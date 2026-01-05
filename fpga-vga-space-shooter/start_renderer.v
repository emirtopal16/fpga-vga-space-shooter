module start_renderer(input [9:0]  x,
                      input [9:0]  y,

                      output [7:0] R,
                      output [7:0] G,
                      output [7:0] B,
                      output       A);

   localparam                      SCREEN_X = 640;
   localparam                      SCREEN_Y = 480;

   localparam                      LOGO_X = 160;
   localparam                      LOGO_Y = 32;

   localparam                      FRAME_X = 240;
   localparam                      FRAME_Y = 224;

   localparam                      FRAME_X_END = FRAME_X + LOGO_X;
   localparam                      FRAME_Y_END = FRAME_Y + LOGO_Y;

   localparam                      BACKGROUND_X = FRAME_X - 5;
   localparam                      BACKGROUND_Y = FRAME_Y - 5;
   localparam                      BACKGROUND_X_END = FRAME_X_END + 5;
   localparam                      BACKGROUND_Y_END = FRAME_Y_END + 5;

   wire                            draw_logo;
   wire                            draw_back;

   assign draw_logo = (x >= FRAME_X) & (x < FRAME_X_END) &
                      (y >= FRAME_Y) & (y < FRAME_Y_END);

   assign draw_back = (x >= BACKGROUND_X) & (x < BACKGROUND_X_END) &
                      (y >= BACKGROUND_Y) & (y < BACKGROUND_Y_END);

   wire [9:0]                      img_x;
   wire [9:0]                      img_y;

   wire [7:0]                      R_img;
   wire [7:0]                      G_img;
   wire [7:0]                      B_img;
   wire                            A_img;

   assign img_x = x - FRAME_X;
   assign img_y = y - FRAME_Y;

   start_img(.x(img_x),
             .y(img_y),

             .R(R_img),
             .G(G_img),
             .B(B_img),
             .A(A_img));

   assign { R, G, B, A } = (draw_logo) ? ({ R_img, G_img, B_img, A_img }) :
                           (draw_back) ? ({ 24'h000000, 1'b1 }) : ({ 24'h000000, 1'b0 });

endmodule // start_renderer
