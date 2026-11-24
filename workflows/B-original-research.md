# Workflow B: Original research from an idea

**Use when:** Starting from an undeveloped scientific idea that requires problem framing, independent autonomous investigation, evidence-led adjudication and—only after the science settles—fresh communication. Do **not** import Workflow A's science-complete assumption here, and do not use Workflow B's research remit to reopen a Workflow A manuscript rescue.

## Stage 1 — Independent project conception (B1)

1. The lead scientist supplies an initial idea and any known data, constraints or motivation (even a short paragraph).
2. Issue [B1-project-conception.md](../prompts/B1-project-conception.md) independently to all three scientists in isolated workspaces (`~/codex/<slug>`, `~/claude/<slug>`, `~/gemini/<slug>`).
3. Ask each for promising scientific questions, what counts as a substantial contribution, a minimum defensible outcome, optional stretch goals, required evidence/verification, and conceptual or feasibility risks. Allow bounded novelty/feasibility checks using primary sources—not unrequested coding or research execution.

## After B1 — Compact scientific charter (reward & invariant design)

Compare the three independent conceptions before shared deliberation, then write a compact charter following the delegation boundary in `docs/operating-notes.md` §0 (specify outcomes, hard epistemic invariants and falsifiable checks; leave code architecture and internal workflow unconstrained):

- The scientific question and why it matters.
- Minimum defensible completed contribution and essential deliverables.
- Optional stretch goals that must not block completion.
- Hard epistemic guardrails, resource bounds and decisions that materially change the objective.
- Common evaluation standard: protected held-out data, predeclared comparisons or independent reproduction where appropriate.
- Honest stopping criteria for a negative, null or infeasible result.
- How the completed contribution will reach its intended audience.

## Stage 2 — Independent autonomous execution (B2)

- Give each scientist the same frozen input/data packet and its own remote-free workspace. For third-party reference PDFs or bulky frozen datasets/model outputs, keep one read-only master folder (`~/shared/<slug>/`, files `chmod a-w`) and hardlink it into each clone's gitignored `resources/` directory via `--resources-dir` (`docs/operating-notes.md` §3)—zero disk triplication, zero Git/copyright leaks, and zero cross-scientist leakage.
- Each determines its own methods, abstractions and internal decomposition, resolving ordinary implementation choices autonomously while keeping a concise trail of consequential assumptions, failed approaches and limitations.
- Bring back only true objective changes or unavailable essential inputs. Never inspect peer workspaces, shared discussion boards or prior private logs.

## Stage 3 — Independent cross-critique, adjudication and fresh communication (B3+)

- Freeze submitted investigations. Each scientist independently critiques the other two, tying criticisms to reproducible discrepancies or evidence.
- Investigate material discrepancies directly; do not average incompatible claims into compromise or pick whichever story looks cleanest. Remember that models sharing training data can share errors—agreement is consistency, not scientific proof.
- Separate **scientific integration** from **code integration**: selecting one maintained implementation and keeping another as an independent verification check is often cleaner than merging three architectures.
- Only after the scientific account is stable, stage a dedicated fresh-writer workspace (`~/writer/<slug>` via `scripts/stage-writer-workspace.sh`) and compose the final manuscript afresh from the accepted evidence, figures, limitations and unresolved issues—then use the three scientists for a final scientific-fidelity audit (see [Workflow A](A-manuscript-rescue.md) Stage 3–4).

## Post-pilot reflection

After completion, record briefly in `projects/<slug>/STATE.md`: whether independent execution exposed real weaknesses or alternative methods, how much attention went to science vs. supervision, whether integration stayed proportionate, and whether the contribution reached its audience.
