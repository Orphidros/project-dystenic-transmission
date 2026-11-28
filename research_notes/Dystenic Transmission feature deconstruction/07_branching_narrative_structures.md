# Branching Narrative Structures for a Multi-Protagonist Metroidvania (DT track 07)

Scope note: research was capped at about 16 tool calls. Many web results were aggregators or fan sites; only claims a fetched or searched page supports carry a URL. Roughly half the requested case studies (Frostpunk, Darkest Dungeon, Disco Elysium, Citizen Sleeper, Kentucky Route Zero, Witcher 2/3, Spec Ops, Pathologic 2, Journey, Hellblade, No Straight Roads, UNBEATABLE, Blasphemous, Ender Lilies, Axiom Verge, Signalis, Lost Crown, MIO, Chrono Trigger, Fallout, Suikoden II, Live A Live, inkle/ink writing, Ingold's later talks, GDC branching-cost talks) were NOT reached. They are listed under Gaps, not asserted. Date of all fetches: 2026-11-05. All options below are options with trade-offs, not canon rulings.

## What structural patterns contain branching cost while preserving felt agency, and what did designers say about cost?

### Takeaway
Ashwell's taxonomy ties each pattern to an authoring cost and an agency feel: Gauntlet is cheapest, Time Cave and Sorting Hat multiply content, and Branch-and-Bottleneck needs heavy state tracking but yields a personalised story. Shipped character-death games (Until Dawn, Banner Saga) contained cost by keeping a fixed "fundamental story" and surfacing the consequence, and their writers still called the burden severe.

### Cited Findings
- Ashwell names Time Cave, Gauntlet, Branch and Bottleneck, Quest, Open Map, Sorting Hat, Floating Modules, Loop and Grow (with "spoke and hub" variant). Article is from 2015 and explicitly non-exhaustive; patterns blend. — [IFWiki mirror, Standard Patterns](https://www.ifwiki.org/Standard_Patterns_in_Choice-Based_Games)
- Cost statements in the same article: Gauntlet is "perhaps the easiest structure to author"; Branch and Bottleneck "has to be used in a fairly large piece"; Sorting Hat means the author "may end up effectively having to write several different games"; Floating Modules is "a challenging style to write for" and without large content "tends to collapse into a linear system". — [IFWiki](https://www.ifwiki.org/Standard_Patterns_in_Choice-Based_Games)
- Felt agency per pattern: Time Cave gives "vast freedom but little ability to comprehend it"; Gauntlet players "realise that they are on a constrained path"; Branch and Bottleneck lets the player build "a somewhat-distinctive story and/or personality"; bottlenecks can be invisible ("exquisite-corpse effect"). — [IFWiki](https://www.ifwiki.org/Standard_Patterns_in_Choice-Based_Games)
- Until Dawn: Supermassive built the Butterfly Effect to tell players a choice mattered and let them trace results; the team used a node-based tool linking story, script, interactions and gameplay so developers could "follow any thread to any consequence"; "the fundamental story remained the same"; a pregnancy subplot was cut as too distracting; the script was rewritten and scenes reshot for PS4; designers' expectations of a key choice split were wrong (players split near 50-50). — [Game Informer, Afterwords: Until Dawn, 2015-10-18](https://gameinformer.com/b/features/archive/2015/10/18/afterwords-until-dawn.aspx)
- Until Dawn co-writer Graham Reznick called the mechanic a "ridiculously exciting way to tell a story" but said holding every branch in mind was very difficult; Fessenden said Supermassive set the core plot and designers then checked the branching patterns would work. Reported as thousands of paths to hundreds of endings (Destructoid figure, secondary). All major playable characters can live or die. — [Wccftech interview coverage](https://wccftech.com/until-dawn-writer-the-butterly-effect-ridiculously-exciting/); [Destructoid](https://www.destructoid.com/until-dawn-has-hundreds-of-endings-and-thousands-of-branches/); [Wikipedia, Until Dawn](https://en.wikipedia.org/wiki/Until_Dawn)
- Banner Saga: writer Alex Thomas said making all choices matter was "probably the hardest thing I had to do"; choices decide who lives, who dies and relationships; the cast was large enough to lose allies without breaking the game; sequel written "as if every player had them all alive" while imports alter major plot points. Quotes are via republished interviews; originals not checked. — [GameBanshee interview](https://gamebanshee.com/news/112437-the-banner-saga-interview-v15-112437.html); [RPGamer interview](https://archive.rpgamer.com/games/indie/bannersaga2/bannersaga2int.html)
- Telltale: criticism is that decisions have "only a superficial impact" and the story proceeds regardless; Den of Geek notes Walking Dead S1 splits into distinct paths in only one episode; Game Informer notes Season Two was the first Telltale game with multiple endings; an Eludamos paper argues "choices don't matter" misses how they function. — [PC Gamer](https://pcgamer.com/im-over-the-fact-that-choices-dont-really-matter-in-telltale-games); [Den of Geek](https://www.denofgeek.com/games/the-walking-dead-false-promises-telltale/); [Game Informer 2015](https://www.gameinformer.com/b/features/archive/2015/02/03/why-your-choices-dont-matter-in-telltale-games.aspx); [Eludamos](https://eludamos.org/index.php/eludamos/article/view/vol9no1-2)
- Failbetter: storylets are "discrete chunks of narrative that can be played in any order, as many times as you like", controlled by qualities that "tell storylets what to do"; EB has "around sixty different kinds of narrative structure"; exile-style qualities (Mark of Cain) lock a storyline after completion. Kennedy later moved to "resource narrative" wording. — [Failbetter, Echo Bazaar Narrative Structures Part Two](https://www.failbettergames.com/echo-bazaar-narrative-structures-part-two); naming shift per [Emily Short 2016](https://emshort.blog/2016/04/12/beyond-branching-quality-based-and-salience-based-narrative-structures/) (already covered by prior report; cited for context only)

### Inferences
- (inference) DT's Wave-Lock chapters are close to Ashwell's Branch and Bottleneck with a Sorting Hat flavour: each Wave is a bottleneck, and state carried through it (who is alive, which tone was struck) decides which variants play. The cost warning applies: it only pays off if the piece is large enough for state to accumulate, and Sorting Hat variants multiply writing.
- (inference) Until Dawn's lesson for a solo dev is the cut-down version: keep one fixed plot spine, make death change who delivers beats, and surface "this mattered" through a signal. DT's musical tone is the cheap equivalent of the Butterfly Effect icon, with the Butterfly Effect's problem that players then know exactly when to save-scum; DT's no-label rule trades that away deliberately.
- (inference) Telltale's critique implies "felt agency" needs at least some visible divergence in scene content, not only in dialogue lines; a state variable with no scene consequence reads as an illusion.

### Gaps
- No primary source found for Failbetter's own statements on content cost (the fetched page did not discuss it). Not found: Kennedy's GDC 2016 "Choice, Consequence, Complicity" content, GDC branching-cost talks, inkle's writing on ink/structure (80 Days, Heaven's Vault), Ingold's post-2017 talks.
- No Telltale internal documentation on choice tracking; only critics.

## How do games keep coherent story when any member can die or leave (FLAG-13: abandoned vs deceased)?

### Takeaway
Shipped games use three levers: a cast large enough to absorb loss (Banner Saga), writing "as if everyone is alive" with swappable stand-ins (Banner Saga 2, ME2/ME3 plan), and a fixed spine with consequence-scaled variants (Until Dawn). ME2's mission is the clearest model of deterministic survival from stored variables, but I could not retrieve the exact formula.

### Cited Findings
- ME2 Suicide Mission: crew are assigned tasks by strength; "loyalty and suitability for the task determines whether they live or perish"; failing to upgrade the Normandy can kill crew; crew die gradually if Shepard delays attacking the base; if fewer than two squadmates remain Shepard also dies. Legendary Edition data: Garrus 98% survival, Mordin 90%. Developers knew letting most squadmates die was risky and planned to bring back ME1 characters in ME3 so deaths would not carry undue story impact. — [Wikipedia, Suicide Mission (Mass Effect 2)](https://en.wikipedia.org/wiki/Suicide_Mission_(Mass_Effect_2))
- Community guidance (weaker source): loyal squadmates live and disloyal ones die in the common case; a missing Thanix Cannon upgrade kills one of a named set; role placement matters. One modder calls the underlying mechanics "debatable". — [RPG Site guide](https://www.rpgsite.net/feature/11118-mass-effect-2-suicide-mission-choices-how-to-make-sure-everyone-lives-for-the-best-ending); [GamesRadar](https://gamesradar.com/mass-effect-2-loyalty-guide)
- Game Informer's ME2 survival feature explains rules in a flowchart image that text retrieval could not read. — [Game Informer 2010-06-04](https://www.gameinformer.com/b/features/archive/2010/06/04/how-to-save-or-kill-your-party-in-mass-effect-2.aspx?amp)
- Banner Saga: sequel treats every imported hero as potentially alive; final game lets characters "die left and right" while earlier game had almost no deaths (review claim). — [RPGamer interview](https://archive.rpgamer.com/games/indie/bannersaga2/bannersaga2int.html); [GameBanshee review](https://gamebanshee.com/k44ud)
- Octopath Traveler: reviewers say the eight members rarely interact outside battle and optional scenes; the sequel tries to interlink stories but "still feel like solitary tales at their core" (Shacknews). — [Shacknews review](https://www.shacknews.com/article/134209/octopath-traveler-2-review-score); [Nova Crystallis](https://novacrystallis.com/2023/02/octopath-traveler-ii-review/)

### Inferences
- (inference) Option A, "loyalty-gated survival" (ME2 style): store one value per member (trust/bond) plus a few mission-prep booleans; death is computed at a single climax. Cheap to author (one scene set plus per-member eulogy), but it makes loss feel deterministic and guide-solvable. Fits DT's one-event Wave finales.
- (inference) Option B, "injury-accumulation death" (DT's own optional permadeath, two unhealed injuries): spreads loss across play, so story must tolerate absence at any Wave. Costs the most writing because every post-death scene needs variants. Pair with ME3-style stand-ins or "empty-chair" lines to contain cost.
- (inference) FLAG-13 option: store one status enum per member (present / injured / abandoned / deceased / returned) rather than two booleans. "Abandoned" and "deceased" can then share most scene variants (absence) and differ only in a few lines, tone of the instrument's silence versus a held-out hook, and recoverability. This keeps writing near linear in cast size, but the music rule needs a decision: whether an abandoned member's instrument fades differently from a dead member's.
- (inference) Octopath's critique warns the opposite failure: five members with isolated chapter arcs and no cross-talk. DT's Wave-Lock chapters should keep one cross-character beat per Wave.

### Gaps
- Exact ME2 survival computation (loyalty plus per-role checks) not retrieved from a text source; the commonly cited rules are in image flowcharts. Recommend the report writer treat the above as qualitative.
- Not reached: Frostpunk, Darkest Dungeon narrative tone around loss, The Quarry specifics, Suikoden II recruitment/loss, Live A Live.

## How do any-order chapter structures preserve information ordering (Wave-Lock, Information Ordering Contract)?

### Takeaway
Ashwell's Sorting Hat, Quest and Open Map patterns show the trade: freer order means more reliance on state tracking, and Floating Modules collapses to linear without large content. Failbetter-style storylets handle order with gating qualities, which is the closest published mechanism to an information contract.

### Cited Findings
- Open Map relies on "extensive state-tracking both explicit and secret"; players have "more leisure to explore" but spend "less of their time advancing the story". Quest is organised by geography rather than time and "do[es] poorly" without state. — [IFWiki](https://www.ifwiki.org/Standard_Patterns_in_Choice-Based_Games)
- Storylets are playable in any order and unlocked by qualities, so a revelation can require a quality set by earlier reading. — [Failbetter](https://www.failbettergames.com/echo-bazaar-narrative-structures-part-two)
- NieR: Automata ships five main endings (A-E) and 21 others (F-Z); the first routes replay the story from different perspectives and later routes add content. Sources disagree on which playthrough maps to which route; one account is low reliability. — [GameRevolution](https://www.gamerevolution.com/guides/71797-nier-automata-a-guide-to-all-26-endings-no-spoilers); [Giant Bomb](https://www.giantbomb.com/wd/3030-49998); [GamesRadar](https://www.gamesradar.com/nier-automata-how-a-robot-powered-action-game-became-a-powerful-study-of-human-frailty)
- Hollow Knight: secondary sources say story is carried through environment, NPC dialogue, dream sequences and item descriptions with deliberate under-explanation. No source found confirming NPC arcs react to exploration order. — [Comicbook.com](https://comicbook.com/gaming/news/storytelling-depth-in-hollow-knight-and-silksong)

### Inferences
- (inference) Information Ordering Contract as data: tag each revelation with a prerequisite set (facts the player must already hold) and let the Wave-Lock only gate on those tags, not on room or character order. Any-order play then cannot expose a reveal early, and unmet prerequisites default to the ambiguous Distorted/Fragmented signal states rather than a hard block.
- (inference) NieR-style perspective routes give a low-cost order lock: replaying the same Wave from a different member adds meaning through new information (a fixed spine, a different viewpoint), not new spine content.
- (inference) Because Metroidvania gating already restricts order spatially, DT can lean on ability gates for coarse order and facts-held tags for fine order, a cheaper combination than Open Map's full state tracking.

### Gaps
- Not reached: Octopath II and Live A Live designer statements, Chrono Trigger NG+ endings, Disco Elysium and Kentucky Route Zero structure, the Metroidvania cases (Blasphemous, Ender Lilies, Axiom Verge, Signalis, Lost Crown, MIO). No source found that Hollow Knight NPC arcs depend on exploration order.

## Delayed, compounding and opaque/sensory feedback

### Takeaway
Evidence is thin. Undertale's morality is reported as carried by tempo, pitch and tonality changes in leitmotifs rather than a UI meter, which is the nearest precedent to DT's tone-as-feedback rule. Sayonara Wild Hearts shows a music-first structure designed as one emotional arc. Hi-Fi Rush and UNBEATABLE evidence was not obtained.

### Cited Findings
- Undertale (academic and fan analyses, mixed quality): tonal music for "good" choices and tonal ambiguity for "evil" ones (BGSU honors thesis); Genocide-route tracks are slowed and pitch-lowered; a recurring motif is altered by player morality; "But the Earth Refused to Die" is chant, white noise and heartbeat. — [BGSU honors thesis](https://scholarworks.bgsu.edu/honorsprojects/925); [Game Developer, Undertale leitmotifs part 2](https://www.gamedeveloper.com/audio/an-examination-of-leitmotifs-and-their-use-to-shape-narrative-in-undertale-part-2-of-2); [Undertale Wiki](https://undertale.fandom.com/wiki/But_the_Earth_Refused_to_Die). Track-level claims unverified by me.
- Sayonara Wild Hearts: composer Daniel Olsén says the game is built as album-like emotional arc; songs were shortened to a third or given buildup/drop for sequences; a playtest song shifted the game's tone. — [Uppercut](https://uppercutcrit.com/soundscapes-as-stories/); [Apple Developer, Behind the Design](https://developer.apple.com/news/?id=33kvkagk)
- Hi-Fi Rush: one reviewer notes music-synced world feedback but no music-adjacent solution to a late fire mechanic. — [Laptop Mag](https://laptopmag.com/reviews/hi-fi-rush)
- Until Dawn deliberately did the opposite of opaque: visible butterfly icons, so players could trace results. — [Game Informer](https://gameinformer.com/b/features/archive/2015/10/18/afterwords-until-dawn.aspx)

### Inferences
- (inference) Opaque feedback trades discoverability for dread; Until Dawn is the control case. A partial-disclosure option: no icon in play, but a post-Wave "echo" playback of which tones were struck (harmonic, missed, silence, chord) so consequence can be traced later without live save-scumming.
- (inference) Undertale-style drift (tempo/pitch change of an existing leitmotif) is far cheaper than composing branch tracks: one theme per member, with parametric degradations tied to tone counters, fits AudioStreamSynchronized/Interactive already in the build resources.
- (inference) Signal states (Clear/Distorted/Fragmented/Encrypted) can double as a delayed-consequence readout: a Wave opens in a state determined by earlier tones, giving compounding without new branches.

### Gaps
- Not reached: Witcher 2 Act 2 split and Witcher 3 delayed consequences, Spec Ops: The Line, Pathologic 2, Journey, Hellblade, No Straight Roads, UNBEATABLE (a prior search returned nothing on it), Disco Elysium thought cabinet, Citizen Sleeper, Kentucky Route Zero.

## What ending-matrix shapes fit a solo developer (FLAG-02 and FLAG-09)?

### Takeaway
Most reviewed evidence says shipped endings are assembled from a few stored variables plus modular epilogue fragments, with a fixed spine. NieR's 5 main plus 21 minor endings shows how a few "real" endings can coexist with cheap alternates. I did not obtain direct sources on Fallout slideshows, Undertale, or Chrono Trigger endings, so shapes below are options built from the sourced patterns.

### Cited Findings
- NieR: Automata has 26 endings, five main (A-E) and 21 additional (F-Z), the latter described as arising from doing things the game "doesn't really want you to do"; minor endings return you to the menu to continue from your last save. — [GameRevolution](https://www.gamerevolution.com/guides/71797-nier-automata-a-guide-to-all-26-endings-no-spoilers); [Giant Bomb](https://www.giantbomb.com/wd/3030-49998)
- Telltale Season Two was the first Telltale game with multiple endings (per Game Informer), after critics said S1 collapsed to one finish. — [Game Informer 2015](https://www.gameinformer.com/b/features/archive/2015/02/03/why-your-choices-dont-matter-in-telltale-games.aspx)
- Until Dawn reportedly reaches hundreds of endings from per-character survival combinations while the spine stays fixed. — [Destructoid](https://www.destructoid.com/until-dawn-has-hundreds-of-endings-and-thousands-of-branches/)
- ME2 deaths are tolerated by design because ME3 can bring back earlier characters; ME2's ending state is a per-squadmate survive/die vector. — [Wikipedia, Suicide Mission](https://en.wikipedia.org/wiki/Suicide_Mission_(Mass_Effect_2))

### Inferences (options, with trade-offs; no rulings)
- Option 1, "Roster vector plus one tone verdict": ending = (alive/abandoned/deceased per member, 5 values) x (one aggregate tone state: Clear/Distorted/Fragmented). Composed from modular epilogue cards per member. Authoring cost grows linearly with cast, not combinatorially. Drawback: endings feel assembled; mitigate with 3-5 hand-written "headline" cards that fire on thresholds.
- Option 2, "Few real endings, many cheap ones" (NieR shape): 3-4 fully authored endings keyed to two or three stored variables, plus short joke or failure endings. Cheapest for a solo dev, and can fund FLAG-09's secret ending as a chord-tone-gated fifth. Drawback: players who died or abandoned members may feel the main endings ignore them; add a one-screen roster acknowledgement.
- Option 3, "Perspective replay" (NieR/NG+ shape, FLAG-12): same spine retold with a different member plus new information; the matrix grows by viewpoint rather than branch. Drawback: needs a replay mode and ties the secret ending to NG+.
- Option 4, "Storylet ending" (Failbetter shape): ending scenes are storylets gated by qualities (member alive, tone count, secrets found); the first fully-satisfied set plays. Easiest to extend later and easy to unit-test as a table; drawback is that without authoring discipline, priority collisions occur, so keep a published ordering.
- (inference) Authorability rules drawn from Ashwell: cap the number of independent variables feeding endings (suggest at most 5-6), keep bottlenecks at each Wave end, and prefer additive epilogue fragments to whole-scene forks.

### Gaps
- No sources obtained for: Fallout slideshow ending construction, Undertale ending flags, Chrono Trigger NG+ endings (13 is commonly cited, unverified here), ME2/ME3 ending variable count, or published advice (GDC) on keeping an ending matrix authorable.

## DT translation table

| Item | Verdict | Tier | DT system | Note |
|---|---|---|---|---|
| Fixed spine with variant fragments (Until Dawn "fundamental story remained the same") | Adapt | T1.5 | Wave-Lock chapters | Branch content, not plot; one cross-character beat per Wave |
| Butterfly Effect visible icon | Avoid | T1.5 | Tone signals | Contradicts no-label rule; consider post-Wave echo instead |
| Node-graph tracing tool ("follow any thread") | Borrow | T1 | Choice flags | Implementation covered by tooling track |
| Loyalty-plus-prep survival at a climax (ME2) | Adapt | T2 | Optional permadeath, Wave finales | Per-member bond value; not needed in T1 (permadeath out of scope) |
| Stand-ins and "as if everyone alive" writing (Banner Saga 2, ME3 plan) | Adapt | T2 | FLAG-13 abandoned vs deceased | Contains cost of variants |
| Single per-member status enum | Enhance | T1.5 | FLAG-13 | Present/injured/abandoned/deceased/returned |
| Ashwell Branch-and-Bottleneck with invisible bottlenecks | Borrow | T1 | Wave-Lock | Gate on facts-held tags |
| Storylet/quality gating for revelations | Adapt | T1.5 | Information Ordering Contract | Unmet prerequisites default to Distorted/Fragmented |
| Undertale-style tempo/pitch drift of leitmotifs | Adapt | T1.5 | Music as language, signal states | One theme per member, parametric degradation |
| Few main endings plus cheap minor endings (NieR) | Borrow | T2 | FLAG-02 | 3-4 authored plus fragments |
| Perspective replay for secret ending (NieR) | Adapt | T3 | FLAG-09, FLAG-12 | Needs NG+; out of T1 |
| Isolated chapter arcs with no cross-talk (Octopath) | Avoid | T1.5 | Switch mechanic, band theme | Violates "Nothing survives alone" |
| Telltale-style flags with no visible scene consequence | Avoid | T1 | Micro-choice | Pair every flag with at least one scene or audio change |
