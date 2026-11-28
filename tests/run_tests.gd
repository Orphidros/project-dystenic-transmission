extends SceneTree
## Headless checks for the session 1 rulings, plus an end-to-end smoke test of the
## prototype scene. Run from the project folder:
##   godot --headless --import            (first time only, to register class names)
##   godot --headless -s tests/run_tests.gd

## Tests write their growth logs here and delete the folder when the run ends, pass or fail.
const TEST_LOG_DIR := "user://test_logs/"

var _passes := 0
var _fails := 0


func _initialize() -> void:
	_run()


func _run() -> void:
	await process_frame  # Let the tree go live, so added nodes get _ready and can play audio.
	var normal_session := _write_normal_session()
	GrowthLog.folder = TEST_LOG_DIR  # before any test log opens, the prototype scene's included
	_test_windows()
	_test_node_rules()
	_test_pair_bond()
	_test_beat_state()
	_test_miss_rule()
	_test_idle_gap()
	_test_combo_pause()
	_test_pattern_completion()
	_test_new_pattern_first_beat()
	_test_early_downbeat()
	_test_closing_attack()
	_test_switch_up_phase()
	_test_early_end_ends_combo()
	_test_pattern_bars()
	_test_enemy_hits()
	_test_enemy_hit_signals()
	_test_environmental_damage()
	_test_damage_outside_beat_state()
	_test_growth_credit()
	_test_growth_log_sessions()
	await process_frame
	await _smoke_prototype()
	await _test_switch_during_beat_state()
	await _test_handoff_flag_on()
	await _test_airborne_switch_silent()
	await _test_gamepad_bindings()
	for i in 3:
		await process_frame  # let freed nodes close their log files
	_clean_up_test_logs(normal_session)
	print("\n%d passed, %d failed" % [_passes, _fails])
	quit(1 if _fails > 0 else 0)


func _check(ok: bool, what: String) -> void:
	if ok:
		_passes += 1
		print("  ok    ", what)
	else:
		_fails += 1
		print("  FAIL  ", what)


func _test_windows() -> void:
	print("RhythmWindows")
	var w := RhythmWindows.new()
	_check(w.grade(0.0) == RhythmWindows.Grade.PERFECT, "0 ms is Perfect")
	_check(w.grade(-45.0) == RhythmWindows.Grade.PERFECT, "-45 ms is Perfect (symmetric windows)")
	_check(w.grade(45.5) == RhythmWindows.Grade.GOOD, "45.5 ms is Good")
	_check(w.grade(-90.0) == RhythmWindows.Grade.GOOD, "-90 ms is Good")
	_check(w.grade(120.0) == RhythmWindows.Grade.POOR, "120 ms is Poor")
	_check(w.grade(151.0) == RhythmWindows.Grade.MISS, "151 ms is a Miss")


func _test_node_rules() -> void:
	print("NodeRules (CoD-05, CoD-06)")
	var r := NodeRules.resolve(RhythmWindows.Grade.PERFECT, false, false)
	_check(r["opened"] and int(r["bond_delta"]) == 1 and float(r["stress_delta"]) == 0.0, "Perfect opens cleanly and writes the bond")
	r = NodeRules.resolve(RhythmWindows.Grade.POOR, false, false)
	_check(r["opened"] and r["crack"] and float(r["stress_delta"]) == 0.0 and r["first_fault_used"], "first Poor opens, cracks, and is stress-free")
	r = NodeRules.resolve(RhythmWindows.Grade.POOR, true, false)
	_check(r["crack"] and float(r["stress_delta"]) == NodeRules.NODE_POOR_TICK, "a later Poor ticks lightly")
	r = NodeRules.resolve(RhythmWindows.Grade.MISS, false, false)
	_check(r["rejected"] and float(r["stress_delta"]) == 0.0, "first Miss rejects, stress-free")
	r = NodeRules.resolve(RhythmWindows.Grade.MISS, true, false)
	_check(float(r["stress_delta"]) == NodeRules.NODE_MISS_TICK, "a later Miss builds a little more")
	_check(NodeRules.NODE_MISS_TICK < NodeRules.COMBAT_MISS_TICK, "node faults build slower than combat")
	r = NodeRules.resolve(RhythmWindows.Grade.MISS, false, true)
	_check(float(r["stress_delta"]) == NodeRules.COMBAT_MISS_TICK, "time-critical node uses the combat rate")
	_check(int(NodeRules.resolve(RhythmWindows.Grade.POOR, false, false)["bond_delta"]) == 0, "a Poor answer leaves the bond alone (CoD-14)")


