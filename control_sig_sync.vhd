-- Synchronizing control signals

attribute ASYNC_REG : string;
signal async_toggle : std_logic := '0';
signal sync         : std_logic_vector(2 downto 0);
attribute ASYNC_REG of sync : signal is "TRUE";
signal sync_pulse   : std_logic;

process(src_clk)
begin
if rising_edge(src_clk) then
    if ctrl_in then
      async_toggle <= not async_toggle;
    end if;
  end if;
end process;
process(dst_clk)
begin
  if rising_edge(dst_clk) then
    sync <= sync(1 downto 0) & async_toggle;
  end if;
end process;
sync_pulse <= xor sync(2 downto 1);
