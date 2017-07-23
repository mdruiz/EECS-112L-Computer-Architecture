module test_tb;
	logic  Input;
	wire  Output;
	
test L1(
	.Input(Input),
	.Output(Output)
	);

		
initial begin

	Input = 1'b 0;
	#50;
	Input = 1'b 1;
	#50;
	
	
	
end

endmodule