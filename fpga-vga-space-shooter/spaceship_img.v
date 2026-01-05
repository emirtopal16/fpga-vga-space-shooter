module spaceship_img(input [9:0]      x,
                     input [9:0]      y,

                     input [3:0]      angle,

                     output reg [7:0] R,
                     output reg [7:0] G,
                     output reg [7:0] B,
                     output reg       A);

   localparam                           PIX_WIDTH = 2;
   localparam                           X = 32;
   localparam                           Y = 32;

   reg [PIX_WIDTH-1:0]                  mem0 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem1 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem2 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem3 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem4 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem5 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem6 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem7 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem8 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  mem9 [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  memA [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  memB [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  memC [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  memD [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  memE [X*Y-1:0];
   reg [PIX_WIDTH-1:0]                  memF [X*Y-1:0];

   initial begin
      $readmemb("./sprites/spaceship/12.txt", mem0);
      $readmemb("./sprites/spaceship/13.txt", mem1);
      $readmemb("./sprites/spaceship/14.txt", mem2);
      $readmemb("./sprites/spaceship/15.txt", mem3);
      $readmemb("./sprites/spaceship/00.txt", mem4);
      $readmemb("./sprites/spaceship/01.txt", mem5);
      $readmemb("./sprites/spaceship/02.txt", mem6);
      $readmemb("./sprites/spaceship/03.txt", mem7);
      $readmemb("./sprites/spaceship/04.txt", mem8);
      $readmemb("./sprites/spaceship/05.txt", mem9);
      $readmemb("./sprites/spaceship/06.txt", memA);
      $readmemb("./sprites/spaceship/07.txt", memB);
      $readmemb("./sprites/spaceship/08.txt", memC);
      $readmemb("./sprites/spaceship/09.txt", memD);
      $readmemb("./sprites/spaceship/10.txt", memE);
      $readmemb("./sprites/spaceship/11.txt", memF);
   end

   wire [9:0]                           address;
   wire [PIX_WIDTH-1:0]                 pixel [15:0];

   assign address = x + y*X;

   assign pixel[0] = mem0[address];
   assign pixel[1] = mem1[address];
   assign pixel[2] = mem2[address];
   assign pixel[3] = mem3[address];
   assign pixel[4] = mem4[address];
   assign pixel[5] = mem5[address];
   assign pixel[6] = mem6[address];
   assign pixel[7] = mem7[address];
   assign pixel[8] = mem8[address];
   assign pixel[9] = mem9[address];
   assign pixel[10] = memA[address];
   assign pixel[11] = memB[address];
   assign pixel[12] = memC[address];
   assign pixel[13] = memD[address];
   assign pixel[14] = memE[address];
   assign pixel[15] = memF[address];

   always @(*) begin
      case (pixel[angle])
        2'd0: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 1'b0 };
        2'd1: { R, G, B, A } <= { 8'b00000000, 8'b00000000, 8'b00000000, 1'b1 };
        2'd2: { R, G, B, A } <= { 8'b11101101, 8'b00011100, 8'b00100100, 1'b1 };
        2'd3: { R, G, B, A } <= { 8'b11111111, 8'b11111111, 8'b11111111, 1'b1 };
      endcase // case (angle)
   end

endmodule // spaceship_image
