library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory3 is
	port(PC: in std_logic_vector(31 downto 0);
		 Instruction : out std_logic_vector(31 downto 0));
		 
end entity;

architecture RTL of instruction_memory3 is
	type RAM64x32 is array (0 to 63) of std_logic_vector(31 downto 0);
	
	function init_mem return RAM64x32 is 
		variable result : RAM64x32;
	begin 
	for i in 63 downto 0 loop 
		result(i):=(others=>'0');
	end loop;
	
	-- @Mémoire de données
	-- 0x20 : 3
	-- 0x21 : 107
	-- 0x22 : 27
	-- 0x23 : 12
	-- 0x24 : 322
	-- 0x25 : 155
	-- 0x26 : 63
	
	result(0):=X"E3A00020"; --start   : MOV R0, #0x20@ R0 <-0x20, adresse de TAB
	result(1):=X"E3A02001"; --          MOV R2, #1@ nombre de permutations
	result(2):=X"E3A02000"; --WHILE   : MOV R2, #0@ permut = 0
	result(3):=X"E3A01001"; --          MOV R1, #1@ I=1
	result(4):=X"E6103000"; --FOR     : LDR R3, [R0]@ TAB[i]
	result(5):=X"E6104001"; --          LDR R4, [R0,#1]@ TAB[i+1]
	result(6):=X"E1530004"; --          CMP R3, R4
	result(7):=X"C6004000"; --          STRGT R4, [R0]@ TAB[i] <-R4
	result(8):=X"C6003001"; --          STRGT R3, [R0,#1]@ TAB[i+1] <-R3
	result(9):=X"C2822001"; --          ADDGT R2, R2, #1@ NB_PERMUT = NB_PERMUT + 1
	result(10):=X"E2800001";--          ADD R0, R0, #1@ on incrémente l'adresse du Tab
	result(11):=X"E2811001";--          ADD R1, R1, #1   @ i++
	result(12):=X"E3510007";--	        CMP R1, #0x7@ si i<7, on saute sur la boucle FOR
	result(13):=X"BAFFFFF6";--          BLT FOR
	result(14):=X"E3520000";--          CMP R2, #0@ test permut
	result(15):=X"E3A00020";--          MOV     R0, #0x20@ on remet l'adresse de base du tableau dans R0
	result(16):=X"1AFFFFF1";--          BNE WHILE@ si permut est diffferent de 0 on saute à WHILE
	result(17):=X"EAFFFFFF";--wait    : BAL wait @ Pour finir, on bloque le processeur dans une boucle infinie vide
	
		return result;
	end init_mem;
	
	signal mem: RAM64x32 :=init_mem;
	
	begin
		Instruction<=mem(to_integer(unsigned(PC(5 downto 0))));
	end architecture;