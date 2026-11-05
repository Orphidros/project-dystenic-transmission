# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Project

Dystenic Transmission — a Godot 4 game. This is the developer's first Godot
project and first game project overall, so explain engine-specific concepts
rather than assuming familiarity with Godot conventions.

## Engine

- Godot **4.7**, Forward+ renderer (`config/features` in `project.godot`).
- Physics: **Jolt Physics** (`3d/physics_engine="Jolt Physics"`).
- Windows rendering driver: D3D12.
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

## Tier 1 prototype: scope lock

The current milestone is a deliberately small, locked-scope prototype. Do
not expand scope without the user explicitly asking, even if a request seems
like a natural next step:

- **Characters:** exactly two playable characters — **Vox Nullis** and
  **Ciphera**. No additional characters.
- **Map:** one small map, **3–5 rooms**. No overworld, no multiple levels.
- **Explicitly out of scope for Tier 1** — do not implement, even partially,
  without confirming first:
  - Permadeath
  - Combination attacks (two-character and Full Band). Single-character
    graded chains and phrases are in scope, including Beat-State and the
    passage handoff on a switch (author, 2026-11-05).
  - Aerial character-switching
- **Approved Tier 1 additions (author, 2026-11-05):**
  - a hidden Vox–Ciphera pair-bond integer;
  - Ciphera's rig as a beat light (no attacks, no ally AI);
  - a growth-credit log (records only; nothing is spent in Tier 1).

  Rulings and their details are in
  `design/decisions/2026-11-05_design-gap-session-1.md`. The GDD and
  Supplement 1 remain the canon once Design folds them in.
- If a request would break this scope lock, say so and confirm with the user
  before building it.

## Session rule: always end with something running

A session is not done when it produces documentation or design notes alone.

- Favor small, verifiable increments — getting a scene running in the editor
  beats writing more spec.
- Before ending a session, run the project (or the relevant scene) and
  confirm it launches without errors.
- Documentation-only sessions are not an acceptable outcome unless the user
  explicitly asked for only documentation or planning.
