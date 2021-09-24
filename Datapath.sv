// Anastasia Staroverova & Ajay Matto
// TCES 330, Spring 2021
// 5/13/2021
// Project
// Datapath module for Project

module Datapath(clk, D_Addr, D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, ALU_s0, ALU_inA, ALU_inB, ALU_out);
	input clk, D_Wr, RF_s, RF_W_en;
	input [7:0] D_Addr;
	input [3:0] RF_W_Addr, RF_Ra_Addr, RF_Rb_Addr;
	input [2:0] ALU_s0;
	wire [15:0] RaData, RbData, Rout;
	output logic [15:0] ALU_inA, ALU_inB, ALU_out;
	logic [15:0] R_data, W_Data;
	//DataMemory      (address, clock, data, wren, q);
	DataMemory Datamem(D_Addr, clk, RaData, D_Wr, R_data);
	//Mux_2_to_1  (R_data, ALU_Q, RF_s, W_data);
	Mux_2_to_1 Mux(R_data, Rout, RF_s, W_Data);
	//regfile16x16a      (clk, RF_W_en, RF_W_addr, W_Data, RF_Ra_addr, Ra_data, RF_Rb_addr, Rb_data);
	regfile16x16a Regfile(clk, RF_W_en, RF_W_Addr, W_Data, RF_Ra_Addr, RaData, RF_Rb_Addr, RbData);
	//ALU (A, B, Sel, Q);
	ALU Aludata(RaData, RbData, ALU_s0, Rout);
	assign ALU_inA = RaData;
	assign ALU_inB = RbData;
	assign ALU_out = Rout;
endmodule

//testbench
`timescale 1ns/1ns
module Datapath_tb();
	logic clk, D_Wr, RF_s, RF_W_en;
	logic [7:0] D_Addr;
	logic [3:0] RF_W_Addr, RF_Ra_Addr, RF_Rb_Addr;
	logic [2:0] ALU_s0;
	logic [15:0] ALU_inA, ALU_inB, ALU_out;
	Datapath DUT(clk, D_Addr, D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, ALU_s0, ALU_inA, ALU_inB, ALU_out);
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end
	initial begin
		//load Reg[1] = Dmem[0B] = 52229 = CC05 	0B=11
		D_Addr = 8'h0B; D_Wr = 1'b0; RF_s = 1'b1; RF_W_Addr = 4'd1; RF_W_en=1'b1; RF_Ra_Addr = 4'd1; RF_Rb_Addr = 4'd1; ALU_s0=3'b000; #120; 		//load Reg[2] = Dmem[1B] = 437 = 01B5	 	1B=27
		D_Addr = 8'h1B; D_Wr = 1'b0; RF_s = 1'b1; RF_W_Addr = 4'd2; RF_W_en=1'b1; RF_Ra_Addr = 4'd2; RF_Rb_Addr = 4'd2; ALU_s0=3'b000; #120;
		//load Reg[4] = Dmem[06] = 4268 = 10AC		 06=6
		D_Addr = 8'h06; D_Wr = 1'b0; RF_s = 1'b1; RF_W_Addr = 4'd4; RF_W_en=1'b1; RF_Ra_Addr = 4'd4; RF_Rb_Addr = 4'd4; ALU_s0=3'b000; #120;
		//load Reg[5] = Dmem[8A] = 41024 = A040         8A=138
		D_Addr = 8'h8A; D_Wr = 1'b0; RF_s = 1'b1; RF_W_Addr = 4'd5; RF_W_en=1'b1; RF_Ra_Addr = 4'd5; RF_Rb_Addr = 4'd5; ALU_s0=3'b000; #120;		//sub Reg[3]=Reg[1] - Reg[2]	51792 = 52229 - 437 
		D_Addr = 8'h00; D_Wr = 1'b0; RF_s = 1'b0; RF_W_Addr = 4'd3; RF_W_en=1'b1; RF_Ra_Addr = 4'd1; RF_Rb_Addr = 4'd2; ALU_s0=3'b010; #120;
		//add  Reg[6]=Reg[4] + Reg[5]	 45292 = 4268 + 41024
		D_Addr = 8'h00; D_Wr = 1'b0; RF_s = 1'b0; RF_W_Addr = 4'd6; RF_W_en=1'b1; RF_Ra_Addr = 4'd4; RF_Rb_Addr = 4'd5; ALU_s0=3'b001; #120;
		//add Reg[0]=Reg[3] + Reg[6]     97084 = 51792 + 45292
		D_Addr = 8'h00; D_Wr = 1'b0; RF_s = 1'b0; RF_W_Addr = 4'd0; RF_W_en=1'b1; RF_Ra_Addr = 4'd3; RF_Rb_Addr = 4'd6; ALU_s0=3'b001; #120;
		//store D[CD]=Reg[0] = 97084             CD=205
		D_Addr = 8'hCD; D_Wr = 1'b1; RF_s = 1'b0; RF_W_Addr = 4'd0; RF_W_en=1'b0; RF_Ra_Addr = 4'd0; RF_Rb_Addr = 4'd0; ALU_s0=3'b000; #120; 
		$stop;
	end
	initial $monitor($time,,, "D_Addr = %d \t D_Wr = %d \t RF_s = %d \t RF_W_Addr = %d \t RF_W_en = %d \t RF_Ra_Addr = %d \t RF_Rb_Addr = %d \t ALU_s0 = %d \t ALU_inA = %d \t ALU_inB = %d \t ALU_out = %d \t R_data = %d \t W_Data = %d", D_Addr, D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, ALU_s0, ALU_inA, ALU_inB, ALU_out, DUT.R_data, DUT.W_Data);
endmodule 