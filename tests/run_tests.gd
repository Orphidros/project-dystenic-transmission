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
	await process_frame
	await _smoke_prototype()
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
	print("NodeRules (D-05, D-06)")
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
	_check(int(NodeRules.resolve(RhythmWindows.Grade.POOR, false, false)["bond_delta"]) == 0, "a Poor answer leaves the bond alone (D-14)")


func _test_pair_bond() -> void:
	print("PairBond (D-13, D-14)")
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
	print("BeatState (D-07, D-09 to D-11)")
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
