module enemy_renderer(input [9:0]  x,
                      input [9:0]  y,

                      input        alive,
                      input [3:0]  angle,
                      input [7:0]  distance,
                      input [1:0]  kind,
                      input [3:0]  health,

                      input [15:0] angles_hit,

                      output [7:0] R,
                      output [7:0] G,
                      output [7:0] B,
                      output       A);

   localparam                      X = 32;
   localparam                      Y = 32;

   wire [9:0]                      frame_x;
   wire [9:0]                      frame_y;

   wire [9:0]                      img_x;
   wire [9:0]                      img_y;

   wire [9:0]                      frame_x_end;
   wire [9:0]                      frame_y_end;

   wire                            within_frame;

   // test code
   coordinate_generator coordgen(.distance(distance),
                                 .angle(angle),

                                 .x(frame_x),
                                 .y(frame_y));
   //assign frame_x = 100 + distance;
   //assign frame_y = angle*30;
   // test code

   assign within_frame = (x >= frame_x) & (x < frame_x_end) &
                         (y >= frame_y) & (y < frame_y_end);

   assign frame_x_end = frame_x + X;
   assign frame_y_end = frame_y + Y;

   assign img_x = x - frame_x;
   assign img_y = y - frame_y;

   wire [7:0]                      R_img;
   wire [7:0]                      G_img;
   wire [7:0]                      B_img;
   wire                            A_img;

   wire [7:0]                      R_health;
   wire [7:0]                      G_health;
   wire [7:0]                      B_health;
   wire                            A_health;

   wire                            draw_health;

   assign draw_health = (img_y < 6);

   wire                            hit;
   assign hit = angles_hit[angle];

   enemy_img img(.x(img_x),
                 .y(img_y),

                 .select(kind),

                 .R(R_img),
                 .G(G_img),
                 .B(B_img),
                 .A(A_img));

   health_bar_renderer health_inst(.x(img_x),
                                   .y(img_y),

                                   .health(health),
                                   .hit(hit),

                                   .R(R_health),
                                   .G(G_health),
                                   .B(B_health),
                                   .A(A_health));

   assign { R, G, B, A } = (draw_health) ? ({ R_health, G_health, B_health, A_health & within_frame & alive }) :
                           ({ R_img, G_img, B_img, A_img & within_frame & alive });

endmodule // enemy_renderer
