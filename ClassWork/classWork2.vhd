entity FULL_ADDER is
  port (A, B, CI: in bit;
        z, CO: out bit);
end FULL_ADDER;

architecture RTL2 of FULL_ADDER is
    begin
        z <= A xor B xor CI;
        CO <= (A and B) or (A and CI) or (Y and CI);
end architecture RTL2;


architecture STRUCT of FULL_ADDER is
    component HALFADDER
        port (a, b : in bit_vector(1 downto 0);
              z, CO : out bit_vector(1 downto 0));
    end component;
    signal C: bit_vector(4 downto 0);
    begin
	F:for I in 3 downto 0 generate
	    FAS: FULL_ADDER port map( A(I), B(I), C(I), S(I), C(I+1));
	end generate F;
        Cout <= C(4);
	C(0) <= Cin;
    end STRUCT;