func _test_pair_bond() -> void:
	print("PairBond (CoD-13, CoD-14)")
	var b := PairBond.new()
	b.record_shared_success("node")
	b.record_shared_success("handoff")
	_check(b.value == 2, "shared successes raise the bond")
	b.record_micro_choice(false)
	_check(b.value == 0, "the missed-note choice lowers it")
	for i in 3:
		b.record_shared_success("node")
	_check(b.band() == 1, "band 1 at a value of 3")
	b.free()


func _test_beat_state() -> void:
	print("BeatState (CoD-07, CoD-09 to CoD-11)")
	var music := MusicDirector.new()
	root.add_child(music)
	var log := GrowthLog.new()
	root.add_child(log)
	var bond := PairBond.new()
	root.add_child(bond)
	var bs := BeatState.new()
	root.add_child(bs)
	bs.setup(music, log, bond, ["Vox", "Ciphera"])
	var beat := int(music.beat_seconds() * 1_000_000.0)
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	_check(bs.active and bs.chain == 0 and log.entries.is_empty(), "the opening attack enters Beat-State, ungraded")
	var anchor: int = bs._anchor_usec
	bs.on_attack(anchor + beat + 10_000, "Vox", "close")
	_check(bs.last_grade == RhythmWindows.Grade.PERFECT and bs.chain == 1, "+10 ms on beat 1 is Perfect")
	bs.on_attack(anchor + 2 * beat - 70_000, "Vox", "close")
	_check(bs.last_grade == RhythmWindows.Grade.GOOD, "-70 ms on beat 2 is Good")
	bs.calibration_ms = 30.0
	bs.on_attack(anchor + 3 * beat + 30_000, "Vox", "close")
	_check(bs.last_grade == RhythmWindows.Grade.PERFECT and is_equal_approx(bs.last_offset_ms, 0.0), "calibration offset is applied")
	bs.calibration_ms = 0.0
	bs.hand_off("Ciphera")
	bs.on_attack(anchor + 4 * beat, "Ciphera", "close")
	_check(bond.value == 1 and bs.character == "Ciphera", "a Perfect after a handoff writes the bond")
	bs.on_attack(anchor + 5 * beat + beat / 2, "Ciphera", "close")
	_check(bs.last_grade == RhythmWindows.Grade.MISS and bs.active, "a half-beat-off press is a Miss, and one Miss no longer ends Beat-State")
	bs.on_attack(anchor + 6 * beat + beat / 2, "Ciphera", "close")
	_check(bs.last_grade == RhythmWindows.Grade.MISS and not bs.active, "a second Miss in a row ends it")
	_check(log.entries.size() == 6, "six judged inputs logged, both Misses included")
	_check(int(log.credits.get("Vox", 0)) == 3 and int(log.credits.get("Ciphera", 0)) == 1, "growth credits per character")
	for n: Node in [bs, bond, log, music]:
		n.queue_free()


func _smoke_prototype() -> void:
	print("Prototype scene (smoke test)")
	var scene: PackedScene = load("res://scenes/proto/beat_state_proto.tscn")
	var proto := scene.instantiate()
	root.add_child(proto)
	for i in 90:
		await physics_frame
	var node: CadenceNode = proto.node
	_check(proto.vox.is_on_floor(), "Vox lands on the floor (plane-locked body under Jolt)")
	_check(is_zero_approx(proto.vox.global_position.z), "Vox stays on the movement plane")

	proto.vox.global_position.x = node.global_position.x - 0.5
	_check(not node.can_interact("Vox", proto.vox.global_position), "Vox sees nothing before the reveal (O-43)")
	proto._switch()
	_check(proto.active == proto.ciphera, "ground switch to Ciphera")
	proto.ciphera.global_position = Vector3(node.global_position.x - 0.5, proto.vox.global_position.y, 0.0)
	proto._interact(Time.get_ticks_usec())
	_check(node.state == CadenceNode.State.REVEALED, "Ciphera reveals the node")
	for i in 30:
		await physics_frame
	proto._switch()
	proto.vox.global_position.x = node.global_position.x - 0.5
	proto._interact(Time.get_ticks_usec())
	_check(node.state == CadenceNode.State.PLAYING, "Vox starts the cadence")

	# Answer every note dead on time, as a perfect player would.
	var answered := 0
	var deadline := Time.get_ticks_usec() + 8_000_000
	while node.state != CadenceNode.State.OPEN and Time.get_ticks_usec() < deadline:
		await process_frame
		if node.state == CadenceNode.State.ANSWERING and answered < CadenceNode.PATTERN.size():
			var due: float = node._note_usec(answered)
			if Time.get_ticks_usec() >= int(due) - 2000:
				node.answer_press(int(due))
				answered += 1
	_check(node.state == CadenceNode.State.OPEN, "a perfect answer opens the node")
	_check(proto.pair_bond.value == 1, "the node answer writes the pair-bond (shared moment)")
	_check(int(proto.growth_log.credits.get("Vox", 0)) == 4, "four answer notes earn growth credit")
	await physics_frame
	var gate_shape := proto.gate.get_child(0) as CollisionShape3D
	_check(gate_shape.disabled, "the gate opens")

	proto._attack(Time.get_ticks_usec(), "close")
	_check(proto.beat_state.active, "an attack starts Beat-State in the scene")
	for i in 5:
		await process_frame
	proto.queue_free()
	await process_frame


