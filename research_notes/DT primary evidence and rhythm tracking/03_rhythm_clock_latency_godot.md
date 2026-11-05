# Godot 4.7 rhythm clock and latency chain for DT (audio clock, input capture, frame timing, Windows audio, feedback scheduling, Phase 5 measurement)

Scope notes. Target is PC, Windows, D3D12, AMD RX 5700 XT. No Godot binary was available, so **nothing here was run**. Every statement marked "(inference)" is my reasoning from source and is untested. Source was read at the `4.7.1-stable` tag (fetched copies of `core/input/input.cpp`, `input_event.h`, `main/main.cpp`, `platform/windows/os_windows.cpp`, `display_server_windows.cpp`, `drivers/wasapi/audio_driver_wasapi.cpp`, `servers/audio/audio_server.cpp`, `modules/vorbis/audio_stream_ogg_vorbis.cpp`, plus `doc/classes/*.xml`). Tags: [P1] source/official docs/developer-authored; [P2] developer quoted; [S] secondary. Line numbers refer to the 4.7.1-stable files. This extends, and does not repeat, the prior survey's findings (hardware-clock vs system-clock methods, 15 ms default, 512-sample floor, Android 165 ms report, Rhythm Quest/osu!/Clone Hero calibration pointers, BPM's 10 ms recalibration and 80 ms latency assumption). Prior survey line 64 says the 512 buffer "sets a floor of about 11 ms"; confirmed below.

## 1. Input timing: do Godot 4.7 InputEvents carry timestamps, and what is the effective resolution?

### Takeaway
**No. InputEvent has no timestamp field**, and the Windows backend never forwards the OS message time on the key path, so the only usable timestamp is the moment your script sees the event. On Windows that moment is **once per main-loop iteration, at frame start**, so input-timestamp error is up to one frame interval (16.7 ms at 60 Hz, 6.9 ms at 144 Hz) and cannot be reduced by `use_accumulated_input`, `_input` vs `_unhandled_input`, or agile flushing. Polling in `_physics_process` adds a second quantisation at the physics tick.

