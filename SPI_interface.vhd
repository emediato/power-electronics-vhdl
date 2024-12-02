

-- SPI write command
reg_addr    <= x"0A" & "00" & reg_awaddr;
wr_data     <= reg_addr & reg_din;

-- SPI read command
reg_addr    <= x"0B" & "00" & reg_awaddr;
wr_data     <= reg_addr & x"00";

-- for the SPI read command, we need to capture the data on the correct data cycles.
if (bit_cnt > 15) and (clk_cnt = 1) then
    reg_rdata <= reg_rdata(6 downto 0) & MISO;
  end if;
  

  --  The majority of the SPI code resides in the CPU interface state machine. It serializes the data out and captures at the appropriate point.