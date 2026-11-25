# Independent Game Conception & Rebase — `[Project]` (Track D, Round D1)

## Inputs supplied by the Producer

- Founder's North Star, creative vision, motivation, and scope questions: `INPUT.md` (read in full first)
- Curated single-commit baseline repository: this isolated, remote-free workspace at `[baseline commit]` *(or bare tabula-rasa workspace for D-Greenfield)*
- Shared read-only references / source texts / asset pool: `[resources/ path, or none]`
- Save your conception brief directly to: `output/D1-conception.md`

## Assignment

Act as an independent **Senior Game Developer** inspecting this project against the Founder's North Star. Your job is to propose the strongest, cleanest, most genuinely playable game architecture and milestone plan this project can support—**not** to rubber-stamp inherited dependencies, UI layouts, or legacy roadmaps. Challenge existing engine choices, libraries, content contracts, presentation, and scope wherever direct inspection warrants.

Address:

1. **Frank diagnostic vs. the North Star:** *(For D-Rebase)* What in the inherited codebase is genuinely strong and worth keeping vs. what is dead weight, misfit for the player fantasy, or structurally blocking the vision? *(For D-Greenfield)* What are the core mechanical, architectural, and player-experience challenges hidden inside the concept?
2. **2–3 genuinely distinct design & architecture directions (and one recommendation):** Lay out concrete strategic options—not cosmetic variants—specifying what you would keep, cut, simplify, or rebuild (rendering/UI stack, core simulation/parser/systems, engine-vs-content contract, and playable proof scope), and recommend the strongest path.
3. **Engine / content contract & extensibility:** How should engine code stay cleanly decoupled from authored game content (stories, levels, rules, art, audio) so new content drops in cleanly without hacking internals?
4. **Minimum shippable playable milestone vs. stretch goals:** Define the tightest complete, genuinely enjoyable browser-playable release worth putting in front of players, cleanly separated from optional stretch goals that must not delay shipping.
5. **Art, presentation & verification/playability gates:** How should visual presentation and missing art be handled cleanly across a shared asset pool + deterministic/procedural fallbacks? What automated tests, contract checks, bundle/runtime budgets, visual checks, and blind playtest criteria prove the game is rock-solid and fun?

Be explicit about what is verified directly from the workspace and `resources/`, what is assumed, and what risks could break playability or scope.

## Preliminary checks and boundaries

- **Read-only inspection:** You may inspect every file in this workspace and under `resources/`, and run tightly bounded primary-source checks if needed. Cite only files and sources you actually inspect.
- **No coding, installs, or edits:** Do **not** edit repository files, install dependencies (`npm install`/`npm ci`), run builds/tests, generate assets, or make Git commits during D1.
- **Strict isolation:** Work completely independently. Do **not** query or post to any Correspondence Board (MCP or otherwise), read peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect the adviser repository (`research-advisor`), read unrelated local repositories, rely on cross-workspace memory or prior chats about this game, or add Git remotes / push.

## Output and stopping contract

Write the complete brief (~1,200–1,800 words) directly to **`output/D1-conception.md`** (touch no other files). Start with:

- `Common input:` `[curated baseline commit / INPUT.md identifier]`
- `Model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `Resources inspected:` `[brief list of workspace / resources files actually read]`
- `Status:` `ready for review` (or `blocked: <precise reason>`)

Stop after saving `output/D1-conception.md` and give only a brief confirmation. The Producer and Founder will compare all three independent conceptions before locking the D2 Pillar Charter.
