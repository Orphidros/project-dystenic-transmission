# Primary developer sources on branching, consequence tracking and music-driven story (round 2, track 08)

Tags: [P1] developer-authored; [P2] outlet quoting the developer; [S] secondary. Only pages I opened are cited. Search-result-only items are listed under Gaps and are not evidence. Page fetches return model-summarised extracts, so quotes are as extracted and short. Checked against 06_primary_dev_statements.md and round 1 notes 07, 08 and 12. Findings already there (Until Dawn butterfly node tool and Reznick quote, Failbetter "storylets are discrete chunks", Sasko on Vesemir, Quarry tracking burden, Darkest Dungeon) are not repeated except where upgraded. Date of research: 2026-11-05. Budget overran (about 20 calls), so several questions stay open.

## Disco Elysium (ZA/UM): skills, Thought Cabinet, state tracking

### Takeaway
One developer-quoted page was obtained: Kurvitz at Rezzed 2018 describing remembered actions, failed checks locking options, and a visual dialogue tool. Nothing on why skills speak as voices, and no ZA/UM blog or Articy:draft article was reached.

### Cited Findings
- Kurvitz: the team designed around the fact that "people remember that you said or did certain actions", so choices are tracked and later content references them. [P2] ([GameAnalytics, Rezzed 2018 interview](https://www.gameanalytics.com/blog/disco-elysium-rezzed-2018-interview))
- Kurvitz: a failed stat check, his example being flirting, locks a dialogue option; stats also carry consequences such as psychoses. [P2] (same page)
- Kurvitz: side cases can feed the main case and "start merging". [P2] (same page)
- Tooling: "a program which gives us a bit more flexibility and pace" for visual dialogue-tree programming. The page does not name the tool, so the Articy:draft link is **not confirmed**. [P2] (same page)
- Scale and difficulty: 8-person writing team; about 25 staff, none had made a game; he called the branching work "The Mind Shatterer" and said QA, playtesting and integration still lay ahead. [P2] (same page)
- Thought Cabinet at this date: adopting a political outlook "becomes a thought in your head", and finishing it gives a bonus but requires acting on it. [P2] (same page)

### Inferences
- The "failed check locks an option" pattern is the cheapest model for DT tones: a missed note closes a line or beat rather than adding a branch.
- Remembering everything by default (see inkle below) and tracking "said or did" are both log-first designs, which suits a DT event log feeding the ending matrix.

### Gaps
- No page on skills-as-voices rationale; Thought Cabinet creation (GameSpot Audio Logs) and a Kurvitz developer blog were seen only as search listings. Articy:draft use unconfirmed. The page itself said it does not describe skills as voices.

## CD Projekt RED: delayed consequences and branching cost

### Takeaway
Game Developer's GDC 2023 write-up of Sasko's talk supplies a developer-sourced rule: delayed payoffs land hardest, but only if telegraphed. It states nothing about branching cost or state storage.

### Cited Findings
- "Delayed and 'really delayed' consequences make the biggest impression on players"; bring earlier choices back "at the least expected time". [P2, the page states these are its summary of Sasko's talk, not direct quotes] ([Game Developer, GDC 2023 summary](https://www.gamedeveloper.com/marketing/10-key-takeaways-from-the-quest-design-of-cyberpunk-2077-and-the-witcher-3))
- "Design for the visibility of consequences; investing in something not telegraphed well is mostly not worth it." [P2, same caveat] (same page)
- Branching cost, tracking state and playtesting: **not covered** on this page.

### Inferences
- This conflicts mildly with DT's no-label rule: CDPR's advice is to telegraph. DT's tones are the telegraph, so the rule is satisfied if the tone is audible at the choice and the payoff arrives Waves later.
- Delayed payoff across Wave-Lock boundaries fits the Information Ordering Contract, with the cost that early choices must be logged until a later Wave consumes them.

### Gaps
- GDC Vault page 1028897 appeared only in search; the talk was not opened. No CDPR statement on Witcher 2 split cost, Witcher 3 flag storage, or quest-designer headcount (a GameRanx figure was seen only in a search summary). No new Witcher 2 source.

## Supermassive: tracking, scenes without a dead character

### Takeaway
Game Informer's Until Dawn interview with Will Byles gives tool and design intent, but nothing on how scenes absorb a dead character or on ending counts. No Quarry tooling source was reached.

### Cited Findings
- The node program linked story, script, interactions and gameplay "both to a branching network but also vertically within a stack", letting the team follow a thread to its consequence. [P2] ([Game Informer, Afterwords](https://gameinformer.com/b/features/archive/2015/10/18/afterwords-until-dawn.aspx)). Round 1 note 07 already cites this tool; the quoted wording here is new.
- Byles: the Butterfly Effect exists to show a consequential choice and "the chain of events that had led to that consequence". [P2] (same page)
- Byles: a perspective-shift structure works only if "you cannot go back to a previous save"; that is a design constraint on save rules. [P2] (same page)
- Testing: "we were always surprised by people's choices"; the team expected players to shoot Chris and the result was "much closer to 50-50". [P2] (same page)
- Post-run global choice statistics are offered after a first playthrough. [P2] (same page)

### Inferences
- The save-rule remark supports a DT Wave-Lock rule: if consequences are meant to be held, restrict rewinding past a Wave boundary (author decision).
- Surprised playtesters argue for logging choice rates in playtests before tuning which consequences to authorise.

### Gaps
- Dead-character absorption, ending counts, The Quarry tools: not found. Destructoid's "hundreds of endings" stays [S] from round 1.

## inkle: Ingold and Humfrey on state and branching cost

### Takeaway
Ingold states two usable design principles: ink remembers everything seen by default, and content can grow without a flowchart. Sorcery! gives a scale figure for tracked state.

### Cited Findings
- Ingold: "I wanted it to remember everything that you'd ever seen, by default"; "You didn't have to define variables to track things." [P2] ([MCV/DEVELOP, 2021](https://www.mcvuk.com/development-news/want-your-story-to-drive-your-game-rather-than-vice-versa-inkle-and-failbetter-discuss-the-storytelling-potential-of-the-open-source-ink/))
- Ingold on flowcharts: producers ask for them for reassurance, "They don't really read it"; Heaven's Vault is cited at roughly 3,000-4,000 possible lines. [P2] (same page)
- Humfrey (spelled "Humphrey" on the page) argued the tool had to evolve because it was "the core pipeline". [P2] (same page)
- Emily Short on Failbetter's use: ink tracks state and substitutes variable text "with less friction" than a "massive stack of if-statements"; they draft directly in ink then edit in VS Code. [P2] (same page)
- Sorcery!: "695 individual variables carried over from Part 3 into Part 4"; script "adapts itself on the fly"; series is about 1.5 million words; Part 2 added "about half as much content again". [P2] ([Game Developer, Q&A, 2016-01-25](https://gamedeveloper.com/design/q-a-jon-ingold-on-i-sorcery-i-and-crafting-interactive-fiction))
- Ingold: "in games, constraints are almost always good!" (limiting spells). [P2] (same page)

### Inferences
- 695 carried variables is a proof that large state is workable when tooling remembers it, but DT's FLAG-02 cap suggestion (5-6 ending inputs) is about authorability of the matrix, not storage. A seen-set (event log) plus a short list of ending inputs is the combination to consider.
- "Constraints are good" supports a small, fixed ending-input list.

### Gaps
- Joseph Humfrey's own writing: none found. The inkle blog was not reached. No inkle statement on testing or cost per branch.

## Failbetter: storylets and quality-based narrative cost

### Takeaway
Failbetter's own 2011 post names the limits of quality-driven design; Kennedy's GDC 2016 write-up gives the cost framing (brute force is expensive; use cheap choice points and visible consequences).

### Cited Findings
- Nigel (Failbetter), 2011-07-09: "Quality based narrative isn't good at having a series of things that need to happen in order"; one quality reused for different jobs; the number of qualities must be kept down; many qualities controlling ordered events leads to "unexpected behaviour". [P1] ([Failbetter, Don't Poke That, part 1](https://www.failbettergames.com/dont-poke-that-narrative-engineering-principles-part-1)). The page has no statements on content cost or testing.
- Kennedy, GDC 2016: you can feed choice-based narrative "with brute force" but it is expensive; cheaper alternatives are single decisions that alter later experience; "The more that's happening, the less the player notices"; an unnoticed consequence "wasn't actually a consequence". [P2] ([Game Developer, Kennedy GDC 2016](https://gamedeveloper.com/design/failbetter-s-kennedy-good-game-story-is-like-a-well-mixed-cocktail)). Note: round 1 note 07 listed this talk as not reached.

### Inferences
- Direct fit for the Information Ordering Contract: Failbetter says quality-gating is poor at strict ordering. If DT's contract requires facts in order, a Wave-Lock state machine should enforce order and qualities should only vary tone and fragments within it.
- Kennedy's "unnoticed is not a consequence" plus CDPR's visibility rule both back an audible tone at every consequential beat.

### Gaps
- No Failbetter post on content cost per storylet; the "Fallen London free-to-play" post was seen only in listings.

## Music and story: Metronomik, Tango Gameworks, D-CELL

### Takeaway
Only a search snippet on No Straight Roads and no new page for Hi-Fi Rush or UNBEATABLE were obtained. These sub-questions are largely unanswered.

### Cited Findings
- The Unreal Engine developer interview with Metronomik (Daim Dziauddin and Wan Hazmer) came up in search, but my fetch of that page returned HTTP 403. Nothing on it is evidence.

### Inferences
- None made.

### Gaps
- No readable Metronomik, Tango (beyond 06's GDC page), or D-CELL material this round. Search snippets (not opened) report that NSR boss fights each tell a story and that music adapts to player actions; they are unverified here. Recommend a retry of the Unreal page through another route.

## Endings: keeping the matrix authorable

### Takeaway
No developer source on ending-matrix authoring was retrieved. The Sawyer ending-slide article truncated to its headline.

### Cited Findings
- PC Gamer headline only (body truncated on fetch): a minor New Vegas quest received its own slide "because the team was transfixed by the choice". [S, headline only] ([PC Gamer](https://www.pcgamer.com/games/fallout/a-minor-fallout-new-vegas-quest-got-its-own-ending-slide-because-the-team-was-transfixed-by-the-choice-where-you-make-the-ncrs-worst-soldiers-take-psycho/))

### Inferences
- Headline-level evidence suggests slide selection was curated, not exhaustive, which supports a limited per-member card set. Weak support; do not rely on it.

### Gaps
- Sawyer's quoted claims ("mostly arbitrary", "huge amount of variety and reactivity") appeared only in a search summary of secondary pages and are unverified. No Supermassive ending-count statement. Do not cite Tim Cain's "implementing endgame slides" mirror.

## Mapping to DT (options, not rulings)

| Finding | DT system | Option |
|---|---|---|
| Failbetter: qualities poor at ordering | Information Ordering Contract | A: Wave-Lock state machine fixes order, qualities vary only tone/fragments. B: add a "requires fact X seen" check per beat |
| Ingold: remember everything seen by default | Ending matrix FLAG-02 | A: event log plus a short list of derived ending inputs. B: counters only |
| Kennedy and CDPR: consequences must be noticed/telegraphed | Tones, signal states | Audible tone at each consequential beat; payoff Waves later |
| Kurvitz: failed check closes an option | Signal states Clear to Fragmented | Fragmented state removes a line rather than adding a branch |
| Byles: no rewinding past a perspective shift | Wave-Lock, FLAG-13 | Autosave at Wave boundary and no reload of past a lost member (author decision) |
| Byles: playtesters surprised | Pair-bond integer | Log bond and choice rates in playtests before tuning |
| Sorcery! 695 variables | FLAG-13 status enum | Enum stays small; richness comes from the log |

## Borrow / Adapt / Enhance / Avoid

| Item | Verdict | Tier | DT system | Note |
|---|---|---|---|---|
| Log everything seen, derive flags later (ink) | Borrow | T1 | pair-bond, ending matrix | Cheap to start; log is free to add now |
| Failed check closes a line (Disco Elysium) | Adapt | T1.5 | Signal states | Needs line-level authoring |
| Delayed, telegraphed payoff (CDPR) | Adapt | T1.5 | Wave-Lock | One payoff per two Waves |
| Quality-gated strict ordering | Avoid | T1 | Information Ordering Contract | Failbetter says it misbehaves |
| Visible butterfly icon (Until Dawn) | Avoid | T1 | Tones | Already decided in round 1 |
| Reload restriction at Wave boundary | Adapt | T1.5 | Wave-Lock | Author decision |

## Design questions this raises for DT
1. **Information Ordering Contract:** Failbetter says quality-gating cannot enforce order. Should order live in the Wave-Lock state machine, with qualities used only for tone variation?
2. **Event log vs counters (FLAG-02):** Ingold's remember-everything default suggests logging every tone event. Is the ending matrix computed from the log or from a short list of counters?
3. **Reload rules:** Byles ties perspective shifts to forbidden rewinds. Can the player reload past a Wave boundary or after a lost member?
4. **Telegraphing (tones):** CDPR and Kennedy say unnoticed consequences are wasted. How audible must a tone be on a first-time listener, and how is that tested?
5. **FLAG-13 enum:** Is a three-value status enough, given Sorcery!'s evidence that richness comes from logged history rather than state values?
6. **Pair-bond playtest logging:** Supermassive was surprised by playtest choice rates. Which bond inputs get logged from the first build so tuning has data?
