//Anastasia Staroverova
//Ajay Matto
//TECES 330 Spring 2021
//Course Project
//This is the PC module that acts like a counter

module PC(Clock, Clr, Up, Im_Out);

	input Clock, Clr, Up;
	output logic [6:0] Im_Out=0;
	
	always_ff @(posedge Clock) begin
		if (Clr) Im_Out <= 0;
		else begin
			if (Up) Im_Out <= Im_Out + 1'b1;
			else Im_Out <= Im_Out;
		end
	end

endmodule

// testbench
module PC_tb();

	logic Clock,Clr, Up;
	logic [6:0] Im_Out;
	
	PC DUT(Clock, Clr, Up, Im_Out);
	
	time Start, Delta;
	
	always begin  	
		Clock = 0;  	
		#10;  	
		Clock = 1;  	
		#10;  
	end
	initial begin 
		Clr = 0;
		for(int i=0;i<15;i++)begin
			{Up}=i;
			#10;
		end
		Clr = 1; #20;
	$stop;
	end
	  initial
        $monitor($time,,,Up,,,Im_Out);
	

endmodule 