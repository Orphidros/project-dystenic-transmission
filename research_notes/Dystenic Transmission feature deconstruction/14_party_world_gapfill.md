# Party, bond and world-RPG gap-fill for DT (extends track 06)

Research date: 2026-11-05. Adds to, does not repeat, `06_party_world_rpg_layers.md`. About 20 tool calls; sources are mostly Wikipedia, wikis and search summaries (secondary). Search-summary-only claims are marked "(search summary)". Nothing here should be copied; items are principles to rebuild. No decompilations or datamines were used. T1 = Vox + Ciphera only; permadeath, combos and aerial switching are out of T1.

## 1. Bonds and cohesion (Persona, Fire Emblem mechanics, morale stats)

### Takeaway
Persona's bond rank pays out in two currencies: story scenes and a concrete build-side multiplier (fusion EXP), plus combat perks that appear at set ranks. Bond growth is gated by a scarce time budget. DT's band cohesion can reuse "bond rank feeds the crafting loop" by feeding the combat/progression loop rather than only combat.

### Cited Findings
- Persona 4 (and Golden): each Social Link maps to an Arcana. When fusing Personas of that Arcana, the result gets bonus EXP that scales with link rank (rank 1: one level plus 10% of next level; rank 2: one level plus 50%; rank 3: two levels; rank 4: two levels plus 50%; rank 5: three levels). Maxing a link unlocks that Arcana's ultimate Persona (example: Yukiko link and Amaterasu). Having a Persona of the matching Arcana equipped gives extra link points. The table found covers ranks 1-5 only; other sources describe ranks to 10 — [Megami Tensei Wiki "Social Link"](https://megatenwiki.com/wiki/Confidant); [PC Gamer P4G social links](https://pcgamer.com/all-persona-4-golden-social-links-guide) (both via search summary)
- Persona 5 confidants: rank-ups unlock combat perks such as Baton Pass (a party member takes the turn after Joker's 1 More) and Follow Up (chance of an extra attack after Joker's attack), plus non-combat perks (a ramen shop, "Punk Talk"). Guides disagree on which rank unlocks which perk, and Royal grants Baton Pass automatically; treat rank thresholds as unreliable — [CGMagazine confidant guide](https://www.cgmagonline.com/guides/persona-5-confidant-guide-futaba-makoto-ann-ryuji-haru-and-yusuke) (search summary)
- Fire Emblem Awakening: support conversations come from fighting adjacent via Pair Up and Dual Support; the pair-up partner boosts the main unit and may add Dual Strike/Dual Guard (already in track 06) — [Wikipedia](https://en.wikipedia.org/wiki/Fire_Emblem_Awakening)
- Party-wide cohesion stat precedents already in 06: Banner Saga morale and XCOM 2 bonds. No additional morale-stat game was verified this session.

### Inferences
- (inference) Cohesion rank could modify the "band meter" fill rate and unlock a pair's shared stress relief, mirroring FE's "bond turns into adjacency bonus" and P5's "rank unlocks a combat verb". Persona's sharpest lesson is that bonuses are small, explicit and tied to a parallel system (fusion); DT's parallel system is gear crafting or XP spend, e.g. a pair rank cuts the XP cost of that pair's shared abilities (T2).
- (inference) Because P5 guides cannot agree on thresholds, publish DT's thresholds in-game via audio/animation tells only if the thresholds are stable; keep them hidden (matches the hidden-stress rule) and test with logging.
- (inference) T1 with two members has exactly one pair (Vox-Ciphera); a single "pair bond" integer is a sufficient stub.

### Gaps
- No primary Atlus source for rank thresholds or the weekly time budget. Persona's design rationale from Atlus interviews was not retrieved.
- No verified game with a pure party-wide morale stat beyond Banner Saga (06).

## 2. Combination techniques (Chrono Trigger, Indivisible, Child of Light)

### Takeaway
Chrono Trigger gates combos by "known singles plus fought together", not by a menu unlock, and gives every combo a content-count cost (45 dual, 15 triple). Child of Light shows a 2-active-member limit with free switching and a real-time helper that sits outside the turn system.

### Cited Findings
- Chrono Trigger dual techs: two characters must know predetermined single techs and have fought together in battle. All characters except Magus can use them. 45 dual techs total — [Chrono Trigger Wiki (wiki.gg) Techs](https://chronotrigger.wiki.gg/wiki/Techs)
- Triple techs: three characters; most require Crono in the party. After the Ocean Palace events another character can lead; non-Crono triples need special accessories. 15 total (10 Crono, 5 non-Crono). Triple techs also cost permanently locked TP investment per one search summary — [wiki.gg Techs](https://chronotrigger.wiki.gg/wiki/Techs); [Thonky tech tables](https://thonky.com/chrono-trigger/techs) (search summary)
- Cost: both partners act simultaneously and each pays the MP of its own single tech (Thonky lists separate costs per character). The game "automatically displays the combo as an option" when partners have enough MP — [Thonky](https://thonky.com/chrono-trigger/techs) (search summary); [Wikipedia](https://en.wikipedia.org/wiki/Chrono_Trigger). Example: Crono's Cyclone plus Lucca's Flame Toss gives Fire Whirl.
- Positioning: no source retrieved stated formation or range rules. Not found.
- Indivisible: combo sequencing per button covered in 06. Nothing new retrieved.
- Child of Light: only two party members fight at once, all level up; switching is free and does not cost the turn; Igniculus acts in real time off the timeline (slows enemies, heals) and a co-op player can control him. A co-op reviewer argued the second player's role fades later. A developer video reportedly said Igniculus-only co-op was intentional (unverified, from search summary) — [VideoGamer guide](https://www.videogamer.com/guides/child-of-light-s-battle-system-an-introduction-and-tips-and-tricks); [Co-Optimus review](https://www.co-optimus.com/ampfeature/1365/child-of-light-co-op-review.html)

### Inferences
- (inference) "Known singles plus fought together" is a cheap, readable unlock for DT: pair ability unlocks when each member has used its prerequisite move and shared N rhythm encounters. It doubles as the cohesion writer (section 1). T2.
- (inference) Chrono's Magus exclusion shows one character can be left combo-less to avoid content cost; DT's Ciphera (rig-based) could be the "chord conductor" who enables pairs rather than authoring a finisher per partner.
- (inference) Child of Light's real-time helper outside the turn system is a precedent for a Ciphera-style rig/drone assist in T1 that does not count as an active member. Not combo-scope, so safe.

### Gaps
- Chrono MP numbers, field positioning (members closing to the target) and TP cost for duals not verified. Indivisible interviews not found. No developer statement on Child of Light's two-member limit (the Yohalem interview text was not returned).

## 3. Party switching in action games (Lost Vikings, Ys, Valkyrie Profile 2; Trine only new)

### Takeaway
The Lost Vikings is the hard-gate extreme: every obstacle needs a specific character and one death makes the level unwinnable. Valkyrie Profile 2 (as described) puts the field verbs on one character, so switching is not the field gate there. Ys sources found show no party switching.

### Cited Findings
- The Lost Vikings: Erik runs, jumps and bashes; Baleog fights and shoots a bow that also hits distant switches; Olaf blocks projectiles, glides and acts as a platform. Each Viking has 3 health; if one dies the others continue but the level is unwinnable and must be restarted; unlimited continues. Concept started from Lemmings with hundreds of tiny Vikings, reduced to five then three because larger characters suited TV screens and players wanted direct control — [Wikipedia](https://en.wikipedia.org/wiki/The_Lost_Vikings)
- Valkyrie Profile 2: dungeons are 2D side-scrolling; Alicia alone can jump, swing a sword and shoot photons that freeze enemies and objects in crystal, used for many puzzles. Silmeria can take over Alicia's body but usually leaves Alicia in control. Certain einherjar combinations in the party trigger conversations. The page describes no formal field-switching mechanic — [Wikipedia](https://en.wikipedia.org/wiki/Valkyrie_Profile_2:_Silmeria)
- Ys Origin: playable characters differ by weapon and range (axe/sword, staff magic, short-range claws) and share a Boost Meter. The page mentions no party switching in Ys Origin or Ys VIII — [Wikipedia](https://en.wikipedia.org/wiki/Ys_Origin). Ys party switching is therefore not confirmed here.
- Trine: nothing new beyond 06.

### Inferences
- (inference) The Lost Vikings' "death makes level unwinnable" is a permadeath-like punishment that DT must not replicate in non-permadeath play; DT's blackout-and-drag escort is the soft equivalent. Rule of thumb: failure should be recoverable in-room.
- (inference) Original design pressure was players "wanted direct control": supports DT's single-controlled-character plus passive followers choice (06 avoided active AI companions).
- (inference) Ys Origin's shared Boost Meter across differently-ranged characters is a cheap precedent for DT's shared band meter (T2).

### Gaps
- Ys series party switching (Ys VIII, Ys IX, Seven) not sourced; background recollection is that Ys VIII lets the player swap between characters, but that is unverified. VP2 switching and Silmeria mode details not found.

## 4. Recruitment and hubs (Suikoden, Octopath path actions)

### Takeaway
Octopath's path actions are the closest sourced analogue to DT's "only see what your skills reveal", and the sourced part is that they are per-character, target NPCs, and carry a reputation cost for the risky half. Suikoden's page content gave only the 108-recruit framing; castle growth details are a gap.

### Cited Findings
- Octopath Traveler: each of the eight characters has a path action. Olberic and H'aanit Challenge; Alfyn and Cyrus Inquire (information for quests or hidden items); Tressa and Therion acquire items (commerce versus pickpocketing); Ophilia and Primrose Guide NPCs and use them as guest summons. The first action per character is "Noble" with effectiveness depending on the character's level or the in-game currency; the other actions are "Rogue" actions that risk credibility with other NPCs. Losing enough reputation in a town blocks path actions there until a fee restores it — [Wikipedia](https://en.wikipedia.org/wiki/Octopath_Traveler)
- Suikoden: each main game has 108 recruitable characters (in most games all recruitable), inspired by the Chinese novel Shui Hu Zhuan (Water Margin). Recruiting all is not required to finish but unlocks story-affecting bonuses (the article marks that as needing citation). The player gets a base, usually a captured abandoned castle that becomes a bustling community. Battle party holds up to six — [Wikipedia](https://en.wikipedia.org/wiki/Suikoden). Shops/services unlocking per recruit and missable recruits were not covered by the page.

### Inferences
- (inference) DT can express "only see what your skills reveal" as a per-member interaction layer on NPCs: Vox could draw out speech (Inquire-like), Ciphera could read signal (Inquire/Acquire-like). A reputation cost on the invasive verb mirrors Octopath's Noble/Rogue split and the Signal states (Clear to Encrypted). T1: one NPC reading differently for each of the two characters.
- (inference) Suikoden's collection hook (recruits as a visible checklist that adds services) maps to a Metroidvania hub; the sourced facts are thin, so build only the principle: each recruited NPC visibly adds something to the hub. T2.

### Gaps
- Suikoden castle growth stages, which stars unlock which shops, and missable-star rules not retrieved (page text did not cover them). Octopath success-chance formulas and level requirements not found.

## 5. Factions, shops and economies at Metroidvania scale

### Takeaway
Salt and Sanctuary treats faction membership as an exclusive, costly-to-swap commitment with per-visit rewards. Hollow Knight's merchant Salubra gates stock behind a collection count, so shop growth tracks exploration, not story. Blasphemous NPC chains are sequence-sensitive and missable.

### Cited Findings
- Salt and Sanctuary creeds: changing creed means taking an oath at a sanctuary of the new creed; sources disagree on the penalty (one guide: devotion resets to 1, no apostasy when joining the Order of the Betrayer; the wiki: abandoning a creed makes you an Apostate; leader ranks reset). The wiki says switching accumulates sin cleared for about 1,000 Salt per switch and desecrating another creed's sanctuary costs about 10,000 Salt to forgive. Devotion rises by placing a creed leader item at an owned sanctuary and using "Work" to trade enemy remains for rank. Each rest at a sanctuary owned by your creed lets you pick one reward from a creed-specific set; one post says rewards per cycle are limited, reducing switch pain — [Fextralife S&S Creeds](https://saltandsanctuary.wiki.fextralife.com/Creeds) and community threads via search summary (older, partly garbled; the Fandom page returned HTTP 402)
- Hollow Knight, Salubra: starts with 3 charm notches, 8 more can be found for a cap of 11 (one guide says 7 more; conflict). Four notches are sold by Salubra with stock unlocked at charm counts of 5, 10, 18 and 25, priced 120, 500, 900 and 1,400 Geo (total 2,920); at 40 charms she offers Salubra's Blessing for 800 Geo — [Hollow Knight wiki Charm Notches](https://hollowknight.wiki/w/Charm_Notches) (search summary)
- Hollow Knight, Sly: stock grows after returning the Shopkeeper's Key (found in Crystal Peak) and again after he is rescued from Deepnest; some charms appear only after the rescue. Prices differ between sources — [Hollow Knight wiki](https://hollowknight.wiki/w/Charms) (search summary)
- Blasphemous: Tirso's herb quest is described as missable (give one herb before killing any boss, per a Steam guide); Cleofas's quest reward is missable if he is allowed to die; Gemino's quest is missable at the cost of a room and an early prayer. Deogracias's chain could not be confirmed missable. Player forum and guide sources only — [Steam Blasphemous threads](https://steamcommunity.com/app/774361/discussions/0/1864993937059479949); [TrueAchievements walkthrough](https://www.trueachievements.com/game/Blasphemous/walkthrough/6)
- Kenshi: attacking a faction makes you its enemy for a while; most factions have no way to repair relations; some groups (cannibals, berserkers) are hostile to all and not in the factions list; positive relations open recruiting from a faction's ranks; most of the roughly 100 factions are small squads — [Kenshi Wiki Faction](https://kenshi.fandom.com/wiki/Faction) (search summary)

### Inferences
- (inference) Collection-count gating (Salubra) suits DT's Metroidvania pacing and avoids a faction system in T1: a vendor whose stock unlocks at N recovered "signal fragments" is cheap and legible.
- (inference) S&S shows the cost of exclusive factions: designers added sin fees and per-visit rewards to manage switching. For DT, factions as mutually exclusive "tones" would conflict with the no-good/bad musical signalling; consider reputation as separate per-faction scalars with decay instead. T2+.
- (inference) Blasphemous missable chains conflict with the "Nothing survives alone" pillar if misses are silent; DT's Decay Map could telegraph the window (an NPC visibly degrades) rather than hide it.

### Gaps
- Primary-source numbers for S&S were not retrievable (Fandom 402, Hollow Knight wiki.gg returned 401). Hollow Knight prices are from search summaries and disagree across sources. No developer interview on hub NPC growth was found.

## 6. Pitfalls (party AI, micromanagement, save-scumming, dead weight)

### Takeaway
The best-sourced new fact is that Fire Emblem's own designers reset after losing units in Classic mode, evidence that permadeath invites save-scumming even among its authors. The rest of the pitfalls remain thinly sourced.

### Cited Findings
- Awakening developers: Maeda — "In Classic Mode, definitely, I reset if lose someone." Higuchi and Yokota also said they reset; Yokota also resets over bad random level-up gains — [Kotaku](https://kotaku.com/even-the-people-behind-fire-emblem-hit-reset-when-somet-465971876) (fetched)
- Casual Mode: Maeda said multiple modes let players who find Classic too hard still finish on Casual (Iwata Asks); Higuchi said he opposed Casual, Yokota first said "no way" but later said he plays only Casual. Reports differ on whether fallen units return on the next map (Iwata Asks) or are only out for the rest of a battle (Shacknews) — [Iwata Asks](https://iwataasks.nintendo.com/interviews/3ds/fire-emblem/0/2); [Engadget](https://www.engadget.com/2013/04/03/intelligent-systems-divided-over-fire-emblem-awakenings-casual/); [Destructoid](https://vip-develop.destructoid.com/?p=122935); [Escapist](https://www.escapistmagazine.com/?p=92073); [Shacknews](https://www.shacknews.com/article/78536/future-fire-emblems-likely-to-include-casual-mode) (all via search summary)
- XCOM: Solomon argued permadeath makes players attached to their soldiers; one report says Firaxis was surprised by how popular and attachment-heavy Iron Man mode was (Iron Man saves only on quit); a Kotaku writer defended reloading as a way to keep the squad succeeding — [PCGamesN interview](https://pcgamesn.com/xcom-2/xcom-jake-solomon-interview); [Softpedia](https://news.softpedia.com/news/XCOM-s-Iron-Man-Mode-Popularity-Surprised-Firaxis-321378.shtml); [Kotaku](https://kotaku.com/in-defense-of-xcom-save-scumming-1761282470) (search summary; exact wording not confirmed)
- The Lost Vikings: a dead hero makes the level unwinnable, forcing restart (section 3).
- Child of Light: a reviewer argued the helper-only co-op role fades later (section 2), a mild dead-weight signal.

### Inferences
- (inference) If DT's optional permadeath (death after two unhealed injuries) ships, expect reloads. The two-injury delay is already a softer-than-FE design because the player gets warning; add autosave-on-injury (T2+) so the reload point is after the warning, not before it.
- (inference) Dead-weight risk: with two T1 characters each owning a verb, neither can be dead weight; at five members, ensure each owns a traversal verb, as no sourced fix beyond Chrono's exclusion of Magus was found.

### Gaps
- Party AI frustration and micromanagement fatigue: still no new developer or critic source beyond 06. No dead-weight-character source.

## DT translation table

| Item | Verdict | Tier | DT system |
|---|---|---|---|
| Pair bond integer for Vox-Ciphera, written by rhythm performance and the micro-choice, hidden | Borrow (Persona/FE principle) | T1 | Band cohesion stub |
| Bond rank cuts XP cost of the pair's shared abilities (Persona fusion bonus analogue) | Adapt | T2 | XP spend, cohesion |
| Hidden thresholds; do not copy P5-style rank-perk ladders | Avoid | T2 | Cohesion |
| Combo unlock = prerequisite singles used plus N shared encounters (Chrono) | Adapt | T2 | 2- to 5-member combos |
| Per-member MP/stamina share for each partner in a combo | Adapt | T2 | Combos, stamina |
| One member (Ciphera) as enabler instead of a finisher per partner | Enhance | T2 | Combos |
| Real-time helper outside the turn/active-member limit (Child of Light Igniculus) | Adapt | T1 | Ciphera rig assist |
| Level-unwinnable on a member's death (Lost Vikings) | Avoid | T1 | Blackout/escort |
| Shared meter across differently-ranged members (Ys Origin Boost) | Adapt | T2 | Band meter |
| Per-character NPC reading (Octopath Inquire analogue) with a reputation cost for the invasive verb | Adapt | T1 (single NPC), T2 (system) | "Only see what your skills reveal" |
| Town-blocked until fee/reputation restored (Octopath) | Adapt | T2 | Faction/NPC rep |
| Vendor stock unlocked at collection counts (Salubra) | Borrow | T1.5 | Shops, Decay Map |
| Shop stock jumps on rescue/return-item events (Sly) | Adapt | T2 | Hub NPC growth |
| Mutually exclusive factions with switch fees (S&S creeds) | Avoid for T1/T1.5; revisit | T2+ | Factions |
| Per-faction scalar reputation with decay | Adapt | T2 | Factions |
| Telegraph missable NPC windows through Decay Map | Enhance | T1.5 | NPC chains |
| Recruit checklist where each recruit visibly adds hub services (Suikoden principle) | Adapt | T2 | Hub (details unverified) |
| Autosave on injury to blunt permadeath reloads | Adapt | T2+ | Optional permadeath |
| Classic/Casual-style mode split (already in 06) with the knowledge that authors reset | Borrow | T2 | Band/Solo permadeath modes |
