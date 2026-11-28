# Public repo scout: game, sound, visual, design and engineering

**From:** a Claude Code session, 2026-11-28 · **For:** Systems & Code, Assets & Pipeline, Audio & SFX, Lore & Story and Design · **Status:** research, not a ruling. Nothing here is installed.

## Method

- **Discovery:** Firecrawl's developer search, which covers public repos, READMEs, GitHub issues and pull requests, and agent-skill files. Plain web search filled the gaps.
- **Vetting:** GitHub's search API on 2026-11-28 gave stars, license, last push and archived status. The README was read where fit with DT was uncertain.
- **Not checked:** whether each project runs on Godot 4.7.2, unless stated. Test any plugin in a throwaway branch before it goes into `addons/`.

## Rules applied

- **Licenses.** MIT, ISC and CC0 can ship in the game. GPL tools are fine when only their output reaches DT, such as a synth's audio or a Blender add-on's mesh, but GPL code is never linked into the game. Models under non-commercial licenses are flagged.
- **Supply chain.** Same as the Firecrawl rule: pin an exact version or commit that is at least two weeks old. Read any MCP server or agent skill before installing it, because both run code on your machine.
- **Scope.** Tier tags follow CLAUDE.md's scope mirror. Anything marked Tier 1.5+ is for study now, not building.
- **Originality.** Starter kits and demos are for learning techniques. Their levels and art don't come into DT.

**Tags:** **T1** = useful for Tier 1 work now · **T1.5+** = later tier · **Tool** = used to make things, never shipped · **Study** = read for ideas, don't install.

## Top picks for Tier 1

| # | Repo | Why DT wants it | Next step |
|---|---|---|---|
| 1 | Coding-Solo/godot-mcp | Lets Claude Code launch the project on your PC and read its errors. That is the loop the "always end with something running" rule needs. | Trial on the PC, pinned. Check 4.7.2: the last push was in April. |
| 2 | Blender Lab MCP (official) | The Blender Foundation's own server. It bundles searchable copies of the Blender Python API and the manual, so fewer scripts call APIs that don't exist. | Compare with the community MCP for Blender that dt-blender-art uses now. |
| 3 | ramokz/phantom-camera | Cinemachine-style cameras for 3D. Path follow suits a side-view rail camera, priorities give per-room cameras, and transitions are tweened. Matches the REPLACED camera goal. | Try on the greybox once the rooms exist. Keep it plane-locked. |
| 4 | qwqzhanqwq/Godot-CSG-Blockout | Greybox rooms from stock CSG nodes, with jump-height and gap checks against the player's numbers. | Use for the 3–5 greybox rooms. Feed it Vox's and Ciphera's jump values. |
| 5 | GDQuest/GDScript-formatter | A fast GDScript formatter, updated two days ago. Low-risk tidiness. | Systems & Code decides whether formatting is enforced. |
| 6 | Maaack/Godot-Game-Template | Options and pause menus with input remapping. DT needs both: the calibration slider lives in the options menu, and the input map stays rebindable (O-01). | Study and borrow pieces. Don't adopt the template. |
| 7 | EL4CTEO/blender-skills | 28 tested Blender 5.3 agent skills: Godot export, Rigify game skeletons, asset QA, retopology and UVs. | Mine into dt-blender-art. Don't install wholesale. |
| 8 | abarichello/godot-ci or chickensoft-games/setup-godot | Headless Godot in GitHub Actions. | Waits for the author's answer to the replay proposal's CI question (CoD-17 proposal, Q4). |

