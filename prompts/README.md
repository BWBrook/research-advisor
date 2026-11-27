# Prompts

Only the opening assignments are kept as templates. The workflow is adaptive: read real outputs with the lead scientist, then write the next substantial instruction from what was learned.

| Prompt | Recipient | When to use |
|---|---|---|
| [adviser-start.md](adviser-start.md) | Continuing local adviser | First launch or a fresh adviser session for `projects/<slug>/`. |
| [A1-editorial-reconnaissance.md](A1-editorial-reconnaissance.md) | Each of the three independent scientists | Track A Stage 1, after building the curated baseline and `INPUT.md`. |
| [A2-fresh-draft.md](A2-fresh-draft.md) | Each of the three independent scientists | Track A Stage 2, after comparing A1 conceptions and settling shared bounds/clarifications. |
| [A3-primary-writer.md](A3-primary-writer.md) | Fresh primary writer (`~/writer/<slug>`) | Track A Stage 3 (or Track B/C final communication, only if triggered), after auditing scientist drafts into read-only `grist/`. |
| [B1-project-rebase.md](B1-project-rebase.md) | Each of the three independent scientists | Track B Stage 1, after curating a partially built repository into remote-free single-commit clones. |
| [C1-tabula-rasa-conception.md](C1-tabula-rasa-conception.md) | Each of the three independent scientists | Track C Stage 1, from bare (or nearly bare) tabula-rasa workspaces with `INPUT.md` and optional `resources/`. |
| [BC2-execution.md](BC2-execution.md) | Each of the three independent scientists | Track B or C Stage 2, after agreeing the compact charter (`output/CHARTER.md`) and plain-English gut-check. |
| [BC3-cross-critique.md](BC3-cross-critique.md) | Three **fresh** scientist sessions | Track B or C Stage 3, read-only adversarial audit over frozen `output/[b3|c3]-packet/` and adviser-verified metrics. |
| [D1-game-conception.md](D1-game-conception.md) | Each of the three senior game developers | Track D Stage 1 (rebase or greenfield), independent diagnosis, architecture and creative conception. |
| [D2-game-execution.md](D2-game-execution.md) | Each of the three senior game developers | Track D Stage 2, autonomous build against the frozen Pillar Charter (`output/CHARTER.md`). |
| [D3-playtest-and-audit.md](D3-playtest-and-audit.md) | Three **fresh** developer sessions | Track D Stage 3, read-only blind exploratory playtest + adversarial code/contract audit over frozen `output/d3-packet/`. |
| [distillation.md](distillation.md) | One builder + short legibility audit (or parallel trio for Track C theory/models) | Optional post-validation distillation pass on Tracks B, C or D against a locked verified oracle (`docs/operating-notes.md` §0). |

Render one launch copy per scientist under gitignored `projects/<slug>/work/` and copy each scientist's own prompt into its isolated workspace at `output/ASSIGNMENT-<round>.md` for clean desktop-app or CLI launch. Keep substantive wording and inputs identical across all three; only workspace and output paths differ.

Never give scientists this entire adviser repository as their starting context—its archive and comparisons could anchor them or expose peer candidates.

The two original prompts from the initial design discussion are preserved verbatim in [the conversation appendix](../context/conversation.md#appendix-the-original-two-reconnaissance-prompts).
