module renderer(input [9:0]                  x,
                input [9:0]                  y,

                input [GAME_STATE_WIDTH-1:0] game_state,
                input [15:0]                 angles_hit,
                input [9:0]                  score,
                input [1:0]                  screen_state,

                output [7:0]                 R,
                output [7:0]                 G,
                output [7:0]                 B);

   localparam                ENEMY_STATE_WIDTH = 19;
   localparam                SPACESHIP_STATE_WIDTH = 28;
   localparam                GAME_STATE_WIDTH = ENEMY_STATE_WIDTH*8 + SPACESHIP_STATE_WIDTH;

   wire [ENEMY_STATE_WIDTH*8-1:0] enemy_state_data;
   wire [SPACESHIP_STATE_WIDTH-1:0] spaceship_state_data;

   wire                             start_screen;
   wire                             game_screen;
   wire                             game_over_screen;

   assign start_screen = screen_state == 2'd0;
   assign game_screen = screen_state == 2'd1;
   assign game_over_screen = screen_state == 2'd2;

   assign { spaceship_state_data, enemy_state_data } = game_state;

   // spaceship wires
   wire                     spaceship_state;
   wire [3:0]               charge;
   wire                     mode;
   wire [1:0]               health;
   wire [3:0]               angle;

   assign { spaceship_state, charge, mode, health, angle } = spaceship_state_data;

   wire [7:0]                R_background;
   wire [7:0]                G_background;
   wire [7:0]                B_background;

   wire [7:0]                R_enemy;
   wire [7:0]                G_enemy;
   wire [7:0]                B_enemy;
   wire                      A_enemy;

   wire [7:0]                R_spaceship;
   wire [7:0]                G_spaceship;
   wire [7:0]                B_spaceship;
   wire                      A_spaceship;

   wire [7:0]                R_start;
   wire [7:0]                G_start;
   wire [7:0]                B_start;
   wire                      A_start;

   wire [7:0]                R_gameover;
   wire [7:0]                G_gameover;
   wire [7:0]                B_gameover;
   wire                      A_gameover;

   wire [7:0]                R_bullet;
   wire [7:0]                G_bullet;
   wire [7:0]                B_bullet;
   wire                      A_bullet;

   background_renderer background_inst(.x(x),
                                       .y(y),

                                       .R(R_background),
                                       .G(G_background),
                                       .B(B_background));

   enemies_renderer renderer_inst1(.x(x),
                                   .y(y),

                                   .state(enemy_state_data),
                                   .angles_hit(angles_hit),

                                   .R(R_enemy),
                                   .G(G_enemy),
                                   .B(B_enemy),
                                   .A(A_enemy));

   spaceship_renderer renderer_inst2(.x(x),
                                     .y(y),

                                     .angle(angle),

                                     .R(R_spaceship),
                                     .G(G_spaceship),
                                     .B(B_spaceship),
                                     .A(A_spaceship));

   start_renderer renderer_inst4(.x(x),
                                 .y(y),

                                 .R(R_start),
                                 .G(G_start),
                                 .B(B_start),
                                 .A(A_start));

   gameover_renderer renderer_inst5(.x(x),
                                    .y(y),

                                    .score(score),

                                    .R(R_gameover),
                                    .G(G_gameover),
                                    .B(B_gameover),
                                    .A(A_gameover));

   bullet_renderer renderer_inst6(.x(x),
                                  .y(y),

                                  .count((mode) ? (3'd5) : (3'd3)),

                                  .R(R_bullet),
                                  .G(G_bullet),
                                  .B(B_bullet),
                                  .A(A_bullet));

   assign { R, G, B } = (A_spaceship & game_screen) ? ({ R_spaceship, G_spaceship, B_spaceship }) :
                        (A_bullet & game_screen) ? ({ R_bullet, G_bullet, B_bullet }) :
                        (A_enemy & game_screen) ? ({ R_enemy, G_enemy, B_enemy }) :
                        (A_start & start_screen) ? ({ R_start, G_start, B_start }) :
                        (game_over_screen) ? ({ R_gameover, G_gameover, B_gameover }) :
                        ({ R_background, G_background, B_background });

endmodule // renderer
