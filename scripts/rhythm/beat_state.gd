class_name BeatState
extends Node
## Beat-State, or Rhythmic Focus (CoD-07, amended 2026-11-21; CoD-09; CoD-10).
## The first attack of a single-character chain is an ungraded anchor (CoD-09). It starts that
## character's instrument passage instantly, and later inputs are graded against the passage's
## targets, not the background track (CoD-07).
## CoD-07 (amended 2026-11-21): Beat-State plays in patterns of pattern_bars bars (4 at Tier 1).
## - A pattern played through to its end is complete. The combo carries into the next pattern,
##   which starts on the following bar with no new opening attack and a fresh miss count.
## - The closing attack picks the next pattern: its range tier repeats the passage or switches it
##   up (CoD-07, widened 2026-11-20 and 2026-11-21). Extensions wait for Tier 1.5's passages.
## - A pattern ends early on two Misses in a row, on the third Miss in total within it, on
##   environmental damage, or on an idle gap of three beats (OQ-A09). An early end ends the combo.
## - A Miss that doesn't end the pattern pauses the combo, and an enemy hit is a Miss.
## The combo keeps growing with no cap, and the player can strike whether or not Beat-State
## runs (author, 2026-11-20). hand_off() is the CoD-11 handoff: Tier 1.5 (OQ-A10), called by the
## prototype only when its beat_state_handoff_enabled flag is on (OQ-066).

signal entered(character: String, tier: String)
signal exited(reason: String)
signal judged(grade: int, offset_ms: float, chain: int, character: String)
## CoD-07 (amended 2026-11-21): patterns; a completed pattern carries the combo.
signal pattern_completed(number: int, chain: int, next_tier: String)
## CoD-07 (amended 2026-11-21): an enemy hit is a Miss. When damage exists, this signal plays the
## percussive amp-feedback buzz with the enemy's hit-type sound, and adds the hit's stress (O-07).
signal enemy_hit_taken(hit_type: String)

## Passage targets in beats, within a one-bar loop. The passage is picked by character and by
## range tier. CoD-07, widened 2026-11-20 and 2026-11-21: stage, enemy and distance to the enemy
## aren't built yet. One placeholder passage per character per range tier (CoD-12; OQ-A08).
## Every Tier 1 passage has a beat on the downbeat, which keeps the bar line unambiguous.
const TIER_TARGETS: Dictionary = {
	"close": [0.0, 1.0, 2.0, 3.0],
	"mid": [0.0, 1.0, 1.5, 2.0, 3.0],
}
const BEATS_PER_BAR := 4.0
## CoD-07 (amended 2026-11-21): the Miss counts that end a pattern early.
const MISSES_IN_A_ROW_TO_END := 2
const MISSES_IN_TOTAL_TO_END := 3
## A Switch-up's passage may start up to this long before the bar line is heard: three frames at
## 60 fps, so one slow frame can't push the start past the bar line and clip the downbeat. Its phase
## is set so that its downbeat still lands exactly on the bar line. The last 50 ms of every Tier 1
## passage loop is silent, so starting early adds no sound.
const SWITCH_UP_START_WINDOW_USEC := 50_000
## Judged targets are keyed by bar and position (bar * KEY_STRIDE + position), so each pattern
## keeps its own passage's targets.
const KEY_STRIDE := 16

@export var windows: RhythmWindows
## CoD-07; OQ-A09 (ruled 2026-11-09, restated 2026-11-20): about three beats.
## What may extend it is open (OQ-036).
@export var idle_gap_beats: float = 3.0
## CoD-07 (amended 2026-11-21): Tier 1's pattern length, in bars of the loaded passage. Later
## patterns may set their own, longer or more complex. The bar lines between patterns fall every
## pattern_bars * BEATS_PER_BAR beats after the anchor.
@export var pattern_bars := 4

var music: MusicDirector
var growth_log: GrowthLog
var pair_bond: PairBond
var calibration_ms: float = 0.0

var active := false
var character := ""
var tier := ""  # the current pattern's passage
var chain := 0
var last_grade := -1
var last_offset_ms := 0.0
var pattern_number := 0  # 1 for the first pattern of each Beat-State
var misses_in_a_row := 0  # reset by any Perfect, Good or Poor, and when a pattern completes
var misses_total := 0  # within the current pattern
## When and how the last passage started ahead of a bar line: usec, lead_usec, from_s, tier.
var last_passage_start: Dictionary = {}

var _anchor_usec := 0  # when beat zero of the first pattern is heard; patterns never move it
var _last_input_usec := 0
var _judged: Dictionary = {}  # bar * KEY_STRIDE + position -> true
var _handoff_pending := false
var _players: Dictionary = {}  # "Character:tier" -> AudioStreamPlayer
var _current_player: AudioStreamPlayer
var _closing_tier := ""  # range tier of the last attack that belonged to the current pattern
var _next_locked := false  # true once no press can still belong to the current pattern
var _next_tier := ""
var _next_started := false  # a Switch-up's passage has started ahead of the bar line


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
		_judge(press_usec, p_tier)


