module fpga_display(input [GAME_STATE_WIDTH-1:0] state,
                    input [3:0]  enemy_count,
                    input [9:0]  score,
                    input        collision,

                    output [6:0] HEX0,
                    output [6:0] HEX1,
                    output [6:0] HEX2,
                    output [6:0] HEX3,
                    output [6:0] HEX4,
                    output [6:0] HEX5,

                    output [9:0] LEDR);

   localparam                   ENEMY_STATE_WIDTH = 19;
   localparam                   SPACESHIP_STATE_WIDTH = 28;
   localparam                   GAME_STATE_WIDTH = ENEMY_STATE_WIDTH*8 + SPACESHIP_STATE_WIDTH;

   wire [ENEMY_STATE_WIDTH*8-1:0] enemy_state_data;
   wire [SPACESHIP_STATE_WIDTH-1:0] spaceship_state_data;

   assign { spaceship_state_data, enemy_state_data } = state;

   // spaceship wires
   wire                     spaceship_state;
   wire [3:0]               charge;
   wire                     mode;
   wire [1:0]               health;
   wire [3:0]               angle;

   assign { spaceship_state, charge, mode, health, angle } = spaceship_state_data;

   // enemy wires
   wire                     enemy_alive[7:0];
   wire [3:0]               enemy_angle[7:0];
   wire [1:0]               enemy_kind[7:0];
   wire [7:0]               enemy_distance[7:0];
   wire [3:0]               enemy_health[7:0];

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

   seven_segment ss_inst1(.N(enemy_count), .disp(HEX0));
   //seven_segment ss_inst2(.N(charge), .disp(HEX1));
   assign HEX1 = 7'b1111111;
   //assign HEX3 = 7'b1111111;
   //assign HEX4 = 7'b1111111;
   assign HEX5 = 7'b1111111;

   seven_segment ss_inst3(.N(score[3:0]), .disp(HEX2));
   seven_segment ss_inst4(.N(score[7:4]), .disp(HEX3));
   seven_segment ss_inst5(.N(score[9:8]), .disp(HEX4));

   assign LEDR[0] = collision;
   assign LEDR[1] = mode;

endmodule // fpga_display
