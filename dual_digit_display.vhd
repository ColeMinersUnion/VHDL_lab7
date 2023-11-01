LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dual_digit_display IS

PORT(
	B1 : in std_logic_vector(3 downto 0);
	B2 : in std_logic_vector(3 downto 0);

	Hex1 : out std_logic_vector(6 downto 0);
	Hex2 : out std_logic_vector(6 downto 0)
);

END dual_digit_display;

ARCHITECTURE dataflow of dual_digit_display IS

 
	COMPONENT display_decoder IS
		PORT(    A, B, C, D : in std_logic;
					Disp : out std_logic_vector);
	END COMPONENT;

BEGIN

	Converter1 : display_decoder PORT MAP( A => B1(0), B => B1(1), C => B1(2),D => B1(3),
														Disp => Hex1);

	Converter2 : display_decoder PORT MAP( A => B2(0), B => B2(1),C => B2(2),D => B2(3),
														Disp => Hex2);   

END dataflow;