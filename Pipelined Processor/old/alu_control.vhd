library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is

port(
	clk: 			in std_logic;
	instruction:	in std_logic_vector(5 downto 0);
	ALUOP0:			in std_logic;
	ALUOP1:			in std_logic;
	Operation:		out std_logic_vector(3 downto 0)	-- changed this from 5 downto 0
);
end alu_control;

ARCHITECTURE beh OF alu_control IS	-- ALUOP0 is the leftmost bit; ALUOP 1 is the bit to the right of it
BEGIN
	PROCESS (clk, instruction, ALUOP0, ALUOP1) IS 
	BEGIN
	--	IF(ALUOP0 ='0' and ALUOP1 = '0' ) THEN							-- lw, sw
	--		Operation 	<=	"0010";
		IF(ALUOP0 ='0' and ALUOP1 = '0' and (instruction(3 downto 0) = "0011" or instruction(3 downto 0) = "1011")) THEN	-- lw, sw
			Operation 	<=	"0010";
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction(3 downto 0) ="1000") THEN	-- addi
			Operation	<=	"0010";
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction(3 downto 0) ="1100") THEN	-- andi
			Operation	<=	"0000";
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction(3 downto 0) ="1101") THEN	-- ori
			Operation	<=	"0001";
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction(3 downto 0) ="1010") THEN	-- slti
			Operation	<=	"0111";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="0000") THEN	-- add
			Operation	<=	"0010";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="0010") THEN	-- sub
			Operation	<=	"0110";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="0100") THEN	-- and
			Operation	<=	"0000";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="0101") THEN	-- or
			Operation	<=	"0001";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="1010") THEN	-- slt
			Operation	<=	"0111";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="0111") THEN	-- nor
			Operation	<=	"1100";
		ELSIF(ALUOP0 = '1' and instruction(3 downto 0) ="0110") THEN	-- xor
			Operation	<=	"1101";
		ELSIF(ALUOP0 = '0'and ALUOP1 ='1') THEN							-- beq
			Operation	<=  "0110";
		ELSE
			Operation <= "ZZZZ";
			
		END IF;
	END PROCESS;

END beh;