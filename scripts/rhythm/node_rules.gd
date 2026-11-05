class_name NodeRules
extends RefCounted
## Rulings D-05 and D-06 (2026-11-05) as a pure function, so they can be tested.
## The stress amounts are placeholders. Only their order matters for now:
## the free first fault < a node Poor < a node Miss < combat rates.

## Stress added at a node for any fault after the first one.
const NODE_POOR_TICK := 1.5
const NODE_MISS_TICK := 3.0
## Combat rates (O-07), used at time-critical nodes.
const COMBAT_POOR_TICK := 3.0
const COMBAT_MISS_TICK := 6.0
## How time-critical nodes are read: the first-fault grace doesn't apply there
## either, because combat has no grace. This is an interpretation, still to be confirmed.
const GRACE_AT_TIME_CRITICAL := false


## Resolves a node answer from its worst graded note. Returns a Dictionary with:
## opened, crack, rejected, stress_delta, first_fault_used and bond_delta.
static func resolve(worst_grade: int, first_fault_used: bool, time_critical: bool) -> Dictionary:
	var r := {
		"opened": false,
		"crack": false,
		"rejected": false,
		"stress_delta": 0.0,
		"first_fault_used": first_fault_used,
		"bond_delta": 0,
	}
	if worst_grade == RhythmWindows.Grade.PERFECT or worst_grade == RhythmWindows.Grade.GOOD:
		r["opened"] = true
		r["bond_delta"] = 1  # D-13: answering a node Ciphera revealed is a shared moment.
	elif worst_grade == RhythmWindows.Grade.POOR:
		r["opened"] = true
		r["crack"] = true  # D-05: the crack always carries, even on the free first fault.
		var poor_tick := COMBAT_POOR_TICK if time_critical else NODE_POOR_TICK
		r["stress_delta"] = _fault_stress(first_fault_used, time_critical, poor_tick)
		r["first_fault_used"] = true
	else:
		r["rejected"] = true
		var miss_tick := COMBAT_MISS_TICK if time_critical else NODE_MISS_TICK
		r["stress_delta"] = _fault_stress(first_fault_used, time_critical, miss_tick)
		r["first_fault_used"] = true
	return r


static func _fault_stress(first_fault_used: bool, time_critical: bool, tick: float) -> float:
	var grace := not first_fault_used and (not time_critical or GRACE_AT_TIME_CRITICAL)
	return 0.0 if grace else tick
