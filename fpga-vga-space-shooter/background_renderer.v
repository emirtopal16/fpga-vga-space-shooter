module background_renderer(input [9:0]  x,
                           input [9:0]  y,

                           output [7:0] R,
                           output [7:0] G,
                           output [7:0] B);

   reg [4:0]                            displacement;

   initial begin
      displacement = 5'd0;
   end

   wire                                 draw_star;
   assign draw_star = (x[4:0] == displacement) & (y[4:0] == displacement);

   wire                                 new_frame;
   assign new_frame = (x == 0) & (y == 0);

   assign R = (draw_star) ? (8'hFF) : (8'h00);
   assign G = (draw_star) ? (8'hFF) : (8'h00);
   assign B = (draw_star) ? (8'hFF) : (8'hFF);

   always @(posedge new_frame) begin
      displacement <= displacement + 1;
   end

endmodule // background_renderer
