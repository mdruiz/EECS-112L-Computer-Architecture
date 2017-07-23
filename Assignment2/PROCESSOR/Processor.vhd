library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Processor IS
port(
	ref_clk :		 in std_logic;
	--instruction :		 in std_logic_vector(31 DOWNTO 0);
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
		Func_in	 	: IN std_logic_vector (3 DOWNTO 0);
		A_in 	 	: IN std_logic_vector (31 DOWNTO 0);
		B_in 	 	: IN std_logic_vector (31 DOWNTO 0);
		O_out 	 	: OUT std_logic_vector (31 DOWNTO 0)
		-- Branch_out	: OUT std_logic ;
		-- Jump_out 	: OUT std_logic 
); 
END COMPONENT;


COMPONENT control
PORT(
		clk 		: in std_logic;
		instruction : in std_logic_vector(5 downto 0);
		RegDst		: out std_logic;
		Branch		: out std_logic;
		MemRead		: out std_logic;
		MemToReg	: out std_logic;
		ALUOP0		: out std_logic;
		ALUOP1		: out std_logic;
		MemWrite	: out std_logic;
		ALUSrc		: out std_logic;
		RegWrite	: out std_logic
); 
END COMPONENT;

COMPONENT imem
port(
	addr 		: in STD_LOGIC_VECTOR(31 downto 0);
	instruction	: out STD_LOGIC_VECTOR(31 downto 0)
);
END COMPONENT;

COMPONENT ram 
 PORT (	
		clk 	: IN std_logic;
		we 		: IN std_logic;
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
			clk: 			in std_logic;
			instruction:	in std_logic_vector(5 downto 0);
			ALUOP0:			in std_logic;
			ALUOP1:			in std_logic;
			Operation:		out std_logic_vector(3 downto 0)
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
--From instruction mem to other parts
--SIGNAL s1 : std_logic_vector(31 downto 26);
--SIGNAL s2 : std_logic_vector(25 downto 21);
--SIGNAL s3 : std_logic_vector(20 downto 16);
--SIGNAL s4 : std_logic_vector(15 downto 11);
--SIGNAL s5 : std_logic_vector(15 downto 0);
--SIGNAL s6 : std_logic_vector(5 downto 0);

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

-- From Data memory to other parts
SIGNAL g1 : std_logic_vector(31 downto 0);

-- From Second Mux near the RAM to other parts
SIGNAL h1 : std_logic_vector(31 downto 0);

-- From ALU control
SIGNAL i1 : std_logic_vector(3 downto 0);

-- Clock
-- SIGNAL clock : std_logic := '0'; 

-- From Pc to rest
SIGNAL j1 : std_logic_vector(31 downto 0);

-- From Adder to rest 
SIGNAL k1 : std_logic_vector(31 downto 0); 

-- From 6-to-1 mux before the ALU control
SIGNAL l1 : std_logic_vector(5 downto 0);

-- SIGNAL rst : std_logic := '0';
-- SIGNAL Branch_out, Jump_out : std_logic;
SIGNAL address : std_logic_vector (31 DOWNTO 0) := "00000000000000000000000000000110";
SIGNAL instruction : std_logic_vector (31 DOWNTO 0);

BEGIN
	--clock <= '0' after 50 ns when clock = '1' else '1' after 50 ns;
	--ref_clk <= '0' after 50 ns when clock = '1' else '1' after 50 ns;
	a10 <= a5 and not a6;

	COMPONENT1: regfile 	PORT MAP( ref_clk, reset, a9, instruction (25 DOWNTO 21), instruction (20 DOWNTO 16), c1, c2, d1, h1);
	COMPONENT2: alu			PORT MAP( i1, c1, e1, f1);
	COMPONENT3: control 	PORT MAP( ref_clk, instruction (31 DOWNTO 26), a1, a2, a3, a4, a5, a6, a7, a8, a9);
	COMPONENT4: ram			PORT MAP( ref_clk, a7, f1, c2, g1);
	COMPONENT5: mux2to1 	PORT MAP( c2, b1, a8, e1);
	COMPONENT6: Sign_extend PORT MAP( instruction (15 DOWNTO 0), b1);
	COMPONENT7: mux2to1_5 	PORT MAP( instruction (20 DOWNTO 16), instruction (15 DOWNTO 11), a1, d1);
	COMPONENT8: mux2to1		PORT MAP( f1, g1, a4, h1);
	COMPONENT9: alu_control PORT MAP( ref_clk, l1, a5, a6, i1);
	COMPONENT10: imem 		PORT MAP( j1, instruction);
	COMPONENT11: pc			PORT MAP( ref_clk, k1, j1);
	COMPONENT12: adder		PORT MAP( j1,(0 => '1', others=> '0'),k1);
	-------------------
	COMPONENT13: mux2to1_6	PORT MAP( instruction (31 DOWNTO 26), instruction (5 DOWNTO 0), a10, l1);
END beh;
