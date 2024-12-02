library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_one_layer_nn is
end tb_one_layer_nn;

architecture sim of tb_one_layer_nn is

    -- Constants
    constant N : integer := 6;  -- Bits per weight
    constant neurons : integer := 3;
    constant weights : integer := 5;

    -- Inputs to the ANN
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal x : signed(N-1 downto 0) := (others => '0');  -- Input vector
    signal weights_matrix : signed(N-1 downto 0) := (others => '0');

    -- Outputs from the ANN
    signal y : array(1 to neurons) of signed(N-1 downto 0);

    -- Clock generation
    constant clk_period : time := 20 ns;

begin

    -- Instantiate the ANN
    uut: entity work.one_layer_nn
        generic map (
            N => N,
            neurons => neurons,
            weights => weights
        )
        port map (
            clk => clk,
            rst => rst,
            x => x,
            y => y
        );

    -- Clock generation process
    clk_gen: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Test process
    stim_proc: process
    begin
        -- Reset the system
        rst <= '1';
        wait for 2 * clk_period;
        rst <= '0';

        -- Apply test inputs
        x <= to_signed(12, N);  -- Example input
        weights_matrix <= (
            to_signed(2, N), to_signed(4, N), to_signed(5, N), to_signed(-3, N), to_signed(6, N),
            to_signed(1, N), to_signed(3, N), to_signed(2, N), to_signed(-4, N), to_signed(7, N),
            to_signed(-1, N), to_signed(-2, N), to_signed(3, N), to_signed(2, N), to_signed(-5, N)
        );

        -- Wait for computation
        wait for 10 * clk_period;

        -- Add additional test cases as needed
        wait;

    end process;
end sim;
