library ieee;
use ieee.std_logic_1164.all;
library work;
use work.common_pkg.all;

entity example_entity is
    port (
        clk : in std_logic;
        input_val : in integer;
        output_val : out integer
    );
end entity;

architecture behavior of example_entity is
    signal state : state_type := IDLE; -- Using type from common_pkg
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if state = IDLE then
                output_val <= multiply_by_two(input_val); -- Using function from common_pkg
                state <= START;
            end if;
        end if;
    end process;
end architecture;
