write_hdl > outputs/${DESIGN_NAME}_netlist_dft.v
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > outputs/${DESIGN_NAME}_delays.sdf
write_sdc > outputs/${DESIGN_NAME}_constraints_dft.sdc
write_scandef > outputs/${DESIGN_NAME}_scanDEF.scandef 

gui_show