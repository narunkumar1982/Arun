read_design -physical_data /home/pd1/UART_Sep24/dB/UART_Sep24_post_route.enc.dat/ uart
read_spef -rc_corner Max_RC_Corner /home/pd1/UART_Sep24/outputs/rev_Max_0.spef.gz
read_spef -rc_corner Min_RC_Corner /home/pd1/UART_Sep24/outputs/rev_Min_0.spef.gz

read_sdf -view WC_Analysis /home/pd1/UART_Sep24/outputs/Max_rev_0.sdf
report_timing -late -max_paths 10 > /home/pd1/UART_Sep24/rpts/eco_timing_rpt/set_up_rev_0.rpt
report_timing -early  -max_paths 10 > /home/pd1/UART_Sep24/rpts/eco_timing_rpt/hold_rev_0.rpt
report_constraint -all_violators -drv_violation_type max_capacitance
report_constraint -all_violators -drv_violation_type max_transition
set_eco_opt_mode -save_eco_opt_db /home/pd1/UART_Sep24/dB
set timing_enable_simultaneous_setup_hold_mode true
write_eco_opt_db 
set_eco_opt_mode -load_eco_opt_db /home/pd1/UART_Sep24/dB

eco_opt_design -drv
eco_opt_design -setup
eco_opt_design -hold
#Command to remove previous design loaded
free_design


# Important Features:
To view the timing histogram in gui,(select Timing SI--> Debug timing and browse the timing report file (top.btarpt) 
-->from tempus tool main menu ).
It also guide you to identify the path is violating path or false path. 