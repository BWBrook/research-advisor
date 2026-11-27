# Current state — OpenPVA `v2.1.0` (Track B, Round B1 ready)

Updated: 27 November 2026, Australia/Hobart. **All three B2 submissions (`codex@f9d4fd3`, `claude@cbd996a`, `gemini@01c91d8`) passed uniform independent adviser verification (`R CMD build` with `litedown` HTML vignette, `R CMD check --as-cran --no-manual` `0E/0W/1N`, Woodhen `strict` gate `15.9–16.8 s`, large-pedigree oracle `0` error). Frozen read-only `output/b3-packet/` and `output/ASSIGNMENT-B3.md` are staged across all three workspaces — ready for Barry to launch three brand-new fresh-session B3 reviewers.**

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

## Stage B2 — Independent Autonomous Execution (`v2.1.0`, verified 27 Nov 2026)

- **Active Charter:** [charter.md](charter.md)
- **Baseline `v2.0.1` (`8025928`) quiet-host Woodhen gate:** `13.49 / 16.20 s` wall, `1,200–1,205 MiB` tree RSS (`119.4`, reconciled `TRUE`).

| Family | Model | B2 commit | LOC / exports | Build (vignette) & CRAN check | Woodhen `strict` gate | Large pedigree |
|---|---|---|---|---|---|---|
| **Codex** | `gpt-6.2-astra` | `f9d4fd3` | 3,752 / 51+6 | `5.46 s` (`rosetta-stone.html`); `0E/0W/1N` (`1,274 PASS`, `44 s`) | `15.91–19.05 s`, `1,210–1,213 MiB` | `13.50 s` (`0/0/4.3e-19`) |
| **Claude** | `Fable 5.2` | `cbd996a` | 3,938 / 53+6 | `9.70 s` (`rosetta.html`); `0E/0W/1N` (`2,184 PASS`, `37 s`) | `16.51 s`, `1,230 MiB` | `11.57 s` (`0/0/4.3e-19`) |
| **Gemini** | `Gemini 4 Carbon High` | `01c91d8` | 4,614 / 55+7 | `12.44 s` (`rosetta-stone.html`); `0E/0W/1N` (`1,792 PASS`, `47 s`) | `16.83 s`, `1,216 MiB` | `11.57 s` (`0/0/4.3e-19`) |

## Stage B3 — Fresh-Session Read-Only Cross-Critique (staged 27 Nov 2026)

- Frozen read-only `output/b3-packet/` (containing `VERIFIED-METRICS.md` + frozen `candidate-{codex,claude,gemini}/`) and `output/ASSIGNMENT-B3.md` are staged inside `~/codex/openpva-2.1`, `~/claude/openpva-2.1`, and `~/gemini/openpva-2.1` (no preliminary winner imposed; all three builds are strong and genuinely distinct).

## Next action

Launch three **brand-new fresh** scientist sessions (Codex, Claude, Gemini) on `~/{codex,claude,gemini}/openpva-2.1` to run the read-only B3 cross-critique and save `output/B3-critique.md`. Once all three report back, adjudicate on reproduced evidence and run a single B4 hardening/harvest sprint + short B5 diff audit before PR #3 and CRAN submission.
