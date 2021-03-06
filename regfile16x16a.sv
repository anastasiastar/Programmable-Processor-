// Anastasia Staroverova & Ajay Matto
// TCES 330, Spring 2021
// 5/13/2021
// Project
// RegFile module for Project

module regfile16x16a(input clk,         //system clock
		input RF_W_en,           // write enable 
		input [3:0] RF_W_addr,   //write adress
		input [15:0] W_Data,   //write data
		input [3:0] RF_Ra_addr,  // A-side read adress
		output[15:0] Ra_data,  // A-side read data
		input [3:0] RF_Rb_addr,  // B-side read adress
		output[15:0] Rb_data);  // B-side read data
	
	logic [15:0] regfile [0:15]; //registers

	///read the registers
	assign Ra_data = regfile[RF_Ra_addr];
	assign Rb_data = regfile[RF_Rb_addr];
	always @(posedge clk) begin
		if(RF_W_en) regfile[RF_W_addr] <= W_Data;
	end
endmodule 

//testbench
`timescale 1ns/1ns
module regfile16x16a_tb();
	logic clk, RF_W_en;
	logic [3:0] RF_W_addr;
	logic [15:0] W_Data;
	logic [3:0] RF_Ra_addr; 
	logic [15:0] Ra_data;  
	logic [3:0] RF_Rb_addr;  
	logic [15:0] Rb_data;  
	regfile16x16a dut(clk, RF_W_en, RF_W_addr, W_Data, RF_Ra_addr, Ra_data, RF_Rb_addr, Rb_data);
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end
	initial begin
		RF_W_en = 1;
   		for(int i = 0; i < 16; i++) begin
			RF_W_addr = i; 
			RF_Ra_addr = i; 
			RF_Rb_addr = i; //#10;
			//for(int j = 0; j < 5; j++) begin
			W_Data = $urandom(); #23;
				//RF_Ra_addr = $urandom(); #10;
				//RF_Rb_addr = $urandom(); #10;
			//end
		end
		$stop;
	end
	initial $monitor($time,,, " RF_W_en = %b", RF_W_en,,, " RF_W_addr = %d", RF_W_addr,,, " W_Data = %d", W_Data,,, " RF_Ra_addr = %d", RF_Ra_addr,,, " Ra_data = %d", Ra_data,,, " RF_Rb_addr = %d", RF_Rb_addr,,, " Rb_data = %d", Rb_data);
endmodule 
