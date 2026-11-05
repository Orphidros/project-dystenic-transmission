# RPG build systems in Metroidvanias and action-RPG side-scrollers (research for DT)

Research date 2026-11-05. Method: about 15 web searches, with search-result summaries as the evidence base. I did not fetch the full wiki pages, so exact numbers are only as good as those summaries, and fan wikis and guide sites are secondary sources. Several requested games (Salt and Sacrifice, Death's Gambit: Afterlife, Aeterna Noctis, Afterimage, The Last Faith, Valfaris, Ender Magnolia detail, Hi-Fi Rush scoring, Dungeon Siege, SaGa) returned nothing usable and are listed under Gaps. Nothing here should be copied. Mechanics are deconstructed into principles only. Any datamine or decompilation referenced by a wiki is for design-intent study only, and nothing should be vendored.

## Q1. Which build axes give the most depth for the least content?

### Takeaway
Three cheap axes recur: a fixed-budget loadout where items cost different amounts (Hollow Knight notches, Nine Sols Computing Power, Lost Crown amulet points), a mutually exclusive branch choice that changes the ending or ability set (Sundered Elder Shards, Dead Cells per-biome mutations), and absorb-to-learn kits (Bloodstained shards, Grime). Budget loadouts give the most depth per authored item, because 1-3 cost tiers and a slowly growing budget make every new item a trade rather than a straight upgrade.

### Cited Findings
- Hollow Knight: charms cost notches and can only be swapped at a Bench. The Knight starts with 3 notches and can reach 11 (8 are found). Overcharming lets you equip past the limit, and the community reports the cost is double damage taken until the next bench clears it (the wiki snippet I saw did not state the penalty, so the double-damage figure is community-sourced). — [Hollow Knight wiki, Charm Notches](https://hollowknight.wiki/w/Charm_Notches), [Overcharmed](https://hollowknight.wiki/w/Overcharmed), [HyperX explainer](https://blog.hyperx.com/article/2556/hollow-knight-overcharmed-status-and-what-it-means). Guide site rogueranker.com contradicts the wiki on some details, so I did not use its figures.
- Nine Sols: Jades are passive buffs, each costing 1 to 3 Computing Power. You start with 2 and can expand to 10 via Computing Units, some of them bought from a merchant for 1000 Jin. A guide calls 4 slots a power spike because most strong early Jades cost 2. No developer statement of the budget figures was found. — [GINX Jade slots](https://ginx.tv/en/nine-sols/jade-slots), [GameSkinny](https://www.gameskinny.com/?p=196670)
- Prince of Persia: The Lost Crown: amulets are passives swapped at Wak-Wak Trees (the save points), cost 1 to 3 equip points, and holders found in the world raise the cap. Most amulets have three tiers (Slightly, Moderately, Greatly) bought at a forge with ore and currency. — [Guides4Gamers](https://guides4gamers.com/prince-of-persia-the-lost-crown/poi/amulets/), [GGRecon](https://www.ggrecon.com/guides/prince-of-persia-the-lost-crown-upgrade-weapons-amulets)
- Blasphemous: 52 rosary beads exist as passive equipment in the first game, some of which modify the death penalty (see Q2). The Mea Culpa sword is upgraded at altars for Tears of Atonement. — [Blasphemous wiki.gg Guilt](https://blasphemous.wiki.gg/wiki/Guilt), [meowdb rosary beads](https://meowdb.com/db/blasphemous/rosary-beads)
- Ender Lilies: spirits drop from bosses and minibosses, relics are found by exploring, and both are equipped at respites. Spirit upgrades cost Blight types tied to source (red Furious Blights for boss spirits, orange Stagnant Blights for minibosses, one spirit upgraded with Ancient Souls). Ender Magnolia raised the loadout from three spirits to four homunculi and swapped Blights for materials spent at a town shop. Early-access information, so later builds may differ. — [PCInvasion guide](https://pcinvasion.com/ender-lilies-skills-relics-guide/3), [Prima Games](https://primagames.com/gaming/ender-lilies-skills-relics-guide/3), [Siliconera preview](https://siliconera.com/?p=1022479)
- Bloodstained: shards are demonic abilities absorbed from defeated demons or released by Shard Stands. Duplicate copies raise a parameter up to grade 9. A second layer of upgrade (usually attack power) uses materials at the Alchemist. Familiar shards gain XP separately. Shard crafting consumes only reagents, not the shard. A reviewer calls the RPG layer "refreshingly simplistic" with five stats. — [Fextralife Shards](https://bloodstainedritualofthenight.wiki.fextralife.com/Shards), [Fandom Shard Stand](https://bloodstained.fandom.com/wiki/Shard_Stand), review via [Backloggd search result set](https://www.backloggd.com/u/TeN/review/79037)
- Grime: the player absorbs a near-death enemy by timing a parry. Some traits need repeated absorbs of the same enemy to learn fully. Learned traits are activated by spending Hunt Points. Weapons are also gained from absorbed enemies. Grime II replaces this with molds. — [Prima Games](https://primagames.com/gaming/grime-enemy-skills-traits-hunt-points-guide), [PC Gamer](https://www.pcgamer.com/grime-a-metroidvania-that-lets-you-absorb-enemies-is-out-now)
- Sundered: a nonlinear shard-funded skill tree, perks slotted into the tree each carrying an advantage and a disadvantage. A boss gives an Elder Shard, which can corrupt a specific ability at a shrine or be burned in the Incinerator for currency and tree unlocks. Three endings depend on how many shards were used (at least one corruption without using all seven gives the mixed ending, all seven gives the corrupt ending). — [Wikipedia Sundered](https://en.wikipedia.org/wiki/Sundered), [Player.One abilities](https://www.player.one/sundered-guide-abilities-corrupted-upgraded-elder-shards-final-boss-118701)
- Dead Cells: power scrolls raise one of Brutality, Tactics or Survival with diminishing returns per stat, encouraging diversification. 53 mutations exist (12 per colour plus 17 colourless), picked per biome. Sources disagree on exact scroll bonuses (+15% damage appears consistently). — [Dead Cells wiki.gg Mutation](https://deadcells.wiki.gg/wiki/Mutation), [Nintendo Life review](https://www.nintendolife.com/reviews/nintendo-switch/dead_cells)
- Rogue Legacy 2: Heirloom meta-progression expands what heirs can do. Traits were reworked to include more positive and neutral ones, and a patch note lists traits going from 37 to 44. Negative traits can earn extra money. Runes, blueprints, ore and souls persist. — [Siliconera](https://www.siliconera.com/rogue-legacy-2-makes-classes-and-traits-more-impactful-to-the-quest/), [RL2 v0.3.0 patch notes](https://roguelegacy2.com/patchnotes/v030), [Game Informer](https://gameinformer.com/review/rogue-legacy-2/generations-of-greatness)
- Salt and Sanctuary: salt converts to Black Pearls on level-up and is spent in a connected-node skill tree where basic nodes can be taken up to five times. Level-up is available at any Sanctuary regardless of creed. — [S&S fan wiki, player mechanics](https://sites.google.com/view/saltandsanctuarywiki/character-info/player-mechanics) (the "creed does not gate the tree" point is from that wiki, which I only saw summarized).

### Inferences
- (inference) Budget-with-unequal-costs gives depth cheaply because content scales as items times cost tiers times budget growth, while authoring cost scales only with items. Every budget increase in Hollow Knight, Nine Sols and Lost Crown is also a collectible, so it doubles as exploration reward.
- (inference) For DT, with five characters and affinity tiers 1-5, a per-character budget loadout (not a shared one) multiplies combinations without new items, but T1 has only Vox and Ciphera, so the budget would be tuned for two.
- (inference) Mutually exclusive choices (Sundered corruption, Dead Cells mutations) fit DT's tone pillar "cost of blind trust" and its musical choice tones, since a corrupt-or-burn choice could be signalled without a good/bad UI.

### Gaps
- Respec rules were not found for any game in these results (Salt and Sanctuary, Blasphemous, Hollow Knight swap rules aside). Needs a targeted search.
- Salt and Sacrifice, Blasphemous 2 prayers and weapon trees, Death's Gambit: Afterlife, Aeterna Noctis, Afterimage, The Last Faith, Valfaris: searches returned nothing relevant or were not run. I will not state details from memory without sources.

## Q2. Souls-lite currencies and death penalties

### Takeaway
Two families: recover-from-death-spot (Salt and Sanctuary salt, Blasphemous guilt fragment) and bank-or-lose (Dead Cells cells at the Collector). Blasphemous is the most distinctive because death adds a persistent debuff and gold-like currency sink, rather than just a retrieval chore.

### Cited Findings
- Salt and Sanctuary: on death you respawn at the last Sanctuary, losing all salt plus 10% of gold per the fan wiki. A 2015-16 Reddit FAQ describes the gold loss as permanent and salt as recoverable by killing the enemy that took it, which gets an HP buff. Dying again first loses the salt for good. One review says the gold cost varies. Enemies respawn when you rest, which makes retrieval harder. Sources conflict on whether the buffed enemy is the killer or a new one. — [fan wiki](https://sites.google.com/view/saltandsanctuarywiki/character-info/player-mechanics), [Reddit FAQ](https://lr.in.psf.lt/r/saltandsanctuary/comments/4c6fcy/new_player_guidefaq), [GodisaGeek review](https://godisageek.com/reviews/salt-and-sanctuary-review/)
- Blasphemous: death leaves a Guilt Fragment near the death location. Picking it up expiates part of the guilt, and any boss defeat clears all fragments. Guilt lowers maximum fervour and Tears of Atonement earned from kills, with a penalty growing per fragment. Confessor Statues remove guilt for Tears using g x (l+1) x 100 (g guilt level, l Mea Culpa level). A bead (Concentrated Sphere of Guilt) reduces guilt dropped. — [wiki.gg Guilt](https://blasphemous.wiki.gg/wiki/Guilt), [wiki.gg Confessor Statue](https://blasphemous.wiki.gg/wiki/Confessor_Statue), [meowdb bead](https://meowdb.com/db/blasphemous-2/rosary-beads/concentrated-sphere-of-guilt)
- Dead Cells: unspent cells are lost on death, so you bank them at the Collector between levels. Creates push-forward vs bank tension. — [Dead Cells wiki / guides result set](https://deadcells.wiki.gg/wiki/Runes) (the summary I saw for the cell-loss rule came from guide sites, treat as secondary)
- Ender Lilies / Magnolia: upgrade currency is typed by source (Blights), which ties spending to which boss you killed, rather than a generic pool. — [Prima Games](https://primagames.com/gaming/ender-lilies-skills-relics-guide/3)

### Inferences
- (inference) For DT, whose health system already has blackout, injury accumulation and an escort, the death penalty slot is partly filled. A Blasphemous-style persistent "debt" (here, perhaps accumulating stress or injury) tied to a recoverable token would reuse existing systems, but XP-as-spent-resource already means unspent XP is the exposed asset.
- (inference) Boss defeat as the guilt-reset (Blasphemous) is a way to make progress forgiving without a separate banking rule.

### Gaps
- Behavior of death penalties versus exploration (does the penalty discourage scouting?) was not found in sourced reviews. Hollow Knight shade and Nine Sols were not searched.

## Q3. Use-based growth without grinding exploits

### Takeaway
The documented pattern is that use-based systems reward cheap repeated actions, and the exploit is almost always a self-inflicted or harmless-target loop. FF2 is the canonical case and the Elder Scrolls lineage shows the recurring fixes: gains gated to meaningful outcomes, trainers, per-target or per-action caps.

### Cited Findings
- FF2: stat growth is tied to use, and players exploit it by attacking allies or casting repeatedly. The game cannot tell enemy damage from ally damage, cancelled commands reportedly still count, and a Steam guide says gains proc once per battle regardless of hit count. One PSP-focused source (low reliability domain) claims ally attacks are unnecessary in that version, unverified. Wikipedia notes the unintended growth. — [Wikipedia FF2](https://en.wikipedia.org/wiki/Final_Fantasy_II), [Steam guide thread](https://steamcommunity.com/app/1173780/discussions/0/3768987250129220655), [Goomba Stomp analysis](https://goombastomp.com/not-final-fantasy-ffiis-intriguing-flawed-progression-system/)
- Morrowind: drain a skill with a spell and re-train it, and keep training past 100 (the skill points still accrue). The Official Morrowind Patch fixed at least one path. — [UESP Morrowind:Cheats](https://app.uesp.net/wiki/Morrowind:Cheats)
- Oblivion: casting at non-hostile NPCs, buying out Alchemy vendors, and taking fall damage for Acrobatics are cited exploits. Community proposals: reward real combat, use script event handlers to detect genuine use, or require paid trainers. — [PC Gamer](https://pcgamer.com/games/the-elder-scrolls/oblivion-remastered-leveling-explained-skills-list), [Gamesas thread](https://www.gamesas.com/post417538.html), [Nexus forum](https://forums.nexusmods.com/topic/392452-seeking-a-mod-to-fix-levelling-system)
- Skyrim: the legendary-skill reset enables repeating the loop for effectively unlimited levels. — [GamingBible](https://www.gamingbible.com/news/skyrim-infinite-levels-exploit-123524-20250530)
- Kenshi: community reports gains slow from the mid-80s and are very slow at 99. A "weaker opponent" penalty can cut training by up to 90% (from a mod description, so unverified against the game). Strength training depends on weapon weight, and players recommend junk-quality weapons for training attack and defence. — [Kenshi Steam threads](https://steamcommunity.com/app/233860/discussions/0/3300476731143927633), [Nexus mod 874](https://nexusmods.com/kenshi/mods/874), [Kenshi wiki Strength](https://kenshi.wiki/w/Strength)
- Dead Cells diminishing returns per scroll stat is an in-genre analogue of a per-stat curve. — [Nintendo Life](https://www.nintendolife.com/reviews/nintendo-switch/dead_cells)

### Inferences
- (inference) Fix toolkit for DT: (1) gain only from graded outcomes, so a Perfect/Good hit on a live threatening enemy counts and a Miss or a harmless target does not; (2) a per-encounter cap, like FF2's once-per-battle proc but made deliberate; (3) diminishing returns per ability rank (Kenshi, Dead Cells); (4) an enemy-affinity-tier multiplier, where tier 1-5 enemies below the character's tier give reduced growth (mirrors Kenshi's weaker-opponent penalty); (5) no growth from self-inflicted or friendly damage, since DT knows damage source; (6) XP as a spent resource means growth is chosen, not automatic, which removes the "must grind everything" pressure.
- (inference) Because DT's stress and stamina are hidden or costed, grinding by spamming a costed action is naturally limited if growth requires successful, not merely attempted, use.

### Gaps
- Dungeon Siege and SaGa (Frontier, Romancing) use-based growth: no usable results; the SaGa spark and stat-growth rules need a dedicated source. FF2's documented fixes in later versions (Pixel Remaster) are only mentioned as "fixes some bugs", with no specifics.

## Q4. Crafting and research progression (blueprints found or researched first)

### Takeaway
The evidence I found supports three loops: blueprint-for-currency unlock (Dead Cells Collector), reagent-only crafting that keeps the ability (Bloodstained), and town-shop construction from dropped materials (Ender Magnolia, Lost Crown forge). I found no sourced example of true "research a spec by dissecting an enemy" in this genre.

### Cited Findings
- Dead Cells: most items are locked until blueprints dropped by enemies are brought to the Collector and a cell cost is paid. Blueprints are rare drops. — [Dead Cells Fandom](https://deadcells.fandom.com/wiki/Runes_and_upgrades), [Gamers Decide](https://gamersdecide.com/articles/dead-cells-best-blueprints) (rune-unlock mechanics conflict between sources, unresolved)
- Bloodstained: shard crafting consumes reagents only, not the shard, combining item and shard crafting. — [Fextralife Shards](https://bloodstainedritualofthenight.wiki.fextralife.com/Shards)
- Ender Magnolia: gear is constructed at a town shop from gathered materials, and bosses can drop rare components that unlock further powers (early access info). — [Siliconera](https://siliconera.com/?p=1022479)
- Lost Crown: amulet tiers are bought at a forge using ore and currency. — [GGRecon](https://www.ggrecon.com/guides/prince-of-persia-the-lost-crown-upgrade-weapons-amulets)

### Inferences
- (inference) For FLAG-39 (engine-parts arc), "tool knowledge as a discovered track" can use the Dead Cells shape: a salvaged bot yields a spec fragment (the blueprint), and a cost at a workshop converts it into craftable parts. Salvage loops mirror Ender Magnolia's boss-component drops, scaled to Affinity tier 1-5 so higher tiers drop higher specs.
- (inference) Bloodstained's reagent-only crafting is a good safeguard against build-locked frustration: crafting never destroys the learned ability.

### Gaps
- No sourced example of research-before-craft (e.g. scanning or dissecting an enemy to unlock a recipe) in a Metroidvania. Needs targeted search (e.g. other genres: Subnautica-style scanning, Monster Hunter).

## Q5. RPG stats coexisting with skill-based action and timing grades

### Takeaway
Rhythm-action games that I found tie timing to a multiplier rather than to growth. Evidence is thin for DT's Perfect/Good/Poor/Miss feeding all three of damage, resource gain and growth.

### Cited Findings
- Metal: Hellsinger: a multiplier (Fury, max 16x per sources) rises with beat accuracy and falls on off-beat or damage. Sources say on-beat shots raise bullet damage and score. Not tying to growth. — [One More Game review](https://onemoregame.ph/metal-hellsinger-review-pc/), [GameCritics](https://gamecritics.com/?p=47231)
- Crypt of the NecroDancer: beat matching boosts a coin multiplier, and missing the beat resets it. The developer widened the timing window and added auto-calibration to reduce stress. — [Wikipedia mirror](https://wiki.krisyotam.com/content/wikipedia_en_all_nopic_2026-03/Crypt_of_the_NecroDancer)
- Grime: parry timing gates the absorb, so a timing skill is the gate for growth. — [Prima Games](https://primagames.com/gaming/grime-enemy-skills-traits-hunt-points-guide)
- Dead Cells diminishing per-stat scroll returns act as a soft stat cap that prevents stat scaling from replacing skill. — [Nintendo Life](https://www.nintendolife.com/reviews/nintendo-switch/dead_cells)

### Inferences
- (inference) A usable DT scheme: Perfect = full damage plus a resource refill plus growth credit; Good = reduced damage plus growth credit; Poor = no growth credit; Miss = stamina or stress cost and no credit. Growth credit only on Perfect/Good ties use-based growth to skill and removes the FF2-style spam exploit.
- (inference) Calibration options (NecroDancer) matter, since a timing-gated growth system punishes latency for players with bad audio sync.

### Gaps
- Hi-Fi Rush scoring specifics were not found. Nine Sols (parry/talisman) and Sekiro-like posture systems were not searched. No example found where timing grade directly feeds XP growth other than Grime's gate.

## Q6. Per-character progression in party or switch games (brief)

### Takeaway
Of the games researched, only Ender Lilies/Magnolia (spirits upgraded individually, familiar shards leveling separately in Bloodstained) offer per-unit growth, and none is a true multi-protagonist switch game.

### Cited Findings
- Bloodstained: the active familiar shard receives EXP from Miriam's kills as well as its own, so growth follows the equipped unit. — [Fandom Shard Stand/Familiar info](https://bloodstained.fandom.com/wiki/Shard_Stand)
- Ender Lilies: each spirit is upgraded separately with typed Blights. — [Prima Games](https://primagames.com/gaming/ender-lilies-skills-relics-guide/3)

### Inferences
- (inference) "Active earns, bench earns less" (the Bloodstained familiar rule) answers the per-character-pool question with a mild catch-up for unused characters, relevant to DT's inactive-member missions. A separate track covers party systems.

### Gaps
- No sourced party-game XP-pool comparison (shared vs per-character) in these results.

## Q7. Pitfalls: stat bloat, dead stats, over-levelling, build lock

### Takeaway
Evidence is anecdotal. Over-levelling is the most reported, and "leaning on leveling instead of skill" is the critique to avoid.

### Cited Findings
- A Steam commenter says players can be overleveled by heaps and steamroll bosses. A critic says Tower Hunter: Erza's Trial leans on leveling over skill. A Backloggd reviewer wanted slower leveling and more meaningful choices after acquiring every skill early. — [Steam thread](https://steamcommunity.com/app/1701520/discussions/0/3830918083265314633), [Metroidvania Review](https://metroidvaniareview.com/tower-hunter-erzas-trial/), [Backloggd](https://www.backloggd.com/u/TeN/review/79037)
- Bloodstained's five stats and basic leveling were called refreshingly simplistic. — [Backloggd](https://www.backloggd.com/u/TeN/review/79037)
- Dead Cells diminishing returns discourage single-stat stacking. — [Nintendo Life](https://www.nintendolife.com/reviews/nintendo-switch/dead_cells)
- Kenshi's slowdown above ~85 and weaker-opponent penalty are anti-trivialising brakes (see Q3).

### Inferences
- (inference) Keep stat count low (Bloodstained), put caps on per-stat returns (Dead Cells, Kenshi), and make XP spending a choice among exclusive options to avoid "acquired every skill early".
- (inference) Respec: free respec at a hub avoids build-locked frustration but removes commitment. A cheap respec with a cost is a common middle ground (not sourced).

### Gaps
- No sourced developer postmortem on stat bloat or dead stats; nothing found for Death's Gambit, Salt and Sanctuary or Blasphemous pitfalls.

## DT mapping and alternative build-system shapes (options, not decisions)

### Option A: Notch-budget loadout plus use-based tool growth
Each character has a gear/tool budget (Hollow Knight, Nine Sols, Lost Crown shape) and abilities grow with graded use. XP is spent only on stat nodes. Trade-offs: very cheap to author and easy to balance for T1's two characters; risk is shallow stat choices and budget feeling like a stat sheet.

### Option B: Absorb-and-learn kit
Tool knowledge is learned from salvaged or defeated enemies (Grime, Bloodstained shards), duplicates raise a rank, XP is spent to activate or rank them, and affinity tier gates what can be learned. Trade-offs: strongest tie to the "Knowledge is the weapon" pillar and FLAG-39; needs enemy-specific authored content, so more costly beyond three T1 enemy types.

### Option C: Corrupt-or-burn exclusive branch
Story-beat abilities offer a Sundered-style choice: use a unique token to corrupt (enhance with a cost) or consume it for XP. Choices are signalled by musical tones. Trade-offs: compounds with DT's branching narrative and cheap per choice; risk is build-locked frustration and a hard-to-balance power gap between ending paths, plus out-of-scope risk if it hints at permadeath consequences.

All three can combine a use-based layer, and none requires the T1-excluded systems (permadeath, combos, aerial switching).

## Borrow / Adapt / Enhance / Avoid

| Verdict | Item | DT system | Tier |
|---|---|---|---|
| Borrow | Budget loadout with unequal costs and found budget upgrades (Hollow Knight, Nine Sols, Lost Crown) | Per-character gear/ability slots | T1 |
| Adapt | Use-based growth credited only on Perfect/Good outcomes, capped per encounter, diminishing per rank | Use-based ability growth, rhythm tiers | T1 |
| Adapt | Blueprint-at-workshop unlock (Dead Cells Collector) for specs found on salvaged bots | Tool-knowledge track, engine-parts arc (FLAG-39) | T2 |
| Adapt | Guilt-fragment style recoverable death debt | Souls-lite framework, injury/stress | T1.5 |
| Adapt | Active-earns, bench-earns-less XP | Per-character XP pools, inactive missions | T2 |
| Enhance | Affinity tier 1-5 multiplier on growth (weaker-opponent penalty idea from Kenshi) | Enemy affinity tiers | T1.5 |
| Enhance | Reagent-only crafting that keeps learned abilities | Armour and engine-research arcs | T2 |
| Enhance | Corrupt-or-burn exclusive token with musical signalling (Sundered) | Story-beat abilities, choice tones | T2 |
| Borrow | Low stat count (Bloodstained, five stats) | Stats track | T1 |
| Avoid | Growth from friendly or self-inflicted damage, or cancelled actions (FF2, Morrowind) | Use-based growth | T1 |
| Avoid | Levelling that replaces skill (Tower Hunter critique) and trivialises bosses | Combat, bosses | T1.5 |
| Avoid | Permadeath-tied penalties, combo systems, aerial switching in Tier 1 | Scope lock | T1 |

## Source quality notes
- Mostly fan wikis (secondary), guide sites and player forums. rogueranker.com, shapes.inc and a low-reliability PSP guide conflicted with wikis and were not relied on. Wiki and guide pages were seen as search summaries, not fully fetched. All pages accessed 2026-11-05 via search. No licence concerns, since nothing is vendored.
