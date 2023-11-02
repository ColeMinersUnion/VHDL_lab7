library ieee;
use ieee.std_logic_1164.all;

entity accumulator is
	port(
		ClockA, Reset, ClkA_50: IN std_logic;
		A : IN std_logic_vector(7 downto 0);
		Sum: OUT std_logic_vector(7 downto 0);
		Num1: OUT std_logic_vector(6 downto 0);
		Num2: OUT std_logic_vector(6 downto 0);
		over, Carry : OUT std_logic
	);
end accumulator;

architecture accum of accumulator is
	component dual_digit_display is
		port(B1, B2: IN std_logic_vector(3 downto 0);
				Hex1, Hex2: OUT std_logic_vector(6 downto 0));
	end component;
	
	--add the component for single digit display

	component adder is
		port(A, B: IN std_logic_vector(7 downto 0);
				Cin: IN std_logic;
				S	: OUT std_logic_vector(7 downto 0);
				Cout: OUT std_logic);
	end component;
	
	component reg is
		port(
			D: IN std_logic_vector(7 downto 0);
			R, clock, Clock_50: IN STD_LOGIC;
			Qa : OUT std_logic_vector(7 downto 0));
	end component;
	
	component DFlipFlop is
		port(
			Data, Set : IN STD_LOGIC;
			CLK : in STD_LOGIC;
			CLK_50 : in STD_LOGIC;
			Q : out STD_LOGIC
		);
	end component;
	
	component overflow is
		port(
			A, B, C: IN std_logic_vector(7 downto 0);
			flooded: OUT std_logic
		);
	end component;
	
signal regAOut, regSIn : std_logic_vector(7 downto 0);
signal gojover, carryout : std_logic;
signal regSout : std_logic_vector(7 downto 0) := "00000000";
	
begin

		RegA : reg port map(A, reset, ClockA, ClkA_50, regAOut);
		FullA: adder port map(regAOut, regSOut, '0', regSIn, carryout);
		Logic: overflow port map(A, regSOut, regSIn, gojover);
		RegS : reg port map(regSIn, reset, ClockA, ClkA_50, regSOut);
		
		joever: DFlipFlop port map(gojover, reset, ClockA, ClkA_50, over);
		takeaway: DFlipFlop port map(carryout, reset, ClockA, ClkA_50, carry);
		Sum <= regSIn;
		--use single digit display for the displays
	
end accum;