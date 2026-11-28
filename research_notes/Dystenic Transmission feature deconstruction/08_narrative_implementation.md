# Branching narrative state in Godot 4.7: implementation guide and open sources to study

Evidence note: all pages below were fetched or searched on 2026-11-05. Most GitHub pages showed no commit dates, and the GitHub API was blocked in this session (403, repo access not enabled), so "last update" is mostly unknown. The Godot-native licence and version fields come from each repo's own README page. Search-snippet-only facts are marked (snippet). Background knowledge that I could not source this session sits in Inferences or Gaps and is marked (unverified).

## 1. State architecture: flag sets, qualities, fact databases, blackboards, event logs vs snapshots

### Takeaway
Shipped narrative engines in the open converge on a few designs. Dendry and the storylet libraries use a flat "qualities" dictionary with requirement expressions. Dialogue Manager and Questify read and write game state through plain GDScript expressions or a query signal. Ren'Py keeps a separate "persistent" store for cross-playthrough data. I found no open, citable implementation of Valve/Ruskin-style fact-database rule matching in a Godot-fit form, and no documented source on how specific shipped games store narrative state for saves.

### Cited Findings
- Dendry (a hypertext IF tool and file format) uses qualities. Values are set in scripts via `Q['var1']`, inserted in text with `[+ foo : bar +]`, and gated by `view-if` and `choose-if` boolean expressions plus `max-visits`. Scenes take comma-separated `tags:`. This is the Failbetter-like quality-plus-requirement model in a small open form. — [aucchen/dendry (a fork of dendry/dendry, MIT)](https://github.com/aucchen/dendry)
- Storylet libraries are all quality/requirement "filtered card deck" designs. TinyQBN is for Twine 2 and SugarCube and uses passage tags. SimpleQBN is generic Node/web JavaScript with a Deck whose cards carry content and requirements. StoryAssembler (LudoNarrative) is JavaScript and gates most choices by conditions. storylets-rs is a Rust crate "roughly based on StoryNexus". unity-storylets (lumpn) implements Emily Short's storylet concept. Harlowe has built-in storylet support as of 3.2.1. StoryNexus itself is proprietary. — [search results (snippet)](https://videlais.com/tag/qbn/); [TinyQBN](https://joshuagrams.github.io/tiny-qbn); [lumpn/unity-storylets](https://github.com/lumpn/unity-storylets); [StoryAssembler](https://www.Github.com/LudoNarrative/StoryAssembler)
- Questify (Godot 4 quest graph) routes every condition through "an architecture-agnostic condition query signal that you handle yourself". Your own state store therefore stays the source of truth. It supports parameterized quests with values injected into conditions, and quests keep optional flags and metadata on objective nodes. — [TheWalruzz/godot-questify](https://github.com/TheWalruzz/godot-questify)
- Dialogue Manager reads and mutates state through GDScript. A dialogue file can name autoloads (`using SomeGlobal`) and can receive `extra_game_states` (nodes, instantiated objects or dictionaries) whose property changes persist after the conversation. Per-conversation scratch variables use `locals.name`. — [Dialogue Manager conditions and mutations doc](https://raw.githubusercontent.com/nathanhoad/godot_dialogue_manager/main/docs/Conditions_Mutations.md)
- Ren'Py separates `persistent` data (not tied to a save point; declared with `default persistent.x = ...`, unset fields read as None) from per-save state. Its merge rule is "most recently updated value" per field, and `renpy.register_persistent` lets you register a custom merge, e.g. the union of seen endings. — [Ren'Py persistent docs](https://www.renpy.org/doc/html/persistent.html)
- ink's own state is a single serialisable story state plus the compiled story. (Not re-verified this session; see Gaps.)

### Inferences
- (inference) DT's data splits into three scopes. Run state is per save and covers the flags and qualities below. Profile state persists across runs, per the Ren'Py persistent model, and covers endings seen, the FLAG-09 secret unlocked and any New Game+ carry-over. Conversation scratch state is the `locals` idea, discarded after each dialogue.
- (inference) The cheapest sound design for a solo dev is one `NarrativeState` autoload holding a typed `Dictionary` of qualities plus a set of flags, with an append-only event log used only for debugging and validation. A snapshot is the save payload. Questify's "you answer the condition query" pattern fits this, because it avoids a second source of truth.
- (inference) Fact-database rule matching only pays off for large reactive-bark volume (many lines competing for one slot). Wave-Lock chapters with a handful of authored choices don't need it before T2.

### Gaps
- No open Godot implementation of Valve/Ruskin-style rule matching was surfaced. I did not search for non-Godot ones beyond the ink/Dendry family. A search for "Left 4 Dead response rules" or "Ruskin dynamic dialog" GitHub implementations is still open.
- No primary source found on how shipped games store narrative state for saves or New Game+. A reliable source was not found; do not rely on any claim about Disco Elysium, 80 Days or similar until sourced.
- The ink runtime save format (JSON state) is something I believe from background knowledge but did not fetch (unverified).

## 2. Storylet engines and open implementations (licence, Godot version, language, last update)

### Takeaway
There is no Godot-native storylet engine surfaced. The storylet options are JavaScript, Rust or Unity, and are useful as design references or ports only. Godot-native quest addons exist (Questify, Quest Manager, QuestSystem) and are GDScript.

### Cited Findings
| Project | Licence (as stated) | Godot / engine | Language | Last update |
|---|---|---|---|---|
| Dendry (aucchen fork of dendry/dendry) | MIT | none (CLI tool) | JavaScript/Node plus a Python automated_player.py (inferred from files) | not shown; 356 commits, 42 stars |
| Questify (TheWalruzz/godot-questify) | MIT | "Godot 4"; no minimum stated, a separate parser plugin says 4.4+ | GDScript, C# wrapper for the singleton | not shown; 72 commits, about 204 stars (Ecosyste.ms) |
| Quest Manager (rubonnek) | not found | requires 4.2.1+ (snippet) | GDScript | not found |
| QuestSystem (ShomyKohai) | MIT (snippet) | Godot 4 (snippet) | GDScript | not found |
| unity-storylets (lumpn) | not checked | Unity | C# | not found |
| TinyQBN, SimpleQBN, StoryAssembler, storylets-rs | not checked | none | JS, JS, JS, Rust | not found |
| Dialogue Manager (nathanhoad) | MIT | 4.6+ ("Dialogue Manager 4 for Godot 4.6+") | GDScript, C# wrapper | no release date shown; about 4.0k stars |
| Yarn Spinner for Godot (GDScript) | Yarn Spinner Public License (YSPL): free to use in your own projects, but redistributing it in a competing dialogue tool and using it to train AI models are restricted | 4.6 or later (standard or .NET build) | "pure-GDScript" | no release date shown; 143 commits |

Sources: [aucchen/dendry](https://github.com/aucchen/dendry); [Questify](https://github.com/TheWalruzz/godot-questify); [search for Godot quest addons (snippet)](https://awesome.ecosyste.ms/projects/github.com%2FTheWalruzz%2Fgodot-questify); [Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager); [YarnSpinner-Godot-GDScript](https://github.com/YarnSpinnerTool/YarnSpinner-Godot-GDScript).
- Questify state API: `Questify.serialize()` returns an Array and `Questify.deserialize()` restores it. `QuestResource.serialize()` and `deserialize()` use Dictionaries, and quests re-enter via `Questify.set_quests()`. — [Questify](https://github.com/TheWalruzz/godot-questify)
- Twine 2.10.0: one listing dates the Windows build 2024-11-24 and another dates the macOS release 2025-02-17, so the dates conflict. It bundles Chapbook 2.3.0. SugarCube 2.37.3 shipped with Twine 2.9.2 and Harlowe 3.3.9 with 2.9.0. Twine's story-format list moved into a dialog. — [Adaptiva patch listings (secondary source)](https://adaptiva.com/patch-library/1000001429_patch_for_twine_x64)

### Inferences
- (inference) The dendry fork shows 42 stars. The original dendry/dendry repo and its authorship were not confirmed (the page did not name Ian Millington), so check authorship before citing it as his.
- (inference) Questify's graph-plus-signal design suits DT's Wave-Lock chapters as a gating and objective layer, not as the whole narrative store. Its C# wrapper is irrelevant to DT (C# flagged as unusable).
- (inference) Studying TinyQBN or SimpleQBN is enough to port a storylet deck to roughly 100 lines of GDScript: a Dictionary of qualities, an Array of storylet Resources with a requirement Callable or expression, and a filter-and-sort step.
- (inference) Yarn Spinner's YSPL licence has an AI-training restriction. This matters because DT's brief excludes non-commercial weights and outputs only, so check whether any of the author's tooling would trip it before adopting.

### Gaps
- Licences, update dates and Godot versions for TinyQBN, SimpleQBN, StoryAssembler, storylets-rs, unity-storylets and Quest Manager were not verified (GitHub API blocked).
- Harlowe 4, SugarCube and Chapbook licences were not retrieved. I believe SugarCube is BSD-2-Clause and Chapbook and Harlowe are MIT-family (unverified); confirm at each repo before borrowing code.
- Bitsy was not researched (budget).
- Dendry's Python automated player and `random-test` are documented only in the README summary; the source wasn't read.

## 3. Validation tooling: reachability, dead branches, ending enumeration

### Takeaway
Random-playthrough bots are the common practice. They are weak for endings gated behind strategic play, so DT should pair them with a deterministic state explorer. DT has no ink or Yarn dependency decided (O-22), so the cheapest path is to write an exporter-plus-graph checker over its own data.

### Cited Findings
- Dendry ships `dendry random-test` (random playthroughs, with options to dump choices and scenes) and an `automated_player.py`. — [aucchen/dendry](https://github.com/aucchen/dendry)
- Ian Thomas's (wildwinter) ink testing tool runs a story hundreds or thousands of times with random choices, counts visits per line and writes a CSV, crediting Dan Fabulich of Choice of Games for the idea. Simple Ink Tester is a browser tool that picks random choices. `inkcheck` is an MCP server listing that explores reachable states deterministically within explicit limits and reports repro paths and where coverage was partial (a listing, not a detailed project page). I found no official inkle testing tool. — [search results (snippet)](https://wildwinter.medium.com/ink-testing-tool-f79e958db017) (the article itself returned 403, so details are from the search snippet only)
- A Choice of Games forum reply says bits of its content are never reached by Randomtest because they need strategic rather than random play. This is ChoiceScript, not ink, but the limit is general. — [Choice of Games forum (snippet)](https://forum.choiceofgames.com/t/one-hopefully-quick-question-re-randomtest/42027)
- ink-proof is a conformance-testing project for ink compilers and runtimes (title only, from search). — [chromy/ink-proof](https://github.com/chromy/ink-proof)
- Yarn Spinner GDScript's repo has a `tests` folder, a GUT config and optional runtime limits (`max_instructions_per_step`, `max_call_stack_depth`, off by default). No analysis tool is named on the page. — [YarnSpinner-Godot-GDScript](https://github.com/YarnSpinnerTool/YarnSpinner-Godot-GDScript)

### Inferences
- (inference) Recommended DT validator, in order of cost: (1) a headless GDScript bot that walks the narrative state machine with seeded random choices and logs which ending and which storylets were hit; (2) a deterministic breadth-first explorer over `(flags, qualities)` snapshots, with a depth cap and state hashing, to enumerate reachable endings; (3) export of the choice graph to JSON and a Python networkx script (unreachable nodes, dead ends, endings with no inbound path, cycles). Items 1 and 2 use the same engine code as the game, which avoids export drift.
- (inference) State-space explosion is the risk for exhaustive search. Keep qualities small and bounded integers, and collapse cosmetic flags out of the hash.
- (inference) The ending matrix (FLAG-02) is directly testable. Define it as a table of required quality ranges per ending, then assert each row is reachable and each reachable state maps to exactly one ending.

### Gaps
- No shipped team's testing practice was found and sourced (inkle, Failbetter, Yarn Spinner users). I did not retrieve the GDC Vault talk that appeared in results. A reliable source was not found; do not assert any team's practice.
- Yarn Spinner's own analysis features (e.g. variable and node analysis in the compiler) were not confirmed from docs.
- Model checking (e.g. TLA+, Alloy, NuSMV for narrative) was not researched.
- The `inkcheck` licence and maturity are unknown.

## 4. Open narrative source to deconstruct

### Takeaway
The best verified study object is inkle's The Intercept (MIT, Unity + ink, a small and complete branching script). Other candidates were named but not verified this session.

### Cited Findings
- inkle/the-intercept: MIT, copyright inkle Ltd 2016, includes Unity and ink plus bundled Newtonsoft Json.NET (MIT). It is described as a demo of how to structure a simple ink project with the Unity plugin. No attribution is required, though the authors would like to hear of ink use. Layout: `Assets/`, `ProjectSettings/`, `README.md`. The script is at `Assets/Ink/TheIntercept.ink`. 26 commits, no date shown. — [inkle/the-intercept](https://github.com/inkle/the-intercept)
- Dendry's repo includes example scene syntax and the automated player, so it doubles as a studyable small engine. — [aucchen/dendry](https://github.com/aucchen/dendry)
- Twine resources (ChapelR) collects Twine tooling and samples. — [ChapelR/twine-resources](https://github.com/chapelr/twine-resources) (title only, not read)

### Inferences
- (inference) What to learn from The Intercept's `.ink`: knot and stitch structure, how variables gate later scenes, how a single short scenario handles a few flag-driven endings. Read it with an eye to counting its endings and verifying them with the bot described in section 3.
- (inference) What to learn from Dendry: how qualities, `view-if`/`choose-if` and `max-visits` combine, and how a random-test harness is attached to a data format.
- (inference) Nothing here should be vendored. The Intercept is MIT, so reading and adapting patterns is legally fine. DT should rebuild ideas, not text.

### Gaps
- Not covered: the ink and Inky repos' example stories, open Ren'Py visual novels with licence checks, open Twine games, and Godot open-source games with dialogue and quest systems. None were searched or verified (call budget). Each needs a targeted search before it can be listed.

## 5. Dialogue tooling: Inky, ink runtimes, Yarn Spinner 3, Twine 2.10, Ren'Py persistence, Dialogue Manager conditions

### Takeaway
Dialogue Manager's condition and mutation syntax is simple and GDScript-native, with a few sharp edges. The Yarn Spinner GDScript port needs Godot 4.6+ and is still pre-release. Ren'Py's persistent store is the clearest documented model for cross-playthrough data.

### Cited Findings
Dialogue Manager conditions and mutations (read now; the prior report flagged this as unread):
- `if/elif/else`, `and`/`or`, parentheses, `match` with `when` branches (including comparisons such as `when > 5`) and `else`, and `while` (the body must mutate something or it may never exit).
- Response lines take `[if cond /]`, and a `=> goto` must come after the condition. Inline text conditions use `[if cond]text[/if]` with an `[else]` form. Random lines use `%`, with an optional condition after it (`% [if cond] => cue`).
- Mutations: `$> Global.method()` or `$> Global.prop = value`. `set` and `do` still work but are deprecated. Inline `[$> expr]` runs when typing reaches that point, and awaited inline mutations pause typing unless written `[$>> expr]`. Signals are emitted with `$> Global.some_signal.emit(args)`.
- State: autoloads by name, `using SomeGlobal`, `extra_game_states` (objects must be instantiated, not class references), `locals.` prefix, `self` as the running resource. Null-safe `?.` makes a null left side evaluate to false instead of crashing. Built-ins `wait(float)` and `debug(...)`.
- Not documented on that page: `once` and weighted randomisation, and what the number in `%2 =>` means.
— [Dialogue Manager Conditions_Mutations.md](https://raw.githubusercontent.com/nathanhoad/godot_dialogue_manager/main/docs/Conditions_Mutations.md) (read via a summarising fetch tool, so re-check exact syntax in the file before coding)

Other tools:
- Yarn Spinner for Godot GDScript is described in official docs as Alpha, with the advice to ship only with the C# version until it leaves testing. A June 2026 monthly update says it took big steps towards beta and that the two Godot versions are meant to be interchangeable. The repo page says "Early Access 3.3" and Godot 4.6 or later. Sources differ on the tag (the release URL reads v3.1a1 while the page text reads v3.2a1), and the repo's Releases section was empty. — [Yarn Spinner June 2026 update](https://www.yarnspinner.dev/blog/monthly_jun_26); [GDScript docs](https://docs.yarnspinner.dev/3.1/yarn-spinner-for-godot/godot-gdscript); [repo](https://github.com/YarnSpinnerTool/YarnSpinner-Godot-GDScript); [GodotCon post](https://yarnspinner.dev/blog/godotcon-amsterdam-2026/)
- Ren'Py persistent data: writes at exit or `renpy.save_persistent()`, loads before `init python`, custom classes must be defined in `python early`, picklable and implement equality. Fields starting `__` are name-mangled per file, so renaming a file breaks old values. `persistent._hasattr` tells "never set" from "set to None". `MultiPersistent` shares data across games by name and needs an explicit `.save()`. The page gives no rollback or security guidance. — [Ren'Py persistent docs](https://www.renpy.org/doc/html/persistent.html)
- Twine 2.10: see section 2 (dates conflict between listings; bundles Chapbook 2.3.0). — [Adaptiva listing](https://adaptiva.com/patch-library/1000001429_patch_for_twine_x64)

### Inferences
- (inference) Dialogue Manager's `extra_game_states` lets DT keep narrative state in a plain script or Dictionary without autoload coupling, which also makes conditions unit-testable.
- (inference) Because dialogue conditions are arbitrary GDScript, the validator in section 3 cannot statically analyse them. Keep conditions to reads of a small set of named qualities (for example `Q.get("trust_vox") >= 2`), so a script can regex-extract them. This is a real trade-off against Dialogue Manager's flexibility.
- (inference) DT's O-22 (dialogue format) should be decided partly on testability: a custom Resource format is easiest to validate, Dialogue Manager is the easiest to author, and Yarn GDScript is not yet shippable by its own docs' guidance.

### Gaps
- Inky editor features, ink C# runtime vs inkgd performance, and Twine 2.10 feature details beyond the patch listing were not researched. The "inkgd is slower" claim is from the prior report and was not re-verified.
- Ren'Py rollback and its persistent-vs-save interaction were not sourced.
- Dialogue Manager release date is not shown on the repo page.

## 6. Save schemas for narrative state

### Takeaway
Use JSON with an explicit `schema_version` and migration functions, store only primitives and stable string IDs, and never decode with `allow_objects`. The Godot docs support JSON for simple state and flag the object-decoding risk.

### Cited Findings
- Godot's saving tutorial (labelled 4.7 docs) recommends JSON for simple state ("human-readable files that are easy to debug") and binary (`store_var`/`get_var`) for more complex state, and ConfigFile for user configuration. JSON needs custom encoding for `Vector2`, `Vector3`, `Color`, `Rect2` and `Quaternion`. The tutorial shows a "Persist" group pattern where each node's `save()` returns a Dictionary, and notes nested persistent nodes need staged loading. — [Godot saving games](https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html)
- `FileAccess.get_var(allow_objects=false)`: "Deserialized objects can contain code which gets executed. Do not use this option if the serialized object comes from untrusted sources to avoid potential security threats such as remote code execution." `store_var(full_objects=false)` allows encoding objects "and can potentially include code". — [FileAccess class docs](https://docs.godotengine.org/en/stable/classes/class_fileaccess.html)
- Questify exposes its own serialize/deserialize to Array/Dictionary, which is JSON-friendly. — [Questify](https://github.com/TheWalruzz/godot-questify)
- Ren'Py's persistent merge function (union of seen endings) is a worked example of cross-version or cross-device merge policy. — [Ren'Py persistent docs](https://www.renpy.org/doc/html/persistent.html)

### Inferences
- (inference) Candidate schema: `{ "schema_version": 3, "run": { "qualities": {id:int}, "flags": [id], "members": {id:"alive|abandoned|deceased"}, "rooms": {room_id:{...}}, "objects": {obj_id:{...}} }, "log": [event ids] }`, with the profile file separate (`endings_seen`, `secret_unlocked`, `ng_plus`). Stable string IDs (never array indexes or node paths) are what make migration possible.
- (inference) Migration pattern: `migrations: Dictionary[int, Callable]`, applied in order from the file's version to current; keep every migration forever; test with committed fixture saves per version. Write saves to a temp file then rename, and keep one backup.
- (inference) A Resource-based save (`.tres`/`ResourceSaver`) is easy but loading an untrusted `.tres` can run embedded script, so it carries the same class of risk as `allow_objects`. This is my reasoning from the get_var warning, not a documented statement about ResourceLoader (unverified). Prefer JSON for anything a player could share or edit.
- (inference) Whether to store a snapshot only or snapshot plus event log: snapshot is the save, and the log (if kept) is capped and used for debugging and to replay a regression.

### Gaps
- No sourced example of a shipped game's versioned save format. Not researched: ConfigFile limits, Godot Resource-loading security docs, and New Game+ carry-over patterns from named games.

## 7. DT translation: one candidate architecture (option to evaluate, not a decision)

### Takeaway
Candidate: a single `NarrativeState` autoload (bounded-integer qualities plus a flag set), per-member status enum, Wave-Lock as a small state machine, and the ending matrix as a data table checked by a headless explorer. Dialogue format (O-22) stays open and plugs in through a thin condition-query interface.

### Cited Findings
- The brief's constraints apply: Godot 4.7.1 standard build in GDScript, C# unusable, T1 locked to Vox and Ciphera, one small map, one micro-choice, no permadeath. — [00_DT_context_brief.md](/home/user/project-dystenic-transmission/research_notes/Dystenic%20Transmission%20feature%20deconstruction/00_DT_context_brief.md)

### Inferences
Sketch (inference throughout):
- **Qualities** (Dictionary[StringName, int]): trust and knowledge values, tone counters per category (harmonic, missed, silence, chord), signal state per context (Clear, Distorted, Fragmented, Encrypted, an enum).
- **Flags** (set of StringName): one-shot facts such as `wave2_gate_opened`.
- **Waves and Wave-Lock:** `wave` int plus a per-wave lock record of required flags. Chapter progress is stored as a per-character cursor so the five-protagonist, 21-segment prologue can be resumed. A lock opens when its requirement expression over qualities and flags is true.
- **Members:** Dictionary[member_id, enum {ALIVE, ABANDONED, DECEASED}] (FLAG-13 kept as separate states). Permadeath rules are not implemented at T1.
- **Ending matrix (FLAG-02):** a data table of ending id to quality and flag requirements, evaluated at the end. A unit test asserts each ending is reachable and no state maps to two endings.
- **Storylet layer (T2 option):** a deck of storylet Resources with requirement expressions, ported from the TinyQBN/SimpleQBN pattern.
- **Interface:** `NarrativeState.check(expr)` and `NarrativeState.apply(mutation)`, the only entry points for Dialogue Manager, Questify or a custom format. This isolates O-22.
- **Validation:** headless seeded bot (T1) and BFS explorer (T1.5), then networkx graph checks (T2).
- **Saves:** JSON with `schema_version` and a separate profile file, as in section 6.

| Action | Item | Tier | DT system |
|---|---|---|---|
| Borrow | Ren'Py persistent-vs-run split and custom merge (union of endings seen) | T1.5 | New Game+ (FLAG-12), secret ending (FLAG-09) |
| Borrow | Questify's "you answer the condition query" pattern (MIT, GDScript, Godot 4) | T1 | Wave-Lock gating |
| Borrow | Dendry `random-test` idea: seeded random playthrough bot | T1 | Wave-Lock, micro-choice validation |
| Adapt | TinyQBN/SimpleQBN storylet deck, rewritten in GDScript | T2 | Branches that compound, signal states |
| Adapt | Dialogue Manager `extra_game_states` and `locals` scoping (MIT, Godot 4.6+) | T1 | dialogue (O-22 still open) |
| Adapt | Ren'Py `MultiPersistent` idea for a profile file separate from run saves | T1.5 | save schema |
| Enhance | Deterministic BFS explorer over `(flags, qualities)` that proves every ending in the matrix is reachable | T1.5 | ending matrix (FLAG-02) |
| Enhance | Versioned JSON saves with migration fixtures and atomic write | T1 | save schema, per-member status |
| Enhance | Restrict dialogue conditions to named-quality reads so a static checker can parse them | T1 | validation, tones and signal states |
| Avoid | `FileAccess.get_var(..., allow_objects=true)` and loading shared `.tres` saves | T1 | save schema (security) |
| Avoid | Adopting Yarn Spinner GDScript for shipping now (docs say Alpha; YSPL licence restrictions) | T1 | dialogue (O-22) |
| Avoid | Fact-database rule matching and a full storylet engine before T2 | T1 | scope lock |

### Gaps
- None of the above is validated in a running Godot project; no Godot binary is available here. Any prototype needs the author's executable path to run.
