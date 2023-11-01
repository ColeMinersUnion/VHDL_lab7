LIBRARY ieee;

USE ieee.std_logic_1164.all;

 

ENTITY display_decoder IS

PORT(

                A : in std_logic;

                B : in std_logic;

                C : in std_logic;

                D : in std_logic;

                Disp : out std_logic_vector(6 downto 0)


);

 

END display_decoder;

 

ARCHITECTURE dataflow OF display_decoder IS

               

BEGIN
	 Disp(0) <= ((not A) and (not C) and (B xor D)) or ((A and D and (B xor C))); --fine

	 Disp(1) <= (B and (not C) and (A xor D)) or (A and C and D) or (B and C and (not D)); --fine

	 Disp(2) <= not((A xor B) or ((not A) and ((not C) or D)) or ((not C) and D)); --fine

	 Disp(3) <= ((not A) and (not C) and (B xor D)) or (B and C and D) or (A and (not B) and (C xor D)); --fine

	 Disp(4) <= not((A and (B or C)) or ((not D) and ((not B) or C))); --fine

	 Disp(5) <= not(((not C) and (not D)) or (A and (not B)) or (B and (not D)) or (B and D and (A xnor C)));

	 Disp(6) <= not(((not A) and B and (not C)) or (A and ((not B) or D)) or (C and ((not B) or (not D)))); --fine

END dataflow;