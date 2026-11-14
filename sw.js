/* Quantum Puter Lab service worker — cache-first, same-origin GET */
const CACHE = 'qplab-v1';
const PRECACHE = [
  "./",
  "./app-pwa.js",
  "./icons/apple-touch-icon.png",
  "./icons/favicon.png",
  "./icons/icon-1024.png",
  "./icons/icon-128.png",
  "./icons/icon-180.png",
  "./icons/icon-192.png",
  "./icons/icon-256.png",
  "./icons/icon-32.png",
  "./icons/icon-512.png",
  "./icons/icon-64.png",
  "./icons/icon-maskable-512.png",
  "./index.html",
  "./lab/bb84/index.html",
  "./lab/coven/index.html",
  "./lab/cymatics/index.html",
  "./lab/darwinism/index.html",
  "./lab/eraser/index.html",
  "./lab/grimoire/index.html",
  "./lab/index.html",
  "./lab/leylines/index.html",
  "./lab/manyworlds/index.html",
  "./lab/soulbond/index.html",
  "./lab/tarot/index.html",
  "./lab/teleport/index.html",
  "./lab/theme.css",
  "./lab/timecrystal/index.html",
  "./lab/wheeler/index.html",
  "./lab/wormhole/index.html",
  "./lab/zeno/index.html",
  "./manifest.webmanifest",
  "./shell.css",
  "./sigil/index.html",
  "./vendor/three.min.js"
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE)
      .then(cache => cache.addAll(PRECACHE))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;
  event.respondWith((async () => {
    const cached = await caches.match(req, { ignoreSearch: true });
    try {
      const res = await fetch(req);
      if (res && res.ok && (res.type === 'basic' || res.type === 'cors')) {
        const copy = res.clone();
        const cache = await caches.open(CACHE);
        cache.put(req, copy);
      }
      return res;
    } catch (err) {
      if (cached) return cached;
      if (req.mode === 'navigate') {
        const home = await caches.match('./index.html');
        if (home) return home;
      }
      throw err;
    }
  })());
});
