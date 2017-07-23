library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY mux_32 IS
PORT (
	in0 : IN std_logic_vector(31 downto 0);
	in1 : IN std_logic_vector(31 downto 0);
	mode : IN std_logic ;
	output1 : OUT std_logic_vector(31 downto 0)
);
END mux_32;

ARCHITECTURE selector OF mux_32 IS
BEGIN

WITH mode SELECT 
	output1 <= in0 WHEN '0',
		in1 WHEN '1',
		(OTHERS => 'X') WHEN OTHERS;

END selector; 