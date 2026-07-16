//Two to one mux
module twotoonemux #(parameter N = 8)
(
	input [N-1:0] A, B,
	input select,
	output [N-1:0] out
);
	
	always_comb begin
		if(select)
			out = A;
		else
			out = B;
	end
	
endmodule