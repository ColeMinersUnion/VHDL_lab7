library ieee;
use ieee.std_logic_1164.all;

entity Moore is port(
	W : IN std_logic_vector(1 downto 0);
	Reset, CLock, Clock_50: IN std_logic;
	z, Dflip, flop : OUT std_logic;
)
end Moore;

architecture dataflow of Moore is

	component DFlipFlop is 
		port(Data, Set, CLK, CLK5_50 : IN std_logic;
				Q : OUT std_logic;
	end component;
	
signal state, nextState: std_logic := '0';
	
begin
	
	
	
end dataflow;
