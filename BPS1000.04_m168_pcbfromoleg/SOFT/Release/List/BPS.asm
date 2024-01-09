
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega168
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega168
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
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

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

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

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
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

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
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

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
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

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
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

	.MACRO __PUTBSR
	STD  Y+@1,R@0
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
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
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

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
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

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
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
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
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

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
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
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _t0_cnt0=R3
	.DEF _t0_cnt1=R2
	.DEF _t0_cnt2=R5
	.DEF _t0_cnt3=R4
	.DEF _t0_cnt4=R7
	.DEF _cnt_ind=R6
	.DEF _adc_cnt0=R9
	.DEF _adc_cnt1=R8
	.DEF _lcd_flash0=R11
	.DEF _lcd_flashx0=R10
	.DEF _lcd_flashy0=R13
	.DEF _volum=R12

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0

_0x3:
	.DB  0x0,0x0,0x48,0x0,0x7D,0x0,0xB1,0x0
	.DB  0xD9,0x0,0xFE,0x0,0x1E,0x1,0x3E,0x1
	.DB  0x5A,0x1,0x74,0x1,0x90,0x1,0xAB,0x1
	.DB  0xC5,0x1,0xDE,0x1,0xF6,0x1,0xD,0x2
_0x4:
	.DB  0x50,0x55,0x55,0x55
_0x5:
	.DB  0xAA,0xAA,0xAA,0xAA
_0x6:
	.DB  0x1E
_0x7:
	.DB  0x32
_0x8:
	.DB  0x32
_0x9:
	.DB  0xD
_0x47:
	.DB  0x7B
_0x20003:
	.DB  0x15
_0x20004:
	.DB  0x9
_0x20005:
	.DB  0x9
_0x20006:
	.DB  0xE7,0x7
_0x20007:
	.DB  0x9
_0x20008:
	.DB  0x1A
_0x20A0060:
	.DB  0x1
_0x20A0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x0A
	.DW  __REG_VARS*2

	.DW  0x04
	.DW  _led_red
	.DW  _0x4*2

	.DW  0x04
	.DW  _led_green
	.DW  _0x5*2

	.DW  0x01
	.DW  _led_drv_cnt
	.DW  _0x6*2

	.DW  0x01
	.DW  _pwm_u
	.DW  _0x7*2

	.DW  0x01
	.DW  __x_
	.DW  _0x9*2

	.DW  0x01
	.DW  _rotor_int
	.DW  _0x47*2

	.DW  0x01
	.DW  _HARDVARE_VERSION
	.DW  _0x20003*2

	.DW  0x01
	.DW  _SOFT_VERSION
	.DW  _0x20004*2

	.DW  0x01
	.DW  _BUILD
	.DW  _0x20005*2

	.DW  0x02
	.DW  _BUILD_YEAR
	.DW  _0x20006*2

	.DW  0x01
	.DW  _BUILD_MONTH
	.DW  _0x20007*2

	.DW  0x01
	.DW  _BUILD_DAY
	.DW  _0x20008*2

	.DW  0x01
	.DW  __seed_G105
	.DW  _0x20A0060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

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
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
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
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x200

	.CSEG
;#define F_REF 8000000L
;#define F_COMP 10000L
;#include <Mega168.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.SET power_ctrl_reg=smcr
	#endif
;#include <delay.h>
;
;//#define KAN_XTAL	8
;#define KAN_XTAL	10
;//#define KAN_XTAL	20
;#include "cmd.c"
;//-----------------------------------------------
;// Символы передач
;#define REGU 0xf5
;#define REGI 0xf6
;#define GetTemp 0xfc
;#define TVOL0 0x75
;#define TVOL1 0x76
;#define TVOL2 0x77
;#define TTEMPER	0x7c
;#define CSTART  0x1a
;#define CMND	0x16
;#define Blok_flip	0x57
;#define END 	0x0A
;#define QWEST	0x25
;#define IM	0x52
;#define Add_kf 0x60
;#define Sub_kf 0x61
;#define ALRM_RES 0x63
;#define Zero_kf2 0x64
;#define MEM_KF 0x62
;#define MEM_KF1 0x26
;#define MEM_KF2 0x27
;#define BLKON 0x80
;#define BLKOFF 0x81
;//#define Put_reg 0x90
;#define GETID 0x90
;#define PUTID 0x91
;#define PUTTM1 0xDA
;#define PUTTM2 0xDB
;#define PUTTM3 0xDC
;#define PUTTM 0xDE
;#define PUTTM31 	0xDD
;#define PUTTM32 	0xD5
;#define GETTM 0xED
;#define GETTM1 	0xEb
;#define GETTM2	0xEc
;#define KLBR 0xEE
;#define XMAX 25
;
;#include <stdio.h>
;#include <math.h>
;
;#define ON 0x55
;#define OFF 0xaa
;
;//#define _220_
;#define _24_
;//#define _110_
;//#define _48/60_
;
;bit bJP; //джампер одет
;bit b100Hz;
;bit b33Hz;
;bit b10Hz;
;bit b5Hz;
;bit b1Hz;
;bit bFl_;
;bit bBL;
;
;char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4,cnt_ind,adc_cnt0,adc_cnt1;
;/*bit l_but;	//идет длинное нажатие на кнопку
;bit n_but=0;     //произошло нажатие
;bit speed;	//разрешение ускорения перебора
;bit bFl_;
;
;bit zero_on;
;bit bFr_ch=0;
;bit bR;
;bit bT1;
;
;enum char {iH,iT,iPrl,iK,iSet}ind;
;signed char sub_ind;
;unsigned int adc_bank[4][16],adc_bank_[4];
;bit bCh;*/
;
;signed int tabl[]={0/*0*/,72/*40*/,125/*80*/,177/*120*/,217/*160*/,254/*200*/,286/*240*/,318/*280*/,346/*320*/,372/*360* ...

	.DSEG
;
;eeprom int freq;
;eeprom char stereo,p_out;
;
;char lcd_flash0=0;
;char lcd_flashx0=0;
;char lcd_flashy0=0;
;//char lcd_flash1=0;
;//char lcd_flashx1=0;
;//char lcd_flashy1=0;
;unsigned char volum;
;eeprom unsigned char volum_ee;
;
;
;int vol_u,vol_i;
;
;unsigned int adc_buff[4][16],adc_buff_[4];
;char adc_cnt,adc_ch;
;
;eeprom signed int K[4][2];
;
;unsigned int I,Un,Ui,Udb;
;signed T;
;char flags=0; // состояние источника
;// 0 -  если одет джампер то 0, если нет то 1
;// 1 -  авария по Tmax (1-активн.);
;// 2 -  авария по Tsign (1-активн.);
;// 3 -  авария по Umax (1-активн.);
;// 4 -  авария по Umin (1-активн.);
;// 5 -  блокировка извне (1-активн.);
;// 6 -  блокировка извне защит(1-активн.);
;
;char flags_tu; // управляющее слово от хоста
;// 0 -  блокировка, если 1 то заблокировать
;// 1 -  блокировка извне защит(1-активн.);
;
;unsigned int  vol_u_temp,vol_i_temp=0;
;long led_red=0x55555550L,led_green=0xaaaaaaaaL;
;char link,link_cnt;
;char led_drv_cnt=30;
;eeprom signed int Umax,dU,tmax,tsign;
;signed tsign_cnt,tmax_cnt;
;unsigned int pwm_u=50,pwm_i=50;
;signed umax_cnt,umin_cnt;
;char flags_tu_cnt_on,flags_tu_cnt_off;
;char adr_new,adr_old,adr_temp,adr_cnt;
;eeprom char adr;
;char cnt_JP0,cnt_JP1;
;enum {jp0,jp1,jp2,jp3} jp_mode;
;int main_cnt1;
;signed _x_=13,_x__;
;int _x_cnt;
;eeprom signed _x_ee_;
;eeprom int U_AVT;
;eeprom char U_AVT_ON;
;
;int main_cnt;
;eeprom char TZAS;
;char plazma;
;int plazma_int[3];
;int adc_ch_2_max,adc_ch_2_min;
;char adc_ch_2_delta;
;char cnt_adc_ch_2_delta;
;char apv_cnt[3];
;int apv_cnt_;
;bit bAPV;
;char cnt_apv_off;
;
;eeprom char res_fl,res_fl_;
;bit bRES=0;
;bit bRES_=0;
;char res_fl_cnt;
;char off_bp_cnt;
;//eeprom char adr_ee;
;
;flash char CONST_ADR[]={0b00000111,0b00000111,0b00000111,0b00000010,0b00000011,0b00000001,0b00000000,0b00000111};
;
;char can_error_cnt;
;char link_cnt63;
;
;#include "can_slave.c"
;#define CS_DDR	DDRB.0
;#define CS	PORTB.0
;#define SPI_PORT_INIT  DDRB|=0b00101100;DDRB.4=0;
;//#define _220_
;//#define _24_
;#include "mcp2510.h"

	.CSEG
_mcp_reset:
; .FSTART _mcp_reset
	cli
	CALL SUBOPT_0x0
	SBI  0x5,0
	sei
	RET
; .FEND
_spi_read:
; .FSTART _spi_read
	ST   -Y,R26
	ST   -Y,R17
;	addr -> Y+1
;	temp -> R17
	cli
	CALL SUBOPT_0x0
	__DELAY_USB 27
	LDI  R26,LOW(3)
	CALL SUBOPT_0x1
	LDI  R26,LOW(85)
	CALL _spi
	MOV  R17,R30
	SBI  0x5,0
	sei
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,2
	RET
; .FEND
_spi_bit_modify:
; .FSTART _spi_bit_modify
	ST   -Y,R26
;	addr -> Y+2
;	mask -> Y+1
;	data -> Y+0
	cli
	CALL SUBOPT_0x0
	LDI  R26,LOW(5)
	CALL _spi
	LDD  R26,Y+2
	CALL SUBOPT_0x1
	LD   R26,Y
	CALL _spi
	SBI  0x5,0
	sei
	ADIW R28,3
	RET
; .FEND
_spi_write:
; .FSTART _spi_write
	ST   -Y,R26
	ST   -Y,R17
;	addr -> Y+2
;	in -> Y+1
;	temp -> R17
	cli
	CALL SUBOPT_0x0
	LDI  R26,LOW(2)
	CALL _spi
	LDD  R26,Y+2
	CALL SUBOPT_0x1
	SBI  0x5,0
	sei
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_spi_read_status:
; .FSTART _spi_read_status
	ST   -Y,R17
;	temp -> R17
	cli
	CALL SUBOPT_0x0
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	LDI  R26,LOW(160)
	CALL _spi
	LDI  R26,LOW(85)
	CALL _spi
	MOV  R17,R30
	SBI  0x5,0
	sei
	MOV  R30,R17
	LD   R17,Y+
	RET
; .FEND
;	in -> Y+0
_spi_rts:
; .FSTART _spi_rts
	ST   -Y,R26
;	in -> Y+0
	cli
	CALL SUBOPT_0x0
	LD   R30,Y
	CPI  R30,0
	BREQ PC+3
	JMP _0x40
	LDI  R30,LOW(129)
	ST   Y,R30
	RJMP _0x41
_0x40:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x42
	LDI  R30,LOW(130)
	ST   Y,R30
	RJMP _0x43
_0x42:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x44
	LDI  R30,LOW(132)
	ST   Y,R30
_0x44:
_0x43:
_0x41:
	LD   R26,Y
	CALL _spi
	SBI  0x5,0
	sei
	ADIW R28,1
	RET
; .FEND
;	in -> Y+1
;	temp -> R17
;	in -> Y+1
;	temp -> R17
;	in -> Y+1
;	temp -> R17
;	in -> Y+1
;	temp -> R17
;	sidh -> Y+7
;	sidl -> Y+6
;	eid8 -> Y+5
;	eid0 -> Y+4
;	temp -> Y+0
;#include "curr_version.h"
;
;extern flash char Table87[];
;extern flash char Table95[];
;extern void gran(signed int *adr, signed int min, signed int max);
;/*
;
;
;char cob1[10],cib1[20];
;
;char ch_cnt1;
;bit bch_1Hz1;
;bit bADRISON1,bADRISRQWST1;
;char random1[4];
;char tr_buff1[8];
;
;
;
;
;
;char bd1[25];
;*/
;//#define CNF1_init	0b00000100  //tq=500ns   //20MHz
;/*
;#define CNF1_init	0b11000000  //tq=500ns   //8MHz
;#define CNF2_init	0b11110001  //Ps1=7tq,Pr=2tq
;#define CNF3_init	0b00000010  //Ps2=6tq */
;
;#if(KAN_XTAL==8)
;#define CNF1_init	0b11000011  //tq=500ns   //8MHz
;#define CNF2_init	0b11111011  //Ps1=7tq,Pr=2tq
;#define CNF3_init	0b00000010  //Ps2=6tq
;#elif(KAN_XTAL==10)
;#define CNF1_init	0b11000011  //tq=500ns   //10MHz
;#define CNF2_init	0b11111110  //Ps1=7tq,Pr=2tq
;#define CNF3_init	0b00000011  //Ps2=6tq
;#elif(KAN_XTAL==20)
;#define CNF1_init	0b11000111  //tq=500ns   //20MHz
;#define CNF2_init	0b11111110  //Ps1=7tq,Pr=2tq
;#define CNF3_init	0b00000011  //Ps2=6tq
;#endif
;
;char can_st1,can_st_old1;
;char RXBUFF1[40],RXBUFF_1[40],TXBUFF1[40];
;char bR1,bIN1,bOUT11;
;char bR_cnt1,TX_len1;
;char cnt_rcpt1,cnt_trsmt1;
;char bOUT_free1;
;bit bOUT1;
;
;
;char can_out_buff[8][4];
;char can_buff_wr_ptr;
;char can_buff_rd_ptr;
;
;extern void granee(eeprom signed int *adr, signed int min, signed int max);
;signed rotor_int=123;

	.DSEG
;//-----------------------------------------------
;void can_transmit1(char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
; 0000 0081 {

	.CSEG
_can_transmit1:
; .FSTART _can_transmit1
;if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
	ST   -Y,R26
;	data0 -> Y+7
;	data1 -> Y+6
;	data2 -> Y+5
;	data3 -> Y+4
;	data4 -> Y+3
;	data5 -> Y+2
;	data6 -> Y+1
;	data7 -> Y+0
	LDS  R26,_can_buff_wr_ptr
	CPI  R26,0
	BRSH PC+3
	JMP _0x49
	CPI  R26,LOW(0x4)
	BRLO PC+3
	JMP _0x49
	RJMP _0x48
_0x49:
	LDI  R30,LOW(0)
	STS  _can_buff_wr_ptr,R30
;
;can_out_buff[0][can_buff_wr_ptr]=data0;
_0x48:
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	SUBI R30,LOW(-_can_out_buff)
	SBCI R31,HIGH(-_can_out_buff)
	LDD  R26,Y+7
	STD  Z+0,R26
;can_out_buff[1][can_buff_wr_ptr]=data1;
	__POINTW2MN _can_out_buff,4
	CALL SUBOPT_0x2
	LDD  R26,Y+6
	STD  Z+0,R26
;can_out_buff[2][can_buff_wr_ptr]=data2;
	__POINTW2MN _can_out_buff,8
	CALL SUBOPT_0x2
	LDD  R26,Y+5
	STD  Z+0,R26
;can_out_buff[3][can_buff_wr_ptr]=data3;
	__POINTW2MN _can_out_buff,12
	CALL SUBOPT_0x2
	LDD  R26,Y+4
	STD  Z+0,R26
;can_out_buff[4][can_buff_wr_ptr]=data4;
	__POINTW2MN _can_out_buff,16
	CALL SUBOPT_0x2
	LDD  R26,Y+3
	STD  Z+0,R26
;can_out_buff[5][can_buff_wr_ptr]=data5;
	__POINTW2MN _can_out_buff,20
	CALL SUBOPT_0x2
	LDD  R26,Y+2
	STD  Z+0,R26
;can_out_buff[6][can_buff_wr_ptr]=data6;
	__POINTW2MN _can_out_buff,24
	CALL SUBOPT_0x2
	LDD  R26,Y+1
	STD  Z+0,R26
;can_out_buff[7][can_buff_wr_ptr]=data7;
	__POINTW2MN _can_out_buff,28
	CALL SUBOPT_0x2
	LD   R26,Y
	STD  Z+0,R26
;
;can_buff_wr_ptr++;
	LDS  R30,_can_buff_wr_ptr
	SUBI R30,-LOW(1)
	STS  _can_buff_wr_ptr,R30
;if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
	LDS  R26,_can_buff_wr_ptr
	CPI  R26,LOW(0x4)
	BRSH PC+3
	JMP _0x4B
	LDI  R30,LOW(0)
	STS  _can_buff_wr_ptr,R30
;}
_0x4B:
	ADIW R28,8
	RET
; .FEND
;//-----------------------------------------------
;void can_init1(void)
;{
_can_init1:
; .FSTART _can_init1
;char spi_temp;
;
;mcp_reset();
	ST   -Y,R17
;	spi_temp -> R17
	CALL _mcp_reset
;spi_temp=spi_read(CANSTAT);
	LDI  R26,LOW(14)
	CALL _spi_read
	MOV  R17,R30
;if((spi_temp&0xe0)!=0x80)
	ANDI R30,LOW(0xE0)
	CPI  R30,LOW(0x80)
	BRNE PC+3
	JMP _0x4C
;    {
;    spi_bit_modify(CANCTRL,0xe0,0x80);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(224)
	ST   -Y,R30
	LDI  R26,LOW(128)
	CALL _spi_bit_modify
;    }
;delay_us(10);
_0x4C:
	__DELAY_USB 27
;spi_write(CNF1,CNF1_init);
	LDI  R30,LOW(42)
	ST   -Y,R30
	LDI  R26,LOW(195)
	CALL _spi_write
;spi_write(CNF2,CNF2_init);
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R26,LOW(254)
	CALL _spi_write
;spi_write(CNF3,CNF3_init);
	LDI  R30,LOW(40)
	ST   -Y,R30
	LDI  R26,LOW(3)
	CALL _spi_write
;
;spi_write(RXB0CTRL,0b00100000);
	LDI  R30,LOW(96)
	ST   -Y,R30
	LDI  R26,LOW(32)
	CALL _spi_write
;spi_write(RXB1CTRL,0b00100000);
	LDI  R30,LOW(112)
	ST   -Y,R30
	LDI  R26,LOW(32)
	CALL _spi_write
;
;delay_ms(10);
	CALL SUBOPT_0x3
;
;spi_write(RXM0SIDH, 0xFF);
	LDI  R30,LOW(32)
	CALL SUBOPT_0x4
;spi_write(RXM0SIDL, 0xFF);
	LDI  R30,LOW(33)
	CALL SUBOPT_0x4
;spi_write(RXF0SIDH, 0xFF);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x4
;spi_write(RXF0SIDL, 0xFF);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x4
;spi_write(RXF1SIDH, 0xFF);
	LDI  R30,LOW(4)
	CALL SUBOPT_0x4
;spi_write(RXF1SIDL, 0xFF);
	LDI  R30,LOW(5)
	CALL SUBOPT_0x4
;
;spi_write(RXM1SIDH, 0xff);
	LDI  R30,LOW(36)
	CALL SUBOPT_0x4
;spi_write(RXM1SIDL, 0xe0);
	LDI  R30,LOW(37)
	ST   -Y,R30
	LDI  R26,LOW(224)
	CALL _spi_write
;
;spi_write(RXF2SIDH, 0x13);
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R26,LOW(19)
	CALL _spi_write
;spi_write(RXF2SIDL, 0xc0);
	LDI  R30,LOW(9)
	CALL SUBOPT_0x5
;
;spi_write(RXF3SIDH, 0x00);
	LDI  R30,LOW(16)
	CALL SUBOPT_0x6
;spi_write(RXF3SIDL, 0x00);
	LDI  R30,LOW(17)
	CALL SUBOPT_0x6
;
;spi_write(RXF4SIDH, 0x00);
	LDI  R30,LOW(20)
	CALL SUBOPT_0x6
;spi_write(RXF4SIDL, 0x00);
	LDI  R30,LOW(21)
	CALL SUBOPT_0x6
;
;spi_write(RXF5SIDH, 0x00);
	LDI  R30,LOW(24)
	CALL SUBOPT_0x6
;spi_write(RXF5SIDL, 0x00);
	LDI  R30,LOW(25)
	CALL SUBOPT_0x6
;
;spi_write(TXB2SIDH, 0x31);
	LDI  R30,LOW(81)
	CALL SUBOPT_0x7
;spi_write(TXB2SIDL, 0xc0);
	LDI  R30,LOW(82)
	CALL SUBOPT_0x5
;
;spi_write(TXB1SIDH, 0x31);
	LDI  R30,LOW(65)
	CALL SUBOPT_0x7
;spi_write(TXB1SIDL, 0xc0);
	LDI  R30,LOW(66)
	CALL SUBOPT_0x5
;
;spi_write(TXB0SIDH, 0x31);
	LDI  R30,LOW(49)
	CALL SUBOPT_0x7
;spi_write(TXB0SIDL, 0xc0);
	LDI  R30,LOW(50)
	CALL SUBOPT_0x5
;
;
;
;spi_bit_modify(CANCTRL,0xe7,0b00000101);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(231)
	ST   -Y,R30
	LDI  R26,LOW(5)
	CALL _spi_bit_modify
;
;spi_write(CANINTE,0b00000110);
	LDI  R30,LOW(43)
	ST   -Y,R30
	LDI  R26,LOW(6)
	CALL _spi_write
;delay_ms(100);
	CALL SUBOPT_0x8
;spi_write(BFPCTRL,0b00000000);
	LDI  R30,LOW(12)
	CALL SUBOPT_0x6
;
;}
	LD   R17,Y+
	RET
; .FEND
;
;
;
;//-----------------------------------------------
;void can_hndl1(void)
;{
_can_hndl1:
; .FSTART _can_hndl1
;unsigned char temp,j,temp_index,c_temp;
;static char ch_cnt;
;#asm("cli")
	CALL __SAVELOCR4
;	temp -> R17
;	j -> R16
;	temp_index -> R19
;	c_temp -> R18
	cli
;
;can_st1=spi_read_status();
	CALL _spi_read_status
	STS  _can_st1,R30
;can_st_old1|=can_st1;
	LDS  R26,_can_st_old1
	OR   R30,R26
	STS  _can_st_old1,R30
;
;if(can_st1&0b00000010)
	LDS  R30,_can_st1
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x4D
;    {
;
;    for(j=0;j<8;j++)
	LDI  R16,LOW(0)
_0x4F:
	CPI  R16,8
	BRLO PC+3
	JMP _0x50
;        {
;        RXBUFF1[j]=spi_read(RXB1D0+j);
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_RXBUFF1)
	SBCI R31,HIGH(-_RXBUFF1)
	PUSH R31
	PUSH R30
	MOV  R26,R16
	SUBI R26,-LOW(118)
	CALL _spi_read
	POP  R26
	POP  R27
	ST   X,R30
;        }
_0x4E:
	SUBI R16,-1
	RJMP _0x4F
_0x50:
;
;    spi_bit_modify(CANINTF,0b00000010,0x00);
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _spi_bit_modify
;     bIN1=1;
	LDI  R30,LOW(1)
	STS  _bIN1,R30
;    }
;
;
;else if(/*(can_st1&0b10101000)&&*/(!(can_st1&0b01010100)))
	RJMP _0x51
_0x4D:
	LDS  R30,_can_st1
	ANDI R30,LOW(0x54)
	BREQ PC+3
	JMP _0x52
;    {
;    char n;
;     spi_bit_modify(CANINTF,0b00011100,0x00);
	SBIW R28,1
;	n -> Y+0
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(28)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _spi_bit_modify
;
;     if(can_buff_rd_ptr!=can_buff_wr_ptr)
	LDS  R30,_can_buff_wr_ptr
	LDS  R26,_can_buff_rd_ptr
	CP   R30,R26
	BRNE PC+3
	JMP _0x53
;         {
;             for(n=0;n<8;n++)
	LDI  R30,LOW(0)
	ST   Y,R30
_0x55:
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRLO PC+3
	JMP _0x56
;            {
;            spi_write(TXB0D0+n,can_out_buff[n][can_buff_rd_ptr]);
	LD   R30,Y
	SUBI R30,-LOW(54)
	ST   -Y,R30
	LDD  R30,Y+1
	LDI  R26,LOW(_can_out_buff)
	LDI  R27,HIGH(_can_out_buff)
	LDI  R31,0
	CALL __LSLW2
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_can_buff_rd_ptr
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CALL _spi_write
;            }
_0x54:
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RJMP _0x55
_0x56:
;            spi_write(TXB0DLC,8);
	LDI  R30,LOW(53)
	ST   -Y,R30
	LDI  R26,LOW(8)
	CALL _spi_write
;            spi_rts(0);
	LDI  R26,LOW(0)
	CALL _spi_rts
;
;            can_buff_rd_ptr++;
	LDS  R30,_can_buff_rd_ptr
	SUBI R30,-LOW(1)
	STS  _can_buff_rd_ptr,R30
;            if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
	LDS  R26,_can_buff_rd_ptr
	CPI  R26,LOW(0x4)
	BRSH PC+3
	JMP _0x57
	LDI  R30,LOW(0)
	STS  _can_buff_rd_ptr,R30
;            }
_0x57:
;     }
_0x53:
	ADIW R28,1
;
;#asm("sei")
_0x52:
_0x51:
	sei
;}
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;
;
;
;
;//-----------------------------------------------
;void can_in_an1(void)
;{
_can_in_an1:
; .FSTART _can_in_an1
;char temp,i;
;signed temp_S;
;int tempI;
;
;
;
;if((RXBUFF1[0]==1)&&(RXBUFF1[1]==2)&&(RXBUFF1[2]==3)&&(RXBUFF1[3]==4)&&(RXBUFF1[4]==5)&&(RXBUFF1[5]==6)&&(RXBUFF1[6]==7) ...
	CALL __SAVELOCR6
;	temp -> R17
;	i -> R16
;	temp_S -> R18,R19
;	tempI -> R20,R21
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x4)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x5)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x6)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,6
	CPI  R26,LOW(0x7)
	BREQ PC+3
	JMP _0x59
	__GETB2MN _RXBUFF1,7
	CPI  R26,LOW(0x8)
	BREQ PC+3
	JMP _0x59
	RJMP _0x5A
