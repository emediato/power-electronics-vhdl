

---------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------
----- test file (test_adder.vhd): -------------

ARCHITECTURE test_adder OF test_adder IS
----- component declaration: ------
    COMPONENT adder IS
        PORT (a, b: IN INTEGER RANGE 0 TO 255;
              sum: OUT INTEGER RANGE 0 TO 511);
    END COMPONENT;
  ----- signal declarations: ----------------
    SIGNAL a: INTEGER RANGE 0 TO 255;
    SIGNAL b: INTEGER RANGE 0 TO 255;
    SIGNAL sum: INTEGER RANGE 0 TO 511;
 BEGIN
 ----- component instantiation: ------------
    dut: adder PORT MAP (a=>a, b=>b, output=>sum);
 ----- signal a: ---------------------------
 process
 BEGIN
        a <= 0;
        WAIT FOR 50 ns;
        a <= 150;
        WAIT FOR 50 ns;
        a <= 200;
        WAIT FOR 50 ns;
        a <= 250;
        WAIT FOR 50 ns;
END PROCESS;
----- signal b: --------------------------
PROCESS
    BEGIN
    b <= 0;
    WAIT FOR 75 ns;
    b <= 120;
    WAIT FOR 75 ns;
    b <= 240;
    WAIT FOR 50 ns;
    END PROCESS;
END test_adder;