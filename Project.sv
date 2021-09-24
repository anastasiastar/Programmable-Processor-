// Anastasia Staroverova & Ajay Matto
// TCES 330, Spring 2021
// 5/13/2021
// Project
// Project module for Project

module Project(CLOCK_50, SW, KEY, LEDG, LEDR, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [17:0] SW;
	input CLOCK_50;
	input [3:0] KEY;
	output [3:0] LEDG;
	output [17:0] LEDR;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	assign LEDR = SW;
	assign LEDG = ~KEY;
	logic [15:0] IR_Out, ALU_A, ALU_B, ALU_Out;
	logic [6:0] PC_Out;
	logic [3:0] State, NextState;
	logic [7:0] longState, longNextState;
	assign longState = {4'b0000, State};
	assign longNextState = {4'b0000, NextState};
	logic [15:0] X0, X4, MUXOut;
	assign X0 = {PC_Out, longState};
	assign X4 = {8'b00000000, longNextState};
	logic syncout;
	logic filterout;
	
	//ButtonSyncRegReg (Clk, Bi, Bo);
	ButtonSyncRegReg sync(CLOCK_50, KEY[2], syncout);
	
	//KeyFilter (Clk, In,Out);
	KeyFilter filter(CLOCK_50, syncout, filterout);
	
	//Processor      (Clk, Reset, IR_Out, PC_Out, State, NextState, ALU_A, ALU_B, ALU_Out);
	Processor process(filterout, KEY[1], IR_Out, PC_Out, State, NextState, ALU_A, ALU_B, ALU_Out);
	
	//Mux_3w_8_to_1(S2, S1, S0, X1, X2, X3, X4, X5, X6, X7, X8, Y);
	Mux_3w_8_to_1 themux(SW[17], SW[16], SW[15], X0, ALU_A, ALU_B, ALU_Out, X4, 16'h0, 16'h0, 16'h0, MUXOut);
	
	//Decoder(C, Hex);
	Decoder hex7(MUXOut[15:12], HEX7);
	Decoder hex4(MUXOut[3:0], HEX4);
	Decoder hex5(MUXOut[7:4], HEX5);
	Decoder hex6(MUXOut[11:8], HEX6);
	Decoder hex0(IR_Out[3:0], HEX0);
	Decoder hex1(IR_Out[7:4], HEX1);
	Decoder hex2(IR_Out[11:8], HEX2);
	Decoder hex3(IR_Out[15:12], HEX3);
endmodule 