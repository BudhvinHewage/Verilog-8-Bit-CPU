LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dec2to4 IS
    PORT 
	(
        w0, w1  			: IN  STD_LOGIC;
        En 					: IN  STD_LOGIC;
        y				   : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
END dec2to4;

ARCHITECTURE Behavior OF dec2to4 IS
    SIGNAL Enw: STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    Enw <= En & w1 & w0;
	 PROCESS (ENW)
	 BEGIN
        -- Initialize outputs to '0'
        y(0) <= '0';
        y(1) <= '0';
        y(2) <= '0';
        y(3) <= '0';
        
        IF Enw = "100" THEN
            y(0) <= '1';
        ELSIF Enw = "101" THEN
            y(1) <= '1';
        ELSIF Enw = "110" THEN
            y(2) <= '1';
        ELSIF Enw = "111" THEN
            y(3) <= '1';
        ELSE
            -- All outputs remain '0' if Enw is not one of the above
        END IF;
	END PROCESS;
END Behavior;