# Deconstructable Study Sources for Metroidvania, Platformer and Action Design

Track 11. Opened and checked on 2026-11-05 unless marked otherwise. Items marked "(snippet only)" come from search results whose page I did not open. Items marked "(unverified)" are claims I could not confirm on a page I opened. Nothing here should be vendored or copied into DT. Use these sources to study design intent, numbers and structure.

## Legal baseline (read first)

- Decompilations and disassemblies (SotN, Super Metroid) are copyrighted work of their publishers. Study design intent, formulas and structure only. Do not copy code, data tables, sprites, level layouts, music or names. Some projects need a legally owned ROM to build; that does not license the code.
- Licence status is per project and must be read on the page itself. Several projects below have no visible licence, which means no reuse rights are granted.

## Key Question 1: Released source code and official toolkits (movement feel, coyote time, jump buffering)

### Takeaway
Official source releases are scarce and partial. The Celeste release is a few class files under MIT, not the full game. The Game Maker's Toolkit Platformer Toolkit is a paid download with no stated licence on its page. Treat both as reference reading, not as code to reuse.

### Cited Findings
- **Celeste (Maddy Thorson / Noel Berry) repo, NoelFB/Celeste.** Opened 2026-11-05. The README says the repo tracks issues and bugs with Celeste and contains "a few of the class files from Celeste" as "a learning resource and for general interest." The page shows an "MIT license" link, and the README says "the MIT License only applies to the code in this repo and does not include the actual commercial Celeste game or assets." Source: [NoelFB/Celeste](https://github.com/NoelFB/Celeste)
- **Celeste Player class, forum and news snippets.** Search snippets describe a roughly 5,400-line Player.cs release from March 2018 and say it is only half the source. The forum link to `Source/Player.cs` is from user posts, not a page I opened. Snippet only: [80.lv article](https://80.lv/articles/celestes-movement-code-available-on-github/?amp=1); [itch devlog](https://itch.io/devlog/729893/celeste-open-source-player-class.amp). Conflict: the README describes "a few class files," while the snippet describes a Player class. Check the repo's file listing before citing either. I did not verify coyote time or jump buffering in the code.
- **Platformer Toolkit (Game Maker's Toolkit / Mark Brown), itch page.** Opened 2026-11-05. Price is "Name your own price." No licence or terms of use is stated on the page. Downloads are Windows, Mac and Linux builds (v1.1), a "Character Controller Unity Scripts" zip (11 kB) and a Unity asset (1.4 MB). The page does not say whether the scripts are full source. Earliest dated devlog shown is "Version 1.1," June 20, 2022. Source: [gmtk Platformer Toolkit](https://gmtk.itch.io/platformer-toolkit)
- **Platformer Toolkit Unity asset, search snippet.** Snippet only: the devlog for the Unity asset ([itch devlog](https://gmtk.itch.io/platformer-toolkit/devlog/455803/unity-asset-now-available) is listed in search results but I did not open it). Snippet describes a stripped character-controller asset. Not verified.
- **Platformia (GPL-3.0), search snippet.** Snippet only: a Unity platformer prototyping toolkit under GPL-3.0, [github.com/artak10t/Platformia](https://github.com/artak10t/Platformia?). Not opened. GPL-3.0 means derivative code must also be GPL. Do not mix into a proprietary DT build.

### Inferences
- The Celeste release is useful for reading how a shipped character controller is structured (state machine, input buffering), but the MIT scope is narrow. Its value for DT is pattern-level study.
- Platformer Toolkit is probably licensed for personal use only, since it is a paid, unlicensed download. Confirm with the author before any use. (inference)

### Gaps
- Could not confirm whether the full Celeste Player class is in the repo, or whether coyote time and jump buffering appear in it. Need to open the repo's `Source` folder listing or the file itself to check.
- Could not confirm whether Platformer Toolkit's character controller is full source. Need the gmtk devlog or the zip contents.

## Key Question 2: Decompilation and disassembly projects (legal caveat applies to all)

### Takeaway
Two projects I opened are useful for formula and structure reading: the SotN decompilation (AGPL-3.0) and the Super Metroid disassembly (no visible licence). Both are legally sensitive. Use them to check design intent only.

### Cited Findings
- **Xeeynamo/sotn-decomp (Castlevania: Symphony of the Night).** Opened 2026-11-05. README: "work-in-progress decompilation" that "aims to recreate the source code from the existing binaries using static and/or dynamic analysis," meant to compile "byte-for-byte to the same binaries." Licence: "AGPL-3.0 license." The repo "does not include any assets or assembly code necessary for compiling the binaries," and "A prior copy of the game is required to extract the required assets." Last commit date not shown on the page; it lists 4,574 commits. Source: [Xeeynamo/sotn-decomp](https://github.com/Xeeynamo/sotn-decomp)
  - Note: AGPL-3.0 is a strong copyleft licence. Any code copied in would require DT to be AGPL. This is a hard reason to avoid copying.
  - Per the brief, SotN systems are covered by another track. Only the study resource is listed here.
- **strager/supermetroid (Super Metroid disassembly, SNES).** Opened 2026-11-05. README: "a disassembly of Super Metroid for the Super Famicom (SNES)." Produces an NTSC ROM, with a SHA-1 digest for verification. The fetched content showed no licence text and no visible LICENSE file in the truncated list. Licence status: unknown, so treat as all rights reserved. Source: [strager/supermetroid](https://github.com/strager/supermetroid)
- **InsaneFirebat/sm_disassembly (Super Metroid), search snippet.** Snippet only: a relocatable disassembly that needs asar v1.81 and the user's own NTSC ROM. Not opened. Source: [awesome.ecosyste.ms listing](https://awesome.ecosyste.ms/projects/github.com%2Finsanefirebat%2Fsm_disassembly)
- **Snesrev Super Metroid PC port (snippet only).** A PC Gamer article says the port "has bugs and the code is messy." Not opened, and the article is older. Source: [PC Gamer](https://www.pcgamer.com/the-same-devs-who-ported-a-link-to-the-past-to-pc-are-reverse-engineering-another-snes-classic)

### Inferences
- For DT, the most useful thing in a disassembly is the documented state machine for a movement or boss state. Read it for structure and then write DT's own version from the principle. (inference)

### Gaps
- Did not open the Super Metroid repo's source files, so I cannot confirm specific movement formulas. Would need to read the physics routines, and only for study.
- No matching-decomp project for other Metroidvania or action games was searched in this session. Candidates to check next: other sotn-decomp forks and ports, and any Hollow Knight or Ori modding datamines. Not researched.

## Key Question 3: Publicly released design documents

### Takeaway
The Doom Bible is a well-known public design document, but I did not open a primary copy. Its main lesson for DT is about story and gameplay tension, which I could only confirm from snippets.

### Cited Findings
- **Doom Bible (Tom Hall, 1992).** Snippet only. Search results describe the bible as Hall's 1992 design document covering plot, backstory and design goals, and report that Carmack felt the story emphasis slowed the game and that Romero wanted it "more brutal and fast." Some ideas were kept and some were reused in Rise of the Triad and Terminal Velocity. Sources disagree on Hall's departure date (July 1993 vs January 1993). Not opened. Source: [Doom Wiki, Doom Bible](https://www.doomwiki.org/wiki/Doom_Bible); [Development of Doom](https://en.wikipedia.org/wiki/Development_of_Doom)
- **Doom Bible licence.** Not established. The document is unlicensed as far as I can see. Do not redistribute copies. Study only.
- **Grim Fandango puzzle document, Deus Ex design docs.** Not searched in this session. Gap.

### Inferences
- The Doom Bible conflict (story-heavy design vs. a fast, brutal game) maps onto DT's pillars: "The world speaks, listen" and the combat-first intent of the GDD. A design doc needs a playable slice to test it, which matches the CLAUDE.md "always end with something running" rule. (inference)

### Gaps
- Need to open the Doom Wiki page to confirm the quotes above before citing them as fact.
- No Metroidvania design document or pitch made public by its developer was searched. Gap.

## Key Question 4: Free GDC Vault talks (Metroidvania level design, platformer feel, cameras, combat, small-team production)

### Takeaway
The GDC Vault free listing I opened shows only about 200 free sessions, with four per section, and none of the free items I could see are Metroidvania, platformer-feel or camera talks. Most relevant talks need a search by title. I did not verify any Metroidvania talk on the GDC Vault.

### Cited Findings
- **GDC Vault free content index.** Opened 2026-11-05. The page labels sections "Free Content" and links to "Show All Free [Event] Content." It does not state in a sentence that every listed item is free. Source: [GDC Vault free](https://www.gdcvault.com/free)
- **Free-listed items with partial relevance (from titles only):**
  - "'Guildlings': Rethinking Mobile Adventure," Jamie Antonisse, Summer 2020 (small-team design).
  - "'Against the Storm' Postmortem," Micha Ogozski, GDC 2024 (small-team production; a small-studio postmortem).
  - "80 DAYS Post-mortem: Letting the Game Tell the Story," Jon Ingold, GDC China 2014 (small-team narrative; relevant to Ingold's GDC 2017 talk already in the Build Resources brief).
  - "10 Questions: Am I Ready to Go Indie?," Don Daglow, GDC 2013 (solo or small-team scope).
  - "'Cuphead' Process and Philosophy," Jake Clark, Showcase 2021 (art pipeline of a run-and-gun game; not design).
  - "3DHaptics" Practical Design Method, Masatoshi Miyakawa, GDC 2024 (loosely relevant to feel and haptics).
  - "Beyond the Border: Designing for Tiny Tina's Wonderlands," Matt Cox, GD Talks (combat design is my guess from the title; unverified).
  - "A Plague Tale" audio design, Aurelien Piters, GDC 2020 (audio, not core).
- **Not found on the free listing:** Metroidvania level design, platformer game feel, 2.5D cameras, God of War or Hi-Fi Rush combat design, rhythm-action design.

### Inferences
- The free listing is not the right place to find Metroidvania talks. Search each title on gdcvault.com and check the paywall state on the talk page before citing. (inference)

### Gaps
- Could not confirm that any Metroidvania level-design talk (Metroid, Hollow Knight, Ori, Axiom Verge, Lost Crown, Dead Cells), platformer feel talk, 2.5D camera talk, God of War or Hi-Fi Rush combat talk, or rhythm-action talk is free. Need to open each on gdcvault.com. Not done in this session.
- Did not check the paywall status of any single talk.

## Key Question 5: Analyses, tools and level-design references

### Takeaway
Mark Brown's Boss Keys series covers Metroid map design and includes a "dependency graph" method that is directly useful to DT's gating design. I did not open the episodes. The Level Design Book and Steve Swink's Game Feel resources were not opened in this session.

### Cited Findings
- **Boss Keys (Mark Brown, GMTK).** Search snippet only. Season 2 (from July 2018) covers Metroid world layout, including Super Metroid, NEStroid, Zero Mission, the Prime series and Metroid Dread. Brown uses a "Dependency Graph" to show how each map is revealed over time. Also covers Hollow Knight world design. Not opened. Source: [Boss Keys overview, Zelda Universe](https://zeldauniverse.net/2017/01/26/explore-zelda-dungeon-design-in-mark-browns-youtube-series-boss-keys/) (snippet only); [GMTK on Wikipedia](https://en.wikipedia.org/wiki/Game_Maker%27s_Toolkit)
- **Metroid world design analysis, search snippet.** [omegametroid.com](https://omegametroid.com/check-out-this-in-depth-world-design-analysis-of-the-metroid-series/) (snippet only). Not opened.
- **Metroidvania Analysis PDF (HSLU, 2021), search snippet.** [blog.hslu.ch PDF](https://blog.hslu.ch/games/files/2021/11/Metroidvania_Analysis.pdf) (snippet only). Likely a student paper on map or lock-and-key analysis; not opened.
- **Level Design Book (book.leveldesignbook.com)** and **Steve Swink's Game Feel**: not searched or opened in this session. Gap.

### Inferences
- A dependency graph for DT's Deep-City layers (about 250 m of staggered levels) is a sensible T2 tool. For T1's 3-5 rooms, a hand-drawn graph is enough. (inference)

### Gaps
- Need to open the Boss Keys Metroid episodes to confirm the graph method and its notation.
- Need to open the Level Design Book and Game Feel resources, and check their licences (the book is likely all-rights-reserved; check).

## Key Question 6: Postmortems of Metroidvanias and small-team action games

### Takeaway
Not researched in depth. The GDC free listing gives one small-studio postmortem (Against the Storm), but none of the Metroidvania postmortems I would expect were verified.

### Cited Findings
- "'Against the Storm' Postmortem," GDC 2024, Micha Ogozski, Eremite Games. Title from the GDC free listing. [GDC Vault free](https://www.gdcvault.com/free). Talk body not opened.
- "80 DAYS Post-mortem," GDC China 2014, Jon Ingold. Title from the GDC free listing. Talk body not opened.

### Gaps
- No Game Developer postmortem for a Metroidvania, Hollow Knight, Ori, Axiom Verge or Dead Cells was opened. Need a targeted search on gamedeveloper.com.

## DT Translation: Borrow / Adapt / Enhance / Avoid

| Action | Item | Tier | DT system tied to | Notes |
|---|---|---|---|---|
| Borrow | Read Celeste's MIT-licensed class files for controller structure (state machine, input handling), then write DT's own | T1 | Movement: running, jumping, plane-locked CharacterBody3D | Verify the files exist in the repo first; MIT applies only to repo code. Do not copy. |
| Borrow | Use the Boss Keys dependency-graph method to draw the T1 room graph | T1 | Map and gating (3-5 rooms) | Method only. Do not reuse Brown's drawings or episodes. |
| Adapt | Dependency graph scaled to the Deep-City's ~250 m vertical layers and Upper, Mid, Lower Depths | T2 | World: vertically stratified Deep-City | Plan for T2 after the T1 slice runs. |
| Adapt | Doom Bible lesson on story versus gameplay tension, applied to DT's combat-first slice | T1 | Pillars: "The world speaks, listen"; Narrative (Wave-Lock) | Keep story beats playable and tested early. |
| Enhance | Build a playable slice before writing more design docs | T1 | Session rule in CLAUDE.md | Matches the Doom Bible lesson and the "always end with something running" rule. |
| Enhance | Study a free GDC small-team postmortem (Against the Storm, 80 DAYS) before production planning | T2 | Production and scope (solo developer, T2 at 2-4 years) | Only after verifying the talk pages are free. |
| Avoid | Copying any code, data, sprites or layouts from sotn-decomp | T1 | Combat, SotN reference | AGPL-3.0 would bind DT to copyleft. Study formulas only. |
| Avoid | Copying from strager/supermetroid | T1 | Movement, map reference | No visible licence; treat as all rights reserved. |
| Avoid | Shipping the Platformer Toolkit scripts or asset | T1 | Movement | No licence stated on the page; paid, name-your-price download. Ask the author first. |
| Avoid | Mixing Platformia (GPL-3.0) into DT | T1 | Movement | Copyleft; would force GPL on DT code. |
| Avoid | Relying on the GDC free listing for Metroidvania talks | T1 | Research process | None of the target talks were verified as free. |

## Sources opened in this session (2026-11-05)

- [NoelFB/Celeste](https://github.com/NoelFB/Celeste)
- [Xeeynamo/sotn-decomp](https://github.com/Xeeynamo/sotn-decomp)
- [strager/supermetroid](https://github.com/strager/supermetroid)
- [gmtk Platformer Toolkit (itch)](https://gmtk.itch.io/platformer-toolkit)
- [GDC Vault free content](https://www.gdcvault.com/free)

Search results only (snippet, not opened): Celeste Player snippet articles, Doom Wiki, Platformia, InsaneFirebat/sm_disassembly, Snesrev PC Gamer article, Boss Keys overview, omegametroid, HSLU Metroidvania Analysis PDF.

## Overall gaps

- No GDC Metroidvania, platformer-feel, camera or combat talk verified as free. Largest gap for this track.
- Level Design Book and Game Feel not opened.
- No Game Developer postmortem for a Metroidvania opened.
- No Metroidvania design document made public by a developer searched.
- Coyote time and jump buffering not verified in any opened source.
