library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity REGISTRE32_COMMANDE_CHARGEMENT is
	port(clk : in std_logic;
		 reset : in std_logic;
		 We : in std_logic;
		 DataIn : in std_logic_vector(31 downto 0);
		 Z : in std_logic_vector(31 downto 0);
		 DataOut: out std_logic_vector(31 downto 0));
end entity;

architecture arch_REGISTRE32_COMMANDE_CHARGEMENT of REGISTRE32_COMMANDE_CHARGEMENT is
	signal S_int : std_logic_vector(31 downto 0);
begin

DataOut<=S_int;

process(reset,clk)
begin

if reset='1' then
	S_int<=(others=>'0');

elsif rising_edge(clk) then
	if We='1' then
		S_int<= Z(0) & DataIn(30 downto 0);
	end if;
end if;

end process;

end architecture;