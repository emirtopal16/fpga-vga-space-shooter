module coordinate_generator(input [7:0] distance,
                            input [3:0] angle,

                            output reg [9:0] x,
                            output reg [9:0] y);

   localparam                                COORD_WIDTH = 10;
   localparam                                MAX_DIST = 208;
   localparam                                ANGLES = 16;

   reg [2*COORD_WIDTH-1:0]                   coord [MAX_DIST*ANGLES-1:0];

   wire [11:0]                               address;
   wire [2*COORD_WIDTH-1:0]                  coord_wire;

   initial $readmemb("./xycoords.txt", coord);

   assign address = angle*MAX_DIST + distance;
   assign coord_wire = coord[address];

   always @(*) begin
      y <= coord_wire[COORD_WIDTH-1:0];
      x <= coord_wire[2*COORD_WIDTH-1:COORD_WIDTH];
   end

endmodule // coordinate_generator
