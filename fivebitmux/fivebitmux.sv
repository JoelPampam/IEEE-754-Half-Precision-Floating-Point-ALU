//5 bit mux
module fivebitmux
(
	input [4:0] A,B,
	input select,
	output [4:0] out
);

	assign out = select ? A : B;
	
endmodule
