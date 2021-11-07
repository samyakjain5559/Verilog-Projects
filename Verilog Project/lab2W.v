`timescale 1ps/1ps
module lab2W(clk,Q);

input clk;
output Q;

reg [2:0] Q;
reg enable;
initial	Q = 3'b000;
initial	enable = 1'b1;

reg[31:0] count = 32'd0;
parameter D = 32'd50000000;  // decrease little to slow

// Refrence for clock devider and counter taken from EECS 3201 lecture and lab 4 , Fall 2020
always @(posedge clk)
begin
	count <= count + 32'd1;
	if (count >= D-1)  // Q is updated every sec ie after counting till 50 million
	begin
		 count <= 32'd0;
		 
		 if (Q == 3'b000)
		 begin
		     enable <= 1;
			  Q <= 3'b001;
		 end
		 else if(enable == 1 && Q < 3'b111) 
		     Q <= Q + 1'b1;
		 else
		 begin
		     Q <= Q - 1'b1;
			  enable <= 0;
		 end
	end
end

   assign cout = (count < D/2) ? 1'b0 : 1'b1;  // increase little to slow


endmodule
