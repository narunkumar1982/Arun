#Invoke and validate the cadence license
source /home/cadence/source.sh

#Xcelium tool commands
xrun -64bit -gui -access +rw CPU_top.v RISC_CPU_tb.v

#Command to invoke genus tool
genus

#Disable the common_ui
set_db common_ui false

set Design CPU_dut
set Effort_level high
set Opt_FF extreme

#Library_setup_ispatial (Ensures Genus & Innovus library handling are consistent)
Note:- to be set before library loading, i.e., before init_design, or read_db
set_db library_setup_ispatial true

#Set the path for the std.cell library
set_db init_lib_search_path /root/home/cadence/dump/digitaltsmc180nm/slow.lib_cells
set_db init_lib_search_path /root/home/cadence/dump/digitaltsmc180nm/fast.lib

#Read the specified std.cell library from the specified library path
set_db library /home/cadence/dump/digitaltsmc180nm/slow.lib 
set_db library /home/cadence/dump/digitaltsmc180nm/fast.lib

#Read the LEF file 
set_db lef_library {tech.lef cell.lef}
read_physical -lef <lef_files>

#Read the Cap table or QRC file
set_db cap_table_file my.cap
            or
set_db qrc_tech_file techfile.qrc

#Read MMMC File
read_mmmc mmmc.tcl

#Read the floorplan
read_def def_file

#Set the path for the rtl file 
set_db init_hdl_search_path /root/home/pd1/RISC_V_31_05_24

#Partitioning is the process of disassembling (partitioning) designs into more manageable block sizes.
set_attribute auto_partition true


#Useful skew attribute (default true recommended)
set_db opt_spatial_useful_skew true


#Read the rtl design
read_hdl /home/pd1/RISC_V_31_05_24/CPU_top.v
#Constructs design hierarchy and connect signals
elaborate $Design  (Name of the Top module)
init_design
#Read the timing constraints
read_sdc /home/pd1/RISC_V_31_05_24/CPU.g

# set the path adjust to optimize timing (set_path_adjust command selectively 
to improve timing for certain  paths in timing-critical designs because it might increase area 
[A positive adjustment relaxes the clock constraint 
[It helps to meet the timing Ex: WNS= -1182 to 3928.7 by using the command with positive value]
and a negative adjustment tightens it.])


set_path_adjust -from [all_registers] -to [all_registers] -exception_name C2C 0.1
set_path_adjust -from [all_registers] -to [all_outputs] -exception_name C2O 2.0
set_path_adjust -from [all_inputs] -to [all_outputs] -exception_name I2O 2.0 


#Path_group
define_cost_group -name I2O -weight 50
define_cost_group -name C2O -weight 50
define_cost_group -name C2C -weight 10
path_group -from [all_inputs] -to [all_outputs] -group I2O
path_group -from [all_registers] -to [all_outputs] -group C2O
path_group -from [all_registers] -to [all_registers] -group C2C

#Specify the power unit
set_attribute lp_power_unit uW 
set_db design_power_effort low
set_db opt_leakage_to_dynamic_ratio 1.0


# physical flow attributes 
set_db design_process_node 180
set_db number_of_routing_layers 9



#Commands and attributes that let you achieve better area results:
set_db syn_generic_effort $Effort_level
set_db syn_map_effort $Effort_level
#Effort level for spatial optimization flow (none, standard, extreme).
set_db opt_spatial_effort $Opt_FF

#Annotate switching activities.
read_tcf /home/pd1/counter/CPU_dut.tcf

#RTL code is map with default library by tool
syn_generic -physical
#Genus maps the generic gate­level netlist to the technology library cells
syn_map -physical
#This step primarily performs  more advanced timing optimization, area optimization and fix DRC violations
syn_opt -ispatial

#To make Genus work on all the paths to reduce the total negative slack (TNS), instead of just WNS:
set_attr tns_opto true

# Disable:
set_attribute hdl_preserve_unused_register true
set_attribute delete_unloaded_seqs false
set_attribute optimize_constant_0_flops false
set_attribute optimize_constant_1_flops false
#set_attribute prune_unsued_logic false


#Generate the various Timing, power, area & DRV reports
report_timing -lint > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_top_timing.rpt
report_timing_summary > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_top_timing_summary.rpt
report_timing -worst 10 > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_top_timing_worst_path.rpt   (List the worst case timing paths interms negative slack only)
report_timing -num_paths 20   (List the timing paths interms of negative and positive slack)
report_qor > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_QoR.rpt
report_constraint -drv_violation_type max_transition > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_max_tran.rpt
report_constraint -drv_violation_type max_capacitance > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_max_cap.rpt
report_area > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_top_area.rpt
report_power > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_top_power.rpt
report power -level 3
report_gates > /home/pd1/RISC_V_31_05_24/rpts/synthesis/CPU_top_gates.rpt
check_design
gui_show

#Export timing constarints, netlist & sdf file
#write_sdc > CPU_top_4.sdc
#write_hdl > CPU_top_gate_level_netlist_4.v
#write_sdf -design CPU > /home/pd1/RISC_V_31_05_24/CPU_top_4.sdf

#write handoff DB for INVS prects
write_design -innovus -db -base_name ./final_db/design 


#Command to create tcf (Toggle Count Format) file
dumptcf -scope CPU_tb -output CPU_dut.tcf -overwrite -flatformat -dumpwireasnet
run 10 us
dumptcf -end



# set weight has been limited ot a 13% of leakage power
To control how leakage and dynamic power are optimized, set the 'opt_leakage_to_dynamic_ratio' design attribute.
#set_attribute lp_power_optimization_weight 0.13 /designs/CPU ---Obsolete
set_attribute opt_leakage_to_dynamic_ratio 0.13 
#specify leakage power constraint
set_attribute lp_leakage_power 1 /designs/CPU (Use tab after slash)
#specify dynamic power constraint
set_attribute max_dynamic_power 30 /designs/CPU (Use tab after slash)
#set_attribute lp_optimize_dynamic_power_first 
set_attribute lp_optimize_dynamic_power_first true /designs/CPU (Use tab after slash)




References Power Commands
set_attribute max_leakage_power < POWER IN nW > /< MODULE IN HIERARCHY >
set_attribute max_dynamic_power < POWER IN nW > /< MODULE IN HIERARCHY >
set_attribute lp_power_optimization_weight < BETWEEN 0 AND 1 > /< MODULE IN HIERARCHY >


Sample Power Optimization Flow Script
A recommended script for power optimization flow is given below.
< … read all library and design data …>
init_design

# read activity data
read_vcd top.pwr_bm.vcd

# enable high-effort power optimization
set_db design_power_effort high

# optimize for both leakage and dynamic power equally
set_db opt_leakage_to_dynamic_ratio 0.5

# restrict usage of ultra-low Vt cells
set_dont_use [get_db base_cells *ULVT*] true
set_db opt_high_effort_lib_cells [get_db lib_cells *ULVT*]

# run early-physical flow
syn_generic -physical
syn_map -physical

# run dedicated logical incremental opt (optional)
syn_opt

# call iSpatial flow
syn_opt -spatial

# report power
report_power





command to know the exact syntax:
type- help path_group


To use man pages from UNIX shell:
Set your environment to view the correct directory: 
setenv MANPATH $CDN_SYNTH_ROOT/share/synth/man_common
Access the manpage by either of the following ways:
Enter the name of the command or attribute that you want. For example:
man report_timing

