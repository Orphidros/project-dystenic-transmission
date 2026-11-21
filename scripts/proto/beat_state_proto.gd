extends Node3D
## Tier 1 prototype room: Beat-State combat, the cadence node and Ciphera's rig light.
## It implements the session 1 rulings in design/decisions/2026-11-05_design-gap-session-1.md.
## Everything is a placeholder: shapes, sounds and numbers. Run it to feel the timing.
##
## Controls: A/D or arrows to move, Space to jump, J close attack, K mid attack,
## E interact, Tab switch (ground only), [ and ] calibration, F3 debug values.

const ACTIONS: Dictionary = {
	"dt_left": [KEY_A, KEY_LEFT],
	"dt_right": [KEY_D, KEY_RIGHT],
	"dt_jump": [KEY_SPACE, KEY_W],
	"dt_attack_close": [KEY_J],
	"dt_attack_mid": [KEY_K],
	"dt_interact": [KEY_E],
	"dt_switch": [KEY_TAB],
	"dt_calib_down": [KEY_BRACKETLEFT],
	"dt_calib_up": [KEY_BRACKETRIGHT],
	"dt_debug": [KEY_F3],
}
## CoD-11, the Beat-State passage handoff on a switch, is Tier 1.5. Its code stays, but only
## runs when this is on. Off (Tier 1): a switch request while Beat-State runs is refused
## silently, and the same request is accepted once Beat-State ends on a Miss or an idle gap
## (author, 2026-11-20).
@export var beat_state_handoff_enabled := false

const COMBAT_MISS_STRESS := 6.0  # O-07: stress rises on a Miss.
const CHAIN_RELIEF_FROM := 5  # O-07: and falls on sustained chains.
const ENEMY_HEARING_M := 10.0

var music: MusicDirector
var growth_log: GrowthLog
var pair_bond: PairBond
var beat_state: BeatState
var vox: ProtoCharacter
var ciphera: ProtoCharacter
var active: ProtoCharacter
var node: CadenceNode
var rig_light: RigLight
var camera: Camera3D
var gate: StaticBody3D
var enemy: Node3D
var calibration_ms := 0.0
var show_debug := false

var _hud: Label
var _enemy_mat: StandardMaterial3D
var _hit_players: Array[AudioStreamPlayer] = []
var _crack_player: AudioStreamPlayer
var _event := "Approach the far wall. Only Ciphera can see what's there."


## The Phase 1 input map normally lives in project.godot; the prototype registers its own.
static func ensure_actions() -> void:
	for a: String in ACTIONS:
		if InputMap.has_action(a):
			continue
		InputMap.add_action(a)
		for k: int in ACTIONS[a]:
			var ev := InputEventKey.new()
			ev.physical_keycode = k
			InputMap.action_add_event(a, ev)


func _ready() -> void:
	ensure_actions()
	_build_world()
	music = MusicDirector.new()
	music.name = "Music"
	add_child(music)
	growth_log = GrowthLog.new()
	add_child(growth_log)
	pair_bond = PairBond.new()
	add_child(pair_bond)
	beat_state = BeatState.new()
	add_child(beat_state)
	beat_state.setup(music, growth_log, pair_bond, ["Vox", "Ciphera"])
	beat_state.judged.connect(_on_judged)
	beat_state.entered.connect(func(who: String, tier: String) -> void: _set_event("%s enters Rhythmic Focus (%s passage)" % [who, tier]))
	beat_state.exited.connect(func(reason: String) -> void: _set_event("Beat-State ends: %s" % reason))
	_build_characters()
	_build_node()
	for g in 4:
		_hit_players.append(_player(PlaceholderAudio.hit(g)))
	_crack_player = _player(PlaceholderAudio.crack())
	_build_hud()


func _input(event: InputEvent) -> void:
	if event.is_echo():
		return
	# Stamp first: InputEvents carry no timestamp in 4.7.1 (round 2), so this is frame-start time.
	var t := Time.get_ticks_usec()
	if event.is_action_pressed("dt_attack_close"):
		_attack(t, "close")
	elif event.is_action_pressed("dt_attack_mid"):
		_attack(t, "mid")
	elif event.is_action_pressed("dt_interact"):
		_interact(t)
	elif event.is_action_pressed("dt_switch"):
		_switch()
	elif event.is_action_pressed("dt_calib_down"):
		_set_calibration(calibration_ms - 5.0)
	elif event.is_action_pressed("dt_calib_up"):
		_set_calibration(calibration_ms + 5.0)
	elif event.is_action_pressed("dt_debug"):
		show_debug = not show_debug


func _process(delta: float) -> void:
	var target := active.global_position + Vector3(0.0, 1.6, 12.0)
	camera.position = camera.position.lerp(target, clampf(delta * 3.0, 0.0, 1.0))
	_update_hud()


