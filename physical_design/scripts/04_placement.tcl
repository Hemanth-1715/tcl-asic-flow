setPlaceMode -place_io_pins true
# Enable automatic placement of I/O pins during standard cell placement

setAnalysisMode -analysisType onChipVariation -cppr both
# Enable On-Chip Variation (OCV) and Common Path Pessimism Removal (CPPR) for both setup and hold analysis

place_design
# Run standard cell placement using the current floorplan, power plan, and placement settings

report_timing -path_type full -max_paths 10 -late > reports/${DESIGN_NAME}_setup_preCTS.rpt
# Generate a pre-CTS setup timing report (worst/slow corner) for the top 10 paths

report_timing -path_type full -max_paths 10 -early > reports/${DESIGN_NAME}_hold_preCTS.rpt
# Generate a pre-CTS hold timing report (best/fast corner) for the top 10 paths