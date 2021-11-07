`timescale 1ns / 100ps

module lab3W_tb();

reg clk;
reg rst,request;
wire [5:0] light;
wire [7:0] sevseg;

trafficlight t1(.rst(rst),.request(request),.clk(clk),.light(light),.sevseg(sevseg));

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
	
	request = 1;  // active low as push button
	rst = 0;
	#10
	
	request = 0;
	rst = 1;
	
end

//always @(posedge clk)
//begin
    
    //if (r == 4'b0000)
	    //$display("All outputs are zero");
	 
//end


endmodule