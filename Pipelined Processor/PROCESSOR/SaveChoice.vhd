library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY SaveChoice IS
	PORT(
		Rt_in	: IN std_logic_vector(31 downto 0);
		SCMode	: IN std_logic_vector(1 downto 0);
		SC_out	: OUT std_logic_vector(31 downto 0)
	);
END SaveChoice;

ARCHITECTURE SCR of SaveChoice IS
BEGIN
	PROCESS (Rt_in, SCMode)
	BEGIN
		IF	(SCMode = "00") -- Save Byte
		THEN
			SC_out <= "000000000000000000000000" & Rt_in(7 downto 0);
		ELSIF	(SCMode = "01") -- Save HalfWord
		THEN
			SC_out <= "0000000000000000" & Rt_in(15 downto 0);
		ELSIF 	(SCMode = "11")	-- Save Word
		THEN
			SC_out <= Rt_in;
		ELSE			-- do nothing
			SC_out <= (OTHERS => 'Z');
		END IF;
	END PROCESS;
END SCR;
