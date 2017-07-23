library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY Shift_Concat IS
PORT(
	s_in 	: IN std_logic_vector(25 downto 0);
	p_in 	: IN std_logic_vector(3 downto 0);
	o_out : OUT std_logic_vector(31 downto 0)
);
END Shift_Concat;

ARCHITECTURE Conc OF Shift_Concat IS
BEGIN
	o_out <= p_in & s_in & "00"; 
END Conc;