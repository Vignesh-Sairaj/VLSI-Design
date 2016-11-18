`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 6
Circuit: FD

Implements circuit:

out = (a&c | b&~c) & c

Correction: Circuit changed to it's logical equivalent: a&c
This avoids the ANDing of c & ~c which causes the static-0 hazard.

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-0 hazard.

This test bench tries all Perm(8, 2) transitions to idenify hazards; None were found.

*/ /////////////////////////////////////////////////////////////////////////////////

module q6_FD_tb;

	// Inputs
	reg a;
	reg b;
	reg c;

	// Outputs
	wire out;
	
	integer i,j;

	// Instantiate the Unit Under Test (UUT)
	q6_FD uut (
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
		
		for(i = 1; i < 2**3; i=i+1) begin
			for(j = 0; j < 2**3; j=j+1) begin
				
				#7 {a, b, c} = j;
				#7 {a, b, c} = j+i;
				
			end
		end
		
		#7 $finish;
		
		/*
		for(j = 0; j < 2**3; j=j+1) begin
			#7 {a, b, c} = j;
		end
		#7 $finish;
		
		#7 {a, b, c} = 3'b101;
		#7 {a, b, c} = 3'b111;
		#7 {a, b, c} = 3'b101;
		#7 $finish;
		*/
	end
      
endmodule

