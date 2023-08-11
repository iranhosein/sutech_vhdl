----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
-- 
-- Create Date: 08/31/2020 09:40:08 PM
-- Design Name: 
-- Module Name: tb_control - Behavioral
-- Project Name: 
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

entity tb_control is
end tb_control;

architecture Behavioral of tb_control is

    constant number: integer := 8;
    signal temp_I: std_logic_vector(number-1 downto 0);
    signal clk_I, reset_I, cooler_LED_I, heater_LED_I: std_logic ;
    signal speed_I: std_logic_vector(3 downto 0);

begin

    UUT: entity work.control
    port map(
        temp => temp_I,
        clk => clk_I,
        reset => reset_I,
        cooler_LED => cooler_LED_I,
        heater_LED => heater_LED_I,
        speed => speed_I
        );
        
    
    tf: process
    begin
        
        reset_I <= '1';
        
        for i in 0 to 20 loop
            clk_I <= '0';
            wait for 30ns;
            clk_I <= '1';
            wait for 30ns;
        end loop;
    
    end process tf;
    
    tb: process
    begin
            
        temp_I <= "11111011";
        wait for 500ns;
        
        temp_I <= "00100100";
        wait for 500ns;
        
        temp_I <= "00001010";
        wait for 500ns;
        
        temp_I <= "00110111";
        wait for 500ns;
        
        temp_I <= "00011000";
        wait for 500ns;
        
    
    end process tb;

end Behavioral;
