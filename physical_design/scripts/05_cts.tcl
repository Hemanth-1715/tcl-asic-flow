add_ndr -name 2w2s -spacing {Metal5 0.4 Metal6 0.4} -width {Metal5 0.14 Metal6 0.14}
# Create a non-default routing rule (2x width, 2x spacing) for clock net routing on Metal5/Metal6

create_route_type -name clkroute -non_default_rule 2w2s \
  -bottom_preferred_layer Metal5 -top_preferred_layer Metal6
# Define a clock route type using the 2W2S rule with preferred top/bottom metal layers

set_ccopt_property route_type clkroute -net_type trunk
# Apply the clock route type to trunk segments of the clock tree

set_ccopt_property route_type clkroute -net_type leaf
# Apply the clock route type to leaf segments of the clock tree

set_ccopt_property buffer_cells {CLKBUFX2 CLKBUFX4}
# Specify which buffer cells ccopt is allowed to use while building the clock tree

set_ccopt_property inverter_cells {CLKINVX2 CLKINVX4}
# Specify which inverter cells ccopt is allowed to use while building the clock tree

set_ccopt_property clock_gating_cells TLATNTSCA*
# Specify the clock gating cell pattern to be recognized/used during CTS

create_ccopt_clock_tree_spec -file ccopt.spec
# Generate the CTS specification file capturing all the above ccopt settings

source ccopt.spec
# Load the generated CTS spec file into the current session

ccopt_design -cts
# Run clock tree synthesis using the loaded spec

report_clock_trees -summary > reports/${DESIGN_NAME}_cts_summary.rpt
# Print a summary of the synthesized clock tree(s) — buffer count, levels, etc.

report_skew > reports/${DESIGN_NAME}_skew.rpt
# Generate a clock skew report to verify balance across the clock tree