
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,17 :: 		void interrupt()
;MyProject.c,19 :: 		INTCON.INTF=0;
	BCF        INTCON+0, 1
;MyProject.c,20 :: 		start=1;
	MOVLW      1
	MOVWF      _start+0
;MyProject.c,21 :: 		if(duty==100)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       _duty+0, 0
	MOVWF      R0+0
	MOVF       _duty+1, 0
	MOVWF      R0+1
	MOVF       _duty+2, 0
	MOVWF      R0+2
	MOVF       _duty+3, 0
	MOVWF      R0+3
	CALL       _Equals_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt0
;MyProject.c,22 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
L_interrupt0:
;MyProject.c,23 :: 		if(duty==40)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _duty+0, 0
	MOVWF      R0+0
	MOVF       _duty+1, 0
	MOVWF      R0+1
	MOVF       _duty+2, 0
	MOVWF      R0+2
	MOVF       _duty+3, 0
	MOVWF      R0+3
	CALL       _Equals_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt1
;MyProject.c,24 :: 		flag=0;
	CLRF       _flag+0
L_interrupt1:
;MyProject.c,25 :: 		if(flag==0)
	MOVF       _flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;MyProject.c,26 :: 		duty=duty+10;
	MOVF       _duty+0, 0
	MOVWF      R0+0
	MOVF       _duty+1, 0
	MOVWF      R0+1
	MOVF       _duty+2, 0
	MOVWF      R0+2
	MOVF       _duty+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _duty+0
	MOVF       R0+1, 0
	MOVWF      _duty+1
	MOVF       R0+2, 0
	MOVWF      _duty+2
	MOVF       R0+3, 0
	MOVWF      _duty+3
	GOTO       L_interrupt3
L_interrupt2:
;MyProject.c,28 :: 		duty=duty-10;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _duty+0, 0
	MOVWF      R0+0
	MOVF       _duty+1, 0
	MOVWF      R0+1
	MOVF       _duty+2, 0
	MOVWF      R0+2
	MOVF       _duty+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _duty+0
	MOVF       R0+1, 0
	MOVWF      _duty+1
	MOVF       R0+2, 0
	MOVWF      _duty+2
	MOVF       R0+3, 0
	MOVWF      _duty+3
L_interrupt3:
;MyProject.c,29 :: 		pwm1_set_duty(duty*255/100);
	MOVF       _duty+0, 0
	MOVWF      R0+0
	MOVF       _duty+1, 0
	MOVWF      R0+1
	MOVF       _duty+2, 0
	MOVWF      R0+2
	MOVF       _duty+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,30 :: 		return ;
;MyProject.c,31 :: 		}
L_end_interrupt:
L__interrupt80:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,33 :: 		void main() {
;MyProject.c,34 :: 		trisc=0;portc=0;
	CLRF       TRISC+0
	CLRF       PORTC+0
;MyProject.c,35 :: 		trisd=0; porta = 0;
	CLRF       TRISD+0
	CLRF       PORTA+0
;MyProject.c,36 :: 		trisb=0b11000111; portb = 0;
	MOVLW      199
	MOVWF      TRISB+0
	CLRF       PORTB+0
;MyProject.c,37 :: 		portd=segment[0];
	MOVF       _segment+0, 0
	MOVWF      PORTD+0
;MyProject.c,39 :: 		intcon.inte=1;
	BSF        INTCON+0, 4
;MyProject.c,40 :: 		intcon.gie=1;
	BSF        INTCON+0, 7
;MyProject.c,41 :: 		option_reg.intedg=1;
	BSF        OPTION_REG+0, 6
;MyProject.c,43 :: 		pwm1_init(2000);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;MyProject.c,44 :: 		pwm1_start();
	CALL       _PWM1_Start+0
;MyProject.c,46 :: 		while(start==0);
L_main4:
	MOVF       _start+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;MyProject.c,47 :: 		loop:                                 //main loop
___main_loop:
;MyProject.c,48 :: 		while(enter==1 && exit==1);
L_main6:
	BTFSS      PORTB+0, 6
	GOTO       L_main7
	BTFSS      PORTB+0, 7
	GOTO       L_main7
L__main78:
	GOTO       L_main6
L_main7:
;MyProject.c,50 :: 		if (enter==0&& exit==1 &&count<9)   // when enter car
	BTFSC      PORTB+0, 6
	GOTO       L_main12
	BTFSS      PORTB+0, 7
	GOTO       L_main12
	MOVLW      9
	SUBWF      _count+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main12
L__main77:
;MyProject.c,52 :: 		dontExit=1;
	BSF        PORTC+0, 3
;MyProject.c,53 :: 		dontEnter=0;
	BCF        PORTC+0, 0
;MyProject.c,54 :: 		open=1;
	BSF        PORTB+0, 4
;MyProject.c,55 :: 		while(up==0 && enter==0);
L_main13:
	BTFSC      PORTB+0, 1
	GOTO       L_main14
	BTFSC      PORTB+0, 6
	GOTO       L_main14
L__main76:
	GOTO       L_main13
L_main14:
;MyProject.c,56 :: 		open=0;
	BCF        PORTB+0, 4
;MyProject.c,57 :: 		while(enter==0 && exit==1);
L_main17:
	BTFSC      PORTB+0, 6
	GOTO       L_main18
	BTFSS      PORTB+0, 7
	GOTO       L_main18
L__main75:
	GOTO       L_main17
L_main18:
;MyProject.c,58 :: 		while(enter==0 && exit==0 );
L_main21:
	BTFSC      PORTB+0, 6
	GOTO       L_main22
	BTFSC      PORTB+0, 7
	GOTO       L_main22
L__main74:
	GOTO       L_main21
L_main22:
;MyProject.c,59 :: 		if(exit==0 && enter==1)
	BTFSC      PORTB+0, 7
	GOTO       L_main27
	BTFSS      PORTB+0, 6
	GOTO       L_main27
L__main73:
;MyProject.c,61 :: 		count++ ;
	INCF       _count+0, 1
;MyProject.c,62 :: 		portd=segment[count];
	MOVF       _count+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,63 :: 		}
