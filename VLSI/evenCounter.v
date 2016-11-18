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
