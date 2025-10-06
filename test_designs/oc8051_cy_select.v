


`include "oc8051_timescale.v"


`include "oc8051_defines.v"


module oc8051_cy_select (cy_sel, cy_in, data_in, data_out);
//
// cy_sel       (in)  carry select, from decoder (see defines.v) [oc8051_decoder.cy_sel -r]
// cy_in        (in)  carry input [oc8051_psw.data_out[7] ]
// data_in      (in)  ram data input [oc8051_ram_sel.bit_out]
// data_out     (out) data output [oc8051_alu.srcCy]
//

input [1:0] cy_sel;
input cy_in, data_in;

output data_out;
reg data_out;

always @(cy_sel or cy_in or data_in)
begin
  case (cy_sel) /* synopsys full_case parallel_case */
    `OC8051_CY_0: data_out = 1'b0;
    `OC8051_CY_PSW: data_out = cy_in;
    `OC8051_CY_RAM: data_out = data_in;
    `OC8051_CY_1: data_out = 1'b1;
  endcase
end

endmodule
