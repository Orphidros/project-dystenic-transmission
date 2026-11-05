# Asset licence and Godot addon gap-fill (track 17)

Accessed 2026-11-05. Closes the Gaps in `10_free_3d_assets.md` and `09_open_source_godot_projects.md`. Brief: `00_DT_context_brief.md`.

**Verification key.** "VERIFIED" = licence quoted from a page opened this session. "PARTIAL" = page opened but licence text was summarised, not quoted in full, or the source conflicts. "GAP" = page blocked (403/404/503), empty, or silent on the point. "SNIPPET" = found in a search result only, not opened.

**Blocking note.** web.archive.org was refused by the fetch tool, so archived copies of blocked pages could not be read. Roughly 25 tool calls were used, above the usual 15 because the gap list has more than 20 items.

---

## Key question 1: Licence verification

### Takeaway
Most blocked official licence pages stayed blocked: Mixamo, Fab, MakeHuman, CMU mocap, Rokoko, OpenGameArt. Verified this pass: MPFB2's code licence (GPL-3 for LICENSE.CODE.md), godotshaders.com's shader licence policy, the SIL OFL 1.1 summary, and the Cogito licence (MIT). The MPFB2 asset-licence result is unresolved (see below). Mixamo, Fab Standard License and CMU mocap terms remain open.

### Cited findings

