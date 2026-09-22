# 0001 — Mood overlay: the story signals, the page renders

**Status:** Proposed — 2026-09-21
**Context:** [#2](https://github.com/Johnesco/fever-dream-sharpee/issues/2)

## Decision

Port the Inform 7 edition's mood overlay (`C:/code/text-games/i7/feverdream/play.html`) without a story hatch.

| Piece | Signal | Renderer |
|---|---|---|
| Room palettes | the `#location-name` status text | `src/mood.ts` sets `data-mood-zone` on `<html>` |
| One-off effects | `transition <kind>` in the story, beside the `play sound` line | the platform's `transition` channel adds `transition-<kind>` to `.sharpee-window`; `src/mood.ts` adds what CSS cannot (glass shards) |
| Perception states | a replace-mode story channel (not yet built) | a renderer registered in `src/browser-entry.ts` |

All colour and animation lives in `browser/fever-dream-sharpee.css`. Palettes write the engine's `--theme-*` tokens under `[data-theme="modern-dark"]` only, so a theme the player picks and the hub's `!important` theme override both win over the mood.

## Consequences

- Events come from the story, not from matching prose. Corrupted prose swaps letters, so the Inform 7 regexes would miss after the spray.
- A `transition` class lasts `durationMs` (default 250). Longer effects use `emit media-transition with kind "<k>" and durationMs <n>`.
- The mood code lives in the bundle, not `play.html`, because `build.py --force` rewrites the page.
- Page code in `src/` is TypeScript, but it is page code, not an ADR-259 story hatch. The story stays pure IR.
- Devkit bundles no author JavaScript except through the entry, so `src/browser-entry.ts` carries `custom-entry:` and the workspace gate WARNs instead of passing. The change is one import and one call; re-check it against the devkit template after every engine bump.
- Open: whether a replace-mode channel's value comes back after a restore. The perception phase waits on that spike.
