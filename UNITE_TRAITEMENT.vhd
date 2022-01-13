library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UNITE_TRAITEMENT is

  port ( clk :  in std_logic;
		 reset : in std_logic;
		 --W : in std_logic_vector(31 downto 0);
		 WE : in std_logic;
		 OP : in std_logic_vector(1 downto 0);
		 Rw,Ra,Rb : in std_logic_vector(3 downto 0);
		 S : out std_logic_vector(31 downto 0);
		 N : out std_logic_vector(31 downto 0));
end entity UNITE_TRAITEMENT;

architecture arch_UNITE_TRAITEMENT of UNITE_TRAITEMENT is
	signal B_W : std_logic_vector(31 downto 0);
	signal B_A : std_logic_vector(31 downto 0);
	signal B_B : std_logic_vector(31 downto 0);
begin  

utt1 : entity work.BANC_REGISTRE
	port map(clk=>clk,
			reset=>reset,
			W=>B_W,
			WE=>WE,
			Rb=>Rb,
			Ra=>Ra,
			Rw=>Rw,
			A=>B_A,
			B=>B_B);
			
utt2 : entity work.ALU
port map(A=>B_A,
		 B=>B_B,
		 OP=>OP,
		 S=>B_W,
		 N=>N);
		 
S<=B_W;

end architecture arch_UNITE_TRAITEMENT;
			