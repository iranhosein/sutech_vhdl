--------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
--
-- Create Date: 19:54:23 08/22/2020
-- Design Name: 
-- Module Name: t_booth
-- Project Name: test bench for booth
-- Target Device: 
-- Tool versions: 
-- Description: 
--
-- VHDL Test Bench Created by ISE for module: booth
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test. Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guaranatee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY t_booth IS
END t_booth;

ARCHITECTURE behavior OF t_booth IS 
constant number: integer:= 64;
-- Component Declaration for the Unit Under Test (UUT)
COMPONENT booth
    PORT(
    m : IN std_logic_vector(number-1 downto 0);
    r : IN std_logic_vector(number-1 downto 0);
    result : OUT std_logic_vector(number+number-1 downto 0)
    );
END COMPONENT;

--Inputs
signal m : std_logic_vector(number-1 downto 0) := (others => '0');
signal r : std_logic_vector(number-1 downto 0) := (others => '0');

--Outputs
signal result : std_logic_vector(number+number-1 downto 0);

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: booth PORT MAP (
    m => m,
    r => r,
    result => result
    );

    process

    begin
        m <= 
        "0000000000000000000000000011100000000000000000100001010010101000"
        ;
        r <= 
        "0000000000000000000000000000000000000011010011111000000110101010"
        ;
        wait for 100 ns;
        m <= 
        "0000000110000000000000000000011000000010010010010101001110101011"
        ;
        r <= 
        "0000000000000011000100110000011000000010010011110101111110101011"
        ;
        wait for 100 ns;
        m <= 
        "0000000000000001100001100000011000000010010011110101111110101011"
        ;
        r <= 
        "0000000000000000000000000000011010010010010010010101111110101011"
        ;
        wait for 100 ns;
    end process;
END ARCHITECTURE;