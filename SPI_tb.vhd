library ieee;
use ieee.std_logic_1164.all;

entity ads128x_spi_with_mux_tb is
end entity;

architecture tb of ads128x_spi_with_mux_tb is
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal start      : std_logic := '0';
    signal miso       : std_logic := '0';
    signal mosi       : std_logic;
    signal sclk       : std_logic;
    signal cs         : std_logic;
    signal mux_select : std_logic_vector(3 downto 0);
    signal data_out   : std_logic_vector(23 downto 0);
    signal data_in    : std_logic_vector(23 downto 0) := x"123456";
    signal done       : std_logic;

    -- Instantiate the SPI Controller
    uut: entity work.ads128x_spi_with_mux
        port map (
            clk       => clk,
            reset     => reset,
            start     => start,
            miso      => miso,
            mosi      => mosi,
            sclk      => sclk,
            cs        => cs,
            mux_select => mux_select,
            data_out  => data_out,
            data_in   => data_in,
            done      => done
        );

begin
    -- Clock generation
    clk_process: process
    begin
        clk <= not clk;
        wait for 10 ns;
    end process;

    -- Test stimulus
    stimulus: process
    begin
        -- Reset the system
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Start SPI communication
        start <= '1';
        wait for 500 ns; -- Wait for communication to complete
        start <= '0';

        wait; -- End simulation
    end process;

end architecture;
