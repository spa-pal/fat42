
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
_0x20003:
	.DB  0x15
_0x20004:
	.DB  0x9
_0x20005:
	.DB  0x8
_0x20006:
	.DB  0xE7,0x7
_0x20007:
	.DB  0xA
_0x20008:
	.DB  0xA
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
;#include "curr_version.h"
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
	RJMP _0x3C0
_0x3F:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x41
	LDI  R30,LOW(130)
	RJMP _0x3C0
_0x41:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x43
	LDI  R30,LOW(132)
_0x3C0:
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
; 0000 00BA {

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
;if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&((RXBUFF1[2]==GETTM) || (RXBUFF1[2]==GETTM1) || (RXBUFF1[2]==GETTM2)))
_0x57:
	CALL SUBOPT_0x8
	BRNE _0x5B
	CALL SUBOPT_0x9
	BRNE _0x5B
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xED)
	BREQ _0x5C
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEB)
	BREQ _0x5C
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEC)
	BRNE _0x5B
_0x5C:
	RJMP _0x5E
_0x5B:
	RJMP _0x5A
_0x5E:
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
	BREQ _0x5F
; 		{
; 		if(flags_tu_cnt_off<4)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRSH _0x60
; 			{
; 			flags_tu_cnt_off++;
	LDS  R30,_flags_tu_cnt_off
	SUBI R30,-LOW(1)
	STS  _flags_tu_cnt_off,R30
; 			if(flags_tu_cnt_off>=4)flags|=0b00100000;
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,LOW(0x4)
	BRLO _0x61
	LDS  R30,_flags
	ORI  R30,0x20
	STS  _flags,R30
; 			}
_0x61:
; 		else flags_tu_cnt_off=4;
	RJMP _0x62
_0x60:
	LDI  R30,LOW(4)
	STS  _flags_tu_cnt_off,R30
; 		}
_0x62:
; 	else
	RJMP _0x63
_0x5F:
; 		{
; 		if(flags_tu_cnt_off)
	LDS  R30,_flags_tu_cnt_off
	CPI  R30,0
	BREQ _0x64
; 			{
; 			flags_tu_cnt_off--;
	SUBI R30,LOW(1)
	STS  _flags_tu_cnt_off,R30
; 			if(flags_tu_cnt_off<=0)
	LDS  R26,_flags_tu_cnt_off
	CPI  R26,0
	BRNE _0x65
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
_0x65:
; 		else flags_tu_cnt_off=0;
	RJMP _0x66
_0x64:
	LDI  R30,LOW(0)
	STS  _flags_tu_cnt_off,R30
; 		}
_0x66:
_0x63:
;
; 	if(flags_tu&0b00000010) flags|=0b01000000;
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x2)
	BREQ _0x67
	LDS  R30,_flags
	ORI  R30,0x40
	RJMP _0x3C1
; 	else flags&=0b10111111;
_0x67:
	LDS  R30,_flags
	ANDI R30,0xBF
_0x3C1:
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
;	if(RXBUFF1[2]==GETTM)	can_transmit1(adress,PUTTM3,/**(((char*)&debug_info_to_uku[0])+1)*/0,/**((char*)&debug_info_to_uk ...
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xED)
	BRNE _0x69
	LDS  R30,_adress
	ST   -Y,R30
	LDI  R30,LOW(220)
	CALL SUBOPT_0xD
	LDI  R30,LOW(0)
	CALL SUBOPT_0xD
	LDI  R26,LOW(0)
	RCALL _can_transmit1
;	if(RXBUFF1[2]==GETTM1)	can_transmit1(adress,PUTTM31,*(((char*)&HARDVARE_VERSION)+1),*((char*)&HARDVARE_VERSION),*(((cha ...
_0x69:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEB)
	BRNE _0x6A
	LDS  R30,_adress
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
	RCALL _can_transmit1
;	if(RXBUFF1[2]==GETTM2)	can_transmit1(adress,PUTTM32,*(((char*)&BUILD_YEAR)+1),*((char*)&BUILD_YEAR),*(((char*)&BUILD_MO ...
_0x6A:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEC)
	BRNE _0x6B
	LDS  R30,_adress
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
	RCALL _can_transmit1
;
;     link_cnt=0;
_0x6B:
	CALL SUBOPT_0xE
;     link=ON;
;
;     if(flags_tu&0b10000000)
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BREQ _0x6C
;     	{
;     	if(!res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x6D
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
_0x6D:
;     else
	RJMP _0x6E
_0x6C:
;     	{
;     	if(main_cnt>20)
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	SBIW R26,21
	BRLT _0x6F
;     		{
;    			if(res_fl)
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	CALL __EEPROMRDB
	CPI  R30,0
	BREQ _0x70
;     			{
;     			res_fl=0;
	LDI  R26,LOW(_res_fl)
	LDI  R27,HIGH(_res_fl)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;     			}
;     		}
_0x70:
;     	}
_0x6F:
_0x6E:
;
;      if(res_fl_)
	CALL SUBOPT_0xF
	BREQ _0x71
;      	{
;      	res_fl_=0;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	LDI  R30,LOW(0)
	CALL __EEPROMWRB
;      	}
;	}
_0x71:
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==KLBR)&&(RXBUFF1[3]==RXBUFF1[4]))
	RJMP _0x72
_0x5A:
	CALL SUBOPT_0x8
	BRNE _0x74
	CALL SUBOPT_0x9
	BRNE _0x74
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0xEE)
	BRNE _0x74
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BREQ _0x75
_0x74:
	RJMP _0x73
_0x75:
;	{
;	rotor_int++;
	CALL SUBOPT_0x10
;	if((RXBUFF1[3]&0xf0)==0x20)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x20)
	BRNE _0x76
;		{
;		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x77
;			{
;			K[0][0]=adc_buff_[0];
	CALL SUBOPT_0x11
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x78
_0x77:
	CALL SUBOPT_0x12
	BRNE _0x79
;			{
;			K[0][1]++;
	CALL SUBOPT_0x13
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x7A
_0x79:
	CALL SUBOPT_0x14
	BRNE _0x7B
;			{
;			K[0][1]+=10;
	CALL SUBOPT_0x13
	ADIW R30,10
	RJMP _0x3C2
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x7B:
	CALL SUBOPT_0x15
	BRNE _0x7D
;			{
;			K[0][1]--;
	CALL SUBOPT_0x13
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x7E
_0x7D:
	CALL SUBOPT_0x16
	BRNE _0x7F
;			{
;			K[0][1]-=10;
	CALL SUBOPT_0x13
	SBIW R30,10
_0x3C2:
	__PUTW1EN _K,2
;			}
;		granee(&K[0][1],300,5000);
_0x7F:
_0x7E:
_0x7A:
_0x78:
	__POINTW1MN _K,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5000)
	LDI  R27,HIGH(5000)
	RJMP _0x3C3
;		}
;	else if((RXBUFF1[3]&0xf0)==0x10)
_0x76:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x10)
	BRNE _0x81
;		{
;		/*if((RXBUFF1[3]&0x0f)==0x01)
;			{
;			K[1][0]=adc_buff_[1];
;			}
;		else*/ if((RXBUFF1[3]&0x0f)==0x02)
	CALL SUBOPT_0x12
	BRNE _0x82
;			{
;			K[1][1]++;
	CALL SUBOPT_0x17
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x83
_0x82:
	CALL SUBOPT_0x14
	BRNE _0x84
;			{
;			K[1][1]+=10;
	CALL SUBOPT_0x17
	ADIW R30,10
	RJMP _0x3C4
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x84:
	CALL SUBOPT_0x15
	BRNE _0x86
;			{
;			K[1][1]--;
	CALL SUBOPT_0x17
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x87
_0x86:
	CALL SUBOPT_0x16
	BRNE _0x88
;			{
;			K[1][1]-=10;
	CALL SUBOPT_0x17
	SBIW R30,10
_0x3C4:
	__PUTW1EN _K,6
;			}
;		/*#ifdef _220_
;		granee(&K[1][1],4500,5500);
;		#else
;		granee(&K[1][1],1360,1700);
;		#endif*/
;		}
_0x88:
_0x87:
_0x83:
;
;	else if((RXBUFF1[3]&0xf0)==0x00)
	RJMP _0x89
_0x81:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	BRNE _0x8A
;		{
;		if((RXBUFF1[3]&0x0f)==0x01)
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BRNE _0x8B
;			{
;			K[2][0]=adc_buff_[0];
	__POINTW2MN _K,8
	CALL SUBOPT_0x11
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x02)
	RJMP _0x8C
_0x8B:
	CALL SUBOPT_0x12
	BRNE _0x8D
;			{
;			K[2][1]++;
	CALL SUBOPT_0x18
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x8E
_0x8D:
	CALL SUBOPT_0x14
	BRNE _0x8F
;			{
;			K[2][1]+=10;
	CALL SUBOPT_0x18
	ADIW R30,10
	RJMP _0x3C5
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x8F:
	CALL SUBOPT_0x15
	BRNE _0x91
;			{
;			K[2][1]--;
	CALL SUBOPT_0x18
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x92
_0x91:
	CALL SUBOPT_0x16
	BRNE _0x93
;			{
;			K[2][1]-=10;
	CALL SUBOPT_0x18
	SBIW R30,10
_0x3C5:
	__PUTW1EN _K,10
;			}
;		/*#ifdef _220_
;		granee(&K[2][1],4500,5500);
;		#else
;		granee(&K[2][1],1360,1700);
;		#endif	*/
;		}
_0x93:
_0x92:
_0x8E:
_0x8C:
;
;	else if((RXBUFF1[3]&0xf0)==0x30)
	RJMP _0x94
_0x8A:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF0)
	CPI  R30,LOW(0x30)
	BRNE _0x95
;		{
;		if((RXBUFF1[3]&0x0f)==0x02)
	CALL SUBOPT_0x12
	BRNE _0x96
;			{
;			K[3][1]++;
	CALL SUBOPT_0x19
	ADIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x03)
	RJMP _0x97
_0x96:
	CALL SUBOPT_0x14
	BRNE _0x98
;			{
;			K[3][1]+=10;
	CALL SUBOPT_0x19
	ADIW R30,10
	RJMP _0x3C6
;			}
;		else if((RXBUFF1[3]&0x0f)==0x04)
_0x98:
	CALL SUBOPT_0x15
	BRNE _0x9A
;			{
;			K[3][1]--;
	CALL SUBOPT_0x19
	SBIW R30,1
	CALL __EEPROMWRW
;			}
;		else if((RXBUFF1[3]&0x0f)==0x05)
	RJMP _0x9B
_0x9A:
	CALL SUBOPT_0x16
	BRNE _0x9C
;			{
;			K[3][1]-=10;
	CALL SUBOPT_0x19
	SBIW R30,10
_0x3C6:
	__PUTW1EN _K,14
;			}
;		granee(&K[3][1],/*480*/200,/*497*/1000);
_0x9C:
_0x9B:
_0x97:
	__POINTW1MN _K,14
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL SUBOPT_0x1A
_0x3C3:
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
_0x95:
_0x94:
_0x89:
	CALL SUBOPT_0xE
;     link=ON;
;     if(res_fl_)
	CALL SUBOPT_0xF
	BREQ _0x9D
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
_0x9D:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==MEM_KF))
	RJMP _0x9E
_0x73:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xA0
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xA0
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x62)
	BREQ _0xA1
_0xA0:
	RJMP _0x9F
_0xA1:
;	{
;	//rotor_int++;
;	if(ee_Umax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_Umax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	CALL SUBOPT_0x1B
	MOVW R22,R30
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xA2
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	LDI  R26,LOW(_ee_Umax)
	LDI  R27,HIGH(_ee_Umax)
	CALL __EEPROMWRW
;	if(ee_dU!=(RXBUFF1[5]+(RXBUFF1[6]*256))) ee_dU=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0xA2:
	LDI  R26,LOW(_ee_dU)
	LDI  R27,HIGH(_ee_dU)
	CALL __EEPROMRDW
	MOVW R22,R30
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xA3
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	LDI  R26,LOW(_ee_dU)
	LDI  R27,HIGH(_ee_dU)
	CALL __EEPROMWRW
;
;    if((RXBUFF1[7]&0x0f)==0x05)
_0xA3:
	__GETB1MN _RXBUFF1,7
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	BRNE _0xA4
;		{
;		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0xA5
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	LDI  R30,LOW(85)
	LDI  R31,HIGH(85)
	CALL __EEPROMWRW
;		}
_0xA5:
;	else if((RXBUFF1[7]&0x0f)==0x0a)
	RJMP _0xA6
_0xA4:
	__GETB1MN _RXBUFF1,7
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0xA)
	BRNE _0xA7
;        {
;        if(ee_AVT_MODE!=0)ee_AVT_MODE=0;
	CALL SUBOPT_0x20
	SBIW R30,0
	BREQ _0xA8
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	CALL SUBOPT_0x21
;        }
_0xA8:
;	}
_0xA7:
_0xA6:
;
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&((RXBUFF1[2]==MEM_KF1)||(RXBUFF1[2]==MEM_KF4)))
	RJMP _0xA9
_0x9F:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xAB
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xAB
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BREQ _0xAC
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x29)
	BRNE _0xAB
_0xAC:
	RJMP _0xAE
_0xAB:
	RJMP _0xAA
_0xAE:
;	{
;	if(ee_tmax!=(RXBUFF1[3]+(RXBUFF1[4]*256))) ee_tmax=(RXBUFF1[3]+(RXBUFF1[4]*256));
	CALL SUBOPT_0x22
	MOVW R22,R30
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xAF
	CALL SUBOPT_0x1C
	CALL SUBOPT_0x1D
	LDI  R26,LOW(_ee_tmax)
	LDI  R27,HIGH(_ee_tmax)
	CALL __EEPROMWRW
;	if(ee_tsign!=(RXBUFF1[5]+(RXBUFF1[5]*256))) ee_tsign=(RXBUFF1[5]+(RXBUFF1[6]*256));
_0xAF:
	CALL SUBOPT_0x23
	MOVW R22,R30
	CALL SUBOPT_0xA
	CALL SUBOPT_0x1F
	CP   R30,R22
	CPC  R31,R23
	BREQ _0xB0
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	LDI  R26,LOW(_ee_tsign)
	LDI  R27,HIGH(_ee_tsign)
	CALL __EEPROMWRW
;	//if(TZAS!=RXBUFF1[7]) TZAS=RXBUFF1[7];
;
;	if(RXBUFF1[2]==MEM_KF1)
_0xB0:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x26)
	BRNE _0xB1
;		{
;		if(ee_DEVICE!=0)ee_DEVICE=0;
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0xB2
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	CALL SUBOPT_0x21
;		if(ee_TZAS!=(signed short)RXBUFF1[7]) ee_TZAS=(signed short)RXBUFF1[7];
_0xB2:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x26
	BREQ _0xB3
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	CALL __EEPROMWRW
;		}
_0xB3:
;	if(RXBUFF1[2]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, ко ...
_0xB1:
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x29)
	BRNE _0xB4
;		{
;		if(ee_DEVICE!=1)ee_DEVICE=1;
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ _0xB5
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __EEPROMWRW
;		if(ee_IMAXVENT!=(signed short)RXBUFF1[7]) ee_IMAXVENT=(signed short)RXBUFF1[7];
_0xB5:
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMRDW
	CALL SUBOPT_0x26
	BREQ _0xB6
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMWRW
;			if(ee_TZAS!=3) ee_TZAS=3;
_0xB6:
	CALL SUBOPT_0x25
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ _0xB7
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL __EEPROMWRW
;		}
_0xB7:
;
;	}
_0xB4:
;
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==ALRM_RES))
	RJMP _0xB8
_0xAA:
	CALL SUBOPT_0x8
	BRNE _0xBA
	CALL SUBOPT_0x9
	BRNE _0xBA
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xBA
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x63)
	BREQ _0xBB
_0xBA:
	RJMP _0xB9
_0xBB:
;	{
;	flags&=0b11100001;
	CALL SUBOPT_0x27
;	tsign_cnt=0;
;	tmax_cnt=0;
;	umax_cnt=0;
;	umin_cnt=0;
;	led_drv_cnt=30;
;	}
;else if((RXBUFF1[0]==adress)&&(RXBUFF1[1]==adress)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==VENT_RES))
	RJMP _0xBC
_0xB9:
	CALL SUBOPT_0x8
	BRNE _0xBE
	CALL SUBOPT_0x9
	BRNE _0xBE
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xBE
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x64)
	BREQ _0xBF
_0xBE:
	RJMP _0xBD
_0xBF:
;	{
;	vent_resurs=0;
	LDI  R26,LOW(_vent_resurs)
	LDI  R27,HIGH(_vent_resurs)
	CALL SUBOPT_0x21
;	}
;else if((RXBUFF1[0]==0xff)&&(RXBUFF1[1]==0xff)&&(RXBUFF1[2]==CMND)&&(RXBUFF1[3]==CMND))
	RJMP _0xC0
_0xBD:
	LDS  R26,_RXBUFF1
	CPI  R26,LOW(0xFF)
	BRNE _0xC2
	__GETB2MN _RXBUFF1,1
	CPI  R26,LOW(0xFF)
	BRNE _0xC2
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xC2
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0x16)
	BREQ _0xC3
_0xC2:
	RJMP _0xC1
_0xC3:
;	{
;	if((RXBUFF1[4]==0x55)&&(RXBUFF1[5]==0x55)) _x_++;
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x55)
	BRNE _0xC5
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x55)
	BREQ _0xC6
_0xC5:
	RJMP _0xC4
_0xC6:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	CALL SUBOPT_0x28
;	else if((RXBUFF1[4]==0x66)&&(RXBUFF1[5]==0x66)) _x_--;
	RJMP _0xC7
_0xC4:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x66)
	BRNE _0xC9
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x66)
	BREQ _0xCA
_0xC9:
	RJMP _0xC8
