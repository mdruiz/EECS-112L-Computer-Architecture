library ieee;
use ieee.std_logic_1164.all;

ENTITY regfile IS
	GENERIC ( NBIT : INTEGER := 32;
		NSEL : INTEGER := 5);
	
	PORT (clk 	: IN std_logic;
		rst_s 	: IN std_logic; -- synchronous reset
		we 	: IN std_logic; -- write enable
		raddr_1 : IN std_logic_vector (NSEL -1 DOWNTO 0); -- read address 1
		raddr_2 : IN std_logic_vector (NSEL -1 DOWNTO 0); -- read address 2
		rdata_1 : OUT std_logic_vector (NBIT -1 DOWNTO 0); -- read data 1
		rdata_2 : OUT std_logic_vector (NBIT -1 DOWNTO 0); -- read data 2
		waddr 	: IN std_logic_vector (NSEL -1 DOWNTO 0); -- write address
		wdata 	: IN std_logic_vector (NBIT -1 DOWNTO 0) -- write data
		);
END regfile ;

ARCHITECTURE r_e_g_i_s_t_e_r of regfile is
	SIGNAL reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10,
		reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20,
		reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30,
		reg31 : std_logic_vector(NBIT - 1 DOWNTO 0) := (OTHERS => '0'); -- individual registers
	CONSTANT ZERO : std_logic_vector(NBIT - 1 DOWNTO 0) := "00000000000000000000000000000000";
BEGIN
	registry: PROCESS(clk, raddr_1, raddr_2, waddr, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8)
	BEGIN
		CASE raddr_1(4 DOWNTO 0) is					-- Outputting the data of the register whose addresses are entered.
			when "00001" => rdata_1 <= reg1;
			when "00010" => rdata_1 <= reg2;
			when "00011" => rdata_1 <= reg3;
			when "00100" => rdata_1 <= reg4;
			when "00101" => rdata_1 <= reg5;
			when "00110" => rdata_1 <= reg6;
			when "00111" => rdata_1 <= reg7;
			when "01000" => rdata_1 <= reg8;
			when "01001" => rdata_1 <= reg9;
			when "01010" => rdata_1 <= reg10;
			when "01011" => rdata_1 <= reg11;
			when "01100" => rdata_1 <= reg12;
			when "01101" => rdata_1 <= reg13;
			when "01110" => rdata_1 <= reg14;
			when "01111" => rdata_1 <= reg15;
			when "10000" => rdata_1 <= reg16;
			when "10001" => rdata_1 <= reg17;
			when "10010" => rdata_1 <= reg18;
			when "10011" => rdata_1 <= reg19;
			when "10100" => rdata_1 <= reg20;
			when "10101" => rdata_1 <= reg21;
			when "10110" => rdata_1 <= reg22;
			when "10111" => rdata_1 <= reg23;
			when "11000" => rdata_1 <= reg24;
			when "11001" => rdata_1 <= reg25;
			when "11010" => rdata_1 <= reg26;
			when "11011" => rdata_1 <= reg27;
			when "11100" => rdata_1 <= reg28;
			when "11101" => rdata_1 <= reg29;
			when "11110" => rdata_1 <= reg30;
			when "11111" => rdata_1 <= reg31;
			when OTHERS => rdata_1 <= ZERO;
		END CASE;
		
		CASE raddr_2(4 DOWNTO 0) is
			when "00001" => rdata_2 <= reg1;
			when "00010" => rdata_2 <= reg2;
			when "00011" => rdata_2 <= reg3;
			when "00100" => rdata_2 <= reg4;
			when "00101" => rdata_2 <= reg5;
			when "00110" => rdata_2 <= reg6;
			when "00111" => rdata_2 <= reg7;
			when "01000" => rdata_2 <= reg8;
			when "01001" => rdata_2 <= reg9;
			when "01010" => rdata_2 <= reg10;
			when "01011" => rdata_2 <= reg11;
			when "01100" => rdata_2 <= reg12;
			when "01101" => rdata_2 <= reg13;
			when "01110" => rdata_2 <= reg14;
			when "01111" => rdata_2 <= reg15;
			when "10000" => rdata_2 <= reg16;
			when "10001" => rdata_2 <= reg17;
			when "10010" => rdata_2 <= reg18;
			when "10011" => rdata_2 <= reg19;
			when "10100" => rdata_2 <= reg20;
			when "10101" => rdata_2 <= reg21;
			when "10110" => rdata_2 <= reg22;
			when "10111" => rdata_2 <= reg23;
			when "11000" => rdata_2 <= reg24;
			when "11001" => rdata_2 <= reg25;
			when "11010" => rdata_2 <= reg26;
			when "11011" => rdata_2 <= reg27;
			when "11100" => rdata_2 <= reg28;
			when "11101" => rdata_2 <= reg29;
			when "11110" => rdata_2 <= reg30;
			when "11111" => rdata_2 <= reg31;
			when OTHERS => rdata_2 <= ZERO;
		END CASE;
		
		if (rising_edge(clk) and rst_s = '1') then	-- Synchronous reset
			reg1 <= ZERO;
			reg2 <= ZERO;
			reg3 <= ZERO;
			reg4 <= ZERO;
			reg5 <= ZERO;
			reg6 <= ZERO;
			reg7 <= ZERO;
			reg8 <= ZERO;
			reg9 <= ZERO;
			reg10 <= ZERO;
			reg11 <= ZERO;
			reg12 <= ZERO;
			reg13 <= ZERO;
			reg14 <= ZERO;
			reg15 <= ZERO;
			reg16 <= ZERO;
			reg17 <= ZERO;
			reg18 <= ZERO;
			reg19 <= ZERO;
			reg20 <= ZERO;
			reg21 <= ZERO;
			reg22 <= ZERO;
			reg23 <= ZERO;
			reg24 <= ZERO;
			reg25 <= ZERO;
			reg26 <= ZERO;
			reg27 <= ZERO;
			reg28 <= ZERO;
			reg29 <= ZERO;
			reg30 <= ZERO;
			reg31 <= ZERO;
		elsif (rising_edge(clk) and we = '1') then	-- Conditions to write to register
			CASE waddr(4 DOWNTO 0) is
				when "00001" => reg1 <= wdata;
				when "00010" => reg2 <= wdata;
				when "00011" => reg3 <= wdata;
				when "00100" => reg4 <= wdata;
				when "00101" => reg5 <= wdata;
				when "00110" => reg6 <= wdata;
				when "00111" => reg7 <= wdata;
				when "01000" => reg8 <= wdata;
				when "01001" => reg9 <= wdata;
				when "01010" => reg10 <= wdata;
				when "01011" => reg11 <= wdata;
				when "01100" => reg12 <= wdata;
				when "01101" => reg13 <= wdata;
				when "01110" => reg14 <= wdata;
				when "01111" => reg15 <= wdata;
				when "10000" => reg16 <= wdata;
				when "10001" => reg17 <= wdata;
				when "10010" => reg18 <= wdata;
				when "10011" => reg19 <= wdata;
				when "10100" => reg20 <= wdata;
				when "10101" => reg21 <= wdata;
				when "10110" => reg22 <= wdata;
				when "10111" => reg23 <= wdata;
				when "11000" => reg24 <= wdata;
				when "11001" => reg25 <= wdata;
				when "11010" => reg26 <= wdata;
				when "11011" => reg27 <= wdata;
				when "11100" => reg28 <= wdata;
				when "11101" => reg29 <= wdata;
				when "11110" => reg30 <= wdata;
				when "11111" => reg31 <= wdata;
				when OTHERS => null;
			END CASE;
		END IF;
	END PROCESS;
END;
