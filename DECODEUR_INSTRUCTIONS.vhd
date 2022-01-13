library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity DECODEUR_INSTRUCTIONS is
port(Instruction : in std_logic_vector(31 downto 0);
	 Psr : in std_logic_vector(31 downto 0);
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
end entity DECODEUR_INSTRUCTIONS;

architecture arch_DECODEUR_INSTRUCTIONS of DECODEUR_INSTRUCTIONS is
	
	type enum_instruction is (NOP,MOV,ADDi,ADDr,CMP,LDR,STR,BAL,BLT,CMPr,STRGT,BNE,ADDGT);
	
	signal instr_courante: enum_instruction;
	
begin

	Offset<=Instruction(23 downto 0);
	Imm<=Instruction(7 downto 0);
	Rn<=Instruction(19 downto 16);
	Rd<=Instruction(15 downto 12);
	Rm<=Instruction(3 downto 0);

process(Instruction)
begin

	if Instruction(31 downto 20)="111000101000" then
		instr_courante<=ADDi;     
	elsif Instruction(31 downto 20)="111000001000" then
		instr_courante<=ADDr;
	elsif Instruction(31 downto 20)="110001100000" then 
		instr_courante<=STRGT;
	elsif Instruction(31 downto 20)="111000111010" then 
		instr_courante<=MOV;
	elsif Instruction(31 downto 20)="111000110101" then
		instr_courante<=CMP;
	elsif Instruction(31 downto 24)="11101010" then
		instr_courante<=BAL;
	elsif Instruction(31 downto 24)="10111010" then
		instr_courante<=BLT;
	elsif Instruction(31 downto 20)="111001100001" then
		instr_courante<=LDR;
	elsif Instruction(31 downto 20)="111001100000" then
		instr_courante<=STR;
	elsif Instruction(31 downto 20)="110000101000" then
		instr_courante<=ADDGT;
	elsif Instruction(31 downto 24)="00011010" then
		instr_courante<=BNE;
	elsif Instruction(31 downto 20)="111000010101" then
		instr_courante<=CMPr;
	else 
		instr_courante<=NOP;
	end if;
	
end process;

process(instr_courante,Psr)
begin
	
	if instr_courante=ADDi then
		nPCsel<='0';
		RegWr<='1';
		ALUsrc<='1';
		ALUctr<="00";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='1';
		
		
	elsif instr_courante=ADDr then
		nPCsel<='0';
		RegWr<='1';
		ALUsrc<='0';
		ALUctr<="00";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='0';
		
	elsif instr_courante=BAL then
		nPCsel<='1';
		RegWr<='1';
		ALUsrc<='1';
		ALUctr<="00";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='1';
		
	elsif instr_courante=BLT then
		if Psr(0)='1' then --N=1
			nPCsel<='1';
			RegWr<='0';
			ALUsrc<='0';
			ALUctr<="00";
			PSREn<='1';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='1';
		else
			nPCsel<='0';
			RegWr<='0';
			ALUsrc<='0';
			ALUctr<="00";
			PSREn<='1';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='1';
		end if;
		
		RegWr<='0';
		ALUsrc<='0';
		ALUctr<="00";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='1';
		
	elsif instr_courante=CMP then
		nPCsel<='0';
		RegWr<='0';
		ALUsrc<='1';
		ALUctr<="10";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='1';
	
	elsif instr_courante=LDR then
		nPCsel<='0';
		RegWr<='1';
		ALUsrc<='1';
		ALUctr<="00";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='1';
		RegSel<='1';
	elsif instr_courante=MOV then
		nPCsel<='0';
		RegWr<='1';
		ALUsrc<='1';
		ALUctr<="01";
		PSREn<='0';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='1';
	elsif instr_courante=STR then
		nPCsel<='0';
		RegWr<='0';
		ALUsrc<='1';
		ALUctr<="00";
		PSREn<='0';
		MemWr<='1';
		WrSrc<='0';
		RegSel<='1';
		
	elsif instr_courante=ADDGT then
		if Psr(0)='0' then --N=0
			nPCsel<='0';
			RegWr<='1';
			ALUsrc<='1';
			ALUctr<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='1';
		else
			nPCsel<='0';
			RegWr<='0';
			ALUsrc<='0';
			ALUctr<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		end if;
		
	elsif instr_courante=BNE then
		if Psr(31)='0' then --Z=0
			nPCsel<='1';
			RegWr<='0';
			ALUsrc<='0';
			ALUctr<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='1';
		else
			nPCsel<='0';
			RegWr<='0';
			ALUsrc<='0';
			ALUctr<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='1';
		end if;
		
	elsif instr_courante=CMPr then
		nPCsel<='0';
		RegWr<='0';
		ALUsrc<='0';
		ALUctr<="10";
		PSREn<='1';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='0';
	
	elsif instr_courante=STRGT then
		if Psr(0)='0' then --N=0
			nPCsel<='0';
			RegWr<='0';
			ALUsrc<='1';
			ALUctr<="00";
			PSREn<='0';
			MemWr<='1';
			WrSrc<='0';
			RegSel<='1';
		else
			nPCsel<='0';
			RegWr<='0';
			ALUsrc<='0';
			ALUctr<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='1';
		end if;
		
	else 
		nPCsel<='0';
		RegWr<='0';
		ALUsrc<='0';
		ALUctr<="00";
		PSREn<='0';
		MemWr<='0';
		WrSrc<='0';
		RegSel<='0';
		
	end if;



end process;




end architecture;