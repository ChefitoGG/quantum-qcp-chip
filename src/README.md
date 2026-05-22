quantum-qcp-chip

A hardware qubit controller implemented in synthesizable Verilog — designed to drive microwave pulses that manipulate the quantum state of a superconducting qubit (|0⟩, |1⟩, or superposition).

Status: ✅ Verified ·  Ready for fabrication (Tiny Tapeout)

What is this?
This project implements a Quantum Control Processor (QCP) in RTL Verilog. It generates precisely timed microwave pulses to rotate the state of a qubit on the Bloch sphere, following the time-dependent Schrödinger equation under a driven two-level Hamiltonian.
In short: this chip tells a qubit what to do.

The Physics
The qubit evolves under the driven Hamiltonian:
iℏddt∣ψ(t)⟩=[−ℏ2ω0σ^z−ℏ2Ω(t)(cos⁡(ωt)σ^x+sin⁡(ωt)σ^y)]∣ψ(t)⟩i\hbar \frac{d}{dt} \left| \psi(t) \right\rangle = \left[ -\frac{\hbar}{2} \omega_0 \hat{\sigma}_z - \frac{\hbar}{2} \Omega(t) \left( \cos(\omega t)\hat{\sigma}_x + \sin(\omega t)\hat{\sigma}_y \right) \right] \left| \psi(t) \right\rangleiℏdtd​∣ψ(t)⟩=[−2ℏ​ω0​σ^z​−2ℏ​Ω(t)(cos(ωt)σ^x​+sin(ωt)σ^y​)]∣ψ(t)⟩
Where:

ω₀ — qubit resonance frequency (transition frequency between |0⟩ and |1⟩)
ω — microwave drive frequency (tuned to resonance: ω ≈ ω₀)
Ω(t) — Rabi frequency, proportional to the pulse amplitude (controls rotation speed)
σ_x, σ_y, σ_z — Pauli matrices (quantum spin operators)

When the drive is on resonance, the qubit undergoes Rabi oscillations — it rotates continuously between |0⟩ and |1⟩. By controlling the pulse duration and phase, any rotation on the Bloch sphere is achievable (X gate, Y gate, arbitrary single-qubit gates).



Architecture:
┌─────────────────────────────────────────────┐
│               QCP Top Module                │
│                                             │
│  ┌──────────┐    ┌──────────┐               │
│  │  Timer   │───▶│  Pulse   │               │
│  │  (qcp_   │    │Generator │──▶ MW_OUT     │
│  │  timer)  │    │          │               │
│  └──────────┘    └──────────┘               │
│       │                                     │
│  ┌────▼─────┐                               │
│  │ Phase &  │                               │
│  │ Freq Ctrl│                               │
│  └──────────┘                               │
└─────────────────────────────────────────────┘


ModuleDescriptionqcp_timerControls pulse timing and duration — verified ✅pulse_genGenerates I/Q microwave signal (cos/sin modulation)topTop-level integration and USB interface

Full module documentation: /src/README.md

Repository Structure:
quantum-qcp-chip/
├── src/          # RTL Verilog source files
├── test/         # Testbenches and simulation
├── docs/         # Schematics, waveforms, datasheets
└── .github/      # CI workflows (lint, simulation)




Author
ChefitoGG — Self-taught hardware engineer
github.com/ChefitoGG

Built from scratch. No degree required.
