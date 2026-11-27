# Creative & Technical Pillar Charter — Lantern (Track D, Stage 2)

Adopted: 27 November 2026 (Founder: Barry W. Brook; Producer: Gemini 4 Neon).

## 1. North Star & Player Fantasy

> *"I'm 13-year-old Barry back in 1987, pulling a book off my shelf, plugging it into my C64 using my magical scanner, and starting to play it instead of Lord of the Rings: Game One."*

Lantern is an offline, deterministic, cross-platform browser engine for mid-1980s **Melbourne House** illustrated parser adventures (*The Hobbit*, *The Lord of the Rings: Game One*, *Shadows of Mordor*). Its magic is the feel of an *"AI within the machine"*—expressive controlled English (**INGLISH**) over an illustrated, living, reactive story world—combined with a clean **"magical scanner" cartridge contract** so new original or classic public-domain stories drop in without modifying engine code.

## 2. Hard Engineering & Architectural Invariants

1. **Zero Phaser / Lightweight Canvas 2D + DOM:** Remove `phaser` completely. Render scenes with crisp Canvas 2D (`imageSmoothingEnabled = false` for pixel art) and ordinary semantic HTML/CSS. Target production JS+CSS bundle **≤ 120 KB gzipped** (excluding image assets), zero runtime network/AI calls, and zero browser console errors.
2. **Authentic Melbourne House Vertical Layout:** Replace the rounded-card dashboard CSS with a retro vertical split: crisp `384×240` top illustration viewport (no caption boxes covering art), compact cartridge-defined status bar, wide incrementally appended scrolling DOM transcript below (do not rebuild the entire transcript DOM each turn), and always-reachable keyboard-first `>` prompt (`↑/↓` history, `#` playtest notes, `TRANSCRIPT` export, clean desktop and narrow/mobile viewport fit including mobile keyboard/`visualViewport` safety).
3. **Pure Declarative Data Cartridges (Zero Cartridge Code at Runtime):** This is the core "magical scanner" invariant. Both playable cartridges (*The Harrow Mine Job* and *The First Axe*) plus the portability fixture (`tiny_adventure`) must express **100% of their world, rules, conditions, effects, crafting recipes, and actor agendas as pure validated data**—with zero imperative hook callbacks at runtime and zero imports from `src/engine/` internals. (You may author cartridges in typed TypeScript compiled/validated as pure data or directly as JSON—the engine consumes only validated data.) Add an automated boundary test confirming `src/engine/` and `src/ui/` never import from or reference any cartridge ID, prose, flag, or story-specific concept. Purge all inherited Harrow leaks (`lampState`, `"Lamp lit"`, `"party shares one pack"`, `oil -> LIGHT`, hardcoded Harrow boot).
4. **Strict Determinism, Typed Outcomes & Fixed Baseline Bugs:**
   - Pure deterministic turn reducer (no `Math.random()` or `Date.now()` inside engine turns; if randomness is used, serialize PRNG state explicitly inside `GameState`).
   - Replace prose-sniffed `isLikelyActionFailure` with explicit typed outcomes (`ok | blocked | failed | interrupted`) so chains and multi-turn commands stop only on genuine failures/interrupts.
   - Fix `pendingClarification` trapping meta commands (`LOOK`, `SAVE`, `LOAD`, `UNDO`, `HELP`, `TRANSCRIPT` must always work).
   - Fix local light visibility (`hasLightForRoom` must check that an active light source is carried or in the current room, not globally lit after being dropped).
5. **Multi-Cartridge Bookshelf, Hardened Saves & `UNDO`:**
   - Replace single-adventure boot with a keyboard-accessible retro **Bookshelf / Cartridge Picker** showing available cartridges (`Continue` / `New Game`, plus in-shell switching and optional URL deep link).
   - Key saves by cartridge ID and validate schema + content revision on load (recovering cleanly from corrupt or mismatched saves without throwing).
   - Implement reliable multi-step **`UNDO`** over pure `GameState`.

## 3. INGLISH Parser & Living-World Simulation Bar

