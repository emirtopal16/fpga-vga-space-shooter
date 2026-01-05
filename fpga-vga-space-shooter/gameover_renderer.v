module gameover_renderer(input [9:0]  x,
                         input [9:0]  y,

                         input [9:0] score,

                         output [7:0] R,
                         output [7:0] G,
                         output [7:0] B,
                         output       A);

   localparam                      SCREEN_X = 640;
   localparam                      SCREEN_Y = 480;

   localparam                      LOGO_X = 256;
   localparam                      LOGO_Y = 32;

   localparam                      SKULL_X = 32;
   localparam                      SKULL_Y = 32;

   localparam                      LOGO_FRAME_X = 192;
   localparam                      LOGO_FRAME_Y = 224;

   localparam                      LOGO_FRAME_X_END = LOGO_FRAME_X + LOGO_X;
   localparam                      LOGO_FRAME_Y_END = LOGO_FRAME_Y + LOGO_Y;

   localparam                      SKULL_FRAME_X = LOGO_FRAME_X - SKULL_X;
   localparam                      SKULL_FRAME_Y = LOGO_FRAME_Y;

   localparam                      SKULL_FRAME_X_END = SKULL_FRAME_X + SKULL_X;
   localparam                      SKULL_FRAME_Y_END = SKULL_FRAME_Y + SKULL_Y;

   wire                            draw_logo;
   wire                            draw_skull;

   assign draw_logo = (x >= LOGO_FRAME_X) & (x < LOGO_FRAME_X_END) &
                      (y >= LOGO_FRAME_Y) & (y < LOGO_FRAME_Y_END);

   assign draw_skull = (x >= SKULL_FRAME_X) & (x < SKULL_FRAME_X_END) &
                       (y >= SKULL_FRAME_Y) & (y < SKULL_FRAME_Y_END);

   wire [9:0]                      logo_img_x;
   wire [9:0]                      logo_img_y;

   wire [9:0]                      skull_img_x;
   wire [9:0]                      skull_img_y;

   wire [7:0]                      R_img;
   wire [7:0]                      G_img;
   wire [7:0]                      B_img;
   wire                            A_img;

   wire [7:0]                      R_skull;
   wire [7:0]                      G_skull;
   wire [7:0]                      B_skull;
   wire                            A_skull;

   assign logo_img_x = x - LOGO_FRAME_X;
   assign logo_img_y = y - LOGO_FRAME_Y;

   assign skull_img_x = x - SKULL_FRAME_X;
   assign skull_img_y = y - SKULL_FRAME_Y;

   skull_img(.x(skull_img_x),
             .y(skull_img_y),

             .R(R_skull),
             .G(G_skull),
             .B(B_skull),
             .A(A_skull));

   gameover_img(.x(logo_img_x),
                .y(logo_img_y),

                .R(R_img),
                .G(G_img),
                .B(B_img),
                .A(A_img));

   assign { R, G, B, A } = (draw_logo) ? ({ R_img, G_img, B_img, A_img }) :
                           (draw_skull) ? ({ R_skull, G_skull, B_skull, A_skull }) : ({ 24'h000000, 1'b1 });

endmodule // gameover_renderer
