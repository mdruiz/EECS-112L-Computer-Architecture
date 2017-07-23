LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg_IFID IS
PORT (
	clk 		: IN std_logic ;
	stall		: IN std_logic ;
	flushB 	: IN std_logic ;
	flushJ	: IN std_logic ; 
	addr_in 	: IN std_logic_vector (31 downto 0); -- input data
	instruction_in 	: IN std_logic_vector (31 downto 0); -- input data
	addr_out 	: OUT std_logic_vector (31 downto 0); -- output data
	instruction_out : OUT std_logic_vector (31 downto 0) -- output data
);
END reg_IFID;

ARCHITECTURE regina OF reg_IFID IS
BEGIN
	PROCESS(clk, addr_in, instruction_in)
	VARIABLE addr, instruction: std_logic_vector(31 downto 0);
	BEGIN
		addr := addr_in;
		instruction := instruction_in;
		IF(clk'EVENT AND clk = '1' AND stall = '0' ) THEN
			IF ( flushB ='0' AND flushJ = '0' )THEN 
				addr_out <= addr;
				instruction_out <= instruction; 
			ELSE 
				addr_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				instruction_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
			END IF;
			
		END IF;
	END PROCESS;
END regina;			
