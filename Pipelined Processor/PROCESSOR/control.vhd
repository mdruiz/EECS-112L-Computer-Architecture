library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY control IS

port(
		clk : 			in std_logic;
		instruction : 		in std_logic_vector(5 downto 0);
		RegDst:			out std_logic;
		Branch:			out std_logic;
		MemRead:		out std_logic;
		MemToReg:		out std_logic;
		ALUOP0:			out std_logic;
		ALUOP1:			out std_logic;
		MemWrite:		out std_logic;
		ALUSrc:			out std_logic;
		RegWrite:		out std_logic;
		JALRMode: 		out std_logic;
		IRMode: 		out std_logic;
		LUIMode: 		out std_logic;
		LCMode: 		out std_logic_vector(2 downto 0);
		SCMode:			out std_logic_vector(1 downto 0);
		dsize:			out std_logic_vector(1 downto 0);
		JumpMode:	out std_logic
);
end control;

ARCHITECTURE beh OF control IS 
BEGIN
		PROCESS (clk, instruction) IS
		BEGIN
			IF(instruction = "000000") THEN	-- Rtype including (SLL or SRL or SRA)  and JRMode (function = 001000) and - JALR (function = 001001)
				RegDst		<= '0';
				Branch		<= '0';
				MemRead		<= '0';
				MemToReg	<= '0';
				ALUOP0 		<= '1';
				ALUOP1		<= '0';
				MemWrite		<= '0';
				ALUSrc 		<= '0';
				RegWrite		<= '1';
				JALRMode		<= '0'; -- X
				IRMode		<= '1';
				LUIMode		<= '0';
				LCMode		<= "000"; --XXX
				SCMode		<= "11"; -- XX
				dsize			<= "10";
				JumpMode		<= '0';
				
			ELSIF (instruction = "100011") THEN -- Load (lw)
				RegDst		<= '0';
				Branch		<= '0';
				MemRead		<= '1';
				MemToReg	<= '1';
				ALUOP0 		<= '0';
				ALUOP1		<= '0';
				MemWrite		<= '0';
				ALUSrc 		<= '1';
				RegWrite		<= '1';
				JALRMode		<= '0'; --X
				IRMode		<= '0';
				LUIMode		<= '0';
				LCMode		<= "010";
				SCMode		<= "11"; -- XX
				dsize			<= "11";
				JumpMode		<= '0';

			ELSIF (instruction = "101011") THEN -- Store (sw)
				RegDst		<= '0'; -- X
				Branch		<= '0';
				MemRead		<= '1';
				MemToReg	<= '1'; -- X
				ALUOP0 		<= '0';
				ALUOP1		<= '0';
				MemWrite		<= '1';
				ALUSrc 		<= '1';
				RegWrite		<= '0';
				JALRMode		<= '0'; -- X
				IRMode		<= '0'; -- X
				LUIMode		<= '0'; -- X
				LCMode		<= "000"; -- XXX
				SCMode		<= "11";
				dsize			<= "11";
				JumpMode		<= '0';

			ELSIF ((instruction = "000100") or (instruction = "000101") or (instruction = "000001") or  (instruction = "000110") or (instruction = "000111") )   THEN -- Branch (beq, bne, bltz, bgez, blez, bgtz)
				RegDst			<= '0'; -- X
				Branch			<= '1';
				MemRead		<= '0';
				MemToReg	<= '0'; --X 
				ALUOP0 		<= '0';
				ALUOP1			<= '1';
				MemWrite		<= '0';
				ALUSrc 			<= '0';
				RegWrite		<= '0';
				JALRMode		<= '0'; -- X
				IRMode			<= '1'; --X
				LUIMode		<= '0'; -- X
				LCMode			<= "000"; -- XXX
				SCMode		<= "11";
				dsize				<= "10";
				JumpMode		<= '0';
				
			ELSIF (instruction = "000010") THEN  -- Jump 
				RegDst			<= '0'; -- X
				Branch			<= '0';
				MemRead		<= '0';
				MemToReg	<= '0'; -- X
				ALUOP0 		<= '0'; 
				ALUOP1			<= '1';
				MemWrite		<= '0';
				ALUSrc 			<= '0'; -- X
				RegWrite		<= '0';
				JALRMode		<= '0'; -- X
				IRMode			<= '0'; -- X
				LUIMode		<= '0'; -- X
				LCMode			<= "000";
				SCMode		<= "11";
				dsize				<= "10";
				JumpMode		<= '1';
				
			ELSIF (instruction = "000011") THEN -- JAL
				RegDst			<= '1';
				Branch			<= '0';
				MemRead		<= '0';
				MemToReg	<= '0'; -- X
				ALUOP0 		<= '0';
				ALUOP1			<= '1';
				MemWrite		<= '0';
				ALUSrc 			<= '0'; -- X
				RegWrite		<= '1';
				JALRMode		<= '0';
				IRMode			<= '0'; -- X
				LUIMode		<= '0';
				LCMode			<= "000";
				SCMode		<= "11";
				dsize				<= "10";
				JumpMode		<= '1';
				
			ELSIF (instruction = "100000" ) THEN -- LB Load Byte 
				RegDst			<= '0';
				Branch			<= '0';
				MemRead		<= '1';
				MemToReg	<= '1';
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '0';
				ALUSrc 			<= '1';
				RegWrite		<= '1';
				JALRMode		<= '0'; -- X
				IRMode			<= '0';
				LUIMode		<= '0';
				LCMode			<= "000";
				SCMode		<= "11"; 
				dsize				<= "00";
				JumpMode		<= '0';
			
			ELSIF (instruction = "100001" ) THEN --LH Load HalfWord
				RegDst			<= '0';
				Branch			<= '0';
				MemRead		<= '1';
				MemToReg	<= '1';
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '0';
				ALUSrc 			<= '1';
				RegWrite		<= '1';
				JALRMode		<= '0';
				IRMode			<= '0';
				LUIMode		<= '0';
				LCMode			<= "001";
				SCMode		<= "11"; 
				dsize				<= "01";
				JumpMode		<= '0';
				
			ELSIF (instruction = "100100") THEN --LBU
				RegDst			<= '0';
				Branch			<= '0';
				MemRead		<= '1';
				MemToReg	<= '1';
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '0';
				ALUSrc 			<= '1';
				RegWrite		<= '1';
				JALRMode		<= '0';
				IRMode			<= '0';
				LUIMode		<= '0';
				LCMode			<= "011";
				SCMode		<= "11";
				dsize				<= "00";
				JumpMode		<= '0';
				
			ELSIF (instruction = "100101") THEN --LHU
				RegDst			<= '0';
				Branch			<= '0';
				MemRead		<= '1';
				MemToReg	<= '1';
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '0';
				ALUSrc 			<= '1';
				RegWrite		<= '1';
				JALRMode		<= '0';
				IRMode			<= '0';
				LUIMode		<= '0';
				LCMode			<= "100";
				SCMode		<= "11";
				dsize				<= "01";
				JumpMode		<= '0';
				
			ELSIF (instruction = "101000") THEN --SB
				RegDst			<= '0'; -- X
				Branch			<= '0';
				MemRead		<= '1';
				MemToReg	<= '1'; -- X
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '1';
				ALUSrc 			<= '1';
				RegWrite		<= '0';
				JALRMode		<= '0'; -- X
				IRMode			<= '0'; -- X
				LUIMode		<= '0'; -- X
				LCMode			<= "101"; -- XXX
				SCMode		<= "00";
				dsize				<= "00";
				JumpMode		<= '0';
				
			ELSIF (instruction = "101001") THEN --SH
				RegDst			<= '0'; -- X
				Branch			<= '0';
				MemRead		<= '1';
				MemToReg	<= '1'; -- X
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '1';
				ALUSrc 			<= '1';
				RegWrite		<= '0';
				JALRMode		<= '0'; -- X
				IRMode			<= '0'; -- X
				LUIMode		<= '0'; -- X
				LCMode			<= "110"; -- XX
				SCMode		<= "01";
				dsize				<= "01";
				JumpMode		<= '0';

			ELSE 						--I-type instructions 
				RegDst			<= '0';
				Branch			<= '0';
				MemRead		<= '0';
				MemToReg	<= '0';
				ALUOP0 		<= '0';
				ALUOP1			<= '0';
				MemWrite		<= '0';
				ALUSrc 			<= '1';
				RegWrite		<= '1';
				JALRMode		<= '0'; -- X
				IRMode			<= '0';
				LUIMode		<= '0';
				LCMode			<= "000"; --XXX
				SCMode		<= "11"; -- XX
				dsize				<= "00";
				JumpMode		<= '0';

			END IF;
		END PROCESS;

END beh;		