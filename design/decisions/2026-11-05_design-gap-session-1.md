Re-tagged by the author on 2026-11-09: D-nn here is CoD-nn in CLAUDE.md and the Project.

# Design-gap session 1: decision records (2026-11-05)

These are the author's rulings from the design-gap discussion that followed the two research rounds. Design folds them into the GDD and Supplement 1, and Systems & Code builds from them. This file is a record for handoff, not a canon source; the GDD and S1 stay authoritative once they are updated.

Inputs: `reports/Dystenic Transmission feature deconstruction.md` and `reports/DT primary evidence and rhythm tracking.md`.

---

## Ruled

**D-01 · Three Tier 1 additions**
- Question: should Tier 1 add three systems that sit outside the Plan v2.0.1 scope lock?
- Ruling: "go-ahead" (author).
- The additions:
  - a hidden Vox–Ciphera pair-bond integer;
  - a Ciphera rig assist (its form is set by D-02);
  - a growth-credit log that records Perfect and Good hits and spends nothing in Tier 1.
- Touches: Plan v2.0.1 scope lock; S1 (Progression, Stress); the repo's CLAUDE.md scope lock.

**D-02 · What the rig assist is in Tier 1**
- Ruling: **the rig is a beat light.** While Vox plays, Ciphera's rig follows and pulses its light on the beat. It doesn't attack and has no AI.
- Considered: one player-cued assist; a full combat assist; deferring it to Tier 1.5.
- Why: it keeps the Plan's deferral of ally combat AI to Tier 1.5 intact. It also doubles as an in-world beat indicator, which helps with signals without sound (O-37).
- Touches: S1 System 4 (Background Character Manager); O-37.

