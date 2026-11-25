# Local operating notes

Use these notes when preparing a stage or reading results. They are practical guidance for running independent multi-model projects, not a rigid orchestration protocol. Each active project tracks its live status in `projects/<slug>/STATE.md`.

## 0. Delegation boundary: outcomes over process (and where science diverges from software)

This harness applies Rich Sutton's *Bitter Lesson* to scientific delegation—avoiding the anthropomorphic "standing teammate org chart" where agents accumulate shared history and trade incremental turns—while respecting the two places where empirical science breaks the software-engineering analogy.

**Specify hard (the boundary and verifier):**
- The scientific question and minimum defensible contribution (explicitly including honest null, negative or infeasible results).
- Hard epistemic invariants: estimand definitions, scope bounds, protected validation or reproducibility checks, and what claims are unsupported.
- Audience, venue and delivery constraints (for communication rounds), plus strict context isolation from stale history and peer work.

**Leave unconstrained (how each scientist gets there):**
- Internal workflow, subagent decomposition, code architecture and abstractions (Tracks B & C), and narrative skeleton or phrasing templates (Track A).
- Intermediate micro-milestones. Judge finished, self-contained artifacts side by side rather than steering every step.
- Distinguish **scientific invariants** (keep rigid) from **codified taste or style policing** (lift when it degrades clarity or forces defensive prose—as observed with verbatim-phrase rules in the `rc-dates` pilot).

**Why science cannot become a pure software "black box + reward function":**
1. **No scalar automated verifier → Goodhart risk.** Software has tests, latency and uptime; science lacks an automated oracle for whether assumptions are realistic or a framing is honest. Unconstrained optimisation against proxy rewards ("cleanest narrative", "strongest effect", "passes a rubric") can smooth away uncertainty or drift the estimand. Cross-family independence (`gpt-6.2-astra`, `fable`, `gemini-4-carbon-high`) plus adversarial cross-critique and protected checks are our substitute for that missing verifier.
2. **Mechanisms cannot stay inside a black box.** A scientist must understand and own the causal chain, assumptions and failure modes behind any claim they stand behind. In scientific communication, human comprehension is not an obsolete legacy constraint—it *is* the real target environment, so the lead scientist's direct reading of finished outputs is genuine evaluation signal rather than micromanagement.

## 1. Locate the project and register local paths

Inspect the local filesystem through your normal tools—start from a path the user supplies or neighbouring project directories. Never ask the user to paste reports or file trees that you can read directly.

Each project keeps machine-specific absolute paths in a gitignored `projects/<slug>/local.json` copied from `local.example.json`. Record only paths actually observed on disk. Record stable source commits and portable project-relative references in `projects/<slug>/STATE.md`.

Before working in a scientific repository, read its own `AGENTS.md` / `CLAUDE.md` and `README.md`. An existing instruction to keep developing the science may conflict with Workflow A's writing-only brief—surface and resolve that conflict under the live user's direction rather than silently altering the scientific repo's instructions.

## 2. Establish a clean common baseline

Inspect the source repository before choosing a baseline commit:

```bash
git -C "$research_repo" status --short
git -C "$research_repo" rev-parse HEAD
git -C "$research_repo" worktree list
```

Record any relevant uncommitted or untracked files; never stash, reset, clean or commit unrelated work just to obtain a tidy baseline. The essential requirement is identical inputs for all three scientists.

For **Track A** (manuscript rescue), write a neutral `INPUT.md` listing allowed files, the baseline commit, audience/venue/length constraints, the recommended evidence-first reading order, a short inventory of what any excluded Supplement already covers, and explicit exclusions. Never preload one scientist's preferred narrative.

For **Track B** (project rebase & completion), build a curated single-commit snapshot of the partially developed repository preserving active code, tests, examples and design contracts while stripping `git log`, `origin`, stale build dumps and prior agent roadmaps/handovers so scientists are not anchored to earlier tactical plans.

