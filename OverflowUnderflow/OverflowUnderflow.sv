//OverFlow and UnderFlow Flag module
module OverflowUnderflow
(
	input [4:0] EA, EB,
	input [9:0] finalmantissa,
	input [5:0] finalexponent,
	input exponentsubtractorcout,
	output Overflow, Underflow
);
	logic Exception;
	logic zero;
	assign Exception = (&EA) | (&EB);
	assign zero = Exception ? 1'b0 : (finalmantissa == 10'd0) ? 1'b1 : 1'b0;
	assign Overflow = (finalexponent > 5'b11110) && !zero;
	assign Underflow = ~exponentsubtractorcout;

endmodule