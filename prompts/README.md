# Prompts

Only the opening assignments are kept as templates. The workflow is adaptive: read real outputs with the lead scientist, then write the next substantial instruction from what was learned.

| Prompt | Recipient | When to use |
|---|---|---|
| [adviser-start.md](adviser-start.md) | Continuing local adviser | First launch or a fresh adviser session for `projects/<slug>/`. |
| [A1-editorial-reconnaissance.md](A1-editorial-reconnaissance.md) | Each of the three independent scientists | Workflow A (manuscript rescue), after building the curated baseline and `INPUT.md`. |
| [B1-project-conception.md](B1-project-conception.md) | Each of the three independent scientists | Workflow B (original research), after the lead scientist supplies an idea and constraints. |

Render one launch copy per scientist under gitignored `projects/<slug>/work/` and copy each scientist's own prompt into its isolated workspace at `output/ASSIGNMENT-<round>.md` for clean desktop-app or CLI launch. Keep substantive wording and inputs identical across all three; only workspace and output paths differ.

Never give scientists this entire adviser repository as their starting context—its archive and comparisons could anchor them or expose peer candidates.

The two original prompts from the initial design discussion are preserved verbatim in [the conversation appendix](../context/conversation.md#appendix-the-original-two-reconnaissance-prompts).
