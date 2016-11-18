`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 6  (Test Bench)
Circuit: FA

Implements circuit:
out = a&c ! b&~c

Corrected for hazard.
Delay only given at NOT gate as that is the only gate that causes the static-1 hazard.

Hazardous Transition:

{a, b, c} : 111 -> 110

*/ /////////////////////////////////////////////////////////////////////////////////

module q6_FA_tb;

	// Inputs
	reg a;
	reg b;
	reg c;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	q6_FA uut (
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
        
		// Add stimulus here
		a = 1; b = 1; c = 0;
		# 10;
		a = 1; b = 1; c = 1;
		#10;
		a = 1; b = 1; c = 0;
		#10;
		$finish;

	end
      
endmodule

