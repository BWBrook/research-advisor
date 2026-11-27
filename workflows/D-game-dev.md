# Track D: Open-source game development (Rebase & Greenfield)

**Use when:** Developing or rebasing a small-to-medium open-source game using independent frontier-model developers—either **D-Rebase** (picking up a half-finished prototype or stalled repo with prior agent baggage, analogous to Track B) or **D-Greenfield** (building a fresh game concept from a bare workspace, analogous to Track C).

**Roles:**
- **Founder / Vision Lead** (human): sets the player fantasy, creative taste, and final calls—and plays the Stage 2 builds directly (5–10 minutes each) as an active-learning "human oracle".
- **Producer & Technical Lead** (continuing adviser, this repo): maintains scope, enforces isolation, verifies builds/visuals/playability, adjudicates on concrete evidence, and coordinates convergence.
- **Three Independent Senior Game Developers** (Codex, Claude, Gemini): work in isolated, remote-free clones (`~/{codex,claude,gemini}/<slug>`) with identical briefs and zero peer visibility.

**Why this model fits games:** Just like empirical science (`docs/operating-notes.md` §0), games lack a scalar automated verifier (passing tests and smooth frame rates do not prove a game is atmospheric, fair, responsive, or fun) and **human play is the real target environment**. Cross-family independence produces genuinely distinct architectural, UX, and creative takes rather than one committee compromise.

## Four game-dev adaptations over Track B/C

1. **Creative & Technical Pillar Charter (not scientific pre-registration):** Pair hard engineering invariants (e.g. offline/deterministic runtime, zero runtime AI, clean engine/content separation, save/load safety, zero console errors, no softlocks) with player-experience pillars (tone, pacing, presentation, interaction generosity) and a strict scope fence.
2. **Playability and visual inspection as co-equal gates:** Automated tests and golden paths are the floor, not the ceiling. Before adjudication, the Producer runs each frozen build, captures multi-viewport screenshots, audits bundle/runtime hygiene, and gives the Founder one-command local launch URLs for brief hands-on playtesting.
3. **Fresh-session blind playtest + code/contract audit (D3):** Brand-new reviewer sessions first play each peer build *blind* (without reading walkthroughs or golden paths) to catch parser/control friction, unclear affordances, dead-ends, and UI bugs—then audit code architecture, saves, softlocks, and portability.
4. **Decoupled shared art pool:** Frontier-model harnesses do not have uniform image-generation tools inside isolated sandboxes. Keep ad hoc image generation out of isolated D2 builds so tool asymmetry does not distort comparison: place existing art, public-domain period art, or shared pre-generated assets read-only under `resources/` (hardlinked via `--resources-dir`), allow crisp deterministic/vector/procedural fallbacks where assets are absent, and run any dedicated art-production pass on the winning backbone (or as an explicit shared resource drop before D2).

## Stage 1 — Curated baseline & independent game conception (D1)

1. The Founder supplies the North Star (the player fantasy and feel), any reference inspirations or source texts, known pain points, and scope bounds.
2. Build single-commit, remote-free clones using `scripts/build-isolated-clones.sh --workflow D`:
   - **D-Rebase:** pass `--source-repo` and `--manifest` keeping active code, tests, core design docs, and existing assets while stripping `git log`, `origin`, `HANDOVER.md`, stale check/build dumps, and legacy agent roadmaps so developers judge the game on its merits.
   - **D-Greenfield:** omit `--source-repo`/`--manifest` to start from a bare workspace with `INPUT.md`.
   - Pass `--resources-dir ~/shared/<slug>` to attach shared read-only reference texts, public-domain books, or shared art pools under gitignored `resources/`.
3. Issue [D1-game-conception.md](../prompts/D1-game-conception.md) independently to all three developers (`output/ASSIGNMENT-D1.md`).
4. Ask for a frank critique against the North Star (what works vs. dead weight), 2–3 genuinely distinct architectural/creative directions with one recommendation, engine/content contract design, minimum playable milestone vs. stretch goals, art/presentation strategy, and playability/verification gates. No coding, installs, or edits during D1.

