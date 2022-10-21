;CodeVisionAVR C Compiler V1.24.1d Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.ro
;e-mail:office@hpinfotech.ro

;Chip type           : ATmega168
;Program type        : Application
;Clock frequency     : 8,000000 MHz
;Memory model        : Small
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : long, width
;External SRAM size  : 0
;Data Stack size     : 256 byte(s)
;Heap size           : 0 byte(s)
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "bps.vec"
	.INCLUDE "bps.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	IN   R26,MCUSR
	OUT  MCUSR,R30
	STS  WDTCSR,R31
	STS  WDTCSR,R30
	OUT  MCUSR,R26

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	LDI  R30,__GPIOR1_INIT
	OUT  GPIOR1,R30
	LDI  R30,__GPIOR2_INIT
	OUT  GPIOR2,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x4FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x4FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x200)
	LDI  R29,HIGH(0x200)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x200
;       1 #define F_REF 8000000L
;       2 #define F_COMP 10000L
;       3 #include <mega168.h>
;       4 #include <delay.h> 
;       5 
;       6 //#define KAN_XTAL	8
;       7 #define KAN_XTAL	10  
;       8 //#define KAN_XTAL	20 
;       9 #include "cmd.c"
;      10 //-----------------------------------------------
;      11 // Символы передач
;      12 #define REGU 0xf5
;      13 #define REGI 0xf6
;      14 #define GetTemp 0xfc
;      15 #define TVOL0 0x75
;      16 #define TVOL1 0x76
;      17 #define TVOL2 0x77
;      18 #define TTEMPER	0x7c
;      19 #define CSTART  0x1a
;      20 #define CMND	0x16
;      21 #define Blok_flip	0x57
;      22 #define END 	0x0A
;      23 #define QWEST	0x25
;      24 #define IM	0x52
;      25 #define Add_kf 0x60
;      26 #define Sub_kf 0x61
;      27 #define ALRM_RES 0x63
;      28 #define Zero_kf2 0x64
;      29 #define MEM_KF 0x62 
;      30 #define MEM_KF1 0x26
;      31 #define MEM_KF2 0x27
;      32 #define BLKON 0x80
;      33 #define BLKOFF 0x81
;      34 //#define Put_reg 0x90
;      35 #define GETID 0x90
;      36 #define PUTID 0x91
;      37 #define PUTTM1 0xDA
;      38 #define PUTTM2 0xDB
;      39 #define PUTTM 0xDE
;      40 #define GETTM 0xED 
;      41 #define KLBR 0xEE
;      42 #define XMAX 25
;      43   
;      44 #include <stdio.h>
;      45 #include <math.h>
;      46 
;      47 #define ON 0x55
;      48 #define OFF 0xaa
;      49 
;      50 //#define _220_
;      51 #define _24_
;      52 
;      53 bit bJP; //джампер одет 
;      54 bit b100Hz;
;      55 bit b33Hz;
;      56 bit b10Hz;
;      57 bit b5Hz;
;      58 bit b1Hz;
;      59 bit bFl_; 
;      60 bit bBL;
;      61 
;      62 char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4,cnt_ind,adc_cnt0,adc_cnt1; 
_adc_cnt0:
	.BYTE 0x1
_adc_cnt1:
	.BYTE 0x1
;      63 /*bit l_but;	//идет длинное нажатие на кнопку
;      64 bit n_but=0;     //произошло нажатие
;      65 bit speed;	//разрешение ускорения перебора
;      66 bit bFl_;
;      67 
;      68 bit zero_on;		
;      69 bit bFr_ch=0;
;      70 bit bR;
;      71 bit bT1;
;      72 
;      73 enum char {iH,iT,iPrl,iK,iSet}ind; 
;      74 signed char sub_ind;
;      75 unsigned int adc_bank[4][16],adc_bank_[4];
;      76 bit bCh;*/
;      77 
;      78 signed int tabl[]={0/*0*/,72/*40*/,125/*80*/,177/*120*/,217/*160*/,254/*200*/,286/*240*/,318/*280*/,346/*320*/,372/*360*/,400/*400*/,427,453,478,502,525};
_tabl:
	.BYTE 0x20
;      79 
;      80 eeprom int freq;

	.ESEG
_freq:
	.DW  0x0
;      81 eeprom char stereo,p_out;
_stereo:
	.DB  0x0
_p_out:
	.DB  0x0
;      82 
;      83 char lcd_flash0=0; 

	.DSEG
_lcd_flash0:
	.BYTE 0x1
;      84 char lcd_flashx0=0;
_lcd_flashx0:
	.BYTE 0x1
;      85 char lcd_flashy0=0;
_lcd_flashy0:
	.BYTE 0x1
;      86 //char lcd_flash1=0; 
;      87 //char lcd_flashx1=0;
;      88 //char lcd_flashy1=0;
;      89 unsigned char volum;
_volum:
	.BYTE 0x1
;      90 eeprom unsigned char volum_ee;

	.ESEG
_volum_ee:
	.DB  0x0
;      91 
;      92 
;      93 int vol_u,vol_i;

	.DSEG
_vol_u:
	.BYTE 0x2
_vol_i:
	.BYTE 0x2
;      94 
;      95 unsigned int adc_buff[4][16],adc_buff_[4];
_adc_buff:
	.BYTE 0x80
_adc_buff_:
	.BYTE 0x8
;      96 char adc_cnt,adc_ch;
_adc_cnt:
	.BYTE 0x1
_adc_ch:
	.BYTE 0x1
;      97 
;      98 eeprom signed int K[4][2]; 

	.ESEG
_K:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;      99 
;     100 unsigned int I,Un,Ui,Udb;

	.DSEG
_I:
	.BYTE 0x2
_Un:
	.BYTE 0x2
_Ui:
	.BYTE 0x2
_Udb:
	.BYTE 0x2
;     101 signed T;
_T:
	.BYTE 0x2
;     102 char flags=0; // состояние источника
_flags:
	.BYTE 0x1
;     103 // 0 -  если одет джампер то 0, если нет то 1
;     104 // 1 -  авария по Tmax (1-активн.);
;     105 // 2 -  авария по Tsign (1-активн.);
;     106 // 3 -  авария по Umax (1-активн.);
;     107 // 4 -  авария по Umin (1-активн.);
;     108 // 5 -  блокировка извне (1-активн.); 
;     109 // 6 -  блокировка извне защит(1-активн.);
;     110 
;     111 char flags_tu; // управляющее слово от хоста
_flags_tu:
	.BYTE 0x1
;     112 // 0 -  блокировка, если 1 то заблокировать 
;     113 // 1 -  блокировка извне защит(1-активн.); 
;     114 
;     115 unsigned int  vol_u_temp,vol_i_temp;
_vol_u_temp:
	.BYTE 0x2
_vol_i_temp:
	.BYTE 0x2
;     116 long led_red=0x55555550L,led_green=0xaaaaaaaaL;
_led_red:
	.BYTE 0x4
_led_green:
	.BYTE 0x4
;     117 char link,link_cnt;
_link:
	.BYTE 0x1
_link_cnt:
	.BYTE 0x1
;     118 char led_drv_cnt=30;
_led_drv_cnt:
	.BYTE 0x1
;     119 eeprom signed int Umax,dU,tmax,tsign;

	.ESEG
_Umax:
	.DW  0x0
_dU:
	.DW  0x0
_tmax:
	.DW  0x0
_tsign:
	.DW  0x0
;     120 signed tsign_cnt,tmax_cnt; 

	.DSEG
_tsign_cnt:
	.BYTE 0x2
_tmax_cnt:
	.BYTE 0x2
;     121 unsigned int pwm_u=50,pwm_i=50;
_pwm_u:
	.BYTE 0x2
_pwm_i:
	.BYTE 0x2
;     122 signed umax_cnt,umin_cnt;
_umax_cnt:
	.BYTE 0x2
_umin_cnt:
	.BYTE 0x2
;     123 char flags_tu_cnt_on,flags_tu_cnt_off; 
_flags_tu_cnt_on:
	.BYTE 0x1
_flags_tu_cnt_off:
	.BYTE 0x1
;     124 char adr_new,adr_old,adr_temp,adr_cnt;
_adr_new:
	.BYTE 0x1
_adr_old:
	.BYTE 0x1
_adr_temp:
	.BYTE 0x1
_adr_cnt:
	.BYTE 0x1
;     125 eeprom char adr;

	.ESEG
_adr:
	.DB  0x0
;     126 char cnt_JP0,cnt_JP1;

	.DSEG
_cnt_JP0:
	.BYTE 0x1
_cnt_JP1:
	.BYTE 0x1
;     127 enum {jp0,jp1,jp2,jp3} jp_mode;
_jp_mode:
	.BYTE 0x1
;     128 int main_cnt1;
_main_cnt1:
	.BYTE 0x2
;     129 signed _x_,_x__; 
__x_:
	.BYTE 0x2
__x__:
	.BYTE 0x2
;     130 int _x_cnt;
__x_cnt:
	.BYTE 0x2
;     131 eeprom signed _x_ee_;

	.ESEG
__x_ee_:
	.DW  0x0
;     132 eeprom int U_AVT;
_U_AVT:
	.DW  0x0
;     133 eeprom char U_AVT_ON;
_U_AVT_ON:
	.DB  0x0
;     134 
;     135 int main_cnt; 

	.DSEG
_main_cnt:
	.BYTE 0x2
;     136 eeprom char TZAS;             

	.ESEG
_TZAS:
	.DB  0x0
;     137 char plazma;

	.DSEG
_plazma:
	.BYTE 0x1
;     138 int plazma_int[3];
_plazma_int:
	.BYTE 0x6
;     139 int adc_ch_2_max,adc_ch_2_min;
_adc_ch_2_max:
	.BYTE 0x2
_adc_ch_2_min:
	.BYTE 0x2
;     140 char adc_ch_2_delta;
_adc_ch_2_delta:
	.BYTE 0x1
;     141 char cnt_adc_ch_2_delta;
_cnt_adc_ch_2_delta:
	.BYTE 0x1
;     142 char apv_cnt[3];
_apv_cnt:
	.BYTE 0x3
;     143 int apv_cnt_;
_apv_cnt_:
	.BYTE 0x2
;     144 char bAPV;
_bAPV:
	.BYTE 0x1
;     145 char cnt_apv_off;
_cnt_apv_off:
	.BYTE 0x1
;     146 
;     147 eeprom char res_fl,res_fl_;

	.ESEG
_res_fl:
	.DB  0x0
_res_fl_:
	.DB  0x0
;     148 char bRES=0;

	.DSEG
_bRES:
	.BYTE 0x1
;     149 char bRES_=0; 
_bRES_:
	.BYTE 0x1
;     150 char res_fl_cnt;
_res_fl_cnt:
	.BYTE 0x1
;     151 char off_bp_cnt;
_off_bp_cnt:
	.BYTE 0x1
;     152 //eeprom char adr_ee;
;     153 
;     154 flash char CONST_ADR[]={0b00000111,0b00000111,0b00000111,0b00000010,0b00000011,0b00000001,0b00000000,0b00000111};

	.CSEG
;     155 
;     156 char can_error_cnt;

	.DSEG
_can_error_cnt:
	.BYTE 0x1
;     157 
;     158 #include "can_slave.c"
;     159 #define CS_DDR	DDRD.1
;     160 #define CS	PORTD.1  
;     161 #define SPI_PORT_INIT  DDRB|=0b00101100;DDRB.4=0; 
;     162 //#define _220_
;     163 //#define _24_
;     164 #include "mcp2510.h"

	.CSEG
_mcp_reset:
	cli
	CALL SUBOPT_0x0
	CBI  0x4,4
	SBI  0xA,1
	CBI  0xB,1
	SBI  0xB,1
	sei
	RET
_spi_read:
	ST   -Y,R16
;	addr -> Y+1
;	temp -> R16
	cli
	CALL SUBOPT_0x0
	CBI  0x4,4
	SBI  0xA,1
	CBI  0xB,1
	__DELAY_USB 27
	LDI  R30,LOW(3)
	CALL SUBOPT_0x1
	CALL SUBOPT_0x2
	SBI  0xB,1
	sei
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,2
	RET
_spi_bit_modify:
	cli
	CALL SUBOPT_0x0
	CBI  0x4,4
	SBI  0xA,1
	CBI  0xB,1
	LDI  R30,LOW(5)
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
	SBI  0xB,1
	sei
	ADIW R28,3
	RET
_spi_write:
	ST   -Y,R16
;	addr -> Y+2
;	in -> Y+1
;	temp -> R16
	cli
	CALL SUBOPT_0x0
	CBI  0x4,4
	SBI  0xA,1
	CBI  0xB,1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x3
	SBI  0xB,1
	sei
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,3
	RET
_spi_read_status:
	ST   -Y,R16
;	temp -> R16
	cli
	CALL SUBOPT_0x0
	CBI  0x4,4
	SBI  0xA,1
	CBI  0xB,1
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	LDI  R30,LOW(160)
	ST   -Y,R30
	CALL _spi
	CALL SUBOPT_0x2
	SBI  0xB,1
	sei
	MOV  R30,R16
	LD   R16,Y+
	RET
	cli
	sei
_spi_rts:
	cli
	CALL SUBOPT_0x0
	CBI  0x4,4
	SBI  0xA,1
	CBI  0xB,1
	LD   R30,Y
	CPI  R30,0
	BRNE _0x9
	LDI  R30,LOW(129)
	ST   Y,R30
	RJMP _0xA
_0x9:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0xB
	LDI  R30,LOW(130)
	ST   Y,R30
	RJMP _0xC
_0xB:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0xD
	LDI  R30,LOW(132)
	ST   Y,R30
_0xD:
_0xC:
_0xA:
	CALL SUBOPT_0x4
	SBI  0xB,1
	sei
	ADIW R28,1
	RET
;	in -> Y+1
;	temp -> R16
;	in -> Y+1
;	temp -> R16
;	in -> Y+1
;	temp -> R16
;	in -> Y+1
;	temp -> R16
;	sidh -> Y+7
;	sidl -> Y+6
;	eid8 -> Y+5
;	eid0 -> Y+4
;	temp -> Y+0
;     165 
;     166 extern flash char Table87[];
;     167 extern flash char Table95[];
;     168 extern void gran(signed int *adr, signed int min, signed int max);
;     169 /*
;     170 
;     171 
;     172 char cob1[10],cib1[20];
;     173 
;     174 char ch_cnt1;
;     175 bit bch_1Hz1;
;     176 bit bADRISON1,bADRISRQWST1;
;     177 char random1[4];
;     178 char tr_buff1[8];
;     179 
;     180 
;     181 
;     182 
;     183 
;     184 char bd1[25]; 
;     185 */
;     186 //#define CNF1_init	0b00000100  //tq=500ns   //20MHz
;     187 /*
;     188 #define CNF1_init	0b11000000  //tq=500ns   //8MHz
;     189 #define CNF2_init	0b11110001  //Ps1=7tq,Pr=2tq 
;     190 #define CNF3_init	0b00000010  //Ps2=6tq */
;     191 
;     192 #if(KAN_XTAL==8)
;     193 #define CNF1_init	0b11000011  //tq=500ns   //8MHz
;     194 #define CNF2_init	0b11111011  //Ps1=7tq,Pr=2tq 
;     195 #define CNF3_init	0b00000010  //Ps2=6tq   
;     196 #elif(KAN_XTAL==10)
;     197 #define CNF1_init	0b11000011  //tq=500ns   //10MHz
;     198 #define CNF2_init	0b11111110  //Ps1=7tq,Pr=2tq 
;     199 #define CNF3_init	0b00000011  //Ps2=6tq
;     200 #elif(KAN_XTAL==20)
;     201 #define CNF1_init	0b11000111  //tq=500ns   //20MHz
;     202 #define CNF2_init	0b11111110  //Ps1=7tq,Pr=2tq 
;     203 #define CNF3_init	0b00000011  //Ps2=6tq
;     204 #endif
;     205 
;     206 char can_st1,can_st_old1;

	.DSEG