## CoD-07 (amended 2026-11-21): an enemy hit is a Miss. It counts toward two in a row and the third
## in total, and it pauses the combo, exactly as a missed input does. It isn't a timed input, so it
## emits enemy_hit_taken instead of judged, plays no scratch, writes nothing to the growth log and
## doesn't reset the idle gap. Not wired yet: the Basic Bot calls it when damage exists (Phases 3
## and 4). Tests call it directly.
func on_enemy_hit(hit_type: String = "") -> void:
	if not active:
		return
	_update_pattern_clock(Time.get_ticks_usec())  # a hit belongs to the pattern running now
	enemy_hit_taken.emit(hit_type)
	_count_miss()


## CoD-07 (amended 2026-11-21): environmental damage ends the pattern at once, and the combo
## with it. Not wired yet: hazards call it when damage exists (Phases 3 and 4). Tests call it.
func on_environmental_damage() -> void:
	if not active:
		return
	_exit("environment")


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


## The bar of the current pattern being heard, from 1 to pattern_bars, or 0 outside Beat-State.
func bar_in_pattern() -> int:
	if not active:
		return 0
	var bars := int(floor(float(Time.get_ticks_usec() - _anchor_usec) / _bar_usec()))
	return clampi(bars - _first_bar(pattern_number) + 1, 1, pattern_bars)


func _process(_delta: float) -> void:
	if not active:
		return
	var now := Time.get_ticks_usec()
	_update_pattern_clock(now)  # completion is checked before the idle gap
	# CoD-07; OQ-A09: no press for the idle gap ends Beat-State. It counts from the last press,
	# across bar lines.
	if active and now - _last_input_usec > idle_gap_beats * _beat_usec():
		_exit("idle")


## CoD-07 (amended 2026-11-21): the closing attack picks the next pattern. Once no press can still
## belong to the current pattern, its closing attack is final and the next passage is known. A
## Switch-up starts just ahead of the bar line, and the pattern completes when the bar line is heard.
func _update_pattern_clock(now: int) -> void:
	var bar_line := _bar_line_usec()
	if not _next_locked and float(now) - calibration_ms * 1000.0 >= _lock_point_usec():
		_next_locked = true
		_next_tier = _closing_tier
	if _next_locked and _next_tier != tier and not _next_started \
			and now + music.audio_lead_usec() >= bar_line - SWITCH_UP_START_WINDOW_USEC:
		_start_passage_ahead(_next_tier)
	if now >= bar_line:
		_complete_pattern()


func _enter(press_usec: int, p_character: String, p_tier: String) -> void:
	active = true
	character = p_character
	tier = p_tier
	chain = 0  # an early end ended the last combo, so the next one starts from 0
	pattern_number = 1
	misses_in_a_row = 0
	misses_total = 0
	_judged.clear()
	_judged[_key(0, 0)] = true  # CoD-09: the opening attack is the ungraded anchor at beat zero.
	_handoff_pending = false
	_closing_tier = p_tier
	_next_locked = false
	_next_tier = ""
	_next_started = false
	_anchor_usec = press_usec + music.audio_lead_usec()
	_last_input_usec = press_usec
	_play_passage(0.0)
	music.enter_focus()
	entered.emit(character, tier)


func _judge(press_usec: int, p_tier: String) -> void:
	var adj := float(press_usec) - calibration_ms * 1000.0
	_last_input_usec = press_usec
	var target := _nearest_unjudged(adj)
	var bar: int = target[0]
	var pos: int = target[1]
	if bar < 0:
		return  # Nothing to grade against; can't happen while patterns complete on time.
	# A press belongs to the pattern of the beat it's graded against. One that plays the next
	# pattern's beat a little early completes the current pattern first, and doesn't count
	# toward its closing attack (CoD-07, amended 2026-11-21).
	if _pattern_of_bar(bar) > pattern_number:
		_complete_pattern()
	_closing_tier = p_tier
	var offset_ms := (adj - _target_usec(bar, pos)) / 1000.0
	var g := windows.grade(offset_ms)
	last_grade = g
	last_offset_ms = offset_ms
	if g == RhythmWindows.Grade.MISS:
		_on_miss(offset_ms)
		return
	misses_in_a_row = 0
	_judged[_key(bar, pos)] = true
	chain += 1
	growth_log.record(g, offset_ms, calibration_ms, "combat", character, chain)  # CoD-01; OQ-067
	if _handoff_pending:
		_handoff_pending = false
		if RhythmWindows.is_credit(g):
			pair_bond.record_shared_success("handoff")  # CoD-13
	judged.emit(g, offset_ms, chain, character)


## A missed input is logged, scratches and adds stress (the controller handles the last two
## through `judged`). It doesn't use up a beat, so a later press can still play it.
func _on_miss(offset_ms: float) -> void:
	growth_log.record(RhythmWindows.Grade.MISS, offset_ms, calibration_ms, "combat", character, chain)  # CoD-01; OQ-067
	judged.emit(RhythmWindows.Grade.MISS, offset_ms, chain, character)
	_count_miss()


