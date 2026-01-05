module prng(
	// 50 MHz
	input clk,
	input seed,
	output reg [19:0] N
);

// 20-bit LFSR based on https://docs.amd.com/v/u/en-US/xapp052

reg seeded;
reg [19:0] Q;

wire taps;
assign taps = N[19] ^ N[16];

initial begin
	N = 20'd1;
	Q = 20'd0;
	seeded = 1'b0;
end

always @(posedge clk) begin
	if (seed & ~seeded) begin
		if (Q != 20'd0) N <= Q;
		else N <= 20'd1;
		seeded <= 1'b1;
	end else begin
		N <= { N[18:0], taps };
		if (~seeded) Q <= Q + 1;
	end
end

endmodule
