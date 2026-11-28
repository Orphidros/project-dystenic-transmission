# RPG build-system gap-fill (supplements 05_rpg_build_systems.md)

Research date 2026-11-05. About 20 tool calls, which is over the 15-call guideline. Method: WebSearch plus WebFetch. Many fetches failed (Fandom and wiki.gg gave 401/402/404; Wikipedia and the Game Developer page worked). Where a claim comes from a search summary and not a fetched page it is marked "(search summary)". Nothing is vendored; wikis are fan sources (secondary). Coverage is partial. Afterimage, Aeterna Noctis, Death's Gambit soul stones, and every developer postmortem on stat bloat are unresolved and listed as Gaps. Nothing here is from memory.

## Q1. Build axes, currency, death penalty and equipment/stat interaction in the named games

### Takeaway
Only four of the seven named games yielded usable mechanics. Salt and Sacrifice ties crafting to which mage you killed (element-matched sets), Blasphemous 2 uses per-weapon trees plus a paired-slot altarpiece, Valfaris uses a permanent ranked-upgrade currency, and The Last Faith is a five-stat souls-like. Death's Gambit gave only its talent structure.

### Cited Findings
- Salt and Sacrifice: crafting materials come from mages, found on the map, via Mage Hunts, or via daily Fated Hunts. A mage has a primary and secondary element, and gear crafted from its materials follows the primary element. Killing a new mage type unlocks a weapon set in its elements, an armour set resisting them, and a ring, amulet and dagger with special effects. Hunted mages teleport away after enough damage or time. Non-mage unique bosses drop only artifacts, not materials. Examples: Clockwork Heart for the Mechwork set, Storied Heart for the Codex set. — [Fextralife S&S wiki](https://saltandsacrifice.wiki.fextralife.com/Clockwork+Heart), [Prima Games Mage Hunts guide](https://primagames.com/?p=317471), [Shacknews review](https://shacknews.com/article/130225/salt-and-sacrifice-review-mage-season) (all via search summary). A user comment on one wiki page claims a drop bug blocks some crafting; unverified.
- Salt and Sacrifice death penalty and respec: not found in this pass.
- Death's Gambit: Afterlife: a General talent tree, a class talent tree, a later secondary class tree and Advanced talents. Each talent costs 1 talent point. Example: Overflowing Soul gives +40 max Soul Energy and requires Soul Crash. Afterlife adds 10 worlds, 6 bosses, 22 weapons and 100 talents. — [Fextralife Acolyte of Death Talents](https://deathsgambit.wiki.fextralife.com/Acolyte+of+Death+Talents), [PC Gamer](https://www.pcgamer.com/deaths-gambit-afterlife/) (search summary).
- Death's Gambit weapons are not class-bound; any class can use any weapon subject to stat requirements, and the Sentinel can use all weapons at half the stat requirement. Wizards gain Soul Energy when consuming a Phoenix Feather, the main healing consumable. Players "can earn Shards" and slot them into attributes. — [Fextralife New Player Help](https://deathsgambit.wiki.fextralife.com/New+Player+Help) (fetched). Soul stones, shard-loss on death and respec were not on that page.
- Blasphemous 2: 3 prayers can be equipped at once, and the data lists 30 prayers (24 base, rest from expansions). Every weapon has its own tree of Weapon Memories bought with Marks of Martyrdom. — [MeowDB Blasphemous 2](https://meowdb.com/db/blasphemous-2/prayers), [earlyguides](https://earlyguides.pages.dev/blasphemous-2/weapons) (search summary; low-grade guide site).
- Blasphemous 2 altarpiece: figures fall into five categories (Candle, Sword, Skull, Feather, Ring). Two same-category pieces in an adjacent paired slot activate a Resonance. There are 20 unique Resonances needing specific combinations (another source says 25; conflicting). You start with 2 slots and buy more from the sculptor Montanes, up to 8 slots and 4 simultaneous Resonances. Whether pieces can be swapped freely is implied but not stated. — [Funario guide](https://funario.pages.dev/posts/every-altarpiece-resonance-in-blasphemous-2) (fetched; guide site, unverified against game). The Confessor figure gives a 25% prayer fervour-cost reduction. — [MeowDB](https://meowdb.com/db/blasphemous-2/figures) (search summary).
- Valfaris: weapons upgrade from Rank 1 to 3 with Blood Metal, and Rank 4 needs a rarer "Blood of Valfaris". Blood Metal spent cannot be retrieved, and one review notes no way to redistribute. Sources: secrets, enemies, and exchanging Resurrection Idols at level ends. Full Metal Mode (New Game+) carries all weapons and upgrades. — [PlayStation Blog](https://blog.playstation.com/?p=218233), [GameCritics](https://gamecritics.com/jarrod-johnston/valfaris-review/) (search summary).
- The Last Faith: five attributes (Vitality, Strength, Dexterity, Mind, Instinct). Weapon upgrades cost one Moonsilver Stone each, dropped or bought from Mariano for 1800 Nycrux, with the Nycrux cost rising per upgrade. Weapon scaling should guide the second stat. — [CommonSenseGamer attributes](https://commonsensegamer.com/the-last-faith-attributes-guide/), [Destructoid](https://www.destructoid.com/how-to-upgrade-weapons-in-the-last-faith/) (search summary).

### Inferences
- (inference) Salt and Sacrifice's mage-to-set mapping is the clearest working model of "kill a specific enemy type, unlock a gear family", which fits DT's salvage arc if each enemy class yields one family and the primary affinity decides the family's flavour.
- (inference) Blasphemous 2's paired-slot resonance gives combinatorial depth from a handful of items. DT could use pairs across two characters (Vox plus Ciphera) so the switch layer matters in the build, but this is a design option, not a finding.
- (inference) Valfaris's irreversible spend is cheap to author but punishes experimentation, which sets up the respec question in Q2.

### Gaps
- Afterimage (talent tree, weapon types) and Aeterna Noctis: the one combined search returned nothing on either, and no dedicated search was run. Unresolved.
- Death's Gambit soul stones, talent respec and death penalty: not found.
- Salt and Sacrifice death penalty and respec; Blasphemous 2 respec and death penalty; Valfaris death penalty: not found.
- Prima/Fextralife pages were seen as summaries, so numbers (e.g., the 1800 Nycrux price) are unverified against the game.

## Q2. Respec rules and what players and developers said

### Takeaway
Evidence is mostly player debate. Costed respec in Path of Exile 2 draws the loudest complaints, free respec (Diablo III) is the comparison players cite, and a limited item locked behind an optional boss (Elden Ring) is praised by some and disliked by others. No developer postmortem on respec was found for the Metroidvania games.

### Cited Findings
- Path of Exile 2: players say high respec costs relative to gold discourage experimentation and "punish" trying builds. A pre-launch reveal reportedly promised cheaper low-level respecs. The developers said they wish to avoid nerfing builds, which players argue conflicts with costly respec. Some players defend cost as deliberate friction in a grindy genre. — [GamesRadar](https://gamesradar.com/games/action-rpg/path-of-exile-2-is-dropping-loot-more-generously-but-early-access-players-are-still-being-bankrupt-by-the-action-rpgs-high-respec-costs-why-am-i-being-punished-for-trying-out-things), [PoE forum](https://pathofexile.com/forum/view-thread/3626685) (search summary; the developer claims are second-hand).
- Diablo III is cited by players as having free skill respecs. — [PoE forum, "Respec should be Free, Always"](https://webcdn.pathofexile.com/forum/view-thread/3609313) (search summary).
- Elden Ring: PC Gamer argues respec friction is a problem but more forgivable in a difficulty-centred game. A Reddit thread praises the finite respec item behind an optional boss, others say finite means no repeated respecs. — [PC Gamer 2023](https://www.pcgamer.com/for-the-love-of-all-that-is-holy-its-2023why-is-it-still-so-annoying-to-respec-in-singleplayer-rpgs) (headline fetched only; body truncated, so the summary above is from search), [r/truegaming](https://lr.eu.psf.lt/r/truegaming/comments/1iokor7/how_difficult_should_it_be_to_respec_in_rpgs).
- Valfaris: no redistribution of spent Blood Metal (see Q1).
- The Last Faith: sources conflict. One guide says no respec, and a Steam post says a respec was used after getting a teacup item. — [CommonSenseGamer](https://commonsensegamer.com/the-last-faith-attributes-guide/), [Steam discussion](https://steamcommunity.com/app/1274600/discussions/0/5971271978948964790) (search summary; unresolved).
- Hollow Knight (charms swap at benches), Salt and Sanctuary, Blasphemous: no respec rule found (as in file 05).

### Inferences
- (inference) DT's XP-as-spent-resource makes respec a design decision: refunding spent XP at a hub is natural, but use-based growth earned through rhythm grades is not "spent", so only the XP-spent nodes need a respec rule.
- (inference) A split fits: free swap for loadout and equipment, costed or limited respec for XP-bought stats, none for use-based growth that was earned by play.

### Gaps
- No developer statements on respec for any named Metroidvania. No Game Developer article found. PC Gamer's body text was not read.

## Q3. Research-before-craft progression

### Takeaway
Subnautica and Satisfactory both gate crafting behind a found or researched unlock, but they differ: Subnautica gates by a few quick scans in the world, Satisfactory by a researched tree with typed sample costs. No Metroidvania schematic hunt was found.

### Cited Findings
- Subnautica 2 (the page is about the sequel; the original is only mentioned in a Steam thread): blueprints usually need two or three fragment scans, each taking a few seconds if held uninterrupted. The PDA shows how many remain, and finishing triggers a Databank entry. Rescanning an already-owned item gives no reward. — [KeenGamer](https://www.keengamer.com/articles/guides/subnautica-2-scanner-guide-how-blueprint-unlocks-work/) (fetched). Counts are still being verified in early access per another search summary ([allthings.how](https://allthings.how/subnautica-2-blueprints-full-recipe-and-unlock-reference-early-access/)). Original Subnautica details were not fetched.
- Satisfactory MAM: picking up a researchable sample starts its tree. Most nodes take about 3 seconds, Hard Drive scans take 10 minutes. Each node is analysed by scanning, crafting a product from the sample, or spending items. Each node unlocks those below it, and the MAM shows percentage progress. Trees are independent of HUB Milestones, though some ingredients depend on Milestones. Research runs one item at a time on a shared queue. Four Hard Drives are needed for MAM trees. — [Satisfactory wiki.gg MAM](https://satisfactory.wiki.gg/wiki/MAM) (fetched).
- Salt and Sacrifice ties the unlock to the kill rather than a scan (Q1).

### Inferences
- (inference) For FLAG-39, a Subnautica-style "scan N fragments from salvaged bot types" is cheap to author: the fragment count is data, and duplicates are explicitly worthless so no grind. The MAM shape (one trigger item opens a small tree of typed steps) suits the engine-parts arc as a "tool knowledge" track.
- (inference) Hold-to-scan maps onto DT's rhythm layer only if the scan is a graded input, which is a design option and not sourced.

### Gaps
- No Metroidvania with a schematic hunt found. Original Subnautica, Dead Cells blueprint rules and Monster Hunter were not re-checked.

## Q4. Use-based growth done well (SaGa, Dungeon Siege)

### Takeaway
Romancing SaGa 2 has no XP: stats and techniques come from weapon use and situational triggers. Kawazu says the draw of sparking is the memorable win and that the frustration is managed by giving players ways to raise their odds. Dungeon Siege's class emerges from use. No source on anti-grind safeguards was found for either.

### Cited Findings
- Romancing SaGa 2: no experience points; stats rise from skill points gained when using weapons or abilities. Using a weapon raises proficiency and the chance to learn techniques tied to it. New abilities also unlock via situations such as parrying. Kawazu credited Kyoji Koizumi with the ability growth system as an improvement over the first game. — [Wikipedia Romancing SaGa 2](https://en.wikipedia.org/wiki/Romancing_SaGa_2) (fetched, first 100,000 characters only; the page does not mention sparking).
- Kawazu (Denfaminicogamer interview, as reported by Automaton) says players love Glimmering because winning thanks to a Glimmer stays with them. He used Romancing SaGa 3's final boss as an example. He says the way to avoid frustration is to encourage players to find ways to improve their odds, such as changing equipment or powering up. — [Automaton](https://automaton-media.com/en/news/saga-series-creator-says-giving-players-gameplay-driven-highs-matters-more-than-a-well-written-story/) (search summary only; my fetch returned just the headline, so this is second-hand and undated here).
- Sparking odds depend on enemy difficulty, weapon level and luck according to a secondary paraphrase, contradicted in part by forum posts about magic level. Treat as unverified. — same search summary.
- Dungeon Siege: Chris Taylor described a skill-based system where class is decided by how you play, with no class picked at the start. Dungeon Siege 3 moved to a menu-based skill-point system, dropping in-field levelling by use. — [GameBanshee Taylor interview](https://gamebanshee.com/kudpx), [PC Gamer DS3 preview](https://www.pcgamer.com/dungeon-siege-3-preview-2) (search summary only).

### Inferences
- (inference) SaGa's lesson for DT is separating a probabilistic reward (sparking) from raw repetition: the player is told what to change to improve odds, which DT can mirror by letting rhythm accuracy and affinity tier visibly raise the odds of a technique "sparking".
- (inference) Dungeon Siege 3 abandoning use-based levelling is a hint that pure use-based growth is hard to keep readable, supporting DT's choice to make XP a spent resource alongside use-based growth. Reason for the change was not found.

### Gaps
- SaGa Frontier growth rules and any developer anti-exploit statements; Dungeon Siege original exploit reports and Taylor's reasoning. The Wikipedia page's final 29,000 characters were not read.

## Q5. Per-character versus shared XP, and benched characters

### Takeaway
The only developer-side source found is a Game Developer article that names the problem and the standard fixes: reserve XP (Pokémon's XP Sharer) or levelling with the party. Everything else is player complaint or mods.

### Cited Findings
- Benjamin Wolf, Game Developer, 9 Jan 2018: reserve members earning no XP fall behind, so the player must grind a neglected character, which can become one of the game's greatest challenges, and catch-up can pad playtime artificially. The XP Sharer is held up as a fix that put progression and battle systems in line. — [Game Developer](https://gamedeveloper.com/design/make-grinding-fun---the-synergy-of-the-battle-system-and-the-progression-system-in-jrpgs-turn-based-strategy-games) (fetched). The article does not discuss over-levelling or stat bloat.
- Octopath Traveler II: a player complains benched members earn no XP and suggests auto-levelling to the party average. — [Steam thread](https://steamcommunity.com/app/1971650/discussions/0/3777994854961118157) (search summary).
- Baldur's Gate 2 EE has an XP Sync mod that matches party XP to the main character; a forum poster says most party RPGs since BG2 give XP to companions out of the party. — [Nexus mod](https://www.nexusmods.com/baldursgate2ee/mods/82), [BG3 Steam post](https://steamcommunity.com/app/1086940/discussions/0/2265817017321647127) (search summary).
- A tabletop house rule gives benched characters a small fixed XP per session. — [Kobold Press](https://koboldpress.com/metagame-mechanics/on-the-bench/) (search summary).
- Obsidian forum thread raises the worry that catch-up makes characters level asynchronously. — [Obsidian forums](https://forums.obsidian.net/topic/69625-on-class-exp-tables/) (search summary).
- Bloodstained: the active familiar shard gains XP from Miriam's kills (file 05).

### Inferences
- (inference) DT's XP-as-spent-resource is a good fit for catch-up: the shared part can be the income (a fraction of XP earned by the active character goes to each benched one's pool) while spending stays per-character. Missions for inactive members can pay out XP too. A fraction and a cap are design choices that I found no source for.
- (inference) Because DT's switching is a core mechanic and not an option, falling behind is worse than in a typical party game, since a locked-out character blocks puzzle layers (character-only interactables).

### Gaps
- No action-RPG or switch-game developer talk on per-character XP. No source found for Octopath's own rule (the thread is a complaint, not a rules page).

## Q6. Postmortems and talks on stat bloat, dead stats, over-levelling

### Takeaway
I found no developer postmortem on stat bloat, dead stats or over-levelling trivialising bosses. The only relevant sourced items are the Game Developer article's opposite problem (levels too slow to feel) and file 05's anecdotes.

### Cited Findings
- Wolf's article says level gains can go unnoticed ("the player might not feel the increase in strength") and treats slow levelling as the greater risk. — [Game Developer](https://gamedeveloper.com/design/make-grinding-fun---the-synergy-of-the-battle-system-and-the-progression-system-in-jrpgs-turn-based-strategy-games)
- Kawazu's point that frustration is managed by letting players raise their odds (Q4) is the nearest developer statement on keeping random reward from feeling arbitrary.
- The Last Faith guides advise Vitality first and scaling-driven second stat, which implies a dominant-stat path in a five-stat system. — [CommonSenseGamer](https://commonsensegamer.com/the-last-faith-progression-guide-best-stats/) (search summary; player advice, not developer intent).

### Inferences
- (inference) Make every stat visible in play (animation, tell or UI feedback) so gains are felt, and keep the stat count low, per file 05.

### Gaps
- Developer postmortems and GDC talks on stat bloat and dead stats were not found. Next step: targeted GDC Vault and Game Developer searches by title.

## Refinement of the first pass's build shapes

- **A (budget loadout plus use-based growth):** strengthened for T1 by Blasphemous 2's paired-slot resonance as a way to add depth without new items, but Valfaris and The Last Faith show irreversible stat/upgrade spend invites respec complaints, so keep loadout swaps free.
- **B (absorb-and-learn kit):** the Salt and Sacrifice kill-to-family mapping and the Subnautica scan-count unlock are the sourced models for this shape. Cost stays high because each enemy type needs authored content, so tie it to the three T1 enemy types.
- **C (corrupt-or-burn exclusive branch):** no new evidence. The Valfaris "no redistribution" complaint raises the build-lock risk for C.
- New hybrid option (inference): XP-spent stats with a costed or limited respec, loadout swaps free, and use-based growth never refunded.

## Borrow / Adapt / Enhance / Avoid

| Verdict | Item | DT system | Tier |
|---|---|---|---|
| Borrow | Kill a specific enemy class to unlock a gear family (Salt and Sacrifice mages) | Salvage arc, enemy affinity tiers | T2 |
| Adapt | Scan-N-fragments unlock where duplicates give nothing (Subnautica) | Tool-knowledge track, FLAG-39 | T2 |
| Adapt | One trigger item opens a small research tree with typed steps (Satisfactory MAM) | Engine-parts arc | T2 |
| Adapt | Paired-slot resonance (Blasphemous 2 altarpiece) as cross-character pairing | Switch layer, per-character loadout | T2 |
| Adapt | Benched characters earn a fraction of XP into their own spendable pool (Pokémon XP Sharer idea, per Game Developer) | Per-character XP pools, inactive missions | T1.5 |
| Enhance | Show players what raises the odds of a technique "sparking" (Kawazu's statement) | Use-based growth graded by rhythm | T1.5 |
| Enhance | Free loadout swap plus limited respec for spent XP, none for earned growth | XP-as-spent-resource | T1.5 |
| Borrow | Per-weapon or per-instrument trees (Blasphemous 2 Weapon Memories) | Gear arcs | T2 |
| Avoid | Irreversible upgrade spend with no redistribution (Valfaris) | XP spending, gear | T1 |
| Avoid | Benched characters stuck at low level, forcing grind (Game Developer, Wolf) | Switch mechanic, character-only interactables | T1 |
| Avoid | Relying on respec cost to create friction (PoE 2 complaints) | XP-as-spent-resource | T1.5 |

## Source quality notes
Fetched and read: Wikipedia Romancing SaGa 2, Satisfactory wiki.gg MAM, KeenGamer, Funario, Fextralife New Player Help, Game Developer (Wolf). All other items are search summaries, and the PC Gamer respec article and Automaton article returned headline only. Guide sites (earlyguides, Funario, CommonSenseGamer) are low-to-medium reliability. The Subnautica findings are for Subnautica 2 early access, not the original. All pages accessed 2026-11-05. No licence concerns; nothing is vendored. Per CLAUDE.md, no Godot binary is available here and this task is research-only, so nothing was run.
