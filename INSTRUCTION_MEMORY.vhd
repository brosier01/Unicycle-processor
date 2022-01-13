library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
	port(PC: in std_logic_vector(31 downto 0);
		 Instruction : out std_logic_vector(31 downto 0));
		 
end entity;

architecture RTL of instruction_memory is
	type RAM64x32 is array (0 to 63) of std_logic_vector(31 downto 0);
	
	function init_mem return RAM64x32 is 
		variable result : RAM64x32;
	begin 
	for i in 63 downto 0 loop 
		result(i):=(others=>'0');
	end loop;               --PC        --INSTRUCTION  --COMMENTAIRE
	
	result(0):=X"E3A01010"; --0x0 _main --MOV R1,#0x10 --R1 = 0x10
	result(1):=X"E3A02000"; --0x1--MOV R2,#0x00 --R2 = 0
	result(2):=X"E6110000"; --0x2 _loop --LDR R0,0(R1) --R0 = DATAMEM[R1]
	result(3):=X"E0822000"; --0x3--ADD R2,R2,R0 --R2 = R2 + R0
	result(4):=X"E2811001"; --0x4--ADD R1,R1,#1 --R1 = R1 + 1
	result(5):=X"E351002A"; --0x5--CMP R1,0x2A  --si R1 >= 0x2A
	result(6):=X"BAFFFFFB"; --0x6--BLT loop --PC = PC + (-5) si N = 
	result(7):=X"E6012000"; --0x7--STR R2,0(R1) --DATAMEM[R1] = R2
	result(8):=X"EAFFFFF7"; --0x8--BAL main--PC = PC + (-7)
		return result;
	end init_mem;
	
	signal mem: RAM64x32 :=init_mem;
	
	begin
		Instruction<=mem(to_integer(unsigned(PC(5 downto 0))));
	end architecture;