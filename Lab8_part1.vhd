library ieee;
USE ieee.std_logic_1164.all;

entity Lab8_part1 is
PORT(
	x : in STD_LOGIC_VECTOR(7 downto 0);
	y : in STD_LOGIC_VECTOR(7 downto 0);
	Sol : out STD_LOGIC_VECTOR(7 downto 0);
	
	C_IN : in STD_LOGIC;
	C_OUT : out STD_LOGIC
);

end Lab8_part1;

architecture dataflow of Lab8_part1 is

	component Four_Bit_RCA
		Port(
			A : in STD_LOGIC_VECTOR(3 downto 0);
			B : in STD_LOGIC_VECTOR(3 downto 0);
			Cin : in STD_LOGIC;
			S : out STD_LOGIC_VECTOR(3 downto 0);
			Cout : out STD_LOGIC
		);
	end component;

	signal mid_carry : STD_LOGIC;
begin
	FourBitA : Four_Bit_RCA port map(A => x(3 downto 0), B => y(3 downto 0), Cin => C_IN, 
	S => Sol(3 downto 0), Cout => mid_carry);
	FourBitB : Four_Bit_RCA port map(A => x(7 downto 4), B => y(7 downto 4), Cin => mid_carry,
	S => Sol(7 downto 4), Cout => C_OUT);


end dataflow;
