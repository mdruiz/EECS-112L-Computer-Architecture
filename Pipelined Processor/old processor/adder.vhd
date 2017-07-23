library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY adder IS
	PORT(
	A_in, B_in : IN STD_LOGIC_VECTOR(31 downto 0);
	O_out : OUT STD_LOGIC_VECTOR(31 downto 0));
END adder;

ARCHITECTURE beh OF adder IS
BEGIN 
O_out <= std_logic_vector(signed(A_in) + signed(B_in));
END beh;