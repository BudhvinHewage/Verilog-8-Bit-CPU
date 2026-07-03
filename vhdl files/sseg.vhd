LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
	PORT (L 			:IN 	STD_LOGIC_VECTOR(3 DOWNTO 0);
		  leds 		:OUT 	STD_LOGIC_VECTOR(1 TO 7);
		  sign 		:OUT  STD_LOGIC_VECTOR(1 TO 7));
END sseg ;

ARCHITECTURE Behavior OF sseg IS

BEGIN
	PROCESS (L)
	BEGIN
		IF L(3) = '0' THEN
			sign <= NOT "0000000";
		ELSE
			sign <= NOT "0000001";
		END IF;

		IF L = "0000" THEN
			leds <= NOT "1111110";  -- Display 0
		ELSIF L = "0001" OR L = "1111" THEN
			leds <= NOT "0110000";  -- Display 1
		ELSIF L = "0010" OR L = "1110" THEN
			leds <= NOT "1101101";  -- Display 2
		ELSIF L = "0011" OR L = "1101" THEN
			leds <= NOT "1111001";  -- Display 3
		ELSIF L = "0100" OR L = "1100" THEN
			leds <= NOT "0110011";  -- Display 4
		ELSIF L = "0101" OR L = "1011" THEN
			leds <= NOT "1011011";  -- Display 5
		ELSIF L = "0110" OR L = "1010" THEN
			leds <= NOT "1011111";  -- Display 6
		ELSIF L = "0111" OR L = "1001" THEN
			leds <= NOT "1110000";  -- Display 7
		ELSIF L = "1000" THEN
			leds <= NOT "1111111";  -- Display 8
		END IF;

	END PROCESS;
END Behavior ;