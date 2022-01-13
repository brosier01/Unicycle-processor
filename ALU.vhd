library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity ALU is
---------------------------------------
  port ( OP :  in std_logic_vector(1 downto 0);
		 A,B : in std_logic_vector(31 downto 0);
		 S : out std_logic_vector(31 downto 0);
		 N : out std_logic_vector(31 downto 0);
		 Z : out std_logic_vector(31 downto 0));
end entity ALU;

architecture arch_ALU of ALU is
	signal S_INT : signed(31 downto 0);
begin

N<=(others=>S_INT(31));
S<=std_logic_vector(S_INT);

Z<=X"FFFFFFFF" when S_INT=X"00000000" else X"00000000"; 

process(A,B,OP)
begin
	
CASE(OP)is
when "00" => S_INT<=signed(A)+signed(B);
when "01" => S_INT<=signed(B);
when "10" => S_INT<=signed(A)-signed(B);
when "11" => S_INT<=signed(A);
when others => S_INT<=(others=>'0');

end case;



end process;

end architecture arch_ALU;