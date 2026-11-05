extends Node
## Phase 5 scene S1 from the round 2 report. It logs the audio clock against the wall
## clock, then writes user://clock_probe.csv and prints a summary.
## Run it for 20 s (the default) on the target PC. Headless options:
##   -- --probe-seconds=3 --probe-quit

@export var duration_s := 20.0

var _player: AudioStreamPlayer
var _latency := 0.0
var _loop_s := 0.0
var _wraps := 0
var _rows: PackedStringArray = []
var _t0_usec := 0
var _a0 := -1.0
var _prev_raw := -1.0
var _prev_audio := -1.0
var _prev_frame_usec := 0
var _backwards := 0
var _drift_min := INF
var _drift_max := -INF
var _frame_ms: PackedFloat32Array = []
var _done := false
var _quit_when_done := false
var _label: Label


func _ready() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("--probe-seconds="):
			duration_s = float(a.get_slice("=", 1))
		elif a == "--probe-quit":
			_quit_when_done = true
	_latency = AudioServer.get_output_latency()
	_loop_s = PlaceholderAudio.track_seconds(100.0)
	_player = AudioStreamPlayer.new()
	_player.stream = PlaceholderAudio.track(100.0)
	add_child(_player)
	_player.play()
	_t0_usec = Time.get_ticks_usec()
	_prev_frame_usec = _t0_usec
	_rows.append("t_ms,playback_pos_s,since_mix_s,audio_time_s,drift_ms,frame_ms")
	var layer := CanvasLayer.new()
	add_child(layer)
	_label = Label.new()
	_label.position = Vector2(16.0, 12.0)
	layer.add_child(_label)


func _process(_delta: float) -> void:
	if _done:
		return
	var now := Time.get_ticks_usec()
	var wall_s := float(now - _t0_usec) / 1_000_000.0
	var pos := _player.get_playback_position()
	var since := AudioServer.get_time_since_last_mix()
	var raw := pos + since - _latency
	if _prev_raw >= 0.0 and raw < _prev_raw - _loop_s * 0.5:
		_wraps += 1  # The track looped.
	_prev_raw = raw
	var audio := raw + _wraps * _loop_s
	if _prev_audio >= 0.0 and audio < _prev_audio:
		_backwards += 1  # The docs say to discard values lower than the previous frame's.
	_prev_audio = audio
	if _a0 < 0.0:
		_a0 = audio
	var drift_ms := ((audio - _a0) - wall_s) * 1000.0
	_drift_min = minf(_drift_min, drift_ms)
	_drift_max = maxf(_drift_max, drift_ms)
	var frame_ms := float(now - _prev_frame_usec) / 1000.0
	_prev_frame_usec = now
	_frame_ms.append(frame_ms)
	_rows.append("%.3f,%.6f,%.6f,%.6f,%.3f,%.3f" % [wall_s * 1000.0, pos, since, audio, drift_ms, frame_ms])
	_label.text = "Clock probe: %.1f / %.0f s\nbackwards reads %d   drift %.1f to %.1f ms" % [wall_s, duration_s, _backwards, _drift_min, _drift_max]
	if wall_s >= duration_s:
		_finish()


func _finish() -> void:
	_done = true
	var f := FileAccess.open("user://clock_probe.csv", FileAccess.WRITE)
	if f:
		f.store_string("\n".join(_rows))
		f.close()
	var sorted := _frame_ms.duplicate()
	sorted.sort()
	var p95 := sorted[int(sorted.size() * 0.95)] if sorted.size() > 0 else 0.0
	var summary := "CLOCK PROBE: %d frames, output latency %.1f ms, backwards reads %d, drift %.1f to %.1f ms, frame p95 %.2f ms, csv %s" % [
		_frame_ms.size(), _latency * 1000.0, _backwards, _drift_min, _drift_max, p95,
		ProjectSettings.globalize_path("user://clock_probe.csv")]
	print(summary)
	_label.text = summary.replace(", ", "\n")
	if _quit_when_done:
		get_tree().quit()
