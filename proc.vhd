LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY proc IS
    PORT ( DIN                 : IN      STD_LOGIC_VECTOR(8 DOWNTO 0);
           Clock_50, Clock, Resetn, Run  : IN      STD_LOGIC;
           Done                : BUFFER  STD_LOGIC;
           BusWires            : BUFFER  STD_LOGIC_VECTOR(8 DOWNTO 0));
END proc;
   
ARCHITECTURE Behavior OF proc IS
   ------------------------------------------------------------------
   -- Define components --
   ------------------------------------------------------------------
   Component addsub IS
    PORT ( AddSub : IN STD_LOGIC;
           A, B : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
           Sum : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
	end component;
	
	component busmux IS
    PORT ( DIN, G, R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
           Rout : IN STD_LOGIC_VECTOR(0 TO 7);
           Gout, DINout : IN STD_LOGIC;
           BusWires : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
	end component;
	
	Component controlunit IS
		PORT ( Clock, Resetn, Run : IN STD_LOGIC;
          IR : IN STD_LOGIC_VECTOR(1 to 9);
          IRin, DINout, Ain, Gin, Gout : OUT STD_LOGIC;
          AddSub : OUT STD_LOGIC;
          Rout, Rin : OUT STD_LOGIC_VECTOR(0 TO 7);
          Done : BUFFER STD_LOGIC);
	end component;
	
	Component regn is 
	PORT ( R           : IN      STD_LOGIC_VECTOR(8 DOWNTO 0);
          Rin, Clock  : IN      STD_LOGIC;
          Q           : BUFFER  STD_LOGIC_VECTOR(8 DOWNTO 0));
	end component;
	
	Component debounce is PORT(
    clk     : IN  STD_LOGIC;  --input clock
    button  : IN  STD_LOGIC;  --input signal to be debounced
    result  : OUT STD_LOGIC);
	end component;
   ------------------------------------------------------------------
   -- Define intermediate signals --
   ------------------------------------------------------------------
	
	--register signals
	signal newClock : std_logic;
	signal RR0, RR1, RR2, RR3, RR4, RR5, RR6, RR7, IRR, GR, AR : std_logic_vector(8 downto 0);
	signal R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, IrrIn, Gin, Ain : std_logic;
	
	--busmux signals
	signal Rout : std_logic_vector(0 to 7);
	signal GBusOut, DBusOut : std_logic;
	
	--addsub signals
	signal add_sub : std_logic;
	signal X, Y, Solution : std_logic_vector(8 downto 0);
	
	--control unit signals
	signal cpuIR : std_logic_vector(1 to 9);
	signal cpuIRin, cpuDINout, cpuAin, cpuGin, cpuGout : std_logic;
	signal cpuRin : std_logic_vector(7 downto 0);
	
BEGIN
	
	dbr : debounce port map(Clock_50, clock, newClock);
	
   ------------------------------------------------------------------
   -- Connect registers (R1 - R7, A, G, IR) --
   ------------------------------------------------------------------
	R0 : regn port map(RR0, R0in, newClock);
	R1 : regn port map(RR1, R1in, newClock);
	R2 : regn port map(RR2, R2in, newClock);
	R3 : regn port map(RR3, R3in, newClock);
	R4 : regn port map(RR4, R4in, newClock);
	R5 : regn port map(RR5, R5in, newClock);
	R6 : regn port map(RR6, R6in, newClock);
	R7 : regn port map(RR7, R7in, newClock);
	IR : regn port map(IRR, IrrIn, newClock);
	G : regn port map(GR, Gin, newClock);
	A : regn port map(AR, Ain, newClock);
	
   ------------------------------------------------------------------
   -- Connect bus multiplexer --
   ------------------------------------------------------------------
	bmux : busmux port map(DIN, GR, RR0, RR1, RR2, RR3, RR4, RR5, RR6, RR7, 
									Rout, GBusOut, DBusOut, BusWires); 
   ------------------------------------------------------------------
   -- Connect addsub --
   ------------------------------------------------------------------
	calculator : addsub port map(add_sub , X, Y, Solution);
   ------------------------------------------------------------------
   -- Connect control unit --
   ------------------------------------------------------------------
   houston : controlunit port map(newClock, ResetN, Run,
											cpuIR,
											IrrIn, cpuDINout, cpuAin, cpuGin, cpuGout,
											add_sub, Rout, cpuRin,
											Done);
											
	 
	 
END Behavior;


