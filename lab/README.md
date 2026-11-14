# Quantum Laboratory

Self-contained browser experiments that sit next to the Quantum Sigil & Resonance Engine. Every page is honest about what is simulated: quantum circuits, wave physics, or a Floquet toy — framed as generative / symbolic art, not supernatural claims.

Open `index.html` in a browser (or serve the `QuantumPuter` folder). Each experiment lives in its own folder and runs offline, except Live Cymatics' optional microphone permission. The Sigil loads Three.js from `../vendor/three.min.js`.

| Experiment | Path | What the math actually is |
|---|---|---|
| Quantum Sigil | `../sigil/index.html` | 12-qubit statevector, CHSH, Grover amplitude amplification, Solfeggio-style audio |
| Quantum Tarot | `tarot/` | 12-qubit sample → 78-card deal; CHSH on Past/Future qubits |
| Ritual Circle | `coven/` | GHZ state on N qubits, Z agreement and X parity |
| Zeno Binding | `zeno/` | Quantum Zeno effect on a Rabi qubit |
| Astral Teleport | `teleport/` | Bennett et al. teleportation with mid-protocol Kraus depolarizing noise on Bob’s half; F=1−p/2 |
| Many-Worlds Decision | `manyworlds/` | Branching amplitude tree (interpretation, not a proof) |
| Live Cymatics | `cymatics/` | FFT-driven Chladni modes (classical waves) |
| Quantum Eraser | `eraser/` | Delayed-choice eraser; no retrocausal signaling |
| Time Crystal | `timecrystal/` | Period-doubled kicked Ising toy |
| Ley Lines | `leylines/` | 2-D split-step Hadamard walk (ballistic vs diffusive) |
| Soul Bond | `soulbond/` | Entanglement swapping; CHSH on the un-met pair |
| Participatory Universe | `wheeler/` | Wheeler delayed-choice; interpretation, no signaling |
| Grimoire Network | `grimoire/` | Entanglement-swapping network of four sigil nodes; monogamy forbids a second maximal bond |
| Spell Seal · BB84 | `bb84/` | Bennett–Brassard 1984 QKD; intercept-resend Eve induces 25% QBER |
| Wormhole | `wormhole/` | 7-qubit Gao–Jafferis–Wall / Google 2022 analogue; not a spacetime wormhole |
| Quantum Darwinism | `darwinism/` | Zurek pointer broadcast; I(S:F) plateaus at 1 bit for k≥1 |

Aesthetic: obsidian, gold, cyan, film-grain. Earlier wings of the project: `../light/` (tweezers, bound photons) and `../ufo/` (propulsion tests).
