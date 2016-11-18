`timescale 1ns / 1ps

/* ///////////////////////////////////////////////////////////////////////////////

Q4 Test Bench

*/ ///////////////////////////////////////////////////////////////////////////////

module counter_updown8_tb;

	// Inputs
	reg clk;
	reg reset;
	reg en;
	reg up_dnN;

	// Outputs
	wire [7:0] count;

	// Instantiate the Unit Under Test (UUT)
	counter_updown8 uut (
		.clk(clk), 
		.reset(reset), 
		.en(en), 
		.up_dnN(up_dnN), 
		.count(count)
	);

	initial begin
		// Initialize Inputs
		clk = 1'b0;
		reset = 1'b1;
		en = 1'b0;
		up_dnN = 1'b0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		reset = 1'b0;
		#10 en = 1'b1;
		#100 up_dnN = 1'b1;
		#100 en = 1'b0;
		#50;
		$finish;
		
	end
	
	always begin
		#5 clk = ~clk;
	end
      
endmodule

