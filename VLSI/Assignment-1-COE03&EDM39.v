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



`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 2

Even-counter

If reset is 1 at posedge clk, output is reset to 0.
If reset is 0, output periodically counts up by 2 units starting at 0 every clock-cycle.
When reset is changed from 1->0, the counter starts counting from 0 the next from the subsequent posedge of clock.

*/ /////////////////////////////////////////////////////////////////////////////////
module evenCounter(
    input clk,
    input reset,
    output reg [2:0] count
    );
	 reg flag = 0;

	always @ (posedge clk) begin
	
		if (~reset) begin
		
			if(flag) begin
				count[0] <= count[0];
				count[1] <= ~count[1];
				count[2] <= (count[2] ^ count[1]);
			end
			
			else begin
				flag <= 1'b1;
			end
		end
		
		else begin
			count <= 3'b0;
			flag <= 1'b0;
		end
	end

endmodule



`timescale 1ns / 1ps
/*/////////////////////////////////////////////////////////////////////////////////

Question: 3

Count 1's

Counts number of ones in given 8-bit number

*//////////////////////////////////////////////////////////////////////////////////
module count1s8(
    input [7:0] value,
    output [3:0] numOnes
    );
	
	assign numOnes = value[0] + value[1] + value[2] + value[3] + value[4] + value[5] + value[6] + value[7];

endmodule



`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 4

Up/Down Ring-Counter

If reset is 1 at posedge clk, output is reset to 0.
If reset is 0 and en (enable) is 1, output periodically shifts (left)/(right) by 1 bit when up_dnN is (1)/(0) starting at 1 every clock-cycle.
If reset is 0 and en is also 0, the output stays at previous value until the next posedge clk.
When reset is changed from 1->0 and en is 1, the counter starts shifting left/right from 1 the next from the subsequent posedge of clock.

*/ /////////////////////////////////////////////////////////////////////////////////
module counter_updown8(
    input clk,
    input reset,
    input en,
    input up_dnN,
    output reg [7:0] count
    );
	 
	 
	 

	reg flag = 0;

	always @ (posedge clk) begin
	
		if (~reset) begin
		
			if(flag) begin
				if(en) begin
					if(up_dnN) begin
						count <= {count[6:0], count[7]};
					end
					
					else begin
						count <= {count[0], count[7:1]};
					end
				end
			end
			
			else begin
				flag <= 1'b1;
			end
		end
		
		else begin
			count <= 8'b00000001;
			flag <= 1'b0;
		end
	end



endmodule



`timescale 1ns / 1ps

/* ///////////////////////////////////////////////////////////////////////////////
Question: 4 (Test Bench)

Up/Down Ring-Counter

If reset is 1 at posedge clk, output is reset to 0.
If reset is 0 and en (enable) is 1, output periodically shifts (left)/(right) by 1 bit when up_dnN is (1)/(0) starting at 1 every clock-cycle.
If reset is 0 and en is also 0, the output stays at previous value until the next posedge clk.
When reset is changed from 1->0 and en is 1, the counter starts shifting left/right from 1 the next from the subsequent posedge of clock.
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




`timescale 1ns / 1ps

/* /////////////////////////////////////////////////////////////////////////////////

Question: 5
Circuit: FA

Implements circuit:

out = a&c ! b&~c

Delay only given at NOT gate as that is the only gate that causes the static-1 hazard.

*/ /////////////////////////////////////////////////////////////////////////////////

module q5_FA(
    input a,
    input b,
    input c,
    output out
    );

	wire ac;
	wire cN;
	wire bcN;
	
	assign ac = a&c;
	
	assign #2 cN = ~c;
	
	assign bcN = b&cN;
	
	assign out = ac | bcN;

endmodule



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




`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 5
Circuit: FB

Implements circuit:

out = (~c & ~a) | b&c

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-1 hazard.

*/ /////////////////////////////////////////////////////////////////////////////////
module q5_FB(
    input a,
    input b,
    input c,
    output out
    );
wire cNaN,bc,cN,aN;

assign #2 cN=~c;
assign #2 aN=~a;

assign cNaN=cN&aN;
assign bc=b&c;

assign out=cNaN | bc;

endmodule


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




`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 6
Circuit: FA

Implements circuit:

out = a&c ! b&~c

Delay only given at NOT gate as that is the only gate that causes the static-1 hazard.

Correction: add term a&b to SOP.

*/ /////////////////////////////////////////////////////////////////////////////////
module q6_FA(
    input a,
    input b,
    input c,
    output out
    );

	wire ac;
	wire cN;
	wire bcN;
	wire ab;
	
	assign ac = a&c;
	
	assign #2 cN = ~c;
	
	assign bcN = b&cN;
	
	assign ab = a&b;
	
	assign out = ac | bcN | ab;


endmodule



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




`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 6
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



`timescale 1ns / 1ps
/* /////////////////////////////////////////////////////////////////////////////////

Question: 6 (Test Bench)
Circuit: FB

Implements circuit:

out = (~c & ~a) | b&c

Correction: added term a&~b

Delay only given at NOT gate(s) as that(those) is(are) the only gate(s) that causes(cause) the static-1 hazard.

Hazardous Transition:

{a, b, c} : 011 -> 010

*/ /////////////////////////////////////////////////////////////////////////////////


module q6_FB_tb;

	// Inputs
	reg a;
	reg b;
	reg c;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	q6_FB uut (
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
		
		       
		a=0; b=1; c=1;
		
		#20 
			
		a=0; b=1; c=0;

		#20

		a=0; b=1; c=1;
		
		#20

		a=0; b=1; c=0;

		#20 $finish;

	end
      
endmodule


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






