module Sign_extend_tb;
	logic [15:0] input1;
	wire [31:0] output1;
	
Sign_extend L1(
	.input1(input1),
	.output1(output1)
	);
	
initial begin
	input1 = 16'b 1010101010101010; /*-21,846*/
	#100;
	input1 = 16'b 0101010101010101;  /*21,845*/
	#100;
	input1 = 16'b 0000000000000001; /*1*/
	#100;
	input1 = 16'b 1000000000000000; /*-32,768*/
	#100;
	input1 = 16'b 0000000000000000; /*0*/
	#100;
	input1 = 16'b 1111111111111111; /*-1*/
	#100;

end
endmodule