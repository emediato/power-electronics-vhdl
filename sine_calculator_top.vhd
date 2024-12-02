// Code your design here
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sine_calculator_top is
    generic (
        NUM_COEF : natural := 32;  -- Number of coefficients in sine_calculator
        NUM_BITS : natural := 7    -- Number of bits for sine amplitude
    );
    port (
        clk    : in std_logic;                    -- Clock signal
        reset  : in std_logic;                    -- Reset signal
        phase  : in natural range 0 to 360;       -- Phase input in degrees
        sine   : out integer range -2**NUM_BITS to 2**NUM_BITS - 1  -- Sine output
    );
end entity;

architecture top_arch of sine_calculator_top is
    -- Signal to connect to the sine_calculator output
    signal sine_output : integer range -2**NUM_BITS to 2**NUM_BITS - 1;

begin
    -- Instantiate the sine_calculator
    sine_inst: entity work.sine_calculator
        generic map (
            NUM_COEF => NUM_COEF,  -- Pass generics from top-level
            NUM_BITS => NUM_BITS   -- Pass generics from top-level
        )
        port map (
            phase => phase,        -- Connect phase input
            sine  => sine_output   -- Connect sine output to the signal
        );

    -- Assign sine output to top-level port
    sine <= sine_output;

end architecture;

entity sine_calculator is
    generic (
        NUM_COEF : natural := 32;   -- Number of coefficients in the ROM
        NUM_BITS : natural := 7     -- Number of bits for amplitude
    );
    port (
        phase : in natural range 0 to 360; -- Input phase in degrees
        sine  : out integer range -2**NUM_BITS to 2**NUM_BITS - 1 -- Output sine value
    );
end entity;

architecture sine_table of sine_calculator is
    -- Define a type for the ROM table
    type integer_array is array (0 to NUM_COEF - 1) of integer range 0 to 2**NUM_BITS - 1;

    -- Predefined sine values for one-quarter cycle (0 to 90 degrees)
    constant ROM : integer_array := (
        0, 3, 9, 16, 22, 28, 34, 40, 
        46, 51, 57, 63, 68, 73, 78, 83,
        88, 92, 96, 100, 104, 107, 110, 113, 
        116, 118, 121, 123, 124, 126, 127, 127
    );

begin
    -- Use symmetry to calculate sine values
    with phase select
        sine <= 
            0 when 0,  -- Sine of 0 degrees is 0
            ROM(phase * (NUM_COEF - 1) / 90) when 1 to 89,  -- First quadrant
            ROM(NUM_COEF - 1) when 90,  -- Sine of 90 degrees is max amplitude
            ROM((NUM_COEF - 1) * (180 - phase) / 90) when 91 to 179,  -- Second quadrant
            0 when 180,  -- Sine of 180 degrees is 0
            -ROM((NUM_COEF - 1) * (phase - 180) / 90) when 181 to 269,  -- Third quadrant
            -ROM(NUM_COEF - 1) when 270,  -- Sine of 270 degrees is -max amplitude
            -ROM((NUM_COEF - 1) * (360 - phase) / 90) when 271 to 359,  -- Fourth quadrant
            0 when 360;  -- Sine of 360 degrees is 0
end architecture;