_0x59:
	RJMP _0x58
_0x5A:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R30,LOW(6)
	ST   -Y,R30
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(8)
	CALL _can_transmit1
;
;
;if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&((RXBUFF1[2]==GETTM) || (RXBUFF1[2]==GETTM1) || (RXBUFF1[2]==GETTM2)))
_0x58:
	CALL SUBOPT_0x9
	LDS  R26,_RXBUFF1
	CP   R30,R26
	BREQ PC+3
	JMP _0x5C
	CALL SUBOPT_0x9
	__GETB2MN _RXBUFF1,1
	CP   R30,R26
	BREQ PC+3
	JMP _0x5C
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xED)
	BRNE PC+3
	JMP _0x5D
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEB)
	BRNE PC+3
	JMP _0x5D
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEC)
	BRNE PC+3
	JMP _0x5D
	RJMP _0x5C
_0x5D:
	RJMP _0x5F
_0x5C:
	RJMP _0x5B
_0x5F:
;	{
;
;	can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
;
;
; 	flags_tu=RXBUFF1[3];
	__GETB1MN _RXBUFF1,3
	STS  _flags_tu,R30
; 	if(flags_tu&0b00000001)
	ANDI R30,LOW(0x1)
	BRNE PC+3
	JMP _0x60
; 		{
; 		if(flags_tu_cnt_off<4)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRLO PC+3
	JMP _0x61
; 			{
; 			flags_tu_cnt_off++;
	LDS  R30,_flags_tu_cnt_off
	SUBI R30,-LOW(1)
	STS  _flags_tu_cnt_off,R30
; 			if(flags_tu_cnt_off>=4)flags|=0b00100000;
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRSH PC+3
	JMP _0x62
	LDS  R30,_flags
	ORI  R30,0x20
	STS  _flags,R30
; 			}
_0x62:
; 		else flags_tu_cnt_off=4;
	RJMP _0x63
_0x61:
	LDI  R30,LOW(4)
	STS  _flags_tu_cnt_off,R30
; 		}
_0x63:
; 	else
	RJMP _0x64
_0x60:
; 		{
; 		if(flags_tu_cnt_off)
	LDS  R30,_flags_tu_cnt_off
	CPI  R30,0
	BRNE PC+3
	JMP _0x65
; 			{
; 			flags_tu_cnt_off--;
	SUBI R30,LOW(1)
	STS  _flags_tu_cnt_off,R30
; 			if(flags_tu_cnt_off<=0)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,0
	BREQ PC+3
	JMP _0x66
; 				{
; 				flags&=0b11011111;
	LDS  R30,_flags
	ANDI R30,0xDF
	STS  _flags,R30
; 				off_bp_cnt=5*TZAS;
	CALL SUBOPT_0xA
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	STS  _off_bp_cnt,R30
; 				}
; 			}
_0x66:
; 		else flags_tu_cnt_off=0;
	RJMP _0x67
_0x65:
	LDI  R30,LOW(0)
	STS  _flags_tu_cnt_off,R30
; 		}
_0x67:
_0x64:
;
; 	if(flags_tu&0b00000010) flags|=0b01000000;
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x68
	LDS  R30,_flags
	ORI  R30,0x40
	STS  _flags,R30
; 	else flags&=0b10111111;
	RJMP _0x69
_0x68:
	LDS  R30,_flags
	ANDI R30,0xBF
	STS  _flags,R30
;
; 	vol_u_temp=RXBUFF1[4]+RXBUFF1[5]*256;
_0x69:
	CALL SUBOPT_0xB
	__GETB2MN _RXBUFF1,4
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _vol_u_temp,R30
	STS  _vol_u_temp+1,R31
; 	vol_i_temp=RXBUFF1[6]+RXBUFF1[7]*256;
	__GETB2MN _RXBUFF1,7
	CALL SUBOPT_0xC
	__GETB2MN _RXBUFF1,6
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _vol_i_temp,R30
	STS  _vol_i_temp+1,R31
;
; 	//I=1234;
;    //	Un=6543;
; 	//Ui=6789;
; 	//T=246;
; 	//flags=0x55;
; 	//_x_=33;
; 	//rotor_int=1000;
; 	rotor_int=flags_tu+(((int)flags)<<8);
	LDS  R31,_flags
	LDI  R30,LOW(0)
	LDS  R26,_flags_tu
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _rotor_int,R30
	STS  _rotor_int+1,R31
;	can_transmit1(adr,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui),* ...
	CALL SUBOPT_0x9
	ST   -Y,R30
	LDI  R30,LOW(218)
	CALL SUBOPT_0xD
;	can_transmit1(adr,PUTTM2,(char)T,0,flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int* ...
	ST   -Y,R30
	LDI  R30,LOW(219)
	CALL SUBOPT_0xE
;	if(RXBUFF1[2]==GETTM)	can_transmit1(adr,PUTTM3,/**(((char*)&debug_info_to_uku[0])+1)*/0,/**((char*)&debug_info_to_uku[0 ...
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xED)
	BREQ PC+3
	JMP _0x6A
	CALL SUBOPT_0x9
	ST   -Y,R30
	LDI  R30,LOW(220)
	CALL SUBOPT_0xF
	LDI  R30,LOW(0)
	CALL SUBOPT_0xF
	LDI  R26,LOW(0)
	CALL _can_transmit1
;	if(RXBUFF1[2]==GETTM1)	can_transmit1(adr,PUTTM31,*(((char*)&HARDVARE_VERSION)+1),*((char*)&HARDVARE_VERSION),*(((char*) ...
_0x6A:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEB)
	BREQ PC+3
	JMP _0x6B
	CALL SUBOPT_0x9
	ST   -Y,R30
	LDI  R30,LOW(221)
	ST   -Y,R30
	__GETB1MN _HARDVARE_VERSION,1
	ST   -Y,R30
	LDS  R30,_HARDVARE_VERSION
	ST   -Y,R30
	__GETB1MN _SOFT_VERSION,1
	ST   -Y,R30
	LDS  R30,_SOFT_VERSION
	ST   -Y,R30
	__GETB1MN _BUILD,1
	ST   -Y,R30
	LDS  R26,_BUILD
	CALL _can_transmit1
;	if(RXBUFF1[2]==GETTM2)	can_transmit1(adr,PUTTM32,*(((char*)&BUILD_YEAR)+1),*((char*)&BUILD_YEAR),*(((char*)&BUILD_MONTH ...
_0x6B:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEC)
	BREQ PC+3
	JMP _0x6C
	CALL SUBOPT_0x9
	ST   -Y,R30
	LDI  R30,LOW(213)
	ST   -Y,R30
	__GETB1MN _BUILD_YEAR,1
	ST   -Y,R30
	LDS  R30,_BUILD_YEAR
	ST   -Y,R30
	__GETB1MN _BUILD_MONTH,1
	ST   -Y,R30
	LDS  R30,_BUILD_MONTH
	ST   -Y,R30
	__GETB1MN _BUILD_DAY,1
	ST   -Y,R30
	LDS  R26,_BUILD_DAY
	CALL _can_transmit1
;
;
;     link_cnt=0;
_0x6C:
	CALL SUBOPT_0x10
;     link=ON;
;
;     if(flags_tu&0b10000000)
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE PC+3
	JMP _0x6D
;     	{
;     	if(!res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ PC+3
	JMP _0x6E
;     		{
;     		res_fl=1;
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	LDI  R30,LOW(1)
	CALL __EEPROMWRB
;     		bRES=1;
	IN   R30,0x2A
	SBR  R30,2
	OUT  0x2A,R30
;     		res_fl_cnt=0;
	LDI  R30,LOW(0)
	STS  _res_fl_cnt,R30
;     		}
;     	}
_0x6E:
;     else
	RJMP _0x6F
_0x6D:
;     	{
;     	if(main_cnt>20)
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	SBIW R26,21
	BRGE PC+3
	JMP _0x70
;     		{
;    			if(res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE PC+3
	JMP _0x71
;     			{
;     			res_fl=0;
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;     			}
;     		}
_0x71:
;     	}
_0x70:
_0x6F:
;
;      if(res_fl_)
	CALL SUBOPT_0x11
	BRNE PC+3
	JMP _0x72
;      	{
;      	res_fl_=0;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;      	}
;	}
_0x72:
;else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==KLBR)&&(RXBUFF1[3]==RXBUFF1[4]))
	RJMP _0x73
_0x5B:
	CALL SUBOPT_0x9
	LDS  R26,_RXBUFF1
	CP   R30,R26
	BREQ PC+3
	JMP _0x75
	CALL SUBOPT_0x9
	__GETB2MN _RXBUFF1,1
	CP   R30,R26
	BREQ PC+3
	JMP _0x75
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEE)
	BREQ PC+3
	JMP _0x75
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BREQ PC+3
	JMP _0x75
	RJMP _0x76
_0x75:
	RJMP _0x74
_0x76:
;    {
;    rotor_int++;
	CALL SUBOPT_0x12
;    if((RXBUFF1[3]&0xf0)==0x20)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x20)
	BREQ PC+3
	JMP _0x77
;        {
;        if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x78
;            {
;            K[0][0]=adc_buff_[0];
	CALL SUBOPT_0x13
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x79
_0x78:
	CALL SUBOPT_0x14
	BREQ PC+3
	JMP _0x7A
;            {
;            K[0][1]++;
	CALL SUBOPT_0x15
	ADIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x7B
_0x7A:
	CALL SUBOPT_0x16
	BREQ PC+3
	JMP _0x7C
;            {
;            K[0][1]+=10;
	CALL SUBOPT_0x15
	ADIW R30,10
	__PUTW1EN _K,2
;            }
;        else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x7D
_0x7C:
	CALL SUBOPT_0x17
	BREQ PC+3
	JMP _0x7E
;            {
;            K[0][1]--;
	CALL SUBOPT_0x15
	SBIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x7F
_0x7E:
	CALL SUBOPT_0x18
	BREQ PC+3
	JMP _0x80
;            {
;            K[0][1]-=10;
	CALL SUBOPT_0x15
	SBIW R30,10
	__PUTW1EN _K,2
;            }
;        granee(&K[0][1],300,5000);
_0x80:
_0x7F:
_0x7D:
_0x7B:
_0x79:
	__POINTW1MN _K,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5000)
	LDI  R27,HIGH(5000)
	CALL _granee
;        }
;    else if((RXBUFF1[3]&0xf0)==0x10)
	RJMP _0x81
_0x77:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x10)
	BREQ PC+3
	JMP _0x82
;        {
;        /*if((RXBUFF1[3]&0x0f)==0x01)
;            {
;            K[1][0]=adc_buff_[1];
;            }
;        else*/ if((RXBUFF1[3]&0x0f)==0x02)
	CALL SUBOPT_0x14
	BREQ PC+3
	JMP _0x83
;            {
;            K[1][1]++;
	CALL SUBOPT_0x19
	ADIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x84
_0x83:
	CALL SUBOPT_0x16
	BREQ PC+3
	JMP _0x85
;            {
;            K[1][1]+=10;
	CALL SUBOPT_0x19
	ADIW R30,10
	__PUTW1EN _K,6
;            }
;        else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x86
_0x85:
	CALL SUBOPT_0x17
	BREQ PC+3
	JMP _0x87
;            {
;            K[1][1]--;
	CALL SUBOPT_0x19
	SBIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x88
_0x87:
	CALL SUBOPT_0x18
	BREQ PC+3
	JMP _0x89
;            {
;            K[1][1]-=10;
	CALL SUBOPT_0x19
	SBIW R30,10
	__PUTW1EN _K,6
;            }
;        /*#ifdef _220_
;        granee(&K[1][1],4500,5500);
;        #else
;        granee(&K[1][1],1360,1700);
;        #endif*/
;        }
_0x89:
_0x88:
_0x86:
_0x84:
;
;    else if((RXBUFF1[3]&0xf0)==0x00)
	RJMP _0x8A
_0x82:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	BREQ PC+3
	JMP _0x8B
;        {
;        if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x8C
;            {
;            K[2][0]=adc_buff_[0];
	__POINTW2MN _K,8
	CALL SUBOPT_0x13
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x8D
_0x8C:
	CALL SUBOPT_0x14
	BREQ PC+3
	JMP _0x8E
;            {
;            K[2][1]++;
	CALL SUBOPT_0x1A
	ADIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x8F
_0x8E:
	CALL SUBOPT_0x16
	BREQ PC+3
	JMP _0x90
;            {
;            K[2][1]+=10;
	CALL SUBOPT_0x1A
	ADIW R30,10
	__PUTW1EN _K,10
;            }
;        else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x91
_0x90:
	CALL SUBOPT_0x17
	BREQ PC+3
	JMP _0x92
;            {
;            K[2][1]--;
	CALL SUBOPT_0x1A
	SBIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x93
_0x92:
	CALL SUBOPT_0x18
	BREQ PC+3
	JMP _0x94
;            {
;            K[2][1]-=10;
	CALL SUBOPT_0x1A
	SBIW R30,10
	__PUTW1EN _K,10
;            }
;        /*#ifdef _220_
;        granee(&K[2][1],4500,5500);
;        #else
;        granee(&K[2][1],1360,1700);
;        #endif    */
;        }
_0x94:
_0x93:
_0x91:
_0x8F:
_0x8D:
;
;    else if((RXBUFF1[3]&0xf0)==0x30)
	RJMP _0x95
_0x8B:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x30)
	BREQ PC+3
	JMP _0x96
;        {
;        if((RXBUFF1[3]&0x0f)==0x02)
	CALL SUBOPT_0x14
	BREQ PC+3
	JMP _0x97
;            {
;            K[3][1]++;
	CALL SUBOPT_0x1B
	ADIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x98
_0x97:
	CALL SUBOPT_0x16
	BREQ PC+3
	JMP _0x99
;            {
;            K[3][1]+=10;
	CALL SUBOPT_0x1B
	ADIW R30,10
	__PUTW1EN _K,14
;            }
;        else if((RXBUFF1[3]&0x0f)==0x04)
	RJMP _0x9A
_0x99:
	CALL SUBOPT_0x17
	BREQ PC+3
	JMP _0x9B
;            {
;            K[3][1]--;
	CALL SUBOPT_0x1B
	SBIW R30,1
	CALL __EEPROMWRW
;            }
;        else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x9C
_0x9B:
	CALL SUBOPT_0x18
	BREQ PC+3
	JMP _0x9D
;            {
;            K[3][1]-=10;
	CALL SUBOPT_0x1B
	SBIW R30,10
	__PUTW1EN _K,14
;            }
;        granee(&K[3][1],/*480*/200,/*497*/1000);
_0x9D:
_0x9C:
_0x9A:
_0x98:
	__POINTW1MN _K,14
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _granee
;        }
;
;/*    else if((RXBUFF1[3]&0xf0)==0xA0)    //изменение адреса(инкремент и декремент)
;        {
;        //rotor++;
;        if((RXBUFF1[3]&0x0f)==0x02)
;            {
;            adr_ee++;
;            }
;        else if((RXBUFF1[3]&0x0f)==0x03)
;            {
;            adr_ee+=10;
;            }
;        else if((RXBUFF1[3]&0x0f)==0x04)
;            {
;            adr_ee--;
;            }
;        else if((RXBUFF1[3]&0x0f)==0x05)
;            {
;            adr_ee-=10;
;            }
;        } */
;/*    else if((RXBUFF1[3]&0xf0)==0xB0)   //установка адреса(для ворот)
;        {
;        //rotor--;
;        adr_ee=(RXBUFF1[3]&0x0f);
;        }  */
;    link_cnt=0;
_0x96:
_0x95:
_0x8A:
_0x81:
	CALL SUBOPT_0x10
;     link=ON;
;     if(res_fl_)
	CALL SUBOPT_0x11
	BRNE PC+3
	JMP _0x9E
;          {
;          res_fl_=0;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;          }
;
;
;    }
_0x9E:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF))
	RJMP _0x9F
_0x74:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0xA1
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0xA1
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x62)
	BREQ PC+3
	JMP _0xA1
	RJMP _0xA2
_0xA1:
	RJMP _0xA0
_0xA2:
;    {
;    //rotor_int++;
;    if(Umax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) Umax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	LDI  R26,LOW(_Umax)
	LDI  R27,HIGH(_Umax)
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	CP   R30,R22
	CPC  R31,R23
	BRNE PC+3
	JMP _0xA3
	__GETB2MN _RXBUFF1,4
	CALL SUBOPT_0xC
	CALL SUBOPT_0x1D
	LDI  R26,LOW(_Umax)
	LDI  R27,HIGH(_Umax)
	CALL __EEPROMWRW
;    if(dU!=(RXBUFF1[5]+(RXBUFF1[6]*256))) dU=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0xA3:
	LDI  R26,LOW(_dU)
	LDI  R27,HIGH(_dU)
	CALL __EEPROMRDW
	MOVW R22,R30
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	CP   R30,R22
	CPC  R31,R23
	BRNE PC+3
	JMP _0xA4
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	LDI  R26,LOW(_dU)
	LDI  R27,HIGH(_dU)
	CALL __EEPROMWRW
;
;    if((RXBUFF1[7]&0x0f)==0x05)
_0xA4:
	__GETB1MN _RXBUFF1,7
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0xA5
;        {
; //      if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
;        }
;    else if((RXBUFF1[7]&0x0f)==0x0a)
	RJMP _0xA6
_0xA5:
	__GETB1MN _RXBUFF1,7
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0xA)
	BREQ PC+3
	JMP _0xA7
;        {
;//        if(ee_AVT_MODE!=0)ee_AVT_MODE=0;
;        }
;    }
_0xA7:
_0xA6:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&((RXBUFF1[2]==MEM_KF1)/*||(RXBUFF1[2]==MEM_KF4)*/))
	RJMP _0xA8
_0xA0:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0xAA
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0xAA
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BREQ PC+3
	JMP _0xAA
	RJMP _0xAB
_0xAA:
	RJMP _0xA9
_0xAB:
;    {
;    if(tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	CP   R30,R22
	CPC  R31,R23
	BRNE PC+3
	JMP _0xAC
	__GETB2MN _RXBUFF1,4
	CALL SUBOPT_0xC
	CALL SUBOPT_0x1D
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMWRW
;    if(tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0xAC:
	CALL SUBOPT_0x20
	MOVW R22,R30
	CALL SUBOPT_0xB
	CALL SUBOPT_0x1F
	CP   R30,R22
	CPC  R31,R23
	BRNE PC+3
	JMP _0xAD
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	LDI  R26,LOW(_tsign)
	LDI  R27,HIGH(_tsign)
	CALL __EEPROMWRW
;    //if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7];
;
;    if(RXBUFF1[2]==MEM_KF1)
_0xAD:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BREQ PC+3
	JMP _0xAE
;        {
; //       if(ee_DEVICE!=0)ee_DEVICE=0;
;        if(TZAS!=(signed short)RXBUFF1[7]) TZAS=(signed short)RXBUFF1[7];
	CALL SUBOPT_0xA
	MOV  R26,R30
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE PC+3
	JMP _0xAF
	__GETB1MN _RXBUFF1,7
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMWRB
;        }
_0xAF:
; //   if(RXBUFF1[2]==MEM_KF4)    //MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выклю ...
; //       {
; //       if(ee_DEVICE!=1)ee_DEVICE=1;
; //       if(ee_IMAXVENT!=(signed short)RXBUFF1[7]) ee_IMAXVENT=(signed short)RXBUFF1[7];
; //           if(ee_TZAS!=3) ee_TZAS=3;
;  //      }
;
;    }
_0xAE:
;
;else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	RJMP _0xB0
_0xA9:
	CALL SUBOPT_0x9
	LDS  R26,_RXBUFF1
	CP   R30,R26
	BREQ PC+3
	JMP _0xB2
	CALL SUBOPT_0x9
	__GETB2MN _RXBUFF1,1
	CP   R30,R26
	BREQ PC+3
	JMP _0xB2
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BREQ PC+3
	JMP _0xB2
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x63)
	BREQ PC+3
	JMP _0xB2
	RJMP _0xB3
_0xB2:
	RJMP _0xB1
_0xB3:
;    {
;    flags&=0b11100001;
	CALL SUBOPT_0x21
;    tsign_cnt=0;
;    tmax_cnt=0;
;    umax_cnt=0;
;    umin_cnt=0;
;    led_drv_cnt=30;
	LDI  R30,LOW(30)
	STS  _led_drv_cnt,R30
;    }
;/*else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==VENT_RES))
;    {
;    vent_resurs=0;
;    }*/
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	RJMP _0xB4
_0xB1:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0xB6
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0xB6
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BREQ PC+3
	JMP _0xB6
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x16)
	BREQ PC+3
	JMP _0xB6
	RJMP _0xB7
_0xB6:
	RJMP _0xB5
_0xB7:
;    {
;    if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0xB9
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0xB9
	RJMP _0xBA
_0xB9:
	RJMP _0xB8
_0xBA:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	CALL SUBOPT_0x22
;    else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--;
	RJMP _0xBB
_0xB8:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x66)
	BREQ PC+3
	JMP _0xBD
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x66)
	BREQ PC+3
	JMP _0xBD
	RJMP _0xBE
