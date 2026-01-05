module enemies(
               input                      clk,

               input [5:0]                random_number, // random number generator used to spawn randomly
               input                      spawn, // spawn new enemy

               input [15:0]               angles_hit,
               input                      firing,
               input                      mode,

               output [3:0]               enemy_count,

               output                     collision,
               output [3:0]               kill_count,

               // enemy state
               output [STATE_WIDTH*8-1:0] state
);

   localparam                    STATE_WIDTH = 19;

   wire [3:0]               new_angle;
   wire                     new_angle_occupied;

   wire [1:0]               new_kind;

   wire                     alive[7:0];
   wire [3:0]               angle[7:0];
   wire [1:0]               kind[7:0];
   wire [7:0]               distance[7:0];
   wire [3:0]               health[7:0];

   wire                     enemy_collision [7:0];
   wire                     enemy_kill [7:0];

   wire [2:0]               dead_cell;

   genvar                   i;
   generate
      for (i = 0; i < 8; i = i + 1) begin: enemy_gen
         wire enemy_spawn;
         wire [STATE_WIDTH-1:0] enemy_data;

         assign enemy_spawn = (i == dead_cell) & spawn & (~new_angle_occupied);

         assign state[STATE_WIDTH*(i+1)-1:STATE_WIDTH*i] = { alive[i], angle[i], kind[i], distance[i], health[i] };

         enemy enemy_inst(.clk(clk),

                          .spawn(enemy_spawn),

                          .new_angle(new_angle),
                          .new_kind(new_kind),

                          .angles_hit(angles_hit),
                          .firing(firing),
                          .mode(mode),

                          .alive(alive[i]),
                          .angle(angle[i]),
                          .kind(kind[i]),
                          .distance(distance[i]),
                          .health(health[i]),

                          .collision(enemy_collision[i]),
                          .killed(enemy_kill[i]));
      end
   endgenerate

   assign collision = enemy_collision[7] |
                      enemy_collision[6] |
                      enemy_collision[5] |
                      enemy_collision[4] |
                      enemy_collision[3] |
                      enemy_collision[2] |
                      enemy_collision[1] |
                      enemy_collision[0];

   assign enemy_count = alive[7] +
                        alive[6] +
                        alive[5] +
                        alive[4] +
                        alive[3] +
                        alive[2] +
                        alive[1] +
                        alive[0];

   assign kill_count = enemy_kill[7] +
                       enemy_kill[6] +
                       enemy_kill[5] +
                       enemy_kill[4] +
                       enemy_kill[3] +
                       enemy_kill[2] +
                       enemy_kill[1] +
                       enemy_kill[0];

   assign new_angle = random_number[3:0];
   assign new_angle_occupied = alive[7] & (new_angle == angle[7]) |
                               alive[6] & (new_angle == angle[6]) |
                               alive[5] & (new_angle == angle[5]) |
                               alive[4] & (new_angle == angle[4]) |
                               alive[3] & (new_angle == angle[3]) |
                               alive[2] & (new_angle == angle[2]) |
                               alive[1] & (new_angle == angle[1]) |
                               alive[0] & (new_angle == angle[0]);

   assign new_kind = random_number[5:4];

   assign dead_cell = (!alive[7]) ? (3'd7) :
                      (!alive[6]) ? (3'd6) :
                      (!alive[5]) ? (3'd5) :
                      (!alive[4]) ? (3'd4) :
                      (!alive[3]) ? (3'd3) :
                      (!alive[2]) ? (3'd2) :
                      (!alive[1]) ? (3'd1) :
                      (!alive[0]) ? (3'd0) : (3'd0);

endmodule // enemies
