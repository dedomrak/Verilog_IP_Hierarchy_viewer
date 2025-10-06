
module mmc_boot_prescaler_16_1(
  rst,
  sys_clk,
  mmc_clk,
  mode_transfer
  );

input rst;
input sys_clk;
output mmc_clk;
input mode_transfer;

reg [3:0] prescaler;

always @(posedge sys_clk)
  if (rst)
    prescaler <= 4'b0000;
  else
    prescaler <= prescaler + 4'b0001;


assign mmc_clk = mode_transfer ?  sys_clk : prescaler[3]; 


endmodule
