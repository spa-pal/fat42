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
2187  0007 00            	dc.b	0
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
2272                     ; 190 void vent_resurs_hndl(void)
2272                     ; 191 {
2273                     	scross	off
2274                     	switch	.text
2275  0000               _vent_resurs_hndl:
2277  0000 88            	push	a
2278       00000001      OFST:	set	1
2281                     ; 193 if(vent_pwm>100)vent_resurs_sec_cnt++;
2283  0001 9c            	rvf
2284  0002 be10          	ldw	x,_vent_pwm
2285  0004 a30065        	cpw	x,#101
2286  0007 2f07          	jrslt	L7441
2289  0009 be09          	ldw	x,_vent_resurs_sec_cnt
2290  000b 1c0001        	addw	x,#1
2291  000e bf09          	ldw	_vent_resurs_sec_cnt,x
2292  0010               L7441:
2293                     ; 194 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2295  0010 be09          	ldw	x,_vent_resurs_sec_cnt
2296  0012 a30e11        	cpw	x,#3601
2297  0015 251b          	jrult	L1541
2298                     ; 196 	if(vent_resurs<60000)vent_resurs++;
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
2314                     ; 197 	vent_resurs_sec_cnt=0;
2316  002f 5f            	clrw	x
2317  0030 bf09          	ldw	_vent_resurs_sec_cnt,x
2318  0032               L1541:
2319                     ; 202 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2321  0032 c60001        	ld	a,_vent_resurs+1
2322  0035 a40f          	and	a,#15
2323  0037 c70000        	ld	_vent_resurs_buff,a
2324                     ; 203 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2326  003a c60001        	ld	a,_vent_resurs+1
2327  003d a4f0          	and	a,#240
2328  003f 4e            	swap	a
2329  0040 a40f          	and	a,#15
2330  0042 aa40          	or	a,#64
2331  0044 c70001        	ld	_vent_resurs_buff+1,a
2332                     ; 204 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
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
2347                     ; 205 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
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
2366                     ; 207 temp=vent_resurs_buff[0]&0x0f;
2368  0076 c60000        	ld	a,_vent_resurs_buff
2369  0079 a40f          	and	a,#15
2370  007b 6b01          	ld	(OFST+0,sp),a
2371                     ; 208 temp^=vent_resurs_buff[1]&0x0f;
2373  007d c60001        	ld	a,_vent_resurs_buff+1
2374  0080 a40f          	and	a,#15
2375  0082 1801          	xor	a,(OFST+0,sp)
2376  0084 6b01          	ld	(OFST+0,sp),a
2377                     ; 209 temp^=vent_resurs_buff[2]&0x0f;
2379  0086 c60002        	ld	a,_vent_resurs_buff+2
2380  0089 a40f          	and	a,#15
2381  008b 1801          	xor	a,(OFST+0,sp)
2382  008d 6b01          	ld	(OFST+0,sp),a
2383                     ; 210 temp^=vent_resurs_buff[3]&0x0f;
2385  008f c60003        	ld	a,_vent_resurs_buff+3
2386  0092 a40f          	and	a,#15
2387  0094 1801          	xor	a,(OFST+0,sp)
2388  0096 6b01          	ld	(OFST+0,sp),a
2389                     ; 212 vent_resurs_buff[0]|=(temp&0x03)<<4;
2391  0098 7b01          	ld	a,(OFST+0,sp)
2392  009a a403          	and	a,#3
2393  009c 97            	ld	xl,a
2394  009d a610          	ld	a,#16
2395  009f 42            	mul	x,a
2396  00a0 9f            	ld	a,xl
2397  00a1 ca0000        	or	a,_vent_resurs_buff
2398  00a4 c70000        	ld	_vent_resurs_buff,a
2399                     ; 213 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2401  00a7 7b01          	ld	a,(OFST+0,sp)
2402  00a9 a40c          	and	a,#12
2403  00ab 48            	sll	a
2404  00ac 48            	sll	a
2405  00ad ca0001        	or	a,_vent_resurs_buff+1
2406  00b0 c70001        	ld	_vent_resurs_buff+1,a
2407                     ; 214 vent_resurs_buff[2]|=(temp&0x30);
2409  00b3 7b01          	ld	a,(OFST+0,sp)
2410  00b5 a430          	and	a,#48
2411  00b7 ca0002        	or	a,_vent_resurs_buff+2
2412  00ba c70002        	ld	_vent_resurs_buff+2,a
2413                     ; 215 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2415  00bd 7b01          	ld	a,(OFST+0,sp)
2416  00bf a4c0          	and	a,#192
2417  00c1 44            	srl	a
2418  00c2 44            	srl	a
2419  00c3 ca0003        	or	a,_vent_resurs_buff+3
2420  00c6 c70003        	ld	_vent_resurs_buff+3,a
2421                     ; 218 vent_resurs_tx_cnt++;
2423  00c9 3c08          	inc	_vent_resurs_tx_cnt
2424                     ; 219 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2426  00cb b608          	ld	a,_vent_resurs_tx_cnt
2427  00cd a104          	cp	a,#4
2428  00cf 2502          	jrult	L5541
2431  00d1 3f08          	clr	_vent_resurs_tx_cnt
2432  00d3               L5541:
2433                     ; 222 }
2436  00d3 84            	pop	a
2437  00d4 81            	ret
2490                     ; 225 void gran(signed short *adr, signed short min, signed short max)
2490                     ; 226 {
2491                     	switch	.text
2492  00d5               _gran:
2494  00d5 89            	pushw	x
2495       00000000      OFST:	set	0
2498                     ; 227 if (*adr<min) *adr=min;
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
2512                     ; 228 if (*adr>max) *adr=max; 
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
2528                     ; 229 } 
2531  00f4 85            	popw	x
2532  00f5 81            	ret
2585                     ; 232 void granee(@eeprom signed short *adr, signed short min, signed short max)
2585                     ; 233 {
2586                     	switch	.text
2587  00f6               _granee:
2589  00f6 89            	pushw	x
2590       00000000      OFST:	set	0
2593                     ; 234 if (*adr<min) *adr=min;
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
2611                     ; 235 if (*adr>max) *adr=max; 
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
2630                     ; 236 }
2633  011f 85            	popw	x
2634  0120 81            	ret
2695                     ; 239 long delay_ms(short in)
2695                     ; 240 {
2696                     	switch	.text
2697  0121               _delay_ms:
2699  0121 520c          	subw	sp,#12
2700       0000000c      OFST:	set	12
2703                     ; 243 i=((long)in)*100UL;
2705  0123 90ae0064      	ldw	y,#100
2706  0127 cd0000        	call	c_vmul
2708  012a 96            	ldw	x,sp
2709  012b 1c0005        	addw	x,#OFST-7
2710  012e cd0000        	call	c_rtol
2712                     ; 245 for(ii=0;ii<i;ii++)
2714  0131 ae0000        	ldw	x,#0
2715  0134 1f0b          	ldw	(OFST-1,sp),x
2716  0136 ae0000        	ldw	x,#0
2717  0139 1f09          	ldw	(OFST-3,sp),x
2719  013b 2012          	jra	L1061
2720  013d               L5751:
2721                     ; 247 		iii++;
2723  013d 96            	ldw	x,sp
2724  013e 1c0001        	addw	x,#OFST-11
2725  0141 a601          	ld	a,#1
2726  0143 cd0000        	call	c_lgadc
2728                     ; 245 for(ii=0;ii<i;ii++)
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
2748                     ; 250 }
2751  0160 5b0c          	addw	sp,#12
2752  0162 81            	ret
2785                     ; 253 void led_hndl(void)
2785                     ; 254 {
2786                     	switch	.text
2787  0163               _led_hndl:
2791                     ; 255 if(adress_error)
2793  0163 725d00f6      	tnz	_adress_error
2794  0167 2714          	jreq	L5161
2795                     ; 257 	led_red=0x55555555L;
2797  0169 ae5555        	ldw	x,#21845
2798  016c bf10          	ldw	_led_red+2,x
2799  016e ae5555        	ldw	x,#21845
2800  0171 bf0e          	ldw	_led_red,x
2801                     ; 258 	led_green=0x55555555L;
2803  0173 ae5555        	ldw	x,#21845
2804  0176 bf14          	ldw	_led_green+2,x
2805  0178 ae5555        	ldw	x,#21845
2806  017b bf12          	ldw	_led_green,x
2807  017d               L5161:
2808                     ; 276 	if(jp_mode!=jp3)
2810  017d b654          	ld	a,_jp_mode
2811  017f a103          	cp	a,#3
2812  0181 2603          	jrne	L02
2813  0183 cc0311        	jp	L7161
2814  0186               L02:
2815                     ; 278 		if(main_cnt1<(5*EE_TZAS))
2817  0186 9c            	rvf
2818  0187 be5b          	ldw	x,_main_cnt1
2819  0189 a3000f        	cpw	x,#15
2820  018c 2e18          	jrsge	L1261
2821                     ; 280 			led_red=0x00000000L;
2823  018e ae0000        	ldw	x,#0
2824  0191 bf10          	ldw	_led_red+2,x
2825  0193 ae0000        	ldw	x,#0
2826  0196 bf0e          	ldw	_led_red,x
2827                     ; 281 			led_green=0x0303030fL;
2829  0198 ae030f        	ldw	x,#783
2830  019b bf14          	ldw	_led_green+2,x
2831  019d ae0303        	ldw	x,#771
2832  01a0 bf12          	ldw	_led_green,x
2834  01a2 acd202d2      	jpf	L3261
2835  01a6               L1261:
2836                     ; 284 		else if((link==ON)&&(flags_tu&0b10000000))
2838  01a6 b66d          	ld	a,_link
2839  01a8 a155          	cp	a,#85
2840  01aa 261e          	jrne	L5261
2842  01ac b66a          	ld	a,_flags_tu
2843  01ae a580          	bcp	a,#128
2844  01b0 2718          	jreq	L5261
2845                     ; 286 			led_red=0x00055555L;
2847  01b2 ae5555        	ldw	x,#21845
2848  01b5 bf10          	ldw	_led_red+2,x
2849  01b7 ae0005        	ldw	x,#5
2850  01ba bf0e          	ldw	_led_red,x
2851                     ; 287 			led_green=0xffffffffL;
2853  01bc aeffff        	ldw	x,#65535
2854  01bf bf14          	ldw	_led_green+2,x
2855  01c1 aeffff        	ldw	x,#-1
2856  01c4 bf12          	ldw	_led_green,x
2858  01c6 acd202d2      	jpf	L3261
2859  01ca               L5261:
2860                     ; 290 		else if(((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(100+(5*EE_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2862  01ca 9c            	rvf
2863  01cb be5b          	ldw	x,_main_cnt1
2864  01cd a30010        	cpw	x,#16
2865  01d0 2f2d          	jrslt	L1361
2867  01d2 9c            	rvf
2868  01d3 be5b          	ldw	x,_main_cnt1
2869  01d5 a30073        	cpw	x,#115
2870  01d8 2e25          	jrsge	L1361
2872  01da ce0006        	ldw	x,_ee_AVT_MODE
2873  01dd a30055        	cpw	x,#85
2874  01e0 271d          	jreq	L1361
2876  01e2 ce0004        	ldw	x,_ee_DEVICE
2877  01e5 2618          	jrne	L1361
2878                     ; 292 			led_red=0x00000000L;
2880  01e7 ae0000        	ldw	x,#0
2881  01ea bf10          	ldw	_led_red+2,x
2882  01ec ae0000        	ldw	x,#0
2883  01ef bf0e          	ldw	_led_red,x
2884                     ; 293 			led_green=0xffffffffL;	
2886  01f1 aeffff        	ldw	x,#65535
2887  01f4 bf14          	ldw	_led_green+2,x
2888  01f6 aeffff        	ldw	x,#-1
2889  01f9 bf12          	ldw	_led_green,x
2891  01fb acd202d2      	jpf	L3261
2892  01ff               L1361:
2893                     ; 296 		else  if(link==OFF)
2895  01ff b66d          	ld	a,_link
2896  0201 a1aa          	cp	a,#170
2897  0203 2618          	jrne	L5361
2898                     ; 298 			led_red=0x55555555L;
2900  0205 ae5555        	ldw	x,#21845
2901  0208 bf10          	ldw	_led_red+2,x
2902  020a ae5555        	ldw	x,#21845
2903  020d bf0e          	ldw	_led_red,x
2904                     ; 299 			led_green=0xffffffffL;
2906  020f aeffff        	ldw	x,#65535
2907  0212 bf14          	ldw	_led_green+2,x
2908  0214 aeffff        	ldw	x,#-1
2909  0217 bf12          	ldw	_led_green,x
2911  0219 acd202d2      	jpf	L3261
2912  021d               L5361:
2913                     ; 302 		else if((link==ON)&&((flags&0b00111110)==0))
2915  021d b66d          	ld	a,_link
2916  021f a155          	cp	a,#85
2917  0221 261d          	jrne	L1461
2919  0223 b605          	ld	a,_flags
2920  0225 a53e          	bcp	a,#62
2921  0227 2617          	jrne	L1461
2922                     ; 304 			led_red=0x00000000L;
2924  0229 ae0000        	ldw	x,#0
2925  022c bf10          	ldw	_led_red+2,x
2926  022e ae0000        	ldw	x,#0
2927  0231 bf0e          	ldw	_led_red,x
2928                     ; 305 			led_green=0xffffffffL;
2930  0233 aeffff        	ldw	x,#65535
2931  0236 bf14          	ldw	_led_green+2,x
2932  0238 aeffff        	ldw	x,#-1
2933  023b bf12          	ldw	_led_green,x
2935  023d cc02d2        	jra	L3261
2936  0240               L1461:
2937                     ; 308 		else if((flags&0b00111110)==0b00000100)
2939  0240 b605          	ld	a,_flags
2940  0242 a43e          	and	a,#62
2941  0244 a104          	cp	a,#4
2942  0246 2616          	jrne	L5461
2943                     ; 310 			led_red=0x00010001L;
2945  0248 ae0001        	ldw	x,#1
2946  024b bf10          	ldw	_led_red+2,x
2947  024d ae0001        	ldw	x,#1
2948  0250 bf0e          	ldw	_led_red,x
2949                     ; 311 			led_green=0xffffffffL;	
2951  0252 aeffff        	ldw	x,#65535
2952  0255 bf14          	ldw	_led_green+2,x
2953  0257 aeffff        	ldw	x,#-1
2954  025a bf12          	ldw	_led_green,x
2956  025c 2074          	jra	L3261
2957  025e               L5461:
2958                     ; 313 		else if(flags&0b00000010)
2960  025e b605          	ld	a,_flags
2961  0260 a502          	bcp	a,#2
2962  0262 2716          	jreq	L1561
2963                     ; 315 			led_red=0x00010001L;
2965  0264 ae0001        	ldw	x,#1
2966  0267 bf10          	ldw	_led_red+2,x
2967  0269 ae0001        	ldw	x,#1
2968  026c bf0e          	ldw	_led_red,x
2969                     ; 316 			led_green=0x00000000L;	
2971  026e ae0000        	ldw	x,#0
2972  0271 bf14          	ldw	_led_green+2,x
2973  0273 ae0000        	ldw	x,#0
2974  0276 bf12          	ldw	_led_green,x
2976  0278 2058          	jra	L3261
2977  027a               L1561:
2978                     ; 318 		else if(flags&0b00001000)
2980  027a b605          	ld	a,_flags
2981  027c a508          	bcp	a,#8
2982  027e 2716          	jreq	L5561
2983                     ; 320 			led_red=0x00090009L;
2985  0280 ae0009        	ldw	x,#9
2986  0283 bf10          	ldw	_led_red+2,x
2987  0285 ae0009        	ldw	x,#9
2988  0288 bf0e          	ldw	_led_red,x
2989                     ; 321 			led_green=0x00000000L;	
2991  028a ae0000        	ldw	x,#0
2992  028d bf14          	ldw	_led_green+2,x
2993  028f ae0000        	ldw	x,#0
2994  0292 bf12          	ldw	_led_green,x
2996  0294 203c          	jra	L3261
2997  0296               L5561:
2998                     ; 323 		else if(flags&0b00010000)
3000  0296 b605          	ld	a,_flags
3001  0298 a510          	bcp	a,#16
3002  029a 2716          	jreq	L1661
3003                     ; 325 			led_red=0x00490049L;
3005  029c ae0049        	ldw	x,#73
3006  029f bf10          	ldw	_led_red+2,x
3007  02a1 ae0049        	ldw	x,#73
3008  02a4 bf0e          	ldw	_led_red,x
3009                     ; 326 			led_green=0x00000000L;	
3011  02a6 ae0000        	ldw	x,#0
3012  02a9 bf14          	ldw	_led_green+2,x
3013  02ab ae0000        	ldw	x,#0
3014  02ae bf12          	ldw	_led_green,x
3016  02b0 2020          	jra	L3261
3017  02b2               L1661:
3018                     ; 329 		else if((link==ON)&&(flags&0b00100000))
3020  02b2 b66d          	ld	a,_link
3021  02b4 a155          	cp	a,#85
3022  02b6 261a          	jrne	L3261
3024  02b8 b605          	ld	a,_flags
3025  02ba a520          	bcp	a,#32
3026  02bc 2714          	jreq	L3261
3027                     ; 331 			led_red=0x00000000L;
3029  02be ae0000        	ldw	x,#0
3030  02c1 bf10          	ldw	_led_red+2,x
3031  02c3 ae0000        	ldw	x,#0
3032  02c6 bf0e          	ldw	_led_red,x
3033                     ; 332 			led_green=0x00030003L;
3035  02c8 ae0003        	ldw	x,#3
3036  02cb bf14          	ldw	_led_green+2,x
3037  02cd ae0003        	ldw	x,#3
3038  02d0 bf12          	ldw	_led_green,x
3039  02d2               L3261:
3040                     ; 335 		if((jp_mode==jp1))
3042  02d2 b654          	ld	a,_jp_mode
3043  02d4 a101          	cp	a,#1
3044  02d6 2618          	jrne	L7661
3045                     ; 337 			led_red=0x00000000L;
3047  02d8 ae0000        	ldw	x,#0
3048  02db bf10          	ldw	_led_red+2,x
3049  02dd ae0000        	ldw	x,#0
3050  02e0 bf0e          	ldw	_led_red,x
3051                     ; 338 			led_green=0x33333333L;
3053  02e2 ae3333        	ldw	x,#13107
3054  02e5 bf14          	ldw	_led_green+2,x
3055  02e7 ae3333        	ldw	x,#13107
3056  02ea bf12          	ldw	_led_green,x
3058  02ec aced03ed      	jpf	L5761
3059  02f0               L7661:
3060                     ; 340 		else if((jp_mode==jp2))
3062  02f0 b654          	ld	a,_jp_mode
3063  02f2 a102          	cp	a,#2
3064  02f4 2703          	jreq	L22
3065  02f6 cc03ed        	jp	L5761
3066  02f9               L22:
3067                     ; 342 			led_red=0xccccccccL;
3069  02f9 aecccc        	ldw	x,#52428
3070  02fc bf10          	ldw	_led_red+2,x
3071  02fe aecccc        	ldw	x,#-13108
3072  0301 bf0e          	ldw	_led_red,x
3073                     ; 343 			led_green=0x00000000L;
3075  0303 ae0000        	ldw	x,#0
3076  0306 bf14          	ldw	_led_green+2,x
3077  0308 ae0000        	ldw	x,#0
3078  030b bf12          	ldw	_led_green,x
3079  030d aced03ed      	jpf	L5761
3080  0311               L7161:
3081                     ; 348 	else if(jp_mode==jp3)
3083  0311 b654          	ld	a,_jp_mode
3084  0313 a103          	cp	a,#3
3085  0315 2703          	jreq	L42
3086  0317 cc03ed        	jp	L5761
3087  031a               L42:
3088                     ; 350 		if(main_cnt1<(5*EE_TZAS))
3090  031a 9c            	rvf
3091  031b be5b          	ldw	x,_main_cnt1
3092  031d a3000f        	cpw	x,#15
3093  0320 2e18          	jrsge	L1071
3094                     ; 352 			led_red=0x00000000L;
3096  0322 ae0000        	ldw	x,#0
3097  0325 bf10          	ldw	_led_red+2,x
3098  0327 ae0000        	ldw	x,#0
3099  032a bf0e          	ldw	_led_red,x
3100                     ; 353 			led_green=0x03030303L;
3102  032c ae0303        	ldw	x,#771
3103  032f bf14          	ldw	_led_green+2,x
3104  0331 ae0303        	ldw	x,#771
3105  0334 bf12          	ldw	_led_green,x
3107  0336 aced03ed      	jpf	L5761
3108  033a               L1071:
3109                     ; 355 		else if((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(70+(5*EE_TZAS))))
3111  033a 9c            	rvf
3112  033b be5b          	ldw	x,_main_cnt1
3113  033d a30010        	cpw	x,#16
3114  0340 2f1f          	jrslt	L5071
3116  0342 9c            	rvf
3117  0343 be5b          	ldw	x,_main_cnt1
3118  0345 a30055        	cpw	x,#85
3119  0348 2e17          	jrsge	L5071
3120                     ; 357 			led_red=0x00000000L;
3122  034a ae0000        	ldw	x,#0
3123  034d bf10          	ldw	_led_red+2,x
3124  034f ae0000        	ldw	x,#0
3125  0352 bf0e          	ldw	_led_red,x
3126                     ; 358 			led_green=0xffffffffL;	
3128  0354 aeffff        	ldw	x,#65535
3129  0357 bf14          	ldw	_led_green+2,x
3130  0359 aeffff        	ldw	x,#-1
3131  035c bf12          	ldw	_led_green,x
3133  035e cc03ed        	jra	L5761
3134  0361               L5071:
3135                     ; 361 		else if((flags&0b00011110)==0)
3137  0361 b605          	ld	a,_flags
3138  0363 a51e          	bcp	a,#30
3139  0365 2616          	jrne	L1171
3140                     ; 363 			led_red=0x00000000L;
3142  0367 ae0000        	ldw	x,#0
3143  036a bf10          	ldw	_led_red+2,x
3144  036c ae0000        	ldw	x,#0
3145  036f bf0e          	ldw	_led_red,x
3146                     ; 364 			led_green=0xffffffffL;
3148  0371 aeffff        	ldw	x,#65535
3149  0374 bf14          	ldw	_led_green+2,x
3150  0376 aeffff        	ldw	x,#-1
3151  0379 bf12          	ldw	_led_green,x
3153  037b 2070          	jra	L5761
3154  037d               L1171:
3155                     ; 368 		else if((flags&0b00111110)==0b00000100)
3157  037d b605          	ld	a,_flags
3158  037f a43e          	and	a,#62
3159  0381 a104          	cp	a,#4
3160  0383 2616          	jrne	L5171
3161                     ; 370 			led_red=0x00010001L;
3163  0385 ae0001        	ldw	x,#1
3164  0388 bf10          	ldw	_led_red+2,x
3165  038a ae0001        	ldw	x,#1
3166  038d bf0e          	ldw	_led_red,x
3167                     ; 371 			led_green=0xffffffffL;	
3169  038f aeffff        	ldw	x,#65535
3170  0392 bf14          	ldw	_led_green+2,x
3171  0394 aeffff        	ldw	x,#-1
3172  0397 bf12          	ldw	_led_green,x
3174  0399 2052          	jra	L5761
3175  039b               L5171:
3176                     ; 373 		else if(flags&0b00000010)
3178  039b b605          	ld	a,_flags
3179  039d a502          	bcp	a,#2
3180  039f 2716          	jreq	L1271
3181                     ; 375 			led_red=0x00010001L;
3183  03a1 ae0001        	ldw	x,#1
3184  03a4 bf10          	ldw	_led_red+2,x
3185  03a6 ae0001        	ldw	x,#1
3186  03a9 bf0e          	ldw	_led_red,x
3187                     ; 376 			led_green=0x00000000L;	
3189  03ab ae0000        	ldw	x,#0
3190  03ae bf14          	ldw	_led_green+2,x
3191  03b0 ae0000        	ldw	x,#0
3192  03b3 bf12          	ldw	_led_green,x
3194  03b5 2036          	jra	L5761
3195  03b7               L1271:
3196                     ; 378 		else if(flags&0b00001000)
3198  03b7 b605          	ld	a,_flags
3199  03b9 a508          	bcp	a,#8
3200  03bb 2716          	jreq	L5271
3201                     ; 380 			led_red=0x00090009L;
3203  03bd ae0009        	ldw	x,#9
3204  03c0 bf10          	ldw	_led_red+2,x
3205  03c2 ae0009        	ldw	x,#9
3206  03c5 bf0e          	ldw	_led_red,x
3207                     ; 381 			led_green=0x00000000L;	
3209  03c7 ae0000        	ldw	x,#0
3210  03ca bf14          	ldw	_led_green+2,x
3211  03cc ae0000        	ldw	x,#0
3212  03cf bf12          	ldw	_led_green,x
3214  03d1 201a          	jra	L5761
3215  03d3               L5271:
3216                     ; 383 		else if(flags&0b00010000)
3218  03d3 b605          	ld	a,_flags
3219  03d5 a510          	bcp	a,#16
3220  03d7 2714          	jreq	L5761
3221                     ; 385 			led_red=0x00490049L;
3223  03d9 ae0049        	ldw	x,#73
3224  03dc bf10          	ldw	_led_red+2,x
3225  03de ae0049        	ldw	x,#73
3226  03e1 bf0e          	ldw	_led_red,x
3227                     ; 386 			led_green=0xffffffffL;	
3229  03e3 aeffff        	ldw	x,#65535
3230  03e6 bf14          	ldw	_led_green+2,x
3231  03e8 aeffff        	ldw	x,#-1
3232  03eb bf12          	ldw	_led_green,x
3233  03ed               L5761:
3234                     ; 546 }
3237  03ed 81            	ret
3265                     ; 549 void led_drv(void)
3265                     ; 550 {
3266                     	switch	.text
3267  03ee               _led_drv:
3271                     ; 552 GPIOA->DDR|=(1<<4);
3273  03ee 72185002      	bset	20482,#4
3274                     ; 553 GPIOA->CR1|=(1<<4);
3276  03f2 72185003      	bset	20483,#4
3277                     ; 554 GPIOA->CR2&=~(1<<4);
3279  03f6 72195004      	bres	20484,#4
3280                     ; 555 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3282  03fa b64a          	ld	a,_led_red_buff+3
3283  03fc a501          	bcp	a,#1
3284  03fe 2706          	jreq	L3471
3287  0400 72185000      	bset	20480,#4
3289  0404 2004          	jra	L5471
3290  0406               L3471:
3291                     ; 556 else GPIOA->ODR&=~(1<<4); 
3293  0406 72195000      	bres	20480,#4
3294  040a               L5471:
3295                     ; 559 GPIOA->DDR|=(1<<5);
3297  040a 721a5002      	bset	20482,#5
3298                     ; 560 GPIOA->CR1|=(1<<5);
3300  040e 721a5003      	bset	20483,#5
3301                     ; 561 GPIOA->CR2&=~(1<<5);	
3303  0412 721b5004      	bres	20484,#5
3304                     ; 562 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3306  0416 b646          	ld	a,_led_green_buff+3
3307  0418 a501          	bcp	a,#1
3308  041a 2706          	jreq	L7471
3311  041c 721a5000      	bset	20480,#5
3313  0420 2004          	jra	L1571
3314  0422               L7471:
3315                     ; 563 else GPIOA->ODR&=~(1<<5);
3317  0422 721b5000      	bres	20480,#5
3318  0426               L1571:
3319                     ; 566 led_red_buff>>=1;
3321  0426 3747          	sra	_led_red_buff
3322  0428 3648          	rrc	_led_red_buff+1
3323  042a 3649          	rrc	_led_red_buff+2
3324  042c 364a          	rrc	_led_red_buff+3
3325                     ; 567 led_green_buff>>=1;
3327  042e 3743          	sra	_led_green_buff
3328  0430 3644          	rrc	_led_green_buff+1
3329  0432 3645          	rrc	_led_green_buff+2
3330  0434 3646          	rrc	_led_green_buff+3
3331                     ; 568 if(++led_drv_cnt>32)
3333  0436 3c16          	inc	_led_drv_cnt
3334  0438 b616          	ld	a,_led_drv_cnt
3335  043a a121          	cp	a,#33
3336  043c 2512          	jrult	L3571
3337                     ; 570 	led_drv_cnt=0;
3339  043e 3f16          	clr	_led_drv_cnt
3340                     ; 571 	led_red_buff=led_red;
3342  0440 be10          	ldw	x,_led_red+2
3343  0442 bf49          	ldw	_led_red_buff+2,x
3344  0444 be0e          	ldw	x,_led_red
3345  0446 bf47          	ldw	_led_red_buff,x
3346                     ; 572 	led_green_buff=led_green;
3348  0448 be14          	ldw	x,_led_green+2
3349  044a bf45          	ldw	_led_green_buff+2,x
3350  044c be12          	ldw	x,_led_green
3351  044e bf43          	ldw	_led_green_buff,x
3352  0450               L3571:
3353                     ; 578 } 
3356  0450 81            	ret
3382                     ; 581 void JP_drv(void)
3382                     ; 582 {
3383                     	switch	.text
3384  0451               _JP_drv:
3388                     ; 584 GPIOD->DDR&=~(1<<6);
3390  0451 721d5011      	bres	20497,#6
3391                     ; 585 GPIOD->CR1|=(1<<6);
3393  0455 721c5012      	bset	20498,#6
3394                     ; 586 GPIOD->CR2&=~(1<<6);
3396  0459 721d5013      	bres	20499,#6
3397                     ; 588 GPIOD->DDR&=~(1<<7);
3399  045d 721f5011      	bres	20497,#7
3400                     ; 589 GPIOD->CR1|=(1<<7);
3402  0461 721e5012      	bset	20498,#7
3403                     ; 590 GPIOD->CR2&=~(1<<7);
3405  0465 721f5013      	bres	20499,#7
3406                     ; 592 if(GPIOD->IDR&(1<<6))
3408  0469 c65010        	ld	a,20496
3409  046c a540          	bcp	a,#64
3410  046e 270a          	jreq	L5671
3411                     ; 594 	if(cnt_JP0<10)
3413  0470 b653          	ld	a,_cnt_JP0
3414  0472 a10a          	cp	a,#10
3415  0474 2411          	jruge	L1771
3416                     ; 596 		cnt_JP0++;
3418  0476 3c53          	inc	_cnt_JP0
3419  0478 200d          	jra	L1771
3420  047a               L5671:
3421                     ; 599 else if(!(GPIOD->IDR&(1<<6)))
3423  047a c65010        	ld	a,20496
3424  047d a540          	bcp	a,#64
3425  047f 2606          	jrne	L1771
3426                     ; 601 	if(cnt_JP0)
3428  0481 3d53          	tnz	_cnt_JP0
3429  0483 2702          	jreq	L1771
3430                     ; 603 		cnt_JP0--;
3432  0485 3a53          	dec	_cnt_JP0
3433  0487               L1771:
3434                     ; 607 if(GPIOD->IDR&(1<<7))
3436  0487 c65010        	ld	a,20496
3437  048a a580          	bcp	a,#128
3438  048c 270a          	jreq	L7771
3439                     ; 609 	if(cnt_JP1<10)
3441  048e b652          	ld	a,_cnt_JP1
3442  0490 a10a          	cp	a,#10
3443  0492 2411          	jruge	L3002
3444                     ; 611 		cnt_JP1++;
3446  0494 3c52          	inc	_cnt_JP1
3447  0496 200d          	jra	L3002
3448  0498               L7771:
3449                     ; 614 else if(!(GPIOD->IDR&(1<<7)))
3451  0498 c65010        	ld	a,20496
3452  049b a580          	bcp	a,#128
3453  049d 2606          	jrne	L3002
3454                     ; 616 	if(cnt_JP1)
3456  049f 3d52          	tnz	_cnt_JP1
3457  04a1 2702          	jreq	L3002
3458                     ; 618 		cnt_JP1--;
3460  04a3 3a52          	dec	_cnt_JP1
3461  04a5               L3002:
3462                     ; 623 if((cnt_JP0==10)&&(cnt_JP1==10))
3464  04a5 b653          	ld	a,_cnt_JP0
3465  04a7 a10a          	cp	a,#10
3466  04a9 2608          	jrne	L1102
3468  04ab b652          	ld	a,_cnt_JP1
3469  04ad a10a          	cp	a,#10
3470  04af 2602          	jrne	L1102
3471                     ; 625 	jp_mode=jp0;
3473  04b1 3f54          	clr	_jp_mode
3474  04b3               L1102:
3475                     ; 627 if((cnt_JP0==0)&&(cnt_JP1==10))
3477  04b3 3d53          	tnz	_cnt_JP0
3478  04b5 260a          	jrne	L3102
3480  04b7 b652          	ld	a,_cnt_JP1
3481  04b9 a10a          	cp	a,#10
3482  04bb 2604          	jrne	L3102
3483                     ; 629 	jp_mode=jp1;
3485  04bd 35010054      	mov	_jp_mode,#1
3486  04c1               L3102:
3487                     ; 631 if((cnt_JP0==10)&&(cnt_JP1==0))
3489  04c1 b653          	ld	a,_cnt_JP0
3490  04c3 a10a          	cp	a,#10
3491  04c5 2608          	jrne	L5102
3493  04c7 3d52          	tnz	_cnt_JP1
3494  04c9 2604          	jrne	L5102
3495                     ; 633 	jp_mode=jp2;
3497  04cb 35020054      	mov	_jp_mode,#2
3498  04cf               L5102:
3499                     ; 635 if((cnt_JP0==0)&&(cnt_JP1==0))
3501  04cf 3d53          	tnz	_cnt_JP0
3502  04d1 2608          	jrne	L7102
3504  04d3 3d52          	tnz	_cnt_JP1
3505  04d5 2604          	jrne	L7102
3506                     ; 637 	jp_mode=jp3;
3508  04d7 35030054      	mov	_jp_mode,#3
3509  04db               L7102:
3510                     ; 640 }
3513  04db 81            	ret
3545                     ; 643 void link_drv(void)		//10Hz
3545                     ; 644 {
3546                     	switch	.text
3547  04dc               _link_drv:
3551                     ; 645 if(jp_mode!=jp3)
3553  04dc b654          	ld	a,_jp_mode
3554  04de a103          	cp	a,#3
3555  04e0 274d          	jreq	L1302
3556                     ; 647 	if(link_cnt<602)link_cnt++;
3558  04e2 9c            	rvf
3559  04e3 be6b          	ldw	x,_link_cnt
3560  04e5 a3025a        	cpw	x,#602
3561  04e8 2e07          	jrsge	L3302
3564  04ea be6b          	ldw	x,_link_cnt
3565  04ec 1c0001        	addw	x,#1
3566  04ef bf6b          	ldw	_link_cnt,x
3567  04f1               L3302:
3568                     ; 648 	if(link_cnt==90)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
3570  04f1 be6b          	ldw	x,_link_cnt
3571  04f3 a3005a        	cpw	x,#90
3572  04f6 2606          	jrne	L5302
3575  04f8 b605          	ld	a,_flags
3576  04fa a4c1          	and	a,#193
3577  04fc b705          	ld	_flags,a
3578  04fe               L5302:
3579                     ; 649 	if(link_cnt==100)
3581  04fe be6b          	ldw	x,_link_cnt
3582  0500 a30064        	cpw	x,#100
3583  0503 262e          	jrne	L7402
3584                     ; 651 		link=OFF;
3586  0505 35aa006d      	mov	_link,#170
3587                     ; 656 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
3589  0509 b60b          	ld	a,_bps_class
3590  050b a101          	cp	a,#1
3591  050d 2606          	jrne	L1402
3594  050f 72100001      	bset	_bMAIN
3596  0513 2004          	jra	L3402
3597  0515               L1402:
3598                     ; 657 		else bMAIN=0;
3600  0515 72110001      	bres	_bMAIN
3601  0519               L3402:
3602                     ; 659 		cnt_net_drv=0;
3604  0519 3f3c          	clr	_cnt_net_drv
3605                     ; 660     		if(!res_fl_)
3607  051b 725d000a      	tnz	_res_fl_
3608  051f 2612          	jrne	L7402
3609                     ; 662 	    		bRES_=1;
3611  0521 3501000d      	mov	_bRES_,#1
3612                     ; 663 	    		res_fl_=1;
3614  0525 a601          	ld	a,#1
3615  0527 ae000a        	ldw	x,#_res_fl_
3616  052a cd0000        	call	c_eewrc
3618  052d 2004          	jra	L7402
3619  052f               L1302:
3620                     ; 667 else link=OFF;	
3622  052f 35aa006d      	mov	_link,#170
3623  0533               L7402:
3624                     ; 668 } 
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
3707                     ; 672 void vent_drv(void)
3707                     ; 673 {
3708                     	switch	.text
3709  0534               _vent_drv:
3711  0534 520c          	subw	sp,#12
3712       0000000c      OFST:	set	12
3715                     ; 676 	short vent_pwm_i_necc=400;
3717  0536 ae0190        	ldw	x,#400
3718  0539 1f05          	ldw	(OFST-7,sp),x
3719                     ; 677 	short vent_pwm_t_necc=400;
3721  053b ae0190        	ldw	x,#400
3722  053e 1f07          	ldw	(OFST-5,sp),x
3723                     ; 678 	short vent_pwm_max_necc=400;
3725                     ; 684 	tempSL=(signed long)I;
3727  0540 ce0010        	ldw	x,_I
3728  0543 cd0000        	call	c_itolx
3730  0546 96            	ldw	x,sp
3731  0547 1c0009        	addw	x,#OFST-3
3732  054a cd0000        	call	c_rtol
3734                     ; 685 	tempSL*=(signed long)Ui;
3736  054d ce000c        	ldw	x,_Ui
3737  0550 cd0000        	call	c_itolx
3739  0553 96            	ldw	x,sp
3740  0554 1c0009        	addw	x,#OFST-3
3741  0557 cd0000        	call	c_lgmul
3743                     ; 686 	tempSL/=100L;
3745  055a 96            	ldw	x,sp
3746  055b 1c0009        	addw	x,#OFST-3
3747  055e cd0000        	call	c_ltor
3749  0561 ae0004        	ldw	x,#L63
3750  0564 cd0000        	call	c_ldiv
3752  0567 96            	ldw	x,sp
3753  0568 1c0009        	addw	x,#OFST-3
3754  056b cd0000        	call	c_rtol
3756                     ; 694 	if(tempSL>3000L)vent_pwm_i_necc=1000;
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
3774                     ; 695 	else if(tempSL<300L)vent_pwm_i_necc=0;
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
3792                     ; 696 	else vent_pwm_i_necc=(short)(400L + ((tempSL-300L)/4L));
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
3810                     ; 697 	gran(&vent_pwm_i_necc,0,1000);
3812  05b7 ae03e8        	ldw	x,#1000
3813  05ba 89            	pushw	x
3814  05bb 5f            	clrw	x
3815  05bc 89            	pushw	x
3816  05bd 96            	ldw	x,sp
3817  05be 1c0009        	addw	x,#OFST-3
3818  05c1 cd00d5        	call	_gran
3820  05c4 5b04          	addw	sp,#4
3821                     ; 699 	tempSL=(signed long)T;
3823  05c6 b672          	ld	a,_T
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
3835                     ; 700 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
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
3856                     ; 701 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
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
3874                     ; 702 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
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
3887                     ; 703 	gran(&vent_pwm_t_necc,0,1000);
3889  0625 ae03e8        	ldw	x,#1000
3890  0628 89            	pushw	x
3891  0629 5f            	clrw	x
3892  062a 89            	pushw	x
3893  062b 96            	ldw	x,sp
3894  062c 1c000b        	addw	x,#OFST-1
3895  062f cd00d5        	call	_gran
3897  0632 5b04          	addw	sp,#4
3898                     ; 705 	vent_pwm_max_necc=vent_pwm_i_necc;
3900  0634 1e05          	ldw	x,(OFST-7,sp)
3901  0636 1f03          	ldw	(OFST-9,sp),x
3902                     ; 706 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3904  0638 9c            	rvf
3905  0639 1e07          	ldw	x,(OFST-5,sp)
3906  063b 1305          	cpw	x,(OFST-7,sp)
3907  063d 2d04          	jrsle	L3212
3910  063f 1e07          	ldw	x,(OFST-5,sp)
3911  0641 1f03          	ldw	(OFST-9,sp),x
3912  0643               L3212:
3913                     ; 708 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3915  0643 9c            	rvf
3916  0644 be10          	ldw	x,_vent_pwm
3917  0646 1303          	cpw	x,(OFST-9,sp)
3918  0648 2e07          	jrsge	L5212
3921  064a be10          	ldw	x,_vent_pwm
3922  064c 1c000a        	addw	x,#10
3923  064f bf10          	ldw	_vent_pwm,x
3924  0651               L5212:
3925                     ; 709 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3927  0651 9c            	rvf
3928  0652 be10          	ldw	x,_vent_pwm
3929  0654 1303          	cpw	x,(OFST-9,sp)
3930  0656 2d07          	jrsle	L7212
3933  0658 be10          	ldw	x,_vent_pwm
3934  065a 1d000a        	subw	x,#10
3935  065d bf10          	ldw	_vent_pwm,x
3936  065f               L7212:
3937                     ; 710 	gran(&vent_pwm,0,1000);
3939  065f ae03e8        	ldw	x,#1000
3940  0662 89            	pushw	x
3941  0663 5f            	clrw	x
3942  0664 89            	pushw	x
3943  0665 ae0010        	ldw	x,#_vent_pwm
3944  0668 cd00d5        	call	_gran
3946  066b 5b04          	addw	sp,#4
3947                     ; 716 	if(vent_pwm_integr_cnt<10)
3949  066d 9c            	rvf
3950  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3951  0670 a3000a        	cpw	x,#10
3952  0673 2e26          	jrsge	L1312
3953                     ; 718 		vent_pwm_integr_cnt++;
3955  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3956  0677 1c0001        	addw	x,#1
3957  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3958                     ; 719 		if(vent_pwm_integr_cnt>=10)
3960  067c 9c            	rvf
3961  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3962  067f a3000a        	cpw	x,#10
3963  0682 2f17          	jrslt	L1312
3964                     ; 721 			vent_pwm_integr_cnt=0;
3966  0684 5f            	clrw	x
3967  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3968                     ; 722 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3970  0687 be0e          	ldw	x,_vent_pwm_integr
3971  0689 90ae0009      	ldw	y,#9
3972  068d cd0000        	call	c_imul
3974  0690 72bb0010      	addw	x,_vent_pwm
3975  0694 a60a          	ld	a,#10
3976  0696 cd0000        	call	c_sdivx
3978  0699 bf0e          	ldw	_vent_pwm_integr,x
3979  069b               L1312:
3980                     ; 725 	gran(&vent_pwm_integr,0,1000);
3982  069b ae03e8        	ldw	x,#1000
3983  069e 89            	pushw	x
3984  069f 5f            	clrw	x
3985  06a0 89            	pushw	x
3986  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3987  06a4 cd00d5        	call	_gran
3989  06a7 5b04          	addw	sp,#4
3990                     ; 729 }
3993  06a9 5b0c          	addw	sp,#12
3994  06ab 81            	ret
4021                     ; 734 void pwr_drv(void)
4021                     ; 735 {
4022                     	switch	.text
4023  06ac               _pwr_drv:
4027                     ; 796 gran(&pwm_u,10,2000);
4029  06ac ae07d0        	ldw	x,#2000
4030  06af 89            	pushw	x
4031  06b0 ae000a        	ldw	x,#10
4032  06b3 89            	pushw	x
4033  06b4 ae0008        	ldw	x,#_pwm_u
4034  06b7 cd00d5        	call	_gran
4036  06ba 5b04          	addw	sp,#4
4037                     ; 806 TIM1->CCR2H= (char)(pwm_u/256);	
4039  06bc be08          	ldw	x,_pwm_u
4040  06be 90ae0100      	ldw	y,#256
4041  06c2 cd0000        	call	c_idiv
4043  06c5 9f            	ld	a,xl
4044  06c6 c75267        	ld	21095,a
4045                     ; 807 TIM1->CCR2L= (char)pwm_u;
4047  06c9 5500095268    	mov	21096,_pwm_u+1
4048                     ; 809 TIM1->CCR1H= (char)(pwm_i/256);	
4050  06ce be0a          	ldw	x,_pwm_i
4051  06d0 90ae0100      	ldw	y,#256
4052  06d4 cd0000        	call	c_idiv
4054  06d7 9f            	ld	a,xl
4055  06d8 c75265        	ld	21093,a
4056                     ; 810 TIM1->CCR1L= (char)pwm_i;
4058  06db 55000b5266    	mov	21094,_pwm_i+1
4059                     ; 812 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4061  06e0 be0e          	ldw	x,_vent_pwm_integr
4062  06e2 90ae0080      	ldw	y,#128
4063  06e6 cd0000        	call	c_idiv
4065  06e9 9f            	ld	a,xl
4066  06ea c75269        	ld	21097,a
4067                     ; 813 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4069  06ed b60f          	ld	a,_vent_pwm_integr+1
4070  06ef 48            	sll	a
4071  06f0 c7526a        	ld	21098,a
4072                     ; 814 }
4075  06f3 81            	ret
4142                     	switch	.const
4143  0018               L45:
4144  0018 0000028a      	dc.l	650
4145                     ; 819 void pwr_hndl(void)				
4145                     ; 820 {
4146                     	switch	.text
4147  06f4               _pwr_hndl:
4149  06f4 5205          	subw	sp,#5
4150       00000005      OFST:	set	5
4153                     ; 821 if(jp_mode==jp3)
4155  06f6 b654          	ld	a,_jp_mode
4156  06f8 a103          	cp	a,#3
4157  06fa 260a          	jrne	L3712
4158                     ; 823 	pwm_u=0;
4160  06fc 5f            	clrw	x
4161  06fd bf08          	ldw	_pwm_u,x
4162                     ; 824 	pwm_i=0;
4164  06ff 5f            	clrw	x
4165  0700 bf0a          	ldw	_pwm_i,x
4167  0702 ac680868      	jpf	L5712
4168  0706               L3712:
4169                     ; 826 else if(jp_mode==jp2)
4171  0706 b654          	ld	a,_jp_mode
4172  0708 a102          	cp	a,#2
4173  070a 260c          	jrne	L7712
4174                     ; 828 	pwm_u=0;
4176  070c 5f            	clrw	x
4177  070d bf08          	ldw	_pwm_u,x
4178                     ; 829 	pwm_i=0x7ff;
4180  070f ae07ff        	ldw	x,#2047
4181  0712 bf0a          	ldw	_pwm_i,x
4183  0714 ac680868      	jpf	L5712
4184  0718               L7712:
4185                     ; 831 else if(jp_mode==jp1)
4187  0718 b654          	ld	a,_jp_mode
4188  071a a101          	cp	a,#1
4189  071c 260e          	jrne	L3022
4190                     ; 833 	pwm_u=0x7ff;
4192  071e ae07ff        	ldw	x,#2047
4193  0721 bf08          	ldw	_pwm_u,x
4194                     ; 834 	pwm_i=0x7ff;
4196  0723 ae07ff        	ldw	x,#2047
4197  0726 bf0a          	ldw	_pwm_i,x
4199  0728 ac680868      	jpf	L5712
4200  072c               L3022:
4201                     ; 845 else if(link==OFF)
4203  072c b66d          	ld	a,_link
4204  072e a1aa          	cp	a,#170
4205  0730 2703          	jreq	L65
4206  0732 cc07e5        	jp	L7022
4207  0735               L65:
4208                     ; 847 	pwm_i=0x7ff;
4210  0735 ae07ff        	ldw	x,#2047
4211  0738 bf0a          	ldw	_pwm_i,x
4212                     ; 848 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4214  073a ce000a        	ldw	x,_Unecc
4215  073d 90ae07d0      	ldw	y,#2000
4216  0741 cd0000        	call	c_vmul
4218  0744 ae0018        	ldw	x,#L45
4219  0747 cd0000        	call	c_ldiv
4221  074a be02          	ldw	x,c_lreg+2
4222  074c bf55          	ldw	_pwm_u_,x
4223                     ; 852 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4225  074e c60013        	ld	a,_pwm_u_buff_ptr
4226  0751 5f            	clrw	x
4227  0752 97            	ld	xl,a
4228  0753 58            	sllw	x
4229  0754 90be55        	ldw	y,_pwm_u_
4230  0757 df0016        	ldw	(_pwm_u_buff,x),y
4231                     ; 853 	pwm_u_buff_ptr++;
4233  075a 725c0013      	inc	_pwm_u_buff_ptr
4234                     ; 854 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4236  075e c60013        	ld	a,_pwm_u_buff_ptr
4237  0761 a110          	cp	a,#16
4238  0763 2504          	jrult	L1122
4241  0765 725f0013      	clr	_pwm_u_buff_ptr
4242  0769               L1122:
4243                     ; 858 		tempSL=0;
4245  0769 ae0000        	ldw	x,#0
4246  076c 1f03          	ldw	(OFST-2,sp),x
4247  076e ae0000        	ldw	x,#0
4248  0771 1f01          	ldw	(OFST-4,sp),x
4249                     ; 859 		for(i=0;i<16;i++)
4251  0773 0f05          	clr	(OFST+0,sp)
4252  0775               L3122:
4253                     ; 861 			tempSL+=(signed long)pwm_u_buff[i];
4255  0775 7b05          	ld	a,(OFST+0,sp)
4256  0777 5f            	clrw	x
4257  0778 97            	ld	xl,a
4258  0779 58            	sllw	x
4259  077a de0016        	ldw	x,(_pwm_u_buff,x)
4260  077d cd0000        	call	c_itolx
4262  0780 96            	ldw	x,sp
4263  0781 1c0001        	addw	x,#OFST-4
4264  0784 cd0000        	call	c_lgadd
4266                     ; 859 		for(i=0;i<16;i++)
4268  0787 0c05          	inc	(OFST+0,sp)
4271  0789 7b05          	ld	a,(OFST+0,sp)
4272  078b a110          	cp	a,#16
4273  078d 25e6          	jrult	L3122
4274                     ; 863 		tempSL>>=4;
4276  078f 96            	ldw	x,sp
4277  0790 1c0001        	addw	x,#OFST-4
4278  0793 a604          	ld	a,#4
4279  0795 cd0000        	call	c_lgrsh
4281                     ; 864 		pwm_u_buff_=(signed short)tempSL;
4283  0798 1e03          	ldw	x,(OFST-2,sp)
4284  079a cf0014        	ldw	_pwm_u_buff_,x
4285                     ; 866 	pwm_u=pwm_u_;
4287  079d be55          	ldw	x,_pwm_u_
4288  079f bf08          	ldw	_pwm_u,x
4289                     ; 867 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4291  07a1 9c            	rvf
4292  07a2 ce000c        	ldw	x,_Ui
4293  07a5 72b0000a      	subw	x,_Unecc
4294  07a9 cd0000        	call	_abs
4296  07ac a30014        	cpw	x,#20
4297  07af 2e06          	jrsge	L1222
4300  07b1 725c0012      	inc	_pwm_u_buff_cnt
4302  07b5 2004          	jra	L3222
4303  07b7               L1222:
4304                     ; 868 	else pwm_u_buff_cnt=0;
4306  07b7 725f0012      	clr	_pwm_u_buff_cnt
4307  07bb               L3222:
4308                     ; 870 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4310  07bb c60012        	ld	a,_pwm_u_buff_cnt
4311  07be a114          	cp	a,#20
4312  07c0 2504          	jrult	L5222
4315  07c2 35140012      	mov	_pwm_u_buff_cnt,#20
4316  07c6               L5222:
4317                     ; 871 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4319  07c6 c60012        	ld	a,_pwm_u_buff_cnt
4320  07c9 a10f          	cp	a,#15
4321  07cb 2505          	jrult	L7222
4324  07cd ce0014        	ldw	x,_pwm_u_buff_
4325  07d0 bf08          	ldw	_pwm_u,x
4326  07d2               L7222:
4327                     ; 874 	if(flags&0b00011010)					//если есть аварии
4329  07d2 b605          	ld	a,_flags
4330  07d4 a51a          	bcp	a,#26
4331  07d6 2603          	jrne	L06
4332  07d8 cc0868        	jp	L5712
4333  07db               L06:
4334                     ; 876 		pwm_u=0;								//то полный стоп
4336  07db 5f            	clrw	x
4337  07dc bf08          	ldw	_pwm_u,x
4338                     ; 877 		pwm_i=0;
4340  07de 5f            	clrw	x
4341  07df bf0a          	ldw	_pwm_i,x
4342  07e1 ac680868      	jpf	L5712
4343  07e5               L7022:
4344                     ; 881 else	if(link==ON)				//если есть связьvol_i_temp_avar
4346  07e5 b66d          	ld	a,_link
4347  07e7 a155          	cp	a,#85
4348  07e9 267d          	jrne	L5712
4349                     ; 883 	if((flags&0b00100000)==0)	//если нет блокировки извне
4351  07eb b605          	ld	a,_flags
4352  07ed a520          	bcp	a,#32
4353  07ef 266b          	jrne	L7322
4354                     ; 885 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4356  07f1 b605          	ld	a,_flags
4357  07f3 a51a          	bcp	a,#26
4358  07f5 260b          	jrne	L1422
4359                     ; 887 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4361  07f7 be60          	ldw	x,_vol_i_temp
4362  07f9 bf08          	ldw	_pwm_u,x
4363                     ; 888 			pwm_i=2000;
4365  07fb ae07d0        	ldw	x,#2000
4366  07fe bf0a          	ldw	_pwm_i,x
4368  0800 2066          	jra	L5712
4369  0802               L1422:
4370                     ; 890 		else if(flags&0b00011010)					//если есть аварии
4372  0802 b605          	ld	a,_flags
4373  0804 a51a          	bcp	a,#26
4374  0806 2708          	jreq	L5422
4375                     ; 892 			pwm_u=0;								//то полный стоп
4377  0808 5f            	clrw	x
4378  0809 bf08          	ldw	_pwm_u,x
4379                     ; 893 			pwm_i=0;
4381  080b 5f            	clrw	x
4382  080c bf0a          	ldw	_pwm_i,x
4384  080e 2058          	jra	L5712
4385  0810               L5422:
4386                     ; 898 			if(vol_i_temp==2000)
4388  0810 be60          	ldw	x,_vol_i_temp
4389  0812 a307d0        	cpw	x,#2000
4390  0815 260c          	jrne	L1522
4391                     ; 900 				pwm_u=2000;
4393  0817 ae07d0        	ldw	x,#2000
4394  081a bf08          	ldw	_pwm_u,x
4395                     ; 901 				pwm_i=2000;
4397  081c ae07d0        	ldw	x,#2000
4398  081f bf0a          	ldw	_pwm_i,x
4400  0821 201d          	jra	L3522
4401  0823               L1522:
4402                     ; 906 				tempI=(int)(Ui-Unecc);
4404  0823 ce000c        	ldw	x,_Ui
4405  0826 72b0000a      	subw	x,_Unecc
4406  082a 1f04          	ldw	(OFST-1,sp),x
4407                     ; 907 				if((tempI>20)||(tempI<-80))pwm_u_cnt=19;
4409  082c 9c            	rvf
4410  082d 1e04          	ldw	x,(OFST-1,sp)
4411  082f a30015        	cpw	x,#21
4412  0832 2e08          	jrsge	L7522
4414  0834 9c            	rvf
4415  0835 1e04          	ldw	x,(OFST-1,sp)
4416  0837 a3ffb0        	cpw	x,#65456
4417  083a 2e04          	jrsge	L3522
4418  083c               L7522:
4421  083c 35130007      	mov	_pwm_u_cnt,#19
4422  0840               L3522:
4423                     ; 911 			if(pwm_u_cnt)
4425  0840 3d07          	tnz	_pwm_u_cnt
4426  0842 2724          	jreq	L5712
4427                     ; 913 				pwm_u_cnt--;
4429  0844 3a07          	dec	_pwm_u_cnt
4430                     ; 914 				pwm_u=(short)((2000L*((long)Unecc))/650L);
4432  0846 ce000a        	ldw	x,_Unecc
4433  0849 90ae07d0      	ldw	y,#2000
4434  084d cd0000        	call	c_vmul
4436  0850 ae0018        	ldw	x,#L45
4437  0853 cd0000        	call	c_ldiv
4439  0856 be02          	ldw	x,c_lreg+2
4440  0858 bf08          	ldw	_pwm_u,x
4441  085a 200c          	jra	L5712
4442  085c               L7322:
4443                     ; 918 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4445  085c b605          	ld	a,_flags
4446  085e a520          	bcp	a,#32
4447  0860 2706          	jreq	L5712
4448                     ; 920 		pwm_u=0;
4450  0862 5f            	clrw	x
4451  0863 bf08          	ldw	_pwm_u,x
4452                     ; 921 		pwm_i=0;
4454  0865 5f            	clrw	x
4455  0866 bf0a          	ldw	_pwm_i,x
4456  0868               L5712:
4457                     ; 949 if(pwm_u>2000)pwm_u=2000;
4459  0868 9c            	rvf
4460  0869 be08          	ldw	x,_pwm_u
4461  086b a307d1        	cpw	x,#2001
4462  086e 2f05          	jrslt	L7622
4465  0870 ae07d0        	ldw	x,#2000
4466  0873 bf08          	ldw	_pwm_u,x
4467  0875               L7622:
4468                     ; 950 if(pwm_i>2000)pwm_i=2000;
4470  0875 9c            	rvf
4471  0876 be0a          	ldw	x,_pwm_i
4472  0878 a307d1        	cpw	x,#2001
4473  087b 2f05          	jrslt	L1722
4476  087d ae07d0        	ldw	x,#2000
4477  0880 bf0a          	ldw	_pwm_i,x
4478  0882               L1722:
4479                     ; 953 }
4482  0882 5b05          	addw	sp,#5
4483  0884 81            	ret
4536                     	switch	.const
4537  001c               L46:
4538  001c 00000258      	dc.l	600
4539  0020               L66:
4540  0020 000003e8      	dc.l	1000
4541  0024               L07:
4542  0024 00000708      	dc.l	1800
4543                     ; 956 void matemat(void)
4543                     ; 957 {
4544                     	switch	.text
4545  0885               _matemat:
4547  0885 5208          	subw	sp,#8
4548       00000008      OFST:	set	8
4551                     ; 981 I=adc_buff_[4];
4553  0887 ce0107        	ldw	x,_adc_buff_+8
4554  088a cf0010        	ldw	_I,x
4555                     ; 982 temp_SL=adc_buff_[4];
4557  088d ce0107        	ldw	x,_adc_buff_+8
4558  0890 cd0000        	call	c_itolx
4560  0893 96            	ldw	x,sp
4561  0894 1c0005        	addw	x,#OFST-3
4562  0897 cd0000        	call	c_rtol
4564                     ; 983 temp_SL-=ee_K[0][0];
4566  089a ce001a        	ldw	x,_ee_K
4567  089d cd0000        	call	c_itolx
4569  08a0 96            	ldw	x,sp
4570  08a1 1c0005        	addw	x,#OFST-3
4571  08a4 cd0000        	call	c_lgsub
4573                     ; 984 if(temp_SL<0) temp_SL=0;
4575  08a7 9c            	rvf
4576  08a8 0d05          	tnz	(OFST-3,sp)
4577  08aa 2e0a          	jrsge	L1132
4580  08ac ae0000        	ldw	x,#0
4581  08af 1f07          	ldw	(OFST-1,sp),x
4582  08b1 ae0000        	ldw	x,#0
4583  08b4 1f05          	ldw	(OFST-3,sp),x
4584  08b6               L1132:
4585                     ; 985 temp_SL*=ee_K[0][1];
4587  08b6 ce001c        	ldw	x,_ee_K+2
4588  08b9 cd0000        	call	c_itolx
4590  08bc 96            	ldw	x,sp
4591  08bd 1c0005        	addw	x,#OFST-3
4592  08c0 cd0000        	call	c_lgmul
4594                     ; 986 temp_SL/=600;
4596  08c3 96            	ldw	x,sp
4597  08c4 1c0005        	addw	x,#OFST-3
4598  08c7 cd0000        	call	c_ltor
4600  08ca ae001c        	ldw	x,#L46
4601  08cd cd0000        	call	c_ldiv
4603  08d0 96            	ldw	x,sp
4604  08d1 1c0005        	addw	x,#OFST-3
4605  08d4 cd0000        	call	c_rtol
4607                     ; 987 I=(signed short)temp_SL;
4609  08d7 1e07          	ldw	x,(OFST-1,sp)
4610  08d9 cf0010        	ldw	_I,x
4611                     ; 990 temp_SL=(signed long)adc_buff_[1];//1;
4613  08dc ce0101        	ldw	x,_adc_buff_+2
4614  08df cd0000        	call	c_itolx
4616  08e2 96            	ldw	x,sp
4617  08e3 1c0005        	addw	x,#OFST-3
4618  08e6 cd0000        	call	c_rtol
4620                     ; 993 if(temp_SL<0) temp_SL=0;
4622  08e9 9c            	rvf
4623  08ea 0d05          	tnz	(OFST-3,sp)
4624  08ec 2e0a          	jrsge	L3132
4627  08ee ae0000        	ldw	x,#0
4628  08f1 1f07          	ldw	(OFST-1,sp),x
4629  08f3 ae0000        	ldw	x,#0
4630  08f6 1f05          	ldw	(OFST-3,sp),x
4631  08f8               L3132:
4632                     ; 994 temp_SL*=(signed long)ee_K[2][1];
4634  08f8 ce0024        	ldw	x,_ee_K+10
4635  08fb cd0000        	call	c_itolx
4637  08fe 96            	ldw	x,sp
4638  08ff 1c0005        	addw	x,#OFST-3
4639  0902 cd0000        	call	c_lgmul
4641                     ; 995 temp_SL/=1000L;
4643  0905 96            	ldw	x,sp
4644  0906 1c0005        	addw	x,#OFST-3
4645  0909 cd0000        	call	c_ltor
4647  090c ae0020        	ldw	x,#L66
4648  090f cd0000        	call	c_ldiv
4650  0912 96            	ldw	x,sp
4651  0913 1c0005        	addw	x,#OFST-3
4652  0916 cd0000        	call	c_rtol
4654                     ; 996 Ui=(unsigned short)temp_SL;
4656  0919 1e07          	ldw	x,(OFST-1,sp)
4657  091b cf000c        	ldw	_Ui,x
4658                     ; 998 temp_SL=(signed long)adc_buff_5;
4660  091e ce00fd        	ldw	x,_adc_buff_5
4661  0921 cd0000        	call	c_itolx
4663  0924 96            	ldw	x,sp
4664  0925 1c0005        	addw	x,#OFST-3
4665  0928 cd0000        	call	c_rtol
4667                     ; 1000 if(temp_SL<0) temp_SL=0;
4669  092b 9c            	rvf
4670  092c 0d05          	tnz	(OFST-3,sp)
4671  092e 2e0a          	jrsge	L5132
4674  0930 ae0000        	ldw	x,#0
4675  0933 1f07          	ldw	(OFST-1,sp),x
4676  0935 ae0000        	ldw	x,#0
4677  0938 1f05          	ldw	(OFST-3,sp),x
4678  093a               L5132:
4679                     ; 1001 temp_SL*=(signed long)ee_K[4][1];
4681  093a ce002c        	ldw	x,_ee_K+18
4682  093d cd0000        	call	c_itolx
4684  0940 96            	ldw	x,sp
4685  0941 1c0005        	addw	x,#OFST-3
4686  0944 cd0000        	call	c_lgmul
4688                     ; 1002 temp_SL/=1000L;
4690  0947 96            	ldw	x,sp
4691  0948 1c0005        	addw	x,#OFST-3
4692  094b cd0000        	call	c_ltor
4694  094e ae0020        	ldw	x,#L66
4695  0951 cd0000        	call	c_ldiv
4697  0954 96            	ldw	x,sp
4698  0955 1c0005        	addw	x,#OFST-3
4699  0958 cd0000        	call	c_rtol
4701                     ; 1003 Usum=(unsigned short)temp_SL;
4703  095b 1e07          	ldw	x,(OFST-1,sp)
4704  095d cf0006        	ldw	_Usum,x
4705                     ; 1007 temp_SL=adc_buff_[3];
4707  0960 ce0105        	ldw	x,_adc_buff_+6
4708  0963 cd0000        	call	c_itolx
4710  0966 96            	ldw	x,sp
4711  0967 1c0005        	addw	x,#OFST-3
4712  096a cd0000        	call	c_rtol
4714                     ; 1009 if(temp_SL<0) temp_SL=0;
4716  096d 9c            	rvf
4717  096e 0d05          	tnz	(OFST-3,sp)
4718  0970 2e0a          	jrsge	L7132
4721  0972 ae0000        	ldw	x,#0
4722  0975 1f07          	ldw	(OFST-1,sp),x
4723  0977 ae0000        	ldw	x,#0
4724  097a 1f05          	ldw	(OFST-3,sp),x
4725  097c               L7132:
4726                     ; 1010 temp_SL*=ee_K[1][1];
4728  097c ce0020        	ldw	x,_ee_K+6
4729  097f cd0000        	call	c_itolx
4731  0982 96            	ldw	x,sp
4732  0983 1c0005        	addw	x,#OFST-3
4733  0986 cd0000        	call	c_lgmul
4735                     ; 1011 temp_SL/=1800;
4737  0989 96            	ldw	x,sp
4738  098a 1c0005        	addw	x,#OFST-3
4739  098d cd0000        	call	c_ltor
4741  0990 ae0024        	ldw	x,#L07
4742  0993 cd0000        	call	c_ldiv
4744  0996 96            	ldw	x,sp
4745  0997 1c0005        	addw	x,#OFST-3
4746  099a cd0000        	call	c_rtol
4748                     ; 1012 Un=(unsigned short)temp_SL;
4750  099d 1e07          	ldw	x,(OFST-1,sp)
4751  099f cf000e        	ldw	_Un,x
4752                     ; 1017 temp_SL=adc_buff_[2];
4754  09a2 ce0103        	ldw	x,_adc_buff_+4
4755  09a5 cd0000        	call	c_itolx
4757  09a8 96            	ldw	x,sp
4758  09a9 1c0005        	addw	x,#OFST-3
4759  09ac cd0000        	call	c_rtol
4761                     ; 1018 temp_SL*=ee_K[3][1];
4763  09af ce0028        	ldw	x,_ee_K+14
4764  09b2 cd0000        	call	c_itolx
4766  09b5 96            	ldw	x,sp
4767  09b6 1c0005        	addw	x,#OFST-3
4768  09b9 cd0000        	call	c_lgmul
4770                     ; 1019 temp_SL/=1000;
4772  09bc 96            	ldw	x,sp
4773  09bd 1c0005        	addw	x,#OFST-3
4774  09c0 cd0000        	call	c_ltor
4776  09c3 ae0020        	ldw	x,#L66
4777  09c6 cd0000        	call	c_ldiv
4779  09c9 96            	ldw	x,sp
4780  09ca 1c0005        	addw	x,#OFST-3
4781  09cd cd0000        	call	c_rtol
4783                     ; 1020 T=(signed short)(temp_SL-273L);
4785  09d0 7b08          	ld	a,(OFST+0,sp)
4786  09d2 5f            	clrw	x
4787  09d3 4d            	tnz	a
4788  09d4 2a01          	jrpl	L27
4789  09d6 53            	cplw	x
4790  09d7               L27:
4791  09d7 97            	ld	xl,a
4792  09d8 1d0111        	subw	x,#273
4793  09db 01            	rrwa	x,a
4794  09dc b772          	ld	_T,a
4795  09de 02            	rlwa	x,a
4796                     ; 1021 if(T<-30)T=-30;
4798  09df 9c            	rvf
4799  09e0 b672          	ld	a,_T
4800  09e2 a1e2          	cp	a,#226
4801  09e4 2e04          	jrsge	L1232
4804  09e6 35e20072      	mov	_T,#226
4805  09ea               L1232:
4806                     ; 1022 if(T>120)T=120;
4808  09ea 9c            	rvf
4809  09eb b672          	ld	a,_T
4810  09ed a179          	cp	a,#121
4811  09ef 2f04          	jrslt	L3232
4814  09f1 35780072      	mov	_T,#120
4815  09f5               L3232:
4816                     ; 1026 Uin=Usum-Ui;
4818  09f5 ce0006        	ldw	x,_Usum
4819  09f8 72b0000c      	subw	x,_Ui
4820  09fc cf0004        	ldw	_Uin,x
4821                     ; 1027 if(link==ON)
4823  09ff b66d          	ld	a,_link
4824  0a01 a155          	cp	a,#85
4825  0a03 260c          	jrne	L5232
4826                     ; 1029 	Unecc=U_out_const-Uin;
4828  0a05 ce0008        	ldw	x,_U_out_const
4829  0a08 72b00004      	subw	x,_Uin
4830  0a0c cf000a        	ldw	_Unecc,x
4832  0a0f 200a          	jra	L7232
4833  0a11               L5232:
4834                     ; 1038 else Unecc=ee_UAVT-Uin;
4836  0a11 ce000c        	ldw	x,_ee_UAVT
4837  0a14 72b00004      	subw	x,_Uin
4838  0a18 cf000a        	ldw	_Unecc,x
4839  0a1b               L7232:
4840                     ; 1046 if(Unecc<0)Unecc=0;
4842  0a1b 9c            	rvf
4843  0a1c ce000a        	ldw	x,_Unecc
4844  0a1f 2e04          	jrsge	L1332
4847  0a21 5f            	clrw	x
4848  0a22 cf000a        	ldw	_Unecc,x
4849  0a25               L1332:
4850                     ; 1047 temp_SL=(signed long)(T-ee_tsign);
4852  0a25 5f            	clrw	x
4853  0a26 b672          	ld	a,_T
4854  0a28 2a01          	jrpl	L47
4855  0a2a 53            	cplw	x
4856  0a2b               L47:
4857  0a2b 97            	ld	xl,a
4858  0a2c 72b0000e      	subw	x,_ee_tsign
4859  0a30 cd0000        	call	c_itolx
4861  0a33 96            	ldw	x,sp
4862  0a34 1c0005        	addw	x,#OFST-3
4863  0a37 cd0000        	call	c_rtol
4865                     ; 1048 temp_SL*=1000L;
4867  0a3a ae03e8        	ldw	x,#1000
4868  0a3d bf02          	ldw	c_lreg+2,x
4869  0a3f ae0000        	ldw	x,#0
4870  0a42 bf00          	ldw	c_lreg,x
4871  0a44 96            	ldw	x,sp
4872  0a45 1c0005        	addw	x,#OFST-3
4873  0a48 cd0000        	call	c_lgmul
4875                     ; 1049 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4877  0a4b ce0010        	ldw	x,_ee_tmax
4878  0a4e 72b0000e      	subw	x,_ee_tsign
4879  0a52 cd0000        	call	c_itolx
4881  0a55 96            	ldw	x,sp
4882  0a56 1c0001        	addw	x,#OFST-7
4883  0a59 cd0000        	call	c_rtol
4885  0a5c 96            	ldw	x,sp
4886  0a5d 1c0005        	addw	x,#OFST-3
4887  0a60 cd0000        	call	c_ltor
4889  0a63 96            	ldw	x,sp
4890  0a64 1c0001        	addw	x,#OFST-7
4891  0a67 cd0000        	call	c_ldiv
4893  0a6a 96            	ldw	x,sp
4894  0a6b 1c0005        	addw	x,#OFST-3
4895  0a6e cd0000        	call	c_rtol
4897                     ; 1051 vol_i_temp_avar=(unsigned short)temp_SL; 
4899  0a71 1e07          	ldw	x,(OFST-1,sp)
4900  0a73 bf06          	ldw	_vol_i_temp_avar,x
4901                     ; 1053 debug_info_to_uku[0]=pwm_u;
4903  0a75 be08          	ldw	x,_pwm_u
4904  0a77 bf01          	ldw	_debug_info_to_uku,x
4905                     ; 1054 debug_info_to_uku[1]=vol_i_temp;
4907  0a79 be60          	ldw	x,_vol_i_temp
4908  0a7b bf03          	ldw	_debug_info_to_uku+2,x
4909                     ; 1056 }
4912  0a7d 5b08          	addw	sp,#8
4913  0a7f 81            	ret
4944                     ; 1059 void temper_drv(void)		//1 Hz
4944                     ; 1060 {
4945                     	switch	.text
4946  0a80               _temper_drv:
4950                     ; 1062 if(T>ee_tsign) tsign_cnt++;
4952  0a80 9c            	rvf
4953  0a81 5f            	clrw	x
4954  0a82 b672          	ld	a,_T
4955  0a84 2a01          	jrpl	L001
4956  0a86 53            	cplw	x
4957  0a87               L001:
4958  0a87 97            	ld	xl,a
4959  0a88 c3000e        	cpw	x,_ee_tsign
4960  0a8b 2d09          	jrsle	L3432
4963  0a8d be59          	ldw	x,_tsign_cnt
4964  0a8f 1c0001        	addw	x,#1
4965  0a92 bf59          	ldw	_tsign_cnt,x
4967  0a94 201d          	jra	L5432
4968  0a96               L3432:
4969                     ; 1063 else if (T<(ee_tsign-1)) tsign_cnt--;
4971  0a96 9c            	rvf
4972  0a97 ce000e        	ldw	x,_ee_tsign
4973  0a9a 5a            	decw	x
4974  0a9b 905f          	clrw	y
4975  0a9d b672          	ld	a,_T
4976  0a9f 2a02          	jrpl	L201
4977  0aa1 9053          	cplw	y
4978  0aa3               L201:
4979  0aa3 9097          	ld	yl,a
4980  0aa5 90bf00        	ldw	c_y,y
4981  0aa8 b300          	cpw	x,c_y
4982  0aaa 2d07          	jrsle	L5432
4985  0aac be59          	ldw	x,_tsign_cnt
4986  0aae 1d0001        	subw	x,#1
4987  0ab1 bf59          	ldw	_tsign_cnt,x
4988  0ab3               L5432:
4989                     ; 1065 gran(&tsign_cnt,0,60);
4991  0ab3 ae003c        	ldw	x,#60
4992  0ab6 89            	pushw	x
4993  0ab7 5f            	clrw	x
4994  0ab8 89            	pushw	x
4995  0ab9 ae0059        	ldw	x,#_tsign_cnt
4996  0abc cd00d5        	call	_gran
4998  0abf 5b04          	addw	sp,#4
4999                     ; 1067 if(tsign_cnt>=55)
5001  0ac1 9c            	rvf
5002  0ac2 be59          	ldw	x,_tsign_cnt
5003  0ac4 a30037        	cpw	x,#55
5004  0ac7 2f16          	jrslt	L1532
5005                     ; 1069 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5007  0ac9 3d54          	tnz	_jp_mode
5008  0acb 2606          	jrne	L7532
5010  0acd b605          	ld	a,_flags
5011  0acf a540          	bcp	a,#64
5012  0ad1 2706          	jreq	L5532
5013  0ad3               L7532:
5015  0ad3 b654          	ld	a,_jp_mode
5016  0ad5 a103          	cp	a,#3
5017  0ad7 2612          	jrne	L1632
5018  0ad9               L5532:
5021  0ad9 72140005      	bset	_flags,#2
5022  0add 200c          	jra	L1632
5023  0adf               L1532:
5024                     ; 1071 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5026  0adf 9c            	rvf
5027  0ae0 be59          	ldw	x,_tsign_cnt
5028  0ae2 a30006        	cpw	x,#6
5029  0ae5 2e04          	jrsge	L1632
5032  0ae7 72150005      	bres	_flags,#2
5033  0aeb               L1632:
5034                     ; 1076 if(T>ee_tmax) tmax_cnt++;
5036  0aeb 9c            	rvf
5037  0aec 5f            	clrw	x
5038  0aed b672          	ld	a,_T
5039  0aef 2a01          	jrpl	L401
5040  0af1 53            	cplw	x
5041  0af2               L401:
5042  0af2 97            	ld	xl,a
5043  0af3 c30010        	cpw	x,_ee_tmax
5044  0af6 2d09          	jrsle	L5632
5047  0af8 be57          	ldw	x,_tmax_cnt
5048  0afa 1c0001        	addw	x,#1
5049  0afd bf57          	ldw	_tmax_cnt,x
5051  0aff 201d          	jra	L7632
5052  0b01               L5632:
5053                     ; 1077 else if (T<(ee_tmax-1)) tmax_cnt--;
5055  0b01 9c            	rvf
5056  0b02 ce0010        	ldw	x,_ee_tmax
5057  0b05 5a            	decw	x
5058  0b06 905f          	clrw	y
5059  0b08 b672          	ld	a,_T
5060  0b0a 2a02          	jrpl	L601
5061  0b0c 9053          	cplw	y
5062  0b0e               L601:
5063  0b0e 9097          	ld	yl,a
5064  0b10 90bf00        	ldw	c_y,y
5065  0b13 b300          	cpw	x,c_y
5066  0b15 2d07          	jrsle	L7632
5069  0b17 be57          	ldw	x,_tmax_cnt
5070  0b19 1d0001        	subw	x,#1
5071  0b1c bf57          	ldw	_tmax_cnt,x
5072  0b1e               L7632:
5073                     ; 1079 gran(&tmax_cnt,0,60);
5075  0b1e ae003c        	ldw	x,#60
5076  0b21 89            	pushw	x
5077  0b22 5f            	clrw	x
5078  0b23 89            	pushw	x
5079  0b24 ae0057        	ldw	x,#_tmax_cnt
5080  0b27 cd00d5        	call	_gran
5082  0b2a 5b04          	addw	sp,#4
5083                     ; 1081 if(tmax_cnt>=55)
5085  0b2c 9c            	rvf
5086  0b2d be57          	ldw	x,_tmax_cnt
5087  0b2f a30037        	cpw	x,#55
5088  0b32 2f16          	jrslt	L3732
5089                     ; 1083 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5091  0b34 3d54          	tnz	_jp_mode
5092  0b36 2606          	jrne	L1042
5094  0b38 b605          	ld	a,_flags
5095  0b3a a540          	bcp	a,#64
5096  0b3c 2706          	jreq	L7732
5097  0b3e               L1042:
5099  0b3e b654          	ld	a,_jp_mode
5100  0b40 a103          	cp	a,#3
5101  0b42 2612          	jrne	L3042
5102  0b44               L7732:
5105  0b44 72120005      	bset	_flags,#1
5106  0b48 200c          	jra	L3042
5107  0b4a               L3732:
5108                     ; 1085 else if (tmax_cnt<=5) flags&=0b11111101;
5110  0b4a 9c            	rvf
5111  0b4b be57          	ldw	x,_tmax_cnt
5112  0b4d a30006        	cpw	x,#6
5113  0b50 2e04          	jrsge	L3042
5116  0b52 72130005      	bres	_flags,#1
5117  0b56               L3042:
5118                     ; 1088 } 
5121  0b56 81            	ret
5153                     ; 1091 void u_drv(void)		//1Hz
5153                     ; 1092 { 
5154                     	switch	.text
5155  0b57               _u_drv:
5159                     ; 1093 if(jp_mode!=jp3)
5161  0b57 b654          	ld	a,_jp_mode
5162  0b59 a103          	cp	a,#3
5163  0b5b 2774          	jreq	L7142
5164                     ; 1095 	if(Ui>ee_Umax)umax_cnt++;
5166  0b5d 9c            	rvf
5167  0b5e ce000c        	ldw	x,_Ui
5168  0b61 c30014        	cpw	x,_ee_Umax
5169  0b64 2d09          	jrsle	L1242
5172  0b66 be70          	ldw	x,_umax_cnt
5173  0b68 1c0001        	addw	x,#1
5174  0b6b bf70          	ldw	_umax_cnt,x
5176  0b6d 2003          	jra	L3242
5177  0b6f               L1242:
5178                     ; 1096 	else umax_cnt=0;
5180  0b6f 5f            	clrw	x
5181  0b70 bf70          	ldw	_umax_cnt,x
5182  0b72               L3242:
5183                     ; 1097 	gran(&umax_cnt,0,10);
5185  0b72 ae000a        	ldw	x,#10
5186  0b75 89            	pushw	x
5187  0b76 5f            	clrw	x
5188  0b77 89            	pushw	x
5189  0b78 ae0070        	ldw	x,#_umax_cnt
5190  0b7b cd00d5        	call	_gran
5192  0b7e 5b04          	addw	sp,#4
5193                     ; 1098 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5195  0b80 9c            	rvf
5196  0b81 be70          	ldw	x,_umax_cnt
5197  0b83 a3000a        	cpw	x,#10
5198  0b86 2f04          	jrslt	L5242
5201  0b88 72160005      	bset	_flags,#3
5202  0b8c               L5242:
5203                     ; 1101 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5205  0b8c 9c            	rvf
5206  0b8d ce000c        	ldw	x,_Ui
5207  0b90 c3000e        	cpw	x,_Un
5208  0b93 2e1d          	jrsge	L7242
5210  0b95 9c            	rvf
5211  0b96 ce000e        	ldw	x,_Un
5212  0b99 72b0000c      	subw	x,_Ui
5213  0b9d c30012        	cpw	x,_ee_dU
5214  0ba0 2d10          	jrsle	L7242
5216  0ba2 c65005        	ld	a,20485
5217  0ba5 a504          	bcp	a,#4
5218  0ba7 2609          	jrne	L7242
5221  0ba9 be6e          	ldw	x,_umin_cnt
5222  0bab 1c0001        	addw	x,#1
5223  0bae bf6e          	ldw	_umin_cnt,x
5225  0bb0 2003          	jra	L1342
5226  0bb2               L7242:
5227                     ; 1102 	else umin_cnt=0;
5229  0bb2 5f            	clrw	x
5230  0bb3 bf6e          	ldw	_umin_cnt,x
5231  0bb5               L1342:
5232                     ; 1103 	gran(&umin_cnt,0,10);	
5234  0bb5 ae000a        	ldw	x,#10
5235  0bb8 89            	pushw	x
5236  0bb9 5f            	clrw	x
5237  0bba 89            	pushw	x
5238  0bbb ae006e        	ldw	x,#_umin_cnt
5239  0bbe cd00d5        	call	_gran
5241  0bc1 5b04          	addw	sp,#4
5242                     ; 1104 	if(umin_cnt>=10)flags|=0b00010000;	  
5244  0bc3 9c            	rvf
5245  0bc4 be6e          	ldw	x,_umin_cnt
5246  0bc6 a3000a        	cpw	x,#10
5247  0bc9 2f71          	jrslt	L5342
5250  0bcb 72180005      	bset	_flags,#4
5251  0bcf 206b          	jra	L5342
5252  0bd1               L7142:
5253                     ; 1106 else if(jp_mode==jp3)
5255  0bd1 b654          	ld	a,_jp_mode
5256  0bd3 a103          	cp	a,#3
5257  0bd5 2665          	jrne	L5342
5258                     ; 1108 	if(Ui>700)umax_cnt++;
5260  0bd7 9c            	rvf
5261  0bd8 ce000c        	ldw	x,_Ui
5262  0bdb a302bd        	cpw	x,#701
5263  0bde 2f09          	jrslt	L1442
5266  0be0 be70          	ldw	x,_umax_cnt
5267  0be2 1c0001        	addw	x,#1
5268  0be5 bf70          	ldw	_umax_cnt,x
5270  0be7 2003          	jra	L3442
5271  0be9               L1442:
5272                     ; 1109 	else umax_cnt=0;
5274  0be9 5f            	clrw	x
5275  0bea bf70          	ldw	_umax_cnt,x
5276  0bec               L3442:
5277                     ; 1110 	gran(&umax_cnt,0,10);
5279  0bec ae000a        	ldw	x,#10
5280  0bef 89            	pushw	x
5281  0bf0 5f            	clrw	x
5282  0bf1 89            	pushw	x
5283  0bf2 ae0070        	ldw	x,#_umax_cnt
5284  0bf5 cd00d5        	call	_gran
5286  0bf8 5b04          	addw	sp,#4
5287                     ; 1111 	if(umax_cnt>=10)flags|=0b00001000;
5289  0bfa 9c            	rvf
5290  0bfb be70          	ldw	x,_umax_cnt
5291  0bfd a3000a        	cpw	x,#10
5292  0c00 2f04          	jrslt	L5442
5295  0c02 72160005      	bset	_flags,#3
5296  0c06               L5442:
5297                     ; 1114 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5299  0c06 9c            	rvf
5300  0c07 ce000c        	ldw	x,_Ui
5301  0c0a a300c8        	cpw	x,#200
5302  0c0d 2e10          	jrsge	L7442
5304  0c0f c65005        	ld	a,20485
5305  0c12 a504          	bcp	a,#4
5306  0c14 2609          	jrne	L7442
5309  0c16 be6e          	ldw	x,_umin_cnt
5310  0c18 1c0001        	addw	x,#1
5311  0c1b bf6e          	ldw	_umin_cnt,x
5313  0c1d 2003          	jra	L1542
5314  0c1f               L7442:
5315                     ; 1115 	else umin_cnt=0;
5317  0c1f 5f            	clrw	x
5318  0c20 bf6e          	ldw	_umin_cnt,x
5319  0c22               L1542:
5320                     ; 1116 	gran(&umin_cnt,0,10);	
5322  0c22 ae000a        	ldw	x,#10
5323  0c25 89            	pushw	x
5324  0c26 5f            	clrw	x
5325  0c27 89            	pushw	x
5326  0c28 ae006e        	ldw	x,#_umin_cnt
5327  0c2b cd00d5        	call	_gran
5329  0c2e 5b04          	addw	sp,#4
5330                     ; 1117 	if(umin_cnt>=10)flags|=0b00010000;	  
5332  0c30 9c            	rvf
5333  0c31 be6e          	ldw	x,_umin_cnt
5334  0c33 a3000a        	cpw	x,#10
5335  0c36 2f04          	jrslt	L5342
5338  0c38 72180005      	bset	_flags,#4
5339  0c3c               L5342:
5340                     ; 1119 }
5343  0c3c 81            	ret
5369                     ; 1144 void apv_start(void)
5369                     ; 1145 {
5370                     	switch	.text
5371  0c3d               _apv_start:
5375                     ; 1146 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5377  0c3d 3d4f          	tnz	_apv_cnt
5378  0c3f 2624          	jrne	L5642
5380  0c41 3d50          	tnz	_apv_cnt+1
5381  0c43 2620          	jrne	L5642
5383  0c45 3d51          	tnz	_apv_cnt+2
5384  0c47 261c          	jrne	L5642
5386                     	btst	_bAPV
5387  0c4e 2515          	jrult	L5642
5388                     ; 1148 	apv_cnt[0]=60;
5390  0c50 353c004f      	mov	_apv_cnt,#60
5391                     ; 1149 	apv_cnt[1]=60;
5393  0c54 353c0050      	mov	_apv_cnt+1,#60
5394                     ; 1150 	apv_cnt[2]=60;
5396  0c58 353c0051      	mov	_apv_cnt+2,#60
5397                     ; 1151 	apv_cnt_=3600;
5399  0c5c ae0e10        	ldw	x,#3600
5400  0c5f bf4d          	ldw	_apv_cnt_,x
5401                     ; 1152 	bAPV=1;	
5403  0c61 72100002      	bset	_bAPV
5404  0c65               L5642:
5405                     ; 1154 }
5408  0c65 81            	ret
5434                     ; 1157 void apv_stop(void)
5434                     ; 1158 {
5435                     	switch	.text
5436  0c66               _apv_stop:
5440                     ; 1159 apv_cnt[0]=0;
5442  0c66 3f4f          	clr	_apv_cnt
5443                     ; 1160 apv_cnt[1]=0;
5445  0c68 3f50          	clr	_apv_cnt+1
5446                     ; 1161 apv_cnt[2]=0;
5448  0c6a 3f51          	clr	_apv_cnt+2
5449                     ; 1162 apv_cnt_=0;	
5451  0c6c 5f            	clrw	x
5452  0c6d bf4d          	ldw	_apv_cnt_,x
5453                     ; 1163 bAPV=0;
5455  0c6f 72110002      	bres	_bAPV
5456                     ; 1164 }
5459  0c73 81            	ret
5494                     ; 1168 void apv_hndl(void)
5494                     ; 1169 {
5495                     	switch	.text
5496  0c74               _apv_hndl:
5500                     ; 1170 if(apv_cnt[0])
5502  0c74 3d4f          	tnz	_apv_cnt
5503  0c76 271e          	jreq	L7052
5504                     ; 1172 	apv_cnt[0]--;
5506  0c78 3a4f          	dec	_apv_cnt
5507                     ; 1173 	if(apv_cnt[0]==0)
5509  0c7a 3d4f          	tnz	_apv_cnt
5510  0c7c 265a          	jrne	L3152
5511                     ; 1175 		flags&=0b11100001;
5513  0c7e b605          	ld	a,_flags
5514  0c80 a4e1          	and	a,#225
5515  0c82 b705          	ld	_flags,a
5516                     ; 1176 		tsign_cnt=0;
5518  0c84 5f            	clrw	x
5519  0c85 bf59          	ldw	_tsign_cnt,x
5520                     ; 1177 		tmax_cnt=0;
5522  0c87 5f            	clrw	x
5523  0c88 bf57          	ldw	_tmax_cnt,x
5524                     ; 1178 		umax_cnt=0;
5526  0c8a 5f            	clrw	x
5527  0c8b bf70          	ldw	_umax_cnt,x
5528                     ; 1179 		umin_cnt=0;
5530  0c8d 5f            	clrw	x
5531  0c8e bf6e          	ldw	_umin_cnt,x
5532                     ; 1181 		led_drv_cnt=30;
5534  0c90 351e0016      	mov	_led_drv_cnt,#30
5535  0c94 2042          	jra	L3152
5536  0c96               L7052:
5537                     ; 1184 else if(apv_cnt[1])
5539  0c96 3d50          	tnz	_apv_cnt+1
5540  0c98 271e          	jreq	L5152
5541                     ; 1186 	apv_cnt[1]--;
5543  0c9a 3a50          	dec	_apv_cnt+1
5544                     ; 1187 	if(apv_cnt[1]==0)
5546  0c9c 3d50          	tnz	_apv_cnt+1
5547  0c9e 2638          	jrne	L3152
5548                     ; 1189 		flags&=0b11100001;
5550  0ca0 b605          	ld	a,_flags
5551  0ca2 a4e1          	and	a,#225
5552  0ca4 b705          	ld	_flags,a
5553                     ; 1190 		tsign_cnt=0;
5555  0ca6 5f            	clrw	x
5556  0ca7 bf59          	ldw	_tsign_cnt,x
5557                     ; 1191 		tmax_cnt=0;
5559  0ca9 5f            	clrw	x
5560  0caa bf57          	ldw	_tmax_cnt,x
5561                     ; 1192 		umax_cnt=0;
5563  0cac 5f            	clrw	x
5564  0cad bf70          	ldw	_umax_cnt,x
5565                     ; 1193 		umin_cnt=0;
5567  0caf 5f            	clrw	x
5568  0cb0 bf6e          	ldw	_umin_cnt,x
5569                     ; 1195 		led_drv_cnt=30;
5571  0cb2 351e0016      	mov	_led_drv_cnt,#30
5572  0cb6 2020          	jra	L3152
5573  0cb8               L5152:
5574                     ; 1198 else if(apv_cnt[2])
5576  0cb8 3d51          	tnz	_apv_cnt+2
5577  0cba 271c          	jreq	L3152
5578                     ; 1200 	apv_cnt[2]--;
5580  0cbc 3a51          	dec	_apv_cnt+2
5581                     ; 1201 	if(apv_cnt[2]==0)
5583  0cbe 3d51          	tnz	_apv_cnt+2
5584  0cc0 2616          	jrne	L3152
5585                     ; 1203 		flags&=0b11100001;
5587  0cc2 b605          	ld	a,_flags
5588  0cc4 a4e1          	and	a,#225
5589  0cc6 b705          	ld	_flags,a
5590                     ; 1204 		tsign_cnt=0;
5592  0cc8 5f            	clrw	x
5593  0cc9 bf59          	ldw	_tsign_cnt,x
5594                     ; 1205 		tmax_cnt=0;
5596  0ccb 5f            	clrw	x
5597  0ccc bf57          	ldw	_tmax_cnt,x
5598                     ; 1206 		umax_cnt=0;
5600  0cce 5f            	clrw	x
5601  0ccf bf70          	ldw	_umax_cnt,x
5602                     ; 1207 		umin_cnt=0;          
5604  0cd1 5f            	clrw	x
5605  0cd2 bf6e          	ldw	_umin_cnt,x
5606                     ; 1209 		led_drv_cnt=30;
5608  0cd4 351e0016      	mov	_led_drv_cnt,#30
5609  0cd8               L3152:
5610                     ; 1213 if(apv_cnt_)
5612  0cd8 be4d          	ldw	x,_apv_cnt_
5613  0cda 2712          	jreq	L7252
5614                     ; 1215 	apv_cnt_--;
5616  0cdc be4d          	ldw	x,_apv_cnt_
5617  0cde 1d0001        	subw	x,#1
5618  0ce1 bf4d          	ldw	_apv_cnt_,x
5619                     ; 1216 	if(apv_cnt_==0) 
5621  0ce3 be4d          	ldw	x,_apv_cnt_
5622  0ce5 2607          	jrne	L7252
5623                     ; 1218 		bAPV=0;
5625  0ce7 72110002      	bres	_bAPV
5626                     ; 1219 		apv_start();
5628  0ceb cd0c3d        	call	_apv_start
5630  0cee               L7252:
5631                     ; 1223 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5633  0cee be6e          	ldw	x,_umin_cnt
5634  0cf0 261e          	jrne	L3352
5636  0cf2 be70          	ldw	x,_umax_cnt
5637  0cf4 261a          	jrne	L3352
5639  0cf6 c65005        	ld	a,20485
5640  0cf9 a504          	bcp	a,#4
5641  0cfb 2613          	jrne	L3352
5642                     ; 1225 	if(cnt_apv_off<20)
5644  0cfd b64c          	ld	a,_cnt_apv_off
5645  0cff a114          	cp	a,#20
5646  0d01 240f          	jruge	L1452
5647                     ; 1227 		cnt_apv_off++;
5649  0d03 3c4c          	inc	_cnt_apv_off
5650                     ; 1228 		if(cnt_apv_off>=20)
5652  0d05 b64c          	ld	a,_cnt_apv_off
5653  0d07 a114          	cp	a,#20
5654  0d09 2507          	jrult	L1452
5655                     ; 1230 			apv_stop();
5657  0d0b cd0c66        	call	_apv_stop
5659  0d0e 2002          	jra	L1452
5660  0d10               L3352:
5661                     ; 1234 else cnt_apv_off=0;	
5663  0d10 3f4c          	clr	_cnt_apv_off
5664  0d12               L1452:
5665                     ; 1236 }
5668  0d12 81            	ret
5671                     	switch	.ubsct
5672  0000               L3452_flags_old:
5673  0000 00            	ds.b	1
5709                     ; 1239 void flags_drv(void)
5709                     ; 1240 {
5710                     	switch	.text
5711  0d13               _flags_drv:
5715                     ; 1242 if(jp_mode!=jp3) 
5717  0d13 b654          	ld	a,_jp_mode
5718  0d15 a103          	cp	a,#3
5719  0d17 2723          	jreq	L3652
5720                     ; 1244 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5722  0d19 b605          	ld	a,_flags
5723  0d1b a508          	bcp	a,#8
5724  0d1d 2706          	jreq	L1752
5726  0d1f b600          	ld	a,L3452_flags_old
5727  0d21 a508          	bcp	a,#8
5728  0d23 270c          	jreq	L7652
5729  0d25               L1752:
5731  0d25 b605          	ld	a,_flags
5732  0d27 a510          	bcp	a,#16
5733  0d29 2726          	jreq	L5752
5735  0d2b b600          	ld	a,L3452_flags_old
5736  0d2d a510          	bcp	a,#16
5737  0d2f 2620          	jrne	L5752
5738  0d31               L7652:
5739                     ; 1246     		if(link==OFF)apv_start();
5741  0d31 b66d          	ld	a,_link
5742  0d33 a1aa          	cp	a,#170
5743  0d35 261a          	jrne	L5752
5746  0d37 cd0c3d        	call	_apv_start
5748  0d3a 2015          	jra	L5752
5749  0d3c               L3652:
5750                     ; 1249 else if(jp_mode==jp3) 
5752  0d3c b654          	ld	a,_jp_mode
5753  0d3e a103          	cp	a,#3
5754  0d40 260f          	jrne	L5752
5755                     ; 1251 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5757  0d42 b605          	ld	a,_flags
5758  0d44 a508          	bcp	a,#8
5759  0d46 2709          	jreq	L5752
5761  0d48 b600          	ld	a,L3452_flags_old
5762  0d4a a508          	bcp	a,#8
5763  0d4c 2603          	jrne	L5752
5764                     ; 1253     		apv_start();
5766  0d4e cd0c3d        	call	_apv_start
5768  0d51               L5752:
5769                     ; 1256 flags_old=flags;
5771  0d51 450500        	mov	L3452_flags_old,_flags
5772                     ; 1258 } 
5775  0d54 81            	ret
5810                     ; 1395 void adr_drv_v4(char in)
5810                     ; 1396 {
5811                     	switch	.text
5812  0d55               _adr_drv_v4:
5816                     ; 1397 if(adress!=in)adress=in;
5818  0d55 c100f7        	cp	a,_adress
5819  0d58 2703          	jreq	L1262
5822  0d5a c700f7        	ld	_adress,a
5823  0d5d               L1262:
5824                     ; 1398 }
5827  0d5d 81            	ret
5856                     ; 1401 void adr_drv_v3(void)
5856                     ; 1402 {
5857                     	switch	.text
5858  0d5e               _adr_drv_v3:
5860  0d5e 88            	push	a
5861       00000001      OFST:	set	1
5864                     ; 1408 GPIOB->DDR&=~(1<<0);
5866  0d5f 72115007      	bres	20487,#0
5867                     ; 1409 GPIOB->CR1&=~(1<<0);
5869  0d63 72115008      	bres	20488,#0
5870                     ; 1410 GPIOB->CR2&=~(1<<0);
5872  0d67 72115009      	bres	20489,#0
5873                     ; 1411 ADC2->CR2=0x08;
5875  0d6b 35085402      	mov	21506,#8
5876                     ; 1412 ADC2->CR1=0x40;
5878  0d6f 35405401      	mov	21505,#64
5879                     ; 1413 ADC2->CSR=0x20+0;
5881  0d73 35205400      	mov	21504,#32
5882                     ; 1414 ADC2->CR1|=1;
5884  0d77 72105401      	bset	21505,#0
5885                     ; 1415 ADC2->CR1|=1;
5887  0d7b 72105401      	bset	21505,#0
5888                     ; 1416 adr_drv_stat=1;
5890  0d7f 35010002      	mov	_adr_drv_stat,#1
5891  0d83               L3362:
5892                     ; 1417 while(adr_drv_stat==1);
5895  0d83 b602          	ld	a,_adr_drv_stat
5896  0d85 a101          	cp	a,#1
5897  0d87 27fa          	jreq	L3362
5898                     ; 1419 GPIOB->DDR&=~(1<<1);
5900  0d89 72135007      	bres	20487,#1
5901                     ; 1420 GPIOB->CR1&=~(1<<1);
5903  0d8d 72135008      	bres	20488,#1
5904                     ; 1421 GPIOB->CR2&=~(1<<1);
5906  0d91 72135009      	bres	20489,#1
5907                     ; 1422 ADC2->CR2=0x08;
5909  0d95 35085402      	mov	21506,#8
5910                     ; 1423 ADC2->CR1=0x40;
5912  0d99 35405401      	mov	21505,#64
5913                     ; 1424 ADC2->CSR=0x20+1;
5915  0d9d 35215400      	mov	21504,#33
5916                     ; 1425 ADC2->CR1|=1;
5918  0da1 72105401      	bset	21505,#0
5919                     ; 1426 ADC2->CR1|=1;
5921  0da5 72105401      	bset	21505,#0
5922                     ; 1427 adr_drv_stat=3;
5924  0da9 35030002      	mov	_adr_drv_stat,#3
5925  0dad               L1462:
5926                     ; 1428 while(adr_drv_stat==3);
5929  0dad b602          	ld	a,_adr_drv_stat
5930  0daf a103          	cp	a,#3
5931  0db1 27fa          	jreq	L1462
5932                     ; 1430 GPIOE->DDR&=~(1<<6);
5934  0db3 721d5016      	bres	20502,#6
5935                     ; 1431 GPIOE->CR1&=~(1<<6);
5937  0db7 721d5017      	bres	20503,#6
5938                     ; 1432 GPIOE->CR2&=~(1<<6);
5940  0dbb 721d5018      	bres	20504,#6
5941                     ; 1433 ADC2->CR2=0x08;
5943  0dbf 35085402      	mov	21506,#8
5944                     ; 1434 ADC2->CR1=0x40;
5946  0dc3 35405401      	mov	21505,#64
5947                     ; 1435 ADC2->CSR=0x20+9;
5949  0dc7 35295400      	mov	21504,#41
5950                     ; 1436 ADC2->CR1|=1;
5952  0dcb 72105401      	bset	21505,#0
5953                     ; 1437 ADC2->CR1|=1;
5955  0dcf 72105401      	bset	21505,#0
5956                     ; 1438 adr_drv_stat=5;
5958  0dd3 35050002      	mov	_adr_drv_stat,#5
5959  0dd7               L7462:
5960                     ; 1439 while(adr_drv_stat==5);
5963  0dd7 b602          	ld	a,_adr_drv_stat
5964  0dd9 a105          	cp	a,#5
5965  0ddb 27fa          	jreq	L7462
5966                     ; 1443 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5968  0ddd 9c            	rvf
5969  0dde ce00ff        	ldw	x,_adc_buff_
5970  0de1 a3022a        	cpw	x,#554
5971  0de4 2f0f          	jrslt	L5562
5973  0de6 9c            	rvf
5974  0de7 ce00ff        	ldw	x,_adc_buff_
5975  0dea a30253        	cpw	x,#595
5976  0ded 2e06          	jrsge	L5562
5979  0def 725f00f8      	clr	_adr
5981  0df3 204c          	jra	L7562
5982  0df5               L5562:
5983                     ; 1444 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5985  0df5 9c            	rvf
5986  0df6 ce00ff        	ldw	x,_adc_buff_
5987  0df9 a3036d        	cpw	x,#877
5988  0dfc 2f0f          	jrslt	L1662
5990  0dfe 9c            	rvf
5991  0dff ce00ff        	ldw	x,_adc_buff_
5992  0e02 a30396        	cpw	x,#918
5993  0e05 2e06          	jrsge	L1662
5996  0e07 350100f8      	mov	_adr,#1
5998  0e0b 2034          	jra	L7562
5999  0e0d               L1662:
6000                     ; 1445 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6002  0e0d 9c            	rvf
6003  0e0e ce00ff        	ldw	x,_adc_buff_
6004  0e11 a302a3        	cpw	x,#675
6005  0e14 2f0f          	jrslt	L5662
6007  0e16 9c            	rvf
6008  0e17 ce00ff        	ldw	x,_adc_buff_
6009  0e1a a302cc        	cpw	x,#716
6010  0e1d 2e06          	jrsge	L5662
6013  0e1f 350200f8      	mov	_adr,#2
6015  0e23 201c          	jra	L7562
6016  0e25               L5662:
6017                     ; 1446 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6019  0e25 9c            	rvf
6020  0e26 ce00ff        	ldw	x,_adc_buff_
6021  0e29 a303e3        	cpw	x,#995
6022  0e2c 2f0f          	jrslt	L1762
6024  0e2e 9c            	rvf
6025  0e2f ce00ff        	ldw	x,_adc_buff_
6026  0e32 a3040c        	cpw	x,#1036
6027  0e35 2e06          	jrsge	L1762
6030  0e37 350300f8      	mov	_adr,#3
6032  0e3b 2004          	jra	L7562
6033  0e3d               L1762:
6034                     ; 1447 else adr[0]=5;
6036  0e3d 350500f8      	mov	_adr,#5
6037  0e41               L7562:
6038                     ; 1449 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6040  0e41 9c            	rvf
6041  0e42 ce0101        	ldw	x,_adc_buff_+2
6042  0e45 a3022a        	cpw	x,#554
6043  0e48 2f0f          	jrslt	L5762
6045  0e4a 9c            	rvf
6046  0e4b ce0101        	ldw	x,_adc_buff_+2
6047  0e4e a30253        	cpw	x,#595
6048  0e51 2e06          	jrsge	L5762
6051  0e53 725f00f9      	clr	_adr+1
6053  0e57 204c          	jra	L7762
6054  0e59               L5762:
6055                     ; 1450 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6057  0e59 9c            	rvf
6058  0e5a ce0101        	ldw	x,_adc_buff_+2
6059  0e5d a3036d        	cpw	x,#877
6060  0e60 2f0f          	jrslt	L1072
6062  0e62 9c            	rvf
6063  0e63 ce0101        	ldw	x,_adc_buff_+2
6064  0e66 a30396        	cpw	x,#918
6065  0e69 2e06          	jrsge	L1072
6068  0e6b 350100f9      	mov	_adr+1,#1
6070  0e6f 2034          	jra	L7762
6071  0e71               L1072:
6072                     ; 1451 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6074  0e71 9c            	rvf
6075  0e72 ce0101        	ldw	x,_adc_buff_+2
6076  0e75 a302a3        	cpw	x,#675
6077  0e78 2f0f          	jrslt	L5072
6079  0e7a 9c            	rvf
6080  0e7b ce0101        	ldw	x,_adc_buff_+2
6081  0e7e a302cc        	cpw	x,#716
6082  0e81 2e06          	jrsge	L5072
6085  0e83 350200f9      	mov	_adr+1,#2
6087  0e87 201c          	jra	L7762
6088  0e89               L5072:
6089                     ; 1452 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6091  0e89 9c            	rvf
6092  0e8a ce0101        	ldw	x,_adc_buff_+2
6093  0e8d a303e3        	cpw	x,#995
6094  0e90 2f0f          	jrslt	L1172
6096  0e92 9c            	rvf
6097  0e93 ce0101        	ldw	x,_adc_buff_+2
6098  0e96 a3040c        	cpw	x,#1036
6099  0e99 2e06          	jrsge	L1172
6102  0e9b 350300f9      	mov	_adr+1,#3
6104  0e9f 2004          	jra	L7762
6105  0ea1               L1172:
6106                     ; 1453 else adr[1]=5;
6108  0ea1 350500f9      	mov	_adr+1,#5
6109  0ea5               L7762:
6110                     ; 1455 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6112  0ea5 9c            	rvf
6113  0ea6 ce0111        	ldw	x,_adc_buff_+18
6114  0ea9 a3022a        	cpw	x,#554
6115  0eac 2f0f          	jrslt	L5172
6117  0eae 9c            	rvf
6118  0eaf ce0111        	ldw	x,_adc_buff_+18
6119  0eb2 a30253        	cpw	x,#595
6120  0eb5 2e06          	jrsge	L5172
6123  0eb7 725f00fa      	clr	_adr+2
6125  0ebb 204c          	jra	L7172
6126  0ebd               L5172:
6127                     ; 1456 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6129  0ebd 9c            	rvf
6130  0ebe ce0111        	ldw	x,_adc_buff_+18
6131  0ec1 a3036d        	cpw	x,#877
6132  0ec4 2f0f          	jrslt	L1272
6134  0ec6 9c            	rvf
6135  0ec7 ce0111        	ldw	x,_adc_buff_+18
6136  0eca a30396        	cpw	x,#918
6137  0ecd 2e06          	jrsge	L1272
6140  0ecf 350100fa      	mov	_adr+2,#1
6142  0ed3 2034          	jra	L7172
6143  0ed5               L1272:
6144                     ; 1457 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6146  0ed5 9c            	rvf
6147  0ed6 ce0111        	ldw	x,_adc_buff_+18
6148  0ed9 a302a3        	cpw	x,#675
6149  0edc 2f0f          	jrslt	L5272
6151  0ede 9c            	rvf
6152  0edf ce0111        	ldw	x,_adc_buff_+18
6153  0ee2 a302cc        	cpw	x,#716
6154  0ee5 2e06          	jrsge	L5272
6157  0ee7 350200fa      	mov	_adr+2,#2
6159  0eeb 201c          	jra	L7172
6160  0eed               L5272:
6161                     ; 1458 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6163  0eed 9c            	rvf
6164  0eee ce0111        	ldw	x,_adc_buff_+18
6165  0ef1 a303e3        	cpw	x,#995
6166  0ef4 2f0f          	jrslt	L1372
6168  0ef6 9c            	rvf
6169  0ef7 ce0111        	ldw	x,_adc_buff_+18
6170  0efa a3040c        	cpw	x,#1036
6171  0efd 2e06          	jrsge	L1372
6174  0eff 350300fa      	mov	_adr+2,#3
6176  0f03 2004          	jra	L7172
6177  0f05               L1372:
6178                     ; 1459 else adr[2]=5;
6180  0f05 350500fa      	mov	_adr+2,#5
6181  0f09               L7172:
6182                     ; 1463 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6184  0f09 c600f8        	ld	a,_adr
6185  0f0c a105          	cp	a,#5
6186  0f0e 270e          	jreq	L7372
6188  0f10 c600f9        	ld	a,_adr+1
6189  0f13 a105          	cp	a,#5
6190  0f15 2707          	jreq	L7372
6192  0f17 c600fa        	ld	a,_adr+2
6193  0f1a a105          	cp	a,#5
6194  0f1c 2606          	jrne	L5372
6195  0f1e               L7372:
6196                     ; 1466 	adress_error=1;
6198  0f1e 350100f6      	mov	_adress_error,#1
6200  0f22               L3472:
6201                     ; 1477 }
6204  0f22 84            	pop	a
6205  0f23 81            	ret
6206  0f24               L5372:
6207                     ; 1470 	if(adr[2]&0x02) bps_class=bpsIPS;
6209  0f24 c600fa        	ld	a,_adr+2
6210  0f27 a502          	bcp	a,#2
6211  0f29 2706          	jreq	L5472
6214  0f2b 3501000b      	mov	_bps_class,#1
6216  0f2f 2002          	jra	L7472
6217  0f31               L5472:
6218                     ; 1471 	else bps_class=bpsIBEP;
6220  0f31 3f0b          	clr	_bps_class
6221  0f33               L7472:
6222                     ; 1473 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6224  0f33 c600fa        	ld	a,_adr+2
6225  0f36 a401          	and	a,#1
6226  0f38 97            	ld	xl,a
6227  0f39 a610          	ld	a,#16
6228  0f3b 42            	mul	x,a
6229  0f3c 9f            	ld	a,xl
6230  0f3d 6b01          	ld	(OFST+0,sp),a
6231  0f3f c600f9        	ld	a,_adr+1
6232  0f42 48            	sll	a
6233  0f43 48            	sll	a
6234  0f44 cb00f8        	add	a,_adr
6235  0f47 1b01          	add	a,(OFST+0,sp)
6236  0f49 c700f7        	ld	_adress,a
6237  0f4c 20d4          	jra	L3472
6260                     ; 1527 void init_CAN(void) {
6261                     	switch	.text
6262  0f4e               _init_CAN:
6266                     ; 1528 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6268  0f4e 72135420      	bres	21536,#1
6269                     ; 1529 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6271  0f52 72105420      	bset	21536,#0
6273  0f56               L3672:
6274                     ; 1530 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6276  0f56 c65421        	ld	a,21537
6277  0f59 a501          	bcp	a,#1
6278  0f5b 27f9          	jreq	L3672
6279                     ; 1532 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6281  0f5d 72185420      	bset	21536,#4
6282                     ; 1534 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6284  0f61 35025427      	mov	21543,#2
6285                     ; 1543 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6287  0f65 35135428      	mov	21544,#19
6288                     ; 1544 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6290  0f69 35c05429      	mov	21545,#192
6291                     ; 1545 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6293  0f6d 357f542c      	mov	21548,#127
6294                     ; 1546 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6296  0f71 35e0542d      	mov	21549,#224
6297                     ; 1548 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6299  0f75 35315430      	mov	21552,#49
6300                     ; 1549 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6302  0f79 35c05431      	mov	21553,#192
6303                     ; 1550 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6305  0f7d 357f5434      	mov	21556,#127
6306                     ; 1551 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6308  0f81 35e05435      	mov	21557,#224
6309                     ; 1555 	CAN->PSR= 6;									// set page 6
6311  0f85 35065427      	mov	21543,#6
6312                     ; 1560 	CAN->Page.Config.FMR1&=~3;								//mask mode
6314  0f89 c65430        	ld	a,21552
6315  0f8c a4fc          	and	a,#252
6316  0f8e c75430        	ld	21552,a
6317                     ; 1566 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6319  0f91 35065432      	mov	21554,#6
6320                     ; 1567 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6322  0f95 35605432      	mov	21554,#96
6323                     ; 1570 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6325  0f99 72105432      	bset	21554,#0
6326                     ; 1571 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6328  0f9d 72185432      	bset	21554,#4
6329                     ; 1574 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6331  0fa1 35065427      	mov	21543,#6
6332                     ; 1576 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6334  0fa5 35d3542c      	mov	21548,#211
6335                     ; 1577 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6337  0fa9 35e7542d      	mov	21549,#231
6338                     ; 1579 	CAN->IER|=(1<<1);
6340  0fad 72125425      	bset	21541,#1
6341                     ; 1582 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6343  0fb1 72115420      	bres	21536,#0
6345  0fb5               L1772:
6346                     ; 1583 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6348  0fb5 c65421        	ld	a,21537
6349  0fb8 a501          	bcp	a,#1
6350  0fba 26f9          	jrne	L1772
6351                     ; 1584 }
6354  0fbc 81            	ret
6462                     ; 1587 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6462                     ; 1588 {
6463                     	switch	.text
6464  0fbd               _can_transmit:
6466  0fbd 89            	pushw	x
6467       00000000      OFST:	set	0
6470                     ; 1590 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6472  0fbe b676          	ld	a,_can_buff_wr_ptr
6473  0fc0 a104          	cp	a,#4
6474  0fc2 2502          	jrult	L3503
6477  0fc4 3f76          	clr	_can_buff_wr_ptr
6478  0fc6               L3503:
6479                     ; 1592 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6481  0fc6 b676          	ld	a,_can_buff_wr_ptr
6482  0fc8 97            	ld	xl,a
6483  0fc9 a610          	ld	a,#16
6484  0fcb 42            	mul	x,a
6485  0fcc 1601          	ldw	y,(OFST+1,sp)
6486  0fce a606          	ld	a,#6
6487  0fd0               L231:
6488  0fd0 9054          	srlw	y
6489  0fd2 4a            	dec	a
6490  0fd3 26fb          	jrne	L231
6491  0fd5 909f          	ld	a,yl
6492  0fd7 e777          	ld	(_can_out_buff,x),a
6493                     ; 1593 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6495  0fd9 b676          	ld	a,_can_buff_wr_ptr
6496  0fdb 97            	ld	xl,a
6497  0fdc a610          	ld	a,#16
6498  0fde 42            	mul	x,a
6499  0fdf 7b02          	ld	a,(OFST+2,sp)
6500  0fe1 48            	sll	a
6501  0fe2 48            	sll	a
6502  0fe3 e778          	ld	(_can_out_buff+1,x),a
6503                     ; 1595 can_out_buff[can_buff_wr_ptr][2]=data0;
6505  0fe5 b676          	ld	a,_can_buff_wr_ptr
6506  0fe7 97            	ld	xl,a
6507  0fe8 a610          	ld	a,#16
6508  0fea 42            	mul	x,a
6509  0feb 7b05          	ld	a,(OFST+5,sp)
6510  0fed e779          	ld	(_can_out_buff+2,x),a
6511                     ; 1596 can_out_buff[can_buff_wr_ptr][3]=data1;
6513  0fef b676          	ld	a,_can_buff_wr_ptr
6514  0ff1 97            	ld	xl,a
6515  0ff2 a610          	ld	a,#16
6516  0ff4 42            	mul	x,a
6517  0ff5 7b06          	ld	a,(OFST+6,sp)
6518  0ff7 e77a          	ld	(_can_out_buff+3,x),a
6519                     ; 1597 can_out_buff[can_buff_wr_ptr][4]=data2;
6521  0ff9 b676          	ld	a,_can_buff_wr_ptr
6522  0ffb 97            	ld	xl,a
6523  0ffc a610          	ld	a,#16
6524  0ffe 42            	mul	x,a
6525  0fff 7b07          	ld	a,(OFST+7,sp)
6526  1001 e77b          	ld	(_can_out_buff+4,x),a
6527                     ; 1598 can_out_buff[can_buff_wr_ptr][5]=data3;
6529  1003 b676          	ld	a,_can_buff_wr_ptr
6530  1005 97            	ld	xl,a
6531  1006 a610          	ld	a,#16
6532  1008 42            	mul	x,a
6533  1009 7b08          	ld	a,(OFST+8,sp)
6534  100b e77c          	ld	(_can_out_buff+5,x),a
6535                     ; 1599 can_out_buff[can_buff_wr_ptr][6]=data4;
6537  100d b676          	ld	a,_can_buff_wr_ptr
6538  100f 97            	ld	xl,a
6539  1010 a610          	ld	a,#16
6540  1012 42            	mul	x,a
6541  1013 7b09          	ld	a,(OFST+9,sp)
6542  1015 e77d          	ld	(_can_out_buff+6,x),a
6543                     ; 1600 can_out_buff[can_buff_wr_ptr][7]=data5;
6545  1017 b676          	ld	a,_can_buff_wr_ptr
6546  1019 97            	ld	xl,a
6547  101a a610          	ld	a,#16
6548  101c 42            	mul	x,a
6549  101d 7b0a          	ld	a,(OFST+10,sp)
6550  101f e77e          	ld	(_can_out_buff+7,x),a
6551                     ; 1601 can_out_buff[can_buff_wr_ptr][8]=data6;
6553  1021 b676          	ld	a,_can_buff_wr_ptr
6554  1023 97            	ld	xl,a
6555  1024 a610          	ld	a,#16
6556  1026 42            	mul	x,a
6557  1027 7b0b          	ld	a,(OFST+11,sp)
6558  1029 e77f          	ld	(_can_out_buff+8,x),a
6559                     ; 1602 can_out_buff[can_buff_wr_ptr][9]=data7;
6561  102b b676          	ld	a,_can_buff_wr_ptr
6562  102d 97            	ld	xl,a
6563  102e a610          	ld	a,#16
6564  1030 42            	mul	x,a
6565  1031 7b0c          	ld	a,(OFST+12,sp)
6566  1033 e780          	ld	(_can_out_buff+9,x),a
6567                     ; 1604 can_buff_wr_ptr++;
6569  1035 3c76          	inc	_can_buff_wr_ptr
6570                     ; 1605 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6572  1037 b676          	ld	a,_can_buff_wr_ptr
6573  1039 a104          	cp	a,#4
6574  103b 2502          	jrult	L5503
6577  103d 3f76          	clr	_can_buff_wr_ptr
6578  103f               L5503:
6579                     ; 1606 } 
6582  103f 85            	popw	x
6583  1040 81            	ret
6612                     ; 1609 void can_tx_hndl(void)
6612                     ; 1610 {
6613                     	switch	.text
6614  1041               _can_tx_hndl:
6618                     ; 1611 if(bTX_FREE)
6620  1041 3d03          	tnz	_bTX_FREE
6621  1043 2757          	jreq	L7603
6622                     ; 1613 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6624  1045 b675          	ld	a,_can_buff_rd_ptr
6625  1047 b176          	cp	a,_can_buff_wr_ptr
6626  1049 275f          	jreq	L5703
6627                     ; 1615 		bTX_FREE=0;
6629  104b 3f03          	clr	_bTX_FREE
6630                     ; 1617 		CAN->PSR= 0;
6632  104d 725f5427      	clr	21543
6633                     ; 1618 		CAN->Page.TxMailbox.MDLCR=8;
6635  1051 35085429      	mov	21545,#8
6636                     ; 1619 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6638  1055 b675          	ld	a,_can_buff_rd_ptr
6639  1057 97            	ld	xl,a
6640  1058 a610          	ld	a,#16
6641  105a 42            	mul	x,a
6642  105b e677          	ld	a,(_can_out_buff,x)
6643  105d c7542a        	ld	21546,a
6644                     ; 1620 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6646  1060 b675          	ld	a,_can_buff_rd_ptr
6647  1062 97            	ld	xl,a
6648  1063 a610          	ld	a,#16
6649  1065 42            	mul	x,a
6650  1066 e678          	ld	a,(_can_out_buff+1,x)
6651  1068 c7542b        	ld	21547,a
6652                     ; 1622 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6654  106b b675          	ld	a,_can_buff_rd_ptr
6655  106d 97            	ld	xl,a
6656  106e a610          	ld	a,#16
6657  1070 42            	mul	x,a
6658  1071 01            	rrwa	x,a
6659  1072 ab79          	add	a,#_can_out_buff+2
6660  1074 2401          	jrnc	L631
6661  1076 5c            	incw	x
6662  1077               L631:
6663  1077 5f            	clrw	x
6664  1078 97            	ld	xl,a
6665  1079 bf00          	ldw	c_x,x
6666  107b ae0008        	ldw	x,#8
6667  107e               L041:
6668  107e 5a            	decw	x
6669  107f 92d600        	ld	a,([c_x],x)
6670  1082 d7542e        	ld	(21550,x),a
6671  1085 5d            	tnzw	x
6672  1086 26f6          	jrne	L041
6673                     ; 1624 		can_buff_rd_ptr++;
6675  1088 3c75          	inc	_can_buff_rd_ptr
6676                     ; 1625 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6678  108a b675          	ld	a,_can_buff_rd_ptr
6679  108c a104          	cp	a,#4
6680  108e 2502          	jrult	L3703
6683  1090 3f75          	clr	_can_buff_rd_ptr
6684  1092               L3703:
6685                     ; 1627 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6687  1092 72105428      	bset	21544,#0
6688                     ; 1628 		CAN->IER|=(1<<0);
6690  1096 72105425      	bset	21541,#0
6691  109a 200e          	jra	L5703
6692  109c               L7603:
6693                     ; 1633 	tx_busy_cnt++;
6695  109c 3c74          	inc	_tx_busy_cnt
6696                     ; 1634 	if(tx_busy_cnt>=100)
6698  109e b674          	ld	a,_tx_busy_cnt
6699  10a0 a164          	cp	a,#100
6700  10a2 2506          	jrult	L5703
6701                     ; 1636 		tx_busy_cnt=0;
6703  10a4 3f74          	clr	_tx_busy_cnt
6704                     ; 1637 		bTX_FREE=1;
6706  10a6 35010003      	mov	_bTX_FREE,#1
6707  10aa               L5703:
6708                     ; 1640 }
6711  10aa 81            	ret
6826                     ; 1666 void can_in_an(void)
6826                     ; 1667 {
6827                     	switch	.text
6828  10ab               _can_in_an:
6830  10ab 5207          	subw	sp,#7
6831       00000007      OFST:	set	7
6834                     ; 1677 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6836  10ad b6cd          	ld	a,_mess+6
6837  10af c100f7        	cp	a,_adress
6838  10b2 2703          	jreq	L061
6839  10b4 cc11ec        	jp	L5313
6840  10b7               L061:
6842  10b7 b6ce          	ld	a,_mess+7
6843  10b9 c100f7        	cp	a,_adress
6844  10bc 2703          	jreq	L261
6845  10be cc11ec        	jp	L5313
6846  10c1               L261:
6848  10c1 b6cf          	ld	a,_mess+8
6849  10c3 a1ed          	cp	a,#237
6850  10c5 2703          	jreq	L461
6851  10c7 cc11ec        	jp	L5313
6852  10ca               L461:
6853                     ; 1680 	can_error_cnt=0;
6855  10ca 3f73          	clr	_can_error_cnt
6856                     ; 1682 	bMAIN=0;
6858  10cc 72110001      	bres	_bMAIN
6859                     ; 1683  	flags_tu=mess[9];
6861  10d0 45d06a        	mov	_flags_tu,_mess+9
6862                     ; 1684  	if(flags_tu&0b00000001)
6864  10d3 b66a          	ld	a,_flags_tu
6865  10d5 a501          	bcp	a,#1
6866  10d7 2706          	jreq	L7313
6867                     ; 1689  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6869  10d9 721a0005      	bset	_flags,#5
6871  10dd 2008          	jra	L1413
6872  10df               L7313:
6873                     ; 1700  				flags&=0b11011111; 
6875  10df 721b0005      	bres	_flags,#5
6876                     ; 1701  				off_bp_cnt=5*EE_TZAS;
6878  10e3 350f005d      	mov	_off_bp_cnt,#15
6879  10e7               L1413:
6880                     ; 1707  	if(flags_tu&0b00000010) flags|=0b01000000;
6882  10e7 b66a          	ld	a,_flags_tu
6883  10e9 a502          	bcp	a,#2
6884  10eb 2706          	jreq	L3413
6887  10ed 721c0005      	bset	_flags,#6
6889  10f1 2004          	jra	L5413
6890  10f3               L3413:
6891                     ; 1708  	else flags&=0b10111111; 
6893  10f3 721d0005      	bres	_flags,#6
6894  10f7               L5413:
6895                     ; 1710  	U_out_const=mess[10]+mess[11]*256;
6897  10f7 b6d2          	ld	a,_mess+11
6898  10f9 5f            	clrw	x
6899  10fa 97            	ld	xl,a
6900  10fb 4f            	clr	a
6901  10fc 02            	rlwa	x,a
6902  10fd 01            	rrwa	x,a
6903  10fe bbd1          	add	a,_mess+10
6904  1100 2401          	jrnc	L441
6905  1102 5c            	incw	x
6906  1103               L441:
6907  1103 c70009        	ld	_U_out_const+1,a
6908  1106 9f            	ld	a,xl
6909  1107 c70008        	ld	_U_out_const,a
6910                     ; 1711  	vol_i_temp=mess[12]+mess[13]*256;  
6912  110a b6d4          	ld	a,_mess+13
6913  110c 5f            	clrw	x
6914  110d 97            	ld	xl,a
6915  110e 4f            	clr	a
6916  110f 02            	rlwa	x,a
6917  1110 01            	rrwa	x,a
6918  1111 bbd3          	add	a,_mess+12
6919  1113 2401          	jrnc	L641
6920  1115 5c            	incw	x
6921  1116               L641:
6922  1116 b761          	ld	_vol_i_temp+1,a
6923  1118 9f            	ld	a,xl
6924  1119 b760          	ld	_vol_i_temp,a
6925                     ; 1721 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6927  111b b608          	ld	a,_vent_resurs_tx_cnt
6928  111d a102          	cp	a,#2
6929  111f 2507          	jrult	L7413
6932  1121 ce0000        	ldw	x,_vent_resurs
6933  1124 bf41          	ldw	_plazma_int+4,x
6935  1126 2004          	jra	L1513
6936  1128               L7413:
6937                     ; 1722 	else plazma_int[2]=vent_resurs_sec_cnt;
6939  1128 be09          	ldw	x,_vent_resurs_sec_cnt
6940  112a bf41          	ldw	_plazma_int+4,x
6941  112c               L1513:
6942                     ; 1723  	rotor_int=flags_tu+(((short)flags)<<8);
6944  112c b605          	ld	a,_flags
6945  112e 5f            	clrw	x
6946  112f 97            	ld	xl,a
6947  1130 4f            	clr	a
6948  1131 02            	rlwa	x,a
6949  1132 01            	rrwa	x,a
6950  1133 bb6a          	add	a,_flags_tu
6951  1135 2401          	jrnc	L051
6952  1137 5c            	incw	x
6953  1138               L051:
6954  1138 b718          	ld	_rotor_int+1,a
6955  113a 9f            	ld	a,xl
6956  113b b717          	ld	_rotor_int,a
6957                     ; 1724 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6959  113d 3b000c        	push	_Ui
6960  1140 3b000d        	push	_Ui+1
6961  1143 3b000e        	push	_Un
6962  1146 3b000f        	push	_Un+1
6963  1149 3b0010        	push	_I
6964  114c 3b0011        	push	_I+1
6965  114f 4bda          	push	#218
6966  1151 3b00f7        	push	_adress
6967  1154 ae018e        	ldw	x,#398
6968  1157 cd0fbd        	call	_can_transmit
6970  115a 5b08          	addw	sp,#8
6971                     ; 1725 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6973  115c 3b0006        	push	_Usum
6974  115f 3b0007        	push	_Usum+1
6975  1162 3b0069        	push	__x_+1
6976  1165 3b0005        	push	_flags
6977  1168 b608          	ld	a,_vent_resurs_tx_cnt
6978  116a 5f            	clrw	x
6979  116b 97            	ld	xl,a
6980  116c d60000        	ld	a,(_vent_resurs_buff,x)
6981  116f 88            	push	a
6982  1170 3b0072        	push	_T
6983  1173 4bdb          	push	#219
6984  1175 3b00f7        	push	_adress
6985  1178 ae018e        	ldw	x,#398
6986  117b cd0fbd        	call	_can_transmit
6988  117e 5b08          	addw	sp,#8
6989                     ; 1726 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6991  1180 3b0005        	push	_debug_info_to_uku+4
6992  1183 3b0006        	push	_debug_info_to_uku+5
6993  1186 3b0003        	push	_debug_info_to_uku+2
6994  1189 3b0004        	push	_debug_info_to_uku+3
6995  118c 3b0001        	push	_debug_info_to_uku
6996  118f 3b0002        	push	_debug_info_to_uku+1
6997  1192 4bdc          	push	#220
6998  1194 3b00f7        	push	_adress
6999  1197 ae018e        	ldw	x,#398
7000  119a cd0fbd        	call	_can_transmit
7002  119d 5b08          	addw	sp,#8
7003                     ; 1727      link_cnt=0;
7005  119f 5f            	clrw	x
7006  11a0 bf6b          	ldw	_link_cnt,x
7007                     ; 1728      link=ON;
7009  11a2 3555006d      	mov	_link,#85
7010                     ; 1730      if(flags_tu&0b10000000)
7012  11a6 b66a          	ld	a,_flags_tu
7013  11a8 a580          	bcp	a,#128
7014  11aa 2716          	jreq	L3513
7015                     ; 1732      	if(!res_fl)
7017  11ac 725d000b      	tnz	_res_fl
7018  11b0 2626          	jrne	L7513
7019                     ; 1734      		res_fl=1;
7021  11b2 a601          	ld	a,#1
7022  11b4 ae000b        	ldw	x,#_res_fl
7023  11b7 cd0000        	call	c_eewrc
7025                     ; 1735      		bRES=1;
7027  11ba 3501000c      	mov	_bRES,#1
7028                     ; 1736      		res_fl_cnt=0;
7030  11be 3f4b          	clr	_res_fl_cnt
7031  11c0 2016          	jra	L7513
7032  11c2               L3513:
7033                     ; 1741      	if(main_cnt>20)
7035  11c2 9c            	rvf
7036  11c3 ce0255        	ldw	x,_main_cnt
7037  11c6 a30015        	cpw	x,#21
7038  11c9 2f0d          	jrslt	L7513
7039                     ; 1743     			if(res_fl)
7041  11cb 725d000b      	tnz	_res_fl
7042  11cf 2707          	jreq	L7513
7043                     ; 1745      			res_fl=0;
7045  11d1 4f            	clr	a
7046  11d2 ae000b        	ldw	x,#_res_fl
7047  11d5 cd0000        	call	c_eewrc
7049  11d8               L7513:
7050                     ; 1750       if(res_fl_)
7052  11d8 725d000a      	tnz	_res_fl_
7053  11dc 2603          	jrne	L661
7054  11de cc1753        	jp	L1013
7055  11e1               L661:
7056                     ; 1752       	res_fl_=0;
7058  11e1 4f            	clr	a
7059  11e2 ae000a        	ldw	x,#_res_fl_
7060  11e5 cd0000        	call	c_eewrc
7062  11e8 ac531753      	jpf	L1013
7063  11ec               L5313:
7064                     ; 1755 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7066  11ec b6cd          	ld	a,_mess+6
7067  11ee c100f7        	cp	a,_adress
7068  11f1 2703          	jreq	L071
7069  11f3 cc1469        	jp	L1713
7070  11f6               L071:
7072  11f6 b6ce          	ld	a,_mess+7
7073  11f8 c100f7        	cp	a,_adress
7074  11fb 2703          	jreq	L271
7075  11fd cc1469        	jp	L1713
7076  1200               L271:
7078  1200 b6cf          	ld	a,_mess+8
7079  1202 a1ee          	cp	a,#238
7080  1204 2703          	jreq	L471
7081  1206 cc1469        	jp	L1713
7082  1209               L471:
7084  1209 b6d0          	ld	a,_mess+9
7085  120b b1d1          	cp	a,_mess+10
7086  120d 2703          	jreq	L671
7087  120f cc1469        	jp	L1713
7088  1212               L671:
7089                     ; 1757 	rotor_int++;
7091  1212 be17          	ldw	x,_rotor_int
7092  1214 1c0001        	addw	x,#1
7093  1217 bf17          	ldw	_rotor_int,x
7094                     ; 1758 	if((mess[9]&0xf0)==0x20)
7096  1219 b6d0          	ld	a,_mess+9
7097  121b a4f0          	and	a,#240
7098  121d a120          	cp	a,#32
7099  121f 2673          	jrne	L3713
7100                     ; 1760 		if((mess[9]&0x0f)==0x01)
7102  1221 b6d0          	ld	a,_mess+9
7103  1223 a40f          	and	a,#15
7104  1225 a101          	cp	a,#1
7105  1227 260d          	jrne	L5713
7106                     ; 1762 			ee_K[0][0]=adc_buff_[4];
7108  1229 ce0107        	ldw	x,_adc_buff_+8
7109  122c 89            	pushw	x
7110  122d ae001a        	ldw	x,#_ee_K
7111  1230 cd0000        	call	c_eewrw
7113  1233 85            	popw	x
7115  1234 204a          	jra	L7713
7116  1236               L5713:
7117                     ; 1764 		else if((mess[9]&0x0f)==0x02)
7119  1236 b6d0          	ld	a,_mess+9
7120  1238 a40f          	and	a,#15
7121  123a a102          	cp	a,#2
7122  123c 260b          	jrne	L1023
7123                     ; 1766 			ee_K[0][1]++;
7125  123e ce001c        	ldw	x,_ee_K+2
7126  1241 1c0001        	addw	x,#1
7127  1244 cf001c        	ldw	_ee_K+2,x
7129  1247 2037          	jra	L7713
7130  1249               L1023:
7131                     ; 1768 		else if((mess[9]&0x0f)==0x03)
7133  1249 b6d0          	ld	a,_mess+9
7134  124b a40f          	and	a,#15
7135  124d a103          	cp	a,#3
7136  124f 260b          	jrne	L5023
7137                     ; 1770 			ee_K[0][1]+=10;
7139  1251 ce001c        	ldw	x,_ee_K+2
7140  1254 1c000a        	addw	x,#10
7141  1257 cf001c        	ldw	_ee_K+2,x
7143  125a 2024          	jra	L7713
7144  125c               L5023:
7145                     ; 1772 		else if((mess[9]&0x0f)==0x04)
7147  125c b6d0          	ld	a,_mess+9
7148  125e a40f          	and	a,#15
7149  1260 a104          	cp	a,#4
7150  1262 260b          	jrne	L1123
7151                     ; 1774 			ee_K[0][1]--;
7153  1264 ce001c        	ldw	x,_ee_K+2
7154  1267 1d0001        	subw	x,#1
7155  126a cf001c        	ldw	_ee_K+2,x
7157  126d 2011          	jra	L7713
7158  126f               L1123:
7159                     ; 1776 		else if((mess[9]&0x0f)==0x05)
7161  126f b6d0          	ld	a,_mess+9
7162  1271 a40f          	and	a,#15
7163  1273 a105          	cp	a,#5
7164  1275 2609          	jrne	L7713
7165                     ; 1778 			ee_K[0][1]-=10;
7167  1277 ce001c        	ldw	x,_ee_K+2
7168  127a 1d000a        	subw	x,#10
7169  127d cf001c        	ldw	_ee_K+2,x
7170  1280               L7713:
7171                     ; 1780 		granee(&ee_K[0][1],50,3000);									
7173  1280 ae0bb8        	ldw	x,#3000
7174  1283 89            	pushw	x
7175  1284 ae0032        	ldw	x,#50
7176  1287 89            	pushw	x
7177  1288 ae001c        	ldw	x,#_ee_K+2
7178  128b cd00f6        	call	_granee
7180  128e 5b04          	addw	sp,#4
7182  1290 ac4e144e      	jpf	L7123
7183  1294               L3713:
7184                     ; 1782 	else if((mess[9]&0xf0)==0x10)
7186  1294 b6d0          	ld	a,_mess+9
7187  1296 a4f0          	and	a,#240
7188  1298 a110          	cp	a,#16
7189  129a 2673          	jrne	L1223
7190                     ; 1784 		if((mess[9]&0x0f)==0x01)
7192  129c b6d0          	ld	a,_mess+9
7193  129e a40f          	and	a,#15
7194  12a0 a101          	cp	a,#1
7195  12a2 260d          	jrne	L3223
7196                     ; 1786 			ee_K[1][0]=adc_buff_[1];
7198  12a4 ce0101        	ldw	x,_adc_buff_+2
7199  12a7 89            	pushw	x
7200  12a8 ae001e        	ldw	x,#_ee_K+4
7201  12ab cd0000        	call	c_eewrw
7203  12ae 85            	popw	x
7205  12af 204a          	jra	L5223
7206  12b1               L3223:
7207                     ; 1788 		else if((mess[9]&0x0f)==0x02)
7209  12b1 b6d0          	ld	a,_mess+9
7210  12b3 a40f          	and	a,#15
7211  12b5 a102          	cp	a,#2
7212  12b7 260b          	jrne	L7223
7213                     ; 1790 			ee_K[1][1]++;
7215  12b9 ce0020        	ldw	x,_ee_K+6
7216  12bc 1c0001        	addw	x,#1
7217  12bf cf0020        	ldw	_ee_K+6,x
7219  12c2 2037          	jra	L5223
7220  12c4               L7223:
7221                     ; 1792 		else if((mess[9]&0x0f)==0x03)
7223  12c4 b6d0          	ld	a,_mess+9
7224  12c6 a40f          	and	a,#15
7225  12c8 a103          	cp	a,#3
7226  12ca 260b          	jrne	L3323
7227                     ; 1794 			ee_K[1][1]+=10;
7229  12cc ce0020        	ldw	x,_ee_K+6
7230  12cf 1c000a        	addw	x,#10
7231  12d2 cf0020        	ldw	_ee_K+6,x
7233  12d5 2024          	jra	L5223
7234  12d7               L3323:
7235                     ; 1796 		else if((mess[9]&0x0f)==0x04)
7237  12d7 b6d0          	ld	a,_mess+9
7238  12d9 a40f          	and	a,#15
7239  12db a104          	cp	a,#4
7240  12dd 260b          	jrne	L7323
7241                     ; 1798 			ee_K[1][1]--;
7243  12df ce0020        	ldw	x,_ee_K+6
7244  12e2 1d0001        	subw	x,#1
7245  12e5 cf0020        	ldw	_ee_K+6,x
7247  12e8 2011          	jra	L5223
7248  12ea               L7323:
7249                     ; 1800 		else if((mess[9]&0x0f)==0x05)
7251  12ea b6d0          	ld	a,_mess+9
7252  12ec a40f          	and	a,#15
7253  12ee a105          	cp	a,#5
7254  12f0 2609          	jrne	L5223
7255                     ; 1802 			ee_K[1][1]-=10;
7257  12f2 ce0020        	ldw	x,_ee_K+6
7258  12f5 1d000a        	subw	x,#10
7259  12f8 cf0020        	ldw	_ee_K+6,x
7260  12fb               L5223:
7261                     ; 1807 		granee(&ee_K[1][1],10,30000);
7263  12fb ae7530        	ldw	x,#30000
7264  12fe 89            	pushw	x
7265  12ff ae000a        	ldw	x,#10
7266  1302 89            	pushw	x
7267  1303 ae0020        	ldw	x,#_ee_K+6
7268  1306 cd00f6        	call	_granee
7270  1309 5b04          	addw	sp,#4
7272  130b ac4e144e      	jpf	L7123
7273  130f               L1223:
7274                     ; 1811 	else if((mess[9]&0xf0)==0x00)
7276  130f b6d0          	ld	a,_mess+9
7277  1311 a5f0          	bcp	a,#240
7278  1313 2673          	jrne	L7423
7279                     ; 1813 		if((mess[9]&0x0f)==0x01)
7281  1315 b6d0          	ld	a,_mess+9
7282  1317 a40f          	and	a,#15
7283  1319 a101          	cp	a,#1
7284  131b 260d          	jrne	L1523
7285                     ; 1815 			ee_K[2][0]=adc_buff_[2];
7287  131d ce0103        	ldw	x,_adc_buff_+4
7288  1320 89            	pushw	x
7289  1321 ae0022        	ldw	x,#_ee_K+8
7290  1324 cd0000        	call	c_eewrw
7292  1327 85            	popw	x
7294  1328 204a          	jra	L3523
7295  132a               L1523:
7296                     ; 1817 		else if((mess[9]&0x0f)==0x02)
7298  132a b6d0          	ld	a,_mess+9
7299  132c a40f          	and	a,#15
7300  132e a102          	cp	a,#2
7301  1330 260b          	jrne	L5523
7302                     ; 1819 			ee_K[2][1]++;
7304  1332 ce0024        	ldw	x,_ee_K+10
7305  1335 1c0001        	addw	x,#1
7306  1338 cf0024        	ldw	_ee_K+10,x
7308  133b 2037          	jra	L3523
7309  133d               L5523:
7310                     ; 1821 		else if((mess[9]&0x0f)==0x03)
7312  133d b6d0          	ld	a,_mess+9
7313  133f a40f          	and	a,#15
7314  1341 a103          	cp	a,#3
7315  1343 260b          	jrne	L1623
7316                     ; 1823 			ee_K[2][1]+=10;
7318  1345 ce0024        	ldw	x,_ee_K+10
7319  1348 1c000a        	addw	x,#10
7320  134b cf0024        	ldw	_ee_K+10,x
7322  134e 2024          	jra	L3523
7323  1350               L1623:
7324                     ; 1825 		else if((mess[9]&0x0f)==0x04)
7326  1350 b6d0          	ld	a,_mess+9
7327  1352 a40f          	and	a,#15
7328  1354 a104          	cp	a,#4
7329  1356 260b          	jrne	L5623
7330                     ; 1827 			ee_K[2][1]--;
7332  1358 ce0024        	ldw	x,_ee_K+10
7333  135b 1d0001        	subw	x,#1
7334  135e cf0024        	ldw	_ee_K+10,x
7336  1361 2011          	jra	L3523
7337  1363               L5623:
7338                     ; 1829 		else if((mess[9]&0x0f)==0x05)
7340  1363 b6d0          	ld	a,_mess+9
7341  1365 a40f          	and	a,#15
7342  1367 a105          	cp	a,#5
7343  1369 2609          	jrne	L3523
7344                     ; 1831 			ee_K[2][1]-=10;
7346  136b ce0024        	ldw	x,_ee_K+10
7347  136e 1d000a        	subw	x,#10
7348  1371 cf0024        	ldw	_ee_K+10,x
7349  1374               L3523:
7350                     ; 1836 		granee(&ee_K[2][1],10,30000);
7352  1374 ae7530        	ldw	x,#30000
7353  1377 89            	pushw	x
7354  1378 ae000a        	ldw	x,#10
7355  137b 89            	pushw	x
7356  137c ae0024        	ldw	x,#_ee_K+10
7357  137f cd00f6        	call	_granee
7359  1382 5b04          	addw	sp,#4
7361  1384 ac4e144e      	jpf	L7123
7362  1388               L7423:
7363                     ; 1840 	else if((mess[9]&0xf0)==0x30)
7365  1388 b6d0          	ld	a,_mess+9
7366  138a a4f0          	and	a,#240
7367  138c a130          	cp	a,#48
7368  138e 265c          	jrne	L5723
7369                     ; 1842 		if((mess[9]&0x0f)==0x02)
7371  1390 b6d0          	ld	a,_mess+9
7372  1392 a40f          	and	a,#15
7373  1394 a102          	cp	a,#2
7374  1396 260b          	jrne	L7723
7375                     ; 1844 			ee_K[3][1]++;
7377  1398 ce0028        	ldw	x,_ee_K+14
7378  139b 1c0001        	addw	x,#1
7379  139e cf0028        	ldw	_ee_K+14,x
7381  13a1 2037          	jra	L1033
7382  13a3               L7723:
7383                     ; 1846 		else if((mess[9]&0x0f)==0x03)
7385  13a3 b6d0          	ld	a,_mess+9
7386  13a5 a40f          	and	a,#15
7387  13a7 a103          	cp	a,#3
7388  13a9 260b          	jrne	L3033
7389                     ; 1848 			ee_K[3][1]+=10;
7391  13ab ce0028        	ldw	x,_ee_K+14
7392  13ae 1c000a        	addw	x,#10
7393  13b1 cf0028        	ldw	_ee_K+14,x
7395  13b4 2024          	jra	L1033
7396  13b6               L3033:
7397                     ; 1850 		else if((mess[9]&0x0f)==0x04)
7399  13b6 b6d0          	ld	a,_mess+9
7400  13b8 a40f          	and	a,#15
7401  13ba a104          	cp	a,#4
7402  13bc 260b          	jrne	L7033
7403                     ; 1852 			ee_K[3][1]--;
7405  13be ce0028        	ldw	x,_ee_K+14
7406  13c1 1d0001        	subw	x,#1
7407  13c4 cf0028        	ldw	_ee_K+14,x
7409  13c7 2011          	jra	L1033
7410  13c9               L7033:
7411                     ; 1854 		else if((mess[9]&0x0f)==0x05)
7413  13c9 b6d0          	ld	a,_mess+9
7414  13cb a40f          	and	a,#15
7415  13cd a105          	cp	a,#5
7416  13cf 2609          	jrne	L1033
7417                     ; 1856 			ee_K[3][1]-=10;
7419  13d1 ce0028        	ldw	x,_ee_K+14
7420  13d4 1d000a        	subw	x,#10
7421  13d7 cf0028        	ldw	_ee_K+14,x
7422  13da               L1033:
7423                     ; 1858 		granee(&ee_K[3][1],300,517);									
7425  13da ae0205        	ldw	x,#517
7426  13dd 89            	pushw	x
7427  13de ae012c        	ldw	x,#300
7428  13e1 89            	pushw	x
7429  13e2 ae0028        	ldw	x,#_ee_K+14
7430  13e5 cd00f6        	call	_granee
7432  13e8 5b04          	addw	sp,#4
7434  13ea 2062          	jra	L7123
7435  13ec               L5723:
7436                     ; 1861 	else if((mess[9]&0xf0)==0x50)
7438  13ec b6d0          	ld	a,_mess+9
7439  13ee a4f0          	and	a,#240
7440  13f0 a150          	cp	a,#80
7441  13f2 265a          	jrne	L7123
7442                     ; 1863 		if((mess[9]&0x0f)==0x02)
7444  13f4 b6d0          	ld	a,_mess+9
7445  13f6 a40f          	and	a,#15
7446  13f8 a102          	cp	a,#2
7447  13fa 260b          	jrne	L1233
7448                     ; 1865 			ee_K[4][1]++;
7450  13fc ce002c        	ldw	x,_ee_K+18
7451  13ff 1c0001        	addw	x,#1
7452  1402 cf002c        	ldw	_ee_K+18,x
7454  1405 2037          	jra	L3233
7455  1407               L1233:
7456                     ; 1867 		else if((mess[9]&0x0f)==0x03)
7458  1407 b6d0          	ld	a,_mess+9
7459  1409 a40f          	and	a,#15
7460  140b a103          	cp	a,#3
7461  140d 260b          	jrne	L5233
7462                     ; 1869 			ee_K[4][1]+=10;
7464  140f ce002c        	ldw	x,_ee_K+18
7465  1412 1c000a        	addw	x,#10
7466  1415 cf002c        	ldw	_ee_K+18,x
7468  1418 2024          	jra	L3233
7469  141a               L5233:
7470                     ; 1871 		else if((mess[9]&0x0f)==0x04)
7472  141a b6d0          	ld	a,_mess+9
7473  141c a40f          	and	a,#15
7474  141e a104          	cp	a,#4
7475  1420 260b          	jrne	L1333
7476                     ; 1873 			ee_K[4][1]--;
7478  1422 ce002c        	ldw	x,_ee_K+18
7479  1425 1d0001        	subw	x,#1
7480  1428 cf002c        	ldw	_ee_K+18,x
7482  142b 2011          	jra	L3233
7483  142d               L1333:
7484                     ; 1875 		else if((mess[9]&0x0f)==0x05)
7486  142d b6d0          	ld	a,_mess+9
7487  142f a40f          	and	a,#15
7488  1431 a105          	cp	a,#5
7489  1433 2609          	jrne	L3233
7490                     ; 1877 			ee_K[4][1]-=10;
7492  1435 ce002c        	ldw	x,_ee_K+18
7493  1438 1d000a        	subw	x,#10
7494  143b cf002c        	ldw	_ee_K+18,x
7495  143e               L3233:
7496                     ; 1879 		granee(&ee_K[4][1],10,30000);									
7498  143e ae7530        	ldw	x,#30000
7499  1441 89            	pushw	x
7500  1442 ae000a        	ldw	x,#10
7501  1445 89            	pushw	x
7502  1446 ae002c        	ldw	x,#_ee_K+18
7503  1449 cd00f6        	call	_granee
7505  144c 5b04          	addw	sp,#4
7506  144e               L7123:
7507                     ; 1882 	link_cnt=0;
7509  144e 5f            	clrw	x
7510  144f bf6b          	ldw	_link_cnt,x
7511                     ; 1883      link=ON;
7513  1451 3555006d      	mov	_link,#85
7514                     ; 1884      if(res_fl_)
7516  1455 725d000a      	tnz	_res_fl_
7517  1459 2603          	jrne	L002
7518  145b cc1753        	jp	L1013
7519  145e               L002:
7520                     ; 1886       	res_fl_=0;
7522  145e 4f            	clr	a
7523  145f ae000a        	ldw	x,#_res_fl_
7524  1462 cd0000        	call	c_eewrc
7526  1465 ac531753      	jpf	L1013
7527  1469               L1713:
7528                     ; 1892 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7530  1469 b6cd          	ld	a,_mess+6
7531  146b a1ff          	cp	a,#255
7532  146d 2703          	jreq	L202
7533  146f cc14fd        	jp	L3433
7534  1472               L202:
7536  1472 b6ce          	ld	a,_mess+7
7537  1474 a1ff          	cp	a,#255
7538  1476 2703          	jreq	L402
7539  1478 cc14fd        	jp	L3433
7540  147b               L402:
7542  147b b6cf          	ld	a,_mess+8
7543  147d a162          	cp	a,#98
7544  147f 267c          	jrne	L3433
7545                     ; 1895 	tempSS=mess[9]+(mess[10]*256);
7547  1481 b6d1          	ld	a,_mess+10
7548  1483 5f            	clrw	x
7549  1484 97            	ld	xl,a
7550  1485 4f            	clr	a
7551  1486 02            	rlwa	x,a
7552  1487 01            	rrwa	x,a
7553  1488 bbd0          	add	a,_mess+9
7554  148a 2401          	jrnc	L251
7555  148c 5c            	incw	x
7556  148d               L251:
7557  148d 02            	rlwa	x,a
7558  148e 1f03          	ldw	(OFST-4,sp),x
7559  1490 01            	rrwa	x,a
7560                     ; 1896 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7562  1491 ce0014        	ldw	x,_ee_Umax
7563  1494 1303          	cpw	x,(OFST-4,sp)
7564  1496 270a          	jreq	L5433
7567  1498 1e03          	ldw	x,(OFST-4,sp)
7568  149a 89            	pushw	x
7569  149b ae0014        	ldw	x,#_ee_Umax
7570  149e cd0000        	call	c_eewrw
7572  14a1 85            	popw	x
7573  14a2               L5433:
7574                     ; 1897 	tempSS=mess[11]+(mess[12]*256);
7576  14a2 b6d3          	ld	a,_mess+12
7577  14a4 5f            	clrw	x
7578  14a5 97            	ld	xl,a
7579  14a6 4f            	clr	a
7580  14a7 02            	rlwa	x,a
7581  14a8 01            	rrwa	x,a
7582  14a9 bbd2          	add	a,_mess+11
7583  14ab 2401          	jrnc	L451
7584  14ad 5c            	incw	x
7585  14ae               L451:
7586  14ae 02            	rlwa	x,a
7587  14af 1f03          	ldw	(OFST-4,sp),x
7588  14b1 01            	rrwa	x,a
7589                     ; 1898 	if(ee_dU!=tempSS) ee_dU=tempSS;
7591  14b2 ce0012        	ldw	x,_ee_dU
7592  14b5 1303          	cpw	x,(OFST-4,sp)
7593  14b7 270a          	jreq	L7433
7596  14b9 1e03          	ldw	x,(OFST-4,sp)
7597  14bb 89            	pushw	x
7598  14bc ae0012        	ldw	x,#_ee_dU
7599  14bf cd0000        	call	c_eewrw
7601  14c2 85            	popw	x
7602  14c3               L7433:
7603                     ; 1899 	if((mess[13]&0x0f)==0x5)
7605  14c3 b6d4          	ld	a,_mess+13
7606  14c5 a40f          	and	a,#15
7607  14c7 a105          	cp	a,#5
7608  14c9 261a          	jrne	L1533
7609                     ; 1901 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7611  14cb ce0006        	ldw	x,_ee_AVT_MODE
7612  14ce a30055        	cpw	x,#85
7613  14d1 2603          	jrne	L602
7614  14d3 cc1753        	jp	L1013
7615  14d6               L602:
7618  14d6 ae0055        	ldw	x,#85
7619  14d9 89            	pushw	x
7620  14da ae0006        	ldw	x,#_ee_AVT_MODE
7621  14dd cd0000        	call	c_eewrw
7623  14e0 85            	popw	x
7624  14e1 ac531753      	jpf	L1013
7625  14e5               L1533:
7626                     ; 1903 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7628  14e5 ce0006        	ldw	x,_ee_AVT_MODE
7629  14e8 a30055        	cpw	x,#85
7630  14eb 2703          	jreq	L012
7631  14ed cc1753        	jp	L1013
7632  14f0               L012:
7635  14f0 5f            	clrw	x
7636  14f1 89            	pushw	x
7637  14f2 ae0006        	ldw	x,#_ee_AVT_MODE
7638  14f5 cd0000        	call	c_eewrw
7640  14f8 85            	popw	x
7641  14f9 ac531753      	jpf	L1013
7642  14fd               L3433:
7643                     ; 1906 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7645  14fd b6cd          	ld	a,_mess+6
7646  14ff a1ff          	cp	a,#255
7647  1501 2703          	jreq	L212
7648  1503 cc15b9        	jp	L3633
7649  1506               L212:
7651  1506 b6ce          	ld	a,_mess+7
7652  1508 a1ff          	cp	a,#255
7653  150a 2703          	jreq	L412
7654  150c cc15b9        	jp	L3633
7655  150f               L412:
7657  150f b6cf          	ld	a,_mess+8
7658  1511 a126          	cp	a,#38
7659  1513 2709          	jreq	L5633
7661  1515 b6cf          	ld	a,_mess+8
7662  1517 a129          	cp	a,#41
7663  1519 2703          	jreq	L612
7664  151b cc15b9        	jp	L3633
7665  151e               L612:
7666  151e               L5633:
7667                     ; 1909 	tempSS=mess[9]+(mess[10]*256);
7669  151e b6d1          	ld	a,_mess+10
7670  1520 5f            	clrw	x
7671  1521 97            	ld	xl,a
7672  1522 4f            	clr	a
7673  1523 02            	rlwa	x,a
7674  1524 01            	rrwa	x,a
7675  1525 bbd0          	add	a,_mess+9
7676  1527 2401          	jrnc	L651
7677  1529 5c            	incw	x
7678  152a               L651:
7679  152a 02            	rlwa	x,a
7680  152b 1f03          	ldw	(OFST-4,sp),x
7681  152d 01            	rrwa	x,a
7682                     ; 1911 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7684  152e ce000c        	ldw	x,_ee_UAVT
7685  1531 1303          	cpw	x,(OFST-4,sp)
7686  1533 270a          	jreq	L7633
7689  1535 1e03          	ldw	x,(OFST-4,sp)
7690  1537 89            	pushw	x
7691  1538 ae000c        	ldw	x,#_ee_UAVT
7692  153b cd0000        	call	c_eewrw
7694  153e 85            	popw	x
7695  153f               L7633:
7696                     ; 1912 	tempSS=(signed short)mess[11];
7698  153f b6d2          	ld	a,_mess+11
7699  1541 5f            	clrw	x
7700  1542 97            	ld	xl,a
7701  1543 1f03          	ldw	(OFST-4,sp),x
7702                     ; 1913 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7704  1545 ce0010        	ldw	x,_ee_tmax
7705  1548 1303          	cpw	x,(OFST-4,sp)
7706  154a 270a          	jreq	L1733
7709  154c 1e03          	ldw	x,(OFST-4,sp)
7710  154e 89            	pushw	x
7711  154f ae0010        	ldw	x,#_ee_tmax
7712  1552 cd0000        	call	c_eewrw
7714  1555 85            	popw	x
7715  1556               L1733:
7716                     ; 1914 	tempSS=(signed short)mess[12];
7718  1556 b6d3          	ld	a,_mess+12
7719  1558 5f            	clrw	x
7720  1559 97            	ld	xl,a
7721  155a 1f03          	ldw	(OFST-4,sp),x
7722                     ; 1915 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7724  155c ce000e        	ldw	x,_ee_tsign
7725  155f 1303          	cpw	x,(OFST-4,sp)
7726  1561 270a          	jreq	L3733
7729  1563 1e03          	ldw	x,(OFST-4,sp)
7730  1565 89            	pushw	x
7731  1566 ae000e        	ldw	x,#_ee_tsign
7732  1569 cd0000        	call	c_eewrw
7734  156c 85            	popw	x
7735  156d               L3733:
7736                     ; 1918 	if(mess[8]==MEM_KF1)
7738  156d b6cf          	ld	a,_mess+8
7739  156f a126          	cp	a,#38
7740  1571 260e          	jrne	L5733
7741                     ; 1920 		if(ee_DEVICE!=0)ee_DEVICE=0;
7743  1573 ce0004        	ldw	x,_ee_DEVICE
7744  1576 2709          	jreq	L5733
7747  1578 5f            	clrw	x
7748  1579 89            	pushw	x
7749  157a ae0004        	ldw	x,#_ee_DEVICE
7750  157d cd0000        	call	c_eewrw
7752  1580 85            	popw	x
7753  1581               L5733:
7754                     ; 1923 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7756  1581 b6cf          	ld	a,_mess+8
7757  1583 a129          	cp	a,#41
7758  1585 2703          	jreq	L022
7759  1587 cc1753        	jp	L1013
7760  158a               L022:
7761                     ; 1925 		if(ee_DEVICE!=1)ee_DEVICE=1;
7763  158a ce0004        	ldw	x,_ee_DEVICE
7764  158d a30001        	cpw	x,#1
7765  1590 270b          	jreq	L3043
7768  1592 ae0001        	ldw	x,#1
7769  1595 89            	pushw	x
7770  1596 ae0004        	ldw	x,#_ee_DEVICE
7771  1599 cd0000        	call	c_eewrw
7773  159c 85            	popw	x
7774  159d               L3043:
7775                     ; 1926 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7777  159d b6d4          	ld	a,_mess+13
7778  159f 5f            	clrw	x
7779  15a0 97            	ld	xl,a
7780  15a1 c30002        	cpw	x,_ee_IMAXVENT
7781  15a4 2603          	jrne	L222
7782  15a6 cc1753        	jp	L1013
7783  15a9               L222:
7786  15a9 b6d4          	ld	a,_mess+13
7787  15ab 5f            	clrw	x
7788  15ac 97            	ld	xl,a
7789  15ad 89            	pushw	x
7790  15ae ae0002        	ldw	x,#_ee_IMAXVENT
7791  15b1 cd0000        	call	c_eewrw
7793  15b4 85            	popw	x
7794  15b5 ac531753      	jpf	L1013
7795  15b9               L3633:
7796                     ; 1931 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7798  15b9 b6cd          	ld	a,_mess+6
7799  15bb c100f7        	cp	a,_adress
7800  15be 262d          	jrne	L1143
7802  15c0 b6ce          	ld	a,_mess+7
7803  15c2 c100f7        	cp	a,_adress
7804  15c5 2626          	jrne	L1143
7806  15c7 b6cf          	ld	a,_mess+8
7807  15c9 a116          	cp	a,#22
7808  15cb 2620          	jrne	L1143
7810  15cd b6d0          	ld	a,_mess+9
7811  15cf a163          	cp	a,#99
7812  15d1 261a          	jrne	L1143
7813                     ; 1933 	flags&=0b11100001;
7815  15d3 b605          	ld	a,_flags
7816  15d5 a4e1          	and	a,#225
7817  15d7 b705          	ld	_flags,a
7818                     ; 1934 	tsign_cnt=0;
7820  15d9 5f            	clrw	x
7821  15da bf59          	ldw	_tsign_cnt,x
7822                     ; 1935 	tmax_cnt=0;
7824  15dc 5f            	clrw	x
7825  15dd bf57          	ldw	_tmax_cnt,x
7826                     ; 1936 	umax_cnt=0;
7828  15df 5f            	clrw	x
7829  15e0 bf70          	ldw	_umax_cnt,x
7830                     ; 1937 	umin_cnt=0;
7832  15e2 5f            	clrw	x
7833  15e3 bf6e          	ldw	_umin_cnt,x
7834                     ; 1938 	led_drv_cnt=30;
7836  15e5 351e0016      	mov	_led_drv_cnt,#30
7838  15e9 ac531753      	jpf	L1013
7839  15ed               L1143:
7840                     ; 1941 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7842  15ed b6cd          	ld	a,_mess+6
7843  15ef c100f7        	cp	a,_adress
7844  15f2 2620          	jrne	L5143
7846  15f4 b6ce          	ld	a,_mess+7
7847  15f6 c100f7        	cp	a,_adress
7848  15f9 2619          	jrne	L5143
7850  15fb b6cf          	ld	a,_mess+8
7851  15fd a116          	cp	a,#22
7852  15ff 2613          	jrne	L5143
7854  1601 b6d0          	ld	a,_mess+9
7855  1603 a164          	cp	a,#100
7856  1605 260d          	jrne	L5143
7857                     ; 1943 	vent_resurs=0;
7859  1607 5f            	clrw	x
7860  1608 89            	pushw	x
7861  1609 ae0000        	ldw	x,#_vent_resurs
7862  160c cd0000        	call	c_eewrw
7864  160f 85            	popw	x
7866  1610 ac531753      	jpf	L1013
7867  1614               L5143:
7868                     ; 1947 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7870  1614 b6cd          	ld	a,_mess+6
7871  1616 a1ff          	cp	a,#255
7872  1618 265f          	jrne	L1243
7874  161a b6ce          	ld	a,_mess+7
7875  161c a1ff          	cp	a,#255
7876  161e 2659          	jrne	L1243
7878  1620 b6cf          	ld	a,_mess+8
7879  1622 a116          	cp	a,#22
7880  1624 2653          	jrne	L1243
7882  1626 b6d0          	ld	a,_mess+9
7883  1628 a116          	cp	a,#22
7884  162a 264d          	jrne	L1243
7885                     ; 1949 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7887  162c b6d1          	ld	a,_mess+10
7888  162e a155          	cp	a,#85
7889  1630 260f          	jrne	L3243
7891  1632 b6d2          	ld	a,_mess+11
7892  1634 a155          	cp	a,#85
7893  1636 2609          	jrne	L3243
7896  1638 be68          	ldw	x,__x_
7897  163a 1c0001        	addw	x,#1
7898  163d bf68          	ldw	__x_,x
7900  163f 2024          	jra	L5243
7901  1641               L3243:
7902                     ; 1950 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7904  1641 b6d1          	ld	a,_mess+10
7905  1643 a166          	cp	a,#102
7906  1645 260f          	jrne	L7243
7908  1647 b6d2          	ld	a,_mess+11
7909  1649 a166          	cp	a,#102
7910  164b 2609          	jrne	L7243
7913  164d be68          	ldw	x,__x_
7914  164f 1d0001        	subw	x,#1
7915  1652 bf68          	ldw	__x_,x
7917  1654 200f          	jra	L5243
7918  1656               L7243:
7919                     ; 1951 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7921  1656 b6d1          	ld	a,_mess+10
7922  1658 a177          	cp	a,#119
7923  165a 2609          	jrne	L5243
7925  165c b6d2          	ld	a,_mess+11
7926  165e a177          	cp	a,#119
7927  1660 2603          	jrne	L5243
7930  1662 5f            	clrw	x
7931  1663 bf68          	ldw	__x_,x
7932  1665               L5243:
7933                     ; 1952      gran(&_x_,-XMAX,XMAX);
7935  1665 ae0019        	ldw	x,#25
7936  1668 89            	pushw	x
7937  1669 aeffe7        	ldw	x,#65511
7938  166c 89            	pushw	x
7939  166d ae0068        	ldw	x,#__x_
7940  1670 cd00d5        	call	_gran
7942  1673 5b04          	addw	sp,#4
7944  1675 ac531753      	jpf	L1013
7945  1679               L1243:
7946                     ; 1954 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7948  1679 b6cd          	ld	a,_mess+6
7949  167b c100f7        	cp	a,_adress
7950  167e 2635          	jrne	L7343
7952  1680 b6ce          	ld	a,_mess+7
7953  1682 c100f7        	cp	a,_adress
7954  1685 262e          	jrne	L7343
7956  1687 b6cf          	ld	a,_mess+8
7957  1689 a116          	cp	a,#22
7958  168b 2628          	jrne	L7343
7960  168d b6d0          	ld	a,_mess+9
7961  168f b1d1          	cp	a,_mess+10
7962  1691 2622          	jrne	L7343
7964  1693 b6d0          	ld	a,_mess+9
7965  1695 a1ee          	cp	a,#238
7966  1697 261c          	jrne	L7343
7967                     ; 1956 	rotor_int++;
7969  1699 be17          	ldw	x,_rotor_int
7970  169b 1c0001        	addw	x,#1
7971  169e bf17          	ldw	_rotor_int,x
7972                     ; 1957      tempI=pwm_u;
7974                     ; 1959 	UU_AVT=Un;
7976  16a0 ce000e        	ldw	x,_Un
7977  16a3 89            	pushw	x
7978  16a4 ae0008        	ldw	x,#_UU_AVT
7979  16a7 cd0000        	call	c_eewrw
7981  16aa 85            	popw	x
7982                     ; 1960 	delay_ms(100);
7984  16ab ae0064        	ldw	x,#100
7985  16ae cd0121        	call	_delay_ms
7988  16b1 ac531753      	jpf	L1013
7989  16b5               L7343:
7990                     ; 1966 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7992  16b5 b6ce          	ld	a,_mess+7
7993  16b7 a1da          	cp	a,#218
7994  16b9 2653          	jrne	L3443
7996  16bb b6cd          	ld	a,_mess+6
7997  16bd c100f7        	cp	a,_adress
7998  16c0 274c          	jreq	L3443
8000  16c2 b6cd          	ld	a,_mess+6
8001  16c4 a106          	cp	a,#6
8002  16c6 2446          	jruge	L3443
8003                     ; 1968 	i_main_bps_cnt[mess[6]]=0;
8005  16c8 b6cd          	ld	a,_mess+6
8006  16ca 5f            	clrw	x
8007  16cb 97            	ld	xl,a
8008  16cc 6f13          	clr	(_i_main_bps_cnt,x)
8009                     ; 1969 	i_main_flag[mess[6]]=1;
8011  16ce b6cd          	ld	a,_mess+6
8012  16d0 5f            	clrw	x
8013  16d1 97            	ld	xl,a
8014  16d2 a601          	ld	a,#1
8015  16d4 e71e          	ld	(_i_main_flag,x),a
8016                     ; 1970 	if(bMAIN)
8018                     	btst	_bMAIN
8019  16db 2476          	jruge	L1013
8020                     ; 1972 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8022  16dd b6d0          	ld	a,_mess+9
8023  16df 5f            	clrw	x
8024  16e0 97            	ld	xl,a
8025  16e1 4f            	clr	a
8026  16e2 02            	rlwa	x,a
8027  16e3 1f01          	ldw	(OFST-6,sp),x
8028  16e5 b6cf          	ld	a,_mess+8
8029  16e7 5f            	clrw	x
8030  16e8 97            	ld	xl,a
8031  16e9 72fb01        	addw	x,(OFST-6,sp)
8032  16ec b6cd          	ld	a,_mess+6
8033  16ee 905f          	clrw	y
8034  16f0 9097          	ld	yl,a
8035  16f2 9058          	sllw	y
8036  16f4 90ef24        	ldw	(_i_main,y),x
8037                     ; 1973 		i_main[adress]=I;
8039  16f7 c600f7        	ld	a,_adress
8040  16fa 5f            	clrw	x
8041  16fb 97            	ld	xl,a
8042  16fc 58            	sllw	x
8043  16fd 90ce0010      	ldw	y,_I
8044  1701 ef24          	ldw	(_i_main,x),y
8045                     ; 1974      	i_main_flag[adress]=1;
8047  1703 c600f7        	ld	a,_adress
8048  1706 5f            	clrw	x
8049  1707 97            	ld	xl,a
8050  1708 a601          	ld	a,#1
8051  170a e71e          	ld	(_i_main_flag,x),a
8052  170c 2045          	jra	L1013
8053  170e               L3443:
8054                     ; 1978 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8056  170e b6ce          	ld	a,_mess+7
8057  1710 a1db          	cp	a,#219
8058  1712 263f          	jrne	L1013
8060  1714 b6cd          	ld	a,_mess+6
8061  1716 c100f7        	cp	a,_adress
8062  1719 2738          	jreq	L1013
8064  171b b6cd          	ld	a,_mess+6
8065  171d a106          	cp	a,#6
8066  171f 2432          	jruge	L1013
8067                     ; 1980 	i_main_bps_cnt[mess[6]]=0;
8069  1721 b6cd          	ld	a,_mess+6
8070  1723 5f            	clrw	x
8071  1724 97            	ld	xl,a
8072  1725 6f13          	clr	(_i_main_bps_cnt,x)
8073                     ; 1981 	i_main_flag[mess[6]]=1;		
8075  1727 b6cd          	ld	a,_mess+6
8076  1729 5f            	clrw	x
8077  172a 97            	ld	xl,a
8078  172b a601          	ld	a,#1
8079  172d e71e          	ld	(_i_main_flag,x),a
8080                     ; 1982 	if(bMAIN)
8082                     	btst	_bMAIN
8083  1734 241d          	jruge	L1013
8084                     ; 1984 		if(mess[9]==0)i_main_flag[i]=1;
8086  1736 3dd0          	tnz	_mess+9
8087  1738 260a          	jrne	L5543
8090  173a 7b07          	ld	a,(OFST+0,sp)
8091  173c 5f            	clrw	x
8092  173d 97            	ld	xl,a
8093  173e a601          	ld	a,#1
8094  1740 e71e          	ld	(_i_main_flag,x),a
8096  1742 2006          	jra	L7543
8097  1744               L5543:
8098                     ; 1985 		else i_main_flag[i]=0;
8100  1744 7b07          	ld	a,(OFST+0,sp)
8101  1746 5f            	clrw	x
8102  1747 97            	ld	xl,a
8103  1748 6f1e          	clr	(_i_main_flag,x)
8104  174a               L7543:
8105                     ; 1986 		i_main_flag[adress]=1;
8107  174a c600f7        	ld	a,_adress
8108  174d 5f            	clrw	x
8109  174e 97            	ld	xl,a
8110  174f a601          	ld	a,#1
8111  1751 e71e          	ld	(_i_main_flag,x),a
8112  1753               L1013:
8113                     ; 1992 can_in_an_end:
8113                     ; 1993 bCAN_RX=0;
8115  1753 3f04          	clr	_bCAN_RX
8116                     ; 1994 }   
8119  1755 5b07          	addw	sp,#7
8120  1757 81            	ret
8143                     ; 1997 void t4_init(void){
8144                     	switch	.text
8145  1758               _t4_init:
8149                     ; 1998 	TIM4->PSCR = 6;
8151  1758 35065345      	mov	21317,#6
8152                     ; 1999 	TIM4->ARR= 61;
8154  175c 353d5346      	mov	21318,#61
8155                     ; 2000 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8157  1760 72105341      	bset	21313,#0
8158                     ; 2002 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8160  1764 35855340      	mov	21312,#133
8161                     ; 2004 }
8164  1768 81            	ret
8187                     ; 2007 void t1_init(void)
8187                     ; 2008 {
8188                     	switch	.text
8189  1769               _t1_init:
8193                     ; 2009 TIM1->ARRH= 0x07;
8195  1769 35075262      	mov	21090,#7
8196                     ; 2010 TIM1->ARRL= 0xff;
8198  176d 35ff5263      	mov	21091,#255
8199                     ; 2011 TIM1->CCR1H= 0x00;	
8201  1771 725f5265      	clr	21093
8202                     ; 2012 TIM1->CCR1L= 0xff;
8204  1775 35ff5266      	mov	21094,#255
8205                     ; 2013 TIM1->CCR2H= 0x00;	
8207  1779 725f5267      	clr	21095
8208                     ; 2014 TIM1->CCR2L= 0x00;
8210  177d 725f5268      	clr	21096
8211                     ; 2015 TIM1->CCR3H= 0x00;	
8213  1781 725f5269      	clr	21097
8214                     ; 2016 TIM1->CCR3L= 0x64;
8216  1785 3564526a      	mov	21098,#100
8217                     ; 2018 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8219  1789 35685258      	mov	21080,#104
8220                     ; 2019 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8222  178d 35685259      	mov	21081,#104
8223                     ; 2020 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8225  1791 3568525a      	mov	21082,#104
8226                     ; 2021 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8228  1795 3511525c      	mov	21084,#17
8229                     ; 2022 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8231  1799 3501525d      	mov	21085,#1
8232                     ; 2023 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8234  179d 35815250      	mov	21072,#129
8235                     ; 2024 TIM1->BKR|= TIM1_BKR_AOE;
8237  17a1 721c526d      	bset	21101,#6
8238                     ; 2025 }
8241  17a5 81            	ret
8266                     ; 2029 void adc2_init(void)
8266                     ; 2030 {
8267                     	switch	.text
8268  17a6               _adc2_init:
8272                     ; 2031 adc_plazma[0]++;
8274  17a6 beb9          	ldw	x,_adc_plazma
8275  17a8 1c0001        	addw	x,#1
8276  17ab bfb9          	ldw	_adc_plazma,x
8277                     ; 2055 GPIOB->DDR&=~(1<<4);
8279  17ad 72195007      	bres	20487,#4
8280                     ; 2056 GPIOB->CR1&=~(1<<4);
8282  17b1 72195008      	bres	20488,#4
8283                     ; 2057 GPIOB->CR2&=~(1<<4);
8285  17b5 72195009      	bres	20489,#4
8286                     ; 2059 GPIOB->DDR&=~(1<<5);
8288  17b9 721b5007      	bres	20487,#5
8289                     ; 2060 GPIOB->CR1&=~(1<<5);
8291  17bd 721b5008      	bres	20488,#5
8292                     ; 2061 GPIOB->CR2&=~(1<<5);
8294  17c1 721b5009      	bres	20489,#5
8295                     ; 2063 GPIOB->DDR&=~(1<<6);
8297  17c5 721d5007      	bres	20487,#6
8298                     ; 2064 GPIOB->CR1&=~(1<<6);
8300  17c9 721d5008      	bres	20488,#6
8301                     ; 2065 GPIOB->CR2&=~(1<<6);
8303  17cd 721d5009      	bres	20489,#6
8304                     ; 2067 GPIOB->DDR&=~(1<<7);
8306  17d1 721f5007      	bres	20487,#7
8307                     ; 2068 GPIOB->CR1&=~(1<<7);
8309  17d5 721f5008      	bres	20488,#7
8310                     ; 2069 GPIOB->CR2&=~(1<<7);
8312  17d9 721f5009      	bres	20489,#7
8313                     ; 2071 GPIOB->DDR&=~(1<<2);
8315  17dd 72155007      	bres	20487,#2
8316                     ; 2072 GPIOB->CR1&=~(1<<2);
8318  17e1 72155008      	bres	20488,#2
8319                     ; 2073 GPIOB->CR2&=~(1<<2);
8321  17e5 72155009      	bres	20489,#2
8322                     ; 2082 ADC2->TDRL=0xff;
8324  17e9 35ff5407      	mov	21511,#255
8325                     ; 2084 ADC2->CR2=0x08;
8327  17ed 35085402      	mov	21506,#8
8328                     ; 2085 ADC2->CR1=0x60;
8330  17f1 35605401      	mov	21505,#96
8331                     ; 2088 	if(adc_ch==5)ADC2->CSR=0x22;
8333  17f5 b6c6          	ld	a,_adc_ch
8334  17f7 a105          	cp	a,#5
8335  17f9 2606          	jrne	L1153
8338  17fb 35225400      	mov	21504,#34
8340  17ff 2007          	jra	L3153
8341  1801               L1153:
8342                     ; 2089 	else ADC2->CSR=0x20+adc_ch+3;
8344  1801 b6c6          	ld	a,_adc_ch
8345  1803 ab23          	add	a,#35
8346  1805 c75400        	ld	21504,a
8347  1808               L3153:
8348                     ; 2091 	ADC2->CR1|=1;
8350  1808 72105401      	bset	21505,#0
8351                     ; 2092 	ADC2->CR1|=1;
8353  180c 72105401      	bset	21505,#0
8354                     ; 2095 adc_plazma[1]=adc_ch;
8356  1810 b6c6          	ld	a,_adc_ch
8357  1812 5f            	clrw	x
8358  1813 97            	ld	xl,a
8359  1814 bfbb          	ldw	_adc_plazma+2,x
8360                     ; 2096 }
8363  1816 81            	ret
8401                     ; 2104 @far @interrupt void TIM4_UPD_Interrupt (void) 
8401                     ; 2105 {
8403                     	switch	.text
8404  1817               f_TIM4_UPD_Interrupt:
8408                     ; 2106 TIM4->SR1&=~TIM4_SR1_UIF;
8410  1817 72115342      	bres	21314,#0
8411                     ; 2108 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8413  181b 3c12          	inc	_pwm_vent_cnt
8414  181d b612          	ld	a,_pwm_vent_cnt
8415  181f a10a          	cp	a,#10
8416  1821 2502          	jrult	L5253
8419  1823 3f12          	clr	_pwm_vent_cnt
8420  1825               L5253:
8421                     ; 2109 GPIOB->ODR|=(1<<3);
8423  1825 72165005      	bset	20485,#3
8424                     ; 2110 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8426  1829 b612          	ld	a,_pwm_vent_cnt
8427  182b a105          	cp	a,#5
8428  182d 2504          	jrult	L7253
8431  182f 72175005      	bres	20485,#3
8432  1833               L7253:
8433                     ; 2114 if(++t0_cnt00>=10)
8435  1833 9c            	rvf
8436  1834 ce0000        	ldw	x,_t0_cnt00
8437  1837 1c0001        	addw	x,#1
8438  183a cf0000        	ldw	_t0_cnt00,x
8439  183d a3000a        	cpw	x,#10
8440  1840 2f08          	jrslt	L1353
8441                     ; 2116 	t0_cnt00=0;
8443  1842 5f            	clrw	x
8444  1843 cf0000        	ldw	_t0_cnt00,x
8445                     ; 2117 	b1000Hz=1;
8447  1846 72100005      	bset	_b1000Hz
8448  184a               L1353:
8449                     ; 2120 if(++t0_cnt0>=100)
8451  184a 9c            	rvf
8452  184b ce0002        	ldw	x,_t0_cnt0
8453  184e 1c0001        	addw	x,#1
8454  1851 cf0002        	ldw	_t0_cnt0,x
8455  1854 a30064        	cpw	x,#100
8456  1857 2f67          	jrslt	L3353
8457                     ; 2122 	t0_cnt0=0;
8459  1859 5f            	clrw	x
8460  185a cf0002        	ldw	_t0_cnt0,x
8461                     ; 2123 	b100Hz=1;
8463  185d 7210000a      	bset	_b100Hz
8464                     ; 2125 	if(++t0_cnt5>=5)
8466  1861 725c0008      	inc	_t0_cnt5
8467  1865 c60008        	ld	a,_t0_cnt5
8468  1868 a105          	cp	a,#5
8469  186a 2508          	jrult	L5353
8470                     ; 2127 		t0_cnt5=0;
8472  186c 725f0008      	clr	_t0_cnt5
8473                     ; 2128 		b20Hz=1;
8475  1870 72100004      	bset	_b20Hz
8476  1874               L5353:
8477                     ; 2131 	if(++t0_cnt1>=10)
8479  1874 725c0004      	inc	_t0_cnt1
8480  1878 c60004        	ld	a,_t0_cnt1
8481  187b a10a          	cp	a,#10
8482  187d 2508          	jrult	L7353
8483                     ; 2133 		t0_cnt1=0;
8485  187f 725f0004      	clr	_t0_cnt1
8486                     ; 2134 		b10Hz=1;
8488  1883 72100009      	bset	_b10Hz
8489  1887               L7353:
8490                     ; 2137 	if(++t0_cnt2>=20)
8492  1887 725c0005      	inc	_t0_cnt2
8493  188b c60005        	ld	a,_t0_cnt2
8494  188e a114          	cp	a,#20
8495  1890 2508          	jrult	L1453
8496                     ; 2139 		t0_cnt2=0;
8498  1892 725f0005      	clr	_t0_cnt2
8499                     ; 2140 		b5Hz=1;
8501  1896 72100008      	bset	_b5Hz
8502  189a               L1453:
8503                     ; 2144 	if(++t0_cnt4>=50)
8505  189a 725c0007      	inc	_t0_cnt4
8506  189e c60007        	ld	a,_t0_cnt4
8507  18a1 a132          	cp	a,#50
8508  18a3 2508          	jrult	L3453
8509                     ; 2146 		t0_cnt4=0;
8511  18a5 725f0007      	clr	_t0_cnt4
8512                     ; 2147 		b2Hz=1;
8514  18a9 72100007      	bset	_b2Hz
8515  18ad               L3453:
8516                     ; 2150 	if(++t0_cnt3>=100)
8518  18ad 725c0006      	inc	_t0_cnt3
8519  18b1 c60006        	ld	a,_t0_cnt3
8520  18b4 a164          	cp	a,#100
8521  18b6 2508          	jrult	L3353
8522                     ; 2152 		t0_cnt3=0;
8524  18b8 725f0006      	clr	_t0_cnt3
8525                     ; 2153 		b1Hz=1;
8527  18bc 72100006      	bset	_b1Hz
8528  18c0               L3353:
8529                     ; 2159 }
8532  18c0 80            	iret
8557                     ; 2162 @far @interrupt void CAN_RX_Interrupt (void) 
8557                     ; 2163 {
8558                     	switch	.text
8559  18c1               f_CAN_RX_Interrupt:
8563                     ; 2165 CAN->PSR= 7;									// page 7 - read messsage
8565  18c1 35075427      	mov	21543,#7
8566                     ; 2167 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8568  18c5 ae000e        	ldw	x,#14
8569  18c8               L632:
8570  18c8 d65427        	ld	a,(21543,x)
8571  18cb e7c6          	ld	(_mess-1,x),a
8572  18cd 5a            	decw	x
8573  18ce 26f8          	jrne	L632
8574                     ; 2178 bCAN_RX=1;
8576  18d0 35010004      	mov	_bCAN_RX,#1
8577                     ; 2179 CAN->RFR|=(1<<5);
8579  18d4 721a5424      	bset	21540,#5
8580                     ; 2181 }
8583  18d8 80            	iret
8606                     ; 2184 @far @interrupt void CAN_TX_Interrupt (void) 
8606                     ; 2185 {
8607                     	switch	.text
8608  18d9               f_CAN_TX_Interrupt:
8612                     ; 2186 if((CAN->TSR)&(1<<0))
8614  18d9 c65422        	ld	a,21538
8615  18dc a501          	bcp	a,#1
8616  18de 2708          	jreq	L7653
8617                     ; 2188 	bTX_FREE=1;	
8619  18e0 35010003      	mov	_bTX_FREE,#1
8620                     ; 2190 	CAN->TSR|=(1<<0);
8622  18e4 72105422      	bset	21538,#0
8623  18e8               L7653:
8624                     ; 2192 }
8627  18e8 80            	iret
8707                     ; 2195 @far @interrupt void ADC2_EOC_Interrupt (void) {
8708                     	switch	.text
8709  18e9               f_ADC2_EOC_Interrupt:
8711       0000000d      OFST:	set	13
8712  18e9 be00          	ldw	x,c_x
8713  18eb 89            	pushw	x
8714  18ec be00          	ldw	x,c_y
8715  18ee 89            	pushw	x
8716  18ef be02          	ldw	x,c_lreg+2
8717  18f1 89            	pushw	x
8718  18f2 be00          	ldw	x,c_lreg
8719  18f4 89            	pushw	x
8720  18f5 520d          	subw	sp,#13
8723                     ; 2200 adc_plazma[2]++;
8725  18f7 bebd          	ldw	x,_adc_plazma+4
8726  18f9 1c0001        	addw	x,#1
8727  18fc bfbd          	ldw	_adc_plazma+4,x
8728                     ; 2207 ADC2->CSR&=~(1<<7);
8730  18fe 721f5400      	bres	21504,#7
8731                     ; 2209 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8733  1902 c65405        	ld	a,21509
8734  1905 b703          	ld	c_lreg+3,a
8735  1907 3f02          	clr	c_lreg+2
8736  1909 3f01          	clr	c_lreg+1
8737  190b 3f00          	clr	c_lreg
8738  190d 96            	ldw	x,sp
8739  190e 1c0001        	addw	x,#OFST-12
8740  1911 cd0000        	call	c_rtol
8742  1914 c65404        	ld	a,21508
8743  1917 5f            	clrw	x
8744  1918 97            	ld	xl,a
8745  1919 90ae0100      	ldw	y,#256
8746  191d cd0000        	call	c_umul
8748  1920 96            	ldw	x,sp
8749  1921 1c0001        	addw	x,#OFST-12
8750  1924 cd0000        	call	c_ladd
8752  1927 96            	ldw	x,sp
8753  1928 1c000a        	addw	x,#OFST-3
8754  192b cd0000        	call	c_rtol
8756                     ; 2214 if(adr_drv_stat==1)
8758  192e b602          	ld	a,_adr_drv_stat
8759  1930 a101          	cp	a,#1
8760  1932 260b          	jrne	L7263
8761                     ; 2216 	adr_drv_stat=2;
8763  1934 35020002      	mov	_adr_drv_stat,#2
8764                     ; 2217 	adc_buff_[0]=temp_adc;
8766  1938 1e0c          	ldw	x,(OFST-1,sp)
8767  193a cf00ff        	ldw	_adc_buff_,x
8769  193d 2020          	jra	L1363
8770  193f               L7263:
8771                     ; 2220 else if(adr_drv_stat==3)
8773  193f b602          	ld	a,_adr_drv_stat
8774  1941 a103          	cp	a,#3
8775  1943 260b          	jrne	L3363
8776                     ; 2222 	adr_drv_stat=4;
8778  1945 35040002      	mov	_adr_drv_stat,#4
8779                     ; 2223 	adc_buff_[1]=temp_adc;
8781  1949 1e0c          	ldw	x,(OFST-1,sp)
8782  194b cf0101        	ldw	_adc_buff_+2,x
8784  194e 200f          	jra	L1363
8785  1950               L3363:
8786                     ; 2226 else if(adr_drv_stat==5)
8788  1950 b602          	ld	a,_adr_drv_stat
8789  1952 a105          	cp	a,#5
8790  1954 2609          	jrne	L1363
8791                     ; 2228 	adr_drv_stat=6;
8793  1956 35060002      	mov	_adr_drv_stat,#6
8794                     ; 2229 	adc_buff_[9]=temp_adc;
8796  195a 1e0c          	ldw	x,(OFST-1,sp)
8797  195c cf0111        	ldw	_adc_buff_+18,x
8798  195f               L1363:
8799                     ; 2232 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8801  195f b6b7          	ld	a,_adc_cnt_cnt
8802  1961 5f            	clrw	x
8803  1962 97            	ld	xl,a
8804  1963 58            	sllw	x
8805  1964 1f03          	ldw	(OFST-10,sp),x
8806  1966 b6c6          	ld	a,_adc_ch
8807  1968 97            	ld	xl,a
8808  1969 a610          	ld	a,#16
8809  196b 42            	mul	x,a
8810  196c 72fb03        	addw	x,(OFST-10,sp)
8811  196f 160c          	ldw	y,(OFST-1,sp)
8812  1971 df0056        	ldw	(_adc_buff_buff,x),y
8813                     ; 2234 adc_ch++;
8815  1974 3cc6          	inc	_adc_ch
8816                     ; 2235 if(adc_ch>=6)
8818  1976 b6c6          	ld	a,_adc_ch
8819  1978 a106          	cp	a,#6
8820  197a 2516          	jrult	L1463
8821                     ; 2237 	adc_ch=0;
8823  197c 3fc6          	clr	_adc_ch
8824                     ; 2238 	adc_cnt_cnt++;
8826  197e 3cb7          	inc	_adc_cnt_cnt
8827                     ; 2239 	if(adc_cnt_cnt>=8)
8829  1980 b6b7          	ld	a,_adc_cnt_cnt
8830  1982 a108          	cp	a,#8
8831  1984 250c          	jrult	L1463
8832                     ; 2241 		adc_cnt_cnt=0;
8834  1986 3fb7          	clr	_adc_cnt_cnt
8835                     ; 2242 		adc_cnt++;
8837  1988 3cc5          	inc	_adc_cnt
8838                     ; 2243 		if(adc_cnt>=16)
8840  198a b6c5          	ld	a,_adc_cnt
8841  198c a110          	cp	a,#16
8842  198e 2502          	jrult	L1463
8843                     ; 2245 			adc_cnt=0;
8845  1990 3fc5          	clr	_adc_cnt
8846  1992               L1463:
8847                     ; 2249 if(adc_cnt_cnt==0)
8849  1992 3db7          	tnz	_adc_cnt_cnt
8850  1994 2660          	jrne	L7463
8851                     ; 2253 	tempSS=0;
8853  1996 ae0000        	ldw	x,#0
8854  1999 1f07          	ldw	(OFST-6,sp),x
8855  199b ae0000        	ldw	x,#0
8856  199e 1f05          	ldw	(OFST-8,sp),x
8857                     ; 2254 	for(i=0;i<8;i++)
8859  19a0 0f09          	clr	(OFST-4,sp)
8860  19a2               L1563:
8861                     ; 2256 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8863  19a2 7b09          	ld	a,(OFST-4,sp)
8864  19a4 5f            	clrw	x
8865  19a5 97            	ld	xl,a
8866  19a6 58            	sllw	x
8867  19a7 1f03          	ldw	(OFST-10,sp),x
8868  19a9 b6c6          	ld	a,_adc_ch
8869  19ab 97            	ld	xl,a
8870  19ac a610          	ld	a,#16
8871  19ae 42            	mul	x,a
8872  19af 72fb03        	addw	x,(OFST-10,sp)
8873  19b2 de0056        	ldw	x,(_adc_buff_buff,x)
8874  19b5 cd0000        	call	c_itolx
8876  19b8 96            	ldw	x,sp
8877  19b9 1c0005        	addw	x,#OFST-8
8878  19bc cd0000        	call	c_lgadd
8880                     ; 2254 	for(i=0;i<8;i++)
8882  19bf 0c09          	inc	(OFST-4,sp)
8885  19c1 7b09          	ld	a,(OFST-4,sp)
8886  19c3 a108          	cp	a,#8
8887  19c5 25db          	jrult	L1563
8888                     ; 2258 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8890  19c7 96            	ldw	x,sp
8891  19c8 1c0005        	addw	x,#OFST-8
8892  19cb cd0000        	call	c_ltor
8894  19ce a603          	ld	a,#3
8895  19d0 cd0000        	call	c_lrsh
8897  19d3 be02          	ldw	x,c_lreg+2
8898  19d5 b6c5          	ld	a,_adc_cnt
8899  19d7 905f          	clrw	y
8900  19d9 9097          	ld	yl,a
8901  19db 9058          	sllw	y
8902  19dd 1703          	ldw	(OFST-10,sp),y
8903  19df b6c6          	ld	a,_adc_ch
8904  19e1 905f          	clrw	y
8905  19e3 9097          	ld	yl,a
8906  19e5 9058          	sllw	y
8907  19e7 9058          	sllw	y
8908  19e9 9058          	sllw	y
8909  19eb 9058          	sllw	y
8910  19ed 9058          	sllw	y
8911  19ef 72f903        	addw	y,(OFST-10,sp)
8912  19f2 90df0113      	ldw	(_adc_buff,y),x
8913  19f6               L7463:
8914                     ; 2262 if((adc_cnt&0x03)==0)
8916  19f6 b6c5          	ld	a,_adc_cnt
8917  19f8 a503          	bcp	a,#3
8918  19fa 264b          	jrne	L7563
8919                     ; 2266 	tempSS=0;
8921  19fc ae0000        	ldw	x,#0
8922  19ff 1f07          	ldw	(OFST-6,sp),x
8923  1a01 ae0000        	ldw	x,#0
8924  1a04 1f05          	ldw	(OFST-8,sp),x
8925                     ; 2267 	for(i=0;i<16;i++)
8927  1a06 0f09          	clr	(OFST-4,sp)
8928  1a08               L1663:
8929                     ; 2269 		tempSS+=(signed long)adc_buff[adc_ch][i];
8931  1a08 7b09          	ld	a,(OFST-4,sp)
8932  1a0a 5f            	clrw	x
8933  1a0b 97            	ld	xl,a
8934  1a0c 58            	sllw	x
8935  1a0d 1f03          	ldw	(OFST-10,sp),x
8936  1a0f b6c6          	ld	a,_adc_ch
8937  1a11 97            	ld	xl,a
8938  1a12 a620          	ld	a,#32
8939  1a14 42            	mul	x,a
8940  1a15 72fb03        	addw	x,(OFST-10,sp)
8941  1a18 de0113        	ldw	x,(_adc_buff,x)
8942  1a1b cd0000        	call	c_itolx
8944  1a1e 96            	ldw	x,sp
8945  1a1f 1c0005        	addw	x,#OFST-8
8946  1a22 cd0000        	call	c_lgadd
8948                     ; 2267 	for(i=0;i<16;i++)
8950  1a25 0c09          	inc	(OFST-4,sp)
8953  1a27 7b09          	ld	a,(OFST-4,sp)
8954  1a29 a110          	cp	a,#16
8955  1a2b 25db          	jrult	L1663
8956                     ; 2271 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8958  1a2d 96            	ldw	x,sp
8959  1a2e 1c0005        	addw	x,#OFST-8
8960  1a31 cd0000        	call	c_ltor
8962  1a34 a604          	ld	a,#4
8963  1a36 cd0000        	call	c_lrsh
8965  1a39 be02          	ldw	x,c_lreg+2
8966  1a3b b6c6          	ld	a,_adc_ch
8967  1a3d 905f          	clrw	y
8968  1a3f 9097          	ld	yl,a
8969  1a41 9058          	sllw	y
8970  1a43 90df00ff      	ldw	(_adc_buff_,y),x
8971  1a47               L7563:
8972                     ; 2278 if(adc_ch==0)adc_buff_5=temp_adc;
8974  1a47 3dc6          	tnz	_adc_ch
8975  1a49 2605          	jrne	L7663
8978  1a4b 1e0c          	ldw	x,(OFST-1,sp)
8979  1a4d cf00fd        	ldw	_adc_buff_5,x
8980  1a50               L7663:
8981                     ; 2279 if(adc_ch==2)adc_buff_1=temp_adc;
8983  1a50 b6c6          	ld	a,_adc_ch
8984  1a52 a102          	cp	a,#2
8985  1a54 2605          	jrne	L1763
8988  1a56 1e0c          	ldw	x,(OFST-1,sp)
8989  1a58 cf00fb        	ldw	_adc_buff_1,x
8990  1a5b               L1763:
8991                     ; 2281 adc_plazma_short++;
8993  1a5b bec3          	ldw	x,_adc_plazma_short
8994  1a5d 1c0001        	addw	x,#1
8995  1a60 bfc3          	ldw	_adc_plazma_short,x
8996                     ; 2283 }
8999  1a62 5b0d          	addw	sp,#13
9000  1a64 85            	popw	x
9001  1a65 bf00          	ldw	c_lreg,x
9002  1a67 85            	popw	x
9003  1a68 bf02          	ldw	c_lreg+2,x
9004  1a6a 85            	popw	x
9005  1a6b bf00          	ldw	c_y,x
9006  1a6d 85            	popw	x
9007  1a6e bf00          	ldw	c_x,x
9008  1a70 80            	iret
9068                     ; 2292 main()
9068                     ; 2293 {
9070                     	switch	.text
9071  1a71               _main:
9075                     ; 2295 CLK->ECKR|=1;
9077  1a71 721050c1      	bset	20673,#0
9079  1a75               L5073:
9080                     ; 2296 while((CLK->ECKR & 2) == 0);
9082  1a75 c650c1        	ld	a,20673
9083  1a78 a502          	bcp	a,#2
9084  1a7a 27f9          	jreq	L5073
9085                     ; 2297 CLK->SWCR|=2;
9087  1a7c 721250c5      	bset	20677,#1
9088                     ; 2298 CLK->SWR=0xB4;
9090  1a80 35b450c4      	mov	20676,#180
9091                     ; 2300 delay_ms(200);
9093  1a84 ae00c8        	ldw	x,#200
9094  1a87 cd0121        	call	_delay_ms
9096                     ; 2301 FLASH_DUKR=0xae;
9098  1a8a 35ae5064      	mov	_FLASH_DUKR,#174
9099                     ; 2302 FLASH_DUKR=0x56;
9101  1a8e 35565064      	mov	_FLASH_DUKR,#86
9102                     ; 2303 enableInterrupts();
9105  1a92 9a            rim
9107                     ; 2306 adr_drv_v3();
9110  1a93 cd0d5e        	call	_adr_drv_v3
9112                     ; 2310 t4_init();
9114  1a96 cd1758        	call	_t4_init
9116                     ; 2312 		GPIOG->DDR|=(1<<0);
9118  1a99 72105020      	bset	20512,#0
9119                     ; 2313 		GPIOG->CR1|=(1<<0);
9121  1a9d 72105021      	bset	20513,#0
9122                     ; 2314 		GPIOG->CR2&=~(1<<0);	
9124  1aa1 72115022      	bres	20514,#0
9125                     ; 2317 		GPIOG->DDR&=~(1<<1);
9127  1aa5 72135020      	bres	20512,#1
9128                     ; 2318 		GPIOG->CR1|=(1<<1);
9130  1aa9 72125021      	bset	20513,#1
9131                     ; 2319 		GPIOG->CR2&=~(1<<1);
9133  1aad 72135022      	bres	20514,#1
9134                     ; 2321 init_CAN();
9136  1ab1 cd0f4e        	call	_init_CAN
9138                     ; 2326 GPIOC->DDR|=(1<<1);
9140  1ab4 7212500c      	bset	20492,#1
9141                     ; 2327 GPIOC->CR1|=(1<<1);
9143  1ab8 7212500d      	bset	20493,#1
9144                     ; 2328 GPIOC->CR2|=(1<<1);
9146  1abc 7212500e      	bset	20494,#1
9147                     ; 2330 GPIOC->DDR|=(1<<2);
9149  1ac0 7214500c      	bset	20492,#2
9150                     ; 2331 GPIOC->CR1|=(1<<2);
9152  1ac4 7214500d      	bset	20493,#2
9153                     ; 2332 GPIOC->CR2|=(1<<2);
9155  1ac8 7214500e      	bset	20494,#2
9156                     ; 2339 t1_init();
9158  1acc cd1769        	call	_t1_init
9160                     ; 2341 GPIOA->DDR|=(1<<5);
9162  1acf 721a5002      	bset	20482,#5
9163                     ; 2342 GPIOA->CR1|=(1<<5);
9165  1ad3 721a5003      	bset	20483,#5
9166                     ; 2343 GPIOA->CR2&=~(1<<5);
9168  1ad7 721b5004      	bres	20484,#5
9169                     ; 2349 GPIOB->DDR&=~(1<<3);
9171  1adb 72175007      	bres	20487,#3
9172                     ; 2350 GPIOB->CR1&=~(1<<3);
9174  1adf 72175008      	bres	20488,#3
9175                     ; 2351 GPIOB->CR2&=~(1<<3);
9177  1ae3 72175009      	bres	20489,#3
9178                     ; 2353 GPIOC->DDR|=(1<<3);
9180  1ae7 7216500c      	bset	20492,#3
9181                     ; 2354 GPIOC->CR1|=(1<<3);
9183  1aeb 7216500d      	bset	20493,#3
9184                     ; 2355 GPIOC->CR2|=(1<<3);
9186  1aef 7216500e      	bset	20494,#3
9187  1af3               L1173:
9188                     ; 2361 	if(b1000Hz)
9190                     	btst	_b1000Hz
9191  1af8 2407          	jruge	L5173
9192                     ; 2363 		b1000Hz=0;
9194  1afa 72110005      	bres	_b1000Hz
9195                     ; 2365 		adc2_init();
9197  1afe cd17a6        	call	_adc2_init
9199  1b01               L5173:
9200                     ; 2368 	if(bCAN_RX)
9202  1b01 3d04          	tnz	_bCAN_RX
9203  1b03 2705          	jreq	L7173
9204                     ; 2370 		bCAN_RX=0;
9206  1b05 3f04          	clr	_bCAN_RX
9207                     ; 2371 		can_in_an();	
9209  1b07 cd10ab        	call	_can_in_an
9211  1b0a               L7173:
9212                     ; 2373 	if(b100Hz)
9214                     	btst	_b100Hz
9215  1b0f 2407          	jruge	L1273
9216                     ; 2375 		b100Hz=0;
9218  1b11 7211000a      	bres	_b100Hz
9219                     ; 2385 		can_tx_hndl();
9221  1b15 cd1041        	call	_can_tx_hndl
9223  1b18               L1273:
9224                     ; 2388 	if(b20Hz)
9226                     	btst	_b20Hz
9227  1b1d 2407          	jruge	L3273
9228                     ; 2390 		b20Hz=0;
9230  1b1f 72110004      	bres	_b20Hz
9231                     ; 2392 		led_drv(); 
9233  1b23 cd03ee        	call	_led_drv
9235  1b26               L3273:
9236                     ; 2396 	if(b10Hz)
9238                     	btst	_b10Hz
9239  1b2b 2422          	jruge	L5273
9240                     ; 2398 		b10Hz=0;
9242  1b2d 72110009      	bres	_b10Hz
9243                     ; 2400 		matemat();
9245  1b31 cd0885        	call	_matemat
9247                     ; 2402 	  link_drv();
9249  1b34 cd04dc        	call	_link_drv
9251                     ; 2404 	  JP_drv();
9253  1b37 cd0451        	call	_JP_drv
9255                     ; 2405 	  flags_drv();
9257  1b3a cd0d13        	call	_flags_drv
9259                     ; 2407 		if(main_cnt10<100)main_cnt10++;
9261  1b3d 9c            	rvf
9262  1b3e ce0253        	ldw	x,_main_cnt10
9263  1b41 a30064        	cpw	x,#100
9264  1b44 2e09          	jrsge	L5273
9267  1b46 ce0253        	ldw	x,_main_cnt10
9268  1b49 1c0001        	addw	x,#1
9269  1b4c cf0253        	ldw	_main_cnt10,x
9270  1b4f               L5273:
9271                     ; 2410 	if(b5Hz)
9273                     	btst	_b5Hz
9274  1b54 241c          	jruge	L1373
9275                     ; 2412 		b5Hz=0;
9277  1b56 72110008      	bres	_b5Hz
9278                     ; 2418 		pwr_drv();		//воздействие на силу
9280  1b5a cd06ac        	call	_pwr_drv
9282                     ; 2419 		led_hndl();
9284  1b5d cd0163        	call	_led_hndl
9286                     ; 2421 		vent_drv();
9288  1b60 cd0534        	call	_vent_drv
9290                     ; 2423 		if(main_cnt1<1000)main_cnt1++;
9292  1b63 9c            	rvf
9293  1b64 be5b          	ldw	x,_main_cnt1
9294  1b66 a303e8        	cpw	x,#1000
9295  1b69 2e07          	jrsge	L1373
9298  1b6b be5b          	ldw	x,_main_cnt1
9299  1b6d 1c0001        	addw	x,#1
9300  1b70 bf5b          	ldw	_main_cnt1,x
9301  1b72               L1373:
9302                     ; 2426 	if(b2Hz)
9304                     	btst	_b2Hz
9305  1b77 240d          	jruge	L5373
9306                     ; 2428 		b2Hz=0;
9308  1b79 72110007      	bres	_b2Hz
9309                     ; 2432 		temper_drv();
9311  1b7d cd0a80        	call	_temper_drv
9313                     ; 2433 		u_drv();
9315  1b80 cd0b57        	call	_u_drv
9317                     ; 2434 		vent_resurs_hndl();
9319  1b83 cd0000        	call	_vent_resurs_hndl
9321  1b86               L5373:
9322                     ; 2437 	if(b1Hz)
9324                     	btst	_b1Hz
9325  1b8b 2503cc1af3    	jruge	L1173
9326                     ; 2439 		b1Hz=0;
9328  1b90 72110006      	bres	_b1Hz
9329                     ; 2441 	  pwr_hndl();		//вычисление воздействий на силу
9331  1b94 cd06f4        	call	_pwr_hndl
9333                     ; 2445 		if(main_cnt<1000)main_cnt++;
9335  1b97 9c            	rvf
9336  1b98 ce0255        	ldw	x,_main_cnt
9337  1b9b a303e8        	cpw	x,#1000
9338  1b9e 2e09          	jrsge	L1473
9341  1ba0 ce0255        	ldw	x,_main_cnt
9342  1ba3 1c0001        	addw	x,#1
9343  1ba6 cf0255        	ldw	_main_cnt,x
9344  1ba9               L1473:
9345                     ; 2446   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9347  1ba9 b66d          	ld	a,_link
9348  1bab a1aa          	cp	a,#170
9349  1bad 2706          	jreq	L5473
9351  1baf b654          	ld	a,_jp_mode
9352  1bb1 a103          	cp	a,#3
9353  1bb3 2603          	jrne	L3473
9354  1bb5               L5473:
9357  1bb5 cd0c74        	call	_apv_hndl
9359  1bb8               L3473:
9360                     ; 2449   		can_error_cnt++;
9362  1bb8 3c73          	inc	_can_error_cnt
9363                     ; 2450   		if(can_error_cnt>=10)
9365  1bba b673          	ld	a,_can_error_cnt
9366  1bbc a10a          	cp	a,#10
9367  1bbe 2505          	jrult	L7473
9368                     ; 2452   			can_error_cnt=0;
9370  1bc0 3f73          	clr	_can_error_cnt
9371                     ; 2453 				init_CAN();
9373  1bc2 cd0f4e        	call	_init_CAN
9375  1bc5               L7473:
9376                     ; 2464 		debug_info_to_uku[2]++;
9378  1bc5 be05          	ldw	x,_debug_info_to_uku+4
9379  1bc7 1c0001        	addw	x,#1
9380  1bca bf05          	ldw	_debug_info_to_uku+4,x
9381  1bcc acf31af3      	jpf	L1173
10638                     	xdef	_main
10639                     	xdef	f_ADC2_EOC_Interrupt
10640                     	xdef	f_CAN_TX_Interrupt
10641                     	xdef	f_CAN_RX_Interrupt
10642                     	xdef	f_TIM4_UPD_Interrupt
10643                     	xdef	_adc2_init
10644                     	xdef	_t1_init
10645                     	xdef	_t4_init
10646                     	xdef	_can_in_an
10647                     	xdef	_can_tx_hndl
10648                     	xdef	_can_transmit
10649                     	xdef	_init_CAN
10650                     	xdef	_adr_drv_v3
10651                     	xdef	_adr_drv_v4
10652                     	xdef	_flags_drv
10653                     	xdef	_apv_hndl
10654                     	xdef	_apv_stop
10655                     	xdef	_apv_start
10656                     	xdef	_u_drv
10657                     	xdef	_temper_drv
10658                     	xdef	_matemat
10659                     	xdef	_pwr_hndl
10660                     	xdef	_pwr_drv
10661                     	xdef	_vent_drv
10662                     	xdef	_link_drv
10663                     	xdef	_JP_drv
10664                     	xdef	_led_drv
10665                     	xdef	_led_hndl
10666                     	xdef	_delay_ms
10667                     	xdef	_granee
10668                     	xdef	_gran
10669                     	xdef	_vent_resurs_hndl
10670                     	switch	.ubsct
10671  0001               _debug_info_to_uku:
10672  0001 000000000000  	ds.b	6
10673                     	xdef	_debug_info_to_uku
10674  0007               _pwm_u_cnt:
10675  0007 00            	ds.b	1
10676                     	xdef	_pwm_u_cnt
10677  0008               _vent_resurs_tx_cnt:
10678  0008 00            	ds.b	1
10679                     	xdef	_vent_resurs_tx_cnt
10680                     	switch	.bss
10681  0000               _vent_resurs_buff:
10682  0000 00000000      	ds.b	4
10683                     	xdef	_vent_resurs_buff
10684                     	switch	.ubsct
10685  0009               _vent_resurs_sec_cnt:
10686  0009 0000          	ds.b	2
10687                     	xdef	_vent_resurs_sec_cnt
10688                     .eeprom:	section	.data
10689  0000               _vent_resurs:
10690  0000 0000          	ds.b	2
10691                     	xdef	_vent_resurs
10692  0002               _ee_IMAXVENT:
10693  0002 0000          	ds.b	2
10694                     	xdef	_ee_IMAXVENT
10695                     	switch	.ubsct
10696  000b               _bps_class:
10697  000b 00            	ds.b	1
10698                     	xdef	_bps_class
10699  000c               _vent_pwm_integr_cnt:
10700  000c 0000          	ds.b	2
10701                     	xdef	_vent_pwm_integr_cnt
10702  000e               _vent_pwm_integr:
10703  000e 0000          	ds.b	2
10704                     	xdef	_vent_pwm_integr
10705  0010               _vent_pwm:
10706  0010 0000          	ds.b	2
10707                     	xdef	_vent_pwm
10708  0012               _pwm_vent_cnt:
10709  0012 00            	ds.b	1
10710                     	xdef	_pwm_vent_cnt
10711                     	switch	.eeprom
10712  0004               _ee_DEVICE:
10713  0004 0000          	ds.b	2
10714                     	xdef	_ee_DEVICE
10715  0006               _ee_AVT_MODE:
10716  0006 0000          	ds.b	2
10717                     	xdef	_ee_AVT_MODE
10718                     	switch	.ubsct
10719  0013               _i_main_bps_cnt:
10720  0013 000000000000  	ds.b	6
10721                     	xdef	_i_main_bps_cnt
10722  0019               _i_main_sigma:
10723  0019 0000          	ds.b	2
10724                     	xdef	_i_main_sigma
10725  001b               _i_main_num_of_bps:
10726  001b 00            	ds.b	1
10727                     	xdef	_i_main_num_of_bps
10728  001c               _i_main_avg:
10729  001c 0000          	ds.b	2
10730                     	xdef	_i_main_avg
10731  001e               _i_main_flag:
10732  001e 000000000000  	ds.b	6
10733                     	xdef	_i_main_flag
10734  0024               _i_main:
10735  0024 000000000000  	ds.b	12
10736                     	xdef	_i_main
10737  0030               _x:
10738  0030 000000000000  	ds.b	12
10739                     	xdef	_x
10740                     	xdef	_volum_u_main_
10741                     	switch	.eeprom
10742  0008               _UU_AVT:
10743  0008 0000          	ds.b	2
10744                     	xdef	_UU_AVT
10745                     	switch	.ubsct
10746  003c               _cnt_net_drv:
10747  003c 00            	ds.b	1
10748                     	xdef	_cnt_net_drv
10749                     	switch	.bit
10750  0001               _bMAIN:
10751  0001 00            	ds.b	1
10752                     	xdef	_bMAIN
10753                     	switch	.ubsct
10754  003d               _plazma_int:
10755  003d 000000000000  	ds.b	6
10756                     	xdef	_plazma_int
10757                     	xdef	_rotor_int
10758  0043               _led_green_buff:
10759  0043 00000000      	ds.b	4
10760                     	xdef	_led_green_buff
10761  0047               _led_red_buff:
10762  0047 00000000      	ds.b	4
10763                     	xdef	_led_red_buff
10764                     	xdef	_led_drv_cnt
10765                     	xdef	_led_green
10766                     	xdef	_led_red
10767  004b               _res_fl_cnt:
10768  004b 00            	ds.b	1
10769                     	xdef	_res_fl_cnt
10770                     	xdef	_bRES_
10771                     	xdef	_bRES
10772                     	switch	.eeprom
10773  000a               _res_fl_:
10774  000a 00            	ds.b	1
10775                     	xdef	_res_fl_
10776  000b               _res_fl:
10777  000b 00            	ds.b	1
10778                     	xdef	_res_fl
10779                     	switch	.ubsct
10780  004c               _cnt_apv_off:
10781  004c 00            	ds.b	1
10782                     	xdef	_cnt_apv_off
10783                     	switch	.bit
10784  0002               _bAPV:
10785  0002 00            	ds.b	1
10786                     	xdef	_bAPV
10787                     	switch	.ubsct
10788  004d               _apv_cnt_:
10789  004d 0000          	ds.b	2
10790                     	xdef	_apv_cnt_
10791  004f               _apv_cnt:
10792  004f 000000        	ds.b	3
10793                     	xdef	_apv_cnt
10794                     	xdef	_bBL_IPS
10795                     	switch	.bit
10796  0003               _bBL:
10797  0003 00            	ds.b	1
10798                     	xdef	_bBL
10799                     	switch	.ubsct
10800  0052               _cnt_JP1:
10801  0052 00            	ds.b	1
10802                     	xdef	_cnt_JP1
10803  0053               _cnt_JP0:
10804  0053 00            	ds.b	1
10805                     	xdef	_cnt_JP0
10806  0054               _jp_mode:
10807  0054 00            	ds.b	1
10808                     	xdef	_jp_mode
10809  0055               _pwm_u_:
10810  0055 0000          	ds.b	2
10811                     	xdef	_pwm_u_
10812                     	xdef	_pwm_i
10813                     	xdef	_pwm_u
10814  0057               _tmax_cnt:
10815  0057 0000          	ds.b	2
10816                     	xdef	_tmax_cnt
10817  0059               _tsign_cnt:
10818  0059 0000          	ds.b	2
10819                     	xdef	_tsign_cnt
10820                     	switch	.eeprom
10821  000c               _ee_UAVT:
10822  000c 0000          	ds.b	2
10823                     	xdef	_ee_UAVT
10824  000e               _ee_tsign:
10825  000e 0000          	ds.b	2
10826                     	xdef	_ee_tsign
10827  0010               _ee_tmax:
10828  0010 0000          	ds.b	2
10829                     	xdef	_ee_tmax
10830  0012               _ee_dU:
10831  0012 0000          	ds.b	2
10832                     	xdef	_ee_dU
10833  0014               _ee_Umax:
10834  0014 0000          	ds.b	2
10835                     	xdef	_ee_Umax
10836  0016               _ee_TZAS:
10837  0016 0000          	ds.b	2
10838                     	xdef	_ee_TZAS
10839                     	switch	.ubsct
10840  005b               _main_cnt1:
10841  005b 0000          	ds.b	2
10842                     	xdef	_main_cnt1
10843  005d               _off_bp_cnt:
10844  005d 00            	ds.b	1
10845                     	xdef	_off_bp_cnt
10846                     	xdef	_vol_i_temp_avar
10847  005e               _flags_tu_cnt_off:
10848  005e 00            	ds.b	1
10849                     	xdef	_flags_tu_cnt_off
10850  005f               _flags_tu_cnt_on:
10851  005f 00            	ds.b	1
10852                     	xdef	_flags_tu_cnt_on
10853  0060               _vol_i_temp:
10854  0060 0000          	ds.b	2
10855                     	xdef	_vol_i_temp
10856  0062               _vol_u_temp:
10857  0062 0000          	ds.b	2
10858                     	xdef	_vol_u_temp
10859                     	switch	.eeprom
10860  0018               __x_ee_:
10861  0018 0000          	ds.b	2
10862                     	xdef	__x_ee_
10863                     	switch	.ubsct
10864  0064               __x_cnt:
10865  0064 0000          	ds.b	2
10866                     	xdef	__x_cnt
10867  0066               __x__:
10868  0066 0000          	ds.b	2
10869                     	xdef	__x__
10870  0068               __x_:
10871  0068 0000          	ds.b	2
10872                     	xdef	__x_
10873  006a               _flags_tu:
10874  006a 00            	ds.b	1
10875                     	xdef	_flags_tu
10876                     	xdef	_flags
10877  006b               _link_cnt:
10878  006b 0000          	ds.b	2
10879                     	xdef	_link_cnt
10880  006d               _link:
10881  006d 00            	ds.b	1
10882                     	xdef	_link
10883  006e               _umin_cnt:
10884  006e 0000          	ds.b	2
10885                     	xdef	_umin_cnt
10886  0070               _umax_cnt:
10887  0070 0000          	ds.b	2
10888                     	xdef	_umax_cnt
10889                     	switch	.eeprom
10890  001a               _ee_K:
10891  001a 000000000000  	ds.b	20
10892                     	xdef	_ee_K
10893                     	switch	.ubsct
10894  0072               _T:
10895  0072 00            	ds.b	1
10896                     	xdef	_T
10897                     	switch	.bss
10898  0004               _Uin:
10899  0004 0000          	ds.b	2
10900                     	xdef	_Uin
10901  0006               _Usum:
10902  0006 0000          	ds.b	2
10903                     	xdef	_Usum
10904  0008               _U_out_const:
10905  0008 0000          	ds.b	2
10906                     	xdef	_U_out_const
10907  000a               _Unecc:
10908  000a 0000          	ds.b	2
10909                     	xdef	_Unecc
10910  000c               _Ui:
10911  000c 0000          	ds.b	2
10912                     	xdef	_Ui
10913  000e               _Un:
10914  000e 0000          	ds.b	2
10915                     	xdef	_Un
10916  0010               _I:
10917  0010 0000          	ds.b	2
10918                     	xdef	_I
10919                     	switch	.ubsct
10920  0073               _can_error_cnt:
10921  0073 00            	ds.b	1
10922                     	xdef	_can_error_cnt
10923                     	xdef	_bCAN_RX
10924  0074               _tx_busy_cnt:
10925  0074 00            	ds.b	1
10926                     	xdef	_tx_busy_cnt
10927                     	xdef	_bTX_FREE
10928  0075               _can_buff_rd_ptr:
10929  0075 00            	ds.b	1
10930                     	xdef	_can_buff_rd_ptr
10931  0076               _can_buff_wr_ptr:
10932  0076 00            	ds.b	1
10933                     	xdef	_can_buff_wr_ptr
10934  0077               _can_out_buff:
10935  0077 000000000000  	ds.b	64
10936                     	xdef	_can_out_buff
10937                     	switch	.bss
10938  0012               _pwm_u_buff_cnt:
10939  0012 00            	ds.b	1
10940                     	xdef	_pwm_u_buff_cnt
10941  0013               _pwm_u_buff_ptr:
10942  0013 00            	ds.b	1
10943                     	xdef	_pwm_u_buff_ptr
10944  0014               _pwm_u_buff_:
10945  0014 0000          	ds.b	2
10946                     	xdef	_pwm_u_buff_
10947  0016               _pwm_u_buff:
10948  0016 000000000000  	ds.b	64
10949                     	xdef	_pwm_u_buff
10950                     	switch	.ubsct
10951  00b7               _adc_cnt_cnt:
10952  00b7 00            	ds.b	1
10953                     	xdef	_adc_cnt_cnt
10954                     	switch	.bss
10955  0056               _adc_buff_buff:
10956  0056 000000000000  	ds.b	160
10957                     	xdef	_adc_buff_buff
10958  00f6               _adress_error:
10959  00f6 00            	ds.b	1
10960                     	xdef	_adress_error
10961  00f7               _adress:
10962  00f7 00            	ds.b	1
10963                     	xdef	_adress
10964  00f8               _adr:
10965  00f8 000000        	ds.b	3
10966                     	xdef	_adr
10967                     	xdef	_adr_drv_stat
10968                     	xdef	_led_ind
10969                     	switch	.ubsct
10970  00b8               _led_ind_cnt:
10971  00b8 00            	ds.b	1
10972                     	xdef	_led_ind_cnt
10973  00b9               _adc_plazma:
10974  00b9 000000000000  	ds.b	10
10975                     	xdef	_adc_plazma
10976  00c3               _adc_plazma_short:
10977  00c3 0000          	ds.b	2
10978                     	xdef	_adc_plazma_short
10979  00c5               _adc_cnt:
10980  00c5 00            	ds.b	1
10981                     	xdef	_adc_cnt
10982  00c6               _adc_ch:
10983  00c6 00            	ds.b	1
10984                     	xdef	_adc_ch
10985                     	switch	.bss
10986  00fb               _adc_buff_1:
10987  00fb 0000          	ds.b	2
10988                     	xdef	_adc_buff_1
10989  00fd               _adc_buff_5:
10990  00fd 0000          	ds.b	2
10991                     	xdef	_adc_buff_5
10992  00ff               _adc_buff_:
10993  00ff 000000000000  	ds.b	20
10994                     	xdef	_adc_buff_
10995  0113               _adc_buff:
10996  0113 000000000000  	ds.b	320
10997                     	xdef	_adc_buff
10998  0253               _main_cnt10:
10999  0253 0000          	ds.b	2
11000                     	xdef	_main_cnt10
11001  0255               _main_cnt:
11002  0255 0000          	ds.b	2
11003                     	xdef	_main_cnt
11004                     	switch	.ubsct
11005  00c7               _mess:
11006  00c7 000000000000  	ds.b	14
11007                     	xdef	_mess
11008                     	switch	.bit
11009  0004               _b20Hz:
11010  0004 00            	ds.b	1
11011                     	xdef	_b20Hz
11012  0005               _b1000Hz:
11013  0005 00            	ds.b	1
11014                     	xdef	_b1000Hz
11015  0006               _b1Hz:
11016  0006 00            	ds.b	1
11017                     	xdef	_b1Hz
11018  0007               _b2Hz:
11019  0007 00            	ds.b	1
11020                     	xdef	_b2Hz
11021  0008               _b5Hz:
11022  0008 00            	ds.b	1
11023                     	xdef	_b5Hz
11024  0009               _b10Hz:
11025  0009 00            	ds.b	1
11026                     	xdef	_b10Hz
11027  000a               _b100Hz:
11028  000a 00            	ds.b	1
11029                     	xdef	_b100Hz
11030                     	xdef	_t0_cnt5
11031                     	xdef	_t0_cnt4
11032                     	xdef	_t0_cnt3
11033                     	xdef	_t0_cnt2
11034                     	xdef	_t0_cnt1
11035                     	xdef	_t0_cnt0
11036                     	xdef	_t0_cnt00
11037                     	xref	_abs
11038                     	xdef	_bVENT_BLOCK
11039                     	xref.b	c_lreg
11040                     	xref.b	c_x
11041                     	xref.b	c_y
11061                     	xref	c_lrsh
11062                     	xref	c_umul
11063                     	xref	c_lgsub
11064                     	xref	c_lgrsh
11065                     	xref	c_lgadd
11066                     	xref	c_idiv
11067                     	xref	c_sdivx
11068                     	xref	c_imul
11069                     	xref	c_lsbc
11070                     	xref	c_ladd
11071                     	xref	c_lsub
11072                     	xref	c_ldiv
11073                     	xref	c_lgmul
11074                     	xref	c_itolx
11075                     	xref	c_eewrc
11076                     	xref	c_ltor
11077                     	xref	c_lgadc
11078                     	xref	c_rtol
11079                     	xref	c_vmul
11080                     	xref	c_eewrw
11081                     	xref	c_lcmp
11082                     	xref	c_uitolx
11083                     	end
