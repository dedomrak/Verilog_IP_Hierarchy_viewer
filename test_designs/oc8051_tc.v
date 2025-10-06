

`include "oc8051_defines.v"

//synopsys translate_off
`include "oc8051_timescale.v"
//synopsys translate_on



module oc8051_tc (clk, rst, 
            data_in,
            wr_addr,
	    wr, wr_bit,
	    ie0, ie1,
	    tr0, tr1,
	    t0, t1,
            tf0, tf1,
	    pres_ow,
//registers
	    tmod, tl0, th0, tl1, th1);

input [7:0]  wr_addr,
             data_in;
input        clk,
             rst,
	     wr,
	     wr_bit,
	     ie0,
	     ie1,
	     tr0,
	     tr1,
	     t0,
	     t1,
	     pres_ow;
output [7:0] tmod,
             tl0,
	     th0,
	     tl1,
	     th1;
output       tf0,
             tf1;


reg [7:0] tmod, tl0, th0, tl1, th1;
reg tf0, tf1_0, tf1_1, t0_buff, t1_buff;

wire tc0_add, tc1_add;

assign tc0_add = (tr0 & (!tmod[3] | !ie0) & ((!tmod[2] & pres_ow) | (tmod[2] & !t0 & t0_buff)));
assign tc1_add = (tr1 & (!tmod[7] | !ie1) & ((!tmod[6] & pres_ow) | (tmod[6] & !t1 & t1_buff)));
assign tf1= tf1_0 | tf1_1;

//
// read or write from one of the addresses in tmod
//
always @(posedge clk or posedge rst)
begin
 if (rst) begin
   tmod <=#1 `OC8051_RST_TMOD;
 end else if ((wr) & !(wr_bit) & (wr_addr==`OC8051_SFR_TMOD))
    tmod <= #1 data_in;
end

//
// TIMER COUNTER 0
//
always @(posedge clk or posedge rst)
begin
 if (rst) begin
   tl0 <=#1 `OC8051_RST_TL0;
   th0 <=#1 `OC8051_RST_TH0;
   tf0 <= #1 1'b0;
   tf1_0 <= #1 1'b0;
 end else if ((wr) & !(wr_bit) & (wr_addr==`OC8051_SFR_TL0)) begin
   tl0 <= #1 data_in;
   tf0 <= #1 1'b0;
   tf1_0 <= #1 1'b0;
 end else if ((wr) & !(wr_bit) & (wr_addr==`OC8051_SFR_TH0)) begin
   th0 <= #1 data_in;
   tf0 <= #1 1'b0;
   tf1_0 <= #1 1'b0;
 end else begin
     case (tmod[1:0]) /* synopsys full_case parallel_case */
      `OC8051_MODE0: begin                       // mode 0
        tf1_0 <= #1 1'b0;
        if (tc0_add)
          {tf0, th0,tl0[4:0]} <= #1 {1'b0, th0, tl0[4:0]}+ 1'b1;
      end
      `OC8051_MODE1: begin                       // mode 1
        tf1_0 <= #1 1'b0;
        if (tc0_add)
          {tf0, th0,tl0} <= #1 {1'b0, th0, tl0}+ 1'b1;
      end

      `OC8051_MODE2: begin                       // mode 2
        tf1_0 <= #1 1'b0;
        if (tc0_add) begin
	  if (tl0 == 8'b1111_1111) begin
            tf0 <=#1 1'b1;
            tl0 <=#1 th0;
           end
          else begin
            tl0 <=#1 tl0 + 8'h1;
            tf0 <= #1 1'b0;
          end
	end
      end
      `OC8051_MODE3: begin                       // mode 3

	 if (tc0_add)
	   {tf0, tl0} <= #1 {1'b0, tl0} +1'b1;

         if (tr1 & pres_ow)
	   {tf1_0, th0} <= #1 {1'b0, th0} +1'b1;

      end
/*      default:begin
        tf0 <= #1 1'b0;
        tf1_0 <= #1 1'b0;
      end*/
    endcase
 end
end

//
// TIMER COUNTER 1
//
always @(posedge clk or posedge rst)
begin
 if (rst) begin
   tl1 <=#1 `OC8051_RST_TL1;
   th1 <=#1 `OC8051_RST_TH1;
   tf1_1 <= #1 1'b0;
 end else if ((wr) & !(wr_bit) & (wr_addr==`OC8051_SFR_TL1)) begin
   tl1 <= #1 data_in;
   tf1_1 <= #1 1'b0;
 end else if ((wr) & !(wr_bit) & (wr_addr==`OC8051_SFR_TH1)) begin
   th1 <= #1 data_in;
   tf1_1 <= #1 1'b0;
 end else begin
     case (tmod[5:4]) /* synopsys full_case parallel_case */
      `OC8051_MODE0: begin                       // mode 0
        if (tc1_add)
          {tf1_1, th1,tl1[4:0]} <= #1 {1'b0, th1, tl1[4:0]}+ 1'b1;
      end
      `OC8051_MODE1: begin                       // mode 1
        if (tc1_add)
          {tf1_1, th1,tl1} <= #1 {1'b0, th1, tl1}+ 1'b1;
      end

      `OC8051_MODE2: begin                       // mode 2
        if (tc1_add) begin
	  if (tl1 == 8'b1111_1111) begin
            tf1_1 <=#1 1'b1;
            tl1 <=#1 th1;
           end
          else begin
            tl1 <=#1 tl1 + 8'h1;
            tf1_1 <= #1 1'b0;
          end
	end
      end
/*      default:begin
        tf1_1 <= #1 1'b0;
      end*/
    endcase
 end
end


always @(posedge clk or posedge rst)
  if (rst) begin
    t0_buff <= #1 1'b0;
    t1_buff <= #1 1'b0;
  end else begin
    t0_buff <= #1 t0;
    t1_buff <= #1 t1;
  end
endmodule
