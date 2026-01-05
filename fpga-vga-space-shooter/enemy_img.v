module enemy_img(input [9:0]      x,
                 input [9:0]      y,

                 input [1:0]      select,

                 output reg [7:0] R,
                 output reg [7:0] G,
                 output reg [7:0] B,
                 output reg       A);

   localparam                      PIX_WIDTH = 3;
   localparam                      X = 32;
   localparam                      Y = 32;

   reg [PIX_WIDTH-1:0]             mem0 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]             mem1 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]             mem2 [X*Y-1:0];

   initial $readmemb("./sprites/enemy1.txt", mem0);
   initial $readmemb("./sprites/enemy2.txt", mem1);
   initial $readmemb("./sprites/enemy3.txt", mem2);

   wire [9:0]                      address;

   wire [PIX_WIDTH-1:0]            pixel [2:0];

   assign address = x + y*X;

   assign pixel[0] = mem0[address];
   assign pixel[1] = mem1[address];
   assign pixel[2] = mem2[address];

   always @(*) begin
      case (select)
        2'b00: begin
           case (pixel[select])
             3'd0: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 1'b0 };
             3'd1: { R, G, B, A } <= { 8'b00100010, 8'b10110001, 8'b01001100, 1'b1 };
             3'd2: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 1'b1 };
             3'd3: { R, G, B, A } <= { 8'b10011100, 8'b01011010, 8'b00111100, 1'b1 };
             3'd4: { R, G, B, A } <= { 8'b10101000, 8'b11100110, 8'b00011101, 1'b1 };
             3'd5: { R, G, B, A } <= { 8'b11101101, 8'b00011100, 8'b00100100, 1'b1 };
             3'd6: { R, G, B, A } <= { 8'b11111111, 8'b11111111, 8'b11111111, 1'b1 };
             3'd7: { R, G, B, A } <= { 8'b11111111, 8'b10100011, 8'b10110001, 1'b1 };
             default: { R, G, B, A } <= { 24'h000000, 1'b0 };
           endcase // case (pixel)
        end
        2'b01: begin
           case (pixel[select])
             3'd0: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 1'b0 };
             3'd2: { R, G, B, A } <= { 8'b00100010, 8'b10110001, 8'b01001100, 1'b1 };
             3'd1: { R, G, B, A } <= { 8'b00000000, 8'b10110111, 8'b11101111, 1'b1 };
             3'd3: { R, G, B, A } <= { 8'b01000110, 8'b01000110, 8'b01000110, 1'b1 };
             3'd6: { R, G, B, A } <= { 8'b11111111, 8'b01111110, 8'b00000000, 1'b1 };
             3'd4: { R, G, B, A } <= { 8'b01101111, 8'b00110001, 8'b10011000, 1'b1 };
             3'd5: { R, G, B, A } <= { 8'b10110100, 8'b10110100, 8'b10110100, 1'b1 };
             default: { R, G, B, A } <= { 24'h000000, 1'b0 };
           endcase // case (pixel)
        end
        2'b10: begin
           case (pixel[select])
             3'd0: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 8'b0 };
             3'd2: { R, G, B, A } <= { 8'b00100010, 8'b10110001, 8'b01001100, 8'b1 };
             3'd1: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 8'b1 };
             3'd3: { R, G, B, A } <= { 8'b11101101, 8'b00011100, 8'b00100100, 8'b1 };
             3'd5: { R, G, B, A } <= { 8'b11111111, 8'b11111111, 8'b11111111, 8'b1 };
             3'd4: { R, G, B, A } <= { 8'b11111111, 8'b01111110, 8'b00000000, 8'b1 };
             default: { R, G, B, A } <= { 24'h000000, 1'b0 };
           endcase // case (pixel)
        end
        default: { R, G, B, A } <= { 24'h000000, 1'b0 };
      endcase // case (select)
   end

endmodule // enemy1_rgb
