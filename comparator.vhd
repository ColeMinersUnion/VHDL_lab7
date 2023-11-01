LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity comparator is 
	Port(
		binNum : IN std_logic_vector(3 downto 0);
		isGreater9 : OUT std_logic
	);
end comparator;

architecture dataflow of comparator is

begin

	isGreater9 <= binNum(3) and (binNum(2) or binNum(1));

end dataflow;
