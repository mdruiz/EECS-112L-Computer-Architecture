library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY alu IS
PORT (
Func_in : IN std_logic_vector (3 DOWNTO 0);
A_in : IN std_logic_vector (31 DOWNTO 0);
B_in : IN std_logic_vector (31 DOWNTO 0);
O_out : OUT std_logic_vector (31 DOWNTO 0)
);
END alu;


ARCHITECTURE alu_arc OF alu IS
BEGIN
	PROCESS(Func_in, A_in, B_in)
	BEGIN
		CASE Func_in IS
			WHEN "0000" => --AND 	
				O_out <= A_in AND B_in;	
			WHEN "0001" => --OR 
				O_out <= A_in OR B_in;
			WHEN "0010" => --ADD 
				O_out <= std_logic_vector(signed(A_in) + signed(B_in));
			WHEN "0110" => --SUB
				O_out <= std_logic_vector(signed(A_in) - signed(B_in)); 
			WHEN "0111" => --SLT
				if signed(A_in) < signed(B_in) then
					O_out <= (0 => '1', others => '0');
				else
					O_out <= (others => '0');
				end if;
			WHEN "1100" => --NOR
				O_out <= A_in NOR B_in;
			WHEN "1101" => --XOR
				O_out <= A_in XOR B_in;
			WHEN others =>
				O_out <= (others => '0');
		END CASE;
	END PROCESS;
END alu_arc;
