library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory2 is
	port(PC: in std_logic_vector(31 downto 0);
		 Instruction : out std_logic_vector(31 downto 0));
		 
end entity;

architecture RTL of instruction_memory2 is
	type RAM64x32 is array (0 to 63) of std_logic_vector(31 downto 0);
	
	function init_mem return RAM64x32 is 
		variable result : RAM64x32;
	begin 
	for i in 63 downto 0 loop 
		result(i):=(others=>'0');
	end loop;
	
	result(0):=X"E3A00010"; --main : MOV R0,#0x10     @R0<=0x10, adresse de TAB
	result(1):=X"E3A01001"; --       MOV R1,#1        @I=1
	result(2):=X"E6103000"; --FOR  : LDR R3,[R0]      @TAB[i]
	result(3):=X"E6104001"; --       LDR R4,[R0,#1]   @TAB[i+1]
	result(4):=X"E6004000"; --       STR R4,[R0]      @TAB[i]<-R4
	result(5):=X"E6003001"; --       STR R3,[R0,#1]   @TAB[i+1]<-R3
	result(6):=X"E2800001"; --       ADD R0,R0,#1     @on incrémente l'adresse du Tab
	result(7):=X"E2811001"; --       ADD R1,R1,#1     @i++
	result(8):=X"E351000A"; --       CMP R1,#0xA      @si i<10, on saute au label FOR
	result(9):=X"BAFFFFF8"; --       BLT FOR
	result(10):=X"EAFFFFFF";--wait : BAL wait       
		return result;
	end init_mem;
	
	signal mem: RAM64x32 :=init_mem;
	
	begin
		Instruction<=mem(to_integer(unsigned(PC(5 downto 0))));
	end architecture;