---- Design file (clock_divider.vhd): ------------
ENTITY clock_divider IS
      PORT (clk, ena: IN BIT;
            output: OUT BIT);
END clock_divider;


 -------------------------------------------------
ARCHITECTURE clock_divider OF clock_divider IS
      CONSTANT max: INTEGER := 5;
BEGIN
PROCESS(clk)
    VARIABLE count: INTEGER RANGE 0 TO 7 := 0;
    VARIABLE temp: BIT;
BEGIN
    PROCESS
     wait until (clk'EVENT AND clk='1') ;
         IF (ena = '1') THEN
            WAIT FOR 8 ns; -- counter delay = 8 ns
            count := count + 1;

            IF (count=max) then
                temp:= NOT temp;
                count := 0;
            END IF;
            WAIT FOR 5 ns; -- counter delay = 5 ns

            output <= temp; -- With these delays, the output is only expected to receive a new value 8 + 5 = 13 ns after the proper clock edge
         END IF;
     END IF;
 END PROCESS;


END clock_divider;


---- Test file (test_clock_divider.vhd):---------------------
ENTITY test_clock_divider IS
END test_clock_divider;
 ------------------------------------------------------------
ARCHITECTURE test_clock_divider OF test_clock_divider IS
    ---- component declaration: ------------------
    COMPONENT clock_divider IS
    PORT (clk, ena: IN BIT;
        output: OUT BIT);
    END COMPONENT;
    ---- signal declarations: --------------------
    SIGNAL clk: BIT := '0';
    SIGNAL ena: BIT := '0';
    SIGNAL output: BIT;
    signal template: BIT := '0';

BEGIN

    -- component instantiation
    dut : clock_divider PORT MAP (clk=>clk, ena=>ena, output=>output);

    -- generate clock
    PROCESS 
    BEGIN 
            WAIT FOR 30 ns;
            clk <= NOT clk;

    END PROCESS;

    --generate enable
    PROCESS 
    BEGIN
        WAIT FOR 60 ns;
        ena <= '1';
        WAIT;
    END PROCESS;

    
    --generate TEMPLATE
    PROCESS 
    BEGIN
        WAIT FOR 343 ns;
        WHILE ena <= '1' LOOP
                tempate <= NOT template ;
                WAIT FOR 300 ns ;
                END LOOP ;
        
    END PROCESS;



    --verify output
    PROCESS 
    BEGIN
        WAIT FOR 1 ns;
        assert (OUTPUT = tempate) 
                REPORT "OUTPUT differs from template"
                SEVERITY FAILURE

    END PROCESS;

END test_clock_divider;