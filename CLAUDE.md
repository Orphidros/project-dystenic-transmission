# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Project

Dystenic Transmission — a Godot 4 game. This is the developer's first Godot
project and first game project overall, so explain engine-specific concepts
rather than assuming familiarity with Godot conventions.

## Engine

- Godot **4.7.2**, pinned by the author on 2026-11-22 (OQ-181). Forward+ renderer
  (`config/features` in `project.godot`).
- Physics: **Jolt Physics** (`3d/physics_engine="Jolt Physics"`).
- Windows rendering driver: D3D12. Forward+ with D3D12 on Windows is the author's choice (OQ-182),
  with Vulkan as the fallback if D3D12 misbehaves.
- No `godot`/`godot4` binary is on PATH in this environment — to run or
  headless-check the project, ask the user for their Godot executable path
  rather than assuming one, or have them run it via the editor.

## Architecture: 2.5D plane-locked CharacterBody3D

Characters are `CharacterBody3D` nodes in real 3D space, but gameplay is
locked to a single movement plane — a 2D side-scroller staged in 3D, not a
free-roaming 3D game:

- Pick one axis as the locked depth axis (conventionally Z) and hold it
  constant for player-controlled movement. Input and physics should never let
  a character drift off that axis.
- The camera is set up so the locked axis reads as "depth" (side-view or
  3/4 view), while models, animation, and lighting stay fully 3D.
- New character controllers should follow this plane-locked pattern rather
  than introducing free 3D movement (6DOF, arbitrary off-plane strafing)
  unless a task explicitly calls for it.
- Level geometry should be built with the plane lock in mind: width and
  height can vary freely, depth stays within the locked axis band.

## Tier 1 scope lock — mirror of Tier 1 Prototype Plan v2.2.0, §2

The plan of record in the claude.ai Project (DT_SystemsCode_Tier1PrototypePlan_v2.2.0) is the
authority, read with Supplement 1 v1.8.0. This section mirrors its §2. If they differ, the plan
wins: stop and ask.

Rulings are tagged CoD-01 to CoD-16. The 2026-11-05 design-gap session numbered them D-01 to D-16,
and the author re-tagged them on 2026-11-09 so that they never read as the Genre Bible's D-1 to D-6.
design/decisions/2026-11-05_design-gap-session-1.md keeps its original numbers: D-nn there is CoD-nn.
Never give a new ruling a bare D- number.

In scope at Tier 1
- Vox Nullis and Ciphera, playable. Metronome, Gravicus and Serratrix-9 as placeholder mannequins.
- A greybox map of 3–5 connected rooms.
- One attack button and a one-to-two-hit chain by a single character, run in Beat-State
  (CoD-07, CoD-09, CoD-10): the opening attack is an ungraded anchor, later inputs are graded
  against the character's passage, and Beat-State ends on a Miss or an idle gap of about three beats.
- Simple placeholder beats, one per range tier for Vox and Ciphera (CoD-12). No real CyberSludge
  track at Tier 1.
- The rhythm grades any encounter that needs a combination of presses; free movement isn't graded.
- Three enemy types as simple-shape silhouettes: Basic Bot, Flying Drone, Heavy Unit.
- Stamina per character (O-02). Stress as a hidden value shown by body tells (O-07), with the node
  faults of CoD-05 and CoD-06.
- Ground-based switching between Vox and Ciphera through the Switching state. A switch request
  while Beat-State runs is refused, silently, until Beat-State ends (author, 2026-11-20).
- Wave-Lock v1, and one traversal gate: the Vox/Ciphera cadence node (CoD-03, CoD-05, CoD-06),
  with what each character sees set by O-43.
- One micro-choice, revealed by tone alone (O-48).
- The rig light (CoD-02); the hidden pair-bond (CoD-01, CoD-13 to CoD-15); calibration (CoD-16).
- The growth log (CoD-01): records every judged input with its grade and signed offset, and spends
  nothing. Only Perfect and Good hits count as growth credit (author, 2026-11-20).
- A minimal save.

Out of scope: Tier 1.5 or later. Do not build these.
- The Beat-State handoff on a switch (CoD-11). The prototype branch already has it: keep it behind
  beat_state_handoff_enabled = false.
- Combat switching, including the aerial strike swap (FLAG-45a).
- Combination attacks, two-character and Full Band (FLAG-45b). "No combo systems" means exactly
  this (CoD-04).
- Ally combat AI; Ciphera's bond-flaw incapacitation; the full Stress spec; the Oracle Core Charge;
  permadeath and injuries; the Death, Dialogue, Cinematic, Stealth and Dispatch states; the other
  three members as playable; cel-shading and all shader work; the 3-state adaptive audio machine;
  the O-43 rhythm-sound hint; real passages and a real track; node types beyond the cadence answer;
  the Hub state (Tier 3).

