//Anastasia Staroverova
//Ajay Matto
//TECES 330
//Course Project
//This module instances the IR,PC,FSM and instruction memory

module Control(Clk,Rst, PC_Out, IR_Out, OutState, NextState, D_Addr, D_Wr,
				RF_s, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, RF_W_Addr,Alu_s0);

	input Clk, Rst;
	output [6:0] PC_Out;
	output [15:0] IR_Out;
	output [3:0] OutState, NextState;
	output [7:0] D_Addr;
	output D_Wr;
	output RF_s;
	output [3:0] RF_W_Addr;
	output RF_W_en;
	output [3:0] RF_Ra_Addr;
	output [3:0] RF_Rb_Addr;
	output [2:0] Alu_s0;
	
	logic PC_clr, PC_up, IR_Id;
	logic [6:0] PC_Hold;
	logic [15:0] IR_In, IR_Hold;
	
	assign PC_Out = PC_Hold;
	assign IR_Out = IR_Hold;
	//InstructionMemory (address,clock,q);
	InstructionMemory Inst(PC_Hold, Clk, IR_In);
	
	//module PC(Clock, Clr, Up, Im_Out);
	PC Count(Clk, PC_clr, PC_up, PC_Hold);
	
	//module IR(Clock,Id,instruction,OutFSM);
	IR instr (Clk, IR_Id, IR_In, IR_Hold);
	
	//module FSM(Clk,Rst,IR,OutState,OutNext,PC_clr,PC_up,IR_Id,D_addr,D_wr,RF_s,RF_W_addr,RF_W_en,RF_Ra_addr,RF_Rb_addr,Alu_s0);
	FSM SM(Clk, Rst, IR_Hold, OutState, NextState, PC_clr, PC_up, IR_Id, D_Addr,D_Wr, RF_s, RF_W_Addr, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, Alu_s0);
endmodule


//testbench
`timescale 1ns/1ns
module Control_tb();
	logic Clk, Rst;
	logic [6:0] PC_Out;
	logic [15:0] IR_Out;
	logic [3:0] OutState, NextState;
	logic [7:0] D_Addr;
	logic D_Wr;
	logic RF_s;
	logic [3:0] RF_W_Addr;
	logic RF_W_en;
	logic [3:0] RF_Ra_Addr;
	logic [3:0] RF_Rb_Addr;
	logic [2:0] Alu_s0;
	
	Control DUT (Clk,Rst, PC_Out, IR_Out, OutState, NextState, D_Addr, D_Wr,
				RF_s, RF_W_en, RF_Ra_Addr, RF_Rb_Addr, RF_W_Addr,Alu_s0);

	//clock
	always begin
		Clk = 0; #10;
		Clk = 1; #10;
	end
	initial begin 
		Rst = 1; #810;
		Rst = 0; #40;
		$stop;
	end
	initial 
	$monitor($time,,, "Reset =%d   PC_out=%d   IR_out=%d   OutState=%d   NextState=%d   D_Addr=%d   D_Wr=%d  RF_s=%d   RF_W_Addr=%d   RF_W_en=%d   RF_Ra_Addr=%d   RF_Rb_Addrn=%d   ALU_so=%d  ",
			Rst,PC_Out,IR_Out,OutState,NextState,D_Addr,
			  D_Wr,RF_s,RF_W_Addr,RF_W_en,RF_Ra_Addr,RF_Rb_Addr,Alu_s0);
endmodule 