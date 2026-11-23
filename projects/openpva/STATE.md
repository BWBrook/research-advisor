# Current state — OpenPVA (Workflow B)

Updated: 23 November 2026, Australia/Hobart. **Curated B1 baseline built; isolated workspaces and B1 assignments staged for independent conception.**

- **Workflow:** B — Original research / scientific-software completion from a partially developed repository
- **Adviser:** Gemini 4 Neon (separate from the three independent scientists)
- **Source repository:** `BWBrook/OpenPVA` (public GitHub, MIT license)
- **Common source baseline:** commit `89b34eeaae608a39b9c040fe8e9f7af217d9ab47` (`89b34ee`, 19 Nov 2026)
- **Curated single-commit baseline:** commit `ed0178c1027e20013259c926eab93cbd1dbf48a7` (115 active package/test/example/doc files + `INPUT.md`, `.gitignore`, isolated `AGENTS.md`/`CLAUDE.md`/`GEMINI.md`; stripped `git log`, `origin`, 7.8 MB pre-realignment `artefacts/`, `HANDOVER.md`, `docs/plan.md`, `docs/roadmap.md`, `docs/goals/`, `docs/log/`, `docs/decisions.md`, `docs/interpretation_notes.md`, upstream `AGENTS.md`)

## Scientists (primary surface: desktop apps)

| Family | Model | Workspace | Round B1 status | Output path |
|---|---|---|---|---|
| OpenAI (Codex Desktop) | `gpt-6.2-astra` | `~/codex/openpva` | Staged — ready to launch | `~/codex/openpva/output/B1-conception.md` |
| Anthropic (Claude Code Desktop) | `Fable` (`fable`) | `~/claude/openpva` | Staged — ready to launch | `~/claude/openpva/output/B1-conception.md` |
| Google (Antigravity Desktop, separate window) | `Gemini 4 Carbon (High)` (`gemini-4-carbon-high`) | `~/gemini/openpva` | Staged — ready to launch | `~/gemini/openpva/output/B1-conception.md` |

## Settled decisions (23 Nov 2026)

- **Target completion:** Open to independent B1 proposals, provided the finished project delivers a concrete public release and scientific communication path (e.g., R package + methods/living paper or benchmark study).
- **Core identity vs. challenge freedom:** Preserve the GAPPS-style composable ordinary-R process philosophy as core identity; allow scientists to challenge real implementation bottlenecks, API ergonomics, missing PVA essentials, or R version/packaging barriers, and to propose pivots or stopping if justified.
- **Isolation & boundaries:** Remote-free single-commit clones (`origin` removed); explicit Correspondence Board, peer-workspace, adviser-repo, and cross-workspace memory prohibitions in `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `INPUT.md`, and `output/ASSIGNMENT-B1.md`. B1 is strictly read-only code inspection + tightly bounded novelty/ecosystem checks (no code edits, `renv` restores, or simulations).
- **Public tracking:** `projects/openpva/{STATE,brief}.md` tracked publicly in `BWBrook/research-advisor`; machine paths (`local.json`) and staging/rendered prompts (`work/`) stay gitignored.

## Verified on disk

- Upstream `BWBrook/OpenPVA@89b34ee` cloned to ignored `projects/openpva/work/upstream/`.
- Curated single-commit baseline `ed0178c` verified (120 tracked files, zero excluded agent-history or `artefacts/` files).
- Three remote-free clones created at `~/codex/openpva`, `~/claude/openpva`, and `~/gemini/openpva`, each with identical `output/ASSIGNMENT-B1.md`.

## Next action

Launch Round B1 independently in each scientist's desktop app (Codex Desktop, Claude Code Desktop, Antigravity Desktop in a separate window). Once all three `output/B1-conception.md` files exist on disk, read and compare them side by side with Barry to establish a compact scientific charter before commissioning B2.
