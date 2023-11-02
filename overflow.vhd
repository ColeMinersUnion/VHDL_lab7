--(A xnor B) xor C
library ieee;
use ieee.std_logic_1164.all;

entity overflow is 
	port (A, B, C: IN std_logic_vector(7 downto 0);
			flooded: OUT std_logic);
end overflow;

architecture dataflow of overflow is 
begin
	flooded <= (A(7) xnor B(7)) xor C(7);
end dataflow;