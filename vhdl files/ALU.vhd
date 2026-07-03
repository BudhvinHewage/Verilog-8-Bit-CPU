LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity ALU is
     port (
          clk, res    : in std_logic;
          Reg1, Reg2  : in std_logic_vector(7 downto 0);
          opcode      : in std_logic_vector(7 downto 0);
          studentID   : in std_logic_vector(3 downto 0);
          check       : out std_logic_vector(3 downto 0);
          Result      : out std_logic_vector(7 downto 0)
     );
end ALU;

architecture calculation of ALU is
begin
     process (clk, res)
     begin
          if res = '1' then
               Result <= "00000000";
          elsif rising_edge(clk) then  
               case opcode is
                         
                    when "00000001" =>  -- increment A by 2
                         Result <= Reg1 + "00000010"; -- conversion of literal values into unsigned bits allows addition then requires conversion backto vector literal
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "00000010" => -- Shift B to the right by 2
                         Result <= '0' & '0' & Reg2(7) & Reg2(6) & Reg2(5) & Reg2(4) & Reg2(3) & Reg2(2); -- & allows concatenation of individual bits together
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "00000100" => -- Shift B to the right by 2
                         Result <= '1' & '1' & '1' & '1' & Reg1(7) & Reg1(6) & Reg1(5) & Reg1(4); -- & allows concatenation of individual bits together
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "00001000" => -- Find the minimum of A and B and return it
                         if (Reg1 > Reg2) then
                              Result <= Reg2;
                         elsif (Reg1 < Reg2) then
                              Result <= Reg1;
                         else
                              Result <= "00000000";
                         end if;

                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "00010000" => -- Rotate A to the right by 2
                         Result <= Reg1(0) & Reg1(1) & Reg1(7 downto 2);
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "00100000" => -- Invert the bit significance of B
                         Result <= (NOT Reg2);
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "01000000" => -- XOR operation
                         Result <= Reg1 XOR Reg2;
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when "10000000" => -- A + B - 4
                         Result <= Reg1 + Reg2 - "00000100";
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
                    when others =>
                         Result <= "00000000";
                         if studentID(0) = '1' then
                              check <= "0001";
                         else
                              check <= "0000";
                         end if;
               end case;
          end if;
    end process;
end calculation;