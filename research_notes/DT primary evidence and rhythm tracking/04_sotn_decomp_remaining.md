# SotN decomp: remaining system gaps (round 2, primary evidence)

Source and method. Local read-only clone `/home/user/xeeynamo/sotn-decomp` at commit `b32d7749d98e` (AGPL-3.0, study only, nothing copied). All findings are **[P1]** code reading. Caveat from the scope file: function and variable names are community guesses, and many are still `func_800F....` placeholders, so I describe behaviour, not names. Paths below are relative to the clone root, written `file:line`. Only short constants are quoted. The clone has no `gen/` folders (extracted disc data is absent), which limits the enemy, equipment and Richter-table findings. Round 1 notes that this extends: `03_sotn_systems.md`, `15_sotn_numbers_gapfill.md`. No web sources were used this round, and I did not re-fetch any fan wiki, so "wiki reading" below means the round 1 notes or the commonly repeated claim, flagged each time.

Each finding ends with a line "DT principle" for an original rebuild.

---

## 1. Map and exploration: completion, reveal flags, teleporters, save rooms

### Takeaway
The map is two 64x64 grids of 2-bit cells (one per castle) in one 0x800-byte array. A cell is marked visited the first time the player stands in it, and each new cell adds 1 to a single room counter that covers both castles. The completion percentage is that counter times 100 over a hard-coded 942, and it is only computed for the save-file title. The castle flip is a position-triggered teleport, and warp rooms are persistent bit flags.

### Cited Findings
- **[P1] Storage format.** `g_CastleMap` is a 0x800-byte array (`include/game.h:2170`). Each map cell takes 2 bits and a byte holds 4 cells; a row is 16 bytes and there are 64 rows, so one castle is 0x400 bytes. The inverted castle uses the second half (`idx += 0x400`). — `src/dra/5087C.c:895-916`, `src/dra/5087C.c:918-949`
- **[P1] Two bit meanings per cell.** The redraw code tests the low bit of each pair (mask `0x55`) as "explored" and the high bit (mask `0xAA`) as "revealed but not visited" and paints the two states with different colours. The function that runs when the Librarian's castle map is bought sets only the `0xAA` bit for a hard-coded bitmap of cells. — `src/dra/5087C.c:938-946`, `src/dra/5087C.c:986-1030`
- **[P1] Visit rule.** Every tick the game computes the player's map cell from tilemap origin plus player position (`>> 8`, so one map cell is 256 px). If the explored bit is not set it sets it, increments `g_RoomCount`, repaints that cell and checks for a secret passage there. It is skipped when the map-reveal permission flag is off and in stage ST0 (the prologue). — `src/dra/5087C.c:895-916`
- **[P1] Counting unit.** `g_RoomCount` counts newly visited map cells, not "rooms" as a level designer would count them. A large room spanning several map cells adds one per cell entered. It is never decremented and is one counter for both castles. — `src/dra/5087C.c:911`, `include/game.h:2148`
- **[P1] Completion percentage.** The only percentage is `g_RoomCount * 100 / 942`, written into the memory-card save title. The 942 is a local constant. The pause-menu status screen prints the raw count under the label "ROOMS" (no percent). The counter is saved in a 16-bit field. — `src/save_mgr.h:506`, `src/save_mgr.h:582`, `src/dra/menu.c:1337`, `src/config_us.h` (`g_MenuStr` entry "ROOMS"), `include/game.h:1256`
- **Round 1 vs code on 200.6%.** Round 1 recorded "200.6%" as a common but unverified figure. The code gives no percent cap and no per-castle split, so 200.6% is consistent with one shared counter over a 942 denominator (200.6% of 942 is about 1,890 cells for the two castles together). The clone cannot confirm the 1,890 total because room and map data are generated assets. The 942 denominator is therefore best read as the size of one castle, and the second castle's cells push the figure past 100%. That is an inference, **not** confirmed.
- **[P1] Inverted castle map.** It is not separate data: the same 64x64 grid is drawn mirrored (`0x3F - x`, `0x3F - y`) and stored in the second half of the array. — `src/dra/5087C.c:752-755`, `src/dra/5087C.c:860-862`
- **[P1] Secret passages on the map.** A table of (tile x, tile y, direction, flag id, inverted flag id) entries is drawn on the map only when the matching persistent castle flag is set or when the player's cell matches. So a secret wall becomes visible on the map only after the player triggers it. — `src/dra/5087C.c:856-893`
- **[P1] Persistent world flags.** `g_CastleFlags` is a 0x300-byte array of one-byte flags (216 named entries) described in the header as state that must persist across rooms and stages: secret walls, shortcuts, elevators, boss defeats, cutscenes, warp unlocks, and the inverted castle unlock. — `include/castle_flags.h:1-5`, entries such as `NO1_SECRET_WALL_BROKEN` (line 15), `SHAFT_ORB_DEFEATED` (line 105), `INVERTED_CASTLE_UNLOCKED` (used at `src/dra/game_handlers.c:435`)
- **[P1] Warp rooms.** Which warp destinations are open is stored as bits inside two bytes (`WRP_UNLOCKS` and `RWRP_UNLOCKS`), one bit per destination (five per castle half). — `include/castle_flags.h:157-168`
- **[P1] Room-to-room and stage-to-stage teleports.** A `RoomTeleport` table gives, per teleporting door, a destination x and y, a room id and a stage id. A room whose tileset field is `0xFF` is treated as a pointer into that table. Boss arenas use a separate `RoomBossTeleport` table keyed by coordinates. — `include/game.h:808-824`, `src/dra/5087C.c:40-60`, `src/dra/5087C.c:182-230`, `src/dra/5087C.c:286-330`
- **[P1] Castle flip.** The jump between castles is not an item or a menu. The code checks whether the player is in the "press up" stand pose and within 4 units of one hard-coded world position in each castle's top stage; if so it starts the teleport player step. — `src/dra/692E8.c:586-612`, caller `src/dra/692E8.c:661-664`
- **[P1] Save rooms.** I did not find the save-room logic. What I found: save-room graphics are loaded as shared assets (`src/dra/d_37d8.c:105`, `src/dra/d_2217C.c:10-17`), and the save payload itself is documented below. Healing at a save room, the save prompt and the room trigger are not located. See Gaps.
- **[P1] Library Card.** The Library Card item calls the teleport routine (`func_8010E42C(0)`) only while standing, walking or crouching, then uses up one item. — `src/dra/6E42C.c:~505-512`

