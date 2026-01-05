module vga_controller(input clk,

                      output           VGA_BLANK_N,
                      output [7:0]     VGA_B,
                      output reg       VGA_CLK,
                      output [7:0]     VGA_G,
                      output           VGA_HS,
                      output [7:0]     VGA_R,
                      output           VGA_SYNC_N,
                      output           VGA_VS,

                      output reg [9:0] x,
                      output reg [9:0] y,

                      output           new_frame,

                      input [7:0]      R,
                      input [7:0]      G,
                      input [7:0]      B);

   // 25 MHz clock
   always @(posedge clk) VGA_CLK <= ~VGA_CLK;

   localparam                       H_ACTIVE  = 640;
   localparam                       H_FP      = 16;
   localparam                       H_SYNC    = 96;
   localparam                       H_BP      = 48;
   localparam                       H_TOTAL   = H_ACTIVE + H_FP + H_SYNC + H_BP;

   localparam                       V_ACTIVE  = 480;
   localparam                       V_FP      = 10;
   localparam                       V_SYNC    = 2;
   localparam                       V_BP      = 33;
   localparam                       V_TOTAL   = V_ACTIVE + V_FP + V_SYNC + V_BP;

   // horizontal and vertical counter up
   always @(posedge VGA_CLK) begin
      if (x < H_TOTAL)
        x <= x + 1;
      else begin
         x <= 0;
         if (y < V_TOTAL)
           y <= y + 1;
         else
           y <= 0;
      end
   end

   // sync signals
   assign VGA_HS = (x >= H_ACTIVE + H_FP) & (x < H_ACTIVE + H_FP + H_SYNC);
   assign VGA_VS = (y >= V_ACTIVE + V_FP) & (y < V_ACTIVE + V_FP + V_SYNC);

   assign VGA_BLANK_N = (x < H_ACTIVE) & (y < V_ACTIVE);
   assign VGA_SYNC_N = ~(VGA_HS | VGA_VS);

   assign VGA_R = (VGA_BLANK_N) ? (R) : (8'h00);
   assign VGA_G = (VGA_BLANK_N) ? (G) : (8'h00);
   assign VGA_B = (VGA_BLANK_N) ? (B) : (8'h00);

   assign new_frame = (x == H_ACTIVE + H_FP) & (y == V_ACTIVE + V_FP);

endmodule // vga_controller