_0xCA:
	LDI  R26,LOW(__x_)
	LDI  R27,HIGH(__x_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
;	else if((RXBUFF1[4]==0x77)&&(RXBUFF1[5]==0x77)) _x_=0;
	RJMP _0xCB
_0xC8:
	__GETB2MN _RXBUFF1,4
	CPI  R26,LOW(0x77)
	BRNE _0xCD
	__GETB2MN _RXBUFF1,5
	CPI  R26,LOW(0x77)
	BREQ _0xCE
_0xCD:
	RJMP _0xCC
_0xCE:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
;     gran(&_x_,-XMAX,XMAX);
_0xCC:
_0xCB:
_0xC7:
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
	RJMP _0xCF
_0xC1:
	CALL SUBOPT_0x8
	BRNE _0xD1
	CALL SUBOPT_0x9
	BRNE _0xD1
	__GETB2MN _RXBUFF1,2
	CPI  R26,LOW(0x16)
	BRNE _0xD1
	__GETB2MN _RXBUFF1,3
	__GETB1MN _RXBUFF1,4
	CP   R30,R26
	BRNE _0xD1
	__GETB2MN _RXBUFF1,3
	CPI  R26,LOW(0xEE)
	BREQ _0xD2
_0xD1:
	RJMP _0xD0
_0xD2:
;	{
;	rotor_int++;
	CALL SUBOPT_0x10
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
	CALL SUBOPT_0x29
	CP   R20,R30
	CPC  R21,R31
	BRNE _0xD3
	LDS  R30,_adress
	ST   -Y,R30
	LDI  R30,LOW(145)
	ST   -Y,R30
	LDI  R30,LOW(221)
	ST   -Y,R30
	CALL SUBOPT_0xD
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _can_transmit1
;
;	}
_0xD3:
;
;
;
;
;
;can_in_an1_end:
_0xD0:
_0xCF:
_0xC0:
_0xBC:
_0xB8:
_0xA9:
_0x9E:
_0x72:
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
	RJMP _0xD5
;	{
;	if(++cnt_net_drv>=7) cnt_net_drv=0;
	LDS  R26,_cnt_net_drv
	SUBI R26,-LOW(1)
	STS  _cnt_net_drv,R26
	CPI  R26,LOW(0x7)
	BRLO _0xD6
	LDI  R30,LOW(0)
	STS  _cnt_net_drv,R30
;
;	if(cnt_net_drv<=5)
_0xD6:
	LDS  R26,_cnt_net_drv
	CPI  R26,LOW(0x6)
	BRSH _0xD7
;		{
;		can_transmit1(cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv ...
	LDS  R30,_cnt_net_drv
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(237)
	ST   -Y,R30
	LDI  R30,LOW(0)
	CALL SUBOPT_0x2A
	LD   R30,X
	LDS  R26,_volum_u_main_
	ADD  R30,R26
	CALL SUBOPT_0x2A
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
	BRLO _0xD8
	LDS  R30,_cnt_net_drv
	LDI  R31,0
	SUBI R30,LOW(-_i_main_flag)
	SBCI R31,HIGH(-_i_main_flag)
	LDI  R26,LOW(0)
	STD  Z+0,R26
;		}
_0xD8:
;	else if(cnt_net_drv==6)
	RJMP _0xD9
_0xD7:
	LDS  R26,_cnt_net_drv
	CPI  R26,LOW(0x6)
	BRNE _0xDA
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
_0xDA:
_0xD9:
;}
_0xD5:
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
; 0000 00BE {
_t0_init:
; .FSTART _t0_init
; 0000 00BF TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 00C0 TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 00C1 TCNT0=-8;
	LDI  R30,LOW(248)
	OUT  0x26,R30
; 0000 00C2 TIMSK0=0x01;
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 00C3 }
	RET
; .FEND
;
;//-----------------------------------------------
;char adr_gran(signed short in)
; 0000 00C7 {
; 0000 00C8 if(in>800)return 1;
;	in -> Y+0
; 0000 00C9 else if((in>80)&&(in<120))return 0;
; 0000 00CA else return 100;
; 0000 00CB }
;
;
;//-----------------------------------------------
;void gran(signed int *adr, signed int min, signed int max)
; 0000 00D0 {
_gran:
; .FSTART _gran
; 0000 00D1 if (*adr<min) *adr=min;
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
	BRGE _0xE1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 00D2 if (*adr>max) *adr=max;
_0xE1:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xE2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
; 0000 00D3 }
_0xE2:
	RJMP _0x20C0002
; .FEND
;
;
;//-----------------------------------------------
;void granee(eeprom signed int *adr, signed int min, signed int max)
; 0000 00D8 {
_granee:
; .FSTART _granee
; 0000 00D9 if (*adr<min) *adr=min;
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
	BRGE _0xE3
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00DA if (*adr>max) *adr=max;
_0xE3:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xE4
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
; 0000 00DB }
_0xE4:
_0x20C0002:
	ADIW R28,6
	RET
; .FEND
;
;//-----------------------------------------------
;void x_drv(void)
; 0000 00DF {
_x_drv:
; .FSTART _x_drv
; 0000 00E0 if(_x__==_x_)
	CALL SUBOPT_0x2B
	LDS  R26,__x__
	LDS  R27,__x__+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0xE5
; 0000 00E1 	{
; 0000 00E2 	if(_x_cnt<60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,60
	BRGE _0xE6
; 0000 00E3 		{
; 0000 00E4 		_x_cnt++;
	LDI  R26,LOW(__x_cnt)
	LDI  R27,HIGH(__x_cnt)
	CALL SUBOPT_0x28
; 0000 00E5 		if(_x_cnt>=60)
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,60
	BRLT _0xE7
; 0000 00E6 			{
; 0000 00E7 			if(_x_ee_!=_x_)_x_ee_=_x_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	MOVW R26,R30
	CALL SUBOPT_0x2B
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xE8
	CALL SUBOPT_0x2B
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMWRW
; 0000 00E8 			}
_0xE8:
; 0000 00E9 		}
_0xE7:
; 0000 00EA 
; 0000 00EB 	}
_0xE6:
; 0000 00EC else _x_cnt=0;
	RJMP _0xE9
_0xE5:
	LDI  R30,LOW(0)
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
; 0000 00ED 
; 0000 00EE if(_x_cnt>60) _x_cnt=0;
_0xE9:
	LDS  R26,__x_cnt
	LDS  R27,__x_cnt+1
	SBIW R26,61
	BRLT _0xEA
	LDI  R30,LOW(0)
	STS  __x_cnt,R30
	STS  __x_cnt+1,R30
; 0000 00EF 
; 0000 00F0 _x__=_x_;
_0xEA:
	CALL SUBOPT_0x2B
	STS  __x__,R30
	STS  __x__+1,R31
; 0000 00F1 }
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_start(void)
; 0000 00F5 {
_apv_start:
; .FSTART _apv_start
; 0000 00F6 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
	LDS  R26,_apv_cnt
	CPI  R26,LOW(0x0)
	BRNE _0xEC
	__GETB2MN _apv_cnt,1
	CPI  R26,LOW(0x0)
	BRNE _0xEC
	__GETB2MN _apv_cnt,2
	CPI  R26,LOW(0x0)
	BRNE _0xEC
	LDS  R30,_bAPV
	CPI  R30,0
	BREQ _0xED
_0xEC:
	RJMP _0xEB
_0xED:
; 0000 00F7 	{
; 0000 00F8 	apv_cnt[0]=60;
	LDI  R30,LOW(60)
	STS  _apv_cnt,R30
; 0000 00F9 	apv_cnt[1]=60;
	__PUTB1MN _apv_cnt,1
; 0000 00FA 	apv_cnt[2]=60;
	__PUTB1MN _apv_cnt,2
; 0000 00FB 	apv_cnt_=3600;
	LDI  R30,LOW(3600)
	LDI  R31,HIGH(3600)
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R31
; 0000 00FC 	bAPV=1;
	LDI  R30,LOW(1)
	STS  _bAPV,R30
; 0000 00FD 	}
; 0000 00FE }
_0xEB:
	RET
; .FEND
;
;//-----------------------------------------------
;void apv_stop(void)
; 0000 0102 {
_apv_stop:
; .FSTART _apv_stop
; 0000 0103 apv_cnt[0]=0;
	LDI  R30,LOW(0)
	STS  _apv_cnt,R30
; 0000 0104 apv_cnt[1]=0;
	__PUTB1MN _apv_cnt,1
; 0000 0105 apv_cnt[2]=0;
	__PUTB1MN _apv_cnt,2
; 0000 0106 apv_cnt_=0;
	STS  _apv_cnt_,R30
	STS  _apv_cnt_+1,R30
; 0000 0107 bAPV=0;
	STS  _bAPV,R30
; 0000 0108 }
	RET
; .FEND
;
;
;//-----------------------------------------------
;void av_wrk_drv(void)
; 0000 010D {
; 0000 010E adc_ch_2_delta=(char)(adc_ch_2_max-adc_ch_2_min);
; 0000 010F adc_ch_2_max=adc_buff_[2];
; 0000 0110 adc_ch_2_min=adc_buff_[2];
; 0000 0111 if(PORTD.7==0)
; 0000 0112 	{
; 0000 0113 	if(adc_ch_2_delta>=5)
; 0000 0114 		{
; 0000 0115 		cnt_adc_ch_2_delta++;
; 0000 0116 		if(cnt_adc_ch_2_delta>=10)
; 0000 0117 			{
; 0000 0118 			flags|=0x10;
; 0000 0119 			apv_start();
; 0000 011A 			}
; 0000 011B 		}
; 0000 011C 	else
; 0000 011D 		{
; 0000 011E 		cnt_adc_ch_2_delta=0;
; 0000 011F 		}
; 0000 0120 	}
; 0000 0121 else cnt_adc_ch_2_delta=0;
; 0000 0122 }
;
;//-----------------------------------------------
;void led_drv_1(void)
; 0000 0126 {
; 0000 0127 DDRD.1=1;
; 0000 0128 if(led_green_buff&0b1L) PORTD.1=1;
; 0000 0129 else PORTD.1=0;
; 0000 012A DDRD.0=1;
; 0000 012B if(led_red_buff&0b1L) PORTD.0=1;
; 0000 012C else PORTD.0=0;
; 0000 012D 
; 0000 012E 
; 0000 012F led_red_buff>>=1;
; 0000 0130 led_green_buff>>=1;
; 0000 0131 if(++led_drv_cnt>32)
; 0000 0132 	{
; 0000 0133 	led_drv_cnt=0;
; 0000 0134 	led_red_buff=led_red;
; 0000 0135 	led_green_buff=led_green;
; 0000 0136 	}
; 0000 0137 
; 0000 0138 }
;
;//-----------------------------------------------
;void led_drv(void)
; 0000 013C {
_led_drv:
; .FSTART _led_drv
; 0000 013D //Красный светодиод
; 0000 013E DDRD.0=1;
	SBI  0xA,0
; 0000 013F if(led_red_buff&0b1L)   PORTD.0=1; 	//Горит если в led_red_buff 1 и на ножке 1
	LDS  R30,_led_red_buff
	ANDI R30,LOW(0x1)
	BREQ _0x106
	SBI  0xB,0
; 0000 0140 else                    PORTD.0=0;
	RJMP _0x109
_0x106:
	CBI  0xB,0
; 0000 0141 
; 0000 0142 //Зеленый светодиод
; 0000 0143 DDRD.1=1;
_0x109:
	SBI  0xA,1
; 0000 0144 if(led_green_buff&0b1L) PORTD.1=1;	//Горит если в led_green_buff 1 и на ножке 1
	LDS  R30,_led_green_buff
	ANDI R30,LOW(0x1)
	BREQ _0x10E
	SBI  0xB,1
; 0000 0145 else                    PORTD.1=0;
	RJMP _0x111
_0x10E:
	CBI  0xB,1
; 0000 0146 
; 0000 0147 
; 0000 0148 led_red_buff>>=1;
_0x111:
	LDS  R30,_led_red_buff
	LDS  R31,_led_red_buff+1
	LDS  R22,_led_red_buff+2
	LDS  R23,_led_red_buff+3
	CALL __ASRD1
	CALL SUBOPT_0x2C
; 0000 0149 led_green_buff>>=1;
	LDS  R30,_led_green_buff
	LDS  R31,_led_green_buff+1
	LDS  R22,_led_green_buff+2
	LDS  R23,_led_green_buff+3
	CALL __ASRD1
	CALL SUBOPT_0x2D
; 0000 014A if(++led_drv_cnt>32)
	LDS  R26,_led_drv_cnt
	SUBI R26,-LOW(1)
	STS  _led_drv_cnt,R26
	CPI  R26,LOW(0x21)
	BRLO _0x114
; 0000 014B 	{
; 0000 014C 	led_drv_cnt=0;
	LDI  R30,LOW(0)
	STS  _led_drv_cnt,R30
; 0000 014D 	led_red_buff=led_red;
	LDS  R30,_led_red
	LDS  R31,_led_red+1
	LDS  R22,_led_red+2
	LDS  R23,_led_red+3
	CALL SUBOPT_0x2C
; 0000 014E 	led_green_buff=led_green;
	LDS  R30,_led_green
	LDS  R31,_led_green+1
	LDS  R22,_led_green+2
	LDS  R23,_led_green+3
	CALL SUBOPT_0x2D
; 0000 014F 	}
; 0000 0150 
; 0000 0151 }
_0x114:
	RET
; .FEND
;
;//-----------------------------------------------
;void flags_drv(void)
; 0000 0155 {
_flags_drv:
; .FSTART _flags_drv
; 0000 0156 static char flags_old;
; 0000 0157 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0x115
; 0000 0158 	{
; 0000 0159 	if(((flags&0b00001000)&&(!(flags_old&0b00001000)))||((flags&0b00010000)&&(!(flags_old&0b00010000))&&(ee_AVT_MODE!=0x55) ...
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x117
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x8)
	BREQ _0x119
_0x117:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x11A
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x10)
	BRNE _0x11A
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BRNE _0x119
_0x11A:
	RJMP _0x116
_0x119:
; 0000 015A     		{
; 0000 015B     		if(link==OFF)apv_start();
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x11D
	RCALL _apv_start
; 0000 015C     		}
_0x11D:
; 0000 015D      }
_0x116:
; 0000 015E else if(jp_mode==jp3)
	RJMP _0x11E
_0x115:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x11F
; 0000 015F 	{
; 0000 0160 	if((flags&0b00001000)&&(!(flags_old&0b00001000)))
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x121
	LDS  R30,_flags_old_S000001B000
	ANDI R30,LOW(0x8)
	BREQ _0x122
_0x121:
	RJMP _0x120
_0x122:
; 0000 0161     		{
; 0000 0162     		apv_start();
	RCALL _apv_start
; 0000 0163     		}
; 0000 0164      }
_0x120:
; 0000 0165 flags_old=flags;
_0x11F:
_0x11E:
	LDS  R30,_flags
	STS  _flags_old_S000001B000,R30
; 0000 0166 
; 0000 0167 }
	RET
; .FEND
;
;//-----------------------------------------------
;void adr_hndl(void)
; 0000 016B {
_adr_hndl:
; .FSTART _adr_hndl
; 0000 016C #define ADR_CONST_0	574
; 0000 016D #define ADR_CONST_1	897
; 0000 016E #define ADR_CONST_2	695
; 0000 016F #define ADR_CONST_3	1015
; 0000 0170 
; 0000 0171 signed tempSI;
; 0000 0172 short aaa[3];
; 0000 0173 char aaaa[3];
; 0000 0174 DDRC=0b00000000;
	SBIW R28,9
	ST   -Y,R17
	ST   -Y,R16
;	tempSI -> R16,R17
;	aaa -> Y+5
;	aaaa -> Y+2
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0000 0175 PORTC=0b00000000;
	OUT  0x8,R30
; 0000 0176 /*char i;
; 0000 0177 DDRD&=0b11100011;
; 0000 0178 PORTD|=0b00011100;
; 0000 0179 
; 0000 017A //adr_new=((char)(!PIND.2))+(((char)(!PIND.3))*2)+((char)(!PIND.4)*4);
; 0000 017B 
; 0000 017C 
; 0000 017D adr_new=(PIND&0b00011100)>>2;
; 0000 017E 
; 0000 017F if(adr_new==adr_old)
; 0000 0180  	{
; 0000 0181  	if(adr_cnt<100)
; 0000 0182  		{
; 0000 0183  		adr_cnt++;
; 0000 0184  	     if(adr_cnt>=100)
; 0000 0185  	     	{
; 0000 0186  	     	adr_temp=adr_new;
; 0000 0187  	     	}
; 0000 0188  	     }
; 0000 0189    	}
; 0000 018A else adr_cnt=0;
; 0000 018B adr_old=adr_new;
; 0000 018C if(adr!=CONST_ADR[adr_temp]) adr=CONST_ADR[adr_temp];
; 0000 018D 
; 0000 018E 
; 0000 018F //if(adr!=0b00000011)adr=0b00000011;*/
; 0000 0190 
; 0000 0191 
; 0000 0192 
; 0000 0193 ADMUX=0b00000110;
	LDI  R30,LOW(6)
	CALL SUBOPT_0x2E
; 0000 0194 ADCSRA=0b10100110;
; 0000 0195 ADCSRA|=0b01000000;
; 0000 0196 delay_ms(10);
; 0000 0197 aaa[0]=ADCW;
	CALL SUBOPT_0x2F
	STD  Y+5,R30
	STD  Y+5+1,R31
; 0000 0198 
; 0000 0199 
; 0000 019A ADMUX=0b00000111;
	LDI  R30,LOW(7)
	CALL SUBOPT_0x2E
; 0000 019B ADCSRA=0b10100110;
; 0000 019C ADCSRA|=0b01000000;
; 0000 019D delay_ms(10);
; 0000 019E aaa[1]=ADCW;
	CALL SUBOPT_0x2F
	STD  Y+7,R30
	STD  Y+7+1,R31
; 0000 019F 
; 0000 01A0 
; 0000 01A1 ADMUX=0b00000000;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x2E
; 0000 01A2 ADCSRA=0b10100110;
; 0000 01A3 ADCSRA|=0b01000000;
; 0000 01A4 delay_ms(10);
; 0000 01A5 aaa[2]=ADCW;
	CALL SUBOPT_0x2F
	STD  Y+9,R30
	STD  Y+9+1,R31
; 0000 01A6 
; 0000 01A7 if((aaa[0]>=(ADR_CONST_0-40))&&(aaa[0]<=(ADR_CONST_0+40))) adr[0]=0;
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x124
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x125
_0x124:
	RJMP _0x123
_0x125:
	LDI  R30,LOW(0)
	RJMP _0x3C7
; 0000 01A8 else if((aaa[0]>=(ADR_CONST_1-40))&&(aaa[0]<=(ADR_CONST_1+40))) adr[0]=1;
_0x123:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x128
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x129
_0x128:
	RJMP _0x127
_0x129:
	LDI  R30,LOW(1)
	RJMP _0x3C7
; 0000 01A9 else if((aaa[0]>=(ADR_CONST_2-40))&&(aaa[0]<=(ADR_CONST_2+40))) adr[0]=2;
_0x127:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x12C
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x12D
_0x12C:
	RJMP _0x12B
_0x12D:
	LDI  R30,LOW(2)
	RJMP _0x3C7
; 0000 01AA else if((aaa[0]>=(ADR_CONST_3-40))&&(aaa[0]<=(ADR_CONST_3+40))) adr[0]=3;
_0x12B:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x130
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x131
_0x130:
	RJMP _0x12F
_0x131:
	LDI  R30,LOW(3)
	RJMP _0x3C7
; 0000 01AB else adr[0]=5;
_0x12F:
	LDI  R30,LOW(5)
_0x3C7:
	STS  _adr,R30
; 0000 01AC 
; 0000 01AD if((aaa[1]>=(ADR_CONST_0-40))&&(aaa[1]<=(ADR_CONST_0+40))) adr[1]=0;
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x134
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x135
_0x134:
	RJMP _0x133
_0x135:
	LDI  R30,LOW(0)
	RJMP _0x3C8
; 0000 01AE else if((aaa[1]>=(ADR_CONST_1-40))&&(aaa[1]<=(ADR_CONST_1+40))) adr[1]=1;
_0x133:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x138
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x139
_0x138:
	RJMP _0x137
_0x139:
	LDI  R30,LOW(1)
	RJMP _0x3C8
; 0000 01AF else if((aaa[1]>=(ADR_CONST_2-40))&&(aaa[1]<=(ADR_CONST_2+40))) adr[1]=2;
_0x137:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x13C
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x13D
_0x13C:
	RJMP _0x13B
_0x13D:
	LDI  R30,LOW(2)
	RJMP _0x3C8
; 0000 01B0 else if((aaa[1]>=(ADR_CONST_3-40))&&(aaa[1]<=(ADR_CONST_3+40))) adr[1]=3;
_0x13B:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x140
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x141
_0x140:
	RJMP _0x13F
_0x141:
	LDI  R30,LOW(3)
	RJMP _0x3C8
; 0000 01B1 else adr[1]=5;
_0x13F:
	LDI  R30,LOW(5)
_0x3C8:
	__PUTB1MN _adr,1
; 0000 01B2 
; 0000 01B3 if((aaa[2]>=(ADR_CONST_0-40))&&(aaa[2]<=(ADR_CONST_0+40))) adr[2]=0;
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x216)
	LDI  R30,HIGH(0x216)
	CPC  R27,R30
	BRLT _0x144
	CPI  R26,LOW(0x267)
	LDI  R30,HIGH(0x267)
	CPC  R27,R30
	BRLT _0x145
_0x144:
	RJMP _0x143
_0x145:
	LDI  R30,LOW(0)
	RJMP _0x3C9
; 0000 01B4 else if((aaa[2]>=(ADR_CONST_1-40))&&(aaa[2]<=(ADR_CONST_1+40))) adr[2]=1;
_0x143:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x359)
	LDI  R30,HIGH(0x359)
	CPC  R27,R30
	BRLT _0x148
	CPI  R26,LOW(0x3AA)
	LDI  R30,HIGH(0x3AA)
	CPC  R27,R30
	BRLT _0x149
_0x148:
	RJMP _0x147
_0x149:
	LDI  R30,LOW(1)
	RJMP _0x3C9
; 0000 01B5 else if((aaa[2]>=(ADR_CONST_2-40))&&(aaa[2]<=(ADR_CONST_2+40))) adr[2]=2;
_0x147:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x28F)
	LDI  R30,HIGH(0x28F)
	CPC  R27,R30
	BRLT _0x14C
	CPI  R26,LOW(0x2E0)
	LDI  R30,HIGH(0x2E0)
	CPC  R27,R30
	BRLT _0x14D
_0x14C:
	RJMP _0x14B
_0x14D:
	LDI  R30,LOW(2)
	RJMP _0x3C9
; 0000 01B6 else if((aaa[2]>=(ADR_CONST_3-40))&&(aaa[2]<=(ADR_CONST_3+40))) adr[2]=3;
_0x14B:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0x3CF)
	LDI  R30,HIGH(0x3CF)
	CPC  R27,R30
	BRLT _0x150
	CPI  R26,LOW(0x420)
	LDI  R30,HIGH(0x420)
	CPC  R27,R30
	BRLT _0x151
_0x150:
	RJMP _0x14F
_0x151:
	LDI  R30,LOW(3)
	RJMP _0x3C9
; 0000 01B7 else adr[2]=5;
_0x14F:
	LDI  R30,LOW(5)
_0x3C9:
	__PUTB1MN _adr,2
; 0000 01B8 
; 0000 01B9 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
	LDS  R26,_adr
	CPI  R26,LOW(0x5)
	BREQ _0x154
	__GETB2MN _adr,1
	CPI  R26,LOW(0x5)
	BREQ _0x154
	__GETB2MN _adr,2
	CPI  R26,LOW(0x5)
	BRNE _0x153
_0x154:
; 0000 01BA 	{
; 0000 01BB 	//adress=100;
; 0000 01BC 	adress_error=1;
	LDI  R30,LOW(1)
	STS  _adress_error,R30
; 0000 01BD 	}
; 0000 01BE else
	RJMP _0x156
