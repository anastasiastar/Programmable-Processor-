// TCES330 Spring 2021 
// Inclass example 04/27
// decoder to display 4-bit number 
// Hexadecimal digits from 0-9, 
// A - F on 7-segment display
// write a 0 to turn on a segment
// write a 1 to turn off a segment

module Decoder(C, Hex);

	input [3:0] C;
	output logic [0:6] Hex;
	
	always @*
	
			case(C)
			0: Hex = 7'b0000001; 
			1: Hex = 7'b1001111;
			2: Hex = 7'b0010010;
			3: Hex = 7'b0000110;
			4: Hex = 7'b1001100; 
			5: Hex = 7'b0100100;
			6: Hex = 7'b0100000;
			7: Hex = 7'b0001111;
			8: Hex = 7'b0000000; 
			9: Hex = 7'b0001100;
			10: Hex = 7'b0001000; //A
			11: Hex = 7'b1100000; //b
			12: Hex = 7'b0110001; //C 
			13: Hex = 7'b1000010; //d
			14: Hex = 7'b0110000; //E
			15: Hex = 7'b0111000; //F
			
			endcase

endmodule
