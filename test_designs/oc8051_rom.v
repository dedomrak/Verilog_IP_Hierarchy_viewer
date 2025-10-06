
`include "oc8051_defines.v"

module oc8051_rom (rst, clk, addr, ea_int, data_o);

//parameter INT_ROM_WID= 15;

input rst, clk;
input [15:0] addr;
//input [22:0] addr;
output ea_int;
output [31:0] data_o;

reg [31:0] data_o;
wire ea;

reg ea_int;


`ifdef OC8051_XILINX_ROM

parameter INT_ROM_WID= 12;

reg [4:0] addr01;


wire [15:0] addr_rst;
wire [7:0] int_data0, int_data1, int_data2, int_data3, int_data4, int_data5, int_data6, int_data7, int_data8, int_data9, int_data10, int_data11, int_data12, int_data13, int_data14, int_data15, int_data16, int_data17, int_data18, int_data19, int_data20, int_data21, int_data22, int_data23, int_data24, int_data25, int_data26, int_data27, int_data28, int_data29, int_data30, int_data31, int_data32, int_data33, int_data34, int_data35, int_data36, int_data37, int_data38, int_data39, int_data40, int_data41, int_data42, int_data43, int_data44, int_data45, int_data46, int_data47, int_data48, int_data49, int_data50, int_data51, int_data52, int_data53, int_data54, int_data55, int_data56, int_data57, int_data58, int_data59, int_data60, int_data61, int_data62, int_data63, int_data64, int_data65, int_data66, int_data67, int_data68, int_data69, int_data70, int_data71, int_data72, int_data73, int_data74, int_data75, int_data76, int_data77, int_data78, int_data79, int_data80, int_data81, int_data82, int_data83, int_data84, int_data85, int_data86, int_data87, int_data88, int_data89, int_data90, int_data91, int_data92, int_data93, int_data94, int_data95, int_data96, int_data97, int_data98, int_data99, int_data100, int_data101, int_data102, int_data103, int_data104, int_data105, int_data106, int_data107, int_data108, int_data109, int_data110, int_data111, int_data112, int_data113, int_data114, int_data115, int_data116, int_data117, int_data118, int_data119, int_data120, int_data121, int_data122, int_data123, int_data124, int_data125, int_data126, int_data127;

assign ea = | addr[15:INT_ROM_WID];

assign addr_rst = rst ? 16'h0000 : addr;

  rom0 rom_0 (.a(addr01), .o(int_data0));
  rom1 rom_1 (.a(addr01), .o(int_data1));
  rom2 rom_2 (.a(addr_rst[11:7]), .o(int_data2));
  rom3 rom_3 (.a(addr_rst[11:7]), .o(int_data3));
  rom4 rom_4 (.a(addr_rst[11:7]), .o(int_data4));
  rom5 rom_5 (.a(addr_rst[11:7]), .o(int_data5));
  rom6 rom_6 (.a(addr_rst[11:7]), .o(int_data6));
  rom7 rom_7 (.a(addr_rst[11:7]), .o(int_data7));
  rom8 rom_8 (.a(addr_rst[11:7]), .o(int_data8));
  
  


always @(addr_rst)
begin
  if (addr_rst[1])
    addr01= addr_rst[11:7]+ 5'h1;
  else
    addr01= addr_rst[11:7];
end

//
// always read tree bits in row

always @(posedge clk or posedge rst)
 if (rst)
   ea_int <= #1 1'b1;
  else ea_int <= #1 !ea;

`else


reg [7:0] buff [0:65535]; //64kb

assign ea = 1'b0;

initial
begin
  $readmemh("../../../bench/in/oc8051_rom.in", buff);
end

always @(posedge clk or posedge rst)
 if (rst)
   ea_int <= #1 1'b1;
  else ea_int <= #1 !ea;

always @(posedge clk)
begin
  data_o <= #1 {buff[addr+3], buff[addr+2], buff[addr+1], buff[addr]};
end


`endif


endmodule


`ifdef OC8051_XILINX_ROM

//rom0
module rom0 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=004760c0" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00475754" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=032c2000" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00300087" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0228b085" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01002085" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=015378ed" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=024bd0c4" */;
endmodule

//rom1
module rom1 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=022c68a6" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0008e892" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=032feb64" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0010a020" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=015b2028" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00bca44c" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02bc34c2" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=016700c3" */;
endmodule

//rom2
module rom2 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00701310" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01a79000" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00a40cee" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01371711" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02340c6b" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=022c00c4" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=022c50c4" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00000aaa" */;
endmodule

//rom3
module rom3 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00f46b58" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=027c0c49" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0280bb9b" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00088848" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00807bbd" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00c30bf9" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01b72fbd" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00343c40" */;
endmodule

//rom4
module rom4 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0340f400" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01036080" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=03677000" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0110b0c4" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00ecabfa" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0248ecaa" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0258ecea" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02a4c790" */;
endmodule

//rom5
module rom5 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02638826" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02cca816" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=03c36298" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02e40029" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02e3d7a0" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=03431409" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02d394c5" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0020c005" */;
endmodule

//rom6
module rom6 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=010070c0" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01885b92" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0318302c" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=004044c0" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=0223a46d" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=012c20a9" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=002cb029" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=03030084" */;
endmodule

//rom7
module rom7 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00289808" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=000d8429" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02bf1b1c" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00820339" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=033b6429" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=010b5069" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=034854e9" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00503421" */;
endmodule

//rom8
module rom8 (o,a);
input [4:0] a;
output [7:0] o;
ROM32X1 u0 (o[0],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=019c8ff3" */;
ROM32X1 u1 (o[1],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01438c62" */;
ROM32X1 u2 (o[2],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=002c6c4b" */;
ROM32X1 u3 (o[3],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=01904b92" */;
ROM32X1 u4 (o[4],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00bc93d5" */;
ROM32X1 u5 (o[5],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02acb31d" */;
ROM32X1 u6 (o[6],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=02bc1335" */;
ROM32X1 u7 (o[7],a[0],a[1],a[2],a[3],a[4]) /* synthesis xc_props="INIT=00c09b32" */;
endmodule


`endif
