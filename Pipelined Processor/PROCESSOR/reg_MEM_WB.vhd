LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg_MEM_WB IS
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
END reg_MEM_WB;

ARCHITECTURE regina OF reg_MEM_WB IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF(clk'EVENT AND clk = '1') THEN
			MemToReg_out <= MemToReg_in;
			RegWrite_out <= RegWrite_in;
			LCMode_out <= LCMode_in;
			RegDstMux_out <= RegDstMux_in;
			LUIMux_out <= LUIMux_in;
			dataO_out <= dataO_in;
			addr_out <= addr_in;
			WriteMode_out <= WriteMode_in;

		END IF;
	END PROCESS;
END regina;			