func _test_growth_credit() -> void:
	print("GrowthLog (CoD-01; author, 2026-11-20)")
	var log := GrowthLog.new()
	root.add_child(log)
	var grades: Array[int] = [RhythmWindows.Grade.PERFECT, RhythmWindows.Grade.GOOD, RhythmWindows.Grade.POOR, RhythmWindows.Grade.MISS]
	var offsets: Array[float] = [-12.0, 60.0, -120.0, 200.0]
	for i in grades.size():
		log.record(grades[i], offsets[i], 5.0, "combat", "Vox", i)
	_check(log.entries.size() == 4, "every judged input is recorded, Poor and Miss included")
	var fields: Array[String] = ["grade", "offset_ms", "applied_offset_ms", "context", "character", "chain_index"]
	var complete := true
	for e: Dictionary in log.entries:
		for f in fields:
			complete = complete and e.has(f)
	_check(complete, "each entry has grade, signed offset, offset applied, context, character, chain index")
	_check(float(log.entries[0]["offset_ms"]) < 0.0 and float(log.entries[2]["offset_ms"]) < 0.0, "offsets keep their sign")
	_check(int(log.credits.get("Vox", 0)) == 2, "only Perfect and Good count as growth credit")
	log.queue_free()


## A fresh prototype room with both characters landed on the floor.
func _spawn_proto() -> Node:
	var scene: PackedScene = load("res://scenes/proto/beat_state_proto.tscn")
	var proto := scene.instantiate()
	root.add_child(proto)
	for i in 90:
		await physics_frame
	return proto


func _test_switch_during_beat_state() -> void:
	print("Switching during Beat-State, handoff off (CoD-11; author, 2026-11-20)")
	var proto: Node = await _spawn_proto()
	var beat := int(proto.music.beat_seconds() * 1_000_000.0)
	_check(proto.beat_state_handoff_enabled == false, "beat_state_handoff_enabled defaults to false")

	proto._attack(Time.get_ticks_usec(), "close")
	var event_before: String = proto._event
	proto._switch()
	_check(proto.active == proto.vox and proto.beat_state.active and proto.beat_state.character == "Vox",
		"a switch is refused while Beat-State runs")
	_check(proto._event == event_before, "the refusal is silent")

	var anchor: int = proto.beat_state._anchor_usec
	proto._attack(anchor + beat / 2, "close")  # half a beat off the passage: a Miss
	proto._switch()
	_check(proto.active == proto.vox and proto.beat_state.active, "still refused after one Miss, since Beat-State runs on")
	proto._attack(anchor + beat + beat / 2, "close")  # a second Miss in a row
	_check(not proto.beat_state.active, "two Misses in a row end Beat-State")
	proto._switch()
	_check(proto.active == proto.ciphera, "the same switch is accepted after Beat-State ends on Misses")

	for i in 10:
		await physics_frame  # Ciphera takes over the body physics and lands
	proto._attack(Time.get_ticks_usec(), "close")
	proto._switch()
	_check(proto.active == proto.ciphera and proto.beat_state.active, "refused again in Ciphera's Beat-State")
	var deadline := Time.get_ticks_usec() + int(proto.beat_state.idle_gap_beats * beat) + 500_000
	while proto.beat_state.active and Time.get_ticks_usec() < deadline:
		await process_frame
	_check(not proto.beat_state.active, "an idle gap ends Beat-State")
	proto._switch()
	_check(proto.active == proto.vox, "the same switch is accepted after an idle gap")
	proto.queue_free()
	await process_frame


