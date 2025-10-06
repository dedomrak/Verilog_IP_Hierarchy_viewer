


`include "oc8051_timescale.v"



module oc8051_wb_iinterface(rst, clk, 
                  adr_i, dat_o, cyc_i, stb_i, ack_o,
		  adr_o, dat_i, cyc_o, stb_o, ack_i
		  );
//
// rst           (in)  reset - pin
// clk           (in)  clock - pini
input rst, clk;

//
// interface to oc8051 cpu
//
// adr_i    (in)  address
// dat_o    (out) data output
// stb_i    (in)  strobe
// ack_o    (out) acknowledge
// cyc_i    (in)  cycle
input         stb_i,
              cyc_i;
input  [15:0] adr_i;
output        ack_o;
output [31:0] dat_o;

//
// interface to instruction rom
//
// adr_o    (out) address
// dat_i    (in)  data input
// stb_o    (out) strobe
// ack_i    (in) acknowledge
// cyc_o    (out)  cycle
input         ack_i;
input  [31:0] dat_i;
output        stb_o,
              cyc_o;
output [15:0] adr_o;

//
// internal bufers and wires
//
reg [15:0] adr_o;
reg        stb_o;

assign ack_o = ack_i;
assign dat_o = dat_i;
//assign stb_o = stb_i || ack_i;
assign cyc_o = stb_o;
//assign adr_o = ack_i ? adr : adr_i;

always @(posedge clk or posedge rst)
  if (rst) begin
    stb_o <= #1 1'b0;
    adr_o <= #1 16'h0000;
  end else if (ack_i) begin
    stb_o <= #1 stb_i;
    adr_o <= #1 adr_i;
  end else if (!stb_o & stb_i) begin
    stb_o <= #1 1'b1;
    adr_o <= #1 adr_i;
  end

endmodule
