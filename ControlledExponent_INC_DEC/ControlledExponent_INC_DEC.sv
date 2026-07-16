//Controlled Exponent Increment and Decrement(Top Level)
module ControlledExponent_INC_DEC
(
	input [4:0] A,
	input select,cin,
	output [4:0] exponent
);

	logic [5:0] C;
	assign C[0] = cin;

	FullAdder FullAdder_instS0(.ai(A[0]) ,.bi(select ^ cin) ,.cini(C[0]) ,.si(exponent[0]) ,.couti(C[1]));
	FullAdder FullAdder_instS1(.ai(A[1]) ,.bi(cin ^ 1'b0) ,.cini(C[1]) ,.si(exponent[1]) ,.couti(C[2]));
	FullAdder FullAdder_instS2(.ai(A[2]) ,.bi(cin ^ 1'b0) ,.cini(C[2]) ,.si(exponent[2]) ,.couti(C[3]));
	FullAdder FullAdder_instS3(.ai(A[3]) ,.bi(cin ^ 1'b0) ,.cini(C[3]) ,.si(exponent[3]) ,.couti(C[4]));
	FullAdder FullAdder_instS4(.ai(A[4]) ,.bi(cin ^ 1'b0) ,.cini(C[4]) ,.si(exponent[4]) ,.couti(C[5]));
	
endmodule