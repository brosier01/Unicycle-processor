library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity EXTENSION_SIGNE is
generic(N:integer);
port ( E : in std_logic_vector((N-1) downto 0);
	   S   : out std_logic_vector(31 downto 0));
end entity EXTENSION_SIGNE;

architecture arch_EXTENSTION_SIGNE of EXTENSION_SIGNE is
	signal bits : std_logic_vector((32-N-1) downto 0);
	
begin

bits<=(others=>E(N-1));
S<=bits & E;

end architecture arch_EXTENSTION_SIGNE;