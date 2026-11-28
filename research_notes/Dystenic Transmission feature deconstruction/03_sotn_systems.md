# Castlevania: Symphony of the Night and the Igavania lineage: systems teardown for DT

Research date 2026-11-05. About 22 tool calls; several key sources blocked (TCRF 403, Castlevania Fandom 402, SDA knowledge base 403). **Numeric formulas and the level curve could not be verified.** They are listed as gaps with the exact source to pull next. Design study only: DT rebuilds principles originally and copies no names, content or code.

## 1. Character stats, growth, damage, luck, status, elements

### Takeaway
SotN has four attributes (STR, CON, INT, LCK) plus HP, MP and Hearts. Level-ups raise attributes, and Life/Heart Vessels permanently raise max HP and Hearts. Verified LCK rules: drops scale with LCK, and a critical triggers when ATT is below LCK. The full damage/defence formula and level curve are NOT verified; ZKeene's FAQ is the community's reference for them.

### Cited Findings
- Four attributes: strength, constitution, intelligence, luck. HP and MP limit survival and casting. Enemies grant XP and levelling raises attributes. Life Vessels and Heart Vessels permanently raise max HP and Hearts. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night) (fetched 2026-11-05)
- Igarashi said earlier Castlevanias were too hard for average players, so XP levelling and items were added to make exploration less difficult. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Luck and drops: base drop rate x LCK / 100, capped at 50% (common) and 25% (rare). Critical: if total ATT is less than total LCK, a crit does random damage between ATT and ATT+LCK. Thief Ring +7 LCK, Soul Eater Ring +5, and Gambler Glasses show drop percentages. Source is a search-result summary of a fan wiki; page itself was paywalled/blocked (402), so treat as (unverified). — [Castlevania Wiki: LCK](https://castlevania.fandom.com/wiki/LCK)
- CON affects knockback height on being hit (lower CON gives more height). Losing half or more of HP in one hit sends Alucard flying until he hits a wall. Hit direction depends on hitbox position relative to Alucard. — [TASVideos SotN resources](https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight)
- The RNG advances constantly and is pushed by AI and by animations. — [TASVideos SotN resources](https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight)
- TASVideos names ZKeene's FAQ as the most reliable source for damage formulas, stat effects and the bestiary, with minor inaccuracies. — [TASVideos](https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight). It is listed as "SOTN FAQ By Zach Keene" at [castlevaniaspeedruns.com/SOTN](https://castlevaniaspeedruns.com/SOTN).
- Aria's LCK is reported by forum posters as near-useless for souls (thousands of points needed); forum claims only. — [Steam discussion](https://steamcommunity.com/app/1552550/discussions/0/3082142648917531858) (unverified)

### Inferences
- (inference) SotN's LCK is a hidden probability dial with two jobs (drops and crits). DT could expose luck-like effects through its Signal states or stress rather than a visible stat.
- (inference) CON-as-knockback shows stats can change physical feel, not only numbers. This suits DT's 3D animation.

### Gaps
- Damage formula (STR, weapon ATT, enemy DEF), level curve (XP thresholds, stat gains per level), status-effect list and durations, and per-enemy elemental tables. Not found in fetchable sources. Next: ZKeene FAQ on GameFAQs; sotn-decomp source and `sotn.xee.dev` progress tooling (study only).
- Whether SotN has the stat-per-level numbers claimed in common memory: not verified, so none are given here.

## 2. Equipment

### Takeaway
SotN replaced the whip with a wide range of weapons and an inventory, which was an intentional pivot. Slot layout details (two hands, head, body, cloak, two accessories), two-handed rules and special-weapon inputs are well known but I could not fetch a citable source.

### Cited Findings
- Alucard uses a wide variety of weapons instead of a whip, with an inventory. The whip was dropped because it took too much screen space and the team wanted unique moves such as transformations. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Hearts fuel sub-weapons. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Bloodstained: weapon type sets attack style (short swords fast close, spears reach, guns ranged only). Equipment drops from monsters and chests. — [Wikipedia, Bloodstained](https://en.wikipedia.org/wiki/Bloodstained:_Ritual_of_the_Night)
- Several LCK accessories exist (Thief Ring, Soul Eater Ring, Gambler Glasses). — [Castlevania Wiki: LCK](https://castlevania.fandom.com/wiki/LCK) (unverified)

### Inferences
- (inference) Equipment pressure works when gear changes how combat plays (reach, speed, input), not only numbers. DT's melee range tiers (close, mid, extended, ranged) map directly to this.

### Gaps
- Exact slot count and layout, two-handed weapon rules, consumable-throw rules, special-weapon inputs and "experimentation" rewards (hidden gear, shield rods, etc.): no fetchable verified source. Next: [castlevaniadungeon.net SotN list](https://castlevaniadungeon.net/Arsenal/sotnlist.html) (appeared in search; not fetched), ZKeene FAQ.

## 3. Abilities, gating, spells, familiars, sub-weapons

### Takeaway
Gating is by transformation and traversal abilities (bat, wolf, mist) gained as items. Eight spells are cast via directional inputs for MP, familiars aid combat and exploration, and Hearts fuel sub-weapons. Igarashi's Bloodstained design step 1 was "create abilities that expand the map".

### Cited Findings
- Most of the castle is locked until the player gets items and abilities such as bat, wolf and mist. A map updates as the player explores. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Eight spells are cast by directional inputs, each with a varying MP cost. Familiars aid in battle and exploration. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Motion inputs must be entered exactly, with no approximation. — [castlevaniaspeedruns.com/SOTN](https://castlevaniaspeedruns.com/SOTN)
- Relic pickup triggers a screen pause, relevant to glitches. Wolf form can clip into slopes (a gating-break risk). Richter Skip bypasses a story gate via wolf clip or wolf jump. — [TASVideos](https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight)
- Igarashi on Bloodstained: his first design step was creating abilities that expand the map. — [Game Developer, Graft, 2019-07-23](https://www.gamedeveloper.com/business/a-i-bloodstained-i-q-a-with-koji-iga-igarashi)
- Level-ups, relics, Max Up and Heart Refresh all trigger screen pauses. — [TASVideos](https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight)

### Inferences
- (inference) Gate-breaking glitches show the cost of gates that rely on one ability. DT's "a character only sees an interactable if they have the skill" rule is a stronger gate: hidden affordances rather than blocked doors. Speedrun glitches suggest testing for sequence breaks via clipping, since 3D CharacterBody3D clipping risks are real.
- (inference) Spell inputs map to DT's rhythm combat as timed or rhythmic inputs instead of directions.

### Gaps
- Spell command list and MP costs, familiar level-up thresholds, sub-weapon Heart costs: not verified. Next: ZKeene FAQ; [TrueAchievements guide credits spell list](https://www.trueachievements.com/a14476/apprentice-achievement).

## 4. World structure

### Takeaway
SotN replaced stage-by-stage progression with an open castle inspired by Zelda and Super Metroid, with an inverted-castle reveal after freeing Richter. Map-completion percentage, save rooms, teleporters, Librarian and drop tables are unverified here.

### Cited Findings
- Team dropped stage-by-stage progression for an open explorable castle. Zelda inspired exploration and backtracking, and Super Metroid directly influenced the game. Motivation: linear Castlevanias in bargain bins had little replay value, and Igarashi wanted a game "that could be enjoyed for a long time". — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Freeing Richter from Shaft unlocks an upside-down castle. Alucard finds five bosses to collect five parts of Dracula. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Development began 1994 as a 32X title (The Bloodletting), then became SotN on PlayStation. Toru Hagihara directed and produced; Igarashi became assistant director to finish it. — [Wikipedia, SotN](https://en.wikipedia.org/wiki/Castlevania:_Symphony_of_the_Night)
- Aria added hidden rooms and breakable walls missing from Harmony of Dissonance, and areas where the route starts linear and branches as abilities grow. — [Wikipedia, Aria](https://en.wikipedia.org/wiki/Castlevania:_Aria_of_Sorrow)
- Map-edge and room-load exploits (shiftline, edge travel) exist because rooms stream by screen. — [TASVideos](https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight)

### Inferences
- (inference) The inverted castle is a content-reuse multiplier. DT's "decaying world / Decay Map" and vertical Deep-City layers are a more original reuse: the same space changing over time rather than a flip.

### Gaps
- Map-completion percentage (the common figure is 200.6%, not verified), number of save rooms and teleporters, Librarian shop, boss order and pacing, and drop tables. Wikipedia fetch was truncated at 100,000 of 119,427 characters. Next: ZKeene FAQ, castlevaniadungeon.net, TCRF (403 from this environment; try a browser).

## 5. Later evolutions

### Takeaway
Each sequel isolates one SotN system and pushes it: souls (Aria, Dawn), partners (Portrait), glyph-and-quest (Ecclesia), shards, crafting and cooking (Bloodstained). Portrait of Ruin is the closest model to DT's band-switching and combo attacks.

### Cited Findings
- **Aria Tactical Soul:** absorb enemy souls. Bullet (red, replaces sub-weapons, costs MP), Guardian (blue, continuous, drains MP), Enchant (yellow, passive), Ability (unique enemies, always on, no MP). One Bullet, one Guardian, one Enchant equipped at once. Link-cable trading, added because Igarashi believed collecting everything alone would be difficult. Ability souls work like Harmony of Dissonance relics. — [Wikipedia, Aria](https://en.wikipedia.org/wiki/Castlevania:_Aria_of_Sorrow)
- Drop rates vary per enemy; Kicker Skeleton's soul must be taken from a live enemy; Soul Eater Ring and Hard Mode help. — search-result summary of [Castlevania Wiki: Ability soul](https://castlevania.fandom.com/wiki/Ability_soul) and Steam threads (unverified)
- **Dawn of Sorrow:** multiple copies of a soul raise its effect, a Doppelganger soul allows two loadouts, souls can be spent to upgrade weapons, Magic Seals (touch pattern after a boss's HP hits zero; failure restores the boss) were criticised. Igarashi feared touch controls would slow "pure action gameplay". — [Wikipedia, Dawn](https://en.wikipedia.org/wiki/Castlevania:_Dawn_of_Sorrow)
- Dawn: Julius Mode unlocks after finishing; playable Julius, Yoko, Alucard; static abilities, stats grow by level. — [Wikipedia, Dawn](https://en.wikipedia.org/wiki/Castlevania:_Dawn_of_Sorrow)
- **Portrait of Ruin:** free switching between Jonathan and Charlotte, an expansion of Dawn's Julius mode. Dual Crush is a joint attack; some puzzles and story sections require both (a motorcycle sequence alternates riders). Paintings are portals to themed pocket areas; designers wanted outdoor settings to avoid repetitive indoors. Igarashi felt Tactical Soul overshadowed items, so quests replaced it. Two-player design homage to Castlevania III. 155 enemies in the bestiary. — [Wikipedia, Portrait](https://en.wikipedia.org/wiki/Castlevania:_Portrait_of_Ruin)
- Portrait partner AI and Dual Crush cost: the idle partner is CPU-controlled, mimics basic movement and attacks enemies in range; Dual Crush is triggered with Up+X and costs MP by the equipped crush; partner damage drains MP so players keep switching; "Rush" is alternating attacks. — search snippets quoting [VGMuseum review](https://www.vgmuseum.com/mrp/cv-por/rev-por.htm) and a GamesRadar interview ([page 2](https://gamesradar.com/portrait-of-ruin-interview/2)); secondhand (unverified)
- **Ecclesia:** over 100 glyphs, equipped to arms and back; MP-draining; Glyph Unions are combined attacks that spend Hearts. — [Wikipedia, Ecclesia](https://en.wikipedia.org/wiki/Castlevania:_Order_of_Ecclesia)
- Wygol Village: villagers are freed by absorbing Torpor glyphs, then return to the village; most offer optional quests that give items or unlock shop stock; one rescue (Nikolai) is mandatory; finishing all quests earns the Master Ring, which doubles attribute points gained; Eugen's first quest costs 3 Iron Ores and unlocks Iron Plate/Leggings. — [StrategyWiki, Ecclesia villagers](https://strategywiki.org/wiki/Castlevania:_Order_of_Ecclesia/Villagers) (via search summary)
- **Bloodstained:** shards dropped by monsters, limited equip slots, swappable on the fly, cost MP. After the prelude, NPC shops sell and craft weapons and upgrade shards. Unreal Engine 4. Kickstarter launched 2015-05-11, $500k base goal met in four hours, over $5.5M raised. 2017 release slipped to 2018 and then shipped 2019-06-18 (PS4, PC, Xbox One; Switch 2019-06-25). Stretch goals included co-op, boss rush, classic mode, roguelike mode; Linux/macOS and Vita ports cancelled; Switch launch had input lag and stutter. — [Wikipedia, Bloodstained](https://en.wikipedia.org/wiki/Bloodstained:_Ritual_of_the_Night)

### Inferences
- (inference) Portrait's MP-as-switch-pressure is a single shared resource tying switching and combo to cost. DT's per-character XP pools and stamina could do the same job, and it suggests keeping the idle party member always doing something visible (AI, mission, or recovering).
- (inference) Bloodstained's Kickstarter lesson for a solo developer: stretch goals multiplied platforms and modes and caused 2 years of slippage. DT's tier lock (T1 -> T3) already guards this.
- (inference) Quests replacing a grind-based system (Portrait) is relevant to DT's use-based growth: give a named goal to a grind.

### Gaps
- Bloodstained cooking and crafting numbers, shard count and the backer count: not stated in the fetched page. The Wikipedia pages were truncated at 100,000 characters. Next: official Bloodstained wiki, Kickstarter page.
- Partner AI behaviour is only secondhand. No primary source found.

## 6. Design statements by Igarashi and production material

### Takeaway
Igarashi's stated principles are: fairness (every boss must be beatable by its designer with only a dagger and no hits), familiar feel over novelty, abilities that expand the map first, and test whether the game is fun to you. No GDC postmortem for SotN or Bloodstained was found.

### Cited Findings
- Bloodstained boss rule: "the developer who creates the boss must beat their own boss without taking a hit and only using a dagger!" Igarashi argues fairness makes players reconsider how to avoid failure and retry. — [Game Developer, Graft, 2019-07-23](https://www.gamedeveloper.com/business/a-i-bloodstained-i-q-a-with-koji-iga-igarashi)
- "how the game felt was more important than challenging new ideas"; "The approach was very similar in terms of just the design" (to SotN); first step was creating map-expanding abilities; hardest challenge in Igavanias is content and replayability. — same source
- Advice to indie developers (Christian Nutt, 2015-03-12): test your own enjoyment, treat outside feedback as vital, step back regularly, communicate your vision, and controls carry the design. He hedged that he was "not really qualified" to advise. — [Game Developer interview](https://www.gamedeveloper.com/design/-i-castlevania-i-s-koji-igarashi-offers-advice-to-today-s-metroidvania-devs)
- Portrait: touch actions "broke the game's action rhythm". Dawn: concern for "pure action gameplay". — Wikipedia pages above (secondhand, interviews cited there)
- Igarashi cites Zelda as an influence (Limited Run interview with Jeremy Parish). — [Nintendo Life via search](https://3dsvc.nintendolife.com/news/2020/09/koji_igarashi_explains_how_zelda_influenced_his_work_on_castlevania_and_bloodstained) (not fetched)

### Inferences
- (inference) The dagger rule becomes a DT test: each boss and each rhythm tier must be clearable with the starting character and no stat advantage, which also supports the Perfect/Good/Poor/Miss tiers.

### Gaps
- No GDC talk postmortem found. The Game Developer article links a free GDC Vault video by Igarashi that I did not locate. Destructoid 2014 was already known and not re-fetched.

## 7. Study resources and legal status

### Takeaway
Use the decompilation and wikis to study intent and formulas only. Nothing should be vendored, copied or redistributed.

### Cited Findings
| Resource | URL | Reveals | Legal status |
|---|---|---|---|
| sotn-decomp | https://github.com/Xeeynamo/sotn-decomp | Matching decompilation for PS1 US, an unreleased JP PS1 build from DXC data, PSP EU and Saturn; about 4,574 commits; wiki on build and internals | Repo is listed AGPL-3.0; contains no game assets and requires the user's own copy of the game. The game code and assets remain Konami's. Study only; never vendor code. Do not use AGPL code in DT. |
| sotn-decomp wiki | https://github.com/Xeeynamo/sotn-decomp/wiki | Page titles include Internals, Debug Module, Glossary, Sound Effects Documentation, Stage graphics; contents not read | Same as above |
| TASVideos SotN resources | https://tasvideos.org/GameResources/PSX/SymphonyOfTheNight | RNG, knockback, glitches, gating breaks, pointers to ZKeene FAQ | Community text; read and cite, do not copy |
| ZKeene's FAQ | GameFAQs / GameSpot (exact URL not confirmed); listed at https://castlevaniaspeedruns.com/SOTN | Damage formulas, stat effects, bestiary (per TASVideos) | Copyrighted by author; read only |
| castlevaniaspeedruns.com | https://castlevaniaspeedruns.com/SOTN | Speedrun mechanics and resource list | Community; read only |
| TCRF | https://tcrf.net/Castlevania:_Symphony_of_the_Night | Unused and debug content (page returned 403 here, so contents unverified) | Wiki text; study only |
| Castlevania Wiki | https://castlevania.fandom.com/wiki/LCK | Item, enemy, stat pages (402 here) | Fandom, CC BY-SA typically (unverified); do not copy art or text |
| StrategyWiki Ecclesia | https://strategywiki.org/wiki/Castlevania:_Order_of_Ecclesia/Villagers | Village quest data | Wiki; read only |

### Gaps
- speedrun.com SotN pages and a standalone damage-formula write-up not located. The SDA knowledge base page (kb.speeddemosarchive.com) returned 403.

## 8. DT translation

### Takeaway
SotN's strongest transferable idea is the unlock loop (ability gates a world, world rewards experimentation). The Igavania sequels show each system can stand alone. DT conflicts with SotN on the following points: five switchable characters versus one hero; per-character spent XP versus a single pooled XP and level; ground-only switching versus free switching; and a vertical decaying world versus a flat map flipped once.

### System map and conflicts
- Five-member switch and combos vs Portrait's two-character Dual Crush: Portrait's pair scales poorly to five; keep the shared-cost idea (cost on use, rewards for alternation).
- Per-character XP as a spent resource vs SotN's automatic levelling: SotN's auto-levelling reduces friction; DT's spend model adds choice at cost of clarity.
- Use-based growth and souls-lite vs Tactical Soul: souls are enemy-derived and collection-driven. DT's enemy affinity tiers 1-5 could be a collection-by-use analogue.
- Rhythm tiers vs SotN's input-exact spells: both ask for precise input, but rhythm input is timed rather than directional.
- Stress (hidden) vs HP/MP-only: no SotN analogue; keep original.
- Grappling and 250 m layers vs SotN's screen-based rooms: avoid SotN's room-streaming glitch classes (shiftline, edge travel) by designing 3D streaming volumes deliberately.

### Borrow / Adapt / Enhance / Avoid
| Verdict | Item | DT system | Tier |
|---|---|---|---|
| Borrow | Ability-gated world: first design step is abilities that expand the map | Progression, Metroidvania gating | T1 |
| Borrow | Boss fairness test (designer beats boss without taking a hit using the weakest tool) | Rhythm combat, bosses | T1.5 |
| Borrow | Controls first: feel over novelty | Plane-locked controller | T1 |
| Adapt | Hidden LCK-style probability (drops, crits) as Signal state or stress effect | Stress, loot | T2 |
| Adapt | Heart-like sub-resource for special moves | Stamina, cooldowns | T1 |
| Adapt | Portrait shared-cost switching: switching and combos cost a shared resource | Five-member switch, combination attacks | T2 |
| Adapt | Idle partner AI that mimics and assists | Inactive members, missions | T2 |
| Adapt | Tactical Soul categories (red/blue/yellow/ability) as ability slots | Souls-lite, use-based growth | T2 |
| Adapt | Quest NPC village (Wygol): rescue unlocks shop stock | Hub, escorts, crafting | T2 |
| Adapt | Bloodstained shards (equip-limited, swappable, MP-cost) | Souls-lite, gear arcs | T2 |
| Enhance | Per-character XP pools plus use-based growth, with a named goal for each grind (Portrait quests) | Progression | T2 |
| Enhance | Vertical Deep-City layers and the Decay Map instead of an inverted castle | World, decay | T2 |
| Enhance | Hidden affordances per character (SotN gates are visible) | Character-specific secrets | T1.5 |
| Avoid | Single-ability gates that wolf-clip style exploits break | Level design, 3D clipping | T1 |
| Avoid | Touch or gimmick inputs that break rhythm (Magic Seals) | Rhythm combat | T1 |
| Avoid | Kickstarter-style stretch-goal scope (co-op, roguelike mode, many ports) | Scope lock | T1 |
| Avoid | Aerial switching, permadeath and combos at T1 | Scope lock | T1 |
| Avoid | Vendoring or porting any decompiled code; AGPL contamination | Legal | T1 |

Session note: this is a research-only task as the assignment requested; the CLAUDE.md "end with something running" rule was not applicable here, and no Godot binary is available in this environment.
