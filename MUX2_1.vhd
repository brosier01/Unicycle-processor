library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity MUX2_1 is
generic(N:integer);
port ( A,B : in std_logic_vector((N-1) downto 0);
	   COM : in std_logic;
	   S   : out std_logic_vector((N-1) downto 0));
end entity MUX2_1;

architecture arch_MUX2_1 of MUX2_1 is
begin

with COM select
S<=A when '0',
   B when '1',
   (others=>'X') when others;


end architecture arch_MUX2_1;