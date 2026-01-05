module enemies_renderer(input [9:0]                     x,
                        input [9:0]                     y,

                        input [ENEMY_STATE_WIDTH*8-1:0] state,
                        input [15:0]                    angles_hit,

                        output [7:0]                    R,
                        output [7:0]                    G,
                        output [7:0]                    B,
                        output                          A);

   localparam                               ENEMY_STATE_WIDTH = 19;

   // enemy wires
   wire                     enemy_alive [7:0];
   wire [3:0]               enemy_angle [7:0];
   wire [1:0]               enemy_kind [7:0];
   wire [7:0]               enemy_distance [7:0];
   wire [3:0]               enemy_health [7:0];

   // enemy state decoder
   genvar                   i;
   generate
      for (i = 0; i < 8; i = i + 1) begin: enemy_state_gen
         assign {
                 enemy_alive[i],
                 enemy_angle[i],
                 enemy_kind[i],
                 enemy_distance[i],
                 enemy_health[i]
                 } = state[ENEMY_STATE_WIDTH*(i+1)-1:ENEMY_STATE_WIDTH*i];
      end
   endgenerate

   // dummy state
   //genvar                   i;
   //generate
   //   for (i = 0; i < 8; i = i + 1) begin: enemy_state_gen
   //      assign enemy_alive[i] = 1'b1;
   //      assign enemy_angle[i] = i * 2;
   //      assign enemy_kind[i] = 2'd0;
   //      assign enemy_distance[i] = i*40 + 40;
   //      assign enemy_health[i] = 4'hFF;
   //   end
   //endgenerate

   wire [7:0] R_enemy [7:0];
   wire [7:0] G_enemy [7:0];
   wire [7:0] B_enemy [7:0];
   wire       A_enemy [7:0];

   genvar                   j;
   generate
      for (j = 0; j < 8; j = j + 1) begin: enemy_renderer_gen
         enemy_renderer renderer_inst(.x(x),
                                      .y(y),

                                      .alive(enemy_alive[j]),
                                      .angle(enemy_angle[j]),
                                      .distance(enemy_distance[j]),
                                      .kind(enemy_kind[j]),
                                      .health(enemy_health[j]),

                                      .angles_hit(angles_hit),

                                      .R(R_enemy[j]),
                                      .G(G_enemy[j]),
                                      .B(B_enemy[j]),
                                      .A(A_enemy[j]));
      end
   endgenerate

   assign { R, G, B, A } = (A_enemy[7]) ? ({ R_enemy[7], G_enemy[7], B_enemy[7], A_enemy[7] }) :
                           (A_enemy[6]) ? ({ R_enemy[6], G_enemy[6], B_enemy[6], A_enemy[6] }) :
                           (A_enemy[5]) ? ({ R_enemy[5], G_enemy[5], B_enemy[5], A_enemy[5] }) :
                           (A_enemy[4]) ? ({ R_enemy[4], G_enemy[4], B_enemy[4], A_enemy[4] }) :
                           (A_enemy[3]) ? ({ R_enemy[3], G_enemy[3], B_enemy[3], A_enemy[3] }) :
                           (A_enemy[2]) ? ({ R_enemy[2], G_enemy[2], B_enemy[2], A_enemy[2] }) :
                           (A_enemy[1]) ? ({ R_enemy[1], G_enemy[1], B_enemy[1], A_enemy[1] }) :
                           (A_enemy[0]) ? ({ R_enemy[0], G_enemy[0], B_enemy[0], A_enemy[0] }) : ({ 24'hAAAAAA, 1'b0 });

endmodule // enemy_renderer
