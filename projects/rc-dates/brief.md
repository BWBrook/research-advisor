# Project brief: `rc-dates` (Workflow A pilot)

- **Workflow:** [A — Manuscript reconstruction](../../workflows/A-manuscript-rescue.md)
- **Live status:** [STATE.md](STATE.md)
- **Source baseline:** `rc-dates@890a570dc6ef96fd94bbb3eb012d17d7f86eca29` (`main`, clean working tree)

## Problem and scope

The science, data curation, simulations (Stages 2, 6, 7), empirical AustArch benchmark, figures and claims ledger (`C01`–`C29`) are complete and settled. The problem is communication: months of iterative agent revisions and audits produced a dense, over-qualified main manuscript (`4,987` built words against a `5,000`-word cap; `250/250` abstract) that reads like a defensive specification rather than a persuasive journal article.

## Settled targets and sequencing (23 Nov 2026)

- **Target deliverable:** Reconstruct **`manuscript/text/main.md`** (including Abstract) and **`manuscript/text/figures.md`** captions for co-author review and submission to the ***Journal of Archaeological Science*** (JAS).
- **Venue constraints:** ~5,000 words maximum (target ~4,300–4,600 for breathing room), ≤250-word Abstract, double-anonymised review (6 co-authors on separate title page: Brook, Wheatley, Johnson, Williams, Ulm, Yates).
- **Sequencing:** Do **not** work on `brief.md`, `for-agents.md`, or `supplement.md` until `main.md` is finished. All three were excluded from the A1 curated snapshot so scientists form fresh narratives from primary evidence + `main.md` alone.
- **Interpretation contract:** Treat `manuscript/estimands.md` as the substantive scientific accuracy boundary while lifting rules that over-police prose style (verbatim required strings, sentence-grain subject policing, redundant per-sentence scope repetition). Defer Pandoc `[value]{.Cxx}` ledger-binding markup until final integration onto the selected manuscript.
- **Curated isolation:** Single-commit, remote-free snapshot (`0bf856f`, 44 manifest files + 5 rendered PDF→PNG figure previews + neutral `INPUT.md`, 4.2 MB), cloned separately for OpenAI (`gpt-6.2-astra`), Anthropic (`fable` / Fable 5.2) and Google (`gemini-4-carbon-high`). Historical review trails (`manuscript/reviews/`, `docs/`, `.scrivmark/`, `git log`) and the Correspondence Board are excluded.
