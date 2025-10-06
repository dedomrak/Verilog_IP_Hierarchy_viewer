


`include "oc8051_timescale.v"


`include "oc8051_defines.v"


module oc8051_b_register (clk, rst, bit_in, data_in, wr, wr_bit,
              wr_addr, data_out);


input clk, rst, wr, wr_bit, bit_in;
input [7:0] wr_addr, data_in;

output [7:0] data_out;

reg [7:0] data_out;

//
//writing to b
//must check if write high and correct address
always @(posedge clk or posedge rst)
begin
  if (rst)
    data_out <= #1 `OC8051_RST_B;
  else if (wr) begin
    if (!wr_bit) begin
      if (wr_addr==`OC8051_SFR_B)
        data_out <= #1 data_in;
    end else begin
      if (wr_addr[7:3]==`OC8051_SFR_B_B)
        data_out[wr_addr[2:0]] <= #1 bit_in;
    end
  end
end

endmodule
