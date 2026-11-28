# Narrative gap-fill: case studies not reached by track 07 (DT track 12)

Scope and honesty note. Date of all searches and fetches: 2026-11-05. About 23 tool calls. The search tool returned summaries and the fetch tool often returned truncated or thin pages (PC Gamer Frostpunk, RPG Codex Disco Elysium and the Fallout slides page all failed or came back empty). Result: most findings below are secondary or tertiary, and I could not obtain primary developer quotes on several of the questions that matter most (Witcher delayed-consequence cost, Disco Elysium state tracking, Quarry absence handling, Blasphemous/Axiom Verge/Lost Crown lore delivery). Those are listed under Gaps and not asserted. Nothing from track 07 is repeated. All DT options are options with trade-offs, not canon rulings. No decompilations or datamines were used, so no legal-status caveats apply.

## 1. Delayed and compounding consequences: Witcher 2 Act 2 split, Witcher 3

### Takeaway
The Witcher 2 Chapter 1 choice (Roche or Iorveth) sets a largely separate Chapter 2, and the game's ending count was later clarified as "states of the world" rather than 16 authored endings. I found no CD Projekt statement on cost; the Witcher 3 evidence is about reveal timing and a risky, long, hand-built quest, not about a delayed-consequence system.

### Cited Findings
- Witcher 2: the player's Chapter 1 choice between assisting Iorveth or Roche "sets the path of the second chapter" (article narration, no named speaker). — [Wikipedia, The Witcher 2](https://en.wikipedia.org/wiki/The_Witcher_2:_Assassins_of_Kings)
- Devs said 16 endings (Eurogamer, 2010-09-01), later clarified as 16 "states of the world" by the game's end (Eurogamer, Wesley Yin-Poole, 2010-11-30), as cited by Wikipedia. I did not open the Eurogamer originals. — [Wikipedia, The Witcher 2](https://en.wikipedia.org/wiki/The_Witcher_2:_Assassins_of_Kings)
- Witcher 2 import: GOG encouraged importing saves from the first game (Techie Buzz 2011-05-10, via Wikipedia). Enhanced Edition added about 4 hours of gameplay and 36 minutes of cinematics (via Wikipedia). — [Wikipedia](https://en.wikipedia.org/wiki/The_Witcher_2:_Assassins_of_Kings)
- Scale of the split (weak, guide site): Roche's camp cannot provide Vergen's quests, merchants, conversations or Saskia's-coalition viewpoint; Act 2 is heavily divided and Act 3 converges. A Steam thread says Chapter 2 is "completely different" per choice. Search summary only; guide author unclear. — [ConsolePulse guide](https://consolepulse.com/multiplatform/the-witcher/guides/why-witcher-2-has-trilogys-bravest-choice-design); [Steam discussion](https://steamcommunity.com/app/20920/discussions/0/535151589907821230)
- Witcher 3 (Bloody Baron): the reveal of the Baron's abuse was deliberately scheduled after the player learns he sheltered Ciri (Wikipedia summary). Lead quest designer Paweł Sasko said he "made so many mistakes" on it (Kotaku headline), it runs about four hours, and its script was reported at 40 pages before dialogue was added (GamesRadar headline). I only saw headlines and summaries, not the bodies. — [Wikipedia, The Bloody Baron](https://en.wikipedia.org/wiki/The_Bloody_Baron); [Kotaku](https://kotaku.com/a-witcher-3-dev-reflects-on-its-most-memorable-quest-the-bloody-baron-quest-i-made-so-many-mistakes-2000730612); [GamesRadar](https://www.gamesradar.com/games/the-witcher/the-first-script-for-the-witcher-3s-best-quest-was-40-pages-long-before-a-single-line-of-dialog-was-even-added)
- Witcher 3 (fetched): Sasko proposed killing Vesemir because "I needed an actual event that would break her inside" (Ciri). The writers resisted but concluded it was a good decision. He said it worked because "[Vesemir] is built up really well and prepared, you get to know him." The same piece says the team wanted choices "no one else will do." The page says nothing on branching cost. — [80.lv](https://80.lv/articles/the-witcher-3-developer-on-hard-decisions-killing-important-characters/)
- Unverified: one search summary says an Iorveth subplot was cut late from Witcher 3 for poor integration and resource cost. I could not trace the source; do not cite it. 

### Inferences
- (inference) Witcher 2 is the "expensive fork" end of the spectrum: a mid-game split into near-separate content, merged back at an act boundary. DT's Wave-Lock already provides act boundaries; a single fork per two Waves would be the affordable version. This only fits T1.5 or later.
- (inference) "16 states of the world" suggests designers counted a world-state vector rather than 16 hand-built finales. That matches track 07's roster-vector option for FLAG-02.
- (inference) Sasko's Vesemir remark supports a rule for DT loss scenes: the death lands because the character was built up earlier, so loss quality depends on pre-loss screen time, not on branch count.
- (inference) The Baron reveal ordering is an example of the Information Ordering Contract at scene scale: the writer sequences facts so a later judgement is made with earlier facts held.

### Gaps
- No CD Projekt designer statement on the cost of the Act 2 split or of Witcher 3 delayed consequences was found (searches returned none; GDC and developer-blog sources not reached).
- No source on how Witcher 3 stores consequence flags.

## 2. Systemic and voiced interiority: Disco Elysium

### Takeaway
Skills are 24 inner voices that speak in dialogue with advice conditioned on points invested; the Thought Cabinet is a slot-limited, time-based internalisation system that mixes costs and bonuses. I found no developer talk on how state is tracked internally.

### Cited Findings
- 24 skills in four attributes (Intellect, Psyche, Physique, Motorics), six each. Skills "can speak directly to the player to influence their decisions", with advice dependent on points invested. Checks are two six-sided dice. High skills carry drawbacks (high Drama gives hysterics and paranoia; high Electrochemistry gives substance abuse), which the article says discourages minmaxing. — [Wikipedia, Disco Elysium](https://en.wikipedia.org/wiki/Disco_Elysium)
- Thought Cabinet: thoughts unlock through conversation and internal monologue, are internalised over set in-game hours, and complete with benefits, sometimes with negatives. Few slots at start, more with levels. Example: "Hobocop" lowers composure with NPCs while internalising, then doubles income from recycling. A skill point can forget a thought, losing its bonuses for that playthrough. ZA/UM compared it to Fallout traits. — [Wikipedia](https://en.wikipedia.org/wiki/Disco_Elysium)
- Team focus on "microreactivity": small choices, such as an embarrassing comment, that ripple through events. Eight writers assisted lead writer Robert Kurvitz. The Final Cut added voice work for nearly 100 characters, over 1.2 million words (per Hindpere). — [Wikipedia](https://en.wikipedia.org/wiki/Disco_Elysium)
- Event-report line: the Thought Cabinet was "an extremely difficult concept to implement" and did not come together until late in development. Only a snippet of the EGX 2019 developer session was retrievable. — [RPG Codex, EGX 2019 session](https://rpgcodex.net/article.php?id=11268)
- Secondary: Hindpere told IGN that the skill voices personify parts of the amnesiac cop's mind (search summary, IGN article not opened). — [Wikipedia, ZA/UM](https://wikipedia.com/wiki/ZA/UM)

### Inferences
- (inference) For Vox's vocal modes: skills-as-voices suggests each vocal mode (for example Clear, Distorted, Fragmented, Encrypted, or DT's own mode names) can be a "voice" that offers or withholds options based on how much the player has invested in it. Trade-off: every voice needs lines in every scene, so cost scales with voices times scenes. Mitigation: only a few scenes per Wave carry voice interjections.
- (inference) The hidden stress system maps onto the Thought Cabinet's pattern of a visible slot cost and a mixed-sign payoff: a thought with a penalty while "internalising" is a cheap way to make stress felt through changed available lines rather than a meter. Matches the brief's "tells only" rule.
- (inference) Skill drawbacks (high Drama causes hysteria) show a precedent for strong abilities having a narrative side effect, which suits tone-tagged vocal modes.

### Gaps
- No developer talk found on how Disco Elysium tracks state (variables, check history, thought triggers). The GDC and Kurvitz blog sources were not reached.
- No primary quote on why skills speak as voices.

## 3. Loss and morale: Frostpunk, The Quarry, Darkest Dungeon

### Takeaway
Frostpunk tracks Hope and Discontent as two coupled meters driven by laws and events, with a fail state when they diverge; Darkest Dungeon surfaces mental state as a stress threshold with a dramatised check and per-class barks; The Quarry lets any character die, but I found no source on how scenes absorb absence.

### Cited Findings
- Frostpunk: PC Gamer says discontent came naturally from building the society, hope from research. Low Hope with high Discontent leads to overthrow and a game end. Laws and buildings drive both meters. Extreme paths can reach totalitarian rule that sidelines the system. Slant argues the system's limits show when changes have little operational consequence. Summaries only; the PC Gamer page failed to fetch. — [PC Gamer](https://www.pcgamer.com/frostpunk-developers-on-hope-misery-and-the-ultimately-terrifying-book-of-laws); [Wikipedia, Frostpunk](https://en.wikipedia.org/wiki/Frostpunk); [Slant](https://www.slantmagazine.com/games/review/frostpunk)
- Darkest Dungeon stress (fetched): stress comes from critical hits, curiosities and party interaction, shown numerically ("+20 Stress!"). At 100 the hero faces an Affliction check; a fail gives a temporary reduced-effectiveness state (selfish, abusive, hopeless, paranoid, afraid, masochistic, irrational), a pass gives a Virtued state (five virtues). A banner, a fullscreen splash after a tense pause and a symbol above the head surface the result; custom barks per class-and-affliction pair precede the afflicted action; behaviours are not fully listed so players learn by observation. Designers wanted to "capture the human response to stress" and create moments of lost control. The page does not mention narrator lines at affliction. — [Game Developer, Affliction deep dive](https://gamedeveloper.com/design/game-design-deep-dive-i-darkest-dungeon-s-i-affliction-system)
- Darkest Dungeon narrator: Wayne June voiced it; Red Hook announced his death in early 2025; a Japanese report says June had given permission for AI use of his voice and the studio said it would not use it (paraphrase of a non-English article; unverified in English). — [GameBusiness.jp](https://www.gamebusiness.jp/article/2026/05/12/26903.html)
- The Quarry: all nine playable characters can die; Will Byles said the hardest writing challenge was tracking where all nine characters were and the effects of choices; reported 1,000-page script and well over 100 endings (secondary, via Wccftech or GamesRadar headline claims of 186). A "Death Rewind" feature exists (NME, not opened). — [SegmentNext interview](https://segmentnext.com/the-quarry-interview); [Wikipedia](https://en.wikipedia.org/wiki/The_Quarry_(video_game)); [GamesRadar](https://gamesradar.com/the-quarry-has-a-mind-boggling-186-endings-for-you-to-uncover); [NME](https://www.nme.com/news/the-quarry-game-director-outlines-how-the-death-rewind-system-will-work-3216739)

### Inferences
- (inference) DT's hidden stress value fits Darkest Dungeon's threshold-and-check shape, but DT's rule of "shown only through body and augment tells" means the splash and numeric display must be replaced with animation and audio. The cost advantage: Darkest Dungeon's per-class-by-affliction bark matrix is a content grid DT can shrink to 2 characters by 2-3 tells for T1.
- (inference) Frostpunk's Hope and Discontent pairing suggests two band-level values (for example cohesion and strain) rather than five per-member numbers; Slant's critique warns that meters need visible operational consequences, which DT's signal states (Clear to Fragmented) could provide.
- (inference) The Quarry evidence supports track 07's finding that tracking is the burden for writers, not authoring prose. A per-member status enum (FLAG-13) is the standard mitigation.

### Gaps
- No source on how The Quarry scenes absorb a dead character's absence.
- No Frostpunk primary quote on content cost or the law system's authoring.
- No Darkest Dungeon source on narrator loss-framing (the narrator-reacts-to-failure rationale). The Game Developer "kicking you when you're down" interview was listed but not opened. — [Game Developer](https://gamedeveloper.com/business/-i-darkest-dungeon-i-designing-for-despair-and-kicking-you-when-you-re-down)

## 4. Ending assembly: Fallout slideshows, Chrono Trigger NG+, authorable matrices

### Takeaway
Fallout slides appear to key off variables the game already tracks, but the only source I found is an unofficial wiki page I could not open; Chrono Trigger's ending count varies by version and sources disagree. I found no published GDC advice on authorable matrices.

### Cited Findings
- Fallout: New Vegas ends in a narrated slideshow reflecting choices; Chris Avellone wrote some of the slides and discussed the abrupt ending in interviews. — [PC Gamer](https://www.pcgamer.com/uk/chris-avellone-explains-fallout-new-vegas-abrupt-ending); [Prima Games](https://primagames.com/news/fallout-new-vegas-writer-chris-avellone-explains-where-ending-went-wrong)
- Fallout 2 endings are influenced by choices and shown after the Enclave control station is destroyed. — [Fallout wiki](https://fallout.gamepedia.com/Fallout_2_endings)
- Unverified: an unofficial mirror attributed to Tim Cain says slide conditions can piggyback on variables already tracked (quest states, NPC status, faction reputation). The page was behind a login redirect, so I could not read it. — [turbo-wiki mirror](https://turbo-wiki.pages.dev/tim-cain/programming/implementing-endgame-slides)
- Chrono Trigger: sources disagree on the count (SNES 12, DS/PC 13, or 13 or 14 including a joke ending); several endings need New Game+; the Time Egg outcomes vary by whether you learned of it and whether Epoch crashed. Use the fan encyclopaedias with caution. — [Chrono Compendium](https://chronocompendium.com/Term/Endings_(Chrono_Trigger).html); [Caves of Narshe](https://mail.cavesofnarshe.com/ct/endings.php?ctmode=nds); [Thonky](https://thonky.com/chrono-trigger/endings)

### Inferences
- (inference) Fallout-style slides are the cheapest modular epilogue: one card per tracked fact, shown in sequence. Trade-off: it reads as a ledger and can feel flat; pairing each card with its member's instrument state (present, silent, distorted) gives DT a musical rather than textual ledger.
- (inference) Chrono Trigger shows that NG+ can host extra endings by letting the player reach the final boss early with persistent state, which would suit FLAG-12 and FLAG-09 together, at the cost of needing a persistent-state spec.
- (inference) Authorability rule stated for DT: ending conditions should read only flags that already exist for gameplay reasons (no ending-only flags), and every flag that feeds an ending should have a scene or audio consequence elsewhere. This is my synthesis; no published GDC guidance was found.

### Gaps
- No primary Tim Cain or GDC source on slide implementation was readable.
- No published advice on authorable ending matrices found.
- No developer source on Chrono Trigger NG+ design intent (Masato Kato statements not found).

## 5. Music-signalled meaning: No Straight Roads, UNBEATABLE, Hi-Fi Rush, Hellblade

### Takeaway
UNBEATABLE is the closest premise match: a band fighting police in a world where music is outlawed, with rhythm combat as the emotional carrier. Hellblade uses binaural voices as both mental-state portrayal and information channel. Hi-Fi Rush makes the world itself move to the beat but with forgiving timing.

### Cited Findings
- UNBEATABLE (D-Cell Games, Playstack): the world outlaws music; Beat fights police, learns about creatures that appear when music plays, and forms a band with three outlaw musicians. Antagonist line: "Music doesn't make us feel things. Music IS feeling. Art IS feeling." Rock-punk soundtrack; action rises with characters' feelings; story told out of order; world rules and backstory left mostly unstated; over 10 hours. Co-director and writer RJ Lake: "Once you say too much, you risk robbing someone of their own experience." He drew more from movie needle drops and title sequences than music videos, and was directed to rewrite the story repeatedly. — [Game Developer, Narrative Notebook #5](https://www.gamedeveloper.com/design/narrative-notebook-5-unbeatable-s-music-video-vibes-can-t-be-beat)
- UNBEATABLE release: a wiki lists 9 December 2025 (weak source; a second weak source says it was delayed for console QA). Announced with a 2021 Kickstarter; pre-production began early 2018. A Gamescom 2025 interview with Andrew Tsai covers why music and storytelling are inseparable (I did not open it). — [UNBEATABLE wiki](https://unbeatable.wiki.gg/wiki/UNBEATABLE); [Indiecator](https://indiecator.org/2025/08/31/andrew-tsai-unbeatable-interview/)
- No Straight Roads (Metronomik, 2020): rock versus EDM premise; Wan Hazmer said the team wanted characters whose reasons to perform music are human rather than simply villainous (secondary). — [Wikipedia](https://en.wikipedia.org/wiki/No_Straight_Roads); [Unreal Engine interview](https://www.unrealengine.com/en-US/developer-interviews/no-straight-roads-innovative-design-fuses-rhythm-based-gameplay-with-dynamic-action)
- Hi-Fi Rush: attacks land off-beat but hit harder on-beat ("more carrot than stick"); pipes and platforms move to the beat; Johanas said many small touches in sound and animation were needed to encourage on-beat input and that "took a really long time"; he also described designing "backwards" from the desired result (GDC 2024 session title). Paraphrased from search summaries. — [GamesRadar](https://gamesradar.com/how-hi-fi-rush-came-together-to-deliver-kinectic-action-comedy-inspired-by-edgar-wright-and-shaun-of-the-dead); [GDC 2024 session](https://schedule.gdconf.com/session/developing-hi-fi-rush-backwards-and-finding-our-positive-gameplay-loop/899845)
- Hellblade: binaural recording (3Dio microphone) was described by Ninja Theory as critical to portraying voice-hearing; a guide notes voices warn of incoming attacks and the game has no HUD; reviewers call headphones a requirement; the team worked with neuroscientists and people who live with psychosis. Secondary sources. — [3Dio](https://3diosound.com/pages/gaming); [The Sound Architect](https://www.thesoundarchitect.co.uk/hellblade-senuas-sacrifice-setting-the-gold-standard-for-audio/); [Shacknews review](https://www.shacknews.com/article/100887/hellblade-senuas-sacrifice-review-truly-disturbing)

### Inferences
- (inference) UNBEATABLE's "withhold rules, let sound carry feeling" supports DT's no-label choice signalling, and its out-of-order telling is a precedent for non-linear Wave presentation. The sourced evidence covers premise and writing stance only; I found no statement of how it ties music to consequence mechanically.
- (inference) Hellblade shows voice-as-information: a vocal cue that doubles as gameplay warning. For Vox, a "signal state" could change what the voice layer tells the player (Clear gives accurate cues, Distorted gives misleading or late ones). Trade-off: unreliable cues can feel like unfair difficulty without a tutorial moment.
- (inference) Hi-Fi Rush's carrot-not-stick timing is compatible with DT's tiered Perfect/Good/Poor/Miss notes, and its beat-synced world suggests Decay Map or glitch-ladder elements could pulse to the track tempo, tying world decay to music cheaply.

### Gaps
- No evidence on how No Straight Roads connects choices or boss outcomes to narrative consequence; sources covered premise only.
- UNBEATABLE design statements on music-as-consequence mechanics and the 2025 release date confirmation from an authoritative source were not found; release date rests on a weak wiki.
- Hellblade GDC talk content on voice design was not retrieved.

## 6. Narrative delivery in Metroidvanias

### Takeaway
Blasphemous and Ender Lilies deliver lore mainly through item descriptions and environmental details, with a known risk of sameness and wandering. I found no developer source on NPC arcs reacting to exploration order, and none for Axiom Verge, Lost Crown or MIO NPC arcs.

### Cited Findings
- Blasphemous: lore via cryptic item descriptions and environment in a Dark Souls manner, left for the community to piece together. Fan-oriented source, low reliability. — [Shapes fandom page](https://cf-inc.shapes.inc/fandom/blasphemous)
- Ender Lilies: reviewers say every item carries a piece of lore, with letters, diary entries and relic descriptions painting the world; one review warns that item-description storytelling can feel samey but says Ender Lilies avoids this; another notes large areas where item locations are unclear. — [RPGamer](https://rpgamer.com/review/ender-lilies-quietus-of-the-knights-review/); [RPGFan](https://rpgfan.com/review/ender-lilies-quietus-of-the-knights); [Siliconera](https://siliconera.com/review-ender-lilies-quietus-of-the-knights-is-about-perseverance)
- Signalis (rose-engine): Yuri Stern finds sorting endings into good, bad or true "disheartening"; Barbara Wittmann said endings depend on overall playstyle and replay for others was not intended; PC Gamer calls the storytelling intentionally fragmented. A 2024 GDC paper analysis exists (not read). — [PlayStation Universe](https://www.psu.com/news/signalis-doesnt-have-a-good-bad-or-true-ending-says-developer/); [Punished Backlog](https://punishedbacklog.com/signalis-ending-explained-dream); [PC Gamer review](https://pcgamer.com/signalis-review); [GDC Vault PDF](https://media.gdcvault.com/gdc2024/GNR/Papers/RaviButler_SignalisAnalysis.pdf)
- MIO: executive producer Sarah Hourcade said less than a quarter of the world-building made is clearly told in the game, though it fed artists, level designers and animators. — [GamingBolt interview](https://gamingbolt.com/?p=635490)
- Prince of Persia: The Lost Crown: director Mounir Radi talked about platformer "musicality" and combat and platforming following one rhythm; one review calls the story needlessly convoluted and forgettable. — [GamesRadar](https://www.gamesradar.com/prince-of-persia-the-lost-crowns-game-director-kept-singing-at-his-developers-to-make-sure-the-combat-and-platforming-followed-the-same-rhythm); [Prima Games](https://primagames.com/featured/prince-of-persia-the-lost-crown-interview-with-cinematic-lead-joseph-antoine-clavet-on-making-a-legend)

### Inferences
- (inference) Item-text lore is the cheapest any-order delivery: each fragment is self-contained, so coherence depends on writing every fragment to be true under any reading order. DT can enforce this with the facts-held tags from track 07, with an extra rule that no fragment may name a fact the player cannot yet hold.
- (inference) MIO's "show a fraction, build the rest" fits a solo developer: write a lore bible far larger than the player sees, and let it constrain environment art and item text.
- (inference) Signalis's rejection of good/bad/true labels is consistent with DT's no-label choice rule; its note that endings follow overall playstyle is a precedent for FLAG-02 endings keyed to aggregate behaviour rather than a single choice.
- (inference) Because DT characters see only interactables they have skills for, character-specific item text is a natural low-cost second layer: the same object yields different lore per character.

### Gaps
- No developer source on Axiom Verge's lore delivery (not reached).
- No source on NPC arcs reacting to exploration order in any of the six games.
- No developer statement from Blasphemous (The Game Kitchen) or Ender Lilies (Adglobe) on narrative design; both rely on reviews.

## DT translation table

| Item | Verdict | Tier | DT system | Note |
|---|---|---|---|---|
| Witcher 2 single big fork re-merging at an act boundary | Adapt | T2 | Wave-Lock, branches | One fork per two Waves; costliest pattern; not for T1 |
| Count world "states" not authored endings (Witcher 2) | Borrow | T2 | FLAG-02 | Pairs with roster-vector option |
| Build up a character before loss (Sasko on Vesemir) | Borrow | T1.5 | Loss scenes, FLAG-13 | Give each member early screen time before any absence |
| Sequence reveals so judgement follows held facts (Baron) | Adapt | T1 | Information Ordering Contract | Gate on facts-held tags |
| Skills as voices with advice by investment (Disco Elysium) | Adapt | T1.5 | Vox vocal modes | Few voice scenes per Wave to cap cost |
| Thought Cabinet slot with penalty while internalising | Enhance | T2 | Hidden stress, tells | Stress shown as changed options, not a meter |
| Hope and Discontent as two coupled band values | Adapt | T1.5 | Stress, signal states | Make operational effects visible (Slant critique) |
| Stress threshold plus dramatised check and per-state barks (Darkest Dungeon) | Adapt | T1 | Hidden stress | Replace splash and numbers with animation and audio tells; 2 characters only |
| Per-class-by-state bark matrix | Avoid | T1 | Stress | Grid grows fast; keep to 2 by 2-3 |
| Fallout-style slide ledger from existing flags | Adapt | T2 | FLAG-02 | Card per fact, plus instrument state |
| No ending-only flags | Borrow | T1.5 | FLAG-02, FLAG-09 | My synthesis, no published source |
| NG+ hosting extra endings (Chrono Trigger) | Adapt | T3 | FLAG-12, FLAG-09 | Needs persistent-state spec |
| Withhold rules, let sound carry feeling (UNBEATABLE) | Borrow | T1 | Tone signals, Waves | Premise match, evidence limited to writing stance |
| Voice as information channel (Hellblade) | Adapt | T1.5 | Vox, signal states | Unreliable cues in Distorted states need a teaching moment |
| Carrot-not-stick timing, beat-synced world (Hi-Fi Rush) | Adapt | T1 | Rhythm tiers, Decay Map | Pulse decay effects to tempo |
| Item-text lore true in any order (Blasphemous, Ender Lilies) | Borrow | T1.5 | World speaks | Prerequisite tags; per-character text variants |
| Show a quarter of the lore bible (MIO) | Borrow | T1 | World, art | Large bible, small exposure |
| Refuse good/bad/true labels (Signalis) | Borrow | T1 | Choice signalling, FLAG-02 | Aligns with no-label rule |
