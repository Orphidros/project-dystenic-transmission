# Open-source rhythm game judgement, conductor and calibration code

Method: files fetched from raw.githubusercontent.com (default branches, 2026-11-05; ITGmania also via a sparse git clone at commit `8a3bf8884acdcb69363f7f0ea592138e398c71e4`). All code claims are [P1]. Line numbers are from the fetched copies and may drift on later commits. Constants are quoted; no code is reproduced beyond one-line formulas.

Not read in depth (see Gaps): Quaver's judging logic, Etterna's scoring maths, StepMania 5 (superseded by ITGmania/Etterna forks), and any Godot-based rhythm engine.

## 1. Judgement windows: real millisecond values per tier, symmetry, scaling

### Takeaway
Every game read publishes its windows in code. They are all symmetric (absolute offset compared to a half-width), 4 to 6 success tiers, with a miss boundary at roughly 135-400 ms. Typical "top tier" is 16-22 ms, "mid" 40-100 ms, outer success window 130-190 ms. Difficulty is a single scalar that interpolates windows (osu! OD, Etterna judge scale) or is a fixed table (ITGmania, Funkin, Quaver). This corrects the "no source publishes window sizes" claim from round 1.

### Cited Findings
Half-widths below mean +/- ms around the note time (the playable range is double).

