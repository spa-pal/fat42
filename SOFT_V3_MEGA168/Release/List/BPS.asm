
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
	.DEF _t0_cnt0=R7
	.DEF _t0_cnt1=R6
	.DEF _t0_cnt2=R9
	.DEF _t0_cnt3=R8
	.DEF _t0_cnt4=R11
	.DEF _cnt_ind=R10
	.DEF _adc_cnt0=R13
	.DEF _adc_cnt1=R12

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

_0x3:
	.DB  0x0,0x0,0x48,0x0,0x7D,0x0,0xB1,0x0
	.DB  0xD9,0x0,0xFE,0x0,0x1E,0x1,0x3E,0x1
	.DB  0x5A,0x1,0x74,0x1,0x90,0x1,0xAB,0x1
	.DB  0xC5,0x1,0xDE,0x1,0xF6,0x1,0xD,0x2
_0x4:
	.DB  0x3,0x3,0x3,0x3
_0x5:
	.DB  0x1E
_0x6:
	.DB  0x32
_0x7:
	.DB  0x32
_0x8:
	.DB  0xBC,0x2
_0x46:
	.DB  0x7B
_0x20A0060:
	.DB  0x1
_0x20A0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  _led_green
	.DW  _0x4*2

	.DW  0x01
	.DW  _led_drv_cnt
	.DW  _0x5*2

	.DW  0x01
	.DW  _pwm_u
	.DW  _0x6*2

	.DW  0x01
	.DW  _pwm_i
	.DW  _0x7*2

	.DW  0x02
	.DW  _volum_u_main_
	.DW  _0x8*2

	.DW  0x01
	.DW  _rotor_int
	.DW  _0x46*2

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
;#include <mega168.h>
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
;#include "mega168_bits.h"
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
;#define VENT_RES 0x64
;//#define Zero_kf2 0x64
;#define MEM_KF 0x62
;#define MEM_KF1 0x26
;#define MEM_KF4 0x29
;#define MEM_KF2 0x27
;#define BLKON 0x80
;#define BLKOFF 0x81
;//#define Put_reg 0x90
;#define GETID 0x90
;#define PUTID 0x91
;#define PUTTM1 0xDA
;#define PUTTM2 0xDB
;#define PUTTM 0xDE
;#define GETTM 0xED
;#define KLBR 0xEE
;#define XMAX 25
;
;#include <stdio.h>
;#include <math.h>
;
;#define ON 0x55
;#define OFF 0xaa
;
;#define BLOCK_INIT  DDRD.4=1;
;#define BLOCK_ON 	{PORTD.4=1;bVENT_BLOCK=1;}
;#define BLOCK_OFF 	{PORTD.4=0;bVENT_BLOCK=0;}
;#define BLOCK_IS_ON (PIND.4==1)
;
;#define _220_
;//#define _24_
;
;bit bJP; //джампер одет
;bit b100Hz;
;bit b33Hz;
;bit b10Hz;
;bit b5Hz;
;bit b1Hz;
;bit bFl_;
;bit bBL;
;bit bBL_IPS=0;
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
;unsigned int adc_buff[5][16],adc_buff_[5];
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
;unsigned int  vol_u_temp,vol_i_temp;
;//Управление светодиодами
;long led_red=0x00000000L;
;long led_green=0x03030303L;
;char led_drv_cnt=30;
;long led_red_buff;
;long led_green_buff;
;char link;
;short link_cnt;
;eeprom signed int Umax_,dU_,tmax_,tsign_;
;signed tsign_cnt,tmax_cnt;
;unsigned int pwm_u=50,pwm_i=50;
;signed umax_cnt,umin_cnt;
;char flags_tu_cnt_on,flags_tu_cnt_off;
;char adr_new,adr_old,adr_temp,adr_cnt;
;//eeprom char adr;
;char cnt_JP0,cnt_JP1;
;enum {jp0,jp1,jp2,jp3} jp_mode;
;int main_cnt1;
;signed _x_,_x__;
;int _x_cnt;
;eeprom signed _x_ee_;
;eeprom int U_AVT_;
;eeprom char U_AVT_ON_;
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
;char bAPV;
;char cnt_apv_off;
;
;eeprom char res_fl,res_fl_;
;char bRES=0;
;char bRES_=0;
;char res_fl_cnt;
;char off_bp_cnt;
;//eeprom char adr_ee;
;
;flash char CONST_ADR[]={0b00000111,0b00000111,0b00000111,0b00000010,0b00000011,0b00000001,0b00000000,0b00000111};
;
;char can_error_cnt;
;
;
;char adr_drv_stat=0;
;char adr[3],adress;
;char adress_error;
;
;enum {bpsIBEP,bpsIPS,bpsIBEP_AVT} bps_class;
;
;eeprom signed short ee_TZAS;
;eeprom signed short ee_Umax;
;eeprom signed short ee_dU;
;eeprom signed short ee_tmax;
;eeprom signed short ee_tsign;
;eeprom signed short ee_U_AVT;
;eeprom int ee_AVT_MODE;			//какой-то переключатель, переключается последним байтом в посылке с MEM_KF
;eeprom signed short ee_DEVICE;	//переключатель, переключается MEM_KF4 или MEM_KF1, MEM_KF4 устанавливает его в 1
;							// и означает что это БПС неибэпный, включается и выключается только по команде,
;							//никакие TZAS, U_AVT не работают
;eeprom short ee_IMAXVENT;
;
;bit bMAIN;
;
;short vent_pwm;
;char bVENT_BLOCK=0;
;signed short plazmaSS;
;char cnt_net_drv;
;
;//Наработка вентилятора
;eeprom unsigned short vent_resurs;
;unsigned short vent_resurs_sec_cnt;
;//#define VENT_RESURS_SEC_IN_HOUR	3600
;#define VENT_RESURS_SEC_IN_HOUR	3600
;unsigned char vent_resurs_buff[4];
;unsigned char vent_resurs_tx_cnt;
;
;eeprom int UU_AVT;
;signed short volum_u_main_=700;
;signed short x[6];
;signed short i_main[6];
;char i_main_flag[6];
;signed short i_main_avg;
;char i_main_num_of_bps;
;signed short i_main_sigma;
;char i_main_bps_cnt[6];
;unsigned short vol_i_temp_avar=0;
;
;//eeprom short AVT_MODE;
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
	RJMP _0x20C0004
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
_0x20C0004:
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
	RJMP _0x20C0003
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
	BRNE _0x3F
	LDI  R30,LOW(129)
	RJMP _0x3B8
_0x3F:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x41
	LDI  R30,LOW(130)
	RJMP _0x3B8
_0x41:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x43
	LDI  R30,LOW(132)
_0x3B8:
	ST   Y,R30
_0x43:
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
; 0000 00B9 {

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
	BRLO _0x48
	CPI  R26,LOW(0x4)
	BRLO _0x47
_0x48:
	LDI  R30,LOW(0)
	STS  _can_buff_wr_ptr,R30
;
;can_out_buff[0][can_buff_wr_ptr]=data0;
_0x47:
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
	BRLO _0x4A
	LDI  R30,LOW(0)
	STS  _can_buff_wr_ptr,R30
;}
_0x4A:
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
	BREQ _0x4B
;	{
;	spi_bit_modify(CANCTRL,0xe0,0x80);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(224)
	ST   -Y,R30
	LDI  R26,LOW(128)
	RCALL _spi_bit_modify
;	}
;delay_us(10);
_0x4B:
	__DELAY_USB 27
;spi_write(CNF1,CNF1_init);
	LDI  R30,LOW(42)
	ST   -Y,R30
	LDI  R26,LOW(195)
	RCALL _spi_write
;spi_write(CNF2,CNF2_init);
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R26,LOW(254)
	RCALL _spi_write
;spi_write(CNF3,CNF3_init);
	LDI  R30,LOW(40)
	ST   -Y,R30
	LDI  R26,LOW(3)
	RCALL _spi_write
;
;spi_write(RXB0CTRL,0b00100000);
	LDI  R30,LOW(96)
	ST   -Y,R30
	LDI  R26,LOW(32)
	RCALL _spi_write
;spi_write(RXB1CTRL,0b00100000);
	LDI  R30,LOW(112)
	ST   -Y,R30
	LDI  R26,LOW(32)
	RCALL _spi_write
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
	RCALL _spi_write
;
;spi_write(RXF2SIDH, 0x13);
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R26,LOW(19)
	RCALL _spi_write
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
	RCALL _spi_write
;delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
;spi_write(BFPCTRL,0b00000000);
	LDI  R30,LOW(12)
	CALL SUBOPT_0x6
;
;}
_0x20C0003:
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
	RCALL _spi_read_status
	STS  _can_st1,R30
;can_st_old1|=can_st1;
	LDS  R26,_can_st_old1
	OR   R30,R26
	STS  _can_st_old1,R30
;
;if(can_st1&0b00000010)
	LDS  R30,_can_st1
	ANDI R30,LOW(0x2)
	BREQ _0x4C
;	{
;
;	for(j=0;j<8;j++)
	LDI  R16,LOW(0)
_0x4E:
	CPI  R16,8
	BRSH _0x4F
;		{
;		RXBUFF1[j]=spi_read(RXB1D0+j);
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
;		}
	SUBI R16,-1
	RJMP _0x4E
_0x4F:
;
;	spi_bit_modify(CANINTF,0b00000010,0x00);
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _spi_bit_modify
;     bIN1=1;
	LDI  R30,LOW(1)
	STS  _bIN1,R30
;	}
;
;
;else if(/*(can_st1&0b10101000)&&*/(!(can_st1&0b01010100)))
	RJMP _0x50
_0x4C:
	LDS  R30,_can_st1
	ANDI R30,LOW(0x54)
	BRNE _0x51
;	{
;	char n;
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
	BREQ _0x52
;     	{
;         	for(n=0;n<8;n++)
	LDI  R30,LOW(0)
	ST   Y,R30
_0x54:
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRSH _0x55
;			{
;			spi_write(TXB0D0+n,can_out_buff[n][can_buff_rd_ptr]);
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
	RCALL _spi_write
;			}
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RJMP _0x54
_0x55:
;    		spi_write(TXB0DLC,8);
	LDI  R30,LOW(53)
	ST   -Y,R30
	LDI  R26,LOW(8)
	CALL _spi_write
;    		spi_rts(0);
	LDI  R26,LOW(0)
	RCALL _spi_rts
;
;    		can_buff_rd_ptr++;
	LDS  R30,_can_buff_rd_ptr
	SUBI R30,-LOW(1)
	STS  _can_buff_rd_ptr,R30
;    		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
	LDS  R26,_can_buff_rd_ptr
	CPI  R26,LOW(0x4)
	BRLO _0x56
	LDI  R30,LOW(0)
	STS  _can_buff_rd_ptr,R30
;    		}
_0x56:
; 	}
_0x52:
	ADIW R28,1
;
;#asm("sei")
_0x51:
_0x50:
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
	BRNE _0x58
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0x2)
	BRNE _0x58
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x3)
	BRNE _0x58
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x4)
	BRNE _0x58
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x5)
	BRNE _0x58
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x6)
	BRNE _0x58
	__GETB2MN _RXBUFF1,6
	CPI  R26,LOW(0x7)
	BRNE _0x58
	__GETB2MN _RXBUFF1,7
	CPI  R26,LOW(0x8)
	BREQ _0x59
_0x58:
	RJMP _0x57
_0x59:
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
	RCALL _can_transmit1
;
;
;if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==GETTM))
_0x57:
	CALL SUBOPT_0x8
	BRNE _0x5B
	CALL SUBOPT_0x9
	BRNE _0x5B
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xED)
	BREQ _0x5C
_0x5B:
	RJMP _0x5A
_0x5C:
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
	BREQ _0x5D
; 		{
; 		if(flags_tu_cnt_off<4)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRSH _0x5E
; 			{
; 			flags_tu_cnt_off++;
	LDS  R30,_flags_tu_cnt_off
	SUBI R30,-LOW(1)
	STS  _flags_tu_cnt_off,R30
; 			if(flags_tu_cnt_off>=4)flags|=0b00100000;
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRLO _0x5F
	LDS  R30,_flags
	ORI  R30,0x20
	STS  _flags,R30
; 			}
_0x5F:
; 		else flags_tu_cnt_off=4;
	RJMP _0x60
_0x5E:
	LDI  R30,LOW(4)
	STS  _flags_tu_cnt_off,R30
; 		}
_0x60:
; 	else
	RJMP _0x61
_0x5D:
; 		{
; 		if(flags_tu_cnt_off)
	LDS  R30,_flags_tu_cnt_off
	CPI  R30,0
	BREQ _0x62
; 			{
; 			flags_tu_cnt_off--;
	SUBI R30,LOW(1)
	STS  _flags_tu_cnt_off,R30
; 			if(flags_tu_cnt_off<=0)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,0
	BRNE _0x63
; 				{
; 				flags&=0b11011111;
	LDS  R30,_flags
	ANDI R30,0xDF
	STS  _flags,R30
; 				off_bp_cnt=5*TZAS;
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	LDI  R26,LOW(5)
	MUL  R30,R26
	MOVW R30,R0
	STS  _off_bp_cnt,R30
; 				}
; 			}
_0x63:
; 		else flags_tu_cnt_off=0;
	RJMP _0x64
_0x62:
	LDI  R30,LOW(0)
	STS  _flags_tu_cnt_off,R30
; 		}
_0x64:
_0x61:
;
; 	if(flags_tu&0b00000010) flags|=0b01000000;
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x2)
	BREQ _0x65
	LDS  R30,_flags
	ORI  R30,0x40
	RJMP _0x3B9
; 	else flags&=0b10111111;
_0x65:
	LDS  R30,_flags
	ANDI R30,0xBF
_0x3B9:
	STS  _flags,R30
;
; 	vol_u_temp=RXBUFF1[4]+RXBUFF1[5]*256;
	CALL SUBOPT_0xA
	__GETB2MN _RXBUFF1,4
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _vol_u_temp,R30
	STS  _vol_u_temp+1,R31
; 	vol_i_temp=RXBUFF1[6]+RXBUFF1[7]*256;
	__GETB2MN _RXBUFF1,7
	CALL SUBOPT_0xB
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
;    //flags = 0x55;
;    plazma_int[1]=((short)flags)*10;
	LDS  R26,_flags
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	__PUTW1MN _plazma_int,2
;	can_transmit1(adress,PUTTM1,*((char*)&I),*(((char*)&I)+1),*((char*)&Un),*(((char*)&Un)+1),*((char*)&/*plazma_int[1]*/Ui ...
	LDS  R30,_adress
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
	__GETB2MN _Ui,1
	CALL SUBOPT_0xC
;	can_transmit1(adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*((char*)&plazma_int[2]/*rotor_int*/),*((( ...
	__GETB1MN _plazma_int,4
	ST   -Y,R30
	__GETB2MN _plazma_int,5
	RCALL _can_transmit1
;     link_cnt=0;
	CALL SUBOPT_0xD
;     link=ON;
;
;     if(flags_tu&0b10000000)
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BREQ _0x67
;     	{
;     	if(!res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x68
;     		{
;     		res_fl=1;
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	LDI  R30,LOW(1)
	CALL __EEPROMWRB
;     		bRES=1;
	STS  _bRES,R30
;     		res_fl_cnt=0;
	LDI  R30,LOW(0)
	STS  _res_fl_cnt,R30
;     		}
;     	}
_0x68:
;     else
	RJMP _0x69
_0x67:
;     	{
;     	if(main_cnt>20)
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	SBIW R26,21
	BRLT _0x6A
;     		{
;    			if(res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ _0x6B
;     			{
;     			res_fl=0;
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;     			}
;     		}
_0x6B:
;     	}
_0x6A:
_0x69:
;
;      if(res_fl_)
	CALL SUBOPT_0xE
	BREQ _0x6C
;      	{
;      	res_fl_=0;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;      	}
;	}
_0x6C:
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==KLBR)&&(RXBUFF1[3]==RXBUFF1[4]))
	RJMP _0x6D
_0x5A:
	CALL SUBOPT_0x8
	BRNE _0x6F
	CALL SUBOPT_0x9
	BRNE _0x6F
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEE)
	BRNE _0x6F
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BREQ _0x70
_0x6F:
	RJMP _0x6E
_0x70:
;	{
;	rotor_int++;
	CALL SUBOPT_0xF
;	if((RXBUFF1[3]&0xf0)==0x20)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x20)
	BRNE _0x71
;		{
;		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x72
;			{
;			K[0][0]=adc_buff_[0];
	CALL SUBOPT_0x10
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x73
_0x72:
	CALL SUBOPT_0x11
	BRNE _0x74
;			{
;			K[0][1]++;
	CALL SUBOPT_0x12
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x75
_0x74:
	CALL SUBOPT_0x13
	BRNE _0x76
;			{
;			K[0][1]+=10;
	CALL SUBOPT_0x12
	ADIW R30,10
	RJMP _0x3BA
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x76:
	CALL SUBOPT_0x14
	BRNE _0x78
;			{
;			K[0][1]--;
	CALL SUBOPT_0x12
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x79
_0x78:
	CALL SUBOPT_0x15
	BRNE _0x7A
;			{
;			K[0][1]-=10;
	CALL SUBOPT_0x12
	SBIW R30,10
_0x3BA:
	__PUTW1EN _K,2
;			}
;		granee(&K[0][1],300,5000);
_0x7A:
_0x79:
_0x75:
_0x73:
	__POINTW1MN _K,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5000)
	LDI  R27,HIGH(5000)
	RJMP _0x3BB
;		}
;	else if((RXBUFF1[3]&0xf0)==0x10)
_0x71:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x10)
	BRNE _0x7C
;		{
;		/*if((RXBUFF1[3]&0x0f)==0x01)
;			{
;			K[1][0]=adc_buff_[1];
;			}
;		else*/ if((RXBUFF1[3]&0x0f)==0x02)
	CALL SUBOPT_0x11
	BRNE _0x7D
;			{
;			K[1][1]++;
	CALL SUBOPT_0x16
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x7E
_0x7D:
	CALL SUBOPT_0x13
	BRNE _0x7F
;			{
;			K[1][1]+=10;
	CALL SUBOPT_0x16
	ADIW R30,10
	RJMP _0x3BC
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x7F:
	CALL SUBOPT_0x14
	BRNE _0x81
;			{
;			K[1][1]--;
	CALL SUBOPT_0x16
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x82
_0x81:
	CALL SUBOPT_0x15
	BRNE _0x83
;			{
;			K[1][1]-=10;
	CALL SUBOPT_0x16
	SBIW R30,10
_0x3BC:
	__PUTW1EN _K,6
;			}
;		/*#ifdef _220_
;		granee(&K[1][1],4500,5500);
;		#else
;		granee(&K[1][1],1360,1700);
;		#endif*/
;		}
_0x83:
_0x82:
_0x7E:
;
;	else if((RXBUFF1[3]&0xf0)==0x00)
	RJMP _0x84
_0x7C:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	BRNE _0x85
;		{
;		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x86
;			{
;			K[2][0]=adc_buff_[0];
	__POINTW2MN _K,8
	CALL SUBOPT_0x10
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x87
_0x86:
	CALL SUBOPT_0x11
	BRNE _0x88
;			{
;			K[2][1]++;
	CALL SUBOPT_0x17
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x89
_0x88:
	CALL SUBOPT_0x13
	BRNE _0x8A
;			{
;			K[2][1]+=10;
	CALL SUBOPT_0x17
	ADIW R30,10
	RJMP _0x3BD
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x8A:
	CALL SUBOPT_0x14
	BRNE _0x8C
;			{
;			K[2][1]--;
	CALL SUBOPT_0x17
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x8D
_0x8C:
	CALL SUBOPT_0x15
	BRNE _0x8E
;			{
;			K[2][1]-=10;
	CALL SUBOPT_0x17
	SBIW R30,10
_0x3BD:
	__PUTW1EN _K,10
;			}
;		/*#ifdef _220_
;		granee(&K[2][1],4500,5500);
;		#else
;		granee(&K[2][1],1360,1700);
;		#endif	*/
;		}
_0x8E:
_0x8D:
_0x89:
_0x87:
;
;	else if((RXBUFF1[3]&0xf0)==0x30)
	RJMP _0x8F
_0x85:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x30)
	BRNE _0x90
;		{
;		if((RXBUFF1[3]&0x0f)==0x02)
	CALL SUBOPT_0x11
	BRNE _0x91
;			{
;			K[3][1]++;
	CALL SUBOPT_0x18
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x92
_0x91:
	CALL SUBOPT_0x13
	BRNE _0x93
;			{
;			K[3][1]+=10;
	CALL SUBOPT_0x18
	ADIW R30,10
	RJMP _0x3BE
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x93:
	CALL SUBOPT_0x14
	BRNE _0x95
;			{
;			K[3][1]--;
	CALL SUBOPT_0x18
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x96
_0x95:
	CALL SUBOPT_0x15
	BRNE _0x97
;			{
;			K[3][1]-=10;
	CALL SUBOPT_0x18
	SBIW R30,10
_0x3BE:
	__PUTW1EN _K,14
;			}
;		granee(&K[3][1],/*480*/200,/*497*/1000);
_0x97:
_0x96:
_0x92:
	__POINTW1MN _K,14
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL SUBOPT_0x19
_0x3BB:
	RCALL _granee
;		}
;
;/*	else if((RXBUFF1[3]&0xf0)==0xA0)    //изменение адреса(инкремент и декремент)
;		{
;		//rotor++;
;		if((RXBUFF1[3]&0x0f)==0x02)
;			{
;			adr_ee++;
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
;			{
;			adr_ee+=10;
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
;			{
;			adr_ee--;
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
;			{
;			adr_ee-=10;
;			}
;		} */
;/*	else if((RXBUFF1[3]&0xf0)==0xB0)   //установка адреса(для ворот)
;		{
;		//rotor--;
;		adr_ee=(RXBUFF1[3]&0x0f);
;		}  */
;	link_cnt=0;
_0x90:
_0x8F:
_0x84:
	CALL SUBOPT_0xD
;     link=ON;
;     if(res_fl_)
	CALL SUBOPT_0xE
	BREQ _0x98
;      	{
;      	res_fl_=0;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;      	}
;
;
;	}
_0x98:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF))
	RJMP _0x99
_0x6E:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0x9B
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0x9B
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x62)
	BREQ _0x9C
_0x9B:
	RJMP _0x9A
_0x9C:
;	{
;	//rotor_int++;
;	if(ee_Umax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_Umax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	CALL SUBOPT_0x1A
	MOVW R22,R30
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	CP   R30,R22
	CPC  R31,R23
	BREQ _0x9D
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	LDI  R26,LOW(_ee_Umax)
	LDI  R27,HIGH(_ee_Umax)
	CALL __EEPROMWRW
;	if(ee_dU!=(RXBUFF1[5]+(RXBUFF1[6]*256))) ee_dU=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0x9D:
	LDI  R26,LOW(_ee_dU)
	LDI  R27,HIGH(_ee_dU)
	CALL __EEPROMRDW
	MOVW R22,R30
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1E
	CP   R30,R22
	CPC  R31,R23
	BREQ _0x9E
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1E
	LDI  R26,LOW(_ee_dU)
	LDI  R27,HIGH(_ee_dU)
	CALL __EEPROMWRW
;
;    if((RXBUFF1[7]&0x0f)==0x05)
_0x9E:
	__GETB1MN _RXBUFF1,7
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BRNE _0x9F
;		{
;		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0xA0
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	LDI  R30,LOW(85)
	LDI  R31,HIGH(85)
	CALL __EEPROMWRW
;		}
_0xA0:
;	else if((RXBUFF1[7]&0x0f)==0x0a)
	RJMP _0xA1
_0x9F:
	__GETB1MN _RXBUFF1,7
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0xA)
	BRNE _0xA2
;        {
;        if(ee_AVT_MODE!=0)ee_AVT_MODE=0;
	CALL SUBOPT_0x1F
	SBIW R30,0
	BREQ _0xA3
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	CALL SUBOPT_0x20
;        }
_0xA3:
;	}
_0xA2:
_0xA1:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&((RXBUFF1[2]==MEM_KF1)||(RXBUFF1[2]==MEM_KF4)))
	RJMP _0xA4
_0x9A:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xA6
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xA6
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BREQ _0xA7
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x29)
	BRNE _0xA6
_0xA7:
	RJMP _0xA9
_0xA6:
	RJMP _0xA5
_0xA9:
;	{
;	if(ee_tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	CALL SUBOPT_0x21
	MOVW R22,R30
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xAA
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	LDI  R26,LOW(_ee_tmax)
	LDI  R27,HIGH(_ee_tmax)
	CALL __EEPROMWRW
;	if(ee_tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) ee_tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0xAA:
	CALL SUBOPT_0x22
	MOVW R22,R30
	CALL SUBOPT_0xA
	CALL SUBOPT_0x1E
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xAB
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1E
	LDI  R26,LOW(_ee_tsign)
	LDI  R27,HIGH(_ee_tsign)
	CALL __EEPROMWRW
;	//if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7];
;
;	if(RXBUFF1[2]==MEM_KF1)
_0xAB:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BRNE _0xAC
;		{
;		if(ee_DEVICE!=0)ee_DEVICE=0;
	CALL SUBOPT_0x23
	SBIW R30,0
	BREQ _0xAD
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	CALL SUBOPT_0x20
;		if(ee_TZAS!=(signed short)RXBUFF1[7]) ee_TZAS=(signed short)RXBUFF1[7];
_0xAD:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	BREQ _0xAE
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	CALL __EEPROMWRW
;		}
_0xAE:
;	if(RXBUFF1[2]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, ко ...
_0xAC:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x29)
	BRNE _0xAF
;		{
;		if(ee_DEVICE!=1)ee_DEVICE=1;
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ _0xB0
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __EEPROMWRW
;		if(ee_IMAXVENT!=(signed short)RXBUFF1[7]) ee_IMAXVENT=(signed short)RXBUFF1[7];
_0xB0:
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMRDW
	CALL SUBOPT_0x25
	BREQ _0xB1
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMWRW
;			if(ee_TZAS!=3) ee_TZAS=3;
_0xB1:
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ _0xB2
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL __EEPROMWRW
;		}
_0xB2:
;
;	}
_0xAF:
;
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	RJMP _0xB3
_0xA5:
	CALL SUBOPT_0x8
	BRNE _0xB5
	CALL SUBOPT_0x9
	BRNE _0xB5
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xB5
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x63)
	BREQ _0xB6
_0xB5:
	RJMP _0xB4
_0xB6:
;	{
;	flags&=0b11100001;
	CALL SUBOPT_0x26
;	tsign_cnt=0;
;	tmax_cnt=0;
;	umax_cnt=0;
;	umin_cnt=0;
;	led_drv_cnt=30;
;	}
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==VENT_RES))
	RJMP _0xB7
_0xB4:
	CALL SUBOPT_0x8
	BRNE _0xB9
	CALL SUBOPT_0x9
	BRNE _0xB9
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xB9
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x64)
	BREQ _0xBA
_0xB9:
	RJMP _0xB8
_0xBA:
;	{
;	vent_resurs=0;
	LDI  R26,LOW(_vent_resurs)
	LDI  R27,HIGH(_vent_resurs)
	CALL SUBOPT_0x20
;	}
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	RJMP _0xBB
_0xB8:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xBD
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xBD
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xBD
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x16)
	BREQ _0xBE
_0xBD:
	RJMP _0xBC
_0xBE:
;	{
;	if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x55)
	BRNE _0xC0
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x55)
	BREQ _0xC1
_0xC0:
	RJMP _0xBF
_0xC1:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	CALL SUBOPT_0x27
;	else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--;
	RJMP _0xC2
_0xBF:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x66)
	BRNE _0xC4
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x66)
	BREQ _0xC5
_0xC4:
	RJMP _0xC3
_0xC5:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
;	else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
	RJMP _0xC6
_0xC3:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x77)
	BRNE _0xC8
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x77)
	BREQ _0xC9
