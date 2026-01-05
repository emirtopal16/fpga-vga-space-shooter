module health_bar_renderer(input [9:0]  x,
                           input [9:0]  y,

                           input [3:0]  health,
                           input        hit,

                           output [7:0] R,
                           output [7:0] G,
                           output [7:0] B,
                           output       A);

   wire                                 draw;
   assign draw = (x < health * 2);

   assign R = (draw & hit) ? (8'hFF) : (8'h00);
   assign G = (draw & ~hit) ? (8'hFF) : (8'h00);
   assign B = 8'h00;

   assign A = (y >= 1) & (y <= 3);

endmodule // health_bar_renderer
