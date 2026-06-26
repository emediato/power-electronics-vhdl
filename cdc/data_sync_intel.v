/* set_max_delay
<delay>
-from ...|data_in
-to ...|data_out

set_max_delay
<delay>
-from ...|enable
-to ...|en_meta_ff
 */


module data_sync_intel (input clk, enable, input [3:0] data_in,
                        output reg [3:0] data_out);

(* preserve altera_attribute = "-name SYNCHRONIZER_IDENTIFICATION \"FORCED IF ASYNCHRONOUS\"" *)
reg en_meta_ff;
(* preserve *) reg en_sync_ff;

always @(posedge clk) begin
    en_meta_ff <= enable;
    en_sync_ff <= en_meta_ff;
end

(* direct_enable = 1 *) wire data_enable;
assign data_enable = en_sync_ff;

always @(posedge clk)
    if (data_enable)
        data_out <= data_in;

endmodule