L_main27:
;MyProject.c,64 :: 		while(enter==1 && exit==0);
L_main28:
	BTFSS      PORTB+0, 6
	GOTO       L_main29
	BTFSC      PORTB+0, 7
	GOTO       L_main29
L__main72:
	GOTO       L_main28
L_main29:
;MyProject.c,65 :: 		while(down==0 && enter==1 && exit==1)
L_main32:
	BTFSC      PORTB+0, 2
	GOTO       L_main33
	BTFSS      PORTB+0, 6
	GOTO       L_main33
	BTFSS      PORTB+0, 7
	GOTO       L_main33
L__main71:
;MyProject.c,67 :: 		close=1;
	BSF        PORTB+0, 5
;MyProject.c,68 :: 		dontExit=0;
	BCF        PORTC+0, 3
;MyProject.c,69 :: 		dontEnter=0;
	BCF        PORTC+0, 0
;MyProject.c,70 :: 		}
	GOTO       L_main32
L_main33:
;MyProject.c,71 :: 		close=0;
	BCF        PORTB+0, 5
;MyProject.c,73 :: 		}
	GOTO       L_main36
L_main12:
;MyProject.c,75 :: 		else if(enter==1 && exit==0)     //  when exit car
	BTFSS      PORTB+0, 6
	GOTO       L_main39
	BTFSC      PORTB+0, 7
	GOTO       L_main39
L__main70:
;MyProject.c,77 :: 		dontExit=0;
	BCF        PORTC+0, 3
;MyProject.c,78 :: 		dontEnter=1;
	BSF        PORTC+0, 0
;MyProject.c,79 :: 		while(up==0 && exit==0)
L_main40:
	BTFSC      PORTB+0, 1
	GOTO       L_main41
	BTFSC      PORTB+0, 7
	GOTO       L_main41
L__main69:
;MyProject.c,81 :: 		open=1;
	BSF        PORTB+0, 4
;MyProject.c,82 :: 		}
	GOTO       L_main40
L_main41:
;MyProject.c,83 :: 		open=0;
	BCF        PORTB+0, 4
;MyProject.c,84 :: 		while(exit==0 && enter == 1);
L_main44:
	BTFSC      PORTB+0, 7
	GOTO       L_main45
	BTFSS      PORTB+0, 6
	GOTO       L_main45
L__main68:
	GOTO       L_main44
L_main45:
;MyProject.c,85 :: 		while(enter==0 && exit==0 );
L_main48:
	BTFSC      PORTB+0, 6
	GOTO       L_main49
	BTFSC      PORTB+0, 7
	GOTO       L_main49
L__main67:
	GOTO       L_main48
L_main49:
;MyProject.c,86 :: 		if(exit==1 && enter==0)
	BTFSS      PORTB+0, 7
	GOTO       L_main54
	BTFSC      PORTB+0, 6
	GOTO       L_main54
L__main66:
;MyProject.c,88 :: 		count--;
	DECF       _count+0, 1
;MyProject.c,89 :: 		portd=segment[count];
	MOVF       _count+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,90 :: 		}
L_main54:
;MyProject.c,91 :: 		while(enter==0 && exit==1);
L_main55:
	BTFSC      PORTB+0, 6
	GOTO       L_main56
	BTFSS      PORTB+0, 7
	GOTO       L_main56
L__main65:
	GOTO       L_main55
L_main56:
;MyProject.c,92 :: 		while(down==0 && enter==1 && exit==1)
L_main59:
	BTFSC      PORTB+0, 2
	GOTO       L_main60
	BTFSS      PORTB+0, 6
	GOTO       L_main60
	BTFSS      PORTB+0, 7
	GOTO       L_main60
L__main64:
;MyProject.c,94 :: 		close=1;
	BSF        PORTB+0, 5
;MyProject.c,95 :: 		dontExit=0;
	BCF        PORTC+0, 3
;MyProject.c,96 :: 		dontEnter=0;
	BCF        PORTC+0, 0
;MyProject.c,97 :: 		}
	GOTO       L_main59
L_main60:
;MyProject.c,98 :: 		close=0;
	BCF        PORTB+0, 5
;MyProject.c,99 :: 		}
L_main39:
L_main36:
;MyProject.c,101 :: 		if(count==9)                     // garage is full
	MOVF       _count+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_main63
;MyProject.c,102 :: 		dontEnter=1;
	BSF        PORTC+0, 0
L_main63:
;MyProject.c,104 :: 		goto loop;
	GOTO       ___main_loop
;MyProject.c,105 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
