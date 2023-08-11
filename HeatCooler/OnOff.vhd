----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
-- 
-- Create Date: 08/31/2020 11:21:40 AM
-- Design Name: 
-- Module Name: heat_cooler - Behavioral
-- Project Name: On/Off
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

entity heat_cooler is
    generic ( number: integer := 8);
    Port (
        temp: in std_logic_vector(number-1 downto 0);
        clk, reset: in std_logic;
        cooler_on, heater_on: out std_logic
        );
end heat_cooler;

architecture Behavioral of heat_cooler is

    subtype STATE_TYPE is std_ulogic_vector(1 downto 0);
    constant S1: STATE_TYPE:= "00";
    constant S2: STATE_TYPE:= "01";
    constant S3: STATE_TYPE:= "11";
    
    signal cooler_on_I, heater_on_I: std_logic;
    signal STATE, NEXTSTATE: STATE_TYPE;

begin

    REG: process(clk, reset)
    begin
        if reset = '1' then
            STATE <= S1;
        elsif clk'event and clk='1' then
            STATE <= NEXTSTATE;
        end if;
    end process REG;
    
    
    CMB: process(STATE, temp)
    begin
        case STATE is
            when S1 =>
                if temp > "00100011" and temp < "10000000" then
                    NEXTSTATE <= S2;
                elsif temp < "00001111" then
                    NEXTSTATE <= S3;
                elsif temp > "01111111" then
                    NEXTSTATE <= S3;
                elsif temp > "00001110" and temp < "00100100" then
                    nextstate <= s1;
                end if;
            when S2 =>
                if temp < "00011001" then
                    NEXTSTATE <= S1;
                elsif temp > "00011000" and temp < "10000000" then
                    NEXTSTATE <= S2;
                elsif temp > "01111111" then
                    NEXTSTATE <= S1;
                end if;
            when S3 =>
                if temp > "00011110" and temp < "10000000" then
                    NEXTSTATE <= S1;
                elsif temp < "00011111" then
                    NEXTSTATE <= S3;
                elsif temp > "01111111" then
                    NEXTSTATE <= S3;
                end if;
            when others =>
                NEXTSTATE <= S1;
        end case;
    end process CMB;
    
    
    OUTPUT: process(NEXTSTATE, temp)
    begin
        case NEXTSTATE is
            when S1 =>
                cooler_on_I <= '0';
                heater_on_I <= '0';
            when S2 =>
                cooler_on_I <= '1';
                heater_on_I <= '0';
            when S3 =>
                cooler_on_I <= '0';
                heater_on_I <= '1';
            when others =>
                cooler_on_I <= '0';
                heater_on_I <= '0';
        end case;
    end process OUTPUT;
    
    
    -- clocked output process
    OUTPUT_REG: process(clk)
    begin
        if clk'event and clk='1' then
            cooler_on <= cooler_on_I;
            heater_on <= heater_on_I;
        end if;
    end process OUTPUT_REG;

end Behavioral;