# --- Actions ---------------------------------------------------------------

func _attack(t: int, tier: String) -> void:
	beat_state.calibration_ms = calibration_ms
	beat_state.on_attack(t, active.display_name, tier)


func _interact(t: int) -> void:
	if node.state == CadenceNode.State.ANSWERING:
		if active == vox:
			node.answer_press(t)
		return
	if node.can_interact(active.display_name, active.global_position):
		node.interact(active.display_name)


func _switch() -> void:
	if not active.is_on_floor():
		_set_event("Switching is ground-only")
		return
	if beat_state.active and not beat_state_handoff_enabled:
		return  # Refused silently until Beat-State ends (author, 2026-11-20).
	var next := ciphera if active == vox else vox
	_set_active(next)
	if beat_state.active:  # Reached only with the CoD-11 handoff enabled.
		beat_state.hand_off(next.display_name)
		_set_event("Handoff to %s at the same phase" % next.display_name)


func _set_active(c: ProtoCharacter) -> void:
	var other := ciphera if c == vox else vox
	active = c
	c.active = true
	c.follow_target = null
	other.active = false
	other.follow_target = c


func _set_calibration(ms: float) -> void:
	calibration_ms = ms
	beat_state.calibration_ms = ms
	node.calibration_ms = ms


# --- Signals ----------------------------------------------------------------

func _on_judged(grade: int, offset_ms: float, chain: int, character: String) -> void:
	_hit_players[grade].play()
	var who := vox if character == "Vox" else ciphera
	if grade == RhythmWindows.Grade.MISS:
		who.add_stress(COMBAT_MISS_STRESS)
	elif chain >= CHAIN_RELIEF_FROM and RhythmWindows.is_credit(grade):
		who.add_stress(-1.0)
	_set_event("%s %+.0f ms, chain %d" % [RhythmWindows.grade_name(grade), offset_ms, chain])


func _on_node_note(grade: int, offset_ms: float) -> void:
	_hit_players[grade].play()
	_set_event("Answer note: %s %+.0f ms" % [RhythmWindows.grade_name(grade), offset_ms])


func _on_node_opened(grade: int) -> void:
	var shape := gate.get_child(0) as CollisionShape3D
	shape.set_deferred("disabled", true)
	gate.visible = false
	_set_event("The node opens (%s). The way is clear." % RhythmWindows.grade_name(grade))


func _on_node_cracked(at: Vector3) -> void:
	_crack_player.play()
	if enemy.global_position.distance_to(at) <= ENEMY_HEARING_M:
		_enemy_mat.albedo_color = Color(0.9, 0.15, 0.1)
		_set_event("Vox's voice cracks, and the bot beyond the gate hears it")


func _set_event(text: String) -> void:
	_event = text


# --- Building the room ------------------------------------------------------

func _build_world() -> void:
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.03, 0.035, 0.05)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.25, 0.27, 0.32)
	env.ambient_light_energy = 0.6
	var we := WorldEnvironment.new()
	we.environment = env
	add_child(we)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50.0, 30.0, 0.0)
	sun.light_energy = 0.4
	add_child(sun)

	_box(Vector3(30.0, 1.0, 4.0), Vector3(3.0, -0.5, 0.0), Color(0.22, 0.22, 0.24))  # floor
	_box(Vector3(1.0, 8.0, 4.0), Vector3(-12.0, 4.0, 0.0), Color(0.18, 0.18, 0.2))  # left wall
	_box(Vector3(1.0, 8.0, 4.0), Vector3(18.0, 4.0, 0.0), Color(0.18, 0.18, 0.2))  # right wall
	_box(Vector3(3.0, 0.4, 4.0), Vector3(-6.0, 1.6, 0.0), Color(0.3, 0.28, 0.25))  # ledge
	_box(Vector3(30.0, 8.0, 0.5), Vector3(3.0, 4.0, -2.2), Color(0.12, 0.12, 0.14), false)  # background, not walkable
	gate = _box(Vector3(0.6, 3.0, 4.0), Vector3(9.0, 1.5, 0.0), Color(0.35, 0.12, 0.1)) as StaticBody3D
	enemy = _box(Vector3(0.9, 1.6, 0.9), Vector3(12.5, 0.8, 0.0), Color(0.45, 0.45, 0.5), false)
	_enemy_mat = (enemy.get_child(0) as MeshInstance3D).material_override as StandardMaterial3D

	camera = Camera3D.new()
	camera.fov = 45.0
	camera.position = Vector3(0.0, 2.5, 12.0)
	add_child(camera)
	camera.current = true


