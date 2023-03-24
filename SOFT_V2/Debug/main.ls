   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _bVENT_BLOCK:
  17  0000 00            	dc.b	0
2175                     	switch	.data
2176  0000               _t0_cnt00:
2177  0000 0000          	dc.w	0
2178  0002               _t0_cnt0:
2179  0002 0000          	dc.w	0
2180  0004               _t0_cnt1:
2181  0004 00            	dc.b	0
2182  0005               _t0_cnt2:
2183  0005 00            	dc.b	0
2184  0006               _t0_cnt3:
2185  0006 00            	dc.b	0
2186  0007               _t0_cnt4:
2187  0007 01            	dc.b	1
2188  0008               _t0_cnt5:
2189  0008 00            	dc.b	0
2190                     	bsct
2191  0001               _led_ind:
2192  0001 05            	dc.b	5
2193  0002               _adr_drv_stat:
2194  0002 00            	dc.b	0
2195  0003               _bTX_FREE:
2196  0003 01            	dc.b	1
2197  0004               _bCAN_RX:
2198  0004 00            	dc.b	0
2199  0005               _flags:
2200  0005 00            	dc.b	0
2201  0006               _vol_i_temp_avar:
2202  0006 0000          	dc.w	0
2203  0008               _pwm_u:
2204  0008 00c8          	dc.w	200
2205  000a               _pwm_i:
2206  000a 0032          	dc.w	50
2207                     .bit:	section	.data,bit
2208  0000               _bBL_IPS:
2209  0000 00            	dc.b	0
2210                     	bsct
2211  000c               _bRES:
2212  000c 00            	dc.b	0
2213  000d               _bRES_:
2214  000d 00            	dc.b	0
2215  000e               _led_red:
2216  000e 00000000      	dc.l	0
2217  0012               _led_green:
2218  0012 03030303      	dc.l	50529027
2219  0016               _led_drv_cnt:
2220  0016 1e            	dc.b	30
2221  0017               _rotor_int:
2222  0017 007b          	dc.w	123
2223  0019               _volum_u_main_:
2224  0019 02bc          	dc.w	700
2269                     .const:	section	.text
2270  0000               L6:
2271  0000 0000ea60      	dc.l	60000
2272                     ; 195 void vent_resurs_hndl(void)
2272                     ; 196 {
2273                     	scross	off
2274                     	switch	.text
2275  0000               _vent_resurs_hndl:
2277  0000 88            	push	a
2278       00000001      OFST:	set	1
2281                     ; 198 if(vent_pwm>100)vent_resurs_sec_cnt++;
2283  0001 9c            	rvf
2284  0002 be10          	ldw	x,_vent_pwm
2285  0004 a30065        	cpw	x,#101
2286  0007 2f07          	jrslt	L7441
2289  0009 be09          	ldw	x,_vent_resurs_sec_cnt
2290  000b 1c0001        	addw	x,#1
2291  000e bf09          	ldw	_vent_resurs_sec_cnt,x
2292  0010               L7441:
2293                     ; 199 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2295  0010 be09          	ldw	x,_vent_resurs_sec_cnt
2296  0012 a30e11        	cpw	x,#3601
2297  0015 251b          	jrult	L1541
2298                     ; 201 	if(vent_resurs<60000)vent_resurs++;
2300  0017 9c            	rvf
2301  0018 ce0000        	ldw	x,_vent_resurs
2302  001b cd0000        	call	c_uitolx
2304  001e ae0000        	ldw	x,#L6
2305  0021 cd0000        	call	c_lcmp
2307  0024 2e09          	jrsge	L3541
2310  0026 ce0000        	ldw	x,_vent_resurs
2311  0029 1c0001        	addw	x,#1
2312  002c cf0000        	ldw	_vent_resurs,x
2313  002f               L3541:
2314                     ; 202 	vent_resurs_sec_cnt=0;
2316  002f 5f            	clrw	x
2317  0030 bf09          	ldw	_vent_resurs_sec_cnt,x
2318  0032               L1541:
2319                     ; 207 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2321  0032 c60001        	ld	a,_vent_resurs+1
2322  0035 a40f          	and	a,#15
2323  0037 c70000        	ld	_vent_resurs_buff,a
2324                     ; 208 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2326  003a c60001        	ld	a,_vent_resurs+1
2327  003d a4f0          	and	a,#240
2328  003f 4e            	swap	a
2329  0040 a40f          	and	a,#15
2330  0042 aa40          	or	a,#64
2331  0044 c70001        	ld	_vent_resurs_buff+1,a
2332                     ; 209 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2334  0047 c60000        	ld	a,_vent_resurs
2335  004a 97            	ld	xl,a
2336  004b c60001        	ld	a,_vent_resurs+1
2337  004e 9f            	ld	a,xl
2338  004f a40f          	and	a,#15
2339  0051 97            	ld	xl,a
2340  0052 4f            	clr	a
2341  0053 02            	rlwa	x,a
2342  0054 4f            	clr	a
2343  0055 01            	rrwa	x,a
2344  0056 9f            	ld	a,xl
2345  0057 aa80          	or	a,#128
2346  0059 c70002        	ld	_vent_resurs_buff+2,a
2347                     ; 210 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2349  005c c60000        	ld	a,_vent_resurs
2350  005f 97            	ld	xl,a
2351  0060 c60001        	ld	a,_vent_resurs+1
2352  0063 9f            	ld	a,xl
2353  0064 a4f0          	and	a,#240
2354  0066 97            	ld	xl,a
2355  0067 4f            	clr	a
2356  0068 02            	rlwa	x,a
2357  0069 01            	rrwa	x,a
2358  006a 4f            	clr	a
2359  006b 41            	exg	a,xl
2360  006c 4e            	swap	a
2361  006d a40f          	and	a,#15
2362  006f 02            	rlwa	x,a
2363  0070 9f            	ld	a,xl
2364  0071 aac0          	or	a,#192
2365  0073 c70003        	ld	_vent_resurs_buff+3,a
2366                     ; 212 temp=vent_resurs_buff[0]&0x0f;
2368  0076 c60000        	ld	a,_vent_resurs_buff
2369  0079 a40f          	and	a,#15
2370  007b 6b01          	ld	(OFST+0,sp),a
2371                     ; 213 temp^=vent_resurs_buff[1]&0x0f;
2373  007d c60001        	ld	a,_vent_resurs_buff+1
2374  0080 a40f          	and	a,#15
2375  0082 1801          	xor	a,(OFST+0,sp)
2376  0084 6b01          	ld	(OFST+0,sp),a
2377                     ; 214 temp^=vent_resurs_buff[2]&0x0f;
2379  0086 c60002        	ld	a,_vent_resurs_buff+2
2380  0089 a40f          	and	a,#15
2381  008b 1801          	xor	a,(OFST+0,sp)
2382  008d 6b01          	ld	(OFST+0,sp),a
2383                     ; 215 temp^=vent_resurs_buff[3]&0x0f;
2385  008f c60003        	ld	a,_vent_resurs_buff+3
2386  0092 a40f          	and	a,#15
2387  0094 1801          	xor	a,(OFST+0,sp)
2388  0096 6b01          	ld	(OFST+0,sp),a
2389                     ; 217 vent_resurs_buff[0]|=(temp&0x03)<<4;
2391  0098 7b01          	ld	a,(OFST+0,sp)
2392  009a a403          	and	a,#3
2393  009c 97            	ld	xl,a
2394  009d a610          	ld	a,#16
2395  009f 42            	mul	x,a
2396  00a0 9f            	ld	a,xl
2397  00a1 ca0000        	or	a,_vent_resurs_buff
2398  00a4 c70000        	ld	_vent_resurs_buff,a
2399                     ; 218 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2401  00a7 7b01          	ld	a,(OFST+0,sp)
2402  00a9 a40c          	and	a,#12
2403  00ab 48            	sll	a
2404  00ac 48            	sll	a
2405  00ad ca0001        	or	a,_vent_resurs_buff+1
2406  00b0 c70001        	ld	_vent_resurs_buff+1,a
2407                     ; 219 vent_resurs_buff[2]|=(temp&0x30);
2409  00b3 7b01          	ld	a,(OFST+0,sp)
2410  00b5 a430          	and	a,#48
2411  00b7 ca0002        	or	a,_vent_resurs_buff+2
2412  00ba c70002        	ld	_vent_resurs_buff+2,a
2413                     ; 220 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2415  00bd 7b01          	ld	a,(OFST+0,sp)
2416  00bf a4c0          	and	a,#192
2417  00c1 44            	srl	a
2418  00c2 44            	srl	a
2419  00c3 ca0003        	or	a,_vent_resurs_buff+3
2420  00c6 c70003        	ld	_vent_resurs_buff+3,a
2421                     ; 223 vent_resurs_tx_cnt++;
2423  00c9 3c08          	inc	_vent_resurs_tx_cnt
2424                     ; 224 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2426  00cb b608          	ld	a,_vent_resurs_tx_cnt
2427  00cd a104          	cp	a,#4
2428  00cf 2502          	jrult	L5541
2431  00d1 3f08          	clr	_vent_resurs_tx_cnt
2432  00d3               L5541:
2433                     ; 227 }
2436  00d3 84            	pop	a
2437  00d4 81            	ret
2490                     ; 230 void gran(signed short *adr, signed short min, signed short max)
2490                     ; 231 {
2491                     	switch	.text
2492  00d5               _gran:
2494  00d5 89            	pushw	x
2495       00000000      OFST:	set	0
2498                     ; 232 if (*adr<min) *adr=min;
2500  00d6 9c            	rvf
2501  00d7 9093          	ldw	y,x
2502  00d9 51            	exgw	x,y
2503  00da fe            	ldw	x,(x)
2504  00db 1305          	cpw	x,(OFST+5,sp)
2505  00dd 51            	exgw	x,y
2506  00de 2e03          	jrsge	L5051
2509  00e0 1605          	ldw	y,(OFST+5,sp)
2510  00e2 ff            	ldw	(x),y
2511  00e3               L5051:
2512                     ; 233 if (*adr>max) *adr=max; 
2514  00e3 9c            	rvf
2515  00e4 1e01          	ldw	x,(OFST+1,sp)
2516  00e6 9093          	ldw	y,x
2517  00e8 51            	exgw	x,y
2518  00e9 fe            	ldw	x,(x)
2519  00ea 1307          	cpw	x,(OFST+7,sp)
2520  00ec 51            	exgw	x,y
2521  00ed 2d05          	jrsle	L7051
2524  00ef 1e01          	ldw	x,(OFST+1,sp)
2525  00f1 1607          	ldw	y,(OFST+7,sp)
2526  00f3 ff            	ldw	(x),y
2527  00f4               L7051:
2528                     ; 234 } 
2531  00f4 85            	popw	x
2532  00f5 81            	ret
2585                     ; 237 void granee(@eeprom signed short *adr, signed short min, signed short max)
2585                     ; 238 {
2586                     	switch	.text
2587  00f6               _granee:
2589  00f6 89            	pushw	x
2590       00000000      OFST:	set	0
2593                     ; 239 if (*adr<min) *adr=min;
2595  00f7 9c            	rvf
2596  00f8 9093          	ldw	y,x
2597  00fa 51            	exgw	x,y
2598  00fb fe            	ldw	x,(x)
2599  00fc 1305          	cpw	x,(OFST+5,sp)
2600  00fe 51            	exgw	x,y
2601  00ff 2e09          	jrsge	L7351
2604  0101 1e05          	ldw	x,(OFST+5,sp)
2605  0103 89            	pushw	x
2606  0104 1e03          	ldw	x,(OFST+3,sp)
2607  0106 cd0000        	call	c_eewrw
2609  0109 85            	popw	x
2610  010a               L7351:
2611                     ; 240 if (*adr>max) *adr=max; 
2613  010a 9c            	rvf
2614  010b 1e01          	ldw	x,(OFST+1,sp)
2615  010d 9093          	ldw	y,x
2616  010f 51            	exgw	x,y
2617  0110 fe            	ldw	x,(x)
2618  0111 1307          	cpw	x,(OFST+7,sp)
2619  0113 51            	exgw	x,y
2620  0114 2d09          	jrsle	L1451
2623  0116 1e07          	ldw	x,(OFST+7,sp)
2624  0118 89            	pushw	x
2625  0119 1e03          	ldw	x,(OFST+3,sp)
2626  011b cd0000        	call	c_eewrw
2628  011e 85            	popw	x
2629  011f               L1451:
2630                     ; 241 }
2633  011f 85            	popw	x
2634  0120 81            	ret
2695                     ; 244 long delay_ms(short in)
2695                     ; 245 {
2696                     	switch	.text
2697  0121               _delay_ms:
2699  0121 520c          	subw	sp,#12
2700       0000000c      OFST:	set	12
2703                     ; 248 i=((long)in)*100UL;
2705  0123 90ae0064      	ldw	y,#100
2706  0127 cd0000        	call	c_vmul
2708  012a 96            	ldw	x,sp
2709  012b 1c0005        	addw	x,#OFST-7
2710  012e cd0000        	call	c_rtol
2712                     ; 250 for(ii=0;ii<i;ii++)
2714  0131 ae0000        	ldw	x,#0
2715  0134 1f0b          	ldw	(OFST-1,sp),x
2716  0136 ae0000        	ldw	x,#0
2717  0139 1f09          	ldw	(OFST-3,sp),x
2719  013b 2012          	jra	L1061
2720  013d               L5751:
2721                     ; 252 		iii++;
2723  013d 96            	ldw	x,sp
2724  013e 1c0001        	addw	x,#OFST-11
2725  0141 a601          	ld	a,#1
2726  0143 cd0000        	call	c_lgadc
2728                     ; 250 for(ii=0;ii<i;ii++)
2730  0146 96            	ldw	x,sp
2731  0147 1c0009        	addw	x,#OFST-3
2732  014a a601          	ld	a,#1
2733  014c cd0000        	call	c_lgadc
2735  014f               L1061:
2738  014f 9c            	rvf
2739  0150 96            	ldw	x,sp
2740  0151 1c0009        	addw	x,#OFST-3
2741  0154 cd0000        	call	c_ltor
2743  0157 96            	ldw	x,sp
2744  0158 1c0005        	addw	x,#OFST-7
2745  015b cd0000        	call	c_lcmp
2747  015e 2fdd          	jrslt	L5751
2748                     ; 255 }
2751  0160 5b0c          	addw	sp,#12
2752  0162 81            	ret
2785                     ; 258 void led_hndl(void)
2785                     ; 259 {
2786                     	switch	.text
2787  0163               _led_hndl:
2791                     ; 260 if(adress_error)
2793  0163 725d0100      	tnz	_adress_error
2794  0167 2714          	jreq	L5161
2795                     ; 262 	led_red=0x55555555L;
2797  0169 ae5555        	ldw	x,#21845
2798  016c bf10          	ldw	_led_red+2,x
2799  016e ae5555        	ldw	x,#21845
2800  0171 bf0e          	ldw	_led_red,x
2801                     ; 263 	led_green=0x55555555L;
2803  0173 ae5555        	ldw	x,#21845
2804  0176 bf14          	ldw	_led_green+2,x
2805  0178 ae5555        	ldw	x,#21845
2806  017b bf12          	ldw	_led_green,x
2807  017d               L5161:
2808                     ; 281 	if(jp_mode!=jp3)
2810  017d b655          	ld	a,_jp_mode
2811  017f a103          	cp	a,#3
2812  0181 2603          	jrne	L02
2813  0183 cc0311        	jp	L7161
2814  0186               L02:
2815                     ; 283 		if(main_cnt1<(5*EE_TZAS))
2817  0186 9c            	rvf
2818  0187 be5e          	ldw	x,_main_cnt1
2819  0189 a3000f        	cpw	x,#15
2820  018c 2e18          	jrsge	L1261
2821                     ; 285 			led_red=0x00000000L;
2823  018e ae0000        	ldw	x,#0
2824  0191 bf10          	ldw	_led_red+2,x
2825  0193 ae0000        	ldw	x,#0
2826  0196 bf0e          	ldw	_led_red,x
2827                     ; 286 			led_green=0x0303030fL;
2829  0198 ae030f        	ldw	x,#783
2830  019b bf14          	ldw	_led_green+2,x
2831  019d ae0303        	ldw	x,#771
2832  01a0 bf12          	ldw	_led_green,x
2834  01a2 acd202d2      	jpf	L3261
2835  01a6               L1261:
2836                     ; 289 		else if((link==ON)&&(flags_tu&0b10000000))
2838  01a6 b670          	ld	a,_link
2839  01a8 a155          	cp	a,#85
2840  01aa 261e          	jrne	L5261
2842  01ac b66d          	ld	a,_flags_tu
2843  01ae a580          	bcp	a,#128
2844  01b0 2718          	jreq	L5261
2845                     ; 291 			led_red=0x00055555L;
2847  01b2 ae5555        	ldw	x,#21845
2848  01b5 bf10          	ldw	_led_red+2,x
2849  01b7 ae0005        	ldw	x,#5
2850  01ba bf0e          	ldw	_led_red,x
2851                     ; 292 			led_green=0xffffffffL;
2853  01bc aeffff        	ldw	x,#65535
2854  01bf bf14          	ldw	_led_green+2,x
2855  01c1 aeffff        	ldw	x,#-1
2856  01c4 bf12          	ldw	_led_green,x
2858  01c6 acd202d2      	jpf	L3261
2859  01ca               L5261:
2860                     ; 295 		else if(((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(100+(5*EE_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2862  01ca 9c            	rvf
2863  01cb be5e          	ldw	x,_main_cnt1
2864  01cd a30010        	cpw	x,#16
2865  01d0 2f2d          	jrslt	L1361
2867  01d2 9c            	rvf
2868  01d3 be5e          	ldw	x,_main_cnt1
2869  01d5 a30073        	cpw	x,#115
2870  01d8 2e25          	jrsge	L1361
2872  01da ce0006        	ldw	x,_ee_AVT_MODE
2873  01dd a30055        	cpw	x,#85
2874  01e0 271d          	jreq	L1361
2876  01e2 ce0004        	ldw	x,_ee_DEVICE
2877  01e5 2618          	jrne	L1361
2878                     ; 297 			led_red=0x00000000L;
2880  01e7 ae0000        	ldw	x,#0
2881  01ea bf10          	ldw	_led_red+2,x
2882  01ec ae0000        	ldw	x,#0
2883  01ef bf0e          	ldw	_led_red,x
2884                     ; 298 			led_green=0xffffffffL;	
2886  01f1 aeffff        	ldw	x,#65535
2887  01f4 bf14          	ldw	_led_green+2,x
2888  01f6 aeffff        	ldw	x,#-1
2889  01f9 bf12          	ldw	_led_green,x
2891  01fb acd202d2      	jpf	L3261
2892  01ff               L1361:
2893                     ; 301 		else  if(link==OFF)
2895  01ff b670          	ld	a,_link
2896  0201 a1aa          	cp	a,#170
2897  0203 2618          	jrne	L5361
2898                     ; 303 			led_red=0x55555555L;
2900  0205 ae5555        	ldw	x,#21845
2901  0208 bf10          	ldw	_led_red+2,x
2902  020a ae5555        	ldw	x,#21845
2903  020d bf0e          	ldw	_led_red,x
2904                     ; 304 			led_green=0xffffffffL;
2906  020f aeffff        	ldw	x,#65535
2907  0212 bf14          	ldw	_led_green+2,x
2908  0214 aeffff        	ldw	x,#-1
2909  0217 bf12          	ldw	_led_green,x
2911  0219 acd202d2      	jpf	L3261
2912  021d               L5361:
2913                     ; 307 		else if((link==ON)&&((flags&0b00111110)==0))
2915  021d b670          	ld	a,_link
2916  021f a155          	cp	a,#85
2917  0221 261d          	jrne	L1461
2919  0223 b605          	ld	a,_flags
2920  0225 a53e          	bcp	a,#62
2921  0227 2617          	jrne	L1461
2922                     ; 309 			led_red=0x00000000L;
2924  0229 ae0000        	ldw	x,#0
2925  022c bf10          	ldw	_led_red+2,x
2926  022e ae0000        	ldw	x,#0
2927  0231 bf0e          	ldw	_led_red,x
2928                     ; 310 			led_green=0xffffffffL;
2930  0233 aeffff        	ldw	x,#65535
2931  0236 bf14          	ldw	_led_green+2,x
2932  0238 aeffff        	ldw	x,#-1
2933  023b bf12          	ldw	_led_green,x
2935  023d cc02d2        	jra	L3261
2936  0240               L1461:
2937                     ; 313 		else if((flags&0b00111110)==0b00000100)
2939  0240 b605          	ld	a,_flags
2940  0242 a43e          	and	a,#62
2941  0244 a104          	cp	a,#4
2942  0246 2616          	jrne	L5461
2943                     ; 315 			led_red=0x00010001L;
2945  0248 ae0001        	ldw	x,#1
2946  024b bf10          	ldw	_led_red+2,x
2947  024d ae0001        	ldw	x,#1
2948  0250 bf0e          	ldw	_led_red,x
2949                     ; 316 			led_green=0xffffffffL;	
2951  0252 aeffff        	ldw	x,#65535
2952  0255 bf14          	ldw	_led_green+2,x
2953  0257 aeffff        	ldw	x,#-1
2954  025a bf12          	ldw	_led_green,x
2956  025c 2074          	jra	L3261
2957  025e               L5461:
2958                     ; 318 		else if(flags&0b00000010)
2960  025e b605          	ld	a,_flags
2961  0260 a502          	bcp	a,#2
2962  0262 2716          	jreq	L1561
2963                     ; 320 			led_red=0x00010001L;
2965  0264 ae0001        	ldw	x,#1
2966  0267 bf10          	ldw	_led_red+2,x
2967  0269 ae0001        	ldw	x,#1
2968  026c bf0e          	ldw	_led_red,x
2969                     ; 321 			led_green=0x00000000L;	
2971  026e ae0000        	ldw	x,#0
2972  0271 bf14          	ldw	_led_green+2,x
2973  0273 ae0000        	ldw	x,#0
2974  0276 bf12          	ldw	_led_green,x
2976  0278 2058          	jra	L3261
2977  027a               L1561:
2978                     ; 323 		else if(flags&0b00001000)
2980  027a b605          	ld	a,_flags
2981  027c a508          	bcp	a,#8
2982  027e 2716          	jreq	L5561
2983                     ; 325 			led_red=0x00090009L;
2985  0280 ae0009        	ldw	x,#9
2986  0283 bf10          	ldw	_led_red+2,x
2987  0285 ae0009        	ldw	x,#9
2988  0288 bf0e          	ldw	_led_red,x
2989                     ; 326 			led_green=0x00000000L;	
2991  028a ae0000        	ldw	x,#0
2992  028d bf14          	ldw	_led_green+2,x
2993  028f ae0000        	ldw	x,#0
2994  0292 bf12          	ldw	_led_green,x
2996  0294 203c          	jra	L3261
2997  0296               L5561:
2998                     ; 328 		else if(flags&0b00010000)
3000  0296 b605          	ld	a,_flags
3001  0298 a510          	bcp	a,#16
3002  029a 2716          	jreq	L1661
3003                     ; 330 			led_red=0x00490049L;
3005  029c ae0049        	ldw	x,#73
3006  029f bf10          	ldw	_led_red+2,x
3007  02a1 ae0049        	ldw	x,#73
3008  02a4 bf0e          	ldw	_led_red,x
3009                     ; 331 			led_green=0x00000000L;	
3011  02a6 ae0000        	ldw	x,#0
3012  02a9 bf14          	ldw	_led_green+2,x
3013  02ab ae0000        	ldw	x,#0
3014  02ae bf12          	ldw	_led_green,x
3016  02b0 2020          	jra	L3261
3017  02b2               L1661:
3018                     ; 334 		else if((link==ON)&&(flags&0b00100000))
3020  02b2 b670          	ld	a,_link
3021  02b4 a155          	cp	a,#85
3022  02b6 261a          	jrne	L3261
3024  02b8 b605          	ld	a,_flags
3025  02ba a520          	bcp	a,#32
3026  02bc 2714          	jreq	L3261
3027                     ; 336 			led_red=0x00000000L;
3029  02be ae0000        	ldw	x,#0
3030  02c1 bf10          	ldw	_led_red+2,x
3031  02c3 ae0000        	ldw	x,#0
3032  02c6 bf0e          	ldw	_led_red,x
3033                     ; 337 			led_green=0x00030003L;
3035  02c8 ae0003        	ldw	x,#3
3036  02cb bf14          	ldw	_led_green+2,x
3037  02cd ae0003        	ldw	x,#3
3038  02d0 bf12          	ldw	_led_green,x
3039  02d2               L3261:
3040                     ; 340 		if((jp_mode==jp1))
3042  02d2 b655          	ld	a,_jp_mode
3043  02d4 a101          	cp	a,#1
3044  02d6 2618          	jrne	L7661
3045                     ; 342 			led_red=0x00000000L;
3047  02d8 ae0000        	ldw	x,#0
3048  02db bf10          	ldw	_led_red+2,x
3049  02dd ae0000        	ldw	x,#0
3050  02e0 bf0e          	ldw	_led_red,x
3051                     ; 343 			led_green=0x33333333L;
3053  02e2 ae3333        	ldw	x,#13107
3054  02e5 bf14          	ldw	_led_green+2,x
3055  02e7 ae3333        	ldw	x,#13107
3056  02ea bf12          	ldw	_led_green,x
3058  02ec aced03ed      	jpf	L5761
3059  02f0               L7661:
3060                     ; 345 		else if((jp_mode==jp2))
3062  02f0 b655          	ld	a,_jp_mode
3063  02f2 a102          	cp	a,#2
3064  02f4 2703          	jreq	L22
3065  02f6 cc03ed        	jp	L5761
3066  02f9               L22:
3067                     ; 347 			led_red=0xccccccccL;
3069  02f9 aecccc        	ldw	x,#52428
3070  02fc bf10          	ldw	_led_red+2,x
3071  02fe aecccc        	ldw	x,#-13108
3072  0301 bf0e          	ldw	_led_red,x
3073                     ; 348 			led_green=0x00000000L;
3075  0303 ae0000        	ldw	x,#0
3076  0306 bf14          	ldw	_led_green+2,x
3077  0308 ae0000        	ldw	x,#0
3078  030b bf12          	ldw	_led_green,x
3079  030d aced03ed      	jpf	L5761
3080  0311               L7161:
3081                     ; 353 	else if(jp_mode==jp3)
3083  0311 b655          	ld	a,_jp_mode
3084  0313 a103          	cp	a,#3
3085  0315 2703          	jreq	L42
3086  0317 cc03ed        	jp	L5761
3087  031a               L42:
3088                     ; 355 		if(main_cnt1<(5*EE_TZAS))
3090  031a 9c            	rvf
3091  031b be5e          	ldw	x,_main_cnt1
3092  031d a3000f        	cpw	x,#15
3093  0320 2e18          	jrsge	L1071
3094                     ; 357 			led_red=0x00000000L;
3096  0322 ae0000        	ldw	x,#0
3097  0325 bf10          	ldw	_led_red+2,x
3098  0327 ae0000        	ldw	x,#0
3099  032a bf0e          	ldw	_led_red,x
3100                     ; 358 			led_green=0x03030303L;
3102  032c ae0303        	ldw	x,#771
3103  032f bf14          	ldw	_led_green+2,x
3104  0331 ae0303        	ldw	x,#771
3105  0334 bf12          	ldw	_led_green,x
3107  0336 aced03ed      	jpf	L5761
3108  033a               L1071:
3109                     ; 360 		else if((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(70+(5*EE_TZAS))))
3111  033a 9c            	rvf
3112  033b be5e          	ldw	x,_main_cnt1
3113  033d a30010        	cpw	x,#16
3114  0340 2f1f          	jrslt	L5071
3116  0342 9c            	rvf
3117  0343 be5e          	ldw	x,_main_cnt1
3118  0345 a30055        	cpw	x,#85
3119  0348 2e17          	jrsge	L5071
3120                     ; 362 			led_red=0x00000000L;
3122  034a ae0000        	ldw	x,#0
3123  034d bf10          	ldw	_led_red+2,x
3124  034f ae0000        	ldw	x,#0
3125  0352 bf0e          	ldw	_led_red,x
3126                     ; 363 			led_green=0xffffffffL;	
3128  0354 aeffff        	ldw	x,#65535
3129  0357 bf14          	ldw	_led_green+2,x
3130  0359 aeffff        	ldw	x,#-1
3131  035c bf12          	ldw	_led_green,x
3133  035e cc03ed        	jra	L5761
3134  0361               L5071:
3135                     ; 366 		else if((flags&0b00011110)==0)
3137  0361 b605          	ld	a,_flags
3138  0363 a51e          	bcp	a,#30
3139  0365 2616          	jrne	L1171
3140                     ; 368 			led_red=0x00000000L;
3142  0367 ae0000        	ldw	x,#0
3143  036a bf10          	ldw	_led_red+2,x
3144  036c ae0000        	ldw	x,#0
3145  036f bf0e          	ldw	_led_red,x
3146                     ; 369 			led_green=0xffffffffL;
3148  0371 aeffff        	ldw	x,#65535
3149  0374 bf14          	ldw	_led_green+2,x
3150  0376 aeffff        	ldw	x,#-1
3151  0379 bf12          	ldw	_led_green,x
3153  037b 2070          	jra	L5761
3154  037d               L1171:
3155                     ; 373 		else if((flags&0b00111110)==0b00000100)
3157  037d b605          	ld	a,_flags
3158  037f a43e          	and	a,#62
3159  0381 a104          	cp	a,#4
3160  0383 2616          	jrne	L5171
3161                     ; 375 			led_red=0x00010001L;
3163  0385 ae0001        	ldw	x,#1
3164  0388 bf10          	ldw	_led_red+2,x
3165  038a ae0001        	ldw	x,#1
3166  038d bf0e          	ldw	_led_red,x
3167                     ; 376 			led_green=0xffffffffL;	
3169  038f aeffff        	ldw	x,#65535
3170  0392 bf14          	ldw	_led_green+2,x
3171  0394 aeffff        	ldw	x,#-1
3172  0397 bf12          	ldw	_led_green,x
3174  0399 2052          	jra	L5761
3175  039b               L5171:
3176                     ; 378 		else if(flags&0b00000010)
3178  039b b605          	ld	a,_flags
3179  039d a502          	bcp	a,#2
3180  039f 2716          	jreq	L1271
3181                     ; 380 			led_red=0x00010001L;
3183  03a1 ae0001        	ldw	x,#1
3184  03a4 bf10          	ldw	_led_red+2,x
3185  03a6 ae0001        	ldw	x,#1
3186  03a9 bf0e          	ldw	_led_red,x
3187                     ; 381 			led_green=0x00000000L;	
3189  03ab ae0000        	ldw	x,#0
3190  03ae bf14          	ldw	_led_green+2,x
3191  03b0 ae0000        	ldw	x,#0
3192  03b3 bf12          	ldw	_led_green,x
3194  03b5 2036          	jra	L5761
3195  03b7               L1271:
3196                     ; 383 		else if(flags&0b00001000)
3198  03b7 b605          	ld	a,_flags
3199  03b9 a508          	bcp	a,#8
3200  03bb 2716          	jreq	L5271
3201                     ; 385 			led_red=0x00090009L;
3203  03bd ae0009        	ldw	x,#9
3204  03c0 bf10          	ldw	_led_red+2,x
3205  03c2 ae0009        	ldw	x,#9
3206  03c5 bf0e          	ldw	_led_red,x
3207                     ; 386 			led_green=0x00000000L;	
3209  03c7 ae0000        	ldw	x,#0
3210  03ca bf14          	ldw	_led_green+2,x
3211  03cc ae0000        	ldw	x,#0
3212  03cf bf12          	ldw	_led_green,x
3214  03d1 201a          	jra	L5761
3215  03d3               L5271:
3216                     ; 388 		else if(flags&0b00010000)
3218  03d3 b605          	ld	a,_flags
3219  03d5 a510          	bcp	a,#16
3220  03d7 2714          	jreq	L5761
3221                     ; 390 			led_red=0x00490049L;
3223  03d9 ae0049        	ldw	x,#73
3224  03dc bf10          	ldw	_led_red+2,x
3225  03de ae0049        	ldw	x,#73
3226  03e1 bf0e          	ldw	_led_red,x
3227                     ; 391 			led_green=0xffffffffL;	
3229  03e3 aeffff        	ldw	x,#65535
3230  03e6 bf14          	ldw	_led_green+2,x
3231  03e8 aeffff        	ldw	x,#-1
3232  03eb bf12          	ldw	_led_green,x
3233  03ed               L5761:
3234                     ; 551 }
3237  03ed 81            	ret
3265                     ; 554 void led_drv(void)
3265                     ; 555 {
3266                     	switch	.text
3267  03ee               _led_drv:
3271                     ; 557 GPIOA->DDR|=(1<<4);
3273  03ee 72185002      	bset	20482,#4
3274                     ; 558 GPIOA->CR1|=(1<<4);
3276  03f2 72185003      	bset	20483,#4
3277                     ; 559 GPIOA->CR2&=~(1<<4);
3279  03f6 72195004      	bres	20484,#4
3280                     ; 560 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3282  03fa b64b          	ld	a,_led_red_buff+3
3283  03fc a501          	bcp	a,#1
3284  03fe 2706          	jreq	L3471
3287  0400 72185000      	bset	20480,#4
3289  0404 2004          	jra	L5471
3290  0406               L3471:
3291                     ; 561 else GPIOA->ODR&=~(1<<4); 
3293  0406 72195000      	bres	20480,#4
3294  040a               L5471:
3295                     ; 564 GPIOA->DDR|=(1<<5);
3297  040a 721a5002      	bset	20482,#5
3298                     ; 565 GPIOA->CR1|=(1<<5);
3300  040e 721a5003      	bset	20483,#5
3301                     ; 566 GPIOA->CR2&=~(1<<5);	
3303  0412 721b5004      	bres	20484,#5
3304                     ; 567 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3306  0416 b647          	ld	a,_led_green_buff+3
3307  0418 a501          	bcp	a,#1
3308  041a 2706          	jreq	L7471
3311  041c 721a5000      	bset	20480,#5
3313  0420 2004          	jra	L1571
3314  0422               L7471:
3315                     ; 568 else GPIOA->ODR&=~(1<<5);
3317  0422 721b5000      	bres	20480,#5
3318  0426               L1571:
3319                     ; 571 led_red_buff>>=1;
3321  0426 3748          	sra	_led_red_buff
3322  0428 3649          	rrc	_led_red_buff+1
3323  042a 364a          	rrc	_led_red_buff+2
3324  042c 364b          	rrc	_led_red_buff+3
3325                     ; 572 led_green_buff>>=1;
3327  042e 3744          	sra	_led_green_buff
3328  0430 3645          	rrc	_led_green_buff+1
3329  0432 3646          	rrc	_led_green_buff+2
3330  0434 3647          	rrc	_led_green_buff+3
3331                     ; 573 if(++led_drv_cnt>32)
3333  0436 3c16          	inc	_led_drv_cnt
3334  0438 b616          	ld	a,_led_drv_cnt
3335  043a a121          	cp	a,#33
3336  043c 2512          	jrult	L3571
3337                     ; 575 	led_drv_cnt=0;
3339  043e 3f16          	clr	_led_drv_cnt
3340                     ; 576 	led_red_buff=led_red;
3342  0440 be10          	ldw	x,_led_red+2
3343  0442 bf4a          	ldw	_led_red_buff+2,x
3344  0444 be0e          	ldw	x,_led_red
3345  0446 bf48          	ldw	_led_red_buff,x
3346                     ; 577 	led_green_buff=led_green;
3348  0448 be14          	ldw	x,_led_green+2
3349  044a bf46          	ldw	_led_green_buff+2,x
3350  044c be12          	ldw	x,_led_green
3351  044e bf44          	ldw	_led_green_buff,x
3352  0450               L3571:
3353                     ; 583 } 
3356  0450 81            	ret
3382                     ; 586 void JP_drv(void)
3382                     ; 587 {
3383                     	switch	.text
3384  0451               _JP_drv:
3388                     ; 589 GPIOD->DDR&=~(1<<6);
3390  0451 721d5011      	bres	20497,#6
3391                     ; 590 GPIOD->CR1|=(1<<6);
3393  0455 721c5012      	bset	20498,#6
3394                     ; 591 GPIOD->CR2&=~(1<<6);
3396  0459 721d5013      	bres	20499,#6
3397                     ; 593 GPIOD->DDR&=~(1<<7);
3399  045d 721f5011      	bres	20497,#7
3400                     ; 594 GPIOD->CR1|=(1<<7);
3402  0461 721e5012      	bset	20498,#7
3403                     ; 595 GPIOD->CR2&=~(1<<7);
3405  0465 721f5013      	bres	20499,#7
3406                     ; 597 if(GPIOD->IDR&(1<<6))
3408  0469 c65010        	ld	a,20496
3409  046c a540          	bcp	a,#64
3410  046e 270a          	jreq	L5671
3411                     ; 599 	if(cnt_JP0<10)
3413  0470 b654          	ld	a,_cnt_JP0
3414  0472 a10a          	cp	a,#10
3415  0474 2411          	jruge	L1771
3416                     ; 601 		cnt_JP0++;
3418  0476 3c54          	inc	_cnt_JP0
3419  0478 200d          	jra	L1771
3420  047a               L5671:
3421                     ; 604 else if(!(GPIOD->IDR&(1<<6)))
3423  047a c65010        	ld	a,20496
3424  047d a540          	bcp	a,#64
3425  047f 2606          	jrne	L1771
3426                     ; 606 	if(cnt_JP0)
3428  0481 3d54          	tnz	_cnt_JP0
3429  0483 2702          	jreq	L1771
3430                     ; 608 		cnt_JP0--;
3432  0485 3a54          	dec	_cnt_JP0
3433  0487               L1771:
3434                     ; 612 if(GPIOD->IDR&(1<<7))
3436  0487 c65010        	ld	a,20496
3437  048a a580          	bcp	a,#128
3438  048c 270a          	jreq	L7771
3439                     ; 614 	if(cnt_JP1<10)
3441  048e b653          	ld	a,_cnt_JP1
3442  0490 a10a          	cp	a,#10
3443  0492 2411          	jruge	L3002
3444                     ; 616 		cnt_JP1++;
3446  0494 3c53          	inc	_cnt_JP1
3447  0496 200d          	jra	L3002
3448  0498               L7771:
3449                     ; 619 else if(!(GPIOD->IDR&(1<<7)))
3451  0498 c65010        	ld	a,20496
3452  049b a580          	bcp	a,#128
3453  049d 2606          	jrne	L3002
3454                     ; 621 	if(cnt_JP1)
3456  049f 3d53          	tnz	_cnt_JP1
3457  04a1 2702          	jreq	L3002
3458                     ; 623 		cnt_JP1--;
3460  04a3 3a53          	dec	_cnt_JP1
3461  04a5               L3002:
3462                     ; 628 if((cnt_JP0==10)&&(cnt_JP1==10))
3464  04a5 b654          	ld	a,_cnt_JP0
3465  04a7 a10a          	cp	a,#10
3466  04a9 2608          	jrne	L1102
3468  04ab b653          	ld	a,_cnt_JP1
3469  04ad a10a          	cp	a,#10
3470  04af 2602          	jrne	L1102
3471                     ; 630 	jp_mode=jp0;
3473  04b1 3f55          	clr	_jp_mode
3474  04b3               L1102:
3475                     ; 632 if((cnt_JP0==0)&&(cnt_JP1==10))
3477  04b3 3d54          	tnz	_cnt_JP0
3478  04b5 260a          	jrne	L3102
3480  04b7 b653          	ld	a,_cnt_JP1
3481  04b9 a10a          	cp	a,#10
3482  04bb 2604          	jrne	L3102
3483                     ; 634 	jp_mode=jp1;
3485  04bd 35010055      	mov	_jp_mode,#1
3486  04c1               L3102:
3487                     ; 636 if((cnt_JP0==10)&&(cnt_JP1==0))
3489  04c1 b654          	ld	a,_cnt_JP0
3490  04c3 a10a          	cp	a,#10
3491  04c5 2608          	jrne	L5102
3493  04c7 3d53          	tnz	_cnt_JP1
3494  04c9 2604          	jrne	L5102
3495                     ; 638 	jp_mode=jp2;
3497  04cb 35020055      	mov	_jp_mode,#2
3498  04cf               L5102:
3499                     ; 640 if((cnt_JP0==0)&&(cnt_JP1==0))
3501  04cf 3d54          	tnz	_cnt_JP0
3502  04d1 2608          	jrne	L7102
3504  04d3 3d53          	tnz	_cnt_JP1
3505  04d5 2604          	jrne	L7102
3506                     ; 642 	jp_mode=jp3;
3508  04d7 35030055      	mov	_jp_mode,#3
3509  04db               L7102:
3510                     ; 645 }
3513  04db 81            	ret
3545                     ; 648 void link_drv(void)		//10Hz
3545                     ; 649 {
3546                     	switch	.text
3547  04dc               _link_drv:
3551                     ; 650 if(jp_mode!=jp3)
3553  04dc b655          	ld	a,_jp_mode
3554  04de a103          	cp	a,#3
3555  04e0 274d          	jreq	L1302
3556                     ; 652 	if(link_cnt<602)link_cnt++;
3558  04e2 9c            	rvf
3559  04e3 be6e          	ldw	x,_link_cnt
3560  04e5 a3025a        	cpw	x,#602
3561  04e8 2e07          	jrsge	L3302
3564  04ea be6e          	ldw	x,_link_cnt
3565  04ec 1c0001        	addw	x,#1
3566  04ef bf6e          	ldw	_link_cnt,x
3567  04f1               L3302:
3568                     ; 653 	if(link_cnt==90)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
3570  04f1 be6e          	ldw	x,_link_cnt
3571  04f3 a3005a        	cpw	x,#90
3572  04f6 2606          	jrne	L5302
3575  04f8 b605          	ld	a,_flags
3576  04fa a4c1          	and	a,#193
3577  04fc b705          	ld	_flags,a
3578  04fe               L5302:
3579                     ; 654 	if(link_cnt==100)
3581  04fe be6e          	ldw	x,_link_cnt
3582  0500 a30064        	cpw	x,#100
3583  0503 262e          	jrne	L7402
3584                     ; 656 		link=OFF;
3586  0505 35aa0070      	mov	_link,#170
3587                     ; 661 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
3589  0509 b60b          	ld	a,_bps_class
3590  050b a101          	cp	a,#1
3591  050d 2606          	jrne	L1402
3594  050f 72100001      	bset	_bMAIN
3596  0513 2004          	jra	L3402
3597  0515               L1402:
3598                     ; 662 		else bMAIN=0;
3600  0515 72110001      	bres	_bMAIN
3601  0519               L3402:
3602                     ; 664 		cnt_net_drv=0;
3604  0519 3f3d          	clr	_cnt_net_drv
3605                     ; 665     		if(!res_fl_)
3607  051b 725d000a      	tnz	_res_fl_
3608  051f 2612          	jrne	L7402
3609                     ; 667 	    		bRES_=1;
3611  0521 3501000d      	mov	_bRES_,#1
3612                     ; 668 	    		res_fl_=1;
3614  0525 a601          	ld	a,#1
3615  0527 ae000a        	ldw	x,#_res_fl_
3616  052a cd0000        	call	c_eewrc
3618  052d 2004          	jra	L7402
3619  052f               L1302:
3620                     ; 672 else link=OFF;	
3622  052f 35aa0070      	mov	_link,#170
3623  0533               L7402:
3624                     ; 673 } 
3627  0533 81            	ret
3696                     	switch	.const
3697  0004               L63:
3698  0004 00000064      	dc.l	100
3699  0008               L04:
3700  0008 00000bb9      	dc.l	3001
3701  000c               L24:
3702  000c 0000012c      	dc.l	300
3703  0010               L44:
3704  0010 00000004      	dc.l	4
3705  0014               L64:
3706  0014 00000190      	dc.l	400
3707                     ; 677 void vent_drv(void)
3707                     ; 678 {
3708                     	switch	.text
3709  0534               _vent_drv:
3711  0534 520c          	subw	sp,#12
3712       0000000c      OFST:	set	12
3715                     ; 681 	short vent_pwm_i_necc=400;
3717  0536 ae0190        	ldw	x,#400
3718  0539 1f05          	ldw	(OFST-7,sp),x
3719                     ; 682 	short vent_pwm_t_necc=400;
3721  053b ae0190        	ldw	x,#400
3722  053e 1f07          	ldw	(OFST-5,sp),x
3723                     ; 683 	short vent_pwm_max_necc=400;
3725                     ; 689 	tempSL=(signed long)I;
3727  0540 ce001a        	ldw	x,_I
3728  0543 cd0000        	call	c_itolx
3730  0546 96            	ldw	x,sp
3731  0547 1c0009        	addw	x,#OFST-3
3732  054a cd0000        	call	c_rtol
3734                     ; 690 	tempSL*=(signed long)Ui;
3736  054d ce0016        	ldw	x,_Ui
3737  0550 cd0000        	call	c_itolx
3739  0553 96            	ldw	x,sp
3740  0554 1c0009        	addw	x,#OFST-3
3741  0557 cd0000        	call	c_lgmul
3743                     ; 691 	tempSL/=100L;
3745  055a 96            	ldw	x,sp
3746  055b 1c0009        	addw	x,#OFST-3
3747  055e cd0000        	call	c_ltor
3749  0561 ae0004        	ldw	x,#L63
3750  0564 cd0000        	call	c_ldiv
3752  0567 96            	ldw	x,sp
3753  0568 1c0009        	addw	x,#OFST-3
3754  056b cd0000        	call	c_rtol
3756                     ; 699 	if(tempSL>3000L)vent_pwm_i_necc=1000;
3758  056e 9c            	rvf
3759  056f 96            	ldw	x,sp
3760  0570 1c0009        	addw	x,#OFST-3
3761  0573 cd0000        	call	c_ltor
3763  0576 ae0008        	ldw	x,#L04
3764  0579 cd0000        	call	c_lcmp
3766  057c 2f07          	jrslt	L3012
3769  057e ae03e8        	ldw	x,#1000
3770  0581 1f05          	ldw	(OFST-7,sp),x
3772  0583 2032          	jra	L5012
3773  0585               L3012:
3774                     ; 700 	else if(tempSL<300L)vent_pwm_i_necc=0;
3776  0585 9c            	rvf
3777  0586 96            	ldw	x,sp
3778  0587 1c0009        	addw	x,#OFST-3
3779  058a cd0000        	call	c_ltor
3781  058d ae000c        	ldw	x,#L24
3782  0590 cd0000        	call	c_lcmp
3784  0593 2e05          	jrsge	L7012
3787  0595 5f            	clrw	x
3788  0596 1f05          	ldw	(OFST-7,sp),x
3790  0598 201d          	jra	L5012
3791  059a               L7012:
3792                     ; 701 	else vent_pwm_i_necc=(short)(400L + ((tempSL-300L)/4L));
3794  059a 96            	ldw	x,sp
3795  059b 1c0009        	addw	x,#OFST-3
3796  059e cd0000        	call	c_ltor
3798  05a1 ae000c        	ldw	x,#L24
3799  05a4 cd0000        	call	c_lsub
3801  05a7 ae0010        	ldw	x,#L44
3802  05aa cd0000        	call	c_ldiv
3804  05ad ae0014        	ldw	x,#L64
3805  05b0 cd0000        	call	c_ladd
3807  05b3 be02          	ldw	x,c_lreg+2
3808  05b5 1f05          	ldw	(OFST-7,sp),x
3809  05b7               L5012:
3810                     ; 702 	gran(&vent_pwm_i_necc,0,1000);
3812  05b7 ae03e8        	ldw	x,#1000
3813  05ba 89            	pushw	x
3814  05bb 5f            	clrw	x
3815  05bc 89            	pushw	x
3816  05bd 96            	ldw	x,sp
3817  05be 1c0009        	addw	x,#OFST-3
3818  05c1 cd00d5        	call	_gran
3820  05c4 5b04          	addw	sp,#4
3821                     ; 704 	tempSL=(signed long)T;
3823  05c6 b675          	ld	a,_T
3824  05c8 b703          	ld	c_lreg+3,a
3825  05ca 48            	sll	a
3826  05cb 4f            	clr	a
3827  05cc a200          	sbc	a,#0
3828  05ce b702          	ld	c_lreg+2,a
3829  05d0 b701          	ld	c_lreg+1,a
3830  05d2 b700          	ld	c_lreg,a
3831  05d4 96            	ldw	x,sp
3832  05d5 1c0009        	addw	x,#OFST-3
3833  05d8 cd0000        	call	c_rtol
3835                     ; 705 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
3837  05db 9c            	rvf
3838  05dc ce000e        	ldw	x,_ee_tsign
3839  05df cd0000        	call	c_itolx
3841  05e2 a61e          	ld	a,#30
3842  05e4 cd0000        	call	c_lsbc
3844  05e7 96            	ldw	x,sp
3845  05e8 1c0009        	addw	x,#OFST-3
3846  05eb cd0000        	call	c_lcmp
3848  05ee 2f05          	jrslt	L3112
3851  05f0 5f            	clrw	x
3852  05f1 1f07          	ldw	(OFST-5,sp),x
3854  05f3 2030          	jra	L5112
3855  05f5               L3112:
3856                     ; 706 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
3858  05f5 9c            	rvf
3859  05f6 ce000e        	ldw	x,_ee_tsign
3860  05f9 cd0000        	call	c_itolx
3862  05fc 96            	ldw	x,sp
3863  05fd 1c0009        	addw	x,#OFST-3
3864  0600 cd0000        	call	c_lcmp
3866  0603 2c07          	jrsgt	L7112
3869  0605 ae03e8        	ldw	x,#1000
3870  0608 1f07          	ldw	(OFST-5,sp),x
3872  060a 2019          	jra	L5112
3873  060c               L7112:
3874                     ; 707 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
3876  060c ce000e        	ldw	x,_ee_tsign
3877  060f 1d001e        	subw	x,#30
3878  0612 1f01          	ldw	(OFST-11,sp),x
3879  0614 1e0b          	ldw	x,(OFST-1,sp)
3880  0616 72f001        	subw	x,(OFST-11,sp)
3881  0619 90ae0014      	ldw	y,#20
3882  061d cd0000        	call	c_imul
3884  0620 1c0190        	addw	x,#400
3885  0623 1f07          	ldw	(OFST-5,sp),x
3886  0625               L5112:
3887                     ; 708 	gran(&vent_pwm_t_necc,0,1000);
3889  0625 ae03e8        	ldw	x,#1000
3890  0628 89            	pushw	x
3891  0629 5f            	clrw	x
3892  062a 89            	pushw	x
3893  062b 96            	ldw	x,sp
3894  062c 1c000b        	addw	x,#OFST-1
3895  062f cd00d5        	call	_gran
3897  0632 5b04          	addw	sp,#4
3898                     ; 710 	vent_pwm_max_necc=vent_pwm_i_necc;
3900  0634 1e05          	ldw	x,(OFST-7,sp)
3901  0636 1f03          	ldw	(OFST-9,sp),x
3902                     ; 711 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3904  0638 9c            	rvf
3905  0639 1e07          	ldw	x,(OFST-5,sp)
3906  063b 1305          	cpw	x,(OFST-7,sp)
3907  063d 2d04          	jrsle	L3212
3910  063f 1e07          	ldw	x,(OFST-5,sp)
3911  0641 1f03          	ldw	(OFST-9,sp),x
3912  0643               L3212:
3913                     ; 713 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3915  0643 9c            	rvf
3916  0644 be10          	ldw	x,_vent_pwm
3917  0646 1303          	cpw	x,(OFST-9,sp)
3918  0648 2e07          	jrsge	L5212
3921  064a be10          	ldw	x,_vent_pwm
3922  064c 1c000a        	addw	x,#10
3923  064f bf10          	ldw	_vent_pwm,x
3924  0651               L5212:
3925                     ; 714 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3927  0651 9c            	rvf
3928  0652 be10          	ldw	x,_vent_pwm
3929  0654 1303          	cpw	x,(OFST-9,sp)
3930  0656 2d07          	jrsle	L7212
3933  0658 be10          	ldw	x,_vent_pwm
3934  065a 1d000a        	subw	x,#10
3935  065d bf10          	ldw	_vent_pwm,x
3936  065f               L7212:
3937                     ; 715 	gran(&vent_pwm,0,1000);
3939  065f ae03e8        	ldw	x,#1000
3940  0662 89            	pushw	x
3941  0663 5f            	clrw	x
3942  0664 89            	pushw	x
3943  0665 ae0010        	ldw	x,#_vent_pwm
3944  0668 cd00d5        	call	_gran
3946  066b 5b04          	addw	sp,#4
3947                     ; 721 	if(vent_pwm_integr_cnt<10)
3949  066d 9c            	rvf
3950  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3951  0670 a3000a        	cpw	x,#10
3952  0673 2e26          	jrsge	L1312
3953                     ; 723 		vent_pwm_integr_cnt++;
3955  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3956  0677 1c0001        	addw	x,#1
3957  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3958                     ; 724 		if(vent_pwm_integr_cnt>=10)
3960  067c 9c            	rvf
3961  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3962  067f a3000a        	cpw	x,#10
3963  0682 2f17          	jrslt	L1312
3964                     ; 726 			vent_pwm_integr_cnt=0;
3966  0684 5f            	clrw	x
3967  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3968                     ; 727 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3970  0687 be0e          	ldw	x,_vent_pwm_integr
3971  0689 90ae0009      	ldw	y,#9
3972  068d cd0000        	call	c_imul
3974  0690 72bb0010      	addw	x,_vent_pwm
3975  0694 a60a          	ld	a,#10
3976  0696 cd0000        	call	c_sdivx
3978  0699 bf0e          	ldw	_vent_pwm_integr,x
3979  069b               L1312:
3980                     ; 730 	gran(&vent_pwm_integr,0,1000);
3982  069b ae03e8        	ldw	x,#1000
3983  069e 89            	pushw	x
3984  069f 5f            	clrw	x
3985  06a0 89            	pushw	x
3986  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3987  06a4 cd00d5        	call	_gran
3989  06a7 5b04          	addw	sp,#4
3990                     ; 734 }
3993  06a9 5b0c          	addw	sp,#12
3994  06ab 81            	ret
4020                     ; 739 void pwr_drv(void)
4020                     ; 740 {
4021                     	switch	.text
4022  06ac               _pwr_drv:
4026                     ; 746 BLOCK_INIT
4028  06ac 721a500c      	bset	20492,#5
4031  06b0 721a500d      	bset	20493,#5
4034  06b4 721b500e      	bres	20494,#5
4035                     ; 748 if(main_cnt1<1500)main_cnt1++;
4037  06b8 9c            	rvf
4038  06b9 be5e          	ldw	x,_main_cnt1
4039  06bb a305dc        	cpw	x,#1500
4040  06be 2e07          	jrsge	L5412
4043  06c0 be5e          	ldw	x,_main_cnt1
4044  06c2 1c0001        	addw	x,#1
4045  06c5 bf5e          	ldw	_main_cnt1,x
4046  06c7               L5412:
4047                     ; 750 if(flags&0b00101010)BLOCK_ON //GPIOB->ODR|=(1<<2);
4049  06c7 b605          	ld	a,_flags
4050  06c9 a52a          	bcp	a,#42
4051  06cb 270a          	jreq	L7412
4054  06cd 721a500a      	bset	20490,#5
4057  06d1 35010000      	mov	_bVENT_BLOCK,#1
4059  06d5 2006          	jra	L1512
4060  06d7               L7412:
4061                     ; 751 else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4063  06d7 721b500a      	bres	20490,#5
4066  06db 3f00          	clr	_bVENT_BLOCK
4067  06dd               L1512:
4068                     ; 824 }
4071  06dd 81            	ret
4138                     	switch	.const
4139  0018               L45:
4140  0018 0000028a      	dc.l	650
4141                     ; 829 void pwr_hndl(void)				
4141                     ; 830 {
4142                     	switch	.text
4143  06de               _pwr_hndl:
4145  06de 5205          	subw	sp,#5
4146       00000005      OFST:	set	5
4149                     ; 831 if(jp_mode==jp3)
4151  06e0 b655          	ld	a,_jp_mode
4152  06e2 a103          	cp	a,#3
4153  06e4 260a          	jrne	L1022
4154                     ; 833 	pwm_u=0;
4156  06e6 5f            	clrw	x
4157  06e7 bf08          	ldw	_pwm_u,x
4158                     ; 834 	pwm_i=0;
4160  06e9 5f            	clrw	x
4161  06ea bf0a          	ldw	_pwm_i,x
4163  06ec ac520852      	jpf	L3022
4164  06f0               L1022:
4165                     ; 836 else if(jp_mode==jp2)
4167  06f0 b655          	ld	a,_jp_mode
4168  06f2 a102          	cp	a,#2
4169  06f4 260c          	jrne	L5022
4170                     ; 838 	pwm_u=0;
4172  06f6 5f            	clrw	x
4173  06f7 bf08          	ldw	_pwm_u,x
4174                     ; 839 	pwm_i=0x7ff;
4176  06f9 ae07ff        	ldw	x,#2047
4177  06fc bf0a          	ldw	_pwm_i,x
4179  06fe ac520852      	jpf	L3022
4180  0702               L5022:
4181                     ; 841 else if(jp_mode==jp1)
4183  0702 b655          	ld	a,_jp_mode
4184  0704 a101          	cp	a,#1
4185  0706 260e          	jrne	L1122
4186                     ; 843 	pwm_u=0x7ff;
4188  0708 ae07ff        	ldw	x,#2047
4189  070b bf08          	ldw	_pwm_u,x
4190                     ; 844 	pwm_i=0x7ff;
4192  070d ae07ff        	ldw	x,#2047
4193  0710 bf0a          	ldw	_pwm_i,x
4195  0712 ac520852      	jpf	L3022
4196  0716               L1122:
4197                     ; 855 else if(link==OFF)
4199  0716 b670          	ld	a,_link
4200  0718 a1aa          	cp	a,#170
4201  071a 2703          	jreq	L65
4202  071c cc07cf        	jp	L5122
4203  071f               L65:
4204                     ; 857 	pwm_i=0x7ff;
4206  071f ae07ff        	ldw	x,#2047
4207  0722 bf0a          	ldw	_pwm_i,x
4208                     ; 858 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4210  0724 ce0014        	ldw	x,_Unecc
4211  0727 90ae07d0      	ldw	y,#2000
4212  072b cd0000        	call	c_vmul
4214  072e ae0018        	ldw	x,#L45
4215  0731 cd0000        	call	c_ldiv
4217  0734 be02          	ldw	x,c_lreg+2
4218  0736 bf58          	ldw	_pwm_u_,x
4219                     ; 862 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4221  0738 c6001d        	ld	a,_pwm_u_buff_ptr
4222  073b 5f            	clrw	x
4223  073c 97            	ld	xl,a
4224  073d 58            	sllw	x
4225  073e 90be58        	ldw	y,_pwm_u_
4226  0741 df0020        	ldw	(_pwm_u_buff,x),y
4227                     ; 863 	pwm_u_buff_ptr++;
4229  0744 725c001d      	inc	_pwm_u_buff_ptr
4230                     ; 864 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4232  0748 c6001d        	ld	a,_pwm_u_buff_ptr
4233  074b a110          	cp	a,#16
4234  074d 2504          	jrult	L7122
4237  074f 725f001d      	clr	_pwm_u_buff_ptr
4238  0753               L7122:
4239                     ; 868 		tempSL=0;
4241  0753 ae0000        	ldw	x,#0
4242  0756 1f03          	ldw	(OFST-2,sp),x
4243  0758 ae0000        	ldw	x,#0
4244  075b 1f01          	ldw	(OFST-4,sp),x
4245                     ; 869 		for(i=0;i<16;i++)
4247  075d 0f05          	clr	(OFST+0,sp)
4248  075f               L1222:
4249                     ; 871 			tempSL+=(signed long)pwm_u_buff[i];
4251  075f 7b05          	ld	a,(OFST+0,sp)
4252  0761 5f            	clrw	x
4253  0762 97            	ld	xl,a
4254  0763 58            	sllw	x
4255  0764 de0020        	ldw	x,(_pwm_u_buff,x)
4256  0767 cd0000        	call	c_itolx
4258  076a 96            	ldw	x,sp
4259  076b 1c0001        	addw	x,#OFST-4
4260  076e cd0000        	call	c_lgadd
4262                     ; 869 		for(i=0;i<16;i++)
4264  0771 0c05          	inc	(OFST+0,sp)
4267  0773 7b05          	ld	a,(OFST+0,sp)
4268  0775 a110          	cp	a,#16
4269  0777 25e6          	jrult	L1222
4270                     ; 873 		tempSL>>=4;
4272  0779 96            	ldw	x,sp
4273  077a 1c0001        	addw	x,#OFST-4
4274  077d a604          	ld	a,#4
4275  077f cd0000        	call	c_lgrsh
4277                     ; 874 		pwm_u_buff_=(signed short)tempSL;
4279  0782 1e03          	ldw	x,(OFST-2,sp)
4280  0784 cf001e        	ldw	_pwm_u_buff_,x
4281                     ; 876 	pwm_u=pwm_u_;
4283  0787 be58          	ldw	x,_pwm_u_
4284  0789 bf08          	ldw	_pwm_u,x
4285                     ; 877 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4287  078b 9c            	rvf
4288  078c ce0016        	ldw	x,_Ui
4289  078f 72b00014      	subw	x,_Unecc
4290  0793 cd0000        	call	_abs
4292  0796 a30014        	cpw	x,#20
4293  0799 2e06          	jrsge	L7222
4296  079b 725c001c      	inc	_pwm_u_buff_cnt
4298  079f 2004          	jra	L1322
4299  07a1               L7222:
4300                     ; 878 	else pwm_u_buff_cnt=0;
4302  07a1 725f001c      	clr	_pwm_u_buff_cnt
4303  07a5               L1322:
4304                     ; 880 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4306  07a5 c6001c        	ld	a,_pwm_u_buff_cnt
4307  07a8 a114          	cp	a,#20
4308  07aa 2504          	jrult	L3322
4311  07ac 3514001c      	mov	_pwm_u_buff_cnt,#20
4312  07b0               L3322:
4313                     ; 881 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4315  07b0 c6001c        	ld	a,_pwm_u_buff_cnt
4316  07b3 a10f          	cp	a,#15
4317  07b5 2505          	jrult	L5322
4320  07b7 ce001e        	ldw	x,_pwm_u_buff_
4321  07ba bf08          	ldw	_pwm_u,x
4322  07bc               L5322:
4323                     ; 884 	if(flags&0b00011010)					//если есть аварии
4325  07bc b605          	ld	a,_flags
4326  07be a51a          	bcp	a,#26
4327  07c0 2603          	jrne	L06
4328  07c2 cc0852        	jp	L3022
4329  07c5               L06:
4330                     ; 886 		pwm_u=0;								//то полный стоп
4332  07c5 5f            	clrw	x
4333  07c6 bf08          	ldw	_pwm_u,x
4334                     ; 887 		pwm_i=0;
4336  07c8 5f            	clrw	x
4337  07c9 bf0a          	ldw	_pwm_i,x
4338  07cb ac520852      	jpf	L3022
4339  07cf               L5122:
4340                     ; 891 else	if(link==ON)				//если есть связьvol_i_temp_avar
4342  07cf b670          	ld	a,_link
4343  07d1 a155          	cp	a,#85
4344  07d3 267d          	jrne	L3022
4345                     ; 893 	if((flags&0b00100000)==0)	//если нет блокировки извне
4347  07d5 b605          	ld	a,_flags
4348  07d7 a520          	bcp	a,#32
4349  07d9 266b          	jrne	L5422
4350                     ; 895 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4352  07db b605          	ld	a,_flags
4353  07dd a51a          	bcp	a,#26
4354  07df 260b          	jrne	L7422
4355                     ; 897 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4357  07e1 be63          	ldw	x,_vol_i_temp
4358  07e3 bf08          	ldw	_pwm_u,x
4359                     ; 898 			pwm_i=2000;
4361  07e5 ae07d0        	ldw	x,#2000
4362  07e8 bf0a          	ldw	_pwm_i,x
4364  07ea 2066          	jra	L3022
4365  07ec               L7422:
4366                     ; 900 		else if(flags&0b00011010)					//если есть аварии
4368  07ec b605          	ld	a,_flags
4369  07ee a51a          	bcp	a,#26
4370  07f0 2708          	jreq	L3522
4371                     ; 902 			pwm_u=0;								//то полный стоп
4373  07f2 5f            	clrw	x
4374  07f3 bf08          	ldw	_pwm_u,x
4375                     ; 903 			pwm_i=0;
4377  07f5 5f            	clrw	x
4378  07f6 bf0a          	ldw	_pwm_i,x
4380  07f8 2058          	jra	L3022
4381  07fa               L3522:
4382                     ; 908 			if(vol_i_temp==2000)
4384  07fa be63          	ldw	x,_vol_i_temp
4385  07fc a307d0        	cpw	x,#2000
4386  07ff 260c          	jrne	L7522
4387                     ; 910 				pwm_u=2000;
4389  0801 ae07d0        	ldw	x,#2000
4390  0804 bf08          	ldw	_pwm_u,x
4391                     ; 911 				pwm_i=2000;
4393  0806 ae07d0        	ldw	x,#2000
4394  0809 bf0a          	ldw	_pwm_i,x
4396  080b 201d          	jra	L1622
4397  080d               L7522:
4398                     ; 916 				tempI=(int)(Ui-Unecc);
4400  080d ce0016        	ldw	x,_Ui
4401  0810 72b00014      	subw	x,_Unecc
4402  0814 1f04          	ldw	(OFST-1,sp),x
4403                     ; 917 				if((tempI>20)||(tempI<-80))pwm_u_cnt=19;
4405  0816 9c            	rvf
4406  0817 1e04          	ldw	x,(OFST-1,sp)
4407  0819 a30015        	cpw	x,#21
4408  081c 2e08          	jrsge	L5622
4410  081e 9c            	rvf
4411  081f 1e04          	ldw	x,(OFST-1,sp)
4412  0821 a3ffb0        	cpw	x,#65456
4413  0824 2e04          	jrsge	L1622
4414  0826               L5622:
4417  0826 35130007      	mov	_pwm_u_cnt,#19
4418  082a               L1622:
4419                     ; 921 			if(pwm_u_cnt)
4421  082a 3d07          	tnz	_pwm_u_cnt
4422  082c 2724          	jreq	L3022
4423                     ; 923 				pwm_u_cnt--;
4425  082e 3a07          	dec	_pwm_u_cnt
4426                     ; 924 				pwm_u=(short)((2000L*((long)Unecc))/650L);
4428  0830 ce0014        	ldw	x,_Unecc
4429  0833 90ae07d0      	ldw	y,#2000
4430  0837 cd0000        	call	c_vmul
4432  083a ae0018        	ldw	x,#L45
4433  083d cd0000        	call	c_ldiv
4435  0840 be02          	ldw	x,c_lreg+2
4436  0842 bf08          	ldw	_pwm_u,x
4437  0844 200c          	jra	L3022
4438  0846               L5422:
4439                     ; 928 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4441  0846 b605          	ld	a,_flags
4442  0848 a520          	bcp	a,#32
4443  084a 2706          	jreq	L3022
4444                     ; 930 		pwm_u=0;
4446  084c 5f            	clrw	x
4447  084d bf08          	ldw	_pwm_u,x
4448                     ; 931 		pwm_i=0;
4450  084f 5f            	clrw	x
4451  0850 bf0a          	ldw	_pwm_i,x
4452  0852               L3022:
4453                     ; 959 if(pwm_u>2000)pwm_u=2000;
4455  0852 9c            	rvf
4456  0853 be08          	ldw	x,_pwm_u
4457  0855 a307d1        	cpw	x,#2001
4458  0858 2f05          	jrslt	L5722
4461  085a ae07d0        	ldw	x,#2000
4462  085d bf08          	ldw	_pwm_u,x
4463  085f               L5722:
4464                     ; 960 if(pwm_i>2000)pwm_i=2000;
4466  085f 9c            	rvf
4467  0860 be0a          	ldw	x,_pwm_i
4468  0862 a307d1        	cpw	x,#2001
4469  0865 2f05          	jrslt	L7722
4472  0867 ae07d0        	ldw	x,#2000
4473  086a bf0a          	ldw	_pwm_i,x
4474  086c               L7722:
4475                     ; 963 }
4478  086c 5b05          	addw	sp,#5
4479  086e 81            	ret
4558                     	switch	.const
4559  001c               L46:
4560  001c 0000000a      	dc.l	10
4561  0020               L66:
4562  0020 0000000f      	dc.l	15
4563  0024               L07:
4564  0024 000007f9      	dc.l	2041
4565  0028               L27:
4566  0028 000003e8      	dc.l	1000
4567                     ; 968 void pwr_hndl_new(void)				
4567                     ; 969 {
4568                     	switch	.text
4569  086f               _pwr_hndl_new:
4571  086f 5208          	subw	sp,#8
4572       00000008      OFST:	set	8
4575                     ; 970 if(jp_mode==jp3)
4577  0871 b655          	ld	a,_jp_mode
4578  0873 a103          	cp	a,#3
4579  0875 260a          	jrne	L3332
4580                     ; 972 	pwm_u=0;
4582  0877 5f            	clrw	x
4583  0878 bf08          	ldw	_pwm_u,x
4584                     ; 973 	pwm_i=0;
4586  087a 5f            	clrw	x
4587  087b bf0a          	ldw	_pwm_i,x
4589  087d ac820b82      	jpf	L5332
4590  0881               L3332:
4591                     ; 975 else if(jp_mode==jp2)
4593  0881 b655          	ld	a,_jp_mode
4594  0883 a102          	cp	a,#2
4595  0885 260c          	jrne	L7332
4596                     ; 977 	pwm_u=0;
4598  0887 5f            	clrw	x
4599  0888 bf08          	ldw	_pwm_u,x
4600                     ; 978 	pwm_i=0x7ff;
4602  088a ae07ff        	ldw	x,#2047
4603  088d bf0a          	ldw	_pwm_i,x
4605  088f ac820b82      	jpf	L5332
4606  0893               L7332:
4607                     ; 980 else if(jp_mode==jp1)
4609  0893 b655          	ld	a,_jp_mode
4610  0895 a101          	cp	a,#1
4611  0897 260e          	jrne	L3432
4612                     ; 982 	pwm_u=0x7ff;
4614  0899 ae07ff        	ldw	x,#2047
4615  089c bf08          	ldw	_pwm_u,x
4616                     ; 983 	pwm_i=0x7ff;
4618  089e ae07ff        	ldw	x,#2047
4619  08a1 bf0a          	ldw	_pwm_i,x
4621  08a3 ac820b82      	jpf	L5332
4622  08a7               L3432:
4623                     ; 994 else if(link==OFF)
4625  08a7 b670          	ld	a,_link
4626  08a9 a1aa          	cp	a,#170
4627  08ab 2703          	jreq	L47
4628  08ad cc0968        	jp	L7432
4629  08b0               L47:
4630                     ; 999 		temp_SL=(signed long)(ee_UAVT);
4632  08b0 ce000c        	ldw	x,_ee_UAVT
4633  08b3 cd0000        	call	c_itolx
4635  08b6 96            	ldw	x,sp
4636  08b7 1c0005        	addw	x,#OFST-3
4637  08ba cd0000        	call	c_rtol
4639                     ; 1007 		temp_SL1=(signed long)(I-250);   //ток после 25А на 1А отнимаем 0.1В
4641  08bd ce001a        	ldw	x,_I
4642  08c0 1d00fa        	subw	x,#250
4643  08c3 cd0000        	call	c_itolx
4645  08c6 96            	ldw	x,sp
4646  08c7 1c0001        	addw	x,#OFST-7
4647  08ca cd0000        	call	c_rtol
4649                     ; 1009 		if(temp_SL1<0) temp_SL1=0;
4651  08cd 9c            	rvf
4652  08ce 0d01          	tnz	(OFST-7,sp)
4653  08d0 2e0a          	jrsge	L1532
4656  08d2 ae0000        	ldw	x,#0
4657  08d5 1f03          	ldw	(OFST-5,sp),x
4658  08d7 ae0000        	ldw	x,#0
4659  08da 1f01          	ldw	(OFST-7,sp),x
4660  08dc               L1532:
4661                     ; 1011 		temp_SL-=temp_SL1/10;
4663  08dc 96            	ldw	x,sp
4664  08dd 1c0001        	addw	x,#OFST-7
4665  08e0 cd0000        	call	c_ltor
4667  08e3 ae001c        	ldw	x,#L46
4668  08e6 cd0000        	call	c_ldiv
4670  08e9 96            	ldw	x,sp
4671  08ea 1c0005        	addw	x,#OFST-3
4672  08ed cd0000        	call	c_lgsub
4674                     ; 1013 		temp_SL-=2250L;//2100L;	//225(900) - 235(1500)
4676  08f0 ae08ca        	ldw	x,#2250
4677  08f3 bf02          	ldw	c_lreg+2,x
4678  08f5 ae0000        	ldw	x,#0
4679  08f8 bf00          	ldw	c_lreg,x
4680  08fa 96            	ldw	x,sp
4681  08fb 1c0005        	addw	x,#OFST-3
4682  08fe cd0000        	call	c_lgsub
4684                     ; 1014 		temp_SL*=90L;//2048L;
4686  0901 ae005a        	ldw	x,#90
4687  0904 bf02          	ldw	c_lreg+2,x
4688  0906 ae0000        	ldw	x,#0
4689  0909 bf00          	ldw	c_lreg,x
4690  090b 96            	ldw	x,sp
4691  090c 1c0005        	addw	x,#OFST-3
4692  090f cd0000        	call	c_lgmul
4694                     ; 1015 		temp_SL/=15L;//250L;
4696  0912 96            	ldw	x,sp
4697  0913 1c0005        	addw	x,#OFST-3
4698  0916 cd0000        	call	c_ltor
4700  0919 ae0020        	ldw	x,#L66
4701  091c cd0000        	call	c_ldiv
4703  091f 96            	ldw	x,sp
4704  0920 1c0005        	addw	x,#OFST-3
4705  0923 cd0000        	call	c_rtol
4707                     ; 1016 		temp_SL+=900L;//250L;
4709  0926 ae0384        	ldw	x,#900
4710  0929 bf02          	ldw	c_lreg+2,x
4711  092b ae0000        	ldw	x,#0
4712  092e bf00          	ldw	c_lreg,x
4713  0930 96            	ldw	x,sp
4714  0931 1c0005        	addw	x,#OFST-3
4715  0934 cd0000        	call	c_lgadd
4717                     ; 1028 		if(temp_SL<0) temp_SL=0;
4719  0937 9c            	rvf
4720  0938 0d05          	tnz	(OFST-3,sp)
4721  093a 2e0a          	jrsge	L3532
4724  093c ae0000        	ldw	x,#0
4725  093f 1f07          	ldw	(OFST-1,sp),x
4726  0941 ae0000        	ldw	x,#0
4727  0944 1f05          	ldw	(OFST-3,sp),x
4728  0946               L3532:
4729                     ; 1029 		if(temp_SL>2040) temp_SL=2040L;
4731  0946 9c            	rvf
4732  0947 96            	ldw	x,sp
4733  0948 1c0005        	addw	x,#OFST-3
4734  094b cd0000        	call	c_ltor
4736  094e ae0024        	ldw	x,#L07
4737  0951 cd0000        	call	c_lcmp
4739  0954 2f0a          	jrslt	L5532
4742  0956 ae07f8        	ldw	x,#2040
4743  0959 1f07          	ldw	(OFST-1,sp),x
4744  095b ae0000        	ldw	x,#0
4745  095e 1f05          	ldw	(OFST-3,sp),x
4746  0960               L5532:
4747                     ; 1031 		pwm_u=(signed short)temp_SL;
4749  0960 1e07          	ldw	x,(OFST-1,sp)
4750  0962 bf08          	ldw	_pwm_u,x
4752  0964 ac820b82      	jpf	L5332
4753  0968               L7432:
4754                     ; 1068 else	if(link==ON)				//если есть связьvol_i_temp_avar
4756  0968 b670          	ld	a,_link
4757  096a a155          	cp	a,#85
4758  096c 2703          	jreq	L67
4759  096e cc0b82        	jp	L5332
4760  0971               L67:
4761                     ; 1078 		if(flags&0b00011010)					//если есть аварии
4763  0971 b605          	ld	a,_flags
4764  0973 a51a          	bcp	a,#26
4765  0975 270a          	jreq	L3632
4766                     ; 1080 			pwm_u=0;								//то полный стоп
4768  0977 5f            	clrw	x
4769  0978 bf08          	ldw	_pwm_u,x
4770                     ; 1081 			pwm_i=0;
4772  097a 5f            	clrw	x
4773  097b bf0a          	ldw	_pwm_i,x
4775  097d ac820b82      	jpf	L5332
4776  0981               L3632:
4777                     ; 1096 			temp_SL=(signed long)adc_buff_5;
4779  0981 ce0107        	ldw	x,_adc_buff_5
4780  0984 cd0000        	call	c_itolx
4782  0987 96            	ldw	x,sp
4783  0988 1c0005        	addw	x,#OFST-3
4784  098b cd0000        	call	c_rtol
4786                     ; 1098 			if(temp_SL<0) temp_SL=0;
4788  098e 9c            	rvf
4789  098f 0d05          	tnz	(OFST-3,sp)
4790  0991 2e0a          	jrsge	L7632
4793  0993 ae0000        	ldw	x,#0
4794  0996 1f07          	ldw	(OFST-1,sp),x
4795  0998 ae0000        	ldw	x,#0
4796  099b 1f05          	ldw	(OFST-3,sp),x
4797  099d               L7632:
4798                     ; 1099 			temp_SL*=(signed long)ee_K[4][1];
4800  099d ce002c        	ldw	x,_ee_K+18
4801  09a0 cd0000        	call	c_itolx
4803  09a3 96            	ldw	x,sp
4804  09a4 1c0005        	addw	x,#OFST-3
4805  09a7 cd0000        	call	c_lgmul
4807                     ; 1100 			temp_SL/=1000L;
4809  09aa 96            	ldw	x,sp
4810  09ab 1c0005        	addw	x,#OFST-3
4811  09ae cd0000        	call	c_ltor
4813  09b1 ae0028        	ldw	x,#L27
4814  09b4 cd0000        	call	c_ldiv
4816  09b7 96            	ldw	x,sp
4817  09b8 1c0005        	addw	x,#OFST-3
4818  09bb cd0000        	call	c_rtol
4820                     ; 1101 			Usum=(unsigned short)temp_SL;	
4822  09be 1e07          	ldw	x,(OFST-1,sp)
4823  09c0 cf0010        	ldw	_Usum,x
4824                     ; 1107 			Udelt++;//=U_out_const/*2300*/-Usum;
4826  09c3 ce000c        	ldw	x,_Udelt
4827  09c6 1c0001        	addw	x,#1
4828  09c9 cf000c        	ldw	_Udelt,x
4829                     ; 1108 			Udelt+=vol_i_temp;	//выравнивание токов по командам от уку
4831  09cc ce000c        	ldw	x,_Udelt
4832  09cf 72bb0063      	addw	x,_vol_i_temp
4833  09d3 cf000c        	ldw	_Udelt,x
4834                     ; 1112 			if(pwm_peace_cnt)pwm_peace_cnt--;
4836  09d6 ce0008        	ldw	x,_pwm_peace_cnt
4837  09d9 2709          	jreq	L1732
4840  09db ce0008        	ldw	x,_pwm_peace_cnt
4841  09de 1d0001        	subw	x,#1
4842  09e1 cf0008        	ldw	_pwm_peace_cnt,x
4843  09e4               L1732:
4844                     ; 1113 			if(pwm_peace_cnt_)pwm_peace_cnt_--;
4846  09e4 ce0006        	ldw	x,_pwm_peace_cnt_
4847  09e7 2709          	jreq	L3732
4850  09e9 ce0006        	ldw	x,_pwm_peace_cnt_
4851  09ec 1d0001        	subw	x,#1
4852  09ef cf0006        	ldw	_pwm_peace_cnt_,x
4853  09f2               L3732:
4854                     ; 1115 			if((Udelt<-50)&&(pwm_peace_cnt==0))
4856  09f2 9c            	rvf
4857  09f3 ce000c        	ldw	x,_Udelt
4858  09f6 a3ffce        	cpw	x,#65486
4859  09f9 2e40          	jrsge	L5732
4861  09fb ce0008        	ldw	x,_pwm_peace_cnt
4862  09fe 263b          	jrne	L5732
4863                     ; 1117 				pwm_delt= (short)(((long)Udelt*2000L)/650L);
4865  0a00 ce000c        	ldw	x,_Udelt
4866  0a03 90ae07d0      	ldw	y,#2000
4867  0a07 cd0000        	call	c_vmul
4869  0a0a ae0018        	ldw	x,#L45
4870  0a0d cd0000        	call	c_ldiv
4872  0a10 be02          	ldw	x,c_lreg+2
4873  0a12 bf56          	ldw	_pwm_delt,x
4874                     ; 1119 				if(pwm_u!=0)
4876  0a14 be08          	ldw	x,_pwm_u
4877  0a16 271b          	jreq	L7732
4878                     ; 1121 					pwm_u+=pwm_delt;
4880  0a18 be08          	ldw	x,_pwm_u
4881  0a1a 72bb0056      	addw	x,_pwm_delt
4882  0a1e bf08          	ldw	_pwm_u,x
4883                     ; 1122 					pwm_schot_cnt++;
4885  0a20 ce0004        	ldw	x,_pwm_schot_cnt
4886  0a23 1c0001        	addw	x,#1
4887  0a26 cf0004        	ldw	_pwm_schot_cnt,x
4888                     ; 1123 					pwm_peace_cnt=30;
4890  0a29 ae001e        	ldw	x,#30
4891  0a2c cf0008        	ldw	_pwm_peace_cnt,x
4893  0a2f acd40ad4      	jpf	L3042
4894  0a33               L7732:
4895                     ; 1125 				else	pwm_peace_cnt=0;
4897  0a33 5f            	clrw	x
4898  0a34 cf0008        	ldw	_pwm_peace_cnt,x
4899  0a37 acd40ad4      	jpf	L3042
4900  0a3b               L5732:
4901                     ; 1128 			else if((Udelt>50)&&(pwm_peace_cnt==0))
4903  0a3b 9c            	rvf
4904  0a3c ce000c        	ldw	x,_Udelt
4905  0a3f a30033        	cpw	x,#51
4906  0a42 2f3f          	jrslt	L5042
4908  0a44 ce0008        	ldw	x,_pwm_peace_cnt
4909  0a47 263a          	jrne	L5042
4910                     ; 1130 				pwm_delt= (short)(((long)Udelt*2000L)/650L);
4912  0a49 ce000c        	ldw	x,_Udelt
4913  0a4c 90ae07d0      	ldw	y,#2000
4914  0a50 cd0000        	call	c_vmul
4916  0a53 ae0018        	ldw	x,#L45
4917  0a56 cd0000        	call	c_ldiv
4919  0a59 be02          	ldw	x,c_lreg+2
4920  0a5b bf56          	ldw	_pwm_delt,x
4921                     ; 1132 				if(pwm_u!=2000)
4923  0a5d be08          	ldw	x,_pwm_u
4924  0a5f a307d0        	cpw	x,#2000
4925  0a62 2719          	jreq	L7042
4926                     ; 1134 					pwm_u+=pwm_delt;
4928  0a64 be08          	ldw	x,_pwm_u
4929  0a66 72bb0056      	addw	x,_pwm_delt
4930  0a6a bf08          	ldw	_pwm_u,x
4931                     ; 1135 					pwm_schot_cnt++;
4933  0a6c ce0004        	ldw	x,_pwm_schot_cnt
4934  0a6f 1c0001        	addw	x,#1
4935  0a72 cf0004        	ldw	_pwm_schot_cnt,x
4936                     ; 1136 					pwm_peace_cnt=30;
4938  0a75 ae001e        	ldw	x,#30
4939  0a78 cf0008        	ldw	_pwm_peace_cnt,x
4941  0a7b 2057          	jra	L3042
4942  0a7d               L7042:
4943                     ; 1138 				else	pwm_peace_cnt=0;
4945  0a7d 5f            	clrw	x
4946  0a7e cf0008        	ldw	_pwm_peace_cnt,x
4947  0a81 2051          	jra	L3042
4948  0a83               L5042:
4949                     ; 1141 			else if(pwm_peace_cnt_==0)
4951  0a83 ce0006        	ldw	x,_pwm_peace_cnt_
4952  0a86 264c          	jrne	L3042
4953                     ; 1143 				if(Udelt>10)pwm_u++;
4955  0a88 9c            	rvf
4956  0a89 ce000c        	ldw	x,_Udelt
4957  0a8c a3000b        	cpw	x,#11
4958  0a8f 2f09          	jrslt	L7142
4961  0a91 be08          	ldw	x,_pwm_u
4962  0a93 1c0001        	addw	x,#1
4963  0a96 bf08          	ldw	_pwm_u,x
4965  0a98 203a          	jra	L3042
4966  0a9a               L7142:
4967                     ; 1144 				else	if(Udelt>0)
4969  0a9a 9c            	rvf
4970  0a9b ce000c        	ldw	x,_Udelt
4971  0a9e 2d0f          	jrsle	L3242
4972                     ; 1146 					pwm_u++;
4974  0aa0 be08          	ldw	x,_pwm_u
4975  0aa2 1c0001        	addw	x,#1
4976  0aa5 bf08          	ldw	_pwm_u,x
4977                     ; 1147 					pwm_peace_cnt_=3;
4979  0aa7 ae0003        	ldw	x,#3
4980  0aaa cf0006        	ldw	_pwm_peace_cnt_,x
4982  0aad 2025          	jra	L3042
4983  0aaf               L3242:
4984                     ; 1149 				else if(Udelt<-10)pwm_u--;
4986  0aaf 9c            	rvf
4987  0ab0 ce000c        	ldw	x,_Udelt
4988  0ab3 a3fff6        	cpw	x,#65526
4989  0ab6 2e09          	jrsge	L7242
4992  0ab8 be08          	ldw	x,_pwm_u
4993  0aba 1d0001        	subw	x,#1
4994  0abd bf08          	ldw	_pwm_u,x
4996  0abf 2013          	jra	L3042
4997  0ac1               L7242:
4998                     ; 1150 				else	if(Udelt<0)
5000  0ac1 9c            	rvf
5001  0ac2 ce000c        	ldw	x,_Udelt
5002  0ac5 2e0d          	jrsge	L3042
5003                     ; 1152 					pwm_u--;
5005  0ac7 be08          	ldw	x,_pwm_u
5006  0ac9 1d0001        	subw	x,#1
5007  0acc bf08          	ldw	_pwm_u,x
5008                     ; 1153 					pwm_peace_cnt_=3;
5010  0ace ae0003        	ldw	x,#3
5011  0ad1 cf0006        	ldw	_pwm_peace_cnt_,x
5012  0ad4               L3042:
5013                     ; 1157 			if(pwm_u<=0)
5015  0ad4 9c            	rvf
5016  0ad5 be08          	ldw	x,_pwm_u
5017  0ad7 2c0d          	jrsgt	L5342
5018                     ; 1159 				pwm_u=0;
5020  0ad9 5f            	clrw	x
5021  0ada bf08          	ldw	_pwm_u,x
5022                     ; 1160 				pwm_peace_cnt=0;
5024  0adc 5f            	clrw	x
5025  0add cf0008        	ldw	_pwm_peace_cnt,x
5026                     ; 1161 				pwm_peace_cnt_=500;
5028  0ae0 ae01f4        	ldw	x,#500
5029  0ae3 cf0006        	ldw	_pwm_peace_cnt_,x
5030  0ae6               L5342:
5031                     ; 1163 			if(pwm_u>=2000)
5033  0ae6 9c            	rvf
5034  0ae7 be08          	ldw	x,_pwm_u
5035  0ae9 a307d0        	cpw	x,#2000
5036  0aec 2f0f          	jrslt	L7342
5037                     ; 1165 				pwm_u=2000;
5039  0aee ae07d0        	ldw	x,#2000
5040  0af1 bf08          	ldw	_pwm_u,x
5041                     ; 1166 				pwm_peace_cnt=0;
5043  0af3 5f            	clrw	x
5044  0af4 cf0008        	ldw	_pwm_peace_cnt,x
5045                     ; 1167 				pwm_peace_cnt_=500;
5047  0af7 ae01f4        	ldw	x,#500
5048  0afa cf0006        	ldw	_pwm_peace_cnt_,x
5049  0afd               L7342:
5050                     ; 1240 		temp_SL=(signed long)(U_out_const+vol_i_temp);
5052  0afd ce0012        	ldw	x,_U_out_const
5053  0b00 72bb0063      	addw	x,_vol_i_temp
5054  0b04 cd0000        	call	c_itolx
5056  0b07 96            	ldw	x,sp
5057  0b08 1c0001        	addw	x,#OFST-7
5058  0b0b cd0000        	call	c_rtol
5060                     ; 1242 		temp_SL-=2250L;//2100L;	//225(900) - 235(1500)
5062  0b0e ae08ca        	ldw	x,#2250
5063  0b11 bf02          	ldw	c_lreg+2,x
5064  0b13 ae0000        	ldw	x,#0
5065  0b16 bf00          	ldw	c_lreg,x
5066  0b18 96            	ldw	x,sp
5067  0b19 1c0001        	addw	x,#OFST-7
5068  0b1c cd0000        	call	c_lgsub
5070                     ; 1243 		temp_SL*=90L;//2048L;
5072  0b1f ae005a        	ldw	x,#90
5073  0b22 bf02          	ldw	c_lreg+2,x
5074  0b24 ae0000        	ldw	x,#0
5075  0b27 bf00          	ldw	c_lreg,x
5076  0b29 96            	ldw	x,sp
5077  0b2a 1c0001        	addw	x,#OFST-7
5078  0b2d cd0000        	call	c_lgmul
5080                     ; 1244 		temp_SL/=15L;//250L;
5082  0b30 96            	ldw	x,sp
5083  0b31 1c0001        	addw	x,#OFST-7
5084  0b34 cd0000        	call	c_ltor
5086  0b37 ae0020        	ldw	x,#L66
5087  0b3a cd0000        	call	c_ldiv
5089  0b3d 96            	ldw	x,sp
5090  0b3e 1c0001        	addw	x,#OFST-7
5091  0b41 cd0000        	call	c_rtol
5093                     ; 1245 		temp_SL+=900L;//250L;
5095  0b44 ae0384        	ldw	x,#900
5096  0b47 bf02          	ldw	c_lreg+2,x
5097  0b49 ae0000        	ldw	x,#0
5098  0b4c bf00          	ldw	c_lreg,x
5099  0b4e 96            	ldw	x,sp
5100  0b4f 1c0001        	addw	x,#OFST-7
5101  0b52 cd0000        	call	c_lgadd
5103                     ; 1257 		if(temp_SL<0) temp_SL=0;
5105  0b55 9c            	rvf
5106  0b56 0d01          	tnz	(OFST-7,sp)
5107  0b58 2e0a          	jrsge	L1442
5110  0b5a ae0000        	ldw	x,#0
5111  0b5d 1f03          	ldw	(OFST-5,sp),x
5112  0b5f ae0000        	ldw	x,#0
5113  0b62 1f01          	ldw	(OFST-7,sp),x
5114  0b64               L1442:
5115                     ; 1258 		if(temp_SL>2040) temp_SL=2040L;
5117  0b64 9c            	rvf
5118  0b65 96            	ldw	x,sp
5119  0b66 1c0001        	addw	x,#OFST-7
5120  0b69 cd0000        	call	c_ltor
5122  0b6c ae0024        	ldw	x,#L07
5123  0b6f cd0000        	call	c_lcmp
5125  0b72 2f0a          	jrslt	L3442
5128  0b74 ae07f8        	ldw	x,#2040
5129  0b77 1f03          	ldw	(OFST-5,sp),x
5130  0b79 ae0000        	ldw	x,#0
5131  0b7c 1f01          	ldw	(OFST-7,sp),x
5132  0b7e               L3442:
5133                     ; 1260 		pwm_u=(signed short)temp_SL;
5135  0b7e 1e03          	ldw	x,(OFST-5,sp)
5136  0b80 bf08          	ldw	_pwm_u,x
5137  0b82               L5332:
5138                     ; 1289 if(pwm_u>2000)pwm_u=2000;
5140  0b82 9c            	rvf
5141  0b83 be08          	ldw	x,_pwm_u
5142  0b85 a307d1        	cpw	x,#2001
5143  0b88 2f05          	jrslt	L5442
5146  0b8a ae07d0        	ldw	x,#2000
5147  0b8d bf08          	ldw	_pwm_u,x
5148  0b8f               L5442:
5149                     ; 1290 if(pwm_u<0)pwm_u=0;
5151  0b8f 9c            	rvf
5152  0b90 be08          	ldw	x,_pwm_u
5153  0b92 2e03          	jrsge	L7442
5156  0b94 5f            	clrw	x
5157  0b95 bf08          	ldw	_pwm_u,x
5158  0b97               L7442:
5159                     ; 1291 if(pwm_i>2000)pwm_i=2000;
5161  0b97 9c            	rvf
5162  0b98 be0a          	ldw	x,_pwm_i
5163  0b9a a307d1        	cpw	x,#2001
5164  0b9d 2f05          	jrslt	L1542
5167  0b9f ae07d0        	ldw	x,#2000
5168  0ba2 bf0a          	ldw	_pwm_i,x
5169  0ba4               L1542:
5170                     ; 1296 pwm_i=1000;
5172  0ba4 ae03e8        	ldw	x,#1000
5173  0ba7 bf0a          	ldw	_pwm_i,x
5174                     ; 1298 TIM1->CCR2H= (char)(pwm_u/256);	
5176  0ba9 be08          	ldw	x,_pwm_u
5177  0bab 90ae0100      	ldw	y,#256
5178  0baf cd0000        	call	c_idiv
5180  0bb2 9f            	ld	a,xl
5181  0bb3 c75267        	ld	21095,a
5182                     ; 1299 TIM1->CCR2L= (char)pwm_u;
5184  0bb6 5500095268    	mov	21096,_pwm_u+1
5185                     ; 1301 TIM1->CCR1H= (char)(pwm_i/256);	
5187  0bbb 35035265      	mov	21093,#3
5188                     ; 1302 TIM1->CCR1L= (char)pwm_i;
5190  0bbf 35e85266      	mov	21094,#232
5191                     ; 1304 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
5193  0bc3 be0e          	ldw	x,_vent_pwm_integr
5194  0bc5 90ae0080      	ldw	y,#128
5195  0bc9 cd0000        	call	c_idiv
5197  0bcc 9f            	ld	a,xl
5198  0bcd c75269        	ld	21097,a
5199                     ; 1305 TIM1->CCR3L= (char)(vent_pwm_integr*2);
5201  0bd0 b60f          	ld	a,_vent_pwm_integr+1
5202  0bd2 48            	sll	a
5203  0bd3 c7526a        	ld	21098,a
5204                     ; 1307 }
5207  0bd6 5b08          	addw	sp,#8
5208  0bd8 81            	ret
5262                     	switch	.const
5263  002c               L201:
5264  002c 00000258      	dc.l	600
5265  0030               L401:
5266  0030 00000708      	dc.l	1800
5267                     ; 1311 void matemat(void)
5267                     ; 1312 {
5268                     	switch	.text
5269  0bd9               _matemat:
5271  0bd9 5208          	subw	sp,#8
5272       00000008      OFST:	set	8
5275                     ; 1336 I=adc_buff_[4];
5277  0bdb ce0111        	ldw	x,_adc_buff_+8
5278  0bde cf001a        	ldw	_I,x
5279                     ; 1337 temp_SL=adc_buff_[4];
5281  0be1 ce0111        	ldw	x,_adc_buff_+8
5282  0be4 cd0000        	call	c_itolx
5284  0be7 96            	ldw	x,sp
5285  0be8 1c0005        	addw	x,#OFST-3
5286  0beb cd0000        	call	c_rtol
5288                     ; 1338 temp_SL-=ee_K[0][0];
5290  0bee ce001a        	ldw	x,_ee_K
5291  0bf1 cd0000        	call	c_itolx
5293  0bf4 96            	ldw	x,sp
5294  0bf5 1c0005        	addw	x,#OFST-3
5295  0bf8 cd0000        	call	c_lgsub
5297                     ; 1339 if(temp_SL<0) temp_SL=0;
5299  0bfb 9c            	rvf
5300  0bfc 0d05          	tnz	(OFST-3,sp)
5301  0bfe 2e0a          	jrsge	L1742
5304  0c00 ae0000        	ldw	x,#0
5305  0c03 1f07          	ldw	(OFST-1,sp),x
5306  0c05 ae0000        	ldw	x,#0
5307  0c08 1f05          	ldw	(OFST-3,sp),x
5308  0c0a               L1742:
5309                     ; 1340 temp_SL*=ee_K[0][1];
5311  0c0a ce001c        	ldw	x,_ee_K+2
5312  0c0d cd0000        	call	c_itolx
5314  0c10 96            	ldw	x,sp
5315  0c11 1c0005        	addw	x,#OFST-3
5316  0c14 cd0000        	call	c_lgmul
5318                     ; 1341 temp_SL/=600;
5320  0c17 96            	ldw	x,sp
5321  0c18 1c0005        	addw	x,#OFST-3
5322  0c1b cd0000        	call	c_ltor
5324  0c1e ae002c        	ldw	x,#L201
5325  0c21 cd0000        	call	c_ldiv
5327  0c24 96            	ldw	x,sp
5328  0c25 1c0005        	addw	x,#OFST-3
5329  0c28 cd0000        	call	c_rtol
5331                     ; 1342 I=(signed short)temp_SL;
5333  0c2b 1e07          	ldw	x,(OFST-1,sp)
5334  0c2d cf001a        	ldw	_I,x
5335                     ; 1345 temp_SL=(signed long)adc_buff_[1];//1;
5337  0c30 ce010b        	ldw	x,_adc_buff_+2
5338  0c33 cd0000        	call	c_itolx
5340  0c36 96            	ldw	x,sp
5341  0c37 1c0005        	addw	x,#OFST-3
5342  0c3a cd0000        	call	c_rtol
5344                     ; 1348 if(temp_SL<0) temp_SL=0;
5346  0c3d 9c            	rvf
5347  0c3e 0d05          	tnz	(OFST-3,sp)
5348  0c40 2e0a          	jrsge	L3742
5351  0c42 ae0000        	ldw	x,#0
5352  0c45 1f07          	ldw	(OFST-1,sp),x
5353  0c47 ae0000        	ldw	x,#0
5354  0c4a 1f05          	ldw	(OFST-3,sp),x
5355  0c4c               L3742:
5356                     ; 1349 temp_SL*=(signed long)ee_K[2][1];
5358  0c4c ce0024        	ldw	x,_ee_K+10
5359  0c4f cd0000        	call	c_itolx
5361  0c52 96            	ldw	x,sp
5362  0c53 1c0005        	addw	x,#OFST-3
5363  0c56 cd0000        	call	c_lgmul
5365                     ; 1350 temp_SL/=1000L;
5367  0c59 96            	ldw	x,sp
5368  0c5a 1c0005        	addw	x,#OFST-3
5369  0c5d cd0000        	call	c_ltor
5371  0c60 ae0028        	ldw	x,#L27
5372  0c63 cd0000        	call	c_ldiv
5374  0c66 96            	ldw	x,sp
5375  0c67 1c0005        	addw	x,#OFST-3
5376  0c6a cd0000        	call	c_rtol
5378                     ; 1351 Ui=(unsigned short)temp_SL;
5380  0c6d 1e07          	ldw	x,(OFST-1,sp)
5381  0c6f cf0016        	ldw	_Ui,x
5382                     ; 1353 temp_SL=(signed long)adc_buff_5;
5384  0c72 ce0107        	ldw	x,_adc_buff_5
5385  0c75 cd0000        	call	c_itolx
5387  0c78 96            	ldw	x,sp
5388  0c79 1c0005        	addw	x,#OFST-3
5389  0c7c cd0000        	call	c_rtol
5391                     ; 1355 if(temp_SL<0) temp_SL=0;
5393  0c7f 9c            	rvf
5394  0c80 0d05          	tnz	(OFST-3,sp)
5395  0c82 2e0a          	jrsge	L5742
5398  0c84 ae0000        	ldw	x,#0
5399  0c87 1f07          	ldw	(OFST-1,sp),x
5400  0c89 ae0000        	ldw	x,#0
5401  0c8c 1f05          	ldw	(OFST-3,sp),x
5402  0c8e               L5742:
5403                     ; 1356 temp_SL*=(signed long)ee_K[4][1];
5405  0c8e ce002c        	ldw	x,_ee_K+18
5406  0c91 cd0000        	call	c_itolx
5408  0c94 96            	ldw	x,sp
5409  0c95 1c0005        	addw	x,#OFST-3
5410  0c98 cd0000        	call	c_lgmul
5412                     ; 1357 temp_SL/=1000L;
5414  0c9b 96            	ldw	x,sp
5415  0c9c 1c0005        	addw	x,#OFST-3
5416  0c9f cd0000        	call	c_ltor
5418  0ca2 ae0028        	ldw	x,#L27
5419  0ca5 cd0000        	call	c_ldiv
5421  0ca8 96            	ldw	x,sp
5422  0ca9 1c0005        	addw	x,#OFST-3
5423  0cac cd0000        	call	c_rtol
5425                     ; 1358 Usum=(unsigned short)temp_SL;
5427  0caf 1e07          	ldw	x,(OFST-1,sp)
5428  0cb1 cf0010        	ldw	_Usum,x
5429                     ; 1362 temp_SL=adc_buff_[3];
5431  0cb4 ce010f        	ldw	x,_adc_buff_+6
5432  0cb7 cd0000        	call	c_itolx
5434  0cba 96            	ldw	x,sp
5435  0cbb 1c0005        	addw	x,#OFST-3
5436  0cbe cd0000        	call	c_rtol
5438                     ; 1364 if(temp_SL<0) temp_SL=0;
5440  0cc1 9c            	rvf
5441  0cc2 0d05          	tnz	(OFST-3,sp)
5442  0cc4 2e0a          	jrsge	L7742
5445  0cc6 ae0000        	ldw	x,#0
5446  0cc9 1f07          	ldw	(OFST-1,sp),x
5447  0ccb ae0000        	ldw	x,#0
5448  0cce 1f05          	ldw	(OFST-3,sp),x
5449  0cd0               L7742:
5450                     ; 1365 temp_SL*=ee_K[1][1];
5452  0cd0 ce0020        	ldw	x,_ee_K+6
5453  0cd3 cd0000        	call	c_itolx
5455  0cd6 96            	ldw	x,sp
5456  0cd7 1c0005        	addw	x,#OFST-3
5457  0cda cd0000        	call	c_lgmul
5459                     ; 1366 temp_SL/=1800;
5461  0cdd 96            	ldw	x,sp
5462  0cde 1c0005        	addw	x,#OFST-3
5463  0ce1 cd0000        	call	c_ltor
5465  0ce4 ae0030        	ldw	x,#L401
5466  0ce7 cd0000        	call	c_ldiv
5468  0cea 96            	ldw	x,sp
5469  0ceb 1c0005        	addw	x,#OFST-3
5470  0cee cd0000        	call	c_rtol
5472                     ; 1367 Un=(unsigned short)temp_SL;
5474  0cf1 1e07          	ldw	x,(OFST-1,sp)
5475  0cf3 cf0018        	ldw	_Un,x
5476                     ; 1372 temp_SL=adc_buff_[2];
5478  0cf6 ce010d        	ldw	x,_adc_buff_+4
5479  0cf9 cd0000        	call	c_itolx
5481  0cfc 96            	ldw	x,sp
5482  0cfd 1c0005        	addw	x,#OFST-3
5483  0d00 cd0000        	call	c_rtol
5485                     ; 1373 temp_SL*=ee_K[3][1];
5487  0d03 ce0028        	ldw	x,_ee_K+14
5488  0d06 cd0000        	call	c_itolx
5490  0d09 96            	ldw	x,sp
5491  0d0a 1c0005        	addw	x,#OFST-3
5492  0d0d cd0000        	call	c_lgmul
5494                     ; 1374 temp_SL/=1000;
5496  0d10 96            	ldw	x,sp
5497  0d11 1c0005        	addw	x,#OFST-3
5498  0d14 cd0000        	call	c_ltor
5500  0d17 ae0028        	ldw	x,#L27
5501  0d1a cd0000        	call	c_ldiv
5503  0d1d 96            	ldw	x,sp
5504  0d1e 1c0005        	addw	x,#OFST-3
5505  0d21 cd0000        	call	c_rtol
5507                     ; 1375 T=(signed short)(temp_SL-273L);
5509  0d24 7b08          	ld	a,(OFST+0,sp)
5510  0d26 5f            	clrw	x
5511  0d27 4d            	tnz	a
5512  0d28 2a01          	jrpl	L601
5513  0d2a 53            	cplw	x
5514  0d2b               L601:
5515  0d2b 97            	ld	xl,a
5516  0d2c 1d0111        	subw	x,#273
5517  0d2f 01            	rrwa	x,a
5518  0d30 b775          	ld	_T,a
5519  0d32 02            	rlwa	x,a
5520                     ; 1376 if(T<-30)T=-30;
5522  0d33 9c            	rvf
5523  0d34 b675          	ld	a,_T
5524  0d36 a1e2          	cp	a,#226
5525  0d38 2e04          	jrsge	L1052
5528  0d3a 35e20075      	mov	_T,#226
5529  0d3e               L1052:
5530                     ; 1377 if(T>120)T=120;
5532  0d3e 9c            	rvf
5533  0d3f b675          	ld	a,_T
5534  0d41 a179          	cp	a,#121
5535  0d43 2f04          	jrslt	L3052
5538  0d45 35780075      	mov	_T,#120
5539  0d49               L3052:
5540                     ; 1381 Uin=Usum-Ui;
5542  0d49 ce0010        	ldw	x,_Usum
5543  0d4c 72b00016      	subw	x,_Ui
5544  0d50 cf000e        	ldw	_Uin,x
5545                     ; 1382 if(link==ON)
5547  0d53 b670          	ld	a,_link
5548  0d55 a155          	cp	a,#85
5549  0d57 260c          	jrne	L5052
5550                     ; 1384 	Unecc=U_out_const-Uin;
5552  0d59 ce0012        	ldw	x,_U_out_const
5553  0d5c 72b0000e      	subw	x,_Uin
5554  0d60 cf0014        	ldw	_Unecc,x
5556  0d63 200a          	jra	L7052
5557  0d65               L5052:
5558                     ; 1393 else Unecc=ee_UAVT-Uin;
5560  0d65 ce000c        	ldw	x,_ee_UAVT
5561  0d68 72b0000e      	subw	x,_Uin
5562  0d6c cf0014        	ldw	_Unecc,x
5563  0d6f               L7052:
5564                     ; 1401 if(Unecc<0)Unecc=0;
5566  0d6f 9c            	rvf
5567  0d70 ce0014        	ldw	x,_Unecc
5568  0d73 2e04          	jrsge	L1152
5571  0d75 5f            	clrw	x
5572  0d76 cf0014        	ldw	_Unecc,x
5573  0d79               L1152:
5574                     ; 1402 temp_SL=(signed long)(T-ee_tsign);
5576  0d79 5f            	clrw	x
5577  0d7a b675          	ld	a,_T
5578  0d7c 2a01          	jrpl	L011
5579  0d7e 53            	cplw	x
5580  0d7f               L011:
5581  0d7f 97            	ld	xl,a
5582  0d80 72b0000e      	subw	x,_ee_tsign
5583  0d84 cd0000        	call	c_itolx
5585  0d87 96            	ldw	x,sp
5586  0d88 1c0005        	addw	x,#OFST-3
5587  0d8b cd0000        	call	c_rtol
5589                     ; 1403 temp_SL*=1000L;
5591  0d8e ae03e8        	ldw	x,#1000
5592  0d91 bf02          	ldw	c_lreg+2,x
5593  0d93 ae0000        	ldw	x,#0
5594  0d96 bf00          	ldw	c_lreg,x
5595  0d98 96            	ldw	x,sp
5596  0d99 1c0005        	addw	x,#OFST-3
5597  0d9c cd0000        	call	c_lgmul
5599                     ; 1404 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5601  0d9f ce0010        	ldw	x,_ee_tmax
5602  0da2 72b0000e      	subw	x,_ee_tsign
5603  0da6 cd0000        	call	c_itolx
5605  0da9 96            	ldw	x,sp
5606  0daa 1c0001        	addw	x,#OFST-7
5607  0dad cd0000        	call	c_rtol
5609  0db0 96            	ldw	x,sp
5610  0db1 1c0005        	addw	x,#OFST-3
5611  0db4 cd0000        	call	c_ltor
5613  0db7 96            	ldw	x,sp
5614  0db8 1c0001        	addw	x,#OFST-7
5615  0dbb cd0000        	call	c_ldiv
5617  0dbe 96            	ldw	x,sp
5618  0dbf 1c0005        	addw	x,#OFST-3
5619  0dc2 cd0000        	call	c_rtol
5621                     ; 1406 vol_i_temp_avar=(unsigned short)temp_SL; 
5623  0dc5 1e07          	ldw	x,(OFST-1,sp)
5624  0dc7 bf06          	ldw	_vol_i_temp_avar,x
5625                     ; 1408 debug_info_to_uku[0]=pwm_u;
5627  0dc9 be08          	ldw	x,_pwm_u
5628  0dcb bf01          	ldw	_debug_info_to_uku,x
5629                     ; 1409 debug_info_to_uku[1]=vol_i_temp;
5631  0dcd be63          	ldw	x,_vol_i_temp
5632  0dcf bf03          	ldw	_debug_info_to_uku+2,x
5633                     ; 1412 Ufade=(I-150)/10;
5635  0dd1 ce001a        	ldw	x,_I
5636  0dd4 1d0096        	subw	x,#150
5637  0dd7 a60a          	ld	a,#10
5638  0dd9 cd0000        	call	c_sdivx
5640  0ddc cf000a        	ldw	_Ufade,x
5641                     ; 1413 if(Ufade<0)Ufade=0;
5643  0ddf 9c            	rvf
5644  0de0 ce000a        	ldw	x,_Ufade
5645  0de3 2e04          	jrsge	L3152
5648  0de5 5f            	clrw	x
5649  0de6 cf000a        	ldw	_Ufade,x
5650  0de9               L3152:
5651                     ; 1414 if(Ufade>15)Ufade=15;
5653  0de9 9c            	rvf
5654  0dea ce000a        	ldw	x,_Ufade
5655  0ded a30010        	cpw	x,#16
5656  0df0 2f06          	jrslt	L5152
5659  0df2 ae000f        	ldw	x,#15
5660  0df5 cf000a        	ldw	_Ufade,x
5661  0df8               L5152:
5662                     ; 1415 }
5665  0df8 5b08          	addw	sp,#8
5666  0dfa 81            	ret
5697                     ; 1418 void temper_drv(void)		//1 Hz
5697                     ; 1419 {
5698                     	switch	.text
5699  0dfb               _temper_drv:
5703                     ; 1421 if(T>ee_tsign) tsign_cnt++;
5705  0dfb 9c            	rvf
5706  0dfc 5f            	clrw	x
5707  0dfd b675          	ld	a,_T
5708  0dff 2a01          	jrpl	L411
5709  0e01 53            	cplw	x
5710  0e02               L411:
5711  0e02 97            	ld	xl,a
5712  0e03 c3000e        	cpw	x,_ee_tsign
5713  0e06 2d09          	jrsle	L7252
5716  0e08 be5c          	ldw	x,_tsign_cnt
5717  0e0a 1c0001        	addw	x,#1
5718  0e0d bf5c          	ldw	_tsign_cnt,x
5720  0e0f 201d          	jra	L1352
5721  0e11               L7252:
5722                     ; 1422 else if (T<(ee_tsign-1)) tsign_cnt--;
5724  0e11 9c            	rvf
5725  0e12 ce000e        	ldw	x,_ee_tsign
5726  0e15 5a            	decw	x
5727  0e16 905f          	clrw	y
5728  0e18 b675          	ld	a,_T
5729  0e1a 2a02          	jrpl	L611
5730  0e1c 9053          	cplw	y
5731  0e1e               L611:
5732  0e1e 9097          	ld	yl,a
5733  0e20 90bf00        	ldw	c_y,y
5734  0e23 b300          	cpw	x,c_y
5735  0e25 2d07          	jrsle	L1352
5738  0e27 be5c          	ldw	x,_tsign_cnt
5739  0e29 1d0001        	subw	x,#1
5740  0e2c bf5c          	ldw	_tsign_cnt,x
5741  0e2e               L1352:
5742                     ; 1424 gran(&tsign_cnt,0,60);
5744  0e2e ae003c        	ldw	x,#60
5745  0e31 89            	pushw	x
5746  0e32 5f            	clrw	x
5747  0e33 89            	pushw	x
5748  0e34 ae005c        	ldw	x,#_tsign_cnt
5749  0e37 cd00d5        	call	_gran
5751  0e3a 5b04          	addw	sp,#4
5752                     ; 1426 if(tsign_cnt>=55)
5754  0e3c 9c            	rvf
5755  0e3d be5c          	ldw	x,_tsign_cnt
5756  0e3f a30037        	cpw	x,#55
5757  0e42 2f16          	jrslt	L5352
5758                     ; 1428 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5760  0e44 3d55          	tnz	_jp_mode
5761  0e46 2606          	jrne	L3452
5763  0e48 b605          	ld	a,_flags
5764  0e4a a540          	bcp	a,#64
5765  0e4c 2706          	jreq	L1452
5766  0e4e               L3452:
5768  0e4e b655          	ld	a,_jp_mode
5769  0e50 a103          	cp	a,#3
5770  0e52 2612          	jrne	L5452
5771  0e54               L1452:
5774  0e54 72140005      	bset	_flags,#2
5775  0e58 200c          	jra	L5452
5776  0e5a               L5352:
5777                     ; 1430 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5779  0e5a 9c            	rvf
5780  0e5b be5c          	ldw	x,_tsign_cnt
5781  0e5d a30006        	cpw	x,#6
5782  0e60 2e04          	jrsge	L5452
5785  0e62 72150005      	bres	_flags,#2
5786  0e66               L5452:
5787                     ; 1435 if(T>ee_tmax) tmax_cnt++;
5789  0e66 9c            	rvf
5790  0e67 5f            	clrw	x
5791  0e68 b675          	ld	a,_T
5792  0e6a 2a01          	jrpl	L021
5793  0e6c 53            	cplw	x
5794  0e6d               L021:
5795  0e6d 97            	ld	xl,a
5796  0e6e c30010        	cpw	x,_ee_tmax
5797  0e71 2d09          	jrsle	L1552
5800  0e73 be5a          	ldw	x,_tmax_cnt
5801  0e75 1c0001        	addw	x,#1
5802  0e78 bf5a          	ldw	_tmax_cnt,x
5804  0e7a 201d          	jra	L3552
5805  0e7c               L1552:
5806                     ; 1436 else if (T<(ee_tmax-1)) tmax_cnt--;
5808  0e7c 9c            	rvf
5809  0e7d ce0010        	ldw	x,_ee_tmax
5810  0e80 5a            	decw	x
5811  0e81 905f          	clrw	y
5812  0e83 b675          	ld	a,_T
5813  0e85 2a02          	jrpl	L221
5814  0e87 9053          	cplw	y
5815  0e89               L221:
5816  0e89 9097          	ld	yl,a
5817  0e8b 90bf00        	ldw	c_y,y
5818  0e8e b300          	cpw	x,c_y
5819  0e90 2d07          	jrsle	L3552
5822  0e92 be5a          	ldw	x,_tmax_cnt
5823  0e94 1d0001        	subw	x,#1
5824  0e97 bf5a          	ldw	_tmax_cnt,x
5825  0e99               L3552:
5826                     ; 1438 gran(&tmax_cnt,0,60);
5828  0e99 ae003c        	ldw	x,#60
5829  0e9c 89            	pushw	x
5830  0e9d 5f            	clrw	x
5831  0e9e 89            	pushw	x
5832  0e9f ae005a        	ldw	x,#_tmax_cnt
5833  0ea2 cd00d5        	call	_gran
5835  0ea5 5b04          	addw	sp,#4
5836                     ; 1440 if(tmax_cnt>=55)
5838  0ea7 9c            	rvf
5839  0ea8 be5a          	ldw	x,_tmax_cnt
5840  0eaa a30037        	cpw	x,#55
5841  0ead 2f16          	jrslt	L7552
5842                     ; 1442 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5844  0eaf 3d55          	tnz	_jp_mode
5845  0eb1 2606          	jrne	L5652
5847  0eb3 b605          	ld	a,_flags
5848  0eb5 a540          	bcp	a,#64
5849  0eb7 2706          	jreq	L3652
5850  0eb9               L5652:
5852  0eb9 b655          	ld	a,_jp_mode
5853  0ebb a103          	cp	a,#3
5854  0ebd 2612          	jrne	L7652
5855  0ebf               L3652:
5858  0ebf 72120005      	bset	_flags,#1
5859  0ec3 200c          	jra	L7652
5860  0ec5               L7552:
5861                     ; 1444 else if (tmax_cnt<=5) flags&=0b11111101;
5863  0ec5 9c            	rvf
5864  0ec6 be5a          	ldw	x,_tmax_cnt
5865  0ec8 a30006        	cpw	x,#6
5866  0ecb 2e04          	jrsge	L7652
5869  0ecd 72130005      	bres	_flags,#1
5870  0ed1               L7652:
5871                     ; 1447 } 
5874  0ed1 81            	ret
5916                     ; 1450 void u_drv(void)		//1Hz
5916                     ; 1451 { 
5917                     	switch	.text
5918  0ed2               _u_drv:
5920  0ed2 89            	pushw	x
5921       00000002      OFST:	set	2
5924                     ; 1452 if(jp_mode!=jp3)
5926  0ed3 b655          	ld	a,_jp_mode
5927  0ed5 a103          	cp	a,#3
5928  0ed7 2766          	jreq	L1162
5929                     ; 1454 	if(Ui>ee_Umax)umax_cnt++;
5931  0ed9 9c            	rvf
5932  0eda ce0016        	ldw	x,_Ui
5933  0edd c30014        	cpw	x,_ee_Umax
5934  0ee0 2d09          	jrsle	L3162
5937  0ee2 be73          	ldw	x,_umax_cnt
5938  0ee4 1c0001        	addw	x,#1
5939  0ee7 bf73          	ldw	_umax_cnt,x
5941  0ee9 2003          	jra	L5162
5942  0eeb               L3162:
5943                     ; 1455 	else umax_cnt=0;
5945  0eeb 5f            	clrw	x
5946  0eec bf73          	ldw	_umax_cnt,x
5947  0eee               L5162:
5948                     ; 1456 	gran(&umax_cnt,0,10);
5950  0eee ae000a        	ldw	x,#10
5951  0ef1 89            	pushw	x
5952  0ef2 5f            	clrw	x
5953  0ef3 89            	pushw	x
5954  0ef4 ae0073        	ldw	x,#_umax_cnt
5955  0ef7 cd00d5        	call	_gran
5957  0efa 5b04          	addw	sp,#4
5958                     ; 1457 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5960  0efc 9c            	rvf
5961  0efd be73          	ldw	x,_umax_cnt
5962  0eff a3000a        	cpw	x,#10
5963  0f02 2f04          	jrslt	L7162
5966  0f04 72160005      	bset	_flags,#3
5967  0f08               L7162:
5968                     ; 1460 	short Upwm=0;
5970                     ; 1461 	Upwm=(pwm_u/3)-50;
5972  0f08 be08          	ldw	x,_pwm_u
5973  0f0a a603          	ld	a,#3
5974  0f0c cd0000        	call	c_sdivx
5976  0f0f 1d0032        	subw	x,#50
5977  0f12 1f01          	ldw	(OFST-1,sp),x
5978                     ; 1463 	if((/*((Ui<Un)&&((Un-Ui)>ee_dU)) || */(Ui < Upwm))&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5980  0f14 9c            	rvf
5981  0f15 ce0016        	ldw	x,_Ui
5982  0f18 1301          	cpw	x,(OFST-1,sp)
5983  0f1a 2e10          	jrsge	L1262
5985  0f1c c6500a        	ld	a,20490
5986  0f1f a520          	bcp	a,#32
5987  0f21 2609          	jrne	L1262
5990  0f23 be71          	ldw	x,_umin_cnt
5991  0f25 1c0001        	addw	x,#1
5992  0f28 bf71          	ldw	_umin_cnt,x
5994  0f2a 2003          	jra	L3262
5995  0f2c               L1262:
5996                     ; 1464 	else umin_cnt=0;
5998  0f2c 5f            	clrw	x
5999  0f2d bf71          	ldw	_umin_cnt,x
6000  0f2f               L3262:
6001                     ; 1465 	gran(&umin_cnt,0,10);	
6003  0f2f ae000a        	ldw	x,#10
6004  0f32 89            	pushw	x
6005  0f33 5f            	clrw	x
6006  0f34 89            	pushw	x
6007  0f35 ae0071        	ldw	x,#_umin_cnt
6008  0f38 cd00d5        	call	_gran
6010  0f3b 5b04          	addw	sp,#4
6012  0f3d 206b          	jra	L5262
6013  0f3f               L1162:
6014                     ; 1469 else if(jp_mode==jp3)
6016  0f3f b655          	ld	a,_jp_mode
6017  0f41 a103          	cp	a,#3
6018  0f43 2665          	jrne	L5262
6019                     ; 1471 	if(Ui>700)umax_cnt++;
6021  0f45 9c            	rvf
6022  0f46 ce0016        	ldw	x,_Ui
6023  0f49 a302bd        	cpw	x,#701
6024  0f4c 2f09          	jrslt	L1362
6027  0f4e be73          	ldw	x,_umax_cnt
6028  0f50 1c0001        	addw	x,#1
6029  0f53 bf73          	ldw	_umax_cnt,x
6031  0f55 2003          	jra	L3362
6032  0f57               L1362:
6033                     ; 1472 	else umax_cnt=0;
6035  0f57 5f            	clrw	x
6036  0f58 bf73          	ldw	_umax_cnt,x
6037  0f5a               L3362:
6038                     ; 1473 	gran(&umax_cnt,0,10);
6040  0f5a ae000a        	ldw	x,#10
6041  0f5d 89            	pushw	x
6042  0f5e 5f            	clrw	x
6043  0f5f 89            	pushw	x
6044  0f60 ae0073        	ldw	x,#_umax_cnt
6045  0f63 cd00d5        	call	_gran
6047  0f66 5b04          	addw	sp,#4
6048                     ; 1474 	if(umax_cnt>=10)flags|=0b00001000;
6050  0f68 9c            	rvf
6051  0f69 be73          	ldw	x,_umax_cnt
6052  0f6b a3000a        	cpw	x,#10
6053  0f6e 2f04          	jrslt	L5362
6056  0f70 72160005      	bset	_flags,#3
6057  0f74               L5362:
6058                     ; 1477 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
6060  0f74 9c            	rvf
6061  0f75 ce0016        	ldw	x,_Ui
6062  0f78 a300c8        	cpw	x,#200
6063  0f7b 2e10          	jrsge	L7362
6065  0f7d c6500a        	ld	a,20490
6066  0f80 a520          	bcp	a,#32
6067  0f82 2609          	jrne	L7362
6070  0f84 be71          	ldw	x,_umin_cnt
6071  0f86 1c0001        	addw	x,#1
6072  0f89 bf71          	ldw	_umin_cnt,x
6074  0f8b 2003          	jra	L1462
6075  0f8d               L7362:
6076                     ; 1478 	else umin_cnt=0;
6078  0f8d 5f            	clrw	x
6079  0f8e bf71          	ldw	_umin_cnt,x
6080  0f90               L1462:
6081                     ; 1479 	gran(&umin_cnt,0,10);	
6083  0f90 ae000a        	ldw	x,#10
6084  0f93 89            	pushw	x
6085  0f94 5f            	clrw	x
6086  0f95 89            	pushw	x
6087  0f96 ae0071        	ldw	x,#_umin_cnt
6088  0f99 cd00d5        	call	_gran
6090  0f9c 5b04          	addw	sp,#4
6091                     ; 1480 	if(umin_cnt>=10)flags|=0b00010000;	  
6093  0f9e 9c            	rvf
6094  0f9f be71          	ldw	x,_umin_cnt
6095  0fa1 a3000a        	cpw	x,#10
6096  0fa4 2f04          	jrslt	L5262
6099  0fa6 72180005      	bset	_flags,#4
6100  0faa               L5262:
6101                     ; 1482 }
6104  0faa 85            	popw	x
6105  0fab 81            	ret
6131                     ; 1507 void apv_start(void)
6131                     ; 1508 {
6132                     	switch	.text
6133  0fac               _apv_start:
6137                     ; 1509 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
6139  0fac 3d50          	tnz	_apv_cnt
6140  0fae 2624          	jrne	L5562
6142  0fb0 3d51          	tnz	_apv_cnt+1
6143  0fb2 2620          	jrne	L5562
6145  0fb4 3d52          	tnz	_apv_cnt+2
6146  0fb6 261c          	jrne	L5562
6148                     	btst	_bAPV
6149  0fbd 2515          	jrult	L5562
6150                     ; 1511 	apv_cnt[0]=60;
6152  0fbf 353c0050      	mov	_apv_cnt,#60
6153                     ; 1512 	apv_cnt[1]=60;
6155  0fc3 353c0051      	mov	_apv_cnt+1,#60
6156                     ; 1513 	apv_cnt[2]=60;
6158  0fc7 353c0052      	mov	_apv_cnt+2,#60
6159                     ; 1514 	apv_cnt_=3600;
6161  0fcb ae0e10        	ldw	x,#3600
6162  0fce bf4e          	ldw	_apv_cnt_,x
6163                     ; 1515 	bAPV=1;	
6165  0fd0 72100002      	bset	_bAPV
6166  0fd4               L5562:
6167                     ; 1517 }
6170  0fd4 81            	ret
6196                     ; 1520 void apv_stop(void)
6196                     ; 1521 {
6197                     	switch	.text
6198  0fd5               _apv_stop:
6202                     ; 1522 apv_cnt[0]=0;
6204  0fd5 3f50          	clr	_apv_cnt
6205                     ; 1523 apv_cnt[1]=0;
6207  0fd7 3f51          	clr	_apv_cnt+1
6208                     ; 1524 apv_cnt[2]=0;
6210  0fd9 3f52          	clr	_apv_cnt+2
6211                     ; 1525 apv_cnt_=0;	
6213  0fdb 5f            	clrw	x
6214  0fdc bf4e          	ldw	_apv_cnt_,x
6215                     ; 1526 bAPV=0;
6217  0fde 72110002      	bres	_bAPV
6218                     ; 1527 }
6221  0fe2 81            	ret
6256                     ; 1531 void apv_hndl(void)
6256                     ; 1532 {
6257                     	switch	.text
6258  0fe3               _apv_hndl:
6262                     ; 1533 if(apv_cnt[0])
6264  0fe3 3d50          	tnz	_apv_cnt
6265  0fe5 271e          	jreq	L7762
6266                     ; 1535 	apv_cnt[0]--;
6268  0fe7 3a50          	dec	_apv_cnt
6269                     ; 1536 	if(apv_cnt[0]==0)
6271  0fe9 3d50          	tnz	_apv_cnt
6272  0feb 265a          	jrne	L3072
6273                     ; 1538 		flags&=0b11100001;
6275  0fed b605          	ld	a,_flags
6276  0fef a4e1          	and	a,#225
6277  0ff1 b705          	ld	_flags,a
6278                     ; 1539 		tsign_cnt=0;
6280  0ff3 5f            	clrw	x
6281  0ff4 bf5c          	ldw	_tsign_cnt,x
6282                     ; 1540 		tmax_cnt=0;
6284  0ff6 5f            	clrw	x
6285  0ff7 bf5a          	ldw	_tmax_cnt,x
6286                     ; 1541 		umax_cnt=0;
6288  0ff9 5f            	clrw	x
6289  0ffa bf73          	ldw	_umax_cnt,x
6290                     ; 1542 		umin_cnt=0;
6292  0ffc 5f            	clrw	x
6293  0ffd bf71          	ldw	_umin_cnt,x
6294                     ; 1544 		led_drv_cnt=30;
6296  0fff 351e0016      	mov	_led_drv_cnt,#30
6297  1003 2042          	jra	L3072
6298  1005               L7762:
6299                     ; 1547 else if(apv_cnt[1])
6301  1005 3d51          	tnz	_apv_cnt+1
6302  1007 271e          	jreq	L5072
6303                     ; 1549 	apv_cnt[1]--;
6305  1009 3a51          	dec	_apv_cnt+1
6306                     ; 1550 	if(apv_cnt[1]==0)
6308  100b 3d51          	tnz	_apv_cnt+1
6309  100d 2638          	jrne	L3072
6310                     ; 1552 		flags&=0b11100001;
6312  100f b605          	ld	a,_flags
6313  1011 a4e1          	and	a,#225
6314  1013 b705          	ld	_flags,a
6315                     ; 1553 		tsign_cnt=0;
6317  1015 5f            	clrw	x
6318  1016 bf5c          	ldw	_tsign_cnt,x
6319                     ; 1554 		tmax_cnt=0;
6321  1018 5f            	clrw	x
6322  1019 bf5a          	ldw	_tmax_cnt,x
6323                     ; 1555 		umax_cnt=0;
6325  101b 5f            	clrw	x
6326  101c bf73          	ldw	_umax_cnt,x
6327                     ; 1556 		umin_cnt=0;
6329  101e 5f            	clrw	x
6330  101f bf71          	ldw	_umin_cnt,x
6331                     ; 1558 		led_drv_cnt=30;
6333  1021 351e0016      	mov	_led_drv_cnt,#30
6334  1025 2020          	jra	L3072
6335  1027               L5072:
6336                     ; 1561 else if(apv_cnt[2])
6338  1027 3d52          	tnz	_apv_cnt+2
6339  1029 271c          	jreq	L3072
6340                     ; 1563 	apv_cnt[2]--;
6342  102b 3a52          	dec	_apv_cnt+2
6343                     ; 1564 	if(apv_cnt[2]==0)
6345  102d 3d52          	tnz	_apv_cnt+2
6346  102f 2616          	jrne	L3072
6347                     ; 1566 		flags&=0b11100001;
6349  1031 b605          	ld	a,_flags
6350  1033 a4e1          	and	a,#225
6351  1035 b705          	ld	_flags,a
6352                     ; 1567 		tsign_cnt=0;
6354  1037 5f            	clrw	x
6355  1038 bf5c          	ldw	_tsign_cnt,x
6356                     ; 1568 		tmax_cnt=0;
6358  103a 5f            	clrw	x
6359  103b bf5a          	ldw	_tmax_cnt,x
6360                     ; 1569 		umax_cnt=0;
6362  103d 5f            	clrw	x
6363  103e bf73          	ldw	_umax_cnt,x
6364                     ; 1570 		umin_cnt=0;          
6366  1040 5f            	clrw	x
6367  1041 bf71          	ldw	_umin_cnt,x
6368                     ; 1572 		led_drv_cnt=30;
6370  1043 351e0016      	mov	_led_drv_cnt,#30
6371  1047               L3072:
6372                     ; 1576 if(apv_cnt_)
6374  1047 be4e          	ldw	x,_apv_cnt_
6375  1049 2712          	jreq	L7172
6376                     ; 1578 	apv_cnt_--;
6378  104b be4e          	ldw	x,_apv_cnt_
6379  104d 1d0001        	subw	x,#1
6380  1050 bf4e          	ldw	_apv_cnt_,x
6381                     ; 1579 	if(apv_cnt_==0) 
6383  1052 be4e          	ldw	x,_apv_cnt_
6384  1054 2607          	jrne	L7172
6385                     ; 1581 		bAPV=0;
6387  1056 72110002      	bres	_bAPV
6388                     ; 1582 		apv_start();
6390  105a cd0fac        	call	_apv_start
6392  105d               L7172:
6393                     ; 1586 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6395  105d be71          	ldw	x,_umin_cnt
6396  105f 261e          	jrne	L3272
6398  1061 be73          	ldw	x,_umax_cnt
6399  1063 261a          	jrne	L3272
6401  1065 c6500a        	ld	a,20490
6402  1068 a520          	bcp	a,#32
6403  106a 2613          	jrne	L3272
6404                     ; 1588 	if(cnt_apv_off<20)
6406  106c b64d          	ld	a,_cnt_apv_off
6407  106e a114          	cp	a,#20
6408  1070 240f          	jruge	L1372
6409                     ; 1590 		cnt_apv_off++;
6411  1072 3c4d          	inc	_cnt_apv_off
6412                     ; 1591 		if(cnt_apv_off>=20)
6414  1074 b64d          	ld	a,_cnt_apv_off
6415  1076 a114          	cp	a,#20
6416  1078 2507          	jrult	L1372
6417                     ; 1593 			apv_stop();
6419  107a cd0fd5        	call	_apv_stop
6421  107d 2002          	jra	L1372
6422  107f               L3272:
6423                     ; 1597 else cnt_apv_off=0;	
6425  107f 3f4d          	clr	_cnt_apv_off
6426  1081               L1372:
6427                     ; 1599 }
6430  1081 81            	ret
6433                     	switch	.ubsct
6434  0000               L3372_flags_old:
6435  0000 00            	ds.b	1
6471                     ; 1602 void flags_drv(void)
6471                     ; 1603 {
6472                     	switch	.text
6473  1082               _flags_drv:
6477                     ; 1605 if(jp_mode!=jp3) 
6479  1082 b655          	ld	a,_jp_mode
6480  1084 a103          	cp	a,#3
6481  1086 2723          	jreq	L3572
6482                     ; 1607 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6484  1088 b605          	ld	a,_flags
6485  108a a508          	bcp	a,#8
6486  108c 2706          	jreq	L1672
6488  108e b600          	ld	a,L3372_flags_old
6489  1090 a508          	bcp	a,#8
6490  1092 270c          	jreq	L7572
6491  1094               L1672:
6493  1094 b605          	ld	a,_flags
6494  1096 a510          	bcp	a,#16
6495  1098 2726          	jreq	L5672
6497  109a b600          	ld	a,L3372_flags_old
6498  109c a510          	bcp	a,#16
6499  109e 2620          	jrne	L5672
6500  10a0               L7572:
6501                     ; 1609     		if(link==OFF)apv_start();
6503  10a0 b670          	ld	a,_link
6504  10a2 a1aa          	cp	a,#170
6505  10a4 261a          	jrne	L5672
6508  10a6 cd0fac        	call	_apv_start
6510  10a9 2015          	jra	L5672
6511  10ab               L3572:
6512                     ; 1612 else if(jp_mode==jp3) 
6514  10ab b655          	ld	a,_jp_mode
6515  10ad a103          	cp	a,#3
6516  10af 260f          	jrne	L5672
6517                     ; 1614 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6519  10b1 b605          	ld	a,_flags
6520  10b3 a508          	bcp	a,#8
6521  10b5 2709          	jreq	L5672
6523  10b7 b600          	ld	a,L3372_flags_old
6524  10b9 a508          	bcp	a,#8
6525  10bb 2603          	jrne	L5672
6526                     ; 1616     		apv_start();
6528  10bd cd0fac        	call	_apv_start
6530  10c0               L5672:
6531                     ; 1619 flags_old=flags;
6533  10c0 450500        	mov	L3372_flags_old,_flags
6534                     ; 1621 } 
6537  10c3 81            	ret
6572                     ; 1758 void adr_drv_v4(char in)
6572                     ; 1759 {
6573                     	switch	.text
6574  10c4               _adr_drv_v4:
6578                     ; 1760 if(adress!=in)adress=in;
6580  10c4 c10101        	cp	a,_adress
6581  10c7 2703          	jreq	L1103
6584  10c9 c70101        	ld	_adress,a
6585  10cc               L1103:
6586                     ; 1761 }
6589  10cc 81            	ret
6618                     ; 1764 void adr_drv_v3(void)
6618                     ; 1765 {
6619                     	switch	.text
6620  10cd               _adr_drv_v3:
6622  10cd 88            	push	a
6623       00000001      OFST:	set	1
6626                     ; 1771 GPIOB->DDR&=~(1<<0);
6628  10ce 72115007      	bres	20487,#0
6629                     ; 1772 GPIOB->CR1&=~(1<<0);
6631  10d2 72115008      	bres	20488,#0
6632                     ; 1773 GPIOB->CR2&=~(1<<0);
6634  10d6 72115009      	bres	20489,#0
6635                     ; 1774 ADC2->CR2=0x08;
6637  10da 35085402      	mov	21506,#8
6638                     ; 1775 ADC2->CR1=0x40;
6640  10de 35405401      	mov	21505,#64
6641                     ; 1776 ADC2->CSR=0x20+0;
6643  10e2 35205400      	mov	21504,#32
6644                     ; 1777 ADC2->CR1|=1;
6646  10e6 72105401      	bset	21505,#0
6647                     ; 1778 ADC2->CR1|=1;
6649  10ea 72105401      	bset	21505,#0
6650                     ; 1779 adr_drv_stat=1;
6652  10ee 35010002      	mov	_adr_drv_stat,#1
6653  10f2               L3203:
6654                     ; 1780 while(adr_drv_stat==1);
6657  10f2 b602          	ld	a,_adr_drv_stat
6658  10f4 a101          	cp	a,#1
6659  10f6 27fa          	jreq	L3203
6660                     ; 1782 GPIOB->DDR&=~(1<<1);
6662  10f8 72135007      	bres	20487,#1
6663                     ; 1783 GPIOB->CR1&=~(1<<1);
6665  10fc 72135008      	bres	20488,#1
6666                     ; 1784 GPIOB->CR2&=~(1<<1);
6668  1100 72135009      	bres	20489,#1
6669                     ; 1785 ADC2->CR2=0x08;
6671  1104 35085402      	mov	21506,#8
6672                     ; 1786 ADC2->CR1=0x40;
6674  1108 35405401      	mov	21505,#64
6675                     ; 1787 ADC2->CSR=0x20+1;
6677  110c 35215400      	mov	21504,#33
6678                     ; 1788 ADC2->CR1|=1;
6680  1110 72105401      	bset	21505,#0
6681                     ; 1789 ADC2->CR1|=1;
6683  1114 72105401      	bset	21505,#0
6684                     ; 1790 adr_drv_stat=3;
6686  1118 35030002      	mov	_adr_drv_stat,#3
6687  111c               L1303:
6688                     ; 1791 while(adr_drv_stat==3);
6691  111c b602          	ld	a,_adr_drv_stat
6692  111e a103          	cp	a,#3
6693  1120 27fa          	jreq	L1303
6694                     ; 1793 GPIOE->DDR&=~(1<<6);
6696  1122 721d5016      	bres	20502,#6
6697                     ; 1794 GPIOE->CR1&=~(1<<6);
6699  1126 721d5017      	bres	20503,#6
6700                     ; 1795 GPIOE->CR2&=~(1<<6);
6702  112a 721d5018      	bres	20504,#6
6703                     ; 1796 ADC2->CR2=0x08;
6705  112e 35085402      	mov	21506,#8
6706                     ; 1797 ADC2->CR1=0x40;
6708  1132 35405401      	mov	21505,#64
6709                     ; 1798 ADC2->CSR=0x20+9;
6711  1136 35295400      	mov	21504,#41
6712                     ; 1799 ADC2->CR1|=1;
6714  113a 72105401      	bset	21505,#0
6715                     ; 1800 ADC2->CR1|=1;
6717  113e 72105401      	bset	21505,#0
6718                     ; 1801 adr_drv_stat=5;
6720  1142 35050002      	mov	_adr_drv_stat,#5
6721  1146               L7303:
6722                     ; 1802 while(adr_drv_stat==5);
6725  1146 b602          	ld	a,_adr_drv_stat
6726  1148 a105          	cp	a,#5
6727  114a 27fa          	jreq	L7303
6728                     ; 1806 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6730  114c 9c            	rvf
6731  114d ce0109        	ldw	x,_adc_buff_
6732  1150 a3022a        	cpw	x,#554
6733  1153 2f0f          	jrslt	L5403
6735  1155 9c            	rvf
6736  1156 ce0109        	ldw	x,_adc_buff_
6737  1159 a30253        	cpw	x,#595
6738  115c 2e06          	jrsge	L5403
6741  115e 725f0102      	clr	_adr
6743  1162 204c          	jra	L7403
6744  1164               L5403:
6745                     ; 1807 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6747  1164 9c            	rvf
6748  1165 ce0109        	ldw	x,_adc_buff_
6749  1168 a3036d        	cpw	x,#877
6750  116b 2f0f          	jrslt	L1503
6752  116d 9c            	rvf
6753  116e ce0109        	ldw	x,_adc_buff_
6754  1171 a30396        	cpw	x,#918
6755  1174 2e06          	jrsge	L1503
6758  1176 35010102      	mov	_adr,#1
6760  117a 2034          	jra	L7403
6761  117c               L1503:
6762                     ; 1808 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6764  117c 9c            	rvf
6765  117d ce0109        	ldw	x,_adc_buff_
6766  1180 a302a3        	cpw	x,#675
6767  1183 2f0f          	jrslt	L5503
6769  1185 9c            	rvf
6770  1186 ce0109        	ldw	x,_adc_buff_
6771  1189 a302cc        	cpw	x,#716
6772  118c 2e06          	jrsge	L5503
6775  118e 35020102      	mov	_adr,#2
6777  1192 201c          	jra	L7403
6778  1194               L5503:
6779                     ; 1809 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6781  1194 9c            	rvf
6782  1195 ce0109        	ldw	x,_adc_buff_
6783  1198 a303e3        	cpw	x,#995
6784  119b 2f0f          	jrslt	L1603
6786  119d 9c            	rvf
6787  119e ce0109        	ldw	x,_adc_buff_
6788  11a1 a3040c        	cpw	x,#1036
6789  11a4 2e06          	jrsge	L1603
6792  11a6 35030102      	mov	_adr,#3
6794  11aa 2004          	jra	L7403
6795  11ac               L1603:
6796                     ; 1810 else adr[0]=5;
6798  11ac 35050102      	mov	_adr,#5
6799  11b0               L7403:
6800                     ; 1812 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6802  11b0 9c            	rvf
6803  11b1 ce010b        	ldw	x,_adc_buff_+2
6804  11b4 a3022a        	cpw	x,#554
6805  11b7 2f0f          	jrslt	L5603
6807  11b9 9c            	rvf
6808  11ba ce010b        	ldw	x,_adc_buff_+2
6809  11bd a30253        	cpw	x,#595
6810  11c0 2e06          	jrsge	L5603
6813  11c2 725f0103      	clr	_adr+1
6815  11c6 204c          	jra	L7603
6816  11c8               L5603:
6817                     ; 1813 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6819  11c8 9c            	rvf
6820  11c9 ce010b        	ldw	x,_adc_buff_+2
6821  11cc a3036d        	cpw	x,#877
6822  11cf 2f0f          	jrslt	L1703
6824  11d1 9c            	rvf
6825  11d2 ce010b        	ldw	x,_adc_buff_+2
6826  11d5 a30396        	cpw	x,#918
6827  11d8 2e06          	jrsge	L1703
6830  11da 35010103      	mov	_adr+1,#1
6832  11de 2034          	jra	L7603
6833  11e0               L1703:
6834                     ; 1814 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6836  11e0 9c            	rvf
6837  11e1 ce010b        	ldw	x,_adc_buff_+2
6838  11e4 a302a3        	cpw	x,#675
6839  11e7 2f0f          	jrslt	L5703
6841  11e9 9c            	rvf
6842  11ea ce010b        	ldw	x,_adc_buff_+2
6843  11ed a302cc        	cpw	x,#716
6844  11f0 2e06          	jrsge	L5703
6847  11f2 35020103      	mov	_adr+1,#2
6849  11f6 201c          	jra	L7603
6850  11f8               L5703:
6851                     ; 1815 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6853  11f8 9c            	rvf
6854  11f9 ce010b        	ldw	x,_adc_buff_+2
6855  11fc a303e3        	cpw	x,#995
6856  11ff 2f0f          	jrslt	L1013
6858  1201 9c            	rvf
6859  1202 ce010b        	ldw	x,_adc_buff_+2
6860  1205 a3040c        	cpw	x,#1036
6861  1208 2e06          	jrsge	L1013
6864  120a 35030103      	mov	_adr+1,#3
6866  120e 2004          	jra	L7603
6867  1210               L1013:
6868                     ; 1816 else adr[1]=5;
6870  1210 35050103      	mov	_adr+1,#5
6871  1214               L7603:
6872                     ; 1818 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6874  1214 9c            	rvf
6875  1215 ce011b        	ldw	x,_adc_buff_+18
6876  1218 a3022a        	cpw	x,#554
6877  121b 2f0f          	jrslt	L5013
6879  121d 9c            	rvf
6880  121e ce011b        	ldw	x,_adc_buff_+18
6881  1221 a30253        	cpw	x,#595
6882  1224 2e06          	jrsge	L5013
6885  1226 725f0104      	clr	_adr+2
6887  122a 204c          	jra	L7013
6888  122c               L5013:
6889                     ; 1819 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6891  122c 9c            	rvf
6892  122d ce011b        	ldw	x,_adc_buff_+18
6893  1230 a3036d        	cpw	x,#877
6894  1233 2f0f          	jrslt	L1113
6896  1235 9c            	rvf
6897  1236 ce011b        	ldw	x,_adc_buff_+18
6898  1239 a30396        	cpw	x,#918
6899  123c 2e06          	jrsge	L1113
6902  123e 35010104      	mov	_adr+2,#1
6904  1242 2034          	jra	L7013
6905  1244               L1113:
6906                     ; 1820 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6908  1244 9c            	rvf
6909  1245 ce011b        	ldw	x,_adc_buff_+18
6910  1248 a302a3        	cpw	x,#675
6911  124b 2f0f          	jrslt	L5113
6913  124d 9c            	rvf
6914  124e ce011b        	ldw	x,_adc_buff_+18
6915  1251 a302cc        	cpw	x,#716
6916  1254 2e06          	jrsge	L5113
6919  1256 35020104      	mov	_adr+2,#2
6921  125a 201c          	jra	L7013
6922  125c               L5113:
6923                     ; 1821 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6925  125c 9c            	rvf
6926  125d ce011b        	ldw	x,_adc_buff_+18
6927  1260 a303e3        	cpw	x,#995
6928  1263 2f0f          	jrslt	L1213
6930  1265 9c            	rvf
6931  1266 ce011b        	ldw	x,_adc_buff_+18
6932  1269 a3040c        	cpw	x,#1036
6933  126c 2e06          	jrsge	L1213
6936  126e 35030104      	mov	_adr+2,#3
6938  1272 2004          	jra	L7013
6939  1274               L1213:
6940                     ; 1822 else adr[2]=5;
6942  1274 35050104      	mov	_adr+2,#5
6943  1278               L7013:
6944                     ; 1826 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6946  1278 c60102        	ld	a,_adr
6947  127b a105          	cp	a,#5
6948  127d 270e          	jreq	L7213
6950  127f c60103        	ld	a,_adr+1
6951  1282 a105          	cp	a,#5
6952  1284 2707          	jreq	L7213
6954  1286 c60104        	ld	a,_adr+2
6955  1289 a105          	cp	a,#5
6956  128b 2606          	jrne	L5213
6957  128d               L7213:
6958                     ; 1829 	adress_error=1;
6960  128d 35010100      	mov	_adress_error,#1
6962  1291               L3313:
6963                     ; 1840 }
6966  1291 84            	pop	a
6967  1292 81            	ret
6968  1293               L5213:
6969                     ; 1833 	if(adr[2]&0x02) bps_class=bpsIPS;
6971  1293 c60104        	ld	a,_adr+2
6972  1296 a502          	bcp	a,#2
6973  1298 2706          	jreq	L5313
6976  129a 3501000b      	mov	_bps_class,#1
6978  129e 2002          	jra	L7313
6979  12a0               L5313:
6980                     ; 1834 	else bps_class=bpsIBEP;
6982  12a0 3f0b          	clr	_bps_class
6983  12a2               L7313:
6984                     ; 1836 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6986  12a2 c60104        	ld	a,_adr+2
6987  12a5 a401          	and	a,#1
6988  12a7 97            	ld	xl,a
6989  12a8 a610          	ld	a,#16
6990  12aa 42            	mul	x,a
6991  12ab 9f            	ld	a,xl
6992  12ac 6b01          	ld	(OFST+0,sp),a
6993  12ae c60103        	ld	a,_adr+1
6994  12b1 48            	sll	a
6995  12b2 48            	sll	a
6996  12b3 cb0102        	add	a,_adr
6997  12b6 1b01          	add	a,(OFST+0,sp)
6998  12b8 c70101        	ld	_adress,a
6999  12bb 20d4          	jra	L3313
7022                     ; 1890 void init_CAN(void) {
7023                     	switch	.text
7024  12bd               _init_CAN:
7028                     ; 1891 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7030  12bd 72135420      	bres	21536,#1
7031                     ; 1892 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7033  12c1 72105420      	bset	21536,#0
7035  12c5               L3513:
7036                     ; 1893 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7038  12c5 c65421        	ld	a,21537
7039  12c8 a501          	bcp	a,#1
7040  12ca 27f9          	jreq	L3513
7041                     ; 1895 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7043  12cc 72185420      	bset	21536,#4
7044                     ; 1897 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7046  12d0 35025427      	mov	21543,#2
7047                     ; 1906 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7049  12d4 35135428      	mov	21544,#19
7050                     ; 1907 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7052  12d8 35c05429      	mov	21545,#192
7053                     ; 1908 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7055  12dc 357f542c      	mov	21548,#127
7056                     ; 1909 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7058  12e0 35e0542d      	mov	21549,#224
7059                     ; 1911 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7061  12e4 35315430      	mov	21552,#49
7062                     ; 1912 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7064  12e8 35c05431      	mov	21553,#192
7065                     ; 1913 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7067  12ec 357f5434      	mov	21556,#127
7068                     ; 1914 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7070  12f0 35e05435      	mov	21557,#224
7071                     ; 1918 	CAN->PSR= 6;									// set page 6
7073  12f4 35065427      	mov	21543,#6
7074                     ; 1923 	CAN->Page.Config.FMR1&=~3;								//mask mode
7076  12f8 c65430        	ld	a,21552
7077  12fb a4fc          	and	a,#252
7078  12fd c75430        	ld	21552,a
7079                     ; 1929 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7081  1300 35065432      	mov	21554,#6
7082                     ; 1930 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7084  1304 35605432      	mov	21554,#96
7085                     ; 1933 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7087  1308 72105432      	bset	21554,#0
7088                     ; 1934 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7090  130c 72185432      	bset	21554,#4
7091                     ; 1937 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7093  1310 35065427      	mov	21543,#6
7094                     ; 1939 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7096  1314 35d3542c      	mov	21548,#211
7097                     ; 1940 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7099  1318 35e7542d      	mov	21549,#231
7100                     ; 1942 	CAN->IER|=(1<<1);
7102  131c 72125425      	bset	21541,#1
7103                     ; 1945 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7105  1320 72115420      	bres	21536,#0
7107  1324               L1613:
7108                     ; 1946 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7110  1324 c65421        	ld	a,21537
7111  1327 a501          	bcp	a,#1
7112  1329 26f9          	jrne	L1613
7113                     ; 1947 }
7116  132b 81            	ret
7224                     ; 1950 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7224                     ; 1951 {
7225                     	switch	.text
7226  132c               _can_transmit:
7228  132c 89            	pushw	x
7229       00000000      OFST:	set	0
7232                     ; 1953 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7234  132d b679          	ld	a,_can_buff_wr_ptr
7235  132f a104          	cp	a,#4
7236  1331 2502          	jrult	L3423
7239  1333 3f79          	clr	_can_buff_wr_ptr
7240  1335               L3423:
7241                     ; 1955 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7243  1335 b679          	ld	a,_can_buff_wr_ptr
7244  1337 97            	ld	xl,a
7245  1338 a610          	ld	a,#16
7246  133a 42            	mul	x,a
7247  133b 1601          	ldw	y,(OFST+1,sp)
7248  133d a606          	ld	a,#6
7249  133f               L641:
7250  133f 9054          	srlw	y
7251  1341 4a            	dec	a
7252  1342 26fb          	jrne	L641
7253  1344 909f          	ld	a,yl
7254  1346 e77a          	ld	(_can_out_buff,x),a
7255                     ; 1956 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7257  1348 b679          	ld	a,_can_buff_wr_ptr
7258  134a 97            	ld	xl,a
7259  134b a610          	ld	a,#16
7260  134d 42            	mul	x,a
7261  134e 7b02          	ld	a,(OFST+2,sp)
7262  1350 48            	sll	a
7263  1351 48            	sll	a
7264  1352 e77b          	ld	(_can_out_buff+1,x),a
7265                     ; 1958 can_out_buff[can_buff_wr_ptr][2]=data0;
7267  1354 b679          	ld	a,_can_buff_wr_ptr
7268  1356 97            	ld	xl,a
7269  1357 a610          	ld	a,#16
7270  1359 42            	mul	x,a
7271  135a 7b05          	ld	a,(OFST+5,sp)
7272  135c e77c          	ld	(_can_out_buff+2,x),a
7273                     ; 1959 can_out_buff[can_buff_wr_ptr][3]=data1;
7275  135e b679          	ld	a,_can_buff_wr_ptr
7276  1360 97            	ld	xl,a
7277  1361 a610          	ld	a,#16
7278  1363 42            	mul	x,a
7279  1364 7b06          	ld	a,(OFST+6,sp)
7280  1366 e77d          	ld	(_can_out_buff+3,x),a
7281                     ; 1960 can_out_buff[can_buff_wr_ptr][4]=data2;
7283  1368 b679          	ld	a,_can_buff_wr_ptr
7284  136a 97            	ld	xl,a
7285  136b a610          	ld	a,#16
7286  136d 42            	mul	x,a
7287  136e 7b07          	ld	a,(OFST+7,sp)
7288  1370 e77e          	ld	(_can_out_buff+4,x),a
7289                     ; 1961 can_out_buff[can_buff_wr_ptr][5]=data3;
7291  1372 b679          	ld	a,_can_buff_wr_ptr
7292  1374 97            	ld	xl,a
7293  1375 a610          	ld	a,#16
7294  1377 42            	mul	x,a
7295  1378 7b08          	ld	a,(OFST+8,sp)
7296  137a e77f          	ld	(_can_out_buff+5,x),a
7297                     ; 1962 can_out_buff[can_buff_wr_ptr][6]=data4;
7299  137c b679          	ld	a,_can_buff_wr_ptr
7300  137e 97            	ld	xl,a
7301  137f a610          	ld	a,#16
7302  1381 42            	mul	x,a
7303  1382 7b09          	ld	a,(OFST+9,sp)
7304  1384 e780          	ld	(_can_out_buff+6,x),a
7305                     ; 1963 can_out_buff[can_buff_wr_ptr][7]=data5;
7307  1386 b679          	ld	a,_can_buff_wr_ptr
7308  1388 97            	ld	xl,a
7309  1389 a610          	ld	a,#16
7310  138b 42            	mul	x,a
7311  138c 7b0a          	ld	a,(OFST+10,sp)
7312  138e e781          	ld	(_can_out_buff+7,x),a
7313                     ; 1964 can_out_buff[can_buff_wr_ptr][8]=data6;
7315  1390 b679          	ld	a,_can_buff_wr_ptr
7316  1392 97            	ld	xl,a
7317  1393 a610          	ld	a,#16
7318  1395 42            	mul	x,a
7319  1396 7b0b          	ld	a,(OFST+11,sp)
7320  1398 e782          	ld	(_can_out_buff+8,x),a
7321                     ; 1965 can_out_buff[can_buff_wr_ptr][9]=data7;
7323  139a b679          	ld	a,_can_buff_wr_ptr
7324  139c 97            	ld	xl,a
7325  139d a610          	ld	a,#16
7326  139f 42            	mul	x,a
7327  13a0 7b0c          	ld	a,(OFST+12,sp)
7328  13a2 e783          	ld	(_can_out_buff+9,x),a
7329                     ; 1967 can_buff_wr_ptr++;
7331  13a4 3c79          	inc	_can_buff_wr_ptr
7332                     ; 1968 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7334  13a6 b679          	ld	a,_can_buff_wr_ptr
7335  13a8 a104          	cp	a,#4
7336  13aa 2502          	jrult	L5423
7339  13ac 3f79          	clr	_can_buff_wr_ptr
7340  13ae               L5423:
7341                     ; 1969 } 
7344  13ae 85            	popw	x
7345  13af 81            	ret
7374                     ; 1972 void can_tx_hndl(void)
7374                     ; 1973 {
7375                     	switch	.text
7376  13b0               _can_tx_hndl:
7380                     ; 1974 if(bTX_FREE)
7382  13b0 3d03          	tnz	_bTX_FREE
7383  13b2 2757          	jreq	L7523
7384                     ; 1976 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7386  13b4 b678          	ld	a,_can_buff_rd_ptr
7387  13b6 b179          	cp	a,_can_buff_wr_ptr
7388  13b8 275f          	jreq	L5623
7389                     ; 1978 		bTX_FREE=0;
7391  13ba 3f03          	clr	_bTX_FREE
7392                     ; 1980 		CAN->PSR= 0;
7394  13bc 725f5427      	clr	21543
7395                     ; 1981 		CAN->Page.TxMailbox.MDLCR=8;
7397  13c0 35085429      	mov	21545,#8
7398                     ; 1982 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7400  13c4 b678          	ld	a,_can_buff_rd_ptr
7401  13c6 97            	ld	xl,a
7402  13c7 a610          	ld	a,#16
7403  13c9 42            	mul	x,a
7404  13ca e67a          	ld	a,(_can_out_buff,x)
7405  13cc c7542a        	ld	21546,a
7406                     ; 1983 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7408  13cf b678          	ld	a,_can_buff_rd_ptr
7409  13d1 97            	ld	xl,a
7410  13d2 a610          	ld	a,#16
7411  13d4 42            	mul	x,a
7412  13d5 e67b          	ld	a,(_can_out_buff+1,x)
7413  13d7 c7542b        	ld	21547,a
7414                     ; 1985 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7416  13da b678          	ld	a,_can_buff_rd_ptr
7417  13dc 97            	ld	xl,a
7418  13dd a610          	ld	a,#16
7419  13df 42            	mul	x,a
7420  13e0 01            	rrwa	x,a
7421  13e1 ab7c          	add	a,#_can_out_buff+2
7422  13e3 2401          	jrnc	L251
7423  13e5 5c            	incw	x
7424  13e6               L251:
7425  13e6 5f            	clrw	x
7426  13e7 97            	ld	xl,a
7427  13e8 bf00          	ldw	c_x,x
7428  13ea ae0008        	ldw	x,#8
7429  13ed               L451:
7430  13ed 5a            	decw	x
7431  13ee 92d600        	ld	a,([c_x],x)
7432  13f1 d7542e        	ld	(21550,x),a
7433  13f4 5d            	tnzw	x
7434  13f5 26f6          	jrne	L451
7435                     ; 1987 		can_buff_rd_ptr++;
7437  13f7 3c78          	inc	_can_buff_rd_ptr
7438                     ; 1988 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7440  13f9 b678          	ld	a,_can_buff_rd_ptr
7441  13fb a104          	cp	a,#4
7442  13fd 2502          	jrult	L3623
7445  13ff 3f78          	clr	_can_buff_rd_ptr
7446  1401               L3623:
7447                     ; 1990 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7449  1401 72105428      	bset	21544,#0
7450                     ; 1991 		CAN->IER|=(1<<0);
7452  1405 72105425      	bset	21541,#0
7453  1409 200e          	jra	L5623
7454  140b               L7523:
7455                     ; 1996 	tx_busy_cnt++;
7457  140b 3c77          	inc	_tx_busy_cnt
7458                     ; 1997 	if(tx_busy_cnt>=100)
7460  140d b677          	ld	a,_tx_busy_cnt
7461  140f a164          	cp	a,#100
7462  1411 2506          	jrult	L5623
7463                     ; 1999 		tx_busy_cnt=0;
7465  1413 3f77          	clr	_tx_busy_cnt
7466                     ; 2000 		bTX_FREE=1;
7468  1415 35010003      	mov	_bTX_FREE,#1
7469  1419               L5623:
7470                     ; 2003 }
7473  1419 81            	ret
7595                     ; 2029 void can_in_an(void)
7595                     ; 2030 {
7596                     	switch	.text
7597  141a               _can_in_an:
7599  141a 5207          	subw	sp,#7
7600       00000007      OFST:	set	7
7603                     ; 2040 if((mess[6]==adress)&&(mess[7]==adress)&&((mess[8]==GETTM) || (mess[8]==GETTM1) || (mess[8]==GETTM2)))	
7605  141c b6d0          	ld	a,_mess+6
7606  141e c10101        	cp	a,_adress
7607  1421 2703          	jreq	L471
7608  1423 cc15c5        	jp	L5233
7609  1426               L471:
7611  1426 b6d1          	ld	a,_mess+7
7612  1428 c10101        	cp	a,_adress
7613  142b 2703          	jreq	L671
7614  142d cc15c5        	jp	L5233
7615  1430               L671:
7617  1430 b6d2          	ld	a,_mess+8
7618  1432 a1ed          	cp	a,#237
7619  1434 270f          	jreq	L7233
7621  1436 b6d2          	ld	a,_mess+8
7622  1438 a1eb          	cp	a,#235
7623  143a 2709          	jreq	L7233
7625  143c b6d2          	ld	a,_mess+8
7626  143e a1ec          	cp	a,#236
7627  1440 2703          	jreq	L002
7628  1442 cc15c5        	jp	L5233
7629  1445               L002:
7630  1445               L7233:
7631                     ; 2043 	can_error_cnt=0;
7633  1445 3f76          	clr	_can_error_cnt
7634                     ; 2045 	bMAIN=0;
7636  1447 72110001      	bres	_bMAIN
7637                     ; 2046  	flags_tu=mess[9];
7639  144b 45d36d        	mov	_flags_tu,_mess+9
7640                     ; 2047  	if(flags_tu&0b00000001)
7642  144e b66d          	ld	a,_flags_tu
7643  1450 a501          	bcp	a,#1
7644  1452 2706          	jreq	L3333
7645                     ; 2052  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7647  1454 721a0005      	bset	_flags,#5
7649  1458 2008          	jra	L5333
7650  145a               L3333:
7651                     ; 2063  				flags&=0b11011111; 
7653  145a 721b0005      	bres	_flags,#5
7654                     ; 2064  				off_bp_cnt=5*EE_TZAS;
7656  145e 350f0060      	mov	_off_bp_cnt,#15
7657  1462               L5333:
7658                     ; 2070  	if(flags_tu&0b00000010) flags|=0b01000000;
7660  1462 b66d          	ld	a,_flags_tu
7661  1464 a502          	bcp	a,#2
7662  1466 2706          	jreq	L7333
7665  1468 721c0005      	bset	_flags,#6
7667  146c 2004          	jra	L1433
7668  146e               L7333:
7669                     ; 2071  	else flags&=0b10111111; 
7671  146e 721d0005      	bres	_flags,#6
7672  1472               L1433:
7673                     ; 2073  	U_out_const=mess[10]+mess[11]*256;
7675  1472 b6d5          	ld	a,_mess+11
7676  1474 5f            	clrw	x
7677  1475 97            	ld	xl,a
7678  1476 4f            	clr	a
7679  1477 02            	rlwa	x,a
7680  1478 01            	rrwa	x,a
7681  1479 bbd4          	add	a,_mess+10
7682  147b 2401          	jrnc	L061
7683  147d 5c            	incw	x
7684  147e               L061:
7685  147e c70013        	ld	_U_out_const+1,a
7686  1481 9f            	ld	a,xl
7687  1482 c70012        	ld	_U_out_const,a
7688                     ; 2074  	vol_i_temp=mess[12]+mess[13]*256;
7690  1485 b6d7          	ld	a,_mess+13
7691  1487 5f            	clrw	x
7692  1488 97            	ld	xl,a
7693  1489 4f            	clr	a
7694  148a 02            	rlwa	x,a
7695  148b 01            	rrwa	x,a
7696  148c bbd6          	add	a,_mess+12
7697  148e 2401          	jrnc	L261
7698  1490 5c            	incw	x
7699  1491               L261:
7700  1491 b764          	ld	_vol_i_temp+1,a
7701  1493 9f            	ld	a,xl
7702  1494 b763          	ld	_vol_i_temp,a
7703                     ; 2086 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7705  1496 b608          	ld	a,_vent_resurs_tx_cnt
7706  1498 a102          	cp	a,#2
7707  149a 2507          	jrult	L3433
7710  149c ce0000        	ldw	x,_vent_resurs
7711  149f bf42          	ldw	_plazma_int+4,x
7713  14a1 2004          	jra	L5433
7714  14a3               L3433:
7715                     ; 2087 	else plazma_int[2]=vent_resurs_sec_cnt;
7717  14a3 be09          	ldw	x,_vent_resurs_sec_cnt
7718  14a5 bf42          	ldw	_plazma_int+4,x
7719  14a7               L5433:
7720                     ; 2088  	rotor_int=flags_tu+(((short)flags)<<8);
7722  14a7 b605          	ld	a,_flags
7723  14a9 5f            	clrw	x
7724  14aa 97            	ld	xl,a
7725  14ab 4f            	clr	a
7726  14ac 02            	rlwa	x,a
7727  14ad 01            	rrwa	x,a
7728  14ae bb6d          	add	a,_flags_tu
7729  14b0 2401          	jrnc	L461
7730  14b2 5c            	incw	x
7731  14b3               L461:
7732  14b3 b718          	ld	_rotor_int+1,a
7733  14b5 9f            	ld	a,xl
7734  14b6 b717          	ld	_rotor_int,a
7735                     ; 2090 	debug_info_to_uku[0]=U_out_const;
7737  14b8 ce0012        	ldw	x,_U_out_const
7738  14bb bf01          	ldw	_debug_info_to_uku,x
7739                     ; 2091 	debug_info_to_uku[1]=ee_UAVT;//Ufade;//Usum;
7741  14bd ce000c        	ldw	x,_ee_UAVT
7742  14c0 bf03          	ldw	_debug_info_to_uku+2,x
7743                     ; 2092 	debug_info_to_uku[2]=pwm_u;//vol_i_temp;//U_out_const;//pwm_u;
7745  14c2 be08          	ldw	x,_pwm_u
7746  14c4 bf05          	ldw	_debug_info_to_uku+4,x
7747                     ; 2095 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7749  14c6 3b0016        	push	_Ui
7750  14c9 3b0017        	push	_Ui+1
7751  14cc 3b0018        	push	_Un
7752  14cf 3b0019        	push	_Un+1
7753  14d2 3b001a        	push	_I
7754  14d5 3b001b        	push	_I+1
7755  14d8 4bda          	push	#218
7756  14da 3b0101        	push	_adress
7757  14dd ae018e        	ldw	x,#398
7758  14e0 cd132c        	call	_can_transmit
7760  14e3 5b08          	addw	sp,#8
7761                     ; 2096 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7763  14e5 3b0010        	push	_Usum
7764  14e8 3b0011        	push	_Usum+1
7765  14eb 3b006c        	push	__x_+1
7766  14ee 3b0005        	push	_flags
7767  14f1 b608          	ld	a,_vent_resurs_tx_cnt
7768  14f3 5f            	clrw	x
7769  14f4 97            	ld	xl,a
7770  14f5 d60000        	ld	a,(_vent_resurs_buff,x)
7771  14f8 88            	push	a
7772  14f9 3b0075        	push	_T
7773  14fc 4bdb          	push	#219
7774  14fe 3b0101        	push	_adress
7775  1501 ae018e        	ldw	x,#398
7776  1504 cd132c        	call	_can_transmit
7778  1507 5b08          	addw	sp,#8
7779                     ; 2097 	if(mess[8]==GETTM)	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&	debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7781  1509 b6d2          	ld	a,_mess+8
7782  150b a1ed          	cp	a,#237
7783  150d 261f          	jrne	L7433
7786  150f 3b0005        	push	_debug_info_to_uku+4
7787  1512 3b0006        	push	_debug_info_to_uku+5
7788  1515 3b0003        	push	_debug_info_to_uku+2
7789  1518 3b0004        	push	_debug_info_to_uku+3
7790  151b 3b0001        	push	_debug_info_to_uku
7791  151e 3b0002        	push	_debug_info_to_uku+1
7792  1521 4bdc          	push	#220
7793  1523 3b0101        	push	_adress
7794  1526 ae018e        	ldw	x,#398
7795  1529 cd132c        	call	_can_transmit
7797  152c 5b08          	addw	sp,#8
7798  152e               L7433:
7799                     ; 2098 	if(mess[8]==GETTM1)	can_transmit(0x18e,adress,PUTTM31,*(((char*)&HARDVARE_VERSION)+1),*((char*)&HARDVARE_VERSION),*(((char*)&SOFT_VERSION)+1),*((char*)&SOFT_VERSION),*(((char*)&BUILD)+1),*((char*)&BUILD));
7801  152e b6d2          	ld	a,_mess+8
7802  1530 a1eb          	cp	a,#235
7803  1532 261f          	jrne	L1533
7806  1534 3b0000        	push	_BUILD
7807  1537 3b0001        	push	_BUILD+1
7808  153a 3b0000        	push	_SOFT_VERSION
7809  153d 3b0001        	push	_SOFT_VERSION+1
7810  1540 3b0000        	push	_HARDVARE_VERSION
7811  1543 3b0001        	push	_HARDVARE_VERSION+1
7812  1546 4bdd          	push	#221
7813  1548 3b0101        	push	_adress
7814  154b ae018e        	ldw	x,#398
7815  154e cd132c        	call	_can_transmit
7817  1551 5b08          	addw	sp,#8
7818  1553               L1533:
7819                     ; 2099 	if(mess[8]==GETTM2)	can_transmit(0x18e,adress,PUTTM32,*(((char*)&BUILD_YEAR)+1),*((char*)&BUILD_YEAR),*(((char*)&BUILD_MONTH)+1),*((char*)&BUILD_MONTH),*(((char*)&BUILD_DAY)+1),*((char*)&BUILD_DAY));
7821  1553 b6d2          	ld	a,_mess+8
7822  1555 a1ec          	cp	a,#236
7823  1557 261f          	jrne	L3533
7826  1559 3b0000        	push	_BUILD_DAY
7827  155c 3b0001        	push	_BUILD_DAY+1
7828  155f 3b0000        	push	_BUILD_MONTH
7829  1562 3b0001        	push	_BUILD_MONTH+1
7830  1565 3b0000        	push	_BUILD_YEAR
7831  1568 3b0001        	push	_BUILD_YEAR+1
7832  156b 4bd5          	push	#213
7833  156d 3b0101        	push	_adress
7834  1570 ae018e        	ldw	x,#398
7835  1573 cd132c        	call	_can_transmit
7837  1576 5b08          	addw	sp,#8
7838  1578               L3533:
7839                     ; 2101      link_cnt=0;
7841  1578 5f            	clrw	x
7842  1579 bf6e          	ldw	_link_cnt,x
7843                     ; 2102      link=ON;
7845  157b 35550070      	mov	_link,#85
7846                     ; 2104      if(flags_tu&0b10000000)
7848  157f b66d          	ld	a,_flags_tu
7849  1581 a580          	bcp	a,#128
7850  1583 2716          	jreq	L5533
7851                     ; 2106      	if(!res_fl)
7853  1585 725d000b      	tnz	_res_fl
7854  1589 2626          	jrne	L1633
7855                     ; 2108      		res_fl=1;
7857  158b a601          	ld	a,#1
7858  158d ae000b        	ldw	x,#_res_fl
7859  1590 cd0000        	call	c_eewrc
7861                     ; 2109      		bRES=1;
7863  1593 3501000c      	mov	_bRES,#1
7864                     ; 2110      		res_fl_cnt=0;
7866  1597 3f4c          	clr	_res_fl_cnt
7867  1599 2016          	jra	L1633
7868  159b               L5533:
7869                     ; 2115      	if(main_cnt>20)
7871  159b 9c            	rvf
7872  159c ce025f        	ldw	x,_main_cnt
7873  159f a30015        	cpw	x,#21
7874  15a2 2f0d          	jrslt	L1633
7875                     ; 2117     			if(res_fl)
7877  15a4 725d000b      	tnz	_res_fl
7878  15a8 2707          	jreq	L1633
7879                     ; 2119      			res_fl=0;
7881  15aa 4f            	clr	a
7882  15ab ae000b        	ldw	x,#_res_fl
7883  15ae cd0000        	call	c_eewrc
7885  15b1               L1633:
7886                     ; 2124       if(res_fl_)
7888  15b1 725d000a      	tnz	_res_fl_
7889  15b5 2603          	jrne	L202
7890  15b7 cc1b26        	jp	L1723
7891  15ba               L202:
7892                     ; 2126       	res_fl_=0;
7894  15ba 4f            	clr	a
7895  15bb ae000a        	ldw	x,#_res_fl_
7896  15be cd0000        	call	c_eewrc
7898  15c1 ac261b26      	jpf	L1723
7899  15c5               L5233:
7900                     ; 2129 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7902  15c5 b6d0          	ld	a,_mess+6
7903  15c7 c10101        	cp	a,_adress
7904  15ca 2703          	jreq	L402
7905  15cc cc1842        	jp	L3733
7906  15cf               L402:
7908  15cf b6d1          	ld	a,_mess+7
7909  15d1 c10101        	cp	a,_adress
7910  15d4 2703          	jreq	L602
7911  15d6 cc1842        	jp	L3733
7912  15d9               L602:
7914  15d9 b6d2          	ld	a,_mess+8
7915  15db a1ee          	cp	a,#238
7916  15dd 2703          	jreq	L012
7917  15df cc1842        	jp	L3733
7918  15e2               L012:
7920  15e2 b6d3          	ld	a,_mess+9
7921  15e4 b1d4          	cp	a,_mess+10
7922  15e6 2703          	jreq	L212
7923  15e8 cc1842        	jp	L3733
7924  15eb               L212:
7925                     ; 2131 	rotor_int++;
7927  15eb be17          	ldw	x,_rotor_int
7928  15ed 1c0001        	addw	x,#1
7929  15f0 bf17          	ldw	_rotor_int,x
7930                     ; 2132 	if((mess[9]&0xf0)==0x20)
7932  15f2 b6d3          	ld	a,_mess+9
7933  15f4 a4f0          	and	a,#240
7934  15f6 a120          	cp	a,#32
7935  15f8 2673          	jrne	L5733
7936                     ; 2134 		if((mess[9]&0x0f)==0x01)
7938  15fa b6d3          	ld	a,_mess+9
7939  15fc a40f          	and	a,#15
7940  15fe a101          	cp	a,#1
7941  1600 260d          	jrne	L7733
7942                     ; 2136 			ee_K[0][0]=adc_buff_[4];
7944  1602 ce0111        	ldw	x,_adc_buff_+8
7945  1605 89            	pushw	x
7946  1606 ae001a        	ldw	x,#_ee_K
7947  1609 cd0000        	call	c_eewrw
7949  160c 85            	popw	x
7951  160d 204a          	jra	L1043
7952  160f               L7733:
7953                     ; 2138 		else if((mess[9]&0x0f)==0x02)
7955  160f b6d3          	ld	a,_mess+9
7956  1611 a40f          	and	a,#15
7957  1613 a102          	cp	a,#2
7958  1615 260b          	jrne	L3043
7959                     ; 2140 			ee_K[0][1]++;
7961  1617 ce001c        	ldw	x,_ee_K+2
7962  161a 1c0001        	addw	x,#1
7963  161d cf001c        	ldw	_ee_K+2,x
7965  1620 2037          	jra	L1043
7966  1622               L3043:
7967                     ; 2142 		else if((mess[9]&0x0f)==0x03)
7969  1622 b6d3          	ld	a,_mess+9
7970  1624 a40f          	and	a,#15
7971  1626 a103          	cp	a,#3
7972  1628 260b          	jrne	L7043
7973                     ; 2144 			ee_K[0][1]+=10;
7975  162a ce001c        	ldw	x,_ee_K+2
7976  162d 1c000a        	addw	x,#10
7977  1630 cf001c        	ldw	_ee_K+2,x
7979  1633 2024          	jra	L1043
7980  1635               L7043:
7981                     ; 2146 		else if((mess[9]&0x0f)==0x04)
7983  1635 b6d3          	ld	a,_mess+9
7984  1637 a40f          	and	a,#15
7985  1639 a104          	cp	a,#4
7986  163b 260b          	jrne	L3143
7987                     ; 2148 			ee_K[0][1]--;
7989  163d ce001c        	ldw	x,_ee_K+2
7990  1640 1d0001        	subw	x,#1
7991  1643 cf001c        	ldw	_ee_K+2,x
7993  1646 2011          	jra	L1043
7994  1648               L3143:
7995                     ; 2150 		else if((mess[9]&0x0f)==0x05)
7997  1648 b6d3          	ld	a,_mess+9
7998  164a a40f          	and	a,#15
7999  164c a105          	cp	a,#5
8000  164e 2609          	jrne	L1043
8001                     ; 2152 			ee_K[0][1]-=10;
8003  1650 ce001c        	ldw	x,_ee_K+2
8004  1653 1d000a        	subw	x,#10
8005  1656 cf001c        	ldw	_ee_K+2,x
8006  1659               L1043:
8007                     ; 2154 		granee(&ee_K[0][1],50,3000);									
8009  1659 ae0bb8        	ldw	x,#3000
8010  165c 89            	pushw	x
8011  165d ae0032        	ldw	x,#50
8012  1660 89            	pushw	x
8013  1661 ae001c        	ldw	x,#_ee_K+2
8014  1664 cd00f6        	call	_granee
8016  1667 5b04          	addw	sp,#4
8018  1669 ac271827      	jpf	L1243
8019  166d               L5733:
8020                     ; 2156 	else if((mess[9]&0xf0)==0x10)
8022  166d b6d3          	ld	a,_mess+9
8023  166f a4f0          	and	a,#240
8024  1671 a110          	cp	a,#16
8025  1673 2673          	jrne	L3243
8026                     ; 2158 		if((mess[9]&0x0f)==0x01)
8028  1675 b6d3          	ld	a,_mess+9
8029  1677 a40f          	and	a,#15
8030  1679 a101          	cp	a,#1
8031  167b 260d          	jrne	L5243
8032                     ; 2160 			ee_K[1][0]=adc_buff_[1];
8034  167d ce010b        	ldw	x,_adc_buff_+2
8035  1680 89            	pushw	x
8036  1681 ae001e        	ldw	x,#_ee_K+4
8037  1684 cd0000        	call	c_eewrw
8039  1687 85            	popw	x
8041  1688 204a          	jra	L7243
8042  168a               L5243:
8043                     ; 2162 		else if((mess[9]&0x0f)==0x02)
8045  168a b6d3          	ld	a,_mess+9
8046  168c a40f          	and	a,#15
8047  168e a102          	cp	a,#2
8048  1690 260b          	jrne	L1343
8049                     ; 2164 			ee_K[1][1]++;
8051  1692 ce0020        	ldw	x,_ee_K+6
8052  1695 1c0001        	addw	x,#1
8053  1698 cf0020        	ldw	_ee_K+6,x
8055  169b 2037          	jra	L7243
8056  169d               L1343:
8057                     ; 2166 		else if((mess[9]&0x0f)==0x03)
8059  169d b6d3          	ld	a,_mess+9
8060  169f a40f          	and	a,#15
8061  16a1 a103          	cp	a,#3
8062  16a3 260b          	jrne	L5343
8063                     ; 2168 			ee_K[1][1]+=10;
8065  16a5 ce0020        	ldw	x,_ee_K+6
8066  16a8 1c000a        	addw	x,#10
8067  16ab cf0020        	ldw	_ee_K+6,x
8069  16ae 2024          	jra	L7243
8070  16b0               L5343:
8071                     ; 2170 		else if((mess[9]&0x0f)==0x04)
8073  16b0 b6d3          	ld	a,_mess+9
8074  16b2 a40f          	and	a,#15
8075  16b4 a104          	cp	a,#4
8076  16b6 260b          	jrne	L1443
8077                     ; 2172 			ee_K[1][1]--;
8079  16b8 ce0020        	ldw	x,_ee_K+6
8080  16bb 1d0001        	subw	x,#1
8081  16be cf0020        	ldw	_ee_K+6,x
8083  16c1 2011          	jra	L7243
8084  16c3               L1443:
8085                     ; 2174 		else if((mess[9]&0x0f)==0x05)
8087  16c3 b6d3          	ld	a,_mess+9
8088  16c5 a40f          	and	a,#15
8089  16c7 a105          	cp	a,#5
8090  16c9 2609          	jrne	L7243
8091                     ; 2176 			ee_K[1][1]-=10;
8093  16cb ce0020        	ldw	x,_ee_K+6
8094  16ce 1d000a        	subw	x,#10
8095  16d1 cf0020        	ldw	_ee_K+6,x
8096  16d4               L7243:
8097                     ; 2181 		granee(&ee_K[1][1],10,30000);
8099  16d4 ae7530        	ldw	x,#30000
8100  16d7 89            	pushw	x
8101  16d8 ae000a        	ldw	x,#10
8102  16db 89            	pushw	x
8103  16dc ae0020        	ldw	x,#_ee_K+6
8104  16df cd00f6        	call	_granee
8106  16e2 5b04          	addw	sp,#4
8108  16e4 ac271827      	jpf	L1243
8109  16e8               L3243:
8110                     ; 2185 	else if((mess[9]&0xf0)==0x00)
8112  16e8 b6d3          	ld	a,_mess+9
8113  16ea a5f0          	bcp	a,#240
8114  16ec 2673          	jrne	L1543
8115                     ; 2187 		if((mess[9]&0x0f)==0x01)
8117  16ee b6d3          	ld	a,_mess+9
8118  16f0 a40f          	and	a,#15
8119  16f2 a101          	cp	a,#1
8120  16f4 260d          	jrne	L3543
8121                     ; 2189 			ee_K[2][0]=adc_buff_[2];
8123  16f6 ce010d        	ldw	x,_adc_buff_+4
8124  16f9 89            	pushw	x
8125  16fa ae0022        	ldw	x,#_ee_K+8
8126  16fd cd0000        	call	c_eewrw
8128  1700 85            	popw	x
8130  1701 204a          	jra	L5543
8131  1703               L3543:
8132                     ; 2191 		else if((mess[9]&0x0f)==0x02)
8134  1703 b6d3          	ld	a,_mess+9
8135  1705 a40f          	and	a,#15
8136  1707 a102          	cp	a,#2
8137  1709 260b          	jrne	L7543
8138                     ; 2193 			ee_K[2][1]++;
8140  170b ce0024        	ldw	x,_ee_K+10
8141  170e 1c0001        	addw	x,#1
8142  1711 cf0024        	ldw	_ee_K+10,x
8144  1714 2037          	jra	L5543
8145  1716               L7543:
8146                     ; 2195 		else if((mess[9]&0x0f)==0x03)
8148  1716 b6d3          	ld	a,_mess+9
8149  1718 a40f          	and	a,#15
8150  171a a103          	cp	a,#3
8151  171c 260b          	jrne	L3643
8152                     ; 2197 			ee_K[2][1]+=10;
8154  171e ce0024        	ldw	x,_ee_K+10
8155  1721 1c000a        	addw	x,#10
8156  1724 cf0024        	ldw	_ee_K+10,x
8158  1727 2024          	jra	L5543
8159  1729               L3643:
8160                     ; 2199 		else if((mess[9]&0x0f)==0x04)
8162  1729 b6d3          	ld	a,_mess+9
8163  172b a40f          	and	a,#15
8164  172d a104          	cp	a,#4
8165  172f 260b          	jrne	L7643
8166                     ; 2201 			ee_K[2][1]--;
8168  1731 ce0024        	ldw	x,_ee_K+10
8169  1734 1d0001        	subw	x,#1
8170  1737 cf0024        	ldw	_ee_K+10,x
8172  173a 2011          	jra	L5543
8173  173c               L7643:
8174                     ; 2203 		else if((mess[9]&0x0f)==0x05)
8176  173c b6d3          	ld	a,_mess+9
8177  173e a40f          	and	a,#15
8178  1740 a105          	cp	a,#5
8179  1742 2609          	jrne	L5543
8180                     ; 2205 			ee_K[2][1]-=10;
8182  1744 ce0024        	ldw	x,_ee_K+10
8183  1747 1d000a        	subw	x,#10
8184  174a cf0024        	ldw	_ee_K+10,x
8185  174d               L5543:
8186                     ; 2210 		granee(&ee_K[2][1],10,30000);
8188  174d ae7530        	ldw	x,#30000
8189  1750 89            	pushw	x
8190  1751 ae000a        	ldw	x,#10
8191  1754 89            	pushw	x
8192  1755 ae0024        	ldw	x,#_ee_K+10
8193  1758 cd00f6        	call	_granee
8195  175b 5b04          	addw	sp,#4
8197  175d ac271827      	jpf	L1243
8198  1761               L1543:
8199                     ; 2214 	else if((mess[9]&0xf0)==0x30)
8201  1761 b6d3          	ld	a,_mess+9
8202  1763 a4f0          	and	a,#240
8203  1765 a130          	cp	a,#48
8204  1767 265c          	jrne	L7743
8205                     ; 2216 		if((mess[9]&0x0f)==0x02)
8207  1769 b6d3          	ld	a,_mess+9
8208  176b a40f          	and	a,#15
8209  176d a102          	cp	a,#2
8210  176f 260b          	jrne	L1053
8211                     ; 2218 			ee_K[3][1]++;
8213  1771 ce0028        	ldw	x,_ee_K+14
8214  1774 1c0001        	addw	x,#1
8215  1777 cf0028        	ldw	_ee_K+14,x
8217  177a 2037          	jra	L3053
8218  177c               L1053:
8219                     ; 2220 		else if((mess[9]&0x0f)==0x03)
8221  177c b6d3          	ld	a,_mess+9
8222  177e a40f          	and	a,#15
8223  1780 a103          	cp	a,#3
8224  1782 260b          	jrne	L5053
8225                     ; 2222 			ee_K[3][1]+=10;
8227  1784 ce0028        	ldw	x,_ee_K+14
8228  1787 1c000a        	addw	x,#10
8229  178a cf0028        	ldw	_ee_K+14,x
8231  178d 2024          	jra	L3053
8232  178f               L5053:
8233                     ; 2224 		else if((mess[9]&0x0f)==0x04)
8235  178f b6d3          	ld	a,_mess+9
8236  1791 a40f          	and	a,#15
8237  1793 a104          	cp	a,#4
8238  1795 260b          	jrne	L1153
8239                     ; 2226 			ee_K[3][1]--;
8241  1797 ce0028        	ldw	x,_ee_K+14
8242  179a 1d0001        	subw	x,#1
8243  179d cf0028        	ldw	_ee_K+14,x
8245  17a0 2011          	jra	L3053
8246  17a2               L1153:
8247                     ; 2228 		else if((mess[9]&0x0f)==0x05)
8249  17a2 b6d3          	ld	a,_mess+9
8250  17a4 a40f          	and	a,#15
8251  17a6 a105          	cp	a,#5
8252  17a8 2609          	jrne	L3053
8253                     ; 2230 			ee_K[3][1]-=10;
8255  17aa ce0028        	ldw	x,_ee_K+14
8256  17ad 1d000a        	subw	x,#10
8257  17b0 cf0028        	ldw	_ee_K+14,x
8258  17b3               L3053:
8259                     ; 2232 		granee(&ee_K[3][1],300,517);									
8261  17b3 ae0205        	ldw	x,#517
8262  17b6 89            	pushw	x
8263  17b7 ae012c        	ldw	x,#300
8264  17ba 89            	pushw	x
8265  17bb ae0028        	ldw	x,#_ee_K+14
8266  17be cd00f6        	call	_granee
8268  17c1 5b04          	addw	sp,#4
8270  17c3 2062          	jra	L1243
8271  17c5               L7743:
8272                     ; 2235 	else if((mess[9]&0xf0)==0x50)
8274  17c5 b6d3          	ld	a,_mess+9
8275  17c7 a4f0          	and	a,#240
8276  17c9 a150          	cp	a,#80
8277  17cb 265a          	jrne	L1243
8278                     ; 2237 		if((mess[9]&0x0f)==0x02)
8280  17cd b6d3          	ld	a,_mess+9
8281  17cf a40f          	and	a,#15
8282  17d1 a102          	cp	a,#2
8283  17d3 260b          	jrne	L3253
8284                     ; 2239 			ee_K[4][1]++;
8286  17d5 ce002c        	ldw	x,_ee_K+18
8287  17d8 1c0001        	addw	x,#1
8288  17db cf002c        	ldw	_ee_K+18,x
8290  17de 2037          	jra	L5253
8291  17e0               L3253:
8292                     ; 2241 		else if((mess[9]&0x0f)==0x03)
8294  17e0 b6d3          	ld	a,_mess+9
8295  17e2 a40f          	and	a,#15
8296  17e4 a103          	cp	a,#3
8297  17e6 260b          	jrne	L7253
8298                     ; 2243 			ee_K[4][1]+=10;
8300  17e8 ce002c        	ldw	x,_ee_K+18
8301  17eb 1c000a        	addw	x,#10
8302  17ee cf002c        	ldw	_ee_K+18,x
8304  17f1 2024          	jra	L5253
8305  17f3               L7253:
8306                     ; 2245 		else if((mess[9]&0x0f)==0x04)
8308  17f3 b6d3          	ld	a,_mess+9
8309  17f5 a40f          	and	a,#15
8310  17f7 a104          	cp	a,#4
8311  17f9 260b          	jrne	L3353
8312                     ; 2247 			ee_K[4][1]--;
8314  17fb ce002c        	ldw	x,_ee_K+18
8315  17fe 1d0001        	subw	x,#1
8316  1801 cf002c        	ldw	_ee_K+18,x
8318  1804 2011          	jra	L5253
8319  1806               L3353:
8320                     ; 2249 		else if((mess[9]&0x0f)==0x05)
8322  1806 b6d3          	ld	a,_mess+9
8323  1808 a40f          	and	a,#15
8324  180a a105          	cp	a,#5
8325  180c 2609          	jrne	L5253
8326                     ; 2251 			ee_K[4][1]-=10;
8328  180e ce002c        	ldw	x,_ee_K+18
8329  1811 1d000a        	subw	x,#10
8330  1814 cf002c        	ldw	_ee_K+18,x
8331  1817               L5253:
8332                     ; 2253 		granee(&ee_K[4][1],10,30000);									
8334  1817 ae7530        	ldw	x,#30000
8335  181a 89            	pushw	x
8336  181b ae000a        	ldw	x,#10
8337  181e 89            	pushw	x
8338  181f ae002c        	ldw	x,#_ee_K+18
8339  1822 cd00f6        	call	_granee
8341  1825 5b04          	addw	sp,#4
8342  1827               L1243:
8343                     ; 2256 	link_cnt=0;
8345  1827 5f            	clrw	x
8346  1828 bf6e          	ldw	_link_cnt,x
8347                     ; 2257      link=ON;
8349  182a 35550070      	mov	_link,#85
8350                     ; 2258      if(res_fl_)
8352  182e 725d000a      	tnz	_res_fl_
8353  1832 2603          	jrne	L412
8354  1834 cc1b26        	jp	L1723
8355  1837               L412:
8356                     ; 2260       	res_fl_=0;
8358  1837 4f            	clr	a
8359  1838 ae000a        	ldw	x,#_res_fl_
8360  183b cd0000        	call	c_eewrc
8362  183e ac261b26      	jpf	L1723
8363  1842               L3733:
8364                     ; 2266 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8366  1842 b6d0          	ld	a,_mess+6
8367  1844 a1ff          	cp	a,#255
8368  1846 2703          	jreq	L612
8369  1848 cc18d0        	jp	L5453
8370  184b               L612:
8372  184b b6d1          	ld	a,_mess+7
8373  184d a1ff          	cp	a,#255
8374  184f 2702          	jreq	L022
8375  1851 207d          	jp	L5453
8376  1853               L022:
8378  1853 b6d2          	ld	a,_mess+8
8379  1855 a162          	cp	a,#98
8380  1857 2677          	jrne	L5453
8381                     ; 2269 	tempSS=mess[9]+(mess[10]*256);
8383  1859 b6d4          	ld	a,_mess+10
8384  185b 5f            	clrw	x
8385  185c 97            	ld	xl,a
8386  185d 4f            	clr	a
8387  185e 02            	rlwa	x,a
8388  185f 01            	rrwa	x,a
8389  1860 bbd3          	add	a,_mess+9
8390  1862 2401          	jrnc	L661
8391  1864 5c            	incw	x
8392  1865               L661:
8393  1865 02            	rlwa	x,a
8394  1866 1f03          	ldw	(OFST-4,sp),x
8395  1868 01            	rrwa	x,a
8396                     ; 2270 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8398  1869 ce0014        	ldw	x,_ee_Umax
8399  186c 1303          	cpw	x,(OFST-4,sp)
8400  186e 270a          	jreq	L7453
8403  1870 1e03          	ldw	x,(OFST-4,sp)
8404  1872 89            	pushw	x
8405  1873 ae0014        	ldw	x,#_ee_Umax
8406  1876 cd0000        	call	c_eewrw
8408  1879 85            	popw	x
8409  187a               L7453:
8410                     ; 2271 	tempSS=mess[11]+(mess[12]*256);
8412  187a b6d6          	ld	a,_mess+12
8413  187c 5f            	clrw	x
8414  187d 97            	ld	xl,a
8415  187e 4f            	clr	a
8416  187f 02            	rlwa	x,a
8417  1880 01            	rrwa	x,a
8418  1881 bbd5          	add	a,_mess+11
8419  1883 2401          	jrnc	L071
8420  1885 5c            	incw	x
8421  1886               L071:
8422  1886 02            	rlwa	x,a
8423  1887 1f03          	ldw	(OFST-4,sp),x
8424  1889 01            	rrwa	x,a
8425                     ; 2272 	if(ee_dU!=tempSS) ee_dU=tempSS;
8427  188a ce0012        	ldw	x,_ee_dU
8428  188d 1303          	cpw	x,(OFST-4,sp)
8429  188f 270a          	jreq	L1553
8432  1891 1e03          	ldw	x,(OFST-4,sp)
8433  1893 89            	pushw	x
8434  1894 ae0012        	ldw	x,#_ee_dU
8435  1897 cd0000        	call	c_eewrw
8437  189a 85            	popw	x
8438  189b               L1553:
8439                     ; 2273 	if((mess[13]&0x0f)==0x5)
8441  189b b6d7          	ld	a,_mess+13
8442  189d a40f          	and	a,#15
8443  189f a105          	cp	a,#5
8444  18a1 2615          	jrne	L3553
8445                     ; 2275 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8447  18a3 ce0006        	ldw	x,_ee_AVT_MODE
8448  18a6 a30055        	cpw	x,#85
8449  18a9 271e          	jreq	L7553
8452  18ab ae0055        	ldw	x,#85
8453  18ae 89            	pushw	x
8454  18af ae0006        	ldw	x,#_ee_AVT_MODE
8455  18b2 cd0000        	call	c_eewrw
8457  18b5 85            	popw	x
8458  18b6 2011          	jra	L7553
8459  18b8               L3553:
8460                     ; 2277 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;
8462  18b8 ce0006        	ldw	x,_ee_AVT_MODE
8463  18bb a30055        	cpw	x,#85
8464  18be 2609          	jrne	L7553
8467  18c0 5f            	clrw	x
8468  18c1 89            	pushw	x
8469  18c2 ae0006        	ldw	x,#_ee_AVT_MODE
8470  18c5 cd0000        	call	c_eewrw
8472  18c8 85            	popw	x
8473  18c9               L7553:
8474                     ; 2278 	FADE_MODE=mess[13];	
8476  18c9 45d713        	mov	_FADE_MODE,_mess+13
8478  18cc ac261b26      	jpf	L1723
8479  18d0               L5453:
8480                     ; 2281 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8482  18d0 b6d0          	ld	a,_mess+6
8483  18d2 a1ff          	cp	a,#255
8484  18d4 2703          	jreq	L222
8485  18d6 cc198c        	jp	L5653
8486  18d9               L222:
8488  18d9 b6d1          	ld	a,_mess+7
8489  18db a1ff          	cp	a,#255
8490  18dd 2703          	jreq	L422
8491  18df cc198c        	jp	L5653
8492  18e2               L422:
8494  18e2 b6d2          	ld	a,_mess+8
8495  18e4 a126          	cp	a,#38
8496  18e6 2709          	jreq	L7653
8498  18e8 b6d2          	ld	a,_mess+8
8499  18ea a129          	cp	a,#41
8500  18ec 2703          	jreq	L622
8501  18ee cc198c        	jp	L5653
8502  18f1               L622:
8503  18f1               L7653:
8504                     ; 2284 	tempSS=mess[9]+(mess[10]*256);
8506  18f1 b6d4          	ld	a,_mess+10
8507  18f3 5f            	clrw	x
8508  18f4 97            	ld	xl,a
8509  18f5 4f            	clr	a
8510  18f6 02            	rlwa	x,a
8511  18f7 01            	rrwa	x,a
8512  18f8 bbd3          	add	a,_mess+9
8513  18fa 2401          	jrnc	L271
8514  18fc 5c            	incw	x
8515  18fd               L271:
8516  18fd 02            	rlwa	x,a
8517  18fe 1f03          	ldw	(OFST-4,sp),x
8518  1900 01            	rrwa	x,a
8519                     ; 2286 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
8521  1901 ce000c        	ldw	x,_ee_UAVT
8522  1904 1303          	cpw	x,(OFST-4,sp)
8523  1906 270a          	jreq	L1753
8526  1908 1e03          	ldw	x,(OFST-4,sp)
8527  190a 89            	pushw	x
8528  190b ae000c        	ldw	x,#_ee_UAVT
8529  190e cd0000        	call	c_eewrw
8531  1911 85            	popw	x
8532  1912               L1753:
8533                     ; 2287 	tempSS=(signed short)mess[11];
8535  1912 b6d5          	ld	a,_mess+11
8536  1914 5f            	clrw	x
8537  1915 97            	ld	xl,a
8538  1916 1f03          	ldw	(OFST-4,sp),x
8539                     ; 2288 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8541  1918 ce0010        	ldw	x,_ee_tmax
8542  191b 1303          	cpw	x,(OFST-4,sp)
8543  191d 270a          	jreq	L3753
8546  191f 1e03          	ldw	x,(OFST-4,sp)
8547  1921 89            	pushw	x
8548  1922 ae0010        	ldw	x,#_ee_tmax
8549  1925 cd0000        	call	c_eewrw
8551  1928 85            	popw	x
8552  1929               L3753:
8553                     ; 2289 	tempSS=(signed short)mess[12];
8555  1929 b6d6          	ld	a,_mess+12
8556  192b 5f            	clrw	x
8557  192c 97            	ld	xl,a
8558  192d 1f03          	ldw	(OFST-4,sp),x
8559                     ; 2290 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8561  192f ce000e        	ldw	x,_ee_tsign
8562  1932 1303          	cpw	x,(OFST-4,sp)
8563  1934 270a          	jreq	L5753
8566  1936 1e03          	ldw	x,(OFST-4,sp)
8567  1938 89            	pushw	x
8568  1939 ae000e        	ldw	x,#_ee_tsign
8569  193c cd0000        	call	c_eewrw
8571  193f 85            	popw	x
8572  1940               L5753:
8573                     ; 2293 	if(mess[8]==MEM_KF1)
8575  1940 b6d2          	ld	a,_mess+8
8576  1942 a126          	cp	a,#38
8577  1944 260e          	jrne	L7753
8578                     ; 2295 		if(ee_DEVICE!=0)ee_DEVICE=0;
8580  1946 ce0004        	ldw	x,_ee_DEVICE
8581  1949 2709          	jreq	L7753
8584  194b 5f            	clrw	x
8585  194c 89            	pushw	x
8586  194d ae0004        	ldw	x,#_ee_DEVICE
8587  1950 cd0000        	call	c_eewrw
8589  1953 85            	popw	x
8590  1954               L7753:
8591                     ; 2298 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8593  1954 b6d2          	ld	a,_mess+8
8594  1956 a129          	cp	a,#41
8595  1958 2703          	jreq	L032
8596  195a cc1b26        	jp	L1723
8597  195d               L032:
8598                     ; 2300 		if(ee_DEVICE!=1)ee_DEVICE=1;
8600  195d ce0004        	ldw	x,_ee_DEVICE
8601  1960 a30001        	cpw	x,#1
8602  1963 270b          	jreq	L5063
8605  1965 ae0001        	ldw	x,#1
8606  1968 89            	pushw	x
8607  1969 ae0004        	ldw	x,#_ee_DEVICE
8608  196c cd0000        	call	c_eewrw
8610  196f 85            	popw	x
8611  1970               L5063:
8612                     ; 2301 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8614  1970 b6d7          	ld	a,_mess+13
8615  1972 5f            	clrw	x
8616  1973 97            	ld	xl,a
8617  1974 c30002        	cpw	x,_ee_IMAXVENT
8618  1977 2603          	jrne	L232
8619  1979 cc1b26        	jp	L1723
8620  197c               L232:
8623  197c b6d7          	ld	a,_mess+13
8624  197e 5f            	clrw	x
8625  197f 97            	ld	xl,a
8626  1980 89            	pushw	x
8627  1981 ae0002        	ldw	x,#_ee_IMAXVENT
8628  1984 cd0000        	call	c_eewrw
8630  1987 85            	popw	x
8631  1988 ac261b26      	jpf	L1723
8632  198c               L5653:
8633                     ; 2306 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8635  198c b6d0          	ld	a,_mess+6
8636  198e c10101        	cp	a,_adress
8637  1991 262d          	jrne	L3163
8639  1993 b6d1          	ld	a,_mess+7
8640  1995 c10101        	cp	a,_adress
8641  1998 2626          	jrne	L3163
8643  199a b6d2          	ld	a,_mess+8
8644  199c a116          	cp	a,#22
8645  199e 2620          	jrne	L3163
8647  19a0 b6d3          	ld	a,_mess+9
8648  19a2 a163          	cp	a,#99
8649  19a4 261a          	jrne	L3163
8650                     ; 2308 	flags&=0b11100001;
8652  19a6 b605          	ld	a,_flags
8653  19a8 a4e1          	and	a,#225
8654  19aa b705          	ld	_flags,a
8655                     ; 2309 	tsign_cnt=0;
8657  19ac 5f            	clrw	x
8658  19ad bf5c          	ldw	_tsign_cnt,x
8659                     ; 2310 	tmax_cnt=0;
8661  19af 5f            	clrw	x
8662  19b0 bf5a          	ldw	_tmax_cnt,x
8663                     ; 2311 	umax_cnt=0;
8665  19b2 5f            	clrw	x
8666  19b3 bf73          	ldw	_umax_cnt,x
8667                     ; 2312 	umin_cnt=0;
8669  19b5 5f            	clrw	x
8670  19b6 bf71          	ldw	_umin_cnt,x
8671                     ; 2313 	led_drv_cnt=30;
8673  19b8 351e0016      	mov	_led_drv_cnt,#30
8675  19bc ac261b26      	jpf	L1723
8676  19c0               L3163:
8677                     ; 2316 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8679  19c0 b6d0          	ld	a,_mess+6
8680  19c2 c10101        	cp	a,_adress
8681  19c5 2620          	jrne	L7163
8683  19c7 b6d1          	ld	a,_mess+7
8684  19c9 c10101        	cp	a,_adress
8685  19cc 2619          	jrne	L7163
8687  19ce b6d2          	ld	a,_mess+8
8688  19d0 a116          	cp	a,#22
8689  19d2 2613          	jrne	L7163
8691  19d4 b6d3          	ld	a,_mess+9
8692  19d6 a164          	cp	a,#100
8693  19d8 260d          	jrne	L7163
8694                     ; 2318 	vent_resurs=0;
8696  19da 5f            	clrw	x
8697  19db 89            	pushw	x
8698  19dc ae0000        	ldw	x,#_vent_resurs
8699  19df cd0000        	call	c_eewrw
8701  19e2 85            	popw	x
8703  19e3 ac261b26      	jpf	L1723
8704  19e7               L7163:
8705                     ; 2322 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8707  19e7 b6d0          	ld	a,_mess+6
8708  19e9 a1ff          	cp	a,#255
8709  19eb 265f          	jrne	L3263
8711  19ed b6d1          	ld	a,_mess+7
8712  19ef a1ff          	cp	a,#255
8713  19f1 2659          	jrne	L3263
8715  19f3 b6d2          	ld	a,_mess+8
8716  19f5 a116          	cp	a,#22
8717  19f7 2653          	jrne	L3263
8719  19f9 b6d3          	ld	a,_mess+9
8720  19fb a116          	cp	a,#22
8721  19fd 264d          	jrne	L3263
8722                     ; 2324 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8724  19ff b6d4          	ld	a,_mess+10
8725  1a01 a155          	cp	a,#85
8726  1a03 260f          	jrne	L5263
8728  1a05 b6d5          	ld	a,_mess+11
8729  1a07 a155          	cp	a,#85
8730  1a09 2609          	jrne	L5263
8733  1a0b be6b          	ldw	x,__x_
8734  1a0d 1c0001        	addw	x,#1
8735  1a10 bf6b          	ldw	__x_,x
8737  1a12 2024          	jra	L7263
8738  1a14               L5263:
8739                     ; 2325 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8741  1a14 b6d4          	ld	a,_mess+10
8742  1a16 a166          	cp	a,#102
8743  1a18 260f          	jrne	L1363
8745  1a1a b6d5          	ld	a,_mess+11
8746  1a1c a166          	cp	a,#102
8747  1a1e 2609          	jrne	L1363
8750  1a20 be6b          	ldw	x,__x_
8751  1a22 1d0001        	subw	x,#1
8752  1a25 bf6b          	ldw	__x_,x
8754  1a27 200f          	jra	L7263
8755  1a29               L1363:
8756                     ; 2326 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8758  1a29 b6d4          	ld	a,_mess+10
8759  1a2b a177          	cp	a,#119
8760  1a2d 2609          	jrne	L7263
8762  1a2f b6d5          	ld	a,_mess+11
8763  1a31 a177          	cp	a,#119
8764  1a33 2603          	jrne	L7263
8767  1a35 5f            	clrw	x
8768  1a36 bf6b          	ldw	__x_,x
8769  1a38               L7263:
8770                     ; 2327      gran(&_x_,-XMAX,XMAX);
8772  1a38 ae0019        	ldw	x,#25
8773  1a3b 89            	pushw	x
8774  1a3c aeffe7        	ldw	x,#65511
8775  1a3f 89            	pushw	x
8776  1a40 ae006b        	ldw	x,#__x_
8777  1a43 cd00d5        	call	_gran
8779  1a46 5b04          	addw	sp,#4
8781  1a48 ac261b26      	jpf	L1723
8782  1a4c               L3263:
8783                     ; 2329 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8785  1a4c b6d0          	ld	a,_mess+6
8786  1a4e c10101        	cp	a,_adress
8787  1a51 2635          	jrne	L1463
8789  1a53 b6d1          	ld	a,_mess+7
8790  1a55 c10101        	cp	a,_adress
8791  1a58 262e          	jrne	L1463
8793  1a5a b6d2          	ld	a,_mess+8
8794  1a5c a116          	cp	a,#22
8795  1a5e 2628          	jrne	L1463
8797  1a60 b6d3          	ld	a,_mess+9
8798  1a62 b1d4          	cp	a,_mess+10
8799  1a64 2622          	jrne	L1463
8801  1a66 b6d3          	ld	a,_mess+9
8802  1a68 a1ee          	cp	a,#238
8803  1a6a 261c          	jrne	L1463
8804                     ; 2331 	rotor_int++;
8806  1a6c be17          	ldw	x,_rotor_int
8807  1a6e 1c0001        	addw	x,#1
8808  1a71 bf17          	ldw	_rotor_int,x
8809                     ; 2332      tempI=pwm_u;
8811                     ; 2334 	UU_AVT=Un;
8813  1a73 ce0018        	ldw	x,_Un
8814  1a76 89            	pushw	x
8815  1a77 ae0008        	ldw	x,#_UU_AVT
8816  1a7a cd0000        	call	c_eewrw
8818  1a7d 85            	popw	x
8819                     ; 2335 	delay_ms(100);
8821  1a7e ae0064        	ldw	x,#100
8822  1a81 cd0121        	call	_delay_ms
8825  1a84 ac261b26      	jpf	L1723
8826  1a88               L1463:
8827                     ; 2341 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8829  1a88 b6d1          	ld	a,_mess+7
8830  1a8a a1da          	cp	a,#218
8831  1a8c 2653          	jrne	L5463
8833  1a8e b6d0          	ld	a,_mess+6
8834  1a90 c10101        	cp	a,_adress
8835  1a93 274c          	jreq	L5463
8837  1a95 b6d0          	ld	a,_mess+6
8838  1a97 a106          	cp	a,#6
8839  1a99 2446          	jruge	L5463
8840                     ; 2343 	i_main_bps_cnt[mess[6]]=0;
8842  1a9b b6d0          	ld	a,_mess+6
8843  1a9d 5f            	clrw	x
8844  1a9e 97            	ld	xl,a
8845  1a9f 6f14          	clr	(_i_main_bps_cnt,x)
8846                     ; 2344 	i_main_flag[mess[6]]=1;
8848  1aa1 b6d0          	ld	a,_mess+6
8849  1aa3 5f            	clrw	x
8850  1aa4 97            	ld	xl,a
8851  1aa5 a601          	ld	a,#1
8852  1aa7 e71f          	ld	(_i_main_flag,x),a
8853                     ; 2345 	if(bMAIN)
8855                     	btst	_bMAIN
8856  1aae 2476          	jruge	L1723
8857                     ; 2347 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8859  1ab0 b6d3          	ld	a,_mess+9
8860  1ab2 5f            	clrw	x
8861  1ab3 97            	ld	xl,a
8862  1ab4 4f            	clr	a
8863  1ab5 02            	rlwa	x,a
8864  1ab6 1f01          	ldw	(OFST-6,sp),x
8865  1ab8 b6d2          	ld	a,_mess+8
8866  1aba 5f            	clrw	x
8867  1abb 97            	ld	xl,a
8868  1abc 72fb01        	addw	x,(OFST-6,sp)
8869  1abf b6d0          	ld	a,_mess+6
8870  1ac1 905f          	clrw	y
8871  1ac3 9097          	ld	yl,a
8872  1ac5 9058          	sllw	y
8873  1ac7 90ef25        	ldw	(_i_main,y),x
8874                     ; 2348 		i_main[adress]=I;
8876  1aca c60101        	ld	a,_adress
8877  1acd 5f            	clrw	x
8878  1ace 97            	ld	xl,a
8879  1acf 58            	sllw	x
8880  1ad0 90ce001a      	ldw	y,_I
8881  1ad4 ef25          	ldw	(_i_main,x),y
8882                     ; 2349      	i_main_flag[adress]=1;
8884  1ad6 c60101        	ld	a,_adress
8885  1ad9 5f            	clrw	x
8886  1ada 97            	ld	xl,a
8887  1adb a601          	ld	a,#1
8888  1add e71f          	ld	(_i_main_flag,x),a
8889  1adf 2045          	jra	L1723
8890  1ae1               L5463:
8891                     ; 2353 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8893  1ae1 b6d1          	ld	a,_mess+7
8894  1ae3 a1db          	cp	a,#219
8895  1ae5 263f          	jrne	L1723
8897  1ae7 b6d0          	ld	a,_mess+6
8898  1ae9 c10101        	cp	a,_adress
8899  1aec 2738          	jreq	L1723
8901  1aee b6d0          	ld	a,_mess+6
8902  1af0 a106          	cp	a,#6
8903  1af2 2432          	jruge	L1723
8904                     ; 2355 	i_main_bps_cnt[mess[6]]=0;
8906  1af4 b6d0          	ld	a,_mess+6
8907  1af6 5f            	clrw	x
8908  1af7 97            	ld	xl,a
8909  1af8 6f14          	clr	(_i_main_bps_cnt,x)
8910                     ; 2356 	i_main_flag[mess[6]]=1;		
8912  1afa b6d0          	ld	a,_mess+6
8913  1afc 5f            	clrw	x
8914  1afd 97            	ld	xl,a
8915  1afe a601          	ld	a,#1
8916  1b00 e71f          	ld	(_i_main_flag,x),a
8917                     ; 2357 	if(bMAIN)
8919                     	btst	_bMAIN
8920  1b07 241d          	jruge	L1723
8921                     ; 2359 		if(mess[9]==0)i_main_flag[i]=1;
8923  1b09 3dd3          	tnz	_mess+9
8924  1b0b 260a          	jrne	L7563
8927  1b0d 7b07          	ld	a,(OFST+0,sp)
8928  1b0f 5f            	clrw	x
8929  1b10 97            	ld	xl,a
8930  1b11 a601          	ld	a,#1
8931  1b13 e71f          	ld	(_i_main_flag,x),a
8933  1b15 2006          	jra	L1663
8934  1b17               L7563:
8935                     ; 2360 		else i_main_flag[i]=0;
8937  1b17 7b07          	ld	a,(OFST+0,sp)
8938  1b19 5f            	clrw	x
8939  1b1a 97            	ld	xl,a
8940  1b1b 6f1f          	clr	(_i_main_flag,x)
8941  1b1d               L1663:
8942                     ; 2361 		i_main_flag[adress]=1;
8944  1b1d c60101        	ld	a,_adress
8945  1b20 5f            	clrw	x
8946  1b21 97            	ld	xl,a
8947  1b22 a601          	ld	a,#1
8948  1b24 e71f          	ld	(_i_main_flag,x),a
8949  1b26               L1723:
8950                     ; 2367 can_in_an_end:
8950                     ; 2368 bCAN_RX=0;
8952  1b26 3f04          	clr	_bCAN_RX
8953                     ; 2369 }   
8956  1b28 5b07          	addw	sp,#7
8957  1b2a 81            	ret
8980                     ; 2372 void t4_init(void){
8981                     	switch	.text
8982  1b2b               _t4_init:
8986                     ; 2373 	TIM4->PSCR = 6;
8988  1b2b 35065345      	mov	21317,#6
8989                     ; 2374 	TIM4->ARR= 31;
8991  1b2f 351f5346      	mov	21318,#31
8992                     ; 2375 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8994  1b33 72105341      	bset	21313,#0
8995                     ; 2377 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8997  1b37 35855340      	mov	21312,#133
8998                     ; 2379 }
9001  1b3b 81            	ret
9024                     ; 2382 void t1_init(void)
9024                     ; 2383 {
9025                     	switch	.text
9026  1b3c               _t1_init:
9030                     ; 2384 TIM1->ARRH= 0x07;
9032  1b3c 35075262      	mov	21090,#7
9033                     ; 2385 TIM1->ARRL= 0xff;
9035  1b40 35ff5263      	mov	21091,#255
9036                     ; 2386 TIM1->CCR1H= 0x00;	
9038  1b44 725f5265      	clr	21093
9039                     ; 2387 TIM1->CCR1L= 0xff;
9041  1b48 35ff5266      	mov	21094,#255
9042                     ; 2388 TIM1->CCR2H= 0x00;	
9044  1b4c 725f5267      	clr	21095
9045                     ; 2389 TIM1->CCR2L= 0x00;
9047  1b50 725f5268      	clr	21096
9048                     ; 2390 TIM1->CCR3H= 0x00;	
9050  1b54 725f5269      	clr	21097
9051                     ; 2391 TIM1->CCR3L= 0x64;
9053  1b58 3564526a      	mov	21098,#100
9054                     ; 2393 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9056  1b5c 35685258      	mov	21080,#104
9057                     ; 2394 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9059  1b60 35685259      	mov	21081,#104
9060                     ; 2395 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9062  1b64 3568525a      	mov	21082,#104
9063                     ; 2396 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9065  1b68 3511525c      	mov	21084,#17
9066                     ; 2397 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9068  1b6c 3501525d      	mov	21085,#1
9069                     ; 2398 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9071  1b70 35815250      	mov	21072,#129
9072                     ; 2399 TIM1->BKR|= TIM1_BKR_AOE;
9074  1b74 721c526d      	bset	21101,#6
9075                     ; 2400 }
9078  1b78 81            	ret
9103                     ; 2404 void adc2_init(void)
9103                     ; 2405 {
9104                     	switch	.text
9105  1b79               _adc2_init:
9109                     ; 2406 adc_plazma[0]++;
9111  1b79 bebc          	ldw	x,_adc_plazma
9112  1b7b 1c0001        	addw	x,#1
9113  1b7e bfbc          	ldw	_adc_plazma,x
9114                     ; 2430 GPIOB->DDR&=~(1<<4);
9116  1b80 72195007      	bres	20487,#4
9117                     ; 2431 GPIOB->CR1&=~(1<<4);
9119  1b84 72195008      	bres	20488,#4
9120                     ; 2432 GPIOB->CR2&=~(1<<4);
9122  1b88 72195009      	bres	20489,#4
9123                     ; 2434 GPIOB->DDR&=~(1<<5);
9125  1b8c 721b5007      	bres	20487,#5
9126                     ; 2435 GPIOB->CR1&=~(1<<5);
9128  1b90 721b5008      	bres	20488,#5
9129                     ; 2436 GPIOB->CR2&=~(1<<5);
9131  1b94 721b5009      	bres	20489,#5
9132                     ; 2438 GPIOB->DDR&=~(1<<6);
9134  1b98 721d5007      	bres	20487,#6
9135                     ; 2439 GPIOB->CR1&=~(1<<6);
9137  1b9c 721d5008      	bres	20488,#6
9138                     ; 2440 GPIOB->CR2&=~(1<<6);
9140  1ba0 721d5009      	bres	20489,#6
9141                     ; 2442 GPIOB->DDR&=~(1<<7);
9143  1ba4 721f5007      	bres	20487,#7
9144                     ; 2443 GPIOB->CR1&=~(1<<7);
9146  1ba8 721f5008      	bres	20488,#7
9147                     ; 2444 GPIOB->CR2&=~(1<<7);
9149  1bac 721f5009      	bres	20489,#7
9150                     ; 2446 GPIOB->DDR&=~(1<<2);
9152  1bb0 72155007      	bres	20487,#2
9153                     ; 2447 GPIOB->CR1&=~(1<<2);
9155  1bb4 72155008      	bres	20488,#2
9156                     ; 2448 GPIOB->CR2&=~(1<<2);
9158  1bb8 72155009      	bres	20489,#2
9159                     ; 2457 ADC2->TDRL=0xff;
9161  1bbc 35ff5407      	mov	21511,#255
9162                     ; 2459 ADC2->CR2=0x08;
9164  1bc0 35085402      	mov	21506,#8
9165                     ; 2460 ADC2->CR1=0x60;
9167  1bc4 35605401      	mov	21505,#96
9168                     ; 2463 	if(adc_ch==5)ADC2->CSR=0x22;
9170  1bc8 b6c9          	ld	a,_adc_ch
9171  1bca a105          	cp	a,#5
9172  1bcc 2606          	jrne	L3173
9175  1bce 35225400      	mov	21504,#34
9177  1bd2 2007          	jra	L5173
9178  1bd4               L3173:
9179                     ; 2464 	else ADC2->CSR=0x20+adc_ch+3;
9181  1bd4 b6c9          	ld	a,_adc_ch
9182  1bd6 ab23          	add	a,#35
9183  1bd8 c75400        	ld	21504,a
9184  1bdb               L5173:
9185                     ; 2466 	ADC2->CR1|=1;
9187  1bdb 72105401      	bset	21505,#0
9188                     ; 2467 	ADC2->CR1|=1;
9190  1bdf 72105401      	bset	21505,#0
9191                     ; 2470 adc_plazma[1]=adc_ch;
9193  1be3 b6c9          	ld	a,_adc_ch
9194  1be5 5f            	clrw	x
9195  1be6 97            	ld	xl,a
9196  1be7 bfbe          	ldw	_adc_plazma+2,x
9197                     ; 2471 }
9200  1be9 81            	ret
9238                     ; 2479 @far @interrupt void TIM4_UPD_Interrupt (void) 
9238                     ; 2480 {
9240                     	switch	.text
9241  1bea               f_TIM4_UPD_Interrupt:
9245                     ; 2481 TIM4->SR1&=~TIM4_SR1_UIF;
9247  1bea 72115342      	bres	21314,#0
9248                     ; 2483 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9250  1bee 3c12          	inc	_pwm_vent_cnt
9251  1bf0 b612          	ld	a,_pwm_vent_cnt
9252  1bf2 a10a          	cp	a,#10
9253  1bf4 2502          	jrult	L7273
9256  1bf6 3f12          	clr	_pwm_vent_cnt
9257  1bf8               L7273:
9258                     ; 2484 GPIOB->ODR|=(1<<3);
9260  1bf8 72165005      	bset	20485,#3
9261                     ; 2485 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9263  1bfc b612          	ld	a,_pwm_vent_cnt
9264  1bfe a105          	cp	a,#5
9265  1c00 2504          	jrult	L1373
9268  1c02 72175005      	bres	20485,#3
9269  1c06               L1373:
9270                     ; 2489 if(++t0_cnt00>=20)
9272  1c06 9c            	rvf
9273  1c07 ce0000        	ldw	x,_t0_cnt00
9274  1c0a 1c0001        	addw	x,#1
9275  1c0d cf0000        	ldw	_t0_cnt00,x
9276  1c10 a30014        	cpw	x,#20
9277  1c13 2f08          	jrslt	L3373
9278                     ; 2491 	t0_cnt00=0;
9280  1c15 5f            	clrw	x
9281  1c16 cf0000        	ldw	_t0_cnt00,x
9282                     ; 2492 	b1000Hz=1;
9284  1c19 72100005      	bset	_b1000Hz
9285  1c1d               L3373:
9286                     ; 2495 if(++t0_cnt0>=200)
9288  1c1d 9c            	rvf
9289  1c1e ce0002        	ldw	x,_t0_cnt0
9290  1c21 1c0001        	addw	x,#1
9291  1c24 cf0002        	ldw	_t0_cnt0,x
9292  1c27 a300c8        	cpw	x,#200
9293  1c2a 2f67          	jrslt	L5373
9294                     ; 2497 	t0_cnt0=0;
9296  1c2c 5f            	clrw	x
9297  1c2d cf0002        	ldw	_t0_cnt0,x
9298                     ; 2498 	b100Hz=1;
9300  1c30 7210000a      	bset	_b100Hz
9301                     ; 2500 	if(++t0_cnt5>=5)
9303  1c34 725c0008      	inc	_t0_cnt5
9304  1c38 c60008        	ld	a,_t0_cnt5
9305  1c3b a105          	cp	a,#5
9306  1c3d 2508          	jrult	L7373
9307                     ; 2502 		t0_cnt5=0;
9309  1c3f 725f0008      	clr	_t0_cnt5
9310                     ; 2503 		b20Hz=1;
9312  1c43 72100004      	bset	_b20Hz
9313  1c47               L7373:
9314                     ; 2506 	if(++t0_cnt1>=10)
9316  1c47 725c0004      	inc	_t0_cnt1
9317  1c4b c60004        	ld	a,_t0_cnt1
9318  1c4e a10a          	cp	a,#10
9319  1c50 2508          	jrult	L1473
9320                     ; 2508 		t0_cnt1=0;
9322  1c52 725f0004      	clr	_t0_cnt1
9323                     ; 2509 		b10Hz=1;
9325  1c56 72100009      	bset	_b10Hz
9326  1c5a               L1473:
9327                     ; 2512 	if(++t0_cnt2>=20)
9329  1c5a 725c0005      	inc	_t0_cnt2
9330  1c5e c60005        	ld	a,_t0_cnt2
9331  1c61 a114          	cp	a,#20
9332  1c63 2508          	jrult	L3473
9333                     ; 2514 		t0_cnt2=0;
9335  1c65 725f0005      	clr	_t0_cnt2
9336                     ; 2515 		b5Hz=1;
9338  1c69 72100008      	bset	_b5Hz
9339  1c6d               L3473:
9340                     ; 2519 	if(++t0_cnt4>=50)
9342  1c6d 725c0007      	inc	_t0_cnt4
9343  1c71 c60007        	ld	a,_t0_cnt4
9344  1c74 a132          	cp	a,#50
9345  1c76 2508          	jrult	L5473
9346                     ; 2521 		t0_cnt4=0;
9348  1c78 725f0007      	clr	_t0_cnt4
9349                     ; 2522 		b2Hz=1;
9351  1c7c 72100007      	bset	_b2Hz
9352  1c80               L5473:
9353                     ; 2525 	if(++t0_cnt3>=100)
9355  1c80 725c0006      	inc	_t0_cnt3
9356  1c84 c60006        	ld	a,_t0_cnt3
9357  1c87 a164          	cp	a,#100
9358  1c89 2508          	jrult	L5373
9359                     ; 2527 		t0_cnt3=0;
9361  1c8b 725f0006      	clr	_t0_cnt3
9362                     ; 2528 		b1Hz=1;
9364  1c8f 72100006      	bset	_b1Hz
9365  1c93               L5373:
9366                     ; 2534 }
9369  1c93 80            	iret
9394                     ; 2537 @far @interrupt void CAN_RX_Interrupt (void) 
9394                     ; 2538 {
9395                     	switch	.text
9396  1c94               f_CAN_RX_Interrupt:
9400                     ; 2540 CAN->PSR= 7;									// page 7 - read messsage
9402  1c94 35075427      	mov	21543,#7
9403                     ; 2542 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9405  1c98 ae000e        	ldw	x,#14
9406  1c9b               L642:
9407  1c9b d65427        	ld	a,(21543,x)
9408  1c9e e7c9          	ld	(_mess-1,x),a
9409  1ca0 5a            	decw	x
9410  1ca1 26f8          	jrne	L642
9411                     ; 2553 bCAN_RX=1;
9413  1ca3 35010004      	mov	_bCAN_RX,#1
9414                     ; 2554 CAN->RFR|=(1<<5);
9416  1ca7 721a5424      	bset	21540,#5
9417                     ; 2556 }
9420  1cab 80            	iret
9443                     ; 2559 @far @interrupt void CAN_TX_Interrupt (void) 
9443                     ; 2560 {
9444                     	switch	.text
9445  1cac               f_CAN_TX_Interrupt:
9449                     ; 2561 if((CAN->TSR)&(1<<0))
9451  1cac c65422        	ld	a,21538
9452  1caf a501          	bcp	a,#1
9453  1cb1 2708          	jreq	L1773
9454                     ; 2563 	bTX_FREE=1;	
9456  1cb3 35010003      	mov	_bTX_FREE,#1
9457                     ; 2565 	CAN->TSR|=(1<<0);
9459  1cb7 72105422      	bset	21538,#0
9460  1cbb               L1773:
9461                     ; 2567 }
9464  1cbb 80            	iret
9544                     ; 2570 @far @interrupt void ADC2_EOC_Interrupt (void) {
9545                     	switch	.text
9546  1cbc               f_ADC2_EOC_Interrupt:
9548       0000000d      OFST:	set	13
9549  1cbc be00          	ldw	x,c_x
9550  1cbe 89            	pushw	x
9551  1cbf be00          	ldw	x,c_y
9552  1cc1 89            	pushw	x
9553  1cc2 be02          	ldw	x,c_lreg+2
9554  1cc4 89            	pushw	x
9555  1cc5 be00          	ldw	x,c_lreg
9556  1cc7 89            	pushw	x
9557  1cc8 520d          	subw	sp,#13
9560                     ; 2575 adc_plazma[2]++;
9562  1cca bec0          	ldw	x,_adc_plazma+4
9563  1ccc 1c0001        	addw	x,#1
9564  1ccf bfc0          	ldw	_adc_plazma+4,x
9565                     ; 2582 ADC2->CSR&=~(1<<7);
9567  1cd1 721f5400      	bres	21504,#7
9568                     ; 2584 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9570  1cd5 c65405        	ld	a,21509
9571  1cd8 b703          	ld	c_lreg+3,a
9572  1cda 3f02          	clr	c_lreg+2
9573  1cdc 3f01          	clr	c_lreg+1
9574  1cde 3f00          	clr	c_lreg
9575  1ce0 96            	ldw	x,sp
9576  1ce1 1c0001        	addw	x,#OFST-12
9577  1ce4 cd0000        	call	c_rtol
9579  1ce7 c65404        	ld	a,21508
9580  1cea 5f            	clrw	x
9581  1ceb 97            	ld	xl,a
9582  1cec 90ae0100      	ldw	y,#256
9583  1cf0 cd0000        	call	c_umul
9585  1cf3 96            	ldw	x,sp
9586  1cf4 1c0001        	addw	x,#OFST-12
9587  1cf7 cd0000        	call	c_ladd
9589  1cfa 96            	ldw	x,sp
9590  1cfb 1c000a        	addw	x,#OFST-3
9591  1cfe cd0000        	call	c_rtol
9593                     ; 2589 if(adr_drv_stat==1)
9595  1d01 b602          	ld	a,_adr_drv_stat
9596  1d03 a101          	cp	a,#1
9597  1d05 260b          	jrne	L1304
9598                     ; 2591 	adr_drv_stat=2;
9600  1d07 35020002      	mov	_adr_drv_stat,#2
9601                     ; 2592 	adc_buff_[0]=temp_adc;
9603  1d0b 1e0c          	ldw	x,(OFST-1,sp)
9604  1d0d cf0109        	ldw	_adc_buff_,x
9606  1d10 2020          	jra	L3304
9607  1d12               L1304:
9608                     ; 2595 else if(adr_drv_stat==3)
9610  1d12 b602          	ld	a,_adr_drv_stat
9611  1d14 a103          	cp	a,#3
9612  1d16 260b          	jrne	L5304
9613                     ; 2597 	adr_drv_stat=4;
9615  1d18 35040002      	mov	_adr_drv_stat,#4
9616                     ; 2598 	adc_buff_[1]=temp_adc;
9618  1d1c 1e0c          	ldw	x,(OFST-1,sp)
9619  1d1e cf010b        	ldw	_adc_buff_+2,x
9621  1d21 200f          	jra	L3304
9622  1d23               L5304:
9623                     ; 2601 else if(adr_drv_stat==5)
9625  1d23 b602          	ld	a,_adr_drv_stat
9626  1d25 a105          	cp	a,#5
9627  1d27 2609          	jrne	L3304
9628                     ; 2603 	adr_drv_stat=6;
9630  1d29 35060002      	mov	_adr_drv_stat,#6
9631                     ; 2604 	adc_buff_[9]=temp_adc;
9633  1d2d 1e0c          	ldw	x,(OFST-1,sp)
9634  1d2f cf011b        	ldw	_adc_buff_+18,x
9635  1d32               L3304:
9636                     ; 2607 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
9638  1d32 b6ba          	ld	a,_adc_cnt_cnt
9639  1d34 5f            	clrw	x
9640  1d35 97            	ld	xl,a
9641  1d36 58            	sllw	x
9642  1d37 1f03          	ldw	(OFST-10,sp),x
9643  1d39 b6c9          	ld	a,_adc_ch
9644  1d3b 97            	ld	xl,a
9645  1d3c a610          	ld	a,#16
9646  1d3e 42            	mul	x,a
9647  1d3f 72fb03        	addw	x,(OFST-10,sp)
9648  1d42 160c          	ldw	y,(OFST-1,sp)
9649  1d44 df0060        	ldw	(_adc_buff_buff,x),y
9650                     ; 2609 adc_ch++;
9652  1d47 3cc9          	inc	_adc_ch
9653                     ; 2610 if(adc_ch>=6)
9655  1d49 b6c9          	ld	a,_adc_ch
9656  1d4b a106          	cp	a,#6
9657  1d4d 2516          	jrult	L3404
9658                     ; 2612 	adc_ch=0;
9660  1d4f 3fc9          	clr	_adc_ch
9661                     ; 2613 	adc_cnt_cnt++;
9663  1d51 3cba          	inc	_adc_cnt_cnt
9664                     ; 2614 	if(adc_cnt_cnt>=8)
9666  1d53 b6ba          	ld	a,_adc_cnt_cnt
9667  1d55 a108          	cp	a,#8
9668  1d57 250c          	jrult	L3404
9669                     ; 2616 		adc_cnt_cnt=0;
9671  1d59 3fba          	clr	_adc_cnt_cnt
9672                     ; 2617 		adc_cnt++;
9674  1d5b 3cc8          	inc	_adc_cnt
9675                     ; 2618 		if(adc_cnt>=16)
9677  1d5d b6c8          	ld	a,_adc_cnt
9678  1d5f a110          	cp	a,#16
9679  1d61 2502          	jrult	L3404
9680                     ; 2620 			adc_cnt=0;
9682  1d63 3fc8          	clr	_adc_cnt
9683  1d65               L3404:
9684                     ; 2624 if(adc_cnt_cnt==0)
9686  1d65 3dba          	tnz	_adc_cnt_cnt
9687  1d67 2660          	jrne	L1504
9688                     ; 2628 	tempSS=0;
9690  1d69 ae0000        	ldw	x,#0
9691  1d6c 1f07          	ldw	(OFST-6,sp),x
9692  1d6e ae0000        	ldw	x,#0
9693  1d71 1f05          	ldw	(OFST-8,sp),x
9694                     ; 2629 	for(i=0;i<8;i++)
9696  1d73 0f09          	clr	(OFST-4,sp)
9697  1d75               L3504:
9698                     ; 2631 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9700  1d75 7b09          	ld	a,(OFST-4,sp)
9701  1d77 5f            	clrw	x
9702  1d78 97            	ld	xl,a
9703  1d79 58            	sllw	x
9704  1d7a 1f03          	ldw	(OFST-10,sp),x
9705  1d7c b6c9          	ld	a,_adc_ch
9706  1d7e 97            	ld	xl,a
9707  1d7f a610          	ld	a,#16
9708  1d81 42            	mul	x,a
9709  1d82 72fb03        	addw	x,(OFST-10,sp)
9710  1d85 de0060        	ldw	x,(_adc_buff_buff,x)
9711  1d88 cd0000        	call	c_itolx
9713  1d8b 96            	ldw	x,sp
9714  1d8c 1c0005        	addw	x,#OFST-8
9715  1d8f cd0000        	call	c_lgadd
9717                     ; 2629 	for(i=0;i<8;i++)
9719  1d92 0c09          	inc	(OFST-4,sp)
9722  1d94 7b09          	ld	a,(OFST-4,sp)
9723  1d96 a108          	cp	a,#8
9724  1d98 25db          	jrult	L3504
9725                     ; 2633 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9727  1d9a 96            	ldw	x,sp
9728  1d9b 1c0005        	addw	x,#OFST-8
9729  1d9e cd0000        	call	c_ltor
9731  1da1 a603          	ld	a,#3
9732  1da3 cd0000        	call	c_lrsh
9734  1da6 be02          	ldw	x,c_lreg+2
9735  1da8 b6c8          	ld	a,_adc_cnt
9736  1daa 905f          	clrw	y
9737  1dac 9097          	ld	yl,a
9738  1dae 9058          	sllw	y
9739  1db0 1703          	ldw	(OFST-10,sp),y
9740  1db2 b6c9          	ld	a,_adc_ch
9741  1db4 905f          	clrw	y
9742  1db6 9097          	ld	yl,a
9743  1db8 9058          	sllw	y
9744  1dba 9058          	sllw	y
9745  1dbc 9058          	sllw	y
9746  1dbe 9058          	sllw	y
9747  1dc0 9058          	sllw	y
9748  1dc2 72f903        	addw	y,(OFST-10,sp)
9749  1dc5 90df011d      	ldw	(_adc_buff,y),x
9750  1dc9               L1504:
9751                     ; 2637 if((adc_cnt&0x03)==0)
9753  1dc9 b6c8          	ld	a,_adc_cnt
9754  1dcb a503          	bcp	a,#3
9755  1dcd 264b          	jrne	L1604
9756                     ; 2641 	tempSS=0;
9758  1dcf ae0000        	ldw	x,#0
9759  1dd2 1f07          	ldw	(OFST-6,sp),x
9760  1dd4 ae0000        	ldw	x,#0
9761  1dd7 1f05          	ldw	(OFST-8,sp),x
9762                     ; 2642 	for(i=0;i<16;i++)
9764  1dd9 0f09          	clr	(OFST-4,sp)
9765  1ddb               L3604:
9766                     ; 2644 		tempSS+=(signed long)adc_buff[adc_ch][i];
9768  1ddb 7b09          	ld	a,(OFST-4,sp)
9769  1ddd 5f            	clrw	x
9770  1dde 97            	ld	xl,a
9771  1ddf 58            	sllw	x
9772  1de0 1f03          	ldw	(OFST-10,sp),x
9773  1de2 b6c9          	ld	a,_adc_ch
9774  1de4 97            	ld	xl,a
9775  1de5 a620          	ld	a,#32
9776  1de7 42            	mul	x,a
9777  1de8 72fb03        	addw	x,(OFST-10,sp)
9778  1deb de011d        	ldw	x,(_adc_buff,x)
9779  1dee cd0000        	call	c_itolx
9781  1df1 96            	ldw	x,sp
9782  1df2 1c0005        	addw	x,#OFST-8
9783  1df5 cd0000        	call	c_lgadd
9785                     ; 2642 	for(i=0;i<16;i++)
9787  1df8 0c09          	inc	(OFST-4,sp)
9790  1dfa 7b09          	ld	a,(OFST-4,sp)
9791  1dfc a110          	cp	a,#16
9792  1dfe 25db          	jrult	L3604
9793                     ; 2646 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9795  1e00 96            	ldw	x,sp
9796  1e01 1c0005        	addw	x,#OFST-8
9797  1e04 cd0000        	call	c_ltor
9799  1e07 a604          	ld	a,#4
9800  1e09 cd0000        	call	c_lrsh
9802  1e0c be02          	ldw	x,c_lreg+2
9803  1e0e b6c9          	ld	a,_adc_ch
9804  1e10 905f          	clrw	y
9805  1e12 9097          	ld	yl,a
9806  1e14 9058          	sllw	y
9807  1e16 90df0109      	ldw	(_adc_buff_,y),x
9808  1e1a               L1604:
9809                     ; 2653 if(adc_ch==0)adc_buff_5=temp_adc;
9811  1e1a 3dc9          	tnz	_adc_ch
9812  1e1c 2605          	jrne	L1704
9815  1e1e 1e0c          	ldw	x,(OFST-1,sp)
9816  1e20 cf0107        	ldw	_adc_buff_5,x
9817  1e23               L1704:
9818                     ; 2654 if(adc_ch==2)adc_buff_1=temp_adc;
9820  1e23 b6c9          	ld	a,_adc_ch
9821  1e25 a102          	cp	a,#2
9822  1e27 2605          	jrne	L3704
9825  1e29 1e0c          	ldw	x,(OFST-1,sp)
9826  1e2b cf0105        	ldw	_adc_buff_1,x
9827  1e2e               L3704:
9828                     ; 2656 adc_plazma_short++;
9830  1e2e bec6          	ldw	x,_adc_plazma_short
9831  1e30 1c0001        	addw	x,#1
9832  1e33 bfc6          	ldw	_adc_plazma_short,x
9833                     ; 2658 }
9836  1e35 5b0d          	addw	sp,#13
9837  1e37 85            	popw	x
9838  1e38 bf00          	ldw	c_lreg,x
9839  1e3a 85            	popw	x
9840  1e3b bf02          	ldw	c_lreg+2,x
9841  1e3d 85            	popw	x
9842  1e3e bf00          	ldw	c_y,x
9843  1e40 85            	popw	x
9844  1e41 bf00          	ldw	c_x,x
9845  1e43 80            	iret
9906                     ; 2667 main()
9906                     ; 2668 {
9908                     	switch	.text
9909  1e44               _main:
9913                     ; 2670 CLK->ECKR|=1;
9915  1e44 721050c1      	bset	20673,#0
9917  1e48               L7014:
9918                     ; 2671 while((CLK->ECKR & 2) == 0);
9920  1e48 c650c1        	ld	a,20673
9921  1e4b a502          	bcp	a,#2
9922  1e4d 27f9          	jreq	L7014
9923                     ; 2672 CLK->SWCR|=2;
9925  1e4f 721250c5      	bset	20677,#1
9926                     ; 2673 CLK->SWR=0xB4;
9928  1e53 35b450c4      	mov	20676,#180
9929                     ; 2675 delay_ms(200);
9931  1e57 ae00c8        	ldw	x,#200
9932  1e5a cd0121        	call	_delay_ms
9934                     ; 2676 FLASH_DUKR=0xae;
9936  1e5d 35ae5064      	mov	_FLASH_DUKR,#174
9937                     ; 2677 FLASH_DUKR=0x56;
9939  1e61 35565064      	mov	_FLASH_DUKR,#86
9940                     ; 2678 enableInterrupts();
9943  1e65 9a            rim
9945                     ; 2681 adr_drv_v3();
9948  1e66 cd10cd        	call	_adr_drv_v3
9950                     ; 2685 t4_init();
9952  1e69 cd1b2b        	call	_t4_init
9954                     ; 2687 		GPIOG->DDR|=(1<<0);
9956  1e6c 72105020      	bset	20512,#0
9957                     ; 2688 		GPIOG->CR1|=(1<<0);
9959  1e70 72105021      	bset	20513,#0
9960                     ; 2689 		GPIOG->CR2&=~(1<<0);	
9962  1e74 72115022      	bres	20514,#0
9963                     ; 2692 		GPIOG->DDR&=~(1<<1);
9965  1e78 72135020      	bres	20512,#1
9966                     ; 2693 		GPIOG->CR1|=(1<<1);
9968  1e7c 72125021      	bset	20513,#1
9969                     ; 2694 		GPIOG->CR2&=~(1<<1);
9971  1e80 72135022      	bres	20514,#1
9972                     ; 2696 init_CAN();
9974  1e84 cd12bd        	call	_init_CAN
9976                     ; 2701 GPIOC->DDR|=(1<<1);
9978  1e87 7212500c      	bset	20492,#1
9979                     ; 2702 GPIOC->CR1|=(1<<1);
9981  1e8b 7212500d      	bset	20493,#1
9982                     ; 2703 GPIOC->CR2|=(1<<1);
9984  1e8f 7212500e      	bset	20494,#1
9985                     ; 2705 GPIOC->DDR|=(1<<2);
9987  1e93 7214500c      	bset	20492,#2
9988                     ; 2706 GPIOC->CR1|=(1<<2);
9990  1e97 7214500d      	bset	20493,#2
9991                     ; 2707 GPIOC->CR2|=(1<<2);
9993  1e9b 7214500e      	bset	20494,#2
9994                     ; 2714 t1_init();
9996  1e9f cd1b3c        	call	_t1_init
9998                     ; 2716 GPIOA->DDR|=(1<<5);
10000  1ea2 721a5002      	bset	20482,#5
10001                     ; 2717 GPIOA->CR1|=(1<<5);
10003  1ea6 721a5003      	bset	20483,#5
10004                     ; 2718 GPIOA->CR2&=~(1<<5);
10006  1eaa 721b5004      	bres	20484,#5
10007                     ; 2724 GPIOB->DDR&=~(1<<3);
10009  1eae 72175007      	bres	20487,#3
10010                     ; 2725 GPIOB->CR1&=~(1<<3);
10012  1eb2 72175008      	bres	20488,#3
10013                     ; 2726 GPIOB->CR2&=~(1<<3);
10015  1eb6 72175009      	bres	20489,#3
10016                     ; 2728 GPIOC->DDR|=(1<<3);
10018  1eba 7216500c      	bset	20492,#3
10019                     ; 2729 GPIOC->CR1|=(1<<3);
10021  1ebe 7216500d      	bset	20493,#3
10022                     ; 2730 GPIOC->CR2|=(1<<3);
10024  1ec2 7216500e      	bset	20494,#3
10025                     ; 2732 U_out_const=ee_UAVT;
10027  1ec6 ce000c        	ldw	x,_ee_UAVT
10028  1ec9 cf0012        	ldw	_U_out_const,x
10029  1ecc               L3114:
10030                     ; 2736 	if(b1000Hz)
10032                     	btst	_b1000Hz
10033  1ed1 240a          	jruge	L7114
10034                     ; 2738 		b1000Hz=0;
10036  1ed3 72110005      	bres	_b1000Hz
10037                     ; 2740 		adc2_init();
10039  1ed7 cd1b79        	call	_adc2_init
10041                     ; 2742 		pwr_hndl_new();
10043  1eda cd086f        	call	_pwr_hndl_new
10045  1edd               L7114:
10046                     ; 2744 	if(bCAN_RX)
10048  1edd 3d04          	tnz	_bCAN_RX
10049  1edf 2705          	jreq	L1214
10050                     ; 2746 		bCAN_RX=0;
10052  1ee1 3f04          	clr	_bCAN_RX
10053                     ; 2747 		can_in_an();	
10055  1ee3 cd141a        	call	_can_in_an
10057  1ee6               L1214:
10058                     ; 2749 	if(b100Hz)
10060                     	btst	_b100Hz
10061  1eeb 2407          	jruge	L3214
10062                     ; 2751 		b100Hz=0;
10064  1eed 7211000a      	bres	_b100Hz
10065                     ; 2761 		can_tx_hndl();
10067  1ef1 cd13b0        	call	_can_tx_hndl
10069  1ef4               L3214:
10070                     ; 2765 	if(b20Hz)
10072                     	btst	_b20Hz
10073  1ef9 2407          	jruge	L5214
10074                     ; 2767 		b20Hz=0;
10076  1efb 72110004      	bres	_b20Hz
10077                     ; 2768 		led_drv();
10079  1eff cd03ee        	call	_led_drv
10081  1f02               L5214:
10082                     ; 2773 	if(b10Hz)
10084                     	btst	_b10Hz
10085  1f07 2422          	jruge	L7214
10086                     ; 2775 		b10Hz=0;
10088  1f09 72110009      	bres	_b10Hz
10089                     ; 2777 		matemat();
10091  1f0d cd0bd9        	call	_matemat
10093                     ; 2779 	  link_drv();
10095  1f10 cd04dc        	call	_link_drv
10097                     ; 2781 	  JP_drv();
10099  1f13 cd0451        	call	_JP_drv
10101                     ; 2782 	  flags_drv();
10103  1f16 cd1082        	call	_flags_drv
10105                     ; 2784 		if(main_cnt10<100)main_cnt10++;
10107  1f19 9c            	rvf
10108  1f1a ce025d        	ldw	x,_main_cnt10
10109  1f1d a30064        	cpw	x,#100
10110  1f20 2e09          	jrsge	L7214
10113  1f22 ce025d        	ldw	x,_main_cnt10
10114  1f25 1c0001        	addw	x,#1
10115  1f28 cf025d        	ldw	_main_cnt10,x
10116  1f2b               L7214:
10117                     ; 2787 	if(b5Hz)
10119                     	btst	_b5Hz
10120  1f30 241c          	jruge	L3314
10121                     ; 2789 		b5Hz=0;
10123  1f32 72110008      	bres	_b5Hz
10124                     ; 2795 		pwr_drv();		//воздействие на силу
10126  1f36 cd06ac        	call	_pwr_drv
10128                     ; 2796 		led_hndl();
10130  1f39 cd0163        	call	_led_hndl
10132                     ; 2798 		vent_drv();
10134  1f3c cd0534        	call	_vent_drv
10136                     ; 2800 		if(main_cnt1<1000)main_cnt1++;
10138  1f3f 9c            	rvf
10139  1f40 be5e          	ldw	x,_main_cnt1
10140  1f42 a303e8        	cpw	x,#1000
10141  1f45 2e07          	jrsge	L3314
10144  1f47 be5e          	ldw	x,_main_cnt1
10145  1f49 1c0001        	addw	x,#1
10146  1f4c bf5e          	ldw	_main_cnt1,x
10147  1f4e               L3314:
10148                     ; 2803 	if(b2Hz)
10150                     	btst	_b2Hz
10151  1f53 240d          	jruge	L7314
10152                     ; 2805 		b2Hz=0;
10154  1f55 72110007      	bres	_b2Hz
10155                     ; 2809 		temper_drv();
10157  1f59 cd0dfb        	call	_temper_drv
10159                     ; 2810 		u_drv();
10161  1f5c cd0ed2        	call	_u_drv
10163                     ; 2811 		vent_resurs_hndl();
10165  1f5f cd0000        	call	_vent_resurs_hndl
10167  1f62               L7314:
10168                     ; 2814 	if(b1Hz)
10170                     	btst	_b1Hz
10171  1f67 2503cc1ecc    	jruge	L3114
10172                     ; 2816 		b1Hz=0;
10174  1f6c 72110006      	bres	_b1Hz
10175                     ; 2822 		if(main_cnt<1000)main_cnt++;
10177  1f70 9c            	rvf
10178  1f71 ce025f        	ldw	x,_main_cnt
10179  1f74 a303e8        	cpw	x,#1000
10180  1f77 2e09          	jrsge	L3414
10183  1f79 ce025f        	ldw	x,_main_cnt
10184  1f7c 1c0001        	addw	x,#1
10185  1f7f cf025f        	ldw	_main_cnt,x
10186  1f82               L3414:
10187                     ; 2823   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10189  1f82 b670          	ld	a,_link
10190  1f84 a1aa          	cp	a,#170
10191  1f86 2706          	jreq	L7414
10193  1f88 b655          	ld	a,_jp_mode
10194  1f8a a103          	cp	a,#3
10195  1f8c 2603          	jrne	L5414
10196  1f8e               L7414:
10199  1f8e cd0fe3        	call	_apv_hndl
10201  1f91               L5414:
10202                     ; 2826   		can_error_cnt++;
10204  1f91 3c76          	inc	_can_error_cnt
10205                     ; 2827   		if(can_error_cnt>=10)
10207  1f93 b676          	ld	a,_can_error_cnt
10208  1f95 a10a          	cp	a,#10
10209  1f97 2403          	jruge	L652
10210  1f99 cc1ecc        	jp	L3114
10211  1f9c               L652:
10212                     ; 2829   			can_error_cnt=0;
10214  1f9c 3f76          	clr	_can_error_cnt
10215                     ; 2830 				init_CAN();
10217  1f9e cd12bd        	call	_init_CAN
10219  1fa1 accc1ecc      	jpf	L3114
11539                     	xdef	_main
11540                     	xdef	f_ADC2_EOC_Interrupt
11541                     	xdef	f_CAN_TX_Interrupt
11542                     	xdef	f_CAN_RX_Interrupt
11543                     	xdef	f_TIM4_UPD_Interrupt
11544                     	xdef	_adc2_init
11545                     	xdef	_t1_init
11546                     	xdef	_t4_init
11547                     	xdef	_can_in_an
11548                     	xdef	_can_tx_hndl
11549                     	xdef	_can_transmit
11550                     	xdef	_init_CAN
11551                     	xdef	_adr_drv_v3
11552                     	xdef	_adr_drv_v4
11553                     	xdef	_flags_drv
11554                     	xdef	_apv_hndl
11555                     	xdef	_apv_stop
11556                     	xdef	_apv_start
11557                     	xdef	_u_drv
11558                     	xdef	_temper_drv
11559                     	xdef	_matemat
11560                     	xdef	_pwr_hndl_new
11561                     	xdef	_pwr_hndl
11562                     	xdef	_pwr_drv
11563                     	xdef	_vent_drv
11564                     	xdef	_link_drv
11565                     	xdef	_JP_drv
11566                     	xdef	_led_drv
11567                     	xdef	_led_hndl
11568                     	xdef	_delay_ms
11569                     	xdef	_granee
11570                     	xdef	_gran
11571                     	xdef	_vent_resurs_hndl
11572                     	switch	.ubsct
11573  0001               _debug_info_to_uku:
11574  0001 000000000000  	ds.b	6
11575                     	xdef	_debug_info_to_uku
11576  0007               _pwm_u_cnt:
11577  0007 00            	ds.b	1
11578                     	xdef	_pwm_u_cnt
11579  0008               _vent_resurs_tx_cnt:
11580  0008 00            	ds.b	1
11581                     	xdef	_vent_resurs_tx_cnt
11582                     	switch	.bss
11583  0000               _vent_resurs_buff:
11584  0000 00000000      	ds.b	4
11585                     	xdef	_vent_resurs_buff
11586                     	switch	.ubsct
11587  0009               _vent_resurs_sec_cnt:
11588  0009 0000          	ds.b	2
11589                     	xdef	_vent_resurs_sec_cnt
11590                     .eeprom:	section	.data
11591  0000               _vent_resurs:
11592  0000 0000          	ds.b	2
11593                     	xdef	_vent_resurs
11594  0002               _ee_IMAXVENT:
11595  0002 0000          	ds.b	2
11596                     	xdef	_ee_IMAXVENT
11597                     	switch	.ubsct
11598  000b               _bps_class:
11599  000b 00            	ds.b	1
11600                     	xdef	_bps_class
11601  000c               _vent_pwm_integr_cnt:
11602  000c 0000          	ds.b	2
11603                     	xdef	_vent_pwm_integr_cnt
11604  000e               _vent_pwm_integr:
11605  000e 0000          	ds.b	2
11606                     	xdef	_vent_pwm_integr
11607  0010               _vent_pwm:
11608  0010 0000          	ds.b	2
11609                     	xdef	_vent_pwm
11610  0012               _pwm_vent_cnt:
11611  0012 00            	ds.b	1
11612                     	xdef	_pwm_vent_cnt
11613                     	switch	.eeprom
11614  0004               _ee_DEVICE:
11615  0004 0000          	ds.b	2
11616                     	xdef	_ee_DEVICE
11617  0006               _ee_AVT_MODE:
11618  0006 0000          	ds.b	2
11619                     	xdef	_ee_AVT_MODE
11620                     	switch	.ubsct
11621  0013               _FADE_MODE:
11622  0013 00            	ds.b	1
11623                     	xdef	_FADE_MODE
11624  0014               _i_main_bps_cnt:
11625  0014 000000000000  	ds.b	6
11626                     	xdef	_i_main_bps_cnt
11627  001a               _i_main_sigma:
11628  001a 0000          	ds.b	2
11629                     	xdef	_i_main_sigma
11630  001c               _i_main_num_of_bps:
11631  001c 00            	ds.b	1
11632                     	xdef	_i_main_num_of_bps
11633  001d               _i_main_avg:
11634  001d 0000          	ds.b	2
11635                     	xdef	_i_main_avg
11636  001f               _i_main_flag:
11637  001f 000000000000  	ds.b	6
11638                     	xdef	_i_main_flag
11639  0025               _i_main:
11640  0025 000000000000  	ds.b	12
11641                     	xdef	_i_main
11642  0031               _x:
11643  0031 000000000000  	ds.b	12
11644                     	xdef	_x
11645                     	xdef	_volum_u_main_
11646                     	switch	.eeprom
11647  0008               _UU_AVT:
11648  0008 0000          	ds.b	2
11649                     	xdef	_UU_AVT
11650                     	switch	.ubsct
11651  003d               _cnt_net_drv:
11652  003d 00            	ds.b	1
11653                     	xdef	_cnt_net_drv
11654                     	switch	.bit
11655  0001               _bMAIN:
11656  0001 00            	ds.b	1
11657                     	xdef	_bMAIN
11658                     	switch	.ubsct
11659  003e               _plazma_int:
11660  003e 000000000000  	ds.b	6
11661                     	xdef	_plazma_int
11662                     	xdef	_rotor_int
11663  0044               _led_green_buff:
11664  0044 00000000      	ds.b	4
11665                     	xdef	_led_green_buff
11666  0048               _led_red_buff:
11667  0048 00000000      	ds.b	4
11668                     	xdef	_led_red_buff
11669                     	xdef	_led_drv_cnt
11670                     	xdef	_led_green
11671                     	xdef	_led_red
11672  004c               _res_fl_cnt:
11673  004c 00            	ds.b	1
11674                     	xdef	_res_fl_cnt
11675                     	xdef	_bRES_
11676                     	xdef	_bRES
11677                     	switch	.eeprom
11678  000a               _res_fl_:
11679  000a 00            	ds.b	1
11680                     	xdef	_res_fl_
11681  000b               _res_fl:
11682  000b 00            	ds.b	1
11683                     	xdef	_res_fl
11684                     	switch	.ubsct
11685  004d               _cnt_apv_off:
11686  004d 00            	ds.b	1
11687                     	xdef	_cnt_apv_off
11688                     	switch	.bit
11689  0002               _bAPV:
11690  0002 00            	ds.b	1
11691                     	xdef	_bAPV
11692                     	switch	.ubsct
11693  004e               _apv_cnt_:
11694  004e 0000          	ds.b	2
11695                     	xdef	_apv_cnt_
11696  0050               _apv_cnt:
11697  0050 000000        	ds.b	3
11698                     	xdef	_apv_cnt
11699                     	xdef	_bBL_IPS
11700                     	switch	.bit
11701  0003               _bBL:
11702  0003 00            	ds.b	1
11703                     	xdef	_bBL
11704                     	switch	.ubsct
11705  0053               _cnt_JP1:
11706  0053 00            	ds.b	1
11707                     	xdef	_cnt_JP1
11708  0054               _cnt_JP0:
11709  0054 00            	ds.b	1
11710                     	xdef	_cnt_JP0
11711  0055               _jp_mode:
11712  0055 00            	ds.b	1
11713                     	xdef	_jp_mode
11714  0056               _pwm_delt:
11715  0056 0000          	ds.b	2
11716                     	xdef	_pwm_delt
11717  0058               _pwm_u_:
11718  0058 0000          	ds.b	2
11719                     	xdef	_pwm_u_
11720                     	xdef	_pwm_i
11721                     	xdef	_pwm_u
11722  005a               _tmax_cnt:
11723  005a 0000          	ds.b	2
11724                     	xdef	_tmax_cnt
11725  005c               _tsign_cnt:
11726  005c 0000          	ds.b	2
11727                     	xdef	_tsign_cnt
11728                     	switch	.eeprom
11729  000c               _ee_UAVT:
11730  000c 0000          	ds.b	2
11731                     	xdef	_ee_UAVT
11732  000e               _ee_tsign:
11733  000e 0000          	ds.b	2
11734                     	xdef	_ee_tsign
11735  0010               _ee_tmax:
11736  0010 0000          	ds.b	2
11737                     	xdef	_ee_tmax
11738  0012               _ee_dU:
11739  0012 0000          	ds.b	2
11740                     	xdef	_ee_dU
11741  0014               _ee_Umax:
11742  0014 0000          	ds.b	2
11743                     	xdef	_ee_Umax
11744  0016               _ee_TZAS:
11745  0016 0000          	ds.b	2
11746                     	xdef	_ee_TZAS
11747                     	switch	.ubsct
11748  005e               _main_cnt1:
11749  005e 0000          	ds.b	2
11750                     	xdef	_main_cnt1
11751  0060               _off_bp_cnt:
11752  0060 00            	ds.b	1
11753                     	xdef	_off_bp_cnt
11754                     	xdef	_vol_i_temp_avar
11755  0061               _flags_tu_cnt_off:
11756  0061 00            	ds.b	1
11757                     	xdef	_flags_tu_cnt_off
11758  0062               _flags_tu_cnt_on:
11759  0062 00            	ds.b	1
11760                     	xdef	_flags_tu_cnt_on
11761  0063               _vol_i_temp:
11762  0063 0000          	ds.b	2
11763                     	xdef	_vol_i_temp
11764  0065               _vol_u_temp:
11765  0065 0000          	ds.b	2
11766                     	xdef	_vol_u_temp
11767                     	switch	.eeprom
11768  0018               __x_ee_:
11769  0018 0000          	ds.b	2
11770                     	xdef	__x_ee_
11771                     	switch	.ubsct
11772  0067               __x_cnt:
11773  0067 0000          	ds.b	2
11774                     	xdef	__x_cnt
11775  0069               __x__:
11776  0069 0000          	ds.b	2
11777                     	xdef	__x__
11778  006b               __x_:
11779  006b 0000          	ds.b	2
11780                     	xdef	__x_
11781  006d               _flags_tu:
11782  006d 00            	ds.b	1
11783                     	xdef	_flags_tu
11784                     	xdef	_flags
11785  006e               _link_cnt:
11786  006e 0000          	ds.b	2
11787                     	xdef	_link_cnt
11788  0070               _link:
11789  0070 00            	ds.b	1
11790                     	xdef	_link
11791  0071               _umin_cnt:
11792  0071 0000          	ds.b	2
11793                     	xdef	_umin_cnt
11794  0073               _umax_cnt:
11795  0073 0000          	ds.b	2
11796                     	xdef	_umax_cnt
11797                     	switch	.bss
11798  0004               _pwm_schot_cnt:
11799  0004 0000          	ds.b	2
11800                     	xdef	_pwm_schot_cnt
11801  0006               _pwm_peace_cnt_:
11802  0006 0000          	ds.b	2
11803                     	xdef	_pwm_peace_cnt_
11804  0008               _pwm_peace_cnt:
11805  0008 0000          	ds.b	2
11806                     	xdef	_pwm_peace_cnt
11807                     	switch	.eeprom
11808  001a               _ee_K:
11809  001a 000000000000  	ds.b	20
11810                     	xdef	_ee_K
11811                     	switch	.ubsct
11812  0075               _T:
11813  0075 00            	ds.b	1
11814                     	xdef	_T
11815                     	switch	.bss
11816  000a               _Ufade:
11817  000a 0000          	ds.b	2
11818                     	xdef	_Ufade
11819  000c               _Udelt:
11820  000c 0000          	ds.b	2
11821                     	xdef	_Udelt
11822  000e               _Uin:
11823  000e 0000          	ds.b	2
11824                     	xdef	_Uin
11825  0010               _Usum:
11826  0010 0000          	ds.b	2
11827                     	xdef	_Usum
11828  0012               _U_out_const:
11829  0012 0000          	ds.b	2
11830                     	xdef	_U_out_const
11831  0014               _Unecc:
11832  0014 0000          	ds.b	2
11833                     	xdef	_Unecc
11834  0016               _Ui:
11835  0016 0000          	ds.b	2
11836                     	xdef	_Ui
11837  0018               _Un:
11838  0018 0000          	ds.b	2
11839                     	xdef	_Un
11840  001a               _I:
11841  001a 0000          	ds.b	2
11842                     	xdef	_I
11843                     	switch	.ubsct
11844  0076               _can_error_cnt:
11845  0076 00            	ds.b	1
11846                     	xdef	_can_error_cnt
11847                     	xdef	_bCAN_RX
11848  0077               _tx_busy_cnt:
11849  0077 00            	ds.b	1
11850                     	xdef	_tx_busy_cnt
11851                     	xdef	_bTX_FREE
11852  0078               _can_buff_rd_ptr:
11853  0078 00            	ds.b	1
11854                     	xdef	_can_buff_rd_ptr
11855  0079               _can_buff_wr_ptr:
11856  0079 00            	ds.b	1
11857                     	xdef	_can_buff_wr_ptr
11858  007a               _can_out_buff:
11859  007a 000000000000  	ds.b	64
11860                     	xdef	_can_out_buff
11861                     	switch	.bss
11862  001c               _pwm_u_buff_cnt:
11863  001c 00            	ds.b	1
11864                     	xdef	_pwm_u_buff_cnt
11865  001d               _pwm_u_buff_ptr:
11866  001d 00            	ds.b	1
11867                     	xdef	_pwm_u_buff_ptr
11868  001e               _pwm_u_buff_:
11869  001e 0000          	ds.b	2
11870                     	xdef	_pwm_u_buff_
11871  0020               _pwm_u_buff:
11872  0020 000000000000  	ds.b	64
11873                     	xdef	_pwm_u_buff
11874                     	switch	.ubsct
11875  00ba               _adc_cnt_cnt:
11876  00ba 00            	ds.b	1
11877                     	xdef	_adc_cnt_cnt
11878                     	switch	.bss
11879  0060               _adc_buff_buff:
11880  0060 000000000000  	ds.b	160
11881                     	xdef	_adc_buff_buff
11882  0100               _adress_error:
11883  0100 00            	ds.b	1
11884                     	xdef	_adress_error
11885  0101               _adress:
11886  0101 00            	ds.b	1
11887                     	xdef	_adress
11888  0102               _adr:
11889  0102 000000        	ds.b	3
11890                     	xdef	_adr
11891                     	xdef	_adr_drv_stat
11892                     	xdef	_led_ind
11893                     	switch	.ubsct
11894  00bb               _led_ind_cnt:
11895  00bb 00            	ds.b	1
11896                     	xdef	_led_ind_cnt
11897  00bc               _adc_plazma:
11898  00bc 000000000000  	ds.b	10
11899                     	xdef	_adc_plazma
11900  00c6               _adc_plazma_short:
11901  00c6 0000          	ds.b	2
11902                     	xdef	_adc_plazma_short
11903  00c8               _adc_cnt:
11904  00c8 00            	ds.b	1
11905                     	xdef	_adc_cnt
11906  00c9               _adc_ch:
11907  00c9 00            	ds.b	1
11908                     	xdef	_adc_ch
11909                     	switch	.bss
11910  0105               _adc_buff_1:
11911  0105 0000          	ds.b	2
11912                     	xdef	_adc_buff_1
11913  0107               _adc_buff_5:
11914  0107 0000          	ds.b	2
11915                     	xdef	_adc_buff_5
11916  0109               _adc_buff_:
11917  0109 000000000000  	ds.b	20
11918                     	xdef	_adc_buff_
11919  011d               _adc_buff:
11920  011d 000000000000  	ds.b	320
11921                     	xdef	_adc_buff
11922  025d               _main_cnt10:
11923  025d 0000          	ds.b	2
11924                     	xdef	_main_cnt10
11925  025f               _main_cnt:
11926  025f 0000          	ds.b	2
11927                     	xdef	_main_cnt
11928                     	switch	.ubsct
11929  00ca               _mess:
11930  00ca 000000000000  	ds.b	14
11931                     	xdef	_mess
11932                     	switch	.bit
11933  0004               _b20Hz:
11934  0004 00            	ds.b	1
11935                     	xdef	_b20Hz
11936  0005               _b1000Hz:
11937  0005 00            	ds.b	1
11938                     	xdef	_b1000Hz
11939  0006               _b1Hz:
11940  0006 00            	ds.b	1
11941                     	xdef	_b1Hz
11942  0007               _b2Hz:
11943  0007 00            	ds.b	1
11944                     	xdef	_b2Hz
11945  0008               _b5Hz:
11946  0008 00            	ds.b	1
11947                     	xdef	_b5Hz
11948  0009               _b10Hz:
11949  0009 00            	ds.b	1
11950                     	xdef	_b10Hz
11951  000a               _b100Hz:
11952  000a 00            	ds.b	1
11953                     	xdef	_b100Hz
11954                     	xdef	_t0_cnt5
11955                     	xdef	_t0_cnt4
11956                     	xdef	_t0_cnt3
11957                     	xdef	_t0_cnt2
11958                     	xdef	_t0_cnt1
11959                     	xdef	_t0_cnt0
11960                     	xdef	_t0_cnt00
11961                     	xref	_BUILD_DAY
11962                     	xref	_BUILD_MONTH
11963                     	xref	_BUILD_YEAR
11964                     	xref	_BUILD
11965                     	xref	_SOFT_VERSION
11966                     	xref	_HARDVARE_VERSION
11967                     	xref	_abs
11968                     	xdef	_bVENT_BLOCK
11969                     	xref.b	c_lreg
11970                     	xref.b	c_x
11971                     	xref.b	c_y
11991                     	xref	c_lrsh
11992                     	xref	c_umul
11993                     	xref	c_idiv
11994                     	xref	c_lgsub
11995                     	xref	c_lgrsh
11996                     	xref	c_lgadd
11997                     	xref	c_sdivx
11998                     	xref	c_imul
11999                     	xref	c_lsbc
12000                     	xref	c_ladd
12001                     	xref	c_lsub
12002                     	xref	c_ldiv
12003                     	xref	c_lgmul
12004                     	xref	c_itolx
12005                     	xref	c_eewrc
12006                     	xref	c_ltor
12007                     	xref	c_lgadc
12008                     	xref	c_rtol
12009                     	xref	c_vmul
12010                     	xref	c_eewrw
12011                     	xref	c_lcmp
12012                     	xref	c_uitolx
12013                     	end
