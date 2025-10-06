
`include "oc8051_timescale.v"


module oc8051_ram (clk, rst, rd_addr, rd_data, wr_addr, wr_data, wr);
// clk          clock
// rd_addr      read addres
// rd_data      read data
// wr_addr      write addres
// wr_data      write data
// wr           write


input clk, wr, rst;
input [7:0] rd_addr, wr_addr, wr_data;
output [7:0] rd_data;

wire [7:0] dob;
RAMB4_S8_S8 ram1(.DOA(rd_data), .DOB(dob), .ADDRA({1'b0, rd_addr}), .DIA(8'h00), .ENA(1'b1), .CLKA(clk), .WEA(1'b0),
                .RSTA(rst), .ADDRB({1'b0, wr_addr}), .DIB(wr_data), .ENB(1'b1), .CLKB(clk), .WEB(wr), .RSTB(rst));


endmodule



module RAMB4_S8_S8(DOA, DOB, ADDRA, DIA, ENA, CLKA, WEA, RSTA, ADDRB, DIB, ENB, CLKB, WEB, RSTB); // synthesis syn_black_box
output [7:0] DOA;
output [7:0] DOB;
input [8:0] ADDRA;
input [7:0] DIA;
input ENA;
input CLKA;
input WEA;
input RSTA;
input [8:0] ADDRB;
input [7:0] DIB;
input ENB;
input CLKB;
input WEB;
input RSTB;
endmodule
