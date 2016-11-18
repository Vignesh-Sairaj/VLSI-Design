`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 5
Circuit: FD

Implements circuit:

out = (a&c | b&~c) & c

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-0 hazard.

*/ /////////////////////////////////////////////////////////////////////////////////

module q5_FD(
    input a,
    input b,
    input c,
    output out
    );
wire cN,ac,bcN,FS;

assign #2 cN=~c;
assign ac=a&c;
assign bcN= b&cN;
assign FS = ac | bcN;
assign out=FS & c;


endmodule
