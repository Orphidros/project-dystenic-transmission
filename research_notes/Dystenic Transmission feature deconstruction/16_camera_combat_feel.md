# Side-scroller camera design and combat game feel, mapped to Godot 4.7

Research date 2026-11-05. "Opened" means the page was fetched and read. Godot docs were fetched from the `stable` URL; I did not confirm that stable equals 4.7.x (unverified). Budget was about 19 tool calls, so several requested talks (God of War, Sifu, Arkham, Metal: Hellsinger) were NOT researched; see Gaps.

## 1. Camera: side-scroller techniques (Keren, Nesky) and what is free to watch

### Takeaway
Keren's Game Developer article is a detailed primary source for camera windows, platform snapping, lerp smoothing, dual-forward focus, look-ahead and attractor zones, and it fills the gap earlier tracks flagged. Nesky's talk is free on the GDC YouTube channel but I only read its summary page, so his 50 mistakes are not itemised here.

### Cited Findings
- Keren's article is a modified version of his GDC 2015 Independent Games Summit talk, published 2015-05-11 — [Game Developer](https://www.gamedeveloper.com/design/scroll-back-the-theory-and-practice-of-cameras-in-side-scrollers)
- Camera window: the camera moves only when the character pushes against a window edge. Rastan Saga's window is as tall as a jump, so jumps do not move the camera. Drawbacks: enemies arriving from above are harder to see, and look-ahead margin can be narrow — same article
- Platform snapping: the camera holds still during jumps and snaps when the character lands on a platform (introduced by Super Mario World; Rayman's window is just over jump height). It only works where the character lands on platforms; Shinobi uses slow continuous snapping instead — same article
- Lerp smoothing: `a + t*(b-a)`. Keren calls lerp "EaseOut" and physics-based smoothing "EaseInOut", and suggests SmoothDamp-style smoothing that accounts for distance and velocity. Very large fast characters can hit the screen edge before the camera catches up. Mushroom 11 varies its smoothing factor with the piece's velocity — same article
- Dual-forward focus: two forward anchors, with the camera shifting to the one matching facing. Super Mario World keeps the current anchor until a threshold is crossed so small back-and-forth does not flip the view. Cave Story moves focus at base speed plus walking speed — same article
- Look-ahead: Defender keeps focus about 25% of screen width ahead. Projected focus extrapolates position from velocity (used by Mushroom 11). The article does not use the term "look-ahead" itself — same article
- Zones and cues: Insanely Twisted Shadow Planet uses double-ring attractors. The outer ring pulls focus toward a cue by weighted average; inside the inner ring the camera focuses only on the cue. Detractors push the camera away. Mushroom 11 uses dozens of rectangular regions per level, each with a camera path and preset zoom (FOV factor), and boss fights use cue attractors — same article
- The article itself cautions that its numbers are examples from specific games, not general recommendations — same article
- Nesky ("Feel Engineer" at thatgamecompany, Journey camera designer) gave "50 Game Camera Mistakes" at GDC 2014. His summary page says "Cameras are most noticeable when they fail" and does not list the mistakes — [Game Developer, 2015-11-17](https://gamedeveloper.com/design/video-50-common-game-camera-mistakes----and-how-to-fix-them)
- GDC Vault description of Nesky's talk: disorienting players, misjudging distances, breaking line of sight, motion sickness. Tagged "free content" — [GDC Vault](https://gdcvault.com/play/1020460/50-Camera)

### Free-to-watch verification (camera)
| Talk | Page opened | Free status | Video URL |
|---|---|---|---|
| Keren, Scroll Back (GDC 2015) | [GDC Vault](https://www.gdcvault.com/play/1022243/Scroll-Back-The-Theory-and) (shows a login-limit message, no player in the fetch) | Tagged "free content" (page does not say so explicitly) | [YouTube](https://www.youtube.com/watch?v=pdvCO97jOQk), URL taken from [Game Developer, 2015-11-09](https://gamedeveloper.com/design/video-how-to-design-the-best-camera-for-your-side-scrolling-game); the video page itself was not opened |
| Nesky, 50 Game Camera Mistakes (GDC 2014) | [GDC Vault](https://gdcvault.com/play/1020460/50-Camera) | Tagged "free content" | [YouTube](https://www.youtube.com/watch?v=C7307qRmlMI), URL taken from [Game Developer](https://gamedeveloper.com/design/video-50-common-game-camera-mistakes----and-how-to-fix-them); video page not opened |

### Inferences
- (inference) For a 3D side-view, Keren's window, snapping and dual-forward concepts apply to the camera's X/Y target position while the depth axis stays fixed; the 3D case adds the choice of perspective vs orthographic (section 2).
- (inference) A DT-sized camera for T1 needs only: a follow target with a dead-zone window, facing-based look-ahead with a hysteresis threshold, and per-room framing presets.

### Gaps
- Nesky's individual mistakes are not itemised; only the summary page was read. Watch the video for the list.
- Keren's article does not state exact window sizes for 3D side-views; no source found on framing for 3D side-views specifically.

## 2. Camera: Godot 4.7 mapping, Phantom Camera coverage, perspective vs orthographic

### Takeaway
Phantom Camera (MIT, Godot 4.4+ per its badge) covers framed dead-zone follow, simple/group/path follow, priority-based transitions and a viewfinder, but its README lists no camera zones/triggers or shake. Those, plus platform snapping, dual-forward focus and attractor rings, need custom code.

### Cited Findings
- Phantom Camera licence is MIT; supported Godot is 4.4 or later per the version badge; the Releases section appeared empty so the current version is unknown — [GitHub README](https://github.com/ramokz/phantom-camera)
- Follow modes: Glued, Simple (offset, damping), Group, Path, Framed (horizontal and vertical dead zones, 2D and 3D), Third Person (3D only, SpringArm3D) — same README
- Look-at modes (Mimic, Simple, Group) are listed for 3D; zoom is 2D only — same README
- Priority: the highest-priority active PhantomCamera controls the real camera, and a higher-priority camera triggers a tweened transition — same README
- The README does not mention camera zones/triggers or noise/shake — same README (absence on this page only; the wiki was not read)
- Camera3D projection: Perspective, Orthogonal ("Objects remain the same size on the screen no matter how far away they are") and Frustum (`frustum_offset` for "tilted frustum" effects). `keep_aspect` locks one axis during fov/size changes; `h_offset` and `v_offset` shift the viewport — [Godot Camera3D docs](https://docs.godotengine.org/en/stable/classes/class_camera3d.html)
- The Camera3D page has no guidance on moving cameras in `_process` vs `_physics_process` or physics interpolation — same page

### Technique coverage table (inference unless marked)
| Technique | Phantom Camera | Custom code |
|---|---|---|
| Camera window | Framed follow dead zones (cited) | Only if non-rectangular windows are wanted |
| Lerp/damped smoothing | Simple follow damping (cited) | Velocity-scaled smoothing (Keren's Mushroom 11 example) |
| Platform snapping | Not listed | Yes: hold Y while airborne, ease on `is_on_floor()` |
| Dual-forward focus | Not listed (offset is static) | Yes: facing anchor with threshold hysteresis |
| Cue/attractor rings, detractors | Not listed | Yes: Area3D rings plus weighted average |
| Per-room zones and zoom presets | Priority switching of several PhantomCameras is a plausible fit | Area3D triggers that set priority (unverified against the wiki) |
| Shake | Not listed | Yes, see section 3 |

### Gaps
- Phantom Camera wiki and 4.7 compatibility not verified; the README only says 4.4+. Other camera talks (Cinemachine, Squirrel Eiserloh's camera math talk seen in search results only) were not read.
- No source compared perspective vs orthographic for 3D side-views beyond the class reference.

## 3. Combat feel: hit-stop, shake, juice, and Godot time controls

### Takeaway
Sakurai's Famitsu column (via Source Gaming) is the best primary-derived account of hit-stop: both parties freeze equally, longer for more damage, capped. Godot gives two levers: global `Engine.time_scale` (does not slow audio) and per-node animation speed.

### Cited Findings
- Sakurai: hit-stop emphasises "the power of impact"; attacker and victim freeze for the same time; "the more damage an attack inflicts, the longer the hitstop period"; per-attack modifiers and a cap exist; hurtboxes stay in place during the shake so hits do not inconsistently miss; the victim's flinch transitions into a hurt animation over four frames during hitstop — [Source Gaming summary of Famitsu vol. 490, 2015-11-11](https://sourcegaming.info/2015/11/11/thoughts-on-hitstop-sakurais-famitsu-column-vol-490-1/). This is a secondary summary of the column, not the original Japanese text.
- Engine.time_scale: scales Timer, SceneTreeTimer, `_process` and `_physics_process` delta; "It's recommended to keep this property above 0.0"; "This does not affect audio playback speed" (use `AudioServer.playback_speed_scale`); it does not adjust `physics_ticks_per_second` — [Godot Engine docs](https://docs.godotengine.org/en/stable/classes/class_engine.html)
- AnimationNodeTimeScale: "Allows to scale the speed of the animation (or reverse it) in any child AnimationNodes"; 0.0 pauses — [Godot docs](https://docs.godotengine.org/en/stable/classes/class_animationnodetimescale.html)
- AnimationTree: "Playback and transitions should be handled using only the AnimationTree" — [Godot docs](https://docs.godotengine.org/en/stable/classes/class_animationtree.html). The page did not cover root motion or TimeSeek.
- Talk URLs from a curated list (page opened, videos not opened): Vlambeer's "The Art of Screenshake" (Jan Willem Nijman) [YouTube](https://www.youtube.com/watch?v=AJdEqssNZ-U) and "Juice it or Lose it" (Martin Jonasson and Petri Purho) [YouTube](https://www.youtube.com/watch?v=Fy0aCDmgnxg) — [Kenney, must-see videos](https://kenney.nl/learn/must-see-videos-for-indie-developers). Both are on YouTube, so free to watch if the links resolve (not played by me).
- Search snippet only (not opened): duration advice such as 2-4 frames for light hits and 12-20 for heavy is from a low-authority blog and conflicts with other forum numbers; treat as game-specific (snippet-only, unverified).

### Inferences
- (inference) Global `Engine.time_scale` is wrong for a rhythm game's hit-stop because the beat clock would drift against audio, which time_scale does not slow. Prefer freezing only the two characters' AnimationTree/AnimationPlayer speed and any hitbox timers for a few frames while the music clock keeps running.
- (inference) Sakurai's "hurtboxes stay put during the shake" suggests: apply visual shake to the mesh, not the CharacterBody3D, so the plane lock and collision are unaffected.
- (inference) Camera shake should be a trauma-style offset applied to `h_offset`/`v_offset` or a child pivot, so it does not fight Phantom Camera's positioning.

### Gaps
- No primary source read on animation cancel windows, input buffering, hit reactions, or paired/synced animations (throws, takedowns). The Source Gaming piece only touches on hit reactions.
- God of War, Sifu, Arkham freeflow and Metal: Hellsinger talks were not searched or opened. Contents of Nijman's and Jonasson/Purho's talks were not read.

## 4. Rhythm-locked animation (Hi-Fi Rush) and timing grades

### Takeaway
Hi-Fi Rush's director frames the core trick as designing backwards so the hit lands on the beat regardless of input timing. The GDC 2024 talk is tagged free on GDC Vault, but I could not confirm a playable video, and the animation-stretching details come only from search snippets.

### Cited Findings
- GDC 2024 talk "Developing 'Hi-Fi RUSH' Backwards and Finding Our Positive Gameplay Loop", John Johanas, Tango Gameworks: the team worked backward from the desired result and used core pillars to define mechanics. Page tagged "free content"; video availability not stated — [GDC Vault](https://gdcvault.com/play/1034256/Developing-Hi-Fi-RUSH-Backwards)
- Session scheduled Wednesday 2024-03-20, 9:00 to 10:00 am, Room 2005 West Hall — search result for [GDC schedule](https://schedule.gdconf.com/session/developing-hi-fi-rush-backwards-and-finding-our-positive-gameplay-loop/899845) (snippet only, page not opened)
- Snippet only (unverified): Johanas said standard action games show the animation before the hit lands, so the team "had to think backward so that no matter what, the animation will hit on the beat"; one report says off-beat input plays a slightly longer variant so every hit still lands on the beat; accurate timing gives more damage and more effective moves — via a [WebSearch result summary](https://80.lv/articles/hi-fi-rush-stylish-rhythm-brawler-from-evil-within-dev-tango-gameworks/), page not opened. Treat as unverified.

### Inferences
- (inference) For DT's Perfect/Good/Poor/Miss grades: quantise the attack's impact frame to the next beat or subdivision, using the AnimationNodeTimeScale node to stretch the wind-up so impact lands on the grid, and let the grade scale damage and the hit-stop length (Sakurai: longer freeze for stronger hits) rather than whether the hit lands. This mirrors the reported Hi-Fi Rush approach but needs checking against the talk itself.
- (inference) Cancel windows can be method-call tracks that open and close per grade; this stays unsourced.

### Gaps
- The actual mechanism (time-stretch vs alternate clips vs both) is not confirmed from a primary source. Watch the GDC talk if available. Metal: Hellsinger and Sifu not researched.

## DT translation

| Tag | Item | Tier | DT system |
|---|---|---|---|
| Borrow | Keren's camera window (dead zone) via Phantom Camera Framed follow | T1 | Side-on camera rig |
| Adapt | Platform snapping: hold camera Y during jumps, ease on landing | T1 | Movement, plane-locked CharacterBody3D |
| Adapt | Dual-forward focus with hysteresis threshold, custom code | T1 | Camera rig, running |
| Adapt | Per-room framing presets via PhantomCamera priority switches | T1 | 3-5 room map |
| Adapt | Hit-stop that freezes only attacker and victim animation speed, length scaled by grade and damage, capped | T1 | Rhythm combat grades |
| Adapt | Impact frame quantised to the beat using AnimationNodeTimeScale | T1.5 | Rhythm combat |
| Enhance | Cue attractor rings and detractors for set pieces | T1.5 | Cinematic camera |
| Enhance | Trauma-style camera shake as a pivot offset | T1.5 | Combat feel |
| Enhance | Per-grade cancel windows and paired takedown clips | T2 | Mid-range throws, grades |
| Avoid | Global `Engine.time_scale` for hit-stop (audio and beat clock mismatch) | T1 | Music as language pillar |
| Avoid | Relying on Keren's example numbers as defaults | T1 | Camera tuning |
| Avoid | Combo systems and aerial switching in camera or combat work | T1 (out of scope) | Scope lock |