func _test_handoff_flag_on() -> void:
	print("Switching during Beat-State, handoff on (CoD-11 kept behind the flag)")
	var proto: Node = await _spawn_proto()
	var beat := int(proto.music.beat_seconds() * 1_000_000.0)
	proto.beat_state_handoff_enabled = true
	proto._attack(Time.get_ticks_usec(), "close")
	proto._switch()
	_check(proto.active == proto.ciphera and proto.beat_state.active and proto.beat_state.character == "Ciphera",
		"with the flag on, the passage hands off and Beat-State continues")
	var anchor: int = proto.beat_state._anchor_usec
	proto._attack(anchor + beat, "close")
	_check(proto.beat_state.last_grade == RhythmWindows.Grade.PERFECT and proto.beat_state.chain == 1,
		"the chain continues on the incoming member's passage")
	_check(proto.pair_bond.value == 1, "a Perfect after the handoff writes the pair-bond (CoD-13)")
	proto.queue_free()
	await process_frame


## A Beat-State with its own music, log and bond, outside any scene, for timing tests.
func _make_beat_state() -> BeatState:
	var music := MusicDirector.new()
	root.add_child(music)
	var log := GrowthLog.new()
	root.add_child(log)
	var bond := PairBond.new()
	root.add_child(bond)
	var bs := BeatState.new()
	root.add_child(bs)
	bs.setup(music, log, bond, ["Vox", "Ciphera"])
	return bs


func _free_beat_state(bs: BeatState) -> void:
	for n: Node in [bs, bs.music, bs.growth_log, bs.pair_bond]:
		n.queue_free()


func _test_miss_rule() -> void:
	print("Beat-State miss rule (CoD-07, amended 2026-11-21)")
	var bs := _make_beat_state()
	var beat := int(bs.music.beat_seconds() * 1_000_000.0)
	var reasons: Array[String] = []
	bs.exited.connect(func(r: String) -> void: reasons.append(r))

	# The author's first example: Start, Good, Miss, Poor, Miss, Good, Miss.
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	var a: int = bs._anchor_usec
	var seq: Array = [
		[a + beat + 70_000, RhythmWindows.Grade.GOOD],
		[a + beat + beat / 2, RhythmWindows.Grade.MISS],
		[a + 2 * beat + 120_000, RhythmWindows.Grade.POOR],
		[a + 2 * beat + beat / 2, RhythmWindows.Grade.MISS],
		[a + 3 * beat - 70_000, RhythmWindows.Grade.GOOD],
		[a + 3 * beat + beat / 2, RhythmWindows.Grade.MISS],
	]
	var grades_ok := true
	var ran_until_last := true
	for i in seq.size():
		bs.on_attack(seq[i][0], "Vox", "close")
		grades_ok = grades_ok and bs.last_grade == seq[i][1]
		if i < seq.size() - 1:
			ran_until_last = ran_until_last and bs.active
	_check(grades_ok, "the first example grades Good, Miss, Poor, Miss, Good, Miss")
	_check(ran_until_last, "Beat-State runs through the first two Misses")
	_check(not bs.active and reasons == ["third_miss"], "the third Miss in total ends it (\"third_miss\")")

	# The author's second example: Start, Good, Miss, Miss.
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	a = bs._anchor_usec
	bs.on_attack(a + beat + 70_000, "Vox", "close")
	bs.on_attack(a + beat + beat / 2, "Vox", "close")
	var after_one_miss := bs.active
	bs.on_attack(a + 2 * beat + beat / 2, "Vox", "close")
	_check(after_one_miss and not bs.active and reasons.back() == "two_in_a_row", "two Misses in a row end it (\"two_in_a_row\")")
	_check(bs.misses_total == 2, "the Miss total counts only within this Beat-State")
	_free_beat_state(bs)


func _test_idle_gap() -> void:
	print("Beat-State idle gap (CoD-07; OQ-A09)")
	var bs := _make_beat_state()
	var beat := int(bs.music.beat_seconds() * 1_000_000.0)
	var reasons: Array[String] = []
	bs.exited.connect(func(r: String) -> void: reasons.append(r))
	_check(is_equal_approx(bs.idle_gap_beats, 3.0), "the idle gap defaults to 3 beats")
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	bs._last_input_usec = Time.get_ticks_usec() - int(2.9 * beat)
	bs._process(0.0)
	_check(bs.active, "2.9 beats without input keeps Beat-State running")
	bs._last_input_usec = Time.get_ticks_usec() - int(3.1 * beat)
	bs._process(0.0)
	_check(not bs.active and reasons == ["idle"], "3.1 beats without input ends it (\"idle\")")
	_free_beat_state(bs)


