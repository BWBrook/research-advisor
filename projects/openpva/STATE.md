# Current state — OpenPVA (Workflow B)

Updated: 25 November 2026, Australia/Hobart. **Round B3 cross-critique complete, frozen, and independently verified on disk. Unanimous 3-for-3 backbone consensus on `candidate-claude` (`OpenPVA 2.0.0`, pure base R) subject to a crisp, verified hardening checklist before landing onto `BWBrook/OpenPVA`.**

- **Workflow:** B — Original research / scientific-software completion from a partially developed repository
- **Adviser:** Gemini 4 Neon (separate from the three independent scientists)
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license)
- **Common source baseline:** commit `89b34eeaae608a39b9c040fe8e9f7af217d9ab47` (`89b34ee`, 19 Nov 2026)
- **Curated single-commit baseline:** commit `ed0178c1027e20013259c926eab93cbd1dbf48a7` (`505 PASS`, `79.2 s`)
- **Active Charter:** [charter.md](charter.md) (adopted 24 Nov 2026)

## Scientists — Verified B1–B3 Summary

| Family | Model | B2 commit | B2 verified check & gate | B3 critique |
|---|---|---|---|---|
| **OpenAI (Codex)** | `gpt-6.2-astra` | `154d329` (`v1.1.0`, 5,052 R + 765 C++) | 0 err / 0 warn / 2 NOTEs (`550 PASS`, 85.0 s); `4.14 s / 151 MiB` (C++ `cohort_program`) | Complete & frozen (1,794 w); 4 live reproducers |
| **Anthropic (Claude)** | `Fable 5.2` | `f6559e9` (`v2.0.0`, 2,780 R, base R only) | 0 err / 0 warn / **1 NOTE** (`726 PASS`, 47.3 s); `15.48 s / 961 MiB` (`strict`, 8 fork) | Complete & frozen (1,722 w); 10 live reproducers |
| **Google (Gemini)** | `Gemini 4 Carbon High` | `14fa2f7` (`v1.0.1`, 7,406 R + 838 C99) | 0 err / 0 warn / 2 NOTEs (`589 PASS`, 98.6 s); `22.30 s / 1,251 MiB` (`fast`, 8 fork) | Complete & frozen (1,877 w); 2 live reproducer batches |

## B3 Adjudication (independently reproduced on disk, 25 Nov 2026)

### 1. Backbone verdict (unanimous 3-for-3)
Adopt **`candidate-claude` (`OpenPVA 2.0.0`, `f6559e9`)** as the unified, base-R-only backbone (zero external `Imports`, zero compiled code for now, 2,780 LOC, idiomatic vectorized R processes, strict cohort accounting, 1 CRAN NOTE). Do **not** port Codex's separate `cohort_program()` C++ sidecar or Gemini's dual list/data-frame backwards-compatibility layer or `dplyr`/`tibble`.

