# Party, companion and world-level RPG systems for a five-member band protagonist (DT track 06)

Research date: 2026-11-05. Budget was about 16 tool calls, so coverage is uneven. Sources are mostly fan wikis, Wikipedia and guides (secondary). Where I could not retrieve a source, the item is in Gaps or tagged "(unverified, background knowledge)". Nothing here should be copied; all items are principles to rebuild. Scope: T1 = Vox + Ciphera only; permadeath, combos and aerial switching are T2+ and tagged.

## 1. Switching: what makes it essential rather than optional

### Takeaway
Switching feels essential when each character owns a verb the world is gated on (Trine's bridge/box/grapple, Portrait of Ruin's paired puzzles) and optional when one character can do everything (Trine 4's developers buffed thief and wizard so players "no longer need to swap to the Knight for fights"). DT's "only see interactables you can use" rule is a stronger gate than anything found in the sampled games.

### Cited Findings
- Trine: three heroes bound into one entity; the player controls one and swaps to either other at any time. Frozenbyte called creative use of the three characters the most enjoyable element, and distinct abilities "the core of the game". Knight took two party slots in size terms, which capped the roster at three (and co-op at three). A summoner thief concept was dropped; a grappling hook led to the thief — [Wikipedia Trine 2](https://en.wikipedia.org/wiki/Trine_2); [Worthplaying 2009](https://www.worthplaying.com/article/2009/4/7/interviews/60574-trine-ps3pc-developer-interview/); [Gaming Nexus 2009](https://www.gamingnexus.com/Article/Trine-Interview/Page0/Item2339.aspx); [PS3 News 2009](https://ps3gamesnews.blogspot.com/2009/05/trine-developer-interview.html)
- Trine puzzle chain: abilities feed each other (wizard builds a bridge the knight and thief use). Reviewer found switching harder to manage solo than in co-op — [Gamecritics](https://gamecritics.com/brad-gallaway/trine-review/)
- Trine 4 interview: thief and wizard made more capable in combat so players need not swap to the Knight for fights (a deliberate loosening of the combat-role gate) — [WCCFtech 2019](https://wccftech.com/trine-4-hands-on-interview-e3-2019/)
- Castlevania: Portrait of Ruin: free switching between two characters (as in Dawn of Sorrow's Julius mode); combined abilities required in some puzzles, e.g. a motorcycle sequence alternating control to dodge obstacles — [Wikipedia](https://en.wikipedia.org/wiki/Castlevania:_Portrait_of_Ruin)
- Sea of Stars: no penalty for swapping active and reserve members in combat; swapping can finish an enemy when a Live Mana boost is not enough — [Gamepur guide](https://vip-develop.gamepur.com/guides/sea-of-stars-combat-basics-combo-points-live-mana-lock-breaking-timed-hits); [Fandom wiki](https://seaofstars.fandom.com/wiki/Combat)
- Indivisible: each party member is tied to a button; combos are sequences of presses; up/down changes the attack; shared block via one character's button or the whole party — [Wikipedia](https://en.wikipedia.org/wiki/Indivisible_(video_game))

### Inferences
- (inference) Three levers to make switching essential: (a) traversal/interactable gating (DT already has it), (b) combat role asymmetry tied to enemy affinity tiers 1-5, (c) a resource each member spends (stamina pool, hidden stress) so rotating is the relief valve. Trine 4's retreat shows pure combat-role gating annoys players; keep combat flexible and put hard gates in traversal.
- (inference) Because switching is ground-only in DT, T1 with two characters is the right test bed: Vox (voice) and Ciphera (rig) need at least two puzzle verbs each that the other cannot perform, and every room should require at least one swap.
- (inference) Solo play makes switching management harder (Gamecritics); keep the swap input instant and non-modal, and consider "ghost" preview of what the other member would see.

### Gaps
- Per-character interactable visibility as a puzzle gate: found no confirmed game that hides interactables per character (Trine shows everything but gates use). Treat DT's version as novel; "Metroid-style scan visor" and Zelda lens of truth analogies are unresearched.
- The Lost Vikings, Child of Light, Valkyrie Profile 2, Ys series switching, Octopath path actions, Chrono Trigger: not retrieved. Background knowledge only (unverified): Lost Vikings gates every obstacle on a different viking and fails the level if one dies; Octopath gives each traveler a path action (e.g. Provoke, Steal) usable on town NPCs.

## 2. Combination attacks

### Takeaway
Combos work best when they are resourced by a shared meter built through skilled play, are pair-specific (so each unlocks only when the right pair is active), and are rare enough to feel like events. All sampled examples gate them by a meter, not a plain cooldown.

### Cited Findings
- Sea of Stars: up to 3 combo points; each two-character pairing has its own combo; points are built by timed blocks/attacks and Live Mana. Sources disagree on whether points persist after battle (one says Dawn of the Equinox update makes them persist; another says they do not) — [Gamepur](https://vip-develop.gamepur.com/guides/sea-of-stars-combat-basics-combo-points-live-mana-lock-breaking-timed-hits); [PlayStation Blog](https://blog.playstation.com/?p=398214)
- Sea of Stars Live Mana: non-boosted attacks generate it; one party member can absorb up to 3 charges to boost their next action — [Gamepur](https://vip-develop.gamepur.com/guides/sea-of-stars-combat-basics-combo-points-live-mana-lock-breaking-timed-hits)
- Portrait of Ruin: Jonathan and Charlotte combine for "Dual Crush"; developers added simultaneous joint attacks and character switching to stress two-character combat — [Wikipedia](https://en.wikipedia.org/wiki/Castlevania:_Portrait_of_Ruin)
- Indivisible: a battle meter fills and powers super attacks when full — [Wikipedia](https://en.wikipedia.org/wiki/Indivisible_(video_game))
- Hi-Fi Rush partner calls: partners (Peppermint, Macaron, Korsica) are on cooldown; a chip spends one Reverb Gauge to refill partner cooldown instantly (7,500 Gears, 4 circuits), mainly used for Macaron with the longest cooldown; some partner actions (Peppermint Cannon Spike, Macaron Gravity Well) work held without Reverb. Partners target the enemy you face. Claims that Macaron's special was made non-offensive to limit shield-chaining are forum speculation — [TrueAchievements/guides via search](https://www.trueachievements.com/game/HiFi-Rush/walkthrough/8) (secondary; unverified details)
- Fire Emblem Awakening: adjacent allies can add a Dual Strike or Dual Guard, driven by support/pair-up — [Wikipedia](https://en.wikipedia.org/wiki/Fire_Emblem_Awakening)

### Inferences
- (inference) A DT rhythm-tier hook is the natural resource: Perfect hits fill a shared "band meter"; Good fills less; Poor/Miss drains. A 2-member combo costs 1 point, 3-5 member combos cost more, mirroring Sea of Stars' 3-point cap. This ties the combo to the band-cohesion stat (section 4) if cohesion modifies fill rate. Tag T2 (out of scope for T1).
- (inference) Pair-specific combos (n choose 2 = 10 for five members) is a content cost for a solo dev; for N-member combos use a generated "chord" built from member roles rather than 26 authored finishers.
- (inference) Cooldown + meter hybrid (Hi-Fi Rush) lets the meter skip a cooldown, which rewards skill without making the cooldown pointless.

### Gaps
- Chrono Trigger techs and PoR Dual Crush MP cost numbers were not retrieved. No developer statement found on balancing combos.

## 3. Background members, dispatch missions and recovery

### Takeaway
Dispatch loops work when the absent member is a real opportunity cost, the outcome is probabilistic with a visible odds readout, and risk includes permanent loss at higher tiers. Real-time timers (Dragon Age: Inquisition) and per-chapter quotas (Valkyrie Profile) are two very different pacing models.

### Cited Findings
- Assassin's Creed Brotherhood: recruits are earned by destroying Borgia towers and rescuing citizens; sent on assignments around Europe or called in to help during missions if idle; they gain XP and skill points; recruits can die on missions and do not return. Rome rebuild unlocks rewards — [Wikipedia](https://en.wikipedia.org/wiki/Assassin's_Creed:_Brotherhood). Success-chance formula not stated in source.
- Dragon Age: Inquisition war table: three advisors, send to map markers; operations cost Power/Influence/time; missions run in real time with a notification; recruited agents each reduce an advisor's time by 5%; reports must be collected for rewards, and follow-ups do not appear until collected; advisors take different approaches that shape outcome; 300+ operations per EA producer interview — [Fextralife](https://dragonage3.wiki.fextralife.com/War+Table); [SegmentNext](https://segmentnext.com/dragon-age-inquisition/war-table); [EA](https://www.ea.com/en-gb/news/dragon-age-inquisition-the-war-table-skyhold). One cheat guide mentions clock-change exploits of timers (exploit, unverified).
- Valkyrie Profile: each chapter requires sending 1-2 einherjar to Valhalla, preferably matching Freya's criteria; sent characters leave the roster until endgame; 21 recruits compensate; Arngrim cannot be sent; rewards (Materialize Points, artifacts) scale with the sent character's quality (Hero Value/traits); status of sent members is viewable between chapters — [Wikipedia](https://en.wikipedia.org/wiki/Valkyrie_Profile_(video_game)); [TheGamer](https://www.thegamer.com/valkyrie-profile-lenneth-character-einherjar-transfer/) (search summary)
- Mass Effect 2: only two squad members join Shepard; the AI controls them; player can pause and issue powers/orders — [Wikipedia](https://en.wikipedia.org/wiki/Mass_Effect_2)
- Banner Saga: battle leaves scars; deaths of favoured allies mostly come through story choices — [Wikipedia](https://en.wikipedia.org/wiki/The_Banner_Saga); [RPGamer review](https://archive.rpgamer.com/games/indie/bannersaga/reviews/bannersagastrev1.html)

### Inferences
- (inference) For DT, a "tour stops / gig runs" dispatch lets benched band members (T1.5+/T2) earn gear parts, rumours or map info while off-stage, consistent with "Nothing survives alone": dispatched members are absent from the current room's puzzles and from combos.
- (inference) Prefer event-based or room-count timers over real-time timers: real-time timers invite clock exploits and "check back later" fatigue in a game meant to be played in sessions. DAI's rule that follow-ups are blocked until reports are collected is a cheap content-drip pattern worth adapting.
- (inference) Following AI for background members: ME2's lesson (two AI companions with pause-and-order) suggests DT should avoid active AI companions entirely; the plane-locked 2.5D structure and single-character control make passive "follower" visuals enough.

### Gaps
- Exact AC Brotherhood success-chance rules, and Kenshi, Suikoden (108 Stars castle hub), Child of Light, Octopath: not retrieved; background knowledge only (unverified).

## 4. Bonds and cohesion

### Takeaway
Bond systems pay out when relationship growth is a by-product of shared play and unlocks both story scenes and small mechanical bonuses. DT's hidden "band cohesion" stat can follow this: grow by fighting together, spend on combos and stress resistance.

### Cited Findings
- Fire Emblem Awakening: support conversations unlock from fighting alongside allies via Pair Up and Dual Support; the secondary unit boosts the main unit's stats and may join as Dual Strike or Dual Guard — [Wikipedia](https://en.wikipedia.org/wiki/Fire_Emblem_Awakening)
- XCOM 2 bonds: bonds form in battle and unlock extra abilities; bonded soldiers (level 2+) beside each other resist negative mental effects (forum claim); when a bondmate dies, the survivor takes penalties and recovers later and can rebond (Fextralife report) — [Fextralife](https://fextralife.com/?p=29352) and [Steam forum](https://steamcommunity.com/app/268500/discussions/0/1643171537288106940) (secondary, approximate)
- Mass Effect 2: loyalty missions decide loyalty; loyalty unlocks a unique power and helps in the final battle; suicide mission survival depends on Normandy upgrades, loyalty and task assignment; outcomes range from all alive to all dead — [Wikipedia](https://en.wikipedia.org/wiki/Mass_Effect_2). Exact thresholds not given in source.
- Banner Saga: morale reflects the caravan's resolve, affected by quests, events, travel, camping, battle outcomes and starvation, and feeds combat willpower (bonus when high, penalty when low) — [Banner Saga Wiki](https://bannersaga.fandom.com/wiki/Caravan) (fan wiki; the same page says there is "no gameplay feature" for the caravan apart from symbolism, which conflicts with other sources describing supplies and morale as mechanics)
- Banner Saga supplies: each supply unit sustains about 100 caravan members for a day; starvation reduces population; heroes cannot die from starvation — same wiki.

### Inferences
- (inference) Band cohesion as a single background scalar (0-100) with member-pair sub-bonds (10 pairs). Raise by synced Perfect-tier play, shared rooms, and consequence-laden choices (tone-coded: harmonic raises, missed note lowers). Lower by abandoning a member (FLAG-13) or choices others disagree with. Effects: combo meter fill rate (T2), stress resistance for adjacent bonded members (T2), dialogue/ending gates (feeds the narrative track).
- (inference) Loyalty-gating of a final mission (ME2) maps onto the ending matrix (FLAG-02): cohesion plus per-member "loyalty" flags could gate who survives a final set piece. T3.
- (inference) T1 can hold a stub: a single cohesion integer with two writers (the micro-choice and rhythm performance), logged but unseen, so later tiers have data.

### Gaps
- Persona social links: not retrieved (background: fixed weekly time budget, rank-up scenes grant fusion bonuses — unverified). Official Persona/FE wiki numbers not gathered.

## 5. Stress, injury, loss; abandoned vs dead; escort

### Takeaway
The strongest model is Darkest Dungeon's: a hidden-to-visible mental meter that causes behavioural variance rather than only numeric penalties, with a town-side sink. Loss systems need an opt-out or softening (Fire Emblem Casual Mode) because players reload; loss that comes through story choice (Banner Saga) avoids save-scumming incentive.

### Cited Findings
- Darkest Dungeon stress: Resolve Check at 100 stress gives an Affliction (about 75%) or Virtue (about 25%) per one wiki; 200 stress is a heart attack that drops a hero to Death's Door or kills one already there. Wikis disagree on what a Virtue does at 200 (glossary: no heart attack; Fandom: Virtue lost and stress reset to 0). Forum posts say stress resets to 150-170 after a heart attack and that deaths spike party stress, chaining collapses (unconfirmed) — [DD wiki glossary](https://darkestdungeon.wiki.gg/wiki/Glossary); [Fandom Virtue](https://darkestdungeon.fandom.com/wiki/Virtue); [Steam thread](https://steamcommunity.com/app/262060/discussions/0/3379410661799369147)
- Designer intent: the Affliction system shows that "any person can break under pressure, and people break in different ways" — [Game Developer deep dive](https://gamedeveloper.com/design/game-design-deep-dive-i-darkest-dungeon-s-i-affliction-system) (page text not fully fetched; quote from search summary)
- Bourassa GDC talks: 2016 "A Torch in the Dark" ([GDC Vault](https://gdcvault.com/play/1023082/A-Torch-in-the-Dark)) and 2024 "Ruin or Redemption" on DD2 ([GDC schedule](https://schedule.gdconf.com/session/ruin-or-redemption-the-making-of-darkest-dungeon-ii/899219)). Neither confirmed as a stress-design talk.
- XCOM 2: fatigue lowers Will; recovery time depends on fatigue, wounds, and facilities; bonds protect against mental effects. A "fatigue injury" claim is from a mod, not vanilla — [Steam forum](https://steamcommunity.com/app/268500/discussions/0/1643171537288106940); [Fextralife Will](https://xcom2.wiki.fextralife.com/Will)
- Fire Emblem Awakening: Casual Mode removes permadeath (fallen units restored after battle); Classic keeps it; chosen at new game separately from difficulty; Intelligent Systems was reportedly divided over it; Maeda said hard battles can be finished in Casual Mode — [Wikipedia](https://en.wikipedia.org/wiki/Fire_Emblem_Awakening); [Engadget 2013](https://www.engadget.com/2013/04/03/intelligent-systems-divided-over-fire-emblem-awakenings-casual/); [Nintendo Life](https://www.nintendolife.com/news/2013/04/talking_point_fire_emblem_awakening_the_big_casual_mode_debate)
- Banner Saga: design intent to make players "accept and deal with the consequences of any defeats", and the game avoids reloading after defeat — [Wikipedia](https://en.wikipedia.org/wiki/The_Banner_Saga)
- Mass Effect 2: Unity power revives fallen squad members — [Wikipedia](https://en.wikipedia.org/wiki/Mass_Effect_2)
- AC Brotherhood: recruits that die on missions do not return — [Wikipedia](https://en.wikipedia.org/wiki/Assassin's_Creed:_Brotherhood)
- Valkyrie Profile: sending a hero to Valhalla is permanent loss from the roster by design, but deliberate and rewarded, and their status remains viewable — [TheGamer](https://www.thegamer.com/valkyrie-profile-lenneth-character-einherjar-transfer/) (search summary)

### Inferences
- (inference) DT's hidden stress with body/augment tells matches DD's principle (variance, not just debuffs). Borrow the two-stage threshold (strain, then break) but display through animation and audio (an off-beat note) rather than a bar. T1: tells only; T2: affliction table.
- (inference) FLAG-13 abandoned vs deceased: Valkyrie Profile treats "sent away" as a distinct state with later status check-ins; ME2 distinguishes the dead from the loyal-and-alive. Suggested model: three states per member (active, absent/abandoned with a drift-away timer and re-encounter option, dead). Abandoned members can reappear changed (hostile, indifferent, rescued), which feeds the narrative track. Escort: a downed member is dragged, and fiction-wise "carried" members slow movement and lock out their instrument (a mechanical echo of the permadeath-removes-instrument rule).
- (inference) Permadeath in DT is optional (death after two unhealed injuries); a FE-style mode toggle at new game is the proven pattern. Save-scumming is mitigated by Banner Saga/Darkest Dungeon's autosave-only approach; consider autosave on injury (T2+).
- (inference) Stress chain collapse (DD forum) is a risk for a five-person band: cap per-event stress propagation.

### Gaps
- Darkest Dungeon official numbers (resolve check formula, per-affliction rates) not verified against a primary source; the DD fandom page returned HTTP 402.
- Developer statements on save-scumming: none found. Pitfalls evidence (party AI frustration, micromanagement fatigue) was not directly sourced this session beyond the Trine reviewer note and Trine 4 change; background knowledge only: ME2 AI companion complaints, DD hamlet management tedium (unverified).

## 6. World layers: NPC questlines, factions, hubs, economies

### Takeaway
Hubs that grow through recruitment and rescue (AC Rome, Suikoden castle, DAI Skyhold) turn collection into visible progress. Economies in the sampled games use more than one currency (Power/Influence/Gold; Renown/supplies), which separates "capability" spending from "survival" spending.

### Cited Findings
- AC Brotherhood: investing in Rome unlocks rewards; areas must be freed (tower destroyed) before renovation, which unlocks missions — [Wikipedia](https://en.wikipedia.org/wiki/Assassin's_Creed:_Brotherhood)
- Dragon Age: Inquisition: Power and Influence are spent at the war table; Inquisition rank perks are spent there; rewards include gold, influence, party approval and equipment — [Fextralife](https://dragonage3.wiki.fextralife.com/War+Table); [Prima](https://primagames.com/eguides/dragon-age-inquisition-eguide/the-war-council/the-war-table)
- Banner Saga: Renown is currency, spent on stat items, advancement and caravan supplies — [GodIsAGeek review](https://godisageek.com/2014/01/the-banner-saga-review/)
- Indivisible: recruits are absorbed into Ajna's mind pocket dimension (a hub-in-the-protagonist) — [Wikipedia](https://en.wikipedia.org/wiki/Indivisible_(video_game))

### Inferences
- (inference) DT's hub could be a venue, backstage or a hacked-radio relay in the Deep-City layers, rebuilt as the band recovers members and fans; the Decay Map can reflect this, with NPC questlines marching forward or failing as the Waves progress (world speaks).
- (inference) Two-currency split: Salvage (crafting) vs Signal/Rep (faction access), so the XP spend pool is not also the shop currency. Faction reputation as a discrete "tone" state fits the musical choice language.
- (inference) T1 needs no hub; a single NPC whose line changes after a micro-choice is enough to test progress-tracking.

### Gaps
- Faction reputation mechanics (e.g. Fallout-style), Kenshi faction/squad systems, Suikoden, Metroidvania shop economies (Hollow Knight, Bloodstained): not retrieved.

## DT translation table

| Item | Verdict | Tier | DT system |
|---|---|---|---|
| Trine-style traversal gates: each member owns a verb; every room needs one swap | Borrow | T1 | Switch mechanic, Vox and Ciphera |
| Per-character interactable visibility as the puzzle gate | Enhance (novel, no sampled precedent) | T1 | "Only see what you can use" rule |
| Keep combat flexible so swapping isn't forced for fights (Trine 4 lesson) | Adapt | T1 | Combat roles, affinity tiers |
| Shared band meter from Perfect/Good/Poor/Miss tiers; pair combos cost points (Sea of Stars) | Adapt | T2 | 2- to 5-member combos |
| Generated N-member chord finishers rather than authored per-pair | Enhance | T2 | Combination attacks |
| Aerial strike-swap | Avoid until scheduled | T2+ | Aerial exception |
| Partner cooldown plus meter-skip (Hi-Fi Rush) | Adapt | T2 | Assist calls |
| Dispatch missions with visible odds, event-based timers, collect-report gate (DAI) | Adapt | T2 | Dispatch of inactive members |
| Real-time dispatch timers | Avoid | T2 | Dispatch |
| Active AI companions (ME2) | Avoid | T1 | Plane-locked single-character control |
| Hidden stress with body/augment tells, two-stage break (DD) | Adapt | T1 tells, T2 afflictions | Hidden stress value |
| Cap stress propagation on death/collapse | Avoid chain failure | T2 | Stress, injuries |
| Cohesion scalar plus 10 pair bonds feeding combos, stress and endings | Adapt | T1 stub, T2 effects | Band cohesion |
| Support conversations unlocked by playing together (FE) | Borrow | T2 | Bonds, narrative |
| Loyalty-gated finale survival (ME2) | Adapt | T3 | Ending matrix FLAG-02 |
| Casual/Classic mode toggle chosen at new game (FE) | Borrow | T2 | Optional permadeath, Band/Solo modes |
| Three member states: active, abandoned (re-encounterable), dead | Enhance | T2 | FLAG-13 |
| Downed member escort as slowed carry with instrument lockout | Enhance | T2 | Blackout/escort system |
| Death through story choice rather than battle (Banner Saga) | Adapt | T2 | Permadeath narrative hooks |
| Hub that grows with recruits and rescues; two-currency split | Adapt | T2 | Hub, shops, Decay Map |
| Single NPC whose dialogue reflects a micro-choice | Borrow | T1 | NPC questlines |
| Sent-away status check-ins (Valkyrie Profile) | Adapt | T2 | Dispatch, abandoned state |
