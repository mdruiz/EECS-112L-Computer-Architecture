library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity orgate is
Port (IN1 : in STD_LOGIC; -- OR gate input
IN2 : in STD_LOGIC; -- OR gate input
OUT1 : out STD_LOGIC); -- OR gate output
end orgate;
architecture Behavioral of orgate is
begin
OUT1 <= IN1 or IN2; -- 2 input OR gate
end Behavioral;
