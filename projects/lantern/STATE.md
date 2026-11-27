# Current state — Lantern (Track D pilot)

Updated: 27 November 2026, Australia/Hobart. **Stage D2 complete and independently verified across all three frozen builds; ready for Founder hands-on playtest (ports `4174`/`4175`/`4176`) and Stage D3 blind playtest + code audit.**

- **Track:** D — Open-source game development (D-Rebase pilot)
- **Founder / Vision Lead:** Barry W. Brook
- **Producer & Technical Lead:** Gemini 4 Neon (separate from the three independent developer sessions)
- **Source repository:** `BWBrook/lantern` (MIT code / CC BY-SA 4.0 content)
- **Common source baseline:** `lantern@1545181db73c0c51535fe9f5139f6c9b4ffd94ef` (`1545181`, clean `main`)
- **Curated single-commit baseline:** `c6ff88c7be1c0d6e4a2621a258e884563223dee2` (`c6ff88c`, 73 manifest files + Track D isolation docs + `INPUT.md`; remote-free clones at `~/{codex,claude,gemini}/lantern`)
- **Active Charter:** [charter.md](charter.md) (adopted 27 Nov 2026)
- **Shared read-only resources (`resources/stone-age-1897/`):** Complete 5-instalment *Idler* (1897) text of H. G. Wells's *A Story of the Stone Age* (~23,140 words from Project Gutenberg Australia) + 15 original 1897 Cosmo Rowe (1877–1952) period illustrations (public domain in AU & US; modern PGA Bing covers excluded).

## Senior Game Developers — Verified D1–D2 Summary

| Family | Model | D2 commit | Cartridge format | `src/` LOC | Verified tests & E2E | Prod JS+CSS gzip |
|---|---|---|---|---|---|---|
| **OpenAI (Codex)** | `Sol 6.2` (max) | `d7783e6` | Pure `cartridge.json` + `import.meta.glob` | `6,344` | `tsc` OK · **213/213** Vitest · **7/7** E2E | **50.14 KiB** |
| **Anthropic (Claude)** | `Opus 5.5` (max) | `7cacb5d` | Pure `cartridge.json` + `import.meta.glob` | `7,995` | `tsc` OK · **241/241** Vitest · **9/9** E2E | **78.61 KiB** |
| **Google (Gemini)** | `Gemini 4 Neon` (XHigh) | `d3062fe` | JSON-serializable TS data + static registry | `10,178` | `tsc` OK · **187/187** Vitest · **7/7** E2E | **64.37 KiB** |

All three builds passed clean `git archive HEAD` verification (`npm ci --prefer-offline`, zero runtime dependencies / Phaser removed, zero boundary leaks in `src/engine` & `src/ui`, zero console/page errors across 24 desktop `1280×800` + mobile `390×844` Playwright screenshots).

## Completed: Stage D1 (Independent game conception & rebase)

All three developers obeyed every read-only and isolation boundary (`commits=1`, `remotes=0`, `dirty=0`, `node_modules=ABSENT`) and converged independently on seven major architectural conclusions:
1. **Drop Phaser 3.90 → Canvas 2D + DOM:** `GameScene.ts` uses Phaser solely as a static image/shape blitter (`drawCaptionPanel` also covers rows 157–227 of 240 on fallbacks). Canvas 2D drops bundle size under ~100–120 KB gzipped and cleanly handles pixel scaling, state-driven palettes/glows, and portrait plates.
2. **Authentic Melbourne House vertical split:** Replace the rounded-card dashboard CSS with a top `384×240` crisp pixel viewport, compact cartridge-defined status bar, wide incrementally-appended DOM transcript (`boot.ts:156` currently rebuilds the whole DOM each turn), and always-reachable `>` prompt.
3. **Purge Harrow leaks & prose-sniffed failure checks:** Remove hardcoded `Lamp`/`"Lamp lit"` (`boot.ts`, `status.ts`, `turn.ts:97`, `GameScene.ts:173`), `"party shares one pack"` (`objects.ts:544`), `oil -> LIGHT` (`dictionary.ts:90`), hardcoded Harrow boot (`load-adventure.ts`), and `isLikelyActionFailure` (`turn.ts:48`, which sniffs English prefixes like `"that "`/`"without"`). Replace with typed `TurnOutcome` (`ok | blocked | failed | interrupted`).
4. **Keep parser front/back ends, upgrade the middle to multi-role INGLISH frames:** Preserve command chains, `ALL`/`EXCEPT`, `AGAIN`, pronouns, and scoped resolution; replace 2-slot/1-preposition `chunkRemainder` with named roles (multi-preposition `BIND X TO Y WITH Z`, location qualifiers `BESIDE`, instrument `AGAINST`, manner `WITHOUT FRIGHTENING`/adverbs, duration `UNTIL DAWN`/`THROUGHOUT THE NIGHT`, topic `WARN/TALK OF`).
5. **Opt-in living-world simulation:** Discrete turn clock + day/night phases, local light/fire fuel, spatial actors/wildlife with finite deterministic agendas, compositional crafting/assemblies, and stealth/awareness—disabled or minimal for Harrow so existing tests remain intact.
6. **Multi-cartridge Bookshelf & hardened saves:** Replace single-adventure boot with a retro cartridge shelf (Continue / New Game) and schema/revision-validated per-cartridge saves (`storage.ts` currently trusts parsed JSON blindly).
7. **Decoupled art verified sufficient for D2:** Keep Harrow's 3 `384×240` PNGs + Canvas fallbacks; render *Stone Age* rooms via state-responsive C64 Canvas scenes and show selected portrait Cosmo Rowe 1897 plates (`435–470×650`) un-stretched on matching story beats/headers (optionally C64-dithered).

