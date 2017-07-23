LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg_EXMEM IS
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
	WriteMode_out 	: out std_logic;
	addr_out 		: out std_logic_vector (31 downto 0);
	--jumpaddr_out 	: out std_logic_vector (31 downto 0);
	RegDstMux_out	: out std_logic_vector ( 4 downto 0);
	alu_out 	: OUT std_logic_vector (31 downto 0)
);
END reg_EXMEM;

ARCHITECTURE regina OF reg_EXMEM IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			alu_out <= alu_in;
			MemRead_out <= MemRead_in;
			MemToReg_out <= MemToReg_in;
			MemWrite_out <= MemWrite_in;
			RegWrite_out <= RegWrite_in;
			LUIMode_out <= LUIMode_in;
			LCMode_out <= LCMode_in;
			SCMode_out <= SCMode_in;
			dsize_out <= dsize_in;
			rdata_2_out <= rdata_2_in;
			--JRMode_out <= JRMode_in;
			--JumpMode_out <= JumpMode_in;
			WriteMode_out <= WriteMode_in;
			addr_out <= addr_in;
			--jumpaddr_out <= jumpaddr_in;
			RegDstMux_out <= RegDstMux_in;
		END IF;
	END PROCESS;
END regina;			
