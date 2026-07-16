//Half Precision Floating Point Adder
module HPFPAdder
(
	input [15:0] A,B,
	output [4:0] Exponent,
	output [9:0] Mantissa
);

	logic [4:0] modexposubout, expoincmuxout;
	logic modexpocout;
	logic [9:0] smuxout, amuxout;
	logic [10:0]  shiftermuxout, mantissarsout, addermuxout;
	logic [10:0] adderout;
	logic addercout;


	ModularExponentSub #(.N(5)) ModularExponentSub_inst
	(
		.A(B[14:10]) ,	// input [(N-1):0] A_sig
		.B(A[14:10]) ,	// input [(N-1):0] B_sig
		.out(modexposubout) ,	// output [(N-1):0] out_sig
		.cout(modexpocout) 	// output  cout_sig
	);
	
	tenbitmux tenbitmux_shiftermux
	(
		.A(A[9:0]) ,	// input [9:0] A_sig
		.B(B[9:0]) ,	// input [9:0] B_sig
		.select(modexpocout) ,	// input  select_sig
		.out(smuxout) 	// output [9:0] out_sig
	);
	assign shiftermuxout = {1'b1,smuxout};

	tenbitmux tenbitmux_addermux
	(
		.A(B[9:0]) ,	// input [9:0] A_sig
		.B(A[9:0]) ,	// input [9:0] B_sig
		.select(modexpocout) ,	// input  select_sig
		.out(amuxout) 	// output [9:0] out_sig
	);
	assign addermuxout = {1'b1,amuxout};
	
		
	fivebitmux expoincmux
	(
		.A(B[14:10]) ,	// input [4:0] A_sig
		.B(A[14:10]) ,	// input [4:0] B_sig
		.select(modexpocout) ,	// input  select_sig
		.out(expoincmuxout) 	// output [4:0] out_sig
	);
	
	BarrelShifter MantissaRightShifter
	(
		.A(shiftermuxout) ,	// input [10:0] A_sig
		.B(modexposubout) ,	// input [4:0] B_sig
		.Y(mantissarsout) 	// output [10:0] Y_sig
	);

	CSA CSA_inst
	(
		.A(mantissarsout) ,	// input [10:0] A_sig
		.B(addermuxout) ,	// input [10:0] B_sig
		.Cin(1'b0) ,	// input  Cin_sig
		.Sum(adderout) ,	// output [10:0] Sum_sig
		.Cout(addercout) 	// output  Cout_sig
	);
	
	logic select;
	
	always_comb begin
		if(addercout)
			select = 1'b1;
		else
			select = 1'b0;
		end
	
	ControlledExponent_INC_DEC ControlledExponent_INC_DEC_inst
	(
		.A(expoincmuxout) ,	// input [4:0] A_sig
		.select(select) ,	// input  select_sig
		.cin(~addercout) ,	// input  cin_sig
		.exponent(Exponent) 	// output [4:0] exponent_sig
	);
	

	MantissaNormalizer MantissaNormalizer_inst
	(
		.A(adderout) ,	// input [10:0] A_sig
		.select(addercout) ,	// input  select_sig
		.mantissa(Mantissa) 	// output [9:0] mantissa_sig
	);
	
endmodule

