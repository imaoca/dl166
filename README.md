# dl166
4 BIT Original CPU

#Registers  
------------------------  
0:000 ACC  
1:001 GR1  
2:010 GR2  
3:011 GR3  
4:100 GR4  
5:101 INPUT PORT(read only)  
6:110 OUTPUT PORT(write only)  
7:111 Program Counter(PC)  

#Instruction Set  
------------------------  
01-000-sss ADD (sss)  acc=acc+(sss)  
01-001-sss OR (sss)   acc=acc | (sss)  
01-010-sss AND (sss)  acc = acc & (sss)  
01-011-sss XOR (sss)  acc = acc ^ (sss)  

01-100-sss INC (sss)  (sss)=(sss)+1  
01-101-sss NOT (sss)  (sss)=!(sss)  
01-110-sss RSHIFT (sss)(sss)=(sss)>>1  
01-111-sss LSHIFT (sss)(sss)=(sss)<<1  

10-00-#### JNC #### if (C==0) PC=#### else PC=PC+1  
10-01-#### JMP #### PC = ####  
10-10-#### SET #### acc=####  

00-ddd-sss MOV (ddd),(sss)  

#Files
------------------------  
DL166.v  
CPU and Memory Verilog-HDL Source files  

testbench3.v  
Test bech for DL166  

asm.txt  
sample code to test DL166.  
// this program is counting up R0 register and show this on LEDs.  
00: inc R0   
01: mov R6,R0  
11: jmp 0  
