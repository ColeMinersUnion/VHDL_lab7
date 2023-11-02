library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Lab8 is
	Port ( A_top : in STD_LOGIC_VECTOR (3 downto 0);
			B_top : in STD_LOGIC_VECTOR (3 downto 0);
			Cin_top : in STD_LOGIC;
			S_top : out STD_LOGIC_VECTOR (3 downto 0);
			Cout_top: out STD_LOGIC);
end Lab8;
architecture struct of Lab8 is
--Full Adder Component Declaration
	component Four_Bit_RCA
		Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
				B : in STD_LOGIC_VECTOR (3 downto 0);
				Cin : in STD_LOGIC;
				S : out STD_LOGIC_VECTOR (3 downto 0);
				Cout : out STD_LOGIC);
	end component;
begin
	RCA0: Four_Bit_RCA port map(A=>A_top, B=>B_top, Cin=>Cin_top,S=>S_top,
	Cout=>Cout_top);
end struct;
