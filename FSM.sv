//Anastasia Staroverova
//Ajay Matto
//Course Project
//Tces 330 Spring 2021
//This module describes the controller FSM and the map given
//

module FSM(Clk,Rst,IR,OutState,OutNext,PC_clr,PC_up,IR_Ld,D_addr,
			  D_wr,RF_s,RF_W_addr,RF_W_en,RF_Ra_addr,RF_Rb_addr,Alu_s0);
	input Clk, Rst;   //system clock and reset 
	input [15:0] IR; 
	//output logic [3:0] OutState, OutNext;
	//Control lines 
	output logic PC_clr, PC_up, IR_Ld;//Program Counter(PC) clear command,PC increment,Instruction Load
	output logic [7:0] D_addr;	  //Data memory adress 8bits
	output logic D_wr;		  // Data memory write enable 
	output logic RF_s;		  // Mux select Line
	output logic [3:0] RF_W_addr;    //Register file write adress 4 bits 
	output logic RF_W_en;            //Register File wrie enable 
	output logic [3:0] RF_Ra_addr;   //Register file A-side read adress 4 bits
	output logic [3:0] RF_Rb_addr;   //Register file B-side read adress 4 bits
	output logic [2:0] Alu_s0;	 //ALI function select 3 bits 
	//local param
	localparam Init=4'b0000,
			Fetch=4'b0001,
			Decode=4'b0010,
			NOOP= 4'b0011,
			Load_A= 4'b0100,
			Load_B= 4'b0101,
			STORE= 4'b0110,
			ADD= 4'b0111,
			SUB=4'b1000,
			HALT=4'b1001;
	output [3:0] OutState, OutNext;
	logic [3:0] CurrentState= Init,NextState;
	assign OutState = CurrentState;
	assign OutNext = NextState;
	always_comb begin
 		PC_clr = 0;//setting all inital values to 0
		PC_up = 0;
		IR_Ld = 0;
		D_addr = 0;
		D_wr = 0;
		RF_s = 0;
		RF_W_addr = 0;
		RF_W_en = 0;
		RF_Ra_addr = 0;
		RF_Rb_addr = 0;
		Alu_s0 = 0; 
	//NextState = CurrentState;
	case (CurrentState)
		Init: begin
			PC_clr=1;
			NextState=Fetch;
		end
		Fetch: begin
			IR_Ld=1;
			PC_up=1;
			NextState=Decode;
		end
		Decode:begin
			if (IR[15:12] == 4'b0000) NextState = NOOP;
			else if (IR[15:12] == 4'b0010) NextState = Load_A;
			else if (IR[15:12] == 4'b0001) NextState = STORE; 
			else if (IR[15:12] == 4'b0011) NextState = ADD; 
			else if (IR[15:12] == 4'b0100) NextState = SUB; 
			else if (IR[15:12] == 4'b0101) NextState = HALT;
			else NextState = Init;
		end
		NOOP: NextState=Fetch;

		Load_A: begin
			D_addr=IR[11:4];
			RF_s=1;
			RF_W_addr=IR[3:0];
			NextState=Load_B;
		end
		Load_B: begin 
			D_addr=IR[11:4];
			RF_s=1;
			RF_W_addr=IR[3:0];
			RF_W_en=1;
			NextState=Fetch;
		end
		STORE: begin
			D_addr=IR[7:0];
			D_wr=1;
			RF_Ra_addr=IR[11:8];
			NextState=Fetch;
		end
		ADD: begin
			RF_W_addr = IR[3:0];
			RF_W_en = 1;
			RF_Ra_addr=IR[11:8];
			RF_Rb_addr = IR[7:4];
			Alu_s0 = 1;
			RF_s = 0;
			NextState = Fetch;
		end
		SUB:begin
			RF_W_addr=IR[3:0];
			RF_W_en=1;
			RF_Ra_addr=IR[11:8];
			RF_Rb_addr=IR[7:4];
			Alu_s0=2;
			RF_s=0;
			NextState=Fetch;
		end
		HALT: NextState=HALT;
		default: NextState=Init;
	endcase
	end //always end 
	//StateReg using non blocking
	always_ff@(posedge Clk) begin
		if (!Rst) begin
			CurrentState<=Init;
		end else begin
			CurrentState<=NextState;
		end
	end 
endmodule 

//testbench
`timescale 1ns/1ns
module FSM_tb();
	logic Clk, Rst;   //system clock and reset 
	logic [15:0] IR; 
	logic [3:0] OutState, OutNext;
	//Control lines 
	logic PC_clr, PC_up, IR_Ld;
	logic [7:0] D_addr;	  
	logic D_wr;		   
	logic RF_s;		  
	logic [3:0] RF_W_addr;    
	logic RF_W_en;           
	logic [3:0] RF_Ra_addr;   
	logic [3:0] RF_Rb_addr;   
	logic [2:0] Alu_s0;	 
	FSM dut(Clk,Rst,IR,OutState,OutNext,PC_clr,PC_up,IR_Ld,D_addr,
			  D_wr,RF_s,RF_W_addr,RF_W_en,RF_Ra_addr,RF_Rb_addr,Alu_s0);
	always begin
		Clk=0; #10;
		Clk=1; #10;
	end //always end 

	initial begin
		Rst = 1; IR[15:12] = 4'b0000; IR[11:0] = $urandom(); #63;
			 IR[15:12] = 4'b0001; IR[11:0] = $urandom(); #60;
			 IR[15:12] = 4'b0010; IR[11:0] = $urandom(); #90;
			 IR[15:12] = 4'b0011; IR[11:0] = $urandom(); #60;
			 IR[15:12] = 4'b0100; IR[11:0] = $urandom(); #60;
			 IR[15:12] = 4'b0101; IR[11:0] = $urandom(); #60;
		Rst = 0; #30;
		$stop;
	end
	initial 
	//$monitor($time,,, "Clock=%d   Reset =%d   IR=%b   OutNext=%d   OutState=%d   PC_clr=%d   PC_up=%d   IR_Ld=%d   D_addr=%d   D_wr=%d   RF_s=%d   RF_W_addr=%d   RF_W_en=%d   RF_Ra_addr=%d   RF_Rb_addr=%d   Alu_s0=%d  CurrentState=%d",Clk,Rst,IR,OutNext,OutState,PC_clr,PC_up,IR_Ld,D_addr,
		//	  D_wr,RF_s,RF_W_addr,RF_W_en,RF_Ra_addr,RF_Rb_addr,Alu_s0,dut.CurrentState);
	$monitor($time,,, "Clock=%d   Reset =%d   IR=%b   OutNext=%d   OutState=%d   PC_clr=%d   PC_up=%d   IR_Ld=%d   D_addr=%d   D_wr=%d   RF_s=%d   RF_W_addr=%d   RF_W_en=%d   RF_Ra_addr=%d   RF_Rb_addr=%d   CurrentState=%d",Clk,Rst,IR,OutNext,OutState,PC_clr,PC_up,IR_Ld,D_addr,
			  D_wr,RF_s,RF_W_addr,RF_W_en,RF_Ra_addr,RF_Rb_addr,dut.CurrentState);
endmodule 