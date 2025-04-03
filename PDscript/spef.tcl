 setDesignMode -process 180

setExtractRCMode -engine postRoute -effortLevel low
extractRC
rcOut -rc_corner Max_RC_Corner -spef /home/pd1/RISC_V_31_05_24/outputs/Max_RC_Corner_Outputs/Max_rev_0.spef.gz
rcOut -rc_corner Min_RC_Corner -spef /home/pd1/RISC_V_31_05_24/outputs/Max_RC_Corner_Outputs/Min_rev_o.spef.gz
write_sdf -interconn all -setuphold split -max_view WC_Analysis /home/pd1/RISC_V_31_05_24/outputs/Max_RC_Corner_Outputs/Max_rev_0.sdf
write_sdf -interconn all -setuphold split -min_view BC_Analysis /home/pd1/RISC_V_31_05_24/outputs/Max_RC_Corner_Outputs/Min_rev_0.sdf


rcOut -rc_corner Max_RC_Corner -spef /home/pd1/RISC_V_31_05_24/outputs/Min_RC_Corner_Outputs/Max_rev_0.spef.gz
rcOut -rc_corner Min_RC_Corner -spef /home/pd1/RISC_V_31_05_24/outputs/Min_RC_Corner_Outputs/Min_rev_o.spef.gz
write_sdf -interconn all -setuphold split -max_view WC_Analysis /home/pd1/RISC_V_31_05_24/outputs/Min_RC_Corner_Outputs/Max_rev_0.sdf
write_sdf -interconn all -setuphold split -min_view BC_Analysis /home/pd1/RISC_V_31_05_24/outputs/Min_RC_Corner_Outputs/Min_rev_0.sdf