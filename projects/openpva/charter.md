# Scientific Charter — OpenPVA (Workflow B, Stage B2)

- **Project:** `OpenPVA` (`BWBrook/OpenPVA@89b34ee`, curated baseline `ed0178c`)
- **Lead scientist:** Barry W. Brook
- **Date adopted:** 24 November 2026
- **Delegation boundary:** This charter specifies hard scientific objectives, epistemic invariants, verification oracles, and performance/packaging gates (`docs/operating-notes.md` §0). Internal code architecture, data structures, refactoring strategy, and workflow decomposition are intentionally left to each independent scientist.

---

## 1. Scientific Question and Significance

**Central question:** How much of a Population Viability Analysis's predicted extinction risk, abundance trajectory, and conservation management ranking is driven by **structural lifecycle semantics** (process ordering, census position, density-dependence mechanism, mate/territory limitation, and inbreeding representation) relative to **parametric vital-rate uncertainty** and Monte Carlo error—and how much of that apparent "package effect" survives once competing formulations are **expectation-matched** to identical baseline demographic dynamics?

**Why it matters:** Classic cross-package comparisons (Mills et al. 1996; Brook et al. 1997, 1999, 2000) found sharp divergence among VORTEX, GAPPS, RAMAS, and INMAT on shared species inputs, but confounded genuine biological semantics with undocumented software defaults, differing RNGs, and silent truncation rules. With `steps` archived from CRAN (January 2026) and active CRAN PVA tools remaining predominantly grid/matrix-based or post-processors (`poems`, `metaRange`, `vortexR`), an audited, composable individual-based R engine provides a clean single-engine laboratory to unbundle the package effect—and to deliver a fast, CRAN-ready R package that conservation ecologists can adopt directly.

---

## 2. Core Experimental Design and Epistemic Invariants

### 2.1 Pre-registration and anti-tautology controls

1. **Pre-register before running production ensembles:** Commit a concise pre-registration document (`study/preregistration.md`) specifying the complete factor matrix, archetype parameter tables (with explicit provenance for every rate), parameter-uncertainty distributions, endpoints, decision-relevance margin (e.g., 5 percentage points absolute risk difference), and replicate-sizing rule *before* executing the production factorial.
2. **Report both Naive Swap and Expectation-Matched contrasts:**
   - **Naive swap:** What a practitioner experiences when switching lifecycle semantics on nominal input parameters without retuning.
   - **Expectation-matched:** Structural variants retuned via an independent analytical/matrix expectation oracle to identical baseline demographic expectations (e.g., matched deterministic growth rate $\lambda$ and stable structure), isolating pure stochastic and semantic effects.
   - **Analytically anchored release-timing contrast ($s = ab$):** Include an explicit supplementation/release-timing axis where annual resident survival $s = ab$ is factored into pre-release ($a$) and post-release ($b$) survival across $b \in [s, 1]$ while holding the unsupplemented resident survivor distribution **identically fixed**, testing when unmeasured post-release mortality timing flips a supplementation decision (and comparing deterministic lowest-ID vs. lottery territory priority where territory allocation applies).
   - Where an exact expectation match cannot be constructed for a nonlinear mechanism (e.g., territory-limited floater queues), state that explicitly and report it cleanly as a structural contrast rather than asserting an exact match.

### 2.2 Required structural axes (grounded in documented cross-package PVA differences)

1. **Event, census, and management timing:** Process ordering (e.g., survival/reproduction/census order) and exact $s = ab$ release-timing split.
2. **Density-dependence mechanism:** Hard ceiling truncation vs. vital-rate density feedback (e.g., Beverton–Holt/Ricker or ceiling multiplier) vs. explicit territory capacity with non-breeding floaters.
3. **Mating system & demographic structure:** Two-sex pair/mate limitation & sex-ratio stochasticity vs. unconstrained / female-dominant breeding, plus litter-size distribution where biologically relevant (bounded/categorical vs. Poisson).
4. **Inbreeding representation:** None vs. aggregate/proxy inbreeding vs. exact conditional pedigree IBD (`pedigree_F`) coupled to vital rates (e.g., lethal-equivalent survival scaling $S = S_0 \exp(-B F)$).

### 2.3 Archetype and empirical scope

