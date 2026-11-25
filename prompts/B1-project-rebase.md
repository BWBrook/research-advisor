# Independent Project Rebase & Conception — `[Project]` (Track B, Round B1)

## Inputs supplied by the adviser

- Lead scientist's North Star, motivation and known constraints: `[insert text or reference INPUT.md]`
- Curated single-commit baseline repository: this isolated, remote-free workspace at `[baseline commit]`
- Additional read-only reference/data packet, if any: `[resources/ path, or none]`
- Save your conception brief directly to: `output/B1-conception.md`

## Assignment

Inspect this curated intermediate repository independently and critically. Your goal is to rebase and complete it into the strongest worthwhile, feasible and scientifically defensible tool, model or analysis it can support—**not** to rubber-stamp inherited architecture or turn unfinished work into a premature paper. Challenge existing design decisions, abstractions, dependencies, scope and assumptions wherever evidence warrants.

Address:

1. **Frank diagnostic of the inherited baseline:** What is genuinely valuable and worth preserving vs. what is over-engineered, brittle, slow, redundant or dead weight? Where would a clean redesign beat incremental patching?
2. **North Star & product shape:** What should the primary deliverable be (e.g., reusable package/tool, benchmark, or analysis—defaulting to *not* paper-shaped unless explicitly requested), and what makes it genuinely adoptable rather than an incremental patchwork?
3. **2–3 distinct rebase directions (and one recommendation):** Lay out concrete strategic options—including what you would keep, drop or rebuild—and recommend the strongest path (or recommend stopping/narrowing if warranted).
4. **Minimum defensible completion vs. stretch goals:** Define what makes the rebased project genuinely complete and ready for its audience, separated cleanly from optional stretch goals that must not block delivery.
5. **Verification oracles, hard gates & risks:** What analytical/exact oracles, tests, scaling/memory gates, or falsifiable checks are essential to trust the result? What conceptual, computational or data risks could force simplification or stopping?

Be explicit about what is established from inspecting this workspace and verified primary sources, what is assumed, and what remains unknown.

## Preliminary checks and boundaries

- **Bounded checks only:** You may inspect the supplied workspace/`resources/` and run tightly bounded primary-source lookups on competing tools, methods or literature. Cite only sources you actually inspect, disclose access limits, and label unverified novelty claims as unverified.
- **No execution or edits:** Do **not** edit repository files, refactor code, install environments, run simulations/benchmarks, or make Git commits during B1.
- **Strict isolation:** Work completely independently. Do **not** query or post to any Correspondence Board (MCP or otherwise), read peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect `~/work/research-advisor`, read unrelated local repositories, rely on cross-workspace memory or prior chats on this topic, or add Git remotes / push.

## Output and stopping contract

Write the complete brief (~1,000–1,500 words) directly to **`output/B1-conception.md`** (touch no other files). Start with:

- `Common input:` `[curated baseline commit / INPUT.md identifier]`
- `Model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `External checks:` `[none, or brief list of live sources/lookups actually run]`
- `Status:` `ready for review` (or `blocked: <precise reason>`)

Stop after saving `output/B1-conception.md` and give only a brief confirmation. The adviser and lead scientist will compare all three independent rebase conceptions before agreeing the B2 charter.
