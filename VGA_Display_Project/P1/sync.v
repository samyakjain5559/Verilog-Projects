module sync(input clk, rst, output hsync, vsync, output reg [9:0] row, col, output indisplayinterval);


//pclk is pixel clock of 25 Mhz as per the vga timing specification
//Resolution is 640 x 480 at 60Hz
//More timing specification below
localparam
	H_DISPLAY = 640,
	H_FRONT_PORCH = 16,
	H_BACK_PORCH = 48,
	H_SYNC_PULSE = 96;
	
localparam
	V_DISPLAY = 480,
	V_FRONT_PORCH = 10,
	V_BACK_PORCH = 33,
	V_SYNC_PULSE = 2;
	
	
wire hsync_done, vsync_done;
reg hsync_pulse, vsync_pulse;

reg pclk;
	
	always @(posedge clk)
	begin
		pclk = ~ pclk;
	end

always @(posedge pclk or posedge rst)
begin
	if(rst == 1)
	begin
		row <= 10'd0;
		col <= 10'd0;
	end
	else
	begin
		if(hsync_done)
		begin
			col <= 10'd0;
			if(vsync_done)
				row <= 10'd0;
			else
				row <= row + 10'd1;
		end
		else
			col <= col + 10'd1;
	end
	
end

always @(posedge pclk)
begin
	hsync_pulse <= (col >= (H_DISPLAY + H_FRONT_PORCH)) && (col < (H_DISPLAY + H_FRONT_PORCH + H_BACK_PORCH)); //needed low pulse when row is finished
	vsync_pulse <= (row >= (V_DISPLAY + V_FRONT_PORCH)) && (row < (V_DISPLAY + V_FRONT_PORCH + V_BACK_PORCH)); //needed low pulse when col is finished
	
end

assign indisplayinterval = (col < H_DISPLAY) && (row < V_DISPLAY);
assign hsync_done = (col >= (H_DISPLAY + H_FRONT_PORCH + H_BACK_PORCH + H_SYNC_PULSE));
assign vsync_done = (row >= (V_DISPLAY + V_FRONT_PORCH + V_BACK_PORCH + V_SYNC_PULSE));
assign hsync = hsync_pulse;
assign vsync = vsync_pulse;


endmodule
