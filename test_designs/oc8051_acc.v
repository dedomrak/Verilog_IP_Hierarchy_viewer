

`include "oc8051_timescale.v"


`include "oc8051_defines.v"


module oc8051_acc (clk, rst, 
                 bit_in, data_in, data2_in, 
		 data_out,
		 wr, wr_bit, wr_addr,
		 p, wr_sfr);


input clk, rst, wr, wr_bit, bit_in;
input [1:0] wr_sfr;
input [7:0] wr_addr, data_in, data2_in;

output p;
output [7:0] data_out;

reg [7:0] data_out;
reg [7:0] acc;

wire wr_acc, wr2_acc, wr_bit_acc;
//
//calculates parity
assign p = ^acc;

assign wr_acc     = (wr_sfr==`OC8051_WRS_ACC1) | (wr & !wr_bit & (wr_addr==`OC8051_SFR_ACC));
assign wr2_acc    = (wr_sfr==`OC8051_WRS_ACC2);
assign wr_bit_acc = (wr & wr_bit & (wr_addr[7:3]==`OC8051_SFR_B_ACC));
//
//writing to acc
always @(wr_sfr or data2_in or wr2_acc or wr_acc or wr_bit_acc or wr_addr[2:0] or data_in or bit_in or data_out)
begin
  if (wr2_acc)
    acc = data2_in;
  else if (wr_acc)
    acc = data_in;
  else if (wr_bit_acc)
    case (wr_addr[2:0]) /* synopsys full_case parallel_case */
      3'b000: acc = {data_out[7:1], bit_in};
      3'b001: acc = {data_out[7:2], bit_in, data_out[0]};
      3'b010: acc = {data_out[7:3], bit_in, data_out[1:0]};
      3'b011: acc = {data_out[7:4], bit_in, data_out[2:0]};
      3'b100: acc = {data_out[7:5], bit_in, data_out[3:0]};
      3'b101: acc = {data_out[7:6], bit_in, data_out[4:0]};
      3'b110: acc = {data_out[7],   bit_in, data_out[5:0]};
      3'b111: acc = {bit_in, data_out[6:0]};
    endcase
  else
    acc = data_out;
end

always @(posedge clk or posedge rst)
begin
  if (rst)
    data_out <= #1 `OC8051_RST_ACC;
  else
    data_out <= #1 acc;
end


`ifdef OC8051_SIMULATION

always @(data_out)
  if (data_out===8'hxx) begin
    $display("time ",$time, "   faulire: invalid write to ACC (oc8051_acc)");
#22
    $finish;

  end


`endif


endmodule

