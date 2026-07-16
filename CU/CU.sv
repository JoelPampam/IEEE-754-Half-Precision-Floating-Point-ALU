//Control Module to decide addition or Subtraction based on the sign bit
module CU
(
	input [15:0] A,B,
	output [15:0] Aout, Bout,
	output addsub,
	output sign
);
	assign addsub = A[15] ^ B[15];
	
	always_comb begin
		if(addsub) begin
			if(A[14:0] > B[14:0]) begin
				Aout = A;
				Bout = B;
				sign = A[15];
			end
			else begin
				Aout = B;
				Bout = A;
				sign = B[15];
			end
		end
		else begin
			Aout = A;
			Bout = B;
			sign = A[15];
		end
	end
	
endmodule