**MPFB2 / MakeHuman**
- The MPFB2 GitHub README names no licence. Its LICENSE files are LICENSE.md, LICENSE.CODE.md and LICENSE.ASSETS.md. The README says only "MPFB2 is a free and open source human generator for Blender." — [makehumancommunity/mpfb2](https://github.com/makehumancommunity/mpfb2) (VERIFIED page; licence not on the page)
- LICENSE.CODE.md opens with "GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007." So the code is GPL-3. — [LICENSE.CODE.md (raw)](https://raw.githubusercontent.com/makehumancommunity/mpfb2/master/LICENSE.CODE.md) (VERIFIED)
- LICENSE.ASSETS.md (raw) returned text that the summariser identified as CC0 1.0 Universal legal text. It did not say which asset set this covers, and the summariser could not quote the full text. This is unresolved. Do not treat MPFB-generated characters as CC0 until the file is re-checked by hand. — [LICENSE.ASSETS.md (raw)](https://raw.githubusercontent.com/makehumancommunity/mpfb2/master/LICENSE.ASSETS.md) (PARTIAL, conflicting)
- The MakeHuman licence page (https://www.makehumancommunity.org/content/licenses.html) returned HTTP 503 in the earlier pass and was not retried here. The MPFB2 FAQ on selling models is still unread. — GAP

**Mixamo**
- https://helpx.adobe.com/creative-cloud/faq/mixamo-faq.html returned HTTP 403. https://www.mixamo.com/faq returned HTTP 404. https://www.mixamo.com/ returned an empty loader page in the earlier pass. Commercial and redistribution terms for Mixamo output are still unverified. The DT brief's "Mixamo is allowed" line is not confirmed by a source. — GAP

**Fab Standard License**
- https://www.fab.com/eula returned HTTP 403. The Fab home page returned HTTP 503 in the earlier pass. The Standard License scope and the free-content list are unverified. — GAP
- The Sketchfab free-models page states that "thousands of royalty-free models are available to license on Fab, a separate paid marketplace." — [Sketchfab free models](https://sketchfab.com/features/free-3d-models) (VERIFIED, from the earlier pass)

**godotshaders.com licence policy**
- Submitters must choose a licence for their shader. The page lists CC0 (public domain), MIT and GNU GPL v3 as the options. The page says "the shader code and other code snippets in the post will be under the license that you choose." — [godotshaders.com/license](https://godotshaders.com/license/) (VERIFIED via summariser)
- The page says "Anyone will be able to use the shaders posted to the site freely, both in personal and commercial products." It adds: "The license only applies to the shader code and other code snippets available in the submitted post." Featured images, screenshots, videos and their assets are excluded. — same page (VERIFIED)
- The page does not say how to treat a shader without a stated licence. Treat each shader's own licence as the authority, and do not reuse any shader that states none. (inference)

**Google Fonts / OFL**
- The OFL summary page (openfontlicense.org) describes the licence as "the widely used, community-approved, free, libre, and open source license specifically designed for fonts." It says OFL fonts can be used in books, posters, artwork, logos and websites with "no acknowledgement is required," and that you can "freely modify and redistribute" them. It names the current licence as SIL OFL version 1.1, text dated 26 February 2007. The summariser said the page did not explicitly mention commercial use. — [openfontlicense.org](https://openfontlicense.org/) (PARTIAL)
- The page says bundling in apps is "subject to certain conditions," which the summariser could not list. Read the full OFL 1.1 text before shipping a bundled font. — [OFL 1.1 full text](https://openfontlicense.org/) (GAP for the full text)
- The Google Fonts glossary page returned only its title. The Share Tech Mono Google Fonts page was checked earlier and also returned only a title. Per-font licences are still unverified. — GAP

**OpenGameArt licence filter**
- https://opengameart.org/content/faq returned HTTP 403. The licence filter options and the list of accepted licences were not checked. — GAP

**CMU Graphics Lab Motion Capture Database**
- https://mocap.cs.cmu.edu/ returned HTTP 503. http://mocap.cs.cmu.edu/info.php returned HTTP 404. The commercial-use and redistribution terms are unverified. Do not use the CMU mocap data in a shipped game until the terms are read. — GAP

**Rokoko free motion library and Truebones free packs**
- https://www.rokoko.com/integrations/godot returned HTTP 404. The Rokoko free-library terms were not found under this URL. — GAP
- https://truebones.gumroad.com/ returned only the title "Truebones Studios." No free pack or licence statement was shown. — GAP

**Cogito (official repo location)**
- https://github.com/Phazorknight/Cogito returned HTTP 404 in this pass, even though a web search listed it. The GitHub README points to Codeberg. The Codeberg repo is the current home. — [Codeberg Phazorknight/Cogito](https://codeberg.org/Phazorknight/Cogito) (VERIFIED page)
- Codeberg README: licence not named on the page. The LICENSE file is "MIT License" with "Copyright (c) 2023 Phazorknight." — [Codeberg LICENSE (raw)](https://codeberg.org/Phazorknight/Cogito/raw/branch/main/LICENSE) (VERIFIED)
- Codeberg badge: "Godot_4.6.3_stable". Latest commit: 2026-11-04 23:42:49 +01:00. Features listed: "Save and Load System as well as scene persistency" and "Basic Quest System." The page also carries a notice about Terms of Use changes, which was not read. — [Codeberg Cogito](https://codeberg.org/Phazorknight/Cogito) (VERIFIED)
- The Godot Asset Library listing for COGITO is in search results and shows Godot 4.3 and 4.4 claims. Versions conflict across listings. — SNIPPET
- The Witoldinio fork (from `09`) is now superseded by the Codeberg upstream as the verified source. Its licence is MIT per the fork's own README. — [Witoldinio/godot-Cogito](https://github.com/Witoldinio/godot-Cogito) (VERIFIED in `09`)
- chasesnip3rpp/Cogito: no change. Do not download. (carried from `09`)

### Inferences
- Cogito's upstream is MIT, and it has a save/load system and a basic quest system, which fills two of the addon gaps below. It is first-person and was built for Godot 4.6.3. Its Godot 4.7 compatibility is unverified. (inference)
- MPFB2 code is GPL-3. Any code that is vendored must be GPL-compatible with DT's licence choice. The character asset licence is still open. Do not ship MPFB output until LICENSE.ASSETS.md is read by hand. (inference)

### Gaps
- Mixamo commercial and redistribution terms (403, 404, 503).
- Fab Standard License text and the free-item list (403, 503).
- MPFB2 asset licence (conflicting summary; re-check by hand). MakeHuman licence page (503 in earlier pass).
- CMU mocap terms (503, 404).
- Rokoko and Truebones free-pack terms (404; title-only page).
- OpenGameArt licence list (403).
- Google Fonts per-font licences; full OFL 1.1 text.

---

## Key question 2: Missing kit types (sewer, tunnel, pipe, industrial, rubble, scanned debris)

### Takeaway
Kenney's City Kit (Industrial) and Factory Kit are both CC0 with 40 and 140 files, but neither page lists file formats or named pipe, sewer or tunnel pieces. Poly Haven's industrial model filter page did not show any model names. No verified sewer, tunnel or rubble kit was found.

### Cited findings
- Kenney "City Kit (Industrial)": licence "Creative Commons CC0"; "40×" files; no file formats listed; tags city, building, factory and warehouse. No sewer, pipe, tunnel or rubble pieces named. — [kenney.nl/assets/city-kit-industrial](https://kenney.nl/assets/city-kit-industrial) (VERIFIED)
- Kenney "Factory Kit": licence "Creative Commons CC0"; "140×" files; no formats listed. Tags include conveyor, belt, industrial, warehouse and factory. No individual pipe or tunnel piece named. — [kenney.nl/assets/factory-kit](https://kenney.nl/assets/factory-kit) (VERIFIED)
- Kenney site-level CC0 statement (from `10`): "all game assets on the asset pages are public domain licensed (CC0)." — [kenney.nl/support](https://kenney.nl/support) (VERIFIED earlier)
- Poly Haven "all models" page filtered to industrial: the summariser found no model names. It listed collection titles (for example "Project Lighthouse" and "The Hidden Alley") but no pipe, sewer, tunnel or rubble model. The page has only a "License" nav link with no text. Poly Haven's CC0 status is already verified in `10` from https://polyhaven.com/license. — [polyhaven.com/all?type=models&c=industrial](https://polyhaven.com/all?type=models&c=industrial) (PARTIAL; no names shown)

### Inferences
- Kenney's Factory and City (Industrial) kits are the nearest CC0 match to Mid and Lower Depths industrial dressing. Pipe and tunnel pieces would have to be made in Blender from the kit's modules. (inference)
- Scanned-debris and rubble remain a gap. Poly Haven's CC0 scans are the likely best source once a specific model is named, but none was identified. (inference)

### Gaps
- Named sewer, tunnel, pipe or rubble models from Poly Haven (filter showed no names).
- Quaternius and Sketchfab CC0 sewer searches were not run in this pass. OpenGameArt was blocked.
- Kenney file formats for City Kit (Industrial) and Factory Kit are not listed on the pages.

---

## Key question 3: Missing Godot 4 addons (save, quest, menu/settings, input-buffer/combo)

### Takeaway
Save systems and quest systems are now covered by MIT-licensed Godot 4 addons. The Asset Library input-buffer addon claims MIT, but its linked source repo states no licence and no description, so it cannot be adopted yet. No menu or settings addon was searched in this pass.

### Catalogue (all opened this session unless marked)

| Project | URL | Licence (as stated) | Godot version (as stated) | Last update | What it does | Verdict |
|---|---|---|---|---|---|---|
| Cogito (Codeberg upstream) | https://codeberg.org/Phazorknight/Cogito | MIT (LICENSE file) | Badge 4.6.3 stable; Asset Library claims 4.3 and 4.4 (snippet) | Latest commit 2026-11-04 | First-person template with save/load, basic quest system, interactables | study; upstream verified |
| savestate (youssof20) | https://github.com/youssof20/savestate | MIT | "Tested on Windows with Godot 4.5.2, 4.6.3, and 4.7.2" | not shown; 17 commits | Named slots, checkpoints, automatic saving, save history, editor panel | adopt-candidate for save system (check it against 4.7.2 claim) |
| CodingQuests/godot-save-system | https://github.com/CodingQuests/godot-save-system | MIT | "Tested on Godot 4.7.2 stable on Windows"; README "Godot 4.7 or later" | not shown; 2 commits | Slot-based saves, items stay gone after load, atomic JSON writes, versioned save upgrades | adopt-candidate (young; 2 commits) |
| saveflow-lite (indieshade) | https://github.com/indieshade/saveflow-lite | MIT | "Godot 4.6+" (page title and status) | not shown; 98 commits | Slot-based save/load, scene, node and save-graph persistence, typed data | study (larger; check 4.7 compatibility) |
| ShomyKohai/quest-system | https://github.com/ShomyKohai/quest-system | MIT | "Godot 4.4+" | not shown (151 commits; no releases) | Resource-based quests, typed singleton, localisation, serialisation, GDUnit4 tests | adopt-candidate (quest system) |
| Rubonnek/quest-manager | https://github.com/Rubonnek/quest-manager | MIT | "Godot 4.2.1+" | not shown (84 commits; no releases) | Nested quest trees, state tracking, Callable transition conditions, signals, runtime debug viewer, save/load | adopt-candidate (quest system; has save/load) |
| Msumri/combo-tutorial (source for Asset Library "Input Buffer Combo System") | https://github.com/Msumri/combo-tutorial | **Not stated on the page** | Not stated | not shown; 8 commits | Folder `addons/Input_buffer_combo_system`; no description | avoid until licence is confirmed |
| Input Buffer Combo System (Asset Library) | https://store.godotengine.org/asset/whats-code/input-buffer-combo-system/ | MIT (listing) | Compatibility list spans 4.8 down to 3.0; no single version | Last updated 19 October 2026 | "A lightweight and flexible combo input buffer system for Godot 4" | study; licence conflicts with source repo, so verify before use |
| GD-Sync Multiplayer Plugin | https://store.godotengine.org/asset/gd-sync/gd-sync-godot-multiplayer-plugin/ | BSD 3-Clause (listing) | Godot 4 | not shown | Multiplayer backend with cloud saves (not a standalone save system) | not relevant to DT single-player |
| GustavoLR548/quest-system-example | (snippet only; not opened) | not stated | not stated | — | Tutorial pairing a quest addon with Nathan Hoad's dialogue manager | SNIPPET; study only if needed |
| godot-save-system topic list: andresmtz88/Dream-Librarian, lucasmcclean/godot-game-template, Sitofait/godot4-save-manager-lite, gaoyuan-taka/godot-action-adventure-skills | GitHub topic page (save-system?l=gdscript) | Not stated on topic page | Godot 4 (topic page) | — | Listed as save-related; not opened | SNIPPET / not opened; skip for now |

### Cited findings
- savestate: "Tested on Windows with Godot 4.5.2, 4.6.3, and 4.7.2," MIT, named save slots, checkpoints, automatic saving — [youssof20/savestate](https://github.com/youssof20/savestate) (VERIFIED)
- CodingQuests save system: "Tested on Godot 4.7.2 stable on Windows," README "Godot 4.7 or later," MIT — [CodingQuests/godot-save-system](https://github.com/CodingQuests/godot-save-system) (VERIFIED)
- saveflow-lite: MIT, "Godot 4.6+" — [indieshade/saveflow-lite](https://github.com/indieshade/saveflow-lite) (VERIFIED; the topic page had said "not stated")
- ShomyKohai quest-system: "MIT license," "Godot 4.4+," resource-based quests — [ShomyKohai/quest-system](https://github.com/ShomyKohai/quest-system) (VERIFIED)
- Rubonnek quest-manager: "MIT license," "Godot 4.2.1+," save/load support — [Rubonnek/quest-manager](https://github.com/Rubonnek/quest-manager) (VERIFIED)
- Input Buffer Combo System listing: "MIT," "Last Updated: 19 October 2026," link to https://github.com/Msumri/combo-tutorial — [Asset Library page](https://store.godotengine.org/asset/whats-code/input-buffer-combo-system/) (VERIFIED on listing)
- Msumri/combo-tutorial: "License name: Not stated on the page"; "No description, website, or topics provided." — [Msumri/combo-tutorial](https://github.com/Msumri/combo-tutorial) (VERIFIED absence of licence)
- The official Cogito GitHub URL (https://github.com/Phazorknight/Cogito) returned HTTP 404; the Codeberg repo is its current home. — VERIFIED

### Inferences
- The savestate and CodingQuests save addons both claim Godot 4.7.2 testing, which matches the DT target. Each is young and unmaintained-looking (2 and 17 commits). Treat them as references and re-test on 4.7.1 before adopting. (inference)
- The Asset Library input-buffer addon and its source repo disagree on licence. Until the author confirms, do not vendor it. Implement input buffering in-house, which is small. (inference)
- Quest systems in this table are data-driven (resources or trees), which fits DT's three progression tracks (experience, story beats, tool knowledge) better than a single flat quest list. (inference)

### Gaps
- Menu and settings addons (not searched in this pass).
- Input buffer / combo addon with a verified licence (none found). Combo systems are out of T1 scope anyway.
- Last-commit dates are not shown on most GitHub repos, so maintenance status is unverified for every save and quest addon.
- No addon was tested in Godot 4.7.1 in this pass.

---

## DT translation: Borrow / Adapt / Enhance / Avoid

| Action | Item | Tier | DT system it serves | Notes |
|---|---|---|---|---|
| Borrow | Kenney City Kit (Industrial) and Factory Kit (CC0; both verified) | T1.5 | Mid and Lower Depths industrial dressing | Formats not listed; check after download |
| Adapt | savestate or CodingQuests save system (MIT; claim 4.7.2) | T1 | Save/load for two-character prototype | Re-test on 4.7.1; treat as reference |
| Adapt | ShomyKohai quest-system or Rubonnek quest-manager (MIT) | T1.5 | Wave-Lock and progression tracks | Check Godot 4.7 compatibility; quest scope may be larger than T1 |
| Adapt | Cogito (MIT, Codeberg) save/load and quest patterns | T2 | Interactables and gated visibility | First-person; study data patterns only |
| Avoid | Msumri/combo-tutorial input-buffer addon | T1 | Input buffering | No licence on source repo despite Asset Library MIT claim |
| Avoid | Any MPFB2 or MakeHuman-generated character | T2 | Custom characters | LICENSE.ASSETS.md conflicts; re-check by hand before any use |
| Avoid | Mixamo animations (until terms are read) | T1 | Animation pipeline | Terms still GAP; the brief's "allowed" line is unverified |
| Avoid | CMU mocap data (until terms are read) | T2 | Motion reference | Terms GAP (503, 404) |
| Avoid | Rokoko and Truebones free packs (until terms are read) | T2 | Motion reference | Terms GAP (404; title-only) |
| Avoid | Fab Standard License items (until read) | T2 | Any Fab item | GAP (403, 503) |
| Avoid | Any godotshaders.com shader with no licence stated | T1.5 | Glitch ladder | Policy requires a licence choice; unlicensed = do not use |
| Avoid | Any Google Font without a checked per-font licence | T1.5 | Augment HUD | OFL 1.1 is the family licence; per-font check still needed |
| Avoid | GD-Sync multiplayer plugin | — | — | Multiplayer backend; out of DT scope |

---

## Sources (opened this session)

- https://github.com/makehumancommunity/mpfb2
- https://raw.githubusercontent.com/makehumancommunity/mpfb2/master/LICENSE.CODE.md
- https://raw.githubusercontent.com/makehumancommunity/mpfb2/master/LICENSE.ASSETS.md (conflicting summary)
- https://godotshaders.com/license/
- https://openfontlicense.org/
- https://codeberg.org/Phazorknight/Cogito
- https://codeberg.org/Phazorknight/Cogito/raw/branch/main/LICENSE
- https://store.godotengine.org/asset/whats-code/input-buffer-combo-system/
- https://github.com/Msumri/combo-tutorial
- https://kenney.nl/assets/city-kit-industrial
- https://kenney.nl/assets/factory-kit
- https://polyhaven.com/all?type=models&c=industrial
- https://store.godotengine.org/search/?q=save+system
- https://github.com/topics/save-system?l=gdscript
- https://github.com/ShomyKohai/quest-system
- https://github.com/Rubonnek/quest-manager
- https://github.com/youssof20/savestate
- https://github.com/CodingQuests/godot-save-system
- https://github.com/indieshade/saveflow-lite

Blocked or failed: https://helpx.adobe.com/creative-cloud/faq/mixamo-faq.html (403); https://www.mixamo.com/faq (404); https://www.fab.com/eula (403); https://mocap.cs.cmu.edu/ (503); http://mocap.cs.cmu.edu/info.php (404); https://www.rokoko.com/integrations/godot (404); https://truebones.gumroad.com/ (title only); https://fonts.google.com/knowledge/glossary/open_font_license (title only); https://opengameart.org/content/faq (403); https://github.com/Phazorknight/Cogito (404); https://github.com/topics (not opened: n/a); web.archive.org (refused by the fetch tool).
