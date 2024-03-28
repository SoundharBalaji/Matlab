#include<LPC214x.h>
#define TEMT 0x40
#define r1 (1<<16)
#define r2 (1<<17)
#define r3 (1<<18)
#define r4 (1<<19)
#define c1 (1<<20)
#define c2 (1<<21)
#define c3 (1<<22)
#define c4 (1<<23)
#define S7SEG_ENB 0x00B80000;
#define DIGI1_ENB 0x00800000;
#define S7SEG_LED 0xff000000;
unsigned int thousands,hundreds,tens,ones;
void init_Matrix_7seg(void)
{
IODIR1|=0xfff00000;
IODIR0|=S7SEG_ENB;
IOPIN0|=S7SEG_ENB;
}
void keypad_delay(void)
{
unsigned int t1;
t1=5000;
while(t1--);
}
unsigned int keypad(void)
{
unsigned int key;
IOCLR1|=(c1|c2|c3|c4|r1|r2|r3|r4);
while(1)
{
IOCLR1|=c1;
IOSET1|=(c2|c3|c4);
if((IOPIN1&r1)==0)
{
key=1;
keypad_delay();
return key;
}
else if((IOPIN1&r2)==0)
{
key=5;
keypad_delay();
return key;
}
else if((IOPIN1&r3)==0)
{	
key=9;
keypad_delay();
return key;
}
else if((IOPIN1&r4)==0)
{	
key=13;
keypad_delay();
return key;
}
IOCLR1|=c2;
IOSET1|=(c1|c3|c4);
if((IOPIN1&r1)==0)
{
key=2;
keypad_delay();
return key;
}
else if((IOPIN1&r2)==0)
{
key=6;
keypad_delay();
return key;
}
else if((IOPIN1&r3)==0)
{	
key=10;
keypad_delay();
return key;
}
else if((IOPIN1&r4)==0)
{	
key=14;
keypad_delay();
return key;
}
IOCLR1|=c3;
IOSET1|=(c1|c2|c4);
if((IOPIN1&r1)==0)
{
key=3;
keypad_delay();
return key;
}
else if((IOPIN1&r2)==0)
{
key=7;
keypad_delay();
return key;
}
else if((IOPIN1&r3)==0)
{	
key=11;
keypad_delay();
return key;
}
else if((IOPIN1&r4)==0)
{	
key=15;
keypad_delay();
return key;
}
IOCLR1|=c4;
IOSET1|=(c1|c2|c3);
if((IOPIN1&r1)==0)
{
key=4;
keypad_delay();
return key;
}
else if((IOPIN1&r2)==0)
{
key=8;
keypad_delay();
return key;
}
else if((IOPIN1&r3)==0)										
{	
key=12;
keypad_delay();
return key;
}
else if((IOPIN1&r4)==0)
{	
key=16;
keypad_delay();
return key;
}
}
}
void Alpha_Dispay(unsigned int value)
{
IOPIN0|=S7SEG_ENB;
IOPIN0=~DIGI1_ENB;
IOPIN1&=~S7SEG_LED;
switch(value)
{
case 1:IOPIN1|=0x3F000000;break;
case 2:IOPIN1|=0x06000000;break;
case 3:IOPIN1|=0x5B000000;break;
case 4:IOPIN1|=0x4F000000;break;
case 5:IOPIN1|=0x66000000;break;
case 6:IOPIN1|=0x6D000000;break;
case 7:IOPIN1|=0x7D000000;break;
case 8:IOPIN1|=0x07000000;break;
case 9:IOPIN1|=0x7F000000;break;
case 10:IOPIN1|=0x6F000000;break;

case 11:IOPIN1|=0x77000000;break;
case 12:IOPIN1|=0x7C000000;break;
case 13:IOPIN1|=0x39000000;break;
case 14:IOPIN1|=0x5E000000;break;
case 15:IOPIN1|=0x79000000;break;
case 16:IOPIN1|=0x71000000;break;
}
}
 int main()
 {
 unsigned int get_key,last_key,Disp_key;
 init_Matrix_7seg();
 IOPIN1&=~S7SEG_LED;
 IOPIN0|=S7SEG_ENB;
 last_key=0;
 while(1)
 {
 get_key=keypad();
 if(get_key!=0)
 {
 if(get_key!=last_key)
 {
 Disp_key=get_key;
 last_key=get_key;
 }
 }
 Alpha_Dispay(Disp_key);
 }
 }



