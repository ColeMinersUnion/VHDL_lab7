library ieee;
use ieee.std_logic_1164.all;

entity DFlipFlop is
	port(
		Data, Set : IN STD_LOGIC;
		CLK : in STD_LOGIC;
		CLK_50 : in STD_LOGIC;
		Q : out STD_LOGIC
	);
end DFlipFlop;

architecture dataflow of DFlipFlop is

	component debounce is
		port(
			clk : IN std_logic;
			button : IN std_logic;
			result : OUT std_logic
		);
	end component;

	signal newClock : std_logic;

begin
	
	CLKDB : debounce port map(CLK_50, CLK, newClock);

	dff: PROCESS (Set, newClock)
	begin
		if (Set = '0') then
			Q <= '0';
		elsif (rising_edge(newClock)) then
			Q <= Data;
		end if;
	end process dff;
end dataflow;