library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UNITE_TRAITEMENT_FINALE is
---------------------------------------
  port ( clk :  in std_logic;
		 reset : in std_logic;
		 WrEn : in std_logic;
		 RegWr : in std_logic;
		 Rw,Ra,Rb : in std_logic_vector(3 downto 0);
		 Imm : in std_logic_vector(7 downto 0);
		 SEL1,SEL2,SEL3 : in std_logic;
		 OP : in std_logic_vector(1 downto 0);
		 N : out std_logic_vector(31 downto 0);
		 Z : out std_logic_vector(31 downto 0);
		 S : out std_logic_vector(31 downto 0));
end entity UNITE_TRAITEMENT_FINALE;


architecture ARCH_UNITE_TRAITEMENT_FINALE of UNITE_TRAITEMENT_FINALE is
	
	signal B_A : std_logic_vector(31 downto 0);
	signal B_B : std_logic_vector(31 downto 0);
	signal EXT : std_logic_vector(31 downto 0);
	signal ALUout : std_logic_vector(31 downto 0);
	signal B_W : std_logic_vector(31 downto 0);
	signal DataOut : std_logic_vector(31 downto 0);
	signal S_sel1 : std_logic_vector(31 downto 0);
	signal outrb : std_logic_vector(3 downto 0);
	

begin

utt1 : entity work.BANC_REGISTRE
	PORT MAP(clk=>clk,
			 reset=>reset,
			 W=>B_W,
			 Rw=>Rw,
			 Ra=>Ra,
			 Rb=>outrb,
			 WE=>RegWr,
			 A=>B_A,
			 B=>B_B);
			 
utt2 : entity work.MUX2_1
	GENERIC MAP(N=>32)
	PORT MAP(A=>B_B,
			 COM=>SEL1,
			 B=>EXT,
			 S=>S_sel1);
			 
utt3 : entity work.MUX2_1
	GENERIC MAP(N=>32)
	PORT MAP(A=>ALUout,
			 B=>DataOut,
			 COM=>SEL2,
			 S=>B_W);
			 
utt4 : entity work.EXTENSION_SIGNE
	GENERIC MAP(N=>8)
	PORT MAP(E=>Imm,
	         S=>EXT);
			 
utt5 : entity work.ALU
	PORT MAP(OP=>OP,
			 A=>B_A,
			 B=>S_sel1,
			 S=>ALUout,
			 N=>N,
			 Z=>Z);
			 
utt6 : entity work.MEMOIRE_DONNEES
	PORT MAP(DataIn=>B_B,
			 WrEn=>WrEn,
			 clk=>clk,
			 reset=>reset,
			 Addr=>ALUout(5 downto 0),
			 DataOut=>DataOut);
			 
utt7: entity work.MUX2_1
	GENERIC MAP(N=>4)
	PORT MAP(A=>Rb,
			 B=>Rw,
			 COM=>SEL3,
			 S=>outrb);
			 
S<=B_W;
			 
			 
end architecture ARCH_UNITE_TRAITEMENT_FINALE;