_0xBD:
	RJMP _0xBC
_0xBE:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	CALL SUBOPT_0x23
;    else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
	RJMP _0xBF
_0xBC:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x77)
	BREQ PC+3
	JMP _0xC1
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x77)
	BREQ PC+3
	JMP _0xC1
	RJMP _0xC2
_0xC1:
	RJMP _0xC0
_0xC2:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
;     gran(&_x_,-XMAX,XMAX);
_0xC0:
_0xBF:
_0xBB:
	LDI  R30,LOW(__x_)
	LDI  R31,HIGH(__x_)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(65511)
	LDI  R31,HIGH(65511)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(25)
	LDI  R27,0
	CALL _gran
;    }
;else if((RXBUFF1[0]==adr)&&(RXBUFF1[1]==adr)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==RXBUFF1[4])&&(RXBUFF1[3]==0xee))
	RJMP _0xC3
_0xB5:
	CALL SUBOPT_0x9
	LDS  R26,_RXBUFF1
	CP   R30,R26
	BREQ PC+3
	JMP _0xC5
	CALL SUBOPT_0x9
	__GETB2MN _RXBUFF1,1
	CP   R30,R26
	BREQ PC+3
	JMP _0xC5
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BREQ PC+3
	JMP _0xC5
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BREQ PC+3
	JMP _0xC5
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0xEE)
	BREQ PC+3
	JMP _0xC5
	RJMP _0xC6
_0xC5:
	RJMP _0xC4
_0xC6:
;    {
;    rotor_int++;
	CALL SUBOPT_0x12
;     tempI=pwm_u;
	__GETWRMN 20,21,0,_pwm_u
;    U_AVT=tempI;
	MOVW R30,R20
	LDI  R26,LOW(_U_AVT)
	LDI  R27,HIGH(_U_AVT)
	CALL __EEPROMWRW
;    delay_ms(100);
	CALL SUBOPT_0x8
;    if(U_AVT==tempI)can_transmit1(adr,PUTID,0xdd,0xdd,0,0,0,0);
	LDI  R26,LOW(_U_AVT)
	LDI  R27,HIGH(_U_AVT)
	CALL __EEPROMRDW
	CP   R20,R30
	CPC  R21,R31
	BREQ PC+3
	JMP _0xC7
	CALL SUBOPT_0x9
	ST   -Y,R30
	LDI  R30,LOW(145)
	ST   -Y,R30
	LDI  R30,LOW(221)
	ST   -Y,R30
	CALL SUBOPT_0xF
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _can_transmit1
;
;    }
_0xC7:
;
;
;
;
;
;can_in_an1_end:
_0xC4:
_0xC3:
_0xB4:
_0xB0:
_0xA8:
_0x9F:
_0x73:
_0xC8:
;bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
;}
	CALL __LOADLOCR6
	ADIW R28,6
	RET
; .FEND
;
;//-----------------------------------------------
;void net_drv(void)
;{
;//char temp_;
;/*if(bMAIN)
;    {
;    if(++cnt_net_drv>=7) cnt_net_drv=0;
;
;    if(cnt_net_drv<=5)
;        {
;        can_transmit1(cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_n ...
;        i_main_bps_cnt[cnt_net_drv]++;
;        if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
;        }
;    else if(cnt_net_drv==6)
;        {
;        plazma_int[2]=pwm_u;
;        can_transmit1(adr,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char ...
;        can_transmit1(adr,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*) ...
;        }
;    } */
;}
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;//-----------------------------------------------
;void t0_init(void)
; 0000 0084 {
_t0_init:
; .FSTART _t0_init
; 0000 0085 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 0086 TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 0087 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 0088 OCR0A=0x00;
	OUT  0x27,R30
; 0000 0089 OCR0B=0x00;
	OUT  0x28,R30
; 0000 008A 
; 0000 008B TCNT0=-8;
	LDI  R30,LOW(248)
	OUT  0x26,R30
; 0000 008C TIMSK0|=0b00000001;
	LDS  R30,110
	ORI  R30,1
	STS  110,R30
; 0000 008D 
; 0000 008E 
; 0000 008F }
	RET
; .FEND
;
;//-----------------------------------------------
;char adr_gran(signed short in)
; 0000 0093 {
_adr_gran:
; .FSTART _adr_gran
; 0000 0094 if(in>800)return 1;
	ST   -Y,R27
	ST   -Y,R26
;	in -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x321)
	LDI  R30,HIGH(0x321)
	CPC  R27,R30
	BRGE PC+3
	JMP _0xC9
	LDI  R30,LOW(1)
	ADIW R28,2
	RET
; 0000 0095 else if((in>80)&&(in<120))return 0;
_0xC9:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x51)
	LDI  R30,HIGH(0x51)
	CPC  R27,R30
	BRGE PC+3
	JMP _0xCC
	CPI  R26,LOW(0x78)
	LDI  R30,HIGH(0x78)
	CPC  R27,R30
	BRLT PC+3
	JMP _0xCC
	RJMP _0xCD
_0xCC:
	RJMP _0xCB
_0xCD:
	LDI  R30,LOW(0)
	ADIW R28,2
	RET
; 0000 0096 else return 100;
_0xCB:
	LDI  R30,LOW(100)
	ADIW R28,2
	RET
; 0000 0097 }
_0xCE:
_0xCA:
	ADIW R28,2
	RET
; .FEND
;
;
;//-----------------------------------------------
;void gran(signed int *adr, signed int min, signed int max)
; 0000 009C {
_gran:
; .FSTART _gran
; 0000 009D if (*adr<min) *adr=min;
	ST   -Y,R27
	ST   -Y,R26
;	*adr -> Y+4
;	min -> Y+2
;	max -> Y+0
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	MOVW R26,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0xCF
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 009E if (*adr>max) *adr=max;
_0xCF:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0xD0
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 009F }
_0xD0:
	ADIW R28,6
	RET
; .FEND
;
;
;//-----------------------------------------------
;void granee(eeprom signed int *adr, signed int min, signed int max)
; 0000 00A4 {
_granee:
; .FSTART _granee
; 0000 00A5 if (*adr<min) *adr=min;
	ST   -Y,R27
	ST   -Y,R26
;	*adr -> Y+4
;	min -> Y+2
;	max -> Y+0
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	MOVW R26,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0xD1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00A6 if (*adr>max) *adr=max;
_0xD1:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0xD2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00A7 }
_0xD2:
	ADIW R28,6
	RET
; .FEND
;
;//-----------------------------------------------
;void x_drv(void)
; 0000 00AB {
_x_drv:
; .FSTART _x_drv
; 0000 00AC /*
; 0000 00AD if((adr==62)&&(link_cnt63<5))
; 0000 00AE         {
; 0000 00AF         //_x_=25;
; 0000 00B0         if((I>I63)&&((I-I63)>1))
; 0000 00B1                 {
; 0000 00B2 	        if(_x_cnt<5)
; 0000 00B3 		        {
; 0000 00B4 		        _x_cnt++;
; 0000 00B5 		        if(_x_cnt>=5)
; 0000 00B6 			        {
; 0000 00B7 			        _x_--;
; 0000 00B8 			        _x_cnt=0;
; 0000 00B9 			        }
; 0000 00BA 		        }
; 0000 00BB                 }
; 0000 00BC 
; 0000 00BD         else if((I<I63)&&((I63-I)>1))
; 0000 00BE                 {
; 0000 00BF 	        if(_x_cnt<5)
; 0000 00C0 		        {
; 0000 00C1 		        _x_cnt++;
; 0000 00C2 		        if(_x_cnt>=5)
; 0000 00C3 			        {
; 0000 00C4 			        _x_++;
; 0000 00C5 			        _x_cnt=0;
; 0000 00C6 			        }
; 0000 00C7 		        }
; 0000 00C8                 }
; 0000 00C9         else _x_cnt=0;
; 0000 00CA 
; 0000 00CB         gran(&_x_,-XMAX,XMAX);
; 0000 00CC         }
; 0000 00CD else if(adr==63)
; 0000 00CE         {
; 0000 00CF         }
; 0000 00D0 else
; 0000 00D1         {
; 0000 00D2 
; 0000 00D3 if(_x__==_x_)
; 0000 00D4 	{
; 0000 00D5 	if(_x_cnt<60)
; 0000 00D6 		{
; 0000 00D7 		_x_cnt++;
; 0000 00D8 		if(_x_cnt>=60)
; 0000 00D9 			{
; 0000 00DA 			if(_x_ee_!=_x_)_x_ee_=_x_;
; 0000 00DB 			}
; 0000 00DC 		}
; 0000 00DD 
; 0000 00DE 	}
; 0000 00DF else _x_cnt=0;
; 0000 00E0 
; 0000 00E1 if(_x_cnt>60) _x_cnt=0;
; 0000 00E2 
; 0000 00E3 _x__=_x_;
; 0000 00E4         }  */
; 0000 00E5 }
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_start(void)
; 0000 00E9 {
_apv_start:
; .FSTART _apv_start
; 0000 00EA if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
	LDS  R26,_apv_cnt
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0xD4
	__GETB2MN _apv_cnt,1
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0xD4
	__GETB2MN _apv_cnt,2
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0xD4
	IN   R30,0x2A
	SBRC R30,0
	RJMP _0xD4
	RJMP _0xD5
_0xD4:
	RJMP _0xD3
_0xD5:
; 0000 00EB 	{
; 0000 00EC 	apv_cnt[0]=60;
	LDI  R30,LOW(60)
	STS  _apv_cnt,R30
; 0000 00ED 	apv_cnt[1]=60;
	__PUTB1MN _apv_cnt,1
; 0000 00EE 	apv_cnt[2]=60;
	__PUTB1MN _apv_cnt,2
; 0000 00EF 	apv_cnt_=3600;
	LDI  R30,LOW(3600)
	LDI  R31,HIGH(3600)
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R31
; 0000 00F0 	bAPV=1;
	IN   R30,0x2A
	SBR  R30,1
	OUT  0x2A,R30
; 0000 00F1 	}
; 0000 00F2 }
_0xD3:
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_stop(void)
; 0000 00F6 {
_apv_stop:
; .FSTART _apv_stop
; 0000 00F7 apv_cnt[0]=0;
	LDI  R30,LOW(0)
	STS  _apv_cnt,R30
; 0000 00F8 apv_cnt[1]=0;
	__PUTB1MN _apv_cnt,1
; 0000 00F9 apv_cnt[2]=0;
	__PUTB1MN _apv_cnt,2
; 0000 00FA apv_cnt_=0;
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R30
; 0000 00FB bAPV=0;
	IN   R30,0x2A
	CBR  R30,1
	OUT  0x2A,R30
; 0000 00FC }
	RET
