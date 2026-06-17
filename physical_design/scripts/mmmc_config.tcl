create_library_set -name min_timing -timing $FAST_LIB
# Create a library set using the fast (best-case) liberty file, used for hold analysis

create_library_set -name max_timing -timing $SLOW_LIB
# Create a library set using the slow (worst-case) liberty file, used for setup analysis

create_rc_corner -name rccorner -cap_table $CAPTABLE_FILE
# Define the RC corner using the foundry capacitance table for parasitic estimation

create_delay_corner -name min_delay -library_set min_timing -rc_corner rccorner
# Define the min delay corner (best-case) combining fast library set and RC corner

create_delay_corner -name max_delay -library_set max_timing -rc_corner rccorner
# Define the max delay corner (worst-case) combining slow library set and RC corner

create_constraint_mode -name const -sdc_files $SDC_FILE
# Define the constraint mode using the SDC file carried over from synthesis

create_analysis_view -name best -delay_corner min_delay -constraint_mode const
# Create the "best case" analysis view used for hold checks

create_analysis_view -name worst -delay_corner max_delay -constraint_mode const
# Create the "worst case" analysis view used for setup checks

set_analysis_view -setup {worst} -hold {best}
# Assign which analysis view is used for setup checks and which for hold checks