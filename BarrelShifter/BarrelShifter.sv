//Right Barrel Shifter
module BarrelShifter (

	input [10:0] A,
	input [4:0] B,
	output [10:0] Y
);


	logic [10:0] V,U,W,X;
	
	//B4
	Mux Mux_inst0(.A(1'b0) ,.B(A[0]) ,.S(B[4]) ,.Out(U[0]));
	Mux Mux_inst1(.A(1'b0) ,.B(A[1]) ,.S(B[4]) ,.Out(U[1]));
	Mux Mux_inst2(.A(1'b0) ,.B(A[2]) ,.S(B[4]) ,.Out(U[2]));
	Mux Mux_inst3(.A(1'b0) ,.B(A[3]) ,.S(B[4]) ,.Out(U[3]));
	Mux Mux_inst4(.A(1'b0) ,.B(A[4]) ,.S(B[4]) ,.Out(U[4]));
	Mux Mux_inst5(.A(1'b0) ,.B(A[5]) ,.S(B[4]) ,.Out(U[5]));
	Mux Mux_inst6(.A(1'b0) ,.B(A[6]) ,.S(B[4]) ,.Out(U[6]));
	Mux Mux_inst7(.A(1'b0) ,.B(A[7]) ,.S(B[4]) ,.Out(U[7]));
	Mux Mux_inst8(.A(1'b0) ,.B(A[8]) ,.S(B[4]) ,.Out(U[8]));
	Mux Mux_inst9(.A(1'b0) ,.B(A[9]) ,.S(B[4]) ,.Out(U[9]));
	Mux Mux_instA(.A(1'b0) ,.B(A[10]) ,.S(B[4]) ,.Out(U[10]));
	
	//B3
	Mux Mux_instB(.A(U[8]) ,.B(U[0]) ,.S(B[3]) ,.Out(V[0]));
	Mux Mux_instC(.A(U[9]) ,.B(U[1]) ,.S(B[3]) ,.Out(V[1]));
	Mux Mux_instD(.A(U[10]) ,.B(U[2]) ,.S(B[3]) ,.Out(V[2]));
	Mux Mux_instE(.A(1'b0) ,.B(U[3]) ,.S(B[3]) ,.Out(V[3]));
	Mux Mux_instF(.A(1'b0) ,.B(U[4]) ,.S(B[3]) ,.Out(V[4]));
	Mux Mux_inst00(.A(1'b0) ,.B(U[5]) ,.S(B[3]) ,.Out(V[5]));
	Mux Mux_inst01(.A(1'b0) ,.B(U[6]) ,.S(B[3]) ,.Out(V[6]));
	Mux Mux_inst02(.A(1'b0) ,.B(U[7]) ,.S(B[3]) ,.Out(V[7]));
	Mux Mux_inst03(.A(1'b0) ,.B(U[8]) ,.S(B[3]) ,.Out(V[8]));
	Mux Mux_inst04(.A(1'b0) ,.B(U[9]) ,.S(B[3]) ,.Out(V[9]));
	Mux Mux_inst05(.A(1'b0) ,.B(U[10]) ,.S(B[3]) ,.Out(V[10]));

	//B2
	Mux Mux_inst06(.A(V[4]) ,.B(V[0]) ,.S(B[2]) ,.Out(W[0]));
	Mux Mux_inst07(.A(V[5]) ,.B(V[1]) ,.S(B[2]) ,.Out(W[1]));
	Mux Mux_inst08(.A(V[6]) ,.B(V[2]) ,.S(B[2]) ,.Out(W[2]));
	Mux Mux_inst09(.A(V[7]) ,.B(V[3]) ,.S(B[2]) ,.Out(W[3]));
	Mux Mux_inst0A(.A(V[8]) ,.B(V[4]) ,.S(B[2]) ,.Out(W[4]));
	Mux Mux_inst0B(.A(V[9]) ,.B(V[5]) ,.S(B[2]) ,.Out(W[5]));
	Mux Mux_inst0C(.A(V[10]) ,.B(V[6]) ,.S(B[2]) ,.Out(W[6]));
	Mux Mux_inst0D(.A(1'b0) ,.B(V[7]) ,.S(B[2]) ,.Out(W[7]));
	Mux Mux_inst0E(.A(1'b0) ,.B(V[8]) ,.S(B[2]) ,.Out(W[8]));
	Mux Mux_inst0F(.A(1'b0) ,.B(V[9]) ,.S(B[2]) ,.Out(W[9]));
	Mux Mux_inst10(.A(1'b0) ,.B(V[10]) ,.S(B[2]) ,.Out(W[10]));

	//B1
	Mux Mux_inst11(.A(W[2]) ,.B(W[0]) ,.S(B[1]) ,.Out(X[0]));
	Mux Mux_inst12(.A(W[3]) ,.B(W[1]) ,.S(B[1]) ,.Out(X[1]));
	Mux Mux_inst13(.A(W[4]) ,.B(W[2]) ,.S(B[1]) ,.Out(X[2]));
	Mux Mux_inst14(.A(W[5]) ,.B(W[3]) ,.S(B[1]) ,.Out(X[3]));
	Mux Mux_inst15(.A(W[6]) ,.B(W[4]) ,.S(B[1]) ,.Out(X[4]));
	Mux Mux_inst16(.A(W[7]) ,.B(W[5]) ,.S(B[1]) ,.Out(X[5]));
	Mux Mux_inst17(.A(W[8]) ,.B(W[6]) ,.S(B[1]) ,.Out(X[6]));
	Mux Mux_inst18(.A(W[9]) ,.B(W[7]) ,.S(B[1]) ,.Out(X[7]));
	Mux Mux_inst19(.A(W[10]) ,.B(W[8]) ,.S(B[1]) ,.Out(X[8]));
	Mux Mux_inst1A(.A(1'b0) ,.B(W[9]) ,.S(B[1]) ,.Out(X[9]));
	Mux Mux_inst1B(.A(1'b0) ,.B(W[10]) ,.S(B[1]) ,.Out(X[10]));

	//B0
	Mux Mux_inst1C(.A(X[1]) ,.B(X[0]) ,.S(B[0]) ,.Out(Y[0]));
	Mux Mux_inst1D(.A(X[2]) ,.B(X[1]) ,.S(B[0]) ,.Out(Y[1]));
	Mux Mux_inst1E(.A(X[3]) ,.B(X[2]) ,.S(B[0]) ,.Out(Y[2]));
	Mux Mux_inst1F(.A(X[4]) ,.B(X[3]) ,.S(B[0]) ,.Out(Y[3]));
	Mux Mux_inst100(.A(X[5]) ,.B(X[4]) ,.S(B[0]) ,.Out(Y[4]));
	Mux Mux_inst101(.A(X[6]) ,.B(X[5]) ,.S(B[0]) ,.Out(Y[5]));
	Mux Mux_inst102(.A(X[7]) ,.B(X[6]) ,.S(B[0]) ,.Out(Y[6]));
	Mux Mux_inst103(.A(X[8]) ,.B(X[7]) ,.S(B[0]) ,.Out(Y[7]));
	Mux Mux_inst104(.A(X[9]) ,.B(X[8]) ,.S(B[0]) ,.Out(Y[8]));
	Mux Mux_inst105(.A(X[10]) ,.B(X[9]) ,.S(B[0]) ,.Out(Y[9]));
	Mux Mux_inst106(.A(1'b0) ,.B(X[10]) ,.S(B[0]) ,.Out(Y[10]));
	
endmodule