LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ssegModified IS
	PORT (L 			:IN 	STD_LOGIC_VECTOR(3 DOWNTO 0);
		  leds 		:OUT 	STD_LOGIC_VECTOR(1 TO 7);
		  sign 		:OUT  STD_LOGIC_VECTOR(1 TO 7));
END ssegModified ;

ARCHITECTURE Behavior OF ssegModified IS

BEGIN
	PROCESS (L)
	BEGIN
		IF L(3) = '0' THEN
			sign <= NOT "0000000";
		ELSE
			sign <= NOT "0000001";
		END IF;

		IF L = "0001" THEN
		              --abcdefg
			leds <= NOT "1110110";  -- Display n
		ELSIF L = "0000" OR L = "1111" THEN
			leds <= NOT "0111011";  -- Display y
		END IF;

	END PROCESS;
END Behavior ;