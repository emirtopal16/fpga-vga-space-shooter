module game(
            input                           clk,

            input                           fire,
            input                           change_mode,
            input                           rotate,
            input                           rotate_right,

            output reg [9:0]                score,

            output [GAME_STATE_WIDTH - 1:0] state,
            output [3:0]                    enemy_count,
            output                          collision,
            output [15:0]                   angles_hit
);

   localparam                               ENEMY_STATE_WIDTH = 19;
   localparam                               SPACESHIP_STATE_WIDTH = 28;
   localparam                               GAME_STATE_WIDTH = ENEMY_STATE_WIDTH*8 + SPACESHIP_STATE_WIDTH;

   wire [19:0]    N;
   prng rand_generator(.clk(clk), .N(N));

   wire           spawn;
   //wire [3:0]     enemy_count;

   // enemy wires
   wire                     enemy_alive[7:0];
   wire [3:0]               enemy_angle[7:0];
   wire [1:0]               enemy_kind[7:0];
   wire [7:0]               enemy_distance[7:0];
   wire [3:0]               enemy_health[7:0];

   wire [ENEMY_STATE_WIDTH*8-1:0]          enemy_state_data;
   wire [SPACESHIP_STATE_WIDTH-1:0]        spaceship_state_data;

   //wire                     collision;

   // spaceship wires
   wire                     spaceship_state;
   wire [3:0]               charge;
   wire                     mode;
   wire [1:0]               health;
   wire [3:0]               angle;

   //wire [15:0]              angles_hit;
   wire                     firing;

   wire [3:0]               kill_count;

   always @(posedge clk) begin
      score <= score + kill_count;
   end

   assign spaceship_state_data = { spaceship_state, charge, mode, health, angle };

   assign state = { spaceship_state_data, enemy_state_data };

   genvar                   i;
   generate
      for (i = 0; i < 8; i = i + 1) begin: enemy_state_gen
         assign {
                 enemy_alive[i],
                 enemy_angle[i],
                 enemy_kind[i],
                 enemy_distance[i],
                 enemy_health[i]
                 } = enemy_state_data[ENEMY_STATE_WIDTH*(i+1)-1:ENEMY_STATE_WIDTH*i];
      end
   endgenerate

   spaceship spaceship_inst(.clk(clk),

                            .fire(fire),
                            .change_mode(change_mode),
                            .rotate(rotate),
                            .rotate_right(rotate_right),

                            .collision(collision),

                            .state(spaceship_state),
                            .charge(charge),
                            .mode(mode),
                            .health(health),
                            .angle(angle),

                            .angles_hit(angles_hit),
                            .firing(firing));

   enemies enemies_inst(.clk(clk),

                        .random_number(N[5:0]),
                        .spawn(spawn),

                        .angles_hit(angles_hit),
                        .firing(firing),
                        .mode(mode),

                        .enemy_count(enemy_count),

                        .collision(collision),
                        .kill_count(kill_count),

                        .state(enemy_state_data));

   spawner spawn_clock(.clk(clk), .random_number(N[9:6]), .enemy_count(enemy_count), .spawn(spawn));

endmodule
