// Four to one mux
module four2one
(
	input [1:0] SEL,
	input [3:0] D0,D1,D2,D3,
	output logic [3:0] Y
);
	always_comb
		case(SEL)
			2'b00: Y = D0;
			2'b01: Y = D1;
			2'b10: Y = D2;
			2'b11: Y = D3;
		endcase
endmodule
