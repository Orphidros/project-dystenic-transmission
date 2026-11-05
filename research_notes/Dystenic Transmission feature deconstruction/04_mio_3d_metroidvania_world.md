# MIO and 3D-rendered side-view Metroidvanias: world design, traversal, interaction (as of 2026-11-05)

Coverage note: about 16 tool calls. MIO is well covered by reviews and a fan wiki, thinly by developer sources. Dread, Samus Returns, Shadow Complex, Trine, Bloodstained and Ori got only shallow search coverage; no GDC Vault talk was retrieved for any of them. Claims from my background knowledge are marked "(background, unverified)" and are never in Cited Findings.

## 1. MIO specifics: release, team, engine, traversal, currency, death, modifiers, map, reception

### Takeaway
MIO released 2026-01-20 (verified by several sources). It is a 2.5D Metroidvania with a grapple-and-momentum core, a shared-energy traversal kit, a Souls-lite currency (Nacre) that is lost on death unless banked, and a Hollow Knight-like slot-based modifier system. Douze Dixièmes announced its closure on 2026-06-23, which the prior report doesn't know. The engine is unnamed ("own custom engine") and no headcount is confirmed.

### Cited Findings
**Release, studio, team**
- Released January 20, 2026 on PC, PS5, Xbox Series, Switch and Switch 2, $19.99, by Douze Dixièmes and Focus Entertainment — [search summary of reviews (OpenCritic, Game8 etc.)](https://opencritic.com/game/19840/-)
- Announced at the June 2024 Nintendo Direct for 2025, then delayed in December 2025 to 20 January 2026 — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit); [Analog Stick](https://www.analogstickgaming.com/news/2025/12/4/mio-memories-in-orbit-sets-course-to-launch-on-january-20-2026)
- Credited roles: director Oscar Blumberg, producers Sarah Hourcade and George Herrmann, two programmers (Ferragu, Kazandjian), one artist (Etienne Thibault Buisson), writer Tom Ariaudo, composer Nicolas Gueguen, engine contributor Joran Bigalet. Wikipedia credits an engine person but does not name the engine — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)
- "Our own custom engine" is the studio's own phrase; Creative Bloq reports the art direction took two team members about five years of tuning in the engine and "often pushed the engine and pipeline beyond what they could handle" (secondhand via search snippet; the article body did not load) — [Gamereactor/Creative Bloq summaries](https://www.creativebloq.com/3d/video-game-design/mio-memories-in-orbits-stunning-hand-drawn-art-direction-explained-by-its-creators). Creative Bloq's title calls it "a 3D Metroidvania that feels hand-drawn", so the pipeline is 3D rendered with a painted/watercolour look rather than painted 2D backgrounds. A review describes comic-book sensibilities with watercolour textures layered over 3D space — [inkl review](https://www.inkl.com/news/mio-memories-in-orbit-review-a-painterly-metroidvania-that-rewards-patience-and-curiosity)
- Blumberg: "We're a small team, so most people do multiple things"; the studio was founded about 8 years ago; camera is "quite far away for gameplay reasons"; the story "had to co-evolve with the level design"; many mechanics "not explained at all or only partially"; hints exist "in the world" and an in-game hint pops up if you're stuck too long — [GamePressure interview](https://www.gamepressure.com/editorials/most-challenging-was-letting-go-of-ideas-we-liked-interview-with/z2783)
- Expressiveness without faces comes from exaggerated posture and body language (same interview, which cites graphic-novel references Meurisse, Kerascoët, Guarnido) — [GamePressure](https://www.gamepressure.com/editorials/most-challenging-was-letting-go-of-ideas-we-liked-interview-with/z2783)
- Closure: Douze Dixièmes announced it would close on 2026-06-23 (Le Figaro report, relayed by Kotaku). Focus reportedly keeps publishing rights. No official studio statement was quoted in the pages I read. A Russian outlet claims 10 employees (unverified, single source) — [Kotaku](https://kotaku.com/the-studio-behind-one-of-2026s-most-delightful-metroidvanias-is-closing-2000709642); [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit); [Gamereactor](https://www.gamereactor.eu/douze-dixiemes-the-studio-behind-mio-memories-in-orbit-has-been-shut-down-1738973/)

**Traversal and sequence**
- Core kit as reported: double jump, wall/ceiling crawl ("like a spider"), glide, grappling "onto certain nodes". Abilities unlock at major milestones and open areas already seen — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review)
- All movement abilities draw one small shared energy reserve. It refills by standing still on solid ground briefly, or after striking an enemy or energy source. Energy-restoring flowers and enemies act as bounce points — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review)
- Fan wiki ability order: Hairpin Grapple (early, essential; advanced play chains grapple points while keeping momentum), aerial combat with jump reset (hitting an enemy or environmental object resets the double jump), Arachnid Locomotion (walls/ceilings, costs energy), Dash/Deflect (perfect-dodge style), Orbs (ranged), Decoy Clones, Gliding (around hour 8, costs energy), Flowing Steps (final; earned via two hard platforming challenges in The Crucible; climbs "gloom water" and waterfalls). Unlock timing for items 2-6 not given — [MIO wiki](https://www.miomemoriesinorbit.wiki/abilities-upgrades/). Treat as fan-sourced.
- Combat is mostly aerial; "striking any enemy will recover your double-jump" — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)
- A guide reports a teacher robot, Samsk, grants abilities after major story moments; seven abilities total (secondhand via search summary; the individual guide wasn't fetched) — [Steam guide](https://steamcommunity.com/sharedfiles/filedetails/?id=3783530257)
- World has four main biomes, plentiful shortcuts, secrets throughout, about 15 bosses each with own moveset and music, many off the main path — [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/)

**Currency and death**
- Nacre is the currency. On death all carried ("Liquid") Nacre is lost, unrecoverable per the wiki; it goes to Shii, an NPC who is the only way to check the map early. After enough Nacre is lost to Shii, permanent map access is granted — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit). Contradicted in detail by the wiki and But Why Tho, which say Liquid Nacre is simply lost with no pickup and can be converted to permanent Solid Nacre by certain active robots — [MIO wiki](https://www.miomemoriesinorbit.wiki/abilities-upgrades/); [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/). Sources disagree on where lost Nacre "goes"; the shared fact is bank-or-lose.
- Enemies respawn and scrap piles reform after resting, so Nacre is re-farmable — [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/)
- Death returns the player to the last "Overseer" rested at. Overseers provide fast travel, save, and map updates and are sparse early — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)
- Health is permanently drained as you progress (reviewer reads this as a discouraging early mechanic); a shell upgrade adds a permanent health node after four collected — [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/)
- Reported but secondhand: a small attack bonus per death, capped (search summary only). An "assist" menu includes pacifist mode, a stand-still one-hit shield, and "boss erosion" (bosses weaken slightly each time they kill you); the reviewer calls erosion the most useful and most controversial — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review); [70% Complete on assists](https://www.70percentcomplete.com/mio-memories-in-orbit-wants-you-to-play-it/)

**Modifiers and upgrades**
- Modifiers are equippable, "reminiscent of Hollow Knight's charm system", with slot costs by quality; some are negative but grant extra slots — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)
- Allocation Matrix has limited capacity; 7 Mod Extensions total; equip/unequip at Network Gates, where Nacre is also spent on upgrades like max health. The minimap itself can be disabled to free slots, i.e. the map is a loadout item — [MIO wiki](https://www.miomemoriesinorbit.wiki/abilities-upgrades/)

**Map, interactables, environmental storytelling**
- Map is gated early (Shii, Overseer updates) — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)
- Interactables named in reviews: grapple nodes, energy flowers, converter robots, scrap piles, lore collectibles ("Pearls"), health refills placed where needed — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review); [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/)
- Story through environment and "short bits of text on public plaques"; dense detail used for claustrophobia, sparse backgrounds to focus the foreground — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review)
- Destructoid praised the environmental storytelling — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)

