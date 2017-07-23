library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Processor IS
port(
	ref_clk : in std_logic;	
	reset	: in std_logic
);
END Processor;

ARCHITECTURE beh OF Processor IS 

COMPONENT regfile
PORT (
	clk 	: IN std_logic;
	rst_s 	: IN std_logic; -- synchronous reset
	we 	: IN std_logic; -- write enable
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
	Func_in 	: IN std_logic_vector (3 DOWNTO 0);
	A_in 		: IN std_logic_vector (31 DOWNTO 0);
	B_in 		: IN std_logic_vector (31 DOWNTO 0);
	O_out 		: OUT std_logic_vector (31 DOWNTO 0);
	Branch_out	: OUT std_logic
);
END COMPONENT;


COMPONENT control
PORT(
	clk		: in std_logic;
	instruction 	: in std_logic_vector(5 downto 0);
	RegDst		: out std_logic;
	Branch		: out std_logic;
	MemRead		: out std_logic;
	MemToReg	: out std_logic;
	ALUOP0		: out std_logic;
	ALUOP1		: out std_logic;
	MemWrite	: out std_logic;
	ALUSrc		: out std_logic;
	RegWrite	: out std_logic;
	JALRMode	: out std_logic;
	IRMode		: out std_logic;
	LUIMode		: out std_logic;
	LCMode		: out std_logic_vector(2 downto 0);
	SCMode		: out std_logic_vector(1 downto 0);
	dsize		: out std_logic_vector(1 downto 0);
	JumpMode	: out std_logic
);
END COMPONENT;


