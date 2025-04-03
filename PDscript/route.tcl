
#Use muliple CPU
setMultiCpuUsage -localCpu 4

# Restore the design place.enc
#restoreDesign /home/pd1/RISC_V_31_05_24/dB/RISC_V_post_cts.enc.dat CPU

# Routing settings
setDesignMode -flowEffort extreme
setNanoRouteMode -routeWithTimingDriven true
setNanoRouteMode -routeWithSiDriven true
setAnalysisMode -analysisType onChipVariation -cppr both
setNanoRouteMode -drouteFixAntenna true
setNanoRouteMode -routeInsertAntennaDiode true
setOptMode -fixSISlew true
#setNanoRouteMode -routeDesignFixClockNets true 
#setAttribute -net n_1 -top_preferred_routing_layer Metal3 -bottom_preferred_routing_layer Metal2 -preferred_routing_layer_effort high
setRouteMode -earlyGlobalEffortLevel medium
# Route the Design to meet timing
routeDesign -globalDetail

#optDesign -postRoute


#Timing Analysis
timeDesign -postRoute 
timeDesign -postRoute -hold 
timeDesign -postRoute -prefix postRoute -drvReports -expandReg2Reg -slackReports

#Dump the reports
report_constraint > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_constraint.rpt
reportTranViolation > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_tran_viol.rpt
reportCapViolation > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_cap_viol.rpt
reportGateCount > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_gate_count.rpt
reportVtInstCount > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_threshold_voltage.rpt
report_design > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_design_summary.rpt
reportCongestion -overflow > /home/pd1/RISC_V_31_05_24/rpts/route_rpts/route_congestion.rpt
report_timing -nworst 10


#save the block
saveDesign dB/RISC_V_route.enc











# Try the following commands
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithSiDriven 1
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail


setEndCapMode -reset
setEndCapMode -boundary_tap false
setNanoRouteMode -quiet -routeAntennaCellName {}
setUsefulSkewMode -maxSkew false -noBoundary false -useCells {dl04d1 bufbd7 buffd2 dl03d1 bufbdf buffda dl02d2 dl03d4 dl04d2 dl02d1 dl01d4 buffd3 bufbda bufbdk buffd4 dl04d4 dl02d4 bufbd4 dl01d2 bufbd3 bufbd1 dl01d1 buffd7 bufbd2 buffd1 dl03d2 inv0d2 invbda inv0da invbdk inv0d1 inv0d7 invbd4 invbd2 inv0d0 invbd7 invbdf inv0d4} -maxAllowedDelay 1
setNanoRouteMode -quiet -routeAntennaCellName adiode
setNanoRouteMode -quiet -routeTdrEffort 5
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true
routeDesign -globalDetail -viaOpt -wireOpt

### Post Route Anlysis.......0.0
setAnalysisMode -analysisType onChipVariation
timeDesign -postRoute
## optional when there is any violation....
 optDesign -postRoute -hold

timeDesign -postRoute 
report_timing
setAnalysisMode -checkType hold
report_timing 
report_power
report_constraint -all_violators
report_ccopt_skew_groups

### Metal Fill..
addFiller -cell feedth9 -prefix FILLER -doDRC
addFiller -cell feedth3 -prefix FILLER -doDRC
addFiller -cell feedth -prefix FILLER -doDRC

###Verify Geometry
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }

###Verify DRC
get_verify_drc_mode -disable_rules -quiet
get_verify_drc_mode -quiet -area
get_verify_drc_mode -quiet -layer_range
get_verify_drc_mode -check_implant -quiet
get_verify_drc_mode -check_implant_across_rows -quiet
get_verify_drc_mode -check_ndr_spacing -quiet
get_verify_drc_mode -check_only -quiet
get_verify_drc_mode -check_same_via_cell -quiet
get_verify_drc_mode -exclude_pg_net -quiet
get_verify_drc_mode -ignore_trial_route -quiet
get_verify_drc_mode -max_wrong_way_halo -quiet
get_verify_drc_mode -use_min_spacing_on_block_obs -quiet
get_verify_drc_mode -limit -quiet
set_verify_drc_mode -disable_rules {} -check_implant true -check_implant_across_rows false -check_ndr_spacing false -check_same_via_cell false -exclude_pg_net false -ignore_trial_route false -report test.drc.rpt -limit 1000
verify_drc
set_verify_drc_mode -area {0 0 0 0}

###Verify Connectivity
verifyConnectivity -type all -error 1000 -warning 50

saveNetlist omp_post_layout.v

### Save DEF file
set dbgLefDefOutVersion 5.8
global dbgLefDefOutVersion
set dbgLefDefOutVersion 5.8
defOut -floorplan -netlist -routing omp_post_layout.def
set dbgLefDefOutVersion 5.8
set dbgLefDefOutVersion 5.8

### GDS file Stream 
streamOut omp_gds.gds -mapFile libraries/lef/gds2_fe_4l.map -libName DesignLib -units 20000 -mode ALL
streamOut omp_gds.gds -mapFile libraries/lef/gds2_fe_4l.map -libName DesignLib -merge { libraries/tsl18fs120.gds libraries/tsl18cio250_4lm.gds } -units 20000 -mode ALL