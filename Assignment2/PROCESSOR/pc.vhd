library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
	port(
	clk : in std_logic;
	i_in : in std_logic_vector(31 downto 0);
	i_out : out std_logic_vector(31 downto 0) );
end pc;

architecture beh of pc is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if i_in = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" then
				i_out <= (others => '0');
			else
				i_out <= i_in;
			end if;
		end if;
	end process;
end beh;
