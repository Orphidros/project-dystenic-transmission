# Free and permissively licensed 3D assets for DT prototyping

Accessed 2026-11-05 unless noted. Scope: characters/rigs, environment kits, props, materials/HDRIs, VFX/shaders, UI/fonts, Fab free content. Audio and the Quaternius Universal Animation Library are excluded (already covered).

**Verification key.** "VERIFIED" means the licence was quoted from a page I opened this session. "LISTING ONLY" means the pack name appeared on an index page I opened, but I did not open its own page. "GAP" means the source could not be read or the licence was not on the page.

---

## Key questions

### Q1. Characters and rigs (placeholder band members, Vox, Ciphera)

### Takeaway
KayKit Adventurers is the strongest verified free character candidate: CC0, rigged and animated, with FBX and glTF. Its skeleton type is not stated, so Mixamo or Godot humanoid retargeting compatibility is unverified. The Mixamo terms and MakeHuman/MPFB output terms could not be verified this session.

### Cited findings
- KayKit - Character Pack: Adventurers (itch.io). Licence quoted: "Creative Commons Zero v1.0 Universal" and "Free for personal and commercial use, no attribution required. (CC0 Licensed)". Formats: FBX and GLTF. Described as "fully rigged and animated" and "compatible with KayKit Character Animations". VERIFIED — [KayKit Adventurers](https://kaylousberg.itch.io/kaykit-adventurers)
- The KayKit itch index lists 21 "Pay $0 or more" packs (free with optional tip). These include Character Animations, Skeletons, Dungeon, Platformer, Mixed Bag 1 and 2, and many "Bits" packs. I did not open each page, so their licences are LISTING ONLY. — [KayKit index](https://kaylousberg.itch.io/)
- KayKit's index lists six "Legacy" packs, which the page calls outdated: Spooktober, Mini Game Variety, Medieval Builder, Dungeon, Skeleton Pack, and Character Animations. Use the current versions instead. LISTING ONLY.
- The KayKit index page itself contains no licence text, so the licence must be read on each pack page. VERIFIED ON PACK PAGE ONLY for Adventurers.
- Quaternius "Universal Base Characters" is listed on the Quaternius index. LISTING ONLY. Also listed: "Modular Character Outfits - Fantasy", "Ultimate Modular Men Pack", "Ultimate Modular Women Pack", "Background Posed Humans Pack", "Animated Man Pack" and "Animated Woman Pack". All LISTING ONLY. — [Quaternius index](https://quaternius.com/)
- Quaternius index: the page has no licence text. The "License" nav link was not readable. Per-pack CC0 is verified on the two pack pages below. — [Quaternius index](https://quaternius.com/)
- Mixamo: the page I fetched rendered only "Loading Mixamo" and no terms. Adobe's general terms page contains no Mixamo clause. Mixamo's commercial-use and redistribution terms are GAP. The DT brief says Mixamo is allowed; that is not verified here. — [Mixamo](https://www.mixamo.com/#/) (GAP)
- MakeHuman licence page returned HTTP 503. MPFB2 page (static.makehumancommunity.org/mpfb.html) names no licence and its FAQ answers on selling models and closed-source games are not shown. Output terms for MPFB-generated characters are GAP. — [MPFB](https://static.makehumancommunity.org/mpfb.html) (GAP)

### Inferences
- KayKit Adventurers (CC0, FBX+glTF) is a good first placeholder for Vox or a crowd NPC. It is safe to use in a commercial game without credit, though the page asks users not to "resell unmodified copies or claim them as your own".
- Skeleton compatibility must be checked on import. Compare bone names and hierarchy with Godot's humanoid retarget profile, or with a Mixamo naming map. (inference)
- MPFB output terms should not be assumed CC0 until the official FAQ is read. (inference)

### Gaps
- Mixamo commercial and redistribution terms, from a readable source (blocked/empty pages).
- MakeHuman and MPFB2 licence and output terms (503 and empty content).
- KayKit Adventurers skeleton type (not stated).
- Mannequin/placeholder pack with glTF confirmed. None verified.
- DT scope note: T1 is Vox and Ciphera only. Placeholders for Serratrix-9, Metronome and Gravicus are T2+ work and should not be built for T1 without confirmation.

---

### Q2. Environment kits and props (industrial, sci-fi, cyberpunk, sewer, ruin, tunnel, urban decay)

### Takeaway
Quaternius "Cyberpunk Game Kit" (CC0, 71 models, FBX/OBJ/Blend/glTF) is the best verified direct match for DT's urban cyberpunk kit. Kenney's industrial and cave kits are CC0 at site level; their pack pages were not all opened. No verified sewer, rubble or decay pack yet.

### Cited findings
- Quaternius "Cyberpunk Game Kit". Licence quoted: "CC0", with "free to use in personal and commercial projects." Attribution line "© Quaternius". 71 models. Formats: FBX, OBJ, Blend, glTF. VERIFIED — [Cyberpunk Game Kit](https://quaternius.com/packs/cyberpunkgamekit.html), released per page.
- Quaternius "Ultimate Modular Ruins Pack". Licence: CC0, "free to use in personal and commercial projects". 90 models, released August 2021. Formats: FBX, OBJ, Blend. No glTF listed on this page. VERIFIED — [Ultimate Modular Ruins](https://quaternius.com/packs/ultimatemodularruins.html)
- Quaternius download buttons on both pack pages link to a placeholder anchor (#inline), so direct download URLs were not confirmed. Patreon tiers offer discounted "Source" kits. VERIFIED on pages.
- Quaternius index also lists "Downtown City MegaKit", "Sci-Fi Essentials Kit", "Modular Sci-Fi Megakit", "Ultimate Modular Sci-Fi Pack", "Modular Streets Pack", "Modular Platformer Pack" and "Sci-Fi Modular Gun Pack". All LISTING ONLY. — [Quaternius index](https://quaternius.com/)
- Kenney licence (site support page): "Yes, all game assets on the asset pages are public domain licensed (CC0)." Attribution: "Attribution is not required", and commercial use is allowed. VERIFIED — [Kenney support](https://kenney.nl/support)
- Kenney "Modular Space Kit". Licence: "Creative Commons CC0". 40 files. The page does not list formats or poly counts. VERIFIED — [Modular Space Kit](https://kenney.nl/assets/modular-space-kit)
- Kenney 3D category index lists "City Kit (Industrial)", "Factory Kit", "Modular Cave Kit", "Graveyard Kit", "Car Kit", "Platformer Kit" and "Pirate Kit". LISTING ONLY. Their CC0 status rests on the site-level statement above. — [Kenney 3D category](https://kenney.nl/assets/category:3D)
- Poly Haven models: 14 categories, including "Industrial & Infrastructure" ("Industrial, utility and infrastructure objects"). No individual sewer, rubble or sci-fi model was visible, and glTF was not mentioned on the page. VERIFIED category list only — [Poly Haven models](https://polyhaven.com/models)

### Inferences
- Quaternius Cyberpunk Game Kit is a plausible greybox source for T1 Deep-City room dressing. Its visual style may not fit the author's art direction, so treat it as placeholder. (inference)
- Because some Quaternius packs omit glTF, prefer packs that list glTF or convert FBX to GLB in Blender before import. (inference)

### Gaps
- No verified sewer, tunnel, rubble or decay kit. Poly Haven shows industrial objects but no confirmed rubble or scanned debris.
- Open Kenney "City Kit (Industrial)" and "Factory Kit" pages to confirm formats and file counts.
- OpenGameArt was blocked (403), so its sci-fi or ruin packs are not covered.
- Itch free-tag search was not run, so no itch environment packs are verified.
- Scanned debris and rubble: no verified free source this session.

---

### Q3. Materials, textures and HDRIs

### Takeaway
Poly Haven, ambientCG and cgbookcase are all CC0 with no attribution required, verified on their own pages. ShareTextures states "copyright-free" wording without naming CC0 in the body, so check its licence page before use.

### Cited findings
- Poly Haven licence page: "Our assets are all licensed as CC0", covering HDRIs, textures and 3D models. Terms of Service carve-outs apply to logos, renders and site text. "You do not need to give credit." VERIFIED — [Poly Haven licence](https://polyhaven.com/license)
- ambientCG: "All assets are released under the Creative Commons CC0 license" and "free to use without attribution - even in commercial circumstances." Types: PBR surfaces (atlas, material, decal), HDRIs (hdri, hdri-element), Substances, 3D assets (3d-model, terrain). VERIFIED — [ambientCG](https://ambientcg.com/)
- cgbookcase: "The textures are published under the CC0 1.0 license, which means means you can use them for free without giving credit." Categories include Concrete, Metal, Rock, Walls, Road, Paving, Surface Imperfections and Tiles. PBR photogrammetry sets are listed, but the individual map channels are not confirmed. VERIFIED — [cgbookcase textures](https://cgbookcase.com/textures)
- ShareTextures: "All of our content is copyright-free. It means, you can use them anywhere you want which includes commercial projects too." The page title is "CC0 Textures & Models". VERIFIED wording; CC0 not stated in the body. Artwork credit line only. — [ShareTextures](https://sharetextures.com/)
- Kenney "Sci-Fi UI" elements are listed under VFX/UI below. Not a texture source.

### Inferences
- Concrete, metal, rock and wall surfaces from ambientCG and cgbookcase cover most of the DT sewer, tunnel and industrial material needs. (inference)
- Grime and leak decals: ambientCG lists a "Decal" type, but no grime or leak decal set was opened. Treat decal coverage as unverified. (inference)

### Gaps
- Decal sets for grime, leaks and wear: not verified in any individual pack.
- ShareTextures licence page not opened, so CC0 status is unconfirmed.
- Map channel lists (albedo, normal, roughness, etc.) for individual ambientCG and cgbookcase sets were not read.

---

### Q4. VFX, shaders and particles

### Takeaway
Kenney Particle Pack is CC0 (80 files, 512x512 tile, tagged particle, shader, vfx) and is the only verified VFX pack this session. godotshaders.com licences are per shader and were not verified. The licence page is not readable from the index.

### Cited findings
- Kenney particle pack. Licence: "Creative Commons CC0". 80 files, 512x512 tiles. The page does not name the smoke, spark, flame or star textures, so check the download contents. VERIFIED — [Kenney particle pack](https://kenney.nl/assets/particle-pack)
- Kenney "UI Pack: Sci-Fi". Licence: "Creative Commons CC0". 130 files. Tags: buttons, panels, sliders, space and sci-fi interface. Progress bars, icons and fonts are not confirmed on the page. VERIFIED — [Kenney Sci-Fi UI](https://kenney.nl/assets/ui-pack-sci-fi)
- godotshaders.com: the footer links to a licence page, but its content was not read. The page shows no per-shader licence. VERIFIED that per-shader licence is not stated on the index. — [godotshaders](https://godotshaders.com/)
- One listed shader matches a cyberpunk theme: "Bomb Rush Cyberfunk - Hippie Bands (spatial)". Listed on index; not opened. Licence: GAP. — [Bomb Rush Cyberfunk shader](https://godotshaders.com/shader/bomb-rush-cyberfunk-hippie-bands/) (snippet only)
- Sketchfab: "free downloads are available under Creative Commons licenses" (general phrase). No filter names (CC0, CC-BY, CC-BY-NC) were shown on this page. Per-model licences must be read on each model. VERIFIED (general statement only) — [Sketchfab free models](https://sketchfab.com/features/free-3d-models)

### Inferences
- Glitch and strobe effects for the "glitch ladder" can be built with shaders from scratch using the Kenney particle textures and a screen shader. No licence risk if written in-house. (inference)
- Any godotshaders.com item must be checked individually for licence before use; a missing licence means no reuse. (inference)

### Gaps
- godotshaders.com licence page (not read).
- Individual shader licences (none opened).
- Free flipbook packs: none verified.
- Sketchfab CC-BY and CC-BY-NC filter results not confirmed (page shows no filters).

---

### Q5. UI and fonts

### Takeaway
Kenney Sci-Fi UI Pack is CC0 and verified. No font licence was verified this session: both Google Fonts pages returned no licence text, so OFL is not confirmed from source.

### Cited findings
- Kenney Sci-Fi UI Pack, CC0, 130 files (see Q4). VERIFIED.
- Google Fonts "Share Tech Mono" page opened. Returned title only; no licence or designer shown. GAP — [Share Tech Mono](https://fonts.google.com/specimen/Share+Tech+Mono)
- Google Fonts glossary "Open Font License" page opened. Returned title only; OFL terms not quoted. GAP — [Google Fonts glossary](https://fonts.google.com/knowledge/glossary/open_font_license)

### Inferences
- Google Fonts are generally OFL, but this is an inference from general knowledge, not from a verified page this session. Confirm the OFL terms and each font's licence before shipping. (inference)

### Gaps
- Font licences (none verified). Candidate fonts for a diegetic augment HUD have not been checked.

---

### Q6. Fab (fab.com) free monthly content and licence scope

### Takeaway
Not verified. The Fab FAQ returned HTTP 403, and the Fab home page returned HTTP 503. I could not confirm which free items carry the Standard License. DT's brief says only Standard License content is allowed, so every Fab item must be checked before use.

### Cited findings
- Fab FAQ: HTTP 403 Forbidden. GAP — [Fab FAQ](https://www.fab.com/faq)
- Fab home: HTTP 503 Service Unavailable. GAP — [Fab](https://www.fab.com/)
- The Sketchfab free-models page states that "thousands of royalty-free models are available to license on Fab, a separate paid marketplace." VERIFIED on that page. — [Sketchfab free models](https://sketchfab.com/features/free-3d-models)

### Inferences
- Fab items should be treated as UE-only until the item's own licence page states the Standard License. (inference)

### Gaps
- Fab free monthly list, licence type per item, and whether the Standard License allows use outside Unreal Engine. Retry later or read the Fab item pages individually.

---

## Flags

- **AI-generated provenance:** none of the verified packs claim AI generation, but I did not check for it. Confirm provenance on any pack before use.
- **Non-commercial or attribution-required:** none found among verified items. Quaternius and Kenney pages show "© " credit lines, but CC0 does not require credit. Keep credits as a courtesy (inference).
- **Itch "$0 or more":** these packs are free with an optional tip. The price field does not state the licence. Read each pack page.
- **Legacy KayKit packs:** the index marks them outdated.
- **Mixamo:** DT's brief lists it as allowed; I could not verify its terms this session.
- **MPFB / MakeHuman:** output licence unverified; do not ship generated characters until read.
- **Godot 4.7 compatibility:** not stated on any verified pack page. Unverified for all items.

---

## DT translation: Borrow / Adapt / Enhance / Avoid

| Item | Action | Tier | DT system | Note |
|---|---|---|---|---|
| Quaternius Cyberpunk Game Kit (CC0, glTF) | Borrow | T1 | Deep-City room dressing; Wave-Lock prototype map (3-5 rooms) | Placeholder greybox; check style fit with author's art direction |
| KayKit Adventurers (CC0, FBX+glTF, rigged) | Borrow | T1 | Vox or Ciphera placeholder body | Check skeleton against Godot humanoid profile |
| ambientCG and cgbookcase CC0 surfaces | Borrow | T1 | Industrial and sewer materials | No licence risk; check map channels |
| Poly Haven CC0 HDRIs | Borrow | T1 | Lighting for dying-sun and sewer scenes | Use for lighting setup only |
| Kenney Particle Pack (CC0) | Borrow | T1 | Basic hit and augment VFX | Verify contents before use |
| Kenney Sci-Fi UI Pack (CC0) | Adapt | T1 | Diegetic augment HUD base | Restyle to match DT visuals |
| Quaternius Ultimate Modular Ruins (CC0, no glTF) | Adapt | T1.5 | Ruin and decay kit for later rooms | Convert FBX to GLB in Blender first |
| Kenney Industrial / Factory kits (CC0 at site level) | Adapt | T1.5 | Industrial stratum (Mid and Lower Depths) | Pack pages not yet opened |
| Quaternius placeholder mannequins for Serratrix-9, Metronome, Gravicus | Avoid for now | T2 | Band members beyond Vox and Ciphera | Out of T1 scope; do not build without confirmation |
| Mixamo animations | Avoid until verified | T1 | Animation pipeline | Terms not verified; DT brief says allowed |
| MPFB / MakeHuman characters | Avoid until verified | T2 | Custom character generation | Output licence unverified |
| godotshaders.com items (per-shader licence) | Avoid until checked | T1.5 | Glitch ladder shaders | Check each shader's licence; build in-house if unclear |
| Fab Standard License content | Avoid until verified | T2 | Any Fab item | Only Standard License allowed; not verified this session |
| Google Fonts / OFL HUD font | Avoid until verified | T1.5 | Diegetic augment HUD font | Licence not read this session |
| Kenney Modular Cave Kit, Graveyard Kit (listing only) | Adapt | T2 | Cavernous chambers, tunnels | Pack pages not opened |
| Quaternius Downtown City MegaKit, Modular Streets (listing only) | Adapt | T2 | Urban decay streets (Upper Depths) | Pack pages not opened |

---

## Sources (opened this session)

- https://kenney.nl/assets/category:3D
- https://kenney.nl/support
- https://kenney.nl/assets/modular-space-kit
- https://kenney.nl/assets/particle-pack
- https://kenney.nl/assets/ui-pack-sci-fi
- https://quaternius.com/
- https://quaternius.com/packs/cyberpunkgamekit.html
- https://quaternius.com/packs/ultimatemodularruins.html
- https://kaylousberg.itch.io/
- https://kaylousberg.itch.io/kaykit-adventurers
- https://polyhaven.com/license
- https://polyhaven.com/models
- https://ambientcg.com/
- https://cgbookcase.com/textures
- https://sharetextures.com/
- https://www.mixamo.com/#/ (empty)
- https://www.adobe.com/legal/terms.html (no Mixamo clause)
- https://static.makehumancommunity.org/mpfb.html (no licence text)
- https://fonts.google.com/specimen/Share+Tech+Mono (no licence text)
- https://fonts.google.com/knowledge/glossary/open_font_license (no licence text)
- https://godotshaders.com/ (no licence text)
- https://sketchfab.com/features/free-3d-models (general CC statement)

Blocked or failed: https://www.fab.com/faq (403), https://www.fab.com/ (503), https://www.makehumancommunity.org/content/licenses.html (503), https://opengameart.org/content/license-faq (403).
