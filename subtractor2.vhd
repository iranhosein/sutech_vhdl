----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
--
-- Create Date: 10:14:48 08/22/2020 
-- Design Name: 
-- Module Name: my_subtractor - Behavioral 
-- Project Name: One-bit full subtractor 2
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_subtractor is
    port ( x, y, b: in std_logic;
        d: out std_logic
        );
end my_subtractor;

architecture out_bit of my_subtractor is
begin
    d <= ( (not x) and (not y) and b ) or ( (not x) and y and (not b) ) or ( x and (not y) and (not b) ) or ( x and y and b );
end out_bit;

architecture borrow_bit of my_subtractor is
begin
    d <= ( (not x) and y ) or ( (not x) and b ) or ( y and b);
end borrow_bit;