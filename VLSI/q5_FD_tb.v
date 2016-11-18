`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 5
Circuit: FD

Implements circuit:

out = (a&c | b&~c) & c

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-0 hazard.

There are many such transitions as can be seen in the simulation; this test bench tries all Perm(8, 2) transitions to idenify hazards.

*/ /////////////////////////////////////////////////////////////////////////////////

module q5_FD_tb;

	// Inputs
	reg a;
	reg b;
	reg c;
	
	integer i, j;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	q5_FD uut (
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

