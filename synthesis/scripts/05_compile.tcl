set_db syn_generic_effort medium
syn_generic

set_db syn_map_effort medium
syn_map

set_db syn_opt_effort medium
syn_opt

# Generate generic reports
report_timing > reports/${DESIGN_NAME}_timing.rpt
report_area   > reports/${DESIGN_NAME}_area.rpt
report_power  > reports/${DESIGN_NAME}_power.rpt