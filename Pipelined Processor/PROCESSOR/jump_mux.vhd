library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY jump_mux IS
PORT (
	in0 : IN std_logic_vector(4 downto 0);
	mode : IN std_logic ;
	output1 : OUT std_logic_vector(4 downto 0)
);
END jump_mux ;

ARCHITECTURE selector OF jump_mux IS
BEGIN

WITH mode SELECT 
	output1 <= in0 WHEN '0',
		(OTHERS => '1') WHEN '1',
	(OTHERS => 'X') WHEN OTHERS;

END selector; 