func _build_characters() -> void:
	vox = ProtoCharacter.new()
	vox.name = "Vox"
	vox.display_name = "Vox"
	vox.body_color = Color(0.75, 0.32, 0.3)
	vox.tell_color = Color(1.0, 0.45, 0.15)
	vox.position = Vector3(-2.0, 0.5, 0.0)
	add_child(vox)
	ciphera = ProtoCharacter.new()
	ciphera.name = "Ciphera"
	ciphera.display_name = "Ciphera"
	ciphera.body_color = Color(0.32, 0.45, 0.8)
	ciphera.tell_color = Color(0.4, 1.0, 0.9)
	ciphera.position = Vector3(-3.2, 0.5, 0.0)
	add_child(ciphera)
	rig_light = RigLight.new()
	rig_light.bond = pair_bond
	rig_light.phase_source = _rig_phase
	ciphera.add_child(rig_light)
	_set_active(vox)


func _build_node() -> void:
	node = CadenceNode.new()
	node.name = "CadenceNode"
	node.position = Vector3(8.4, 1.3, 0.0)
	add_child(node)
	node.setup(music, beat_state.windows, growth_log, pair_bond)
	node.revealed.connect(func() -> void: _set_event("Ciphera's overlay reveals a hidden node. Vox's voice can open it."))
	node.rejected.connect(func() -> void: _set_event("The node rejects the answer and replays the cadence"))
	node.note_judged.connect(_on_node_note)
	node.opened.connect(_on_node_opened)
	node.cracked.connect(_on_node_cracked)
	node.stress.connect(func(who: String, amount: float) -> void: (vox if who == "Vox" else ciphera).add_stress(amount))


func _build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	_hud = Label.new()
	_hud.position = Vector2(16.0, 12.0)
	_hud.add_theme_font_size_override("font_size", 16)
	layer.add_child(_hud)


func _update_hud() -> void:
	var lines: PackedStringArray = []
	lines.append("Active: %s    (Tab: switch, ground only)" % active.display_name)
	if beat_state.active:
		var perks := ""
		if beat_state.chain >= 3:
			perks += "  [stamina saver]"
		if beat_state.chain >= 5:
			perks += "  [damage boost]"
		lines.append("Beat-State: ON (%s passage)   chain %d%s" % [beat_state.tier, beat_state.chain, perks])
	else:
		lines.append("Beat-State: off   (J or K to attack; the first attack starts the passage)")
	if beat_state.last_grade >= 0:
		lines.append("Last hit: %s %+.0f ms" % [RhythmWindows.grade_name(beat_state.last_grade), beat_state.last_offset_ms])
	var prompt := ""
	if node.can_interact(active.display_name, active.global_position) or node.state == CadenceNode.State.PLAYING or node.state == CadenceNode.State.ANSWERING:
		prompt = node.prompt_for(active.display_name)
	if prompt != "":
		lines.append(">> " + prompt)
	lines.append("Calibration: %+.0f ms  ([ / ])" % calibration_ms)
	lines.append(_event)
	lines.append("A/D move   Space jump   J close   K mid   E interact   F3 debug")
	if show_debug:
		lines.append("--- debug (hidden values) ---")
		lines.append("Stress  Vox %.1f   Ciphera %.1f" % [vox.stress, ciphera.stress])
		lines.append("Pair-bond %d (band %d)   growth credits %s" % [pair_bond.value, pair_bond.band(), str(growth_log.credits)])
		lines.append("Audio lead %.1f ms   output latency %.1f ms   node: %s" % [
			music.audio_lead_usec() / 1000.0, music.output_latency_s * 1000.0, CadenceNode.State.keys()[node.state]])
	_hud.text = "\n".join(lines)


func _rig_phase() -> float:
	var p := node.pulse_phase()
	if p >= 0.0:
		return p
	if beat_state.active:
		return beat_state.beat_phase()
	return fposmod(music.track_time() / music.beat_seconds(), 1.0)


func _box(size: Vector3, pos: Vector3, color: Color, collide: bool = true) -> Node3D:
	var root: Node3D
	if collide:
		var body := StaticBody3D.new()
		var cs := CollisionShape3D.new()
		var bs := BoxShape3D.new()
		bs.size = size
		cs.shape = bs
		body.add_child(cs)
		root = body
	else:
		root = Node3D.new()
	var mi := MeshInstance3D.new()
	var bm := BoxMesh.new()
	bm.size = size
	mi.mesh = bm
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	mi.material_override = m
	root.add_child(mi)  # child 0 is the collision shape on bodies, the mesh otherwise
	root.position = pos
	add_child(root)
	return root


func _player(stream: AudioStream) -> AudioStreamPlayer:
	var p := AudioStreamPlayer.new()
	p.stream = stream
	add_child(p)
	return p
