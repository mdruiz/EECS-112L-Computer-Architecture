library ieee;
use ieee.std_logic_1164.all;			-- Allan was here
use ieee.numeric_std.all;

ENTITY ram IS
	port (	clk 	: IN std_logic;
		we 	: IN std_logic;
		addr 	: IN std_logic_vector (31 DOWNTO 0);
		dataI 	: IN std_logic_vector (31 DOWNTO 0);
		dataO 	: OUT std_logic_vector (31 DOWNTO 0));
END ram;

ARCHITECTURE mem OF ram IS
	TYPE memory IS array (511 DOWNTO 0) of std_logic_vector (31 DOWNTO 0);
	SIGNAL bleh : memory := (OTHERS => (OTHERS => '0'));
BEGIN
	data: PROCESS (clk, we, addr, dataI)
	BEGIN
		dataO <= bleh(to_integer(unsigned(addr (8 DOWNTO 0))));

		IF (rising_edge(clk) and we = '1')
		THEN
			bleh(to_integer(unsigned(addr (8 DOWNTO 0)))) <= dataI;
		END IF;
	END PROCESS;
END;