**Distinct independent catches verified from source:**
- *Sol 6.2 & Opus 5.5:* `parser-corpus.json` actually contains **72** entries (not 74, verified directly on disk).
- *Sol 6.2:* `hasLightForRoom` (`visibility.ts`) checks a global `lamp_lit` flag, so dropping a lit lamp still lights dark rooms.
- *Opus 5.5:* `pendingClarification` traps meta commands (`LOOK`, `SAVE`, `HELP`) at `plan.ts:282`/`turn.ts:189`; all 12 Harrow hooks already fit pure declarative `conditions -> effects -> text`; PGA Chapter I text has minor OCR typos (`"Euderia"`, dropped word after `"strips of rabbit"`).
- *Gemini 4 Neon:* Verified exact Cosmo Rowe plate dimensions (`435–470×650` portrait, `600–602×150–184` headers) and flagged classical artistic nudity on some 1897 plates for Founder preference check.

**Three Founder Charter calls locked (27 Nov 2026):**
1. *Stone Age* Proof 2 slice: **"The First Axe"** (~5 tightly polished rooms, late Ch. I axe/fire → early Ch. II gully bear attack, deferring cave climax, tribe & horses while still verifying all 7 `INPUT.md` INGLISH forms in engine tests).
2. Cartridge contract: **Pure declarative data cartridges** (zero cartridge code at runtime; all 12 Harrow hooks and all *First Axe* rules/agendas expressed declaratively as validated data).
3. Failure stance & 1897 plates: **Require `UNDO` + foreseeable survival failure endings**, and keep 1897 Cosmo Rowe plates **faithful & un-stretched** (with optional C64 dither and brief 1897 period note).

## Decision log

- **2026-11-25:** Initiated Track D (`workflows/D-game-dev.md`, `prompts/D1–D3`, `--workflow D` in `scripts/build-isolated-clones.sh`) to pilot multi-model independent development on open-source hobby game projects, starting with `lantern` (D-Rebase).
- **2026-11-25:** Locked Founder's North Star (*1987 Melbourne House C64 / INGLISH "magical scanner" browser engine*), two proof cartridges (*The Harrow Mine Job* + tractable playable slice of H. G. Wells's *A Story of the Stone Age* [1897], faithful to Wells's Victorian conception), decoupled art policy (keep 3 existing Harrow PNGs + shared `resources/` pool for *Stone Age*, no ad hoc image generation inside D2), and decision to skip Founder playtest of September `1545181` in favour of saving hands-on playtest energy for D2 candidates.
- **2026-11-27:** Read, audited, and froze all three D1 briefs (`Sol 6.2`, `Opus 5.5`, `Gemini 4 Neon`; all clean read-only isolation).
- **2026-11-27:** Locked Pillar Charter ([charter.md](charter.md)), completed MacBook toolchain/Playwright pre-flight (Node `v26.13.1`, pre-cached Chromium/Firefox/WebKit, non-colliding local ports `4174`/`4175`/`4176` + `reuseExistingServer: false`), and staged `output/CHARTER.md` + `output/ASSIGNMENT-D2.md` across all three clones.
- **2026-11-27:** Independently froze and verified all three D2 builds (`Codex d7783e6`, `Claude 7cacb5d`, `Gemini d3062fe`) on clean `git archive HEAD` extractions; all three passed every automated Charter gate (`0` runtime deps, `50–79 KiB` gzipped JS+CSS, `187–241` Vitest, `7–9` Chromium E2E, `0` console errors across 24 uniform screenshots).

## Next action

1. Founder hands-on playtest (5–10 min per candidate on local preview ports `4174` Codex, `4175` Claude, `4176` Gemini).
2. Stage fresh-session, read-only **D3 blind playtest + adversarial code/contract audit** (`output/d3-packet/` + `VERIFIED-METRICS.md` + Founder playtest notes) across all three families.
