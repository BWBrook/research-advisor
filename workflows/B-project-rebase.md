# Track B: Project rebase & completion

**Use when:** Picking up a partially built, stalled, or sprawling repository (existing code, models, analyses, tests, or exploratory notebooks—often carrying prior AI-agent roadmaps or sunk-cost architecture) that needs critical rebasing, independent autonomous rebuild/execution, evidence-led adjudication and—only if explicitly triggered by the lead scientist—final communication.

**Track boundaries:** Do **not** import Track A's science-complete assumption here, and do not use Track B to reopen a Track A manuscript rescue. If you are starting from a bare (or nearly bare) repository with an idea and no prior code or ideation, use [Track C: Tabula-rasa research](C-tabula-rasa.md).

**Default: not paper-shaped until the lead scientist pulls the trigger.** Resist agents' reflex to turn every tool, model or analysis into a journal manuscript prematurely. Establish upfront whether the primary product is a **reusable scientific tool/package**, a **research analysis**, or a **benchmark/dataset**—keeping technical documentation thorough without forcing paper ceremony before the lead scientist chooses to write a paper.

## Stage 1 — Curated baseline & independent rebase conception (B1)

1. The lead scientist supplies the existing repository, motivation, North Star, and any known pain points or constraints.
2. Build curated single-commit, remote-free clones (`scripts/build-isolated-clones.sh --workflow B`) to strip `git log`, `origin`, stale check/build dumps, and prior agent roadmaps/handovers while keeping active code, tests, examples, data and design contracts. Stripping prior roadmaps is essential so all three scientists judge the work on its merits rather than anchoring on an earlier agent's tactical script.
3. Issue [B1-project-rebase.md](../prompts/B1-project-rebase.md) independently to all three scientists in isolated workspaces (`~/codex/<slug>`, `~/claude/<slug>`, `~/gemini/<slug>`).
4. Ask each for a frank diagnostic of the inherited repository: what is sound vs. over-engineered or broken, what to keep vs. delete/rewrite (no backwards compatibility unless explicitly required), 2–3 distinct rebase directions with one recommendation, the minimum defensible completed contribution, optional stretch goals, required verification oracles/gates, and conceptual or feasibility risks. Allow bounded checks of the workspace and primary sources—not unrequested coding or refactoring.

## After B1 — Compact project charter (reward & invariant design)

Compare the three independent rebase conceptions before shared deliberation, then write a compact charter following `docs/operating-notes.md` §0 (specify outcomes, hard epistemic/engineering invariants and falsifiable checks; leave internal architecture unconstrained):

- The core North Star and why it matters (explicitly clarifying tool-first vs. study-first).
- What inherited contracts must hold vs. what legacy clutter may be dropped cleanly.
- Minimum defensible completed contribution and essential deliverables.
- Optional stretch goals that must not block completion.
- Hard epistemic and engineering guardrails, resource bounds and decisions that materially change the objective. When setting performance gates on software, state a **single-unified-engine invariant** explicitly so a fast-optimising scientist speeds up the composable tool rather than bolting on a fixed-schema compiled sidecar.
- Common evaluation standard: analytical/exact oracles, protected checks, uniform resource budgets (parent + worker process-tree memory), and independent reproduction.
- Honest stopping criteria for an infeasible, negative or null result.
- How the completed contribution will reach its intended audience (public package/PR/release, archive, docs/examples, or—only when explicitly triggered—a manuscript).

**Plain-English gut-check before launching B2:** Give the lead scientist a concise, jargon-free 1-minute summary of *"what the scientists are actually keeping, rewriting, testing, and proving"* before commissioning heavy B2 runs. This catches goal drift (such as paper framing creeping into a software rebase) while changes are still free.

## Stage 2 — Independent autonomous execution (B2)

- Run a quick **host-runtime pre-flight** before staging B2 (checking installed R/Python versions, available libraries, and any `.Rprofile`/`renv` or `.venv` autoloaders that would stall fresh clones). Place the frozen charter inside gitignored `output/CHARTER.md` alongside `output/ASSIGNMENT-B2.md` ([BC2-execution.md](../prompts/BC2-execution.md)) so `git status` and package checks stay clean.
- Require scientists to **profile and record the unmodified baseline first** before refactoring, and lock any comparative study design before production runs.
- Give each scientist the same frozen input packet and its own remote-free workspace. For third-party reference PDFs or bulky frozen datasets/outputs, keep one read-only master folder (`~/shared/<slug>/`, files `chmod a-w`) and hardlink it into each clone's gitignored `resources/` via `--resources-dir` (`docs/operating-notes.md` §3).
- **Remote compute & detachable `tmux` routing:** Never anchor multi-hour runs solely to a local laptop when remote servers, resizable cloud VMs or HPC queues are available. In gitignored `output/ASSIGNMENT-B2.md`, authorise offloading heavy parallel runs inside detachable `tmux` sessions under **isolated per-family remote directories and session names** (keeping hostnames strictly in gitignored local files, never in tracked public files).
- Each scientist determines its own architecture and internal decomposition, resolving ordinary choices autonomously while recording consequential assumptions, failed approaches and limitations. Bring back only true objective changes or unavailable essential inputs.

## Stage 3 — Independent verification, fresh-session cross-critique (B3) and convergence (B4–B5)

- **Adviser verification first:** Independently verify all three frozen `git archive HEAD` snapshots on disk (tests, build/package checks, uniform process-tree memory & runtime gates, and key numerical spot-checks)—never rely on completion claims or parent-only memory metrics alone.
- **Fresh-session read-only B3 cross-critique:** Stage a self-contained read-only review packet (`output/b3-packet/`) inside each workspace containing frozen snapshots of all three candidates plus the adviser's verified metrics table, and issue [BC3-cross-critique.md](../prompts/BC3-cross-critique.md) in **brand-new chat threads** (avoiding B2 log compaction and defensive attachment). Fresh cross-family red-teaming is fast and catches unique release blockers each family alone misses.
- **Adjudicate on evidence, not consensus:** Independently reproduce every claimed blocker on disk. Separate **scientific/design integration** from **code integration**: choosing one clean maintained backbone and harvesting specific verified fixes from peers beats merging three architectures.
- **Single-builder hardening + short diff audit (B4–B5):** Export the winning backbone to a fresh remote-free integration clone, commission one builder (e.g., the larger-allocation family) to execute the verified blocker/harvest checklist with full tests, then run a short read-only `GO / FIX-FIRST` diff audit by the winning-design family before landing onto the upstream repository via a history-preserving PR (letting live CI verify all target platforms).
- **Optional final communication:** Only if and when the lead scientist explicitly triggers a manuscript, stage a dedicated fresh-writer workspace (`~/writer/<slug>` via `scripts/stage-writer-workspace.sh`) and compose afresh from adjudicated evidence (see [Track A](A-manuscript-rescue.md) Stage 3–4).

## Post-pilot reflection & workspace cleanup

After completion, record briefly in `projects/<slug>/STATE.md`: whether independent rebasing and fresh-session cross-critique exposed real weaknesses or better architectures, how much attention went to science/design vs. supervision, whether convergence stayed proportionate, and whether the contribution reached its audience.

Once the rebased deliverable lands upstream (PR merged / release tagged), package all temporary pilot clones (`.git`, tracked code/docs and Markdown briefs/reports, stripping all generated build/check/simulation artifacts) into a single compact `.zip` archive using `scripts/archive-pilot-clones.sh --delete-sources` and prune temporary staging folders in `projects/<slug>/work/` (`docs/operating-notes.md` §7).
