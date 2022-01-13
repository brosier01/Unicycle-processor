library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity BANC_REGISTRE is
---------------------------------------
  port ( clk :  in std_logic;
		 reset : in std_logic;
		 W : in std_logic_vector(31 downto 0);
		 WE : in std_logic;
		 Rw,Ra,Rb : in std_logic_vector(3 downto 0);
		 A,B : out std_logic_vector(31 downto 0));
end entity BANC_REGISTRE;

architecture arch_BANC_REGISTRE of BANC_REGISTRE is
type table is array(15 downto 0) of std_logic_vector(31 downto 0);

function init_banc return table is
variable result : table;
begin
	for i in 14 downto 0 loop
		result(i):=(others=>'0');
	end loop;
	result(15):=X"00000030";
	return result;
end init_banc;

signal Banc :  table:=init_banc;

begin


A<=Banc(to_integer(unsigned(Ra)));
B<=Banc(to_integer(unsigned(Rb)));


process(reset,clk)
begin

if reset='1' then --reset asynchrone
	Banc<=init_banc;
elsif rising_edge(clk) then
	if WE='1' then
		Banc(to_integer(unsigned(Rw)))<=W;
	end if;
end if;	



end process;


end architecture arch_BANC_REGISTRE;