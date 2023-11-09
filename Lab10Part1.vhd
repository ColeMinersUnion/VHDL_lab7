library ieee;
use ieee.std_logic_1164.all;
use ieee.Numeric_std.all;


entity Lab10Part1 is
	port(	Enable: IN std_logic;
			--Clear : IN std_logic;
			Reset : IN std_logic;
			Clock : IN std_logic;
			Clk50 : IN std_logic;
			output : OUT std_logic_vector(6 downto 0)
		);
end Lab10Part1;

architecture dataflow of Lab10Part1 is

	component reg is
		port( D : IN std_logic_vector(3 downto 0);
				R, clock, Clock50 : IN std_logic;
				Qa : OUT std_logic_vector(3 downto 0)
		);
	end component;
	
	component display_decoder is
		port( A, B, C, D : IN std_logic;
				Disp : OUT std_logic_vector(6 downto 0));
	end component;

signal intput : std_logic_vector(3 downto 0) := "0000";
--signal outVect: std_logic_vector(3 downto 0);
begin
	
	regInt : reg port map(intput, Reset, Clock, Clk50, intput);
	disp : display_decoder port map(intput(0), intput(1), intput(2), intput(3), output);
	
	
	process(Clear, Enable, intput, Clock)
	begin
		if(Clear = '1') then
			intput <= "0000";
		elsif(Enable = '1' and rising_edge(Clock)) then
			if (input = "1001") then
				-- add rst logic
			intput <= intput + "0001";
		else
			intput <= "0000";
		end if;
	end process;
	
	  

end dataflow;

