----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
--
-- Create Date: 10:28:29 08/22/2020 
-- Design Name: 
-- Module Name: debt - Behavioral 
-- Project Name: One-bit full subtractor 1
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

entity debt is
    generic ( n: integer := 64 );
    port ( x, y: in std_logic_vector(n-1 downto 0);
    b: in std_logic;
    d: out std_logic_vector(n downto 0));
end debt;

architecture Behavioral of debt is
    component COMP1 is
        port ( x, y, b: in std_logic;
        d: out std_logic);
    end component;
    component COMP2 is
        port ( x, y, b: in std_logic;
        d: out std_logic);
    end component;
    for all: COMP1 use entity work.my_subtractor(borrow_bit);
    for all: COMP2 use entity work.my_subtractor(out_bit);
    -- for rest: COMP use entity work.my_subtractor(borrow_bit);
    -- for fulls: COMP use entity work.my_subtractor(out_bit);
    constant number: integer := 64;
    signal im: std_logic_vector(number downto 0);
    begin
        im(0) <= '0';
        c_1: for i in 0 to number-1 generate
            deb: COMP1 port map ( x(i), y(i), im(i), im(i+1) );
        end generate;
        c_2: for i in 0 to number-1 generate
            ou: COMP2 port map ( x(i), y(i), im(i), d(i) );
        end generate;
        d(number) <= im(number);
end Behavioral;