module bullet_renderer(input [9:0]  x,
                       input [9:0]  y,

                       input [2:0]  count,

                       output [7:0] R,
                       output [7:0] G,
                       output [7:0] B,
                       output       A);

   localparam                       SCREEN_X = 640;
   localparam                       SCREEN_Y = 480;
   localparam                       X = 11;
   localparam                       Y = 32;

   localparam                       FRAME_Y = 446;
   localparam                       FRAME_Y_END = FRAME_Y + Y;

   wire                             draw_y;

   assign draw_y = (y >= FRAME_Y) & (y < FRAME_Y_END);

   wire [4:0]                       bullets;

   assign bullets = (count <= 1) ? (5'b10000) :
                    (count <= 3) ? (5'b11100) : (5'b11111);

   wire [7:0]                       R_bullet [4:0];
   wire [7:0]                       G_bullet [4:0];
   wire [7:0]                       B_bullet [4:0];
   wire                             A_bullet [4:0];

   wire                             draw_bullet [4:0];

   wire [9:0]                       frame_x [4:0];
   wire [9:0]                       frame_x_end [4:0];

   wire [9:0]                       x_img [4:0];
   wire [9:0]                       y_img [4:0];

   genvar                           i;
   generate
      for (i = 0; i < 5; i = i + 1) begin: bullet_gen
         assign frame_x[i] = 2 + (X + 1) * i;
         assign frame_x_end[i] = frame_x[i] + X;

         assign draw_bullet[i] = draw_y & bullets[i] &
                                 (x >= frame_x[i]) & (x < frame_x_end[i]);

         assign x_img[i] = x - frame_x[i];
         assign y_img[i] = y - FRAME_Y;

         bullet_img(.x(x_img[i]),
                    .y(y_img[i]),

                    .R(R_bullet[i]),
                    .G(G_bullet[i]),
                    .B(B_bullet[i]),
                    .A(A_bullet[i]));
      end
   endgenerate

   assign { R, G, B, A } = (draw_bullet[0]) ? ({ R_bullet[0], G_bullet[0], B_bullet[0], A_bullet[0] }) :
                           (draw_bullet[1]) ? ({ R_bullet[1], G_bullet[1], B_bullet[1], A_bullet[1] }) :
                           (draw_bullet[2]) ? ({ R_bullet[2], G_bullet[2], B_bullet[2], A_bullet[2] }) :
                           (draw_bullet[3]) ? ({ R_bullet[3], G_bullet[3], B_bullet[3], A_bullet[3] }) :
                           (draw_bullet[4]) ? ({ R_bullet[4], G_bullet[4], B_bullet[4], A_bullet[4] }) :
                           ({ 24'h000000, 1'b0 });

endmodule // bullet_renderer
