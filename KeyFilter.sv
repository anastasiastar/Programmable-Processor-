//Anastasia Staroverova
//Ajay Matto
//Teces 330 Course Project
//This module is the key filter needed to follow the button sync 
//Allows at most 10 output signals per second with a 50MHz clock

module KeyFilter (Clk, In,Out);
	input Clk;// System Clock
	input In;// Input Signal
	output logic Out; //A filter version of In

	localparam DUR= 5_000_000-1;
	logic [32:0] Countdown=0;

	always @(posedge Clk) begin

		Out<=0;
		if(Countdown==0) begin
			if(In) begin
				Out<=1;
				Countdown<=DUR;
			end
		end
		else begin
			Countdown<=Countdown-1;
		end
	end
endmodule 
