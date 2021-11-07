
module render(
	input clk, reset,
	input sw,
	input indisplayinterval,
	input square_on,
	output [11:0]rgb,
	input [8:0] switches
	);
	
	reg [11:0] rgb_reg;
	
	always @(posedge clk)
	begin
			if(square_on)
			begin
				rgb_reg[11] = 1'b0;
				rgb_reg[7] = 1'b0;
				rgb_reg[3] = 1'b0;
				
				rgb_reg[10:8] = switches[8:6];
				rgb_reg[6:4] = switches[5:3];
				rgb_reg[2:0] = switches[2:0];
				
				//rgb_reg <= 12'b000011110000; //red
			end
			else
				rgb_reg <= 12'b111111111111;
			//end
	end
	
	assign rgb = (indisplayinterval) ? rgb_reg : 12'b000000000000;
	
endmodule

