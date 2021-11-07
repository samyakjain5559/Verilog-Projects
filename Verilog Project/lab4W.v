`timescale 1ps/1ps
module lab4W(clk,cout);

input clk;
output cout;

integer i;
reg [7:0] rom [0:18];

reg [7:0] value;
initial begin
	i = 0;
	rom[0] = 127;
	rom[1] = 170;
	rom[2] = 208;
	rom[3] = 236;
	rom[4] = 252;
	rom[5] = 252;
	rom[6] = 236;
	rom[7] = 208;
	rom[8] = 170;
	rom[9] = 127;
	rom[10] = 83;
	rom[11] = 45;
	rom[12] = 17;
	rom[13] = 1;
	rom[14] = 1;
	rom[15] = 17;
	rom[16] = 45;
	rom[17] = 83;
	rom[18] = 127;
end

// CREDITS for clock devider
// Clock devider code used from EECS 3201 Lab 4 provided by the proffesor Andrew
//initial rom[i] =  127;
reg cout ,number;
reg[31:0] count = 32'd0;
//parameter D = 32'd50000000;
//parameter D = 32'd100;
//parameter D = 32'd250000; // 200 hz clock
//parameter D = 32'd13158; // 3800 hz clock or 0.263ms
parameter D = 32'd13155; // 3800 hz clock or 0.263ms

always @(posedge clk)
begin
	count <= count + 32'd1;
	
	if (count >= D-1)
	begin
		count <= 32'd0;
		
		//value <= (rom[i])/256;
		value <= (rom[i]);
		
		if(i == 18)
			i = 0;
		else
			i = i + 1;
		
	end
		
end

//initial rom[0] =  127;

always @(posedge clk)
begin
     if (value == 127)
		  begin
			  //cout = (count < (124500)) ? 1'b1 : 1'b0;  //49.8 % duty cycle
			  //cout = (count < (24900000)) ? 1'b1 : 1'b0;  //49.8 % duty cycle
			  //cout = (count < (6553)) ? 1'b1 : 1'b0;  //49.8 % duty cycle for 13157 hz or 0.263 ms
			  cout = (count < (6630)) ? 1'b0 : 1'b1;  //49.6 % duty cycle for 13157 hz or 0.263 ms
		  end
	  if (value == 170)
		  begin
			  //cout = (count < (166500)) ? 1'b1 : 1'b0;  //66.6 % duty cycle
			  //cout = (count < (33300000)) ? 1'b1 : 1'b0;  //66.6 % duty cycle
			  //cout = (count < (8763)) ? 1'b1 : 1'b0;  //66.6 % duty cycle
			  cout = (count < (4420)) ? 1'b0 : 1'b1;  //66.4 % duty cycle
		  end
	  if (value == 208)
		  begin
			  //cout = (count < (203125)) ? 1'b1 : 1'b0;  //81.2 % duty cycle
			  //cout = (count < (40600000)) ? 1'b1 : 1'b0;  //81.2 % duty cycle
           //cout = (count < (10684)) ? 1'b1 : 1'b0;  //81.2 % duty cycle
			  cout = (count < (2474)) ? 1'b0 : 1'b1;  //81.25 % duty cycle
		  end
	  if (value == 236)
		  begin
			  //cout = (count < (230450)) ? 1'b1 : 1'b0;  //92.18 % duty cycle
			  //cout = (count < (46090000)) ? 1'b1 : 1'b0;  //92.18 % duty cycle
			  //cout = (count < (12129)) ? 1'b1 : 1'b0;  //92.18 % duty cycle
			  cout = (count < (1028)) ? 1'b0 : 1'b1;  //92.1875 % duty cycle
		  end
	  if (value == 252)
		  begin
			  //cout = (count < (246075)) ? 1'b1 : 1'b0;  //98.43 % duty cycle
			  //cout = (count < (49215000)) ? 1'b1 : 1'b0;  //98.43 % duty cycle
			  //cout = (count < (12951)) ? 1'b1 : 1'b0;  //98.43 % duty cycle
			  cout = (count < (206)) ? 1'b0 : 1'b1;  //98.4375 % duty cycle
		  end
	  if (value == 83)
		  begin
			  //cout = (count < (81050)) ? 1'b1 : 1'b0;  //32.42 % duty cycle
			  //cout = (count < (16210000)) ? 1'b1 : 1'b0;  //32.42 % duty cycle
			  //cout = (count < (4266)) ? 1'b1 : 1'b0;  //32.42 % duty cycle
			  cout = (count < (8890)) ? 1'b0 : 1'b1;  //32.4218 % duty cycle
		  end
	  if (value == 45)
		  begin
			  //cout = (count < (43925)) ? 1'b1 : 1'b0;  //17.57 % duty cycle
			  //cout = (count < (8785000)) ? 1'b1 : 1'b0;  //17.57 % duty cycle
			  //cout = (count < (2312)) ? 1'b1 : 1'b0;  //17.57 % duty cycle
			  cout = (count < (10843)) ? 1'b0 : 1'b1;  //17.578 % duty cycle
		  end
	  if (value == 17)
		  begin
			  //cout = (count < (16600)) ? 1'b1 : 1'b0;  //6.6 % duty cycle
			  //cout = (count < (3300000)) ? 1'b1 : 1'b0;  //6.6 % duty cycle
			  //cout = (count < (868)) ? 1'b1 : 1'b0;  //6.6 % duty cycle
			  cout = (count < (12282)) ? 1'b0 : 1'b1;  //6.64 % duty cycle
		  end
	  if (value == 1)
		  begin
			  //cout = (count < (975)) ? 1'b1 : 1'b0;  //0.39 % duty cycle
			  //cout = (count < (195000)) ? 1'b1 : 1'b0;  //0.39 % duty cycle
			  //cout = (count < (51)) ? 1'b1 : 1'b0;  //0.39 % duty cycle
			  cout = (count < (13104)) ? 1'b0 : 1'b1;  //0.39 % duty cycle
		  end
		
     //cout = (count < (value*250000)) ? 1'b1 : 1'b0;  //duty cycle
end

endmodule