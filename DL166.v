module cpu(input reset,input clk,input[3:0] btn,output[3:0]led);
	wire[7:0] dout;	
	reg c_flag=1'b0;
	reg [4:0]regs[7:0];
	assign led= regs[6];
	rom memory(dout, regs[7]);
	wire[2:0] ddd,sss;
	wire[3:0] imd;
	assign ddd[2:0]=dout[5:3];//[2:0]
	assign sss[2:0]=dout[2:0];//[2:0]
	assign imd[3:0]=dout[3:0];//[3:0]

	always @(posedge clk)
	  if(reset==0) {regs[0],regs[1],regs[2],regs[3],regs[4],regs[7]}=0;
	  else begin
		regs[5]=btn;
		case(dout[7:6])
		2'b00: regs[ddd]=regs[sss];
		2'b01: case(dout[5:3])
		  3'b000:begin regs[0]=regs[0]+regs[sss];c_flag=regs[0][4];regs[0][4]=0;end  //ADD take care c_flag
		  3'b001:regs[0]=regs[0]|regs[sss];
		  3'b010:regs[0]=regs[0]&regs[sss];
		  3'b011:regs[0]=regs[0]^regs[sss];
		  3'b100:begin regs[sss]=regs[sss]+1;c_flag=regs[sss][4];regs[sss][4]=0;end //INC take care c_flag
		  3'b101:regs[sss]=!regs[sss];
		  3'b110:begin c_flag=regs[sss][0];regs[sss]=regs[sss]>>1;end		     //RSHIFT take care c_flag
		  3'b111:begin c_flag=regs[sss][3];regs[sss]=regs[sss]<<1;end		     //LSHIFT take care c_flag
		 endcase
		2'b10: case(dout[5:4])
		  2'b00:regs[7]= (c_flag)?regs[7]+1:imd;		//JNC
		  2'b01:regs[7]=imd;					//JMP
		  2'b10:regs[0]=imd;					//SET
		 endcase
		endcase		
		if(dout[7:4]!=4'b1000 && dout[7:4]!=4'b1001) regs[7]=regs[7]+1;
	end
endmodule 
