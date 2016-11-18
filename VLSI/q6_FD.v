`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 6
Circuit: FD

Implements circuit:

out = (a&c | b&~c) & c

Correction: Circuit changed to it's logical equivalent: a&c
This avoids the ANDing of c & ~c which causes the static-0 hazard.

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-0 hazard.

*/ /////////////////////////////////////////////////////////////////////////////////
module q6_FD(
    input a,
    input b,
    input c,
    output out
    );

	assign out = a&c;

endmodule
