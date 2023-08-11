architecture RTL of REG_TEST2 is
    signal Y_I , Z_I : std_ulogic ;
    signal STATE,NEXTSTATE : STATE_TYPE ;
begin
    REG: process (CLK, RESET) begin
        if RESET='1' then    
            STATE <= START ;
        elsif CLK'event and CLK='1' then
            STATE <= NEXTSTATE ;
        end if ;    
    end process REG ;

    CMB: process (A,B,STATE) begin
        case STATE is
            when START => if (A or B)='0' then
                    NEXTSTATE <= MIDDLE ;
                end if ;
            when MIDDLE => if (A and B)='1' then
                    NEXTSTATE <= STOP ;
                end if ;
            when STOP    => if (A xor B)='1' then
                    NEXTSTATE <= START ;
                end if ;
            when others => NEXTSTATE <= START ;
        end case ;
    end process CMB ;

    OUTPUT: process (NEXTSTATE, A, B)
    begin
        case NEXTSTATE is
           when START   =>
                           Y_I <= '0' ;
                           Z_I <= A and B ;
           when MIDDLE   =>
                           Y_I <= A nor B ;
                           Z_I <= '1' ;
           when STOP   =>
                           Y_I <= A nand B ;
                           Z_I <= A or B ;
           when others =>
                           Y_I <= 0;
                           Z_I <= 0;
           end case;
    end process OUTPUT

    -- clocked output process
    OUTPUT_REG: process(CLK)    begin
        if CLK'event and CLK='1' then
         Y <= Y_I ;
         Z <= Z_I ;
        end if ;
    end process OUTPUT_REG ;
end RTL ; 