_can_st1:
	.BYTE 0x1
_can_st_old1:
	.BYTE 0x1
;     207 char RXBUFF1[40],RXBUFF_1[40],TXBUFF1[40];
_RXBUFF1:
	.BYTE 0x28
_RXBUFF_1:
	.BYTE 0x28
_TXBUFF1:
	.BYTE 0x28
;     208 char bR1,bIN1,bOUT11;
_bR1:
	.BYTE 0x1
_bIN1:
	.BYTE 0x1
_bOUT11:
	.BYTE 0x1
;     209 char bR_cnt1,TX_len1;
_bR_cnt1:
	.BYTE 0x1
_TX_len1:
	.BYTE 0x1
;     210 char cnt_rcpt1,cnt_trsmt1;
_cnt_rcpt1:
	.BYTE 0x1
_cnt_trsmt1:
	.BYTE 0x1
;     211 char bOUT_free1;
_bOUT_free1:
	.BYTE 0x1
;     212 bit bOUT1; 
;     213 
;     214 
;     215 char can_out_buff[8,4];
_can_out_buff:
	.BYTE 0x20
;     216 char can_buff_wr_ptr;
_can_buff_wr_ptr:
	.BYTE 0x1
;     217 char can_buff_rd_ptr;
_can_buff_rd_ptr:
	.BYTE 0x1
;     218 
;     219 extern void granee(eeprom signed int *adr, signed int min, signed int max);
;     220 signed rotor_int=123;
_rotor_int:
	.BYTE 0x2
;     221 //-----------------------------------------------
;     222 void can_transmit1(char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
;     223 {

	.CSEG
_can_transmit1:
;     224 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
	LDS  R26,_can_buff_wr_ptr
	CPI  R26,0
	BRLO _0x10
	CALL SUBOPT_0x5
	BRSH _0xF
_0x10:
	LDI  R30,LOW(0)
	STS  _can_buff_wr_ptr,R30
;     225 
;     226 can_out_buff[0,can_buff_wr_ptr]=data0;
_0xF:
	LDS  R26,_can_buff_wr_ptr
	LDI  R27,0
	SUBI R26,LOW(-_can_out_buff)
	SBCI R27,HIGH(-_can_out_buff)
	LDD  R30,Y+7
	ST   X,R30
;     227 can_out_buff[1,can_buff_wr_ptr]=data1;
	__POINTW2MN _can_out_buff,4
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+6
	ST   X,R30
;     228 can_out_buff[2,can_buff_wr_ptr]=data2;
	__POINTW2MN _can_out_buff,8
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+5
	ST   X,R30
;     229 can_out_buff[3,can_buff_wr_ptr]=data3;
	__POINTW2MN _can_out_buff,12
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+4
	ST   X,R30
;     230 can_out_buff[4,can_buff_wr_ptr]=data4;
	__POINTW2MN _can_out_buff,16
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+3
	ST   X,R30
;     231 can_out_buff[5,can_buff_wr_ptr]=data5;
	__POINTW2MN _can_out_buff,20
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+2
	ST   X,R30
;     232 can_out_buff[6,can_buff_wr_ptr]=data6;
	__POINTW2MN _can_out_buff,24
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+1
	ST   X,R30
;     233 can_out_buff[7,can_buff_wr_ptr]=data7;
	__POINTW2MN _can_out_buff,28
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,Y
	ST   X,R30
;     234 
;     235 can_buff_wr_ptr++;
	LDS  R30,_can_buff_wr_ptr
	SUBI R30,-LOW(1)
	STS  _can_buff_wr_ptr,R30
;     236 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
	CALL SUBOPT_0x5
	BRSH _0x12
	LDI  R30,LOW(0)
	STS  _can_buff_wr_ptr,R30
;     237 } 
_0x12:
	ADIW R28,8
	RET
;     238 //-----------------------------------------------
;     239 void can_init1(void)
;     240 {
_can_init1:
;     241 char spi_temp;                 
;     242 
;     243 mcp_reset();
	ST   -Y,R16
;	spi_temp -> R16
	CALL _mcp_reset
;     244 spi_temp=spi_read(CANSTAT);
	LDI  R30,LOW(14)
	ST   -Y,R30
	CALL _spi_read
	MOV  R16,R30
;     245 if((spi_temp&0xe0)!=0x80)
	MOV  R30,R16
	ANDI R30,LOW(0xE0)
	CPI  R30,LOW(0x80)
	BREQ _0x13
;     246 	{
;     247 	spi_bit_modify(CANCTRL,0xe0,0x80);
	LDI  R30,LOW(15)
	CALL SUBOPT_0x6
	LDI  R30,LOW(128)
	ST   -Y,R30
	CALL _spi_bit_modify
;     248 	}
;     249 delay_us(10);		
_0x13:
	__DELAY_USB 27
;     250 spi_write(CNF1,CNF1_init);
	LDI  R30,LOW(42)
	ST   -Y,R30
	LDI  R30,LOW(195)
	ST   -Y,R30
	CALL _spi_write
;     251 spi_write(CNF2,CNF2_init);
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(254)
	ST   -Y,R30
	CALL _spi_write
;     252 spi_write(CNF3,CNF3_init);
	LDI  R30,LOW(40)
	CALL SUBOPT_0x7
	CALL _spi_write
;     253 
;     254 spi_write(RXB0CTRL,0b00100000);
	LDI  R30,LOW(96)
	CALL SUBOPT_0x8
;     255 spi_write(RXB1CTRL,0b00100000);
	LDI  R30,LOW(112)
	CALL SUBOPT_0x8
;     256 
;     257 delay_ms(10);
	CALL SUBOPT_0x9
;     258 
;     259 spi_write(RXM0SIDH, 0xFF); 
	LDI  R30,LOW(32)
	CALL SUBOPT_0xA
;     260 spi_write(RXM0SIDL, 0xFF); 
	LDI  R30,LOW(33)
	CALL SUBOPT_0xA
;     261 spi_write(RXF0SIDH, 0xFF); 
	LDI  R30,LOW(0)
	CALL SUBOPT_0xA
;     262 spi_write(RXF0SIDL, 0xFF); 
	LDI  R30,LOW(1)
	CALL SUBOPT_0xA
;     263 spi_write(RXF1SIDH, 0xFF);
	LDI  R30,LOW(4)
	CALL SUBOPT_0xA
;     264 spi_write(RXF1SIDL, 0xFF); 
	LDI  R30,LOW(5)
	CALL SUBOPT_0xA
;     265 
;     266 spi_write(RXM1SIDH, 0xff); 
	LDI  R30,LOW(36)
	CALL SUBOPT_0xA
;     267 spi_write(RXM1SIDL, 0xe0); 
	LDI  R30,LOW(37)
	CALL SUBOPT_0x6
	CALL _spi_write
;     268 
;     269 spi_write(RXF2SIDH, 0x13); 
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R30,LOW(19)
	ST   -Y,R30
	CALL _spi_write
;     270 spi_write(RXF2SIDL, 0xc0); 
	LDI  R30,LOW(9)
	CALL SUBOPT_0xB
;     271 
;     272 spi_write(RXF3SIDH, 0x00); 
	LDI  R30,LOW(16)
	CALL SUBOPT_0xC
;     273 spi_write(RXF3SIDL, 0x00); 
	LDI  R30,LOW(17)
	CALL SUBOPT_0xC
;     274 
;     275 spi_write(RXF4SIDH, 0x00); 
	LDI  R30,LOW(20)
	CALL SUBOPT_0xC
;     276 spi_write(RXF4SIDL, 0x00); 
	LDI  R30,LOW(21)
	CALL SUBOPT_0xC
;     277 
;     278 spi_write(RXF5SIDH, 0x00); 
	LDI  R30,LOW(24)
	CALL SUBOPT_0xC
;     279 spi_write(RXF5SIDL, 0x00); 
	LDI  R30,LOW(25)
	CALL SUBOPT_0xC
;     280 
;     281 spi_write(TXB2SIDH, 0x31); 
	LDI  R30,LOW(81)
	CALL SUBOPT_0xD
;     282 spi_write(TXB2SIDL, 0xc0); 
	LDI  R30,LOW(82)
	CALL SUBOPT_0xB
;     283 
;     284 spi_write(TXB1SIDH, 0x31); 
	LDI  R30,LOW(65)
	CALL SUBOPT_0xD
;     285 spi_write(TXB1SIDL, 0xc0); 
	LDI  R30,LOW(66)
	CALL SUBOPT_0xB
;     286 
;     287 spi_write(TXB0SIDH, 0x31); 
	LDI  R30,LOW(49)
	CALL SUBOPT_0xD
;     288 spi_write(TXB0SIDL, 0xc0); 
	LDI  R30,LOW(50)
	CALL SUBOPT_0xB
;     289 
;     290 
;     291 
;     292 spi_bit_modify(CANCTRL,0xe7,0b00000101);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(231)
	CALL SUBOPT_0xE
	CALL _spi_bit_modify
;     293 
;     294 spi_write(CANINTE,0b00000110);
	LDI  R30,LOW(43)
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL _spi_write
;     295 delay_ms(100);
	CALL SUBOPT_0xF
;     296 spi_write(BFPCTRL,0b00000000);  
	LDI  R30,LOW(12)
	CALL SUBOPT_0xC
;     297 
;     298 }
	LD   R16,Y+
	RET
;     299 
;     300 
;     301 
;     302 //-----------------------------------------------
;     303 void can_hndl1(void)
;     304 {
_can_hndl1:
;     305 unsigned char temp,j,temp_index,c_temp;
;     306 static char ch_cnt;

	.DSEG
_ch_cnt_SE:
	.BYTE 0x1

	.CSEG
;     307 #asm("cli")
	CALL __SAVELOCR4
;	temp -> R16
;	j -> R17
;	temp_index -> R18
;	c_temp -> R19
	cli
;     308 can_st1=spi_read_status();
	CALL _spi_read_status
	STS  _can_st1,R30
;     309 can_st_old1|=can_st1;
	LDS  R26,_can_st_old1
	OR   R30,R26
	STS  _can_st_old1,R30
;     310 
;     311 if(can_st1&0b00000010)
	LDS  R30,_can_st1
	ANDI R30,LOW(0x2)
	BREQ _0x14
;     312 	{
;     313 	
;     314 	for(j=0;j<8;j++)
	LDI  R17,LOW(0)
_0x16:
	CPI  R17,8
	BRSH _0x17
;     315 		{
;     316 		RXBUFF1[j]=spi_read(RXB1D0+j);
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_RXBUFF1)
	SBCI R31,HIGH(-_RXBUFF1)
	PUSH R31
	PUSH R30
	MOV  R30,R17
	SUBI R30,-LOW(118)
	ST   -Y,R30
	CALL _spi_read
	POP  R26
	POP  R27
	ST   X,R30
;     317 		}
	SUBI R17,-1
	RJMP _0x16
_0x17:
;     318 	
;     319 	spi_bit_modify(CANINTF,0b00000010,0x00);
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(2)
	CALL SUBOPT_0x10
;     320      bIN1=1;
	LDI  R30,LOW(1)
	STS  _bIN1,R30
;     321 	}
;     322            
;     323            
;     324 else if(/*(can_st1&0b10101000)&&*/(!(can_st1&0b01010100)))
	RJMP _0x18
_0x14:
	LDS  R30,_can_st1
	ANDI R30,LOW(0x54)
	BREQ PC+3
	JMP _0x19
;     325 	{
;     326 	char n;
;     327      spi_bit_modify(CANINTF,0b00011100,0x00);
	SBIW R28,1
;	n -> Y+0
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(28)
	CALL SUBOPT_0x10
;     328      
;     329      if(can_buff_rd_ptr!=can_buff_wr_ptr)
	LDS  R30,_can_buff_wr_ptr
	LDS  R26,_can_buff_rd_ptr
	CP   R30,R26
	BREQ _0x1A
;     330      	{
;     331          	for(n=0;n<8;n++)
	LDI  R30,LOW(0)
	ST   Y,R30
_0x1C:
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRSH _0x1D
;     332 			{ 
;     333 			spi_write(TXB0D0+n,can_out_buff[n,can_buff_rd_ptr]);
	LD   R30,Y
	SUBI R30,-LOW(54)
	ST   -Y,R30
	LDD  R30,Y+1
	LDI  R26,LOW(_can_out_buff)
	LDI  R27,HIGH(_can_out_buff)
	LDI  R31,0
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_can_buff_rd_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	CALL _spi_write
;     334 			} 
	CALL SUBOPT_0x11
	RJMP _0x1C
_0x1D:
;     335     		spi_write(TXB0DLC,8);
	LDI  R30,LOW(53)
	CALL SUBOPT_0x12
	CALL _spi_write
;     336     		spi_rts(0); 
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _spi_rts
;     337     		
;     338     		can_buff_rd_ptr++;
	LDS  R30,_can_buff_rd_ptr
	SUBI R30,-LOW(1)
	STS  _can_buff_rd_ptr,R30
;     339     		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
	LDS  R26,_can_buff_rd_ptr
	LDI  R30,LOW(3)
	CP   R30,R26
	BRSH _0x1E
	LDI  R30,LOW(0)
	STS  _can_buff_rd_ptr,R30
;     340     		} 
_0x1E:
;     341  	} 	
_0x1A:
	ADIW R28,1
;     342 		
;     343 #asm("sei") 
_0x19:
_0x18:
	sei
;     344 }
	CALL __LOADLOCR4
	ADIW R28,4
	RET
;     345 
;     346 
;     347 
;     348 
;     349 //-----------------------------------------------
;     350 void can_in_an1(void)
;     351 {
_can_in_an1:
;     352 char temp,i;
;     353 signed temp_S;
;     354 int tempI;
;     355 
;     356 
;     357 
;     358 if((RXBUFF1[0]==1)&&(RXBUFF1[1]==2)&&(RXBUFF1[2]==3)&&(RXBUFF1[3]==4)&&(RXBUFF1[4]==5)&&(RXBUFF1[5]==6)&&(RXBUFF1[6]==7)&&(RXBUFF1[7]==8))can_transmit1(1,2,3,4,5,6,7,8);
	CALL __SAVELOCR6
;	temp -> R16
;	i -> R17
;	temp_S -> R18,R19
;	tempI -> R20,R21
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0x1)
	BRNE _0x20
	__GETB1MN _RXBUFF1,1
	CPI  R30,LOW(0x2)
	BRNE _0x20
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0x3)
	BRNE _0x20
	__GETB1MN _RXBUFF1,3
	CPI  R30,LOW(0x4)
	BRNE _0x20
	__GETB1MN _RXBUFF1,4
	CPI  R30,LOW(0x5)
	BRNE _0x20
	__GETB1MN _RXBUFF1,5
	CPI  R30,LOW(0x6)
	BRNE _0x20
	__GETB1MN _RXBUFF1,6
	CPI  R30,LOW(0x7)
	BRNE _0x20
	__GETB1MN _RXBUFF1,7
	CPI  R30,LOW(0x8)
	BREQ _0x21
_0x20:
	RJMP _0x1F
_0x21:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(2)
	CALL SUBOPT_0x7
	LDI  R30,LOW(4)
	CALL SUBOPT_0xE
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(7)
	CALL SUBOPT_0x12
	CALL _can_transmit1
;     359 
;     360 
;     361 if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==GETTM))	
_0x1F:
	LDI  R26,LOW(_RXBUFF1)
	LDI  R27,HIGH(_RXBUFF1)
	LD   R30,X
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x23
	__GETB1MN _RXBUFF1,1
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x23
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0xED)
	BREQ _0x24
_0x23:
	RJMP _0x22