; .FEND
;
;
;//-----------------------------------------------
;void av_wrk_drv_(void)
; 0000 0101 {
; 0000 0102 adc_ch_2_delta=(char)(adc_ch_2_max-adc_ch_2_min);
; 0000 0103 adc_ch_2_max=adc_buff_[2];
; 0000 0104 adc_ch_2_min=adc_buff_[2];
; 0000 0105 if(PORTD.7==0)
; 0000 0106 	{
; 0000 0107 	if(adc_ch_2_delta>=5)
; 0000 0108 		{
; 0000 0109 		cnt_adc_ch_2_delta++;
; 0000 010A 		if(cnt_adc_ch_2_delta>=10)
; 0000 010B 			{
; 0000 010C 			flags|=0x10;
; 0000 010D 			apv_start();
; 0000 010E 			}
; 0000 010F 		}
; 0000 0110 	else
; 0000 0111 		{
; 0000 0112 		cnt_adc_ch_2_delta=0;
; 0000 0113 		}
; 0000 0114 	}
; 0000 0115 else cnt_adc_ch_2_delta=0;
; 0000 0116 }
;
;//-----------------------------------------------
;void led_drv(void)
; 0000 011A {
_led_drv:
; .FSTART _led_drv
; 0000 011B 
; 0000 011C static long led_red_buff,led_green_buff;
; 0000 011D 
; 0000 011E DDRD.1=1;
	SBI  0xA,1
; 0000 011F if(led_green_buff&0b1L) PORTD.1=1;
	LDS  R30,_led_green_buff_S0000019000
	ANDI R30,LOW(0x1)
	BRNE PC+3
	JMP _0xDD
	SBI  0xB,1
; 0000 0120 else PORTD.1=0;
	RJMP _0xE0
_0xDD:
	CBI  0xB,1
; 0000 0121 DDRD.0=1;
_0xE0:
	SBI  0xA,0
; 0000 0122 if(led_red_buff&0b1L) PORTD.0=1;
	LDS  R30,_led_red_buff_S0000019000
	ANDI R30,LOW(0x1)
	BRNE PC+3
	JMP _0xE5
	SBI  0xB,0
; 0000 0123 else PORTD.0=0;
	RJMP _0xE8
_0xE5:
	CBI  0xB,0
; 0000 0124 
; 0000 0125 
; 0000 0126 led_red_buff>>=1;
_0xE8:
	LDS  R30,_led_red_buff_S0000019000
	LDS  R31,_led_red_buff_S0000019000+1
	LDS  R22,_led_red_buff_S0000019000+2
	LDS  R23,_led_red_buff_S0000019000+3
	CALL __ASRD1
	CALL SUBOPT_0x24
; 0000 0127 led_green_buff>>=1;
	LDS  R30,_led_green_buff_S0000019000
	LDS  R31,_led_green_buff_S0000019000+1
	LDS  R22,_led_green_buff_S0000019000+2
	LDS  R23,_led_green_buff_S0000019000+3
	CALL __ASRD1
	CALL SUBOPT_0x25
; 0000 0128 if(++led_drv_cnt>32)
	LDS  R26,_led_drv_cnt
	SUBI R26,-LOW(1)
	STS  _led_drv_cnt,R26
	CPI  R26,LOW(0x21)
	BRSH PC+3
	JMP _0xEB
; 0000 0129 	{
; 0000 012A 	led_drv_cnt=0;
	LDI  R30,LOW(0)
	STS  _led_drv_cnt,R30
; 0000 012B 	led_red_buff=led_red;
	LDS  R30,_led_red
	LDS  R31,_led_red+1
	LDS  R22,_led_red+2
	LDS  R23,_led_red+3
	CALL SUBOPT_0x24
; 0000 012C 	led_green_buff=led_green;
	LDS  R30,_led_green
	LDS  R31,_led_green+1
	LDS  R22,_led_green+2
	LDS  R23,_led_green+3
	CALL SUBOPT_0x25
; 0000 012D 	}
; 0000 012E 
; 0000 012F }
_0xEB:
	RET
; .FEND
;
;//-----------------------------------------------
;void flags_drv(void)
; 0000 0133 {
_flags_drv:
; .FSTART _flags_drv
; 0000 0134 static char flags_old;
; 0000 0135 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0xEC
; 0000 0136 	{
; 0000 0137 	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000))))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0xEE
	LDS  R30,_flags_old_S000001A000
	ANDI R30,LOW(0x8)
	BREQ PC+3
	JMP _0xEE
	RJMP _0xF0
_0xEE:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BRNE PC+3
	JMP _0xF1
	LDS  R30,_flags_old_S000001A000
	ANDI R30,LOW(0x10)
	BREQ PC+3
	JMP _0xF1
	RJMP _0xF0
_0xF1:
	RJMP _0xED
_0xF0:
; 0000 0138     		{
; 0000 0139     		if(link==OFF)apv_start();
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ PC+3
	JMP _0xF4
	CALL _apv_start
; 0000 013A     		}
_0xF4:
; 0000 013B      }
_0xED:
; 0000 013C else if(jp_mode==jp3)
	RJMP _0xF5
_0xEC:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0xF6
; 0000 013D 	{
; 0000 013E 	if((flags&0b00001000)&&(!(flags_old&0b00001000)))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0xF8
	LDS  R30,_flags_old_S000001A000
	ANDI R30,LOW(0x8)
	BREQ PC+3
	JMP _0xF8
	RJMP _0xF9
_0xF8:
	RJMP _0xF7
_0xF9:
; 0000 013F     		{
; 0000 0140     		apv_start();
	CALL _apv_start
; 0000 0141     		}
; 0000 0142      }
_0xF7:
; 0000 0143 flags_old=flags;
_0xF6:
_0xF5:
	LDS  R30,_flags
	STS  _flags_old_S000001A000,R30
; 0000 0144 
; 0000 0145 }
	RET
; .FEND
;
;//-----------------------------------------------
;void adr_hndl(void)
; 0000 0149 {
_adr_hndl:
; .FSTART _adr_hndl
; 0000 014A signed tempSI;
; 0000 014B char aaa[3];
; 0000 014C char aaaa[3];
; 0000 014D DDRC=0b00000000;
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
;	tempSI -> R16,R17
;	aaa -> Y+5
;	aaaa -> Y+2
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 014E PORTC=0b00011110;
	LDI  R30,LOW(30)
	OUT  0x8,R30
; 0000 014F /*char i;
; 0000 0150 DDRD&=0b11100011;
; 0000 0151 PORTD|=0b00011100;
; 0000 0152 
; 0000 0153 //adr_new=((char)(!PIND.2))+(((char)(!PIND.3))*2)+((char)(!PIND.4)*4);
; 0000 0154 
; 0000 0155 
; 0000 0156 adr_new=(PIND&0b00011100)>>2;
; 0000 0157 
; 0000 0158 if(adr_new==adr_old)
; 0000 0159  	{
; 0000 015A  	if(adr_cnt<100)
; 0000 015B  		{
; 0000 015C  		adr_cnt++;
; 0000 015D  	     if(adr_cnt>=100)
; 0000 015E  	     	{
; 0000 015F  	     	adr_temp=adr_new;
; 0000 0160  	     	}
; 0000 0161  	     }
; 0000 0162    	}
; 0000 0163 else adr_cnt=0;
; 0000 0164 adr_old=adr_new;
; 0000 0165 if(adr!=CONST_ADR[adr_temp]) adr=CONST_ADR[adr_temp];
; 0000 0166 
; 0000 0167 
; 0000 0168 //if(adr!=0b00000011)adr=0b00000011;*/
; 0000 0169 
; 0000 016A 
; 0000 016B 
; 0000 016C ADMUX=0b01000110;
	LDI  R30,LOW(70)
	CALL SUBOPT_0x26
; 0000 016D ADCSRA=0b10100110;
; 0000 016E ADCSRA|=0b01000000;
; 0000 016F delay_ms(10);
; 0000 0170 //plazma_int[0]=ADCW;
; 0000 0171 aaa[0]=adr_gran(ADCW);
	CALL SUBOPT_0x27
	CALL _adr_gran
	STD  Y+5,R30
; 0000 0172 tempSI=ADCW/200;
	CALL SUBOPT_0x28
; 0000 0173 gran(&tempSI,0,3);
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL SUBOPT_0x29
	POP  R16
	POP  R17
; 0000 0174 aaaa[0]=(char)tempSI;
	__PUTBSR 16,2
; 0000 0175 
; 0000 0176 ADMUX=0b01000111;
	LDI  R30,LOW(71)
	CALL SUBOPT_0x26
; 0000 0177 ADCSRA=0b10100110;
; 0000 0178 ADCSRA|=0b01000000;
; 0000 0179 delay_ms(10);
; 0000 017A //plazma_int[1]=ADCW;
; 0000 017B aaa[1]=adr_gran(ADCW);
	CALL SUBOPT_0x27
	CALL _adr_gran
	STD  Y+6,R30
; 0000 017C tempSI=ADCW/200;
	CALL SUBOPT_0x28
; 0000 017D gran(&tempSI,0,3);
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL SUBOPT_0x29
	POP  R16
	POP  R17
; 0000 017E aaaa[1]=(char)tempSI;
	MOVW R30,R28
	ADIW R30,3
	ST   Z,R16
; 0000 017F 
; 0000 0180 
; 0000 0181 ADMUX=0b01000000;
	LDI  R30,LOW(64)
	CALL SUBOPT_0x26
; 0000 0182 ADCSRA=0b10100110;
; 0000 0183 ADCSRA|=0b01000000;
; 0000 0184 delay_ms(10);
; 0000 0185 //plazma_int[2]=ADCW;
; 0000 0186 aaa[2]=adr_gran(ADCW);
	CALL SUBOPT_0x27
	CALL _adr_gran
	STD  Y+7,R30
; 0000 0187 tempSI=ADCW/200;
	CALL SUBOPT_0x28
; 0000 0188 gran(&tempSI,0,3);
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL SUBOPT_0x29
	POP  R16
	POP  R17
; 0000 0189 aaaa[2]=(char)tempSI;
	MOVW R30,R28
	ADIW R30,4
	ST   Z,R16
; 0000 018A 
; 0000 018B adr=100;
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	LDI  R30,LOW(100)
	CALL __EEPROMWRB
; 0000 018C //adr=0;//aaa[0]+ (aaa[1]*4)+ (aaa[2]*16);
; 0000 018D 
; 0000 018E if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
	LDD  R26,Y+5
	CPI  R26,LOW(0x64)
	BRNE PC+3
	JMP _0xFB
	LDD  R26,Y+6
	CPI  R26,LOW(0x64)
	BRNE PC+3
	JMP _0xFB
	LDD  R26,Y+7
	CPI  R26,LOW(0x64)
	BRNE PC+3
	JMP _0xFB
	RJMP _0xFC
_0xFB:
	RJMP _0xFA
_0xFC:
; 0000 018F 	{
; 0000 0190 	if(aaa[0]==0)
	LDD  R30,Y+5
	CPI  R30,0
	BREQ PC+3
	JMP _0xFD
; 0000 0191 		{
; 0000 0192 		if(aaa[1]==0)adr=3;
	LDD  R30,Y+6
	CPI  R30,0
	BREQ PC+3
	JMP _0xFE
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	LDI  R30,LOW(3)
	CALL __EEPROMWRB
; 0000 0193 		else adr=0;
	RJMP _0xFF
_0xFE:
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
; 0000 0194 		}
_0xFF:
; 0000 0195 	else if(aaa[1]==0)adr=1;
	RJMP _0x100
_0xFD:
	LDD  R30,Y+6
	CPI  R30,0
	BREQ PC+3
	JMP _0x101
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	LDI  R30,LOW(1)
	CALL __EEPROMWRB
; 0000 0196 	else if(aaa[2]==0)adr=2;
	RJMP _0x102
_0x101:
	LDD  R30,Y+7
	CPI  R30,0
	BREQ PC+3
	JMP _0x103
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	LDI  R30,LOW(2)
	CALL __EEPROMWRB
; 0000 0197 
; 0000 0198 	//adr=1;
; 0000 0199 	}
_0x103:
_0x102:
_0x100:
; 0000 019A else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adr=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
	RJMP _0x104
_0xFA:
	LDD  R26,Y+5
	CPI  R26,LOW(0x64)
	BREQ PC+3
	JMP _0x106
	LDD  R26,Y+6
	CPI  R26,LOW(0x64)
	BREQ PC+3
	JMP _0x106
	LDD  R26,Y+7
	CPI  R26,LOW(0x64)
	BREQ PC+3
	JMP _0x106
	RJMP _0x107
_0x106:
	RJMP _0x105
_0x107:
	LDD  R30,Y+3
	LSL  R30
	LSL  R30
	LDD  R26,Y+2
	ADD  R30,R26
	MOV  R22,R30
	LDD  R30,Y+4
	LDI  R26,LOW(16)
	MUL  R30,R26
	MOVW R30,R0
	ADD  R30,R22
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMWRB
; 0000 019B    /*	{
; 0000 019C 	adr=0;
; 0000 019D 	} */
; 0000 019E else adr=100;
	RJMP _0x108
_0x105:
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	LDI  R30,LOW(100)
	CALL __EEPROMWRB
; 0000 019F /*if(adr_gran(aaa[2])==100)adr=2;
; 0000 01A0 else *///adr=adr_gran(aaa[2]);
; 0000 01A1 ///adr=0;
; 0000 01A2 //plazma=adr;
; 0000 01A3 //if(adr==100)adr=0;
; 0000 01A4 
; 0000 01A5 //plazma
; 0000 01A6 //adr=;
; 0000 01A7 }
_0x108:
_0x104:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	RET
; .FEND
;
;
;//-----------------------------------------------
;void apv_hndl(void)
; 0000 01AC {
_apv_hndl:
; .FSTART _apv_hndl
; 0000 01AD if(apv_cnt[0])
	LDS  R30,_apv_cnt
	CPI  R30,0
	BRNE PC+3
	JMP _0x109
; 0000 01AE 	{
; 0000 01AF 	apv_cnt[0]--;
	SUBI R30,LOW(1)
	STS  _apv_cnt,R30
; 0000 01B0 	if(apv_cnt[0]==0)
	CPI  R30,0
	BREQ PC+3
	JMP _0x10A
; 0000 01B1 		{
; 0000 01B2 		flags&=0b11100001;
	CALL SUBOPT_0x21
; 0000 01B3 		tsign_cnt=0;
; 0000 01B4 		tmax_cnt=0;
; 0000 01B5 		umax_cnt=0;
; 0000 01B6 		umin_cnt=0;
; 0000 01B7 		cnt_adc_ch_2_delta=0;
	CALL SUBOPT_0x2A
; 0000 01B8 		led_drv_cnt=30;
; 0000 01B9 		}
; 0000 01BA 	}
_0x10A:
; 0000 01BB else if(apv_cnt[1])
	RJMP _0x10B
_0x109:
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE PC+3
	JMP _0x10C
; 0000 01BC 	{
; 0000 01BD 	apv_cnt[1]--;
	__GETB1MN _apv_cnt,1
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,1
; 0000 01BE 	if(apv_cnt[1]==0)
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BREQ PC+3
	JMP _0x10D
; 0000 01BF 		{
; 0000 01C0 		flags&=0b11100001;
	CALL SUBOPT_0x21
; 0000 01C1 		tsign_cnt=0;
; 0000 01C2 		tmax_cnt=0;
; 0000 01C3 		umax_cnt=0;
; 0000 01C4 		umin_cnt=0;
; 0000 01C5 		cnt_adc_ch_2_delta=0;
	CALL SUBOPT_0x2A
; 0000 01C6 		led_drv_cnt=30;
; 0000 01C7 		}
; 0000 01C8 	}
_0x10D:
; 0000 01C9 else if(apv_cnt[2])
	RJMP _0x10E
_0x10C:
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE PC+3
	JMP _0x10F
; 0000 01CA 	{
; 0000 01CB 	apv_cnt[2]--;
	__GETB1MN _apv_cnt,2
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,2
; 0000 01CC 	if(apv_cnt[2]==0)
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BREQ PC+3
	JMP _0x110
; 0000 01CD 		{
; 0000 01CE 		flags&=0b11100001;
	CALL SUBOPT_0x21
; 0000 01CF 		tsign_cnt=0;
; 0000 01D0 		tmax_cnt=0;
; 0000 01D1 		umax_cnt=0;
; 0000 01D2 		umin_cnt=0;
; 0000 01D3 		cnt_adc_ch_2_delta=0;
	CALL SUBOPT_0x2A
; 0000 01D4 		led_drv_cnt=30;
; 0000 01D5 		}
; 0000 01D6 	}
_0x110:
; 0000 01D7 
; 0000 01D8 if(apv_cnt_)
_0x10F:
_0x10E:
_0x10B:
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BRNE PC+3
	JMP _0x111
; 0000 01D9 	{
; 0000 01DA 	apv_cnt_--;
	LDI  R26,LOW(_apv_cnt_)
	LDI  R27,HIGH(_apv_cnt_)
	CALL SUBOPT_0x23
; 0000 01DB 	if(apv_cnt_==0)
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BREQ PC+3
	JMP _0x112
; 0000 01DC 		{
; 0000 01DD 		bAPV=0;
	IN   R30,0x2A
	CBR  R30,1
	OUT  0x2A,R30
; 0000 01DE 		apv_start();
	CALL _apv_start
; 0000 01DF 		}
; 0000 01E0 	}
_0x112:
; 0000 01E1 
; 0000 01E2 if((umin_cnt==0)&&(umax_cnt==0)&&(cnt_adc_ch_2_delta==0)&&(PORTD.2==0))
_0x111:
	CALL SUBOPT_0x2B
	SBIW R26,0
	BREQ PC+3
	JMP _0x114
	CALL SUBOPT_0x2C
	SBIW R26,0
	BREQ PC+3
	JMP _0x114
	LDS  R26,_cnt_adc_ch_2_delta
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x114
	SBIC 0xB,2
	RJMP _0x114
	RJMP _0x115
_0x114:
	RJMP _0x113
_0x115:
; 0000 01E3 	{
; 0000 01E4 	if(cnt_apv_off<20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRLO PC+3
	JMP _0x116
; 0000 01E5 		{
; 0000 01E6 		cnt_apv_off++;
	LDS  R30,_cnt_apv_off
	SUBI R30,-LOW(1)
	STS  _cnt_apv_off,R30
; 0000 01E7 		if(cnt_apv_off>=20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRSH PC+3
	JMP _0x117
; 0000 01E8 			{
; 0000 01E9 			apv_stop();
	CALL _apv_stop
; 0000 01EA 			}
; 0000 01EB 		}
_0x117:
; 0000 01EC 	}
_0x116:
; 0000 01ED else cnt_apv_off=0;
	RJMP _0x118
_0x113:
	LDI  R30,LOW(0)
	STS  _cnt_apv_off,R30
; 0000 01EE 
; 0000 01EF }
_0x118:
	RET
; .FEND
;
;//-----------------------------------------------
;void link_drv(void)
; 0000 01F3 {
_link_drv:
; .FSTART _link_drv
; 0000 01F4 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x119
; 0000 01F5 	{
; 0000 01F6 	if(link_cnt==49)flags&=0b11000001;
	LDS  R26,_link_cnt
	CPI  R26,LOW(0x31)
	BREQ PC+3
	JMP _0x11A
	LDS  R30,_flags
	ANDI R30,LOW(0xC1)
	STS  _flags,R30
; 0000 01F7 	if((++link_cnt>=50)&&(adr!=62)&&(adr!=63))
_0x11A:
	LDS  R26,_link_cnt
	SUBI R26,-LOW(1)
	STS  _link_cnt,R26
	CPI  R26,LOW(0x32)
	BRSH PC+3
	JMP _0x11C
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3E)
	BRNE PC+3
	JMP _0x11C
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3F)
	BRNE PC+3
	JMP _0x11C
	RJMP _0x11D
_0x11C:
	RJMP _0x11B
_0x11D:
; 0000 01F8 		{
; 0000 01F9 		link_cnt=50;
	LDI  R30,LOW(50)
	STS  _link_cnt,R30
; 0000 01FA     		link=OFF;
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 01FB     		if(!res_fl_)
	CALL SUBOPT_0x11
	BREQ PC+3
	JMP _0x11E
; 0000 01FC 			{
; 0000 01FD 	    		bRES_=1;
	IN   R30,0x2A
	SBR  R30,4
	OUT  0x2A,R30
; 0000 01FE 	    		res_fl_=1;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	LDI  R30,LOW(1)
	CALL __EEPROMWRB
; 0000 01FF 	    		}
; 0000 0200     		}
_0x11E:
; 0000 0201 	}
_0x11B:
; 0000 0202 else link=OFF;
	RJMP _0x11F
_0x119:
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 0203 }
_0x11F:
	RET
