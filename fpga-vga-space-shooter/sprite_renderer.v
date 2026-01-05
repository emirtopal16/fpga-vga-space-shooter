module sprite_renderer(input [7:0]  R_pix,
                       input [7:0]  G_pix,
                       input [7:0]  B_pix,

                       output [9:0] x_pix,
                       output [9:0] y_pix,

                       input [9:0]  vga_x,
                       input [9:0]  vga_y,

                       input [9:0]  x,
                       input [9:0]  y,

                       output [7:0] R,
                       output [7:0] G,
                       output [7:0] B,

                       output       enable);

   parameter                       X = 32;
   parameter                       Y = 32;

   wire                            draw;

   wire [23:0]                     pixel;

   wire [31:0]                     address;

   assign enable = ((vga_x >= x && vga_x < x + X) && (vga_y > y && vga_y < y + Y));

   assign x_pix = vga_x - x;
   assign y_pix = vga_y - y;

   assign R = R_pix;
   assign G = G_pix;
   assign B = B_pix;

endmodule // sprite_renderer
