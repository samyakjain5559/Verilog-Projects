
module top (
	input clk, reset,
	input[8:0] switches,
	input fkey,
	input bkey,
	output [11:0] rgb,
	output [7:0]sevseg0,sevseg1,sevseg2,
	output hsync, vsync
	);
	
	
	wire [9:0] x,y;
	wire indisplayinterval;
	wire square_on;
	
	sync v1 (.clk(clk), .rst(reset), .hsync(hsync), .vsync(vsync), .col(x), .row(y), .indisplayinterval(indisplayinterval));
	
	render r1 (.clk(clk), .indisplayinterval(indisplayinterval), .square_on(square_on), .rgb(rgb),.switches(switches));

	shapeselector ss1 (.x(x), .y(y), .clk(clk),.square_on(square_on), .fkey(fkey),.bkey(bkey));

	DisplayDecoder d2(switches[8:6],sevseg2);
	DisplayDecoder d1(switches[5:3],sevseg1);
	DisplayDecoder d0(switches[2:0],sevseg0);
	
endmodule

// hex display from lab 2 of EECS 3201 Fall 2020
module DisplayDecoder(hex_input,sevseg);

   input [0:3]hex_input;
   output [0:6]sevseg;
	hex1 zero(sevseg,hex_input);
	
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
