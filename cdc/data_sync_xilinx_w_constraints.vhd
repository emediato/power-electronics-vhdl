-- set_max_delay
-- -datapath_only
-- <delay>
-- -from .../data_in
-- -to .../data_out
-- 
-- set_max_delay
-- -datapath_only
-- <delay>
-- -from .../enable
-- -to .../en_meta_ff


module data_sync_xilinx (input clk, enable, input [3:0] data_in,
                         output reg [3:0] data_out);

(* ASYNC_REG = "TRUE" *) reg en_meta_ff;
(* ASYNC_REG = "TRUE" *) reg en_sync_ff;

always @(posedge clk) begin
    en_meta_ff <= enable;
    en_sync_ff <= en_meta_ff;
end

(* direct_enable = "yes" *) wire data_enable;
assign data_enable = en_sync_ff;

always @(posedge clk)
    if (data_enable)
        data_out <= data_in;

endmodule