## CoD-07 (amended 2026-11-21): a missed input and an enemy hit count here, the same way.
## A Miss that doesn't end the pattern pauses the chain: it keeps its number, and the next
## Perfect, Good or Poor carries on from it. A Miss that is both the second in a row and the
## third in total ends as "two_in_a_row" (confirmed by the author, 2026-11-21).
func _count_miss() -> void:
	misses_in_a_row += 1
	misses_total += 1
	_handoff_pending = false
	if misses_in_a_row >= MISSES_IN_A_ROW_TO_END:
		_exit("two_in_a_row")
	elif misses_total >= MISSES_IN_TOTAL_TO_END:
		_exit("third_miss")


## CoD-07 (amended 2026-11-21): patterns; a completed pattern carries the combo. The chain and the
## anchor stay, the miss counts reset, and the closing attack's tier picks the next passage: the
## same tier keeps it playing, the other tier is a Switch-up. The new pattern's first beat isn't
## pre-judged; the player plays it.
func _complete_pattern() -> void:
	var completed := pattern_number
	var next := _upcoming_tier()
	if next != tier and not _next_started:
		_start_passage_ahead(next)
	tier = next
	pattern_number += 1
	misses_in_a_row = 0
	misses_total = 0
	_next_locked = false
	_next_tier = ""
	_next_started = false
	_closing_tier = tier
	pattern_completed.emit(completed, chain, next)


## Starts a Switch-up's passage so that its downbeat is heard exactly on the bar line, using the
## audio lead and the phase arithmetic hand_off() uses: started inside the pattern's last bar, the
## passage reaches its downbeat on the anchor's bar grid, which is the bar line.
func _start_passage_ahead(p_tier: String) -> void:
	var now := Time.get_ticks_usec()
	var lead := music.audio_lead_usec()
	var loop_s := BEATS_PER_BAR * music.beat_seconds()
	var from_s := fposmod(float(now + lead - _anchor_usec) / 1_000_000.0, loop_s)
	_play_passage(from_s, p_tier)
	_next_started = true
	last_passage_start = {"usec": now, "lead_usec": lead, "from_s": from_s, "tier": p_tier}


func _exit(reason: String) -> void:
	active = false
	_handoff_pending = false
	if _current_player:
		_current_player.stop()
	music.exit_focus()
	exited.emit(reason)


func _play_passage(from_s: float, p_tier: String = "") -> void:
	if _current_player:
		_current_player.stop()
	_current_player = _players["%s:%s" % [character, p_tier if p_tier != "" else tier]]
	_current_player.play(from_s)


## The nearest beat nobody has played yet, among the current pattern and the next one.
## Returns [bar, position], or [-1, -1].
func _nearest_unjudged(adj: float) -> Array:
	var first := _first_bar(pattern_number)
	var last := first + 2 * pattern_bars - 1
	var bar := int(floor((adj - _anchor_usec) / _bar_usec()))
	var best: Array = [-1, -1]
	var best_dist := INF
	for b in range(maxi(bar - 1, first), mini(bar + 1, last) + 1):
		var targets: Array = TIER_TARGETS[_tier_for_bar(b)]
		for k in targets.size():
			if _judged.has(_key(b, k)):
				continue
			var d := absf(adj - _target_usec(b, k))
			if d < best_dist:
				best_dist = d
				best = [b, k]
	return best


## Midway between the current pattern's latest unplayed beat and its bar line: after this, every
## press is nearer the next pattern's downbeat. If every beat has been played, that's now.
func _lock_point_usec() -> float:
	var first := _first_bar(pattern_number)
	var targets: Array = TIER_TARGETS[tier]
	for b in range(first + pattern_bars - 1, first - 1, -1):
		for k in range(targets.size() - 1, -1, -1):
			if not _judged.has(_key(b, k)):
				return (_target_usec(b, k) + _bar_line_usec()) / 2.0
	return -INF


func _upcoming_tier() -> String:
	return _next_tier if _next_locked else _closing_tier


func _tier_for_bar(bar: int) -> String:
	return tier if _pattern_of_bar(bar) <= pattern_number else _upcoming_tier()


func _pattern_of_bar(bar: int) -> int:
	@warning_ignore("integer_division")
	return bar / pattern_bars + 1


func _first_bar(pattern: int) -> int:
	return (pattern - 1) * pattern_bars


func _bar_line_usec() -> float:
	return _anchor_usec + pattern_number * pattern_bars * _bar_usec()


func _key(bar: int, pos: int) -> int:
	return bar * KEY_STRIDE + pos


func _beat_usec() -> float:
	return music.beat_seconds() * 1_000_000.0


func _bar_usec() -> float:
	return BEATS_PER_BAR * _beat_usec()


func _target_usec(bar: int, pos: int) -> float:
	var targets: Array = TIER_TARGETS[_tier_for_bar(bar)]
	var tb: float = targets[pos]
	return _anchor_usec + bar * _bar_usec() + tb * _beat_usec()