_0x153:
; 0000 01BF 	{
; 0000 01C0 	if(adr[2]&0x02) bps_class=bpsIPS;
	__GETB1MN _adr,2
	ANDI R30,LOW(0x2)
	BREQ _0x157
	LDI  R30,LOW(1)
	RJMP _0x3CA
; 0000 01C1 	else bps_class=bpsIBEP;
_0x157:
	LDI  R30,LOW(0)
_0x3CA:
	STS  _bps_class,R30
; 0000 01C2 
; 0000 01C3 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
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
; 0000 01C4 	}
_0x156:
; 0000 01C5 //plazmaSS=adress;
; 0000 01C6 //adress=0;
; 0000 01C7 
; 0000 01C8 }
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
; 0000 01CF {
_apv_hndl:
; .FSTART _apv_hndl
; 0000 01D0 if(apv_cnt[0])
	LDS  R30,_apv_cnt
	CPI  R30,0
	BREQ _0x159
; 0000 01D1 	{
; 0000 01D2 	apv_cnt[0]--;
	SUBI R30,LOW(1)
	STS  _apv_cnt,R30
; 0000 01D3 	if(apv_cnt[0]==0)
	CPI  R30,0
	BRNE _0x15A
; 0000 01D4 		{
; 0000 01D5 		flags&=0b11100001;
	CALL SUBOPT_0x27
; 0000 01D6 		tsign_cnt=0;
; 0000 01D7 		tmax_cnt=0;
; 0000 01D8 		umax_cnt=0;
; 0000 01D9 		umin_cnt=0;
; 0000 01DA 		//cnt_adc_ch_2_delta=0;
; 0000 01DB 		led_drv_cnt=30;
; 0000 01DC 		}
; 0000 01DD 	}
_0x15A:
; 0000 01DE else if(apv_cnt[1])
	RJMP _0x15B
_0x159:
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BREQ _0x15C
; 0000 01DF 	{
; 0000 01E0 	apv_cnt[1]--;
	__GETB1MN _apv_cnt,1
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,1
; 0000 01E1 	if(apv_cnt[1]==0)
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0x15D
; 0000 01E2 		{
; 0000 01E3 		flags&=0b11100001;
	CALL SUBOPT_0x27
; 0000 01E4 		tsign_cnt=0;
; 0000 01E5 		tmax_cnt=0;
; 0000 01E6 		umax_cnt=0;
; 0000 01E7 		umin_cnt=0;
; 0000 01E8 //		cnt_adc_ch_2_delta=0;
; 0000 01E9 		led_drv_cnt=30;
; 0000 01EA 		}
; 0000 01EB 	}
_0x15D:
; 0000 01EC else if(apv_cnt[2])
	RJMP _0x15E
_0x15C:
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BREQ _0x15F
; 0000 01ED 	{
; 0000 01EE 	apv_cnt[2]--;
	__GETB1MN _apv_cnt,2
	SUBI R30,LOW(1)
	__PUTB1MN _apv_cnt,2
; 0000 01EF 	if(apv_cnt[2]==0)
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0x160
; 0000 01F0 		{
; 0000 01F1 		flags&=0b11100001;
	CALL SUBOPT_0x27
; 0000 01F2 		tsign_cnt=0;
; 0000 01F3 		tmax_cnt=0;
; 0000 01F4 		umax_cnt=0;
; 0000 01F5 		umin_cnt=0;
; 0000 01F6 //		cnt_adc_ch_2_delta=0;
; 0000 01F7 		led_drv_cnt=30;
; 0000 01F8 		}
; 0000 01F9 	}
_0x160:
; 0000 01FA 
; 0000 01FB if(apv_cnt_)
_0x15F:
_0x15E:
_0x15B:
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BREQ _0x161
; 0000 01FC 	{
; 0000 01FD 	apv_cnt_--;
	LDI  R26,LOW(_apv_cnt_)
	LDI  R27,HIGH(_apv_cnt_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 01FE 	if(apv_cnt_==0)
	LDS  R30,_apv_cnt_
	LDS  R31,_apv_cnt_+1
	SBIW R30,0
	BRNE _0x162
; 0000 01FF 		{
; 0000 0200 		bAPV=0;
	LDI  R30,LOW(0)
	STS  _bAPV,R30
; 0000 0201 		apv_start();
	RCALL _apv_start
; 0000 0202 		}
; 0000 0203 	}
_0x162:
; 0000 0204 
; 0000 0205 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
_0x161:
	CALL SUBOPT_0x30
	SBIW R26,0
	BRNE _0x164
	CALL SUBOPT_0x31
	SBIW R26,0
	BRNE _0x164
	SBIS 0x9,4
	RJMP _0x165
_0x164:
	RJMP _0x163
_0x165:
; 0000 0206 	{
; 0000 0207 	if(cnt_apv_off<20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRSH _0x166
; 0000 0208 		{
; 0000 0209 		cnt_apv_off++;
	LDS  R30,_cnt_apv_off
	SUBI R30,-LOW(1)
	STS  _cnt_apv_off,R30
; 0000 020A 		if(cnt_apv_off>=20)
	LDS  R26,_cnt_apv_off
	CPI  R26,LOW(0x14)
	BRLO _0x167
; 0000 020B 			{
; 0000 020C 			apv_stop();
	RCALL _apv_stop
; 0000 020D 			}
; 0000 020E 		}
_0x167:
; 0000 020F 	}
_0x166:
; 0000 0210 else cnt_apv_off=0;
	RJMP _0x168
_0x163:
	LDI  R30,LOW(0)
	STS  _cnt_apv_off,R30
; 0000 0211 
; 0000 0212 }
_0x168:
	RET
; .FEND
;
;//-----------------------------------------------
;void link_drv(void)		//10Hz
; 0000 0216 {
_link_drv:
; .FSTART _link_drv
; 0000 0217 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ _0x169
; 0000 0218 	{
; 0000 0219 	if(link_cnt<602)link_cnt++;
	CALL SUBOPT_0x32
	CPI  R26,LOW(0x25A)
	LDI  R30,HIGH(0x25A)
	CPC  R27,R30
	BRGE _0x16A
	LDI  R26,LOW(_link_cnt)
	LDI  R27,HIGH(_link_cnt)
	CALL SUBOPT_0x28
; 0000 021A 	if(link_cnt==590)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
_0x16A:
	CALL SUBOPT_0x32
	CPI  R26,LOW(0x24E)
	LDI  R30,HIGH(0x24E)
	CPC  R27,R30
	BRNE _0x16B
	LDS  R30,_flags
	ANDI R30,LOW(0xC1)
	STS  _flags,R30
; 0000 021B 	if(link_cnt==600)
_0x16B:
	CALL SUBOPT_0x32
	CPI  R26,LOW(0x258)
	LDI  R30,HIGH(0x258)
	CPC  R27,R30
	BRNE _0x16C
; 0000 021C 		{
; 0000 021D 		link=OFF;
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 021E 
; 0000 021F 		//попробую вместо
; 0000 0220 		//if((AVT_MODE!=0x55)&&(!eeDEVICE))bMAIN=1;
; 0000 0221 		//написать
; 0000 0222 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x16D
	IN   R30,0x2A
	SBR  R30,2
	RJMP _0x3CB
; 0000 0223 		else bMAIN=0;
_0x16D:
	IN   R30,0x2A
	CBR  R30,2
_0x3CB:
	OUT  0x2A,R30
; 0000 0224 
; 0000 0225 		cnt_net_drv=0;
	LDI  R30,LOW(0)
	STS  _cnt_net_drv,R30
; 0000 0226     		if(!res_fl_)
	CALL SUBOPT_0xF
	BRNE _0x16F
; 0000 0227 			{
; 0000 0228 	    		bRES_=1;
	LDI  R30,LOW(1)
	STS  _bRES_,R30
; 0000 0229 	    		res_fl_=1;
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMWRB
; 0000 022A 	    		}
; 0000 022B     		}
_0x16F:
; 0000 022C 	}
_0x16C:
; 0000 022D else link=OFF;
	RJMP _0x170
_0x169:
	LDI  R30,LOW(170)
	STS  _link,R30
; 0000 022E }
_0x170:
	RET
; .FEND
;
;//-----------------------------------------------
;void temper_drv(void)
; 0000 0232 {
_temper_drv:
; .FSTART _temper_drv
; 0000 0233 if(T>ee_tsign) tsign_cnt++;
	CALL SUBOPT_0x23
	CALL SUBOPT_0x33
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x171
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3CC
; 0000 0234 else if (T<(ee_tsign-1)) tsign_cnt--;
_0x171:
	CALL SUBOPT_0x23
	SBIW R30,1
	CALL SUBOPT_0x33
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x173
	LDI  R26,LOW(_tsign_cnt)
	LDI  R27,HIGH(_tsign_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3CC:
	ST   -X,R31
	ST   -X,R30
; 0000 0235 
; 0000 0236 gran(&tsign_cnt,0,60);
_0x173:
	LDI  R30,LOW(_tsign_cnt)
	LDI  R31,HIGH(_tsign_cnt)
	CALL SUBOPT_0x34
; 0000 0237 
; 0000 0238 if(tsign_cnt>=55)
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,55
	BRLT _0x174
; 0000 0239 	{
; 0000 023A 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0x176
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x178
_0x176:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x175
_0x178:
	LDS  R30,_flags
	ORI  R30,4
	STS  _flags,R30
; 0000 023B 	}
_0x175:
; 0000 023C else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
	RJMP _0x17A
_0x174:
	LDS  R26,_tsign_cnt
	LDS  R27,_tsign_cnt+1
	SBIW R26,6
	BRGE _0x17B
	LDS  R30,_flags
	ANDI R30,0xFB
	STS  _flags,R30
; 0000 023D 
; 0000 023E 
; 0000 023F 
; 0000 0240 
; 0000 0241 if(T>ee_tmax) tmax_cnt++;
_0x17B:
_0x17A:
	CALL SUBOPT_0x22
	CALL SUBOPT_0x33
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x17C
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3CD
; 0000 0242 else if (T<(ee_tmax-1)) tmax_cnt--;
_0x17C:
	CALL SUBOPT_0x22
	SBIW R30,1
	CALL SUBOPT_0x33
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x17E
	LDI  R26,LOW(_tmax_cnt)
	LDI  R27,HIGH(_tmax_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3CD:
	ST   -X,R31
	ST   -X,R30
; 0000 0243 
; 0000 0244 gran(&tmax_cnt,0,60);
_0x17E:
	LDI  R30,LOW(_tmax_cnt)
	LDI  R31,HIGH(_tmax_cnt)
	CALL SUBOPT_0x34
; 0000 0245 
; 0000 0246 if(tmax_cnt>=55)
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,55
	BRLT _0x17F
; 0000 0247 	{
; 0000 0248 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x0)
	BRNE _0x181
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x183
_0x181:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x180
_0x183:
	LDS  R30,_flags
	ORI  R30,2
	STS  _flags,R30
; 0000 0249 	}
_0x180:
; 0000 024A else if (tmax_cnt<=5) flags&=0b11111101;
	RJMP _0x185
_0x17F:
	LDS  R26,_tmax_cnt
	LDS  R27,_tmax_cnt+1
	SBIW R26,6
	BRGE _0x186
	LDS  R30,_flags
	ANDI R30,0xFD
	STS  _flags,R30
; 0000 024B 
; 0000 024C 
; 0000 024D }
_0x186:
_0x185:
	RET
; .FEND
;
;//-----------------------------------------------
;void u_drv(void)		//1Hz
; 0000 0251 {
_u_drv:
; .FSTART _u_drv
; 0000 0252 if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x187
; 0000 0253 	{
; 0000 0254 	if(Ui>ee_Umax)umax_cnt++;
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x35
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x188
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x28
; 0000 0255 	else umax_cnt=0;
	RJMP _0x189
_0x188:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 0256 	gran(&umax_cnt,0,10);
_0x189:
	CALL SUBOPT_0x36
; 0000 0257 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
	BRLT _0x18A
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 0258 
; 0000 0259     if(ee_AVT_MODE==0x55)
_0x18A:
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BRNE _0x18B
; 0000 025A         {
; 0000 025B         short temp=ee_Umax;
; 0000 025C         temp/=10;
	SBIW R28,2
;	temp -> Y+0
	CALL SUBOPT_0x1B
	ST   Y,R30
	STD  Y+1,R31
	LD   R26,Y
	LDD  R27,Y+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ST   Y,R30
	STD  Y+1,R31
; 0000 025D         temp*=9;
	LDI  R26,LOW(9)
	LDI  R27,HIGH(9)
	CALL __MULW12
	ST   Y,R30
	STD  Y+1,R31
; 0000 025E         if((Ui<temp)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
	CALL SUBOPT_0x35
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x18D
	SBIS 0x9,4
	RJMP _0x18E
_0x18D:
	RJMP _0x18C
_0x18E:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3CE
; 0000 025F         else umin_cnt--;
_0x18C:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3CE:
	ST   -X,R31
	ST   -X,R30
; 0000 0260         gran(&umin_cnt,0,10);
	CALL SUBOPT_0x37
; 0000 0261         if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x190
	CALL SUBOPT_0x38
; 0000 0262         if(umin_cnt<=0)flags&=~0b00010000;
_0x190:
	CALL SUBOPT_0x30
	CALL __CPW02
	BRLT _0x191
	LDS  R30,_flags
	ANDI R30,0xEF
	STS  _flags,R30
; 0000 0263         }
_0x191:
	ADIW R28,2
; 0000 0264     else
	RJMP _0x192
_0x18B:
; 0000 0265         {
; 0000 0266         if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
	LDS  R30,_Un
	LDS  R31,_Un+1
	CALL SUBOPT_0x35
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x194
	CALL SUBOPT_0x35
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
	BRSH _0x194
	SBIS 0x9,4
	RJMP _0x195
_0x194:
	RJMP _0x193
_0x195:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	CALL SUBOPT_0x28
; 0000 0267         else umin_cnt=0;
	RJMP _0x196
_0x193:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
; 0000 0268         gran(&umin_cnt,0,10);
_0x196:
	CALL SUBOPT_0x37
; 0000 0269         if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x197
	CALL SUBOPT_0x38
; 0000 026A 
; 0000 026B         }
_0x197:
_0x192:
; 0000 026C 
; 0000 026D    // if(ee_AVT_MODE==0x55) &&
; 0000 026E 
; 0000 026F 	}
; 0000 0270 else if(jp_mode==jp3)
	RJMP _0x198
_0x187:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x199
; 0000 0271 	{
; 0000 0272 	if(Ui>700)umax_cnt++;
	CALL SUBOPT_0x35
	CPI  R26,LOW(0x2BD)
	LDI  R30,HIGH(0x2BD)
	CPC  R27,R30
	BRLO _0x19A
	LDI  R26,LOW(_umax_cnt)
	LDI  R27,HIGH(_umax_cnt)
	CALL SUBOPT_0x28
; 0000 0273 	else umax_cnt=0;
	RJMP _0x19B
_0x19A:
	LDI  R30,LOW(0)
	STS  _umax_cnt,R30
	STS  _umax_cnt+1,R30
; 0000 0274 	gran(&umax_cnt,0,10);
_0x19B:
	CALL SUBOPT_0x36
; 0000 0275 	if(umax_cnt>=10)flags|=0b00001000;
	BRLT _0x19C
	LDS  R30,_flags
	ORI  R30,8
	STS  _flags,R30
; 0000 0276 
; 0000 0277 
; 0000 0278 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;
_0x19C:
	CALL SUBOPT_0x35
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRSH _0x19E
	SBIS 0x9,4
	RJMP _0x19F
_0x19E:
	RJMP _0x19D
_0x19F:
	LDI  R26,LOW(_umin_cnt)
	LDI  R27,HIGH(_umin_cnt)
	CALL SUBOPT_0x28
; 0000 0279 	else umin_cnt=0;
	RJMP _0x1A0
_0x19D:
	LDI  R30,LOW(0)
	STS  _umin_cnt,R30
	STS  _umin_cnt+1,R30
; 0000 027A 	gran(&umin_cnt,0,10);
_0x1A0:
	CALL SUBOPT_0x37
; 0000 027B 	if(umin_cnt>=10)flags|=0b00010000;
	BRLT _0x1A1
	CALL SUBOPT_0x38
; 0000 027C 	}
_0x1A1:
; 0000 027D }
_0x199:
_0x198:
	RET
; .FEND
;
;//-----------------------------------------------
;void led_hndl_1(void)
; 0000 0281 {
; 0000 0282 if(jp_mode!=jp3)
; 0000 0283 	{
; 0000 0284 	if(main_cnt1<(5*TZAS))
; 0000 0285 		{
; 0000 0286 		led_red=0x00000000L;
; 0000 0287 		led_green=0x03030303L;
; 0000 0288 		}
; 0000 0289 	else if((link==ON)&&(flags_tu&0b10000000))
; 0000 028A 		{
; 0000 028B 		led_red=0x00055555L;
; 0000 028C  		led_green=0xffffffffL;
; 0000 028D  		}
; 0000 028E 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(100+(5*TZAS))))
; 0000 028F 		{
; 0000 0290 		led_red=0x00000000L;
; 0000 0291 		led_green=0xffffffffL;
; 0000 0292 		}
; 0000 0293 
; 0000 0294 	else  if(link==OFF)
; 0000 0295  		{
; 0000 0296  		led_red=0x55555555L;
; 0000 0297  		led_green=0xffffffffL;
; 0000 0298  		}
; 0000 0299 
; 0000 029A 	else if((link==ON)&&((flags&0b00111110)==0))
; 0000 029B 		{
; 0000 029C 		led_red=0x00000000L;
; 0000 029D 		led_green=0xffffffffL;
; 0000 029E 		}
; 0000 029F 
; 0000 02A0 
; 0000 02A1 
; 0000 02A2 
; 0000 02A3 
; 0000 02A4 	else if((flags&0b00111110)==0b00000100)
; 0000 02A5 		{
; 0000 02A6 		led_red=0x00010001L;
; 0000 02A7 		led_green=0xffffffffL;
; 0000 02A8 		}
; 0000 02A9 	else if(flags&0b00000010)
; 0000 02AA 		{
; 0000 02AB 		led_red=0x00010001L;
; 0000 02AC 		led_green=0x00000000L;
; 0000 02AD 		}
; 0000 02AE 	else if(flags&0b00001000)
; 0000 02AF 		{
; 0000 02B0 		led_red=0x00090009L;
; 0000 02B1 		led_green=0x00000000L;
; 0000 02B2 		}
; 0000 02B3 	else if(flags&0b00010000)
; 0000 02B4 		{
; 0000 02B5 		led_red=0x00490049L;
; 0000 02B6 		led_green=0x00000000L;
; 0000 02B7 		}
; 0000 02B8 
; 0000 02B9 	else if((link==ON)&&(flags&0b00100000))
; 0000 02BA 		{
; 0000 02BB 		led_red=0x00000000L;
; 0000 02BC 		led_green=0x00030003L;
; 0000 02BD 		}
; 0000 02BE 
; 0000 02BF 	if((jp_mode==jp1))
; 0000 02C0 		{
; 0000 02C1 		led_red=0x00000000L;
; 0000 02C2 		led_green=0x33333333L;
; 0000 02C3 		}
; 0000 02C4 	else if((jp_mode==jp2))
; 0000 02C5 		{
; 0000 02C6 		led_red=0xccccccccL;
; 0000 02C7 		led_green=0x00000000L;
; 0000 02C8 		}
; 0000 02C9 	}
; 0000 02CA else if(jp_mode==jp3)
; 0000 02CB 	{
; 0000 02CC 	if(main_cnt1<(5*TZAS))
; 0000 02CD 		{
; 0000 02CE 		led_red=0x00000000L;
; 0000 02CF 		led_green=0x03030303L;
; 0000 02D0 		}
; 0000 02D1 	else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
; 0000 02D2 		{
; 0000 02D3 		led_red=0x00000000L;
; 0000 02D4 		led_green=0xffffffffL;
; 0000 02D5 		}
; 0000 02D6 
; 0000 02D7 	else if((flags&0b00011110)==0)
; 0000 02D8 		{
; 0000 02D9 		led_red=0x00000000L;
; 0000 02DA 		led_green=0xffffffffL;
; 0000 02DB 		}
; 0000 02DC 
; 0000 02DD 
; 0000 02DE 	else if((flags&0b00111110)==0b00000100)
; 0000 02DF 		{
; 0000 02E0 		led_red=0x00010001L;
; 0000 02E1 		led_green=0xffffffffL;
; 0000 02E2 		}
; 0000 02E3 	else if(flags&0b00000010)
; 0000 02E4 		{
; 0000 02E5 		led_red=0x00010001L;
; 0000 02E6 		led_green=0x00000000L;
; 0000 02E7 		}
; 0000 02E8 	else if(flags&0b00001000)
; 0000 02E9 		{
; 0000 02EA 		led_red=0x00090009L;
; 0000 02EB 		led_green=0x00000000L;
; 0000 02EC 		}
; 0000 02ED 	else if(flags&0b00010000)
; 0000 02EE 		{
; 0000 02EF 		led_red=0x00490049L;
; 0000 02F0 		led_green=0xffffffffL;
; 0000 02F1 		}
; 0000 02F2 		/*led_green=0x33333333L;
; 0000 02F3 		led_red=0xccccccccL;*/
; 0000 02F4 	}
; 0000 02F5 
; 0000 02F6 }
;
;//-----------------------------------------------
;void led_hndl(void)
; 0000 02FA {
_led_hndl:
; .FSTART _led_hndl
; 0000 02FB if(adress_error)
	LDS  R30,_adress_error
	CPI  R30,0
	BREQ _0x1D2
; 0000 02FC 	{
; 0000 02FD 	led_red=0x55555555L;
	CALL SUBOPT_0x39
	CALL SUBOPT_0x3A
; 0000 02FE 	led_green=0x55555555L;
	CALL SUBOPT_0x39
	RJMP _0x3D3
; 0000 02FF 	}
; 0000 0300 
; 0000 0301 /*else if(bps_class==bpsIBEP)		//проверка работы адресатора
; 0000 0302 	{
; 0000 0303 	if(adress==0)led_red=0x00000001L;
; 0000 0304 	if(adress==1)led_red=0x00000005L;
; 0000 0305 	if(adress==2)led_red=0x00000015L;
; 0000 0306 	if(adress==3)led_red=0x00000055L;
; 0000 0307 	if(adress==4)led_red=0x00000155L;
; 0000 0308 	if(adress==5)led_red=0x00111111L;
; 0000 0309 	if(adress==6)led_red=0x01111111L;
; 0000 030A 	if(adress==7)led_red=0x11111111L;
; 0000 030B 	led_green=0x00000000L;
; 0000 030C 	}*/
; 0000 030D /*		else  if(link==OFF)
; 0000 030E 			{
; 0000 030F 			led_red=0x555ff555L;
; 0000 0310 			led_green=0xffffffffL;
; 0000 0311 			}
; 0000 0312 else if(link_cnt>50)
; 0000 0313 	{
; 0000 0314 	led_red=0x5555ff55L;
; 0000 0315 	led_green=0x55555555L;
; 0000 0316 	} */
; 0000 0317 else if(ee_AVT_MODE==0x55)
_0x1D2:
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x1D4
; 0000 0318 	{
; 0000 0319 
; 0000 031A     led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 031B 	led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	CALL SUBOPT_0x3D
; 0000 031C 
; 0000 031D 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x1D5
; 0000 031E 		{
; 0000 031F /*		if(main_cnt1<(5*ee_TZAS))
; 0000 0320 			{
; 0000 0321 			led_red=0x00000000L;
; 0000 0322 			led_green=0x03030303L;
; 0000 0323 			}
; 0000 0324 
; 0000 0325 		else if((link==ON)&&(flags_tu&0b10000000))
; 0000 0326 			{
; 0000 0327 			led_red=0x00055555L;
; 0000 0328 			led_green=0xffffffffL;
; 0000 0329 			}   */
; 0000 032A 
; 0000 032B /*		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
; 0000 032C 			{
; 0000 032D 			led_red=0x00000000L;
; 0000 032E 			led_green=0xffffffffL;
; 0000 032F 			} */
; 0000 0330 
; 0000 0331 /*		else  if(link==OFF)
; 0000 0332 			{
; 0000 0333 			led_red=0x55555555L;
; 0000 0334 			led_green=0xffffffffL;
; 0000 0335 			}
; 0000 0336 
; 0000 0337 		else*/ if((link==ON)&&((flags&0b00111110)==0))
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1D7
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x1D8
_0x1D7:
	RJMP _0x1D6
_0x1D8:
; 0000 0338 			{
; 0000 0339 			led_red=0x00000111L;
	__GETD1N 0x111
	CALL SUBOPT_0x3A
; 0000 033A 			led_green=0x00000111L;
	__GETD1N 0x111
	RJMP _0x3D4
; 0000 033B 			}
; 0000 033C 
; 0000 033D 		else if((flags&0b00111110)==0b00000100)
_0x1D6:
	CALL SUBOPT_0x3E
	BRNE _0x1DA
; 0000 033E 			{
; 0000 033F 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
	RJMP _0x3D5
; 0000 0340 			led_green=0xffffffffL;
; 0000 0341 			}
; 0000 0342 		else if(flags&0b00000010)
_0x1DA:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x1DC
; 0000 0343 			{
; 0000 0344 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 0345 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 0346 			}
; 0000 0347 		else if(flags&0b00001000)
	RJMP _0x1DD
_0x1DC:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x1DE
; 0000 0348 			{
; 0000 0349 			led_red=0x00090009L;
	CALL SUBOPT_0x42
; 0000 034A 			led_green=0x00000000L;
; 0000 034B 			}
; 0000 034C 		else if(flags&0b00010000)
	RJMP _0x1DF
_0x1DE:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x1E0
; 0000 034D 			{
; 0000 034E 			led_red=0x00490049L;
	CALL SUBOPT_0x43
_0x3D5:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 034F 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
_0x3D4:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0350 			}
; 0000 0351 
; 0000 0352 /*		else if((link==ON)&&(flags&0b00100000))
; 0000 0353 			{
; 0000 0354 			led_red=0x00000000L;
; 0000 0355 			led_green=0x00030003L;
; 0000 0356 			} */
; 0000 0357 
; 0000 0358 		if((jp_mode==jp1))
_0x1E0:
_0x1DF:
_0x1DD:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x1E1
; 0000 0359 			{
; 0000 035A 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 035B 			led_green=0x33333333L;
	CALL SUBOPT_0x44
; 0000 035C 			}
; 0000 035D 		else if((jp_mode==jp2))
	RJMP _0x1E2
_0x1E1:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x1E3
; 0000 035E 			{
; 0000 035F 			led_red=0xccccccccL;
	CALL SUBOPT_0x45
; 0000 0360 			led_green=0x00000000L;
; 0000 0361 			}
; 0000 0362 		}
_0x1E3:
_0x1E2:
; 0000 0363 
; 0000 0364 /*    if(umin_cnt)
; 0000 0365         {
; 0000 0366         led_red=0x00c900c9L;
; 0000 0367 		led_green=0x00c000c0L;
; 0000 0368         } */
; 0000 0369 	}
_0x1D5:
; 0000 036A else if(bps_class==bpsIBEP)	//если блок ИБЭПный
	RJMP _0x1E4
_0x1D4:
	LDS  R30,_bps_class
	CPI  R30,0
	BREQ PC+2
	RJMP _0x1E5
; 0000 036B 	{
; 0000 036C 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x1E6
; 0000 036D 		{
; 0000 036E 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x1E7
; 0000 036F 			{
; 0000 0370 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 0371 			led_green=0x03030303L;
	CALL SUBOPT_0x47
	RJMP _0x3D6
; 0000 0372 			}
; 0000 0373 
; 0000 0374 		else if((link==ON)&&(flags_tu&0b10000000))
_0x1E7:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1EA
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x1EB
_0x1EA:
	RJMP _0x1E9
_0x1EB:
; 0000 0375 			{
; 0000 0376 			led_red=0x00055555L;
	CALL SUBOPT_0x48
; 0000 0377 			led_green=0xffffffffL;
	RJMP _0x3D6
; 0000 0378 			}
; 0000 0379 
; 0000 037A 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
_0x1E9:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x1EE
	CALL SUBOPT_0x49
	BRLT _0x1EF
_0x1EE:
	RJMP _0x1F0
_0x1EF:
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x1F0
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0x1F1
_0x1F0:
	RJMP _0x1ED
_0x1F1:
; 0000 037B 			{
; 0000 037C 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 037D 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3D6
; 0000 037E 			}
; 0000 037F 
; 0000 0380 		else  if(link==OFF)
_0x1ED:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x1F3
; 0000 0381 			{
; 0000 0382 			led_red=0x55555555L;
	CALL SUBOPT_0x4A
; 0000 0383 			led_green=0xffffffffL;
	RJMP _0x3D6
; 0000 0384 			}
; 0000 0385 
; 0000 0386 		else if((link==ON)&&((flags&0b00111110)==0))
_0x1F3:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x1F6
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x1F7
_0x1F6:
	RJMP _0x1F5
_0x1F7:
; 0000 0387 			{
; 0000 0388 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 0389 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3D6
; 0000 038A 			}
; 0000 038B 
; 0000 038C 		else if((flags&0b00111110)==0b00000100)
_0x1F5:
	CALL SUBOPT_0x3E
	BRNE _0x1F9
; 0000 038D 			{
; 0000 038E 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 038F 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3D6
; 0000 0390 			}
; 0000 0391 		else if(flags&0b00000010)
_0x1F9:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x1FB
; 0000 0392 			{
; 0000 0393 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 0394 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 0395 			}
; 0000 0396 		else if(flags&0b00001000)
	RJMP _0x1FC
_0x1FB:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x1FD
; 0000 0397 			{
; 0000 0398 			led_red=0x00090009L;
	CALL SUBOPT_0x42
; 0000 0399 			led_green=0x00000000L;
; 0000 039A 			}
; 0000 039B 		else if(flags&0b00010000)
	RJMP _0x1FE
_0x1FD:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x1FF
; 0000 039C 			{
; 0000 039D 			led_red=0x00490049L;
	CALL SUBOPT_0x4B
; 0000 039E 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 039F 			}
; 0000 03A0 
; 0000 03A1 		else if((link==ON)&&(flags&0b00100000))
	RJMP _0x200
_0x1FF:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x202
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x203
_0x202:
	RJMP _0x201
_0x203:
; 0000 03A2 			{
; 0000 03A3 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03A4 			led_green=0x00030003L;
	__GETD1N 0x30003
_0x3D6:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03A5 			}
; 0000 03A6 
; 0000 03A7 		if((jp_mode==jp1))
_0x201:
_0x200:
_0x1FE:
_0x1FC:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x204
; 0000 03A8 			{
; 0000 03A9 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03AA 			led_green=0x33333333L;
	CALL SUBOPT_0x44
; 0000 03AB 			}
; 0000 03AC 		else if((jp_mode==jp2))
	RJMP _0x205
_0x204:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x206
; 0000 03AD 			{
; 0000 03AE 			led_red=0xccccccccL;
	CALL SUBOPT_0x45
; 0000 03AF 			led_green=0x00000000L;
; 0000 03B0 			}
; 0000 03B1 		}
_0x206:
_0x205:
; 0000 03B2 	else if(jp_mode==jp3)
	RJMP _0x207
_0x1E6:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0x208
; 0000 03B3 		{
; 0000 03B4 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x209
; 0000 03B5 			{
; 0000 03B6 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03B7 			led_green=0x03030303L;
	CALL SUBOPT_0x47
	RJMP _0x3D7
; 0000 03B8 			}
; 0000 03B9 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
_0x209:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x20C
	CALL SUBOPT_0x4C
	BRLT _0x20D
_0x20C:
	RJMP _0x20B
_0x20D:
; 0000 03BA 			{
; 0000 03BB 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03BC 			led_green=0xffffffffL;
	RJMP _0x3D8
; 0000 03BD 			}
; 0000 03BE 
; 0000 03BF 		else if((flags&0b00011110)==0)
_0x20B:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x20F
; 0000 03C0 			{
; 0000 03C1 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03C2 			led_green=0xffffffffL;
	RJMP _0x3D8
; 0000 03C3 			}
; 0000 03C4 
; 0000 03C5 
; 0000 03C6 		else if((flags&0b00111110)==0b00000100)
_0x20F:
	CALL SUBOPT_0x3E
	BRNE _0x211
; 0000 03C7 			{
; 0000 03C8 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
	RJMP _0x3D9
; 0000 03C9 			led_green=0xffffffffL;
; 0000 03CA 			}
; 0000 03CB 		else if(flags&0b00000010)
_0x211:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x213
; 0000 03CC 			{
; 0000 03CD 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 03CE 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 03CF 			}
; 0000 03D0 		else if(flags&0b00001000)
	RJMP _0x214
_0x213:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x215
; 0000 03D1 			{
; 0000 03D2 			led_red=0x00090009L;
	CALL SUBOPT_0x42
; 0000 03D3 			led_green=0x00000000L;
; 0000 03D4 			}
; 0000 03D5 		else if(flags&0b00010000)
	RJMP _0x216
_0x215:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x217
; 0000 03D6 			{
; 0000 03D7 			led_red=0x00490049L;
	CALL SUBOPT_0x43
_0x3D9:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 03D8 			led_green=0xffffffffL;
_0x3D8:
	__GETD1N 0xFFFFFFFF
_0x3D7:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03D9 			}
; 0000 03DA 		}
_0x217:
_0x216:
_0x214:
; 0000 03DB 	}
_0x208:
_0x207:
; 0000 03DC else if(bps_class==bpsIPS)	//если блок ИПСный
	RJMP _0x218
_0x1E5:
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x219
; 0000 03DD 	{
; 0000 03DE 	if(jp_mode!=jp3)
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE PC+2
	RJMP _0x21A
; 0000 03DF 		{
; 0000 03E0 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x21B
; 0000 03E1 			{
; 0000 03E2 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03E3 			led_green=0x03030303L;
	CALL SUBOPT_0x47
	RJMP _0x3DA
; 0000 03E4 			}
; 0000 03E5 
; 0000 03E6 		else if((link==ON)&&(flags_tu&0b10000000))
_0x21B:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x21E
	LDS  R30,_flags_tu
	ANDI R30,LOW(0x80)
	BRNE _0x21F
_0x21E:
	RJMP _0x21D
_0x21F:
; 0000 03E7 			{
; 0000 03E8 			led_red=0x00055555L;
	CALL SUBOPT_0x48
; 0000 03E9 			led_green=0xffffffffL;
	RJMP _0x3DA
; 0000 03EA 			}
; 0000 03EB 
; 0000 03EC 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
_0x21D:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x222
	CALL SUBOPT_0x49
	BRLT _0x223
_0x222:
	RJMP _0x224
_0x223:
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x224
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0x225
_0x224:
	RJMP _0x221
_0x225:
; 0000 03ED 			{
; 0000 03EE 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03EF 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3DA
; 0000 03F0 			}
; 0000 03F1 
; 0000 03F2 		else  if(link==OFF)
_0x221:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ PC+2
	RJMP _0x227
; 0000 03F3 			{
; 0000 03F4 			if((flags&0b00011110)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x228
; 0000 03F5 				{
; 0000 03F6 				led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 03F7 				if(bMAIN)led_green=0xfffffff5L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x229
	__GETD1N 0xFFFFFFF5
	RJMP _0x3DB
; 0000 03F8 				else led_green=0xffffffffL;
_0x229:
	CALL SUBOPT_0x3C
_0x3DB:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 03F9 				}
; 0000 03FA 
; 0000 03FB 			else if((flags&0b00111110)==0b00000100)
	RJMP _0x22B
_0x228:
	CALL SUBOPT_0x3E
	BRNE _0x22C
; 0000 03FC 				{
; 0000 03FD 				led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 03FE 				if(bMAIN)led_green=0xfffffff5L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x22D
	__GETD1N 0xFFFFFFF5
	RJMP _0x3DC
; 0000 03FF 				else led_green=0xffffffffL;
_0x22D:
	CALL SUBOPT_0x3C
_0x3DC:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0400 				}
; 0000 0401 			else if(flags&0b00000010)
	RJMP _0x22F
_0x22C:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x230
; 0000 0402 				{
; 0000 0403 				led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 0404 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x231
	CALL SUBOPT_0x4D
; 0000 0405 				else led_green=0x00000000L;
	RJMP _0x232
_0x231:
	CALL SUBOPT_0x41
; 0000 0406 				}
_0x232:
; 0000 0407 			else if(flags&0b00001000)
	RJMP _0x233
_0x230:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x234
; 0000 0408 				{
; 0000 0409 				led_red=0x00090009L;
	__GETD1N 0x90009
	CALL SUBOPT_0x3A
; 0000 040A 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x235
	CALL SUBOPT_0x4D
; 0000 040B 				else led_green=0x00000000L;
	RJMP _0x236
_0x235:
	CALL SUBOPT_0x41
; 0000 040C 				}
_0x236:
; 0000 040D 			else if(flags&0b00010000)
	RJMP _0x237
_0x234:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x238
; 0000 040E 				{
; 0000 040F 				led_red=0x00490049L;
	CALL SUBOPT_0x4B
; 0000 0410 				if(bMAIN)led_green=0x00000005L;
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x239
	CALL SUBOPT_0x4D
; 0000 0411 				else led_green=0x00000000L;
	RJMP _0x23A
_0x239:
	CALL SUBOPT_0x41
; 0000 0412 				}
_0x23A:
; 0000 0413 			else
	RJMP _0x23B
_0x238:
; 0000 0414 				{
; 0000 0415 				led_red=0x55555555L;
	CALL SUBOPT_0x4A
; 0000 0416 				led_green=0xffffffffL;
	CALL SUBOPT_0x3D
; 0000 0417 				}
_0x23B:
_0x237:
_0x233:
_0x22F:
_0x22B:
; 0000 0418 
; 0000 0419 
; 0000 041A /*			if(bMAIN)
; 0000 041B 				{
; 0000 041C 				led_red=0x0L;
; 0000 041D 				led_green=0xfffffff5L;
; 0000 041E 				}
; 0000 041F 			else
; 0000 0420 				{
; 0000 0421 				led_red=0x55555555L;
; 0000 0422 				led_green=0xffffffffL;
; 0000 0423 				}*/
; 0000 0424 			}
; 0000 0425 
; 0000 0426 		else if((link==ON)&&((flags&0b00111110)==0))
	RJMP _0x23C
_0x227:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x23E
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	BREQ _0x23F
_0x23E:
	RJMP _0x23D
_0x23F:
; 0000 0427 			{
; 0000 0428 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 0429 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3DA
; 0000 042A 			}
; 0000 042B 
; 0000 042C 		else if((flags&0b00111110)==0b00000100)
_0x23D:
	CALL SUBOPT_0x3E
	BRNE _0x241
; 0000 042D 			{
; 0000 042E 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 042F 			led_green=0xffffffffL;
	CALL SUBOPT_0x3C
	RJMP _0x3DA
; 0000 0430 			}
; 0000 0431 		else if(flags&0b00000010)
_0x241:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x243
; 0000 0432 			{
; 0000 0433 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 0434 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 0435 			}
; 0000 0436 		else if(flags&0b00001000)
	RJMP _0x244
_0x243:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x245
; 0000 0437 			{
; 0000 0438 			led_red=0x00090009L;
	CALL SUBOPT_0x42
; 0000 0439 			led_green=0x00000000L;
; 0000 043A 			}
; 0000 043B 		else if(flags&0b00010000)
	RJMP _0x246
_0x245:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x247
; 0000 043C 			{
; 0000 043D 			led_red=0x00490049L;
	CALL SUBOPT_0x4B
; 0000 043E 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 043F 			}
; 0000 0440 
; 0000 0441 		else if((link==ON)&&(flags&0b00100000))
	RJMP _0x248
_0x247:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BRNE _0x24A
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BRNE _0x24B
_0x24A:
	RJMP _0x249
_0x24B:
; 0000 0442 			{
; 0000 0443 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 0444 			led_green=0x00030003L;
	__GETD1N 0x30003
_0x3DA:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 0445 			}
; 0000 0446 
; 0000 0447 		if((jp_mode==jp1))
_0x249:
_0x248:
_0x246:
_0x244:
_0x23C:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x24C
; 0000 0448 			{
; 0000 0449 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 044A 			led_green=0x33333333L;
	CALL SUBOPT_0x44
; 0000 044B 			}
; 0000 044C 		else if((jp_mode==jp2))
	RJMP _0x24D
_0x24C:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x24E
; 0000 044D 			{
; 0000 044E 			//if(ee_DEVICE)led_red=0xccccccacL;
; 0000 044F 			//else led_red=0xcc0cccacL;
; 0000 0450 			led_red=0xccccccccL;
	CALL SUBOPT_0x45
; 0000 0451 			led_green=0x00000000L;
; 0000 0452 			}
; 0000 0453 		}
_0x24E:
_0x24D:
; 0000 0454 	else if(jp_mode==jp3)
	RJMP _0x24F
_0x21A:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0x250
; 0000 0455 		{
; 0000 0456 		if(main_cnt1<(5*ee_TZAS))
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x251
; 0000 0457 			{
; 0000 0458 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 0459 			led_green=0x03030303L;
	CALL SUBOPT_0x47
	RJMP _0x3D3
; 0000 045A 			}
; 0000 045B 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
_0x251:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x254
	CALL SUBOPT_0x4C
	BRLT _0x255
_0x254:
	RJMP _0x253
_0x255:
; 0000 045C 			{
; 0000 045D 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 045E 			led_green=0xffffffffL;
	RJMP _0x3DD
; 0000 045F 			}
; 0000 0460 
; 0000 0461 		else if((flags&0b00011110)==0)
_0x253:
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	BRNE _0x257
; 0000 0462 			{
; 0000 0463 			led_red=0x00000000L;
	CALL SUBOPT_0x3B
; 0000 0464 			led_green=0xffffffffL;
	RJMP _0x3DD
; 0000 0465 			}
; 0000 0466 
; 0000 0467 
; 0000 0468 		else if((flags&0b00111110)==0b00000100)
_0x257:
	CALL SUBOPT_0x3E
	BRNE _0x259
; 0000 0469 			{
; 0000 046A 			led_red=0x00010001L;
	CALL SUBOPT_0x3F
	RJMP _0x3DE
; 0000 046B 			led_green=0xffffffffL;
; 0000 046C 			}
; 0000 046D 		else if(flags&0b00000010)
_0x259:
	LDS  R30,_flags
	ANDI R30,LOW(0x2)
	BREQ _0x25B
; 0000 046E 			{
; 0000 046F 			led_red=0x00010001L;
	CALL SUBOPT_0x40
; 0000 0470 			led_green=0x00000000L;
	CALL SUBOPT_0x41
; 0000 0471 			}
; 0000 0472 		else if(flags&0b00001000)
	RJMP _0x25C
_0x25B:
	LDS  R30,_flags
	ANDI R30,LOW(0x8)
	BREQ _0x25D
; 0000 0473 			{
; 0000 0474 			led_red=0x00090009L;
	CALL SUBOPT_0x42
; 0000 0475 			led_green=0x00000000L;
; 0000 0476 			}
; 0000 0477 		else if(flags&0b00010000)
	RJMP _0x25E
_0x25D:
	LDS  R30,_flags
	ANDI R30,LOW(0x10)
	BREQ _0x25F
; 0000 0478 			{
; 0000 0479 			led_red=0x00490049L;
	CALL SUBOPT_0x43
_0x3DE:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
; 0000 047A 			led_green=0xffffffffL;
_0x3DD:
	__GETD1N 0xFFFFFFFF
_0x3D3:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
; 0000 047B 			}
; 0000 047C 		}
_0x25F:
_0x25E:
_0x25C:
; 0000 047D 	}
_0x250:
_0x24F:
; 0000 047E }
_0x219:
_0x218:
_0x1E4:
	RET
; .FEND
;
;
;
;
;//-----------------------------------------------
;void pwr_drv_(void)
; 0000 0485 {
; 0000 0486 DDRD.4=1;
; 0000 0487 
; 0000 0488 if(main_cnt1<150)main_cnt1++;
; 0000 0489 
; 0000 048A if(main_cnt1<(5*TZAS))
; 0000 048B 	{
; 0000 048C 	PORTD.4=1;
; 0000 048D 	}
; 0000 048E else if((main_cnt1>(5*TZAS))&&(main_cnt1<(70+(5*TZAS))))
; 0000 048F 	{
; 0000 0490 	PORTD.4=0;
; 0000 0491 	}
; 0000 0492 else if(bBL)
; 0000 0493 	{
; 0000 0494 	PORTD.4=1;
; 0000 0495 	}
; 0000 0496 else if(!bBL)
; 0000 0497 	{
; 0000 0498 	PORTD.4=0;
; 0000 0499 	}
; 0000 049A 
; 0000 049B //DDRB|=0b00000010;
; 0000 049C 
; 0000 049D gran(&pwm_u,2,1020);
; 0000 049E 
; 0000 049F 
; 0000 04A0 OCR1A=pwm_u;
; 0000 04A1 /*PORTB.2=1;
; 0000 04A2 OCR1A=0;*/
; 0000 04A3 }
;
;//-----------------------------------------------
;//Вентилятор
;void vent_drv(void)
; 0000 04A8 {
_vent_drv:
; .FSTART _vent_drv
; 0000 04A9 
; 0000 04AA 
; 0000 04AB 	short vent_pwm_i_necc=400;
; 0000 04AC 	short vent_pwm_t_necc=400;
; 0000 04AD 	short vent_pwm_max_necc=400;
; 0000 04AE 	signed long tempSL;
; 0000 04AF 
; 0000 04B0 	//I=1200;
; 0000 04B1 
; 0000 04B2 	tempSL=36000L/(signed long)ee_Umax;
	SBIW R28,4
	CALL __SAVELOCR6
;	vent_pwm_i_necc -> R16,R17
;	vent_pwm_t_necc -> R18,R19
;	vent_pwm_max_necc -> R20,R21
;	tempSL -> Y+6
	__GETWRN 16,17,400
	__GETWRN 18,19,400
	__GETWRN 20,21,400
	CALL SUBOPT_0x1B
	CALL __CWD1
	__GETD2N 0x8CA0
	CALL SUBOPT_0x4E
; 0000 04B3 	tempSL=(signed long)I/tempSL;
	LDS  R26,_I
	LDS  R27,_I+1
	CLR  R24
	CLR  R25
	__GETD1S 6
	CALL SUBOPT_0x4E
; 0000 04B4 
; 0000 04B5 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x274
	LDI  R26,LOW(_ee_IMAXVENT)
	LDI  R27,HIGH(_ee_IMAXVENT)
	CALL __EEPROMRDW
	LDS  R26,_I
	LDS  R27,_I+1
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	__PUTD1S 6
; 0000 04B6 
; 0000 04B7 	if(tempSL>10)vent_pwm_i_necc=1000;
_0x274:
	CALL SUBOPT_0x4F
	__CPD2N 0xB
	BRLT _0x275
	__GETWRN 16,17,1000
; 0000 04B8 	else if(tempSL<1)vent_pwm_i_necc=400;
	RJMP _0x276
_0x275:
	CALL SUBOPT_0x4F
	__CPD2N 0x1
	BRGE _0x277
	__GETWRN 16,17,400
; 0000 04B9 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
	RJMP _0x278
_0x277:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(60)
	LDI  R27,HIGH(60)
	CALL __MULW12
	SUBI R30,LOW(-400)
	SBCI R31,HIGH(-400)
	MOVW R16,R30
; 0000 04BA 	gran(&vent_pwm_i_necc,400,1000);
_0x278:
_0x276:
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL SUBOPT_0x50
	RCALL _gran
	POP  R16
	POP  R17
; 0000 04BB 	//vent_pwm_i_necc=400;
; 0000 04BC 	tempSL=(signed long)T;
	LDS  R30,_T
	LDS  R31,_T+1
	CALL __CWD1
	__PUTD1S 6
; 0000 04BD 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
	CALL SUBOPT_0x23
	CALL __CWD1
	__SUBD1N 30
	CALL SUBOPT_0x4F
	CALL __CPD12
	BRLT _0x279
	__GETWRN 18,19,400
; 0000 04BE 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
	RJMP _0x27A
_0x279:
	CALL SUBOPT_0x23
	CALL SUBOPT_0x4F
	CALL __CWD1
	CALL __CPD21
	BRLT _0x27B
	__GETWRN 18,19,1000
; 0000 04BF 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
	RJMP _0x27C
_0x27B:
	CALL SUBOPT_0x23
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
; 0000 04C0 	gran(&vent_pwm_t_necc,400,1000);
_0x27C:
_0x27A:
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R19
	PUSH R18
	CALL SUBOPT_0x50
	RCALL _gran
	POP  R18
	POP  R19
; 0000 04C1 
; 0000 04C2 	vent_pwm_max_necc=vent_pwm_i_necc;
	MOVW R20,R16
; 0000 04C3 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
	__CPWRR 16,17,18,19
	BRGE _0x27D
	MOVW R20,R18
; 0000 04C4 
; 0000 04C5 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
_0x27D:
	CALL SUBOPT_0x51
	CP   R26,R20
	CPC  R27,R21
	BRGE _0x27E
	LDS  R30,_vent_pwm
	LDS  R31,_vent_pwm+1
	ADIW R30,10
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R31
; 0000 04C6 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
_0x27E:
	CALL SUBOPT_0x51
	CP   R20,R26
	CPC  R21,R27
	BRGE _0x27F
	LDS  R30,_vent_pwm
	LDS  R31,_vent_pwm+1
	SBIW R30,10
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R31
; 0000 04C7 	gran(&vent_pwm,400,1000);
_0x27F:
	LDI  R30,LOW(_vent_pwm)
	LDI  R31,HIGH(_vent_pwm)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x50
	RCALL _gran
; 0000 04C8 
; 0000 04C9 	//vent_pwm=1000-vent_pwm;	// Для нового блока. Там похоже нужна инверсия
; 0000 04CA 	//vent_pwm=300;
; 0000 04CB 	if(bVENT_BLOCK)vent_pwm=0;
	LDS  R30,_bVENT_BLOCK
	CPI  R30,0
	BREQ _0x280
	LDI  R30,LOW(0)
	STS  _vent_pwm,R30
	STS  _vent_pwm+1,R30
; 0000 04CC }
_0x280:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;
;//-----------------------------------------------
;void vent_resurs_hndl(void)
; 0000 04D0 {
_vent_resurs_hndl:
; .FSTART _vent_resurs_hndl
; 0000 04D1 unsigned char temp;
; 0000 04D2 if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
	ST   -Y,R17
;	temp -> R17
	LDS  R30,_bVENT_BLOCK
	CPI  R30,0
	BRNE _0x281
	LDI  R26,LOW(_vent_resurs_sec_cnt)
	LDI  R27,HIGH(_vent_resurs_sec_cnt)
	CALL SUBOPT_0x28
; 0000 04D3 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
_0x281:
	LDS  R26,_vent_resurs_sec_cnt
	LDS  R27,_vent_resurs_sec_cnt+1
	CPI  R26,LOW(0xE11)
	LDI  R30,HIGH(0xE11)
	CPC  R27,R30
	BRLO _0x282
; 0000 04D4 	{
; 0000 04D5 	if(vent_resurs<60000)vent_resurs++;
	CALL SUBOPT_0x52
	CPI  R30,LOW(0xEA60)
	LDI  R26,HIGH(0xEA60)
	CPC  R31,R26
	BRSH _0x283
	CALL SUBOPT_0x52
	ADIW R30,1
	CALL __EEPROMWRW
; 0000 04D6 	vent_resurs_sec_cnt=0;
_0x283:
	LDI  R30,LOW(0)
	STS  _vent_resurs_sec_cnt,R30
	STS  _vent_resurs_sec_cnt+1,R30
; 0000 04D7 	}
; 0000 04D8 
; 0000 04D9 //vent_resurs=12543;
; 0000 04DA 
; 0000 04DB vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
_0x282:
	CALL SUBOPT_0x52
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _vent_resurs_buff,R30
; 0000 04DC vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
	CALL SUBOPT_0x52
	ANDI R30,LOW(0xF0)
	ANDI R31,HIGH(0xF0)
	CALL __LSRW4
	LDI  R31,0
	ORI  R30,0x40
	__PUTB1MN _vent_resurs_buff,1
; 0000 04DD vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
	CALL SUBOPT_0x52
	ANDI R30,LOW(0xF00)
	ANDI R31,HIGH(0xF00)
	MOV  R30,R31
	LDI  R31,0
	LDI  R31,0
	ORI  R30,0x80
	__PUTB1MN _vent_resurs_buff,2
; 0000 04DE vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
	CALL SUBOPT_0x52
	ANDI R30,LOW(0xF000)
	ANDI R31,HIGH(0xF000)
	CALL __LSRW4
	MOV  R30,R31
	LDI  R31,0
	LDI  R31,0
	ORI  R30,LOW(0xC0)
	__PUTB1MN _vent_resurs_buff,3
; 0000 04DF 
; 0000 04E0 temp=vent_resurs_buff[0]&0x0f;
	LDS  R30,_vent_resurs_buff
	ANDI R30,LOW(0xF)
	MOV  R17,R30
; 0000 04E1 temp^=vent_resurs_buff[1]&0x0f;
	__GETB1MN _vent_resurs_buff,1
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 04E2 temp^=vent_resurs_buff[2]&0x0f;
	__GETB1MN _vent_resurs_buff,2
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 04E3 temp^=vent_resurs_buff[3]&0x0f;
	__GETB1MN _vent_resurs_buff,3
	ANDI R30,LOW(0xF)
	EOR  R17,R30
; 0000 04E4 
; 0000 04E5 vent_resurs_buff[0]|=(temp&0x03)<<4;
	MOV  R30,R17
	ANDI R30,LOW(0x3)
	SWAP R30
	ANDI R30,0xF0
	LDS  R26,_vent_resurs_buff
	OR   R30,R26
	STS  _vent_resurs_buff,R30
; 0000 04E6 vent_resurs_buff[1]|=(temp&0x0c)<<2;
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
; 0000 04E7 vent_resurs_buff[2]|=(temp&0x30);
	__POINTW1MN _vent_resurs_buff,2
	MOVW R0,R30
	LD   R26,Z
	MOV  R30,R17
	ANDI R30,LOW(0x30)
	OR   R30,R26
	MOVW R26,R0
	ST   X,R30
; 0000 04E8 vent_resurs_buff[3]|=(temp&0xc0)>>2;
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
; 0000 04E9 
; 0000 04EA 
; 0000 04EB vent_resurs_tx_cnt++;
	LDS  R30,_vent_resurs_tx_cnt
	SUBI R30,-LOW(1)
	STS  _vent_resurs_tx_cnt,R30
; 0000 04EC if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
	LDS  R26,_vent_resurs_tx_cnt
	CPI  R26,LOW(0x4)
	BRLO _0x284
	LDI  R30,LOW(0)
	STS  _vent_resurs_tx_cnt,R30
; 0000 04ED 
; 0000 04EE 
; 0000 04EF }
_0x284:
	RJMP _0x20C0001
; .FEND
;
;//-----------------------------------------------
;void volum_u_main_drv(void)
; 0000 04F3 {
_volum_u_main_drv:
; .FSTART _volum_u_main_drv
; 0000 04F4 char i;
; 0000 04F5 
; 0000 04F6 if(bMAIN)
	ST   -Y,R17
;	i -> R17
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x285
; 0000 04F7 	{
; 0000 04F8 	if(Un<(UU_AVT-10))volum_u_main_+=5;
	CALL SUBOPT_0x53
	SBIW R30,10
	CALL SUBOPT_0x54
	BRSH _0x286
	CALL SUBOPT_0x55
	ADIW R30,5
	CALL SUBOPT_0x56
; 0000 04F9 	else if(Un<(UU_AVT-1))volum_u_main_++;
	RJMP _0x287
_0x286:
	CALL SUBOPT_0x53
	SBIW R30,1
	CALL SUBOPT_0x54
	BRSH _0x288
	LDI  R26,LOW(_volum_u_main_)
	LDI  R27,HIGH(_volum_u_main_)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	RJMP _0x3E0
; 0000 04FA 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
_0x288:
	CALL SUBOPT_0x53
	ADIW R30,10
	CALL SUBOPT_0x57
	BRSH _0x28A
	CALL SUBOPT_0x55
	SBIW R30,10
	CALL SUBOPT_0x56
; 0000 04FB 	else if(Un>(UU_AVT+1))volum_u_main_--;
	RJMP _0x28B
_0x28A:
	CALL SUBOPT_0x53
	ADIW R30,1
	CALL SUBOPT_0x57
	BRSH _0x28C
	LDI  R26,LOW(_volum_u_main_)
	LDI  R27,HIGH(_volum_u_main_)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
_0x3E0:
	ST   -X,R31
	ST   -X,R30
; 0000 04FC 	if(volum_u_main_>1020)volum_u_main_=1020;
_0x28C:
_0x28B:
_0x287:
	LDS  R26,_volum_u_main_
	LDS  R27,_volum_u_main_+1
	CPI  R26,LOW(0x3FD)
	LDI  R30,HIGH(0x3FD)
	CPC  R27,R30
	BRLT _0x28D
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	CALL SUBOPT_0x56
; 0000 04FD 	if(volum_u_main_<0)volum_u_main_=0;
_0x28D:
	LDS  R26,_volum_u_main_+1
	TST  R26
	BRPL _0x28E
	LDI  R30,LOW(0)
	STS  _volum_u_main_,R30
	STS  _volum_u_main_+1,R30
; 0000 04FE 	//volum_u_main_=700;
; 0000 04FF 
; 0000 0500 	i_main_sigma=0;
_0x28E:
	LDI  R30,LOW(0)
	STS  _i_main_sigma,R30
	STS  _i_main_sigma+1,R30
; 0000 0501 	i_main_num_of_bps=0;
	STS  _i_main_num_of_bps,R30
; 0000 0502 	for(i=0;i<6;i++)
	LDI  R17,LOW(0)
_0x290:
	CPI  R17,6
	BRSH _0x291
; 0000 0503 		{
; 0000 0504 		if(i_main_flag[i])
	CALL SUBOPT_0x58
	LD   R30,Z
	CPI  R30,0
	BREQ _0x292
; 0000 0505 			{
; 0000 0506 			i_main_sigma+=i_main[i];
	CALL SUBOPT_0x59
	LDS  R26,_i_main_sigma
	LDS  R27,_i_main_sigma+1
	ADD  R30,R26
	ADC  R31,R27
	STS  _i_main_sigma,R30
	STS  _i_main_sigma+1,R31
; 0000 0507 			i_main_flag[i]=1;
	CALL SUBOPT_0x58
	LDI  R26,LOW(1)
	STD  Z+0,R26
; 0000 0508 			i_main_num_of_bps++;
	LDS  R30,_i_main_num_of_bps
	SUBI R30,-LOW(1)
	STS  _i_main_num_of_bps,R30
; 0000 0509 			}
; 0000 050A 		else
	RJMP _0x293
_0x292:
; 0000 050B 			{
; 0000 050C 			i_main_flag[i]=0;
	CALL SUBOPT_0x58
	LDI  R26,LOW(0)
	STD  Z+0,R26
; 0000 050D 			}
_0x293:
; 0000 050E 		}
	SUBI R17,-1
	RJMP _0x290
_0x291:
; 0000 050F 	i_main_avg=i_main_sigma/i_main_num_of_bps;
	LDS  R30,_i_main_num_of_bps
	LDS  R26,_i_main_sigma
	LDS  R27,_i_main_sigma+1
	LDI  R31,0
	CALL __DIVW21
	STS  _i_main_avg,R30
	STS  _i_main_avg+1,R31
; 0000 0510 	for(i=0;i<6;i++)
	LDI  R17,LOW(0)
_0x295:
	CPI  R17,6
	BRLO PC+2
	RJMP _0x296
; 0000 0511 		{
; 0000 0512 		if(i_main_flag[i])
	CALL SUBOPT_0x58
	LD   R30,Z
	CPI  R30,0
	BREQ _0x297
; 0000 0513 			{
; 0000 0514 			if(i_main[i]<(i_main_avg-10))x[i]++;
	CALL SUBOPT_0x59
	MOVW R26,R30
	LDS  R30,_i_main_avg
	LDS  R31,_i_main_avg+1
	SBIW R30,10
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x298
	CALL SUBOPT_0x5A
	ADIW R30,1
	RJMP _0x3E1
; 0000 0515 			else if(i_main[i]>(i_main_avg+10))x[i]--;
_0x298:
	CALL SUBOPT_0x59
	MOVW R26,R30
	LDS  R30,_i_main_avg
	LDS  R31,_i_main_avg+1
	ADIW R30,10
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x29A
	CALL SUBOPT_0x5A
	SBIW R30,1
_0x3E1:
	ST   -X,R31
	ST   -X,R30
; 0000 0516 			if(x[i]>100)x[i]=100;
_0x29A:
	CALL SUBOPT_0x5B
	CALL __GETW1P
	CPI  R30,LOW(0x65)
	LDI  R26,HIGH(0x65)
	CPC  R31,R26
	BRLT _0x29B
	CALL SUBOPT_0x5B
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   X+,R30
	ST   X,R31
; 0000 0517 			if(x[i]<-100)x[i]=-100;
_0x29B:
	CALL SUBOPT_0x5B
	CALL __GETW1P
	CPI  R30,LOW(0xFF9C)
	LDI  R26,HIGH(0xFF9C)
	CPC  R31,R26
	BRGE _0x29C
	CALL SUBOPT_0x5B
	LDI  R30,LOW(65436)
	LDI  R31,HIGH(65436)
	ST   X+,R30
	ST   X,R31
; 0000 0518 			//if()
; 0000 0519 			}
_0x29C:
; 0000 051A 
; 0000 051B 		}
_0x297:
	SUBI R17,-1
	RJMP _0x295
_0x296:
; 0000 051C 	//plazma_int[2]=x[1];
; 0000 051D 	}
; 0000 051E }
_0x285:
_0x20C0001:
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;//Вычисление воздействий на силу
;//10Hz
;void pwr_hndl(void)
; 0000 0524 {
_pwr_hndl:
; .FSTART _pwr_hndl
; 0000 0525 if(ee_AVT_MODE==0x55)
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BRNE _0x29D
; 0000 0526 	{
; 0000 0527 /*	if(ee_Device==0x55)
; 0000 0528 		{
; 0000 0529 		pwm_u=0x3ff;
; 0000 052A 		pwm_i=0x3ff;
; 0000 052B 		bBL=0;
; 0000 052C 		}
; 0000 052D 	else
; 0000 052E  	if(ee_DEVICE)
; 0000 052F 		{
; 0000 0530 		pwm_u=0x00;
; 0000 0531 		pwm_i=0x00;
; 0000 0532 		bBL=1;
; 0000 0533 		}
; 0000 0534 	else */
; 0000 0535 		{
; 0000 0536 		if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE _0x29E
; 0000 0537 			{
; 0000 0538 			pwm_u=ee_U_AVT;
	CALL SUBOPT_0x29
	CALL SUBOPT_0x5C
; 0000 0539 			gran(&pwm_u,0,1020);
	CALL SUBOPT_0x5D
; 0000 053A 		    	//pwm_i=0x3ff;
; 0000 053B 			if(pwm_i<1020)
	BRSH _0x29F
; 0000 053C 				{
; 0000 053D 				pwm_i+=30;
	CALL SUBOPT_0x5E
; 0000 053E 				if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2A0
	CALL SUBOPT_0x5F
; 0000 053F 				}
_0x2A0:
; 0000 0540 			bBL=0;
_0x29F:
	CBI  0x1E,7
; 0000 0541 			bBL_IPS=0;
	IN   R30,0x2A
	CBR  R30,1
	RJMP _0x3E2
; 0000 0542 			}
; 0000 0543 		else if(flags&0b00001010)
_0x29E:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ _0x2A4
; 0000 0544 			{
; 0000 0545 			pwm_u=0;
	CALL SUBOPT_0x60
; 0000 0546 			pwm_i=0;
; 0000 0547 			bBL=1;
; 0000 0548 			bBL_IPS=1;
	IN   R30,0x2A
	SBR  R30,1
_0x3E2:
	OUT  0x2A,R30
; 0000 0549 			}
; 0000 054A 		}
_0x2A4:
; 0000 054B //pwm_u=950;
; 0000 054C //		pwm_i=950;
; 0000 054D 	}
; 0000 054E 
; 0000 054F else if(jp_mode==jp3)
	RJMP _0x2A7
_0x29D:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x2A8
; 0000 0550 	{
; 0000 0551 	if((flags&0b00001010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BRNE _0x2A9
; 0000 0552 		{
; 0000 0553 		pwm_u=500;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	CALL SUBOPT_0x61
; 0000 0554 		if(pwm_i<1020)
	BRSH _0x2AA
; 0000 0555 			{
; 0000 0556 			pwm_i+=30;
	CALL SUBOPT_0x5E
; 0000 0557 			if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2AB
	CALL SUBOPT_0x5F
; 0000 0558 			}
_0x2AB:
; 0000 0559 		bBL=0;
_0x2AA:
	CBI  0x1E,7
; 0000 055A 		}
; 0000 055B 	else if(flags&0b00001010)
	RJMP _0x2AE
_0x2A9:
	LDS  R30,_flags
	ANDI R30,LOW(0xA)
	BREQ _0x2AF
; 0000 055C 		{
; 0000 055D 		pwm_u=0;
	CALL SUBOPT_0x60
; 0000 055E 		pwm_i=0;
; 0000 055F 		bBL=1;
; 0000 0560 		}
; 0000 0561 
; 0000 0562 	}
_0x2AF:
_0x2AE:
; 0000 0563 else if(jp_mode==jp2)
	RJMP _0x2B2
_0x2A8:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x2)
	BRNE _0x2B3
; 0000 0564 	{
; 0000 0565 	pwm_u=0;
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
; 0000 0566 	//pwm_i=0x3ff;
; 0000 0567 	if(pwm_i<1020)
	CALL SUBOPT_0x62
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	BRSH _0x2B4
; 0000 0568 		{
; 0000 0569 		pwm_i+=30;
	CALL SUBOPT_0x5E
; 0000 056A 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2B5
	CALL SUBOPT_0x5F
; 0000 056B 		}
_0x2B5:
; 0000 056C 	bBL=0;
_0x2B4:
	CBI  0x1E,7
; 0000 056D 	}
; 0000 056E else if(jp_mode==jp1)
	RJMP _0x2B8
_0x2B3:
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x1)
	BRNE _0x2B9
; 0000 056F 	{
; 0000 0570 	pwm_u=0x3ff;
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	CALL SUBOPT_0x61
; 0000 0571 	//pwm_i=0x3ff;
; 0000 0572 	if(pwm_i<1020)
	BRSH _0x2BA
; 0000 0573 		{
; 0000 0574 		pwm_i+=30;
	CALL SUBOPT_0x5E
; 0000 0575 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2BB
	CALL SUBOPT_0x5F
; 0000 0576 		}
_0x2BB:
; 0000 0577 	bBL=0;
_0x2BA:
	CBI  0x1E,7
; 0000 0578 	}
; 0000 0579 
; 0000 057A else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
	RJMP _0x2BE
_0x2B9:
	IN   R30,0x2A
	SBRS R30,1
	RJMP _0x2C0
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ _0x2C1
_0x2C0:
	RJMP _0x2BF
_0x2C1:
; 0000 057B 	{
; 0000 057C 	pwm_u=volum_u_main_;
	CALL SUBOPT_0x55
	CALL SUBOPT_0x61
; 0000 057D 	//pwm_i=0x3ff;
; 0000 057E 	if(pwm_i<1020)
	BRSH _0x2C2
; 0000 057F 		{
; 0000 0580 		pwm_i+=30;
	CALL SUBOPT_0x5E
; 0000 0581 		if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2C3
	CALL SUBOPT_0x5F
; 0000 0582 		}
_0x2C3:
; 0000 0583 	bBL_IPS=0;
_0x2C2:
	IN   R30,0x2A
	CBR  R30,1
	OUT  0x2A,R30
; 0000 0584 	}
; 0000 0585 
; 0000 0586 else if(link==OFF)
	RJMP _0x2C4
_0x2BF:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BRNE _0x2C5
; 0000 0587 	{
; 0000 0588 /*	if(ee_Device==0x55)
; 0000 0589 		{
; 0000 058A 		pwm_u=0x3ff;
; 0000 058B 		pwm_i=0x3ff;
; 0000 058C 		bBL=0;
; 0000 058D 		}
; 0000 058E 	else*/
; 0000 058F  	if(ee_DEVICE)
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0x2C6
; 0000 0590 		{
; 0000 0591 		pwm_u=0x00;
	CALL SUBOPT_0x60
; 0000 0592 		pwm_i=0x00;
; 0000 0593 		bBL=1;
; 0000 0594 		}
; 0000 0595 	else
	RJMP _0x2C9
_0x2C6:
; 0000 0596 		{
; 0000 0597 		if((flags&0b00011010)==0)
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BRNE _0x2CA
; 0000 0598 			{
; 0000 0599 			pwm_u=ee_U_AVT;
	CALL SUBOPT_0x29
	CALL SUBOPT_0x5C
; 0000 059A 			gran(&pwm_u,0,1020);
	CALL SUBOPT_0x5D
; 0000 059B 		    	//pwm_i=0x3ff;
; 0000 059C 			if(pwm_i<1020)
	BRSH _0x2CB
; 0000 059D 				{
; 0000 059E 				pwm_i+=30;
	CALL SUBOPT_0x5E
; 0000 059F 				if(pwm_i>1020)pwm_i=1020;
	BRLO _0x2CC
	CALL SUBOPT_0x5F
; 0000 05A0 				}
_0x2CC:
; 0000 05A1 			bBL=0;
_0x2CB:
	CBI  0x1E,7
; 0000 05A2 			bBL_IPS=0;
	IN   R30,0x2A
	CBR  R30,1
	RJMP _0x3E3
; 0000 05A3 			}
; 0000 05A4 		else if(flags&0b00011010)
_0x2CA:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2D0
; 0000 05A5 			{
; 0000 05A6 			pwm_u=0;
	CALL SUBOPT_0x60
; 0000 05A7 			pwm_i=0;
; 0000 05A8 			bBL=1;
; 0000 05A9 			bBL_IPS=1;
	IN   R30,0x2A
	SBR  R30,1
_0x3E3:
	OUT  0x2A,R30
; 0000 05AA 			}
; 0000 05AB 		}
_0x2D0:
_0x2C9:
; 0000 05AC //pwm_u=950;
; 0000 05AD //		pwm_i=950;
; 0000 05AE 	}
; 0000 05AF 
; 0000 05B0 
; 0000 05B1 
; 0000 05B2 else	if(link==ON)				//если есть связьvol_i_temp_avar
	RJMP _0x2D3
_0x2C5:
	LDS  R26,_link
	CPI  R26,LOW(0x55)
	BREQ PC+2
	RJMP _0x2D4
; 0000 05B3 	{
; 0000 05B4 	if((flags&0b00100000)==0)	//если нет блокировки извне
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ PC+2
	RJMP _0x2D5
; 0000 05B5 		{
; 0000 05B6 		if(((flags&0b00011110)==0b00000100)) 	//если нет аварий или если они заблокированы
	LDS  R30,_flags
	ANDI R30,LOW(0x1E)
	CPI  R30,LOW(0x4)
	BRNE _0x2D6
; 0000 05B7 			{
; 0000 05B8 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
	CALL SUBOPT_0x63
; 0000 05B9 			if(!ee_DEVICE)
	SBIW R30,0
	BRNE _0x2D7
; 0000 05BA 				{
; 0000 05BB 				if(pwm_i<vol_i_temp_avar)pwm_i+=vol_i_temp_avar/30;
	CALL SUBOPT_0x64
	CALL SUBOPT_0x62
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x2D8
	LDS  R26,_vol_i_temp_avar
	LDS  R27,_vol_i_temp_avar+1
	CALL SUBOPT_0x65
	RJMP _0x3E4
; 0000 05BC 				else	pwm_i=vol_i_temp_avar;
_0x2D8:
	CALL SUBOPT_0x64
_0x3E4:
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05BD 				}
; 0000 05BE 			else pwm_i=vol_i_temp_avar;
	RJMP _0x2DA
_0x2D7:
	CALL SUBOPT_0x64
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05BF 
; 0000 05C0 			bBL=0;
_0x2DA:
	CBI  0x1E,7
; 0000 05C1 			}
; 0000 05C2 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
_0x2D6:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2DE
	LDS  R30,_flags
	ANDI R30,LOW(0x40)
	BREQ _0x2DD
_0x2DE:
; 0000 05C3 			{
; 0000 05C4 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
	CALL SUBOPT_0x63
; 0000 05C5 		    	//pwm_i=vol_i_temp;
; 0000 05C6 			if(!ee_DEVICE)
	SBIW R30,0
	BRNE _0x2E0
; 0000 05C7 				{
; 0000 05C8 				if(pwm_i<vol_i_temp)pwm_i+=vol_i_temp/30;
	CALL SUBOPT_0x66
	CALL SUBOPT_0x62
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x2E1
	LDS  R26,_vol_i_temp
	LDS  R27,_vol_i_temp+1
	CALL SUBOPT_0x65
	RJMP _0x3E5
; 0000 05C9 				else	pwm_i=vol_i_temp;
_0x2E1:
	CALL SUBOPT_0x66
_0x3E5:
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05CA 				}
; 0000 05CB 			else pwm_i=vol_i_temp;
	RJMP _0x2E3
_0x2E0:
	CALL SUBOPT_0x66
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
; 0000 05CC 			bBL=0;
_0x2E3:
	CBI  0x1E,7
; 0000 05CD 			}
; 0000 05CE 		else if(flags&0b00011010)					//если есть аварии
	RJMP _0x2E6
_0x2DD:
	LDS  R30,_flags
	ANDI R30,LOW(0x1A)
	BREQ _0x2E7
; 0000 05CF 			{
; 0000 05D0 			pwm_u=0;								//то полный стоп
	CALL SUBOPT_0x60
; 0000 05D1 			pwm_i=0;
; 0000 05D2 			bBL=1;
; 0000 05D3 			}
; 0000 05D4 		}
_0x2E7:
_0x2E6:
; 0000 05D5 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
	RJMP _0x2EA
_0x2D5:
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x2EB
; 0000 05D6 		{
; 0000 05D7 		pwm_u=0;
	CALL SUBOPT_0x60
; 0000 05D8 	    	pwm_i=0;
; 0000 05D9 		bBL=1;
; 0000 05DA 		}
; 0000 05DB /*pwm_u=950;
; 0000 05DC 		pwm_i=950;*/
; 0000 05DD 	}
_0x2EB:
_0x2EA:
; 0000 05DE //pwm_u=vol_u_temp;
; 0000 05DF }
_0x2D4:
_0x2D3:
_0x2C4:
_0x2BE:
_0x2B8:
_0x2B2:
_0x2A7:
	RET
; .FEND
;
;//-----------------------------------------------
;//Воздействие на силу
;//5Hz
;void pwr_drv(void)
; 0000 05E5 {
_pwr_drv:
; .FSTART _pwr_drv
; 0000 05E6 /*GPIOB->DDR|=(1<<2);
; 0000 05E7 GPIOB->CR1|=(1<<2);
; 0000 05E8 GPIOB->CR2&=~(1<<2);*/
; 0000 05E9 BLOCK_INIT
	SBI  0xA,4
; 0000 05EA 
; 0000 05EB if(main_cnt1<1500)main_cnt1++;
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CPI  R26,LOW(0x5DC)
	LDI  R30,HIGH(0x5DC)
	CPC  R27,R30
	BRGE _0x2F0
	LDI  R26,LOW(_main_cnt1)
	LDI  R27,HIGH(_main_cnt1)
	CALL SUBOPT_0x28
; 0000 05EC 
; 0000 05ED if((main_cnt1<25)&&(ee_DEVICE))
_0x2F0:
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	SBIW R26,25
	BRGE _0x2F2
	CALL SUBOPT_0x24
	SBIW R30,0
	BRNE _0x2F3
_0x2F2:
	RJMP _0x2F1
_0x2F3:
; 0000 05EE 	{
; 0000 05EF 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3E6
; 0000 05F0 	}
; 0000 05F1 else if((ee_DEVICE))
_0x2F1:
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0x2F7
; 0000 05F2 	{
; 0000 05F3 	if(bBL)
	SBIS 0x1E,7
	RJMP _0x2F8
; 0000 05F4 		{
; 0000 05F5 		BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3E7
; 0000 05F6 		}
; 0000 05F7 	else if(!bBL)
_0x2F8:
	SBIC 0x1E,7
	RJMP _0x2FC
; 0000 05F8 		{
; 0000 05F9 		BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3E7:
	STS  _bVENT_BLOCK,R30
; 0000 05FA 		}
; 0000 05FB 	}
_0x2FC:
; 0000 05FC else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
	RJMP _0x2FF
_0x2F7:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x301
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x302
_0x301:
	RJMP _0x300
_0x302:
; 0000 05FD 	{
; 0000 05FE 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3E6
; 0000 05FF 	//GPIOB->ODR|=(1<<2);
; 0000 0600 	}
; 0000 0601 else if(bps_class==bpsIPS)
_0x300:
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BRNE _0x306
; 0000 0602 		{
; 0000 0603 //GPIOB->ODR|=(1<<2);
; 0000 0604 		if(bBL_IPS)
	IN   R30,0x2A
	SBRS R30,0
	RJMP _0x307
; 0000 0605 			{
; 0000 0606 			 BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3E8
; 0000 0607 			//GPIOB->ODR|=(1<<2);
; 0000 0608 			}
; 0000 0609 		else if(!bBL_IPS)
_0x307:
	IN   R30,0x2A
	SBRC R30,0
	RJMP _0x30B
; 0000 060A 			{
; 0000 060B 			  BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3E8:
	STS  _bVENT_BLOCK,R30
; 0000 060C 			//GPIOB->ODR&=~(1<<2);
; 0000 060D 			}
; 0000 060E 		}
_0x30B:
; 0000 060F else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
	RJMP _0x30E
_0x306:
	CALL SUBOPT_0x25
	CALL SUBOPT_0x46
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x310
	CALL SUBOPT_0x4C
	BRLT _0x311
_0x310:
	RJMP _0x30F
_0x311:
; 0000 0610 	{
; 0000 0611 	if(bps_class==bpsIPS)
	LDS  R26,_bps_class
	CPI  R26,LOW(0x1)
	BREQ _0x3E9
; 0000 0612 		{
; 0000 0613 		  BLOCK_OFF
; 0000 0614 		//GPIOB->ODR&=~(1<<2);
; 0000 0615 		}
; 0000 0616 	else if(bps_class==bpsIBEP)
	LDS  R30,_bps_class
	CPI  R30,0
	BRNE _0x316
; 0000 0617 		{
; 0000 0618 		if(ee_DEVICE)
	CALL SUBOPT_0x24
	SBIW R30,0
	BREQ _0x317
; 0000 0619 			{
; 0000 061A 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
	LDS  R30,_flags
	ANDI R30,LOW(0x20)
	BREQ _0x318
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3EA
; 0000 061B 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
_0x318:
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3EA:
	STS  _bVENT_BLOCK,R30
; 0000 061C 			}
; 0000 061D 		else
	RJMP _0x31E
_0x317:
; 0000 061E 			{
; 0000 061F 			BLOCK_OFF
_0x3E9:
	CBI  0xB,4
	LDI  R30,LOW(0)
	STS  _bVENT_BLOCK,R30
; 0000 0620 			//GPIOB->ODR&=~(1<<2);
; 0000 0621 			}
_0x31E:
; 0000 0622 		}
; 0000 0623 	}
_0x316:
; 0000 0624 else if(bBL)
	RJMP _0x321
_0x30F:
	SBIS 0x1E,7
	RJMP _0x322
; 0000 0625 	{
; 0000 0626 	BLOCK_ON
	SBI  0xB,4
	LDI  R30,LOW(1)
	RJMP _0x3E6
; 0000 0627 	//GPIOB->ODR|=(1<<2);
; 0000 0628 	}
; 0000 0629 else if(!bBL)
_0x322:
	SBIC 0x1E,7
	RJMP _0x326
; 0000 062A 	{
; 0000 062B 	BLOCK_OFF
	CBI  0xB,4
	LDI  R30,LOW(0)
_0x3E6:
	STS  _bVENT_BLOCK,R30
; 0000 062C 	//GPIOB->ODR&=~(1<<2);
; 0000 062D 	}
; 0000 062E 
; 0000 062F //pwm_u=800;
; 0000 0630 //pwm_u=400;
; 0000 0631 
; 0000 0632 gran(&pwm_u,1,1020);
_0x326:
_0x321:
_0x30E:
_0x2FF:
	LDI  R30,LOW(_pwm_u)
	LDI  R31,HIGH(_pwm_u)
	CALL SUBOPT_0x67
; 0000 0633 gran(&pwm_i,1,1020);
	LDI  R30,LOW(_pwm_i)
	LDI  R31,HIGH(_pwm_i)
	CALL SUBOPT_0x67
; 0000 0634 
; 0000 0635 if(ee_AVT_MODE!=0x55)
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x329
; 0000 0636     {
; 0000 0637     if((ee_DEVICE==0)&&(main_cnt1<(5*(ee_TZAS+10))))pwm_u=10;
	CALL SUBOPT_0x24
	SBIW R30,0
	BRNE _0x32B
	CALL SUBOPT_0x25
	ADIW R30,10
	CALL SUBOPT_0x46
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x32C
_0x32B:
	RJMP _0x32A
_0x32C:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x5C
; 0000 0638     }
_0x32A:
; 0000 0639 
; 0000 063A //pwm_u=1000;
; 0000 063B //pwm_i=1000;
; 0000 063C 
; 0000 063D //GPIOB->ODR|=(1<<3);
; 0000 063E 
; 0000 063F //pwm_u=100;
; 0000 0640 //pwm_i=400;
; 0000 0641 //vent_pwm=200;
; 0000 0642 
; 0000 0643 
; 0000 0644 OCR1AH= (char)(pwm_u/256);
_0x329:
	LDS  R30,_pwm_u+1
	STS  137,R30
; 0000 0645 OCR1AL= (char)pwm_u;
	LDS  R30,_pwm_u
	STS  136,R30
; 0000 0646 
; 0000 0647 OCR1BH= (char)(pwm_i/256);
	LDS  R30,_pwm_i+1
	STS  139,R30
; 0000 0648 OCR1BL= (char)pwm_i;
	LDS  R30,_pwm_i
	STS  138,R30
; 0000 0649 /*
; 0000 064A TIM1->CCR1H= (char)(pwm_i/256);
; 0000 064B TIM1->CCR1L= (char)pwm_i;
; 0000 064C 
; 0000 064D TIM1->CCR3H= (char)(vent_pwm/256);
; 0000 064E TIM1->CCR3L= (char)vent_pwm;*/
; 0000 064F 
; 0000 0650 //OCR1AL= 260;//pwm_u;
; 0000 0651 //OCR1B= 0;//pwm_i;
; 0000 0652 
; 0000 0653 OCR2B=(char)(vent_pwm/4);
	CALL SUBOPT_0x51
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __DIVW21
	STS  180,R30
; 0000 0654 
; 0000 0655 }
	RET
; .FEND
;
;//-----------------------------------------------
;void pwr_hndl_(void)
; 0000 0659 {
; 0000 065A //vol_u_temp=800;
; 0000 065B if(jp_mode==jp3)
; 0000 065C 	{
; 0000 065D 	if((flags&0b00001010)==0)
; 0000 065E 		{
; 0000 065F 		pwm_u=500;
; 0000 0660 		//pwm_i=0x3ff;
; 0000 0661 		bBL=0;
; 0000 0662 		}
; 0000 0663 	else if(flags&0b00001010)
; 0000 0664 		{
; 0000 0665 		pwm_u=0;
; 0000 0666 		//pwm_i=0;
; 0000 0667 		bBL=1;
; 0000 0668 		}
; 0000 0669 
; 0000 066A 	}
; 0000 066B else if(jp_mode==jp2)
; 0000 066C 	{
; 0000 066D 	pwm_u=0;
; 0000 066E 	//pwm_i=0x3ff;
; 0000 066F 	bBL=0;
; 0000 0670 	}
; 0000 0671 else if(jp_mode==jp1)
; 0000 0672 	{
; 0000 0673 	pwm_u=0x3ff;
; 0000 0674 	//pwm_i=0x3ff;
; 0000 0675 	bBL=0;
; 0000 0676 	}
; 0000 0677 
; 0000 0678 else if(link==OFF)
; 0000 0679 	{
; 0000 067A 	if((flags&0b00011010)==0)
; 0000 067B 		{
; 0000 067C 		pwm_u=ee_U_AVT;
; 0000 067D 		gran(&pwm_u,0,1020);
; 0000 067E 	    //	pwm_i=0x3ff;
; 0000 067F 		bBL=0;
; 0000 0680 		}
; 0000 0681 	else if(flags&0b00011010)
; 0000 0682 		{
; 0000 0683 		pwm_u=0;
; 0000 0684 		//pwm_i=0;
; 0000 0685 		bBL=1;
; 0000 0686 		}
; 0000 0687 	}
; 0000 0688 
; 0000 0689 else	if(link==ON)
; 0000 068A 	{
; 0000 068B 	if((flags&0b00100000)==0)
; 0000 068C 		{
; 0000 068D 		if(((flags&0b00011010)==0)||(flags&0b01000000))
; 0000 068E 			{
; 0000 068F 			pwm_u=vol_u_temp+_x_;
; 0000 0690 		    //	pwm_i=0x3ff;
; 0000 0691 			bBL=0;
; 0000 0692 			}
; 0000 0693 		else if(flags&0b00011010)
; 0000 0694 			{
; 0000 0695 			pwm_u=0;
; 0000 0696 			//pwm_i=0;
; 0000 0697 			bBL=1;
; 0000 0698 			}
; 0000 0699 		}
; 0000 069A 	else if(flags&0b00100000)
; 0000 069B 		{
; 0000 069C 		pwm_u=0;
; 0000 069D 	    //	pwm_i=0;
; 0000 069E 		bBL=1;
; 0000 069F 		}
; 0000 06A0 	}
; 0000 06A1 //pwm_u=vol_u_temp;
; 0000 06A2 }
;
;//-----------------------------------------------
;void JP_drv(void)
; 0000 06A6 {
_JP_drv:
; .FSTART _JP_drv
; 0000 06A7 
; 0000 06A8 DDRB.6=1;
	SBI  0x4,6
; 0000 06A9 DDRB.7=1;
	SBI  0x4,7
; 0000 06AA PORTB.6=1;
	SBI  0x5,6
; 0000 06AB PORTB.7=1;
	SBI  0x5,7
; 0000 06AC 
; 0000 06AD if(PINB.6)
	SBIS 0x3,6
	RJMP _0x35E
; 0000 06AE 	{
; 0000 06AF 	if(cnt_JP0<10)
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRSH _0x35F
; 0000 06B0 		{
; 0000 06B1 		cnt_JP0++;
	LDS  R30,_cnt_JP0
	SUBI R30,-LOW(1)
	STS  _cnt_JP0,R30
; 0000 06B2 		}
; 0000 06B3 	}
_0x35F:
; 0000 06B4 else if(!PINB.6)
	RJMP _0x360
_0x35E:
	SBIC 0x3,6
	RJMP _0x361
; 0000 06B5 	{
; 0000 06B6 	if(cnt_JP0)
	LDS  R30,_cnt_JP0
	CPI  R30,0
	BREQ _0x362
; 0000 06B7 		{
; 0000 06B8 		cnt_JP0--;
	SUBI R30,LOW(1)
	STS  _cnt_JP0,R30
; 0000 06B9 		}
; 0000 06BA 	}
_0x362:
; 0000 06BB 
; 0000 06BC if(PINB.7)
_0x361:
_0x360:
	SBIS 0x3,7
	RJMP _0x363
; 0000 06BD 	{
; 0000 06BE 	if(cnt_JP1<10)
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BRSH _0x364
; 0000 06BF 		{
; 0000 06C0 		cnt_JP1++;
	LDS  R30,_cnt_JP1
	SUBI R30,-LOW(1)
	STS  _cnt_JP1,R30
; 0000 06C1 		}
; 0000 06C2 	}
_0x364:
; 0000 06C3 else if(!PINB.7)
	RJMP _0x365
_0x363:
	SBIC 0x3,7
	RJMP _0x366
; 0000 06C4 	{
; 0000 06C5 	if(cnt_JP1)
	LDS  R30,_cnt_JP1
	CPI  R30,0
	BREQ _0x367
; 0000 06C6 		{
; 0000 06C7 		cnt_JP1--;
	SUBI R30,LOW(1)
	STS  _cnt_JP1,R30
; 0000 06C8 		}
; 0000 06C9 	}
_0x367:
; 0000 06CA 
; 0000 06CB 
; 0000 06CC if((cnt_JP0==10)&&(cnt_JP1==10))
_0x366:
_0x365:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x369
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x36A
_0x369:
	RJMP _0x368
_0x36A:
; 0000 06CD 	{
; 0000 06CE 	jp_mode=jp0;
	LDI  R30,LOW(0)
	STS  _jp_mode,R30
; 0000 06CF 	}
; 0000 06D0 if((cnt_JP0==0)&&(cnt_JP1==10))
_0x368:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x36C
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0xA)
	BREQ _0x36D
_0x36C:
	RJMP _0x36B
_0x36D:
; 0000 06D1 	{
; 0000 06D2 	jp_mode=jp1;
	LDI  R30,LOW(1)
	STS  _jp_mode,R30
; 0000 06D3 	}
; 0000 06D4 if((cnt_JP0==10)&&(cnt_JP1==0))
_0x36B:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0xA)
	BRNE _0x36F
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x370
_0x36F:
	RJMP _0x36E
_0x370:
; 0000 06D5 	{
; 0000 06D6 	jp_mode=jp2;
	LDI  R30,LOW(2)
	STS  _jp_mode,R30
; 0000 06D7 	}
; 0000 06D8 if((cnt_JP0==0)&&(cnt_JP1==0))
_0x36E:
	LDS  R26,_cnt_JP0
	CPI  R26,LOW(0x0)
	BRNE _0x372
	LDS  R26,_cnt_JP1
	CPI  R26,LOW(0x0)
	BREQ _0x373
_0x372:
	RJMP _0x371
_0x373:
; 0000 06D9 	{
; 0000 06DA 	jp_mode=jp3;
	LDI  R30,LOW(3)
	STS  _jp_mode,R30
; 0000 06DB 	}
; 0000 06DC 
; 0000 06DD }
_0x371:
	RET
; .FEND
;
;//-----------------------------------------------
;void adc_hndl(void)
; 0000 06E1 {
_adc_hndl:
; .FSTART _adc_hndl
; 0000 06E2 unsigned tempUI;
; 0000 06E3 tempUI=ADCW;
	ST   -Y,R17
	ST   -Y,R16
;	tempUI -> R16,R17
	__GETWRMN 16,17,0,120
; 0000 06E4 adc_buff[adc_ch][adc_cnt]=tempUI;
	CALL SUBOPT_0x68
	MOVW R26,R30
	LDS  R30,_adc_cnt
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R16
	STD  Z+1,R17
; 0000 06E5 /*if(adc_ch==2)
; 0000 06E6 	{
; 0000 06E7 	if(tempUI>adc_ch_2_max)adc_ch_2_max=tempUI;
; 0000 06E8 	else if(tempUI<adc_ch_2_min)adc_ch_2_min=tempUI;
; 0000 06E9 	}  */
; 0000 06EA 
; 0000 06EB if((adc_cnt&0x03)==0)
	LDS  R30,_adc_cnt
	ANDI R30,LOW(0x3)
	BRNE _0x374
; 0000 06EC 	{
; 0000 06ED 	char i;
; 0000 06EE 	adc_buff_[adc_ch]=0;
	SBIW R28,1
;	i -> Y+0
	CALL SUBOPT_0x69
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
; 0000 06EF 	for(i=0;i<16;i++)
	ST   Y,R30
_0x376:
	LD   R26,Y
	CPI  R26,LOW(0x10)
	BRSH _0x377
; 0000 06F0 		{
; 0000 06F1 		adc_buff_[adc_ch]+=adc_buff[adc_ch][i];
	CALL SUBOPT_0x69
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	LD   R0,Z
	LDD  R1,Z+1
	CALL SUBOPT_0x68
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
; 0000 06F2 		}
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RJMP _0x376
_0x377:
; 0000 06F3 	adc_buff_[adc_ch]>>=4;
	CALL SUBOPT_0x69
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X+
	LD   R31,X+
	CALL __LSRW4
	ST   -X,R31
	ST   -X,R30
; 0000 06F4     //adc_buff_[adc_ch]=(adc_ch+1)*100;
; 0000 06F5 	}
	ADIW R28,1
; 0000 06F6 
; 0000 06F7 if(++adc_ch>=5)
_0x374:
	LDS  R26,_adc_ch
	SUBI R26,-LOW(1)
	STS  _adc_ch,R26
	CPI  R26,LOW(0x5)
	BRLO _0x378
; 0000 06F8 	{
; 0000 06F9 	adc_ch=0;
	LDI  R30,LOW(0)
	STS  _adc_ch,R30
; 0000 06FA 	if(++adc_cnt>=16)
	LDS  R26,_adc_cnt
	SUBI R26,-LOW(1)
	STS  _adc_cnt,R26
	CPI  R26,LOW(0x10)
	BRLO _0x379
; 0000 06FB 		{
; 0000 06FC 		adc_cnt=0;
	STS  _adc_cnt,R30
; 0000 06FD 		}
; 0000 06FE 	}
_0x379:
; 0000 06FF DDRC&=0b11000000;
_0x378:
	IN   R30,0x7
	ANDI R30,LOW(0xC0)
	OUT  0x7,R30
; 0000 0700 PORTC&=0b11000000;
	IN   R30,0x8
	ANDI R30,LOW(0xC0)
	OUT  0x8,R30
; 0000 0701 
; 0000 0702 if(adc_ch==0)       ADMUX=0b00000001; //ток
	LDS  R30,_adc_ch
	CPI  R30,0
	BRNE _0x37A
	LDI  R30,LOW(1)
	RJMP _0x3EB
; 0000 0703 else if(adc_ch==1)  ADMUX=0b00000100; //напр ист
_0x37A:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x1)
	BRNE _0x37C
	LDI  R30,LOW(4)
	RJMP _0x3EB
; 0000 0704 else if(adc_ch==2)  ADMUX=0b00000010; //напр нагр
_0x37C:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x2)
	BRNE _0x37E
	LDI  R30,LOW(2)
	RJMP _0x3EB
