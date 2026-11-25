# Track C: Tabula-rasa research

**Use when:** Starting from a bare (or nearly bare) repository where the lead scientist brings a fresh idea, North Star, motivation, and optional primary data (or a public-data, theoretical, or simulation remit)—with **no prior code, no prior AI-agent ideation, and no legacy scaffolding**.

**Track boundaries:** If substantial prior code, models or agent work already exist and need rebasing, use [Track B: Project rebase & completion](B-project-rebase.md). If the science is already complete and only the manuscript needs fresh reconstruction, use [Track A: Manuscript rescue](A-manuscript-rescue.md).

**Default: not paper-shaped until the lead scientist pulls the trigger.** Start by earning a genuine scientific finding, model, benchmark, or tool—not by writing paper prose around an untested idea. Keep technical documentation and reproducible outputs thorough; commission a manuscript only after adjudicated evidence warrants one.

## Stage 1 — Tabula-rasa workspaces & independent problem framing (C1)

1. The lead scientist writes a concise opening brief (`INPUT.md`): the core idea or curiosity, North Star, why it might matter, any primary data or candidate public sources, resource/time constraints, and known non-negotiables.
2. Build bare, single-commit, remote-free workspaces using `scripts/build-isolated-clones.sh --workflow C --input-md <INPUT.md> --baseline-dir <dir> --project <slug>` (optionally passing `--resources-dir ~/shared/<slug>` to hardlink read-only primary data or key reference PDFs into gitignored `resources/`, or `--source-repo`/`--manifest` if a minimal starter repo already holds small project-owned data files).
3. Issue [C1-tabula-rasa-conception.md](../prompts/C1-tabula-rasa-conception.md) independently to all three scientists (`~/codex/<slug>`, `~/claude/<slug>`, `~/gemini/<slug>`).
4. Because there is no inherited codebase to anchor on, C1 divergence is **conceptual and epistemic**: ask each scientist for 2–3 distinct research formulations (recommending one—or recommending to stop/reframe if the premise fails basic novelty or feasibility checks), exact falsifiable hypotheses or design aims, bounded primary-source novelty/prior-art checks, data and compute feasibility, analytical/synthetic validation oracles, and what a null or negative result would look like. No coding, environment builds or production runs in C1.

## After C1 — Compact scientific charter & pre-registration lock

Compare the three independent conceptions before shared deliberation. Look specifically for where the three families proposed genuinely different hypotheses, estimands, models or data strategies—and for early red flags (duplicate prior work, identifiability traps, unavailable data). Then write a compact charter following `docs/operating-notes.md` §0:

- The chosen research question, estimand or build objective, and why it matters relative to prior work.
- Primary product shape (e.g., reproducible analysis, simulation/theoretical study, benchmark, or reusable tool—not a manuscript unless explicitly commissioned).
- **Independent oracles and falsification checks built from scratch:** because Track C has no legacy baseline or existing test suite, explicitly specify synthetic/analytical verification oracles, held-out validation splits or sensitivity tests, and failure modes that would overturn the working hypothesis.
- Minimum defensible completed contribution vs. optional stretch goals.
- Resource, data-governance and licensing bounds (never fabricating data or misclaiming shareability).
- **Explicit null / negative / stop criteria:** define upfront what evidence justifies concluding a null result or halting rather than p-hacking or scope-creeping.

**Plain-English gut-check before launching C2:** Give the lead scientist a concise, jargon-free 1-minute summary of *"what question the scientists are testing, against what ground truth, and what counts as a negative or stop result"* before commissioning C2 execution.

## Stage 2 — Independent autonomous execution (C2)

- Run a quick **host-runtime pre-flight** and place the frozen charter at gitignored `output/CHARTER.md` alongside `output/ASSIGNMENT-C2.md` (adapted from [BC2-execution.md](../prompts/BC2-execution.md)).
- Require each scientist to **commit its pre-registered design, oracle checks, and stopping criteria** on local `main` *before* running production analyses or heavy simulations.
- Use hardlinked read-only `resources/` (`--resources-dir`) for shared primary data or reference PDFs so nothing is triplicated, committed to Git, or leaked between peers.
- **Remote compute & detachable `tmux` routing:** Authorise offloading heavy parallel simulations or model fits to available remote servers, resized cloud VMs or HPC queues in detachable `tmux` sessions under **isolated per-family remote directories and session names** (hostnames strictly in gitignored local files, never in tracked public files).
- Each scientist builds its own clean implementation from scratch, runs its verification oracles and analyses, commits cleanly on local `main`, saves compact reproducible outputs under `output/`, and writes `output/C2-report.md` linking every numerical claim to code and saved artifacts.

## Stage 3 — Independent verification, fresh-session cross-critique (C3) and convergence (C4–C5)

- **Adviser verification first:** Independently verify all three frozen `git archive HEAD` snapshots on disk (tests, analytical/synthetic oracle pass, uniform process-tree resource metrics, and independent recomputation of headline numbers/tables directly from saved outputs)—never trust self-reported claims alone.
- **Fresh-session read-only C3 cross-critique:** Stage a frozen, self-contained `output/c3-packet/` (all three candidate repos + adviser-verified metrics table) and launch **brand-new chat threads** with [BC3-cross-critique.md](../prompts/BC3-cross-critique.md). Fresh cross-family red-teaming is especially valuable on tabula-rasa work, where hidden methodological bugs, leakage, weak baselines, or silent estimand drift are easiest to miss by the author who built the pipeline.
- **Adjudicate on evidence, not consensus:** Independently reproduce every claimed bug, assumption failure, or cross-family numerical discrepancy. Disagreement across three independent from-scratch builds is high-value scientific signal—reconcile *why* estimates or models differ before choosing what survives.
- **Proportionate convergence (C4–C5):** Depending on the product:
  - *Tool / reusable pipeline:* select one clean backbone, run a focused hardening sprint (C4) harvesting verified peer fixes/checks, then a short read-only diff audit (C5) before publishing.
  - *Empirical / simulation / theoretical investigation:* freeze the adjudicated primary codebase and evidence ledger (verifying any cross-family robustness checks that materially inform the conclusion) without merging redundant pipelines.
- **Optional final communication:** Only when the lead scientist explicitly decides the adjudicated evidence warrants a paper, stage a dedicated fresh-writer workspace (`~/writer/<slug>` via `scripts/stage-writer-workspace.sh`) and compose afresh (see [Track A](A-manuscript-rescue.md) Stage 3–4).

## Post-pilot reflection

After completion, record briefly in `projects/<slug>/STATE.md`: whether independent tabula-rasa framing and execution produced genuinely distinct scientific angles, what fresh-session cross-critique caught, how much human attention went to scientific judgement vs. supervision, and whether the work earned its next audience step.