## Agent tooling: MCP servers and skills

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| Blender Lab MCP (projects.blender.org/lab/blender_mcp) | not on GitHub | GPL-3.0-or-later (reported) | v1.0.3 | Official server, Blender 5.1 or later. Scene and object summaries, screenshots, renders, and a search over the bundled API docs and manual. | T1, Tool |
| ahujasid/mcp-for-blender | 36,066 | MIT | 2026-11-26 | The community server once called blender-mcp. It renamed itself on 2026-09-16 so it wouldn't be confused with the official one. If dt-blender-art says "blender-mcp", it means this. | T1, Tool |
| EL4CTEO/blender-skills | 3,012 | MIT | 2026-11-27 | 28 skills, every script tested in Blender. Overlaps dt-blender-art. | Study |
| Coding-Solo/godot-mcp | 6,801 | MIT | 2026-04-16 | Launch the editor, run the project, read debug output, edit scenes. | T1, Tool |
| HazielCC/godot-mcp (a fork) | 1 | MIT | 2026-11-16 | Adds whole-project script checks, headless GUT runs and a play-and-screenshot check. One maintainer. | Study |
| ziva-sh/godot-skills | 0 | MIT | Nov 2026 | Six Godot 4 skills. Every snippet is parse-checked on Godot 4.7.2, a test method worth copying into dt-godot. | Study |
| thedivergentai/game-dev-agentic-skills (also linked as GD-Agentic-Skills) | about 970 (skills.sh) | not verified | 2026 | A hub of 92 Godot 4.7 skills. Too big to load whole; read only the parts you need. | Study |
| vl4dt/godot-skills | 33 | MIT | 2026-08-25 | 12 Godot skills, including a migration guide to 4.7. | Study |

**Blender Lab's own warning, quoted exactly from blender.org:** "The MCP server will execute LLM generated code in Blender without any guards in place to protect your data from removal or being sent to a remote location. To keep your data safe it is recommended to use a virtual machine, or a system without access to sensitive information." The community server runs code the same way.

At minimum, keep `.blend` files under version control or backed up. Run Blender under an account that can't reach personal files.

**DT already has its own skills:** dt-godot (OQ-137) and dt-blender-art. Third-party skills are a source of fixes and checks to fold in, not replacements. If two skills cover the same topic, the agent may load the wrong one.

