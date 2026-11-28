I've never made a readme, so this is going to be a rough draft for now. 

This repository is meant for personal use. 
It is meant for building a game in Godot 4.x
This is my first project, so, that's all I know to put here.

## Tier 1 prototype: Beat-State and the cadence node

Press Play (F5) in Godot 4.7. `main.tscn` loads `scenes/proto/beat_state_proto.tscn`,
a placeholder room built from the 2026-11-05 design rulings
(`design/decisions/2026-11-05_design-gap-session-1.md`). All shapes, sounds and
numbers are placeholders.

| Keyboard | Gamepad (Xbox) | Action |
|---|---|---|
| A / D or arrows | Left stick or D-pad | Move (locked to the movement plane) |
| Space or W | A | Jump |
| J / K | X / Y | Close / mid attack. The first attack starts Beat-State and its passage; later attacks are graded against the passage |
| Tab | RB | Switch between Vox and Ciphera. Refused, silently, in mid-air and while Beat-State runs. The passage handoff is Tier 1.5, and its flag is off |
| E | B | Interact. As Ciphera near the far wall: reveal the node. As Vox: start the cadence, then answer it on the beat |
| [ and ] | D-pad down / up | Timing calibration, -5 / +5 ms |
| F3 | View | Debug readout of hidden values (stress, pair-bond, growth credits, audio lead) |

The full Tier 1 input map, with the parry, the dodge and pause that the prototype doesn't have yet, is in `CLAUDE.md` (O-01, 2026-11-22).

**Patterns.** Beat-State plays in patterns of four bars. A pattern ends early on two Misses in a
row, on the third Miss in total within it, on environmental damage, or after three beats with no
press, and an early end ends the combo. A pattern played through to its end carries the combo into
the next one, which starts on the following bar. The closing attack picks the next pattern: the
same tier plays the same pattern again, and the other tier switches it up to that tier's passage.
A Miss that doesn't end the pattern pauses the combo: it keeps its number.

**Clock probe.** Phase 5's first measurement scene is `scenes/proto/clock_probe.tscn`.
Run it on the target PC for 20 seconds. It prints a summary and writes
`clock_probe.csv` into the project's user data folder.

**Tests.** From the project folder, with your Godot executable in place of `godot`:

```
godot --headless --import
godot --headless -s tests/run_tests.gd
```

The tests cover the timing windows, the node rules, the pair-bond and Beat-State,
plus an end-to-end smoke test: reveal, switch, answer the cadence, open the gate.
