# Independent Blind Playtest & Adversarial Code Audit — `[Project]` (Track D, Round D3)

## Inputs supplied by the Producer

- **Frozen review packet:** `output/d3-packet/` inside this workspace, containing:
  - `output/d3-packet/VERIFIED-METRICS.md` (Producer-verified test/build metrics, bundle sizes, screenshot inventory, and any Founder playtest notes)
  - `output/d3-packet/candidate-codex/` (frozen source, tests, assets, and D2 report)
  - `output/d3-packet/candidate-claude/` (frozen source, tests, assets, and D2 report)
  - `output/d3-packet/candidate-gemini/` (frozen source, tests, assets, and D2 report)
- **Save your written critique directly to:** `output/D3-critique.md`

## North Star and adjudication goal

`[Insert concise Founder North Star and, if preliminary Producer/Founder evaluation identified a leading backbone candidate, state it openly while instructing reviewers to challenge it directly whenever evidence warrants.]`

## Assignment (fresh-session, read-only playtest + adversarial audit)

Work in **two explicit passes** so walkthrough knowledge does not contaminate your playtest:

### Pass 1 — Blind exploratory playtest (do this BEFORE reading golden paths or walkthroughs)
- Drive each candidate's game engine (via a quick headless harness or local browser/Playwright check) using ordinary, uncoached player inputs—including synonyms, compound phrases, off-path exploration, `WAIT`/world-tick checks, save/load mid-session, and edge-case mistakes.
- Record concrete transcripts/observations: where the game feels alive, atmospheric, and generous vs. where it breaks immersion, misparses natural commands, softlocks, leaks spoilers, or glitches visually.

### Pass 2 — Adversarial code, contract & architecture audit
- Inspect `VERIFIED-METRICS.md`, `output/D2-report.md`, and the actual code and tests across all three frozen candidates. Tie every finding to exact `file:line` citations and tag severity (`[BLOCKER]`, `[IMPORTANT]`, `[SUGGESTION]`):
  1. **Backbone stress-test:** Hunt for real bugs, softlocks, parser/simulation loopholes, save/load corruption, engine-vs-content leakage, bundle/dependency bloat, and cross-browser/viewport hazards in the leading candidate (and across all three). Challenge any preliminary backbone choice if concrete evidence favours another candidate.
  2. **Targeted harvest (and explicit exclusions):** Identify the highest-value, low-bloat fixes, mechanics, UI touches, or content ideas from peer builds worth importing—and state explicitly what should **not** be merged to avoid complexity sprawl.
  3. **Extensibility check ("new content test"):** Judge honestly how painful or clean it would be for an author (or offline coding agent) to drop a brand-new adventure/level into each candidate's contract.

## Strict boundaries (read-only, fast round)

- **Read-only critique:** Do **not** edit any repository files, modify the frozen packet, install global packages, or make Git commits.
- **Bounded checks allowed:** You may run short read-only playtest scripts, unit tests, or headless browser checks strictly against the frozen packet to reproduce playability or code bugs; list what you ran in your header.
- **Strict isolation:** Inspect only this workspace and its frozen packet. Do **not** read live peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect the adviser repository (`research-advisor`), read unrelated local repos, or query/post to any Correspondence Board.

## Output and stopping contract

Write **~1,200–1,800 words** directly to **`output/D3-critique.md`** (touch no other files). Start with:

- `Round:` `[Project] Track D — Stage 3 Blind Playtest & Adversarial Audit`
- `Reviewer model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `Packet inspected:` `output/d3-packet/ ([candidate commit SHAs])`
- `Blind playtests & reproducers run:` `[brief list of live playtests / < 10 s reproducers executed]`
- `Status:` `ready for review`

Stop after saving `output/D3-critique.md` and give only a brief confirmation.
