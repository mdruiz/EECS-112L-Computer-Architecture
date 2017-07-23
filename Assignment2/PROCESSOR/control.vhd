library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
--USE work.c31L_pack.all; 

ENTITY control IS

port(
		clk : 			in std_logic;
		instruction : 	in std_logic_vector(5 downto 0);
		RegDst:			out std_logic;
		Branch:			out std_logic;
		MemRead:		out std_logic;
		MemToReg:		out std_logic;
		ALUOP0:			out std_logic;
		ALUOP1:			out std_logic;
		MemWrite:		out std_logic;
		ALUSrc:			out std_logic;
		RegWrite:		out std_logic
);
end control;

ARCHITECTURE beh OF control IS 
BEGIN
		PROCESS (clk, instruction) IS
		BEGIN
			IF(instruction = "000000") THEN	-- Rtype
				ALUSrc 		<= '0';
				MemToReg	<= '0';
				RegDst		<= '1';
				RegWrite	<= '1';
				Branch		<= '0';
				MemWrite	<= '0';
				ALUOP0 		<= '1';
				ALUOP1		<= '0';
				MemRead		<= '0';
			ELSIF (instruction = "100011") THEN -- Load
				ALUSrc 		<= '1';
				MemToReg	<= '1';
				RegDst		<= '0';
				RegWrite	<= '1';
				Branch		<= '0';
				MemWrite	<= '0';
				ALUOP0		<= '0';
				ALUOP1		<= '0';
				MemRead		<= '1';
			ELSIF (instruction = "101011") THEN -- Store
				ALUSrc 		<= '1';
				MemToReg	<= 'X';
				RegDst		<= 'X';
				RegWrite	<= '0';	
				Branch		<= '0';
				MemWrite	<= '1';
				ALUOP0		<= '0';
				ALUOP1		<= '0';
				MemRead		<= '0';
			ELSIF (instruction = "000100") THEN -- Branch
				ALUSrc 		<= '0';
				MemToReg	<= 'X';
				RegDst		<= 'X';
				RegWrite	<= '0';	
				Branch		<= '1';
				MemWrite	<= '0';
				ALUOP0		<= '0';
				ALUOP1		<= '1';
				MemRead		<= '0';
			ELSE 						--OTHER		-- Possibly for I-type instructions (the uncommented stuff)
			--	ALUSrc 		<= 'X';
			--	MemToReg	<= 'X';
			--	RegDst		<= 'X';
			--	RegWrite	<= 'X';	
			--	Branch		<= 'X';
			--	MemWrite	<= 'X';
			--	ALUOP0		<= 'X';
			--	ALUOP1		<= 'X';
			--	MemRead		<= '0';
				ALUSrc 		<= '1';
				MemToReg	<= '0';
				RegDst		<= '0';
				RegWrite	<= '1';
				Branch		<= '0';
				MemWrite	<= '0';
				ALUOP0 		<= '0';
				ALUOP1		<= '0';
				MemRead		<= '0';
			END IF;
		END PROCESS;

END beh;		