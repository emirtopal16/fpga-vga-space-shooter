module skull_img(input [9:0]      x,
                 input [9:0]      y,

                 output reg [7:0] R,
                 output reg [7:0] G,
                 output reg [7:0] B,
                 output reg       A);

   localparam                X = 32;
   localparam                Y = 32;

   reg [2:0]                 mem [X*Y-1:0];

   initial $readmemb("./sprites/start/skull.txt", mem);

   wire [9:0]                address;
   wire [2:0]                pixel;

   assign address = x + y*X;
   assign pixel = mem[address];

   always @(*) begin
      case (pixel)
        3'd0: { R, G, B, A } <= { 24'h000000, 1'b0 };
        3'd1: { R, G, B, A } <= { 24'h000000, 1'b1 };
        3'd2: { R, G, B, A } <= { 24'h404040, 1'b1 };
        3'd3: { R, G, B, A } <= { 24'hBFBFBF, 1'b1 };
        3'd4: { R, G, B, A } <= { 24'hFFFFFF, 1'b1 };
        default: { R, G, B, A } <= { 24'h000000, 1'b0 };
      endcase // case (pixel)
   end

endmodule // start_img
