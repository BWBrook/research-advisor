# Independent Autonomous Execution — `[Project]` (Track `[B|C]`, Round `[B2|C2]`)

## Inputs supplied by the adviser

- **Common Charter:** `output/CHARTER.md` (read in full before writing code or running analyses)
- **Baseline workspace:** Your isolated, remote-free clone at `[baseline commit]` (clean on `main`; read-only shared data/PDFs in `resources/` if present)
- **Primary deliverables:**
  1. Verified code/package/analysis implementation committed cleanly on local `main`
  2. Pre-registered study/benchmark design (where applicable) + reproducible scripts and compact machine-readable tables/figures under `output/`
  3. Concise Technical & Scientific Report saved directly to **`output/[B2|C2]-report.md`** (~1,500–2,500 words)

## Assignment

Execute **Stage 2** of `output/CHARTER.md` autonomously inside this isolated workspace. You have full freedom over internal software architecture, data structures, refactoring/implementation strategy and workflow decomposition—provided you satisfy every **core identity commitment, unified-engine invariant (where applicable), verification oracle, performance/memory gate, and epistemic standard** in `output/CHARTER.md`.

### Required epistemic sequence

1. **Baseline or pre-flight check first:**
   - *Track B (rebase):* Measure and record the unmodified baseline's runtime, memory and test state before refactoring.
   - *Track C (tabula-rasa):* Verify input data schemas/integrity and build your analytical/synthetic verification oracles before production runs.
2. **Lock design before production runs:** Commit your pre-registered factor matrix, hypotheses/estimands, provenance, precision targets and falsification checks on local `main` *before* executing heavy runs.
3. **Build, verify and pass all hard gates:** Satisfy all correctness oracles, package/build checks and scaling/memory gates cleanly (measuring full parent + worker process-tree memory, not parent-only RSS).
4. **Commit and report:** Commit cleanly on local `main`, save compact evidence under `output/`, and write `output/[B2|C2]-report.md` linking every quantitative claim to its reproducing script and output path.

## Runtime environment and compute routing

- **Local host (verified by adviser):** `[OS, cores, RAM cap, R/Python version, pre-installed vs. absent libraries, any renv/.venv autoloader note]`
- **Remote compute & detachable execution:** `[Optional: authorised remote Linux server / resized cloud VM / HPC queue, with THIS scientist's isolated remote scratch path and tmux session name so long parallel runs survive laptop sleep without breaking cross-scientist isolation—keep hostnames strictly in gitignored local copies, never in tracked public files]`

## Strict boundaries

- **Not paper-shaped unless explicitly commissioned:** Do **not** draft a journal manuscript, lay brief or submission prose here unless `output/CHARTER.md` explicitly requests it. Deliver verified software/analyses, reproducible outputs and a concise technical report ready for frozen Stage 3 cross-critique.
- **Strict isolation:** Work completely independently. Do **not** query or post to any Correspondence Board (MCP or otherwise), read peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect `~/work/research-advisor`, read unrelated local repos, or rely on cross-workspace memory/prior chats on this topic.
- **Git hygiene:** Commit cleanly on local `main` (leave `git status` clean except gitignored `output/` and `resources/`). Do **not** add Git remotes, push anywhere, or overwrite prior round outputs (`output/[B1|C1]-*`).
- **Honesty:** Never invent published parameters or observations; cite only inspected sources; report null, negative, or infeasible findings and any deviations transparently.

## Output header and stopping contract

Start **`output/[B2|C2]-report.md`** with:

- `Common charter:` `[project charter identifier & date]`
- `Final local commit:` `<short SHA on main>`
- `Model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `Verification gates:` `[runtime version, test/build/oracle summary, scaling wall time & summed tree RSS]`
- `Status:` `ready for review` (or `blocked: <precise reason>`)

Stop after committing on local `main` and saving `output/[B2|C2]-report.md`, and give only a brief chat confirmation.
