`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 4
Circuit: FA

Implements circuit:

out = a&c ! b&~c

Delay only given at NOT gate as that is the only gate that causes the static-1 hazard.

Correction: add term a&b to SOP.

*/ /////////////////////////////////////////////////////////////////////////////////
module q6_FA(
    input a,
    input b,
    input c,
    output out
    );

	wire ac;
	wire cN;
	wire bcN;
	wire ab;
	
	assign ac = a&c;
	
	assign #2 cN = ~c;
	
	assign bcN = b&cN;
	
	assign ab = a&b;
	
	assign out = ac | bcN | ab;


endmodule
