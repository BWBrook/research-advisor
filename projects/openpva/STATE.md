# Current state — OpenPVA (Workflow B)

Updated: 25 November 2026, Australia/Hobart. **Round B2 complete and independently verified across all three scientists (clean `git archive` builds, `R CMD check --as-cran --no-manual`, `testthat`, and uniform process-tree RSS scaling gates); frozen B2 reports/preregistrations archived; ready for Barry's B3 / adjudication decision.**

- **Workflow:** B — Original research / scientific-software completion from a partially developed repository
- **Adviser:** Gemini 4 Neon (separate from the three independent scientists)
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license)
- **Common source baseline:** commit `89b34eeaae608a39b9c040fe8e9f7af217d9ab47` (`89b34ee`, 19 Nov 2026)
- **Curated single-commit baseline:** commit `ed0178c1027e20013259c926eab93cbd1dbf48a7` (`505 PASS`, `79.2 s` on host R 4.6.2)
- **Active Charter:** [charter.md](charter.md) (adopted 24 Nov 2026)

## Scientists — Verified Round B2 Summary (25 Nov 2026)

| Family | Model | Frozen B2 commit | Package & LOC | Independent `R CMD check --as-cran` | Independent scaling gate (1,000 × 40-yr pedigree Woodhen) |
|---|---|---|---|---|---|
| **OpenAI (Codex)** | `gpt-6.2-astra` | `154d329` | `OpenPVA 1.1.0` — 5,052 R + 765 C++ (`src/cohort.cpp`); two-engine split (`process_core.R` untouched + fixed-schema C++ `cohort_program()`); `Imports: codetools, dplyr, tibble` | **0 err / 0 warn / 2 NOTEs** (`550 PASS`, 85.0 s; examples OK; also tested on real R 4.1.0) | **4.14 s / 151 MiB** tree RSS (1 core, `cohort_program` C++, `N ≈ 125`) |
| **Anthropic (Claude)** | `Fable 5.2` | `f6559e9` | **`OpenPVA 2.0.0` — 2,780 R, 0 compiled code**; unified columnar pure-base-R engine, lazy in-place living-only kinship store; `Imports: parallel, stats, utils` only | **0 err / 0 warn / 1 NOTE** (New submission only; `726 PASS`, 47.3 s; examples OK) | **15.48 s / 961 MiB** tree RSS (8 fork workers, **`strict` validation**, `inst/examples/woodhen`, `N ≈ 187`) |
| **Google (Gemini)** | `Gemini 4 Carbon High` | `14fa2f7` | `OpenPVA 1.0.1` — 7,406 R + 838 C99 (`src/openpva_c.c`); unified backwards-compatible list+columnar engine + ancestor-compressed BFS pedigree; `Imports: parallel, stats, tibble, tools, utils` | **0 err / 0 warn / 2 NOTEs** (`589 PASS`, 98.6 s; examples NONE) | **22.30 s / 1,251 MiB** true tree RSS (8 fork workers, `fast` validation, `N_final ≈ 274`; report's `144.4 MiB` was parent-only `VmHWM`) |

## Key B2 findings verified on disk

- **Why Codex took 32 min vs. Claude/Gemini 15–18 h:** Codex did not stop early (it ran 444,020 trajectories + replay + real R 4.1.0 check + verified 1995/1999–2001 Woodhen historical check), but achieved speed by leaving `OpenPVA`'s general `pva_process()` engine untouched and building a separate fixed-schema C++ simulator (`cohort_program()`). Claude rebuilt the unified package in pure base R and ran a huge 12,096-cell factorial (plus a full Woodhen rerun after an 8.9 GB `N > 5,000` kinship OOM and a 1.2M-replicate precision top-up). Gemini kept full backwards compatibility (8,244 LOC), ran slower per core despite C99, and ran ~350,000+ adaptive replicates locally.
- **Scientific convergence across all three independent studies:**
  1. Expectation-matching removes most apparent density/ordering "package effect" variance (leaving parametric uncertainty dominant: ~62–95% of variance).
  2. Structural mechanisms that genuinely survive matching are **inbreeding representation** (omitting inbreeding understates risk dramatically; scalar `proxy_Ne` misstates baseline drift unless generation-time-scaled [Claude] and fails severely under supplementation by missing outbred founder genetic rescue [Gemini]), **carrying-capacity semantics** (hard truncation vs. territorial floaters vs. sub-capacity Beverton–Holt damping), and **process/release timing** near decision margins. Bounded vs. Poisson litters at equal mean had negligible impact.
  3. **Parsimony check:** Compact age/sex count models preserve ordinal management rankings well (0%–minimal regret) but diverge sharply on absolute risk thresholds and supplementation gains when individual pedigree/genetic rescue or territorial/maternal structure matters.
- **Adviser judgement under Barry's "1987 Richard Harris" North Star:** **Claude's `OpenPVA 2.0.0` (`f6559e9`)** is the standout package backbone (one clean unified pure-base-R engine, 2,780 LOC, zero external dependencies, idiomatic vectorized R, 15.5 s strict-validated pedigree gate, 1 CRAN NOTE), with three targeted imports/hardening items from peers: Codex's PSOCK `.libPaths()` + `--vanilla` fix and real R 4.1.0 test, an explicit large-$N$ (`N > 2,000`) memory guard or sparse/compressed fallback inspired by Gemini's C99 ancestor-BFS pedigree, and retaining a clean Grizzly mammal example alongside Woodhen.

## Settled decisions

- **23 Nov 2026 (B1 setup):** Preserve OpenPVA's GAPPS-style composable ordinary-R process philosophy; curated remote-free single-commit clones.
- **24 Nov 2026 (Charter & North Star):** North Star is **OpenPVA as the modern GAPPS** (tool conservation biologists and AI agents choose to use), anchored by the *"1987 Richard Harris"* litmus test; case studies serve to develop, stress-test, and illustrate the tool rather than forcing a primary journal paper prematurely.

## Verified on disk (25 Nov 2026)

- Frozen B2 reports, preregistrations, and `HEAD` SHAs archived under gitignored `projects/openpva/work/frozen-B2/{codex,claude,gemini}/`.
- Independent clean `git archive HEAD` builds, `R CMD check --as-cran --no-manual`, `testthat`, and uniform process-tree RSS benchmarks completed in gitignored `projects/openpva/work/verify/`; all three scientist workspaces remain untouched with clean `git status` and zero remotes.

## Next action

Await Barry's choice: run a **lean, read-only Round B3 cross-critique** (recommended—fast adversarial code/science audit of the three frozen B2 builds, especially stress-testing Claude's `2.0.0` backbone before adoption) OR move straight to adopting and hardening Claude `OpenPVA 2.0.0` for Sprint 2 / landing on `BWBrook/OpenPVA`.