**Reception**
- Metacritic 81-83 depending on platform; OpenCritic 83% recommend over 102 reviews. Destructoid 9/10, Game Informer 8.75 (early progression tedious), Nintendo Life 8, NWR 7.5 (pacing frustrating), Shacknews 6 (upgrades discourage experimentation, weak combo and bosses) — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit)
- Strengths: art ("Euro sci-fi comic come to life"), triumphant hard platforming, generous shortcuts and refills, boss variety. Weaknesses: long platforming runs that restart "from the very first step", brutal bosses, slow early game, floaty controls (search summary), costly Nacre loss, empty ending — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review); [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/)
- Commercial: critics praised it but sales reportedly weaker; this is outlet inference, not studio-confirmed — [Gamereactor](https://www.gamereactor.eu/douze-dixiemes-the-studio-behind-mio-memories-in-orbit-has-been-shut-down-1738973/)

### Inferences
- (inference) MIO's grapple is a momentum chain between nodes plus a hit-to-reset jump; the design logic is "the world supplies reset points", so rooms are authored as sequences of reset opportunities. DT's grapple can be rebuilt on the same principle without copying the Hairpin.
- (inference) A shared energy pool for all traversal is a cheap way to bound exploit lines in a plane-locked controller: a single float, easy to implement in GDScript.
- (inference) Slot-loadout modifiers that include the map itself fit DT's "see only what your skills reveal" rule closely.
- (inference) The complaint about restarting long platforming runs implies DT's 250 m vertical layers need checkpoints or rest points inside long climbs.

### Gaps
- Engine name, final headcount, total dev time: not found (the "five years" figure is for the art direction work per Creative Bloq, not the whole game).
- Exact grapple physics, unlock order of items 2-6, and map-pin or screenshot features: not found. Camera framing behaviour per room (fixed vs follow): not found beyond "far away".
- Closure details from the studio itself: not found; only secondary reports.

## 2. 3D in side view: depth layers, readability, camera, lighting

### Takeaway
Developers who discuss it say the 3D space exists to enable camera movement and depth, not depth-axis gameplay. Evidence is thin outside Lost Crown and Dread.

### Cited Findings
- Lost Crown art director Jean-Christophe Alessandri: "it's really important to keep that [sense of] depth... we use a lot of camera movement, and we can do that with 3D"; the game mixes 3D models/environments with side-scrolling action — [Rock Paper Shotgun visit, as quoted in a search summary](https://wwwrockpapershotgos.pages.dev/posts/prince-of-persia-the-lost-crowns-anime-inspired-art-was-led-by-a-new-generation-of-animators) (mirror domain; verify against the original RPS piece)
- Lost Crown level design: "We used the camera to ensure that the path is super-readable", foreshadowing the path — [Techpowerup forum repost of Ubisoft interview](https://techpowerup.com/forums/posts/5180045) (secondhand)
- Lost Crown special moves take control of the camera and move it inside the world, with a palette shift — [Sameteem write-up](https://sameteem.com/threads/how-ubisoft-is-bringing-prince-of-persia-back-as-an-anime-like-metroidvania.22686/?amp=1) (secondhand)
- Dread reviewers: the 2.5D presentation adds "depth, fluidity and detail" that sprites would make costly — [search summary of reviews](https://www.engadget.com/metroid-dread-nintendo-switch-preview-e3-130020326.html)
- Shadow Complex (Unreal Engine 3): world 70,402 units wide, 25,217 tall, average depth only 3,500 units; enemies patrol backgrounds and the avatar aims at them in Z automatically; levels planned on paper in Illustrator then blocked out with BSP — [Game Informer tidbits](https://gameinformer.com/b/news/archive/2010/01/05/shadow-complex-tidbits); [Wikipedia](https://en.wikipedia.org/wiki/Shadow_Complex); [GDC 2010 write-up](https://code3d.gamedev.net/blogs/entry/2111303-gdc-2010-wrap-up)
- Trine 3's move into full 3D caused iteration problems with how the Wizard and Thief worked in depth; Frozenbyte went back to 2.5D for Trine 4 because the games "play better as side-scrollers" — [80.lv](https://80.lv/articles/trine-3-interview); [Destructoid/Fandom interview](https://www.fandom.com/articles/2017-interview-frozenbyte-on-trine-4-2-5d-is-where)
- MIO: sparse backgrounds focus the foreground; dense detail conveys claustrophobia — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review)

### Inferences
- (inference) Every example keeps gameplay on one plane and spends depth on camera, background parallax and set-piece moves. Trine's retreat from 3D supports DT's plane lock.
- (inference) Shadow Complex's thin-depth-slab world plus auto-aim into background is a model for DT's "enemy visible in depth but not reachable" rule.

### Gaps
- Per-room camera framing rules, silhouette-readability and dark-scene lighting practices from any developer: not found. No GDC Vault talk was retrieved for Lost Crown, Dread or Shadow Complex.

## 3. Navigation and world: maps, fast travel, shortcuts, EMMI, scan pulse, pacing

### Takeaway
Lost Crown's Memory Shards are the best-documented navigation aid: a capped, reusable screenshot-to-map pin with a stated design rationale. EMMI is documented only at the origin-and-intent level.

### Cited Findings
- Memory Shards: one button takes a screenshot (HUD removed) and pins it to the map; hold to view it. Senior designer Remi Boutin: "when looking at our map we forgot what we were trying to do". Start with 15, increasable but never unlimited. The cap began as a technical limit (cloud-save size) and became a feature: limited shards keep the map readable. Shards are placed as chest rewards near blocked paths, which also teaches the feature. "It took tons of iteration and playtest to get a 'natural' feeling" — [Game Developer](https://gamedeveloper.com/design/how-memory-shards-help-players-find-secrets-in-prince-of-persia-the-lost-crown)
- Inverse reports the feature began as an accessibility tool — [Inverse](https://www.inverse.com/gaming/prince-of-persia-lost-crown-accessibility-interview)
- EMMI: Sakamoto says the concept (a humanoid robot on all fours chasing Samus) is about 15 years old; the brutality was by design to evoke dread though "not a horror game"; MercurySteam proposed suggestions that were considered; he wrote level-design explanations by hand for each designer — [Nintendo Everything / Famitsu summary](https://nintendoeverything.com/metroid-dread-hd-emmi-interview-yoshio-sakamoto/); [Nintendo Wire](https://nintendowire.com/news/2022/01/24/metroid-dread-producer-discusses-the-games-difficulty-and-why-the-e-m-m-i-encounters-were-so-unforgiving/); [Shinesparkers](https://shinesparkers.net/sakamoto-reveals-he-first-conceived-the-e-m-m-i-fifteen-years-ago/)
- VGC criticised Dread for hiding progress behind unmarked blocks and for level design less intricate than classic entries — [VGC](https://www.videogameschronicle.com/review/metroid-dread/)
- MIO: sparse Overseers give fast travel, save and map updates; shortcuts are generous and "going right when told to go left" can unlock one — [Wikipedia](https://en.wikipedia.org/wiki/MIO:_Memories_in_Orbit); [But Why Tho](https://butwhytho.net/2026/01/mio-memories-in-orbit-review/)

### Inferences
- (inference) For DT, a capped "pin" resource fits a 3-5 room T1 only as text/icon pins; screenshot capture is a T1.5+ feature.
- (inference) EMMI-style pursuit zones are expressible as a scripted chaser confined to a room set with a lose-or-escape door; they conflict with nothing in T1 but add an enemy type beyond the three-enemy cap, so defer.
- Scan pulse (Samus Returns) and Dread EMMI zone mechanics: not sourced here (background, unverified: a pulse that reveals breakable blocks and map secrets on the local screen). The reveal-on-demand idea matches DT's skill-gated visibility.

### Gaps
- Samus Returns scan pulse, Dread map and fast-travel details, Lost Crown fast travel, and sequence-break/backtracking statements from developers: no source retrieved. Vertical pacing of any game: not found.

## 4. Interactions: grapple points, destructibles, physics props, switches, multi-character

### Takeaway
Grapple points and energy refills in MIO and physics props in Trine are the best-evidenced items; the other games' interaction details weren't sourced.

### Cited Findings
- MIO: grapple nodes, energy flowers, enemies as bounce points; hitting environmental objects resets the jump — [AV Club](https://www.avclub.com/mio-memories-in-orbit-review); [MIO wiki](https://www.miomemoriesinorbit.wiki/abilities-upgrades/)
- Trine: PhysX-driven; progress requires using physics objects and machinery; Trine 2 team fixed unwanted physics behaviour and made objects keep kinetic energy — [WorthPlaying](https://worthplaying.com/article/2009/4/7/interviews/60574); [Siliconera](https://www.siliconera.com/?p=104068)
- Trine's three-character switching is the multi-character interaction model; Trine 3 showed depth made character roles harder to design — [80.lv](https://80.lv/articles/trine-3-interview)

### Inferences
- (inference) Jolt gives Godot comparable rigid-body props; keep puzzle props few and reset-able, since Trine's own teams spent effort taming physics.
- (inference) Vox/Ciphera can mirror Trine's "different verbs open different objects" with Ciphera-only interactables, consistent with the DT skill-gated visibility rule.

### Gaps
- Shadow Complex destructibles and gates, Dread/Samus Returns/Bloodstained/Ori interaction details, Ori traversal language: not sourced.

## 5. Developer statements (GDC, interviews)

### Takeaway
Retrievable developer statements are mostly interviews, not GDC talks.

### Cited Findings
- Sakamoto and MercurySteam: see section 3. Lost Crown: Boutin on Memory Shards; Radi/Ubisoft on Rayman lineage — [Game Developer](https://gamedeveloper.com/design/how-memory-shards-help-players-find-secrets-in-prince-of-persia-the-lost-crown); [Xbox Wire](https://news.xbox.com/en-us/2024/01/17/prince-of-persia-the-lost-crown-builds-on-raymans-platforming-legacy/) (body not read)
- MIO: Blumberg and Hourcade interviews — [GamePressure](https://www.gamepressure.com/editorials/most-challenging-was-letting-go-of-ideas-we-liked-interview-with/z2783); [Xbox Era](https://xboxera.com/2026/01/19/mios-sarah-hourcade-talks-game-pass-inspiration-and-the-games-gorgeous-artstyle)
- Shadow Complex GDC 2010: paper-first planning then BSP blockout — [gamedev.net wrap-up](https://code3d.gamedev.net/blogs/entry/2111303-gdc-2010-wrap-up)

### Inferences
- (inference) The Shadow Complex paper-then-blockout workflow matches DT's Cyclops/GridMap prototyping for a solo developer.

### Gaps
- No GDC Vault talk found for Dread EMMI, Lost Crown level design or Shadow Complex's Unreal approach. Search with the speaker names directly in the Vault.

## 6. DT translation

### Takeaway
Borrow principles (reset points, banked currency, loadout-as-map, capped pins); avoid early depth-axis gameplay and extra enemy types in T1.

### Cited Findings
- None new; see sections above.

### Inferences
| Action | Item | Tier | DT system |
|---|---|---|---|
| Borrow | Grapple nodes as momentum "reset points" authored per room | T1 | Grappling; plane-locked CharacterBody3D |
| Adapt | Single shared traversal-energy pool (stand-still or hit refill) | T1 | Stamina and movement |
| Adapt | Bank-or-lose currency on death, mapped to DT's XP pool and blackout rather than a lost-on-death drop | T2 | Souls-lite XP; blackout system |
| Adapt | Hard gating by skill: Ciphera-only or Vox-only interactables hidden from the other | T1 | Character-specific visibility rule; switching |
| Enhance | Map as a loadout item (minimap toggle trading against slots) tied to signal states (Clear to Encrypted) | T2 | Perception overlay; map |
| Adapt | Capped map pins (Memory Shards idea) as text or icon pins | T1.5 | Map; backtracking in 250 m layers |
| Enhance | Rest points inside long vertical climbs to avoid "restart from the first step" | T1 | ~250 m Deep-City layers; duct and crouch passages |
| Borrow | Camera spends depth on framing and set-piece moves, gameplay stays on one plane | T1 | Camera rig; plane lock |
| Borrow | Shadow Complex-style background enemies visible but non-interactive | T1.5 | Enemy readability |
| Adapt | Assist options such as boss erosion, as accessibility options | T1.5 | Rhythm combat; accessibility |
| Avoid | Depth-axis gameplay (Trine 3's problem) | T1 | Plane lock |
| Avoid | EMMI-style pursuit zones until after the three-enemy T1 cap | T1.5 | Enemy roster |
| Avoid | Unmarked hidden progress blocks (VGC complaint) without a reveal tool | T1 | Skill-gated reveal |
| Avoid | Vendoring or copying MIO/Dread/Lost Crown names, art or layouts | T1 | Originality rule |

### Gaps
- None beyond sections 1-5.
