# 2026-11-05 · Claude Code (research and prototype session) → Design and all threads · Handoff

**Reader:** an agent updating the GDD, Supplement 1 (S1), the Tier 1 Plan and related documents. The author ruled everything in §1, but none of it is recorded in the GDD or S1 yet. Nothing here is canon until Design folds it in.

**Repo:** `Orphidros/project-dystenic-transmission`, branch `claude/dystenic-transmission-research-69uq1t`, draft PR #1 (latest commit `4a914aa`).
**Inputs:** GDD v4.13.2; DT Research: Game Build Resources v1.0 (2026-10-13).
**Evidence tags in the reports:** [P1] primary (code, developer-authored, patch notes, decompilation); [P2] developer quoted by an outlet; [S] secondary.

## 0. Artifacts (repo paths)
- `reports/Dystenic Transmission feature deconstruction.md`: round 1. REPLACED, SotN and MIO rebuilt for 3D characters; branching narrative and RPG layers; asset, addon and project catalogue with licences; study library; tiered Borrow/Adapt/Enhance/Avoid plan. Notes are in `research_notes/Dystenic Transmission feature deconstruction/`.
- `reports/DT primary evidence and rhythm tracking.md`: round 2. Evidence ledger; rhythm pipeline spec for Godot 4.7.1; about 35 design questions. Notes are in `research_notes/DT primary evidence and rhythm tracking/`.
- `design/decisions/2026-11-05_design-gap-session-1.md`: the authoritative wording of rulings D-01 to D-16.
- The prototype: `scenes/proto/`, `scripts/`, `tests/run_tests.gd`. `main.tscn` instances it, and `README.md` lists the controls.
- `CLAUDE.md`: its scope lock now records D-01, D-02 and D-04.

## 1. Author rulings, 2026-11-05: fold into the documents named
| ID | Ruling | Lands in |
|---|---|---|
| D-01 | Tier 1 adds three systems: a hidden Vox–Ciphera pair-bond integer; a Ciphera rig assist (its form is D-02); a growth-credit log that records Perfect and Good hits and spends nothing in Tier 1 | Plan v2.0.1 scope lock; GDD Scope Framework (Tier 1); S1 Progression and Stress |
| D-02 | The rig assist is a **beat light**: it follows Vox and pulses on the beat, with no attacks and no AI. Ally combat AI stays at Tier 1.5. It also serves as an in-world beat indicator | S1 System 4; O-37 |
| D-03 | The Tier 1 node: **Vox answers a cadence.** The node plays an Oracle cadence of about one bar; after the switch the rig light pulses the pattern, and Vox answers on the beat, graded. Author: "all three states will be considered for future nodes, plus others" | S1 System 7; GDD Next Steps (**closes the node question**); Audio & SFX (cadence cue) |
| D-04 | Tier 1's "no combo systems" lock means **no combination attacks** (two-character and Full Band; FLAG-45). Single-character graded chains and phrases are allowed | Plan scope wording; GDD Scope Framework |
| D-05 | Node grades: Perfect or Good opens it. Poor opens it, but Vox's voice cracks audibly to nearby enemies and stress ticks. A Miss rejects the answer and the cadence replays | S1 System 7; **amends O-07** (a Poor at a node is now a stress input); S1 perception (Vox's vocal sounds alert enemies) |
| D-06 | Node stress grace: the first fault at a node (Poor or Miss) is free, though a Poor still cracks. Later faults build slowly, more slowly than in combat. Where speed is integral to avoiding death, faults build at the combat rate | S1 Stress; O-07; room and node cards gain a "time-critical" field |
| D-07 | **Beat-State (Rhythmic Focus).** Combat is free-flowing. The first attack of a single-character chain starts Beat-State instantly at the press, and that character's instrument passage begins. Later inputs are graded against the passage's timing, not the background track. The track and area sound pitch-drop to a low drone foundation; the music never stops. Beat-State ends on a Miss or an idle gap. The opening attack's range tier picks the passage, which is one section of a track; the enemy or encounter picks the track | S1 System 5; GDD Combat (Timing Tiers; Stamina, where "on-beat" means the passage's beat during Beat-State); Audio & SFX; Music; O-52 |
| D-08 | A combat Miss (a discordant scratch) never uses the choice-tone family | GDD Choice & Consequence; Audio & SFX |
| D-09 | The opening attack is an ungraded anchor: it pays full stamina and sets beat zero | S1 System 5 |
| D-10 | The passage plays at the encounter track's tempo, with its phase reset at the press | S1 System 5; Music |
| D-11 | A switch during Beat-State hands the passage to the incoming member's instrument at the same phase, and the chain continues. This is a handoff, not a combination attack | S1 Swap State; O-53 stays open |
| D-12 | Tier 1 uses placeholder passages per range tier for Vox and Ciphera; real compositions arrive at Tier 1.5 | Plan Phase 5; Music and Audio scheduling |
| D-13 | Only shared moments write the bond: a Perfect or Good answer to a node Ciphera revealed, a Perfect or Good Beat-State handoff, and the micro-choice. Solo hits don't count | S1 (a new subsystem); GDD Stage & Jukebox (relation to band cohesion) |
| D-14 | The bond falls only through choices. Performance only raises it, Poor and Miss are neutral, and the micro-choice's missed-note outcome lowers it | As D-13 |
| D-15 | The bond's only tell: the rig light warms and steadies as the bond rises. The value stays hidden | As D-13; light doctrine |
| D-16 | Tier 1 calibration is a rerunnable tap test (it averages taps and rejects noisy runs) plus a manual offset slider. The log's signed offsets enable suggestions later | Plan Phase 5 (scene S6) and Phase 7 (options) |

