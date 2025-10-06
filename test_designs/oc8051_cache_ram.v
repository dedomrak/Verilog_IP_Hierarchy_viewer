

`include "oc8051_timescale.v"


module oc8051_cache_ram (clk, rst, addr0, data0, addr1, data1_i, data1_o, wr1);
//
// this module is part of oc8051_icache
// it's tehnology dependent
//
// clk          (in)  clock
// addr0        (in)  addres port 0
// data0        (out) data output port 0
// addr1        (in)  address port 1
// data1_i      (in)  data input port 1
// data1_o      (out) data output port 1
// wr1          (in)  write port 1
//

parameter ADR_WIDTH = 7; // cache address wihth
parameter CACHE_RAM = 128; // cache ram x 32 (2^ADR_WIDTH)

input clk, wr1, rst;
input [ADR_WIDTH-1:0] addr0, addr1;
input [31:0] data1_i;
output [31:0] data0, data1_o;

`ifdef OC8051_XILINX_RAM

  RAMB4_S8_S8 ram1(.DOA(data0[7:0]), .DOB(data1_o[7:0]), .ADDRA({2'b0, addr0}), .DIA(8'h00), .ENA(1'b1), .CLKA(clk), .WEA(1'b0),
                .RSTA(rst), .ADDRB({2'b0, addr1}), .DIB(data1_i[7:0]), .ENB(1'b1), .CLKB(clk), .WEB(wr1), .RSTB(rst));

  RAMB4_S8_S8 ram2(.DOA(data0[15:8]), .DOB(data1_o[15:8]), .ADDRA({2'b0, addr0}), .DIA(8'h00), .ENA(1'b1), .CLKA(clk), .WEA(1'b0),
                .RSTA(rst), .ADDRB({2'b0, addr1}), .DIB(data1_i[15:8]), .ENB(1'b1), .CLKB(clk), .WEB(wr1), .RSTB(rst));

  RAMB4_S8_S8 ram3(.DOA(data0[23:16]), .DOB(data1_o[23:16]), .ADDRA({2'b0, addr0}), .DIA(8'h00), .ENA(1'b1), .CLKA(clk), .WEA(1'b0),
                .RSTA(rst), .ADDRB({2'b0, addr1}), .DIB(data1_i[23:16]), .ENB(1'b1), .CLKB(clk), .WEB(wr1), .RSTB(rst));

  RAMB4_S8_S8 ram4(.DOA(data0[31:24]), .DOB(data1_o[31:24]), .ADDRA({2'b0, addr0}), .DIA(8'h00), .ENA(1'b1), .CLKA(clk), .WEA(1'b0),
                .RSTA(rst), .ADDRB({2'b0, addr1}), .DIB(data1_i[31:24]), .ENB(1'b1), .CLKB(clk), .WEB(wr1), .RSTB(rst));

`else

reg [31:0] data0, data1_o;

//
// buffer
reg [31:0] buff [0:CACHE_RAM];

//
// port 1
//
always @(posedge clk or posedge rst)
begin
  if (rst)
    data1_o <= #1 32'h0;
  else if (wr1) begin
    buff[addr1] <= #1 data1_i;
    data1_o <= #1 data1_i;
  end else
    data1_o <= #1 buff[addr1];
end

//
// port 0
//
always @(posedge clk or posedge rst)
begin
  if (rst)
    data0 <= #1 32'h0;
  else if ((addr0==addr1) & wr1)
    data0 <= #1 data1_i;
  else
    data0 <= #1 buff[addr0];
end

`endif


endmodule
