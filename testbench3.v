module testbench3();
	reg clk;
	reg reset = 1;
	wire[3:0] btn;
	wire[3:0]led;
	wire  [7:0] w_data;
    	wire  [7:0] r_data;
	wire  [3:0] adr;
//	cpu cpu0(reset,clk,btn,led);
	 ram ram1(clk, 0, {4'b0000,adr}, r_data, adr, w_data);  
	 cpu cpu1(reset,clk,btn,led,adr,r_data);


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
