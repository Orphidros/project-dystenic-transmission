class_name BeatState
extends Node
## Beat-State, or Rhythmic Focus (CoD-07, CoD-09 to CoD-11).
## The first attack of a single-character chain is an ungraded anchor. It starts that
## character's instrument passage instantly, and later inputs are graded against the
## passage's targets, not the background track. Beat-State ends on a Miss or an idle gap.
## A switch mid-chain hands the passage to the incoming member at the same phase.

signal entered(character: String, tier: String)
signal exited(reason: String)
signal judged(grade: int, offset_ms: float, chain: int, character: String)

## Passage targets in beats, within a one-bar loop, chosen by the opening attack's range tier.
const TIER_TARGETS: Dictionary = {
	"close": [0.0, 1.0, 2.0, 3.0],
	"mid": [0.0, 1.0, 1.5, 2.0, 3.0],
}
const BEATS_PER_BAR := 4.0

@export var windows: RhythmWindows
@export var idle_gap_beats: float = 2.0

var music: MusicDirector
var growth_log: GrowthLog
var pair_bond: PairBond
var calibration_ms: float = 0.0

var active := false
var character := ""
var tier := ""
var chain := 0
var last_grade := -1
var last_offset_ms := 0.0

var _anchor_usec := 0  # when beat zero of the passage is heard
var _last_input_usec := 0
var _judged: Dictionary = {}  # target index, counted across bars -> true
var _handoff_pending := false
var _players: Dictionary = {}  # "Character:tier" -> AudioStreamPlayer
var _current_player: AudioStreamPlayer


func setup(p_music: MusicDirector, p_log: GrowthLog, p_bond: PairBond, characters: Array) -> void:
	music = p_music
	growth_log = p_log
	pair_bond = p_bond
	if windows == null:
		windows = RhythmWindows.new()
	for c: String in characters:
		for t: String in TIER_TARGETS:
			var p := AudioStreamPlayer.new()
			p.stream = PlaceholderAudio.passage(music.bpm, c, t, TIER_TARGETS[t])
			p.volume_db = -4.0
			add_child(p)
			_players["%s:%s" % [c, t]] = p


## An attack press. press_usec is stamped in _input; p_tier is the attack's range tier.
func on_attack(press_usec: int, p_character: String, p_tier: String) -> void:
	if not active:
		_enter(press_usec, p_character, p_tier)
	else:
		_judge(press_usec)


## CoD-11: the passage moves to the incoming member's instrument at the same phase.
func hand_off(new_character: String) -> void:
	if not active:
		return
	character = new_character
	var now := Time.get_ticks_usec()
	var loop_s := BEATS_PER_BAR * music.beat_seconds()
	var phase_s := fposmod(float(now + music.audio_lead_usec() - _anchor_usec) / 1_000_000.0, loop_s)
	_play_passage(phase_s)
	_handoff_pending = true
	_last_input_usec = now


## The phase of the passage beat as heard, from 0 to 1, or -1 outside Beat-State.
func beat_phase() -> float:
	if not active:
		return -1.0
	return fposmod(float(Time.get_ticks_usec() - _anchor_usec) / _beat_usec(), 1.0)


func _process(_delta: float) -> void:
	if active and Time.get_ticks_usec() - _last_input_usec > idle_gap_beats * _beat_usec():
		_exit("idle")


func _enter(press_usec: int, p_character: String, p_tier: String) -> void:
	active = true
	character = p_character
	tier = p_tier
	chain = 0
	_judged.clear()
	_judged[0] = true  # CoD-09: the opening attack is the ungraded anchor at beat zero.
	_handoff_pending = false
	_anchor_usec = press_usec + music.audio_lead_usec()
	_last_input_usec = press_usec
	_play_passage(0.0)
	music.enter_focus()
	entered.emit(character, tier)


func _judge(press_usec: int) -> void:
	var adj := float(press_usec) - calibration_ms * 1000.0
	var targets: Array = TIER_TARGETS[tier]
	var n := targets.size()
	var bar := int(floor((adj - _anchor_usec) / _beat_usec() / BEATS_PER_BAR))
	var best := -1
	var best_dist := INF
	for b in range(maxi(bar - 1, 0), bar + 2):
		for k in n:
			var idx := b * n + k
			if _judged.has(idx):
				continue
			var d := absf(adj - _target_usec(idx))
			if d < best_dist:
				best_dist = d
				best = idx
	var offset_ms := (adj - _target_usec(best)) / 1000.0
	var g := windows.grade(offset_ms)
	last_grade = g
	last_offset_ms = offset_ms
	_last_input_usec = press_usec
	if g == RhythmWindows.Grade.MISS:
		growth_log.record(g, offset_ms, calibration_ms, "combat", character, chain)
		judged.emit(g, offset_ms, chain, character)
		_exit("miss")
		return
	_judged[best] = true
	chain += 1
	growth_log.record(g, offset_ms, calibration_ms, "combat", character, chain)
	if _handoff_pending:
		_handoff_pending = false
		if RhythmWindows.is_credit(g):
			pair_bond.record_shared_success("handoff")  # CoD-13
	judged.emit(g, offset_ms, chain, character)


func _exit(reason: String) -> void:
	active = false
	_handoff_pending = false
	if _current_player:
		_current_player.stop()
	music.exit_focus()
	exited.emit(reason)


func _play_passage(from_s: float) -> void:
	if _current_player:
		_current_player.stop()
	_current_player = _players["%s:%s" % [character, tier]]
	_current_player.play(from_s)


func _beat_usec() -> float:
	return music.beat_seconds() * 1_000_000.0


func _target_usec(index: int) -> float:
	var targets: Array = TIER_TARGETS[tier]
	var n := targets.size()
	@warning_ignore("integer_division")
	var bar := index / n
	var tb: float = targets[index % n]
	return _anchor_usec + (bar * BEATS_PER_BAR + tb) * _beat_usec()
