library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY LUI_Shifter IS

port(
	Input: 		in std_logic_vector(31 downto 0);
	Output:		out std_logic_vector(31 downto 0)
);
end LUI_Shifter;

ARCHITECTURE beh OF LUI_Shifter IS 
	
BEGIN
	Output <= Input(15 downto 0) & "0000000000000000";

END beh;	