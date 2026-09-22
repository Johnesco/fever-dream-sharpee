/**
 * Mood overlay (ADR 0001, issue #2): the page side of the Inform 7 edition's
 * mood system. The story signals; this module and the author stylesheet render.
 *
 * - Room palettes: the status line's room name sets `data-mood-zone` on
 *   `<html>`. The colours live in `browser/fever-dream-sharpee.css`.
 * - Glass shards: the story's glass transition (`emit media-transition`) puts `transition-glass` on
 *   `.sharpee-window`. CSS shakes the window; the shards need DOM, so they
 *   are spawned here.
 * - Clarity: the story's fungus transition runs the ripple (CSS); when it
 *   ends, `data-perception="clarity"` goes on `<html>` and stays, switching
 *   the palettes and starting the 40s decay. Latched here, not read from the
 *   story, so a restore or restart does not reset it (restart is in flux).
 */

/** Room name (lower case, no leading article) → palette zone. */
const ROOM_ZONES: Record<string, string> = {
  'receiving room': 'ward',
  'corridor': 'ward',
  'treatment room': 'treatment',
  'stairwell': 'basement',
  'laboratory': 'laboratory',
  'cold storage': 'coldstorage',
  'cistern': 'cistern',
  'source': 'source',
};

const SHARD_COUNT = 20;
const SHARD_LIFETIME_MS = 1500;
/** Matches the story's `durationMs 2500` on the fungus transition. */
const FUNGUS_RIPPLE_MS = 2500;

function zoneFor(roomName: string): string | undefined {
  const key = roomName.trim().toLowerCase().replace(/^the\s+/, '');
  return ROOM_ZONES[key];
}

function prefersReducedMotion(win: Window): boolean {
  return win.matchMedia?.('(prefers-reduced-motion: reduce)').matches ?? false;
}

function spawnGlassShards(doc: Document): void {
  const win = doc.defaultView;
  if (!win || prefersReducedMotion(win)) return;
  const cx = win.innerWidth / 2;
  const cy = win.innerHeight * 0.4;
  const shards: HTMLElement[] = [];
  for (let i = 0; i < SHARD_COUNT; i++) {
    const shard = doc.createElement('div');
    shard.className = 'fd-glass-shard';
    const angle = (i / SHARD_COUNT) * Math.PI * 2 + (Math.random() - 0.5) * 0.6;
    const dist = 50 + Math.random() * 200;
    shard.style.left = `${cx}px`;
    shard.style.top = `${cy}px`;
    shard.style.setProperty('--sx', `${Math.cos(angle) * dist}px`);
    shard.style.setProperty('--sy', `${Math.sin(angle) * dist + 40}px`);
    shard.style.setProperty('--sr', `${Math.random() * 360 - 180}deg`);
    shard.style.setProperty('--shard-w', `${3 + Math.random() * 6}px`);
    shard.style.setProperty('--shard-h', `${5 + Math.random() * 10}px`);
    shard.style.setProperty('--shard-dur', `${0.6 + Math.random() * 0.6}s`);
    doc.body.appendChild(shard);
    shards.push(shard);
  }
  win.setTimeout(() => shards.forEach((s) => s.remove()), SHARD_LIFETIME_MS);
}

/** Wire the overlay. Call once, after the page's DOM exists. */
export function startMood(doc: Document = document): void {
  const location = doc.getElementById('location-name');
  if (location) {
    const applyZone = (): void => {
      const zone = zoneFor(location.textContent ?? '');
      if (zone) doc.documentElement.dataset.moodZone = zone;
    };
    new MutationObserver(applyZone).observe(location, {
      childList: true, characterData: true, subtree: true,
    });
    applyZone();
  }

  const frame = doc.querySelector('.sharpee-window');
  if (frame) {
    let glassShown = false;
    let fungusShown = false;
    new MutationObserver(() => {
      const glass = frame.classList.contains('transition-glass');
      if (glass && !glassShown) spawnGlassShards(doc);
      glassShown = glass;

      const fungus = frame.classList.contains('transition-fungus');
      if (fungus && !fungusShown) {
        doc.defaultView?.setTimeout(() => {
          doc.documentElement.dataset.perception = 'clarity';
        }, FUNGUS_RIPPLE_MS);
      }
      fungusShown = fungus;
    }).observe(frame, { attributes: true, attributeFilter: ['class'] });
  }
}
