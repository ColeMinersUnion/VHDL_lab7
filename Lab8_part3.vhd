library ieee;
USE ieee.NUMERIC_STD.all;
USE ieee.STD_LOGIC_1164.all;

entity Lab8_part3 is
port(
	A : IN STD_LOGIC_VECTOR(7 downto 0);
	B : IN STD_LOGIC_VECTOR(7 downto 0);
	Cin : IN STD_LOGIC;
	S : OUT STD_LOGIC_VECTOR(7 downto 0);
	Cout : OUT STD_LOGIC
);
end Lab8_part3;

architecture dataflow of Lab8_part3 is

--my new fancy objects are here
signal intA, intB, intCin, intS : unsigned(8 downto 0);
begin
	intA(7 downto 0) <= unsigned(A);
	intA(8) <= '0';
	
	intB(7 downto 0) <= unsigned(B);
	intB(8) <= '0';
	
	intCin <= (0 => Cin, others => '0');
	
	intS <= intA + intB + intCin;
	
	S <= STD_LOGIC_VECTOR(intS(7 downto 0));
	Cout <= intS(8);
	


end dataflow;
