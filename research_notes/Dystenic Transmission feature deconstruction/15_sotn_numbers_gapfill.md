# SotN numbers gap-fill for DT (damage, growth, equipment, familiars, spells, world)

Research date 2026-11-05. About 20 tool calls. **Main source: the sotn-decomp repository**, read from a shallow clone (`git clone --depth 1` of https://github.com/Xeeynamo/sotn-decomp, cloned to `/home/user/xeeynamo/sotn-decomp`, outside the DT repo, so nothing was vendored). Legal status: the repo is AGPL-3.0-or-later and its own files carry `SPDX-License-Identifier: AGPL-3.0-or-later`. The game code and data remain Konami's. These notes record numbers and rules only, for studying design intent. No code is copied, and none may be copied into DT. Source paths below are in that repo and were read at the clone date (US build unless stated). Decompiled names such as `func_800FE044` are community guesses. Where I interpret code I mark it (inference).

Not reached: ZKeene's FAQ (GameFAQs returned 403), TCRF, Fandom. Web searches returned no usable community damage or XP tables. Search snippets are marked as such.

## 1. Damage and defence

### Takeaway
The decompiled code gives a clear damage rule. Attack = weapon ATT plus STR (full STR if ATT <= STR, otherwise half), plus accessory bonuses. Per hit: double on weakness, halve on resist, add a crit effect, then subtract enemy DEF with a floor of 1 and a cap of 9999. Incoming damage is raw enemy attack minus the player's defence. That defence is equipment DEF plus sqrt(CON) - 2. The fan-wiki crit rule (ATT versus LCK) does NOT match the decompiled code.

### Cited Findings
- Player attack: `totalAttack = weaponATT; if (weaponATT <= STR) totalAttack += STR else totalAttack += STR/2; totalAttack += sum(accessory attBonus); clamp 0..999`. Specials: Badelaire adds game hours, Muramasa adds sqrt of a counter, Sword Familiar weapon adds familiar level, Shield Rod adds +5 ATT when the other hand holds a shield, an ATK buff adds +20. — [src/dra/menu.c `CalcAttack`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/menu.c)
- Total stats: `total = base + equipBonus`, but for CON the equipment bonus is multiplied by 8 and for INT by 4 (`statsTotal[1] = base + equip*8`, `statsTotal[2] = base + equip*4`). Equipment bonus is capped at 99 per stat. Relic stat boosts (the four "of Vlad" relics, +10 each) and timed buffs (+20) feed the same equipment bonus. — [src/dra/menu.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/menu.c)
- Per-hit damage to an enemy: (1) if the enemy immune mask covers the element, the hit is flagged immune (no damage). (2) If the absorb mask covers it, the hit heals the enemy. (3) If the enemy "strengths" mask covers it, damage /= 2. (4) If the element is in the enemy's weaknesses, damage *= 2. (5) Roll a crit (below). (6) `damage = damage > enemyDEF ? damage - enemyDEF : 1`. (7) Cap at 9999. A Dragon Helm halves enemy DEF before this step. An attack with no element is treated as the physical-style element 0x20. — [src/dra/5D5BC.c, damage routine near line 880](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Critical hit chance: weapon's `criticalRate` + `sqrt(LCK*2 + (rand & 15)) - 5`, clamped 0..255. A hit crits if that rate exceeds a random byte (so rate/256). Crit chance is forced to 0 in stage ST0 (the prologue-style opening stage). — [src/dra/5D5BC.c `GetEquipProperties`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Crit effect depends on a random "best stat" roll: each of the four base stats gets `+ rand & 0x3F`, and the highest wins. STR wins: damage x2. CON wins: if enemy DEF > damage, add DEF/2, else add damage/2. INT wins: add sqrt(rooms visited). LCK wins: add `rand % LCK + 1` (US) or without the +1 (other builds). The crit happens before DEF subtraction. — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Contradicting reading: a fan-wiki talk page (via search snippet only, not fetched) says a crit does 1x-2x ATT when ATT >= LCK, and ATT to ATT+LCK when ATT < LCK. — [Castlevania Wiki talk: Critical Hit](https://castlevania.fandom.com/wiki/Talk:Critical_Hit/@comment-25598699-20171104135123) (snippet only, unverified). The code above shows no ATT-versus-LCK branch, so I treat the code as authoritative and the wiki as a likely simplification (inference).
- Defence: `totalDefense = sum(hand item DEF) + sum(accessory defBonus) + sqrt(CON) - 2`, +2 for Shield Rod with a shield, +room count / 60 for Walk Armor, +20 for a DEF buff, clamped 0..999. — [src/dra/menu.c `CalcDefense`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/menu.c)
- Damage taken: `amount - defense` normally; stone-type hits use `amount - defense*2`; poison doubles damage taken; "unblockable" kinds do `maxHP/8`; petrified player takes `maxHP/8`. If the result is 0 or less, damage is forced to 1. A Talisman gives a dodge chance when `LCK * count >= rand & 511`. Ballroom Mask reduces some hit types by 1/5 (one) or 1/3 (two). — [src/dra/5D5BC.c, lines ~640-730](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Status effects scale with stats: poison timer -= CON*16 (floor 256), curse timer -= CON*4 (floor 64), Dark Metamorphosis duration += INT*4. Poison halves the player's weapon attack. — [src/dra/5D5BC.c `GetStatusAilmentTimer` and `GetEquipProperties`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Spell and sub-weapon damage: `base + (INT*2 + rand%12)/10` for spells (Mojo Mail x1.5), `base + (stat[2]*2 + rand%12)/10` for sub-weapons (Brilliant Mail +10; Staurolite doubles or triples the Cross-style entries). Note that sub-weapons here read index 2 of the stats array, which is INT. — [src/dra/5D5BC.c `GetSpellDef`, `func_800FE3C4`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- A function doubles a value when the stage is the inverted castle (`func_800FD664`). Its callers were not traced, so what it scales is unverified. — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Knockback severity labels use thresholds on hit size versus max HP (`damage*2 >= maxHP` is the heaviest, `amount*50 >= maxHP` the middle, else light). — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)

### Inferences
- (inference) DT can study the shape: flat subtraction of DEF with a floor of 1 means weak hits stop mattering at a known point. Flat subtraction rewards upgrades but makes grinding and low-damage hits pointless. DT could instead keep every Perfect-tier rhythm hit meaningful with a proportional or floor-percentage rule, chosen to fit the Perfect/Good/Poor/Miss tiers.
- (inference) The "highest stat wins the crit" roll lets each stat flavour crits (double, armour-break, scaling, bonus). DT could let each band member's crit flavour come from their own stat identity.
- (inference) CON mitigates through sqrt, so its defence gain flattens quickly while its effect on status duration is linear (CON*16). DT can borrow "defence stat protects against ailments more than raw damage" for Signal-state resistance.
- (inference) Weakness x2 / resist x1/2 is a coarse two-step table. DT's enemy affinity tiers 1-5 could use finer steps, while keeping the principle that one multiplier step must be readable on screen.

### Gaps
- Enemy tables (HP, DEF, XP value, weaknesses) are generated data (`dra/gen/us/enemydefs.h`, not read). Per-weapon ATT values are in generated `equipment.h` (not read).
- ZKeene's FAQ could not be fetched to cross-check the decompiled rules against the community's reading.

## 2. Growth: XP curve, stat gains, enemy XP scaling

### Takeaway
Total XP for level N is a fixed table running from 100 (L2) to 999,999 (L99). Each level gives +4 or +5 MP, +2 max Hearts, a level-banded HP gain, and a coin flip per attribute (at least two attributes gained on average via a mercy rule). Enemy XP drops by a third for each level the player exceeds the enemy and rises 25% per level for enemies above the player, capped at five levels.

### Cited Findings
- XP thresholds `g_ExpNext[level]` (total XP to reach that level; index 0 and 1 are 0): L2 100, L3 250, L4 450, L5 700, L6 1,000, L7 1,350, L8 1,750, L9 2,200, L10 2,700, L11 3,250, L12 3,850, L13 4,500, L14 5,200, L15 5,950, L16 6,750, L17 7,600, L18 8,500, L19 9,450, L20 10,450, L21 11,700, L22 13,200, L23 15,100, L24 17,500, L25 20,400, L26 23,700, L27 27,200, L28 30,900, L29 35,000, L30 39,500, L31 44,500, L32 50,000, L33 56,000, L34 61,500, L35 68,500, L36 76,000, L37 84,000, L38 92,500, L39 101,500, L40 110,000, L41 120,000, then +10,000 per level to L51 210,000; L52 222,000 then +12,000 per level to L62 330,000... (the table continues in steps of 12,000, 14,000, 16,000, 18,000, 20,000), L99 999,999. Examples: L50 200,000, L60 306,000, L70 414,000 (step 14,000), L80 566,000, L90 738,000, L99 999,999 (the last entry is a cap value, not a step). — [src/config_us.h `g_ExpNext`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/config_us.h). Step sizes are my reading of the table (inference); the numbers listed individually are copied from it.
- Level-up effects: `mpMax += 4 + (rand & 1)`; `hp` and `hpMax += g_LevelHPIncrease[newLevel / 10]` with table `{1, 3, 6, 10, 20, 30, 40, 50, 100, 200}` (so levels 1-9 give +1 HP, 10-19 +3, 20-29 +6, 30-39 +10, 40-49 +20, 50-59 +30, 60-69 +40, 70-79 +50, 80-89 +100, 90-99 +200); `heartsMax += 2`. — [src/dra/5D5BC.c `CheckAndDoLevelUp`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Attribute gains per level: each of the four base stats gets +1 on a coin flip (`rand & 1`), capped at 99. If fewer than 2 stats rose, one random stat gets +1 (a second random roll, so +2 on one stat is possible). Expected gain is about 2.25 stat points per level (inference from the rule: 4 x 0.5 plus the mercy top-up). — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Enemy XP scaling (the "type" argument is the enemy level): if player level > enemy level, XP is multiplied by 2/3 once per level of difference (minimum 1); if the enemy is higher, XP gains +25% per level of difference, with the difference capped at 5. XP total is capped at the L99 value. — [src/dra/5D5BC.c `func_800FE044`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Permanent pick-ups: Life Max Up adds its amount to max HP (capped at 9999; doubled for the alternate playable character in this code) and refills HP; Heart Max Up adds to max Hearts (cap 9999). — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)

### Inferences
- (inference) The curve is smooth and front-loaded: L2-L10 need 2,700 XP total, and each of L60-L99 costs 14k-20k per level. DT's XP is a spent resource, not an automatic level, so DT could keep the "diminishing XP from old enemies" idea (2/3 per level gap) as a way to push exploration, while tracking a per-character pool.
- (inference) The big HP-per-level jumps at L80+ (+100, +200) show the designers back-loaded power. Early levels give little HP, so Life Max Up pick-ups carry the early game. DT can mirror this by making found upgrades matter more than XP early.
- (inference) Random stat gains (coin flips with a mercy floor) smooth luck without choice. DT's spent-XP model replaces randomness with player choice, which raises the balance burden. Each spend needs a defensible marginal value.

### Gaps
- Enemy level and base XP values live in generated enemy data (not read), so no worked "XP per kill versus area" example is given.
- The ellipsis in the XP list above covers steps I did not individually transcribe. Read `g_ExpNext` directly if exact mid-table numbers matter.

## 3. Equipment rules

### Takeaway
There are two hand slots plus five body slots (head, armour, cape, two accessories). Consumable weapons are used up unless a Duplicator accessory is worn. Shield Rod gets bonuses from a shield in the other hand. Two-handed rules and special-weapon inputs were not found in the code read.

### Cited Findings
- Slot layout: equipment index 0 and 1 are the two hands; indices 2-6 are head, armour, cape, accessory 1, accessory 2 (stat loops iterate `equipment[2+i]` for i in 0..4; the item checks name HEAD_SLOT, ARMOR_SLOT, CAPE_SLOT, ACCESSORY_1_SLOT, ACCESSORY_2_SLOT). — [src/dra/menu.c, src/dra/5D5BC.c `CheckEquipmentItemCount`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Inventory stacks cap at 99 of each item. — [src/dra/5D5BC.c `AddToInventory`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Consumable weapons: using one decrements its count; at 0 the hand becomes empty. Wearing a Duplicator stops all decrements. — [src/dra/5D5BC.c `ReduceWeapon`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Shield Rod: +5 ATT and +2 DEF when the other hand holds a shield-category item. A shield-category item with base attack 1 gives 0 attack. — [src/dra/menu.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/menu.c)
- Food and medicine items have 0 attack. — [src/dra/menu.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/menu.c)
- Notable synergy items found in the code: Heart Broach (halves sub-weapon Heart cost with one, divides by 3 with two, minimum 1), Dragon Helm (halves enemy DEF), Mojo Mail (spells x1.5), Brilliant Mail (+10 sub-weapon attack), Ring of Arcana (drop rate), Walk Armor (DEF grows with rooms visited), Medusa and Fire Shields (immunity to stone and fire). — [src/dra/5D5BC.c, src/dra/menu.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/menu.c)
- Sword Familiar can be wielded as a weapon at level 50, has the highest attack at level 99 and does not gain XP in sword form. — [castlevaniadungeon.net SotN list](https://castlevaniadungeon.net/Arsenal/sotnlist.html) (fetched 2026-11-05). The code confirms the sword's ATT adds familiar level.

### Inferences
- (inference) Cheap build-defining modifiers (cost reduction, enemy-DEF shred, damage multipliers on one category) give identity without new systems. DT's gear arc (weaponisation, salvaged armour, engine parts) could use the same pattern of one distinctive modifier per item.
- (inference) Duplicator removing consumable cost is an "economy-bypass" item. DT should decide early whether any item may switch off a cost (stamina, ammo), because it changes balance for every encounter.

### Gaps
- Two-handed rules, how the game decides which hand a weapon uses, and special-weapon inputs (for example the button for special attacks): not found in files read. Needs ZKeene's FAQ or the player-step source (`src/dra/`, not read).

## 4. Familiars

### Takeaway
Familiars level from 1 to 99 with 100 familiar-XP per level. They earn XP only when a kill happens while they are the active familiar, and the gain is the bit length of (enemy XP / familiar level), so XP per kill shrinks quickly as they level.

### Cited Findings
- Familiar level = `exp / 100 + 1`; familiar XP is capped at 9,899 (so level 99). — [src/dra/5D5BC.c `func_800FE044`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Familiar XP gain per kill: `n = enemyBaseXP / familiarLevel`; gain = number of binary digits of n (that is, floor(log2 n) + 1), minimum 1. The HD build subtracts 2 from this gain, so HD builds level familiars more slowly. — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Familiar list in the stats array includes at least Bat, Fairy, Ghost, Demon and Sword (names from the list page; the code has a `FAM_STATS_SWORD` slot). — [castlevaniadungeon.net](https://castlevaniadungeon.net/Arsenal/sotnlist.html)
- Bat familiar: summons more bats at higher levels (no numbers given). — [castlevaniadungeon.net](https://castlevaniadungeon.net/Arsenal/sotnlist.html)
- A steam-forum comment says familiars cap at level 99 on their own table (Bloodstained thread, about a different game, unverified). — search snippet only.

### Inferences
- (inference) Gain of about log2(XP/level) per kill gives a strong diminishing return, so a familiar sits between "levels automatically" and "needs grinding". A use-based DT ability can use the same shape: gains tied to the ratio of challenge to current rank, not to raw kill count.
- (inference) Making familiar XP depend on the summoned familiar being active at the kill gives players a reason to rotate. DT's inactive band members could earn slowly through missions using the same ratio rule.

### Gaps
- What each level changes per familiar (attack, number of bats, ability unlock thresholds) is not in the files read. Only the sword's "ATT + level" is confirmed. Needs the familiar entity code or ZKeene's FAQ.

## 5. Spells and sub-weapons

### Takeaway
Eight spells have fixed inputs and MP costs. Sub-weapon Heart costs are small integers, except the stopwatch at 20, with Heart Broach as a cost reducer. Item-crash details were not decoded.

### Cited Findings
- Spells (MP, input; D = down, U = up, F = forward, B = back; the code shows arrow glyphs): Dark Metamorphosis 10 (back, up-back, up, up-forward, forward); Summon Spirit 5 (back, forward, up, down); Hellfire 15 (up, down, down-forward, forward); Tetra Spirit 20 (up held, up-forward, forward, down-forward, down); Wolf Charge 10 (down, down-forward, forward; wolf form); Soul Steal 50 (back, forward, down-forward, down, down-back, back, forward); Wing Smash 8 (up, up-back, back, down-back, down, down-forward, forward; bat form); Sword Brothers 30 (down, down-forward, forward, up-forward, up held, down). — [src/config_us.h `g_SpellDefs`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/config_us.h). MP values agree with [castlevaniadungeon.net](https://castlevaniadungeon.net/Arsenal/sotnlist.html) (which gives the same costs 10/15/50/5/20/8/10/30). The input strings differ slightly in presentation (the web page lists button requirements and a 2-second hold on Tetra Spirit and Sword Brothers; the code shows "hold" marks on the up direction).
- Casting requires `MP >= cost` and then subtracts the cost. — [src/dra/5D5BC.c `CastSpell`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Sub-weapon table `g_SubwpnDefs` (fields: attack, Heart cost, ...). Enum order: Dagger, Axe, Holy Water, Cross, Bible, Stopwatch, Rebound Stone, Vibhuti, Agunea. Rows in the table: Dagger attack 5 cost 1; Axe 10 / 4; Holy Water 1 / 3; row 4 (Cross) 5 / 100; Bible 8 / 5; Stopwatch 0 / 20; Rebound Stone 8 / 2; Vibhuti 8 / 3; Agunea 10 / 5; three further rows (15/10, 8/1, 40/5) follow, likely the crash variants referenced by each row's `crashId` field (inference, mapping not traced). The Cross cost of 100 looks odd and may reflect field meaning or ordering (unverified); do not rely on it. — [src/config_us.h `g_SubwpnDefs`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/config_us.h), [include/game.h enum](https://github.com/Xeeynamo/sotn-decomp/blob/master/include/game.h)
- Heart Broach halves Heart cost (one) or divides by 3 (two), minimum 1. Hearts are spent only if the player has enough. — [src/dra/5D5BC.c `func_800FE3C4`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Staurolite doubles (one) or triples (two) attack for the sub-weapon entries 4 and 12 on the US build (the HD/PSP builds apply it to entry 4 only). — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)

### Inferences
- (inference) Spell costs span 5 to 50 MP, a 10x range tied to power and input difficulty (the 50 MP spell has the longest input). DT can price rhythm-input specials by sequence length and accuracy tier.
- (inference) Cheap sub-weapons (1-5 Hearts) fire often while the stopwatch costs 20, so cost marks tool power. DT's stamina or cooldown costs can follow the same "rarely used effects cost much more" curve.

### Gaps
- Crash (item-crash) trigger input, heart cost per crash and effects not decoded; Hearts for each crash entry not mapped to a named crash.
- Spell damage base values sit in `g_SpellDefs` columns that I did not decode into named fields.

## 6. World numbers: map percentages, Librarian stock, drops, boss order

### Takeaway
The Librarian's shop list and prices are recoverable from the decompilation, including an "unlock level" per item that rises with castle progress. Drops use a byte roll with a small LCK offset. Map-completion percentages and boss order were not found.

### Cited Findings
- Librarian shop (US build, `price` in gold; the number after the category is an unlock level, "related to the number of things accomplished in the castle", where beating the game unlocks all): Potion 800 (unlock 0), High Potion 2,000 (3), Elixir 8,000 (5), Manna Prism 4,000 (3), Antivenom 200, Uncurse 200, Hammer 200, Magic Missile 300, Bwaka Knife 400, Boomerang 500 (1), Javelin 800 (3), Fire Boomerang 1,000 (4), Shuriken 2,400 (4), Cross Shuriken 5,000 (6), Buffalo Star 8,000 (7), Flame Star 15,000 (7), Library Card 500, Meal Ticket 2,000 (8), Saber 1,500, Mace 2,000, Damascus Sword 4,000, Firebrand / Icebrand / Thunderbrand 10,000 each (5), Harper 12,000 (5), Leather Shield 400, Iron Shield 3,980, Velvet Hat 400, Leather Hat 1,000, Circlet 4,000, Silver Crown 12,000 (5), Iron Cuirass 1,500, Steel Cuirass 4,000, Diamond Plate 12,000, Reverse Cloak 2,000, Elven Cloak 3,000, Joseph's Cloak 30,000, Medal 3,000, Ring of Pales 4,000 (1), Gauntlet 8,000 (4), Duplicator 500,000 (8), Castle Map 103, Magic Scrolls 1-5 at 500 / 1,500 / 5,000 / 8,000 / 15,000. A relic entry (Jewel of Open) costs 500 and a final special entry 1,000,000 (not shown in the shop). — [src/st/lib/e_shop.c `D_us_8018134C`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/st/lib/e_shop.c). The enum also lists nine "tactics" document slots for bosses (Dracula, Olrox, Doppleganger10, Granfaloon, Minotaur/Werewolf, Scylla, Slogra/Gaibon, Hippogryph, Beelzebub, Succubus, Karasuman, Trevor/Grant/Sypha, Death, Cerberus, Richter, Medusa, The Creature, Lesser Demon, Doppleganger40, Akmodan II, Darkwing Bat, Galamoth, Maria, Shaft, Lord Dracula) as `SHOP_TACTICS` ids; I read them as boss-strategy document entries (inference).
- Drop structure: a byte roll `rnd = rand & 0xFF`, minus `(LCK + rand & 0x1F) / 20`, minus `rareRate * RingOfArcanaCount`. If `rnd < rareRate` the rare drop is given (probability about rareRate/256). Otherwise `rnd -= rareRate`, subtract the Ring of Arcana and LCK terms again, and if `rnd < uncommonRate` the uncommon drop is given. Else a "common" item index comes from `rand % 28` (+1 each if there is no rare or no uncommon drop, + Ring count). So each enemy has two rates (rare, uncommon) and a shared common table. LCK 99 only shifts the roll by about 5 out of 256. — [src/dra/5D5BC.c `func_800FF494`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c). Contradicting reading: a fan-wiki summary says drop rate = base x LCK / 100 capped at 50% (common) and 25% (rare). — [Castlevania Wiki: LCK](https://castlevania.fandom.com/wiki/LCK) (search snippet only, page blocked; unverified). The code supports a much weaker LCK effect.
- A separate helper computes `x + x*LCK/128` for a nonzero input (use not traced; plausibly a money or reward modifier) (inference). — [src/dra/5D5BC.c `func_800FF460`](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)
- Inverted castle exists as a stage flag (`STAGE_INVERTEDCASTLE_FLAG`). — [src/dra/5D5BC.c](https://github.com/Xeeynamo/sotn-decomp/blob/master/src/dra/5D5BC.c)

### Inferences
- (inference) Gating shop stock by a progress counter (unlock level) is a cheap way to make a hub shop grow with exploration. DT's hub or scrap-trader could unlock stock by story beats or tool knowledge instead of a number of rooms.
- (inference) The very high-priced items (Duplicator 500,000, Joseph's Cloak 30,000) work as money sinks and long-term goals. DT's spent-XP economy needs equivalent sinks so XP does not pile up unspent.
- (inference) A luck-style stat that only moves a drop roll by about 5/256 is nearly invisible. If DT adds a luck-like effect, it should have a visible tell (a Signal state or body cue) so the player can feel it.

### Gaps
- Map-completion percentages (normal castle, inverted castle, the 200.6% total), typical boss order, and per-enemy drop values: not found. The decompiled code read did not expose them, and no web source was reachable. Next: ZKeene's FAQ, castlevaniadungeon.net map pages, or `src/dra` map-percent code (search for the room-count routines).

## Borrow / Adapt / Enhance / Avoid

| Verdict | Item | DT system | Tier |
|---|---|---|---|
| Borrow | Floor-of-1 minimum damage and a hard cap, so extremes stay bounded | Combat, stats | T1 |
| Adapt | Stat-weighted crit flavour (highest roll picks double / armour-break / bonus), tied to each member's identity | Rhythm combat, per-character stats | T2 |
| Adapt | Enemy XP shrinking by a fixed fraction per level gap (2/3) to steer players onward, applied per character pool | Spent-XP economy | T2 |
| Adapt | Level-banded HP growth with big late jumps, replaced by purchasable steps | Progression | T2 |
| Adapt | Familiar XP of about log2(enemy XP / rank) as a diminishing, use-based rule | Use-based ability growth, inactive members | T2 |
| Adapt | Stat that shortens ailment duration (CON x16) to resist Signal states | Signal states, stress | T1.5 |
| Adapt | Shop stock unlocked by a progress counter | Hub, gear arcs | T2 |
| Adapt | One distinctive modifier per gear item (cost halving, enemy-DEF shred, spell multiplier) | Gear arcs | T1.5 |
| Enhance | Replace random stat coin-flips with chosen spends, each with a legible marginal value | Progression | T2 |
| Enhance | Make luck-like effects visible through Signal state or body tells | Stress, loot | T2 |
| Enhance | Finer affinity steps (tiers 1-5) instead of only x2 and x1/2 | Enemy affinity tiers | T2 |
| Avoid | Items that remove a core cost entirely (Duplicator-style) unless costed by a large sink | Economy, stamina | T2 |
| Avoid | Flat DEF subtraction that makes weak hits worthless, which would undercut Poor and Good rhythm tiers | Rhythm combat | T1 |
| Avoid | Copying SotN numbers, tables or names (the XP curve, shop list, spell inputs); rebuild originals from the principles | Legal, originality | T1 |
| Avoid | Vendoring or porting decompiled code (AGPL-3.0); the clone stays outside the DT repo | Legal | T1 |
