# Stage A2 — Independent fresh manuscript reconstruction: `[project name]`

## Inputs and output destinations

- Curated workspace (isolated single-commit snapshot): `[absolute path]`
- Source commit this snapshot was exported from: `[baseline]`
- Neutral input packet: `[path to INPUT.md]`
- Your own A1 assessment: `[path to output/A1-assessment.md]`
- Write your three deliverables to:
  1. `[workspace]/output/A2-main.md` (complete fresh manuscript)
  2. `[workspace]/output/A2-figures.md` (revised captions for existing figures)
  3. `[workspace]/output/A2-coverage.md` (compact coverage map + metadata header)

## Objective

Write a **complete, fresh, submission-ready reconstruction** of the main manuscript and its figure captions from the ground up, executing the narrative arc you recommended in your own `output/A1-assessment.md` (or a sharpened version of it).

Do **not** patch the existing manuscript paragraph by paragraph. Compose fresh, lucid, active, authoritative scientific prose for the target venue and audience—a paper a reader wants to finish rather than a defensive audit log.

## Hard bounds and shared clarifications

### Venue, length and format
- **Word budget:** Target `[e.g. 4,300–4,600]` words total (strict ceiling `[e.g. < 5,000]`), counting title, Abstract, Keywords, body, tables, declarations and figure captions, excluding the bibliography. Count words carefully and report both total and Abstract word counts in `output/A2-coverage.md`.
- **Abstract:** Target `[e.g. ≤ 230 words]` (strict ceiling `[e.g. 250 words]`).
- **Review mode:** `[e.g. double-anonymised; omit author names, affiliations, funding and CRediT from A2-main.md and cite co-authors in the third person]`.
- **Figures:** Retain all existing graphic files unchanged (`[list paths]`). State whether figure reordering is permitted.
- **Citations and markup:**
  - Keep exact Pandoc citation keys (`[@key]`) verified against `[bibliography path]`; do not invent citations or keys.
  - Omit repository-specific inline claim-binding markup (such as `[value]{.C01}`) during drafting so prose flows cleanly; bindings are re-attached at final integration.
  - Retain required end-matter sections (`Data availability`, `Competing interests`, AI disclosure, `## References`).

### Scientific invariants and lifted style rules
- **Preserve all settled scientific content and substantive interpretation bounds** (`[claims ledger & interpretation contract paths]`).
- **Lifted style-policing rules (agreed after A1):** `[List any style/phrasing rules explicitly lifted—e.g. set scope per section rather than per sentence; drop verbatim required strings; condense superseded sensitivity histories to one honest sentence pointing to SI.]`
- **Shared factual clarifications (supplied identically to all three scientists):** `[List any factual precisions, label reconciliations, or verified comparators from primary CSVs.]`

## Your autonomy

Within the bounds above, you have complete freedom over section structure, headings, narrative sequence, figure order (if permitted), whether to add a compact Markdown summary table, and your internal drafting and verification workflow. Leave technical machinery already documented in the Supplementary Information in the supplement rather than repeating it in `main.md`.

## Required `output/A2-coverage.md` format

Start with a short header: source baseline, your actual model and harness, narrative arc chosen, figure order, Abstract word count, total word count (specifying counting method), and `Status: ready for review` (or `Status: blocked` with reason).

Follow with a compact scientific-unit table:
`| Source / Claim ID | Core content preserved | Destination in A2 (section / table / caption / SI ref) | Notes or open items |`

## Strictly out of bounds

- **Work independently.** Do not consult other scientists, peer workspaces, reports, branches or discussion threads.
- **Do not query any Correspondence Board** (via MCP or otherwise), inspect the parent scientific repository, read `git log`, rely on prior project memory, or read excluded renderings.
- **Do not edit source files** or run analyses. Write **only** to `output/A2-main.md`, `output/A2-figures.md`, and `output/A2-coverage.md`. Stop after saving all three files.
