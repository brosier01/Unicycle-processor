library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PC is
	port(clk : in std_logic;
		 reset : in std_logic;
		 E : in std_logic_vector(31 downto 0);
		 S: out std_logic_vector(31 downto 0));
end entity;

architecture arch_PC of PC is
	signal S_int : std_logic_vector(31 downto 0);
begin

S<=S_int;

process(clk,reset)
begin

if reset='1' then
	S_int<=(others=>'0');

elsif rising_edge(clk) then
	S_int<=E;

end if;

end process;

end architecture arch_PC;