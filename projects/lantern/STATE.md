# Current state — Lantern (Track D pilot)

Updated: 25 November 2026, Australia/Hobart. **Active stage: D1 staged and ready for desktop launch across all three independent senior game developers.**

- **Track:** D — Open-source game development (D-Rebase pilot)
- **Founder / Vision Lead:** Barry W. Brook
- **Producer & Technical Lead:** Gemini 4 Neon (separate from the three independent developer sessions)
- **Source repository:** `BWBrook/lantern` (MIT code / CC BY-SA 4.0 content)
- **Common source baseline:** `lantern@1545181db73c0c51535fe9f5139f6c9b4ffd94ef` (`1545181`, clean `main`)
- **Curated single-commit baseline:** `c6ff88c7be1c0d6e4a2621a258e884563223dee2` (`c6ff88c`, 73 manifest files + Track D isolation docs + `INPUT.md`; remote-free clones at `~/{codex,claude,gemini}/lantern`)
- **Shared read-only resources (`resources/stone-age-1897/`):** Complete 5-instalment *Idler* (1897) text of H. G. Wells's *A Story of the Stone Age* (~23,140 words from Project Gutenberg Australia) + 15 original 1897 Cosmo Rowe (1877–1952) period illustrations (public domain in AU & US; modern PGA Bing covers excluded).

## Senior Game Developers (isolated remote-free clones)

| Family | Model | Workspace | D1 Status |
|---|---|---|---|
| **OpenAI (Codex)** | `gpt-6.2-astra` | `~/codex/lantern` | Staged (`output/ASSIGNMENT-D1.md`) |
| **Anthropic (Claude)** | `fable` (Fable 5.2) | `~/claude/lantern` | Staged (`output/ASSIGNMENT-D1.md`) |
| **Google (Gemini)** | `gemini-4-carbon-high` | `~/gemini/lantern` | Staged (`output/ASSIGNMENT-D1.md`) |

## Decision log

- **2026-11-25:** Initiated Track D (`workflows/D-game-dev.md`, `prompts/D1–D3`, `--workflow D` in `scripts/build-isolated-clones.sh`) to pilot multi-model independent development on open-source hobby game projects, starting with `lantern` (D-Rebase).
- **2026-11-25:** Locked Founder's North Star (*1987 Melbourne House C64 / INGLISH "magical scanner" browser engine*), two proof cartridges (*The Harrow Mine Job* + tractable playable slice of H. G. Wells's *A Story of the Stone Age* [1897], faithful to Wells's Victorian conception), decoupled art policy (keep 3 existing Harrow PNGs + shared `resources/` pool for *Stone Age*, no ad hoc image generation inside D2), and decision to skip Founder playtest of September `1545181` in favour of saving hands-on playtest energy for D2 candidates.

## Next action

Run D1 independently across Codex (`gpt-6.2-astra`), Claude (`fable`), and Gemini (`gemini-4-carbon-high`), then compare all three `output/D1-conception.md` briefs to draft the D2 Creative & Technical Pillar Charter and 1-minute gut-check.
