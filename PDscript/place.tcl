#Enable multiple CPU option
setMultiCpuUsage -localCpu 4

# Restore the design place.enc
restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_pre_place.enc.dat CPU

# Dont use cells
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

#Controls the congestion hotspot score the timing targetslack
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_global_timing_effort high

#Enable even cell distribution for designs with less than 70% utilization.
setPlaceMode -place_global_uniform_density true

#Load the scan chain def file
defIn cordic_scan.def

#A design does not have a scan chain, use the following command
setPlaceMode -place_global_ignore_scan true 

#Place the std.cells
place_design

#To remove the placed std.cells
unplaceAllInsts 


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
reportCongestion -overflow -hotspot > /home/pd1/RISC_V_31_05_24/rpts/place_rpts/congestion.rpt

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


#Placement Blockage
createPlaceBlockage -type soft -box {328.02 599.76 345.84 604.8} -name softBlockage5
createPlaceBlockage -type soft -box {584.94 725.76 786.54 846.72} -name softBlockage1
createPlaceBlockage -type soft -box {267.8165 626.3295 320.9265 675.646} -name softBlockage2
createPlaceBlockage -type soft -box {422.0885 776.8075 467.6115 824.8595} -name softBlockage3
createPlaceBlockage -type soft -box {23.045 272.263 769.8325 322.8435} -name softBlockage4

#06-08-24
createPlaceBlockage -type soft -box {766.38 342.72 806.70 383.04} -name softblockage8
createPlaceBlockage -type soft -box {685.74 524.16 726.06 564.48} -name softBlockage6


# Select the particular area by using mouse then right click on the mouse and 
select attribute editor or press "Q", able to see the co-ordinates in the BOX tab {671.919 374.1955 720.256 417.162}
gui_select -rect {272.69 626.623 322.8175 669.5895}
gui_select -rect {262.38 766.08 302.70 806.40} (To see the co-ordinate location in Gui}
gui_select -rect {328.02 599.76 345.84 604.8}
#06-08-24
gui_select -rect {766.38   342.72   806.70   383.04}
gui_select -rect {685.74   524.16   726.06   564.48}
#To meet the timing target use path grouping technique (Execute the following commands one after another)

group_path -name reg2reg -from all_registers -to all_registers
setPathGroupOptions reg2reg -effortLevel high
setPathGroupOptions reg2reg -late -effortLevel high -targetSlack 0.0 -weight 50 (Dont copy paste, type the command in the console)

#save the block
saveDesign dB/RISC_V_place.enc




  
  
  
  
  