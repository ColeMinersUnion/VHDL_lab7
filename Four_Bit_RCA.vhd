library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Four_Bit_RCA is
	Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
			B : in STD_LOGIC_VECTOR (3 downto 0);
			Cin : in STD_LOGIC;
			S : out STD_LOGIC_VECTOR (3 downto 0);
			Cout : out STD_LOGIC);
end Four_Bit_RCA;
architecture struct of Four_Bit_RCA is
--Full Adder Component Declaration
	component FullAdder
		Port ( x : in STD_LOGIC;
				y : in STD_LOGIC;
				carry_in : in STD_LOGIC;
				sum : out STD_LOGIC;
				carry_out : out STD_LOGIC);
	end component;
--Intermediate Signals
	signal c1,c2,c3: STD_LOGIC;
begin
--Full Adder Instantiations and Port Mappings
	FA0: FullAdder port map(x=>A(0), y=>B(0), carry_in=>Cin,
	sum=>S(0),carry_out=>c1);
	FA1: FullAdder port map(x=>A(1), y=>B(1), carry_in=>c1,
	sum=>S(1),carry_out=>c2);
	FA2: FullAdder port map(x=>A(2), y=>B(2), carry_in=>c2,
	sum=>S(2),carry_out=>c3);
	FA3: FullAdder port map(x=>A(3), y=>B(3), carry_in=>c3,
	sum=>S(3),carry_out=>Cout);
end struct;