### Inferences
- (inference) Using one coordinate grid for both map storage and room lookup means the "map" and the "world" are the same data. A room is found by its (x, y) map cell (`SetNextRoomToLoad`, `src/dra/5087C.c:286-330`), so the map UI can be a cheap view over visited flags rather than a second system.
- (inference) Marking a cell visited when the player stands in it, not when a room loads, makes the map honest about where the player actually went.

**DT principle:** Keep one authoritative grid of room cells in the Room Manager. Store per cell a small bitfield (unseen, glimpsed or revealed by a map item, visited), and derive the map screen, the completion figure and reveal items from it. Count completion per region and show it to the player, since SotN's single shared counter with a hidden denominator is opaque.

### Gaps
- Save-room entity, HP and MP restore, and save prompt flow: not located in the files read. Needs a read of one stage's entity table (for example `src/st/no3/e_init.c`) and the `E_SAVE_GAME_POPUP` handler in `src/st/chi/en_misc.c:24`.
- Total number of map cells per castle (and so the true 200.6% maximum): generated data, not in the clone.
- Whether the displayed in-game map screen also shows a percentage: I found none in the files read (only the save title).

---

## 2. Equipment rules: two-handers, shields, stat application, special weapons, item crashes

### Takeaway
A two-handed weapon is stored in both hand slots at once, so equip and unequip logic keeps the pair in sync. Attack is a small formula built from weapon attack, STR, accessory bonuses and a handful of item-specific terms, capped at 999. A weapon's "special move" is a quarter-circle-forward input tracked by a per-frame state machine, costing MP from a hidden equipment entry. Item crashes belong to Richter's code, not Alucard's.

