library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity MEMOIRE_DONNEES is
---------------------------------------
  port ( clk :  in std_logic;
		 reset : in std_logic;
		 WrEn : in std_logic;
		 Addr : in std_logic_vector(5 downto 0);
		 DataIn : in std_logic_vector(31 downto 0);
		 DataOut : out std_logic_vector(31 downto 0));
end entity MEMOIRE_DONNEES;

architecture ARCH_MEMOIRE_DONNEES of MEMOIRE_DONNEES is

type table is array(63 downto 0) of std_logic_vector(31 downto 0);

function init_banc return table is
variable result : table;
begin
	for i in 62 downto 0 loop
		result(i):=(others=>'0');
	end loop;
	result(63):=X"00000001";
	result(16):=X"00000030";
	result(17):=X"00000001";
	result(18):=X"00000001";
	result(19):=X"00000001";
	result(20):=X"00000001";
	result(21):=X"00000001";
	result(22):=X"00000001";
	result(23):=X"00000001";
	result(24):=X"00000001";
	result(25):=X"00000001";
	result(26):=X"00000001";
	result(27):=X"00000001";
	result(32):= x"00000003";
	result(33):= x"0000006B";
	result(34):= x"0000001B";
	result(35):= x"0000000C";
	result(36):= x"00000142";
	result(37):= x"0000009B";
	result(38):= x"0000003F";
	result(41):=X"00000001";
	return result;
end init_banc;

signal Banc :  table:=init_banc;

begin

DataOut<=Banc(to_integer(unsigned(Addr)));

process(clk,reset)
begin

if reset='1' then --reset asynchrone
	Banc<=init_banc;
elsif rising_edge(clk) then
	if WrEn='1' then
		Banc(to_integer(unsigned(Addr)))<=DataIn;
	end if;
end if;	

end process;



end architecture ARCH_MEMOIRE_DONNEES;