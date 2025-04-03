#setPlaceMode -placeIOpins 1
assignIoPins
#create_pin -name PIN_NAME -location {X Y} -layer METAL_LAYER -direction INPUT/OUTPUT/INOUT

# Manual Pin Placement
create_pin -name clk -location {100 950} -layer metal1 -direction INPUT
create_pin -name rst -location {200 950} -layer metal1 -direction INPUT
create_pin -name data_in -location {300 950} -layer metal1 -direction INPUT
create_pin -name data_out -location {400 50} -layer metal1 -direction OUTPUT

# Alternatively, Automatic Pin Placement
# place_pins -type io -spacing 10 -hor_edge_type alternate -ver_edge_type alternate -start_corner lower_left
#place_pins -type io -order top_down -group_by side -step 100


#Creates a pin group for a partition or for the top-level
createPinGroup {M_2 -pin{value_o[5] easter_egg[1] address[4] easter_egg[0] value_o[4] clk_i DataOrReg}} -optimizeOrder 
createPinGroup {M_6 -pin{value_o[7] address[0] instr_i[1] reset}} -optimizeOrder 



#To speed up, if you have to run multiple editPin commands then wrap all editPin commands within 'setPinAssignMode -pinEditInBatch true' (then editPin commands)
setPinAssignMode -pinEditInBatch true 
getPinAssignMode -pinEditInBatch -quiet
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 2 -spreadType center -spacing 2 -pin {{axi_req_o[0]} {axi_req_o[1]} {axi_req_o[2]} {axi_req_o[3]} {axi_req_o[4]} {axi_req_o[5]} {axi_req_o[6]} {axi_req_o[7]} {axi_req_o[8]} {axi_req_o[9]} {axi_req_o[10]} {axi_req_o[11]} {axi_req_o[12]} {axi_req_o[13]} {axi_req_o[14]} {axi_req_o[15]} {axi_req_o[16]} {axi_req_o[17]} {axi_req_o[18]} {axi_req_o[19]} {axi_req_o[20]} {axi_req_o[21]} {axi_req_o[22]} {axi_req_o[23]} {axi_req_o[24]} {axi_req_o[25]} {axi_req_o[26]} {axi_req_o[27]} {axi_req_o[28]} {axi_req_o[29]} {axi_req_o[30]} {axi_req_o[31]} {axi_req_o[32]} {axi_req_o[33]} {axi_req_o[34]} {axi_req_o[35]} {axi_req_o[36]} {axi_req_o[37]} {axi_req_o[38]} {axi_req_o[39]} {axi_req_o[40]} {axi_req_o[41]} {axi_req_o[42]} {axi_req_o[43]} {axi_req_o[44]} {axi_req_o[45]} {axi_req_o[46]} {axi_req_o[47]} {axi_req_o[48]} {axi_req_o[49]} {axi_req_o[50]} {axi_req_o[51]} {axi_req_o[52]} {axi_req_o[53]} {axi_req_o[54]} {axi_req_o[55]} {axi_req_o[56]} {axi_req_o[57]} {axi_req_o[58]} {axi_req_o[59]} {axi_req_o[60]} {axi_req_o[61]} {axi_req_o[62]} {axi_req_o[63]} {axi_req_o[64]} {axi_req_o[65]} {axi_req_o[66]} {axi_req_o[67]} {axi_req_o[68]} {axi_req_o[69]} {axi_req_o[70]} {axi_req_o[71]} {axi_req_o[72]} {axi_req_o[73]} {axi_req_o[74]} {axi_req_o[75]} {axi_req_o[76]} {axi_req_o[77]} {axi_req_o[78]} {axi_req_o[79]} {axi_req_o[80]} {axi_req_o[81]} {axi_req_o[82]} {axi_req_o[83]} {axi_req_o[84]} {axi_req_o[85]} {axi_req_o[86]} {axi_req_o[87]} {axi_req_o[88]} {axi_req_o[89]} {axi_req_o[90]} {axi_req_o[91]} {axi_req_o[92]} {axi_req_o[93]} {axi_req_o[94]} {axi_req_o[95]} {axi_req_o[96]} {axi_req_o[97]} {axi_req_o[98]} {axi_req_o[99]} {axi_req_o[100]} {axi_req_o[101]} {axi_req_o[102]} {axi_req_o[103]} {axi_req_o[104]} {axi_req_o[105]} {axi_req_o[106]} {axi_req_o[107]} {axi_req_o[108]} {axi_req_o[109]} {axi_req_o[110]} {axi_req_o[111]} {axi_req_o[112]} {axi_req_o[113]} {axi_req_o[114]} {axi_req_o[115]} {axi_req_o[116]} {axi_req_o[117]} {axi_req_o[118]} {axi_req_o[119]} {axi_req_o[120]} {axi_req_o[121]} {axi_req_o[122]} {axi_req_o[123]} {axi_req_o[124]} {axi_req_o[125]} {axi_req_o[126]} {axi_req_o[127]} {axi_req_o[128]} {axi_req_o[129]} {axi_req_o[130]} {axi_req_o[131]} {axi_req_o[132]} {axi_req_o[133]} {axi_req_o[134]} {axi_req_o[135]} {axi_req_o[136]} {axi_req_o[137]} {axi_req_o[138]} {axi_req_o[139]} {axi_req_o[140]} {axi_req_o[141]} {axi_req_o[142]} {axi_req_o[143]} {axi_req_o[144]} {axi_req_o[145]} {axi_req_o[146]} {axi_req_o[147]} {axi_req_o[148]} {axi_req_o[149]} {axi_req_o[150]} {axi_req_o[151]} {axi_req_o[152]} {axi_req_o[153]} {axi_req_o[154]} {axi_req_o[155]} {axi_req_o[156]} {axi_req_o[157]} {axi_req_o[158]} {axi_req_o[159]} {axi_req_o[160]} {axi_req_o[161]} {axi_req_o[162]} {axi_req_o[163]} {axi_req_o[164]} {axi_req_o[165]} {axi_req_o[166]} {axi_req_o[167]} {axi_req_o[168]} {axi_req_o[169]} {axi_req_o[170]} {axi_req_o[171]} {axi_req_o[172]} {axi_req_o[173]} {axi_req_o[174]} {axi_req_o[175]} {axi_req_o[176]} {axi_req_o[177]} {axi_req_o[178]} {axi_req_o[179]} {axi_req_o[180]} {axi_req_o[181]} {axi_req_o[182]} {axi_req_o[183]} {axi_req_o[184]} {axi_req_o[185]} {axi_req_o[186]} {axi_req_o[187]} {axi_req_o[188]} {axi_req_o[189]} {axi_req_o[190]} {axi_req_o[191]} {axi_req_o[192]} {axi_req_o[193]} {axi_req_o[194]} {axi_req_o[195]} {axi_req_o[196]} {axi_req_o[197]} {axi_req_o[198]} {axi_req_o[199]} {axi_req_o[200]} {axi_req_o[201]} {axi_req_o[202]} {axi_req_o[203]} {axi_req_o[204]} {axi_req_o[205]} {axi_req_o[206]} {axi_req_o[207]} {axi_req_o[208]} {axi_req_o[209]} {axi_req_o[210]} {axi_req_o[211]} {axi_req_o[212]} {axi_req_o[213]} {axi_req_o[214]} {axi_req_o[215]} {axi_req_o[216]} {axi_req_o[217]} {axi_req_o[218]} {axi_req_o[219]} {axi_req_o[220]} {axi_req_o[221]} {axi_req_o[222]} {axi_req_o[223]} {axi_req_o[224]} {axi_req_o[225]} {axi_req_o[226]} {axi_req_o[227]} {axi_req_o[228]} {axi_req_o[229]} {axi_req_o[230]} {axi_req_o[231]} {axi_req_o[232]} {axi_req_o[233]} {axi_req_o[234]} {axi_req_o[235]} {axi_req_o[236]} {axi_req_o[237]} {axi_req_o[238]} {axi_req_o[239]} {axi_req_o[240]} {axi_req_o[241]} {axi_req_o[242]} {axi_req_o[243]} {axi_req_o[244]} {axi_req_o[245]} {axi_req_o[246]} {axi_req_o[247]} {axi_req_o[248]} {axi_req_o[249]} {axi_req_o[250]} {axi_req_o[251]} {axi_req_o[252]} {axi_req_o[253]} {axi_req_o[254]} {axi_req_o[255]} {axi_req_o[256]} {axi_req_o[257]} {axi_req_o[258]} {axi_req_o[259]} {axi_req_o[260]} {axi_req_o[261]} {axi_req_o[262]} {axi_req_o[263]} {axi_req_o[264]} {axi_req_o[265]} {axi_req_o[266]} {axi_req_o[267]} {axi_req_o[268]} {axi_req_o[269]} {axi_req_o[270]} {axi_req_o[271]} {axi_req_o[272]} {axi_req_o[273]} {axi_req_o[274]} {axi_req_o[275]} {axi_req_o[276]} {axi_req_o[277]} {axi_resp_i[0]} {axi_resp_i[1]} {axi_resp_i[2]} {axi_resp_i[3]} {axi_resp_i[4]} {axi_resp_i[5]} {axi_resp_i[6]} {axi_resp_i[7]} {axi_resp_i[8]} {axi_resp_i[9]} {axi_resp_i[10]} {axi_resp_i[11]} {axi_resp_i[12]} {axi_resp_i[13]} {axi_resp_i[14]} {axi_resp_i[15]} {axi_resp_i[16]} {axi_resp_i[17]} {axi_resp_i[18]} {axi_resp_i[19]} {axi_resp_i[20]} {axi_resp_i[21]} {axi_resp_i[22]} {axi_resp_i[23]} {axi_resp_i[24]} {axi_resp_i[25]} {axi_resp_i[26]} {axi_resp_i[27]} {axi_resp_i[28]} {axi_resp_i[29]} {axi_resp_i[30]} {axi_resp_i[31]} {axi_resp_i[32]} {axi_resp_i[33]} {axi_resp_i[34]} {axi_resp_i[35]} {axi_resp_i[36]} {axi_resp_i[37]} {axi_resp_i[38]} {axi_resp_i[39]} {axi_resp_i[40]} {axi_resp_i[41]} {axi_resp_i[42]} {axi_resp_i[43]} {axi_resp_i[44]} {axi_resp_i[45]} {axi_resp_i[46]} {axi_resp_i[47]} {axi_resp_i[48]} {axi_resp_i[49]} {axi_resp_i[50]} {axi_resp_i[51]} {axi_resp_i[52]} {axi_resp_i[53]} {axi_resp_i[54]} {axi_resp_i[55]} {axi_resp_i[56]} {axi_resp_i[57]} {axi_resp_i[58]} {axi_resp_i[59]} {axi_resp_i[60]} {axi_resp_i[61]} {axi_resp_i[62]} {axi_resp_i[63]} {axi_resp_i[64]} {axi_resp_i[65]} {axi_resp_i[66]} {axi_resp_i[67]} {axi_resp_i[68]} {axi_resp_i[69]} {axi_resp_i[70]} {axi_resp_i[71]} {axi_resp_i[72]} {axi_resp_i[73]} {axi_resp_i[74]} {axi_resp_i[75]} {axi_resp_i[76]} {axi_resp_i[77]} {axi_resp_i[78]} {axi_resp_i[79]} {axi_resp_i[80]} {axi_resp_i[81]} {boot_addr_i[0]} {boot_addr_i[1]} {boot_addr_i[2]} {boot_addr_i[3]} {boot_addr_i[4]} {boot_addr_i[5]} {boot_addr_i[6]} {boot_addr_i[7]} {boot_addr_i[8]} {boot_addr_i[9]} {boot_addr_i[10]} {boot_addr_i[11]} {boot_addr_i[12]} {boot_addr_i[13]} {boot_addr_i[14]} {boot_addr_i[15]} {boot_addr_i[16]} {boot_addr_i[17]} {boot_addr_i[18]} {boot_addr_i[19]} {boot_addr_i[20]} {boot_addr_i[21]} {boot_addr_i[22]} {boot_addr_i[23]} {boot_addr_i[24]} {boot_addr_i[25]} {boot_addr_i[26]} {boot_addr_i[27]} {boot_addr_i[28]} {boot_addr_i[29]} {boot_addr_i[30]} {boot_addr_i[31]} {boot_addr_i[32]} {boot_addr_i[33]} {boot_addr_i[34]} {boot_addr_i[35]} {boot_addr_i[36]} {boot_addr_i[37]} {boot_addr_i[38]} {boot_addr_i[39]} {boot_addr_i[40]} {boot_addr_i[41]} {boot_addr_i[42]} {boot_addr_i[43]} {boot_addr_i[44]} {boot_addr_i[45]} {boot_addr_i[46]} {boot_addr_i[47]} {boot_addr_i[48]} {boot_addr_i[49]} {boot_addr_i[50]} {boot_addr_i[51]} {boot_addr_i[52]} {boot_addr_i[53]} {boot_addr_i[54]} {boot_addr_i[55]} {boot_addr_i[56]} {boot_addr_i[57]} {boot_addr_i[58]} {boot_addr_i[59]} {boot_addr_i[60]} {boot_addr_i[61]} {boot_addr_i[62]} {boot_addr_i[63]} clk_i debug_req_i {hart_id_i[0]} {hart_id_i[1]} {hart_id_i[2]} {hart_id_i[3]} {hart_id_i[4]} {hart_id_i[5]} {hart_id_i[6]} {hart_id_i[7]} {hart_id_i[8]} {hart_id_i[9]} {hart_id_i[10]} {hart_id_i[11]} {hart_id_i[12]} {hart_id_i[13]} {hart_id_i[14]} {hart_id_i[15]} {hart_id_i[16]} {hart_id_i[17]} {hart_id_i[18]} {hart_id_i[19]} {hart_id_i[20]} {hart_id_i[21]} {hart_id_i[22]} {hart_id_i[23]} {hart_id_i[24]} {hart_id_i[25]} {hart_id_i[26]} {hart_id_i[27]} {hart_id_i[28]} {hart_id_i[29]} {hart_id_i[30]} {hart_id_i[31]} {hart_id_i[32]} {hart_id_i[33]} {hart_id_i[34]} {hart_id_i[35]} {hart_id_i[36]} {hart_id_i[37]} {hart_id_i[38]} {hart_id_i[39]} {hart_id_i[40]} {hart_id_i[41]} {hart_id_i[42]} {hart_id_i[43]} {hart_id_i[44]} {hart_id_i[45]} {hart_id_i[46]} {hart_id_i[47]} {hart_id_i[48]} {hart_id_i[49]} {hart_id_i[50]} {hart_id_i[51]} {hart_id_i[52]} {hart_id_i[53]} {hart_id_i[54]} {hart_id_i[55]} {hart_id_i[56]} {hart_id_i[57]} {hart_id_i[58]} {hart_id_i[59]} {hart_id_i[60]} {hart_id_i[61]} {hart_id_i[62]} {hart_id_i[63]} ipi_i {irq_i[0]} {irq_i[1]} rst_ni time_irq_i}
selectObject IO_Pin {axi_resp_i[1]}