; .FEND
;
;//-----------------------------------------------
;void temper_drv(void)
; 0000 0207 {
_temper_drv:
; .FSTART _temper_drv
; 0000 0208 
; 0000 0209 if(T>tsign) tsign_cnt++;
	CALL SUBOPT_0x20
	CALL SUBOPT_0x2D
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x120
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	CALL SUBOPT_0x22
; 0000 020A else if (T<(tsign-1)) tsign_cnt--;
	RJMP _0x121
_0x120:
	CALL SUBOPT_0x20
	SBIW R30,1
	CALL SUBOPT_0x2D
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x122
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	CALL SUBOPT_0x23
; 0000 020B 
; 0000 020C gran(&tsign_cnt,0,60);
_0x122:
_0x121:
	LDI  R30,LOW(_tsign_cnt)
	LDI  R31,HIGH(_tsign_cnt)
	CALL SUBOPT_0x2E
; 0000 020D 
; 0000 020E if(tsign_cnt>=55)
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,55
	BRGE PC+3
	JMP _0x123
; 0000 020F 	{
; 0000 0210 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x125
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x125
	RJMP _0x127
_0x125:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x127
	RJMP _0x124
_0x127:
	LDS  R30,_flags
	ORI  R30,4
	STS  _flags,R30
; 0000 0211 	}
_0x124:
; 0000 0212 else if (tsign_cnt<=5) flags&=0b11111011;
	RJMP _0x129
_0x123:
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,6
	BRLT PC+3
	JMP _0x12A
	LDS  R30,_flags
	ANDI R30,0xFB
	STS  _flags,R30
; 0000 0213 
; 0000 0214 
; 0000 0215 
; 0000 0216 
; 0000 0217 if(T>tmax) tmax_cnt++;
_0x12A:
_0x129:
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMRDW
	CALL SUBOPT_0x2D
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x12B
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	CALL SUBOPT_0x22
; 0000 0218 else if (T<(tmax-1)) tmax_cnt--;
	RJMP _0x12C
_0x12B:
	LDI  R26,LOW(_tmax)
	LDI  R27,HIGH(_tmax)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL SUBOPT_0x2D
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x12D
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	CALL SUBOPT_0x23
; 0000 0219 
; 0000 021A gran(&tmax_cnt,0,60);
_0x12D:
_0x12C:
	LDI  R30,LOW(_tmax_cnt)
	LDI  R31,HIGH(_tmax_cnt)
	CALL SUBOPT_0x2E
; 0000 021B 
; 0000 021C if(tmax_cnt>=55)
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,55
	BRGE PC+3
	JMP _0x12E
; 0000 021D 	{
; 0000 021E 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x130
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x130
	RJMP _0x132
_0x130:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x132
	RJMP _0x12F
_0x132:
	LDS  R30,_flags
	ORI  R30,2
	STS  _flags,R30
; 0000 021F 	}
_0x12F:
; 0000 0220 else if (tmax_cnt<=5) flags&=0b11111101;
	RJMP _0x134
_0x12E:
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,6
	BRLT PC+3
	JMP _0x135
	LDS  R30,_flags
	ANDI R30,0xFD
	STS  _flags,R30
; 0000 0221 
; 0000 0222 
; 0000 0223 }
_0x135:
_0x134:
	RET
; .FEND
;
;//-----------------------------------------------
;void u_drv(void)
; 0000 0227 {
_u_drv:
; .FSTART _u_drv
; 0000 0228 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x136
; 0000 0229 	{
; 0000 022A 	if(Ui>Umax)umax_cnt++;
	LDI  R26,LOW(_Umax)
	LDI  R27,HIGH(_Umax)
	CALL __EEPROMRDW
	CALL SUBOPT_0x2F
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x137
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x22
; 0000 022B 	else umax_cnt=0;
	RJMP _0x138
_0x137:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 022C 	gran(&umax_cnt,0,10);
_0x138:
	CALL SUBOPT_0x30
; 0000 022D 	if(umax_cnt>=10)flags|=0b00001000;
	BRGE PC+3
	JMP _0x139
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 022E 
; 0000 022F 
; 0000 0230 	if((Ui<Un)&&((Un-Ui)>dU)&&(!PORTB.2))umin_cnt++;
_0x139:
	LDS  R30,_Un
	LDS  R31,_Un+1
	CALL SUBOPT_0x2F
	CP   R26,R30
	CPC  R27,R31
	BRLO PC+3
	JMP _0x13B
	CALL SUBOPT_0x2F
	LDS  R30,_Un
	LDS  R31,_Un+1
	SUB  R30,R26
	SBC  R31,R27
	MOVW R0,R30
	LDI  R26,LOW(_dU)
	LDI  R27,HIGH(_dU)
	CALL __EEPROMRDW
	CP   R30,R0
	CPC  R31,R1
	BRLO PC+3
	JMP _0x13B
	SBIC 0x5,2
	RJMP _0x13B
	RJMP _0x13C
_0x13B:
	RJMP _0x13A
_0x13C:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	CALL SUBOPT_0x22
; 0000 0231 	else umin_cnt=0;
	RJMP _0x13D
_0x13A:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
; 0000 0232 	gran(&umin_cnt,0,10);
_0x13D:
	CALL SUBOPT_0x31
; 0000 0233 	if((umin_cnt>=10)&&(adr!=62)&&(adr!=63))flags|=0b00010000;
	BRGE PC+3
	JMP _0x13F
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3E)
	BRNE PC+3
	JMP _0x13F
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3F)
	BRNE PC+3
	JMP _0x13F
	RJMP _0x140
_0x13F:
	RJMP _0x13E
_0x140:
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
; 0000 0234 	}
_0x13E:
; 0000 0235 else if(jp_mode==jp3)
	RJMP _0x141
_0x136:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x142
; 0000 0236 	{
; 0000 0237 	if(Ui>700)umax_cnt++;
	CALL SUBOPT_0x2F
	CPI  R26,LOW(0x2BD)
	LDI  R30,HIGH(0x2BD)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x143
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x22
; 0000 0238 	else umax_cnt=0;
	RJMP _0x144
_0x143:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 0239 	gran(&umax_cnt,0,10);
_0x144:
	CALL SUBOPT_0x30
; 0000 023A 	if(umax_cnt>=10)flags|=0b00001000;
	BRGE PC+3
	JMP _0x145
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 023B 
; 0000 023C 
; 0000 023D 	if((Ui<200)&&(!PORTB.2))umin_cnt++;
_0x145:
	CALL SUBOPT_0x2F
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRLO PC+3
	JMP _0x147
	SBIC 0x5,2
	RJMP _0x147
	RJMP _0x148
_0x147:
	RJMP _0x146
_0x148:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	CALL SUBOPT_0x22
; 0000 023E 	else umin_cnt=0;
	RJMP _0x149
_0x146:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
; 0000 023F 	gran(&umin_cnt,0,10);
_0x149:
	CALL SUBOPT_0x31
; 0000 0240 	if(umin_cnt>=10)flags|=0b00010000;
	BRGE PC+3
	JMP _0x14A
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
; 0000 0241 	}
_0x14A:
; 0000 0242 }
_0x142:
_0x141:
	RET
; .FEND
;
;//-----------------------------------------------
;void led_hndl(void)
; 0000 0246 {
_led_hndl:
; .FSTART _led_hndl
; 0000 0247 
; 0000 0248 if(adr==62)
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3E)
	BREQ PC+3
	JMP _0x14B
; 0000 0249 	{
; 0000 024A 	if(main_cnt1<(5*TZAS))
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x14C
; 0000 024B 		{
; 0000 024C 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 024D 		led_green=0x03030303L;
	CALL SUBOPT_0x34
; 0000 024E 		}
; 0000 024F 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
	RJMP _0x14D
_0x14C:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x14F
	CALL SUBOPT_0xA
	CALL SUBOPT_0x35
	BRLT PC+3
	JMP _0x14F
	RJMP _0x150
_0x14F:
	RJMP _0x14E
_0x150:
; 0000 0250 		{
; 0000 0251 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 0252 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 0253 		}
; 0000 0254 	else if(((flags&0b00001110)==0))
	RJMP _0x151
_0x14E:
	LDS  R30,_flags
	ANDI R30,LOW(0xE)
	BREQ PC+3
	JMP _0x152
; 0000 0255 		{
; 0000 0256 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 0257 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 0258 		}
; 0000 0259 	else if((flags&0b00111110)==0b00000100)
	RJMP _0x153
_0x152:
	CALL SUBOPT_0x37
	BREQ PC+3
	JMP _0x154
; 0000 025A 		{
; 0000 025B 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 025C 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 025D 		}
; 0000 025E 	else if(flags&0b00000010)
	RJMP _0x155
_0x154:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x156
; 0000 025F 		{
; 0000 0260 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 0261 		led_green=0x00000000L;
	CALL SUBOPT_0x39
; 0000 0262 		}
; 0000 0263 	else if(flags&0b00001000)
	RJMP _0x157
_0x156:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0x158
; 0000 0264 		{
; 0000 0265 		led_red=0x00090009L;
	CALL SUBOPT_0x3A
; 0000 0266 		led_green=0x00000000L;
; 0000 0267 		}
; 0000 0268         }
_0x158:
_0x157:
_0x155:
_0x153:
_0x151:
_0x14D:
; 0000 0269 else if(adr==63)
	RJMP _0x159
_0x14B:
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3F)
	BREQ PC+3
	JMP _0x15A
; 0000 026A 	{
; 0000 026B 	if(main_cnt1<(5*TZAS))
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x15B
; 0000 026C 		{
; 0000 026D 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 026E 		led_green=0x03030303L;
	CALL SUBOPT_0x34
; 0000 026F 		}
; 0000 0270 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
	RJMP _0x15C
_0x15B:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x15E
	CALL SUBOPT_0xA
	CALL SUBOPT_0x35
	BRLT PC+3
	JMP _0x15E
	RJMP _0x15F
_0x15E:
	RJMP _0x15D
_0x15F:
; 0000 0271 		{
; 0000 0272 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 0273 		led_green=0xfffffffeL;
	CALL SUBOPT_0x3B
; 0000 0274 		}
; 0000 0275 	else if(((flags&0b00001110)==0))
	RJMP _0x160
_0x15D:
	LDS  R30,_flags
	ANDI R30,LOW(0xE)
	BREQ PC+3
	JMP _0x161
; 0000 0276 		{
; 0000 0277 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 0278 		led_green=0xfffffffeL;
	CALL SUBOPT_0x3B
; 0000 0279 		}
; 0000 027A 	else if((flags&0b00111110)==0b00000100)
	RJMP _0x162
_0x161:
	CALL SUBOPT_0x37
	BREQ PC+3
	JMP _0x163
; 0000 027B 		{
; 0000 027C 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 027D 		led_green=0xfffffffeL;
	CALL SUBOPT_0x3B
; 0000 027E 		}
; 0000 027F 	else if(flags&0b00000010)
	RJMP _0x164
_0x163:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x165
; 0000 0280 		{
; 0000 0281 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 0282 		led_green=0x00000000L;
	CALL SUBOPT_0x39
; 0000 0283 		}
; 0000 0284 	else if(flags&0b00001000)
	RJMP _0x166
_0x165:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0x167
; 0000 0285 		{
; 0000 0286 		led_red=0x00090009L;
	CALL SUBOPT_0x3A
; 0000 0287 		led_green=0x00000000L;
; 0000 0288 		}
; 0000 0289         }
_0x167:
_0x166:
_0x164:
_0x162:
_0x160:
_0x15C:
; 0000 028A else if(jp_mode!=jp3)
	RJMP _0x168
_0x15A:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x169
; 0000 028B 	{
; 0000 028C 	if(main_cnt1<(5*TZAS))
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x16A
; 0000 028D 		{
; 0000 028E 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 028F 		led_green=0x03030303L;
	CALL SUBOPT_0x34
; 0000 0290 		}
; 0000 0291 	else if((link==ON)&&(flags_tu&0b10000000))
	RJMP _0x16B
_0x16A:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0x16D
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE PC+3
	JMP _0x16D
	RJMP _0x16E
_0x16D:
	RJMP _0x16C
_0x16E:
; 0000 0292 		{
; 0000 0293 		led_red=0x00055555L;
	__GETD1N 0x55555
	CALL SUBOPT_0x3C
; 0000 0294  		led_green=0xffffffffL;
; 0000 0295  		}
; 0000 0296 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
	RJMP _0x16F
_0x16C:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x171
	CALL SUBOPT_0xA
	CALL SUBOPT_0x35
	BRLT PC+3
	JMP _0x171
	RJMP _0x172
_0x171:
	RJMP _0x170
_0x172:
; 0000 0297 		{
; 0000 0298 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 0299 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 029A 		}
; 0000 029B 
; 0000 029C 	else  if(link==OFF)
	RJMP _0x173
_0x170:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ PC+3
	JMP _0x174
; 0000 029D  		{
; 0000 029E  		led_red=0x55555555L;
	__GETD1N 0x55555555
	CALL SUBOPT_0x3C
; 0000 029F  		led_green=0xffffffffL;
; 0000 02A0  		}
; 0000 02A1 
; 0000 02A2 	else if((link==ON)&&((flags&0b00111110)==0))
	RJMP _0x175
_0x174:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0x177
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ PC+3
	JMP _0x177
	RJMP _0x178
_0x177:
	RJMP _0x176
_0x178:
; 0000 02A3 		{
; 0000 02A4 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 02A5 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 02A6 		}
; 0000 02A7 
; 0000 02A8 
; 0000 02A9 
; 0000 02AA 
; 0000 02AB 
; 0000 02AC 	else if((flags&0b00111110)==0b00000100)
	RJMP _0x179
_0x176:
	CALL SUBOPT_0x37
	BREQ PC+3
	JMP _0x17A
; 0000 02AD 		{
; 0000 02AE 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 02AF 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 02B0 		}
; 0000 02B1 	else if(flags&0b00000010)
	RJMP _0x17B
_0x17A:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x17C
; 0000 02B2 		{
; 0000 02B3 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 02B4 		led_green=0x00000000L;
	CALL SUBOPT_0x39
; 0000 02B5 		}
; 0000 02B6 	else if(flags&0b00001000)
	RJMP _0x17D
_0x17C:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0x17E
; 0000 02B7 		{
; 0000 02B8 		led_red=0x00090009L;
	CALL SUBOPT_0x3A
; 0000 02B9 		led_green=0x00000000L;
; 0000 02BA 		}
; 0000 02BB 	else if(flags&0b00010000)
	RJMP _0x17F
_0x17E:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BRNE PC+3
	JMP _0x180
; 0000 02BC 		{
; 0000 02BD 		led_red=0x00490049L;
	__GETD1N 0x490049
	CALL SUBOPT_0x3D
; 0000 02BE 		led_green=0x00000000L;
; 0000 02BF 		}
; 0000 02C0 
; 0000 02C1 	else if((link==ON)&&(flags&0b00100000))
	RJMP _0x181
_0x180:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0x183
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE PC+3
	JMP _0x183
	RJMP _0x184
_0x183:
	RJMP _0x182
_0x184:
; 0000 02C2 		{
; 0000 02C3 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 02C4 		led_green=0x00030003L;
	__GETD1N 0x30003
	CALL SUBOPT_0x3E
; 0000 02C5 		}
; 0000 02C6 
; 0000 02C7 	if((jp_mode==jp1))
_0x182:
_0x181:
_0x17F:
_0x17D:
_0x17B:
_0x179:
_0x175:
_0x173:
_0x16F:
_0x16B:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x185
; 0000 02C8 		{
; 0000 02C9 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 02CA 		led_green=0x33333333L;
	__GETD1N 0x33333333
	CALL SUBOPT_0x3E
; 0000 02CB 		}
; 0000 02CC 	else if((jp_mode==jp2))
	RJMP _0x186
_0x185:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x187
; 0000 02CD 		{
; 0000 02CE 		led_red=0xccccccccL;
	__GETD1N 0xCCCCCCCC
	CALL SUBOPT_0x3D
; 0000 02CF 		led_green=0x00000000L;
; 0000 02D0 		}
; 0000 02D1 	}
_0x187:
_0x186:
; 0000 02D2 else if(jp_mode==jp3)
	RJMP _0x188
