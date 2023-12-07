LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY busmux IS
    PORT ( DIN, G, R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
           Rout : IN STD_LOGIC_VECTOR(0 TO 7);
           Gout, DINout : IN STD_LOGIC;
           BusWires : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
END busmux;

ARCHITECTURE Behavior OF busmux IS
   SIGNAL Sel : STD_LOGIC_VECTOR(1 to 10); 
BEGIN
 
   Sel <= Rout & Gout & DINout;

   PROCESS (Sel, DIN, G, R0, R1, R2, R3, R4, R5, R6, R7)
   BEGIN
      IF Sel = "1000000000" THEN
         BusWires <= R0;
      ELSIF Sel = "0100000000" THEN
         BusWires <= R1;
      ELSIF Sel = "0010000000" THEN
         BusWires <= R2;
      ELSIF Sel = "0001000000" THEN
         BusWires <= R3;
      ELSIF Sel = "0000100000" THEN
         BusWires <= R4;
      ELSIF Sel = "0000010000" THEN
         BusWires <= R5;
      ELSIF Sel = "0000001000" THEN
         BusWires <= R6;
      ELSIF Sel = "0000000100" THEN
         BusWires <= R7;
      ELSIF Sel = "0000000010" THEN
         BusWires <= G;
      ELSE 
         BusWires <= DIN;
      END IF;
   END PROCESS;   

END Behavior;
