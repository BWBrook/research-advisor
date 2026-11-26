# Project Charter — OpenPVA `v2.1.0` (Track B, Stage B2)

- **Project:** `OpenPVA` (`BWBrook/OpenPVA`) — `v2.1.0` ("Complete the conservation practitioner's toolkit + CRAN readiness")
- **Baseline:** Curated single-commit snapshot of locked `OpenPVA 2.0.1` (`8025928`, exported from `main` @ `55b40df`)
- **Date adopted:** 26 November 2026 (agreed by Barry W. Brook after comparing three independent B1 conceptions)
- **Product shape:** Tool-first R package release ready for CRAN submission (**not paper-shaped**—do not draft a manuscript or paper prose)

---

## 1. Core Objective & Hard Invariants

Extend OpenPVA from its lean `v2.0.1` core into a complete, CRAN-ready pure-base-R conservation PVA toolkit ("the modern GAPPS") without sacrificing simplicity, speed, or auditability.

### Non-negotiable engineering & epistemic invariants
1. **Pure base + recommended R runtime:** `Depends: R (>= 4.1.0)` (no post-4.1 R syntax), `NeedsCompilation: no`, `Imports` restricted strictly to base + recommended packages (`codetools`, `graphics`, `grDevices`, `parallel`, `stats`, `tools`, `utils`). Only `testthat` and `litedown` (or `Sweave` fallback) in `Suggests`. Zero `renv` clutter.
2. **Single unified composable engine:** Every new capability integrates cleanly as ordinary `pva_process()` / helper / S3 methods over columnar `pva_state`. No parallel execution loops, sidecar engines, or backwards-compatibility shims.
3. **Engine contracts intact:** Strict cohort-split accounting, exact pedigree parity across dense, traced (`> max_dense_kinship`), and mid-run-switched states, strict tamper detection on engine-owned fields, and bit-identical replicate RNG across serial, Unix fork, and clean `--vanilla` PSOCK workers.
4. **Honest scope boundary (deferred to `v2.2.0`):** Do **not** build `observation_process()`, `when()` adaptive triggers, ensemble LHS/PRCC/Sobol/EVPI sensitivity, SIR/SEIR disease compartments, multi-species coupling, selected/linked/mutating loci, per-patch $\phi_p$, or compiled C/C++ code.

---

## 2. Essential `v2.1.0` Deliverables (All Four Pillars)

Internal architecture, exact function/argument names, and solver choices remain unconstrained provided every deliverable satisfies its biological, mathematical, and CRAN contracts:

### Pillar 1A — Kinship-Aware Mating & Pedigree Founder Representation
- **Polygynous mating helper** (e.g., `mate_min_kinship()` plugging into `reproduction_process(mate = ...)`): selects minimum-kinship eligible males subject to `max_kinship` (returning `NA` when none qualify so `require_mate = TRUE` skips breeding) with clean, reproducible tie handling.
- **Monogamous kinship-aware pairing** (extending `pairing_process()` cleanly): supports kinship-minimising / mean-kinship-prioritised pairing under `capacity` and `max_kinship`. Exact bipartite assignment vs. greedy ascending pairs is left to your design—document the exact guarantee your solver provides and benchmark runtime at 200 eligible pairs.
- **Founder representation & mean kinship:** export individual `mean_kinship()` (against all living individuals including self-kinship) and add exact Lacy (1995) Founder Genome Equivalents $\mathrm{FGE} = 1 / (2 \bar{K})$ to `summarise_pedigree()` (using all living pairs including diagonals, so $N$ unrelated founders yield exactly $N$).
- **Cross-store parity & traced scaling:** round kinship scores (e.g. `1e-12`) before argmin/ordering comparisons so dense, traced, and mid-run-switched stores make identical mating decisions. Keep traced cross-sex queries scalable (avoiding full $(n_F + n_M)^2$ scalar passes).

