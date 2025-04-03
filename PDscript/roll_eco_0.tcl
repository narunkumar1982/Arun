restoreDesign /home/pd1/UART_Sep24/dB/UART_Sep24_post_route.enc.dat uart
source /home/pd1/UART_Sep24/eco_innovus.tcl 
ecoRoute
saveNetlist /home/pd1/UART_Sep24/outputs/UART_Sep24_route.v
saveNetlist -includePowerGround /home/pd1/UART_Sep24/outputs/UART_Sep24_route_pg.v
saveNetlist -phys /home/pd1/UART_Sep24/outputs/UART_Sep24_route_lvs.v
saveDesign dB/UART_Sep24_post_route.enc