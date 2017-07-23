module orgatetb;
 logic input1;
 logic input2;
 wire output1;
 orgate L1(	.IN1(input1),
		.IN2(input2),
		.OUT1(output1));
 initial begin
 input1 = 1'b0;
 input2 = 1'b0;
 #10;
 input2 = 1'b1;
 #10;
 input1 = 1'b1;
 input2 = 1'b0;
 #10;
 input2 = 1'b1;
 end
endmodule
