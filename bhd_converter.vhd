library ieee;
use ieee.std_logic_1164.all;

entity bhd_converter is

	port(
		num : IN std_logic_vector(3 downto 0);
		hex : OUT std_logic_vector(6 downto 0);
		digit1 : OUT std_logic_vector(6 downto 0);
		digit2 : OUT std_logic_vector(6 downto 0)
	);

end bhd_converter;


architecture dataflow of bhd_converter is

	component circuitA is
		port(
				binNum : IN std_logic_vector(3 downto 0);
				decDig : OUT std_logic_vector(3 downto 0)
				);
	end component;

	component circuitB is
		port(input : IN std_logic_vector(3 downto 0);
				output : OUT std_logic_vector(3 downto 0));
	end component;

	component display_decoder is
		port(A, B, C, D: IN std_logic;
				Disp : OUT std_logic_vector(6 downto 0) );
	end component;

	component multiplexer is
		port(A, B: IN std_logic_vector(3 downto 0);
				sel : IN std_logic;
				Cout : OUT std_logic_vector(3 downto 0));
	end component;
	
	component comparator is
		port(binNum : IN std_logic_vector(3 downto 0);
				isGreater9 : OUT std_logic);
	end component;
	
	signal temp : std_logic_vector(3 downto 0);
	signal Digit_A : std_logic_vector(3 downto 0);
	signal Digit_B : std_logic_vector(3 downto 0); 
	signal isBigger : std_logic;

begin
	compare : comparator port map(binNum => num, isGreater9 => isBigger);

	circB : circuitB port map(input => num, output => Digit_B);
	circA : circuitA port map(binNum => num, decDig => temp);
	
	mux : multiplexer port map(A => num, B => temp, sel => isBigger, Cout => Digit_A);

	
	hexDisp : display_decoder port map(A => num(3), B => num(2), C => num(1), D => num(0), Disp => hex);
	
	

	DispA : display_decoder port map(A => Digit_A(3), B => Digit_A(2), C => Digit_A(1), D => Digit_A(0), Disp => digit1);
	DispB : display_decoder port map(A => Digit_B(3), B => Digit_B(2), C => Digit_B(1), D => Digit_B(0), Disp => digit2);
	
	
	
end dataflow;
