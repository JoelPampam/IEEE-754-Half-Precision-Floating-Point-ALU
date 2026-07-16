//Paramterized Ripple Carry Adder
module ParameterizedRCA #(parameter N = 8)
(
	input Cin,
	input [N-1:0] A,B,
	output [N-1:0] Sum,
	output Cout
);

	wire [N:0] C;
	assign C[0] = Cin;
	assign Cout = C[N];
	
	genvar i;
	generate
		for(i=0;i<N;i=i+1)
			begin:full_adder
				FullAdder FullAdder_inst (A[i],B[i],C[i],Sum[i],C[i+1]);
			end
	endgenerate
	
endmodule
	
	