## Engineering

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| godot-gdunit-labs/gdUnit4 | 1,319 | MIT | 2026-11-23 | A test framework, moved from MikeSchulze/gdUnit4. Its GitHub Action is godot-gdunit-labs/gdUnit4-action. | Study |
| bitwes/Gut | 2,797 | MIT (GitHub doesn't detect the file; check) | 2026-08-18 | A test framework. | Study |
| GDQuest/GDScript-formatter | 498 | MIT | 2026-11-26 | Formatter. | T1, Tool |
| Scony/godot-gdscript-toolkit | 1,629 | MIT | 2025-10-09 | Linter and formatter. Check that it parses 4.7 syntax. | Tool |
| abarichello/godot-ci | 1,159 | MIT | 2026-10-20 | Docker image and CI templates. | Tool |
| chickensoft-games/setup-godot | 189 | MIT | 2026-11-10 | GitHub Action that sets up headless Godot. | Tool |
| godotengine/godot-git-plugin | 967 | MIT | 2026-10-21 | Git inside the editor. Optional. | Tool |
| godotengine/godot-demo-projects | 9,849 | MIT | 2026-11-25 | Official demos. Good reading for a first Godot project. | Study |

**The test runner:** DT's own `tests/run_tests.gd` (110 checks) works and matches the replay proposal. Moving to GUT or gdUnit4 is a Systems & Code decision for when the suite outgrows it; there's no reason to switch now.

## Game systems

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| ramokz/phantom-camera | 3,680 | MIT | 2026-11-22 | 3D cameras. Follow modes: Glued, Simple, Group, Path, Framed, Third Person. Priority switching, tweened transitions. README names Godot 4.4+. | T1 |
| Maaack/Godot-Game-Template | 1,761 | MIT | 2026-11-24 | Menus, options, pause, credits, scene loader. | Study (T1) |
| nathanhoad/godot_input_helper | 1,122 | MIT | 2025-06-08 | Device detection and rebinding. Not updated for 17 months. | Study |
| derkork/godot-statecharts | 1,634 | MIT | 2026-06-26 | Statecharts for the character states (Switching, Beat-State, and later Death and Dialogue). A hand-written state machine may be enough at Tier 1. | Study |
| limbonaut/limboai | 3,148 | MIT | 2026-10-30 | Behavior trees and state machines. A C++ extension, so it needs a build that matches 4.7.2. | T1.5+ |
| bitbrain/beehave | 3,335 | MIT | 2026-09-20 | Behavior trees in plain GDScript. Tier 1 enemies have one attack each, so this is for later. | T1.5+ |
| godot-extended-libraries/godot-debug-menu | 674 | MIT | 2025-11-19 | FPS and frame-time overlay, a fit for the F3 debug overlay. Goes in the `dev_tools` module once that exists; no new developer switches before then (author, 2026-11-21). | Later, in `dev_tools` |
| KoBeWi/Metroidvania-System | 1,607 | MIT | 2026-10-23 | Map editor, minimap, room transitions, save data as a Dictionary. Built for **2D grid** games and needs Godot 4.6+. Not drop-in for DT's 3D rooms; its data model is worth reading. | Study |
| KenneyNL/Starter-Kit-3D-Platformer | 1,286 | MIT | 2026-03-12 | A CharacterBody3D controller to compare against. | Study |

**Skipped:** Ark2000/PankuConsole and AdamKormos/SaveMadeEasy. Neither has been updated since January 2025. Tier 1's minimal save doesn't need a plugin.

## Level design (greybox)

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| qwqzhanqwq/Godot-CSG-Blockout | 124 | MIT | 2026-10-17 | Godot 4.6+. Draw rooms in one drag, cut doors, check jumps and slopes against player numbers, freeze rooms to meshes and back, send to Blender as `.glb`. Uses stock CSG nodes, so removing the plugin leaves scenes intact. | T1 |
| blackears/cyclopsLevelBuilder | 1,667 | MIT | 2026-10-28 | The better-known blockout tool, with its own mesh blocks. | T1 (alternative) |
| func-godot/func_godot_plugin | 904 | MIT | 2026-11-14 | TrenchBroom `.map` import. Overkill for a 2.5D plane. | Skip |
| HungryProton/scatter | 3,046 | MIT | 2026-09-27 | Scatters props across an area. For the art pass, not greybox. | T1.5+ |

**Plane lock:** whichever tool is used, room depth stays inside the locked depth band (CLAUDE.md, Architecture). CSG Blockout's first-person "Play From Here" mode doesn't apply to a side view.

## Sound

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| michaelgundlach/rhythm_notifier | 66 | MIT | 2025-09-12 | Beat signals that allow for output latency. Compare its timing math with `MusicDirector`. Not a replacement, since `BeatState` is tested against stricter needs. | Study |
| timothyqiu/gdfxr | 199 | MIT | 2024-08-21 | sfxr sound generator inside the editor. Could make placeholder scratch and buzz sounds. Old, so check on 4.7.2. `placeholder_audio.gd` already makes these sounds. | T1, Tool (maybe) |
| surge-synthesizer/surge | 4,176 | GPL-3.0 | 2026-11-27 | Surge XT, a free synth for the Audio & SFX thread. Sounds made with it belong to DT. | Tool |
| librosa/librosa | 9,222 | ISC | 2026-11-25 | Offline tempo, beat and onset analysis. Checks that a real track's beat grid matches its passages. Real tracks are Tier 1.5+. | T1.5+, Tool |
| aubio/aubio | 3,793 | GPL-3.0 | 2026-04-10 | Command-line beat and onset trackers. | T1.5+, Tool |
| CPJKU/madmom | 1,746 | code BSD; models said to be CC BY-NC-SA | 2026-03-20 | Strong beat tracking, but check the model license before using it in a commercial pipeline. | Flagged |
| Draganoider/Beatex | 2 | MIT | 2026-11-04 | Finds the hits a player would feel in a song, using a model trained on human osu! maps. Interesting, but the training data's origin and the project's age (2 stars) both say wait. | Watch |
| utopia-rise/fmod-gdextension | 962 | bindings open; FMOD proprietary | 2026-11-07 | Audio middleware. Belongs with the 3-state adaptive audio machine, which is out of Tier 1. Read FMOD's terms. | T1.5+ |
| alessandrofama/wwise-godot-integration | 455 | bindings open; Wwise proprietary | 2026-11-25 | As above, for Wwise. | T1.5+ |
| nathanhoad/godot_sound_manager | 839 | MIT | 2026-03-29 | A simple music and SFX player. | Optional |

**Primary source for audio timing:** the Godot 4.7 manual's "Sync the gameplay with audio and music".

**Licensed sound libraries:** Firecrawl's provider catalogue can search Openverse (CC-licensed audio, filterable to commercial use), BigSoundBank (no attribution needed) and ccMixter. That's useful to Audio & SFX for licensed placeholders.

## Visual

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| RodZill4/material-maker | 6,345 | MIT | 2026-11-27 | Procedural textures and painting, built on Godot. | T1.5+, Tool |
| VAST-AI-Research/UniRig | 2,421 | MIT (code) | 2026-06-04 | AI auto-rigging (SIGGRAPH 2025). Check the weights' license, and the Project's stance on AI in assets, before using it. | Study, flagged |

Cel-shading and all shader work are out of Tier 1, so shader collections wait. Firecrawl's catalogue also reaches ambientCG for CC0 PBR textures.

## Design and narrative

| Repo | Stars | License | Last push | Use in DT | Tag |
|---|---|---|---|---|---|
| nathanhoad/godot_dialogue_manager | 4,008 | MIT | 2026-11-25 | Nonlinear dialogue in GDScript, the natural fit for a GDScript project. The Dialogue state is Tier 1.5+. The Tier 1 micro-choice is shown by tone alone (O-48) and needs no dialogue system. | T1.5+ |
| dialogic-godot/dialogic | 6,194 | MIT | 2026-11-19 | Heavier, visual-novel style. | T1.5+ |
| inkle/ink | 5,094 | MIT | 2026-11-16 | Narrative scripting language. | Study |
| paulloz/godot-ink | 793 | MIT | 2026-07-04 | Ink for Godot. Reportedly needs Godot's .NET build; check. | Flagged |
| YarnSpinnerTool/YarnSpinner-Godot | 219 | MIT | 2026-10-22 | C# only, so it doesn't fit a GDScript project. | Skip |
| mhgolkar/Arrow | 1,379 | MIT | 2025-09-05 | Narrative design tool for branch graphs, built on Godot. For Lore & Story. | Study |
| obsidianmd/jsoncanvas | 4,015 | MIT | 2026-07-24 | The open spec behind Obsidian `.canvas` files. A small script could check branch maps for dead ends and unreachable scenes, which dt-design now does by reading. | Tool idea |

## Cautions

1. **Godot 4.7.2.** Only CSG Blockout (4.6+), Metroidvania-System (4.6+), Phantom Camera (README says 4.4+) and ziva-sh's skills (tested on 4.7.2) state a version. Test the rest before relying on them.
2. **Code-running tools.** Both Blender servers, the Godot servers and any skill with scripts run code locally. Read them, pin them, and keep work backed up.
3. **Stale projects.** Godot Input Helper, gdfxr and gdtoolkit haven't been updated recently. They may still work, but check.
4. **Licenses to read first:** madmom's models, UniRig's weights, FMOD and Wwise.
5. **Phase order.** Phase 0 (dt-godot v0.6.0, OQ-051/OQ-137) still runs first. Plugins land in `addons/` only with Systems & Code's go-ahead.

## Questions for the author

1. Trial the Godot MCP server on your PC, so Claude Code can run DT and read its errors?
2. Compare the official Blender Lab server with the community MCP for Blender for dt-blender-art, starting in a sandboxed Blender?
3. For the greybox rooms: CSG Blockout, Cyclops, or plain CSG?
4. Phantom Camera for the greybox camera, or a hand-written plane-locked camera first?
5. Should a formatter be enforced, and if so, in CI or a pre-commit hook?

## Cost of this scout

About 29 Firecrawl credits. Developer search costs 2 credits a call, a plain page scrape 1, and a scrape that asks a question of the page 5. The GitHub search API is free.
