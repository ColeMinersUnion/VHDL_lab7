library ieee;
use ieee.std_logic_1164.all;

entity motherboard is
	port(CLK50, CLK_P, CLK_M, Reset, RunButton : IN std_logic;
			ProcDone : BUFFER std_logic;
			Bus_Wires : BUFFER std_logic_vector(8 downto 0));
	

end motherboard;

architecture dataflow of motherboard is

component proc is
	port ( DIN                 : IN      STD_LOGIC_VECTOR(8 DOWNTO 0);
           Clock_50, Clock, Resetn, Run  : IN      STD_LOGIC;
           Done                : BUFFER  STD_LOGIC;
           BusWires            : BUFFER  STD_LOGIC_VECTOR(8 DOWNTO 0));
end component;

component debounce is
	PORT(
    clk     : IN  STD_LOGIC;  --input clock
    button  : IN  STD_LOGIC;  --input signal to be debounced
    result  : OUT STD_LOGIC); 
end component;

component inst_mem is
	PORT
		(
			address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			q		: OUT STD_LOGIC_VECTOR (8 DOWNTO 0)
		);
end component;

component counter is
port(
		Clock, ResetN : IN std_logic;
		address : OUT std_logic_vector(4 downto 0)
	);
end component;
	
	
signal ROM_instructions : std_logic_vector(8 downto 0);
signal count : std_logic_vector(4 downto 0);
signal newCLK : std_logic;

begin
	
	iterator : counter port map(CLK_M, Reset, count);
	trampoline : debounce port map(CLK50, CLK_M, newCLK); --debouncing the clock for ROM
	Romble : inst_mem port map(count, newCLK, ROM_instructions); --ROM File
	Due : proc port map(ROM_instructions, CLK50, CLK_P, Reset, RunButton, ProcDone, Bus_Wires); --Process Stuff
	
	
	
end dataflow;
