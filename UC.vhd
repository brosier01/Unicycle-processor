library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UC is
port(clk : in std_logic;
	 reset : in std_logic;
	 DataIn : in std_logic_vector(31 downto 0);
	 Za : in std_logic_vector(31 downto 0);
	 Instruction : in std_logic_vector(31 downto 0);
	 ALUsrc : out std_logic;
	 ALUctr : out std_logic_vector(1 downto 0);
	 MemWr : out std_logic;
	 WrSrc : out std_logic;
	 PSREn : out std_logic;
	 nPCsel : out std_logic;
	 RegWr : out std_logic;
	 RegSel : out std_logic;
	 Rn,Rd,Rm : out std_logic_vector(3 downto 0);
	 Offset : out std_logic_vector(23 downto 0);
	 Imm : out std_logic_vector(7 downto 0)
	);
end entity UC;

architecture arch_UC of UC is

	signal outpsr: std_logic_vector(31 downto 0);
	signal psrOn : std_logic;

begin

utt1: entity work.DECODEUR_INSTRUCTIONS
port map(Instruction=>Instruction,
		 Psr=>outpsr,
		 ALUsrc=>ALUsrc,
		 ALUctr=>ALUctr,
		 MemWr=>MemWr,
		 WrSrc=>WrSrc,
		 PSREn=>psrOn,
		 nPCsel=>nPCsel,
		 RegWr=>RegWr,
		 RegSel=>RegSel,
		 Rn=>Rn,
		 Rd=>Rd,
		 Rm=>Rm,
		 Offset=>Offset,
		 Imm=>Imm
	);
	
utt2 : entity work.REGISTRE32_COMMANDE_CHARGEMENT
port map(clk=>clk,
		 reset=>reset,
		 We=>psrOn,
		 DataIn=>DataIn,
		 Z=>Za,
		 DataOut=>outpsr
	);

end architecture;