func _test_growth_log_sessions() -> void:
	print("Growth log, one file per session (build call, 2026-11-21)")
	var first := GrowthLog.new()
	root.add_child(first)
	first.record(RhythmWindows.Grade.PERFECT, 5.0, 0.0, "combat", "Vox", 1)
	var second := GrowthLog.new()
	root.add_child(second)
	second.record(RhythmWindows.Grade.MISS, 200.0, 0.0, "combat", "Vox", 0)
	_check(first.path != second.path and FileAccess.file_exists(first.path) and FileAccess.file_exists(second.path),
		"two sessions write two files")
	_check(first.path.begins_with(TEST_LOG_DIR.path_join("growth_log_")) and first.path.ends_with(".jsonl"),
		"files are named growth_log_<date>_<time>.jsonl, in the test folder during tests")
	var lines := FileAccess.get_file_as_string(first.path).strip_edges().split("\n")
	var header: Variant = JSON.parse_string(lines[0])
	var entry: Variant = JSON.parse_string(lines[1]) if lines.size() > 1 else null
	_check(lines.size() == 2 and header is Dictionary and header.has("session_start") and str(header.get("godot_version", "")).begins_with("4.7"),
		"the first file is intact: a session header with start time and Godot version, then its entry")
	_check(entry is Dictionary and entry["grade"] == "Perfect" and entry.has("chain_index"), "the entry schema is unchanged")
	first.queue_free()
	second.queue_free()


func _test_airborne_switch_silent() -> void:
	print("Airborne switch refused silently (Supplement 1, System 4)")
	var proto: Node = await _spawn_proto()
	proto.vox.global_position.y = 4.0
	for i in 2:
		await physics_frame
	var event_before: String = proto._event
	var airborne: bool = not proto.vox.is_on_floor()
	proto._switch()
	_check(airborne and proto.active == proto.vox, "a switch in the air is refused")
	_check(proto._event == event_before, "the refusal leaves the event text unchanged")
	proto.queue_free()
	await process_frame


func _test_gamepad_bindings() -> void:
	print("Provisional gamepad bindings (O-01)")
	load("res://scripts/proto/beat_state_proto.gd").ensure_actions()
	var buttons := {
		"dt_left": JOY_BUTTON_DPAD_LEFT, "dt_right": JOY_BUTTON_DPAD_RIGHT, "dt_jump": JOY_BUTTON_A,
		"dt_attack_close": JOY_BUTTON_X, "dt_attack_mid": JOY_BUTTON_Y, "dt_interact": JOY_BUTTON_B,
		"dt_switch": JOY_BUTTON_RIGHT_SHOULDER, "dt_calib_up": JOY_BUTTON_DPAD_UP,
		"dt_calib_down": JOY_BUTTON_DPAD_DOWN, "dt_debug": JOY_BUTTON_BACK,
	}
	for action: String in buttons:
		var found := false
		for ev in InputMap.action_get_events(action):
			found = found or (ev is InputEventJoypadButton and ev.button_index == buttons[action])
		_check(found, "%s has its gamepad button" % action)
	var axes := {"dt_left": -1.0, "dt_right": 1.0}
	for action: String in axes:
		var found := false
		for ev in InputMap.action_get_events(action):
			found = found or (ev is InputEventJoypadMotion and ev.axis == JOY_AXIS_LEFT_X and signf(ev.axis_value) == axes[action])
		_check(found and is_equal_approx(InputMap.action_get_deadzone(action), 0.3), "%s has the left stick with a 0.3 deadzone" % action)
	var keys := {
		"dt_left": [KEY_A, KEY_LEFT], "dt_right": [KEY_D, KEY_RIGHT], "dt_jump": [KEY_SPACE, KEY_W],
		"dt_attack_close": [KEY_J], "dt_attack_mid": [KEY_K], "dt_interact": [KEY_E], "dt_switch": [KEY_TAB],
		"dt_calib_down": [KEY_BRACKETLEFT], "dt_calib_up": [KEY_BRACKETRIGHT], "dt_debug": [KEY_F3],
	}
	var kept := true
	for action: String in keys:
		for k: int in keys[action]:
			var has_key := false
			for ev in InputMap.action_get_events(action):
				has_key = has_key or (ev is InputEventKey and ev.physical_keycode == k)
			kept = kept and has_key
	_check(kept, "every keyboard key is kept")


# --- Patterns, the combo pause and damage (CoD-07, amended 2026-11-21) ----------------------

## Moves the anchor so that "now" sits `beats` after it, as if Beat-State had been running that
## long. Target times move with it, so presses are timed from the returned anchor afterwards.
## The idle gap is kept out of it.
func _shift_to(bs: BeatState, beats: float) -> int:
	var now := Time.get_ticks_usec()
	bs._anchor_usec = now - int(beats * bs._beat_usec())
	bs._last_input_usec = now
	return bs._anchor_usec


