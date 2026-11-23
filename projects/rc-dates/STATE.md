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

## Next decision (awaiting Barry)

1. **A2 arrangement:** Option A (recommended: three independent full rewrites, each executing its own recommended arc under one shared content/length/accuracy contract) vs. Option B (lock Archive-First across all three) vs. Option C (single primary drafter + two critics).
2. **Figures:** Keep all 6 existing figures in `main.md` for A2 (avoiding SI edits now), or allow testing Fig. 4 demotion to SI?
3. **Comparator:** Allow adding the verified `r_all` ratio-1.5 baseline (`98.2–99.6%`) to A2 drafts (to be registered cleanly in `claims.csv` at integration)?

## Decision log

- **2026-11-23:** Locked baseline to `rc-dates@890a570`; scoped reconstruction to `main.md` + abstract + `figures.md` captions for JAS (~5,000 words / 250 abstract), deferring `brief.md`, `for-agents.md` and `supplement.md` until `main.md` is done. Built curated single-commit baseline (`0bf856f`) and isolated remote-free clones. Completed and compared all three A1 assessments.
