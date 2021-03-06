// Anastasia Staroverova & Ajay Matto
// TCES 330, Spring 2021
// 5/13/2021
// Project
// 2 to 1 mux module for Project

module Mux_2_to_1(R_data, ALU_Q, RF_s, W_data);
	input [15:0] R_data, ALU_Q; 
	input RF_s;
	output [15:0] W_data;
	assign W_data = (RF_s)?R_data:ALU_Q;
endmodule

//testbench
module Mux_2_to_1_tb();
	reg [15:0] R_data, ALU_Q;
	reg RF_s;
	wire [15:0] W_data;
	Mux_2_to_1 dut(R_data, ALU_Q, RF_s, W_data);
	initial begin
		for (int i = 0; i < 60; i++) begin
			R_data = $urandom();
			ALU_Q = $urandom();
			RF_s = $urandom();
			#10;
		end
		$stop;
	end
	initial
	$monitor ($time,,, "R_data = %d \t ALU_Q = %d \t RF_s = %b \t W_data = %d \t", R_data, ALU_Q, RF_s, W_data);
endmodule