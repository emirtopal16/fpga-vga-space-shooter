module spaceship(
                 input            clk,

                 input            fire,
                 input            change_mode,
                 input            rotate,
                 input            rotate_right,

                 input            collision,

                 output reg       state,
                 output reg [3:0] charge,
                 output reg       mode,
                 output reg [1:0] health,
                 output reg [3:0] angle,

                 output [15:0]    angles_hit,
                 output           firing
);

   // state
   // 0: idle (can rotate the ship)
   // 1: firing sequence (unable to rotate)

   // charge
   // 16: full charge
   // 0: no charge

   // mode
   // 0: fast shooting
   // 1: slow shooting

   localparam                     FIRE_ANIMATION_DURATION = 830000;
   localparam                     RELOAD_DURATION0 = 6250000;
   localparam                     RELOAD_DURATION1 = 12500000;

   reg [31:0]                     firing_countdown;
   reg [31:0]                     reload_counter;

   wire [31:0]                    current_reload_duration;
   assign current_reload_duration = (mode) ? (RELOAD_DURATION1) : (RELOAD_DURATION0);

   initial begin
      state = 1'b0;
      charge = 4'hF;

      mode = 1'b0;
      health = 2'd3;
      angle = 4'd0;
   end

   angles_hit_generator angles_git_gen_inst(.angle(0 - angle), .mode(mode), .angles_hit(angles_hit));

   assign firing = (firing_countdown == 0) & state;

   always @(posedge clk) begin
      if (collision) begin
         health <= health - 1;
      end
      case (state)
        // idle
        1'b0: begin
           if (fire) begin
              if (charge == 4'hF) begin
                 charge <= 4'h0;
                 state <= 1'b1;
                 firing_countdown <= FIRE_ANIMATION_DURATION;
              end
           end else begin
              mode <= mode ^ change_mode;

              if (rotate)
                case (rotate_right)
                  1'b0: angle <= angle + 1;
                  1'b1: angle <= angle - 1;
                endcase // case (rotate_right)

              if (charge != 4'hF) begin // charging
                 if (reload_counter > current_reload_duration) begin
                    charge <= charge + 1;
                    reload_counter <= 0;
                 end
                 reload_counter <= reload_counter + 1;
              end
           end
        end
        // firing
        1'b1: begin
           if (firing_countdown == 0) begin
              state <= 1'b0;
           end else begin
              firing_countdown <= firing_countdown - 1;
           end
        end
      endcase // case (state)
   end

endmodule // spaceship