_0x169:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x189
; 0000 02D3 	{
; 0000 02D4 	if(main_cnt1<(5*TZAS))
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x18A
; 0000 02D5 		{
; 0000 02D6 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 02D7 		led_green=0x03030303L;
	CALL SUBOPT_0x34
; 0000 02D8 		}
; 0000 02D9 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
	RJMP _0x18B
_0x18A:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x18D
	CALL SUBOPT_0xA
	CALL SUBOPT_0x3F
	BRLT PC+3
	JMP _0x18D
	RJMP _0x18E
_0x18D:
	RJMP _0x18C
_0x18E:
; 0000 02DA 		{
; 0000 02DB 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 02DC 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 02DD 		}
; 0000 02DE 
; 0000 02DF 	else if((flags&0b00011110)==0)
	RJMP _0x18F
_0x18C:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BREQ PC+3
	JMP _0x190
; 0000 02E0 		{
; 0000 02E1 		led_red=0x00000000L;
	CALL SUBOPT_0x33
; 0000 02E2 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 02E3 		}
; 0000 02E4 
; 0000 02E5 
; 0000 02E6 	else if((flags&0b00111110)==0b00000100)
	RJMP _0x191
_0x190:
	CALL SUBOPT_0x37
	BREQ PC+3
	JMP _0x192
; 0000 02E7 		{
; 0000 02E8 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 02E9 		led_green=0xffffffffL;
	CALL SUBOPT_0x36
; 0000 02EA 		}
; 0000 02EB 	else if(flags&0b00000010)
	RJMP _0x193
_0x192:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BRNE PC+3
	JMP _0x194
; 0000 02EC 		{
; 0000 02ED 		led_red=0x00010001L;
	CALL SUBOPT_0x38
; 0000 02EE 		led_green=0x00000000L;
	CALL SUBOPT_0x39
; 0000 02EF 		}
; 0000 02F0 	else if(flags&0b00001000)
	RJMP _0x195
_0x194:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BRNE PC+3
	JMP _0x196
; 0000 02F1 		{
; 0000 02F2 		led_red=0x00090009L;
	CALL SUBOPT_0x3A
; 0000 02F3 		led_green=0x00000000L;
; 0000 02F4 		}
; 0000 02F5 	else if(flags&0b00010000)
	RJMP _0x197
_0x196:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BRNE PC+3
	JMP _0x198
; 0000 02F6 		{
; 0000 02F7 		led_red=0x00490049L;
	__GETD1N 0x490049
	CALL SUBOPT_0x3C
; 0000 02F8 		led_green=0xffffffffL;
; 0000 02F9 		}
; 0000 02FA 		/*led_green=0x33333333L;
; 0000 02FB 		led_red=0xccccccccL;*/
; 0000 02FC 	}
_0x198:
_0x197:
_0x195:
_0x193:
_0x191:
_0x18F:
_0x18B:
; 0000 02FD 
; 0000 02FE }
_0x189:
_0x188:
_0x168:
_0x159:
	RET
; .FEND
;
;//-----------------------------------------------
;void pwr_drv(void)
; 0000 0302 {
_pwr_drv:
; .FSTART _pwr_drv
; 0000 0303 DDRD.4=1;
	SBI  0xA,4
; 0000 0304 
; 0000 0305 if(main_cnt1<150)main_cnt1++;
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CPI  R26,LOW(0x96)
	LDI  R30,HIGH(0x96)
	CPC  R27,R30
	BRLT PC+3
	JMP _0x19B
	LDI  R26,LOW(_main_cnt1)
	LDI  R27,HIGH(_main_cnt1)
	CALL SUBOPT_0x22
; 0000 0306 
; 0000 0307 if(main_cnt1<(5*TZAS))
_0x19B:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x19C
; 0000 0308 	{
; 0000 0309 	PORTD.4=1;
	SBI  0xB,4
; 0000 030A 	}
; 0000 030B else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
	RJMP _0x19F
_0x19C:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRLT PC+3
	JMP _0x1A1
	CALL SUBOPT_0xA
	CALL SUBOPT_0x3F
	BRLT PC+3
	JMP _0x1A1
	RJMP _0x1A2
_0x1A1:
	RJMP _0x1A0
_0x1A2:
; 0000 030C 	{
; 0000 030D 	PORTD.4=0;
	CBI  0xB,4
; 0000 030E 	}
; 0000 030F else if(bBL)
	RJMP _0x1A5
_0x1A0:
	SBIS 0x1E,7
	RJMP _0x1A6
; 0000 0310 	{
; 0000 0311 	PORTD.4=1;
	SBI  0xB,4
; 0000 0312 	}
; 0000 0313 else if(!bBL)
	RJMP _0x1A9
_0x1A6:
	SBIC 0x1E,7
	RJMP _0x1AA
; 0000 0314 	{
; 0000 0315 	PORTD.4=0;
	CBI  0xB,4
; 0000 0316 	}
; 0000 0317 
; 0000 0318 DDRB|=0b00000110;
_0x1AA:
_0x1A9:
_0x1A5:
_0x19F:
	IN   R30,0x4
	ORI  R30,LOW(0x6)
	OUT  0x4,R30
; 0000 0319 
; 0000 031A gran(&pwm_u,2,1020);
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL SUBOPT_0x40
; 0000 031B 
; 0000 031C 
; 0000 031D ///OCR1AL=pwm_u;
; 0000 031E /*PORTB.2=1;
; 0000 031F OCR1A=0;*/
; 0000 0320 *((short*)&OCR1AL)=pwm_u;
	CALL SUBOPT_0x41
; 0000 0321 *((short*)&OCR1AL)=pwm_u;
	CALL SUBOPT_0x41
; 0000 0322 //PORTB.2=0;
; 0000 0323 }
	RET
; .FEND
;
;//-----------------------------------------------
;void pwr_hndl(void)
; 0000 0327 {
_pwr_hndl:
; .FSTART _pwr_hndl
; 0000 0328 //vol_u_temp=800;
; 0000 0329 if(adr==63)
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3F)
	BREQ PC+3
	JMP _0x1AD
; 0000 032A         {
; 0000 032B         if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ PC+3
	JMP _0x1AE
; 0000 032C 		{
; 0000 032D 		pwm_u=950;
	LDI  R30,LOW(950)
	LDI  R31,HIGH(950)
	CALL SUBOPT_0x42
; 0000 032E 		bBL=0;
; 0000 032F 		}
; 0000 0330 	else if(flags&0b00001010)
	RJMP _0x1B1
_0x1AE:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE PC+3
	JMP _0x1B2
; 0000 0331 		{
; 0000 0332 		pwm_u=0;
	CALL SUBOPT_0x43
; 0000 0333 		bBL=1;
; 0000 0334 		}
; 0000 0335         }
_0x1B2:
_0x1B1:
; 0000 0336 else if(adr==62)
	RJMP _0x1B5
_0x1AD:
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3E)
	BREQ PC+3
	JMP _0x1B6
; 0000 0337         {
; 0000 0338         if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ PC+3
	JMP _0x1B7
; 0000 0339 		{
; 0000 033A 		pwm_u=950+_x_;
	LDS  R30,__x_
	LDS  R31,__x_+1
	SUBI R30,LOW(-950)
	SBCI R31,HIGH(-950)
	CALL SUBOPT_0x42
; 0000 033B 		bBL=0;
; 0000 033C 		}
; 0000 033D 	else if(flags&0b00001010)
	RJMP _0x1BA
_0x1B7:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE PC+3
	JMP _0x1BB
; 0000 033E 		{
; 0000 033F 		pwm_u=0;
	CALL SUBOPT_0x43
; 0000 0340 		bBL=1;
; 0000 0341 		}
; 0000 0342         }
_0x1BB:
_0x1BA:
; 0000 0343 else if(jp_mode==jp3)
	RJMP _0x1BE
_0x1B6:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x1BF
; 0000 0344 	{
; 0000 0345 	if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ PC+3
	JMP _0x1C0
; 0000 0346 		{
; 0000 0347 		pwm_u=500;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	CALL SUBOPT_0x42
; 0000 0348 		//pwm_i=0x3ff;
; 0000 0349 		bBL=0;
; 0000 034A 		}
; 0000 034B 	else if(flags&0b00001010)
	RJMP _0x1C3
_0x1C0:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE PC+3
	JMP _0x1C4
; 0000 034C 		{
; 0000 034D 		pwm_u=0;
	CALL SUBOPT_0x43
; 0000 034E 		//pwm_i=0;
; 0000 034F 		bBL=1;
; 0000 0350 		}
; 0000 0351 
; 0000 0352 	}
_0x1C4:
_0x1C3:
; 0000 0353 else if(jp_mode==jp2)
	RJMP _0x1C7
_0x1BF:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x1C8
; 0000 0354 	{
; 0000 0355 	pwm_u=0;
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
; 0000 0356 	//pwm_i=0x3ff;
; 0000 0357 	bBL=0;
	CBI  0x1E,7
; 0000 0358 	}
; 0000 0359 else if(jp_mode==jp1)
	RJMP _0x1CB
_0x1C8:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x1CC
; 0000 035A 	{
; 0000 035B 	pwm_u=0x3ff;
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	CALL SUBOPT_0x42
; 0000 035C 	//pwm_i=0x3ff;
; 0000 035D 	bBL=0;
; 0000 035E 	}
; 0000 035F 
; 0000 0360 else if(link==OFF)
	RJMP _0x1CF
_0x1CC:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ PC+3
	JMP _0x1D0
; 0000 0361 	{
; 0000 0362 	if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ PC+3
	JMP _0x1D1
; 0000 0363 		{
; 0000 0364 		pwm_u=U_AVT;
	LDI  R26,LOW(_U_AVT)
	LDI  R27,HIGH(_U_AVT)
	CALL __EEPROMRDW
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
; 0000 0365 		gran(&pwm_u,0,1020);
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x40
; 0000 0366 	    //	pwm_i=0x3ff;
; 0000 0367 		bBL=0;
	CBI  0x1E,7
; 0000 0368 		}
; 0000 0369 	else if(flags&0b00011010)
	RJMP _0x1D4
_0x1D1:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE PC+3
	JMP _0x1D5
; 0000 036A 		{
; 0000 036B 		pwm_u=0;
	CALL SUBOPT_0x43
; 0000 036C 		//pwm_i=0;
; 0000 036D 		bBL=1;
; 0000 036E 		}
; 0000 036F 	}
_0x1D5:
_0x1D4:
; 0000 0370 
; 0000 0371 else	if(link==ON)
	RJMP _0x1D8
_0x1D0:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0x1D9
; 0000 0372 	{
; 0000 0373 	if((flags&0b00100000)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ PC+3
	JMP _0x1DA
; 0000 0374 		{
; 0000 0375 		if(((flags&0b00011010)==0)||(flags&0b01000000))
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE PC+3
	JMP _0x1DC
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ PC+3
	JMP _0x1DC
	RJMP _0x1DB
_0x1DC:
; 0000 0376 			{
; 0000 0377 			pwm_u=vol_u_temp+_x_;
	LDS  R30,__x_
	LDS  R31,__x_+1
	LDS  R26,_vol_u_temp
	LDS  R27,_vol_u_temp+1
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x42
; 0000 0378 		    //	pwm_i=0x3ff;
; 0000 0379 			bBL=0;
; 0000 037A 			}
; 0000 037B 		else if(flags&0b00011010)
	RJMP _0x1E0
_0x1DB:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE PC+3
	JMP _0x1E1
; 0000 037C 			{
; 0000 037D 			pwm_u=0;
	CALL SUBOPT_0x43
; 0000 037E 			//pwm_i=0;
; 0000 037F 			bBL=1;
; 0000 0380 			}
; 0000 0381 		}
_0x1E1:
_0x1E0:
; 0000 0382 	else if(flags&0b00100000)
	RJMP _0x1E4
_0x1DA:
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE PC+3
	JMP _0x1E5
; 0000 0383 		{
; 0000 0384 		pwm_u=0;
	CALL SUBOPT_0x43
; 0000 0385 	    //	pwm_i=0;
; 0000 0386 		bBL=1;
; 0000 0387 		}
; 0000 0388 	}
_0x1E5:
_0x1E4:
; 0000 0389 //pwm_u=vol_u_temp;
; 0000 038A //pwm_u=500;
; 0000 038B //pwm_i=500;
; 0000 038C //bBL=1;
; 0000 038D }
_0x1D9:
_0x1D8:
_0x1CF:
_0x1CB:
_0x1C7:
_0x1BE:
_0x1B5:
	RET
; .FEND
;
;//-----------------------------------------------
;void JP_drv(void)
; 0000 0391 {
_JP_drv:
; .FSTART _JP_drv
; 0000 0392 
; 0000 0393 DDRB.6=1;
	SBI  0x4,6
; 0000 0394 DDRB.7=1;
	SBI  0x4,7
; 0000 0395 PORTB.6=1;
	SBI  0x5,6
; 0000 0396 PORTB.7=1;
	SBI  0x5,7
; 0000 0397 
; 0000 0398 if(PINB.6)
	SBIS 0x3,6
	RJMP _0x1F0
; 0000 0399 	{
; 0000 039A 	if(cnt_JP0<10)
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRLO PC+3
	JMP _0x1F1
; 0000 039B 		{
; 0000 039C 		cnt_JP0++;
	LDS  R30,_cnt_JP0
	SUBI R30,-LOW(1)
	STS  _cnt_JP0,R30
; 0000 039D 		}
; 0000 039E 	}
_0x1F1:
; 0000 039F else if(!PINB.6)
	RJMP _0x1F2
_0x1F0:
	SBIC 0x3,6
	RJMP _0x1F3
; 0000 03A0 	{
; 0000 03A1 	if(cnt_JP0)
	LDS  R30,_cnt_JP0
	CPI  R30,0
	BRNE PC+3
	JMP _0x1F4
; 0000 03A2 		{
; 0000 03A3 		cnt_JP0--;
	SUBI R30,LOW(1)
	STS  _cnt_JP0,R30
; 0000 03A4 		}
; 0000 03A5 	}
_0x1F4:
; 0000 03A6 
; 0000 03A7 if(PINB.7)
_0x1F3:
_0x1F2:
	SBIS 0x3,7
	RJMP _0x1F5
; 0000 03A8 	{
; 0000 03A9 	if(cnt_JP1<10)
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BRLO PC+3
	JMP _0x1F6
; 0000 03AA 		{
; 0000 03AB 		cnt_JP1++;
	LDS  R30,_cnt_JP1
	SUBI R30,-LOW(1)
	STS  _cnt_JP1,R30
; 0000 03AC 		}
; 0000 03AD 	}
_0x1F6:
; 0000 03AE else if(!PINB.7)
	RJMP _0x1F7
_0x1F5:
	SBIC 0x3,7
	RJMP _0x1F8
; 0000 03AF 	{
; 0000 03B0 	if(cnt_JP1)
	LDS  R30,_cnt_JP1
	CPI  R30,0
	BRNE PC+3
	JMP _0x1F9
; 0000 03B1 		{
; 0000 03B2 		cnt_JP1--;
	SUBI R30,LOW(1)
	STS  _cnt_JP1,R30
; 0000 03B3 		}
; 0000 03B4 	}
_0x1F9:
; 0000 03B5 
; 0000 03B6 
; 0000 03B7 if((cnt_JP0==10)&&(cnt_JP1==10))
_0x1F8:
_0x1F7:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0x1FB
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0x1FB
	RJMP _0x1FC
_0x1FB:
	RJMP _0x1FA
_0x1FC:
; 0000 03B8 	{
; 0000 03B9 	jp_mode=jp0;
	LDI  R30,LOW(0)
	STS  _jp_mode,R30
; 0000 03BA 	}
; 0000 03BB if((cnt_JP0==0)&&(cnt_JP1==10))
_0x1FA:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x1FE
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0x1FE
	RJMP _0x1FF
_0x1FE:
	RJMP _0x1FD
_0x1FF:
; 0000 03BC 	{
; 0000 03BD 	jp_mode=jp1;
	LDI  R30,LOW(1)
	STS  _jp_mode,R30
; 0000 03BE 	}
; 0000 03BF if((cnt_JP0==10)&&(cnt_JP1==0))
_0x1FD:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0x201
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x201
	RJMP _0x202
_0x201:
	RJMP _0x200
_0x202:
; 0000 03C0 	{
; 0000 03C1 	jp_mode=jp2;
	LDI  R30,LOW(2)
	STS  _jp_mode,R30
; 0000 03C2 	}
; 0000 03C3 if((cnt_JP0==0)&&(cnt_JP1==0))
_0x200:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x204
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ PC+3
	JMP _0x204
	RJMP _0x205
_0x204:
	RJMP _0x203
_0x205:
; 0000 03C4 	{
; 0000 03C5 	jp_mode=jp3;
	LDI  R30,LOW(3)
	STS  _jp_mode,R30
; 0000 03C6 	}
; 0000 03C7 
; 0000 03C8 }
_0x203:
	RET
