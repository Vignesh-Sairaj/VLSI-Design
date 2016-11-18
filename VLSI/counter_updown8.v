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
