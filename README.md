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

## Two reusable workflows

| Workflow | Starting point | What we are trying to finish | Playbook |
|---|---|---|---|
| **A: Manuscript rescue** | Completed science, data, modelling and an initial manuscript that has grown dense or defensive. | A freshly conceived, readable manuscript that preserves all substantive scientific content. | [workflows/A-manuscript-rescue.md](workflows/A-manuscript-rescue.md) |
| **B: Original research** | An undeveloped scientific idea. | A defensible investigation from independent conception through execution, evidence-led adjudication and fresh communication. | [workflows/B-original-research.md](workflows/B-original-research.md) |

## Repository layout

- [AGENTS.md](AGENTS.md) (`CLAUDE.md`, `GEMINI.md`): adviser role, delegation boundary and isolation rules.
- [docs/operating-notes.md](docs/operating-notes.md): practical mechanics—curated clone isolation, desktop-first launch workflow, CLI fallbacks, and evidence comparison.
- [workflows/](workflows/): project-agnostic playbooks (`A-manuscript-rescue.md`, `B-original-research.md`).
- [prompts/](prompts/): reusable opening assignment templates (`adviser-start.md`, `A1-editorial-reconnaissance.md`, `B1-project-conception.md`). Later prompts are written adaptively from actual outputs.
- [scripts/build-isolated-clones.sh](scripts/build-isolated-clones.sh): manifest-driven builder for single-commit, remote-free scientist clones (including PNG previews for PDF figures).
- [projects/](projects/): self-contained per-project folders (`STATE.md`, `brief.md`, plus gitignored `local.json` and `work/`). See [`projects/rc-dates/`](projects/rc-dates/) for our live Workflow A proof-of-concept.
- [context/](context/): origin rationale ([briefing.md](context/briefing.md)) and discussion archive ([conversation.md](context/conversation.md)).

## Getting started on a new project

1. **In this hub (or via GitHub's *Use this template* button):** create `projects/<slug>/` with `brief.md`, `STATE.md`, and an ignored `local.json` copied from [local.example.json](local.example.json). See [projects/README.md](projects/README.md).
2. **Start your continuing adviser session** in this directory and say:
   > Read `AGENTS.md`, `docs/operating-notes.md`, the relevant workflow under `workflows/`, and `prompts/adviser-start.md`, then begin as my continuing adviser for `projects/<slug>`.
3. Multiple advisers (for example, one on a Workflow A manuscript rescue and another on a parallel Workflow B investigation) can work concurrently in separate `projects/<slug>/` folders without colliding.

## How this work is done

Initiated by Barry W. Brook after an exploratory design session with OpenAI ChatGPT Pro (preserved in [context/conversation.md](context/conversation.md)). The local harness architecture, curated-isolation tooling, delegation boundaries and Workflow A pilot supervision were developed with Google Gemini 4 Neon (Antigravity). Pilot scientist sessions run independently across OpenAI Codex (`gpt-6.2-astra`), Anthropic Claude (`fable` / Fable 5.2) and Google Gemini (`gemini-4-carbon-high`).

## Citation

See [CITATION.cff](CITATION.cff).

## Licence

Code is released under the [MIT Licence](LICENSE). Text, figures and documentation created for this project are released under [CC BY-SA 4.0](LICENSE-CONTENT). Third-party material keeps its own terms where stated.
