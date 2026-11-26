# Current state — OpenPVA `v2.1.0` (Track B, Round B1 ready)

Updated: 26 November 2026, Australia/Hobart. **`OpenPVA 2.0.1` (`55b40df`) is merged on `BWBrook/OpenPVA` `main` after 4/4 green CI and Gemini Carbon's `GO` diff audit. Curated single-commit, remote-free `openpva-2.1` clones (`8025928`, 71 manifest files) and identical `output/ASSIGNMENT-B1.md` briefs are staged across Codex, Claude, and Gemini — ready for Barry to launch the fresh trio.**

- **Track:** B — Project rebase & milestone completion (second cycle, starting clean from `OpenPVA 2.0.1`)
- **Adviser:** Gemini 4 Neon (separate from the three independent scientists)
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license; `v2.0.0` Zenodo DOI: `10.5281/zenodo.24521839`)
- **Locked `v2.0.1` source baseline:** commit `55b40df2a5d68a4dfdd6e9708027c82d5430d2de` (`55b40df`, merged via [PR #2](https://github.com/BWBrook/OpenPVA/pull/2), CI [Run 45745322414](https://github.com/BWBrook/OpenPVA/actions/runs/45745322414) 4/4 PASS, `926 PASS`, `0 err / 0 warn / 1 NOTE`)
- **Curated single-commit baseline:** commit `802592803c065226073d969e420adcc0190e3413` (`8025928`, 71 manifest files)
- **Project scope:** [brief.md](brief.md)

## Pre-cycle `v2.0.1` Maintenance Summary (locked on `main` @ `55b40df`)

- **Builder:** OpenAI Codex (`gpt-6.2-astra`, `c4f737a`); **Read-only auditor:** Google Gemini 4 Carbon (`Verdict: GO`, zero blockers).
- **A1–A4 resolved:** `age_sex_rate(missing_sex = c("error", "zero"))`, `mate_from_field(stale = c("error", "unpaired"))`, pure-R dense pedigree sibling reuse & exact-size matrix growth (Woodhen strict gate `34.55 s / 1,263 MiB → 32.04 s / 1,214 MiB`, serial 32-rep `-18%`, byte-identical outputs), and independent crossing-2,000 related-founder tabular oracle (`0` kinship/F error, `4.34e-19` mean-kinship error).

## Stage B1 — Independent Design & API Conception (`v2.1.0`)

| Family | Model | Workspace | B1 status |
|---|---|---|---|
| **OpenAI (Codex)** | `gpt-6.2-astra` | `~/codex/openpva-2.1` (`8025928`) | Staged (`output/ASSIGNMENT-B1.md`), ready to launch |
| **Anthropic (Claude)** | `Fable` | `~/claude/openpva-2.1` (`8025928`) | Staged (`output/ASSIGNMENT-B1.md`), ready to launch |
| **Google (Gemini)** | `Gemini 4 Carbon (High)` | `~/gemini/openpva-2.1` (`8025928`) | Staged (`output/ASSIGNMENT-B1.md`), ready to launch |

## Next action

Launch three **fresh** independent scientist sessions (Codex, Claude, Gemini) on `~/{codex,claude,gemini}/openpva-2.1` to write `output/B1-conception.md` covering the four `v2.1.0` pillars (managed genetics/min-kinship + gene-drop, correlated spatiotemporal environments, base-R plotting, GAPPS/Vortex Rosetta Stone vignette + CRAN readiness). Once all three report back, compare conceptions and lock the plain-English `v2.1.0` Charter before B2.
