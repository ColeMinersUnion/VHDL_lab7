library ieee;
use ieee.std_logic_1164.all;

entity VendingMachine is
	port(Nickles, Dimes: IN std_logic;
			Reset, Clock, Clock_50: IN std_logic;
			Coke : OUT std_logic;
			test : OUT std_logic;
			states : OUT std_logic_vector(4 downto 0));
end VendingMachine;

architecture dataflow of VendingMachine is

	component debounce is
		port(clk, button : IN std_logic;
				result : OUT std_logic);
	end component;

type state_05 is (ST1, ST2, ST3, ST4, ST5);
signal newClock : std_logic;
signal state, nextState : state_05;
	
begin
	bouncer : debounce port map(Clock_50, Clock, newClock);

	process(newClock, nextState, Reset)
	begin
		if (Reset = '0') then
			state <= ST1;
		elsif (rising_edge(newClock)) then
			state <= nextState;
		end if;
	end process;
	
	process(state, Dimes, Nickles)
	begin
		states <= "00000";
		coke <= '0';
		case state is
			when ST1 =>
				states <= "00001";
				coke <= '0';
				if (Nickles = '1') then
					nextState <= ST3;
				elsif (Dimes = '1') then
					nextState <= ST2;
				else 
					nextState <= state;
				end if;
			when ST2 => 
				states <= "00010";
				coke <= '0';
				if (Dimes = '1' and Nickles = '0') then
					nextState <= ST5;
				elsif (Nickles <= '1') then
					nextState <= ST4;
				else 
					nextState <= state;
				end if;
			when ST3 => 
				states <= "00100";
				coke <= '0';
				if (Nickles = '1') then
					nextState <= ST2;
				elsif (Dimes = '1') then
					nextState <= ST4;
				else 
					nextState <= state;
				end if;
			when ST4 => 
				states <= "01000";
				coke <= '1';
				if (Nickles = '1') then
					nextState <= ST3;
				elsif (Dimes = '1') then
					nextState <= ST2;
				else 
					nextState <= ST1;
				end if;
			when ST5 => 
				states <= "10000";
				coke <= '1';
				if (Nickles = '1') then
					nextState <= ST2;
				elsif (Dimes = '1') then
					nextState <= ST4;
				else 
					nextState <= ST3;
					
				end if;
		end case;
	end process;

end dataflow;
