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

## Completed: Stage A2 (Three independent full manuscript rewrites)

All three scientists delivered `output/A2-main.md`, `output/A2-figures.md`, and `output/A2-coverage.md` (verified directly on disk: zero `{.Cxx}` spans, zero invalid citation keys, zero double-anonymity leaks, 0.8–3.3% 8-gram overlap with baseline `main.md`).

- **Apples-to-apples Pandoc-rendered whitespace counts** (baseline = `5,044` [DOCX `4,987`], Abstract `250`, 45 citations):
  - **Codex (`gpt-6.2-astra`):** **4,472** total (Abstract **202**, captions **585**), **27** citations (dropped 18 baseline refs, including co-authors Ulm 1996 and Williams 2015/2016), **0.8%** overlap. Best pure prose voice and tightest length; used a 5-section narrative arc (non-standard IMRaD) with Archive-First; nailed `1,872,000 = 720,000 + 1,152,000` combined row count.
  - **Claude (`claude-fable-5-2`):** **4,746** total (Abstract **230**, captions **507**), **45/45** baseline citations intact, **3.3%** overlap. Strongest standard JAS IMRaD + Archive-First structure, claim-driven Results subheadings, cleanest fidelity (verified 50% constant directionality and flagged `stage6_summary.txt`'s `"selected-state agreement"` phrasing); ~100 words above target band (well under 5,000 cap).
  - **Gemini (`gemini-4-carbon-high`):** **4,581** total (Abstract **229**, captions **574**), **47** citations (45 baseline + 2 valid `refs.yaml` Contreras papers), **2.4%** overlap. Strongest archaeological "three safeguards" framing, complete 10-row empirical Table 1 (verified exact against CSVs), preserved Fig. 1–6 numbering, and exact linear-vs-exponential breakdown of 75% ten-fold uniform rates (`78.8–81.9%` linear, `100%` exponential); one verified factual error in §2.1 attributing the combined `1,872,000` rows to Stage 6 alone (`1,152,000`), and densest/most code-styled prose (inline backticks and nested parentheticals).

## Active stage: A3 — Fresh Gemini 4 Neon primary writer (pre-writer cross-critique skipped)

Decided 24 November 2026:
- **Sequence:** Skip intermediate scientist cross-critique (adviser A2 audit against primary CSVs and `refs.yaml` was sufficient); proceed directly to a **fresh Gemini 4 Neon primary writer session** working with Barry in an isolated workspace (`~/writer/rc-dates`), followed by **A4 final scientific-fidelity audit** by Astra, Fable, and Carbon on Neon's unified manuscript.
- **Settled spine & bounds:** Standard JAS **IMRaD + Archive-First** (AustArch empirical shock promoted to Fig. 1, mechanism Fig. 2, unified simulations Figs. 3–6), retaining all 6 existing graphics, targeting **4,300–4,600 words** (Abstract ≤ 230), omitting `{.Cxx}` markup until final integration, and harvesting Claude's structure + Codex's voice + Gemini's archaeological safeguards framing into one completely fresh unified draft (never patchwork-stitched).
- **Left to Neon writer + Barry:** Final title choice, Table 1 design (compact 4-row vs. fuller empirical summary), and non-core citation curation (preserving co-authors' relevant works and core field anchors from `refs.yaml`).
- **Status:** Isolated writer workspace (`~/writer/rc-dates`, single-commit baseline `0bf856f` + read-only `grist/` containing all three A2 drafts and `adviser-a2-synthesis.md` + `output/ASSIGNMENT-A3-WRITE.md`) staged and ready for Barry to launch in a fresh Antigravity Neon window.

## Decision log

- **2026-11-23:** Locked baseline to `rc-dates@890a570`; scoped reconstruction to `main.md` + abstract + `figures.md` captions for JAS (~5,000 words / 250 abstract), deferring `brief.md`, `for-agents.md` and `supplement.md` until `main.md` is done. Built curated single-commit baseline (`0bf856f`) and isolated remote-free clones. Completed and compared all three A1 assessments.
- **2026-11-23:** Commissioned A2 (three independent full rewrites, each executing its own A1 arc under one shared accuracy/length contract, all 6 figures retained, style-policing lifted). Settled downstream final-prose model: a fresh Gemini 4 Neon primary writer + Barry will compose the final narrative in one voice using the three drafts as grist, with Astra, Fable and Carbon acting as fidelity critics.
- **2026-11-24:** All three A2 manuscripts audited independently against primary CSVs, `refs.yaml`, and baseline `main.md` (all verified genuinely fresh, clean, and ready for fresh primary-writer synthesis).
- **2026-11-24:** Skipped pre-writer scientist cross-critique; commissioned fresh Gemini 4 Neon primary writer in isolated `~/writer/rc-dates` on the IMRaD + Archive-First spine (leaving title, Table 1 design, and non-core citation curation to Neon + Barry), reserving Astra, Fable, and Carbon for the A4 final scientific-fidelity audit.
