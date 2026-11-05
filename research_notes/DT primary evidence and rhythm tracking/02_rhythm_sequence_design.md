# Rhythm sequence grammars: how rhythm-action games define, recognise and reward input sequences (for DT)

Research date 2026-11-05. Tags: [P1] developer-authored, [P2] developer quoted by an outlet, [S] secondary.

**Method and honesty note.** About 20 tool calls. Fetched and read in full (via summariser): the Game Developer NecroDancer deep dive (Ryan Clark, [P1]), the Game Developer Metal: Hellsinger piece ([P2]), the PlayStation Blog Patapon interview ([P2]), the Game Developer Patapon 3 Q&A ([P2]), the Wccftech Hi-Fi Rush Q&A ([P2]), and the Game Developer Rhythm Doctor piece ([P2]). Thumper was read via a Game Developer Q&A ([P2]). Everything else is from search-result summaries only, flagged [S]. The No Straight Roads Unreal Engine interview returned HTTP 403 and the TechRadar Hi-Fi Rush interview was truncated by paywall/newsletter text. **No primary source was found for: Patapon command recognition internals and Fever rules beyond one interview line; Hi-Fi Rush combo notation, beat snapping and partner calls; Rock Band/Guitar Hero (drum fills, Overdrive); Theatrhythm; Sayonara Wild Hearts; BPM beyond marketing description; Pistol Whip beyond reviews.** Those are listed as Gaps rather than filled from memory. Round 1 findings are only upgraded or contradicted where noted. No GDC talk video was watched (the Hi-Fi Rush GDC 2024 page exists but its content was not obtainable).

## 1. Grammar: per-beat actions vs measure-level commands vs free combos snapped to the beat. How are sequences recognised, and how are rests and holds represented?

### Takeaway
The best-evidenced grammars are (a) one action per beat on a fixed grid (NecroDancer, [P1]), (b) a call-and-response phrase where the game states a pattern and the player repeats it (Patapon, [P2], thin on internals) and (c) one-button pattern reading where rests are explicit marks (Rhythm Doctor, [P2]). Primary evidence for "free combos snapped to the beat" (Hi-Fi Rush) was not obtainable; only that it exists and that players found unanticipated combinations.

