`timescale 1ns / 1ps
/*/////////////////////////////////////////////////////////////////////////////////

Question: 3

Count 1's

Counts number of ones in given 8-bit number

*//////////////////////////////////////////////////////////////////////////////////
module count1s8(
    input [7:0] value,
    output [3:0] numOnes
    );
	
	assign numOnes = value[0] + value[1] + value[2] + value[3] + value[4] + value[5] + value[6] + value[7];

endmodule
