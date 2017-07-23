library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Processor IS
port(
	ref_clk :		 in std_logic;
	
	reset: 			 in std_logic
);
END Processor;

ARCHITECTURE beh OF Processor IS 

COMPONENT regfile

PORT (
		clk 	: IN std_logic;
		rst_s 	: IN std_logic; -- synchronous reset
		we 		: IN std_logic; -- write enable
		raddr_1 : IN std_logic_vector (4 DOWNTO 0); -- read address 1
		raddr_2 : IN std_logic_vector (4 DOWNTO 0); -- read address 2
		rdata_1 : OUT std_logic_vector (31 DOWNTO 0); -- read data 1
		rdata_2 : OUT std_logic_vector (31 DOWNTO 0); -- read data 2
		waddr 	: IN std_logic_vector (4 DOWNTO 0); -- write address
		wdata 	: IN std_logic_vector (31 DOWNTO 0) -- write data
		);
END COMPONENT;

COMPONENT alu
PORT (
	Func_in : IN std_logic_vector (3 DOWNTO 0);
	A_in : IN std_logic_vector (31 DOWNTO 0);
	B_in : IN std_logic_vector (31 DOWNTO 0);
	O_out : OUT std_logic_vector (31 DOWNTO 0);
	Branch_out: Out std_logic
);
END COMPONENT;


COMPONENT control
PORT(
		clk : 					in std_logic;
		instruction : 		in std_logic_vector(5 downto 0);
		RegDst:				out std_logic;
		Branch:				out std_logic;
		MemRead:			out std_logic;
		MemToReg:			out std_logic;
		ALUOP0:				out std_logic;
		ALUOP1:				out std_logic;
		MemWrite:			out std_logic;
		ALUSrc:				out std_logic;
		RegWrite:			out std_logic;
		JALRMode: 		out std_logic;
		IRMode: 			out std_logic;
		LUIMode: 			out std_logic;
		LCMode: 			out std_logic_vector(2 downto 0);
		SCMode:				out std_logic_vector(1 downto 0);
		dsize:				out std_logic_vector(1 downto 0)
);
END COMPONENT;

