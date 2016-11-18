`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 5
Circuit: FB

Implements circuit:

out = (~c & ~a) | b&c

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-1 hazard.

Correction: added term a&~b

*/ /////////////////////////////////////////////////////////////////////////////////
module q6_FB(
    input a,
    input b,
    input c,
    output out
    );
	 
	wire cNaN,bc,cN,aN,aNb;
		 
	assign #2 cN=~c;
	assign #2 aN=~a;

	assign cNaN=cN&aN;
	assign bc=b&c;
	assign aNb = aN&b;

	assign out=cNaN | bc | aNb;

endmodule
