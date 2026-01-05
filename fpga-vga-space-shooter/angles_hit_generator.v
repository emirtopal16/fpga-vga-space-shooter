module angles_hit_generator(
                           input [3:0] angle,
                           input mode,
                           output [15:0] angles_hit
);

   wire [3:0] angle0;
   wire [3:0] angle1;
   wire [3:0] angle2;
   wire [3:0] angle3;
   wire [3:0] angle4;

   assign angle0 = angle - 2;
   assign angle1 = angle - 1;
   assign angle2 = angle;
   assign angle3 = angle + 1;
   assign angle4 = angle + 2;

   genvar i;
   generate
      for (i = 0; i < 16; i = i + 1) begin: angles_hit_gen
         assign angles_hit[i] = (i == angle0) & mode |
                                (i == angle1) |
                                (i == angle2) |
                                (i == angle3) |
                                (i == angle4) & mode;
      end
   endgenerate

endmodule // angle_hit_generator
