library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UNITE_GESTION_INSTRUCTIONS is
---------------------------------------
  port ( clk :  in std_logic;
		 reset : in std_logic;
		 nPCsel : in std_logic;
		 Offset : in std_logic_vector(23 downto 0);
		 Instruction : out std_logic_vector(31 downto 0));
end entity UNITE_GESTION_INSTRUCTIONS;

architecture arch_UNITE_GESTION_INSTRUCTIONS of UNITE_GESTION_INSTRUCTIONS is

	signal ext_pc : std_logic_vector(31 downto 0);
	signal ext_mux : std_logic_vector(31 downto 0);
	signal ext_extender : std_logic_vector(31 downto 0);
	signal pc_plus_un : std_logic_vector(31 downto 0);
	signal pc_plus_offset : std_logic_vector(31 downto 0);

begin


pc_plus_un<=std_logic_vector(signed(ext_pc) + 1);
pc_plus_offset<=std_logic_vector(signed(ext_pc) + 1 + signed(ext_extender));

utt1 : entity work.PC
	PORT MAP(E=>ext_mux,
			 clk=>clk,
			 reset=>reset,
			 S=>ext_pc);
utt2 : entity work.MUX2_1
	GENERIC MAP(N=>32)
	PORT MAP(A=>pc_plus_un,
			 B=>pc_plus_offset,
			 COM=>nPCsel,
			 S=>ext_mux);

utt3 : entity work.INSTRUCTION_MEMORY3
	PORT MAP(PC=>ext_pc,
			 Instruction =>Instruction
			 
	);
	
utt4 : entity work.PC_EXTENDER
port map(E=>Offset,
		 S=>ext_extender
	);

	
end architecture arch_UNITE_GESTION_INSTRUCTIONS;