### Cited Findings
- **NecroDancer is per-beat.** Player and enemies move at fixed intervals; Clark's first prototype had the player move on the beat and enemies halfway between beats, which made a predictable turn structure but an unsynchronised world. Final design: "the player and the enemies move at the same time, but allow the player's action to take priority." [P1] — [Game Developer deep dive](https://gamedeveloper.com/audio/game-design-deep-dive-finding-the-beat-in-i-crypt-of-the-necrodancer-i-)
- **Patapon grammar, as the developer describes it:** the four buttons were first thought of as parts of a drum mapped to "March, Attack and Defend". The March command came from the name itself, "pata, pata, pata, pon". Throw is "pon, pon". The other two buttons are "don" and "chaka". [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468)
- **Patapon call and response.** Early on, the Patapons repeated each command back; Pyramid suggested they sing it back, which became central ("call and response became central to the game", Adachi). [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468). The interview does NOT use the terms "four-beat structure" or "response measure"; the four-beat/measure framing in round 1 and in the brief comes from fan wikis, e.g. [Patapon Wiki](https://patapon.fandom.com/wiki/Patapon_(Video_Game)) and [StrategyWiki Patapon 3 controls](https://strategywiki.org/wiki/Patapon_3/Controls) [S].
- **Patapon complexity trade-off.** Kotani worried complex commands would be hard to remember and simple ones boring; the original plan was adjective-and-grammar control, later simplified to onomatopoeic commands [P2 for the worry; the "adjectives" history is from a Wikipedia mirror, [S]] — [PlayStation Blog](https://blog.playstation.com/?p=193468), [Cavac Patapon](https://cavac.at/cavacopedia/Patapon). Kotani also says more drum commands unlock during the adventure [P2, search snippet] — [Pocket Gamer](https://www.pocketgamer.com/patapon/talking-a-different-beat-with-patapons-designer-hiroyuki-kotani).
- **Patapon is unforgiving by the developer's own account:** players have about two seconds to choose between attack, defend and retreat; skipping a needed defence means heavy damage. [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468)
- **Patapon difficult rhythms.** The irregular "don, dodon, dodon" Miracle rhythm "seemed hard for some players". [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468)
- **Rhythm Doctor one-button grammar.** One button; players follow a pulse down an EKG line to the right-hand side, usually on the seventh beat; pulses appear in a "mechanical, staccato way". Mechanics include swing beats, a press on the 2 and 4 (the "SVT" mechanic) and skipped beats. [P2] — [Game Developer](https://www.gamedeveloper.com/design/using-medical-stories-and-heart-conditions-to-create-musical-challenges-in-rhythm-doctor)
- **Rests and holds in Rhythm Doctor are shown explicitly:** held beats require holding the spacebar so pulses "build tension"; frozen-ice pulses signal delayed timing; red X marks silent beats. [P2] — [Game Developer](https://www.gamedeveloper.com/design/using-medical-stories-and-heart-conditions-to-create-musical-challenges-in-rhythm-doctor)
- **Rhythm Doctor teaching method:** each concept is introduced with "a few different variations"; beat types must be "clear and distinct from each other" so players can read several rows at once; Azman likens the approach to Hanon piano exercises. [P2] — same Game Developer link.
- **Thumper** deliberately kept to "one button and one stick", and rather than escalating by adding notes or inputs "keeping it simple and pure has always been a goal". [P2] — [Game Developer Q&A](https://gamedeveloper.com/audio/q-a-the-rhythm-violence-of-i-thumper-i-)
- **Hi-Fi Rush combos:** Johanas says fans found "a ton of combinations" the team did not anticipate, described as new rhythms created by merging your attacks with your partner's. [P2] — [Wccftech](https://wccftech.com/hi-fi-rush-qa-with-director-john-johanas-on-reception-working-with-mikami-and-more/)
- **BPM: Bullets Per Minute:** shooting, jumping and dodging are tied to the beat and enemies perform dance-like attack sequences timed to the soundtrack [S, marketing-derived summaries] — [Gematsu](https://www.gematsu.com/2020/04/rhythm-action-first-person-shooter-roguelike-bpm-bullets-per-minute-announced-for-consoles-pc), [Destructoid](https://www.destructoid.com/bass-pounding-shooter-bpm-bullets-per-minute-is-coming-to-consoles-this-summer/)
- **Rift of the NecroDancer** is lane-based (Guitar Hero and Rhythm Heaven inspired); enemies move across lanes on the beat or are pushed back when hit [S, search summary] — [Wikipedia](https://en.wikipedia.org/wiki/Rift_of_the_NecroDancer), [Brace Yourself press page](https://braceyourselfgames.com/press/rift-of-the-necrodancer/). Gordon (design director) argues Crypt is a real rhythm game because of its optionality and strategy [S via Game Rant summary].

### Inferences
- (inference) Three recognition strategies emerge. **Per-beat**: judge each press independently against the nearest beat (NecroDancer). **Buffer-then-match**: collect presses over a measure and match against a phrase table (Patapon-style, but its internals are unverified here). **Incremental**: advance a cursor through a known pattern per beat and fail on mismatch (Rhythm Doctor-style reading; the game tells you the pattern in advance with marks, so no recognition ambiguity). For DT, per-beat judgement is the cheapest and a phrase matcher can be layered on top of it.
- (inference) Representing rests explicitly (Rhythm Doctor's red X, NecroDancer's empty beats) removes the question "did the player skip on purpose?"; the grammar is then a fixed array of tokens per measure (press / rest / hold).
- (inference) Patapon's two-second decision window and its "don, dodon, dodon" difficulty suggest the readable core is short phrases of identical-looking beats; irregular rhythms are where players struggled.

### Gaps
- No primary source on how Patapon recognises a command (buffered at measure end vs incremental), what a wrong fourth drum does, or how the response measure is timed. Round 1's "four-beat commands, response measure" claim remains [S].
- No primary source on Hi-Fi Rush combo notation (rests in strings), beat snapping of attacks or partner calls. Round 1's "attacks land off-beat but hit harder on-beat" remains a paraphrase of search summaries ("more carrot than stick" appeared in a search summary of the Wccftech Q&A but not in the fetched text).
- No source at all on Rock Band/Guitar Hero drum fills and Overdrive, Theatrhythm chain/hold/slide notation, Sayonara Wild Hearts, or Thumper's input model beyond the quote above. Not filled from memory.

## 2. Rewards and failure: streaks, multipliers, fever states; what a miss breaks; soft-fail; stamina and resources

### Takeaway
Developer evidence supports "reward, don't punish" scoring (Hi-Fi Rush, Pistol Whip [S]) and a widened timing window plus autocalibration (NecroDancer, [P1]), versus Patapon's openly strict rhythm. The coin multiplier/groove chain was not covered by the P1 article fetched.

### Cited Findings
- **NecroDancer window.** The first build allowed about 20 percent leeway, "within 100ms of the beat or your movement will fail" at the 120 BPM example; Clark found it "felt best at 100 percent". Missing the beat and failing to move could lead to death, which frustrated players and is why he widened it. [P1] — [Game Developer deep dive](https://gamedeveloper.com/audio/game-design-deep-dive-finding-the-beat-in-i-crypt-of-the-necrodancer-i-). The "100 percent" figure is from the fetch summariser's reading; the exact meaning of 100 percent of what is not defined in the extract (unverified).
- **NecroDancer autocalibration.** A leaky integrator "will slowly shift the effective position of each beat to match" the player's timing, capped so it never drifts more than half a beat from the true position. [P1] — same link.
- **NecroDancer on stress and accuracy.** Clark observed that player timing drifts when stressed and that accuracy requirements add frustration rather than challenge. [P1] — same link.
- **Round 1 comparison.** Round 1 said "the developer widened the timing window and added auto-calibration", sourced to a Wikipedia mirror [S]. The P1 article confirms both and adds the leaky-integrator and half-beat cap details. Round 1 also said missing the beat resets the coin multiplier [S]; the P1 article extract did not cover the multiplier, so that stays [S].
- **Hi-Fi Rush scoring.** "We needed to both encourage and give a reward for players to play in our ideal way, which is with the beat of the song"; Just Timing percentage "was the rhythm-based portion of the battle"; "We didn't want it to be too complicated or difficult"; the intended feel is that "YOU are the one pulling off those cool actions to the music, even if you aren't perfect". [P2] — [Wccftech](https://wccftech.com/hi-fi-rush-qa-with-director-john-johanas-on-reception-working-with-mikami-and-more/)
- **Hi-Fi Rush beat meter.** Johanas found people found the beat in surprisingly different ways, which led to an optional on-screen beat meter [P2, search summary of the same Q&A; not in fetched text] — [Wccftech](https://wccftech.com/hi-fi-rush-qa-with-director-john-johanas-on-reception-working-with-mikami-and-more/)
- **Metal: Hellsinger.** Keeping rhythm "by interacting (largely shooting) enemies is core to the experience"; getting hit lowers Fury, which affects score and music intensity. The article does not list which actions are graded and gives no timing window. [P2] — [Game Developer](https://gamedeveloper.com/design/shredding-for-satan-how-i-metal-hellsinger-i-designed-fps-harmonies-in-hell). Fury tiers of 2x/4x/8x/16x with shooting, reloading and dodging on the beat building it are from search-summary sources [S] — [GameSkinny](https://www.gameskinny.com/tips/metal-hellsinger-how-to-increase-fury-to-get-high-scores/). Consistent with round 1's "max 16x" [S].
- **Patapon Fever.** "Fever is earned by chaining a large combo, which makes the music livelier"; the remaster lowered the requirement to a 3-combo (interviewer's note and Kotani, paraphrased). [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468). Taking damage shakes the player's rhythm; the defensive "chaka, chaka" command matters most. Same link.
- **Remaster lag.** Kotani's biggest worry was display lag; after the team's work "it's actually easier to get into the rhythm than even the PSP version!" [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468)
- **Pistol Whip:** shooting in time earns more points, off-beat shots are not penalised and a player can play "entirely rhythmless"; modifiers change the score multiplier. [S] — [Road to VR](https://roadtovr.com/pistol-whip-preview/), [Wikipedia](https://en.wikipedia.org/wiki/Pistol_Whip)

### Inferences
- (inference) Two reward philosophies: **soft-fail scoring** (Hi-Fi Rush, Pistol Whip: off-beat still works, on-beat scores more) and **hard-fail rhythm** (Patapon: break the chain and Fever drops, defence delayed). DT's Perfect/Good/Poor/Miss tiers with "each with its own note" fit the soft-fail philosophy, and the hidden growth-credit log and pair-bond integer can be written by the grade without changing whether an action lands.
- (inference) NecroDancer's autocalibration is directly relevant because DT's growth credits record Perfect and Good hits; a latency error would otherwise silently deny credits (round 1 made the same point from [S]; the P1 source now backs the mechanism).
- (inference) Chain-based fever states (Patapon, Hellsinger) tie to a musical reward (layers) rather than a numerical one, matching DT's "music as language" pillar.

### Gaps
- Stamina or resources tied to rhythm: no developer source found that ties a stamina pool to the beat. DT's costed dodge has no precedent in the sources read.
- No P1/P2 numbers for Hi-Fi Rush Just Timing windows, Hellsinger windows, or Patapon windows. Window sizes other than NecroDancer's are unknown.
- Rock Band/Guitar Hero Overdrive and streak multipliers: no source retrieved.

## 3. Enemies on the beat: telegraphing and how many act per beat

### Takeaway
NecroDancer is the only source with an explicit cadence model: enemies on fixed beat intervals, player priority on simultaneous actions. Hellsinger and No Straight Roads tie enemy attacks to the grid but the evidence is partial.

### Cited Findings
- **NecroDancer cadence.** Most enemies move every second beat while the player acts on every beat, so you can hit and retreat; other enemies attack every other beat or every four beats. [S-quality paraphrase in search summary of Clark's Gamasutra material] — [Game Developer Road to the IGF](https://gamedeveloper.com/business/road-to-the-igf-brace-yourself-games-i-crypt-of-the-necrodancer-i-). The P1 deep dive confirms that enemies move on the beat with the player and that the player's action takes priority [P1] — [deep dive](https://gamedeveloper.com/audio/game-design-deep-dive-finding-the-beat-in-i-crypt-of-the-necrodancer-i-).
- **Why predictability.** Clark's goal was a game that felt fair like Spelunky, with predictable, fixed-interval enemy patterns. [P1] — [deep dive](https://gamedeveloper.com/audio/game-design-deep-dive-finding-the-beat-in-i-crypt-of-the-necrodancer-i-)
- **Hellsinger enemies.** Some enemies have rhythmic attacks and some appear on the beat so players can shoot them in time; background flames and enemy emissive effects pulse on the beat but are described as "peripheral effects". The Outsiders built internal systems that define the beat for everything so actions scale to any song [the latter from a search summary, S]. [P2] — [Game Developer](https://gamedeveloper.com/design/shredding-for-satan-how-i-metal-hellsinger-i-designed-fps-harmonies-in-hell)
- **No Straight Roads (search summary of an Unreal Engine developer interview; page itself returned 403):** parryable enemy attacks appear only on the beat; an earlier version allowed a parry window of 0 to 0.5 seconds after the attack appeared; music drafts often came before boss design and inspired attacks. [P2 via snippet, unverified against the page] — [Unreal Engine interview](https://www.unrealengine.com/developer-interviews/no-straight-roads-innovative-design-fuses-rhythm-based-gameplay-with-dynamic-action). RPGamer's impression: enemy attacks follow the soundtrack while player attacks use the player's own instruments and the player can move freely [S] — [RPGamer](https://rpgamer.com/2019/06/no-straight-roads-e3-impression/). A review finds fights not especially difficult and samey [S] — [The Sixth Axis](https://www.thesixthaxis.com/2020/08/25/no-straight-roads-review/).
- **Patapon:** the enemy's side of the call-and-response is not described in the sources read.

### Inferences
- (inference) "How many may act per beat" is not stated in any source read. NecroDancer implies one action per actor per beat, with cadence divisors (1, 2, 4) per enemy type. For DT's three T1 enemy types (Basic Bot, Flying Drone, Heavy Unit) divisors map naturally: bot every 2 beats, drone every beat or on a pattern, heavy every 4 with a visible wind-up.
- (inference) NSR's "parryable attacks only on the beat" suggests a rule to keep telegraphs unambiguous: only on-grid attacks can be graded, so off-grid hazards are a visual language reserved for non-gradable threats.

### Gaps
- No source on a cap on simultaneous enemy actions per beat in any game. Hellsinger's exact enemy beat rules and BPM's attack patterns were not found. Hi-Fi Rush enemy telegraph rules not found.

## 4. Instruments as verbs (Patapon drums, Rock Band parts, NSR) and DT's five-member band

### Takeaway
Patapon is the clearest "instrument as verb" system but is one instrument with four verbs. NSR splits enemy attacks (soundtrack) from player attacks (the player's own instruments). No source was found on per-part verbs in Rock Band.

### Cited Findings
- Patapon: four drum sounds are the whole input vocabulary, with sound design chosen so each press "feel[s] good and commanding"; Adachi blended percussion from many countries because plain congas and bongos were not satisfying. [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468)
- NSR: player attacks use the player's own instruments while enemy attacks come from the soundtrack [S] — [RPGamer](https://rpgamer.com/2019/06/no-straight-roads-e3-impression/).
- Rhythm Doctor and Thumper both show one-input games can support wide variety by changing the rhythm rather than the buttons [P2] — [Game Developer Rhythm Doctor](https://www.gamedeveloper.com/design/using-medical-stories-and-heart-conditions-to-create-musical-challenges-in-rhythm-doctor), [Game Developer Thumper Q&A](https://gamedeveloper.com/audio/q-a-the-rhythm-violence-of-i-thumper-i-).

### Inferences
- (inference) With two T1 characters, "instrument as verb" can be implemented as the same input on the same grid with different effect and tone (Vox: voice, Ciphera: rig), keeping the grammar identical and only varying what a graded token does. This also keeps the grammar cheap to extend to the other three members later.

### Gaps
- Rock Band parts as verbs, Theatrhythm party roles, and any "switching characters on the beat" precedent: no sources found.

## 5. Adaptive music: how layers respond to performance

### Takeaway
Hellsinger is the only well-evidenced case: tracks authored as parallel stems of identical length, with layers added or removed as Fury changes, smoothed.

### Cited Findings
- Composers built tracks around Fury with "5 gradations of instrumentation"; Fury gains or losses add or remove layers with "some delay and smoothing"; at the top tier vocals enter when the player performs well. [P2] — [Game Developer](https://gamedeveloper.com/design/shredding-for-satan-how-i-metal-hellsinger-i-designed-fps-harmonies-in-hell). Search summaries describe four identical-length stems per track and note sources disagree on layer count [S] — [Windows Central](https://www.windowscentral.com/gaming/metal-hellsinger-interview-composing-the-music-soundtrack-with-two-feathers).
- Patapon: Fever "makes the music livelier" [P2] — [PlayStation Blog](https://blog.playstation.com/?p=193468). All tracks share one 120 BPM marching tempo, which made it hard to keep music from sounding samey [P2, same link].
- Patapon 3 music was chosen for clarity: "we wanted it to be clear when you were pushing the buttons correctly and when you were doing it wrong"; songs based on simple children's folk melodies where rhythm is the main element. [P2] — [Game Developer Patapon 3 Q&A](https://gamedeveloper.com/game-platforms/q-a-i-patapon-3-i-director-on-avoiding-needless-complexity-in-sequels)
- Metronomik composers were involved early in NSR [S via search summary] — [GameRevolution](https://www.gamerevolution.com/?p=557029).

### Inferences
- (inference) Fixed tempo and equal-length stems make layer switching trivial to keep on the grid; DT's tone-based choice signals (harmonic/missed note/silence/chord) could reuse the same layered stem bus.

### Gaps
- Thumper, BPM, Sayonara and Hi-Fi Rush adaptive-music evidence not found.

## 6. Developer statements on fairness and readability

### Takeaway
Consistent themes: keep rhythm visible and distinct, widen tolerance after seeing stress behaviour, keep the player in control of the feel, and make correct vs incorrect audibly obvious.

### Cited Findings
- Clark: accuracy requirements add frustration rather than challenge; players drift when stressed; fairness like Spelunky. [P1] — [deep dive](https://gamedeveloper.com/audio/game-design-deep-dive-finding-the-beat-in-i-crypt-of-the-necrodancer-i-). When only the player moves on the beat "it makes it more difficult for players to get into the groove". Same link.
- Johanas: "important not to lose what makes it accessible and approachable". [P2] — [Wccftech](https://wccftech.com/hi-fi-rush-qa-with-director-john-johanas-on-reception-working-with-mikami-and-more/)
- Azman: first prototype had "much too steep of a learning curve"; simpler levels were added before it. [P2] — [Game Developer Rhythm Doctor](https://www.gamedeveloper.com/design/using-medical-stories-and-heart-conditions-to-create-musical-challenges-in-rhythm-doctor). One-button design also helped adapt for blind players. Same link.
- Kotani: music chosen so it is clear when you press correctly and when you do not. [P2] — [Game Developer Patapon 3 Q&A](https://gamedeveloper.com/game-platforms/q-a-i-patapon-3-i-director-on-avoiding-needless-complexity-in-sequels). Also that sequels tend toward complexity and he layered RPG systems above simple core play. Same link.
- Flury (Thumper): "How do you make that stuff readable but still look cool?" [P2] — [Game Developer Thumper Q&A](https://gamedeveloper.com/audio/q-a-the-rhythm-violence-of-i-thumper-i-)
- Hellsinger visual beat cues are peripheral. [P2] — [Game Developer](https://gamedeveloper.com/design/shredding-for-satan-how-i-metal-hellsinger-i-designed-fps-harmonies-in-hell)

### Inferences
- (inference) Accessibility: DT's rule that choices carry no UI and are signalled by tones makes an audio-only readable beat important; a beat meter option (Hi-Fi Rush) and a calibration setting (NecroDancer) are cheap, evidenced mitigations.

### Gaps
- No developer statements retrieved from BPM, Pistol Whip, Sayonara Wild Hearts or Theatrhythm teams.

## 7. Candidate grammars for DT (options, not decisions) and DT translation

### Takeaway
Three options that respect the T1 lock (no combo system): A per-beat single-action grid, B call-and-response phrases (best fit for the enviro-puzzle and micro-choice), C an on-beat quantised attack with graded outcome. They can be mixed (e.g. C for combat, B for puzzles), but each has trade-offs and the choice is the author's.

### Cited Findings
- See sections 1 to 6 for the evidence behind each option.

### Inferences
**Option A. Per-beat grid (NecroDancer/Hellsinger lineage).** One graded action per active-member per beat; any press is judged Perfect/Good/Poor/Miss against the nearest beat; a Miss is a lost action, not a death. Enemies act on divisors of the beat with player priority on ties. Recognition: incremental, no sequence needed. Rests are simply beats with no input (not graded). Pros: smallest to build in Godot, easiest to calibrate (autocalibration per Clark), fairest telegraphs. Cons: the "on every beat" pressure can feel mechanical and may wear out in a long fight; Clark's own finding that stress causes drift applies. Ties to: growth-credit log and pair-bond integer are written per graded beat.

**Option B. Call-and-response phrases (Patapon lineage).** Enemy or puzzle device states a one-measure pattern of tokens (press, rest, hold); the player repeats it in the next measure. Tokens are buffered and compared incrementally (cursor advances on each beat; a wrong or early token fails the phrase at that beat rather than waiting for the measure end, which gives faster feedback; this choice is unverified against Patapon). Pros: natural fit for the enviro-puzzle (a door or machine speaks, Ciphera's rig answers) and the micro-choice (answer-in-tone, tied to the tone-signalling rule); rests and holds are explicit like Rhythm Doctor; clean for "music as language". Cons: phrase length and variety must stay small (Kotani's complexity worry, "don, dodon, dodon" difficulty); the scope lock needs a decision on whether a fixed single-measure phrase counts as a "combination of button presses" that T1 allows, since the author said no combo system in T1. Treat B as a puzzle/dialogue grammar, not a chained attack system, unless the author says otherwise.

**Option C. Free attack snapped to the beat (Hi-Fi Rush lineage).** Press any time; the attack's impact is quantised to the next beat or subdivision and the grade scales damage and feedback rather than whether the hit lands (soft-fail). Pros: the most forgiving, matches the "player in control even if not perfect" statement [P2]; fits Perfect/Good/Poor/Miss notes. Cons: the actual Hi-Fi Rush snapping mechanism is not confirmed from a primary source, so animation stretching vs alternate clips remains a build decision; combos are a natural extension which T1 excludes, so keep to single actions in T1.

**Instrument-as-verb note.** All three options can give Vox and Ciphera different effects on the same token grid.

**Borrow / Adapt / Enhance / Avoid**

| Item | Verb | Tier | DT system | Note |
|---|---|---|---|---|
| Player and enemies act on the same beat, player wins ties (NecroDancer, P1) | Borrow | T1 | Rhythm combat | One action per actor per beat |
| Enemy cadence divisors 1/2/4 per type (NecroDancer, S) | Adapt | T1 | Basic Bot, Flying Drone, Heavy Unit | Map each type to a divisor |
| Autocalibration with a capped leaky integrator (P1) | Borrow | T1 | Growth-credit log, input capture | Protects credit fairness |
| Soft-fail scoring, grade scales effect (Hi-Fi Rush, P2) | Adapt | T1 | Perfect/Good/Poor/Miss | Miss still lands as a weak action |
| Optional beat meter (Hi-Fi Rush, P2 snippet) | Adapt | T1 | Accessibility | Optional, since DT is audio-first |
| Explicit rest/hold marks (Rhythm Doctor, P2) | Adapt | T1 | Enviro-puzzle phrases | Use DT's own marks |
| Call-and-response phrase (Patapon, P2) | Adapt | T1 (puzzle) / T1.5 | Enviro-puzzle, micro-choice | Confirm vs combo lock |
| Fever/Fury chain driving music layers (Patapon, Hellsinger) | Adapt | T1 | Music as language, Wave tone | Layers on a shared bus |
| Parryable attacks only on the grid (NSR, P2 snippet) | Adapt | T1 | Heavy Unit telegraph | Verify against the page |
| Chained multi-press combos, aerial swaps | Avoid | out of T1 | Combo system | Scope lock |
| Hard-fail death on missed beat | Avoid | any | Combat | Clark widened the window because of frustration |

### Gaps
- None of the three options has been run or prototyped. No Godot binary is on PATH in this environment, so nothing was tested; per CLAUDE.md the author would need to supply their Godot executable to try a beat-grid prototype.

## Design questions this raises for DT
1. **Grammar choice per encounter type:** should combat use Option A or C, and puzzles/the micro-choice use Option B, or one grammar everywhere? (Rhythm combat, enviro-puzzle, micro-choice)
2. **Scope lock:** does a one-measure call-and-response phrase count as the "combo system" that T1 excludes? (Scope lock vs enviro-puzzle)
3. **Miss semantics:** is a Miss a lost action, a weak action, or a damage event, and does it break the hidden pair-bond integer or just skip a growth credit? (Perfect/Good/Poor/Miss, pair-bond, growth-credit log)
4. **Enemy cadence:** which beat divisors for Basic Bot, Flying Drone and Heavy Unit, and may more than one enemy act on the same beat? (Enemy telegraphing)
5. **Calibration and accessibility:** autocalibration, a manual offset and an optional beat meter in T1, given audio-only tone signals? (Input capture, tone signalling)
6. **Instrument verbs:** same token grid with different effects for Vox and Ciphera, or different input vocabularies? (Switching, five-member band later)
