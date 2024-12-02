-- Main code
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.package_of_types_and_weights.ALL;
USE work.package_of_sigmoid.ALL;
USE work.package_of_amplitude.ALL;

ENTITY neural_net IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        x : IN SIGNED(N-1 DOWNTO 0);
        y : OUT short_array
    );
END neural_net;

ARCHITECTURE rtl OF neural_net IS
    SIGNAL prod, acc1, acc2 : long_array;
    SIGNAL sigmoid : short_array;
    SIGNAL counter : INTEGER RANGE 1 TO weights+1;
BEGIN

    -- Counter process =  control the inputs and to act as a pointer to the stored weights. 
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' THEN
                counter <= 1;
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;

    -- Registers for acc2 and y - implements the registers for the signals acc1 → acc2 and sigmoid → y
    PROCESS(clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            IF rst = '1' THEN

                FOR i IN 1 TO neurons LOOP
                    y(i) <= sigmoid(i);
                    acc2(i) <= (OTHERS => '0');
                END LOOP;

            ELSE

                FOR i IN 1 TO neurons LOOP
                    acc2(i) <= acc1(i);
                END LOOP;

            END IF;
        END IF;
    END PROCESS;

    -- Combinational process for computations - constructs the combinational units of the circuit.
    PROCESS(x, counter)
    BEGIN
        FOR i IN 1 TO neurons LOOP

            prod(i) <= x * TO_SIGNED(weight(i, counter), N);
            acc1(i) <= prod(i) + acc2(i);

            IF ((acc2(i)(2*N-1) = prod(i)(2*N-1)) AND (
                                            acc1(i)(2*N-1) /= acc2(i)(2*N-1))) THEN

                acc1(i) <= ((2*N-1) => acc2(i)(2*N-1)), -- causes the accumulated value to assume the largest possible value if overflow occurs

                    OTHERS => NOT acc2(i)(2*N-1);

                    
            END IF;

            sigmoid(i) <= conv_sig(acc2(i));

        END LOOP;
    END PROCESS;

END rtl;