`timescale 1ps/1ps
module trafficlight(input rst,input request,input clk,output reg [5:0] light,output reg [7:0] sevseg);

//input clk;
//input s0,s1;
//output out0,out1,out2,out3,out4,out5;
//output [0:6]hex0;

reg [2:0] state;
initial	state = 3'b000;
reg [3:0] Q;
//initial Q = (request == 1 && (Q > 4'b0101)) ? 4'b0101 : 4'b1010;
initial	Q = 4'b1010;
//reg out0,out1,out2,out3,out4,out5;
//initial light[3] = 1'b0;  // main red
//initial light[4] = 1'b0;
//initial light[5] = 1'b1;
//initial light[0] = 1'b1;  //sec red
//initial light[1] = 1'b0;
//initial light[2] = 1'b0;
reg period = 0;
reg [3:0] tsecond = 0; 
reg[31:0] count = 0;
parameter D = 32'd50000000;   
//parameter D = 32'd50000;

always @(posedge clk)
begin
	count <= count + 32'd1;
	if (count >= D-1)  // state is chnaging at 3 seconds (1 sec extra for counting to 50 million)
	begin
		 count <= 32'd0; 
		 
		 if((rst == 1))
		 begin
		    //out0 <= 1'b0;             
			 //out1 <= 1'b0;
			 //out2 <= 1'b1;
			 //out3 <= 1'b1;
			 //out4 <= 1'b0;
			 //out5 <= 1'b0;
		    Q = 4'b1010;
			 state <= 3'b000;
		 end
		 
		 
		 case(state) 
	
			 3'b000: begin 
				       
						  if (Q <= 4'b0001)      // chnage after 10 seconds (keep 1 less)
						  begin
							  
							  if (rst == 1)
							  begin
							      light[3] <= 1'b0;             
									light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b000;
									Q = 4'b1010;
							  end
							  else
							  begin
							      light[3] <= 1'b0;
									light[4] <= 1'b1;
									light[5] <= 1'b0;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b001;
							      Q = 2'b10;
							  end
							  
						  end
						  else
						  begin
						     
							  if (rst == 1)
							  begin
							      light[3] <= 1'b0;             
									light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b000;
							      Q = 4'b1010;
							  end
							  else if(request == 1 && (Q > 4'b0101))   // if tsecond > 5 sec then decrease main green 
							  begin 
						             state <= 3'b000;
										 Q = Q - 3'b101;
							  end
							  else
							  begin
						         state <= 3'b000;
							      Q = Q - 1'b1;
							  end
						  end
			 end		
			 
			 3'b001: begin

						  if (Q <= 4'b0001)  // change after 2 second
						  begin
							  
							  if (rst == 1)
							  begin
							      light[3] <= 1'b0;             
									light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b000;
							      Q = 4'b1010;
							  end
							  else
							  begin
							      light[3] <= 1'b1;
						         light[4] <= 1'b0;
						         light[5] <= 1'b0;
						         light[0] <= 1'b0;
						         light[1] <= 1'b0;
						         light[2] <= 1'b1;
							      state <= 3'b010;
							      Q = 3'b101;
							  end
							  
						  end
						  else
						  begin
						  
						     if (rst == 1)
							  begin
							      light[3] <= 1'b0;             
									light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b000;
									Q = 4'b1010;
							  end
							  else
							  begin
						         state <= 3'b001;
							      Q = Q - 1'b1;
							  end
						  end
			 end
			 
			 3'b010: begin           // here both main is red for 5 sec and sec is green for 5 sec
		
						  if (Q <= 4'b0001)  // chnage after 5 second
						  begin
							  
							  if (rst == 1)
							  begin
							     light[3] <= 1'b0;             
								  light[4] <= 1'b0;
								  light[5] <= 1'b1;
								  light[0] <= 1'b1;
								  light[1] <= 1'b0;
								  light[2] <= 1'b0;
							     state <= 3'b000;
								  Q = 4'b1010;
							  end
							  else
							  begin
							     light[3] <= 1'b1;
								  light[4] <= 1'b0;
								  light[5] <= 1'b0;
								  light[0] <= 1'b0;
								  light[1] <= 1'b1;
								  light[2] <= 1'b0;
							     state <= 3'b011;
							     Q = 2'b10;
							  end
							  
						  end
						  else
						  begin
						  
						     if (rst == 1)
							  begin
							      light[3] <= 1'b0;             
									light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b000;
							      Q = 4'b1010;
							  end
							  else
							  begin
						         state <= 3'b010;
							      Q = Q - 1'b1;
							  end
						  end
			 end
			 
			 3'b011: begin           // here both main is red for 2 sec and sec is yellow for 2 sec
					
						  if (Q <= 4'b0001)  // chnage after 2 second
						  begin
							  
							  if (rst == 1)
							  begin
							     light[3] <= 1'b0;             
			                 light[4] <= 1'b0;
								  light[5] <= 1'b1;
								  light[0] <= 1'b1;
								  light[1] <= 1'b0;
								  light[2] <= 1'b0;
							     state <= 3'b000;
							     Q = 4'b1010;
							  end
							  else
							  begin
							     light[3] <= 1'b0;             
								  light[4] <= 1'b0;
								  light[5] <= 1'b1;
								  light[0] <= 1'b1;
								  light[1] <= 1'b0;
								  light[2] <= 1'b0;
							     state <= 3'b000;
							     Q = 4'b1010;
								  if(request == 1 && (Q > 4'b0101))   // if tsecond > 5 sec then decrease main green 
								  begin 
											 //state <= 3'b000;
											 Q = Q - 3'b101;
								  end
							  end
							  
						  end
						  else
						  begin
						     
							  if (rst == 1)
							  begin
							      light[3] <= 1'b0;             
			                  light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;
							      state <= 3'b000;
							      Q = 4'b1010;
							  end
							  else
							  begin
						         state <= 3'b011;
							      Q = Q - 1'b1;
							  end
						  end
			 end
			 
			 default : begin       
			                  light[3] <= 1'b0;              // main green for 10 sec and sec red for 10
									light[4] <= 1'b0;
									light[5] <= 1'b1;
									light[0] <= 1'b1;
									light[1] <= 1'b0;
									light[2] <= 1'b0;   
								   state <= 3'b000;
							      Q = 4'b1010;	
			 end
		
	    endcase
		 //tsecond <= tsecond + 1;
	end
	
end

//assign cout = (count < D/2) ? 1'b0 : 1'b1; 
initial light[5:0] = 6'b100001;
//initial Q = (request == 1 && (Q > 4'b0101)) ? 4'b0101 : 4'b1010; 

   wire [7:0] temp;
	
   Lab1 l0(Q[3:0],temp);
	
	always @(posedge clk)
	begin
	   sevseg = temp; 
	end
	

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


endmodule
