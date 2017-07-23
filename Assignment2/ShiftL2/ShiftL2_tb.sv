module ShiftL2_tb;
	logic [31:0] Input;
	wire [31:0] Output;
	
ShiftL2 L1(
	.Input(Input),
	.Output(Output)
	);
	
initial begin

	Input = 32'b 11111111111111111111111111111111;
	#100;
	Input = 32'b 01010101010101010101010101010101;
	#100;
	Input = 32'b 10101010101010101010101010101010;
	#100;

end
endmodule