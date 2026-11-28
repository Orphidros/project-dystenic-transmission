class_name RigLight
extends OmniLight3D
## Ciphera's rig as a beat light (CoD-02). It moves with her, pulses on the beat, and has
## no attacks and no AI. Its warmth and steadiness are the pair-bond's only tell (CoD-15).
## Chosen light is small, so the range is short.

const COOL := Color(0.45, 0.8, 1.0)
const WARM := Color(1.0, 0.72, 0.42)

var phase_source: Callable  # returns a beat phase from 0 to 1, or -1 for none
var bond: PairBond


func _ready() -> void:
	omni_range = 3.0
	light_energy = 0.6
	position = Vector3(0.0, 1.7, 0.4)


func _process(_delta: float) -> void:
	var band := bond.band() if bond else 0
	var w := float(band) / 3.0
	light_color = COOL.lerp(WARM, w)
	var phase: float = phase_source.call() if phase_source.is_valid() else -1.0
	var pulse := exp(-phase * 7.0) if phase >= 0.0 else 0.0
	var jitter := randf_range(-0.25, 0.25) * (1.0 - w)  # It steadies as the bond rises.
	light_energy = maxf(0.0, 0.5 + 2.5 * pulse + jitter)
