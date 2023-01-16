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
4533                     	switch	.const
4534  001c               L46:
4535  001c 000003e8      	dc.l	1000
4536                     ; 959 void pwr_hndl_new(void)				
4536                     ; 960 {
4537                     	switch	.text
4538  0885               _pwr_hndl_new:
4540  0885 5204          	subw	sp,#4
4541       00000004      OFST:	set	4
4544                     ; 961 if(jp_mode==jp3)
4546  0887 b655          	ld	a,_jp_mode
4547  0889 a103          	cp	a,#3
4548  088b 260a          	jrne	L1132
4549                     ; 963 	pwm_u=0;
4551  088d 5f            	clrw	x
4552  088e bf08          	ldw	_pwm_u,x
4553                     ; 964 	pwm_i=0;
4555  0890 5f            	clrw	x
4556  0891 bf0a          	ldw	_pwm_i,x
4558  0893 ac470a47      	jpf	L3132
4559  0897               L1132:
4560                     ; 966 else if(jp_mode==jp2)
4562  0897 b655          	ld	a,_jp_mode
4563  0899 a102          	cp	a,#2
4564  089b 260c          	jrne	L5132
4565                     ; 968 	pwm_u=0;
4567  089d 5f            	clrw	x
4568  089e bf08          	ldw	_pwm_u,x
4569                     ; 969 	pwm_i=0x7ff;
4571  08a0 ae07ff        	ldw	x,#2047
4572  08a3 bf0a          	ldw	_pwm_i,x
4574  08a5 ac470a47      	jpf	L3132
4575  08a9               L5132:
4576                     ; 971 else if(jp_mode==jp1)
4578  08a9 b655          	ld	a,_jp_mode
4579  08ab a101          	cp	a,#1
4580  08ad 260e          	jrne	L1232
4581                     ; 973 	pwm_u=0x7ff;
4583  08af ae07ff        	ldw	x,#2047
4584  08b2 bf08          	ldw	_pwm_u,x
4585                     ; 974 	pwm_i=0x7ff;
4587  08b4 ae07ff        	ldw	x,#2047
4588  08b7 bf0a          	ldw	_pwm_i,x
4590  08b9 ac470a47      	jpf	L3132
4591  08bd               L1232:
4592                     ; 1021 else	if(link==ON)				//если есть связьvol_i_temp_avar
4594  08bd b670          	ld	a,_link
4595  08bf a155          	cp	a,#85
4596  08c1 2703          	jreq	L66
4597  08c3 cc0a47        	jp	L3132
4598  08c6               L66:
4599                     ; 1048 			temp_SL=(signed long)adc_buff_5;
4601  08c6 ce0107        	ldw	x,_adc_buff_5
4602  08c9 cd0000        	call	c_itolx
4604  08cc 96            	ldw	x,sp
4605  08cd 1c0001        	addw	x,#OFST-3
4606  08d0 cd0000        	call	c_rtol
4608                     ; 1050 			if(temp_SL<0) temp_SL=0;
4610  08d3 9c            	rvf
4611  08d4 0d01          	tnz	(OFST-3,sp)
4612  08d6 2e0a          	jrsge	L7232
4615  08d8 ae0000        	ldw	x,#0
4616  08db 1f03          	ldw	(OFST-1,sp),x
4617  08dd ae0000        	ldw	x,#0
4618  08e0 1f01          	ldw	(OFST-3,sp),x
4619  08e2               L7232:
4620                     ; 1051 			temp_SL*=(signed long)ee_K[4][1];
4622  08e2 ce002c        	ldw	x,_ee_K+18
4623  08e5 cd0000        	call	c_itolx
4625  08e8 96            	ldw	x,sp
4626  08e9 1c0001        	addw	x,#OFST-3
4627  08ec cd0000        	call	c_lgmul
4629                     ; 1052 			temp_SL/=1000L;
4631  08ef 96            	ldw	x,sp
4632  08f0 1c0001        	addw	x,#OFST-3
4633  08f3 cd0000        	call	c_ltor
4635  08f6 ae001c        	ldw	x,#L46
4636  08f9 cd0000        	call	c_ldiv
4638  08fc 96            	ldw	x,sp
4639  08fd 1c0001        	addw	x,#OFST-3
4640  0900 cd0000        	call	c_rtol
4642                     ; 1053 			Usum=(unsigned short)temp_SL;	
4644  0903 1e03          	ldw	x,(OFST-1,sp)
4645  0905 cf0010        	ldw	_Usum,x
4646                     ; 1059 			Udelt=U_out_const/*2300*/-Usum;
4648  0908 ce0012        	ldw	x,_U_out_const
4649  090b 72b00010      	subw	x,_Usum
4650  090f cf000c        	ldw	_Udelt,x
4651                     ; 1061 			if(FADE_MODE)Udelt-=Ufade;//наклон вниз выходной характеристики
4653  0912 3d13          	tnz	_FADE_MODE
4654  0914 270a          	jreq	L1332
4657  0916 ce000c        	ldw	x,_Udelt
4658  0919 72b0000a      	subw	x,_Ufade
4659  091d cf000c        	ldw	_Udelt,x
4660  0920               L1332:
4661                     ; 1064 			if(pwm_peace_cnt)pwm_peace_cnt--;
4663  0920 ce0008        	ldw	x,_pwm_peace_cnt
4664  0923 2709          	jreq	L3332
4667  0925 ce0008        	ldw	x,_pwm_peace_cnt
4668  0928 1d0001        	subw	x,#1
4669  092b cf0008        	ldw	_pwm_peace_cnt,x
4670  092e               L3332:
4671                     ; 1065 			if(pwm_peace_cnt_)pwm_peace_cnt_--;
4673  092e ce0006        	ldw	x,_pwm_peace_cnt_
4674  0931 2709          	jreq	L5332
4677  0933 ce0006        	ldw	x,_pwm_peace_cnt_
4678  0936 1d0001        	subw	x,#1
4679  0939 cf0006        	ldw	_pwm_peace_cnt_,x
4680  093c               L5332:
4681                     ; 1067 			if((Udelt<-50)&&(pwm_peace_cnt==0))
4683  093c 9c            	rvf
4684  093d ce000c        	ldw	x,_Udelt
4685  0940 a3ffce        	cpw	x,#65486
4686  0943 2e40          	jrsge	L7332
4688  0945 ce0008        	ldw	x,_pwm_peace_cnt
4689  0948 263b          	jrne	L7332
4690                     ; 1069 				pwm_delt= (short)(((long)Udelt*2000L)/650L);
4692  094a ce000c        	ldw	x,_Udelt
4693  094d 90ae07d0      	ldw	y,#2000
4694  0951 cd0000        	call	c_vmul
4696  0954 ae0018        	ldw	x,#L45
4697  0957 cd0000        	call	c_ldiv
4699  095a be02          	ldw	x,c_lreg+2
4700  095c bf56          	ldw	_pwm_delt,x
4701                     ; 1071 				if(pwm_u!=0)
4703  095e be08          	ldw	x,_pwm_u
4704  0960 271b          	jreq	L1432
4705                     ; 1073 					pwm_u+=pwm_delt;
4707  0962 be08          	ldw	x,_pwm_u
4708  0964 72bb0056      	addw	x,_pwm_delt
4709  0968 bf08          	ldw	_pwm_u,x
4710                     ; 1074 					pwm_schot_cnt++;
4712  096a ce0004        	ldw	x,_pwm_schot_cnt
4713  096d 1c0001        	addw	x,#1
4714  0970 cf0004        	ldw	_pwm_schot_cnt,x
4715                     ; 1075 					pwm_peace_cnt=30;
4717  0973 ae001e        	ldw	x,#30
4718  0976 cf0008        	ldw	_pwm_peace_cnt,x
4720  0979 ac1e0a1e      	jpf	L5432
4721  097d               L1432:
4722                     ; 1077 				else	pwm_peace_cnt=0;
4724  097d 5f            	clrw	x
4725  097e cf0008        	ldw	_pwm_peace_cnt,x
4726  0981 ac1e0a1e      	jpf	L5432
4727  0985               L7332:
4728                     ; 1080 			else if((Udelt>50)&&(pwm_peace_cnt==0))
4730  0985 9c            	rvf
4731  0986 ce000c        	ldw	x,_Udelt
4732  0989 a30033        	cpw	x,#51
4733  098c 2f3f          	jrslt	L7432
4735  098e ce0008        	ldw	x,_pwm_peace_cnt
4736  0991 263a          	jrne	L7432
4737                     ; 1082 				pwm_delt= (short)(((long)Udelt*2000L)/650L);
4739  0993 ce000c        	ldw	x,_Udelt
4740  0996 90ae07d0      	ldw	y,#2000
4741  099a cd0000        	call	c_vmul
4743  099d ae0018        	ldw	x,#L45
4744  09a0 cd0000        	call	c_ldiv
4746  09a3 be02          	ldw	x,c_lreg+2
4747  09a5 bf56          	ldw	_pwm_delt,x
4748                     ; 1084 				if(pwm_u!=2000)
4750  09a7 be08          	ldw	x,_pwm_u
4751  09a9 a307d0        	cpw	x,#2000
4752  09ac 2719          	jreq	L1532
4753                     ; 1086 					pwm_u+=pwm_delt;
4755  09ae be08          	ldw	x,_pwm_u
4756  09b0 72bb0056      	addw	x,_pwm_delt
4757  09b4 bf08          	ldw	_pwm_u,x
4758                     ; 1087 					pwm_schot_cnt++;
4760  09b6 ce0004        	ldw	x,_pwm_schot_cnt
4761  09b9 1c0001        	addw	x,#1
4762  09bc cf0004        	ldw	_pwm_schot_cnt,x
4763                     ; 1088 					pwm_peace_cnt=30;
4765  09bf ae001e        	ldw	x,#30
4766  09c2 cf0008        	ldw	_pwm_peace_cnt,x
4768  09c5 2057          	jra	L5432
4769  09c7               L1532:
4770                     ; 1090 				else	pwm_peace_cnt=0;
4772  09c7 5f            	clrw	x
4773  09c8 cf0008        	ldw	_pwm_peace_cnt,x
4774  09cb 2051          	jra	L5432
4775  09cd               L7432:
4776                     ; 1093 			else if(pwm_peace_cnt_==0)
4778  09cd ce0006        	ldw	x,_pwm_peace_cnt_
4779  09d0 264c          	jrne	L5432
4780                     ; 1095 				if(Udelt>10)pwm_u++;
4782  09d2 9c            	rvf
4783  09d3 ce000c        	ldw	x,_Udelt
4784  09d6 a3000b        	cpw	x,#11
4785  09d9 2f09          	jrslt	L1632
4788  09db be08          	ldw	x,_pwm_u
4789  09dd 1c0001        	addw	x,#1
4790  09e0 bf08          	ldw	_pwm_u,x
4792  09e2 203a          	jra	L5432
4793  09e4               L1632:
4794                     ; 1096 				else	if(Udelt>0)
4796  09e4 9c            	rvf
4797  09e5 ce000c        	ldw	x,_Udelt
4798  09e8 2d0f          	jrsle	L5632
4799                     ; 1098 					pwm_u++;
4801  09ea be08          	ldw	x,_pwm_u
4802  09ec 1c0001        	addw	x,#1
4803  09ef bf08          	ldw	_pwm_u,x
4804                     ; 1099 					pwm_peace_cnt_=3;
4806  09f1 ae0003        	ldw	x,#3
4807  09f4 cf0006        	ldw	_pwm_peace_cnt_,x
4809  09f7 2025          	jra	L5432
4810  09f9               L5632:
4811                     ; 1101 				else if(Udelt<-10)pwm_u--;
4813  09f9 9c            	rvf
4814  09fa ce000c        	ldw	x,_Udelt
4815  09fd a3fff6        	cpw	x,#65526
4816  0a00 2e09          	jrsge	L1732
4819  0a02 be08          	ldw	x,_pwm_u
4820  0a04 1d0001        	subw	x,#1
4821  0a07 bf08          	ldw	_pwm_u,x
4823  0a09 2013          	jra	L5432
4824  0a0b               L1732:
4825                     ; 1102 				else	if(Udelt<0)
4827  0a0b 9c            	rvf
4828  0a0c ce000c        	ldw	x,_Udelt
4829  0a0f 2e0d          	jrsge	L5432
4830                     ; 1104 					pwm_u--;
4832  0a11 be08          	ldw	x,_pwm_u
4833  0a13 1d0001        	subw	x,#1
4834  0a16 bf08          	ldw	_pwm_u,x
4835                     ; 1105 					pwm_peace_cnt_=3;
4837  0a18 ae0003        	ldw	x,#3
4838  0a1b cf0006        	ldw	_pwm_peace_cnt_,x
4839  0a1e               L5432:
4840                     ; 1109 			if(pwm_u<=0)
4842  0a1e 9c            	rvf
4843  0a1f be08          	ldw	x,_pwm_u
4844  0a21 2c0d          	jrsgt	L7732
4845                     ; 1111 				pwm_u=0;
4847  0a23 5f            	clrw	x
4848  0a24 bf08          	ldw	_pwm_u,x
4849                     ; 1112 				pwm_peace_cnt=0;
4851  0a26 5f            	clrw	x
4852  0a27 cf0008        	ldw	_pwm_peace_cnt,x
4853                     ; 1113 				pwm_peace_cnt_=500;
4855  0a2a ae01f4        	ldw	x,#500
4856  0a2d cf0006        	ldw	_pwm_peace_cnt_,x
4857  0a30               L7732:
4858                     ; 1115 			if(pwm_u>=2000)
4860  0a30 9c            	rvf
4861  0a31 be08          	ldw	x,_pwm_u
4862  0a33 a307d0        	cpw	x,#2000
4863  0a36 2f0f          	jrslt	L3132
4864                     ; 1117 				pwm_u=2000;
4866  0a38 ae07d0        	ldw	x,#2000
4867  0a3b bf08          	ldw	_pwm_u,x
4868                     ; 1118 				pwm_peace_cnt=0;
4870  0a3d 5f            	clrw	x
4871  0a3e cf0008        	ldw	_pwm_peace_cnt,x
4872                     ; 1119 				pwm_peace_cnt_=500;
4874  0a41 ae01f4        	ldw	x,#500
4875  0a44 cf0006        	ldw	_pwm_peace_cnt_,x
4876  0a47               L3132:
4877                     ; 1213 if(pwm_u>2000)pwm_u=2000;
4879  0a47 9c            	rvf
4880  0a48 be08          	ldw	x,_pwm_u
4881  0a4a a307d1        	cpw	x,#2001
4882  0a4d 2f05          	jrslt	L3042
4885  0a4f ae07d0        	ldw	x,#2000
4886  0a52 bf08          	ldw	_pwm_u,x
4887  0a54               L3042:
4888                     ; 1214 if(pwm_u<0)pwm_u=0;
4890  0a54 9c            	rvf
4891  0a55 be08          	ldw	x,_pwm_u
4892  0a57 2e03          	jrsge	L5042
4895  0a59 5f            	clrw	x
4896  0a5a bf08          	ldw	_pwm_u,x
4897  0a5c               L5042:
4898                     ; 1215 if(pwm_i>2000)pwm_i=2000;
4900  0a5c 9c            	rvf
4901  0a5d be0a          	ldw	x,_pwm_i
4902  0a5f a307d1        	cpw	x,#2001
4903  0a62 2f05          	jrslt	L7042
4906  0a64 ae07d0        	ldw	x,#2000
4907  0a67 bf0a          	ldw	_pwm_i,x
4908  0a69               L7042:
4909                     ; 1220 TIM1->CCR2H= (char)(pwm_u/256);	
4911  0a69 be08          	ldw	x,_pwm_u
4912  0a6b 90ae0100      	ldw	y,#256
4913  0a6f cd0000        	call	c_idiv
4915  0a72 9f            	ld	a,xl
4916  0a73 c75267        	ld	21095,a
4917                     ; 1221 TIM1->CCR2L= (char)pwm_u;
4919  0a76 5500095268    	mov	21096,_pwm_u+1
4920                     ; 1223 TIM1->CCR1H= (char)(pwm_i/256);	
4922  0a7b be0a          	ldw	x,_pwm_i
4923  0a7d 90ae0100      	ldw	y,#256
4924  0a81 cd0000        	call	c_idiv
4926  0a84 9f            	ld	a,xl
4927  0a85 c75265        	ld	21093,a
4928                     ; 1224 TIM1->CCR1L= (char)pwm_i;
4930  0a88 55000b5266    	mov	21094,_pwm_i+1
4931                     ; 1226 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4933  0a8d be0e          	ldw	x,_vent_pwm_integr
4934  0a8f 90ae0080      	ldw	y,#128
4935  0a93 cd0000        	call	c_idiv
4937  0a96 9f            	ld	a,xl
4938  0a97 c75269        	ld	21097,a
4939                     ; 1227 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4941  0a9a b60f          	ld	a,_vent_pwm_integr+1
4942  0a9c 48            	sll	a
4943  0a9d c7526a        	ld	21098,a
4944                     ; 1229 }
4947  0aa0 5b04          	addw	sp,#4
4948  0aa2 81            	ret
5002                     	switch	.const
5003  0020               L27:
5004  0020 00000258      	dc.l	600
5005  0024               L47:
5006  0024 00000708      	dc.l	1800
5007                     ; 1233 void matemat(void)
5007                     ; 1234 {
5008                     	switch	.text
5009  0aa3               _matemat:
5011  0aa3 5208          	subw	sp,#8
5012       00000008      OFST:	set	8
5015                     ; 1258 I=adc_buff_[4];
5017  0aa5 ce0111        	ldw	x,_adc_buff_+8
5018  0aa8 cf001a        	ldw	_I,x
5019                     ; 1259 temp_SL=adc_buff_[4];
5021  0aab ce0111        	ldw	x,_adc_buff_+8
5022  0aae cd0000        	call	c_itolx
5024  0ab1 96            	ldw	x,sp
5025  0ab2 1c0005        	addw	x,#OFST-3
5026  0ab5 cd0000        	call	c_rtol
5028                     ; 1260 temp_SL-=ee_K[0][0];
5030  0ab8 ce001a        	ldw	x,_ee_K
5031  0abb cd0000        	call	c_itolx
5033  0abe 96            	ldw	x,sp
5034  0abf 1c0005        	addw	x,#OFST-3
5035  0ac2 cd0000        	call	c_lgsub
5037                     ; 1261 if(temp_SL<0) temp_SL=0;
5039  0ac5 9c            	rvf
5040  0ac6 0d05          	tnz	(OFST-3,sp)
5041  0ac8 2e0a          	jrsge	L7242
5044  0aca ae0000        	ldw	x,#0
5045  0acd 1f07          	ldw	(OFST-1,sp),x
5046  0acf ae0000        	ldw	x,#0
5047  0ad2 1f05          	ldw	(OFST-3,sp),x
5048  0ad4               L7242:
5049                     ; 1262 temp_SL*=ee_K[0][1];
5051  0ad4 ce001c        	ldw	x,_ee_K+2
5052  0ad7 cd0000        	call	c_itolx
5054  0ada 96            	ldw	x,sp
5055  0adb 1c0005        	addw	x,#OFST-3
5056  0ade cd0000        	call	c_lgmul
5058                     ; 1263 temp_SL/=600;
5060  0ae1 96            	ldw	x,sp
5061  0ae2 1c0005        	addw	x,#OFST-3
5062  0ae5 cd0000        	call	c_ltor
5064  0ae8 ae0020        	ldw	x,#L27
5065  0aeb cd0000        	call	c_ldiv
5067  0aee 96            	ldw	x,sp
5068  0aef 1c0005        	addw	x,#OFST-3
5069  0af2 cd0000        	call	c_rtol
5071                     ; 1264 I=(signed short)temp_SL;
5073  0af5 1e07          	ldw	x,(OFST-1,sp)
5074  0af7 cf001a        	ldw	_I,x
5075                     ; 1267 temp_SL=(signed long)adc_buff_[1];//1;
5077  0afa ce010b        	ldw	x,_adc_buff_+2
5078  0afd cd0000        	call	c_itolx
5080  0b00 96            	ldw	x,sp
5081  0b01 1c0005        	addw	x,#OFST-3
5082  0b04 cd0000        	call	c_rtol
5084                     ; 1270 if(temp_SL<0) temp_SL=0;
5086  0b07 9c            	rvf
5087  0b08 0d05          	tnz	(OFST-3,sp)
5088  0b0a 2e0a          	jrsge	L1342
5091  0b0c ae0000        	ldw	x,#0
5092  0b0f 1f07          	ldw	(OFST-1,sp),x
5093  0b11 ae0000        	ldw	x,#0
5094  0b14 1f05          	ldw	(OFST-3,sp),x
5095  0b16               L1342:
5096                     ; 1271 temp_SL*=(signed long)ee_K[2][1];
5098  0b16 ce0024        	ldw	x,_ee_K+10
5099  0b19 cd0000        	call	c_itolx
5101  0b1c 96            	ldw	x,sp
5102  0b1d 1c0005        	addw	x,#OFST-3
5103  0b20 cd0000        	call	c_lgmul
5105                     ; 1272 temp_SL/=1000L;
5107  0b23 96            	ldw	x,sp
5108  0b24 1c0005        	addw	x,#OFST-3
5109  0b27 cd0000        	call	c_ltor
5111  0b2a ae001c        	ldw	x,#L46
5112  0b2d cd0000        	call	c_ldiv
5114  0b30 96            	ldw	x,sp
5115  0b31 1c0005        	addw	x,#OFST-3
5116  0b34 cd0000        	call	c_rtol
5118                     ; 1273 Ui=(unsigned short)temp_SL;
5120  0b37 1e07          	ldw	x,(OFST-1,sp)
5121  0b39 cf0016        	ldw	_Ui,x
5122                     ; 1275 temp_SL=(signed long)adc_buff_5;
5124  0b3c ce0107        	ldw	x,_adc_buff_5
5125  0b3f cd0000        	call	c_itolx
5127  0b42 96            	ldw	x,sp
5128  0b43 1c0005        	addw	x,#OFST-3
5129  0b46 cd0000        	call	c_rtol
5131                     ; 1277 if(temp_SL<0) temp_SL=0;
5133  0b49 9c            	rvf
5134  0b4a 0d05          	tnz	(OFST-3,sp)
5135  0b4c 2e0a          	jrsge	L3342
5138  0b4e ae0000        	ldw	x,#0
5139  0b51 1f07          	ldw	(OFST-1,sp),x
5140  0b53 ae0000        	ldw	x,#0
5141  0b56 1f05          	ldw	(OFST-3,sp),x
5142  0b58               L3342:
5143                     ; 1278 temp_SL*=(signed long)ee_K[4][1];
5145  0b58 ce002c        	ldw	x,_ee_K+18
5146  0b5b cd0000        	call	c_itolx
5148  0b5e 96            	ldw	x,sp
5149  0b5f 1c0005        	addw	x,#OFST-3
5150  0b62 cd0000        	call	c_lgmul
5152                     ; 1279 temp_SL/=1000L;
5154  0b65 96            	ldw	x,sp
5155  0b66 1c0005        	addw	x,#OFST-3
5156  0b69 cd0000        	call	c_ltor
5158  0b6c ae001c        	ldw	x,#L46
5159  0b6f cd0000        	call	c_ldiv
5161  0b72 96            	ldw	x,sp
5162  0b73 1c0005        	addw	x,#OFST-3
5163  0b76 cd0000        	call	c_rtol
5165                     ; 1280 Usum=(unsigned short)temp_SL;
5167  0b79 1e07          	ldw	x,(OFST-1,sp)
5168  0b7b cf0010        	ldw	_Usum,x
5169                     ; 1284 temp_SL=adc_buff_[3];
5171  0b7e ce010f        	ldw	x,_adc_buff_+6
5172  0b81 cd0000        	call	c_itolx
5174  0b84 96            	ldw	x,sp
5175  0b85 1c0005        	addw	x,#OFST-3
5176  0b88 cd0000        	call	c_rtol
5178                     ; 1286 if(temp_SL<0) temp_SL=0;
5180  0b8b 9c            	rvf
5181  0b8c 0d05          	tnz	(OFST-3,sp)
5182  0b8e 2e0a          	jrsge	L5342
5185  0b90 ae0000        	ldw	x,#0
5186  0b93 1f07          	ldw	(OFST-1,sp),x
5187  0b95 ae0000        	ldw	x,#0
5188  0b98 1f05          	ldw	(OFST-3,sp),x
5189  0b9a               L5342:
5190                     ; 1287 temp_SL*=ee_K[1][1];
5192  0b9a ce0020        	ldw	x,_ee_K+6
5193  0b9d cd0000        	call	c_itolx
5195  0ba0 96            	ldw	x,sp
5196  0ba1 1c0005        	addw	x,#OFST-3
5197  0ba4 cd0000        	call	c_lgmul
5199                     ; 1288 temp_SL/=1800;
5201  0ba7 96            	ldw	x,sp
5202  0ba8 1c0005        	addw	x,#OFST-3
5203  0bab cd0000        	call	c_ltor
5205  0bae ae0024        	ldw	x,#L47
5206  0bb1 cd0000        	call	c_ldiv
5208  0bb4 96            	ldw	x,sp
5209  0bb5 1c0005        	addw	x,#OFST-3
5210  0bb8 cd0000        	call	c_rtol
5212                     ; 1289 Un=(unsigned short)temp_SL;
5214  0bbb 1e07          	ldw	x,(OFST-1,sp)
5215  0bbd cf0018        	ldw	_Un,x
5216                     ; 1294 temp_SL=adc_buff_[2];
5218  0bc0 ce010d        	ldw	x,_adc_buff_+4
5219  0bc3 cd0000        	call	c_itolx
5221  0bc6 96            	ldw	x,sp
5222  0bc7 1c0005        	addw	x,#OFST-3
5223  0bca cd0000        	call	c_rtol
5225                     ; 1295 temp_SL*=ee_K[3][1];
5227  0bcd ce0028        	ldw	x,_ee_K+14
5228  0bd0 cd0000        	call	c_itolx
5230  0bd3 96            	ldw	x,sp
5231  0bd4 1c0005        	addw	x,#OFST-3
5232  0bd7 cd0000        	call	c_lgmul
5234                     ; 1296 temp_SL/=1000;
5236  0bda 96            	ldw	x,sp
5237  0bdb 1c0005        	addw	x,#OFST-3
5238  0bde cd0000        	call	c_ltor
5240  0be1 ae001c        	ldw	x,#L46
5241  0be4 cd0000        	call	c_ldiv
5243  0be7 96            	ldw	x,sp
5244  0be8 1c0005        	addw	x,#OFST-3
5245  0beb cd0000        	call	c_rtol
5247                     ; 1297 T=(signed short)(temp_SL-273L);
5249  0bee 7b08          	ld	a,(OFST+0,sp)
5250  0bf0 5f            	clrw	x
5251  0bf1 4d            	tnz	a
5252  0bf2 2a01          	jrpl	L67
5253  0bf4 53            	cplw	x
5254  0bf5               L67:
5255  0bf5 97            	ld	xl,a
5256  0bf6 1d0111        	subw	x,#273
5257  0bf9 01            	rrwa	x,a
5258  0bfa b775          	ld	_T,a
5259  0bfc 02            	rlwa	x,a
5260                     ; 1298 if(T<-30)T=-30;
5262  0bfd 9c            	rvf
5263  0bfe b675          	ld	a,_T
5264  0c00 a1e2          	cp	a,#226
5265  0c02 2e04          	jrsge	L7342
5268  0c04 35e20075      	mov	_T,#226
5269  0c08               L7342:
5270                     ; 1299 if(T>120)T=120;
5272  0c08 9c            	rvf
5273  0c09 b675          	ld	a,_T
5274  0c0b a179          	cp	a,#121
5275  0c0d 2f04          	jrslt	L1442
5278  0c0f 35780075      	mov	_T,#120
5279  0c13               L1442:
5280                     ; 1303 Uin=Usum-Ui;
5282  0c13 ce0010        	ldw	x,_Usum
5283  0c16 72b00016      	subw	x,_Ui
5284  0c1a cf000e        	ldw	_Uin,x
5285                     ; 1304 if(link==ON)
5287  0c1d b670          	ld	a,_link
5288  0c1f a155          	cp	a,#85
5289  0c21 260c          	jrne	L3442
5290                     ; 1306 	Unecc=U_out_const-Uin;
5292  0c23 ce0012        	ldw	x,_U_out_const
5293  0c26 72b0000e      	subw	x,_Uin
5294  0c2a cf0014        	ldw	_Unecc,x
5296  0c2d 200a          	jra	L5442
5297  0c2f               L3442:
5298                     ; 1315 else Unecc=ee_UAVT-Uin;
5300  0c2f ce000c        	ldw	x,_ee_UAVT
5301  0c32 72b0000e      	subw	x,_Uin
5302  0c36 cf0014        	ldw	_Unecc,x
5303  0c39               L5442:
5304                     ; 1323 if(Unecc<0)Unecc=0;
5306  0c39 9c            	rvf
5307  0c3a ce0014        	ldw	x,_Unecc
5308  0c3d 2e04          	jrsge	L7442
5311  0c3f 5f            	clrw	x
5312  0c40 cf0014        	ldw	_Unecc,x
5313  0c43               L7442:
5314                     ; 1324 temp_SL=(signed long)(T-ee_tsign);
5316  0c43 5f            	clrw	x
5317  0c44 b675          	ld	a,_T
5318  0c46 2a01          	jrpl	L001
5319  0c48 53            	cplw	x
5320  0c49               L001:
5321  0c49 97            	ld	xl,a
5322  0c4a 72b0000e      	subw	x,_ee_tsign
5323  0c4e cd0000        	call	c_itolx
5325  0c51 96            	ldw	x,sp
5326  0c52 1c0005        	addw	x,#OFST-3
5327  0c55 cd0000        	call	c_rtol
5329                     ; 1325 temp_SL*=1000L;
5331  0c58 ae03e8        	ldw	x,#1000
5332  0c5b bf02          	ldw	c_lreg+2,x
5333  0c5d ae0000        	ldw	x,#0
5334  0c60 bf00          	ldw	c_lreg,x
5335  0c62 96            	ldw	x,sp
5336  0c63 1c0005        	addw	x,#OFST-3
5337  0c66 cd0000        	call	c_lgmul
5339                     ; 1326 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5341  0c69 ce0010        	ldw	x,_ee_tmax
5342  0c6c 72b0000e      	subw	x,_ee_tsign
5343  0c70 cd0000        	call	c_itolx
5345  0c73 96            	ldw	x,sp
5346  0c74 1c0001        	addw	x,#OFST-7
5347  0c77 cd0000        	call	c_rtol
5349  0c7a 96            	ldw	x,sp
5350  0c7b 1c0005        	addw	x,#OFST-3
5351  0c7e cd0000        	call	c_ltor
5353  0c81 96            	ldw	x,sp
5354  0c82 1c0001        	addw	x,#OFST-7
5355  0c85 cd0000        	call	c_ldiv
5357  0c88 96            	ldw	x,sp
5358  0c89 1c0005        	addw	x,#OFST-3
5359  0c8c cd0000        	call	c_rtol
5361                     ; 1328 vol_i_temp_avar=(unsigned short)temp_SL; 
5363  0c8f 1e07          	ldw	x,(OFST-1,sp)
5364  0c91 bf06          	ldw	_vol_i_temp_avar,x
5365                     ; 1330 debug_info_to_uku[0]=pwm_u;
5367  0c93 be08          	ldw	x,_pwm_u
5368  0c95 bf01          	ldw	_debug_info_to_uku,x
5369                     ; 1331 debug_info_to_uku[1]=vol_i_temp;
5371  0c97 be63          	ldw	x,_vol_i_temp
5372  0c99 bf03          	ldw	_debug_info_to_uku+2,x
5373                     ; 1333 Ufade=I/50;
5375  0c9b ce001a        	ldw	x,_I
5376  0c9e a632          	ld	a,#50
5377  0ca0 cd0000        	call	c_sdivx
5379  0ca3 cf000a        	ldw	_Ufade,x
5380                     ; 1334 if(Ufade<0)Ufade=0;
5382  0ca6 9c            	rvf
5383  0ca7 ce000a        	ldw	x,_Ufade
5384  0caa 2e04          	jrsge	L1542
5387  0cac 5f            	clrw	x
5388  0cad cf000a        	ldw	_Ufade,x
5389  0cb0               L1542:
5390                     ; 1335 if(Ufade>15)Ufade=15;
5392  0cb0 9c            	rvf
5393  0cb1 ce000a        	ldw	x,_Ufade
5394  0cb4 a30010        	cpw	x,#16
5395  0cb7 2f06          	jrslt	L3542
5398  0cb9 ae000f        	ldw	x,#15
5399  0cbc cf000a        	ldw	_Ufade,x
5400  0cbf               L3542:
5401                     ; 1336 }
5404  0cbf 5b08          	addw	sp,#8
5405  0cc1 81            	ret
5436                     ; 1339 void temper_drv(void)		//1 Hz
5436                     ; 1340 {
5437                     	switch	.text
5438  0cc2               _temper_drv:
5442                     ; 1342 if(T>ee_tsign) tsign_cnt++;
5444  0cc2 9c            	rvf
5445  0cc3 5f            	clrw	x
5446  0cc4 b675          	ld	a,_T
5447  0cc6 2a01          	jrpl	L401
5448  0cc8 53            	cplw	x
5449  0cc9               L401:
5450  0cc9 97            	ld	xl,a
5451  0cca c3000e        	cpw	x,_ee_tsign
5452  0ccd 2d09          	jrsle	L5642
5455  0ccf be5c          	ldw	x,_tsign_cnt
5456  0cd1 1c0001        	addw	x,#1
5457  0cd4 bf5c          	ldw	_tsign_cnt,x
5459  0cd6 201d          	jra	L7642
5460  0cd8               L5642:
5461                     ; 1343 else if (T<(ee_tsign-1)) tsign_cnt--;
5463  0cd8 9c            	rvf
5464  0cd9 ce000e        	ldw	x,_ee_tsign
5465  0cdc 5a            	decw	x
5466  0cdd 905f          	clrw	y
5467  0cdf b675          	ld	a,_T
5468  0ce1 2a02          	jrpl	L601
5469  0ce3 9053          	cplw	y
5470  0ce5               L601:
5471  0ce5 9097          	ld	yl,a
5472  0ce7 90bf00        	ldw	c_y,y
5473  0cea b300          	cpw	x,c_y
5474  0cec 2d07          	jrsle	L7642
5477  0cee be5c          	ldw	x,_tsign_cnt
5478  0cf0 1d0001        	subw	x,#1
5479  0cf3 bf5c          	ldw	_tsign_cnt,x
5480  0cf5               L7642:
5481                     ; 1345 gran(&tsign_cnt,0,60);
5483  0cf5 ae003c        	ldw	x,#60
5484  0cf8 89            	pushw	x
5485  0cf9 5f            	clrw	x
5486  0cfa 89            	pushw	x
5487  0cfb ae005c        	ldw	x,#_tsign_cnt
5488  0cfe cd00d5        	call	_gran
5490  0d01 5b04          	addw	sp,#4
5491                     ; 1347 if(tsign_cnt>=55)
5493  0d03 9c            	rvf
5494  0d04 be5c          	ldw	x,_tsign_cnt
5495  0d06 a30037        	cpw	x,#55
5496  0d09 2f16          	jrslt	L3742
5497                     ; 1349 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5499  0d0b 3d55          	tnz	_jp_mode
5500  0d0d 2606          	jrne	L1052
5502  0d0f b605          	ld	a,_flags
5503  0d11 a540          	bcp	a,#64
5504  0d13 2706          	jreq	L7742
5505  0d15               L1052:
5507  0d15 b655          	ld	a,_jp_mode
5508  0d17 a103          	cp	a,#3
5509  0d19 2612          	jrne	L3052
5510  0d1b               L7742:
5513  0d1b 72140005      	bset	_flags,#2
5514  0d1f 200c          	jra	L3052
5515  0d21               L3742:
5516                     ; 1351 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5518  0d21 9c            	rvf
5519  0d22 be5c          	ldw	x,_tsign_cnt
5520  0d24 a30006        	cpw	x,#6
5521  0d27 2e04          	jrsge	L3052
5524  0d29 72150005      	bres	_flags,#2
5525  0d2d               L3052:
5526                     ; 1356 if(T>ee_tmax) tmax_cnt++;
5528  0d2d 9c            	rvf
5529  0d2e 5f            	clrw	x
5530  0d2f b675          	ld	a,_T
5531  0d31 2a01          	jrpl	L011
5532  0d33 53            	cplw	x
5533  0d34               L011:
5534  0d34 97            	ld	xl,a
5535  0d35 c30010        	cpw	x,_ee_tmax
5536  0d38 2d09          	jrsle	L7052
5539  0d3a be5a          	ldw	x,_tmax_cnt
5540  0d3c 1c0001        	addw	x,#1
5541  0d3f bf5a          	ldw	_tmax_cnt,x
5543  0d41 201d          	jra	L1152
5544  0d43               L7052:
5545                     ; 1357 else if (T<(ee_tmax-1)) tmax_cnt--;
5547  0d43 9c            	rvf
5548  0d44 ce0010        	ldw	x,_ee_tmax
5549  0d47 5a            	decw	x
5550  0d48 905f          	clrw	y
5551  0d4a b675          	ld	a,_T
5552  0d4c 2a02          	jrpl	L211
5553  0d4e 9053          	cplw	y
5554  0d50               L211:
5555  0d50 9097          	ld	yl,a
5556  0d52 90bf00        	ldw	c_y,y
5557  0d55 b300          	cpw	x,c_y
5558  0d57 2d07          	jrsle	L1152
5561  0d59 be5a          	ldw	x,_tmax_cnt
5562  0d5b 1d0001        	subw	x,#1
5563  0d5e bf5a          	ldw	_tmax_cnt,x
5564  0d60               L1152:
5565                     ; 1359 gran(&tmax_cnt,0,60);
5567  0d60 ae003c        	ldw	x,#60
5568  0d63 89            	pushw	x
5569  0d64 5f            	clrw	x
5570  0d65 89            	pushw	x
5571  0d66 ae005a        	ldw	x,#_tmax_cnt
5572  0d69 cd00d5        	call	_gran
5574  0d6c 5b04          	addw	sp,#4
5575                     ; 1361 if(tmax_cnt>=55)
5577  0d6e 9c            	rvf
5578  0d6f be5a          	ldw	x,_tmax_cnt
5579  0d71 a30037        	cpw	x,#55
5580  0d74 2f16          	jrslt	L5152
5581                     ; 1363 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5583  0d76 3d55          	tnz	_jp_mode
5584  0d78 2606          	jrne	L3252
5586  0d7a b605          	ld	a,_flags
5587  0d7c a540          	bcp	a,#64
5588  0d7e 2706          	jreq	L1252
5589  0d80               L3252:
5591  0d80 b655          	ld	a,_jp_mode
5592  0d82 a103          	cp	a,#3
5593  0d84 2612          	jrne	L5252
5594  0d86               L1252:
5597  0d86 72120005      	bset	_flags,#1
5598  0d8a 200c          	jra	L5252
5599  0d8c               L5152:
5600                     ; 1365 else if (tmax_cnt<=5) flags&=0b11111101;
5602  0d8c 9c            	rvf
5603  0d8d be5a          	ldw	x,_tmax_cnt
5604  0d8f a30006        	cpw	x,#6
5605  0d92 2e04          	jrsge	L5252
5608  0d94 72130005      	bres	_flags,#1
5609  0d98               L5252:
5610                     ; 1368 } 
5613  0d98 81            	ret
5645                     ; 1371 void u_drv(void)		//1Hz
5645                     ; 1372 { 
5646                     	switch	.text
5647  0d99               _u_drv:
5651                     ; 1373 if(jp_mode!=jp3)
5653  0d99 b655          	ld	a,_jp_mode
5654  0d9b a103          	cp	a,#3
5655  0d9d 2774          	jreq	L1452
5656                     ; 1375 	if(Ui>ee_Umax)umax_cnt++;
5658  0d9f 9c            	rvf
5659  0da0 ce0016        	ldw	x,_Ui
5660  0da3 c30014        	cpw	x,_ee_Umax
5661  0da6 2d09          	jrsle	L3452
5664  0da8 be73          	ldw	x,_umax_cnt
5665  0daa 1c0001        	addw	x,#1
5666  0dad bf73          	ldw	_umax_cnt,x
5668  0daf 2003          	jra	L5452
5669  0db1               L3452:
5670                     ; 1376 	else umax_cnt=0;
5672  0db1 5f            	clrw	x
5673  0db2 bf73          	ldw	_umax_cnt,x
5674  0db4               L5452:
5675                     ; 1377 	gran(&umax_cnt,0,10);
5677  0db4 ae000a        	ldw	x,#10
5678  0db7 89            	pushw	x
5679  0db8 5f            	clrw	x
5680  0db9 89            	pushw	x
5681  0dba ae0073        	ldw	x,#_umax_cnt
5682  0dbd cd00d5        	call	_gran
5684  0dc0 5b04          	addw	sp,#4
5685                     ; 1378 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5687  0dc2 9c            	rvf
5688  0dc3 be73          	ldw	x,_umax_cnt
5689  0dc5 a3000a        	cpw	x,#10
5690  0dc8 2f04          	jrslt	L7452
5693  0dca 72160005      	bset	_flags,#3
5694  0dce               L7452:
5695                     ; 1381 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5697  0dce 9c            	rvf
5698  0dcf ce0016        	ldw	x,_Ui
5699  0dd2 c30018        	cpw	x,_Un
5700  0dd5 2e1d          	jrsge	L1552
5702  0dd7 9c            	rvf
5703  0dd8 ce0018        	ldw	x,_Un
5704  0ddb 72b00016      	subw	x,_Ui
5705  0ddf c30012        	cpw	x,_ee_dU
5706  0de2 2d10          	jrsle	L1552
5708  0de4 c65005        	ld	a,20485
5709  0de7 a504          	bcp	a,#4
5710  0de9 2609          	jrne	L1552
5713  0deb be71          	ldw	x,_umin_cnt
5714  0ded 1c0001        	addw	x,#1
5715  0df0 bf71          	ldw	_umin_cnt,x
5717  0df2 2003          	jra	L3552
5718  0df4               L1552:
5719                     ; 1382 	else umin_cnt=0;
5721  0df4 5f            	clrw	x
5722  0df5 bf71          	ldw	_umin_cnt,x
5723  0df7               L3552:
5724                     ; 1383 	gran(&umin_cnt,0,10);	
5726  0df7 ae000a        	ldw	x,#10
5727  0dfa 89            	pushw	x
5728  0dfb 5f            	clrw	x
5729  0dfc 89            	pushw	x
5730  0dfd ae0071        	ldw	x,#_umin_cnt
5731  0e00 cd00d5        	call	_gran
5733  0e03 5b04          	addw	sp,#4
5734                     ; 1384 	if(umin_cnt>=10)flags|=0b00010000;	  
5736  0e05 9c            	rvf
5737  0e06 be71          	ldw	x,_umin_cnt
5738  0e08 a3000a        	cpw	x,#10
5739  0e0b 2f71          	jrslt	L7552
5742  0e0d 72180005      	bset	_flags,#4
5743  0e11 206b          	jra	L7552
5744  0e13               L1452:
5745                     ; 1386 else if(jp_mode==jp3)
5747  0e13 b655          	ld	a,_jp_mode
5748  0e15 a103          	cp	a,#3
5749  0e17 2665          	jrne	L7552
5750                     ; 1388 	if(Ui>700)umax_cnt++;
5752  0e19 9c            	rvf
5753  0e1a ce0016        	ldw	x,_Ui
5754  0e1d a302bd        	cpw	x,#701
5755  0e20 2f09          	jrslt	L3652
5758  0e22 be73          	ldw	x,_umax_cnt
5759  0e24 1c0001        	addw	x,#1
5760  0e27 bf73          	ldw	_umax_cnt,x
5762  0e29 2003          	jra	L5652
5763  0e2b               L3652:
5764                     ; 1389 	else umax_cnt=0;
5766  0e2b 5f            	clrw	x
5767  0e2c bf73          	ldw	_umax_cnt,x
5768  0e2e               L5652:
5769                     ; 1390 	gran(&umax_cnt,0,10);
5771  0e2e ae000a        	ldw	x,#10
5772  0e31 89            	pushw	x
5773  0e32 5f            	clrw	x
5774  0e33 89            	pushw	x
5775  0e34 ae0073        	ldw	x,#_umax_cnt
5776  0e37 cd00d5        	call	_gran
5778  0e3a 5b04          	addw	sp,#4
5779                     ; 1391 	if(umax_cnt>=10)flags|=0b00001000;
5781  0e3c 9c            	rvf
5782  0e3d be73          	ldw	x,_umax_cnt
5783  0e3f a3000a        	cpw	x,#10
5784  0e42 2f04          	jrslt	L7652
5787  0e44 72160005      	bset	_flags,#3
5788  0e48               L7652:
5789                     ; 1394 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5791  0e48 9c            	rvf
5792  0e49 ce0016        	ldw	x,_Ui
5793  0e4c a300c8        	cpw	x,#200
5794  0e4f 2e10          	jrsge	L1752
5796  0e51 c65005        	ld	a,20485
5797  0e54 a504          	bcp	a,#4
5798  0e56 2609          	jrne	L1752
5801  0e58 be71          	ldw	x,_umin_cnt
5802  0e5a 1c0001        	addw	x,#1
5803  0e5d bf71          	ldw	_umin_cnt,x
5805  0e5f 2003          	jra	L3752
5806  0e61               L1752:
5807                     ; 1395 	else umin_cnt=0;
5809  0e61 5f            	clrw	x
5810  0e62 bf71          	ldw	_umin_cnt,x
5811  0e64               L3752:
5812                     ; 1396 	gran(&umin_cnt,0,10);	
5814  0e64 ae000a        	ldw	x,#10
5815  0e67 89            	pushw	x
5816  0e68 5f            	clrw	x
5817  0e69 89            	pushw	x
5818  0e6a ae0071        	ldw	x,#_umin_cnt
5819  0e6d cd00d5        	call	_gran
5821  0e70 5b04          	addw	sp,#4
5822                     ; 1397 	if(umin_cnt>=10)flags|=0b00010000;	  
5824  0e72 9c            	rvf
5825  0e73 be71          	ldw	x,_umin_cnt
5826  0e75 a3000a        	cpw	x,#10
5827  0e78 2f04          	jrslt	L7552
5830  0e7a 72180005      	bset	_flags,#4
5831  0e7e               L7552:
5832                     ; 1399 }
5835  0e7e 81            	ret
5861                     ; 1424 void apv_start(void)
5861                     ; 1425 {
5862                     	switch	.text
5863  0e7f               _apv_start:
5867                     ; 1426 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5869  0e7f 3d50          	tnz	_apv_cnt
5870  0e81 2624          	jrne	L7062
5872  0e83 3d51          	tnz	_apv_cnt+1
5873  0e85 2620          	jrne	L7062
5875  0e87 3d52          	tnz	_apv_cnt+2
5876  0e89 261c          	jrne	L7062
5878                     	btst	_bAPV
5879  0e90 2515          	jrult	L7062
5880                     ; 1428 	apv_cnt[0]=60;
5882  0e92 353c0050      	mov	_apv_cnt,#60
5883                     ; 1429 	apv_cnt[1]=60;
5885  0e96 353c0051      	mov	_apv_cnt+1,#60
5886                     ; 1430 	apv_cnt[2]=60;
5888  0e9a 353c0052      	mov	_apv_cnt+2,#60
5889                     ; 1431 	apv_cnt_=3600;
5891  0e9e ae0e10        	ldw	x,#3600
5892  0ea1 bf4e          	ldw	_apv_cnt_,x
5893                     ; 1432 	bAPV=1;	
5895  0ea3 72100002      	bset	_bAPV
5896  0ea7               L7062:
5897                     ; 1434 }
5900  0ea7 81            	ret
5926                     ; 1437 void apv_stop(void)
5926                     ; 1438 {
5927                     	switch	.text
5928  0ea8               _apv_stop:
5932                     ; 1439 apv_cnt[0]=0;
5934  0ea8 3f50          	clr	_apv_cnt
5935                     ; 1440 apv_cnt[1]=0;
5937  0eaa 3f51          	clr	_apv_cnt+1
5938                     ; 1441 apv_cnt[2]=0;
5940  0eac 3f52          	clr	_apv_cnt+2
5941                     ; 1442 apv_cnt_=0;	
5943  0eae 5f            	clrw	x
5944  0eaf bf4e          	ldw	_apv_cnt_,x
5945                     ; 1443 bAPV=0;
5947  0eb1 72110002      	bres	_bAPV
5948                     ; 1444 }
5951  0eb5 81            	ret
5986                     ; 1448 void apv_hndl(void)
5986                     ; 1449 {
5987                     	switch	.text
5988  0eb6               _apv_hndl:
5992                     ; 1450 if(apv_cnt[0])
5994  0eb6 3d50          	tnz	_apv_cnt
5995  0eb8 271e          	jreq	L1362
5996                     ; 1452 	apv_cnt[0]--;
5998  0eba 3a50          	dec	_apv_cnt
5999                     ; 1453 	if(apv_cnt[0]==0)
6001  0ebc 3d50          	tnz	_apv_cnt
6002  0ebe 265a          	jrne	L5362
6003                     ; 1455 		flags&=0b11100001;
6005  0ec0 b605          	ld	a,_flags
6006  0ec2 a4e1          	and	a,#225
6007  0ec4 b705          	ld	_flags,a
6008                     ; 1456 		tsign_cnt=0;
6010  0ec6 5f            	clrw	x
6011  0ec7 bf5c          	ldw	_tsign_cnt,x
6012                     ; 1457 		tmax_cnt=0;
6014  0ec9 5f            	clrw	x
6015  0eca bf5a          	ldw	_tmax_cnt,x
6016                     ; 1458 		umax_cnt=0;
6018  0ecc 5f            	clrw	x
6019  0ecd bf73          	ldw	_umax_cnt,x
6020                     ; 1459 		umin_cnt=0;
6022  0ecf 5f            	clrw	x
6023  0ed0 bf71          	ldw	_umin_cnt,x
6024                     ; 1461 		led_drv_cnt=30;
6026  0ed2 351e0016      	mov	_led_drv_cnt,#30
6027  0ed6 2042          	jra	L5362
6028  0ed8               L1362:
6029                     ; 1464 else if(apv_cnt[1])
6031  0ed8 3d51          	tnz	_apv_cnt+1
6032  0eda 271e          	jreq	L7362
6033                     ; 1466 	apv_cnt[1]--;
6035  0edc 3a51          	dec	_apv_cnt+1
6036                     ; 1467 	if(apv_cnt[1]==0)
6038  0ede 3d51          	tnz	_apv_cnt+1
6039  0ee0 2638          	jrne	L5362
6040                     ; 1469 		flags&=0b11100001;
6042  0ee2 b605          	ld	a,_flags
6043  0ee4 a4e1          	and	a,#225
6044  0ee6 b705          	ld	_flags,a
6045                     ; 1470 		tsign_cnt=0;
6047  0ee8 5f            	clrw	x
6048  0ee9 bf5c          	ldw	_tsign_cnt,x
6049                     ; 1471 		tmax_cnt=0;
6051  0eeb 5f            	clrw	x
6052  0eec bf5a          	ldw	_tmax_cnt,x
6053                     ; 1472 		umax_cnt=0;
6055  0eee 5f            	clrw	x
6056  0eef bf73          	ldw	_umax_cnt,x
6057                     ; 1473 		umin_cnt=0;
6059  0ef1 5f            	clrw	x
6060  0ef2 bf71          	ldw	_umin_cnt,x
6061                     ; 1475 		led_drv_cnt=30;
6063  0ef4 351e0016      	mov	_led_drv_cnt,#30
6064  0ef8 2020          	jra	L5362
6065  0efa               L7362:
6066                     ; 1478 else if(apv_cnt[2])
6068  0efa 3d52          	tnz	_apv_cnt+2
6069  0efc 271c          	jreq	L5362
6070                     ; 1480 	apv_cnt[2]--;
6072  0efe 3a52          	dec	_apv_cnt+2
6073                     ; 1481 	if(apv_cnt[2]==0)
6075  0f00 3d52          	tnz	_apv_cnt+2
6076  0f02 2616          	jrne	L5362
6077                     ; 1483 		flags&=0b11100001;
6079  0f04 b605          	ld	a,_flags
6080  0f06 a4e1          	and	a,#225
6081  0f08 b705          	ld	_flags,a
6082                     ; 1484 		tsign_cnt=0;
6084  0f0a 5f            	clrw	x
6085  0f0b bf5c          	ldw	_tsign_cnt,x
6086                     ; 1485 		tmax_cnt=0;
6088  0f0d 5f            	clrw	x
6089  0f0e bf5a          	ldw	_tmax_cnt,x
6090                     ; 1486 		umax_cnt=0;
6092  0f10 5f            	clrw	x
6093  0f11 bf73          	ldw	_umax_cnt,x
6094                     ; 1487 		umin_cnt=0;          
6096  0f13 5f            	clrw	x
6097  0f14 bf71          	ldw	_umin_cnt,x
6098                     ; 1489 		led_drv_cnt=30;
6100  0f16 351e0016      	mov	_led_drv_cnt,#30
6101  0f1a               L5362:
6102                     ; 1493 if(apv_cnt_)
6104  0f1a be4e          	ldw	x,_apv_cnt_
6105  0f1c 2712          	jreq	L1562
6106                     ; 1495 	apv_cnt_--;
6108  0f1e be4e          	ldw	x,_apv_cnt_
6109  0f20 1d0001        	subw	x,#1
6110  0f23 bf4e          	ldw	_apv_cnt_,x
6111                     ; 1496 	if(apv_cnt_==0) 
6113  0f25 be4e          	ldw	x,_apv_cnt_
6114  0f27 2607          	jrne	L1562
6115                     ; 1498 		bAPV=0;
6117  0f29 72110002      	bres	_bAPV
6118                     ; 1499 		apv_start();
6120  0f2d cd0e7f        	call	_apv_start
6122  0f30               L1562:
6123                     ; 1503 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6125  0f30 be71          	ldw	x,_umin_cnt
6126  0f32 261e          	jrne	L5562
6128  0f34 be73          	ldw	x,_umax_cnt
6129  0f36 261a          	jrne	L5562
6131  0f38 c65005        	ld	a,20485
6132  0f3b a504          	bcp	a,#4
6133  0f3d 2613          	jrne	L5562
6134                     ; 1505 	if(cnt_apv_off<20)
6136  0f3f b64d          	ld	a,_cnt_apv_off
6137  0f41 a114          	cp	a,#20
6138  0f43 240f          	jruge	L3662
6139                     ; 1507 		cnt_apv_off++;
6141  0f45 3c4d          	inc	_cnt_apv_off
6142                     ; 1508 		if(cnt_apv_off>=20)
6144  0f47 b64d          	ld	a,_cnt_apv_off
6145  0f49 a114          	cp	a,#20
6146  0f4b 2507          	jrult	L3662
6147                     ; 1510 			apv_stop();
6149  0f4d cd0ea8        	call	_apv_stop
6151  0f50 2002          	jra	L3662
6152  0f52               L5562:
6153                     ; 1514 else cnt_apv_off=0;	
6155  0f52 3f4d          	clr	_cnt_apv_off
6156  0f54               L3662:
6157                     ; 1516 }
6160  0f54 81            	ret
6163                     	switch	.ubsct
6164  0000               L5662_flags_old:
6165  0000 00            	ds.b	1
6201                     ; 1519 void flags_drv(void)
6201                     ; 1520 {
6202                     	switch	.text
6203  0f55               _flags_drv:
6207                     ; 1522 if(jp_mode!=jp3) 
6209  0f55 b655          	ld	a,_jp_mode
6210  0f57 a103          	cp	a,#3
6211  0f59 2723          	jreq	L5072
6212                     ; 1524 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6214  0f5b b605          	ld	a,_flags
6215  0f5d a508          	bcp	a,#8
6216  0f5f 2706          	jreq	L3172
6218  0f61 b600          	ld	a,L5662_flags_old
6219  0f63 a508          	bcp	a,#8
6220  0f65 270c          	jreq	L1172
6221  0f67               L3172:
6223  0f67 b605          	ld	a,_flags
6224  0f69 a510          	bcp	a,#16
6225  0f6b 2726          	jreq	L7172
6227  0f6d b600          	ld	a,L5662_flags_old
6228  0f6f a510          	bcp	a,#16
6229  0f71 2620          	jrne	L7172
6230  0f73               L1172:
6231                     ; 1526     		if(link==OFF)apv_start();
6233  0f73 b670          	ld	a,_link
6234  0f75 a1aa          	cp	a,#170
6235  0f77 261a          	jrne	L7172
6238  0f79 cd0e7f        	call	_apv_start
6240  0f7c 2015          	jra	L7172
6241  0f7e               L5072:
6242                     ; 1529 else if(jp_mode==jp3) 
6244  0f7e b655          	ld	a,_jp_mode
6245  0f80 a103          	cp	a,#3
6246  0f82 260f          	jrne	L7172
6247                     ; 1531 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6249  0f84 b605          	ld	a,_flags
6250  0f86 a508          	bcp	a,#8
6251  0f88 2709          	jreq	L7172
6253  0f8a b600          	ld	a,L5662_flags_old
6254  0f8c a508          	bcp	a,#8
6255  0f8e 2603          	jrne	L7172
6256                     ; 1533     		apv_start();
6258  0f90 cd0e7f        	call	_apv_start
6260  0f93               L7172:
6261                     ; 1536 flags_old=flags;
6263  0f93 450500        	mov	L5662_flags_old,_flags
6264                     ; 1538 } 
6267  0f96 81            	ret
6302                     ; 1675 void adr_drv_v4(char in)
6302                     ; 1676 {
6303                     	switch	.text
6304  0f97               _adr_drv_v4:
6308                     ; 1677 if(adress!=in)adress=in;
6310  0f97 c10101        	cp	a,_adress
6311  0f9a 2703          	jreq	L3472
6314  0f9c c70101        	ld	_adress,a
6315  0f9f               L3472:
6316                     ; 1678 }
6319  0f9f 81            	ret
6348                     ; 1681 void adr_drv_v3(void)
6348                     ; 1682 {
6349                     	switch	.text
6350  0fa0               _adr_drv_v3:
6352  0fa0 88            	push	a
6353       00000001      OFST:	set	1
6356                     ; 1688 GPIOB->DDR&=~(1<<0);
6358  0fa1 72115007      	bres	20487,#0
6359                     ; 1689 GPIOB->CR1&=~(1<<0);
6361  0fa5 72115008      	bres	20488,#0
6362                     ; 1690 GPIOB->CR2&=~(1<<0);
6364  0fa9 72115009      	bres	20489,#0
6365                     ; 1691 ADC2->CR2=0x08;
6367  0fad 35085402      	mov	21506,#8
6368                     ; 1692 ADC2->CR1=0x40;
6370  0fb1 35405401      	mov	21505,#64
6371                     ; 1693 ADC2->CSR=0x20+0;
6373  0fb5 35205400      	mov	21504,#32
6374                     ; 1694 ADC2->CR1|=1;
6376  0fb9 72105401      	bset	21505,#0
6377                     ; 1695 ADC2->CR1|=1;
6379  0fbd 72105401      	bset	21505,#0
6380                     ; 1696 adr_drv_stat=1;
6382  0fc1 35010002      	mov	_adr_drv_stat,#1
6383  0fc5               L5572:
6384                     ; 1697 while(adr_drv_stat==1);
6387  0fc5 b602          	ld	a,_adr_drv_stat
6388  0fc7 a101          	cp	a,#1
6389  0fc9 27fa          	jreq	L5572
6390                     ; 1699 GPIOB->DDR&=~(1<<1);
6392  0fcb 72135007      	bres	20487,#1
6393                     ; 1700 GPIOB->CR1&=~(1<<1);
6395  0fcf 72135008      	bres	20488,#1
6396                     ; 1701 GPIOB->CR2&=~(1<<1);
6398  0fd3 72135009      	bres	20489,#1
6399                     ; 1702 ADC2->CR2=0x08;
6401  0fd7 35085402      	mov	21506,#8
6402                     ; 1703 ADC2->CR1=0x40;
6404  0fdb 35405401      	mov	21505,#64
6405                     ; 1704 ADC2->CSR=0x20+1;
6407  0fdf 35215400      	mov	21504,#33
6408                     ; 1705 ADC2->CR1|=1;
6410  0fe3 72105401      	bset	21505,#0
6411                     ; 1706 ADC2->CR1|=1;
6413  0fe7 72105401      	bset	21505,#0
6414                     ; 1707 adr_drv_stat=3;
6416  0feb 35030002      	mov	_adr_drv_stat,#3
6417  0fef               L3672:
6418                     ; 1708 while(adr_drv_stat==3);
6421  0fef b602          	ld	a,_adr_drv_stat
6422  0ff1 a103          	cp	a,#3
6423  0ff3 27fa          	jreq	L3672
6424                     ; 1710 GPIOE->DDR&=~(1<<6);
6426  0ff5 721d5016      	bres	20502,#6
6427                     ; 1711 GPIOE->CR1&=~(1<<6);
6429  0ff9 721d5017      	bres	20503,#6
6430                     ; 1712 GPIOE->CR2&=~(1<<6);
6432  0ffd 721d5018      	bres	20504,#6
6433                     ; 1713 ADC2->CR2=0x08;
6435  1001 35085402      	mov	21506,#8
6436                     ; 1714 ADC2->CR1=0x40;
6438  1005 35405401      	mov	21505,#64
6439                     ; 1715 ADC2->CSR=0x20+9;
6441  1009 35295400      	mov	21504,#41
6442                     ; 1716 ADC2->CR1|=1;
6444  100d 72105401      	bset	21505,#0
6445                     ; 1717 ADC2->CR1|=1;
6447  1011 72105401      	bset	21505,#0
6448                     ; 1718 adr_drv_stat=5;
6450  1015 35050002      	mov	_adr_drv_stat,#5
6451  1019               L1772:
6452                     ; 1719 while(adr_drv_stat==5);
6455  1019 b602          	ld	a,_adr_drv_stat
6456  101b a105          	cp	a,#5
6457  101d 27fa          	jreq	L1772
6458                     ; 1723 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6460  101f 9c            	rvf
6461  1020 ce0109        	ldw	x,_adc_buff_
6462  1023 a3022a        	cpw	x,#554
6463  1026 2f0f          	jrslt	L7772
6465  1028 9c            	rvf
6466  1029 ce0109        	ldw	x,_adc_buff_
6467  102c a30253        	cpw	x,#595
6468  102f 2e06          	jrsge	L7772
6471  1031 725f0102      	clr	_adr
6473  1035 204c          	jra	L1003
6474  1037               L7772:
6475                     ; 1724 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6477  1037 9c            	rvf
6478  1038 ce0109        	ldw	x,_adc_buff_
6479  103b a3036d        	cpw	x,#877
6480  103e 2f0f          	jrslt	L3003
6482  1040 9c            	rvf
6483  1041 ce0109        	ldw	x,_adc_buff_
6484  1044 a30396        	cpw	x,#918
6485  1047 2e06          	jrsge	L3003
6488  1049 35010102      	mov	_adr,#1
6490  104d 2034          	jra	L1003
6491  104f               L3003:
6492                     ; 1725 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6494  104f 9c            	rvf
6495  1050 ce0109        	ldw	x,_adc_buff_
6496  1053 a302a3        	cpw	x,#675
6497  1056 2f0f          	jrslt	L7003
6499  1058 9c            	rvf
6500  1059 ce0109        	ldw	x,_adc_buff_
6501  105c a302cc        	cpw	x,#716
6502  105f 2e06          	jrsge	L7003
6505  1061 35020102      	mov	_adr,#2
6507  1065 201c          	jra	L1003
6508  1067               L7003:
6509                     ; 1726 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6511  1067 9c            	rvf
6512  1068 ce0109        	ldw	x,_adc_buff_
6513  106b a303e3        	cpw	x,#995
6514  106e 2f0f          	jrslt	L3103
6516  1070 9c            	rvf
6517  1071 ce0109        	ldw	x,_adc_buff_
6518  1074 a3040c        	cpw	x,#1036
6519  1077 2e06          	jrsge	L3103
6522  1079 35030102      	mov	_adr,#3
6524  107d 2004          	jra	L1003
6525  107f               L3103:
6526                     ; 1727 else adr[0]=5;
6528  107f 35050102      	mov	_adr,#5
6529  1083               L1003:
6530                     ; 1729 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6532  1083 9c            	rvf
6533  1084 ce010b        	ldw	x,_adc_buff_+2
6534  1087 a3022a        	cpw	x,#554
6535  108a 2f0f          	jrslt	L7103
6537  108c 9c            	rvf
6538  108d ce010b        	ldw	x,_adc_buff_+2
6539  1090 a30253        	cpw	x,#595
6540  1093 2e06          	jrsge	L7103
6543  1095 725f0103      	clr	_adr+1
6545  1099 204c          	jra	L1203
6546  109b               L7103:
6547                     ; 1730 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6549  109b 9c            	rvf
6550  109c ce010b        	ldw	x,_adc_buff_+2
6551  109f a3036d        	cpw	x,#877
6552  10a2 2f0f          	jrslt	L3203
6554  10a4 9c            	rvf
6555  10a5 ce010b        	ldw	x,_adc_buff_+2
6556  10a8 a30396        	cpw	x,#918
6557  10ab 2e06          	jrsge	L3203
6560  10ad 35010103      	mov	_adr+1,#1
6562  10b1 2034          	jra	L1203
6563  10b3               L3203:
6564                     ; 1731 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6566  10b3 9c            	rvf
6567  10b4 ce010b        	ldw	x,_adc_buff_+2
6568  10b7 a302a3        	cpw	x,#675
6569  10ba 2f0f          	jrslt	L7203
6571  10bc 9c            	rvf
6572  10bd ce010b        	ldw	x,_adc_buff_+2
6573  10c0 a302cc        	cpw	x,#716
6574  10c3 2e06          	jrsge	L7203
6577  10c5 35020103      	mov	_adr+1,#2
6579  10c9 201c          	jra	L1203
6580  10cb               L7203:
6581                     ; 1732 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6583  10cb 9c            	rvf
6584  10cc ce010b        	ldw	x,_adc_buff_+2
6585  10cf a303e3        	cpw	x,#995
6586  10d2 2f0f          	jrslt	L3303
6588  10d4 9c            	rvf
6589  10d5 ce010b        	ldw	x,_adc_buff_+2
6590  10d8 a3040c        	cpw	x,#1036
6591  10db 2e06          	jrsge	L3303
6594  10dd 35030103      	mov	_adr+1,#3
6596  10e1 2004          	jra	L1203
6597  10e3               L3303:
6598                     ; 1733 else adr[1]=5;
6600  10e3 35050103      	mov	_adr+1,#5
6601  10e7               L1203:
6602                     ; 1735 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6604  10e7 9c            	rvf
6605  10e8 ce011b        	ldw	x,_adc_buff_+18
6606  10eb a3022a        	cpw	x,#554
6607  10ee 2f0f          	jrslt	L7303
6609  10f0 9c            	rvf
6610  10f1 ce011b        	ldw	x,_adc_buff_+18
6611  10f4 a30253        	cpw	x,#595
6612  10f7 2e06          	jrsge	L7303
6615  10f9 725f0104      	clr	_adr+2
6617  10fd 204c          	jra	L1403
6618  10ff               L7303:
6619                     ; 1736 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6621  10ff 9c            	rvf
6622  1100 ce011b        	ldw	x,_adc_buff_+18
6623  1103 a3036d        	cpw	x,#877
6624  1106 2f0f          	jrslt	L3403
6626  1108 9c            	rvf
6627  1109 ce011b        	ldw	x,_adc_buff_+18
6628  110c a30396        	cpw	x,#918
6629  110f 2e06          	jrsge	L3403
6632  1111 35010104      	mov	_adr+2,#1
6634  1115 2034          	jra	L1403
6635  1117               L3403:
6636                     ; 1737 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6638  1117 9c            	rvf
6639  1118 ce011b        	ldw	x,_adc_buff_+18
6640  111b a302a3        	cpw	x,#675
6641  111e 2f0f          	jrslt	L7403
6643  1120 9c            	rvf
6644  1121 ce011b        	ldw	x,_adc_buff_+18
6645  1124 a302cc        	cpw	x,#716
6646  1127 2e06          	jrsge	L7403
6649  1129 35020104      	mov	_adr+2,#2
6651  112d 201c          	jra	L1403
6652  112f               L7403:
6653                     ; 1738 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6655  112f 9c            	rvf
6656  1130 ce011b        	ldw	x,_adc_buff_+18
6657  1133 a303e3        	cpw	x,#995
6658  1136 2f0f          	jrslt	L3503
6660  1138 9c            	rvf
6661  1139 ce011b        	ldw	x,_adc_buff_+18
6662  113c a3040c        	cpw	x,#1036
6663  113f 2e06          	jrsge	L3503
6666  1141 35030104      	mov	_adr+2,#3
6668  1145 2004          	jra	L1403
6669  1147               L3503:
6670                     ; 1739 else adr[2]=5;
6672  1147 35050104      	mov	_adr+2,#5
6673  114b               L1403:
6674                     ; 1743 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6676  114b c60102        	ld	a,_adr
6677  114e a105          	cp	a,#5
6678  1150 270e          	jreq	L1603
6680  1152 c60103        	ld	a,_adr+1
6681  1155 a105          	cp	a,#5
6682  1157 2707          	jreq	L1603
6684  1159 c60104        	ld	a,_adr+2
6685  115c a105          	cp	a,#5
6686  115e 2606          	jrne	L7503
6687  1160               L1603:
6688                     ; 1746 	adress_error=1;
6690  1160 35010100      	mov	_adress_error,#1
6692  1164               L5603:
6693                     ; 1757 }
6696  1164 84            	pop	a
6697  1165 81            	ret
6698  1166               L7503:
6699                     ; 1750 	if(adr[2]&0x02) bps_class=bpsIPS;
6701  1166 c60104        	ld	a,_adr+2
6702  1169 a502          	bcp	a,#2
6703  116b 2706          	jreq	L7603
6706  116d 3501000b      	mov	_bps_class,#1
6708  1171 2002          	jra	L1703
6709  1173               L7603:
6710                     ; 1751 	else bps_class=bpsIBEP;
6712  1173 3f0b          	clr	_bps_class
6713  1175               L1703:
6714                     ; 1753 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6716  1175 c60104        	ld	a,_adr+2
6717  1178 a401          	and	a,#1
6718  117a 97            	ld	xl,a
6719  117b a610          	ld	a,#16
6720  117d 42            	mul	x,a
6721  117e 9f            	ld	a,xl
6722  117f 6b01          	ld	(OFST+0,sp),a
6723  1181 c60103        	ld	a,_adr+1
6724  1184 48            	sll	a
6725  1185 48            	sll	a
6726  1186 cb0102        	add	a,_adr
6727  1189 1b01          	add	a,(OFST+0,sp)
6728  118b c70101        	ld	_adress,a
6729  118e 20d4          	jra	L5603
6752                     ; 1807 void init_CAN(void) {
6753                     	switch	.text
6754  1190               _init_CAN:
6758                     ; 1808 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6760  1190 72135420      	bres	21536,#1
6761                     ; 1809 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6763  1194 72105420      	bset	21536,#0
6765  1198               L5013:
6766                     ; 1810 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6768  1198 c65421        	ld	a,21537
6769  119b a501          	bcp	a,#1
6770  119d 27f9          	jreq	L5013
6771                     ; 1812 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6773  119f 72185420      	bset	21536,#4
6774                     ; 1814 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6776  11a3 35025427      	mov	21543,#2
6777                     ; 1823 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6779  11a7 35135428      	mov	21544,#19
6780                     ; 1824 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6782  11ab 35c05429      	mov	21545,#192
6783                     ; 1825 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6785  11af 357f542c      	mov	21548,#127
6786                     ; 1826 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6788  11b3 35e0542d      	mov	21549,#224
6789                     ; 1828 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6791  11b7 35315430      	mov	21552,#49
6792                     ; 1829 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6794  11bb 35c05431      	mov	21553,#192
6795                     ; 1830 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6797  11bf 357f5434      	mov	21556,#127
6798                     ; 1831 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6800  11c3 35e05435      	mov	21557,#224
6801                     ; 1835 	CAN->PSR= 6;									// set page 6
6803  11c7 35065427      	mov	21543,#6
6804                     ; 1840 	CAN->Page.Config.FMR1&=~3;								//mask mode
6806  11cb c65430        	ld	a,21552
6807  11ce a4fc          	and	a,#252
6808  11d0 c75430        	ld	21552,a
6809                     ; 1846 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6811  11d3 35065432      	mov	21554,#6
6812                     ; 1847 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6814  11d7 35605432      	mov	21554,#96
6815                     ; 1850 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6817  11db 72105432      	bset	21554,#0
6818                     ; 1851 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6820  11df 72185432      	bset	21554,#4
6821                     ; 1854 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6823  11e3 35065427      	mov	21543,#6
6824                     ; 1856 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6826  11e7 35d3542c      	mov	21548,#211
6827                     ; 1857 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6829  11eb 35e7542d      	mov	21549,#231
6830                     ; 1859 	CAN->IER|=(1<<1);
6832  11ef 72125425      	bset	21541,#1
6833                     ; 1862 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6835  11f3 72115420      	bres	21536,#0
6837  11f7               L3113:
6838                     ; 1863 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6840  11f7 c65421        	ld	a,21537
6841  11fa a501          	bcp	a,#1
6842  11fc 26f9          	jrne	L3113
6843                     ; 1864 }
6846  11fe 81            	ret
6954                     ; 1867 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6954                     ; 1868 {
6955                     	switch	.text
6956  11ff               _can_transmit:
6958  11ff 89            	pushw	x
6959       00000000      OFST:	set	0
6962                     ; 1870 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6964  1200 b679          	ld	a,_can_buff_wr_ptr
6965  1202 a104          	cp	a,#4
6966  1204 2502          	jrult	L5713
6969  1206 3f79          	clr	_can_buff_wr_ptr
6970  1208               L5713:
6971                     ; 1872 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6973  1208 b679          	ld	a,_can_buff_wr_ptr
6974  120a 97            	ld	xl,a
6975  120b a610          	ld	a,#16
6976  120d 42            	mul	x,a
6977  120e 1601          	ldw	y,(OFST+1,sp)
6978  1210 a606          	ld	a,#6
6979  1212               L631:
6980  1212 9054          	srlw	y
6981  1214 4a            	dec	a
6982  1215 26fb          	jrne	L631
6983  1217 909f          	ld	a,yl
6984  1219 e77a          	ld	(_can_out_buff,x),a
6985                     ; 1873 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6987  121b b679          	ld	a,_can_buff_wr_ptr
6988  121d 97            	ld	xl,a
6989  121e a610          	ld	a,#16
6990  1220 42            	mul	x,a
6991  1221 7b02          	ld	a,(OFST+2,sp)
6992  1223 48            	sll	a
6993  1224 48            	sll	a
6994  1225 e77b          	ld	(_can_out_buff+1,x),a
6995                     ; 1875 can_out_buff[can_buff_wr_ptr][2]=data0;
6997  1227 b679          	ld	a,_can_buff_wr_ptr
6998  1229 97            	ld	xl,a
6999  122a a610          	ld	a,#16
7000  122c 42            	mul	x,a
7001  122d 7b05          	ld	a,(OFST+5,sp)
7002  122f e77c          	ld	(_can_out_buff+2,x),a
7003                     ; 1876 can_out_buff[can_buff_wr_ptr][3]=data1;
7005  1231 b679          	ld	a,_can_buff_wr_ptr
7006  1233 97            	ld	xl,a
7007  1234 a610          	ld	a,#16
7008  1236 42            	mul	x,a
7009  1237 7b06          	ld	a,(OFST+6,sp)
7010  1239 e77d          	ld	(_can_out_buff+3,x),a
7011                     ; 1877 can_out_buff[can_buff_wr_ptr][4]=data2;
7013  123b b679          	ld	a,_can_buff_wr_ptr
7014  123d 97            	ld	xl,a
7015  123e a610          	ld	a,#16
7016  1240 42            	mul	x,a
7017  1241 7b07          	ld	a,(OFST+7,sp)
7018  1243 e77e          	ld	(_can_out_buff+4,x),a
7019                     ; 1878 can_out_buff[can_buff_wr_ptr][5]=data3;
7021  1245 b679          	ld	a,_can_buff_wr_ptr
7022  1247 97            	ld	xl,a
7023  1248 a610          	ld	a,#16
7024  124a 42            	mul	x,a
7025  124b 7b08          	ld	a,(OFST+8,sp)
7026  124d e77f          	ld	(_can_out_buff+5,x),a
7027                     ; 1879 can_out_buff[can_buff_wr_ptr][6]=data4;
7029  124f b679          	ld	a,_can_buff_wr_ptr
7030  1251 97            	ld	xl,a
7031  1252 a610          	ld	a,#16
7032  1254 42            	mul	x,a
7033  1255 7b09          	ld	a,(OFST+9,sp)
7034  1257 e780          	ld	(_can_out_buff+6,x),a
7035                     ; 1880 can_out_buff[can_buff_wr_ptr][7]=data5;
7037  1259 b679          	ld	a,_can_buff_wr_ptr
7038  125b 97            	ld	xl,a
7039  125c a610          	ld	a,#16
7040  125e 42            	mul	x,a
7041  125f 7b0a          	ld	a,(OFST+10,sp)
7042  1261 e781          	ld	(_can_out_buff+7,x),a
7043                     ; 1881 can_out_buff[can_buff_wr_ptr][8]=data6;
7045  1263 b679          	ld	a,_can_buff_wr_ptr
7046  1265 97            	ld	xl,a
7047  1266 a610          	ld	a,#16
7048  1268 42            	mul	x,a
7049  1269 7b0b          	ld	a,(OFST+11,sp)
7050  126b e782          	ld	(_can_out_buff+8,x),a
7051                     ; 1882 can_out_buff[can_buff_wr_ptr][9]=data7;
7053  126d b679          	ld	a,_can_buff_wr_ptr
7054  126f 97            	ld	xl,a
7055  1270 a610          	ld	a,#16
7056  1272 42            	mul	x,a
7057  1273 7b0c          	ld	a,(OFST+12,sp)
7058  1275 e783          	ld	(_can_out_buff+9,x),a
7059                     ; 1884 can_buff_wr_ptr++;
7061  1277 3c79          	inc	_can_buff_wr_ptr
7062                     ; 1885 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7064  1279 b679          	ld	a,_can_buff_wr_ptr
7065  127b a104          	cp	a,#4
7066  127d 2502          	jrult	L7713
7069  127f 3f79          	clr	_can_buff_wr_ptr
7070  1281               L7713:
7071                     ; 1886 } 
7074  1281 85            	popw	x
7075  1282 81            	ret
7104                     ; 1889 void can_tx_hndl(void)
7104                     ; 1890 {
7105                     	switch	.text
7106  1283               _can_tx_hndl:
7110                     ; 1891 if(bTX_FREE)
7112  1283 3d03          	tnz	_bTX_FREE
7113  1285 2757          	jreq	L1123
7114                     ; 1893 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7116  1287 b678          	ld	a,_can_buff_rd_ptr
7117  1289 b179          	cp	a,_can_buff_wr_ptr
7118  128b 275f          	jreq	L7123
7119                     ; 1895 		bTX_FREE=0;
7121  128d 3f03          	clr	_bTX_FREE
7122                     ; 1897 		CAN->PSR= 0;
7124  128f 725f5427      	clr	21543
7125                     ; 1898 		CAN->Page.TxMailbox.MDLCR=8;
7127  1293 35085429      	mov	21545,#8
7128                     ; 1899 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7130  1297 b678          	ld	a,_can_buff_rd_ptr
7131  1299 97            	ld	xl,a
7132  129a a610          	ld	a,#16
7133  129c 42            	mul	x,a
7134  129d e67a          	ld	a,(_can_out_buff,x)
7135  129f c7542a        	ld	21546,a
7136                     ; 1900 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7138  12a2 b678          	ld	a,_can_buff_rd_ptr
7139  12a4 97            	ld	xl,a
7140  12a5 a610          	ld	a,#16
7141  12a7 42            	mul	x,a
7142  12a8 e67b          	ld	a,(_can_out_buff+1,x)
7143  12aa c7542b        	ld	21547,a
7144                     ; 1902 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7146  12ad b678          	ld	a,_can_buff_rd_ptr
7147  12af 97            	ld	xl,a
7148  12b0 a610          	ld	a,#16
7149  12b2 42            	mul	x,a
7150  12b3 01            	rrwa	x,a
7151  12b4 ab7c          	add	a,#_can_out_buff+2
7152  12b6 2401          	jrnc	L241
7153  12b8 5c            	incw	x
7154  12b9               L241:
7155  12b9 5f            	clrw	x
7156  12ba 97            	ld	xl,a
7157  12bb bf00          	ldw	c_x,x
7158  12bd ae0008        	ldw	x,#8
7159  12c0               L441:
7160  12c0 5a            	decw	x
7161  12c1 92d600        	ld	a,([c_x],x)
7162  12c4 d7542e        	ld	(21550,x),a
7163  12c7 5d            	tnzw	x
7164  12c8 26f6          	jrne	L441
7165                     ; 1904 		can_buff_rd_ptr++;
7167  12ca 3c78          	inc	_can_buff_rd_ptr
7168                     ; 1905 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7170  12cc b678          	ld	a,_can_buff_rd_ptr
7171  12ce a104          	cp	a,#4
7172  12d0 2502          	jrult	L5123
7175  12d2 3f78          	clr	_can_buff_rd_ptr
7176  12d4               L5123:
7177                     ; 1907 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7179  12d4 72105428      	bset	21544,#0
7180                     ; 1908 		CAN->IER|=(1<<0);
7182  12d8 72105425      	bset	21541,#0
7183  12dc 200e          	jra	L7123
7184  12de               L1123:
7185                     ; 1913 	tx_busy_cnt++;
7187  12de 3c77          	inc	_tx_busy_cnt
7188                     ; 1914 	if(tx_busy_cnt>=100)
7190  12e0 b677          	ld	a,_tx_busy_cnt
7191  12e2 a164          	cp	a,#100
7192  12e4 2506          	jrult	L7123
7193                     ; 1916 		tx_busy_cnt=0;
7195  12e6 3f77          	clr	_tx_busy_cnt
7196                     ; 1917 		bTX_FREE=1;
7198  12e8 35010003      	mov	_bTX_FREE,#1
7199  12ec               L7123:
7200                     ; 1920 }
7203  12ec 81            	ret
7320                     ; 1946 void can_in_an(void)
7320                     ; 1947 {
7321                     	switch	.text
7322  12ed               _can_in_an:
7324  12ed 5207          	subw	sp,#7
7325       00000007      OFST:	set	7
7328                     ; 1957 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7330  12ef b6d0          	ld	a,_mess+6
7331  12f1 c10101        	cp	a,_adress
7332  12f4 2703          	jreq	L461
7333  12f6 cc1457        	jp	L7523
7334  12f9               L461:
7336  12f9 b6d1          	ld	a,_mess+7
7337  12fb c10101        	cp	a,_adress
7338  12fe 2703          	jreq	L661
7339  1300 cc1457        	jp	L7523
7340  1303               L661:
7342  1303 b6d2          	ld	a,_mess+8
7343  1305 a1ed          	cp	a,#237
7344  1307 2703          	jreq	L071
7345  1309 cc1457        	jp	L7523
7346  130c               L071:
7347                     ; 1960 	can_error_cnt=0;
7349  130c 3f76          	clr	_can_error_cnt
7350                     ; 1962 	bMAIN=0;
7352  130e 72110001      	bres	_bMAIN
7353                     ; 1963  	flags_tu=mess[9];
7355  1312 45d36d        	mov	_flags_tu,_mess+9
7356                     ; 1964  	if(flags_tu&0b00000001)
7358  1315 b66d          	ld	a,_flags_tu
7359  1317 a501          	bcp	a,#1
7360  1319 2706          	jreq	L1623
7361                     ; 1969  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7363  131b 721a0005      	bset	_flags,#5
7365  131f 2008          	jra	L3623
7366  1321               L1623:
7367                     ; 1980  				flags&=0b11011111; 
7369  1321 721b0005      	bres	_flags,#5
7370                     ; 1981  				off_bp_cnt=5*EE_TZAS;
7372  1325 350f0060      	mov	_off_bp_cnt,#15
7373  1329               L3623:
7374                     ; 1987  	if(flags_tu&0b00000010) flags|=0b01000000;
7376  1329 b66d          	ld	a,_flags_tu
7377  132b a502          	bcp	a,#2
7378  132d 2706          	jreq	L5623
7381  132f 721c0005      	bset	_flags,#6
7383  1333 2004          	jra	L7623
7384  1335               L5623:
7385                     ; 1988  	else flags&=0b10111111; 
7387  1335 721d0005      	bres	_flags,#6
7388  1339               L7623:
7389                     ; 1990  	U_out_const=mess[10]+mess[11]*256;
7391  1339 b6d5          	ld	a,_mess+11
7392  133b 5f            	clrw	x
7393  133c 97            	ld	xl,a
7394  133d 4f            	clr	a
7395  133e 02            	rlwa	x,a
7396  133f 01            	rrwa	x,a
7397  1340 bbd4          	add	a,_mess+10
7398  1342 2401          	jrnc	L051
7399  1344 5c            	incw	x
7400  1345               L051:
7401  1345 c70013        	ld	_U_out_const+1,a
7402  1348 9f            	ld	a,xl
7403  1349 c70012        	ld	_U_out_const,a
7404                     ; 1991  	vol_i_temp=mess[12]+mess[13]*256;
7406  134c b6d7          	ld	a,_mess+13
7407  134e 5f            	clrw	x
7408  134f 97            	ld	xl,a
7409  1350 4f            	clr	a
7410  1351 02            	rlwa	x,a
7411  1352 01            	rrwa	x,a
7412  1353 bbd6          	add	a,_mess+12
7413  1355 2401          	jrnc	L251
7414  1357 5c            	incw	x
7415  1358               L251:
7416  1358 b764          	ld	_vol_i_temp+1,a
7417  135a 9f            	ld	a,xl
7418  135b b763          	ld	_vol_i_temp,a
7419                     ; 1992 	if(vol_i_temp>20)vol_i_temp=20;
7421  135d 9c            	rvf
7422  135e be63          	ldw	x,_vol_i_temp
7423  1360 a30015        	cpw	x,#21
7424  1363 2f05          	jrslt	L1723
7427  1365 ae0014        	ldw	x,#20
7428  1368 bf63          	ldw	_vol_i_temp,x
7429  136a               L1723:
7430                     ; 1993  	if(vol_i_temp<-20)vol_i_temp=-20;
7432  136a 9c            	rvf
7433  136b be63          	ldw	x,_vol_i_temp
7434  136d a3ffec        	cpw	x,#65516
7435  1370 2e05          	jrsge	L3723
7438  1372 aeffec        	ldw	x,#65516
7439  1375 bf63          	ldw	_vol_i_temp,x
7440  1377               L3723:
7441                     ; 2003 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7443  1377 b608          	ld	a,_vent_resurs_tx_cnt
7444  1379 a102          	cp	a,#2
7445  137b 2507          	jrult	L5723
7448  137d ce0000        	ldw	x,_vent_resurs
7449  1380 bf42          	ldw	_plazma_int+4,x
7451  1382 2004          	jra	L7723
7452  1384               L5723:
7453                     ; 2004 	else plazma_int[2]=vent_resurs_sec_cnt;
7455  1384 be09          	ldw	x,_vent_resurs_sec_cnt
7456  1386 bf42          	ldw	_plazma_int+4,x
7457  1388               L7723:
7458                     ; 2005  	rotor_int=flags_tu+(((short)flags)<<8);
7460  1388 b605          	ld	a,_flags
7461  138a 5f            	clrw	x
7462  138b 97            	ld	xl,a
7463  138c 4f            	clr	a
7464  138d 02            	rlwa	x,a
7465  138e 01            	rrwa	x,a
7466  138f bb6d          	add	a,_flags_tu
7467  1391 2401          	jrnc	L451
7468  1393 5c            	incw	x
7469  1394               L451:
7470  1394 b718          	ld	_rotor_int+1,a
7471  1396 9f            	ld	a,xl
7472  1397 b717          	ld	_rotor_int,a
7473                     ; 2007 	debug_info_to_uku[0]=pwm_u;
7475  1399 be08          	ldw	x,_pwm_u
7476  139b bf01          	ldw	_debug_info_to_uku,x
7477                     ; 2008 	debug_info_to_uku[1]=Ufade;//Usum;
7479  139d ce000a        	ldw	x,_Ufade
7480  13a0 bf03          	ldw	_debug_info_to_uku+2,x
7481                     ; 2009 	debug_info_to_uku[2]=FADE_MODE;//pwm_u;
7483  13a2 b613          	ld	a,_FADE_MODE
7484  13a4 5f            	clrw	x
7485  13a5 97            	ld	xl,a
7486  13a6 bf05          	ldw	_debug_info_to_uku+4,x
7487                     ; 2012 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7489  13a8 3b0016        	push	_Ui
7490  13ab 3b0017        	push	_Ui+1
7491  13ae 3b0018        	push	_Un
7492  13b1 3b0019        	push	_Un+1
7493  13b4 3b001a        	push	_I
7494  13b7 3b001b        	push	_I+1
7495  13ba 4bda          	push	#218
7496  13bc 3b0101        	push	_adress
7497  13bf ae018e        	ldw	x,#398
7498  13c2 cd11ff        	call	_can_transmit
7500  13c5 5b08          	addw	sp,#8
7501                     ; 2013 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7503  13c7 3b0010        	push	_Usum
7504  13ca 3b0011        	push	_Usum+1
7505  13cd 3b006c        	push	__x_+1
7506  13d0 3b0005        	push	_flags
7507  13d3 b608          	ld	a,_vent_resurs_tx_cnt
7508  13d5 5f            	clrw	x
7509  13d6 97            	ld	xl,a
7510  13d7 d60000        	ld	a,(_vent_resurs_buff,x)
7511  13da 88            	push	a
7512  13db 3b0075        	push	_T
7513  13de 4bdb          	push	#219
7514  13e0 3b0101        	push	_adress
7515  13e3 ae018e        	ldw	x,#398
7516  13e6 cd11ff        	call	_can_transmit
7518  13e9 5b08          	addw	sp,#8
7519                     ; 2014 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7521  13eb 3b0005        	push	_debug_info_to_uku+4
7522  13ee 3b0006        	push	_debug_info_to_uku+5
7523  13f1 3b0003        	push	_debug_info_to_uku+2
7524  13f4 3b0004        	push	_debug_info_to_uku+3
7525  13f7 3b0001        	push	_debug_info_to_uku
7526  13fa 3b0002        	push	_debug_info_to_uku+1
7527  13fd 4bdc          	push	#220
7528  13ff 3b0101        	push	_adress
7529  1402 ae018e        	ldw	x,#398
7530  1405 cd11ff        	call	_can_transmit
7532  1408 5b08          	addw	sp,#8
7533                     ; 2015      link_cnt=0;
7535  140a 5f            	clrw	x
7536  140b bf6e          	ldw	_link_cnt,x
7537                     ; 2016      link=ON;
7539  140d 35550070      	mov	_link,#85
7540                     ; 2018      if(flags_tu&0b10000000)
7542  1411 b66d          	ld	a,_flags_tu
7543  1413 a580          	bcp	a,#128
7544  1415 2716          	jreq	L1033
7545                     ; 2020      	if(!res_fl)
7547  1417 725d000b      	tnz	_res_fl
7548  141b 2626          	jrne	L5033
7549                     ; 2022      		res_fl=1;
7551  141d a601          	ld	a,#1
7552  141f ae000b        	ldw	x,#_res_fl
7553  1422 cd0000        	call	c_eewrc
7555                     ; 2023      		bRES=1;
7557  1425 3501000c      	mov	_bRES,#1
7558                     ; 2024      		res_fl_cnt=0;
7560  1429 3f4c          	clr	_res_fl_cnt
7561  142b 2016          	jra	L5033
7562  142d               L1033:
7563                     ; 2029      	if(main_cnt>20)
7565  142d 9c            	rvf
7566  142e ce025f        	ldw	x,_main_cnt
7567  1431 a30015        	cpw	x,#21
7568  1434 2f0d          	jrslt	L5033
7569                     ; 2031     			if(res_fl)
7571  1436 725d000b      	tnz	_res_fl
7572  143a 2707          	jreq	L5033
7573                     ; 2033      			res_fl=0;
7575  143c 4f            	clr	a
7576  143d ae000b        	ldw	x,#_res_fl
7577  1440 cd0000        	call	c_eewrc
7579  1443               L5033:
7580                     ; 2038       if(res_fl_)
7582  1443 725d000a      	tnz	_res_fl_
7583  1447 2603          	jrne	L271
7584  1449 cc19b8        	jp	L3223
7585  144c               L271:
7586                     ; 2040       	res_fl_=0;
7588  144c 4f            	clr	a
7589  144d ae000a        	ldw	x,#_res_fl_
7590  1450 cd0000        	call	c_eewrc
7592  1453 acb819b8      	jpf	L3223
7593  1457               L7523:
7594                     ; 2043 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7596  1457 b6d0          	ld	a,_mess+6
7597  1459 c10101        	cp	a,_adress
7598  145c 2703          	jreq	L471
7599  145e cc16d4        	jp	L7133
7600  1461               L471:
7602  1461 b6d1          	ld	a,_mess+7
7603  1463 c10101        	cp	a,_adress
7604  1466 2703          	jreq	L671
7605  1468 cc16d4        	jp	L7133
7606  146b               L671:
7608  146b b6d2          	ld	a,_mess+8
7609  146d a1ee          	cp	a,#238
7610  146f 2703          	jreq	L002
7611  1471 cc16d4        	jp	L7133
7612  1474               L002:
7614  1474 b6d3          	ld	a,_mess+9
7615  1476 b1d4          	cp	a,_mess+10
7616  1478 2703          	jreq	L202
7617  147a cc16d4        	jp	L7133
7618  147d               L202:
7619                     ; 2045 	rotor_int++;
7621  147d be17          	ldw	x,_rotor_int
7622  147f 1c0001        	addw	x,#1
7623  1482 bf17          	ldw	_rotor_int,x
7624                     ; 2046 	if((mess[9]&0xf0)==0x20)
7626  1484 b6d3          	ld	a,_mess+9
7627  1486 a4f0          	and	a,#240
7628  1488 a120          	cp	a,#32
7629  148a 2673          	jrne	L1233
7630                     ; 2048 		if((mess[9]&0x0f)==0x01)
7632  148c b6d3          	ld	a,_mess+9
7633  148e a40f          	and	a,#15
7634  1490 a101          	cp	a,#1
7635  1492 260d          	jrne	L3233
7636                     ; 2050 			ee_K[0][0]=adc_buff_[4];
7638  1494 ce0111        	ldw	x,_adc_buff_+8
7639  1497 89            	pushw	x
7640  1498 ae001a        	ldw	x,#_ee_K
7641  149b cd0000        	call	c_eewrw
7643  149e 85            	popw	x
7645  149f 204a          	jra	L5233
7646  14a1               L3233:
7647                     ; 2052 		else if((mess[9]&0x0f)==0x02)
7649  14a1 b6d3          	ld	a,_mess+9
7650  14a3 a40f          	and	a,#15
7651  14a5 a102          	cp	a,#2
7652  14a7 260b          	jrne	L7233
7653                     ; 2054 			ee_K[0][1]++;
7655  14a9 ce001c        	ldw	x,_ee_K+2
7656  14ac 1c0001        	addw	x,#1
7657  14af cf001c        	ldw	_ee_K+2,x
7659  14b2 2037          	jra	L5233
7660  14b4               L7233:
7661                     ; 2056 		else if((mess[9]&0x0f)==0x03)
7663  14b4 b6d3          	ld	a,_mess+9
7664  14b6 a40f          	and	a,#15
7665  14b8 a103          	cp	a,#3
7666  14ba 260b          	jrne	L3333
7667                     ; 2058 			ee_K[0][1]+=10;
7669  14bc ce001c        	ldw	x,_ee_K+2
7670  14bf 1c000a        	addw	x,#10
7671  14c2 cf001c        	ldw	_ee_K+2,x
7673  14c5 2024          	jra	L5233
7674  14c7               L3333:
7675                     ; 2060 		else if((mess[9]&0x0f)==0x04)
7677  14c7 b6d3          	ld	a,_mess+9
7678  14c9 a40f          	and	a,#15
7679  14cb a104          	cp	a,#4
7680  14cd 260b          	jrne	L7333
7681                     ; 2062 			ee_K[0][1]--;
7683  14cf ce001c        	ldw	x,_ee_K+2
7684  14d2 1d0001        	subw	x,#1
7685  14d5 cf001c        	ldw	_ee_K+2,x
7687  14d8 2011          	jra	L5233
7688  14da               L7333:
7689                     ; 2064 		else if((mess[9]&0x0f)==0x05)
7691  14da b6d3          	ld	a,_mess+9
7692  14dc a40f          	and	a,#15
7693  14de a105          	cp	a,#5
7694  14e0 2609          	jrne	L5233
7695                     ; 2066 			ee_K[0][1]-=10;
7697  14e2 ce001c        	ldw	x,_ee_K+2
7698  14e5 1d000a        	subw	x,#10
7699  14e8 cf001c        	ldw	_ee_K+2,x
7700  14eb               L5233:
7701                     ; 2068 		granee(&ee_K[0][1],50,3000);									
7703  14eb ae0bb8        	ldw	x,#3000
7704  14ee 89            	pushw	x
7705  14ef ae0032        	ldw	x,#50
7706  14f2 89            	pushw	x
7707  14f3 ae001c        	ldw	x,#_ee_K+2
7708  14f6 cd00f6        	call	_granee
7710  14f9 5b04          	addw	sp,#4
7712  14fb acb916b9      	jpf	L5433
7713  14ff               L1233:
7714                     ; 2070 	else if((mess[9]&0xf0)==0x10)
7716  14ff b6d3          	ld	a,_mess+9
7717  1501 a4f0          	and	a,#240
7718  1503 a110          	cp	a,#16
7719  1505 2673          	jrne	L7433
7720                     ; 2072 		if((mess[9]&0x0f)==0x01)
7722  1507 b6d3          	ld	a,_mess+9
7723  1509 a40f          	and	a,#15
7724  150b a101          	cp	a,#1
7725  150d 260d          	jrne	L1533
7726                     ; 2074 			ee_K[1][0]=adc_buff_[1];
7728  150f ce010b        	ldw	x,_adc_buff_+2
7729  1512 89            	pushw	x
7730  1513 ae001e        	ldw	x,#_ee_K+4
7731  1516 cd0000        	call	c_eewrw
7733  1519 85            	popw	x
7735  151a 204a          	jra	L3533
7736  151c               L1533:
7737                     ; 2076 		else if((mess[9]&0x0f)==0x02)
7739  151c b6d3          	ld	a,_mess+9
7740  151e a40f          	and	a,#15
7741  1520 a102          	cp	a,#2
7742  1522 260b          	jrne	L5533
7743                     ; 2078 			ee_K[1][1]++;
7745  1524 ce0020        	ldw	x,_ee_K+6
7746  1527 1c0001        	addw	x,#1
7747  152a cf0020        	ldw	_ee_K+6,x
7749  152d 2037          	jra	L3533
7750  152f               L5533:
7751                     ; 2080 		else if((mess[9]&0x0f)==0x03)
7753  152f b6d3          	ld	a,_mess+9
7754  1531 a40f          	and	a,#15
7755  1533 a103          	cp	a,#3
7756  1535 260b          	jrne	L1633
7757                     ; 2082 			ee_K[1][1]+=10;
7759  1537 ce0020        	ldw	x,_ee_K+6
7760  153a 1c000a        	addw	x,#10
7761  153d cf0020        	ldw	_ee_K+6,x
7763  1540 2024          	jra	L3533
7764  1542               L1633:
7765                     ; 2084 		else if((mess[9]&0x0f)==0x04)
7767  1542 b6d3          	ld	a,_mess+9
7768  1544 a40f          	and	a,#15
7769  1546 a104          	cp	a,#4
7770  1548 260b          	jrne	L5633
7771                     ; 2086 			ee_K[1][1]--;
7773  154a ce0020        	ldw	x,_ee_K+6
7774  154d 1d0001        	subw	x,#1
7775  1550 cf0020        	ldw	_ee_K+6,x
7777  1553 2011          	jra	L3533
7778  1555               L5633:
7779                     ; 2088 		else if((mess[9]&0x0f)==0x05)
7781  1555 b6d3          	ld	a,_mess+9
7782  1557 a40f          	and	a,#15
7783  1559 a105          	cp	a,#5
7784  155b 2609          	jrne	L3533
7785                     ; 2090 			ee_K[1][1]-=10;
7787  155d ce0020        	ldw	x,_ee_K+6
7788  1560 1d000a        	subw	x,#10
7789  1563 cf0020        	ldw	_ee_K+6,x
7790  1566               L3533:
7791                     ; 2095 		granee(&ee_K[1][1],10,30000);
7793  1566 ae7530        	ldw	x,#30000
7794  1569 89            	pushw	x
7795  156a ae000a        	ldw	x,#10
7796  156d 89            	pushw	x
7797  156e ae0020        	ldw	x,#_ee_K+6
7798  1571 cd00f6        	call	_granee
7800  1574 5b04          	addw	sp,#4
7802  1576 acb916b9      	jpf	L5433
7803  157a               L7433:
7804                     ; 2099 	else if((mess[9]&0xf0)==0x00)
7806  157a b6d3          	ld	a,_mess+9
7807  157c a5f0          	bcp	a,#240
7808  157e 2673          	jrne	L5733
7809                     ; 2101 		if((mess[9]&0x0f)==0x01)
7811  1580 b6d3          	ld	a,_mess+9
7812  1582 a40f          	and	a,#15
7813  1584 a101          	cp	a,#1
7814  1586 260d          	jrne	L7733
7815                     ; 2103 			ee_K[2][0]=adc_buff_[2];
7817  1588 ce010d        	ldw	x,_adc_buff_+4
7818  158b 89            	pushw	x
7819  158c ae0022        	ldw	x,#_ee_K+8
7820  158f cd0000        	call	c_eewrw
7822  1592 85            	popw	x
7824  1593 204a          	jra	L1043
7825  1595               L7733:
7826                     ; 2105 		else if((mess[9]&0x0f)==0x02)
7828  1595 b6d3          	ld	a,_mess+9
7829  1597 a40f          	and	a,#15
7830  1599 a102          	cp	a,#2
7831  159b 260b          	jrne	L3043
7832                     ; 2107 			ee_K[2][1]++;
7834  159d ce0024        	ldw	x,_ee_K+10
7835  15a0 1c0001        	addw	x,#1
7836  15a3 cf0024        	ldw	_ee_K+10,x
7838  15a6 2037          	jra	L1043
7839  15a8               L3043:
7840                     ; 2109 		else if((mess[9]&0x0f)==0x03)
7842  15a8 b6d3          	ld	a,_mess+9
7843  15aa a40f          	and	a,#15
7844  15ac a103          	cp	a,#3
7845  15ae 260b          	jrne	L7043
7846                     ; 2111 			ee_K[2][1]+=10;
7848  15b0 ce0024        	ldw	x,_ee_K+10
7849  15b3 1c000a        	addw	x,#10
7850  15b6 cf0024        	ldw	_ee_K+10,x
7852  15b9 2024          	jra	L1043
7853  15bb               L7043:
7854                     ; 2113 		else if((mess[9]&0x0f)==0x04)
7856  15bb b6d3          	ld	a,_mess+9
7857  15bd a40f          	and	a,#15
7858  15bf a104          	cp	a,#4
7859  15c1 260b          	jrne	L3143
7860                     ; 2115 			ee_K[2][1]--;
7862  15c3 ce0024        	ldw	x,_ee_K+10
7863  15c6 1d0001        	subw	x,#1
7864  15c9 cf0024        	ldw	_ee_K+10,x
7866  15cc 2011          	jra	L1043
7867  15ce               L3143:
7868                     ; 2117 		else if((mess[9]&0x0f)==0x05)
7870  15ce b6d3          	ld	a,_mess+9
7871  15d0 a40f          	and	a,#15
7872  15d2 a105          	cp	a,#5
7873  15d4 2609          	jrne	L1043
7874                     ; 2119 			ee_K[2][1]-=10;
7876  15d6 ce0024        	ldw	x,_ee_K+10
7877  15d9 1d000a        	subw	x,#10
7878  15dc cf0024        	ldw	_ee_K+10,x
7879  15df               L1043:
7880                     ; 2124 		granee(&ee_K[2][1],10,30000);
7882  15df ae7530        	ldw	x,#30000
7883  15e2 89            	pushw	x
7884  15e3 ae000a        	ldw	x,#10
7885  15e6 89            	pushw	x
7886  15e7 ae0024        	ldw	x,#_ee_K+10
7887  15ea cd00f6        	call	_granee
7889  15ed 5b04          	addw	sp,#4
7891  15ef acb916b9      	jpf	L5433
7892  15f3               L5733:
7893                     ; 2128 	else if((mess[9]&0xf0)==0x30)
7895  15f3 b6d3          	ld	a,_mess+9
7896  15f5 a4f0          	and	a,#240
7897  15f7 a130          	cp	a,#48
7898  15f9 265c          	jrne	L3243
7899                     ; 2130 		if((mess[9]&0x0f)==0x02)
7901  15fb b6d3          	ld	a,_mess+9
7902  15fd a40f          	and	a,#15
7903  15ff a102          	cp	a,#2
7904  1601 260b          	jrne	L5243
7905                     ; 2132 			ee_K[3][1]++;
7907  1603 ce0028        	ldw	x,_ee_K+14
7908  1606 1c0001        	addw	x,#1
7909  1609 cf0028        	ldw	_ee_K+14,x
7911  160c 2037          	jra	L7243
7912  160e               L5243:
7913                     ; 2134 		else if((mess[9]&0x0f)==0x03)
7915  160e b6d3          	ld	a,_mess+9
7916  1610 a40f          	and	a,#15
7917  1612 a103          	cp	a,#3
7918  1614 260b          	jrne	L1343
7919                     ; 2136 			ee_K[3][1]+=10;
7921  1616 ce0028        	ldw	x,_ee_K+14
7922  1619 1c000a        	addw	x,#10
7923  161c cf0028        	ldw	_ee_K+14,x
7925  161f 2024          	jra	L7243
7926  1621               L1343:
7927                     ; 2138 		else if((mess[9]&0x0f)==0x04)
7929  1621 b6d3          	ld	a,_mess+9
7930  1623 a40f          	and	a,#15
7931  1625 a104          	cp	a,#4
7932  1627 260b          	jrne	L5343
7933                     ; 2140 			ee_K[3][1]--;
7935  1629 ce0028        	ldw	x,_ee_K+14
7936  162c 1d0001        	subw	x,#1
7937  162f cf0028        	ldw	_ee_K+14,x
7939  1632 2011          	jra	L7243
7940  1634               L5343:
7941                     ; 2142 		else if((mess[9]&0x0f)==0x05)
7943  1634 b6d3          	ld	a,_mess+9
7944  1636 a40f          	and	a,#15
7945  1638 a105          	cp	a,#5
7946  163a 2609          	jrne	L7243
7947                     ; 2144 			ee_K[3][1]-=10;
7949  163c ce0028        	ldw	x,_ee_K+14
7950  163f 1d000a        	subw	x,#10
7951  1642 cf0028        	ldw	_ee_K+14,x
7952  1645               L7243:
7953                     ; 2146 		granee(&ee_K[3][1],300,517);									
7955  1645 ae0205        	ldw	x,#517
7956  1648 89            	pushw	x
7957  1649 ae012c        	ldw	x,#300
7958  164c 89            	pushw	x
7959  164d ae0028        	ldw	x,#_ee_K+14
7960  1650 cd00f6        	call	_granee
7962  1653 5b04          	addw	sp,#4
7964  1655 2062          	jra	L5433
7965  1657               L3243:
7966                     ; 2149 	else if((mess[9]&0xf0)==0x50)
7968  1657 b6d3          	ld	a,_mess+9
7969  1659 a4f0          	and	a,#240
7970  165b a150          	cp	a,#80
7971  165d 265a          	jrne	L5433
7972                     ; 2151 		if((mess[9]&0x0f)==0x02)
7974  165f b6d3          	ld	a,_mess+9
7975  1661 a40f          	and	a,#15
7976  1663 a102          	cp	a,#2
7977  1665 260b          	jrne	L7443
7978                     ; 2153 			ee_K[4][1]++;
7980  1667 ce002c        	ldw	x,_ee_K+18
7981  166a 1c0001        	addw	x,#1
7982  166d cf002c        	ldw	_ee_K+18,x
7984  1670 2037          	jra	L1543
7985  1672               L7443:
7986                     ; 2155 		else if((mess[9]&0x0f)==0x03)
7988  1672 b6d3          	ld	a,_mess+9
7989  1674 a40f          	and	a,#15
7990  1676 a103          	cp	a,#3
7991  1678 260b          	jrne	L3543
7992                     ; 2157 			ee_K[4][1]+=10;
7994  167a ce002c        	ldw	x,_ee_K+18
7995  167d 1c000a        	addw	x,#10
7996  1680 cf002c        	ldw	_ee_K+18,x
7998  1683 2024          	jra	L1543
7999  1685               L3543:
8000                     ; 2159 		else if((mess[9]&0x0f)==0x04)
8002  1685 b6d3          	ld	a,_mess+9
8003  1687 a40f          	and	a,#15
8004  1689 a104          	cp	a,#4
8005  168b 260b          	jrne	L7543
8006                     ; 2161 			ee_K[4][1]--;
8008  168d ce002c        	ldw	x,_ee_K+18
8009  1690 1d0001        	subw	x,#1
8010  1693 cf002c        	ldw	_ee_K+18,x
8012  1696 2011          	jra	L1543
8013  1698               L7543:
8014                     ; 2163 		else if((mess[9]&0x0f)==0x05)
8016  1698 b6d3          	ld	a,_mess+9
8017  169a a40f          	and	a,#15
8018  169c a105          	cp	a,#5
8019  169e 2609          	jrne	L1543
8020                     ; 2165 			ee_K[4][1]-=10;
8022  16a0 ce002c        	ldw	x,_ee_K+18
8023  16a3 1d000a        	subw	x,#10
8024  16a6 cf002c        	ldw	_ee_K+18,x
8025  16a9               L1543:
8026                     ; 2167 		granee(&ee_K[4][1],10,30000);									
8028  16a9 ae7530        	ldw	x,#30000
8029  16ac 89            	pushw	x
8030  16ad ae000a        	ldw	x,#10
8031  16b0 89            	pushw	x
8032  16b1 ae002c        	ldw	x,#_ee_K+18
8033  16b4 cd00f6        	call	_granee
8035  16b7 5b04          	addw	sp,#4
8036  16b9               L5433:
8037                     ; 2170 	link_cnt=0;
8039  16b9 5f            	clrw	x
8040  16ba bf6e          	ldw	_link_cnt,x
8041                     ; 2171      link=ON;
8043  16bc 35550070      	mov	_link,#85
8044                     ; 2172      if(res_fl_)
8046  16c0 725d000a      	tnz	_res_fl_
8047  16c4 2603          	jrne	L402
8048  16c6 cc19b8        	jp	L3223
8049  16c9               L402:
8050                     ; 2174       	res_fl_=0;
8052  16c9 4f            	clr	a
8053  16ca ae000a        	ldw	x,#_res_fl_
8054  16cd cd0000        	call	c_eewrc
8056  16d0 acb819b8      	jpf	L3223
8057  16d4               L7133:
8058                     ; 2180 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8060  16d4 b6d0          	ld	a,_mess+6
8061  16d6 a1ff          	cp	a,#255
8062  16d8 2703          	jreq	L602
8063  16da cc1762        	jp	L1743
8064  16dd               L602:
8066  16dd b6d1          	ld	a,_mess+7
8067  16df a1ff          	cp	a,#255
8068  16e1 2702          	jreq	L012
8069  16e3 207d          	jp	L1743
8070  16e5               L012:
8072  16e5 b6d2          	ld	a,_mess+8
8073  16e7 a162          	cp	a,#98
8074  16e9 2677          	jrne	L1743
8075                     ; 2183 	tempSS=mess[9]+(mess[10]*256);
8077  16eb b6d4          	ld	a,_mess+10
8078  16ed 5f            	clrw	x
8079  16ee 97            	ld	xl,a
8080  16ef 4f            	clr	a
8081  16f0 02            	rlwa	x,a
8082  16f1 01            	rrwa	x,a
8083  16f2 bbd3          	add	a,_mess+9
8084  16f4 2401          	jrnc	L651
8085  16f6 5c            	incw	x
8086  16f7               L651:
8087  16f7 02            	rlwa	x,a
8088  16f8 1f03          	ldw	(OFST-4,sp),x
8089  16fa 01            	rrwa	x,a
8090                     ; 2184 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8092  16fb ce0014        	ldw	x,_ee_Umax
8093  16fe 1303          	cpw	x,(OFST-4,sp)
8094  1700 270a          	jreq	L3743
8097  1702 1e03          	ldw	x,(OFST-4,sp)
8098  1704 89            	pushw	x
8099  1705 ae0014        	ldw	x,#_ee_Umax
8100  1708 cd0000        	call	c_eewrw
8102  170b 85            	popw	x
8103  170c               L3743:
8104                     ; 2185 	tempSS=mess[11]+(mess[12]*256);
8106  170c b6d6          	ld	a,_mess+12
8107  170e 5f            	clrw	x
8108  170f 97            	ld	xl,a
8109  1710 4f            	clr	a
8110  1711 02            	rlwa	x,a
8111  1712 01            	rrwa	x,a
8112  1713 bbd5          	add	a,_mess+11
8113  1715 2401          	jrnc	L061
8114  1717 5c            	incw	x
8115  1718               L061:
8116  1718 02            	rlwa	x,a
8117  1719 1f03          	ldw	(OFST-4,sp),x
8118  171b 01            	rrwa	x,a
8119                     ; 2186 	if(ee_dU!=tempSS) ee_dU=tempSS;
8121  171c ce0012        	ldw	x,_ee_dU
8122  171f 1303          	cpw	x,(OFST-4,sp)
8123  1721 270a          	jreq	L5743
8126  1723 1e03          	ldw	x,(OFST-4,sp)
8127  1725 89            	pushw	x
8128  1726 ae0012        	ldw	x,#_ee_dU
8129  1729 cd0000        	call	c_eewrw
8131  172c 85            	popw	x
8132  172d               L5743:
8133                     ; 2187 	if((mess[13]&0x0f)==0x5)
8135  172d b6d7          	ld	a,_mess+13
8136  172f a40f          	and	a,#15
8137  1731 a105          	cp	a,#5
8138  1733 2615          	jrne	L7743
8139                     ; 2189 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8141  1735 ce0006        	ldw	x,_ee_AVT_MODE
8142  1738 a30055        	cpw	x,#85
8143  173b 271e          	jreq	L3053
8146  173d ae0055        	ldw	x,#85
8147  1740 89            	pushw	x
8148  1741 ae0006        	ldw	x,#_ee_AVT_MODE
8149  1744 cd0000        	call	c_eewrw
8151  1747 85            	popw	x
8152  1748 2011          	jra	L3053
8153  174a               L7743:
8154                     ; 2191 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;
8156  174a ce0006        	ldw	x,_ee_AVT_MODE
8157  174d a30055        	cpw	x,#85
8158  1750 2609          	jrne	L3053
8161  1752 5f            	clrw	x
8162  1753 89            	pushw	x
8163  1754 ae0006        	ldw	x,#_ee_AVT_MODE
8164  1757 cd0000        	call	c_eewrw
8166  175a 85            	popw	x
8167  175b               L3053:
8168                     ; 2192 	FADE_MODE=mess[13];	
8170  175b 45d713        	mov	_FADE_MODE,_mess+13
8172  175e acb819b8      	jpf	L3223
8173  1762               L1743:
8174                     ; 2195 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8176  1762 b6d0          	ld	a,_mess+6
8177  1764 a1ff          	cp	a,#255
8178  1766 2703          	jreq	L212
8179  1768 cc181e        	jp	L1153
8180  176b               L212:
8182  176b b6d1          	ld	a,_mess+7
8183  176d a1ff          	cp	a,#255
8184  176f 2703          	jreq	L412
8185  1771 cc181e        	jp	L1153
8186  1774               L412:
8188  1774 b6d2          	ld	a,_mess+8
8189  1776 a126          	cp	a,#38
8190  1778 2709          	jreq	L3153
8192  177a b6d2          	ld	a,_mess+8
8193  177c a129          	cp	a,#41
8194  177e 2703          	jreq	L612
8195  1780 cc181e        	jp	L1153
8196  1783               L612:
8197  1783               L3153:
8198                     ; 2198 	tempSS=mess[9]+(mess[10]*256);
8200  1783 b6d4          	ld	a,_mess+10
8201  1785 5f            	clrw	x
8202  1786 97            	ld	xl,a
8203  1787 4f            	clr	a
8204  1788 02            	rlwa	x,a
8205  1789 01            	rrwa	x,a
8206  178a bbd3          	add	a,_mess+9
8207  178c 2401          	jrnc	L261
8208  178e 5c            	incw	x
8209  178f               L261:
8210  178f 02            	rlwa	x,a
8211  1790 1f03          	ldw	(OFST-4,sp),x
8212  1792 01            	rrwa	x,a
8213                     ; 2200 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
8215  1793 ce000c        	ldw	x,_ee_UAVT
8216  1796 1303          	cpw	x,(OFST-4,sp)
8217  1798 270a          	jreq	L5153
8220  179a 1e03          	ldw	x,(OFST-4,sp)
8221  179c 89            	pushw	x
8222  179d ae000c        	ldw	x,#_ee_UAVT
8223  17a0 cd0000        	call	c_eewrw
8225  17a3 85            	popw	x
8226  17a4               L5153:
8227                     ; 2201 	tempSS=(signed short)mess[11];
8229  17a4 b6d5          	ld	a,_mess+11
8230  17a6 5f            	clrw	x
8231  17a7 97            	ld	xl,a
8232  17a8 1f03          	ldw	(OFST-4,sp),x
8233                     ; 2202 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8235  17aa ce0010        	ldw	x,_ee_tmax
8236  17ad 1303          	cpw	x,(OFST-4,sp)
8237  17af 270a          	jreq	L7153
8240  17b1 1e03          	ldw	x,(OFST-4,sp)
8241  17b3 89            	pushw	x
8242  17b4 ae0010        	ldw	x,#_ee_tmax
8243  17b7 cd0000        	call	c_eewrw
8245  17ba 85            	popw	x
8246  17bb               L7153:
8247                     ; 2203 	tempSS=(signed short)mess[12];
8249  17bb b6d6          	ld	a,_mess+12
8250  17bd 5f            	clrw	x
8251  17be 97            	ld	xl,a
8252  17bf 1f03          	ldw	(OFST-4,sp),x
8253                     ; 2204 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8255  17c1 ce000e        	ldw	x,_ee_tsign
8256  17c4 1303          	cpw	x,(OFST-4,sp)
8257  17c6 270a          	jreq	L1253
8260  17c8 1e03          	ldw	x,(OFST-4,sp)
8261  17ca 89            	pushw	x
8262  17cb ae000e        	ldw	x,#_ee_tsign
8263  17ce cd0000        	call	c_eewrw
8265  17d1 85            	popw	x
8266  17d2               L1253:
8267                     ; 2207 	if(mess[8]==MEM_KF1)
8269  17d2 b6d2          	ld	a,_mess+8
8270  17d4 a126          	cp	a,#38
8271  17d6 260e          	jrne	L3253
8272                     ; 2209 		if(ee_DEVICE!=0)ee_DEVICE=0;
8274  17d8 ce0004        	ldw	x,_ee_DEVICE
8275  17db 2709          	jreq	L3253
8278  17dd 5f            	clrw	x
8279  17de 89            	pushw	x
8280  17df ae0004        	ldw	x,#_ee_DEVICE
8281  17e2 cd0000        	call	c_eewrw
8283  17e5 85            	popw	x
8284  17e6               L3253:
8285                     ; 2212 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8287  17e6 b6d2          	ld	a,_mess+8
8288  17e8 a129          	cp	a,#41
8289  17ea 2703          	jreq	L022
8290  17ec cc19b8        	jp	L3223
8291  17ef               L022:
8292                     ; 2214 		if(ee_DEVICE!=1)ee_DEVICE=1;
8294  17ef ce0004        	ldw	x,_ee_DEVICE
8295  17f2 a30001        	cpw	x,#1
8296  17f5 270b          	jreq	L1353
8299  17f7 ae0001        	ldw	x,#1
8300  17fa 89            	pushw	x
8301  17fb ae0004        	ldw	x,#_ee_DEVICE
8302  17fe cd0000        	call	c_eewrw
8304  1801 85            	popw	x
8305  1802               L1353:
8306                     ; 2215 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8308  1802 b6d7          	ld	a,_mess+13
8309  1804 5f            	clrw	x
8310  1805 97            	ld	xl,a
8311  1806 c30002        	cpw	x,_ee_IMAXVENT
8312  1809 2603          	jrne	L222
8313  180b cc19b8        	jp	L3223
8314  180e               L222:
8317  180e b6d7          	ld	a,_mess+13
8318  1810 5f            	clrw	x
8319  1811 97            	ld	xl,a
8320  1812 89            	pushw	x
8321  1813 ae0002        	ldw	x,#_ee_IMAXVENT
8322  1816 cd0000        	call	c_eewrw
8324  1819 85            	popw	x
8325  181a acb819b8      	jpf	L3223
8326  181e               L1153:
8327                     ; 2220 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8329  181e b6d0          	ld	a,_mess+6
8330  1820 c10101        	cp	a,_adress
8331  1823 262d          	jrne	L7353
8333  1825 b6d1          	ld	a,_mess+7
8334  1827 c10101        	cp	a,_adress
8335  182a 2626          	jrne	L7353
8337  182c b6d2          	ld	a,_mess+8
8338  182e a116          	cp	a,#22
8339  1830 2620          	jrne	L7353
8341  1832 b6d3          	ld	a,_mess+9
8342  1834 a163          	cp	a,#99
8343  1836 261a          	jrne	L7353
8344                     ; 2222 	flags&=0b11100001;
8346  1838 b605          	ld	a,_flags
8347  183a a4e1          	and	a,#225
8348  183c b705          	ld	_flags,a
8349                     ; 2223 	tsign_cnt=0;
8351  183e 5f            	clrw	x
8352  183f bf5c          	ldw	_tsign_cnt,x
8353                     ; 2224 	tmax_cnt=0;
8355  1841 5f            	clrw	x
8356  1842 bf5a          	ldw	_tmax_cnt,x
8357                     ; 2225 	umax_cnt=0;
8359  1844 5f            	clrw	x
8360  1845 bf73          	ldw	_umax_cnt,x
8361                     ; 2226 	umin_cnt=0;
8363  1847 5f            	clrw	x
8364  1848 bf71          	ldw	_umin_cnt,x
8365                     ; 2227 	led_drv_cnt=30;
8367  184a 351e0016      	mov	_led_drv_cnt,#30
8369  184e acb819b8      	jpf	L3223
8370  1852               L7353:
8371                     ; 2230 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8373  1852 b6d0          	ld	a,_mess+6
8374  1854 c10101        	cp	a,_adress
8375  1857 2620          	jrne	L3453
8377  1859 b6d1          	ld	a,_mess+7
8378  185b c10101        	cp	a,_adress
8379  185e 2619          	jrne	L3453
8381  1860 b6d2          	ld	a,_mess+8
8382  1862 a116          	cp	a,#22
8383  1864 2613          	jrne	L3453
8385  1866 b6d3          	ld	a,_mess+9
8386  1868 a164          	cp	a,#100
8387  186a 260d          	jrne	L3453
8388                     ; 2232 	vent_resurs=0;
8390  186c 5f            	clrw	x
8391  186d 89            	pushw	x
8392  186e ae0000        	ldw	x,#_vent_resurs
8393  1871 cd0000        	call	c_eewrw
8395  1874 85            	popw	x
8397  1875 acb819b8      	jpf	L3223
8398  1879               L3453:
8399                     ; 2236 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8401  1879 b6d0          	ld	a,_mess+6
8402  187b a1ff          	cp	a,#255
8403  187d 265f          	jrne	L7453
8405  187f b6d1          	ld	a,_mess+7
8406  1881 a1ff          	cp	a,#255
8407  1883 2659          	jrne	L7453
8409  1885 b6d2          	ld	a,_mess+8
8410  1887 a116          	cp	a,#22
8411  1889 2653          	jrne	L7453
8413  188b b6d3          	ld	a,_mess+9
8414  188d a116          	cp	a,#22
8415  188f 264d          	jrne	L7453
8416                     ; 2238 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8418  1891 b6d4          	ld	a,_mess+10
8419  1893 a155          	cp	a,#85
8420  1895 260f          	jrne	L1553
8422  1897 b6d5          	ld	a,_mess+11
8423  1899 a155          	cp	a,#85
8424  189b 2609          	jrne	L1553
8427  189d be6b          	ldw	x,__x_
8428  189f 1c0001        	addw	x,#1
8429  18a2 bf6b          	ldw	__x_,x
8431  18a4 2024          	jra	L3553
8432  18a6               L1553:
8433                     ; 2239 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8435  18a6 b6d4          	ld	a,_mess+10
8436  18a8 a166          	cp	a,#102
8437  18aa 260f          	jrne	L5553
8439  18ac b6d5          	ld	a,_mess+11
8440  18ae a166          	cp	a,#102
8441  18b0 2609          	jrne	L5553
8444  18b2 be6b          	ldw	x,__x_
8445  18b4 1d0001        	subw	x,#1
8446  18b7 bf6b          	ldw	__x_,x
8448  18b9 200f          	jra	L3553
8449  18bb               L5553:
8450                     ; 2240 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8452  18bb b6d4          	ld	a,_mess+10
8453  18bd a177          	cp	a,#119
8454  18bf 2609          	jrne	L3553
8456  18c1 b6d5          	ld	a,_mess+11
8457  18c3 a177          	cp	a,#119
8458  18c5 2603          	jrne	L3553
8461  18c7 5f            	clrw	x
8462  18c8 bf6b          	ldw	__x_,x
8463  18ca               L3553:
8464                     ; 2241      gran(&_x_,-XMAX,XMAX);
8466  18ca ae0019        	ldw	x,#25
8467  18cd 89            	pushw	x
8468  18ce aeffe7        	ldw	x,#65511
8469  18d1 89            	pushw	x
8470  18d2 ae006b        	ldw	x,#__x_
8471  18d5 cd00d5        	call	_gran
8473  18d8 5b04          	addw	sp,#4
8475  18da acb819b8      	jpf	L3223
8476  18de               L7453:
8477                     ; 2243 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8479  18de b6d0          	ld	a,_mess+6
8480  18e0 c10101        	cp	a,_adress
8481  18e3 2635          	jrne	L5653
8483  18e5 b6d1          	ld	a,_mess+7
8484  18e7 c10101        	cp	a,_adress
8485  18ea 262e          	jrne	L5653
8487  18ec b6d2          	ld	a,_mess+8
8488  18ee a116          	cp	a,#22
8489  18f0 2628          	jrne	L5653
8491  18f2 b6d3          	ld	a,_mess+9
8492  18f4 b1d4          	cp	a,_mess+10
8493  18f6 2622          	jrne	L5653
8495  18f8 b6d3          	ld	a,_mess+9
8496  18fa a1ee          	cp	a,#238
8497  18fc 261c          	jrne	L5653
8498                     ; 2245 	rotor_int++;
8500  18fe be17          	ldw	x,_rotor_int
8501  1900 1c0001        	addw	x,#1
8502  1903 bf17          	ldw	_rotor_int,x
8503                     ; 2246      tempI=pwm_u;
8505                     ; 2248 	UU_AVT=Un;
8507  1905 ce0018        	ldw	x,_Un
8508  1908 89            	pushw	x
8509  1909 ae0008        	ldw	x,#_UU_AVT
8510  190c cd0000        	call	c_eewrw
8512  190f 85            	popw	x
8513                     ; 2249 	delay_ms(100);
8515  1910 ae0064        	ldw	x,#100
8516  1913 cd0121        	call	_delay_ms
8519  1916 acb819b8      	jpf	L3223
8520  191a               L5653:
8521                     ; 2255 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8523  191a b6d1          	ld	a,_mess+7
8524  191c a1da          	cp	a,#218
8525  191e 2653          	jrne	L1753
8527  1920 b6d0          	ld	a,_mess+6
8528  1922 c10101        	cp	a,_adress
8529  1925 274c          	jreq	L1753
8531  1927 b6d0          	ld	a,_mess+6
8532  1929 a106          	cp	a,#6
8533  192b 2446          	jruge	L1753
8534                     ; 2257 	i_main_bps_cnt[mess[6]]=0;
8536  192d b6d0          	ld	a,_mess+6
8537  192f 5f            	clrw	x
8538  1930 97            	ld	xl,a
8539  1931 6f14          	clr	(_i_main_bps_cnt,x)
8540                     ; 2258 	i_main_flag[mess[6]]=1;
8542  1933 b6d0          	ld	a,_mess+6
8543  1935 5f            	clrw	x
8544  1936 97            	ld	xl,a
8545  1937 a601          	ld	a,#1
8546  1939 e71f          	ld	(_i_main_flag,x),a
8547                     ; 2259 	if(bMAIN)
8549                     	btst	_bMAIN
8550  1940 2476          	jruge	L3223
8551                     ; 2261 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8553  1942 b6d3          	ld	a,_mess+9
8554  1944 5f            	clrw	x
8555  1945 97            	ld	xl,a
8556  1946 4f            	clr	a
8557  1947 02            	rlwa	x,a
8558  1948 1f01          	ldw	(OFST-6,sp),x
8559  194a b6d2          	ld	a,_mess+8
8560  194c 5f            	clrw	x
8561  194d 97            	ld	xl,a
8562  194e 72fb01        	addw	x,(OFST-6,sp)
8563  1951 b6d0          	ld	a,_mess+6
8564  1953 905f          	clrw	y
8565  1955 9097          	ld	yl,a
8566  1957 9058          	sllw	y
8567  1959 90ef25        	ldw	(_i_main,y),x
8568                     ; 2262 		i_main[adress]=I;
8570  195c c60101        	ld	a,_adress
8571  195f 5f            	clrw	x
8572  1960 97            	ld	xl,a
8573  1961 58            	sllw	x
8574  1962 90ce001a      	ldw	y,_I
8575  1966 ef25          	ldw	(_i_main,x),y
8576                     ; 2263      	i_main_flag[adress]=1;
8578  1968 c60101        	ld	a,_adress
8579  196b 5f            	clrw	x
8580  196c 97            	ld	xl,a
8581  196d a601          	ld	a,#1
8582  196f e71f          	ld	(_i_main_flag,x),a
8583  1971 2045          	jra	L3223
8584  1973               L1753:
8585                     ; 2267 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8587  1973 b6d1          	ld	a,_mess+7
8588  1975 a1db          	cp	a,#219
8589  1977 263f          	jrne	L3223
8591  1979 b6d0          	ld	a,_mess+6
8592  197b c10101        	cp	a,_adress
8593  197e 2738          	jreq	L3223
8595  1980 b6d0          	ld	a,_mess+6
8596  1982 a106          	cp	a,#6
8597  1984 2432          	jruge	L3223
8598                     ; 2269 	i_main_bps_cnt[mess[6]]=0;
8600  1986 b6d0          	ld	a,_mess+6
8601  1988 5f            	clrw	x
8602  1989 97            	ld	xl,a
8603  198a 6f14          	clr	(_i_main_bps_cnt,x)
8604                     ; 2270 	i_main_flag[mess[6]]=1;		
8606  198c b6d0          	ld	a,_mess+6
8607  198e 5f            	clrw	x
8608  198f 97            	ld	xl,a
8609  1990 a601          	ld	a,#1
8610  1992 e71f          	ld	(_i_main_flag,x),a
8611                     ; 2271 	if(bMAIN)
8613                     	btst	_bMAIN
8614  1999 241d          	jruge	L3223
8615                     ; 2273 		if(mess[9]==0)i_main_flag[i]=1;
8617  199b 3dd3          	tnz	_mess+9
8618  199d 260a          	jrne	L3063
8621  199f 7b07          	ld	a,(OFST+0,sp)
8622  19a1 5f            	clrw	x
8623  19a2 97            	ld	xl,a
8624  19a3 a601          	ld	a,#1
8625  19a5 e71f          	ld	(_i_main_flag,x),a
8627  19a7 2006          	jra	L5063
8628  19a9               L3063:
8629                     ; 2274 		else i_main_flag[i]=0;
8631  19a9 7b07          	ld	a,(OFST+0,sp)
8632  19ab 5f            	clrw	x
8633  19ac 97            	ld	xl,a
8634  19ad 6f1f          	clr	(_i_main_flag,x)
8635  19af               L5063:
8636                     ; 2275 		i_main_flag[adress]=1;
8638  19af c60101        	ld	a,_adress
8639  19b2 5f            	clrw	x
8640  19b3 97            	ld	xl,a
8641  19b4 a601          	ld	a,#1
8642  19b6 e71f          	ld	(_i_main_flag,x),a
8643  19b8               L3223:
8644                     ; 2281 can_in_an_end:
8644                     ; 2282 bCAN_RX=0;
8646  19b8 3f04          	clr	_bCAN_RX
8647                     ; 2283 }   
8650  19ba 5b07          	addw	sp,#7
8651  19bc 81            	ret
8674                     ; 2286 void t4_init(void){
8675                     	switch	.text
8676  19bd               _t4_init:
8680                     ; 2287 	TIM4->PSCR = 6;
8682  19bd 35065345      	mov	21317,#6
8683                     ; 2288 	TIM4->ARR= 31;
8685  19c1 351f5346      	mov	21318,#31
8686                     ; 2289 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8688  19c5 72105341      	bset	21313,#0
8689                     ; 2291 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8691  19c9 35855340      	mov	21312,#133
8692                     ; 2293 }
8695  19cd 81            	ret
8718                     ; 2296 void t1_init(void)
8718                     ; 2297 {
8719                     	switch	.text
8720  19ce               _t1_init:
8724                     ; 2298 TIM1->ARRH= 0x07;
8726  19ce 35075262      	mov	21090,#7
8727                     ; 2299 TIM1->ARRL= 0xff;
8729  19d2 35ff5263      	mov	21091,#255
8730                     ; 2300 TIM1->CCR1H= 0x00;	
8732  19d6 725f5265      	clr	21093
8733                     ; 2301 TIM1->CCR1L= 0xff;
8735  19da 35ff5266      	mov	21094,#255
8736                     ; 2302 TIM1->CCR2H= 0x00;	
8738  19de 725f5267      	clr	21095
8739                     ; 2303 TIM1->CCR2L= 0x00;
8741  19e2 725f5268      	clr	21096
8742                     ; 2304 TIM1->CCR3H= 0x00;	
8744  19e6 725f5269      	clr	21097
8745                     ; 2305 TIM1->CCR3L= 0x64;
8747  19ea 3564526a      	mov	21098,#100
8748                     ; 2307 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8750  19ee 35685258      	mov	21080,#104
8751                     ; 2308 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8753  19f2 35685259      	mov	21081,#104
8754                     ; 2309 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8756  19f6 3568525a      	mov	21082,#104
8757                     ; 2310 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8759  19fa 3511525c      	mov	21084,#17
8760                     ; 2311 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8762  19fe 3501525d      	mov	21085,#1
8763                     ; 2312 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8765  1a02 35815250      	mov	21072,#129
8766                     ; 2313 TIM1->BKR|= TIM1_BKR_AOE;
8768  1a06 721c526d      	bset	21101,#6
8769                     ; 2314 }
8772  1a0a 81            	ret
8797                     ; 2318 void adc2_init(void)
8797                     ; 2319 {
8798                     	switch	.text
8799  1a0b               _adc2_init:
8803                     ; 2320 adc_plazma[0]++;
8805  1a0b bebc          	ldw	x,_adc_plazma
8806  1a0d 1c0001        	addw	x,#1
8807  1a10 bfbc          	ldw	_adc_plazma,x
8808                     ; 2344 GPIOB->DDR&=~(1<<4);
8810  1a12 72195007      	bres	20487,#4
8811                     ; 2345 GPIOB->CR1&=~(1<<4);
8813  1a16 72195008      	bres	20488,#4
8814                     ; 2346 GPIOB->CR2&=~(1<<4);
8816  1a1a 72195009      	bres	20489,#4
8817                     ; 2348 GPIOB->DDR&=~(1<<5);
8819  1a1e 721b5007      	bres	20487,#5
8820                     ; 2349 GPIOB->CR1&=~(1<<5);
8822  1a22 721b5008      	bres	20488,#5
8823                     ; 2350 GPIOB->CR2&=~(1<<5);
8825  1a26 721b5009      	bres	20489,#5
8826                     ; 2352 GPIOB->DDR&=~(1<<6);
8828  1a2a 721d5007      	bres	20487,#6
8829                     ; 2353 GPIOB->CR1&=~(1<<6);
8831  1a2e 721d5008      	bres	20488,#6
8832                     ; 2354 GPIOB->CR2&=~(1<<6);
8834  1a32 721d5009      	bres	20489,#6
8835                     ; 2356 GPIOB->DDR&=~(1<<7);
8837  1a36 721f5007      	bres	20487,#7
8838                     ; 2357 GPIOB->CR1&=~(1<<7);
8840  1a3a 721f5008      	bres	20488,#7
8841                     ; 2358 GPIOB->CR2&=~(1<<7);
8843  1a3e 721f5009      	bres	20489,#7
8844                     ; 2360 GPIOB->DDR&=~(1<<2);
8846  1a42 72155007      	bres	20487,#2
8847                     ; 2361 GPIOB->CR1&=~(1<<2);
8849  1a46 72155008      	bres	20488,#2
8850                     ; 2362 GPIOB->CR2&=~(1<<2);
8852  1a4a 72155009      	bres	20489,#2
8853                     ; 2371 ADC2->TDRL=0xff;
8855  1a4e 35ff5407      	mov	21511,#255
8856                     ; 2373 ADC2->CR2=0x08;
8858  1a52 35085402      	mov	21506,#8
8859                     ; 2374 ADC2->CR1=0x60;
8861  1a56 35605401      	mov	21505,#96
8862                     ; 2377 	if(adc_ch==5)ADC2->CSR=0x22;
8864  1a5a b6c9          	ld	a,_adc_ch
8865  1a5c a105          	cp	a,#5
8866  1a5e 2606          	jrne	L7363
8869  1a60 35225400      	mov	21504,#34
8871  1a64 2007          	jra	L1463
8872  1a66               L7363:
8873                     ; 2378 	else ADC2->CSR=0x20+adc_ch+3;
8875  1a66 b6c9          	ld	a,_adc_ch
8876  1a68 ab23          	add	a,#35
8877  1a6a c75400        	ld	21504,a
8878  1a6d               L1463:
8879                     ; 2380 	ADC2->CR1|=1;
8881  1a6d 72105401      	bset	21505,#0
8882                     ; 2381 	ADC2->CR1|=1;
8884  1a71 72105401      	bset	21505,#0
8885                     ; 2384 adc_plazma[1]=adc_ch;
8887  1a75 b6c9          	ld	a,_adc_ch
8888  1a77 5f            	clrw	x
8889  1a78 97            	ld	xl,a
8890  1a79 bfbe          	ldw	_adc_plazma+2,x
8891                     ; 2385 }
8894  1a7b 81            	ret
8932                     ; 2393 @far @interrupt void TIM4_UPD_Interrupt (void) 
8932                     ; 2394 {
8934                     	switch	.text
8935  1a7c               f_TIM4_UPD_Interrupt:
8939                     ; 2395 TIM4->SR1&=~TIM4_SR1_UIF;
8941  1a7c 72115342      	bres	21314,#0
8942                     ; 2397 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8944  1a80 3c12          	inc	_pwm_vent_cnt
8945  1a82 b612          	ld	a,_pwm_vent_cnt
8946  1a84 a10a          	cp	a,#10
8947  1a86 2502          	jrult	L3563
8950  1a88 3f12          	clr	_pwm_vent_cnt
8951  1a8a               L3563:
8952                     ; 2398 GPIOB->ODR|=(1<<3);
8954  1a8a 72165005      	bset	20485,#3
8955                     ; 2399 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8957  1a8e b612          	ld	a,_pwm_vent_cnt
8958  1a90 a105          	cp	a,#5
8959  1a92 2504          	jrult	L5563
8962  1a94 72175005      	bres	20485,#3
8963  1a98               L5563:
8964                     ; 2403 if(++t0_cnt00>=10)
8966  1a98 9c            	rvf
8967  1a99 ce0000        	ldw	x,_t0_cnt00
8968  1a9c 1c0001        	addw	x,#1
8969  1a9f cf0000        	ldw	_t0_cnt00,x
8970  1aa2 a3000a        	cpw	x,#10
8971  1aa5 2f08          	jrslt	L7563
8972                     ; 2405 	t0_cnt00=0;
8974  1aa7 5f            	clrw	x
8975  1aa8 cf0000        	ldw	_t0_cnt00,x
8976                     ; 2406 	b1000Hz=1;
8978  1aab 72100005      	bset	_b1000Hz
8979  1aaf               L7563:
8980                     ; 2409 if(++t0_cnt0>=100)
8982  1aaf 9c            	rvf
8983  1ab0 ce0002        	ldw	x,_t0_cnt0
8984  1ab3 1c0001        	addw	x,#1
8985  1ab6 cf0002        	ldw	_t0_cnt0,x
8986  1ab9 a30064        	cpw	x,#100
8987  1abc 2f67          	jrslt	L1663
8988                     ; 2411 	t0_cnt0=0;
8990  1abe 5f            	clrw	x
8991  1abf cf0002        	ldw	_t0_cnt0,x
8992                     ; 2412 	b100Hz=1;
8994  1ac2 7210000a      	bset	_b100Hz
8995                     ; 2414 	if(++t0_cnt5>=5)
8997  1ac6 725c0008      	inc	_t0_cnt5
8998  1aca c60008        	ld	a,_t0_cnt5
8999  1acd a105          	cp	a,#5
9000  1acf 2508          	jrult	L3663
9001                     ; 2416 		t0_cnt5=0;
9003  1ad1 725f0008      	clr	_t0_cnt5
9004                     ; 2417 		b20Hz=1;
9006  1ad5 72100004      	bset	_b20Hz
9007  1ad9               L3663:
9008                     ; 2420 	if(++t0_cnt1>=10)
9010  1ad9 725c0004      	inc	_t0_cnt1
9011  1add c60004        	ld	a,_t0_cnt1
9012  1ae0 a10a          	cp	a,#10
9013  1ae2 2508          	jrult	L5663
9014                     ; 2422 		t0_cnt1=0;
9016  1ae4 725f0004      	clr	_t0_cnt1
9017                     ; 2423 		b10Hz=1;
9019  1ae8 72100009      	bset	_b10Hz
9020  1aec               L5663:
9021                     ; 2426 	if(++t0_cnt2>=20)
9023  1aec 725c0005      	inc	_t0_cnt2
9024  1af0 c60005        	ld	a,_t0_cnt2
9025  1af3 a114          	cp	a,#20
9026  1af5 2508          	jrult	L7663
9027                     ; 2428 		t0_cnt2=0;
9029  1af7 725f0005      	clr	_t0_cnt2
9030                     ; 2429 		b5Hz=1;
9032  1afb 72100008      	bset	_b5Hz
9033  1aff               L7663:
9034                     ; 2433 	if(++t0_cnt4>=50)
9036  1aff 725c0007      	inc	_t0_cnt4
9037  1b03 c60007        	ld	a,_t0_cnt4
9038  1b06 a132          	cp	a,#50
9039  1b08 2508          	jrult	L1763
9040                     ; 2435 		t0_cnt4=0;
9042  1b0a 725f0007      	clr	_t0_cnt4
9043                     ; 2436 		b2Hz=1;
9045  1b0e 72100007      	bset	_b2Hz
9046  1b12               L1763:
9047                     ; 2439 	if(++t0_cnt3>=100)
9049  1b12 725c0006      	inc	_t0_cnt3
9050  1b16 c60006        	ld	a,_t0_cnt3
9051  1b19 a164          	cp	a,#100
9052  1b1b 2508          	jrult	L1663
9053                     ; 2441 		t0_cnt3=0;
9055  1b1d 725f0006      	clr	_t0_cnt3
9056                     ; 2442 		b1Hz=1;
9058  1b21 72100006      	bset	_b1Hz
9059  1b25               L1663:
9060                     ; 2448 }
9063  1b25 80            	iret
9088                     ; 2451 @far @interrupt void CAN_RX_Interrupt (void) 
9088                     ; 2452 {
9089                     	switch	.text
9090  1b26               f_CAN_RX_Interrupt:
9094                     ; 2454 CAN->PSR= 7;									// page 7 - read messsage
9096  1b26 35075427      	mov	21543,#7
9097                     ; 2456 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9099  1b2a ae000e        	ldw	x,#14
9100  1b2d               L632:
9101  1b2d d65427        	ld	a,(21543,x)
9102  1b30 e7c9          	ld	(_mess-1,x),a
9103  1b32 5a            	decw	x
9104  1b33 26f8          	jrne	L632
9105                     ; 2467 bCAN_RX=1;
9107  1b35 35010004      	mov	_bCAN_RX,#1
9108                     ; 2468 CAN->RFR|=(1<<5);
9110  1b39 721a5424      	bset	21540,#5
9111                     ; 2470 }
9114  1b3d 80            	iret
9137                     ; 2473 @far @interrupt void CAN_TX_Interrupt (void) 
9137                     ; 2474 {
9138                     	switch	.text
9139  1b3e               f_CAN_TX_Interrupt:
9143                     ; 2475 if((CAN->TSR)&(1<<0))
9145  1b3e c65422        	ld	a,21538
9146  1b41 a501          	bcp	a,#1
9147  1b43 2708          	jreq	L5173
9148                     ; 2477 	bTX_FREE=1;	
9150  1b45 35010003      	mov	_bTX_FREE,#1
9151                     ; 2479 	CAN->TSR|=(1<<0);
9153  1b49 72105422      	bset	21538,#0
9154  1b4d               L5173:
9155                     ; 2481 }
9158  1b4d 80            	iret
9238                     ; 2484 @far @interrupt void ADC2_EOC_Interrupt (void) {
9239                     	switch	.text
9240  1b4e               f_ADC2_EOC_Interrupt:
9242       0000000d      OFST:	set	13
9243  1b4e be00          	ldw	x,c_x
9244  1b50 89            	pushw	x
9245  1b51 be00          	ldw	x,c_y
9246  1b53 89            	pushw	x
9247  1b54 be02          	ldw	x,c_lreg+2
9248  1b56 89            	pushw	x
9249  1b57 be00          	ldw	x,c_lreg
9250  1b59 89            	pushw	x
9251  1b5a 520d          	subw	sp,#13
9254                     ; 2489 adc_plazma[2]++;
9256  1b5c bec0          	ldw	x,_adc_plazma+4
9257  1b5e 1c0001        	addw	x,#1
9258  1b61 bfc0          	ldw	_adc_plazma+4,x
9259                     ; 2496 ADC2->CSR&=~(1<<7);
9261  1b63 721f5400      	bres	21504,#7
9262                     ; 2498 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9264  1b67 c65405        	ld	a,21509
9265  1b6a b703          	ld	c_lreg+3,a
9266  1b6c 3f02          	clr	c_lreg+2
9267  1b6e 3f01          	clr	c_lreg+1
9268  1b70 3f00          	clr	c_lreg
9269  1b72 96            	ldw	x,sp
9270  1b73 1c0001        	addw	x,#OFST-12
9271  1b76 cd0000        	call	c_rtol
9273  1b79 c65404        	ld	a,21508
9274  1b7c 5f            	clrw	x
9275  1b7d 97            	ld	xl,a
9276  1b7e 90ae0100      	ldw	y,#256
9277  1b82 cd0000        	call	c_umul
9279  1b85 96            	ldw	x,sp
9280  1b86 1c0001        	addw	x,#OFST-12
9281  1b89 cd0000        	call	c_ladd
9283  1b8c 96            	ldw	x,sp
9284  1b8d 1c000a        	addw	x,#OFST-3
9285  1b90 cd0000        	call	c_rtol
9287                     ; 2503 if(adr_drv_stat==1)
9289  1b93 b602          	ld	a,_adr_drv_stat
9290  1b95 a101          	cp	a,#1
9291  1b97 260b          	jrne	L5573
9292                     ; 2505 	adr_drv_stat=2;
9294  1b99 35020002      	mov	_adr_drv_stat,#2
9295                     ; 2506 	adc_buff_[0]=temp_adc;
9297  1b9d 1e0c          	ldw	x,(OFST-1,sp)
9298  1b9f cf0109        	ldw	_adc_buff_,x
9300  1ba2 2020          	jra	L7573
9301  1ba4               L5573:
9302                     ; 2509 else if(adr_drv_stat==3)
9304  1ba4 b602          	ld	a,_adr_drv_stat
9305  1ba6 a103          	cp	a,#3
9306  1ba8 260b          	jrne	L1673
9307                     ; 2511 	adr_drv_stat=4;
9309  1baa 35040002      	mov	_adr_drv_stat,#4
9310                     ; 2512 	adc_buff_[1]=temp_adc;
9312  1bae 1e0c          	ldw	x,(OFST-1,sp)
9313  1bb0 cf010b        	ldw	_adc_buff_+2,x
9315  1bb3 200f          	jra	L7573
9316  1bb5               L1673:
9317                     ; 2515 else if(adr_drv_stat==5)
9319  1bb5 b602          	ld	a,_adr_drv_stat
9320  1bb7 a105          	cp	a,#5
9321  1bb9 2609          	jrne	L7573
9322                     ; 2517 	adr_drv_stat=6;
9324  1bbb 35060002      	mov	_adr_drv_stat,#6
9325                     ; 2518 	adc_buff_[9]=temp_adc;
9327  1bbf 1e0c          	ldw	x,(OFST-1,sp)
9328  1bc1 cf011b        	ldw	_adc_buff_+18,x
9329  1bc4               L7573:
9330                     ; 2521 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
9332  1bc4 b6ba          	ld	a,_adc_cnt_cnt
9333  1bc6 5f            	clrw	x
9334  1bc7 97            	ld	xl,a
9335  1bc8 58            	sllw	x
9336  1bc9 1f03          	ldw	(OFST-10,sp),x
9337  1bcb b6c9          	ld	a,_adc_ch
9338  1bcd 97            	ld	xl,a
9339  1bce a610          	ld	a,#16
9340  1bd0 42            	mul	x,a
9341  1bd1 72fb03        	addw	x,(OFST-10,sp)
9342  1bd4 160c          	ldw	y,(OFST-1,sp)
9343  1bd6 df0060        	ldw	(_adc_buff_buff,x),y
9344                     ; 2523 adc_ch++;
9346  1bd9 3cc9          	inc	_adc_ch
9347                     ; 2524 if(adc_ch>=6)
9349  1bdb b6c9          	ld	a,_adc_ch
9350  1bdd a106          	cp	a,#6
9351  1bdf 2516          	jrult	L7673
9352                     ; 2526 	adc_ch=0;
9354  1be1 3fc9          	clr	_adc_ch
9355                     ; 2527 	adc_cnt_cnt++;
9357  1be3 3cba          	inc	_adc_cnt_cnt
9358                     ; 2528 	if(adc_cnt_cnt>=8)
9360  1be5 b6ba          	ld	a,_adc_cnt_cnt
9361  1be7 a108          	cp	a,#8
9362  1be9 250c          	jrult	L7673
9363                     ; 2530 		adc_cnt_cnt=0;
9365  1beb 3fba          	clr	_adc_cnt_cnt
9366                     ; 2531 		adc_cnt++;
9368  1bed 3cc8          	inc	_adc_cnt
9369                     ; 2532 		if(adc_cnt>=16)
9371  1bef b6c8          	ld	a,_adc_cnt
9372  1bf1 a110          	cp	a,#16
9373  1bf3 2502          	jrult	L7673
9374                     ; 2534 			adc_cnt=0;
9376  1bf5 3fc8          	clr	_adc_cnt
9377  1bf7               L7673:
9378                     ; 2538 if(adc_cnt_cnt==0)
9380  1bf7 3dba          	tnz	_adc_cnt_cnt
9381  1bf9 2660          	jrne	L5773
9382                     ; 2542 	tempSS=0;
9384  1bfb ae0000        	ldw	x,#0
9385  1bfe 1f07          	ldw	(OFST-6,sp),x
9386  1c00 ae0000        	ldw	x,#0
9387  1c03 1f05          	ldw	(OFST-8,sp),x
9388                     ; 2543 	for(i=0;i<8;i++)
9390  1c05 0f09          	clr	(OFST-4,sp)
9391  1c07               L7773:
9392                     ; 2545 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9394  1c07 7b09          	ld	a,(OFST-4,sp)
9395  1c09 5f            	clrw	x
9396  1c0a 97            	ld	xl,a
9397  1c0b 58            	sllw	x
9398  1c0c 1f03          	ldw	(OFST-10,sp),x
9399  1c0e b6c9          	ld	a,_adc_ch
9400  1c10 97            	ld	xl,a
9401  1c11 a610          	ld	a,#16
9402  1c13 42            	mul	x,a
9403  1c14 72fb03        	addw	x,(OFST-10,sp)
9404  1c17 de0060        	ldw	x,(_adc_buff_buff,x)
9405  1c1a cd0000        	call	c_itolx
9407  1c1d 96            	ldw	x,sp
9408  1c1e 1c0005        	addw	x,#OFST-8
9409  1c21 cd0000        	call	c_lgadd
9411                     ; 2543 	for(i=0;i<8;i++)
9413  1c24 0c09          	inc	(OFST-4,sp)
9416  1c26 7b09          	ld	a,(OFST-4,sp)
9417  1c28 a108          	cp	a,#8
9418  1c2a 25db          	jrult	L7773
9419                     ; 2547 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9421  1c2c 96            	ldw	x,sp
9422  1c2d 1c0005        	addw	x,#OFST-8
9423  1c30 cd0000        	call	c_ltor
9425  1c33 a603          	ld	a,#3
9426  1c35 cd0000        	call	c_lrsh
9428  1c38 be02          	ldw	x,c_lreg+2
9429  1c3a b6c8          	ld	a,_adc_cnt
9430  1c3c 905f          	clrw	y
9431  1c3e 9097          	ld	yl,a
9432  1c40 9058          	sllw	y
9433  1c42 1703          	ldw	(OFST-10,sp),y
9434  1c44 b6c9          	ld	a,_adc_ch
9435  1c46 905f          	clrw	y
9436  1c48 9097          	ld	yl,a
9437  1c4a 9058          	sllw	y
9438  1c4c 9058          	sllw	y
9439  1c4e 9058          	sllw	y
9440  1c50 9058          	sllw	y
9441  1c52 9058          	sllw	y
9442  1c54 72f903        	addw	y,(OFST-10,sp)
9443  1c57 90df011d      	ldw	(_adc_buff,y),x
9444  1c5b               L5773:
9445                     ; 2551 if((adc_cnt&0x03)==0)
9447  1c5b b6c8          	ld	a,_adc_cnt
9448  1c5d a503          	bcp	a,#3
9449  1c5f 264b          	jrne	L5004
9450                     ; 2555 	tempSS=0;
9452  1c61 ae0000        	ldw	x,#0
9453  1c64 1f07          	ldw	(OFST-6,sp),x
9454  1c66 ae0000        	ldw	x,#0
9455  1c69 1f05          	ldw	(OFST-8,sp),x
9456                     ; 2556 	for(i=0;i<16;i++)
9458  1c6b 0f09          	clr	(OFST-4,sp)
9459  1c6d               L7004:
9460                     ; 2558 		tempSS+=(signed long)adc_buff[adc_ch][i];
9462  1c6d 7b09          	ld	a,(OFST-4,sp)
9463  1c6f 5f            	clrw	x
9464  1c70 97            	ld	xl,a
9465  1c71 58            	sllw	x
9466  1c72 1f03          	ldw	(OFST-10,sp),x
9467  1c74 b6c9          	ld	a,_adc_ch
9468  1c76 97            	ld	xl,a
9469  1c77 a620          	ld	a,#32
9470  1c79 42            	mul	x,a
9471  1c7a 72fb03        	addw	x,(OFST-10,sp)
9472  1c7d de011d        	ldw	x,(_adc_buff,x)
9473  1c80 cd0000        	call	c_itolx
9475  1c83 96            	ldw	x,sp
9476  1c84 1c0005        	addw	x,#OFST-8
9477  1c87 cd0000        	call	c_lgadd
9479                     ; 2556 	for(i=0;i<16;i++)
9481  1c8a 0c09          	inc	(OFST-4,sp)
9484  1c8c 7b09          	ld	a,(OFST-4,sp)
9485  1c8e a110          	cp	a,#16
9486  1c90 25db          	jrult	L7004
9487                     ; 2560 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9489  1c92 96            	ldw	x,sp
9490  1c93 1c0005        	addw	x,#OFST-8
9491  1c96 cd0000        	call	c_ltor
9493  1c99 a604          	ld	a,#4
9494  1c9b cd0000        	call	c_lrsh
9496  1c9e be02          	ldw	x,c_lreg+2
9497  1ca0 b6c9          	ld	a,_adc_ch
9498  1ca2 905f          	clrw	y
9499  1ca4 9097          	ld	yl,a
9500  1ca6 9058          	sllw	y
9501  1ca8 90df0109      	ldw	(_adc_buff_,y),x
9502  1cac               L5004:
9503                     ; 2567 if(adc_ch==0)adc_buff_5=temp_adc;
9505  1cac 3dc9          	tnz	_adc_ch
9506  1cae 2605          	jrne	L5104
9509  1cb0 1e0c          	ldw	x,(OFST-1,sp)
9510  1cb2 cf0107        	ldw	_adc_buff_5,x
9511  1cb5               L5104:
9512                     ; 2568 if(adc_ch==2)adc_buff_1=temp_adc;
9514  1cb5 b6c9          	ld	a,_adc_ch
9515  1cb7 a102          	cp	a,#2
9516  1cb9 2605          	jrne	L7104
9519  1cbb 1e0c          	ldw	x,(OFST-1,sp)
9520  1cbd cf0105        	ldw	_adc_buff_1,x
9521  1cc0               L7104:
9522                     ; 2570 adc_plazma_short++;
9524  1cc0 bec6          	ldw	x,_adc_plazma_short
9525  1cc2 1c0001        	addw	x,#1
9526  1cc5 bfc6          	ldw	_adc_plazma_short,x
9527                     ; 2572 }
9530  1cc7 5b0d          	addw	sp,#13
9531  1cc9 85            	popw	x
9532  1cca bf00          	ldw	c_lreg,x
9533  1ccc 85            	popw	x
9534  1ccd bf02          	ldw	c_lreg+2,x
9535  1ccf 85            	popw	x
9536  1cd0 bf00          	ldw	c_y,x
9537  1cd2 85            	popw	x
9538  1cd3 bf00          	ldw	c_x,x
9539  1cd5 80            	iret
9597                     ; 2581 main()
9597                     ; 2582 {
9599                     	switch	.text
9600  1cd6               _main:
9604                     ; 2584 CLK->ECKR|=1;
9606  1cd6 721050c1      	bset	20673,#0
9608  1cda               L3304:
9609                     ; 2585 while((CLK->ECKR & 2) == 0);
9611  1cda c650c1        	ld	a,20673
9612  1cdd a502          	bcp	a,#2
9613  1cdf 27f9          	jreq	L3304
9614                     ; 2586 CLK->SWCR|=2;
9616  1ce1 721250c5      	bset	20677,#1
9617                     ; 2587 CLK->SWR=0xB4;
9619  1ce5 35b450c4      	mov	20676,#180
9620                     ; 2589 delay_ms(200);
9622  1ce9 ae00c8        	ldw	x,#200
9623  1cec cd0121        	call	_delay_ms
9625                     ; 2590 FLASH_DUKR=0xae;
9627  1cef 35ae5064      	mov	_FLASH_DUKR,#174
9628                     ; 2591 FLASH_DUKR=0x56;
9630  1cf3 35565064      	mov	_FLASH_DUKR,#86
9631                     ; 2592 enableInterrupts();
9634  1cf7 9a            rim
9636                     ; 2595 adr_drv_v3();
9639  1cf8 cd0fa0        	call	_adr_drv_v3
9641                     ; 2599 t4_init();
9643  1cfb cd19bd        	call	_t4_init
9645                     ; 2601 		GPIOG->DDR|=(1<<0);
9647  1cfe 72105020      	bset	20512,#0
9648                     ; 2602 		GPIOG->CR1|=(1<<0);
9650  1d02 72105021      	bset	20513,#0
9651                     ; 2603 		GPIOG->CR2&=~(1<<0);	
9653  1d06 72115022      	bres	20514,#0
9654                     ; 2606 		GPIOG->DDR&=~(1<<1);
9656  1d0a 72135020      	bres	20512,#1
9657                     ; 2607 		GPIOG->CR1|=(1<<1);
9659  1d0e 72125021      	bset	20513,#1
9660                     ; 2608 		GPIOG->CR2&=~(1<<1);
9662  1d12 72135022      	bres	20514,#1
9663                     ; 2610 init_CAN();
9665  1d16 cd1190        	call	_init_CAN
9667                     ; 2615 GPIOC->DDR|=(1<<1);
9669  1d19 7212500c      	bset	20492,#1
9670                     ; 2616 GPIOC->CR1|=(1<<1);
9672  1d1d 7212500d      	bset	20493,#1
9673                     ; 2617 GPIOC->CR2|=(1<<1);
9675  1d21 7212500e      	bset	20494,#1
9676                     ; 2619 GPIOC->DDR|=(1<<2);
9678  1d25 7214500c      	bset	20492,#2
9679                     ; 2620 GPIOC->CR1|=(1<<2);
9681  1d29 7214500d      	bset	20493,#2
9682                     ; 2621 GPIOC->CR2|=(1<<2);
9684  1d2d 7214500e      	bset	20494,#2
9685                     ; 2628 t1_init();
9687  1d31 cd19ce        	call	_t1_init
9689                     ; 2630 GPIOA->DDR|=(1<<5);
9691  1d34 721a5002      	bset	20482,#5
9692                     ; 2631 GPIOA->CR1|=(1<<5);
9694  1d38 721a5003      	bset	20483,#5
9695                     ; 2632 GPIOA->CR2&=~(1<<5);
9697  1d3c 721b5004      	bres	20484,#5
9698                     ; 2638 GPIOB->DDR&=~(1<<3);
9700  1d40 72175007      	bres	20487,#3
9701                     ; 2639 GPIOB->CR1&=~(1<<3);
9703  1d44 72175008      	bres	20488,#3
9704                     ; 2640 GPIOB->CR2&=~(1<<3);
9706  1d48 72175009      	bres	20489,#3
9707                     ; 2642 GPIOC->DDR|=(1<<3);
9709  1d4c 7216500c      	bset	20492,#3
9710                     ; 2643 GPIOC->CR1|=(1<<3);
9712  1d50 7216500d      	bset	20493,#3
9713                     ; 2644 GPIOC->CR2|=(1<<3);
9715  1d54 7216500e      	bset	20494,#3
9716  1d58               L7304:
9717                     ; 2650 	if(b1000Hz)
9719                     	btst	_b1000Hz
9720  1d5d 240a          	jruge	L3404
9721                     ; 2652 		b1000Hz=0;
9723  1d5f 72110005      	bres	_b1000Hz
9724                     ; 2654 		adc2_init();
9726  1d63 cd1a0b        	call	_adc2_init
9728                     ; 2656 		pwr_hndl_new();
9730  1d66 cd0885        	call	_pwr_hndl_new
9732  1d69               L3404:
9733                     ; 2658 	if(bCAN_RX)
9735  1d69 3d04          	tnz	_bCAN_RX
9736  1d6b 2705          	jreq	L5404
9737                     ; 2660 		bCAN_RX=0;
9739  1d6d 3f04          	clr	_bCAN_RX
9740                     ; 2661 		can_in_an();	
9742  1d6f cd12ed        	call	_can_in_an
9744  1d72               L5404:
9745                     ; 2663 	if(b100Hz)
9747                     	btst	_b100Hz
9748  1d77 2407          	jruge	L7404
9749                     ; 2665 		b100Hz=0;
9751  1d79 7211000a      	bres	_b100Hz
9752                     ; 2675 		can_tx_hndl();
9754  1d7d cd1283        	call	_can_tx_hndl
9756  1d80               L7404:
9757                     ; 2679 	if(b20Hz)
9759                     	btst	_b20Hz
9760  1d85 2404          	jruge	L1504
9761                     ; 2681 		b20Hz=0;
9763  1d87 72110004      	bres	_b20Hz
9764  1d8b               L1504:
9765                     ; 2687 	if(b10Hz)
9767                     	btst	_b10Hz
9768  1d90 2425          	jruge	L3504
9769                     ; 2689 		b10Hz=0;
9771  1d92 72110009      	bres	_b10Hz
9772                     ; 2690 		led_drv();
9774  1d96 cd03ee        	call	_led_drv
9776                     ; 2691 		matemat();
9778  1d99 cd0aa3        	call	_matemat
9780                     ; 2693 	  link_drv();
9782  1d9c cd04dc        	call	_link_drv
9784                     ; 2695 	  JP_drv();
9786  1d9f cd0451        	call	_JP_drv
9788                     ; 2696 	  flags_drv();
9790  1da2 cd0f55        	call	_flags_drv
9792                     ; 2698 		if(main_cnt10<100)main_cnt10++;
9794  1da5 9c            	rvf
9795  1da6 ce025d        	ldw	x,_main_cnt10
9796  1da9 a30064        	cpw	x,#100
9797  1dac 2e09          	jrsge	L3504
9800  1dae ce025d        	ldw	x,_main_cnt10
9801  1db1 1c0001        	addw	x,#1
9802  1db4 cf025d        	ldw	_main_cnt10,x
9803  1db7               L3504:
9804                     ; 2701 	if(b5Hz)
9806                     	btst	_b5Hz
9807  1dbc 2419          	jruge	L7504
9808                     ; 2703 		b5Hz=0;
9810  1dbe 72110008      	bres	_b5Hz
9811                     ; 2710 		led_hndl();
9813  1dc2 cd0163        	call	_led_hndl
9815                     ; 2712 		vent_drv();
9817  1dc5 cd0534        	call	_vent_drv
9819                     ; 2714 		if(main_cnt1<1000)main_cnt1++;
9821  1dc8 9c            	rvf
9822  1dc9 be5e          	ldw	x,_main_cnt1
9823  1dcb a303e8        	cpw	x,#1000
9824  1dce 2e07          	jrsge	L7504
9827  1dd0 be5e          	ldw	x,_main_cnt1
9828  1dd2 1c0001        	addw	x,#1
9829  1dd5 bf5e          	ldw	_main_cnt1,x
9830  1dd7               L7504:
9831                     ; 2717 	if(b2Hz)
9833                     	btst	_b2Hz
9834  1ddc 240d          	jruge	L3604
9835                     ; 2719 		b2Hz=0;
9837  1dde 72110007      	bres	_b2Hz
9838                     ; 2723 		temper_drv();
9840  1de2 cd0cc2        	call	_temper_drv
9842                     ; 2724 		u_drv();
9844  1de5 cd0d99        	call	_u_drv
9846                     ; 2725 		vent_resurs_hndl();
9848  1de8 cd0000        	call	_vent_resurs_hndl
9850  1deb               L3604:
9851                     ; 2728 	if(b1Hz)
9853                     	btst	_b1Hz
9854  1df0 2503cc1d58    	jruge	L7304
9855                     ; 2730 		b1Hz=0;
9857  1df5 72110006      	bres	_b1Hz
9858                     ; 2736 		if(main_cnt<1000)main_cnt++;
9860  1df9 9c            	rvf
9861  1dfa ce025f        	ldw	x,_main_cnt
9862  1dfd a303e8        	cpw	x,#1000
9863  1e00 2e09          	jrsge	L7604
9866  1e02 ce025f        	ldw	x,_main_cnt
9867  1e05 1c0001        	addw	x,#1
9868  1e08 cf025f        	ldw	_main_cnt,x
9869  1e0b               L7604:
9870                     ; 2737   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9872  1e0b b670          	ld	a,_link
9873  1e0d a1aa          	cp	a,#170
9874  1e0f 2706          	jreq	L3704
9876  1e11 b655          	ld	a,_jp_mode
9877  1e13 a103          	cp	a,#3
9878  1e15 2603          	jrne	L1704
9879  1e17               L3704:
9882  1e17 cd0eb6        	call	_apv_hndl
9884  1e1a               L1704:
9885                     ; 2740   		can_error_cnt++;
9887  1e1a 3c76          	inc	_can_error_cnt
9888                     ; 2741   		if(can_error_cnt>=10)
9890  1e1c b676          	ld	a,_can_error_cnt
9891  1e1e a10a          	cp	a,#10
9892  1e20 2403          	jruge	L642
9893  1e22 cc1d58        	jp	L7304
9894  1e25               L642:
9895                     ; 2743   			can_error_cnt=0;
9897  1e25 3f76          	clr	_can_error_cnt
9898                     ; 2744 				init_CAN();
9900  1e27 cd1190        	call	_init_CAN
9902  1e2a ac581d58      	jpf	L7304
11222                     	xdef	_main
11223                     	xdef	f_ADC2_EOC_Interrupt
11224                     	xdef	f_CAN_TX_Interrupt
11225                     	xdef	f_CAN_RX_Interrupt
11226                     	xdef	f_TIM4_UPD_Interrupt
11227                     	xdef	_adc2_init
11228                     	xdef	_t1_init
11229                     	xdef	_t4_init
11230                     	xdef	_can_in_an
11231                     	xdef	_can_tx_hndl
11232                     	xdef	_can_transmit
11233                     	xdef	_init_CAN
11234                     	xdef	_adr_drv_v3
11235                     	xdef	_adr_drv_v4
11236                     	xdef	_flags_drv
11237                     	xdef	_apv_hndl
11238                     	xdef	_apv_stop
11239                     	xdef	_apv_start
11240                     	xdef	_u_drv
11241                     	xdef	_temper_drv
11242                     	xdef	_matemat
11243                     	xdef	_pwr_hndl_new
11244                     	xdef	_pwr_hndl
11245                     	xdef	_pwr_drv
11246                     	xdef	_vent_drv
11247                     	xdef	_link_drv
11248                     	xdef	_JP_drv
11249                     	xdef	_led_drv
11250                     	xdef	_led_hndl
11251                     	xdef	_delay_ms
11252                     	xdef	_granee
11253                     	xdef	_gran
11254                     	xdef	_vent_resurs_hndl
11255                     	switch	.ubsct
11256  0001               _debug_info_to_uku:
11257  0001 000000000000  	ds.b	6
11258                     	xdef	_debug_info_to_uku
11259  0007               _pwm_u_cnt:
11260  0007 00            	ds.b	1
11261                     	xdef	_pwm_u_cnt
11262  0008               _vent_resurs_tx_cnt:
11263  0008 00            	ds.b	1
11264                     	xdef	_vent_resurs_tx_cnt
11265                     	switch	.bss
11266  0000               _vent_resurs_buff:
11267  0000 00000000      	ds.b	4
11268                     	xdef	_vent_resurs_buff
11269                     	switch	.ubsct
11270  0009               _vent_resurs_sec_cnt:
11271  0009 0000          	ds.b	2
11272                     	xdef	_vent_resurs_sec_cnt
11273                     .eeprom:	section	.data
11274  0000               _vent_resurs:
11275  0000 0000          	ds.b	2
11276                     	xdef	_vent_resurs
11277  0002               _ee_IMAXVENT:
11278  0002 0000          	ds.b	2
11279                     	xdef	_ee_IMAXVENT
11280                     	switch	.ubsct
11281  000b               _bps_class:
11282  000b 00            	ds.b	1
11283                     	xdef	_bps_class
11284  000c               _vent_pwm_integr_cnt:
11285  000c 0000          	ds.b	2
11286                     	xdef	_vent_pwm_integr_cnt
11287  000e               _vent_pwm_integr:
11288  000e 0000          	ds.b	2
11289                     	xdef	_vent_pwm_integr
11290  0010               _vent_pwm:
11291  0010 0000          	ds.b	2
11292                     	xdef	_vent_pwm
11293  0012               _pwm_vent_cnt:
11294  0012 00            	ds.b	1
11295                     	xdef	_pwm_vent_cnt
11296                     	switch	.eeprom
11297  0004               _ee_DEVICE:
11298  0004 0000          	ds.b	2
11299                     	xdef	_ee_DEVICE
11300  0006               _ee_AVT_MODE:
11301  0006 0000          	ds.b	2
11302                     	xdef	_ee_AVT_MODE
11303                     	switch	.ubsct
11304  0013               _FADE_MODE:
11305  0013 00            	ds.b	1
11306                     	xdef	_FADE_MODE
11307  0014               _i_main_bps_cnt:
11308  0014 000000000000  	ds.b	6
11309                     	xdef	_i_main_bps_cnt
11310  001a               _i_main_sigma:
11311  001a 0000          	ds.b	2
11312                     	xdef	_i_main_sigma
11313  001c               _i_main_num_of_bps:
11314  001c 00            	ds.b	1
11315                     	xdef	_i_main_num_of_bps
11316  001d               _i_main_avg:
11317  001d 0000          	ds.b	2
11318                     	xdef	_i_main_avg
11319  001f               _i_main_flag:
11320  001f 000000000000  	ds.b	6
11321                     	xdef	_i_main_flag
11322  0025               _i_main:
11323  0025 000000000000  	ds.b	12
11324                     	xdef	_i_main
11325  0031               _x:
11326  0031 000000000000  	ds.b	12
11327                     	xdef	_x
11328                     	xdef	_volum_u_main_
11329                     	switch	.eeprom
11330  0008               _UU_AVT:
11331  0008 0000          	ds.b	2
11332                     	xdef	_UU_AVT
11333                     	switch	.ubsct
11334  003d               _cnt_net_drv:
11335  003d 00            	ds.b	1
11336                     	xdef	_cnt_net_drv
11337                     	switch	.bit
11338  0001               _bMAIN:
11339  0001 00            	ds.b	1
11340                     	xdef	_bMAIN
11341                     	switch	.ubsct
11342  003e               _plazma_int:
11343  003e 000000000000  	ds.b	6
11344                     	xdef	_plazma_int
11345                     	xdef	_rotor_int
11346  0044               _led_green_buff:
11347  0044 00000000      	ds.b	4
11348                     	xdef	_led_green_buff
11349  0048               _led_red_buff:
11350  0048 00000000      	ds.b	4
11351                     	xdef	_led_red_buff
11352                     	xdef	_led_drv_cnt
11353                     	xdef	_led_green
11354                     	xdef	_led_red
11355  004c               _res_fl_cnt:
11356  004c 00            	ds.b	1
11357                     	xdef	_res_fl_cnt
11358                     	xdef	_bRES_
11359                     	xdef	_bRES
11360                     	switch	.eeprom
11361  000a               _res_fl_:
11362  000a 00            	ds.b	1
11363                     	xdef	_res_fl_
11364  000b               _res_fl:
11365  000b 00            	ds.b	1
11366                     	xdef	_res_fl
11367                     	switch	.ubsct
11368  004d               _cnt_apv_off:
11369  004d 00            	ds.b	1
11370                     	xdef	_cnt_apv_off
11371                     	switch	.bit
11372  0002               _bAPV:
11373  0002 00            	ds.b	1
11374                     	xdef	_bAPV
11375                     	switch	.ubsct
11376  004e               _apv_cnt_:
11377  004e 0000          	ds.b	2
11378                     	xdef	_apv_cnt_
11379  0050               _apv_cnt:
11380  0050 000000        	ds.b	3
11381                     	xdef	_apv_cnt
11382                     	xdef	_bBL_IPS
11383                     	switch	.bit
11384  0003               _bBL:
11385  0003 00            	ds.b	1
11386                     	xdef	_bBL
11387                     	switch	.ubsct
11388  0053               _cnt_JP1:
11389  0053 00            	ds.b	1
11390                     	xdef	_cnt_JP1
11391  0054               _cnt_JP0:
11392  0054 00            	ds.b	1
11393                     	xdef	_cnt_JP0
11394  0055               _jp_mode:
11395  0055 00            	ds.b	1
11396                     	xdef	_jp_mode
11397  0056               _pwm_delt:
11398  0056 0000          	ds.b	2
11399                     	xdef	_pwm_delt
11400  0058               _pwm_u_:
11401  0058 0000          	ds.b	2
11402                     	xdef	_pwm_u_
11403                     	xdef	_pwm_i
11404                     	xdef	_pwm_u
11405  005a               _tmax_cnt:
11406  005a 0000          	ds.b	2
11407                     	xdef	_tmax_cnt
11408  005c               _tsign_cnt:
11409  005c 0000          	ds.b	2
11410                     	xdef	_tsign_cnt
11411                     	switch	.eeprom
11412  000c               _ee_UAVT:
11413  000c 0000          	ds.b	2
11414                     	xdef	_ee_UAVT
11415  000e               _ee_tsign:
11416  000e 0000          	ds.b	2
11417                     	xdef	_ee_tsign
11418  0010               _ee_tmax:
11419  0010 0000          	ds.b	2
11420                     	xdef	_ee_tmax
11421  0012               _ee_dU:
11422  0012 0000          	ds.b	2
11423                     	xdef	_ee_dU
11424  0014               _ee_Umax:
11425  0014 0000          	ds.b	2
11426                     	xdef	_ee_Umax
11427  0016               _ee_TZAS:
11428  0016 0000          	ds.b	2
11429                     	xdef	_ee_TZAS
11430                     	switch	.ubsct
11431  005e               _main_cnt1:
11432  005e 0000          	ds.b	2
11433                     	xdef	_main_cnt1
11434  0060               _off_bp_cnt:
11435  0060 00            	ds.b	1
11436                     	xdef	_off_bp_cnt
11437                     	xdef	_vol_i_temp_avar
11438  0061               _flags_tu_cnt_off:
11439  0061 00            	ds.b	1
11440                     	xdef	_flags_tu_cnt_off
11441  0062               _flags_tu_cnt_on:
11442  0062 00            	ds.b	1
11443                     	xdef	_flags_tu_cnt_on
11444  0063               _vol_i_temp:
11445  0063 0000          	ds.b	2
11446                     	xdef	_vol_i_temp
11447  0065               _vol_u_temp:
11448  0065 0000          	ds.b	2
11449                     	xdef	_vol_u_temp
11450                     	switch	.eeprom
11451  0018               __x_ee_:
11452  0018 0000          	ds.b	2
11453                     	xdef	__x_ee_
11454                     	switch	.ubsct
11455  0067               __x_cnt:
11456  0067 0000          	ds.b	2
11457                     	xdef	__x_cnt
11458  0069               __x__:
11459  0069 0000          	ds.b	2
11460                     	xdef	__x__
11461  006b               __x_:
11462  006b 0000          	ds.b	2
11463                     	xdef	__x_
11464  006d               _flags_tu:
11465  006d 00            	ds.b	1
11466                     	xdef	_flags_tu
11467                     	xdef	_flags
11468  006e               _link_cnt:
11469  006e 0000          	ds.b	2
11470                     	xdef	_link_cnt
11471  0070               _link:
11472  0070 00            	ds.b	1
11473                     	xdef	_link
11474  0071               _umin_cnt:
11475  0071 0000          	ds.b	2
11476                     	xdef	_umin_cnt
11477  0073               _umax_cnt:
11478  0073 0000          	ds.b	2
11479                     	xdef	_umax_cnt
11480                     	switch	.bss
11481  0004               _pwm_schot_cnt:
11482  0004 0000          	ds.b	2
11483                     	xdef	_pwm_schot_cnt
11484  0006               _pwm_peace_cnt_:
11485  0006 0000          	ds.b	2
11486                     	xdef	_pwm_peace_cnt_
11487  0008               _pwm_peace_cnt:
11488  0008 0000          	ds.b	2
11489                     	xdef	_pwm_peace_cnt
11490                     	switch	.eeprom
11491  001a               _ee_K:
11492  001a 000000000000  	ds.b	20
11493                     	xdef	_ee_K
11494                     	switch	.ubsct
11495  0075               _T:
11496  0075 00            	ds.b	1
11497                     	xdef	_T
11498                     	switch	.bss
11499  000a               _Ufade:
11500  000a 0000          	ds.b	2
11501                     	xdef	_Ufade
11502  000c               _Udelt:
11503  000c 0000          	ds.b	2
11504                     	xdef	_Udelt
11505  000e               _Uin:
11506  000e 0000          	ds.b	2
11507                     	xdef	_Uin
11508  0010               _Usum:
11509  0010 0000          	ds.b	2
11510                     	xdef	_Usum
11511  0012               _U_out_const:
11512  0012 0000          	ds.b	2
11513                     	xdef	_U_out_const
11514  0014               _Unecc:
11515  0014 0000          	ds.b	2
11516                     	xdef	_Unecc
11517  0016               _Ui:
11518  0016 0000          	ds.b	2
11519                     	xdef	_Ui
11520  0018               _Un:
11521  0018 0000          	ds.b	2
11522                     	xdef	_Un
11523  001a               _I:
11524  001a 0000          	ds.b	2
11525                     	xdef	_I
11526                     	switch	.ubsct
11527  0076               _can_error_cnt:
11528  0076 00            	ds.b	1
11529                     	xdef	_can_error_cnt
11530                     	xdef	_bCAN_RX
11531  0077               _tx_busy_cnt:
11532  0077 00            	ds.b	1
11533                     	xdef	_tx_busy_cnt
11534                     	xdef	_bTX_FREE
11535  0078               _can_buff_rd_ptr:
11536  0078 00            	ds.b	1
11537                     	xdef	_can_buff_rd_ptr
11538  0079               _can_buff_wr_ptr:
11539  0079 00            	ds.b	1
11540                     	xdef	_can_buff_wr_ptr
11541  007a               _can_out_buff:
11542  007a 000000000000  	ds.b	64
11543                     	xdef	_can_out_buff
11544                     	switch	.bss
11545  001c               _pwm_u_buff_cnt:
11546  001c 00            	ds.b	1
11547                     	xdef	_pwm_u_buff_cnt
11548  001d               _pwm_u_buff_ptr:
11549  001d 00            	ds.b	1
11550                     	xdef	_pwm_u_buff_ptr
11551  001e               _pwm_u_buff_:
11552  001e 0000          	ds.b	2
11553                     	xdef	_pwm_u_buff_
11554  0020               _pwm_u_buff:
11555  0020 000000000000  	ds.b	64
11556                     	xdef	_pwm_u_buff
11557                     	switch	.ubsct
11558  00ba               _adc_cnt_cnt:
11559  00ba 00            	ds.b	1
11560                     	xdef	_adc_cnt_cnt
11561                     	switch	.bss
11562  0060               _adc_buff_buff:
11563  0060 000000000000  	ds.b	160
11564                     	xdef	_adc_buff_buff
11565  0100               _adress_error:
11566  0100 00            	ds.b	1
11567                     	xdef	_adress_error
11568  0101               _adress:
11569  0101 00            	ds.b	1
11570                     	xdef	_adress
11571  0102               _adr:
11572  0102 000000        	ds.b	3
11573                     	xdef	_adr
11574                     	xdef	_adr_drv_stat
11575                     	xdef	_led_ind
11576                     	switch	.ubsct
11577  00bb               _led_ind_cnt:
11578  00bb 00            	ds.b	1
11579                     	xdef	_led_ind_cnt
11580  00bc               _adc_plazma:
11581  00bc 000000000000  	ds.b	10
11582                     	xdef	_adc_plazma
11583  00c6               _adc_plazma_short:
11584  00c6 0000          	ds.b	2
11585                     	xdef	_adc_plazma_short
11586  00c8               _adc_cnt:
11587  00c8 00            	ds.b	1
11588                     	xdef	_adc_cnt
11589  00c9               _adc_ch:
11590  00c9 00            	ds.b	1
11591                     	xdef	_adc_ch
11592                     	switch	.bss
11593  0105               _adc_buff_1:
11594  0105 0000          	ds.b	2
11595                     	xdef	_adc_buff_1
11596  0107               _adc_buff_5:
11597  0107 0000          	ds.b	2
11598                     	xdef	_adc_buff_5
11599  0109               _adc_buff_:
11600  0109 000000000000  	ds.b	20
11601                     	xdef	_adc_buff_
11602  011d               _adc_buff:
11603  011d 000000000000  	ds.b	320
11604                     	xdef	_adc_buff
11605  025d               _main_cnt10:
11606  025d 0000          	ds.b	2
11607                     	xdef	_main_cnt10
11608  025f               _main_cnt:
11609  025f 0000          	ds.b	2
11610                     	xdef	_main_cnt
11611                     	switch	.ubsct
11612  00ca               _mess:
11613  00ca 000000000000  	ds.b	14
11614                     	xdef	_mess
11615                     	switch	.bit
11616  0004               _b20Hz:
11617  0004 00            	ds.b	1
11618                     	xdef	_b20Hz
11619  0005               _b1000Hz:
11620  0005 00            	ds.b	1
11621                     	xdef	_b1000Hz
11622  0006               _b1Hz:
11623  0006 00            	ds.b	1
11624                     	xdef	_b1Hz
11625  0007               _b2Hz:
11626  0007 00            	ds.b	1
11627                     	xdef	_b2Hz
11628  0008               _b5Hz:
11629  0008 00            	ds.b	1
11630                     	xdef	_b5Hz
11631  0009               _b10Hz:
11632  0009 00            	ds.b	1
11633                     	xdef	_b10Hz
11634  000a               _b100Hz:
11635  000a 00            	ds.b	1
11636                     	xdef	_b100Hz
11637                     	xdef	_t0_cnt5
11638                     	xdef	_t0_cnt4
11639                     	xdef	_t0_cnt3
11640                     	xdef	_t0_cnt2
11641                     	xdef	_t0_cnt1
11642                     	xdef	_t0_cnt0
11643                     	xdef	_t0_cnt00
11644                     	xref	_abs
11645                     	xdef	_bVENT_BLOCK
11646                     	xref.b	c_lreg
11647                     	xref.b	c_x
11648                     	xref.b	c_y
11668                     	xref	c_lrsh
11669                     	xref	c_umul
11670                     	xref	c_lgsub
11671                     	xref	c_lgrsh
11672                     	xref	c_lgadd
11673                     	xref	c_idiv
11674                     	xref	c_sdivx
11675                     	xref	c_imul
11676                     	xref	c_lsbc
11677                     	xref	c_ladd
11678                     	xref	c_lsub
11679                     	xref	c_ldiv
11680                     	xref	c_lgmul
11681                     	xref	c_itolx
11682                     	xref	c_eewrc
11683                     	xref	c_ltor
11684                     	xref	c_lgadc
11685                     	xref	c_rtol
11686                     	xref	c_vmul
11687                     	xref	c_eewrw
11688                     	xref	c_lcmp
11689                     	xref	c_uitolx
11690                     	end
