module key_press(input clk,
                 input  key,
                 output out);

   reg                  key_inner;
   reg                  key_prev;
   wire                 active;

   assign out = key_inner & ~key_prev;

   always @(posedge clk) begin
      key_inner <= key;
      key_prev <= key_inner;
   end

endmodule // key_press
