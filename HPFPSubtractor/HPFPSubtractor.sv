//Half precision Floating Point Subtractor
module HPFPSubtractor
(
	input [15:0] A,B,
	output [4:0] Exponent,
	output [9:0] Mantissa,
	output exponentsubtractorcout
);

	logic [4:0] modexposubout, expoincmuxout;
	logic modexpocout;
	logic [9:0] smuxout, amuxout;
	logic [10:0]  shiftermuxout, mantissarsout, addermuxout;
	logic [10:0] adderout;
	logic addercout;


	ModularExponentSub #(.N(5)) ModularExponentSub_inst
	(
		.A(A[14:10]) ,	// input [(N-1):0] A_sig
		.B(B[14:10]) ,	// input [(N-1):0] B_sig
		.out(modexposubout) ,	// output [(N-1):0] out_sig
		.cout(modexpocout) 	// output  cout_sig
	);
	
	tenbitmux tenbitmux_shiftermux
	(
		.A(B[9:0]) ,	// input [9:0] A_sig
		.B(A[9:0]) ,	// input [9:0] B_sig
		.select(modexpocout) ,	// input  select_sig
		.out(smuxout) 	// output [9:0] out_sig
	);
	assign shiftermuxout = {1'b1,smuxout};

	tenbitmux tenbitmux_addermux
	(
		.A(A[9:0]) ,	// input [9:0] A_sig
		.B(B[9:0]) ,	// input [9:0] B_sig
		.select(modexpocout) ,	// input  select_sig
		.out(amuxout) 	// output [9:0] out_sig
	);
	assign addermuxout = {1'b1,amuxout};
	
		
	fivebitmux expoincmux
	(
		.A(A[14:10]) ,	// input [4:0] A_sig
		.B(B[14:10]) ,	// input [4:0] B_sig
		.select(modexpocout) ,	// input  select_sig
		.out(expoincmuxout) 	// output [4:0] out_sig
	);
	
	BarrelShifter MantissaRightShifter
	(
		.A(shiftermuxout) ,	// input [10:0] A_sig
		.B(modexposubout) ,	// input [4:0] B_sig
		.Y(mantissarsout) 	// output [10:0] Y_sig
	);
	
	Subtractor Subtractor_inst
	(
		.A(addermuxout) ,	// input [10:0] A_sig
		.B(mantissarsout) ,	// input [10:0] B_sig
		.cin(1'b1) ,	// input  cin_sig
		.cout(addercout) ,	// output  cout_sig
		.R(adderout) 	// output [10:0] R_sig
	);
	
	logic [3:0] leadingzeros;

	always_comb begin
		 leadingzeros = 4'd11;
		 for (integer i = 10; i >= 0; i = i - 1) begin
			  if (adderout[i] && leadingzeros == 4'd11) begin
					leadingzeros = 4'd11 - (i+1'b1);
			  end
		 end
	end
	ExponentSubtractor ExponentSubtractor_inst
	(
		.A(expoincmuxout) ,	// input [4:0] A_sig
		.B(leadingzeros) ,	// input [3:0] B_sig
		.exponent(Exponent), 	// output [4:0] exponent_sig
		.cout(exponentsubtractorcout)
	);

	BarrelShifterLeft MantissaNormalizerLeft_inst
	(
		.A(adderout) ,	// input [10:0] A_sig
		.B(leadingzeros) ,	// input [4:0] B_sig
		.Y(Mantissa) 	// output [10:0] Y_sig
	);
	
endmodule