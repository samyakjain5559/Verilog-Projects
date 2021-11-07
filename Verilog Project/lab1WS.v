module main(clk,sw1,sw2,sw3,led0, led2, led3, led4, cout);


input clk, sw1, sw2, sw3;
reg[31:0] sel;
output cout, led0, led2, led3, led4;

reg[31:0] count = 32'd0;
parameter D = 32'd12500;


always @(posedge clk)
begin
	count <= count + 32'd1;
	if (count >= D-1)
		count <= 32'd0;
end

always @(sw1 or sw2 or sw3)
//begin
begin
	if (sw3 == 0 && sw2 == 0 && sw1 == 0)
		sel = D-(D*0.10);
		
	else if (sw3 == 0 && sw2 == 0 && sw1 == 1)
		sel = D-(D*0.21429);
		
	else if (sw3 == 0 && sw2 == 1 && sw1 == 0)
		sel = D-(D*0.32858);
		
	else if (sw3 == 0 && sw2 == 1 && sw1 == 1)
		sel = D-(D*0.44287);
		
	else if (sw3 == 1 && sw2 == 0 && sw1 == 0)
		sel = D-(D*0.55716);
		
	else if (sw3 == 1 && sw2 == 0 && sw1 == 1)
		sel = D-(D*0.67145);
		
	else if (sw3 == 1 && sw2 == 1 && sw1 == 0)
		sel = D-(D*0.78574);
		
	else if (sw3 == 1 && sw2 == 1 && sw1 == 1)
		sel = D-(D*0.90);
end
//end

assign cout = (count >= sel) ? 1'b1 : 1'b0;
assign led4 = sw3; //most significant bit led
assign led3 = sw2;
assign led2 = sw1;

assign led0 = cout;

endmodule