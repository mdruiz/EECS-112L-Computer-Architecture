library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY ShiftL2 IS

port(
	Input: 		in std_logic_vector(31 downto 0);
	Output:		out std_logic_vector(31 downto 0)
);
end ShiftL2;

ARCHITECTURE beh OF ShiftL2 IS 
	
BEGIN
	Output <= Input(29 downto 0) & "00";

END beh;	