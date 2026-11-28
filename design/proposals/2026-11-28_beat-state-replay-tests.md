# Proposal: replay tests for Beat-State

**From:** a Claude Code session, 2026-11-28 (CoD-17) · **For:** the Systems & Code thread · **Status:** a proposal, not a ruling

## The idea, borrowed from rea-games

rea-games (MIT, github.com/erkamyaman/rea-games, studied at commit `f070a83`) proves that a game behaves the same way twice with four steps:

1. **Record a case:** every input, every random number the game drew (its *tape*), and the full state after each step (its *trace*).
2. **Write the spec:** a GAME.md with the constants, the order of operations inside one step, the formulas and the known quirks.
3. **Replay:** a runner reads a case, feeds the same inputs to the code under test, and prints the trace it gets.
4. **Compare exactly:** the first difference is printed with its path, for example `trace[412].tRex.yPos: 46 != 45.5`.

Its rules are worth keeping:
- Traces come only from running the code. Never write one by hand.
- No tolerance in the comparison unless the spec says why and how much.
- Fix the code, not the case.
- Break the code on purpose three ways and watch the check fail. A check that can't fail proves nothing.

Its Godot 2048 runner is about 20 lines. It reads a case on stdin, steps the game, and prints `{trace, tapeUsed}`.

**What DT would not take:** its purpose. rea-games rebuilds other people's games, which DT's originality rule rules out. DT uses only the method, and only on its own code: to catch any change that alters behavior nobody ruled on, and to replay a playtest bug exactly.

## Why Beat-State needs it

Beat-State's rules are now intricate:
- patterns and their bar lines;
- the closing attack and Switch-ups;
- two in a row against third in total, and the combo pause;
- enemy hits;
- the idle gap.

Each was ruled on a different day (CoD-07, amended 2026-11-21). Today's 110 tests check single situations. Replay cases would check whole recorded fights, step by step, and every future change would have to reproduce them exactly, or come with the ruling that changed them.

## What it needs in DT

1. **A clock seam.** `BeatState` reads the real clock (`Time.get_ticks_usec()`) and the audio lead (`AudioServer`, through `MusicDirector`) directly. Both differ on every run, and headless runs mix in uneven 0–90 ms chunks.
   - Give `BeatState` a small clock object. In play, it answers with the real time and the real lead. In a replay, it answers with the recorded values.
   - This is rea-games' "replace the clock with a fake you step by hand". The production behavior doesn't change.
2. **A recorder.** A node beside `BeatState` writes each call it receives, with its arguments:
   - `on_attack(press_usec, character, tier)`, `on_enemy_hit(type)`, `on_environmental_damage()`, `hand_off()`;
   - one `step(now_usec, lead_usec)` per frame;
   - the settings at the start: tempo, `pattern_bars`, `idle_gap_beats`, the windows, calibration and the handoff flag.

   After each entry it writes a snapshot:
   - `active`, `character`, `tier` and `chain`;
   - `pattern_number`, both miss counts, `last_grade` and `last_offset_ms`;
   - the sorted judged beats;
   - the signals emitted in that step;
   - the growth-log entry written in that step.

   Presses are already stamped in `_input`, so the case holds exactly what `BeatState` saw.
3. **A case file**, gzipped JSON: `{name, recorded_at, commit, rulings, settings, inputs, trace}`.
   - `rulings` lists the IDs the behavior rests on (for example `CoD-07 (amended 2026-11-21)`), which ties into the traceability rule.
   - Gameplay randomness doesn't exist yet. When it arrives (enemy AI, the chain-5 critical odds), record its numbers as a tape, as rea-games does, so a change in how many are drawn shows up.
   - The noise in the placeholder audio and the rig light's flicker are cosmetic. They get a separate random stream that never enters a case.
4. **A runner**, `tests/replay/run_cases.gd`. Headless Godot 4.7.2 replays every case through a fresh `BeatState` on the fake clock, compares field by field, and prints the first difference with its path. It's added to `tests/run_tests.gd` as one more check, so existing commands still run everything.
5. **A spec:** `docs/behavior/beat_state.md`, Beat-State's GAME.md. It covers:
   - the order of operations in one frame (pattern clock, then idle gap) and in one press (nearest unplayed beat, then completion, then grade);
   - every constant;
   - what isn't modelled (the audio itself) and why that can't change a trace.

   Each line cites its ruling.
6. **The break-it-on-purpose check.** Once, when the harness lands and again whenever cases are added, change three things and confirm each makes the runner fail with a trace difference, not a crash:
   - the miss total (3 → 4);
   - the Good window (90 → 85 ms);
   - the bar-line arithmetic, off by one bar.

## Where the cases come from

- **Scripted cases** turn today's test sequences into recordings:
  - the author's two miss sequences;
  - a Switch-up, an early downbeat and an idle gap at 2.9 and 3.1 beats;
  - hit-then-Miss.
- **Edge cases:** frame rates of 30, 60 and 144 fps; a 50 ms hitch next to a bar line; an audio lead that swings like the headless driver's; a 100-pattern run to catch drift.
- **Playtest cases.** When the author plays on the PC and says a fight felt right, its recording becomes a golden case.
- **When a ruling changes behavior on purpose,** the affected cases are recorded again in the same commit. Their `rulings` field then names the new ruling, so the diff shows why the expected behavior changed.

## Cost and placement

- **Size:** about a day's work for one agent session: the clock seam, the recorder, the runner and about ten scripted cases. The spec takes longer, because it's mostly gathering the decision records into one place.
- **Phase:** Phase 5 (the rhythm evaluator), before Phase 4's Basic Bot wires the damage hooks, so the hooks arrive under test.
- **CI is optional:** the repository's placeholder GitHub Actions workflow could run the suite headless on every push. rea-games does exactly that with Godot.

## Questions for the author

1. **The clock seam.** Is it acceptable in `BeatState` itself, with play using the real clock? Or must it wait for the `dev_tools` module? It isn't a developer switch: nothing in play can turn it.
2. **Golden cases.** Which playtest recordings become golden: every fight you mark as felt right, or only ones you pick?
3. **Where cases live.** The repository is public. A recording holds only button timings and game state, nothing personal. Should cases be committed (gzipped, as rea-games does), or kept out of the repository?
4. **CI.** Should a GitHub Actions run be set up later, on Linux with headless Godot 4.7.2?
