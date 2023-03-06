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
4903                     ; 1219 pwm_u=0;
4905  0a65 5f            	clrw	x
4906  0a66 bf08          	ldw	_pwm_u,x
4907                     ; 1220 pwm_i=1000;
4909  0a68 ae03e8        	ldw	x,#1000
4910  0a6b bf0a          	ldw	_pwm_i,x
4911                     ; 1222 TIM1->CCR2H= (char)(pwm_u/256);	
4913  0a6d be08          	ldw	x,_pwm_u
4914  0a6f 90ae0100      	ldw	y,#256
4915  0a73 cd0000        	call	c_idiv
4917  0a76 9f            	ld	a,xl
4918  0a77 c75267        	ld	21095,a
4919                     ; 1223 TIM1->CCR2L= (char)pwm_u;
4921  0a7a 5500095268    	mov	21096,_pwm_u+1
4922                     ; 1225 TIM1->CCR1H= (char)(pwm_i/256);	
4924  0a7f 35035265      	mov	21093,#3
4925                     ; 1226 TIM1->CCR1L= (char)pwm_i;
4927  0a83 35e85266      	mov	21094,#232
4928                     ; 1228 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4930  0a87 be0e          	ldw	x,_vent_pwm_integr
4931  0a89 90ae0080      	ldw	y,#128
4932  0a8d cd0000        	call	c_idiv
4934  0a90 9f            	ld	a,xl
4935  0a91 c75269        	ld	21097,a
4936                     ; 1229 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4938  0a94 b60f          	ld	a,_vent_pwm_integr+1
4939  0a96 48            	sll	a
4940  0a97 c7526a        	ld	21098,a
4941                     ; 1231 }
4944  0a9a 5b04          	addw	sp,#4
4945  0a9c 81            	ret
4999                     	switch	.const
5000  0020               L27:
5001  0020 00000258      	dc.l	600
5002  0024               L47:
5003  0024 00000708      	dc.l	1800
5004                     ; 1235 void matemat(void)
5004                     ; 1236 {
5005                     	switch	.text
5006  0a9d               _matemat:
5008  0a9d 5208          	subw	sp,#8
5009       00000008      OFST:	set	8
5012                     ; 1260 I=adc_buff_[4];
5014  0a9f ce0111        	ldw	x,_adc_buff_+8
5015  0aa2 cf001a        	ldw	_I,x
5016                     ; 1261 temp_SL=adc_buff_[4];
5018  0aa5 ce0111        	ldw	x,_adc_buff_+8
5019  0aa8 cd0000        	call	c_itolx
5021  0aab 96            	ldw	x,sp
5022  0aac 1c0005        	addw	x,#OFST-3
5023  0aaf cd0000        	call	c_rtol
5025                     ; 1262 temp_SL-=ee_K[0][0];
5027  0ab2 ce001a        	ldw	x,_ee_K
5028  0ab5 cd0000        	call	c_itolx
5030  0ab8 96            	ldw	x,sp
5031  0ab9 1c0005        	addw	x,#OFST-3
5032  0abc cd0000        	call	c_lgsub
5034                     ; 1263 if(temp_SL<0) temp_SL=0;
5036  0abf 9c            	rvf
5037  0ac0 0d05          	tnz	(OFST-3,sp)
5038  0ac2 2e0a          	jrsge	L5242
5041  0ac4 ae0000        	ldw	x,#0
5042  0ac7 1f07          	ldw	(OFST-1,sp),x
5043  0ac9 ae0000        	ldw	x,#0
5044  0acc 1f05          	ldw	(OFST-3,sp),x
5045  0ace               L5242:
5046                     ; 1264 temp_SL*=ee_K[0][1];
5048  0ace ce001c        	ldw	x,_ee_K+2
5049  0ad1 cd0000        	call	c_itolx
5051  0ad4 96            	ldw	x,sp
5052  0ad5 1c0005        	addw	x,#OFST-3
5053  0ad8 cd0000        	call	c_lgmul
5055                     ; 1265 temp_SL/=600;
5057  0adb 96            	ldw	x,sp
5058  0adc 1c0005        	addw	x,#OFST-3
5059  0adf cd0000        	call	c_ltor
5061  0ae2 ae0020        	ldw	x,#L27
5062  0ae5 cd0000        	call	c_ldiv
5064  0ae8 96            	ldw	x,sp
5065  0ae9 1c0005        	addw	x,#OFST-3
5066  0aec cd0000        	call	c_rtol
5068                     ; 1266 I=(signed short)temp_SL;
5070  0aef 1e07          	ldw	x,(OFST-1,sp)
5071  0af1 cf001a        	ldw	_I,x
5072                     ; 1269 temp_SL=(signed long)adc_buff_[1];//1;
5074  0af4 ce010b        	ldw	x,_adc_buff_+2
5075  0af7 cd0000        	call	c_itolx
5077  0afa 96            	ldw	x,sp
5078  0afb 1c0005        	addw	x,#OFST-3
5079  0afe cd0000        	call	c_rtol
5081                     ; 1272 if(temp_SL<0) temp_SL=0;
5083  0b01 9c            	rvf
5084  0b02 0d05          	tnz	(OFST-3,sp)
5085  0b04 2e0a          	jrsge	L7242
5088  0b06 ae0000        	ldw	x,#0
5089  0b09 1f07          	ldw	(OFST-1,sp),x
5090  0b0b ae0000        	ldw	x,#0
5091  0b0e 1f05          	ldw	(OFST-3,sp),x
5092  0b10               L7242:
5093                     ; 1273 temp_SL*=(signed long)ee_K[2][1];
5095  0b10 ce0024        	ldw	x,_ee_K+10
5096  0b13 cd0000        	call	c_itolx
5098  0b16 96            	ldw	x,sp
5099  0b17 1c0005        	addw	x,#OFST-3
5100  0b1a cd0000        	call	c_lgmul
5102                     ; 1274 temp_SL/=1000L;
5104  0b1d 96            	ldw	x,sp
5105  0b1e 1c0005        	addw	x,#OFST-3
5106  0b21 cd0000        	call	c_ltor
5108  0b24 ae001c        	ldw	x,#L46
5109  0b27 cd0000        	call	c_ldiv
5111  0b2a 96            	ldw	x,sp
5112  0b2b 1c0005        	addw	x,#OFST-3
5113  0b2e cd0000        	call	c_rtol
5115                     ; 1275 Ui=(unsigned short)temp_SL;
5117  0b31 1e07          	ldw	x,(OFST-1,sp)
5118  0b33 cf0016        	ldw	_Ui,x
5119                     ; 1277 temp_SL=(signed long)adc_buff_5;
5121  0b36 ce0107        	ldw	x,_adc_buff_5
5122  0b39 cd0000        	call	c_itolx
5124  0b3c 96            	ldw	x,sp
5125  0b3d 1c0005        	addw	x,#OFST-3
5126  0b40 cd0000        	call	c_rtol
5128                     ; 1279 if(temp_SL<0) temp_SL=0;
5130  0b43 9c            	rvf
5131  0b44 0d05          	tnz	(OFST-3,sp)
5132  0b46 2e0a          	jrsge	L1342
5135  0b48 ae0000        	ldw	x,#0
5136  0b4b 1f07          	ldw	(OFST-1,sp),x
5137  0b4d ae0000        	ldw	x,#0
5138  0b50 1f05          	ldw	(OFST-3,sp),x
5139  0b52               L1342:
5140                     ; 1280 temp_SL*=(signed long)ee_K[4][1];
5142  0b52 ce002c        	ldw	x,_ee_K+18
5143  0b55 cd0000        	call	c_itolx
5145  0b58 96            	ldw	x,sp
5146  0b59 1c0005        	addw	x,#OFST-3
5147  0b5c cd0000        	call	c_lgmul
5149                     ; 1281 temp_SL/=1000L;
5151  0b5f 96            	ldw	x,sp
5152  0b60 1c0005        	addw	x,#OFST-3
5153  0b63 cd0000        	call	c_ltor
5155  0b66 ae001c        	ldw	x,#L46
5156  0b69 cd0000        	call	c_ldiv
5158  0b6c 96            	ldw	x,sp
5159  0b6d 1c0005        	addw	x,#OFST-3
5160  0b70 cd0000        	call	c_rtol
5162                     ; 1282 Usum=(unsigned short)temp_SL;
5164  0b73 1e07          	ldw	x,(OFST-1,sp)
5165  0b75 cf0010        	ldw	_Usum,x
5166                     ; 1286 temp_SL=adc_buff_[3];
5168  0b78 ce010f        	ldw	x,_adc_buff_+6
5169  0b7b cd0000        	call	c_itolx
5171  0b7e 96            	ldw	x,sp
5172  0b7f 1c0005        	addw	x,#OFST-3
5173  0b82 cd0000        	call	c_rtol
5175                     ; 1288 if(temp_SL<0) temp_SL=0;
5177  0b85 9c            	rvf
5178  0b86 0d05          	tnz	(OFST-3,sp)
5179  0b88 2e0a          	jrsge	L3342
5182  0b8a ae0000        	ldw	x,#0
5183  0b8d 1f07          	ldw	(OFST-1,sp),x
5184  0b8f ae0000        	ldw	x,#0
5185  0b92 1f05          	ldw	(OFST-3,sp),x
5186  0b94               L3342:
5187                     ; 1289 temp_SL*=ee_K[1][1];
5189  0b94 ce0020        	ldw	x,_ee_K+6
5190  0b97 cd0000        	call	c_itolx
5192  0b9a 96            	ldw	x,sp
5193  0b9b 1c0005        	addw	x,#OFST-3
5194  0b9e cd0000        	call	c_lgmul
5196                     ; 1290 temp_SL/=1800;
5198  0ba1 96            	ldw	x,sp
5199  0ba2 1c0005        	addw	x,#OFST-3
5200  0ba5 cd0000        	call	c_ltor
5202  0ba8 ae0024        	ldw	x,#L47
5203  0bab cd0000        	call	c_ldiv
5205  0bae 96            	ldw	x,sp
5206  0baf 1c0005        	addw	x,#OFST-3
5207  0bb2 cd0000        	call	c_rtol
5209                     ; 1291 Un=(unsigned short)temp_SL;
5211  0bb5 1e07          	ldw	x,(OFST-1,sp)
5212  0bb7 cf0018        	ldw	_Un,x
5213                     ; 1296 temp_SL=adc_buff_[2];
5215  0bba ce010d        	ldw	x,_adc_buff_+4
5216  0bbd cd0000        	call	c_itolx
5218  0bc0 96            	ldw	x,sp
5219  0bc1 1c0005        	addw	x,#OFST-3
5220  0bc4 cd0000        	call	c_rtol
5222                     ; 1297 temp_SL*=ee_K[3][1];
5224  0bc7 ce0028        	ldw	x,_ee_K+14
5225  0bca cd0000        	call	c_itolx
5227  0bcd 96            	ldw	x,sp
5228  0bce 1c0005        	addw	x,#OFST-3
5229  0bd1 cd0000        	call	c_lgmul
5231                     ; 1298 temp_SL/=1000;
5233  0bd4 96            	ldw	x,sp
5234  0bd5 1c0005        	addw	x,#OFST-3
5235  0bd8 cd0000        	call	c_ltor
5237  0bdb ae001c        	ldw	x,#L46
5238  0bde cd0000        	call	c_ldiv
5240  0be1 96            	ldw	x,sp
5241  0be2 1c0005        	addw	x,#OFST-3
5242  0be5 cd0000        	call	c_rtol
5244                     ; 1299 T=(signed short)(temp_SL-273L);
5246  0be8 7b08          	ld	a,(OFST+0,sp)
5247  0bea 5f            	clrw	x
5248  0beb 4d            	tnz	a
5249  0bec 2a01          	jrpl	L67
5250  0bee 53            	cplw	x
5251  0bef               L67:
5252  0bef 97            	ld	xl,a
5253  0bf0 1d0111        	subw	x,#273
5254  0bf3 01            	rrwa	x,a
5255  0bf4 b775          	ld	_T,a
5256  0bf6 02            	rlwa	x,a
5257                     ; 1300 if(T<-30)T=-30;
5259  0bf7 9c            	rvf
5260  0bf8 b675          	ld	a,_T
5261  0bfa a1e2          	cp	a,#226
5262  0bfc 2e04          	jrsge	L5342
5265  0bfe 35e20075      	mov	_T,#226
5266  0c02               L5342:
5267                     ; 1301 if(T>120)T=120;
5269  0c02 9c            	rvf
5270  0c03 b675          	ld	a,_T
5271  0c05 a179          	cp	a,#121
5272  0c07 2f04          	jrslt	L7342
5275  0c09 35780075      	mov	_T,#120
5276  0c0d               L7342:
5277                     ; 1305 Uin=Usum-Ui;
5279  0c0d ce0010        	ldw	x,_Usum
5280  0c10 72b00016      	subw	x,_Ui
5281  0c14 cf000e        	ldw	_Uin,x
5282                     ; 1306 if(link==ON)
5284  0c17 b670          	ld	a,_link
5285  0c19 a155          	cp	a,#85
5286  0c1b 260c          	jrne	L1442
5287                     ; 1308 	Unecc=U_out_const-Uin;
5289  0c1d ce0012        	ldw	x,_U_out_const
5290  0c20 72b0000e      	subw	x,_Uin
5291  0c24 cf0014        	ldw	_Unecc,x
5293  0c27 200a          	jra	L3442
5294  0c29               L1442:
5295                     ; 1317 else Unecc=ee_UAVT-Uin;
5297  0c29 ce000c        	ldw	x,_ee_UAVT
5298  0c2c 72b0000e      	subw	x,_Uin
5299  0c30 cf0014        	ldw	_Unecc,x
5300  0c33               L3442:
5301                     ; 1325 if(Unecc<0)Unecc=0;
5303  0c33 9c            	rvf
5304  0c34 ce0014        	ldw	x,_Unecc
5305  0c37 2e04          	jrsge	L5442
5308  0c39 5f            	clrw	x
5309  0c3a cf0014        	ldw	_Unecc,x
5310  0c3d               L5442:
5311                     ; 1326 temp_SL=(signed long)(T-ee_tsign);
5313  0c3d 5f            	clrw	x
5314  0c3e b675          	ld	a,_T
5315  0c40 2a01          	jrpl	L001
5316  0c42 53            	cplw	x
5317  0c43               L001:
5318  0c43 97            	ld	xl,a
5319  0c44 72b0000e      	subw	x,_ee_tsign
5320  0c48 cd0000        	call	c_itolx
5322  0c4b 96            	ldw	x,sp
5323  0c4c 1c0005        	addw	x,#OFST-3
5324  0c4f cd0000        	call	c_rtol
5326                     ; 1327 temp_SL*=1000L;
5328  0c52 ae03e8        	ldw	x,#1000
5329  0c55 bf02          	ldw	c_lreg+2,x
5330  0c57 ae0000        	ldw	x,#0
5331  0c5a bf00          	ldw	c_lreg,x
5332  0c5c 96            	ldw	x,sp
5333  0c5d 1c0005        	addw	x,#OFST-3
5334  0c60 cd0000        	call	c_lgmul
5336                     ; 1328 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5338  0c63 ce0010        	ldw	x,_ee_tmax
5339  0c66 72b0000e      	subw	x,_ee_tsign
5340  0c6a cd0000        	call	c_itolx
5342  0c6d 96            	ldw	x,sp
5343  0c6e 1c0001        	addw	x,#OFST-7
5344  0c71 cd0000        	call	c_rtol
5346  0c74 96            	ldw	x,sp
5347  0c75 1c0005        	addw	x,#OFST-3
5348  0c78 cd0000        	call	c_ltor
5350  0c7b 96            	ldw	x,sp
5351  0c7c 1c0001        	addw	x,#OFST-7
5352  0c7f cd0000        	call	c_ldiv
5354  0c82 96            	ldw	x,sp
5355  0c83 1c0005        	addw	x,#OFST-3
5356  0c86 cd0000        	call	c_rtol
5358                     ; 1330 vol_i_temp_avar=(unsigned short)temp_SL; 
5360  0c89 1e07          	ldw	x,(OFST-1,sp)
5361  0c8b bf06          	ldw	_vol_i_temp_avar,x
5362                     ; 1332 debug_info_to_uku[0]=pwm_u;
5364  0c8d be08          	ldw	x,_pwm_u
5365  0c8f bf01          	ldw	_debug_info_to_uku,x
5366                     ; 1333 debug_info_to_uku[1]=vol_i_temp;
5368  0c91 be63          	ldw	x,_vol_i_temp
5369  0c93 bf03          	ldw	_debug_info_to_uku+2,x
5370                     ; 1336 Ufade=(I-150)/10;
5372  0c95 ce001a        	ldw	x,_I
5373  0c98 1d0096        	subw	x,#150
5374  0c9b a60a          	ld	a,#10
5375  0c9d cd0000        	call	c_sdivx
5377  0ca0 cf000a        	ldw	_Ufade,x
5378                     ; 1337 if(Ufade<0)Ufade=0;
5380  0ca3 9c            	rvf
5381  0ca4 ce000a        	ldw	x,_Ufade
5382  0ca7 2e04          	jrsge	L7442
5385  0ca9 5f            	clrw	x
5386  0caa cf000a        	ldw	_Ufade,x
5387  0cad               L7442:
5388                     ; 1338 if(Ufade>15)Ufade=15;
5390  0cad 9c            	rvf
5391  0cae ce000a        	ldw	x,_Ufade
5392  0cb1 a30010        	cpw	x,#16
5393  0cb4 2f06          	jrslt	L1542
5396  0cb6 ae000f        	ldw	x,#15
5397  0cb9 cf000a        	ldw	_Ufade,x
5398  0cbc               L1542:
5399                     ; 1339 }
5402  0cbc 5b08          	addw	sp,#8
5403  0cbe 81            	ret
5434                     ; 1342 void temper_drv(void)		//1 Hz
5434                     ; 1343 {
5435                     	switch	.text
5436  0cbf               _temper_drv:
5440                     ; 1345 if(T>ee_tsign) tsign_cnt++;
5442  0cbf 9c            	rvf
5443  0cc0 5f            	clrw	x
5444  0cc1 b675          	ld	a,_T
5445  0cc3 2a01          	jrpl	L401
5446  0cc5 53            	cplw	x
5447  0cc6               L401:
5448  0cc6 97            	ld	xl,a
5449  0cc7 c3000e        	cpw	x,_ee_tsign
5450  0cca 2d09          	jrsle	L3642
5453  0ccc be5c          	ldw	x,_tsign_cnt
5454  0cce 1c0001        	addw	x,#1
5455  0cd1 bf5c          	ldw	_tsign_cnt,x
5457  0cd3 201d          	jra	L5642
5458  0cd5               L3642:
5459                     ; 1346 else if (T<(ee_tsign-1)) tsign_cnt--;
5461  0cd5 9c            	rvf
5462  0cd6 ce000e        	ldw	x,_ee_tsign
5463  0cd9 5a            	decw	x
5464  0cda 905f          	clrw	y
5465  0cdc b675          	ld	a,_T
5466  0cde 2a02          	jrpl	L601
5467  0ce0 9053          	cplw	y
5468  0ce2               L601:
5469  0ce2 9097          	ld	yl,a
5470  0ce4 90bf00        	ldw	c_y,y
5471  0ce7 b300          	cpw	x,c_y
5472  0ce9 2d07          	jrsle	L5642
5475  0ceb be5c          	ldw	x,_tsign_cnt
5476  0ced 1d0001        	subw	x,#1
5477  0cf0 bf5c          	ldw	_tsign_cnt,x
5478  0cf2               L5642:
5479                     ; 1348 gran(&tsign_cnt,0,60);
5481  0cf2 ae003c        	ldw	x,#60
5482  0cf5 89            	pushw	x
5483  0cf6 5f            	clrw	x
5484  0cf7 89            	pushw	x
5485  0cf8 ae005c        	ldw	x,#_tsign_cnt
5486  0cfb cd00d5        	call	_gran
5488  0cfe 5b04          	addw	sp,#4
5489                     ; 1350 if(tsign_cnt>=55)
5491  0d00 9c            	rvf
5492  0d01 be5c          	ldw	x,_tsign_cnt
5493  0d03 a30037        	cpw	x,#55
5494  0d06 2f16          	jrslt	L1742
5495                     ; 1352 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5497  0d08 3d55          	tnz	_jp_mode
5498  0d0a 2606          	jrne	L7742
5500  0d0c b605          	ld	a,_flags
5501  0d0e a540          	bcp	a,#64
5502  0d10 2706          	jreq	L5742
5503  0d12               L7742:
5505  0d12 b655          	ld	a,_jp_mode
5506  0d14 a103          	cp	a,#3
5507  0d16 2612          	jrne	L1052
5508  0d18               L5742:
5511  0d18 72140005      	bset	_flags,#2
5512  0d1c 200c          	jra	L1052
5513  0d1e               L1742:
5514                     ; 1354 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5516  0d1e 9c            	rvf
5517  0d1f be5c          	ldw	x,_tsign_cnt
5518  0d21 a30006        	cpw	x,#6
5519  0d24 2e04          	jrsge	L1052
5522  0d26 72150005      	bres	_flags,#2
5523  0d2a               L1052:
5524                     ; 1359 if(T>ee_tmax) tmax_cnt++;
5526  0d2a 9c            	rvf
5527  0d2b 5f            	clrw	x
5528  0d2c b675          	ld	a,_T
5529  0d2e 2a01          	jrpl	L011
5530  0d30 53            	cplw	x
5531  0d31               L011:
5532  0d31 97            	ld	xl,a
5533  0d32 c30010        	cpw	x,_ee_tmax
5534  0d35 2d09          	jrsle	L5052
5537  0d37 be5a          	ldw	x,_tmax_cnt
5538  0d39 1c0001        	addw	x,#1
5539  0d3c bf5a          	ldw	_tmax_cnt,x
5541  0d3e 201d          	jra	L7052
5542  0d40               L5052:
5543                     ; 1360 else if (T<(ee_tmax-1)) tmax_cnt--;
5545  0d40 9c            	rvf
5546  0d41 ce0010        	ldw	x,_ee_tmax
5547  0d44 5a            	decw	x
5548  0d45 905f          	clrw	y
5549  0d47 b675          	ld	a,_T
5550  0d49 2a02          	jrpl	L211
5551  0d4b 9053          	cplw	y
5552  0d4d               L211:
5553  0d4d 9097          	ld	yl,a
5554  0d4f 90bf00        	ldw	c_y,y
5555  0d52 b300          	cpw	x,c_y
5556  0d54 2d07          	jrsle	L7052
5559  0d56 be5a          	ldw	x,_tmax_cnt
5560  0d58 1d0001        	subw	x,#1
5561  0d5b bf5a          	ldw	_tmax_cnt,x
5562  0d5d               L7052:
5563                     ; 1362 gran(&tmax_cnt,0,60);
5565  0d5d ae003c        	ldw	x,#60
5566  0d60 89            	pushw	x
5567  0d61 5f            	clrw	x
5568  0d62 89            	pushw	x
5569  0d63 ae005a        	ldw	x,#_tmax_cnt
5570  0d66 cd00d5        	call	_gran
5572  0d69 5b04          	addw	sp,#4
5573                     ; 1364 if(tmax_cnt>=55)
5575  0d6b 9c            	rvf
5576  0d6c be5a          	ldw	x,_tmax_cnt
5577  0d6e a30037        	cpw	x,#55
5578  0d71 2f16          	jrslt	L3152
5579                     ; 1366 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5581  0d73 3d55          	tnz	_jp_mode
5582  0d75 2606          	jrne	L1252
5584  0d77 b605          	ld	a,_flags
5585  0d79 a540          	bcp	a,#64
5586  0d7b 2706          	jreq	L7152
5587  0d7d               L1252:
5589  0d7d b655          	ld	a,_jp_mode
5590  0d7f a103          	cp	a,#3
5591  0d81 2612          	jrne	L3252
5592  0d83               L7152:
5595  0d83 72120005      	bset	_flags,#1
5596  0d87 200c          	jra	L3252
5597  0d89               L3152:
5598                     ; 1368 else if (tmax_cnt<=5) flags&=0b11111101;
5600  0d89 9c            	rvf
5601  0d8a be5a          	ldw	x,_tmax_cnt
5602  0d8c a30006        	cpw	x,#6
5603  0d8f 2e04          	jrsge	L3252
5606  0d91 72130005      	bres	_flags,#1
5607  0d95               L3252:
5608                     ; 1371 } 
5611  0d95 81            	ret
5653                     ; 1374 void u_drv(void)		//1Hz
5653                     ; 1375 { 
5654                     	switch	.text
5655  0d96               _u_drv:
5657  0d96 89            	pushw	x
5658       00000002      OFST:	set	2
5661                     ; 1376 if(jp_mode!=jp3)
5663  0d97 b655          	ld	a,_jp_mode
5664  0d99 a103          	cp	a,#3
5665  0d9b 2772          	jreq	L5452
5666                     ; 1378 	if(Ui>ee_Umax)umax_cnt++;
5668  0d9d 9c            	rvf
5669  0d9e ce0016        	ldw	x,_Ui
5670  0da1 c30014        	cpw	x,_ee_Umax
5671  0da4 2d09          	jrsle	L7452
5674  0da6 be73          	ldw	x,_umax_cnt
5675  0da8 1c0001        	addw	x,#1
5676  0dab bf73          	ldw	_umax_cnt,x
5678  0dad 2003          	jra	L1552
5679  0daf               L7452:
5680                     ; 1379 	else umax_cnt=0;
5682  0daf 5f            	clrw	x
5683  0db0 bf73          	ldw	_umax_cnt,x
5684  0db2               L1552:
5685                     ; 1380 	gran(&umax_cnt,0,10);
5687  0db2 ae000a        	ldw	x,#10
5688  0db5 89            	pushw	x
5689  0db6 5f            	clrw	x
5690  0db7 89            	pushw	x
5691  0db8 ae0073        	ldw	x,#_umax_cnt
5692  0dbb cd00d5        	call	_gran
5694  0dbe 5b04          	addw	sp,#4
5695                     ; 1381 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5697  0dc0 9c            	rvf
5698  0dc1 be73          	ldw	x,_umax_cnt
5699  0dc3 a3000a        	cpw	x,#10
5700  0dc6 2f04          	jrslt	L3552
5703  0dc8 72160005      	bset	_flags,#3
5704  0dcc               L3552:
5705                     ; 1384 	short Upwm=0;
5707                     ; 1385 	Upwm=(pwm_u/3)-50;
5709  0dcc be08          	ldw	x,_pwm_u
5710  0dce a603          	ld	a,#3
5711  0dd0 cd0000        	call	c_sdivx
5713  0dd3 1d0032        	subw	x,#50
5714  0dd6 1f01          	ldw	(OFST-1,sp),x
5715                     ; 1387 	if((/*((Ui<Un)&&((Un-Ui)>ee_dU)) || */(Ui < Upwm))&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5717  0dd8 9c            	rvf
5718  0dd9 ce0016        	ldw	x,_Ui
5719  0ddc 1301          	cpw	x,(OFST-1,sp)
5720  0dde 2e10          	jrsge	L5552
5722  0de0 c65005        	ld	a,20485
5723  0de3 a504          	bcp	a,#4
5724  0de5 2609          	jrne	L5552
5727  0de7 be71          	ldw	x,_umin_cnt
5728  0de9 1c0001        	addw	x,#1
5729  0dec bf71          	ldw	_umin_cnt,x
5731  0dee 2003          	jra	L7552
5732  0df0               L5552:
5733                     ; 1388 	else umin_cnt=0;
5735  0df0 5f            	clrw	x
5736  0df1 bf71          	ldw	_umin_cnt,x
5737  0df3               L7552:
5738                     ; 1389 	gran(&umin_cnt,0,10);	
5740  0df3 ae000a        	ldw	x,#10
5741  0df6 89            	pushw	x
5742  0df7 5f            	clrw	x
5743  0df8 89            	pushw	x
5744  0df9 ae0071        	ldw	x,#_umin_cnt
5745  0dfc cd00d5        	call	_gran
5747  0dff 5b04          	addw	sp,#4
5748                     ; 1390 	if(umin_cnt>=10)flags|=0b00010000;
5750  0e01 9c            	rvf
5751  0e02 be71          	ldw	x,_umin_cnt
5752  0e04 a3000a        	cpw	x,#10
5753  0e07 2f71          	jrslt	L3652
5756  0e09 72180005      	bset	_flags,#4
5757  0e0d 206b          	jra	L3652
5758  0e0f               L5452:
5759                     ; 1393 else if(jp_mode==jp3)
5761  0e0f b655          	ld	a,_jp_mode
5762  0e11 a103          	cp	a,#3
5763  0e13 2665          	jrne	L3652
5764                     ; 1395 	if(Ui>700)umax_cnt++;
5766  0e15 9c            	rvf
5767  0e16 ce0016        	ldw	x,_Ui
5768  0e19 a302bd        	cpw	x,#701
5769  0e1c 2f09          	jrslt	L7652
5772  0e1e be73          	ldw	x,_umax_cnt
5773  0e20 1c0001        	addw	x,#1
5774  0e23 bf73          	ldw	_umax_cnt,x
5776  0e25 2003          	jra	L1752
5777  0e27               L7652:
5778                     ; 1396 	else umax_cnt=0;
5780  0e27 5f            	clrw	x
5781  0e28 bf73          	ldw	_umax_cnt,x
5782  0e2a               L1752:
5783                     ; 1397 	gran(&umax_cnt,0,10);
5785  0e2a ae000a        	ldw	x,#10
5786  0e2d 89            	pushw	x
5787  0e2e 5f            	clrw	x
5788  0e2f 89            	pushw	x
5789  0e30 ae0073        	ldw	x,#_umax_cnt
5790  0e33 cd00d5        	call	_gran
5792  0e36 5b04          	addw	sp,#4
5793                     ; 1398 	if(umax_cnt>=10)flags|=0b00001000;
5795  0e38 9c            	rvf
5796  0e39 be73          	ldw	x,_umax_cnt
5797  0e3b a3000a        	cpw	x,#10
5798  0e3e 2f04          	jrslt	L3752
5801  0e40 72160005      	bset	_flags,#3
5802  0e44               L3752:
5803                     ; 1401 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5805  0e44 9c            	rvf
5806  0e45 ce0016        	ldw	x,_Ui
5807  0e48 a300c8        	cpw	x,#200
5808  0e4b 2e10          	jrsge	L5752
5810  0e4d c65005        	ld	a,20485
5811  0e50 a504          	bcp	a,#4
5812  0e52 2609          	jrne	L5752
5815  0e54 be71          	ldw	x,_umin_cnt
5816  0e56 1c0001        	addw	x,#1
5817  0e59 bf71          	ldw	_umin_cnt,x
5819  0e5b 2003          	jra	L7752
5820  0e5d               L5752:
5821                     ; 1402 	else umin_cnt=0;
5823  0e5d 5f            	clrw	x
5824  0e5e bf71          	ldw	_umin_cnt,x
5825  0e60               L7752:
5826                     ; 1403 	gran(&umin_cnt,0,10);	
5828  0e60 ae000a        	ldw	x,#10
5829  0e63 89            	pushw	x
5830  0e64 5f            	clrw	x
5831  0e65 89            	pushw	x
5832  0e66 ae0071        	ldw	x,#_umin_cnt
5833  0e69 cd00d5        	call	_gran
5835  0e6c 5b04          	addw	sp,#4
5836                     ; 1404 	if(umin_cnt>=10)flags|=0b00010000;	  
5838  0e6e 9c            	rvf
5839  0e6f be71          	ldw	x,_umin_cnt
5840  0e71 a3000a        	cpw	x,#10
5841  0e74 2f04          	jrslt	L3652
5844  0e76 72180005      	bset	_flags,#4
5845  0e7a               L3652:
5846                     ; 1406 }
5849  0e7a 85            	popw	x
5850  0e7b 81            	ret
5876                     ; 1431 void apv_start(void)
5876                     ; 1432 {
5877                     	switch	.text
5878  0e7c               _apv_start:
5882                     ; 1433 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5884  0e7c 3d50          	tnz	_apv_cnt
5885  0e7e 2624          	jrne	L3162
5887  0e80 3d51          	tnz	_apv_cnt+1
5888  0e82 2620          	jrne	L3162
5890  0e84 3d52          	tnz	_apv_cnt+2
5891  0e86 261c          	jrne	L3162
5893                     	btst	_bAPV
5894  0e8d 2515          	jrult	L3162
5895                     ; 1435 	apv_cnt[0]=60;
5897  0e8f 353c0050      	mov	_apv_cnt,#60
5898                     ; 1436 	apv_cnt[1]=60;
5900  0e93 353c0051      	mov	_apv_cnt+1,#60
5901                     ; 1437 	apv_cnt[2]=60;
5903  0e97 353c0052      	mov	_apv_cnt+2,#60
5904                     ; 1438 	apv_cnt_=3600;
5906  0e9b ae0e10        	ldw	x,#3600
5907  0e9e bf4e          	ldw	_apv_cnt_,x
5908                     ; 1439 	bAPV=1;	
5910  0ea0 72100002      	bset	_bAPV
5911  0ea4               L3162:
5912                     ; 1441 }
5915  0ea4 81            	ret
5941                     ; 1444 void apv_stop(void)
5941                     ; 1445 {
5942                     	switch	.text
5943  0ea5               _apv_stop:
5947                     ; 1446 apv_cnt[0]=0;
5949  0ea5 3f50          	clr	_apv_cnt
5950                     ; 1447 apv_cnt[1]=0;
5952  0ea7 3f51          	clr	_apv_cnt+1
5953                     ; 1448 apv_cnt[2]=0;
5955  0ea9 3f52          	clr	_apv_cnt+2
5956                     ; 1449 apv_cnt_=0;	
5958  0eab 5f            	clrw	x
5959  0eac bf4e          	ldw	_apv_cnt_,x
5960                     ; 1450 bAPV=0;
5962  0eae 72110002      	bres	_bAPV
5963                     ; 1451 }
5966  0eb2 81            	ret
6001                     ; 1455 void apv_hndl(void)
6001                     ; 1456 {
6002                     	switch	.text
6003  0eb3               _apv_hndl:
6007                     ; 1457 if(apv_cnt[0])
6009  0eb3 3d50          	tnz	_apv_cnt
6010  0eb5 271e          	jreq	L5362
6011                     ; 1459 	apv_cnt[0]--;
6013  0eb7 3a50          	dec	_apv_cnt
6014                     ; 1460 	if(apv_cnt[0]==0)
6016  0eb9 3d50          	tnz	_apv_cnt
6017  0ebb 265a          	jrne	L1462
6018                     ; 1462 		flags&=0b11100001;
6020  0ebd b605          	ld	a,_flags
6021  0ebf a4e1          	and	a,#225
6022  0ec1 b705          	ld	_flags,a
6023                     ; 1463 		tsign_cnt=0;
6025  0ec3 5f            	clrw	x
6026  0ec4 bf5c          	ldw	_tsign_cnt,x
6027                     ; 1464 		tmax_cnt=0;
6029  0ec6 5f            	clrw	x
6030  0ec7 bf5a          	ldw	_tmax_cnt,x
6031                     ; 1465 		umax_cnt=0;
6033  0ec9 5f            	clrw	x
6034  0eca bf73          	ldw	_umax_cnt,x
6035                     ; 1466 		umin_cnt=0;
6037  0ecc 5f            	clrw	x
6038  0ecd bf71          	ldw	_umin_cnt,x
6039                     ; 1468 		led_drv_cnt=30;
6041  0ecf 351e0016      	mov	_led_drv_cnt,#30
6042  0ed3 2042          	jra	L1462
6043  0ed5               L5362:
6044                     ; 1471 else if(apv_cnt[1])
6046  0ed5 3d51          	tnz	_apv_cnt+1
6047  0ed7 271e          	jreq	L3462
6048                     ; 1473 	apv_cnt[1]--;
6050  0ed9 3a51          	dec	_apv_cnt+1
6051                     ; 1474 	if(apv_cnt[1]==0)
6053  0edb 3d51          	tnz	_apv_cnt+1
6054  0edd 2638          	jrne	L1462
6055                     ; 1476 		flags&=0b11100001;
6057  0edf b605          	ld	a,_flags
6058  0ee1 a4e1          	and	a,#225
6059  0ee3 b705          	ld	_flags,a
6060                     ; 1477 		tsign_cnt=0;
6062  0ee5 5f            	clrw	x
6063  0ee6 bf5c          	ldw	_tsign_cnt,x
6064                     ; 1478 		tmax_cnt=0;
6066  0ee8 5f            	clrw	x
6067  0ee9 bf5a          	ldw	_tmax_cnt,x
6068                     ; 1479 		umax_cnt=0;
6070  0eeb 5f            	clrw	x
6071  0eec bf73          	ldw	_umax_cnt,x
6072                     ; 1480 		umin_cnt=0;
6074  0eee 5f            	clrw	x
6075  0eef bf71          	ldw	_umin_cnt,x
6076                     ; 1482 		led_drv_cnt=30;
6078  0ef1 351e0016      	mov	_led_drv_cnt,#30
6079  0ef5 2020          	jra	L1462
6080  0ef7               L3462:
6081                     ; 1485 else if(apv_cnt[2])
6083  0ef7 3d52          	tnz	_apv_cnt+2
6084  0ef9 271c          	jreq	L1462
6085                     ; 1487 	apv_cnt[2]--;
6087  0efb 3a52          	dec	_apv_cnt+2
6088                     ; 1488 	if(apv_cnt[2]==0)
6090  0efd 3d52          	tnz	_apv_cnt+2
6091  0eff 2616          	jrne	L1462
6092                     ; 1490 		flags&=0b11100001;
6094  0f01 b605          	ld	a,_flags
6095  0f03 a4e1          	and	a,#225
6096  0f05 b705          	ld	_flags,a
6097                     ; 1491 		tsign_cnt=0;
6099  0f07 5f            	clrw	x
6100  0f08 bf5c          	ldw	_tsign_cnt,x
6101                     ; 1492 		tmax_cnt=0;
6103  0f0a 5f            	clrw	x
6104  0f0b bf5a          	ldw	_tmax_cnt,x
6105                     ; 1493 		umax_cnt=0;
6107  0f0d 5f            	clrw	x
6108  0f0e bf73          	ldw	_umax_cnt,x
6109                     ; 1494 		umin_cnt=0;          
6111  0f10 5f            	clrw	x
6112  0f11 bf71          	ldw	_umin_cnt,x
6113                     ; 1496 		led_drv_cnt=30;
6115  0f13 351e0016      	mov	_led_drv_cnt,#30
6116  0f17               L1462:
6117                     ; 1500 if(apv_cnt_)
6119  0f17 be4e          	ldw	x,_apv_cnt_
6120  0f19 2712          	jreq	L5562
6121                     ; 1502 	apv_cnt_--;
6123  0f1b be4e          	ldw	x,_apv_cnt_
6124  0f1d 1d0001        	subw	x,#1
6125  0f20 bf4e          	ldw	_apv_cnt_,x
6126                     ; 1503 	if(apv_cnt_==0) 
6128  0f22 be4e          	ldw	x,_apv_cnt_
6129  0f24 2607          	jrne	L5562
6130                     ; 1505 		bAPV=0;
6132  0f26 72110002      	bres	_bAPV
6133                     ; 1506 		apv_start();
6135  0f2a cd0e7c        	call	_apv_start
6137  0f2d               L5562:
6138                     ; 1510 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6140  0f2d be71          	ldw	x,_umin_cnt
6141  0f2f 261e          	jrne	L1662
6143  0f31 be73          	ldw	x,_umax_cnt
6144  0f33 261a          	jrne	L1662
6146  0f35 c65005        	ld	a,20485
6147  0f38 a504          	bcp	a,#4
6148  0f3a 2613          	jrne	L1662
6149                     ; 1512 	if(cnt_apv_off<20)
6151  0f3c b64d          	ld	a,_cnt_apv_off
6152  0f3e a114          	cp	a,#20
6153  0f40 240f          	jruge	L7662
6154                     ; 1514 		cnt_apv_off++;
6156  0f42 3c4d          	inc	_cnt_apv_off
6157                     ; 1515 		if(cnt_apv_off>=20)
6159  0f44 b64d          	ld	a,_cnt_apv_off
6160  0f46 a114          	cp	a,#20
6161  0f48 2507          	jrult	L7662
6162                     ; 1517 			apv_stop();
6164  0f4a cd0ea5        	call	_apv_stop
6166  0f4d 2002          	jra	L7662
6167  0f4f               L1662:
6168                     ; 1521 else cnt_apv_off=0;	
6170  0f4f 3f4d          	clr	_cnt_apv_off
6171  0f51               L7662:
6172                     ; 1523 }
6175  0f51 81            	ret
6178                     	switch	.ubsct
6179  0000               L1762_flags_old:
6180  0000 00            	ds.b	1
6216                     ; 1526 void flags_drv(void)
6216                     ; 1527 {
6217                     	switch	.text
6218  0f52               _flags_drv:
6222                     ; 1529 if(jp_mode!=jp3) 
6224  0f52 b655          	ld	a,_jp_mode
6225  0f54 a103          	cp	a,#3
6226  0f56 2723          	jreq	L1172
6227                     ; 1531 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6229  0f58 b605          	ld	a,_flags
6230  0f5a a508          	bcp	a,#8
6231  0f5c 2706          	jreq	L7172
6233  0f5e b600          	ld	a,L1762_flags_old
6234  0f60 a508          	bcp	a,#8
6235  0f62 270c          	jreq	L5172
6236  0f64               L7172:
6238  0f64 b605          	ld	a,_flags
6239  0f66 a510          	bcp	a,#16
6240  0f68 2726          	jreq	L3272
6242  0f6a b600          	ld	a,L1762_flags_old
6243  0f6c a510          	bcp	a,#16
6244  0f6e 2620          	jrne	L3272
6245  0f70               L5172:
6246                     ; 1533     		if(link==OFF)apv_start();
6248  0f70 b670          	ld	a,_link
6249  0f72 a1aa          	cp	a,#170
6250  0f74 261a          	jrne	L3272
6253  0f76 cd0e7c        	call	_apv_start
6255  0f79 2015          	jra	L3272
6256  0f7b               L1172:
6257                     ; 1536 else if(jp_mode==jp3) 
6259  0f7b b655          	ld	a,_jp_mode
6260  0f7d a103          	cp	a,#3
6261  0f7f 260f          	jrne	L3272
6262                     ; 1538 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6264  0f81 b605          	ld	a,_flags
6265  0f83 a508          	bcp	a,#8
6266  0f85 2709          	jreq	L3272
6268  0f87 b600          	ld	a,L1762_flags_old
6269  0f89 a508          	bcp	a,#8
6270  0f8b 2603          	jrne	L3272
6271                     ; 1540     		apv_start();
6273  0f8d cd0e7c        	call	_apv_start
6275  0f90               L3272:
6276                     ; 1543 flags_old=flags;
6278  0f90 450500        	mov	L1762_flags_old,_flags
6279                     ; 1545 } 
6282  0f93 81            	ret
6317                     ; 1682 void adr_drv_v4(char in)
6317                     ; 1683 {
6318                     	switch	.text
6319  0f94               _adr_drv_v4:
6323                     ; 1684 if(adress!=in)adress=in;
6325  0f94 c10101        	cp	a,_adress
6326  0f97 2703          	jreq	L7472
6329  0f99 c70101        	ld	_adress,a
6330  0f9c               L7472:
6331                     ; 1685 }
6334  0f9c 81            	ret
6363                     ; 1688 void adr_drv_v3(void)
6363                     ; 1689 {
6364                     	switch	.text
6365  0f9d               _adr_drv_v3:
6367  0f9d 88            	push	a
6368       00000001      OFST:	set	1
6371                     ; 1695 GPIOB->DDR&=~(1<<0);
6373  0f9e 72115007      	bres	20487,#0
6374                     ; 1696 GPIOB->CR1&=~(1<<0);
6376  0fa2 72115008      	bres	20488,#0
6377                     ; 1697 GPIOB->CR2&=~(1<<0);
6379  0fa6 72115009      	bres	20489,#0
6380                     ; 1698 ADC2->CR2=0x08;
6382  0faa 35085402      	mov	21506,#8
6383                     ; 1699 ADC2->CR1=0x40;
6385  0fae 35405401      	mov	21505,#64
6386                     ; 1700 ADC2->CSR=0x20+0;
6388  0fb2 35205400      	mov	21504,#32
6389                     ; 1701 ADC2->CR1|=1;
6391  0fb6 72105401      	bset	21505,#0
6392                     ; 1702 ADC2->CR1|=1;
6394  0fba 72105401      	bset	21505,#0
6395                     ; 1703 adr_drv_stat=1;
6397  0fbe 35010002      	mov	_adr_drv_stat,#1
6398  0fc2               L1672:
6399                     ; 1704 while(adr_drv_stat==1);
6402  0fc2 b602          	ld	a,_adr_drv_stat
6403  0fc4 a101          	cp	a,#1
6404  0fc6 27fa          	jreq	L1672
6405                     ; 1706 GPIOB->DDR&=~(1<<1);
6407  0fc8 72135007      	bres	20487,#1
6408                     ; 1707 GPIOB->CR1&=~(1<<1);
6410  0fcc 72135008      	bres	20488,#1
6411                     ; 1708 GPIOB->CR2&=~(1<<1);
6413  0fd0 72135009      	bres	20489,#1
6414                     ; 1709 ADC2->CR2=0x08;
6416  0fd4 35085402      	mov	21506,#8
6417                     ; 1710 ADC2->CR1=0x40;
6419  0fd8 35405401      	mov	21505,#64
6420                     ; 1711 ADC2->CSR=0x20+1;
6422  0fdc 35215400      	mov	21504,#33
6423                     ; 1712 ADC2->CR1|=1;
6425  0fe0 72105401      	bset	21505,#0
6426                     ; 1713 ADC2->CR1|=1;
6428  0fe4 72105401      	bset	21505,#0
6429                     ; 1714 adr_drv_stat=3;
6431  0fe8 35030002      	mov	_adr_drv_stat,#3
6432  0fec               L7672:
6433                     ; 1715 while(adr_drv_stat==3);
6436  0fec b602          	ld	a,_adr_drv_stat
6437  0fee a103          	cp	a,#3
6438  0ff0 27fa          	jreq	L7672
6439                     ; 1717 GPIOE->DDR&=~(1<<6);
6441  0ff2 721d5016      	bres	20502,#6
6442                     ; 1718 GPIOE->CR1&=~(1<<6);
6444  0ff6 721d5017      	bres	20503,#6
6445                     ; 1719 GPIOE->CR2&=~(1<<6);
6447  0ffa 721d5018      	bres	20504,#6
6448                     ; 1720 ADC2->CR2=0x08;
6450  0ffe 35085402      	mov	21506,#8
6451                     ; 1721 ADC2->CR1=0x40;
6453  1002 35405401      	mov	21505,#64
6454                     ; 1722 ADC2->CSR=0x20+9;
6456  1006 35295400      	mov	21504,#41
6457                     ; 1723 ADC2->CR1|=1;
6459  100a 72105401      	bset	21505,#0
6460                     ; 1724 ADC2->CR1|=1;
6462  100e 72105401      	bset	21505,#0
6463                     ; 1725 adr_drv_stat=5;
6465  1012 35050002      	mov	_adr_drv_stat,#5
6466  1016               L5772:
6467                     ; 1726 while(adr_drv_stat==5);
6470  1016 b602          	ld	a,_adr_drv_stat
6471  1018 a105          	cp	a,#5
6472  101a 27fa          	jreq	L5772
6473                     ; 1730 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6475  101c 9c            	rvf
6476  101d ce0109        	ldw	x,_adc_buff_
6477  1020 a3022a        	cpw	x,#554
6478  1023 2f0f          	jrslt	L3003
6480  1025 9c            	rvf
6481  1026 ce0109        	ldw	x,_adc_buff_
6482  1029 a30253        	cpw	x,#595
6483  102c 2e06          	jrsge	L3003
6486  102e 725f0102      	clr	_adr
6488  1032 204c          	jra	L5003
6489  1034               L3003:
6490                     ; 1731 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6492  1034 9c            	rvf
6493  1035 ce0109        	ldw	x,_adc_buff_
6494  1038 a3036d        	cpw	x,#877
6495  103b 2f0f          	jrslt	L7003
6497  103d 9c            	rvf
6498  103e ce0109        	ldw	x,_adc_buff_
6499  1041 a30396        	cpw	x,#918
6500  1044 2e06          	jrsge	L7003
6503  1046 35010102      	mov	_adr,#1
6505  104a 2034          	jra	L5003
6506  104c               L7003:
6507                     ; 1732 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6509  104c 9c            	rvf
6510  104d ce0109        	ldw	x,_adc_buff_
6511  1050 a302a3        	cpw	x,#675
6512  1053 2f0f          	jrslt	L3103
6514  1055 9c            	rvf
6515  1056 ce0109        	ldw	x,_adc_buff_
6516  1059 a302cc        	cpw	x,#716
6517  105c 2e06          	jrsge	L3103
6520  105e 35020102      	mov	_adr,#2
6522  1062 201c          	jra	L5003
6523  1064               L3103:
6524                     ; 1733 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6526  1064 9c            	rvf
6527  1065 ce0109        	ldw	x,_adc_buff_
6528  1068 a303e3        	cpw	x,#995
6529  106b 2f0f          	jrslt	L7103
6531  106d 9c            	rvf
6532  106e ce0109        	ldw	x,_adc_buff_
6533  1071 a3040c        	cpw	x,#1036
6534  1074 2e06          	jrsge	L7103
6537  1076 35030102      	mov	_adr,#3
6539  107a 2004          	jra	L5003
6540  107c               L7103:
6541                     ; 1734 else adr[0]=5;
6543  107c 35050102      	mov	_adr,#5
6544  1080               L5003:
6545                     ; 1736 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6547  1080 9c            	rvf
6548  1081 ce010b        	ldw	x,_adc_buff_+2
6549  1084 a3022a        	cpw	x,#554
6550  1087 2f0f          	jrslt	L3203
6552  1089 9c            	rvf
6553  108a ce010b        	ldw	x,_adc_buff_+2
6554  108d a30253        	cpw	x,#595
6555  1090 2e06          	jrsge	L3203
6558  1092 725f0103      	clr	_adr+1
6560  1096 204c          	jra	L5203
6561  1098               L3203:
6562                     ; 1737 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6564  1098 9c            	rvf
6565  1099 ce010b        	ldw	x,_adc_buff_+2
6566  109c a3036d        	cpw	x,#877
6567  109f 2f0f          	jrslt	L7203
6569  10a1 9c            	rvf
6570  10a2 ce010b        	ldw	x,_adc_buff_+2
6571  10a5 a30396        	cpw	x,#918
6572  10a8 2e06          	jrsge	L7203
6575  10aa 35010103      	mov	_adr+1,#1
6577  10ae 2034          	jra	L5203
6578  10b0               L7203:
6579                     ; 1738 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6581  10b0 9c            	rvf
6582  10b1 ce010b        	ldw	x,_adc_buff_+2
6583  10b4 a302a3        	cpw	x,#675
6584  10b7 2f0f          	jrslt	L3303
6586  10b9 9c            	rvf
6587  10ba ce010b        	ldw	x,_adc_buff_+2
6588  10bd a302cc        	cpw	x,#716
6589  10c0 2e06          	jrsge	L3303
6592  10c2 35020103      	mov	_adr+1,#2
6594  10c6 201c          	jra	L5203
6595  10c8               L3303:
6596                     ; 1739 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6598  10c8 9c            	rvf
6599  10c9 ce010b        	ldw	x,_adc_buff_+2
6600  10cc a303e3        	cpw	x,#995
6601  10cf 2f0f          	jrslt	L7303
6603  10d1 9c            	rvf
6604  10d2 ce010b        	ldw	x,_adc_buff_+2
6605  10d5 a3040c        	cpw	x,#1036
6606  10d8 2e06          	jrsge	L7303
6609  10da 35030103      	mov	_adr+1,#3
6611  10de 2004          	jra	L5203
6612  10e0               L7303:
6613                     ; 1740 else adr[1]=5;
6615  10e0 35050103      	mov	_adr+1,#5
6616  10e4               L5203:
6617                     ; 1742 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6619  10e4 9c            	rvf
6620  10e5 ce011b        	ldw	x,_adc_buff_+18
6621  10e8 a3022a        	cpw	x,#554
6622  10eb 2f0f          	jrslt	L3403
6624  10ed 9c            	rvf
6625  10ee ce011b        	ldw	x,_adc_buff_+18
6626  10f1 a30253        	cpw	x,#595
6627  10f4 2e06          	jrsge	L3403
6630  10f6 725f0104      	clr	_adr+2
6632  10fa 204c          	jra	L5403
6633  10fc               L3403:
6634                     ; 1743 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6636  10fc 9c            	rvf
6637  10fd ce011b        	ldw	x,_adc_buff_+18
6638  1100 a3036d        	cpw	x,#877
6639  1103 2f0f          	jrslt	L7403
6641  1105 9c            	rvf
6642  1106 ce011b        	ldw	x,_adc_buff_+18
6643  1109 a30396        	cpw	x,#918
6644  110c 2e06          	jrsge	L7403
6647  110e 35010104      	mov	_adr+2,#1
6649  1112 2034          	jra	L5403
6650  1114               L7403:
6651                     ; 1744 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6653  1114 9c            	rvf
6654  1115 ce011b        	ldw	x,_adc_buff_+18
6655  1118 a302a3        	cpw	x,#675
6656  111b 2f0f          	jrslt	L3503
6658  111d 9c            	rvf
6659  111e ce011b        	ldw	x,_adc_buff_+18
6660  1121 a302cc        	cpw	x,#716
6661  1124 2e06          	jrsge	L3503
6664  1126 35020104      	mov	_adr+2,#2
6666  112a 201c          	jra	L5403
6667  112c               L3503:
6668                     ; 1745 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6670  112c 9c            	rvf
6671  112d ce011b        	ldw	x,_adc_buff_+18
6672  1130 a303e3        	cpw	x,#995
6673  1133 2f0f          	jrslt	L7503
6675  1135 9c            	rvf
6676  1136 ce011b        	ldw	x,_adc_buff_+18
6677  1139 a3040c        	cpw	x,#1036
6678  113c 2e06          	jrsge	L7503
6681  113e 35030104      	mov	_adr+2,#3
6683  1142 2004          	jra	L5403
6684  1144               L7503:
6685                     ; 1746 else adr[2]=5;
6687  1144 35050104      	mov	_adr+2,#5
6688  1148               L5403:
6689                     ; 1750 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6691  1148 c60102        	ld	a,_adr
6692  114b a105          	cp	a,#5
6693  114d 270e          	jreq	L5603
6695  114f c60103        	ld	a,_adr+1
6696  1152 a105          	cp	a,#5
6697  1154 2707          	jreq	L5603
6699  1156 c60104        	ld	a,_adr+2
6700  1159 a105          	cp	a,#5
6701  115b 2606          	jrne	L3603
6702  115d               L5603:
6703                     ; 1753 	adress_error=1;
6705  115d 35010100      	mov	_adress_error,#1
6707  1161               L1703:
6708                     ; 1764 }
6711  1161 84            	pop	a
6712  1162 81            	ret
6713  1163               L3603:
6714                     ; 1757 	if(adr[2]&0x02) bps_class=bpsIPS;
6716  1163 c60104        	ld	a,_adr+2
6717  1166 a502          	bcp	a,#2
6718  1168 2706          	jreq	L3703
6721  116a 3501000b      	mov	_bps_class,#1
6723  116e 2002          	jra	L5703
6724  1170               L3703:
6725                     ; 1758 	else bps_class=bpsIBEP;
6727  1170 3f0b          	clr	_bps_class
6728  1172               L5703:
6729                     ; 1760 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6731  1172 c60104        	ld	a,_adr+2
6732  1175 a401          	and	a,#1
6733  1177 97            	ld	xl,a
6734  1178 a610          	ld	a,#16
6735  117a 42            	mul	x,a
6736  117b 9f            	ld	a,xl
6737  117c 6b01          	ld	(OFST+0,sp),a
6738  117e c60103        	ld	a,_adr+1
6739  1181 48            	sll	a
6740  1182 48            	sll	a
6741  1183 cb0102        	add	a,_adr
6742  1186 1b01          	add	a,(OFST+0,sp)
6743  1188 c70101        	ld	_adress,a
6744  118b 20d4          	jra	L1703
6767                     ; 1814 void init_CAN(void) {
6768                     	switch	.text
6769  118d               _init_CAN:
6773                     ; 1815 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6775  118d 72135420      	bres	21536,#1
6776                     ; 1816 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6778  1191 72105420      	bset	21536,#0
6780  1195               L1113:
6781                     ; 1817 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6783  1195 c65421        	ld	a,21537
6784  1198 a501          	bcp	a,#1
6785  119a 27f9          	jreq	L1113
6786                     ; 1819 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6788  119c 72185420      	bset	21536,#4
6789                     ; 1821 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6791  11a0 35025427      	mov	21543,#2
6792                     ; 1830 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6794  11a4 35135428      	mov	21544,#19
6795                     ; 1831 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6797  11a8 35c05429      	mov	21545,#192
6798                     ; 1832 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6800  11ac 357f542c      	mov	21548,#127
6801                     ; 1833 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6803  11b0 35e0542d      	mov	21549,#224
6804                     ; 1835 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6806  11b4 35315430      	mov	21552,#49
6807                     ; 1836 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6809  11b8 35c05431      	mov	21553,#192
6810                     ; 1837 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6812  11bc 357f5434      	mov	21556,#127
6813                     ; 1838 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6815  11c0 35e05435      	mov	21557,#224
6816                     ; 1842 	CAN->PSR= 6;									// set page 6
6818  11c4 35065427      	mov	21543,#6
6819                     ; 1847 	CAN->Page.Config.FMR1&=~3;								//mask mode
6821  11c8 c65430        	ld	a,21552
6822  11cb a4fc          	and	a,#252
6823  11cd c75430        	ld	21552,a
6824                     ; 1853 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6826  11d0 35065432      	mov	21554,#6
6827                     ; 1854 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6829  11d4 35605432      	mov	21554,#96
6830                     ; 1857 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6832  11d8 72105432      	bset	21554,#0
6833                     ; 1858 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6835  11dc 72185432      	bset	21554,#4
6836                     ; 1861 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6838  11e0 35065427      	mov	21543,#6
6839                     ; 1863 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6841  11e4 35d3542c      	mov	21548,#211
6842                     ; 1864 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6844  11e8 35e7542d      	mov	21549,#231
6845                     ; 1866 	CAN->IER|=(1<<1);
6847  11ec 72125425      	bset	21541,#1
6848                     ; 1869 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6850  11f0 72115420      	bres	21536,#0
6852  11f4               L7113:
6853                     ; 1870 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6855  11f4 c65421        	ld	a,21537
6856  11f7 a501          	bcp	a,#1
6857  11f9 26f9          	jrne	L7113
6858                     ; 1871 }
6861  11fb 81            	ret
6969                     ; 1874 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6969                     ; 1875 {
6970                     	switch	.text
6971  11fc               _can_transmit:
6973  11fc 89            	pushw	x
6974       00000000      OFST:	set	0
6977                     ; 1877 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6979  11fd b679          	ld	a,_can_buff_wr_ptr
6980  11ff a104          	cp	a,#4
6981  1201 2502          	jrult	L1023
6984  1203 3f79          	clr	_can_buff_wr_ptr
6985  1205               L1023:
6986                     ; 1879 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6988  1205 b679          	ld	a,_can_buff_wr_ptr
6989  1207 97            	ld	xl,a
6990  1208 a610          	ld	a,#16
6991  120a 42            	mul	x,a
6992  120b 1601          	ldw	y,(OFST+1,sp)
6993  120d a606          	ld	a,#6
6994  120f               L631:
6995  120f 9054          	srlw	y
6996  1211 4a            	dec	a
6997  1212 26fb          	jrne	L631
6998  1214 909f          	ld	a,yl
6999  1216 e77a          	ld	(_can_out_buff,x),a
7000                     ; 1880 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7002  1218 b679          	ld	a,_can_buff_wr_ptr
7003  121a 97            	ld	xl,a
7004  121b a610          	ld	a,#16
7005  121d 42            	mul	x,a
7006  121e 7b02          	ld	a,(OFST+2,sp)
7007  1220 48            	sll	a
7008  1221 48            	sll	a
7009  1222 e77b          	ld	(_can_out_buff+1,x),a
7010                     ; 1882 can_out_buff[can_buff_wr_ptr][2]=data0;
7012  1224 b679          	ld	a,_can_buff_wr_ptr
7013  1226 97            	ld	xl,a
7014  1227 a610          	ld	a,#16
7015  1229 42            	mul	x,a
7016  122a 7b05          	ld	a,(OFST+5,sp)
7017  122c e77c          	ld	(_can_out_buff+2,x),a
7018                     ; 1883 can_out_buff[can_buff_wr_ptr][3]=data1;
7020  122e b679          	ld	a,_can_buff_wr_ptr
7021  1230 97            	ld	xl,a
7022  1231 a610          	ld	a,#16
7023  1233 42            	mul	x,a
7024  1234 7b06          	ld	a,(OFST+6,sp)
7025  1236 e77d          	ld	(_can_out_buff+3,x),a
7026                     ; 1884 can_out_buff[can_buff_wr_ptr][4]=data2;
7028  1238 b679          	ld	a,_can_buff_wr_ptr
7029  123a 97            	ld	xl,a
7030  123b a610          	ld	a,#16
7031  123d 42            	mul	x,a
7032  123e 7b07          	ld	a,(OFST+7,sp)
7033  1240 e77e          	ld	(_can_out_buff+4,x),a
7034                     ; 1885 can_out_buff[can_buff_wr_ptr][5]=data3;
7036  1242 b679          	ld	a,_can_buff_wr_ptr
7037  1244 97            	ld	xl,a
7038  1245 a610          	ld	a,#16
7039  1247 42            	mul	x,a
7040  1248 7b08          	ld	a,(OFST+8,sp)
7041  124a e77f          	ld	(_can_out_buff+5,x),a
7042                     ; 1886 can_out_buff[can_buff_wr_ptr][6]=data4;
7044  124c b679          	ld	a,_can_buff_wr_ptr
7045  124e 97            	ld	xl,a
7046  124f a610          	ld	a,#16
7047  1251 42            	mul	x,a
7048  1252 7b09          	ld	a,(OFST+9,sp)
7049  1254 e780          	ld	(_can_out_buff+6,x),a
7050                     ; 1887 can_out_buff[can_buff_wr_ptr][7]=data5;
7052  1256 b679          	ld	a,_can_buff_wr_ptr
7053  1258 97            	ld	xl,a
7054  1259 a610          	ld	a,#16
7055  125b 42            	mul	x,a
7056  125c 7b0a          	ld	a,(OFST+10,sp)
7057  125e e781          	ld	(_can_out_buff+7,x),a
7058                     ; 1888 can_out_buff[can_buff_wr_ptr][8]=data6;
7060  1260 b679          	ld	a,_can_buff_wr_ptr
7061  1262 97            	ld	xl,a
7062  1263 a610          	ld	a,#16
7063  1265 42            	mul	x,a
7064  1266 7b0b          	ld	a,(OFST+11,sp)
7065  1268 e782          	ld	(_can_out_buff+8,x),a
7066                     ; 1889 can_out_buff[can_buff_wr_ptr][9]=data7;
7068  126a b679          	ld	a,_can_buff_wr_ptr
7069  126c 97            	ld	xl,a
7070  126d a610          	ld	a,#16
7071  126f 42            	mul	x,a
7072  1270 7b0c          	ld	a,(OFST+12,sp)
7073  1272 e783          	ld	(_can_out_buff+9,x),a
7074                     ; 1891 can_buff_wr_ptr++;
7076  1274 3c79          	inc	_can_buff_wr_ptr
7077                     ; 1892 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7079  1276 b679          	ld	a,_can_buff_wr_ptr
7080  1278 a104          	cp	a,#4
7081  127a 2502          	jrult	L3023
7084  127c 3f79          	clr	_can_buff_wr_ptr
7085  127e               L3023:
7086                     ; 1893 } 
7089  127e 85            	popw	x
7090  127f 81            	ret
7119                     ; 1896 void can_tx_hndl(void)
7119                     ; 1897 {
7120                     	switch	.text
7121  1280               _can_tx_hndl:
7125                     ; 1898 if(bTX_FREE)
7127  1280 3d03          	tnz	_bTX_FREE
7128  1282 2757          	jreq	L5123
7129                     ; 1900 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7131  1284 b678          	ld	a,_can_buff_rd_ptr
7132  1286 b179          	cp	a,_can_buff_wr_ptr
7133  1288 275f          	jreq	L3223
7134                     ; 1902 		bTX_FREE=0;
7136  128a 3f03          	clr	_bTX_FREE
7137                     ; 1904 		CAN->PSR= 0;
7139  128c 725f5427      	clr	21543
7140                     ; 1905 		CAN->Page.TxMailbox.MDLCR=8;
7142  1290 35085429      	mov	21545,#8
7143                     ; 1906 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7145  1294 b678          	ld	a,_can_buff_rd_ptr
7146  1296 97            	ld	xl,a
7147  1297 a610          	ld	a,#16
7148  1299 42            	mul	x,a
7149  129a e67a          	ld	a,(_can_out_buff,x)
7150  129c c7542a        	ld	21546,a
7151                     ; 1907 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7153  129f b678          	ld	a,_can_buff_rd_ptr
7154  12a1 97            	ld	xl,a
7155  12a2 a610          	ld	a,#16
7156  12a4 42            	mul	x,a
7157  12a5 e67b          	ld	a,(_can_out_buff+1,x)
7158  12a7 c7542b        	ld	21547,a
7159                     ; 1909 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7161  12aa b678          	ld	a,_can_buff_rd_ptr
7162  12ac 97            	ld	xl,a
7163  12ad a610          	ld	a,#16
7164  12af 42            	mul	x,a
7165  12b0 01            	rrwa	x,a
7166  12b1 ab7c          	add	a,#_can_out_buff+2
7167  12b3 2401          	jrnc	L241
7168  12b5 5c            	incw	x
7169  12b6               L241:
7170  12b6 5f            	clrw	x
7171  12b7 97            	ld	xl,a
7172  12b8 bf00          	ldw	c_x,x
7173  12ba ae0008        	ldw	x,#8
7174  12bd               L441:
7175  12bd 5a            	decw	x
7176  12be 92d600        	ld	a,([c_x],x)
7177  12c1 d7542e        	ld	(21550,x),a
7178  12c4 5d            	tnzw	x
7179  12c5 26f6          	jrne	L441
7180                     ; 1911 		can_buff_rd_ptr++;
7182  12c7 3c78          	inc	_can_buff_rd_ptr
7183                     ; 1912 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7185  12c9 b678          	ld	a,_can_buff_rd_ptr
7186  12cb a104          	cp	a,#4
7187  12cd 2502          	jrult	L1223
7190  12cf 3f78          	clr	_can_buff_rd_ptr
7191  12d1               L1223:
7192                     ; 1914 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7194  12d1 72105428      	bset	21544,#0
7195                     ; 1915 		CAN->IER|=(1<<0);
7197  12d5 72105425      	bset	21541,#0
7198  12d9 200e          	jra	L3223
7199  12db               L5123:
7200                     ; 1920 	tx_busy_cnt++;
7202  12db 3c77          	inc	_tx_busy_cnt
7203                     ; 1921 	if(tx_busy_cnt>=100)
7205  12dd b677          	ld	a,_tx_busy_cnt
7206  12df a164          	cp	a,#100
7207  12e1 2506          	jrult	L3223
7208                     ; 1923 		tx_busy_cnt=0;
7210  12e3 3f77          	clr	_tx_busy_cnt
7211                     ; 1924 		bTX_FREE=1;
7213  12e5 35010003      	mov	_bTX_FREE,#1
7214  12e9               L3223:
7215                     ; 1927 }
7218  12e9 81            	ret
7335                     ; 1953 void can_in_an(void)
7335                     ; 1954 {
7336                     	switch	.text
7337  12ea               _can_in_an:
7339  12ea 5207          	subw	sp,#7
7340       00000007      OFST:	set	7
7343                     ; 1964 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7345  12ec b6d0          	ld	a,_mess+6
7346  12ee c10101        	cp	a,_adress
7347  12f1 2703          	jreq	L461
7348  12f3 cc1452        	jp	L3623
7349  12f6               L461:
7351  12f6 b6d1          	ld	a,_mess+7
7352  12f8 c10101        	cp	a,_adress
7353  12fb 2703          	jreq	L661
7354  12fd cc1452        	jp	L3623
7355  1300               L661:
7357  1300 b6d2          	ld	a,_mess+8
7358  1302 a1ed          	cp	a,#237
7359  1304 2703          	jreq	L071
7360  1306 cc1452        	jp	L3623
7361  1309               L071:
7362                     ; 1967 	can_error_cnt=0;
7364  1309 3f76          	clr	_can_error_cnt
7365                     ; 1969 	bMAIN=0;
7367  130b 72110001      	bres	_bMAIN
7368                     ; 1970  	flags_tu=mess[9];
7370  130f 45d36d        	mov	_flags_tu,_mess+9
7371                     ; 1971  	if(flags_tu&0b00000001)
7373  1312 b66d          	ld	a,_flags_tu
7374  1314 a501          	bcp	a,#1
7375  1316 2706          	jreq	L5623
7376                     ; 1976  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7378  1318 721a0005      	bset	_flags,#5
7380  131c 2008          	jra	L7623
7381  131e               L5623:
7382                     ; 1987  				flags&=0b11011111; 
7384  131e 721b0005      	bres	_flags,#5
7385                     ; 1988  				off_bp_cnt=5*EE_TZAS;
7387  1322 350f0060      	mov	_off_bp_cnt,#15
7388  1326               L7623:
7389                     ; 1994  	if(flags_tu&0b00000010) flags|=0b01000000;
7391  1326 b66d          	ld	a,_flags_tu
7392  1328 a502          	bcp	a,#2
7393  132a 2706          	jreq	L1723
7396  132c 721c0005      	bset	_flags,#6
7398  1330 2004          	jra	L3723
7399  1332               L1723:
7400                     ; 1995  	else flags&=0b10111111; 
7402  1332 721d0005      	bres	_flags,#6
7403  1336               L3723:
7404                     ; 1997  	U_out_const=mess[10]+mess[11]*256;
7406  1336 b6d5          	ld	a,_mess+11
7407  1338 5f            	clrw	x
7408  1339 97            	ld	xl,a
7409  133a 4f            	clr	a
7410  133b 02            	rlwa	x,a
7411  133c 01            	rrwa	x,a
7412  133d bbd4          	add	a,_mess+10
7413  133f 2401          	jrnc	L051
7414  1341 5c            	incw	x
7415  1342               L051:
7416  1342 c70013        	ld	_U_out_const+1,a
7417  1345 9f            	ld	a,xl
7418  1346 c70012        	ld	_U_out_const,a
7419                     ; 1998  	vol_i_temp=mess[12]+mess[13]*256;
7421  1349 b6d7          	ld	a,_mess+13
7422  134b 5f            	clrw	x
7423  134c 97            	ld	xl,a
7424  134d 4f            	clr	a
7425  134e 02            	rlwa	x,a
7426  134f 01            	rrwa	x,a
7427  1350 bbd6          	add	a,_mess+12
7428  1352 2401          	jrnc	L251
7429  1354 5c            	incw	x
7430  1355               L251:
7431  1355 b764          	ld	_vol_i_temp+1,a
7432  1357 9f            	ld	a,xl
7433  1358 b763          	ld	_vol_i_temp,a
7434                     ; 1999 	if(vol_i_temp>20)vol_i_temp=20;
7436  135a 9c            	rvf
7437  135b be63          	ldw	x,_vol_i_temp
7438  135d a30015        	cpw	x,#21
7439  1360 2f05          	jrslt	L5723
7442  1362 ae0014        	ldw	x,#20
7443  1365 bf63          	ldw	_vol_i_temp,x
7444  1367               L5723:
7445                     ; 2000  	if(vol_i_temp<-20)vol_i_temp=-20;
7447  1367 9c            	rvf
7448  1368 be63          	ldw	x,_vol_i_temp
7449  136a a3ffec        	cpw	x,#65516
7450  136d 2e05          	jrsge	L7723
7453  136f aeffec        	ldw	x,#65516
7454  1372 bf63          	ldw	_vol_i_temp,x
7455  1374               L7723:
7456                     ; 2010 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7458  1374 b608          	ld	a,_vent_resurs_tx_cnt
7459  1376 a102          	cp	a,#2
7460  1378 2507          	jrult	L1033
7463  137a ce0000        	ldw	x,_vent_resurs
7464  137d bf42          	ldw	_plazma_int+4,x
7466  137f 2004          	jra	L3033
7467  1381               L1033:
7468                     ; 2011 	else plazma_int[2]=vent_resurs_sec_cnt;
7470  1381 be09          	ldw	x,_vent_resurs_sec_cnt
7471  1383 bf42          	ldw	_plazma_int+4,x
7472  1385               L3033:
7473                     ; 2012  	rotor_int=flags_tu+(((short)flags)<<8);
7475  1385 b605          	ld	a,_flags
7476  1387 5f            	clrw	x
7477  1388 97            	ld	xl,a
7478  1389 4f            	clr	a
7479  138a 02            	rlwa	x,a
7480  138b 01            	rrwa	x,a
7481  138c bb6d          	add	a,_flags_tu
7482  138e 2401          	jrnc	L451
7483  1390 5c            	incw	x
7484  1391               L451:
7485  1391 b718          	ld	_rotor_int+1,a
7486  1393 9f            	ld	a,xl
7487  1394 b717          	ld	_rotor_int,a
7488                     ; 2014 	debug_info_to_uku[0]=pwm_u;
7490  1396 be08          	ldw	x,_pwm_u
7491  1398 bf01          	ldw	_debug_info_to_uku,x
7492                     ; 2015 	debug_info_to_uku[1]=Udelt;//Ufade;//Usum;
7494  139a ce000c        	ldw	x,_Udelt
7495  139d bf03          	ldw	_debug_info_to_uku+2,x
7496                     ; 2016 	debug_info_to_uku[2]=vol_i_temp;//pwm_u;
7498  139f be63          	ldw	x,_vol_i_temp
7499  13a1 bf05          	ldw	_debug_info_to_uku+4,x
7500                     ; 2019 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7502  13a3 3b0016        	push	_Ui
7503  13a6 3b0017        	push	_Ui+1
7504  13a9 3b0018        	push	_Un
7505  13ac 3b0019        	push	_Un+1
7506  13af 3b001a        	push	_I
7507  13b2 3b001b        	push	_I+1
7508  13b5 4bda          	push	#218
7509  13b7 3b0101        	push	_adress
7510  13ba ae018e        	ldw	x,#398
7511  13bd cd11fc        	call	_can_transmit
7513  13c0 5b08          	addw	sp,#8
7514                     ; 2020 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7516  13c2 3b0010        	push	_Usum
7517  13c5 3b0011        	push	_Usum+1
7518  13c8 3b006c        	push	__x_+1
7519  13cb 3b0005        	push	_flags
7520  13ce b608          	ld	a,_vent_resurs_tx_cnt
7521  13d0 5f            	clrw	x
7522  13d1 97            	ld	xl,a
7523  13d2 d60000        	ld	a,(_vent_resurs_buff,x)
7524  13d5 88            	push	a
7525  13d6 3b0075        	push	_T
7526  13d9 4bdb          	push	#219
7527  13db 3b0101        	push	_adress
7528  13de ae018e        	ldw	x,#398
7529  13e1 cd11fc        	call	_can_transmit
7531  13e4 5b08          	addw	sp,#8
7532                     ; 2021 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7534  13e6 3b0005        	push	_debug_info_to_uku+4
7535  13e9 3b0006        	push	_debug_info_to_uku+5
7536  13ec 3b0003        	push	_debug_info_to_uku+2
7537  13ef 3b0004        	push	_debug_info_to_uku+3
7538  13f2 3b0001        	push	_debug_info_to_uku
7539  13f5 3b0002        	push	_debug_info_to_uku+1
7540  13f8 4bdc          	push	#220
7541  13fa 3b0101        	push	_adress
7542  13fd ae018e        	ldw	x,#398
7543  1400 cd11fc        	call	_can_transmit
7545  1403 5b08          	addw	sp,#8
7546                     ; 2022      link_cnt=0;
7548  1405 5f            	clrw	x
7549  1406 bf6e          	ldw	_link_cnt,x
7550                     ; 2023      link=ON;
7552  1408 35550070      	mov	_link,#85
7553                     ; 2025      if(flags_tu&0b10000000)
7555  140c b66d          	ld	a,_flags_tu
7556  140e a580          	bcp	a,#128
7557  1410 2716          	jreq	L5033
7558                     ; 2027      	if(!res_fl)
7560  1412 725d000b      	tnz	_res_fl
7561  1416 2626          	jrne	L1133
7562                     ; 2029      		res_fl=1;
7564  1418 a601          	ld	a,#1
7565  141a ae000b        	ldw	x,#_res_fl
7566  141d cd0000        	call	c_eewrc
7568                     ; 2030      		bRES=1;
7570  1420 3501000c      	mov	_bRES,#1
7571                     ; 2031      		res_fl_cnt=0;
7573  1424 3f4c          	clr	_res_fl_cnt
7574  1426 2016          	jra	L1133
7575  1428               L5033:
7576                     ; 2036      	if(main_cnt>20)
7578  1428 9c            	rvf
7579  1429 ce025f        	ldw	x,_main_cnt
7580  142c a30015        	cpw	x,#21
7581  142f 2f0d          	jrslt	L1133
7582                     ; 2038     			if(res_fl)
7584  1431 725d000b      	tnz	_res_fl
7585  1435 2707          	jreq	L1133
7586                     ; 2040      			res_fl=0;
7588  1437 4f            	clr	a
7589  1438 ae000b        	ldw	x,#_res_fl
7590  143b cd0000        	call	c_eewrc
7592  143e               L1133:
7593                     ; 2045       if(res_fl_)
7595  143e 725d000a      	tnz	_res_fl_
7596  1442 2603          	jrne	L271
7597  1444 cc19b3        	jp	L7223
7598  1447               L271:
7599                     ; 2047       	res_fl_=0;
7601  1447 4f            	clr	a
7602  1448 ae000a        	ldw	x,#_res_fl_
7603  144b cd0000        	call	c_eewrc
7605  144e acb319b3      	jpf	L7223
7606  1452               L3623:
7607                     ; 2050 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7609  1452 b6d0          	ld	a,_mess+6
7610  1454 c10101        	cp	a,_adress
7611  1457 2703          	jreq	L471
7612  1459 cc16cf        	jp	L3233
7613  145c               L471:
7615  145c b6d1          	ld	a,_mess+7
7616  145e c10101        	cp	a,_adress
7617  1461 2703          	jreq	L671
7618  1463 cc16cf        	jp	L3233
7619  1466               L671:
7621  1466 b6d2          	ld	a,_mess+8
7622  1468 a1ee          	cp	a,#238
7623  146a 2703          	jreq	L002
7624  146c cc16cf        	jp	L3233
7625  146f               L002:
7627  146f b6d3          	ld	a,_mess+9
7628  1471 b1d4          	cp	a,_mess+10
7629  1473 2703          	jreq	L202
7630  1475 cc16cf        	jp	L3233
7631  1478               L202:
7632                     ; 2052 	rotor_int++;
7634  1478 be17          	ldw	x,_rotor_int
7635  147a 1c0001        	addw	x,#1
7636  147d bf17          	ldw	_rotor_int,x
7637                     ; 2053 	if((mess[9]&0xf0)==0x20)
7639  147f b6d3          	ld	a,_mess+9
7640  1481 a4f0          	and	a,#240
7641  1483 a120          	cp	a,#32
7642  1485 2673          	jrne	L5233
7643                     ; 2055 		if((mess[9]&0x0f)==0x01)
7645  1487 b6d3          	ld	a,_mess+9
7646  1489 a40f          	and	a,#15
7647  148b a101          	cp	a,#1
7648  148d 260d          	jrne	L7233
7649                     ; 2057 			ee_K[0][0]=adc_buff_[4];
7651  148f ce0111        	ldw	x,_adc_buff_+8
7652  1492 89            	pushw	x
7653  1493 ae001a        	ldw	x,#_ee_K
7654  1496 cd0000        	call	c_eewrw
7656  1499 85            	popw	x
7658  149a 204a          	jra	L1333
7659  149c               L7233:
7660                     ; 2059 		else if((mess[9]&0x0f)==0x02)
7662  149c b6d3          	ld	a,_mess+9
7663  149e a40f          	and	a,#15
7664  14a0 a102          	cp	a,#2
7665  14a2 260b          	jrne	L3333
7666                     ; 2061 			ee_K[0][1]++;
7668  14a4 ce001c        	ldw	x,_ee_K+2
7669  14a7 1c0001        	addw	x,#1
7670  14aa cf001c        	ldw	_ee_K+2,x
7672  14ad 2037          	jra	L1333
7673  14af               L3333:
7674                     ; 2063 		else if((mess[9]&0x0f)==0x03)
7676  14af b6d3          	ld	a,_mess+9
7677  14b1 a40f          	and	a,#15
7678  14b3 a103          	cp	a,#3
7679  14b5 260b          	jrne	L7333
7680                     ; 2065 			ee_K[0][1]+=10;
7682  14b7 ce001c        	ldw	x,_ee_K+2
7683  14ba 1c000a        	addw	x,#10
7684  14bd cf001c        	ldw	_ee_K+2,x
7686  14c0 2024          	jra	L1333
7687  14c2               L7333:
7688                     ; 2067 		else if((mess[9]&0x0f)==0x04)
7690  14c2 b6d3          	ld	a,_mess+9
7691  14c4 a40f          	and	a,#15
7692  14c6 a104          	cp	a,#4
7693  14c8 260b          	jrne	L3433
7694                     ; 2069 			ee_K[0][1]--;
7696  14ca ce001c        	ldw	x,_ee_K+2
7697  14cd 1d0001        	subw	x,#1
7698  14d0 cf001c        	ldw	_ee_K+2,x
7700  14d3 2011          	jra	L1333
7701  14d5               L3433:
7702                     ; 2071 		else if((mess[9]&0x0f)==0x05)
7704  14d5 b6d3          	ld	a,_mess+9
7705  14d7 a40f          	and	a,#15
7706  14d9 a105          	cp	a,#5
7707  14db 2609          	jrne	L1333
7708                     ; 2073 			ee_K[0][1]-=10;
7710  14dd ce001c        	ldw	x,_ee_K+2
7711  14e0 1d000a        	subw	x,#10
7712  14e3 cf001c        	ldw	_ee_K+2,x
7713  14e6               L1333:
7714                     ; 2075 		granee(&ee_K[0][1],50,3000);									
7716  14e6 ae0bb8        	ldw	x,#3000
7717  14e9 89            	pushw	x
7718  14ea ae0032        	ldw	x,#50
7719  14ed 89            	pushw	x
7720  14ee ae001c        	ldw	x,#_ee_K+2
7721  14f1 cd00f6        	call	_granee
7723  14f4 5b04          	addw	sp,#4
7725  14f6 acb416b4      	jpf	L1533
7726  14fa               L5233:
7727                     ; 2077 	else if((mess[9]&0xf0)==0x10)
7729  14fa b6d3          	ld	a,_mess+9
7730  14fc a4f0          	and	a,#240
7731  14fe a110          	cp	a,#16
7732  1500 2673          	jrne	L3533
7733                     ; 2079 		if((mess[9]&0x0f)==0x01)
7735  1502 b6d3          	ld	a,_mess+9
7736  1504 a40f          	and	a,#15
7737  1506 a101          	cp	a,#1
7738  1508 260d          	jrne	L5533
7739                     ; 2081 			ee_K[1][0]=adc_buff_[1];
7741  150a ce010b        	ldw	x,_adc_buff_+2
7742  150d 89            	pushw	x
7743  150e ae001e        	ldw	x,#_ee_K+4
7744  1511 cd0000        	call	c_eewrw
7746  1514 85            	popw	x
7748  1515 204a          	jra	L7533
7749  1517               L5533:
7750                     ; 2083 		else if((mess[9]&0x0f)==0x02)
7752  1517 b6d3          	ld	a,_mess+9
7753  1519 a40f          	and	a,#15
7754  151b a102          	cp	a,#2
7755  151d 260b          	jrne	L1633
7756                     ; 2085 			ee_K[1][1]++;
7758  151f ce0020        	ldw	x,_ee_K+6
7759  1522 1c0001        	addw	x,#1
7760  1525 cf0020        	ldw	_ee_K+6,x
7762  1528 2037          	jra	L7533
7763  152a               L1633:
7764                     ; 2087 		else if((mess[9]&0x0f)==0x03)
7766  152a b6d3          	ld	a,_mess+9
7767  152c a40f          	and	a,#15
7768  152e a103          	cp	a,#3
7769  1530 260b          	jrne	L5633
7770                     ; 2089 			ee_K[1][1]+=10;
7772  1532 ce0020        	ldw	x,_ee_K+6
7773  1535 1c000a        	addw	x,#10
7774  1538 cf0020        	ldw	_ee_K+6,x
7776  153b 2024          	jra	L7533
7777  153d               L5633:
7778                     ; 2091 		else if((mess[9]&0x0f)==0x04)
7780  153d b6d3          	ld	a,_mess+9
7781  153f a40f          	and	a,#15
7782  1541 a104          	cp	a,#4
7783  1543 260b          	jrne	L1733
7784                     ; 2093 			ee_K[1][1]--;
7786  1545 ce0020        	ldw	x,_ee_K+6
7787  1548 1d0001        	subw	x,#1
7788  154b cf0020        	ldw	_ee_K+6,x
7790  154e 2011          	jra	L7533
7791  1550               L1733:
7792                     ; 2095 		else if((mess[9]&0x0f)==0x05)
7794  1550 b6d3          	ld	a,_mess+9
7795  1552 a40f          	and	a,#15
7796  1554 a105          	cp	a,#5
7797  1556 2609          	jrne	L7533
7798                     ; 2097 			ee_K[1][1]-=10;
7800  1558 ce0020        	ldw	x,_ee_K+6
7801  155b 1d000a        	subw	x,#10
7802  155e cf0020        	ldw	_ee_K+6,x
7803  1561               L7533:
7804                     ; 2102 		granee(&ee_K[1][1],10,30000);
7806  1561 ae7530        	ldw	x,#30000
7807  1564 89            	pushw	x
7808  1565 ae000a        	ldw	x,#10
7809  1568 89            	pushw	x
7810  1569 ae0020        	ldw	x,#_ee_K+6
7811  156c cd00f6        	call	_granee
7813  156f 5b04          	addw	sp,#4
7815  1571 acb416b4      	jpf	L1533
7816  1575               L3533:
7817                     ; 2106 	else if((mess[9]&0xf0)==0x00)
7819  1575 b6d3          	ld	a,_mess+9
7820  1577 a5f0          	bcp	a,#240
7821  1579 2673          	jrne	L1043
7822                     ; 2108 		if((mess[9]&0x0f)==0x01)
7824  157b b6d3          	ld	a,_mess+9
7825  157d a40f          	and	a,#15
7826  157f a101          	cp	a,#1
7827  1581 260d          	jrne	L3043
7828                     ; 2110 			ee_K[2][0]=adc_buff_[2];
7830  1583 ce010d        	ldw	x,_adc_buff_+4
7831  1586 89            	pushw	x
7832  1587 ae0022        	ldw	x,#_ee_K+8
7833  158a cd0000        	call	c_eewrw
7835  158d 85            	popw	x
7837  158e 204a          	jra	L5043
7838  1590               L3043:
7839                     ; 2112 		else if((mess[9]&0x0f)==0x02)
7841  1590 b6d3          	ld	a,_mess+9
7842  1592 a40f          	and	a,#15
7843  1594 a102          	cp	a,#2
7844  1596 260b          	jrne	L7043
7845                     ; 2114 			ee_K[2][1]++;
7847  1598 ce0024        	ldw	x,_ee_K+10
7848  159b 1c0001        	addw	x,#1
7849  159e cf0024        	ldw	_ee_K+10,x
7851  15a1 2037          	jra	L5043
7852  15a3               L7043:
7853                     ; 2116 		else if((mess[9]&0x0f)==0x03)
7855  15a3 b6d3          	ld	a,_mess+9
7856  15a5 a40f          	and	a,#15
7857  15a7 a103          	cp	a,#3
7858  15a9 260b          	jrne	L3143
7859                     ; 2118 			ee_K[2][1]+=10;
7861  15ab ce0024        	ldw	x,_ee_K+10
7862  15ae 1c000a        	addw	x,#10
7863  15b1 cf0024        	ldw	_ee_K+10,x
7865  15b4 2024          	jra	L5043
7866  15b6               L3143:
7867                     ; 2120 		else if((mess[9]&0x0f)==0x04)
7869  15b6 b6d3          	ld	a,_mess+9
7870  15b8 a40f          	and	a,#15
7871  15ba a104          	cp	a,#4
7872  15bc 260b          	jrne	L7143
7873                     ; 2122 			ee_K[2][1]--;
7875  15be ce0024        	ldw	x,_ee_K+10
7876  15c1 1d0001        	subw	x,#1
7877  15c4 cf0024        	ldw	_ee_K+10,x
7879  15c7 2011          	jra	L5043
7880  15c9               L7143:
7881                     ; 2124 		else if((mess[9]&0x0f)==0x05)
7883  15c9 b6d3          	ld	a,_mess+9
7884  15cb a40f          	and	a,#15
7885  15cd a105          	cp	a,#5
7886  15cf 2609          	jrne	L5043
7887                     ; 2126 			ee_K[2][1]-=10;
7889  15d1 ce0024        	ldw	x,_ee_K+10
7890  15d4 1d000a        	subw	x,#10
7891  15d7 cf0024        	ldw	_ee_K+10,x
7892  15da               L5043:
7893                     ; 2131 		granee(&ee_K[2][1],10,30000);
7895  15da ae7530        	ldw	x,#30000
7896  15dd 89            	pushw	x
7897  15de ae000a        	ldw	x,#10
7898  15e1 89            	pushw	x
7899  15e2 ae0024        	ldw	x,#_ee_K+10
7900  15e5 cd00f6        	call	_granee
7902  15e8 5b04          	addw	sp,#4
7904  15ea acb416b4      	jpf	L1533
7905  15ee               L1043:
7906                     ; 2135 	else if((mess[9]&0xf0)==0x30)
7908  15ee b6d3          	ld	a,_mess+9
7909  15f0 a4f0          	and	a,#240
7910  15f2 a130          	cp	a,#48
7911  15f4 265c          	jrne	L7243
7912                     ; 2137 		if((mess[9]&0x0f)==0x02)
7914  15f6 b6d3          	ld	a,_mess+9
7915  15f8 a40f          	and	a,#15
7916  15fa a102          	cp	a,#2
7917  15fc 260b          	jrne	L1343
7918                     ; 2139 			ee_K[3][1]++;
7920  15fe ce0028        	ldw	x,_ee_K+14
7921  1601 1c0001        	addw	x,#1
7922  1604 cf0028        	ldw	_ee_K+14,x
7924  1607 2037          	jra	L3343
7925  1609               L1343:
7926                     ; 2141 		else if((mess[9]&0x0f)==0x03)
7928  1609 b6d3          	ld	a,_mess+9
7929  160b a40f          	and	a,#15
7930  160d a103          	cp	a,#3
7931  160f 260b          	jrne	L5343
7932                     ; 2143 			ee_K[3][1]+=10;
7934  1611 ce0028        	ldw	x,_ee_K+14
7935  1614 1c000a        	addw	x,#10
7936  1617 cf0028        	ldw	_ee_K+14,x
7938  161a 2024          	jra	L3343
7939  161c               L5343:
7940                     ; 2145 		else if((mess[9]&0x0f)==0x04)
7942  161c b6d3          	ld	a,_mess+9
7943  161e a40f          	and	a,#15
7944  1620 a104          	cp	a,#4
7945  1622 260b          	jrne	L1443
7946                     ; 2147 			ee_K[3][1]--;
7948  1624 ce0028        	ldw	x,_ee_K+14
7949  1627 1d0001        	subw	x,#1
7950  162a cf0028        	ldw	_ee_K+14,x
7952  162d 2011          	jra	L3343
7953  162f               L1443:
7954                     ; 2149 		else if((mess[9]&0x0f)==0x05)
7956  162f b6d3          	ld	a,_mess+9
7957  1631 a40f          	and	a,#15
7958  1633 a105          	cp	a,#5
7959  1635 2609          	jrne	L3343
7960                     ; 2151 			ee_K[3][1]-=10;
7962  1637 ce0028        	ldw	x,_ee_K+14
7963  163a 1d000a        	subw	x,#10
7964  163d cf0028        	ldw	_ee_K+14,x
7965  1640               L3343:
7966                     ; 2153 		granee(&ee_K[3][1],300,517);									
7968  1640 ae0205        	ldw	x,#517
7969  1643 89            	pushw	x
7970  1644 ae012c        	ldw	x,#300
7971  1647 89            	pushw	x
7972  1648 ae0028        	ldw	x,#_ee_K+14
7973  164b cd00f6        	call	_granee
7975  164e 5b04          	addw	sp,#4
7977  1650 2062          	jra	L1533
7978  1652               L7243:
7979                     ; 2156 	else if((mess[9]&0xf0)==0x50)
7981  1652 b6d3          	ld	a,_mess+9
7982  1654 a4f0          	and	a,#240
7983  1656 a150          	cp	a,#80
7984  1658 265a          	jrne	L1533
7985                     ; 2158 		if((mess[9]&0x0f)==0x02)
7987  165a b6d3          	ld	a,_mess+9
7988  165c a40f          	and	a,#15
7989  165e a102          	cp	a,#2
7990  1660 260b          	jrne	L3543
7991                     ; 2160 			ee_K[4][1]++;
7993  1662 ce002c        	ldw	x,_ee_K+18
7994  1665 1c0001        	addw	x,#1
7995  1668 cf002c        	ldw	_ee_K+18,x
7997  166b 2037          	jra	L5543
7998  166d               L3543:
7999                     ; 2162 		else if((mess[9]&0x0f)==0x03)
8001  166d b6d3          	ld	a,_mess+9
8002  166f a40f          	and	a,#15
8003  1671 a103          	cp	a,#3
8004  1673 260b          	jrne	L7543
8005                     ; 2164 			ee_K[4][1]+=10;
8007  1675 ce002c        	ldw	x,_ee_K+18
8008  1678 1c000a        	addw	x,#10
8009  167b cf002c        	ldw	_ee_K+18,x
8011  167e 2024          	jra	L5543
8012  1680               L7543:
8013                     ; 2166 		else if((mess[9]&0x0f)==0x04)
8015  1680 b6d3          	ld	a,_mess+9
8016  1682 a40f          	and	a,#15
8017  1684 a104          	cp	a,#4
8018  1686 260b          	jrne	L3643
8019                     ; 2168 			ee_K[4][1]--;
8021  1688 ce002c        	ldw	x,_ee_K+18
8022  168b 1d0001        	subw	x,#1
8023  168e cf002c        	ldw	_ee_K+18,x
8025  1691 2011          	jra	L5543
8026  1693               L3643:
8027                     ; 2170 		else if((mess[9]&0x0f)==0x05)
8029  1693 b6d3          	ld	a,_mess+9
8030  1695 a40f          	and	a,#15
8031  1697 a105          	cp	a,#5
8032  1699 2609          	jrne	L5543
8033                     ; 2172 			ee_K[4][1]-=10;
8035  169b ce002c        	ldw	x,_ee_K+18
8036  169e 1d000a        	subw	x,#10
8037  16a1 cf002c        	ldw	_ee_K+18,x
8038  16a4               L5543:
8039                     ; 2174 		granee(&ee_K[4][1],10,30000);									
8041  16a4 ae7530        	ldw	x,#30000
8042  16a7 89            	pushw	x
8043  16a8 ae000a        	ldw	x,#10
8044  16ab 89            	pushw	x
8045  16ac ae002c        	ldw	x,#_ee_K+18
8046  16af cd00f6        	call	_granee
8048  16b2 5b04          	addw	sp,#4
8049  16b4               L1533:
8050                     ; 2177 	link_cnt=0;
8052  16b4 5f            	clrw	x
8053  16b5 bf6e          	ldw	_link_cnt,x
8054                     ; 2178      link=ON;
8056  16b7 35550070      	mov	_link,#85
8057                     ; 2179      if(res_fl_)
8059  16bb 725d000a      	tnz	_res_fl_
8060  16bf 2603          	jrne	L402
8061  16c1 cc19b3        	jp	L7223
8062  16c4               L402:
8063                     ; 2181       	res_fl_=0;
8065  16c4 4f            	clr	a
8066  16c5 ae000a        	ldw	x,#_res_fl_
8067  16c8 cd0000        	call	c_eewrc
8069  16cb acb319b3      	jpf	L7223
8070  16cf               L3233:
8071                     ; 2187 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8073  16cf b6d0          	ld	a,_mess+6
8074  16d1 a1ff          	cp	a,#255
8075  16d3 2703          	jreq	L602
8076  16d5 cc175d        	jp	L5743
8077  16d8               L602:
8079  16d8 b6d1          	ld	a,_mess+7
8080  16da a1ff          	cp	a,#255
8081  16dc 2702          	jreq	L012
8082  16de 207d          	jp	L5743
8083  16e0               L012:
8085  16e0 b6d2          	ld	a,_mess+8
8086  16e2 a162          	cp	a,#98
8087  16e4 2677          	jrne	L5743
8088                     ; 2190 	tempSS=mess[9]+(mess[10]*256);
8090  16e6 b6d4          	ld	a,_mess+10
8091  16e8 5f            	clrw	x
8092  16e9 97            	ld	xl,a
8093  16ea 4f            	clr	a
8094  16eb 02            	rlwa	x,a
8095  16ec 01            	rrwa	x,a
8096  16ed bbd3          	add	a,_mess+9
8097  16ef 2401          	jrnc	L651
8098  16f1 5c            	incw	x
8099  16f2               L651:
8100  16f2 02            	rlwa	x,a
8101  16f3 1f03          	ldw	(OFST-4,sp),x
8102  16f5 01            	rrwa	x,a
8103                     ; 2191 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8105  16f6 ce0014        	ldw	x,_ee_Umax
8106  16f9 1303          	cpw	x,(OFST-4,sp)
8107  16fb 270a          	jreq	L7743
8110  16fd 1e03          	ldw	x,(OFST-4,sp)
8111  16ff 89            	pushw	x
8112  1700 ae0014        	ldw	x,#_ee_Umax
8113  1703 cd0000        	call	c_eewrw
8115  1706 85            	popw	x
8116  1707               L7743:
8117                     ; 2192 	tempSS=mess[11]+(mess[12]*256);
8119  1707 b6d6          	ld	a,_mess+12
8120  1709 5f            	clrw	x
8121  170a 97            	ld	xl,a
8122  170b 4f            	clr	a
8123  170c 02            	rlwa	x,a
8124  170d 01            	rrwa	x,a
8125  170e bbd5          	add	a,_mess+11
8126  1710 2401          	jrnc	L061
8127  1712 5c            	incw	x
8128  1713               L061:
8129  1713 02            	rlwa	x,a
8130  1714 1f03          	ldw	(OFST-4,sp),x
8131  1716 01            	rrwa	x,a
8132                     ; 2193 	if(ee_dU!=tempSS) ee_dU=tempSS;
8134  1717 ce0012        	ldw	x,_ee_dU
8135  171a 1303          	cpw	x,(OFST-4,sp)
8136  171c 270a          	jreq	L1053
8139  171e 1e03          	ldw	x,(OFST-4,sp)
8140  1720 89            	pushw	x
8141  1721 ae0012        	ldw	x,#_ee_dU
8142  1724 cd0000        	call	c_eewrw
8144  1727 85            	popw	x
8145  1728               L1053:
8146                     ; 2194 	if((mess[13]&0x0f)==0x5)
8148  1728 b6d7          	ld	a,_mess+13
8149  172a a40f          	and	a,#15
8150  172c a105          	cp	a,#5
8151  172e 2615          	jrne	L3053
8152                     ; 2196 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8154  1730 ce0006        	ldw	x,_ee_AVT_MODE
8155  1733 a30055        	cpw	x,#85
8156  1736 271e          	jreq	L7053
8159  1738 ae0055        	ldw	x,#85
8160  173b 89            	pushw	x
8161  173c ae0006        	ldw	x,#_ee_AVT_MODE
8162  173f cd0000        	call	c_eewrw
8164  1742 85            	popw	x
8165  1743 2011          	jra	L7053
8166  1745               L3053:
8167                     ; 2198 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;
8169  1745 ce0006        	ldw	x,_ee_AVT_MODE
8170  1748 a30055        	cpw	x,#85
8171  174b 2609          	jrne	L7053
8174  174d 5f            	clrw	x
8175  174e 89            	pushw	x
8176  174f ae0006        	ldw	x,#_ee_AVT_MODE
8177  1752 cd0000        	call	c_eewrw
8179  1755 85            	popw	x
8180  1756               L7053:
8181                     ; 2199 	FADE_MODE=mess[13];	
8183  1756 45d713        	mov	_FADE_MODE,_mess+13
8185  1759 acb319b3      	jpf	L7223
8186  175d               L5743:
8187                     ; 2202 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8189  175d b6d0          	ld	a,_mess+6
8190  175f a1ff          	cp	a,#255
8191  1761 2703          	jreq	L212
8192  1763 cc1819        	jp	L5153
8193  1766               L212:
8195  1766 b6d1          	ld	a,_mess+7
8196  1768 a1ff          	cp	a,#255
8197  176a 2703          	jreq	L412
8198  176c cc1819        	jp	L5153
8199  176f               L412:
8201  176f b6d2          	ld	a,_mess+8
8202  1771 a126          	cp	a,#38
8203  1773 2709          	jreq	L7153
8205  1775 b6d2          	ld	a,_mess+8
8206  1777 a129          	cp	a,#41
8207  1779 2703          	jreq	L612
8208  177b cc1819        	jp	L5153
8209  177e               L612:
8210  177e               L7153:
8211                     ; 2205 	tempSS=mess[9]+(mess[10]*256);
8213  177e b6d4          	ld	a,_mess+10
8214  1780 5f            	clrw	x
8215  1781 97            	ld	xl,a
8216  1782 4f            	clr	a
8217  1783 02            	rlwa	x,a
8218  1784 01            	rrwa	x,a
8219  1785 bbd3          	add	a,_mess+9
8220  1787 2401          	jrnc	L261
8221  1789 5c            	incw	x
8222  178a               L261:
8223  178a 02            	rlwa	x,a
8224  178b 1f03          	ldw	(OFST-4,sp),x
8225  178d 01            	rrwa	x,a
8226                     ; 2207 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
8228  178e ce000c        	ldw	x,_ee_UAVT
8229  1791 1303          	cpw	x,(OFST-4,sp)
8230  1793 270a          	jreq	L1253
8233  1795 1e03          	ldw	x,(OFST-4,sp)
8234  1797 89            	pushw	x
8235  1798 ae000c        	ldw	x,#_ee_UAVT
8236  179b cd0000        	call	c_eewrw
8238  179e 85            	popw	x
8239  179f               L1253:
8240                     ; 2208 	tempSS=(signed short)mess[11];
8242  179f b6d5          	ld	a,_mess+11
8243  17a1 5f            	clrw	x
8244  17a2 97            	ld	xl,a
8245  17a3 1f03          	ldw	(OFST-4,sp),x
8246                     ; 2209 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8248  17a5 ce0010        	ldw	x,_ee_tmax
8249  17a8 1303          	cpw	x,(OFST-4,sp)
8250  17aa 270a          	jreq	L3253
8253  17ac 1e03          	ldw	x,(OFST-4,sp)
8254  17ae 89            	pushw	x
8255  17af ae0010        	ldw	x,#_ee_tmax
8256  17b2 cd0000        	call	c_eewrw
8258  17b5 85            	popw	x
8259  17b6               L3253:
8260                     ; 2210 	tempSS=(signed short)mess[12];
8262  17b6 b6d6          	ld	a,_mess+12
8263  17b8 5f            	clrw	x
8264  17b9 97            	ld	xl,a
8265  17ba 1f03          	ldw	(OFST-4,sp),x
8266                     ; 2211 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8268  17bc ce000e        	ldw	x,_ee_tsign
8269  17bf 1303          	cpw	x,(OFST-4,sp)
8270  17c1 270a          	jreq	L5253
8273  17c3 1e03          	ldw	x,(OFST-4,sp)
8274  17c5 89            	pushw	x
8275  17c6 ae000e        	ldw	x,#_ee_tsign
8276  17c9 cd0000        	call	c_eewrw
8278  17cc 85            	popw	x
8279  17cd               L5253:
8280                     ; 2214 	if(mess[8]==MEM_KF1)
8282  17cd b6d2          	ld	a,_mess+8
8283  17cf a126          	cp	a,#38
8284  17d1 260e          	jrne	L7253
8285                     ; 2216 		if(ee_DEVICE!=0)ee_DEVICE=0;
8287  17d3 ce0004        	ldw	x,_ee_DEVICE
8288  17d6 2709          	jreq	L7253
8291  17d8 5f            	clrw	x
8292  17d9 89            	pushw	x
8293  17da ae0004        	ldw	x,#_ee_DEVICE
8294  17dd cd0000        	call	c_eewrw
8296  17e0 85            	popw	x
8297  17e1               L7253:
8298                     ; 2219 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8300  17e1 b6d2          	ld	a,_mess+8
8301  17e3 a129          	cp	a,#41
8302  17e5 2703          	jreq	L022
8303  17e7 cc19b3        	jp	L7223
8304  17ea               L022:
8305                     ; 2221 		if(ee_DEVICE!=1)ee_DEVICE=1;
8307  17ea ce0004        	ldw	x,_ee_DEVICE
8308  17ed a30001        	cpw	x,#1
8309  17f0 270b          	jreq	L5353
8312  17f2 ae0001        	ldw	x,#1
8313  17f5 89            	pushw	x
8314  17f6 ae0004        	ldw	x,#_ee_DEVICE
8315  17f9 cd0000        	call	c_eewrw
8317  17fc 85            	popw	x
8318  17fd               L5353:
8319                     ; 2222 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8321  17fd b6d7          	ld	a,_mess+13
8322  17ff 5f            	clrw	x
8323  1800 97            	ld	xl,a
8324  1801 c30002        	cpw	x,_ee_IMAXVENT
8325  1804 2603          	jrne	L222
8326  1806 cc19b3        	jp	L7223
8327  1809               L222:
8330  1809 b6d7          	ld	a,_mess+13
8331  180b 5f            	clrw	x
8332  180c 97            	ld	xl,a
8333  180d 89            	pushw	x
8334  180e ae0002        	ldw	x,#_ee_IMAXVENT
8335  1811 cd0000        	call	c_eewrw
8337  1814 85            	popw	x
8338  1815 acb319b3      	jpf	L7223
8339  1819               L5153:
8340                     ; 2227 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8342  1819 b6d0          	ld	a,_mess+6
8343  181b c10101        	cp	a,_adress
8344  181e 262d          	jrne	L3453
8346  1820 b6d1          	ld	a,_mess+7
8347  1822 c10101        	cp	a,_adress
8348  1825 2626          	jrne	L3453
8350  1827 b6d2          	ld	a,_mess+8
8351  1829 a116          	cp	a,#22
8352  182b 2620          	jrne	L3453
8354  182d b6d3          	ld	a,_mess+9
8355  182f a163          	cp	a,#99
8356  1831 261a          	jrne	L3453
8357                     ; 2229 	flags&=0b11100001;
8359  1833 b605          	ld	a,_flags
8360  1835 a4e1          	and	a,#225
8361  1837 b705          	ld	_flags,a
8362                     ; 2230 	tsign_cnt=0;
8364  1839 5f            	clrw	x
8365  183a bf5c          	ldw	_tsign_cnt,x
8366                     ; 2231 	tmax_cnt=0;
8368  183c 5f            	clrw	x
8369  183d bf5a          	ldw	_tmax_cnt,x
8370                     ; 2232 	umax_cnt=0;
8372  183f 5f            	clrw	x
8373  1840 bf73          	ldw	_umax_cnt,x
8374                     ; 2233 	umin_cnt=0;
8376  1842 5f            	clrw	x
8377  1843 bf71          	ldw	_umin_cnt,x
8378                     ; 2234 	led_drv_cnt=30;
8380  1845 351e0016      	mov	_led_drv_cnt,#30
8382  1849 acb319b3      	jpf	L7223
8383  184d               L3453:
8384                     ; 2237 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8386  184d b6d0          	ld	a,_mess+6
8387  184f c10101        	cp	a,_adress
8388  1852 2620          	jrne	L7453
8390  1854 b6d1          	ld	a,_mess+7
8391  1856 c10101        	cp	a,_adress
8392  1859 2619          	jrne	L7453
8394  185b b6d2          	ld	a,_mess+8
8395  185d a116          	cp	a,#22
8396  185f 2613          	jrne	L7453
8398  1861 b6d3          	ld	a,_mess+9
8399  1863 a164          	cp	a,#100
8400  1865 260d          	jrne	L7453
8401                     ; 2239 	vent_resurs=0;
8403  1867 5f            	clrw	x
8404  1868 89            	pushw	x
8405  1869 ae0000        	ldw	x,#_vent_resurs
8406  186c cd0000        	call	c_eewrw
8408  186f 85            	popw	x
8410  1870 acb319b3      	jpf	L7223
8411  1874               L7453:
8412                     ; 2243 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8414  1874 b6d0          	ld	a,_mess+6
8415  1876 a1ff          	cp	a,#255
8416  1878 265f          	jrne	L3553
8418  187a b6d1          	ld	a,_mess+7
8419  187c a1ff          	cp	a,#255
8420  187e 2659          	jrne	L3553
8422  1880 b6d2          	ld	a,_mess+8
8423  1882 a116          	cp	a,#22
8424  1884 2653          	jrne	L3553
8426  1886 b6d3          	ld	a,_mess+9
8427  1888 a116          	cp	a,#22
8428  188a 264d          	jrne	L3553
8429                     ; 2245 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8431  188c b6d4          	ld	a,_mess+10
8432  188e a155          	cp	a,#85
8433  1890 260f          	jrne	L5553
8435  1892 b6d5          	ld	a,_mess+11
8436  1894 a155          	cp	a,#85
8437  1896 2609          	jrne	L5553
8440  1898 be6b          	ldw	x,__x_
8441  189a 1c0001        	addw	x,#1
8442  189d bf6b          	ldw	__x_,x
8444  189f 2024          	jra	L7553
8445  18a1               L5553:
8446                     ; 2246 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8448  18a1 b6d4          	ld	a,_mess+10
8449  18a3 a166          	cp	a,#102
8450  18a5 260f          	jrne	L1653
8452  18a7 b6d5          	ld	a,_mess+11
8453  18a9 a166          	cp	a,#102
8454  18ab 2609          	jrne	L1653
8457  18ad be6b          	ldw	x,__x_
8458  18af 1d0001        	subw	x,#1
8459  18b2 bf6b          	ldw	__x_,x
8461  18b4 200f          	jra	L7553
8462  18b6               L1653:
8463                     ; 2247 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8465  18b6 b6d4          	ld	a,_mess+10
8466  18b8 a177          	cp	a,#119
8467  18ba 2609          	jrne	L7553
8469  18bc b6d5          	ld	a,_mess+11
8470  18be a177          	cp	a,#119
8471  18c0 2603          	jrne	L7553
8474  18c2 5f            	clrw	x
8475  18c3 bf6b          	ldw	__x_,x
8476  18c5               L7553:
8477                     ; 2248      gran(&_x_,-XMAX,XMAX);
8479  18c5 ae0019        	ldw	x,#25
8480  18c8 89            	pushw	x
8481  18c9 aeffe7        	ldw	x,#65511
8482  18cc 89            	pushw	x
8483  18cd ae006b        	ldw	x,#__x_
8484  18d0 cd00d5        	call	_gran
8486  18d3 5b04          	addw	sp,#4
8488  18d5 acb319b3      	jpf	L7223
8489  18d9               L3553:
8490                     ; 2250 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8492  18d9 b6d0          	ld	a,_mess+6
8493  18db c10101        	cp	a,_adress
8494  18de 2635          	jrne	L1753
8496  18e0 b6d1          	ld	a,_mess+7
8497  18e2 c10101        	cp	a,_adress
8498  18e5 262e          	jrne	L1753
8500  18e7 b6d2          	ld	a,_mess+8
8501  18e9 a116          	cp	a,#22
8502  18eb 2628          	jrne	L1753
8504  18ed b6d3          	ld	a,_mess+9
8505  18ef b1d4          	cp	a,_mess+10
8506  18f1 2622          	jrne	L1753
8508  18f3 b6d3          	ld	a,_mess+9
8509  18f5 a1ee          	cp	a,#238
8510  18f7 261c          	jrne	L1753
8511                     ; 2252 	rotor_int++;
8513  18f9 be17          	ldw	x,_rotor_int
8514  18fb 1c0001        	addw	x,#1
8515  18fe bf17          	ldw	_rotor_int,x
8516                     ; 2253      tempI=pwm_u;
8518                     ; 2255 	UU_AVT=Un;
8520  1900 ce0018        	ldw	x,_Un
8521  1903 89            	pushw	x
8522  1904 ae0008        	ldw	x,#_UU_AVT
8523  1907 cd0000        	call	c_eewrw
8525  190a 85            	popw	x
8526                     ; 2256 	delay_ms(100);
8528  190b ae0064        	ldw	x,#100
8529  190e cd0121        	call	_delay_ms
8532  1911 acb319b3      	jpf	L7223
8533  1915               L1753:
8534                     ; 2262 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8536  1915 b6d1          	ld	a,_mess+7
8537  1917 a1da          	cp	a,#218
8538  1919 2653          	jrne	L5753
8540  191b b6d0          	ld	a,_mess+6
8541  191d c10101        	cp	a,_adress
8542  1920 274c          	jreq	L5753
8544  1922 b6d0          	ld	a,_mess+6
8545  1924 a106          	cp	a,#6
8546  1926 2446          	jruge	L5753
8547                     ; 2264 	i_main_bps_cnt[mess[6]]=0;
8549  1928 b6d0          	ld	a,_mess+6
8550  192a 5f            	clrw	x
8551  192b 97            	ld	xl,a
8552  192c 6f14          	clr	(_i_main_bps_cnt,x)
8553                     ; 2265 	i_main_flag[mess[6]]=1;
8555  192e b6d0          	ld	a,_mess+6
8556  1930 5f            	clrw	x
8557  1931 97            	ld	xl,a
8558  1932 a601          	ld	a,#1
8559  1934 e71f          	ld	(_i_main_flag,x),a
8560                     ; 2266 	if(bMAIN)
8562                     	btst	_bMAIN
8563  193b 2476          	jruge	L7223
8564                     ; 2268 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8566  193d b6d3          	ld	a,_mess+9
8567  193f 5f            	clrw	x
8568  1940 97            	ld	xl,a
8569  1941 4f            	clr	a
8570  1942 02            	rlwa	x,a
8571  1943 1f01          	ldw	(OFST-6,sp),x
8572  1945 b6d2          	ld	a,_mess+8
8573  1947 5f            	clrw	x
8574  1948 97            	ld	xl,a
8575  1949 72fb01        	addw	x,(OFST-6,sp)
8576  194c b6d0          	ld	a,_mess+6
8577  194e 905f          	clrw	y
8578  1950 9097          	ld	yl,a
8579  1952 9058          	sllw	y
8580  1954 90ef25        	ldw	(_i_main,y),x
8581                     ; 2269 		i_main[adress]=I;
8583  1957 c60101        	ld	a,_adress
8584  195a 5f            	clrw	x
8585  195b 97            	ld	xl,a
8586  195c 58            	sllw	x
8587  195d 90ce001a      	ldw	y,_I
8588  1961 ef25          	ldw	(_i_main,x),y
8589                     ; 2270      	i_main_flag[adress]=1;
8591  1963 c60101        	ld	a,_adress
8592  1966 5f            	clrw	x
8593  1967 97            	ld	xl,a
8594  1968 a601          	ld	a,#1
8595  196a e71f          	ld	(_i_main_flag,x),a
8596  196c 2045          	jra	L7223
8597  196e               L5753:
8598                     ; 2274 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8600  196e b6d1          	ld	a,_mess+7
8601  1970 a1db          	cp	a,#219
8602  1972 263f          	jrne	L7223
8604  1974 b6d0          	ld	a,_mess+6
8605  1976 c10101        	cp	a,_adress
8606  1979 2738          	jreq	L7223
8608  197b b6d0          	ld	a,_mess+6
8609  197d a106          	cp	a,#6
8610  197f 2432          	jruge	L7223
8611                     ; 2276 	i_main_bps_cnt[mess[6]]=0;
8613  1981 b6d0          	ld	a,_mess+6
8614  1983 5f            	clrw	x
8615  1984 97            	ld	xl,a
8616  1985 6f14          	clr	(_i_main_bps_cnt,x)
8617                     ; 2277 	i_main_flag[mess[6]]=1;		
8619  1987 b6d0          	ld	a,_mess+6
8620  1989 5f            	clrw	x
8621  198a 97            	ld	xl,a
8622  198b a601          	ld	a,#1
8623  198d e71f          	ld	(_i_main_flag,x),a
8624                     ; 2278 	if(bMAIN)
8626                     	btst	_bMAIN
8627  1994 241d          	jruge	L7223
8628                     ; 2280 		if(mess[9]==0)i_main_flag[i]=1;
8630  1996 3dd3          	tnz	_mess+9
8631  1998 260a          	jrne	L7063
8634  199a 7b07          	ld	a,(OFST+0,sp)
8635  199c 5f            	clrw	x
8636  199d 97            	ld	xl,a
8637  199e a601          	ld	a,#1
8638  19a0 e71f          	ld	(_i_main_flag,x),a
8640  19a2 2006          	jra	L1163
8641  19a4               L7063:
8642                     ; 2281 		else i_main_flag[i]=0;
8644  19a4 7b07          	ld	a,(OFST+0,sp)
8645  19a6 5f            	clrw	x
8646  19a7 97            	ld	xl,a
8647  19a8 6f1f          	clr	(_i_main_flag,x)
8648  19aa               L1163:
8649                     ; 2282 		i_main_flag[adress]=1;
8651  19aa c60101        	ld	a,_adress
8652  19ad 5f            	clrw	x
8653  19ae 97            	ld	xl,a
8654  19af a601          	ld	a,#1
8655  19b1 e71f          	ld	(_i_main_flag,x),a
8656  19b3               L7223:
8657                     ; 2288 can_in_an_end:
8657                     ; 2289 bCAN_RX=0;
8659  19b3 3f04          	clr	_bCAN_RX
8660                     ; 2290 }   
8663  19b5 5b07          	addw	sp,#7
8664  19b7 81            	ret
8687                     ; 2293 void t4_init(void){
8688                     	switch	.text
8689  19b8               _t4_init:
8693                     ; 2294 	TIM4->PSCR = 6;
8695  19b8 35065345      	mov	21317,#6
8696                     ; 2295 	TIM4->ARR= 31;
8698  19bc 351f5346      	mov	21318,#31
8699                     ; 2296 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8701  19c0 72105341      	bset	21313,#0
8702                     ; 2298 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8704  19c4 35855340      	mov	21312,#133
8705                     ; 2300 }
8708  19c8 81            	ret
8731                     ; 2303 void t1_init(void)
8731                     ; 2304 {
8732                     	switch	.text
8733  19c9               _t1_init:
8737                     ; 2305 TIM1->ARRH= 0x07;
8739  19c9 35075262      	mov	21090,#7
8740                     ; 2306 TIM1->ARRL= 0xff;
8742  19cd 35ff5263      	mov	21091,#255
8743                     ; 2307 TIM1->CCR1H= 0x00;	
8745  19d1 725f5265      	clr	21093
8746                     ; 2308 TIM1->CCR1L= 0xff;
8748  19d5 35ff5266      	mov	21094,#255
8749                     ; 2309 TIM1->CCR2H= 0x00;	
8751  19d9 725f5267      	clr	21095
8752                     ; 2310 TIM1->CCR2L= 0x00;
8754  19dd 725f5268      	clr	21096
8755                     ; 2311 TIM1->CCR3H= 0x00;	
8757  19e1 725f5269      	clr	21097
8758                     ; 2312 TIM1->CCR3L= 0x64;
8760  19e5 3564526a      	mov	21098,#100
8761                     ; 2314 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8763  19e9 35685258      	mov	21080,#104
8764                     ; 2315 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8766  19ed 35685259      	mov	21081,#104
8767                     ; 2316 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8769  19f1 3568525a      	mov	21082,#104
8770                     ; 2317 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8772  19f5 3511525c      	mov	21084,#17
8773                     ; 2318 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8775  19f9 3501525d      	mov	21085,#1
8776                     ; 2319 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8778  19fd 35815250      	mov	21072,#129
8779                     ; 2320 TIM1->BKR|= TIM1_BKR_AOE;
8781  1a01 721c526d      	bset	21101,#6
8782                     ; 2321 }
8785  1a05 81            	ret
8810                     ; 2325 void adc2_init(void)
8810                     ; 2326 {
8811                     	switch	.text
8812  1a06               _adc2_init:
8816                     ; 2327 adc_plazma[0]++;
8818  1a06 bebc          	ldw	x,_adc_plazma
8819  1a08 1c0001        	addw	x,#1
8820  1a0b bfbc          	ldw	_adc_plazma,x
8821                     ; 2351 GPIOB->DDR&=~(1<<4);
8823  1a0d 72195007      	bres	20487,#4
8824                     ; 2352 GPIOB->CR1&=~(1<<4);
8826  1a11 72195008      	bres	20488,#4
8827                     ; 2353 GPIOB->CR2&=~(1<<4);
8829  1a15 72195009      	bres	20489,#4
8830                     ; 2355 GPIOB->DDR&=~(1<<5);
8832  1a19 721b5007      	bres	20487,#5
8833                     ; 2356 GPIOB->CR1&=~(1<<5);
8835  1a1d 721b5008      	bres	20488,#5
8836                     ; 2357 GPIOB->CR2&=~(1<<5);
8838  1a21 721b5009      	bres	20489,#5
8839                     ; 2359 GPIOB->DDR&=~(1<<6);
8841  1a25 721d5007      	bres	20487,#6
8842                     ; 2360 GPIOB->CR1&=~(1<<6);
8844  1a29 721d5008      	bres	20488,#6
8845                     ; 2361 GPIOB->CR2&=~(1<<6);
8847  1a2d 721d5009      	bres	20489,#6
8848                     ; 2363 GPIOB->DDR&=~(1<<7);
8850  1a31 721f5007      	bres	20487,#7
8851                     ; 2364 GPIOB->CR1&=~(1<<7);
8853  1a35 721f5008      	bres	20488,#7
8854                     ; 2365 GPIOB->CR2&=~(1<<7);
8856  1a39 721f5009      	bres	20489,#7
8857                     ; 2367 GPIOB->DDR&=~(1<<2);
8859  1a3d 72155007      	bres	20487,#2
8860                     ; 2368 GPIOB->CR1&=~(1<<2);
8862  1a41 72155008      	bres	20488,#2
8863                     ; 2369 GPIOB->CR2&=~(1<<2);
8865  1a45 72155009      	bres	20489,#2
8866                     ; 2378 ADC2->TDRL=0xff;
8868  1a49 35ff5407      	mov	21511,#255
8869                     ; 2380 ADC2->CR2=0x08;
8871  1a4d 35085402      	mov	21506,#8
8872                     ; 2381 ADC2->CR1=0x60;
8874  1a51 35605401      	mov	21505,#96
8875                     ; 2384 	if(adc_ch==5)ADC2->CSR=0x22;
8877  1a55 b6c9          	ld	a,_adc_ch
8878  1a57 a105          	cp	a,#5
8879  1a59 2606          	jrne	L3463
8882  1a5b 35225400      	mov	21504,#34
8884  1a5f 2007          	jra	L5463
8885  1a61               L3463:
8886                     ; 2385 	else ADC2->CSR=0x20+adc_ch+3;
8888  1a61 b6c9          	ld	a,_adc_ch
8889  1a63 ab23          	add	a,#35
8890  1a65 c75400        	ld	21504,a
8891  1a68               L5463:
8892                     ; 2387 	ADC2->CR1|=1;
8894  1a68 72105401      	bset	21505,#0
8895                     ; 2388 	ADC2->CR1|=1;
8897  1a6c 72105401      	bset	21505,#0
8898                     ; 2391 adc_plazma[1]=adc_ch;
8900  1a70 b6c9          	ld	a,_adc_ch
8901  1a72 5f            	clrw	x
8902  1a73 97            	ld	xl,a
8903  1a74 bfbe          	ldw	_adc_plazma+2,x
8904                     ; 2392 }
8907  1a76 81            	ret
8945                     ; 2400 @far @interrupt void TIM4_UPD_Interrupt (void) 
8945                     ; 2401 {
8947                     	switch	.text
8948  1a77               f_TIM4_UPD_Interrupt:
8952                     ; 2402 TIM4->SR1&=~TIM4_SR1_UIF;
8954  1a77 72115342      	bres	21314,#0
8955                     ; 2404 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8957  1a7b 3c12          	inc	_pwm_vent_cnt
8958  1a7d b612          	ld	a,_pwm_vent_cnt
8959  1a7f a10a          	cp	a,#10
8960  1a81 2502          	jrult	L7563
8963  1a83 3f12          	clr	_pwm_vent_cnt
8964  1a85               L7563:
8965                     ; 2405 GPIOB->ODR|=(1<<3);
8967  1a85 72165005      	bset	20485,#3
8968                     ; 2406 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8970  1a89 b612          	ld	a,_pwm_vent_cnt
8971  1a8b a105          	cp	a,#5
8972  1a8d 2504          	jrult	L1663
8975  1a8f 72175005      	bres	20485,#3
8976  1a93               L1663:
8977                     ; 2410 if(++t0_cnt00>=10)
8979  1a93 9c            	rvf
8980  1a94 ce0000        	ldw	x,_t0_cnt00
8981  1a97 1c0001        	addw	x,#1
8982  1a9a cf0000        	ldw	_t0_cnt00,x
8983  1a9d a3000a        	cpw	x,#10
8984  1aa0 2f08          	jrslt	L3663
8985                     ; 2412 	t0_cnt00=0;
8987  1aa2 5f            	clrw	x
8988  1aa3 cf0000        	ldw	_t0_cnt00,x
8989                     ; 2413 	b1000Hz=1;
8991  1aa6 72100005      	bset	_b1000Hz
8992  1aaa               L3663:
8993                     ; 2416 if(++t0_cnt0>=100)
8995  1aaa 9c            	rvf
8996  1aab ce0002        	ldw	x,_t0_cnt0
8997  1aae 1c0001        	addw	x,#1
8998  1ab1 cf0002        	ldw	_t0_cnt0,x
8999  1ab4 a30064        	cpw	x,#100
9000  1ab7 2f67          	jrslt	L5663
9001                     ; 2418 	t0_cnt0=0;
9003  1ab9 5f            	clrw	x
9004  1aba cf0002        	ldw	_t0_cnt0,x
9005                     ; 2419 	b100Hz=1;
9007  1abd 7210000a      	bset	_b100Hz
9008                     ; 2421 	if(++t0_cnt5>=5)
9010  1ac1 725c0008      	inc	_t0_cnt5
9011  1ac5 c60008        	ld	a,_t0_cnt5
9012  1ac8 a105          	cp	a,#5
9013  1aca 2508          	jrult	L7663
9014                     ; 2423 		t0_cnt5=0;
9016  1acc 725f0008      	clr	_t0_cnt5
9017                     ; 2424 		b20Hz=1;
9019  1ad0 72100004      	bset	_b20Hz
9020  1ad4               L7663:
9021                     ; 2427 	if(++t0_cnt1>=10)
9023  1ad4 725c0004      	inc	_t0_cnt1
9024  1ad8 c60004        	ld	a,_t0_cnt1
9025  1adb a10a          	cp	a,#10
9026  1add 2508          	jrult	L1763
9027                     ; 2429 		t0_cnt1=0;
9029  1adf 725f0004      	clr	_t0_cnt1
9030                     ; 2430 		b10Hz=1;
9032  1ae3 72100009      	bset	_b10Hz
9033  1ae7               L1763:
9034                     ; 2433 	if(++t0_cnt2>=20)
9036  1ae7 725c0005      	inc	_t0_cnt2
9037  1aeb c60005        	ld	a,_t0_cnt2
9038  1aee a114          	cp	a,#20
9039  1af0 2508          	jrult	L3763
9040                     ; 2435 		t0_cnt2=0;
9042  1af2 725f0005      	clr	_t0_cnt2
9043                     ; 2436 		b5Hz=1;
9045  1af6 72100008      	bset	_b5Hz
9046  1afa               L3763:
9047                     ; 2440 	if(++t0_cnt4>=50)
9049  1afa 725c0007      	inc	_t0_cnt4
9050  1afe c60007        	ld	a,_t0_cnt4
9051  1b01 a132          	cp	a,#50
9052  1b03 2508          	jrult	L5763
9053                     ; 2442 		t0_cnt4=0;
9055  1b05 725f0007      	clr	_t0_cnt4
9056                     ; 2443 		b2Hz=1;
9058  1b09 72100007      	bset	_b2Hz
9059  1b0d               L5763:
9060                     ; 2446 	if(++t0_cnt3>=100)
9062  1b0d 725c0006      	inc	_t0_cnt3
9063  1b11 c60006        	ld	a,_t0_cnt3
9064  1b14 a164          	cp	a,#100
9065  1b16 2508          	jrult	L5663
9066                     ; 2448 		t0_cnt3=0;
9068  1b18 725f0006      	clr	_t0_cnt3
9069                     ; 2449 		b1Hz=1;
9071  1b1c 72100006      	bset	_b1Hz
9072  1b20               L5663:
9073                     ; 2455 }
9076  1b20 80            	iret
9101                     ; 2458 @far @interrupt void CAN_RX_Interrupt (void) 
9101                     ; 2459 {
9102                     	switch	.text
9103  1b21               f_CAN_RX_Interrupt:
9107                     ; 2461 CAN->PSR= 7;									// page 7 - read messsage
9109  1b21 35075427      	mov	21543,#7
9110                     ; 2463 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9112  1b25 ae000e        	ldw	x,#14
9113  1b28               L632:
9114  1b28 d65427        	ld	a,(21543,x)
9115  1b2b e7c9          	ld	(_mess-1,x),a
9116  1b2d 5a            	decw	x
9117  1b2e 26f8          	jrne	L632
9118                     ; 2474 bCAN_RX=1;
9120  1b30 35010004      	mov	_bCAN_RX,#1
9121                     ; 2475 CAN->RFR|=(1<<5);
9123  1b34 721a5424      	bset	21540,#5
9124                     ; 2477 }
9127  1b38 80            	iret
9150                     ; 2480 @far @interrupt void CAN_TX_Interrupt (void) 
9150                     ; 2481 {
9151                     	switch	.text
9152  1b39               f_CAN_TX_Interrupt:
9156                     ; 2482 if((CAN->TSR)&(1<<0))
9158  1b39 c65422        	ld	a,21538
9159  1b3c a501          	bcp	a,#1
9160  1b3e 2708          	jreq	L1273
9161                     ; 2484 	bTX_FREE=1;	
9163  1b40 35010003      	mov	_bTX_FREE,#1
9164                     ; 2486 	CAN->TSR|=(1<<0);
9166  1b44 72105422      	bset	21538,#0
9167  1b48               L1273:
9168                     ; 2488 }
9171  1b48 80            	iret
9251                     ; 2491 @far @interrupt void ADC2_EOC_Interrupt (void) {
9252                     	switch	.text
9253  1b49               f_ADC2_EOC_Interrupt:
9255       0000000d      OFST:	set	13
9256  1b49 be00          	ldw	x,c_x
9257  1b4b 89            	pushw	x
9258  1b4c be00          	ldw	x,c_y
9259  1b4e 89            	pushw	x
9260  1b4f be02          	ldw	x,c_lreg+2
9261  1b51 89            	pushw	x
9262  1b52 be00          	ldw	x,c_lreg
9263  1b54 89            	pushw	x
9264  1b55 520d          	subw	sp,#13
9267                     ; 2496 adc_plazma[2]++;
9269  1b57 bec0          	ldw	x,_adc_plazma+4
9270  1b59 1c0001        	addw	x,#1
9271  1b5c bfc0          	ldw	_adc_plazma+4,x
9272                     ; 2503 ADC2->CSR&=~(1<<7);
9274  1b5e 721f5400      	bres	21504,#7
9275                     ; 2505 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9277  1b62 c65405        	ld	a,21509
9278  1b65 b703          	ld	c_lreg+3,a
9279  1b67 3f02          	clr	c_lreg+2
9280  1b69 3f01          	clr	c_lreg+1
9281  1b6b 3f00          	clr	c_lreg
9282  1b6d 96            	ldw	x,sp
9283  1b6e 1c0001        	addw	x,#OFST-12
9284  1b71 cd0000        	call	c_rtol
9286  1b74 c65404        	ld	a,21508
9287  1b77 5f            	clrw	x
9288  1b78 97            	ld	xl,a
9289  1b79 90ae0100      	ldw	y,#256
9290  1b7d cd0000        	call	c_umul
9292  1b80 96            	ldw	x,sp
9293  1b81 1c0001        	addw	x,#OFST-12
9294  1b84 cd0000        	call	c_ladd
9296  1b87 96            	ldw	x,sp
9297  1b88 1c000a        	addw	x,#OFST-3
9298  1b8b cd0000        	call	c_rtol
9300                     ; 2510 if(adr_drv_stat==1)
9302  1b8e b602          	ld	a,_adr_drv_stat
9303  1b90 a101          	cp	a,#1
9304  1b92 260b          	jrne	L1673
9305                     ; 2512 	adr_drv_stat=2;
9307  1b94 35020002      	mov	_adr_drv_stat,#2
9308                     ; 2513 	adc_buff_[0]=temp_adc;
9310  1b98 1e0c          	ldw	x,(OFST-1,sp)
9311  1b9a cf0109        	ldw	_adc_buff_,x
9313  1b9d 2020          	jra	L3673
9314  1b9f               L1673:
9315                     ; 2516 else if(adr_drv_stat==3)
9317  1b9f b602          	ld	a,_adr_drv_stat
9318  1ba1 a103          	cp	a,#3
9319  1ba3 260b          	jrne	L5673
9320                     ; 2518 	adr_drv_stat=4;
9322  1ba5 35040002      	mov	_adr_drv_stat,#4
9323                     ; 2519 	adc_buff_[1]=temp_adc;
9325  1ba9 1e0c          	ldw	x,(OFST-1,sp)
9326  1bab cf010b        	ldw	_adc_buff_+2,x
9328  1bae 200f          	jra	L3673
9329  1bb0               L5673:
9330                     ; 2522 else if(adr_drv_stat==5)
9332  1bb0 b602          	ld	a,_adr_drv_stat
9333  1bb2 a105          	cp	a,#5
9334  1bb4 2609          	jrne	L3673
9335                     ; 2524 	adr_drv_stat=6;
9337  1bb6 35060002      	mov	_adr_drv_stat,#6
9338                     ; 2525 	adc_buff_[9]=temp_adc;
9340  1bba 1e0c          	ldw	x,(OFST-1,sp)
9341  1bbc cf011b        	ldw	_adc_buff_+18,x
9342  1bbf               L3673:
9343                     ; 2528 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
9345  1bbf b6ba          	ld	a,_adc_cnt_cnt
9346  1bc1 5f            	clrw	x
9347  1bc2 97            	ld	xl,a
9348  1bc3 58            	sllw	x
9349  1bc4 1f03          	ldw	(OFST-10,sp),x
9350  1bc6 b6c9          	ld	a,_adc_ch
9351  1bc8 97            	ld	xl,a
9352  1bc9 a610          	ld	a,#16
9353  1bcb 42            	mul	x,a
9354  1bcc 72fb03        	addw	x,(OFST-10,sp)
9355  1bcf 160c          	ldw	y,(OFST-1,sp)
9356  1bd1 df0060        	ldw	(_adc_buff_buff,x),y
9357                     ; 2530 adc_ch++;
9359  1bd4 3cc9          	inc	_adc_ch
9360                     ; 2531 if(adc_ch>=6)
9362  1bd6 b6c9          	ld	a,_adc_ch
9363  1bd8 a106          	cp	a,#6
9364  1bda 2516          	jrult	L3773
9365                     ; 2533 	adc_ch=0;
9367  1bdc 3fc9          	clr	_adc_ch
9368                     ; 2534 	adc_cnt_cnt++;
9370  1bde 3cba          	inc	_adc_cnt_cnt
9371                     ; 2535 	if(adc_cnt_cnt>=8)
9373  1be0 b6ba          	ld	a,_adc_cnt_cnt
9374  1be2 a108          	cp	a,#8
9375  1be4 250c          	jrult	L3773
9376                     ; 2537 		adc_cnt_cnt=0;
9378  1be6 3fba          	clr	_adc_cnt_cnt
9379                     ; 2538 		adc_cnt++;
9381  1be8 3cc8          	inc	_adc_cnt
9382                     ; 2539 		if(adc_cnt>=16)
9384  1bea b6c8          	ld	a,_adc_cnt
9385  1bec a110          	cp	a,#16
9386  1bee 2502          	jrult	L3773
9387                     ; 2541 			adc_cnt=0;
9389  1bf0 3fc8          	clr	_adc_cnt
9390  1bf2               L3773:
9391                     ; 2545 if(adc_cnt_cnt==0)
9393  1bf2 3dba          	tnz	_adc_cnt_cnt
9394  1bf4 2660          	jrne	L1004
9395                     ; 2549 	tempSS=0;
9397  1bf6 ae0000        	ldw	x,#0
9398  1bf9 1f07          	ldw	(OFST-6,sp),x
9399  1bfb ae0000        	ldw	x,#0
9400  1bfe 1f05          	ldw	(OFST-8,sp),x
9401                     ; 2550 	for(i=0;i<8;i++)
9403  1c00 0f09          	clr	(OFST-4,sp)
9404  1c02               L3004:
9405                     ; 2552 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9407  1c02 7b09          	ld	a,(OFST-4,sp)
9408  1c04 5f            	clrw	x
9409  1c05 97            	ld	xl,a
9410  1c06 58            	sllw	x
9411  1c07 1f03          	ldw	(OFST-10,sp),x
9412  1c09 b6c9          	ld	a,_adc_ch
9413  1c0b 97            	ld	xl,a
9414  1c0c a610          	ld	a,#16
9415  1c0e 42            	mul	x,a
9416  1c0f 72fb03        	addw	x,(OFST-10,sp)
9417  1c12 de0060        	ldw	x,(_adc_buff_buff,x)
9418  1c15 cd0000        	call	c_itolx
9420  1c18 96            	ldw	x,sp
9421  1c19 1c0005        	addw	x,#OFST-8
9422  1c1c cd0000        	call	c_lgadd
9424                     ; 2550 	for(i=0;i<8;i++)
9426  1c1f 0c09          	inc	(OFST-4,sp)
9429  1c21 7b09          	ld	a,(OFST-4,sp)
9430  1c23 a108          	cp	a,#8
9431  1c25 25db          	jrult	L3004
9432                     ; 2554 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9434  1c27 96            	ldw	x,sp
9435  1c28 1c0005        	addw	x,#OFST-8
9436  1c2b cd0000        	call	c_ltor
9438  1c2e a603          	ld	a,#3
9439  1c30 cd0000        	call	c_lrsh
9441  1c33 be02          	ldw	x,c_lreg+2
9442  1c35 b6c8          	ld	a,_adc_cnt
9443  1c37 905f          	clrw	y
9444  1c39 9097          	ld	yl,a
9445  1c3b 9058          	sllw	y
9446  1c3d 1703          	ldw	(OFST-10,sp),y
9447  1c3f b6c9          	ld	a,_adc_ch
9448  1c41 905f          	clrw	y
9449  1c43 9097          	ld	yl,a
9450  1c45 9058          	sllw	y
9451  1c47 9058          	sllw	y
9452  1c49 9058          	sllw	y
9453  1c4b 9058          	sllw	y
9454  1c4d 9058          	sllw	y
9455  1c4f 72f903        	addw	y,(OFST-10,sp)
9456  1c52 90df011d      	ldw	(_adc_buff,y),x
9457  1c56               L1004:
9458                     ; 2558 if((adc_cnt&0x03)==0)
9460  1c56 b6c8          	ld	a,_adc_cnt
9461  1c58 a503          	bcp	a,#3
9462  1c5a 264b          	jrne	L1104
9463                     ; 2562 	tempSS=0;
9465  1c5c ae0000        	ldw	x,#0
9466  1c5f 1f07          	ldw	(OFST-6,sp),x
9467  1c61 ae0000        	ldw	x,#0
9468  1c64 1f05          	ldw	(OFST-8,sp),x
9469                     ; 2563 	for(i=0;i<16;i++)
9471  1c66 0f09          	clr	(OFST-4,sp)
9472  1c68               L3104:
9473                     ; 2565 		tempSS+=(signed long)adc_buff[adc_ch][i];
9475  1c68 7b09          	ld	a,(OFST-4,sp)
9476  1c6a 5f            	clrw	x
9477  1c6b 97            	ld	xl,a
9478  1c6c 58            	sllw	x
9479  1c6d 1f03          	ldw	(OFST-10,sp),x
9480  1c6f b6c9          	ld	a,_adc_ch
9481  1c71 97            	ld	xl,a
9482  1c72 a620          	ld	a,#32
9483  1c74 42            	mul	x,a
9484  1c75 72fb03        	addw	x,(OFST-10,sp)
9485  1c78 de011d        	ldw	x,(_adc_buff,x)
9486  1c7b cd0000        	call	c_itolx
9488  1c7e 96            	ldw	x,sp
9489  1c7f 1c0005        	addw	x,#OFST-8
9490  1c82 cd0000        	call	c_lgadd
9492                     ; 2563 	for(i=0;i<16;i++)
9494  1c85 0c09          	inc	(OFST-4,sp)
9497  1c87 7b09          	ld	a,(OFST-4,sp)
9498  1c89 a110          	cp	a,#16
9499  1c8b 25db          	jrult	L3104
9500                     ; 2567 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9502  1c8d 96            	ldw	x,sp
9503  1c8e 1c0005        	addw	x,#OFST-8
9504  1c91 cd0000        	call	c_ltor
9506  1c94 a604          	ld	a,#4
9507  1c96 cd0000        	call	c_lrsh
9509  1c99 be02          	ldw	x,c_lreg+2
9510  1c9b b6c9          	ld	a,_adc_ch
9511  1c9d 905f          	clrw	y
9512  1c9f 9097          	ld	yl,a
9513  1ca1 9058          	sllw	y
9514  1ca3 90df0109      	ldw	(_adc_buff_,y),x
9515  1ca7               L1104:
9516                     ; 2574 if(adc_ch==0)adc_buff_5=temp_adc;
9518  1ca7 3dc9          	tnz	_adc_ch
9519  1ca9 2605          	jrne	L1204
9522  1cab 1e0c          	ldw	x,(OFST-1,sp)
9523  1cad cf0107        	ldw	_adc_buff_5,x
9524  1cb0               L1204:
9525                     ; 2575 if(adc_ch==2)adc_buff_1=temp_adc;
9527  1cb0 b6c9          	ld	a,_adc_ch
9528  1cb2 a102          	cp	a,#2
9529  1cb4 2605          	jrne	L3204
9532  1cb6 1e0c          	ldw	x,(OFST-1,sp)
9533  1cb8 cf0105        	ldw	_adc_buff_1,x
9534  1cbb               L3204:
9535                     ; 2577 adc_plazma_short++;
9537  1cbb bec6          	ldw	x,_adc_plazma_short
9538  1cbd 1c0001        	addw	x,#1
9539  1cc0 bfc6          	ldw	_adc_plazma_short,x
9540                     ; 2579 }
9543  1cc2 5b0d          	addw	sp,#13
9544  1cc4 85            	popw	x
9545  1cc5 bf00          	ldw	c_lreg,x
9546  1cc7 85            	popw	x
9547  1cc8 bf02          	ldw	c_lreg+2,x
9548  1cca 85            	popw	x
9549  1ccb bf00          	ldw	c_y,x
9550  1ccd 85            	popw	x
9551  1cce bf00          	ldw	c_x,x
9552  1cd0 80            	iret
9612                     ; 2588 main()
9612                     ; 2589 {
9614                     	switch	.text
9615  1cd1               _main:
9619                     ; 2591 CLK->ECKR|=1;
9621  1cd1 721050c1      	bset	20673,#0
9623  1cd5               L7304:
9624                     ; 2592 while((CLK->ECKR & 2) == 0);
9626  1cd5 c650c1        	ld	a,20673
9627  1cd8 a502          	bcp	a,#2
9628  1cda 27f9          	jreq	L7304
9629                     ; 2593 CLK->SWCR|=2;
9631  1cdc 721250c5      	bset	20677,#1
9632                     ; 2594 CLK->SWR=0xB4;
9634  1ce0 35b450c4      	mov	20676,#180
9635                     ; 2596 delay_ms(200);
9637  1ce4 ae00c8        	ldw	x,#200
9638  1ce7 cd0121        	call	_delay_ms
9640                     ; 2597 FLASH_DUKR=0xae;
9642  1cea 35ae5064      	mov	_FLASH_DUKR,#174
9643                     ; 2598 FLASH_DUKR=0x56;
9645  1cee 35565064      	mov	_FLASH_DUKR,#86
9646                     ; 2599 enableInterrupts();
9649  1cf2 9a            rim
9651                     ; 2602 adr_drv_v3();
9654  1cf3 cd0f9d        	call	_adr_drv_v3
9656                     ; 2606 t4_init();
9658  1cf6 cd19b8        	call	_t4_init
9660                     ; 2608 		GPIOG->DDR|=(1<<0);
9662  1cf9 72105020      	bset	20512,#0
9663                     ; 2609 		GPIOG->CR1|=(1<<0);
9665  1cfd 72105021      	bset	20513,#0
9666                     ; 2610 		GPIOG->CR2&=~(1<<0);	
9668  1d01 72115022      	bres	20514,#0
9669                     ; 2613 		GPIOG->DDR&=~(1<<1);
9671  1d05 72135020      	bres	20512,#1
9672                     ; 2614 		GPIOG->CR1|=(1<<1);
9674  1d09 72125021      	bset	20513,#1
9675                     ; 2615 		GPIOG->CR2&=~(1<<1);
9677  1d0d 72135022      	bres	20514,#1
9678                     ; 2617 init_CAN();
9680  1d11 cd118d        	call	_init_CAN
9682                     ; 2622 GPIOC->DDR|=(1<<1);
9684  1d14 7212500c      	bset	20492,#1
9685                     ; 2623 GPIOC->CR1|=(1<<1);
9687  1d18 7212500d      	bset	20493,#1
9688                     ; 2624 GPIOC->CR2|=(1<<1);
9690  1d1c 7212500e      	bset	20494,#1
9691                     ; 2626 GPIOC->DDR|=(1<<2);
9693  1d20 7214500c      	bset	20492,#2
9694                     ; 2627 GPIOC->CR1|=(1<<2);
9696  1d24 7214500d      	bset	20493,#2
9697                     ; 2628 GPIOC->CR2|=(1<<2);
9699  1d28 7214500e      	bset	20494,#2
9700                     ; 2635 t1_init();
9702  1d2c cd19c9        	call	_t1_init
9704                     ; 2637 GPIOA->DDR|=(1<<5);
9706  1d2f 721a5002      	bset	20482,#5
9707                     ; 2638 GPIOA->CR1|=(1<<5);
9709  1d33 721a5003      	bset	20483,#5
9710                     ; 2639 GPIOA->CR2&=~(1<<5);
9712  1d37 721b5004      	bres	20484,#5
9713                     ; 2645 GPIOB->DDR&=~(1<<3);
9715  1d3b 72175007      	bres	20487,#3
9716                     ; 2646 GPIOB->CR1&=~(1<<3);
9718  1d3f 72175008      	bres	20488,#3
9719                     ; 2647 GPIOB->CR2&=~(1<<3);
9721  1d43 72175009      	bres	20489,#3
9722                     ; 2649 GPIOC->DDR|=(1<<3);
9724  1d47 7216500c      	bset	20492,#3
9725                     ; 2650 GPIOC->CR1|=(1<<3);
9727  1d4b 7216500d      	bset	20493,#3
9728                     ; 2651 GPIOC->CR2|=(1<<3);
9730  1d4f 7216500e      	bset	20494,#3
9731                     ; 2653 U_out_const=ee_UAVT;
9733  1d53 ce000c        	ldw	x,_ee_UAVT
9734  1d56 cf0012        	ldw	_U_out_const,x
9735  1d59               L3404:
9736                     ; 2657 	if(b1000Hz)
9738                     	btst	_b1000Hz
9739  1d5e 240a          	jruge	L7404
9740                     ; 2659 		b1000Hz=0;
9742  1d60 72110005      	bres	_b1000Hz
9743                     ; 2661 		adc2_init();
9745  1d64 cd1a06        	call	_adc2_init
9747                     ; 2663 		pwr_hndl_new();
9749  1d67 cd0885        	call	_pwr_hndl_new
9751  1d6a               L7404:
9752                     ; 2665 	if(bCAN_RX)
9754  1d6a 3d04          	tnz	_bCAN_RX
9755  1d6c 2705          	jreq	L1504
9756                     ; 2667 		bCAN_RX=0;
9758  1d6e 3f04          	clr	_bCAN_RX
9759                     ; 2668 		can_in_an();	
9761  1d70 cd12ea        	call	_can_in_an
9763  1d73               L1504:
9764                     ; 2670 	if(b100Hz)
9766                     	btst	_b100Hz
9767  1d78 2407          	jruge	L3504
9768                     ; 2672 		b100Hz=0;
9770  1d7a 7211000a      	bres	_b100Hz
9771                     ; 2682 		can_tx_hndl();
9773  1d7e cd1280        	call	_can_tx_hndl
9775  1d81               L3504:
9776                     ; 2686 	if(b20Hz)
9778                     	btst	_b20Hz
9779  1d86 2404          	jruge	L5504
9780                     ; 2688 		b20Hz=0;
9782  1d88 72110004      	bres	_b20Hz
9783  1d8c               L5504:
9784                     ; 2694 	if(b10Hz)
9786                     	btst	_b10Hz
9787  1d91 2425          	jruge	L7504
9788                     ; 2696 		b10Hz=0;
9790  1d93 72110009      	bres	_b10Hz
9791                     ; 2697 		led_drv();
9793  1d97 cd03ee        	call	_led_drv
9795                     ; 2698 		matemat();
9797  1d9a cd0a9d        	call	_matemat
9799                     ; 2700 	  link_drv();
9801  1d9d cd04dc        	call	_link_drv
9803                     ; 2702 	  JP_drv();
9805  1da0 cd0451        	call	_JP_drv
9807                     ; 2703 	  flags_drv();
9809  1da3 cd0f52        	call	_flags_drv
9811                     ; 2705 		if(main_cnt10<100)main_cnt10++;
9813  1da6 9c            	rvf
9814  1da7 ce025d        	ldw	x,_main_cnt10
9815  1daa a30064        	cpw	x,#100
9816  1dad 2e09          	jrsge	L7504
9819  1daf ce025d        	ldw	x,_main_cnt10
9820  1db2 1c0001        	addw	x,#1
9821  1db5 cf025d        	ldw	_main_cnt10,x
9822  1db8               L7504:
9823                     ; 2708 	if(b5Hz)
9825                     	btst	_b5Hz
9826  1dbd 2419          	jruge	L3604
9827                     ; 2710 		b5Hz=0;
9829  1dbf 72110008      	bres	_b5Hz
9830                     ; 2717 		led_hndl();
9832  1dc3 cd0163        	call	_led_hndl
9834                     ; 2719 		vent_drv();
9836  1dc6 cd0534        	call	_vent_drv
9838                     ; 2721 		if(main_cnt1<1000)main_cnt1++;
9840  1dc9 9c            	rvf
9841  1dca be5e          	ldw	x,_main_cnt1
9842  1dcc a303e8        	cpw	x,#1000
9843  1dcf 2e07          	jrsge	L3604
9846  1dd1 be5e          	ldw	x,_main_cnt1
9847  1dd3 1c0001        	addw	x,#1
9848  1dd6 bf5e          	ldw	_main_cnt1,x
9849  1dd8               L3604:
9850                     ; 2724 	if(b2Hz)
9852                     	btst	_b2Hz
9853  1ddd 240d          	jruge	L7604
9854                     ; 2726 		b2Hz=0;
9856  1ddf 72110007      	bres	_b2Hz
9857                     ; 2730 		temper_drv();
9859  1de3 cd0cbf        	call	_temper_drv
9861                     ; 2731 		u_drv();
9863  1de6 cd0d96        	call	_u_drv
9865                     ; 2732 		vent_resurs_hndl();
9867  1de9 cd0000        	call	_vent_resurs_hndl
9869  1dec               L7604:
9870                     ; 2735 	if(b1Hz)
9872                     	btst	_b1Hz
9873  1df1 2503cc1d59    	jruge	L3404
9874                     ; 2737 		b1Hz=0;
9876  1df6 72110006      	bres	_b1Hz
9877                     ; 2743 		if(main_cnt<1000)main_cnt++;
9879  1dfa 9c            	rvf
9880  1dfb ce025f        	ldw	x,_main_cnt
9881  1dfe a303e8        	cpw	x,#1000
9882  1e01 2e09          	jrsge	L3704
9885  1e03 ce025f        	ldw	x,_main_cnt
9886  1e06 1c0001        	addw	x,#1
9887  1e09 cf025f        	ldw	_main_cnt,x
9888  1e0c               L3704:
9889                     ; 2744   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9891  1e0c b670          	ld	a,_link
9892  1e0e a1aa          	cp	a,#170
9893  1e10 2706          	jreq	L7704
9895  1e12 b655          	ld	a,_jp_mode
9896  1e14 a103          	cp	a,#3
9897  1e16 2603          	jrne	L5704
9898  1e18               L7704:
9901  1e18 cd0eb3        	call	_apv_hndl
9903  1e1b               L5704:
9904                     ; 2747   		can_error_cnt++;
9906  1e1b 3c76          	inc	_can_error_cnt
9907                     ; 2748   		if(can_error_cnt>=10)
9909  1e1d b676          	ld	a,_can_error_cnt
9910  1e1f a10a          	cp	a,#10
9911  1e21 2403          	jruge	L642
9912  1e23 cc1d59        	jp	L3404
9913  1e26               L642:
9914                     ; 2750   			can_error_cnt=0;
9916  1e26 3f76          	clr	_can_error_cnt
9917                     ; 2751 				init_CAN();
9919  1e28 cd118d        	call	_init_CAN
9921  1e2b ac591d59      	jpf	L3404
11241                     	xdef	_main
11242                     	xdef	f_ADC2_EOC_Interrupt
11243                     	xdef	f_CAN_TX_Interrupt
11244                     	xdef	f_CAN_RX_Interrupt
11245                     	xdef	f_TIM4_UPD_Interrupt
11246                     	xdef	_adc2_init
11247                     	xdef	_t1_init
11248                     	xdef	_t4_init
11249                     	xdef	_can_in_an
11250                     	xdef	_can_tx_hndl
11251                     	xdef	_can_transmit
11252                     	xdef	_init_CAN
11253                     	xdef	_adr_drv_v3
11254                     	xdef	_adr_drv_v4
11255                     	xdef	_flags_drv
11256                     	xdef	_apv_hndl
11257                     	xdef	_apv_stop
11258                     	xdef	_apv_start
11259                     	xdef	_u_drv
11260                     	xdef	_temper_drv
11261                     	xdef	_matemat
11262                     	xdef	_pwr_hndl_new
11263                     	xdef	_pwr_hndl
11264                     	xdef	_pwr_drv
11265                     	xdef	_vent_drv
11266                     	xdef	_link_drv
11267                     	xdef	_JP_drv
11268                     	xdef	_led_drv
11269                     	xdef	_led_hndl
11270                     	xdef	_delay_ms
11271                     	xdef	_granee
11272                     	xdef	_gran
11273                     	xdef	_vent_resurs_hndl
11274                     	switch	.ubsct
11275  0001               _debug_info_to_uku:
11276  0001 000000000000  	ds.b	6
11277                     	xdef	_debug_info_to_uku
11278  0007               _pwm_u_cnt:
11279  0007 00            	ds.b	1
11280                     	xdef	_pwm_u_cnt
11281  0008               _vent_resurs_tx_cnt:
11282  0008 00            	ds.b	1
11283                     	xdef	_vent_resurs_tx_cnt
11284                     	switch	.bss
11285  0000               _vent_resurs_buff:
11286  0000 00000000      	ds.b	4
11287                     	xdef	_vent_resurs_buff
11288                     	switch	.ubsct
11289  0009               _vent_resurs_sec_cnt:
11290  0009 0000          	ds.b	2
11291                     	xdef	_vent_resurs_sec_cnt
11292                     .eeprom:	section	.data
11293  0000               _vent_resurs:
11294  0000 0000          	ds.b	2
11295                     	xdef	_vent_resurs
11296  0002               _ee_IMAXVENT:
11297  0002 0000          	ds.b	2
11298                     	xdef	_ee_IMAXVENT
11299                     	switch	.ubsct
11300  000b               _bps_class:
11301  000b 00            	ds.b	1
11302                     	xdef	_bps_class
11303  000c               _vent_pwm_integr_cnt:
11304  000c 0000          	ds.b	2
11305                     	xdef	_vent_pwm_integr_cnt
11306  000e               _vent_pwm_integr:
11307  000e 0000          	ds.b	2
11308                     	xdef	_vent_pwm_integr
11309  0010               _vent_pwm:
11310  0010 0000          	ds.b	2
11311                     	xdef	_vent_pwm
11312  0012               _pwm_vent_cnt:
11313  0012 00            	ds.b	1
11314                     	xdef	_pwm_vent_cnt
11315                     	switch	.eeprom
11316  0004               _ee_DEVICE:
11317  0004 0000          	ds.b	2
11318                     	xdef	_ee_DEVICE
11319  0006               _ee_AVT_MODE:
11320  0006 0000          	ds.b	2
11321                     	xdef	_ee_AVT_MODE
11322                     	switch	.ubsct
11323  0013               _FADE_MODE:
11324  0013 00            	ds.b	1
11325                     	xdef	_FADE_MODE
11326  0014               _i_main_bps_cnt:
11327  0014 000000000000  	ds.b	6
11328                     	xdef	_i_main_bps_cnt
11329  001a               _i_main_sigma:
11330  001a 0000          	ds.b	2
11331                     	xdef	_i_main_sigma
11332  001c               _i_main_num_of_bps:
11333  001c 00            	ds.b	1
11334                     	xdef	_i_main_num_of_bps
11335  001d               _i_main_avg:
11336  001d 0000          	ds.b	2
11337                     	xdef	_i_main_avg
11338  001f               _i_main_flag:
11339  001f 000000000000  	ds.b	6
11340                     	xdef	_i_main_flag
11341  0025               _i_main:
11342  0025 000000000000  	ds.b	12
11343                     	xdef	_i_main
11344  0031               _x:
11345  0031 000000000000  	ds.b	12
11346                     	xdef	_x
11347                     	xdef	_volum_u_main_
11348                     	switch	.eeprom
11349  0008               _UU_AVT:
11350  0008 0000          	ds.b	2
11351                     	xdef	_UU_AVT
11352                     	switch	.ubsct
11353  003d               _cnt_net_drv:
11354  003d 00            	ds.b	1
11355                     	xdef	_cnt_net_drv
11356                     	switch	.bit
11357  0001               _bMAIN:
11358  0001 00            	ds.b	1
11359                     	xdef	_bMAIN
11360                     	switch	.ubsct
11361  003e               _plazma_int:
11362  003e 000000000000  	ds.b	6
11363                     	xdef	_plazma_int
11364                     	xdef	_rotor_int
11365  0044               _led_green_buff:
11366  0044 00000000      	ds.b	4
11367                     	xdef	_led_green_buff
11368  0048               _led_red_buff:
11369  0048 00000000      	ds.b	4
11370                     	xdef	_led_red_buff
11371                     	xdef	_led_drv_cnt
11372                     	xdef	_led_green
11373                     	xdef	_led_red
11374  004c               _res_fl_cnt:
11375  004c 00            	ds.b	1
11376                     	xdef	_res_fl_cnt
11377                     	xdef	_bRES_
11378                     	xdef	_bRES
11379                     	switch	.eeprom
11380  000a               _res_fl_:
11381  000a 00            	ds.b	1
11382                     	xdef	_res_fl_
11383  000b               _res_fl:
11384  000b 00            	ds.b	1
11385                     	xdef	_res_fl
11386                     	switch	.ubsct
11387  004d               _cnt_apv_off:
11388  004d 00            	ds.b	1
11389                     	xdef	_cnt_apv_off
11390                     	switch	.bit
11391  0002               _bAPV:
11392  0002 00            	ds.b	1
11393                     	xdef	_bAPV
11394                     	switch	.ubsct
11395  004e               _apv_cnt_:
11396  004e 0000          	ds.b	2
11397                     	xdef	_apv_cnt_
11398  0050               _apv_cnt:
11399  0050 000000        	ds.b	3
11400                     	xdef	_apv_cnt
11401                     	xdef	_bBL_IPS
11402                     	switch	.bit
11403  0003               _bBL:
11404  0003 00            	ds.b	1
11405                     	xdef	_bBL
11406                     	switch	.ubsct
11407  0053               _cnt_JP1:
11408  0053 00            	ds.b	1
11409                     	xdef	_cnt_JP1
11410  0054               _cnt_JP0:
11411  0054 00            	ds.b	1
11412                     	xdef	_cnt_JP0
11413  0055               _jp_mode:
11414  0055 00            	ds.b	1
11415                     	xdef	_jp_mode
11416  0056               _pwm_delt:
11417  0056 0000          	ds.b	2
11418                     	xdef	_pwm_delt
11419  0058               _pwm_u_:
11420  0058 0000          	ds.b	2
11421                     	xdef	_pwm_u_
11422                     	xdef	_pwm_i
11423                     	xdef	_pwm_u
11424  005a               _tmax_cnt:
11425  005a 0000          	ds.b	2
11426                     	xdef	_tmax_cnt
11427  005c               _tsign_cnt:
11428  005c 0000          	ds.b	2
11429                     	xdef	_tsign_cnt
11430                     	switch	.eeprom
11431  000c               _ee_UAVT:
11432  000c 0000          	ds.b	2
11433                     	xdef	_ee_UAVT
11434  000e               _ee_tsign:
11435  000e 0000          	ds.b	2
11436                     	xdef	_ee_tsign
11437  0010               _ee_tmax:
11438  0010 0000          	ds.b	2
11439                     	xdef	_ee_tmax
11440  0012               _ee_dU:
11441  0012 0000          	ds.b	2
11442                     	xdef	_ee_dU
11443  0014               _ee_Umax:
11444  0014 0000          	ds.b	2
11445                     	xdef	_ee_Umax
11446  0016               _ee_TZAS:
11447  0016 0000          	ds.b	2
11448                     	xdef	_ee_TZAS
11449                     	switch	.ubsct
11450  005e               _main_cnt1:
11451  005e 0000          	ds.b	2
11452                     	xdef	_main_cnt1
11453  0060               _off_bp_cnt:
11454  0060 00            	ds.b	1
11455                     	xdef	_off_bp_cnt
11456                     	xdef	_vol_i_temp_avar
11457  0061               _flags_tu_cnt_off:
11458  0061 00            	ds.b	1
11459                     	xdef	_flags_tu_cnt_off
11460  0062               _flags_tu_cnt_on:
11461  0062 00            	ds.b	1
11462                     	xdef	_flags_tu_cnt_on
11463  0063               _vol_i_temp:
11464  0063 0000          	ds.b	2
11465                     	xdef	_vol_i_temp
11466  0065               _vol_u_temp:
11467  0065 0000          	ds.b	2
11468                     	xdef	_vol_u_temp
11469                     	switch	.eeprom
11470  0018               __x_ee_:
11471  0018 0000          	ds.b	2
11472                     	xdef	__x_ee_
11473                     	switch	.ubsct
11474  0067               __x_cnt:
11475  0067 0000          	ds.b	2
11476                     	xdef	__x_cnt
11477  0069               __x__:
11478  0069 0000          	ds.b	2
11479                     	xdef	__x__
11480  006b               __x_:
11481  006b 0000          	ds.b	2
11482                     	xdef	__x_
11483  006d               _flags_tu:
11484  006d 00            	ds.b	1
11485                     	xdef	_flags_tu
11486                     	xdef	_flags
11487  006e               _link_cnt:
11488  006e 0000          	ds.b	2
11489                     	xdef	_link_cnt
11490  0070               _link:
11491  0070 00            	ds.b	1
11492                     	xdef	_link
11493  0071               _umin_cnt:
11494  0071 0000          	ds.b	2
11495                     	xdef	_umin_cnt
11496  0073               _umax_cnt:
11497  0073 0000          	ds.b	2
11498                     	xdef	_umax_cnt
11499                     	switch	.bss
11500  0004               _pwm_schot_cnt:
11501  0004 0000          	ds.b	2
11502                     	xdef	_pwm_schot_cnt
11503  0006               _pwm_peace_cnt_:
11504  0006 0000          	ds.b	2
11505                     	xdef	_pwm_peace_cnt_
11506  0008               _pwm_peace_cnt:
11507  0008 0000          	ds.b	2
11508                     	xdef	_pwm_peace_cnt
11509                     	switch	.eeprom
11510  001a               _ee_K:
11511  001a 000000000000  	ds.b	20
11512                     	xdef	_ee_K
11513                     	switch	.ubsct
11514  0075               _T:
11515  0075 00            	ds.b	1
11516                     	xdef	_T
11517                     	switch	.bss
11518  000a               _Ufade:
11519  000a 0000          	ds.b	2
11520                     	xdef	_Ufade
11521  000c               _Udelt:
11522  000c 0000          	ds.b	2
11523                     	xdef	_Udelt
11524  000e               _Uin:
11525  000e 0000          	ds.b	2
11526                     	xdef	_Uin
11527  0010               _Usum:
11528  0010 0000          	ds.b	2
11529                     	xdef	_Usum
11530  0012               _U_out_const:
11531  0012 0000          	ds.b	2
11532                     	xdef	_U_out_const
11533  0014               _Unecc:
11534  0014 0000          	ds.b	2
11535                     	xdef	_Unecc
11536  0016               _Ui:
11537  0016 0000          	ds.b	2
11538                     	xdef	_Ui
11539  0018               _Un:
11540  0018 0000          	ds.b	2
11541                     	xdef	_Un
11542  001a               _I:
11543  001a 0000          	ds.b	2
11544                     	xdef	_I
11545                     	switch	.ubsct
11546  0076               _can_error_cnt:
11547  0076 00            	ds.b	1
11548                     	xdef	_can_error_cnt
11549                     	xdef	_bCAN_RX
11550  0077               _tx_busy_cnt:
11551  0077 00            	ds.b	1
11552                     	xdef	_tx_busy_cnt
11553                     	xdef	_bTX_FREE
11554  0078               _can_buff_rd_ptr:
11555  0078 00            	ds.b	1
11556                     	xdef	_can_buff_rd_ptr
11557  0079               _can_buff_wr_ptr:
11558  0079 00            	ds.b	1
11559                     	xdef	_can_buff_wr_ptr
11560  007a               _can_out_buff:
11561  007a 000000000000  	ds.b	64
11562                     	xdef	_can_out_buff
11563                     	switch	.bss
11564  001c               _pwm_u_buff_cnt:
11565  001c 00            	ds.b	1
11566                     	xdef	_pwm_u_buff_cnt
11567  001d               _pwm_u_buff_ptr:
11568  001d 00            	ds.b	1
11569                     	xdef	_pwm_u_buff_ptr
11570  001e               _pwm_u_buff_:
11571  001e 0000          	ds.b	2
11572                     	xdef	_pwm_u_buff_
11573  0020               _pwm_u_buff:
11574  0020 000000000000  	ds.b	64
11575                     	xdef	_pwm_u_buff
11576                     	switch	.ubsct
11577  00ba               _adc_cnt_cnt:
11578  00ba 00            	ds.b	1
11579                     	xdef	_adc_cnt_cnt
11580                     	switch	.bss
11581  0060               _adc_buff_buff:
11582  0060 000000000000  	ds.b	160
11583                     	xdef	_adc_buff_buff
11584  0100               _adress_error:
11585  0100 00            	ds.b	1
11586                     	xdef	_adress_error
11587  0101               _adress:
11588  0101 00            	ds.b	1
11589                     	xdef	_adress
11590  0102               _adr:
11591  0102 000000        	ds.b	3
11592                     	xdef	_adr
11593                     	xdef	_adr_drv_stat
11594                     	xdef	_led_ind
11595                     	switch	.ubsct
11596  00bb               _led_ind_cnt:
11597  00bb 00            	ds.b	1
11598                     	xdef	_led_ind_cnt
11599  00bc               _adc_plazma:
11600  00bc 000000000000  	ds.b	10
11601                     	xdef	_adc_plazma
11602  00c6               _adc_plazma_short:
11603  00c6 0000          	ds.b	2
11604                     	xdef	_adc_plazma_short
11605  00c8               _adc_cnt:
11606  00c8 00            	ds.b	1
11607                     	xdef	_adc_cnt
11608  00c9               _adc_ch:
11609  00c9 00            	ds.b	1
11610                     	xdef	_adc_ch
11611                     	switch	.bss
11612  0105               _adc_buff_1:
11613  0105 0000          	ds.b	2
11614                     	xdef	_adc_buff_1
11615  0107               _adc_buff_5:
11616  0107 0000          	ds.b	2
11617                     	xdef	_adc_buff_5
11618  0109               _adc_buff_:
11619  0109 000000000000  	ds.b	20
11620                     	xdef	_adc_buff_
11621  011d               _adc_buff:
11622  011d 000000000000  	ds.b	320
11623                     	xdef	_adc_buff
11624  025d               _main_cnt10:
11625  025d 0000          	ds.b	2
11626                     	xdef	_main_cnt10
11627  025f               _main_cnt:
11628  025f 0000          	ds.b	2
11629                     	xdef	_main_cnt
11630                     	switch	.ubsct
11631  00ca               _mess:
11632  00ca 000000000000  	ds.b	14
11633                     	xdef	_mess
11634                     	switch	.bit
11635  0004               _b20Hz:
11636  0004 00            	ds.b	1
11637                     	xdef	_b20Hz
11638  0005               _b1000Hz:
11639  0005 00            	ds.b	1
11640                     	xdef	_b1000Hz
11641  0006               _b1Hz:
11642  0006 00            	ds.b	1
11643                     	xdef	_b1Hz
11644  0007               _b2Hz:
11645  0007 00            	ds.b	1
11646                     	xdef	_b2Hz
11647  0008               _b5Hz:
11648  0008 00            	ds.b	1
11649                     	xdef	_b5Hz
11650  0009               _b10Hz:
11651  0009 00            	ds.b	1
11652                     	xdef	_b10Hz
11653  000a               _b100Hz:
11654  000a 00            	ds.b	1
11655                     	xdef	_b100Hz
11656                     	xdef	_t0_cnt5
11657                     	xdef	_t0_cnt4
11658                     	xdef	_t0_cnt3
11659                     	xdef	_t0_cnt2
11660                     	xdef	_t0_cnt1
11661                     	xdef	_t0_cnt0
11662                     	xdef	_t0_cnt00
11663                     	xref	_abs
11664                     	xdef	_bVENT_BLOCK
11665                     	xref.b	c_lreg
11666                     	xref.b	c_x
11667                     	xref.b	c_y
11687                     	xref	c_lrsh
11688                     	xref	c_umul
11689                     	xref	c_lgsub
11690                     	xref	c_lgrsh
11691                     	xref	c_lgadd
11692                     	xref	c_idiv
11693                     	xref	c_sdivx
11694                     	xref	c_imul
11695                     	xref	c_lsbc
11696                     	xref	c_ladd
11697                     	xref	c_lsub
11698                     	xref	c_ldiv
11699                     	xref	c_lgmul
11700                     	xref	c_itolx
11701                     	xref	c_eewrc
11702                     	xref	c_ltor
11703                     	xref	c_lgadc
11704                     	xref	c_rtol
11705                     	xref	c_vmul
11706                     	xref	c_eewrw
11707                     	xref	c_lcmp
11708                     	xref	c_uitolx
11709                     	end
