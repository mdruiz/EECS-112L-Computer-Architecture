library ieee;
use ieee.std_logic_1164.all;
 ENTITY reg_ID_EX IS
	PORT(
		clk : 				in std_logic;
		flush :			in std_logic;
		MemRead_in:		in std_logic;
		MemToReg_in:		in std_logic;
		ALUOP0_in:		in std_logic;
		ALUOP1_in:		in std_logic;
		MemWrite_in:		in std_logic;
		ALUSrc_in:		in std_logic;
		RegWrite_in:		in std_logic;
		LUIMode_in: 		in std_logic;
		LCMode_in: 		in std_logic_vector(2 downto 0);
		SCMode_in:		in std_logic_vector(1 downto 0);
		dsize_in:			in std_logic_vector(1 downto 0);
		rdata_1_in: 		in std_logic_vector (31 downto 0); -- read data 1
		rdata_2_in : 		in std_logic_vector (31 downto 0); -- read data 2
		Sign_extend_in:		in std_logic_vector (31 downto 0);
		Extend_in:			in std_logic_vector (31 downto 0);
		addr_in :			in std_logic_vector (31 downto 0);
		RegDstMux_in:		in std_logic_vector ( 4 downto 0);
		--jumpaddr_in :		in std_logic_vector (31 downto 0);
		ALUControlMux_in:	in std_logic_vector (5 downto 0);	
		RsE_in:			in std_logic_vector (4 downto 0);
		IRModeMux_in:		in std_logic_vector (4 downto 0);
		MemRead_out:		out std_logic;
		MemToReg_out:		out std_logic;
		ALUOP0_out:		out std_logic;
		ALUOP1_out:		out std_logic;
		MemWrite_out:		out std_logic;
		ALUSrc_out:		out std_logic;
		RegWrite_out:		out std_logic;
		LUIMode_out: 		out std_logic;
		LCMode_out: 		out std_logic_vector(2 downto 0);
		SCMode_out:		out std_logic_vector(1 downto 0);
		dsize_out:			out std_logic_vector(1 downto 0);
		rdata_1_out : 		out std_logic_vector (31 downto 0); -- read data 1
		rdata_2_out : 		out std_logic_vector (31 downto 0); -- read data 2
		Sign_extend_out:	out std_logic_vector (31 downto 0);
		Extend_out:		out std_logic_vector (31 downto 0);
		addr_out :			out std_logic_vector (31 downto 0);
		RegDstMux_out:	out std_logic_vector ( 4 downto 0);
		--jumpaddr_out :		out std_logic_vector (31 downto 0);
		ALUControlMux_out:	out std_logic_vector (5 downto 0);
		RsE_out:			out std_logic_vector (4 downto 0);
		IRModeMux_out:	out std_logic_vector (4 downto 0)
	
);
END reg_ID_EX;
	
ARCHITECTURE reg OF reg_ID_EX IS
BEGIN
	PROCESS (clk) IS
	BEGIN
		IF (clk'event and clk = '1') THEN
			
			IF (flush = '0') THEN
				MemRead_out <= MemRead_in;
				MemToReg_out <= MemToReg_in;
				ALUOP0_out <= ALUOP0_in;
				ALUOP1_out <= ALUOP1_in;
				MemWrite_out <= MemWrite_in;
				ALUSrc_out <= ALUSrc_in;
				RegWrite_out <= RegWrite_in;
				LUIMode_out <= LUIMode_in;
				LCMode_out <= LCMode_in;
				SCMode_out <= SCMode_in;
				dsize_out <= dsize_in;
				rdata_1_out <= rdata_1_in;
				rdata_2_out <= rdata_2_in;
				Sign_extend_out <= Sign_extend_in;
				Extend_out <= Extend_in;
				addr_out <= addr_in;
				RegDstMux_out <= RegDstMux_in;
				--jumpaddr_out <= jumpaddr_in;
				ALUControlMux_out <= ALUControlMux_in;
				RsE_out <= RsE_in;
				IRModeMux_out <= IRModeMux_in;
			
			ELSE
				MemRead_out <= 'X';
				MemToReg_out <= 'X';
				ALUOP0_out <= 'X';
				ALUOP1_out <= 'X';
				MemWrite_out <= 'X';
				ALUSrc_out <= 'X';
				RegWrite_out <= 'X';
				LUIMode_out <= 'X';
				LCMode_out <= "XXX";
				SCMode_out <= "XX";
				dsize_out <= "XX";
				rdata_1_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				rdata_2_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				Sign_extend_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				Extend_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				addr_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				RegDstMux_out <= "XXXXX";
				--jumpaddr_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				ALUControlMux_out <= "XXXXXX";
				RsE_out <= "XXXXX";
				IRModeMux_out <= "XXXXX";
			END IF;	
			
		END IF;
	END PROCESS;
	
END reg;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	