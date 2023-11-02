library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FullAdder is
	Port ( x : in STD_LOGIC;
			y : in STD_LOGIC;
			carry_in : in STD_LOGIC;
			sum : out STD_LOGIC;
			carry_out : out STD_LOGIC);
end FullAdder;
architecture struct of FullAdder is
--internal signal declarations
	signal w0,w1,w2,w3,w4,w5,w6: STD_LOGIC;
begin
--Full Adder Using only "2 input" gates (i.e. AND2, OR2 and XOR2)
	w0 <= x AND y after 2ns;
	w1 <= x AND carry_in after 2ns;
	w2 <= y AND carry_in after 2ns;
	w3 <= x XOR y after 4ns;
	w4 <= w3 XOR carry_in after 4 ns;
	w5 <= w0 OR w1 after 2ns;
	w6 <= w1 OR w2 after 2ns;
	sum <= w4;
	carry_out <= w5 OR w6 after 2ns;
end struct;
