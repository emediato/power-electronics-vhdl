-- Main code
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY hello_world IS
    PORT (
        clk : IN STD_LOGIC;
        led : OUT STD_LOGIC
    );
END hello_world;

ARCHITECTURE rtl OF hello_world IS
    CONSTANT clk_freq   : integer   := 50000000; -- 50 MHz
    constant blink_freq     : integer   := 2; -- piscar frequencia de 1 s
    SIGNAL counter_max  : INTEGER   := clk_freq/blink_freq/2-1;

    signal cnt : unsigned(24 downto 0);
    signal blink : std_logic;

    BEGIN

    PROCESS(clk)
        BEGIN
            IF rising_edge(clk) THEN
                IF cnt = counter_max THEN
                    counter <= (others => '0'));
                    blink   <= not blink;
                ELSE
                cnt <= cnt + 1;
                END IF;
            END IF;
        END PROCESS;
        led <= blink;

end rtl;
