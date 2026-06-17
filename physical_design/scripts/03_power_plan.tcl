add_rings -nets {vdd vss} -type core_rings \
  -layer {top Metal5 bottom Metal5 left Metal6 right Metal6} \
  -width 0.7 -spacing 0.2 -offset 0.5
# Create power rings around the core boundary: Metal5 for top/bottom, Metal6 for left/right, 0.7um width, 0.2um spacing, 0.5um offset

add_stripes -nets {vdd vss} -layer Metal6 \
  -direction vertical -width 0.7 -spacing 0.2 \
  -set_to_set_distance 5 -start_from_core_boundary
# Add vertical power stripes on Metal6 with 0.7um width, 0.2um spacing, and 5um set-to-set distance between stripe pairs

sroute -connect {corePin} -layerChangeRange {Metal1 Metal6} -nets {vdd vss}
# Run special route to connect standard cell power/ground pins (follow-pins) to the power grid