COMPONENT imem
port(
	addr 		: in STD_LOGIC_VECTOR(31 downto 0);
	instruction	: out STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;

COMPONENT ram 
	port (
			clk	: IN std_logic;
			we 		: IN std_logic;
			dsize 	: IN std_logic_vector (1 DOWNTO 0);
			addr 	: IN std_logic_vector (31 DOWNTO 0);
			dataI 	: IN std_logic_vector (31 DOWNTO 0);
			dataO 	: OUT std_logic_vector (31 DOWNTO 0)
);
END COMPONENT;

COMPONENT mux2to1
PORT (
		in0		 : IN std_logic_vector(31 downto 0);
		in1 	 : IN std_logic_vector(31 downto 0);
		mode 	 : IN std_logic ;
		output1	 : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT mux2to1_5
PORT (
		in0		 : IN std_logic_vector(4 downto 0);
		in1 	 : IN std_logic_vector(4 downto 0);
		mode	 : IN std_logic ;
		output1	 : OUT std_logic_vector(4 downto 0)
);
END COMPONENT;


COMPONENT Sign_extend
PORT(
    	input1    	 : in 	std_logic_vector(15 downto 0);
    	output1   	 : out	std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT alu_control
PORT(
	clk: 				in std_logic;
	instruction:		in std_logic_vector(5 downto 0);
	ALUOP0:				in std_logic;
	ALUOP1:				in std_logic;
	Operation:			out std_logic_vector(3 downto 0);	-- changed this from 5 downto 0
	JRMode :			out std_logic;
	JumpMode:			out std_logic;
	ShiftMode:			out std_logic;
	WriteMode:			out std_logic
);
END COMPONENT;

COMPONENT adder 
	PORT(
		A_in, B_in : IN STD_LOGIC_VECTOR(31 downto 0);
		O_out : OUT STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;

COMPONENT pc
	port(
		clk : in std_logic;
		i_in : in std_logic_vector(31 downto 0);
		i_out : out std_logic_vector(31 downto 0) 
);
END COMPONENT;

COMPONENT mux2to1_6
PORT (
		in0 	: IN std_logic_vector(5 downto 0);
		in1 	: IN std_logic_vector(5 downto 0);
		mode 	: IN std_logic ;
		output1 : OUT std_logic_vector(5 downto 0)
);	
END COMPONENT;

COMPONENT mux_5_a 
PORT (
		in0 : IN std_logic_vector(4 downto 0);
		in1 : IN std_logic_vector(4 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(4 downto 0)
);

END COMPONENT;

COMPONENT mux_5_b 
PORT (
		in0 : IN std_logic_vector(4 downto 0);
		in1 : IN std_logic_vector(4 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(4 downto 0)
);
END COMPONENT;

COMPONENT mux_5_c 
PORT (
		in0 : IN std_logic_vector(4 downto 0);
		in1 : IN std_logic_vector(4 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(4 downto 0)
);
END COMPONENT;

COMPONENT mux_32_d 
PORT (
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(31 downto 0)
);

END COMPONENT;

COMPONENT mux_32_e 
PORT (
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT mux_32_f
PORT (
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(31 downto 0)
);	

END COMPONENT;

COMPONENT mux_32_g 
PORT (
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT mux_32_h 
PORT (
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(31 downto 0)
);	

END COMPONENT;

COMPONENT mux_32_i
PORT(
		in0 : IN std_logic_vector(31 downto 0);
		in1 : IN std_logic_vector(31 downto 0);
		mode : IN std_logic ;
		output1 : OUT std_logic_vector(31 downto 0)

);
END COMPONENT;

COMPONENT Concat 
PORT(
		s_in 	: IN std_logic_vector(25 downto 0);
		p_in 	: IN std_logic_vector(3 downto 0);
		o_out : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT ShiftL2 
PORT(
		Input: 		in std_logic_vector(31 downto 0);
		Output:		out std_logic_vector(31 downto 0)
);

END COMPONENT;

COMPONENT branch_adder 
PORT(
			A_in, B_in : IN STD_LOGIC_VECTOR(31 downto 0);
			O_out : OUT STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;

COMPONENT And_Gate 
PORT(
		in0 : 	IN std_logic;
		in1 : 	IN std_logic;
		out1:	OUT std_logic
);
END COMPONENT;

COMPONENT LoadChoice
PORT(
		Mem_in	: IN std_logic_vector(31 downto 0);
		LCMode	: IN std_logic_vector(2 downto 0);
		LC_out	: OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT SaveChoice
PORT(
		Rt_in	: IN std_logic_vector(31 downto 0);
		SCMode	: IN std_logic_vector(1 downto 0);
		SC_out	: OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT Extend
PORT(
    input1    	 : in 	std_logic_vector(4 downto 0);
    output1   	 : out	std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT LUI_Shifter
PORT(
	Input: 		in std_logic_vector(31 downto 0);
	Output:		out std_logic_vector(31 downto 0)
);
END COMPONENT;
-- From Control to other parts
SIGNAL a1 : std_logic; -- RegDst
SIGNAL a2 : std_logic; -- Branch
SIGNAL a3 : std_logic; -- MemRead
SIGNAL a4 : std_logic; -- MemToReg
SIGNAL a5 : std_logic; -- ALUOP0
SIGNAL a6 : std_logic; -- ALUOP1
SIGNAL a7 : std_logic; -- MemWrite
SIGNAL a8 : std_logic; -- ALUSrc
SIGNAL a9 : std_logic; -- RegWrite
SIGNAL a10: std_logic; -- To 6-to-1 mux
SIGNAL a11: std_logic; -- IRMode
SIGNAL a12: std_logic; -- JALRMode
SIGNAL a13: std_logic; -- WriteMode
SIGNAL a14: std_logic; -- LUIMode
Signal a15: std_logic_vector(2 downto 0); -- LCMode(2 downto 0);
SIGNAL a16: std_logic_vector(1 downto 0); -- SCMode;
Signal a17: std_logic_vector(1 downto 0); --  dsize
 

-- From Sign_extend to other parts
SIGNAL b1 : std_logic_vector(31 downto 0);

-- From Register to other parts
SIGNAL c1 : std_logic_vector(31 downto 0);	-- rdata_1
SIGNAL c2 : std_logic_vector(31 downto 0);	-- rdata_2

--From mux 5 bit to other parts
SIGNAL d1 : std_logic_vector( 4 downto 0);

--From mux near ALU to other parts.
SIGNAL e1 : std_logic_vector(31 downto 0);

-- From ALU to other parts 
SIGNAL f1 : std_logic_vector(31 downto 0);
Signal f2 : std_logic; -- zero 

-- From Data memory to other parts
SIGNAL g1 : std_logic_vector(31 downto 0);

-- From Second Mux near the RAM to other parts
SIGNAL h1 : std_logic_vector(31 downto 0);

-- From ALU control
SIGNAL i1 : std_logic_vector(3 downto 0);
Signal i2 : std_logic; -- JRMode
Signal i3 : std_logic; -- JumpMode
Signal i4 : std_logic; -- ShiftMode
-- Clock
-- SIGNAL clock : std_logic := '0'; 

-- From Pc to rest
SIGNAL j1 : std_logic_vector(31 downto 0);

-- From Adder to rest 
SIGNAL k1 : std_logic_vector(31 downto 0); 

-- From 6-to-1 mux before the ALU control
SIGNAL l1 : std_logic_vector(5 downto 0);

-- From Mux_5_a to the before the mux c near the WA of the Reg file
SIGNAL mua : std_logic_vector(4 downto 0);

-- From Mux_5_b to the before the mux c near the WA of the Reg file
SIGNAL mub : std_logic_vector(4 downto 0); 

--From MUX_32_D to the RegFile.
SIGNAL mud : std_logic_vector(31 downto 0);

-- From MUX_32_E to Mux_32_f
SIGNAL mue : std_logic_vector(31 downto 0);

-- From Mux_32_G to Mux_32_f
Signal mug : std_logic_vector(31 downto 0);

-- From Mux_32_f to PC again
Signal muf : std_logic_vector(31 downto 0);

-- From Concat_shift to mux_32_g
Signal conc : std_logic_vector(31 downto 0);

--From Shift L2 to Alu  to add branch and jump amount
Signal sll2	: std_logic_vector(31 downto 0); 

--  From Branch Alu to Mux END
Signal alu1	: std_logic_vector(31 downto 0);

--From SHAMT shift amount 
Signal shamt : std_logic_vector(31 downto 0);

-- From MUX I 
Signal mui : std_logic_vector(31 downto 0);

--FROM Mux H
Signal muh : std_logic_vector(31 downto 0);

--FROM SaveChoice
Signal savc: std_logic_vector(31 downto 0);

--FROM LoadChoice
Signal loadc: std_logic_vector(31 downto 0);

-- FROM And_Gate
Signal Andc: std_logic; 

--FROM LUI - SHIFTER
Signal Luiout: std_logic_vector(31 downto 0);
-- SIGNAL rst : std_logic := '0';
-- SIGNAL Branch_out, Jump_out : std_logic;
SIGNAL address : std_logic_vector (31 DOWNTO 0) := "00000000000000000000000000000110";
SIGNAL instruction : std_logic_vector (31 DOWNTO 0);
SIGNAL JAL :	std_logic_vector(4 DOWNTO 0) := "11111";

BEGIN
	--clock <= '0' after 50 ns when clock = '1' else '1' after 50 ns;
	--ref_clk <= '0' after 50 ns when clock = '1' else '1' after 50 ns;
	a10 <= a5 and not a6;

	COMPONENT1: regfile 				PORT MAP( ref_clk, reset, a9, instruction (25 DOWNTO 21), instruction (20 DOWNTO 16), c1, c2, d1, mud); -- PORT MAP(clk ,reset,we,raddr_1,raddr_2,rdata_1,rdata_2,waddr,wdata);
	COMPONENT2: alu						PORT MAP( i1, mui, e1, f1, f2); --PORT MAP(func_in, A_in, B_in, output, Branch_out);
	COMPONENT3: control 				PORT MAP( ref_clk, instruction (31 DOWNTO 26), a1, a2, a3, a4, a5, a6, a7, a8, a9,a12,a11,a14,a15,a16,a17); -- PORT MAP(clk, instruction, RegDst, Branch, MemRead, MemToReg, ALUOP0, ALUOP1, MemWrite, ALUSrc, RegWrite, JALRMode,IRMode, LUIMode, LCMode, SCMode, dsize);
	COMPONENT4: ram					PORT MAP( ref_clk, a7, a17,f1, savc, g1); -- PORT MAP(clk, we, dsize, addr, dataI, dataO);
	COMPONENT5: mux2to1 			PORT MAP( c2, b1, a8, e1); -- PORT MAP (k) (in0,in1, mode, output1);
	COMPONENT6: Sign_extend 		PORT MAP( instruction (15 DOWNTO 0), b1); -- PORT MAP (input1,output1);
	COMPONENT7: Extend				PORT MAP( instruction (10 DOWNTO 6), shamt); -- PORT MAP(input1,output1)
	COMPONENT8: mux2to1				PORT MAP( muh, loadc, a4, h1); -- j mem 2 reg 
	COMPONENT9: alu_control			PORT MAP( ref_clk, l1, a5, a6, i1, i2, i3, i4,a13); -- PORT MAP (clk, instruction,ALUOP0, ALUOP1, Operation, JRMode, JumpMode, ShiftMode); 
	COMPONENT10: imem 				PORT MAP( j1, instruction); --PORT MAP (addr,instruction);
	COMPONENT11: pc						PORT MAP( ref_clk, muf, j1); --PORT MAP (clk, i_in, i_out);
	COMPONENT12: adder				PORT MAP( j1,(2 => '1', others=> '0'),k1); -- PORT MAP(A_in, B_in, O_out);
	
	-------------------
	COMPONENT13: mux2to1_6		PORT MAP( instruction (31 DOWNTO 26), instruction (5 DOWNTO 0), a10, l1);
	------------------- Assignment 2
	COMPONENT14: mux_5_a   		PORT MAP( instruction (20 DOWNTO 16 ),instruction(15 downto 11), a11, mua ); --PORT MAP(in0,in1,mode,output1);
	COMPONENT15: mux_5_b   		PORT MAP( instruction (15 DOWNTO 11),JAL, a12, mub ); --PORT MAP(in0,in1,mode,output1);
	COMPONENT16: mux_5_c    		PORT MAP( mua, mub, a1, d1 ); --PORT MAP(in0,in1,mode,output1);
	COMPONENT17: mux_32_d   		PORT MAP( h1, k1, a13, mud ); --PORT MAP(in0,in1,mode,output1); 
	COMPONENT18: mux_32_e   		PORT MAP( k1, alu1, Andc, mue ); --PORT MAP(in0,in1,mode,output1);
	COMPONENT19: mux_32_f   		PORT MAP( mue, mug, i3, muf ); --PORT MAP(in0,in1,mode,output1);
	COMPONENT20: mux_32_g  		PORT MAP( conc, f1 ,i2, mug); --PORT MAP(in0,in1,mode,output1);
	COMPONENT21: mux_32_h  		PORT MAP(f1, Luiout, a14, muh); --PORT MAP(in0,in1,mode,output1);
	COMPONENT22: Concat 				PORT MAP(instruction(25 downto 0), k1(31 downto 28), conc ); --PORT MAP(s_in,p_in,output);
	COMPONENT23: ShiftL2 				PORT MAP( b1, sll2 ); --(Input,output);
	COMPONENT24: branch_adder	PORT MAP (k1, sll2, alu1); -- PORT MAP(A_in,B_in,O_out); 
	COMPONENT25: And_Gate   		PORT MAP (a2, f2, Andc); -- PORT MAP(in0,in1,out1);
	COMPONENT26: mux_32_i   		PORT MAP (c1, shamt, i4, mui);--PORT MAP(in0,in1,mode,output1);
	COMPONENT27: LoadChoice 		PORT MAP (g1, a15, loadc); -- PORT MAP(Mem_in, LCMode, LC_out);
	COMPONENT28: SaveChoice 		PORT MAP (c2, a16, savc); -- PORT MAP(Rt_in, SCMode, SC_out);
	COMPONENT29: LUI_Shifter 		PORT MAP (f1,Luiout); -- PORT MAP (Input, Output);
END beh;
