//Anastasia Staroverova
//Ajay Matto
//Teces330
//Course Project
// This module is the IR one needed for the project.
// It is a group of flip flops which latch out the input signal 

module IR(Clock,Id,instruction,OutFSM);
	input Clock,Id;
	input [15:0] instruction;
	output logic [15:0] OutFSM;
	always_ff @(posedge Clock) begin
		if(Id) OutFSM<=instruction;
		else OutFSM<=OutFSM;
	end
endmodule 