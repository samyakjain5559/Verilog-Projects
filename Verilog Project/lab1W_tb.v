`timescale 1ns / 1ps

module lab1W_tb();

reg clk;
reg s0,s1,s2;
wire cout;

lab1W t1(.clk(clk),.s0(s0),.s1(s1),.s2(s2),.cout(cout));

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

   s2 = 0;  // 44.84 percent duty cycle
	s1 = 1;
	s0 = 1;
	 #500000;
	 
	s2 = 0;   // 32.84 percent duty
	s1 = 1;
	s0 = 0;
	 #500000;
	 
	s2 = 1;   // 67 percent duty
	s1 = 0;
	s0 = 1;
	 #500000;
	 
	s2 = 0;   // 21.42 percent duty
	s1 = 0;
	s0 = 1;
	 #500000;
	
end

//always @(posedge clk)
//begin
    
    //if (r == 4'b0000)
	    //$display("All outputs are zero");
	 
//end


endmodule