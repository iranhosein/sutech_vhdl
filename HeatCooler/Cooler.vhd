----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
-- 
-- Create Date: 08/30/2020 01:48:03 PM
-- Design Name: 
-- Module Name: cooler - Behavioral
-- Project Name: cooler
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cooler is
    generic ( number: integer := 8);
    Port (
        temp: in std_logic_vector(number-1 downto 0);
        clk, cooler_on: in std_logic;
        speed: out std_logic_vector(3 downto 0) 
        );
end cooler;

architecture Behavioral of cooler is

    subtype STATE_TYPE is std_ulogic_vector(1 downto 0);
    constant S1: STATE_TYPE:= "00";
    constant S2: STATE_TYPE:= "01";
    constant S3: STATE_TYPE:= "11";
    constant S_out: STATE_TYPE:= "10";
    
    signal speed_I: std_logic_vector(3 downto 0);
    signal STATE, NEXTSTATE: STATE_TYPE := "00";

begin

    REG: process(clk, cooler_on)
    begin
        if cooler_on = '0' then
            STATE <= S_out;
        elsif clk'event and clk='1' then
            STATE <= NEXTSTATE;
        end if;
    end process REG;
   
    
    CMB: process(STATE, temp)
    begin
        case STATE is
            when S_out =>
                if temp > "00100011" and temp < "10000000" then
                    NEXTSTATE <= S1;
                elsif temp < "00100100" then
                    NEXTSTATE <= S_out;
                elsif temp > "01111111" then
                    NEXTSTATE <= S_out;
                end if;
            when S1 =>
                if temp > "00101000" and temp < "10000000" then
                    NEXTSTATE <= S2;
                elsif temp < "00011001" then
                    NEXTSTATE <= S_out;
                elsif temp > "01111111" then
                    NEXTSTATE <= S_out;
                elsif temp < "00101001" and temp > "00011000" then
                    NEXTSTATE <= S1;
                end if;
            when S2 =>
                if temp < "00100011" then
                    NEXTSTATE <= S1;
                elsif temp > "01111111" then
                    NEXTSTATE <= S1;
                elsif temp > "00101101" and temp < "10000000" then
                    NEXTSTATE <= S3;
                elsif temp > "00100010" and temp < "00101110" then
                    NEXTSTATE <= S2;
                end if;
            when S3 =>
                if temp < "00101000" then
                    NEXTSTATE <= S2;
                elsif temp > "01111111" then
                    NEXTSTATE <= S2;
                elsif temp > "00100111" and temp < "10000000" then
                    NEXTSTATE <= S3;
                end if;
            when others =>
                NEXTSTATE <= S_out;
        end case;
    end process CMB;
    
    
    OUTPUT: process(NEXTSTATE, temp)
    begin
        case NEXTSTATE is
            when S_out =>
                speed_I <= "0000";
            when S1 =>
                speed_I <= "0100";
            when S2 =>
                speed_I <= "0110";
            when S3 =>
                speed_I <= "1000";
            when others =>
                speed_I <= "0000";
        end case;
    end process OUTPUT;
    
    
    -- clocked output process
    OUTPUT_REG: process(clk)
    begin
        if clk'event and clk='1' then
            speed <= speed_I;
        end if;
    end process OUTPUT_REG;
    
    

end Behavioral;
