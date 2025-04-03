#Use muliple CPU
setMultiCpuUsage -localCpu 2


# Restore the design place.enc
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_route.enc.dat CPU

# Route the Design to meet timing
optDesign -postRoute


#Timing Analysis
timeDesign -postRoute 
timeDesign -postRoute -hold   
timeDesign -postRoute -prefix postRoute -drvReports -expandReg2Reg -slackReports

#Dump the reports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_constraint.rpt
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_threshold_voltage.rpt
report_design > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_design_summary.rpt
reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/post_route_rpts/route_congestion.rpt
report_timing -nworst 10


# Add Filler Cells
setFillerMode -corePrefix FILL -core "FILL1 FILL2 FILL4 FILL8 FILL16"
addFiller -cell {FILL1 FILL2 FILL4 FILL8 FILL16} -prefix FILL



# Verification
verify_drc -limit 0
verify_drc -check_short_only -report myReport.txt
verifyGeometry
verifyConnectivity
PIC_Cntl_Flow
#Dump the reports
# Write out files in different formatASIC Design Exploration
# Writes out the pnr netlist
saveNetlist /home/pd1/RISC_V_31_05_24/outputs/RISC_V_route.v
# Writes out netlist with PG 
saveNetlist -includePowerGround /home/pd1/RISC_V_31_05_24/outputs/RISC_V_route_pg.v
# Writes out physical cell instances, and inserts power and ground nets in the netlist. 
# This is used for LVS and for designs with multiple supply voltages. 
# Hierarchical power and ground nets are also supported.
saveNetlist -phys /home/pd1/RISC_V_31_05_24/outputs/RISC_V_route_lvs.v

streamOut RISC_V.gds -mapFile streamOut.map -libName DesignLib -units 2000 -mode ALL -dieAreaAsBoundary
#save the block
saveDesign dB/RISC_V_post_route.enc


