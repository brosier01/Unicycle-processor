library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PROCESSEUR_P4 is
port ( clk : in std_logic;
	   reset : in std_logic;
	   S : out std_logic_vector(31 downto 0)
	);
end entity PROCESSEUR_P4;

architecture arch_PROCESSEU_P4 of PROCESSEUR_P4 is
	
	signal nPCsel_int : std_logic;
	signal Offset_int : std_logic_vector(23 downto 0);
	signal Instruction_int : std_logic_vector(31 downto 0);
	signal WrEn_int : std_logic;
	signal RegWr_int : std_logic;
	signal Ra_int : std_logic_vector(3 downto 0);
	signal Rb_int : std_logic_vector(3 downto 0);
	signal Rw_int : std_logic_vector(3 downto 0);
	signal Imm_int : std_logic_vector(7 downto 0);
	signal SEL1_int : std_logic;
	signal SEL2_int : std_logic;
	signal SEL3_int : std_logic;
	signal OP_int : std_logic_vector(1 downto 0);
	signal N_int : std_logic_vector(31 downto 0);
	signal Z_int : std_logic_vector(31 downto 0);
	
begin

utt1 : entity work.UNITE_GESTION_INSTRUCTIONS
port map(clk=>clk,
		 reset=>reset,
		 nPCsel=>nPCsel_int,
		 Offset=>Offset_int,
		 Instruction=>Instruction_int);
		 
utt2 : entity work.UNITE_TRAITEMENT_FINALE
port map(clk=>clk,
		 reset=>reset,
		 WrEn=>WrEn_int,
		 RegWr=>RegWr_int,
		 Rw=>Rw_int,
		 Ra=>Ra_int,
		 Rb=>Rb_int,
		 Imm=>Imm_int,
		 SEL1=>SEL1_int,
		 SEL2=>SEL2_int,
		 SEL3=>SEL3_int,
		 OP=>OP_int,
		 N=>N_int,
		 Z=>Z_int,
		 S=>S
	);
	
utt3 : entity work.UC
port map(clk=>clk,
		 reset=>reset,
		 DataIn=>N_int,
		 Za=>Z_int,
		 Instruction=>Instruction_int,
		 ALUsrc=>SEL1_int,
		 ALUctr=>OP_int,
		 MemWr=>WrEn_int,
		 WrSrc=>SEL2_int,
		 nPCsel=>nPCsel_int,
		 RegWr=>RegWr_int,
		 RegSel=>SEL3_int,
		 Rn=>Ra_int,
		 Rd=>Rw_int,
		 Rm=>Rb_int,
		 Offset=>Offset_int,
		 Imm=>Imm_int
	);
	
end architecture arch_PROCESSEU_P4;