//Twos comp converter
module TwosCompConverter #(parameter N = 8)
(
	input[N-1:0]A,
	output[N-1:0]B
);
	wire [N:0] ha;
	assign ha[0] = 1'b1;
		genvar i;
		generate
			for(i=0;i<N;i=i+1)
				begin: twosFor
					halfADDER halfADDER_inst1
					(
						.s(B[i]),
						.cout(ha[i+1]),
						.a((A[i])^(1'b1)),
						.b(ha[i])
					);
				end
		endgenerate
endmodule
