# Project brief — OpenPVA (Workflow B)

- **Workflow:** B — Original research / scientific-software completion from a partially developed repository
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license)
- **Common source baseline:** commit `89b34eeaae608a39b9c040fe8e9f7af217d9ab47` (`89b34ee`, 19 Nov 2026)
- **Lead scientist:** Barry W. Brook
- **Adviser:** Gemini 4 Neon (separate from the three independent scientist sessions)

## Starting state

`OpenPVA` is a modular, individual-based Population Viability Analysis (PVA) toolkit for R realigned as a modern open-R descendant of GAPPS. Earlier AI-assisted development produced a lean, tested package core (14 files in `R/`, ~4,491 LOC, 42 exports, `Imports: dplyr, tibble`, `Depends: R (>= 4.6.0)`, 15 `testthat` files, an uncalibrated synthetic grizzly benchmark, and a standalone Lord Howe Island woodhen vertical slice in `inst/examples/woodhen/`), alongside ~8 MB of pre-realignment check artefacts and superseded agent roadmaps/logs. Development paused before the project reached a finished, externally communicated scientific contribution.

## Settled scope and North Star (updated 24 Nov 2026)

- **North Star — the "modern GAPPS" (tool-first, not paper-first):** The primary goal is to build an R PVA toolkit that conservation biologists—and their AI agents—will genuinely choose to use for real PVAs because of its clarity, flexibility, modularity, biological realism, speed, and verifiability. Case studies and event-sequencing experiments (e.g., Grizzly, Woodhen, release-timing/structural contrasts) serve primarily to **develop, stress-test, and demonstrate** the tool across repeated sprints rather than to drive a primary research paper.
- **Dissemination path:** Release a fast, CRAN/r-universe-ready R package with strong documentation, worked examples, and an agent-usable guide (plus Zenodo DOI). A journal paper is not an immediate requirement; if written once the tool matures, it will likely be a concise **Software Note (*Ecography*)** or **Application / R package note (*Methods in Ecology and Evolution*)** using the sequencing/case-study results as a sharp illustration.
- **Core identity vs. freedom to challenge:** Keep OpenPVA's **GAPPS-style composable ordinary-R process philosophy** (explicit modeller-defined biological programme; transparent state, RNG, and accounting contracts; no black-box fixed lifecycle) as core identity. Within that identity, scientists are explicitly free to challenge real bottlenecks or gaps—including runtime performance, API ergonomics, missing essential PVA/statistical capabilities, `R (>= 4.6.0)` version constraints, or what should be cut or simplified.
- **Curated isolation:** All three scientists receive an identical single-commit, remote-free snapshot of `OpenPVA@89b34ee` containing all 115 active package, test, example, CI, bibliography, and architecture/design/reference files, with `git log`, `origin`, `artefacts/`, and historical agent process docs (`HANDOVER.md`, `docs/plan.md`, `docs/roadmap.md`, `docs/goals/`, `docs/log/`, `docs/decisions.md`, `docs/interpretation_notes.md`, original `AGENTS.md`) stripped to prevent anchoring.

## Downstream stages

Round B2 is currently running independently across the three scientists under [charter.md](charter.md), which already puts heavy engineering, verification, CRAN-readiness, and real-case stress testing at the centre (with manuscript prose explicitly deferred). At Stage B3 freeze and adjudication, the three builds will be evaluated primarily on **tool quality as the modern GAPPS** (API clarity for humans and AI agents, speed/cleanliness, modularity, biological realism, verification oracles, and CRAN readiness), using their case-study results as stress-test evidence and showcase material for subsequent tool-focused sprints.
