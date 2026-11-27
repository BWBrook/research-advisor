# Optional Post-Validation Distillation — `[Project]` (Track `[B|C|D]`)

## Inputs supplied by the adviser

- **Locked validated baseline:** This isolated, remote-free workspace at `[validated commit]` (all tests, verification oracles, golden paths, and/or claims ledger already passing and locked as the behavioural reference)
- **Locked reference checks to preserve:** `[exact test command, byte-identical or tolerance-locked output/oracle checks, claims ledger or playability invariants]`
- **Scope:** `[entire repo, or named subsystem/model/pipeline]`
- **Save your concise distillation report to:** **`output/DISTILLATION-report.md`**

## Assignment

The validated baseline is scientifically/functionally locked and serves as your **hard regression oracle**. Undertake a bounded distillation pass to hill-climb toward the simplest, clearest, most conceptually economical expression of this validated work—**optimising for human comprehension and conceptual elegance, never raw line-count golfing**.

Look for substantive simplifications across:

1. **Conceptual & scientific parsimony (especially Track C):** Can a complex model, mathematical formulation, or simulation pipeline be collapsed to fewer governing mechanisms or cleaner equations while still reproducing the validated findings? Does simplifying expose a cleaner general principle?
2. **Separating background from novel core:** Pull routine boilerplate, plumbing, or standard machinery cleanly apart from the core scientific argument, algorithm, or game loop so a human reader grasps what is actually new in minutes rather than hours.
3. **Structural & test economy:** Delete dead code, redundant abstractions, duplicate wrappers, and overlapping test permutations that detect no distinct consequential failure—while keeping every guard, edge-case check, and readable error message that protects real users or scientific validity.

## Hard guardrails (non-negotiable)

- **Preserve every locked oracle:** Every simplification must pass all locked verification checks, analytical/empirical oracles, reproducibility/RNG contracts, and claims-ledger bindings unchanged (or, for genuine model-simplification discoveries in Track C, report exact quantitative fidelity against the full validated reference side by side).
- **Conceptual elegance over mechanical brevity:** Reject clever one-liners, opaque metaprogramming, cryptic variable names, or stripped safeguards that shrink LOC at the expense of human legibility. Retain complexity wherever it is scientifically or operationally justified.
- **Explicit null exit:** If inspection shows the validated product is already near minimal and further compression would trade clarity or safety for cleverness, **stop without forcing churn** and document that conclusion plainly.
- **Stopping rule:** Iterate only while simplifications materially improve conceptual clarity, maintainability, or scientific insight; stop as soon as remaining edits are cosmetic or yield diminishing returns.
- **Strict isolation & git hygiene:** Commit cleanly on local `main` (leave `git status` clean except gitignored `output/`). Do not add Git remotes, push, or query any Correspondence Board.

## Output and stopping contract

Write **~500–1,000 words** directly to **`output/DISTILLATION-report.md`** starting with:

- `Validated reference commit:` `<baseline SHA>`
- `Distilled commit:` `<final local SHA, or "unchanged — already near minimal">`
- `Model / harness:` `[only what you can directly observe]`
- `Oracle verification:` `[exact checks re-run against the locked reference and pass status]`
- `Status:` `ready for legibility audit` (or `no material simplification warranted`)

Summarise: (1) substantive simplifications made and why they improve human understanding or expose cleaner structure, (2) complexity deliberately retained and why, (3) exact before/after metrics (treated as diagnostic evidence, not the goal), and (4) any residual risks for the short legibility/diff audit. Stop after committing and saving `output/DISTILLATION-report.md`.
