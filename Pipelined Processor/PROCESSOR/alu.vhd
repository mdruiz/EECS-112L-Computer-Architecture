library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY alu IS
PORT (
Func_in : IN std_logic_vector (3 DOWNTO 0);
A_in : IN std_logic_vector (31 DOWNTO 0);
B_in : IN std_logic_vector (31 DOWNTO 0);
O_out : OUT std_logic_vector (31 DOWNTO 0);
Branch_out: Out std_logic
);
END alu;


ARCHITECTURE alu_arc OF alu IS
BEGIN
	PROCESS(Func_in, A_in, B_in)
	BEGIN
		-- used codes: 0-14, not used codes: 15 (1111)
		CASE Func_in IS
			WHEN "1001" => --SLL
				O_out <= std_logic_vector(unsigned(B_in) sll to_integer(unsigned(A_in)));
				Branch_out <= '0';
			WHEN "1010" => --SRL
				O_out <= std_logic_vector(unsigned(B_in) srl to_integer(unsigned(A_in)));
				Branch_out <= '0';
			WHEN "1011" => --SRA
				O_out <= to_stdlogicvector(to_bitvector(B_in) sra to_integer(unsigned(A_in)));
				Branch_out <= '0';
			WHEN "0000" => --AND 	
				O_out <= A_in AND B_in;	
				Branch_out <= '0';
			WHEN "0001" => --OR 
				O_out <= A_in OR B_in;
				Branch_out <= '0';
			WHEN "0010" => --ADD 
				O_out <= std_logic_vector(signed(A_in) + signed(B_in));
				Branch_out <= '0';
			WHEN "0110" => --SUB and beq
				O_out <= std_logic_vector(signed(A_in) - signed(B_in)); 
				if (signed(A_in) - signed(B_in))=0 then 
					Branch_out <= '1';
				else 
					Branch_out <= '0';
				end if;
			WHEN "0111" => --SLT
				if signed(A_in) < signed(B_in) then
					O_out <= (0 => '1', others => '0');
				else
					O_out <= (others => '0');
				end if;
				Branch_out <= '0';
			WHEN "1110" => --SLT unsigned
				if unsigned(A_in) < unsigned(B_in) then
					O_out <= (0 => '1', others => '0');
				else
					O_out <= (others => '0');
				end if;
				Branch_out <= '0';
			WHEN "1100" => --NOR
				O_out <= A_in NOR B_in;
				Branch_out <= '0';
			WHEN "1101" => --XOR
				O_out <= A_in XOR B_in;
				Branch_out <= '0';
			WHEN "0011" => --bne
				O_out <= std_logic_vector(signed(A_in) - signed(B_in)); 
				if (signed(A_in) - signed(B_in))=0 then 
					Branch_out <= '0';
				else 
					Branch_out <= '1';
				end if;
			WHEN "0100" => --bltz and bgez
				O_out <= std_logic_vector(signed(A_in) - signed(B_in)); 
				if (signed(A_in) < 0) and (signed(B_in) = 0) then 
					Branch_out <= '1';
				elsif (signed(A_in) >= 0) and (signed(B_in) = 1) then 
					Branch_out <= '1';
				else 
					Branch_out <= '0';
				end if;
			WHEN "0101" => --blez
				O_out <= std_logic_vector(signed(A_in) - signed(B_in)); 
				if (signed(A_in) <= 0)  then 
					Branch_out <= '1';
				else 
					Branch_out <= '0';
				end if;
			WHEN "1000" => --bgtz
				O_out <= std_logic_vector(signed(A_in) - signed(B_in)); 
				if (signed(A_in) > 0) then 
					Branch_out <= '1';
				else 
					Branch_out <= '0';
				end if;
			WHEN others =>
				O_out <= (others => '0');
				Branch_out <= '0';
		END CASE;
	END PROCESS;
END alu_arc;
