library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY test IS

port(
	Input: 		in std_logic;
	Output:		out std_logic
);
end test;

ARCHITECTURE beh OF test IS 
	
BEGIN
	Output <= Input;

END beh;	