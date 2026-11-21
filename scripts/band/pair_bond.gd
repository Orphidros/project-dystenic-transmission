class_name PairBond
extends Node
## The hidden Vox-Ciphera pair-bond (CoD-01, CoD-13 to CoD-15).
## It is never shown as a number. Its only tell is Ciphera's rig light, through band().
## The band thresholds are placeholders, to be set from playtest data in the growth log (OQ-056).

signal changed(value: int, band: int)

const BAND_THRESHOLDS: Array[int] = [0, 3, 6, 10]

var value: int = 0


## CoD-13: a node answer or a Beat-State handoff, at Perfect or Good.
func record_shared_success(source: String) -> void:
	_add(1, source)


## CoD-14: only choices can lower the bond. Harmonic raises it; the missed note lowers it.
func record_micro_choice(harmonic: bool) -> void:
	_add(2 if harmonic else -2, "micro_choice")


func band() -> int:
	var b := 0
	for i in BAND_THRESHOLDS.size():
		if value >= BAND_THRESHOLDS[i]:
			b = i
	return b


func _add(delta: int, source: String) -> void:
	value = maxi(0, value + delta)
	changed.emit(value, band())
	print_verbose("PairBond %+d (%s) -> %d" % [delta, source, value])