; 0000 0705 else if(adc_ch==3)  ADMUX=0b00000011; //темпер
_0x37E:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x3)
	BRNE _0x380
	LDI  R30,LOW(3)
	RJMP _0x3EB
; 0000 0706 else if(adc_ch==4)  ADMUX=0b00000101; //доп
_0x380:
	LDS  R26,_adc_ch
	CPI  R26,LOW(0x4)
	BRNE _0x382
	LDI  R30,LOW(5)
_0x3EB:
	STS  124,R30
; 0000 0707 
; 0000 0708 
; 0000 0709 ADCSRA=0b10100110;
_0x382:
	LDI  R30,LOW(166)
	STS  122,R30
; 0000 070A ADCSRA|=0b01000000;
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 070B 
; 0000 070C }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;//-----------------------------------------------
;void matemat(void)
; 0000 0710 {
_matemat:
; .FSTART _matemat
; 0000 0711 signed long temp_SL;
; 0000 0712 
; 0000 0713 #ifdef _220_
; 0000 0714 temp_SL=adc_buff_[0];
	SBIW R28,4
;	temp_SL -> Y+0
	CALL SUBOPT_0x11
	CALL SUBOPT_0x6A
; 0000 0715 temp_SL-=K[0][0];
	LDI  R26,LOW(_K)
	LDI  R27,HIGH(_K)
	CALL __EEPROMRDW
	CALL SUBOPT_0x6B
	CALL __SUBD21
	CALL __PUTD2S0
; 0000 0716 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x383
	CALL SUBOPT_0x6C
; 0000 0717 temp_SL*=K[0][1];
_0x383:
	CALL SUBOPT_0x13
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6D
; 0000 0718 temp_SL/=2400;
	__GETD1N 0x960
	CALL SUBOPT_0x6E
; 0000 0719 I=(signed int)temp_SL;
	STS  _I,R30
	STS  _I+1,R31
; 0000 071A #else
; 0000 071B 
; 0000 071C #ifdef _24_
; 0000 071D temp_SL=adc_buff_[0];
; 0000 071E temp_SL-=K[0][0];
; 0000 071F if(temp_SL<0) temp_SL=0;
; 0000 0720 temp_SL*=K[0][1];
; 0000 0721 temp_SL/=800;
; 0000 0722 I=(signed int)temp_SL;
; 0000 0723 #else
; 0000 0724 temp_SL=adc_buff_[0];
; 0000 0725 temp_SL-=K[0][0];
; 0000 0726 if(temp_SL<0) temp_SL=0;
; 0000 0727 temp_SL*=K[0][1];
; 0000 0728 temp_SL/=1200;
; 0000 0729 I=(signed int)temp_SL;
; 0000 072A #endif
; 0000 072B #endif
; 0000 072C 
; 0000 072D //I=adc_buff_[0];
; 0000 072E 
; 0000 072F temp_SL=adc_buff_[1];
	__GETW1MN _adc_buff_,2
	CALL SUBOPT_0x6A
; 0000 0730 //temp_SL-=K[1,0];
; 0000 0731 if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x384
	CALL SUBOPT_0x6C
; 0000 0732 temp_SL*=K[2][1];
_0x384:
	CALL SUBOPT_0x18
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6D
; 0000 0733 temp_SL/=1000;
	CALL SUBOPT_0x6F
; 0000 0734 Ui=(unsigned)temp_SL;
	STS  _Ui,R30
	STS  _Ui+1,R31
; 0000 0735 
; 0000 0736 //Ui=K[2][1];
; 0000 0737 
; 0000 0738 
; 0000 0739 temp_SL=adc_buff_[2];
	__GETW1MN _adc_buff_,4
	CALL SUBOPT_0x6A
; 0000 073A //temp_SL-=K[2,0];
; 0000 073B if(temp_SL<0) temp_SL=0;
	LDD  R26,Y+3
	TST  R26
	BRPL _0x385
	CALL SUBOPT_0x6C
; 0000 073C temp_SL*=K[1][1];
_0x385:
	CALL SUBOPT_0x17
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6D
; 0000 073D temp_SL/=1000;
	CALL SUBOPT_0x6F
; 0000 073E Un=(unsigned)temp_SL;
	STS  _Un,R30
	STS  _Un+1,R31
; 0000 073F //Un=K[1][1];
; 0000 0740 
; 0000 0741 temp_SL=adc_buff_[3];
	__GETW1MN _adc_buff_,6
	CALL SUBOPT_0x6A
; 0000 0742 temp_SL*=K[3][1];
	CALL SUBOPT_0x19
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6D
; 0000 0743 temp_SL/=1326;
	__GETD1N 0x52E
	CALL SUBOPT_0x6E
; 0000 0744 T=(signed)(temp_SL-273);
	SUBI R30,LOW(273)
	SBCI R31,HIGH(273)
	STS  _T,R30
	STS  _T+1,R31
; 0000 0745 //T=TZAS;
; 0000 0746 
; 0000 0747 Udb=flags;
	LDS  R30,_flags
	LDI  R31,0
	STS  _Udb,R30
	STS  _Udb+1,R31
; 0000 0748 
; 0000 0749 
; 0000 074A 
; 0000 074B }
	ADIW R28,4
	RET
