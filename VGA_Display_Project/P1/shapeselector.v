module shapeselector(input[9:0] x, y,
            input clk,
				output square_on,
				input fkey,input bkey);

reg so;
reg [1:0] shapeSel = 2'd0;
integer temp = 0, abc = 0, abp = 0,apb = 0, pbc = 0;
reg rec_on;
reg[31:0] fshapecounter = 32'd0;
reg[31:0] bshapecounter = 32'd0;

localparam
	centerX = 320,
	centerY = 240,
	radius = 100;

localparam
	RECT = 0,
	SQUARE = 1,
	CIRCLE = 2,
	TRIANGLE = 3;

//triangle sides
localparam
	//SAx = (centerX - 50), SAy = (centerY + 100),
	SAx = 270, SAy=340,
	SCx = 370, SCy = 340,
	SBx = 320, SBy = 140;

always @(posedge clk)
begin
   if(fkey == 0)
	begin
	  fshapecounter = fshapecounter + 32'd1;
	  bshapecounter = 32'd0;
	end
	else if(bkey == 0)
	begin
	  bshapecounter = bshapecounter + 32'd1;
	  fshapecounter = 32'd0;
	end
	if(fkey == 1 && fshapecounter > 0)
	begin
	   fshapecounter = 32'd0;
		bshapecounter = 32'd0;
		if(shapeSel == 2'd3)
		   shapeSel = 2'd0;
	   else
	      shapeSel = shapeSel + 2'd1;
	end
	else if(bkey == 1 && bshapecounter > 0)
	begin
	   bshapecounter = 32'd0;
		fshapecounter = 32'd0;
		if(shapeSel == 2'd0)
		   shapeSel = 2'd3;
		else
	      shapeSel = shapeSel - 2'd1;
	end
	
   if(shapeSel == RECT)
	  rec_on = (x >= (centerX-200) && x <= (centerX+200)) && (y>= (centerY-100) && y <= (centerY+100)) ?1:0;
	else if(shapeSel == SQUARE)
	  rec_on = (x >= (centerX-150) && x <= (centerX+150)) && (y>= (centerY-150) && y <= (centerY+150)) ?1:0;
	else if(shapeSel == CIRCLE)
	begin
		temp = ((x - centerX) * (x - centerX)) + ((y - centerY) * (y - centerY));
		rec_on = temp <= (radius * radius);
	end
	else if(shapeSel == TRIANGLE)
	begin
		 abc = ((SAx * (SBy-SCy)) + (SBx * (SCy-SAy)) + (SCx * (SAy-SBy)));
		 if(abc[31] == 1'b1)
		     abc = -abc;
		 abp = ((SAx * (SBy-y)) + (SBx * (y-SAy)) + (x *(SAy-SBy)));
		 if(abp[31] == 1'b1)
		     abp = -abp;
		 apb = ((SAx * (y-SCy)) + (x * (SCy-SAy)) + (SCx * (SAy-y)));
		 if(apb[31] == 1'b1)
		     apb = -apb;
		 pbc = ((x * (SBy-SCy)) + (SBx * (SCy-y)) + (SCx * (y-SBy)));
		 if(pbc[31] == 1'b1)
		     pbc = -pbc;
		 
		 rec_on = abc == (abp+apb+pbc);
	
	end

end

assign square_on = rec_on;

endmodule 