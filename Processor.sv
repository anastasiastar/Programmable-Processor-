// Anastasia Staroverova & Ajay Matto
// TCES 330, Spring 2021
// 5/13/2021
// Project
// Processor module for Project

module Processor(Clk, Reset, IR_Out, PC_Out, State, NextState, ALU_A, ALU_B, ALU_Out);
	input Clk, Reset;
	output logic [15:0] IR_Out, ALU_A, ALU_B, ALU_Out;
	output [6:0] PC_Out;
	output [3:0] State, NextState;
	logic D_Wr, RF_s, RF_W_en;
	logic [7:0] D_Addr;
	logic [3:0] RF_W_Addr, RF_Ra_Addr, RF_Rb_Addr;
	logic [2:0] ALU_s0;
	
	//Control  (Clk,Rst, PC_Out, IR_Out, OutState, NextState, D_Addr, D_Wr,RF_s, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, RF_W_Addr,Alu_s0);
	Control con(Clk,Reset, PC_Out, IR_Out, State, NextState, D_Addr, D_Wr, RF_s, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, RF_W_Addr,ALU_s0);
	
	//Datapath   (clk, D_Addr, D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, ALU_s0, ALU_inA, ALU_inB, ALU_out);
	Datapath data(Clk, D_Addr, D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, ALU_s0, ALU_A, ALU_B, ALU_Out);
endmodule 