### Cited Findings
- **[P1] Two-handed weapons.** Items have a category, and one category is "two-hand". Equipping one in a hand writes the same item id into the other hand's slot, and removing it, or equipping something else, clears the other slot. Items displaced from the other hand go back to the inventory (unless that item was itself the two-hander). — `src/dra/menu.c:3146-3155`, `src/dra/menu.c:3236-3248`, enum `include/game.h:1023`
- **Round 1 gap closed.** Round 1 (`15_sotn_numbers_gapfill.md` section 3) said two-handed rules were not found. They are: there is no separate "two-hand lock" flag; the rule is the duplicate id in both slots.
- **[P1] Attack formula (per hand).** Start from the weapon's attack. If that is at most STR, add STR; otherwise add STR/2. Then add the sum of the five accessory slots' attack bonuses. Special cases follow: Badelaire adds play-time hours, Muramasa adds the square root of a counter, Shield Rod adds 5 when the other hand holds a shield-category item, Sword Familiar adds the sword familiar's level, and an ATK buff adds 20. Floor 0, cap 999. Food, medicine, and shields with base attack 1 return 0. — `src/dra/menu.c:262-320`
- **[P1] Defense formula.** Sum of both hands' defence (Shield Rod gets +2 if the other hand is a shield), accessory defence bonuses, plus `sqrt(CON) - 2`, plus Walk Armor's `rooms / 60`, plus 20 under a DEF buff. Floor 0, cap 999. Elemental weakness, resist, immunity and absorb masks are OR-ed together from accessories, special items (Medusa Shield stone, Fire Shield fire, Heart of Vlad curse) and timed resist buffs. — `src/dra/menu.c:334-410`
- **[P1] Stat application order.** Accessory stat bonuses from the five body slots (stored as signed bytes) are summed per stat. Sunstone or Moonstone adds 5 to every stat per stone, chosen by `playTimeHours % 24` being 6 to 17 (sun) or otherwise (moon). Timed buffs add 20 to STR, INT or LCK, and the four Vlad relics add 10 each when active. Equip bonuses cap at 99 per stat. Total stat is base plus equip, except CON's equip bonus is multiplied by 8 and INT's by 4 before adding. — `src/dra/menu.c:176-260`
- **Possible wiki divergence (flagged).** Sun and Moon stones read the **play-time timer**, not a world clock or real-world time. If a wiki says "night" or "day" it is describing play hours modulo 24, which drifts from anything the player sees. I did not fetch a wiki page this round, so the wiki's exact wording is unverified.
- **[P1] Critical hit chance.** An equipped weapon's crit rate gets `sqrt(2*LCK + rand&15) - 5`, clamped 0..255, and is forced to 0 in stage ST0. — `src/dra/5D5BC.c:530-549`
- **[P1] Poison and weapons.** Poison halves the attack value. — `src/dra/5D5BC.c:556-558`
- **[P1] Which button attacks.** Square is the left-hand attack and Circle the right-hand attack (tapped). Pressing both fires a combined "dual" move if one is configured and the MP check passes. A shield held in a hand turns a held Square or Circle into an attack press, which is how shield bashes work. — `src/dra/6E42C.c:~389-440`
- **[P1] Special weapon moves.** Each weapon entry names a special move (another hidden equipment entry). It fires when the quarter-circle-forward combo state reads complete (down, down-forward, forward), only while grounded, and only if the chain limit allows and `HasEnoughMp(mpUsage)` passes; the MP cost is that hidden entry's `mpUsage`, subtracted when the attack entity spawns. A second pattern (back, forward) unlocks a weapon's alternate move. Two special cases are hard-coded: the Combat Knife and the Sword of Dawn (needs standing on solid ground). — `src/dra/6E42C.c:~440-520`, `src/dra/6E42C.c:~555-560`, `src/dra/704D0.c:48-170`
- **[P1] Chain limits.** A thrown or deployed weapon type has a cap on simultaneous live instances (for example Buffalo Star three per hand). Sub-weapons carry the same idea in a `chainLimit` field. — `src/dra/6E42C.c:~326-370`, `include/game.h:1518-1533`
- **[P1] Consumable weapons.** Each use calls `ReduceWeapon(hand)`, and a dual move reduces the other hand too. — `src/dra/6E42C.c:~558-566`
- **[P1] Sub-weapon (Up + attack) rules.** Use needs Up held plus a Square or Circle tap. It fails, in order, if Up is not held, no sub-weapon is held, the Stopwatch is already running, too many instances of that sub-weapon are alive, or hearts are short. Hearts are deducted only at the last check. Entering the attack timer sets a 4-frame lock. — `src/dra/6E42C.c:266-310`
- **[P1] Sub-weapon cost and damage details.** Heart Broach halves cost with one worn and divides by 3 with two (minimum 1). Sub-weapon damage adds Brilliant Mail +10, Staurolite double or triple (entries 4 and 12 on the US build), and `(2*INT + rand%12) / 10`. — `src/dra/5D5BC.c:482-528` (this confirms round 1's Heart Broach and Staurolite points; the stat in the damage term is index 2, which `Stats` names INT, `include/game.h:1045`)
- **[P1] Agunea sustain cost.** While Up plus Square stay held and Agunea is attached to an enemy, it spends 5 hearts (reduced by Heart Broach, minimum 1) every 12 ticks and stops when hearts run out. — `src/dra/84B88.c:2000-2030`
- **[P1] Item crashes are Richter's.** The crash trigger exists only in the Richter player code: Triangle, with Up not required, while grounded and not otherwise busy, calls `RicDoCrash()`. It reads the held sub-weapon's `crashId` to find a second table row (the crash's own attack and heart cost) and spends those hearts. Holy Water, Stopwatch (blocked while time is already stopped), Cross, Axe, Dagger, Rebound Stone, Vibhuti, Agunea and Bible each get their own player step. — `src/ric/pl_steps.c:334-340`, `src/ric/pl_setstep.c:322-420`, `src/ric/pl_blueprints.c:107-132`
- **[P1] Alucard.** Alucard's sub-weapon table has a `crashId` field and a cross-crash entity exists in the Alucard code, but I found no code in `src/dra/` that sets the player status flag the HUD uses to flash the heart counter ("enough hearts for a crash") or that triggers a crash. Treat Alucard crashes as not found, not as absent. — `src/dra/5F60C.c:1067-1074`, `src/dra/84B88.c:811-830`

### Inferences
- (inference) The duplicate-id trick means DT can model two-handers as "occupies both grip slots" without special-casing every system; the cost is every equip path must remember to clear the twin.
- (inference) Round 1's oddity about the Cross costing 100 hearts in Alucard's table (`src/config_us.h` sub-weapon row 4) stays unresolved. Richter's real table is a generated file not in the clone, so crash costs cannot be read this round. Do not quote Cross or crash heart costs.

**DT principle:** Treat equipment as modifiers applied in a fixed, documented order (base, stat scaling, slot bonuses, conditional bonuses, cap), recomputed from scratch on every change rather than patched incrementally. For the band, a gear's "hand occupancy" is an explicit slot rule the inventory UI shows. For special inputs, price them by input effort and a resource (SotN: MP for specials, hearts for sub-weapons), not by free repetition.

### Gaps
- Per-weapon attack values and the special-move table: generated `equipment.h`, absent.
- Richter crash heart costs and damage: generated `src/ric/gen/subweapons.h`, absent.
- Exact meaning of the `0x55`/`0xAA`-style masks on the two-handed state beyond the category: not needed.

---

## 3. Familiars: what levels change

### Takeaway
Familiar level is split into ten bands of ten levels (level / 10 indexes an ability table), and each familiar's table changes its own timing, reach or ability unlocks. Familiar damage is an ability-row attack multiplied by 1 to 5 as level rises. The Sword familiar's level 50 grants the Sword Familiar weapon item once.

### Cited Findings
- **[P1] Damage scaling (all familiars using spell rows).** `attack = spellRowAttack * (level * 4 / 95 + 1)` with integer division, so the multiplier is x1 below level 24, x2 from 24, x3 from 48, x4 from 72, x5 from 95. — `src/dra/7879C.c:1536-1555`
- **[P1] Lookup rule.** Every familiar reads `level / 10` as an index into a 10-row table, so behaviour changes in steps at levels 10, 20, ... 90. — e.g. `src/servant/tt_000/bat.c:116,135,643,682,773`
- **[P1] Bat.** Table columns (in order): delay between attacks in frames, angle step, extra bats, minimum enemy HP to attack, whether it makes "bad" (low-value) attacks. Rows run from delay 90, 0 extra bats at levels 0-9 to delay 30, 3 extra bats at levels 80-99; extra bats go 0, 0, 1, 1, 2, 2, 2, 3, 3, 3; the minimum enemy HP column rises from 64 to 352; bad attacks are allowed only at levels 0-19. — `src/servant/tt_000/bat.c:65-69`, struct `src/servant/tt_000/bat.h:5-11`. The columns' meaning is from the struct field names (community guesses).
- **[P1] Ghost.** Attack delay falls from 120 frames (levels 0-19) to 60 (levels 80-99); the ability used switches to a soul-steal variant from level 70; bad attacks are allowed only to level 39. — `src/servant/tt_001/ghost.c:27-38`, struct `src/servant/tt_001/ghost.h:5-9`
- **[P1] Faerie.** Seven per-band values: a timer between actions (30 down to 0) and chances (out of 255) for using a Life Apple (always 255), Hammer, uncursing, antivenom, resist items and healing. Hammer chance goes 0x20 to 0xC0, uncurse 0x10 to 0x60, antivenom 0x10 to 0x60, resist 0x10 to 0x80, heal 0xC0 to 0xFF. — `src/servant/tt_002/faerie.c:45-56`, struct `src/servant/tt_002/faerie.h:36-50`
- **[P1] Faerie extras by level.** Level under 5 blocks its special behaviour; level 50 or more is required for one routine and below 90 it triggers only one time in eight; the PSP branch uses different thresholds (level 16 and 10). — `src/servant/tt_002/faerie.c:1520-1560`
- **[P1] Demon.** Four values per band: action timer 60 down to 15, a minimum enemy HP gate (0x80 down to 0x10), a bad-attack flag (levels 0-29 only) and a max enemy axis distance (0x40 up to 0x80). A separate attack-selector table adds more attack types as level rises: one at levels 0-9, up to five at levels 80-99. — `src/servant/tt_003/demon_data.h:3-19`
- **[P1] Sword.** The level 50 check gives the player the Sword Familiar **weapon** item (once, guarded by a castle flag), and a level-90 slot is reserved in code. — `src/servant/tt_004/sword.c:644-662`
- **Round 1 upgrade.** Round 1 took "Sword Familiar wieldable at level 50" from castlevaniadungeon.net [S]. It is now **[P1]**: the grant is one-time, flagged in `g_CastleFlags`, and is not a continuous unlock.
- **[P1] Familiar spell rows.** Familiar attacks use rows 15 to 26 of the spell table (`FAM_ABILITY_*`), the same table as Alucard's spells with blank names. — `include/game.h:1108-1118`, `src/config_us.h:143-175`
- **[P1] Nose Devil, Pixie** exist as JP-only familiars (`FAM_STATS_YOUSEI`, `FAM_STATS_NOSE_DEMON`); their tables exist in `src/servant/tt_005`, `tt_006` but I did not read them. — `include/game.h:1131-1132`

### Inferences
- (inference) The design is a single scalar (level) mapped through a lookup table to several behaviours at once. Because ten-level steps are legible, a player feels discrete upgrades rather than a smooth number.

**DT principle:** For DT's use-based growth, define each ability's growth as a small table of discrete bands where each band changes one or two readable behaviours (rate, reach, a new option), plus a separate smooth damage multiplier. Do not make every stat creep every level.

### Gaps
- Pixie and Nose Devil tables and whether the US build uses them.
- The bat's actual hit damage per level: depends on spell row 15 (attack 10, from the table) times the multiplier above, but I did not trace the bat attack entity.

---

## 4. Enemies: stat structure, location, damage, drops

### Takeaway
Enemy stats are rows of a 40-byte struct kept in generated data that the clone lacks, so I can describe structure and the code that reads it, not the values. Damage, weakness, resistance, critical hits and drop selection are all in readable code.

### Cited Findings
- **[P1] Structure.** One `EnemyDef` row per enemy holds: name, HP, ATT, attack element, DEF, hitbox state, weaknesses, strengths, immunes, absorbs (each a 16-bit element mask), level, XP, rare item id, uncommon item id, rare and uncommon drop rates, hitbox width and height, and a flags word. — `include/game.h:1496-1516` (struct defined here)
- **[P1] Where the values live.** `g_EnemyDefs` is filled by `#include "dra/gen/us/enemydefs.h"` (generated from the disc image at build time), so the numbers are not in the repository snapshot. — `src/config_us.h:207-209`
- **[P1] Entity linkage.** An enemy entity stores an `enemyId`; damage code copies `g_EnemyDefs[enemyId]` and reads it. — `src/dra/5D5BC.c:870-884`
- **[P1] Damage to an enemy.** Order: Dragon Helm halves the enemy's DEF; element defaults to 0x20 when none set; if the attack's element is wholly covered by the enemy's immunity mask, damage is flagged immune (no damage); if covered by the absorb mask it heals; if covered by strengths, damage is halved; if any bit hits weaknesses, damage is doubled; then a critical roll (below); then DEF is subtracted (minimum 1) and the result is capped at 9999. — `src/dra/5D5BC.c:870-975`
- **[P1] Critical hits.** A hit crits if the attack's crit rate (stored per attacking entity) beats a random byte. The bonus depends on the highest of four noisy stat rolls (`rand&0x3F` plus each base stat): STR doubles damage, CON adds half of enemy DEF (or half of damage if DEF is lower), INT adds the square root of the room counter, LCK adds a random amount up to LCK. — `src/dra/5D5BC.c:925-960`
- **[P1] Damage to the player.** Order: weakness doubles, resistance halves, immunity zeroes (but stone immunity only strips the petrify effect), absorb heals instead; Ballroom Mask reduces some damage kinds by 1/5 or 1/3; damage taken is the attack value minus the DEF stat (stone attacks subtract twice DEF; a few damage kinds are flat 1/8 of max HP); poison doubles damage taken; Talisman gives an LCK-based dodge chance; damage is never below 1 once it connects unless the DEF >= 100 "block" rule applies; Fury Plate sets the DEF buff timer to 0x200 on a hit and Blood Cloak gives hearts. — `src/dra/5D5BC.c:593-755`
- **[P1] Drop choice.** One random byte, reduced by `(LCK + rand&31) / 20`, is compared against the enemy's rare-drop rate; a rare drop needs byte below that rate. Ring of Arcana subtracts `rate * ringCount` from the roll. If not rare, the same roll (reduced again by LCK) is compared against the uncommon rate. Otherwise the result is a generic pickup chosen from about 28 slots (heart and money types), with the slots for an absent rare or uncommon entry shifted. — `src/dra/5D5BC.c:989-1030`, called at `src/st/collision.h:596`
- **[P1] Stage drop lists.** Each stage has a small `PrizeDrops` list of generic pickups (heart vessel, life vessel, and so on) — `src/st/no3/d_prize_drops.c:4-9`
- **[P1] Per-room kill persistence.** Room layout entities carry an index; killing or collecting one sets a bit in a 32-bit-word bitfield, so it does not respawn while you stay in the room. The bitfield is zeroed on room change, so enemies return when you re-enter. — `src/st/st_common.h:61-66`, `src/st/create_entity.h:203-209`, `src/dra/5087C.c:1057-1058`, `src/dra/5087C.c:1804-1806`
- **[P1] XP and drops are per-row data.** The XP value and level used in the XP formula in round 1 live in the same missing table. — `include/game.h:1510-1511`

### Inferences
- (inference) Elements as bitmasks in four separate fields (weak, strong, immune, absorb) is the whole enemy affinity system. It is cheap, readable in a spreadsheet and extendable. DT's affinity tiers 1-5 per character could replace the bit tests with a small integer per element.

**DT principle:** Author enemies as rows in a data table (Godot `Resource` or CSV) with explicit fields for the four affinity relations, drop rates and XP, and run one shared damage function. Keep the damage order (immune, absorb, resist, weak, crit, flat defense, minimum 1, cap) documented so balance changes stay predictable.

### Gaps
- All enemy values (HP, ATT, DEF, XP, weakness masks, drop ids): generated asset data not in the clone.
- The bit assignments of the element masks beyond names (`ELEMENT_*`, `include/game.h:~300-325`) were not needed.

---

## 5. Architecture worth studying: stages and rooms, entities, status timers, save layout

### Takeaway
A stage is an overlay holding a list of rooms; each room is a rectangle on the shared map grid that points to a tile layout, tileset, object graphics and an entity layout. Entities live in one fixed 256-slot pool, created from sorted layout lists as the camera scrolls. Timers are small integer arrays counted down once per tick. The save file is a flat memory-card struct of status, settings, castle flags and map bits.

### Cited Findings
- **Room lookup.** A `RoomHeader` is a rectangle in map-cell units (left, top, right, bottom) plus four ids: tile layout, tileset, object graphics, object layout. `SetNextRoomToLoad(x, y)` scans the list for the room containing the player's map cell, with an end marker where `left == 0x40`. — **[P1]** `include/game.h:790-807`, `src/dra/5087C.c:286-330`
- **[P1] Room change sequence.** On a transition the engine fades out, stops or restarts music from the stage's table, loads the new tile layer, queues graphics loads, recomputes the tilemap origin and size from the neighbouring header, shifts every entity flagged "carries over" by the position difference, then fades in. — `src/dra/5087C.c:1707-1830`
- **[P1] Engine states.** A small top-level state machine (init, normal, menu, a transition state, map, and a few others) dispatches per tick, and the map screen is just a state that keeps entities updating. — `include/game.h:532-539`, `src/dra/5087C.c:1690-1704`
- **[P1] Entity pool.** There are 256 `Entity` slots total, slot 0 is the player, stage entities start at slot 64 (`STAGE_ENTITY_START`), and a layout entry can pin an entity to a specific slot within that range via its index. Each entity holds an id, a function pointer (`pfnUpdate`) looked up from an id-to-function table, position, params, hitbox and flags. — `include/game.h:2206-2208`, `src/st/create_entity.h:33-45`, `src/st/create_entity.h:61-68`
- **[P1] Layout spawning.** Each room's entity layout exists as two sorted lists (one by X, one by Y). As the camera scrolls, the engine walks the list forward or backward and creates entities that enter a margin around the screen (64 px behind, 320 px ahead horizontally; 288 ahead and 64 behind vertically), so off-screen entities do not exist yet. A room can also pick one of several layouts at random from weights. — `src/st/create_entity.h:404-480`
- **[P1] Familiars and the player are entities too.** The player is `g_Entities[0]` with a step state machine; sub-weapons, spells and effects are entities spawned by a "factory" with a blueprint number. — `src/dra/692E8.c:~640-700`, `src/dra/6E42C.c:294-296`
- **[P1] Player timers.** A 16-entry signed timer array counts down once per player update; named slots include poison, curse, hit effect, invincibility, sub-weapon use lock and spell use lock. When one reaches zero a per-slot clean-up runs (restore palette, re-enable afterimage, and so on). — `include/game.h:1911-1926`, `src/dra/692E8.c:700-790`
- **[P1] Status ailment durations.** `GetStatusAilmentTimer` adjusts a base duration by CON or INT: poison base `0xFFF` minus `CON*16`, floor 256; curse base `0x400` minus `CON*4`, floor 64; petrify reduces its small counter by 0 to 4 based on `(CON + rand%12 - 9)/10`; Dark Metamorphosis duration gets `+INT*4`; two other timers gain 50% with Bwaka Knife. Poison also halves attack and doubles damage taken. Petrification clears poison and curse timers. — `src/dra/5D5BC.c:209-245`, `src/dra/71830.c:1382-1393`, `src/dra/71830.c:1670-1672`, `src/dra/5D5BC.c:556`
- **[P1] Stat buff timers.** A 16-slot array holds DEF, ATK, LCK, INT, STR buffs and seven resistances. Giving a buff sets the timer to `0x1000`; each timer counts down by one per call to `DecrementStatBuffTimers`; Fury Plate sets DEF to `0x200`. Active timers add +20 to the stat (or a resistance flag) when stats are recomputed. — `include/game.h:326-339`, `src/dra/5D5BC.c:761-790`, `src/dra/5D5BC.c:855-868`, `src/dra/menu.c:176-260`
- **[P1] Duration units.** Both timer arrays are plain integers decremented per tick. I did not confirm the game's tick rate from code, so seconds figures are not stated.
- **[P1] Save layout.** The save struct is: header (512 bytes of memory-card title and icon), a `SaveInfo` block (name, level, gold, play time, stage, end-game flags, character, rooms-explored, current room x and y, size), the full `PlayerStatus` (HP, MP, stats, equipment, inventory, relics, familiar stats), menu navigation memory, settings, 0x300 castle flags, 0x800 map bytes and the RNG seed. — `include/game.h:1239-1270` (`SaveInfo`, `SaveData`), `src/save_mgr.h:506-640`
- **[P1] What persists.** Persisting: player status, relics, equipment, castle flags, map, room counter, play time, current stage and room cell, **and the random seed**. Not persisting: entity state, per-room kill bitfield (reset on entry), timers (the status timer arrays sit outside `SaveData`), and enemies. Loading restores the stage and room position and then runs the normal room load. — `src/save_mgr.h:600-665`
- **[P1] Settings merge on load.** Completion-related settings bits are OR-ed with those already in memory, so completion unlocks survive loading another slot. — `src/save_mgr.h:648-652`
- **[P1] New game.** New game zeroes all castle flags and then sets a few (elevator, secret stairs, and so on) — `src/dra/game_handlers.c:422-436`.
- **[P1] Random overlay state.** A weather value for the first area is re-rolled from a 16-entry weighted list on every overlay change and stored in a castle flag. — `src/dra/game_handlers.c:330-340`, `src/dra/game_handlers.c:557-558`

### Inferences
- (inference) Persisting the RNG seed in the save prevents save-scumming for drops and crits. DT should decide this on purpose, since rhythm combat may want deterministic encounters.
- (inference) Clearing "killed" flags on room exit gives a self-resetting enemy population with no bookkeeping, but it also permits farming.

**DT principle (Room Manager):** Model a room as data (bounds on the grid, layout id, entity list, music, transition links) with one loader that fades, swaps the entity set, and carries over only entities explicitly marked as persistent. Keep three layers of state separate: permanent world flags (saved), per-visit room state (cleared on entry), and per-fight state (timers, never saved). In Godot terms: `Resource` per room, one `RoomManager` autoload, a saved `Dictionary` for world flags.

### Gaps
- The overlay (stage) loading from disc (`g_StagesLba`, `LoadRoomLayer` internals), and the load-time budget behind the fades: not read.
- Frame rate and a clear statement of timer units.
- The save-room trigger (see section 1).
- How the engine's "carry over" flag (`FLAG_UNK_20000`) is assigned per entity type.

---

## 6. Where code and the common reading diverge (both readings stated)

### Takeaway
Four points where the code differs from, or sharpens, claims in round 1 or the usual fan descriptions. I did not fetch a wiki this round, so "usual reading" below means round 1's notes or widely repeated descriptions, and is unverified.

### Cited Findings
- **Two-handed weapons.** Round 1: not found (gap). Code: same item id written into both hand slots; unequip clears both. Code wins. — `src/dra/menu.c:3146-3155`
- **Map completion.** Usual reading: a "map completion percentage" shown in game, max 200.6% (round 1, unverified). Code: a percentage exists only in the save title (`rooms * 100 / 942`); the status screen shows a raw "ROOMS" count; one counter spans both castles. Code wins for mechanics; the 200.6% cap is not confirmable from the clone. — `src/save_mgr.h:582`, `src/dra/menu.c:1337`
- **Sun and Moon stones.** Usual reading (likely, unverified): effective by day or night. Code: effective by `play-time hours % 24` (6 to 17 sun, otherwise moon). Code wins. — `src/dra/menu.c:206-228`
- **Item crashes.** Round 1: "not decoded". Code: crash trigger and costs are in Richter's player code, using a second row of the sub-weapon table via `crashId`; no Alucard trigger found. Anyone who says "Alucard's item crash" is not supported by what I could find. — `src/ric/pl_blueprints.c:107-132`, `src/ric/pl_setstep.c:322-420`
- **Sword Familiar at level 50.** Round 1 [S]: wieldable at level 50. Code: the item is granted once at exactly level 50 and flagged. Consistent, now [P1]. — `src/servant/tt_004/sword.c:660-663`
- **Input exactness.** Round 1 [S] (castlevaniaspeedruns): motion inputs must be exact. Code agrees: the direction state must equal the expected combination exactly (not a superset) at each step, see Section 7. Consistent, now [P1].

### Inferences
- (inference) Where fan descriptions simplify, they are usually describing behaviour correctly but dropping its units (play time versus clock time, map cells versus rooms). DT's own help text should state units.

### Gaps
- No wiki page was re-fetched, so no wiki sentence is quoted.

---

## 7. Input-sequence recognition (bonus finding for the rhythm track)

### Takeaway
SotN recognises motion inputs with one small per-frame state machine per move, each with a step counter and a 20-tick window per step. This is the code-level reference for how a rhythm game's input sequences could be matched.

### Cited Findings
- **[P1] Per-move state machine.** Each special move has a record of "steps correct" and a countdown timer. Every tick, in a loop over all 16 move slots, the game runs each checker. A step advances only if the held directions exactly equal the expected combination (so down alone, then down plus forward, then forward alone); on advance the timer resets to 20; if the timer hits zero, progress resets to zero. — `src/dra/704D0.c:48-110`, `src/dra/704D0.c:787-835`, `include/game.h:2045`
- **[P1] Facing-relative.** "Forward" is chosen from the facing captured when the sequence started (`g_WasFacingLeft`), so turning mid-input does not break it. — `src/dra/704D0.c:48-70`
- **[P1] Completion latch.** After the last step the state stays in a "complete" value for another window; if the player is busy (a flag is set) the sequence resets, otherwise the attack code reads the complete state and consumes it. — `src/dra/704D0.c:96-110`, consumer `src/dra/6E42C.c:~455-475`
- **[P1] Longer inputs.** Spells use the same pattern with more steps; two spells need a held direction (Tetra Spirit and Sword Brothers, marked "ため" for hold in the spell table). — `src/dra/704D0.c:425-540`, `src/dra/704D0.c:658-786`, `src/config_us.h:143-152`

### Inferences
- (inference) Because the window is per step and not per beat, the system is timing-tolerant. A rhythm game would replace "20 ticks" with "within a beat window of the step's target beat" and keep the rest: one record per sequence, an exact-match test, reset on timeout, a completion latch consumed by combat.

**DT principle:** Describe each combo as data (list of steps, each with a target beat offset and window), run one matcher per active sequence each audio-synced tick, and let combat consume a "complete" latch. Add a grace rule that a wrong press resets only that sequence, not the encounter.

### Gaps
- The tick rate (and so the real duration of 20 ticks) is not confirmed from the code read.

---

## Borrow / Adapt / Enhance / Avoid

### Takeaway
Tags use the DT tiers T1 to T3. SotN's data-driven, table-based structure is the most reusable part; its hidden numbers and opaque counters are the part to avoid.

### Cited Findings
| Item | Verdict | Tier | Note |
|---|---|---|---|
| One grid of room cells that drives map, room lookup and reveal | Adapt | T1 | Room Manager owns one grid; bitfield per cell. Section 1 |
| Map percent shown only on save title with a hidden denominator | Avoid | T1 | Show per-region progress and units. Section 1 |
| Fixed-order stat and damage pipeline recomputed from scratch | Borrow | T1 | Sections 2 and 4 |
| Two-hander as duplicate in both slots | Adapt | T2 | Use an explicit "occupies" rule. Section 2 |
| Level-band tables for familiar or ability growth | Adapt | T1 (growth credit log), T2 (spending) | Bands change behaviour, separate smooth damage multiplier. Section 3 |
| Four element masks per enemy | Enhance | T1 | Replace with affinity tier 1-5 per character. Section 4 |
| Room-local kill flags cleared on re-entry | Adapt | T1 | Decide deliberately; DT's decay-era world may want kills to persist. Section 5 |
| Three state layers (world, visit, fight) | Borrow | T1 | Section 5 |
| Saved RNG seed | Avoid unless intended | T1 | Section 5 |
| Per-step input state machine with exact match and timeout | Adapt | T1 | Beat-window per step. Section 7 |
| Sun and Moon stones keyed to play-time hours | Avoid | T3 | Hidden unit; use a visible world clock if time-of-day matters. Section 2 |
| Position-triggered world flip as a one-off secret | Enhance | T3 | DT's decay map is a better reuse than a flip |

### Inferences
- (inference) None beyond the table.

### Gaps
- None beyond those listed in each section.

---

## Design questions this raises for DT

### Takeaway
Six decisions for the author, each tied to a DT system.

### Cited Findings
1. **Room Manager and map.** Should DT's map track "visited" and "revealed by a map item" as separate states per room cell (as SotN does with two bits), and should it show completion per region? Related: should big rooms count once or per cell?
2. **Saves and the decay-era world.** Which state is permanent (world flags, hidden pair-bond integer, growth-credit log), which resets on room entry (enemy population), and which is never saved (fight timers)? Should the RNG seed be saved?
3. **Enemy persistence.** SotN clears kill flags when you leave a room, so farming is possible. In a decaying world, do killed enemies stay dead, return slowly with the Decay Map, or return on a rule such as rest?
4. **Equipment and band switching.** Should two-handed or "rig" gear occupy two slots by an explicit rule, and does any item (like the Duplicator) bypass a cost such as stamina? Do Ciphera's rig assists use the same slot rules?
5. **Growth bands.** For use-based growth fed by the Perfect and Good growth-credit log, do abilities improve in discrete bands (readable behaviour changes at set ranks) plus a smooth damage multiplier, as familiars do?
6. **Input sequences.** Does a combo step reset only that sequence when missed, and is the window tied to one beat or a window around the target beat? Should a "complete" combo latch persist across a beat if combat is busy?

### Inferences
- (inference) These feed the design-gap discussion in task #6.

### Gaps
- Answers are the author's to give.
