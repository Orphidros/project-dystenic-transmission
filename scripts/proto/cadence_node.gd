class_name CadenceNode
extends Node3D
## The Tier 1 enviro-puzzle node (O-33, O-43, D-03, D-05, D-06).
## Ciphera reveals it, then Vox answers its Oracle cadence on the beat. The node plays
## the cadence for one bar, and Vox answers the same rhythm in the next bar.
## The worst graded note decides the result (NodeRules).

signal revealed
signal opened(grade: int)
signal cracked(at: Vector3)
signal rejected
signal note_judged(grade: int, offset_ms: float)
signal stress(character: String, amount: float)

enum State { HIDDEN, REVEALED, PLAYING, ANSWERING, RESOLVING, OPEN }

const PATTERN: Array[float] = [0.0, 1.0, 2.5, 3.0]  # beats within one bar
const BEATS_PER_BAR := 4.0

@export var time_critical := false
@export var interact_radius := 1.4

var state: State = State.HIDDEN
var first_fault_used := false
var calibration_ms := 0.0
var music: MusicDirector
var windows: RhythmWindows
var growth_log: GrowthLog
var pair_bond: PairBond

var _mesh: MeshInstance3D
var _mat: StandardMaterial3D
var _player: AudioStreamPlayer
var _start_usec := 0  # when the cadence's beat zero is heard
var _judged: Dictionary = {}  # note index -> grade
var _worst := 0
var _replay_at_usec := -1


func _ready() -> void:
	_mesh = MeshInstance3D.new()
	var bm := BoxMesh.new()
	bm.size = Vector3(0.5, 0.5, 0.2)
	_mesh.mesh = bm
	_mat = StandardMaterial3D.new()
	_mat.albedo_color = Color(0.1, 0.3, 0.35)
	_mat.emission_enabled = true
	_mat.emission = Color(0.3, 0.9, 1.0)
	_mesh.material_override = _mat
	_mesh.visible = false  # One true view: hidden is a viewer state until revealed (O-43).
	add_child(_mesh)


func setup(p_music: MusicDirector, p_windows: RhythmWindows, p_log: GrowthLog, p_bond: PairBond) -> void:
	music = p_music
	windows = p_windows
	growth_log = p_log
	pair_bond = p_bond
	_player = AudioStreamPlayer.new()
	_player.stream = PlaceholderAudio.cadence(music.bpm, PATTERN)
	add_child(_player)


## O-43: a character without the skill sees nothing and gets no prompt.
func can_interact(character: String, at: Vector3) -> bool:
	if absf(at.x - global_position.x) > interact_radius:
		return false
	if character == "Ciphera":
		return state == State.HIDDEN
	if character == "Vox":
		return state == State.REVEALED
	return false


func prompt_for(character: String) -> String:
	if state == State.HIDDEN and character == "Ciphera":
		return "E: reveal (illumination overlay)"
	if state == State.REVEALED and character == "Vox":
		return "E: answer the cadence"
	if state == State.PLAYING:
		return "Listen to the cadence..."
	if state == State.ANSWERING and character == "Vox":
		return "Answer it with E, on the beat"
	return ""


func interact(character: String) -> void:
	if character == "Ciphera" and state == State.HIDDEN:
		state = State.REVEALED
		_mesh.visible = true  # Once revealed, it stays revealed for the band.
		revealed.emit()
	elif character == "Vox" and state == State.REVEALED:
		_play_cadence()


func answer_press(press_usec: int) -> void:
	if state != State.ANSWERING:
		return
	var adj := float(press_usec) - calibration_ms * 1000.0
	var best := -1
	var best_d := INF
	for k in PATTERN.size():
		if _judged.has(k):
			continue
		var d := absf(adj - _note_usec(k))
		if d < best_d:
			best_d = d
			best = k
	if best == -1:
		return
	var offset_ms := (adj - _note_usec(best)) / 1000.0
	_record(best, windows.grade(offset_ms), offset_ms, "node")


## Pulse phase for Ciphera's rig light: it pulses the pattern while the cadence plays,
## then the beat while Vox answers. Returns -1 when the node isn't sounding.
func pulse_phase() -> float:
	if state != State.PLAYING and state != State.ANSWERING:
		return -1.0
	var beats := float(Time.get_ticks_usec() - _start_usec) / _beat_usec()
	if state == State.ANSWERING:
		return fposmod(beats, 1.0)
	var since := INF
	for pb in PATTERN:
		if beats >= pb:
			since = minf(since, beats - pb)
	return since if since < INF else -1.0


func _process(_delta: float) -> void:
	var now := Time.get_ticks_usec()
	if state == State.PLAYING:
		var p := pulse_phase()
		_mat.emission_energy_multiplier = 0.6 + (3.0 * exp(-p * 6.0) if p >= 0.0 else 0.0)
		if now >= _start_usec + BEATS_PER_BAR * _beat_usec() - windows.poor_ms * 1000.0:
			state = State.ANSWERING
	elif state == State.ANSWERING:
		_mat.emission_energy_multiplier = 1.2
		var adj := float(now) - calibration_ms * 1000.0
		for k in PATTERN.size():
			if not _judged.has(k) and adj > _note_usec(k) + windows.poor_ms * 1000.0:
				_record(k, RhythmWindows.Grade.MISS, windows.poor_ms, "node_unanswered")
		if _judged.size() == PATTERN.size():
			_resolve()
	elif state == State.RESOLVING:
		if _replay_at_usec > 0 and now >= _replay_at_usec:
			_replay_at_usec = -1
			_play_cadence()


func _play_cadence() -> void:
	state = State.PLAYING
	_judged.clear()
	_worst = RhythmWindows.Grade.PERFECT
	_start_usec = Time.get_ticks_usec() + music.audio_lead_usec()
	_player.play()


func _record(k: int, g: int, offset_ms: float, context: String) -> void:
	_judged[k] = g
	_worst = maxi(_worst, g)
	growth_log.record(g, offset_ms, calibration_ms, context, "Vox", k)
	note_judged.emit(g, offset_ms)


func _resolve() -> void:
	var r := NodeRules.resolve(_worst, first_fault_used, time_critical)
	first_fault_used = r["first_fault_used"]
	var stress_delta: float = r["stress_delta"]
	if stress_delta > 0.0:
		stress.emit("Vox", stress_delta)
	if r["crack"]:
		cracked.emit(global_position)
	if r["opened"]:
		state = State.OPEN
		_mat.emission = Color(0.4, 1.0, 0.5)
		if int(r["bond_delta"]) > 0:
			pair_bond.record_shared_success("node")
		opened.emit(_worst)
	else:
		state = State.RESOLVING
		_mat.emission_energy_multiplier = 0.3
		rejected.emit()
		_replay_at_usec = Time.get_ticks_usec() + int(2.0 * _beat_usec())  # D-05: the node replays the cadence


func _beat_usec() -> float:
	return music.beat_seconds() * 1_000_000.0


func _note_usec(k: int) -> float:
	return _start_usec + (BEATS_PER_BAR + PATTERN[k]) * _beat_usec()