## Opens Beat-State on the close passage and plays beats 1 to `last` dead on time, on `p_tier`.
func _play_through(bs: BeatState, last: int, p_tier: String = "close") -> int:
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	var a: int = bs._anchor_usec
	var beat := int(bs._beat_usec())
	for i in range(1, last + 1):
		bs.on_attack(a + i * beat, "Vox", p_tier)
	return a


func _test_combo_pause() -> void:
	print("The combo pauses on a Miss (CoD-07, amended 2026-11-21)")
	var bs := _make_beat_state()
	var beat := int(bs._beat_usec())
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	var a: int = bs._anchor_usec
	bs.on_attack(a + beat, "Vox", "close")  # Perfect, chain 1
	bs.on_attack(a + 2 * beat + 70_000, "Vox", "close")  # Good, chain 2
	bs.on_attack(a + 2 * beat + beat / 2, "Vox", "close")  # Miss
	var after_miss := bs.chain
	bs.on_attack(a + 3 * beat + 120_000, "Vox", "close")  # Poor
	_check(bs.active and after_miss == 2 and bs.chain == 3, "after a Miss the chain keeps its value, and the next Poor adds one")
	_free_beat_state(bs)


func _test_pattern_completion() -> void:
	print("Completing a pattern")
	var bs := _make_beat_state()
	var completions: Array = []
	bs.pattern_completed.connect(func(n: int, c: int, t: String) -> void: completions.append([n, c, t]))
	var a := _play_through(bs, 14)
	bs.on_attack(a + 15 * int(bs._beat_usec()) + 200_000, "Vox", "close")  # a Miss late in pattern 1
	a = _shift_to(bs, 16.05)
	bs._process(0.0)
	_check(completions == [[1, 14, "close"]], "pattern_completed fires once, with the chain carried over (14)")
	_check(bs.active and bs.chain == 14 and bs.misses_in_a_row == 0 and bs.misses_total == 0, "the chain carries over and the miss counts reset")
	bs.on_attack(a + 16 * int(bs._beat_usec()) + 200_000, "Vox", "close")  # a Miss early in pattern 2
	_check(bs.active and bs.last_grade == RhythmWindows.Grade.MISS, "a Miss late in one pattern and another early in the next don't end Beat-State")
	bs._last_input_usec = Time.get_ticks_usec()
	bs._process(0.0)
	_check(completions.size() == 1, "and the pattern completes only once")
	_free_beat_state(bs)


func _test_new_pattern_first_beat() -> void:
	print("The new pattern's first beat")
	var bs := _make_beat_state()
	var entries := [0]
	bs.entered.connect(func(_c: String, _t: String) -> void: entries[0] += 1)
	_play_through(bs, 15)
	var a := _shift_to(bs, 16.05)
	bs._process(0.0)
	_check(bs.pattern_number == 2 and bs._anchor_usec == a, "completing the pattern doesn't move the anchor")
	bs.on_attack(a + 16 * int(bs._beat_usec()) + 10_000, "Vox", "close")
	_check(bs.last_grade == RhythmWindows.Grade.PERFECT and bs.chain == 16 and entries[0] == 1 and bs._anchor_usec == a,
		"the new pattern's first beat is graded (Perfect, chain 16), not taken as an opening attack")
	_free_beat_state(bs)


func _test_early_downbeat() -> void:
	print("Playing the next pattern's downbeat a little early")
	var bs := _make_beat_state()
	var completions: Array = []
	bs.pattern_completed.connect(func(n: int, c: int, t: String) -> void: completions.append([n, c, t]))
	var a := _play_through(bs, 15)
	bs.on_attack(a + 16 * int(bs._beat_usec()) - 60_000, "Vox", "mid")  # 60 ms early, on the other tier
	_check(completions == [[1, 15, "close"]], "the old pattern completes first, with the chain at 15")
	_check(bs.pattern_number == 2 and bs.tier == "close", "the early press doesn't change the passage picked (close again)")
	_check(bs.last_grade == RhythmWindows.Grade.GOOD and bs.chain == 16, "the press is graded on the new pattern's downbeat")
	_free_beat_state(bs)


