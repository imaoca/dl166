module ram(clk, we, r_addr, r_data, w_addr, w_data); 
             input clk, we;
             input  [7:0] r_addr, w_addr;
             input  [7:0] w_data;
             output [7:0] r_data;
             reg [7:0] mem [255:0];     
	     
	     initial begin
		mem[ 8'd0] <= 8'b01100_000;// inc R0
		mem[ 8'd1] <= 8'b1000_0000;// jnc 0
		mem[ 8'd2] <= 8'b1010_0000;// SET 0
		mem[ 8'd3] <= 8'b1001_0000;// jmp 0
		mem[ 8'd4] <= 8'b1010_0001;// SET 1
		mem[ 8'd5] <= 8'b0000_1000;// MOV R1,R0
		mem[ 8'd6] <= 8'b1010_0000;// SET 0
		mem[ 8'd7] <= 8'b0100_0001;// ADD R1
		mem[ 8'd8] <= 8'b1000_0111;// jnc 7
		mem[ 8'd9] <= 8'b1001_0110;// jmp 6
	     end
       
             always @(posedge clk) begin
                 if(we) mem[w_addr] <= w_data; 
             end
             assign r_data = mem[r_addr];
endmodule