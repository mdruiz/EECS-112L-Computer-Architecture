library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Hazard_Unit IS
port(
	ref_clk 		: in std_logic;	
	reset			: in std_logic;
	RsE			: in std_logic_vector (4 downto 0);
	RtE			: in std_logic_vector (4 downto 0); 
	RsD			: in std_logic_vector (4 downto 0);
	RtD			: in std_logic_vector (4 downto 0);
	WriteRegM		: in std_logic_vector (4 downto 0);
	RegWriteM		: in std_logic;
	WriteRegW	: in std_logic_vector (4 downto 0);
	RegWriteW	: in std_logic;
	Mem2RegE	: in std_logic;
	RegWriteE		: in std_logic;
	WriteRegE		: in std_logic_vector (4 downto 0);
	branchD		: in std_logic;
	ForwardAE		: out std_logic_vector(1 downto 0);
	ForwardBE		: out std_logic_vector(1 downto 0);
	StallF		: out std_logic;
	StallD		: out std_logic;
	FlushE		: out std_logic;
	ForwardAD	: out std_logic;
	ForwardBD	: out std_logic
	
);
END Hazard_Unit;

ARCHITECTURE beh OF Hazard_Unit IS
BEGIN
		PROCESS (ref_clk) IS
		BEGIN
-- Alu alu forwarding
			--ForwardAE
			IF((signed(RsE)  /= 0 ) AND (signed(RsE) = signed(WriteRegM)) AND (RegWriteM = '1')) then 
				ForwardAE <= "10";
			ELSIF( (signed(RsE) /= 0) AND (signed(RsE) = signed(WriteRegW)) AND (RegWriteW = '1')) then 
				ForwardAE <= "01";
			ELSE	
				ForwardAE <= "00";
			END IF;
			
			--ForwardBE
			IF((signed(RtE)  /= 0 ) AND (signed(RtE) = signed(WriteRegM)) AND (RegWriteM = '1')) then 
				ForwardBE <= "10";
			ELSIF( (signed(RtE) /= 0) AND (signed(RtE) = signed(WriteRegW)) AND (RegWriteW = '1')) then 
				ForwardBE <= "01";
			ELSE	
				ForwardBE <= "00";
			END IF;
			
			--stalling for lw and Branch Hazards
			IF (( (RsD = RtE OR RtD = RtE) AND Mem2RegE = '1' ) OR (branchD = '1' AND (RsD = WriteRegE OR RtD = WriteRegE) AND RegWriteE = '1' ) ) THEN
				StallF <= '1';
				StallD <= '1';
				FlushE <= '1';
				
			ELSE
				StallF <= '0';
				StallD <= '0';
				FlushE <= '0';
			END IF;
			
			-- forwarding for Branch Hazards
			IF (branchD = '1' AND RsD = WriteRegM AND RegWriteM ='1') THEN
				ForwardAD <= '1';
				ForwardBD <= '0';
			ELSIF(branchD = '1' AND RtD = WriteRegM AND RegWriteM ='1') THEN
				ForwardAD <= '0';
				ForwardBD <= '1';
			ELSE
				ForwardAD <= '0';
				ForwardBD <= '0';
			END IF;
			
		END PROCESS;
END beh;