# Current state — OpenPVA (Workflow B)

Updated: 24 November 2026, Australia/Hobart. **Round B1 complete; compact scientific charter adopted (`charter.md`); Round B2 autonomous execution staged across all three isolated workspaces.**

- **Workflow:** B — Original research / scientific-software completion from a partially developed repository
- **Adviser:** Gemini 4 Neon (separate from the three independent scientists)
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license)
- **Common source baseline:** commit `89b34eeaae608a39b9c040fe8e9f7af217d9ab47` (`89b34ee`, 19 Nov 2026)
- **Curated single-commit baseline:** commit `ed0178c1027e20013259c926eab93cbd1dbf48a7` (115 active package/test/example/doc files + `INPUT.md`, `.gitignore`, isolated `AGENTS.md`/`CLAUDE.md`/`GEMINI.md`; verified `505 PASS / 0 FAIL / 0 WARN` in `79.2 s` under host R 4.6.2 with `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`)
- **Active Charter:** [charter.md](charter.md) (adopted 24 Nov 2026)

## Scientists (primary surface: desktop apps)

| Family | Model | Workspace | B1 status | B2 status | B2 report path |
|---|---|---|---|---|---|
| OpenAI (Codex Desktop) | `gpt-6.2-astra` | `~/codex/openpva` | Complete (`dab77571…`, 1,360 w) | **Running** (launched 24 Nov) | `~/codex/openpva/output/B2-report.md` |
| Anthropic (Claude Code Desktop) | `Fable` (`fable`) | `~/claude/openpva` | Complete (`733109a7…`, 1,542 w) | **Running** (launched 24 Nov) | `~/claude/openpva/output/B2-report.md` |
| Google (Antigravity Desktop, separate window) | `Gemini 4 Carbon (High)` (`gemini-4-carbon-high`) | `~/gemini/openpva` | Complete (`c5d9dc9b…`, 1,525 w) | **Running** (launched 24 Nov) | `~/gemini/openpva/output/B2-report.md` |

## Settled decisions

- **23 Nov 2026 (B1 setup):** Preserve OpenPVA's GAPPS-style composable ordinary-R process philosophy; strip `git log`, `origin`, pre-realignment `artefacts/`, and historical agent logs/handovers; track `projects/openpva/` publicly in `BWBrook/research-advisor` with `local.json` and `work/` gitignored.
- **24 Nov 2026 (B2 Charter):**
  - **Scientific direction:** Unbundle the PVA "package effect" via a pre-registered within-engine factorial contrasting *naive software swap* vs. *expectation-matched* structural semantics (including the analytically anchored $s = ab$ release-timing split) against parametric vital-rate uncertainty, paired with a CRAN/r-universe-ready `OpenPVA` release and (post-adjudication) an *MEE*/*Ecography* + living-paper trilogy.
  - **Archetype scope:** Two GAPPS-lineage archetypes grounded in-repo (Grizzly + Lord Howe Island Woodhen, with conditional post-1980 Woodhen trajectory check only if verifiable from primary sources; a 3rd published species is optional stretch).
  - **Delegation boundary (`operating-notes.md` §0):** Profile-first hard gates (`< 60 s / < 2 GB` RSS on 1,000 × 40-yr pedigree-enabled Woodhen runs, `R >= 4.1.0`, serial/fork/PSOCK RNG parity, missing core PVA processes, multi-year & exact small-cohort extinction oracles, cohort fault-injection accounting, dense-matrix pedigree `< 1e-13`, clean `R CMD check --as-cran --no-manual`), leaving internal architecture unconstrained.
- **24 Nov 2026 (North Star clarification — tool-first "modern GAPPS"):** Barry clarified that the North Star is **OpenPVA as the modern GAPPS**—a clear, flexible, modular, realistic R PVA toolkit that conservation biologists and their AI agents actively choose to use—developed iteratively through case-study stress tests rather than chasing a primary research paper. Any future paper is secondary and likely a concise **Software Note (*Ecography*)** or **R package / Application note (*MEE*)** using event-sequencing examples as illustration. B2 runs continue undisturbed (they already focus heavily on speed, core PVA processes, oracles, CRAN-readiness, and real-case stress tests, with no manuscript drafting); B3 adjudication will weight **tool ergonomics, clarity, modularity, performance, and verification** first, treating the factorial/sequencing runs as stress tests and showcase demos.

## Verified on disk (24 Nov 2026)

- Frozen B1 briefs archived under ignored `projects/openpva/work/frozen-B1/` (`codex`, `claude`, `gemini`).
- Unmodified `ed0178c` baseline verified: 505 `testthat` assertions pass (`0 FAIL / 0 WARN / 0 SKIP`, `79.2 s`) under host R 4.6.2 (`RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`).
- Byte-identical `output/CHARTER.md` and `output/ASSIGNMENT-B2.md` staged across `~/codex/openpva`, `~/claude/openpva`, and `~/gemini/openpva`; all three clones remain clean on `ed0178c` with zero remotes.

## Next action

Launch Round B2 independently in each scientist's desktop app (fresh session recommended for clean context window). Once all three complete local commits and save `output/B2-report.md`, freeze all three workspaces, verify all gates/oracles directly, and prepare independent B3 cross-critique.
