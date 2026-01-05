module enemy(
             input            clk,

             input            spawn,

             input [3:0]      new_angle,
             input [1:0]      new_kind,

             input [15:0]     angles_hit,
             input            firing,
             input            mode,

             output reg       alive,
             output reg [3:0] angle,
             output reg [1:0] kind,
             output reg [7:0] distance,
             output reg [3:0] health,

             output           collision,
             output           killed
);

   localparam                 FIRE0_DAMAGE = 2;
   localparam                 FIRE1_DAMAGE = 1;

   localparam                 KIND1_DAMAGE = 4;
   localparam                 KIND2_DAMAGE = 2;
   localparam                 KIND3_DAMAGE = 1;

   wire                       distance_clk;

   wire [3:0]                 kind_damage;
   wire [3:0]                 fire_damage;
   wire [3:0]                 damage;

   assign kind_damage = (kind == 2'd0) ? (KIND1_DAMAGE) :
                        (kind == 2'd1) ? (KIND2_DAMAGE) :
                        (kind == 2'd2) ? (KIND3_DAMAGE) :
                        (KIND1_DAMAGE);

   assign fire_damage = (mode) ? (FIRE1_DAMAGE) : (FIRE0_DAMAGE);

   assign damage = fire_damage * kind_damage;

   // 16 times a sec
   clock #(.COUNT(3125000)) dist_clock(.clk(clk), .out(distance_clk));
   //clock #(.COUNT(4)) dist_clock(.clk(clk), .out(distance_clk));

   initial begin
      alive = 1'b0;
      health = 4'hF;
   end

   assign killed = (health == 0);
   assign collision = (distance == 8) & alive;

   always @(posedge clk) begin
      if (!alive && spawn) begin
         alive <= 1'b1;
         angle <= new_angle;
         kind <= new_kind % 3;
         distance <= 8'd200;
         health <= 4'hF;
      end else begin
         // enemy killed
         if (health == 4'd0) begin
            health <= 4'hF;
            alive <= 1'b0;
         end

         if (firing) begin
            if (angles_hit[angle]) begin
               health <= (health >= damage) ? (health - damage) : 0;
            end
         end

         if (distance_clk) distance <= distance - 1;
         if (collision) health <= 0;
      end
   end

endmodule // enemy
