   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     .const:	section	.text
  16  0000               _HARDVARE_VERSION:
  17  0000 0017          	dc.w	23
  18  0002               _SOFT_VERSION:
  19  0002 0001          	dc.w	1
  20  0004               _BUILD:
  21  0004 0015          	dc.w	21
  22  0006               _BUILD_YEAR:
  23  0006 07e7          	dc.w	2023
  24  0008               _BUILD_MONTH:
  25  0008 0003          	dc.w	3
  26  000a               _BUILD_DAY:
  27  000a 0016          	dc.w	22
 102                     	xdef	_BUILD_DAY
 103                     	xdef	_BUILD_MONTH
 104                     	xdef	_BUILD_YEAR
 105                     	xdef	_BUILD
 106                     	xdef	_SOFT_VERSION
 107                     	xdef	_HARDVARE_VERSION
 126                     	end
