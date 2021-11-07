`timescale 1ns / 1ps

module lab4W_tb();

reg clk;
wire cout;
//wire [7:0] value;

lab4W t1(.clk(clk),.cout(cout));

// Test taken from EECS 3201 Lab5 tutorial given by proffesor Andrew

always
begin
   clk = 1'b1;
	#10;
	clk = 1'b0;
	#10;
end

//always @(posedge clk)
//begin
    
    //if (r == 4'b0000)
	    //$display("All outputs are zero");
	 
//end


endmodule