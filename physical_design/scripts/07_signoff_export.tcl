extractRC -outfile outputs/${DESIGN_NAME}.spef
# Extract parasitic RC values from the routed design and write to a SPEF file

report_timing -path_type full -late > reports/${DESIGN_NAME}_setup_postRoute.rpt
# Generate a post-route setup timing report (worst/slow corner)

report_timing -path_type full -early > reports/${DESIGN_NAME}_hold_postRoute.rpt
# Generate a post-route hold timing report (best/fast corner)

write_netlist outputs/${DESIGN_NAME}_final.v
# Export the final post-route gate-level netlist including physical cells (fillers, etc.)

saveDesign outputs/${DESIGN_NAME}_final.enc
# Save the complete Innovus design database for this stage

streamOut outputs/${DESIGN_NAME}.gds -mapFile streamOut.map -libName DesignLib -units 2000
# Export the final layout as a GDSII file using the provided layer map file