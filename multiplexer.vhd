library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
	port(
		A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		sel : IN std_logic;
		
		Cout : OUT std_logic_vector(3 downto 0)
	);
end multiplexer;

architecture dataflow of multiplexer is

begin

PROCESS(sel, A, B)
begin
	case sel is
		when '0' => 
			Cout <= A;
		when '1' =>
			Cout <= B;
		when others =>
			Cout <= "0000";
	end case;
end process;
	
end dataflow;

