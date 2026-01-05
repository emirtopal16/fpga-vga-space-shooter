module clock(
             input  clk,
             output out
);

   parameter        COUNT = 50000000;

   integer          counter;

   assign out = (counter == COUNT - 1);

   initial counter = 0;

   always @(posedge clk) begin
      if (out) counter <= 0;
      else counter <= counter + 1;
   end

endmodule // clock
