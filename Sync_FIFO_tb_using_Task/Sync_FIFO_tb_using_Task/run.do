vlog tb_wr_rd_task.v
vsim tb +seed=23456:
add wave sim:/tb/dut/*
run -all

