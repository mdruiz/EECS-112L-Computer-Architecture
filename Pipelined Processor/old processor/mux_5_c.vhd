library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY mux_5_c IS
PORT (
	in0 : IN std_logic_vector(4 downto 0);
	in1 : IN std_logic_vector(4 downto 0);
	mode : IN std_logic ;
	output1 : OUT std_logic_vector(4 downto 0)
);
END mux_5_c ;

ARCHITECTURE selector OF mux_5_c IS
BEGIN

WITH mode SELECT 
	output1 <= in0 WHEN '0',
					in1 WHEN '1',
	(OTHERS => 'X') WHEN OTHERS;

END selector; 