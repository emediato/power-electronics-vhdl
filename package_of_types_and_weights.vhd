
-- Package of types and weights
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE package_of_types_and_weights IS
    CONSTANT neurons : INTEGER := 3;  -- # of neurons
    CONSTANT weights : INTEGER := 5;  -- # of weights per neuron
    CONSTANT N : INTEGER := 6;  -- # of bits per weight

    -- Data types
    TYPE short_array IS ARRAY (1 TO neurons) OF SIGNED(N-1 DOWNTO 0);
    TYPE long_array IS ARRAY (1 TO neurons) OF SIGNED(2*N-1 DOWNTO 0);
    TYPE weight_array IS ARRAY (1 TO neurons, 1 TO weights) OF
        INTEGER RANGE -(2**(N-1)) TO 2**(N-1)-1;

    -- Weight values
    CONSTANT weight : weight_array := (
        (1, 4, 5, 5, -5),   -- neuron 1
        (5, 2, 5, 5, -5), -- neuron 2
        (-3, -3, -3, -3, -3) -- neuron 3
    );
END package_of_types_and_weights;