#Spread the IO Pins in the Top 
editPin -side TOP -layer M2 -fixedPin 1 -spreadType CENTER -spacing 10 -pin { value_o[5] value_o[7] easter_egg[1] instr_i[7] address[0] instr_i[6] easter_egg[0] instr_i[1] value_o[4] clk_i DataOrReg reset }
#Metal-2
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {443.19 876.96} -spacing 10 -pin value_o[5] 
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {463.19 876.96} -spacing 10 -pin easter_egg[1]
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {493.19 876.96} -spacing 10 -pin address[4]
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {503.19 876.96} -spacing 10 -pin easter_egg[0]
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {533.19 876.96} -spacing 10 -pin value_o[4]
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {563.19 876.96} -spacing 10 -pin clk_i
editPin -side TOP -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {593.19 876.96} -spacing 10 -pin DataOrReg
#Metal-6
editPin -side TOP -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {453.19 876.96} -spacing 10 -pin value_o[7]
editPin -side TOP -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {483.19 876.96} -spacing 10 -pin address[0]
editPin -side TOP -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {523.19 876.96} -spacing 10 -pin instr_i[1]
editPin -side TOP -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {543.19 876.96} -spacing 10 -pin reset
#Metal-4
editPin -side TOP -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {473.19 876.96} -spacing 10 -pin instr_i[7]
editPin -side TOP -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {513.19 876.96} -spacing 10 -pin instr_i[6]
editPin -side TOP -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {458.19 876.96} -spacing 10 -pin value_o[3]
editPin -side TOP -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {448.19 876.96} -spacing 10 -pin value_o[2]
editPin -side TOP -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {468.19 876.96} -spacing 10 -pin address[3]