_0x24:
;     362 	{ 
;     363 	
;     364 	can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
;     365 	
;     366 	
;     367  	flags_tu=RXBUFF1[3];
	__GETB1MN _RXBUFF1,3
	STS  _flags_tu,R30
;     368  	if(flags_tu&0b00000001)
	ANDI R30,LOW(0x1)
	BREQ _0x25
;     369  		{
;     370  		if(flags_tu_cnt_off<4)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRSH _0x26
;     371  			{
;     372  			flags_tu_cnt_off++;
	LDS  R30,_flags_tu_cnt_off
	SUBI R30,-LOW(1)
	STS  _flags_tu_cnt_off,R30
;     373  			if(flags_tu_cnt_off>=4)flags|=0b00100000;
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRLO _0x27
	LDS  R30,_flags
	ORI  R30,0x20
	STS  _flags,R30
;     374  			}
_0x27:
;     375  		else flags_tu_cnt_off=4;
	RJMP _0x28
_0x26:
	LDI  R30,LOW(4)
	STS  _flags_tu_cnt_off,R30
_0x28:
;     376  		}
;     377  	else  		
	RJMP _0x29
_0x25:
;     378  		{
;     379  		if(flags_tu_cnt_off)
	LDS  R30,_flags_tu_cnt_off
	CPI  R30,0
	BREQ _0x2A
;     380  			{
;     381  			flags_tu_cnt_off--;
	SUBI R30,LOW(1)
	STS  _flags_tu_cnt_off,R30
;     382  			if(flags_tu_cnt_off<=0)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,0
	BRNE _0x2B
;     383  				{
;     384  				flags&=0b11011111; 
	LDS  R30,_flags
	ANDI R30,0xDF
	STS  _flags,R30
;     385  				off_bp_cnt=5*TZAS;
	CALL SUBOPT_0x13
	STS  _off_bp_cnt,R30
;     386  				}
;     387  			}
_0x2B:
;     388  		else flags_tu_cnt_off=0;
	RJMP _0x2C
_0x2A:
	LDI  R30,LOW(0)
	STS  _flags_tu_cnt_off,R30
_0x2C:
;     389  		}
_0x29:
;     390  		 
;     391  	if(flags_tu&0b00000010) flags|=0b01000000;
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x2)
	BREQ _0x2D
	LDS  R30,_flags
	ORI  R30,0x40
	RJMP _0x199
;     392  	else flags&=0b10111111; 
_0x2D:
	LDS  R30,_flags
	ANDI R30,0xBF
_0x199:
	STS  _flags,R30
;     393  		
;     394  	vol_u_temp=RXBUFF1[4]+RXBUFF1[5]*256;
	__GETB1MN _RXBUFF1,4
	PUSH R30
	__GETB1MN _RXBUFF1,5
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _vol_u_temp,R30
	STS  _vol_u_temp+1,R31
;     395  	vol_i_temp=RXBUFF1[6]+RXBUFF1[7]*256;  
	__GETB1MN _RXBUFF1,6
	PUSH R30
	__GETB1MN _RXBUFF1,7
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _vol_i_temp,R30
	STS  _vol_i_temp+1,R31
;     396  	
;     397  	//I=1234;
;     398     //	Un=6543;
;     399  	//Ui=6789;
;     400  	//T=246;
;     401  	//flags=0x55;
;     402  	//_x_=33;
;     403  	//rotor_int=1000;
;     404  	rotor_int=flags_tu+(((int)flags)<<8);
	LDS  R31,_flags
	LDI  R30,LOW(0)
	LDS  R26,_flags_tu
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _rotor_int,R30
	STS  _rotor_int+1,R31
;     405 	can_transmit1(adr,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),*(((char*)&/*plazma_int[1]*/Ui)+1));
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	ST   -Y,R30
	LDI  R30,LOW(218)
	ST   -Y,R30
	LDS  R30,_I
	ST   -Y,R30
	__GETB1MN _I,1
	ST   -Y,R30
	LDS  R30,_Un
	ST   -Y,R30
	__GETB1MN _Un,1
	ST   -Y,R30
	LDS  R30,_Ui
	ST   -Y,R30
	__GETB1MN _Ui,1
	ST   -Y,R30
	CALL _can_transmit1
;     406 	can_transmit1(adr,PUTTM2,T,0,flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+1));
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	ST   -Y,R30
	LDI  R30,LOW(219)
	ST   -Y,R30
	LDS  R30,_T
	LDS  R31,_T+1
	CALL SUBOPT_0x15
	LDS  R30,_flags
	ST   -Y,R30
	LDS  R30,__x_
	LDS  R31,__x_+1
	ST   -Y,R30
	__GETB1MN _plazma_int,4
	ST   -Y,R30
	__GETB1MN _plazma_int,5
	ST   -Y,R30
	CALL _can_transmit1
;     407      link_cnt=0;
	CALL SUBOPT_0x16
;     408      link=ON;
;     409      
;     410      if(flags_tu&0b10000000)
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BREQ _0x2F
;     411      	{
;     412      	if(!res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x30
;     413      		{             
;     414      		res_fl=1;
	LDI  R30,LOW(1)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMWRB
;     415      		bRES=1;
	STS  _bRES,R30
;     416      		res_fl_cnt=0;
	LDI  R30,LOW(0)
	STS  _res_fl_cnt,R30
;     417      		}
;     418      	}
_0x30:
;     419      else 
	RJMP _0x31
_0x2F:
;     420      	{
;     421      	if(main_cnt>20)
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x32
;     422      		{
;     423     			if(res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ _0x33
;     424      			{
;     425      			res_fl=0;
	LDI  R30,LOW(0)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMWRB
;     426      			}
;     427      		}
_0x33:
;     428      	}	
_0x32:
_0x31:
;     429      	
;     430       if(res_fl_)
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ _0x34
;     431       	{
;     432       	res_fl_=0;
	LDI  R30,LOW(0)
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMWRB
;     433       	}     	
;     434 	}
_0x34:
;     435 else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==KLBR)&&(RXBUFF1[3]==RXBUFF1[4]))
	RJMP _0x35
_0x22:
	LDI  R26,LOW(_RXBUFF1)
	LDI  R27,HIGH(_RXBUFF1)
	LD   R30,X
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x37
	__GETB1MN _RXBUFF1,1
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x37
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0xEE)
	BRNE _0x37
	__GETB1MN _RXBUFF1,3
	PUSH R30
	__GETB1MN _RXBUFF1,4
	POP  R26
	CP   R30,R26
	BREQ _0x38
_0x37:
	RJMP _0x36
_0x38:
;     436 	{
;     437 	rotor_int++;
	CALL SUBOPT_0x17
;     438 	if((RXBUFF1[3]&0xf0)==0x20)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x20)
	BREQ PC+3
	JMP _0x39
;     439 		{
;     440 		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x3A
;     441 			{
;     442 			K[0,0]=adc_buff_[0];
	LDS  R30,_adc_buff_
	LDS  R31,_adc_buff_+1
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMWRW
;     443 			}
;     444 		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x3B
_0x3A:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	BRNE _0x3C
;     445 			{
;     446 			K[0,1]++;
	__POINTW2MN _K,2
	CALL SUBOPT_0x18
;     447 			} 
;     448 		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x3D
_0x3C:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	BRNE _0x3E
;     449 			{
;     450 			K[0,1]+=10;
	__POINTW2MN _K,2
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	ADIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     451 			}	 
;     452 		else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x3F
_0x3E:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	BRNE _0x40
;     453 			{
;     454 			K[0,1]--;
	__POINTW2MN _K,2
	CALL SUBOPT_0x19
;     455 			} 
;     456 		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x41
_0x40:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BRNE _0x42
;     457 			{
;     458 			K[0,1]-=10;
	__POINTW2MN _K,2
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	SBIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     459 			}
;     460 		granee(&K[0,1],420,1100);									
_0x42:
_0x41:
_0x3F:
_0x3D:
_0x3B:
	__POINTW1MN _K,2
	CALL SUBOPT_0x1A
;     461 		}
;     462 	else if((RXBUFF1[3]&0xf0)==0x10)
	RJMP _0x43
_0x39:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x10)
	BREQ PC+3
	JMP _0x44
;     463 		{
;     464 		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x45
;     465 			{
;     466 			K[1,0]=adc_buff_[1];
	__POINTW1MN _K,4
	PUSH R31
	PUSH R30
	__GETW1MN _adc_buff_,2
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     467 			}
;     468 		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x46
_0x45:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	BRNE _0x47
;     469 			{
;     470 			K[1,1]++;
	__POINTW2MN _K,6
	CALL SUBOPT_0x18
;     471 			} 
;     472 		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x48
_0x47:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	BRNE _0x49
;     473 			{
;     474 			K[1,1]+=10;
	__POINTW2MN _K,6
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	ADIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     475 			}	 
;     476 		else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x4A
_0x49:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	BRNE _0x4B
;     477 			{
;     478 			K[1,1]--;
	__POINTW2MN _K,6
	CALL SUBOPT_0x19
;     479 			} 
;     480 		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x4C
_0x4B:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BRNE _0x4D
;     481 			{
;     482 			K[1,1]-=10;
	__POINTW2MN _K,6
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	SBIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     483 			}
;     484 		#ifdef _220_
;     485 		granee(&K[1,1],4500,5500);
;     486 		#else
;     487 		granee(&K[1,1],1360,1700);
_0x4D:
_0x4C:
_0x4A:
_0x48:
_0x46:
	__POINTW1MN _K,6
	CALL SUBOPT_0x1B
;     488 		#endif									
;     489 		}		
;     490 		 
;     491 	else if((RXBUFF1[3]&0xf0)==0x00)
	RJMP _0x4E
_0x44:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	BREQ PC+3
	JMP _0x4F
;     492 		{
;     493 		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x50
;     494 			{
;     495 			K[2,0]=adc_buff_[2];
	__POINTW1MN _K,8
	PUSH R31
	PUSH R30
	__GETW1MN _adc_buff_,4
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     496 			}
;     497 		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x51
_0x50:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	BRNE _0x52
;     498 			{
;     499 			K[2,1]++;
	__POINTW2MN _K,10
	CALL SUBOPT_0x18
;     500 			} 
;     501 		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x53
_0x52:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	BRNE _0x54
;     502 			{
;     503 			K[2,1]+=10;
	__POINTW2MN _K,10
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	ADIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     504 			}	 
;     505 		else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x55
_0x54:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	BRNE _0x56
;     506 			{
;     507 			K[2,1]--;
	__POINTW2MN _K,10
	CALL SUBOPT_0x19
;     508 			} 
;     509 		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x57
_0x56:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BRNE _0x58
;     510 			{
;     511 			K[2,1]-=10;
	__POINTW2MN _K,10
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	SBIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     512 			}
;     513 		#ifdef _220_
;     514 		granee(&K[2,1],4500,5500);
;     515 		#else
;     516 		granee(&K[2,1],1360,1700);
_0x58:
_0x57:
_0x55:
_0x53:
_0x51:
	__POINTW1MN _K,10
	CALL SUBOPT_0x1B
;     517 		#endif									
;     518 		}		 
;     519 		
;     520 	else if((RXBUFF1[3]&0xf0)==0x30)
	RJMP _0x59
_0x4F:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x30)
	BREQ PC+3
	JMP _0x5A
;     521 		{
;     522 		if((RXBUFF1[3]&0x0f)==0x02)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	BRNE _0x5B
;     523 			{
;     524 			K[3,1]++;
	__POINTW2MN _K,14
	CALL SUBOPT_0x18
;     525 			} 
;     526 		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x5C
_0x5B:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	BRNE _0x5D
;     527 			{
;     528 			K[3,1]+=10;
	__POINTW2MN _K,14
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	ADIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     529 			}	 
;     530 		else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x5E
_0x5D:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	BRNE _0x5F
;     531 			{
;     532 			K[3,1]--;
	__POINTW2MN _K,14
	CALL SUBOPT_0x19
;     533 			} 
;     534 		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x60
_0x5F:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BRNE _0x61
;     535 			{
;     536 			K[3,1]-=10;
	__POINTW2MN _K,14
	PUSH R27
	PUSH R26
	CALL __EEPROMRDW
	SBIW R30,10
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;     537 			}
;     538 		granee(&K[3,1],480,497);									
_0x61:
_0x60:
_0x5E:
_0x5C:
	__POINTW1MN _K,14
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(480)
	LDI  R31,HIGH(480)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(497)
	LDI  R31,HIGH(497)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _granee
;     539 		}     
;     540 		
;     541 /*	else if((RXBUFF1[3]&0xf0)==0xA0)    //изменение адреса(инкремент и декремент)
;     542 		{
;     543 		//rotor++;
;     544 		if((RXBUFF1[3]&0x0f)==0x02)
;     545 			{
;     546 			adr_ee++;
;     547 			} 
;     548 		else if((RXBUFF1[3]&0x0f)==0x03)
;     549 			{
;     550 			adr_ee+=10;
;     551 			}	 
;     552 		else if((RXBUFF1[3]&0x0f)==0x04)
;     553 			{
;     554 			adr_ee--;
;     555 			} 
;     556 		else if((RXBUFF1[3]&0x0f)==0x05)
;     557 			{
;     558 			adr_ee-=10;
;     559 			}
;     560 		} */		
;     561 /*	else if((RXBUFF1[3]&0xf0)==0xB0)   //установка адреса(для ворот)
;     562 		{      
;     563 		//rotor--;
;     564 		adr_ee=(RXBUFF1[3]&0x0f);
;     565 		}  */				
;     566 	link_cnt=0;
_0x5A:
_0x59:
_0x4E:
_0x43:
	CALL SUBOPT_0x16
;     567      link=ON;
;     568      if(res_fl_)
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ _0x62
;     569       	{
;     570       	res_fl_=0;
	LDI  R30,LOW(0)
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMWRB
;     571       	}       	
;     572 	
;     573 	
;     574 	} 
_0x62:
;     575 
;     576 else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF))
	RJMP _0x63
_0x36:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0x65
	__GETB1MN _RXBUFF1,1
	CPI  R30,LOW(0xFF)
	BRNE _0x65
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0x62)
	BREQ _0x66
_0x65:
	RJMP _0x64
_0x66:
;     577 	{
;     578 	//rotor_int++;	
;     579 	if(Umax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) Umax=(RXBUFF1[3]+(RXBUFF1[4]*256)); 
	LDI  R26,LOW(_Umax)
	LDI  R27,HIGH(_Umax)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	__GETB1MN _RXBUFF1,3
	PUSH R30
	__GETB1MN _RXBUFF1,4
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x67
	__GETB1MN _RXBUFF1,3
	PUSH R30
	__GETB1MN _RXBUFF1,4
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	LDI  R26,LOW(_Umax)
	LDI  R27,HIGH(_Umax)
	CALL __EEPROMWRW
;     580 	if(dU!=(RXBUFF1[5]+(RXBUFF1[6]*256))) dU=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0x67:
	LDI  R26,LOW(_dU)
	LDI  R27,HIGH(_dU)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	__GETB1MN _RXBUFF1,5
	PUSH R30
	__GETB1MN _RXBUFF1,6
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x68
	__GETB1MN _RXBUFF1,5
	PUSH R30
	__GETB1MN _RXBUFF1,6
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	LDI  R26,LOW(_dU)
	LDI  R27,HIGH(_dU)
	CALL __EEPROMWRW
;     581 	
;     582 	}
_0x68:
;     583 
;     584 else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF1))
	RJMP _0x69
_0x64:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0x6B
	__GETB1MN _RXBUFF1,1
	CPI  R30,LOW(0xFF)
	BRNE _0x6B
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0x26)
	BREQ _0x6C
_0x6B:
	RJMP _0x6A
