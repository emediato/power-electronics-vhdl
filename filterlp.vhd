library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lowpassfir is
    port (
        clk         : in  std_logic;               -- Clock signal
        reset       : in  std_logic;               -- Reset signal
        datavalid   : in  std_logic;               -- Data valid signal
        datain      : in  std_logic_vector(7 downto 0); -- Input sample X[0]
        coeffA      : in  std_logic_vector(7 downto 0); -- Coefficient A
        coeffB      : in  std_logic_vector(7 downto 0); -- Coefficient B
        coeffC      : in  std_logic_vector(7 downto 0); -- Coefficient C
        filtout     : out std_logic_vector(7 downto 0); -- Filtered output
        done        : out std_logic                -- Done signal
    );
end entity;

architecture behavioral of lowpassfir is
    -- Define internal signals
    signal X0, X1, X2       : std_logic_vector(7 downto 0); -- Shifted samples
    signal multdat, multcoeff : std_logic_vector(7 downto 0); -- Multiplier inputs
    signal multstart        : std_logic;                    -- Start multiplier
    signal multdone         : std_logic;                    -- Multiplier done
    signal multdonedelay    : std_logic;                    -- Delayed multdone
    signal multout          : std_logic_vector(7 downto 0); -- Multiplier output
    signal accum            : std_logic_vector(7 downto 0); -- Accumulator
    signal accumsum         : std_logic_vector(7 downto 0); -- Accumulated sum
    signal state            : integer range 0 to 3 := 0;    -- State machine state
    signal clearaccum       : std_logic;                    -- Accumulator clear
begin

    -- Instantiate the multiplier module (8x8 bit multiplier)
    mult_inst: entity work.mult8x8
        port map (
            clk      => clk,
            dat1     => multdat,
            dat2     => multcoeff,
            start    => multstart,
            done     => multdone,
            multout  => multout
        );

    -- Main process for state machine and filtering logic
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all signals
            X0 <= (others => '0');
            X1 <= (others => '0');
            X2 <= (others => '0');
            accum <= (others => '0');
            state <= 0;
            filtout <= (others => '0');
            done <= '0';
            clearaccum <= '0';
            multstart <= '0';
            multdonedelay <= '0';
        elsif rising_edge(clk) then
            -- Delay the multiplier done signal
            multdonedelay <= multdone;

            -- Accumulate the product into the accumulator
            if clearaccum = '1' then
                accum <= (others => '0');
            elsif multdonedelay = '1' then
                accumsum <= std_logic_vector(unsigned(accum) + unsigned(multout));
                accum <= accumsum;
            end if;

            -- State machine for FIR filter operation
            case state is
                when 0 =>
                    -- Idle state
                    if datavalid = '1' then
                        -- Shift samples
                        X2 <= X1;
                        X1 <= X0;
                        X0 <= datain;

                        -- Start multiplier with A * X[0]
                        multdat <= datain;
                        multcoeff <= coeffA;
                        multstart <= '1';
                        clearaccum <= '1'; -- Clear accumulator
                        state <= 1;
                    else
                        multstart <= '0';
                        done <= '0';
                    end if;

                when 1 =>
                    -- Multiply A * X[0]
                    if multdonedelay = '1' then
                        -- Load B * X[1]
                        multdat <= X1;
                        multcoeff <= coeffB;
                        multstart <= '1';
                        state <= 2;
                    else
                        multstart <= '0';
                    end if;

                when 2 =>
                    -- Multiply B * X[1]
                    if multdonedelay = '1' then
                        -- Load C * X[2]
                        multdat <= X2;
                        multcoeff <= coeffC;
                        multstart <= '1';
                        state <= 3;
                    else
                        multstart <= '0';
                    end if;

                when 3 =>
                    -- Multiply C * X[2]
                    if multdonedelay = '1' then
                        -- Output the result
                        filtout <= accum;
                        done <= '1';
                        state <= 0;
                    else
                        multstart <= '0';
                    end if;

                when others =>
                    state <= 0;
            end case;
        end if;
    end process;
end architecture;
