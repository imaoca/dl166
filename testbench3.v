module testbench3();
	reg clk;
	reg reset = 1;
	wire[3:0] btn;
	wire[3:0]led;
	cpu cpu0(reset,clk,btn,led);

	initial begin
		reset = 0; #1;
		clk = 1; #1; clk = 0; #1; // 10ns period
		clk = 1; #1; clk = 0; #1; // 10ns period
		reset = 1;	
	end

	always 	begin
		clk = 1; #1; clk = 0; #1; // 10ns period
	end
endmodule


