----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
-- 
-- Create Date: 08/31/2020 11:12:01 AM
-- Design Name: 
-- Module Name: control - Behavioral
-- Project Name: control
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

entity control is
    generic ( number: integer := 8);
    Port (
        temp: in std_logic_vector(number-1 downto 0);
        clk, reset: in std_logic;
        cooler_LED, heater_LED: out std_logic;
        speed: out std_logic_vector(3 downto 0)
        );
end control;

architecture Behavioral of control is

    component cooler is
        generic ( number: integer := 8);
        Port (
            temp: in std_logic_vector(number-1 downto 0);
            clk, cooler_on: in std_logic;
            speed: out std_logic_vector(3 downto 0) 
            );
    end component;
    
    for all: cooler use entity work.cooler(Behavioral);
    
    
    component heat_cooler is
        generic ( number: integer := 8);
        Port (
            temp: in std_logic_vector(number-1 downto 0);
            clk, reset: in std_logic;
            cooler_on, heater_on: out std_logic
            );
    end component;
    
    for all: heat_cooler use entity work.heat_cooler(Behavioral);
    
    
--    signal temp_I: std_logic_vector(number-1 downto 0) := "00000000";
    signal cooler_LED_I: std_logic := '0';

begin

    cooler_config: cooler
    port map (
        temp => temp,
        clk => clk,
        cooler_on => cooler_LED_I,
        speed => speed
        );

    heat_cooler_config: heat_cooler
    port map (
        temp => temp,
        clk => clk,
        reset => reset,
        cooler_on => cooler_LED_I,
        heater_on => heater_LED
        );
        
    cooler_LED <= cooler_LED_I;
        
--    porting: process
--    begin
        
--    end process porting;

end Behavioral;
