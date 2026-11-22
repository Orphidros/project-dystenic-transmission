# Decision records: 2026-11-22, the flag pass's First items for Systems & Code

Compiled by the Systems & Code thread on 2026-11-22 from the Project's records (the Systems & Code diary, 2026-11-22), under the rule that every ruling the author makes, in any thread, gets a record here (OQ-068). The Project's canon documents stay the authority; where this file and they differ, they win.

The flag pass opened on 2026-11-21 (OQ-180; the Design thread's record, `2026-11-21_flag-pass-gate.md`, committed with this change). These are the author's answers to the First items of the author decision docket (the weekly All-Threads file of 2026-11-16, §3) that rest with Systems & Code. Two others were settled earlier: `CLAUDE.md`'s update on this branch (OQ-050; commits `d694f32` and `d65309a`), and the mirror and decision-record practice (OQ-068; 2026-11-20, recorded in `2026-11-21_rulings-2026-11-09-to-2026-11-21.md`). The last, the author's playtest and clock probe on his PC (OQ-189), waits for this change.

## 2026-11-22 (00:08 ET)
- **Godot 4.7.2 is DT's engine** for Phase 0 and Tier 1 (OQ-181). It is the second 4.7 maintenance release (2026-08-18), with no known incompatibilities with 4.7.1. Moving to 4.8 is a separate, later question. Thread: Systems & Code. Recorded in: the Systems & Code diary, 2026-11-22. Code: `CLAUDE.md` (this change); `project.godot`'s feature tag stays "4.7".
- **The renderer is Forward+, with Direct3D 12 on Windows** (OQ-182), as `project.godot` already sets it. If D3D12 misbehaves at the author's first PC playtest, the Windows driver switches to Vulkan. Thread: Systems & Code. Recorded in: the Systems & Code diary, 2026-11-22. Code: `CLAUDE.md` (this change); `project.godot` unchanged.
- **The prototype's run is not Phase 0** (OQ-051). Phase 0 still certifies the Blender-to-Godot pipeline on the real crate before Phase 1. Thread: Systems & Code. Recorded in: the Systems & Code diary, 2026-11-22. Code: none.
- **What Phase 0 installs** (OQ-137): dt-godot v0.6.0, on this branch, and the prototype's folders (`scripts/`, `scenes/`, `tests/`) become the convention dt-godot documents. Thread: Systems & Code, with Skill Development. Recorded in: the Systems & Code diary, 2026-11-22. Code: not yet; Phase 0's run.
- **The Tier 1 input map** (O-01), the gate before Phase 1 code. Gamepad (Xbox names), then keyboard:

  | Action | Gamepad | Keyboard | Note |
  |---|---|---|---|
  | Move | Left stick, D-pad | A/D, arrows | |
  | Jump | A | Space, W | |
  | Close attack | X | J | |
  | Mid attack | Y | K | |
  | Interact; the node's answer | B | E | |
  | Switch | RB | Tab | |
  | Parry | LB | L | Graded on the beat; a counter is any attack in the opening after it |
  | Dodge | RT | Shift | Costs stamina |
  | Pause | Menu | Esc | |
  | Debug overlay | View | F3 | Dev builds only (`dev_tools`) |
  | Calibration | — | — | A slider in the options menu |

  LT, both stick clicks and the right stick are free for later. Light, heavy and directional variants and button combinations wait for Tier 1.5's move set. Thread: Systems & Code. Recorded in: the Systems & Code diary, 2026-11-22. Code: `CLAUDE.md` and the comment above the prototype's provisional bindings (this change); Phase 1 writes the map into `project.godot`.

## Not decided here
- Moving to Godot 4.8.
- The parry's windows and the counter's timing (Phase 4, with the Basic Bot).
- `main`'s `CLAUDE.md`, which still carries Session 0's file. It follows the decision on the prototype and the phases, after the playtest.
