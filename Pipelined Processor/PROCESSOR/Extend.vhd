library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Extend IS
PORT(
    input1    	 : in 	std_logic_vector(4 downto 0);
    output1   	 : out	std_logic_vector(31 downto 0)
);
END Extend;

ARCHITECTURE sign OF Extend IS

	--SIGNAL msb: std_logic;

BEGIN
	PROCESS(input1) is
	BEGIN
		output1 <= "000000000000000000000000000" & input1;
	END PROCESS;
END sign;


