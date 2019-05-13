# Run Synthesis
launch_runs synth_1
wait_on_run synth_1

# Run Implementation
launch_runs impl_1
wait_on_run impl_1

# Generate Bitstream
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
