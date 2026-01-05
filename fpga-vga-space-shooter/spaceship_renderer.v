module spaceship_renderer(input [9:0]  x,
                          input [9:0]  y,

                          input [3:0]  angle,

                          output [7:0] R,
                          output [7:0] G,
                          output [7:0] B,
                          output       A);

   localparam                          X = 32;
   localparam                          Y = 32;

   localparam                          FRAME_X = 320;
   localparam                          FRAME_Y = 240;

   localparam                          FRAME_X_END = FRAME_X + X;
   localparam                          FRAME_Y_END = FRAME_Y + Y;

   wire [9:0]                          img_x;
   wire [9:0]                          img_y;

   assign img_x = x - FRAME_X;
   assign img_y = y - FRAME_Y;

   wire                                within_frame;
   assign within_frame = (x >= FRAME_X) && (x < FRAME_X_END) &&
                         (y >= FRAME_Y) && (y < FRAME_Y_END);

   wire [7:0]                      R_img;
   wire [7:0]                      G_img;
   wire [7:0]                      B_img;
   wire                            A_img;

   spaceship_img img(.x(img_x),
                     .y(img_y),

                     .angle(angle),

                     .R(R_img),
                     .G(G_img),
                     .B(B_img),
                     .A(A_img));

   assign R = R_img;
   assign G = G_img;
   assign B = B_img;
   assign A = A_img & within_frame;

endmodule // spaceship_renderer
