library ieee;
use ieee.std_logic_1164.all;

entity circuitB is
	port(
		input : IN std_logic_vector(3 downto 0);
		output : OUT std_logic_vector(3 downto 0)
	);
end circuitB;

architecture dataflow of circuitB is

component comparator is
	Port(
		binNum : IN std_logic_vector(3 downto 0);
		isGreater9 : OUT std_logic
	);
end component;

signal isBig : std_logic;

begin
	comp : comparator port map(binNum => input, isGreater9 => isBig);
	
	process(isBig)
	begin
		case isBig is
			when '0' => 
				output <= "0000";
			when '1' =>
				output <= "0001";
		end case;
	end process;

end dataflow;
