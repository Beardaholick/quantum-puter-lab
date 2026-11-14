# Quantum Puter Lab

An installable, offline-friendly app built from the Quantum Sigil & Resonance Engine and its laboratory. Dark neon, gold, and obsidian, with a film-grain wash. Every experiment is a classical simulation of cited quantum (or wave) mathematics, framed as generative / symbolic art — not a supernatural claim.

## Open it

- **On the Mac:** double-click `~/QuantumPuter/dist/Quantum Puter Lab.app`. It starts a local server and opens a chromeless Chrome window (or your default browser if Chrome is missing).
- **In a browser:** `cd ~/QuantumPuter/app && python3 serve.py`, then visit the printed URL.
- **On an iPhone:** open the site in Safari (the shareable HTTPS link, or the LAN URL printed by the app / `serve.py` on the same Wi-Fi). Tap Share → **Add to Home Screen**. After the first visit, the lab is cached and works offline.

## What’s inside

The Quantum Sigil (12-qubit statevector, CHSH, Grover, Three.js icosahedron) plus fifteen laboratory experiments: tarot, GHZ / Mermin, Zeno, teleportation with mid-protocol Kraus noise, many-worlds visualization, cymatics, delayed-choice eraser, a time-crystal toy, a split-step Hadamard walk, entanglement swapping, Wheeler delayed choice, a grimoire network, BB84, a small-circuit wormhole analogue, and quantum Darwinism.

Light Lab and UFO / Propulsion are earlier Python wings of the original project and are not bundled here.

## Offline

`sw.js` precaches the app shell, experiments, icons, and the local Three.js vendor file. The first load needs a network; after that, the installed PWA runs without one.
