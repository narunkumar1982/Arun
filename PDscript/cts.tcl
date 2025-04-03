
#Use muliple CPU
setMultiCpuUsage -localCpu 2


# Restore the design place.enc
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_place.enc.dat CPU
# Create the CTS Specifications File
#source -e -v scripts/ccopt.spec

# Build the Clock Tree
To run CCOpt-CTS to perform CTS with global skew balancing, use the following command:
ccopt_design -cts

To run CCOpt to perform CTS with Clock Concurrent Optimization, use the same command but
without the cts parameter. An example is provided below.
ccopt_design


#Timing Analysis
timeDesign -postCTS 
timeDesign -postCTS -hold 
timeDesign -postCTS -prefix postcts -drvReports -expandReg2Reg -slackReports


#Dump the reports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/constraint.rpt 
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/threshold_voltage.rpt
report_design > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/design_summary.rpt
reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/congestion.rpt
report_ccopt_clock_trees -file /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/clk_trees.rpt
report_ccopt_clock_tree_structure > /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/clk_tree_structure.rpt
report_ccopt_skew_groups -file /home/pd1/RISC_V_31_05_24/rpts/cts_rpts/skew_groups.rpt
report_timing -nworst 10
report_clock_timing -type skew -nworst 10 

#save the block
saveDesign dB/RISC_V_cts.enc


