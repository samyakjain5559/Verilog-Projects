`timescale 1ps/1ps
//module lab1W(clk,s0,s1,s2,led0);
module lab1W(clk,cout,out0,out1,out2,s0,s1,s2);

input clk;
input s0,s1,s2;
output cout,out0,out1,out2;

// CREDITS for clock devider
// Clock devider code used from EECS 3201 Lab 4 provided by the proffesor Andrew

reg cout ,number;
reg[31:0] count = 32'd0;
//parameter D = 32'd49996000;
//parameter D = 32'd100;
parameter D = 32'd12500;

always @(posedge clk)
begin
	count <= count + 32'd1;
	
	
	if (count >= D-1)
		count <= 32'd0;
end

//assign cout = (count < D/2) ? 1'b0 : 1'b1;  // 50 percent duty cycle


always @(posedge clk)
begin
     
	  if (s2==1 && s1==0 && s0==0)
		  begin
			  cout = (count < 5415) ? 1'b0 : 1'b0; //56.68 percent duty
		  end
	   else if (s2==0 && s1==0 && s0==0)
		  begin
			  cout = (count < 11250) ? 1'b0 : 1'b1; // 10 percent duty
		  end
		else if (s2==0 && s1==0 && s0==1)
		  begin
		     //cout = (count < (D*(13/100))) ? 1'b1 : 1'b0;  // 21.42 percent duty
			  cout = (count < (9823)) ? 1'b0 : 1'b1;
		  end
		else if (s2==0 && s1==1 && s0==0)
		  begin
		     cout = (count < (8395)) ? 1'b0 : 1'b1;  // 32.84 percent duty
		  end
		else if (s2==0 && s1==1 && s0==1)
		  begin
		     cout = (count < (6968)) ? 1'b0 : 1'b1;  // 44.26 percent duty
		  end
		else if (s2==1 && s1==0 && s0==1)
		  begin
		     cout = (count < (4112)) ? 1'b0 : 1'b1;  // 67.1 percent duty
		  end
		else if (s2==1 && s1==1 && s0==0)
		  begin
		     cout = (count < (2685)) ? 1'b0 : 1'b1;  // 78.52 percent duty
		  end
		else if (s2==1 && s1==1 && s0==1)
		  begin
		     cout = (count < (1250)) ? 1'b0 : 1'b1;  // 90 percent duty
		  end

end

 assign out0 = s0;
 assign out1 = s1;
 assign out2 = s2;


endmodule