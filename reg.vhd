library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port( D: IN std_logic_vector(7 downto 0);
			R, clock, Clock_50: IN STD_LOGIC;
			Qa : OUT std_logic_vector(7 downto 0)
		);
end reg;

architecture struct of reg is
	component DFlipFlop is
		port(
			Data, Set, CLK, CLK_50: IN STD_LOGIC;
			Q : OUT std_logic
		);
	end component;
	
	begin
		D0 : DFlipFlop port map(D(0), R, clock, Clock_50, Qa(0));
		D1 : DFlipFlop port map(D(1), R, clock, Clock_50, Qa(1));
		D2 : DFlipFlop port map(D(2), R, clock, Clock_50, Qa(2));
		D3 : DFlipFlop port map(D(3), R, clock, Clock_50, Qa(3));
		D4 : DFlipFlop port map(D(4), R, clock, Clock_50, Qa(4));
		D5 : DFlipFlop port map(D(5), R, clock, Clock_50, Qa(5));
		D6 : DFlipFlop port map(D(6), R, clock, Clock_50, Qa(6));
		D7 : DFlipFlop port map(D(7), R, clock, Clock_50, Qa(7));
end struct;