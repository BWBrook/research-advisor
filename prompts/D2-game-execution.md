# Independent Autonomous Build — `[Project]` (Track D, Round D2)

## Inputs supplied by the Producer

- **Creative & Technical Pillar Charter:** `output/CHARTER.md` (read in full before writing code)
- **Baseline workspace:** Your isolated, remote-free clone at `[baseline commit]` (clean on `main`; read-only shared texts/assets in `resources/` if present)
- **Primary deliverables:**
  1. Runnable, verified browser build committed cleanly on local `main`
  2. Passing automated test suite (unit, contract/portability, golden-path/integration, and E2E where specified)
  3. Concise Technical & Playability Report saved directly to **`output/D2-report.md`** (~1,200–2,000 words)

## Assignment

Execute **Stage 2** of `output/CHARTER.md` autonomously inside this isolated workspace. You have full freedom over internal code architecture, rendering stack, data structures, UI styling, and decomposition—provided you honour every **creative pillar, engine/content boundary, art/asset policy, scope fence, and verification gate** in `output/CHARTER.md`.

### Required build sequence

1. **Pre-flight & baseline check:** Verify the local toolchain and confirm baseline tests/build before refactoring (or verify initial scaffolding for D-Greenfield).
2. **Design for playability, not just green tests:** Treat automated tests and golden paths as the floor. Exercise your own build interactively (headless or via browser/Playwright) with natural, off-path inputs and inspect rendered views at both desktop and compact viewports so layout, readability, pacing, and feedback genuinely feel right.
3. **Pass all hard gates:** Satisfy typecheck, unit/contract tests, production build + bundle-size hygiene, zero console/runtime errors, save/load round-trips, and clean `git status` (no untracked build clutter).
4. **Commit and report:** Commit cleanly on local `main` and write `output/D2-report.md` with exact launch commands, verified test/build metrics, key architectural/design choices, and honest limitations or rough edges.

## Runtime environment

- **Local host (verified by Producer):** `[OS, CPU/RAM, Node/npm/toolchain versions, Playwright/browser status, local-only execution note]`

## Strict boundaries

- **Respect the art/asset policy:** Follow `output/CHARTER.md` strictly on shared assets (`resources/`) vs. deterministic/procedural fallbacks. Do not introduce copyrighted third-party media or runtime network/AI dependencies.
- **Strict isolation:** Work completely independently. Do **not** query or post to any Correspondence Board (MCP or otherwise), read peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect the adviser repository (`research-advisor`), read unrelated local repositories, or rely on cross-workspace memory/prior chats on this project.
- **Git hygiene:** Commit cleanly on local `main` (leave `git status` clean except gitignored `output/`, `resources/`, `node_modules/`, `dist/`). Do **not** add Git remotes, push anywhere, or overwrite prior round outputs (`output/D1-*`).

## Output header and stopping contract

Start **`output/D2-report.md`** with:

- `Common charter:` `[project charter identifier & date]`
- `Final local commit:` `<short SHA on main>`
- `Model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `Launch command:` `[exact single command to boot locally for playtesting]`
- `Verification gates:` `[typecheck, unit/contract/E2E test counts, production build & bundle size]`
- `Status:` `ready for review` (or `blocked: <precise reason>`)

Stop after committing on local `main` and saving `output/D2-report.md`, and give only a brief chat confirmation.
