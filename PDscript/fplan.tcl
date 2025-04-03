set init_lef_file {../../../0_FreePDK45/LEF/NangateOpenCellLibrary.lef ../sram_32_16/sram_32_16_freepdk45.lef}
set init_gnd_net VSS
set init_pwr_net VDD

set init_verilog ../gate/pulpino_top_nangate45.v
set init_top_cell pulpino_top

set init_mmmc_file Default.view

init_design



restoreDesign /home/pd1/NanGate_lib/Ariane_26_10_24/output_flat/dB/ariane_fp_29_10_24.enc.dat ariane


Creates cell placement blockages that can be placed. 
A placement blockage is a  floorplan  object  used  to  block standard cell placements. 
Use this command after importing the design.
* The following command creates a soft blockage, softBlockage2 in the design area:


createPlaceBlockage -type soft -box { { 584.94 725.76 786.54 846.72 } } -name softBlockage1
createPlaceBlockage -type soft -box { { 267.8165 626.3295 320.9265 675.646 } } -name softBlockage2
createPlaceBlockage -type soft -box { { 422.0885 776.8075 467.6115 824.8595 } } -name softBlockage3
createPlaceBlockage -type soft -box { { 723.045 272.263 769.8325 322.8435 } } -name softBlockage4

Command to select particular macro
selectInst {i_cache_subsystem/i_icache/sram_block[2].data_sram/macro_mem[2].i_ram}

gui_select -rect {262.38 766.08 302.70 806.40} (To see the co-ordinate location in Gui}
gui_select -rect {584.94 725.76 786.54 846.72}

# Select the particular area by using mouse then right click on the mouse and 
select attribute editor or press "Q", able to see the co-ordinates in the BOX tab {671.919 374.1955 720.256 417.162}
gui_select -rect {272.69 626.623 322.8175 669.5895}
gui_select -rect {671.919 374.1955 720.256 417.162}

#A density screen area is a floorplan object used to assign standard cell placement density in the design area. 
The createDensityArea command can be used to create partial placement blockages even outside the core boundary.
Use this command after importing the design.
createDensityArea 699.6 526.96 1100.22 773.92 20


#Specifies the attributes for the selected density screen area(s).  
After importing the design and selecting the density area, 
if required, you can use this command to change the density area's location, type, or density. 

setSelectedDensityArea 100.0 100.0 200.0 200.0 75 softDensity2 Soft Instance


setSelectedDensityArea 
x1 y1 x2 y2 ---100.0 100.0 200.0 200.0
density --------{Min =0 to Max=100}  Ex:75
name ----------{softDensity2}
{Partial Soft Hard} -------soft
{Instance Pushdown Undefined} 
---Specifies the relationship of the density screen area to the design. 
Instance: The density screen area is associated with the current design.

#Creation of Fence/Region/Guide
createInstGroup cli8
addInstToInstGroup cli8 "u_ip_top/u_lsioe_cli8/u_spi"
createGuide cli8 {492.384 864.292 589.776 967.824}


createFence core1/rv_cpu_genblk2.pcpi_div -85.573 -158.4485 0.0 0.0
createFence core1/rv_cpu_genblk1.pcpi_mul -53.515 -161.823 0.0 0.0
createFence core1/spimemio -65.326 -168.572 0.0 0.0
createFence sram -85.573 -170.2595 0.0 0.0

createRegion core1/rv_cpu_genblk2.pcpi_div -65.326 -168.572 0.0 0.0
createGuide core1/rv_cpu_genblk2.pcpi_div -53.515 -161.823 0.0 0.0
unplaceGuide core1/rv_cpu_genblk2.pcpi_div -85.573 -170.2595 0.0 0.0


Floorplan commands

Load the design
read_lef technology.lef standard_cells.lef
read_def design.def

# Set the floorplan
create_fp_placement -die_area "0 0 1000 1000" -core_area "100 100 900 900"

# Manual Pin Placement
create_pin -name clk -location {100 950} -layer metal1 -direction INPUT
create_pin -name rst -location {200 950} -layer metal1 -direction INPUT
create_pin -name data_in -location {300 950} -layer metal1 -direction INPUT
create_pin -name data_out -location {400 50} -layer metal1 -direction OUTPUT

# Alternatively, Automatic Pin Placement
# place_pins -type io -spacing 10 -hor_edge_type alternate -ver_edge_type alternate -start_corner lower_left

# Save the design
save_design design_with_pins.def