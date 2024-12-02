library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ads128x_spi_controller is
    port (
        clk         : in std_logic;                -- System clock
        reset       : in std_logic;                -- Reset signal
        start       : in std_logic;                -- Start SPI communication
        miso        : in std_logic;                -- Master In Slave Out
        mosi        : out std_logic;               -- Master Out Slave In
        sclk        : out std_logic;               -- SPI Clock
        cs          : out std_logic;               -- Chip Select
        data_out    : out std_logic_vector(23 downto 0); -- Data read from ADC
        data_in     : in std_logic_vector(23 downto 0);  -- Data to send to ADC
        done        : out std_logic                -- Communication complete
    );
end entity;

architecture behavioral of ads128x_spi_controller is
    -- State encoding
    type state_type is (IDLE, ASSERT_CS, SEND, RECEIVE, DEASSERT_CS, COMPLETE);
    signal state       : state_type := IDLE;
    signal bit_counter : integer range 0 to 23 := 0;
    signal shift_reg   : std_logic_vector(23 downto 0) := (others => '0');
    signal mosi_reg    : std_logic := '0';
    signal sclk_reg    : std_logic := '0';

begin
    -- Assign output signals
    mosi <= mosi_reg;
    sclk <= sclk_reg;
    cs <= '1' when state = IDLE else '0'; -- Active low CS
    done <= '1' when state = COMPLETE else '0';

    -- State Machine Process
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all signals
            state <= IDLE;
            bit_counter <= 0;
            shift_reg <= (others => '0');
            sclk_reg <= '0';
            mosi_reg <= '0';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        state <= ASSERT_CS;
                        shift_reg <= data_in; -- Load data to transmit
                    end if;

                when ASSERT_CS =>
                    state <= SEND; -- Prepare to send data
                    bit_counter <= 0;

                when SEND =>
                    -- Output MSB on MOSI
                    mosi_reg <= shift_reg(23);
                    shift_reg <= shift_reg(22 downto 0) & '0'; -- Shift left
                    sclk_reg <= '1'; -- Generate clock pulse
                    state <= RECEIVE;

                when RECEIVE =>
                    sclk_reg <= '0'; -- Lower clock to capture MISO
                    shift_reg(0) <= miso; -- Capture MISO into LSB
                    bit_counter <= bit_counter + 1;
                    if bit_counter = 23 then
                        state <= DEASSERT_CS;
                    else
                        state <= SEND;
                    end if;

                when DEASSERT_CS =>
                    data_out <= shift_reg; -- Save received data
                    state <= COMPLETE;

                when COMPLETE =>
                    if start = '0' then
                        state <= IDLE; -- Return to IDLE after transaction
                    end if;

                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end architecture;
