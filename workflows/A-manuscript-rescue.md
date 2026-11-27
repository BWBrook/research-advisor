# Workflow A: Manuscript reconstruction (completed science)

**Use when:** Data collection, modelling, validation and an initial manuscript already exist, but incremental revisions have produced dense, defensive or unreadable prose. The remaining problem is scientific communication, not further investigation. Track A *already is* communication distillation of validated science (`docs/operating-notes.md` §0); no separate post-A4 distillation phase is needed.

## What success looks like

A coherent manuscript the lead scientist can read from start to finish, recognise as the science intended, and send to collaborators or a target venue. Central question, evidence and contribution are clear; values, uncertainty, necessary methods, limitations and attribution remain accurate. New modelling, data collection, broad literature expansion and speculative research extensions are **out of scope**.

## Stage 1 — Curated baseline and independent editorial conception (A1)

1. **Freeze a curated, single-commit, remote-free baseline** from the source repository containing *only* what scientists need: figures (plus PNG previews for PDFs so every model family has equal visual access), claims ledger, interpretation contract, compact primary summary CSVs, target manuscript text + captions, attribution metadata and verified bibliography.
   - **Exclude** `git log`, historical review/rework memos, stale checklists, out-of-scope renderings (e.g. briefs or supplements if reconstructing the main article first), raw data blobs and analysis scripts.
   - Clone into isolated per-family workspaces (`~/codex/<slug>`, `~/claude/<slug>`, `~/gemini/<slug>`) with `origin` removed (see `scripts/build-isolated-clones.sh` and `docs/operating-notes.md`). If full-text reference PDFs or large frozen outputs are needed read-only, keep one master folder (`~/shared/<slug>/`, files `chmod a-w`) and hardlink it into each clone's gitignored `resources/` directory via `--resources-dir` (`docs/operating-notes.md` §3).
2. **Issue identical assignments** from [A1-editorial-reconnaissance.md](../prompts/A1-editorial-reconnaissance.md) with a neutral `INPUT.md`.
   - Encourage evidence-first reading (figures, ledger and primary summary tables before reading the old prose) so each scientist forms its own mental model of the contribution.
   - Ask for: contribution, indispensable content, prose and guardrail diagnosis (distinguishing genuine scientific bounds from style over-policing), 2–3 substantially different narrative arcs, a **150–250 word prose specimen** (testing real voice, not just outlines), and editorial boundaries.
   - Forbid querying any shared discussion board, peer workspaces, parent repository history, or prior project memory.

## Decision after A1

The adviser reads all three assessments directly and compares them with the lead scientist:
- Where do all three converge independently on structural defects or over-policing?
- What genuine narrative trade-offs exist (e.g. archive-first vs. mechanism-first)?
- Did any scientist catch a concrete factual ambiguity or wording error in the source?

Choose the A2 arrangement based on real evidence rather than ritual: three independent full rewrites (free or shared narrative), or one primary drafter with two independent critics.

## Stage 2 — Fresh composition with coverage protection (A2)

- Use [A2-fresh-draft.md](../prompts/A2-fresh-draft.md) to specify **outcomes, hard scientific bounds, audience and length ceiling**—not internal workflows or wording templates (`docs/operating-notes.md` §0). Supply any factual clarifications or lifted style-policing rules neutrally and identically to all three scientists without leaking peer interpretations.
- Defer repository build markup (e.g. inline claim-binding spans) until final integration so writers focus cleanly on narrative clarity and scientific fidelity.
- Protect content coverage with a compact scientific-unit table inside each submission (`output/A2-coverage.md`), not a sentence-by-sentence mapping:

| Source location / Claim ID | Content that must remain | Destination in new paper/package | Material change or unresolved issue |
|---|---|---|---|
| Result, method, figure or citation | Claim, value, qualification or reproducibility requirement | Section, figure, table or supplement | Only what needs attention |

