module ram(clk, we, r_addr, r_data, w_addr, w_data); 
             input clk, we;
             input  [7:0] r_addr, w_addr;
             input  [7:0] w_data;
             output [7:0] r_data;
             reg [7:0] mem [255:0];     
	     initial begin
/*
		mem[ 8'd0] <= 8'b1010_0001;// mvi 0001
		mem[ 8'd1] <= 8'b01111_000;// lrotate r0
		mem[ 8'd2] <= 8'b1001_0001;// jmp 1

		mem[ 8'd0] <= 8'b01100_000;// inc R0		
		mem[ 8'd1] <= 8'b1000_0000;// jnc 0000
		mem[ 8'd2] <= 8'b1010_0000;// mvi 0000		
		mem[ 8'd3] <= 8'b1001_0000;// jmp 0
*/

		mem[0] <= 8'b01100_000;// inc R0		
		mem[1] <= 8'b1000_0000;// jnc 0000
		mem[2] <= 8'b1010_0000;// mvi 0000		
		mem[3] <= 8'b1001_0000;// jmp 0

	     end
             always @(posedge clk) begin
                 if(we) mem[w_addr] <= w_data; 
             end
             assign r_data = mem[r_addr];
endmodule