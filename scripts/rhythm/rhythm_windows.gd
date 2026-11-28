class_name RhythmWindows
extends Resource
## Judgement windows for DT's four timing tiers, as half-widths in ms around a target.
## The values are candidates taken from open-source rhythm games (see the round 2
## report) and should be measured in Phase 5. Keep Perfect at or above about 25 ms,
## because Godot 4.7.1 adds roughly +/-10 ms of engine noise before the player acts.

enum Grade { PERFECT, GOOD, POOR, MISS }

const GRADE_NAMES: Array[String] = ["Perfect", "Good", "Poor", "Miss"]

@export var perfect_ms: float = 45.0
@export var good_ms: float = 90.0
@export var poor_ms: float = 150.0


## Grades a signed offset in ms. Early and late use the same window, since none of
## the open-source games studied in round 2 uses an asymmetric one.
func grade(offset_ms: float) -> int:
	var a := absf(offset_ms)
	if a <= perfect_ms:
		return Grade.PERFECT
	if a <= good_ms:
		return Grade.GOOD
	if a <= poor_ms:
		return Grade.POOR
	return Grade.MISS


static func grade_name(g: int) -> String:
	return GRADE_NAMES[g]


## Perfect and Good earn growth credit (CoD-01; OQ-067) and can write the pair-bond (CoD-13).
static func is_credit(g: int) -> bool:
	return g == Grade.PERFECT or g == Grade.GOOD