### 2. Verified release blockers to fix before landing `OpenPVA 2.0.0` (all reproduced live by adviser)
1. **Unseeded runs repeat identically** *(Claude catch)*: `run_scenario()` / `run_pva_ensemble()` draw random root seeds inside `.with_rng_restored()`, returning the exact same seed on consecutive unseeded calls (`1781592037` twice). Fix: draw unseeded root seeds *outside* `.with_rng_restored()`.
2. **Females breed without males by default** *(Claude catch)*: `reproduction_process(require_mate = FALSE)` + `mate_random()` returning `NA` lets 20 females with 0 males produce 35 births; README example leaves males decorative. Fix: default `require_mate = TRUE` whenever `mate` is supplied (and make mating an explicit choice in examples/docs).
3. **Known full siblings initialise with kinship = 0** *(Codex catch)*: `pva_state(..., pedigree = TRUE)` silently defaults to a diagonal kinship matrix even when `mother_id`/`father_id` are supplied (`kinship[3,4] = 0` instead of `0.25`), and strict validation compares two references to the same mutable kinship environment. Fix: derive initial kinship from supplied parentage (or require an aligned matrix) and guard store integrity across non-creating processes.
4. **`summarise_trajectory()` crashes on default `scenario_spec()` and disagrees with `summarise_pva()`** *(Gemini catch)*: `include_initial` defaults to `TRUE` in `summarise_trajectory()` (crashing on `initial_census = NULL`) vs `FALSE` in `summarise_pva()` (yielding `p_ever_below = 0` vs `1` on the same run). Fix: align defaults cleanly (`include_initial = has_initial` or consistent explicit default across both functions).
5. **`staged_survival_process()` miscomputes survival when rates change between stages** *(all three)*: at `post_share = 0` with density-changed rate, residents died (`0/2` alive). Fix: rescale and store `U' = U / s_pre^(1-q)` in an engine-safe slot and test `U' < s_post^q` (bit-identical when rates are constant).
6. **Pedigree `fast` mode `NA` corruption & dead-sire/unknown-sire handling** *(Claude + Gemini)*: `validation = "fast"` silently writes `NA` into `pedigree_F` and `kinship` when `mate = NULL` (`anyNA = TRUE`), and a sire dying between pairing and birth breaks `pedigree = TRUE` (classic grizzly summer mating → autumn harvest → winter parturition). Fix: validate parentage in both modes and retain dead-sire kinship rows (or compact breeder-ancestry table) across the interval until birth.
7. **PSOCK / Windows parallelism & broken CI workflows** *(all three)*: propagate `.libPaths()` + `rscript_args = "--vanilla"` and auto-export callback globals via recommended `codetools` (Codex's fix), enable Windows PSOCK test & CI, remove stale `scripts/ci_restore.R` / `scripts/run_lint.R` calls from `.github/workflows/`, and verify on a real R 4.1.0 runtime.
8. **Ensemble cache key & RNG hygiene** *(all three)*: `run_pva_ensemble()` cache ignores model/summary code, `validation`, and package version; also seed stochastic builders within each member's RNG scope.

### 3. Verified `[IMPORTANT]` polish & targeted harvest (Sprint 2)
- **Validation & edge-case fixes:** reject negative/non-integer individual event counts before summing (`c(2, -1)` currently passes for 1 death); check census completeness against `scenario$n_runs * scenario$n_steps` and require explicit selection on multiple censuses; check nonexistent mate rows, non-integer litters, and logical `NA` in `removal_process(select = )`; error instead of silent clamping in `litter_binomial()` (`mean > size`), fix `shift_logit(1, -Inf) -> NaN`, fix `summarise_accounting(df)` tautology, validate non-NULL global in `inbreeding_proxy_process()`, and allow `age_sex_rate()` to cover one-sex tables without dummy rows.
- **Large-$N$ pedigree safety (stay pure R):** drop `"state"` from default `keep` in `run_scenario()` (avoids storing 7.7 GB of dense kinship matrices across 1,000 runs), reduce kinship store growth factor from `2x` to `1.25–1.5x`, add an explicit configurable memory guard (`max_dense_kinship`), and evaluate Gemini's ancestor-compressed pedigree algorithm as a pure-R fallback (only escalating to zero-dependency C99 `.Call()` if a real large-$N$ model proves pure R too slow).
- **Inbreeding proxy safeguard (reconciled across all 3 studies):** require explicit `generation_time` (no default!) in `inbreeding_proxy_process()`, warn/error if introductions occur with `migration = NULL`, and document clearly that scalar $N_e$ proxies miss F1 heterosis so `pedigree = TRUE` is recommended under supplementation.
- **1987 Richard Harris examples & ecology:** add a clean standalone `inst/examples/grizzly/` maternal-care / inter-birth-interval example (restoring the core 1987 GAPPS problem without polluting the exported namespace), fix Woodhen's female-only survival lookup when male rates change, preserve origin–destination counts in `dispersal_process()` (from Codex), and add a clean user vignette + agent quickstart.

### 4. Scientific discrepancies fully reconciled
- **`proxy_Ne`:** Not biological contradiction—three different equations: Gemini ran `1/(2Ne)` per *year* (no generation-time scaling $T_g$, no immigrant dilution → +42 pp even without releases in `G1`, +63 pp with releases in `W3`); Codex applied $B = 2$ to *every adult every year* (driving both proxy and exact pedigree to ~100%); Claude scaled $N_e$ by $T_g$ and diluted immigrants by $(1-m)^2$.
- **Release timing ($s = ab$):** Age-2 Woodhen releases ($s_2 = 0.85$) agree within ~1–2 pp across all three (`1.8–2.6 pp` Claude, `~1.8 pp` Codex, `3.1–3.9 pp` Gemini with exact pedigree $B = 3.14$). Claude's `10.8–11.0 pp` came from its second age-0 chick release arm ($s_0 = 0.35$).

## Next action

Await Barry's approval to execute the **OpenPVA 2.0.0 Hardening Sprint** (apply all 8 verified blockers + targeted Sprint 2 polish onto a clean integration branch of Claude's `OpenPVA 2.0.0`, verify with `R CMD check --as-cran` + real R 4.1.0 + Windows/PSOCK + full oracles + scaling gate, then review with Barry before landing onto `BWBrook/OpenPVA` and rolling the banked Workflow B lessons into `BWBrook/research-advisor`).

## Banked harness lessons (ready for post-pilot update)

- **Default: not paper-shaped until the human pulls the trigger.**
- **Intermediate-repo curation applies to Workflow B** (stripping stale roadmaps/handovers/artefacts prevents B1 anchoring).
- **Plain-English charter gut-check before B2 launch**, plus host-runtime/`renv` pre-flight and gitignored `output/CHARTER.md`.
- **Remote compute & detachable `tmux` routing in B2 prompts** with isolated per-family remote directories (hostnames kept in gitignored local files only).
- **Specify "single unified engine" invariant explicitly** when setting performance gates (prevents sidecar bypasses).
- **Fresh-session read-only B3 cross-critique is disproportionately high ROI:** 40 minutes of read-only cross-family review uncovered 8 real, live-reproducible blockers in the winning build—with every single model family catching unique blockers the other two missed.