_0x6C:
;     585 	{
;     586 	if(tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	__GETB1MN _RXBUFF1,3
	PUSH R30
	__GETB1MN _RXBUFF1,4
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x6D
	__GETB1MN _RXBUFF1,3
	PUSH R30
	__GETB1MN _RXBUFF1,4
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMWRW
;     587 	if(tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0x6D:
	LDI  R26,LOW(_tsign)
	LDI  R27,HIGH(_tsign)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	__GETB1MN _RXBUFF1,5
	PUSH R30
	__GETB1MN _RXBUFF1,5
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x6E
	__GETB1MN _RXBUFF1,5
	PUSH R30
	__GETB1MN _RXBUFF1,6
	CALL SUBOPT_0x14
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	LDI  R26,LOW(_tsign)
	LDI  R27,HIGH(_tsign)
	CALL __EEPROMWRW
;     588 	if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7]; 
_0x6E:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	PUSH R30
	__GETB1MN _RXBUFF1,7
	POP  R26
	CP   R30,R26
	BREQ _0x6F
	__GETB1MN _RXBUFF1,7
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMWRB
;     589 	
;     590 	}
_0x6F:
;     591 
;     592 else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	RJMP _0x70
_0x6A:
	LDI  R26,LOW(_RXBUFF1)
	LDI  R27,HIGH(_RXBUFF1)
	LD   R30,X
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x72
	__GETB1MN _RXBUFF1,1
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x72
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0x16)
	BRNE _0x72
	__GETB1MN _RXBUFF1,3
	CPI  R30,LOW(0x63)
	BREQ _0x73
_0x72:
	RJMP _0x71
_0x73:
;     593 	{
;     594 	flags&=0b11100001;
	CALL SUBOPT_0x1C
;     595 	tsign_cnt=0;
;     596 	tmax_cnt=0;
;     597 	umax_cnt=0;
;     598 	umin_cnt=0;
;     599 	led_drv_cnt=30;
	LDI  R30,LOW(30)
	STS  _led_drv_cnt,R30
;     600 	}		
;     601 else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	RJMP _0x74
_0x71:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0x76
	__GETB1MN _RXBUFF1,1
	CPI  R30,LOW(0xFF)
	BRNE _0x76
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0x16)
	BRNE _0x76
	__GETB1MN _RXBUFF1,3
	CPI  R30,LOW(0x16)
	BREQ _0x77
_0x76:
	RJMP _0x75
_0x77:
;     602 	{
;     603 	if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	__GETB1MN _RXBUFF1,4
	CPI  R30,LOW(0x55)
	BRNE _0x79
	__GETB1MN _RXBUFF1,5
	CPI  R30,LOW(0x55)
	BREQ _0x7A
_0x79:
	RJMP _0x78
_0x7A:
	LDS  R30,__x_
	LDS  R31,__x_+1
	ADIW R30,1
	STS  __x_,R30
	STS  __x_+1,R31
;     604 	else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--; 
	RJMP _0x7B
_0x78:
	__GETB1MN _RXBUFF1,4
	CPI  R30,LOW(0x66)
	BRNE _0x7D
	__GETB1MN _RXBUFF1,5
	CPI  R30,LOW(0x66)
	BREQ _0x7E
_0x7D:
	RJMP _0x7C
_0x7E:
	LDS  R30,__x_
	LDS  R31,__x_+1
	SBIW R30,1
	STS  __x_,R30
	STS  __x_+1,R31
;     605 	else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
	RJMP _0x7F
_0x7C:
	__GETB1MN _RXBUFF1,4
	CPI  R30,LOW(0x77)
	BRNE _0x81
	__GETB1MN _RXBUFF1,5
	CPI  R30,LOW(0x77)
	BREQ _0x82
_0x81:
	RJMP _0x80
_0x82:
	LDI  R30,0
	STS  __x_,R30
	STS  __x_+1,R30
;     606      gran(&_x_,-XMAX,XMAX);
_0x80:
_0x7F:
_0x7B:
	LDI  R30,LOW(__x_)
	LDI  R31,HIGH(__x_)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(65511)
	LDI  R31,HIGH(65511)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(25)
	LDI  R31,HIGH(25)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _gran
;     607 	}
;     608 else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==RXBUFF1[4])&&(RXBUFF1[3]==0xee))
	RJMP _0x83
_0x75:
	LDI  R26,LOW(_RXBUFF1)
	LDI  R27,HIGH(_RXBUFF1)
	LD   R30,X
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x85
	__GETB1MN _RXBUFF1,1
	PUSH R30
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	POP  R26
	CP   R30,R26
	BRNE _0x85
	__GETB1MN _RXBUFF1,2
	CPI  R30,LOW(0x16)
	BRNE _0x85
	__GETB1MN _RXBUFF1,3
	PUSH R30
	__GETB1MN _RXBUFF1,4
	POP  R26
	CP   R30,R26
	BRNE _0x85
	__GETB1MN _RXBUFF1,3
	CPI  R30,LOW(0xEE)
	BREQ _0x86
_0x85:
	RJMP _0x84
_0x86:
;     609 	{
;     610 	rotor_int++;
	CALL SUBOPT_0x17
;     611      tempI=pwm_u;
	__GETWRMN _pwm_u,0,20,21
;     612 	U_AVT=tempI;
	__GETW1R 20,21
	LDI  R26,LOW(_U_AVT)
	LDI  R27,HIGH(_U_AVT)
	CALL __EEPROMWRW
;     613 	delay_ms(100);
	CALL SUBOPT_0xF
;     614 	if(U_AVT==tempI)can_transmit1(adr,PUTID,0xdd,0xdd,0,0,0,0);
	LDI  R26,LOW(_U_AVT)
	LDI  R27,HIGH(_U_AVT)
	CALL __EEPROMRDW
	CP   R20,R30
	CPC  R21,R31
	BRNE _0x87
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	ST   -Y,R30
	LDI  R30,LOW(145)
	ST   -Y,R30
	LDI  R30,LOW(221)
	ST   -Y,R30
	CALL SUBOPT_0x15
	LDI  R30,LOW(0)
	CALL SUBOPT_0x15
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _can_transmit1
;     615       
;     616 	}	
_0x87:
;     617 
;     618 
;     619 
;     620 
;     621 
;     622 can_in_an1_end:
_0x84:
_0x83:
_0x74:
_0x70:
_0x69:
_0x63:
_0x35:
;     623 bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
;     624 }   
	CALL __LOADLOCR6
	RJMP _0x197
;     625 
;     626 
;     627 
;     628 
;     629 
;     630 
;     631 
;     632 
;     633  
;     634 
;     635 
;     636 
;     637 
;     638 
;     639 
;     640 //-----------------------------------------------
;     641 void t0_init(void)
;     642 {
_t0_init:
;     643 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
;     644 TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
;     645 TCNT0=-8;
	LDI  R30,LOW(248)
	OUT  0x26,R30
;     646 TIMSK0=0x02;
	LDI  R30,LOW(2)
	STS  0x6E,R30
;     647 }
	RET
;     648 
;     649 //-----------------------------------------------
;     650 char adr_gran(signed short in)
;     651 {
_adr_gran:
;     652 if(in>800)return 1;
	LD   R26,Y
	LDD  R27,Y+1
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x89
	LDI  R30,LOW(1)
	RJMP _0x198
;     653 else if((in>80)&&(in<120))return 0;
_0x89:
	LD   R26,Y
	LDD  R27,Y+1
	LDI  R30,LOW(80)
	LDI  R31,HIGH(80)
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x8C
	CPI  R26,LOW(0x78)
	LDI  R30,HIGH(0x78)
	CPC  R27,R30
	BRLT _0x8D
_0x8C:
	RJMP _0x8B
_0x8D:
	LDI  R30,LOW(0)
	RJMP _0x198
;     654 else return 100;
_0x8B:
	LDI  R30,LOW(100)
;     655 } 
_0x198:
	ADIW R28,2
	RET
;     656 
;     657 
;     658 //-----------------------------------------------
;     659 void gran(signed int *adr, signed int min, signed int max)
;     660 {
_gran:
;     661 if (*adr<min) *adr=min;
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	CALL SUBOPT_0x1D
	BRGE _0x8F
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
;     662 if (*adr>max) *adr=max; 
_0x8F:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	CALL SUBOPT_0x1E
	BRGE _0x90
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
;     663 } 
_0x90:
	RJMP _0x197
;     664 
;     665 
;     666 //-----------------------------------------------
;     667 void granee(eeprom signed int *adr, signed int min, signed int max)
;     668 {
_granee:
;     669 if (*adr<min) *adr=min;
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	CALL SUBOPT_0x1D
	BRGE _0x91
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
;     670 if (*adr>max) *adr=max; 
_0x91:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	CALL SUBOPT_0x1E
	BRGE _0x92
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
;     671 }
_0x92:
_0x197:
	ADIW R28,6
	RET
;     672 
;     673 //-----------------------------------------------
;     674 void x_drv(void)
;     675 {
_x_drv:
;     676 if(_x__==_x_)
	LDS  R30,__x_
	LDS  R31,__x_+1
	LDS  R26,__x__
	LDS  R27,__x__+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x93
;     677 	{
;     678 	if(_x_cnt<60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	CPI  R26,LOW(0x3C)
	LDI  R30,HIGH(0x3C)
	CPC  R27,R30
	BRGE _0x94
;     679 		{
;     680 		_x_cnt++;
	LDS  R30,__x_cnt
	LDS  R31,__x_cnt+1
	ADIW R30,1
	STS  __x_cnt,R30
	STS  __x_cnt+1,R31
;     681 		if(_x_cnt>=60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	CPI  R26,LOW(0x3C)
	LDI  R30,HIGH(0x3C)
	CPC  R27,R30
	BRLT _0x95
;     682 			{
;     683 			if(_x_ee_!=_x_)_x_ee_=_x_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	LDS  R26,__x_
	LDS  R27,__x_+1
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x96
	LDS  R30,__x_
	LDS  R31,__x_+1
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMWRW
;     684 			}
_0x96:
;     685 		}
_0x95:
;     686 		
;     687 	}
_0x94:
;     688 else _x_cnt=0;
	RJMP _0x97
_0x93:
	LDI  R30,0
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
_0x97:
;     689 
;     690 if(_x_cnt>60) _x_cnt=0;	
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x98
	LDI  R30,0
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
;     691 
;     692 _x__=_x_;
_0x98:
	LDS  R30,__x_
	LDS  R31,__x_+1
	STS  __x__,R30
	STS  __x__+1,R31
;     693 }
	RET
;     694 
;     695 //-----------------------------------------------
;     696 void apv_start(void)
;     697 {
_apv_start:
;     698 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
	LDS  R26,_apv_cnt
	CPI  R26,LOW(0x0)
	BRNE _0x9A
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0x9A
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0x9A
	LDS  R30,_bAPV
	CPI  R30,0
	BREQ _0x9B
_0x9A:
	RJMP _0x99
_0x9B:
;     699 	{
;     700 	apv_cnt[0]=60;
	LDI  R30,LOW(60)
	STS  _apv_cnt,R30
;     701 	apv_cnt[1]=60;
	__PUTB1MN _apv_cnt,1
;     702 	apv_cnt[2]=60;
	__PUTB1MN _apv_cnt,2
;     703 	apv_cnt_=3600;
	LDI  R30,LOW(3600)
	LDI  R31,HIGH(3600)
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R31
;     704 	bAPV=1;	
	LDI  R30,LOW(1)
	STS  _bAPV,R30
;     705 	}
;     706 }
_0x99:
	RET
;     707 
;     708 //-----------------------------------------------
;     709 void apv_stop(void)
;     710 {
_apv_stop:
;     711 apv_cnt[0]=0;
	LDI  R30,LOW(0)
	STS  _apv_cnt,R30
;     712 apv_cnt[1]=0;
	__PUTB1MN _apv_cnt,1
;     713 apv_cnt[2]=0;
	__PUTB1MN _apv_cnt,2
;     714 apv_cnt_=0;	
	LDI  R30,0
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R30
;     715 bAPV=0;
	LDI  R30,LOW(0)
	STS  _bAPV,R30
;     716 }
	RET
;     717 
;     718 
;     719 //-----------------------------------------------
;     720 void av_wrk_drv(void)
;     721 {                         
;     722 adc_ch_2_delta=(char)(adc_ch_2_max-adc_ch_2_min);
;     723 adc_ch_2_max=adc_buff_[2];
;     724 adc_ch_2_min=adc_buff_[2]; 
;     725 if(PORTD.7==0)
;     726 	{
;     727 	if(adc_ch_2_delta>=5)
;     728 		{
;     729 		cnt_adc_ch_2_delta++;
;     730 		if(cnt_adc_ch_2_delta>=10)
;     731 			{
;     732 			flags|=0x10;
;     733 			apv_start();
;     734 			}
;     735 		}    
;     736 	else 
;     737 		{
;     738 		cnt_adc_ch_2_delta=0;
;     739 		}
;     740 	}
;     741 else cnt_adc_ch_2_delta=0;			
;     742 }
;     743 
;     744 //-----------------------------------------------
;     745 void led_drv(void)
;     746 {
_led_drv:
;     747 
;     748 static long led_red_buff,led_green_buff;

	.DSEG
_led_red_buff_S18:
	.BYTE 0x4
_led_green_buff_S18:
	.BYTE 0x4

	.CSEG
;     749 
;     750 DDRB.0=1;
	SBI  0x4,0
;     751 if(led_green_buff&0b1L) PORTB.0=1;
	LDS  R30,_led_green_buff_S18
	ANDI R30,LOW(0x1)
	BREQ _0xA1
	SBI  0x5,0
;     752 else PORTB.0=0; 
	RJMP _0xA2
_0xA1:
	CBI  0x5,0
_0xA2:
;     753 DDRD.7=1;
	SBI  0xA,7
;     754 if(led_red_buff&0b1L) PORTD.7=1;
	LDS  R30,_led_red_buff_S18
	ANDI R30,LOW(0x1)
	BREQ _0xA3
	SBI  0xB,7
;     755 else PORTD.7=0; 
	RJMP _0xA4
_0xA3:
	CBI  0xB,7
_0xA4:
;     756 
;     757 
;     758 led_red_buff>>=1;
	LDS  R30,_led_red_buff_S18
	LDS  R31,_led_red_buff_S18+1
	LDS  R22,_led_red_buff_S18+2
	LDS  R23,_led_red_buff_S18+3
	CALL __ASRD1
	STS  _led_red_buff_S18,R30
	STS  _led_red_buff_S18+1,R31
	STS  _led_red_buff_S18+2,R22
	STS  _led_red_buff_S18+3,R23
;     759 led_green_buff>>=1;
	LDS  R30,_led_green_buff_S18
	LDS  R31,_led_green_buff_S18+1
	LDS  R22,_led_green_buff_S18+2
	LDS  R23,_led_green_buff_S18+3
	CALL __ASRD1
	STS  _led_green_buff_S18,R30
	STS  _led_green_buff_S18+1,R31
	STS  _led_green_buff_S18+2,R22
	STS  _led_green_buff_S18+3,R23
;     760 if(++led_drv_cnt>32)
	LDS  R26,_led_drv_cnt
	SUBI R26,-LOW(1)
	STS  _led_drv_cnt,R26
	LDI  R30,LOW(32)
	CP   R30,R26
	BRSH _0xA5
;     761 	{
;     762 	led_drv_cnt=0;
	LDI  R30,LOW(0)
	STS  _led_drv_cnt,R30
;     763 	led_red_buff=led_red;
	LDS  R30,_led_red
	LDS  R31,_led_red+1
	LDS  R22,_led_red+2
	LDS  R23,_led_red+3
	STS  _led_red_buff_S18,R30
	STS  _led_red_buff_S18+1,R31
	STS  _led_red_buff_S18+2,R22
	STS  _led_red_buff_S18+3,R23
;     764 	led_green_buff=led_green;
	LDS  R30,_led_green
	LDS  R31,_led_green+1
	LDS  R22,_led_green+2
	LDS  R23,_led_green+3
	STS  _led_green_buff_S18,R30
	STS  _led_green_buff_S18+1,R31
	STS  _led_green_buff_S18+2,R22
	STS  _led_green_buff_S18+3,R23
;     765 	}
;     766 
;     767 } 
_0xA5:
	RET
;     768 
;     769 //-----------------------------------------------
;     770 void flags_drv(void)
;     771 {
_flags_drv:
;     772 static char flags_old;

	.DSEG
_flags_old_S19:
	.BYTE 0x1

	.CSEG
;     773 if(jp_mode!=jp3) 
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0xA6
;     774 	{
;     775 	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000)))) 
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0xA8
	LDS  R30,_flags_old_S19
	ANDI R30,LOW(0x8)
	BREQ _0xAA
