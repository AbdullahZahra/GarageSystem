#define down portb.f2
#define up portb.f1
#define open portb.f4
#define close portb.f5
#define enter portb.f6
#define exit portb.f7
#define dontEnter portc.f0
#define dontExit portc.f3

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
loop:                                 //main loop
while(enter==1 && exit==1);
//--------------------------------------------------------------------------
if (enter==0&& exit==1 &&count<9)   // when enter car
{
dontExit=1;
dontEnter=0;
 open=1;
 while(up==0 && enter==0);
 open=0;
 while(enter==0 && exit==1);
 while(enter==0 && exit==0 );
 if(exit==0 && enter==1)
  {
    count++ ;
    portd=segment[count];
  }
  while(enter==1 && exit==0);
 while(down==0 && enter==1 && exit==1)
  {
    close=1;
    dontExit=0;
    dontEnter=0;
  }
  close=0;

}
//-------------------------------------------------------------------------
else if(enter==1 && exit==0)     //  when exit car
{
dontExit=0;
dontEnter=1;
while(up==0 && exit==0)
{
open=1;
}
open=0;
while(exit==0 && enter == 1);
while(enter==0 && exit==0 );
if(exit==1 && enter==0)
{
count--;
portd=segment[count];
}
while(enter==0 && exit==1);
while(down==0 && enter==1 && exit==1)
{
close=1;
dontExit=0;
dontEnter=0;
}
close=0;
}
//--------------------------------------------------------------------------
if(count==9)                     // garage is full
dontEnter=1;

goto loop;
}