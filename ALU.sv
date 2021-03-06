// Anastasia Staroverova & Ajay Matto
// TCES 330, Spring 2021
// 5/13/2021
// Project
// ALU module for Project

module ALU(A, B, Sel, Q);
	input [2:0] Sel;
	input [15:0] A, B;
	output logic [15:0] Q;
	always @(*) begin
		case(Sel)
			0: Q = 0;
			1: Q = A + B;
			2: Q = A - B;
			3: Q = A;
			4: Q = A ^ B;
			5: Q = A | B;
			6: Q = A & B;
			7: Q = A + 1'b1;
			default: Q = 0;
		endcase
	end
endmodule

//testbench
module ALU_tb();
	logic [2:0] Sel;
	logic [15:0] A, B;
	logic [15:0] Q;
	ALU DUT(A, B, Sel, Q);
	initial begin
		for(int i = 0; i < 8; i++) begin
			{Sel} = i;
			A = $urandom_range(30000);
			B = $urandom_range(30000);
			#10;
		end 
	end
	initial $monitor($time,,," Sel = %d", Sel,,, " A = %d", A,,, " B = %d", B,,, " Q = %d", Q);
endmodule