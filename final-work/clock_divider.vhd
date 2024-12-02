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
     IF (clk'EVENT AND clk='1') THEN
         IF (ena = '1') THEN
            count := count + 1;

            IF (count=max) then
                temp:= NOT temp;
                count := 0;
            END IF;
            END IF;
            output <= temp;
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

    
END test_clock_divider;