For **Track C** (tabula-rasa research), start from a bare (or nearly bare) single-commit workspace containing only `INPUT.md` (the lead scientist's idea, North Star, motivation and constraints), minimal Track C isolation instructions, and optional hardlinked read-only primary data or reference PDFs under `resources/`—with zero prior code or AI ideation.

## 3. Separate adviser and scientist contexts (curated & tabula-rasa isolation)

The adviser runs from this repository. The three independent scientists (Codex, Claude, Gemini) run in their own isolated workspaces and receive only their assignment, common inputs and their own output destination. Never feed this adviser repository, its discussion archive, or another scientist's report into an independent round.

**Prefer single-commit, remote-free clones over raw worktrees across all three tracks:**

- A raw `git worktree` of an existing project exposes full `git log` history, prior AI review/rework memos (e.g. `manuscript/reviews/`, `HANDOVER.md`, stale roadmaps/check dumps), stale checklists, out-of-scope renderings, and the GitHub `origin` remote.
- Instead, build a clean single-commit baseline tailored to the track—allow-listed evidence + manuscript for Track A; allow-listed active source, tests, examples and contracts for Track B; bare `INPUT.md` (plus optional small starter files) for Track C—together with minimal track-scoped `AGENTS.md`/`CLAUDE.md`/`GEMINI.md`.
- Clone that baseline into separate per-family paths (`~/codex/<slug>`, `~/claude/<slug>`, `~/gemini/<slug>`) and **remove `origin`** during independent rounds (`git remote remove origin`).
  - Removing `origin` eliminates accidental pushes to GitHub, prevents any scientist from fetching or listing peer branches on a shared remote, and avoids SSH/sandbox friction.
  - If off-laptop backup or multi-machine sync is wanted, the **adviser** (or user) can mirror frozen round snapshots to an optional private bare remote *after* each round closes—never shared live among scientists during independent work.
- `scripts/build-isolated-clones.sh` (`--workflow A|B|C`) implements this baseline-and-clone step (manifest-driven for Tracks A & B; bare-workspace capable with optional `--resources-dir` for Track C).

**Shared read-only resources (reference PDFs, bulky frozen datasets or model outputs):**

- Keep small, project-owned inputs (figures, summary CSVs, bibliography, code) copied directly into the curated baseline commit.
- For **copyrighted third-party files** (full-text PDFs of cited papers) or **large frozen datasets/outputs** that should neither be committed to Git nor triplicated on disk, keep one master folder outside Git (e.g. `~/shared/<slug>/papers/` or `~/shared/<slug>/data/`), lock its *files* read-only (`find ~/shared/<slug> -type f -exec chmod a-w {} +`—keeping the master directory writable so you can add files later), and hardlink it into each clone's gitignored `resources/` folder:
  - Pass `--resources-dir ~/shared/<slug>` to `scripts/build-isolated-clones.sh`, or attach to existing clones with:
    `for f in codex claude gemini; do mkdir -p ~/$f/<slug>/resources && cp -al ~/shared/<slug>/. ~/$f/<slug>/resources/; done`
  - **Why hardlinks (`cp -al`) beat both symlinks and full copies:** (1) 1× disk usage on Linux/WSL ext4 (no triplication of GB-scale outputs or PDFs); (2) files sit inside each scientist's own workspace at `resources/`, avoiding desktop multi-root setup or `--add-dir` sandbox friction; (3) `cp -al` creates separate directory inodes per clone while sharing only read-only file inodes, so nothing written inside one clone's `resources/` can leak to peers or mutate shared files; (4) `/resources/` is gitignored, keeping third-party PDFs and large binaries out of Git. (On macOS APFS or across filesystems where GNU `cp -al` is unavailable, `cp -cR` or `build-isolated-clones.sh`'s copy fallback handles it automatically.)

**Dedicated primary-writer workspace (`~/writer/<slug>`):**

- When using a **fresh primary writer** to compose the final manuscript (in Track A after scientist drafts, or at the end of Track B or C only once the lead scientist explicitly triggers a manuscript), stage a dedicated, remote-free clone at `~/writer/<slug>` using `scripts/stage-writer-workspace.sh`.
- Keeping the writer separate from `~/{codex,claude,gemini}/<slug>` leaves all three scientist clones clean and intact for the **final scientific-fidelity audit** on the finished manuscript.
- Place frozen scientist drafts and the adviser's verified audit synthesis inside a gitignored, read-only (`chmod a-w`) `grist/` directory inside `~/writer/<slug>`, alongside the curated primary evidence and `output/ASSIGNMENT-WRITE.md`. This gives the fresh writer full visual and textual context in one desktop window with zero cross-workspace friction.

**Context and memory hygiene:**

- **Forbid any shared discussion or correspondence board** in every independent scientist prompt, and disable MCP servers at the CLI layer where supported (Section 4).
- **Avoid destructive memory pruning.** Using fresh directory paths (`~/claude/<slug>`, `~/codex/<slug>`, `~/gemini/<slug>`) prevents per-project auto-memory tied to the original repository path from loading automatically without deleting useful memory from the original project. Still instruct scientists to ignore any cross-workspace memory or prior chats about the study.
- Never overwrite preserved candidate outputs; use versioned filenames inside gitignored `output/` (`output/A1-assessment.md`, `output/A2-main.md`, etc.).

## 4. Prepare and launch a substantial assignment

Render one local launch copy per scientist under gitignored `projects/<slug>/work/`, filling exact paths and scientist identity, **and copy each scientist's own prompt into its workspace at `output/ASSIGNMENT-<round>.md`** (which is gitignored inside the clone). Keep substantive wording and inputs identical across all three.

**Track B & C pre-flight and compute-routing hygiene:**

- **Host-runtime pre-flight:** Before staging Stage 2 execution (`B2`/`C2`), spend 5 seconds checking the host toolchain (R/Python version, installed vs. absent packages, and any `.Rprofile`/`renv` or `.venv` autoloaders that would stall fresh clones) and record the verified facts in `output/ASSIGNMENT-[B2|C2].md`.
- **Keep `CHARTER.md` inside gitignored `output/`:** Placing `output/CHARTER.md` beside `output/ASSIGNMENT-[B2|C2].md` keeps `git status` empty and prevents top-level non-standard-file NOTEs during package builds (`R CMD check`).
- **Remote compute & detachable `tmux` routing:** Never anchor multi-hour Stage 2 simulations exclusively to a local laptop when remote servers, resizable cloud VMs or HPC queues are available. In gitignored `output/ASSIGNMENT-[B2|C2].md` (never in tracked public repo files), remind scientists to offload heavy parallel runs inside detachable `tmux` sessions under **isolated per-family remote directories and session names** (e.g., `<remote-scratch>/<slug>/{codex,claude,gemini}`) so peer isolation holds off-laptop too.

**Primary launch surface — Desktop apps (recommended for interactive monitoring):**

- Open each scientist's isolated clone in its own desktop app (Codex Desktop → `~/codex/<slug>`, Claude Code Desktop → `~/claude/<slug>`, Antigravity Desktop in a separate window/session → `~/gemini/<slug>`).
- Select the assigned model (e.g. `gpt-6.2-astra`, `Fable`, `Gemini 4 Carbon (High)`) and send one line:
  `Read output/ASSIGNMENT-A1.md and follow it. Save your assessment to output/A1-assessment.md.`
- Desktop sessions let you monitor progress, resolve genuine blockers, and keep a thread alive across rounds when useful, without fighting CLI OAuth expiry or headless permission flags.
- *Isolation caveat:* Desktop apps keep global MCP servers attached unless toggled off, so keeping scientists away from any discussion/correspondence board relies on the explicit ban in `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `INPUT.md` and the assignment prompt.

**Optional CLI launch surface (setup and headless batch runs):**

On Linux/WSL where `claude` and `codex` are nvm-managed and `agy` lives under `~/.local/bin`, ensure both are on `PATH` (or invoke by path):

- **Codex (`gpt-6.2-astra`):**
  `codex exec -m gpt-6.2-astra --ignore-user-config -s read-only -C ~/codex/<slug> -o ~/codex/<slug>/output/A1-assessment.md - < <prompt_file>`
  (`--ignore-user-config` skips `$CODEX_HOME/config.toml` and MCP servers while retaining auth; switch to `-s workspace-write` for writing/coding rounds.)
- **Claude (`fable`):**
  Run from `~/claude/<slug>`:
  `claude -p --model fable --effort high --strict-mcp-config --mcp-config '{"mcpServers":{}}' --allowedTools "Read,Glob,Grep" < <prompt_file> > ~/claude/<slug>/output/A1-assessment.md`
  (Use the public alias `fable`, not a version-suffixed string; refresh expired CLI auth with `claude auth login` or use Claude Desktop.)
- **Gemini (`gemini-4-carbon-high`):**
  Run from `~/gemini/<slug>`:
  `agy --model gemini-4-carbon-high --new-project --settings '{"permissions":{"allow":["read_file('"$HOME"'/gemini/<slug>)"]}}' -p "Read output/ASSIGNMENT-A1.md and follow it. Return your full assessment directly." > ~/gemini/<slug>/output/A1-assessment.md`
  (Verify the exact model slug with `agy models`. Because `-p` consumes the next token as the prompt string, always place `--model` and other flags *before* `-p`. Keep the Gemini scientist completely separate from a Gemini adviser session.)

Always re-verify CLI flags and model slugs with `--help` or `agy models` after harness updates. Running three sessions of one underlying model is not a cross-family experiment; any substitution must be explicit.

## 5. Read results directly (no message bus)

Register each workspace and per-round output path in `projects/<slug>/local.json`. Every scientist report should carry a short header naming the baseline, its actual model/harness if known, and `Status: ready for review` or `Status: blocked` with a concrete reason.

Read completed outputs directly from disk and verify that they answer the assigned stage—do not infer completion from a branch name or file existence alone. If one scientist asks a factual input question, resolve it from the record and supply any material input correction equally to all three scientists without relaying the first scientist's interpretation.

## 6. Compare, audit and decide

Keep submissions frozen before comparison or review. Never rely on a scientist's self-reported checks alone—for manuscript rounds (A2), run a fast apples-to-apples adviser audit across all three drafts and the baseline:
- **Word counts** on one identical Pandoc `--citeproc` plain-text whitespace pipeline (bibliography suppressed), checking both Abstract and total (body + tables + declarations + captions).
- **Citation-key resolution and diff** against the project bibliography and baseline—specifically flagging any dropped co-author or core methodological citations and any unverified keys.
- **Freshness check** (e.g. 8-word n-gram overlap against baseline body text) to confirm genuine fresh composition rather than light patching, plus a sweep for stray build markup or anonymity leaks.
- **Primary-evidence spot-checks** against source CSVs/tables whenever two drafts disagree on a number, qualifier, or denominator (in the `rc-dates` pilot, this caught a double-counted simulation row total and verified a missing all-date comparator directly from CSV).

**Skip redundant intermediate cross-critique when a direct adviser audit suffices.** If the drafts are heading into a fresh primary writer session (`~/writer/<slug>`), asking the three scientists to cross-critique each other's intermediate drafts burns attention on prose you are about to replace. Reserve the three scientists' critical pass for a **final scientific-fidelity audit** of the primary writer's unified manuscript. In Tracks B and C (project rebase or tabula-rasa research), by contrast, **fresh-session, read-only Stage 3 cross-critique** over a self-contained frozen `output/[b3|c3]-packet/` (with adviser-verified build, test/oracle, and uniform parent+worker process-tree RSS benchmarks) has exceptionally high ROI: starting brand-new chat threads eliminates compacted Stage 2 logs and defensive attachment, and independent model families routinely catch unique release-blocking bugs or methodological flaws the others miss.

**Default finishing toolchain for Workflow A manuscripts:**
- **De-AI prose check (`audit-ai-writing`):** Run the bundled `--genre scientific` scanner plus a manual cluster check on the primary writer's draft before the lead scientist reads—distinguishing genuine tells (em-dash clusters, repeated `X, not Y` / `rather than` antitheses, repeated `First/Second/Third` scaffolding, copulative avoidance) from domain terms of art.
- **Human line-edit loop (`scrivmark`):** Use `scrivmark` on a tracked branch (inside `~/writer/<slug>` or the target repo) for the lead scientist's inline edits and margin comments, letting the primary writer process and respond to each item cleanly.
- **Build and living-paper sync (`makedoc` + `living-paper`):** Once fidelity-audited and moved back to the scientific repository with ledger bindings restored, build PDF/DOCX outputs and verify checks with `makedoc`. In living-paper repos, reserve the fresh primary writer for human-facing products (`main.md`, `brief.md`) and assign the agent-facing index (`for-agents.md`), claims ledger sync and `supplement.md` alignment to the scientists.

Do not average incompatible scientific claims or patchwork-stitch favourite paragraphs across drafts (which recreates accretive prose). Pick one coherent structural spine, compose fresh in one voice, apply evidence-backed fidelity fixes, and move to collaborator review or release.

## 7. Keep the process light

Update `projects/<slug>/STATE.md` at meaningful transitions only. Keep completed manuscripts and heavy research artifacts in their project workspaces, never in this adviser repository. After finishing a pilot, add a short retrospective noting what improved the science or prose, what consumed attention, and what should change in the reusable playbooks or prompts.
