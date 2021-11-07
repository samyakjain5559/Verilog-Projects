// Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

module pwm_led_top(
	SYS_CLK,
	PB,
	USER_LED
);


input wire	SYS_CLK;
input wire	[2:1] PB;
output wire	[9:0] USER_LED;

wire	dn_debounced;
wire	[3:0] duty_cycle;

wire	pwm;
wire	up_debounced;

reg [7:0]counter1;
reg [11:0] counter2;
reg duty_cycle_clk;
reg pwm_clk;

initial begin
counter1=8'h00;
counter2=12'h000;
duty_cycle_clk=1'b0;
pwm_clk=1'b0;
end

always@(posedge SYS_CLK)
begin 
		counter1<=counter1+1'b1;
				if(counter1==8'h19)
					begin  counter1<=0;
								pwm_clk<=~pwm_clk;	//pwm_clk
					end
	end	


always@(posedge SYS_CLK)
begin
			counter2<=counter2+1'b1;
				if(counter2==12'h1F4)
				begin  counter2<=0;
								duty_cycle_clk<=~duty_cycle_clk;	//duty_cycle_clk
					end
	end	
	

debouncer	db1(
	.noisy(PB[1]),
	.clk(duty_cycle_clk),
	.debounced(up_debounced));

assign	USER_LED[4] =  ~pwm;
assign	USER_LED[5] =  ~pwm;
assign	USER_LED[6] =  ~pwm;
assign	USER_LED[7] =  ~pwm;
assign	USER_LED[8] =  ~pwm;
assign	USER_LED[9] =  ~pwm;

assign	USER_LED[3:0] =  ~duty_cycle;


debouncer	db2(
	.noisy(PB[2]),
	.clk(duty_cycle_clk),
	.debounced(dn_debounced));


duty_cycle	duty_cyc(
	.clk(duty_cycle_clk),
	.up(up_debounced),
	.dn(dn_debounced),
	.duty_cycle(duty_cycle));


pwm_gen	pwm_g(
	.clk(pwm_clk),
	.duty_cycle(duty_cycle),
	.pwm(pwm));


endmodule