; .FEND
;
;//***********************************************
;//***********************************************
;//***********************************************
;//***********************************************
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0752 {
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
; 0000 0753 //DDRD.0=1;
; 0000 0754 //PORTD.0=1;
; 0000 0755 
; 0000 0756 //PORTD.1=0;
; 0000 0757 
; 0000 0758 t0_init();
	CALL _t0_init
; 0000 0759 
; 0000 075A can_hndl1();
	CALL _can_hndl1
; 0000 075B 
; 0000 075C if(++t0_cnt4>=10)
	INC  R11
	LDI  R30,LOW(10)
	CP   R11,R30
	BRLO _0x386
; 0000 075D 	{
; 0000 075E 	t0_cnt4=0;
	CLR  R11
; 0000 075F //	b100Hz=1;
; 0000 0760 
; 0000 0761 
; 0000 0762 if(++t0_cnt0>=10)
	INC  R7
	CP   R7,R30
	BRLO _0x387
; 0000 0763 	{
; 0000 0764 	t0_cnt0=0;
	CLR  R7
; 0000 0765 	b10Hz=1;
	SBI  0x1E,3
; 0000 0766 	}
; 0000 0767 if(++t0_cnt3>=3)
_0x387:
	INC  R8
	LDI  R30,LOW(3)
	CP   R8,R30
	BRLO _0x38A
; 0000 0768 	{
; 0000 0769 	t0_cnt3=0;
	CLR  R8
; 0000 076A 	b33Hz=1;
	SBI  0x1E,2
; 0000 076B 	}
; 0000 076C if(++t0_cnt1>=20)
_0x38A:
	INC  R6
	LDI  R30,LOW(20)
	CP   R6,R30
	BRLO _0x38D
; 0000 076D 	{
; 0000 076E 	t0_cnt1=0;
	CLR  R6
; 0000 076F 	b5Hz=1;
	SBI  0x1E,4
; 0000 0770      bFl_=!bFl_;
	SBIS 0x1E,6
	RJMP _0x390
	CBI  0x1E,6
	RJMP _0x391
_0x390:
	SBI  0x1E,6
_0x391:
; 0000 0771 	}
; 0000 0772 if(++t0_cnt2>=100)
_0x38D:
	INC  R9
	LDI  R30,LOW(100)
	CP   R9,R30
	BRLO _0x392
; 0000 0773 	{
; 0000 0774 	t0_cnt2=0;
	CLR  R9
; 0000 0775 	b1Hz=1;
	SBI  0x1E,5
; 0000 0776 	}
; 0000 0777 }
_0x392:
; 0000 0778 }
_0x386:
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
; 0000 0780 {
_main:
; .FSTART _main
; 0000 0781 //DDRD.0=1;
; 0000 0782 //PORTD.0=0;
; 0000 0783 //DDRD.1=1;
; 0000 0784 //PORTD.1=1;
; 0000 0785 
; 0000 0786 //while (1)
; 0000 0787 	//{
; 0000 0788     //}
; 0000 0789 
; 0000 078A ///DDRD.2=1;
; 0000 078B ///PORTD.2=1;
; 0000 078C 
; 0000 078D ///DDRB.0=1;
; 0000 078E ///PORTB.0=0;
; 0000 078F 
; 0000 0790 	PORTB.2=1;
	SBI  0x5,2
; 0000 0791 	DDRB.2=1;
	SBI  0x4,2
; 0000 0792 DDRB|=0b00110110;
	IN   R30,0x4
	ORI  R30,LOW(0x36)
	OUT  0x4,R30
; 0000 0793 
; 0000 0794 
; 0000 0795 
; 0000 0796 // Timer/Counter 1 initialization
; 0000 0797 // Clock source: System Clock
; 0000 0798 // Clock value: 8000.000 kHz
; 0000 0799 // Mode: Fast PWM top=0x03FF
; 0000 079A // OC1A output: Non-Inverted PWM
; 0000 079B // OC1B output: Non-Inverted PWM
; 0000 079C // Noise Canceler: Off
; 0000 079D // Input Capture on Falling Edge
; 0000 079E // Timer Period: 0.128 ms
; 0000 079F // Output Pulse(s):
; 0000 07A0 // OC1A Period: 0.128 ms Width: 0.032031 ms
; 0000 07A1 // OC1B Period: 0.128 ms Width: 0.032031 ms
; 0000 07A2 // Timer1 Overflow Interrupt: Off
; 0000 07A3 // Input Capture Interrupt: Off
; 0000 07A4 // Compare A Match Interrupt: Off
; 0000 07A5 // Compare B Match Interrupt: Off
; 0000 07A6 TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (1<<WGM11) | (1<<WGM10);
	LDI  R30,LOW(163)
	STS  128,R30
; 0000 07A7 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
	LDI  R30,LOW(9)
	STS  129,R30
; 0000 07A8 
; 0000 07A9 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 07AA TCNT1L=0x00;
	STS  132,R30
; 0000 07AB ICR1H=0x00;
	STS  135,R30
; 0000 07AC ICR1L=0x00;
	STS  134,R30
; 0000 07AD OCR1AH=0x00;
	STS  137,R30
; 0000 07AE OCR1AL=0x00;
	STS  136,R30
; 0000 07AF OCR1BH=0x00;
	STS  139,R30
; 0000 07B0 OCR1BL=0x00;
	STS  138,R30
; 0000 07B1 
; 0000 07B2 DDRB.1=1;
	SBI  0x4,1
; 0000 07B3 DDRB.2=1;
	SBI  0x4,2
; 0000 07B4 
; 0000 07B5 
; 0000 07B6 // Timer/Counter 2 initialization
; 0000 07B7 // Clock source: System Clock
; 0000 07B8 // Clock value: 8000.000 kHz
; 0000 07B9 // Mode: Fast PWM top=0xFF
; 0000 07BA // OC2A output: Disconnected
; 0000 07BB // OC2B output: Non-Inverted PWM
; 0000 07BC // Timer Period: 0.032 ms
; 0000 07BD // Output Pulse(s):
; 0000 07BE // OC2B Period: 0.032 ms Width: 6.0235 us
; 0000 07BF ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 07C0 TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (1<<COM2B1) | (0<<COM2B0) | (1<<WGM21) | (1<<WGM20);
	LDI  R30,LOW(35)
	STS  176,R30
; 0000 07C1 TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (1<<CS20);
	LDI  R30,LOW(1)
	STS  177,R30
; 0000 07C2 TCNT2=0x00;
	LDI  R30,LOW(0)
	STS  178,R30
; 0000 07C3 OCR2A=0x00;
	STS  179,R30
; 0000 07C4 OCR2B=0x30;
	LDI  R30,LOW(48)
	STS  180,R30
; 0000 07C5 
; 0000 07C6 DDRD.3=1;
	SBI  0xA,3
; 0000 07C7 
; 0000 07C8 /*
; 0000 07C9 
; 0000 07CA TCCR1A=0x83;
; 0000 07CB TCCR1B=0x09;
; 0000 07CC TCNT1H=0x00;
; 0000 07CD TCNT1L=0x00;
; 0000 07CE OCR1AH=0x00;
; 0000 07CF OCR1AL=0x00;
; 0000 07D0 OCR1BH=0x00;
; 0000 07D1 OCR1BL=0x00;  */
; 0000 07D2 
; 0000 07D3 SPCR=0x5D;
	LDI  R30,LOW(93)
	OUT  0x2C,R30
; 0000 07D4 SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 07D5 /*delay_ms(100);
; 0000 07D6 delay_ms(100);
; 0000 07D7 delay_ms(100);
; 0000 07D8 delay_ms(100);
; 0000 07D9 delay_ms(100);
; 0000 07DA delay_ms(100);
; 0000 07DB delay_ms(100);
; 0000 07DC delay_ms(100);
; 0000 07DD delay_ms(100);
; 0000 07DE delay_ms(100);*/
; 0000 07DF ///delay_ms(100);
; 0000 07E0 ///delay_ms(100);
; 0000 07E1 ///delay_ms(100);
; 0000 07E2 ///delay_ms(100);
; 0000 07E3 ///delay_ms(100);
; 0000 07E4 ///adr_hndl();
; 0000 07E5 
; 0000 07E6 ///if(adr==100)
; 0000 07E7 ///	{
; 0000 07E8 ///	adr_hndl();
; 0000 07E9 ///	delay_ms(100);
; 0000 07EA ///	}
; 0000 07EB ///if(adr==100)
; 0000 07EC ///	{
; 0000 07ED ///	adr_hndl();
; 0000 07EE ///	delay_ms(100);
; 0000 07EF ///	}
; 0000 07F0 //adr_drv_v3();
; 0000 07F1 //AVT_MODE=1;
; 0000 07F2 adr_hndl();
	CALL _adr_hndl
; 0000 07F3 t0_init();
	CALL _t0_init
; 0000 07F4 
; 0000 07F5 
; 0000 07F6 
; 0000 07F7 link_cnt=0;
	LDI  R30,LOW(0)
	STS  _link_cnt,R30
	STS  _link_cnt+1,R30
; 0000 07F8 if(ee_AVT_MODE!=0x55)link=ON;
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x55)
	LDI  R26,HIGH(0x55)
	CPC  R31,R26
	BREQ _0x39F
	LDI  R30,LOW(85)
	STS  _link,R30
