//Ripple Carry Subtractor
module RippleCarrySub #(parameter N = 8)
(
	input [N-1:0] A, B,
	input cin,
	output [N-1:0] R,
	output Cout
);

	logic [N:0] C;
	assign C[0] = cin;
	assign Cout = C[N];

	genvar i;
	generate
		for(i=0;i<N;i=i+1)
			begin:full_adder
				FullAdder FullAdder_inst (A[i],B[i],C[i],R[i],C[i+1]);
			end
	endgenerate
	
endmodule