**osu!** (ppy/osu)
- [P1] `HitWindows.WindowFor` returns the half-width ("+/- milliseconds allowed ... so the actual hittable range is double this"); `ResultFor(timeOffset)` takes `Math.Abs(timeOffset)` and tests tiers from best to worst, so early and late are symmetric — [HitWindows.cs L82-101](https://github.com/ppy/osu/blob/master/osu.Game/Rulesets/Scoring/HitWindows.cs)
- [P1] osu!standard: Great range (80, 50, 20), Ok (140, 100, 60), Meh (200, 150, 100) as (OD0, OD5, OD10) ms; miss window fixed at 400 ms regardless of OD; each value is `Math.Floor(range) - 0.5` — [OsuHitWindows.cs L12-19, L41-43](https://github.com/ppy/osu/blob/master/osu.Game.Rulesets.Osu/Scoring/OsuHitWindows.cs). Worked example (derived): OD5 gives 49.5 / 99.5 / 149.5; OD8 gives 31.5 / 79.5 / 129.5 (OD8 derived by me from the two-piece formula).
- [P1] Scaling formula: two-piece linear, `DifficultyRange(d) = (d-5)/5`; above 5 it moves from mid toward max, below 5 from mid toward min — [IBeatmapDifficultyInfo.cs L57-72](https://github.com/ppy/osu/blob/master/osu.Game/Beatmaps/IBeatmapDifficultyInfo.cs)
- [P1] osu!taiko: Great (50, 35, 20), Ok (120, 80, 50), Miss (135, 95, 70) — [TaikoHitWindows.cs L12-14](https://github.com/ppy/osu/blob/master/osu.Game.Rulesets.Taiko/Scoring/TaikoHitWindows.cs)
- [P1] osu!mania has six tiers: Perfect (22.4, 19.4, 13.9), Great (64, 49, 34), Good (97, 82, 67), Ok (127, 112, 97), Meh (151, 136, 121), Miss (188, 173, 158). A `SpeedMultiplier` rescales windows so they stay constant in real time when track speed changes, and a `DifficultyMultiplier` shrinks or widens them — [ManiaHitWindows.cs L12-17, L58](https://github.com/ppy/osu/blob/master/osu.Game.Rulesets.Mania/Scoring/ManiaHitWindows.cs). Classic mode swaps in fixed values (Perfect 16 ms, Great 34 + 3*(10-OD), and so on) — same file, `updateWindows` (about L127-155).

**Friday Night Funkin'** (FunkinCrew/Funkin)
- [P1] Current scoring system "PBOT1": thresholds in ms of absolute offset: Perfect-score threshold 5, "killer" 12.5 (commented out in the judge switch), Sick 45, Good 90, Bad 135, Shit 160, Miss above 160 — [Scoring.hx L124-160, L164-203](https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/play/scoring/Scoring.hx)
- [P1] Score is a sigmoid of absolute offset (max 500, slope 0.080, midpoint 54.99 ms, min 9, miss -100), so scoring is continuous while the displayed judgement is stepped — same file L99-119, L164-185
- [P1] Hit window for note eligibility is `HIT_WINDOW_MS = 160.0` — [Constants.hx L361](https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/util/Constants.hx)
- [P1] Older systems are percentages of a 10-frame-at-60fps window (166.67 ms): Legacy Sick 20 percent, Good 75, Bad 90, Shit 100; Week 7 Sick 20, Good 55, Bad 80 — Scoring.hx L209-308. Shows the same game moved from a relative window to absolute-ms tiers.

**ITGmania** (default timing windows, also used by Etterna)
- [P1] Defaults in seconds: W1 0.0225, W2 0.045, W3 0.090, W4 0.135, W5 0.180; Mine 0.090, Hold 0.250, Roll 0.500, Checkpoint 0.1664 — [src/Player.cpp L133-165](https://github.com/itgmania/itgmania/blob/release/src/Player.cpp)
- [P1] Effective window = base * `TimingWindowScale` + `TimingWindowAdd` (L295-299). Judgement compares `fSecondsFromExact = abs(fNoteOffset)` to each window (L2461, L2517-2533), so symmetric.
- [P1] Etterna keeps the same base table (W1 22.5 ms through W5 180 ms) but clamps the scale to [0.001, 1.0], clamps each window to a miss-start constant, and keeps mines at a fixed width across judge levels "so increasing judge should not make any element of the game easier" — [Etterna Player.cpp L56-95, L200-235](https://github.com/etternagame/etterna/blob/develop/src/Etterna/Actor/Gameplay/Player.cpp)

**Quaver** (Quaver.API)
- [P1] Defaults: Marvelous 18, Perfect 43, Great 76, Good 106, Okay 127, Miss 164 ms; combo-break judgement is Miss, and a late LN release is judged Good — [JudgementWindows.cs L24-39](https://github.com/Quaver/Quaver.API/blob/master/Quaver.API/Maps/Processors/Scoring/JudgementWindows.cs). Symmetry not confirmed from this file alone.

### Inferences
- A four-tier mapping that matches the code consensus (ms half-widths, derived by me, not a published standard): Perfect about 25-45 ms (Funkin Sick 45, ITG W2 45, Quaver Perfect 43, osu! Great at OD5 about 50), Good about 90-100 ms (Funkin Good 90, ITG W3 90, osu! Ok at OD5 about 100), Poor about 135-160 ms (Funkin Bad/Shit 135/160, ITG W4/W5, osu! Meh up to 150-200), Miss beyond that or when the window closes.
- For a combat game with stamina and cooldowns, expect to want windows wider than genre norms (a rhythm-action hybrid, not a pure rhythm game). Design decision, not a code finding.
- Keep windows in ms in a data resource, with a single `scale` multiplier (ITG/Etterna) or a 0-10 difficulty scalar (osu!). A per-enemy-tier or per-difficulty scale maps naturally onto DT's affinity tiers.
- Symmetry is universal in the code read. An asymmetric early/late window would be a deliberate DT choice with no precedent here.

### Gaps
- No asymmetric early/late window found in any repo read. If DT wants one, there is no code precedent from this sample (not checked: osu!stable closed source, Project OutFox, Malody, Rhythm Doctor).
- Quaver's per-judgement logic, early/late handling and any scaling by rate not read.
- Etterna's J4 and other judge-scale values (the 0.001-1.0 clamp only) not extracted.

## 2. Conductor and clock: song position, smoothing, BPM changes, offsets

### Takeaway
The Funkin Conductor is the most directly portable pattern: a song position derived from the audio clock, eased toward the audio time each frame, with a hard resync past a drift threshold, plus a separate sub-frame timestamp for input. Its offsets are split into instrumental, file-format, global (input) and audio-visual offsets.

### Cited Findings
- [P1] Funkin `Conductor.songPosition` is "the offset between frame time and music time" companion `songPositionDelta` accumulates `elapsed * 1000 * pitch` between audio-position changes and resets when `songPosition` actually changes; `getTimeWithDelta()` returns position + delta for between-frame consumers — [Conductor.hx L105-113, L437-445, L505-525](https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/Conductor.hx)
- [P1] PlayState smooths the clock: if audio time and conductor time differ by at most `CONDUCTOR_DRIFT_THRESHOLD = 65` ms, the conductor lerps toward audio time with ratio `1 - exp(-MUSIC_EASE_RATIO * playbackRate * dt)` where `MUSIC_EASE_RATIO = 42`; above 65 ms it hard-resyncs. The comment says audio position had low-precision steps that made note scrolling stutter, and the earlier approach of guessing from elapsed time was "frame dependent" — [PlayState.hx L726-731, L1165-1185](https://github.com/FunkinCrew/Funkin/blob/main/source/funkin/play/PlayState.hx)
- [P1] Before audio starts, position advances from frame delta (countdown) and begins the song when it reaches start + offset (PlayState L1147-1150).
- [P1] BPM and time-signature changes are a sorted list of time changes each with a timestamp, beat time, BPM and signature; the current change is found by scanning for the last with `timeStamp <= songPosition`, and step time = change beat time * steps-per-beat + (position - change timestamp)/step length. Step, beat and measure hits dispatch signals on change — Conductor.hx L437-500.
- [P1] Offsets: `combinedOffset = instrumentalOffset + formatOffset + globalOffset` (L294-298). `globalOffset` is a user preference described as compensating "input lag"; `audioVisualOffset` is a separate saved option for audio/visual lag (L271-292). Offsets are added to the position when `applyOffsets` is true (L432-433).
- [P1] ITGmania/StepMania: `GlobalOffsetSeconds` default -0.008 (8 ms) in preferences — [PrefsManager.cpp L249](https://github.com/itgmania/itgmania/blob/release/src/PrefsManager.cpp). Per-song offset is stored as `m_fBeat0OffsetInSeconds` in the timing data (AdjustSync.cpp, song autosync branch).
- [P1] osu! stores a per-beatmap offset adjustable in play and a separate global audio offset; the offset control is in [BeatmapOffsetControl.cs](https://github.com/ppy/osu/blob/master/osu.Game/Screens/Play/PlayerSettings/BeatmapOffsetControl.cs). (I did not read the clock class; the GameplayClockContainer path I tried returned 404.)
- [P1] Quaver exposes `GlobalAudioOffset` as "the offset of the notes compared to the song start" — [ConfigManager.cs L259-261](https://github.com/Quaver/Quaver/blob/develop/Quaver.Shared/Config/ConfigManager.cs)

### Inferences
- Godot equivalent of the Funkin pattern (my mapping, to verify in engine): `AudioStreamPlayer.get_playback_position()` plus `AudioServer.get_time_since_last_mix()` minus `AudioServer.get_output_latency()` gives the audio clock; ease a smoothed `song_pos` toward it each `_process`; use a hard-resync threshold like 65 ms. Verify these Godot calls against the 4.7 docs before relying on them (not read in this track).
- Keep the three offsets distinct from the start: chart offset (per track), input offset (calibrates the player's hardware), visual/audio offset (display latency).
- Store the chart in beats plus a time-change list, derive ms through the list (Funkin pattern), so BPM changes in CyberSludge tracks cost nothing extra.
- No explicit handling of a backwards-moving audio clock beyond clamping and the drift resync was found in Funkin. Treat "never let song_pos decrease between frames" as a DT addition.

### Gaps
- osu! clock internals (FramedClock, decoupled clock, offset application) not read.
- No Godot rhythm-game source read in this track.

## 3. Input-to-note matching and miss detection

### Takeaway
Two mature patterns: Funkin queues timestamped presses and judges them next frame against the first eligible note in that lane, with ghost-miss rules; ITGmania searches outward for the closest note in the column and compensates for input age. Misses are declared when the window closes, not when the press fails.

### Cited Findings
- [P1] Funkin: presses are pushed to `inputPressQueue` as precise events with a timestamp (PlayState L454, L2786) and consumed once per frame in `processInputQueue` (L1327, L3023-3115). Candidate notes come from `getNotesMayHit()` (not already hit, `mayHit` true; Strumline.hx L357-366), grouped by lane; the first note in the lane is chosen, de-prioritising "low priority" notes; no note in range means a ghost miss or a free press depending on the ghost-tapping flag.
- [P1] Funkin judges on press time, not frame time: in `goodNoteHit`, offset = `songPosition - note.time - inputLatencyMs`, where latency = now minus the event timestamp in ns (PlayState L3110-3120).
- [P1] Funkin miss rule: a note is flagged missed when `songPosition > strumTime + HIT_WINDOW_MS` (160 ms) in `handleSkippedNotes` (PlayState L2999-3010). Notes enter the render list only if inside `songPosition - 160` (Strumline.hx L580).
- [P1] osu!: `CheckForResult(userTriggered, timeOffset)`: if not user-triggered and `!HitWindows.CanBeHit(timeOffset)` (the offset has passed the widest success window) it applies the minimum result (Miss); if user-triggered it gets `ResultFor(offset)` and only applies it if the hittable check (earlier notes must be judged first, else shake) passes — [DrawableHitCircle.cs L137-175](https://github.com/ppy/osu/blob/master/osu.Game.Rulesets.Osu/Objects/Drawables/DrawableHitCircle.cs). `CanBeHit` is defined in HitWindows.cs L109 as `timeOffset <= WindowFor(LowestSuccessfulHitResult())`.
- [P1] ITGmania: `GetClosestNote(col, row, rowsAhead, rowsBehind, allowGraded)` searches both directions and returns the nearer; the search distance is derived from the widest window (`GetMaxStepDistanceSeconds` adds `MaxInputLatencySeconds`, L3460-3470). Press time is reconstructed: the step is placed at current music time minus time-since-step, and offset = (note time - that time) / music rate (Player.cpp L2427-2450). Notes older than the max step distance are marked missed in `UpdateTapNotesMissedOlderThan` (L1281). A `JudgedRows` helper ensures each row is judged once (L72).
- [P1] ITG chords: rows are judged as a unit; a row's grade is the worst of its columns (stated by the use of a per-row judged flag and per-row result in Player.cpp; I did not read the full row-scoring function, so treat the "worst of columns" detail as [S]-level inference from the structure).
- [P1] ITG holds have their own forgiveness windows (Hold 250 ms, Roll 500 ms): the player may release and re-press within it — Player.cpp L133-165.
- [P1] Quaver has a distinct LN-miss judgement (`LNMissJudgement = Good`) so a bad release is not a full break — JudgementWindows.cs L39.

### Inferences
- DT's "sequence of presses" is closer to a short chord/pattern per encounter beat than to a multi-lane stream. The cleanest rebuild: a beat map of "slots" (each slot has a beat time and an expected input set), a per-frame queue of timestamped presses, and a judge that, per slot, picks the nearest unjudged slot within the outer window (ITG-style), grades by `abs(offset)`, and closes the slot (miss) once `song_pos > slot_time + outer_window` (Funkin/osu-style).
- Use Godot `InputEvent` timestamps via `Time.get_ticks_usec()` at `_input` entry and convert to song time at judge time, subtracting the elapsed gap (Funkin/ITG both reconstruct press time rather than using frame time). Verify the exact Godot event timing behaviour in 4.7 before relying on it.
- A multi-press slot needs an explicit rule the code gives no single answer to: ITG lets each column be graded separately inside a row; osu!mania and Funkin judge each lane independently. DT must decide whether a "chord slot" grades on the worst press, the first, or the last.

### Gaps
- Funkin's hold-note and ITG's full chord-row grade function not read line by line.
- No source read for wrong-key penalties beyond Funkin's ghost-miss flag.

## 4. Calibration: offset wizards and auto-calibration

### Takeaway
Two real algorithms: osu! suggests an offset from the median hit error, damped by unstable rate; ITGmania auto-sync averages 24 offset samples and applies them only if the standard deviation is under 30 ms.

### Cited Findings
- [P1] osu! `BeatmapOffsetControl`: needs at least 50 "timed" hit events (`AffectsUnstableRate`) from a reference score; suggested offset = `currentOffset - median * exp(-0.0116 * (UR - 90))` when UR >= 90 (cutoff 90), else `currentOffset - median` — [BeatmapOffsetControl.cs L264, L371-384](https://github.com/ppy/osu/blob/master/osu.Game/Screens/Play/PlayerSettings/BeatmapOffsetControl.cs). The code comment links the author's discussion of the curve (ppy/osu discussion 30521, cited in the code, not read).
- [P1] ITGmania `AdjustSync::AutosyncOffset`: mean and stddev over `OFFSET_SAMPLE_COUNT = 24` samples; applies only `if (stddev < .03f)`; for machine autosync adds the mean to `GlobalOffsetSeconds`, for song autosync adds it to the song and each chart's `m_fBeat0OffsetInSeconds`; a result is announced as applied or not applied — [AdjustSync.cpp L194-228](https://github.com/itgmania/itgmania/blob/release/src/AdjustSync.cpp), [AdjustSync.h L45](https://github.com/itgmania/itgmania/blob/release/src/AdjustSync.h)
- [P1] ITGmania also has a dedicated "sync machine" gameplay screen (ScreenGameplaySyncMachine.cpp) that runs a calibration song and compares new and old global offset (L138-139), and a tempo autosync using least squares (AdjustSync.cpp L238-291).
- [P1] Funkin exposes `globalOffset` and `audioVisualOffset` as separate user settings with separate meanings (Conductor.hx L271-292); I did not locate its calibration UI code.

### Inferences
- A DT calibration step can be about 20 lines of GDScript: play a click track, collect N taps (24 and a 30 ms stddev gate are the ITG constants), reject noisy runs, set `input_offset += mean`. A second pass measures the audio-visual offset with a flash-and-beep test. An osu!-style post-fight suggestion (median error with a noise discount) can run in the background against the growth-credit/hit log DT already plans to keep. The hit log (offset per judged slot) is the data both algorithms need, so record `signed_offset_ms` per slot from day one.

### Gaps
- Funkin's offset-calibration UI source and Etterna's equivalents not located.
- No evidence read on how these tools handle Bluetooth or variable latency.

## 5. Licences and reuse

### Takeaway
Reading is unrestricted; copying is not. MIT and Apache-2.0 allow reuse with notice. GPL-3.0 (ITGmania) cannot be used in a closed commercial game. MPL-2.0 (Quaver) is file-level copyleft. The recommendation is to rebuild the patterns in GDScript and port no code.

### Cited Findings
- osu! (ppy/osu): MIT; the LICENCE file begins "Copyright (c) 2025 ppy Pty Ltd" and the source headers say "Licensed under the MIT Licence" — [LICENCE](https://github.com/ppy/osu/blob/master/LICENCE). Permits reuse including commercial, with copyright and licence notice retained. The licence covers code only; osu! name, skins and branding are not part of it (my note; not in the file).
- Friday Night Funkin': the repository licence file states the source code is Apache 2.0, "Copyright 2020-2024 The Funkin' Crew Inc." — [LICENSE.md](https://github.com/FunkinCrew/Funkin/blob/main/LICENSE.md). Permits commercial reuse with notice, a NOTICE-file carry-over and a patent grant. The file I read has more sections than I read in full; I did not check how it treats art and music assets, so assume assets are excluded until verified.
- ITGmania: GPL-3.0 (LICENSE file header "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007") — [LICENSE](https://github.com/itgmania/itgmania/blob/release/LICENSE). Copying code into a distributed game would require releasing it under GPL-3.0.
- Etterna: MIT, "Copyright (c) 2016-2023 Etterna" — [LICENSE](https://github.com/etternagame/etterna/blob/develop/LICENSE). Note Etterna derives from StepMania; the LICENSE I read is MIT, but I did not audit whether inherited StepMania-derived files carry different terms, so do not copy without checking each file.
- Quaver and Quaver.API: Mozilla Public License 2.0 — [Quaver LICENSE](https://github.com/Quaver/Quaver/blob/develop/LICENSE), [Quaver.API LICENSE](https://github.com/Quaver/Quaver.API/blob/master/LICENSE). File-level copyleft: modified MPL files must stay MPL, which is awkward to combine with a GDScript port.

### Inferences
- Numbers and algorithms (window sizes, an exponential ease, "mean of 24 taps under 30 ms stddev") are ideas and facts about timing, but I am not giving legal advice. The safe route is to implement from the descriptions here in original GDScript, credit the sources as inspiration in a credits file, and avoid line-by-line translation of ITGmania (GPL) and Quaver (MPL) in particular.

### Gaps
- Not a legal review; third-party assets and trademarks in each repo are not covered.

## Borrow / Adapt / Enhance / Avoid

| Item | Verdict | Tier | Note |
|---|---|---|---|
| Windows as ms half-widths in a data resource, symmetric, one scale scalar | Borrow | T1 | osu!, ITG, Etterna all do it |
| Four tiers from about 45/90/135-160 ms plus miss, tunable | Adapt | T1 | Funkin and ITG anchors; widen for action combat after playtest |
| Funkin-style eased song clock with 65 ms hard resync | Adapt | T1 | Needs Godot audio-clock calls verified in 4.7 |
| Press-timestamp reconstruction instead of frame time | Borrow | T1 | Funkin, ITG both do it |
| Slot-based beat map judged by nearest-unjudged-within-window; close on window end | Adapt | T1 | For DT input sequences; chord-grading rule is a DT decision |
| Calibration: 24 taps, stddev < 30 ms gate, apply mean | Borrow | T1 | Plus signed-offset hit log |
| osu!-style post-fight offset suggestion (median with UR damping) | Enhance | T2 | Reuses growth-credit log |
| Sigmoid continuous score alongside stepped judgement | Adapt | T2 | Funkin PBOT1; useful for pair-bond and growth-credit weighting |
| Porting ITGmania or Quaver code | Avoid | n/a | GPL-3.0 and MPL-2.0 |
| Asymmetric early/late windows | Avoid unless wanted | T3 | No precedent found |

## Design questions this raises for DT
1. Judge scale per enemy: should window width change with enemy affinity tier or difficulty setting (osu! OD style), or stay fixed with only damage/stamina consequences varying? (Judgement evaluator, affinity tiers.)
2. Chord slots: when an encounter slot needs two or more presses, is it graded on the worst press, the first, or the last, and is a mistimed partner a Poor or a Miss? (Input-sequence recognition.)
3. Ghost presses: does pressing with no note nearby cost anything (Funkin ghost miss) given the costed dodge and stamina pool? (Input handling, stamina.)
4. Offsets: does DT expose separate input and audio-visual offsets and a first-launch calibration (ITG 24-tap gate), or ship one slider? (Settings, calibration, accessibility.)
5. Window-close rule: is a missed slot declared when song time passes the outer window (Funkin/osu!), and does that also fire the "missed note" choice tone, or are combat misses separate from the choice-tone system? (Judgement, narrative tones.)
6. What does the growth-credit and pair-bond log record per slot (tier only, or signed ms offset), given that calibration suggestions and later tuning need the signed value? (Growth-credit log, hidden pair-bond integer.)