## 2. Open, awaiting the author
- **Reading of D-06:** does the first-fault grace also lapse at time-critical nodes? The prototype assumes it does (`NodeRules.GRACE_AT_TIME_CRITICAL = false`).
- **Pair-bond band thresholds:** placeholders 0, 3, 6 and 10. Set them from playtest log data.
- **Growth-log schema:** a default, already implemented. Each entry holds the grade, signed `offset_ms`, the offset applied, the context (`combat`, `node` or `node_unanswered`), the character and the chain index.
- **O-52 during Beat-State:** build toggles (enemies on the passage grid, on the track grid, or on their own timers), and rule from play.
- **Gaps not yet discussed:**
  - O-08, pre-Raid prologue combat, the largest Tier 1.5 gap;
  - progression and loss: bank-or-recover death penalty, blackout, reloading around a lost member (FLAG-01, FLAG-13), loadout budget;
  - narrative questions N1–N5 and map questions M1–M6 (round 2 report, "Design questions").

## 3. Parked
- A family of node types for Tier 1.5 onward: single press, cadence answer, duet across the switch, and new types.
- Post-Wave "echo" tone playback, an option only.

## 4. Flags for other threads
- **Audio & SFX:**
  - New work: the cadence cue; the Beat-State drone and pitch-drop treatment; beat-hit sounds; passages per character × range tier × track.
  - Recovery-to-Weaponization: pre-Raid Beat-State passages must read as score, not as an instrument used as a weapon. This joins O-08's sub-question.
- **Systems & Code (Godot 4.7.1 facts, [P1] from source):**
  - `InputEvent` has no timestamp, so stamp presses in `_input`, accurate to ±1 frame.
  - There is no scheduled playback; PR #107226 is open. A passage becomes audible after the next mix plus output latency, so read the passage clock from the passage stream.
  - `get_output_latency()` is a snapshot taken at device open, so a per-device offset is needed.
  - Engine noise is about ±10 ms at 60 Hz, so keep Perfect at or above about ±25 ms.
  - A bus `AudioEffectPitchShift` keeps the track's timeline intact during the pitch-drop.
- **Narrative:** the micro-choice is now the only input that can lower the bond.
- **dt-godot register (at re-sync):** O-07 is amended; the node question is resolved by D-03.

## 5. Research findings that correct earlier documents
- **REPLACED** uses hand-drawn frame-by-frame sprites; 3D tests were rejected as "sub-par and very noisy" (Zhdanovich, Xbox Wire, 2026-04-14 [P1]).
  - Only design intent transfers: "weight", a sluggish-to-fluent arc, and finishers with custom camera and lighting.
  - The precedents for 3D characters in 2.5D are Planet of Lana, Little Nightmares and Reanimal.
  - The quote "can't do arcade-style platforming" is unverified.
