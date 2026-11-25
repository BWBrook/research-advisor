# Current state — OpenPVA (Track B pilot)

Updated: 25 November 2026, Australia/Hobart. **Pilot complete and PR live with 4/4 green CI.** History-preserving Pull Request [#1](https://github.com/BWBrook/OpenPVA/pull/1) (`openpva-2.0.0` @ `4806407` → `main` @ `89b34ee`) passed all four GitHub Actions checks (Ubuntu R release, Ubuntu R 4.1.0 including clean-library PSOCK floor check, macOS R release, Windows R release). All pilot lessons and the clean Track B (rebase) / Track C (tabula-rasa) separation have been folded into `BWBrook/research-advisor`.

- **Track:** B — Project rebase & completion (pilot that separated Track B from Track C)
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

## Stage B4 — OpenPVA 2.0.0 Hardening Sprint (complete & verified 25 Nov 2026)

- **Integration workspace & commit:** `~/codex/openpva-2.0`, commit `c4dafb6` (clean `git status`, zero remotes; 3,126 LOC pure base R across 11 files in `R/`, `NeedsCompilation: no`, `Imports: codetools, parallel, stats, tools, utils`, zero `renv` clutter, standalone `inst/examples/grizzly/` + sex-specific `inst/examples/woodhen/`, actionlint-clean cross-platform CI for Linux/macOS/Windows + R 4.1.0).
- **Independently verified by adviser (clean `git archive HEAD`):**
  - `R CMD check --as-cran --no-manual`: **0 errors, 0 warnings, 1 NOTE** (New submission only), **`900 PASS / 0 FAIL / 0 WARN / 0 SKIP`** (`74.9 s`), examples OK.
  - Real **R 4.1.0** check log verified (`output/r41-check.log`: `900 PASS`, clean-library PSOCK worker parity, 0 err / 0 warn / 2 NOTEs including old clock-check service).
  - All **8 B3 release blockers** independently re-tested and confirmed fixed.
  - **5,000-animal pure-R pedigree (`R/ancestry.R`, 129 LOC):** independently verified `9.71 s` (peak `10,000` living, `55,000` ancestry records), `1.701 MiB` state, **`0` max oracle error**.
  - **Woodhen scaling gate (`K = 30`, 1,000 × 40-yr, `strict`, 8 fork):** passes under `< 60 s / < 2 GB`, though slowed from `12.5–15.5 s / 732–961 MiB` (`f6559e9`) to `24.05 s` (Codex) / `51.94 s` (adviser re-run) at `1,263 MiB`—flagged for Claude's diff audit (likely copy-on-modify value semantics on the dense kinship store).

## Stage B5 — Brief Final Diff Audit (complete & verified 25 Nov 2026)

- **Audit workspace & report:** `~/claude/openpva-audit/output/B5-audit.md` (archived under `projects/openpva/work/frozen-B5/claude-B5-audit.md`, 1,097 words; clean `git status`).
- **Verdict:** **`GO`** — zero blockers across 7 live `< 5 s` reproducers (dense vs. traced vs. mid-run-switched pedigree parity to `5.6e-17` including related/inbred founders, dead-sire retention, strict tamper guard, split-survival edge cases, unseeded RNG advancement, fast-mode parentage).
- **Woodhen watchpoint:** Claude accepted the value-semantics copy trade-off (`0.59 s -> 0.77 s`, ~1.3× serial for 10 runs, due to matrix copies during `.dense_materialise()` that guarantee tamper detection); gate remains well under `< 60 s / < 2 GB`.
- **Non-blocking follow-ups recorded for post-2.0.0:** (1) warn/guard against female-only survival tables in `age_sex_rate()` silently returning 0 for males; (2) add a related-founder block crossing 2,000 slots to `scripts/benchmark_large_pedigree.R` and note one-way dense→traced switch; (3) verify live GitHub Actions CI across Ubuntu/macOS/Windows + R 4.1.0 on first push; (4) note in `README.md` that `mate_from_field()` requires refreshing pairing fields each interval.
- **Pre-landing note:** Replace sprint-scoped `AGENTS.md` in `~/codex/openpva-2.0` with a permanent `OpenPVA 2.0.0` `AGENTS.md` (and note AI-system provenance in `NEWS.md`/commit message) before opening a history-preserving PR onto `BWBrook/OpenPVA`.

## Landing — PR #1 on `BWBrook/OpenPVA` (25 Nov 2026)

- **Pull request:** https://github.com/BWBrook/OpenPVA/pull/1 (`openpva-2.0.0` @ `4806407` off `main` @ `89b34ee`, preserving full 1.x history).
- **Pre-landing polish (on top of `c4dafb6`):** permanent `OpenPVA 2.0.0` `AGENTS.md`, `README.md` cleanup + B5 notes (`mate_from_field()` interval refresh & one-sex survival table warning for `age_sex_rate()`), explicit AI-system provenance in `NEWS.md`, and `libuv1-dev` on Linux CI (fixing `fs 2.1.0` compilation while keeping single-line `Rscript --vanilla` for Windows `rtools45` bash).
- **Local verification:** `gitleaks protect --staged` (`0` leaks); `R CMD check --as-cran --no-manual` (`0 err / 0 warn / 1 NOTE` [New submission], `900 PASS / 0 FAIL / 0 WARN / 0 SKIP`, `73.0 s`).
- **Live GitHub Actions CI ([Run 45547346310](https://github.com/BWBrook/OpenPVA/actions/runs/45547346310)) — 4/4 PASS:**
  - `ubuntu-24.04 / R release`: PASS (`3m46s`)
  - `ubuntu-24.04 / R 4.1.0` (including `scripts/check_r_floor.R` clean-library PSOCK worker check): PASS (`4m1s`)
  - `macos-latest / R release`: PASS (`2m52s`)
  - `windows-latest / R release`: PASS (`1m48s`)

## Next action

- **Barry:** Review and merge [BWBrook/OpenPVA#1](https://github.com/BWBrook/OpenPVA/pull/1) when ready (and optionally cut a `v2.0.0` release tag / Zenodo DOI later).
- **Cleanup (once merged):** Prune temporary pilot clones (`~/codex/openpva`, `~/claude/openpva`, `~/gemini/openpva`, `~/codex/openpva-2.0`, `~/claude/openpva-audit`) when Barry confirms.

## Post-pilot retrospective (25 Nov 2026)

- **Independence & fresh-session cross-critique ROI:** B2 produced three genuinely distinct engineering philosophies from one charter (Codex: C++ fixed-schema sidecar; Gemini: backwards-compatible dual paths + C99; Claude: pure-base-R unified columnar redesign). Fresh-session read-only B3 (~40 min) was the highest-leverage step of the pilot: every model family caught unique, live-reproducible release blockers in the winning build that the other two missed (8 blockers total), and live PR CI then caught the Ubuntu `libuv1-dev` packaging gap before touching `main`.
- **Human attention (design vs. supervision):** High-value human judgement went to reframing the North Star early—stopping the premature paper reflex and anchoring on a clear tool-first test ("modern GAPPS") via a plain-English charter gut-check. Routine supervision friction came from WSL local compute (15–18 h overnight runs instead of offloaded remote `tmux`), host `renv`/R mismatch, and B2 prompt ambiguity on unified vs. sidecar engines.
- **Proportionate convergence:** Picking one coherent backbone (`candidate-claude` 2.0.0) and harvesting targeted peer fixes/algorithms (Codex's `codetools`/PSOCK fix and dispersal counts; Gemini's ancestor-compressed pedigree algorithm rewritten in 129 lines of pure R) via a single Codex hardening sprint (B4) + Claude diff audit (B5) beat merging three architectures.
- **Harness updates landed:** All six pilot lessons are folded into `BWBrook/research-advisor`, and the pilot directly clarified why **Track B (Project rebase & completion)** and **Track C (Tabula-rasa research)** belong as separate tracks (`workflows/B-project-rebase.md`, `workflows/C-tabula-rasa.md`, `prompts/B1-project-rebase.md`, `prompts/C1-tabula-rasa-conception.md`, `prompts/BC2-execution.md`, `prompts/BC3-cross-critique.md`, `scripts/build-isolated-clones.sh --workflow C`).
