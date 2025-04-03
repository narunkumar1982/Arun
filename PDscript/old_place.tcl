
setMultiCpuUsage -localCpu 4


# Restore the design place.enc
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_pre_place.enc.dat CPU

setDontUse *XL true
setDontUse *X1 true 

#Controls the maximum density of local bins during global placement. 
Sets the maximum density of core area so that the placement engine satisfies the maximum density constraint 
while working on timing, wire length, and congestion.#Use a value between 0 (zero percent) and 1 (100 percent). 
For example, a value of 0.5 indicates that the maximum density in the entire design will be 50 percent or less.
#Default: -1.000
#Note: It is recommended that the place_global_max_density value 
should be greater than standard cell utilization of design.
#Note: Using this option might degrade congestion and timing QOR of Global placement.

setPlaceMode -place_global_max_density 0.72
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_global_timing_effort high
#Enable even cell distribution for designs with less than 70% utilization.
setPlaceMode -place_global_uniform_density true



#defIn cordic_scan.def
#A design does not have a scan chain, use the following command
setPlaceMode -place_global_ignore_scan false 

#To perform rapid timing optimization for design prototyping, use the following commands:    
To optimize timing using low-effort mode for design prototyping, use the following commands:
setDesignMode -flowEffort express
optDesign -preCTS
In low-effort mode, optDesign resizes gates and performs global buffer insertion and repair DRVs, but does not restructure the netlist.



#Place the std.cells
place_design
#unplaceAllInsts (Remove Placement)


#placement_optimization
setMultiCpuUsage -localCpu 4
setOptMode -maxDensity 0.78
setOptMode -setupTargetSlack 0.0
setOptMode -usefulSkewPreCTS false
setOptMode -holdTargetSlack 0.0
setUsefulSkewMode -minAllowedDelay 0.03
setDesignMode -flowEffort express
optDesign -preCTS
timeDesign -preCTS 
timeDesign -preCTS -prefix preCTS -drvReports -expandReg2Reg -slackReports
timeDesign -numpaths 50 -preCTS -drvReports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/constraint.rpt
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/threshold_voltage.rpt

report_design > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/design_summary.rpt
reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/post_place_rpts/congestion.rpt
reportdesignutil 

#save the block
saveDesign dB/RISC_V_post_place.enc

#createRegion core1/rv_cpu_genblk2.pcpi_div 594.0 750.96 596.64 756.0
#createFence core1/rv_cpu_genblk2.pcpi_div 25.0815 -254.131 0.0 0.0
#createFence core1/rv_cpu_genblk1.pcpi_mul -53.515 -161.823 0.0 0.0
#createFence core1/spimemio -65.326 -168.572 0.0 0.0
#createFence sram -85.573 -170.2595 0.0 0.0
#unplaceGuide/fence rv_cpu_genblk2.pcpi_di  (to unplace the fence)


 


#Optimize the std.cells placement to meet timing
#optDesign -preCTS
#    Or
#place_opt_design


#Add Spare cells
#createSpareModule -moduleName my_spare -cell {NOR2X1 3 NANDX1 5 INVX2 5}
#placeSpareModule -moduleName my_spare -stepx 50 -stepy 50 -offsetx 5 -offsety 5
#instantiates a created spare module, and places spare modules across the design. 


#Add TIE Cells
#addTieHiLo -cell "TIEHI TIELO"
#verifyTieCell

#Timing Analysis
timeDesign -preCTS 
timeDesign -preCTS -prefix preCTS -drvReports -expandReg2Reg -slackReports
timeDesign -numpaths 50 -preCTS -drvReports




#Dump the reports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/constraint.rpt
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/threshold_voltage.rpt

report_design > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/design_summary.rpt
reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/congestion.rpt
reportdesignutil 

reportDensityMap

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


#Placement Blockage
createPlaceBlockage -type soft -box { { 584.94 725.76 786.54 846.72 } } -name softBlockage1
createPlaceBlockage -type soft -box { { 267.8165 626.3295 320.9265 675.646 } } -name softBlockage2
createPlaceBlockage -type soft -box { { 422.0885 776.8075 467.6115 824.8595 } } -name softBlockage3
createPlaceBlockage -type soft -box { { 723.045 272.263 769.8325 322.8435 } } -name softBlockage4


gui_select -rect {262.38 766.08 302.70 806.40} (To see the co-ordinate location in Gui}


#setPathGroupOptions reg2reg -effortLevel high
#group_path -name reg2reg -from all_registers -to all_registers
#setPathGroupOptions reg2reg -effortLevel high -targetSlack 0.0 -weight 50.0


#save the block
saveDesign dB/RISC_V_place.enc



Command Order
Run this command after running createSpareModule.

Examples
The following command instantiates module mod1 and places the instantiations at intervals of 50 microns along the x and y axis. It places the instantiations at an offset of 5 microns from the left core boundary and the bottom core boundary:
placeSpareModule -moduleName mod1 -stepx 50 -stepy 50 -offsetx 5 -offsety 5
The following commands create spare module SPGM with cells DFFNSRX2, INVX4, and NOR2X2 using clock net sysclk; then instantiates module SPGMand places the instantiations between channels that are between 4.7 um and 10.0 um wide and at least 11.0 um long. The step size is 10 um in the x direction and 10 um in the y direction and the maximum utilization rate is 60 percent:
createSpareModule -moduleName SPGM -cell {DFFNSRX2 INVX4 \
  NOR2X2} -clock sysclk
placeSpareModule -moduleName SPGM -channel -minWidth 4.7 -maxWidth 10 \
  -minLength 11 -stepx 10 -stepy 10 -util 0.6
  
  
  
  
  