; .FEND
;
;//-----------------------------------------------
;void adc_hndl(void)
; 0000 03CC {
_adc_hndl:
; .FSTART _adc_hndl
; 0000 03CD unsigned tempUI;
; 0000 03CE tempUI=ADCW;
	ST   -Y,R17
	ST   -Y,R16
;	tempUI -> R16,R17
	__GETWRMN 16,17,0,120
; 0000 03CF adc_buff[adc_ch][adc_cnt]=tempUI;
	CALL SUBOPT_0x44
	MOVW R26,R30
	LDS  R30,_adc_cnt
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R16
	STD  Z+1,R17
; 0000 03D0 if(adc_ch==2)
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x206
; 0000 03D1 	{
; 0000 03D2 	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
	LDS  R30,_adc_ch_2_max
	LDS  R31,_adc_ch_2_max+1
	CP   R30,R16
	CPC  R31,R17
	BRLO PC+3
	JMP _0x207
	__PUTWMRN _adc_ch_2_max,0,16,17
; 0000 03D3 	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
	RJMP _0x208
_0x207:
	LDS  R30,_adc_ch_2_min
	LDS  R31,_adc_ch_2_min+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x209
	__PUTWMRN _adc_ch_2_min,0,16,17
; 0000 03D4 	}
_0x209:
_0x208:
; 0000 03D5 
; 0000 03D6 if((adc_cnt&0x03)==0)
_0x206:
	LDS  R30,_adc_cnt
	ANDI R30,LOW(0x3)
	BREQ PC+3
	JMP _0x20A
; 0000 03D7 	{
; 0000 03D8 	char i;
; 0000 03D9 	adc_buff_[adc_ch]=0;
	SBIW R28,1
;	i -> Y+0
	CALL SUBOPT_0x45
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
; 0000 03DA 	for(i=0;i<16;i++)
	ST   Y,R30
_0x20C:
	LD   R26,Y
	CPI  R26,LOW(0x10)
	BRLO PC+3
	JMP _0x20D
; 0000 03DB 		{
; 0000 03DC 		adc_buff_[adc_ch]+=adc_buff[adc_ch][i];
	CALL SUBOPT_0x45
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	LD   R0,Z
	LDD  R1,Z+1
	CALL SUBOPT_0x44
	MOVW R26,R30
	LD   R30,Y
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	ADD  R30,R0
	ADC  R31,R1
	MOVW R26,R22
	ST   X+,R30
	ST   X,R31
; 0000 03DD 		}
_0x20B:
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RJMP _0x20C
_0x20D:
; 0000 03DE 	adc_buff_[adc_ch]>>=4;
	CALL SUBOPT_0x45
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X+
	LD   R31,X+
	CALL __LSRW4
	ST   -X,R31
	ST   -X,R30
; 0000 03DF 	}
	ADIW R28,1
; 0000 03E0 
; 0000 03E1 if(++adc_ch>=4)
_0x20A:
	LDS  R26,_adc_ch
	SUBI R26,-LOW(1)
	STS  _adc_ch,R26
	CPI  R26,LOW(0x4)
	BRSH PC+3
	JMP _0x20E
; 0000 03E2 	{
; 0000 03E3 	adc_ch=0;
	LDI  R30,LOW(0)
	STS  _adc_ch,R30
; 0000 03E4 	if(++adc_cnt>=16)
	LDS  R26,_adc_cnt
	SUBI R26,-LOW(1)
	STS  _adc_cnt,R26
	CPI  R26,LOW(0x10)
	BRSH PC+3
	JMP _0x20F
; 0000 03E5 		{
; 0000 03E6 		adc_cnt=0;
	STS  _adc_cnt,R30
; 0000 03E7 		}
; 0000 03E8 	}
_0x20F:
; 0000 03E9 DDRC&=0b11000000;
_0x20E:
	IN   R30,0x7
	ANDI R30,LOW(0xC0)
	OUT  0x7,R30
; 0000 03EA PORTC&=0b11000000;
	IN   R30,0x8
	ANDI R30,LOW(0xC0)
	OUT  0x8,R30
; 0000 03EB 
; 0000 03EC if(adc_ch==0) ADMUX=0b01000001; //ток
	LDS  R30,_adc_ch
	CPI  R30,0
	BREQ PC+3
	JMP _0x210
	LDI  R30,LOW(65)
	STS  124,R30
; 0000 03ED else if(adc_ch==1) ADMUX=0b01000100; //напр ист
	RJMP _0x211
_0x210:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x212
	LDI  R30,LOW(68)
	STS  124,R30
; 0000 03EE else if(adc_ch==2) ADMUX=0b01000010; //напр нагр
	RJMP _0x213
_0x212:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x214
	LDI  R30,LOW(66)
	STS  124,R30
; 0000 03EF else if(adc_ch==3) ADMUX=0b01000011; //темпер
	RJMP _0x215
_0x214:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x216
	LDI  R30,LOW(67)
	STS  124,R30
; 0000 03F0 
; 0000 03F1 ADCSRA=0b10100110;
_0x216:
_0x215:
_0x213:
_0x211:
	LDI  R30,LOW(166)
	STS  122,R30
; 0000 03F2 ADCSRA|=0b01000000;
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 03F3 
; 0000 03F4 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;void matemat(void)
; 0000 03F8 {
_matemat:
; .FSTART _matemat
; 0000 03F9 signed long temp_SL;
; 0000 03FA /*
; 0000 03FB #ifdef _220_
; 0000 03FC temp_SL=adc_buff_[0];
; 0000 03FD temp_SL-=K[0,0];
; 0000 03FE if(temp_SL<0) temp_SL=0;
; 0000 03FF temp_SL*=K[0,1];
; 0000 0400 temp_SL/=2400;
; 0000 0401 I=(signed int)temp_SL;
; 0000 0402 #else
; 0000 0403 */
; 0000 0404 /*
; 0000 0405 #ifdef _110_
; 0000 0406 temp_SL=adc_buff_[0];
; 0000 0407 temp_SL-=K[0,0];
; 0000 0408 if(temp_SL<0) temp_SL=0;
; 0000 0409 temp_SL*=K[0,1];
; 0000 040A temp_SL/=2400;
; 0000 040B I=(signed int)temp_SL;
; 0000 040C //I=53;
; 0000 040D #else
; 0000 040E */
; 0000 040F 
; 0000 0410 #ifdef _24_
; 0000 0411 temp_SL=adc_buff_[0];
	SBIW R28,4
;	temp_SL -> Y+0
	CALL SUBOPT_0x13
	CALL SUBOPT_0x46
; 0000 0412 temp_SL-=K[0][0];
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMRDW
	CALL SUBOPT_0x47
	CALL __SUBD21
	CALL __PUTD2S0
; 0000 0413 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRMI PC+3
	JMP _0x217
	CALL SUBOPT_0x48
; 0000 0414 temp_SL*=K[0][1];
_0x217:
	CALL SUBOPT_0x15
	CALL SUBOPT_0x47
	CALL SUBOPT_0x49
; 0000 0415 temp_SL/=400;
	__GETD1N 0x190
	CALL SUBOPT_0x4A
; 0000 0416 I=(signed int)temp_SL;
	STS  _I,R30
	STS  _I+1,R31
; 0000 0417 //I=234;
; 0000 0418 #endif
; 0000 0419 
; 0000 041A #ifdef _48/60_
; 0000 041B temp_SL=adc_buff_[0];
; 0000 041C temp_SL-=K[0][0];
; 0000 041D if(temp_SL<0) temp_SL=0;
; 0000 041E temp_SL*=K[0][1];
; 0000 041F temp_SL/=250;
; 0000 0420 I=(signed int)temp_SL;
; 0000 0421 #endif
; 0000 0422 
; 0000 0423 #ifdef _220_
; 0000 0424 temp_SL=adc_buff_[0];
; 0000 0425 temp_SL-=K[0][0];
; 0000 0426 if(temp_SL<0) temp_SL=0;
; 0000 0427 temp_SL*=K[0][1];
; 0000 0428 temp_SL/=1200;
; 0000 0429 I=(signed int)temp_SL;
; 0000 042A #endif
; 0000 042B //I=456;
; 0000 042C 
; 0000 042D #ifdef _110_
; 0000 042E temp_SL=adc_buff_[0];
; 0000 042F temp_SL-=K[0][0];
; 0000 0430 if(temp_SL<0) temp_SL=0;
; 0000 0431 temp_SL*=K[0][1];
; 0000 0432 temp_SL/=1200;
; 0000 0433 I=(signed int)temp_SL;
; 0000 0434 #endif
; 0000 0435 
; 0000 0436 
; 0000 0437 
; 0000 0438 #ifdef _24_
; 0000 0439 temp_SL=adc_buff_[1];
	__GETW1MN _adc_buff_,2
	CALL SUBOPT_0x46
; 0000 043A //temp_SL-=K[1,0];
; 0000 043B if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRMI PC+3
	JMP _0x218
	CALL SUBOPT_0x48
; 0000 043C temp_SL*=K[2][1];
_0x218:
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x47
	CALL SUBOPT_0x49
; 0000 043D temp_SL/=1000;
	CALL SUBOPT_0x4B
; 0000 043E Ui=(unsigned)temp_SL;
	STS  _Ui,R30
	STS  _Ui+1,R31
; 0000 043F #endif
; 0000 0440 
; 0000 0441 #ifdef _48/60_
; 0000 0442 temp_SL=adc_buff_[1];
; 0000 0443 //temp_SL-=K[1,0];
; 0000 0444 if(temp_SL<0) temp_SL=0;
; 0000 0445 temp_SL*=K[2][1];
; 0000 0446 temp_SL/=2000;
; 0000 0447 Ui=(unsigned)temp_SL;
; 0000 0448 #endif
; 0000 0449 
; 0000 044A #ifdef _110_
; 0000 044B temp_SL=adc_buff_[1];
; 0000 044C //temp_SL-=K[1,0];
; 0000 044D if(temp_SL<0) temp_SL=0;
; 0000 044E temp_SL*=K[2][1];
; 0000 044F temp_SL/=1000;
; 0000 0450 Ui=(unsigned)temp_SL;
; 0000 0451 #endif
; 0000 0452 
; 0000 0453 
; 0000 0454 #ifdef _220_
; 0000 0455 temp_SL=adc_buff_[1];
; 0000 0456 //temp_SL-=K[1,0];
; 0000 0457 if(temp_SL<0) temp_SL=0;
; 0000 0458 temp_SL*=K[2][1];
; 0000 0459 temp_SL/=1000;
; 0000 045A Ui=(unsigned)temp_SL;
; 0000 045B #endif
; 0000 045C 
; 0000 045D #ifdef _24_
; 0000 045E temp_SL=adc_buff_[2];
	__GETW1MN _adc_buff_,4
	CALL SUBOPT_0x46
; 0000 045F //temp_SL-=K[2,0];
; 0000 0460 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRMI PC+3
	JMP _0x219
	CALL SUBOPT_0x48
; 0000 0461 temp_SL*=K[1][1];
_0x219:
	CALL SUBOPT_0x19
	CALL SUBOPT_0x47
	CALL SUBOPT_0x49
; 0000 0462 temp_SL/=1000;
	CALL SUBOPT_0x4B
; 0000 0463 Un=(unsigned)temp_SL;
	STS  _Un,R30
	STS  _Un+1,R31
; 0000 0464 #endif
; 0000 0465 
; 0000 0466 #ifdef _48/60_
; 0000 0467 temp_SL=adc_buff_[2];
; 0000 0468 //temp_SL-=K[2,0];
; 0000 0469 if(temp_SL<0) temp_SL=0;
; 0000 046A temp_SL*=K[1][1];
; 0000 046B temp_SL/=2000;
; 0000 046C Un=(unsigned)temp_SL;
; 0000 046D #endif
; 0000 046E 
; 0000 046F #ifdef _110_
; 0000 0470 temp_SL=adc_buff_[2];
; 0000 0471 //temp_SL-=K[2,0];
; 0000 0472 if(temp_SL<0) temp_SL=0;
; 0000 0473 temp_SL*=K[1,1];
; 0000 0474 temp_SL/=1000;
; 0000 0475 Un=(unsigned)temp_SL;
; 0000 0476 #endif
; 0000 0477 
; 0000 0478 #ifdef _220_
; 0000 0479 temp_SL=adc_buff_[2];
; 0000 047A //temp_SL-=K[2,0];
; 0000 047B if(temp_SL<0) temp_SL=0;
; 0000 047C temp_SL*=K[1,1];
; 0000 047D temp_SL/=1000;
; 0000 047E Un=(unsigned)temp_SL;
; 0000 047F #endif
; 0000 0480 
; 0000 0481 
; 0000 0482 temp_SL=adc_buff_[3];
	__GETW1MN _adc_buff_,6
	CALL SUBOPT_0x46
; 0000 0483 temp_SL*=K[3][1];
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x47
	CALL SUBOPT_0x49
; 0000 0484 temp_SL/=1000;
	__GETD1N 0x3E8
	CALL __DIVD21
	CALL SUBOPT_0x4C
; 0000 0485 temp_SL-=273;
	CALL __GETD1S0
	__SUBD1N 273
	CALL SUBOPT_0x4C
; 0000 0486 if(temp_SL<=0L) temp_SL=0L;
	CALL __GETD2S0
	CALL __CPD02
	BRGE PC+3
	JMP _0x21A
	CALL SUBOPT_0x48
; 0000 0487 if(temp_SL>100) temp_SL=100L;
_0x21A:
	CALL __GETD2S0
	__CPD2N 0x65
	BRGE PC+3
	JMP _0x21B
	__GETD1N 0x64
	CALL SUBOPT_0x4C
; 0000 0488 
; 0000 0489 T=(signed)temp_SL;
_0x21B:
	LD   R30,Y
	LDD  R31,Y+1
	STS  _T,R30
	STS  _T+1,R31
; 0000 048A 
; 0000 048B 
; 0000 048C 
; 0000 048D Udb=flags;
	LDS  R30,_flags
	LDI  R31,0
	STS  _Udb,R30
	STS  _Udb+1,R31
; 0000 048E 
; 0000 048F 
; 0000 0490 
; 0000 0491 }
	ADIW R28,4
	RET
; .FEND
;
;//***********************************************
;//***********************************************
;//***********************************************
;//***********************************************
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0498 {
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
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
; 0000 0499 t0_init();
	CALL _t0_init
; 0000 049A 
; 0000 049B can_hndl1();
	CALL _can_hndl1
; 0000 049C 
; 0000 049D if(++t0_cnt4>=10)
	INC  R7
	LDI  R30,LOW(10)
	CP   R7,R30
	BRSH PC+3
	JMP _0x21C
; 0000 049E 	{
; 0000 049F 	t0_cnt4=0;
	CLR  R7
; 0000 04A0 //	b100Hz=1;
; 0000 04A1 
; 0000 04A2 
; 0000 04A3 if(++t0_cnt0>=10)
	INC  R3
	CP   R3,R30
	BRSH PC+3
	JMP _0x21D
; 0000 04A4 	{
; 0000 04A5 	t0_cnt0=0;
	CLR  R3
; 0000 04A6 	b10Hz=1;
	SBI  0x1E,3
; 0000 04A7 	}
; 0000 04A8 if(++t0_cnt3>=3)
_0x21D:
	INC  R4
	LDI  R30,LOW(3)
	CP   R4,R30
	BRSH PC+3
	JMP _0x220
; 0000 04A9 	{
; 0000 04AA 	t0_cnt3=0;
	CLR  R4
; 0000 04AB 	b33Hz=1;
	SBI  0x1E,2
; 0000 04AC 	}
; 0000 04AD if(++t0_cnt1>=20)
_0x220:
	INC  R2
	LDI  R30,LOW(20)
	CP   R2,R30
	BRSH PC+3
	JMP _0x223
; 0000 04AE 	{
; 0000 04AF 	t0_cnt1=0;
	CLR  R2
; 0000 04B0 	b5Hz=1;
	SBI  0x1E,4
; 0000 04B1      bFl_=!bFl_;
	SBIS 0x1E,6
	RJMP _0x226
	CBI  0x1E,6
	RJMP _0x227
_0x226:
	SBI  0x1E,6
_0x227:
; 0000 04B2 	}
; 0000 04B3 if(++t0_cnt2>=100)
_0x223:
	INC  R5
	LDI  R30,LOW(100)
	CP   R5,R30
	BRSH PC+3
	JMP _0x228
; 0000 04B4 	{
; 0000 04B5 	t0_cnt2=0;
	CLR  R5
; 0000 04B6 	b1Hz=1;
	SBI  0x1E,5
; 0000 04B7 	}
; 0000 04B8 }
_0x228:
; 0000 04B9 }
_0x21C:
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
; .FEND
;
;
;//===============================================
;//===============================================
;//===============================================
;//===============================================
;void main(void)
; 0000 04C1 {
_main:
; .FSTART _main
; 0000 04C2 
; 0000 04C3 DDRD.2=1;
	SBI  0xA,2
; 0000 04C4 PORTD.2=1;
	SBI  0xB,2
; 0000 04C5 
; 0000 04C6 DDRB.0=1;
	SBI  0x4,0
; 0000 04C7 PORTB.0=0;
	CBI  0x5,0
; 0000 04C8 
; 0000 04C9 PORTB.2=1;
	SBI  0x5,2
; 0000 04CA DDRB.2=1;
	SBI  0x4,2
; 0000 04CB 
; 0000 04CC DDRB|=0b00110110;
	IN   R30,0x4
	ORI  R30,LOW(0x36)
	OUT  0x4,R30
; 0000 04CD 
; 0000 04CE TCCR1A=0x83;
	LDI  R30,LOW(131)
	STS  128,R30
; 0000 04CF TCCR1B=0x09;
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 04D0 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 04D1 TCNT1L=0x00;
	STS  132,R30
; 0000 04D2 OCR1AH=0x00;
	STS  137,R30
; 0000 04D3 OCR1AL=0x00;
	STS  136,R30
; 0000 04D4 OCR1BH=0x00;
	STS  139,R30
; 0000 04D5 OCR1BL=0x00;
	STS  138,R30
; 0000 04D6 
; 0000 04D7 SPCR=0x5D;
	LDI  R30,LOW(93)
	OUT  0x2C,R30
; 0000 04D8 SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 04D9 
; 0000 04DA 
; 0000 04DB delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04DC delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04DD delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04DE delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04DF delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04E0 adr_hndl();
	CALL _adr_hndl
; 0000 04E1 
; 0000 04E2 if(adr==100)
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x64)
	BREQ PC+3
	JMP _0x237
; 0000 04E3 	{
; 0000 04E4 	adr_hndl();
	CALL _adr_hndl
; 0000 04E5 	delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04E6 	}
; 0000 04E7 if(adr==100)
_0x237:
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x64)
	BREQ PC+3
	JMP _0x238
; 0000 04E8 	{
; 0000 04E9 	adr_hndl();
	CALL _adr_hndl
; 0000 04EA 	delay_ms(100);
	CALL SUBOPT_0x8
; 0000 04EB 	}
; 0000 04EC 
; 0000 04ED t0_init();
_0x238:
	CALL _t0_init
; 0000 04EE 
; 0000 04EF 
; 0000 04F0 
; 0000 04F1 link_cnt=0;
	CALL SUBOPT_0x10
