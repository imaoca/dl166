module cpu(input reset,input clk,input[3:0] btn,output[3:0]led);
	wire[7:0] dout;	
	reg c_flag=1'b0;
	reg [4:0]regs[7:0];
	assign led= regs[6];
	rom memory(dout, regs[7]);
	always @(posedge clk)
	  if(reset==0) {regs[0],regs[1],regs[2],regs[3],regs[4],regs[7]}=0;
	  else begin
		regs[5]=btn;
		case(dout[7:6])
		2'b00: regs[dout[5:3]]=regs[dout[2:0]];
		2'b01: case(dout[5:3])
		  3'b000:begin regs[0]=regs[0]+regs[dout[2:0]];c_flag=regs[0][4];regs[0][4]=0;end  //ADD care c_flag
		  3'b001:regs[0]=regs[0]|regs[dout[2:0]];
		  3'b010:regs[0]=regs[0]&regs[dout[2:0]];
		  3'b011:regs[0]=regs[0]^regs[dout[2:0]];
		  3'b100:begin regs[dout[2:0]]=regs[dout[2:0]]+1;c_flag=regs[dout[2:0]][4];regs[dout[2:0]][4]=0;end //INC care c_flag
		  3'b101:regs[dout[2:0]]=!regs[dout[2:0]];
		  3'b110:begin c_flag=regs[dout[2:0]][0];regs[dout[2:0]]=regs[dout[2:0]]>>1;end		     //RSHIFT care c_flag
		  3'b111:begin c_flag=regs[dout[2:0]][3];regs[dout[2:0]]=regs[dout[2:0]]<<1;end		     //LSHIFT care c_flag
		 endcase
		2'b10: case(dout[5:4])
		  2'b00:regs[7]= (c_flag)?regs[7]+1:dout[3:0];		//JNC
		  2'b01:regs[7]=dout[3:0];				//JMP
		  2'b10:regs[0]=dout[3:0];				//SET
		 endcase
		endcase		
		if(dout[7:4]!=4'b1000 && dout[7:4]!=4'b1001) regs[7]=regs[7]+1;
	end
endmodule 
