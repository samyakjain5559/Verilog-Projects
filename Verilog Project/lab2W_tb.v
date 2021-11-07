`timescale 1ns / 1ps

module lab2W_tb();

reg clk;
wire [2:0]Q;

lab2W t1(.clk(clk),.Q(Q));

// Test taken from EECS 3201 Lab5 tutorial given by proffesor Andrew

always
begin
   clk = 1'b1;
	#10;
	clk = 1'b0;
	#10;
end


endmodule