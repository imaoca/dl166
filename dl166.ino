#include "LedControl.h"
LedControl lc=LedControl(7,5,6,1);
unsigned char reg[8],mem[16],inst,c_flag,dip,cnt;
unsigned char pin[]={11,10,4,3,2,14,15,16,17,18,19};
unsigned char prg[16]={0x60,0x80,0xa0,0x90,0x00,0x61,0x41,0x86,0x60,0x98,0x60,0x78,0x9b,0x60,0x70,0x9e};

void setup() {
  lc.shutdown(0,false);lc.setIntensity(0,8);lc.clearDisplay(0);// led diplay setup
  for (int i=0;i<11;i++) pinMode(pin[i],INPUT_PULLUP);
  pinMode(13, OUTPUT);      // clock blink 
  reg[0],reg[1],reg[2],reg[3],reg[4],reg[5],reg[6],reg[7],c_flag,cnt=0;
  if (digitalRead(2))for (int i=0;i<16;i++) mem[i]=prg[i];
}
void cpu(){
  if ((cnt++)>60) {
    digitalWrite(13, !digitalRead(13));cnt=0;
    reg[4]=dip &0x0f;
    inst = mem[reg[7]];
/*MOV*/    if (0x00==(inst&0xc0)) reg[(inst&0x38)>>3]=reg[inst&7]; 
/*add*/    if (0x40==(inst&0xf8)) if ((reg[0]+=reg[inst&7])>15) c_flag=1;
/*or*/     if (0x48==(inst&0xf8)) reg[0]|=reg[inst&7];
/*and*/    if (0x50==(inst&0xf8)) reg[0]&=reg[inst&7];
/*xor*/    if (0x58==(inst&0xf8)) reg[0]^=reg[inst&7];
/*inc*/    if (0x60==(inst&0xf8)) if ((reg[inst&7]++)>15) c_flag=1;
/*not*/    if (0x61==(inst&0xf8)) reg[inst&7]=!reg[inst&7];
/*lrotate*/if (0x70==(inst&0xf8)) reg[inst&7]=((reg[inst&7])>>1)|((reg[inst&7]&0x01) << 3);
/*lrotate*/if (0x78==(inst&0xf8)) reg[inst&7]=((reg[inst&7])<<1)|((reg[inst&7]&0x08) >> 3);
/*jnc*/    if (0x80==(inst&0xf0)) {reg[7]=(c_flag)?reg[7]+1:inst&0x0f;c_flag=0;}
/*jmp*/    if (0x90==(inst&0xf0)) reg[7]=inst&0x0f;
/*mvi*/    if (0xa0==(inst&0xf0)) reg[0]=inst&0x0f;
    if ((0x90!=(inst&0xf0)&&(0x80!=(inst&0xf0)))) reg[7]++;
    }
  }
void loop() {
  dip=!digitalRead(14)+(!digitalRead(15))*2+(!digitalRead(16))*4+(!digitalRead(17))*8+(!digitalRead(18))*16+(!digitalRead(19))*32+(!digitalRead(3))*64+(!digitalRead(2))*128;
  if (digitalRead(4)==0){ // run mode
    cpu();  
    for (int i=0;i<8;i++)lc.setColumn(0,i,reg[i]);
    lc.setColumn(0,4,(reg[4]|(c_flag<<7)));  
  }
  else {                  // programing mode 
    for (int i=0;i<8;i++) lc.setColumn(0,i,(mem[i+(8*(reg[7]>7))])^dip*(i==(reg[7]%8)));delay(100);  
    for (int i=0;i<8;i++) lc.setColumn(0,i,(mem[i+(8*(reg[7]>7))]));delay(100);  
    if (!digitalRead(11)){reg[7]=(reg[7]<15)?reg[7]+1:0;delay(200);}
    if (!digitalRead(10)){mem[reg[7]]=dip;delay(1000);}
  }
}
