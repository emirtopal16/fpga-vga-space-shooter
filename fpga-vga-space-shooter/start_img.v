module start_img(input [9:0]      x,
                 input [9:0]      y,

                 output reg [7:0] R,
                 output reg [7:0] G,
                 output reg [7:0] B,
                 output reg       A);

   localparam                X = 160;
   localparam                Y = 32;

   reg                       mem [X*Y-1:0];

   initial $readmemb("./sprites/start/start.txt", mem);

   wire [9:0]                address;
   wire                      pixel;

   assign address = x + y*X;
   assign pixel = mem[address];

   always @(*) begin
      case (pixel)
        1'b0: { R, G, B, A } <= { 24'h000000, 1'b0 };
        1'b1: { R, G, B, A } <= { 24'hFFFFFF, 1'b1 };
      endcase // case (pixel)
   end

endmodule // start_img
