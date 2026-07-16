module MantissaNormalizerLeft
(
	input [10:0] A,
	input select,
	output [9:0] mantissa
);

logic [9:0] Y;
	
	always_comb begin
		if(select == 1) begin
				Y = A[9:0];
			end
		else begin
			Y = {A[8:0],1'b0};
		end
	end
	
	assign mantissa = Y;
	
endmodule
			