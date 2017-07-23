library ieee;
use ieee.std_logic_1164.all;	-- Allan was here
use ieee.numeric_std.all;	-- Changed from word-addressable to byte-addressable

ENTITY ram IS
	port (clk	: IN std_logic;
		we 	: IN std_logic;
		dsize 	: IN std_logic_vector (1 DOWNTO 0);
		addr 	: IN std_logic_vector (31 DOWNTO 0);
		dataI 	: IN std_logic_vector (31 DOWNTO 0);
		dataO 	: OUT std_logic_vector (31 DOWNTO 0));
END ram;

ARCHITECTURE mem OF ram IS
	TYPE memory IS array (2047 DOWNTO 0) of std_logic_vector (7 DOWNTO 0);
	SIGNAL bleh : memory := (OTHERS => (OTHERS => '0'));			-- where all the data is stored
BEGIN
	data: PROCESS (clk, we, dsize, addr, dataI)
	BEGIN
		IF (dsize = "11")					-- lw
		THEN
			dataO <= bleh(to_integer(unsigned(addr(10 DOWNTO 0)))) & 
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 1) & 
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 2) & 
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 3);
		ELSIF (dsize = "01")					-- lh, lhu
		THEN
			dataO <= (31 DOWNTO 16 => '-') & 
			bleh(to_integer(unsigned(addr(10 DOWNTO 0)))) & 
			bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 1);
		ELSIF (dsize = "00")					-- lb, lbu
		THEN	
			dataO <= (31 DOWNTO 8 => '-') & bleh(to_integer(unsigned(addr(10 DOWNTO 0))));
		ELSE
			dataO <= (OTHERS => 'Z');
		END IF;

		IF (rising_edge(clk) and we = '1')
		THEN
			IF (dsize = "11")				-- sw
			THEN
				bleh(to_integer(unsigned(addr(10 DOWNTO 0)))) 	<= dataI (31 DOWNTO 24);
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 1) <= dataI (23 DOWNTO 16);
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 2) <= dataI (15 DOWNTO 8);
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 3) <= dataI (7 DOWNTO 0);
			ELSIF (dsize = "01")				-- sh
			THEN	
				bleh(to_integer(unsigned(addr(10 DOWNTO 0)))) 	<= dataI (15 DOWNTO 8);
				bleh(to_integer(unsigned(addr(10 DOWNTO 0))) + 1) <= dataI (7 DOWNTO 0);
			ELSIF (dsize = "00")				-- sb
			THEN	
				bleh(to_integer(unsigned(addr(10 DOWNTO 0)))) 	<= dataI (7 DOWNTO 0);
			ELSE
				null;
			END IF;
		END IF;
	END PROCESS;
END;