#Spread the IO Pins in the Bottom
#Metal-2
editPin -side BOTTOM -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {443.19 0.0} -spacing 10 -pin value_o[1]
editPin -side BOTTOM -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {473.19 0.0} -spacing 10 -pin instr_i[5]
editPin -side BOTTOM -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {493.19 0.0} -spacing 10 -pin address[2]
editPin -side BOTTOM -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {503.19 0.0} -spacing 10 -pin instr_i[4]
editPin -side BOTTOM -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {533.19 0.0} -spacing 10 -pin value_o[0]
editPin -side BOTTOM -layer M2 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {543.19 0.0} -spacing 10 -pin is_positive

#Metal-6
editPin -side BOTTOM -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {463.19 0.0} -spacing 10 -pin value_o[6]
editPin -side BOTTOM -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {483.19 0.0} -spacing 10 -pin value_o[6]
editPin -side BOTTOM -layer M6 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {513.19 0.0} -spacing 10 -pin instr_i[0]


#Metal-4
editPin -side BOTTOM -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {453.19 0.0} -spacing 10 -pin vout_addr[1]
editPin -side BOTTOM -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {523.19 0.0} -spacing 10 -pin vout_addr[0]
editPin -side BOTTOM -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {553.19 0.0} -spacing 10 -pin instr_i[3]
editPin -side BOTTOM -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {563.19 0.0} -spacing 10 -pin address[1]
editPin -side BOTTOM -layer M4 -fixedPin 1 -fixOverlap 1 -spreadtype START -start {573.19 0.0} -spacing 10 -pin instr_i[2]





#SelectIO pins
selectIOPin pinname
selectIOPin value_o[4]
selectIOPin easter_egg[1]
selectIOPin value_o[5]

checkPinAssignment

# Save the design
save_design design_with_pins.def


# List out the no. of IO ports
sizeof_collection [get_ports *]  

# List out the no. of output ports
sizeof_collection [get_ports * -filter "@direction==out"]

# List the output ports with port_name
get_ports * -filter "@direction==out"

# List out the no. of input ports
sizeof_collection [get_ports * -filter "@direction==in"]

# List the input ports with port_name
get_ports * -filter "@direction==in"

# Commands to fix io ports
setPtnPinStatus -pin * -cell CPU -status fixed

fixAllIos
saveDesign dB/RISC_V_io.enc
# Commands to unfix io ports
#unfixAllIos
#The following command writes the current I/O pad and pin information to Version: 3 file
#saveIoFile myIoPlan.io
#The following command writes the current I/O pad and pin information to a Version: 2 file and specifies the clockwise placement of the I/O pins in the I/O template file:
#saveIoFile -v2 -ioOrder clockwise -template myIoPlan.io