- A necessary qualification must still constrain the claim it qualifies; relegating it to a supplement is not always enough. Where source prose contradicts a table or ledger, flag the exact discrepancy rather than silently polishing it away or launching a scientific audit.
- **Adviser audit before Stage 3:** Read all three drafts directly and run an apples-to-apples check on Pandoc word counts, citation-key diffs (especially co-author works), 8-gram freshness overlap, anonymity/markup hygiene, and primary-CSV spot-checks (`docs/operating-notes.md` §6).

## Stage 3 — Fresh primary writer (`~/writer/<slug>`), de-AI pass, `scrivmark` review and final fidelity audit (A3–A4)

- **Skip pre-writer scientist cross-critique when the adviser's A2 audit already surfaces the factual catches and structural trade-offs.** Save the three scientists' critical energy for auditing the actual deliverable going to collaborators. (If deep substantive ambiguity remains across drafts, run a bounded cross-critique first.)
- **Fresh primary writer (`~/writer/<slug>`):** Stage a dedicated remote-free writer workspace with `scripts/stage-writer-workspace.sh` (cloning the curated baseline and placing frozen scientist drafts + `adviser-a2-synthesis.md` into read-only, gitignored `grist/`), keeping `~/{codex,claude,gemini}/<slug>` untouched for the final audit. Commission a fresh primary writer session using [A3-primary-writer.md](../prompts/A3-primary-writer.md), working directly with the lead scientist. Lock the macro-spine and hard invariants; leave voice, title, table design and non-core citation curation to the writer + lead scientist. Compose **fresh from top to bottom in one unified voice**—never patchwork-stitching paragraphs across drafts.
- **Anti-slop (`audit-ai-writing`) pass before human read-through:** Run the `audit-ai-writing` scanner (`--genre scientific`) plus a manual cluster audit on `output/FINAL-main.md` and `output/FINAL-figures.md` before the lead scientist reads. Ignore domain terms of art and required Markdown headings; target genuine LLM surface clusters—excessive em dashes, repeated `X, not Y` / `rather than` antitheses, stacked triads or repeated `First/Second/Third` scaffolding, copulative avoidance (`serves as`), and aphoristic closers.
- **Lead-scientist line edit via `scrivmark`:** Once the polished draft is ready for human review, place the draft on a tracked branch (inside `~/writer/<slug>` or the target repo) and run the lead scientist's review round in **`scrivmark`**, letting the primary writer respond cleanly to every inline edit and margin comment.
- **Stage 4 — Scientists as final fidelity critics:** Freeze the signed-off manuscript (`FINAL-main.md` + `FINAL-figures.md`) and hand it back to the three scientists specifically for a **scientific accuracy, numerical fidelity, estimand-boundary and coverage audit** (not style committees).

## Stage 5 — Integration, `makedoc` build and `living-paper` products

- **Integrate and build with `makedoc`:** Move the fidelity-checked manuscript back into the scientific repository, update the claims ledger and interpretation contract (`claims.csv`, `value-bindings.csv`, `estimands.md`) for any newly registered verified comparators or relaxed style rules, re-attach inline Pandoc claim-binding spans (`[value]{.Cxx}`), and build/verify with **`makedoc`** (`make manuscript-check`, `make manuscript-build`, exact DOCX word count and visual PDF inspection).
- **`living-paper` division of labour (after `main.md` settles):**
  - **Fresh primary writer + lead scientist** handle human-facing products: the journal article (`main.md` + `figures.md`) and, when needed, the two-page plain-language **brief** (`brief.md`, checked by `makedoc` for two-page fit).
  - **The three scientists** handle machine-facing and audit products: updating and independently verifying the **agent-first guide (`for-agents.md`)**, aligning `supplement.md` cross-references/figure numbers, and auditing the claims ledger across all products.
- Do not let speculative polish defer collaborator review or release indefinitely.
- **Post-pilot archive & cleanup:** Once the reconstructed manuscript lands on its upstream repository, package the temporary `~/{codex,claude,gemini,writer}/<slug>` workspaces (`.git`, tracked files and Markdown reports only, stripping generated outputs) into one compact `.zip` with `scripts/archive-pilot-clones.sh --delete-sources` (`docs/operating-notes.md` §7).