_0xC8:
	RJMP _0xC7
_0xC9:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
;     gran(&_x_,-XMAX,XMAX);
_0xC7:
_0xC6:
_0xC2:
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
	RCALL _gran
;	}
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==RXBUFF1[4])&&(RXBUFF1[3]==0xee))
	RJMP _0xCA
_0xBC:
	CALL SUBOPT_0x8
	BRNE _0xCC
	CALL SUBOPT_0x9
	BRNE _0xCC
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xCC
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BRNE _0xCC
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0xEE)
	BREQ _0xCD
_0xCC:
	RJMP _0xCB
_0xCD:
;	{
;	rotor_int++;
	CALL SUBOPT_0xF
;     tempI=pwm_u;
	__GETWRMN 20,21,0,_pwm_u
;	ee_U_AVT=tempI;
	MOVW R30,R20
	LDI  R26,LOW(_ee_U_AVT)
	LDI  R27,HIGH(_ee_U_AVT)
	CALL __EEPROMWRW
;	delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
;	if(ee_U_AVT==tempI)can_transmit1(adress,PUTID,0xdd,0xdd,0,0,0,0);
	CALL SUBOPT_0x28
	CP   R20,R30
	CPC  R21,R31
	BRNE _0xCE
	LDS  R30,_adress
	ST   -Y,R30
	LDI  R30,LOW(145)
	ST   -Y,R30
	LDI  R30,LOW(221)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _can_transmit1
;
;	}
_0xCE:
;
;
;
;
;
;can_in_an1_end:
_0xCB:
_0xCA:
_0xBB:
_0xB7:
_0xB3:
_0xA4:
_0x99:
_0x6D:
;bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
;}
	CALL __LOADLOCR6
	RJMP _0x20C0002
; .FEND
;
;//-----------------------------------------------
;void net_drv(void)
;{
_net_drv:
; .FSTART _net_drv
;//char temp_;
;if(bMAIN)
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0xD0
;	{
;	if(++cnt_net_drv>=7) cnt_net_drv=0;
	LDS  R26,_cnt_net_drv
	SUBI R26,-LOW(1)
	STS  _cnt_net_drv,R26
	CPI  R26,LOW(0x7)
	BRLO _0xD1
	LDI  R30,LOW(0)
	STS  _cnt_net_drv,R30
;
;	if(cnt_net_drv<=5)
_0xD1:
	LDS  R26,_cnt_net_drv
	CPI  R26,LOW(0x6)
	BRSH _0xD2
;		{
;		can_transmit1(cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv ...
	LDS  R30,_cnt_net_drv
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(237)
	ST   -Y,R30
	LDI  R30,LOW(0)
	CALL SUBOPT_0x29
	LD   R30,X
	LDS  R26,_volum_u_main_
	ADD  R30,R26
	CALL SUBOPT_0x29
	CALL __GETW1P
	LDS  R26,_volum_u_main_
	LDS  R27,_volum_u_main_+1
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __DIVW21
	ST   -Y,R30
	LDI  R30,LOW(232)
	ST   -Y,R30
	LDI  R26,LOW(232)
	RCALL _can_transmit1
;		i_main_bps_cnt[cnt_net_drv]++;
	LDS  R26,_cnt_net_drv
	LDI  R27,0
	SUBI R26,LOW(-_i_main_bps_cnt)
	SBCI R27,HIGH(-_i_main_bps_cnt)
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
;		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
	LDS  R30,_cnt_net_drv
	LDI  R31,0
	SUBI R30,LOW(-_i_main_bps_cnt)
	SBCI R31,HIGH(-_i_main_bps_cnt)
	LD   R26,Z
	CPI  R26,LOW(0xB)
	BRLO _0xD3
	LDS  R30,_cnt_net_drv
	LDI  R31,0
	SUBI R30,LOW(-_i_main_flag)
	SBCI R31,HIGH(-_i_main_flag)
	LDI  R26,LOW(0)
	STD  Z+0,R26
;		}
_0xD3:
;	else if(cnt_net_drv==6)
	RJMP _0xD4
_0xD2:
	LDS  R26,_cnt_net_drv
	CPI  R26,LOW(0x6)
	BRNE _0xD5
;		{
;		plazma_int[2]=pwm_u;
	LDS  R30,_pwm_u
	LDS  R31,_pwm_u+1
	__PUTW1MN _plazma_int,4
;		can_transmit1(adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)& ...
	LDS  R30,_adress
	ST   -Y,R30
	LDI  R30,LOW(218)
	ST   -Y,R30
	__GETB1MN _I,1
	ST   -Y,R30
	LDS  R30,_I
	ST   -Y,R30
	__GETB1MN _Un,1
	ST   -Y,R30
	LDS  R30,_Un
	ST   -Y,R30
	__GETB1MN _Ui,1
	ST   -Y,R30
	LDS  R26,_Ui
	CALL SUBOPT_0xC
;		can_transmit1(adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&pl ...
	__GETB1MN _plazma_int,5
	ST   -Y,R30
	__GETB2MN _plazma_int,4
	RCALL _can_transmit1
;		}
;	}
_0xD5:
_0xD4:
;}
_0xD0:
	RET
; .FEND
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
;
;//-----------------------------------------------
;void t0_init(void)
; 0000 00BD {
_t0_init:
; .FSTART _t0_init
; 0000 00BE TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 00BF TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 00C0 TCNT0=-8;
	LDI  R30,LOW(248)
	OUT  0x26,R30
; 0000 00C1 TIMSK0=0x01;
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 00C2 }
	RET
; .FEND
;
;//-----------------------------------------------
;char adr_gran(signed short in)
; 0000 00C6 {
; 0000 00C7 if(in>800)return 1;
;	in -> Y+0
; 0000 00C8 else if((in>80)&&(in<120))return 0;
; 0000 00C9 else return 100;
; 0000 00CA }
;
;
;//-----------------------------------------------
;void gran(signed int *adr, signed int min, signed int max)
; 0000 00CF {
_gran:
; .FSTART _gran
; 0000 00D0 if (*adr<min) *adr=min;
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
	BRGE _0xDC
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 00D1 if (*adr>max) *adr=max;
_0xDC:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xDD
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 00D2 }
_0xDD:
	RJMP _0x20C0002
; .FEND
;
;
;//-----------------------------------------------
;void granee(eeprom signed int *adr, signed int min, signed int max)
; 0000 00D7 {
_granee:
; .FSTART _granee
; 0000 00D8 if (*adr<min) *adr=min;
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
	BRGE _0xDE
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00D9 if (*adr>max) *adr=max;
_0xDE:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xDF
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00DA }
_0xDF:
_0x20C0002:
	ADIW R28,6
	RET
; .FEND
;
;//-----------------------------------------------
;void x_drv(void)
; 0000 00DE {
_x_drv:
; .FSTART _x_drv
; 0000 00DF if(_x__==_x_)
	CALL SUBOPT_0x2A
	LDS  R26,__x__
	LDS  R27,__x__+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0xE0
; 0000 00E0 	{
; 0000 00E1 	if(_x_cnt<60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,60
	BRGE _0xE1
; 0000 00E2 		{
; 0000 00E3 		_x_cnt++;
	LDI  R26,LOW(__x_cnt)
	LDI  R27,HIGH(__x_cnt)
	CALL SUBOPT_0x27
; 0000 00E4 		if(_x_cnt>=60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,60
	BRLT _0xE2
; 0000 00E5 			{
; 0000 00E6 			if(_x_ee_!=_x_)_x_ee_=_x_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	MOVW R26,R30
	CALL SUBOPT_0x2A
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xE3
	CALL SUBOPT_0x2A
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMWRW
; 0000 00E7 			}
_0xE3:
; 0000 00E8 		}
_0xE2:
; 0000 00E9 
; 0000 00EA 	}
_0xE1:
; 0000 00EB else _x_cnt=0;
	RJMP _0xE4
_0xE0:
	LDI  R30,LOW(0)
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
; 0000 00EC 
; 0000 00ED if(_x_cnt>60) _x_cnt=0;
_0xE4:
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,61
	BRLT _0xE5
	LDI  R30,LOW(0)
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
; 0000 00EE 
; 0000 00EF _x__=_x_;
_0xE5:
	CALL SUBOPT_0x2A
	STS  __x__,R30
	STS  __x__+1,R31
; 0000 00F0 }
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_start(void)
; 0000 00F4 {
_apv_start:
; .FSTART _apv_start
; 0000 00F5 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
	LDS  R26,_apv_cnt
	CPI  R26,LOW(0x0)
	BRNE _0xE7
	__GETB2MN _apv_cnt,1
	CPI  R26,LOW(0x0)
	BRNE _0xE7
	__GETB2MN _apv_cnt,2
	CPI  R26,LOW(0x0)
	BRNE _0xE7
	LDS  R30,_bAPV
	CPI  R30,0
	BREQ _0xE8
_0xE7:
	RJMP _0xE6
_0xE8:
; 0000 00F6 	{
; 0000 00F7 	apv_cnt[0]=60;
	LDI  R30,LOW(60)
	STS  _apv_cnt,R30
; 0000 00F8 	apv_cnt[1]=60;
	__PUTB1MN _apv_cnt,1
; 0000 00F9 	apv_cnt[2]=60;
	__PUTB1MN _apv_cnt,2
; 0000 00FA 	apv_cnt_=3600;
	LDI  R30,LOW(3600)
	LDI  R31,HIGH(3600)
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R31
; 0000 00FB 	bAPV=1;
	LDI  R30,LOW(1)
	STS  _bAPV,R30
; 0000 00FC 	}
; 0000 00FD }
_0xE6:
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_stop(void)
; 0000 0101 {
_apv_stop:
; .FSTART _apv_stop
; 0000 0102 apv_cnt[0]=0;
	LDI  R30,LOW(0)
	STS  _apv_cnt,R30
; 0000 0103 apv_cnt[1]=0;
	__PUTB1MN _apv_cnt,1
; 0000 0104 apv_cnt[2]=0;
	__PUTB1MN _apv_cnt,2
; 0000 0105 apv_cnt_=0;
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R30
; 0000 0106 bAPV=0;
	STS  _bAPV,R30
; 0000 0107 }
	RET
; .FEND
;
;
;//-----------------------------------------------
;void av_wrk_drv(void)
; 0000 010C {
; 0000 010D adc_ch_2_delta=(char)(adc_ch_2_max-adc_ch_2_min);
; 0000 010E adc_ch_2_max=adc_buff_[2];
; 0000 010F adc_ch_2_min=adc_buff_[2];
; 0000 0110 if(PORTD.7==0)
; 0000 0111 	{
; 0000 0112 	if(adc_ch_2_delta>=5)
; 0000 0113 		{
; 0000 0114 		cnt_adc_ch_2_delta++;
; 0000 0115 		if(cnt_adc_ch_2_delta>=10)
; 0000 0116 			{
; 0000 0117 			flags|=0x10;
; 0000 0118 			apv_start();
; 0000 0119 			}
; 0000 011A 		}
; 0000 011B 	else
; 0000 011C 		{
; 0000 011D 		cnt_adc_ch_2_delta=0;
; 0000 011E 		}
; 0000 011F 	}
; 0000 0120 else cnt_adc_ch_2_delta=0;
; 0000 0121 }
;
;//-----------------------------------------------
;void led_drv_1(void)
; 0000 0125 {
; 0000 0126 DDRD.1=1;
; 0000 0127 if(led_green_buff&0b1L) PORTD.1=1;
; 0000 0128 else PORTD.1=0;
; 0000 0129 DDRD.0=1;
; 0000 012A if(led_red_buff&0b1L) PORTD.0=1;
; 0000 012B else PORTD.0=0;
; 0000 012C 
; 0000 012D 
; 0000 012E led_red_buff>>=1;
; 0000 012F led_green_buff>>=1;
; 0000 0130 if(++led_drv_cnt>32)
; 0000 0131 	{
; 0000 0132 	led_drv_cnt=0;
; 0000 0133 	led_red_buff=led_red;
; 0000 0134 	led_green_buff=led_green;
; 0000 0135 	}
; 0000 0136 
; 0000 0137 }
;
;//-----------------------------------------------
;void led_drv(void)
; 0000 013B {
_led_drv:
; .FSTART _led_drv
; 0000 013C //Красный светодиод
; 0000 013D DDRD.0=1;
	SBI  0xA,0
; 0000 013E if(led_red_buff&0b1L)   PORTD.0=1; 	//Горит если в led_red_buff 1 и на ножке 1
	LDS  R30,_led_red_buff
	ANDI R30,LOW(0x1)
	BREQ _0x101
	SBI  0xB,0
; 0000 013F else                    PORTD.0=0;
	RJMP _0x104
_0x101:
	CBI  0xB,0
; 0000 0140 
; 0000 0141 //Зеленый светодиод
; 0000 0142 DDRD.1=1;
_0x104:
	SBI  0xA,1
; 0000 0143 if(led_green_buff&0b1L) PORTD.1=1;	//Горит если в led_green_buff 1 и на ножке 1
	LDS  R30,_led_green_buff
	ANDI R30,LOW(0x1)
	BREQ _0x109
	SBI  0xB,1
; 0000 0144 else                    PORTD.1=0;
	RJMP _0x10C
_0x109:
	CBI  0xB,1
; 0000 0145 
; 0000 0146 
; 0000 0147 led_red_buff>>=1;
_0x10C:
	LDS  R30,_led_red_buff
	LDS  R31,_led_red_buff+1
	LDS  R22,_led_red_buff+2
	LDS  R23,_led_red_buff+3
	CALL __ASRD1
	CALL SUBOPT_0x2B
; 0000 0148 led_green_buff>>=1;
	LDS  R30,_led_green_buff
	LDS  R31,_led_green_buff+1
	LDS  R22,_led_green_buff+2
	LDS  R23,_led_green_buff+3
	CALL __ASRD1
	CALL SUBOPT_0x2C
; 0000 0149 if(++led_drv_cnt>32)
	LDS  R26,_led_drv_cnt
	SUBI R26,-LOW(1)
	STS  _led_drv_cnt,R26
	CPI  R26,LOW(0x21)
	BRLO _0x10F
; 0000 014A 	{
; 0000 014B 	led_drv_cnt=0;
	LDI  R30,LOW(0)
	STS  _led_drv_cnt,R30
; 0000 014C 	led_red_buff=led_red;
	LDS  R30,_led_red
	LDS  R31,_led_red+1
	LDS  R22,_led_red+2
	LDS  R23,_led_red+3
	CALL SUBOPT_0x2B
; 0000 014D 	led_green_buff=led_green;
	LDS  R30,_led_green
	LDS  R31,_led_green+1
	LDS  R22,_led_green+2
	LDS  R23,_led_green+3
	CALL SUBOPT_0x2C
; 0000 014E 	}
; 0000 014F 
; 0000 0150 }
_0x10F:
	RET
; .FEND
;
;//-----------------------------------------------
;void flags_drv(void)
; 0000 0154 {
_flags_drv:
; .FSTART _flags_drv
; 0000 0155 static char flags_old;
; 0000 0156 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0x110
; 0000 0157 	{
; 0000 0158 	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000))))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x112
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x8)
	BREQ _0x114
_0x112:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x115
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x10)
	BREQ _0x114
_0x115:
	RJMP _0x111
_0x114:
; 0000 0159     		{
; 0000 015A     		if(link==OFF)apv_start();
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x118
	RCALL _apv_start
; 0000 015B     		}
_0x118:
; 0000 015C      }
_0x111:
; 0000 015D else if(jp_mode==jp3)
	RJMP _0x119
_0x110:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x11A
; 0000 015E 	{
; 0000 015F 	if((flags&0b00001000)&&(!(flags_old&0b00001000)))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x11C
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x8)
	BREQ _0x11D
_0x11C:
	RJMP _0x11B
_0x11D:
; 0000 0160     		{
; 0000 0161     		apv_start();
	RCALL _apv_start
; 0000 0162     		}
; 0000 0163      }
_0x11B:
; 0000 0164 flags_old=flags;
_0x11A:
_0x119:
	LDS  R30,_flags
	STS  _flags_old_S000001B000,R30
; 0000 0165 
; 0000 0166 }
	RET