### Pillar 1B — Optional Neutral-Locus Gene-Drop Genetics
Internal storage (optional engine-owned state slot vs. process-managed global) is your design choice, provided all five invariants hold:
1. **Zero cost when disabled:** default `0L` loci allocates zero marker storage, consumes zero RNG draws, and adds zero overhead to the Woodhen `strict` scaling gate.
2. **Non-perturbing to demography:** enabling neutral markers must **never** alter demographic outcomes (`n_alive`, births, deaths, pairings, trajectories) for the same scenario seed (isolate marker segregation RNG from the demographic stream).
3. **Full lifecycle & tamper fidelity:** works with year-0 `initial_census`, `add_individuals()`, `introduction_process()` (introducing fresh alleles), unknown/one-missing parents, same-interval departed sires (e.g., grizzly autumn harvest before winter birth), and strict tamper validation. Refuse ambiguous marker initialization if a supplied `kinship` matrix implies founder relationships unexplained by recorded parentage (or document and enforce a clean rule).
4. **Conservation genetic metrics:** report observed heterozygosity $H_o$, expected heterozygosity $H_e = 1 - \frac{1}{L}\sum_{\ell,a} p_{\ell,a}^2$, allelic richness, **allelic retention relative to initial founder allele labels** (so later introductions cannot mask loss of native alleles), and realised founder shares.
5. **Extinction-safe trajectory summaries:** allow `summarise_trajectory()` to handle `NA` genetic metrics on extinct replicates ($N = 0$, reporting extant summaries + extant count) while keeping `summarise_pva()` strict on finite abundance metrics.

### Pillar 2 — Correlated Spatiotemporal Environments
- Pure-R composable environmental generator(s) integrating cleanly with `environment_process()`:
  - **Temporal AR(1) autocorrelation** ($|\phi| < 1$, stationary initialization, explicit scaling definition).
  - **Spatially correlated multi-patch anomalies** via pivoted / rank-revealing Cholesky factorization at construction, handling both positive-definite correlation matrices and perfect synchrony ($\rho = 1$).
  - **Deterministic trends / regime shifts** composed cleanly without AR(1) trend lag bias.
- **Bit-identity invariants:** store lagged values strictly in `state$globals` (never in mutable closures); compute linear combinations in pure R rather than BLAS `%*%` so serial, fork, and PSOCK runs stay bit-identical across multi-replicate scenarios.

### Pillar 3 — Zero-Dependency Base-R Diagnostic Plotting
- Add S3 class `c("pva_ensemble", "data.frame")` to `run_pva_ensemble()` return values.
- Register `plot.pva_run()` (trajectory fan ribbons + median, cumulative first-passage risk curve with Wilson Monte Carlo interval, and cohort accounting reconciliation view) and `plot.pva_ensemble()` (design contrasts with uncertainty intervals), using base `graphics`/`grDevices` only.
- Honour caller `par()` (restore any local graphics settings on exit), leave `.Random.seed` untouched, return the plotted summary data frame invisibly, and update `scripts/build_rd.R` so S3 `\method{plot}{...}` Rd usage passes `R CMD check --as-cran` cleanly.

### Pillar 4 — GAPPS / Vortex Rosetta Stone Vignette & CRAN Readiness
- **Vignette engine:** build an executable HTML vignette (`vignettes/`) using **`litedown`** (`Suggests: litedown`, `VignetteBuilder: litedown`, zero Pandoc/LaTeX required). Fall back to bundled `utils::Sweave` PDF **only** if `litedown` demonstrably fails to build on R 4.1.0 / CRAN check. Keep vignette execution deterministic (fixed seeds) and fast (`< 15 s`).
- **Rosetta Stone content:** concise lookup table plus short runnable examples translating verified GAPPS idioms (strictly within `docs/gapps_heritage.md`—never invent unverified GAPPS syntax), Vortex annual sequence (EV/catastrophe, ceiling vs. density multipliers, harvest/release order sensitivity demonstrating cohort-timing differences), Leslie matrix projection ($A^t n_0$), kinship mating + gene-drop genetics, correlated two-patch dispersal, and `plot()` diagnostics.
- **CRAN submission readiness:** bump `DESCRIPTION` to `Version: 2.1.0`, set maintainer email to `barry.brook@utas.edu.au`, update `inst/CITATION`, `NEWS.md`, `README.md`, `docs/reference/public_api.md`, add runnable examples to `man/summaries.Rd`, and update `.github/workflows/ci-fast.yaml` so CI builds vignettes (`R CMD build .`) and checks cleanly on Ubuntu (R release and R 4.1.0), macOS, and Windows (checking PDF manual on at least one Linux job).

