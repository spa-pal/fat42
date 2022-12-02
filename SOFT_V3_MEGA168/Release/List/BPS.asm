
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
;enum {bpsIBEP,bpsIPS} bps_class;
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
	RJMP _0x38E
_0x3F:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x41
	LDI  R30,LOW(130)
	RJMP _0x38E
_0x41:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x43
	LDI  R30,LOW(132)
_0x38E:
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
; 0000 00B7 {

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
	RJMP _0x38F
; 	else flags&=0b10111111;
_0x65:
	LDS  R30,_flags
	ANDI R30,0xBF
_0x38F:
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
	RJMP _0x390
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
_0x390:
	__PUTW1EN _K,2
;			}
;		granee(&K[0][1],420,5000);
_0x7A:
_0x79:
_0x75:
_0x73:
	__POINTW1MN _K,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(420)
	LDI  R31,HIGH(420)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5000)
	LDI  R27,HIGH(5000)
	RJMP _0x391
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
	RJMP _0x392
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
_0x392:
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
	RJMP _0x393
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
_0x393:
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
	RJMP _0x394
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
_0x394:
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
_0x391:
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
;	}
_0x9E:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&((RXBUFF1[2]==MEM_KF1)||(RXBUFF1[2]==MEM_KF4)))
	RJMP _0x9F
_0x9A:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xA1
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xA1
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BREQ _0xA2
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x29)
	BRNE _0xA1
_0xA2:
	RJMP _0xA4
_0xA1:
	RJMP _0xA0
_0xA4:
;	{
;	if(ee_tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	CALL SUBOPT_0x1F
	MOVW R22,R30
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xA5
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	LDI  R26,LOW(_ee_tmax)
	LDI  R27,HIGH(_ee_tmax)
	CALL __EEPROMWRW
;	if(ee_tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) ee_tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0xA5:
	CALL SUBOPT_0x20
	MOVW R22,R30
	CALL SUBOPT_0xA
	CALL SUBOPT_0x1E
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xA6
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x1E
	LDI  R26,LOW(_ee_tsign)
	LDI  R27,HIGH(_ee_tsign)
	CALL __EEPROMWRW
;	//if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7];
;
;	if(RXBUFF1[2]==MEM_KF1)
_0xA6:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BRNE _0xA7
;		{
;		if(ee_DEVICE!=0)ee_DEVICE=0;
	CALL SUBOPT_0x21
	SBIW R30,0
	BREQ _0xA8
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EEPROMWRW
;		if(ee_TZAS!=(signed short)RXBUFF1[7]) ee_TZAS=(signed short)RXBUFF1[7];
_0xA8:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x23
	BREQ _0xA9
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	CALL __EEPROMWRW
;		}
_0xA9:
;	if(RXBUFF1[2]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, ко ...
_0xA7:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x29)
	BRNE _0xAA
;		{
;		if(ee_DEVICE!=1)ee_DEVICE=1;
	CALL SUBOPT_0x21
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ _0xAB
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __EEPROMWRW
;		if(ee_IMAXVENT!=(signed short)RXBUFF1[7]) ee_IMAXVENT=(signed short)RXBUFF1[7];
_0xAB:
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMRDW
	CALL SUBOPT_0x23
	BREQ _0xAC
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMWRW
;			if(ee_TZAS!=3) ee_TZAS=3;
_0xAC:
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ _0xAD
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL __EEPROMWRW
;		}
_0xAD:
;
;	}
_0xAA:
;
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	RJMP _0xAE
_0xA0:
	CALL SUBOPT_0x8
	BRNE _0xB0
	CALL SUBOPT_0x9
	BRNE _0xB0
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xB0
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x63)
	BREQ _0xB1
_0xB0:
	RJMP _0xAF
_0xB1:
;	{
;	flags&=0b11100001;
	CALL SUBOPT_0x24
;	tsign_cnt=0;
;	tmax_cnt=0;
;	umax_cnt=0;
;	umin_cnt=0;
;	led_drv_cnt=30;
;	}
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==VENT_RES))
	RJMP _0xB2
_0xAF:
	CALL SUBOPT_0x8
	BRNE _0xB4
	CALL SUBOPT_0x9
	BRNE _0xB4
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xB4
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x64)
	BREQ _0xB5
_0xB4:
	RJMP _0xB3
_0xB5:
;	{
;	vent_resurs=0;
	LDI  R26,LOW(_vent_resurs)
	LDI  R27,HIGH(_vent_resurs)
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EEPROMWRW
;	}
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	RJMP _0xB6
_0xB3:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xB8
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xB8
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xB8
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x16)
	BREQ _0xB9
_0xB8:
	RJMP _0xB7
_0xB9:
;	{
;	if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x55)
	BRNE _0xBB
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x55)
	BREQ _0xBC
_0xBB:
	RJMP _0xBA
_0xBC:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	CALL SUBOPT_0x25
;	else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--;
	RJMP _0xBD
_0xBA:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x66)
	BRNE _0xBF
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x66)
	BREQ _0xC0
_0xBF:
	RJMP _0xBE
_0xC0:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
;	else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
	RJMP _0xC1
_0xBE:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x77)
	BRNE _0xC3
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x77)
	BREQ _0xC4
_0xC3:
	RJMP _0xC2
_0xC4:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
;     gran(&_x_,-XMAX,XMAX);
_0xC2:
_0xC1:
_0xBD:
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
	RJMP _0xC5
_0xB7:
	CALL SUBOPT_0x8
	BRNE _0xC7
	CALL SUBOPT_0x9
	BRNE _0xC7
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xC7
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BRNE _0xC7
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0xEE)
	BREQ _0xC8
_0xC7:
	RJMP _0xC6
_0xC8:
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
	LDI  R26,LOW(_ee_U_AVT)
	LDI  R27,HIGH(_ee_U_AVT)
	CALL __EEPROMRDW
	CP   R20,R30
	CPC  R21,R31
	BRNE _0xC9
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
_0xC9:
;
;
;
;
;
;can_in_an1_end:
_0xC6:
_0xC5:
_0xB6:
_0xB2:
_0xAE:
_0x9F:
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
	RJMP _0xCB
;	{
;	if(++cnt_net_drv>=7) cnt_net_drv=0;
	LDS  R26,_cnt_net_drv
	SUBI R26,-LOW(1)
	STS  _cnt_net_drv,R26
	CPI  R26,LOW(0x7)
	BRLO _0xCC
	LDI  R30,LOW(0)
	STS  _cnt_net_drv,R30
;
;	if(cnt_net_drv<=5)
_0xCC:
	LDS  R26,_cnt_net_drv
	CPI  R26,LOW(0x6)
	BRSH _0xCD
;		{
;		can_transmit1(cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv ...
	LDS  R30,_cnt_net_drv
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(237)
	ST   -Y,R30
	LDI  R30,LOW(0)
	CALL SUBOPT_0x26
	LD   R30,X
	LDS  R26,_volum_u_main_
	ADD  R30,R26
	CALL SUBOPT_0x26
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
	BRLO _0xCE
	LDS  R30,_cnt_net_drv
	LDI  R31,0
	SUBI R30,LOW(-_i_main_flag)
	SBCI R31,HIGH(-_i_main_flag)
	LDI  R26,LOW(0)
	STD  Z+0,R26
;		}
_0xCE:
;	else if(cnt_net_drv==6)
	RJMP _0xCF
_0xCD:
	LDS  R26,_cnt_net_drv
	CPI  R26,LOW(0x6)
	BRNE _0xD0
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
_0xD0:
_0xCF:
;}
_0xCB:
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
; 0000 00BB {
_t0_init:
; .FSTART _t0_init
; 0000 00BC TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 00BD TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 00BE TCNT0=-8;
	LDI  R30,LOW(248)
	OUT  0x26,R30
; 0000 00BF TIMSK0=0x01;
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 00C0 }
	RET
; .FEND
;
;//-----------------------------------------------
;char adr_gran(signed short in)
; 0000 00C4 {
; 0000 00C5 if(in>800)return 1;
;	in -> Y+0
; 0000 00C6 else if((in>80)&&(in<120))return 0;
; 0000 00C7 else return 100;
; 0000 00C8 }
;
;
;//-----------------------------------------------
;void gran(signed int *adr, signed int min, signed int max)
; 0000 00CD {
_gran:
; .FSTART _gran
; 0000 00CE if (*adr<min) *adr=min;
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
	BRGE _0xD7
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 00CF if (*adr>max) *adr=max;
_0xD7:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xD8
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 00D0 }
_0xD8:
	RJMP _0x20C0002
; .FEND
;
;
;//-----------------------------------------------
;void granee(eeprom signed int *adr, signed int min, signed int max)
; 0000 00D5 {
_granee:
; .FSTART _granee
; 0000 00D6 if (*adr<min) *adr=min;
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
	BRGE _0xD9
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00D7 if (*adr>max) *adr=max;
_0xD9:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xDA
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00D8 }
_0xDA:
_0x20C0002:
	ADIW R28,6
	RET
; .FEND
;
;//-----------------------------------------------
;void x_drv(void)
; 0000 00DC {
_x_drv:
; .FSTART _x_drv
; 0000 00DD if(_x__==_x_)
	CALL SUBOPT_0x27
	LDS  R26,__x__
	LDS  R27,__x__+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0xDB
; 0000 00DE 	{
; 0000 00DF 	if(_x_cnt<60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,60
	BRGE _0xDC
; 0000 00E0 		{
; 0000 00E1 		_x_cnt++;
	LDI  R26,LOW(__x_cnt)
	LDI  R27,HIGH(__x_cnt)
	CALL SUBOPT_0x25
; 0000 00E2 		if(_x_cnt>=60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,60
	BRLT _0xDD
; 0000 00E3 			{
; 0000 00E4 			if(_x_ee_!=_x_)_x_ee_=_x_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	MOVW R26,R30
	CALL SUBOPT_0x27
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xDE
	CALL SUBOPT_0x27
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMWRW
; 0000 00E5 			}
_0xDE:
; 0000 00E6 		}
_0xDD:
; 0000 00E7 
; 0000 00E8 	}
_0xDC:
; 0000 00E9 else _x_cnt=0;
	RJMP _0xDF
_0xDB:
	LDI  R30,LOW(0)
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
; 0000 00EA 
; 0000 00EB if(_x_cnt>60) _x_cnt=0;
_0xDF:
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,61
	BRLT _0xE0
	LDI  R30,LOW(0)
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
; 0000 00EC 
; 0000 00ED _x__=_x_;
_0xE0:
	CALL SUBOPT_0x27
	STS  __x__,R30
	STS  __x__+1,R31
; 0000 00EE }
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_start(void)
; 0000 00F2 {
_apv_start:
; .FSTART _apv_start
; 0000 00F3 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
	LDS  R26,_apv_cnt
	CPI  R26,LOW(0x0)
	BRNE _0xE2
	__GETB2MN _apv_cnt,1
	CPI  R26,LOW(0x0)
	BRNE _0xE2
	__GETB2MN _apv_cnt,2
	CPI  R26,LOW(0x0)
	BRNE _0xE2
	LDS  R30,_bAPV
	CPI  R30,0
	BREQ _0xE3
_0xE2:
	RJMP _0xE1
_0xE3:
; 0000 00F4 	{
; 0000 00F5 	apv_cnt[0]=60;
	LDI  R30,LOW(60)
	STS  _apv_cnt,R30
; 0000 00F6 	apv_cnt[1]=60;
	__PUTB1MN _apv_cnt,1
; 0000 00F7 	apv_cnt[2]=60;
	__PUTB1MN _apv_cnt,2
; 0000 00F8 	apv_cnt_=3600;
	LDI  R30,LOW(3600)
	LDI  R31,HIGH(3600)
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R31
; 0000 00F9 	bAPV=1;
	LDI  R30,LOW(1)
	STS  _bAPV,R30
; 0000 00FA 	}
; 0000 00FB }
_0xE1:
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_stop(void)
; 0000 00FF {
_apv_stop:
; .FSTART _apv_stop
; 0000 0100 apv_cnt[0]=0;
	LDI  R30,LOW(0)
	STS  _apv_cnt,R30
; 0000 0101 apv_cnt[1]=0;
	__PUTB1MN _apv_cnt,1
; 0000 0102 apv_cnt[2]=0;
	__PUTB1MN _apv_cnt,2
; 0000 0103 apv_cnt_=0;
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R30
; 0000 0104 bAPV=0;
	STS  _bAPV,R30
; 0000 0105 }
	RET
; .FEND
;
;
;//-----------------------------------------------
;void av_wrk_drv(void)
; 0000 010A {
; 0000 010B adc_ch_2_delta=(char)(adc_ch_2_max-adc_ch_2_min);
; 0000 010C adc_ch_2_max=adc_buff_[2];
; 0000 010D adc_ch_2_min=adc_buff_[2];
; 0000 010E if(PORTD.7==0)
; 0000 010F 	{
; 0000 0110 	if(adc_ch_2_delta>=5)
; 0000 0111 		{
; 0000 0112 		cnt_adc_ch_2_delta++;
; 0000 0113 		if(cnt_adc_ch_2_delta>=10)
; 0000 0114 			{
; 0000 0115 			flags|=0x10;
; 0000 0116 			apv_start();
; 0000 0117 			}
; 0000 0118 		}
; 0000 0119 	else
; 0000 011A 		{
; 0000 011B 		cnt_adc_ch_2_delta=0;
; 0000 011C 		}
; 0000 011D 	}
; 0000 011E else cnt_adc_ch_2_delta=0;
; 0000 011F }
;
;//-----------------------------------------------
;void led_drv_(void)
; 0000 0123 {
; 0000 0124 DDRD.1=1;
; 0000 0125 if(led_green_buff&0b1L) PORTD.1=1;
; 0000 0126 else PORTD.1=0;
; 0000 0127 DDRD.0=1;
; 0000 0128 if(led_red_buff&0b1L) PORTD.0=1;
; 0000 0129 else PORTD.0=0;
; 0000 012A 
; 0000 012B 
; 0000 012C led_red_buff>>=1;
; 0000 012D led_green_buff>>=1;
; 0000 012E if(++led_drv_cnt>32)
; 0000 012F 	{
; 0000 0130 	led_drv_cnt=0;
; 0000 0131 	led_red_buff=led_red;
; 0000 0132 	led_green_buff=led_green;
; 0000 0133 	}
; 0000 0134 
; 0000 0135 }
;
;//-----------------------------------------------
;void led_drv(void)
; 0000 0139 {
_led_drv:
; .FSTART _led_drv
; 0000 013A //Красный светодиод
; 0000 013B DDRD.0=1;
	SBI  0xA,0
; 0000 013C if(led_red_buff&0b1L)   PORTD.0=1; 	//Горит если в led_red_buff 1 и на ножке 1
	LDS  R30,_led_red_buff
	ANDI R30,LOW(0x1)
	BREQ _0xFC
	SBI  0xB,0
; 0000 013D else                    PORTD.0=0;
	RJMP _0xFF
_0xFC:
	CBI  0xB,0
; 0000 013E 
; 0000 013F //Зеленый светодиод
; 0000 0140 DDRD.1=1;
_0xFF:
	SBI  0xA,1
; 0000 0141 if(led_green_buff&0b1L) PORTD.1=1;	//Горит если в led_green_buff 1 и на ножке 1
	LDS  R30,_led_green_buff
	ANDI R30,LOW(0x1)
	BREQ _0x104
	SBI  0xB,1
; 0000 0142 else                    PORTD.1=0;
	RJMP _0x107
_0x104:
	CBI  0xB,1
; 0000 0143 
; 0000 0144 
; 0000 0145 led_red_buff>>=1;
_0x107:
	LDS  R30,_led_red_buff
	LDS  R31,_led_red_buff+1
	LDS  R22,_led_red_buff+2
	LDS  R23,_led_red_buff+3
	CALL __ASRD1
	CALL SUBOPT_0x28
; 0000 0146 led_green_buff>>=1;
	LDS  R30,_led_green_buff
	LDS  R31,_led_green_buff+1
	LDS  R22,_led_green_buff+2
	LDS  R23,_led_green_buff+3
	CALL __ASRD1
	CALL SUBOPT_0x29
; 0000 0147 if(++led_drv_cnt>32)
	LDS  R26,_led_drv_cnt
	SUBI R26,-LOW(1)
	STS  _led_drv_cnt,R26
	CPI  R26,LOW(0x21)
	BRLO _0x10A
; 0000 0148 	{
; 0000 0149 	led_drv_cnt=0;
	LDI  R30,LOW(0)
	STS  _led_drv_cnt,R30
; 0000 014A 	led_red_buff=led_red;
	LDS  R30,_led_red
	LDS  R31,_led_red+1
	LDS  R22,_led_red+2
	LDS  R23,_led_red+3
	CALL SUBOPT_0x28
; 0000 014B 	led_green_buff=led_green;
	LDS  R30,_led_green
	LDS  R31,_led_green+1
	LDS  R22,_led_green+2
	LDS  R23,_led_green+3
	CALL SUBOPT_0x29
; 0000 014C 	}
; 0000 014D 
; 0000 014E }
_0x10A:
	RET
; .FEND
;
;//-----------------------------------------------
;void flags_drv(void)
; 0000 0152 {
_flags_drv:
; .FSTART _flags_drv
; 0000 0153 static char flags_old;
; 0000 0154 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0x10B
; 0000 0155 	{
; 0000 0156 	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000))))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x10D
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x8)
	BREQ _0x10F
