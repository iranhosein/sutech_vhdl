CREATED BY HOSSEIN ABDOLLAHIPOUR

entity FA is
  port (a, b: in bit_vector(1 downto 0);
        Cin: in bit;
        s: out bit_vector(1 downto 0);
        c2: out bit);
end FA;
 
architecture RTL of FA is
    component FULLADDER
        port(a, b: in bit_vector(1 downto 0);
            Cin: in bit;
            s: out bit_vector(1 downto 0);
            c2: out bit);
    end component;
    for MODULE1: FULLADDER use entity work.FULLADDER(FA1);
begin
    s(0) <= a(0) xor b(0) xor cin;
    c(1) <= (a(0) and b(0)) or (a(0) and cin) or (b(0) and cin);
    s(1) <= a(1) xor b(1) xor c(1);
    c(2) <= (a(1) and b(1)) or (a(1) and c(1)) or (b(1) and c(1));
end RTL;
