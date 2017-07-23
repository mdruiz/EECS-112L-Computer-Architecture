library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Branch_Comp IS 
PORT(
	in0		: in std_logic_vector(31 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	out1	: out std_logic	
);
END Branch_Comp;

ARCHITECTURE beh OF Branch_Comp IS 
BEGIN
	PROCESS(in0,in1) is
	BEGIN
		IF (in0 = in1) then 
			out1 <= '1';
		ELSE 
			out1 <= '0';
		END If;
	END PROCESS;
END beh;