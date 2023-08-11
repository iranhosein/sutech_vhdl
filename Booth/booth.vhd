----------------------------------------------------------------------------------
-- Company: Sutech University
-- Engineer: Hossein Abdollahipour
--
-- Create Date: 17:11:40 08/22/2020 
-- Design Name:
-- Module Name: booth - Behavioral 
-- Project Name: Booth
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

USE ieee.std_logic_signed.ALL;

entity booth is
    GENERIC ( n : integer := 64);
    port ( m : in STD_LOGIC_VECTOR(n - 1 downto 0);
    r : in STD_LOGIC_VECTOR(n - 1 downto 0);
    result : out STD_LOGIC_VECTOR(n + n - 1 downto 0)
    );
end booth;

architecture behavior of booth is
begin
    process(m, r)
        constant NUMBER : std_logic_vector(n-1 downto 0) := (others => '0');
        variable a, s, p : std_logic_vector(n+n+1 downto 0);
        variable mn : std_logic_vector(n-1 DOWNTO 0);
    begin
        a := (others => '0');
        s := (others => '0');
        p := (others => '0');
        if (m /= NUMBER and r /= NUMBER) then
            a(n+n downto n+1) := m;
            a(n+n+1) := m(n-1);
            mn := (not m) + 1;
            s(n+n downto n+1) := mn;
            s(n+n+1) := not(m(n-1));
            p(n downto 1) := r;
            for i in 1 to n loop
                if (p(1 downto 0) = "01") then
                    p := p + a;
                elsif (p(1 downto 0) = "10") then
                    p := p + s;
                end if;
                -- Shift Right Arithmetic
                p(n+n downto 0) := p(n+n+1 downto 1);
            end loop;
        end if;
        result <= p(n+n downto 1);
    end process;
end behavior;


