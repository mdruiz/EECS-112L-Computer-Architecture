library ieee;
use ieee.std_logic_1164.all;

ENTITY ram_tb IS
END ram_tb;

ARCHITECTURE testbench OF ram_tb IS
	COMPONENT ram 
		port (clk	: IN std_logic;
			we 	: IN std_logic;
			dsize 	: IN std_logic_vector (1 DOWNTO 0);
			addr 	: IN std_logic_vector (31 DOWNTO 0);
			dataI 	: IN std_logic_vector (31 DOWNTO 0);
			dataO 	: OUT std_logic_vector (31 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT LoadChoice
		PORT(Mem_in	: IN std_logic_vector(31 downto 0);
			LCMode	: IN std_logic_vector(2 downto 0);
			LC_out	: OUT std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT SaveChoice IS
		PORT(Rt_in	: IN std_logic_vector(31 downto 0);
			SCMode	: IN std_logic_vector(1 downto 0);
			SC_out	: OUT std_logic_vector(31 downto 0));
	END COMPONENT;
	
	SIGNAL addr_tb, dataI_tb, dataO_tb, rt_in_tb, LC_out_tb : std_logic_vector(31 DOWNTO 0);
	SIGNAL mode : std_logic_vector(2 DOWNTO 0);
	SIGNAL clk_tb, we_tb : std_logic := '0';
BEGIN
	clk_tb <= '1' after 50 ns when clk_tb = '0' else '0' after 50 ns when clk_tb = '1';

	data: ram port map (clk_tb, we_tb, mode (2 DOWNTO 1), addr_tb, dataI_tb, dataO_tb);
	load: LoadChoice port map (dataO_tb, mode, LC_out_tb);
	save: SaveChoice port map (rt_in_tb, mode (2 DOWNTO 1), dataI_tb);
END testbench;
	