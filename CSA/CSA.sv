//Carry Select Adder
module CSA
(
	input [10:0] A,B,
	input Cin,
	output [10:0] Sum,
	output Cout
);


	wire [4:0] lower;
	wire [5:0] RCA2, RCA3, upper;
	wire C80, C81,C4;

	ParameterizedRCA #(.N(5))ParameterizedRCA_inst0
	(
		.Cin(Cin) ,	// input  Cin_sig
		.A(A[4:0]) ,	// input [(N-1):0] A_sig
		.B(B[4:0]) ,	// input [(N-1):0] B_sig
		.Sum(lower[4:0]) ,	// output [(N-1):0] Sum_sig
		.Cout(C4) 	// output  Cout_sig
	);
	
	ParameterizedRCA #(.N(6))ParameterizedRCA_inst1
	(
		.Cin(1'b0) ,	// input  Cin_sig
		.A(A[10:5]) ,	// input [(N-1):0] A_sig
		.B(B[10:5]) ,	// input [(N-1):0] B_sig
		.Sum(RCA2) ,	// output [(N-1):0] Sum_sig
		.Cout(C80) 	// output  Cout_sig
	);
	
	ParameterizedRCA #(.N(6))ParameterizedRCA_inst2
	(
		.Cin(1'b1) ,	// input  Cin_sig
		.A(A[10:5]) ,	// input [(N-1):0] A_sig
		.B(B[10:5]) ,	// input [(N-1):0] B_sig
		.Sum(RCA3) ,	// output [(N-1):0] Sum_sig
		.Cout(C81) 	// output  Cout_sig
	);
	
	Mux R5_inst
	(
		.A(RCA3[0]) ,	// input  A_sig
		.B(RCA2[0]) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(upper[0]) 	// output  R_sig
	);
	
	Mux R6_inst
	(
		.A(RCA3[1]) ,	// input  A_sig
		.B(RCA2[1]) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(upper[1]) 	// output  R_sig
	);
	
	Mux R7_inst
	(
		.A(RCA3[2]) ,	// input  A_sig
		.B(RCA2[2]) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(upper[2]) 	// output  R_sig
	);
	
	Mux R8_inst
	(
		.A(RCA3[3]) ,	// input  A_sig
		.B(RCA2[3]) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(upper[3]) 	// output  R_sig
	);
	
	Mux R9_inst
	(
		.A(RCA3[4]) ,	// input  A_sig
		.B(RCA2[4]) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(upper[4]) 	// output  R_sig
	);
	
	Mux R10_inst
	(
		.A(RCA3[5]) ,	// input  A_sig
		.B(RCA2[5]) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(upper[5]) 	// output  R_sig
	);
	
	Mux Cout_inst
	(
		.A(C81) ,	// input  A_sig
		.B(C80) ,	// input  B_sig
		.S(C4) ,	// input  C4_sig
		.Out(Cout) 	// output  R_sig
	);
	
	assign Sum = {upper,lower};
endmodule