- **Zero Harrow regression:** Preserve command chains, noun lists, `ALL`/`EXCEPT`, `AGAIN`, pronouns (`it`/`them`), companion addressing, scoped resolution, honest `I read that as: ...` disclosures, and typo hints. All **72** cases in `adventures/harrow_mine/tests/parser-corpus.json` and both golden paths (`golden-path.txt` and `golden-path-natural.txt`) must pass cleanly.
- **Multi-role INGLISH grammar:** Upgrade the parser middle layer to support named semantic roles:
  - location and surface prepositions (`beside`, `against`, `from`, `of`, `with`, `to`, etc.),
  - trivalent / multi-preposition crafting (`BIND X TO Y WITH Z`),
  - preserved manner adverbs and stealth clauses (`quietly`, `carefully`, `slowly`, `without frightening ...`),
  - social/warning topics (`WARN <actor> OF <hazard>`, `TALK`/`ASK` with topic),
  - guarded multi-turn durations (`UNTIL DAWN`, `THROUGHOUT THE NIGHT`) that advance the world clock step-by-step and interrupt immediately on newly perceived danger, lost targets, or depleted fuel/supplies.
- **Opt-in living-world simulation (inactive or minimal in Harrow; active in *The First Axe*):**
  - Discrete world turn clock and day/night phases (only accepted physical/social actions and explicit `WAIT` advance time; meta commands, parser errors, and pure observations do not burn clock unfairly).
  - Local light and fire/fuel depletion.
  - Spatial actors and wildlife with independent locations and finite deterministic agendas (investigating fire, patrolling/approaching, warning/sheltering, reacting to noise/manner).
  - Compositional crafting/assemblies with recoverable components on failed attempts.
- **All 7 `INPUT.md` INGLISH command shapes verified:** Exercise the forms natural to *The First Axe* directly in live gameplay, AND verify all 7 exact sentence structures from `INPUT.md` (`EXAMINE THE TRACKS BESIDE THE RIVER`, `BREAK THE FLINT AGAINST THE LARGE STONE`, `BIND THE SHARP STONE TO THE BRANCH WITH SINEW`, `WARN EUDENA OF THE LION`, `FOLLOW THE HORSES WITHOUT FRIGHTENING THEM`, `KEEP THE FIRE BURNING THROUGHOUT THE NIGHT`, `WATCH THE TRIBE FROM THE TREES UNTIL DAWN`) in engine parser/fixture tests.

## 4. Two Playable Proof Cartridges (Stage 2 Deliverable)

### Proof 1 — *The Harrow Mine Job* (12 rooms, pure-data port)
- Complete 12-room mine heist ported cleanly to the pure declarative cartridge format (zero runtime hooks), passing all 72 existing corpus cases, both golden paths, and local-lamp darkness checks.
- Preserve the 3 existing `384×240` C64 PNG stills (`town_edge_dawn.png`, `loading_yard_ruin.png`, `main_gallery_hub.png`) at crisp native aspect and render the other 9 rooms with clean C64-palette Canvas 2D fallbacks (no caption overlay).