Decision records (author, 2026-11-20 and 2026-11-21; OQ-068):
- Every ruling the author makes, in any thread, gets a record in design/decisions/.
- A ruling made in a Claude Code session: write its record the same day, and list it in the
  build report for the Project's Systems & Code diary. Only these rulings take new CoD- numbers.
- Rulings made in the Project's threads arrive in decision files that the Systems & Code thread's
  prompts carry. Commit them as given. They keep their OQ-, FLAG- or O- IDs. Never invent a new
  ID prefix.
- Traceability: a code comment that carries a ruling cites its ID, with the amendment date when a
  ruling amends one (for example "CoD-07, amended 2026-11-21"). Each record lists the files and the
  commit that carry it, so a bug can be traced to its ruling and back.

## Rulings newer than the mirror (until Plan v2.3.0)

These come from the author after Plan v2.2.0. They win over the mirror above until the plan's
next revision re-mirrors its §2.
- Beat-State plays in patterns: four bars of the loaded passage at Tier 1 (`pattern_bars`); later
  patterns may be longer or more complex. A pattern ends early on two Misses in a row, on the third
  Miss in total within it, on environmental damage (at once), or on an idle gap of three beats, and
  an early end ends the combo. An enemy hit is a Miss, with its own sound: a percussive amp-feedback
  buzz alongside the enemy's hit-type sound, in place of the scratch. A Miss that doesn't end the
  pattern pauses the combo: it keeps its number, and the next Perfect, Good or Poor carries on from
  it. A pattern played through to its end is complete: the combo carries over, and the next pattern
  starts on the following bar with no new opening attack and a fresh miss count. The next pattern is
  picked by the same factors that picked the first, so it repeats or becomes a Pattern Switch-up or
  a Pattern Extension. At Tier 1 the closing attack's range tier picks it, and Extensions wait for
  new passages. This amends CoD-07 and, within Beat-State, Supplement 1's Miss State (author,
  2026-11-20 and 2026-11-21). The damage hooks exist in `BeatState`; wire them, and the enemy hit's
  sound, when damage exists.
- The combo flows and keeps growing, as in Batman: Arkham Asylum. The player can strike whether or
  not Beat-State runs (2026-11-20).
- The beat that loads depends on the stage, the enemy, the character, and the opening range (the
  distance to the enemy and the opening attack's range tier) and input. This widens CoD-07
  (2026-11-20 and 2026-11-21). Tier 1 keeps one placeholder passage per character per range tier,
  on one placeholder track.
- The Tier 1 input map (O-01; author, 2026-11-22). Gamepad (Xbox names), then keyboard: move, left
  stick or D-pad, A/D or the arrows; jump, A, Space or W; close attack, X, J; mid attack, Y, K;
  interact and the node's answer, B, E; switch, RB, Tab; parry, LB, L (graded on the beat; a counter
  is any attack in the opening after it); dodge, RT, Shift; pause, Menu, Esc; the debug overlay,
  View, F3, in dev builds only. Calibration is a slider in the options menu, not a button. LT, both
  stick clicks and the right stick are free for later. Light, heavy and directional variants and
  button combinations wait for Tier 1.5's move set. Phase 1 writes the map into `project.godot`,
  and it stays rebindable.
- Phase 0 still runs: the prototype's run isn't Phase 0 (OQ-051). It installs dt-godot v0.6.0 on
  this branch, and the prototype's folders (`scripts/`, `scenes/`, `tests/`) are the convention
  dt-godot documents (OQ-137; author, 2026-11-22).
- Counters, parries and learnable Solo-Finishers join the combat design (2026-11-21). Tier 1
  builds one parry-and-counter, against the Basic Bot's single attack, telegraphed and graded on
  the beat, together with the Basic Bot (Phase 4). The other counters and parries, and
  Solo-Finishers with how they're learned, are Tier 1.5: don't build them.
- Developer switches live in one `dev_tools` module that can be removed and is left out of the
  release build (author, 2026-11-21). It isn't built yet; until it is, add no new developer switches.
- O-52's test switch, when it's built with the Basic Bot, is one of these developer switches
  (author, 2026-11-21).

## Session rule: always end with something running

A session is not done when it produces documentation or design notes alone.

- Favor small, verifiable increments — getting a scene running in the editor
  beats writing more spec.
- Before ending a session, run the project (or the relevant scene) and
  confirm it launches without errors.
- Documentation-only sessions are not an acceptable outcome unless the user
  explicitly asked for only documentation or planning.
