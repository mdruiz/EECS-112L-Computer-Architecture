library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY mux_5 IS
PORT (
	in0 : IN std_logic_vector(4 downto 0);
	in1 : IN std_logic_vector(4 downto 0);
	mode : IN std_logic ;
	output1 : OUT std_logic_vector(4 downto 0)
);
END mux_5 ;

ARCHITECTURE selector OF mux_5 IS
BEGIN

WITH mode SELECT 
	output1 <= in1 WHEN '1',
			 in0 WHEN OTHERS;

END selector;  