func _test_closing_attack() -> void:
	print("The closing attack picks the next pattern")
	var same := _make_beat_state()
	_play_through(same, 15)
	var player_before: AudioStreamPlayer = same._current_player
	_shift_to(same, 16.05)
	same._process(0.0)
	_check(same.tier == "close" and same._current_player == player_before, "a closing attack on the same tier keeps the passage")
	_free_beat_state(same)

	var up := _make_beat_state()
	var completions: Array = []
	up.pattern_completed.connect(func(n: int, c: int, t: String) -> void: completions.append([n, c, t]))
	var a := _play_through(up, 14)
	up.on_attack(a + 15 * int(up._beat_usec()), "Vox", "mid")  # the closing attack, on mid
	a = _shift_to(up, 16.05)
	up._process(0.0)
	_check(completions == [[1, 15, "mid"]] and up.tier == "mid", "on the other tier it switches up to the mid passage")
	up.on_attack(a + int(17.5 * up._beat_usec()), "Vox", "mid")
	_check(up.last_grade == RhythmWindows.Grade.PERFECT, "after close to mid, a press on beat 1.5 of a bar grades Perfect")
	_free_beat_state(up)


func _test_switch_up_phase() -> void:
	print("A Switch-up lands on the bar line")
	var bs := _make_beat_state()
	var a := _play_through(bs, 14)
	bs.on_attack(a + 15 * int(bs._beat_usec()), "Vox", "mid")
	# Place "now" so that a passage started now is heard 30 ms before the bar line. The audio lead
	# (next mix plus output latency) is measured first: headless runs mix in uneven chunks.
	var lead_now: int = bs.music.audio_lead_usec()
	a = _shift_to(bs, 16.0 - float(lead_now + 30_000) / bs._beat_usec())
	bs._process(0.0)
	var start: Dictionary = bs.last_passage_start
	var bar_line := a + 16 * bs._beat_usec()
	var loop_usec := 4.0 * bs._beat_usec()
	var from_usec := float(start.get("from_s", 0.0)) * 1_000_000.0
	var heard_start := float(start.get("usec", 0)) + float(start.get("lead_usec", 0))
	# The passage's nearest downbeat as heard: behind the start if it began just past one, else ahead.
	var heard_downbeat := heard_start - from_usec if from_usec < loop_usec / 2.0 else heard_start + loop_usec - from_usec
	_check(start.get("tier", "") == "mid" and bs.pattern_number == 1 and heard_start < bar_line,
		"the mid passage starts ahead, before the bar line and before the pattern completes")
	_check(absf(heard_downbeat - bar_line) < 1.0, "its downbeat is heard exactly on the bar line (%.3f us off)" % absf(heard_downbeat - bar_line))
	_shift_to(bs, 16.05)
	bs._process(0.0)
	_check(bs.pattern_number == 2 and bs.last_passage_start == start, "completing the pattern doesn't restart it")
	_free_beat_state(bs)


func _test_early_end_ends_combo() -> void:
	print("An early end ends the combo")
	var bs := _make_beat_state()
	var a := _play_through(bs, 3)
	var beat := int(bs._beat_usec())
	bs.on_attack(a + 3 * beat + beat / 2, "Vox", "close")
	bs.on_attack(a + 4 * beat + beat / 2, "Vox", "close")
	_check(not bs.active, "two Misses in a row end the pattern early")
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	_check(bs.active and bs.chain == 0 and bs.pattern_number == 1, "the next opening attack starts the combo from 0")
	_free_beat_state(bs)


func _test_pattern_bars() -> void:
	print("pattern_bars moves the bar line")
	var bs := _make_beat_state()
	var completions: Array = []
	bs.pattern_completed.connect(func(n: int, c: int, t: String) -> void: completions.append(n))
	bs.pattern_bars = 2
	_play_through(bs, 7)
	_shift_to(bs, 7.9)
	bs._process(0.0)
	var before_line := completions.size()
	_shift_to(bs, 8.05)
	bs._process(0.0)
	_check(before_line == 0 and completions == [1] and bs.pattern_number == 2, "with 2 bars, the pattern completes at 8 beats")
	_free_beat_state(bs)


