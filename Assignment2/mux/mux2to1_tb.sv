module mux2to1_tb;
	logic[31:0] in0;
	logic[31:0] in1;
	logic mode;
	wire[31:0] output1;
	
mux2to1 L1(
	.in0(in0),
	.in1(in1),
	.mode(mode),
	.output1(output1)
	);
	
initial begin
	in0 = 32'b 01010101010101010101010101010101;
	in1 = 32'b 10101010101010101010101010101010;
	mode = 1'b 1;
	#100;
	mode = 1'b 0;
	#100;
	
	in0 = 32'b 00000000000000000000000000000000;
	in1 = 32'b 11111111111111111111111111111111;
	mode = 1'b 0;
	#100;
	mode = 1'b 1;
	#100;
	
	in0 = 32'b 00001111000011110000111100001111;
	in1 = 32'b 11110000111100001111000011110000;
	mode = 1'b 1;
	#100;
	mode = 1'b 0;
	#100;
	

end
endmodule