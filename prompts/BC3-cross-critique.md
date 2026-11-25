# Independent Cross-Critique — `[Project]` (Track `[B|C]`, Round `[B3|C3]`)

## Inputs supplied by the adviser

- **Frozen review packet:** `output/[b3|c3]-packet/` inside this workspace, containing:
  - `output/[b3|c3]-packet/VERIFIED-METRICS.md` (adviser-verified build/check, test/oracle, and uniform process-tree resource metrics across all three frozen Stage 2 commits)
  - `output/[b3|c3]-packet/candidate-codex/` (frozen source, tests, analyses and Stage 2 report)
  - `output/[b3|c3]-packet/candidate-claude/` (frozen source, tests, analyses and Stage 2 report)
  - `output/[b3|c3]-packet/candidate-gemini/` (frozen source, tests, analyses and Stage 2 report)
- **Save your written critique directly to:** `output/[B3|C3]-critique.md`

## North Star and adjudication goal

`[Insert concise statement of the lead scientist's standing North Star—e.g. tool-first litmus test or core scientific question—and, if preliminary adviser evaluation identified a leading backbone candidate, state it openly while instructing reviewers not to defer to it.]`

## Assignment (fresh-session, read-only adversarial audit)

Inspect `VERIFIED-METRICS.md` and read the actual code, tests, analyses and reports across all three frozen candidates. Tie every finding to exact `file:line` citations and tag severity (`[BLOCKER]`, `[IMPORTANT]`, `[SUGGESTION]`):

1. **Adversarial audit of the leading candidate (or all three builds):** Hunt for real bugs, mathematical/statistical errors, data leakage, contract loopholes, portability/packaging traps, scaling/memory cliffs and usability friction for real domain users (and their AI agents). Challenge any preliminary backbone choice directly if concrete code or scientific evidence supports another candidate (or shows all three share a flaw).
2. **Targeted harvest (and explicit exclusions):** Identify the highest-value, low-bloat fixes, tests, algorithms or methodological checks from peer builds worth importing—and state explicitly what should **not** be imported to prevent complexity creep or dual-engine sprawl.
3. **Reconcile material discrepancies:** Trace concrete causes (citing exact code, equations or parameters) behind any substantive scientific or numerical disagreements across the three Stage 2 reports, plus any silent weakness affecting a reported claim.

## Strict boundaries (read-only, fast round)

- **Read-only critique:** Do **not** edit any repository files, modify the frozen packet, install packages, run heavy simulations, or make Git commits.
- **Tiny reproducers allowed:** You may run brief (`< 5 s`) read-only snippets sourcing code from the frozen packet strictly to confirm a suspected bug or edge case; list any checks run in your header.
- **Strict isolation:** Inspect only this workspace and its frozen packet. Do **not** read live peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect `~/work/research-advisor`, read unrelated local repos, or query/post to any Correspondence Board.

## Output and stopping contract

Write **~1,200–1,800 words** directly to **`output/[B3|C3]-critique.md`** (touch no other files). Start with:

- `Round:` `[Project] Track [B|C] — Stage 3 Independent Cross-Critique`
- `Reviewer model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `Packet inspected:` `output/[b3|c3]-packet/ ([candidate commit SHAs])`
- `Live reproducers run:` `[none, or brief list of < 5 s checks actually executed]`
- `Status:` `ready for review`

Stop after saving `output/[B3|C3]-critique.md` and give only a brief confirmation.
