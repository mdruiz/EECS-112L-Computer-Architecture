library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY LoadChoice IS
	PORT(
		Mem_in	: IN std_logic_vector(31 downto 0);
		LCMode	: IN std_logic_vector(2 downto 0);
		LC_out	: OUT std_logic_vector(31 downto 0)
	);
END LoadChoice;

ARCHITECTURE LCR of LoadChoice IS
BEGIN
	PROCESS (Mem_in, LCMode)
	BEGIN
		-- First 2 bits of LCMode just like dsize, last bit for regular (0)/unsigned (1) load
		IF 	(LCMode = "001") -- Load Byte unsigned
		THEN
			LC_out <= "000000000000000000000000" & Mem_in(7 downto 0);
		ELSIF 	(LCMode = "011") -- Load Half unsigned
		THEN
			LC_out <=  "0000000000000000" & Mem_in(15 downto 0);
		ELSIF 	(LCMode (2 DOWNTO 1) = "11") -- Load Word
		THEN 	
			LC_out <= Mem_in;
		ELSIF 	(LCMode = "000") -- Load Byte
		THEN 
			IF ( Mem_in(7) = '1') 
			THEN
				LC_out <= "111111111111111111111111" & Mem_in(7 downto 0);
			ELSE 
				LC_out <= "000000000000000000000000" & Mem_in(7 downto 0);
			END IF;
		ELSIF 	(LCMode = "010") -- Load Halfword
		THEN 
			IF ( Mem_in(15) = '1') 
			THEN
				LC_out <= "1111111111111111" & Mem_in(15 downto 0);
			ELSE 
				LC_out <= "0000000000000000" & Mem_in(15 downto 0);
			END IF;
		ELSE 	 -- do nothing
			LC_out <= (OTHERS => 'Z');
		END IF;
	END PROCESS;
END LCR;