; 0000 04F2 link=ON;
; 0000 04F3 
; 0000 04F4 main_cnt1=0;
	LDI  R30,LOW(0)
	STS  _main_cnt1,R30
	STS  _main_cnt1+1,R30
; 0000 04F5 //_x_ee_=20;
; 0000 04F6 _x_=_x_ee_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	STS  __x_,R30
	STS  __x_+1,R31
; 0000 04F7 
; 0000 04F8 if((_x_>XMAX)||(_x_<-XMAX))_x_=0;
	LDS  R26,__x_
	LDS  R27,__x_+1
	SBIW R26,26
	BRLT PC+3
	JMP _0x23A
	LDS  R26,__x_
	LDS  R27,__x_+1
	CPI  R26,LOW(0xFFE7)
	LDI  R30,HIGH(0xFFE7)
	CPC  R27,R30
	BRGE PC+3
	JMP _0x23A
	RJMP _0x239
_0x23A:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
; 0000 04F9 
; 0000 04FA if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;
_0x239:
	CALL SUBOPT_0xA
	CPI  R30,0
	BRSH PC+3
	JMP _0x23D
	CALL SUBOPT_0xA
	CPI  R30,LOW(0x4)
	BRLO PC+3
	JMP _0x23D
	RJMP _0x23C
_0x23D:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	LDI  R30,LOW(3)
	CALL __EEPROMWRB
; 0000 04FB 
; 0000 04FC #asm("sei")
_0x23C:
	sei
; 0000 04FD granee(&K[0][1],420,1100);
	__POINTW1MN _K,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(420)
	LDI  R31,HIGH(420)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1100)
	LDI  R27,HIGH(1100)
	CALL _granee
; 0000 04FE 
; 0000 04FF #ifdef _220_
; 0000 0500 granee(&K[1,1],4500,5500);
; 0000 0501 granee(&K[2,1],4500,5500);
; 0000 0502 #else
; 0000 0503 #ifdef _110_
; 0000 0504 granee(&K[1,1],2200,3500);
; 0000 0505 granee(&K[2,1],2200,3500);
; 0000 0506 #ifdef _48/60_
; 0000 0507 granee(&K[1,1],1000,5500);
; 0000 0508 granee(&K[2,1],1000,5500);
; 0000 0509 #else
; 0000 050A granee(&K[1,1],1360,1700);
; 0000 050B granee(&K[2,1],1360,1700);
; 0000 050C #endif
; 0000 050D #endif
; 0000 050E #endif
; 0000 050F //granee(&K[1,1],1510,1850);
; 0000 0510 //granee(&K[2,1],1510,1850);
; 0000 0511 DDRD.2=1;
	SBI  0xA,2
; 0000 0512 PORTD.2=0;
	CBI  0xB,2
; 0000 0513 delay_ms(100);
	CALL SUBOPT_0x8
; 0000 0514 PORTD.2=1;
	SBI  0xB,2
; 0000 0515 can_init1();
	CALL _can_init1
; 0000 0516 
; 0000 0517 while (1)
_0x245:
; 0000 0518 	{
; 0000 0519 	if(bIN1)
	LDS  R30,_bIN1
	CPI  R30,0
	BRNE PC+3
	JMP _0x248
; 0000 051A 		{
; 0000 051B 		bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
; 0000 051C 
; 0000 051D 		can_in_an1();
	CALL _can_in_an1
; 0000 051E 		}
; 0000 051F 
; 0000 0520 /*	if(b100Hz)
; 0000 0521 		{
; 0000 0522 		b100Hz=0;
; 0000 0523 		}*/
; 0000 0524 	if(b33Hz)
_0x248:
	SBIS 0x1E,2
	RJMP _0x249
; 0000 0525 		{
; 0000 0526 		b33Hz=0;
	CBI  0x1E,2
; 0000 0527                 adc_hndl();
	CALL _adc_hndl
; 0000 0528 		}
; 0000 0529 	if(b10Hz)
_0x249:
	SBIS 0x1E,3
	RJMP _0x24C
; 0000 052A 		{
; 0000 052B 		b10Hz=0;
	CBI  0x1E,3
; 0000 052C                 matemat();
	CALL _matemat
; 0000 052D 	    	led_drv();
	CALL _led_drv
; 0000 052E 	        link_drv();
	CALL _link_drv
; 0000 052F 	        pwr_hndl();
	CALL _pwr_hndl
; 0000 0530 	        JP_drv();
	CALL _JP_drv
; 0000 0531 	        flags_drv();
	CALL _flags_drv
; 0000 0532 		}
; 0000 0533 	if(b5Hz)
_0x24C:
	SBIS 0x1E,4
	RJMP _0x24F
; 0000 0534 		{
; 0000 0535 		b5Hz=0;
	CBI  0x1E,4
; 0000 0536  	        pwr_drv();
	CALL _pwr_drv
; 0000 0537  		led_hndl();
	CALL _led_hndl
; 0000 0538 		}
; 0000 0539     	if(b1Hz)
_0x24F:
	SBIS 0x1E,5
	RJMP _0x252
; 0000 053A 		{
; 0000 053B 		b1Hz=0;
	CBI  0x1E,5
; 0000 053C 		temper_drv();
	CALL _temper_drv
; 0000 053D 		u_drv();
	CALL _u_drv
; 0000 053E                 x_drv();
	CALL _x_drv
; 0000 053F 
; 0000 0540                 if(main_cnt<1000)main_cnt++;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRLT PC+3
	JMP _0x255
	LDI  R26,LOW(_main_cnt)
	LDI  R27,HIGH(_main_cnt)
	CALL SUBOPT_0x22
; 0000 0541   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
_0x255:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE PC+3
	JMP _0x257
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x257
	RJMP _0x256
_0x257:
	CALL _apv_hndl
; 0000 0542 
; 0000 0543   		can_error_cnt++;
_0x256:
	LDS  R30,_can_error_cnt
	SUBI R30,-LOW(1)
	STS  _can_error_cnt,R30
; 0000 0544   		if(can_error_cnt>=10)
	LDS  R26,_can_error_cnt
	CPI  R26,LOW(0xA)
	BRSH PC+3
	JMP _0x259
; 0000 0545   			{
; 0000 0546   			can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
; 0000 0547   			DDRD.2=1;
	SBI  0xA,2
; 0000 0548 			PORTD.2=0;
	CBI  0xB,2
; 0000 0549 			delay_ms(100);
	CALL SUBOPT_0x8
; 0000 054A 			PORTD.2=1;
	SBI  0xB,2
; 0000 054B 
; 0000 054C 			can_init1();
	CALL _can_init1
; 0000 054D   			}
; 0000 054E   		//can_transmit1(adr,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/ ...
; 0000 054F 		//can_transmit1(adr,PUTTM2,T,0,flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_int[2]/*rotor_int*/)+ ...
; 0000 0550 
; 0000 0551 		if((adr==62)||(adr==63))
_0x259:
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3E)
	BRNE PC+3
	JMP _0x261
	CALL SUBOPT_0x9
	CPI  R30,LOW(0x3F)
	BRNE PC+3
	JMP _0x261
	RJMP _0x260
_0x261:
; 0000 0552 		        {
; 0000 0553 		        can_transmit1(adr-62,0x33,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int ...
	CALL SUBOPT_0x9
	SUBI R30,LOW(62)
	ST   -Y,R30
	LDI  R30,LOW(51)
	CALL SUBOPT_0xD
; 0000 0554 	                can_transmit1(adr-62,0x34,T,0,flags,(char) _x_,*((char*)&plazma_int[2]/*rotor_int*/),*(((char*)&plazma_ ...
	SUBI R30,LOW(62)
	ST   -Y,R30
	LDI  R30,LOW(52)
	CALL SUBOPT_0xE
; 0000 0555 		        }
; 0000 0556 
; 0000 0557 		if(link_cnt63<20)link_cnt63++;
_0x260:
	LDS  R26,_link_cnt63
	CPI  R26,LOW(0x14)
	BRLO PC+3
	JMP _0x263
	LDS  R30,_link_cnt63
	SUBI R30,-LOW(1)
	STS  _link_cnt63,R30
; 0000 0558 
; 0000 0559  		}
_0x263:
; 0000 055A      #asm("wdr")
_0x252:
	wdr
; 0000 055B 	}
	RJMP _0x245
_0x247:
; 0000 055C }
_0x264:
	RJMP _0x264
; .FEND
;#include "curr_version.h"
;
;const short HARDVARE_VERSION = 21;

	.DSEG
;const short SOFT_VERSION = 9;
;const short BUILD = 9;
;const short BUILD_YEAR = 2023;
;const short BUILD_MONTH = 9;
;const short BUILD_DAY = 26;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_spi:
; .FSTART _spi
	ST   -Y,R26
	LD   R30,Y
	OUT  0x2E,R30
_0x2040003:
	IN   R30,0x2D
	SBRC R30,7
	RJMP _0x2040005
	RJMP _0x2040003
_0x2040005:
	IN   R30,0x2E
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.DSEG
_adc_buff:
	.BYTE 0x80
_adc_buff_:
	.BYTE 0x8
_adc_cnt:
	.BYTE 0x1
_adc_ch:
	.BYTE 0x1

	.ESEG
_K:
	.BYTE 0x10

	.DSEG
_I:
	.BYTE 0x2
_Un:
	.BYTE 0x2
_Ui:
	.BYTE 0x2
_Udb:
	.BYTE 0x2
_T:
	.BYTE 0x2
_flags:
	.BYTE 0x1
_flags_tu:
	.BYTE 0x1
_vol_u_temp:
	.BYTE 0x2
_vol_i_temp:
	.BYTE 0x2
_led_red:
	.BYTE 0x4
_led_green:
	.BYTE 0x4
_link:
	.BYTE 0x1
_link_cnt:
	.BYTE 0x1
_led_drv_cnt:
	.BYTE 0x1

	.ESEG
_Umax:
	.BYTE 0x2
_dU:
	.BYTE 0x2
_tmax:
	.BYTE 0x2
_tsign:
	.BYTE 0x2

	.DSEG
_tsign_cnt:
	.BYTE 0x2
_tmax_cnt:
	.BYTE 0x2
_pwm_u:
	.BYTE 0x2
_umax_cnt:
	.BYTE 0x2
_umin_cnt:
	.BYTE 0x2
_flags_tu_cnt_off:
	.BYTE 0x1

	.ESEG
_adr:
	.BYTE 0x1

	.DSEG
_cnt_JP0:
	.BYTE 0x1
_cnt_JP1:
	.BYTE 0x1
_jp_mode:
	.BYTE 0x1
_main_cnt1:
	.BYTE 0x2
__x_:
	.BYTE 0x2

	.ESEG
__x_ee_:
	.BYTE 0x2
_U_AVT:
	.BYTE 0x2

	.DSEG
_main_cnt:
	.BYTE 0x2

	.ESEG
_TZAS:
	.BYTE 0x1

	.DSEG
_plazma_int:
	.BYTE 0x6
_adc_ch_2_max:
	.BYTE 0x2
_adc_ch_2_min:
	.BYTE 0x2
_adc_ch_2_delta:
	.BYTE 0x1
_cnt_adc_ch_2_delta:
	.BYTE 0x1
_apv_cnt:
	.BYTE 0x3
_apv_cnt_:
	.BYTE 0x2
_cnt_apv_off:
	.BYTE 0x1

	.ESEG
_res_fl:
	.BYTE 0x1
_res_fl_:
	.BYTE 0x1

	.DSEG
_res_fl_cnt:
	.BYTE 0x1
_off_bp_cnt:
	.BYTE 0x1
_can_error_cnt:
	.BYTE 0x1
_link_cnt63:
	.BYTE 0x1
_HARDVARE_VERSION:
	.BYTE 0x2
_SOFT_VERSION:
	.BYTE 0x2
_BUILD:
	.BYTE 0x2
_BUILD_YEAR:
	.BYTE 0x2
_BUILD_MONTH:
	.BYTE 0x2
_BUILD_DAY:
	.BYTE 0x2
_can_st1:
	.BYTE 0x1
_can_st_old1:
	.BYTE 0x1
_RXBUFF1:
	.BYTE 0x28
_bIN1:
	.BYTE 0x1
_can_out_buff:
	.BYTE 0x20
_can_buff_wr_ptr:
	.BYTE 0x1
_can_buff_rd_ptr:
	.BYTE 0x1
_rotor_int:
	.BYTE 0x2
_led_red_buff_S0000019000:
	.BYTE 0x4
_led_green_buff_S0000019000:
	.BYTE 0x4
_flags_old_S000001A000:
	.BYTE 0x1
__seed_G105:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x0:
	IN   R30,0x4
	ORI  R30,LOW(0x2C)
	OUT  0x4,R30
	CBI  0x4,4
	SBI  0x4,0
	CBI  0x5,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	CALL _spi
	LDD  R26,Y+1
	JMP  _spi

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x2:
	LDS  R30,_can_buff_wr_ptr
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(10)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4:
	ST   -Y,R30
	LDI  R26,LOW(255)
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	ST   -Y,R30
	LDI  R26,LOW(192)
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6:
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	ST   -Y,R30
	LDI  R26,LOW(49)
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(100)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 28 TIMES, CODE SIZE REDUCTION:51 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(_adr)
	LDI  R27,HIGH(_adr)
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB:
	__GETB2MN _RXBUFF1,5
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0xC:
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0xD:
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
	__GETB2MN _Ui,1
	CALL _can_transmit1
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0xE:
	ST   -Y,R30
	LDS  R30,_T
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,_flags
	ST   -Y,R30
	LDS  R30,__x_
	ST   -Y,R30
	__GETB1MN _plazma_int,4
	ST   -Y,R30
	__GETB2MN _plazma_int,5
	JMP  _can_transmit1

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(0)
	STS  _link_cnt,R30
	LDI  R30,LOW(85)
	STS  _link,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMRDB
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x12:
	LDI  R26,LOW(_rotor_int)
	LDI  R27,HIGH(_rotor_int)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	LDS  R30,_adc_buff_
	LDS  R31,_adc_buff_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x15:
	__POINTW2MN _K,2
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x18:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x19:
	__POINTW2MN _K,6
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1A:
	__POINTW2MN _K,10
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1B:
	__POINTW2MN _K,14
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1C:
	CALL __EEPROMRDW
	MOVW R22,R30
	__GETB2MN _RXBUFF1,4
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1D:
	__GETB2MN _RXBUFF1,3
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	__GETB2MN _RXBUFF1,6
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1F:
	__GETB2MN _RXBUFF1,5
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	LDI  R26,LOW(_tsign)
	LDI  R27,HIGH(_tsign)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:66 WORDS
SUBOPT_0x21:
	LDS  R30,_flags
	ANDI R30,LOW(0xE1)
	STS  _flags,R30
	LDI  R30,LOW(0)
	STS  _tsign_cnt,R30
	STS  _tsign_cnt+1,R30
	STS  _tmax_cnt,R30
	STS  _tmax_cnt+1,R30
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x22:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x23:
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x24:
	STS  _led_red_buff_S0000019000,R30
	STS  _led_red_buff_S0000019000+1,R31
	STS  _led_red_buff_S0000019000+2,R22
	STS  _led_red_buff_S0000019000+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x25:
	STS  _led_green_buff_S0000019000,R30
	STS  _led_green_buff_S0000019000+1,R31
	STS  _led_green_buff_S0000019000+2,R22
	STS  _led_green_buff_S0000019000+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x26:
	STS  124,R30
	LDI  R30,LOW(166)
	STS  122,R30
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x27:
	LDS  R26,120
	LDS  R27,120+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x28:
	CALL SUBOPT_0x27
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL __DIVW21U
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x29:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2A:
	LDI  R30,LOW(0)
	STS  _cnt_adc_ch_2_delta,R30
	LDI  R30,LOW(30)
	STS  _led_drv_cnt,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDS  R26,_umin_cnt
	LDS  R27,_umin_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	LDS  R26,_umax_cnt
	LDS  R27,_umax_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2D:
	LDS  R26,_T
	LDS  R27,_T+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2E:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(60)
	LDI  R27,0
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2F:
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x30:
	LDI  R30,LOW(_umax_cnt)
	LDI  R31,HIGH(_umax_cnt)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _gran
	CALL SUBOPT_0x2C
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x31:
	LDI  R30,LOW(_umin_cnt)
	LDI  R31,HIGH(_umin_cnt)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _gran
	CALL SUBOPT_0x2B
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:51 WORDS
SUBOPT_0x32:
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:88 WORDS
SUBOPT_0x33:
	LDI  R30,LOW(0)
	STS  _led_red,R30
	STS  _led_red+1,R30
	STS  _led_red+2,R30
	STS  _led_red+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x34:
	__GETD1N 0x3030303
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x35:
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,-LOW(100)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:107 WORDS
SUBOPT_0x36:
	__GETD1N 0xFFFFFFFF
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x37:
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:67 WORDS
SUBOPT_0x38:
	__GETD1N 0x10001
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:60 WORDS
SUBOPT_0x39:
	LDI  R30,LOW(0)
	STS  _led_green,R30
	STS  _led_green+1,R30
	STS  _led_green+2,R30
	STS  _led_green+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x3A:
	__GETD1N 0x90009
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RJMP SUBOPT_0x39

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x3B:
	__GETD1N 0xFFFFFFFE
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x3C:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RJMP SUBOPT_0x36

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3D:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RJMP SUBOPT_0x39

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3E:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3F:
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	SUBI R30,-LOW(70)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x40:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1020)
	LDI  R27,HIGH(1020)
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x41:
	LDS  R30,_pwm_u
	LDS  R31,_pwm_u+1
	STS  136,R30
	STS  136+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x42:
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
	CBI  0x1E,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x43:
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
	SBI  0x1E,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x44:
	LDS  R30,_adc_ch
	LDI  R31,0
	LSL  R30
	ROL  R31
	CALL __LSLW4
	SUBI R30,LOW(-_adc_buff)
	SBCI R31,HIGH(-_adc_buff)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x45:
	LDS  R30,_adc_ch
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x46:
	CLR  R22
	CLR  R23
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x47:
	CALL __GETD2S0
	CALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x48:
	LDI  R30,LOW(0)
	CALL __CLRD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x49:
	CALL __MULD12
	CALL __PUTD1S0
	CALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4A:
	CALL __DIVD21
	CALL __PUTD1S0
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	__GETD1N 0x3E8
	RJMP SUBOPT_0x4A

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4C:
	CALL __PUTD1S0
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__SUBD21:
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
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
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
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
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
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

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTD2S0:
	ST   Y,R26
	STD  Y+1,R27
	STD  Y+2,R24
	STD  Y+3,R25
	RET

__CLRD1S0:
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
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
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
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

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
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

;END OF CODE MARKER
__END_OF_CODE:
