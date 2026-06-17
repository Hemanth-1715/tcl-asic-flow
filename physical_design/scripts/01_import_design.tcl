source scripts/mmmc_config.tcl
# Load the MMMC view definition (library sets, RC corner, delay corners, constraint mode, analysis views)

read_physical -lef $LEF_FILE
# Load the LEF file containing physical/abstract views of standard cells and macros

read_netlist $NETLIST_FILE -top $DESIGN_NAME
# Read the post-synthesis gate-level Verilog netlist and set the top module

init_design
# Initialize the design database using the loaded netlist, LEF, and MMMC views