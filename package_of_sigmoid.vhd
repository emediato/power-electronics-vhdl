
-- Package with sigmoid function
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.package_of_types_and_weights.ALL;

PACKAGE package_of_sigmoid IS
    FUNCTION conv_sigmoid (input : SIGNED) RETURN SIGNED;
END package_of_sigmoid;

PACKAGE BODY package_of_sigmoid IS
    FUNCTION conv_sigmoid (input : SIGNED) RETURN SIGNED IS
        VARIABLE a : INTEGER RANGE 0 TO 4**N-1;
        VARIABLE b : INTEGER RANGE 0 TO 2**N-1;
    BEGIN
        a := TO_INTEGER(ABS(input));
        IF (a = 0) THEN
            b := 0;
        ELSIF (a > 0 AND a < 9) THEN
            b := 2;
        ELSIF (a >= 9 AND a < 19) THEN
            b := 6;
        ELSIF (a >= 19 AND a < 30) THEN
            b := 10;
        ELSIF (a >= 30 AND a < 42) THEN
            b := 14;
        ELSIF (a >= 42 AND a < 56) THEN
            b := 18;
        ELSIF (a >= 56 AND a < 75) THEN
            b := 22;
        ELSIF (a >= 75 AND a < 104) THEN
            b := 2;
        ELSE
            b := 30;
        END IF;

        IF (input(2*N-1) = '0') THEN
            RETURN TO_SIGNED(b, N);
        ELSE
            RETURN TO_SIGNED(-b, N);
        END IF;
    END FUNCTION conv_sigmoid;
END package_of_sigmoid;

