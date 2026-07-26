# Verilog 8-Bit CPU

A Verilog redesign of an 8-bit CPU/ALU system originally implemented in VHDL, targeting the
Digilent **Basys 3** (Artix-7, `xc7a35tcpg236-1`). Built and simulated in Vivado, structured
as a small hierarchical datapath: a free-running enable-gated state counter drives a decoder
that selects one of eight ALU operations, with switch-loaded input registers and a multiplexed
7-segment output.

This is a from-scratch Verilog port, not an auto-translation — every module was rewritten and
independently verified in simulation before being wired into the top level.

## Architecture

```
CPU (top)
├── machine     — 3-bit enable-gated counter (yfsm), advances on data_in while clocked
├── decod       — maps current_state -> one-hot 8-bit opcode, gated by Enable_Decoder
│   └── dec2to4  (x2)  — 2-to-4 line decoders, one for states 0-3, one for 4-7
├── RSU (x2)    — clocked input registers, load A / B on next posedge after reset release
├── ALU         — clocked, 8-way case on one-hot opcode, computes result
└── sseg        — time-multiplexed 4-digit 7-segment driver for result display
```

All sequential modules (`machine`, `RSU`, `ALU`) share the same reset pattern:
asynchronous, active-high (`posedge clk or posedge reset`), synchronous load otherwise.
At the top level, a single external `Reset_All` port fans out internally to all four reset
nets (`FSM_Reset`, `Reset_A`, `Reset_B`, `Reset_C`) — one physical button clears the entire
datapath, including the last computed ALU result.

### Why `machine` isn't a "real" FSM

`current_state` doesn't branch on external conditions — it's a mod-8 counter that increments
by one every clock edge `data_in` is held high, and holds otherwise. `data_in` is functionally
an **enable**, not a serial data line or a branch condition. That's a deliberate simplification:
it gives deterministic, one-state-per-button-press stepping through all 8 ALU operations for
manual testing on hardware.

## Opcode Table

`decod` converts the 3-bit `current_state` into a one-hot 8-bit opcode (only live while
`Enable_Decoder` is asserted; otherwise the ALU sees `opcode = 0` and outputs `0`).

| State | Opcode (one-hot) | Operation             | Expression                          |
|-------|-------------------|------------------------|--------------------------------------|
| S0    | `00000001`        | Add 2 to Reg1          | `Reg1 + 2`                           |
| S1    | `00000010`        | Shift right by 2       | `Reg1 >> 2`                          |
| S2    | `00000100`        | Min(Reg1, Reg2)        | `(Reg1 > Reg2) ? Reg2 : Reg1`        |
| S3    | `00001000`        | Masked AND             | `{6'b0,Reg1[1:0]} & {2'b0,Reg1[7:2]}`|
| S4    | `00010000`        | Bitwise NOT            | `~Reg2`                              |
| S5    | `00100000`        | Bitwise XOR            | `Reg1 ^ Reg2`                        |
| S6    | `01000000`        | Reg1 + Reg2 − 4        | `Reg1 + Reg2 - 4`                    |
| S7    | `10000000`        | Shift left by 1        | `Reg1 << 1`                          |

## Board I/O Map (Basys 3)

| Signal            | Board control        | Pin(s)                                      |
|-------------------|-----------------------|----------------------------------------------|
| `clk`             | Onboard 100 MHz osc.  | W5                                            |
| `A[7:0]`          | Switches SW0–SW7      | V17, V16, W16, W17, W15, V15, W14, W13        |
| `B[7:0]`          | Switches SW8–SW15     | V2, T3, T2, R3, W2, U1, T1, R2                |
| `Reset_All`       | BTNC (center)         | U18                                           |
| `data_in`         | BTNR (right)          | T17                                           |
| `Enable_Decoder`  | BTNL (left)           | W19                                           |
| `RCheck[7:0]`     | LED0–LED7             | U16, E19, U19, V19, W18, U15, U14, V14        |
| `OpCodeCheck[7:0]`| LED8–LED15            | V13, V3, W3, U3, P3, N3, P1, L1               |
| `Led[6:0]`        | 7-seg segments        | W7, W6, U8, V8, U5, V5, U7                    |
| `Anodes[3:0]`     | 7-seg digit enables    | U2, U4, V4, W4                                |

Every top-level port is pin-constrained. `Reset_A`, `Reset_B`, `Reset_C`, and `FSM_Reset` are
internal-only wires driven from `Reset_All` — see Architecture.

## Repository Layout

Source files live under `8_Bit_CPU_Design.srcs/`; everything else is Vivado-generated project
state (caches, run directories, simulation build output).

```
8_Bit_CPU_Design.srcs/
├── sources_1/new/
│   ├── CPU.v          — top-level module, wires the datapath together
│   ├── machine.v       — enable-gated state counter
│   ├── decod.v          — top-level 3-to-8 one-hot decoder
│   ├── dec2to4.v        — 2-to-4 decoder building block, instantiated twice by decod
│   ├── RSU.v            — clocked input register (used for both A and B)
│   ├── ALU.v            — 8-operation ALU
│   └── sseg.v           — multiplexed 4-digit 7-segment display driver
├── sim_1/new/
│   └── tb_cpu.v         — top-level testbench
└── constrs_1/new/
    └── basys3.xdc        — active pin constraints
```

## Simulation

`tb_cpu.v` instantiates `CPU`, generates a 10 ns-period clock, releases reset, loads fixed
values into `A`/`B`, then steps through all 8 states: pulses `data_in` high for one clock edge
to advance `machine` by one state, holds it low so the state settles, and prints `RCheck` to
the console each cycle via `$display`.

To run:
1. Open the project in Vivado, select `tb_cpu` as the simulation top.
2. **Flow Navigator → Simulation → Run Simulation → Run Behavioral Simulation.**
3. Check the Tcl console output and the waveform viewer for `OpCodeCheck` / `RCheck` against
   the Opcode Table above.

## Status

- [x] All modules translated to Verilog and simulated individually
- [x] RTL Analysis / Linter run — unused wires identified and removed, no violations
- [x] Synthesis run — port mapping and hierarchy verified
- [x] Implementation run — surfaced the need for a physical `Enable_Decoder` button, added
      and constrained
- [x] All top-level ports pin-constrained; resets consolidated to a single `Reset_All` input
- [ ] Bitstream generated and programmed to hardware
- [ ] On-board validation across all 8 opcodes

## Known Issues / TODO

- **Full Vivado project state is checked into the repo** (`.cache/`, `.runs/`, `.sim/`,
  `.ip_user_files/`, generated `.dcp` files). Standard practice is to `.gitignore` these and
  keep only `.srcs/`, `.xpr`, and constraint files under version control — worth adding before
  the repo grows further.

## Background

Redesign of an earlier VHDL implementation of the same 8-bit CPU/ALU architecture, done as a
self-directed exercise in re-deriving the same digital logic in Verilog rather than
transliterating syntax 1:1.