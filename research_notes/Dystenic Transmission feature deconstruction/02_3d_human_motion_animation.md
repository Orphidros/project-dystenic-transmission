# 3D Human Motion and Animation for a Plane-Locked 2.5D Side-Scroller (Godot 4.7, solo dev)

Research date: 2026-11-05. Budget was about 15 tool calls; coverage is uneven and the Gaps sections say where. The CMU official site and several GitHub pages returned 503 or 403 from this environment, so some licence statements rest on secondary sources and are marked (unverified).

## 1. Techniques: which ones multiply a small clip library, ranked by payoff vs effort

### Takeaway
Motion matching is the headline technique (Ubisoft For Honor, GDC 2016), but a solo dev gets most of the payoff from cheaper pieces first: foot IK via Godot's built-in modifiers, AnimationTree blending with additive layers, and partial-ragdoll hit reactions. Full motion matching is a T2 experiment, not a T1 dependency.

### Cited Findings
- GDC 2016 "Motion Matching and The Road to Next-Gen Animation" was given by Simon Clavet (Ubisoft Montreal) and covered the For Honor animation system. — [GDC Vault](https://gdcvault.com/play/1022985/Motion-Matching-and-The-Road); one ResetEra post credits a different presenter, treated as unreliable per [Game Watch](https://game.watch.impress.co.jp/docs/news/749136.html)
- Technique as described in press coverage: each frame the system searches all mocap data for the best-matching frame and transitions to it. Clavet called it deliberately brute-force. The cost is large data storage and substantial CPU. — [Game Watch (Impress), GDC 2016 report](https://game.watch.impress.co.jp/docs/news/749136.html)
- The For Honor team ran weekly mocap sessions to fill gaps that the search revealed. — [Game Watch (Impress)](https://game.watch.impress.co.jp/docs/news/749136.html)
- Manual animation transitions could only cover a small number of patterns, which motivated the search approach. — [Game Watch (Impress)](https://game.watch.impress.co.jp/docs/news/749136.html)
- Daniel Holden's article on inertialization transition cost: the usual motion-matching cost sums weighted position and velocity differences, which mixes units and needs hand-tuned weights. He proposes cost as the total displacement of an inertialized transition, with an approximate database feature `2·pos/y + vel/y²` that needs no weight tuning. He says he has not tested it extensively. The page gives no code licence. — [theorangeduck.com, Inertialization Transition Cost](https://theorangeduck.com/page/inertialization-transition-cost)
- Holden's Learned Motion Matching (Holden, Kanoun, Perepichka, Popa, ACM TOG 39(4), 2020) replaces the pose database with learned networks. — [theorangeduck.com](https://www.theorangeduck.com/page/learned-motion-matching); [DOI](https://doi.org/10.1145/3386569.3392440)
- The orangeduck/Motion-Matching reference code is MIT-licensed and C++, last push 2025-02-06 per an aggregator (unverified against the repo's LICENSE). A reimplementation notes its training data (LAFAN1) is CC BY-NC-ND 4.0 unlike the MIT code. — [GitTrend](https://gittrend.io/repo/orangeduck/Motion-Matching); [kai-lan/Motion-Matching](https://github.com/kai-lan/Motion-Matching)
- Godot's ragdoll tutorial: PhysicalBoneSimulator3D drives PhysicalBone3D children, one per bone. Partial simulation is possible by passing bone names to the start call. Default influence is 1.0, so the ragdoll fully overrides animation; lowering it blends simulation with animation, which is the basis of active ragdolls. Hinge and cone joints cover most uses; pin joints cause crumpling. — [Godot docs, Ragdoll system](https://docs.godotengine.org/en/latest/tutorials/physics/ragdoll_system.html)
- A user report on Godot 4.5 says blending animation, physics and animation through influence gave poor active-ragdoll results; suggestions were stiffer leg and lower-back joints and keeping the AnimationTree active during the blend. Forum anecdote, not a benchmark. — [Godot forum](https://forum.godotengine.org/t/active-ragdoll-in-godot-4-5-how-to-achieve-good-results/128728)
- Godot 4.6 added IKModifier3D (a SkeletonModifier3D family) with children TwoBoneIK3D, ChainIK3D, SplineIK3D, IterateIK3D, FABRIK3D, CCDIK3D and JacobianIK3D. TwoBoneIK3D and SplineIK3D are deterministic. Between 4.4 and 4.6, 19 new SkeletonModifiers were added. — [Godot blog, Inverse Kinematics returns to Godot 4.6](https://godotengine.org/article/inverse-kinematics-returns-to-godot-4-6/)
- The 4.7 class reference lists IKModifier3D with ChainIK3D and TwoBoneIK3D as direct subclasses and describes it as a base for IK on multiple bones. — [Godot 4.7 docs, IKModifier3D](https://docs.godotengine.org/en/stable/classes/class_ikmodifier3d.html)

### Inferences
- (inference) Payoff vs effort for one person, best first:
  1. Foot IK and ground adaptation with TwoBoneIK3D on both legs. Cheap, and it removes foot slide on the staggered, uneven Deep-City levels.
  2. AnimationTree state machine plus BlendSpace1D (speed) for locomotion, with short crossfades. Built in.
  3. Additive layers for breathing, injury limp and stress tells. They multiply clips cheaply and map directly to DT's hidden stress value. Godot AnimationTree has an Add node; I did not verify the 4.7 specifics (gap).
  4. Partial-ragdoll hit reactions using PhysicalBoneSimulator3D with influence ramped for a fraction of a second. Weighty feel for little authored data. Expect tuning time (see the forum report above).
  5. Anchor-point warping for ledge grab, mantle and vault: move the root to a computed anchor while one authored clip plays. In a plane-locked game the warp is 2D (X, Y), which makes it unusually easy. No source cited; design inference.
  6. Motion matching. Highest ceiling, highest data and tuning cost, and the only Godot 4 implementation is in development (section 2).
  7. Learned motion matching, Euphoria-style full active ragdoll: research-grade, skip.
- (inference) Inertialization (Holden) is the cheap way to get motion-matching-like blend quality without a database, but I found no maintained Godot 4 implementation. It could be hand-written in GDScript as a SkeletonModifier3D, which is a T2 task.

### Gaps
- Stride warping, distance matching, hit-stop on skeletal animation and procedural secondary motion (beyond the existence of SpringBone): no sources gathered within budget.
- The Last of Us Part II motion-matching talk and the Euphoria/physical-animation GDC talks were not fetched.
- Root motion vs in-place guidance for Godot 4.7 (RootMotion track, AnimationTree root motion API): not researched.

## 2. Godot 4.x implementations

### Takeaway
There is one live open-source motion-matching addon for Godot 4 (GuilhermeGSousa, MIT, C++ GDExtension, built for 4.4), and it is explicitly in development. Everything else found is stale or tiny. The built-in 4.4 to 4.7 SkeletonModifier3D and IK family does more for DT's near-term needs.

### Cited Findings
Repo table. Dates are `pushed_at` from the GitHub search API (the 'last commit' proxy), fetched 2026-11-05. Per-repo API access was denied, so dates come from search results only.

| Repo | Licence | Last push | Stated Godot version | Language |
|---|---|---|---|---|
| [GuilhermeGSousa/godot-motion-matching](https://github.com/GuilhermeGSousa/godot-motion-matching) | MIT | 2026-06-04 | "Motion Matching for Godot 4.4" | C++ GDExtension (godot-cpp, SCons) |
| [GuilhermeGSousa/godot-motion-matching-demo](https://github.com/GuilhermeGSousa/godot-motion-matching-demo) | none listed | 2026-06-09 | demo for the addon | GDScript |
| [Remi123/MotionMatching](https://github.com/Remi123/MotionMatching) | MIT | 2024-08-20 | not verified | C++ |
| [V-Sekai/godot_motion_matching](https://github.com/V-Sekai/godot_motion_matching) | MIT | 2024-02-01 | pre-4.4; a C++ module port of Remi123's | C++ module |
| [theroeberry/Motion-Matching-For-Godot](https://github.com/theroeberry/Motion-Matching-For-Godot) | MIT | 2022-06-29 | not verified | C++ |

Source for all rows: GitHub repository search results, 2026-11-05; a V-Sekai/Remi123 relationship is stated by [awesome.ecosyste.ms](https://awesome.ecosyste.ms/projects/github.com%2Fv-sekai%2Fgodot_motion_matching).

- GuilhermeGSousa addon details: 255 stars, 66 commits, 13 open issues, no GitHub Releases listed; builds a pose database from an animation library, matches features against character state at runtime, integrates with AnimationTree, needs no blend trees or state machines. Requires animations with root motion and a root bone at foot level. The Asset Library listing shows version 0.2.1 for 4.4 and says the module is still under development. — [GitHub repo](https://github.com/GuilhermeGSousa/godot-motion-matching); [Godot Asset Library](https://godotengine.org/asset-library/asset/3822)
- The README says the implementation follows Holden's motion-matching article. — [search summary of README](https://github.com/GuilhermeGSousa/godot-motion-matching)
- Active-ragdoll: no dedicated Godot 4 addon found; only the built-in PhysicalBoneSimulator3D route. — [Godot docs](https://docs.godotengine.org/en/latest/tutorials/physics/ragdoll_system.html)
- GDExtension caveat: C++ GDExtension binaries are platform-specific. DT targets Windows (D3D12 rendering driver), so a Windows build is required; the repo advertises a "Build GDExtension" CI badge but I did not check whether prebuilt Windows binaries are published. — [GitHub repo](https://github.com/GuilhermeGSousa/godot-motion-matching)

### Inferences
- (inference) Compatibility with Godot 4.7.1 is unverified. GDExtensions built for 4.4 generally load in later 4.x if the API is compatible, but this needs a test before anything depends on it. Treat it as a spike: one afternoon, using the demo repo.
- (inference) Because the addon needs root-motion clips with a foot-level root bone, Mixamo and Quaternius clips would need preparation in Blender first.
- (inference) No C#/.NET dependency was found, which fits DT's standard (non-.NET) build.

### Gaps
- Not checked: BoneMap/SkeletonProfileHumanoid retargeting limits, AnimationLibrary sharing across characters, SkeletonModifier3D subclass authoring examples; I rely on the existence confirmed in the 4.6 blog post only.
- The exact last commit date per repo (API denied); `pushed_at` may include non-default-branch pushes.
- GuilhermeGSousa README licence text and any non-Godot-4.4 version claims were not read from the raw README.

## 3. Free motion data

### Takeaway
For a shipping game, the safe-looking sources are Rokoko's free packs and Truebones (both state commercial use is allowed, per secondary pages) and, with caution, CMU. LAFAN1, Bandai Namco and AMASS are research or non-commercial only and must be prototype-only at most.

### Cited Findings
| Dataset | Stated licence | Ship in DT? |
|---|---|---|
| Ubisoft La Forge LAFAN1 | CC BY-NC-ND 4.0 ("see license.txt"); (c) 2018 Ubisoft. 77 sequences, 496,672 frames at 30 fps (about 4.6 h), 5 subjects, BVH. Themes include Fight (3), Fight and sports (2), Obstacles (17), Walk (12), Run (4), Jumps (3), Fall and get up (6). | NO. Non-commercial and no derivatives; research or prototype-only, and retargeted output is arguably a derivative. |
| Bandai Namco Research Motion Dataset 1 and 2 | CC BY-NC 4.0 per the repo README; Blender visualization scripts MIT; (c) 2022 Bandai Namco Research. Some 2022 press says CC BY-NC-ND 4.0 (conflict). BVH. Dataset 1: 17 content types including fighting and dancing, 15 styles; dataset 2: locomotion and hand actions, 7 styles. | NO. Non-commercial; prototype-only. |
| AMASS (SMPL format) | Non-commercial scientific research, education or artistic projects only; commercial use, including incorporation in a commercial product and training models for commercial use, prohibited; commercial enquiries go to the MPI. SMPL body model has its own separate licence. | NO. Research-only. |
| CMU Graphics Lab Motion Capture | Secondary sources say the CMU site states the data is free for use including commercial projects; the official terms page returned 503 here (unverified). A 4TU FBX conversion lists CC BY-NC 4.0, so converted copies may carry different terms. | Probably yes for the original, but verify on mocap.cs.cmu.edu before shipping. |
| Rokoko free packs | Free pack pages state use in any animation, VFX, game or 3D project "including for commercial use"; the rest of the library is paid. 2020 article says the 150 free moves are commercially usable. | Yes, per the pack page; read it per pack. |
| Truebones | A 2019 Gumroad terms post says products are royalty free for any purpose including games; the full ToS page text was not retrieved. Some free downloads are time-limited promotions. | Likely yes; save the terms text at download time. |
| ActorCore, Mixamo | Mixamo is covered elsewhere. ActorCore: not researched. | Unknown |

Sources: [LAFAN1 repo](https://github.com/ubisoft/ubisoft-laforge-animation-dataset); [Bandai Namco README](https://github.com/BandaiNamcoResearchInc/Bandai-Namco-Research-Motiondataset/blob/master/README.md); [automaton-media on Bandai licence (CC BY-NC-ND claim)](https://automaton-media.com/en/news/20220430-12213/); [AMASS licence page](https://amass.is.tue.mpg.de/license.html); [Meshcapade on SMPL licences](https://meshcapade.notion.site/The-SMPL-Model-Licenses-2144560e54388085af5eff111fcdf266); [CG Press on CMU](https://cgpress.org/archives/carnegie-mellon-university-motion-capture-database.html); [4TU CMU FBX](https://data.4tu.nl/datasets/0448aab2-3332-449f-a8e2-d208cb58c7df); [Rokoko free walk and run](https://rokoko.com/resources/rokoko-mocap-16-free-walk-and-run-cycle-animations); [CG Channel on Rokoko 150 moves](https://www.cgchannel.com/2020/03/get-150-free-mocap-moves-from-rokokos-motion-library); [Truebones terms post](https://truebones.gumroad.com/p/truebones-terms-of-use-for-truebones-motions-t-o-s).

- Prototype-only flag: LAFAN1, Bandai Namco and AMASS are non-commercial. A motion-matching database built from any of them cannot ship, and trained models (Learned Motion Matching) inherit the restriction (AMASS explicitly bans training for commercial use).

### Inferences
- (inference) For DT, fighting clips are the scarce category in commercially usable data; Truebones and Rokoko packs plus original capture (FreeMoCap, BlendArMocap already covered) are the realistic route. LAFAN1 and Bandai Namco fight data are useful only to prototype timing.
- (inference) Keep a licence ledger (source URL, date, licence text saved) per imported clip; the sources above change over time (Truebones free promos, 2020-era Rokoko text).

### Gaps
- ActorCore free motions: no sources.
- CMU official terms text: not verified; Truebones full ToS and Rokoko current licence text not read.
- LAFAN1 and Bandai LICENSE files were not read directly (the pages only reference them).

## 4. Workflow: Blender retargeting, loop cleanup, clip counts

### Takeaway
Retargeting tooling exists and is free, but I could not confirm Expy Kit's licence or any developer clip-count figures. Treat clip budget numbers as unknown rather than guessing.

### Cited Findings
- Expy Kit (pKrime) is a Blender add-on for character conversion between Mixamo, Rigify and Unreal; its Gumroad listing is pay-what-you-want (EUR 0+) and refers to a "premium" zip with paid features. Its licence text was not found. — [Gumroad listing](https://ballsandninjas.gumroad.com/l/xotibs); [BlenderNation](https://www.blendernation.com/2022/06/04/blender-expy-kit-addon-easy-mixamo-to-rigify-retargeting/); source repo at github.com/pKrime/Expy-Kit per [search summary](https://extensions.blender.org/add-ons/retarget/)
- "Retarget" on extensions.blender.org is a fork of Expy Kit and AnimAide with presets for Mixamo, Unreal, VRoid, MMD and DAZ; the platform requires add-ons to be GPL-3.0-or-later compatible. Repo: github.com/KBSBAUDRICE/Retarget. — [Blender Extensions, Retarget](https://extensions.blender.org/add-ons/retarget/)
- Bandai Namco's repo includes MIT-licensed Blender scripts for visualizing its BVH motion. — [README](https://github.com/BandaiNamcoResearchInc/Bandai-Namco-Research-Motiondataset/blob/master/README.md)

### Inferences
- (inference) A Blender-side step is mandatory before the Godot motion-matching addon: apply a foot-level root bone and bake root motion. Retarget or Expy Kit presets for Mixamo to a common rig, then export GLB.
- (inference) GPL add-ons used as tools do not infect exported animation data, but this is a general principle, not a statement found in these sources; confirm if concerned.
- (inference) None of the retargeting tools found needs CUDA (they are Blender Python add-ons). The only CUDA or NVIDIA risk is with training Learned Motion Matching networks, which the reference repo does with PyTorch (CUDA is typical; not verified for CPU or ROCm). AMD RX 5700 XT has no ROCm support per the context brief, so skip learned approaches.

### Gaps
- Rokoko Blender plugin licence, built-in Blender retargeting tools, Rigify-based loop cleanup practice: not researched.
- Developer figures for the minimum clip count of a fluid locomotion plus melee set: none found. Not invented.

## 5. Combat-specific: paired animations, hit-stop, cancel windows tied to rhythm tiers

### Takeaway
Nothing sourced within budget. The relevant Godot built-ins are known to exist but I did not retrieve documentation on them.

### Cited Findings
- Godot's partial-ragdoll influence parameter (section 1) is the one sourced combat-relevant mechanism: ramping influence is the basis for blended hit reactions. — [Godot docs](https://docs.godotengine.org/en/latest/tutorials/physics/ragdoll_system.html)

### Inferences
- (inference) Hit-stop can be done by setting the AnimationPlayer or AnimationTree `speed_scale` to near zero for a few frames while the rhythm clock (Conductor or RhythmNotifier, already covered) keeps running. Cancel windows can be method-call or marker tracks on the animation, opened and closed per timing tier. Both need verification against the 4.7 class reference.
- (inference) Paired animations (takedowns, throws) in a plane-locked game can use one attacker clip and one victim clip, with the victim's root snapped to an attacker-relative anchor at start. The shared plane removes most alignment problems.

### Gaps
- No sources for paired animation sync, hit-stop with skeletal animation or animation cancel windows. Needs a follow-up search (for example Sakurai or Platinum-style hit-stop writeups, GDQuest animation-event tutorials).

## DT translation

| Action | Item | Tier | DT system |
|---|---|---|---|
| Borrow | Built-in TwoBoneIK3D foot IK, AnimationTree blend spaces and additive layers | T1 | Plane-locked CharacterBody3D locomotion; hidden stress tells (additive breathing or limp layers) |
| Borrow | Partial PhysicalBoneSimulator3D with ramped influence for hit reactions | T1 (single enemy type first), T1.5 | Combat feel; enemy Heavy Unit and Basic Bot reactions |
| Borrow | Commercially licensed clips only: Rokoko free packs, Truebones, CMU after verifying terms; keep a licence ledger | T1 | Vox and Ciphera clip library |
| Adapt | Anchor-point warping for ledge grab, mantle, vault (2D warp because of the plane lock) | T1.5 | Climbing and limited parkour; Deep-City staggered levels |
| Adapt | Hit-stop via speed_scale plus marker-track cancel windows tied to Perfect/Good/Poor/Miss | T1 (basic), T1.5 | Rhythm combat timing tiers |
| Adapt | Single-anchor paired takedown clips | T2 | Mid-range throws, tackles |
| Enhance | GuilhermeGSousa motion matching spike on 4.7.1 with Mixamo or Rokoko clips prepared with a foot-level root | T2 (spike only, not a dependency) | Locomotion polish; MIT, C++ GDExtension, 4.4-era, in development |
| Enhance | Hand-written inertialization as a SkeletonModifier3D for switch-in/out blends | T2 | Character switching (ground only in T1) |
| Avoid | Shipping anything trained or built from LAFAN1, Bandai Namco or AMASS (CC BY-NC(-ND) or non-commercial); prototype-only | All | Pipeline legality |
| Avoid | Learned Motion Matching and Euphoria-style full active ragdoll | T3 | No GPU training path on RX 5700 XT (inference); tuning cost far above payoff |
| Avoid | Relying on the motion-matching addon in T1 | T1 | Scope lock; unverified on 4.7.1 |