**D-03 · How the Tier 1 node opens** (first item in Design's flag-pass queue; needed by Phase 7)
- Ruling: **Vox answers a cadence.** Once Ciphera has revealed the node, it plays a short Oracle cadence of about one measure. After the switch, Ciphera's rig light pulses that pattern and Vox answers it on the beat, graded.
- Author's words: "B: answer a cadence, is absolutely a good start, but all three states will be considered for future nodes, plus others we have yet to come up with."
- Considered: a single press (A); a duet across the switch (C).
- Touches: S1 System 7; GDD Next Steps (the node question); Audio & SFX (the cadence cue).

**D-04 · How to read Tier 1's "no combo systems" lock**
- Ruling: **the lock covers combination attacks only**, meaning two-character and Full Band attacks (FLAG-45, Tier 1.5). Single-character graded phrases and S1's chains are allowed in Tier 1.
- Touches: the Plan's scope-lock wording; the repo's CLAUDE.md.

**D-05 · Node grades**
- Ruling:
  - Perfect or Good opens the node cleanly.
  - **Poor opens it at a cost:** Vox's voice cracks on a dull note that nearby enemies hear, and hidden stress ticks.
  - A Miss rejects the answer and the node replays the cadence.
- Considered: crack only; stress tick only; a quiet cost (a slow open with nothing logged).
- Touches: **O-07 (amended).** O-07 ruled that stress rises only on a Miss or a hit; a Poor at a node now also ticks it. Also S1 perception (Vox's involuntary vocal sounds can alert enemies).

**D-06 · Grace on node stress**
- Ruling:
  - **The first fault at a node, Poor or Miss, costs no stress.** A Poor still cracks and alerts enemies.
  - After that, faults build stress slowly, more slowly than in combat.
  - Where speed is integral to avoiding death, node faults build stress at the combat rate.
- Author's words: "Yes, but the first Miss is free, additional misses build slowly, slower than in Combat since it may be less life-threatening, unless in a spot where quickness is integral to avoiding death."
- Touches: O-07; S1 Stress; room and node cards (each needs a "time-critical: yes/no" field).

**D-07 · Combat grammar: Beat-State (Rhythmic Focus)**
- Author's words: "Free-flowing, when the first attack of a combination begins, the character enters a Beat-State that takes over, providing and starting character instrument specific passages that will time the player inputs that will be graded against instead of grading to background soundtrack timing." And: "Instantly at the press, and the Beat-State overrules the track so that the character enters a Rhythmic Focus at combo start — Track and area environmental sounds pitch-drop out to provide a low drone foundation for the combat and beat-hit sounds."
- Ruling, in parts:
  - Combat is free-flowing.
  - The first attack of a single-character combination starts Beat-State **instantly at the press**.
  - That character's instrument-specific passage begins, and later inputs are graded against **the passage's timing, not the background soundtrack's**.
  - The track and the area's environmental sound pitch-drop to a **low drone foundation** under the combat and beat-hit sounds. The music never stops.
  - Beat-State **ends on a Miss or after an idle gap**.
  - The **opening attack's range tier picks the passage**, which is one section of a track. The **track is chosen by the enemy or encounter**.
- Considered: graded against the background beat; actions locked to the beat; strikes snapped to the next beat.
- Touches:
  - S1 System 5 (rhythm); GDD Combat (timing tiers) and Stamina (on-beat now means the passage's beat during Beat-State).
  - Audio & SFX (passages, drone treatment, beat-hit sounds); the Music thread (tracks and their range-tier sections).
  - O-52 (enemies on the beat); O-08's sub-question (what voices each character's notes before their instruments are in play).

**D-08 · Combat misses vs choice tones**
- Ruling: **keep them distinct.** A combat Miss stays a discordant scratch. The choice tones (harmonic, missed note, silence, chord) are their own family, and combat never uses them.
- Touches: Audio & SFX; GDD Choice & Consequence.

**D-09 · Beat-State: the opening attack**
- Ruling: **the opening attack is an ungraded anchor.** It lands normally, pays full stamina and sets beat zero. Grading starts with the second input.
- Considered: grading it against the track's beat before the drop; always counting it as Perfect.

**D-10 · Beat-State: tempo**
- Ruling: **passages play at the encounter track's tempo**, with the phase reset at the press.
- Considered: a tempo band per member; a tempo that ramps with the chain.

**D-11 · Beat-State: switching mid-chain**
- Ruling: **the passage hands off at the same phase.** It passes to the incoming member's instrument without dropping a beat, and the chain continues. This is a musical handoff, not a combination attack, so it is outside the D-04 lock.
- Considered: Beat-State ends on a switch; switching is blocked during Beat-State.
- Touches: the Swap State (S1); O-53, what enemies do during a swap, still open and decided from play.

**D-12 · Tier 1 passage production**
- Ruling: **placeholder patterns.** Simple percussive or tonal patterns per range tier for Vox and Ciphera, enough to test whether Beat-State feels good. Real compositions arrive at Tier 1.5.
- Considered: one real composed track; the full set.
- Touches: Plan Phase 5; Audio & SFX and the Music thread (Tier 1.5 scheduling).

**D-13 · What writes the pair-bond**
- Ruling: **shared moments only.** Three things write it:
  - answering a node Ciphera revealed, where Perfect or Good raises it;
  - Beat-State handoffs between Vox and Ciphera at Perfect or Good;
  - the micro-choice.
- Solo combat hits don't count, so the bond reflects togetherness rather than general skill.
- Considered: every graded hit; the micro-choice only.

**D-14 · Whether the pair-bond can fall**
- Ruling: **only through choices.** Performance only raises the bond; Poor and Miss are neutral. Only the micro-choice's missed-note outcome lowers it, so weak rhythm skill never damages the relationship.
- Considered: misses in shared moments lower it too; it never falls in Tier 1.

**D-15 · How the player perceives the pair-bond**
- Ruling: **one tell, through the rig light.** Ciphera's beat light (D-02) steadies and warms toward Vox as the bond rises. The value itself stays hidden.
- Considered: logged only; a line or tone at thresholds.
- Touches: the light doctrine (hand-made light, small); Audio & SFX if the light pairs with sound later.

**D-16 · Calibration in Tier 1**
- Ruling: **a tap test plus a slider.** One rerunnable tap test that averages taps and rejects noisy runs, plus a manual offset slider in the options. The growth log's signed offsets allow suggestions later.
- Considered: adding capped auto-calibration; a slider only.
- Touches: Plan Phase 5 (scene S6); Phase 7 (options).

---

## Flags raised in session (for the owners named)

- **Recovery-to-Weaponization** [LOCKED]. Tier 1 uses Raid-era enemies, so this is fine there. In the prologue's Waves 1–4, Beat-State passages must read as score and not as an instrument used as a weapon. This joins O-08's sub-question. Owners: Audio & SFX and Design.
- **Implementation detail for the pitch-drop.** A bus pitch-shift effect keeps the track's timeline intact; changing the player's `pitch_scale` (a tape-stop effect) shifts it. Either works, because nothing is graded against the track during Beat-State. Owners: Audio & SFX and Systems & Code.
- **Godot timing** (round 2 report). There is no scheduled playback in 4.7.1, so a passage becomes audible about one mix chunk plus output latency after the press. The passage clock should be read from the passage stream itself, so grading matches what the player hears. Owner: Systems & Code.

## Built

The first runnable prototype, `scenes/proto/beat_state_proto.tscn`, implements D-02, D-03, D-05 to D-07 and D-09 to D-16. It uses placeholder shapes, code-generated sounds and placeholder numbers. Stamina is not built yet. Headless checks on Godot 4.7.1 (`tests/run_tests.gd`) pass 36 of 36, including an end-to-end smoke test: reveal, switch, answer the cadence, open the gate. The clock probe, `scenes/proto/clock_probe.tscn` (Phase 5 scene S1), needs a run on the target PC.

## Proposed (awaiting the author)

- **How time-critical nodes are read (from D-06).** The prototype assumes the first-fault grace doesn't apply at time-critical nodes, because combat has no grace. To be confirmed. It's one constant in `scripts/rhythm/node_rules.gd`.

- **Default proposal for the growth-credit log schema.** Each judged input records its grade, the signed offset in ms, the offset applied, the context (combat or node), the character, and the Beat-State chain index. Recording the signed offset costs nothing and later feeds calibration suggestions and tuning.
- O-52 during Beat-State is decided from play. Build toggles for enemies on the passage's grid, on the track's grid, and on their own timers.
- Pair-bond thresholds, meaning the bands at which the rig-light tell changes. Set them from playtest data in the log; no primary source exists.

## Parked

- **A family of node types** for Tier 1.5 onward: single press, cadence answer, duet across the switch, and types not yet invented (from D-03). Home: puzzle design at Tier 1.5.
