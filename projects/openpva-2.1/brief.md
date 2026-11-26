# Project brief — OpenPVA `v2.1.0` (Track B)

- **Track:** B — Project rebase & milestone completion (clean second cycle off released `OpenPVA 2.0.1`)
- **Upstream repository:** `BWBrook/OpenPVA` (public GitHub, MIT license; `v2.0.0` Zenodo DOI: `10.5281/zenodo.24521839`)
- **Lead scientist:** Barry W. Brook
- **North Star:** Build the *"modern GAPPS"* — a lean, unified, pure-base-R composable PVA toolkit that conservation biologists (and their AI agents) actually choose to use over Vortex, RAMAS, or ad-hoc loops. **Not paper-shaped** (tool-first; target is a CRAN-ready `v2.1.0` release).

## Target scope (`v2.1.0`: Complete the conservation practitioner's toolkit + CRAN readiness)

Four focused pillars built natively onto the locked `OpenPVA 2.0.1` engine:

1. **Managed genetics & inbreeding avoidance:** inbreeding-avoidance / minimum-kinship pairing (e.g., `mate_min_kinship()`) plus optional neutral-locus gene-drop genetics and founder representation (`He`, retained alleles, founder genome equivalents).
2. **Correlated spatiotemporal environments:** pure-base-R environmental generators covering AR(1) temporal autocorrelation (red noise), Cholesky-correlated multi-patch spatial synchrony, and climate/regime trend drift.
3. **Zero-dependency diagnostic plotting:** base-R `plot()` methods (`plot.pva_run()`, `plot.pva_ensemble()`, trajectory fan ribbons, quasi-extinction risk curves, accounting diagnostics) using base `graphics`/`grDevices` only.
4. **Practitioner adoption & CRAN readiness:** a concise "GAPPS / Vortex Rosetta Stone" vignette (`vignettes/`) translating classic Vortex/GAPPS/matrix idioms into OpenPVA's ordered process lists, plus full CRAN submission readiness (`R CMD check --as-cran` clean with vignettes built, zero errors/warnings).

## Explicitly deferred to `v2.2.0` (out of scope for `v2.1.0`)

- Adaptive management & noisy monitoring MSE (`observation_process()` + conditional `when()` triggers)
- Ensemble LHS/PRCC/Sobol sensitivity analysis & Expected Value of Information (EVPI/EVPPI)
- Individual disease/health compartments (SIR/SEIR) and multi-species coupling
- Optional C99/compiled acceleration (only if a future benchmark proves pure R inadequate)

## Hard engineering & epistemic invariants

- **Pure base + recommended R only:** `Depends: R (>= 4.1.0)`, `NeedsCompilation: no`, zero external runtime `Imports` (base `graphics`/`grDevices` allowed; any vignette builder stays strictly in `Suggests` or uses base R).
- **Single unified engine:** every new capability composes directly as ordinary `pva_process()` / helper objects over columnar `pva_state` without duplicating execution loops or adding compatibility layers.
- **Engine contracts intact:** strict cohort accounting, exact pedigree parity (dense, traced, and mid-run transition), bit-identical replicate RNG across serial / fork / PSOCK, strict tamper detection, and no regression on the Woodhen `strict` scaling gate (`< 60 s / < 2 GB`).
