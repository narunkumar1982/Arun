create_ccopt_clock_tree -name clk_i -source clk_i -no_skew_group
create_ccopt_skew_group -name clk_i -sources clk_i -auto_sinks
add_ndr -name cts_2W2S  -spacing {Metal1 0.46 Metal2 0.56 Metal3 0.56 Metal4 0.56 Metal5 0.56 Metal6 0.92} -width {Metal1 0.46 Metal2 0.56 Metal3 0.56 Metal4 0.56 Metal5 0.56 Metal6 0.88}
create_route_type -name clkroute -non_default_rule cts_2W2S -preferred_routing_layer_effort high -top_preffered_layer Metal4 -bottom_preferred_layer Metal3 
set_ccopt_property route_type clkroute -net_type trunk
set_ccopt_property route_type clkroute -net_type leaf
set_ccopt_property buffer_cells {CLKBUFX8 CLKBUFX12}
set_ccopt_property inverter_cells {CLKINVX8 CLKINVX12}
set_ccopt_property target_skew 0.05 
set_ccopt_property target_insertion_delay 0.1
set_ccopt_property target_max_trans_sdc 0.5
#create_ccopt_clock_tree_spec -file ccopt.spec
#create_ccopt_clock_tree_spec -file ./results/ctsspec.tcl
#source ./results/ctsspec.tcl



#Declare the analysis views to be used during ccopt_design.
create_ccopt_clock_tree -name clk_i -source clk_i -no_skew_group
create_ccopt_skew_group -name clk_i -sources clk_i -auto_sinks
set_analysis_view  -setup WC -hold BC


#Define route types. A route type binds a non-default routing rule and preferred routing layers. NDRs can be defined via LEF or using the add_ndr command.
add_ndr -name cts_2W2S  -spacing {Metal1 0.46 Metal2 0.56 Metal3 0.56 Metal4 0.56 Metal5 0.56 Metal6 0.92} -width {Metal1 0.46 Metal2 0.56 Metal3 0.56 Metal4 0.56 Metal5 0.56 Metal6 0.88}
create_route_type -name leaf_rule -non_default_rule cts_2W2S  -top_preferred_layer Metal4 -bottom_preferred_layer Metal3
create_route_type -name trunk_rule -non_default_rule cts_2W2S -top_preferred_layer Metal4 -bottom_preferred_layer Metal3 -shield_net VSS
create_route_type -name top_rule -non_default_rule cts_2W2S -top_preferred_layer Metal4 -bottom_preferred_layer Metal3  -shield_net VSS

#Leaf nets – Any net that is connected to one or more clock tree sinks is a leaf net. By default, CCOpt-CTS and CCOpt will insert buffers so that no buffer drives both sinks and internal nodes.
#Trunk nets – Any net that is not a leaf net is by default a trunk net.
#Top nets – If you configure the routing_top_min_fanout property, then any trunk net which has a transitive fanout sink count higher than the configured count threshold will instead be a top net. For example, if the property is set to 10,000, then any trunk net that is above (in the clock tree fan-in cone) 10,000 or more sinks will be a top net.

#Specify that the route types defined above will be used for leaf, trunk, and top nets, respectively. Note that top routing rules will not be used unless the routing_top_min_fanout property is also set.
set_ccopt_property -net_type leaf route_type leaf_rule
set_ccopt_property -net_type trunk route_type trunk_rule
set_ccopt_property -net_type top route_type top_rule




#Configure library cells for CTS to use. In this example, the logic_cells property is not defined so when resizing existing logic cell instances CTS will use matching family cells which are not dont_use. The specification of a library cell overrides any dont_use setting for that library cell.
#get_ccopt_property -help buffer_cells

set_ccopt_property buffer_cells {CLKBUFX8 CLKBUFX12}
set_ccopt_property inverter_cells {CLKINVX8 CLKINVX12}
#set_ccopt_property clock_gating_cells {PREICGX12 PREICG8 PREICGX6 PREICGX4}


#Include this setting to use inverters in preference to buffers.
set_ccopt_property use_inverters true

#setOptMode for max_length and clock_spacing

setOptMode -maxLength 200 


#Controlling Useful Skew Effort in CCOpt
#The -usefulSkewCCOpt parameter of setOptMode specifies the level of useful skew effort applied during the ccopt_design or optDesign -postCTS commands. 
setOptMode -usefulSkew true
setOptMode -usefulSkewCCOpt extreme
setDesignMode -flowEffort extreme

#Configure the maximum transition target.
#set_ccopt_property target_max_trans 100ps
#set_ccopt_property target_max_cap 0.3pf
set_ccopt_property -delay_corner Max_Delay target_max_trans 500ps

#set_ccopt_property target_max_cap 0.3pf -delay_corner Max_delay

set_ccopt_property -delay_corner Min_Delay target_max_trans 400ps
#set_ccopt_property target_max_cap 0.3pf -delay_corner Min_delay


set_ccopt_property routing_top_min_fanout 2000

#Configure a skew target for CCOpt-CTS (ccopt_design -cts). This is ignored by CCOpt (ccopt_design).
#set_ccopt_property target_skew 50ps 
set_ccopt_property target_insertion_delay 250ps

set_ccopt_property -delay_corner Max_Delay target_skew 50ps
#set_ccopt_property -delay_corner Max_Delay target_insertion_delay 250ps

set_ccopt_property -delay_corner Min_Delay target_skew 30ps
#set_ccopt_property target_insertion_delay 150ps -delay_corner Min_Delay

#Use the following command to explore more details
set_ccopt_property -help target_insertion_delay

#CCOpt and CCOpt-CTS can be configured between cluster, trial, or full mode using the balance_mode CCOpt property. 
set_ccopt_property balance_mode cluster 

#CTS definitions for Stop pins- Example
set_ccopt_property sink_type -pin Inv1/A stop

#Skew Grouping
set_ccopt_property -skew_group clk_i target_skew 50ps



# for CELL Pin desity
set_ccopt_property cell_density 1
set_ccopt_property call_cong_repair_during_final_implementation true
  
  
  
  
#Transition Target
The maximum transition target to CCOpt is specified using the following command:
set_ccopt_property target_max_trans value
The value can be specified in library units, for example 100, or specified in explicit units for example 100ps, 0.1ns.
The transition target can be specified by net type, clock tree and per power domain. For example, it may be desirable to have a
tighter transition target at sink pins to improve flop CK->Q arc timing, but relax the transition target in trunk nets to reduce clock area
and power. Shielding and extra spacing could be used for trunk nets to further reduce clock power whilst avoiding signal integrity
problems. This example configures trunk nets to have a 150ps transition target whilst leaf nets have a 100ps transition target:
set_ccopt_property -net_type trunk target_max_trans 150ps
set_ccopt_property net_type leaf target_max_trans 100ps