LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY controlunit IS
   PORT ( Clock, Resetn, Run : IN STD_LOGIC;
          IR : IN STD_LOGIC_VECTOR(1 to 9);
          IRin, DINout, Ain, Gin, Gout : OUT STD_LOGIC;
          AddSub : OUT STD_LOGIC;
          Rout, Rin : OUT STD_LOGIC_VECTOR(0 TO 7);
          Done : BUFFER STD_LOGIC);
END controlunit;

ARCHITECTURE Behavior OF controlunit IS

   -- Decoder that converts 3-bit codes for registers X and Y to register enable vectors
   COMPONENT dec3to8 
      PORT ( W   : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
             En  : IN   STD_LOGIC;
             Y   : OUT  STD_LOGIC_VECTOR(0 TO 7));
   END COMPONENT;
   
   -- FSM states
   TYPE State_type IS (T0, T1, T2, T3);
   SIGNAL Tstep_Q, Tstep_D: State_type;

   -- 3-bit instruction code
   SIGNAL I : STD_LOGIC_VECTOR(2 DOWNTO 0); 
   -- instruction register enable vectors (will get these from 3-bit instruction register codes and 3to8 decoder)
   SIGNAL Xreg, Yreg : STD_LOGIC_VECTOR(0 TO 7); 

   -- 3to8 decoder enable
   SIGNAL En : STD_LOGIC; 
BEGIN

   En <= '1';
   I <= IR(1 TO 3);
   -- dec3to8 converts 3-bit opcode X and Y to 8-bit register enable vectors 
   decX: dec3to8 PORT MAP (IR(4 TO 6), En, Xreg);
   decY: dec3to8 PORT MAP (IR(7 TO 9), En, Yreg);
   
   -------------------
   -- FSM processes --
   -------------------
   -- State transition process
   fsmflipflops: PROCESS (Clock, Resetn, Tstep_D)
   BEGIN
         IF (Resetn = '0') THEN
            Tstep_Q <= T0;
         ELSIF (rising_edge(Clock)) THEN
            Tstep_Q <= Tstep_D;
         END IF;
   END PROCESS; 

   -- Next-state logic process
   statetable: PROCESS(Tstep_Q, Run, Done)
   BEGIN
      CASE Tstep_Q IS
         WHEN T0 =>    -- data is loaded into IR in this time step
               IF(Run = '0') THEN Tstep_D <=T0;
               ELSE Tstep_D <= T1;
               END IF;
         WHEN T1 =>   
				IF(Done = '1') THEN Tstep_D <= T0;
				ELSE Tstep_D <= T2;
				END IF;
			WHEN T2 =>
				Tstep_D <= T3;
			WHEN T3 =>
				Tstep_D <= T0;
				
         ----------------------------------------
         -- Add other states and behavior here --
         ----------------------------------------
      END CASE;
   END PROCESS; 

   -- Control signals process
   controlsignals: PROCESS (Tstep_Q, I, Xreg, Yreg)
   -- Instruction Table
   --    000: mv    Rx,Ry      : Rx <- [Ry]
   --    001: mvi   Rx,#D      : Rx <- D
   --    010: add   Rx,Ry      : Rx <- [Rx] + [Ry]
   --    011: sub   Rx,Ry      : Rx <- [Rx] - [Ry]
   --    OPCODE format: III XXX YYY, where 
   --    III = instruction, XXX = Rx, and YYY = Ry. For mvi,
   --    a second word of data is loaded from DIN
   BEGIN
      -- Pre-assign values
      Done <= '0'; Ain <= '0'; Gin <= '0'; Gout <= '0'; AddSub <= '0';
      IRin <= '0'; DINout <= '0'; Rin <= "00000000"; Rout <= "00000000";
      CASE Tstep_Q IS
         WHEN T0 => -- store DIN in IR as long as Tstep_Q = 0
            IRin <= '1';
         WHEN T1 => -- define signals in time step T1 (depends on instruction)
            CASE I IS 
               WHEN "000" => -- mv Rx,Ry
               ----------------------------------------------
               -- Define signals for each instruction here --
               ----------------------------------------------
						Rout <= Yreg;
						Rin <= Xreg;
						Done <= '1';
					WHEN "001" => 
						--move immediate
						DINout <= '1';
						Rin <= Xreg;
						Done <= '1';
					WHEN "010" =>
						Ain <= '1';
						Rout <= Xreg;
					WHEN "011" => 
						Ain <= '1';
						Rout <= Xreg;
					WHEN OTHERS =>
						Rin <= "00000000"; 
						Rout <= "00000000";
            END CASE;
         WHEN T2 => -- define signals in time step T2 (depends on instruction)
            CASE I IS
               ----------------------------------------------
               -- Define signals for each instruction here --
					----------------------------------------------
					WHEN "010" =>
						Rout <= Yreg;
						Gin <= '1';
					WHEN "011" =>
						Rout <= Yreg;
						Gin <= '1';
						AddSub <= '1';
					WHEN OTHERS =>
						Rin <= "00000000"; 
						Rout <= "00000000";
				END CASE;
         WHEN T3 => -- define signals in time step T3
            CASE I IS
               ----------------------------------------------
               -- Define signals for each instruction here --
               ----------------------------------------------
					WHEN "010" =>
						Rin <= Xreg;
						Gout <= '1';
						Done <= '1';
					WHEN "011" =>
						Rin <= Xreg;
						Gout <= '1';
						Done <= '1';
					WHEN OTHERS =>
						Rin <= "00000000"; 
						Rout <= "00000000";
            END CASE;
      END CASE;
   END PROCESS;

END Behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dec3to8 IS
   PORT ( W   : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
          En  : IN   STD_LOGIC;
          Y   : OUT  STD_LOGIC_VECTOR(0 TO 7));
END dec3to8;

ARCHITECTURE Behavior OF dec3to8 IS
BEGIN
   PROCESS (W, En)
   BEGIN
      IF (En = '1') THEN
         CASE W IS
            WHEN "000" => Y <= "10000000";
            WHEN "001" => Y <= "01000000";
            WHEN "010" => Y <= "00100000";
            WHEN "011" => Y <= "00010000";
            WHEN "100" => Y <= "00001000";
            WHEN "101" => Y <= "00000100";
            WHEN "110" => Y <= "00000010";
            WHEN "111" => Y <= "00000001";
            WHEN OTHERS => Y <= "00000000";
         END CASE;
      ELSE 
         Y <= "00000000";
      END IF;
   END PROCESS;
END Behavior;
