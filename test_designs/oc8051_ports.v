



`include "oc8051_timescale.v"


`include "oc8051_defines.v"


module oc8051_ports (clk, 
                    rst,
                    bit_in, 
		    data_in,
		    wr, 
		    wr_bit,
		    wr_addr, 

	`ifdef OC8051_PORT0
		    p0_out,
                    p0_in,
		    p0_data,
	`endif

	`ifdef OC8051_PORT1
		    p1_out,
		    p1_in,
		    p1_data,

	`endif

	`ifdef OC8051_PORT2
		    p2_out,
		    p2_in,
		    p2_data,
	`endif

	`ifdef OC8051_PORT3
		    p3_out,
		    p3_in,
		    p3_data,
	`endif

		    rmw);

input        clk,	//clock
             rst,	//reset
	     wr,	//write [oc8051_decoder.wr -r]
	     wr_bit,	//write bit addresable [oc8051_decoder.bit_addr -r]
	     bit_in,	//bit input [oc8051_alu.desCy]
	     rmw;	//read modify write feature [oc8051_decoder.rmw]
input [7:0]  wr_addr,	//write address [oc8051_ram_wr_sel.out]
             data_in; 	//data input (from alu destiantion 1) [oc8051_alu.des1]

`ifdef OC8051_PORT0
  input  [7:0] p0_in;
  output [7:0] p0_out,
               p0_data;
  reg    [7:0] p0_out;

  assign p0_data = rmw ? p0_out : p0_in;
`endif


`ifdef OC8051_PORT1
  input  [7:0] p1_in;
  output [7:0] p1_out,
               p1_data;
  reg    [7:0] p1_out;

  assign p1_data = rmw ? p1_out : p1_in;
`endif


`ifdef OC8051_PORT2
  input  [7:0] p2_in;
  output [7:0] p2_out,
	       p2_data;
  reg    [7:0] p2_out;

  assign p2_data = rmw ? p2_out : p2_in;
`endif


`ifdef OC8051_PORT3
  input  [7:0] p3_in;
  output [7:0] p3_out,
	       p3_data;
  reg    [7:0] p3_out;

  assign p3_data = rmw ? p3_out : p3_in;
`endif

//
// case of writing to port
always @(posedge clk or posedge rst)
begin
  if (rst) begin
`ifdef OC8051_PORT0
    p0_out <= #1 `OC8051_RST_P0;
`endif

`ifdef OC8051_PORT1
    p1_out <= #1 `OC8051_RST_P1;
`endif

`ifdef OC8051_PORT2
    p2_out <= #1 `OC8051_RST_P2;
`endif

`ifdef OC8051_PORT3
    p3_out <= #1 `OC8051_RST_P3;
`endif
  end else if (wr) begin
    if (!wr_bit) begin
      case (wr_addr) /* synopsys full_case parallel_case */
//
// bytaddresable
`ifdef OC8051_PORT0
        `OC8051_SFR_P0: p0_out <= #1 data_in;
`endif

`ifdef OC8051_PORT1
        `OC8051_SFR_P1: p1_out <= #1 data_in;
`endif

`ifdef OC8051_PORT2
        `OC8051_SFR_P2: p2_out <= #1 data_in;
`endif

`ifdef OC8051_PORT3
        `OC8051_SFR_P3: p3_out <= #1 data_in;
`endif
      endcase
    end else begin
      case (wr_addr[7:3]) /* synopsys full_case parallel_case */

//
// bit addressable
`ifdef OC8051_PORT0
        `OC8051_SFR_B_P0: p0_out[wr_addr[2:0]] <= #1 bit_in;
`endif

`ifdef OC8051_PORT1
        `OC8051_SFR_B_P1: p1_out[wr_addr[2:0]] <= #1 bit_in;
`endif

`ifdef OC8051_PORT2
        `OC8051_SFR_B_P2: p2_out[wr_addr[2:0]] <= #1 bit_in;
`endif

`ifdef OC8051_PORT3
        `OC8051_SFR_B_P3: p3_out[wr_addr[2:0]] <= #1 bit_in;
`endif
      endcase
    end
  end
end


endmodule

