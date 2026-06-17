# ==============================================================================
# Master Physical Design Flow Script (Cadence Innovus)
# ==============================================================================

# 1. Define Design Parameters
set DESIGN_NAME "my_design"

# Link to post-synthesis outputs (assuming synthesis flow was run previously)
set NETLIST_FILE "../synthesis/outputs/${DESIGN_NAME}_netlist_dft.v"
set SDC_FILE "../synthesis/outputs/${DESIGN_NAME}_constraints_dft.sdc"

# 2. Define Foundry & Library Paths (180nm PDK)
set LEF_FILE "/home/install/FOUNDRY/digital/90nm/dig/lef/all.lef"
set CAPTABLE_FILE "/home/install/FOUNDRY/digital/90nm/dig/captable/*.tbl"
set FAST_LIB "fast.lib"
set SLOW_LIB "slow.lib"

# 3. Execute Flow
source scripts/01_import_design.tcl
source scripts/02_floorplan.tcl
source scripts/03_power_plan.tcl
source scripts/04_placement.tcl
source scripts/05_cts.tcl
source scripts/06_routing.tcl
source scripts/07_signoff_export.tcl