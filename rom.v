module rom(dout, addr);
	output [7:0] dout;
	input [3:0] addr;
	reg[7:0] mem[15:0];
	initial begin
		mem[ 4'd0] <= 8'b01100_000;// inc R0
		mem[ 4'd1] <= 8'b1000_0000;// jnc 0
		mem[ 4'd2] <= 8'b1010_0000;// SET 0
		mem[ 4'd3] <= 8'b1001_0000;// jmp 0
	end
	assign dout = mem[addr];
endmodule
