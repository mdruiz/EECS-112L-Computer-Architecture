library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY mux_3to1 IS
PORT (
	in0 : IN std_logic_vector(31 downto 0);
	in1 : IN std_logic_vector(31 downto 0);
	in2 : IN std_logic_vector(31 downto 0);
	mode : IN std_logic_vector(1 downto 0) ;
	output1 : OUT std_logic_vector(31 downto 0)
);
END mux_3to1;

ARCHITECTURE selector OF mux_3to1 IS
BEGIN
WITH mode SELECT 
	output1 <= in0 WHEN "00",
			   in1 WHEN "01",
			 in2 WHEN OTHERS;

END selector;  