_0xA8:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0xAB
	LDS  R30,_flags_old_S19
	ANDI R30,LOW(0x10)
	BREQ _0xAA
_0xAB:
	RJMP _0xA7
_0xAA:
;     776     		{	
;     777     		if(link==OFF)apv_start();
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0xAE
	CALL _apv_start
;     778     		}
_0xAE:
;     779      }
_0xA7:
;     780 else if(jp_mode==jp3) 
	RJMP _0xAF
_0xA6:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0xB0
;     781 	{
;     782 	if((flags&0b00001000)&&(!(flags_old&0b00001000))) 
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0xB2
	LDS  R30,_flags_old_S19
	ANDI R30,LOW(0x8)
	BREQ _0xB3
_0xB2:
	RJMP _0xB1
_0xB3:
;     783     		{	
;     784     		apv_start();
	CALL _apv_start
;     785     		}
;     786      }
_0xB1:
;     787 flags_old=flags;
_0xB0:
_0xAF:
	LDS  R30,_flags
	STS  _flags_old_S19,R30
;     788 
;     789 } 
	RET
;     790 
;     791 //-----------------------------------------------
;     792 void adr_hndl(void)
;     793 {
_adr_hndl:
;     794 signed tempSI; 
;     795 char aaa[3];
;     796 char aaaa[3];
;     797 DDRC=0b00011110; 
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
;	tempSI -> R16,R17
;	aaa -> Y+5
;	aaaa -> Y+2
	LDI  R30,LOW(30)
	OUT  0x7,R30
;     798 PORTC=0b00011110;
	OUT  0x8,R30
;     799 /*char i; 
;     800 DDRD&=0b11100011;
;     801 PORTD|=0b00011100;
;     802 
;     803 //adr_new=((char)(!PIND.2))+(((char)(!PIND.3))*2)+((char)(!PIND.4)*4);
;     804 
;     805 
;     806 adr_new=(PIND&0b00011100)>>2;
;     807 
;     808 if(adr_new==adr_old) 
;     809  	{
;     810  	if(adr_cnt<100)
;     811  		{
;     812  		adr_cnt++;
;     813  	     if(adr_cnt>=100)
;     814  	     	{
;     815  	     	adr_temp=adr_new;
;     816  	     	}
;     817  	     }	
;     818    	}
;     819 else adr_cnt=0;
;     820 adr_old=adr_new;
;     821 if(adr!=CONST_ADR[adr_temp]) adr=CONST_ADR[adr_temp]; 
;     822 
;     823 
;     824 //if(adr!=0b00000011)adr=0b00000011;*/
;     825 
;     826 
;     827 
;     828 ADMUX=0b01000111;
	LDI  R30,LOW(71)
	CALL SUBOPT_0x1F
;     829 ADCSRA=0b10100110;
;     830 ADCSRA|=0b01000000;
;     831 delay_ms(10);
;     832 //plazma_int[0]=ADCW;
;     833 aaa[0]=adr_gran(ADCW);
	CALL SUBOPT_0x20
	STD  Y+5,R30
;     834 tempSI=ADCW/200;
	CALL SUBOPT_0x21
;     835 gran(&tempSI,0,3);
;     836 aaaa[0]=(char)tempSI;
	STD  Y+2,R16
;     837 
;     838 ADMUX=0b01000000;
	LDI  R30,LOW(64)
	CALL SUBOPT_0x1F
;     839 ADCSRA=0b10100110;
;     840 ADCSRA|=0b01000000;
;     841 delay_ms(10);
;     842 //plazma_int[1]=ADCW;
;     843 aaa[1]=adr_gran(ADCW);
	CALL SUBOPT_0x20
	STD  Y+6,R30
;     844 tempSI=ADCW/200;
	CALL SUBOPT_0x21
;     845 gran(&tempSI,0,3);
;     846 aaaa[1]=(char)tempSI;
	MOVW R26,R28
	ADIW R26,3
	ST   X,R16
;     847 
;     848 
;     849 ADMUX=0b01000101;
	LDI  R30,LOW(69)
	CALL SUBOPT_0x1F
;     850 ADCSRA=0b10100110;
;     851 ADCSRA|=0b01000000;
;     852 delay_ms(10);
;     853 //plazma_int[2]=ADCW;
;     854 aaa[2]=adr_gran(ADCW);
	CALL SUBOPT_0x20
	STD  Y+7,R30
;     855 tempSI=ADCW/200;
	CALL SUBOPT_0x21
;     856 gran(&tempSI,0,3);
;     857 aaaa[2]=(char)tempSI;
	MOVW R26,R28
	ADIW R26,4
	ST   X,R16
;     858 
;     859 adr=100;
	LDI  R30,LOW(100)
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMWRB
;     860 //adr=0;//aaa[0]+ (aaa[1]*4)+ (aaa[2]*16);
;     861 
;     862 if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
	LDD  R26,Y+5
	CPI  R26,LOW(0x64)
	BREQ _0xB5
	LDD  R26,Y+6
	CPI  R26,LOW(0x64)
	BREQ _0xB5
	LDD  R26,Y+7
	CPI  R26,LOW(0x64)
	BRNE _0xB6
_0xB5:
	RJMP _0xB4
_0xB6:
;     863 	{
;     864 	if(aaa[0]==0)
	LDD  R30,Y+5
	CPI  R30,0
	BRNE _0xB7
;     865 		{
;     866 		if(aaa[1]==0)adr=3;
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0xB8
	LDI  R30,LOW(3)
	RJMP _0x19A
;     867 		else adr=0;
_0xB8:
	LDI  R30,LOW(0)
_0x19A:
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMWRB
;     868 		}
;     869 	else if(aaa[1]==0)adr=1;	
	RJMP _0xBA
_0xB7:
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0xBB
	LDI  R30,LOW(1)
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMWRB
;     870 	else if(aaa[2]==0)adr=2;
	RJMP _0xBC
_0xBB:
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0xBD
	LDI  R30,LOW(2)
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMWRB
;     871      
;     872 	//adr=1;
;     873 	}
_0xBD:
_0xBC:
_0xBA:
;     874 else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adr=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
	RJMP _0xBE
_0xB4:
	LDD  R26,Y+5
	CPI  R26,LOW(0x64)
	BRNE _0xC0
	LDD  R26,Y+6
	CPI  R26,LOW(0x64)
	BRNE _0xC0
	LDD  R26,Y+7
	CPI  R26,LOW(0x64)
	BREQ _0xC1
_0xC0:
	RJMP _0xBF
_0xC1:
	LDD  R30,Y+3
	LSL  R30
	LSL  R30
	LDD  R26,Y+2
	ADD  R30,R26
	PUSH R30
	LDD  R30,Y+4
	SWAP R30
	ANDI R30,0xF0
	POP  R26
	ADD  R30,R26
	RJMP _0x19B
;     875    /*	{
;     876 	adr=0;
;     877 	} */
;     878 else adr=100;
_0xBF:
	LDI  R30,LOW(100)
_0x19B:
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMWRB
_0xBE:
;     879 /*if(adr_gran(aaa[2])==100)adr=2;
;     880 else *///adr=adr_gran(aaa[2]);
;     881 ///adr=0;
;     882 //plazma=adr;
;     883 //if(adr==100)adr=0;
;     884 
;     885 //plazma
;     886 
;     887 } 
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	RET
;     888 
;     889 
;     890 //-----------------------------------------------
;     891 void apv_hndl(void)
;     892 {
_apv_hndl:
;     893 if(apv_cnt[0])
	LDS  R30,_apv_cnt
	CPI  R30,0
	BREQ _0xC3
;     894 	{
;     895 	apv_cnt[0]--;
	LDI  R26,LOW(_apv_cnt)
	LDI  R27,HIGH(_apv_cnt)
	CALL SUBOPT_0x22
;     896 	if(apv_cnt[0]==0)
	LDS  R30,_apv_cnt
	CPI  R30,0
	BRNE _0xC4
;     897 		{
;     898 		flags&=0b11100001;
	CALL SUBOPT_0x1C
;     899 		tsign_cnt=0;
;     900 		tmax_cnt=0;
;     901 		umax_cnt=0;
;     902 		umin_cnt=0;
;     903 		cnt_adc_ch_2_delta=0;
	CALL SUBOPT_0x23
;     904 		led_drv_cnt=30;
;     905 		}
;     906 	}
_0xC4:
;     907 else if(apv_cnt[1])
	RJMP _0xC5
_0xC3:
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BREQ _0xC6
;     908 	{
;     909 	apv_cnt[1]--;
	__POINTW2MN _apv_cnt,1
	CALL SUBOPT_0x22
;     910 	if(apv_cnt[1]==0)
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0xC7
;     911 		{
;     912 		flags&=0b11100001;
	CALL SUBOPT_0x1C
;     913 		tsign_cnt=0;
;     914 		tmax_cnt=0;
;     915 		umax_cnt=0;
;     916 		umin_cnt=0;
;     917 		cnt_adc_ch_2_delta=0;		
	CALL SUBOPT_0x23
;     918 		led_drv_cnt=30;
;     919 		}
;     920 	}	       
_0xC7:
;     921 else if(apv_cnt[2])
	RJMP _0xC8
_0xC6:
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BREQ _0xC9
;     922 	{
;     923 	apv_cnt[2]--;
	__POINTW2MN _apv_cnt,2
	CALL SUBOPT_0x22
;     924 	if(apv_cnt[2]==0)
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0xCA
;     925 		{
;     926 		flags&=0b11100001;
	CALL SUBOPT_0x1C
;     927 		tsign_cnt=0;
;     928 		tmax_cnt=0;
;     929 		umax_cnt=0;
;     930 		umin_cnt=0;          
;     931 		cnt_adc_ch_2_delta=0;		
	CALL SUBOPT_0x23
;     932 		led_drv_cnt=30;
;     933 		}
;     934 	}	         
_0xCA:
;     935 	
;     936 if(apv_cnt_)
_0xC9:
_0xC8:
_0xC5:
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BREQ _0xCB
;     937 	{
;     938 	apv_cnt_--;
	SBIW R30,1
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R31
;     939 	if(apv_cnt_==0) 
	SBIW R30,0
	BRNE _0xCC
;     940 		{
;     941 		bAPV=0;
	LDI  R30,LOW(0)
	STS  _bAPV,R30
;     942 		apv_start();
	CALL _apv_start
;     943 		}
;     944 	}	   
_0xCC:
;     945 	
;     946 if((umin_cnt==0)&&(umax_cnt==0)&&(cnt_adc_ch_2_delta==0)&&(PORTD.2==0))
_0xCB:
	LDS  R26,_umin_cnt
	LDS  R27,_umin_cnt+1
	CALL __CPW02
	BRNE _0xCE
	LDS  R26,_umax_cnt
	LDS  R27,_umax_cnt+1
	CALL __CPW02
	BRNE _0xCE
	LDS  R26,_cnt_adc_ch_2_delta
	CPI  R26,LOW(0x0)
	BRNE _0xCE
	SBIS 0xB,2
	RJMP _0xCF
_0xCE:
	RJMP _0xCD
_0xCF:
;     947 	{
;     948 	if(cnt_apv_off<20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRSH _0xD0
;     949 		{
;     950 		cnt_apv_off++;
	LDS  R30,_cnt_apv_off
	SUBI R30,-LOW(1)
	STS  _cnt_apv_off,R30
;     951 		if(cnt_apv_off>=20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRLO _0xD1
;     952 			{
;     953 			apv_stop();
	CALL _apv_stop
;     954 			}
;     955 		}
_0xD1:
;     956 	}
_0xD0:
;     957 else cnt_apv_off=0;	
	RJMP _0xD2
_0xCD:
	LDI  R30,LOW(0)
	STS  _cnt_apv_off,R30
_0xD2:
;     958 	
;     959 }
	RET
;     960       
;     961 //-----------------------------------------------
;     962 void link_drv(void)
;     963 {
_link_drv:
;     964 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0xD3
;     965 	{
;     966 	if(link_cnt==49)flags&=0b11000001;
	LDS  R26,_link_cnt
	CPI  R26,LOW(0x31)
	BRNE _0xD4
	LDS  R30,_flags
	ANDI R30,LOW(0xC1)
	STS  _flags,R30
;     967 	if(++link_cnt>=50)
_0xD4:
	LDS  R26,_link_cnt
	SUBI R26,-LOW(1)
	STS  _link_cnt,R26
	CPI  R26,LOW(0x32)
	BRLO _0xD5
;     968 		{
;     969 		link_cnt=50;
	LDI  R30,LOW(50)
	STS  _link_cnt,R30
;     970     		link=OFF;
	LDI  R30,LOW(170)
	STS  _link,R30
;     971     		if(!res_fl_)
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0xD6
;     972 			{
;     973 	    		bRES_=1;
	LDI  R30,LOW(1)
	STS  _bRES_,R30
;     974 	    		res_fl_=1;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMWRB
;     975 	    		}
;     976     		}            
_0xD6:
;     977 	}
_0xD5:
;     978 else link=OFF;	
	RJMP _0xD7
_0xD3:
	LDI  R30,LOW(170)
	STS  _link,R30
_0xD7:
;     979 } 
	RET
;     980 
;     981 //-----------------------------------------------
;     982 void temper_drv(void)
;     983 {
_temper_drv:
;     984 
;     985 if(T>tsign) tsign_cnt++;
	LDI  R26,LOW(_tsign)
	LDI  R27,HIGH(_tsign)
	CALL __EEPROMRDW
	LDS  R26,_T
	LDS  R27,_T+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xD8
	LDS  R30,_tsign_cnt
	LDS  R31,_tsign_cnt+1
	ADIW R30,1
	STS  _tsign_cnt,R30
	STS  _tsign_cnt+1,R31
;     986 else if (T<(tsign-1)) tsign_cnt--;
	RJMP _0xD9
_0xD8:
	LDI  R26,LOW(_tsign)
	LDI  R27,HIGH(_tsign)
	CALL __EEPROMRDW
	CALL SUBOPT_0x24
	BRGE _0xDA
	LDS  R30,_tsign_cnt
	LDS  R31,_tsign_cnt+1
	SBIW R30,1
	STS  _tsign_cnt,R30
	STS  _tsign_cnt+1,R31
;     987 
;     988 gran(&tsign_cnt,0,60);
_0xDA:
_0xD9:
	LDI  R30,LOW(_tsign_cnt)
	LDI  R31,HIGH(_tsign_cnt)
	CALL SUBOPT_0x25
;     989 
;     990 if(tsign_cnt>=55)
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	CPI  R26,LOW(0x37)
	LDI  R30,HIGH(0x37)
	CPC  R27,R30
	BRLT _0xDB
;     991 	{
;     992 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0xDD
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0xDF
_0xDD:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0xDC
_0xDF:
	LDS  R30,_flags
	ORI  R30,4
	STS  _flags,R30
;     993 	}
_0xDC:
;     994 else if (tsign_cnt<=5) flags&=0b11111011;
	RJMP _0xE1
_0xDB:
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R26
	CPC  R31,R27
	BRLT _0xE2
	LDS  R30,_flags
	ANDI R30,0xFB
	STS  _flags,R30
;     995 
;     996 
;     997 
;     998 	
;     999 if(T>tmax) tmax_cnt++;
_0xE2:
_0xE1:
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMRDW
	LDS  R26,_T
	LDS  R27,_T+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xE3
	LDS  R30,_tmax_cnt
	LDS  R31,_tmax_cnt+1
	ADIW R30,1
	STS  _tmax_cnt,R30
	STS  _tmax_cnt+1,R31
;    1000 else if (T<(tmax-1)) tmax_cnt--;
	RJMP _0xE4
_0xE3:
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMRDW
	CALL SUBOPT_0x24
	BRGE _0xE5
	LDS  R30,_tmax_cnt
	LDS  R31,_tmax_cnt+1
	SBIW R30,1
	STS  _tmax_cnt,R30
	STS  _tmax_cnt+1,R31
;    1001 
;    1002 gran(&tmax_cnt,0,60);
_0xE5:
_0xE4:
	LDI  R30,LOW(_tmax_cnt)
	LDI  R31,HIGH(_tmax_cnt)
	CALL SUBOPT_0x25
;    1003 
;    1004 if(tmax_cnt>=55)
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	CPI  R26,LOW(0x37)
	LDI  R30,HIGH(0x37)
	CPC  R27,R30
	BRLT _0xE6
;    1005 	{
;    1006 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0xE8
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0xEA
_0xE8:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0xE7
_0xEA:
	LDS  R30,_flags
	ORI  R30,2
	STS  _flags,R30
;    1007 	}
_0xE7:
;    1008 else if (tmax_cnt<=5) flags&=0b11111101;
	RJMP _0xEC
_0xE6:
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R26
	CPC  R31,R27
	BRLT _0xED
	LDS  R30,_flags
	ANDI R30,0xFD
	STS  _flags,R30
;    1009 
;    1010 
;    1011 } 
_0xED:
_0xEC:
	RET
;    1012 
;    1013 //-----------------------------------------------
;    1014 void u_drv(void)
;    1015 { 
_u_drv:
;    1016 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0xEE
;    1017 	{        
;    1018 	if(Ui>Umax)umax_cnt++;
	LDI  R26,LOW(_Umax)
	LDI  R27,HIGH(_Umax)
	CALL __EEPROMRDW
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xEF
	CALL SUBOPT_0x26
;    1019 	else umax_cnt=0;
	RJMP _0xF0
_0xEF:
	LDI  R30,0
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
_0xF0:
;    1020 	gran(&umax_cnt,0,10);
	CALL SUBOPT_0x27
;    1021 	if(umax_cnt>=10)flags|=0b00001000;
	BRLT _0xF1
	CALL SUBOPT_0x28
;    1022 
;    1023 	
;    1024 	if((Ui<Un)&&((Un-Ui)>dU)&&(!PORTB.2))umin_cnt++;	
_0xF1:
	LDS  R30,_Un
	LDS  R31,_Un+1
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	CP   R26,R30
	CPC  R27,R31
	BRSH _0xF3
	SUB  R30,R26
	SBC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_dU)
	LDI  R27,HIGH(_dU)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xF3
	SBIS 0x5,2
	RJMP _0xF4
_0xF3:
	RJMP _0xF2
_0xF4:
	CALL SUBOPT_0x29
;    1025 	else umin_cnt=0;
	RJMP _0xF5
_0xF2:
	LDI  R30,0
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
_0xF5:
;    1026 	gran(&umin_cnt,0,10);	
	CALL SUBOPT_0x2A
;    1027 	if(umin_cnt>=10)flags|=0b00010000;	  
	BRLT _0xF6
	CALL SUBOPT_0x2B
;    1028 	}
_0xF6:
;    1029 else if(jp_mode==jp3)
	RJMP _0xF7
_0xEE:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0xF8
;    1030 	{        
;    1031 	if(Ui>700)umax_cnt++;
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	LDI  R30,LOW(700)
	LDI  R31,HIGH(700)
	CP   R30,R26
	CPC  R31,R27
	BRSH _0xF9
	CALL SUBOPT_0x26
;    1032 	else umax_cnt=0;
	RJMP _0xFA
_0xF9:
	LDI  R30,0
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
_0xFA:
;    1033 	gran(&umax_cnt,0,10);
	CALL SUBOPT_0x27
;    1034 	if(umax_cnt>=10)flags|=0b00001000;
	BRLT _0xFB
	CALL SUBOPT_0x28
;    1035 
;    1036 	
;    1037 	if((Ui<200)&&(!PORTB.2))umin_cnt++;	
_0xFB:
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRSH _0xFD
	SBIS 0x5,2
	RJMP _0xFE
_0xFD:
	RJMP _0xFC
_0xFE:
	CALL SUBOPT_0x29
;    1038 	else umin_cnt=0;
	RJMP _0xFF
_0xFC:
	LDI  R30,0
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
_0xFF:
;    1039 	gran(&umin_cnt,0,10);	
	CALL SUBOPT_0x2A
;    1040 	if(umin_cnt>=10)flags|=0b00010000;	  
	BRLT _0x100
	CALL SUBOPT_0x2B
;    1041 	}
_0x100:
;    1042 }
_0xF8:
_0xF7:
	RET
;    1043 
;    1044 //-----------------------------------------------
;    1045 void led_hndl(void)
;    1046 { 
_led_hndl:
;    1047 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x101
;    1048 	{
;    1049 	if(main_cnt1<(5*TZAS))
	CALL SUBOPT_0x13
	CALL SUBOPT_0x2C
	BRGE _0x102
;    1050 		{
;    1051 		led_red=0x00000000L;
	CALL SUBOPT_0x2D
;    1052 		led_green=0x03030303L;
;    1053 		}
;    1054 	else if((link==ON)&&(flags_tu&0b10000000))
	RJMP _0x103
_0x102:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x105
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x106
_0x105:
	RJMP _0x104
_0x106:
;    1055 		{
;    1056 		led_red=0x00055555L;
	__GETD1N 0x55555
	CALL SUBOPT_0x2E
;    1057  		led_green=0xffffffffL;
;    1058  		} 
;    1059 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
	RJMP _0x107
_0x104:
	CALL SUBOPT_0x13
	CALL SUBOPT_0x2F
	BRGE _0x109
	CALL SUBOPT_0x13
	SUBI R30,-LOW(100)
	CALL SUBOPT_0x2C
	BRLT _0x10A
_0x109:
	RJMP _0x108
_0x10A:
;    1060 		{
;    1061 		led_red=0x00000000L;
	__GETD1N 0x0
	CALL SUBOPT_0x2E
;    1062 		led_green=0xffffffffL;	
;    1063 		}  
;    1064 	
;    1065 	else  if(link==OFF)
	RJMP _0x10B
_0x108:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x10C
;    1066  		{
;    1067  		led_red=0x55555555L;
	__GETD1N 0x55555555
	CALL SUBOPT_0x2E
;    1068  		led_green=0xffffffffL;
;    1069  		}
;    1070 		         
;    1071 	else if((link==ON)&&((flags&0b00111110)==0))
	RJMP _0x10D
_0x10C:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x10F
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x110
_0x10F:
	RJMP _0x10E
_0x110:
;    1072 		{
;    1073 		led_red=0x00000000L;
	__GETD1N 0x0
	CALL SUBOPT_0x2E
;    1074 		led_green=0xffffffffL;
;    1075 		}
;    1076 
;    1077 
;    1078 	
;    1079 
;    1080 		
;    1081 	else if((flags&0b00111110)==0b00000100)
	RJMP _0x111
_0x10E:
	CALL SUBOPT_0x30
	BRNE _0x112
;    1082 		{
;    1083 		led_red=0x00010001L;
	__GETD1N 0x10001
	CALL SUBOPT_0x2E
;    1084 		led_green=0xffffffffL;	
;    1085 		}
;    1086 	else if(flags&0b00000010)
	RJMP _0x113
_0x112:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x114
;    1087 		{
;    1088 		led_red=0x00010001L;
	CALL SUBOPT_0x31
;    1089 		led_green=0x00000000L;	
;    1090 		} 
;    1091 	else if(flags&0b00001000)
	RJMP _0x115
_0x114:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x116
;    1092 		{
;    1093 		led_red=0x00090009L;
	CALL SUBOPT_0x32
;    1094 		led_green=0x00000000L;	
;    1095 		}
;    1096 	else if(flags&0b00010000)
	RJMP _0x117
_0x116:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x118
;    1097 		{
;    1098 		led_red=0x00490049L;
	__GETD1N 0x490049
	CALL SUBOPT_0x33
;    1099 		led_green=0x00000000L;	
;    1100 		}			
;    1101 
;    1102 	else if((link==ON)&&(flags&0b00100000))
	RJMP _0x119
_0x118:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x11B
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x11C
_0x11B:
	RJMP _0x11A
_0x11C:
;    1103 		{
;    1104 		led_red=0x00000000L;
	__GETD1N 0x0
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
;    1105 		led_green=0x00030003L;
	__GETD1N 0x30003
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
;    1106 		} 
;    1107 
;    1108 	if((jp_mode==jp1))
_0x11A:
_0x119:
_0x117:
_0x115:
_0x113:
_0x111:
_0x10D:
_0x10B:
_0x107:
_0x103:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x11D
;    1109 		{
;    1110 		led_red=0x00000000L;
	__GETD1N 0x0
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
;    1111 		led_green=0x33333333L;
	__GETD1N 0x33333333
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
;    1112 		}
;    1113 	else if((jp_mode==jp2))
	RJMP _0x11E
_0x11D:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x11F
;    1114 		{
;    1115 		led_red=0xccccccccL;
	__GETD1N 0xCCCCCCCC
	CALL SUBOPT_0x33
;    1116 		led_green=0x00000000L;
;    1117 		}
;    1118 	}		
_0x11F:
_0x11E:
;    1119 else if(jp_mode==jp3)
	RJMP _0x120
_0x101:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x121
;    1120 	{
;    1121 	if(main_cnt1<(5*TZAS))
	CALL SUBOPT_0x13
	CALL SUBOPT_0x2C
	BRGE _0x122
;    1122 		{
;    1123 		led_red=0x00000000L;
	CALL SUBOPT_0x2D
;    1124 		led_green=0x03030303L;
;    1125 		}
;    1126 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
	RJMP _0x123
_0x122:
	CALL SUBOPT_0x13
	CALL SUBOPT_0x2F
	BRGE _0x125
	CALL SUBOPT_0x13
	SUBI R30,-LOW(70)
	CALL SUBOPT_0x2C
	BRLT _0x126
_0x125:
	RJMP _0x124
_0x126:
;    1127 		{
;    1128 		led_red=0x00000000L;
	__GETD1N 0x0
	CALL SUBOPT_0x2E
;    1129 		led_green=0xffffffffL;	
;    1130 		} 
;    1131 		
;    1132 	else if((flags&0b00011110)==0)
	RJMP _0x127
_0x124:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x128
;    1133 		{
;    1134 		led_red=0x00000000L;
	__GETD1N 0x0
	CALL SUBOPT_0x2E
;    1135 		led_green=0xffffffffL;
;    1136 		}
;    1137     
;    1138 
;    1139 	else if((flags&0b00111110)==0b00000100)
	RJMP _0x129
_0x128:
	CALL SUBOPT_0x30
	BRNE _0x12A
;    1140 		{
;    1141 		led_red=0x00010001L;
	__GETD1N 0x10001
	CALL SUBOPT_0x2E
;    1142 		led_green=0xffffffffL;	
;    1143 		}
;    1144 	else if(flags&0b00000010)
	RJMP _0x12B
_0x12A:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x12C
;    1145 		{
;    1146 		led_red=0x00010001L;
	CALL SUBOPT_0x31
;    1147 		led_green=0x00000000L;	
;    1148 		} 
;    1149 	else if(flags&0b00001000)
	RJMP _0x12D
_0x12C:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x12E
;    1150 		{
;    1151 		led_red=0x00090009L;
	CALL SUBOPT_0x32
;    1152 		led_green=0x00000000L;	
;    1153 		}
;    1154 	else if(flags&0b00010000)
	RJMP _0x12F
_0x12E:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x130
;    1155 		{
;    1156 		led_red=0x00490049L;
	__GETD1N 0x490049
	CALL SUBOPT_0x2E
;    1157 		led_green=0xffffffffL;	
;    1158 		}  
;    1159 		/*led_green=0x33333333L;
;    1160 		led_red=0xccccccccL;*/					
;    1161 	}						
_0x130:
_0x12F:
_0x12D:
_0x12B:
_0x129:
_0x127:
_0x123:
;    1162 
;    1163 }
_0x121:
_0x120:
	RET
;    1164  
;    1165 //-----------------------------------------------
;    1166 void pwr_drv(void)
;    1167 {
_pwr_drv:
;    1168 DDRB.2=1;
	SBI  0x4,2
;    1169 
;    1170 if(main_cnt1<150)main_cnt1++;
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CPI  R26,LOW(0x96)
	LDI  R30,HIGH(0x96)
	CPC  R27,R30
	BRGE _0x131
	LDS  R30,_main_cnt1
	LDS  R31,_main_cnt1+1
	ADIW R30,1
	STS  _main_cnt1,R30
	STS  _main_cnt1+1,R31
;    1171 
;    1172 if(main_cnt1<(5*TZAS))
_0x131:
	CALL SUBOPT_0x13
	CALL SUBOPT_0x2C
	BRGE _0x132
;    1173 	{
;    1174 	PORTB.2=1;
	SBI  0x5,2
;    1175 	}         
;    1176 else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
	RJMP _0x133
_0x132:
	CALL SUBOPT_0x13
	CALL SUBOPT_0x2F
	BRGE _0x135
	CALL SUBOPT_0x13
	SUBI R30,-LOW(70)
	CALL SUBOPT_0x2C
	BRLT _0x136
_0x135:
	RJMP _0x134
_0x136:
;    1177 	{
;    1178 	PORTB.2=0;
	CBI  0x5,2
;    1179 	}    	
;    1180 else if(bBL)
	RJMP _0x137
_0x134:
	SBIS 0x1E,7
	RJMP _0x138
;    1181 	{
;    1182 	PORTB.2=1;
	SBI  0x5,2
;    1183 	}
;    1184 else if(!bBL)
	RJMP _0x139
_0x138:
	SBIC 0x1E,7
	RJMP _0x13A
;    1185 	{
;    1186 	PORTB.2=0;
	CBI  0x5,2
;    1187 	}
;    1188 
;    1189 DDRB|=0b00000010;
_0x13A:
_0x139:
_0x137:
_0x133:
	SBI  0x4,1
;    1190 
;    1191 gran(&pwm_u,2,1020);
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL SUBOPT_0x34
;    1192 
;    1193 
;    1194 OCR1A=pwm_u;
	LDS  R30,_pwm_u
	LDS  R31,_pwm_u+1
	STS  0x88,R30
	STS  0x88+1,R31
;    1195 /*PORTB.2=1;
;    1196 OCR1A=0;*/
;    1197 } 
	RET
;    1198 
;    1199 //-----------------------------------------------
;    1200 void pwr_hndl(void)
;    1201 {
_pwr_hndl:
;    1202 //vol_u_temp=800;
;    1203 if(jp_mode==jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x13B
;    1204 	{
;    1205 	if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE _0x13C
;    1206 		{
;    1207 		pwm_u=500;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
;    1208 		//pwm_i=0x3ff;
;    1209 		bBL=0;
	CBI  0x1E,7
;    1210 		}
;    1211 	else if(flags&0b00001010)
	RJMP _0x13D
_0x13C:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ _0x13E
;    1212 		{
;    1213 		pwm_u=0;
	LDI  R30,0
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
;    1214 		//pwm_i=0;
;    1215 		bBL=1;
	SBI  0x1E,7
;    1216 		}	
;    1217 	
;    1218 	}  
_0x13E:
_0x13D:
;    1219 else if(jp_mode==jp2)
	RJMP _0x13F
_0x13B:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x140
;    1220 	{
;    1221 	pwm_u=0;
	LDI  R30,0
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
;    1222 	//pwm_i=0x3ff;
;    1223 	bBL=0;
	CBI  0x1E,7
;    1224 	}     
;    1225 else if(jp_mode==jp1)
	RJMP _0x141
_0x140:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x142
;    1226 	{
;    1227 	pwm_u=0x3ff;
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
;    1228 	//pwm_i=0x3ff;
;    1229 	bBL=0;
	CBI  0x1E,7
;    1230 	} 
;    1231 	
;    1232 else if(link==OFF)
	RJMP _0x143
_0x142:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x144
;    1233 	{ 
;    1234 	if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE _0x145
;    1235 		{
;    1236 		pwm_u=U_AVT;
	LDI  R26,LOW(_U_AVT)
	LDI  R27,HIGH(_U_AVT)
	CALL __EEPROMRDW
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
;    1237 		gran(&pwm_u,0,1020);
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x34
;    1238 	    //	pwm_i=0x3ff;
;    1239 		bBL=0;
	CBI  0x1E,7
;    1240 		}
;    1241 	else if(flags&0b00011010)
	RJMP _0x146
_0x145:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x147
;    1242 		{
;    1243 		pwm_u=0;
	LDI  R30,0
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
;    1244 		//pwm_i=0;
;    1245 		bBL=1;
	SBI  0x1E,7
;    1246 		}		
;    1247 	}
_0x147:
_0x146:
;    1248 
;    1249 else	if(link==ON)
	RJMP _0x148
_0x144:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x149
;    1250 	{
;    1251 	if((flags&0b00100000)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x14A
;    1252 		{
;    1253 		if(((flags&0b00011010)==0)||(flags&0b01000000))
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x14C
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x14B
_0x14C:
;    1254 			{
;    1255 			pwm_u=vol_u_temp+_x_;
	LDS  R30,__x_
	LDS  R31,__x_+1
	LDS  R26,_vol_u_temp
	LDS  R27,_vol_u_temp+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
;    1256 		    //	pwm_i=0x3ff;
;    1257 			bBL=0;
	CBI  0x1E,7
;    1258 			}
;    1259 		else if(flags&0b00011010)
	RJMP _0x14E
_0x14B:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x14F
;    1260 			{
;    1261 			pwm_u=0;
	LDI  R30,0
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
;    1262 			//pwm_i=0;
;    1263 			bBL=1;
	SBI  0x1E,7
;    1264 			}
;    1265 		}
_0x14F:
_0x14E:
;    1266 	else if(flags&0b00100000)
	RJMP _0x150
_0x14A:
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x151
;    1267 		{
;    1268 		pwm_u=0;
	LDI  R30,0
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
;    1269 	    //	pwm_i=0;
;    1270 		bBL=1;
	SBI  0x1E,7
;    1271 		}			
;    1272 	}	   
_0x151:
_0x150:
;    1273 //pwm_u=vol_u_temp;		
;    1274 }
_0x149:
_0x148:
_0x143:
_0x141:
_0x13F:
	RET
;    1275 
;    1276 //-----------------------------------------------
;    1277 void JP_drv(void)
;    1278 {
_JP_drv:
;    1279 
;    1280 DDRD.5=1;
	SBI  0xA,5
;    1281 DDRD.6=1;
	SBI  0xA,6
;    1282 PORTD.5=1;
	SBI  0xB,5
;    1283 PORTD.6=1;
	SBI  0xB,6
;    1284 
;    1285 if(PIND.5)
	SBIS 0x9,5
	RJMP _0x152
;    1286 	{
;    1287 	if(cnt_JP0<10)
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRSH _0x153
;    1288 		{
;    1289 		cnt_JP0++;
	LDS  R30,_cnt_JP0
	SUBI R30,-LOW(1)
	STS  _cnt_JP0,R30
;    1290 		}			     
;    1291 	}
_0x153:
;    1292 else if(!PIND.5)
	RJMP _0x154
_0x152:
	SBIC 0x9,5
	RJMP _0x155
;    1293 	{
;    1294 	if(cnt_JP0)
	LDS  R30,_cnt_JP0
	CPI  R30,0
	BREQ _0x156
;    1295 		{
;    1296 		cnt_JP0--;
	SUBI R30,LOW(1)
	STS  _cnt_JP0,R30
;    1297 		}	
;    1298 	}
_0x156:
;    1299 	 
;    1300 if(PIND.6)
_0x155:
_0x154:
	SBIS 0x9,6
	RJMP _0x157
;    1301 	{
;    1302 	if(cnt_JP1<10)
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BRSH _0x158
;    1303 		{
;    1304 		cnt_JP1++;
	LDS  R30,_cnt_JP1
	SUBI R30,-LOW(1)
	STS  _cnt_JP1,R30
;    1305 		}			     
;    1306 	}
_0x158:
;    1307 else if(!PIND.6)
	RJMP _0x159
_0x157:
	SBIC 0x9,6
	RJMP _0x15A
;    1308 	{
;    1309 	if(cnt_JP1)
	LDS  R30,_cnt_JP1
	CPI  R30,0
	BREQ _0x15B
;    1310 		{
;    1311 		cnt_JP1--;
	SUBI R30,LOW(1)
	STS  _cnt_JP1,R30
;    1312 		}	
;    1313 	}	
_0x15B:
;    1314 
;    1315 
;    1316 if((cnt_JP0==10)&&(cnt_JP1==10))
_0x15A:
_0x159:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x15D
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x15E
_0x15D:
	RJMP _0x15C
_0x15E:
;    1317 	{
;    1318 	jp_mode=jp0;
	LDI  R30,LOW(0)
	STS  _jp_mode,R30
;    1319 	}
;    1320 if((cnt_JP0==0)&&(cnt_JP1==10))
_0x15C:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x160
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x161
_0x160:
	RJMP _0x15F
_0x161:
;    1321 	{
;    1322 	jp_mode=jp1;
	LDI  R30,LOW(1)
	STS  _jp_mode,R30
;    1323 	}
;    1324 if((cnt_JP0==10)&&(cnt_JP1==0))
_0x15F:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x163
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x164
_0x163:
	RJMP _0x162
_0x164:
;    1325 	{
;    1326 	jp_mode=jp2;
	LDI  R30,LOW(2)
	STS  _jp_mode,R30
;    1327 	}		 
;    1328 if((cnt_JP0==0)&&(cnt_JP1==0))
_0x162:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x166
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x167
_0x166:
	RJMP _0x165
_0x167:
;    1329 	{
;    1330 	jp_mode=jp3;
	LDI  R30,LOW(3)
	STS  _jp_mode,R30
;    1331 	}	
;    1332 		
;    1333 }
_0x165:
	RET
;    1334 
;    1335 //-----------------------------------------------
;    1336 void adc_hndl(void)
;    1337 {                        
_adc_hndl:
;    1338 unsigned tempUI;
;    1339 tempUI=ADCW;
	ST   -Y,R17
	ST   -Y,R16
;	tempUI -> R16,R17
	__GETWRMN 120,0,16,17
;    1340 adc_buff[adc_ch,adc_cnt]=tempUI;
	CALL SUBOPT_0x35
	PUSH R27
	PUSH R26
	LSL  R30
	ROL  R31
	CALL __LSLW4
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_adc_cnt
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	ST   X+,R16
	ST   X,R17
;    1341 if(adc_ch==2)
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BRNE _0x168
;    1342 	{
;    1343 	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
	LDS  R30,_adc_ch_2_max
	LDS  R31,_adc_ch_2_max+1
	CP   R30,R16
	CPC  R31,R17
	BRGE _0x169
	__PUTWMRN _adc_ch_2_max,0,16,17
;    1344 	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
	RJMP _0x16A
_0x169:
	LDS  R30,_adc_ch_2_min
	LDS  R31,_adc_ch_2_min+1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x16B
	__PUTWMRN _adc_ch_2_min,0,16,17
;    1345 	}
_0x16B:
_0x16A:
;    1346 
;    1347 if((adc_cnt&0x03)==0)
_0x168:
	LDS  R30,_adc_cnt
	ANDI R30,LOW(0x3)
	BREQ PC+3
	JMP _0x16C
;    1348 	{
;    1349 	char i;
;    1350 	adc_buff_[adc_ch]=0;
	SBIW R28,1
;	i -> Y+0
	CALL SUBOPT_0x36
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
;    1351 	for(i=0;i<16;i++)
	ST   Y,R30
_0x16E:
	LD   R26,Y
	CPI  R26,LOW(0x10)
	BRSH _0x16F
;    1352 		{
;    1353 		adc_buff_[adc_ch]+=adc_buff[adc_ch,i];
	CALL SUBOPT_0x36
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __GETW1P
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x35
	PUSH R27
	PUSH R26
	LSL  R30
	ROL  R31
	CALL __LSLW4
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,Y
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;    1354 		}                                     
	CALL SUBOPT_0x11
	RJMP _0x16E
_0x16F:
;    1355 	adc_buff_[adc_ch]>>=4;	
	CALL SUBOPT_0x36
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __GETW1P
	CALL __LSRW4
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;    1356 	}                     
	ADIW R28,1
;    1357 
;    1358 if(++adc_ch>=4)
_0x16C:
	LDS  R26,_adc_ch
	SUBI R26,-LOW(1)
	STS  _adc_ch,R26
	CPI  R26,LOW(0x4)
	BRLO _0x170
;    1359 	{
;    1360 	adc_ch=0;
	LDI  R30,LOW(0)
	STS  _adc_ch,R30
;    1361 	if(++adc_cnt>=16)
	LDS  R26,_adc_cnt
	SUBI R26,-LOW(1)
	STS  _adc_cnt,R26
	CPI  R26,LOW(0x10)
	BRLO _0x171
;    1362 		{
;    1363 		adc_cnt=0;
	STS  _adc_cnt,R30
;    1364 		}
;    1365 	}	          
_0x171:
;    1366 DDRC&=0b11000000;
_0x170:
	IN   R30,0x7
	ANDI R30,LOW(0xC0)
	OUT  0x7,R30
;    1367 PORTC&=0b11000000;
	IN   R30,0x8
	ANDI R30,LOW(0xC0)
	OUT  0x8,R30
;    1368 
;    1369 if(adc_ch==0) ADMUX=0b01000010; //ток
	LDS  R30,_adc_ch
	CPI  R30,0
	BRNE _0x172
	LDI  R30,LOW(66)
	STS  0x7C,R30
;    1370 else if(adc_ch==1) ADMUX=0b01000100; //напр ист
	RJMP _0x173
_0x172:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x1)
	BRNE _0x174
	LDI  R30,LOW(68)
	STS  0x7C,R30
;    1371 else if(adc_ch==2) ADMUX=0b01000011; //напр нагр
	RJMP _0x175
_0x174:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BRNE _0x176
	LDI  R30,LOW(67)
	STS  0x7C,R30
;    1372 else if(adc_ch==3) ADMUX=0b01000001; //темпер
	RJMP _0x177
_0x176:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x3)
	BRNE _0x178
	LDI  R30,LOW(65)
	STS  0x7C,R30
;    1373 
;    1374 ADCSRA=0b10100110;
_0x178:
_0x177:
_0x175:
_0x173:
	LDI  R30,LOW(166)
	STS  0x7A,R30
;    1375 ADCSRA|=0b01000000;	
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
;    1376 
;    1377 }
	LD   R16,Y+
	LD   R17,Y+
	RET
;    1378 
;    1379 //-----------------------------------------------
;    1380 void matemat(void)
;    1381 {
_matemat:
;    1382 signed long temp_SL;
;    1383 
;    1384 #ifdef _220_
;    1385 temp_SL=adc_buff_[0];
;    1386 temp_SL-=K[0,0];
;    1387 if(temp_SL<0) temp_SL=0;
;    1388 temp_SL*=K[0,1];
;    1389 temp_SL/=2400;
;    1390 I=(signed int)temp_SL;
;    1391 #else
;    1392 
;    1393 #ifdef _24_
;    1394 temp_SL=adc_buff_[0];
	SBIW R28,4
;	temp_SL -> Y+0
	LDS  R30,_adc_buff_
	LDS  R31,_adc_buff_+1
	CLR  R22
	CLR  R23
	__PUTD1S 0
;    1395 temp_SL-=K[0,0];
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL SUBOPT_0x37
	CALL __SWAPD12
	CALL __SUBD12
	CALL SUBOPT_0x38
;    1396 if(temp_SL<0) temp_SL=0;
	BRGE _0x179
	__CLRD1S 0
;    1397 temp_SL*=K[0,1];
_0x179:
	__POINTW2MN _K,2
	CALL SUBOPT_0x37
	CALL SUBOPT_0x39
;    1398 temp_SL/=800;
	__GETD1N 0x320
	CALL SUBOPT_0x3A
;    1399 I=(signed int)temp_SL;
	STS  _I,R30
	STS  _I+1,R31
;    1400 #else
;    1401 temp_SL=adc_buff_[0];
;    1402 temp_SL-=K[0,0];
;    1403 if(temp_SL<0) temp_SL=0;
;    1404 temp_SL*=K[0,1];
;    1405 temp_SL/=1200;
;    1406 I=(signed int)temp_SL;
;    1407 #endif 
;    1408 #endif
;    1409 
;    1410 temp_SL=adc_buff_[1];
	__GETW1MN _adc_buff_,2
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x38
;    1411 //temp_SL-=K[1,0];
;    1412 if(temp_SL<0) temp_SL=0;
	BRGE _0x17A
	__CLRD1S 0
;    1413 temp_SL*=K[2,1];
_0x17A:
	__POINTW2MN _K,10
	CALL SUBOPT_0x37
	CALL SUBOPT_0x39
;    1414 temp_SL/=1000;
	__GETD1N 0x3E8
	CALL SUBOPT_0x3A
;    1415 Ui=(unsigned)temp_SL;
	STS  _Ui,R30
	STS  _Ui+1,R31
;    1416 
;    1417 
;    1418 
;    1419 temp_SL=adc_buff_[2];
	__GETW1MN _adc_buff_,4
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x38
;    1420 //temp_SL-=K[2,0];
;    1421 if(temp_SL<0) temp_SL=0;
	BRGE _0x17B
	__CLRD1S 0
;    1422 temp_SL*=K[1,1];
_0x17B:
	__POINTW2MN _K,6
	CALL SUBOPT_0x37
	CALL SUBOPT_0x39
;    1423 temp_SL/=1000;
	__GETD1N 0x3E8
	CALL SUBOPT_0x3A
;    1424 Un=(unsigned)temp_SL;
	STS  _Un,R30
	STS  _Un+1,R31
;    1425 
;    1426 
;    1427 temp_SL=adc_buff_[3];
	__GETW1MN _adc_buff_,6
	CLR  R22
	CLR  R23
	__PUTD1S 0
;    1428 temp_SL*=K[3,1];
	__POINTW2MN _K,14
	CALL SUBOPT_0x37
	CALL SUBOPT_0x39
;    1429 temp_SL/=1000;
	__GETD1N 0x3E8
	CALL __DIVD21
	__PUTD1S 0
;    1430 T=(signed)(temp_SL-273);
	__SUBD1N 273
	STS  _T,R30
	STS  _T+1,R31
;    1431 
;    1432 Udb=flags;
	LDS  R30,_flags
	LDI  R31,0
	STS  _Udb,R30
	STS  _Udb+1,R31
;    1433 
;    1434 }
	ADIW R28,4
	RET
;    1435 
;    1436 //***********************************************
;    1437 //***********************************************
;    1438 //***********************************************
;    1439 //***********************************************
;    1440 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;    1441 {
_timer0_ovf_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    1442 t0_init();
	CALL _t0_init
;    1443  
;    1444 can_hndl1();
	CALL _can_hndl1
;    1445 
;    1446 if(++t0_cnt4>=10)
	INC  R13
	LDI  R30,LOW(10)
	CP   R13,R30
	BRLO _0x17C
;    1447 	{
;    1448 	t0_cnt4=0;
	CLR  R13
;    1449 //	b100Hz=1;
;    1450 
;    1451 
;    1452 if(++t0_cnt0>=10)
	INC  R9
	CP   R9,R30
	BRLO _0x17D
;    1453 	{
;    1454 	t0_cnt0=0;
	CLR  R9
;    1455 	b10Hz=1;
	SBI  0x1E,3
;    1456 	} 
;    1457 if(++t0_cnt3>=3)
_0x17D:
	INC  R12
	LDI  R30,LOW(3)
	CP   R12,R30
	BRLO _0x17E
;    1458 	{
;    1459 	t0_cnt3=0;
	CLR  R12
;    1460 	b33Hz=1;
	SBI  0x1E,2
;    1461 	} 	
;    1462 if(++t0_cnt1>=20)
_0x17E:
	INC  R10
	LDI  R30,LOW(20)
	CP   R10,R30
	BRLO _0x17F
;    1463 	{
;    1464 	t0_cnt1=0;
	CLR  R10
;    1465 	b5Hz=1;
	SBI  0x1E,4
;    1466      bFl_=!bFl_;
	CLT
	SBIS 0x1E,6
	SET
	IN   R30,0x1E
	BLD  R30,6
	OUT  0x1E,R30
;    1467 	}
;    1468 if(++t0_cnt2>=100)
_0x17F:
	INC  R11
	LDI  R30,LOW(100)
	CP   R11,R30
	BRLO _0x180
;    1469 	{
;    1470 	t0_cnt2=0;
	CLR  R11
;    1471 	b1Hz=1;
	SBI  0x1E,5
;    1472 	}		
;    1473 }
_0x180:
;    1474 }
_0x17C:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;    1475 
;    1476    
;    1477 //===============================================
;    1478 //===============================================
;    1479 //===============================================
;    1480 //===============================================
;    1481 void main(void)
;    1482 {
_main:
;    1483 
;    1484 DDRD.2=1;
	SBI  0xA,2
;    1485 PORTD.2=1;
	SBI  0xB,2
;    1486 
;    1487 DDRB.0=1;
	SBI  0x4,0
;    1488 PORTB.0=0;
	CBI  0x5,0
;    1489 
;    1490 	PORTB.2=1;
	SBI  0x5,2
;    1491 	DDRB.2=1;
	SBI  0x4,2
;    1492 DDRB|=0b00110110;
	IN   R30,0x4
	ORI  R30,LOW(0x36)
	OUT  0x4,R30
;    1493 
;    1494 TCCR1A=0x83;
	LDI  R30,LOW(131)
	STS  0x80,R30
;    1495 TCCR1B=0x09;
	LDI  R30,LOW(9)
	STS  0x81,R30
;    1496 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  0x85,R30
;    1497 TCNT1L=0x00;
	STS  0x84,R30
;    1498 OCR1AH=0x00;
	STS  0x89,R30
;    1499 OCR1AL=0x00;
	STS  0x88,R30
;    1500 OCR1BH=0x00;
	STS  0x8B,R30
;    1501 OCR1BL=0x00;
	STS  0x8A,R30
;    1502 
;    1503 SPCR=0x5D;
	LDI  R30,LOW(93)
	OUT  0x2C,R30
;    1504 SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;    1505 /*delay_ms(100);
;    1506 delay_ms(100);
;    1507 delay_ms(100);
;    1508 delay_ms(100);
;    1509 delay_ms(100);
;    1510 delay_ms(100);
;    1511 delay_ms(100);
;    1512 delay_ms(100);
;    1513 delay_ms(100);
;    1514 delay_ms(100);*/
;    1515 delay_ms(100);
	CALL SUBOPT_0xF
;    1516 delay_ms(100);
	CALL SUBOPT_0xF
;    1517 delay_ms(100);
	CALL SUBOPT_0xF
;    1518 delay_ms(100);
	CALL SUBOPT_0xF
;    1519 delay_ms(100); 
	CALL SUBOPT_0xF
;    1520 adr_hndl();
	CALL _adr_hndl
;    1521 
;    1522 if(adr==100)
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x64)
	BRNE _0x181
;    1523 	{
;    1524 	adr_hndl();
	CALL _adr_hndl
;    1525 	delay_ms(100);
	CALL SUBOPT_0xF
;    1526 	}
;    1527 if(adr==100)	
_0x181:
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x64)
	BRNE _0x182
