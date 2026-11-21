# Coding Patterns Notebook: entries from 2026-11-21

Staged for the Coding Patterns Notebook in the dt-godot skill (its "Practice" handbooks). That skill sits in `.claude/skills/dt-godot/` on the Windows machine and isn't in this checkout, so these entries wait here. Copy them in, then delete this file.

Each entry covers one pattern used in the 2026-11-21 change: the CoD-11 flag, the switch refusal, the growth-log check and the new tests.

---

## Feature flag: keep the code, switch the behaviour

**What it is.** One true/false setting decides whether a piece of behaviour runs. The code for that behaviour stays in place. It just doesn't run while the setting is off.

**Where in DT.** `beat_state_handoff_enabled` in `scripts/proto/beat_state_proto.gd`. When it's off, a switch during Beat-State is refused. When it's on, the old CoD-11 handoff runs exactly as before.

**Why.** CoD-11 moved to Tier 1.5, but its code works and is tested. Deleting it would mean rewriting it later. A flag lets you park it safely.

**In Godot.** `@export` makes the variable a checkbox in the Inspector. Select the BeatStateProto node and you can tick it without touching code.

**Watch out.**
- Name flags for what they turn on.
- Default them to the Tier 1 rule.
- Test both settings, or the "off" path quietly rots.

## Guard clause: refuse early, change nothing

**What it is.** A check at the top of a function that returns straight away when a request isn't allowed. The rest of the function only ever sees valid requests.

**Where in DT.** `_switch()` checks two things before switching anyone:
- "on the ground?"
- "Beat-State running and handoff off?"

A refused switch returns before any state changes. "Silent" means it returns without a message, a sound or a state change.

**Why.** Each rule is a single readable line, and there's no way to half-switch.

**Watch out.** Put the cheapest, most common refusals first. Keep each guard about one rule.

## Ask the system, don't copy its state

**What it is.** Don't keep your own "switching is locked" variable. Ask the system that knows: `beat_state.active`.

**Where in DT.** The switch refusal reads `beat_state.active` every time. When Beat-State ends, on a Miss or an idle gap, the next switch request is accepted automatically. No timer or extra flag has to be reset.

**Why.** Two copies of the same fact drift apart. That's how you get bugs like "switching stays locked after a Miss".

**Watch out.** This works when the question is cheap to ask. If it ever becomes expensive, cache the answer and update it in one place.

## Append-only log with a derived tally

**What it is.** Record every event as it happens, and never edit or delete entries. Totals, like growth credit, are worked out from the records by one rule.

**Where in DT.** `GrowthLog.record()` writes every judged input with six fields: grade, signed offset in ms, offset applied, context, character and chain index. It writes them to memory and to `user://growth_log.jsonl`. Credit is counted only when `RhythmWindows.is_credit()` says the grade is Perfect or Good (CoD-01; author, 2026-11-20).

**Why.** The raw log can answer questions nobody has asked yet, such as calibration suggestions, tuning or pair-bond thresholds. The tally rule can change without losing data.

**Watch out.**
- Log what actually happened, including Misses.
- Keep the anchor attack out, because it's not judged.

## One rule, one function

**What it is.** A rule used in more than one place lives in a single small function, and everything calls it.

**Where in DT.** `RhythmWindows.is_credit(grade)` decides "Perfect or Good" for both the growth log and the pair-bond. `NodeRules.resolve()` holds all of CoD-05 and CoD-06.

**Why.** When the author changes a ruling, you change one line. Tests can check the rule directly, without building a scene.

**Watch out.** Keep these functions pure: same input, same output, no side effects. They're much easier to test that way.

## Testing through the scene, with injected timestamps

**What it is.** Tests load the real scene and call its own methods, such as `_attack()`, `_switch()` and `_interact()`, instead of faking key presses. Timing tests pass exact timestamps, such as "anchor + half a beat", rather than relying on a human's timing.

**Where in DT.** `tests/run_tests.gd`:
- `_spawn_proto()` waits 90 physics frames so the characters land before switching. Switching is ground-only.
- The switch tests end Beat-State both ways: with a deliberate Miss, and by waiting out the idle gap.

**Why.** The tests are repeatable and exercise the same code the game runs. They also run headless, with no window, so any session can verify a change.

**Watch out.**
- Wait for physics before checking anything physical.
- Free the scene between tests, so one test's state can't leak into the next.

**Command.** `godot --headless --import` once, then `godot --headless -s tests/run_tests.gd`.

## Safe bulk rename with a word-boundary search

**What it is.** When renaming tags across many files, match the exact tag shape and nothing else, then check what's left.

**Where in DT.** The CoD re-tag replaced `D-01` to `D-16` with `CoD-01` to `CoD-16` in `scripts/` and `tests/`, using the pattern `\bD-(0[1-9]|1[0-6])\b`. The `\b` word boundary means it won't match inside `CoD-05`, so running it twice changes nothing. Genre Bible tags like `D-1` don't match it either.

**Why.** A loose search-and-replace corrupts things you didn't mean to touch.

**Watch out.** Always grep afterwards for leftovers, and look at the diff before committing.
