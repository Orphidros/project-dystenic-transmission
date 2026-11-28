# Decision records: 2026-11-28, research tooling

Written in the Claude Code session where the author ruled, the same day (OQ-068). The Project's canon documents stay the authority; where this file and they differ, they win.

## 2026-11-28
- **CoD-17 · Firecrawl's MCP server for research, and a replay-test proposal for Beat-State.** The author reviewed five public repositories with Claude Code (Firecrawl, rea-games, CLI-Anything, DeerFlow and raea). On the two Claude Code put first, he said: "Do both in the order you presented". That means:
  1. Set up Firecrawl's MCP server, pinned, with the key kept out of the repository, and test it on a page our research couldn't read.
  2. Read rea-games' code and its GAME.md format, and draft a replay-test design for Beat-State as a proposal for the Systems & Code thread.

  Thread: a Claude Code session (Systems & Code's repository).
  - Code for the first part: `.mcp.json` and `docs/tooling/firecrawl-mcp.md` (commit `258de3b`). The API key is a network secret on the author's cloud environment, and a local-scope setting on his PC, never in the repository.
  - The second part's proposal: `design/proposals/2026-11-28_beat-state-replay-tests.md` (commit `258de3b`). It is not a ruling; the Systems & Code thread takes it up.
  - Left as they were: CLI-Anything (maybe later), DeerFlow (study its skills only) and raea (parked).

## Notes from Claude Code (not rulings)
- **Use limits.** Firecrawl is for pages that are merely JavaScript-heavy, not for getting around sites that deliberately block bots or charge for access.
- **The pin.** `firecrawl-mcp` is pinned at 3.40.0, chosen because it had been out for two weeks.
