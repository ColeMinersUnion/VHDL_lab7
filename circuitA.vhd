LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity circuitA is
	port( binNum : IN std_logic_vector(3 downto 0);
			decDig : OUT std_logic_vector(3 downto 0)
			);
end circuitA;

architecture circ of circuitA is

begin

	decDig(3) <= '0';
	decDig(0) <= binNum(0);
	decDig(2) <= binNum(2) and binNum(1);
	decDig(1) <= binNum(2) and (not binNum(1));

end circ;