- **Minimum defensible scope — two GAPPS-lineage archetypes already grounded in-repo:**
  1. **Slow, long-lived mammal under targeted mortality (Grizzly archetype):** Grounded in `OpenPVA`'s benchmark structure (explicitly labelled synthetic/illustrative unless freshly backed by cited primary estimates), comparing $\ge 2$ management options (e.g., baseline vs. targeted human-mortality reduction and/or supplementation).
  2. **Fast, territorial endangered bird under multi-intervention recovery (1980 Lord Howe Island Woodhen archetype):** Grounded in `inst/examples/woodhen/`, comparing management options (habitat/pig control, supplementation/captive release, timing), preserving strict provenance distinctions between inherited teaching assumptions and published field data.
- **Conditional historical trajectory check:** Include an out-of-sample retrospective trajectory check for Lord Howe Island woodhen *only* if independent post-1980 survey counts and intervention records can be verified from primary published sources without inventing figures or leaking evaluation counts into capacity estimation; otherwise document the provenance limit explicitly and keep the woodhen scenarios strictly illustrative.
- **Decision-relevant estimands (all required):**
  - Horizon quasi-extinction probability, first-crossing probability (e.g., falling below a species-defined breeding-pair threshold), time-to-threshold, and final abundance quantiles;
  - **Variance decomposition** partitioning outcome variance across structural semantics, parametric vital-rate uncertainty, their interaction, and Monte Carlo error;
  - **Management ranking robustness:** Probability of top-ranked management reversal and absolute risk-reduction intervals against the pre-declared decision margin;
  - **Parsimony falsification check:** Compare the full IBM against a compact matched age/sex count or matrix model to determine where individual-level detail materially alters decisions versus where a simpler model suffices.

---

## 3. Hard Software, Performance, and Verification Gates

### 3.1 Preserved package identity

- Retain OpenPVA's core identity: a lifecycle is a direct ordered list of ordinary R `pva_process` objects with explicit field dependency declarations (`requires`, `writes`, `creates`), engine-owned time/IDs/RNG/accounting/provenance, and no fixed biological dispatcher or lifecycle DSL.

### 3.2 Profile-first hard performance & resource gate

- **Measure first:** Profile the unmodified `ed0178c` baseline's wall time and peak memory across horizon length, population size, and pedigree on/off before refactoring.
- **Performance gate:** A 40-year, pedigree-enabled Woodhen-scale ensemble (`N ≈ 100–200` living individuals, `1,000` replicates) must complete in **`< 60 seconds` wall time and `< 2 GB` peak RSS** on the local 8-core / 12 GB Linux host, and the full production factorial must execute reproducibly within the 12 GB RAM cap without swapping or OOM.
- **Internal design unconstrained:** Each scientist freely chooses how to hit this gate (e.g., columnar state, active/archival ledger split, incremental sparse pedigree tracking, tiered strict/fast validation proven identical, summary-only replicate retention, minimal compiled C/Rcpp hot loops in `src/`, etc.).

### 3.3 Core PVA capability and CRAN-readiness gates

- **Missing PVA essentials exposed as ordinary composable processes / helpers:**
  - `removal_process()` (harvest, culling, capture) reconciling with accounting;
  - reusable environmental stochasticity and catastrophe constructors;
  - non-Poisson (bounded/categorical or custom) litter-size support in `reproduction_process()` alongside Poisson;
  - density-feedback helpers beyond ceiling truncation (e.g., Beverton–Holt / Ricker);
  - inbreeding-fitness helper (e.g., lethal-equivalent scaling on `pedigree_F`) and pedigree summary metrics;
  - generic `summarise_pva()` (with Monte Carlo standard errors / intervals) and reproducible `run_pva_ensemble()` separating structural/parametric designs from inner Monte Carlo replicates.
