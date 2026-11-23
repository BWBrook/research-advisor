# Project brief — OpenPVA (Workflow B)

- **Workflow:** B — Original research / scientific-software completion from a partially developed repository
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license)
- **Common source baseline:** commit `89b34eeaae608a39b9c040fe8e9f7af217d9ab47` (`89b34ee`, 19 Nov 2026)
- **Lead scientist:** Barry W. Brook
- **Adviser:** Gemini 4 Neon (separate from the three independent scientist sessions)

## Starting state

`OpenPVA` is a modular, individual-based Population Viability Analysis (PVA) toolkit for R realigned as a modern open-R descendant of GAPPS. Earlier AI-assisted development produced a lean, tested package core (14 files in `R/`, ~4,491 LOC, 42 exports, `Imports: dplyr, tibble`, `Depends: R (>= 4.6.0)`, 15 `testthat` files, an uncalibrated synthetic grizzly benchmark, and a standalone Lord Howe Island woodhen vertical slice in `inst/examples/woodhen/`), alongside ~8 MB of pre-realignment check artefacts and superseded agent roadmaps/logs. Development paused before the project reached a finished, externally communicated scientific contribution.

## Settled scope and freedom for Round B1 (23 Nov 2026)

- **Completion bar ("reaching people"):** Open to independent B1 proposals, provided the finished project delivers a concrete public release and scientific communication path (e.g., CRAN/r-universe-ready R package plus a methods paper such as *Methods in Ecology and Evolution*, *Ecography*, or JOSS; a living paper + Zenodo release; and/or a substantive comparative or empirical PVA study built on OpenPVA). Adding more internal features to an unpublicised repository is not completion.
- **Core identity vs. freedom to challenge:** Keep OpenPVA's **GAPPS-style composable ordinary-R process philosophy** (explicit modeller-defined biological programme; transparent state, RNG, and accounting contracts; no black-box fixed lifecycle) as core identity. Within that identity, scientists are explicitly free to challenge real bottlenecks or gaps—including runtime performance of the append-only R-list IBM state at PVA ensemble scale, API ergonomics, missing essential PVA/statistical capabilities, `R (>= 4.6.0)` version constraints, or what should be cut or simplified—and may recommend a major pivot or stopping if evidence warrants.
- **Curated isolation:** All three scientists receive an identical single-commit, remote-free snapshot of `OpenPVA@89b34ee` containing all 115 active package, test, example, CI, bibliography, and architecture/design/reference files, with `git log`, `origin`, `artefacts/`, and historical agent process docs (`HANDOVER.md`, `docs/plan.md`, `docs/roadmap.md`, `docs/goals/`, `docs/log/`, `docs/decisions.md`, `docs/interpretation_notes.md`, original `AGENTS.md`) stripped to prevent anchoring.
- **Hard invariants for B1:** Read-only code inspection + tightly bounded novelty/ecosystem checks only (no code edits, environment installs, or benchmark execution yet). Strict isolation from peer workspaces, the adviser repo, prior chats/memory, and any Correspondence Board.

## Downstream stages (not yet commissioned)

After all three independent B1 conception briefs return, Barry and the adviser will compare them side by side and agree a compact scientific charter (outcomes, hard epistemic/validation invariants, honest stopping criteria) before commissioning B2 autonomous execution.
