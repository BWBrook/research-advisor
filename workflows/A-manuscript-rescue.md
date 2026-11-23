# Workflow A: Manuscript reconstruction (completed science)

**Use when:** Data collection, modelling, validation and an initial manuscript already exist, but incremental revisions have produced dense, defensive or unreadable prose. The remaining problem is scientific communication, not further investigation.

## What success looks like

A coherent manuscript the lead scientist can read from start to finish, recognise as the science intended, and send to collaborators or a target venue. Central question, evidence and contribution are clear; values, uncertainty, necessary methods, limitations and attribution remain accurate. New modelling, data collection, broad literature expansion and speculative research extensions are **out of scope**.

## Stage 1 — Curated baseline and independent editorial conception (A1)

1. **Freeze a curated, single-commit, remote-free baseline** from the source repository containing *only* what scientists need: figures (plus PNG previews for PDFs so every model family has equal visual access), claims ledger, interpretation contract, compact primary summary CSVs, target manuscript text + captions, attribution metadata and verified bibliography.
   - **Exclude** `git log`, historical review/rework memos, stale checklists, out-of-scope renderings (e.g. briefs or supplements if reconstructing the main article first), raw data blobs and analysis scripts.
   - Clone into isolated per-family workspaces (`~/codex/<slug>`, `~/claude/<slug>`, `~/gemini/<slug>`) with `origin` removed (see `scripts/build-isolated-clones.sh` and `docs/operating-notes.md`).
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

- Specify **outcomes, hard scientific bounds, audience and length ceiling**—not internal workflows or wording templates (`docs/operating-notes.md` §0).
- Defer repository build markup (e.g. inline claim-binding spans) until final integration so writers focus cleanly on narrative clarity and scientific fidelity.
- Protect content coverage with a compact scientific-unit table inside each submission (not a sentence-by-sentence mapping):

| Source location / Claim ID | Content that must remain | Destination in new paper/package | Material change or unresolved issue |
|---|---|---|---|
| Result, method, figure or citation | Claim, value, qualification or reproducibility requirement | Section, figure, table or supplement | Only what needs attention |

- A necessary qualification must still constrain the claim it qualifies; relegating it to a supplement is not always enough. Where source prose contradicts a table or ledger, flag the exact discrepancy rather than silently polishing it away or launching a scientific audit.

## Stage 3 — Independent cross-critique, fresh primary writer and fidelity audit (A3+)

- Freeze A2 drafts before cross-review. Each scientist can independently critique the other drafts on scientific fidelity, coverage, clarity, argument and pacing—tying every critique to evidence rather than style preferences.
- **Fresh primary writer option (preferred when voice matters):** Rather than picking one scientist draft directly or patchwork-merging paragraphs across drafts (which recreates accretive prose), commission a **fresh primary writer session** (e.g. a new Gemini 4 Neon session separate from both the adviser and the three scientists) working closely with the lead scientist. That writer selects one coherent narrative spine, absorbs the best framing moves, tables and factual catches from the three A2 drafts and critiques, and **composes the final prose fresh in one unified voice from top to bottom**.
- **Scientists as final fidelity critics:** Once the primary writer's draft exists, hand it back to the three scientists specifically for a **scientific accuracy, coverage and boundary audit** (not style nitpicking). Re-attach automated ledger/build checks once on the final text, and move swiftly to collaborator review.
- Do not let speculative polish defer dissemination indefinitely.
