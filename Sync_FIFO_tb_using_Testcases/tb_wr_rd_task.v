`include "sync_fifo.v"

module tb;
parameter WIDTH=8,DEPTH=16,PTR_ADDR=4;
 
reg clk_i,rst_i,wr_en_i,rd_en_i;
reg [WIDTH-1:0]wdata_i;
wire [WIDTH-1:0]rdata_o;
wire full_o,empty_o,wr_error_o,rd_error_o;
integer i;
reg [30*8:1]testcase;
fifo_s dut(clk_i,rst_i,wdata_i,full_o,wr_en_i,wr_error_o,rdata_o,empty_o,rd_en_i,rd_error_o);

initial begin
clk_i=0;
forever #5 clk_i =~clk_i;
end

initial begin
	$value$plusargs("testname=%s",testcase);
	rst_i = 1;
	@(posedge clk_i);
	rst_i = 0;
	case(testcase)
		"fifo_empty":begin
		 	write_task(DEPTH);
			end	

		"fifo_empty":begin
			write_task(DEPTH);
			read_task(DEPTH);
		 end
		 "fifo_full_error":begin
		 	write_task(DEPTH+1);
			end	
		"fifo_empty_error":begin
				write_task(9);
				read_task(13);
		end		
	endcase
	write_task(DEPTH);
	read_task(DEPTH);
			
	#50
	$finish;
end
task write_task(input integer num_wr);
begin
	for(i=0; i<num_wr; i=i+1) begin
		@(posedge clk_i);
		wdata_i = $random;
		wr_en_i =1;
		
	end
	@(posedge clk_i);
		wr_en_i =0;
		wdata_i =0;
end
endtask

task read_task(input integer num_rd);
begin
	for(i=0; i<num_rd; i=i+1) begin
		@(posedge clk_i);
		rd_en_i =1;
	end
		@(posedge clk_i);
		rd_en_i =0;
end
endtask

endmodule








