source generate_project_basys3.tcl
cd /home/vivado/project/project_basys3
synth_design -top mbed_tester_basys3_top -part xc7a35tcpg236-1
opt_design
place_design
route_design
write_bitstream mbed_tester_basys3_top.bit
exit