;    1528 	{
;    1529 	adr_hndl();
	CALL _adr_hndl
;    1530 	delay_ms(100);
	CALL SUBOPT_0xF
;    1531 	}
;    1532 
;    1533 t0_init();
_0x182:
	CALL _t0_init
;    1534 
;    1535 
;    1536 
;    1537 link_cnt=0;
	CALL SUBOPT_0x16
;    1538 link=ON;
;    1539 /*
;    1540 Umax=1000;
;    1541 dU=100;
;    1542 tmax=60;
;    1543 tsign=50;
;    1544 */
;    1545 main_cnt1=0;
	LDI  R30,0
	STS  _main_cnt1,R30
	STS  _main_cnt1+1,R30
;    1546 //_x_ee_=20;
;    1547 _x_=_x_ee_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	STS  __x_,R30
	STS  __x_+1,R31
;    1548 
;    1549 if((_x_>XMAX)||(_x_<-XMAX))_x_=0;
	LDS  R26,__x_
	LDS  R27,__x_+1
	LDI  R30,LOW(25)
	LDI  R31,HIGH(25)
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x184
	CPI  R26,LOW(0xFFE7)
	LDI  R30,HIGH(0xFFE7)
	CPC  R27,R30
	BRGE _0x183
_0x184:
	LDI  R30,0
	STS  __x_,R30
	STS  __x_+1,R30
