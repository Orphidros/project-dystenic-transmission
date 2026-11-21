extends SceneTree
## Headless checks for the session 1 rulings, plus an end-to-end smoke test of the
## prototype scene. Run from the project folder:
##   godot --headless --import            (first time only, to register class names)
##   godot --headless -s tests/run_tests.gd

var _passes := 0
var _fails := 0


func _initialize() -> void:
	_run()


func _run() -> void:
	await process_frame  # Let the tree go live, so added nodes get _ready and can play audio.
	_test_windows()
	_test_node_rules()
	_test_pair_bond()
	_test_beat_state()
	_test_growth_credit()
	await process_frame
	await _smoke_prototype()
	await _test_switch_during_beat_state()
	await _test_handoff_flag_on()
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
	_check(bs.last_grade == RhythmWindows.Grade.MISS and not bs.active, "a half-beat-off press is a Miss and ends Beat-State")
	_check(log.entries.size() == 5, "five judged inputs logged")
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
	_check(not proto.beat_state.active, "a Miss ends Beat-State")
	proto._switch()
	_check(proto.active == proto.ciphera, "the same switch is accepted after a Miss")

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
