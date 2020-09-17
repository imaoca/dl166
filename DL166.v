module cpu(input reset,input clk,input[3:0] btn,output[3:0]led);
	wire[4:0]op; wire[2:0]sss; // Instruction set (op is operator,sss is operalnd)	
	reg c_flag;
	reg [3:0]regs[7:0];
	assign led= regs[6];
	rom memory({op,sss}, regs[7]);
	always @(posedge clk)
	  if(reset==0) {regs[0],regs[1],regs[2],regs[3],regs[4],regs[6],regs[7],c_flag}=0;
	  else begin
	   regs[5]=btn;
 	   casez(op)
/* MOV */	8'b00zzz: regs[op[2:0]]=regs[sss];
/* ADD */	8'b01000: begin 
			regs[0]=regs[0]+regs[sss];
			if (regs[0]+regs[sss]>15) c_flag=1;else c_flag=0;
			end  //Take care c_flag
/* OR  */	8'b01001: regs[0]=regs[0]|regs[sss];
/* AND */	8'b01010: regs[0]=regs[0]&regs[sss];
/* XOR */	8'b01011: regs[0]=regs[0]^regs[sss];
/* INC */	8'b01100: begin 
			regs[sss]=regs[sss]+1;
			if (regs[sss]==15)  c_flag=1;else c_flag=0;
			end //Take care c_flag
/* NOT */	8'b01101: regs[sss]=!regs[sss];
// RSHIFT 	8'b01110: begin c_flag=regs[sss][0];regs[sss]=regs[sss]>>1;end	// Reserved
// LSHIFT 	8'b01111: begin c_flag=regs[sss][3];regs[sss]=regs[sss]<<1;end	// Reserved	
/* JNC */	8'b1000z: regs[7]= (c_flag)?regs[7]+1:{op[0],sss};
/* JMP */	8'b1001z: regs[7]= {op[0],sss};
/* SET */	8'b1010z: regs[0]= {op[0],sss};	
	   endcase		
/* PC++ */ if(op[4:1]!=4'b1000 && op[4:1]!=4'b1001) begin regs[7]=regs[7]+1;end
	end
endmodule
