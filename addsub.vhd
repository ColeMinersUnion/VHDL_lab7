  LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY addsub IS
    PORT ( AddSub : IN STD_LOGIC;
           A, B : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
           Sum : OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
END addsub;

ARCHITECTURE Behavior OF addsub IS
    
BEGIN
    PROCESS (AddSub, A, B)
    BEGIN
        IF AddSub = '0' THEN
            Sum <= A + B;
        ELSE
            Sum <= A - B;
        END IF;
    END PROCESS;

END Behavior;
