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
2272                     ; 191 void vent_resurs_hndl(void)
2272                     ; 192 {
2273                     	scross	off
2274                     	switch	.text
2275  0000               _vent_resurs_hndl:
2277  0000 88            	push	a
2278       00000001      OFST:	set	1
2281                     ; 194 if(vent_pwm>100)vent_resurs_sec_cnt++;
2283  0001 9c            	rvf
2284  0002 be10          	ldw	x,_vent_pwm
2285  0004 a30065        	cpw	x,#101
2286  0007 2f07          	jrslt	L7441
2289  0009 be09          	ldw	x,_vent_resurs_sec_cnt
2290  000b 1c0001        	addw	x,#1
2291  000e bf09          	ldw	_vent_resurs_sec_cnt,x
2292  0010               L7441:
2293                     ; 195 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2295  0010 be09          	ldw	x,_vent_resurs_sec_cnt
2296  0012 a30e11        	cpw	x,#3601
2297  0015 251b          	jrult	L1541
2298                     ; 197 	if(vent_resurs<60000)vent_resurs++;
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
2314                     ; 198 	vent_resurs_sec_cnt=0;
2316  002f 5f            	clrw	x
2317  0030 bf09          	ldw	_vent_resurs_sec_cnt,x
2318  0032               L1541:
2319                     ; 203 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2321  0032 c60001        	ld	a,_vent_resurs+1
2322  0035 a40f          	and	a,#15
2323  0037 c70000        	ld	_vent_resurs_buff,a
2324                     ; 204 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2326  003a c60001        	ld	a,_vent_resurs+1
2327  003d a4f0          	and	a,#240
2328  003f 4e            	swap	a
2329  0040 a40f          	and	a,#15
2330  0042 aa40          	or	a,#64
2331  0044 c70001        	ld	_vent_resurs_buff+1,a
2332                     ; 205 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
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
2347                     ; 206 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
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
2366                     ; 208 temp=vent_resurs_buff[0]&0x0f;
2368  0076 c60000        	ld	a,_vent_resurs_buff
2369  0079 a40f          	and	a,#15
2370  007b 6b01          	ld	(OFST+0,sp),a
2371                     ; 209 temp^=vent_resurs_buff[1]&0x0f;
2373  007d c60001        	ld	a,_vent_resurs_buff+1
2374  0080 a40f          	and	a,#15
2375  0082 1801          	xor	a,(OFST+0,sp)
2376  0084 6b01          	ld	(OFST+0,sp),a
2377                     ; 210 temp^=vent_resurs_buff[2]&0x0f;
2379  0086 c60002        	ld	a,_vent_resurs_buff+2
2380  0089 a40f          	and	a,#15
2381  008b 1801          	xor	a,(OFST+0,sp)
2382  008d 6b01          	ld	(OFST+0,sp),a
2383                     ; 211 temp^=vent_resurs_buff[3]&0x0f;
2385  008f c60003        	ld	a,_vent_resurs_buff+3
2386  0092 a40f          	and	a,#15
2387  0094 1801          	xor	a,(OFST+0,sp)
2388  0096 6b01          	ld	(OFST+0,sp),a
2389                     ; 213 vent_resurs_buff[0]|=(temp&0x03)<<4;
2391  0098 7b01          	ld	a,(OFST+0,sp)
2392  009a a403          	and	a,#3
2393  009c 97            	ld	xl,a
2394  009d a610          	ld	a,#16
2395  009f 42            	mul	x,a
2396  00a0 9f            	ld	a,xl
2397  00a1 ca0000        	or	a,_vent_resurs_buff
2398  00a4 c70000        	ld	_vent_resurs_buff,a
2399                     ; 214 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2401  00a7 7b01          	ld	a,(OFST+0,sp)
2402  00a9 a40c          	and	a,#12
2403  00ab 48            	sll	a
2404  00ac 48            	sll	a
2405  00ad ca0001        	or	a,_vent_resurs_buff+1
2406  00b0 c70001        	ld	_vent_resurs_buff+1,a
2407                     ; 215 vent_resurs_buff[2]|=(temp&0x30);
2409  00b3 7b01          	ld	a,(OFST+0,sp)
2410  00b5 a430          	and	a,#48
2411  00b7 ca0002        	or	a,_vent_resurs_buff+2
2412  00ba c70002        	ld	_vent_resurs_buff+2,a
2413                     ; 216 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2415  00bd 7b01          	ld	a,(OFST+0,sp)
2416  00bf a4c0          	and	a,#192
2417  00c1 44            	srl	a
2418  00c2 44            	srl	a
2419  00c3 ca0003        	or	a,_vent_resurs_buff+3
2420  00c6 c70003        	ld	_vent_resurs_buff+3,a
2421                     ; 219 vent_resurs_tx_cnt++;
2423  00c9 3c08          	inc	_vent_resurs_tx_cnt
2424                     ; 220 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2426  00cb b608          	ld	a,_vent_resurs_tx_cnt
2427  00cd a104          	cp	a,#4
2428  00cf 2502          	jrult	L5541
2431  00d1 3f08          	clr	_vent_resurs_tx_cnt
2432  00d3               L5541:
2433                     ; 223 }
2436  00d3 84            	pop	a
2437  00d4 81            	ret
2490                     ; 226 void gran(signed short *adr, signed short min, signed short max)
2490                     ; 227 {
2491                     	switch	.text
2492  00d5               _gran:
2494  00d5 89            	pushw	x
2495       00000000      OFST:	set	0
2498                     ; 228 if (*adr<min) *adr=min;
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
2512                     ; 229 if (*adr>max) *adr=max; 
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
2528                     ; 230 } 
2531  00f4 85            	popw	x
2532  00f5 81            	ret
2585                     ; 233 void granee(@eeprom signed short *adr, signed short min, signed short max)
2585                     ; 234 {
2586                     	switch	.text
2587  00f6               _granee:
2589  00f6 89            	pushw	x
2590       00000000      OFST:	set	0
2593                     ; 235 if (*adr<min) *adr=min;
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
2611                     ; 236 if (*adr>max) *adr=max; 
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
2630                     ; 237 }
2633  011f 85            	popw	x
2634  0120 81            	ret
2695                     ; 240 long delay_ms(short in)
2695                     ; 241 {
2696                     	switch	.text
2697  0121               _delay_ms:
2699  0121 520c          	subw	sp,#12
2700       0000000c      OFST:	set	12
2703                     ; 244 i=((long)in)*100UL;
2705  0123 90ae0064      	ldw	y,#100
2706  0127 cd0000        	call	c_vmul
2708  012a 96            	ldw	x,sp
2709  012b 1c0005        	addw	x,#OFST-7
2710  012e cd0000        	call	c_rtol
2712                     ; 246 for(ii=0;ii<i;ii++)
2714  0131 ae0000        	ldw	x,#0
2715  0134 1f0b          	ldw	(OFST-1,sp),x
2716  0136 ae0000        	ldw	x,#0
2717  0139 1f09          	ldw	(OFST-3,sp),x
2719  013b 2012          	jra	L1061
2720  013d               L5751:
2721                     ; 248 		iii++;
2723  013d 96            	ldw	x,sp
2724  013e 1c0001        	addw	x,#OFST-11
2725  0141 a601          	ld	a,#1
2726  0143 cd0000        	call	c_lgadc
2728                     ; 246 for(ii=0;ii<i;ii++)
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
2748                     ; 251 }
2751  0160 5b0c          	addw	sp,#12
2752  0162 81            	ret
2785                     ; 254 void led_hndl(void)
2785                     ; 255 {
2786                     	switch	.text
2787  0163               _led_hndl:
2791                     ; 256 if(adress_error)
2793  0163 725d0100      	tnz	_adress_error
2794  0167 2714          	jreq	L5161
2795                     ; 258 	led_red=0x55555555L;
2797  0169 ae5555        	ldw	x,#21845
2798  016c bf10          	ldw	_led_red+2,x
2799  016e ae5555        	ldw	x,#21845
2800  0171 bf0e          	ldw	_led_red,x
2801                     ; 259 	led_green=0x55555555L;
2803  0173 ae5555        	ldw	x,#21845
2804  0176 bf14          	ldw	_led_green+2,x
2805  0178 ae5555        	ldw	x,#21845
2806  017b bf12          	ldw	_led_green,x
2807  017d               L5161:
2808                     ; 277 	if(jp_mode!=jp3)
2810  017d b655          	ld	a,_jp_mode
2811  017f a103          	cp	a,#3
2812  0181 2603          	jrne	L02
2813  0183 cc0311        	jp	L7161
2814  0186               L02:
2815                     ; 279 		if(main_cnt1<(5*EE_TZAS))
2817  0186 9c            	rvf
2818  0187 be5e          	ldw	x,_main_cnt1
2819  0189 a3000f        	cpw	x,#15
2820  018c 2e18          	jrsge	L1261
2821                     ; 281 			led_red=0x00000000L;
2823  018e ae0000        	ldw	x,#0
2824  0191 bf10          	ldw	_led_red+2,x
2825  0193 ae0000        	ldw	x,#0
2826  0196 bf0e          	ldw	_led_red,x
2827                     ; 282 			led_green=0x0303030fL;
2829  0198 ae030f        	ldw	x,#783
2830  019b bf14          	ldw	_led_green+2,x
2831  019d ae0303        	ldw	x,#771
2832  01a0 bf12          	ldw	_led_green,x
2834  01a2 acd202d2      	jpf	L3261
2835  01a6               L1261:
2836                     ; 285 		else if((link==ON)&&(flags_tu&0b10000000))
2838  01a6 b670          	ld	a,_link
2839  01a8 a155          	cp	a,#85
2840  01aa 261e          	jrne	L5261
2842  01ac b66d          	ld	a,_flags_tu
2843  01ae a580          	bcp	a,#128
2844  01b0 2718          	jreq	L5261
2845                     ; 287 			led_red=0x00055555L;
2847  01b2 ae5555        	ldw	x,#21845
2848  01b5 bf10          	ldw	_led_red+2,x
2849  01b7 ae0005        	ldw	x,#5
2850  01ba bf0e          	ldw	_led_red,x
2851                     ; 288 			led_green=0xffffffffL;
2853  01bc aeffff        	ldw	x,#65535
2854  01bf bf14          	ldw	_led_green+2,x
2855  01c1 aeffff        	ldw	x,#-1
2856  01c4 bf12          	ldw	_led_green,x
2858  01c6 acd202d2      	jpf	L3261
2859  01ca               L5261:
2860                     ; 291 		else if(((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(100+(5*EE_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
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
2878                     ; 293 			led_red=0x00000000L;
2880  01e7 ae0000        	ldw	x,#0
2881  01ea bf10          	ldw	_led_red+2,x
2882  01ec ae0000        	ldw	x,#0
2883  01ef bf0e          	ldw	_led_red,x
2884                     ; 294 			led_green=0xffffffffL;	
2886  01f1 aeffff        	ldw	x,#65535
2887  01f4 bf14          	ldw	_led_green+2,x
2888  01f6 aeffff        	ldw	x,#-1
2889  01f9 bf12          	ldw	_led_green,x
2891  01fb acd202d2      	jpf	L3261
2892  01ff               L1361:
2893                     ; 297 		else  if(link==OFF)
2895  01ff b670          	ld	a,_link
2896  0201 a1aa          	cp	a,#170
2897  0203 2618          	jrne	L5361
2898                     ; 299 			led_red=0x55555555L;
2900  0205 ae5555        	ldw	x,#21845
2901  0208 bf10          	ldw	_led_red+2,x
2902  020a ae5555        	ldw	x,#21845
2903  020d bf0e          	ldw	_led_red,x
2904                     ; 300 			led_green=0xffffffffL;
2906  020f aeffff        	ldw	x,#65535
2907  0212 bf14          	ldw	_led_green+2,x
2908  0214 aeffff        	ldw	x,#-1
2909  0217 bf12          	ldw	_led_green,x
2911  0219 acd202d2      	jpf	L3261
2912  021d               L5361:
2913                     ; 303 		else if((link==ON)&&((flags&0b00111110)==0))
2915  021d b670          	ld	a,_link
2916  021f a155          	cp	a,#85
2917  0221 261d          	jrne	L1461
2919  0223 b605          	ld	a,_flags
2920  0225 a53e          	bcp	a,#62
2921  0227 2617          	jrne	L1461
2922                     ; 305 			led_red=0x00000000L;
2924  0229 ae0000        	ldw	x,#0
2925  022c bf10          	ldw	_led_red+2,x
2926  022e ae0000        	ldw	x,#0
2927  0231 bf0e          	ldw	_led_red,x
2928                     ; 306 			led_green=0xffffffffL;
2930  0233 aeffff        	ldw	x,#65535
2931  0236 bf14          	ldw	_led_green+2,x
2932  0238 aeffff        	ldw	x,#-1
2933  023b bf12          	ldw	_led_green,x
2935  023d cc02d2        	jra	L3261
2936  0240               L1461:
2937                     ; 309 		else if((flags&0b00111110)==0b00000100)
2939  0240 b605          	ld	a,_flags
2940  0242 a43e          	and	a,#62
2941  0244 a104          	cp	a,#4
2942  0246 2616          	jrne	L5461
2943                     ; 311 			led_red=0x00010001L;
2945  0248 ae0001        	ldw	x,#1
2946  024b bf10          	ldw	_led_red+2,x
2947  024d ae0001        	ldw	x,#1
2948  0250 bf0e          	ldw	_led_red,x
2949                     ; 312 			led_green=0xffffffffL;	
2951  0252 aeffff        	ldw	x,#65535
2952  0255 bf14          	ldw	_led_green+2,x
2953  0257 aeffff        	ldw	x,#-1
2954  025a bf12          	ldw	_led_green,x
2956  025c 2074          	jra	L3261
2957  025e               L5461:
2958                     ; 314 		else if(flags&0b00000010)
2960  025e b605          	ld	a,_flags
2961  0260 a502          	bcp	a,#2
2962  0262 2716          	jreq	L1561
2963                     ; 316 			led_red=0x00010001L;
2965  0264 ae0001        	ldw	x,#1
2966  0267 bf10          	ldw	_led_red+2,x
2967  0269 ae0001        	ldw	x,#1
2968  026c bf0e          	ldw	_led_red,x
2969                     ; 317 			led_green=0x00000000L;	
2971  026e ae0000        	ldw	x,#0
2972  0271 bf14          	ldw	_led_green+2,x
2973  0273 ae0000        	ldw	x,#0
2974  0276 bf12          	ldw	_led_green,x
2976  0278 2058          	jra	L3261
2977  027a               L1561:
2978                     ; 319 		else if(flags&0b00001000)
2980  027a b605          	ld	a,_flags
2981  027c a508          	bcp	a,#8
2982  027e 2716          	jreq	L5561
2983                     ; 321 			led_red=0x00090009L;
2985  0280 ae0009        	ldw	x,#9
2986  0283 bf10          	ldw	_led_red+2,x
2987  0285 ae0009        	ldw	x,#9
2988  0288 bf0e          	ldw	_led_red,x
2989                     ; 322 			led_green=0x00000000L;	
2991  028a ae0000        	ldw	x,#0
2992  028d bf14          	ldw	_led_green+2,x
2993  028f ae0000        	ldw	x,#0
2994  0292 bf12          	ldw	_led_green,x
2996  0294 203c          	jra	L3261
2997  0296               L5561:
2998                     ; 324 		else if(flags&0b00010000)
3000  0296 b605          	ld	a,_flags
3001  0298 a510          	bcp	a,#16
3002  029a 2716          	jreq	L1661
3003                     ; 326 			led_red=0x00490049L;
3005  029c ae0049        	ldw	x,#73
3006  029f bf10          	ldw	_led_red+2,x
3007  02a1 ae0049        	ldw	x,#73
3008  02a4 bf0e          	ldw	_led_red,x
3009                     ; 327 			led_green=0x00000000L;	
3011  02a6 ae0000        	ldw	x,#0
3012  02a9 bf14          	ldw	_led_green+2,x
3013  02ab ae0000        	ldw	x,#0
3014  02ae bf12          	ldw	_led_green,x
3016  02b0 2020          	jra	L3261
3017  02b2               L1661:
3018                     ; 330 		else if((link==ON)&&(flags&0b00100000))
3020  02b2 b670          	ld	a,_link
3021  02b4 a155          	cp	a,#85
3022  02b6 261a          	jrne	L3261
3024  02b8 b605          	ld	a,_flags
3025  02ba a520          	bcp	a,#32
3026  02bc 2714          	jreq	L3261
3027                     ; 332 			led_red=0x00000000L;
3029  02be ae0000        	ldw	x,#0
3030  02c1 bf10          	ldw	_led_red+2,x
3031  02c3 ae0000        	ldw	x,#0
3032  02c6 bf0e          	ldw	_led_red,x
3033                     ; 333 			led_green=0x00030003L;
3035  02c8 ae0003        	ldw	x,#3
3036  02cb bf14          	ldw	_led_green+2,x
3037  02cd ae0003        	ldw	x,#3
3038  02d0 bf12          	ldw	_led_green,x
3039  02d2               L3261:
3040                     ; 336 		if((jp_mode==jp1))
3042  02d2 b655          	ld	a,_jp_mode
3043  02d4 a101          	cp	a,#1
3044  02d6 2618          	jrne	L7661
3045                     ; 338 			led_red=0x00000000L;
3047  02d8 ae0000        	ldw	x,#0
3048  02db bf10          	ldw	_led_red+2,x
3049  02dd ae0000        	ldw	x,#0
3050  02e0 bf0e          	ldw	_led_red,x
3051                     ; 339 			led_green=0x33333333L;
3053  02e2 ae3333        	ldw	x,#13107
3054  02e5 bf14          	ldw	_led_green+2,x
3055  02e7 ae3333        	ldw	x,#13107
3056  02ea bf12          	ldw	_led_green,x
3058  02ec aced03ed      	jpf	L5761
3059  02f0               L7661:
3060                     ; 341 		else if((jp_mode==jp2))
3062  02f0 b655          	ld	a,_jp_mode
3063  02f2 a102          	cp	a,#2
3064  02f4 2703          	jreq	L22
3065  02f6 cc03ed        	jp	L5761
3066  02f9               L22:
3067                     ; 343 			led_red=0xccccccccL;
3069  02f9 aecccc        	ldw	x,#52428
3070  02fc bf10          	ldw	_led_red+2,x
3071  02fe aecccc        	ldw	x,#-13108
3072  0301 bf0e          	ldw	_led_red,x
3073                     ; 344 			led_green=0x00000000L;
3075  0303 ae0000        	ldw	x,#0
3076  0306 bf14          	ldw	_led_green+2,x
3077  0308 ae0000        	ldw	x,#0
3078  030b bf12          	ldw	_led_green,x
3079  030d aced03ed      	jpf	L5761
3080  0311               L7161:
3081                     ; 349 	else if(jp_mode==jp3)
3083  0311 b655          	ld	a,_jp_mode
3084  0313 a103          	cp	a,#3
3085  0315 2703          	jreq	L42
3086  0317 cc03ed        	jp	L5761
3087  031a               L42:
3088                     ; 351 		if(main_cnt1<(5*EE_TZAS))
3090  031a 9c            	rvf
3091  031b be5e          	ldw	x,_main_cnt1
3092  031d a3000f        	cpw	x,#15
3093  0320 2e18          	jrsge	L1071
3094                     ; 353 			led_red=0x00000000L;
3096  0322 ae0000        	ldw	x,#0
3097  0325 bf10          	ldw	_led_red+2,x
3098  0327 ae0000        	ldw	x,#0
3099  032a bf0e          	ldw	_led_red,x
3100                     ; 354 			led_green=0x03030303L;
3102  032c ae0303        	ldw	x,#771
3103  032f bf14          	ldw	_led_green+2,x
3104  0331 ae0303        	ldw	x,#771
3105  0334 bf12          	ldw	_led_green,x
3107  0336 aced03ed      	jpf	L5761
3108  033a               L1071:
3109                     ; 356 		else if((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(70+(5*EE_TZAS))))
3111  033a 9c            	rvf
3112  033b be5e          	ldw	x,_main_cnt1
3113  033d a30010        	cpw	x,#16
3114  0340 2f1f          	jrslt	L5071
3116  0342 9c            	rvf
3117  0343 be5e          	ldw	x,_main_cnt1
3118  0345 a30055        	cpw	x,#85
3119  0348 2e17          	jrsge	L5071
3120                     ; 358 			led_red=0x00000000L;
3122  034a ae0000        	ldw	x,#0
3123  034d bf10          	ldw	_led_red+2,x
3124  034f ae0000        	ldw	x,#0
3125  0352 bf0e          	ldw	_led_red,x
3126                     ; 359 			led_green=0xffffffffL;	
3128  0354 aeffff        	ldw	x,#65535
3129  0357 bf14          	ldw	_led_green+2,x
3130  0359 aeffff        	ldw	x,#-1
3131  035c bf12          	ldw	_led_green,x
3133  035e cc03ed        	jra	L5761
3134  0361               L5071:
3135                     ; 362 		else if((flags&0b00011110)==0)
3137  0361 b605          	ld	a,_flags
3138  0363 a51e          	bcp	a,#30
3139  0365 2616          	jrne	L1171
3140                     ; 364 			led_red=0x00000000L;
3142  0367 ae0000        	ldw	x,#0
3143  036a bf10          	ldw	_led_red+2,x
3144  036c ae0000        	ldw	x,#0
3145  036f bf0e          	ldw	_led_red,x
3146                     ; 365 			led_green=0xffffffffL;
3148  0371 aeffff        	ldw	x,#65535
3149  0374 bf14          	ldw	_led_green+2,x
3150  0376 aeffff        	ldw	x,#-1
3151  0379 bf12          	ldw	_led_green,x
3153  037b 2070          	jra	L5761
3154  037d               L1171:
3155                     ; 369 		else if((flags&0b00111110)==0b00000100)
3157  037d b605          	ld	a,_flags
3158  037f a43e          	and	a,#62
3159  0381 a104          	cp	a,#4
3160  0383 2616          	jrne	L5171
3161                     ; 371 			led_red=0x00010001L;
3163  0385 ae0001        	ldw	x,#1
3164  0388 bf10          	ldw	_led_red+2,x
3165  038a ae0001        	ldw	x,#1
3166  038d bf0e          	ldw	_led_red,x
3167                     ; 372 			led_green=0xffffffffL;	
3169  038f aeffff        	ldw	x,#65535
3170  0392 bf14          	ldw	_led_green+2,x
3171  0394 aeffff        	ldw	x,#-1
3172  0397 bf12          	ldw	_led_green,x
3174  0399 2052          	jra	L5761
3175  039b               L5171:
3176                     ; 374 		else if(flags&0b00000010)
3178  039b b605          	ld	a,_flags
3179  039d a502          	bcp	a,#2
3180  039f 2716          	jreq	L1271
3181                     ; 376 			led_red=0x00010001L;
3183  03a1 ae0001        	ldw	x,#1
3184  03a4 bf10          	ldw	_led_red+2,x
3185  03a6 ae0001        	ldw	x,#1
3186  03a9 bf0e          	ldw	_led_red,x
3187                     ; 377 			led_green=0x00000000L;	
3189  03ab ae0000        	ldw	x,#0
3190  03ae bf14          	ldw	_led_green+2,x
3191  03b0 ae0000        	ldw	x,#0
3192  03b3 bf12          	ldw	_led_green,x
3194  03b5 2036          	jra	L5761
3195  03b7               L1271:
3196                     ; 379 		else if(flags&0b00001000)
3198  03b7 b605          	ld	a,_flags
3199  03b9 a508          	bcp	a,#8
3200  03bb 2716          	jreq	L5271
3201                     ; 381 			led_red=0x00090009L;
3203  03bd ae0009        	ldw	x,#9
3204  03c0 bf10          	ldw	_led_red+2,x
3205  03c2 ae0009        	ldw	x,#9
3206  03c5 bf0e          	ldw	_led_red,x
3207                     ; 382 			led_green=0x00000000L;	
3209  03c7 ae0000        	ldw	x,#0
3210  03ca bf14          	ldw	_led_green+2,x
3211  03cc ae0000        	ldw	x,#0
3212  03cf bf12          	ldw	_led_green,x
3214  03d1 201a          	jra	L5761
3215  03d3               L5271:
3216                     ; 384 		else if(flags&0b00010000)
3218  03d3 b605          	ld	a,_flags
3219  03d5 a510          	bcp	a,#16
3220  03d7 2714          	jreq	L5761
3221                     ; 386 			led_red=0x00490049L;
3223  03d9 ae0049        	ldw	x,#73
3224  03dc bf10          	ldw	_led_red+2,x
3225  03de ae0049        	ldw	x,#73
3226  03e1 bf0e          	ldw	_led_red,x
3227                     ; 387 			led_green=0xffffffffL;	
3229  03e3 aeffff        	ldw	x,#65535
3230  03e6 bf14          	ldw	_led_green+2,x
3231  03e8 aeffff        	ldw	x,#-1
3232  03eb bf12          	ldw	_led_green,x
3233  03ed               L5761:
3234                     ; 547 }
3237  03ed 81            	ret
3265                     ; 550 void led_drv(void)
3265                     ; 551 {
3266                     	switch	.text
3267  03ee               _led_drv:
3271                     ; 553 GPIOA->DDR|=(1<<4);
3273  03ee 72185002      	bset	20482,#4
3274                     ; 554 GPIOA->CR1|=(1<<4);
3276  03f2 72185003      	bset	20483,#4
3277                     ; 555 GPIOA->CR2&=~(1<<4);
3279  03f6 72195004      	bres	20484,#4
3280                     ; 556 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3282  03fa b64b          	ld	a,_led_red_buff+3
3283  03fc a501          	bcp	a,#1
3284  03fe 2706          	jreq	L3471
3287  0400 72185000      	bset	20480,#4
3289  0404 2004          	jra	L5471
3290  0406               L3471:
3291                     ; 557 else GPIOA->ODR&=~(1<<4); 
3293  0406 72195000      	bres	20480,#4
3294  040a               L5471:
3295                     ; 560 GPIOA->DDR|=(1<<5);
3297  040a 721a5002      	bset	20482,#5
3298                     ; 561 GPIOA->CR1|=(1<<5);
3300  040e 721a5003      	bset	20483,#5
3301                     ; 562 GPIOA->CR2&=~(1<<5);	
3303  0412 721b5004      	bres	20484,#5
3304                     ; 563 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3306  0416 b647          	ld	a,_led_green_buff+3
3307  0418 a501          	bcp	a,#1
3308  041a 2706          	jreq	L7471
3311  041c 721a5000      	bset	20480,#5
3313  0420 2004          	jra	L1571
3314  0422               L7471:
3315                     ; 564 else GPIOA->ODR&=~(1<<5);
3317  0422 721b5000      	bres	20480,#5
3318  0426               L1571:
3319                     ; 567 led_red_buff>>=1;
3321  0426 3748          	sra	_led_red_buff
3322  0428 3649          	rrc	_led_red_buff+1
3323  042a 364a          	rrc	_led_red_buff+2
3324  042c 364b          	rrc	_led_red_buff+3
3325                     ; 568 led_green_buff>>=1;
3327  042e 3744          	sra	_led_green_buff
3328  0430 3645          	rrc	_led_green_buff+1
3329  0432 3646          	rrc	_led_green_buff+2
3330  0434 3647          	rrc	_led_green_buff+3
3331                     ; 569 if(++led_drv_cnt>32)
3333  0436 3c16          	inc	_led_drv_cnt
3334  0438 b616          	ld	a,_led_drv_cnt
3335  043a a121          	cp	a,#33
3336  043c 2512          	jrult	L3571
3337                     ; 571 	led_drv_cnt=0;
3339  043e 3f16          	clr	_led_drv_cnt
3340                     ; 572 	led_red_buff=led_red;
3342  0440 be10          	ldw	x,_led_red+2
3343  0442 bf4a          	ldw	_led_red_buff+2,x
3344  0444 be0e          	ldw	x,_led_red
3345  0446 bf48          	ldw	_led_red_buff,x
3346                     ; 573 	led_green_buff=led_green;
3348  0448 be14          	ldw	x,_led_green+2
3349  044a bf46          	ldw	_led_green_buff+2,x
3350  044c be12          	ldw	x,_led_green
3351  044e bf44          	ldw	_led_green_buff,x
3352  0450               L3571:
3353                     ; 579 } 
3356  0450 81            	ret
3382                     ; 582 void JP_drv(void)
3382                     ; 583 {
3383                     	switch	.text
3384  0451               _JP_drv:
3388                     ; 585 GPIOD->DDR&=~(1<<6);
3390  0451 721d5011      	bres	20497,#6
3391                     ; 586 GPIOD->CR1|=(1<<6);
3393  0455 721c5012      	bset	20498,#6
3394                     ; 587 GPIOD->CR2&=~(1<<6);
3396  0459 721d5013      	bres	20499,#6
3397                     ; 589 GPIOD->DDR&=~(1<<7);
3399  045d 721f5011      	bres	20497,#7
3400                     ; 590 GPIOD->CR1|=(1<<7);
3402  0461 721e5012      	bset	20498,#7
3403                     ; 591 GPIOD->CR2&=~(1<<7);
3405  0465 721f5013      	bres	20499,#7
3406                     ; 593 if(GPIOD->IDR&(1<<6))
3408  0469 c65010        	ld	a,20496
3409  046c a540          	bcp	a,#64
3410  046e 270a          	jreq	L5671
3411                     ; 595 	if(cnt_JP0<10)
3413  0470 b654          	ld	a,_cnt_JP0
3414  0472 a10a          	cp	a,#10
3415  0474 2411          	jruge	L1771
3416                     ; 597 		cnt_JP0++;
3418  0476 3c54          	inc	_cnt_JP0
3419  0478 200d          	jra	L1771
3420  047a               L5671:
3421                     ; 600 else if(!(GPIOD->IDR&(1<<6)))
3423  047a c65010        	ld	a,20496
3424  047d a540          	bcp	a,#64
3425  047f 2606          	jrne	L1771
3426                     ; 602 	if(cnt_JP0)
3428  0481 3d54          	tnz	_cnt_JP0
3429  0483 2702          	jreq	L1771
3430                     ; 604 		cnt_JP0--;
3432  0485 3a54          	dec	_cnt_JP0
3433  0487               L1771:
3434                     ; 608 if(GPIOD->IDR&(1<<7))
3436  0487 c65010        	ld	a,20496
3437  048a a580          	bcp	a,#128
3438  048c 270a          	jreq	L7771
3439                     ; 610 	if(cnt_JP1<10)
3441  048e b653          	ld	a,_cnt_JP1
3442  0490 a10a          	cp	a,#10
3443  0492 2411          	jruge	L3002
3444                     ; 612 		cnt_JP1++;
3446  0494 3c53          	inc	_cnt_JP1
3447  0496 200d          	jra	L3002
3448  0498               L7771:
3449                     ; 615 else if(!(GPIOD->IDR&(1<<7)))
3451  0498 c65010        	ld	a,20496
3452  049b a580          	bcp	a,#128
3453  049d 2606          	jrne	L3002
3454                     ; 617 	if(cnt_JP1)
3456  049f 3d53          	tnz	_cnt_JP1
3457  04a1 2702          	jreq	L3002
3458                     ; 619 		cnt_JP1--;
3460  04a3 3a53          	dec	_cnt_JP1
3461  04a5               L3002:
3462                     ; 624 if((cnt_JP0==10)&&(cnt_JP1==10))
3464  04a5 b654          	ld	a,_cnt_JP0
3465  04a7 a10a          	cp	a,#10
3466  04a9 2608          	jrne	L1102
3468  04ab b653          	ld	a,_cnt_JP1
3469  04ad a10a          	cp	a,#10
3470  04af 2602          	jrne	L1102
3471                     ; 626 	jp_mode=jp0;
3473  04b1 3f55          	clr	_jp_mode
3474  04b3               L1102:
3475                     ; 628 if((cnt_JP0==0)&&(cnt_JP1==10))
3477  04b3 3d54          	tnz	_cnt_JP0
3478  04b5 260a          	jrne	L3102
3480  04b7 b653          	ld	a,_cnt_JP1
3481  04b9 a10a          	cp	a,#10
3482  04bb 2604          	jrne	L3102
3483                     ; 630 	jp_mode=jp1;
3485  04bd 35010055      	mov	_jp_mode,#1
3486  04c1               L3102:
3487                     ; 632 if((cnt_JP0==10)&&(cnt_JP1==0))
3489  04c1 b654          	ld	a,_cnt_JP0
3490  04c3 a10a          	cp	a,#10
3491  04c5 2608          	jrne	L5102
3493  04c7 3d53          	tnz	_cnt_JP1
3494  04c9 2604          	jrne	L5102
3495                     ; 634 	jp_mode=jp2;
3497  04cb 35020055      	mov	_jp_mode,#2
3498  04cf               L5102:
3499                     ; 636 if((cnt_JP0==0)&&(cnt_JP1==0))
3501  04cf 3d54          	tnz	_cnt_JP0
3502  04d1 2608          	jrne	L7102
3504  04d3 3d53          	tnz	_cnt_JP1
3505  04d5 2604          	jrne	L7102
3506                     ; 638 	jp_mode=jp3;
3508  04d7 35030055      	mov	_jp_mode,#3
3509  04db               L7102:
3510                     ; 641 }
3513  04db 81            	ret
3545                     ; 644 void link_drv(void)		//10Hz
3545                     ; 645 {
3546                     	switch	.text
3547  04dc               _link_drv:
3551                     ; 646 if(jp_mode!=jp3)
3553  04dc b655          	ld	a,_jp_mode
3554  04de a103          	cp	a,#3
3555  04e0 274d          	jreq	L1302
3556                     ; 648 	if(link_cnt<602)link_cnt++;
3558  04e2 9c            	rvf
3559  04e3 be6e          	ldw	x,_link_cnt
3560  04e5 a3025a        	cpw	x,#602
3561  04e8 2e07          	jrsge	L3302
3564  04ea be6e          	ldw	x,_link_cnt
3565  04ec 1c0001        	addw	x,#1
3566  04ef bf6e          	ldw	_link_cnt,x
3567  04f1               L3302:
3568                     ; 649 	if(link_cnt==90)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
3570  04f1 be6e          	ldw	x,_link_cnt
3571  04f3 a3005a        	cpw	x,#90
3572  04f6 2606          	jrne	L5302
3575  04f8 b605          	ld	a,_flags
3576  04fa a4c1          	and	a,#193
3577  04fc b705          	ld	_flags,a
3578  04fe               L5302:
3579                     ; 650 	if(link_cnt==100)
3581  04fe be6e          	ldw	x,_link_cnt
3582  0500 a30064        	cpw	x,#100
3583  0503 262e          	jrne	L7402
3584                     ; 652 		link=OFF;
3586  0505 35aa0070      	mov	_link,#170
3587                     ; 657 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
3589  0509 b60b          	ld	a,_bps_class
3590  050b a101          	cp	a,#1
3591  050d 2606          	jrne	L1402
3594  050f 72100001      	bset	_bMAIN
3596  0513 2004          	jra	L3402
3597  0515               L1402:
3598                     ; 658 		else bMAIN=0;
3600  0515 72110001      	bres	_bMAIN
3601  0519               L3402:
3602                     ; 660 		cnt_net_drv=0;
3604  0519 3f3d          	clr	_cnt_net_drv
3605                     ; 661     		if(!res_fl_)
3607  051b 725d000a      	tnz	_res_fl_
3608  051f 2612          	jrne	L7402
3609                     ; 663 	    		bRES_=1;
3611  0521 3501000d      	mov	_bRES_,#1
3612                     ; 664 	    		res_fl_=1;
3614  0525 a601          	ld	a,#1
3615  0527 ae000a        	ldw	x,#_res_fl_
3616  052a cd0000        	call	c_eewrc
3618  052d 2004          	jra	L7402
3619  052f               L1302:
3620                     ; 668 else link=OFF;	
3622  052f 35aa0070      	mov	_link,#170
3623  0533               L7402:
3624                     ; 669 } 
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
3707                     ; 673 void vent_drv(void)
3707                     ; 674 {
3708                     	switch	.text
3709  0534               _vent_drv:
3711  0534 520c          	subw	sp,#12
3712       0000000c      OFST:	set	12
3715                     ; 677 	short vent_pwm_i_necc=400;
3717  0536 ae0190        	ldw	x,#400
3718  0539 1f05          	ldw	(OFST-7,sp),x
3719                     ; 678 	short vent_pwm_t_necc=400;
3721  053b ae0190        	ldw	x,#400
3722  053e 1f07          	ldw	(OFST-5,sp),x
3723                     ; 679 	short vent_pwm_max_necc=400;
3725                     ; 685 	tempSL=(signed long)I;
3727  0540 ce001a        	ldw	x,_I
3728  0543 cd0000        	call	c_itolx
3730  0546 96            	ldw	x,sp
3731  0547 1c0009        	addw	x,#OFST-3
3732  054a cd0000        	call	c_rtol
3734                     ; 686 	tempSL*=(signed long)Ui;
3736  054d ce0016        	ldw	x,_Ui
3737  0550 cd0000        	call	c_itolx
3739  0553 96            	ldw	x,sp
3740  0554 1c0009        	addw	x,#OFST-3
3741  0557 cd0000        	call	c_lgmul
3743                     ; 687 	tempSL/=100L;
3745  055a 96            	ldw	x,sp
3746  055b 1c0009        	addw	x,#OFST-3
3747  055e cd0000        	call	c_ltor
3749  0561 ae0004        	ldw	x,#L63
3750  0564 cd0000        	call	c_ldiv
3752  0567 96            	ldw	x,sp
3753  0568 1c0009        	addw	x,#OFST-3
3754  056b cd0000        	call	c_rtol
3756                     ; 695 	if(tempSL>3000L)vent_pwm_i_necc=1000;
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
3774                     ; 696 	else if(tempSL<300L)vent_pwm_i_necc=0;
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
3792                     ; 697 	else vent_pwm_i_necc=(short)(400L + ((tempSL-300L)/4L));
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
3810                     ; 698 	gran(&vent_pwm_i_necc,0,1000);
3812  05b7 ae03e8        	ldw	x,#1000
3813  05ba 89            	pushw	x
3814  05bb 5f            	clrw	x
3815  05bc 89            	pushw	x
3816  05bd 96            	ldw	x,sp
3817  05be 1c0009        	addw	x,#OFST-3
3818  05c1 cd00d5        	call	_gran
3820  05c4 5b04          	addw	sp,#4
3821                     ; 700 	tempSL=(signed long)T;
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
3835                     ; 701 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
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
3856                     ; 702 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
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
3874                     ; 703 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
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
3887                     ; 704 	gran(&vent_pwm_t_necc,0,1000);
3889  0625 ae03e8        	ldw	x,#1000
3890  0628 89            	pushw	x
3891  0629 5f            	clrw	x
3892  062a 89            	pushw	x
3893  062b 96            	ldw	x,sp
3894  062c 1c000b        	addw	x,#OFST-1
3895  062f cd00d5        	call	_gran
3897  0632 5b04          	addw	sp,#4
3898                     ; 706 	vent_pwm_max_necc=vent_pwm_i_necc;
3900  0634 1e05          	ldw	x,(OFST-7,sp)
3901  0636 1f03          	ldw	(OFST-9,sp),x
3902                     ; 707 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3904  0638 9c            	rvf
3905  0639 1e07          	ldw	x,(OFST-5,sp)
3906  063b 1305          	cpw	x,(OFST-7,sp)
3907  063d 2d04          	jrsle	L3212
3910  063f 1e07          	ldw	x,(OFST-5,sp)
3911  0641 1f03          	ldw	(OFST-9,sp),x
3912  0643               L3212:
3913                     ; 709 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3915  0643 9c            	rvf
3916  0644 be10          	ldw	x,_vent_pwm
3917  0646 1303          	cpw	x,(OFST-9,sp)
3918  0648 2e07          	jrsge	L5212
3921  064a be10          	ldw	x,_vent_pwm
3922  064c 1c000a        	addw	x,#10
3923  064f bf10          	ldw	_vent_pwm,x
3924  0651               L5212:
3925                     ; 710 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3927  0651 9c            	rvf
3928  0652 be10          	ldw	x,_vent_pwm
3929  0654 1303          	cpw	x,(OFST-9,sp)
3930  0656 2d07          	jrsle	L7212
3933  0658 be10          	ldw	x,_vent_pwm
3934  065a 1d000a        	subw	x,#10
3935  065d bf10          	ldw	_vent_pwm,x
3936  065f               L7212:
3937                     ; 711 	gran(&vent_pwm,0,1000);
3939  065f ae03e8        	ldw	x,#1000
3940  0662 89            	pushw	x
3941  0663 5f            	clrw	x
3942  0664 89            	pushw	x
3943  0665 ae0010        	ldw	x,#_vent_pwm
3944  0668 cd00d5        	call	_gran
3946  066b 5b04          	addw	sp,#4
3947                     ; 717 	if(vent_pwm_integr_cnt<10)
3949  066d 9c            	rvf
3950  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3951  0670 a3000a        	cpw	x,#10
3952  0673 2e26          	jrsge	L1312
3953                     ; 719 		vent_pwm_integr_cnt++;
3955  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3956  0677 1c0001        	addw	x,#1
3957  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3958                     ; 720 		if(vent_pwm_integr_cnt>=10)
3960  067c 9c            	rvf
3961  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3962  067f a3000a        	cpw	x,#10
3963  0682 2f17          	jrslt	L1312
3964                     ; 722 			vent_pwm_integr_cnt=0;
3966  0684 5f            	clrw	x
3967  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3968                     ; 723 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3970  0687 be0e          	ldw	x,_vent_pwm_integr
3971  0689 90ae0009      	ldw	y,#9
3972  068d cd0000        	call	c_imul
3974  0690 72bb0010      	addw	x,_vent_pwm
3975  0694 a60a          	ld	a,#10
3976  0696 cd0000        	call	c_sdivx
3978  0699 bf0e          	ldw	_vent_pwm_integr,x
3979  069b               L1312:
3980                     ; 726 	gran(&vent_pwm_integr,0,1000);
3982  069b ae03e8        	ldw	x,#1000
3983  069e 89            	pushw	x
3984  069f 5f            	clrw	x
3985  06a0 89            	pushw	x
3986  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3987  06a4 cd00d5        	call	_gran
3989  06a7 5b04          	addw	sp,#4
3990                     ; 730 }
3993  06a9 5b0c          	addw	sp,#12
3994  06ab 81            	ret
4021                     ; 735 void pwr_drv(void)
4021                     ; 736 {
4022                     	switch	.text
4023  06ac               _pwr_drv:
4027                     ; 797 gran(&pwm_u,10,2000);
4029  06ac ae07d0        	ldw	x,#2000
4030  06af 89            	pushw	x
4031  06b0 ae000a        	ldw	x,#10
4032  06b3 89            	pushw	x
4033  06b4 ae0008        	ldw	x,#_pwm_u
4034  06b7 cd00d5        	call	_gran
4036  06ba 5b04          	addw	sp,#4
4037                     ; 807 TIM1->CCR2H= (char)(pwm_u/256);	
4039  06bc be08          	ldw	x,_pwm_u
4040  06be 90ae0100      	ldw	y,#256
4041  06c2 cd0000        	call	c_idiv
4043  06c5 9f            	ld	a,xl
4044  06c6 c75267        	ld	21095,a
4045                     ; 808 TIM1->CCR2L= (char)pwm_u;
4047  06c9 5500095268    	mov	21096,_pwm_u+1
4048                     ; 810 TIM1->CCR1H= (char)(pwm_i/256);	
4050  06ce be0a          	ldw	x,_pwm_i
4051  06d0 90ae0100      	ldw	y,#256
4052  06d4 cd0000        	call	c_idiv
4054  06d7 9f            	ld	a,xl
4055  06d8 c75265        	ld	21093,a
4056                     ; 811 TIM1->CCR1L= (char)pwm_i;
4058  06db 55000b5266    	mov	21094,_pwm_i+1
4059                     ; 813 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4061  06e0 be0e          	ldw	x,_vent_pwm_integr
4062  06e2 90ae0080      	ldw	y,#128
4063  06e6 cd0000        	call	c_idiv
4065  06e9 9f            	ld	a,xl
4066  06ea c75269        	ld	21097,a
4067                     ; 814 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4069  06ed b60f          	ld	a,_vent_pwm_integr+1
4070  06ef 48            	sll	a
4071  06f0 c7526a        	ld	21098,a
4072                     ; 815 }
4075  06f3 81            	ret
4142                     	switch	.const
4143  0018               L45:
4144  0018 0000028a      	dc.l	650
4145                     ; 820 void pwr_hndl(void)				
4145                     ; 821 {
4146                     	switch	.text
4147  06f4               _pwr_hndl:
4149  06f4 5205          	subw	sp,#5
4150       00000005      OFST:	set	5
4153                     ; 822 if(jp_mode==jp3)
4155  06f6 b655          	ld	a,_jp_mode
4156  06f8 a103          	cp	a,#3
4157  06fa 260a          	jrne	L3712
4158                     ; 824 	pwm_u=0;
4160  06fc 5f            	clrw	x
4161  06fd bf08          	ldw	_pwm_u,x
4162                     ; 825 	pwm_i=0;
4164  06ff 5f            	clrw	x
4165  0700 bf0a          	ldw	_pwm_i,x
4167  0702 ac680868      	jpf	L5712
4168  0706               L3712:
4169                     ; 827 else if(jp_mode==jp2)
4171  0706 b655          	ld	a,_jp_mode
4172  0708 a102          	cp	a,#2
4173  070a 260c          	jrne	L7712
4174                     ; 829 	pwm_u=0;
4176  070c 5f            	clrw	x
4177  070d bf08          	ldw	_pwm_u,x
4178                     ; 830 	pwm_i=0x7ff;
4180  070f ae07ff        	ldw	x,#2047
4181  0712 bf0a          	ldw	_pwm_i,x
4183  0714 ac680868      	jpf	L5712
4184  0718               L7712:
4185                     ; 832 else if(jp_mode==jp1)
4187  0718 b655          	ld	a,_jp_mode
4188  071a a101          	cp	a,#1
4189  071c 260e          	jrne	L3022
4190                     ; 834 	pwm_u=0x7ff;
4192  071e ae07ff        	ldw	x,#2047
4193  0721 bf08          	ldw	_pwm_u,x
4194                     ; 835 	pwm_i=0x7ff;
4196  0723 ae07ff        	ldw	x,#2047
4197  0726 bf0a          	ldw	_pwm_i,x
4199  0728 ac680868      	jpf	L5712
4200  072c               L3022:
4201                     ; 846 else if(link==OFF)
4203  072c b670          	ld	a,_link
4204  072e a1aa          	cp	a,#170
4205  0730 2703          	jreq	L65
4206  0732 cc07e5        	jp	L7022
4207  0735               L65:
4208                     ; 848 	pwm_i=0x7ff;
4210  0735 ae07ff        	ldw	x,#2047
4211  0738 bf0a          	ldw	_pwm_i,x
4212                     ; 849 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4214  073a ce0014        	ldw	x,_Unecc
4215  073d 90ae07d0      	ldw	y,#2000
4216  0741 cd0000        	call	c_vmul
4218  0744 ae0018        	ldw	x,#L45
4219  0747 cd0000        	call	c_ldiv
4221  074a be02          	ldw	x,c_lreg+2
4222  074c bf58          	ldw	_pwm_u_,x
4223                     ; 853 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4225  074e c6001d        	ld	a,_pwm_u_buff_ptr
4226  0751 5f            	clrw	x
4227  0752 97            	ld	xl,a
4228  0753 58            	sllw	x
4229  0754 90be58        	ldw	y,_pwm_u_
4230  0757 df0020        	ldw	(_pwm_u_buff,x),y
4231                     ; 854 	pwm_u_buff_ptr++;
4233  075a 725c001d      	inc	_pwm_u_buff_ptr
4234                     ; 855 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4236  075e c6001d        	ld	a,_pwm_u_buff_ptr
4237  0761 a110          	cp	a,#16
4238  0763 2504          	jrult	L1122
4241  0765 725f001d      	clr	_pwm_u_buff_ptr
4242  0769               L1122:
4243                     ; 859 		tempSL=0;
4245  0769 ae0000        	ldw	x,#0
4246  076c 1f03          	ldw	(OFST-2,sp),x
4247  076e ae0000        	ldw	x,#0
4248  0771 1f01          	ldw	(OFST-4,sp),x
4249                     ; 860 		for(i=0;i<16;i++)
4251  0773 0f05          	clr	(OFST+0,sp)
4252  0775               L3122:
4253                     ; 862 			tempSL+=(signed long)pwm_u_buff[i];
4255  0775 7b05          	ld	a,(OFST+0,sp)
4256  0777 5f            	clrw	x
4257  0778 97            	ld	xl,a
4258  0779 58            	sllw	x
4259  077a de0020        	ldw	x,(_pwm_u_buff,x)
4260  077d cd0000        	call	c_itolx
4262  0780 96            	ldw	x,sp
4263  0781 1c0001        	addw	x,#OFST-4
4264  0784 cd0000        	call	c_lgadd
4266                     ; 860 		for(i=0;i<16;i++)
4268  0787 0c05          	inc	(OFST+0,sp)
4271  0789 7b05          	ld	a,(OFST+0,sp)
4272  078b a110          	cp	a,#16
4273  078d 25e6          	jrult	L3122
4274                     ; 864 		tempSL>>=4;
4276  078f 96            	ldw	x,sp
4277  0790 1c0001        	addw	x,#OFST-4
4278  0793 a604          	ld	a,#4
4279  0795 cd0000        	call	c_lgrsh
4281                     ; 865 		pwm_u_buff_=(signed short)tempSL;
4283  0798 1e03          	ldw	x,(OFST-2,sp)
4284  079a cf001e        	ldw	_pwm_u_buff_,x
4285                     ; 867 	pwm_u=pwm_u_;
4287  079d be58          	ldw	x,_pwm_u_
4288  079f bf08          	ldw	_pwm_u,x
4289                     ; 868 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4291  07a1 9c            	rvf
4292  07a2 ce0016        	ldw	x,_Ui
4293  07a5 72b00014      	subw	x,_Unecc
4294  07a9 cd0000        	call	_abs
4296  07ac a30014        	cpw	x,#20
4297  07af 2e06          	jrsge	L1222
4300  07b1 725c001c      	inc	_pwm_u_buff_cnt
4302  07b5 2004          	jra	L3222
4303  07b7               L1222:
4304                     ; 869 	else pwm_u_buff_cnt=0;
4306  07b7 725f001c      	clr	_pwm_u_buff_cnt
4307  07bb               L3222:
4308                     ; 871 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4310  07bb c6001c        	ld	a,_pwm_u_buff_cnt
4311  07be a114          	cp	a,#20
4312  07c0 2504          	jrult	L5222
4315  07c2 3514001c      	mov	_pwm_u_buff_cnt,#20
4316  07c6               L5222:
4317                     ; 872 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4319  07c6 c6001c        	ld	a,_pwm_u_buff_cnt
4320  07c9 a10f          	cp	a,#15
4321  07cb 2505          	jrult	L7222
4324  07cd ce001e        	ldw	x,_pwm_u_buff_
4325  07d0 bf08          	ldw	_pwm_u,x
4326  07d2               L7222:
4327                     ; 875 	if(flags&0b00011010)					//если есть аварии
4329  07d2 b605          	ld	a,_flags
4330  07d4 a51a          	bcp	a,#26
4331  07d6 2603          	jrne	L06
4332  07d8 cc0868        	jp	L5712
4333  07db               L06:
4334                     ; 877 		pwm_u=0;								//то полный стоп
4336  07db 5f            	clrw	x
4337  07dc bf08          	ldw	_pwm_u,x
4338                     ; 878 		pwm_i=0;
4340  07de 5f            	clrw	x
4341  07df bf0a          	ldw	_pwm_i,x
4342  07e1 ac680868      	jpf	L5712
4343  07e5               L7022:
4344                     ; 882 else	if(link==ON)				//если есть связьvol_i_temp_avar
4346  07e5 b670          	ld	a,_link
4347  07e7 a155          	cp	a,#85
4348  07e9 267d          	jrne	L5712
4349                     ; 884 	if((flags&0b00100000)==0)	//если нет блокировки извне
4351  07eb b605          	ld	a,_flags
4352  07ed a520          	bcp	a,#32
4353  07ef 266b          	jrne	L7322
4354                     ; 886 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4356  07f1 b605          	ld	a,_flags
4357  07f3 a51a          	bcp	a,#26
4358  07f5 260b          	jrne	L1422
4359                     ; 888 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4361  07f7 be63          	ldw	x,_vol_i_temp
4362  07f9 bf08          	ldw	_pwm_u,x
4363                     ; 889 			pwm_i=2000;
4365  07fb ae07d0        	ldw	x,#2000
4366  07fe bf0a          	ldw	_pwm_i,x
4368  0800 2066          	jra	L5712
4369  0802               L1422:
4370                     ; 891 		else if(flags&0b00011010)					//если есть аварии
4372  0802 b605          	ld	a,_flags
4373  0804 a51a          	bcp	a,#26
4374  0806 2708          	jreq	L5422
4375                     ; 893 			pwm_u=0;								//то полный стоп
4377  0808 5f            	clrw	x
4378  0809 bf08          	ldw	_pwm_u,x
4379                     ; 894 			pwm_i=0;
4381  080b 5f            	clrw	x
4382  080c bf0a          	ldw	_pwm_i,x
4384  080e 2058          	jra	L5712
4385  0810               L5422:
4386                     ; 899 			if(vol_i_temp==2000)
4388  0810 be63          	ldw	x,_vol_i_temp
4389  0812 a307d0        	cpw	x,#2000
4390  0815 260c          	jrne	L1522
4391                     ; 901 				pwm_u=2000;
4393  0817 ae07d0        	ldw	x,#2000
4394  081a bf08          	ldw	_pwm_u,x
4395                     ; 902 				pwm_i=2000;
4397  081c ae07d0        	ldw	x,#2000
4398  081f bf0a          	ldw	_pwm_i,x
4400  0821 201d          	jra	L3522
4401  0823               L1522:
4402                     ; 907 				tempI=(int)(Ui-Unecc);
4404  0823 ce0016        	ldw	x,_Ui
4405  0826 72b00014      	subw	x,_Unecc
4406  082a 1f04          	ldw	(OFST-1,sp),x
4407                     ; 908 				if((tempI>20)||(tempI<-80))pwm_u_cnt=19;
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
4423                     ; 912 			if(pwm_u_cnt)
4425  0840 3d07          	tnz	_pwm_u_cnt
4426  0842 2724          	jreq	L5712
4427                     ; 914 				pwm_u_cnt--;
4429  0844 3a07          	dec	_pwm_u_cnt
4430                     ; 915 				pwm_u=(short)((2000L*((long)Unecc))/650L);
4432  0846 ce0014        	ldw	x,_Unecc
4433  0849 90ae07d0      	ldw	y,#2000
4434  084d cd0000        	call	c_vmul
4436  0850 ae0018        	ldw	x,#L45
4437  0853 cd0000        	call	c_ldiv
4439  0856 be02          	ldw	x,c_lreg+2
4440  0858 bf08          	ldw	_pwm_u,x
4441  085a 200c          	jra	L5712
4442  085c               L7322:
4443                     ; 919 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4445  085c b605          	ld	a,_flags
4446  085e a520          	bcp	a,#32
4447  0860 2706          	jreq	L5712
4448                     ; 921 		pwm_u=0;
4450  0862 5f            	clrw	x
4451  0863 bf08          	ldw	_pwm_u,x
4452                     ; 922 		pwm_i=0;
4454  0865 5f            	clrw	x
4455  0866 bf0a          	ldw	_pwm_i,x
4456  0868               L5712:
4457                     ; 950 if(pwm_u>2000)pwm_u=2000;
4459  0868 9c            	rvf
4460  0869 be08          	ldw	x,_pwm_u
4461  086b a307d1        	cpw	x,#2001
4462  086e 2f05          	jrslt	L7622
4465  0870 ae07d0        	ldw	x,#2000
4466  0873 bf08          	ldw	_pwm_u,x
4467  0875               L7622:
4468                     ; 951 if(pwm_i>2000)pwm_i=2000;
4470  0875 9c            	rvf
4471  0876 be0a          	ldw	x,_pwm_i
4472  0878 a307d1        	cpw	x,#2001
4473  087b 2f05          	jrslt	L1722
4476  087d ae07d0        	ldw	x,#2000
4477  0880 bf0a          	ldw	_pwm_i,x
4478  0882               L1722:
4479                     ; 954 }
4482  0882 5b05          	addw	sp,#5
4483  0884 81            	ret
4532                     	switch	.const
4533  001c               L46:
4534  001c 000003e8      	dc.l	1000
4535                     ; 959 void pwr_hndl_new(void)				
4535                     ; 960 {
4536                     	switch	.text
4537  0885               _pwr_hndl_new:
4539  0885 5204          	subw	sp,#4
4540       00000004      OFST:	set	4
4543                     ; 961 if(jp_mode==jp3)
4545  0887 b655          	ld	a,_jp_mode
4546  0889 a103          	cp	a,#3
4547  088b 260a          	jrne	L1132
4548                     ; 963 	pwm_u=0;
4550  088d 5f            	clrw	x
4551  088e bf08          	ldw	_pwm_u,x
4552                     ; 964 	pwm_i=0;
4554  0890 5f            	clrw	x
4555  0891 bf0a          	ldw	_pwm_i,x
4557  0893 ac430a43      	jpf	L3132
4558  0897               L1132:
4559                     ; 966 else if(jp_mode==jp2)
4561  0897 b655          	ld	a,_jp_mode
4562  0899 a102          	cp	a,#2
4563  089b 260c          	jrne	L5132
4564                     ; 968 	pwm_u=0;
4566  089d 5f            	clrw	x
4567  089e bf08          	ldw	_pwm_u,x
4568                     ; 969 	pwm_i=0x7ff;
4570  08a0 ae07ff        	ldw	x,#2047
4571  08a3 bf0a          	ldw	_pwm_i,x
4573  08a5 ac430a43      	jpf	L3132
4574  08a9               L5132:
4575                     ; 971 else if(jp_mode==jp1)
4577  08a9 b655          	ld	a,_jp_mode
4578  08ab a101          	cp	a,#1
4579  08ad 260e          	jrne	L1232
4580                     ; 973 	pwm_u=0x7ff;
4582  08af ae07ff        	ldw	x,#2047
4583  08b2 bf08          	ldw	_pwm_u,x
4584                     ; 974 	pwm_i=0x7ff;
4586  08b4 ae07ff        	ldw	x,#2047
4587  08b7 bf0a          	ldw	_pwm_i,x
4589  08b9 ac430a43      	jpf	L3132
4590  08bd               L1232:
4591                     ; 1021 else	if(link==ON)				//если есть связьvol_i_temp_avar
4593  08bd b670          	ld	a,_link
4594  08bf a155          	cp	a,#85
4595  08c1 2703          	jreq	L66
4596  08c3 cc0a43        	jp	L3132
4597  08c6               L66:
4598                     ; 1048 			temp_SL=(signed long)adc_buff_5;
4600  08c6 ce0107        	ldw	x,_adc_buff_5
4601  08c9 cd0000        	call	c_itolx
4603  08cc 96            	ldw	x,sp
4604  08cd 1c0001        	addw	x,#OFST-3
4605  08d0 cd0000        	call	c_rtol
4607                     ; 1050 			if(temp_SL<0) temp_SL=0;
4609  08d3 9c            	rvf
4610  08d4 0d01          	tnz	(OFST-3,sp)
4611  08d6 2e0a          	jrsge	L7232
4614  08d8 ae0000        	ldw	x,#0
4615  08db 1f03          	ldw	(OFST-1,sp),x
4616  08dd ae0000        	ldw	x,#0
4617  08e0 1f01          	ldw	(OFST-3,sp),x
4618  08e2               L7232:
4619                     ; 1051 			temp_SL*=(signed long)ee_K[4][1];
4621  08e2 ce002c        	ldw	x,_ee_K+18
4622  08e5 cd0000        	call	c_itolx
4624  08e8 96            	ldw	x,sp
4625  08e9 1c0001        	addw	x,#OFST-3
4626  08ec cd0000        	call	c_lgmul
4628                     ; 1052 			temp_SL/=1000L;
4630  08ef 96            	ldw	x,sp
4631  08f0 1c0001        	addw	x,#OFST-3
4632  08f3 cd0000        	call	c_ltor
4634  08f6 ae001c        	ldw	x,#L46
4635  08f9 cd0000        	call	c_ldiv
4637  08fc 96            	ldw	x,sp
4638  08fd 1c0001        	addw	x,#OFST-3
4639  0900 cd0000        	call	c_rtol
4641                     ; 1053 			Usum=(unsigned short)temp_SL;	
4643  0903 1e03          	ldw	x,(OFST-1,sp)
4644  0905 cf0010        	ldw	_Usum,x
4645                     ; 1059 			Udelt=U_out_const/*2300*/-Usum;
4647  0908 ce0012        	ldw	x,_U_out_const
4648  090b 72b00010      	subw	x,_Usum
4649  090f cf000c        	ldw	_Udelt,x
4650                     ; 1060 			Udelt+=vol_i_temp;	//выравнивание токов по командам от уку
4652  0912 ce000c        	ldw	x,_Udelt
4653  0915 72bb0063      	addw	x,_vol_i_temp
4654  0919 cf000c        	ldw	_Udelt,x
4655                     ; 1064 			if(pwm_peace_cnt)pwm_peace_cnt--;
4657  091c ce0008        	ldw	x,_pwm_peace_cnt
4658  091f 2709          	jreq	L1332
4661  0921 ce0008        	ldw	x,_pwm_peace_cnt
4662  0924 1d0001        	subw	x,#1
4663  0927 cf0008        	ldw	_pwm_peace_cnt,x
4664  092a               L1332:
4665                     ; 1065 			if(pwm_peace_cnt_)pwm_peace_cnt_--;
4667  092a ce0006        	ldw	x,_pwm_peace_cnt_
4668  092d 2709          	jreq	L3332
4671  092f ce0006        	ldw	x,_pwm_peace_cnt_
4672  0932 1d0001        	subw	x,#1
4673  0935 cf0006        	ldw	_pwm_peace_cnt_,x
4674  0938               L3332:
4675                     ; 1067 			if((Udelt<-50)&&(pwm_peace_cnt==0))
4677  0938 9c            	rvf
4678  0939 ce000c        	ldw	x,_Udelt
4679  093c a3ffce        	cpw	x,#65486
4680  093f 2e40          	jrsge	L5332
4682  0941 ce0008        	ldw	x,_pwm_peace_cnt
4683  0944 263b          	jrne	L5332
4684                     ; 1069 				pwm_delt= (short)(((long)Udelt*2000L)/650L);
4686  0946 ce000c        	ldw	x,_Udelt
4687  0949 90ae07d0      	ldw	y,#2000
4688  094d cd0000        	call	c_vmul
4690  0950 ae0018        	ldw	x,#L45
4691  0953 cd0000        	call	c_ldiv
4693  0956 be02          	ldw	x,c_lreg+2
4694  0958 bf56          	ldw	_pwm_delt,x
4695                     ; 1071 				if(pwm_u!=0)
4697  095a be08          	ldw	x,_pwm_u
4698  095c 271b          	jreq	L7332
4699                     ; 1073 					pwm_u+=pwm_delt;
4701  095e be08          	ldw	x,_pwm_u
4702  0960 72bb0056      	addw	x,_pwm_delt
4703  0964 bf08          	ldw	_pwm_u,x
4704                     ; 1074 					pwm_schot_cnt++;
4706  0966 ce0004        	ldw	x,_pwm_schot_cnt
4707  0969 1c0001        	addw	x,#1
4708  096c cf0004        	ldw	_pwm_schot_cnt,x
4709                     ; 1075 					pwm_peace_cnt=30;
4711  096f ae001e        	ldw	x,#30
4712  0972 cf0008        	ldw	_pwm_peace_cnt,x
4714  0975 ac1a0a1a      	jpf	L3432
4715  0979               L7332:
4716                     ; 1077 				else	pwm_peace_cnt=0;
4718  0979 5f            	clrw	x
4719  097a cf0008        	ldw	_pwm_peace_cnt,x
4720  097d ac1a0a1a      	jpf	L3432
4721  0981               L5332:
4722                     ; 1080 			else if((Udelt>50)&&(pwm_peace_cnt==0))
4724  0981 9c            	rvf
4725  0982 ce000c        	ldw	x,_Udelt
4726  0985 a30033        	cpw	x,#51
4727  0988 2f3f          	jrslt	L5432
4729  098a ce0008        	ldw	x,_pwm_peace_cnt
4730  098d 263a          	jrne	L5432
4731                     ; 1082 				pwm_delt= (short)(((long)Udelt*2000L)/650L);
4733  098f ce000c        	ldw	x,_Udelt
4734  0992 90ae07d0      	ldw	y,#2000
4735  0996 cd0000        	call	c_vmul
4737  0999 ae0018        	ldw	x,#L45
4738  099c cd0000        	call	c_ldiv
4740  099f be02          	ldw	x,c_lreg+2
4741  09a1 bf56          	ldw	_pwm_delt,x
4742                     ; 1084 				if(pwm_u!=2000)
4744  09a3 be08          	ldw	x,_pwm_u
4745  09a5 a307d0        	cpw	x,#2000
4746  09a8 2719          	jreq	L7432
4747                     ; 1086 					pwm_u+=pwm_delt;
4749  09aa be08          	ldw	x,_pwm_u
4750  09ac 72bb0056      	addw	x,_pwm_delt
4751  09b0 bf08          	ldw	_pwm_u,x
4752                     ; 1087 					pwm_schot_cnt++;
4754  09b2 ce0004        	ldw	x,_pwm_schot_cnt
4755  09b5 1c0001        	addw	x,#1
4756  09b8 cf0004        	ldw	_pwm_schot_cnt,x
4757                     ; 1088 					pwm_peace_cnt=30;
4759  09bb ae001e        	ldw	x,#30
4760  09be cf0008        	ldw	_pwm_peace_cnt,x
4762  09c1 2057          	jra	L3432
4763  09c3               L7432:
4764                     ; 1090 				else	pwm_peace_cnt=0;
4766  09c3 5f            	clrw	x
4767  09c4 cf0008        	ldw	_pwm_peace_cnt,x
4768  09c7 2051          	jra	L3432
4769  09c9               L5432:
4770                     ; 1093 			else if(pwm_peace_cnt_==0)
4772  09c9 ce0006        	ldw	x,_pwm_peace_cnt_
4773  09cc 264c          	jrne	L3432
4774                     ; 1095 				if(Udelt>10)pwm_u++;
4776  09ce 9c            	rvf
4777  09cf ce000c        	ldw	x,_Udelt
4778  09d2 a3000b        	cpw	x,#11
4779  09d5 2f09          	jrslt	L7532
4782  09d7 be08          	ldw	x,_pwm_u
4783  09d9 1c0001        	addw	x,#1
4784  09dc bf08          	ldw	_pwm_u,x
4786  09de 203a          	jra	L3432
4787  09e0               L7532:
4788                     ; 1096 				else	if(Udelt>0)
4790  09e0 9c            	rvf
4791  09e1 ce000c        	ldw	x,_Udelt
4792  09e4 2d0f          	jrsle	L3632
4793                     ; 1098 					pwm_u++;
4795  09e6 be08          	ldw	x,_pwm_u
4796  09e8 1c0001        	addw	x,#1
4797  09eb bf08          	ldw	_pwm_u,x
4798                     ; 1099 					pwm_peace_cnt_=3;
4800  09ed ae0003        	ldw	x,#3
4801  09f0 cf0006        	ldw	_pwm_peace_cnt_,x
4803  09f3 2025          	jra	L3432
4804  09f5               L3632:
4805                     ; 1101 				else if(Udelt<-10)pwm_u--;
4807  09f5 9c            	rvf
4808  09f6 ce000c        	ldw	x,_Udelt
4809  09f9 a3fff6        	cpw	x,#65526
4810  09fc 2e09          	jrsge	L7632
4813  09fe be08          	ldw	x,_pwm_u
4814  0a00 1d0001        	subw	x,#1
4815  0a03 bf08          	ldw	_pwm_u,x
4817  0a05 2013          	jra	L3432
4818  0a07               L7632:
4819                     ; 1102 				else	if(Udelt<0)
4821  0a07 9c            	rvf
4822  0a08 ce000c        	ldw	x,_Udelt
4823  0a0b 2e0d          	jrsge	L3432
4824                     ; 1104 					pwm_u--;
4826  0a0d be08          	ldw	x,_pwm_u
4827  0a0f 1d0001        	subw	x,#1
4828  0a12 bf08          	ldw	_pwm_u,x
4829                     ; 1105 					pwm_peace_cnt_=3;
4831  0a14 ae0003        	ldw	x,#3
4832  0a17 cf0006        	ldw	_pwm_peace_cnt_,x
4833  0a1a               L3432:
4834                     ; 1109 			if(pwm_u<=0)
4836  0a1a 9c            	rvf
4837  0a1b be08          	ldw	x,_pwm_u
4838  0a1d 2c0d          	jrsgt	L5732
4839                     ; 1111 				pwm_u=0;
4841  0a1f 5f            	clrw	x
4842  0a20 bf08          	ldw	_pwm_u,x
4843                     ; 1112 				pwm_peace_cnt=0;
4845  0a22 5f            	clrw	x
4846  0a23 cf0008        	ldw	_pwm_peace_cnt,x
4847                     ; 1113 				pwm_peace_cnt_=500;
4849  0a26 ae01f4        	ldw	x,#500
4850  0a29 cf0006        	ldw	_pwm_peace_cnt_,x
4851  0a2c               L5732:
4852                     ; 1115 			if(pwm_u>=2000)
4854  0a2c 9c            	rvf
4855  0a2d be08          	ldw	x,_pwm_u
4856  0a2f a307d0        	cpw	x,#2000
4857  0a32 2f0f          	jrslt	L3132
4858                     ; 1117 				pwm_u=2000;
4860  0a34 ae07d0        	ldw	x,#2000
4861  0a37 bf08          	ldw	_pwm_u,x
4862                     ; 1118 				pwm_peace_cnt=0;
4864  0a39 5f            	clrw	x
4865  0a3a cf0008        	ldw	_pwm_peace_cnt,x
4866                     ; 1119 				pwm_peace_cnt_=500;
4868  0a3d ae01f4        	ldw	x,#500
4869  0a40 cf0006        	ldw	_pwm_peace_cnt_,x
4870  0a43               L3132:
4871                     ; 1213 if(pwm_u>2000)pwm_u=2000;
4873  0a43 9c            	rvf
4874  0a44 be08          	ldw	x,_pwm_u
4875  0a46 a307d1        	cpw	x,#2001
4876  0a49 2f05          	jrslt	L1042
4879  0a4b ae07d0        	ldw	x,#2000
4880  0a4e bf08          	ldw	_pwm_u,x
4881  0a50               L1042:
4882                     ; 1214 if(pwm_u<0)pwm_u=0;
4884  0a50 9c            	rvf
4885  0a51 be08          	ldw	x,_pwm_u
4886  0a53 2e03          	jrsge	L3042
4889  0a55 5f            	clrw	x
4890  0a56 bf08          	ldw	_pwm_u,x
4891  0a58               L3042:
4892                     ; 1215 if(pwm_i>2000)pwm_i=2000;
4894  0a58 9c            	rvf
4895  0a59 be0a          	ldw	x,_pwm_i
4896  0a5b a307d1        	cpw	x,#2001
4897  0a5e 2f05          	jrslt	L5042
4900  0a60 ae07d0        	ldw	x,#2000
4901  0a63 bf0a          	ldw	_pwm_i,x
4902  0a65               L5042:
4903                     ; 1220 TIM1->CCR2H= (char)(pwm_u/256);	
4905  0a65 be08          	ldw	x,_pwm_u
4906  0a67 90ae0100      	ldw	y,#256
4907  0a6b cd0000        	call	c_idiv
4909  0a6e 9f            	ld	a,xl
4910  0a6f c75267        	ld	21095,a
4911                     ; 1221 TIM1->CCR2L= (char)pwm_u;
4913  0a72 5500095268    	mov	21096,_pwm_u+1
4914                     ; 1223 TIM1->CCR1H= (char)(pwm_i/256);	
4916  0a77 be0a          	ldw	x,_pwm_i
4917  0a79 90ae0100      	ldw	y,#256
4918  0a7d cd0000        	call	c_idiv
4920  0a80 9f            	ld	a,xl
4921  0a81 c75265        	ld	21093,a
4922                     ; 1224 TIM1->CCR1L= (char)pwm_i;
4924  0a84 55000b5266    	mov	21094,_pwm_i+1
4925                     ; 1226 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4927  0a89 be0e          	ldw	x,_vent_pwm_integr
4928  0a8b 90ae0080      	ldw	y,#128
4929  0a8f cd0000        	call	c_idiv
4931  0a92 9f            	ld	a,xl
4932  0a93 c75269        	ld	21097,a
4933                     ; 1227 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4935  0a96 b60f          	ld	a,_vent_pwm_integr+1
4936  0a98 48            	sll	a
4937  0a99 c7526a        	ld	21098,a
4938                     ; 1229 }
4941  0a9c 5b04          	addw	sp,#4
4942  0a9e 81            	ret
4996                     	switch	.const
4997  0020               L27:
4998  0020 00000258      	dc.l	600
4999  0024               L47:
5000  0024 00000708      	dc.l	1800
5001                     ; 1233 void matemat(void)
5001                     ; 1234 {
5002                     	switch	.text
5003  0a9f               _matemat:
5005  0a9f 5208          	subw	sp,#8
5006       00000008      OFST:	set	8
5009                     ; 1258 I=adc_buff_[4];
5011  0aa1 ce0111        	ldw	x,_adc_buff_+8
5012  0aa4 cf001a        	ldw	_I,x
5013                     ; 1259 temp_SL=adc_buff_[4];
5015  0aa7 ce0111        	ldw	x,_adc_buff_+8
5016  0aaa cd0000        	call	c_itolx
5018  0aad 96            	ldw	x,sp
5019  0aae 1c0005        	addw	x,#OFST-3
5020  0ab1 cd0000        	call	c_rtol
5022                     ; 1260 temp_SL-=ee_K[0][0];
5024  0ab4 ce001a        	ldw	x,_ee_K
5025  0ab7 cd0000        	call	c_itolx
5027  0aba 96            	ldw	x,sp
5028  0abb 1c0005        	addw	x,#OFST-3
5029  0abe cd0000        	call	c_lgsub
5031                     ; 1261 if(temp_SL<0) temp_SL=0;
5033  0ac1 9c            	rvf
5034  0ac2 0d05          	tnz	(OFST-3,sp)
5035  0ac4 2e0a          	jrsge	L5242
5038  0ac6 ae0000        	ldw	x,#0
5039  0ac9 1f07          	ldw	(OFST-1,sp),x
5040  0acb ae0000        	ldw	x,#0
5041  0ace 1f05          	ldw	(OFST-3,sp),x
5042  0ad0               L5242:
5043                     ; 1262 temp_SL*=ee_K[0][1];
5045  0ad0 ce001c        	ldw	x,_ee_K+2
5046  0ad3 cd0000        	call	c_itolx
5048  0ad6 96            	ldw	x,sp
5049  0ad7 1c0005        	addw	x,#OFST-3
5050  0ada cd0000        	call	c_lgmul
5052                     ; 1263 temp_SL/=600;
5054  0add 96            	ldw	x,sp
5055  0ade 1c0005        	addw	x,#OFST-3
5056  0ae1 cd0000        	call	c_ltor
5058  0ae4 ae0020        	ldw	x,#L27
5059  0ae7 cd0000        	call	c_ldiv
5061  0aea 96            	ldw	x,sp
5062  0aeb 1c0005        	addw	x,#OFST-3
5063  0aee cd0000        	call	c_rtol
5065                     ; 1264 I=(signed short)temp_SL;
5067  0af1 1e07          	ldw	x,(OFST-1,sp)
5068  0af3 cf001a        	ldw	_I,x
5069                     ; 1267 temp_SL=(signed long)adc_buff_[1];//1;
5071  0af6 ce010b        	ldw	x,_adc_buff_+2
5072  0af9 cd0000        	call	c_itolx
5074  0afc 96            	ldw	x,sp
5075  0afd 1c0005        	addw	x,#OFST-3
5076  0b00 cd0000        	call	c_rtol
5078                     ; 1270 if(temp_SL<0) temp_SL=0;
5080  0b03 9c            	rvf
5081  0b04 0d05          	tnz	(OFST-3,sp)
5082  0b06 2e0a          	jrsge	L7242
5085  0b08 ae0000        	ldw	x,#0
5086  0b0b 1f07          	ldw	(OFST-1,sp),x
5087  0b0d ae0000        	ldw	x,#0
5088  0b10 1f05          	ldw	(OFST-3,sp),x
5089  0b12               L7242:
5090                     ; 1271 temp_SL*=(signed long)ee_K[2][1];
5092  0b12 ce0024        	ldw	x,_ee_K+10
5093  0b15 cd0000        	call	c_itolx
5095  0b18 96            	ldw	x,sp
5096  0b19 1c0005        	addw	x,#OFST-3
5097  0b1c cd0000        	call	c_lgmul
5099                     ; 1272 temp_SL/=1000L;
5101  0b1f 96            	ldw	x,sp
5102  0b20 1c0005        	addw	x,#OFST-3
5103  0b23 cd0000        	call	c_ltor
5105  0b26 ae001c        	ldw	x,#L46
5106  0b29 cd0000        	call	c_ldiv
5108  0b2c 96            	ldw	x,sp
5109  0b2d 1c0005        	addw	x,#OFST-3
5110  0b30 cd0000        	call	c_rtol
5112                     ; 1273 Ui=(unsigned short)temp_SL;
5114  0b33 1e07          	ldw	x,(OFST-1,sp)
5115  0b35 cf0016        	ldw	_Ui,x
5116                     ; 1275 temp_SL=(signed long)adc_buff_5;
5118  0b38 ce0107        	ldw	x,_adc_buff_5
5119  0b3b cd0000        	call	c_itolx
5121  0b3e 96            	ldw	x,sp
5122  0b3f 1c0005        	addw	x,#OFST-3
5123  0b42 cd0000        	call	c_rtol
5125                     ; 1277 if(temp_SL<0) temp_SL=0;
5127  0b45 9c            	rvf
5128  0b46 0d05          	tnz	(OFST-3,sp)
5129  0b48 2e0a          	jrsge	L1342
5132  0b4a ae0000        	ldw	x,#0
5133  0b4d 1f07          	ldw	(OFST-1,sp),x
5134  0b4f ae0000        	ldw	x,#0
5135  0b52 1f05          	ldw	(OFST-3,sp),x
5136  0b54               L1342:
5137                     ; 1278 temp_SL*=(signed long)ee_K[4][1];
5139  0b54 ce002c        	ldw	x,_ee_K+18
5140  0b57 cd0000        	call	c_itolx
5142  0b5a 96            	ldw	x,sp
5143  0b5b 1c0005        	addw	x,#OFST-3
5144  0b5e cd0000        	call	c_lgmul
5146                     ; 1279 temp_SL/=1000L;
5148  0b61 96            	ldw	x,sp
5149  0b62 1c0005        	addw	x,#OFST-3
5150  0b65 cd0000        	call	c_ltor
5152  0b68 ae001c        	ldw	x,#L46
5153  0b6b cd0000        	call	c_ldiv
5155  0b6e 96            	ldw	x,sp
5156  0b6f 1c0005        	addw	x,#OFST-3
5157  0b72 cd0000        	call	c_rtol
5159                     ; 1280 Usum=(unsigned short)temp_SL;
5161  0b75 1e07          	ldw	x,(OFST-1,sp)
5162  0b77 cf0010        	ldw	_Usum,x
5163                     ; 1284 temp_SL=adc_buff_[3];
5165  0b7a ce010f        	ldw	x,_adc_buff_+6
5166  0b7d cd0000        	call	c_itolx
5168  0b80 96            	ldw	x,sp
5169  0b81 1c0005        	addw	x,#OFST-3
5170  0b84 cd0000        	call	c_rtol
5172                     ; 1286 if(temp_SL<0) temp_SL=0;
5174  0b87 9c            	rvf
5175  0b88 0d05          	tnz	(OFST-3,sp)
5176  0b8a 2e0a          	jrsge	L3342
5179  0b8c ae0000        	ldw	x,#0
5180  0b8f 1f07          	ldw	(OFST-1,sp),x
5181  0b91 ae0000        	ldw	x,#0
5182  0b94 1f05          	ldw	(OFST-3,sp),x
5183  0b96               L3342:
5184                     ; 1287 temp_SL*=ee_K[1][1];
5186  0b96 ce0020        	ldw	x,_ee_K+6
5187  0b99 cd0000        	call	c_itolx
5189  0b9c 96            	ldw	x,sp
5190  0b9d 1c0005        	addw	x,#OFST-3
5191  0ba0 cd0000        	call	c_lgmul
5193                     ; 1288 temp_SL/=1800;
5195  0ba3 96            	ldw	x,sp
5196  0ba4 1c0005        	addw	x,#OFST-3
5197  0ba7 cd0000        	call	c_ltor
5199  0baa ae0024        	ldw	x,#L47
5200  0bad cd0000        	call	c_ldiv
5202  0bb0 96            	ldw	x,sp
5203  0bb1 1c0005        	addw	x,#OFST-3
5204  0bb4 cd0000        	call	c_rtol
5206                     ; 1289 Un=(unsigned short)temp_SL;
5208  0bb7 1e07          	ldw	x,(OFST-1,sp)
5209  0bb9 cf0018        	ldw	_Un,x
5210                     ; 1294 temp_SL=adc_buff_[2];
5212  0bbc ce010d        	ldw	x,_adc_buff_+4
5213  0bbf cd0000        	call	c_itolx
5215  0bc2 96            	ldw	x,sp
5216  0bc3 1c0005        	addw	x,#OFST-3
5217  0bc6 cd0000        	call	c_rtol
5219                     ; 1295 temp_SL*=ee_K[3][1];
5221  0bc9 ce0028        	ldw	x,_ee_K+14
5222  0bcc cd0000        	call	c_itolx
5224  0bcf 96            	ldw	x,sp
5225  0bd0 1c0005        	addw	x,#OFST-3
5226  0bd3 cd0000        	call	c_lgmul
5228                     ; 1296 temp_SL/=1000;
5230  0bd6 96            	ldw	x,sp
5231  0bd7 1c0005        	addw	x,#OFST-3
5232  0bda cd0000        	call	c_ltor
5234  0bdd ae001c        	ldw	x,#L46
5235  0be0 cd0000        	call	c_ldiv
5237  0be3 96            	ldw	x,sp
5238  0be4 1c0005        	addw	x,#OFST-3
5239  0be7 cd0000        	call	c_rtol
5241                     ; 1297 T=(signed short)(temp_SL-273L);
5243  0bea 7b08          	ld	a,(OFST+0,sp)
5244  0bec 5f            	clrw	x
5245  0bed 4d            	tnz	a
5246  0bee 2a01          	jrpl	L67
5247  0bf0 53            	cplw	x
5248  0bf1               L67:
5249  0bf1 97            	ld	xl,a
5250  0bf2 1d0111        	subw	x,#273
5251  0bf5 01            	rrwa	x,a
5252  0bf6 b775          	ld	_T,a
5253  0bf8 02            	rlwa	x,a
5254                     ; 1298 if(T<-30)T=-30;
5256  0bf9 9c            	rvf
5257  0bfa b675          	ld	a,_T
5258  0bfc a1e2          	cp	a,#226
5259  0bfe 2e04          	jrsge	L5342
5262  0c00 35e20075      	mov	_T,#226
5263  0c04               L5342:
5264                     ; 1299 if(T>120)T=120;
5266  0c04 9c            	rvf
5267  0c05 b675          	ld	a,_T
5268  0c07 a179          	cp	a,#121
5269  0c09 2f04          	jrslt	L7342
5272  0c0b 35780075      	mov	_T,#120
5273  0c0f               L7342:
5274                     ; 1303 Uin=Usum-Ui;
5276  0c0f ce0010        	ldw	x,_Usum
5277  0c12 72b00016      	subw	x,_Ui
5278  0c16 cf000e        	ldw	_Uin,x
5279                     ; 1304 if(link==ON)
5281  0c19 b670          	ld	a,_link
5282  0c1b a155          	cp	a,#85
5283  0c1d 260c          	jrne	L1442
5284                     ; 1306 	Unecc=U_out_const-Uin;
5286  0c1f ce0012        	ldw	x,_U_out_const
5287  0c22 72b0000e      	subw	x,_Uin
5288  0c26 cf0014        	ldw	_Unecc,x
5290  0c29 200a          	jra	L3442
5291  0c2b               L1442:
5292                     ; 1315 else Unecc=ee_UAVT-Uin;
5294  0c2b ce000c        	ldw	x,_ee_UAVT
5295  0c2e 72b0000e      	subw	x,_Uin
5296  0c32 cf0014        	ldw	_Unecc,x
5297  0c35               L3442:
5298                     ; 1323 if(Unecc<0)Unecc=0;
5300  0c35 9c            	rvf
5301  0c36 ce0014        	ldw	x,_Unecc
5302  0c39 2e04          	jrsge	L5442
5305  0c3b 5f            	clrw	x
5306  0c3c cf0014        	ldw	_Unecc,x
5307  0c3f               L5442:
5308                     ; 1324 temp_SL=(signed long)(T-ee_tsign);
5310  0c3f 5f            	clrw	x
5311  0c40 b675          	ld	a,_T
5312  0c42 2a01          	jrpl	L001
5313  0c44 53            	cplw	x
5314  0c45               L001:
5315  0c45 97            	ld	xl,a
5316  0c46 72b0000e      	subw	x,_ee_tsign
5317  0c4a cd0000        	call	c_itolx
5319  0c4d 96            	ldw	x,sp
5320  0c4e 1c0005        	addw	x,#OFST-3
5321  0c51 cd0000        	call	c_rtol
5323                     ; 1325 temp_SL*=1000L;
5325  0c54 ae03e8        	ldw	x,#1000
5326  0c57 bf02          	ldw	c_lreg+2,x
5327  0c59 ae0000        	ldw	x,#0
5328  0c5c bf00          	ldw	c_lreg,x
5329  0c5e 96            	ldw	x,sp
5330  0c5f 1c0005        	addw	x,#OFST-3
5331  0c62 cd0000        	call	c_lgmul
5333                     ; 1326 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5335  0c65 ce0010        	ldw	x,_ee_tmax
5336  0c68 72b0000e      	subw	x,_ee_tsign
5337  0c6c cd0000        	call	c_itolx
5339  0c6f 96            	ldw	x,sp
5340  0c70 1c0001        	addw	x,#OFST-7
5341  0c73 cd0000        	call	c_rtol
5343  0c76 96            	ldw	x,sp
5344  0c77 1c0005        	addw	x,#OFST-3
5345  0c7a cd0000        	call	c_ltor
5347  0c7d 96            	ldw	x,sp
5348  0c7e 1c0001        	addw	x,#OFST-7
5349  0c81 cd0000        	call	c_ldiv
5351  0c84 96            	ldw	x,sp
5352  0c85 1c0005        	addw	x,#OFST-3
5353  0c88 cd0000        	call	c_rtol
5355                     ; 1328 vol_i_temp_avar=(unsigned short)temp_SL; 
5357  0c8b 1e07          	ldw	x,(OFST-1,sp)
5358  0c8d bf06          	ldw	_vol_i_temp_avar,x
5359                     ; 1330 debug_info_to_uku[0]=pwm_u;
5361  0c8f be08          	ldw	x,_pwm_u
5362  0c91 bf01          	ldw	_debug_info_to_uku,x
5363                     ; 1331 debug_info_to_uku[1]=vol_i_temp;
5365  0c93 be63          	ldw	x,_vol_i_temp
5366  0c95 bf03          	ldw	_debug_info_to_uku+2,x
5367                     ; 1334 Ufade=(I-150)/10;
5369  0c97 ce001a        	ldw	x,_I
5370  0c9a 1d0096        	subw	x,#150
5371  0c9d a60a          	ld	a,#10
5372  0c9f cd0000        	call	c_sdivx
5374  0ca2 cf000a        	ldw	_Ufade,x
5375                     ; 1335 if(Ufade<0)Ufade=0;
5377  0ca5 9c            	rvf
5378  0ca6 ce000a        	ldw	x,_Ufade
5379  0ca9 2e04          	jrsge	L7442
5382  0cab 5f            	clrw	x
5383  0cac cf000a        	ldw	_Ufade,x
5384  0caf               L7442:
5385                     ; 1336 if(Ufade>15)Ufade=15;
5387  0caf 9c            	rvf
5388  0cb0 ce000a        	ldw	x,_Ufade
5389  0cb3 a30010        	cpw	x,#16
5390  0cb6 2f06          	jrslt	L1542
5393  0cb8 ae000f        	ldw	x,#15
5394  0cbb cf000a        	ldw	_Ufade,x
5395  0cbe               L1542:
5396                     ; 1337 }
5399  0cbe 5b08          	addw	sp,#8
5400  0cc0 81            	ret
5431                     ; 1340 void temper_drv(void)		//1 Hz
5431                     ; 1341 {
5432                     	switch	.text
5433  0cc1               _temper_drv:
5437                     ; 1343 if(T>ee_tsign) tsign_cnt++;
5439  0cc1 9c            	rvf
5440  0cc2 5f            	clrw	x
5441  0cc3 b675          	ld	a,_T
5442  0cc5 2a01          	jrpl	L401
5443  0cc7 53            	cplw	x
5444  0cc8               L401:
5445  0cc8 97            	ld	xl,a
5446  0cc9 c3000e        	cpw	x,_ee_tsign
5447  0ccc 2d09          	jrsle	L3642
5450  0cce be5c          	ldw	x,_tsign_cnt
5451  0cd0 1c0001        	addw	x,#1
5452  0cd3 bf5c          	ldw	_tsign_cnt,x
5454  0cd5 201d          	jra	L5642
5455  0cd7               L3642:
5456                     ; 1344 else if (T<(ee_tsign-1)) tsign_cnt--;
5458  0cd7 9c            	rvf
5459  0cd8 ce000e        	ldw	x,_ee_tsign
5460  0cdb 5a            	decw	x
5461  0cdc 905f          	clrw	y
5462  0cde b675          	ld	a,_T
5463  0ce0 2a02          	jrpl	L601
5464  0ce2 9053          	cplw	y
5465  0ce4               L601:
5466  0ce4 9097          	ld	yl,a
5467  0ce6 90bf00        	ldw	c_y,y
5468  0ce9 b300          	cpw	x,c_y
5469  0ceb 2d07          	jrsle	L5642
5472  0ced be5c          	ldw	x,_tsign_cnt
5473  0cef 1d0001        	subw	x,#1
5474  0cf2 bf5c          	ldw	_tsign_cnt,x
5475  0cf4               L5642:
5476                     ; 1346 gran(&tsign_cnt,0,60);
5478  0cf4 ae003c        	ldw	x,#60
5479  0cf7 89            	pushw	x
5480  0cf8 5f            	clrw	x
5481  0cf9 89            	pushw	x
5482  0cfa ae005c        	ldw	x,#_tsign_cnt
5483  0cfd cd00d5        	call	_gran
5485  0d00 5b04          	addw	sp,#4
5486                     ; 1348 if(tsign_cnt>=55)
5488  0d02 9c            	rvf
5489  0d03 be5c          	ldw	x,_tsign_cnt
5490  0d05 a30037        	cpw	x,#55
5491  0d08 2f16          	jrslt	L1742
5492                     ; 1350 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5494  0d0a 3d55          	tnz	_jp_mode
5495  0d0c 2606          	jrne	L7742
5497  0d0e b605          	ld	a,_flags
5498  0d10 a540          	bcp	a,#64
5499  0d12 2706          	jreq	L5742
5500  0d14               L7742:
5502  0d14 b655          	ld	a,_jp_mode
5503  0d16 a103          	cp	a,#3
5504  0d18 2612          	jrne	L1052
5505  0d1a               L5742:
5508  0d1a 72140005      	bset	_flags,#2
5509  0d1e 200c          	jra	L1052
5510  0d20               L1742:
5511                     ; 1352 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5513  0d20 9c            	rvf
5514  0d21 be5c          	ldw	x,_tsign_cnt
5515  0d23 a30006        	cpw	x,#6
5516  0d26 2e04          	jrsge	L1052
5519  0d28 72150005      	bres	_flags,#2
5520  0d2c               L1052:
5521                     ; 1357 if(T>ee_tmax) tmax_cnt++;
5523  0d2c 9c            	rvf
5524  0d2d 5f            	clrw	x
5525  0d2e b675          	ld	a,_T
5526  0d30 2a01          	jrpl	L011
5527  0d32 53            	cplw	x
5528  0d33               L011:
5529  0d33 97            	ld	xl,a
5530  0d34 c30010        	cpw	x,_ee_tmax
5531  0d37 2d09          	jrsle	L5052
5534  0d39 be5a          	ldw	x,_tmax_cnt
5535  0d3b 1c0001        	addw	x,#1
5536  0d3e bf5a          	ldw	_tmax_cnt,x
5538  0d40 201d          	jra	L7052
5539  0d42               L5052:
5540                     ; 1358 else if (T<(ee_tmax-1)) tmax_cnt--;
5542  0d42 9c            	rvf
5543  0d43 ce0010        	ldw	x,_ee_tmax
5544  0d46 5a            	decw	x
5545  0d47 905f          	clrw	y
5546  0d49 b675          	ld	a,_T
5547  0d4b 2a02          	jrpl	L211
5548  0d4d 9053          	cplw	y
5549  0d4f               L211:
5550  0d4f 9097          	ld	yl,a
5551  0d51 90bf00        	ldw	c_y,y
5552  0d54 b300          	cpw	x,c_y
5553  0d56 2d07          	jrsle	L7052
5556  0d58 be5a          	ldw	x,_tmax_cnt
5557  0d5a 1d0001        	subw	x,#1
5558  0d5d bf5a          	ldw	_tmax_cnt,x
5559  0d5f               L7052:
5560                     ; 1360 gran(&tmax_cnt,0,60);
5562  0d5f ae003c        	ldw	x,#60
5563  0d62 89            	pushw	x
5564  0d63 5f            	clrw	x
5565  0d64 89            	pushw	x
5566  0d65 ae005a        	ldw	x,#_tmax_cnt
5567  0d68 cd00d5        	call	_gran
5569  0d6b 5b04          	addw	sp,#4
5570                     ; 1362 if(tmax_cnt>=55)
5572  0d6d 9c            	rvf
5573  0d6e be5a          	ldw	x,_tmax_cnt
5574  0d70 a30037        	cpw	x,#55
5575  0d73 2f16          	jrslt	L3152
5576                     ; 1364 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5578  0d75 3d55          	tnz	_jp_mode
5579  0d77 2606          	jrne	L1252
5581  0d79 b605          	ld	a,_flags
5582  0d7b a540          	bcp	a,#64
5583  0d7d 2706          	jreq	L7152
5584  0d7f               L1252:
5586  0d7f b655          	ld	a,_jp_mode
5587  0d81 a103          	cp	a,#3
5588  0d83 2612          	jrne	L3252
5589  0d85               L7152:
5592  0d85 72120005      	bset	_flags,#1
5593  0d89 200c          	jra	L3252
5594  0d8b               L3152:
5595                     ; 1366 else if (tmax_cnt<=5) flags&=0b11111101;
5597  0d8b 9c            	rvf
5598  0d8c be5a          	ldw	x,_tmax_cnt
5599  0d8e a30006        	cpw	x,#6
5600  0d91 2e04          	jrsge	L3252
5603  0d93 72130005      	bres	_flags,#1
5604  0d97               L3252:
5605                     ; 1369 } 
5608  0d97 81            	ret
5650                     ; 1372 void u_drv(void)		//1Hz
5650                     ; 1373 { 
5651                     	switch	.text
5652  0d98               _u_drv:
5654  0d98 89            	pushw	x
5655       00000002      OFST:	set	2
5658                     ; 1374 if(jp_mode!=jp3)
5660  0d99 b655          	ld	a,_jp_mode
5661  0d9b a103          	cp	a,#3
5662  0d9d 2772          	jreq	L5452
5663                     ; 1376 	if(Ui>ee_Umax)umax_cnt++;
5665  0d9f 9c            	rvf
5666  0da0 ce0016        	ldw	x,_Ui
5667  0da3 c30014        	cpw	x,_ee_Umax
5668  0da6 2d09          	jrsle	L7452
5671  0da8 be73          	ldw	x,_umax_cnt
5672  0daa 1c0001        	addw	x,#1
5673  0dad bf73          	ldw	_umax_cnt,x
5675  0daf 2003          	jra	L1552
5676  0db1               L7452:
5677                     ; 1377 	else umax_cnt=0;
5679  0db1 5f            	clrw	x
5680  0db2 bf73          	ldw	_umax_cnt,x
5681  0db4               L1552:
5682                     ; 1378 	gran(&umax_cnt,0,10);
5684  0db4 ae000a        	ldw	x,#10
5685  0db7 89            	pushw	x
5686  0db8 5f            	clrw	x
5687  0db9 89            	pushw	x
5688  0dba ae0073        	ldw	x,#_umax_cnt
5689  0dbd cd00d5        	call	_gran
5691  0dc0 5b04          	addw	sp,#4
5692                     ; 1379 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5694  0dc2 9c            	rvf
5695  0dc3 be73          	ldw	x,_umax_cnt
5696  0dc5 a3000a        	cpw	x,#10
5697  0dc8 2f04          	jrslt	L3552
5700  0dca 72160005      	bset	_flags,#3
5701  0dce               L3552:
5702                     ; 1382 	short Upwm=0;
5704                     ; 1383 	Upwm=(pwm_u/3)-50;
5706  0dce be08          	ldw	x,_pwm_u
5707  0dd0 a603          	ld	a,#3
5708  0dd2 cd0000        	call	c_sdivx
5710  0dd5 1d0032        	subw	x,#50
5711  0dd8 1f01          	ldw	(OFST-1,sp),x
5712                     ; 1385 	if((/*((Ui<Un)&&((Un-Ui)>ee_dU)) || */(Ui < Upwm))&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5714  0dda 9c            	rvf
5715  0ddb ce0016        	ldw	x,_Ui
5716  0dde 1301          	cpw	x,(OFST-1,sp)
5717  0de0 2e10          	jrsge	L5552
5719  0de2 c65005        	ld	a,20485
5720  0de5 a504          	bcp	a,#4
5721  0de7 2609          	jrne	L5552
5724  0de9 be71          	ldw	x,_umin_cnt
5725  0deb 1c0001        	addw	x,#1
5726  0dee bf71          	ldw	_umin_cnt,x
5728  0df0 2003          	jra	L7552
5729  0df2               L5552:
5730                     ; 1386 	else umin_cnt=0;
5732  0df2 5f            	clrw	x
5733  0df3 bf71          	ldw	_umin_cnt,x
5734  0df5               L7552:
5735                     ; 1387 	gran(&umin_cnt,0,10);	
5737  0df5 ae000a        	ldw	x,#10
5738  0df8 89            	pushw	x
5739  0df9 5f            	clrw	x
5740  0dfa 89            	pushw	x
5741  0dfb ae0071        	ldw	x,#_umin_cnt
5742  0dfe cd00d5        	call	_gran
5744  0e01 5b04          	addw	sp,#4
5745                     ; 1388 	if(umin_cnt>=10)flags|=0b00010000;
5747  0e03 9c            	rvf
5748  0e04 be71          	ldw	x,_umin_cnt
5749  0e06 a3000a        	cpw	x,#10
5750  0e09 2f71          	jrslt	L3652
5753  0e0b 72180005      	bset	_flags,#4
5754  0e0f 206b          	jra	L3652
5755  0e11               L5452:
5756                     ; 1391 else if(jp_mode==jp3)
5758  0e11 b655          	ld	a,_jp_mode
5759  0e13 a103          	cp	a,#3
5760  0e15 2665          	jrne	L3652
5761                     ; 1393 	if(Ui>700)umax_cnt++;
5763  0e17 9c            	rvf
5764  0e18 ce0016        	ldw	x,_Ui
5765  0e1b a302bd        	cpw	x,#701
5766  0e1e 2f09          	jrslt	L7652
5769  0e20 be73          	ldw	x,_umax_cnt
5770  0e22 1c0001        	addw	x,#1
5771  0e25 bf73          	ldw	_umax_cnt,x
5773  0e27 2003          	jra	L1752
5774  0e29               L7652:
5775                     ; 1394 	else umax_cnt=0;
5777  0e29 5f            	clrw	x
5778  0e2a bf73          	ldw	_umax_cnt,x
5779  0e2c               L1752:
5780                     ; 1395 	gran(&umax_cnt,0,10);
5782  0e2c ae000a        	ldw	x,#10
5783  0e2f 89            	pushw	x
5784  0e30 5f            	clrw	x
5785  0e31 89            	pushw	x
5786  0e32 ae0073        	ldw	x,#_umax_cnt
5787  0e35 cd00d5        	call	_gran
5789  0e38 5b04          	addw	sp,#4
5790                     ; 1396 	if(umax_cnt>=10)flags|=0b00001000;
5792  0e3a 9c            	rvf
5793  0e3b be73          	ldw	x,_umax_cnt
5794  0e3d a3000a        	cpw	x,#10
5795  0e40 2f04          	jrslt	L3752
5798  0e42 72160005      	bset	_flags,#3
5799  0e46               L3752:
5800                     ; 1399 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5802  0e46 9c            	rvf
5803  0e47 ce0016        	ldw	x,_Ui
5804  0e4a a300c8        	cpw	x,#200
5805  0e4d 2e10          	jrsge	L5752
5807  0e4f c65005        	ld	a,20485
5808  0e52 a504          	bcp	a,#4
5809  0e54 2609          	jrne	L5752
5812  0e56 be71          	ldw	x,_umin_cnt
5813  0e58 1c0001        	addw	x,#1
5814  0e5b bf71          	ldw	_umin_cnt,x
5816  0e5d 2003          	jra	L7752
5817  0e5f               L5752:
5818                     ; 1400 	else umin_cnt=0;
5820  0e5f 5f            	clrw	x
5821  0e60 bf71          	ldw	_umin_cnt,x
5822  0e62               L7752:
5823                     ; 1401 	gran(&umin_cnt,0,10);	
5825  0e62 ae000a        	ldw	x,#10
5826  0e65 89            	pushw	x
5827  0e66 5f            	clrw	x
5828  0e67 89            	pushw	x
5829  0e68 ae0071        	ldw	x,#_umin_cnt
5830  0e6b cd00d5        	call	_gran
5832  0e6e 5b04          	addw	sp,#4
5833                     ; 1402 	if(umin_cnt>=10)flags|=0b00010000;	  
5835  0e70 9c            	rvf
5836  0e71 be71          	ldw	x,_umin_cnt
5837  0e73 a3000a        	cpw	x,#10
5838  0e76 2f04          	jrslt	L3652
5841  0e78 72180005      	bset	_flags,#4
5842  0e7c               L3652:
5843                     ; 1404 }
5846  0e7c 85            	popw	x
5847  0e7d 81            	ret
5873                     ; 1429 void apv_start(void)
5873                     ; 1430 {
5874                     	switch	.text
5875  0e7e               _apv_start:
5879                     ; 1431 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5881  0e7e 3d50          	tnz	_apv_cnt
5882  0e80 2624          	jrne	L3162
5884  0e82 3d51          	tnz	_apv_cnt+1
5885  0e84 2620          	jrne	L3162
5887  0e86 3d52          	tnz	_apv_cnt+2
5888  0e88 261c          	jrne	L3162
5890                     	btst	_bAPV
5891  0e8f 2515          	jrult	L3162
5892                     ; 1433 	apv_cnt[0]=60;
5894  0e91 353c0050      	mov	_apv_cnt,#60
5895                     ; 1434 	apv_cnt[1]=60;
5897  0e95 353c0051      	mov	_apv_cnt+1,#60
5898                     ; 1435 	apv_cnt[2]=60;
5900  0e99 353c0052      	mov	_apv_cnt+2,#60
5901                     ; 1436 	apv_cnt_=3600;
5903  0e9d ae0e10        	ldw	x,#3600
5904  0ea0 bf4e          	ldw	_apv_cnt_,x
5905                     ; 1437 	bAPV=1;	
5907  0ea2 72100002      	bset	_bAPV
5908  0ea6               L3162:
5909                     ; 1439 }
5912  0ea6 81            	ret
5938                     ; 1442 void apv_stop(void)
5938                     ; 1443 {
5939                     	switch	.text
5940  0ea7               _apv_stop:
5944                     ; 1444 apv_cnt[0]=0;
5946  0ea7 3f50          	clr	_apv_cnt
5947                     ; 1445 apv_cnt[1]=0;
5949  0ea9 3f51          	clr	_apv_cnt+1
5950                     ; 1446 apv_cnt[2]=0;
5952  0eab 3f52          	clr	_apv_cnt+2
5953                     ; 1447 apv_cnt_=0;	
5955  0ead 5f            	clrw	x
5956  0eae bf4e          	ldw	_apv_cnt_,x
5957                     ; 1448 bAPV=0;
5959  0eb0 72110002      	bres	_bAPV
5960                     ; 1449 }
5963  0eb4 81            	ret
5998                     ; 1453 void apv_hndl(void)
5998                     ; 1454 {
5999                     	switch	.text
6000  0eb5               _apv_hndl:
6004                     ; 1455 if(apv_cnt[0])
6006  0eb5 3d50          	tnz	_apv_cnt
6007  0eb7 271e          	jreq	L5362
6008                     ; 1457 	apv_cnt[0]--;
6010  0eb9 3a50          	dec	_apv_cnt
6011                     ; 1458 	if(apv_cnt[0]==0)
6013  0ebb 3d50          	tnz	_apv_cnt
6014  0ebd 265a          	jrne	L1462
6015                     ; 1460 		flags&=0b11100001;
6017  0ebf b605          	ld	a,_flags
6018  0ec1 a4e1          	and	a,#225
6019  0ec3 b705          	ld	_flags,a
6020                     ; 1461 		tsign_cnt=0;
6022  0ec5 5f            	clrw	x
6023  0ec6 bf5c          	ldw	_tsign_cnt,x
6024                     ; 1462 		tmax_cnt=0;
6026  0ec8 5f            	clrw	x
6027  0ec9 bf5a          	ldw	_tmax_cnt,x
6028                     ; 1463 		umax_cnt=0;
6030  0ecb 5f            	clrw	x
6031  0ecc bf73          	ldw	_umax_cnt,x
6032                     ; 1464 		umin_cnt=0;
6034  0ece 5f            	clrw	x
6035  0ecf bf71          	ldw	_umin_cnt,x
6036                     ; 1466 		led_drv_cnt=30;
6038  0ed1 351e0016      	mov	_led_drv_cnt,#30
6039  0ed5 2042          	jra	L1462
6040  0ed7               L5362:
6041                     ; 1469 else if(apv_cnt[1])
6043  0ed7 3d51          	tnz	_apv_cnt+1
6044  0ed9 271e          	jreq	L3462
6045                     ; 1471 	apv_cnt[1]--;
6047  0edb 3a51          	dec	_apv_cnt+1
6048                     ; 1472 	if(apv_cnt[1]==0)
6050  0edd 3d51          	tnz	_apv_cnt+1
6051  0edf 2638          	jrne	L1462
6052                     ; 1474 		flags&=0b11100001;
6054  0ee1 b605          	ld	a,_flags
6055  0ee3 a4e1          	and	a,#225
6056  0ee5 b705          	ld	_flags,a
6057                     ; 1475 		tsign_cnt=0;
6059  0ee7 5f            	clrw	x
6060  0ee8 bf5c          	ldw	_tsign_cnt,x
6061                     ; 1476 		tmax_cnt=0;
6063  0eea 5f            	clrw	x
6064  0eeb bf5a          	ldw	_tmax_cnt,x
6065                     ; 1477 		umax_cnt=0;
6067  0eed 5f            	clrw	x
6068  0eee bf73          	ldw	_umax_cnt,x
6069                     ; 1478 		umin_cnt=0;
6071  0ef0 5f            	clrw	x
6072  0ef1 bf71          	ldw	_umin_cnt,x
6073                     ; 1480 		led_drv_cnt=30;
6075  0ef3 351e0016      	mov	_led_drv_cnt,#30
6076  0ef7 2020          	jra	L1462
6077  0ef9               L3462:
6078                     ; 1483 else if(apv_cnt[2])
6080  0ef9 3d52          	tnz	_apv_cnt+2
6081  0efb 271c          	jreq	L1462
6082                     ; 1485 	apv_cnt[2]--;
6084  0efd 3a52          	dec	_apv_cnt+2
6085                     ; 1486 	if(apv_cnt[2]==0)
6087  0eff 3d52          	tnz	_apv_cnt+2
6088  0f01 2616          	jrne	L1462
6089                     ; 1488 		flags&=0b11100001;
6091  0f03 b605          	ld	a,_flags
6092  0f05 a4e1          	and	a,#225
6093  0f07 b705          	ld	_flags,a
6094                     ; 1489 		tsign_cnt=0;
6096  0f09 5f            	clrw	x
6097  0f0a bf5c          	ldw	_tsign_cnt,x
6098                     ; 1490 		tmax_cnt=0;
6100  0f0c 5f            	clrw	x
6101  0f0d bf5a          	ldw	_tmax_cnt,x
6102                     ; 1491 		umax_cnt=0;
6104  0f0f 5f            	clrw	x
6105  0f10 bf73          	ldw	_umax_cnt,x
6106                     ; 1492 		umin_cnt=0;          
6108  0f12 5f            	clrw	x
6109  0f13 bf71          	ldw	_umin_cnt,x
6110                     ; 1494 		led_drv_cnt=30;
6112  0f15 351e0016      	mov	_led_drv_cnt,#30
6113  0f19               L1462:
6114                     ; 1498 if(apv_cnt_)
6116  0f19 be4e          	ldw	x,_apv_cnt_
6117  0f1b 2712          	jreq	L5562
6118                     ; 1500 	apv_cnt_--;
6120  0f1d be4e          	ldw	x,_apv_cnt_
6121  0f1f 1d0001        	subw	x,#1
6122  0f22 bf4e          	ldw	_apv_cnt_,x
6123                     ; 1501 	if(apv_cnt_==0) 
6125  0f24 be4e          	ldw	x,_apv_cnt_
6126  0f26 2607          	jrne	L5562
6127                     ; 1503 		bAPV=0;
6129  0f28 72110002      	bres	_bAPV
6130                     ; 1504 		apv_start();
6132  0f2c cd0e7e        	call	_apv_start
6134  0f2f               L5562:
6135                     ; 1508 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6137  0f2f be71          	ldw	x,_umin_cnt
6138  0f31 261e          	jrne	L1662
6140  0f33 be73          	ldw	x,_umax_cnt
6141  0f35 261a          	jrne	L1662
6143  0f37 c65005        	ld	a,20485
6144  0f3a a504          	bcp	a,#4
6145  0f3c 2613          	jrne	L1662
6146                     ; 1510 	if(cnt_apv_off<20)
6148  0f3e b64d          	ld	a,_cnt_apv_off
6149  0f40 a114          	cp	a,#20
6150  0f42 240f          	jruge	L7662
6151                     ; 1512 		cnt_apv_off++;
6153  0f44 3c4d          	inc	_cnt_apv_off
6154                     ; 1513 		if(cnt_apv_off>=20)
6156  0f46 b64d          	ld	a,_cnt_apv_off
6157  0f48 a114          	cp	a,#20
6158  0f4a 2507          	jrult	L7662
6159                     ; 1515 			apv_stop();
6161  0f4c cd0ea7        	call	_apv_stop
6163  0f4f 2002          	jra	L7662
6164  0f51               L1662:
6165                     ; 1519 else cnt_apv_off=0;	
6167  0f51 3f4d          	clr	_cnt_apv_off
6168  0f53               L7662:
6169                     ; 1521 }
6172  0f53 81            	ret
6175                     	switch	.ubsct
6176  0000               L1762_flags_old:
6177  0000 00            	ds.b	1
6213                     ; 1524 void flags_drv(void)
6213                     ; 1525 {
6214                     	switch	.text
6215  0f54               _flags_drv:
6219                     ; 1527 if(jp_mode!=jp3) 
6221  0f54 b655          	ld	a,_jp_mode
6222  0f56 a103          	cp	a,#3
6223  0f58 2723          	jreq	L1172
6224                     ; 1529 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6226  0f5a b605          	ld	a,_flags
6227  0f5c a508          	bcp	a,#8
6228  0f5e 2706          	jreq	L7172
6230  0f60 b600          	ld	a,L1762_flags_old
6231  0f62 a508          	bcp	a,#8
6232  0f64 270c          	jreq	L5172
6233  0f66               L7172:
6235  0f66 b605          	ld	a,_flags
6236  0f68 a510          	bcp	a,#16
6237  0f6a 2726          	jreq	L3272
6239  0f6c b600          	ld	a,L1762_flags_old
6240  0f6e a510          	bcp	a,#16
6241  0f70 2620          	jrne	L3272
6242  0f72               L5172:
6243                     ; 1531     		if(link==OFF)apv_start();
6245  0f72 b670          	ld	a,_link
6246  0f74 a1aa          	cp	a,#170
6247  0f76 261a          	jrne	L3272
6250  0f78 cd0e7e        	call	_apv_start
6252  0f7b 2015          	jra	L3272
6253  0f7d               L1172:
6254                     ; 1534 else if(jp_mode==jp3) 
6256  0f7d b655          	ld	a,_jp_mode
6257  0f7f a103          	cp	a,#3
6258  0f81 260f          	jrne	L3272
6259                     ; 1536 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6261  0f83 b605          	ld	a,_flags
6262  0f85 a508          	bcp	a,#8
6263  0f87 2709          	jreq	L3272
6265  0f89 b600          	ld	a,L1762_flags_old
6266  0f8b a508          	bcp	a,#8
6267  0f8d 2603          	jrne	L3272
6268                     ; 1538     		apv_start();
6270  0f8f cd0e7e        	call	_apv_start
6272  0f92               L3272:
6273                     ; 1541 flags_old=flags;
6275  0f92 450500        	mov	L1762_flags_old,_flags
6276                     ; 1543 } 
6279  0f95 81            	ret
6314                     ; 1680 void adr_drv_v4(char in)
6314                     ; 1681 {
6315                     	switch	.text
6316  0f96               _adr_drv_v4:
6320                     ; 1682 if(adress!=in)adress=in;
6322  0f96 c10101        	cp	a,_adress
6323  0f99 2703          	jreq	L7472
6326  0f9b c70101        	ld	_adress,a
6327  0f9e               L7472:
6328                     ; 1683 }
6331  0f9e 81            	ret
6360                     ; 1686 void adr_drv_v3(void)
6360                     ; 1687 {
6361                     	switch	.text
6362  0f9f               _adr_drv_v3:
6364  0f9f 88            	push	a
6365       00000001      OFST:	set	1
6368                     ; 1693 GPIOB->DDR&=~(1<<0);
6370  0fa0 72115007      	bres	20487,#0
6371                     ; 1694 GPIOB->CR1&=~(1<<0);
6373  0fa4 72115008      	bres	20488,#0
6374                     ; 1695 GPIOB->CR2&=~(1<<0);
6376  0fa8 72115009      	bres	20489,#0
6377                     ; 1696 ADC2->CR2=0x08;
6379  0fac 35085402      	mov	21506,#8
6380                     ; 1697 ADC2->CR1=0x40;
6382  0fb0 35405401      	mov	21505,#64
6383                     ; 1698 ADC2->CSR=0x20+0;
6385  0fb4 35205400      	mov	21504,#32
6386                     ; 1699 ADC2->CR1|=1;
6388  0fb8 72105401      	bset	21505,#0
6389                     ; 1700 ADC2->CR1|=1;
6391  0fbc 72105401      	bset	21505,#0
6392                     ; 1701 adr_drv_stat=1;
6394  0fc0 35010002      	mov	_adr_drv_stat,#1
6395  0fc4               L1672:
6396                     ; 1702 while(adr_drv_stat==1);
6399  0fc4 b602          	ld	a,_adr_drv_stat
6400  0fc6 a101          	cp	a,#1
6401  0fc8 27fa          	jreq	L1672
6402                     ; 1704 GPIOB->DDR&=~(1<<1);
6404  0fca 72135007      	bres	20487,#1
6405                     ; 1705 GPIOB->CR1&=~(1<<1);
6407  0fce 72135008      	bres	20488,#1
6408                     ; 1706 GPIOB->CR2&=~(1<<1);
6410  0fd2 72135009      	bres	20489,#1
6411                     ; 1707 ADC2->CR2=0x08;
6413  0fd6 35085402      	mov	21506,#8
6414                     ; 1708 ADC2->CR1=0x40;
6416  0fda 35405401      	mov	21505,#64
6417                     ; 1709 ADC2->CSR=0x20+1;
6419  0fde 35215400      	mov	21504,#33
6420                     ; 1710 ADC2->CR1|=1;
6422  0fe2 72105401      	bset	21505,#0
6423                     ; 1711 ADC2->CR1|=1;
6425  0fe6 72105401      	bset	21505,#0
6426                     ; 1712 adr_drv_stat=3;
6428  0fea 35030002      	mov	_adr_drv_stat,#3
6429  0fee               L7672:
6430                     ; 1713 while(adr_drv_stat==3);
6433  0fee b602          	ld	a,_adr_drv_stat
6434  0ff0 a103          	cp	a,#3
6435  0ff2 27fa          	jreq	L7672
6436                     ; 1715 GPIOE->DDR&=~(1<<6);
6438  0ff4 721d5016      	bres	20502,#6
6439                     ; 1716 GPIOE->CR1&=~(1<<6);
6441  0ff8 721d5017      	bres	20503,#6
6442                     ; 1717 GPIOE->CR2&=~(1<<6);
6444  0ffc 721d5018      	bres	20504,#6
6445                     ; 1718 ADC2->CR2=0x08;
6447  1000 35085402      	mov	21506,#8
6448                     ; 1719 ADC2->CR1=0x40;
6450  1004 35405401      	mov	21505,#64
6451                     ; 1720 ADC2->CSR=0x20+9;
6453  1008 35295400      	mov	21504,#41
6454                     ; 1721 ADC2->CR1|=1;
6456  100c 72105401      	bset	21505,#0
6457                     ; 1722 ADC2->CR1|=1;
6459  1010 72105401      	bset	21505,#0
6460                     ; 1723 adr_drv_stat=5;
6462  1014 35050002      	mov	_adr_drv_stat,#5
6463  1018               L5772:
6464                     ; 1724 while(adr_drv_stat==5);
6467  1018 b602          	ld	a,_adr_drv_stat
6468  101a a105          	cp	a,#5
6469  101c 27fa          	jreq	L5772
6470                     ; 1728 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6472  101e 9c            	rvf
6473  101f ce0109        	ldw	x,_adc_buff_
6474  1022 a3022a        	cpw	x,#554
6475  1025 2f0f          	jrslt	L3003
6477  1027 9c            	rvf
6478  1028 ce0109        	ldw	x,_adc_buff_
6479  102b a30253        	cpw	x,#595
6480  102e 2e06          	jrsge	L3003
6483  1030 725f0102      	clr	_adr
6485  1034 204c          	jra	L5003
6486  1036               L3003:
6487                     ; 1729 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6489  1036 9c            	rvf
6490  1037 ce0109        	ldw	x,_adc_buff_
6491  103a a3036d        	cpw	x,#877
6492  103d 2f0f          	jrslt	L7003
6494  103f 9c            	rvf
6495  1040 ce0109        	ldw	x,_adc_buff_
6496  1043 a30396        	cpw	x,#918
6497  1046 2e06          	jrsge	L7003
6500  1048 35010102      	mov	_adr,#1
6502  104c 2034          	jra	L5003
6503  104e               L7003:
6504                     ; 1730 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6506  104e 9c            	rvf
6507  104f ce0109        	ldw	x,_adc_buff_
6508  1052 a302a3        	cpw	x,#675
6509  1055 2f0f          	jrslt	L3103
6511  1057 9c            	rvf
6512  1058 ce0109        	ldw	x,_adc_buff_
6513  105b a302cc        	cpw	x,#716
6514  105e 2e06          	jrsge	L3103
6517  1060 35020102      	mov	_adr,#2
6519  1064 201c          	jra	L5003
6520  1066               L3103:
6521                     ; 1731 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6523  1066 9c            	rvf
6524  1067 ce0109        	ldw	x,_adc_buff_
6525  106a a303e3        	cpw	x,#995
6526  106d 2f0f          	jrslt	L7103
6528  106f 9c            	rvf
6529  1070 ce0109        	ldw	x,_adc_buff_
6530  1073 a3040c        	cpw	x,#1036
6531  1076 2e06          	jrsge	L7103
6534  1078 35030102      	mov	_adr,#3
6536  107c 2004          	jra	L5003
6537  107e               L7103:
6538                     ; 1732 else adr[0]=5;
6540  107e 35050102      	mov	_adr,#5
6541  1082               L5003:
6542                     ; 1734 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6544  1082 9c            	rvf
6545  1083 ce010b        	ldw	x,_adc_buff_+2
6546  1086 a3022a        	cpw	x,#554
6547  1089 2f0f          	jrslt	L3203
6549  108b 9c            	rvf
6550  108c ce010b        	ldw	x,_adc_buff_+2
6551  108f a30253        	cpw	x,#595
6552  1092 2e06          	jrsge	L3203
6555  1094 725f0103      	clr	_adr+1
6557  1098 204c          	jra	L5203
6558  109a               L3203:
6559                     ; 1735 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6561  109a 9c            	rvf
6562  109b ce010b        	ldw	x,_adc_buff_+2
6563  109e a3036d        	cpw	x,#877
6564  10a1 2f0f          	jrslt	L7203
6566  10a3 9c            	rvf
6567  10a4 ce010b        	ldw	x,_adc_buff_+2
6568  10a7 a30396        	cpw	x,#918
6569  10aa 2e06          	jrsge	L7203
6572  10ac 35010103      	mov	_adr+1,#1
6574  10b0 2034          	jra	L5203
6575  10b2               L7203:
6576                     ; 1736 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6578  10b2 9c            	rvf
6579  10b3 ce010b        	ldw	x,_adc_buff_+2
6580  10b6 a302a3        	cpw	x,#675
6581  10b9 2f0f          	jrslt	L3303
6583  10bb 9c            	rvf
6584  10bc ce010b        	ldw	x,_adc_buff_+2
6585  10bf a302cc        	cpw	x,#716
6586  10c2 2e06          	jrsge	L3303
6589  10c4 35020103      	mov	_adr+1,#2
6591  10c8 201c          	jra	L5203
6592  10ca               L3303:
6593                     ; 1737 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6595  10ca 9c            	rvf
6596  10cb ce010b        	ldw	x,_adc_buff_+2
6597  10ce a303e3        	cpw	x,#995
6598  10d1 2f0f          	jrslt	L7303
6600  10d3 9c            	rvf
6601  10d4 ce010b        	ldw	x,_adc_buff_+2
6602  10d7 a3040c        	cpw	x,#1036
6603  10da 2e06          	jrsge	L7303
6606  10dc 35030103      	mov	_adr+1,#3
6608  10e0 2004          	jra	L5203
6609  10e2               L7303:
6610                     ; 1738 else adr[1]=5;
6612  10e2 35050103      	mov	_adr+1,#5
6613  10e6               L5203:
6614                     ; 1740 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6616  10e6 9c            	rvf
6617  10e7 ce011b        	ldw	x,_adc_buff_+18
6618  10ea a3022a        	cpw	x,#554
6619  10ed 2f0f          	jrslt	L3403
6621  10ef 9c            	rvf
6622  10f0 ce011b        	ldw	x,_adc_buff_+18
6623  10f3 a30253        	cpw	x,#595
6624  10f6 2e06          	jrsge	L3403
6627  10f8 725f0104      	clr	_adr+2
6629  10fc 204c          	jra	L5403
6630  10fe               L3403:
6631                     ; 1741 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6633  10fe 9c            	rvf
6634  10ff ce011b        	ldw	x,_adc_buff_+18
6635  1102 a3036d        	cpw	x,#877
6636  1105 2f0f          	jrslt	L7403
6638  1107 9c            	rvf
6639  1108 ce011b        	ldw	x,_adc_buff_+18
6640  110b a30396        	cpw	x,#918
6641  110e 2e06          	jrsge	L7403
6644  1110 35010104      	mov	_adr+2,#1
6646  1114 2034          	jra	L5403
6647  1116               L7403:
6648                     ; 1742 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6650  1116 9c            	rvf
6651  1117 ce011b        	ldw	x,_adc_buff_+18
6652  111a a302a3        	cpw	x,#675
6653  111d 2f0f          	jrslt	L3503
6655  111f 9c            	rvf
6656  1120 ce011b        	ldw	x,_adc_buff_+18
6657  1123 a302cc        	cpw	x,#716
6658  1126 2e06          	jrsge	L3503
6661  1128 35020104      	mov	_adr+2,#2
6663  112c 201c          	jra	L5403
6664  112e               L3503:
6665                     ; 1743 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6667  112e 9c            	rvf
6668  112f ce011b        	ldw	x,_adc_buff_+18
6669  1132 a303e3        	cpw	x,#995
6670  1135 2f0f          	jrslt	L7503
6672  1137 9c            	rvf
6673  1138 ce011b        	ldw	x,_adc_buff_+18
6674  113b a3040c        	cpw	x,#1036
6675  113e 2e06          	jrsge	L7503
6678  1140 35030104      	mov	_adr+2,#3
6680  1144 2004          	jra	L5403
6681  1146               L7503:
6682                     ; 1744 else adr[2]=5;
6684  1146 35050104      	mov	_adr+2,#5
6685  114a               L5403:
6686                     ; 1748 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6688  114a c60102        	ld	a,_adr
6689  114d a105          	cp	a,#5
6690  114f 270e          	jreq	L5603
6692  1151 c60103        	ld	a,_adr+1
6693  1154 a105          	cp	a,#5
6694  1156 2707          	jreq	L5603
6696  1158 c60104        	ld	a,_adr+2
6697  115b a105          	cp	a,#5
6698  115d 2606          	jrne	L3603
6699  115f               L5603:
6700                     ; 1751 	adress_error=1;
6702  115f 35010100      	mov	_adress_error,#1
6704  1163               L1703:
6705                     ; 1762 }
6708  1163 84            	pop	a
6709  1164 81            	ret
6710  1165               L3603:
6711                     ; 1755 	if(adr[2]&0x02) bps_class=bpsIPS;
6713  1165 c60104        	ld	a,_adr+2
6714  1168 a502          	bcp	a,#2
6715  116a 2706          	jreq	L3703
6718  116c 3501000b      	mov	_bps_class,#1
6720  1170 2002          	jra	L5703
6721  1172               L3703:
6722                     ; 1756 	else bps_class=bpsIBEP;
6724  1172 3f0b          	clr	_bps_class
6725  1174               L5703:
6726                     ; 1758 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6728  1174 c60104        	ld	a,_adr+2
6729  1177 a401          	and	a,#1
6730  1179 97            	ld	xl,a
6731  117a a610          	ld	a,#16
6732  117c 42            	mul	x,a
6733  117d 9f            	ld	a,xl
6734  117e 6b01          	ld	(OFST+0,sp),a
6735  1180 c60103        	ld	a,_adr+1
6736  1183 48            	sll	a
6737  1184 48            	sll	a
6738  1185 cb0102        	add	a,_adr
6739  1188 1b01          	add	a,(OFST+0,sp)
6740  118a c70101        	ld	_adress,a
6741  118d 20d4          	jra	L1703
6764                     ; 1812 void init_CAN(void) {
6765                     	switch	.text
6766  118f               _init_CAN:
6770                     ; 1813 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6772  118f 72135420      	bres	21536,#1
6773                     ; 1814 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6775  1193 72105420      	bset	21536,#0
6777  1197               L1113:
6778                     ; 1815 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6780  1197 c65421        	ld	a,21537
6781  119a a501          	bcp	a,#1
6782  119c 27f9          	jreq	L1113
6783                     ; 1817 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6785  119e 72185420      	bset	21536,#4
6786                     ; 1819 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6788  11a2 35025427      	mov	21543,#2
6789                     ; 1828 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6791  11a6 35135428      	mov	21544,#19
6792                     ; 1829 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6794  11aa 35c05429      	mov	21545,#192
6795                     ; 1830 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6797  11ae 357f542c      	mov	21548,#127
6798                     ; 1831 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6800  11b2 35e0542d      	mov	21549,#224
6801                     ; 1833 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6803  11b6 35315430      	mov	21552,#49
6804                     ; 1834 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6806  11ba 35c05431      	mov	21553,#192
6807                     ; 1835 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6809  11be 357f5434      	mov	21556,#127
6810                     ; 1836 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6812  11c2 35e05435      	mov	21557,#224
6813                     ; 1840 	CAN->PSR= 6;									// set page 6
6815  11c6 35065427      	mov	21543,#6
6816                     ; 1845 	CAN->Page.Config.FMR1&=~3;								//mask mode
6818  11ca c65430        	ld	a,21552
6819  11cd a4fc          	and	a,#252
6820  11cf c75430        	ld	21552,a
6821                     ; 1851 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6823  11d2 35065432      	mov	21554,#6
6824                     ; 1852 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6826  11d6 35605432      	mov	21554,#96
6827                     ; 1855 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6829  11da 72105432      	bset	21554,#0
6830                     ; 1856 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6832  11de 72185432      	bset	21554,#4
6833                     ; 1859 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6835  11e2 35065427      	mov	21543,#6
6836                     ; 1861 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6838  11e6 35d3542c      	mov	21548,#211
6839                     ; 1862 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6841  11ea 35e7542d      	mov	21549,#231
6842                     ; 1864 	CAN->IER|=(1<<1);
6844  11ee 72125425      	bset	21541,#1
6845                     ; 1867 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6847  11f2 72115420      	bres	21536,#0
6849  11f6               L7113:
6850                     ; 1868 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6852  11f6 c65421        	ld	a,21537
6853  11f9 a501          	bcp	a,#1
6854  11fb 26f9          	jrne	L7113
6855                     ; 1869 }
6858  11fd 81            	ret
6966                     ; 1872 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6966                     ; 1873 {
6967                     	switch	.text
6968  11fe               _can_transmit:
6970  11fe 89            	pushw	x
6971       00000000      OFST:	set	0
6974                     ; 1875 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6976  11ff b679          	ld	a,_can_buff_wr_ptr
6977  1201 a104          	cp	a,#4
6978  1203 2502          	jrult	L1023
6981  1205 3f79          	clr	_can_buff_wr_ptr
6982  1207               L1023:
6983                     ; 1877 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6985  1207 b679          	ld	a,_can_buff_wr_ptr
6986  1209 97            	ld	xl,a
6987  120a a610          	ld	a,#16
6988  120c 42            	mul	x,a
6989  120d 1601          	ldw	y,(OFST+1,sp)
6990  120f a606          	ld	a,#6
6991  1211               L631:
6992  1211 9054          	srlw	y
6993  1213 4a            	dec	a
6994  1214 26fb          	jrne	L631
6995  1216 909f          	ld	a,yl
6996  1218 e77a          	ld	(_can_out_buff,x),a
6997                     ; 1878 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6999  121a b679          	ld	a,_can_buff_wr_ptr
7000  121c 97            	ld	xl,a
7001  121d a610          	ld	a,#16
7002  121f 42            	mul	x,a
7003  1220 7b02          	ld	a,(OFST+2,sp)
7004  1222 48            	sll	a
7005  1223 48            	sll	a
7006  1224 e77b          	ld	(_can_out_buff+1,x),a
7007                     ; 1880 can_out_buff[can_buff_wr_ptr][2]=data0;
7009  1226 b679          	ld	a,_can_buff_wr_ptr
7010  1228 97            	ld	xl,a
7011  1229 a610          	ld	a,#16
7012  122b 42            	mul	x,a
7013  122c 7b05          	ld	a,(OFST+5,sp)
7014  122e e77c          	ld	(_can_out_buff+2,x),a
7015                     ; 1881 can_out_buff[can_buff_wr_ptr][3]=data1;
7017  1230 b679          	ld	a,_can_buff_wr_ptr
7018  1232 97            	ld	xl,a
7019  1233 a610          	ld	a,#16
7020  1235 42            	mul	x,a
7021  1236 7b06          	ld	a,(OFST+6,sp)
7022  1238 e77d          	ld	(_can_out_buff+3,x),a
7023                     ; 1882 can_out_buff[can_buff_wr_ptr][4]=data2;
7025  123a b679          	ld	a,_can_buff_wr_ptr
7026  123c 97            	ld	xl,a
7027  123d a610          	ld	a,#16
7028  123f 42            	mul	x,a
7029  1240 7b07          	ld	a,(OFST+7,sp)
7030  1242 e77e          	ld	(_can_out_buff+4,x),a
7031                     ; 1883 can_out_buff[can_buff_wr_ptr][5]=data3;
7033  1244 b679          	ld	a,_can_buff_wr_ptr
7034  1246 97            	ld	xl,a
7035  1247 a610          	ld	a,#16
7036  1249 42            	mul	x,a
7037  124a 7b08          	ld	a,(OFST+8,sp)
7038  124c e77f          	ld	(_can_out_buff+5,x),a
7039                     ; 1884 can_out_buff[can_buff_wr_ptr][6]=data4;
7041  124e b679          	ld	a,_can_buff_wr_ptr
7042  1250 97            	ld	xl,a
7043  1251 a610          	ld	a,#16
7044  1253 42            	mul	x,a
7045  1254 7b09          	ld	a,(OFST+9,sp)
7046  1256 e780          	ld	(_can_out_buff+6,x),a
7047                     ; 1885 can_out_buff[can_buff_wr_ptr][7]=data5;
7049  1258 b679          	ld	a,_can_buff_wr_ptr
7050  125a 97            	ld	xl,a
7051  125b a610          	ld	a,#16
7052  125d 42            	mul	x,a
7053  125e 7b0a          	ld	a,(OFST+10,sp)
7054  1260 e781          	ld	(_can_out_buff+7,x),a
7055                     ; 1886 can_out_buff[can_buff_wr_ptr][8]=data6;
7057  1262 b679          	ld	a,_can_buff_wr_ptr
7058  1264 97            	ld	xl,a
7059  1265 a610          	ld	a,#16
7060  1267 42            	mul	x,a
7061  1268 7b0b          	ld	a,(OFST+11,sp)
7062  126a e782          	ld	(_can_out_buff+8,x),a
7063                     ; 1887 can_out_buff[can_buff_wr_ptr][9]=data7;
7065  126c b679          	ld	a,_can_buff_wr_ptr
7066  126e 97            	ld	xl,a
7067  126f a610          	ld	a,#16
7068  1271 42            	mul	x,a
7069  1272 7b0c          	ld	a,(OFST+12,sp)
7070  1274 e783          	ld	(_can_out_buff+9,x),a
7071                     ; 1889 can_buff_wr_ptr++;
7073  1276 3c79          	inc	_can_buff_wr_ptr
7074                     ; 1890 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7076  1278 b679          	ld	a,_can_buff_wr_ptr
7077  127a a104          	cp	a,#4
7078  127c 2502          	jrult	L3023
7081  127e 3f79          	clr	_can_buff_wr_ptr
7082  1280               L3023:
7083                     ; 1891 } 
7086  1280 85            	popw	x
7087  1281 81            	ret
7116                     ; 1894 void can_tx_hndl(void)
7116                     ; 1895 {
7117                     	switch	.text
7118  1282               _can_tx_hndl:
7122                     ; 1896 if(bTX_FREE)
7124  1282 3d03          	tnz	_bTX_FREE
7125  1284 2757          	jreq	L5123
7126                     ; 1898 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7128  1286 b678          	ld	a,_can_buff_rd_ptr
7129  1288 b179          	cp	a,_can_buff_wr_ptr
7130  128a 275f          	jreq	L3223
7131                     ; 1900 		bTX_FREE=0;
7133  128c 3f03          	clr	_bTX_FREE
7134                     ; 1902 		CAN->PSR= 0;
7136  128e 725f5427      	clr	21543
7137                     ; 1903 		CAN->Page.TxMailbox.MDLCR=8;
7139  1292 35085429      	mov	21545,#8
7140                     ; 1904 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7142  1296 b678          	ld	a,_can_buff_rd_ptr
7143  1298 97            	ld	xl,a
7144  1299 a610          	ld	a,#16
7145  129b 42            	mul	x,a
7146  129c e67a          	ld	a,(_can_out_buff,x)
7147  129e c7542a        	ld	21546,a
7148                     ; 1905 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7150  12a1 b678          	ld	a,_can_buff_rd_ptr
7151  12a3 97            	ld	xl,a
7152  12a4 a610          	ld	a,#16
7153  12a6 42            	mul	x,a
7154  12a7 e67b          	ld	a,(_can_out_buff+1,x)
7155  12a9 c7542b        	ld	21547,a
7156                     ; 1907 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7158  12ac b678          	ld	a,_can_buff_rd_ptr
7159  12ae 97            	ld	xl,a
7160  12af a610          	ld	a,#16
7161  12b1 42            	mul	x,a
7162  12b2 01            	rrwa	x,a
7163  12b3 ab7c          	add	a,#_can_out_buff+2
7164  12b5 2401          	jrnc	L241
7165  12b7 5c            	incw	x
7166  12b8               L241:
7167  12b8 5f            	clrw	x
7168  12b9 97            	ld	xl,a
7169  12ba bf00          	ldw	c_x,x
7170  12bc ae0008        	ldw	x,#8
7171  12bf               L441:
7172  12bf 5a            	decw	x
7173  12c0 92d600        	ld	a,([c_x],x)
7174  12c3 d7542e        	ld	(21550,x),a
7175  12c6 5d            	tnzw	x
7176  12c7 26f6          	jrne	L441
7177                     ; 1909 		can_buff_rd_ptr++;
7179  12c9 3c78          	inc	_can_buff_rd_ptr
7180                     ; 1910 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7182  12cb b678          	ld	a,_can_buff_rd_ptr
7183  12cd a104          	cp	a,#4
7184  12cf 2502          	jrult	L1223
7187  12d1 3f78          	clr	_can_buff_rd_ptr
7188  12d3               L1223:
7189                     ; 1912 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7191  12d3 72105428      	bset	21544,#0
7192                     ; 1913 		CAN->IER|=(1<<0);
7194  12d7 72105425      	bset	21541,#0
7195  12db 200e          	jra	L3223
7196  12dd               L5123:
7197                     ; 1918 	tx_busy_cnt++;
7199  12dd 3c77          	inc	_tx_busy_cnt
7200                     ; 1919 	if(tx_busy_cnt>=100)
7202  12df b677          	ld	a,_tx_busy_cnt
7203  12e1 a164          	cp	a,#100
7204  12e3 2506          	jrult	L3223
7205                     ; 1921 		tx_busy_cnt=0;
7207  12e5 3f77          	clr	_tx_busy_cnt
7208                     ; 1922 		bTX_FREE=1;
7210  12e7 35010003      	mov	_bTX_FREE,#1
7211  12eb               L3223:
7212                     ; 1925 }
7215  12eb 81            	ret
7332                     ; 1951 void can_in_an(void)
7332                     ; 1952 {
7333                     	switch	.text
7334  12ec               _can_in_an:
7336  12ec 5207          	subw	sp,#7
7337       00000007      OFST:	set	7
7340                     ; 1962 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7342  12ee b6d0          	ld	a,_mess+6
7343  12f0 c10101        	cp	a,_adress
7344  12f3 2703          	jreq	L461
7345  12f5 cc1454        	jp	L3623
7346  12f8               L461:
7348  12f8 b6d1          	ld	a,_mess+7
7349  12fa c10101        	cp	a,_adress
7350  12fd 2703          	jreq	L661
7351  12ff cc1454        	jp	L3623
7352  1302               L661:
7354  1302 b6d2          	ld	a,_mess+8
7355  1304 a1ed          	cp	a,#237
7356  1306 2703          	jreq	L071
7357  1308 cc1454        	jp	L3623
7358  130b               L071:
7359                     ; 1965 	can_error_cnt=0;
7361  130b 3f76          	clr	_can_error_cnt
7362                     ; 1967 	bMAIN=0;
7364  130d 72110001      	bres	_bMAIN
7365                     ; 1968  	flags_tu=mess[9];
7367  1311 45d36d        	mov	_flags_tu,_mess+9
7368                     ; 1969  	if(flags_tu&0b00000001)
7370  1314 b66d          	ld	a,_flags_tu
7371  1316 a501          	bcp	a,#1
7372  1318 2706          	jreq	L5623
7373                     ; 1974  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7375  131a 721a0005      	bset	_flags,#5
7377  131e 2008          	jra	L7623
7378  1320               L5623:
7379                     ; 1985  				flags&=0b11011111; 
7381  1320 721b0005      	bres	_flags,#5
7382                     ; 1986  				off_bp_cnt=5*EE_TZAS;
7384  1324 350f0060      	mov	_off_bp_cnt,#15
7385  1328               L7623:
7386                     ; 1992  	if(flags_tu&0b00000010) flags|=0b01000000;
7388  1328 b66d          	ld	a,_flags_tu
7389  132a a502          	bcp	a,#2
7390  132c 2706          	jreq	L1723
7393  132e 721c0005      	bset	_flags,#6
7395  1332 2004          	jra	L3723
7396  1334               L1723:
7397                     ; 1993  	else flags&=0b10111111; 
7399  1334 721d0005      	bres	_flags,#6
7400  1338               L3723:
7401                     ; 1995  	U_out_const=mess[10]+mess[11]*256;
7403  1338 b6d5          	ld	a,_mess+11
7404  133a 5f            	clrw	x
7405  133b 97            	ld	xl,a
7406  133c 4f            	clr	a
7407  133d 02            	rlwa	x,a
7408  133e 01            	rrwa	x,a
7409  133f bbd4          	add	a,_mess+10
7410  1341 2401          	jrnc	L051
7411  1343 5c            	incw	x
7412  1344               L051:
7413  1344 c70013        	ld	_U_out_const+1,a
7414  1347 9f            	ld	a,xl
7415  1348 c70012        	ld	_U_out_const,a
7416                     ; 1996  	vol_i_temp=mess[12]+mess[13]*256;
7418  134b b6d7          	ld	a,_mess+13
7419  134d 5f            	clrw	x
7420  134e 97            	ld	xl,a
7421  134f 4f            	clr	a
7422  1350 02            	rlwa	x,a
7423  1351 01            	rrwa	x,a
7424  1352 bbd6          	add	a,_mess+12
7425  1354 2401          	jrnc	L251
7426  1356 5c            	incw	x
7427  1357               L251:
7428  1357 b764          	ld	_vol_i_temp+1,a
7429  1359 9f            	ld	a,xl
7430  135a b763          	ld	_vol_i_temp,a
7431                     ; 1997 	if(vol_i_temp>20)vol_i_temp=20;
7433  135c 9c            	rvf
7434  135d be63          	ldw	x,_vol_i_temp
7435  135f a30015        	cpw	x,#21
7436  1362 2f05          	jrslt	L5723
7439  1364 ae0014        	ldw	x,#20
7440  1367 bf63          	ldw	_vol_i_temp,x
7441  1369               L5723:
7442                     ; 1998  	if(vol_i_temp<-20)vol_i_temp=-20;
7444  1369 9c            	rvf
7445  136a be63          	ldw	x,_vol_i_temp
7446  136c a3ffec        	cpw	x,#65516
7447  136f 2e05          	jrsge	L7723
7450  1371 aeffec        	ldw	x,#65516
7451  1374 bf63          	ldw	_vol_i_temp,x
7452  1376               L7723:
7453                     ; 2008 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7455  1376 b608          	ld	a,_vent_resurs_tx_cnt
7456  1378 a102          	cp	a,#2
7457  137a 2507          	jrult	L1033
7460  137c ce0000        	ldw	x,_vent_resurs
7461  137f bf42          	ldw	_plazma_int+4,x
7463  1381 2004          	jra	L3033
7464  1383               L1033:
7465                     ; 2009 	else plazma_int[2]=vent_resurs_sec_cnt;
7467  1383 be09          	ldw	x,_vent_resurs_sec_cnt
7468  1385 bf42          	ldw	_plazma_int+4,x
7469  1387               L3033:
7470                     ; 2010  	rotor_int=flags_tu+(((short)flags)<<8);
7472  1387 b605          	ld	a,_flags
7473  1389 5f            	clrw	x
7474  138a 97            	ld	xl,a
7475  138b 4f            	clr	a
7476  138c 02            	rlwa	x,a
7477  138d 01            	rrwa	x,a
7478  138e bb6d          	add	a,_flags_tu
7479  1390 2401          	jrnc	L451
7480  1392 5c            	incw	x
7481  1393               L451:
7482  1393 b718          	ld	_rotor_int+1,a
7483  1395 9f            	ld	a,xl
7484  1396 b717          	ld	_rotor_int,a
7485                     ; 2012 	debug_info_to_uku[0]=pwm_u;
7487  1398 be08          	ldw	x,_pwm_u
7488  139a bf01          	ldw	_debug_info_to_uku,x
7489                     ; 2013 	debug_info_to_uku[1]=Udelt;//Ufade;//Usum;
7491  139c ce000c        	ldw	x,_Udelt
7492  139f bf03          	ldw	_debug_info_to_uku+2,x
7493                     ; 2014 	debug_info_to_uku[2]=vol_i_temp;//pwm_u;
7495  13a1 be63          	ldw	x,_vol_i_temp
7496  13a3 bf05          	ldw	_debug_info_to_uku+4,x
7497                     ; 2017 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7499  13a5 3b0016        	push	_Ui
7500  13a8 3b0017        	push	_Ui+1
7501  13ab 3b0018        	push	_Un
7502  13ae 3b0019        	push	_Un+1
7503  13b1 3b001a        	push	_I
7504  13b4 3b001b        	push	_I+1
7505  13b7 4bda          	push	#218
7506  13b9 3b0101        	push	_adress
7507  13bc ae018e        	ldw	x,#398
7508  13bf cd11fe        	call	_can_transmit
7510  13c2 5b08          	addw	sp,#8
7511                     ; 2018 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7513  13c4 3b0010        	push	_Usum
7514  13c7 3b0011        	push	_Usum+1
7515  13ca 3b006c        	push	__x_+1
7516  13cd 3b0005        	push	_flags
7517  13d0 b608          	ld	a,_vent_resurs_tx_cnt
7518  13d2 5f            	clrw	x
7519  13d3 97            	ld	xl,a
7520  13d4 d60000        	ld	a,(_vent_resurs_buff,x)
7521  13d7 88            	push	a
7522  13d8 3b0075        	push	_T
7523  13db 4bdb          	push	#219
7524  13dd 3b0101        	push	_adress
7525  13e0 ae018e        	ldw	x,#398
7526  13e3 cd11fe        	call	_can_transmit
7528  13e6 5b08          	addw	sp,#8
7529                     ; 2019 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7531  13e8 3b0005        	push	_debug_info_to_uku+4
7532  13eb 3b0006        	push	_debug_info_to_uku+5
7533  13ee 3b0003        	push	_debug_info_to_uku+2
7534  13f1 3b0004        	push	_debug_info_to_uku+3
7535  13f4 3b0001        	push	_debug_info_to_uku
7536  13f7 3b0002        	push	_debug_info_to_uku+1
7537  13fa 4bdc          	push	#220
7538  13fc 3b0101        	push	_adress
7539  13ff ae018e        	ldw	x,#398
7540  1402 cd11fe        	call	_can_transmit
7542  1405 5b08          	addw	sp,#8
7543                     ; 2020      link_cnt=0;
7545  1407 5f            	clrw	x
7546  1408 bf6e          	ldw	_link_cnt,x
7547                     ; 2021      link=ON;
7549  140a 35550070      	mov	_link,#85
7550                     ; 2023      if(flags_tu&0b10000000)
7552  140e b66d          	ld	a,_flags_tu
7553  1410 a580          	bcp	a,#128
7554  1412 2716          	jreq	L5033
7555                     ; 2025      	if(!res_fl)
7557  1414 725d000b      	tnz	_res_fl
7558  1418 2626          	jrne	L1133
7559                     ; 2027      		res_fl=1;
7561  141a a601          	ld	a,#1
7562  141c ae000b        	ldw	x,#_res_fl
7563  141f cd0000        	call	c_eewrc
7565                     ; 2028      		bRES=1;
7567  1422 3501000c      	mov	_bRES,#1
7568                     ; 2029      		res_fl_cnt=0;
7570  1426 3f4c          	clr	_res_fl_cnt
7571  1428 2016          	jra	L1133
7572  142a               L5033:
7573                     ; 2034      	if(main_cnt>20)
7575  142a 9c            	rvf
7576  142b ce025f        	ldw	x,_main_cnt
7577  142e a30015        	cpw	x,#21
7578  1431 2f0d          	jrslt	L1133
7579                     ; 2036     			if(res_fl)
7581  1433 725d000b      	tnz	_res_fl
7582  1437 2707          	jreq	L1133
7583                     ; 2038      			res_fl=0;
7585  1439 4f            	clr	a
7586  143a ae000b        	ldw	x,#_res_fl
7587  143d cd0000        	call	c_eewrc
7589  1440               L1133:
7590                     ; 2043       if(res_fl_)
7592  1440 725d000a      	tnz	_res_fl_
7593  1444 2603          	jrne	L271
7594  1446 cc19b5        	jp	L7223
7595  1449               L271:
7596                     ; 2045       	res_fl_=0;
7598  1449 4f            	clr	a
7599  144a ae000a        	ldw	x,#_res_fl_
7600  144d cd0000        	call	c_eewrc
7602  1450 acb519b5      	jpf	L7223
7603  1454               L3623:
7604                     ; 2048 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7606  1454 b6d0          	ld	a,_mess+6
7607  1456 c10101        	cp	a,_adress
7608  1459 2703          	jreq	L471
7609  145b cc16d1        	jp	L3233
7610  145e               L471:
7612  145e b6d1          	ld	a,_mess+7
7613  1460 c10101        	cp	a,_adress
7614  1463 2703          	jreq	L671
7615  1465 cc16d1        	jp	L3233
7616  1468               L671:
7618  1468 b6d2          	ld	a,_mess+8
7619  146a a1ee          	cp	a,#238
7620  146c 2703          	jreq	L002
7621  146e cc16d1        	jp	L3233
7622  1471               L002:
7624  1471 b6d3          	ld	a,_mess+9
7625  1473 b1d4          	cp	a,_mess+10
7626  1475 2703          	jreq	L202
7627  1477 cc16d1        	jp	L3233
7628  147a               L202:
7629                     ; 2050 	rotor_int++;
7631  147a be17          	ldw	x,_rotor_int
7632  147c 1c0001        	addw	x,#1
7633  147f bf17          	ldw	_rotor_int,x
7634                     ; 2051 	if((mess[9]&0xf0)==0x20)
7636  1481 b6d3          	ld	a,_mess+9
7637  1483 a4f0          	and	a,#240
7638  1485 a120          	cp	a,#32
7639  1487 2673          	jrne	L5233
7640                     ; 2053 		if((mess[9]&0x0f)==0x01)
7642  1489 b6d3          	ld	a,_mess+9
7643  148b a40f          	and	a,#15
7644  148d a101          	cp	a,#1
7645  148f 260d          	jrne	L7233
7646                     ; 2055 			ee_K[0][0]=adc_buff_[4];
7648  1491 ce0111        	ldw	x,_adc_buff_+8
7649  1494 89            	pushw	x
7650  1495 ae001a        	ldw	x,#_ee_K
7651  1498 cd0000        	call	c_eewrw
7653  149b 85            	popw	x
7655  149c 204a          	jra	L1333
7656  149e               L7233:
7657                     ; 2057 		else if((mess[9]&0x0f)==0x02)
7659  149e b6d3          	ld	a,_mess+9
7660  14a0 a40f          	and	a,#15
7661  14a2 a102          	cp	a,#2
7662  14a4 260b          	jrne	L3333
7663                     ; 2059 			ee_K[0][1]++;
7665  14a6 ce001c        	ldw	x,_ee_K+2
7666  14a9 1c0001        	addw	x,#1
7667  14ac cf001c        	ldw	_ee_K+2,x
7669  14af 2037          	jra	L1333
7670  14b1               L3333:
7671                     ; 2061 		else if((mess[9]&0x0f)==0x03)
7673  14b1 b6d3          	ld	a,_mess+9
7674  14b3 a40f          	and	a,#15
7675  14b5 a103          	cp	a,#3
7676  14b7 260b          	jrne	L7333
7677                     ; 2063 			ee_K[0][1]+=10;
7679  14b9 ce001c        	ldw	x,_ee_K+2
7680  14bc 1c000a        	addw	x,#10
7681  14bf cf001c        	ldw	_ee_K+2,x
7683  14c2 2024          	jra	L1333
7684  14c4               L7333:
7685                     ; 2065 		else if((mess[9]&0x0f)==0x04)
7687  14c4 b6d3          	ld	a,_mess+9
7688  14c6 a40f          	and	a,#15
7689  14c8 a104          	cp	a,#4
7690  14ca 260b          	jrne	L3433
7691                     ; 2067 			ee_K[0][1]--;
7693  14cc ce001c        	ldw	x,_ee_K+2
7694  14cf 1d0001        	subw	x,#1
7695  14d2 cf001c        	ldw	_ee_K+2,x
7697  14d5 2011          	jra	L1333
7698  14d7               L3433:
7699                     ; 2069 		else if((mess[9]&0x0f)==0x05)
7701  14d7 b6d3          	ld	a,_mess+9
7702  14d9 a40f          	and	a,#15
7703  14db a105          	cp	a,#5
7704  14dd 2609          	jrne	L1333
7705                     ; 2071 			ee_K[0][1]-=10;
7707  14df ce001c        	ldw	x,_ee_K+2
7708  14e2 1d000a        	subw	x,#10
7709  14e5 cf001c        	ldw	_ee_K+2,x
7710  14e8               L1333:
7711                     ; 2073 		granee(&ee_K[0][1],50,3000);									
7713  14e8 ae0bb8        	ldw	x,#3000
7714  14eb 89            	pushw	x
7715  14ec ae0032        	ldw	x,#50
7716  14ef 89            	pushw	x
7717  14f0 ae001c        	ldw	x,#_ee_K+2
7718  14f3 cd00f6        	call	_granee
7720  14f6 5b04          	addw	sp,#4
7722  14f8 acb616b6      	jpf	L1533
7723  14fc               L5233:
7724                     ; 2075 	else if((mess[9]&0xf0)==0x10)
7726  14fc b6d3          	ld	a,_mess+9
7727  14fe a4f0          	and	a,#240
7728  1500 a110          	cp	a,#16
7729  1502 2673          	jrne	L3533
7730                     ; 2077 		if((mess[9]&0x0f)==0x01)
7732  1504 b6d3          	ld	a,_mess+9
7733  1506 a40f          	and	a,#15
7734  1508 a101          	cp	a,#1
7735  150a 260d          	jrne	L5533
7736                     ; 2079 			ee_K[1][0]=adc_buff_[1];
7738  150c ce010b        	ldw	x,_adc_buff_+2
7739  150f 89            	pushw	x
7740  1510 ae001e        	ldw	x,#_ee_K+4
7741  1513 cd0000        	call	c_eewrw
7743  1516 85            	popw	x
7745  1517 204a          	jra	L7533
7746  1519               L5533:
7747                     ; 2081 		else if((mess[9]&0x0f)==0x02)
7749  1519 b6d3          	ld	a,_mess+9
7750  151b a40f          	and	a,#15
7751  151d a102          	cp	a,#2
7752  151f 260b          	jrne	L1633
7753                     ; 2083 			ee_K[1][1]++;
7755  1521 ce0020        	ldw	x,_ee_K+6
7756  1524 1c0001        	addw	x,#1
7757  1527 cf0020        	ldw	_ee_K+6,x
7759  152a 2037          	jra	L7533
7760  152c               L1633:
7761                     ; 2085 		else if((mess[9]&0x0f)==0x03)
7763  152c b6d3          	ld	a,_mess+9
7764  152e a40f          	and	a,#15
7765  1530 a103          	cp	a,#3
7766  1532 260b          	jrne	L5633
7767                     ; 2087 			ee_K[1][1]+=10;
7769  1534 ce0020        	ldw	x,_ee_K+6
7770  1537 1c000a        	addw	x,#10
7771  153a cf0020        	ldw	_ee_K+6,x
7773  153d 2024          	jra	L7533
7774  153f               L5633:
7775                     ; 2089 		else if((mess[9]&0x0f)==0x04)
7777  153f b6d3          	ld	a,_mess+9
7778  1541 a40f          	and	a,#15
7779  1543 a104          	cp	a,#4
7780  1545 260b          	jrne	L1733
7781                     ; 2091 			ee_K[1][1]--;
7783  1547 ce0020        	ldw	x,_ee_K+6
7784  154a 1d0001        	subw	x,#1
7785  154d cf0020        	ldw	_ee_K+6,x
7787  1550 2011          	jra	L7533
7788  1552               L1733:
7789                     ; 2093 		else if((mess[9]&0x0f)==0x05)
7791  1552 b6d3          	ld	a,_mess+9
7792  1554 a40f          	and	a,#15
7793  1556 a105          	cp	a,#5
7794  1558 2609          	jrne	L7533
7795                     ; 2095 			ee_K[1][1]-=10;
7797  155a ce0020        	ldw	x,_ee_K+6
7798  155d 1d000a        	subw	x,#10
7799  1560 cf0020        	ldw	_ee_K+6,x
7800  1563               L7533:
7801                     ; 2100 		granee(&ee_K[1][1],10,30000);
7803  1563 ae7530        	ldw	x,#30000
7804  1566 89            	pushw	x
7805  1567 ae000a        	ldw	x,#10
7806  156a 89            	pushw	x
7807  156b ae0020        	ldw	x,#_ee_K+6
7808  156e cd00f6        	call	_granee
7810  1571 5b04          	addw	sp,#4
7812  1573 acb616b6      	jpf	L1533
7813  1577               L3533:
7814                     ; 2104 	else if((mess[9]&0xf0)==0x00)
7816  1577 b6d3          	ld	a,_mess+9
7817  1579 a5f0          	bcp	a,#240
7818  157b 2673          	jrne	L1043
7819                     ; 2106 		if((mess[9]&0x0f)==0x01)
7821  157d b6d3          	ld	a,_mess+9
7822  157f a40f          	and	a,#15
7823  1581 a101          	cp	a,#1
7824  1583 260d          	jrne	L3043
7825                     ; 2108 			ee_K[2][0]=adc_buff_[2];
7827  1585 ce010d        	ldw	x,_adc_buff_+4
7828  1588 89            	pushw	x
7829  1589 ae0022        	ldw	x,#_ee_K+8
7830  158c cd0000        	call	c_eewrw
7832  158f 85            	popw	x
7834  1590 204a          	jra	L5043
7835  1592               L3043:
7836                     ; 2110 		else if((mess[9]&0x0f)==0x02)
7838  1592 b6d3          	ld	a,_mess+9
7839  1594 a40f          	and	a,#15
7840  1596 a102          	cp	a,#2
7841  1598 260b          	jrne	L7043
7842                     ; 2112 			ee_K[2][1]++;
7844  159a ce0024        	ldw	x,_ee_K+10
7845  159d 1c0001        	addw	x,#1
7846  15a0 cf0024        	ldw	_ee_K+10,x
7848  15a3 2037          	jra	L5043
7849  15a5               L7043:
7850                     ; 2114 		else if((mess[9]&0x0f)==0x03)
7852  15a5 b6d3          	ld	a,_mess+9
7853  15a7 a40f          	and	a,#15
7854  15a9 a103          	cp	a,#3
7855  15ab 260b          	jrne	L3143
7856                     ; 2116 			ee_K[2][1]+=10;
7858  15ad ce0024        	ldw	x,_ee_K+10
7859  15b0 1c000a        	addw	x,#10
7860  15b3 cf0024        	ldw	_ee_K+10,x
7862  15b6 2024          	jra	L5043
7863  15b8               L3143:
7864                     ; 2118 		else if((mess[9]&0x0f)==0x04)
7866  15b8 b6d3          	ld	a,_mess+9
7867  15ba a40f          	and	a,#15
7868  15bc a104          	cp	a,#4
7869  15be 260b          	jrne	L7143
7870                     ; 2120 			ee_K[2][1]--;
7872  15c0 ce0024        	ldw	x,_ee_K+10
7873  15c3 1d0001        	subw	x,#1
7874  15c6 cf0024        	ldw	_ee_K+10,x
7876  15c9 2011          	jra	L5043
7877  15cb               L7143:
7878                     ; 2122 		else if((mess[9]&0x0f)==0x05)
7880  15cb b6d3          	ld	a,_mess+9
7881  15cd a40f          	and	a,#15
7882  15cf a105          	cp	a,#5
7883  15d1 2609          	jrne	L5043
7884                     ; 2124 			ee_K[2][1]-=10;
7886  15d3 ce0024        	ldw	x,_ee_K+10
7887  15d6 1d000a        	subw	x,#10
7888  15d9 cf0024        	ldw	_ee_K+10,x
7889  15dc               L5043:
7890                     ; 2129 		granee(&ee_K[2][1],10,30000);
7892  15dc ae7530        	ldw	x,#30000
7893  15df 89            	pushw	x
7894  15e0 ae000a        	ldw	x,#10
7895  15e3 89            	pushw	x
7896  15e4 ae0024        	ldw	x,#_ee_K+10
7897  15e7 cd00f6        	call	_granee
7899  15ea 5b04          	addw	sp,#4
7901  15ec acb616b6      	jpf	L1533
7902  15f0               L1043:
7903                     ; 2133 	else if((mess[9]&0xf0)==0x30)
7905  15f0 b6d3          	ld	a,_mess+9
7906  15f2 a4f0          	and	a,#240
7907  15f4 a130          	cp	a,#48
7908  15f6 265c          	jrne	L7243
7909                     ; 2135 		if((mess[9]&0x0f)==0x02)
7911  15f8 b6d3          	ld	a,_mess+9
7912  15fa a40f          	and	a,#15
7913  15fc a102          	cp	a,#2
7914  15fe 260b          	jrne	L1343
7915                     ; 2137 			ee_K[3][1]++;
7917  1600 ce0028        	ldw	x,_ee_K+14
7918  1603 1c0001        	addw	x,#1
7919  1606 cf0028        	ldw	_ee_K+14,x
7921  1609 2037          	jra	L3343
7922  160b               L1343:
7923                     ; 2139 		else if((mess[9]&0x0f)==0x03)
7925  160b b6d3          	ld	a,_mess+9
7926  160d a40f          	and	a,#15
7927  160f a103          	cp	a,#3
7928  1611 260b          	jrne	L5343
7929                     ; 2141 			ee_K[3][1]+=10;
7931  1613 ce0028        	ldw	x,_ee_K+14
7932  1616 1c000a        	addw	x,#10
7933  1619 cf0028        	ldw	_ee_K+14,x
7935  161c 2024          	jra	L3343
7936  161e               L5343:
7937                     ; 2143 		else if((mess[9]&0x0f)==0x04)
7939  161e b6d3          	ld	a,_mess+9
7940  1620 a40f          	and	a,#15
7941  1622 a104          	cp	a,#4
7942  1624 260b          	jrne	L1443
7943                     ; 2145 			ee_K[3][1]--;
7945  1626 ce0028        	ldw	x,_ee_K+14
7946  1629 1d0001        	subw	x,#1
7947  162c cf0028        	ldw	_ee_K+14,x
7949  162f 2011          	jra	L3343
7950  1631               L1443:
7951                     ; 2147 		else if((mess[9]&0x0f)==0x05)
7953  1631 b6d3          	ld	a,_mess+9
7954  1633 a40f          	and	a,#15
7955  1635 a105          	cp	a,#5
7956  1637 2609          	jrne	L3343
7957                     ; 2149 			ee_K[3][1]-=10;
7959  1639 ce0028        	ldw	x,_ee_K+14
7960  163c 1d000a        	subw	x,#10
7961  163f cf0028        	ldw	_ee_K+14,x
7962  1642               L3343:
7963                     ; 2151 		granee(&ee_K[3][1],300,517);									
7965  1642 ae0205        	ldw	x,#517
7966  1645 89            	pushw	x
7967  1646 ae012c        	ldw	x,#300
7968  1649 89            	pushw	x
7969  164a ae0028        	ldw	x,#_ee_K+14
7970  164d cd00f6        	call	_granee
7972  1650 5b04          	addw	sp,#4
7974  1652 2062          	jra	L1533
7975  1654               L7243:
7976                     ; 2154 	else if((mess[9]&0xf0)==0x50)
7978  1654 b6d3          	ld	a,_mess+9
7979  1656 a4f0          	and	a,#240
7980  1658 a150          	cp	a,#80
7981  165a 265a          	jrne	L1533
7982                     ; 2156 		if((mess[9]&0x0f)==0x02)
7984  165c b6d3          	ld	a,_mess+9
7985  165e a40f          	and	a,#15
7986  1660 a102          	cp	a,#2
7987  1662 260b          	jrne	L3543
7988                     ; 2158 			ee_K[4][1]++;
7990  1664 ce002c        	ldw	x,_ee_K+18
7991  1667 1c0001        	addw	x,#1
7992  166a cf002c        	ldw	_ee_K+18,x
7994  166d 2037          	jra	L5543
7995  166f               L3543:
7996                     ; 2160 		else if((mess[9]&0x0f)==0x03)
7998  166f b6d3          	ld	a,_mess+9
7999  1671 a40f          	and	a,#15
8000  1673 a103          	cp	a,#3
8001  1675 260b          	jrne	L7543
8002                     ; 2162 			ee_K[4][1]+=10;
8004  1677 ce002c        	ldw	x,_ee_K+18
8005  167a 1c000a        	addw	x,#10
8006  167d cf002c        	ldw	_ee_K+18,x
8008  1680 2024          	jra	L5543
8009  1682               L7543:
8010                     ; 2164 		else if((mess[9]&0x0f)==0x04)
8012  1682 b6d3          	ld	a,_mess+9
8013  1684 a40f          	and	a,#15
8014  1686 a104          	cp	a,#4
8015  1688 260b          	jrne	L3643
8016                     ; 2166 			ee_K[4][1]--;
8018  168a ce002c        	ldw	x,_ee_K+18
8019  168d 1d0001        	subw	x,#1
8020  1690 cf002c        	ldw	_ee_K+18,x
8022  1693 2011          	jra	L5543
8023  1695               L3643:
8024                     ; 2168 		else if((mess[9]&0x0f)==0x05)
8026  1695 b6d3          	ld	a,_mess+9
8027  1697 a40f          	and	a,#15
8028  1699 a105          	cp	a,#5
8029  169b 2609          	jrne	L5543
8030                     ; 2170 			ee_K[4][1]-=10;
8032  169d ce002c        	ldw	x,_ee_K+18
8033  16a0 1d000a        	subw	x,#10
8034  16a3 cf002c        	ldw	_ee_K+18,x
8035  16a6               L5543:
8036                     ; 2172 		granee(&ee_K[4][1],10,30000);									
8038  16a6 ae7530        	ldw	x,#30000
8039  16a9 89            	pushw	x
8040  16aa ae000a        	ldw	x,#10
8041  16ad 89            	pushw	x
8042  16ae ae002c        	ldw	x,#_ee_K+18
8043  16b1 cd00f6        	call	_granee
8045  16b4 5b04          	addw	sp,#4
8046  16b6               L1533:
8047                     ; 2175 	link_cnt=0;
8049  16b6 5f            	clrw	x
8050  16b7 bf6e          	ldw	_link_cnt,x
8051                     ; 2176      link=ON;
8053  16b9 35550070      	mov	_link,#85
8054                     ; 2177      if(res_fl_)
8056  16bd 725d000a      	tnz	_res_fl_
8057  16c1 2603          	jrne	L402
8058  16c3 cc19b5        	jp	L7223
8059  16c6               L402:
8060                     ; 2179       	res_fl_=0;
8062  16c6 4f            	clr	a
8063  16c7 ae000a        	ldw	x,#_res_fl_
8064  16ca cd0000        	call	c_eewrc
8066  16cd acb519b5      	jpf	L7223
8067  16d1               L3233:
8068                     ; 2185 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8070  16d1 b6d0          	ld	a,_mess+6
8071  16d3 a1ff          	cp	a,#255
8072  16d5 2703          	jreq	L602
8073  16d7 cc175f        	jp	L5743
8074  16da               L602:
8076  16da b6d1          	ld	a,_mess+7
8077  16dc a1ff          	cp	a,#255
8078  16de 2702          	jreq	L012
8079  16e0 207d          	jp	L5743
8080  16e2               L012:
8082  16e2 b6d2          	ld	a,_mess+8
8083  16e4 a162          	cp	a,#98
8084  16e6 2677          	jrne	L5743
8085                     ; 2188 	tempSS=mess[9]+(mess[10]*256);
8087  16e8 b6d4          	ld	a,_mess+10
8088  16ea 5f            	clrw	x
8089  16eb 97            	ld	xl,a
8090  16ec 4f            	clr	a
8091  16ed 02            	rlwa	x,a
8092  16ee 01            	rrwa	x,a
8093  16ef bbd3          	add	a,_mess+9
8094  16f1 2401          	jrnc	L651
8095  16f3 5c            	incw	x
8096  16f4               L651:
8097  16f4 02            	rlwa	x,a
8098  16f5 1f03          	ldw	(OFST-4,sp),x
8099  16f7 01            	rrwa	x,a
8100                     ; 2189 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8102  16f8 ce0014        	ldw	x,_ee_Umax
8103  16fb 1303          	cpw	x,(OFST-4,sp)
8104  16fd 270a          	jreq	L7743
8107  16ff 1e03          	ldw	x,(OFST-4,sp)
8108  1701 89            	pushw	x
8109  1702 ae0014        	ldw	x,#_ee_Umax
8110  1705 cd0000        	call	c_eewrw
8112  1708 85            	popw	x
8113  1709               L7743:
8114                     ; 2190 	tempSS=mess[11]+(mess[12]*256);
8116  1709 b6d6          	ld	a,_mess+12
8117  170b 5f            	clrw	x
8118  170c 97            	ld	xl,a
8119  170d 4f            	clr	a
8120  170e 02            	rlwa	x,a
8121  170f 01            	rrwa	x,a
8122  1710 bbd5          	add	a,_mess+11
8123  1712 2401          	jrnc	L061
8124  1714 5c            	incw	x
8125  1715               L061:
8126  1715 02            	rlwa	x,a
8127  1716 1f03          	ldw	(OFST-4,sp),x
8128  1718 01            	rrwa	x,a
8129                     ; 2191 	if(ee_dU!=tempSS) ee_dU=tempSS;
8131  1719 ce0012        	ldw	x,_ee_dU
8132  171c 1303          	cpw	x,(OFST-4,sp)
8133  171e 270a          	jreq	L1053
8136  1720 1e03          	ldw	x,(OFST-4,sp)
8137  1722 89            	pushw	x
8138  1723 ae0012        	ldw	x,#_ee_dU
8139  1726 cd0000        	call	c_eewrw
8141  1729 85            	popw	x
8142  172a               L1053:
8143                     ; 2192 	if((mess[13]&0x0f)==0x5)
8145  172a b6d7          	ld	a,_mess+13
8146  172c a40f          	and	a,#15
8147  172e a105          	cp	a,#5
8148  1730 2615          	jrne	L3053
8149                     ; 2194 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8151  1732 ce0006        	ldw	x,_ee_AVT_MODE
8152  1735 a30055        	cpw	x,#85
8153  1738 271e          	jreq	L7053
8156  173a ae0055        	ldw	x,#85
8157  173d 89            	pushw	x
8158  173e ae0006        	ldw	x,#_ee_AVT_MODE
8159  1741 cd0000        	call	c_eewrw
8161  1744 85            	popw	x
8162  1745 2011          	jra	L7053
8163  1747               L3053:
8164                     ; 2196 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;
8166  1747 ce0006        	ldw	x,_ee_AVT_MODE
8167  174a a30055        	cpw	x,#85
8168  174d 2609          	jrne	L7053
8171  174f 5f            	clrw	x
8172  1750 89            	pushw	x
8173  1751 ae0006        	ldw	x,#_ee_AVT_MODE
8174  1754 cd0000        	call	c_eewrw
8176  1757 85            	popw	x
8177  1758               L7053:
8178                     ; 2197 	FADE_MODE=mess[13];	
8180  1758 45d713        	mov	_FADE_MODE,_mess+13
8182  175b acb519b5      	jpf	L7223
8183  175f               L5743:
8184                     ; 2200 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8186  175f b6d0          	ld	a,_mess+6
8187  1761 a1ff          	cp	a,#255
8188  1763 2703          	jreq	L212
8189  1765 cc181b        	jp	L5153
8190  1768               L212:
8192  1768 b6d1          	ld	a,_mess+7
8193  176a a1ff          	cp	a,#255
8194  176c 2703          	jreq	L412
8195  176e cc181b        	jp	L5153
8196  1771               L412:
8198  1771 b6d2          	ld	a,_mess+8
8199  1773 a126          	cp	a,#38
8200  1775 2709          	jreq	L7153
8202  1777 b6d2          	ld	a,_mess+8
8203  1779 a129          	cp	a,#41
8204  177b 2703          	jreq	L612
8205  177d cc181b        	jp	L5153
8206  1780               L612:
8207  1780               L7153:
8208                     ; 2203 	tempSS=mess[9]+(mess[10]*256);
8210  1780 b6d4          	ld	a,_mess+10
8211  1782 5f            	clrw	x
8212  1783 97            	ld	xl,a
8213  1784 4f            	clr	a
8214  1785 02            	rlwa	x,a
8215  1786 01            	rrwa	x,a
8216  1787 bbd3          	add	a,_mess+9
8217  1789 2401          	jrnc	L261
8218  178b 5c            	incw	x
8219  178c               L261:
8220  178c 02            	rlwa	x,a
8221  178d 1f03          	ldw	(OFST-4,sp),x
8222  178f 01            	rrwa	x,a
8223                     ; 2205 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
8225  1790 ce000c        	ldw	x,_ee_UAVT
8226  1793 1303          	cpw	x,(OFST-4,sp)
8227  1795 270a          	jreq	L1253
8230  1797 1e03          	ldw	x,(OFST-4,sp)
8231  1799 89            	pushw	x
8232  179a ae000c        	ldw	x,#_ee_UAVT
8233  179d cd0000        	call	c_eewrw
8235  17a0 85            	popw	x
8236  17a1               L1253:
8237                     ; 2206 	tempSS=(signed short)mess[11];
8239  17a1 b6d5          	ld	a,_mess+11
8240  17a3 5f            	clrw	x
8241  17a4 97            	ld	xl,a
8242  17a5 1f03          	ldw	(OFST-4,sp),x
8243                     ; 2207 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8245  17a7 ce0010        	ldw	x,_ee_tmax
8246  17aa 1303          	cpw	x,(OFST-4,sp)
8247  17ac 270a          	jreq	L3253
8250  17ae 1e03          	ldw	x,(OFST-4,sp)
8251  17b0 89            	pushw	x
8252  17b1 ae0010        	ldw	x,#_ee_tmax
8253  17b4 cd0000        	call	c_eewrw
8255  17b7 85            	popw	x
8256  17b8               L3253:
8257                     ; 2208 	tempSS=(signed short)mess[12];
8259  17b8 b6d6          	ld	a,_mess+12
8260  17ba 5f            	clrw	x
8261  17bb 97            	ld	xl,a
8262  17bc 1f03          	ldw	(OFST-4,sp),x
8263                     ; 2209 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8265  17be ce000e        	ldw	x,_ee_tsign
8266  17c1 1303          	cpw	x,(OFST-4,sp)
8267  17c3 270a          	jreq	L5253
8270  17c5 1e03          	ldw	x,(OFST-4,sp)
8271  17c7 89            	pushw	x
8272  17c8 ae000e        	ldw	x,#_ee_tsign
8273  17cb cd0000        	call	c_eewrw
8275  17ce 85            	popw	x
8276  17cf               L5253:
8277                     ; 2212 	if(mess[8]==MEM_KF1)
8279  17cf b6d2          	ld	a,_mess+8
8280  17d1 a126          	cp	a,#38
8281  17d3 260e          	jrne	L7253
8282                     ; 2214 		if(ee_DEVICE!=0)ee_DEVICE=0;
8284  17d5 ce0004        	ldw	x,_ee_DEVICE
8285  17d8 2709          	jreq	L7253
8288  17da 5f            	clrw	x
8289  17db 89            	pushw	x
8290  17dc ae0004        	ldw	x,#_ee_DEVICE
8291  17df cd0000        	call	c_eewrw
8293  17e2 85            	popw	x
8294  17e3               L7253:
8295                     ; 2217 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8297  17e3 b6d2          	ld	a,_mess+8
8298  17e5 a129          	cp	a,#41
8299  17e7 2703          	jreq	L022
8300  17e9 cc19b5        	jp	L7223
8301  17ec               L022:
8302                     ; 2219 		if(ee_DEVICE!=1)ee_DEVICE=1;
8304  17ec ce0004        	ldw	x,_ee_DEVICE
8305  17ef a30001        	cpw	x,#1
8306  17f2 270b          	jreq	L5353
8309  17f4 ae0001        	ldw	x,#1
8310  17f7 89            	pushw	x
8311  17f8 ae0004        	ldw	x,#_ee_DEVICE
8312  17fb cd0000        	call	c_eewrw
8314  17fe 85            	popw	x
8315  17ff               L5353:
8316                     ; 2220 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8318  17ff b6d7          	ld	a,_mess+13
8319  1801 5f            	clrw	x
8320  1802 97            	ld	xl,a
8321  1803 c30002        	cpw	x,_ee_IMAXVENT
8322  1806 2603          	jrne	L222
8323  1808 cc19b5        	jp	L7223
8324  180b               L222:
8327  180b b6d7          	ld	a,_mess+13
8328  180d 5f            	clrw	x
8329  180e 97            	ld	xl,a
8330  180f 89            	pushw	x
8331  1810 ae0002        	ldw	x,#_ee_IMAXVENT
8332  1813 cd0000        	call	c_eewrw
8334  1816 85            	popw	x
8335  1817 acb519b5      	jpf	L7223
8336  181b               L5153:
8337                     ; 2225 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8339  181b b6d0          	ld	a,_mess+6
8340  181d c10101        	cp	a,_adress
8341  1820 262d          	jrne	L3453
8343  1822 b6d1          	ld	a,_mess+7
8344  1824 c10101        	cp	a,_adress
8345  1827 2626          	jrne	L3453
8347  1829 b6d2          	ld	a,_mess+8
8348  182b a116          	cp	a,#22
8349  182d 2620          	jrne	L3453
8351  182f b6d3          	ld	a,_mess+9
8352  1831 a163          	cp	a,#99
8353  1833 261a          	jrne	L3453
8354                     ; 2227 	flags&=0b11100001;
8356  1835 b605          	ld	a,_flags
8357  1837 a4e1          	and	a,#225
8358  1839 b705          	ld	_flags,a
8359                     ; 2228 	tsign_cnt=0;
8361  183b 5f            	clrw	x
8362  183c bf5c          	ldw	_tsign_cnt,x
8363                     ; 2229 	tmax_cnt=0;
8365  183e 5f            	clrw	x
8366  183f bf5a          	ldw	_tmax_cnt,x
8367                     ; 2230 	umax_cnt=0;
8369  1841 5f            	clrw	x
8370  1842 bf73          	ldw	_umax_cnt,x
8371                     ; 2231 	umin_cnt=0;
8373  1844 5f            	clrw	x
8374  1845 bf71          	ldw	_umin_cnt,x
8375                     ; 2232 	led_drv_cnt=30;
8377  1847 351e0016      	mov	_led_drv_cnt,#30
8379  184b acb519b5      	jpf	L7223
8380  184f               L3453:
8381                     ; 2235 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8383  184f b6d0          	ld	a,_mess+6
8384  1851 c10101        	cp	a,_adress
8385  1854 2620          	jrne	L7453
8387  1856 b6d1          	ld	a,_mess+7
8388  1858 c10101        	cp	a,_adress
8389  185b 2619          	jrne	L7453
8391  185d b6d2          	ld	a,_mess+8
8392  185f a116          	cp	a,#22
8393  1861 2613          	jrne	L7453
8395  1863 b6d3          	ld	a,_mess+9
8396  1865 a164          	cp	a,#100
8397  1867 260d          	jrne	L7453
8398                     ; 2237 	vent_resurs=0;
8400  1869 5f            	clrw	x
8401  186a 89            	pushw	x
8402  186b ae0000        	ldw	x,#_vent_resurs
8403  186e cd0000        	call	c_eewrw
8405  1871 85            	popw	x
8407  1872 acb519b5      	jpf	L7223
8408  1876               L7453:
8409                     ; 2241 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8411  1876 b6d0          	ld	a,_mess+6
8412  1878 a1ff          	cp	a,#255
8413  187a 265f          	jrne	L3553
8415  187c b6d1          	ld	a,_mess+7
8416  187e a1ff          	cp	a,#255
8417  1880 2659          	jrne	L3553
8419  1882 b6d2          	ld	a,_mess+8
8420  1884 a116          	cp	a,#22
8421  1886 2653          	jrne	L3553
8423  1888 b6d3          	ld	a,_mess+9
8424  188a a116          	cp	a,#22
8425  188c 264d          	jrne	L3553
8426                     ; 2243 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8428  188e b6d4          	ld	a,_mess+10
8429  1890 a155          	cp	a,#85
8430  1892 260f          	jrne	L5553
8432  1894 b6d5          	ld	a,_mess+11
8433  1896 a155          	cp	a,#85
8434  1898 2609          	jrne	L5553
8437  189a be6b          	ldw	x,__x_
8438  189c 1c0001        	addw	x,#1
8439  189f bf6b          	ldw	__x_,x
8441  18a1 2024          	jra	L7553
8442  18a3               L5553:
8443                     ; 2244 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8445  18a3 b6d4          	ld	a,_mess+10
8446  18a5 a166          	cp	a,#102
8447  18a7 260f          	jrne	L1653
8449  18a9 b6d5          	ld	a,_mess+11
8450  18ab a166          	cp	a,#102
8451  18ad 2609          	jrne	L1653
8454  18af be6b          	ldw	x,__x_
8455  18b1 1d0001        	subw	x,#1
8456  18b4 bf6b          	ldw	__x_,x
8458  18b6 200f          	jra	L7553
8459  18b8               L1653:
8460                     ; 2245 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8462  18b8 b6d4          	ld	a,_mess+10
8463  18ba a177          	cp	a,#119
8464  18bc 2609          	jrne	L7553
8466  18be b6d5          	ld	a,_mess+11
8467  18c0 a177          	cp	a,#119
8468  18c2 2603          	jrne	L7553
8471  18c4 5f            	clrw	x
8472  18c5 bf6b          	ldw	__x_,x
8473  18c7               L7553:
8474                     ; 2246      gran(&_x_,-XMAX,XMAX);
8476  18c7 ae0019        	ldw	x,#25
8477  18ca 89            	pushw	x
8478  18cb aeffe7        	ldw	x,#65511
8479  18ce 89            	pushw	x
8480  18cf ae006b        	ldw	x,#__x_
8481  18d2 cd00d5        	call	_gran
8483  18d5 5b04          	addw	sp,#4
8485  18d7 acb519b5      	jpf	L7223
8486  18db               L3553:
8487                     ; 2248 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8489  18db b6d0          	ld	a,_mess+6
8490  18dd c10101        	cp	a,_adress
8491  18e0 2635          	jrne	L1753
8493  18e2 b6d1          	ld	a,_mess+7
8494  18e4 c10101        	cp	a,_adress
8495  18e7 262e          	jrne	L1753
8497  18e9 b6d2          	ld	a,_mess+8
8498  18eb a116          	cp	a,#22
8499  18ed 2628          	jrne	L1753
8501  18ef b6d3          	ld	a,_mess+9
8502  18f1 b1d4          	cp	a,_mess+10
8503  18f3 2622          	jrne	L1753
8505  18f5 b6d3          	ld	a,_mess+9
8506  18f7 a1ee          	cp	a,#238
8507  18f9 261c          	jrne	L1753
8508                     ; 2250 	rotor_int++;
8510  18fb be17          	ldw	x,_rotor_int
8511  18fd 1c0001        	addw	x,#1
8512  1900 bf17          	ldw	_rotor_int,x
8513                     ; 2251      tempI=pwm_u;
8515                     ; 2253 	UU_AVT=Un;
8517  1902 ce0018        	ldw	x,_Un
8518  1905 89            	pushw	x
8519  1906 ae0008        	ldw	x,#_UU_AVT
8520  1909 cd0000        	call	c_eewrw
8522  190c 85            	popw	x
8523                     ; 2254 	delay_ms(100);
8525  190d ae0064        	ldw	x,#100
8526  1910 cd0121        	call	_delay_ms
8529  1913 acb519b5      	jpf	L7223
8530  1917               L1753:
8531                     ; 2260 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8533  1917 b6d1          	ld	a,_mess+7
8534  1919 a1da          	cp	a,#218
8535  191b 2653          	jrne	L5753
8537  191d b6d0          	ld	a,_mess+6
8538  191f c10101        	cp	a,_adress
8539  1922 274c          	jreq	L5753
8541  1924 b6d0          	ld	a,_mess+6
8542  1926 a106          	cp	a,#6
8543  1928 2446          	jruge	L5753
8544                     ; 2262 	i_main_bps_cnt[mess[6]]=0;
8546  192a b6d0          	ld	a,_mess+6
8547  192c 5f            	clrw	x
8548  192d 97            	ld	xl,a
8549  192e 6f14          	clr	(_i_main_bps_cnt,x)
8550                     ; 2263 	i_main_flag[mess[6]]=1;
8552  1930 b6d0          	ld	a,_mess+6
8553  1932 5f            	clrw	x
8554  1933 97            	ld	xl,a
8555  1934 a601          	ld	a,#1
8556  1936 e71f          	ld	(_i_main_flag,x),a
8557                     ; 2264 	if(bMAIN)
8559                     	btst	_bMAIN
8560  193d 2476          	jruge	L7223
8561                     ; 2266 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8563  193f b6d3          	ld	a,_mess+9
8564  1941 5f            	clrw	x
8565  1942 97            	ld	xl,a
8566  1943 4f            	clr	a
8567  1944 02            	rlwa	x,a
8568  1945 1f01          	ldw	(OFST-6,sp),x
8569  1947 b6d2          	ld	a,_mess+8
8570  1949 5f            	clrw	x
8571  194a 97            	ld	xl,a
8572  194b 72fb01        	addw	x,(OFST-6,sp)
8573  194e b6d0          	ld	a,_mess+6
8574  1950 905f          	clrw	y
8575  1952 9097          	ld	yl,a
8576  1954 9058          	sllw	y
8577  1956 90ef25        	ldw	(_i_main,y),x
8578                     ; 2267 		i_main[adress]=I;
8580  1959 c60101        	ld	a,_adress
8581  195c 5f            	clrw	x
8582  195d 97            	ld	xl,a
8583  195e 58            	sllw	x
8584  195f 90ce001a      	ldw	y,_I
8585  1963 ef25          	ldw	(_i_main,x),y
8586                     ; 2268      	i_main_flag[adress]=1;
8588  1965 c60101        	ld	a,_adress
8589  1968 5f            	clrw	x
8590  1969 97            	ld	xl,a
8591  196a a601          	ld	a,#1
8592  196c e71f          	ld	(_i_main_flag,x),a
8593  196e 2045          	jra	L7223
8594  1970               L5753:
8595                     ; 2272 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8597  1970 b6d1          	ld	a,_mess+7
8598  1972 a1db          	cp	a,#219
8599  1974 263f          	jrne	L7223
8601  1976 b6d0          	ld	a,_mess+6
8602  1978 c10101        	cp	a,_adress
8603  197b 2738          	jreq	L7223
8605  197d b6d0          	ld	a,_mess+6
8606  197f a106          	cp	a,#6
8607  1981 2432          	jruge	L7223
8608                     ; 2274 	i_main_bps_cnt[mess[6]]=0;
8610  1983 b6d0          	ld	a,_mess+6
8611  1985 5f            	clrw	x
8612  1986 97            	ld	xl,a
8613  1987 6f14          	clr	(_i_main_bps_cnt,x)
8614                     ; 2275 	i_main_flag[mess[6]]=1;		
8616  1989 b6d0          	ld	a,_mess+6
8617  198b 5f            	clrw	x
8618  198c 97            	ld	xl,a
8619  198d a601          	ld	a,#1
8620  198f e71f          	ld	(_i_main_flag,x),a
8621                     ; 2276 	if(bMAIN)
8623                     	btst	_bMAIN
8624  1996 241d          	jruge	L7223
8625                     ; 2278 		if(mess[9]==0)i_main_flag[i]=1;
8627  1998 3dd3          	tnz	_mess+9
8628  199a 260a          	jrne	L7063
8631  199c 7b07          	ld	a,(OFST+0,sp)
8632  199e 5f            	clrw	x
8633  199f 97            	ld	xl,a
8634  19a0 a601          	ld	a,#1
8635  19a2 e71f          	ld	(_i_main_flag,x),a
8637  19a4 2006          	jra	L1163
8638  19a6               L7063:
8639                     ; 2279 		else i_main_flag[i]=0;
8641  19a6 7b07          	ld	a,(OFST+0,sp)
8642  19a8 5f            	clrw	x
8643  19a9 97            	ld	xl,a
8644  19aa 6f1f          	clr	(_i_main_flag,x)
8645  19ac               L1163:
8646                     ; 2280 		i_main_flag[adress]=1;
8648  19ac c60101        	ld	a,_adress
8649  19af 5f            	clrw	x
8650  19b0 97            	ld	xl,a
8651  19b1 a601          	ld	a,#1
8652  19b3 e71f          	ld	(_i_main_flag,x),a
8653  19b5               L7223:
8654                     ; 2286 can_in_an_end:
8654                     ; 2287 bCAN_RX=0;
8656  19b5 3f04          	clr	_bCAN_RX
8657                     ; 2288 }   
8660  19b7 5b07          	addw	sp,#7
8661  19b9 81            	ret
8684                     ; 2291 void t4_init(void){
8685                     	switch	.text
8686  19ba               _t4_init:
8690                     ; 2292 	TIM4->PSCR = 6;
8692  19ba 35065345      	mov	21317,#6
8693                     ; 2293 	TIM4->ARR= 31;
8695  19be 351f5346      	mov	21318,#31
8696                     ; 2294 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8698  19c2 72105341      	bset	21313,#0
8699                     ; 2296 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8701  19c6 35855340      	mov	21312,#133
8702                     ; 2298 }
8705  19ca 81            	ret
8728                     ; 2301 void t1_init(void)
8728                     ; 2302 {
8729                     	switch	.text
8730  19cb               _t1_init:
8734                     ; 2303 TIM1->ARRH= 0x07;
8736  19cb 35075262      	mov	21090,#7
8737                     ; 2304 TIM1->ARRL= 0xff;
8739  19cf 35ff5263      	mov	21091,#255
8740                     ; 2305 TIM1->CCR1H= 0x00;	
8742  19d3 725f5265      	clr	21093
8743                     ; 2306 TIM1->CCR1L= 0xff;
8745  19d7 35ff5266      	mov	21094,#255
8746                     ; 2307 TIM1->CCR2H= 0x00;	
8748  19db 725f5267      	clr	21095
8749                     ; 2308 TIM1->CCR2L= 0x00;
8751  19df 725f5268      	clr	21096
8752                     ; 2309 TIM1->CCR3H= 0x00;	
8754  19e3 725f5269      	clr	21097
8755                     ; 2310 TIM1->CCR3L= 0x64;
8757  19e7 3564526a      	mov	21098,#100
8758                     ; 2312 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8760  19eb 35685258      	mov	21080,#104
8761                     ; 2313 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8763  19ef 35685259      	mov	21081,#104
8764                     ; 2314 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8766  19f3 3568525a      	mov	21082,#104
8767                     ; 2315 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8769  19f7 3511525c      	mov	21084,#17
8770                     ; 2316 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8772  19fb 3501525d      	mov	21085,#1
8773                     ; 2317 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8775  19ff 35815250      	mov	21072,#129
8776                     ; 2318 TIM1->BKR|= TIM1_BKR_AOE;
8778  1a03 721c526d      	bset	21101,#6
8779                     ; 2319 }
8782  1a07 81            	ret
8807                     ; 2323 void adc2_init(void)
8807                     ; 2324 {
8808                     	switch	.text
8809  1a08               _adc2_init:
8813                     ; 2325 adc_plazma[0]++;
8815  1a08 bebc          	ldw	x,_adc_plazma
8816  1a0a 1c0001        	addw	x,#1
8817  1a0d bfbc          	ldw	_adc_plazma,x
8818                     ; 2349 GPIOB->DDR&=~(1<<4);
8820  1a0f 72195007      	bres	20487,#4
8821                     ; 2350 GPIOB->CR1&=~(1<<4);
8823  1a13 72195008      	bres	20488,#4
8824                     ; 2351 GPIOB->CR2&=~(1<<4);
8826  1a17 72195009      	bres	20489,#4
8827                     ; 2353 GPIOB->DDR&=~(1<<5);
8829  1a1b 721b5007      	bres	20487,#5
8830                     ; 2354 GPIOB->CR1&=~(1<<5);
8832  1a1f 721b5008      	bres	20488,#5
8833                     ; 2355 GPIOB->CR2&=~(1<<5);
8835  1a23 721b5009      	bres	20489,#5
8836                     ; 2357 GPIOB->DDR&=~(1<<6);
8838  1a27 721d5007      	bres	20487,#6
8839                     ; 2358 GPIOB->CR1&=~(1<<6);
8841  1a2b 721d5008      	bres	20488,#6
8842                     ; 2359 GPIOB->CR2&=~(1<<6);
8844  1a2f 721d5009      	bres	20489,#6
8845                     ; 2361 GPIOB->DDR&=~(1<<7);
8847  1a33 721f5007      	bres	20487,#7
8848                     ; 2362 GPIOB->CR1&=~(1<<7);
8850  1a37 721f5008      	bres	20488,#7
8851                     ; 2363 GPIOB->CR2&=~(1<<7);
8853  1a3b 721f5009      	bres	20489,#7
8854                     ; 2365 GPIOB->DDR&=~(1<<2);
8856  1a3f 72155007      	bres	20487,#2
8857                     ; 2366 GPIOB->CR1&=~(1<<2);
8859  1a43 72155008      	bres	20488,#2
8860                     ; 2367 GPIOB->CR2&=~(1<<2);
8862  1a47 72155009      	bres	20489,#2
8863                     ; 2376 ADC2->TDRL=0xff;
8865  1a4b 35ff5407      	mov	21511,#255
8866                     ; 2378 ADC2->CR2=0x08;
8868  1a4f 35085402      	mov	21506,#8
8869                     ; 2379 ADC2->CR1=0x60;
8871  1a53 35605401      	mov	21505,#96
8872                     ; 2382 	if(adc_ch==5)ADC2->CSR=0x22;
8874  1a57 b6c9          	ld	a,_adc_ch
8875  1a59 a105          	cp	a,#5
8876  1a5b 2606          	jrne	L3463
8879  1a5d 35225400      	mov	21504,#34
8881  1a61 2007          	jra	L5463
8882  1a63               L3463:
8883                     ; 2383 	else ADC2->CSR=0x20+adc_ch+3;
8885  1a63 b6c9          	ld	a,_adc_ch
8886  1a65 ab23          	add	a,#35
8887  1a67 c75400        	ld	21504,a
8888  1a6a               L5463:
8889                     ; 2385 	ADC2->CR1|=1;
8891  1a6a 72105401      	bset	21505,#0
8892                     ; 2386 	ADC2->CR1|=1;
8894  1a6e 72105401      	bset	21505,#0
8895                     ; 2389 adc_plazma[1]=adc_ch;
8897  1a72 b6c9          	ld	a,_adc_ch
8898  1a74 5f            	clrw	x
8899  1a75 97            	ld	xl,a
8900  1a76 bfbe          	ldw	_adc_plazma+2,x
8901                     ; 2390 }
8904  1a78 81            	ret
8942                     ; 2398 @far @interrupt void TIM4_UPD_Interrupt (void) 
8942                     ; 2399 {
8944                     	switch	.text
8945  1a79               f_TIM4_UPD_Interrupt:
8949                     ; 2400 TIM4->SR1&=~TIM4_SR1_UIF;
8951  1a79 72115342      	bres	21314,#0
8952                     ; 2402 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8954  1a7d 3c12          	inc	_pwm_vent_cnt
8955  1a7f b612          	ld	a,_pwm_vent_cnt
8956  1a81 a10a          	cp	a,#10
8957  1a83 2502          	jrult	L7563
8960  1a85 3f12          	clr	_pwm_vent_cnt
8961  1a87               L7563:
8962                     ; 2403 GPIOB->ODR|=(1<<3);
8964  1a87 72165005      	bset	20485,#3
8965                     ; 2404 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8967  1a8b b612          	ld	a,_pwm_vent_cnt
8968  1a8d a105          	cp	a,#5
8969  1a8f 2504          	jrult	L1663
8972  1a91 72175005      	bres	20485,#3
8973  1a95               L1663:
8974                     ; 2408 if(++t0_cnt00>=10)
8976  1a95 9c            	rvf
8977  1a96 ce0000        	ldw	x,_t0_cnt00
8978  1a99 1c0001        	addw	x,#1
8979  1a9c cf0000        	ldw	_t0_cnt00,x
8980  1a9f a3000a        	cpw	x,#10
8981  1aa2 2f08          	jrslt	L3663
8982                     ; 2410 	t0_cnt00=0;
8984  1aa4 5f            	clrw	x
8985  1aa5 cf0000        	ldw	_t0_cnt00,x
8986                     ; 2411 	b1000Hz=1;
8988  1aa8 72100005      	bset	_b1000Hz
8989  1aac               L3663:
8990                     ; 2414 if(++t0_cnt0>=100)
8992  1aac 9c            	rvf
8993  1aad ce0002        	ldw	x,_t0_cnt0
8994  1ab0 1c0001        	addw	x,#1
8995  1ab3 cf0002        	ldw	_t0_cnt0,x
8996  1ab6 a30064        	cpw	x,#100
8997  1ab9 2f67          	jrslt	L5663
8998                     ; 2416 	t0_cnt0=0;
9000  1abb 5f            	clrw	x
9001  1abc cf0002        	ldw	_t0_cnt0,x
9002                     ; 2417 	b100Hz=1;
9004  1abf 7210000a      	bset	_b100Hz
9005                     ; 2419 	if(++t0_cnt5>=5)
9007  1ac3 725c0008      	inc	_t0_cnt5
9008  1ac7 c60008        	ld	a,_t0_cnt5
9009  1aca a105          	cp	a,#5
9010  1acc 2508          	jrult	L7663
9011                     ; 2421 		t0_cnt5=0;
9013  1ace 725f0008      	clr	_t0_cnt5
9014                     ; 2422 		b20Hz=1;
9016  1ad2 72100004      	bset	_b20Hz
9017  1ad6               L7663:
9018                     ; 2425 	if(++t0_cnt1>=10)
9020  1ad6 725c0004      	inc	_t0_cnt1
9021  1ada c60004        	ld	a,_t0_cnt1
9022  1add a10a          	cp	a,#10
9023  1adf 2508          	jrult	L1763
9024                     ; 2427 		t0_cnt1=0;
9026  1ae1 725f0004      	clr	_t0_cnt1
9027                     ; 2428 		b10Hz=1;
9029  1ae5 72100009      	bset	_b10Hz
9030  1ae9               L1763:
9031                     ; 2431 	if(++t0_cnt2>=20)
9033  1ae9 725c0005      	inc	_t0_cnt2
9034  1aed c60005        	ld	a,_t0_cnt2
9035  1af0 a114          	cp	a,#20
9036  1af2 2508          	jrult	L3763
9037                     ; 2433 		t0_cnt2=0;
9039  1af4 725f0005      	clr	_t0_cnt2
9040                     ; 2434 		b5Hz=1;
9042  1af8 72100008      	bset	_b5Hz
9043  1afc               L3763:
9044                     ; 2438 	if(++t0_cnt4>=50)
9046  1afc 725c0007      	inc	_t0_cnt4
9047  1b00 c60007        	ld	a,_t0_cnt4
9048  1b03 a132          	cp	a,#50
9049  1b05 2508          	jrult	L5763
9050                     ; 2440 		t0_cnt4=0;
9052  1b07 725f0007      	clr	_t0_cnt4
9053                     ; 2441 		b2Hz=1;
9055  1b0b 72100007      	bset	_b2Hz
9056  1b0f               L5763:
9057                     ; 2444 	if(++t0_cnt3>=100)
9059  1b0f 725c0006      	inc	_t0_cnt3
9060  1b13 c60006        	ld	a,_t0_cnt3
9061  1b16 a164          	cp	a,#100
9062  1b18 2508          	jrult	L5663
9063                     ; 2446 		t0_cnt3=0;
9065  1b1a 725f0006      	clr	_t0_cnt3
9066                     ; 2447 		b1Hz=1;
9068  1b1e 72100006      	bset	_b1Hz
9069  1b22               L5663:
9070                     ; 2453 }
9073  1b22 80            	iret
9098                     ; 2456 @far @interrupt void CAN_RX_Interrupt (void) 
9098                     ; 2457 {
9099                     	switch	.text
9100  1b23               f_CAN_RX_Interrupt:
9104                     ; 2459 CAN->PSR= 7;									// page 7 - read messsage
9106  1b23 35075427      	mov	21543,#7
9107                     ; 2461 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9109  1b27 ae000e        	ldw	x,#14
9110  1b2a               L632:
9111  1b2a d65427        	ld	a,(21543,x)
9112  1b2d e7c9          	ld	(_mess-1,x),a
9113  1b2f 5a            	decw	x
9114  1b30 26f8          	jrne	L632
9115                     ; 2472 bCAN_RX=1;
9117  1b32 35010004      	mov	_bCAN_RX,#1
9118                     ; 2473 CAN->RFR|=(1<<5);
9120  1b36 721a5424      	bset	21540,#5
9121                     ; 2475 }
9124  1b3a 80            	iret
9147                     ; 2478 @far @interrupt void CAN_TX_Interrupt (void) 
9147                     ; 2479 {
9148                     	switch	.text
9149  1b3b               f_CAN_TX_Interrupt:
9153                     ; 2480 if((CAN->TSR)&(1<<0))
9155  1b3b c65422        	ld	a,21538
9156  1b3e a501          	bcp	a,#1
9157  1b40 2708          	jreq	L1273
9158                     ; 2482 	bTX_FREE=1;	
9160  1b42 35010003      	mov	_bTX_FREE,#1
9161                     ; 2484 	CAN->TSR|=(1<<0);
9163  1b46 72105422      	bset	21538,#0
9164  1b4a               L1273:
9165                     ; 2486 }
9168  1b4a 80            	iret
9248                     ; 2489 @far @interrupt void ADC2_EOC_Interrupt (void) {
9249                     	switch	.text
9250  1b4b               f_ADC2_EOC_Interrupt:
9252       0000000d      OFST:	set	13
9253  1b4b be00          	ldw	x,c_x
9254  1b4d 89            	pushw	x
9255  1b4e be00          	ldw	x,c_y
9256  1b50 89            	pushw	x
9257  1b51 be02          	ldw	x,c_lreg+2
9258  1b53 89            	pushw	x
9259  1b54 be00          	ldw	x,c_lreg
9260  1b56 89            	pushw	x
9261  1b57 520d          	subw	sp,#13
9264                     ; 2494 adc_plazma[2]++;
9266  1b59 bec0          	ldw	x,_adc_plazma+4
9267  1b5b 1c0001        	addw	x,#1
9268  1b5e bfc0          	ldw	_adc_plazma+4,x
9269                     ; 2501 ADC2->CSR&=~(1<<7);
9271  1b60 721f5400      	bres	21504,#7
9272                     ; 2503 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9274  1b64 c65405        	ld	a,21509
9275  1b67 b703          	ld	c_lreg+3,a
9276  1b69 3f02          	clr	c_lreg+2
9277  1b6b 3f01          	clr	c_lreg+1
9278  1b6d 3f00          	clr	c_lreg
9279  1b6f 96            	ldw	x,sp
9280  1b70 1c0001        	addw	x,#OFST-12
9281  1b73 cd0000        	call	c_rtol
9283  1b76 c65404        	ld	a,21508
9284  1b79 5f            	clrw	x
9285  1b7a 97            	ld	xl,a
9286  1b7b 90ae0100      	ldw	y,#256
9287  1b7f cd0000        	call	c_umul
9289  1b82 96            	ldw	x,sp
9290  1b83 1c0001        	addw	x,#OFST-12
9291  1b86 cd0000        	call	c_ladd
9293  1b89 96            	ldw	x,sp
9294  1b8a 1c000a        	addw	x,#OFST-3
9295  1b8d cd0000        	call	c_rtol
9297                     ; 2508 if(adr_drv_stat==1)
9299  1b90 b602          	ld	a,_adr_drv_stat
9300  1b92 a101          	cp	a,#1
9301  1b94 260b          	jrne	L1673
9302                     ; 2510 	adr_drv_stat=2;
9304  1b96 35020002      	mov	_adr_drv_stat,#2
9305                     ; 2511 	adc_buff_[0]=temp_adc;
9307  1b9a 1e0c          	ldw	x,(OFST-1,sp)
9308  1b9c cf0109        	ldw	_adc_buff_,x
9310  1b9f 2020          	jra	L3673
9311  1ba1               L1673:
9312                     ; 2514 else if(adr_drv_stat==3)
9314  1ba1 b602          	ld	a,_adr_drv_stat
9315  1ba3 a103          	cp	a,#3
9316  1ba5 260b          	jrne	L5673
9317                     ; 2516 	adr_drv_stat=4;
9319  1ba7 35040002      	mov	_adr_drv_stat,#4
9320                     ; 2517 	adc_buff_[1]=temp_adc;
9322  1bab 1e0c          	ldw	x,(OFST-1,sp)
9323  1bad cf010b        	ldw	_adc_buff_+2,x
9325  1bb0 200f          	jra	L3673
9326  1bb2               L5673:
9327                     ; 2520 else if(adr_drv_stat==5)
9329  1bb2 b602          	ld	a,_adr_drv_stat
9330  1bb4 a105          	cp	a,#5
9331  1bb6 2609          	jrne	L3673
9332                     ; 2522 	adr_drv_stat=6;
9334  1bb8 35060002      	mov	_adr_drv_stat,#6
9335                     ; 2523 	adc_buff_[9]=temp_adc;
9337  1bbc 1e0c          	ldw	x,(OFST-1,sp)
9338  1bbe cf011b        	ldw	_adc_buff_+18,x
9339  1bc1               L3673:
9340                     ; 2526 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
9342  1bc1 b6ba          	ld	a,_adc_cnt_cnt
9343  1bc3 5f            	clrw	x
9344  1bc4 97            	ld	xl,a
9345  1bc5 58            	sllw	x
9346  1bc6 1f03          	ldw	(OFST-10,sp),x
9347  1bc8 b6c9          	ld	a,_adc_ch
9348  1bca 97            	ld	xl,a
9349  1bcb a610          	ld	a,#16
9350  1bcd 42            	mul	x,a
9351  1bce 72fb03        	addw	x,(OFST-10,sp)
9352  1bd1 160c          	ldw	y,(OFST-1,sp)
9353  1bd3 df0060        	ldw	(_adc_buff_buff,x),y
9354                     ; 2528 adc_ch++;
9356  1bd6 3cc9          	inc	_adc_ch
9357                     ; 2529 if(adc_ch>=6)
9359  1bd8 b6c9          	ld	a,_adc_ch
9360  1bda a106          	cp	a,#6
9361  1bdc 2516          	jrult	L3773
9362                     ; 2531 	adc_ch=0;
9364  1bde 3fc9          	clr	_adc_ch
9365                     ; 2532 	adc_cnt_cnt++;
9367  1be0 3cba          	inc	_adc_cnt_cnt
9368                     ; 2533 	if(adc_cnt_cnt>=8)
9370  1be2 b6ba          	ld	a,_adc_cnt_cnt
9371  1be4 a108          	cp	a,#8
9372  1be6 250c          	jrult	L3773
9373                     ; 2535 		adc_cnt_cnt=0;
9375  1be8 3fba          	clr	_adc_cnt_cnt
9376                     ; 2536 		adc_cnt++;
9378  1bea 3cc8          	inc	_adc_cnt
9379                     ; 2537 		if(adc_cnt>=16)
9381  1bec b6c8          	ld	a,_adc_cnt
9382  1bee a110          	cp	a,#16
9383  1bf0 2502          	jrult	L3773
9384                     ; 2539 			adc_cnt=0;
9386  1bf2 3fc8          	clr	_adc_cnt
9387  1bf4               L3773:
9388                     ; 2543 if(adc_cnt_cnt==0)
9390  1bf4 3dba          	tnz	_adc_cnt_cnt
9391  1bf6 2660          	jrne	L1004
9392                     ; 2547 	tempSS=0;
9394  1bf8 ae0000        	ldw	x,#0
9395  1bfb 1f07          	ldw	(OFST-6,sp),x
9396  1bfd ae0000        	ldw	x,#0
9397  1c00 1f05          	ldw	(OFST-8,sp),x
9398                     ; 2548 	for(i=0;i<8;i++)
9400  1c02 0f09          	clr	(OFST-4,sp)
9401  1c04               L3004:
9402                     ; 2550 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9404  1c04 7b09          	ld	a,(OFST-4,sp)
9405  1c06 5f            	clrw	x
9406  1c07 97            	ld	xl,a
9407  1c08 58            	sllw	x
9408  1c09 1f03          	ldw	(OFST-10,sp),x
9409  1c0b b6c9          	ld	a,_adc_ch
9410  1c0d 97            	ld	xl,a
9411  1c0e a610          	ld	a,#16
9412  1c10 42            	mul	x,a
9413  1c11 72fb03        	addw	x,(OFST-10,sp)
9414  1c14 de0060        	ldw	x,(_adc_buff_buff,x)
9415  1c17 cd0000        	call	c_itolx
9417  1c1a 96            	ldw	x,sp
9418  1c1b 1c0005        	addw	x,#OFST-8
9419  1c1e cd0000        	call	c_lgadd
9421                     ; 2548 	for(i=0;i<8;i++)
9423  1c21 0c09          	inc	(OFST-4,sp)
9426  1c23 7b09          	ld	a,(OFST-4,sp)
9427  1c25 a108          	cp	a,#8
9428  1c27 25db          	jrult	L3004
9429                     ; 2552 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9431  1c29 96            	ldw	x,sp
9432  1c2a 1c0005        	addw	x,#OFST-8
9433  1c2d cd0000        	call	c_ltor
9435  1c30 a603          	ld	a,#3
9436  1c32 cd0000        	call	c_lrsh
9438  1c35 be02          	ldw	x,c_lreg+2
9439  1c37 b6c8          	ld	a,_adc_cnt
9440  1c39 905f          	clrw	y
9441  1c3b 9097          	ld	yl,a
9442  1c3d 9058          	sllw	y
9443  1c3f 1703          	ldw	(OFST-10,sp),y
9444  1c41 b6c9          	ld	a,_adc_ch
9445  1c43 905f          	clrw	y
9446  1c45 9097          	ld	yl,a
9447  1c47 9058          	sllw	y
9448  1c49 9058          	sllw	y
9449  1c4b 9058          	sllw	y
9450  1c4d 9058          	sllw	y
9451  1c4f 9058          	sllw	y
9452  1c51 72f903        	addw	y,(OFST-10,sp)
9453  1c54 90df011d      	ldw	(_adc_buff,y),x
9454  1c58               L1004:
9455                     ; 2556 if((adc_cnt&0x03)==0)
9457  1c58 b6c8          	ld	a,_adc_cnt
9458  1c5a a503          	bcp	a,#3
9459  1c5c 264b          	jrne	L1104
9460                     ; 2560 	tempSS=0;
9462  1c5e ae0000        	ldw	x,#0
9463  1c61 1f07          	ldw	(OFST-6,sp),x
9464  1c63 ae0000        	ldw	x,#0
9465  1c66 1f05          	ldw	(OFST-8,sp),x
9466                     ; 2561 	for(i=0;i<16;i++)
9468  1c68 0f09          	clr	(OFST-4,sp)
9469  1c6a               L3104:
9470                     ; 2563 		tempSS+=(signed long)adc_buff[adc_ch][i];
9472  1c6a 7b09          	ld	a,(OFST-4,sp)
9473  1c6c 5f            	clrw	x
9474  1c6d 97            	ld	xl,a
9475  1c6e 58            	sllw	x
9476  1c6f 1f03          	ldw	(OFST-10,sp),x
9477  1c71 b6c9          	ld	a,_adc_ch
9478  1c73 97            	ld	xl,a
9479  1c74 a620          	ld	a,#32
9480  1c76 42            	mul	x,a
9481  1c77 72fb03        	addw	x,(OFST-10,sp)
9482  1c7a de011d        	ldw	x,(_adc_buff,x)
9483  1c7d cd0000        	call	c_itolx
9485  1c80 96            	ldw	x,sp
9486  1c81 1c0005        	addw	x,#OFST-8
9487  1c84 cd0000        	call	c_lgadd
9489                     ; 2561 	for(i=0;i<16;i++)
9491  1c87 0c09          	inc	(OFST-4,sp)
9494  1c89 7b09          	ld	a,(OFST-4,sp)
9495  1c8b a110          	cp	a,#16
9496  1c8d 25db          	jrult	L3104
9497                     ; 2565 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9499  1c8f 96            	ldw	x,sp
9500  1c90 1c0005        	addw	x,#OFST-8
9501  1c93 cd0000        	call	c_ltor
9503  1c96 a604          	ld	a,#4
9504  1c98 cd0000        	call	c_lrsh
9506  1c9b be02          	ldw	x,c_lreg+2
9507  1c9d b6c9          	ld	a,_adc_ch
9508  1c9f 905f          	clrw	y
9509  1ca1 9097          	ld	yl,a
9510  1ca3 9058          	sllw	y
9511  1ca5 90df0109      	ldw	(_adc_buff_,y),x
9512  1ca9               L1104:
9513                     ; 2572 if(adc_ch==0)adc_buff_5=temp_adc;
9515  1ca9 3dc9          	tnz	_adc_ch
9516  1cab 2605          	jrne	L1204
9519  1cad 1e0c          	ldw	x,(OFST-1,sp)
9520  1caf cf0107        	ldw	_adc_buff_5,x
9521  1cb2               L1204:
9522                     ; 2573 if(adc_ch==2)adc_buff_1=temp_adc;
9524  1cb2 b6c9          	ld	a,_adc_ch
9525  1cb4 a102          	cp	a,#2
9526  1cb6 2605          	jrne	L3204
9529  1cb8 1e0c          	ldw	x,(OFST-1,sp)
9530  1cba cf0105        	ldw	_adc_buff_1,x
9531  1cbd               L3204:
9532                     ; 2575 adc_plazma_short++;
9534  1cbd bec6          	ldw	x,_adc_plazma_short
9535  1cbf 1c0001        	addw	x,#1
9536  1cc2 bfc6          	ldw	_adc_plazma_short,x
9537                     ; 2577 }
9540  1cc4 5b0d          	addw	sp,#13
9541  1cc6 85            	popw	x
9542  1cc7 bf00          	ldw	c_lreg,x
9543  1cc9 85            	popw	x
9544  1cca bf02          	ldw	c_lreg+2,x
9545  1ccc 85            	popw	x
9546  1ccd bf00          	ldw	c_y,x
9547  1ccf 85            	popw	x
9548  1cd0 bf00          	ldw	c_x,x
9549  1cd2 80            	iret
9609                     ; 2586 main()
9609                     ; 2587 {
9611                     	switch	.text
9612  1cd3               _main:
9616                     ; 2589 CLK->ECKR|=1;
9618  1cd3 721050c1      	bset	20673,#0
9620  1cd7               L7304:
9621                     ; 2590 while((CLK->ECKR & 2) == 0);
9623  1cd7 c650c1        	ld	a,20673
9624  1cda a502          	bcp	a,#2
9625  1cdc 27f9          	jreq	L7304
9626                     ; 2591 CLK->SWCR|=2;
9628  1cde 721250c5      	bset	20677,#1
9629                     ; 2592 CLK->SWR=0xB4;
9631  1ce2 35b450c4      	mov	20676,#180
9632                     ; 2594 delay_ms(200);
9634  1ce6 ae00c8        	ldw	x,#200
9635  1ce9 cd0121        	call	_delay_ms
9637                     ; 2595 FLASH_DUKR=0xae;
9639  1cec 35ae5064      	mov	_FLASH_DUKR,#174
9640                     ; 2596 FLASH_DUKR=0x56;
9642  1cf0 35565064      	mov	_FLASH_DUKR,#86
9643                     ; 2597 enableInterrupts();
9646  1cf4 9a            rim
9648                     ; 2600 adr_drv_v3();
9651  1cf5 cd0f9f        	call	_adr_drv_v3
9653                     ; 2604 t4_init();
9655  1cf8 cd19ba        	call	_t4_init
9657                     ; 2606 		GPIOG->DDR|=(1<<0);
9659  1cfb 72105020      	bset	20512,#0
9660                     ; 2607 		GPIOG->CR1|=(1<<0);
9662  1cff 72105021      	bset	20513,#0
9663                     ; 2608 		GPIOG->CR2&=~(1<<0);	
9665  1d03 72115022      	bres	20514,#0
9666                     ; 2611 		GPIOG->DDR&=~(1<<1);
9668  1d07 72135020      	bres	20512,#1
9669                     ; 2612 		GPIOG->CR1|=(1<<1);
9671  1d0b 72125021      	bset	20513,#1
9672                     ; 2613 		GPIOG->CR2&=~(1<<1);
9674  1d0f 72135022      	bres	20514,#1
9675                     ; 2615 init_CAN();
9677  1d13 cd118f        	call	_init_CAN
9679                     ; 2620 GPIOC->DDR|=(1<<1);
9681  1d16 7212500c      	bset	20492,#1
9682                     ; 2621 GPIOC->CR1|=(1<<1);
9684  1d1a 7212500d      	bset	20493,#1
9685                     ; 2622 GPIOC->CR2|=(1<<1);
9687  1d1e 7212500e      	bset	20494,#1
9688                     ; 2624 GPIOC->DDR|=(1<<2);
9690  1d22 7214500c      	bset	20492,#2
9691                     ; 2625 GPIOC->CR1|=(1<<2);
9693  1d26 7214500d      	bset	20493,#2
9694                     ; 2626 GPIOC->CR2|=(1<<2);
9696  1d2a 7214500e      	bset	20494,#2
9697                     ; 2633 t1_init();
9699  1d2e cd19cb        	call	_t1_init
9701                     ; 2635 GPIOA->DDR|=(1<<5);
9703  1d31 721a5002      	bset	20482,#5
9704                     ; 2636 GPIOA->CR1|=(1<<5);
9706  1d35 721a5003      	bset	20483,#5
9707                     ; 2637 GPIOA->CR2&=~(1<<5);
9709  1d39 721b5004      	bres	20484,#5
9710                     ; 2643 GPIOB->DDR&=~(1<<3);
9712  1d3d 72175007      	bres	20487,#3
9713                     ; 2644 GPIOB->CR1&=~(1<<3);
9715  1d41 72175008      	bres	20488,#3
9716                     ; 2645 GPIOB->CR2&=~(1<<3);
9718  1d45 72175009      	bres	20489,#3
9719                     ; 2647 GPIOC->DDR|=(1<<3);
9721  1d49 7216500c      	bset	20492,#3
9722                     ; 2648 GPIOC->CR1|=(1<<3);
9724  1d4d 7216500d      	bset	20493,#3
9725                     ; 2649 GPIOC->CR2|=(1<<3);
9727  1d51 7216500e      	bset	20494,#3
9728                     ; 2651 U_out_const=ee_UAVT;
9730  1d55 ce000c        	ldw	x,_ee_UAVT
9731  1d58 cf0012        	ldw	_U_out_const,x
9732  1d5b               L3404:
9733                     ; 2655 	if(b1000Hz)
9735                     	btst	_b1000Hz
9736  1d60 240a          	jruge	L7404
9737                     ; 2657 		b1000Hz=0;
9739  1d62 72110005      	bres	_b1000Hz
9740                     ; 2659 		adc2_init();
9742  1d66 cd1a08        	call	_adc2_init
9744                     ; 2661 		pwr_hndl_new();
9746  1d69 cd0885        	call	_pwr_hndl_new
9748  1d6c               L7404:
9749                     ; 2663 	if(bCAN_RX)
9751  1d6c 3d04          	tnz	_bCAN_RX
9752  1d6e 2705          	jreq	L1504
9753                     ; 2665 		bCAN_RX=0;
9755  1d70 3f04          	clr	_bCAN_RX
9756                     ; 2666 		can_in_an();	
9758  1d72 cd12ec        	call	_can_in_an
9760  1d75               L1504:
9761                     ; 2668 	if(b100Hz)
9763                     	btst	_b100Hz
9764  1d7a 2407          	jruge	L3504
9765                     ; 2670 		b100Hz=0;
9767  1d7c 7211000a      	bres	_b100Hz
9768                     ; 2680 		can_tx_hndl();
9770  1d80 cd1282        	call	_can_tx_hndl
9772  1d83               L3504:
9773                     ; 2684 	if(b20Hz)
9775                     	btst	_b20Hz
9776  1d88 2404          	jruge	L5504
9777                     ; 2686 		b20Hz=0;
9779  1d8a 72110004      	bres	_b20Hz
9780  1d8e               L5504:
9781                     ; 2692 	if(b10Hz)
9783                     	btst	_b10Hz
9784  1d93 2425          	jruge	L7504
9785                     ; 2694 		b10Hz=0;
9787  1d95 72110009      	bres	_b10Hz
9788                     ; 2695 		led_drv();
9790  1d99 cd03ee        	call	_led_drv
9792                     ; 2696 		matemat();
9794  1d9c cd0a9f        	call	_matemat
9796                     ; 2698 	  link_drv();
9798  1d9f cd04dc        	call	_link_drv
9800                     ; 2700 	  JP_drv();
9802  1da2 cd0451        	call	_JP_drv
9804                     ; 2701 	  flags_drv();
9806  1da5 cd0f54        	call	_flags_drv
9808                     ; 2703 		if(main_cnt10<100)main_cnt10++;
9810  1da8 9c            	rvf
9811  1da9 ce025d        	ldw	x,_main_cnt10
9812  1dac a30064        	cpw	x,#100
9813  1daf 2e09          	jrsge	L7504
9816  1db1 ce025d        	ldw	x,_main_cnt10
9817  1db4 1c0001        	addw	x,#1
9818  1db7 cf025d        	ldw	_main_cnt10,x
9819  1dba               L7504:
9820                     ; 2706 	if(b5Hz)
9822                     	btst	_b5Hz
9823  1dbf 2419          	jruge	L3604
9824                     ; 2708 		b5Hz=0;
9826  1dc1 72110008      	bres	_b5Hz
9827                     ; 2715 		led_hndl();
9829  1dc5 cd0163        	call	_led_hndl
9831                     ; 2717 		vent_drv();
9833  1dc8 cd0534        	call	_vent_drv
9835                     ; 2719 		if(main_cnt1<1000)main_cnt1++;
9837  1dcb 9c            	rvf
9838  1dcc be5e          	ldw	x,_main_cnt1
9839  1dce a303e8        	cpw	x,#1000
9840  1dd1 2e07          	jrsge	L3604
9843  1dd3 be5e          	ldw	x,_main_cnt1
9844  1dd5 1c0001        	addw	x,#1
9845  1dd8 bf5e          	ldw	_main_cnt1,x
9846  1dda               L3604:
9847                     ; 2722 	if(b2Hz)
9849                     	btst	_b2Hz
9850  1ddf 240d          	jruge	L7604
9851                     ; 2724 		b2Hz=0;
9853  1de1 72110007      	bres	_b2Hz
9854                     ; 2728 		temper_drv();
9856  1de5 cd0cc1        	call	_temper_drv
9858                     ; 2729 		u_drv();
9860  1de8 cd0d98        	call	_u_drv
9862                     ; 2730 		vent_resurs_hndl();
9864  1deb cd0000        	call	_vent_resurs_hndl
9866  1dee               L7604:
9867                     ; 2733 	if(b1Hz)
9869                     	btst	_b1Hz
9870  1df3 2503cc1d5b    	jruge	L3404
9871                     ; 2735 		b1Hz=0;
9873  1df8 72110006      	bres	_b1Hz
9874                     ; 2741 		if(main_cnt<1000)main_cnt++;
9876  1dfc 9c            	rvf
9877  1dfd ce025f        	ldw	x,_main_cnt
9878  1e00 a303e8        	cpw	x,#1000
9879  1e03 2e09          	jrsge	L3704
9882  1e05 ce025f        	ldw	x,_main_cnt
9883  1e08 1c0001        	addw	x,#1
9884  1e0b cf025f        	ldw	_main_cnt,x
9885  1e0e               L3704:
9886                     ; 2742   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9888  1e0e b670          	ld	a,_link
9889  1e10 a1aa          	cp	a,#170
9890  1e12 2706          	jreq	L7704
9892  1e14 b655          	ld	a,_jp_mode
9893  1e16 a103          	cp	a,#3
9894  1e18 2603          	jrne	L5704
9895  1e1a               L7704:
9898  1e1a cd0eb5        	call	_apv_hndl
9900  1e1d               L5704:
9901                     ; 2745   		can_error_cnt++;
9903  1e1d 3c76          	inc	_can_error_cnt
9904                     ; 2746   		if(can_error_cnt>=10)
9906  1e1f b676          	ld	a,_can_error_cnt
9907  1e21 a10a          	cp	a,#10
9908  1e23 2403          	jruge	L642
9909  1e25 cc1d5b        	jp	L3404
9910  1e28               L642:
9911                     ; 2748   			can_error_cnt=0;
9913  1e28 3f76          	clr	_can_error_cnt
9914                     ; 2749 				init_CAN();
9916  1e2a cd118f        	call	_init_CAN
9918  1e2d ac5b1d5b      	jpf	L3404
11238                     	xdef	_main
11239                     	xdef	f_ADC2_EOC_Interrupt
11240                     	xdef	f_CAN_TX_Interrupt
11241                     	xdef	f_CAN_RX_Interrupt
11242                     	xdef	f_TIM4_UPD_Interrupt
11243                     	xdef	_adc2_init
11244                     	xdef	_t1_init
11245                     	xdef	_t4_init
11246                     	xdef	_can_in_an
11247                     	xdef	_can_tx_hndl
11248                     	xdef	_can_transmit
11249                     	xdef	_init_CAN
11250                     	xdef	_adr_drv_v3
11251                     	xdef	_adr_drv_v4
11252                     	xdef	_flags_drv
11253                     	xdef	_apv_hndl
11254                     	xdef	_apv_stop
11255                     	xdef	_apv_start
11256                     	xdef	_u_drv
11257                     	xdef	_temper_drv
11258                     	xdef	_matemat
11259                     	xdef	_pwr_hndl_new
11260                     	xdef	_pwr_hndl
11261                     	xdef	_pwr_drv
11262                     	xdef	_vent_drv
11263                     	xdef	_link_drv
11264                     	xdef	_JP_drv
11265                     	xdef	_led_drv
11266                     	xdef	_led_hndl
11267                     	xdef	_delay_ms
11268                     	xdef	_granee
11269                     	xdef	_gran
11270                     	xdef	_vent_resurs_hndl
11271                     	switch	.ubsct
11272  0001               _debug_info_to_uku:
11273  0001 000000000000  	ds.b	6
11274                     	xdef	_debug_info_to_uku
11275  0007               _pwm_u_cnt:
11276  0007 00            	ds.b	1
11277                     	xdef	_pwm_u_cnt
11278  0008               _vent_resurs_tx_cnt:
11279  0008 00            	ds.b	1
11280                     	xdef	_vent_resurs_tx_cnt
11281                     	switch	.bss
11282  0000               _vent_resurs_buff:
11283  0000 00000000      	ds.b	4
11284                     	xdef	_vent_resurs_buff
11285                     	switch	.ubsct
11286  0009               _vent_resurs_sec_cnt:
11287  0009 0000          	ds.b	2
11288                     	xdef	_vent_resurs_sec_cnt
11289                     .eeprom:	section	.data
11290  0000               _vent_resurs:
11291  0000 0000          	ds.b	2
11292                     	xdef	_vent_resurs
11293  0002               _ee_IMAXVENT:
11294  0002 0000          	ds.b	2
11295                     	xdef	_ee_IMAXVENT
11296                     	switch	.ubsct
11297  000b               _bps_class:
11298  000b 00            	ds.b	1
11299                     	xdef	_bps_class
11300  000c               _vent_pwm_integr_cnt:
11301  000c 0000          	ds.b	2
11302                     	xdef	_vent_pwm_integr_cnt
11303  000e               _vent_pwm_integr:
11304  000e 0000          	ds.b	2
11305                     	xdef	_vent_pwm_integr
11306  0010               _vent_pwm:
11307  0010 0000          	ds.b	2
11308                     	xdef	_vent_pwm
11309  0012               _pwm_vent_cnt:
11310  0012 00            	ds.b	1
11311                     	xdef	_pwm_vent_cnt
11312                     	switch	.eeprom
11313  0004               _ee_DEVICE:
11314  0004 0000          	ds.b	2
11315                     	xdef	_ee_DEVICE
11316  0006               _ee_AVT_MODE:
11317  0006 0000          	ds.b	2
11318                     	xdef	_ee_AVT_MODE
11319                     	switch	.ubsct
11320  0013               _FADE_MODE:
11321  0013 00            	ds.b	1
11322                     	xdef	_FADE_MODE
11323  0014               _i_main_bps_cnt:
11324  0014 000000000000  	ds.b	6
11325                     	xdef	_i_main_bps_cnt
11326  001a               _i_main_sigma:
11327  001a 0000          	ds.b	2
11328                     	xdef	_i_main_sigma
11329  001c               _i_main_num_of_bps:
11330  001c 00            	ds.b	1
11331                     	xdef	_i_main_num_of_bps
11332  001d               _i_main_avg:
11333  001d 0000          	ds.b	2
11334                     	xdef	_i_main_avg
11335  001f               _i_main_flag:
11336  001f 000000000000  	ds.b	6
11337                     	xdef	_i_main_flag
11338  0025               _i_main:
11339  0025 000000000000  	ds.b	12
11340                     	xdef	_i_main
11341  0031               _x:
11342  0031 000000000000  	ds.b	12
11343                     	xdef	_x
11344                     	xdef	_volum_u_main_
11345                     	switch	.eeprom
11346  0008               _UU_AVT:
11347  0008 0000          	ds.b	2
11348                     	xdef	_UU_AVT
11349                     	switch	.ubsct
11350  003d               _cnt_net_drv:
11351  003d 00            	ds.b	1
11352                     	xdef	_cnt_net_drv
11353                     	switch	.bit
11354  0001               _bMAIN:
11355  0001 00            	ds.b	1
11356                     	xdef	_bMAIN
11357                     	switch	.ubsct
11358  003e               _plazma_int:
11359  003e 000000000000  	ds.b	6
11360                     	xdef	_plazma_int
11361                     	xdef	_rotor_int
11362  0044               _led_green_buff:
11363  0044 00000000      	ds.b	4
11364                     	xdef	_led_green_buff
11365  0048               _led_red_buff:
11366  0048 00000000      	ds.b	4
11367                     	xdef	_led_red_buff
11368                     	xdef	_led_drv_cnt
11369                     	xdef	_led_green
11370                     	xdef	_led_red
11371  004c               _res_fl_cnt:
11372  004c 00            	ds.b	1
11373                     	xdef	_res_fl_cnt
11374                     	xdef	_bRES_
11375                     	xdef	_bRES
11376                     	switch	.eeprom
11377  000a               _res_fl_:
11378  000a 00            	ds.b	1
11379                     	xdef	_res_fl_
11380  000b               _res_fl:
11381  000b 00            	ds.b	1
11382                     	xdef	_res_fl
11383                     	switch	.ubsct
11384  004d               _cnt_apv_off:
11385  004d 00            	ds.b	1
11386                     	xdef	_cnt_apv_off
11387                     	switch	.bit
11388  0002               _bAPV:
11389  0002 00            	ds.b	1
11390                     	xdef	_bAPV
11391                     	switch	.ubsct
11392  004e               _apv_cnt_:
11393  004e 0000          	ds.b	2
11394                     	xdef	_apv_cnt_
11395  0050               _apv_cnt:
11396  0050 000000        	ds.b	3
11397                     	xdef	_apv_cnt
11398                     	xdef	_bBL_IPS
11399                     	switch	.bit
11400  0003               _bBL:
11401  0003 00            	ds.b	1
11402                     	xdef	_bBL
11403                     	switch	.ubsct
11404  0053               _cnt_JP1:
11405  0053 00            	ds.b	1
11406                     	xdef	_cnt_JP1
11407  0054               _cnt_JP0:
11408  0054 00            	ds.b	1
11409                     	xdef	_cnt_JP0
11410  0055               _jp_mode:
11411  0055 00            	ds.b	1
11412                     	xdef	_jp_mode
11413  0056               _pwm_delt:
11414  0056 0000          	ds.b	2
11415                     	xdef	_pwm_delt
11416  0058               _pwm_u_:
11417  0058 0000          	ds.b	2
11418                     	xdef	_pwm_u_
11419                     	xdef	_pwm_i
11420                     	xdef	_pwm_u
11421  005a               _tmax_cnt:
11422  005a 0000          	ds.b	2
11423                     	xdef	_tmax_cnt
11424  005c               _tsign_cnt:
11425  005c 0000          	ds.b	2
11426                     	xdef	_tsign_cnt
11427                     	switch	.eeprom
11428  000c               _ee_UAVT:
11429  000c 0000          	ds.b	2
11430                     	xdef	_ee_UAVT
11431  000e               _ee_tsign:
11432  000e 0000          	ds.b	2
11433                     	xdef	_ee_tsign
11434  0010               _ee_tmax:
11435  0010 0000          	ds.b	2
11436                     	xdef	_ee_tmax
11437  0012               _ee_dU:
11438  0012 0000          	ds.b	2
11439                     	xdef	_ee_dU
11440  0014               _ee_Umax:
11441  0014 0000          	ds.b	2
11442                     	xdef	_ee_Umax
11443  0016               _ee_TZAS:
11444  0016 0000          	ds.b	2
11445                     	xdef	_ee_TZAS
11446                     	switch	.ubsct
11447  005e               _main_cnt1:
11448  005e 0000          	ds.b	2
11449                     	xdef	_main_cnt1
11450  0060               _off_bp_cnt:
11451  0060 00            	ds.b	1
11452                     	xdef	_off_bp_cnt
11453                     	xdef	_vol_i_temp_avar
11454  0061               _flags_tu_cnt_off:
11455  0061 00            	ds.b	1
11456                     	xdef	_flags_tu_cnt_off
11457  0062               _flags_tu_cnt_on:
11458  0062 00            	ds.b	1
11459                     	xdef	_flags_tu_cnt_on
11460  0063               _vol_i_temp:
11461  0063 0000          	ds.b	2
11462                     	xdef	_vol_i_temp
11463  0065               _vol_u_temp:
11464  0065 0000          	ds.b	2
11465                     	xdef	_vol_u_temp
11466                     	switch	.eeprom
11467  0018               __x_ee_:
11468  0018 0000          	ds.b	2
11469                     	xdef	__x_ee_
11470                     	switch	.ubsct
11471  0067               __x_cnt:
11472  0067 0000          	ds.b	2
11473                     	xdef	__x_cnt
11474  0069               __x__:
11475  0069 0000          	ds.b	2
11476                     	xdef	__x__
11477  006b               __x_:
11478  006b 0000          	ds.b	2
11479                     	xdef	__x_
11480  006d               _flags_tu:
11481  006d 00            	ds.b	1
11482                     	xdef	_flags_tu
11483                     	xdef	_flags
11484  006e               _link_cnt:
11485  006e 0000          	ds.b	2
11486                     	xdef	_link_cnt
11487  0070               _link:
11488  0070 00            	ds.b	1
11489                     	xdef	_link
11490  0071               _umin_cnt:
11491  0071 0000          	ds.b	2
11492                     	xdef	_umin_cnt
11493  0073               _umax_cnt:
11494  0073 0000          	ds.b	2
11495                     	xdef	_umax_cnt
11496                     	switch	.bss
11497  0004               _pwm_schot_cnt:
11498  0004 0000          	ds.b	2
11499                     	xdef	_pwm_schot_cnt
11500  0006               _pwm_peace_cnt_:
11501  0006 0000          	ds.b	2
11502                     	xdef	_pwm_peace_cnt_
11503  0008               _pwm_peace_cnt:
11504  0008 0000          	ds.b	2
11505                     	xdef	_pwm_peace_cnt
11506                     	switch	.eeprom
11507  001a               _ee_K:
11508  001a 000000000000  	ds.b	20
11509                     	xdef	_ee_K
11510                     	switch	.ubsct
11511  0075               _T:
11512  0075 00            	ds.b	1
11513                     	xdef	_T
11514                     	switch	.bss
11515  000a               _Ufade:
11516  000a 0000          	ds.b	2
11517                     	xdef	_Ufade
11518  000c               _Udelt:
11519  000c 0000          	ds.b	2
11520                     	xdef	_Udelt
11521  000e               _Uin:
11522  000e 0000          	ds.b	2
11523                     	xdef	_Uin
11524  0010               _Usum:
11525  0010 0000          	ds.b	2
11526                     	xdef	_Usum
11527  0012               _U_out_const:
11528  0012 0000          	ds.b	2
11529                     	xdef	_U_out_const
11530  0014               _Unecc:
11531  0014 0000          	ds.b	2
11532                     	xdef	_Unecc
11533  0016               _Ui:
11534  0016 0000          	ds.b	2
11535                     	xdef	_Ui
11536  0018               _Un:
11537  0018 0000          	ds.b	2
11538                     	xdef	_Un
11539  001a               _I:
11540  001a 0000          	ds.b	2
11541                     	xdef	_I
11542                     	switch	.ubsct
11543  0076               _can_error_cnt:
11544  0076 00            	ds.b	1
11545                     	xdef	_can_error_cnt
11546                     	xdef	_bCAN_RX
11547  0077               _tx_busy_cnt:
11548  0077 00            	ds.b	1
11549                     	xdef	_tx_busy_cnt
11550                     	xdef	_bTX_FREE
11551  0078               _can_buff_rd_ptr:
11552  0078 00            	ds.b	1
11553                     	xdef	_can_buff_rd_ptr
11554  0079               _can_buff_wr_ptr:
11555  0079 00            	ds.b	1
11556                     	xdef	_can_buff_wr_ptr
11557  007a               _can_out_buff:
11558  007a 000000000000  	ds.b	64
11559                     	xdef	_can_out_buff
11560                     	switch	.bss
11561  001c               _pwm_u_buff_cnt:
11562  001c 00            	ds.b	1
11563                     	xdef	_pwm_u_buff_cnt
11564  001d               _pwm_u_buff_ptr:
11565  001d 00            	ds.b	1
11566                     	xdef	_pwm_u_buff_ptr
11567  001e               _pwm_u_buff_:
11568  001e 0000          	ds.b	2
11569                     	xdef	_pwm_u_buff_
11570  0020               _pwm_u_buff:
11571  0020 000000000000  	ds.b	64
11572                     	xdef	_pwm_u_buff
11573                     	switch	.ubsct
11574  00ba               _adc_cnt_cnt:
11575  00ba 00            	ds.b	1
11576                     	xdef	_adc_cnt_cnt
11577                     	switch	.bss
11578  0060               _adc_buff_buff:
11579  0060 000000000000  	ds.b	160
11580                     	xdef	_adc_buff_buff
11581  0100               _adress_error:
11582  0100 00            	ds.b	1
11583                     	xdef	_adress_error
11584  0101               _adress:
11585  0101 00            	ds.b	1
11586                     	xdef	_adress
11587  0102               _adr:
11588  0102 000000        	ds.b	3
11589                     	xdef	_adr
11590                     	xdef	_adr_drv_stat
11591                     	xdef	_led_ind
11592                     	switch	.ubsct
11593  00bb               _led_ind_cnt:
11594  00bb 00            	ds.b	1
11595                     	xdef	_led_ind_cnt
11596  00bc               _adc_plazma:
11597  00bc 000000000000  	ds.b	10
11598                     	xdef	_adc_plazma
11599  00c6               _adc_plazma_short:
11600  00c6 0000          	ds.b	2
11601                     	xdef	_adc_plazma_short
11602  00c8               _adc_cnt:
11603  00c8 00            	ds.b	1
11604                     	xdef	_adc_cnt
11605  00c9               _adc_ch:
11606  00c9 00            	ds.b	1
11607                     	xdef	_adc_ch
11608                     	switch	.bss
11609  0105               _adc_buff_1:
11610  0105 0000          	ds.b	2
11611                     	xdef	_adc_buff_1
11612  0107               _adc_buff_5:
11613  0107 0000          	ds.b	2
11614                     	xdef	_adc_buff_5
11615  0109               _adc_buff_:
11616  0109 000000000000  	ds.b	20
11617                     	xdef	_adc_buff_
11618  011d               _adc_buff:
11619  011d 000000000000  	ds.b	320
11620                     	xdef	_adc_buff
11621  025d               _main_cnt10:
11622  025d 0000          	ds.b	2
11623                     	xdef	_main_cnt10
11624  025f               _main_cnt:
11625  025f 0000          	ds.b	2
11626                     	xdef	_main_cnt
11627                     	switch	.ubsct
11628  00ca               _mess:
11629  00ca 000000000000  	ds.b	14
11630                     	xdef	_mess
11631                     	switch	.bit
11632  0004               _b20Hz:
11633  0004 00            	ds.b	1
11634                     	xdef	_b20Hz
11635  0005               _b1000Hz:
11636  0005 00            	ds.b	1
11637                     	xdef	_b1000Hz
11638  0006               _b1Hz:
11639  0006 00            	ds.b	1
11640                     	xdef	_b1Hz
11641  0007               _b2Hz:
11642  0007 00            	ds.b	1
11643                     	xdef	_b2Hz
11644  0008               _b5Hz:
11645  0008 00            	ds.b	1
11646                     	xdef	_b5Hz
11647  0009               _b10Hz:
11648  0009 00            	ds.b	1
11649                     	xdef	_b10Hz
11650  000a               _b100Hz:
11651  000a 00            	ds.b	1
11652                     	xdef	_b100Hz
11653                     	xdef	_t0_cnt5
11654                     	xdef	_t0_cnt4
11655                     	xdef	_t0_cnt3
11656                     	xdef	_t0_cnt2
11657                     	xdef	_t0_cnt1
11658                     	xdef	_t0_cnt0
11659                     	xdef	_t0_cnt00
11660                     	xref	_abs
11661                     	xdef	_bVENT_BLOCK
11662                     	xref.b	c_lreg
11663                     	xref.b	c_x
11664                     	xref.b	c_y
11684                     	xref	c_lrsh
11685                     	xref	c_umul
11686                     	xref	c_lgsub
11687                     	xref	c_lgrsh
11688                     	xref	c_lgadd
11689                     	xref	c_idiv
11690                     	xref	c_sdivx
11691                     	xref	c_imul
11692                     	xref	c_lsbc
11693                     	xref	c_ladd
11694                     	xref	c_lsub
11695                     	xref	c_ldiv
11696                     	xref	c_lgmul
11697                     	xref	c_itolx
11698                     	xref	c_eewrc
11699                     	xref	c_ltor
11700                     	xref	c_lgadc
11701                     	xref	c_rtol
11702                     	xref	c_vmul
11703                     	xref	c_eewrw
11704                     	xref	c_lcmp
11705                     	xref	c_uitolx
11706                     	end
