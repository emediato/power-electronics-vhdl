## Generation of a regular repetitive waveform 

#### Option 1 (compact, but AFTER might not be supported):
  ---------------------------
  SIGNAL clk: BIT := '1';
  ---------------------------
  clk <= NOT clk AFTER 30 ns;

####  Option 2 (recommended):
  ---------------------------
  SIGNAL clk: BIT := '1';
  ---------------------------
  WAIT FOR 30 ns;
  clk <= NOT clk;
  ---------------------------
#### Option 3 (the longest):
  ---------------------------
  SIGNAL clk: BIT := '1';
  ---------------------------
  WAIT FOR 30 ns;
  clk <= '0';
  WAIT FOR 30 ns;
  clk <= '1';

## Generation of a single-pulse waveform (Figure 24.2(b))
##### Note that the last WAIT statement in the code below is unbounded.
  -----------------------
  SIGNAL rst: BIT := '0';
  -----------------------
  WAIT FOR 30 ns;
  rst <= '1';
  WAIT FOR 30 ns;
  rst <= '0';
  WAIT;

## Generation of an irregular nonrepetitive waveform 
##### Instead of repeating the WAIT statement several times, LOOP was employed in the code below with the waveform values assigned first to a CONSTANT (called wave). Note that the last WAIT is again unbounded.
  
CONSTANT wave: BIT_VECTOR(1 TO 8) := "10110100";
SIGNAL x: BIT := '0';
------------------------------------------------
  FOR i IN wave'RANGE LOOP
        x <= wave(i);
        WAIT FOR 30 ns;
  END LOOP;

WAIT;

## Generation of an irregular repetitive waveform (Figure 24.2(d))
#### The only difference with respect to the case above is the removal of the last WAIT.
-------------------------------------------------
CONSTANT wave: BIT_VECTOR(1 TO 8) := "10110100";
SIGNAL y: BIT := '0';   --initial value unnecessary
-------------------------------------------------
  FOR i IN wave'RANGE LOOP
        y <= wave(i);
        WAIT FOR 30 ns;
  END LOOP;

## Generation of a multibit waveform
#### In this case an integer was employed to generate an 8-bit waveform. Note that a signal can be declared without an initial value (which must then obviously be included in the code, as done below). The wave- forms generated from this code are repetitive.
  ---------------------------------
  SIGNAL z: INTEGER RANGE 0 TO 255;
  ---------------------------------
  z <= 0;
  WAIT FOR 120 ns;
  z <= 33;
  WAIT FOR 120 ns;
  z <= 255;
  WAIT FOR 60 ns;
  z <= 99;
  WAIT FOR 180 ns;
