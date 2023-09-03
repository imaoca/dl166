module cpu(input reset,input clk,input[3:0] btn,output[3:0]led,output[3:0]adr,input[7:0]dout);
   wire[4:0]op=dout[7:3]; 
	wire[2:0]sss=dout[2:0]; // Instruction set (op is operator,sss is operalnd)	
	reg c_flag;
	reg [3:0]regs[7:0];
	assign led = regs[6];
	assign adr = regs[7];
	always @(posedge clk)
	  if(reset==0) {regs[0],regs[1],regs[2],regs[3],regs[4],regs[6],regs[7],c_flag}=0;
	  else begin
	   regs[5]=btn;
 	   casez(op)
/* MOV */	5'b00zzz: regs[op[2:0]]<=regs[sss];
/* ADD */	5'b01000: begin regs[0]<=regs[0]+regs[sss]; c_flag <= (regs[0]+regs[sss] > 15)?1:0;end
/* OR  */	5'b01001: regs[0]<=regs[0]|regs[sss];
/* AND */	5'b01010: regs[0]<=regs[0]&regs[sss];
/* XOR */	5'b01011: regs[0]<=regs[0]^regs[sss];
/* INC */	5'b01100: begin regs[sss]<=regs[sss]+1; c_flag <= (regs[sss]+1 > 15)?1:0;end
/* NOT */	5'b01101: regs[sss]<=~regs[sss];
/*RROTATE*/	5'b01110: regs[sss]=regs[sss]>>1| (regs[sss]<<3 & 4'b1000);
/*LROTATE*/	5'b01111: regs[sss]=regs[sss]<<1| (regs[sss]>>3 & 4'b0001);	
/* JNC */	5'b1000z: begin regs[7]<= (c_flag)?regs[7]+1:{op[0],sss};c_flag=0;end
/* JMP */	5'b1001z: regs[7]<= {op[0],sss};
/* MVI */	5'b1010z: regs[0]<= {op[0],sss};	
	   endcase		
/* PC++ */  if(op[4:1]!=4'b1000 && op[4:1]!=4'b1001) regs[7]=regs[7]+1;
	end
endmodule
