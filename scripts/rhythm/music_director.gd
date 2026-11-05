class_name MusicDirector
extends Node
## Plays the encounter track, the area sound and Beat-State's drone (D-07, D-10).
## When Beat-State starts, the track and ambience pitch-drop, filter down and duck,
## and a low drone rises underneath. The music never stops.

@export var bpm: float = 100.0

var output_latency_s: float = 0.0
var track_player: AudioStreamPlayer
var ambience_player: AudioStreamPlayer
var drone_player: AudioStreamPlayer
var _bus_fx: Dictionary = {}  # bus name -> {"pitch": AudioEffectPitchShift, "lowpass": AudioEffectLowPassFilter}
var _tween: Tween


func _ready() -> void:
	_setup_bus("Music", true)
	_setup_bus("Ambience", true)
	_setup_bus("Drone", false)
	# The docs call this expensive, so read it once (round 2: it's a snapshot taken at device open anyway).
	output_latency_s = AudioServer.get_output_latency()
	track_player = _make_player(PlaceholderAudio.track(bpm), "Music", -6.0)
	ambience_player = _make_player(PlaceholderAudio.ambience(), "Ambience", -14.0)
	drone_player = _make_player(PlaceholderAudio.drone(), "Drone", -80.0)
	track_player.play()
	ambience_player.play()
	drone_player.play()


func beat_seconds() -> float:
	return 60.0 / bpm


## The encounter track's position as heard, using the hardware-clock method.
func track_time() -> float:
	var t := track_player.get_playback_position() + AudioServer.get_time_since_last_mix() - output_latency_s
	return maxf(t, 0.0)


## Microseconds from calling play() to the sound being heard. There is no scheduled
## playback in 4.7.1, so new sounds start at the next mix plus output latency.
func audio_lead_usec() -> int:
	return int((AudioServer.get_time_to_next_mix() + output_latency_s) * 1_000_000.0)


## Rhythmic Focus begins: the track pitch-drops into a low drone foundation.
func enter_focus() -> void:
	_fade(0.6, 450.0, -10.0, -8.0, 0.25)


func exit_focus() -> void:
	_fade(1.0, 20000.0, 0.0, -80.0, 0.45)


func _fade(pitch: float, cutoff: float, duck_db: float, drone_db: float, dur: float) -> void:
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	for bus: String in ["Music", "Ambience"]:
		var fx: Dictionary = _bus_fx[bus]
		_tween.tween_property(fx["pitch"], "pitch_scale", pitch, dur)
		_tween.tween_property(fx["lowpass"], "cutoff_hz", cutoff, dur)
		var idx := AudioServer.get_bus_index(bus)
		_tween.tween_method(func(db: float) -> void: AudioServer.set_bus_volume_db(idx, db),
			AudioServer.get_bus_volume_db(idx), duck_db, dur)
	_tween.tween_property(drone_player, "volume_db", drone_db, dur)


func _setup_bus(bus_name: String, with_fx: bool) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		idx = AudioServer.bus_count
		AudioServer.add_bus(idx)
		AudioServer.set_bus_name(idx, bus_name)
		AudioServer.set_bus_send(idx, "Master")
	if not with_fx:
		return
	if AudioServer.get_bus_effect_count(idx) >= 2:
		_bus_fx[bus_name] = {"pitch": AudioServer.get_bus_effect(idx, 0), "lowpass": AudioServer.get_bus_effect(idx, 1)}
		return
	var pitch := AudioEffectPitchShift.new()
	var lowpass := AudioEffectLowPassFilter.new()
	lowpass.cutoff_hz = 20000.0
	AudioServer.add_bus_effect(idx, pitch)
	AudioServer.add_bus_effect(idx, lowpass)
	_bus_fx[bus_name] = {"pitch": pitch, "lowpass": lowpass}


func _make_player(stream: AudioStream, bus: String, db: float) -> AudioStreamPlayer:
	var p := AudioStreamPlayer.new()
	p.stream = stream
	p.bus = bus
	p.volume_db = db
	add_child(p)
	return p
