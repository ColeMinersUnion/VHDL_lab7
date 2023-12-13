library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity counter is
	port(
		Clock, ResetN : IN std_logic;
		address : OUT std_logic_vector(4 downto 0)
	);
end counter;

architecture struct of counter is

signal count : unsigned(4 downto 0) := "00000";

begin
	
	Process(count, ResetN, Clock)
	BEGIN
        IF ResetN = '0' THEN
            count <= "00000";
        ELSIF Clock = '1' THEN
            IF count = 31 THEN
					count <= "00000";
				ELSE 
					count <= count + 1;
				END IF;
		  ELSE
				count <= count;
        END IF;
    END PROCESS;
	 
	 
	address <= std_logic_vector(count);

end struct;
