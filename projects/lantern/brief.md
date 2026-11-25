# Project brief — Lantern (Track D pilot: D-Rebase)

- **Track:** D — Open-source game development (D-Rebase pilot)
- **Source repository:** `BWBrook/lantern` (MIT code / CC BY-SA 4.0 original content)
- **Common source baseline:** commit `1545181db73c0c51535fe9f5139f6c9b4ffd94ef` (`1545181`, *Merge the parser grammar tranche into main*)
- **Founder / Vision Lead:** Barry W. Brook
- **Producer & Technical Lead:** Gemini 4 Neon (separate from the three independent senior game developers)

## North Star

Build a modern cross-platform browser game engine that feels lifted straight out of the mid-1980s **Melbourne House** Commodore 64 illustrated parser-adventure lineage (*The Hobbit*, *The Lord of the Rings: Game One*, *Shadows of Mordor*)—deterministic and offline (zero runtime LLM calls), yet capturing the illusion of an *"AI within the machine"* via expressive controlled English (**INGLISH**) and a genuinely living, reactive story world.

**Short North Star ("the magical scanner"):**
> *"I'm 13-year-old Barry back in 1987, pulling a book off my shelf, plugging it into my C64 using my magical scanner, and starting to play it instead of Lord of the Rings: Game One."*

## Two proof cartridges

1. **Proof 1 — *The Harrow Mine Job* (existing trial balloon in `adventures/harrow_mine/`):**
   An original 12-room architectural mine heist (Bram Pike & Nessa Vale, locks, light, mechanical winch, shared party inventory) that already exercises Lantern's current parser and room/hook contract. Keep the 3 existing C64-style PNG room stills (`town_edge_dawn.png`, `loading_yard_ruin.png`, `main_gallery_hub.png`) and deterministic fallbacks for remaining rooms during Stage 2.
2. **Proof 2 — H. G. Wells, *A Story of the Stone Age* (1897, public domain in AU & US):**
   Deliberately orthogonal to Harrow Mine: ecological, technological, and social survival rather than architectural locks and keys. Illustrative INGLISH commands the engine should grow toward supporting:
   - `EXAMINE THE TRACKS BESIDE THE RIVER`
   - `BREAK THE FLINT AGAINST THE LARGE STONE`
   - `BIND THE SHARP STONE TO THE BRANCH WITH SINEW`
   - `WARN EUDENA OF THE LION`
   - `FOLLOW THE HORSES WITHOUT FRIGHTENING THEM`
   - `KEEP THE FIRE BURNING THROUGHOUT THE NIGHT`
   - `WATCH THE TRIBE FROM THE TREES UNTIL DAWN`

   Complete 5-instalment *Idler* (May–September 1897) text plus 15 original 1897 period illustrations by Cosmo Rowe (1877–1952) are staged read-only in `resources/stone-age-1897/`. Start with a tractable playable slice (e.g., Chapter I *Ugh-lomi and Uya*, or whatever compact proof scope D1 recommends) while designing the engine/cartridge contract so full novella or Verne-length adaptations remain cleanly achievable later.
   - **Setting fidelity (settled):** Reproduce **Wells's 1897 Victorian conception** of Palaeolithic Surrey/the Weald faithfully rather than retrofitting modern palaeoanthropology, preserving the authentic feeling of stepping inside the 1897 book.

## Art & asset policy (settled)

- **Harrow Mine:** Keep the 3 existing C64 PNGs + crisp deterministic/procedural fallbacks during D2; defer generating remaining Harrow room PNGs to a dedicated pass on the winning backbone.
- **A Story of the Stone Age:** Shared read-only resource pool (`resources/stone-age-1897/illustrations/` holds Cosmo Rowe's 15 public-domain period drawings; any additional shared art assets will be staged identically across all developers before D2, or developers may propose vector/C64-dithered/procedural rendering pipelines). No ad hoc external image generation during isolated D2 rounds.

## Curated isolation

All three senior game developers (**Codex** `gpt-6.2-astra`, **Claude** `fable` / Fable 5.2, **Gemini** `gemini-4-carbon-high`) receive an identical curated single-commit, remote-free clone of `lantern@1545181` (73 active code, test, asset, and reference doc files; `HANDOVER.md`, old `AGENTS.md`/`CLAUDE.md`, `git log`, and `origin` stripped) plus read-only `resources/stone-age-1897/`.

## Downstream plan

- **D1:** Independent game rebase & creative conception (`output/D1-conception.md`).
- **Charter:** Compare all three conceptions, lock the Pillar Charter + 1-minute plain-English gut-check with Barry.
- **D2:** Independent autonomous builds on local MacBook (`macbook`, Node 26.13.1), producing runnable browser games + automated tests.
- **Producer verification + Founder active-learning playtest:** Verify builds/tests/bundle sizes + Playwright desktop/mobile screenshots, then hand Barry three clean local URLs for 5–10 min hands-on play per candidate.
- **D3:** Fresh-session read-only blind playtest + adversarial code/contract audit.
- **D4–D5:** Backbone convergence, targeted peer harvest, dedicated art/polish pass, short `GO / FIX-FIRST` diff audit, merge to `BWBrook/lantern` + compact pilot archive cleanup.
