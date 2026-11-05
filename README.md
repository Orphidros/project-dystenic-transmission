I've never made a readme, so this is going to be a rough draft for now. 

This repository is meant for personal use. 
It is meant for building a game in Godot 4.x
This is my first project, so, that's all I know to put here.

## Tier 1 prototype: Beat-State and the cadence node

Press Play (F5) in Godot 4.7. `main.tscn` loads `scenes/proto/beat_state_proto.tscn`,
a placeholder room built from the 2026-11-05 design rulings
(`design/decisions/2026-11-05_design-gap-session-1.md`). All shapes, sounds and
numbers are placeholders.

| Key | Action |
|---|---|
| A / D or arrows | Move (locked to the movement plane) |
| Space | Jump |
| J / K | Close / mid attack. The first attack starts Beat-State and its passage; later attacks are graded against the passage |
| Tab | Switch between Vox and Ciphera (ground only). During Beat-State the passage hands off at the same phase |
| E | Interact. As Ciphera near the far wall: reveal the node. As Vox: start the cadence, then answer it on the beat |
| [ and ] | Timing calibration, -5 / +5 ms |
| F3 | Debug readout of hidden values (stress, pair-bond, growth credits, audio lead) |

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