; .FEND
;
;//-----------------------------------------------
;void adr_hndl(void)
; 0000 016A {
_adr_hndl:
; .FSTART _adr_hndl
; 0000 016B #define ADR_CONST_0	574
; 0000 016C #define ADR_CONST_1	897
; 0000 016D #define ADR_CONST_2	695
; 0000 016E #define ADR_CONST_3	1015
; 0000 016F 
; 0000 0170 signed tempSI;
; 0000 0171 short aaa[3];
; 0000 0172 char aaaa[3];
; 0000 0173 DDRC=0b00000000;
	SBIW R28,9
	ST   -Y,R17
	ST   -Y,R16
;	tempSI -> R16,R17
;	aaa -> Y+5
;	aaaa -> Y+2
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 0174 PORTC=0b00000000;
	OUT  0x8,R30
; 0000 0175 /*char i;
; 0000 0176 DDRD&=0b11100011;
; 0000 0177 PORTD|=0b00011100;
; 0000 0178 
; 0000 0179 //adr_new=((char)(!PIND.2))+(((char)(!PIND.3))*2)+((char)(!PIND.4)*4);
; 0000 017A 
; 0000 017B 
; 0000 017C adr_new=(PIND&0b00011100)>>2;
; 0000 017D 
; 0000 017E if(adr_new==adr_old)
; 0000 017F  	{
; 0000 0180  	if(adr_cnt<100)
; 0000 0181  		{
; 0000 0182  		adr_cnt++;
; 0000 0183  	     if(adr_cnt>=100)
; 0000 0184  	     	{
; 0000 0185  	     	adr_temp=adr_new;
; 0000 0186  	     	}
; 0000 0187  	     }
; 0000 0188    	}
; 0000 0189 else adr_cnt=0;
; 0000 018A adr_old=adr_new;
; 0000 018B if(adr!=CONST_ADR[adr_temp]) adr=CONST_ADR[adr_temp];
; 0000 018C 
; 0000 018D 
; 0000 018E //if(adr!=0b00000011)adr=0b00000011;*/
; 0000 018F 
; 0000 0190 
; 0000 0191 
; 0000 0192 ADMUX=0b00000110;
	LDI  R30,LOW(6)
	CALL SUBOPT_0x2D
; 0000 0193 ADCSRA=0b10100110;
; 0000 0194 ADCSRA|=0b01000000;
; 0000 0195 delay_ms(10);
; 0000 0196 aaa[0]=ADCW;
	CALL SUBOPT_0x2E
	STD  Y+5,R30
	STD  Y+5+1,R31
; 0000 0197 
; 0000 0198 
; 0000 0199 ADMUX=0b00000111;
	LDI  R30,LOW(7)
	CALL SUBOPT_0x2D
; 0000 019A ADCSRA=0b10100110;
; 0000 019B ADCSRA|=0b01000000;
; 0000 019C delay_ms(10);
; 0000 019D aaa[1]=ADCW;
	CALL SUBOPT_0x2E
	STD  Y+7,R30
	STD  Y+7+1,R31
; 0000 019E 
; 0000 019F 
; 0000 01A0 ADMUX=0b00000000;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x2D
; 0000 01A1 ADCSRA=0b10100110;
; 0000 01A2 ADCSRA|=0b01000000;
; 0000 01A3 delay_ms(10);
; 0000 01A4 aaa[2]=ADCW;
	CALL SUBOPT_0x2E
	STD  Y+9,R30
	STD  Y+9+1,R31
; 0000 01A5 
; 0000 01A6 if((aaa[0]>=(ADR_CONST_0-40))&&(aaa[0]<=(ADR_CONST_0+40))) adr[0]=0;
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x11F
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x120
_0x11F:
	RJMP _0x11E
_0x120:
	LDI  R30,LOW(0)
	RJMP _0x3BF
; 0000 01A7 else if((aaa[0]>=(ADR_CONST_1-40))&&(aaa[0]<=(ADR_CONST_1+40))) adr[0]=1;
_0x11E:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x123
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x124
_0x123:
	RJMP _0x122
_0x124:
	LDI  R30,LOW(1)
	RJMP _0x3BF
; 0000 01A8 else if((aaa[0]>=(ADR_CONST_2-40))&&(aaa[0]<=(ADR_CONST_2+40))) adr[0]=2;
_0x122:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x127
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x128
_0x127:
	RJMP _0x126
_0x128:
	LDI  R30,LOW(2)
	RJMP _0x3BF
; 0000 01A9 else if((aaa[0]>=(ADR_CONST_3-40))&&(aaa[0]<=(ADR_CONST_3+40))) adr[0]=3;
_0x126:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x12B
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x12C
_0x12B:
	RJMP _0x12A
_0x12C:
	LDI  R30,LOW(3)
	RJMP _0x3BF
; 0000 01AA else adr[0]=5;
_0x12A:
	LDI  R30,LOW(5)
_0x3BF:
	STS  _adr,R30
; 0000 01AB 
; 0000 01AC if((aaa[1]>=(ADR_CONST_0-40))&&(aaa[1]<=(ADR_CONST_0+40))) adr[1]=0;
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x12F
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x130
_0x12F:
	RJMP _0x12E
_0x130:
	LDI  R30,LOW(0)
	RJMP _0x3C0
; 0000 01AD else if((aaa[1]>=(ADR_CONST_1-40))&&(aaa[1]<=(ADR_CONST_1+40))) adr[1]=1;
_0x12E:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x133
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x134
_0x133:
	RJMP _0x132
_0x134:
	LDI  R30,LOW(1)
	RJMP _0x3C0
; 0000 01AE else if((aaa[1]>=(ADR_CONST_2-40))&&(aaa[1]<=(ADR_CONST_2+40))) adr[1]=2;
_0x132:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x137
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x138
_0x137:
	RJMP _0x136
_0x138:
	LDI  R30,LOW(2)
	RJMP _0x3C0
; 0000 01AF else if((aaa[1]>=(ADR_CONST_3-40))&&(aaa[1]<=(ADR_CONST_3+40))) adr[1]=3;
_0x136:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x13B
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x13C
_0x13B:
	RJMP _0x13A
_0x13C:
	LDI  R30,LOW(3)
	RJMP _0x3C0
; 0000 01B0 else adr[1]=5;
_0x13A:
	LDI  R30,LOW(5)
_0x3C0:
	__PUTB1MN _adr,1
; 0000 01B1 
; 0000 01B2 if((aaa[2]>=(ADR_CONST_0-40))&&(aaa[2]<=(ADR_CONST_0+40))) adr[2]=0;
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x13F
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x140
_0x13F:
	RJMP _0x13E
_0x140:
	LDI  R30,LOW(0)
	RJMP _0x3C1
; 0000 01B3 else if((aaa[2]>=(ADR_CONST_1-40))&&(aaa[2]<=(ADR_CONST_1+40))) adr[2]=1;
_0x13E:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x143
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x144
_0x143:
	RJMP _0x142
_0x144:
	LDI  R30,LOW(1)
	RJMP _0x3C1
; 0000 01B4 else if((aaa[2]>=(ADR_CONST_2-40))&&(aaa[2]<=(ADR_CONST_2+40))) adr[2]=2;
_0x142:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x147
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x148
_0x147:
	RJMP _0x146
_0x148:
	LDI  R30,LOW(2)
	RJMP _0x3C1
; 0000 01B5 else if((aaa[2]>=(ADR_CONST_3-40))&&(aaa[2]<=(ADR_CONST_3+40))) adr[2]=3;
_0x146:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x14B
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x14C
_0x14B:
	RJMP _0x14A
_0x14C:
	LDI  R30,LOW(3)
	RJMP _0x3C1
; 0000 01B6 else adr[2]=5;
_0x14A:
	LDI  R30,LOW(5)
_0x3C1:
	__PUTB1MN _adr,2
; 0000 01B7 
; 0000 01B8 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
	LDS  R26,_adr
	CPI  R26,LOW(0x5)
	BREQ _0x14F
	__GETB2MN _adr,1
	CPI  R26,LOW(0x5)
	BREQ _0x14F
	__GETB2MN _adr,2
	CPI  R26,LOW(0x5)
	BRNE _0x14E
_0x14F:
; 0000 01B9 	{
; 0000 01BA 	//adress=100;
; 0000 01BB 	adress_error=1;
	LDI  R30,LOW(1)
	STS  _adress_error,R30
; 0000 01BC 	}
; 0000 01BD else
	RJMP _0x151
_0x14E:
; 0000 01BE 	{
; 0000 01BF 	if(adr[2]&0x02) bps_class=bpsIPS;
	__GETB1MN _adr,2
	ANDI R30,LOW(0x2)
	BREQ _0x152
	LDI  R30,LOW(1)
	RJMP _0x3C2
; 0000 01C0 	else bps_class=bpsIBEP;
_0x152:
	LDI  R30,LOW(0)
_0x3C2:
	STS  _bps_class,R30
; 0000 01C1 
; 0000 01C2 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
	__GETB1MN _adr,1
	LSL  R30
	LSL  R30
	LDS  R26,_adr
	ADD  R30,R26
	MOV  R22,R30
	__GETB1MN _adr,2
	ANDI R30,LOW(0x1)
	LDI  R26,LOW(16)
	MUL  R30,R26
	MOVW R30,R0
	ADD  R30,R22
	STS  _adress,R30
; 0000 01C3 	}
_0x151:
; 0000 01C4 //plazmaSS=adress;
; 0000 01C5 //adress=0;
; 0000 01C6 
; 0000 01C7 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,11
	RET
; .FEND
;
;
;
;
;//-----------------------------------------------
;void apv_hndl(void)
; 0000 01CE {
_apv_hndl:
; .FSTART _apv_hndl
; 0000 01CF if(apv_cnt[0])
	LDS  R30,_apv_cnt
	CPI  R30,0
	BREQ _0x154
; 0000 01D0 	{
; 0000 01D1 	apv_cnt[0]--;
	SUBI R30,LOW(1)
	STS  _apv_cnt,R30
; 0000 01D2 	if(apv_cnt[0]==0)
	CPI  R30,0
	BRNE _0x155
; 0000 01D3 		{
; 0000 01D4 		flags&=0b11100001;
	CALL SUBOPT_0x26
; 0000 01D5 		tsign_cnt=0;
; 0000 01D6 		tmax_cnt=0;
; 0000 01D7 		umax_cnt=0;
; 0000 01D8 		umin_cnt=0;
; 0000 01D9 		//cnt_adc_ch_2_delta=0;
; 0000 01DA 		led_drv_cnt=30;
; 0000 01DB 		}
; 0000 01DC 	}
_0x155:
; 0000 01DD else if(apv_cnt[1])
	RJMP _0x156
_0x154:
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BREQ _0x157
; 0000 01DE 	{
; 0000 01DF 	apv_cnt[1]--;
	__GETB1MN _apv_cnt,1
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,1
; 0000 01E0 	if(apv_cnt[1]==0)
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0x158
; 0000 01E1 		{
; 0000 01E2 		flags&=0b11100001;
	CALL SUBOPT_0x26
; 0000 01E3 		tsign_cnt=0;
; 0000 01E4 		tmax_cnt=0;
; 0000 01E5 		umax_cnt=0;
; 0000 01E6 		umin_cnt=0;
; 0000 01E7 //		cnt_adc_ch_2_delta=0;
; 0000 01E8 		led_drv_cnt=30;
; 0000 01E9 		}
; 0000 01EA 	}
_0x158:
; 0000 01EB else if(apv_cnt[2])
	RJMP _0x159
_0x157:
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BREQ _0x15A
; 0000 01EC 	{
; 0000 01ED 	apv_cnt[2]--;
	__GETB1MN _apv_cnt,2
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,2
; 0000 01EE 	if(apv_cnt[2]==0)
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0x15B
; 0000 01EF 		{
; 0000 01F0 		flags&=0b11100001;
	CALL SUBOPT_0x26
; 0000 01F1 		tsign_cnt=0;
; 0000 01F2 		tmax_cnt=0;
; 0000 01F3 		umax_cnt=0;
; 0000 01F4 		umin_cnt=0;
; 0000 01F5 //		cnt_adc_ch_2_delta=0;
; 0000 01F6 		led_drv_cnt=30;
; 0000 01F7 		}
; 0000 01F8 	}
_0x15B:
; 0000 01F9 
; 0000 01FA if(apv_cnt_)
_0x15A:
_0x159:
_0x156:
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BREQ _0x15C
; 0000 01FB 	{
; 0000 01FC 	apv_cnt_--;
	LDI  R26,LOW(_apv_cnt_)
	LDI  R27,HIGH(_apv_cnt_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 01FD 	if(apv_cnt_==0)
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BRNE _0x15D
; 0000 01FE 		{
; 0000 01FF 		bAPV=0;
	LDI  R30,LOW(0)
	STS  _bAPV,R30
; 0000 0200 		apv_start();
	RCALL _apv_start
; 0000 0201 		}
; 0000 0202 	}
_0x15D:
; 0000 0203 
; 0000 0204 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
_0x15C:
	CALL SUBOPT_0x2F
	SBIW R26,0
	BRNE _0x15F
	CALL SUBOPT_0x30
	SBIW R26,0
	BRNE _0x15F
	SBIS 0x9,4
	RJMP _0x160
_0x15F:
	RJMP _0x15E
_0x160:
; 0000 0205 	{
; 0000 0206 	if(cnt_apv_off<20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRSH _0x161
; 0000 0207 		{
; 0000 0208 		cnt_apv_off++;
	LDS  R30,_cnt_apv_off
	SUBI R30,-LOW(1)
	STS  _cnt_apv_off,R30
; 0000 0209 		if(cnt_apv_off>=20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRLO _0x162
; 0000 020A 			{
; 0000 020B 			apv_stop();
	RCALL _apv_stop
; 0000 020C 			}
; 0000 020D 		}
_0x162:
; 0000 020E 	}
_0x161:
; 0000 020F else cnt_apv_off=0;
	RJMP _0x163
_0x15E:
	LDI  R30,LOW(0)
	STS  _cnt_apv_off,R30
; 0000 0210 
; 0000 0211 }
_0x163:
	RET
; .FEND
;
;//-----------------------------------------------
;void link_drv(void)		//10Hz
; 0000 0215 {
_link_drv:
; .FSTART _link_drv
; 0000 0216 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0x164
; 0000 0217 	{
; 0000 0218 	if(link_cnt<602)link_cnt++;
	CALL SUBOPT_0x31
	CPI  R26,LOW(0x25A)
	LDI  R30,HIGH(0x25A)
	CPC  R27,R30
	BRGE _0x165
	LDI  R26,LOW(_link_cnt)
	LDI  R27,HIGH(_link_cnt)
	CALL SUBOPT_0x27
; 0000 0219 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
_0x165:
	CALL SUBOPT_0x31
	CPI  R26,LOW(0x24E)
	LDI  R30,HIGH(0x24E)
	CPC  R27,R30
	BRNE _0x166
	LDS  R30,_flags
	ANDI R30,LOW(0xC1)
	STS  _flags,R30
; 0000 021A 	if(link_cnt==600)
_0x166:
	CALL SUBOPT_0x31
	CPI  R26,LOW(0x258)
	LDI  R30,HIGH(0x258)
	CPC  R27,R30
	BRNE _0x167
; 0000 021B 		{
; 0000 021C 		link=OFF;
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 021D 
; 0000 021E 		//попробую вместо
; 0000 021F 		//if((AVT_MODE!=0x55)&&(!eeDEVICE))bMAIN=1;
; 0000 0220 		//написать
; 0000 0221 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x168
	IN   R30,0x2A
	SBR  R30,2
	RJMP _0x3C3
; 0000 0222 		else bMAIN=0;
_0x168:
	IN   R30,0x2A
	CBR  R30,2
_0x3C3:
	OUT  0x2A,R30
; 0000 0223 
; 0000 0224 		cnt_net_drv=0;
	LDI  R30,LOW(0)
	STS  _cnt_net_drv,R30
; 0000 0225     		if(!res_fl_)
	CALL SUBOPT_0xE
	BRNE _0x16A
; 0000 0226 			{
; 0000 0227 	    		bRES_=1;
	LDI  R30,LOW(1)
	STS  _bRES_,R30
; 0000 0228 	    		res_fl_=1;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMWRB
; 0000 0229 	    		}
; 0000 022A     		}
_0x16A:
; 0000 022B 	}
_0x167:
; 0000 022C else link=OFF;
	RJMP _0x16B
_0x164:
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 022D }
_0x16B:
	RET
; .FEND
;
;//-----------------------------------------------
;void temper_drv(void)
; 0000 0231 {
_temper_drv:
; .FSTART _temper_drv
; 0000 0232 if(T>ee_tsign) tsign_cnt++;
	CALL SUBOPT_0x22
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x16C
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3C4
; 0000 0233 else if (T<(ee_tsign-1)) tsign_cnt--;
_0x16C:
	CALL SUBOPT_0x22
	SBIW R30,1
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x16E
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3C4:
	ST   -X,R31
	ST   -X,R30
; 0000 0234 
; 0000 0235 gran(&tsign_cnt,0,60);
_0x16E:
	LDI  R30,LOW(_tsign_cnt)
	LDI  R31,HIGH(_tsign_cnt)
	CALL SUBOPT_0x33
; 0000 0236 
; 0000 0237 if(tsign_cnt>=55)
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,55
	BRLT _0x16F
; 0000 0238 	{
; 0000 0239 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0x171
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x173
_0x171:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x170
_0x173:
	LDS  R30,_flags
	ORI  R30,4
	STS  _flags,R30
; 0000 023A 	}
_0x170:
; 0000 023B else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
	RJMP _0x175
_0x16F:
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,6
	BRGE _0x176
	LDS  R30,_flags
	ANDI R30,0xFB
	STS  _flags,R30
; 0000 023C 
; 0000 023D 
; 0000 023E 
; 0000 023F 
; 0000 0240 if(T>ee_tmax) tmax_cnt++;
_0x176:
_0x175:
	CALL SUBOPT_0x21
	CALL SUBOPT_0x32
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x177
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3C5
; 0000 0241 else if (T<(ee_tmax-1)) tmax_cnt--;
_0x177:
	CALL SUBOPT_0x21
	SBIW R30,1
	CALL SUBOPT_0x32
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x179
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3C5:
	ST   -X,R31
	ST   -X,R30
; 0000 0242 
; 0000 0243 gran(&tmax_cnt,0,60);
_0x179:
	LDI  R30,LOW(_tmax_cnt)
	LDI  R31,HIGH(_tmax_cnt)
	CALL SUBOPT_0x33
; 0000 0244 
; 0000 0245 if(tmax_cnt>=55)
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,55
	BRLT _0x17A
; 0000 0246 	{
; 0000 0247 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0x17C
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x17E
_0x17C:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x17B
_0x17E:
	LDS  R30,_flags
	ORI  R30,2
	STS  _flags,R30
; 0000 0248 	}
_0x17B:
; 0000 0249 else if (tmax_cnt<=5) flags&=0b11111101;
	RJMP _0x180
_0x17A:
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,6
	BRGE _0x181
	LDS  R30,_flags
	ANDI R30,0xFD
	STS  _flags,R30
; 0000 024A 
; 0000 024B 
; 0000 024C }
_0x181:
_0x180:
	RET
; .FEND
;
;//-----------------------------------------------
;void u_drv(void)		//1Hz
; 0000 0250 {
_u_drv:
; .FSTART _u_drv
; 0000 0251 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x182
; 0000 0252 	{
; 0000 0253 	if(Ui>ee_Umax)umax_cnt++;
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x34
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x183
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x27
; 0000 0254 	else umax_cnt=0;
	RJMP _0x184
_0x183:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 0255 	gran(&umax_cnt,0,10);
_0x184:
	CALL SUBOPT_0x35
; 0000 0256 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
	BRLT _0x185
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 0257 
; 0000 0258     if(ee_AVT_MODE==0x55)
_0x185:
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BRNE _0x186
; 0000 0259         {
; 0000 025A         short temp=ee_Umax;
; 0000 025B         temp/=10;
	SBIW R28,2
;	temp -> Y+0
	CALL SUBOPT_0x1A
	ST   Y,R30
	STD  Y+1,R31
	LD   R26,Y
	LDD  R27,Y+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ST   Y,R30
	STD  Y+1,R31
; 0000 025C         temp*=9;
	LDI  R26,LOW(9)
	LDI  R27,HIGH(9)
	CALL __MULW12
	ST   Y,R30
	STD  Y+1,R31
; 0000 025D         if((Ui<temp)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
	CALL SUBOPT_0x34
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x188
	SBIS 0x9,4
	RJMP _0x189
_0x188:
	RJMP _0x187
_0x189:
	CALL SUBOPT_0x36
; 0000 025E         else umin_cnt=0;
	RJMP _0x18A
_0x187:
	CALL SUBOPT_0x37
; 0000 025F         gran(&umin_cnt,0,10);
_0x18A:
	CALL SUBOPT_0x38
; 0000 0260         if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x18B
	CALL SUBOPT_0x39
; 0000 0261         }
_0x18B:
	ADIW R28,2
; 0000 0262     else
	RJMP _0x18C
_0x186:
; 0000 0263         {
; 0000 0264         if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
	LDS  R30,_Un
	LDS  R31,_Un+1
	CALL SUBOPT_0x34
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x18E
	CALL SUBOPT_0x34
	LDS  R30,_Un
	LDS  R31,_Un+1
	SUB  R30,R26
	SBC  R31,R27
	MOVW R0,R30
	LDI  R26,LOW(_ee_dU)
	LDI  R27,HIGH(_ee_dU)
	CALL __EEPROMRDW
	CP   R30,R0
	CPC  R31,R1
	BRSH _0x18E
	SBIS 0x9,4
	RJMP _0x18F
_0x18E:
	RJMP _0x18D
_0x18F:
	CALL SUBOPT_0x36
; 0000 0265         else umin_cnt=0;
	RJMP _0x190
_0x18D:
	CALL SUBOPT_0x37
; 0000 0266         gran(&umin_cnt,0,10);
_0x190:
	CALL SUBOPT_0x38
; 0000 0267         if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x191
	CALL SUBOPT_0x39
; 0000 0268 
; 0000 0269         }
_0x191:
_0x18C:
; 0000 026A 	}
; 0000 026B else if(jp_mode==jp3)
	RJMP _0x192
_0x182:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x193
; 0000 026C 	{
; 0000 026D 	if(Ui>700)umax_cnt++;
	CALL SUBOPT_0x34
	CPI  R26,LOW(0x2BD)
	LDI  R30,HIGH(0x2BD)
	CPC  R27,R30
	BRLO _0x194
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x27
; 0000 026E 	else umax_cnt=0;
	RJMP _0x195
_0x194:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 026F 	gran(&umax_cnt,0,10);
_0x195:
	CALL SUBOPT_0x35
; 0000 0270 	if(umax_cnt>=10)flags|=0b00001000;
	BRLT _0x196
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 0271 
; 0000 0272 
; 0000 0273 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
_0x196:
	CALL SUBOPT_0x34
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRSH _0x198
	SBIS 0x9,4
	RJMP _0x199
_0x198:
	RJMP _0x197
_0x199:
	CALL SUBOPT_0x36
; 0000 0274 	else umin_cnt=0;
	RJMP _0x19A
_0x197:
	CALL SUBOPT_0x37
; 0000 0275 	gran(&umin_cnt,0,10);
_0x19A:
	CALL SUBOPT_0x38
; 0000 0276 	if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x19B
	CALL SUBOPT_0x39
; 0000 0277 	}
_0x19B:
; 0000 0278 }
_0x193:
_0x192:
	RET
; .FEND
;
;//-----------------------------------------------
;void led_hndl_1(void)
; 0000 027C {
; 0000 027D if(jp_mode!=jp3)
; 0000 027E 	{
; 0000 027F 	if(main_cnt1<(5*TZAS))
; 0000 0280 		{
; 0000 0281 		led_red=0x00000000L;
; 0000 0282 		led_green=0x03030303L;
; 0000 0283 		}
; 0000 0284 	else if((link==ON)&&(flags_tu&0b10000000))
; 0000 0285 		{
; 0000 0286 		led_red=0x00055555L;
; 0000 0287  		led_green=0xffffffffL;
; 0000 0288  		}
; 0000 0289 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
; 0000 028A 		{
; 0000 028B 		led_red=0x00000000L;
; 0000 028C 		led_green=0xffffffffL;
; 0000 028D 		}
; 0000 028E 
; 0000 028F 	else  if(link==OFF)
; 0000 0290  		{
; 0000 0291  		led_red=0x55555555L;
; 0000 0292  		led_green=0xffffffffL;
; 0000 0293  		}
; 0000 0294 
; 0000 0295 	else if((link==ON)&&((flags&0b00111110)==0))
; 0000 0296 		{
; 0000 0297 		led_red=0x00000000L;
; 0000 0298 		led_green=0xffffffffL;
; 0000 0299 		}
; 0000 029A 
; 0000 029B 
; 0000 029C 
; 0000 029D 
; 0000 029E 
; 0000 029F 	else if((flags&0b00111110)==0b00000100)
; 0000 02A0 		{
; 0000 02A1 		led_red=0x00010001L;
; 0000 02A2 		led_green=0xffffffffL;
; 0000 02A3 		}
; 0000 02A4 	else if(flags&0b00000010)
; 0000 02A5 		{
; 0000 02A6 		led_red=0x00010001L;
; 0000 02A7 		led_green=0x00000000L;
; 0000 02A8 		}
; 0000 02A9 	else if(flags&0b00001000)
; 0000 02AA 		{
; 0000 02AB 		led_red=0x00090009L;
; 0000 02AC 		led_green=0x00000000L;
; 0000 02AD 		}
; 0000 02AE 	else if(flags&0b00010000)
; 0000 02AF 		{
; 0000 02B0 		led_red=0x00490049L;
; 0000 02B1 		led_green=0x00000000L;
; 0000 02B2 		}
; 0000 02B3 
; 0000 02B4 	else if((link==ON)&&(flags&0b00100000))
; 0000 02B5 		{
; 0000 02B6 		led_red=0x00000000L;
; 0000 02B7 		led_green=0x00030003L;
; 0000 02B8 		}
; 0000 02B9 
; 0000 02BA 	if((jp_mode==jp1))
; 0000 02BB 		{
; 0000 02BC 		led_red=0x00000000L;
; 0000 02BD 		led_green=0x33333333L;
; 0000 02BE 		}
; 0000 02BF 	else if((jp_mode==jp2))
; 0000 02C0 		{
; 0000 02C1 		led_red=0xccccccccL;
; 0000 02C2 		led_green=0x00000000L;
; 0000 02C3 		}
; 0000 02C4 	}
; 0000 02C5 else if(jp_mode==jp3)
; 0000 02C6 	{
; 0000 02C7 	if(main_cnt1<(5*TZAS))
; 0000 02C8 		{
; 0000 02C9 		led_red=0x00000000L;
; 0000 02CA 		led_green=0x03030303L;
; 0000 02CB 		}
; 0000 02CC 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
; 0000 02CD 		{
; 0000 02CE 		led_red=0x00000000L;
; 0000 02CF 		led_green=0xffffffffL;
; 0000 02D0 		}
; 0000 02D1 
; 0000 02D2 	else if((flags&0b00011110)==0)
; 0000 02D3 		{
; 0000 02D4 		led_red=0x00000000L;
; 0000 02D5 		led_green=0xffffffffL;
; 0000 02D6 		}
; 0000 02D7 
; 0000 02D8 
; 0000 02D9 	else if((flags&0b00111110)==0b00000100)
; 0000 02DA 		{
; 0000 02DB 		led_red=0x00010001L;
; 0000 02DC 		led_green=0xffffffffL;
; 0000 02DD 		}
; 0000 02DE 	else if(flags&0b00000010)
; 0000 02DF 		{
; 0000 02E0 		led_red=0x00010001L;
; 0000 02E1 		led_green=0x00000000L;
; 0000 02E2 		}
; 0000 02E3 	else if(flags&0b00001000)
; 0000 02E4 		{
; 0000 02E5 		led_red=0x00090009L;
; 0000 02E6 		led_green=0x00000000L;
; 0000 02E7 		}
; 0000 02E8 	else if(flags&0b00010000)
; 0000 02E9 		{
; 0000 02EA 		led_red=0x00490049L;
; 0000 02EB 		led_green=0xffffffffL;
; 0000 02EC 		}
; 0000 02ED 		/*led_green=0x33333333L;
; 0000 02EE 		led_red=0xccccccccL;*/
; 0000 02EF 	}
; 0000 02F0 
; 0000 02F1 }
;
;//-----------------------------------------------
;void led_hndl(void)
; 0000 02F5 {
_led_hndl:
; .FSTART _led_hndl
; 0000 02F6 if(adress_error)
	LDS  R30,_adress_error
	CPI  R30,0
	BREQ _0x1CC
; 0000 02F7 	{
; 0000 02F8 	led_red=0x55555555L;
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3B
; 0000 02F9 	led_green=0x55555555L;
	CALL SUBOPT_0x3A
	RJMP _0x3CA
; 0000 02FA 	}
; 0000 02FB 
; 0000 02FC /*else if(bps_class==bpsIBEP)		//проверка работы адресатора
; 0000 02FD 	{
; 0000 02FE 	if(adress==0)led_red=0x00000001L;
; 0000 02FF 	if(adress==1)led_red=0x00000005L;
; 0000 0300 	if(adress==2)led_red=0x00000015L;
; 0000 0301 	if(adress==3)led_red=0x00000055L;
; 0000 0302 	if(adress==4)led_red=0x00000155L;
; 0000 0303 	if(adress==5)led_red=0x00111111L;
; 0000 0304 	if(adress==6)led_red=0x01111111L;
; 0000 0305 	if(adress==7)led_red=0x11111111L;
; 0000 0306 	led_green=0x00000000L;
; 0000 0307 	}*/
; 0000 0308 /*		else  if(link==OFF)
; 0000 0309 			{
; 0000 030A 			led_red=0x555ff555L;
; 0000 030B 			led_green=0xffffffffL;
; 0000 030C 			}
; 0000 030D else if(link_cnt>50)
; 0000 030E 	{
; 0000 030F 	led_red=0x5555ff55L;
; 0000 0310 	led_green=0x55555555L;
; 0000 0311 	} */
; 0000 0312 else if(ee_AVT_MODE==0x55)
_0x1CC:
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x1CE
; 0000 0313 	{
; 0000 0314 
; 0000 0315     led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0316 	led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x3E
; 0000 0317 
; 0000 0318 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x1CF
; 0000 0319 		{
; 0000 031A /*		if(main_cnt1<(5*ee_TZAS))
; 0000 031B 			{
; 0000 031C 			led_red=0x00000000L;
; 0000 031D 			led_green=0x03030303L;
; 0000 031E 			}
; 0000 031F 
; 0000 0320 		else if((link==ON)&&(flags_tu&0b10000000))
; 0000 0321 			{
; 0000 0322 			led_red=0x00055555L;
; 0000 0323 			led_green=0xffffffffL;
; 0000 0324 			}   */
; 0000 0325 
; 0000 0326 /*		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
; 0000 0327 			{
; 0000 0328 			led_red=0x00000000L;
; 0000 0329 			led_green=0xffffffffL;
; 0000 032A 			} */
; 0000 032B 
; 0000 032C /*		else  if(link==OFF)
; 0000 032D 			{
; 0000 032E 			led_red=0x55555555L;
; 0000 032F 			led_green=0xffffffffL;
; 0000 0330 			}
; 0000 0331 
; 0000 0332 		else*/ if((link==ON)&&((flags&0b00111110)==0))
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1D1
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x1D2
_0x1D1:
	RJMP _0x1D0
_0x1D2:
; 0000 0333 			{
; 0000 0334 			led_red=0x00000111L;
	__GETD1N 0x111
	CALL SUBOPT_0x3B
; 0000 0335 			led_green=0x00000111L;
	__GETD1N 0x111
	RJMP _0x3CB
; 0000 0336 			}
; 0000 0337 
; 0000 0338 		else if((flags&0b00111110)==0b00000100)
_0x1D0:
	CALL SUBOPT_0x3F
	BRNE _0x1D4
; 0000 0339 			{
; 0000 033A 			led_red=0x00010001L;
	CALL SUBOPT_0x40
	RJMP _0x3CC
; 0000 033B 			led_green=0xffffffffL;
; 0000 033C 			}
; 0000 033D 		else if(flags&0b00000010)
_0x1D4:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x1D6
; 0000 033E 			{
; 0000 033F 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 0340 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 0341 			}
; 0000 0342 		else if(flags&0b00001000)
	RJMP _0x1D7
_0x1D6:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x1D8
; 0000 0343 			{
; 0000 0344 			led_red=0x00090009L;
	CALL SUBOPT_0x43
; 0000 0345 			led_green=0x00000000L;
; 0000 0346 			}
; 0000 0347 		else if(flags&0b00010000)
	RJMP _0x1D9
_0x1D8:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x1DA
; 0000 0348 			{
; 0000 0349 			led_red=0x00490049L;
	CALL SUBOPT_0x44
_0x3CC:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 034A 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
_0x3CB:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 034B 			}
; 0000 034C 
; 0000 034D /*		else if((link==ON)&&(flags&0b00100000))
; 0000 034E 			{
; 0000 034F 			led_red=0x00000000L;
; 0000 0350 			led_green=0x00030003L;
; 0000 0351 			} */
; 0000 0352 
; 0000 0353 		if((jp_mode==jp1))
_0x1DA:
_0x1D9:
_0x1D7:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x1DB
; 0000 0354 			{
; 0000 0355 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0356 			led_green=0x33333333L;
	CALL SUBOPT_0x45
; 0000 0357 			}
; 0000 0358 		else if((jp_mode==jp2))
	RJMP _0x1DC
_0x1DB:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x1DD
; 0000 0359 			{
; 0000 035A 			led_red=0xccccccccL;
	CALL SUBOPT_0x46
; 0000 035B 			led_green=0x00000000L;
; 0000 035C 			}
; 0000 035D 		}
_0x1DD:
_0x1DC:
; 0000 035E 
; 0000 035F /*    if(umin_cnt)
; 0000 0360         {
; 0000 0361         led_red=0x00c900c9L;
; 0000 0362 		led_green=0x00c000c0L;
; 0000 0363         } */
; 0000 0364 	}
_0x1CF:
; 0000 0365 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
	RJMP _0x1DE
_0x1CE:
	LDS  R30,_bps_class
	CPI  R30,0
	BREQ PC+2
	RJMP _0x1DF
; 0000 0366 	{
; 0000 0367 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x1E0
; 0000 0368 		{
; 0000 0369 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x1E1
; 0000 036A 			{
; 0000 036B 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 036C 			led_green=0x03030303L;
	CALL SUBOPT_0x48
	RJMP _0x3CD
; 0000 036D 			}
; 0000 036E 
; 0000 036F 		else if((link==ON)&&(flags_tu&0b10000000))
_0x1E1:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1E4
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x1E5
_0x1E4:
	RJMP _0x1E3
_0x1E5:
; 0000 0370 			{
; 0000 0371 			led_red=0x00055555L;
	CALL SUBOPT_0x49
; 0000 0372 			led_green=0xffffffffL;
	RJMP _0x3CD
; 0000 0373 			}
; 0000 0374 
; 0000 0375 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
_0x1E3:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x1E8
	CALL SUBOPT_0x4A
	BRLT _0x1E9
_0x1E8:
	RJMP _0x1EA
_0x1E9:
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x1EA
	CALL SUBOPT_0x23
	SBIW R30,0
	BREQ _0x1EB
_0x1EA:
	RJMP _0x1E7
_0x1EB:
; 0000 0376 			{
; 0000 0377 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0378 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	RJMP _0x3CD
; 0000 0379 			}
; 0000 037A 
; 0000 037B 		else  if(link==OFF)
_0x1E7:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x1ED
; 0000 037C 			{
; 0000 037D 			led_red=0x55555555L;
	CALL SUBOPT_0x4B
; 0000 037E 			led_green=0xffffffffL;
	RJMP _0x3CD
; 0000 037F 			}
; 0000 0380 
; 0000 0381 		else if((link==ON)&&((flags&0b00111110)==0))
_0x1ED:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1F0
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x1F1
_0x1F0:
	RJMP _0x1EF
_0x1F1:
; 0000 0382 			{
; 0000 0383 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0384 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	RJMP _0x3CD
; 0000 0385 			}
; 0000 0386 
; 0000 0387 		else if((flags&0b00111110)==0b00000100)
_0x1EF:
	CALL SUBOPT_0x3F
	BRNE _0x1F3
; 0000 0388 			{
; 0000 0389 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 038A 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	RJMP _0x3CD
; 0000 038B 			}
; 0000 038C 		else if(flags&0b00000010)
_0x1F3:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x1F5
; 0000 038D 			{
; 0000 038E 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 038F 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 0390 			}
; 0000 0391 		else if(flags&0b00001000)
	RJMP _0x1F6
_0x1F5:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x1F7
; 0000 0392 			{
; 0000 0393 			led_red=0x00090009L;
	CALL SUBOPT_0x43
; 0000 0394 			led_green=0x00000000L;
; 0000 0395 			}
; 0000 0396 		else if(flags&0b00010000)
	RJMP _0x1F8
_0x1F7:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x1F9
; 0000 0397 			{
; 0000 0398 			led_red=0x00490049L;
	CALL SUBOPT_0x4C
; 0000 0399 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 039A 			}
; 0000 039B 
; 0000 039C 		else if((link==ON)&&(flags&0b00100000))
	RJMP _0x1FA
_0x1F9:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1FC
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x1FD
_0x1FC:
	RJMP _0x1FB
_0x1FD:
; 0000 039D 			{
; 0000 039E 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 039F 			led_green=0x00030003L;
	__GETD1N 0x30003
_0x3CD:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03A0 			}
; 0000 03A1 
; 0000 03A2 		if((jp_mode==jp1))
_0x1FB:
_0x1FA:
_0x1F8:
_0x1F6:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x1FE
; 0000 03A3 			{
; 0000 03A4 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03A5 			led_green=0x33333333L;
	CALL SUBOPT_0x45
; 0000 03A6 			}
; 0000 03A7 		else if((jp_mode==jp2))
	RJMP _0x1FF
_0x1FE:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x200
; 0000 03A8 			{
; 0000 03A9 			led_red=0xccccccccL;
	CALL SUBOPT_0x46
; 0000 03AA 			led_green=0x00000000L;
; 0000 03AB 			}
; 0000 03AC 		}
_0x200:
_0x1FF:
; 0000 03AD 	else if(jp_mode==jp3)
	RJMP _0x201
_0x1E0:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0x202
; 0000 03AE 		{
; 0000 03AF 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x203
; 0000 03B0 			{
; 0000 03B1 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03B2 			led_green=0x03030303L;
	CALL SUBOPT_0x48
	RJMP _0x3CE
; 0000 03B3 			}
; 0000 03B4 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
_0x203:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x206
	CALL SUBOPT_0x4D
	BRLT _0x207
_0x206:
	RJMP _0x205
_0x207:
; 0000 03B5 			{
; 0000 03B6 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03B7 			led_green=0xffffffffL;
	RJMP _0x3CF
; 0000 03B8 			}
; 0000 03B9 
; 0000 03BA 		else if((flags&0b00011110)==0)
_0x205:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x209
; 0000 03BB 			{
; 0000 03BC 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03BD 			led_green=0xffffffffL;
	RJMP _0x3CF
; 0000 03BE 			}
; 0000 03BF 
; 0000 03C0 
; 0000 03C1 		else if((flags&0b00111110)==0b00000100)
_0x209:
	CALL SUBOPT_0x3F
	BRNE _0x20B
; 0000 03C2 			{
; 0000 03C3 			led_red=0x00010001L;
	CALL SUBOPT_0x40
	RJMP _0x3D0
; 0000 03C4 			led_green=0xffffffffL;
; 0000 03C5 			}
; 0000 03C6 		else if(flags&0b00000010)
_0x20B:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x20D
; 0000 03C7 			{
; 0000 03C8 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 03C9 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 03CA 			}
; 0000 03CB 		else if(flags&0b00001000)
	RJMP _0x20E
_0x20D:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x20F
; 0000 03CC 			{
; 0000 03CD 			led_red=0x00090009L;
	CALL SUBOPT_0x43
; 0000 03CE 			led_green=0x00000000L;
; 0000 03CF 			}
; 0000 03D0 		else if(flags&0b00010000)
	RJMP _0x210
_0x20F:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x211
; 0000 03D1 			{
; 0000 03D2 			led_red=0x00490049L;
	CALL SUBOPT_0x44
_0x3D0:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 03D3 			led_green=0xffffffffL;
_0x3CF:
	__GETD1N 0xFFFFFFFF
_0x3CE:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03D4 			}
; 0000 03D5 		}
_0x211:
_0x210:
_0x20E:
; 0000 03D6 	}
_0x202:
_0x201:
; 0000 03D7 else if(bps_class==bpsIPS)	//если блок ИПСный
	RJMP _0x212
_0x1DF:
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x213
; 0000 03D8 	{
; 0000 03D9 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x214
; 0000 03DA 		{
; 0000 03DB 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x215
; 0000 03DC 			{
; 0000 03DD 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03DE 			led_green=0x03030303L;
	CALL SUBOPT_0x48
	RJMP _0x3D1
; 0000 03DF 			}
; 0000 03E0 
; 0000 03E1 		else if((link==ON)&&(flags_tu&0b10000000))
_0x215:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x218
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x219
_0x218:
	RJMP _0x217
_0x219:
; 0000 03E2 			{
; 0000 03E3 			led_red=0x00055555L;
	CALL SUBOPT_0x49
; 0000 03E4 			led_green=0xffffffffL;
	RJMP _0x3D1
; 0000 03E5 			}
; 0000 03E6 
; 0000 03E7 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
_0x217:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x21C
	CALL SUBOPT_0x4A
	BRLT _0x21D
_0x21C:
	RJMP _0x21E
_0x21D:
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x21E
	CALL SUBOPT_0x23
	SBIW R30,0
	BREQ _0x21F
_0x21E:
	RJMP _0x21B
_0x21F:
; 0000 03E8 			{
; 0000 03E9 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03EA 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	RJMP _0x3D1
; 0000 03EB 			}
; 0000 03EC 
; 0000 03ED 		else  if(link==OFF)
_0x21B:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ PC+2
	RJMP _0x221
; 0000 03EE 			{
; 0000 03EF 			if((flags&0b00011110)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x222
; 0000 03F0 				{
; 0000 03F1 				led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 03F2 				if(bMAIN)led_green=0xfffffff5L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x223
	__GETD1N 0xFFFFFFF5
	RJMP _0x3D2
; 0000 03F3 				else led_green=0xffffffffL;
_0x223:
	CALL SUBOPT_0x3D
_0x3D2:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03F4 				}
; 0000 03F5 
; 0000 03F6 			else if((flags&0b00111110)==0b00000100)
	RJMP _0x225
_0x222:
	CALL SUBOPT_0x3F
	BRNE _0x226
; 0000 03F7 				{
; 0000 03F8 				led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 03F9 				if(bMAIN)led_green=0xfffffff5L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x227
	__GETD1N 0xFFFFFFF5
	RJMP _0x3D3
; 0000 03FA 				else led_green=0xffffffffL;
_0x227:
	CALL SUBOPT_0x3D
_0x3D3:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03FB 				}
; 0000 03FC 			else if(flags&0b00000010)
	RJMP _0x229
_0x226:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x22A
; 0000 03FD 				{
; 0000 03FE 				led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 03FF 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x22B
	CALL SUBOPT_0x4E
; 0000 0400 				else led_green=0x00000000L;
	RJMP _0x22C
_0x22B:
	CALL SUBOPT_0x42
; 0000 0401 				}
_0x22C:
; 0000 0402 			else if(flags&0b00001000)
	RJMP _0x22D
_0x22A:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x22E
; 0000 0403 				{
; 0000 0404 				led_red=0x00090009L;
	__GETD1N 0x90009
	CALL SUBOPT_0x3B
; 0000 0405 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x22F
	CALL SUBOPT_0x4E
; 0000 0406 				else led_green=0x00000000L;
	RJMP _0x230
_0x22F:
	CALL SUBOPT_0x42
; 0000 0407 				}
_0x230:
; 0000 0408 			else if(flags&0b00010000)
	RJMP _0x231
_0x22E:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x232
; 0000 0409 				{
; 0000 040A 				led_red=0x00490049L;
	CALL SUBOPT_0x4C
; 0000 040B 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x233
	CALL SUBOPT_0x4E
; 0000 040C 				else led_green=0x00000000L;
	RJMP _0x234
_0x233:
	CALL SUBOPT_0x42
; 0000 040D 				}
_0x234:
; 0000 040E 			else
	RJMP _0x235
_0x232:
; 0000 040F 				{
; 0000 0410 				led_red=0x55555555L;
	CALL SUBOPT_0x4B
; 0000 0411 				led_green=0xffffffffL;
	CALL SUBOPT_0x3E
; 0000 0412 				}
_0x235:
_0x231:
_0x22D:
_0x229:
_0x225:
; 0000 0413 
; 0000 0414 
; 0000 0415 /*			if(bMAIN)
; 0000 0416 				{
; 0000 0417 				led_red=0x0L;
; 0000 0418 				led_green=0xfffffff5L;
; 0000 0419 				}
; 0000 041A 			else
; 0000 041B 				{
; 0000 041C 				led_red=0x55555555L;
; 0000 041D 				led_green=0xffffffffL;
; 0000 041E 				}*/
; 0000 041F 			}
; 0000 0420 
; 0000 0421 		else if((link==ON)&&((flags&0b00111110)==0))
	RJMP _0x236
_0x221:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x238
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x239
_0x238:
	RJMP _0x237
_0x239:
; 0000 0422 			{
; 0000 0423 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0424 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	RJMP _0x3D1
; 0000 0425 			}
; 0000 0426 
; 0000 0427 		else if((flags&0b00111110)==0b00000100)
_0x237:
	CALL SUBOPT_0x3F
	BRNE _0x23B
; 0000 0428 			{
; 0000 0429 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 042A 			led_green=0xffffffffL;
	CALL SUBOPT_0x3D
	RJMP _0x3D1
; 0000 042B 			}
; 0000 042C 		else if(flags&0b00000010)
_0x23B:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x23D
; 0000 042D 			{
; 0000 042E 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 042F 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 0430 			}
; 0000 0431 		else if(flags&0b00001000)
	RJMP _0x23E
_0x23D:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x23F
; 0000 0432 			{
; 0000 0433 			led_red=0x00090009L;
	CALL SUBOPT_0x43
; 0000 0434 			led_green=0x00000000L;
; 0000 0435 			}
; 0000 0436 		else if(flags&0b00010000)
	RJMP _0x240
_0x23F:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x241
; 0000 0437 			{
; 0000 0438 			led_red=0x00490049L;
	CALL SUBOPT_0x4C
; 0000 0439 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 043A 			}
; 0000 043B 
; 0000 043C 		else if((link==ON)&&(flags&0b00100000))
	RJMP _0x242
_0x241:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x244
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x245
_0x244:
	RJMP _0x243
_0x245:
; 0000 043D 			{
; 0000 043E 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 043F 			led_green=0x00030003L;
	__GETD1N 0x30003
_0x3D1:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0440 			}
; 0000 0441 
; 0000 0442 		if((jp_mode==jp1))
_0x243:
_0x242:
_0x240:
_0x23E:
_0x236:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x246
; 0000 0443 			{
; 0000 0444 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0445 			led_green=0x33333333L;
	CALL SUBOPT_0x45
; 0000 0446 			}
; 0000 0447 		else if((jp_mode==jp2))
	RJMP _0x247
_0x246:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x248
; 0000 0448 			{
; 0000 0449 			//if(ee_DEVICE)led_red=0xccccccacL;
; 0000 044A 			//else led_red=0xcc0cccacL;
; 0000 044B 			led_red=0xccccccccL;
	CALL SUBOPT_0x46
; 0000 044C 			led_green=0x00000000L;
; 0000 044D 			}
; 0000 044E 		}
_0x248:
_0x247:
; 0000 044F 	else if(jp_mode==jp3)
	RJMP _0x249
_0x214:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0x24A
; 0000 0450 		{
; 0000 0451 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x24B
; 0000 0452 			{
; 0000 0453 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0454 			led_green=0x03030303L;
	CALL SUBOPT_0x48
	RJMP _0x3CA
; 0000 0455 			}
; 0000 0456 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
_0x24B:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x24E
	CALL SUBOPT_0x4D
	BRLT _0x24F
_0x24E:
	RJMP _0x24D
_0x24F:
; 0000 0457 			{
; 0000 0458 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 0459 			led_green=0xffffffffL;
	RJMP _0x3D4
; 0000 045A 			}
; 0000 045B 
; 0000 045C 		else if((flags&0b00011110)==0)
_0x24D:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x251
; 0000 045D 			{
; 0000 045E 			led_red=0x00000000L;
	CALL SUBOPT_0x3C
; 0000 045F 			led_green=0xffffffffL;
	RJMP _0x3D4
; 0000 0460 			}
; 0000 0461 
; 0000 0462 
; 0000 0463 		else if((flags&0b00111110)==0b00000100)
_0x251:
	CALL SUBOPT_0x3F
	BRNE _0x253
; 0000 0464 			{
; 0000 0465 			led_red=0x00010001L;
	CALL SUBOPT_0x40
	RJMP _0x3D5
; 0000 0466 			led_green=0xffffffffL;
; 0000 0467 			}
; 0000 0468 		else if(flags&0b00000010)
_0x253:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x255
; 0000 0469 			{
; 0000 046A 			led_red=0x00010001L;
	CALL SUBOPT_0x41
; 0000 046B 			led_green=0x00000000L;
	CALL SUBOPT_0x42
; 0000 046C 			}
; 0000 046D 		else if(flags&0b00001000)
	RJMP _0x256
_0x255:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x257
; 0000 046E 			{
; 0000 046F 			led_red=0x00090009L;
	CALL SUBOPT_0x43
; 0000 0470 			led_green=0x00000000L;
; 0000 0471 			}
; 0000 0472 		else if(flags&0b00010000)
	RJMP _0x258
_0x257:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x259
; 0000 0473 			{
; 0000 0474 			led_red=0x00490049L;
	CALL SUBOPT_0x44
_0x3D5:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 0475 			led_green=0xffffffffL;
_0x3D4:
	__GETD1N 0xFFFFFFFF
_0x3CA:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0476 			}
; 0000 0477 		}
_0x259:
_0x258:
_0x256:
; 0000 0478 	}
_0x24A:
_0x249:
; 0000 0479 }
_0x213:
_0x212:
_0x1DE:
	RET
; .FEND
;
;
;
;
;//-----------------------------------------------
;void pwr_drv_(void)
; 0000 0480 {
; 0000 0481 DDRD.4=1;
; 0000 0482 
; 0000 0483 if(main_cnt1<150)main_cnt1++;
; 0000 0484 
; 0000 0485 if(main_cnt1<(5*TZAS))
; 0000 0486 	{
; 0000 0487 	PORTD.4=1;
; 0000 0488 	}
; 0000 0489 else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
; 0000 048A 	{
; 0000 048B 	PORTD.4=0;
; 0000 048C 	}
; 0000 048D else if(bBL)
; 0000 048E 	{
; 0000 048F 	PORTD.4=1;
; 0000 0490 	}
; 0000 0491 else if(!bBL)
; 0000 0492 	{
; 0000 0493 	PORTD.4=0;
; 0000 0494 	}
; 0000 0495 
; 0000 0496 //DDRB|=0b00000010;
; 0000 0497 
; 0000 0498 gran(&pwm_u,2,1020);
; 0000 0499 
; 0000 049A 
; 0000 049B OCR1A=pwm_u;
; 0000 049C /*PORTB.2=1;
; 0000 049D OCR1A=0;*/
; 0000 049E }
;
;//-----------------------------------------------
;//Вентилятор
;void vent_drv(void)
; 0000 04A3 {
_vent_drv:
; .FSTART _vent_drv
; 0000 04A4 
; 0000 04A5 
; 0000 04A6 	short vent_pwm_i_necc=400;
; 0000 04A7 	short vent_pwm_t_necc=400;
; 0000 04A8 	short vent_pwm_max_necc=400;
; 0000 04A9 	signed long tempSL;
; 0000 04AA 
; 0000 04AB 	//I=1200;
; 0000 04AC 
; 0000 04AD 	tempSL=36000L/(signed long)ee_Umax;
	SBIW R28,4
	CALL __SAVELOCR6
;	vent_pwm_i_necc -> R16,R17
;	vent_pwm_t_necc -> R18,R19
;	vent_pwm_max_necc -> R20,R21
;	tempSL -> Y+6
	__GETWRN 16,17,400
	__GETWRN 18,19,400
	__GETWRN 20,21,400
	CALL SUBOPT_0x1A
	CALL __CWD1
	__GETD2N 0x8CA0
	CALL SUBOPT_0x4F
; 0000 04AE 	tempSL=(signed long)I/tempSL;
	LDS  R26,_I
	LDS  R27,_I+1
	CLR  R24
	CLR  R25
	__GETD1S 6
	CALL SUBOPT_0x4F
; 0000 04AF 
; 0000 04B0 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x26E
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMRDW
	LDS  R26,_I
	LDS  R27,_I+1
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	__PUTD1S 6
; 0000 04B1 
; 0000 04B2 	if(tempSL>10)vent_pwm_i_necc=1000;
_0x26E:
	CALL SUBOPT_0x50
	__CPD2N 0xB
	BRLT _0x26F
	__GETWRN 16,17,1000
; 0000 04B3 	else if(tempSL<1)vent_pwm_i_necc=400;
	RJMP _0x270
_0x26F:
	CALL SUBOPT_0x50
	__CPD2N 0x1
	BRGE _0x271
	__GETWRN 16,17,400
; 0000 04B4 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
	RJMP _0x272
_0x271:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(60)
	LDI  R27,HIGH(60)
	CALL __MULW12
	SUBI R30,LOW(-400)
	SBCI R31,HIGH(-400)
	MOVW R16,R30
; 0000 04B5 	gran(&vent_pwm_i_necc,400,1000);
_0x272:
_0x270:
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL SUBOPT_0x51
	RCALL _gran
	POP  R16
	POP  R17
; 0000 04B6 	//vent_pwm_i_necc=400;
; 0000 04B7 	tempSL=(signed long)T;
	LDS  R30,_T
	LDS  R31,_T+1
	CALL __CWD1
	__PUTD1S 6
; 0000 04B8 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
	CALL SUBOPT_0x22
	CALL __CWD1
	__SUBD1N 30
	CALL SUBOPT_0x50
	CALL __CPD12
	BRLT _0x273
	__GETWRN 18,19,400
; 0000 04B9 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
	RJMP _0x274
_0x273:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x50
	CALL __CWD1
	CALL __CPD21
	BRLT _0x275
	__GETWRN 18,19,1000
; 0000 04BA 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
	RJMP _0x276
_0x275:
	CALL SUBOPT_0x22
	SBIW R30,30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12
	SUBI R30,LOW(-400)
	SBCI R31,HIGH(-400)
	MOVW R18,R30
; 0000 04BB 	gran(&vent_pwm_t_necc,400,1000);
_0x276:
_0x274:
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R19
	PUSH R18
	CALL SUBOPT_0x51
	RCALL _gran
	POP  R18
	POP  R19
; 0000 04BC 
; 0000 04BD 	vent_pwm_max_necc=vent_pwm_i_necc;
	MOVW R20,R16
; 0000 04BE 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
	__CPWRR 16,17,18,19
	BRGE _0x277
	MOVW R20,R18
; 0000 04BF 
; 0000 04C0 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
_0x277:
	CALL SUBOPT_0x52
	CP   R26,R20
	CPC  R27,R21
	BRGE _0x278
	LDS  R30,_vent_pwm
	LDS  R31,_vent_pwm+1
	ADIW R30,10
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R31
; 0000 04C1 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
_0x278:
	CALL SUBOPT_0x52
	CP   R20,R26
	CPC  R21,R27
	BRGE _0x279
	LDS  R30,_vent_pwm
	LDS  R31,_vent_pwm+1
	SBIW R30,10
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R31
; 0000 04C2 	gran(&vent_pwm,400,1000);
_0x279:
	LDI  R30,LOW(_vent_pwm)
	LDI  R31,HIGH(_vent_pwm)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x51
	RCALL _gran
; 0000 04C3 
; 0000 04C4 	//vent_pwm=1000-vent_pwm;	// Для нового блока. Там похоже нужна инверсия
; 0000 04C5 	//vent_pwm=300;
; 0000 04C6 	if(bVENT_BLOCK)vent_pwm=0;
	LDS  R30,_bVENT_BLOCK
	CPI  R30,0
	BREQ _0x27A
	LDI  R30,LOW(0)
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R30
; 0000 04C7 }
_0x27A:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;
;//-----------------------------------------------
;void vent_resurs_hndl(void)
; 0000 04CB {
_vent_resurs_hndl:
; .FSTART _vent_resurs_hndl
; 0000 04CC unsigned char temp;
; 0000 04CD if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
	ST   -Y,R17
;	temp -> R17
	LDS  R30,_bVENT_BLOCK
	CPI  R30,0
	BRNE _0x27B
	LDI  R26,LOW(_vent_resurs_sec_cnt)
	LDI  R27,HIGH(_vent_resurs_sec_cnt)
	CALL SUBOPT_0x27
; 0000 04CE if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
_0x27B:
	LDS  R26,_vent_resurs_sec_cnt
	LDS  R27,_vent_resurs_sec_cnt+1
	CPI  R26,LOW(0xE11)
	LDI  R30,HIGH(0xE11)
	CPC  R27,R30
	BRLO _0x27C
; 0000 04CF 	{
; 0000 04D0 	if(vent_resurs<60000)vent_resurs++;
	CALL SUBOPT_0x53
	CPI  R30,LOW(0xEA60)
	LDI  R26,HIGH(0xEA60)
	CPC  R31,R26
	BRSH _0x27D
	CALL SUBOPT_0x53
	ADIW R30,1
	CALL __EEPROMWRW
; 0000 04D1 	vent_resurs_sec_cnt=0;
_0x27D:
	LDI  R30,LOW(0)
	STS  _vent_resurs_sec_cnt,R30
	STS  _vent_resurs_sec_cnt+1,R30
; 0000 04D2 	}
; 0000 04D3 
; 0000 04D4 //vent_resurs=12543;
; 0000 04D5 
; 0000 04D6 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
_0x27C:
	CALL SUBOPT_0x53
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _vent_resurs_buff,R30
; 0000 04D7 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
	CALL SUBOPT_0x53
	ANDI R30,LOW(0xF0)
	ANDI R31,HIGH(0xF0)
	CALL __LSRW4
	LDI  R31,0
	ORI  R30,0x40
	__PUTB1MN _vent_resurs_buff,1
; 0000 04D8 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
	CALL SUBOPT_0x53
	ANDI R30,LOW(0xF00)
	ANDI R31,HIGH(0xF00)
	MOV  R30,R31
	LDI  R31,0
	LDI  R31,0
	ORI  R30,0x80
	__PUTB1MN _vent_resurs_buff,2
; 0000 04D9 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
	CALL SUBOPT_0x53
	ANDI R30,LOW(0xF000)
	ANDI R31,HIGH(0xF000)
	CALL __LSRW4
	MOV  R30,R31
	LDI  R31,0
	LDI  R31,0
	ORI  R30,LOW(0xC0)
	__PUTB1MN _vent_resurs_buff,3
; 0000 04DA 
; 0000 04DB temp=vent_resurs_buff[0]&0x0f;
	LDS  R30,_vent_resurs_buff
	ANDI R30,LOW(0xF)
	MOV  R17,R30
; 0000 04DC temp^=vent_resurs_buff[1]&0x0f;
	__GETB1MN _vent_resurs_buff,1
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 04DD temp^=vent_resurs_buff[2]&0x0f;
	__GETB1MN _vent_resurs_buff,2
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 04DE temp^=vent_resurs_buff[3]&0x0f;
	__GETB1MN _vent_resurs_buff,3
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 04DF 
; 0000 04E0 vent_resurs_buff[0]|=(temp&0x03)<<4;
	MOV  R30,R17
	ANDI R30,LOW(0x3)
	SWAP R30
	ANDI R30,0xF0
	LDS  R26,_vent_resurs_buff
	OR   R30,R26
	STS  _vent_resurs_buff,R30
; 0000 04E1 vent_resurs_buff[1]|=(temp&0x0c)<<2;
	__POINTW1MN _vent_resurs_buff,1
	MOVW R0,R30
	LD   R26,Z
	MOV  R30,R17
	ANDI R30,LOW(0xC)
	LSL  R30
	LSL  R30
	OR   R30,R26
	MOVW R26,R0
	ST   X,R30
; 0000 04E2 vent_resurs_buff[2]|=(temp&0x30);
	__POINTW1MN _vent_resurs_buff,2
	MOVW R0,R30
	LD   R26,Z
	MOV  R30,R17
	ANDI R30,LOW(0x30)
	OR   R30,R26
	MOVW R26,R0
	ST   X,R30
; 0000 04E3 vent_resurs_buff[3]|=(temp&0xc0)>>2;
	__POINTW1MN _vent_resurs_buff,3
	MOVW R0,R30
	LD   R26,Z
	MOV  R30,R17
	ANDI R30,LOW(0xC0)
	LSR  R30
	LSR  R30
	OR   R30,R26
	MOVW R26,R0
	ST   X,R30
; 0000 04E4 
; 0000 04E5 
; 0000 04E6 vent_resurs_tx_cnt++;
	LDS  R30,_vent_resurs_tx_cnt
	SUBI R30,-LOW(1)
	STS  _vent_resurs_tx_cnt,R30
; 0000 04E7 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
	LDS  R26,_vent_resurs_tx_cnt
	CPI  R26,LOW(0x4)
	BRLO _0x27E
	LDI  R30,LOW(0)
	STS  _vent_resurs_tx_cnt,R30
; 0000 04E8 
; 0000 04E9 
; 0000 04EA }
_0x27E:
	RJMP _0x20C0001
; .FEND
;
;//-----------------------------------------------
;void volum_u_main_drv(void)
; 0000 04EE {
_volum_u_main_drv:
; .FSTART _volum_u_main_drv
; 0000 04EF char i;
; 0000 04F0 
; 0000 04F1 if(bMAIN)
	ST   -Y,R17
;	i -> R17
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x27F
; 0000 04F2 	{
; 0000 04F3 	if(Un<(UU_AVT-10))volum_u_main_+=5;
	CALL SUBOPT_0x54
	SBIW R30,10
	CALL SUBOPT_0x55
	BRSH _0x280
	CALL SUBOPT_0x56
	ADIW R30,5
	CALL SUBOPT_0x57
; 0000 04F4 	else if(Un<(UU_AVT-1))volum_u_main_++;
	RJMP _0x281
_0x280:
	CALL SUBOPT_0x54
	SBIW R30,1
	CALL SUBOPT_0x55
	BRSH _0x282
	LDI  R26,LOW(_volum_u_main_)
	LDI  R27,HIGH(_volum_u_main_)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3D7
; 0000 04F5 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
_0x282:
	CALL SUBOPT_0x54
	ADIW R30,10
	CALL SUBOPT_0x58
	BRSH _0x284
	CALL SUBOPT_0x56
	SBIW R30,10
	CALL SUBOPT_0x57
; 0000 04F6 	else if(Un>(UU_AVT+1))volum_u_main_--;
	RJMP _0x285
_0x284:
	CALL SUBOPT_0x54
	ADIW R30,1
	CALL SUBOPT_0x58
	BRSH _0x286
	LDI  R26,LOW(_volum_u_main_)
	LDI  R27,HIGH(_volum_u_main_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3D7:
	ST   -X,R31
	ST   -X,R30
; 0000 04F7 	if(volum_u_main_>1020)volum_u_main_=1020;
_0x286:
_0x285:
_0x281:
	LDS  R26,_volum_u_main_
	LDS  R27,_volum_u_main_+1
	CPI  R26,LOW(0x3FD)
	LDI  R30,HIGH(0x3FD)
	CPC  R27,R30
	BRLT _0x287
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	CALL SUBOPT_0x57
; 0000 04F8 	if(volum_u_main_<0)volum_u_main_=0;
_0x287:
	LDS  R26,_volum_u_main_+1
	TST  R26
	BRPL _0x288
	LDI  R30,LOW(0)
	STS  _volum_u_main_,R30
	STS  _volum_u_main_+1,R30
; 0000 04F9 	//volum_u_main_=700;
; 0000 04FA 
; 0000 04FB 	i_main_sigma=0;
_0x288:
	LDI  R30,LOW(0)
	STS  _i_main_sigma,R30
	STS  _i_main_sigma+1,R30
; 0000 04FC 	i_main_num_of_bps=0;
	STS  _i_main_num_of_bps,R30
; 0000 04FD 	for(i=0;i<6;i++)
	LDI  R17,LOW(0)
_0x28A:
	CPI  R17,6
	BRSH _0x28B
; 0000 04FE 		{
; 0000 04FF 		if(i_main_flag[i])
	CALL SUBOPT_0x59
	LD   R30,Z
	CPI  R30,0
	BREQ _0x28C
; 0000 0500 			{
; 0000 0501 			i_main_sigma+=i_main[i];
	CALL SUBOPT_0x5A
	LDS  R26,_i_main_sigma
	LDS  R27,_i_main_sigma+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _i_main_sigma,R30
	STS  _i_main_sigma+1,R31
; 0000 0502 			i_main_flag[i]=1;
	CALL SUBOPT_0x59
	LDI  R26,LOW(1)
	STD  Z+0,R26
; 0000 0503 			i_main_num_of_bps++;
	LDS  R30,_i_main_num_of_bps
	SUBI R30,-LOW(1)
	STS  _i_main_num_of_bps,R30
; 0000 0504 			}
; 0000 0505 		else
	RJMP _0x28D
_0x28C:
; 0000 0506 			{
; 0000 0507 			i_main_flag[i]=0;
	CALL SUBOPT_0x59
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0000 0508 			}
_0x28D:
; 0000 0509 		}
	SUBI R17,-1
	RJMP _0x28A
_0x28B:
; 0000 050A 	i_main_avg=i_main_sigma/i_main_num_of_bps;
	LDS  R30,_i_main_num_of_bps
	LDS  R26,_i_main_sigma
	LDS  R27,_i_main_sigma+1
	LDI  R31,0
	CALL __DIVW21
	STS  _i_main_avg,R30
	STS  _i_main_avg+1,R31
; 0000 050B 	for(i=0;i<6;i++)
	LDI  R17,LOW(0)
_0x28F:
	CPI  R17,6
	BRLO PC+2
	RJMP _0x290
; 0000 050C 		{
; 0000 050D 		if(i_main_flag[i])
	CALL SUBOPT_0x59
	LD   R30,Z
	CPI  R30,0
	BREQ _0x291
; 0000 050E 			{
; 0000 050F 			if(i_main[i]<(i_main_avg-10))x[i]++;
	CALL SUBOPT_0x5A
	MOVW R26,R30
	LDS  R30,_i_main_avg
	LDS  R31,_i_main_avg+1
	SBIW R30,10
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x292
	CALL SUBOPT_0x5B
	ADIW R30,1
	RJMP _0x3D8
; 0000 0510 			else if(i_main[i]>(i_main_avg+10))x[i]--;
_0x292:
	CALL SUBOPT_0x5A
	MOVW R26,R30
	LDS  R30,_i_main_avg
	LDS  R31,_i_main_avg+1
	ADIW R30,10
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x294
	CALL SUBOPT_0x5B
	SBIW R30,1
_0x3D8:
	ST   -X,R31
	ST   -X,R30
; 0000 0511 			if(x[i]>100)x[i]=100;
_0x294:
	CALL SUBOPT_0x5C
	CALL __GETW1P
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRLT _0x295
	CALL SUBOPT_0x5C
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   X+,R30
	ST   X,R31
; 0000 0512 			if(x[i]<-100)x[i]=-100;
_0x295:
	CALL SUBOPT_0x5C
	CALL __GETW1P
	CPI  R30,LOW(0xFF9C)
	LDI  R26,HIGH(0xFF9C)
	CPC  R31,R26
	BRGE _0x296
	CALL SUBOPT_0x5C
	LDI  R30,LOW(65436)
	LDI  R31,HIGH(65436)
	ST   X+,R30
	ST   X,R31
; 0000 0513 			//if()
; 0000 0514 			}
_0x296:
; 0000 0515 
; 0000 0516 		}
_0x291:
	SUBI R17,-1
	RJMP _0x28F
_0x290:
; 0000 0517 	//plazma_int[2]=x[1];
; 0000 0518 	}
; 0000 0519 }
_0x27F:
_0x20C0001:
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;//Вычисление воздействий на силу
;//10Hz
;void pwr_hndl(void)
; 0000 051F {
_pwr_hndl:
; .FSTART _pwr_hndl
; 0000 0520 if(ee_AVT_MODE==0x55)
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BRNE _0x297
; 0000 0521 	{
; 0000 0522 /*	if(ee_Device==0x55)
; 0000 0523 		{
; 0000 0524 		pwm_u=0x3ff;
; 0000 0525 		pwm_i=0x3ff;
; 0000 0526 		bBL=0;
; 0000 0527 		}
; 0000 0528 	else
; 0000 0529  	if(ee_DEVICE)
; 0000 052A 		{
; 0000 052B 		pwm_u=0x00;
; 0000 052C 		pwm_i=0x00;
; 0000 052D 		bBL=1;
; 0000 052E 		}
; 0000 052F 	else */
; 0000 0530 		{
; 0000 0531 		if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE _0x298
; 0000 0532 			{
; 0000 0533 			pwm_u=ee_U_AVT;
	CALL SUBOPT_0x28
	CALL SUBOPT_0x5D
; 0000 0534 			gran(&pwm_u,0,1020);
	CALL SUBOPT_0x5E
; 0000 0535 		    	//pwm_i=0x3ff;
; 0000 0536 			if(pwm_i<1020)
	BRSH _0x299
; 0000 0537 				{
; 0000 0538 				pwm_i+=30;
	CALL SUBOPT_0x5F
; 0000 0539 				if(pwm_i>1020)pwm_i=1020;
	BRLO _0x29A
	CALL SUBOPT_0x60
; 0000 053A 				}
_0x29A:
; 0000 053B 			bBL=0;
_0x299:
	CBI  0x1E,7
; 0000 053C 			bBL_IPS=0;
	IN   R30,0x2A
	CBR  R30,1
	RJMP _0x3D9
; 0000 053D 			}
; 0000 053E 		else if(flags&0b00001010)
_0x298:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ _0x29E
; 0000 053F 			{
; 0000 0540 			pwm_u=0;
	CALL SUBOPT_0x61
; 0000 0541 			pwm_i=0;
; 0000 0542 			bBL=1;
; 0000 0543 			bBL_IPS=1;
	IN   R30,0x2A
	SBR  R30,1
_0x3D9:
	OUT  0x2A,R30
; 0000 0544 			}
; 0000 0545 		}
_0x29E:
; 0000 0546 //pwm_u=950;
; 0000 0547 //		pwm_i=950;
; 0000 0548 	}
; 0000 0549 
; 0000 054A else if(jp_mode==jp3)
	RJMP _0x2A1
_0x297:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x2A2
; 0000 054B 	{
; 0000 054C 	if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE _0x2A3
; 0000 054D 		{
; 0000 054E 		pwm_u=500;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	CALL SUBOPT_0x62
; 0000 054F 		if(pwm_i<1020)
	BRSH _0x2A4
; 0000 0550 			{
; 0000 0551 			pwm_i+=30;
	CALL SUBOPT_0x5F
; 0000 0552 			if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2A5
	CALL SUBOPT_0x60
; 0000 0553 			}
_0x2A5:
; 0000 0554 		bBL=0;
_0x2A4:
	CBI  0x1E,7
; 0000 0555 		}
; 0000 0556 	else if(flags&0b00001010)
	RJMP _0x2A8
_0x2A3:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ _0x2A9
; 0000 0557 		{
; 0000 0558 		pwm_u=0;
	CALL SUBOPT_0x61
; 0000 0559 		pwm_i=0;
; 0000 055A 		bBL=1;
; 0000 055B 		}
; 0000 055C 
; 0000 055D 	}
_0x2A9:
_0x2A8:
; 0000 055E else if(jp_mode==jp2)
	RJMP _0x2AC
_0x2A2:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x2AD
; 0000 055F 	{
; 0000 0560 	pwm_u=0;
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
; 0000 0561 	//pwm_i=0x3ff;
; 0000 0562 	if(pwm_i<1020)
	CALL SUBOPT_0x63
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	BRSH _0x2AE
; 0000 0563 		{
; 0000 0564 		pwm_i+=30;
	CALL SUBOPT_0x5F
; 0000 0565 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2AF
	CALL SUBOPT_0x60
; 0000 0566 		}
_0x2AF:
; 0000 0567 	bBL=0;
_0x2AE:
	CBI  0x1E,7
; 0000 0568 	}
; 0000 0569 else if(jp_mode==jp1)
	RJMP _0x2B2
_0x2AD:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x2B3
; 0000 056A 	{
; 0000 056B 	pwm_u=0x3ff;
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	CALL SUBOPT_0x62
; 0000 056C 	//pwm_i=0x3ff;
; 0000 056D 	if(pwm_i<1020)
	BRSH _0x2B4
; 0000 056E 		{
; 0000 056F 		pwm_i+=30;
	CALL SUBOPT_0x5F
; 0000 0570 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2B5
	CALL SUBOPT_0x60
; 0000 0571 		}
_0x2B5:
; 0000 0572 	bBL=0;
_0x2B4:
	CBI  0x1E,7
; 0000 0573 	}
; 0000 0574 
; 0000 0575 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
	RJMP _0x2B8
_0x2B3:
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x2BA
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ _0x2BB
_0x2BA:
	RJMP _0x2B9
_0x2BB:
; 0000 0576 	{
; 0000 0577 	pwm_u=volum_u_main_;
	CALL SUBOPT_0x56
	CALL SUBOPT_0x62
; 0000 0578 	//pwm_i=0x3ff;
; 0000 0579 	if(pwm_i<1020)
	BRSH _0x2BC
; 0000 057A 		{
; 0000 057B 		pwm_i+=30;
	CALL SUBOPT_0x5F
; 0000 057C 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2BD
	CALL SUBOPT_0x60
; 0000 057D 		}
_0x2BD:
; 0000 057E 	bBL_IPS=0;
_0x2BC:
	IN   R30,0x2A
	CBR  R30,1
	OUT  0x2A,R30
; 0000 057F 	}
; 0000 0580 
; 0000 0581 else if(link==OFF)
	RJMP _0x2BE
_0x2B9:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x2BF
; 0000 0582 	{
; 0000 0583 /*	if(ee_Device==0x55)
; 0000 0584 		{
; 0000 0585 		pwm_u=0x3ff;
; 0000 0586 		pwm_i=0x3ff;
; 0000 0587 		bBL=0;
; 0000 0588 		}
; 0000 0589 	else*/
; 0000 058A  	if(ee_DEVICE)
	CALL SUBOPT_0x23
	SBIW R30,0
	BREQ _0x2C0
; 0000 058B 		{
; 0000 058C 		pwm_u=0x00;
	CALL SUBOPT_0x61
; 0000 058D 		pwm_i=0x00;
; 0000 058E 		bBL=1;
; 0000 058F 		}
; 0000 0590 	else
	RJMP _0x2C3
_0x2C0:
; 0000 0591 		{
; 0000 0592 		if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE _0x2C4
; 0000 0593 			{
; 0000 0594 			pwm_u=ee_U_AVT;
	CALL SUBOPT_0x28
	CALL SUBOPT_0x5D
; 0000 0595 			gran(&pwm_u,0,1020);
	CALL SUBOPT_0x5E
; 0000 0596 		    	//pwm_i=0x3ff;
; 0000 0597 			if(pwm_i<1020)
	BRSH _0x2C5
; 0000 0598 				{
; 0000 0599 				pwm_i+=30;
	CALL SUBOPT_0x5F
; 0000 059A 				if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2C6
	CALL SUBOPT_0x60
; 0000 059B 				}
_0x2C6:
; 0000 059C 			bBL=0;
_0x2C5:
	CBI  0x1E,7
; 0000 059D 			bBL_IPS=0;
	IN   R30,0x2A
	CBR  R30,1
	RJMP _0x3DA
; 0000 059E 			}
; 0000 059F 		else if(flags&0b00011010)
_0x2C4:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2CA
; 0000 05A0 			{
; 0000 05A1 			pwm_u=0;
	CALL SUBOPT_0x61
; 0000 05A2 			pwm_i=0;
; 0000 05A3 			bBL=1;
; 0000 05A4 			bBL_IPS=1;
	IN   R30,0x2A
	SBR  R30,1
_0x3DA:
	OUT  0x2A,R30
; 0000 05A5 			}
; 0000 05A6 		}
_0x2CA:
_0x2C3:
; 0000 05A7 //pwm_u=950;
; 0000 05A8 //		pwm_i=950;
; 0000 05A9 	}
; 0000 05AA 
; 0000 05AB 
; 0000 05AC 
; 0000 05AD else	if(link==ON)				//если есть связьvol_i_temp_avar
	RJMP _0x2CD
_0x2BF:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+2
	RJMP _0x2CE
; 0000 05AE 	{
; 0000 05AF 	if((flags&0b00100000)==0)	//если нет блокировки извне
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ PC+2
	RJMP _0x2CF
; 0000 05B0 		{
; 0000 05B1 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	CPI  R30,LOW(0x4)
	BRNE _0x2D0
; 0000 05B2 			{
; 0000 05B3 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
	CALL SUBOPT_0x64
; 0000 05B4 			if(!ee_DEVICE)
	SBIW R30,0
	BRNE _0x2D1
; 0000 05B5 				{
; 0000 05B6 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
	CALL SUBOPT_0x65
	CALL SUBOPT_0x63
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x2D2
	LDS  R26,_vol_i_temp_avar
	LDS  R27,_vol_i_temp_avar+1
	CALL SUBOPT_0x66
	RJMP _0x3DB
; 0000 05B7 				else	pwm_i=vol_i_temp_avar;
_0x2D2:
	CALL SUBOPT_0x65
_0x3DB:
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05B8 				}
; 0000 05B9 			else pwm_i=vol_i_temp_avar;
	RJMP _0x2D4
_0x2D1:
	CALL SUBOPT_0x65
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05BA 
; 0000 05BB 			bBL=0;
_0x2D4:
	CBI  0x1E,7
; 0000 05BC 			}
; 0000 05BD 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
_0x2D0:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2D8
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x2D7
_0x2D8:
; 0000 05BE 			{
; 0000 05BF 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
	CALL SUBOPT_0x64
; 0000 05C0 		    	//pwm_i=vol_i_temp;
; 0000 05C1 			if(!ee_DEVICE)
	SBIW R30,0
	BRNE _0x2DA
; 0000 05C2 				{
; 0000 05C3 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
	CALL SUBOPT_0x67
	CALL SUBOPT_0x63
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x2DB
	LDS  R26,_vol_i_temp
	LDS  R27,_vol_i_temp+1
	CALL SUBOPT_0x66
	RJMP _0x3DC
; 0000 05C4 				else	pwm_i=vol_i_temp;
_0x2DB:
	CALL SUBOPT_0x67
_0x3DC:
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05C5 				}
; 0000 05C6 			else pwm_i=vol_i_temp;
	RJMP _0x2DD
_0x2DA:
	CALL SUBOPT_0x67
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05C7 			bBL=0;
_0x2DD:
	CBI  0x1E,7
; 0000 05C8 			}
; 0000 05C9 		else if(flags&0b00011010)					//если есть аварии
	RJMP _0x2E0
_0x2D7:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2E1
; 0000 05CA 			{
; 0000 05CB 			pwm_u=0;								//то полный стоп
	CALL SUBOPT_0x61
; 0000 05CC 			pwm_i=0;
; 0000 05CD 			bBL=1;
; 0000 05CE 			}
; 0000 05CF 		}
_0x2E1:
_0x2E0:
; 0000 05D0 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
	RJMP _0x2E4
_0x2CF:
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x2E5
; 0000 05D1 		{
; 0000 05D2 		pwm_u=0;
	CALL SUBOPT_0x61
; 0000 05D3 	    	pwm_i=0;
; 0000 05D4 		bBL=1;
; 0000 05D5 		}
; 0000 05D6 /*pwm_u=950;
; 0000 05D7 		pwm_i=950;*/
; 0000 05D8 	}
_0x2E5:
_0x2E4:
; 0000 05D9 //pwm_u=vol_u_temp;
; 0000 05DA }
_0x2CE:
_0x2CD:
_0x2BE:
_0x2B8:
_0x2B2:
_0x2AC:
_0x2A1:
	RET
; .FEND
;
;//-----------------------------------------------
;//Воздействие на силу
;//5Hz
;void pwr_drv(void)
; 0000 05E0 {
_pwr_drv:
; .FSTART _pwr_drv
; 0000 05E1 /*GPIOB->DDR|=(1<<2);
; 0000 05E2 GPIOB->CR1|=(1<<2);
; 0000 05E3 GPIOB->CR2&=~(1<<2);*/
; 0000 05E4 BLOCK_INIT
	SBI  0xA,4
; 0000 05E5 
; 0000 05E6 if(main_cnt1<1500)main_cnt1++;
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CPI  R26,LOW(0x5DC)
	LDI  R30,HIGH(0x5DC)
	CPC  R27,R30
	BRGE _0x2EA
	LDI  R26,LOW(_main_cnt1)
	LDI  R27,HIGH(_main_cnt1)
	CALL SUBOPT_0x27
; 0000 05E7 
; 0000 05E8 if((main_cnt1<25)&&(ee_DEVICE))
_0x2EA:
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	SBIW R26,25
	BRGE _0x2EC
	CALL SUBOPT_0x23
	SBIW R30,0
	BRNE _0x2ED
_0x2EC:
	RJMP _0x2EB
_0x2ED:
; 0000 05E9 	{
; 0000 05EA 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3DD
; 0000 05EB 	}
; 0000 05EC else if((ee_DEVICE))
_0x2EB:
	CALL SUBOPT_0x23
	SBIW R30,0
	BREQ _0x2F1
; 0000 05ED 	{
; 0000 05EE 	if(bBL)
	SBIS 0x1E,7
	RJMP _0x2F2
; 0000 05EF 		{
; 0000 05F0 		BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3DE
; 0000 05F1 		}
; 0000 05F2 	else if(!bBL)
_0x2F2:
	SBIC 0x1E,7
	RJMP _0x2F6
; 0000 05F3 		{
; 0000 05F4 		BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3DE:
	STS  _bVENT_BLOCK,R30
; 0000 05F5 		}
; 0000 05F6 	}
_0x2F6:
; 0000 05F7 else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
	RJMP _0x2F9
_0x2F1:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x2FB
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x2FC
_0x2FB:
	RJMP _0x2FA
_0x2FC:
; 0000 05F8 	{
; 0000 05F9 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3DD
; 0000 05FA 	//GPIOB->ODR|=(1<<2);
; 0000 05FB 	}
; 0000 05FC else if(bps_class==bpsIPS)
_0x2FA:
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x300
; 0000 05FD 		{
; 0000 05FE //GPIOB->ODR|=(1<<2);
; 0000 05FF 		if(bBL_IPS)
	IN   R30,0x2A
	SBRS R30,0
	RJMP _0x301
; 0000 0600 			{
; 0000 0601 			 BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3DF
; 0000 0602 			//GPIOB->ODR|=(1<<2);
; 0000 0603 			}
; 0000 0604 		else if(!bBL_IPS)
_0x301:
	IN   R30,0x2A
	SBRC R30,0
	RJMP _0x305
; 0000 0605 			{
; 0000 0606 			  BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3DF:
	STS  _bVENT_BLOCK,R30
; 0000 0607 			//GPIOB->ODR&=~(1<<2);
; 0000 0608 			}
; 0000 0609 		}
_0x305:
; 0000 060A else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
	RJMP _0x308
_0x300:
	CALL SUBOPT_0x24
	CALL SUBOPT_0x47
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x30A
	CALL SUBOPT_0x4D
	BRLT _0x30B
_0x30A:
	RJMP _0x309
_0x30B:
; 0000 060B 	{
; 0000 060C 	if(bps_class==bpsIPS)
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BREQ _0x3E0
; 0000 060D 		{
; 0000 060E 		  BLOCK_OFF
; 0000 060F 		//GPIOB->ODR&=~(1<<2);
; 0000 0610 		}
; 0000 0611 	else if(bps_class==bpsIBEP)
	LDS  R30,_bps_class
	CPI  R30,0
	BRNE _0x310
; 0000 0612 		{
; 0000 0613 		if(ee_DEVICE)
	CALL SUBOPT_0x23
	SBIW R30,0
	BREQ _0x311
; 0000 0614 			{
; 0000 0615 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x312
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3E1
; 0000 0616 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
_0x312:
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3E1:
	STS  _bVENT_BLOCK,R30
; 0000 0617 			}
; 0000 0618 		else
	RJMP _0x318
_0x311:
; 0000 0619 			{
; 0000 061A 			BLOCK_OFF
_0x3E0:
	CBI  0xB,4
	LDI  R30,LOW(0)
	STS  _bVENT_BLOCK,R30
; 0000 061B 			//GPIOB->ODR&=~(1<<2);
; 0000 061C 			}
_0x318:
; 0000 061D 		}
; 0000 061E 	}
_0x310:
; 0000 061F else if(bBL)
	RJMP _0x31B
_0x309:
	SBIS 0x1E,7
	RJMP _0x31C
; 0000 0620 	{
; 0000 0621 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3DD
; 0000 0622 	//GPIOB->ODR|=(1<<2);
; 0000 0623 	}
; 0000 0624 else if(!bBL)
_0x31C:
	SBIC 0x1E,7
	RJMP _0x320
; 0000 0625 	{
; 0000 0626 	BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3DD:
	STS  _bVENT_BLOCK,R30
; 0000 0627 	//GPIOB->ODR&=~(1<<2);
; 0000 0628 	}
; 0000 0629 
; 0000 062A //pwm_u=800;
; 0000 062B //pwm_u=400;
; 0000 062C 
; 0000 062D gran(&pwm_u,1,1020);
_0x320:
_0x31B:
_0x308:
_0x2F9:
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	CALL SUBOPT_0x68
; 0000 062E gran(&pwm_i,1,1020);
	LDI  R30,LOW(_pwm_i)
	LDI  R31,HIGH(_pwm_i)
	CALL SUBOPT_0x68
; 0000 062F 
; 0000 0630 if(ee_AVT_MODE!=0x55)
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x323
; 0000 0631     {
; 0000 0632     if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
	CALL SUBOPT_0x23
	SBIW R30,0
	BRNE _0x325
	CALL SUBOPT_0x24
	ADIW R30,10
	CALL SUBOPT_0x47
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x326
_0x325:
	RJMP _0x324
_0x326:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x5D
; 0000 0633     }
_0x324:
; 0000 0634 
; 0000 0635 //pwm_u=1000;
; 0000 0636 //pwm_i=1000;
; 0000 0637 
; 0000 0638 //GPIOB->ODR|=(1<<3);
; 0000 0639 
; 0000 063A //pwm_u=100;
; 0000 063B //pwm_i=400;
; 0000 063C //vent_pwm=200;
; 0000 063D 
; 0000 063E 
; 0000 063F OCR1AH= (char)(pwm_u/256);
_0x323:
	LDS  R30,_pwm_u+1
	STS  137,R30
; 0000 0640 OCR1AL= (char)pwm_u;
	LDS  R30,_pwm_u
	STS  136,R30
; 0000 0641 
; 0000 0642 OCR1BH= (char)(pwm_i/256);
	LDS  R30,_pwm_i+1
	STS  139,R30
; 0000 0643 OCR1BL= (char)pwm_i;
	LDS  R30,_pwm_i
	STS  138,R30
; 0000 0644 /*
; 0000 0645 TIM1->CCR1H= (char)(pwm_i/256);
; 0000 0646 TIM1->CCR1L= (char)pwm_i;
; 0000 0647 
; 0000 0648 TIM1->CCR3H= (char)(vent_pwm/256);
; 0000 0649 TIM1->CCR3L= (char)vent_pwm;*/
; 0000 064A 
; 0000 064B //OCR1AL= 260;//pwm_u;
; 0000 064C //OCR1B= 0;//pwm_i;
; 0000 064D 
; 0000 064E OCR2B=(char)(vent_pwm/4);
	CALL SUBOPT_0x52
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __DIVW21
	STS  180,R30
; 0000 064F 
; 0000 0650 }
	RET
; .FEND
;
;//-----------------------------------------------
;void pwr_hndl_(void)
; 0000 0654 {
; 0000 0655 //vol_u_temp=800;
; 0000 0656 if(jp_mode==jp3)
; 0000 0657 	{
; 0000 0658 	if((flags&0b00001010)==0)
; 0000 0659 		{
; 0000 065A 		pwm_u=500;
; 0000 065B 		//pwm_i=0x3ff;
; 0000 065C 		bBL=0;
; 0000 065D 		}
; 0000 065E 	else if(flags&0b00001010)
; 0000 065F 		{
; 0000 0660 		pwm_u=0;
; 0000 0661 		//pwm_i=0;
; 0000 0662 		bBL=1;
; 0000 0663 		}
; 0000 0664 
; 0000 0665 	}
; 0000 0666 else if(jp_mode==jp2)
; 0000 0667 	{
; 0000 0668 	pwm_u=0;
; 0000 0669 	//pwm_i=0x3ff;
; 0000 066A 	bBL=0;
; 0000 066B 	}
; 0000 066C else if(jp_mode==jp1)
; 0000 066D 	{
; 0000 066E 	pwm_u=0x3ff;
; 0000 066F 	//pwm_i=0x3ff;
; 0000 0670 	bBL=0;
; 0000 0671 	}
; 0000 0672 
; 0000 0673 else if(link==OFF)
; 0000 0674 	{
; 0000 0675 	if((flags&0b00011010)==0)
; 0000 0676 		{
; 0000 0677 		pwm_u=ee_U_AVT;
; 0000 0678 		gran(&pwm_u,0,1020);
; 0000 0679 	    //	pwm_i=0x3ff;
; 0000 067A 		bBL=0;
; 0000 067B 		}
; 0000 067C 	else if(flags&0b00011010)
; 0000 067D 		{
; 0000 067E 		pwm_u=0;
; 0000 067F 		//pwm_i=0;
; 0000 0680 		bBL=1;
; 0000 0681 		}
; 0000 0682 	}
; 0000 0683 
; 0000 0684 else	if(link==ON)
; 0000 0685 	{
; 0000 0686 	if((flags&0b00100000)==0)
; 0000 0687 		{
; 0000 0688 		if(((flags&0b00011010)==0)||(flags&0b01000000))
; 0000 0689 			{
; 0000 068A 			pwm_u=vol_u_temp+_x_;
; 0000 068B 		    //	pwm_i=0x3ff;
; 0000 068C 			bBL=0;
; 0000 068D 			}
; 0000 068E 		else if(flags&0b00011010)
; 0000 068F 			{
; 0000 0690 			pwm_u=0;
; 0000 0691 			//pwm_i=0;
; 0000 0692 			bBL=1;
; 0000 0693 			}
; 0000 0694 		}
; 0000 0695 	else if(flags&0b00100000)
; 0000 0696 		{
; 0000 0697 		pwm_u=0;
; 0000 0698 	    //	pwm_i=0;
; 0000 0699 		bBL=1;
; 0000 069A 		}
; 0000 069B 	}
; 0000 069C //pwm_u=vol_u_temp;
; 0000 069D }
;
;//-----------------------------------------------
;void JP_drv(void)
; 0000 06A1 {
_JP_drv:
; .FSTART _JP_drv
; 0000 06A2 
; 0000 06A3 DDRB.6=1;
	SBI  0x4,6
; 0000 06A4 DDRB.7=1;
	SBI  0x4,7
; 0000 06A5 PORTB.6=1;
	SBI  0x5,6
; 0000 06A6 PORTB.7=1;
	SBI  0x5,7
; 0000 06A7 
; 0000 06A8 if(PINB.6)
	SBIS 0x3,6
	RJMP _0x358
; 0000 06A9 	{
; 0000 06AA 	if(cnt_JP0<10)
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRSH _0x359
; 0000 06AB 		{
; 0000 06AC 		cnt_JP0++;
	LDS  R30,_cnt_JP0
	SUBI R30,-LOW(1)
	STS  _cnt_JP0,R30
; 0000 06AD 		}
; 0000 06AE 	}
_0x359:
; 0000 06AF else if(!PINB.6)
	RJMP _0x35A
_0x358:
	SBIC 0x3,6
	RJMP _0x35B
; 0000 06B0 	{
; 0000 06B1 	if(cnt_JP0)
	LDS  R30,_cnt_JP0
	CPI  R30,0
	BREQ _0x35C
; 0000 06B2 		{
; 0000 06B3 		cnt_JP0--;
	SUBI R30,LOW(1)
	STS  _cnt_JP0,R30
; 0000 06B4 		}
; 0000 06B5 	}
_0x35C:
; 0000 06B6 
; 0000 06B7 if(PINB.7)
_0x35B:
_0x35A:
	SBIS 0x3,7
	RJMP _0x35D
; 0000 06B8 	{
; 0000 06B9 	if(cnt_JP1<10)
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BRSH _0x35E
; 0000 06BA 		{
; 0000 06BB 		cnt_JP1++;
	LDS  R30,_cnt_JP1
	SUBI R30,-LOW(1)
	STS  _cnt_JP1,R30
; 0000 06BC 		}
; 0000 06BD 	}
_0x35E:
; 0000 06BE else if(!PINB.7)
	RJMP _0x35F
_0x35D:
	SBIC 0x3,7
	RJMP _0x360
; 0000 06BF 	{
; 0000 06C0 	if(cnt_JP1)
	LDS  R30,_cnt_JP1
	CPI  R30,0
	BREQ _0x361
; 0000 06C1 		{
; 0000 06C2 		cnt_JP1--;
	SUBI R30,LOW(1)
	STS  _cnt_JP1,R30
; 0000 06C3 		}
; 0000 06C4 	}
_0x361:
; 0000 06C5 
; 0000 06C6 
; 0000 06C7 if((cnt_JP0==10)&&(cnt_JP1==10))
_0x360:
_0x35F:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x363
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x364
_0x363:
	RJMP _0x362
_0x364:
; 0000 06C8 	{
; 0000 06C9 	jp_mode=jp0;
	LDI  R30,LOW(0)
	STS  _jp_mode,R30
; 0000 06CA 	}
; 0000 06CB if((cnt_JP0==0)&&(cnt_JP1==10))
_0x362:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x366
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x367
_0x366:
	RJMP _0x365
_0x367:
; 0000 06CC 	{
; 0000 06CD 	jp_mode=jp1;
	LDI  R30,LOW(1)
	STS  _jp_mode,R30
; 0000 06CE 	}
; 0000 06CF if((cnt_JP0==10)&&(cnt_JP1==0))
_0x365:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x369
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x36A
_0x369:
	RJMP _0x368
_0x36A:
; 0000 06D0 	{
; 0000 06D1 	jp_mode=jp2;
	LDI  R30,LOW(2)
	STS  _jp_mode,R30
; 0000 06D2 	}
; 0000 06D3 if((cnt_JP0==0)&&(cnt_JP1==0))
_0x368:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x36C
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x36D
_0x36C:
	RJMP _0x36B
_0x36D:
; 0000 06D4 	{
; 0000 06D5 	jp_mode=jp3;
	LDI  R30,LOW(3)
	STS  _jp_mode,R30
; 0000 06D6 	}
; 0000 06D7 
; 0000 06D8 }
_0x36B:
	RET
; .FEND
;
;//-----------------------------------------------
;void adc_hndl(void)
; 0000 06DC {
_adc_hndl:
; .FSTART _adc_hndl
; 0000 06DD unsigned tempUI;
; 0000 06DE tempUI=ADCW;
	ST   -Y,R17
	ST   -Y,R16
;	tempUI -> R16,R17
	__GETWRMN 16,17,0,120
; 0000 06DF adc_buff[adc_ch][adc_cnt]=tempUI;
	CALL SUBOPT_0x69
	MOVW R26,R30
	LDS  R30,_adc_cnt
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R16
	STD  Z+1,R17
; 0000 06E0 /*if(adc_ch==2)
; 0000 06E1 	{
; 0000 06E2 	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
; 0000 06E3 	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
; 0000 06E4 	}  */
; 0000 06E5 
; 0000 06E6 if((adc_cnt&0x03)==0)
	LDS  R30,_adc_cnt
	ANDI R30,LOW(0x3)
	BRNE _0x36E
; 0000 06E7 	{
; 0000 06E8 	char i;
; 0000 06E9 	adc_buff_[adc_ch]=0;
	SBIW R28,1
;	i -> Y+0
	CALL SUBOPT_0x6A
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
; 0000 06EA 	for(i=0;i<16;i++)
	ST   Y,R30
_0x370:
	LD   R26,Y
	CPI  R26,LOW(0x10)
	BRSH _0x371
; 0000 06EB 		{
; 0000 06EC 		adc_buff_[adc_ch]+=adc_buff[adc_ch][i];
	CALL SUBOPT_0x6A
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	LD   R0,Z
	LDD  R1,Z+1
	CALL SUBOPT_0x69
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
; 0000 06ED 		}
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RJMP _0x370
_0x371:
; 0000 06EE 	adc_buff_[adc_ch]>>=4;
	CALL SUBOPT_0x6A
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X+
	LD   R31,X+
	CALL __LSRW4
	ST   -X,R31
	ST   -X,R30
; 0000 06EF     //adc_buff_[adc_ch]=(adc_ch+1)*100;
; 0000 06F0 	}
	ADIW R28,1
; 0000 06F1 
; 0000 06F2 if(++adc_ch>=5)
_0x36E:
	LDS  R26,_adc_ch
	SUBI R26,-LOW(1)
	STS  _adc_ch,R26
	CPI  R26,LOW(0x5)
	BRLO _0x372
; 0000 06F3 	{
; 0000 06F4 	adc_ch=0;
	LDI  R30,LOW(0)
	STS  _adc_ch,R30
; 0000 06F5 	if(++adc_cnt>=16)
	LDS  R26,_adc_cnt
	SUBI R26,-LOW(1)
	STS  _adc_cnt,R26
	CPI  R26,LOW(0x10)
	BRLO _0x373
; 0000 06F6 		{
; 0000 06F7 		adc_cnt=0;
	STS  _adc_cnt,R30
; 0000 06F8 		}
; 0000 06F9 	}
_0x373:
; 0000 06FA DDRC&=0b11000000;
_0x372:
	IN   R30,0x7
	ANDI R30,LOW(0xC0)
	OUT  0x7,R30
; 0000 06FB PORTC&=0b11000000;
	IN   R30,0x8
	ANDI R30,LOW(0xC0)
	OUT  0x8,R30
; 0000 06FC 
; 0000 06FD if(adc_ch==0)       ADMUX=0b00000001; //ток
	LDS  R30,_adc_ch
	CPI  R30,0
	BRNE _0x374
	LDI  R30,LOW(1)
	RJMP _0x3E2
; 0000 06FE else if(adc_ch==1)  ADMUX=0b00000100; //напр ист
_0x374:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x1)
	BRNE _0x376
	LDI  R30,LOW(4)
	RJMP _0x3E2
; 0000 06FF else if(adc_ch==2)  ADMUX=0b00000010; //напр нагр
_0x376:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BRNE _0x378
	LDI  R30,LOW(2)
	RJMP _0x3E2
; 0000 0700 else if(adc_ch==3)  ADMUX=0b00000011; //темпер
_0x378:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x3)
	BRNE _0x37A
	LDI  R30,LOW(3)
	RJMP _0x3E2
; 0000 0701 else if(adc_ch==4)  ADMUX=0b00000101; //доп
_0x37A:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x4)
	BRNE _0x37C
	LDI  R30,LOW(5)
_0x3E2:
	STS  124,R30
; 0000 0702 
; 0000 0703 
; 0000 0704 ADCSRA=0b10100110;
_0x37C:
	LDI  R30,LOW(166)
	STS  122,R30
; 0000 0705 ADCSRA|=0b01000000;
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0706 
; 0000 0707 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;void matemat(void)
; 0000 070B {
_matemat:
; .FSTART _matemat
; 0000 070C signed long temp_SL;
; 0000 070D 
; 0000 070E #ifdef _220_
; 0000 070F temp_SL=adc_buff_[0];
	SBIW R28,4
;	temp_SL -> Y+0
	CALL SUBOPT_0x10
	CALL SUBOPT_0x6B
; 0000 0710 temp_SL-=K[0][0];
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMRDW
	CALL SUBOPT_0x6C
	CALL __SUBD21
	CALL __PUTD2S0
; 0000 0711 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x37D
	CALL SUBOPT_0x6D
; 0000 0712 temp_SL*=K[0][1];
_0x37D:
	CALL SUBOPT_0x12
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6E
; 0000 0713 temp_SL/=2400;
	__GETD1N 0x960
	CALL SUBOPT_0x6F
; 0000 0714 I=(signed int)temp_SL;
	STS  _I,R30
	STS  _I+1,R31
; 0000 0715 #else
; 0000 0716 
; 0000 0717 #ifdef _24_
; 0000 0718 temp_SL=adc_buff_[0];
; 0000 0719 temp_SL-=K[0][0];
; 0000 071A if(temp_SL<0) temp_SL=0;
; 0000 071B temp_SL*=K[0][1];
; 0000 071C temp_SL/=800;
; 0000 071D I=(signed int)temp_SL;
; 0000 071E #else
; 0000 071F temp_SL=adc_buff_[0];
; 0000 0720 temp_SL-=K[0][0];
; 0000 0721 if(temp_SL<0) temp_SL=0;
; 0000 0722 temp_SL*=K[0][1];
; 0000 0723 temp_SL/=1200;
; 0000 0724 I=(signed int)temp_SL;
; 0000 0725 #endif
; 0000 0726 #endif
; 0000 0727 
; 0000 0728 //I=adc_buff_[0];
; 0000 0729 
; 0000 072A temp_SL=adc_buff_[1];
	__GETW1MN _adc_buff_,2
	CALL SUBOPT_0x6B
; 0000 072B //temp_SL-=K[1,0];
; 0000 072C if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x37E
	CALL SUBOPT_0x6D
; 0000 072D temp_SL*=K[2][1];
_0x37E:
	CALL SUBOPT_0x17
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6E
; 0000 072E temp_SL/=1000;
	CALL SUBOPT_0x70
; 0000 072F Ui=(unsigned)temp_SL;
	STS  _Ui,R30
	STS  _Ui+1,R31
; 0000 0730 
; 0000 0731 //Ui=K[2][1];
; 0000 0732 
; 0000 0733 
; 0000 0734 temp_SL=adc_buff_[2];
	__GETW1MN _adc_buff_,4
	CALL SUBOPT_0x6B
; 0000 0735 //temp_SL-=K[2,0];
; 0000 0736 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x37F
	CALL SUBOPT_0x6D
; 0000 0737 temp_SL*=K[1][1];
_0x37F:
	CALL SUBOPT_0x16
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6E
; 0000 0738 temp_SL/=1000;
	CALL SUBOPT_0x70
; 0000 0739 Un=(unsigned)temp_SL;
	STS  _Un,R30
	STS  _Un+1,R31
; 0000 073A //Un=K[1][1];
; 0000 073B 
; 0000 073C temp_SL=adc_buff_[3];
	__GETW1MN _adc_buff_,6
	CALL SUBOPT_0x6B
; 0000 073D temp_SL*=K[3][1];
	CALL SUBOPT_0x18
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6E
; 0000 073E temp_SL/=1326;
	__GETD1N 0x52E
	CALL SUBOPT_0x6F
; 0000 073F T=(signed)(temp_SL-273);
	SUBI R30,LOW(273)
	SBCI R31,HIGH(273)
	STS  _T,R30
	STS  _T+1,R31
; 0000 0740 //T=TZAS;
; 0000 0741 
; 0000 0742 Udb=flags;
	LDS  R30,_flags
	LDI  R31,0
	STS  _Udb,R30
	STS  _Udb+1,R31
; 0000 0743 
; 0000 0744 
; 0000 0745 
; 0000 0746 }
	ADIW R28,4
	RET
; .FEND
;
;//***********************************************
;//***********************************************
;//***********************************************
;//***********************************************
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 074D {
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
; 0000 074E //DDRD.0=1;
; 0000 074F //PORTD.0=1;
; 0000 0750 
; 0000 0751 //PORTD.1=0;
; 0000 0752 
; 0000 0753 t0_init();
	CALL _t0_init
; 0000 0754 
; 0000 0755 can_hndl1();
	CALL _can_hndl1
; 0000 0756 
; 0000 0757 if(++t0_cnt4>=10)
	INC  R11
	LDI  R30,LOW(10)
	CP   R11,R30
	BRLO _0x380
; 0000 0758 	{
; 0000 0759 	t0_cnt4=0;
	CLR  R11
; 0000 075A //	b100Hz=1;
; 0000 075B 
; 0000 075C 
; 0000 075D if(++t0_cnt0>=10)
	INC  R7
	CP   R7,R30
	BRLO _0x381
; 0000 075E 	{
; 0000 075F 	t0_cnt0=0;
	CLR  R7
; 0000 0760 	b10Hz=1;
	SBI  0x1E,3
; 0000 0761 	}
; 0000 0762 if(++t0_cnt3>=3)
_0x381:
	INC  R8
	LDI  R30,LOW(3)
	CP   R8,R30
	BRLO _0x384
; 0000 0763 	{
; 0000 0764 	t0_cnt3=0;
	CLR  R8
; 0000 0765 	b33Hz=1;
	SBI  0x1E,2
; 0000 0766 	}
; 0000 0767 if(++t0_cnt1>=20)
_0x384:
	INC  R6
	LDI  R30,LOW(20)
	CP   R6,R30
	BRLO _0x387
; 0000 0768 	{
; 0000 0769 	t0_cnt1=0;
	CLR  R6
; 0000 076A 	b5Hz=1;
	SBI  0x1E,4
; 0000 076B      bFl_=!bFl_;
	SBIS 0x1E,6
	RJMP _0x38A
	CBI  0x1E,6
	RJMP _0x38B
_0x38A:
	SBI  0x1E,6
_0x38B:
; 0000 076C 	}
; 0000 076D if(++t0_cnt2>=100)
_0x387:
	INC  R9
	LDI  R30,LOW(100)
	CP   R9,R30
	BRLO _0x38C
; 0000 076E 	{
; 0000 076F 	t0_cnt2=0;
	CLR  R9
; 0000 0770 	b1Hz=1;
	SBI  0x1E,5
; 0000 0771 	}
; 0000 0772 }
_0x38C:
; 0000 0773 }
_0x380:
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
; 0000 077B {
_main:
; .FSTART _main
; 0000 077C //DDRD.0=1;
; 0000 077D //PORTD.0=0;
; 0000 077E //DDRD.1=1;
; 0000 077F //PORTD.1=1;
; 0000 0780 
; 0000 0781 //while (1)
; 0000 0782 	//{
; 0000 0783     //}
; 0000 0784 
; 0000 0785 ///DDRD.2=1;
; 0000 0786 ///PORTD.2=1;
; 0000 0787 
; 0000 0788 ///DDRB.0=1;
; 0000 0789 ///PORTB.0=0;
; 0000 078A 
; 0000 078B 	PORTB.2=1;
	SBI  0x5,2
; 0000 078C 	DDRB.2=1;
	SBI  0x4,2
; 0000 078D DDRB|=0b00110110;
	IN   R30,0x4
	ORI  R30,LOW(0x36)
	OUT  0x4,R30
; 0000 078E 
; 0000 078F 
; 0000 0790 
; 0000 0791 // Timer/Counter 1 initialization
; 0000 0792 // Clock source: System Clock
; 0000 0793 // Clock value: 8000.000 kHz
; 0000 0794 // Mode: Fast PWM top=0x03FF
; 0000 0795 // OC1A output: Non-Inverted PWM
; 0000 0796 // OC1B output: Non-Inverted PWM
; 0000 0797 // Noise Canceler: Off
; 0000 0798 // Input Capture on Falling Edge
; 0000 0799 // Timer Period: 0.128 ms
; 0000 079A // Output Pulse(s):
; 0000 079B // OC1A Period: 0.128 ms Width: 0.032031 ms
; 0000 079C // OC1B Period: 0.128 ms Width: 0.032031 ms
; 0000 079D // Timer1 Overflow Interrupt: Off
; 0000 079E // Input Capture Interrupt: Off
; 0000 079F // Compare A Match Interrupt: Off
; 0000 07A0 // Compare B Match Interrupt: Off
; 0000 07A1 TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (1<<WGM11) | (1<<WGM10);
	LDI  R30,LOW(163)
	STS  128,R30
; 0000 07A2 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 07A3 
; 0000 07A4 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 07A5 TCNT1L=0x00;
	STS  132,R30
; 0000 07A6 ICR1H=0x00;
	STS  135,R30
; 0000 07A7 ICR1L=0x00;
	STS  134,R30
; 0000 07A8 OCR1AH=0x01;
	LDI  R30,LOW(1)
	STS  137,R30
; 0000 07A9 OCR1AL=0x00;
	LDI  R30,LOW(0)
	STS  136,R30
; 0000 07AA OCR1BH=0x03;
	LDI  R30,LOW(3)
	STS  139,R30
; 0000 07AB OCR1BL=0x00;
	LDI  R30,LOW(0)
	STS  138,R30
; 0000 07AC 
; 0000 07AD DDRB.1=1;
	SBI  0x4,1
; 0000 07AE DDRB.2=1;
	SBI  0x4,2
; 0000 07AF 
; 0000 07B0 
; 0000 07B1 // Timer/Counter 2 initialization
; 0000 07B2 // Clock source: System Clock
; 0000 07B3 // Clock value: 8000.000 kHz
; 0000 07B4 // Mode: Fast PWM top=0xFF
; 0000 07B5 // OC2A output: Disconnected
; 0000 07B6 // OC2B output: Non-Inverted PWM
; 0000 07B7 // Timer Period: 0.032 ms
; 0000 07B8 // Output Pulse(s):
; 0000 07B9 // OC2B Period: 0.032 ms Width: 6.0235 us
; 0000 07BA ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 07BB TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (1<<COM2B1) | (0<<COM2B0) | (1<<WGM21) | (1<<WGM20);
	LDI  R30,LOW(35)
	STS  176,R30
; 0000 07BC TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (1<<CS20);
	LDI  R30,LOW(1)
	STS  177,R30
; 0000 07BD TCNT2=0x00;
	LDI  R30,LOW(0)
	STS  178,R30
; 0000 07BE OCR2A=0x00;
	STS  179,R30
; 0000 07BF OCR2B=0x30;
	LDI  R30,LOW(48)
	STS  180,R30
; 0000 07C0 
; 0000 07C1 DDRD.3=1;
	SBI  0xA,3
; 0000 07C2 
; 0000 07C3 /*
; 0000 07C4 
; 0000 07C5 TCCR1A=0x83;
; 0000 07C6 TCCR1B=0x09;
; 0000 07C7 TCNT1H=0x00;
; 0000 07C8 TCNT1L=0x00;
; 0000 07C9 OCR1AH=0x00;
; 0000 07CA OCR1AL=0x00;
; 0000 07CB OCR1BH=0x00;
; 0000 07CC OCR1BL=0x00;  */
; 0000 07CD 
; 0000 07CE SPCR=0x5D;
	LDI  R30,LOW(93)
	OUT  0x2C,R30
; 0000 07CF SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 07D0 /*delay_ms(100);
; 0000 07D1 delay_ms(100);
; 0000 07D2 delay_ms(100);
; 0000 07D3 delay_ms(100);
; 0000 07D4 delay_ms(100);
; 0000 07D5 delay_ms(100);
; 0000 07D6 delay_ms(100);
; 0000 07D7 delay_ms(100);
; 0000 07D8 delay_ms(100);
; 0000 07D9 delay_ms(100);*/
; 0000 07DA ///delay_ms(100);
; 0000 07DB ///delay_ms(100);
; 0000 07DC ///delay_ms(100);
; 0000 07DD ///delay_ms(100);
; 0000 07DE ///delay_ms(100);
; 0000 07DF ///adr_hndl();
; 0000 07E0 
; 0000 07E1 ///if(adr==100)
; 0000 07E2 ///	{
; 0000 07E3 ///	adr_hndl();
; 0000 07E4 ///	delay_ms(100);
; 0000 07E5 ///	}
; 0000 07E6 ///if(adr==100)
; 0000 07E7 ///	{
; 0000 07E8 ///	adr_hndl();
; 0000 07E9 ///	delay_ms(100);
; 0000 07EA ///	}
; 0000 07EB //adr_drv_v3();
; 0000 07EC //AVT_MODE=1;
; 0000 07ED adr_hndl();
	CALL _adr_hndl
; 0000 07EE t0_init();
	CALL _t0_init
; 0000 07EF 
; 0000 07F0 
; 0000 07F1 
; 0000 07F2 link_cnt=0;
	LDI  R30,LOW(0)
	STS  _link_cnt,R30
	STS  _link_cnt+1,R30
; 0000 07F3 if(ee_AVT_MODE!=0x55)link=ON;
	CALL SUBOPT_0x1F
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x399
	LDI  R30,LOW(85)
	STS  _link,R30
; 0000 07F4 /*
; 0000 07F5 Umax=1000;
; 0000 07F6 dU=100;
; 0000 07F7 tmax=60;
; 0000 07F8 tsign=50;
; 0000 07F9 */
; 0000 07FA main_cnt1=0;
_0x399:
	LDI  R30,LOW(0)
	STS  _main_cnt1,R30
	STS  _main_cnt1+1,R30
; 0000 07FB //_x_ee_=20;
; 0000 07FC _x_=_x_ee_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	STS  __x_,R30
	STS  __x_+1,R31
; 0000 07FD 
; 0000 07FE if((_x_>XMAX)||(_x_<-XMAX))_x_=0;
	LDS  R26,__x_
	LDS  R27,__x_+1
	SBIW R26,26
	BRGE _0x39B
	LDS  R26,__x_
	LDS  R27,__x_+1
	CPI  R26,LOW(0xFFE7)
	LDI  R30,HIGH(0xFFE7)
	CPC  R27,R30
	BRGE _0x39A
_0x39B:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
; 0000 07FF 
; 0000 0800 if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;
_0x39A:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	CPI  R30,0
	BRLO _0x39E
	CPI  R30,LOW(0x4)
	BRLO _0x39D
_0x39E:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	LDI  R30,LOW(3)
	CALL __EEPROMWRB
; 0000 0801 
; 0000 0802 #asm("sei")
_0x39D:
	sei
; 0000 0803 //granee(&K[0][1],420,1100);
; 0000 0804 
; 0000 0805 #ifdef _220_
; 0000 0806 //granee(&K[1][1],4500,5500);
; 0000 0807 //granee(&K[2][1],4500,5500);
; 0000 0808 #else
; 0000 0809 //granee(&K[1][1],1360,1700);
; 0000 080A //granee(&K[2][1],1360,1700);
; 0000 080B #endif
; 0000 080C 
; 0000 080D 
; 0000 080E //K[1][1]=123;
; 0000 080F //K[2][1]=456;
; 0000 0810 //granee(&K[1,1],1510,1850);
; 0000 0811 //granee(&K[2,1],1510,1850);
; 0000 0812 ///DDRD.2=1;
; 0000 0813 ///PORTD.2=0;
; 0000 0814 ///delay_ms(100);
; 0000 0815 ///PORTD.2=1;
; 0000 0816 can_init1();
	CALL _can_init1
; 0000 0817 
; 0000 0818 //DDRD.1=1;
; 0000 0819 //PORTD.1=0;
; 0000 081A DDRD.0=1;
	SBI  0xA,0
; 0000 081B 
; 0000 081C //ee_AVT_MODE=0x55;
; 0000 081D while (1)
_0x3A2:
; 0000 081E 	{
; 0000 081F 
; 0000 0820     //delay_ms(100);
; 0000 0821 	if(bIN1)
	LDS  R30,_bIN1
	CPI  R30,0
	BREQ _0x3A5
; 0000 0822 		{
; 0000 0823 		bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
; 0000 0824 
; 0000 0825 		can_in_an1();
	CALL _can_in_an1
; 0000 0826 		}
; 0000 0827 
; 0000 0828 /*	if(b100Hz)
; 0000 0829 		{
; 0000 082A 		b100Hz=0;
; 0000 082B 		}*/
; 0000 082C 	if(b33Hz)
_0x3A5:
	SBIS 0x1E,2
	RJMP _0x3A6
; 0000 082D 		{
; 0000 082E 		b33Hz=0;
	CBI  0x1E,2
; 0000 082F 
; 0000 0830         adc_hndl();
	RCALL _adc_hndl
; 0000 0831 		}
; 0000 0832 	if(b10Hz)
_0x3A6:
	SBIS 0x1E,3
	RJMP _0x3A9
; 0000 0833 		{
; 0000 0834 		b10Hz=0;
	CBI  0x1E,3
; 0000 0835 
; 0000 0836 		matemat();
	RCALL _matemat
; 0000 0837 		led_drv();
	CALL _led_drv
; 0000 0838 	    link_drv();
	CALL _link_drv
; 0000 0839 	    pwr_hndl();		//вычисление воздействий на силу
	RCALL _pwr_hndl
; 0000 083A 	    JP_drv();
	RCALL _JP_drv
; 0000 083B 	    flags_drv();
	CALL _flags_drv
; 0000 083C 		net_drv();
	CALL _net_drv
; 0000 083D 		}
; 0000 083E 	if(b5Hz)
_0x3A9:
	SBIS 0x1E,4
	RJMP _0x3AC
; 0000 083F 		{
; 0000 0840 		b5Hz=0;
	CBI  0x1E,4
; 0000 0841 
; 0000 0842         pwr_drv();
	RCALL _pwr_drv
; 0000 0843  		led_hndl();
	CALL _led_hndl
; 0000 0844         vent_drv();
	RCALL _vent_drv
; 0000 0845 		}
; 0000 0846     if(b1Hz)
_0x3AC:
	SBIS 0x1E,5
	RJMP _0x3AF
; 0000 0847 		{
; 0000 0848 		b1Hz=0;
	CBI  0x1E,5
; 0000 0849 
; 0000 084A         temper_drv();			//вычисление аварий температуры
	CALL _temper_drv
; 0000 084B 		u_drv();
	CALL _u_drv
; 0000 084C         x_drv();
	CALL _x_drv
; 0000 084D 
; 0000 084E         if(main_cnt<1000)main_cnt++;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0x3B2
	LDI  R26,LOW(_main_cnt)
	LDI  R27,HIGH(_main_cnt)
	CALL SUBOPT_0x27
; 0000 084F   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
_0x3B2:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ _0x3B4
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x3B3
_0x3B4:
	CALL _apv_hndl
; 0000 0850 
; 0000 0851 		//Пересброс КАНа в случае зависания
; 0000 0852   		can_error_cnt++;
_0x3B3:
	LDS  R30,_can_error_cnt
	SUBI R30,-LOW(1)
	STS  _can_error_cnt,R30
; 0000 0853   		if(can_error_cnt>=10)
	LDS  R26,_can_error_cnt
	CPI  R26,LOW(0xA)
	BRLO _0x3B6
; 0000 0854   			{
; 0000 0855   			can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
; 0000 0856 			can_init1();;
	CALL _can_init1
; 0000 0857   			}
; 0000 0858 
; 0000 0859 		volum_u_main_drv();
_0x3B6:
	RCALL _volum_u_main_drv
; 0000 085A 
; 0000 085B 		//pwm_stat++;
; 0000 085C 		//if(pwm_stat>=10)pwm_stat=0;
; 0000 085D         //adc_plazma_short++;
; 0000 085E 
; 0000 085F 		vent_resurs_hndl();
	RCALL _vent_resurs_hndl
; 0000 0860         }
; 0000 0861      #asm("wdr")
_0x3AF:
	wdr
; 0000 0862 	}
	RJMP _0x3A2
; 0000 0863 }
_0x3B7:
	RJMP _0x3B7
; .FEND
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
	SBRS R30,7
	RJMP _0x2040003
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
	.BYTE 0xA0
_adc_buff_:
	.BYTE 0xA
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
_led_drv_cnt:
	.BYTE 0x1
_led_red_buff:
	.BYTE 0x4
_led_green_buff:
	.BYTE 0x4
_link:
	.BYTE 0x1
_link_cnt:
	.BYTE 0x2
_tsign_cnt:
	.BYTE 0x2
_tmax_cnt:
	.BYTE 0x2
_pwm_u:
	.BYTE 0x2
_pwm_i:
	.BYTE 0x2
_umax_cnt:
	.BYTE 0x2
_umin_cnt:
	.BYTE 0x2
_flags_tu_cnt_off:
	.BYTE 0x1
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
__x__:
	.BYTE 0x2
__x_cnt:
	.BYTE 0x2

	.ESEG
__x_ee_:
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
_bAPV:
	.BYTE 0x1
_cnt_apv_off:
	.BYTE 0x1

	.ESEG
_res_fl:
	.BYTE 0x1
_res_fl_:
	.BYTE 0x1

	.DSEG
_bRES:
	.BYTE 0x1
_bRES_:
	.BYTE 0x1
_res_fl_cnt:
	.BYTE 0x1
_off_bp_cnt:
	.BYTE 0x1
_can_error_cnt:
	.BYTE 0x1
_adr:
	.BYTE 0x3
_adress:
	.BYTE 0x1
_adress_error:
	.BYTE 0x1
_bps_class:
	.BYTE 0x1

	.ESEG
_ee_TZAS:
	.BYTE 0x2
_ee_Umax:
	.BYTE 0x2
_ee_dU:
	.BYTE 0x2
_ee_tmax:
	.BYTE 0x2
_ee_tsign:
	.BYTE 0x2
_ee_U_AVT:
	.BYTE 0x2
_ee_AVT_MODE:
	.BYTE 0x2
_ee_DEVICE:
	.BYTE 0x2
_ee_IMAXVENT:
	.BYTE 0x2

	.DSEG
_vent_pwm:
	.BYTE 0x2
_bVENT_BLOCK:
	.BYTE 0x1
_cnt_net_drv:
	.BYTE 0x1

	.ESEG
_vent_resurs:
	.BYTE 0x2

	.DSEG
_vent_resurs_sec_cnt:
	.BYTE 0x2
_vent_resurs_buff:
	.BYTE 0x4
_vent_resurs_tx_cnt:
	.BYTE 0x1

	.ESEG
_UU_AVT:
	.BYTE 0x2

	.DSEG
_volum_u_main_:
	.BYTE 0x2
_x:
	.BYTE 0xC
_i_main:
	.BYTE 0xC
_i_main_flag:
	.BYTE 0x6
_i_main_avg:
	.BYTE 0x2
_i_main_num_of_bps:
	.BYTE 0x1
_i_main_sigma:
	.BYTE 0x2
_i_main_bps_cnt:
	.BYTE 0x6
_vol_i_temp_avar:
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
_flags_old_S000001B000:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x8:
	LDS  R30,_adress
	LDS  R26,_RXBUFF1
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	__GETB2MN _RXBUFF1,1
	LDS  R30,_adress
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xA:
	__GETB2MN _RXBUFF1,5
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0xB:
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0xC:
	CALL _can_transmit1
	LDS  R30,_adress
	ST   -Y,R30
	LDI  R30,LOW(219)
	ST   -Y,R30
	LDS  R30,_T
	ST   -Y,R30
	LDS  R30,_vent_resurs_tx_cnt
	LDI  R31,0
	SUBI R30,LOW(-_vent_resurs_buff)
	SBCI R31,HIGH(-_vent_resurs_buff)
	LD   R30,Z
	ST   -Y,R30
	LDS  R30,_flags
	ST   -Y,R30
	LDS  R30,__x_
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(0)
	STS  _link_cnt,R30
	STS  _link_cnt+1,R30
	LDI  R30,LOW(85)
	STS  _link,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMRDB
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(_rotor_int)
	LDI  R27,HIGH(_rotor_int)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	LDS  R30,_adc_buff_
	LDS  R31,_adc_buff_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x12:
	__POINTW2MN _K,2
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x16:
	__POINTW2MN _K,6
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x17:
	__POINTW2MN _K,10
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	__POINTW2MN _K,14
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x19:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	LDI  R26,LOW(_ee_Umax)
	LDI  R27,HIGH(_ee_Umax)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	__GETB2MN _RXBUFF1,4
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1C:
	__GETB2MN _RXBUFF1,3
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	__GETB2MN _RXBUFF1,6
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1E:
	__GETB2MN _RXBUFF1,5
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1F:
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EEPROMWRW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	LDI  R26,LOW(_ee_tmax)
	LDI  R27,HIGH(_ee_tmax)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x22:
	LDI  R26,LOW(_ee_tsign)
	LDI  R27,HIGH(_ee_tsign)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x23:
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x24:
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	MOVW R26,R30
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:75 WORDS
SUBOPT_0x26:
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
	LDI  R30,LOW(30)
	STS  _led_drv_cnt,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x27:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	LDI  R26,LOW(_ee_U_AVT)
	LDI  R27,HIGH(_ee_U_AVT)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x29:
	ST   -Y,R30
	LDS  R30,_cnt_net_drv
	LDI  R26,LOW(_x)
	LDI  R27,HIGH(_x)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2A:
	LDS  R30,__x_
	LDS  R31,__x_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2B:
	STS  _led_red_buff,R30
	STS  _led_red_buff+1,R31
	STS  _led_red_buff+2,R22
	STS  _led_red_buff+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2C:
	STS  _led_green_buff,R30
	STS  _led_green_buff+1,R31
	STS  _led_green_buff+2,R22
	STS  _led_green_buff+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2D:
	STS  124,R30
	LDI  R30,LOW(166)
	STS  122,R30
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2E:
	LDS  R30,120
	LDS  R31,120+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2F:
	LDS  R26,_umin_cnt
	LDS  R27,_umin_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x30:
	LDS  R26,_umax_cnt
	LDS  R27,_umax_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x31:
	LDS  R26,_link_cnt
	LDS  R27,_link_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x32:
	LDS  R26,_T
	LDS  R27,_T+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x33:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(60)
	LDI  R27,0
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x34:
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x35:
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
	RCALL SUBOPT_0x30
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x36:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	RJMP SUBOPT_0x27

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x37:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x38:
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
	RCALL SUBOPT_0x2F
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x39:
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3A:
	__GETD1N 0x55555555
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 27 TIMES, CODE SIZE REDUCTION:153 WORDS
SUBOPT_0x3B:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:123 WORDS
SUBOPT_0x3C:
	LDI  R30,LOW(0)
	STS  _led_red,R30
	STS  _led_red+1,R30
	STS  _led_red+2,R30
	STS  _led_red+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x3D:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x3E:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3F:
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x40:
	__GETD1N 0x10001
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x41:
	RCALL SUBOPT_0x40
	RJMP SUBOPT_0x3B

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:116 WORDS
SUBOPT_0x42:
	LDI  R30,LOW(0)
	STS  _led_green,R30
	STS  _led_green+1,R30
	STS  _led_green+2,R30
	STS  _led_green+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x43:
	__GETD1N 0x90009
	RCALL SUBOPT_0x3B
	RJMP SUBOPT_0x42

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x44:
	__GETD1N 0x490049
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x45:
	__GETD1N 0x33333333
	RJMP SUBOPT_0x3E

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x46:
	__GETD1N 0xCCCCCCCC
	RCALL SUBOPT_0x3B
	RJMP SUBOPT_0x42

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x47:
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x48:
	__GETD1N 0x3030303
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x49:
	__GETD1N 0x55555
	RCALL SUBOPT_0x3B
	RJMP SUBOPT_0x3D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4A:
	SUBI R30,LOW(-100)
	SBCI R31,HIGH(-100)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	RCALL SUBOPT_0x3A
	RCALL SUBOPT_0x3B
	RJMP SUBOPT_0x3D

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4C:
	RCALL SUBOPT_0x44
	RJMP SUBOPT_0x3B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4D:
	SUBI R30,LOW(-70)
	SBCI R31,HIGH(-70)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4E:
	__GETD1N 0x5
	RJMP SUBOPT_0x3E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4F:
	CALL __DIVD21
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x50:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x51:
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	RJMP SUBOPT_0x19

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x52:
	LDS  R26,_vent_pwm
	LDS  R27,_vent_pwm+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x53:
	LDI  R26,LOW(_vent_resurs)
	LDI  R27,HIGH(_vent_resurs)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x54:
	LDI  R26,LOW(_UU_AVT)
	LDI  R27,HIGH(_UU_AVT)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x55:
	LDS  R26,_Un
	LDS  R27,_Un+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x56:
	LDS  R30,_volum_u_main_
	LDS  R31,_volum_u_main_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x57:
	STS  _volum_u_main_,R30
	STS  _volum_u_main_+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x58:
	LDS  R26,_Un
	LDS  R27,_Un+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x59:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_i_main_flag)
	SBCI R31,HIGH(-_i_main_flag)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x5A:
	MOV  R30,R17
	LDI  R26,LOW(_i_main)
	LDI  R27,HIGH(_i_main)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5B:
	MOV  R30,R17
	LDI  R26,LOW(_x)
	LDI  R27,HIGH(_x)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X+
	LD   R31,X+
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x5C:
	MOV  R30,R17
	LDI  R26,LOW(_x)
	LDI  R27,HIGH(_x)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5D:
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x5E:
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1020)
	LDI  R27,HIGH(1020)
	CALL _gran
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:67 WORDS
SUBOPT_0x5F:
	LDS  R30,_pwm_i
	LDS  R31,_pwm_i+1
	ADIW R30,30
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	CPI  R26,LOW(0x3FD)
	LDI  R30,HIGH(0x3FD)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x60:
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x61:
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
	STS  _pwm_i,R30
	STS  _pwm_i+1,R30
	SBI  0x1E,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x62:
	RCALL SUBOPT_0x5D
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x63:
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x64:
	RCALL SUBOPT_0x2A
	LDS  R26,_vol_u_temp
	LDS  R27,_vol_u_temp+1
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x5D
	RJMP SUBOPT_0x23

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x65:
	LDS  R30,_vol_i_temp_avar
	LDS  R31,_vol_i_temp_avar+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x66:
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	CALL __DIVW21U
	RCALL SUBOPT_0x63
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x67:
	LDS  R30,_vol_i_temp
	LDS  R31,_vol_i_temp+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x68:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1020)
	LDI  R27,HIGH(1020)
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x69:
	LDS  R30,_adc_ch
	LDI  R31,0
	LSL  R30
	ROL  R31
	CALL __LSLW4
	SUBI R30,LOW(-_adc_buff)
	SBCI R31,HIGH(-_adc_buff)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6A:
	LDS  R30,_adc_ch
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6B:
	CLR  R22
	CLR  R23
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6C:
	CALL __GETD2S0
	CALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6D:
	LDI  R30,LOW(0)
	CALL __CLRD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x6E:
	CALL __MULD12
	CALL __PUTD1S0
	CALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x6F:
	CALL __DIVD21
	CALL __PUTD1S0
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x70:
	__GETD1N 0x3E8
	RJMP SUBOPT_0x6F


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

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
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

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
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

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
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

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
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
