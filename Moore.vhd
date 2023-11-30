library ieee;
use ieee.std_logic_1164.all;

entity Moore is port(
	W : IN std_logic;
	Reset, Clock, Clock_50: IN std_logic;
	z : OUT std_logic
);
end Moore;

architecture dataflow of Moore is

	component debounce is
		port(clk, button : IN std_logic;
				result : OUT std_logic);
	end component;

type state_03 is (ST0, ST1, ST2);
signal newClock : std_logic;
signal state, nextState : state_03;
	
begin

	bouncer : debounce port map(Clock_50, Clock, newClock);

	process(newClock, nextState, Reset)
	begin
		if (Reset = '0') then
			state <= ST0;
		elsif (rising_edge(newClock)) then
			state <= nextState;
		end if;
	end process;
	
	process(state, w)
	begin
		z <= '0';
		case state is
			when ST0 =>
				Z <= '0';
				if (w = '1') then
					nextState <= ST1;
				else
					nextState <= ST0;
				end if;
			when ST1 => 
				Z <= '0';
				if (w = '1') then
					nextState <= ST2;
				else
					nextState <= ST0;
				end if;
			when ST2 => 
				Z <= '1';
				if(w = '1') then
					nextState <= ST2;
				else
					nextState <= ST0;
				end if;
			when others =>
				Z <= '0';
				nextState <= ST0;
		end case;
	end process;
	
end dataflow;
