# Firecrawl MCP server: setup and use

Adopted for a trial on 2026-11-28 (CoD-17). It lets Claude Code read web pages that our usual fetch tools can't, mainly pages that build their content with JavaScript after they load.

## What is installed

- **The server:** `firecrawl-mcp@3.40.0`, Firecrawl's official MCP server (MIT, github.com/firecrawl/firecrawl-mcp-server). It needs Node 22 or later.
- **Pinned on purpose.** `.mcp.json` names an exact version, never `@latest`. 3.40.0 was 16 days old when chosen; versions out for a couple of weeks are less likely to be a freshly hijacked release. To update, pick a version at least two weeks old, read its release notes, and change the one line in `.mcp.json`.
- **The Firecrawl service** itself is AGPL-3.0. That only matters to someone who modifies and serves it, so it doesn't touch DT.

## Where the API key lives: never in the repository

The repository is public (OQ-138). `.mcp.json` holds no key: it reads `FIRECRAWL_API_KEY` from the environment, and falls back to the placeholder `proxy-injected`.

- **Cloud sessions (the "Mobile Sandbox" environment).** The key is saved as a network secret for `api.firecrawl.dev`, and the session's proxy adds it to every request to that host. The placeholder is all the server ever sees. Most cloud sessions load the project's servers without asking.
- **Your Windows PC.** Add a local-scope copy of the server with your real key. Local scope is stored in your user profile (`~/.claude.json`, under this project's path), not in the repository, and it wins over the project's `.mcp.json`. Run this from the repository folder:

  ```
  claude mcp add firecrawl --scope local -e FIRECRAWL_API_KEY=fc-YOUR-KEY -- npx -y firecrawl-mcp@3.40.0
  ```

  If it shows as failed in `claude mcp list` on native Windows, `npx` may need a command shell to start it. Remove it and add it again with `cmd /c` in front of `npx`. Claude Code's MCP docs don't cover this case, so try the plain form first.
- **Approval.** The first interactive session in this folder asks you to approve the project's `firecrawl` server. To undo a choice, run `claude mcp reset-project-choices`.

## Test, 2026-11-28 (cloud session, server 3.40.0)

The page was Hollow Knight's Steam news hub (`store.steampowered.com/news/app/367520`), which gave our round 2 research only its navigation.

| Method | Result |
|---|---|
| Plain fetch | 175 visible words, no news posts |
| Firecrawl, default scrape | 276 words, mostly page metadata |
| Firecrawl, `waitFor: 8000`, `onlyMainContent: false` | 1,056 words, including the patch-note posts ("Patch Version 1.5.12620 Now Live", "Small Update / Patch Notes", …) |

**Lesson:** pages that load their content after opening need `waitFor` (in milliseconds) and sometimes `onlyMainContent: false`.

## How to use it well

These are recommendations, not rulings.

- **Use it for pages that are merely JavaScript-heavy,** such as Steam, store pages and modern blogs.
- **Don't use it to get around a site that deliberately blocks bots or charges for access.** Fandom's 402, GameFAQs' and TCRF's 403 and Cloudflare challenges are examples. That can breach the site's terms, so find another source.
- **Prefer primary sources.** Developer posts, patch notes and official docs still win, as in round 2's evidence tiers.
- **Mind the credits.** Each scrape costs Firecrawl credits, and crawls and agent runs cost many. The `firecrawl_credit_usage` tool shows what's left.
- **The tools that matter most:** `firecrawl_scrape` (one page), `firecrawl_search` (search, with page contents), `firecrawl_map` (every URL on a site) and `firecrawl_interact` (click and scroll through a page). The server offers 32 tools in all.
