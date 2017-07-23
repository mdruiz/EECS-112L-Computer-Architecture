library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Sign_extend IS
PORT(
    input1    	 : in 	std_logic_vector(15 downto 0);
    output1   	 : out	std_logic_vector(31 downto 0)
);
END Sign_extend;

ARCHITECTURE sign OF Sign_extend IS

	--SIGNAL msb: std_logic;

BEGIN
	PROCESS(input1) is
	BEGIN
		--msb <= (input1(15));
		IF ((input1(15)) = '1') THEN
		output1 <= "1111111111111111" & input1;
    
		ELSE 
		output1 <= "0000000000000000" & input1;
		END IF;
	END PROCESS;
END sign;