; 0000 07F9 /*
; 0000 07FA Umax=1000;
; 0000 07FB dU=100;
; 0000 07FC tmax=60;
; 0000 07FD tsign=50;
; 0000 07FE */
; 0000 07FF main_cnt1=0;
_0x39F:
	LDI  R30,LOW(0)
	STS  _main_cnt1,R30
	STS  _main_cnt1+1,R30
; 0000 0800 //_x_ee_=20;
; 0000 0801 _x_=_x_ee_;
	LDI  R26,LOW(__x_ee_)
	LDI  R27,HIGH(__x_ee_)
	CALL __EEPROMRDW
	STS  __x_,R30
	STS  __x_+1,R31
; 0000 0802 
; 0000 0803 if((_x_>XMAX)||(_x_<-XMAX))_x_=0;
	LDS  R26,__x_
	LDS  R27,__x_+1
	SBIW R26,26
	BRGE _0x3A1
	LDS  R26,__x_
	LDS  R27,__x_+1
	CPI  R26,LOW(0xFFE7)
	LDI  R30,HIGH(0xFFE7)
	CPC  R27,R30
	BRGE _0x3A0
_0x3A1:
	LDI  R30,LOW(0)
	STS  __x_,R30
	STS  __x_+1,R30
; 0000 0804 
; 0000 0805 if(!((TZAS>=0)&&(TZAS<=3))) TZAS=3;
_0x3A0:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	CALL __EEPROMRDB
	CPI  R30,0
	BRLO _0x3A4
	CPI  R30,LOW(0x4)
	BRLO _0x3A3
