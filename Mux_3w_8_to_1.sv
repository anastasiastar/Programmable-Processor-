// Ajay Matto
// TCES 330, Spring 2021
// 4/20/2021
// Lab 4
// Mux_3w_8_to_1 module for Lab 4

module Mux_3w_8_to_1(S2, S1, S0, X1, X2, X3, X4, X5, X6, X7, X8, Y); 
	input S2, S1, S0;
	input [15:0] X1, X2, X3, X4, X5, X6, X7, X8;
	output logic [15:0] Y;
	
	always @* begin
		case({S2, S1, S0})
			0:  Y = X1;
			1:  Y = X2;
			2:  Y = X3;
			3:  Y = X4;
			4:  Y = X5;
			5:  Y = X6;
			6:  Y = X7;
			7:  Y = X8;
		endcase
	end
endmodule 

module Mux_3w_8_to_1_tb();
	logic S2, S1, S0;
	logic [15:0] X1, X2, X3, X4, X5, X6, X7, X8;
	logic [15:0] Y;
	Mux_3w_8_to_1 dut(S2, S1, S0, X1, X2, X3, X4, X5, X6, X7, X8, Y);
	initial begin
		for(int i = 0; i < 7; i++) begin
			{S2, S1, S0} = i;
			X1[15:0] = 0; X2[15:0] = 0; X3[15:0] = 0; X4[15:0] = 0; X5[15:0] = 0; X6[15:0] = 0; X7[15:0] = 0; X8[15:0] = 0;
			#10;
		end 
		for(int k = 0; k < 7; k++) begin
			{S2, S1, S0} = k;
			X1[15:0] = 1; X2[15:0] = 1; X3[15:0] = 1; X4[15:0] = 1; X5[15:0] = 1; X6[15:0] = 1; X7[15:0] = 1; X8[15:0] = 1;
			#10;
		end 
		for(int j = 0; j < 500; j++) begin
			{S2, S1, S0} = $urandom;
			X1 = $urandom();
			X2 = $urandom();
			X3 = $urandom();
			X4 = $urandom();
			X5 = $urandom();
			X6 = $urandom();
			X7 = $urandom();
			X8 = $urandom();
			#10;
			$display ($time,,, "%b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t", S2, S1, S0, X1, X2, X3, X4, X5, X6, X7, X8, Y);
		end
		//$stop;
	end
endmodule 