module bullet_img(input [9:0]      x,
                  input [9:0]      y,

                  output reg [7:0] R,
                  output reg [7:0] G,
                  output reg [7:0] B,
                  output reg       A);

   localparam                X = 11;
   localparam                Y = 32;

   reg [1:0]                 mem [X*Y-1:0];

   initial $readmemb("./sprites/start/bullet.txt", mem);

   wire [9:0]                address;
   wire [1:0]                pixel;

   assign address = x + y*X;
   assign pixel = mem[address];

   always @(*) begin
      case (pixel)
        2'd0: { R, G, B, A } <= { 24'h000000, 1'b0 };
        2'd1: { R, G, B, A } <= { 24'h000000, 1'b1 };
        2'd3: { R, G, B, A } <= { 24'hFFEB3B, 1'b1 };
        2'd2: { R, G, B, A } <= { 24'h998608, 1'b1 };
        default: { R, G, B, A } <= { 24'h000000, 1'b0 };
      endcase // case (pixel)
   end

endmodule // bullet_img
