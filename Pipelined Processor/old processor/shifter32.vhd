library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY shifter IS
	PORT(
	a, b: IN std_logic_vector(31 DOWNTO 0);
	mode: IN std_logic_vector(3 DOWNTO 0);
	a_shifted: OUT std_logic_vector(31 DOWNTO 0)
	);
END shifter;

ARCHITECTURE beh OF shifter IS
TYPE shift_array IS ARRAY(32 DOWNTO 0) OF std_logic_vector(31 DOWNTO 0);
SIGNAL sll_sig, srl_sig, sra_sig: shift_array;
BEGIN
	sll_sig(0) <= a;
	srl_sig(0) <= a;
	sra_sig(0) <= a;
	LL: FOR i IN 1 TO 32 GENERATE
		sll_sig(i) <= sll_sig(i-1)(30 DOWNTO 0) & '0';
	END GENERATE LL;
	RL: FOR i IN 1 TO 32 GENERATE
		srl_sig(i) <= '0' & srl_sig(i-1)(31 DOWNTO 1); 
	END GENERATE RL;
	RA: FOR i IN 1 TO 32 GENERATE
		sra_sig(i) <= a(31) & sra_sig(i-1)(31 DOWNTO 1); 
	END GENERATE RA;
	a_shifted <= 	(OTHERS => '0') WHEN b(6) = '1' OR b(7) = '1' OR b(8) = '1' OR b(9) = '1' OR
					     b(10) = '1' OR b(11) = '1' OR b(12) = '1' OR b(13) = '1' OR
					     b(14) = '1' OR b(15) = '1' OR b(16) = '1' OR b(17) = '1' OR
					     b(18) = '1' OR b(19) = '1' OR b(20) = '1' OR b(21) = '1' OR
					     b(22) = '1' OR b(23) = '1' OR b(24) = '1' OR b(25) = '1' OR
					     b(26) = '1' OR b(27) = '1' OR b(28) = '1' OR b(29) = '1' OR
					     b(30) = '1' OR b(31) = '1' ELSE
			sll_sig(to_integer(unsigned(b))) WHEN mode = "1001" ELSE
			srl_sig(to_integer(unsigned(b))) WHEN mode = "1010" ELSE
			sra_sig(to_integer(unsigned(b))) WHEN mode = "1011" ELSE
			(OTHERS => '0');
			

END beh;