## After D1 — Creative & Technical Pillar Charter + 1-minute gut-check

Compare all three independent conceptions before shared deliberation, noting where families diverge on architecture, simulation depth, UX/presentation, and content scope. Then draft a compact `CHARTER.md` specifying outcomes and invariants (leaving internal code structure unconstrained):

- **Player fantasy & creative pillars:** what the game must *feel* like in the player's hands.
- **Engine / content contract & proof points:** what must stay cleanly separated and what concrete playable content proves it.
- **Hard technical invariants:** determinism, offline execution, zero runtime LLM (where required), save/load integrity, zero console errors, no unwinnable states, bundle/performance ceilings.
- **Art & asset policy:** exact shared assets from `resources/` vs. deterministic/procedural fallback expectations.
- **Explicit scope fence:** features intentionally excluded from this milestone.
- **Verification & playability gates:** automated tests, contract/portability checks, golden paths, visual viewport checks, and blind playtest criteria.

Give the Founder a **1-minute plain-English gut-check** (*"what the developers are keeping, ripping out, building, and proving"*) before launching D2.

## Stage 2 — Independent autonomous execution (D2)

- Run a quick **host-runtime pre-flight** (Node/toolchain versions, Playwright/browser availability, package-install behaviour) and record verified host facts in `output/ASSIGNMENT-D2.md` ([D2-game-execution.md](../prompts/D2-game-execution.md)) beside frozen gitignored `output/CHARTER.md`.
- Each developer builds its runnable candidate independently on local `main`, satisfies all automated tests/build/contract checks, leaves `git status` clean, and writes `output/D2-report.md` (with exact launch command, verification results, architectural choices, and known trade-offs).

## Stage 3 — Producer verification, Founder playtest & fresh-session blind audit (D3)

1. **Producer verification first:** From frozen `git archive HEAD` snapshots (or read-only frozen exports), run typechecks, unit/contract/E2E tests, production builds + bundle-size checks, and capture Playwright screenshots across desktop and narrow viewports. Write a concise `VERIFIED-METRICS.md`.
2. **Founder active-learning playtest (5–10 min per candidate):** Provide clean one-command local launch instructions (or side-by-side preview ports) so the Founder plays each candidate directly and records high-signal impressions (feel, atmosphere, parser/control responsiveness, readability, delight vs. friction).
3. **Fresh-session read-only D3 blind playtest & code audit:** Stage a frozen `output/d3-packet/` containing all three candidate builds plus `VERIFIED-METRICS.md`, and launch **brand-new chat threads** with [D3-playtest-and-audit.md](../prompts/D3-playtest-and-audit.md). Each reviewer plays peer builds *blind* first (logging exact inputs/stumbles) and then audits architecture, contract boundaries, save/load, softlocks, and portability.
4. **Evidence-led adjudication:** Combine automated checks, Founder playtest signal, and independently reproduced D3 findings. Pick **one clean backbone** and list specific verified fixes/features to harvest—never frankenstein three engines together.

## Stage 4–5 — Hardening, art/polish pass, diff audit & release (D4–D5)

- **D4 hardening sprint:** Export the chosen backbone to a fresh remote-free integration clone (`~/codex/<slug>-integration` or equivalent) to fix verified blockers, harvest targeted peer wins, and integrate any dedicated room-art or prose-polish pass cleanly.
- **Optional post-hardening distillation (only if warranted):** If multi-round iteration left dead scaffolding, redundant state plumbing, or bloated modules, run one bounded [distillation pass](../prompts/distillation.md) gated against the locked test suite, golden paths, and playfeel before D5 (`docs/operating-notes.md` §0).
- **D5 brief diff audit:** Have the winning-backbone family run a short read-only `GO / FIX-FIRST` audit over the final diff plus a quick live playcheck.
- **Land, release & archive:** Merge cleanly onto the upstream repository (e.g., history-preserving PR, green CI, optional GitHub Pages playable demo), update `projects/<slug>/STATE.md` with a short retrospective, and pack temporary clones into one compact `.zip` via `scripts/archive-pilot-clones.sh --delete-sources`.