;    1550 
;    1551 if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;
_0x183:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	MOV  R26,R30
	CPI  R26,0
	BRLO _0x187
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	MOV  R26,R30
	LDI  R30,LOW(3)
	CP   R30,R26
	BRSH _0x186
_0x187:
	LDI  R30,LOW(3)
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMWRB
;    1552 
;    1553 #asm("sei")
_0x186:
	sei
;    1554 granee(&K[0,1],420,1100);
	__POINTW1MN _K,2
	CALL SUBOPT_0x1A
;    1555 
;    1556 #ifdef _220_
;    1557 granee(&K[1,1],4500,5500);
;    1558 granee(&K[2,1],4500,5500);
;    1559 #else
;    1560 granee(&K[1,1],1360,1700);
	__POINTW1MN _K,6
	CALL SUBOPT_0x1B
;    1561 granee(&K[2,1],1360,1700);
	__POINTW1MN _K,10
	CALL SUBOPT_0x1B
;    1562 #endif									
;    1563 
;    1564 //granee(&K[1,1],1510,1850);
;    1565 //granee(&K[2,1],1510,1850);
;    1566 DDRD.2=1;
	SBI  0xA,2
;    1567 PORTD.2=0;
	CBI  0xB,2
;    1568 delay_ms(100);
	CALL SUBOPT_0xF
