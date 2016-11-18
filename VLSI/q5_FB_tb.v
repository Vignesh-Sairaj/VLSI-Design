`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 5 (Test Bench)
Circuit: FB

Implements circuit:

out = (~c & ~a) | b&c

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-1 hazard.

Hazardous Transition:

{a, b, c} : 011 -> 010

*/ /////////////////////////////////////////////////////////////////////////////////

module q5_FB_tb;

	// Inputs
	reg a;
	reg b;
	reg c;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	q5_FB uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		c = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		a=0; b=1; c=1;
		
		#20 
			
		a=0; b=1; c=0;

		#20

		a=0; b=1; c=1;
		
		#20

		a=0; b=1; c=0;

		#20 $finish;
			
		// Add stimulus here

	end
      
endmodule

