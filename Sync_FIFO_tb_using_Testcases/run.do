vlog tb_wr_rd_task.v
vsim tb +testcase=fifo_empty_error
add wave sim:/tb/dut/*
run -all

