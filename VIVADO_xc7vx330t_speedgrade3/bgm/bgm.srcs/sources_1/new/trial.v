module mult_EV(clk, opa, opb, prod);
input		clk;
input [23:0] opa;
input [23:0] opb;

output reg [47:0] prod;

wire [47:0] result;
assign result = opa * opb;

always @(posedge clk)
	prod <= result;

endmodule