COMPONENT imem
port(
	addr 		: in STD_LOGIC_VECTOR(31 downto 0);
	instruction	: out STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;


COMPONENT data_mem 
port (
	clk	: IN std_logic;
	we 	: IN std_logic;
	dsize 	: IN std_logic_vector (1 DOWNTO 0);
	addr 	: IN std_logic_vector (31 DOWNTO 0);
	dataI 	: IN std_logic_vector (31 DOWNTO 0);
	dataO 	: OUT std_logic_vector (31 DOWNTO 0)
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
	clk		: in std_logic;
	instruction	: in std_logic_vector(5 downto 0);
	ALUOP0		: in std_logic;
	ALUOP1		: in std_logic;
	Operation	: out std_logic_vector(3 downto 0);	-- changed this from 5 downto 0
	ShiftMode	: out std_logic;
	WriteMode	: out std_logic
);
END COMPONENT;


COMPONENT adder 
PORT(
	A_in 	: IN STD_LOGIC_VECTOR(31 downto 0);
	O_out 	: OUT STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;


COMPONENT pc
port(
	clk 	: in std_logic;
	stall 	: in std_logic;
	i_in 	: in std_logic_vector(31 downto 0);
	i_out 	: out std_logic_vector(31 downto 0) 
);
END COMPONENT;


COMPONENT mux_6
PORT (
	in0 	: IN std_logic_vector(5 downto 0);
	in1 	: IN std_logic_vector(5 downto 0);
	mode 	: IN std_logic ;
	output1 : OUT std_logic_vector(5 downto 0)
);	
END COMPONENT;


COMPONENT mux_5
PORT (
	in0 	: IN std_logic_vector(4 downto 0);
	in1 	: IN std_logic_vector(4 downto 0);
	mode 	: IN std_logic ;
	output1 : OUT std_logic_vector(4 downto 0)
);

END COMPONENT;


COMPONENT jump_mux 
PORT (
	in0 	: IN std_logic_vector(4 downto 0);
	mode	: IN std_logic ;
	output1 : OUT std_logic_vector(4 downto 0)
);
END COMPONENT;


COMPONENT mux_32 
PORT (
	in0 	: IN std_logic_vector(31 downto 0);
	in1 	: IN std_logic_vector(31 downto 0);
	mode 	: IN std_logic ;
	output1 : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;


COMPONENT Shift_Concat 
PORT(
	s_in 	: IN std_logic_vector(25 downto 0);
	p_in 	: IN std_logic_vector(3 downto 0);
	o_out 	: OUT std_logic_vector(31 downto 0)
);
END COMPONENT;


COMPONENT ShiftL2 
PORT(
	Input	: in std_logic_vector(31 downto 0);
	Output	: out std_logic_vector(31 downto 0)
);

END COMPONENT;


COMPONENT branch_adder 
PORT(
	A_in	: IN STD_LOGIC_VECTOR(31 downto 0);
	B_in	: IN STD_LOGIC_VECTOR(31 downto 0);
	O_out	: OUT STD_LOGIC_VECTOR(31 downto 0)
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
	input1	: in std_logic_vector(4 downto 0);
	output1	: out std_logic_vector(31 downto 0)
);
END COMPONENT;


COMPONENT LUI_Shifter
PORT(
	Input	: in std_logic_vector(31 downto 0);
	Output	: out std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT reg_EXMEM IS
PORT (
	clk 			: in std_logic;
	MemRead_in	: in std_logic;
	MemToReg_in	: in std_logic;
	MemWrite_in	: in std_logic;
	RegWrite_in	: in std_logic;
	LUIMode_in	: in std_logic;
	LCMode_in	: in std_logic_vector(2 downto 0);
	SCMode_in	: in std_logic_vector(1 downto 0);
	dsize_in		: in std_logic_vector(1 downto 0);
	rdata_2_in 	: in std_logic_vector (31 downto 0); -- read data 2
	--JRMode_in 	: in std_logic;
	--JumpMode_in	: in std_logic;
	WriteMode_in	: in std_logic;
	addr_in 		: in std_logic_vector (31 downto 0);
	--jumpaddr_in 	: in std_logic_vector (31 downto 0);
	RegDstMux_in	: in std_logic_vector ( 4 downto 0);
	alu_in 		: IN std_logic_vector (31 downto 0); 
	MemRead_out	: out std_logic;
	MemToReg_out	: out std_logic;
	MemWrite_out	: out std_logic;
	RegWrite_out	: out std_logic;
	LUIMode_out	: out std_logic;
	LCMode_out	: out std_logic_vector(2 downto 0);
	SCMode_out	: out std_logic_vector(1 downto 0);
	dsize_out		: out std_logic_vector(1 downto 0);
	rdata_2_out 	: out std_logic_vector (31 downto 0); -- read data 2
	--JRMode_out 	: out std_logic;
	--JumpMode_out	: out std_logic;
	WriteMode_out	: out std_logic;
	addr_out 		: out std_logic_vector (31 downto 0);
	--jumpaddr_out 	: out std_logic_vector (31 downto 0);
	RegDstMux_out	: out std_logic_vector ( 4 downto 0);
	alu_out 	: OUT std_logic_vector (31 downto 0)
);
END COMPONENT;

COMPONENT reg_ID_EX IS
PORT(
		clk : 				in std_logic;
		flush : 			in std_logic;
		MemRead_in:		in std_logic;
		MemToReg_in:		in std_logic;
		ALUOP0_in:		in std_logic;
		ALUOP1_in:		in std_logic;
		MemWrite_in:		in std_logic;
		ALUSrc_in:		in std_logic;
		RegWrite_in:		in std_logic;
		LUIMode_in: 		in std_logic;
		LCMode_in: 		in std_logic_vector(2 downto 0);
		SCMode_in:		in std_logic_vector(1 downto 0);
		dsize_in:			in std_logic_vector(1 downto 0);
		rdata_1_in: 		in std_logic_vector (31 downto 0); -- read data 1
		rdata_2_in : 		in std_logic_vector (31 downto 0); -- read data 2
		Sign_extend_in:		in std_logic_vector (31 downto 0);
		Extend_in:			in std_logic_vector (31 downto 0);
		addr_in :			in std_logic_vector (31 downto 0);
		RegDstMux_in:		in std_logic_vector ( 4 downto 0);
		--jumpaddr_in :		in std_logic_vector (31 downto 0);
		ALUControlMux_in:	in std_logic_vector (5 downto 0);	
		RsE_in:			in std_logic_vector (4 downto 0);
		IRModeMux_in:		in std_logic_vector (4 downto 0);
		MemRead_out:		out std_logic;
		MemToReg_out:		out std_logic;
		ALUOP0_out:		out std_logic;
		ALUOP1_out:		out std_logic;
		MemWrite_out:		out std_logic;
		ALUSrc_out:		out std_logic;
		RegWrite_out:		out std_logic;
		LUIMode_out: 		out std_logic;
		LCMode_out: 		out std_logic_vector(2 downto 0);
		SCMode_out:		out std_logic_vector(1 downto 0);
		dsize_out:			out std_logic_vector(1 downto 0);
		rdata_1_out : 		out std_logic_vector (31 downto 0); -- read data 1
		rdata_2_out : 		out std_logic_vector (31 downto 0); -- read data 2
		Sign_extend_out:	out std_logic_vector (31 downto 0);
		Extend_out:		out std_logic_vector (31 downto 0);
		addr_out :			out std_logic_vector (31 downto 0);
		RegDstMux_out:	out std_logic_vector ( 4 downto 0);
		--jumpaddr_out :		out std_logic_vector (31 downto 0);
		ALUControlMux_out:	out std_logic_vector (5 downto 0);
		RsE_out:			out std_logic_vector (4 downto 0);
		IRModeMux_out:	out std_logic_vector (4 downto 0)
	
);
END COMPONENT;

COMPONENT reg_IFID IS
PORT (
	clk 		: IN std_logic ;
	stall		: IN std_logic;
	flushB 	: IN std_logic ;
	flushJ	: IN std_logic ;
	addr_in 	: IN std_logic_vector (31 downto 0); -- input data
	instruction_in 	: IN std_logic_vector (31 downto 0); -- input data
	addr_out 	: OUT std_logic_vector (31 downto 0); -- output data
	instruction_out : OUT std_logic_vector (31 downto 0) -- output data
);
END COMPONENT;

COMPONENT reg_MEM_WB IS
PORT (
	clk 				: in std_logic;
	MemToReg_in		: in std_logic;
	RegWrite_in		: in std_logic;
	LCMode_in		: in std_logic_vector(2 downto 0);
	RegDstMux_in		: in std_logic_vector ( 4 downto 0);
	LUIMux_in 		: in std_logic_vector (31 downto 0);
	addr_in 			: in std_logic_vector (31 downto 0);
	dataO_in 			: in std_logic_vector (31 DOWNTO 0);
	WriteMode_in		: in std_logic;
	MemToReg_out		: out std_logic;
	RegWrite_out		: out std_logic;
	LCMode_out		: out std_logic_vector(2 downto 0);
	RegDstMux_out		: out std_logic_vector ( 4 downto 0);
	LUIMux_out 		: out std_logic_vector (31 downto 0);
	dataO_out 		: out std_logic_vector (31 DOWNTO 0);
	addr_out 			: out std_logic_vector (31 downto 0);
	WriteMode_out		: out std_logic
);
END COMPONENT;

COMPONENT Hazard_Unit IS
PORT(
	ref_clk 		: in std_logic;	
	reset			: in std_logic;
	RsE			: in std_logic_vector (4 downto 0);
	RtE			: in std_logic_vector (4 downto 0); 
	RsD			: in std_logic_vector (4 downto 0);
	RtD			: in std_logic_vector (4 downto 0);
	WriteRegM		: in std_logic_vector (4 downto 0);
	RegWriteM		: in std_logic;
	WriteRegW	: in std_logic_vector (4 downto 0);
	RegWriteW	: in std_logic;
	Mem2RegE	: in std_logic;
	RegWriteE		: in std_logic;
	WriteRegE		: in std_logic_vector (4 downto 0);
	branchD		: in std_logic;
	ForwardAE		: out std_logic_vector(1 downto 0);
	ForwardBE		: out std_logic_vector(1 downto 0);
	StallF		: out std_logic;
	StallD		: out std_logic;
	FlushE		: out std_logic;
	ForwardAD	: out std_logic;
	ForwardBD	: out std_logic
	
);
END COMPONENT;

COMPONENT mux_3to1 IS
PORT (
	in0 : IN std_logic_vector(31 downto 0);
	in1 : IN std_logic_vector(31 downto 0);
	in2 : IN std_logic_vector(31 downto 0);
	mode : IN std_logic_vector(1 downto 0) ;
	output1 : OUT std_logic_vector(31 downto 0)
);
END COMPONENT;

COMPONENT Branch_Comp IS 
PORT(
	in0		: in std_logic_vector(31 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	out1		: out std_logic	
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
SIGNAL JAL :	std_logic_vector(4 DOWNTO 0) := "11111";
SIGNAL instruction1 : std_logic_vector(31 DOWNTO 0);


-----------------------------------------
--From IF/ID

Signal k2: std_logic_vector(31 downto 0);
Signal instruction2: std_logic_vector(31 downto 0);

-- FROM ID/EX 
Signal k3: std_logic_vector(31 downto 0);
Signal conc3: std_logic_vector(31 downto 0);
Signal d3: std_logic_vector( 4 downto 0);
Signal b3: std_logic_vector(31 downto 0);
Signal shamt3: std_logic_vector (31 downto 0);
Signal l3: std_logic_vector (5 downto 0);
Signal cc1: std_logic_vector(31 downto 0);
Signal cc2: std_logic_vector(31 downto 0);
Signal aa2: std_logic;
Signal aa3: std_logic;
Signal aa4: std_logic;
Signal aa5: std_logic;
Signal aa6: std_logic;
Signal aa7: std_logic;
Signal aa8: std_logic;
Signal aa9: std_logic;
Signal aa14: std_logic;
Signal aa15: std_logic_vector(2 downto 0);
Signal aa16: std_logic_vector(1 downto 0);
Signal aa17: std_logic_vector(1 downto 0);
Signal rs2: std_logic_vector(4 downto 0);
Signal rt2: std_logic_vector(4 downto 0);

-- FROM Ex/Mem
Signal k4: std_logic_vector(31 downto 0);
Signal conc4: std_logic_vector(31 downto 0);
Signal d4: std_logic_vector(4 downto 0);
Signal ccc2: std_logic_vector(31 downto 0);
Signal alu4: std_logic_vector(31 downto 0);
Signal ff1 : std_logic_vector(31 downto 0);
Signal ff2 : std_logic;
Signal aaa2: std_logic;
Signal aaa3: std_logic;
Signal aaa4: std_logic;
Signal aaa7: std_logic;
Signal aaa9: std_logic;
Signal aaa14: std_logic;
Signal aaa15: std_logic_vector (2 downto 0);
Signal aaa16: std_logic_vector (1 downto 0);
Signal aaa17: std_logic_vector (1 downto 0);
--Signal ii2: std_logic;
Signal ii3: std_logic;
Signal aa13: std_logic;


-- From Mem/WB
Signal k5: std_logic_vector(31 downto 0);
Signal d5: std_logic_vector(4 downto 0);
Signal g5: std_logic_vector(31 downto 0);
Signal muh5 : std_logic_vector (31 downto 0);
Signal aaaa4: std_logic;
Signal aaaa9: std_logic;
Signal aaaa15: std_logic_vector (2 downto 0);
Signal aaa13: std_logic;

---------
Signal mul : std_logic_vector (31 downto 0);
Signal mum : std_logic_vector (31 downto 0);
Signal mun : std_logic_vector (31 downto 0);
Signal muo : std_logic_vector (31 downto 0);

Signal foAE : std_logic_vector (1 downto 0);
Signal foBE : std_logic_vector (1 downto 0);
Signal foAD : std_logic;
Signal foBD : std_logic;

Signal stall_f : std_logic;
Signal stall_d : std_logic;
Signal flush_e : std_logic;
Signal bcp : std_logic;
Signal jumpp: std_logic;

BEGIN
	a10 <= a5 and not a6;

	REG_FILE		: regfile 		PORT MAP( ref_clk, reset, aaaa9, instruction2 (25 DOWNTO 21), instruction2 (20 DOWNTO 16), c1, c2, d5, mud); -- PORT MAP(clk ,reset,we,raddr_1,raddr_2,rdata_1,rdata_2,waddr,wdata);
	ALUU		: alu			PORT MAP( i1, mui, e1, f1, f2); --PORT MAP(func_in, A_in, B_in, output, Branch_out);
	CONTR		: control 		PORT MAP( ref_clk, instruction2(31 DOWNTO 26), a1, a2, a3, a4, a5, a6, a7, a8, a9,a12,a11,a14,a15,a16,a17,jumpp); -- PORT MAP(clk, instruction, RegDst, Branch, MemRead, MemToReg, ALUOP0, ALUOP1, MemWrite, ALUSrc, RegWrite, JALRMode,IRMode, LUIMode, LCMode, SCMode, dsize,JumpMode);
	DATAMEM 		: data_mem	PORT MAP( ref_clk, aaa7, aaa17,ff1, savc, g1); -- PORT MAP(clk, we, dsize, addr, dataI, dataO); --aa3 for memRead
	SIGN_EXT 	: Sign_extend 	PORT MAP( instruction2 (15 DOWNTO 0), b1); -- PORT MAP (input1,output1);
	EXTENDER 	: Extend		PORT MAP( instruction2 (10 DOWNTO 6), shamt); -- PORT MAP(input1,output1)
	ALUCONTROL	: alu_control	PORT MAP( ref_clk, l3, aa5, aa6, i1, i4,a13); -- PORT MAP (clk, instruction,ALUOP0, ALUOP1, Operation, ShiftMode, WriteMode); 
	I_MEM	 	: imem 		PORT MAP( j1, instruction1); --PORT MAP (addr,instruction);
	PC_COUNTER 	: pc			PORT MAP( ref_clk, stall_f, muf, j1); --PORT MAP (clk, i_in, i_out);
	ADDERR 		: adder		PORT MAP( j1, k1); -- PORT MAP(A_in, O_out);
	MUX6 		: mux_6		PORT MAP( instruction2 (31 DOWNTO 26), instruction2 (5 DOWNTO 0), a10, l1);
	------------------- Assignment 2
	MUX_5_A	  	: mux_5   		PORT MAP( instruction2 (20 DOWNTO 16 ),instruction2(15 downto 11), a11, mua ); --PORT MAP(in0,in1,mode,output1);
	MUX_5_B	   	: jump_mux   	PORT MAP( instruction2 (15 DOWNTO 11), a12, mub ); --PORT MAP(in0,in1,mode,output1);
	MUX_5_C	   	: mux_5    	PORT MAP( mua, mub, a1, d1 ); --PORT MAP(in0,in1,mode,output1);
	MUX_32_D   	: mux_32	   	PORT MAP( h1, k5, aaa13, mud ); --PORT MAP(in0,in1,mode,output1); 
	MUX_32_E   	: mux_32   	PORT MAP( k1, alu1, Andc, mue ); --PORT MAP(in0,in1,mode,output1);
	MUX_32_F   	: mux_32	   	PORT MAP( mue, conc, jumpp, muf ); --PORT MAP(in0,in1,mode,output1);
	--MUX_32_G  	: mux_32  	PORT MAP( conc4, ff1 ,ii2, mug); --PORT MAP(in0,in1,mode,output1);
	MUX_32_H   	: mux_32  	PORT MAP(ff1, Luiout, aaa14, muh); --PORT MAP(in0,in1,mode,output1);
	MUX_32_I   	: mux_32	   	PORT MAP (mul, shamt3, i4, mui);--PORT MAP(in0,in1,mode,output1);
	MUX_32_J		: mux_32		PORT MAP( muh5, loadc, aaaa4, h1); -- j mem 2 reg 
	MUX_32_K		: mux_32 		PORT MAP( mum, b3, aa8, e1); -- PORT MAP (k) (in0,in1, mode, output1);
	MUX_3_L		: mux_3to1	PORT MAP(cc1, mud, ff1, foAE, mul);	-- (in0, in1, in2, mode, output1);
	MUX_3_M		: mux_3to1	PORT MAP(cc2, mud, ff1, foBE, mum);	-- (in0, in1, in2, mode, output1);
	MUX_32_N   	: mux_32	   	PORT MAP( c1, ff1, foAD, mun ); --PORT MAP(in0,in1,mode,output1); 
	MUX_32_O   	: mux_32	   	PORT MAP( c2, ff1, foBD, muo ); --PORT MAP(in0,in1,mode,output1); 
	
	SHIFT_CONC	: Shift_Concat 	PORT MAP(instruction2(25 downto 0), k2(31 downto 28), conc ); --PORT MAP(s_in,p_in,output);
	SHIFT2		: ShiftL2 		PORT MAP( b1, sll2 ); --(Input,output);
	BRANCH_ADD	: branch_adder	PORT MAP (k2, sll2, alu1); -- PORT MAP(A_in,B_in,O_out); 
	ANDGATE		: And_Gate   	PORT MAP (a2, bcp, Andc); -- PORT MAP(in0,in1,out1);
	LOAD_CHOICE	: LoadChoice 	PORT MAP (g5, aaaa15, loadc); -- PORT MAP(Mem_in, LCMode, LC_out);
	SAVE_CHOICE	: SaveChoice 	PORT MAP (ccc2, aaa16, savc); -- PORT MAP(Rt_in, SCMode, SC_out);
	LUISHIFTER	: LUI_Shifter 	PORT MAP (ff1,Luiout); -- PORT MAP (Input, Output);
	------------------- Assignment 3
	BRANCH_COM	: Branch_Comp	PORT MAP ( mun, muo, bcp); --PORT MAP ( in0, in1, out1)
		
	
	IFID		: reg_IFID 		PORT MAP(ref_clk, stall_d, ANDc, jumpp , k1, instruction1 , k2, instruction2 );
	
		-- clk, stall,  flushB, flushJ, addr_in, instruction_in, addr_out, instruction_out;
	
	EXMEM	: reg_EXMEM 	PORT MAP (ref_clk, aa3,aa4,aa7,aa9,aa14,aa15,aa16,aa17,mum, a13,k3, d3, f1,
							aaa3, aaa4, aaa7, aaa9, aaa14, aaa15, aaa16, aaa17, ccc2, aa13, k4, d4, ff1);
	
		-- clk,MemRead_in,MemToReg_in,MemWrite_in,RegWrite_in,LUIMode_in,LCMode_in,SCMode_in,dsize_in,rdata_2_in
		-- WriteMode_in, addr_in, branchaddr_in,RegDstMux_in, alu_in,MemRead_out,MemToReg_out,MemWrite_out, RegWrite_out
		-- LUIMode_out,LCMode_out,SCMode_out,dsize_out,rdata_2_out, WriteMode_out,addr_out, branchaddr_out, RegDstMux_out, alu_out) ;
	
	IDEX		: reg_ID_EX 	PORT MAP(ref_clk, flush_e, a3, a4, a5, a6, a7, a8, a9, a14, a15, a16, a17, c1, c2, b1, shamt, k2, d1 , l1, instruction2 (25 downto 21), instruction2(20 downto 16), 
							aa3, aa4, aa5, aa6, aa7, aa8, aa9, aa14, aa15, aa16, aa17,cc1, cc2, b3, shamt3, k3, d3, l3, rs2, rt2);
	
		-- clk, flush, MemRead_in, MemToReg_in, ALUOP1_in, ALUOP1_in, MemWrite_in, AluSrc_in, RegWrite_in, LUIMode_in, LCMode_in, SCMode_in,dsize_in, rdata_1_in , rdata_2_in,
		-- Sign_extend_in, Extend_in, addr_in, RegDstMux_in , ALUControlMux_in, RsE_in, IRModeMux_in, MemRead_out, MemToReg_out, ALUOP0_out, ALUOP1_out, MemWrite_out, ALUSrc_out,
		-- RegWrite_out, LUIMode_out, LCMode_out, SCMode_out, dsize_out,rdata_1_out, rdata_2_out, Sign_extend_out, Extend_out, addr_out, RegDstMux_out, ALUControlMux_out, RsE_out, IRModeMux_out
	

	
	MEMWB	: reg_MEM_WB 	PORT MAP(ref_clk, aaa4, aaa9, aaa15, d4, muh, k4, g1, aa13, 
							aaaa4, aaaa9, aaaa15, d5, muh5, g5, k5, aaa13);
	
		-- clk, MemToReg_in, RegWrite_in, LCMode_in, RegDstMux_in, LUIMux_in, addr_in, dataO_in, WriteMode_in, MemToReg_out
		-- RegWrite_out, LCMode_out, RegDstMux_out, LUIMux_out, dataO_out, addr_out, WriteMode_out
	
	HAZARD	: Hazard_Unit 	PORT MAP(ref_clk, reset, rs2, rt2, instruction2 (25 downto 21) , instruction2 (20 downto 16), d4, aaa9, d5, aaaa9, aa4, aa9 , d3, a2, foAE, foBE, stall_f, stall_d, flush_e, foAD, foBD);

	-- ref_clk,  reset,  RsE,RtE, RsD, RtD, WriteRegM, RegWriteM, WriteRegW, RegWriteW, Mem2RegE, RegWriteE, WriteRegE, branchD, ForwardAE, ForwardBE, StallF, StallD, FlushE, ForwardAD, ForwardBD
	
END beh;
