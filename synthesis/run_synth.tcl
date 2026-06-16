# ==============================================================================
# Master Synthesis Flow Script
# ==============================================================================

# 1. Define Design Parameters
set DESIGN_NAME "my_design"
set CONSTRAINT_FILE "my_design_constraints.g"

# 2. Define Library and RTL Paths
set LIB_PATH "/home/install/FOUNDRY/digital/90nm/dig/lib"
set RTL_PATH "/home/student/Desktop/ASIC_Design/work"

# 3. Execute Flow
source scripts/01_read_libs.tcl
source scripts/02_read_netlist.tcl
source scripts/03_elaborate.tcl
source scripts/04_constraints.tcl
source scripts/05_compile.tcl
source scripts/06_dft_scan_insert.tcl
source scripts/07_write_outputs.tcl