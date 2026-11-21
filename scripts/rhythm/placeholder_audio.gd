class_name PlaceholderAudio
extends RefCounted
## Placeholder sounds generated in code (CoD-12; OQ-A08), so the prototype needs no audio assets.
## Real compositions replace them at Tier 1.5. Every sound here belongs to Audio & SFX.

const RATE := 22050


static func beats_to_seconds(bpm: float, beats: float) -> float:
	return beats * 60.0 / bpm


static func track_seconds(bpm: float) -> float:
	return beats_to_seconds(bpm, 8.0)


## The encounter track: a two-bar loop of kick, snare, hats and bass.
static func track(bpm: float) -> AudioStreamWAV:
	var b := _buffer(track_seconds(bpm))
	for beat in 8:
		var t := beats_to_seconds(bpm, beat)
		if beat % 2 == 0:
			_tone(b, t, 0.35, 58.0, 0.7, "kick", 14.0)
		else:
			_tone(b, t, 0.2, 0.0, 0.3, "noise", 28.0)
		for half in 2:
			_tone(b, t + beats_to_seconds(bpm, 0.5 * half), 0.05, 0.0, 0.08, "noise", 90.0)
	for nb: float in [0.0, 1.5, 2.0, 3.5, 4.0, 5.5, 6.0, 7.5]:
		_tone(b, beats_to_seconds(bpm, nb), 0.3, 55.0, 0.18, "saw", 7.0)
	return _to_stream(b, true)


## Area sound: a soft, low-passed noise bed.
static func ambience() -> AudioStreamWAV:
	var b := _buffer(3.0)
	var y := 0.0
	for i in b.size():
		y += (randf_range(-1.0, 1.0) - y) * 0.03
		b[i] = y * 0.6
	return _to_stream(b, true)


## Beat-State's low drone foundation. Each frequency fits a whole number of cycles
## into 4 s, so the loop is seamless.
static func drone() -> AudioStreamWAV:
	var b := _buffer(4.0)
	for i in b.size():
		var t := float(i) / RATE
		b[i] = 0.3 * sin(TAU * 55.0 * t) + 0.2 * sin(TAU * 82.5 * t) + 0.08 * sin(TAU * 110.0 * t)
	return _to_stream(b, true)


## A one-bar instrument passage for one character and one range tier (CoD-07).
## Its notes fall exactly on the targets the player is graded against.
static func passage(bpm: float, character: String, tier: String, targets: Array) -> AudioStreamWAV:
	var b := _buffer(beats_to_seconds(bpm, 4.0))
	var wave := "square" if character == "Vox" else "fm"
	var base := 146.83 if character == "Vox" else 293.66
	var melody: Array[float] = [1.0, 1.335, 1.498, 1.335, 1.122]
	for i in targets.size():
		var tb: float = targets[i]
		var t := beats_to_seconds(bpm, tb)
		if tier == "close":
			_tone(b, t, 0.18, base * 0.5, 0.45, wave, 22.0)
			_tone(b, t, 0.08, 0.0, 0.25, "noise", 45.0)
		else:
			_tone(b, t, 0.35, base * melody[i % melody.size()], 0.35, wave, 8.0)
	return _to_stream(b, true)


## The node's Oracle cadence (CoD-03): one bar, not looped.
static func cadence(bpm: float, pattern: Array) -> AudioStreamWAV:
	var b := _buffer(beats_to_seconds(bpm, 4.0))
	var steps: Array[float] = [1.0, 1.0, 1.189, 0.891]
	for i in pattern.size():
		var pb: float = pattern[i]
		var t := beats_to_seconds(bpm, pb)
		var f := 392.0 * steps[i % steps.size()]
		_tone(b, t, 0.3, f, 0.3, "sine", 9.0)
		_tone(b, t, 0.3, f * 1.5, 0.15, "sine", 9.0)
	return _to_stream(b, false)


## Beat-hit sounds by grade. The Miss is a discordant scratch and never a choice tone (CoD-08).
static func hit(grade: int) -> AudioStreamWAV:
	var b := _buffer(0.3)
	match grade:
		0:
			_tone(b, 0.0, 0.25, 1318.5, 0.35, "sine", 18.0)
		1:
			_tone(b, 0.0, 0.2, 1244.5, 0.3, "sine", 24.0)
		2:
			_tone(b, 0.0, 0.15, 196.0, 0.4, "sine", 35.0)
		_:
			_tone(b, 0.0, 0.28, 0.0, 0.35, "noise", 10.0)
			_tone(b, 0.0, 0.28, 233.0, 0.2, "saw", 10.0)
			_tone(b, 0.0, 0.28, 247.0, 0.2, "saw", 10.0)
	return _to_stream(b, false)


## Vox's voice cracking on a Poor node answer (CoD-05).
static func crack() -> AudioStreamWAV:
	var b := _buffer(0.45)
	_tone(b, 0.0, 0.4, 0.0, 0.3, "noise", 9.0)
	_tone(b, 0.0, 0.4, 170.0, 0.35, "crack", 7.0)
	return _to_stream(b, false)


static func _buffer(seconds: float) -> PackedFloat32Array:
	var b := PackedFloat32Array()
	b.resize(int(seconds * RATE))
	b.fill(0.0)
	return b


static func _tone(buf: PackedFloat32Array, start_s: float, dur_s: float, freq: float, amp: float, wave: String, decay: float) -> void:
	var i0 := int(start_s * RATE)
	var n := int(dur_s * RATE)
	var ph := 0.0
	for j in n:
		var idx := i0 + j
		if idx >= buf.size():
			break
		var t := float(j) / RATE
		var env := exp(-t * decay) * minf(1.0, t * 500.0)
		var f := freq
		if wave == "kick":
			f = freq * (1.0 + 2.5 * exp(-t * 35.0))
		elif wave == "crack":
			f = freq * (1.0 + 0.2 * sin(TAU * 11.0 * t))
		ph += f / RATE
		var v := 0.0
		match wave:
			"sine", "kick":
				v = sin(TAU * ph)
			"square":
				v = 1.0 if fmod(ph, 1.0) < 0.5 else -1.0
			"saw", "crack":
				v = 2.0 * fmod(ph, 1.0) - 1.0
			"noise":
				v = randf_range(-1.0, 1.0)
			"fm":
				v = sin(TAU * ph + 1.8 * sin(TAU * ph * 2.0))
		buf[idx] += v * amp * env


static func _to_stream(samples: PackedFloat32Array, loop: bool) -> AudioStreamWAV:
	var bytes := PackedByteArray()
	bytes.resize(samples.size() * 2)
	for i in samples.size():
		bytes.encode_s16(i * 2, int(clampf(samples[i], -1.0, 1.0) * 32767.0))
	var s := AudioStreamWAV.new()
	s.format = AudioStreamWAV.FORMAT_16_BITS
	s.mix_rate = RATE
	s.stereo = false
	s.data = bytes
	if loop:
		s.loop_mode = AudioStreamWAV.LOOP_FORWARD
		s.loop_begin = 0
		s.loop_end = samples.size()
	return s
