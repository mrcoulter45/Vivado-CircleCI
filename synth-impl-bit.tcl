source generate_project_basys3.tcl
cd /home/vivado/project/project_basys3
set_param general.maxThreads 4
synth_design -top mbed_tester_basys3_top -part xc7a35tcpg236-1 -verbose
opt_design -verbose
place_design -verbose
route_design -verbose
write_bitstream mbed_tester_basys3_top.bit -verbose
exit
