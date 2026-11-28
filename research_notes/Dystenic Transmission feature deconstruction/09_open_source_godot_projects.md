# Open-source Godot 4 projects, templates, demos and addons for a 2.5D action Metroidvania

Research date: 2026-11-05. Target engine: Godot 4.7.x, GDScript. Brief: `00_DT_context_brief.md`.

Method note: every repository below was opened in this session unless marked **(snippet only)**, which means it came from a search result and was not opened. Where a page did not show a field, the entry says "not shown on page" rather than guessing. Most GitHub pages captured here did not show a last-commit date, so the date column is mostly missing; treat that as a gap to close by checking the repo's commit list before adopting anything.

Common caveat: almost no 2.5D side-view Metroidvania code exists as open source in Godot 4. Everything found is either 2D side-view (useful for combat and room logic, not for 3D camera or plane lock), or 3D third-person / first-person (useful for controller and interaction code, not for the side-on camera). Nothing found already implements a plane-locked CharacterBody3D with a side-on camera. That gap is inference from this search, not a complete survey.

---

## Key Question 1: Complete projects and official demos worth studying

### Takeaway
The official `godot-demo-projects` repo (MIT, targets Godot 4.x on master) is the most reliable free source. Its `3d/platformer` and `3d/kinematic_character` folders are the best official 3D locomotion references. Kenney's Starter Kit 3D Platformer is the best small, clean adopt-candidate for a 3D platformer baseline. No open-source 2.5D side-view 3D-character Metroidvania in Godot 4 was found.

### Catalogue

| Project | URL | Licence (as stated) | Godot version (as stated) | Language | Last commit / release | What to study | Verdict |
|---|---|---|---|---|---|---|---|
| godotengine/godot-demo-projects | https://github.com/godotengine/godot-demo-projects | MIT (README) | master = "next 4.x release"; 3.x and 2.1 branches exist | GDScript (inferred from demo content; languages list not shown) | not shown on page | Folder index of 32 3D demos (see below) | study |
| 3d/platformer (in above) | https://github.com/godotengine/godot-demo-projects/tree/master/3d/platformer | inherits MIT | no version in README; names Forward+, GDScript, CharacterBody3D | GDScript | not shown | Player folder holds the controller (script names not visible in capture); coin, enemy, stage folders show a small 3D platformer loop | study (adopt-candidate for locomotion reference) |
| 3d/kinematic_character (in above) | https://github.com/godotengine/godot-demo-projects/tree/master/3d/kinematic_character | inherits MIT | inherits master (4.x) | GDScript (inferred) | not shown | CharacterBody3D movement reference; "kinematic" is the closest official pattern to DT's plane-locked body | study |
| Starter Kit 3D Platformer (Kenney) | https://github.com/KenneyNL/Starter-Kit-3D-Platformer | MIT for code; sprites, models and sound CC0 (repo page) | 4.6 (repo page); Asset Library and Asset Store listings disagree (4.3, 4.5, 4.6, one marked unstable) | not stated (Godot project; scripts folder not named) | not shown; 64 commits | Double jump, coins, falling platforms, camera rotate/zoom, gamepad input. Use as a clean 3D character baseline | adopt-candidate (verify version on 4.7 first) |
| godotengine/tps-demo | https://github.com/godotengine/tps-demo | Asset Library lists MIT (snippet only for licence; repo page did not name licence) | master = latest stable "currently 4.x"; third-party listings say 4.4, 4.5, 4.7 | not stated (Godot project) | not shown; 213 commits | Official, large, high-quality demo. Enemy AI in `enemies/red_robot`; player in `player`; ENet multiplayer; VoxelGI/SDFGI. Study the enemy state machine and feature-complete project structure | study |
| dsnopek/gdquest-tps-demo | https://github.com/dsnopek/gdquest-tps-demo | MIT code, CC-BY-4.0 assets (GDQuest) | Godot 4 (minor not stated) | GDScript (inferred from .gd files) | not shown; 164 commits | Plug-and-play TPS controller: run, jump, melee, aim, shoot, grenades, weapon cycling | study (overlaps the already-covered GDQuest 3D controller; check before duplicating) |
| uheartbeast/metroidvania-godot-4 | https://github.com/uheartbeast/metroidvania-godot-4 | MIT (Heart Gamedev LLC, 2023) | not stated (name suggests 4.x) | GDScript and scenes | not shown; 57 commits | Folder layout for a complete Metroidvania: player, enemies, collisions, effects, menus, ui, world, a SaveManager and WorldStash autoload | study (2D; structure only) |
| Gear0u0/METROIDVANIA-FORGE | https://github.com/Gear0u0/METROIDVANIA-FORGE | not stated on page | 4.6 (About text) | not stated | not shown; 26 commits | Only player and world folders visible; no systems described | avoid for reuse (no licence); study only if its structure is useful |
| SenZmaKi/gyattsouls | https://github.com/SenZmaKi/gyattsouls | not stated on page | 4.3 | not stated | not shown; 4 commits | Soulslike 2D metroidvania (genre only; no mechanics described) | avoid (no licence; tiny) |
| Toxe/godot-planes-sidescroller-3d | https://github.com/Toxe/godot-planes-sidescroller-3d | MIT | not stated | not stated | not shown; 20 commits | A 3D sidescroller prototype (README says WIP); `PlanesSidescroller3D` folder. Camera and plane handling not visible | study (the closest open-source match to a plane-locked 3D side-scroller found; WIP, verify in editor) |

