# Current state — OpenPVA `v2.1.0` (Track B, Round B1 ready)

Updated: 26 November 2026, Australia/Hobart. **Charter adopted (`charter.md`: `litedown::vignette` HTML with Sweave fallback, non-perturbing neutral gene-drop in `v2.1.0`, monitored maintainer email `barry.brook@utas.edu.au`). `litedown 1.0` (`xfun 0.62`) verified on WSL host R 4.6.2, and identical `output/CHARTER.md` + `output/ASSIGNMENT-B2.md` are staged across all three isolated clones — ready for Barry to launch Stage B2.**

- **Track:** B — Project rebase & milestone completion (second cycle, starting clean from `OpenPVA 2.0.1`)
- **Adviser:** Gemini 4 Neon (separate from the three independent scientists)
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license; `v2.0.0` Zenodo DOI: `10.5281/zenodo.24521839`)
- **Locked `v2.0.1` source baseline:** commit `55b40df2a5d68a4dfdd6e9708027c82d5430d2de` (`55b40df`, merged via [PR #2](https://github.com/BWBrook/OpenPVA/pull/2), CI [Run 45745322414](https://github.com/BWBrook/OpenPVA/actions/runs/45745322414) 4/4 PASS, `926 PASS`, `0 err / 0 warn / 1 NOTE`)
- **Curated single-commit baseline:** commit `802592803c065226073d969e420adcc0190e3413` (`8025928`, 71 manifest files)
- **Project scope:** [brief.md](brief.md)

## Pre-cycle `v2.0.1` Maintenance Summary (locked on `main` @ `55b40df`)

- **Builder:** OpenAI Codex (`gpt-6.2-astra`, `c4f737a`); **Read-only auditor:** Google Gemini 4 Carbon (`Verdict: GO`, zero blockers).
- **A1–A4 resolved:** `age_sex_rate(missing_sex = c("error", "zero"))`, `mate_from_field(stale = c("error", "unpaired"))`, pure-R dense pedigree sibling reuse & exact-size matrix growth (Woodhen strict gate `34.55 s / 1,263 MiB → 32.04 s / 1,214 MiB`, serial 32-rep `-18%`, byte-identical outputs), and independent crossing-2,000 related-founder tabular oracle (`0` kinship/F error, `4.34e-19` mean-kinship error).

## Stage B1 — Independent Design & API Conception (`v2.1.0`, complete 26 Nov 2026)

| Family | Model | Workspace | B1 status & frozen copy |
|---|---|---|---|
| **OpenAI (Codex)** | `gpt-6.2-astra` | `~/codex/openpva-2.1` (`8025928`) | Complete & frozen (`1,595` w, clean git) |
| **Anthropic (Claude)** | `Fable 5.2` | `~/claude/openpva-2.1` (`8025928`) | Complete & frozen (`1,745` w, clean git) |
| **Google (Gemini)** | `Gemini 4 Carbon (High)` | `~/gemini/openpva-2.1` (`8025928`) | Complete & frozen (`1,677` w, clean git) |

### Key B1 synthesis (independent catches across all three)
- **All three caught:** `DESCRIPTION` maintainer email (`users.noreply.github.com`) is CRAN-ineligible; `run_pva_ensemble()` returns a bare `data.frame` (needs `c("pva_ensemble", "data.frame")`); CI skips vignette builds (`--no-build-vignettes`); exact `FGE = 1 / (2 * mean_kinship)` belongs directly in `summarise_pedigree()`; AR(1) state must live in `state$globals` (never closures) with pivoted Cholesky for $\rho = 1$ and R-level accumulation to avoid BLAS drift; kinship tie-breaking must round to `1e-12` for dense/traced parity.
- **Unique catches:** **Claude** caught `.census_matrix()` rejecting `NA` when genetic census metrics hit extinction (`N = 0`), stale `inst/CITATION` (`2.0.0`), and the monoecious-only trap in $H_t = H_0(1 - 1/(2N_e))^t$ (exact oracle is conditional on pedigree: $E[H_e] = 1 - \bar{K}$, $E[H_o] = 1 - \bar{F}$). **Gemini** caught `scripts/build_rd.R` lacking S3 `\method{}{}` support for `plot.*`, chunk-vectorised traced cross-sex kinship, and AR(1) trend lag bias ($Z_{t-1} = Y_{t-1} - \mu(t-1)$). **Codex** contributed the exact 16-outcome full-sibling gene-drop oracle (`AB × CD`), refusing marker init on unexplained supplied founder kinships, and defining allelic retention strictly against initial founder labels.

## Stage B2 — Independent Autonomous Execution (`v2.1.0`, staged 26 Nov 2026)

- **Active Charter:** [charter.md](charter.md) (copied to gitignored `output/CHARTER.md` in each clone).
- **Host pre-flight verified (26 Nov 2026):** R `4.6.2`, `testthat`, `pkgload`, `litedown 1.0` (`litedown::vignette`), `xfun 0.62`, `pdflatex`, `xelatex`, `qpdf`.
- **Staged workspaces:** `~/codex/openpva-2.1`, `~/claude/openpva-2.1`, `~/gemini/openpva-2.1` (all clean on single-commit `8025928`, remote-free, with `output/CHARTER.md` and `output/ASSIGNMENT-B2.md`).

## Next action

Launch all three scientists into Stage B2 (`output/ASSIGNMENT-B2.md`) to implement, test, benchmark, commit on local `main`, and write `output/B2-report.md`. Once all three finish, independently verify all frozen `git archive HEAD` snapshots on disk and stage fresh-session read-only B3 cross-critique.
