//Half Precision FLoating Point Adder/Subtractor Top Level module - DE10 Implementaton
module HalfPrecisionFPAdder
(
	input clk,
	input reset,
	input [3:0] row,
	output [3:0] col,
	output logic [3:0] CAT,
	output logic [0:6] SEG,
	input key2,key3,key4,
	output Overflow, Underflow
);

	logic [15:0] BCDSM,Result;
	logic [31:0] Y;
	logic MuxRate, CounterCLK;
	logic [3:0] HEX0, HEX1, HEX2, HEX3;
	logic value, trig;
	logic [4:0] Exponent;
	logic [9:0] Mantissa;
	logic [15:0] A_reg, B_reg;
	

	keypad_input #(.DIGITS(4)) keypad_input_inst
	(
		.clk(clk),
		.reset(reset),
		.row(row),
		.col(col),
		.out(BCDSM),
		.value(value),
		.trig(trig)
	);

		
	ClockLadder ClockLadder_inst
	(
		.clock(clk) ,	// input  clock_sig
		.clear(reset) ,	// input  clear_sig
		.Y(Y) 	// output [31:0] Y_sig
	);
	assign CounterCLK = Y[22];
	assign MuxRate = Y[17];
	
	logic [1:0] displaysel;

	always_ff @(posedge clk, negedge reset) begin
		 if(!reset) begin
			  A_reg <= 0;
			  B_reg <= 0;
			  displaysel <= 2'b11;
		 end
		 else if(!key2) begin
			  A_reg <= BCDSM;
			  displaysel <= 2'b00;
		 end
		 else if(!key3) begin
			  B_reg <= BCDSM;
			  displaysel <= 2'b01;
		 end
		 else if(!key4) begin
			  displaysel <= 2'b10;
		 end
	end
	
	logic [15:0] Aout, Bout;
	logic addsub;
	logic sign;
	CU CU_inst
	(
		.A(A_reg) ,	// input [15:0] A_sig
		.B(B_reg) ,	// input [15:0] B_sig
		.Aout(Aout) ,	// output [15:0] Aout_sig
		.Bout(Bout) ,	// output [15:0] Bout_sig
		.addsub(addsub), 	// output  addsub_sig
		.sign(sign)
	);
	
	logic [4:0] ExponentSub, ExponentAdd;
	logic [9:0] MantissaAdd, MantissaSub;
	logic UA;
	HPFPSubtractor HPFPSubtractor_inst
	(
		.A(Aout) ,	// input [15:0] A_sig
		.B(Bout) ,	// input [15:0] B_sig
		.Exponent(ExponentSub) ,	// output [4:0] Exponent_sig
		.Mantissa(MantissaSub), 	// output [9:0] Mantissa_sig
		.exponentsubtractorcout(exponentsubtractorcout)
	);
	
	HPFPAdder HPFPAdder_inst
	(
		.A(Aout) ,	// input [15:0] A_sig
		.B(Bout) ,	// input [15:0] B_sig
		.Exponent(ExponentAdd) ,	// output [4:0] Exponent_sig
		.Mantissa(MantissaAdd) 	// output [9:0] Mantissa_sig
	);

	assign Exponent = addsub ? ExponentSub : ExponentAdd;
	assign Mantissa = addsub ? MantissaSub : MantissaAdd;
	logic OE,UE;
	
	OverflowUnderflow OverflowUnderflow_inst
	(
		.EA(A_reg[14:10]) ,	// input [4:0] EA_sig
		.EB(B_reg[14:10]) ,	// input [4:0] EB_sig
		.finalmantissa(Mantissa) ,	// input [9:0] finalmantissa_sig
		.finalexponent(Exponent) ,	// input [5:0] finalexponent_sig
		.exponentsubtractorcout(exponentsubtractorcout) ,	// input  exponentsubtractorcout_sig
		.Overflow(OE) ,	// output  Overflow_sig
		.Underflow(UE) 	// output  Underflow_sig
	);
	
	assign Overflow  = addsub ? 1'b0 : OE;
	assign Underflow = addsub ? UE : 1'b0;
	
	logic [15:0] Resulttemp;
	
	always_comb begin
		if(Overflow)
			Resulttemp = {sign,5'b11111,10'b0000000000};
		else if (Underflow)
			Resulttemp = {sign,5'b00000,10'b0000000000};
		else
			Resulttemp = {sign,Exponent,Mantissa};
	end
	
	
	assign Result = Resulttemp;
	logic [15:0] display;
	
	always_comb begin
		case(displaysel)
			2'b00: display = A_reg;
			2'b01: display = B_reg;
			2'b10: display = Result;
			default: display = BCDSM;
		endcase
	end
	
	
	assign HEX0 = display[3:0];
	assign HEX1 = display[7:4];
	assign HEX2 = display[11:8];
	assign HEX3 = display[15:12];
		
	Multi7segdisplay Multi7segdisplay_inst
	(
		.HEX0(HEX0) ,	// input [3:0] HEX0_sig
		.HEX1(HEX1) ,	// input [3:0] HEX1_sig
		.HEX2(HEX2) ,	// input [3:0] HEX2_sig
		.HEX3(HEX3) ,	// input [3:0] HEX3_sig
		.CLK(MuxRate) ,	// input  CLK_sig
		.Reset(reset) ,	// input  Reset_sig
		.Load(CounterCLK) ,	// input  Load_sig
		.SEG(SEG) ,	// output [0:6] SEG_sig
		.CAT(CAT) 	// output [3:0] CAT_sig
	);
	
endmodule