_0x3A4:
	LDI  R26,LOW(_TZAS)
	LDI  R27,HIGH(_TZAS)
	LDI  R30,LOW(3)
	CALL __EEPROMWRB
; 0000 0806 
; 0000 0807 #asm("sei")
_0x3A3:
	sei
; 0000 0808 //granee(&K[0][1],420,1100);
; 0000 0809 
; 0000 080A #ifdef _220_
; 0000 080B //granee(&K[1][1],4500,5500);
; 0000 080C //granee(&K[2][1],4500,5500);
; 0000 080D #else
; 0000 080E //granee(&K[1][1],1360,1700);
; 0000 080F //granee(&K[2][1],1360,1700);
; 0000 0810 #endif
; 0000 0811 
; 0000 0812 
; 0000 0813 //K[1][1]=123;
; 0000 0814 //K[2][1]=456;
; 0000 0815 //granee(&K[1,1],1510,1850);
; 0000 0816 //granee(&K[2,1],1510,1850);
; 0000 0817 ///DDRD.2=1;
; 0000 0818 ///PORTD.2=0;
; 0000 0819 ///delay_ms(100);
; 0000 081A ///PORTD.2=1;
; 0000 081B can_init1();
	CALL _can_init1
; 0000 081C 
; 0000 081D //DDRD.1=1;
; 0000 081E //PORTD.1=0;
; 0000 081F DDRD.0=1;
	SBI  0xA,0