---

## 3. Mandatory Verification Oracles & Hard B2 Gates

Every B2 submission must commit automated tests and report observed results for all seven gates:

1. **Kinship mating oracles:** Brute-force enumeration on small related/inbred pedigrees ($n_F, n_M \le 7$, with `max_kinship` and `capacity`), verifying declared matching optimality/invariants, `< 1e-13` parity against an independent tabular pedigree, and identical pairings/offspring across dense (`2000L`), traced (`1L`/`3L`), and mid-run-switched stores. Report 200-pair timing in dense and traced modes.
2. **Pedigree FGE & gene-drop oracles:**
   - Exact: $N$ unrelated founders → `FGE == N`, `2N` alleles, `He == 1 - 1/(2N)`; exact 16-outcome combinatorial check for two full siblings from `AB × CD` (mean $H_e = 5/8 = 1 - \bar{K}$, mean retention $= 3/4$, pedigree FGE $= 4/3$); departed mid-interval sire allele transmission; introductions adding novel alleles without inflating native retention.
   - Conditional-on-pedigree Monte Carlo: over loci on a fixed pedigree, mean $H_e$ within 4 SE of $1 - \bar{K}$ and mean $H_o$ within 4 SE of $1 - \bar{F}$.
   - Non-perturbation: exact `identical()` demographic census, events, and accounting between `n_loci = 0L` and `n_loci > 0L` for the same scenario seed.
3. **Correlated environment oracles:** Exact first-two-step deterministic verification through a trend/regime shift; stationary Monte Carlo check ($\ge 2{,}000$ independent draws) confirming unbiased mean, stationary variance, lag-$k$ covariance $\phi^k$, and cross-patch correlation matrix within 4–5 SE (including $\phi < 0$, $\phi = 0$, and $\rho = 1$); bit-identical serial / fork / PSOCK parity across multi-replicate AR(1) scenarios.
4. **Plotting checks:** Headless `pdf(NULL)` (and `png()` when available) smoke tests across every plot view (including deliberately broken accounting, single-run/single-step, and extinct replicates), asserting non-empty output, unchanged `par(no.readonly = TRUE)`, unchanged `.Random.seed`, and identical invisible returned tables.
5. **CRAN build & check gate:** `R CMD build .` (WITH vignettes built!) followed by `R CMD check --as-cran OpenPVA_2.1.0.tar.gz` → **0 errors, 0 warnings, ≤ 1 NOTE** (New submission only), 0 test failures/warnings/skips, vignette build `< 15 s`, test suite `< 60 s`. Verify clean-library PSOCK floor (`scripts/check_r_floor.R`) and verify zero post-R-4.1.0 syntax.
6. **Woodhen scaling & regression gate:** `scripts/benchmark_gate.R` (`K = 30`, 1,000 × 40-yr, `strict`, 8 fork, `n_loci = 0L`) passes `< 60 s` wall time and `< 2 GB` peak summed process-tree RSS, with no material regression vs. the unmodified `v2.0.1` baseline measured on the same machine.
7. **Large-pedigree oracle gate:** `scripts/benchmark_large_pedigree.R` (including crossing-2,000 related founders) passes `< 1e-13` oracle error.
