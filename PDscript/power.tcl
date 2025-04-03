#Power Planning
setMultiCpuUsage -localCpu 2
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_io.enc.dat CPU

clearGlobalNets
globalNetConnect VDD -type pgpin -pin vdd! -all
globalNetConnect VSS -type pgpin -pin gnd! -all
globalNetConnect VDD -type tiehi
globalNetConnect VSS -type tielo


# ADD RING
#The following command adds a core ring to the vdd and gnd nets on layers METAL5 and METAL6:
addRing -nets {VSS VDD} -width 5 -layer {top Metal5 left Metal6 bottom Metal5  right  Metal6}  -offset 2 -spacing 1
#This ring is centered between the I/O pad area and the core boundary, has a width of 5 μm, and is located at least 2 μm away from any other ring.


# ADD STRIPES
#The following command adds stripes in the vertical direction for the vdd and gnd nets:
addStripe -direction vertical -nets {VDD VSS} -width 5 -spacing 1 -layer Metal5 -start_offset 20  -set_to_set_distance 40


#ADD power rails
sroute -connect {blockPin padPin padRing corePin floatingStripe } -allowjogging true -allowlayerChange true -blockPin useLef -targetviaLayerRange {M1 M6} 


#VIAGEN Engine: Use it for special via insertion. The VIAGEN Engine:

#PG_Checks:-
CheckDesign -all
timeDesign -preplace

#Check the PowerVia violations
verifyPowerVia 

#Check PG shorts and opens
verify_PG_short 
verifyConnectivity -allPGPinPort

#Save the design
saveDesign dB/RISC_V_power_plan.enc

reportdesignutil





  
  
  
  
  
  
