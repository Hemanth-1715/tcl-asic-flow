set_db dft_scan_style muxed_scan
# Set the DFT Scan flip-flop style for scan replacement

set_db dft_prefix dft_
# Prefix is added to the name of DFT logic that is inserted

define_shift_enable -name SE -active high -create_port SE
# Define the test signals, the syntax is: define_shift_enable -name {scan_en} -active {high} -create_port {scan_en}

check_dft_rules
# It is recommended to check DFT rules multiple times during a DFT flow. Check pass means all the registers are eligible for scan connection

set_db design:${DESIGN_NAME} .dft_min_number_of_scan_chains 1
# Specify the number of scan chains required to connect all FFs. Here one scan chain is used

define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports
# Specify the scan-in and scan-out ports of the scan chain

connect_scan_chains -auto_create_chains
# Connect the scan chains using the connect_scan_chain command. This will include all original FFs that were mapped to scan flops

syn_opt -incr
# Run incremental synthesis to map the newly inserted scan logic

report_scan_chains
# View the DFT chains

write_dft_atpg -library $LIB_PATH
# Run the final ATPG analysis and vector generation. This step will take the final scan chains and run through the basic ATPG flow. This flow will generate a directory name test_scripts in current working location