Other items seen only as search snippets (not opened):
- hackenshaw/gdt-platformer-template: "free and open source template for a 2.5D platformer in Godot 4" (snippet only, https://github.com/hackenshaw/gdt-platformer-template is not confirmed as the exact URL; the snippet named it without a link). Potentially the most relevant 2.5D starting point. Must open before any verdict.
- "Godot 4 2.5D Platformer Template - Free and Open Source" (YouTube, snippet only): https://www.youtube.com/watch?v=GEiaz6Nn7-0. Not opened.

### Cited Findings
- godot-demo-projects: README states MIT and that master is compatible with the next 4.x release; the 3d folder contains 32 demos including `platformer` and `kinematic_character` — [godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects), [3d tree](https://github.com/godotengine/godot-demo-projects/tree/master/3d) (accessed 2026-11-05).
- Kenney Starter Kit 3D Platformer: repo page states Godot 4.6, MIT code, CC0 art and sound — [KenneyNL/Starter-Kit-3D-Platformer](https://github.com/KenneyNL/Starter-Kit-3D-Platformer) (accessed 2026-11-05). Store and Asset Library version claims conflict (4.3 / 4.5 / 4.6) — [Godot Asset Store listing](https://store.godotengine.org/asset/kenney/starter-kit-3d-platformer/) (snippet only for version claim).
- godotengine/tps-demo: README says master targets latest stable 4.x; DeepWiki lists VoxelGI/SDFGI, ENet multiplayer and enemy state-machine AI — [godotengine/tps-demo](https://github.com/godotengine/tps-demo), [DeepWiki summary](https://deepwiki.com/godotengine/tps-demo) (snippet only for DeepWiki). Asset Library entry lists MIT — [Asset Library asset 678](https://godotengine.org/asset-library/asset/678) (snippet only).
- dsnopek/gdquest-tps-demo: Godot 4, MIT code, CC-BY-4.0 assets — [dsnopek/gdquest-tps-demo](https://github.com/dsnopek/gdquest-tps-demo).
- uheartbeast/metroidvania-godot-4: MIT, 2023 Heart Gamedev LLC — [uheartbeast/metroidvania-godot-4](https://github.com/uheartbeast/metroidvania-godot-4).
- Toxe planes sidescroller: "WIP", MIT — [Toxe/godot-planes-sidescroller-3d](https://github.com/Toxe/godot-planes-sidescroller-3d).
- SenZmaKi/gyattsouls: "soulslike metroidvania 2D game made with Godot 4.3", no licence shown — [SenZmaKi/gyattsouls](https://github.com/SenZmaKi/gyattsouls).
- Gear0u0/METROIDVANIA-FORGE: "2D Metroidvania game developed with Godot 4.6" — [Gear0u0/METROIDVANIA-FORGE](https://github.com/Gear0u0/METROIDVANIA-FORGE).
- The search for Godot 4 metroidvania projects also surfaced KoBeWi's Metroidvania System (already covered by the brief) — [Asset Store listing](https://store.godotengine.org/asset/kobewi/metroidvania-system/?url_changed=true) (snippet only).

### Inferences
- The official 3d/platformer and kinematic_character demos are safer references than any community project, since they are maintained with the engine (inference).
- Kenney's kit is the fastest path to a working 3D character in Godot 4.7, but its version claims must be checked by opening it in 4.7 (inference).

### Gaps
- No open-source Godot 4 2.5D side-view Metroidvania with a 3D character and side-on camera was found. This matters most for DT: the closest matches are 2D or third-person.
- Last-commit dates were not shown for almost any repo, so maintenance status is unverified.
- The official 3d/platformer player scripts were not readable through the page capture; they must be opened in a clone.

---

## Key Question 2: 3D and 2.5D character controllers, side-scroller cameras

### Takeaway
Community Godot 4 controllers with wall jump and sliding exist (Tim-333), and a climb/glide controller exists (acegiak), but no open-source one with a ledge grab was confirmed. The third-person Jeh3no controller is a good FSM reference. For a side-on camera, no confirmed open-source Godot 4 implementation was found; Toxe's planes sidescroller is the closest.

### Catalogue

| Project | URL | Licence (as stated) | Godot version (as stated) | Language | Last commit | What to study | Verdict |
|---|---|---|---|---|---|---|---|
| Tim-333/full-character-controller-for-godot-3d | https://github.com/Tim-333/full-character-controller-for-godot-3d | **not stated** | 4.5 | GDScript (not stated; inferred) | not shown; 3 commits | Walk, sprint, slide, wallrun, wall jump, camera tilt, head bob. README says "still some bugs" | study only (no licence; do not copy) |
| acegiak/g4-climb-n-glide-character-controller | https://github.com/acegiak/g4-climb-n-glide-character-controller | MIT | 4.x (no minor) | not stated | not shown; 13 commits | Run, jump, climb, glide, optional stamina, interactables. Dimension (2D or 3D) not stated on page | study (check whether climb is surface-based; that is the closest thing found to a ledge/climb system) |
| Jeh3no/Godot-Third-Person-Controller | https://github.com/Jeh3no/Godot-Third-Person-Controller | MIT | 4.4 through 4.7 (README) | GDScript only (README) | not shown; 59 commits | FSM movement, acceleration curves, slopes, multi-jump, jump buffer, coyote time, curve-based air control, shoulder cameras | study (strong FSM reference; third-person camera, not side-on) |
| Toxe/godot-planes-sidescroller-3d | https://github.com/Toxe/godot-planes-sidescroller-3d | MIT | not stated | not stated | not shown | 3D sidescroller prototype; camera and plane handling not visible on page | study (verify camera in clone) |
| CodingQuests/godot-platformer-controller | https://github.com/CodingQuests/godot-platformer-controller | **snippet only** | 2D | — | — | Coyote time, jump buffer, air dash, wall slide and wall jump; 2D, no ledge grab | study only (2D; snippet) |
| clarkgreenrepos/Godot-Character-Movement-Plugin | https://github.com/clarkgreenrepos/Godot-Character-Movement-Plugin | **snippet only** | 4 (claimed) | — | — | Configurable FPS and TPS CharacterBody3D, Source-style movement, jump, slide, coyote time; no ledge or wall jump in snippets | study only (snippet) |
| ExpressoBits/character-controller | https://github.com/expressobits/character-controller | **snippet only** | 4 (claimed) | — | — | Modular FPS controller; walk, crouch, sprint, swim, fly | study only (snippet) |

Not opened (search result only, no verdict): arget4me/GodotWallJump (wall jump; dimension unknown), 0xspig/3dCharacterController (Godot 3 per snippet, bunnyhop; not opened).

### Cited Findings
- Tim-333: "made in godot 4.5", features list wall jump and wallrun, no licence on page — [Tim-333/full-character-controller-for-godot-3d](https://github.com/Tim-333/full-character-controller-for-godot-3d).
- acegiak: "A character controller for Godot 4 with run, jump, climb, glide, and stamina", MIT — [acegiak/g4-climb-n-glide-character-controller](https://github.com/acegiak/g4-climb-n-glide-character-controller).
- Jeh3no: "100% written in GDScript", Godot 4.4–4.7 claimed, MIT, camera options all over-the-shoulder or free-follow — [Jeh3no/Godot-Third-Person-Controller](https://github.com/Jeh3no/Godot-Third-Person-Controller).
- Toxe: "WIP", MIT — [Toxe/godot-planes-sidescroller-3d](https://github.com/Toxe/godot-planes-sidescroller-3d).
- Forum: a 3D character can be restricted to a 2D axis by moving along the camera's basis x when the camera is perpendicular to the plane (community answer; snippet only) — [Godot Forum thread](https://forum.godotengine.org/t/lock-unlock-movement-to-arbitrary-2d-axis-in-3d-game/5805).

### Inferences
- No open-source Godot 4 ledge grab in 3D was confirmed. Ledge grab and climb are likely to need custom code, which fits DT's "learnable, progressively advanced grappling" design (inference).
- The acegiak and Tim-333 controllers are the best 3D mechanic references for wall and climb states, but Tim-333 cannot be copied because it has no licence (rule 2 of the brief).
- Jeh3no's FSM design is the strongest pattern for a plane-locked controller; the camera code should be discarded in favour of a side-on rig (inference).

### Gaps
- Dimensionality of acegiak's climb system is unverified; it may be 2D.
- No open-source 3D grapple controller in Godot 4 was found in this pass.
- Side-scroller camera: no confirmed open-source Godot 4 side-on follow camera with dynamic moves. The Phantom Camera addon (already covered by the brief) is the likely camera tool, so this gap is best filled by that addon.

---

## Key Question 3: Combat frameworks (hitbox, hurtbox, combo, enemy AI, damage)

### Takeaway
CodingQuests/godot-hitbox-hurtbox is the most complete verified Godot 4 combat component set (MIT, Godot 4.7+), but it uses Area2D and must be ported to Area3D for DT. The combo/input-buffer side is served by a separate addon or demo; no single open-source Godot 4 addon combines hitbox, hurtbox and combo input.

### Catalogue

| Project | URL | Licence (as stated) | Godot version (as stated) | Language | Last commit | What to study | Verdict |
|---|---|---|---|---|---|---|---|
| CodingQuests/godot-hitbox-hurtbox | https://github.com/CodingQuests/godot-hitbox-hurtbox | MIT for code; third-party sprites CC0 (Kenney Tiny Dungeon) | 4.7 or later (tested 4.7.2 Windows) | GDScript only | not shown; 2 commits | HealthComponent (signals: damaged, healed, died), HitboxComponent and HurtboxComponent (Area2D; knockback, crit), WeaponController (windup/active/recovery state machine), Player dash with i-frames, GameManager autoload for hit-stop and shake, PlayerCamera (shake, kick, zoom punch), Juice helpers | adopt-candidate (port Area2D to Area3D; 2 commits means treat as a reference, not a library) |
| rathrio/godot-combo-demo | https://github.com/rathrio/godot-combo-demo | not stated on page | not stated | GDScript (inferred from .gd files) | not shown; 17 commits | Combo that accounts for pauses between inputs; includes Hitbox, Hurtbox and InputBuffer scripts | study (combo systems are out of T1 scope; reference only) |
| Input Buffer Combo System (What's Code) | https://store.godotengine.org/asset/whats-code/input-buffer-combo-system/ | MIT (Asset Library listing; snippet only) | Godot 4 (snippet only) | — | — | Timed input buffer and customisable combo sequences | study (snippet only; open source link not confirmed) |
| MisterOsoo/Active-Frame-Hitbox | https://github.com/MisterOsoo/Active-Frame-Hitbox | — | 4.x (snippet only) | — | — | Frame-based hitboxes, hurtboxes and health component | study (snippet only; not opened) |
| wokidoo/GoInputBuffer | https://github.com/wokidoo/GoInputBuffer | — | — | — | — | Input buffering; no combo detection per snippet | not opened; skip |
| drkitt/godot-input-buffer | https://github.com/drkitt/godot-input-buffer | — | **Godot 3 per README (snippet only)** | — | — | Simple buffer | study only (Godot 3) |

Note on the Asset Library combo system: the brief lists no combo addon as covered, so this is a new item, but its source was not verified.

### Cited Findings
- CodingQuests hitbox: components described above; "Requires Godot 4.7 or later; tested on 4.7.2 stable on Windows. Earlier 4.x versions are untested." — [CodingQuests/godot-hitbox-hurtbox](https://github.com/CodingQuests/godot-hitbox-hurtbox).
- rathrio: "A simple combo system that considers pauses between inputs." — [rathrio/godot-combo-demo](https://github.com/rathrio/godot-combo-demo).
- Asset Library combo addon description (snippet only) — [Input Buffer Combo System, Asset Library 4955](https://godotengine.org/asset-library/asset/4955).

### Inferences
- The CodingQuests components show the right separation for DT's basic rhythm combat: hitbox emits damage, hurtbox reads it, health emits signals, and a hit-stop autoload handles feel. This is the pattern to port (inference).
- Hit-stop, screen shake and damage-number juice from this repo overlap the already-covered Saltmire Juice and Juicee addons; prefer whichever is simpler (inference).

### Gaps
- No Godot 4 3D hitbox/hurtbox addon was verified as open source.
- Enemy AI examples: the godotengine/tps-demo `enemies/red_robot` folder is the best official enemy state machine pointer, but its script names were not visible. The brief already covers Beehave and LimboAI for AI, so enemy AI is handled elsewhere.
- Damage and stat systems: none found beyond the CodingQuests health component. GLoot and the RPG-stat work in the brief remain the main coverage.

---

## Key Question 4: Interaction, inventory, quest, save and menu addons

### Takeaway
COGITO is the most complete open-source Godot 4 interaction and inventory template found, but it is first-person and the official repo could not be opened (404) in this session. Its forks claim MIT and Godot 4.4–4.7 compatibility, which must be verified before use.

### Catalogue

| Project | URL | Licence (as stated) | Godot version (as stated) | Language | Last commit | What to study | Verdict |
|---|---|---|---|---|---|---|---|
| Witoldinio/godot-Cogito (fork of r2d2m/Cogito per page) | https://github.com/Witoldinio/godot-Cogito | MIT (fork's README) | 4.2.1 (badge) | GDScript (inferred) | not shown; 216 commits | Interactable objects, inventory on resources, first-person controller with sprint, jump, crouch, slide. Study how interactables are declared as data | study (dated: Godot 4.2.1; upstream claims 4.4 and newer) |
| Phazorknight/Cogito (upstream, per search snippet) | https://github.com/Phazorknight/Cogito | — | 1.1.0 and 4.4 (snippet); Codeberg mirror mentions 4.5.1 (snippet) | — | — | Official COGITO template: "immersive sim template for Godot 4" | study; **the GitHub URL returned HTTP 404 when fetched, so it is not verified. Codeberg mirror at https://codeberg.org/Phazorknight/Cogito (snippet only)** |
| chasesnip3rpp/Cogito | https://github.com/chasesnip3rpp/Cogito | — | — | — | — | Unknown | **avoid: search result's download link points to an unusual .zip path rather than an official source. Do not download.** |
| nicholaskarlson/Godot-Cogito | https://github.com/nicholaskarlson/Godot-Cogito | — | — | — | — | Fork (snippet only) | not opened; skip unless upstream is unavailable |

Not searched in this pass (gap): standalone save-system, quest-system and menu addons for Godot 4. The brief already covers GLoot and Maaack's template. The uheartbeast repo has a SaveManager and WorldStash autoload (see Key Question 1), which is a small example.

### Cited Findings
- COGITO official description: "Immersive Sim Template Project for GODOT 4," with a first-person controller, sprinting, jumping, crouching, sliding and a resource-based inventory — [Godot Forum thread](https://forum.godotengine.org/t/cogito-first-person-immersive-sim-template-for-godot-4/34515) (snippet only), [Codeberg mirror](https://codeberg.org/Phazorknight/Cogito) (snippet only).
- Witoldinio fork: MIT; "forked from r2d2m/Cogito"; Godot 4.2.1 badge — [Witoldinio/godot-Cogito](https://github.com/Witoldinio/godot-Cogito).
- The chasesnip3rpp result warns about an unusual download path — [chasesnip3rpp/Cogito](https://github.com/chasesnip3rpp/Cogito) (snippet only; not opened).

### Inferences
- COGITO's value for DT is its interaction model (interactables that show only when the character has the right skill, matching the brief's "a character only sees an interactable if they have the skill or equipment") rather than its first-person camera. Inference from the brief and the template's description.
- The resource-based inventory pattern is a plausible starting point for DT's gear arcs, but DT's per-character XP and tool-knowledge model is more specific than COGITO's (inference).

### Gaps
- The official Phazorknight repo was not opened (404 on the GitHub URL). The Witoldinio fork is the only verified copy, and its licence must be confirmed against upstream.
- Save, quest and menu addon survey was not done. This is a gap in this research pass.

---

## Key Question 5: Curated lists

### Takeaway
The official awesome-godot list is CC-BY-4.0, and its sections split entries by Godot version (Godot 4 listed first). It is a directory, not a source of code, so it is most useful as a discovery index.

### Catalogue

| Resource | URL | Licence | Godot version | Last update | What to use it for | Verdict |
|---|---|---|---|---|---|---|
| awesome-godot | https://github.com/godotengine/awesome-godot | CC-BY-4.0 (repo page) | Entries sorted into Godot 4, 3 and 2 subsections; some marked as both | not shown (519 commits) | Discovery index; sections include Games, Templates, Demos, Plugins and scripts, Tutorials (moved to Godot docs) | study (discovery only) |

### Cited Findings
- awesome-godot: CC-BY-4.0; Godot 4 is listed first in each version-split section; Tutorials list moved to Godot docs — [godotengine/awesome-godot](https://github.com/godotengine/awesome-godot).

### Inferences
- The "Plugins" and "Demos" sections are where to look for Godot 4 combat or controller addons not found in this pass (inference; the list was not browsed item by item).

### Gaps
- Individual awesome-godot entries were not opened, so no entry was verified from that list beyond the ones linked from search. A full pass through the Godot 4 "Games (2D)" and "Templates" sections would be a useful follow-up.

---

## Key Question 6: Open-source Godot 4 rhythm-action with input-timing judgement

### Takeaway
The brief said no open-source rhythm-action judging input timing was found. This pass confirms that for SRGL and partly updates it: SRGL is Godot 4.6 .NET (C#), which the brief's rules flag. A C# rhythm game exists (Rhythia), but it is aim-based and AGPL. The most relevant GDScript example is g4rge (snippet only).

### Catalogue

| Project | URL | Licence (as stated) | Godot version (as stated) | Language | Last commit | What to study | Verdict |
|---|---|---|---|---|---|---|---|
| SRGL (joung2321/SRGL) | https://github.com/joung2321/SRGL | MIT | 4.6 (.NET) | **C#** (script-based library) | not shown; 118 commits | Timing window of 120 ms (120 × 1000 µs), partitions at 25/50/100 ms (pure / far / lost), judgement strategy interface, combo break threshold, user offset | study (design only). **avoid as a dependency: C#/.NET-only.** The brief lists SRGL as already covered; this confirms the C# constraint |
| Rhythia/Client | https://github.com/Rhythia/Client | AGPL-3.0 (snippet only) | Godot 4.7 with C# (snippet only) | C# (snippet only) | — | Full game; "aim-based" rhythm; a judgements area in game scripts | avoid (AGPL and C#; aim-based, not input timing) |
| polyxord/g4rge | https://github.com/polyxord/g4rge | MIT code, CC0 assets (snippet only) | 4.3 (snippet only) | GDScript (snippet only) | — | Godot 4 rhythm example, systems based on Quaver | study (snippet only; open it before relying on it) |
| scenent/gd-rhythm | https://github.com/scenent/gd-rhythm | MIT (snippet only) | 4.0.1 (snippet only) | GDScript (snippet only) | — | Perfect, Good, Bad judgement; old and simple | study (snippet only) |
| djrow/micgame-2 | https://github.com/djrow/micgame-2 | — (snippet only) | Godot 4 with ONNX Runtime (snippet only) | — | — | Microphone-based polyphonic rhythm game | not opened; note only (relevant to DT's music-as-language pillar; ONNX adds weight) |

### Cited Findings
- SRGL: "Godot 4.6 (.NET)", MIT, C# script-based library, 120 ms window referenced to Arcaea, partitions at 25/50/100 ms — [joung2321/SRGL](https://github.com/joung2321/SRGL).
- Rhythia: "Aim-based rhythm game client, built in Godot 4" (snippet only) — [Rhythia/Client](https://github.com/Rhythia/Client).
- g4rge: "Godot 4 Rhythm Game Example" (snippet only) — [polyxord/g4rge](https://github.com/polyxord/g4rge).

### Inferences
- The SRGL partition design (pure, far, lost at a fixed timing window) is a usable design reference for DT's Perfect / Good / Poor / Miss tiers, which have a different number of tiers and notes. Port the principle, not the code (inference).
- Rhythia's aim-based judgement is not input-timing judgement, so it does not answer the brief's question. It is still the largest open Godot 4 rhythm codebase found (inference from its description).

### Gaps
- No open-source GDScript rhythm game with input-timing judgement was opened and verified. g4rge and gd-rhythm are candidates only from snippets.
- Brief's existing rhythm addons (RhythmNotifier, Conductor, Guitarrada) were not re-surveyed, per the brief.

---

## Borrow / Adapt / Enhance / Avoid (DT translation)

Tier tags: T1 = prototype (Vox and Ciphera, 3-5 rooms). T1.5 = public prologue demo. T2 = Album 1. T3 = full vision. Combo systems and aerial switching are out of T1 scope per the scope lock, so combo items are tagged T2.

| Action | Item | Tier | DT system it serves | Notes |
|---|---|---|---|---|
| Borrow | godot-demo-projects `3d/kinematic_character` and `3d/platformer` (MIT) | T1 | Movement; plane-locked CharacterBody3D | Read in a clone first; confirm they run on 4.7 |
| Borrow | Kenney Starter Kit 3D Platformer (MIT code, CC0 art) | T1 | Movement baseline; camera rotate and zoom | Verify version on 4.7; treat as a template to strip down |
| Adapt | Jeh3no FSM controller (MIT) patterns: coyote time, jump buffer, curve-based air control | T1 | Movement feel | Replace the third-person camera with a side-on rig |
| Adapt | CodingQuests hitbox/hurtbox/health components (MIT, Godot 4.7+) | T1 | Basic rhythm combat; the three enemy types | Port Area2D to Area3D; keep the signal design |
| Adapt | CodingQuests hit-stop and camera kick ideas (GameManager, PlayerCamera) | T1 | Combat feel | Compare with Saltmire Juice and Juicee before choosing |
| Adapt | SRGL judgement partitions (pure, far, lost windows) as a design reference | T1 | Rhythm timing tiers (Perfect, Good, Poor, Miss) | Principle only; the library is C# |
| Adapt | COGITO interactable declaration (skill-gated visibility) | T2 | Interaction; gated-interactable rule | Upstream repo not verified; use the verified Witoldinio fork |
| Adapt | Toxe planes sidescroller 3D (MIT, WIP) plane handling | T1 | Plane-locked 3D side-view | Only after opening its camera code |
| Enhance | Build a verified plane-locked side-on 3D camera rig (no open-source example found) | T1 | Side-on camera; cinematic moves | Phantom Camera (already covered) is the likely camera tool |
| Enhance | Ledge grab and climb states for the 3D controller | T2 | Movement: ledge, climb, grapple | No confirmed open-source Godot 4 3D ledge grab; likely custom |
| Enhance | Combo system with pauses (rathrio demo as a reference) | T2 | Combat combos; 2-5 member combination attacks | Out of T1 scope; reference only |
| Enhance | Gyattsouls and METROIDVANIA-FORGE structure, only if licence is confirmed | T2 | Metroidvania room layout | Both lack licences; ask authors before studying code beyond structure |
| Avoid | SRGL as a dependency | T1 | Rhythm combat | C#/.NET-only; the brief flags this; GDScript project |
| Avoid | Rhythia Client | T3 | Rhythm | AGPL and C#; aim-based |
| Avoid | Tim-333 controller code | T1 | Wall jump and wallrun | No licence; study only |
| Avoid | gyattsouls and METROIDVANIA-FORGE code | T2 | Metroidvania | No licence stated |
| Avoid | chasesnip3rpp/Cogito download | T2 | Interaction | Download link suspicious; do not download |
| Avoid | drkitt/godot-input-buffer | T1 | Input buffering | Godot 3 per README (snippet) |
| Avoid | Any repo's assets, names, art or levels | all | all | Originality rule 1 |

Stated legal status: decompilations and datamines were not part of this research. Nothing above should be vendored into DT without a licence check on the exact commit used.

---

## Summary of verified vs unverified sources
- Opened and read in this session: godotengine/godot-demo-projects (incl. 3d tree and 3d/platformer), godotengine/awesome-godot, godotengine/tps-demo, dsnopek/gdquest-tps-demo, uheartbeast/metroidvania-godot-4, Tim-333/full-character-controller-for-godot-3d, acegiak/g4-climb-n-glide-character-controller, Jeh3no/Godot-Third-Person-Controller, KenneyNL/Starter-Kit-3D-Platformer, CodingQuests/godot-hitbox-hurtbox, rathrio/godot-combo-demo, Gear0u0/METROIDVANIA-FORGE, SenZmaKi/gyattsouls, Toxe/godot-planes-sidescroller-3d, joung2321/SRGL, Witoldinio/godot-Cogito.
- Not opened (snippet only): Phazorknight/Cogito (GitHub returned 404; Codeberg mirror also snippet only), Rhythia/Client, polyxord/g4rge, scenent/gd-rhythm, djrow/micgame-2, CodingQuests/godot-platformer-controller, clarkgreenrepos/Godot-Character-Movement-Plugin, expressobits/character-controller, arget4me/GodotWallJump, MisterOsoo/Active-Frame-Hitbox, Input Buffer Combo System, hackenshaw/gdt-platformer-template.
- Corrections to the brief: SRGL is confirmed C#/.NET (Godot 4.6). Its judgement design (120 ms window, partitions) is the most concrete timing reference found.
