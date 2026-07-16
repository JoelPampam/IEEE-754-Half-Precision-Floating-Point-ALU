//Modular Exponent Subtractor(Top Level)
module ModularExponentSub #(parameter N = 8)
(
	input [N-1:0] A, B,
	output [N-1:0] out,
	output cout
);

	logic [N-1:0] R,Rcomp;
	logic Cout;
	
	RippleCarrySub #(.N(N)) RippleCarrySub_inst
	(
		.A(A) ,	// input [(N-1):0] A_sig
		.B(B^{N{1'b1}}) ,	// input [(N-1):0] B_sig
		.cin(1'b1) ,
		.R(R) ,	// output [(N-1):0] R_sig
		.Cout(cout) 	// output  Cout_sig
	);
	TwosCompConverter #(.N(N)) TwosCompConverter_inst
	(
		.A(R) ,	// input [(N-1):0] A_sig
		.B(Rcomp) 	// output [(N-1):0] B_sig
	);
	twotoonemux #(.N(N))twotoonemux_inst
	(
		.A(R) ,	// input [(N-1):0] A_sig
		.B(Rcomp) ,	// input [(N-1):0] B_sig
		.select(cout) ,	// input  select_sig
		.out(out) 	// output [(N-1):0] out_sig
	);
	
endmodule