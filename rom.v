module rom(dout, addr);
	output [7:0] dout;
	input [3:0] addr;
	reg[7:0] mem[15:0];
	initial begin
//		`include "asm.txt"
		mem[ 4'd0] <= 8'b01100_000;// inc R0
		mem[ 4'd1] <= 8'b1000_0000;// jnc 0
		mem[ 4'd2] <= 8'b1001_0010;// jmp 2
	end
	assign dout = mem[addr];
endmodule