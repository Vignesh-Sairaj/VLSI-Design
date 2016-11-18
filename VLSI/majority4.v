`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 1

4-bit Majority

Returns True iff at least 3 of the given inputs are True 

*/ /////////////////////////////////////////////////////////////////////////////////
module majority4(
    input a,
    input b,
    input c,
    input d,
    output out
    );
	 
	 assign out = a&b&c | b&c&d | c&d&a | d&a&b;
endmodule
