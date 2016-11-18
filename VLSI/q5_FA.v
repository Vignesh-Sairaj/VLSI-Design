`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 5
Circuit: FA

Implements circuit:

out = a&c ! b&~c

Delay only given at NOT gate as that is the only gate that causes the static-1 hazard.

*/ /////////////////////////////////////////////////////////////////////////////////

module q5_FA(
    input a,
    input b,
    input c,
    output out
    );

	wire ac;
	wire cN;
	wire bcN;
	
	assign ac = a&c;
	
	assign #2 cN = ~c;
	
	assign bcN = b&cN;
	
	assign out = ac | bcN;

endmodule