;    1569 PORTD.2=1;
	SBI  0xB,2
;    1570 can_init1();
	CALL _can_init1
;    1571 
;    1572 while (1)
_0x189:
;    1573 	{
;    1574 	if(bIN1) 
	LDS  R30,_bIN1
	CPI  R30,0
	BREQ _0x18C
;    1575 		{
;    1576 		bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
;    1577 	
;    1578 		can_in_an1();
	CALL _can_in_an1
;    1579 		} 
;    1580 			
;    1581 /*	if(b100Hz)
;    1582 		{
;    1583 		b100Hz=0;
;    1584 		}*/   
;    1585 	if(b33Hz)
_0x18C:
	SBIS 0x1E,2
	RJMP _0x18D
;    1586 		{
;    1587 		b33Hz=0;
	CBI  0x1E,2
;    1588           adc_hndl();
	CALL _adc_hndl
;    1589 		}   		
;    1590 	if(b10Hz)
_0x18D:
	SBIS 0x1E,3
	RJMP _0x18E
;    1591 		{
;    1592 		b10Hz=0;
	CBI  0x1E,3
;    1593           matemat();
	CALL _matemat
;    1594 	    	led_drv(); 
	CALL _led_drv
;    1595 	     link_drv();
	CALL _link_drv
;    1596 	     pwr_hndl();
	CALL _pwr_hndl
;    1597 	     JP_drv();
	CALL _JP_drv
;    1598 	     flags_drv();
	CALL _flags_drv
;    1599 		}
;    1600 	if(b5Hz)
_0x18E:
	SBIS 0x1E,4
	RJMP _0x18F
;    1601 		{
;    1602 		b5Hz=0;
	CBI  0x1E,4
;    1603  	     pwr_drv();
	CALL _pwr_drv
;    1604  		led_hndl();
	CALL _led_hndl
;    1605 		} 
;    1606     	if(b1Hz)
_0x18F:
	SBIS 0x1E,5
	RJMP _0x190
;    1607 		{
;    1608 		b1Hz=0;
	CBI  0x1E,5
;    1609 		temper_drv();
	CALL _temper_drv
;    1610 		u_drv();
	CALL _u_drv
;    1611           x_drv();
	CALL _x_drv
;    1612           if(main_cnt<1000)main_cnt++;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0x191
	LDS  R30,_main_cnt
	LDS  R31,_main_cnt+1
	ADIW R30,1
	STS  _main_cnt,R30
	STS  _main_cnt+1,R31
;    1613   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
_0x191:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ _0x193
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x192
_0x193:
	CALL _apv_hndl
;    1614   		
;    1615   		can_error_cnt++;
_0x192:
	LDS  R30,_can_error_cnt
	SUBI R30,-LOW(1)
	STS  _can_error_cnt,R30
;    1616   		if(can_error_cnt>=10)
	LDS  R26,_can_error_cnt
	CPI  R26,LOW(0xA)
	BRLO _0x195
;    1617   			{
;    1618   			can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
;    1619   			DDRD.2=1;
	SBI  0xA,2
;    1620 			PORTD.2=0;
	CBI  0xB,2
;    1621 			delay_ms(100);
	CALL SUBOPT_0xF
;    1622 			PORTD.2=1;
	SBI  0xB,2
;    1623 			
;    1624 			can_init1();
	CALL _can_init1
;    1625   			}
;    1626   		//can_transmit1(adr,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),*(((char*)&/*plazma_int[1]*/Ui)+1));
;    1627 		//can_transmit1(adr,PUTTM2,T,0,flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+1));
;    1628 
;    1629  		}
_0x195:
;    1630      #asm("wdr")	
_0x190:
	wdr
;    1631 	}
	RJMP _0x189
;    1632 }
_0x196:
	RJMP _0x196
_getchar:
     lds  r30,ucsr0a
     sbrs r30,rxc
     rjmp _getchar
     lds  r30,udr0
	RET
_putchar:
     lds  r30,ucsr0a
     sbrs r30,udre
     rjmp _putchar
     ld   r30,y
     sts  udr0,r30
	ADIW R28,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x0:
	IN   R30,0x4
	ORI  R30,LOW(0x2C)
	OUT  0x4,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1:
	ST   -Y,R30
	CALL _spi
	LDD  R30,Y+1
	ST   -Y,R30
	JMP  _spi

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2:
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _spi
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3:
	ST   -Y,R30
	CALL _spi
	LDD  R30,Y+2
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4:
	LD   R30,Y
	ST   -Y,R30
	JMP  _spi

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5:
	LDS  R26,_can_buff_wr_ptr
	LDI  R30,LOW(3)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6:
	ST   -Y,R30
	LDI  R30,LOW(224)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7:
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x8:
	ST   -Y,R30
	LDI  R30,LOW(32)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x9:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0xA:
	ST   -Y,R30
	LDI  R30,LOW(255)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xB:
	ST   -Y,R30
	LDI  R30,LOW(192)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0xC:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xD:
	ST   -Y,R30
	LDI  R30,LOW(49)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE:
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0xF:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _spi_bit_modify

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x11:
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x12:
	ST   -Y,R30
	LDI  R30,LOW(8)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES
SUBOPT_0x13:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOV  R30,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES
SUBOPT_0x14:
	MOVW R26,R30
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x15:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x16:
	LDI  R30,LOW(0)
	STS  _link_cnt,R30
	LDI  R30,LOW(85)
	STS  _link,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17:
	LDS  R30,_rotor_int
	LDS  R31,_rotor_int+1
	ADIW R30,1
	STS  _rotor_int,R30
	STS  _rotor_int+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x18:
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x19:
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(420)
	LDI  R31,HIGH(420)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1100)
	LDI  R31,HIGH(1100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x1B:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1360)
	LDI  R31,HIGH(1360)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1700)
	LDI  R31,HIGH(1700)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x1C:
	LDS  R30,_flags
	ANDI R30,LOW(0xE1)
	STS  _flags,R30
	LDI  R30,0
	STS  _tsign_cnt,R30
	STS  _tsign_cnt+1,R30
	LDI  R30,0
	STS  _tmax_cnt,R30
	STS  _tmax_cnt+1,R30
	LDI  R30,0
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
	LDI  R30,0
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1D:
	MOVW R26,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1E:
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1F:
	STS  0x7C,R30
	LDI  R30,LOW(166)
	STS  0x7A,R30
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x20:
	LDS  R30,120
	LDS  R31,120+1
	ST   -Y,R31
	ST   -Y,R30
	JMP  _adr_gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x21:
	LDS  R30,120
	LDS  R31,120+1
	MOVW R26,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL __DIVW21U
	__PUTW1R 16,17
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x22:
	LD   R30,X
	SUBI R30,LOW(1)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x23:
	LDI  R30,LOW(0)
	STS  _cnt_adc_ch_2_delta,R30
	LDI  R30,LOW(30)
	STS  _led_drv_cnt,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x24:
	SBIW R30,1
	LDS  R26,_T
	LDS  R27,_T+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x25:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x26:
	LDS  R30,_umax_cnt
	LDS  R31,_umax_cnt+1
	ADIW R30,1
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x27:
	LDI  R30,LOW(_umax_cnt)
	LDI  R31,HIGH(_umax_cnt)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _gran
	LDS  R26,_umax_cnt
	LDS  R27,_umax_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x28:
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x29:
	LDS  R30,_umin_cnt
	LDS  R31,_umin_cnt+1
	ADIW R30,1
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2A:
	LDI  R30,LOW(_umin_cnt)
	LDI  R31,HIGH(_umin_cnt)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _gran
	LDS  R26,_umin_cnt
	LDS  R27,_umin_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2B:
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x2C:
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2D:
	__GETD1N 0x0
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	__GETD1N 0x3030303
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x2E:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	__GETD1N 0xFFFFFFFF
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x2F:
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x30:
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x31:
	__GETD1N 0x10001
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	__GETD1N 0x0
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x32:
	__GETD1N 0x90009
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	__GETD1N 0x0
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x33:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	__GETD1N 0x0
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x34:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x35:
	LDS  R30,_adc_ch
	LDI  R26,LOW(_adc_buff)
	LDI  R27,HIGH(_adc_buff)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x36:
	LDS  R30,_adc_ch
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x37:
	CALL __EEPROMRDW
	__GETD2S 0
	CALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x38:
	__PUTD1S 0
	__GETD2S 0
	CALL __CPD20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x39:
	CALL __MULD12
	__PUTD1S 0
	__GETD2S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3A:
	CALL __DIVD21
	__PUTD1S 0
	LD   R30,Y
	LDD  R31,Y+1
	RET

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

_spi:
	ld   r30,y+
	out  spdr,r30
__spi0:
	in   r30,spsr
	sbrs r30,7
	rjmp __spi0
	in   r30,spdr
	ret

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__ANEGD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRD1:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	RET

__LSRW4:
	LSR  R31
	ROR  R30
__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__CWD1:
	LDI  R22,0
	LDI  R23,0
	SBRS R31,7
	RET
	SER  R22
	SER  R23
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULD12:
	RCALL __CHKSIGND
	RCALL __MULD12U
	BRTC __MULD121
	RCALL __ANEGD1
__MULD121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R19
	CLR  R20
	LDI  R21,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R19
	ROL  R20
	SUB  R0,R30
	SBC  R1,R31
	SBC  R19,R22
	SBC  R20,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R19,R22
	ADC  R20,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R21
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOV  R24,R19
	MOV  R25,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIC EECR,EEWE
	RJMP __EEPROMWRB
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__CPD20:
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

