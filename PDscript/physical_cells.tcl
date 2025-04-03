
#Place the physical cells

setMultiCpuUsage -localCpu 2

#Restore the design
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_power_plan.enc.dat CPU 

#Add EndCap & WellTap
setEndCapMode -leftEdge FILL2 -rightEdge FILL2
addEndCap -prefix PwrCap

set_well_tap_mode -insert_cells {FILL2 rule 24 boundary_layer B1 boundary_rule 5}
addWellTap -cell FILL2 -checkerBoard -cellinterval 36


#Check the endcap & Well-tap
verifyEndCap    
verifyWellTap

#Save the design
saveDesign dB/RISC_V_pre_place.enc

#Utilization report
reportdesignutil

#To delete well-tap cells, use the deleteFiller command.
#deleteFiller

           


