`timescale 1ps/1ps
module lab3Wtest(clk,out0,out1,out2,out3,out4,out5,s0,s1,period,tsecond);

input clk;
input s0,s1;
output out0,out1,out2,out3,out4,out5,period,tsecond;

reg [2:0] state = 0;
reg out0,out1,out2,out3,out4,out5;
reg period ;
reg [3:0] tsecond = 0; 
reg[31:0] count = 0;
parameter D = 32'd25000000; 
//parameter D = 32'd50; 
always @(posedge clk)
begin
	//count <= count + 32'd1;
	
	if (count == 50000000) begin   // Changed for debug
		period <= 0;
		count <= 0;
	end else if(count == 25000000) begin
		period <= 1;
		count <= count + 1;
	end else begin
		count <= count + 1;
	end
	
end

//assign cout = (count < D/2) ? 1'b0 : 1'b1;  

always @(posedge period)
begin
   case(state) 
	
	    3'b000: begin 
                 out0 = 1'b0;              // main green for 10 sec and sec red for 10
					  out1 = 1'b0;
					  out2 = 1'b1;
					  out3 = 1'b1;
					  out4 = 1'b0;
					  out5 = 1'b0;
					  if (tsecond >= 2)
					  begin
						  tsecond = 0;
						  state = 3'b001;
					  end
       end		
		 
		 3'b001: begin
		          out0 = 1'b0;
				    out1 = 1'b1;
				    out2 = 1'b0;
				    out3 = 1'b0;
				    out4 = 1'b0;
				    out5 = 1'b0;
		 end
	
	endcase
	
	tsecond = tsecond + 1;
end

endmodule