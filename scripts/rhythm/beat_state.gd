class_name BeatState
extends Node
## Beat-State, or Rhythmic Focus (CoD-07, amended 2026-11-21; CoD-09; CoD-10).
## The first attack of a single-character chain is an ungraded anchor (CoD-09). It starts that
## character's instrument passage instantly, and later inputs are graded against the passage's
## targets, not the background track (CoD-07).
## Beat-State ends on two Misses in a row, on the third Miss in total, or on an idle gap of three
## beats (CoD-07, amended 2026-11-21; OQ-A09). The combo keeps growing with no cap, and the player
## can strike whether or not Beat-State runs (author, 2026-11-20).
## hand_off() is the CoD-11 handoff. It is Tier 1.5 (OQ-A10), and the prototype calls it only
## when its beat_state_handoff_enabled flag is on (OQ-066).

signal entered(character: String, tier: String)
signal exited(reason: String)
signal judged(grade: int, offset_ms: float, chain: int, character: String)

## Passage targets in beats, within a one-bar loop. The passage is picked by character and by the
## opening attack's range tier. CoD-07, widened 2026-11-20 and 2026-11-21: stage, enemy and distance
## to the enemy aren't built yet. One placeholder passage per character per range tier (CoD-12; OQ-A08).
const TIER_TARGETS: Dictionary = {
	"close": [0.0, 1.0, 2.0, 3.0],
	"mid": [0.0, 1.0, 1.5, 2.0, 3.0],
}
const BEATS_PER_BAR := 4.0
## CoD-07, amended 2026-11-21: the Miss counts that end Beat-State.
const MISSES_IN_A_ROW_TO_END := 2
const MISSES_IN_TOTAL_TO_END := 3

@export var windows: RhythmWindows
## CoD-07; OQ-A09 (ruled 2026-11-09, restated 2026-11-20): about three beats.
## What may extend it is open (OQ-036).
@export var idle_gap_beats: float = 3.0
## After a Miss that doesn't end Beat-State, reset the combo count to zero.
## Follows Supplement 1's Miss State; the author may flip it (2026-11-21).
@export var miss_resets_chain := true

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
var misses_in_a_row := 0  # reset by any Perfect, Good or Poor
var misses_total := 0  # reset only when Beat-State ends

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


## CoD-11 (Tier 1.5; OQ-A10): the passage moves to the incoming member's instrument at the
## same phase. Kept intact; the prototype only calls it with its handoff flag on (OQ-066).
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
	# CoD-07; OQ-A09: no input for the idle gap ends Beat-State.
	if active and Time.get_ticks_usec() - _last_input_usec > idle_gap_beats * _beat_usec():
		_exit("idle")


func _enter(press_usec: int, p_character: String, p_tier: String) -> void:
	active = true
	character = p_character
	tier = p_tier
	chain = 0
	misses_in_a_row = 0
	misses_total = 0
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
		_on_miss(offset_ms)
		return
	misses_in_a_row = 0
	_judged[best] = true
	chain += 1
	growth_log.record(g, offset_ms, calibration_ms, "combat", character, chain)  # CoD-01; OQ-067
	if _handoff_pending:
		_handoff_pending = false
		if RhythmWindows.is_credit(g):
			pair_bond.record_shared_success("handoff")  # CoD-13
	judged.emit(g, offset_ms, chain, character)


## CoD-07, amended 2026-11-21. A Miss is logged, scratches and adds stress as before (the
## controller handles the last two through `judged`). It doesn't consume a target, so the passage
## plays on at its phase and later inputs are still graded against it. Beat-State ends only on
## the second Miss in a row or the third in total.
func _on_miss(offset_ms: float) -> void:
	misses_in_a_row += 1
	misses_total += 1
	_handoff_pending = false
	growth_log.record(RhythmWindows.Grade.MISS, offset_ms, calibration_ms, "combat", character, chain)  # CoD-01; OQ-067
	judged.emit(RhythmWindows.Grade.MISS, offset_ms, chain, character)
	if misses_in_a_row >= MISSES_IN_A_ROW_TO_END:
		_exit("two_in_a_row")
	elif misses_total >= MISSES_IN_TOTAL_TO_END:
		_exit("third_miss")
	elif miss_resets_chain:
		chain = 0  # Supplement 1's Miss State (miss_resets_chain; 2026-11-21)


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
