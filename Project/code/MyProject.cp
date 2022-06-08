#line 1 "C:/Users/abdullah/Desktop/New folder/code/MyProject.c"









float duty=30;

char flag=0;
char start=0;
char count=0;
char segment[]={0X3F,0X06,0X5B,0X4F,0X66,0X6D,0X7D,0X07,0X7F,0X6F};

void interrupt()
{
INTCON.INTF=0;
start=1;
if(duty==100)
flag=1;
if(duty==40)
flag=0;
if(flag==0)
duty=duty+10;
else
duty=duty-10;
pwm1_set_duty(duty*255/100);
return ;
}

void main() {
trisc=0;portc=0;
trisd=0; porta = 0;
trisb=0b11000111; portb = 0;
portd=segment[0];

intcon.inte=1;
intcon.gie=1;
option_reg.intedg=1;

pwm1_init(2000);
pwm1_start();

while(start==0);
loop:
while( portb.f6 ==1 &&  portb.f7 ==1);

if ( portb.f6 ==0&&  portb.f7 ==1 &&count<9)
{
 portc.f3 =1;
 portc.f0 =0;
  portb.f4 =1;
 while( portb.f1 ==0 &&  portb.f6 ==0);
  portb.f4 =0;
 while( portb.f6 ==0 &&  portb.f7 ==1);
 while( portb.f6 ==0 &&  portb.f7 ==0 );
 if( portb.f7 ==0 &&  portb.f6 ==1)
 {
 count++ ;
 portd=segment[count];
 }
 while( portb.f6 ==1 &&  portb.f7 ==0);
 while( portb.f2 ==0 &&  portb.f6 ==1 &&  portb.f7 ==1)
 {
  portb.f5 =1;
  portc.f3 =0;
  portc.f0 =0;
 }
  portb.f5 =0;

}

else if( portb.f6 ==1 &&  portb.f7 ==0)
{
 portc.f3 =0;
 portc.f0 =1;
while( portb.f1 ==0 &&  portb.f7 ==0)
{
 portb.f4 =1;
}
 portb.f4 =0;
while( portb.f7 ==0 &&  portb.f6  == 1);
while( portb.f6 ==0 &&  portb.f7 ==0 );
if( portb.f7 ==1 &&  portb.f6 ==0)
{
count--;
portd=segment[count];
}
while( portb.f6 ==0 &&  portb.f7 ==1);
while( portb.f2 ==0 &&  portb.f6 ==1 &&  portb.f7 ==1)
{
 portb.f5 =1;
 portc.f3 =0;
 portc.f0 =0;
}
 portb.f5 =0;
}

if(count==9)
 portc.f0 =1;

goto loop;
}
