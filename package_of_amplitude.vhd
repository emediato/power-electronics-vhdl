
-- Package with sigmoid function
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.package_of_types_and_weights.ALL;

PACKAGE package_of_amplitude IS
    FUNCTION conv_sig (input : SIGNED) RETURN SIGNED;
END package_of_amplitude;

PACKAGE BODY package_of_amplitude IS
    FUNCTION conv_sig (input : SIGNED) RETURN SIGNED IS
        VARIABLE a : INTEGER RANGE 0 TO 4**N-1;
        VARIABLE b : INTEGER RANGE 0 TO 2**N-1;
    BEGIN
        a := TO_INTEGER(ABS(input));
        IF (a = 0) THEN
            b := 0;
        ELSIF (a > 0 AND a < 50) THEN
            b := 2;
        ELSIF (a >= 50 AND a < 100) THEN
            b := 6;
        END IF;

        IF (input(2*N-1) = '0') THEN
            RETURN TO_SIGNED(b, N);
        ELSE
            RETURN TO_SIGNED(-b, N);
        END IF;
    END FUNCTION conv_sig;
END package_of_amplitude;