; 0000 0820 
; 0000 0821 //ee_AVT_MODE=0x55;
; 0000 0822 		pwm_u=0x00;
	CALL SUBOPT_0x60
; 0000 0823 		pwm_i=0x00;
; 0000 0824 		bBL=1;
; 0000 0825 
; 0000 0826 
; 0000 0827 while (1)
_0x3AA:
; 0000 0828 	{
; 0000 0829 
; 0000 082A     //delay_ms(100);
; 0000 082B 	if(bIN1)
	LDS  R30,_bIN1
	CPI  R30,0
	BREQ _0x3AD
; 0000 082C 		{
; 0000 082D 		bIN1=0;
	LDI  R30,LOW(0)
	STS  _bIN1,R30
; 0000 082E 
; 0000 082F 		can_in_an1();
	CALL _can_in_an1
; 0000 0830 		}
; 0000 0831 
; 0000 0832 /*	if(b100Hz)
; 0000 0833 		{
; 0000 0834 		b100Hz=0;
; 0000 0835 		}*/
; 0000 0836 	if(b33Hz)
_0x3AD:
	SBIS 0x1E,2
	RJMP _0x3AE
; 0000 0837 		{
; 0000 0838 		b33Hz=0;
	CBI  0x1E,2
; 0000 0839 
; 0000 083A         adc_hndl();
	RCALL _adc_hndl
; 0000 083B 		}
; 0000 083C 	if(b10Hz)
_0x3AE:
	SBIS 0x1E,3
	RJMP _0x3B1
; 0000 083D 		{
; 0000 083E 		b10Hz=0;
	CBI  0x1E,3
; 0000 083F 
; 0000 0840 		matemat();
	RCALL _matemat
; 0000 0841 		led_drv();
	CALL _led_drv
; 0000 0842 	    link_drv();
	CALL _link_drv
; 0000 0843 	    pwr_hndl();		//вычисление воздействий на силу
	RCALL _pwr_hndl
; 0000 0844 	    JP_drv();
	RCALL _JP_drv
; 0000 0845 	    flags_drv();
	CALL _flags_drv
; 0000 0846 		net_drv();
	CALL _net_drv
; 0000 0847 		}
; 0000 0848 	if(b5Hz)
_0x3B1:
	SBIS 0x1E,4
	RJMP _0x3B4
; 0000 0849 		{
; 0000 084A 		b5Hz=0;
	CBI  0x1E,4
; 0000 084B 
; 0000 084C         pwr_drv();
	RCALL _pwr_drv
; 0000 084D  		led_hndl();
	CALL _led_hndl
; 0000 084E         vent_drv();
	RCALL _vent_drv
; 0000 084F 		}
; 0000 0850     if(b1Hz)
_0x3B4:
	SBIS 0x1E,5
	RJMP _0x3B7
; 0000 0851 		{
; 0000 0852 		b1Hz=0;
	CBI  0x1E,5
; 0000 0853 
; 0000 0854         temper_drv();			//вычисление аварий температуры
	CALL _temper_drv
; 0000 0855 		u_drv();
	CALL _u_drv
; 0000 0856         x_drv();
	CALL _x_drv
; 0000 0857 
; 0000 0858         if(main_cnt<1000)main_cnt++;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0x3BA
	LDI  R26,LOW(_main_cnt)
	LDI  R27,HIGH(_main_cnt)
	CALL SUBOPT_0x28
; 0000 0859   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
_0x3BA:
	LDS  R26,_link
	CPI  R26,LOW(0xAA)
	BREQ _0x3BC
	LDS  R26,_jp_mode
	CPI  R26,LOW(0x3)
	BRNE _0x3BB
_0x3BC:
	CALL _apv_hndl
; 0000 085A 
; 0000 085B 		//Пересброс КАНа в случае зависания
; 0000 085C   		can_error_cnt++;
_0x3BB:
	LDS  R30,_can_error_cnt
	SUBI R30,-LOW(1)
	STS  _can_error_cnt,R30
; 0000 085D   		if(can_error_cnt>=10)
	LDS  R26,_can_error_cnt
	CPI  R26,LOW(0xA)
	BRLO _0x3BE
; 0000 085E   			{
; 0000 085F   			can_error_cnt=0;
	LDI  R30,LOW(0)
	STS  _can_error_cnt,R30
; 0000 0860 			can_init1();;
	CALL _can_init1
; 0000 0861   			}
; 0000 0862 
; 0000 0863 		volum_u_main_drv();
_0x3BE:
	RCALL _volum_u_main_drv
; 0000 0864 
; 0000 0865 		//pwm_stat++;
; 0000 0866 		//if(pwm_stat>=10)pwm_stat=0;
; 0000 0867         //adc_plazma_short++;
; 0000 0868 
; 0000 0869 		vent_resurs_hndl();
	RCALL _vent_resurs_hndl
; 0000 086A         }
; 0000 086B      #asm("wdr")
_0x3B7:
	wdr
; 0000 086C 	}
	RJMP _0x3AA
; 0000 086D }
_0x3BF:
	RJMP _0x3BF
; .FEND
;#include "curr_version.h"
;
;const short HARDVARE_VERSION = 21;

	.DSEG
;const short SOFT_VERSION = 9;
;const short BUILD = 8;
;const short BUILD_YEAR = 2023;
;const short BUILD_MONTH = 10;
;const short BUILD_DAY = 10;
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(0)
	STS  _link_cnt,R30
	STS  _link_cnt+1,R30
	LDI  R30,LOW(85)
	STS  _link,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(_res_fl_)
	LDI  R27,HIGH(_res_fl_)
	CALL __EEPROMRDB
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	LDI  R26,LOW(_rotor_int)
	LDI  R27,HIGH(_rotor_int)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	LDS  R30,_adc_buff_
	LDS  R31,_adc_buff_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x13:
	__POINTW2MN _K,2
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	__GETB1MN _RXBUFF1,3
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x5)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x17:
	__POINTW2MN _K,6
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	__POINTW2MN _K,10
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x19:
	__POINTW2MN _K,14
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	LDI  R26,LOW(_ee_Umax)
	LDI  R27,HIGH(_ee_Umax)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1C:
	__GETB2MN _RXBUFF1,4
	RJMP SUBOPT_0xB

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
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1F:
	__GETB2MN _RXBUFF1,5
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x20:
	LDI  R26,LOW(_ee_AVT_MODE)
	LDI  R27,HIGH(_ee_AVT_MODE)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EEPROMWRW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	LDI  R26,LOW(_ee_tmax)
	LDI  R27,HIGH(_ee_tmax)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x23:
	LDI  R26,LOW(_ee_tsign)
	LDI  R27,HIGH(_ee_tsign)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x24:
	LDI  R26,LOW(_ee_DEVICE)
	LDI  R27,HIGH(_ee_DEVICE)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x25:
	LDI  R26,LOW(_ee_TZAS)
	LDI  R27,HIGH(_ee_TZAS)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	MOVW R26,R30
	__GETB1MN _RXBUFF1,7
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:75 WORDS
SUBOPT_0x27:
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
SUBOPT_0x28:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	LDI  R26,LOW(_ee_U_AVT)
	LDI  R27,HIGH(_ee_U_AVT)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2A:
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
SUBOPT_0x2B:
	LDS  R30,__x_
	LDS  R31,__x_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2C:
	STS  _led_red_buff,R30
	STS  _led_red_buff+1,R31
	STS  _led_red_buff+2,R22
	STS  _led_red_buff+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2D:
	STS  _led_green_buff,R30
	STS  _led_green_buff+1,R31
	STS  _led_green_buff+2,R22
	STS  _led_green_buff+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2E:
	STS  124,R30
	LDI  R30,LOW(166)
	STS  122,R30
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2F:
	LDS  R30,120
	LDS  R31,120+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x30:
	LDS  R26,_umin_cnt
	LDS  R27,_umin_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x31:
	LDS  R26,_umax_cnt
	LDS  R27,_umax_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	LDS  R26,_link_cnt
	LDS  R27,_link_cnt+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x33:
	LDS  R26,_T
	LDS  R27,_T+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x34:
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
SUBOPT_0x35:
	LDS  R26,_Ui
	LDS  R27,_Ui+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x36:
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
	RCALL SUBOPT_0x31
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x37:
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
	RCALL SUBOPT_0x30
	SBIW R26,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x38:
	LDS  R30,_flags
	ORI  R30,0x10
	STS  _flags,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x39:
	__GETD1N 0x55555555
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 27 TIMES, CODE SIZE REDUCTION:153 WORDS
SUBOPT_0x3A:
	STS  _led_red,R30
	STS  _led_red+1,R31
	STS  _led_red+2,R22
	STS  _led_red+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:123 WORDS
SUBOPT_0x3B:
	LDI  R30,LOW(0)
	STS  _led_red,R30
	STS  _led_red+1,R30
	STS  _led_red+2,R30
	STS  _led_red+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x3C:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x3D:
	STS  _led_green,R30
	STS  _led_green+1,R31
	STS  _led_green+2,R22
	STS  _led_green+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3E:
	LDS  R30,_flags
	ANDI R30,LOW(0x3E)
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x3F:
	__GETD1N 0x10001
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x40:
	RCALL SUBOPT_0x3F
	RJMP SUBOPT_0x3A

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:116 WORDS
SUBOPT_0x41:
	LDI  R30,LOW(0)
	STS  _led_green,R30
	STS  _led_green+1,R30
	STS  _led_green+2,R30
	STS  _led_green+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x42:
	__GETD1N 0x90009
	RCALL SUBOPT_0x3A
	RJMP SUBOPT_0x41

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x43:
	__GETD1N 0x490049
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x44:
	__GETD1N 0x33333333
	RJMP SUBOPT_0x3D

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x45:
	__GETD1N 0xCCCCCCCC
	RCALL SUBOPT_0x3A
	RJMP SUBOPT_0x41

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x46:
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x47:
	__GETD1N 0x3030303
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x48:
	__GETD1N 0x55555
	RCALL SUBOPT_0x3A
	RJMP SUBOPT_0x3C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x49:
	SUBI R30,LOW(-100)
	SBCI R31,HIGH(-100)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4A:
	RCALL SUBOPT_0x39
	RCALL SUBOPT_0x3A
	RJMP SUBOPT_0x3C

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	RCALL SUBOPT_0x43
	RJMP SUBOPT_0x3A

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4C:
	SUBI R30,LOW(-70)
	SBCI R31,HIGH(-70)
	LDS  R26,_main_cnt1
	LDS  R27,_main_cnt1+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4D:
	__GETD1N 0x5
	RJMP SUBOPT_0x3D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4E:
	CALL __DIVD21
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4F:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x50:
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	RJMP SUBOPT_0x1A

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x51:
	LDS  R26,_vent_pwm
	LDS  R27,_vent_pwm+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x52:
	LDI  R26,LOW(_vent_resurs)
	LDI  R27,HIGH(_vent_resurs)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x53:
	LDI  R26,LOW(_UU_AVT)
	LDI  R27,HIGH(_UU_AVT)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x54:
	LDS  R26,_Un
	LDS  R27,_Un+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x55:
	LDS  R30,_volum_u_main_
	LDS  R31,_volum_u_main_+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x56:
	STS  _volum_u_main_,R30
	STS  _volum_u_main_+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x57:
	LDS  R26,_Un
	LDS  R27,_Un+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x58:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_i_main_flag)
	SBCI R31,HIGH(-_i_main_flag)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x59:
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
SUBOPT_0x5A:
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
SUBOPT_0x5B:
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
SUBOPT_0x5C:
	STS  _pwm_u,R30
	STS  _pwm_u+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x5D:
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
SUBOPT_0x5E:
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
SUBOPT_0x5F:
	LDI  R30,LOW(1020)
	LDI  R31,HIGH(1020)
	STS  _pwm_i,R30
	STS  _pwm_i+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:51 WORDS
SUBOPT_0x60:
	LDI  R30,LOW(0)
	STS  _pwm_u,R30
	STS  _pwm_u+1,R30
	STS  _pwm_i,R30
	STS  _pwm_i+1,R30
	SBI  0x1E,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x61:
	RCALL SUBOPT_0x5C
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	CPI  R26,LOW(0x3FC)
	LDI  R30,HIGH(0x3FC)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x62:
	LDS  R26,_pwm_i
	LDS  R27,_pwm_i+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x63:
	RCALL SUBOPT_0x2B
	LDS  R26,_vol_u_temp
	LDS  R27,_vol_u_temp+1
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x5C
	RJMP SUBOPT_0x24

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x64:
	LDS  R30,_vol_i_temp_avar
	LDS  R31,_vol_i_temp_avar+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x65:
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	CALL __DIVW21U
	RCALL SUBOPT_0x62
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x66:
	LDS  R30,_vol_i_temp
	LDS  R31,_vol_i_temp+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x67:
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
SUBOPT_0x68:
	LDS  R30,_adc_ch
	LDI  R31,0
	LSL  R30
	ROL  R31
	CALL __LSLW4
	SUBI R30,LOW(-_adc_buff)
	SBCI R31,HIGH(-_adc_buff)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x69:
	LDS  R30,_adc_ch
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6A:
	CLR  R22
	CLR  R23
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6B:
	CALL __GETD2S0
	CALL __CWD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6C:
	LDI  R30,LOW(0)
	CALL __CLRD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x6D:
	CALL __MULD12
	CALL __PUTD1S0
	CALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x6E:
	CALL __DIVD21
	CALL __PUTD1S0
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6F:
	__GETD1N 0x3E8
	RJMP SUBOPT_0x6E


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

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
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
