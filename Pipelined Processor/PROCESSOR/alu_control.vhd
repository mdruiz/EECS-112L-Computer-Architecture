library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is

port(
	clk: 				in std_logic;
	instruction:	in std_logic_vector(5 downto 0);
	ALUOP0:		in std_logic;
	ALUOP1:		in std_logic;
	Operation:		out std_logic_vector(3 downto 0);	-- changed this from 5 downto 0
	ShiftMode:		out std_logic;
	WriteMode:	out std_logic
);
end alu_control;

ARCHITECTURE beh OF alu_control IS	-- ALUOP0 is the leftmost bit; ALUOP 1 is the bit to the right of it
BEGIN
	PROCESS (clk, instruction, ALUOP0, ALUOP1) IS 
	BEGIN
	
		IF(ALUOP0 ='0' and ALUOP1 = '0' and (instruction = "100011" or instruction = "101011")) THEN	-- lw, sw
			Operation 	<=	"0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction ="001000") THEN	-- addi
			Operation	<=	"0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction ="001100") THEN	-- andi
			Operation	<=	"0000";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction ="001101") THEN	-- ori
			Operation	<=	"0001";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 ='0' and ALUOP1 = '0' and instruction ="001010") THEN	-- slti
			Operation	<=	"0111";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="100000") THEN	-- add
			Operation	<=	"0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="100010") THEN	-- sub
			Operation	<=	"0110";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="100100") THEN	-- and
			Operation	<=	"0000";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="100101") THEN	-- or
			Operation	<=	"0001";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction = "101010") THEN	-- slt
			Operation	<=	"0111";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="101011") THEN		--sltu
			Operation	<=  "1110";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="100111") THEN	-- nor
			Operation	<=	"1100";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="100110") THEN	-- xor
			Operation	<=	"1101";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="000000") THEN		--sll
			Operation	<=  "1001";
			ShiftMode	<=	'1';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="000010") THEN		--srl
			Operation	<=  "1010";
			ShiftMode	<=	'1';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="000011") THEN		--sra
			Operation	<=  "1011";
			ShiftMode	<=	'1';	
			WriteMode	<= 	'0';
		ELSIF (ALUOP0 = '1' and instruction ="001000") THEN --jr
			Operation  <= 	"0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '1' and instruction ="001001") THEN		--jalr
			Operation	<=  "0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'1';
		ELSIF(ALUOP0 = '0' and ALUOP1 ='1' and instruction ="000100") THEN		-- beq
			Operation	<=  "0110";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '0' and ALUOP1 ='1' and instruction ="000101") THEN		-- bne
			Operation	<=  "0011";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '0' and ALUOP1 ='1' and instruction ="000001") THEN		-- bltz or bgez
			Operation	<=  "0100";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '0' and ALUOP1 ='1' and instruction ="000110") THEN		-- blez
			Operation	<=  "0101";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '0' and ALUOP1 ='1' and instruction ="000111") THEN		-- bgtz
			Operation	<=  "1000";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '0' and ALUOP1 ='1' and instruction ="000010") THEN		--jump
			Operation	<=  "0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'0';
		ELSIF(ALUOP0 = '0'and ALUOP1 ='1' and instruction ="000011") THEN		--jal
			Operation	<=  "0010";
			ShiftMode	<=	'0';
			WriteMode	<= 	'1';
			
		ELSE
			Operation <= "ZZZZ";
			ShiftMode	<=	'0';
			
		END IF;
	END PROCESS;

END beh;