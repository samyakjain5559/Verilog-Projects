`timescale 1ps/1ps
module lab5W(s,clk,rst,hex1,hex2,hexdecimal);

input clk;
input rst,s;
output [7:0]hex1,hex2,hexdecimal;
//output [3:0] decimalcount,tdisp;

//reg [7:0]hexdecimal = 8'b11111111;
reg [7:0]hex2 = 8'b11111111;
reg [2:0] state;
initial	state = 3'b000;
reg [3:0] Q;
reg [3:0]decimalcount;
initial	Q = 4'b0000;  // initial zero
reg b = 1'b0;   // bool for greater than 10 true
reg bhold = 1'b0; // bool for if holding more than 0.5 sec
reg [3:0] tdisp = 0; 
reg[31:0] count = 0;
//parameter D = 32'd50000000;   
parameter D = 32'd25000000;  // 0.5 sec clock

always @(posedge clk)
begin
	count <= count + 32'd1;
	if (count >= D-1)  // state is chnaging at 3 seconds (1 sec extra for counting to 50 million)
	begin
		 count <= 32'd0; 
		 
		 if((rst == 1'b0))  // push0 is active low
		 begin
		    Q = 4'b0000;
			 tdisp = 4'b0000;
			 state <= 3'b000;
			 b = 1'b0;  // set greater than 10 false
			 hex2 = 8'b11111111;
			 bhold = 1'b0;
			 //hexdecimal = 8'b11111111;
			 decimalcount = 4'b0000;
		 end
		 
		 if((tdisp == 4'b101) && (b == 1'b1))
		 begin
		    Q = 4'b0000;
			 tdisp = 4'b0000;
			 b = 1'b0;  // set greater than 10 false
			 hex2 = 8'b11111111;
		 end
		 
		 case(state) 
	
			 3'b000: begin      // should I add counter for 1 clock cycle to check if button is held?
				       
						  if (Q >= 4'b0100)      // chnage after 2 seconds (keep 1 less) which 4 as 0.5 sec clock
						  begin
							  
							  if (rst == 1'b0)
							  begin
							      Q = 4'b0000;
									tdisp = 4'b0000;
									state <= 3'b000;
									b = 1'b0;  // set greater than 10 false
									hex2 = 8'b11111111;
									bhold = 1'b0;
									//hexdecimal = 8'b11111111;
									decimalcount = 4'b0000;
							  end
							  else
							  begin
							      state <= 3'b001;
							      Q = 4'b0000;
							  end
							  
						  end
						  else
						  begin
						  
						     if(s == 1'b1)
							  begin
							      bhold = 1'b0;  // refresh if not hold
									Q = 4'b0000;
							  end
						     
							  if (rst == 1'b0)
							  begin
							      
							      Q = 4'b0000;
									tdisp = 4'b0000;
									state <= 3'b000;
									b = 1'b0;  // set greater than 10 false
									hex2 = 8'b11111111;
									bhold = 1'b0;
									//hexdecimal = 8'b11111111;
									decimalcount = 4'b0000;
							  end
							  else if(s == 1'b0 && (bhold == 1'b0))
							  begin
							      bhold = 1'b1;
						         state <= 3'b000;       // specify this for next iteration
							      Q = Q + 1'b1;
									if(tdisp >= 4'b1001 && decimalcount >= 4'b0101)
									begin
									   tdisp = tdisp - 4'b1001;
										b = 1'b1;  // set greater than 10 true
										hex2 = 8'b11111001;
										//decimalcount = decimalcount + 4'b0101;
										decimalcount = 4'b0000;
									end
							      else
							      begin		
									   decimalcount = decimalcount + 4'b0101;
										
										if (decimalcount > 4'b0101)
										begin
										  tdisp = tdisp + 1'b1;
										  decimalcount = 4'b0000;
										end
									end  
							  end
							  else
							  begin
							      state <= 3'b000;   // here Q is not changed
									Q = Q + 1'b1;      // reset 2 sec count but disp is same
									//bhold = 1'b0;
							  end
						  end
			 end		
			 
			 3'b001: begin

						  if (s == 1'b1)  // if button not pressed
						  begin
							  
							  if (rst == 1'b0)
							  begin
							      
							      Q = 4'b0000;
									tdisp = 4'b0000;
									state <= 3'b000;
									b = 1'b0;  // set greater than 10 false
									hex2 = 8'b11111111;
									bhold = 1'b0;
									//hexdecimal = 8'b11111111;
									decimalcount = 4'b0000;
							  end
							  else
							  begin
							      
							      state <= 3'b000;  // no tdisp as its continuing
							      Q = 3'b000;
									bhold = 1'b0;
							  end
							  
						  end
						  else if(s == 1'b0) // button pushed
						  begin
						  
						     if (rst == 1'b0)
							  begin
							      
							      Q = 4'b0000;
									tdisp = 4'b0000;
									state <= 3'b000;
									b = 1'b0;  // set greater than 10 false
									hex2 = 8'b11111111;
									bhold = 1'b0;
									decimalcount = 4'b0000;
							  end
							  else
							  begin
						         state <= 3'b001;
							      if(tdisp >= 4'b1001 && decimalcount >= 4'b0101)
									begin
									   tdisp = tdisp - 4'b1001;
										b = 1'b1;  // set greater than 10 true
										hex2 = 8'b11111001;
										//decimalcount = decimalcount + 4'b0101;
										decimalcount = 4'b0000;
									end
							      else		
									begin
									   decimalcount = decimalcount + 4'b0101;
										
										if (decimalcount > 4'b0101)
										begin
										  tdisp = tdisp + 1'b1;
										  decimalcount = 4'b0000;
										end
									end
							  end
						  end
			 end
			 
			 default : begin       
			             
								   state <= 3'b000;
							      Q = 4'b0000;
								   tdisp = 4'b0001;	
									
			 end
		
	    endcase
		 //tsecond <= tsecond + 1;
	end
	
end

//assign cout = (count < D/2) ? 1'b0 : 1'b1; 

   Lab1 l0(tdisp[3:0],hex1);

	Lab1 l1(decimalcount[3:0],hexdecimal);

endmodule


// hex display from lab 2 of EECS 3201 Fall 2020
module Lab1(a,seg);

   input [0:3]a;
   output [0:6]seg;
	hex1 zero(seg,a);
	
endmodule

module hex1(out,H);

  input  [3:0] H;
  output [6:0]out;

	assign out[0] = (~H[3]&~H[2]&~H[1]&H[0])|(~H[3]&H[2]&~H[1]&~H[0])|(H[3]&~H[2]&H[1]&H[0])|(H[3]&H[2]&~H[1]&H[0]);
	assign out[1] = (~H[3]&H[2]&~H[1]&H[0])|(~H[3]&H[2]&H[1]&~H[0])|(H[3]&~H[2]&H[1]&H[0])|(H[3]&H[2]&~H[1]&~H[0])|(H[3]&H[2]&H[1]&~H[0])|(H[3]&H[2]&H[1]&H[0]);
	assign out[2] = (~H[3]&~H[2]&H[1]&~H[0])|(H[3]&H[2]&~H[1]&~H[0])|(H[3]&H[2]&H[1]&~H[0])|(H[3]&H[2]&H[1]&H[0]);
	assign out[3] = (~H[3]&~H[2]&~H[1]&H[0])|(~H[3]&H[2]&~H[1]&~H[0])|(~H[3]&H[2]&H[1]&H[0])|(H[3]&~H[2]&~H[1]&H[0])|(H[3]&~H[2]&H[1]&~H[0])|(H[3]&H[2]&H[1]&H[0]);
	assign out[4] = (~H[3]&~H[2]&~H[1]&H[0])|(~H[3]&~H[2]&H[1]&H[0])|(~H[3]&H[2]&~H[1]&~H[0])|(~H[3]&H[2]&~H[1]&H[0])|(~H[3]&H[2]&H[1]&H[0])|(H[3]&~H[2]&~H[1]&H[0]);
	assign out[5] = (~H[3]&~H[2]&~H[1]&H[0])|(~H[3]&~H[2]&H[1]&~H[0])|(~H[3]&~H[2]&H[1]&H[0])|(~H[3]&H[2]&H[1]&H[0])|(H[3]&H[2]&~H[1]&H[0]);
	assign out[6] = (~H[3]&~H[2]&~H[1]&~H[0])|(~H[3]&~H[2]&~H[1]&H[0])|(~H[3]&H[2]&H[1]&H[0])|(H[3]&H[2]&~H[1]&~H[0]);
   //assign out[7] = 1'b1;

endmodule
