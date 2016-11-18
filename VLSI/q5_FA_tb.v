`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 5  (Test Bench)
Circuit: FA

Implements circuit:
out = a&c ! b&~c

Delay only given at NOT gate as that is the only gate that causes the static-1 hazard.

Hazardous Transition:

{a, b, c} : 111 -> 110

*/ /////////////////////////////////////////////////////////////////////////////////

module q5_FA_tb;

	// Inputs
	reg a;
	reg b;
	reg c;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	q5_FA uut (
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
		
		a = 1; b = 1; c = 1;
		# 10;
		a = 1; b = 1; c = 0;
		#20;
		$finish;

	end
      
endmodule