### Proof 2 — *The First Axe* (compact ~5-room slice of H. G. Wells's *A Story of the Stone Age*, 1897)
- **Setting fidelity:** Strictly faithful to Wells's 1897 Victorian Surrey/Weald conception (`resources/stone-age-1897/01-ugh-lomi-and-uya.txt` and `02-ugh-lomi-and-the-cave-bear.txt`). Include a brief, tasteful period note noting the 1897 *Idler* source.
- **Playable arc (~5 tightly polished locations, ~20–30 min play):** Span from the morning after Ugh-lomi and Eudena's first fireless night on the chalk cliff ledge through:
  1. discovering the holed flint + stick fit, chipping/knapping the edge against stone, and binding the **First Axe** with rabbit strips (accepting `sinew` as an alias/synonym as well);
  2. sparking and tending **Brother Fire** through the night while watching for approaching danger until dawn;
  3. perceiving and reacting to **Andoo the Cave-Bear** (and mate/tracks/chalk-rattle cues) investigating the fire, coordinating with and warning **Eudena** (who has her own spatial state and reactions);
  4. departing upriver via **at least two genuine winning paths** (Wells's dramatic fire-fails / gully-fight / axe-recovery route AND an observant stealth/warned early-escape route) plus **foreseeable survival failure endings** (e.g., mauled by Andoo if warnings are ignored) made completely fair by **`UNDO`**.
- **Test & playability artifacts:** Ship a primary golden path, an alternate-route walkthrough, a failure+`UNDO` walkthrough, and a **≥ 50-case parser corpus** covering natural paraphrases, multi-clause commands, and honest refusals.

## 5. Decoupled Art & Presentation Policy

- **No ad hoc AI image generation during Stage 2.**
- **Harrow Mine:** Reuse the 3 existing `384×240` PNGs + upgraded crisp Canvas 2D fallbacks for the remaining 9 rooms.
- **The First Axe:** Render the ~5 locations as state-responsive C64-palette Canvas 2D landscapes (visually reflecting time of day, fire glow/dying embers, tracks/silhouettes), AND incorporate selected public-domain 1897 **Cosmo Rowe** illustrations copied from read-only `resources/stone-age-1897/illustrations/` into the cartridge's local assets (with full provenance/attribution: H. G. Wells 1866–1946, Cosmo Rowe 1877–1952, *The Idler* 1897, public domain in AU & US). Display Cosmo Rowe's portrait plates (`435–470×650`) **faithfully and un-stretched** (preserving aspect ratio, with optional C64 dither/retro framing) on matching story beats, and use title headers cleanly on the bookshelf/title screen.

## 6. Explicit Scope Fence (Out of Scope for Stage 2)

Do **not** build: runtime LLM/network calls, a visual content editor, RPG HP/combat stat systems, Tauri desktop packaging, Chapters III–V of *Stone Age* (full cave-bear boulder climax, tribe/Uya arc, horse-riding, Uya the lion) or a Verne cartridge, sound/music engines unless tiny and strictly optional/muted by default, or ad hoc newly generated PNG art.

## 7. Verification & Playability Gates

Every candidate will be independently verified by the Producer on frozen `git archive HEAD` snapshots before Founder hands-on playtesting and Stage 3 blind playtest + audit:

1. **Typecheck & build:** `npm run typecheck` (0 errors); `npm run build` succeeds cleanly with production JS+CSS **≤ 120 KB gzipped** (excluding images).
2. **Unit, contract & determinism tests (`npm test`):**
   - Cartridge schema/reference/asset validation + engine boundary test (zero cartridge imports/leaks in `src/engine/` and `src/ui/`).
   - Harrow: 72-case corpus, both golden paths, local-lamp darkness test.
   - *The First Axe*: ≥50-case corpus, both winning routes, foreseeable death + `UNDO`, clock/fire/interrupt/stealth/crafting tests.
   - Engine parser/fixture verification of all 7 `INPUT.md` command shapes.
   - `tiny_adventure` portability fixture ported to pure data and passing end-to-end.
   - Replay determinism (identical inputs → byte-identical final `GameState` and transcript) + save/load round-trip & corrupt/mismatched save recovery.
3. **Browser E2E & visual hygiene (`npm run test:e2e`):** Playwright Chromium tests (`reuseExistingServer: false`) checking zero console errors, desktop (`1280×800`) and mobile/narrow (`390×844`) viewport fit without clipping/overflow, non-blank canvas, un-stretched portrait plates, bookshelf cartridge switching, save/load, `UNDO`, and live gameplay turns on both cartridges.
4. **Founder & Stage 3 blind playtest readiness:** Include a clean, concise cartridge-authoring guide or example (`README` / docs note) showing how a human or offline "magical scanner" agent adds a third cartridge, and ensure a brand-new player can explore both cartridges unaided using built-in `HELP` and in-world cues.

## 8. Freedom of Internal Design

Internal cartridge schema ergonomics, TypeScript-to-JSON build mechanics (if used), parser implementation, Canvas 2D drawing style, retro colour/font palette, and test helper structure are entirely yours to design. Focus on making Lantern genuinely feel like an unforgettable 1987 Melbourne House machine in a modern browser.
