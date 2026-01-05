module input_controller(input clk,

                        input [9:0] SW,
                        input [3:0] KEY,

                        output      fire,
                        output      change_mode,
                        output      rotate,
                        output      rotate_right);

   wire                             rotate_right_active;
   wire                             rotate_left_active;

   assign rotate = rotate_right_active ^ rotate_left_active;
   assign rotate_right = rotate_right_active;

   key_press press1(.clk(clk), .key(~KEY[2]), .out(rotate_right_active));
   key_press press2(.clk(clk), .key(~KEY[3]), .out(rotate_left_active));

   key_press press3(.clk(clk), .key(~KEY[0]), .out(fire));
   key_press press4(.clk(clk), .key(~KEY[1]), .out(change_mode));

endmodule // input_controller
