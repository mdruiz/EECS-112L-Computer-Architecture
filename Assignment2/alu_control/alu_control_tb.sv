module alu_control_tb;
	logic clk;
	logic [5:0] instruction;
	logic ALUOP0;
	logic ALUOP1;
	wire [5:0] Operation;

	
alu_control L1(
	.clk(clk),
	.instruction(instruction),
	.ALUOP0(ALUOP0),
	.ALUOP1(ALUOP1),
	.Operation(Operation)
	);
	
initial begin

	ALUOP0 = 1'b 0;
	ALUOP1 = 1'b 0;
	
	instruction = 6'b 000000;
	#100;
	instruction = 6'b 111111;
	#100;
	instruction = 6'b 010101;
	#100;
	instruction = 6'b 101010;
	#100;
	
	ALUOP0 = 1'b 0;
	ALUOP1 = 1'b 1;
	
	instruction = 6'b 000000;
	#100;
	instruction = 6'b 000010;
	#100;
	instruction = 6'b 000100;
	#100;
	instruction = 6'b 000101;
	#100;
	instruction = 6'b 001010;
	#100;
	instruction = 6'b 001100;
	#100;
	
	instruction = 6'b 100000;
	#100;
	instruction = 6'b 100010;
	#100;
	instruction = 6'b 100100;
	#100;
	instruction = 6'b 100101;
	#100;
	instruction = 6'b 101010;
	#100;
	instruction = 6'b 001100;
	#100;
	
	ALUOP0 = 1'b 1;
	ALUOP1 = 1'b 0;
	
	instruction = 6'b 000000;
	#100;
	instruction = 6'b 111111;
	#100;
	instruction = 6'b 010101;
	#100;
	instruction = 6'b 101010;
	#100;
	
	ALUOP0 = 1'b 1;
	ALUOP1 = 1'b 1;
	
	instruction = 6'b 000000;
	#100;
	instruction = 6'b 000010;
	#100;
	instruction = 6'b 000100;
	#100;
	instruction = 6'b 000101;
	#100;
	instruction = 6'b 001010;
	#100;
	instruction = 6'b 001100;
	#100;
	
	instruction = 6'b 100000;
	#100;
	instruction = 6'b 100010;
	#100;
	instruction = 6'b 100100;
	#100;
	instruction = 6'b 100101;
	#100;
	instruction = 6'b 101010;
	#100;
	instruction = 6'b 001100;
	#100;
	
end
endmodule