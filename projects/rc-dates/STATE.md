# State: `rc-dates` (Workflow A pilot)

Updated: 23 November 2026, Australia/Hobart. **Adviser:** Gemini 4 Neon.

## Baseline and scientists

- **Source commit:** `rc-dates@890a570dc6ef96fd94bbb3eb012d17d7f86eca29` (`main`, clean)
- **Curated baseline commit:** `0bf856f46ffa0ada99be65a56a4502b49c5cae35` (44 manifest files + 5 PNG previews of PDF figures, single commit, remote-free clones; local paths in gitignored `local.json`)
- **Scientists (desktop-app primary surface):**
  - **OpenAI:** `gpt-6.2-astra` (Codex) — **A1 complete** (`output/A1-assessment.md` read & verified)
  - **Anthropic:** `fable` / Fable 5.2 (Claude Code) — **A1 complete** (`output/A1-assessment.md` read & verified)
  - **Google:** `gemini-4-carbon-high` (Antigravity, isolated from Neon adviser) — **A1 complete** (`output/A1-assessment.md` read & verified)

## Completed: Stage A1 (Independent editorial conception)

All three scientists respected every isolation boundary, found **no material scientific contradiction**, and converged independently on four diagnoses:
1. **Broken Methods–Results order:** `main.md` hooks on AustArch (§1), starts Methods with AustArch (§2.1–2.2), then flips Results to Simulations first (§3.1–3.2) and pushes AustArch to §3.3 / Fig. 6.
2. **Stage-stitching and repetition:** Stage 2 (10-fold) and Stage 6 (1.5–5-fold) are narrated chronologically rather than as one unified dose-response design; findings are retold up to 6×; Methods + captions consume nearly 2,000 words while Results get ~870; superseded `v1`/`v2` noise checks are rehearsed at length ahead of Stage 7.
3. **`estimands.md` mixes sound scientific bounds with style over-policing:** All three endorsed the core scientific bounds and independently flagged literal sentence-grain subject policing, verbatim required phrases (`"cannot, by itself"`), and over-broad phrasing bans.
4. **Distinct independent catches worth carrying into A2:**
   - *Codex:* `main.md` §3.1 says "mean absolute contrast" (`mean(|c|)`), whereas `C15` and Fig. 4 report magnitudes of **signed means** (`|mean(c)|`).
   - *Claude:* Missing all-date weak-trend comparator—verified directly in `stage6_selection_rates.csv` as **98.2–99.6%** (`r_all`, ratio 1.5); unbound §3.3 empirical bracketed numbers (`C08`).
   - *Gemini:* Frozen Fig. 2/3 label mismatch (*"truth-consistent state"* vs. *"correct direction"*) and unexplained 116- vs. 68-site shell/bone filter asymmetry.

**Key editorial divergence:** Codex and Claude recommend **Archive-First** (open with the 68-site, 5,500-year Australian shift; Codex's 2-paragraph prose specimen stood out strongly for voice); Gemini recommends **Mechanism → Unified Simulation → Archive** (preserves Figure 1–6 numbering). Claude also proposed demoting Fig. 4 to SI and adding a compact empirical table; Codex and Gemini keep all 6 figures.

## Active stage: A2 (Three independent full manuscript rewrites)

Commissioned 23 November 2026 under **Option A + planned fresh primary writer**:
- **Assignment:** Each scientist independently writes a complete fresh `output/A2-main.md`, `output/A2-figures.md` (captions), and compact `output/A2-coverage.md` using its own recommended A1 narrative arc, targeting **4,300–4,600 words** total (JAS cap 5,000; Abstract ≤ 230 words; double-anonymised), keeping all 6 existing figures (reordering permitted; compact empirical summary table permitted; no edits to `supplement.md` or source files), omitting `[value]{.Cxx}` ledger spans during drafting, and keeping exact `[@key]` citations from `references/refs.yaml`.
- **Shared factual & editorial clarifications supplied equally to all three:**
  - Keep all substantive scientific boundaries in `estimands.md`; lift the four style-policing constraints (verbatim required strings like `"cannot, by itself"`, sentence-grain subject policing, per-sentence scope repetition, and verbose `v1`/`v2` narration—condense `v1`/`v2` to one honest sentence pointing to S3).
  - Clarify `C15`: reported magnitudes (`0.345–0.351`, `0.585–0.597`) are magnitudes of **signed means** (`|mean(c)|`), not `mean(|c|)`.
  - Explain frozen Fig. 2/3 `"truth-consistent state"` labels clearly in prose/captions.
  - Verified all-date weak-trend detection baseline from `stage6_selection_rates.csv` (`r_all`, ratio 1.5: **98.2–99.6%**, 0 reversals) may be cited if useful and flagged in `A2-coverage.md` for ledger registration at final integration.
- **Planned downstream stage (after A2):** Compare the three full drafts (and optionally run a focused A3 cross-critique), then commission a **fresh Gemini 4 Neon primary writer session** working with Barry to compose the final paper in one unified voice—using the three A2 drafts as grist (never patchwork-stitched) and the three scientists as final accuracy/fidelity critics.
- **Status:** `output/ASSIGNMENT-A2.md` staged in all three isolated clones (`~/{codex,claude,gemini}/rc-dates`); ready for desktop-app launch.

## Decision log

- **2026-11-23:** Locked baseline to `rc-dates@890a570`; scoped reconstruction to `main.md` + abstract + `figures.md` captions for JAS (~5,000 words / 250 abstract), deferring `brief.md`, `for-agents.md` and `supplement.md` until `main.md` is done. Built curated single-commit baseline (`0bf856f`) and isolated remote-free clones. Completed and compared all three A1 assessments.
- **2026-11-23:** Commissioned A2 (three independent full rewrites, each executing its own A1 arc under one shared accuracy/length contract, all 6 figures retained, style-policing lifted). Settled downstream final-prose model: a fresh Gemini 4 Neon primary writer + Barry will compose the final narrative in one voice using the three drafts as grist, with Astra, Fable and Carbon acting as fidelity critics.