- **MIO** released on 2026-01-20. Douze Dixièmes reportedly closed on 2026-06-23 (no official statement read). The core team was about 15 people [P2].
- **Judgement windows are published in open-source code:** osu! (MIT), Funkin (Apache-2.0), Etterna (MIT), ITGmania (GPL-3.0) and Quaver (MPL-2.0).
  - Candidate DT windows: Perfect 25–45 ms, Good 90–100 ms, Poor 135–160 ms. The prototype uses 45, 90 and 150.
  - Rebuild the patterns in GDScript and port no code.
- **Darkest Dungeon's** designers chose to show stress as a number [P1]. Hidden values need readable tells.
- **Hi-Fi Rush's** GDC page doesn't support "hits land on the beat". Johanas: "you don't need to be good at rhythm games" [P2].
- **Sea of Stars** combo points persist after battle since 2024-11-12 [P1].
- **Lost Crown** amulets: 3 holders at the start, rising to 12, with costs of 1 to 3 [P1].
- **SotN** (sotn-decomp, AGPL-3.0, study only) [P1]:
  - crit chance is the weapon's rate + sqrt(2·LCK + rand&15) − 5, out of 256;
  - LCK shifts the drop roll only about 5/256, which contradicts the fan wikis;
  - map % = rooms·100/942;
  - a two-handed weapon is the same item id written into both hands;
  - familiars change in bands of level/10, and the Sword familiar item comes at level 50;
  - motion inputs use an exact-match state machine with a 20-tick window per step.
- **Licences still unverified:** Mixamo, Fab Standard License, CMU mocap, MPFB2 assets, Rokoko, Truebones.
- **Verified:**
  - Cogito: moved to Codeberg, MIT.
  - MIT save and quest addons tested on 4.7.2: savestate, CodingQuests godot-save-system, ShomyKohai quest-system, Rubonnek quest-manager.
  - CC0 assets: Kenney, Quaternius, KayKit, ambientCG, Poly Haven.

## 6. Prototype status
- **Built:**
  - Beat-State (D-07, D-09–D-11);
  - the cadence node (D-03, D-05, D-06), with the O-43 reveal;
  - the rig beat light and bond tell (D-02, D-15);
  - the pair-bond (D-13, D-14);
  - the growth log, written to `user://growth_log.jsonl`;
  - calibration on the `[` and `]` keys in ±5 ms steps, standing in for the slider;
  - plane-locked `CharacterBody3D` placeholders under Jolt;
  - code-generated placeholder audio;
  - the Phase 5 clock probe, `scenes/proto/clock_probe.tscn`.
- **Not built:** stamina (O-02), the tap-test screen (D-16), enemies and AI, more than one room, the micro-choice.
- **Verified** with the official Godot 4.7.1 Linux build, headless:
  - `tests/run_tests.gd` passes 36 of 36: the rules, plus an end-to-end run of reveal → switch → answer → gate opens;
  - the main scene ran 600 frames with no errors.
- **Not verified:** how it feels to play, real audio latency (the headless audio driver is a dummy), and Windows with D3D12. The author should run `main.tscn` and the clock probe (20 s) on the target PC.
- **Code:**
  - `scripts/rhythm/`: `rhythm_windows`, `node_rules`, `beat_state`, `music_director`, `placeholder_audio`;
  - `scripts/band/pair_bond.gd`;
  - `scripts/progression/growth_log.gd`;
  - `scripts/proto/`: `beat_state_proto`, `cadence_node`, `proto_character`, `rig_light`, `clock_probe`.

## 7. Next steps
1. **Design:** fold D-01 to D-16 into the GDD (Scope Framework, Combat, Choice & Consequence, Next Steps) and S1 (Systems 4, 5 and 7, Stress, Swap State). Record the O-07 amendment and close the node question.
2. **Author:** play the prototype, run the clock probe, and answer §2.
3. **Build:** stamina, then tap-test calibration, then the Phase 4 enemy with O-52 toggles.
4. **Design sessions:** O-08, then progression and loss.

The scheduled Monday session was deleted at the author's request on 2026-11-05. Local work is paused until the author returns to their computer.
