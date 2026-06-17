#Overview
## tcl-asic-flow — RTL to GDSII Tcl Scripts for Cadence Genus & Innovus

Documented Tcl scripts covering a complete RTL-to-GDSII physical design flow using **Cadence Genus** (synthesis + DFT) and **Cadence Innovus** (place & route), implemented on a synchronous counter design at **180nm and 90nm** process nodes.

This repository is not a tutorial. It documents actual commands run during academic physical design projects, with comments explaining the reasoning behind each decision — not just the syntax.

---

## Tool & Technology Stack

| Category | Details |
|----------|---------|
| Synthesis & DFT | Cadence Genus |
| Place & Route | Cadence Innovus 17.13 |
| Process Nodes | 180nm, 90nm |
| Libraries | Standard cell liberty files (fast.lib / slow.lib), LEF, captable |
| Timing Methodology | MMMC (Multi-Mode Multi-Corner) — setup/hold with min/max corners |
| Clock Tree | ccopt-based CTS with non-default routing rules (2W2S) |
| Design | Synchronous counter (Verilog RTL → GDSII) |

---

## Repository Structure

```text
tcl-asic-flow/
│
├── README.md
│
├── synthesis/
│   ├── run_synth.tcl             # Master execution wrapper
│   ├── scripts/                  # 01 through 07 Genus Tcl scripts
│   ├── reports/                  # Area, power, and timing reports (.gitignore)
│   └── outputs/                  # Post-synth netlist, SDC, scan DEF (.gitignore)
│
└── physical_design/
    ├── run_pd.tcl                # Master execution wrapper
    ├── scripts/                  # MMMC config and 01 through 07 Innovus scripts
    ├── reports/                  # Pre/Post-CTS and signoff timing reports (.gitignore)
    └── outputs/                  # SPEF, Innovus DB, final netlist, GDSII (.gitignore)
```

## Flow Overview

### Synthesis (`/synthesis/scripts`)

Starts from RTL Verilog and produces a gate-level netlist with scan chains inserted for testability.

**01 → Read libraries** — Load fast/slow liberty files and set link library  
**02 → Read RTL** — Read Verilog and set the top-level module  
**03 → Elaborate** — Resolve hierarchy, check for unresolved references  
**04 → Constraints** — Apply clock definition, input/output delays, false paths via SDC  
**05 → Compile** — Run synthesis with timing-driven optimization  
**06 → DFT** — Insert scan chains, define scan enable/data ports, verify scan connectivity  
**07 → Write outputs** — Export post-synthesis netlist, updated SDC, and scan DEF for PD handoff  

### Physical Design (`/physical_design`)

Takes the post-synthesis netlist through floorplanning, power planning, placement, CTS, routing, and GDSII export.

**01 → Import** — Load netlist, LEF, and initialize MMMC with min/max corners (fast/slow libs + captable RC)  
**02 → Floorplan** — Set aspect ratio 1:1, ~70% core utilization, 2.5µm core-to-die boundary  
**03 → Power plan** — VDD/VSS rings on Metal5/6, vertical stripes on Metal6, SRoute for follow-pins  
**04 → Placement** — Enable OCV + CPPR, run standard cell placement, check pre-CTS timing for setup and hold  
**05 → CTS** — Create 2W2S NDR for clock nets, run ccopt-based clock tree synthesis  
**06 → Route** — NanoRoute with via optimization, filler cell insertion  
**07 → Signoff** — RC extraction to SPEF, save final netlist and design DB, stream out GDSII  

---

## Key Concepts Demonstrated

**MMMC setup** — Multi-corner analysis configured with separate library sets and RC corners for setup (worst/slow) and hold (best/fast) sign-off, reflecting real sign-off methodology rather than single-corner analysis.

**Non-default routing rules for CTS** — Clock nets routed with 2x width and 2x spacing (2W2S NDR) on upper metal layers to reduce resistance and coupling, improving clock tree quality and skew.

**OCV and CPPR** — On-Chip Variation and Common Path Pessimism Removal enabled during placement and timing analysis to model realistic within-die variation without double-counting shared path pessimism.

**DFT to PD handoff** — Scan DEF exported from synthesis is imported into Innovus to preserve scan chain ordering through placement, a critical step often skipped in academic flows.

---

## How to Run

The entire flow is controlled via the run_synth.tcl master script. You do not need to edit the individual files in the scripts/ directory unless you are modifying the synthesis methodology.

1. Open synthesis/run_synth.tcl.

2. Update the DESIGN_NAME and CONSTRAINT_FILE variables for your specific top-level module.

3. Update the $LIB_PATH and $RTL_PATH variables to point to your local PDK and working directory.

4. Launch Genus from the synthesis/ directory and source the wrapper:

**Synthesis (Genus):**
```tcl
# Navigate to the synthesis directory

# Launch Genus and execute the flow
genus -legacy_ui -f run_synth.tcl
```
All generated reports (area, power, timing) will be saved to reports/, and handoff files will be deposited in outputs/.

**Physical Design (Innovus):**
1. Open `physical_design/run_pd.tcl`.
2. Ensure the `$DESIGN_NAME` variable matches your synthesis output.
3. Launch Innovus from the `physical_design/` directory and source the wrapper:

```tcl
# Navigate to the physical design directory
cd tcl-asic-flow/physical_design/

# Launch Innovus and execute the complete flow
innovus -init run_pd.tcl -log run_pd.log
```

---

## Notes

- Library paths and cell names in the scripts reference a 180nm academic PDK. Adjust paths for your environment.
- `scripts/mmmc_config.tcl` and `scripts/ccopt.spec` are configuration files sourced automatically by the main flow scripts — they do not need to be run directly.
- Timing reports generated during the flow are not committed to the repo but the commands to reproduce them are in `04_placement.tcl` and `07_signoff_export.tcl`.

---

## Background

These scripts were developed during academic physical design coursework using Cadence EDA tools. The goal of this repository is to document the decision-making behind each step — layer choices, margin values, CTS parameters — rather than just the commands in isolation.

Process nodes covered: **180nm**, **90nm**
