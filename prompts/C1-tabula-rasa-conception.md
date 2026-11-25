# Independent Tabula-Rasa Problem Framing & Conception — `[Project]` (Track C, Round C1)

## Inputs supplied by the adviser

- Lead scientist's idea, North Star, motivation and constraints: `INPUT.md` (read in full first)
- Supplied primary data or read-only references, if any: `[resources/ path, or none — public data / theory / simulation]`
- Save your conception brief directly to: `output/C1-conception.md`

## Assignment

Starting from a blank slate (no prior code or AI ideation), develop this idea independently into the strongest worthwhile, feasible and scientifically defensible research investigation, model, benchmark or tool it can support. Treat the initial idea as a starting hypothesis—not a conclusion to confirm. Challenge the framing, novelty, identifiability and feasibility wherever evidence warrants.

Address:

1. **Promising research questions & novelty:** What exact scientific question, estimand, model or methodological contribution is most worthwhile here, and why does it matter relative to existing literature or tools? (State clearly if the premise duplicates prior work or needs sharp reframing.)
2. **2–3 distinct conceptions (and one recommendation):** Lay out genuinely distinct ways to formulate and tackle this project—not minor parameter variants—and recommend the strongest path, **or recommend against proceeding** if the premise fails basic novelty, data or feasibility checks.
3. **Minimum defensible contribution vs. stretch goals:** Define the smallest completed, defensible outcome worth delivering to its audience (defaulting to *not* paper-shaped—e.g., verified analysis, simulation study, benchmark or reusable tool—unless `INPUT.md` explicitly requests a manuscript), separated from optional stretch goals.
4. **Data, methods & from-scratch verification oracles:** What primary/public data, simulation design, analytical or synthetic oracles, held-out validation splits, or falsifiable checks are required so an independent critic would trust the findings?
5. **Failure modes & honest null/stop criteria:** What conceptual traps, confounding/identifiability issues, licensing/governance constraints, or compute bottlenecks could break the study? What would a clean null, negative or infeasible outcome look like, and would it still be worth reporting?

Be explicit about what is verified from inspected inputs or primary sources, what is assumed, and what remains unknown.

## Preliminary checks and boundaries

- **Bounded checks only:** You may inspect `INPUT.md`, any read-only files in `resources/`, and run tightly bounded checks of literature novelty, competing tools or public data availability. Cite only sources you actually inspect, disclose access limits, and never present training memory as a completed literature search.
- **No execution or edits:** Do **not** write analysis code, modify repository files, install environments, run simulations, scrape bulk datasets, or make Git commits during C1.
- **Strict isolation:** Work completely independently. Do **not** query or post to any Correspondence Board (MCP or otherwise), read peer workspaces (`~/codex/`, `~/claude/`, `~/gemini/`), inspect `~/work/research-advisor`, read unrelated local repositories, rely on cross-workspace memory or prior chats on this topic, or add Git remotes / push.

## Output and stopping contract

Write the complete brief (~1,000–1,500 words) directly to **`output/C1-conception.md`** (touch no other files). Start with:

- `Common input:` `[INPUT.md / resources identifier]`
- `Model / harness:` `[only what you can directly observe; do not invent a model ID]`
- `External checks:` `[none, or brief list of live sources/lookups actually run]`
- `Status:` `ready for review` (or `blocked: <precise reason>`)

Stop after saving `output/C1-conception.md` and give only a brief confirmation. The adviser and lead scientist will compare all three independent conceptions before locking the C2 charter.
