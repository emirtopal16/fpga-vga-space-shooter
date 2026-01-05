module spawner(
               input       clk,

               input [3:0] random_number,

               input [3:0] enemy_count,

               output      spawn);

   integer                 countdown;

   wire                    low_enemy_count;

   initial countdown = 0;

   assign low_enemy_count = enemy_count == 4'd0 ||
                            enemy_count == 4'd1;

   assign spawn = (countdown == 0) & (enemy_count != 4'd8) || low_enemy_count;

   always @(posedge clk) begin
      if (countdown == 0) begin
         //countdown <= { 1'b1, random_number };
         countdown <= 30000000;
      end else begin
         countdown <= countdown - 1;
      end
   end

endmodule // spawner
