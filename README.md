# research-advisor

> **Status:** developed in the open as a working record. This is work in progress: contents may change, and nothing here is peer-reviewed unless stated.

A lightweight harness for completing scientific research and manuscript reconstruction using **three independent frontier AI model families** (OpenAI Codex, Anthropic Claude, Google Gemini) coordinated by a **separate continuing adviser**—designed to preserve the human scientist's intellectual ownership while avoiding incremental agent ping-pong and process bureaucracy.

## Core model

```text
   Lead scientist  ◄──►  Continuing adviser (this repo)
                                │
             ┌──────────────────┼──────────────────┐
             ▼                  ▼                  ▼
      Codex scientist    Claude scientist   Gemini scientist
      (isolated clone)   (isolated clone)   (isolated clone)
```

- **Specify outcomes and epistemic invariants, not internal process** ([docs/operating-notes.md](docs/operating-notes.md) §0): apply the Bitter Lesson to delegation while respecting where empirical science diverges from software engineering (no scalar automated verifier → Goodhart risk; mechanisms cannot stay in a black box).
- **Independent conceptions → independent substantial execution → independent written critiques → evidence-led adjudication → fresh communication.**
- **Strict context isolation:** each scientist works in a curated, single-commit, remote-free clone with no shared discussion board, no peer visibility, and no stale review/commit history.
- **Keep it small:** plain Markdown, Git and existing desktop/CLI agent harnesses—no orchestration daemon, message bus or framework bloat.

## Four reusable tracks

| Track | Starting point | What we are trying to finish | Playbook |
|---|---|---|---|
| **A: Manuscript rescue** | Completed science (~90% done), frozen evidence and a manuscript that has grown dense or defensive. | A freshly conceived, readable manuscript that preserves all substantive scientific content. | [workflows/A-manuscript-rescue.md](workflows/A-manuscript-rescue.md) |
| **B: Project rebase & completion** | A partially developed, stalled or sprawling repository (existing code, models, tests or notebooks, often with prior agent baggage). | A critically rebased, independently verified scientific tool, model or analysis—plus an optional manuscript only if triggered by the lead scientist. | [workflows/B-project-rebase.md](workflows/B-project-rebase.md) |
| **C: Tabula-rasa research** | A bare (or nearly bare) repository: a fresh idea, North Star and optional primary data (or public-data/theory/simulation remit), with zero prior code or AI ideation. | A defensible investigation, model or tool built from scratch—including an honest null, negative or stop decision if warranted. | [workflows/C-tabula-rasa.md](workflows/C-tabula-rasa.md) |
| **D: Open-source game dev** | A half-finished game prototype (D-Rebase) or bare game concept (D-Greenfield), with Founder vision and optional shared reference texts/assets. | A genuinely playable, independently playtested open-source game—using cross-family blind playtesting, visual checks and brief Founder play sessions as the oracle. | [workflows/D-game-dev.md](workflows/D-game-dev.md) |

## Repository layout

- [AGENTS.md](AGENTS.md) (`CLAUDE.md`, `GEMINI.md`): adviser role, delegation boundary and isolation rules.
- [docs/operating-notes.md](docs/operating-notes.md): practical mechanics—curated and tabula-rasa clone isolation, desktop-first launch workflow, CLI fallbacks, compute routing and evidence comparison.
- [workflows/](workflows/): project-agnostic playbooks (`A-manuscript-rescue.md`, `B-project-rebase.md`, `C-tabula-rasa.md`, `D-game-dev.md`).
- [prompts/](prompts/): reusable assignment templates (`adviser-start.md`, `A1–A3`, `B1-project-rebase.md`, `C1-tabula-rasa-conception.md`, `BC2-execution.md`, `BC3-cross-critique.md`, `D1–D3`). Adapt each stage to actual outputs rather than running a rigid script.
- [scripts/](scripts/): isolated clone builder ([build-isolated-clones.sh](scripts/build-isolated-clones.sh), supporting `--workflow A|B|C|D` and optional hardlinked/cloned read-only `--resources-dir`), primary-writer workspace stager ([stage-writer-workspace.sh](scripts/stage-writer-workspace.sh) for `~/writer/<slug>` with read-only `grist/`), and post-pilot compact archiver/cleaner ([archive-pilot-clones.sh](scripts/archive-pilot-clones.sh)).
- [projects/](projects/): self-contained per-project folders (`STATE.md`, `brief.md`, plus gitignored `local.json` and `work/`). See [`projects/rc-dates/`](projects/rc-dates/) (Track A pilot), [`projects/openpva/`](projects/openpva/) (Track B pilot), and [`projects/lantern/`](projects/lantern/) (Track D pilot).
- [context/](context/): origin rationale ([briefing.md](context/briefing.md)) and discussion archive ([conversation.md](context/conversation.md)).

## Getting started on a new project

1. **In this hub (or via GitHub's *Use this template* button):** create `projects/<slug>/` with `brief.md`, `STATE.md`, and an ignored `local.json` copied from [local.example.json](local.example.json). See [projects/README.md](projects/README.md).
2. **Start your continuing adviser session** in this directory and say:
   > Read `AGENTS.md`, `docs/operating-notes.md`, the relevant track playbook under `workflows/`, and `prompts/adviser-start.md`, then begin as my continuing adviser for `projects/<slug>`.
3. Multiple advisers (for example, one on a Track A manuscript rescue and another on a parallel Track B rebase or Track C tabula-rasa project) can work concurrently in separate `projects/<slug>/` folders without colliding.

## How this work is done

Initiated by Barry W. Brook after an exploratory design session with OpenAI ChatGPT Pro (preserved in [context/conversation.md](context/conversation.md)). The local harness architecture, curated-isolation tooling, delegation boundaries, three-track structure, and Track A/B pilot supervision were developed with Google Gemini 4 Neon (Antigravity). Pilot scientist sessions run independently across OpenAI Codex (`gpt-6.2-astra`), Anthropic Claude (`fable` / Fable 5.2) and Google Gemini (`gemini-4-carbon-high`).

## Citation

See [CITATION.cff](CITATION.cff).

## Licence

Code is released under the [MIT Licence](LICENSE). Text, figures and documentation created for this project are released under [CC BY-SA 4.0](LICENSE-CONTENT). Third-party material keeps its own terms where stated.
