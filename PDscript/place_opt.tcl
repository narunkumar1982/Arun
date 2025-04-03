#Enable multiple CPU option
setMultiCpuUsage -localCpu 4


# Restore the design place.enc
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_place.enc.dat CPU

setDontUse *XL true
setDontUse *X1 true 

#To perform rapid timing optimization for design prototyping, use the following commands:    
To optimize timing using low-effort mode for design prototyping, use the following commands:
In low-effort mode, optDesign resizes gates and performs global buffer insertion and repair DRVs, 
but does not restructure the netlist.
setDesignMode -flowEffort extreme

#placement_optimization
setOptMode -maxDensity 0.78
setOptMode -setupTargetSlack 0.0
setOptMode -usefulSkewPreCTS false
setOptMode -holdTargetSlack 0.0
#setUsefulSkewMode -minAllowedDelay 0.03



#Optimize the std.cells placement to meet timing
optDesign -preCTS
    Or
place_opt_design


#Add Spare cells
createSpareModule -moduleName my_spare -cell {NOR2X1 3 NANDX1 5 INVX2 5}
placeSpareModule -moduleName my_spare -stepx 50 -stepy 50 -offsetx 5 -offsety 5
#instantiates a created spare module, and places spare modules across the design. 


#Add TIE Cells
addTieHiLo -cell "TIEHI TIELO"
verifyTieCell

#Timing Analysis
timeDesign -preCTS 
timeDesign -preCTS -prefix preCTS -drvReports -expandReg2Reg -slackReports
timeDesign -numpaths 50 -preCTS -drvReports

#Dump the reports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/constraint.rpt
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/threshold_voltage.rpt
report_design > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/design_summary.rpt
reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/congestion.rpt

#Report the design utilization
reportdesignutil 

#Report the density map
reportDensityMap

#Report the congestion hotspot score
reportCongestion -hotSpot -3d

-hotSpot	
Reports the local hotspot score. It reports the maximum and total hotspot area.
Hotspot score refers to the contiguous area of gcells (there is some normalization done internally) which have routing overflow. 
Typically, a max hotspot score < 100 indicates that the design is routable.
Max hotspot – It is the largest contiguous area of gcells with overflow
Total hotspot – It is the total of all hotspots
Greater the number of adjacent gcells with overflow, bigger will be the hotspot.
Note: You can use this parameter to view the congestion hotspot regions seen by the router after global route.
Honors 3d congestion map. When specified, it enables the layer-based congestion reporting.


#save the block
saveDesign dB/RISC_V_post_place.enc

