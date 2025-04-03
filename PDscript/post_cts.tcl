setMultiCpuUsage -localCpu 4
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_cts.enc.dat CPU
# Create the CTS Specifications File
#source -e -v scripts/ccopt.spec

#Optimize the Design to meet timing
setOptMode -effort extreme
setOptMode -maxDensity 0.78
setOptMode -fixDRC true
setOptMode -fixFanoutLoad true
setOptMode -optimizeFF true
setOptMode -setupTargetSlack 0.0
setOptMode -holdTargetSlack 0.0
#setOptMode -holdFixingCells {BUFFX8 BUFFX12 DELAY2 DELAY3} (Command is not required if hold timing is met)
optDesign -postCTS

#Timing Analysis
timeDesign -postCTS 
timeDesign -postCTS -hold 
timeDesign -postCTS -prefix postcts -drvReports -expandReg2Reg -slackReports


#Dump the reports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_constraint.rpt
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_threshold_voltage.rpt
report_design > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_design_summary.rpt


reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_congestion.rpt
report_ccopt_clock_trees -file /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_clk_trees.rpt
report_ccopt_clock_tree_structure > /home/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_clk_tree_structure.rpt
report_ccopt_skew_groups -file /home/pd1/RISC_V_31_05_24/rpts/post_cts_rpts/postCTS_skew_groups.rpt
report_timing -nworst 10
report_clock_timing -type skew -nworst 10

#save the block
saveDesign dB/RISC_V_post_cts.enc

reportdesignutil 
