# DT context brief (shared by every research track)

Read this before researching. It replaces reading the 240 KB GDD. Source: DT GDD v4.13.2 (2026-10-12) and DT Research: Game Build Resources v1.0 (2026-10-13). Today is 2026-11-05.

## The game
- **Dystenic Transmission: The Game.** A Metroidvania RPG for PC. Solo developer (Orphidros), first game project.
- **Engine:** Godot 4.7.1-stable, standard build (GDScript; .NET/C# tools are unusable as shipped). Forward+ renderer, Jolt physics.
- **Presentation:** 2.5D. Full 3D scenes, **3D characters and 3D skeletal animation (not sprites)**, a plane-locked CharacterBody3D (depth axis fixed) and a side-on camera rig with dynamic/cinematic camera moves.
- **Tone:** grimdark cyberpunk horror. A world once more advanced than Cyberpunk 2077, now decayed under failing AI governance (the Axioms) and a dying sun. Visual references: Mandragora, MIO: Memories in Orbit, Cyberpunk: Edgerunners, BLAME!, Signalis. Soundtrack genre: "CyberSludge". The author has their own art direction, so don't propose an art style.
- **Pillars:** (1) The cost of blind trust; (2) Nothing survives alone; (3) Knowledge is the weapon; (4) The world speaks, listen; (5) Music as language.

## Core systems as designed
- **Five band-member protagonists:** Vox Nullis (vocalist), Serratrix-9 (guitar), Metronome (drums), Gravicus (bass), Ciphera (sonic architect, a rig-based character).
- **Switch mechanic:** switching mid-combat; ground-only switching as a puzzle layer, with one exception (an aerial strike-swap during combos); 2- to 5-character combination attacks; inactive members can be dispatched on missions; enemy affinity tiers 1-5 per character; character-specific secrets. A character only sees an interactable if they have the skill or equipment for it.
- **Combat:** action-forward with RPG stats and cooldown depth. Human-scale melee range tiers: close (knees, elbows, headbutts, shoulder-slams), mid (punches, kicks, throws, tackles), extended (weapons), ranged (guns). Rhythm timing tiers (Perfect, Good, Poor, Miss), each with its own note. Free movement between encounters isn't graded. Stamina pool per character; the dodge is costed. Hidden stress value shown only through body and augment tells.
- **Health:** a pool per character. In non-permadeath play a member blacks out and is dragged to safety, with injury accumulation and an escort system. Optional permadeath (death after two unhealed injuries) removes that member's instrument from the soundtrack. Band and Solo permadeath modes.
- **Movement:** running, jumping, climbing, limited human-adjacent parkour. Learnable, progressively advanced grappling. Duct crawls, crouch passages, leaps across great heights, secret access points, enterable side rooms, cavernous chambers. The Deep-City has ~250 m vertical layers with staggered, uneven levels.
- **Progression:** XP is a spent resource, with a pool per character. Three tracks: experience (stats), story beats (ability access), tool knowledge (discovered). Use-based ability growth; a souls-lite framework. Gear arcs run weaponization, then salvaged and crafted armour, then engine parts researched and crafted from salvaged bots.
- **Narrative:** a prologue of 5 "Waves" across 21 segments, played as character chapters with a Wave-Lock structure. Choices carry no good/bad UI and are signalled by musical tones: harmonic (good), missed note (bad), silence (neutral), chord (secret). Signal states: Clear, Distorted, Fragmented, Encrypted. Branches diverge significantly and compound. Open flags: the ending matrix (FLAG-02), a secret ending (FLAG-09), abandoned vs deceased members (FLAG-13), New Game+ (FLAG-12), boss structure (FLAG-06).
- **World:** a vertically stratified Deep-City (Upper, Mid and Lower Depths, plus the Sewers). The world visibly decays over time (the Decay Map). A perception overlay means connected citizens see an edited reality, built as one true view with suppression as a viewer state. Glitch ladder: strobe, then slippage, then rot.
- **Enemies:** bots, flying drones, heavy units, wardens, and augment-husks with swarm behaviour (infighting under 7, a hive-swarm at 8 or more).

## Scope tiers (respect these when recommending)
- **T1, the prototype (locked):** Vox and Ciphera only, one small map of 3-5 rooms, three enemy types (Basic Bot, Flying Drone, Heavy Unit), basic rhythm combat, basic switching, Wave-Lock, one micro-choice. **Out of scope for T1:** permadeath, combo systems, aerial switching.
- **T1.5:** the public prologue demo (all five Waves, a boss, cel shading arrives).
- **T2:** Album 1 as a complete game (2-4 years solo).
- **T3:** the full five-album vision.

## Pipeline constraints
- Hardware: AMD RX 5700 XT (RDNA1; no CUDA, no ROCm). Local-first, though cloud tools are allowed where they help (Mixamo is allowed). Cloud 3D generators are off.
- Blender plus blender-mcp art pipeline, glTF/GLB export to Godot. Poly Haven enabled. Fab/Unreal assets only under the Standard License; no UE-only or MetaHuman content.
- Non-commercial model weights and free-tier AI outputs can't ship.

## Already covered by Game Build Resources v1.0. Don't re-survey; only extend or correct
godot-statecharts, GLoot, Phantom Camera, DebugDraw3D, LimboConsole, Maaack's Game Template, LimboAI, Beehave, Panku Console, ClutteredCode hit kit, Saltmire Juice, Juicee, KoBeWi Metroidvania System, Cyclops Level Builder, GridMap, draw.io, Dormans 2010, the itch Godot Platformer Template, the GDQuest 3D controller, UCharacterBody3D, rhythm addons (RhythmNotifier, Conductor, SRGL, Guitarrada, gdscript-midi-parser), AudioStreamSynchronized/Interactive, FMOD/Wwise, Sonniss/Kenney/Freesound/Pixabay audio, Surge XT/Vital/Cardinal, the Quaternius Universal Animation Library, Mixamo, Rigify, Auto-Rig Pro, BlendArMocap, FreeMoCap, Plask, Move.ai, Cascadeur, Dialogic 2, Dialogue Manager, inkgd, YarnSpinner-Godot, Arcweave, articy:draft X, JSON Canvas, Emily Short's "Beyond Branching", Ingold GDC 2017, Ruskin GDC 2012, Triangle Strategy, Pentiment, Mass Effect 3, 13 Sentinels, the Hades dialogue talk, cel/outline shaders, EA IRIS, WCAG 2.3.1. Its reference-game table holds only shallow facts (team, span, engine) for Axiom Verge, Animal Well, Hollow Knight, REPLACED, MIO, Signalis, Bloodstained and SotN. Deep systems analysis of those games is new work.
The full file is at `/root/.claude/uploads/48bd2ca8-078a-57eb-a290-6f500eda2058/18be3f8f-DT_Research_GameBuildResources_v1.0.md`. Grep it rather than reading it whole. The GDD is at `/root/.claude/uploads/48bd2ca8-078a-57eb-a290-6f500eda2058/a8e3b57f-DT_GDD_v4.13.2.md`; grep a specific heading if you need more, and never read the whole file.

## Rules for every track
1. **Originality:** deconstruct mechanics into principles DT can rebuild in its own way. Never propose copying names, characters, art, levels, music or code. Decompilations, datamines and disassemblies are for studying design intent and formulas only; state their legal status and that nothing should be vendored.
2. **Licences:** for every asset or tool, quote the licence as its own page states it. Flag non-commercial terms, GPL/AGPL, C#/.NET-only tools, missing licences and paid tiers.
3. **Godot fit:** state Godot 4.x compatibility as claimed (4.7.x is the target), and mark when it's unknown.
4. **Evidence:** give full URLs and the date of each source. Mark unverified claims "(unverified)" and inferences "(inference)".
5. **DT translation:** end your notes with a table of *Borrow / Adapt / Enhance / Avoid* items, each tagged T1, T1.5, T2 or T3 and tied to a DT system above.
6. **Token economy:** use targeted searches and fetches, skip very long pages unless they're essential, and stop at about 15-25 strong sources. Keep notes dense, at most about 4,000 words.