- **Portability and package hygiene:**
  - Lower `Depends: R` to the lowest version actually needed (target `R (>= 4.1.0)`, justified and checked);
  - Cross-platform parallel execution (`parallel = TRUE` supporting both Unix fork and PSOCK clusters with bit-identical preassigned L'Ecuyer-CMRG streams and caller `.Random.seed` restoration);
  - Reconcile package metadata (`DESCRIPTION`, `NEWS.md`, `inst/CITATION`, `README.md` broken links), clean up namespace clutter (e.g., deciding cleanly whether the grizzly fixture stays exported or moves to examples/data, and minimising unnecessary runtime dependencies such as `dplyr` where clean);
  - Pass `R CMD build --no-build-vignettes .` and `R CMD check --as-cran --no-manual` with **0 errors, 0 warnings** (document any unavoidable CRAN NOTE explicitly).

### 3.4 Falsifiable verification oracles (all required)

1. **Multi-year expected-value oracle:** Independent multi-step (`t = 1..T`) age/sex matrix expectation check agreeing with simulated stochastic means within `≤ 3 × MCSE`.
2. **Exact small-cohort extinction / first-crossing oracle:** Independent exact enumerated / Markov / branching-process calculation for a small two-sex cohort (including across scheduled releases), verifying first-crossing and horizon occupancy probabilities within prespecified Monte Carlo tolerances.
3. **Cohort-level accounting & deliberate fault-injection test:** Interval reconciliation (`start + births + introductions - deaths - removals = end`) *plus* a negative test proving that mischarging newly introduced/born individuals a full interval of mortality—or omitting a removal/death event—is caught even when aggregate counts appear plausible.
4. **Pedigree identity oracle:** Exact conditional `pedigree_F` agreeing with an independent dense numerator-relationship matrix oracle (`< 1e-13`) across multi-year runs and any fast/incremental backend.
5. **RNG & validation-mode parity:** Bit-identical results across serial, fork, and PSOCK runs at fixed seed; if a `fast` validation mode exists alongside `strict`, proven identical outputs on integration fixtures.
6. **Monte Carlo precision:** Size production replicates from pilot variance so 95% CI half-width on primary risk differences is `≤ 2` percentage points (or `MCSE ≤ 1/5` of the declared decision margin).

---

## 4. Minimum Defensible Outcome vs. Optional Stretch Goals

### Minimum defensible completion for Stage B2 (required for review)
1. **Upgraded, verified, CRAN-clean `OpenPVA` package** committed locally on `main` (clean `git status`, no remotes, no push), passing all tests, oracles, performance gates, and `R CMD check --as-cran --no-manual`.
2. **Pre-registered, fully reproducible factorial study** (`study/preregistration.md`, runnable analysis scripts, and machine-readable summary tables + diagnostic figures under `output/`) covering both archetypes, naive vs. expectation-matched contrasts, $s = ab$ release timing, variance decomposition, management rank reversals, and the parsimony check.
3. **Self-contained B2 Technical & Scientific Report** saved to **`output/B2-report.md`** (~1,500–2,500 words) linking every quantitative claim to reproducible scripts and output files, documenting design trade-offs, failed approaches, limitations, and unresolved issues.

### Optional stretch goals (must not block B2 completion)
- A 3rd empirical vertebrate species with complete, citable published parameter tables and $\ge 2$ management options.
- Verified out-of-sample post-1980 Woodhen hindcast against primary published monitoring series.
- Cross-check of one matched scenario against an external engine (`VORTEX` or `popbio`).
- Standalone `vignettes/` sources ready for r-universe / CRAN build.

---

## 5. Honest Stopping and Null-Result Criteria

- **Null/negative findings are legitimate, publishable completion:**
  - If expectation-matching removes most structural variance and management rankings hold across semantics, report that cleanly as a practitioner translation rule.
  - If a compact age/sex count or matrix model matches full-IBM management rankings equally well, report that honestly and delineate exactly where individual-level modelling earns its keep.
- **Feasibility/compute stop rule:** Never silently downgrade Monte Carlo precision below stated bounds or disable pedigree tracking to meet runtime targets. If pure-R cannot clear the `< 60 s / < 2 GB` gate, escalate targeted hot loops to minimal compiled C (`src/`) or document the exact measured scaling ceiling transparently.
- **Escalate to lead scientist only for:** A genuine material change to the scientific objective or an unavailable essential external input. Resolve all ordinary implementation and statistical choices autonomously.

---

## 6. Path to Audience (Post-Adjudication, Stage B3+)

Final manuscript prose is **deferred to Stage B3+**. After all three B2 investigations finish, the adviser and lead scientist will freeze all three workspaces, run independent written B3 cross-critiques, adjudicate scientific discrepancies and choose the maintained package backbone (retaining an independent implementation as verification where useful), and **then** compose the public outputs afresh from the adjudicated evidence:
- Tagged **r-universe / CRAN-ready `OpenPVA` release** + **Zenodo DOI**;
- Living-paper trilogy backed by one claims ledger: **methods/research article** (*Methods in Ecology and Evolution* or *Ecography*), **two-page plain-language brief**, and **agent replication guide**.
