


`include "oc8051_timescale.v"


`include "oc8051_defines.v"

//
// duble port ram
//
module oc8051_ram_64x32_dual_bist (
                     clk,
                     rst,
                     
		     adr0,
		     dat0_o,
		     en0,
		     
		     adr1,
		     dat1_i,
		     dat1_o,
		     en1,
		     wr1
`ifdef OC8051_BIST
	 ,
         scanb_rst,
         scanb_clk,
         scanb_si,
         scanb_so,
         scanb_en
`endif
		     );

parameter ADR_WIDTH = 6;

input         clk, 
              wr1, 
	      rst,
	      en0,
	      en1;
input  [7:0]  dat1_i;
input  [ADR_WIDTH-1:0]  adr0,
                        adr1;
output [7:0]  dat0_o,
              dat1_o;

reg    [7:0]  rd_data;


`ifdef OC8051_BIST
input   scanb_rst;
input   scanb_clk;
input   scanb_si;
output  scanb_so;
input   scanb_en;
`endif


`ifdef OC8051_RAM_XILINX
  xilinx_ram_dp xilinx_ram(
  	// read port
  	.CLKA(clk),
  	.RSTA(rst),
  	.ENA(en0),
  	.ADDRA(adr0),
  	.DIA(32'h00),
  	.WEA(1'b0),
  	.DOA(dat0_o),
  
  	// write port
  	.CLKB(clk),
  	.RSTB(rst),
  	.ENB(en1),
  	.ADDRB(adr1),
  	.DIB(dat1_i),
  	.WEB(wr1),
  	.DOB(dat1_o)
  );
  
  defparam
  	xilinx_ram.dwidth = 32,
  	xilinx_ram.awidth = ADR_WIDTH;

`else

  `ifdef OC8051_RAM_VIRTUALSILICON

  `else

    `ifdef OC8051_RAM_GENERIC
    
      generic_dpram #(ADR_WIDTH, 32) oc8051_ram1(
      	.rclk  ( clk            ),
      	.rrst  ( rst            ),
      	.rce   ( en0            ),
      	.oe    ( 1'b1           ),
      	.raddr ( adr0           ),
      	.do    ( dat0_o         ),
      
      	.wclk  ( clk            ),
      	.wrst  ( rst            ),
      	.wce   ( en1            ),
      	.we    ( wr1            ),
      	.waddr ( adr1           ),
      	.di    ( dat1_i         )
      );
    
    `else

      reg [31:0] dat1_o, 
                 dat0_o;  
      //
      // buffer
      reg    [31:0]  buff [0:(1<<ADR_WIDTH) -1];

      always @(posedge clk or posedge rst)
      begin
        if (rst)
          dat1_o     <= #1 32'h0;
        else if (wr1) begin
          buff[adr1] <= #1 dat1_i;
          dat1_o    <= #1 dat1_i;
        end else
          dat1_o <= #1 buff[adr1];
      end
      
      always @(posedge clk or posedge rst)
      begin
        if (rst)
          dat0_o <= #1 32'h0;
        else if ((adr0==adr1) & wr1)
          dat0_o <= #1 dat1_i;
        else
          dat0_o <= #1 buff[adr0];
      end
            
    `endif  //OC8051_RAM_GENERIC
  `endif    //OC8051_RAM_VIRTUALSILICON  
`endif      //OC8051_RAM_XILINX

endmodule
