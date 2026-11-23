# Projects

Each active or pilot project gets its own self-contained folder `projects/<slug>/`:

```text
projects/<slug>/
├── STATE.md       # Live status, settled decisions, output pointers, next action
├── brief.md       # Project-specific scope, target venue/deliverable, hard invariants
├── local.json     # (gitignored) Machine-specific paths and per-round artifact map
└── work/          # (gitignored) Curated single-commit baselines, manifests, rendered prompts
```

## Two ways to run a new project

1. **Inside this hub (best while the harness is actively evolving):** Create `projects/<slug>/` with `STATE.md`, `brief.md`, and an ignored `local.json` copied from [local.example.json](../local.example.json). Multiple advisers (e.g. one for an Experiment A manuscript rescue and a parallel adviser for an Experiment B original investigation) can work concurrently in separate `projects/<slug>/` folders without merge conflicts.
2. **As a standalone repository (best for collaborator-specific or self-contained projects):** Click **Use this template** on GitHub (`BWBrook/research-advisor`) or clone this repo for a single project, then work in `projects/<slug>/`.

## Public vs. local files

- `projects/*/local.json` and `projects/*/work/` are gitignored so absolute local paths, staging baselines and temporary prompts stay off GitHub.
- Track `STATE.md` and `brief.md` when working in the open (as in our worked proof-of-concept [`rc-dates`](rc-dates/)). If a future project is embargoed or private, add `projects/<slug>/` to `.git/info/exclude` locally or run it in a private clone.
