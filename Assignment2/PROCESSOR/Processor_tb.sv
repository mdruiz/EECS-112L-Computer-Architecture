module Processor_tb;
	logic  ref_clk;
	logic  reset;
	
Processor L1(
	.ref_clk(ref_clk),
	.reset(reset)
	);

		
initial begin

	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	ref_clk = 1'b 0;
	#50;
	ref_clk = 1'b 1;
	#50;
	
	
	
end



endmodule