_0x10D:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x110
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x10)
	BREQ _0x10F
_0x110:
	RJMP _0x10C
_0x10F:
; 0000 0157     		{
; 0000 0158     		if(link==OFF)apv_start();
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x113
	RCALL _apv_start
; 0000 0159     		}
_0x113:
; 0000 015A      }
_0x10C:
; 0000 015B else if(jp_mode==jp3)
	RJMP _0x114
_0x10B:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x115
; 0000 015C 	{
; 0000 015D 	if((flags&0b00001000)&&(!(flags_old&0b00001000)))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x117
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x8)
	BREQ _0x118
_0x117:
	RJMP _0x116
_0x118:
; 0000 015E     		{
; 0000 015F     		apv_start();
	RCALL _apv_start
; 0000 0160     		}
; 0000 0161      }
_0x116:
; 0000 0162 flags_old=flags;
_0x115:
_0x114:
	LDS  R30,_flags
	STS  _flags_old_S000001B000,R30
; 0000 0163 
; 0000 0164 }
	RET
; .FEND
;
;//-----------------------------------------------
;void adr_hndl(void)
; 0000 0168 {
_adr_hndl:
; .FSTART _adr_hndl
; 0000 0169 #define ADR_CONST_0	574
; 0000 016A #define ADR_CONST_1	897
; 0000 016B #define ADR_CONST_2	695
; 0000 016C #define ADR_CONST_3	1015
; 0000 016D 
; 0000 016E signed tempSI;
; 0000 016F short aaa[3];
; 0000 0170 char aaaa[3];
; 0000 0171 DDRC=0b00000000;
	SBIW R28,9
	ST   -Y,R17
	ST   -Y,R16
;	tempSI -> R16,R17
;	aaa -> Y+5
;	aaaa -> Y+2
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 0172 PORTC=0b00000000;
	OUT  0x8,R30
; 0000 0173 /*char i;
; 0000 0174 DDRD&=0b11100011;
; 0000 0175 PORTD|=0b00011100;
; 0000 0176 
; 0000 0177 //adr_new=((char)(!PIND.2))+(((char)(!PIND.3))*2)+((char)(!PIND.4)*4);
; 0000 0178 
; 0000 0179 
; 0000 017A adr_new=(PIND&0b00011100)>>2;
; 0000 017B 
; 0000 017C if(adr_new==adr_old)
; 0000 017D  	{
; 0000 017E  	if(adr_cnt<100)
; 0000 017F  		{
; 0000 0180  		adr_cnt++;
; 0000 0181  	     if(adr_cnt>=100)
; 0000 0182  	     	{
; 0000 0183  	     	adr_temp=adr_new;
; 0000 0184  	     	}
; 0000 0185  	     }
; 0000 0186    	}
; 0000 0187 else adr_cnt=0;
; 0000 0188 adr_old=adr_new;
; 0000 0189 if(adr!=CONST_ADR[adr_temp]) adr=CONST_ADR[adr_temp];
; 0000 018A 
; 0000 018B 
; 0000 018C //if(adr!=0b00000011)adr=0b00000011;*/
; 0000 018D 
; 0000 018E 
; 0000 018F 
; 0000 0190 ADMUX=0b00000110;
	LDI  R30,LOW(6)
	CALL SUBOPT_0x2A
; 0000 0191 ADCSRA=0b10100110;
; 0000 0192 ADCSRA|=0b01000000;
; 0000 0193 delay_ms(10);
; 0000 0194 aaa[0]=ADCW;
	CALL SUBOPT_0x2B
	STD  Y+5,R30
	STD  Y+5+1,R31
; 0000 0195 
; 0000 0196 
; 0000 0197 ADMUX=0b00000111;
	LDI  R30,LOW(7)
	CALL SUBOPT_0x2A
; 0000 0198 ADCSRA=0b10100110;
; 0000 0199 ADCSRA|=0b01000000;
; 0000 019A delay_ms(10);
; 0000 019B aaa[1]=ADCW;
	CALL SUBOPT_0x2B
	STD  Y+7,R30
	STD  Y+7+1,R31
; 0000 019C 
; 0000 019D 
; 0000 019E ADMUX=0b00000000;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x2A
; 0000 019F ADCSRA=0b10100110;
; 0000 01A0 ADCSRA|=0b01000000;
; 0000 01A1 delay_ms(10);
; 0000 01A2 aaa[2]=ADCW;
	CALL SUBOPT_0x2B
	STD  Y+9,R30
	STD  Y+9+1,R31
; 0000 01A3 
; 0000 01A4 if((aaa[0]>=(ADR_CONST_0-40))&&(aaa[0]<=(ADR_CONST_0+40))) adr[0]=0;
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x11A
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x11B
_0x11A:
	RJMP _0x119
_0x11B:
	LDI  R30,LOW(0)
	RJMP _0x395
; 0000 01A5 else if((aaa[0]>=(ADR_CONST_1-40))&&(aaa[0]<=(ADR_CONST_1+40))) adr[0]=1;
_0x119:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x11E
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x11F
_0x11E:
	RJMP _0x11D
_0x11F:
	LDI  R30,LOW(1)
	RJMP _0x395
; 0000 01A6 else if((aaa[0]>=(ADR_CONST_2-40))&&(aaa[0]<=(ADR_CONST_2+40))) adr[0]=2;
_0x11D:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x122
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x123
_0x122:
	RJMP _0x121
_0x123:
	LDI  R30,LOW(2)
	RJMP _0x395
; 0000 01A7 else if((aaa[0]>=(ADR_CONST_3-40))&&(aaa[0]<=(ADR_CONST_3+40))) adr[0]=3;
_0x121:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x126
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x127
_0x126:
	RJMP _0x125
_0x127:
	LDI  R30,LOW(3)
	RJMP _0x395
; 0000 01A8 else adr[0]=5;
_0x125:
	LDI  R30,LOW(5)
_0x395:
	STS  _adr,R30
; 0000 01A9 
; 0000 01AA if((aaa[1]>=(ADR_CONST_0-40))&&(aaa[1]<=(ADR_CONST_0+40))) adr[1]=0;
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x12A
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x12B
_0x12A:
	RJMP _0x129
_0x12B:
	LDI  R30,LOW(0)
	RJMP _0x396
; 0000 01AB else if((aaa[1]>=(ADR_CONST_1-40))&&(aaa[1]<=(ADR_CONST_1+40))) adr[1]=1;
_0x129:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x12E
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x12F
_0x12E:
	RJMP _0x12D
_0x12F:
	LDI  R30,LOW(1)
	RJMP _0x396
; 0000 01AC else if((aaa[1]>=(ADR_CONST_2-40))&&(aaa[1]<=(ADR_CONST_2+40))) adr[1]=2;
_0x12D:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x132
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x133
_0x132:
	RJMP _0x131
_0x133:
	LDI  R30,LOW(2)
	RJMP _0x396
; 0000 01AD else if((aaa[1]>=(ADR_CONST_3-40))&&(aaa[1]<=(ADR_CONST_3+40))) adr[1]=3;
_0x131:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x136
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x137
_0x136:
	RJMP _0x135
_0x137:
	LDI  R30,LOW(3)
	RJMP _0x396
; 0000 01AE else adr[1]=5;
_0x135:
	LDI  R30,LOW(5)
_0x396:
	__PUTB1MN _adr,1
; 0000 01AF 
; 0000 01B0 if((aaa[2]>=(ADR_CONST_0-40))&&(aaa[2]<=(ADR_CONST_0+40))) adr[2]=0;
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x13A
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x13B
_0x13A:
	RJMP _0x139
_0x13B:
	LDI  R30,LOW(0)
	RJMP _0x397
; 0000 01B1 else if((aaa[2]>=(ADR_CONST_1-40))&&(aaa[2]<=(ADR_CONST_1+40))) adr[2]=1;
_0x139:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x13E
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x13F
_0x13E:
	RJMP _0x13D
_0x13F:
	LDI  R30,LOW(1)
	RJMP _0x397
; 0000 01B2 else if((aaa[2]>=(ADR_CONST_2-40))&&(aaa[2]<=(ADR_CONST_2+40))) adr[2]=2;
_0x13D:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x142
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x143
_0x142:
	RJMP _0x141
_0x143:
	LDI  R30,LOW(2)
	RJMP _0x397
; 0000 01B3 else if((aaa[2]>=(ADR_CONST_3-40))&&(aaa[2]<=(ADR_CONST_3+40))) adr[2]=3;
_0x141:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x146
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x147
_0x146:
	RJMP _0x145
_0x147:
	LDI  R30,LOW(3)
	RJMP _0x397
; 0000 01B4 else adr[2]=5;
_0x145:
	LDI  R30,LOW(5)
_0x397:
	__PUTB1MN _adr,2
; 0000 01B5 
; 0000 01B6 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
	LDS  R26,_adr
	CPI  R26,LOW(0x5)
	BREQ _0x14A
	__GETB2MN _adr,1
	CPI  R26,LOW(0x5)
	BREQ _0x14A
	__GETB2MN _adr,2
	CPI  R26,LOW(0x5)
	BRNE _0x149
_0x14A:
; 0000 01B7 	{
; 0000 01B8 	//adress=100;
; 0000 01B9 	adress_error=1;
	LDI  R30,LOW(1)
	STS  _adress_error,R30
; 0000 01BA 	}
; 0000 01BB else
	RJMP _0x14C
_0x149:
; 0000 01BC 	{
; 0000 01BD 	if(adr[2]&0x02) bps_class=bpsIPS;
	__GETB1MN _adr,2
	ANDI R30,LOW(0x2)
	BREQ _0x14D
	LDI  R30,LOW(1)
	RJMP _0x398
; 0000 01BE 	else bps_class=bpsIBEP;
_0x14D:
	LDI  R30,LOW(0)
_0x398:
	STS  _bps_class,R30
; 0000 01BF 
; 0000 01C0 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
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
; 0000 01C1 	}
_0x14C:
; 0000 01C2 //plazmaSS=adress;
; 0000 01C3 //adress=0;
; 0000 01C4 
; 0000 01C5 }
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
; 0000 01CC {
_apv_hndl:
; .FSTART _apv_hndl
; 0000 01CD if(apv_cnt[0])
	LDS  R30,_apv_cnt
	CPI  R30,0
	BREQ _0x14F
; 0000 01CE 	{
; 0000 01CF 	apv_cnt[0]--;
	SUBI R30,LOW(1)
	STS  _apv_cnt,R30
; 0000 01D0 	if(apv_cnt[0]==0)
	CPI  R30,0
	BRNE _0x150
; 0000 01D1 		{
; 0000 01D2 		flags&=0b11100001;
	CALL SUBOPT_0x24
; 0000 01D3 		tsign_cnt=0;
; 0000 01D4 		tmax_cnt=0;
; 0000 01D5 		umax_cnt=0;
; 0000 01D6 		umin_cnt=0;
; 0000 01D7 		//cnt_adc_ch_2_delta=0;
; 0000 01D8 		led_drv_cnt=30;
; 0000 01D9 		}
; 0000 01DA 	}
_0x150:
; 0000 01DB else if(apv_cnt[1])
	RJMP _0x151
_0x14F:
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BREQ _0x152
; 0000 01DC 	{
; 0000 01DD 	apv_cnt[1]--;
	__GETB1MN _apv_cnt,1
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,1
; 0000 01DE 	if(apv_cnt[1]==0)
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0x153
; 0000 01DF 		{
; 0000 01E0 		flags&=0b11100001;
	CALL SUBOPT_0x24
; 0000 01E1 		tsign_cnt=0;
; 0000 01E2 		tmax_cnt=0;
; 0000 01E3 		umax_cnt=0;
; 0000 01E4 		umin_cnt=0;
; 0000 01E5 //		cnt_adc_ch_2_delta=0;
; 0000 01E6 		led_drv_cnt=30;
; 0000 01E7 		}
; 0000 01E8 	}
_0x153:
; 0000 01E9 else if(apv_cnt[2])
	RJMP _0x154
_0x152:
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BREQ _0x155
; 0000 01EA 	{
; 0000 01EB 	apv_cnt[2]--;
	__GETB1MN _apv_cnt,2
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,2
; 0000 01EC 	if(apv_cnt[2]==0)
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0x156
; 0000 01ED 		{
; 0000 01EE 		flags&=0b11100001;
	CALL SUBOPT_0x24
; 0000 01EF 		tsign_cnt=0;
; 0000 01F0 		tmax_cnt=0;
; 0000 01F1 		umax_cnt=0;
; 0000 01F2 		umin_cnt=0;
; 0000 01F3 //		cnt_adc_ch_2_delta=0;
; 0000 01F4 		led_drv_cnt=30;
; 0000 01F5 		}
; 0000 01F6 	}
_0x156:
; 0000 01F7 
; 0000 01F8 if(apv_cnt_)
_0x155:
_0x154:
_0x151:
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BREQ _0x157
; 0000 01F9 	{
; 0000 01FA 	apv_cnt_--;
	LDI  R26,LOW(_apv_cnt_)
	LDI  R27,HIGH(_apv_cnt_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 01FB 	if(apv_cnt_==0)
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BRNE _0x158
; 0000 01FC 		{
; 0000 01FD 		bAPV=0;
	LDI  R30,LOW(0)
	STS  _bAPV,R30
; 0000 01FE 		apv_start();
	RCALL _apv_start
; 0000 01FF 		}
; 0000 0200 	}
_0x158:
; 0000 0201 
; 0000 0202 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
_0x157:
	CALL SUBOPT_0x2C
	SBIW R26,0
	BRNE _0x15A
	CALL SUBOPT_0x2D
	SBIW R26,0
	BRNE _0x15A
	SBIS 0x9,4
	RJMP _0x15B
_0x15A:
	RJMP _0x159
_0x15B:
; 0000 0203 	{
; 0000 0204 	if(cnt_apv_off<20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRSH _0x15C
; 0000 0205 		{
; 0000 0206 		cnt_apv_off++;
	LDS  R30,_cnt_apv_off
	SUBI R30,-LOW(1)
	STS  _cnt_apv_off,R30
; 0000 0207 		if(cnt_apv_off>=20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRLO _0x15D
; 0000 0208 			{
; 0000 0209 			apv_stop();
	RCALL _apv_stop
; 0000 020A 			}
; 0000 020B 		}
_0x15D:
; 0000 020C 	}
_0x15C:
; 0000 020D else cnt_apv_off=0;
	RJMP _0x15E
_0x159:
	LDI  R30,LOW(0)
	STS  _cnt_apv_off,R30
; 0000 020E 
; 0000 020F }
_0x15E:
	RET
; .FEND
;
;//-----------------------------------------------
;void link_drv(void)		//10Hz
; 0000 0213 {
_link_drv:
; .FSTART _link_drv
; 0000 0214 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0x15F
; 0000 0215 	{
; 0000 0216 	if(link_cnt<602)link_cnt++;
	CALL SUBOPT_0x2E
	CPI  R26,LOW(0x25A)
	LDI  R30,HIGH(0x25A)
	CPC  R27,R30
	BRGE _0x160
	LDI  R26,LOW(_link_cnt)
	LDI  R27,HIGH(_link_cnt)
	CALL SUBOPT_0x25
; 0000 0217 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
_0x160:
	CALL SUBOPT_0x2E
	CPI  R26,LOW(0x24E)
	LDI  R30,HIGH(0x24E)
	CPC  R27,R30
	BRNE _0x161
	LDS  R30,_flags
	ANDI R30,LOW(0xC1)
	STS  _flags,R30
; 0000 0218 	if(link_cnt==600)
_0x161:
	CALL SUBOPT_0x2E
	CPI  R26,LOW(0x258)
	LDI  R30,HIGH(0x258)
	CPC  R27,R30
	BRNE _0x162
; 0000 0219 		{
; 0000 021A 		link=OFF;
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 021B 
; 0000 021C 		//попробую вместо
; 0000 021D 		//if((AVT_MODE!=0x55)&&(!eeDEVICE))bMAIN=1;
; 0000 021E 		//написать
; 0000 021F 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x163
	IN   R30,0x2A
	SBR  R30,2
	RJMP _0x399
; 0000 0220 		else bMAIN=0;
_0x163:
	IN   R30,0x2A
	CBR  R30,2
_0x399:
	OUT  0x2A,R30
; 0000 0221 
; 0000 0222 		cnt_net_drv=0;
	LDI  R30,LOW(0)
	STS  _cnt_net_drv,R30
; 0000 0223     		if(!res_fl_)
	CALL SUBOPT_0xE
	BRNE _0x165
; 0000 0224 			{
; 0000 0225 	    		bRES_=1;
	LDI  R30,LOW(1)
	STS  _bRES_,R30
; 0000 0226 	    		res_fl_=1;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMWRB
; 0000 0227 	    		}
; 0000 0228     		}
_0x165:
; 0000 0229 	}
_0x162:
; 0000 022A else link=OFF;
	RJMP _0x166
_0x15F:
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 022B }
_0x166:
	RET
; .FEND
;
;//-----------------------------------------------
;void temper_drv(void)
; 0000 022F {
_temper_drv:
; .FSTART _temper_drv
; 0000 0230 if(T>ee_tsign) tsign_cnt++;
	CALL SUBOPT_0x20
	CALL SUBOPT_0x2F
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x167
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x39A
; 0000 0231 else if (T<(ee_tsign-1)) tsign_cnt--;
_0x167:
	CALL SUBOPT_0x20
	SBIW R30,1
	CALL SUBOPT_0x2F
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x169
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x39A:
	ST   -X,R31
	ST   -X,R30
; 0000 0232 
; 0000 0233 gran(&tsign_cnt,0,60);
_0x169:
	LDI  R30,LOW(_tsign_cnt)
	LDI  R31,HIGH(_tsign_cnt)
	CALL SUBOPT_0x30
; 0000 0234 
; 0000 0235 if(tsign_cnt>=55)
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,55
	BRLT _0x16A
; 0000 0236 	{
; 0000 0237 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0x16C
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x16E
_0x16C:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x16B
_0x16E:
	LDS  R30,_flags
	ORI  R30,4
	STS  _flags,R30
; 0000 0238 	}
_0x16B:
; 0000 0239 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
	RJMP _0x170
_0x16A:
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,6
	BRGE _0x171
	LDS  R30,_flags
	ANDI R30,0xFB
	STS  _flags,R30
; 0000 023A 
; 0000 023B 
; 0000 023C 
; 0000 023D 
; 0000 023E if(T>ee_tmax) tmax_cnt++;
_0x171:
_0x170:
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x2F
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x172
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x39B
; 0000 023F else if (T<(ee_tmax-1)) tmax_cnt--;
_0x172:
	CALL SUBOPT_0x1F
	SBIW R30,1
	CALL SUBOPT_0x2F
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x174
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x39B:
	ST   -X,R31
	ST   -X,R30
; 0000 0240 
; 0000 0241 gran(&tmax_cnt,0,60);
_0x174:
	LDI  R30,LOW(_tmax_cnt)
	LDI  R31,HIGH(_tmax_cnt)
	CALL SUBOPT_0x30
; 0000 0242 
; 0000 0243 if(tmax_cnt>=55)
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,55
	BRLT _0x175
; 0000 0244 	{
; 0000 0245 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0x177
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x179
_0x177:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x176
_0x179:
	LDS  R30,_flags
	ORI  R30,2
	STS  _flags,R30
; 0000 0246 	}
_0x176:
; 0000 0247 else if (tmax_cnt<=5) flags&=0b11111101;
	RJMP _0x17B
_0x175:
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,6
	BRGE _0x17C
	LDS  R30,_flags
	ANDI R30,0xFD
	STS  _flags,R30
; 0000 0248 
; 0000 0249 
; 0000 024A }
_0x17C:
_0x17B:
	RET
; .FEND
;
;//-----------------------------------------------
;void u_drv(void)		//1Hz
; 0000 024E {
_u_drv:
; .FSTART _u_drv
; 0000 024F if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x17D
; 0000 0250 	{
; 0000 0251 	if(Ui>ee_Umax)umax_cnt++;
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x31
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x17E
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x25
; 0000 0252 	else umax_cnt=0;
	RJMP _0x17F
_0x17E:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 0253 	gran(&umax_cnt,0,10);
_0x17F:
	CALL SUBOPT_0x32
; 0000 0254 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
	BRLT _0x180
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 0255 
; 0000 0256 
; 0000 0257 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
_0x180:
	LDS  R30,_Un
	LDS  R31,_Un+1
	CALL SUBOPT_0x31
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x182
	CALL SUBOPT_0x31
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
	BRSH _0x182
	SBIS 0x9,4
	RJMP _0x183
_0x182:
	RJMP _0x181
_0x183:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	CALL SUBOPT_0x25
; 0000 0258 	else umin_cnt=0;
	RJMP _0x184
_0x181:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
; 0000 0259 	gran(&umin_cnt,0,10);
_0x184:
	CALL SUBOPT_0x33
; 0000 025A 	if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x185
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
; 0000 025B 	}
_0x185:
; 0000 025C else if(jp_mode==jp3)
	RJMP _0x186
_0x17D:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x187
; 0000 025D 	{
; 0000 025E 	if(Ui>700)umax_cnt++;
	CALL SUBOPT_0x31
	CPI  R26,LOW(0x2BD)
	LDI  R30,HIGH(0x2BD)
	CPC  R27,R30
	BRLO _0x188
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x25
; 0000 025F 	else umax_cnt=0;
	RJMP _0x189
_0x188:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 0260 	gran(&umax_cnt,0,10);
_0x189:
	CALL SUBOPT_0x32
; 0000 0261 	if(umax_cnt>=10)flags|=0b00001000;
	BRLT _0x18A
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 0262 
; 0000 0263 
; 0000 0264 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
_0x18A:
	CALL SUBOPT_0x31
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRSH _0x18C
	SBIS 0x9,4
	RJMP _0x18D
_0x18C:
	RJMP _0x18B
_0x18D:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	CALL SUBOPT_0x25
; 0000 0265 	else umin_cnt=0;
	RJMP _0x18E
_0x18B:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
; 0000 0266 	gran(&umin_cnt,0,10);
_0x18E:
	CALL SUBOPT_0x33
; 0000 0267 	if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x18F
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
; 0000 0268 	}
_0x18F:
; 0000 0269 }
_0x187:
_0x186:
	RET
; .FEND
;
;//-----------------------------------------------
;void led_hndl_(void)
; 0000 026D {
; 0000 026E if(jp_mode!=jp3)
; 0000 026F 	{
; 0000 0270 	if(main_cnt1<(5*TZAS))
; 0000 0271 		{
; 0000 0272 		led_red=0x00000000L;
; 0000 0273 		led_green=0x03030303L;
; 0000 0274 		}
; 0000 0275 	else if((link==ON)&&(flags_tu&0b10000000))
; 0000 0276 		{
; 0000 0277 		led_red=0x00055555L;
; 0000 0278  		led_green=0xffffffffL;
; 0000 0279  		}
; 0000 027A 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
; 0000 027B 		{
; 0000 027C 		led_red=0x00000000L;
; 0000 027D 		led_green=0xffffffffL;
; 0000 027E 		}
; 0000 027F 
; 0000 0280 	else  if(link==OFF)
; 0000 0281  		{
; 0000 0282  		led_red=0x55555555L;
; 0000 0283  		led_green=0xffffffffL;
; 0000 0284  		}
; 0000 0285 
; 0000 0286 	else if((link==ON)&&((flags&0b00111110)==0))
; 0000 0287 		{
; 0000 0288 		led_red=0x00000000L;
; 0000 0289 		led_green=0xffffffffL;
; 0000 028A 		}
; 0000 028B 
; 0000 028C 
; 0000 028D 
; 0000 028E 
; 0000 028F 
; 0000 0290 	else if((flags&0b00111110)==0b00000100)
; 0000 0291 		{
; 0000 0292 		led_red=0x00010001L;
; 0000 0293 		led_green=0xffffffffL;
; 0000 0294 		}
; 0000 0295 	else if(flags&0b00000010)
; 0000 0296 		{
; 0000 0297 		led_red=0x00010001L;
; 0000 0298 		led_green=0x00000000L;
; 0000 0299 		}
; 0000 029A 	else if(flags&0b00001000)
; 0000 029B 		{
; 0000 029C 		led_red=0x00090009L;
; 0000 029D 		led_green=0x00000000L;
; 0000 029E 		}
; 0000 029F 	else if(flags&0b00010000)
; 0000 02A0 		{
; 0000 02A1 		led_red=0x00490049L;
; 0000 02A2 		led_green=0x00000000L;
; 0000 02A3 		}
; 0000 02A4 
; 0000 02A5 	else if((link==ON)&&(flags&0b00100000))
; 0000 02A6 		{
; 0000 02A7 		led_red=0x00000000L;
; 0000 02A8 		led_green=0x00030003L;
; 0000 02A9 		}
; 0000 02AA 
; 0000 02AB 	if((jp_mode==jp1))
; 0000 02AC 		{
; 0000 02AD 		led_red=0x00000000L;
; 0000 02AE 		led_green=0x33333333L;
; 0000 02AF 		}
; 0000 02B0 	else if((jp_mode==jp2))
; 0000 02B1 		{
; 0000 02B2 		led_red=0xccccccccL;
; 0000 02B3 		led_green=0x00000000L;
; 0000 02B4 		}
; 0000 02B5 	}
; 0000 02B6 else if(jp_mode==jp3)
; 0000 02B7 	{
; 0000 02B8 	if(main_cnt1<(5*TZAS))
; 0000 02B9 		{
; 0000 02BA 		led_red=0x00000000L;
; 0000 02BB 		led_green=0x03030303L;
; 0000 02BC 		}
; 0000 02BD 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
; 0000 02BE 		{
; 0000 02BF 		led_red=0x00000000L;
; 0000 02C0 		led_green=0xffffffffL;
; 0000 02C1 		}
; 0000 02C2 
; 0000 02C3 	else if((flags&0b00011110)==0)
; 0000 02C4 		{
; 0000 02C5 		led_red=0x00000000L;
; 0000 02C6 		led_green=0xffffffffL;
; 0000 02C7 		}
; 0000 02C8 
; 0000 02C9 
; 0000 02CA 	else if((flags&0b00111110)==0b00000100)
; 0000 02CB 		{
; 0000 02CC 		led_red=0x00010001L;
; 0000 02CD 		led_green=0xffffffffL;
; 0000 02CE 		}
; 0000 02CF 	else if(flags&0b00000010)
; 0000 02D0 		{
; 0000 02D1 		led_red=0x00010001L;
; 0000 02D2 		led_green=0x00000000L;
; 0000 02D3 		}
; 0000 02D4 	else if(flags&0b00001000)
; 0000 02D5 		{
; 0000 02D6 		led_red=0x00090009L;
; 0000 02D7 		led_green=0x00000000L;
; 0000 02D8 		}
; 0000 02D9 	else if(flags&0b00010000)
; 0000 02DA 		{
; 0000 02DB 		led_red=0x00490049L;
; 0000 02DC 		led_green=0xffffffffL;
; 0000 02DD 		}
; 0000 02DE 		/*led_green=0x33333333L;
; 0000 02DF 		led_red=0xccccccccL;*/
; 0000 02E0 	}
; 0000 02E1 
; 0000 02E2 }
;
;//-----------------------------------------------
;void led_hndl(void)
; 0000 02E6 {
_led_hndl:
; .FSTART _led_hndl
; 0000 02E7 if(adress_error)
	LDS  R30,_adress_error
	CPI  R30,0
	BREQ _0x1C0
; 0000 02E8 	{
; 0000 02E9 	led_red=0x55555555L;
	CALL SUBOPT_0x34
	CALL SUBOPT_0x35
; 0000 02EA 	led_green=0x55555555L;
	CALL SUBOPT_0x34
	RJMP _0x3A0
; 0000 02EB 	}
; 0000 02EC 
; 0000 02ED /*else if(bps_class==bpsIBEP)		//проверка работы адресатора
; 0000 02EE 	{
; 0000 02EF 	if(adress==0)led_red=0x00000001L;
; 0000 02F0 	if(adress==1)led_red=0x00000005L;
; 0000 02F1 	if(adress==2)led_red=0x00000015L;
; 0000 02F2 	if(adress==3)led_red=0x00000055L;
; 0000 02F3 	if(adress==4)led_red=0x00000155L;
; 0000 02F4 	if(adress==5)led_red=0x00111111L;
; 0000 02F5 	if(adress==6)led_red=0x01111111L;
; 0000 02F6 	if(adress==7)led_red=0x11111111L;
; 0000 02F7 	led_green=0x00000000L;
; 0000 02F8 	}*/
; 0000 02F9 /*		else  if(link==OFF)
; 0000 02FA 			{
; 0000 02FB 			led_red=0x555ff555L;
; 0000 02FC 			led_green=0xffffffffL;
; 0000 02FD 			}
; 0000 02FE else if(link_cnt>50)
; 0000 02FF 	{
; 0000 0300 	led_red=0x5555ff55L;
; 0000 0301 	led_green=0x55555555L;
; 0000 0302 	} */
; 0000 0303 
; 0000 0304 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
_0x1C0:
	LDS  R30,_bps_class
	CPI  R30,0
	BREQ PC+2
	RJMP _0x1C2
; 0000 0305 	{
; 0000 0306 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x1C3
; 0000 0307 		{
; 0000 0308 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x1C4
; 0000 0309 			{
; 0000 030A 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 030B 			led_green=0x03030303L;
	CALL SUBOPT_0x38
	RJMP _0x3A1
; 0000 030C 			}
; 0000 030D 
; 0000 030E 		else if((link==ON)&&(flags_tu&0b10000000))
_0x1C4:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1C7
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x1C8
_0x1C7:
	RJMP _0x1C6
_0x1C8:
; 0000 030F 			{
; 0000 0310 			led_red=0x00055555L;
	CALL SUBOPT_0x39
; 0000 0311 			led_green=0xffffffffL;
	RJMP _0x3A1
; 0000 0312 			}
; 0000 0313 
; 0000 0314 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
_0x1C6:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x1CB
	CALL SUBOPT_0x3A
	BRLT _0x1CC
_0x1CB:
	RJMP _0x1CD
_0x1CC:
	CALL SUBOPT_0x3B
	BREQ _0x1CD
	CALL SUBOPT_0x21
	SBIW R30,0
	BREQ _0x1CE
_0x1CD:
	RJMP _0x1CA
_0x1CE:
; 0000 0315 			{
; 0000 0316 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0317 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3A1
; 0000 0318 			}
; 0000 0319 
; 0000 031A 		else  if(link==OFF)
_0x1CA:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x1D0
; 0000 031B 			{
; 0000 031C 			led_red=0x55555555L;
	CALL SUBOPT_0x3D
; 0000 031D 			led_green=0xffffffffL;
	RJMP _0x3A1
; 0000 031E 			}
; 0000 031F 
; 0000 0320 		else if((link==ON)&&((flags&0b00111110)==0))
_0x1D0:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1D3
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x1D4
_0x1D3:
	RJMP _0x1D2
_0x1D4:
; 0000 0321 			{
; 0000 0322 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0323 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3A1
; 0000 0324 			}
; 0000 0325 
; 0000 0326 		else if((flags&0b00111110)==0b00000100)
_0x1D2:
	CALL SUBOPT_0x3E
	BRNE _0x1D6
; 0000 0327 			{
; 0000 0328 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 0329 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3A1
; 0000 032A 			}
; 0000 032B 		else if(flags&0b00000010)
_0x1D6:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x1D8
; 0000 032C 			{
; 0000 032D 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 032E 			led_green=0x00000000L;
	CALL SUBOPT_0x40
; 0000 032F 			}
; 0000 0330 		else if(flags&0b00001000)
	RJMP _0x1D9
_0x1D8:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x1DA
; 0000 0331 			{
; 0000 0332 			led_red=0x00090009L;
	CALL SUBOPT_0x41
; 0000 0333 			led_green=0x00000000L;
; 0000 0334 			}
; 0000 0335 		else if(flags&0b00010000)
	RJMP _0x1DB
_0x1DA:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x1DC
; 0000 0336 			{
; 0000 0337 			led_red=0x00490049L;
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
; 0000 0338 			led_green=0x00000000L;
; 0000 0339 			}
; 0000 033A 
; 0000 033B 		else if((link==ON)&&(flags&0b00100000))
	RJMP _0x1DD
_0x1DC:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1DF
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x1E0
_0x1DF:
	RJMP _0x1DE
_0x1E0:
; 0000 033C 			{
; 0000 033D 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 033E 			led_green=0x00030003L;
	__GETD1N 0x30003
_0x3A1:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 033F 			}
; 0000 0340 
; 0000 0341 		if((jp_mode==jp1))
_0x1DE:
_0x1DD:
_0x1DB:
_0x1D9:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x1E1
; 0000 0342 			{
; 0000 0343 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0344 			led_green=0x33333333L;
	CALL SUBOPT_0x44
; 0000 0345 			}
; 0000 0346 		else if((jp_mode==jp2))
	RJMP _0x1E2
_0x1E1:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x1E3
; 0000 0347 			{
; 0000 0348 			led_red=0xccccccccL;
	CALL SUBOPT_0x45
; 0000 0349 			led_green=0x00000000L;
; 0000 034A 			}
; 0000 034B 		}
_0x1E3:
_0x1E2:
; 0000 034C 	else if(jp_mode==jp3)
	RJMP _0x1E4
_0x1C3:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0x1E5
; 0000 034D 		{
; 0000 034E 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x1E6
; 0000 034F 			{
; 0000 0350 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0351 			led_green=0x03030303L;
	CALL SUBOPT_0x38
	RJMP _0x3A2
; 0000 0352 			}
; 0000 0353 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
_0x1E6:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x1E9
	CALL SUBOPT_0x46
	BRLT _0x1EA
_0x1E9:
	RJMP _0x1E8
_0x1EA:
; 0000 0354 			{
; 0000 0355 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0356 			led_green=0xffffffffL;
	RJMP _0x3A3
; 0000 0357 			}
; 0000 0358 
; 0000 0359 		else if((flags&0b00011110)==0)
_0x1E8:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x1EC
; 0000 035A 			{
; 0000 035B 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 035C 			led_green=0xffffffffL;
	RJMP _0x3A3
; 0000 035D 			}
; 0000 035E 
; 0000 035F 
; 0000 0360 		else if((flags&0b00111110)==0b00000100)
_0x1EC:
	CALL SUBOPT_0x3E
	BRNE _0x1EE
; 0000 0361 			{
; 0000 0362 			led_red=0x00010001L;
	__GETD1N 0x10001
	RJMP _0x3A4
; 0000 0363 			led_green=0xffffffffL;
; 0000 0364 			}
; 0000 0365 		else if(flags&0b00000010)
_0x1EE:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x1F0
; 0000 0366 			{
; 0000 0367 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 0368 			led_green=0x00000000L;
	CALL SUBOPT_0x40
; 0000 0369 			}
; 0000 036A 		else if(flags&0b00001000)
	RJMP _0x1F1
_0x1F0:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x1F2
; 0000 036B 			{
; 0000 036C 			led_red=0x00090009L;
	CALL SUBOPT_0x41
; 0000 036D 			led_green=0x00000000L;
; 0000 036E 			}
; 0000 036F 		else if(flags&0b00010000)
	RJMP _0x1F3
_0x1F2:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x1F4
; 0000 0370 			{
; 0000 0371 			led_red=0x00490049L;
	CALL SUBOPT_0x42
_0x3A4:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 0372 			led_green=0xffffffffL;
_0x3A3:
	__GETD1N 0xFFFFFFFF
_0x3A2:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0373 			}
; 0000 0374 		}
_0x1F4:
_0x1F3:
_0x1F1:
; 0000 0375 	}
_0x1E5:
_0x1E4:
; 0000 0376 else if(bps_class==bpsIPS)	//если блок ИПСный
	RJMP _0x1F5
_0x1C2:
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x1F6
; 0000 0377 	{
; 0000 0378 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x1F7
; 0000 0379 		{
; 0000 037A 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x1F8
; 0000 037B 			{
; 0000 037C 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 037D 			led_green=0x03030303L;
	CALL SUBOPT_0x38
	RJMP _0x3A5
; 0000 037E 			}
; 0000 037F 
; 0000 0380 		else if((link==ON)&&(flags_tu&0b10000000))
_0x1F8:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1FB
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x1FC
_0x1FB:
	RJMP _0x1FA
_0x1FC:
; 0000 0381 			{
; 0000 0382 			led_red=0x00055555L;
	CALL SUBOPT_0x39
; 0000 0383 			led_green=0xffffffffL;
	RJMP _0x3A5
; 0000 0384 			}
; 0000 0385 
; 0000 0386 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
_0x1FA:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x1FF
	CALL SUBOPT_0x3A
	BRLT _0x200
_0x1FF:
	RJMP _0x201
_0x200:
	CALL SUBOPT_0x3B
	BREQ _0x201
	CALL SUBOPT_0x21
	SBIW R30,0
	BREQ _0x202
_0x201:
	RJMP _0x1FE
_0x202:
; 0000 0387 			{
; 0000 0388 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0389 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3A5
; 0000 038A 			}
; 0000 038B 
; 0000 038C 		else  if(link==OFF)
_0x1FE:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ PC+2
	RJMP _0x204
; 0000 038D 			{
; 0000 038E 			if((flags&0b00011110)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x205
; 0000 038F 				{
; 0000 0390 				led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 0391 				if(bMAIN)led_green=0xfffffff5L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x206
	__GETD1N 0xFFFFFFF5
	RJMP _0x3A6
; 0000 0392 				else led_green=0xffffffffL;
_0x206:
	CALL SUBOPT_0x3C
_0x3A6:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0393 				}
; 0000 0394 
; 0000 0395 			else if((flags&0b00111110)==0b00000100)
	RJMP _0x208
_0x205:
	CALL SUBOPT_0x3E
	BRNE _0x209
; 0000 0396 				{
; 0000 0397 				led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 0398 				if(bMAIN)led_green=0xfffffff5L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x20A
	__GETD1N 0xFFFFFFF5
	RJMP _0x3A7
; 0000 0399 				else led_green=0xffffffffL;
_0x20A:
	CALL SUBOPT_0x3C
_0x3A7:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 039A 				}
; 0000 039B 			else if(flags&0b00000010)
	RJMP _0x20C
_0x209:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x20D
; 0000 039C 				{
; 0000 039D 				led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 039E 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x20E
	CALL SUBOPT_0x47
; 0000 039F 				else led_green=0x00000000L;
	RJMP _0x20F
_0x20E:
	CALL SUBOPT_0x40
; 0000 03A0 				}
_0x20F:
; 0000 03A1 			else if(flags&0b00001000)
	RJMP _0x210
_0x20D:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x211
; 0000 03A2 				{
; 0000 03A3 				led_red=0x00090009L;
	__GETD1N 0x90009
	CALL SUBOPT_0x35
; 0000 03A4 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x212
	CALL SUBOPT_0x47
; 0000 03A5 				else led_green=0x00000000L;
	RJMP _0x213
_0x212:
	CALL SUBOPT_0x40
; 0000 03A6 				}
_0x213:
; 0000 03A7 			else if(flags&0b00010000)
	RJMP _0x214
_0x211:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x215
; 0000 03A8 				{
; 0000 03A9 				led_red=0x00490049L;
	CALL SUBOPT_0x42
	CALL SUBOPT_0x35
; 0000 03AA 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x216
	CALL SUBOPT_0x47
; 0000 03AB 				else led_green=0x00000000L;
	RJMP _0x217
_0x216:
	CALL SUBOPT_0x40
; 0000 03AC 				}
_0x217:
; 0000 03AD 			else
	RJMP _0x218
_0x215:
; 0000 03AE 				{
; 0000 03AF 				led_red=0x55555555L;
	CALL SUBOPT_0x3D
; 0000 03B0 				led_green=0xffffffffL;
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03B1 				}
_0x218:
_0x214:
_0x210:
_0x20C:
_0x208:
; 0000 03B2 
; 0000 03B3 
; 0000 03B4 /*			if(bMAIN)
; 0000 03B5 				{
; 0000 03B6 				led_red=0x0L;
; 0000 03B7 				led_green=0xfffffff5L;
; 0000 03B8 				}
; 0000 03B9 			else
; 0000 03BA 				{
; 0000 03BB 				led_red=0x55555555L;
; 0000 03BC 				led_green=0xffffffffL;
; 0000 03BD 				}*/
; 0000 03BE 			}
; 0000 03BF 
; 0000 03C0 		else if((link==ON)&&((flags&0b00111110)==0))
	RJMP _0x219
_0x204:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x21B
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x21C
_0x21B:
	RJMP _0x21A
_0x21C:
; 0000 03C1 			{
; 0000 03C2 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 03C3 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3A5
; 0000 03C4 			}
; 0000 03C5 
; 0000 03C6 		else if((flags&0b00111110)==0b00000100)
_0x21A:
	CALL SUBOPT_0x3E
	BRNE _0x21E
; 0000 03C7 			{
; 0000 03C8 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 03C9 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3A5
; 0000 03CA 			}
; 0000 03CB 		else if(flags&0b00000010)
_0x21E:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x220
; 0000 03CC 			{
; 0000 03CD 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 03CE 			led_green=0x00000000L;
	CALL SUBOPT_0x40
; 0000 03CF 			}
; 0000 03D0 		else if(flags&0b00001000)
	RJMP _0x221
_0x220:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x222
; 0000 03D1 			{
; 0000 03D2 			led_red=0x00090009L;
	CALL SUBOPT_0x41
; 0000 03D3 			led_green=0x00000000L;
; 0000 03D4 			}
; 0000 03D5 		else if(flags&0b00010000)
	RJMP _0x223
_0x222:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x224
; 0000 03D6 			{
; 0000 03D7 			led_red=0x00490049L;
	CALL SUBOPT_0x42
	CALL SUBOPT_0x43
; 0000 03D8 			led_green=0x00000000L;
; 0000 03D9 			}
; 0000 03DA 
; 0000 03DB 		else if((link==ON)&&(flags&0b00100000))
	RJMP _0x225
_0x224:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x227
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x228
_0x227:
	RJMP _0x226
_0x228:
; 0000 03DC 			{
; 0000 03DD 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 03DE 			led_green=0x00030003L;
	__GETD1N 0x30003
_0x3A5:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03DF 			}
; 0000 03E0 
; 0000 03E1 		if((jp_mode==jp1))
_0x226:
_0x225:
_0x223:
_0x221:
_0x219:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x229
; 0000 03E2 			{
; 0000 03E3 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 03E4 			led_green=0x33333333L;
	CALL SUBOPT_0x44
; 0000 03E5 			}
; 0000 03E6 		else if((jp_mode==jp2))
	RJMP _0x22A
_0x229:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x22B
; 0000 03E7 			{
; 0000 03E8 			//if(ee_DEVICE)led_red=0xccccccacL;
; 0000 03E9 			//else led_red=0xcc0cccacL;
; 0000 03EA 			led_red=0xccccccccL;
	CALL SUBOPT_0x45
; 0000 03EB 			led_green=0x00000000L;
; 0000 03EC 			}
; 0000 03ED 		}
_0x22B:
_0x22A:
; 0000 03EE 	else if(jp_mode==jp3)
	RJMP _0x22C
_0x1F7:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0x22D
; 0000 03EF 		{
; 0000 03F0 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x22E
; 0000 03F1 			{
; 0000 03F2 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 03F3 			led_green=0x03030303L;
	CALL SUBOPT_0x38
	RJMP _0x3A0
; 0000 03F4 			}
; 0000 03F5 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
_0x22E:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x231
	CALL SUBOPT_0x46
	BRLT _0x232
_0x231:
	RJMP _0x230
_0x232:
; 0000 03F6 			{
; 0000 03F7 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 03F8 			led_green=0xffffffffL;
	RJMP _0x3A8
; 0000 03F9 			}
; 0000 03FA 
; 0000 03FB 		else if((flags&0b00011110)==0)
_0x230:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x234
; 0000 03FC 			{
; 0000 03FD 			led_red=0x00000000L;
	CALL SUBOPT_0x37
; 0000 03FE 			led_green=0xffffffffL;
	RJMP _0x3A8
; 0000 03FF 			}
; 0000 0400 
; 0000 0401 
; 0000 0402 		else if((flags&0b00111110)==0b00000100)
_0x234:
	CALL SUBOPT_0x3E
	BRNE _0x236
; 0000 0403 			{
; 0000 0404 			led_red=0x00010001L;
	__GETD1N 0x10001
	RJMP _0x3A9
; 0000 0405 			led_green=0xffffffffL;
; 0000 0406 			}
; 0000 0407 		else if(flags&0b00000010)
_0x236:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x238
; 0000 0408 			{
; 0000 0409 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
; 0000 040A 			led_green=0x00000000L;
	CALL SUBOPT_0x40
; 0000 040B 			}
; 0000 040C 		else if(flags&0b00001000)
	RJMP _0x239
_0x238:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x23A
; 0000 040D 			{
; 0000 040E 			led_red=0x00090009L;
	CALL SUBOPT_0x41
; 0000 040F 			led_green=0x00000000L;
; 0000 0410 			}
; 0000 0411 		else if(flags&0b00010000)
	RJMP _0x23B
_0x23A:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x23C
; 0000 0412 			{
; 0000 0413 			led_red=0x00490049L;
	CALL SUBOPT_0x42
_0x3A9:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 0414 			led_green=0xffffffffL;
_0x3A8:
	__GETD1N 0xFFFFFFFF
_0x3A0:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0415 			}
; 0000 0416 		}
_0x23C:
_0x23B:
_0x239:
; 0000 0417 	}
_0x22D:
_0x22C:
; 0000 0418 }
_0x1F6:
_0x1F5:
	RET
; .FEND
;
;
;
;
;//-----------------------------------------------
;void pwr_drv_(void)
; 0000 041F {
; 0000 0420 DDRD.4=1;
; 0000 0421 
; 0000 0422 if(main_cnt1<150)main_cnt1++;
; 0000 0423 
; 0000 0424 if(main_cnt1<(5*TZAS))
; 0000 0425 	{
; 0000 0426 	PORTD.4=1;
; 0000 0427 	}
; 0000 0428 else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
; 0000 0429 	{
; 0000 042A 	PORTD.4=0;
; 0000 042B 	}
; 0000 042C else if(bBL)
; 0000 042D 	{
; 0000 042E 	PORTD.4=1;
; 0000 042F 	}
; 0000 0430 else if(!bBL)
; 0000 0431 	{
; 0000 0432 	PORTD.4=0;
; 0000 0433 	}
; 0000 0434 
; 0000 0435 //DDRB|=0b00000010;
; 0000 0436 
; 0000 0437 gran(&pwm_u,2,1020);
; 0000 0438 
; 0000 0439 
; 0000 043A OCR1A=pwm_u;
; 0000 043B /*PORTB.2=1;
; 0000 043C OCR1A=0;*/
; 0000 043D }
;
;//-----------------------------------------------
;//Вентилятор
;void vent_drv(void)
; 0000 0442 {
_vent_drv:
; .FSTART _vent_drv
; 0000 0443 
; 0000 0444 
; 0000 0445 	short vent_pwm_i_necc=400;
; 0000 0446 	short vent_pwm_t_necc=400;
; 0000 0447 	short vent_pwm_max_necc=400;
; 0000 0448 	signed long tempSL;
; 0000 0449 
; 0000 044A 	//I=1200;
; 0000 044B 
; 0000 044C 	tempSL=36000L/(signed long)ee_Umax;
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
	CALL SUBOPT_0x48
; 0000 044D 	tempSL=(signed long)I/tempSL;
	LDS  R26,_I
	LDS  R27,_I+1
	CLR  R24
	CLR  R25
	__GETD1S 6
	CALL SUBOPT_0x48
; 0000 044E 
; 0000 044F 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
	CALL SUBOPT_0x21
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x251
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMRDW
	LDS  R26,_I
	LDS  R27,_I+1
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	__PUTD1S 6
; 0000 0450 
; 0000 0451 	if(tempSL>10)vent_pwm_i_necc=1000;
_0x251:
	CALL SUBOPT_0x49
	__CPD2N 0xB
	BRLT _0x252
	__GETWRN 16,17,1000
; 0000 0452 	else if(tempSL<1)vent_pwm_i_necc=400;
	RJMP _0x253
_0x252:
	CALL SUBOPT_0x49
	__CPD2N 0x1
	BRGE _0x254
	__GETWRN 16,17,400
; 0000 0453 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
	RJMP _0x255
_0x254:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(60)
	LDI  R27,HIGH(60)
	CALL __MULW12
	SUBI R30,LOW(-400)
	SBCI R31,HIGH(-400)
	MOVW R16,R30
; 0000 0454 	gran(&vent_pwm_i_necc,400,1000);
_0x255:
_0x253:
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL SUBOPT_0x4A
	RCALL _gran
	POP  R16
	POP  R17
; 0000 0455 	//vent_pwm_i_necc=400;
; 0000 0456 	tempSL=(signed long)T;
	LDS  R30,_T
	LDS  R31,_T+1
	CALL __CWD1
	__PUTD1S 6
; 0000 0457 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
	CALL SUBOPT_0x20
	CALL __CWD1
	__SUBD1N 30
	CALL SUBOPT_0x49
	CALL __CPD12
	BRLT _0x256
	__GETWRN 18,19,400
; 0000 0458 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
	RJMP _0x257
_0x256:
	CALL SUBOPT_0x20
	CALL SUBOPT_0x49
	CALL __CWD1
	CALL __CPD21
	BRLT _0x258
	__GETWRN 18,19,1000
; 0000 0459 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
	RJMP _0x259
_0x258:
	CALL SUBOPT_0x20
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
; 0000 045A 	gran(&vent_pwm_t_necc,400,1000);
_0x259:
_0x257:
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R19
	PUSH R18
	CALL SUBOPT_0x4A
	RCALL _gran
	POP  R18
	POP  R19
; 0000 045B 
; 0000 045C 	vent_pwm_max_necc=vent_pwm_i_necc;
	MOVW R20,R16
; 0000 045D 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
	__CPWRR 16,17,18,19
	BRGE _0x25A
	MOVW R20,R18
; 0000 045E 
; 0000 045F 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
_0x25A:
	CALL SUBOPT_0x4B
	CP   R26,R20
	CPC  R27,R21
	BRGE _0x25B
	LDS  R30,_vent_pwm
	LDS  R31,_vent_pwm+1
	ADIW R30,10
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R31
; 0000 0460 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
_0x25B:
	CALL SUBOPT_0x4B
	CP   R20,R26
	CPC  R21,R27
	BRGE _0x25C
	LDS  R30,_vent_pwm
	LDS  R31,_vent_pwm+1
	SBIW R30,10
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R31
; 0000 0461 	gran(&vent_pwm,400,1000);
_0x25C:
	LDI  R30,LOW(_vent_pwm)
	LDI  R31,HIGH(_vent_pwm)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x4A
	RCALL _gran
; 0000 0462 
; 0000 0463 	//vent_pwm=1000-vent_pwm;	// Для нового блока. Там похоже нужна инверсия
; 0000 0464 	//vent_pwm=300;
; 0000 0465 	if(bVENT_BLOCK)vent_pwm=0;
	LDS  R30,_bVENT_BLOCK
	CPI  R30,0
	BREQ _0x25D
	LDI  R30,LOW(0)
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R30
; 0000 0466 }
_0x25D:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;
;//-----------------------------------------------
;void vent_resurs_hndl(void)
; 0000 046A {
_vent_resurs_hndl:
; .FSTART _vent_resurs_hndl
; 0000 046B unsigned char temp;
; 0000 046C if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
	ST   -Y,R17
;	temp -> R17
	LDS  R30,_bVENT_BLOCK
	CPI  R30,0
	BRNE _0x25E
	LDI  R26,LOW(_vent_resurs_sec_cnt)
	LDI  R27,HIGH(_vent_resurs_sec_cnt)
	CALL SUBOPT_0x25
; 0000 046D if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
_0x25E:
	LDS  R26,_vent_resurs_sec_cnt
	LDS  R27,_vent_resurs_sec_cnt+1
	CPI  R26,LOW(0xE11)
	LDI  R30,HIGH(0xE11)
	CPC  R27,R30
	BRLO _0x25F
; 0000 046E 	{
; 0000 046F 	if(vent_resurs<60000)vent_resurs++;
	CALL SUBOPT_0x4C
	CPI  R30,LOW(0xEA60)
	LDI  R26,HIGH(0xEA60)
	CPC  R31,R26
	BRSH _0x260
	CALL SUBOPT_0x4C
	ADIW R30,1
	CALL __EEPROMWRW
; 0000 0470 	vent_resurs_sec_cnt=0;
_0x260:
	LDI  R30,LOW(0)
	STS  _vent_resurs_sec_cnt,R30
	STS  _vent_resurs_sec_cnt+1,R30
; 0000 0471 	}
; 0000 0472 
; 0000 0473 //vent_resurs=12543;
; 0000 0474 
; 0000 0475 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
_0x25F:
	CALL SUBOPT_0x4C
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _vent_resurs_buff,R30
; 0000 0476 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
	CALL SUBOPT_0x4C
	ANDI R30,LOW(0xF0)
	ANDI R31,HIGH(0xF0)
	CALL __LSRW4
	LDI  R31,0
	ORI  R30,0x40
	__PUTB1MN _vent_resurs_buff,1
; 0000 0477 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
	CALL SUBOPT_0x4C
	ANDI R30,LOW(0xF00)
	ANDI R31,HIGH(0xF00)
	MOV  R30,R31
	LDI  R31,0
	LDI  R31,0
	ORI  R30,0x80
	__PUTB1MN _vent_resurs_buff,2
; 0000 0478 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
	CALL SUBOPT_0x4C
	ANDI R30,LOW(0xF000)
	ANDI R31,HIGH(0xF000)
	CALL __LSRW4
	MOV  R30,R31
	LDI  R31,0
	LDI  R31,0
	ORI  R30,LOW(0xC0)
	__PUTB1MN _vent_resurs_buff,3
; 0000 0479 
; 0000 047A temp=vent_resurs_buff[0]&0x0f;
	LDS  R30,_vent_resurs_buff
	ANDI R30,LOW(0xF)
	MOV  R17,R30
; 0000 047B temp^=vent_resurs_buff[1]&0x0f;
	__GETB1MN _vent_resurs_buff,1
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 047C temp^=vent_resurs_buff[2]&0x0f;
	__GETB1MN _vent_resurs_buff,2
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 047D temp^=vent_resurs_buff[3]&0x0f;
	__GETB1MN _vent_resurs_buff,3
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 047E 
; 0000 047F vent_resurs_buff[0]|=(temp&0x03)<<4;
	MOV  R30,R17
	ANDI R30,LOW(0x3)
	SWAP R30
	ANDI R30,0xF0
	LDS  R26,_vent_resurs_buff
	OR   R30,R26
	STS  _vent_resurs_buff,R30
; 0000 0480 vent_resurs_buff[1]|=(temp&0x0c)<<2;
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
; 0000 0481 vent_resurs_buff[2]|=(temp&0x30);
	__POINTW1MN _vent_resurs_buff,2
	MOVW R0,R30
	LD   R26,Z
	MOV  R30,R17
	ANDI R30,LOW(0x30)
	OR   R30,R26
	MOVW R26,R0
	ST   X,R30
; 0000 0482 vent_resurs_buff[3]|=(temp&0xc0)>>2;
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
; 0000 0483 
; 0000 0484 
; 0000 0485 vent_resurs_tx_cnt++;
	LDS  R30,_vent_resurs_tx_cnt
	SUBI R30,-LOW(1)
	STS  _vent_resurs_tx_cnt,R30
; 0000 0486 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
	LDS  R26,_vent_resurs_tx_cnt
	CPI  R26,LOW(0x4)
	BRLO _0x261
	LDI  R30,LOW(0)
	STS  _vent_resurs_tx_cnt,R30
; 0000 0487 
; 0000 0488 
; 0000 0489 }
_0x261:
	RJMP _0x20C0001
; .FEND
;
;//-----------------------------------------------
;void volum_u_main_drv(void)
; 0000 048D {
_volum_u_main_drv:
; .FSTART _volum_u_main_drv
; 0000 048E char i;
; 0000 048F 
; 0000 0490 if(bMAIN)
	ST   -Y,R17
;	i -> R17
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x262
; 0000 0491 	{
; 0000 0492 	if(Un<(UU_AVT-10))volum_u_main_+=5;
	CALL SUBOPT_0x4D
	SBIW R30,10
	CALL SUBOPT_0x4E
	BRSH _0x263
	CALL SUBOPT_0x4F
	ADIW R30,5
	CALL SUBOPT_0x50
; 0000 0493 	else if(Un<(UU_AVT-1))volum_u_main_++;
	RJMP _0x264
_0x263:
	CALL SUBOPT_0x4D
	SBIW R30,1
	CALL SUBOPT_0x4E
	BRSH _0x265
	LDI  R26,LOW(_volum_u_main_)
	LDI  R27,HIGH(_volum_u_main_)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3AB
; 0000 0494 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
_0x265:
	CALL SUBOPT_0x4D
	ADIW R30,10
	CALL SUBOPT_0x51
	BRSH _0x267
	CALL SUBOPT_0x4F
	SBIW R30,10
	CALL SUBOPT_0x50
; 0000 0495 	else if(Un>(UU_AVT+1))volum_u_main_--;
	RJMP _0x268
_0x267:
	CALL SUBOPT_0x4D
	ADIW R30,1
	CALL SUBOPT_0x51
	BRSH _0x269
	LDI  R26,LOW(_volum_u_main_)
	LDI  R27,HIGH(_volum_u_main_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3AB:
	ST   -X,R31
	ST   -X,R30
; 0000 0496 	if(volum_u_main_>1020)volum_u_main_=1020;
_0x269:
_0x268:
_0x264:
	LDS  R26,_volum_u_main_
	LDS  R27,_volum_u_main_+1
	CPI  R26,LOW(0x3FD)
	LDI  R30,HIGH(0x3FD)
	CPC  R27,R30
	BRLT _0x26A
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	CALL SUBOPT_0x50
; 0000 0497 	if(volum_u_main_<0)volum_u_main_=0;
_0x26A:
	LDS  R26,_volum_u_main_+1
	TST  R26
	BRPL _0x26B
	LDI  R30,LOW(0)
	STS  _volum_u_main_,R30
	STS  _volum_u_main_+1,R30
; 0000 0498 	//volum_u_main_=700;
; 0000 0499 
; 0000 049A 	i_main_sigma=0;
_0x26B:
	LDI  R30,LOW(0)
	STS  _i_main_sigma,R30
	STS  _i_main_sigma+1,R30
; 0000 049B 	i_main_num_of_bps=0;
	STS  _i_main_num_of_bps,R30
; 0000 049C 	for(i=0;i<6;i++)
	LDI  R17,LOW(0)
_0x26D:
	CPI  R17,6
	BRSH _0x26E
; 0000 049D 		{
; 0000 049E 		if(i_main_flag[i])
	CALL SUBOPT_0x52
	LD   R30,Z
	CPI  R30,0
	BREQ _0x26F
; 0000 049F 			{
; 0000 04A0 			i_main_sigma+=i_main[i];
	CALL SUBOPT_0x53
	LDS  R26,_i_main_sigma
	LDS  R27,_i_main_sigma+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _i_main_sigma,R30
	STS  _i_main_sigma+1,R31
; 0000 04A1 			i_main_flag[i]=1;
	CALL SUBOPT_0x52
	LDI  R26,LOW(1)
	STD  Z+0,R26
; 0000 04A2 			i_main_num_of_bps++;
	LDS  R30,_i_main_num_of_bps
	SUBI R30,-LOW(1)
	STS  _i_main_num_of_bps,R30
; 0000 04A3 			}
; 0000 04A4 		else
	RJMP _0x270
_0x26F:
; 0000 04A5 			{
; 0000 04A6 			i_main_flag[i]=0;
	CALL SUBOPT_0x52
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0000 04A7 			}
_0x270:
; 0000 04A8 		}
	SUBI R17,-1
	RJMP _0x26D
_0x26E:
; 0000 04A9 	i_main_avg=i_main_sigma/i_main_num_of_bps;
	LDS  R30,_i_main_num_of_bps
	LDS  R26,_i_main_sigma
	LDS  R27,_i_main_sigma+1
	LDI  R31,0
	CALL __DIVW21
	STS  _i_main_avg,R30
	STS  _i_main_avg+1,R31
; 0000 04AA 	for(i=0;i<6;i++)
	LDI  R17,LOW(0)
_0x272:
	CPI  R17,6
	BRLO PC+2
	RJMP _0x273
; 0000 04AB 		{
; 0000 04AC 		if(i_main_flag[i])
	CALL SUBOPT_0x52
	LD   R30,Z
	CPI  R30,0
	BREQ _0x274
; 0000 04AD 			{
; 0000 04AE 			if(i_main[i]<(i_main_avg-10))x[i]++;
	CALL SUBOPT_0x53
	MOVW R26,R30
	LDS  R30,_i_main_avg
	LDS  R31,_i_main_avg+1
	SBIW R30,10
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x275
	CALL SUBOPT_0x54
	ADIW R30,1
	RJMP _0x3AC
; 0000 04AF 			else if(i_main[i]>(i_main_avg+10))x[i]--;
_0x275:
	CALL SUBOPT_0x53
	MOVW R26,R30
	LDS  R30,_i_main_avg
	LDS  R31,_i_main_avg+1
	ADIW R30,10
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x277
	CALL SUBOPT_0x54
	SBIW R30,1
_0x3AC:
	ST   -X,R31
	ST   -X,R30
; 0000 04B0 			if(x[i]>100)x[i]=100;
_0x277:
	CALL SUBOPT_0x55
	CALL __GETW1P
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRLT _0x278
	CALL SUBOPT_0x55
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   X+,R30
	ST   X,R31
; 0000 04B1 			if(x[i]<-100)x[i]=-100;
_0x278:
	CALL SUBOPT_0x55
	CALL __GETW1P
	CPI  R30,LOW(0xFF9C)
	LDI  R26,HIGH(0xFF9C)
	CPC  R31,R26
	BRGE _0x279
	CALL SUBOPT_0x55
	LDI  R30,LOW(65436)
	LDI  R31,HIGH(65436)
	ST   X+,R30
	ST   X,R31
; 0000 04B2 			//if()
; 0000 04B3 			}
_0x279:
; 0000 04B4 
; 0000 04B5 		}
_0x274:
	SUBI R17,-1
	RJMP _0x272
_0x273:
; 0000 04B6 	//plazma_int[2]=x[1];
; 0000 04B7 	}
; 0000 04B8 }
_0x262:
_0x20C0001:
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;//Вычисление воздействий на силу
;//10Hz
;void pwr_hndl(void)
; 0000 04BE {
_pwr_hndl:
; .FSTART _pwr_hndl
; 0000 04BF if(jp_mode==jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x27A
; 0000 04C0 	{
; 0000 04C1 	if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE _0x27B
; 0000 04C2 		{
; 0000 04C3 		pwm_u=500;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	CALL SUBOPT_0x56
; 0000 04C4 		if(pwm_i<1020)
	BRSH _0x27C
; 0000 04C5 			{
; 0000 04C6 			pwm_i+=30;
	CALL SUBOPT_0x57
; 0000 04C7 			if(pwm_i>1020)pwm_i=1020;
	BRLO _0x27D
	CALL SUBOPT_0x58
; 0000 04C8 			}
_0x27D:
; 0000 04C9 		bBL=0;
_0x27C:
	CBI  0x1E,7
; 0000 04CA 		}
; 0000 04CB 	else if(flags&0b00001010)
	RJMP _0x280
_0x27B:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ _0x281
; 0000 04CC 		{
; 0000 04CD 		pwm_u=0;
	CALL SUBOPT_0x59
; 0000 04CE 		pwm_i=0;
	CALL SUBOPT_0x5A
; 0000 04CF 		bBL=1;
; 0000 04D0 		}
; 0000 04D1 
; 0000 04D2 	}
_0x281:
_0x280:
; 0000 04D3 else if(jp_mode==jp2)
	RJMP _0x284
_0x27A:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x285
; 0000 04D4 	{
; 0000 04D5 	pwm_u=0;
	CALL SUBOPT_0x59
; 0000 04D6 	//pwm_i=0x3ff;
; 0000 04D7 	if(pwm_i<1020)
	CALL SUBOPT_0x5B
	BRSH _0x286
; 0000 04D8 		{
; 0000 04D9 		pwm_i+=30;
	CALL SUBOPT_0x57
; 0000 04DA 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x287
	CALL SUBOPT_0x58
; 0000 04DB 		}
_0x287:
; 0000 04DC 	bBL=0;
_0x286:
	CBI  0x1E,7
; 0000 04DD 	}
; 0000 04DE else if(jp_mode==jp1)
	RJMP _0x28A
_0x285:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x28B
; 0000 04DF 	{
; 0000 04E0 	pwm_u=0x3ff;
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	CALL SUBOPT_0x56
; 0000 04E1 	//pwm_i=0x3ff;
; 0000 04E2 	if(pwm_i<1020)
	BRSH _0x28C
; 0000 04E3 		{
; 0000 04E4 		pwm_i+=30;
	CALL SUBOPT_0x57
; 0000 04E5 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x28D
	CALL SUBOPT_0x58
; 0000 04E6 		}
_0x28D:
; 0000 04E7 	bBL=0;
_0x28C:
	CBI  0x1E,7
; 0000 04E8 	}
; 0000 04E9 
; 0000 04EA else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
	RJMP _0x290
_0x28B:
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x292
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ _0x293
_0x292:
	RJMP _0x291
_0x293:
; 0000 04EB 	{
; 0000 04EC 	pwm_u=volum_u_main_;
	CALL SUBOPT_0x4F
	CALL SUBOPT_0x56
; 0000 04ED 	//pwm_i=0x3ff;
; 0000 04EE 	if(pwm_i<1020)
	BRSH _0x294
; 0000 04EF 		{
; 0000 04F0 		pwm_i+=30;
	CALL SUBOPT_0x57
; 0000 04F1 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x295
	CALL SUBOPT_0x58
; 0000 04F2 		}
_0x295:
; 0000 04F3 	bBL_IPS=0;
_0x294:
	IN   R30,0x2A
	CBR  R30,1
	OUT  0x2A,R30
; 0000 04F4 	}
; 0000 04F5 
; 0000 04F6 else if(link==OFF)
	RJMP _0x296
_0x291:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x297
; 0000 04F7 	{
; 0000 04F8 /*	if(ee_Device==0x55)
; 0000 04F9 		{
; 0000 04FA 		pwm_u=0x3ff;
; 0000 04FB 		pwm_i=0x3ff;
; 0000 04FC 		bBL=0;
; 0000 04FD 		}
; 0000 04FE 	else*/
; 0000 04FF  	if(ee_DEVICE)
	CALL SUBOPT_0x21
	SBIW R30,0
	BREQ _0x298
; 0000 0500 		{
; 0000 0501 		pwm_u=0x00;
	CALL SUBOPT_0x59
; 0000 0502 		pwm_i=0x00;
	CALL SUBOPT_0x5A
; 0000 0503 		bBL=1;
; 0000 0504 		}
; 0000 0505 	else
	RJMP _0x29B
_0x298:
; 0000 0506 		{
; 0000 0507 		if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE _0x29C
; 0000 0508 			{
; 0000 0509 			pwm_u=ee_U_AVT;
	LDI  R26,LOW(_ee_U_AVT)
	LDI  R27,HIGH(_ee_U_AVT)
	CALL __EEPROMRDW
	CALL SUBOPT_0x5C
; 0000 050A 			gran(&pwm_u,0,1020);
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x5D
; 0000 050B 		    	//pwm_i=0x3ff;
; 0000 050C 			if(pwm_i<1020)
	CALL SUBOPT_0x5B
	BRSH _0x29D
; 0000 050D 				{
; 0000 050E 				pwm_i+=30;
	CALL SUBOPT_0x57
; 0000 050F 				if(pwm_i>1020)pwm_i=1020;
	BRLO _0x29E
	CALL SUBOPT_0x58
; 0000 0510 				}
_0x29E:
; 0000 0511 			bBL=0;
_0x29D:
	CBI  0x1E,7
; 0000 0512 			bBL_IPS=0;
	IN   R30,0x2A
	CBR  R30,1
	RJMP _0x3AD
; 0000 0513 			}
; 0000 0514 		else if(flags&0b00011010)
_0x29C:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2A2
; 0000 0515 			{
; 0000 0516 			pwm_u=0;
	CALL SUBOPT_0x59
; 0000 0517 			pwm_i=0;
	CALL SUBOPT_0x5A
; 0000 0518 			bBL=1;
; 0000 0519 			bBL_IPS=1;
	IN   R30,0x2A
	SBR  R30,1
_0x3AD:
	OUT  0x2A,R30
; 0000 051A 			}
; 0000 051B 		}
_0x2A2:
_0x29B:
; 0000 051C //pwm_u=950;
; 0000 051D //		pwm_i=950;
; 0000 051E 	}
; 0000 051F 
; 0000 0520 
; 0000 0521 
; 0000 0522 else	if(link==ON)				//если есть связьvol_i_temp_avar
	RJMP _0x2A5
_0x297:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+2
	RJMP _0x2A6
; 0000 0523 	{
; 0000 0524 	if((flags&0b00100000)==0)	//если нет блокировки извне
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ PC+2
	RJMP _0x2A7
; 0000 0525 		{
; 0000 0526 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	CPI  R30,LOW(0x4)
	BRNE _0x2A8
; 0000 0527 			{
; 0000 0528 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
	CALL SUBOPT_0x5E
; 0000 0529 			if(!ee_DEVICE)
	SBIW R30,0
	BRNE _0x2A9
; 0000 052A 				{
; 0000 052B 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x60
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x2AA
	LDS  R26,_vol_i_temp_avar
	LDS  R27,_vol_i_temp_avar+1
	CALL SUBOPT_0x61
	RJMP _0x3AE
; 0000 052C 				else	pwm_i=vol_i_temp_avar;
_0x2AA:
	CALL SUBOPT_0x5F
_0x3AE:
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 052D 				}
; 0000 052E 			else pwm_i=vol_i_temp_avar;
	RJMP _0x2AC
_0x2A9:
	CALL SUBOPT_0x5F
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 052F 
; 0000 0530 			bBL=0;
_0x2AC:
	CBI  0x1E,7
; 0000 0531 			}
; 0000 0532 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
_0x2A8:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2B0
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x2AF
_0x2B0:
; 0000 0533 			{
; 0000 0534 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
	CALL SUBOPT_0x5E
; 0000 0535 		    	//pwm_i=vol_i_temp;
; 0000 0536 			if(!ee_DEVICE)
	SBIW R30,0
	BRNE _0x2B2
; 0000 0537 				{
; 0000 0538 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
	CALL SUBOPT_0x62
	CALL SUBOPT_0x60
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x2B3
	LDS  R26,_vol_i_temp
	LDS  R27,_vol_i_temp+1
	CALL SUBOPT_0x61
	RJMP _0x3AF
; 0000 0539 				else	pwm_i=vol_i_temp;
_0x2B3:
	CALL SUBOPT_0x62
_0x3AF:
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 053A 				}
; 0000 053B 			else pwm_i=vol_i_temp;
	RJMP _0x2B5
_0x2B2:
	CALL SUBOPT_0x62
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 053C 			bBL=0;
_0x2B5:
	CBI  0x1E,7
; 0000 053D 			}
; 0000 053E 		else if(flags&0b00011010)					//если есть аварии
	RJMP _0x2B8
_0x2AF:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2B9
; 0000 053F 			{
; 0000 0540 			pwm_u=0;								//то полный стоп
	CALL SUBOPT_0x59
; 0000 0541 			pwm_i=0;
	CALL SUBOPT_0x5A
; 0000 0542 			bBL=1;
; 0000 0543 			}
; 0000 0544 		}
_0x2B9:
_0x2B8:
; 0000 0545 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
	RJMP _0x2BC
_0x2A7:
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x2BD
; 0000 0546 		{
; 0000 0547 		pwm_u=0;
	CALL SUBOPT_0x59
; 0000 0548 	    	pwm_i=0;
	CALL SUBOPT_0x5A
; 0000 0549 		bBL=1;
; 0000 054A 		}
; 0000 054B /*pwm_u=950;
; 0000 054C 		pwm_i=950;*/
; 0000 054D 	}
_0x2BD:
_0x2BC:
; 0000 054E //pwm_u=vol_u_temp;
; 0000 054F }
_0x2A6:
_0x2A5:
_0x296:
_0x290:
_0x28A:
_0x284:
	RET
; .FEND
;
;//-----------------------------------------------
;//Воздействие на силу
;//5Hz
;void pwr_drv(void)
; 0000 0555 {
_pwr_drv:
; .FSTART _pwr_drv
; 0000 0556 /*GPIOB->DDR|=(1<<2);
; 0000 0557 GPIOB->CR1|=(1<<2);
; 0000 0558 GPIOB->CR2&=~(1<<2);*/
; 0000 0559 BLOCK_INIT
	SBI  0xA,4
; 0000 055A 
; 0000 055B if(main_cnt1<1500)main_cnt1++;
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CPI  R26,LOW(0x5DC)
	LDI  R30,HIGH(0x5DC)
	CPC  R27,R30
	BRGE _0x2C2
	LDI  R26,LOW(_main_cnt1)
	LDI  R27,HIGH(_main_cnt1)
	CALL SUBOPT_0x25
; 0000 055C 
; 0000 055D if((main_cnt1<25)&&(ee_DEVICE))
_0x2C2:
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	SBIW R26,25
	BRGE _0x2C4
	CALL SUBOPT_0x21
	SBIW R30,0
	BRNE _0x2C5
_0x2C4:
	RJMP _0x2C3
_0x2C5:
; 0000 055E 	{
; 0000 055F 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3B0
; 0000 0560 	}
; 0000 0561 else if((ee_DEVICE))
_0x2C3:
	CALL SUBOPT_0x21
	SBIW R30,0
	BREQ _0x2C9
; 0000 0562 	{
; 0000 0563 	if(bBL)
	SBIS 0x1E,7
	RJMP _0x2CA
; 0000 0564 		{
; 0000 0565 		BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3B1
; 0000 0566 		}
; 0000 0567 	else if(!bBL)
_0x2CA:
	SBIC 0x1E,7
	RJMP _0x2CE
; 0000 0568 		{
; 0000 0569 		BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3B1:
	STS  _bVENT_BLOCK,R30
; 0000 056A 		}
; 0000 056B 	}
_0x2CE:
; 0000 056C else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
	RJMP _0x2D1
_0x2C9:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x2D3
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x2D4
_0x2D3:
	RJMP _0x2D2
_0x2D4:
; 0000 056D 	{
; 0000 056E 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3B0
; 0000 056F 	//GPIOB->ODR|=(1<<2);
; 0000 0570 	}
; 0000 0571 else if(bps_class==bpsIPS)
_0x2D2:
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x2D8
; 0000 0572 		{
; 0000 0573 //GPIOB->ODR|=(1<<2);
; 0000 0574 		if(bBL_IPS)
	IN   R30,0x2A
	SBRS R30,0
	RJMP _0x2D9
; 0000 0575 			{
; 0000 0576 			 BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3B2
; 0000 0577 			//GPIOB->ODR|=(1<<2);
; 0000 0578 			}
; 0000 0579 		else if(!bBL_IPS)
_0x2D9:
	IN   R30,0x2A
	SBRC R30,0
	RJMP _0x2DD
; 0000 057A 			{
; 0000 057B 			  BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3B2:
	STS  _bVENT_BLOCK,R30
; 0000 057C 			//GPIOB->ODR&=~(1<<2);
; 0000 057D 			}
; 0000 057E 		}
_0x2DD:
; 0000 057F else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
	RJMP _0x2E0
_0x2D8:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x36
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x2E2
	CALL SUBOPT_0x46
	BRLT _0x2E3
_0x2E2:
	RJMP _0x2E1
_0x2E3:
; 0000 0580 	{
; 0000 0581 	if(bps_class==bpsIPS)
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BREQ _0x3B3
; 0000 0582 		{
; 0000 0583 		  BLOCK_OFF
; 0000 0584 		//GPIOB->ODR&=~(1<<2);
; 0000 0585 		}
; 0000 0586 	else if(bps_class==bpsIBEP)
	LDS  R30,_bps_class
	CPI  R30,0
	BRNE _0x2E8
; 0000 0587 		{
; 0000 0588 		if(ee_DEVICE)
	CALL SUBOPT_0x21
	SBIW R30,0
	BREQ _0x2E9
; 0000 0589 			{
; 0000 058A 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x2EA
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3B4
; 0000 058B 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
_0x2EA:
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3B4:
	STS  _bVENT_BLOCK,R30
; 0000 058C 			}
; 0000 058D 		else
	RJMP _0x2F0
_0x2E9:
; 0000 058E 			{
; 0000 058F 			BLOCK_OFF
_0x3B3:
	CBI  0xB,4
	LDI  R30,LOW(0)
	STS  _bVENT_BLOCK,R30
; 0000 0590 			//GPIOB->ODR&=~(1<<2);
; 0000 0591 			}
_0x2F0:
; 0000 0592 		}
; 0000 0593 	}
_0x2E8:
; 0000 0594 else if(bBL)
	RJMP _0x2F3
_0x2E1:
	SBIS 0x1E,7
	RJMP _0x2F4
; 0000 0595 	{
; 0000 0596 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3B0
; 0000 0597 	//GPIOB->ODR|=(1<<2);
; 0000 0598 	}
; 0000 0599 else if(!bBL)
_0x2F4:
	SBIC 0x1E,7
	RJMP _0x2F8
; 0000 059A 	{
; 0000 059B 	BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3B0:
	STS  _bVENT_BLOCK,R30
; 0000 059C 	//GPIOB->ODR&=~(1<<2);
; 0000 059D 	}
; 0000 059E 
; 0000 059F //pwm_u=800;
; 0000 05A0 //pwm_u=400;
; 0000 05A1 
; 0000 05A2 gran(&pwm_u,10,1020);
_0x2F8:
_0x2F3:
_0x2E0:
_0x2D1:
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	CALL SUBOPT_0x63
; 0000 05A3 gran(&pwm_i,10,1020);
	LDI  R30,LOW(_pwm_i)
	LDI  R31,HIGH(_pwm_i)
	CALL SUBOPT_0x63
; 0000 05A4 
; 0000 05A5 if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
	CALL SUBOPT_0x21
	SBIW R30,0
	BRNE _0x2FC
	CALL SUBOPT_0x22
	ADIW R30,10
	CALL SUBOPT_0x36
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x2FD
_0x2FC:
	RJMP _0x2FB
_0x2FD:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x5C
; 0000 05A6 
; 0000 05A7 //pwm_u=1000;
; 0000 05A8 //pwm_i=1000;
; 0000 05A9 
; 0000 05AA //GPIOB->ODR|=(1<<3);
; 0000 05AB 
; 0000 05AC //pwm_u=100;
; 0000 05AD //pwm_i=400;
; 0000 05AE //vent_pwm=200;
; 0000 05AF 
; 0000 05B0 
; 0000 05B1 OCR1AH= (char)(pwm_u/256);
_0x2FB:
	LDS  R30,_pwm_u+1
	STS  137,R30
; 0000 05B2 OCR1AL= (char)pwm_u;
	LDS  R30,_pwm_u
	STS  136,R30
; 0000 05B3 
; 0000 05B4 OCR1BH= (char)(pwm_i/256);
	LDS  R30,_pwm_i+1
	STS  139,R30
; 0000 05B5 OCR1BL= (char)pwm_i;
	LDS  R30,_pwm_i
	STS  138,R30
; 0000 05B6 /*
; 0000 05B7 TIM1->CCR1H= (char)(pwm_i/256);
; 0000 05B8 TIM1->CCR1L= (char)pwm_i;
; 0000 05B9 
; 0000 05BA TIM1->CCR3H= (char)(vent_pwm/256);
; 0000 05BB TIM1->CCR3L= (char)vent_pwm;*/
; 0000 05BC 
; 0000 05BD //OCR1AL= 260;//pwm_u;
; 0000 05BE //OCR1B= 0;//pwm_i;
; 0000 05BF 
; 0000 05C0 OCR2B=(char)(vent_pwm/4);
	CALL SUBOPT_0x4B
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __DIVW21
	STS  180,R30
; 0000 05C1 
; 0000 05C2 }
	RET
; .FEND
;
;//-----------------------------------------------
;void pwr_hndl_(void)
; 0000 05C6 {
; 0000 05C7 //vol_u_temp=800;
; 0000 05C8 if(jp_mode==jp3)
; 0000 05C9 	{
; 0000 05CA 	if((flags&0b00001010)==0)
; 0000 05CB 		{
; 0000 05CC 		pwm_u=500;
; 0000 05CD 		//pwm_i=0x3ff;
; 0000 05CE 		bBL=0;
; 0000 05CF 		}
; 0000 05D0 	else if(flags&0b00001010)
; 0000 05D1 		{
; 0000 05D2 		pwm_u=0;
; 0000 05D3 		//pwm_i=0;
; 0000 05D4 		bBL=1;
; 0000 05D5 		}
; 0000 05D6 
; 0000 05D7 	}
; 0000 05D8 else if(jp_mode==jp2)
; 0000 05D9 	{
; 0000 05DA 	pwm_u=0;
; 0000 05DB 	//pwm_i=0x3ff;
; 0000 05DC 	bBL=0;
; 0000 05DD 	}
; 0000 05DE else if(jp_mode==jp1)
; 0000 05DF 	{
; 0000 05E0 	pwm_u=0x3ff;
; 0000 05E1 	//pwm_i=0x3ff;
; 0000 05E2 	bBL=0;
; 0000 05E3 	}
; 0000 05E4 
; 0000 05E5 else if(link==OFF)
; 0000 05E6 	{
; 0000 05E7 	if((flags&0b00011010)==0)
; 0000 05E8 		{
; 0000 05E9 		pwm_u=ee_U_AVT;
; 0000 05EA 		gran(&pwm_u,0,1020);
; 0000 05EB 	    //	pwm_i=0x3ff;
; 0000 05EC 		bBL=0;
; 0000 05ED 		}
; 0000 05EE 	else if(flags&0b00011010)
; 0000 05EF 		{
; 0000 05F0 		pwm_u=0;
; 0000 05F1 		//pwm_i=0;
; 0000 05F2 		bBL=1;
; 0000 05F3 		}
; 0000 05F4 	}
; 0000 05F5 
; 0000 05F6 else	if(link==ON)
; 0000 05F7 	{
; 0000 05F8 	if((flags&0b00100000)==0)
; 0000 05F9 		{
; 0000 05FA 		if(((flags&0b00011010)==0)||(flags&0b01000000))
; 0000 05FB 			{
; 0000 05FC 			pwm_u=vol_u_temp+_x_;
; 0000 05FD 		    //	pwm_i=0x3ff;
; 0000 05FE 			bBL=0;
; 0000 05FF 			}
; 0000 0600 		else if(flags&0b00011010)
; 0000 0601 			{
; 0000 0602 			pwm_u=0;
; 0000 0603 			//pwm_i=0;
; 0000 0604 			bBL=1;
; 0000 0605 			}
; 0000 0606 		}
; 0000 0607 	else if(flags&0b00100000)
; 0000 0608 		{
; 0000 0609 		pwm_u=0;
; 0000 060A 	    //	pwm_i=0;
; 0000 060B 		bBL=1;
; 0000 060C 		}
; 0000 060D 	}
; 0000 060E //pwm_u=vol_u_temp;
; 0000 060F }
;
;//-----------------------------------------------
;void JP_drv(void)
; 0000 0613 {
_JP_drv:
; .FSTART _JP_drv
; 0000 0614 
; 0000 0615 DDRB.6=1;
	SBI  0x4,6
; 0000 0616 DDRB.7=1;
	SBI  0x4,7
; 0000 0617 PORTB.6=1;
	SBI  0x5,6
; 0000 0618 PORTB.7=1;
	SBI  0x5,7
; 0000 0619 
; 0000 061A if(PINB.6)
	SBIS 0x3,6
	RJMP _0x32F
; 0000 061B 	{
; 0000 061C 	if(cnt_JP0<10)
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRSH _0x330
; 0000 061D 		{
; 0000 061E 		cnt_JP0++;
	LDS  R30,_cnt_JP0
	SUBI R30,-LOW(1)
	STS  _cnt_JP0,R30
; 0000 061F 		}
; 0000 0620 	}
_0x330:
; 0000 0621 else if(!PINB.6)
	RJMP _0x331
_0x32F:
	SBIC 0x3,6
	RJMP _0x332
; 0000 0622 	{
; 0000 0623 	if(cnt_JP0)
	LDS  R30,_cnt_JP0
	CPI  R30,0
	BREQ _0x333
; 0000 0624 		{
; 0000 0625 		cnt_JP0--;
	SUBI R30,LOW(1)
	STS  _cnt_JP0,R30
; 0000 0626 		}
; 0000 0627 	}
_0x333:
; 0000 0628 
; 0000 0629 if(PINB.7)
_0x332:
_0x331:
	SBIS 0x3,7
	RJMP _0x334
; 0000 062A 	{
; 0000 062B 	if(cnt_JP1<10)
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BRSH _0x335
; 0000 062C 		{
; 0000 062D 		cnt_JP1++;
	LDS  R30,_cnt_JP1
	SUBI R30,-LOW(1)
	STS  _cnt_JP1,R30
; 0000 062E 		}
; 0000 062F 	}
_0x335:
; 0000 0630 else if(!PINB.7)
	RJMP _0x336
_0x334:
	SBIC 0x3,7
	RJMP _0x337
; 0000 0631 	{
; 0000 0632 	if(cnt_JP1)
	LDS  R30,_cnt_JP1
	CPI  R30,0
	BREQ _0x338
; 0000 0633 		{
; 0000 0634 		cnt_JP1--;
	SUBI R30,LOW(1)
	STS  _cnt_JP1,R30
; 0000 0635 		}
; 0000 0636 	}
_0x338:
; 0000 0637 
; 0000 0638 
; 0000 0639 if((cnt_JP0==10)&&(cnt_JP1==10))
_0x337:
_0x336:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x33A
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x33B
_0x33A:
	RJMP _0x339
_0x33B:
; 0000 063A 	{
; 0000 063B 	jp_mode=jp0;
	LDI  R30,LOW(0)
	STS  _jp_mode,R30
; 0000 063C 	}
; 0000 063D if((cnt_JP0==0)&&(cnt_JP1==10))
_0x339:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x33D
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x33E
_0x33D:
	RJMP _0x33C
_0x33E:
; 0000 063E 	{
; 0000 063F 	jp_mode=jp1;
	LDI  R30,LOW(1)
	STS  _jp_mode,R30
; 0000 0640 	}
; 0000 0641 if((cnt_JP0==10)&&(cnt_JP1==0))
_0x33C:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x340
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x341
_0x340:
	RJMP _0x33F
_0x341:
; 0000 0642 	{
; 0000 0643 	jp_mode=jp2;
	LDI  R30,LOW(2)
	STS  _jp_mode,R30
; 0000 0644 	}
; 0000 0645 if((cnt_JP0==0)&&(cnt_JP1==0))
_0x33F:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x343
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x344
_0x343:
	RJMP _0x342
_0x344:
; 0000 0646 	{
; 0000 0647 	jp_mode=jp3;
	LDI  R30,LOW(3)
	STS  _jp_mode,R30
; 0000 0648 	}
; 0000 0649 
; 0000 064A }
_0x342:
	RET
; .FEND
;
;//-----------------------------------------------
;void adc_hndl(void)
; 0000 064E {
_adc_hndl:
; .FSTART _adc_hndl
; 0000 064F unsigned tempUI;
; 0000 0650 tempUI=ADCW;
	ST   -Y,R17
	ST   -Y,R16
;	tempUI -> R16,R17
	__GETWRMN 16,17,0,120
; 0000 0651 adc_buff[adc_ch][adc_cnt]=tempUI;
	CALL SUBOPT_0x64
	MOVW R26,R30
	LDS  R30,_adc_cnt
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R16
	STD  Z+1,R17
; 0000 0652 /*if(adc_ch==2)
; 0000 0653 	{
; 0000 0654 	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
; 0000 0655 	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
; 0000 0656 	}  */
; 0000 0657 
; 0000 0658 if((adc_cnt&0x03)==0)
	LDS  R30,_adc_cnt
	ANDI R30,LOW(0x3)
	BRNE _0x345
; 0000 0659 	{
; 0000 065A 	char i;
; 0000 065B 	adc_buff_[adc_ch]=0;
	SBIW R28,1
;	i -> Y+0
	CALL SUBOPT_0x65
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
; 0000 065C 	for(i=0;i<16;i++)
	ST   Y,R30
_0x347:
	LD   R26,Y
	CPI  R26,LOW(0x10)
	BRSH _0x348
; 0000 065D 		{
; 0000 065E 		adc_buff_[adc_ch]+=adc_buff[adc_ch][i];
	CALL SUBOPT_0x65
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	LD   R0,Z
	LDD  R1,Z+1
	CALL SUBOPT_0x64
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
; 0000 065F 		}
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RJMP _0x347
_0x348:
; 0000 0660 	adc_buff_[adc_ch]>>=4;
	CALL SUBOPT_0x65
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X+
	LD   R31,X+
	CALL __LSRW4
	ST   -X,R31
	ST   -X,R30
; 0000 0661     //adc_buff_[adc_ch]=(adc_ch+1)*100;
; 0000 0662 	}
	ADIW R28,1
; 0000 0663 
; 0000 0664 if(++adc_ch>=5)
_0x345:
	LDS  R26,_adc_ch
	SUBI R26,-LOW(1)
	STS  _adc_ch,R26
	CPI  R26,LOW(0x5)
	BRLO _0x349
; 0000 0665 	{
; 0000 0666 	adc_ch=0;
	LDI  R30,LOW(0)
	STS  _adc_ch,R30
; 0000 0667 	if(++adc_cnt>=16)
	LDS  R26,_adc_cnt
	SUBI R26,-LOW(1)
	STS  _adc_cnt,R26
	CPI  R26,LOW(0x10)
	BRLO _0x34A
; 0000 0668 		{
; 0000 0669 		adc_cnt=0;
	STS  _adc_cnt,R30
; 0000 066A 		}
; 0000 066B 	}
_0x34A:
; 0000 066C DDRC&=0b11000000;
_0x349:
	IN   R30,0x7
	ANDI R30,LOW(0xC0)
	OUT  0x7,R30
; 0000 066D PORTC&=0b11000000;
	IN   R30,0x8
	ANDI R30,LOW(0xC0)
	OUT  0x8,R30
; 0000 066E 
; 0000 066F if(adc_ch==0)       ADMUX=0b00000001; //ток
	LDS  R30,_adc_ch
	CPI  R30,0
	BRNE _0x34B
	LDI  R30,LOW(1)
	RJMP _0x3B5
; 0000 0670 else if(adc_ch==1)  ADMUX=0b00000100; //напр ист
_0x34B:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x1)
	BRNE _0x34D
	LDI  R30,LOW(4)
	RJMP _0x3B5
; 0000 0671 else if(adc_ch==2)  ADMUX=0b00000010; //напр нагр
_0x34D:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BRNE _0x34F
	LDI  R30,LOW(2)
	RJMP _0x3B5
; 0000 0672 else if(adc_ch==3)  ADMUX=0b00000011; //темпер
_0x34F:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x3)
	BRNE _0x351
	LDI  R30,LOW(3)
	RJMP _0x3B5
; 0000 0673 else if(adc_ch==4)  ADMUX=0b00000101; //доп
_0x351:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x4)
	BRNE _0x353
	LDI  R30,LOW(5)
_0x3B5:
	STS  124,R30
; 0000 0674 
; 0000 0675 
; 0000 0676 ADCSRA=0b10100110;
_0x353:
	LDI  R30,LOW(166)
	STS  122,R30
; 0000 0677 ADCSRA|=0b01000000;
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0678 
; 0000 0679 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;void matemat(void)
; 0000 067D {
_matemat:
; .FSTART _matemat
; 0000 067E signed long temp_SL;
; 0000 067F 
; 0000 0680 #ifdef _220_
; 0000 0681 temp_SL=adc_buff_[0];
	SBIW R28,4
;	temp_SL -> Y+0
	CALL SUBOPT_0x10
	CALL SUBOPT_0x66
; 0000 0682 temp_SL-=K[0][0];
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMRDW
	CALL SUBOPT_0x67
	CALL __SUBD21
	CALL __PUTD2S0
; 0000 0683 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x354
	CALL SUBOPT_0x68
; 0000 0684 temp_SL*=K[0][1];
_0x354:
	CALL SUBOPT_0x12
	CALL SUBOPT_0x67
	CALL SUBOPT_0x69
; 0000 0685 temp_SL/=2400;
	__GETD1N 0x960
	CALL SUBOPT_0x6A
; 0000 0686 I=(signed int)temp_SL;
	STS  _I,R30
	STS  _I+1,R31
; 0000 0687 #else
; 0000 0688 
; 0000 0689 #ifdef _24_
; 0000 068A temp_SL=adc_buff_[0];
; 0000 068B temp_SL-=K[0][0];
; 0000 068C if(temp_SL<0) temp_SL=0;
; 0000 068D temp_SL*=K[0][1];
; 0000 068E temp_SL/=800;
; 0000 068F I=(signed int)temp_SL;
; 0000 0690 #else
; 0000 0691 temp_SL=adc_buff_[0];
; 0000 0692 temp_SL-=K[0][0];
; 0000 0693 if(temp_SL<0) temp_SL=0;
; 0000 0694 temp_SL*=K[0][1];
; 0000 0695 temp_SL/=1200;
; 0000 0696 I=(signed int)temp_SL;
; 0000 0697 #endif
; 0000 0698 #endif
; 0000 0699 
; 0000 069A //I=adc_buff_[0];
; 0000 069B 
; 0000 069C temp_SL=adc_buff_[1];
	__GETW1MN _adc_buff_,2
	CALL SUBOPT_0x66
; 0000 069D //temp_SL-=K[1,0];
; 0000 069E if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x355
	CALL SUBOPT_0x68
; 0000 069F temp_SL*=K[2][1];
_0x355:
	CALL SUBOPT_0x17
	CALL SUBOPT_0x67
	CALL SUBOPT_0x69
; 0000 06A0 temp_SL/=1000;
	CALL SUBOPT_0x6B
; 0000 06A1 Ui=(unsigned)temp_SL;
	STS  _Ui,R30
	STS  _Ui+1,R31
; 0000 06A2 
; 0000 06A3 //Ui=K[2][1];
; 0000 06A4 
; 0000 06A5 
; 0000 06A6 temp_SL=adc_buff_[2];
	__GETW1MN _adc_buff_,4
	CALL SUBOPT_0x66
; 0000 06A7 //temp_SL-=K[2,0];
; 0000 06A8 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x356
	CALL SUBOPT_0x68
; 0000 06A9 temp_SL*=K[1][1];
_0x356:
	CALL SUBOPT_0x16
	CALL SUBOPT_0x67
	CALL SUBOPT_0x69
; 0000 06AA temp_SL/=1000;
	CALL SUBOPT_0x6B
; 0000 06AB Un=(unsigned)temp_SL;
	STS  _Un,R30
	STS  _Un+1,R31
; 0000 06AC //Un=K[1][1];
; 0000 06AD 
; 0000 06AE temp_SL=adc_buff_[3];
	__GETW1MN _adc_buff_,6
	CALL SUBOPT_0x66
; 0000 06AF temp_SL*=K[3][1];
	CALL SUBOPT_0x18
	CALL SUBOPT_0x67
	CALL SUBOPT_0x69
; 0000 06B0 temp_SL/=1326;
	__GETD1N 0x52E
	CALL SUBOPT_0x6A
; 0000 06B1 T=(signed)(temp_SL-273);
	SUBI R30,LOW(273)
	SBCI R31,HIGH(273)
	STS  _T,R30
	STS  _T+1,R31
; 0000 06B2 //T=TZAS;
; 0000 06B3 
; 0000 06B4 Udb=flags;
	LDS  R30,_flags
	LDI  R31,0
	STS  _Udb,R30
	STS  _Udb+1,R31
; 0000 06B5 
; 0000 06B6 
; 0000 06B7 
; 0000 06B8 }
	ADIW R28,4
	RET
; .FEND
;
;//***********************************************
;//***********************************************
;//***********************************************
;//***********************************************
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 06BF {
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
; 0000 06C0 //DDRD.0=1;
; 0000 06C1 //PORTD.0=1;
; 0000 06C2 
; 0000 06C3 //PORTD.1=0;
; 0000 06C4 
; 0000 06C5 t0_init();
	CALL _t0_init
; 0000 06C6 
; 0000 06C7 can_hndl1();
	CALL _can_hndl1
; 0000 06C8 
; 0000 06C9 if(++t0_cnt4>=10)
	INC  R11
	LDI  R30,LOW(10)
	CP   R11,R30
	BRLO _0x357
; 0000 06CA 	{
; 0000 06CB 	t0_cnt4=0;
	CLR  R11
; 0000 06CC //	b100Hz=1;
; 0000 06CD 
; 0000 06CE 
; 0000 06CF if(++t0_cnt0>=10)
	INC  R7
	CP   R7,R30
	BRLO _0x358
; 0000 06D0 	{
; 0000 06D1 	t0_cnt0=0;
	CLR  R7
; 0000 06D2 	b10Hz=1;
	SBI  0x1E,3
; 0000 06D3 	}
; 0000 06D4 if(++t0_cnt3>=3)
_0x358:
	INC  R8
	LDI  R30,LOW(3)
	CP   R8,R30
	BRLO _0x35B
; 0000 06D5 	{
; 0000 06D6 	t0_cnt3=0;
	CLR  R8
; 0000 06D7 	b33Hz=1;
	SBI  0x1E,2
; 0000 06D8 	}
; 0000 06D9 if(++t0_cnt1>=20)
_0x35B:
	INC  R6
	LDI  R30,LOW(20)
	CP   R6,R30
	BRLO _0x35E
; 0000 06DA 	{
; 0000 06DB 	t0_cnt1=0;
	CLR  R6
; 0000 06DC 	b5Hz=1;
	SBI  0x1E,4
; 0000 06DD      bFl_=!bFl_;
	SBIS 0x1E,6
	RJMP _0x361
	CBI  0x1E,6
	RJMP _0x362
_0x361:
	SBI  0x1E,6
_0x362:
; 0000 06DE 	}
; 0000 06DF if(++t0_cnt2>=100)
_0x35E:
	INC  R9
	LDI  R30,LOW(100)
	CP   R9,R30
	BRLO _0x363
; 0000 06E0 	{
; 0000 06E1 	t0_cnt2=0;
	CLR  R9
; 0000 06E2 	b1Hz=1;
	SBI  0x1E,5
; 0000 06E3 	}
; 0000 06E4 }
_0x363:
; 0000 06E5 }
_0x357:
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
; 0000 06ED {
_main:
; .FSTART _main
; 0000 06EE //DDRD.0=1;
; 0000 06EF //PORTD.0=0;
; 0000 06F0 //DDRD.1=1;
; 0000 06F1 //PORTD.1=1;
; 0000 06F2 
; 0000 06F3 //while (1)
; 0000 06F4 	//{
; 0000 06F5     //}
; 0000 06F6 
; 0000 06F7 ///DDRD.2=1;
; 0000 06F8 ///PORTD.2=1;
; 0000 06F9 
; 0000 06FA ///DDRB.0=1;
; 0000 06FB ///PORTB.0=0;
; 0000 06FC 
; 0000 06FD 	PORTB.2=1;
	SBI  0x5,2
; 0000 06FE 	DDRB.2=1;
	SBI  0x4,2
; 0000 06FF DDRB|=0b00110110;
	IN   R30,0x4
	ORI  R30,LOW(0x36)
	OUT  0x4,R30
; 0000 0700 
; 0000 0701 
; 0000 0702 
; 0000 0703 // Timer/Counter 1 initialization
; 0000 0704 // Clock source: System Clock
; 0000 0705 // Clock value: 8000.000 kHz
; 0000 0706 // Mode: Fast PWM top=0x03FF
; 0000 0707 // OC1A output: Non-Inverted PWM
; 0000 0708 // OC1B output: Non-Inverted PWM
; 0000 0709 // Noise Canceler: Off
; 0000 070A // Input Capture on Falling Edge
; 0000 070B // Timer Period: 0.128 ms
; 0000 070C // Output Pulse(s):
; 0000 070D // OC1A Period: 0.128 ms Width: 0.032031 ms
; 0000 070E // OC1B Period: 0.128 ms Width: 0.032031 ms
; 0000 070F // Timer1 Overflow Interrupt: Off
; 0000 0710 // Input Capture Interrupt: Off
; 0000 0711 // Compare A Match Interrupt: Off
; 0000 0712 // Compare B Match Interrupt: Off
; 0000 0713 TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (1<<WGM11) | (1<<WGM10);
	LDI  R30,LOW(163)
	STS  128,R30
; 0000 0714 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 0715 
; 0000 0716 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 0717 TCNT1L=0x00;
	STS  132,R30
; 0000 0718 ICR1H=0x00;
	STS  135,R30
; 0000 0719 ICR1L=0x00;
	STS  134,R30
; 0000 071A OCR1AH=0x01;
	LDI  R30,LOW(1)
	STS  137,R30
; 0000 071B OCR1AL=0x00;
	LDI  R30,LOW(0)
	STS  136,R30
; 0000 071C OCR1BH=0x03;
	LDI  R30,LOW(3)
	STS  139,R30
; 0000 071D OCR1BL=0x00;
	LDI  R30,LOW(0)
	STS  138,R30
; 0000 071E 
; 0000 071F DDRB.1=1;
	SBI  0x4,1
; 0000 0720 DDRB.2=1;
	SBI  0x4,2
; 0000 0721 
; 0000 0722 
; 0000 0723 // Timer/Counter 2 initialization
; 0000 0724 // Clock source: System Clock
; 0000 0725 // Clock value: 8000.000 kHz
; 0000 0726 // Mode: Fast PWM top=0xFF
; 0000 0727 // OC2A output: Disconnected
; 0000 0728 // OC2B output: Non-Inverted PWM
; 0000 0729 // Timer Period: 0.032 ms
; 0000 072A // Output Pulse(s):
; 0000 072B // OC2B Period: 0.032 ms Width: 6.0235 us
; 0000 072C ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 072D TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (1<<COM2B1) | (0<<COM2B0) | (1<<WGM21) | (1<<WGM20);
	LDI  R30,LOW(35)
	STS  176,R30
; 0000 072E TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (1<<CS20);
	LDI  R30,LOW(1)
	STS  177,R30
; 0000 072F TCNT2=0x00;
	LDI  R30,LOW(0)
	STS  178,R30
; 0000 0730 OCR2A=0x00;
	STS  179,R30
; 0000 0731 OCR2B=0x30;
	LDI  R30,LOW(48)
	STS  180,R30
; 0000 0732 
; 0000 0733 DDRD.3=1;
	SBI  0xA,3
; 0000 0734 
; 0000 0735 /*
; 0000 0736 
; 0000 0737 TCCR1A=0x83;
; 0000 0738 TCCR1B=0x09;
; 0000 0739 TCNT1H=0x00;
; 0000 073A TCNT1L=0x00;
; 0000 073B OCR1AH=0x00;
; 0000 073C OCR1AL=0x00;
; 0000 073D OCR1BH=0x00;
; 0000 073E OCR1BL=0x00;  */
; 0000 073F 
; 0000 0740 SPCR=0x5D;
	LDI  R30,LOW(93)
	OUT  0x2C,R30
; 0000 0741 SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 0742 /*delay_ms(100);
; 0000 0743 delay_ms(100);
; 0000 0744 delay_ms(100);
; 0000 0745 delay_ms(100);
; 0000 0746 delay_ms(100);
; 0000 0747 delay_ms(100);
; 0000 0748 delay_ms(100);
; 0000 0749 delay_ms(100);
; 0000 074A delay_ms(100);
; 0000 074B delay_ms(100);*/
; 0000 074C ///delay_ms(100);
; 0000 074D ///delay_ms(100);
; 0000 074E ///delay_ms(100);
; 0000 074F ///delay_ms(100);
; 0000 0750 ///delay_ms(100);
; 0000 0751 ///adr_hndl();
; 0000 0752 
; 0000 0753 ///if(adr==100)
; 0000 0754 ///	{
; 0000 0755 ///	adr_hndl();
; 0000 0756 ///	delay_ms(100);
; 0000 0757 ///	}
; 0000 0758 ///if(adr==100)
; 0000 0759 ///	{
; 0000 075A ///	adr_hndl();
; 0000 075B ///	delay_ms(100);
; 0000 075C ///	}
; 0000 075D //adr_drv_v3();
; 0000 075E 
; 0000 075F adr_hndl();
	CALL _adr_hndl
; 0000 0760 t0_init();
	CALL _t0_init
; 0000 0761 
; 0000 0762 
; 0000 0763 
; 0000 0764 link_cnt=0;
	CALL SUBOPT_0xD
; 0000 0765 link=ON;
; 0000 0766 /*
; 0000 0767 Umax=1000;
; 0000 0768 dU=100;
; 0000 0769 tmax=60;
; 0000 076A tsign=50;
; 0000 076B */
; 0000 076C main_cnt1=0;
	LDI  R30,LOW(0)
	STS  _main_cnt1,R30
	STS  _main_cnt1+1,R30
; 0000 076D //_x_ee_=20;
; 0000 076E _x_=_x_ee_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	STS  __x_,R30
	STS  __x_+1,R31
; 0000 076F 
; 0000 0770 if((_x_>XMAX)||(_x_<-XMAX))_x_=0;
	LDS  R26,__x_
	LDS  R27,__x_+1
	SBIW R26,26
	BRGE _0x371
	LDS  R26,__x_
	LDS  R27,__x_+1
	CPI  R26,LOW(0xFFE7)
	LDI  R30,HIGH(0xFFE7)
	CPC  R27,R30
	BRGE _0x370
_0x371:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
; 0000 0771 
; 0000 0772 if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;
_0x370:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	CPI  R30,0
	BRLO _0x374
	CPI  R30,LOW(0x4)
	BRLO _0x373
_0x374:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	LDI  R30,LOW(3)
	CALL __EEPROMWRB
; 0000 0773 
; 0000 0774 #asm("sei")
_0x373:
	sei
; 0000 0775 //granee(&K[0][1],420,1100);
; 0000 0776 
; 0000 0777 #ifdef _220_
; 0000 0778 //granee(&K[1][1],4500,5500);
; 0000 0779 //granee(&K[2][1],4500,5500);
; 0000 077A #else
; 0000 077B //granee(&K[1][1],1360,1700);
; 0000 077C //granee(&K[2][1],1360,1700);
; 0000 077D #endif
; 0000 077E 
; 0000 077F 
; 0000 0780 //K[1][1]=123;
; 0000 0781 //K[2][1]=456;
; 0000 0782 //granee(&K[1,1],1510,1850);
; 0000 0783 //granee(&K[2,1],1510,1850);
; 0000 0784 ///DDRD.2=1;
; 0000 0785 ///PORTD.2=0;
; 0000 0786 ///delay_ms(100);
; 0000 0787 ///PORTD.2=1;
; 0000 0788 can_init1();
	CALL _can_init1
; 0000 0789 
; 0000 078A //DDRD.1=1;
; 0000 078B //PORTD.1=0;
; 0000 078C DDRD.0=1;
	SBI  0xA,0
; 0000 078D while (1)
_0x378:
; 0000 078E 	{
; 0000 078F 
; 0000 0790     //delay_ms(100);
; 0000 0791 	if(bIN1)
	LDS  R30,_bIN1
	CPI  R30,0
	BREQ _0x37B
; 0000 0792 		{
; 0000 0793 		bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
; 0000 0794 
; 0000 0795 		can_in_an1();
	CALL _can_in_an1
; 0000 0796 		}
; 0000 0797 
; 0000 0798 /*	if(b100Hz)
; 0000 0799 		{
; 0000 079A 		b100Hz=0;
; 0000 079B 		}*/
; 0000 079C 	if(b33Hz)
_0x37B:
	SBIS 0x1E,2
	RJMP _0x37C
; 0000 079D 		{
; 0000 079E 		b33Hz=0;
	CBI  0x1E,2
; 0000 079F 
; 0000 07A0         adc_hndl();
	RCALL _adc_hndl
; 0000 07A1 		}
; 0000 07A2 	if(b10Hz)
_0x37C:
	SBIS 0x1E,3
	RJMP _0x37F
; 0000 07A3 		{
; 0000 07A4 		b10Hz=0;
	CBI  0x1E,3
; 0000 07A5 
; 0000 07A6 		matemat();
	RCALL _matemat
; 0000 07A7 		led_drv();
	CALL _led_drv
; 0000 07A8 	    link_drv();
	CALL _link_drv
; 0000 07A9 	    pwr_hndl();		//вычисление воздействий на силу
	RCALL _pwr_hndl
; 0000 07AA 	    JP_drv();
	RCALL _JP_drv
; 0000 07AB 	    flags_drv();
	CALL _flags_drv
; 0000 07AC 		net_drv();
	CALL _net_drv
; 0000 07AD 		}
; 0000 07AE 	if(b5Hz)
_0x37F:
	SBIS 0x1E,4
	RJMP _0x382
; 0000 07AF 		{
; 0000 07B0 		b5Hz=0;
	CBI  0x1E,4
; 0000 07B1 
; 0000 07B2         pwr_drv();
	RCALL _pwr_drv
; 0000 07B3  		led_hndl();
	CALL _led_hndl
; 0000 07B4         vent_drv();
	RCALL _vent_drv
; 0000 07B5 		}
; 0000 07B6     if(b1Hz)
_0x382:
	SBIS 0x1E,5
	RJMP _0x385
; 0000 07B7 		{
; 0000 07B8 		b1Hz=0;
	CBI  0x1E,5
; 0000 07B9 
; 0000 07BA         temper_drv();			//вычисление аварий температуры
	CALL _temper_drv
; 0000 07BB 		u_drv();
	CALL _u_drv
; 0000 07BC         x_drv();
	CALL _x_drv
; 0000 07BD 
; 0000 07BE         if(main_cnt<1000)main_cnt++;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0x388
	LDI  R26,LOW(_main_cnt)
	LDI  R27,HIGH(_main_cnt)
	CALL SUBOPT_0x25
; 0000 07BF   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
_0x388:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ _0x38A
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x389
_0x38A:
	CALL _apv_hndl
; 0000 07C0 
; 0000 07C1 		//Пересброс КАНа в случае зависания
; 0000 07C2   		can_error_cnt++;
_0x389:
	LDS  R30,_can_error_cnt
	SUBI R30,-LOW(1)
	STS  _can_error_cnt,R30
; 0000 07C3   		if(can_error_cnt>=10)
	LDS  R26,_can_error_cnt
	CPI  R26,LOW(0xA)
	BRLO _0x38C
; 0000 07C4   			{
; 0000 07C5   			can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
; 0000 07C6 			can_init1();;
	CALL _can_init1
; 0000 07C7   			}
; 0000 07C8 
; 0000 07C9 		volum_u_main_drv();
_0x38C:
	RCALL _volum_u_main_drv
; 0000 07CA 
; 0000 07CB 		//pwm_stat++;
; 0000 07CC 		//if(pwm_stat>=10)pwm_stat=0;
; 0000 07CD         //adc_plazma_short++;
; 0000 07CE 
; 0000 07CF 		vent_resurs_hndl();
	RCALL _vent_resurs_hndl
; 0000 07D0         }
; 0000 07D1      #asm("wdr")
_0x385:
	wdr
; 0000 07D2 	}
	RJMP _0x378
; 0000 07D3 }
_0x38D:
	RJMP _0x38D
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	LDI  R26,LOW(_ee_tmax)
	LDI  R27,HIGH(_ee_tmax)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x20:
	LDI  R26,LOW(_ee_tsign)
	LDI  R27,HIGH(_ee_tsign)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x21:
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x22:
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	MOVW R26,R30
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:75 WORDS
SUBOPT_0x24:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x25:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x26:
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
SUBOPT_0x27:
	LDS  R30,__x_
	LDS  R31,__x_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x28:
	STS  _led_red_buff,R30
	STS  _led_red_buff+1,R31
	STS  _led_red_buff+2,R22
	STS  _led_red_buff+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x29:
	STS  _led_green_buff,R30
	STS  _led_green_buff+1,R31
	STS  _led_green_buff+2,R22
	STS  _led_green_buff+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2A:
	STS  124,R30
	LDI  R30,LOW(166)
	STS  122,R30
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDS  R30,120
	LDS  R31,120+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	LDS  R26,_umin_cnt
	LDS  R27,_umin_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	LDS  R26,_umax_cnt
	LDS  R27,_umax_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2E:
	LDS  R26,_link_cnt
	LDS  R27,_link_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2F:
	LDS  R26,_T
	LDS  R27,_T+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x30:
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
SUBOPT_0x31:
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x32:
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
	RCALL SUBOPT_0x2D
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x33:
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
	RCALL SUBOPT_0x2C
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x34:
	__GETD1N 0x55555555
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES, CODE SIZE REDUCTION:129 WORDS
SUBOPT_0x35:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x36:
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:109 WORDS
SUBOPT_0x37:
	LDI  R30,LOW(0)
	STS  _led_red,R30
	STS  _led_red+1,R30
	STS  _led_red+2,R30
	STS  _led_red+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x38:
	__GETD1N 0x3030303
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x39:
	__GETD1N 0x55555
	RCALL SUBOPT_0x35
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3A:
	SUBI R30,LOW(-100)
	SBCI R31,HIGH(-100)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3B:
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3C:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3D:
	RCALL SUBOPT_0x34
	RCALL SUBOPT_0x35
	RJMP SUBOPT_0x3C

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3E:
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x3F:
	__GETD1N 0x10001
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:95 WORDS
SUBOPT_0x40:
	LDI  R30,LOW(0)
	STS  _led_green,R30
	STS  _led_green+1,R30
	STS  _led_green+2,R30
	STS  _led_green+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x41:
	__GETD1N 0x90009
	RCALL SUBOPT_0x35
	RJMP SUBOPT_0x40

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x42:
	__GETD1N 0x490049
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x43:
	RCALL SUBOPT_0x35
	RJMP SUBOPT_0x40

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x44:
	__GETD1N 0x33333333
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x45:
	__GETD1N 0xCCCCCCCC
	RJMP SUBOPT_0x43

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x46:
	SUBI R30,LOW(-70)
	SBCI R31,HIGH(-70)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x47:
	__GETD1N 0x5
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x48:
	CALL __DIVD21
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x49:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4A:
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	RJMP SUBOPT_0x19

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	LDS  R26,_vent_pwm
	LDS  R27,_vent_pwm+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4C:
	LDI  R26,LOW(_vent_resurs)
	LDI  R27,HIGH(_vent_resurs)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4D:
	LDI  R26,LOW(_UU_AVT)
	LDI  R27,HIGH(_UU_AVT)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4E:
	LDS  R26,_Un
	LDS  R27,_Un+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4F:
	LDS  R30,_volum_u_main_
	LDS  R31,_volum_u_main_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x50:
	STS  _volum_u_main_,R30
	STS  _volum_u_main_+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x51:
	LDS  R26,_Un
	LDS  R27,_Un+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x52:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_i_main_flag)
	SBCI R31,HIGH(-_i_main_flag)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x53:
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
SUBOPT_0x54:
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
SUBOPT_0x55:
	MOV  R30,R17
	LDI  R26,LOW(_x)
	LDI  R27,HIGH(_x)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x56:
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x57:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x58:
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x59:
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x5A:
	LDI  R30,LOW(0)
	STS  _pwm_i,R30
	STS  _pwm_i+1,R30
	SBI  0x1E,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5B:
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5C:
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5D:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1020)
	LDI  R27,HIGH(1020)
	JMP  _gran

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5E:
	RCALL SUBOPT_0x27
	LDS  R26,_vol_u_temp
	LDS  R27,_vol_u_temp+1
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x5C
	RJMP SUBOPT_0x21

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5F:
	LDS  R30,_vol_i_temp_avar
	LDS  R31,_vol_i_temp_avar+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x60:
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x61:
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	CALL __DIVW21U
	RCALL SUBOPT_0x60
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x62:
	LDS  R30,_vol_i_temp
	LDS  R31,_vol_i_temp+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x63:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RJMP SUBOPT_0x5D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x64:
	LDS  R30,_adc_ch
	LDI  R31,0
	LSL  R30
	ROL  R31
	CALL __LSLW4
	SUBI R30,LOW(-_adc_buff)
	SBCI R31,HIGH(-_adc_buff)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x65:
	LDS  R30,_adc_ch
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x66:
	CLR  R22
	CLR  R23
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x67:
	CALL __GETD2S0
	CALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x68:
	LDI  R30,LOW(0)
	CALL __CLRD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x69:
	CALL __MULD12
	CALL __PUTD1S0
	CALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x6A:
	CALL __DIVD21
	CALL __PUTD1S0
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6B:
	__GETD1N 0x3E8
	RJMP SUBOPT_0x6A


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
