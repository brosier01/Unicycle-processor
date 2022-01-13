library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC_EXTENDER is
port ( E : in std_logic_vector(23 downto 0);
	   S   : out std_logic_vector(31 downto 0));
end entity PC_EXTENDER;

architecture ARCH_PC_EXTENDER of PC_EXTENDER is
	signal bits : std_logic_vector(7 downto 0);
	
begin

bits<=(others=>E(23));
S<=bits & E;

end architecture ARCH_PC_EXTENDER;