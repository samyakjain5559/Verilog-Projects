`timescale 1ns / 100ps

module lab5W_tb();

reg clk;
reg rst,s;
wire [7:0] hex1,hex2,hexdecimal;
//wire [3:0] tdisp,decimalcount;

lab5W t1(.s(s),.clk(clk),.rst(rst),.hex1(hex1),.hex2(hex2),.hexdecimal(hexdecimal));
//lab5W t1(.s(s),.clk(clk),.rst(rst),.tdisp(tdisp),.decimalcount(decimalcount));

// Test taken from EECS 3201 Lab5 tutorial given by proffesor Andrew

always
begin
   clk = 1'b1;
	#10;
	clk = 1'b0;
	#10;
end

initial
begin
	
	s = 1;
	rst = 0;
	#10;
	
	s = 0;
	rst = 1;
	#2000000000;
	
	s=0;
	#2000000000;
end

//always @(posedge clk)
//begin
    
    //if (r == 4'b0000)
	    //$display("All outputs are zero");
	 
//end


endmodule