### Cited Findings
- [P1] `InputEvent.xml` (4.7.1) lists only `device`, action/pressed/echo helpers, `accumulate`, `xformed_by`, etc. There is no timestamp member or method. A grep of `core/input/input_event.h` for "timestamp" returned nothing. The base class carries only a device id (and event ID, per the 4.2 docs tutorial) — [InputEvent.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/InputEvent.xml); [input_event.h](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/core/input/input_event.h)
- [P1] On Windows, `OS_Windows::run()` loops `DisplayServer::process_events()` then `Main::iteration()` — [os_windows.cpp ~L2349-2356](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/platform/windows/os_windows.cpp)
- [P1] `DisplayServerWindows::process_events()` drains the Win32 queue with `PeekMessageW`/`DispatchMessageW`, then calls `_process_key_events()` and `Input::flush_buffered_events()`. So every key, mouse and pad event reaches GDScript at that one point in the frame — [display_server_windows.cpp L4224-4249](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/platform/windows/display_server_windows.cpp)
- [P1] The Win32 message timestamp (`GetMessageTime`) appears in `display_server_windows.cpp` only for pen double-click logic (L5948-5952); my grep found no use of it on the key/mouse/pad path, so the OS-side event time is discarded (grep-level evidence, I did not read every handler). Same file, link above.
- [P1] `Input::parse_input_event` with `use_accumulated_input` true pushes events to `buffered_events` and tries `accumulate()` with the previous one; with it false and agile flushing off, events go straight to `_parse_input_event_impl` — [input.cpp L1549-1557](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/core/input/input.cpp). Only `InputEventMouseMotion` and `InputEventScreenDrag` implement `accumulate` (grep of `input_event.cpp`: L1031, L1536), so **key and pad button events are never merged**. Accumulation is irrelevant to keyboard timing.
- [P1] Docs: accumulation "limits the number of input method calls per second to the rendering FPS"; disabling it gives "slightly more precise/reactive input" at CPU cost — [Input.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/Input.xml). The Godot jitter/stutter page repeats that `set_use_accumulated_input(false)` makes `_input` run on every event — [Jitter, stutter and input lag](https://docs.godotengine.org/en/4.7/tutorials/rendering/jitter_stutter.html)
- [P1] `input_devices/buffering/agile_event_flushing` (default false) flushes "just before every idle and physics frame"; the docs state "Currently implemented only on Android" — [ProjectSettings.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/ProjectSettings.xml). `Main::iteration` does call `flush_buffered_events()` before each physics step and before `process` when the flag is set (main.cpp L4969, L5051), but on Windows events are already flushed in `process_events()` ahead of the iteration, so the flag has nothing left to flush mid-frame (inference).
- [P1] Order inside `Main::iteration`: physics steps first (`_physics_process`), then `process` (`_process`). Both run after `process_events()` delivered `_input`, so the whole frame sees one input snapshot — [main.cpp L4925-5075](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/main/main.cpp)
- [P1] `physics_ticks_per_second` doc: "Input can also become less responsive at low tick rates as there can be a gap between input being registered, and the response on the next physics tick." — ProjectSettings.xml link above
- [P1] No godot-proposals thread or PR for input-event timestamps was found. A GitHub issue search was blocked in this environment (GraphQL and repo API refused) and the web searches returned none. The only hit was a forum user stamping events with `Time.get_ticks_msec()` inside `_input` — [forum thread](https://forum.godotengine.org/t/how-to-allow-others-to-set-the-timestamping-method-for-a-input-signaling-class/137479) [S]. Treat "no proposal exists" as unverified.

### Inferences
- Effective timestamp = `Time.get_ticks_usec()` read in `_input` = frame-start dispatch time. True press time is earlier by a uniformly distributed 0 to (one frame interval, plus time spent blocked in present/vsync) if the app was busy. A constant average offset (about half a frame) is absorbed by calibration; the uniform spread (±half a frame, std dev ≈ interval/√12 ≈ 4.8 ms at 60 Hz, 2 ms at 144 Hz) is irreducible without raw timestamps.
- Because the loop blocks in present/frame limiting, key presses wait in the Win32 queue until the next `process_events()`. If a frame hitches (shader compile, GC-like spikes, asset load), judgement error grows to that hitch length. Frame hitches therefore matter more than any input setting.
- Recommendation: capture presses in `_input` (not `_unhandled_input`, which only adds UI/GUI routing), stamp `Time.get_ticks_usec()` immediately, and judge on that stamp. Never judge from `_physics_process` polling (adds up to 16.7 ms at 60 Hz). Leave accumulation at default; setting it false has no benefit for key presses on Windows, but cost is low if wanted for mouse. Skip agile flushing (Android-only per docs).
- A real fix for sub-frame accuracy would be a GDExtension reading raw input with QPC stamps on its own thread. That needs a native build, so it is outside T1 (GDScript, standard build). Log it as a T2+ option only if Phase 5 shows input jitter dominates the budget.

### Gaps
- Whether Windows keyboard events are delivered faster than the main loop via any other thread: not seen, but I did not read all of `display_server_windows.cpp`.
- USB keyboard/pad polling latency and Windows input-stack latency: no source found; must be measured (Phase 5).
- Gamepad path (SDL joypad, `joypad_sdl->process_events()` is called at the top of `process_events`) was not read in detail; assumed same frame-start quantisation.

## 2. Frame timing: V-Sync, frame pacing, physics ticks, interpolation, tick sources

### Takeaway
Frame interval is the unit of input-to-judgement and judgement-to-visual error. For a rhythm game on a fixed-refresh Windows display, the lowest-latency supported options are V-Sync on with an FPS cap just under refresh (formula from the docs), double-buffered swapchain only if frames are consistently on time, physics interpolation OFF for anything judged, and `Time.get_ticks_usec()` (QPC-based) as the single time source.

### Cited Findings
- [P1] `Time.get_ticks_usec/msec` are monotonic; the docs say to use them "for precise time calculation" and warn the `_from_system` methods follow the user-settable system clock — [Time.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/Time.xml)
- [P1] `OS_Windows::get_ticks_usec()` uses `QueryPerformanceCounter` minus a start value; the OS init calls `timeBeginPeriod` so `Sleep(n)` is not coarse — [os_windows.cpp L286-306, L986-993](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/platform/windows/os_windows.cpp)
- [P1] The Windows FPS limiter sleeps in multiples of the timer resolution then busy-waits the remainder; "low processor usage mode" uses a relaxed sleep with "worse frame pacing" — os_windows.cpp L2640-2672 (same link). `Engine.max_fps` is applied there, so a cap does not rely on V-Sync.
- [P1] `Main::iteration` stamps `_frame_ticks = get_ticks_usec()` at iteration start and feeds the main timer sync; `physics_jitter_fix` default 0.5 smooths the real-time vs in-game clock; "values of 0 or less" keep ticks synchronised; jitter fix is auto-disabled when physics interpolation is on — [main.cpp L4917-4934](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/main/main.cpp); ProjectSettings.xml
- [P1] Docs on input lag: physics interpolation "will increase input lag for behavior that depends on the physics tick" and this matters for "fixed-framerate genres like fighting and rhythm games". Higher physics tick rates reduce latency, multiples of refresh suggested (120/180/240). V-Sync off lowers lag but tears. Preferred where supported: V-Sync on with VRR and an FPS cap below refresh — [Jitter, stutter and input lag](https://docs.godotengine.org/en/4.7/tutorials/rendering/jitter_stutter.html)
- [P1] FPS cap formula `r - (r*r)/3600.0` (58 FPS at 60 Hz, 138 at 144 Hz) for V-Sync Enabled on VRR monitors — [ProjectSettings.xml `application/run/max_fps`](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/ProjectSettings.xml)
- [P1] `rendering/rendering_device/vsync/swapchain_image_count` default 3; double-buffering "may give you the lowest lag" but with V-Sync on a missed frame drops the rate in multiples (30, 15 FPS); triple buffering costs "up to 1 frame of latency"; `frame_queue_size` default 2 (read only at startup) — ProjectSettings.xml link above
- [P1] Godot's own sync doc lists the visual side: "Graphics APIs display two or three frames late" and TVs add processing delay — [sync_with_audio.rst, 4.7 branch](https://raw.githubusercontent.com/godotengine/godot-docs/4.7/tutorials/audio/sync_with_audio.rst) (flagged `article_outdated`)

### Inferences
- Display-side latency (render queue plus swapchain plus monitor scanout) is a **visual-offset** problem separate from audio. Judgement should be against audio-clock time; visuals should be drawn at `song_time + visual_offset` where the offset is calibrated per player. Rhythm Quest makes the same split: audio-visual offset is the main calibration target and effects can be pre-scheduled, but visuals cannot be pre-scheduled "without jarring rewinds" — [Rhythm Quest devlog 10](https://rhythmquestgame.com/devlog/10.html) [P1 for that game's dev].
- Candidate settings for a rhythm encounter (untested): V-Sync Enabled; `max_fps` = refresh − refresh²/3600 only if VRR is in use, otherwise leave uncapped under V-Sync; swapchain 3 initially, test 2; `physics_ticks_per_second` 120 (a multiple of 60/120/240 Hz displays) if CPU allows; `physics_interpolation` off for DT's judged elements, or, if DT needs it for character smoothness, keep judged logic and visuals (note-lines, rings, hit flashes) out of interpolated nodes via `physics_interpolation_mode` per branch (doc'd per-node control, ProjectSettings.xml). CLAUDE.md's plane-locked CharacterBody3D movement is physics-tick driven, so this split matters for DT.
- Rhythm-judged **animation timing** (attack contact frames) should read `song_time`, not physics ticks, so animation does not drift when ticks batch.

### Gaps
- Actual RX 5700 XT + D3D12 swapchain latency in 4.7.1: no documented figure; measure (camera test).
- Whether `swapchain_image_count=2` is stable under DT's scenes: untested.
- Windows 11 DWM / fullscreen-optimization effects: only the generic note in the jitter page (windowed vs exclusive fullscreen "OS and driver behavior") — no numbers.

## 3. Audio clock: get_time_since_last_mix, get_time_to_next_mix, get_output_latency, WASAPI in 4.7, get_playback_position

### Takeaway
On Windows, Godot's clock helpers are wall-clock stamps taken when the audio thread starts producing a 512-frame chunk, and `get_output_latency()` is a value computed once when the device opens (not a live measurement). So `song_time` can be reconstructed to a few ms of jitter, but the **absolute offset** to what the player hears is only as good as the WASAPI-reported latency, which excludes hardware/Bluetooth/driver delays (inference). DT must keep a measured per-device offset on top of the engine figure.

### Cited Findings
- [P1] `update_mix_time()` stores `_last_mix_frames = p_frames` and `_last_mix_time = get_ticks_usec()` when the driver calls `audio_server_process`; `get_time_since_last_mix()` = now − `_last_mix_time`; `get_time_to_next_mix()` = (last_mix_frames / mix_rate) − time since — [audio_server.cpp L74-105](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/servers/audio/audio_server.cpp). Both take the driver mutex (`lock()/unlock()`).
- [P1] The WASAPI thread holds the same lock while it calls `audio_server_process(buffer_frames, ...)` — [audio_driver_wasapi.cpp L744-760](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/drivers/wasapi/audio_driver_wasapi.cpp)
- [P1] `AudioServer` mixes in a hardcoded `buffer_size = 512`, with a comment that this "limits audio latency to an absolute minimum of 11ms with default mix rate" and refers to TODOs — audio_server.cpp L1528-1531.
- [P1] WASAPI is **shared mode only** in this driver (`AUDCLNT_SHAREMODE_SHARED`; "Since we're using WASAPI Shared Mode we can't control any of these"). If `IAudioClient3` is available (Windows 10+, output only), the driver computes `desired_period_frames = target_latency_ms * mix_rate / 1000`, snaps it to a multiple of the engine's fundamental period, clamps to the min/max period, and calls `InitializeSharedAudioStream`; `real_latency = current_period_frames / sample_rate`. If that fails it falls back to `IAudioClient`, with `buffer_frames = GetBufferSize()` and `real_latency = GetStreamLatency()` — [audio_driver_wasapi.cpp L286-310, L405-480](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/drivers/wasapi/audio_driver_wasapi.cpp). The setting is read from `Engine::get_audio_output_latency()` (L595).
- [P1] `get_latency()` just returns the stored `real_latency` (L611-613). The AudioServer doc says the returned value "will differ depending on the operating system and audio driver" and "can be expensive" — [AudioServer.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/AudioServer.xml). `audio/driver/output_latency` doc: if the host cannot honour it Godot uses "the nearest latency allowed by the host. As such you should always use get_output_latency to determine the actual" value, and "this setting is ignored on Android" — ProjectSettings.xml.
- [P1] The WASAPI thread writes a chunk only when the device buffer has room (`GetCurrentPadding`), handles `AUDCLNT_E_DEVICE_INVALIDATED`, and re-inits the device when the "Default" device changes or a new `output_device` is chosen (L765-900). That is the point where `real_latency` is refreshed.
- [P1] `get_playback_position()` on `AudioStreamPlayer` returns the position of the most recently started playback (float), via `AudioServer::get_playback_position` → `stream_playback->get_playback_position()` (`audio_stream_player_internal.cpp` L296-302; `audio_server.cpp` L1462-1475). For Ogg Vorbis it is `frames_mixed / sampling_rate`, i.e. quantised to mixed chunks — [audio_stream_ogg_vorbis.cpp L253-255](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/modules/vorbis/audio_stream_ogg_vorbis.cpp).
- [P1] Official guidance: position "will increment in chunks"; adding `get_time_since_last_mix()` and subtracting output latency "may be a bit jittery"; discard values lower than the previous frame; system-clock method "recommended" for songs of a few minutes. The hardware method "will work for songs of any length" — [sync_with_audio.rst](https://raw.githubusercontent.com/godotengine/godot-docs/4.7/tutorials/audio/sync_with_audio.rst) (article flagged outdated).
- [P1] Open issue #38215 "AudioServer::get_output_latency() and audio output latency setting are inaccurate" (labels bug, topic:audio; open; added to Audio Issue Triage project 2026-05-20, "For team assessment"). Reporter: `get_output_latency()` returns the same value regardless of buffer size. A Jan 2021 comment: the PulseAudio driver caches the first latency value. A May 2026 comment confirms the hardcoded mix buffer is 512, not 1024. No comment is Windows-specific; no linked fix PR — [issue 38215](https://github.com/godotengine/godot/issues/38215).
- [S] Unity precedent for chunked position: `AudioSource.time` updated every 21-22 ms (default 1024-sample DSP buffer); the author smooths it by advancing a local clock with frame delta and correcting toward the reported value, hard-snapping at a 30 ms error, bleeding off smaller error slowly (0.05 and 0.01 per second in the post's code; comments in that post disagree with its own values). Also found stopwatch drift up to ~30 ms over 50 s on his setup — [itch.io post](https://itch.io/blog/744936/the-right-way-to-interpolate-the-audio-playback-time-unity)
- [S] Hit and jump effects in Rhythm Quest are "prescheduled to play on time", the tap-test warning "we can never measure a single type of latency by itself" (already in prior survey), plus Rhythm Doctor's two-phase calibration: audio/video sync first, then an input tap test mirroring gameplay (the "seventh beat tap test") — described by the Rhythm Quest dev, i.e. second-hand for Rhythm Doctor — [Rhythm Quest devlog 10](https://rhythmquestgame.com/devlog/10.html). I found no Rhythm Doctor developer-authored post on latency and no Exceed7 Native Audio research page (see Gaps).

### Inferences
- Resolution of the stamp: 512 frames = 10.67 ms at 48 kHz (11.6 ms at 44.1 kHz). `get_time_since_last_mix()` fills in between chunks, but the stamp is taken on the audio thread when the chunk **starts being produced**, not when it is queued to the device or heard. The time between the stamp and the device actually consuming that chunk is hidden inside the "latency" number. If `GetCurrentPadding` shows the buffer full, the thread loop may hold the chunk for a while (not measured).
- The position and time-since-mix reads are not atomic. If a mix lands between the two reads, you get ±one chunk (up to 10.7 ms) of jitter, in one direction depending on read order. Read `time_since_last_mix` first and position second (or the reverse) consistently, and run a filter. Detect chunk boundaries by watching position change and re-anchor there. Discard-if-lower alone is insufficient (it hides the jitter downward only).
- `real_latency` is assigned only in device init (L420-425, L469-474), so it is a snapshot (supports the PulseAudio caching report as a general pattern; I did not read the other drivers). It is the shared-mode engine period or stream latency, not a measured round trip. It will not include Bluetooth codec delay, USB DAC buffers, or driver extras. Expect a residual error on headphones/BT that only a calibration screen captures.
- Re-read `get_output_latency()` on device change. The WASAPI driver re-inits on default-device change, but there is no signal to GDScript; poll `AudioServer.output_device` and `get_output_latency()` every few seconds (cheap enough per the doc, "not every frame") and flag a recalibration prompt when either changes.
- Design: use a **hybrid clock**. A system-clock anchor `(ticks_usec_at_play, expected position)` gives smooth, queryable-at-any-instant time (essential, since the input timestamp arrives from `_input` at a different instant from `_process`); correct that anchor slowly from the hardware estimate `pos + time_since_last_mix − latency`, with a hard resync above ~30 ms (candidate threshold). This covers both docs methods, handles songs of any length, and gives a monotonic song time without discarding samples.
- `get_playback_position()` returns `float` (32-bit): at 300 s the spacing is ~3e-5 s, fine; at hours, not an issue for DT.
- `AudioStreamInteractive` returns 0.0 for position (prior survey); so for adaptive music keep the anchor-based clock re-anchored at each clip transition.

### Gaps
- Real WASAPI shared-mode numbers on the RX 5700 XT PC's audio device (period size from `IAudioClient3`, `real_latency` actual, hot-swap behaviour): not available without running Godot; run the Phase 5 `ClockProbe` with `--verbose` (the driver prints "selected a period frame size" and "calculated latency" lines, L457-461, L539).
- No Windows-specific issue was found in the tracker (issue-search APIs were blocked; one web search found none). Absence is unverified.
- Exceed7 "Native Audio" latency science: I did not locate a primary page; only the Asset Store listing with vendor-reported old-iOS figures (iPod Touch 5th gen 94.6 → 58.8 ms) came up ([listing](https://assetstore.unity.com/packages/slug/107067)) [S]. Not usable for the Windows budget.
- osu! developer writing on latency (beyond the Offset Wizard already in the prior survey) was not re-fetched in this round.

## 4. Feedback scheduling: low-latency hit sounds, AudioStreamPolyphonic, scheduling on the beat

### Takeaway
Godot 4.7.1 cannot start a sound at a future audio time; every `play()` / `play_stream()` takes effect at the next 512-frame mix plus output latency. A scheduled-play API (`play_scheduled`, an absolute audio clock) exists only as an **open, unmerged PR (#107226)**. For DT, player-triggered hit sounds are fine via a pre-loaded pool or `AudioStreamPolyphonic`; enemy on-beat cues should be fired early by a computed lead time, or baked into a music/cue stem.

### Cited Findings
- [P1] `AudioStreamPlaybackPolyphonic.play_stream(stream, from_offset=0, volume_db=0, pitch_scale=1.0, playback_type, bus)` returns an int id; `set_stream_volume/pitch`, `stop_stream`, `is_stream_playing` use that id. `AudioStreamPolyphonic` has `polyphony` (default 32) — [AudioStreamPlaybackPolyphonic.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/AudioStreamPlaybackPolyphonic.xml); [AudioStreamPolyphonic.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/AudioStreamPolyphonic.xml). There is no start-time argument.
- [P1] `AudioStreamPlayer` methods in 4.7.1: `play`, `seek`, `stop`, `get_playback_position`, `get_stream_playback`, `has_stream_playback`; no scheduled play — [AudioStreamPlayer.xml](https://raw.githubusercontent.com/godotengine/godot/4.7.1-stable/doc/classes/AudioStreamPlayer.xml). Godot's sync doc: after `play()` "sound will not begin immediately, but when the audio thread processes the next chunk"; "This delay can't be avoided but it can be estimated" by `get_time_to_next_mix()` — sync_with_audio.rst.
- [P1] godot-proposals #1151 (scheduled playback) was the origin; PR #105510 ("Implement audio absolute time (DSP time) and scheduled play") was closed unmerged 2025-06-06, superseded by **#107226**, which is **open**, milestone 4.x, no approving review shown, last visible activity Sept 2026 (a comment) and review July 2026. API in the PR: `ScheduledAudioStreamPlayer`(/2D/3D), `play_scheduled`, `AudioStreamPlaybackScheduled`, `get_absolute_time()`. Stated problems: the absolute time divides by mix rate so it can jump on device change; silence frames are mixed for every queued sound (~190 FPS with 1000 queued sounds); a `stop()` can truncate a fade-out — [PR 105510](https://github.com/godotengine/godot/pull/105510), [PR 107226](https://github.com/godotengine/godot/pull/107226). Not in 4.7.1-stable.
- [P1] The PR #105510 author's own workaround note, from a commenter: pad samples with silence and offset playback position (bonjorno7, June 2025) — same PR page. The PR also said `Time.get_ticks_usec()` "is not synced to mix steps".
- [P1] The prior survey's "pre-scheduled feedback sounds" candidate is therefore not available natively in 4.7.1; it can only be approximated (below).

### Inferences
- Playing latency for a hit sound = time to next mix (0-10.7 ms, uniformly) + output latency (15 ms default setting, nominal) ≈ 15-26 ms at defaults. Jitter is ±5 ms from the chunking alone. Keep sounds short, **pre-loaded** (`preload()`/load at scene start so no decode or disk on first hit), and in memory-resident formats (WAV or short Ogg; decode cost for Ogg per play is unmeasured). `AudioStreamPolyphonic` avoids node churn and `AudioStreamPlayer` per-sound scene-tree overhead; a pool of N players is the alternative. No latency difference between the two was found in docs (untested).
- Because judgement happens after the press, hit sounds are reactive and cannot be pre-scheduled anyway. The prescheduling Rhythm Quest uses applies to **auto** sounds (metronome ticks, enemy telegraph beats). In Godot, approximate by firing at `target_song_time − (output_latency + mean time_to_next_mix)`, evaluated each frame, so jitter is ≤ frame interval + 10.7 ms. For tight cue sounds (tens of ms), bake them into a dedicated cue stem started in the same frame as the music (both `play()` calls are consumed in the same mix step in my reading, inference) so they are sample-locked.
- A missed-hit must not silence the music or stem layers (prior survey candidate): keep miss feedback on a separate bus.
- Track #107226; if it merges in a 4.8+ build, `get_absolute_time()` would replace the system-clock anchor. Don't plan T1 around it.

### Gaps
- No measurement of Godot's actual `play()`-to-speaker latency on Windows; Phase 5 S4 below.
- Whether `AudioStreamPolyphonic` plays at the same mix step as a plain player: not documented.
- Sample-playback type (`playback_type`) is marked experimental in 4.7.1 (AudioStreamPlayer.xml) and the PR notes that scheduled play does not support samples; not relevant to Windows desktop stream playback, left alone.

## 5. Measurement methods used elsewhere and how they transfer

### Takeaway
Shipped rhythm games separate **audio-video offset** from **input latency**, calibrate both per device with tap tests, and accept player-set offsets. Godot gives you no way to read the physical chain, so DT needs external loopback measurements for development and an in-game tap calibration for players.

### Cited Findings
- [P1 dev-authored] Rhythm Quest: tap test measures audio+input (or video+input) latency together; subtracting the audio and visual taps gives the A/V offset; standard practice is about 10 taps discarding min and max; tap feedback must not play sounds; Rhythm Doctor splits calibration in two phases, A/V sync then an input tap test that mirrors gameplay (the "seventh beat tap test") — [devlog 10](https://rhythmquestgame.com/devlog/10.html). Rhythm Doctor's claim is second-hand; I found no Rhythm Doctor developer post.
- [P1] Android reference method (not Godot): round-trip latency measured with a loopback dongle and a native low-latency API (Pixel XL, Android 8.0, 18 ms at 48 kHz/192 frames) — [AOSP latency measurements](https://source.android.com/devices/audio/latency_measurements). Shows the standard external loopback approach; not a Windows figure.
- [P1] Godot's own list of delay sources: chunked mixing, mix-to-play delay, "graphics APIs display two or three frames late", TV processing — sync_with_audio.rst.
- [S] BPM (via prior survey) recalibrates when the clock difference exceeds 10 ms and assumes player latency under 80 ms; no published windows in any surveyed game.

### Inferences
- Measurement ladder: (1) **software-only** clock/frame logging (free); (2) **acoustic loopback**: record the keyboard's physical click (or a contact mic on the key) and the game's speaker/line-out on two channels of one recorder, so key-to-sound latency is read on one timeline; (3) **high-speed camera** (240 fps phone, 4.2 ms per frame) filming key and monitor for key-to-photon; (4) in-game tap test for what the human actually experiences. (2) and (3) are standard practice but I did not find a Godot-specific write-up; untested for DT hardware.

### Gaps
- No Rhythm Doctor or osu!-lazer developer-authored latency article found; Exceed7 original articles not located.
- No Godot-specific loopback-test write-up found.

## 6. End-to-end pipeline spec and error budget

### Takeaway
Pipeline: audio clock → song position → beat map → input timestamp → judgement → feedback. Per-stage random error sums to roughly **±10-12 ms (95th percentile, candidate)** at 60 Hz on a good Windows setup, dominated by input quantisation and mix chunking; constant offsets (output latency, display, input) are absorbed by calibration. All numbers below are candidates derived from source reading, not measurements.

### Cited Findings
Every row rests on findings in sections 1-4; no new sources.

| # | Stage | What the engine does [P1] | Error type | Candidate budget (95th pct, untested) | Mitigation |
|---|---|---|---|---|---|
| 1 | Audio clock | 512-frame chunks (10.7 ms @48 kHz); `_last_mix_time` from audio thread; mutex shared with the mix | random (chunk + non-atomic reads) | ±3 ms after filtering (raw ±10.7) | hybrid clock, monotonic filter |
| 2 | Song position → heard time | `real_latency` computed once at device open; shared mode only | constant per device, plus unmodelled hardware/BT delay | residual ≤ ±8 ms after calibration (device-dependent) | per-device offset, re-prompt on device change |
| 3 | Beat map | none (script data) | authoring only | 0 for runtime; keep times as float64 seconds or int µs | derive from DAW tempo map; round-trip test |
| 4 | Input timestamp | dispatch at frame start in `process_events`; no OS time | random: uniform over frame interval + hitch | ±half frame: ±8.3 ms @60 Hz, ±3.5 ms @144 Hz; +hitch | high refresh, no hitches; judge in `_input` |
| 5 | Judgement | pure GDScript compare of stamp vs beat time | none | <0.1 ms | integer microsecond math |
| 6 | Feedback (audio) | next mix + output latency; no scheduling | random 0-10.7 ms | ±5.3 ms jitter on hit sounds | pre-loaded pool, lead-time for auto cues |
| 7 | Feedback (visual) | rendered next frame + swapchain queue (1-3 frames) | constant + ±frame | calibrate visual offset | visual offset setting; physics interp off on judged nodes |

### Inferences
- Judging window width must exceed the random sum. 95th percentile random error root-sum-square of rows 1, 4, 6 at 60 Hz is √(3² + 8.3² + 5.3²) ≈ 10.3 ms at 60 Hz, ≈ 6.7 ms at 144 Hz (my arithmetic on candidate inputs). A Perfect window narrower than ±(2 × that) would punish engine noise rather than the player; this is a design input, not a recommendation of specific windows (no surveyed game publishes windows).
- Judgement stays on the **audio-clock side** of the pipe: `judged_delta = (input_ticks_usec − anchor_usec) / 1e6 + anchor_song_time − beat_time − player_input_offset`.

### Gaps
- All budget rows are estimates from source reading. Phase 5 must replace them.

## 7. Slot-in design for dt_beat_map.gd, dt_rhythm_log.gd and the GD-Agentic conductor/latency calibrator

(The scripts are not in this repo; I could not read their APIs. This is an interface proposal, to be reconciled when they are opened. Prior survey notes they exist and that dt-godot encodes older document versions.)

- **Clock service** (`DTClock`, autoload): owns the anchor, exposes `song_time_at(ticks_usec) -> float` and `now_song_time()`. Inputs: the conductor (or a thin wrapper around `AudioStreamPlayer.play()` that records `ticks_usec`, `time_to_next_mix`, `output_latency` at play), plus per-frame `_process` hardware estimate. The GD-Agentic conductor should become a *client* of this or be adapted to emit the same fields. Check whether the conductor uses the discard-lower approach or a filter.
- **Beat map**: `dt_beat_map.gd` supplies `beat_to_seconds(beat)` and `next_events(song_time)`; must accept tempo changes if DAW export has them (prior survey).
- **Input capture**: single `_input` handler stamps `ticks_usec` and queues `(action, ticks_usec)`; judgement runs immediately on stamp (not deferred to `_process`), so `_process` jitter does not matter.
- **Calibrator**: applies two offsets, `audio_visual_offset` and `input_offset` (Rhythm Doctor two-phase split), both persisted per output device name from `AudioServer.output_device`.
- **Rhythm log** (`dt_rhythm_log.gd` schema unknown): keep these fields per judged event, so Phase 5 data and the growth-credit and pair-bond logs can reuse the same stream: `frame`, `ticks_usec_input`, `ticks_usec_frame_start`, `song_time_hw_est`, `song_time_anchor`, `anchor_correction_ms`, `beat_time`, `delta_ms`, `tier` (Perfect/Good/Poor/Miss), `output_latency`, `time_since_last_mix`, `output_device`, `refresh_hz`, `physics_tps`, `frame_dt_ms`. The growth-credit log (Perfect and Good hits, T1) and the hidden pair-bond integer should read tiers from this same record rather than re-timing anything.
- Pseudocode (untested, GDScript idea only): anchor at `play()`: `anchor_usec = Time.get_ticks_usec(); anchor_song = -(AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())`. Each `_process`: `hw = player.get_playback_position() + AudioServer.get_time_since_last_mix() - latency`; `err = hw - song_time_at(now)`; if `abs(err) > 0.030` snap, else `anchor_song += err * k` with small `k` (candidate). Use `Time.get_ticks_usec()` for `now`.

## 8. Phase 5 measurement plan and candidate pass/fail thresholds

### Takeaway
Six small scenes, run on the actual RX 5700 XT PC with every output device DT might meet (speakers/wired headphones/BT), each producing CSV from the rhythm log; pass/fail numbers below are candidates to be revised after the first run.

### Cited Findings
(plan; grounded in sections 1-6. The measurement-method ladder is from section 5.)

**Scenes** (each a minimal scene, GDScript, headless-safe where noted):
- **S1 ClockProbe** (no gameplay): play a 5 min stem; per frame log `ticks_usec`, frame dt, `get_playback_position`, `get_time_since_last_mix`, `get_time_to_next_mix`, `get_output_latency`; compute both docs methods and the hybrid. Run vsync on/off, 60 and 144 Hz, windowed/fullscreen. Also print the driver's `--verbose` WASAPI lines.
- **S2 InputStampProbe**: human taps along to a metronome; log `_input` stamps; compare `_input` vs `_physics_process` polling vs `use_accumulated_input` true/false to confirm no difference for keys (confirms section 1). Optionally a camera/contact-mic rig for ground truth.
- **S3 LoopbackKeySound**: key press → immediate hit sound via (a) one `AudioStreamPlayer`, (b) pool of 8, (c) `AudioStreamPolyphonic`; record physical key click and speaker output on two channels; 100 presses each.
- **S4 FrameStress**: S1 plus synthetic hitches (a 30, 60, 100 ms busy-wait at random) to see judgement error growth and anchor recovery.
- **S5 DeviceSwap**: hot-swap output device (speakers ↔ wired ↔ BT) mid-run; log `output_device`, `get_output_latency()` before and after; test that re-calibration prompt triggers.
- **S6 CalibrationScreen**: two-phase tap test (A/V then input, Rhythm Doctor style), 10 taps each, min/max trimmed; three repeats per device.

**Candidate thresholds** (all untested guesses to calibrate against, not facts):
- Clock: filtered `song_time` monotonic, zero backward steps; filtered jitter (std dev of hybrid minus hardware estimate) ≤ 3 ms; hybrid-vs-hardware drift over 5 min ≤ 5 ms without resync; zero hard resyncs at steady state.
- Frames: p99 frame time ≤ 1.25 × refresh interval during encounter scenes; no frame > 2 × interval in a 5 minute run.
- Input: dispatch-to-physical (S2 camera/mic) mean stable across runs to ±3 ms, std dev ≤ interval/√12 + 1 ms (≈ 5.8 ms @60 Hz).
- Hit sound: key-to-speaker median ≤ 40 ms on wired/speakers at 15 ms setting, std dev ≤ 5 ms; BT is reported, not gated.
- Calibration: repeat spread (three runs) ≤ 8 ms; residual after calibration p95 ≤ 10 ms.
- Overall: system-attributable judged-delta error p95 ≤ 12 ms at 60 Hz (matches section 6 estimate), ≤ 8 ms at 144 Hz.

### Inferences
- If S3 shows hit-sound latency above ~50 ms, try lowering `audio/driver/output_latency` (cost: CPU/crackle per docs) and compare `real_latency`; the 512-frame mix floor still holds (audio_server.cpp L1528).
- If S2 shows input jitter dominating, consider the native raw-input option (section 1) at T2.

### Gaps
- Exact schema of `dt_rhythm_log.gd` and the calibrator's API unknown here; thresholds need the author's sign-off.

## Design questions this raises for DT

1. **Judgement windows (rhythm combat / tiers).** The system noise floor is roughly ±7-10 ms. Should Perfect and Good windows be fixed numbers, scale with measured per-device jitter from calibration, or scale with difficulty?
2. **Input sequences (combos on the beat).** Press timestamps have frame-interval resolution. Should a sequence be recognised by per-press windows only, or may DT add a short "chord" grace (e.g. one frame) when two presses must be simultaneous (2-character combination attacks, later)?
3. **Physics-tick vs song-time animation (CharacterBody3D, attack animation).** Attack hit-frames driven by `song_time` rather than physics ticks mean animation and movement can disagree for a frame. Does DT accept that, or require physics interpolation and its extra tick of latency?
4. **Enemy beat-locking (O-52).** With no scheduled playback, enemy telegraph sounds fire with ±(frame + 10.7 ms) jitter unless baked into a cue stem. Should telegraph audio live in the stems (lower jitter, less dynamic) or be triggered at runtime (flexible, looser)?
5. **Calibration and device change (settings/onboarding).** Will DT ship a mandatory first-run two-phase calibration, store it per output device, and prompt again when the device changes (Bluetooth being the worst case)? Is a "gamepad vs keyboard" offset also needed?
6. **Refresh and cap policy (options menu).** Should DT lock the target presentation to V-Sync on with a cap formula, offer an uncapped lower-latency mode, or expose physics ticks (e.g. 120) as a setting? This trades CPU against input error and affects non-60 Hz monitors.

## Borrow / Adapt / Enhance / Avoid

| Item | Verdict | Tier | DT system | Basis |
|---|---|---|---|---|
| Godot docs' hardware-clock + system-clock methods | Adapt (hybrid anchor with slow correction) | T1 | Rhythm evaluator clock | sync_with_audio.rst; Unity smoothing post [S] |
| `Time.get_ticks_usec()` as sole time source | Borrow | T1 | Input stamp, logging | Time.xml; QPC in os_windows.cpp |
| Stamp in `_input` on arrival | Borrow (only option) | T1 | Input capture | no event timestamps; Windows flushes in `process_events` |
| `use_accumulated_input=false`, agile flushing | Avoid as a timing fix | T1 | Input capture | no key-merging; agile is Android-only |
| Physics-tick polling for judgement | Avoid | T1 | Judgement | one extra tick of quantisation; docs warn on interpolation |
| Per-device offsets + two-phase tap test | Borrow (Rhythm Doctor/Rhythm Quest pattern) | T1 | Calibrator | devlog 10 |
| Re-reading `get_output_latency()` on device change | Enhance (poll output_device, prompt recalibrate) | T1 | Calibrator, options | WASAPI init-time latency |
| Pre-loaded polyphonic/pool hit sounds | Adapt | T1 | Feedback | no scheduled play in 4.7.1 |
| Cue stems for telegraph audio | Enhance | T1.5 | Enemy beat-lock | no scheduling; same-frame start |
| `play_scheduled` / `get_absolute_time()` (#107226) | Avoid depending on it | T2 | Feedback | open, unmerged |
| Native raw-input extension with QPC stamps | Avoid for now (log as option) | T3 | Input capture | needs GDExtension build |
| Physics interpolation on judged nodes | Avoid | T1 | Movement/visuals | doc: adds input lag |
