//PIPO register
module PIPO
(
	input [3:0] D,
	input CLK,CLR,
	output logic [3:0] Q
);
	always_ff @ (posedge CLK, negedge CLR)
		begin
			if(CLR==1'b0) Q <= 0;
				else if(CLK==1'b1) Q <= D;
		end
endmodule