## Banked harness lessons (deferred until post-B3 update)

- **Default: not paper-shaped until the human pulls the trigger.** Resist agents' reflex to turn every Workflow B tool/investigation into a journal manuscript prematurely; keep documentation thorough without forcing paper framing until explicitly chosen.
- **Intermediate-repo curation applies to Workflow B**, not just Workflow A (stripping stale agent roadmaps/handovers/artefacts prevents B1 anchoring).
- **Plain-English charter gut-check before B2 launch**, plus a quick host-runtime/`renv` pre-flight and placing `CHARTER.md` inside gitignored `output/` to keep `git status` and `R CMD check` clean.
- **Remote compute & detachable `tmux` routing in B2 prompts:** Never anchor heavy B2 assignments exclusively to the local laptop; explicitly remind scientists in gitignored `ASSIGNMENT-B2.md` to offload long or parallelisable runs to available remote servers / resized cloud VMs / HPC batch queues inside detachable `tmux` sessions—assigning each scientist its own **isolated per-family remote directory** so peer isolation holds off-laptop too (and keeping machine hostnames strictly in gitignored local files / personal machine policy, never in public repo files).
- **Specify "single unified engine" invariant explicitly when performance gates are set:** Without it, a fast-optimising scientist can satisfy a benchmark gate via a separate fixed-schema compiled sidecar rather than speeding up the general composable engine.