func _test_enemy_hits() -> void:
	print("An enemy hit is a Miss (CoD-07, amended 2026-11-21)")
	var bs := _make_beat_state()
	var beat := int(bs._beat_usec())
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	var a: int = bs._anchor_usec
	bs.on_attack(a + beat, "Vox", "close")
	bs.on_enemy_hit("strike")
	_check(bs.active and bs.chain == 1 and bs.misses_in_a_row == 1, "after one hit, Beat-State carries on and the chain holds")
	_free_beat_state(bs)

	var reasons: Array[String] = []
	bs = _make_beat_state()
	bs.exited.connect(func(r: String) -> void: reasons.append(r))
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	a = bs._anchor_usec
	bs.on_enemy_hit()
	bs.on_attack(a + beat + beat / 2, "Vox", "close")  # a timing Miss
	_check(reasons == ["two_in_a_row"], "a hit, then a timing Miss, gives two_in_a_row")
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	bs.on_enemy_hit()
	bs.on_enemy_hit()
	_check(reasons == ["two_in_a_row", "two_in_a_row"], "hit, hit gives two_in_a_row")
	_free_beat_state(bs)

	for third: String in ["timing", "hit"]:
		var r: Array[String] = []
		var b := _make_beat_state()
		b.exited.connect(func(x: String) -> void: r.append(x))
		b.on_attack(Time.get_ticks_usec(), "Vox", "close")
		var an: int = b._anchor_usec
		b.on_enemy_hit()
		b.on_attack(an + beat + 70_000, "Vox", "close")  # Good
		b.on_enemy_hit()
		var carried_on := b.active
		if third == "timing":
			b.on_attack(an + 2 * beat - 70_000, "Vox", "close")  # Good, between the Misses
			b.on_attack(an + 2 * beat + beat / 2, "Vox", "close")  # a timing Miss
		else:
			b.on_attack(an + 2 * beat - 70_000, "Vox", "close")
			b.on_enemy_hit()
		_check(carried_on and r == ["third_miss"], "hit, Good, hit carries on, and a third Miss (%s) gives third_miss" % third)
		_free_beat_state(b)


func _test_enemy_hit_signals() -> void:
	print("What an enemy hit emits")
	var bs := _make_beat_state()
	var hits: Array[String] = []
	var judged := [0]
	bs.enemy_hit_taken.connect(func(t: String) -> void: hits.append(t))
	bs.judged.connect(func(_g: int, _o: float, _c: int, _ch: String) -> void: judged[0] += 1)
	bs.on_attack(Time.get_ticks_usec(), "Vox", "close")
	var idle_from: int = bs._last_input_usec
	bs.on_enemy_hit("blade")
	_check(hits == ["blade"] and judged[0] == 0, "a hit emits enemy_hit_taken with its type, and no judged")
	_check(bs.growth_log.entries.is_empty() and bs._last_input_usec == idle_from, "it writes nothing to the growth log and doesn't reset the idle gap")
	_free_beat_state(bs)


func _test_environmental_damage() -> void:
	print("Environmental damage ends the pattern")
	var bs := _make_beat_state()
	var reasons: Array[String] = []
	bs.exited.connect(func(r: String) -> void: reasons.append(r))
	_play_through(bs, 2)
	var misses_before := bs.misses_total
	bs.on_environmental_damage()
	_check(misses_before == 0 and not bs.active and reasons == ["environment"], "at once, with no Misses before it (\"environment\")")
	_free_beat_state(bs)


func _test_damage_outside_beat_state() -> void:
	print("Damage outside Beat-State")
	var bs := _make_beat_state()
	var signals := [0]
	bs.enemy_hit_taken.connect(func(_t: String) -> void: signals[0] += 1)
	bs.exited.connect(func(_r: String) -> void: signals[0] += 1)
	bs.on_enemy_hit("strike")
	bs.on_environmental_damage()
	_check(not bs.active and signals[0] == 0 and bs.misses_total == 0, "a hit or environmental damage outside Beat-State changes nothing")
	_free_beat_state(bs)


# --- Test logs ----------------------------------------------------------------------------

## A normal play session's log, written to the normal folder before the tests start, so the
## clean-up can be checked against it. Returns [path, contents].
func _write_normal_session() -> Array:
	var g := GrowthLog.new()
	root.add_child(g)
	g.record(RhythmWindows.Grade.GOOD, 30.0, 0.0, "combat", "Vox", 1)
	var path := g.path
	g.free()  # closes its file
	return [path, FileAccess.get_file_as_string(path)]


func _clean_up_test_logs(normal_session: Array) -> void:
	print("Test logs")
	var dir := DirAccess.open(TEST_LOG_DIR)
	if dir:
		for f in dir.get_files():
			dir.remove(f)
	DirAccess.remove_absolute(TEST_LOG_DIR)
	GrowthLog.folder = "user://"
	_check(not DirAccess.dir_exists_absolute(TEST_LOG_DIR), "the test-log folder is gone after the run")
	var path: String = normal_session[0]
	_check(FileAccess.file_exists(path) and FileAccess.get_file_as_string(path) == normal_session[1], "a normal session's file is untouched")
	DirAccess.remove_absolute(path)  # that file was the tests' own stand-in for a play session
