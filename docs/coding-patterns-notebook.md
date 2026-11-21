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

---

*Entries added 2026-11-21: the Beat-State miss rule, gamepad bindings, per-session logs and ruling citations.*

## Counting in a row against counting in total

**What it is.** Two counters for the same event. One counts how many happened **in a row**, and resets whenever something else happens in between. The other counts how many happened **in total**, and resets only when the whole episode ends.

**Where in DT.** `BeatState` keeps `misses_in_a_row` and `misses_total`.
- A Perfect, Good or Poor sets `misses_in_a_row` back to 0.
- `misses_total` only resets when Beat-State starts again.
- Beat-State ends at 2 in a row (`"two_in_a_row"`) or 3 in total (`"third_miss"`), per CoD-07 as amended 2026-11-21.

The author's examples:
- Start, Good, Miss, Poor, Miss, Good, Miss never has two in a row, but reaches three in total, so it ends on the third.
- Start, Good, Miss, Miss ends on two in a row.

**Why.** "In a row" catches a player who has lost the beat. "In total" caps how sloppy a whole run can get. Each counter answers a different question, so you need both.

**Watch out.** Decide which counter wins when both trip on the same input. Here, two-in-a-row is checked first. Reset both at the start of each Beat-State, or a fresh run starts already half-failed.

## One action, many devices: the InputMap

**What it is.** Godot's InputMap gives each control a name, such as `dt_jump`, and lets you attach any number of physical inputs to that name: keys, gamepad buttons, stick directions. Game code only ever asks about the name, for example `is_action_pressed("dt_jump")`.

**Where in DT.** `ensure_actions()` in `scripts/proto/beat_state_proto.gd` attaches:
- the keyboard keys (`ACTIONS`);
- the provisional gamepad buttons (`PAD_BUTTONS`);
- the left stick (`PAD_AXES`), with a 0.3 **deadzone**: stick movement under 30% is ignored, so a resting thumb doesn't drift the character.

A gamepad press goes through the same `_input()` function as a key press, so it's timed the same way. The bindings are provisional, because the real layout is the input map's (O-01).

**Why.** Changing the controls never touches gameplay code. When O-01 settles the layout, only the binding lists change.

**Watch out.**
- Set `device = -1` on gamepad events so any connected controller works.
- Add events only if they're missing (`action_has_event`), so running the setup twice doesn't double-bind.

## Never overwrite a log

**What it is.** Each run writes a new file whose name includes the date and time. If that name is already taken, it adds `_2`, `_3` and so on. The first line of the file is a **header** saying when the session started and which Godot version ran it.

**Where in DT.** `GrowthLog.new_session_path()` builds names like `user://growth_log_2026-11-21_14-05-09.jsonl`. `_ready()` writes the header line. Each later line is one judged input, with the same fields as before.

**Why.**
- Playtest data is evidence. The pair-bond thresholds and the growth-log schema both wait on it (OQ-056).
- Overwriting last night's session with today's would destroy the very thing you're collecting.
- The header tells you later which build produced the numbers.

**Watch out.**
- Check whether the file exists *before* opening it for writing. Opening a file for writing creates it, which is what makes the second same-second session pick `_2`.
- `user://` is Godot's per-user data folder. On Windows it's under `%APPDATA%\Godot\app_userdata\<project name>\`.

## Comments that cite rulings

**What it is.** When a piece of code exists because of a design ruling, its comment names the ruling's ID. If the ruling was later changed, the comment gives the amendment date, for example `CoD-07, amended 2026-11-21`.

**Where in DT.** These all carry IDs now:
- `beat_state.gd`: the end rule, the idle gap and the handoff;
- `node_rules.gd`: the time-critical grace, CoD-06 and OQ-A07;
- `growth_log.gd` and `rhythm_windows.gd`: CoD-01 and OQ-067;
- the prototype controller: OQ-066, OQ-A10 and O-01.

Each record in `design/decisions/` lists the files and the commit that carry it, so you can go from a bug to its ruling and from a ruling to its code.

**Why.** Months from now, "why does a single Miss not end Beat-State?" has an answer you can look up. Without it, someone "fixes" the code back to the old rule.

**Watch out.**
- Use only the existing prefixes: CoD-, OQ-, O- and FLAG-.
- A build decision that isn't a ruling gets labelled as a build call, with its date, not a made-up ID.
