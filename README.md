# dl166
4 BIT Original CPU. it has 16 steps programming space. it has 8 registers include program counter. They have 4 bit. Instruction set is 8bit.

# Registers  (4 bit)
------------------------  
|No|Register|Description
----|----|----
|000| R0| Accumlator|   
|001| R1| General Perpus Register|
|010| R2| General Perpus Register|
|011| R3| General Perpus Register|
|100| R4| General Perpus Register|
|101| R5| INPUT PORT(read only)|  
|110| R6| OUTPUT PORT(write only)|  
|111| R7| Program Counter(PC)|  

# Instruction Set  (8 bit)
------------------------  
|Binary|Assebler|Description|
----|----|----
|01-000-sss| ADD (sss)|  acc=acc+(sss)|  
|01-001-sss| OR (sss)|   acc=acc or (sss)|  
|01-010-sss| AND (sss)|  acc = acc & (sss)|  
|01-011-sss| XOR (sss)|  acc = acc ^ (sss) | 
|01-100-sss| INC (sss)|  (sss)=(sss)+1|  
|01-101-sss| NOT (sss)|  (sss)=!(sss)|  
|01-110-sss| RSHIFT (sss)|(sss)=(sss)>>1 (to be done)|  
|01-111-sss| LSHIFT (sss)|(sss)=(sss)<<1 (to be done)|  
|10-00-####| JNC #### |if (C==0) PC=#### else PC=PC+1|  
|10-01-####| JMP #### |PC = ####|  
|10-10-####| SET #### |acc=####|  
|00-ddd-sss| MOV (ddd),(sss)|(ddd)=(sss)|

# Carry flag
------------------------  
The instruction sets for which the carry flag is set are ADD and INC. The set carry flag does not change until these instructions are executed. Also, if the carry flag is set, the register value is undefined.

# Files
------------------------  
DL166.v  
CPU and Memory Verilog-HDL Source files  

testbench3.v  
Test bech for DL166  

rom.v
Memory module and set pre installed program

asm.txt  
sample code to test DL166.  
// this program is counting up R0 register and show this on LEDs.  
00: inc R6 // 01100110   
01: jmp 0  // 10010000

# Known bugs
------------------------  

Carry flag behavior is incomprehensible. I must define a condition that clears the carry flag.
It is fixed on 2020/09/14
