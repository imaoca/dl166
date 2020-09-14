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
 	   casez(dout)
		8'b00zzzzzz: regs[dout[5:3]]=regs[dout[2:0]];
		8'b01000zzz: begin regs[0]=regs[0]+regs[dout[2:0]];c_flag=regs[0][4];regs[0][4]=0;end  //ADD take care c_flag
		8'b01001zzz: regs[0]=regs[0]|regs[dout[2:0]];
		8'b01010zzz: regs[0]=regs[0]&regs[dout[2:0]];
		8'b01011zzz: regs[0]=regs[0]^regs[dout[2:0]];
		8'b01100zzz: begin regs[dout[2:0]]=regs[dout[2:0]]+1;c_flag=regs[dout[2:0]][4];regs[dout[2:0]][4]=0;end //INC take care c_flag
		8'b01101zzz: regs[dout[2:0]]=!regs[dout[2:0]];
		8'b01110zzz: begin c_flag=regs[dout[2:0]][0];regs[dout[2:0]]=regs[dout[2:0]]>>1;end		     //RSHIFT take care c_flag
		8'b01111zzz: begin c_flag=regs[dout[2:0]][3];regs[dout[2:0]]=regs[dout[2:0]]<<1;end		     //LSHIFT take care c_flag
		8'b1000zzzz: regs[7]= (c_flag)?regs[7]+1:dout[3:0];	//JNC
		8'b1001zzzz: regs[7]=dout[3:0];				//JMP
		8'b1010zzzz: regs[0]=dout[3:0];				//SET
	   endcase		
	   if(dout[7:4]!=4'b1000 && dout[7:4]!=4'b1001) regs[7]=regs[7]+1;
	end
endmodule 
