//Mux
module Mux(

	input A,
	input B,
	input S,
	output Out
);

	assign Out = S ? A : B;
	
endmodule
