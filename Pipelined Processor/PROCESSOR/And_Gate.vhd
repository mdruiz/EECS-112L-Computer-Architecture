library ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY And_Gate IS
PORT(
		in0 : 	IN std_logic;
		in1 : 	IN std_logic;
		out1:	OUT std_logic
);
END And_Gate;

ARCHITECTURE ander OF And_Gate IS
BEGIN
	
	out1 <= in0 and in1;
END ander;