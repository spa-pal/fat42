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
2188                     	bsct
2189  0001               _led_ind:
2190  0001 05            	dc.b	5
2191  0002               _adr_drv_stat:
2192  0002 00            	dc.b	0
2193  0003               _bTX_FREE:
2194  0003 01            	dc.b	1
2195  0004               _bCAN_RX:
2196  0004 00            	dc.b	0
2197  0005               _flags:
2198  0005 00            	dc.b	0
2199  0006               _vol_i_temp_avar:
2200  0006 0000          	dc.w	0
2201  0008               _pwm_u:
2202  0008 00c8          	dc.w	200
2203  000a               _pwm_i:
2204  000a 0032          	dc.w	50
2205                     .bit:	section	.data,bit
2206  0000               _bBL_IPS:
2207  0000 00            	dc.b	0
2208                     	bsct
2209  000c               _bRES:
2210  000c 00            	dc.b	0
2211  000d               _bRES_:
2212  000d 00            	dc.b	0
2213  000e               _led_red:
2214  000e 00000000      	dc.l	0
2215  0012               _led_green:
2216  0012 03030303      	dc.l	50529027
2217  0016               _led_drv_cnt:
2218  0016 1e            	dc.b	30
2219  0017               _rotor_int:
2220  0017 007b          	dc.w	123
2221  0019               _volum_u_main_:
2222  0019 02bc          	dc.w	700
2267                     .const:	section	.text
2268  0000               L6:
2269  0000 0000ea60      	dc.l	60000
2270                     ; 190 void vent_resurs_hndl(void)
2270                     ; 191 {
2271                     	scross	off
2272                     	switch	.text
2273  0000               _vent_resurs_hndl:
2275  0000 88            	push	a
2276       00000001      OFST:	set	1
2279                     ; 193 if(vent_pwm>100)vent_resurs_sec_cnt++;
2281  0001 9c            	rvf
2282  0002 be10          	ldw	x,_vent_pwm
2283  0004 a30065        	cpw	x,#101
2284  0007 2f07          	jrslt	L7441
2287  0009 be09          	ldw	x,_vent_resurs_sec_cnt
2288  000b 1c0001        	addw	x,#1
2289  000e bf09          	ldw	_vent_resurs_sec_cnt,x
2290  0010               L7441:
2291                     ; 194 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2293  0010 be09          	ldw	x,_vent_resurs_sec_cnt
2294  0012 a30e11        	cpw	x,#3601
2295  0015 251b          	jrult	L1541
2296                     ; 196 	if(vent_resurs<60000)vent_resurs++;
2298  0017 9c            	rvf
2299  0018 ce0000        	ldw	x,_vent_resurs
2300  001b cd0000        	call	c_uitolx
2302  001e ae0000        	ldw	x,#L6
2303  0021 cd0000        	call	c_lcmp
2305  0024 2e09          	jrsge	L3541
2308  0026 ce0000        	ldw	x,_vent_resurs
2309  0029 1c0001        	addw	x,#1
2310  002c cf0000        	ldw	_vent_resurs,x
2311  002f               L3541:
2312                     ; 197 	vent_resurs_sec_cnt=0;
2314  002f 5f            	clrw	x
2315  0030 bf09          	ldw	_vent_resurs_sec_cnt,x
2316  0032               L1541:
2317                     ; 202 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2319  0032 c60001        	ld	a,_vent_resurs+1
2320  0035 a40f          	and	a,#15
2321  0037 c70000        	ld	_vent_resurs_buff,a
2322                     ; 203 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2324  003a c60001        	ld	a,_vent_resurs+1
2325  003d a4f0          	and	a,#240
2326  003f 4e            	swap	a
2327  0040 a40f          	and	a,#15
2328  0042 aa40          	or	a,#64
2329  0044 c70001        	ld	_vent_resurs_buff+1,a
2330                     ; 204 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2332  0047 c60000        	ld	a,_vent_resurs
2333  004a 97            	ld	xl,a
2334  004b c60001        	ld	a,_vent_resurs+1
2335  004e 9f            	ld	a,xl
2336  004f a40f          	and	a,#15
2337  0051 97            	ld	xl,a
2338  0052 4f            	clr	a
2339  0053 02            	rlwa	x,a
2340  0054 4f            	clr	a
2341  0055 01            	rrwa	x,a
2342  0056 9f            	ld	a,xl
2343  0057 aa80          	or	a,#128
2344  0059 c70002        	ld	_vent_resurs_buff+2,a
2345                     ; 205 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2347  005c c60000        	ld	a,_vent_resurs
2348  005f 97            	ld	xl,a
2349  0060 c60001        	ld	a,_vent_resurs+1
2350  0063 9f            	ld	a,xl
2351  0064 a4f0          	and	a,#240
2352  0066 97            	ld	xl,a
2353  0067 4f            	clr	a
2354  0068 02            	rlwa	x,a
2355  0069 01            	rrwa	x,a
2356  006a 4f            	clr	a
2357  006b 41            	exg	a,xl
2358  006c 4e            	swap	a
2359  006d a40f          	and	a,#15
2360  006f 02            	rlwa	x,a
2361  0070 9f            	ld	a,xl
2362  0071 aac0          	or	a,#192
2363  0073 c70003        	ld	_vent_resurs_buff+3,a
2364                     ; 207 temp=vent_resurs_buff[0]&0x0f;
2366  0076 c60000        	ld	a,_vent_resurs_buff
2367  0079 a40f          	and	a,#15
2368  007b 6b01          	ld	(OFST+0,sp),a
2369                     ; 208 temp^=vent_resurs_buff[1]&0x0f;
2371  007d c60001        	ld	a,_vent_resurs_buff+1
2372  0080 a40f          	and	a,#15
2373  0082 1801          	xor	a,(OFST+0,sp)
2374  0084 6b01          	ld	(OFST+0,sp),a
2375                     ; 209 temp^=vent_resurs_buff[2]&0x0f;
2377  0086 c60002        	ld	a,_vent_resurs_buff+2
2378  0089 a40f          	and	a,#15
2379  008b 1801          	xor	a,(OFST+0,sp)
2380  008d 6b01          	ld	(OFST+0,sp),a
2381                     ; 210 temp^=vent_resurs_buff[3]&0x0f;
2383  008f c60003        	ld	a,_vent_resurs_buff+3
2384  0092 a40f          	and	a,#15
2385  0094 1801          	xor	a,(OFST+0,sp)
2386  0096 6b01          	ld	(OFST+0,sp),a
2387                     ; 212 vent_resurs_buff[0]|=(temp&0x03)<<4;
2389  0098 7b01          	ld	a,(OFST+0,sp)
2390  009a a403          	and	a,#3
2391  009c 97            	ld	xl,a
2392  009d a610          	ld	a,#16
2393  009f 42            	mul	x,a
2394  00a0 9f            	ld	a,xl
2395  00a1 ca0000        	or	a,_vent_resurs_buff
2396  00a4 c70000        	ld	_vent_resurs_buff,a
2397                     ; 213 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2399  00a7 7b01          	ld	a,(OFST+0,sp)
2400  00a9 a40c          	and	a,#12
2401  00ab 48            	sll	a
2402  00ac 48            	sll	a
2403  00ad ca0001        	or	a,_vent_resurs_buff+1
2404  00b0 c70001        	ld	_vent_resurs_buff+1,a
2405                     ; 214 vent_resurs_buff[2]|=(temp&0x30);
2407  00b3 7b01          	ld	a,(OFST+0,sp)
2408  00b5 a430          	and	a,#48
2409  00b7 ca0002        	or	a,_vent_resurs_buff+2
2410  00ba c70002        	ld	_vent_resurs_buff+2,a
2411                     ; 215 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2413  00bd 7b01          	ld	a,(OFST+0,sp)
2414  00bf a4c0          	and	a,#192
2415  00c1 44            	srl	a
2416  00c2 44            	srl	a
2417  00c3 ca0003        	or	a,_vent_resurs_buff+3
2418  00c6 c70003        	ld	_vent_resurs_buff+3,a
2419                     ; 218 vent_resurs_tx_cnt++;
2421  00c9 3c08          	inc	_vent_resurs_tx_cnt
2422                     ; 219 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2424  00cb b608          	ld	a,_vent_resurs_tx_cnt
2425  00cd a104          	cp	a,#4
2426  00cf 2502          	jrult	L5541
2429  00d1 3f08          	clr	_vent_resurs_tx_cnt
2430  00d3               L5541:
2431                     ; 222 }
2434  00d3 84            	pop	a
2435  00d4 81            	ret
2488                     ; 225 void gran(signed short *adr, signed short min, signed short max)
2488                     ; 226 {
2489                     	switch	.text
2490  00d5               _gran:
2492  00d5 89            	pushw	x
2493       00000000      OFST:	set	0
2496                     ; 227 if (*adr<min) *adr=min;
2498  00d6 9c            	rvf
2499  00d7 9093          	ldw	y,x
2500  00d9 51            	exgw	x,y
2501  00da fe            	ldw	x,(x)
2502  00db 1305          	cpw	x,(OFST+5,sp)
2503  00dd 51            	exgw	x,y
2504  00de 2e03          	jrsge	L5051
2507  00e0 1605          	ldw	y,(OFST+5,sp)
2508  00e2 ff            	ldw	(x),y
2509  00e3               L5051:
2510                     ; 228 if (*adr>max) *adr=max; 
2512  00e3 9c            	rvf
2513  00e4 1e01          	ldw	x,(OFST+1,sp)
2514  00e6 9093          	ldw	y,x
2515  00e8 51            	exgw	x,y
2516  00e9 fe            	ldw	x,(x)
2517  00ea 1307          	cpw	x,(OFST+7,sp)
2518  00ec 51            	exgw	x,y
2519  00ed 2d05          	jrsle	L7051
2522  00ef 1e01          	ldw	x,(OFST+1,sp)
2523  00f1 1607          	ldw	y,(OFST+7,sp)
2524  00f3 ff            	ldw	(x),y
2525  00f4               L7051:
2526                     ; 229 } 
2529  00f4 85            	popw	x
2530  00f5 81            	ret
2583                     ; 232 void granee(@eeprom signed short *adr, signed short min, signed short max)
2583                     ; 233 {
2584                     	switch	.text
2585  00f6               _granee:
2587  00f6 89            	pushw	x
2588       00000000      OFST:	set	0
2591                     ; 234 if (*adr<min) *adr=min;
2593  00f7 9c            	rvf
2594  00f8 9093          	ldw	y,x
2595  00fa 51            	exgw	x,y
2596  00fb fe            	ldw	x,(x)
2597  00fc 1305          	cpw	x,(OFST+5,sp)
2598  00fe 51            	exgw	x,y
2599  00ff 2e09          	jrsge	L7351
2602  0101 1e05          	ldw	x,(OFST+5,sp)
2603  0103 89            	pushw	x
2604  0104 1e03          	ldw	x,(OFST+3,sp)
2605  0106 cd0000        	call	c_eewrw
2607  0109 85            	popw	x
2608  010a               L7351:
2609                     ; 235 if (*adr>max) *adr=max; 
2611  010a 9c            	rvf
2612  010b 1e01          	ldw	x,(OFST+1,sp)
2613  010d 9093          	ldw	y,x
2614  010f 51            	exgw	x,y
2615  0110 fe            	ldw	x,(x)
2616  0111 1307          	cpw	x,(OFST+7,sp)
2617  0113 51            	exgw	x,y
2618  0114 2d09          	jrsle	L1451
2621  0116 1e07          	ldw	x,(OFST+7,sp)
2622  0118 89            	pushw	x
2623  0119 1e03          	ldw	x,(OFST+3,sp)
2624  011b cd0000        	call	c_eewrw
2626  011e 85            	popw	x
2627  011f               L1451:
2628                     ; 236 }
2631  011f 85            	popw	x
2632  0120 81            	ret
2693                     ; 239 long delay_ms(short in)
2693                     ; 240 {
2694                     	switch	.text
2695  0121               _delay_ms:
2697  0121 520c          	subw	sp,#12
2698       0000000c      OFST:	set	12
2701                     ; 243 i=((long)in)*100UL;
2703  0123 90ae0064      	ldw	y,#100
2704  0127 cd0000        	call	c_vmul
2706  012a 96            	ldw	x,sp
2707  012b 1c0005        	addw	x,#OFST-7
2708  012e cd0000        	call	c_rtol
2710                     ; 245 for(ii=0;ii<i;ii++)
2712  0131 ae0000        	ldw	x,#0
2713  0134 1f0b          	ldw	(OFST-1,sp),x
2714  0136 ae0000        	ldw	x,#0
2715  0139 1f09          	ldw	(OFST-3,sp),x
2717  013b 2012          	jra	L1061
2718  013d               L5751:
2719                     ; 247 		iii++;
2721  013d 96            	ldw	x,sp
2722  013e 1c0001        	addw	x,#OFST-11
2723  0141 a601          	ld	a,#1
2724  0143 cd0000        	call	c_lgadc
2726                     ; 245 for(ii=0;ii<i;ii++)
2728  0146 96            	ldw	x,sp
2729  0147 1c0009        	addw	x,#OFST-3
2730  014a a601          	ld	a,#1
2731  014c cd0000        	call	c_lgadc
2733  014f               L1061:
2736  014f 9c            	rvf
2737  0150 96            	ldw	x,sp
2738  0151 1c0009        	addw	x,#OFST-3
2739  0154 cd0000        	call	c_ltor
2741  0157 96            	ldw	x,sp
2742  0158 1c0005        	addw	x,#OFST-7
2743  015b cd0000        	call	c_lcmp
2745  015e 2fdd          	jrslt	L5751
2746                     ; 250 }
2749  0160 5b0c          	addw	sp,#12
2750  0162 81            	ret
2783                     ; 253 void led_hndl(void)
2783                     ; 254 {
2784                     	switch	.text
2785  0163               _led_hndl:
2789                     ; 255 if(adress_error)
2791  0163 725d00f6      	tnz	_adress_error
2792  0167 2714          	jreq	L5161
2793                     ; 257 	led_red=0x55555555L;
2795  0169 ae5555        	ldw	x,#21845
2796  016c bf10          	ldw	_led_red+2,x
2797  016e ae5555        	ldw	x,#21845
2798  0171 bf0e          	ldw	_led_red,x
2799                     ; 258 	led_green=0x55555555L;
2801  0173 ae5555        	ldw	x,#21845
2802  0176 bf14          	ldw	_led_green+2,x
2803  0178 ae5555        	ldw	x,#21845
2804  017b bf12          	ldw	_led_green,x
2805  017d               L5161:
2806                     ; 276 	if(jp_mode!=jp3)
2808  017d b654          	ld	a,_jp_mode
2809  017f a103          	cp	a,#3
2810  0181 2603          	jrne	L02
2811  0183 cc0311        	jp	L7161
2812  0186               L02:
2813                     ; 278 		if(main_cnt1<(5*EE_TZAS))
2815  0186 9c            	rvf
2816  0187 be5b          	ldw	x,_main_cnt1
2817  0189 a3000f        	cpw	x,#15
2818  018c 2e18          	jrsge	L1261
2819                     ; 280 			led_red=0x00000000L;
2821  018e ae0000        	ldw	x,#0
2822  0191 bf10          	ldw	_led_red+2,x
2823  0193 ae0000        	ldw	x,#0
2824  0196 bf0e          	ldw	_led_red,x
2825                     ; 281 			led_green=0x0303030fL;
2827  0198 ae030f        	ldw	x,#783
2828  019b bf14          	ldw	_led_green+2,x
2829  019d ae0303        	ldw	x,#771
2830  01a0 bf12          	ldw	_led_green,x
2832  01a2 acd202d2      	jpf	L3261
2833  01a6               L1261:
2834                     ; 284 		else if((link==ON)&&(flags_tu&0b10000000))
2836  01a6 b66d          	ld	a,_link
2837  01a8 a155          	cp	a,#85
2838  01aa 261e          	jrne	L5261
2840  01ac b66a          	ld	a,_flags_tu
2841  01ae a580          	bcp	a,#128
2842  01b0 2718          	jreq	L5261
2843                     ; 286 			led_red=0x00055555L;
2845  01b2 ae5555        	ldw	x,#21845
2846  01b5 bf10          	ldw	_led_red+2,x
2847  01b7 ae0005        	ldw	x,#5
2848  01ba bf0e          	ldw	_led_red,x
2849                     ; 287 			led_green=0xffffffffL;
2851  01bc aeffff        	ldw	x,#65535
2852  01bf bf14          	ldw	_led_green+2,x
2853  01c1 aeffff        	ldw	x,#-1
2854  01c4 bf12          	ldw	_led_green,x
2856  01c6 acd202d2      	jpf	L3261
2857  01ca               L5261:
2858                     ; 290 		else if(((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(100+(5*EE_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2860  01ca 9c            	rvf
2861  01cb be5b          	ldw	x,_main_cnt1
2862  01cd a30010        	cpw	x,#16
2863  01d0 2f2d          	jrslt	L1361
2865  01d2 9c            	rvf
2866  01d3 be5b          	ldw	x,_main_cnt1
2867  01d5 a30073        	cpw	x,#115
2868  01d8 2e25          	jrsge	L1361
2870  01da ce0006        	ldw	x,_ee_AVT_MODE
2871  01dd a30055        	cpw	x,#85
2872  01e0 271d          	jreq	L1361
2874  01e2 ce0004        	ldw	x,_ee_DEVICE
2875  01e5 2618          	jrne	L1361
2876                     ; 292 			led_red=0x00000000L;
2878  01e7 ae0000        	ldw	x,#0
2879  01ea bf10          	ldw	_led_red+2,x
2880  01ec ae0000        	ldw	x,#0
2881  01ef bf0e          	ldw	_led_red,x
2882                     ; 293 			led_green=0xffffffffL;	
2884  01f1 aeffff        	ldw	x,#65535
2885  01f4 bf14          	ldw	_led_green+2,x
2886  01f6 aeffff        	ldw	x,#-1
2887  01f9 bf12          	ldw	_led_green,x
2889  01fb acd202d2      	jpf	L3261
2890  01ff               L1361:
2891                     ; 296 		else  if(link==OFF)
2893  01ff b66d          	ld	a,_link
2894  0201 a1aa          	cp	a,#170
2895  0203 2618          	jrne	L5361
2896                     ; 298 			led_red=0x55555555L;
2898  0205 ae5555        	ldw	x,#21845
2899  0208 bf10          	ldw	_led_red+2,x
2900  020a ae5555        	ldw	x,#21845
2901  020d bf0e          	ldw	_led_red,x
2902                     ; 299 			led_green=0xffffffffL;
2904  020f aeffff        	ldw	x,#65535
2905  0212 bf14          	ldw	_led_green+2,x
2906  0214 aeffff        	ldw	x,#-1
2907  0217 bf12          	ldw	_led_green,x
2909  0219 acd202d2      	jpf	L3261
2910  021d               L5361:
2911                     ; 302 		else if((link==ON)&&((flags&0b00111110)==0))
2913  021d b66d          	ld	a,_link
2914  021f a155          	cp	a,#85
2915  0221 261d          	jrne	L1461
2917  0223 b605          	ld	a,_flags
2918  0225 a53e          	bcp	a,#62
2919  0227 2617          	jrne	L1461
2920                     ; 304 			led_red=0x00000000L;
2922  0229 ae0000        	ldw	x,#0
2923  022c bf10          	ldw	_led_red+2,x
2924  022e ae0000        	ldw	x,#0
2925  0231 bf0e          	ldw	_led_red,x
2926                     ; 305 			led_green=0xffffffffL;
2928  0233 aeffff        	ldw	x,#65535
2929  0236 bf14          	ldw	_led_green+2,x
2930  0238 aeffff        	ldw	x,#-1
2931  023b bf12          	ldw	_led_green,x
2933  023d cc02d2        	jra	L3261
2934  0240               L1461:
2935                     ; 308 		else if((flags&0b00111110)==0b00000100)
2937  0240 b605          	ld	a,_flags
2938  0242 a43e          	and	a,#62
2939  0244 a104          	cp	a,#4
2940  0246 2616          	jrne	L5461
2941                     ; 310 			led_red=0x00010001L;
2943  0248 ae0001        	ldw	x,#1
2944  024b bf10          	ldw	_led_red+2,x
2945  024d ae0001        	ldw	x,#1
2946  0250 bf0e          	ldw	_led_red,x
2947                     ; 311 			led_green=0xffffffffL;	
2949  0252 aeffff        	ldw	x,#65535
2950  0255 bf14          	ldw	_led_green+2,x
2951  0257 aeffff        	ldw	x,#-1
2952  025a bf12          	ldw	_led_green,x
2954  025c 2074          	jra	L3261
2955  025e               L5461:
2956                     ; 313 		else if(flags&0b00000010)
2958  025e b605          	ld	a,_flags
2959  0260 a502          	bcp	a,#2
2960  0262 2716          	jreq	L1561
2961                     ; 315 			led_red=0x00010001L;
2963  0264 ae0001        	ldw	x,#1
2964  0267 bf10          	ldw	_led_red+2,x
2965  0269 ae0001        	ldw	x,#1
2966  026c bf0e          	ldw	_led_red,x
2967                     ; 316 			led_green=0x00000000L;	
2969  026e ae0000        	ldw	x,#0
2970  0271 bf14          	ldw	_led_green+2,x
2971  0273 ae0000        	ldw	x,#0
2972  0276 bf12          	ldw	_led_green,x
2974  0278 2058          	jra	L3261
2975  027a               L1561:
2976                     ; 318 		else if(flags&0b00001000)
2978  027a b605          	ld	a,_flags
2979  027c a508          	bcp	a,#8
2980  027e 2716          	jreq	L5561
2981                     ; 320 			led_red=0x00090009L;
2983  0280 ae0009        	ldw	x,#9
2984  0283 bf10          	ldw	_led_red+2,x
2985  0285 ae0009        	ldw	x,#9
2986  0288 bf0e          	ldw	_led_red,x
2987                     ; 321 			led_green=0x00000000L;	
2989  028a ae0000        	ldw	x,#0
2990  028d bf14          	ldw	_led_green+2,x
2991  028f ae0000        	ldw	x,#0
2992  0292 bf12          	ldw	_led_green,x
2994  0294 203c          	jra	L3261
2995  0296               L5561:
2996                     ; 323 		else if(flags&0b00010000)
2998  0296 b605          	ld	a,_flags
2999  0298 a510          	bcp	a,#16
3000  029a 2716          	jreq	L1661
3001                     ; 325 			led_red=0x00490049L;
3003  029c ae0049        	ldw	x,#73
3004  029f bf10          	ldw	_led_red+2,x
3005  02a1 ae0049        	ldw	x,#73
3006  02a4 bf0e          	ldw	_led_red,x
3007                     ; 326 			led_green=0x00000000L;	
3009  02a6 ae0000        	ldw	x,#0
3010  02a9 bf14          	ldw	_led_green+2,x
3011  02ab ae0000        	ldw	x,#0
3012  02ae bf12          	ldw	_led_green,x
3014  02b0 2020          	jra	L3261
3015  02b2               L1661:
3016                     ; 329 		else if((link==ON)&&(flags&0b00100000))
3018  02b2 b66d          	ld	a,_link
3019  02b4 a155          	cp	a,#85
3020  02b6 261a          	jrne	L3261
3022  02b8 b605          	ld	a,_flags
3023  02ba a520          	bcp	a,#32
3024  02bc 2714          	jreq	L3261
3025                     ; 331 			led_red=0x00000000L;
3027  02be ae0000        	ldw	x,#0
3028  02c1 bf10          	ldw	_led_red+2,x
3029  02c3 ae0000        	ldw	x,#0
3030  02c6 bf0e          	ldw	_led_red,x
3031                     ; 332 			led_green=0x00030003L;
3033  02c8 ae0003        	ldw	x,#3
3034  02cb bf14          	ldw	_led_green+2,x
3035  02cd ae0003        	ldw	x,#3
3036  02d0 bf12          	ldw	_led_green,x
3037  02d2               L3261:
3038                     ; 335 		if((jp_mode==jp1))
3040  02d2 b654          	ld	a,_jp_mode
3041  02d4 a101          	cp	a,#1
3042  02d6 2618          	jrne	L7661
3043                     ; 337 			led_red=0x00000000L;
3045  02d8 ae0000        	ldw	x,#0
3046  02db bf10          	ldw	_led_red+2,x
3047  02dd ae0000        	ldw	x,#0
3048  02e0 bf0e          	ldw	_led_red,x
3049                     ; 338 			led_green=0x33333333L;
3051  02e2 ae3333        	ldw	x,#13107
3052  02e5 bf14          	ldw	_led_green+2,x
3053  02e7 ae3333        	ldw	x,#13107
3054  02ea bf12          	ldw	_led_green,x
3056  02ec aced03ed      	jpf	L5761
3057  02f0               L7661:
3058                     ; 340 		else if((jp_mode==jp2))
3060  02f0 b654          	ld	a,_jp_mode
3061  02f2 a102          	cp	a,#2
3062  02f4 2703          	jreq	L22
3063  02f6 cc03ed        	jp	L5761
3064  02f9               L22:
3065                     ; 342 			led_red=0xccccccccL;
3067  02f9 aecccc        	ldw	x,#52428
3068  02fc bf10          	ldw	_led_red+2,x
3069  02fe aecccc        	ldw	x,#-13108
3070  0301 bf0e          	ldw	_led_red,x
3071                     ; 343 			led_green=0x00000000L;
3073  0303 ae0000        	ldw	x,#0
3074  0306 bf14          	ldw	_led_green+2,x
3075  0308 ae0000        	ldw	x,#0
3076  030b bf12          	ldw	_led_green,x
3077  030d aced03ed      	jpf	L5761
3078  0311               L7161:
3079                     ; 348 	else if(jp_mode==jp3)
3081  0311 b654          	ld	a,_jp_mode
3082  0313 a103          	cp	a,#3
3083  0315 2703          	jreq	L42
3084  0317 cc03ed        	jp	L5761
3085  031a               L42:
3086                     ; 350 		if(main_cnt1<(5*EE_TZAS))
3088  031a 9c            	rvf
3089  031b be5b          	ldw	x,_main_cnt1
3090  031d a3000f        	cpw	x,#15
3091  0320 2e18          	jrsge	L1071
3092                     ; 352 			led_red=0x00000000L;
3094  0322 ae0000        	ldw	x,#0
3095  0325 bf10          	ldw	_led_red+2,x
3096  0327 ae0000        	ldw	x,#0
3097  032a bf0e          	ldw	_led_red,x
3098                     ; 353 			led_green=0x03030303L;
3100  032c ae0303        	ldw	x,#771
3101  032f bf14          	ldw	_led_green+2,x
3102  0331 ae0303        	ldw	x,#771
3103  0334 bf12          	ldw	_led_green,x
3105  0336 aced03ed      	jpf	L5761
3106  033a               L1071:
3107                     ; 355 		else if((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(70+(5*EE_TZAS))))
3109  033a 9c            	rvf
3110  033b be5b          	ldw	x,_main_cnt1
3111  033d a30010        	cpw	x,#16
3112  0340 2f1f          	jrslt	L5071
3114  0342 9c            	rvf
3115  0343 be5b          	ldw	x,_main_cnt1
3116  0345 a30055        	cpw	x,#85
3117  0348 2e17          	jrsge	L5071
3118                     ; 357 			led_red=0x00000000L;
3120  034a ae0000        	ldw	x,#0
3121  034d bf10          	ldw	_led_red+2,x
3122  034f ae0000        	ldw	x,#0
3123  0352 bf0e          	ldw	_led_red,x
3124                     ; 358 			led_green=0xffffffffL;	
3126  0354 aeffff        	ldw	x,#65535
3127  0357 bf14          	ldw	_led_green+2,x
3128  0359 aeffff        	ldw	x,#-1
3129  035c bf12          	ldw	_led_green,x
3131  035e cc03ed        	jra	L5761
3132  0361               L5071:
3133                     ; 361 		else if((flags&0b00011110)==0)
3135  0361 b605          	ld	a,_flags
3136  0363 a51e          	bcp	a,#30
3137  0365 2616          	jrne	L1171
3138                     ; 363 			led_red=0x00000000L;
3140  0367 ae0000        	ldw	x,#0
3141  036a bf10          	ldw	_led_red+2,x
3142  036c ae0000        	ldw	x,#0
3143  036f bf0e          	ldw	_led_red,x
3144                     ; 364 			led_green=0xffffffffL;
3146  0371 aeffff        	ldw	x,#65535
3147  0374 bf14          	ldw	_led_green+2,x
3148  0376 aeffff        	ldw	x,#-1
3149  0379 bf12          	ldw	_led_green,x
3151  037b 2070          	jra	L5761
3152  037d               L1171:
3153                     ; 368 		else if((flags&0b00111110)==0b00000100)
3155  037d b605          	ld	a,_flags
3156  037f a43e          	and	a,#62
3157  0381 a104          	cp	a,#4
3158  0383 2616          	jrne	L5171
3159                     ; 370 			led_red=0x00010001L;
3161  0385 ae0001        	ldw	x,#1
3162  0388 bf10          	ldw	_led_red+2,x
3163  038a ae0001        	ldw	x,#1
3164  038d bf0e          	ldw	_led_red,x
3165                     ; 371 			led_green=0xffffffffL;	
3167  038f aeffff        	ldw	x,#65535
3168  0392 bf14          	ldw	_led_green+2,x
3169  0394 aeffff        	ldw	x,#-1
3170  0397 bf12          	ldw	_led_green,x
3172  0399 2052          	jra	L5761
3173  039b               L5171:
3174                     ; 373 		else if(flags&0b00000010)
3176  039b b605          	ld	a,_flags
3177  039d a502          	bcp	a,#2
3178  039f 2716          	jreq	L1271
3179                     ; 375 			led_red=0x00010001L;
3181  03a1 ae0001        	ldw	x,#1
3182  03a4 bf10          	ldw	_led_red+2,x
3183  03a6 ae0001        	ldw	x,#1
3184  03a9 bf0e          	ldw	_led_red,x
3185                     ; 376 			led_green=0x00000000L;	
3187  03ab ae0000        	ldw	x,#0
3188  03ae bf14          	ldw	_led_green+2,x
3189  03b0 ae0000        	ldw	x,#0
3190  03b3 bf12          	ldw	_led_green,x
3192  03b5 2036          	jra	L5761
3193  03b7               L1271:
3194                     ; 378 		else if(flags&0b00001000)
3196  03b7 b605          	ld	a,_flags
3197  03b9 a508          	bcp	a,#8
3198  03bb 2716          	jreq	L5271
3199                     ; 380 			led_red=0x00090009L;
3201  03bd ae0009        	ldw	x,#9
3202  03c0 bf10          	ldw	_led_red+2,x
3203  03c2 ae0009        	ldw	x,#9
3204  03c5 bf0e          	ldw	_led_red,x
3205                     ; 381 			led_green=0x00000000L;	
3207  03c7 ae0000        	ldw	x,#0
3208  03ca bf14          	ldw	_led_green+2,x
3209  03cc ae0000        	ldw	x,#0
3210  03cf bf12          	ldw	_led_green,x
3212  03d1 201a          	jra	L5761
3213  03d3               L5271:
3214                     ; 383 		else if(flags&0b00010000)
3216  03d3 b605          	ld	a,_flags
3217  03d5 a510          	bcp	a,#16
3218  03d7 2714          	jreq	L5761
3219                     ; 385 			led_red=0x00490049L;
3221  03d9 ae0049        	ldw	x,#73
3222  03dc bf10          	ldw	_led_red+2,x
3223  03de ae0049        	ldw	x,#73
3224  03e1 bf0e          	ldw	_led_red,x
3225                     ; 386 			led_green=0xffffffffL;	
3227  03e3 aeffff        	ldw	x,#65535
3228  03e6 bf14          	ldw	_led_green+2,x
3229  03e8 aeffff        	ldw	x,#-1
3230  03eb bf12          	ldw	_led_green,x
3231  03ed               L5761:
3232                     ; 546 }
3235  03ed 81            	ret
3263                     ; 549 void led_drv(void)
3263                     ; 550 {
3264                     	switch	.text
3265  03ee               _led_drv:
3269                     ; 552 GPIOA->DDR|=(1<<4);
3271  03ee 72185002      	bset	20482,#4
3272                     ; 553 GPIOA->CR1|=(1<<4);
3274  03f2 72185003      	bset	20483,#4
3275                     ; 554 GPIOA->CR2&=~(1<<4);
3277  03f6 72195004      	bres	20484,#4
3278                     ; 555 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3280  03fa b64a          	ld	a,_led_red_buff+3
3281  03fc a501          	bcp	a,#1
3282  03fe 2706          	jreq	L3471
3285  0400 72185000      	bset	20480,#4
3287  0404 2004          	jra	L5471
3288  0406               L3471:
3289                     ; 556 else GPIOA->ODR&=~(1<<4); 
3291  0406 72195000      	bres	20480,#4
3292  040a               L5471:
3293                     ; 559 GPIOA->DDR|=(1<<5);
3295  040a 721a5002      	bset	20482,#5
3296                     ; 560 GPIOA->CR1|=(1<<5);
3298  040e 721a5003      	bset	20483,#5
3299                     ; 561 GPIOA->CR2&=~(1<<5);	
3301  0412 721b5004      	bres	20484,#5
3302                     ; 562 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3304  0416 b646          	ld	a,_led_green_buff+3
3305  0418 a501          	bcp	a,#1
3306  041a 2706          	jreq	L7471
3309  041c 721a5000      	bset	20480,#5
3311  0420 2004          	jra	L1571
3312  0422               L7471:
3313                     ; 563 else GPIOA->ODR&=~(1<<5);
3315  0422 721b5000      	bres	20480,#5
3316  0426               L1571:
3317                     ; 566 led_red_buff>>=1;
3319  0426 3747          	sra	_led_red_buff
3320  0428 3648          	rrc	_led_red_buff+1
3321  042a 3649          	rrc	_led_red_buff+2
3322  042c 364a          	rrc	_led_red_buff+3
3323                     ; 567 led_green_buff>>=1;
3325  042e 3743          	sra	_led_green_buff
3326  0430 3644          	rrc	_led_green_buff+1
3327  0432 3645          	rrc	_led_green_buff+2
3328  0434 3646          	rrc	_led_green_buff+3
3329                     ; 568 if(++led_drv_cnt>32)
3331  0436 3c16          	inc	_led_drv_cnt
3332  0438 b616          	ld	a,_led_drv_cnt
3333  043a a121          	cp	a,#33
3334  043c 2512          	jrult	L3571
3335                     ; 570 	led_drv_cnt=0;
3337  043e 3f16          	clr	_led_drv_cnt
3338                     ; 571 	led_red_buff=led_red;
3340  0440 be10          	ldw	x,_led_red+2
3341  0442 bf49          	ldw	_led_red_buff+2,x
3342  0444 be0e          	ldw	x,_led_red
3343  0446 bf47          	ldw	_led_red_buff,x
3344                     ; 572 	led_green_buff=led_green;
3346  0448 be14          	ldw	x,_led_green+2
3347  044a bf45          	ldw	_led_green_buff+2,x
3348  044c be12          	ldw	x,_led_green
3349  044e bf43          	ldw	_led_green_buff,x
3350  0450               L3571:
3351                     ; 578 } 
3354  0450 81            	ret
3380                     ; 581 void JP_drv(void)
3380                     ; 582 {
3381                     	switch	.text
3382  0451               _JP_drv:
3386                     ; 584 GPIOD->DDR&=~(1<<6);
3388  0451 721d5011      	bres	20497,#6
3389                     ; 585 GPIOD->CR1|=(1<<6);
3391  0455 721c5012      	bset	20498,#6
3392                     ; 586 GPIOD->CR2&=~(1<<6);
3394  0459 721d5013      	bres	20499,#6
3395                     ; 588 GPIOD->DDR&=~(1<<7);
3397  045d 721f5011      	bres	20497,#7
3398                     ; 589 GPIOD->CR1|=(1<<7);
3400  0461 721e5012      	bset	20498,#7
3401                     ; 590 GPIOD->CR2&=~(1<<7);
3403  0465 721f5013      	bres	20499,#7
3404                     ; 592 if(GPIOD->IDR&(1<<6))
3406  0469 c65010        	ld	a,20496
3407  046c a540          	bcp	a,#64
3408  046e 270a          	jreq	L5671
3409                     ; 594 	if(cnt_JP0<10)
3411  0470 b653          	ld	a,_cnt_JP0
3412  0472 a10a          	cp	a,#10
3413  0474 2411          	jruge	L1771
3414                     ; 596 		cnt_JP0++;
3416  0476 3c53          	inc	_cnt_JP0
3417  0478 200d          	jra	L1771
3418  047a               L5671:
3419                     ; 599 else if(!(GPIOD->IDR&(1<<6)))
3421  047a c65010        	ld	a,20496
3422  047d a540          	bcp	a,#64
3423  047f 2606          	jrne	L1771
3424                     ; 601 	if(cnt_JP0)
3426  0481 3d53          	tnz	_cnt_JP0
3427  0483 2702          	jreq	L1771
3428                     ; 603 		cnt_JP0--;
3430  0485 3a53          	dec	_cnt_JP0
3431  0487               L1771:
3432                     ; 607 if(GPIOD->IDR&(1<<7))
3434  0487 c65010        	ld	a,20496
3435  048a a580          	bcp	a,#128
3436  048c 270a          	jreq	L7771
3437                     ; 609 	if(cnt_JP1<10)
3439  048e b652          	ld	a,_cnt_JP1
3440  0490 a10a          	cp	a,#10
3441  0492 2411          	jruge	L3002
3442                     ; 611 		cnt_JP1++;
3444  0494 3c52          	inc	_cnt_JP1
3445  0496 200d          	jra	L3002
3446  0498               L7771:
3447                     ; 614 else if(!(GPIOD->IDR&(1<<7)))
3449  0498 c65010        	ld	a,20496
3450  049b a580          	bcp	a,#128
3451  049d 2606          	jrne	L3002
3452                     ; 616 	if(cnt_JP1)
3454  049f 3d52          	tnz	_cnt_JP1
3455  04a1 2702          	jreq	L3002
3456                     ; 618 		cnt_JP1--;
3458  04a3 3a52          	dec	_cnt_JP1
3459  04a5               L3002:
3460                     ; 623 if((cnt_JP0==10)&&(cnt_JP1==10))
3462  04a5 b653          	ld	a,_cnt_JP0
3463  04a7 a10a          	cp	a,#10
3464  04a9 2608          	jrne	L1102
3466  04ab b652          	ld	a,_cnt_JP1
3467  04ad a10a          	cp	a,#10
3468  04af 2602          	jrne	L1102
3469                     ; 625 	jp_mode=jp0;
3471  04b1 3f54          	clr	_jp_mode
3472  04b3               L1102:
3473                     ; 627 if((cnt_JP0==0)&&(cnt_JP1==10))
3475  04b3 3d53          	tnz	_cnt_JP0
3476  04b5 260a          	jrne	L3102
3478  04b7 b652          	ld	a,_cnt_JP1
3479  04b9 a10a          	cp	a,#10
3480  04bb 2604          	jrne	L3102
3481                     ; 629 	jp_mode=jp1;
3483  04bd 35010054      	mov	_jp_mode,#1
3484  04c1               L3102:
3485                     ; 631 if((cnt_JP0==10)&&(cnt_JP1==0))
3487  04c1 b653          	ld	a,_cnt_JP0
3488  04c3 a10a          	cp	a,#10
3489  04c5 2608          	jrne	L5102
3491  04c7 3d52          	tnz	_cnt_JP1
3492  04c9 2604          	jrne	L5102
3493                     ; 633 	jp_mode=jp2;
3495  04cb 35020054      	mov	_jp_mode,#2
3496  04cf               L5102:
3497                     ; 635 if((cnt_JP0==0)&&(cnt_JP1==0))
3499  04cf 3d53          	tnz	_cnt_JP0
3500  04d1 2608          	jrne	L7102
3502  04d3 3d52          	tnz	_cnt_JP1
3503  04d5 2604          	jrne	L7102
3504                     ; 637 	jp_mode=jp3;
3506  04d7 35030054      	mov	_jp_mode,#3
3507  04db               L7102:
3508                     ; 640 }
3511  04db 81            	ret
3543                     ; 643 void link_drv(void)		//10Hz
3543                     ; 644 {
3544                     	switch	.text
3545  04dc               _link_drv:
3549                     ; 645 if(jp_mode!=jp3)
3551  04dc b654          	ld	a,_jp_mode
3552  04de a103          	cp	a,#3
3553  04e0 274d          	jreq	L1302
3554                     ; 647 	if(link_cnt<602)link_cnt++;
3556  04e2 9c            	rvf
3557  04e3 be6b          	ldw	x,_link_cnt
3558  04e5 a3025a        	cpw	x,#602
3559  04e8 2e07          	jrsge	L3302
3562  04ea be6b          	ldw	x,_link_cnt
3563  04ec 1c0001        	addw	x,#1
3564  04ef bf6b          	ldw	_link_cnt,x
3565  04f1               L3302:
3566                     ; 648 	if(link_cnt==90)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
3568  04f1 be6b          	ldw	x,_link_cnt
3569  04f3 a3005a        	cpw	x,#90
3570  04f6 2606          	jrne	L5302
3573  04f8 b605          	ld	a,_flags
3574  04fa a4c1          	and	a,#193
3575  04fc b705          	ld	_flags,a
3576  04fe               L5302:
3577                     ; 649 	if(link_cnt==100)
3579  04fe be6b          	ldw	x,_link_cnt
3580  0500 a30064        	cpw	x,#100
3581  0503 262e          	jrne	L7402
3582                     ; 651 		link=OFF;
3584  0505 35aa006d      	mov	_link,#170
3585                     ; 656 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
3587  0509 b60b          	ld	a,_bps_class
3588  050b a101          	cp	a,#1
3589  050d 2606          	jrne	L1402
3592  050f 72100001      	bset	_bMAIN
3594  0513 2004          	jra	L3402
3595  0515               L1402:
3596                     ; 657 		else bMAIN=0;
3598  0515 72110001      	bres	_bMAIN
3599  0519               L3402:
3600                     ; 659 		cnt_net_drv=0;
3602  0519 3f3c          	clr	_cnt_net_drv
3603                     ; 660     		if(!res_fl_)
3605  051b 725d000a      	tnz	_res_fl_
3606  051f 2612          	jrne	L7402
3607                     ; 662 	    		bRES_=1;
3609  0521 3501000d      	mov	_bRES_,#1
3610                     ; 663 	    		res_fl_=1;
3612  0525 a601          	ld	a,#1
3613  0527 ae000a        	ldw	x,#_res_fl_
3614  052a cd0000        	call	c_eewrc
3616  052d 2004          	jra	L7402
3617  052f               L1302:
3618                     ; 667 else link=OFF;	
3620  052f 35aa006d      	mov	_link,#170
3621  0533               L7402:
3622                     ; 668 } 
3625  0533 81            	ret
3694                     	switch	.const
3695  0004               L63:
3696  0004 00000064      	dc.l	100
3697  0008               L04:
3698  0008 00000bb9      	dc.l	3001
3699  000c               L24:
3700  000c 0000012c      	dc.l	300
3701  0010               L44:
3702  0010 00000004      	dc.l	4
3703                     ; 672 void vent_drv(void)
3703                     ; 673 {
3704                     	switch	.text
3705  0534               _vent_drv:
3707  0534 520c          	subw	sp,#12
3708       0000000c      OFST:	set	12
3711                     ; 676 	short vent_pwm_i_necc=400;
3713  0536 ae0190        	ldw	x,#400
3714  0539 1f05          	ldw	(OFST-7,sp),x
3715                     ; 677 	short vent_pwm_t_necc=400;
3717  053b ae0190        	ldw	x,#400
3718  053e 1f07          	ldw	(OFST-5,sp),x
3719                     ; 678 	short vent_pwm_max_necc=400;
3721                     ; 684 	tempSL=(signed long)I;
3723  0540 ce0010        	ldw	x,_I
3724  0543 cd0000        	call	c_itolx
3726  0546 96            	ldw	x,sp
3727  0547 1c0009        	addw	x,#OFST-3
3728  054a cd0000        	call	c_rtol
3730                     ; 685 	tempSL*=(signed long)Ui;
3732  054d ce000c        	ldw	x,_Ui
3733  0550 cd0000        	call	c_itolx
3735  0553 96            	ldw	x,sp
3736  0554 1c0009        	addw	x,#OFST-3
3737  0557 cd0000        	call	c_lgmul
3739                     ; 686 	tempSL/=100L;
3741  055a 96            	ldw	x,sp
3742  055b 1c0009        	addw	x,#OFST-3
3743  055e cd0000        	call	c_ltor
3745  0561 ae0004        	ldw	x,#L63
3746  0564 cd0000        	call	c_ldiv
3748  0567 96            	ldw	x,sp
3749  0568 1c0009        	addw	x,#OFST-3
3750  056b cd0000        	call	c_rtol
3752                     ; 694 	if(tempSL>3000L)vent_pwm_i_necc=1000;
3754  056e 9c            	rvf
3755  056f 96            	ldw	x,sp
3756  0570 1c0009        	addw	x,#OFST-3
3757  0573 cd0000        	call	c_ltor
3759  0576 ae0008        	ldw	x,#L04
3760  0579 cd0000        	call	c_lcmp
3762  057c 2f07          	jrslt	L3012
3765  057e ae03e8        	ldw	x,#1000
3766  0581 1f05          	ldw	(OFST-7,sp),x
3768  0583 2032          	jra	L5012
3769  0585               L3012:
3770                     ; 695 	else if(tempSL<300L)vent_pwm_i_necc=0;
3772  0585 9c            	rvf
3773  0586 96            	ldw	x,sp
3774  0587 1c0009        	addw	x,#OFST-3
3775  058a cd0000        	call	c_ltor
3777  058d ae000c        	ldw	x,#L24
3778  0590 cd0000        	call	c_lcmp
3780  0593 2e05          	jrsge	L7012
3783  0595 5f            	clrw	x
3784  0596 1f05          	ldw	(OFST-7,sp),x
3786  0598 201d          	jra	L5012
3787  059a               L7012:
3788                     ; 696 	else vent_pwm_i_necc=(short)(300L + ((tempSL-300L)/4L));
3790  059a 96            	ldw	x,sp
3791  059b 1c0009        	addw	x,#OFST-3
3792  059e cd0000        	call	c_ltor
3794  05a1 ae000c        	ldw	x,#L24
3795  05a4 cd0000        	call	c_lsub
3797  05a7 ae0010        	ldw	x,#L44
3798  05aa cd0000        	call	c_ldiv
3800  05ad ae000c        	ldw	x,#L24
3801  05b0 cd0000        	call	c_ladd
3803  05b3 be02          	ldw	x,c_lreg+2
3804  05b5 1f05          	ldw	(OFST-7,sp),x
3805  05b7               L5012:
3806                     ; 697 	gran(&vent_pwm_i_necc,0,1000);
3808  05b7 ae03e8        	ldw	x,#1000
3809  05ba 89            	pushw	x
3810  05bb 5f            	clrw	x
3811  05bc 89            	pushw	x
3812  05bd 96            	ldw	x,sp
3813  05be 1c0009        	addw	x,#OFST-3
3814  05c1 cd00d5        	call	_gran
3816  05c4 5b04          	addw	sp,#4
3817                     ; 699 	tempSL=(signed long)T;
3819  05c6 b672          	ld	a,_T
3820  05c8 b703          	ld	c_lreg+3,a
3821  05ca 48            	sll	a
3822  05cb 4f            	clr	a
3823  05cc a200          	sbc	a,#0
3824  05ce b702          	ld	c_lreg+2,a
3825  05d0 b701          	ld	c_lreg+1,a
3826  05d2 b700          	ld	c_lreg,a
3827  05d4 96            	ldw	x,sp
3828  05d5 1c0009        	addw	x,#OFST-3
3829  05d8 cd0000        	call	c_rtol
3831                     ; 700 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
3833  05db 9c            	rvf
3834  05dc ce000e        	ldw	x,_ee_tsign
3835  05df cd0000        	call	c_itolx
3837  05e2 a61e          	ld	a,#30
3838  05e4 cd0000        	call	c_lsbc
3840  05e7 96            	ldw	x,sp
3841  05e8 1c0009        	addw	x,#OFST-3
3842  05eb cd0000        	call	c_lcmp
3844  05ee 2f05          	jrslt	L3112
3847  05f0 5f            	clrw	x
3848  05f1 1f07          	ldw	(OFST-5,sp),x
3850  05f3 2030          	jra	L5112
3851  05f5               L3112:
3852                     ; 701 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
3854  05f5 9c            	rvf
3855  05f6 ce000e        	ldw	x,_ee_tsign
3856  05f9 cd0000        	call	c_itolx
3858  05fc 96            	ldw	x,sp
3859  05fd 1c0009        	addw	x,#OFST-3
3860  0600 cd0000        	call	c_lcmp
3862  0603 2c07          	jrsgt	L7112
3865  0605 ae03e8        	ldw	x,#1000
3866  0608 1f07          	ldw	(OFST-5,sp),x
3868  060a 2019          	jra	L5112
3869  060c               L7112:
3870                     ; 702 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
3872  060c ce000e        	ldw	x,_ee_tsign
3873  060f 1d001e        	subw	x,#30
3874  0612 1f01          	ldw	(OFST-11,sp),x
3875  0614 1e0b          	ldw	x,(OFST-1,sp)
3876  0616 72f001        	subw	x,(OFST-11,sp)
3877  0619 90ae0014      	ldw	y,#20
3878  061d cd0000        	call	c_imul
3880  0620 1c0190        	addw	x,#400
3881  0623 1f07          	ldw	(OFST-5,sp),x
3882  0625               L5112:
3883                     ; 703 	gran(&vent_pwm_t_necc,0,1000);
3885  0625 ae03e8        	ldw	x,#1000
3886  0628 89            	pushw	x
3887  0629 5f            	clrw	x
3888  062a 89            	pushw	x
3889  062b 96            	ldw	x,sp
3890  062c 1c000b        	addw	x,#OFST-1
3891  062f cd00d5        	call	_gran
3893  0632 5b04          	addw	sp,#4
3894                     ; 705 	vent_pwm_max_necc=vent_pwm_i_necc;
3896  0634 1e05          	ldw	x,(OFST-7,sp)
3897  0636 1f03          	ldw	(OFST-9,sp),x
3898                     ; 706 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3900  0638 9c            	rvf
3901  0639 1e07          	ldw	x,(OFST-5,sp)
3902  063b 1305          	cpw	x,(OFST-7,sp)
3903  063d 2d04          	jrsle	L3212
3906  063f 1e07          	ldw	x,(OFST-5,sp)
3907  0641 1f03          	ldw	(OFST-9,sp),x
3908  0643               L3212:
3909                     ; 708 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3911  0643 9c            	rvf
3912  0644 be10          	ldw	x,_vent_pwm
3913  0646 1303          	cpw	x,(OFST-9,sp)
3914  0648 2e07          	jrsge	L5212
3917  064a be10          	ldw	x,_vent_pwm
3918  064c 1c000a        	addw	x,#10
3919  064f bf10          	ldw	_vent_pwm,x
3920  0651               L5212:
3921                     ; 709 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3923  0651 9c            	rvf
3924  0652 be10          	ldw	x,_vent_pwm
3925  0654 1303          	cpw	x,(OFST-9,sp)
3926  0656 2d07          	jrsle	L7212
3929  0658 be10          	ldw	x,_vent_pwm
3930  065a 1d000a        	subw	x,#10
3931  065d bf10          	ldw	_vent_pwm,x
3932  065f               L7212:
3933                     ; 710 	gran(&vent_pwm,0,1000);
3935  065f ae03e8        	ldw	x,#1000
3936  0662 89            	pushw	x
3937  0663 5f            	clrw	x
3938  0664 89            	pushw	x
3939  0665 ae0010        	ldw	x,#_vent_pwm
3940  0668 cd00d5        	call	_gran
3942  066b 5b04          	addw	sp,#4
3943                     ; 715 	if(vent_pwm_integr_cnt<10)
3945  066d 9c            	rvf
3946  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3947  0670 a3000a        	cpw	x,#10
3948  0673 2e26          	jrsge	L1312
3949                     ; 717 		vent_pwm_integr_cnt++;
3951  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3952  0677 1c0001        	addw	x,#1
3953  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3954                     ; 718 		if(vent_pwm_integr_cnt>=10)
3956  067c 9c            	rvf
3957  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3958  067f a3000a        	cpw	x,#10
3959  0682 2f17          	jrslt	L1312
3960                     ; 720 			vent_pwm_integr_cnt=0;
3962  0684 5f            	clrw	x
3963  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3964                     ; 721 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3966  0687 be0e          	ldw	x,_vent_pwm_integr
3967  0689 90ae0009      	ldw	y,#9
3968  068d cd0000        	call	c_imul
3970  0690 72bb0010      	addw	x,_vent_pwm
3971  0694 a60a          	ld	a,#10
3972  0696 cd0000        	call	c_sdivx
3974  0699 bf0e          	ldw	_vent_pwm_integr,x
3975  069b               L1312:
3976                     ; 724 	gran(&vent_pwm_integr,0,1000);
3978  069b ae03e8        	ldw	x,#1000
3979  069e 89            	pushw	x
3980  069f 5f            	clrw	x
3981  06a0 89            	pushw	x
3982  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3983  06a4 cd00d5        	call	_gran
3985  06a7 5b04          	addw	sp,#4
3986                     ; 728 }
3989  06a9 5b0c          	addw	sp,#12
3990  06ab 81            	ret
4017                     ; 733 void pwr_drv(void)
4017                     ; 734 {
4018                     	switch	.text
4019  06ac               _pwr_drv:
4023                     ; 795 gran(&pwm_u,0,1020);
4025  06ac ae03fc        	ldw	x,#1020
4026  06af 89            	pushw	x
4027  06b0 5f            	clrw	x
4028  06b1 89            	pushw	x
4029  06b2 ae0008        	ldw	x,#_pwm_u
4030  06b5 cd00d5        	call	_gran
4032  06b8 5b04          	addw	sp,#4
4033                     ; 805 TIM1->CCR2H= (char)(pwm_u/256);	
4035  06ba be08          	ldw	x,_pwm_u
4036  06bc 90ae0100      	ldw	y,#256
4037  06c0 cd0000        	call	c_idiv
4039  06c3 9f            	ld	a,xl
4040  06c4 c75267        	ld	21095,a
4041                     ; 806 TIM1->CCR2L= (char)pwm_u;
4043  06c7 5500095268    	mov	21096,_pwm_u+1
4044                     ; 808 TIM1->CCR1H= (char)(pwm_i/256);	
4046  06cc be0a          	ldw	x,_pwm_i
4047  06ce 90ae0100      	ldw	y,#256
4048  06d2 cd0000        	call	c_idiv
4050  06d5 9f            	ld	a,xl
4051  06d6 c75265        	ld	21093,a
4052                     ; 809 TIM1->CCR1L= (char)pwm_i;
4054  06d9 55000b5266    	mov	21094,_pwm_i+1
4055                     ; 811 TIM1->CCR3H= (char)(vent_pwm_integr/256);	
4057  06de be0e          	ldw	x,_vent_pwm_integr
4058  06e0 90ae0100      	ldw	y,#256
4059  06e4 cd0000        	call	c_idiv
4061  06e7 9f            	ld	a,xl
4062  06e8 c75269        	ld	21097,a
4063                     ; 812 TIM1->CCR3L= (char)vent_pwm_integr;
4065  06eb 55000f526a    	mov	21098,_vent_pwm_integr+1
4066                     ; 813 }
4069  06f0 81            	ret
4127                     	switch	.const
4128  0014               L25:
4129  0014 0000028a      	dc.l	650
4130                     ; 818 void pwr_hndl(void)				
4130                     ; 819 {
4131                     	switch	.text
4132  06f1               _pwr_hndl:
4134  06f1 5205          	subw	sp,#5
4135       00000005      OFST:	set	5
4138                     ; 820 if(jp_mode==jp3)
4140  06f3 b654          	ld	a,_jp_mode
4141  06f5 a103          	cp	a,#3
4142  06f7 260a          	jrne	L7612
4143                     ; 822 	pwm_u=0;
4145  06f9 5f            	clrw	x
4146  06fa bf08          	ldw	_pwm_u,x
4147                     ; 823 	pwm_i=0;
4149  06fc 5f            	clrw	x
4150  06fd bf0a          	ldw	_pwm_i,x
4152  06ff ac4c084c      	jpf	L1712
4153  0703               L7612:
4154                     ; 825 else if(jp_mode==jp2)
4156  0703 b654          	ld	a,_jp_mode
4157  0705 a102          	cp	a,#2
4158  0707 260c          	jrne	L3712
4159                     ; 827 	pwm_u=0;
4161  0709 5f            	clrw	x
4162  070a bf08          	ldw	_pwm_u,x
4163                     ; 828 	pwm_i=0x3ff;
4165  070c ae03ff        	ldw	x,#1023
4166  070f bf0a          	ldw	_pwm_i,x
4168  0711 ac4c084c      	jpf	L1712
4169  0715               L3712:
4170                     ; 830 else if(jp_mode==jp1)
4172  0715 b654          	ld	a,_jp_mode
4173  0717 a101          	cp	a,#1
4174  0719 260e          	jrne	L7712
4175                     ; 832 	pwm_u=0x3ff;
4177  071b ae03ff        	ldw	x,#1023
4178  071e bf08          	ldw	_pwm_u,x
4179                     ; 833 	pwm_i=0x3ff;
4181  0720 ae03ff        	ldw	x,#1023
4182  0723 bf0a          	ldw	_pwm_i,x
4184  0725 ac4c084c      	jpf	L1712
4185  0729               L7712:
4186                     ; 844 else if(link==OFF)
4188  0729 b66d          	ld	a,_link
4189  072b a1aa          	cp	a,#170
4190  072d 2703          	jreq	L45
4191  072f cc07d4        	jp	L3022
4192  0732               L45:
4193                     ; 846 	pwm_i=0x3ff;
4195  0732 ae03ff        	ldw	x,#1023
4196  0735 bf0a          	ldw	_pwm_i,x
4197                     ; 847 	pwm_u_=(short)((1000L*((long)Unecc))/650L);
4199  0737 ce000a        	ldw	x,_Unecc
4200  073a 90ae03e8      	ldw	y,#1000
4201  073e cd0000        	call	c_vmul
4203  0741 ae0014        	ldw	x,#L25
4204  0744 cd0000        	call	c_ldiv
4206  0747 be02          	ldw	x,c_lreg+2
4207  0749 bf55          	ldw	_pwm_u_,x
4208                     ; 849 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4210  074b c60013        	ld	a,_pwm_u_buff_ptr
4211  074e 5f            	clrw	x
4212  074f 97            	ld	xl,a
4213  0750 58            	sllw	x
4214  0751 90be55        	ldw	y,_pwm_u_
4215  0754 df0016        	ldw	(_pwm_u_buff,x),y
4216                     ; 850 	pwm_u_buff_ptr++;
4218  0757 725c0013      	inc	_pwm_u_buff_ptr
4219                     ; 851 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4221  075b c60013        	ld	a,_pwm_u_buff_ptr
4222  075e a110          	cp	a,#16
4223  0760 2504          	jrult	L5022
4226  0762 725f0013      	clr	_pwm_u_buff_ptr
4227  0766               L5022:
4228                     ; 855 		tempSL=0;
4230  0766 ae0000        	ldw	x,#0
4231  0769 1f03          	ldw	(OFST-2,sp),x
4232  076b ae0000        	ldw	x,#0
4233  076e 1f01          	ldw	(OFST-4,sp),x
4234                     ; 856 		for(i=0;i<16;i++)
4236  0770 0f05          	clr	(OFST+0,sp)
4237  0772               L7022:
4238                     ; 858 			tempSL+=(signed long)pwm_u_buff[i];
4240  0772 7b05          	ld	a,(OFST+0,sp)
4241  0774 5f            	clrw	x
4242  0775 97            	ld	xl,a
4243  0776 58            	sllw	x
4244  0777 de0016        	ldw	x,(_pwm_u_buff,x)
4245  077a cd0000        	call	c_itolx
4247  077d 96            	ldw	x,sp
4248  077e 1c0001        	addw	x,#OFST-4
4249  0781 cd0000        	call	c_lgadd
4251                     ; 856 		for(i=0;i<16;i++)
4253  0784 0c05          	inc	(OFST+0,sp)
4256  0786 7b05          	ld	a,(OFST+0,sp)
4257  0788 a110          	cp	a,#16
4258  078a 25e6          	jrult	L7022
4259                     ; 860 		tempSL>>=4;
4261  078c 96            	ldw	x,sp
4262  078d 1c0001        	addw	x,#OFST-4
4263  0790 a604          	ld	a,#4
4264  0792 cd0000        	call	c_lgrsh
4266                     ; 861 		pwm_u_buff_=(signed short)tempSL;
4268  0795 1e03          	ldw	x,(OFST-2,sp)
4269  0797 cf0014        	ldw	_pwm_u_buff_,x
4270                     ; 863 	pwm_u=pwm_u_;
4272  079a be55          	ldw	x,_pwm_u_
4273  079c bf08          	ldw	_pwm_u,x
4274                     ; 864 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4276  079e 9c            	rvf
4277  079f ce000c        	ldw	x,_Ui
4278  07a2 72b0000a      	subw	x,_Unecc
4279  07a6 cd0000        	call	_abs
4281  07a9 a30014        	cpw	x,#20
4282  07ac 2e06          	jrsge	L5122
4285  07ae 725c0012      	inc	_pwm_u_buff_cnt
4287  07b2 2004          	jra	L7122
4288  07b4               L5122:
4289                     ; 865 	else pwm_u_buff_cnt=0;
4291  07b4 725f0012      	clr	_pwm_u_buff_cnt
4292  07b8               L7122:
4293                     ; 867 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4295  07b8 c60012        	ld	a,_pwm_u_buff_cnt
4296  07bb a114          	cp	a,#20
4297  07bd 2504          	jrult	L1222
4300  07bf 35140012      	mov	_pwm_u_buff_cnt,#20
4301  07c3               L1222:
4302                     ; 868 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4304  07c3 c60012        	ld	a,_pwm_u_buff_cnt
4305  07c6 a10f          	cp	a,#15
4306  07c8 2403          	jruge	L65
4307  07ca cc084c        	jp	L1712
4308  07cd               L65:
4311  07cd ce0014        	ldw	x,_pwm_u_buff_
4312  07d0 bf08          	ldw	_pwm_u,x
4313  07d2 2078          	jra	L1712
4314  07d4               L3022:
4315                     ; 871 else	if(link==ON)				//если есть связьvol_i_temp_avar
4317  07d4 b66d          	ld	a,_link
4318  07d6 a155          	cp	a,#85
4319  07d8 2672          	jrne	L1712
4320                     ; 873 	if((flags&0b00100000)==0)	//если нет блокировки извне
4322  07da b605          	ld	a,_flags
4323  07dc a520          	bcp	a,#32
4324  07de 2660          	jrne	L1322
4325                     ; 875 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4327  07e0 b605          	ld	a,_flags
4328  07e2 a51a          	bcp	a,#26
4329  07e4 260b          	jrne	L3322
4330                     ; 877 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4332  07e6 be60          	ldw	x,_vol_i_temp
4333  07e8 bf08          	ldw	_pwm_u,x
4334                     ; 878 			pwm_i=1000;
4336  07ea ae03e8        	ldw	x,#1000
4337  07ed bf0a          	ldw	_pwm_i,x
4339  07ef 200c          	jra	L5322
4340  07f1               L3322:
4341                     ; 880 		else if(flags&0b00011010)					//если есть аварии
4343  07f1 b605          	ld	a,_flags
4344  07f3 a51a          	bcp	a,#26
4345  07f5 2706          	jreq	L5322
4346                     ; 882 			pwm_u=0;								//то полный стоп
4348  07f7 5f            	clrw	x
4349  07f8 bf08          	ldw	_pwm_u,x
4350                     ; 883 			pwm_i=0;
4352  07fa 5f            	clrw	x
4353  07fb bf0a          	ldw	_pwm_i,x
4354  07fd               L5322:
4355                     ; 886 		if(vol_i_temp==1000)
4357  07fd be60          	ldw	x,_vol_i_temp
4358  07ff a303e8        	cpw	x,#1000
4359  0802 260c          	jrne	L1422
4360                     ; 888 			pwm_u=1000;
4362  0804 ae03e8        	ldw	x,#1000
4363  0807 bf08          	ldw	_pwm_u,x
4364                     ; 889 			pwm_i=1000;
4366  0809 ae03e8        	ldw	x,#1000
4367  080c bf0a          	ldw	_pwm_i,x
4369  080e 2014          	jra	L3422
4370  0810               L1422:
4371                     ; 893 			if((abs((int)(Ui-Unecc)))>50)	pwm_u_cnt=19;
4373  0810 9c            	rvf
4374  0811 ce000c        	ldw	x,_Ui
4375  0814 72b0000a      	subw	x,_Unecc
4376  0818 cd0000        	call	_abs
4378  081b a30033        	cpw	x,#51
4379  081e 2f04          	jrslt	L3422
4382  0820 35130007      	mov	_pwm_u_cnt,#19
4383  0824               L3422:
4384                     ; 896 		if(pwm_u_cnt)
4386  0824 3d07          	tnz	_pwm_u_cnt
4387  0826 2724          	jreq	L1712
4388                     ; 898 			pwm_u_cnt--;
4390  0828 3a07          	dec	_pwm_u_cnt
4391                     ; 899 			pwm_u=(short)((1000L*((long)Unecc))/650L);
4393  082a ce000a        	ldw	x,_Unecc
4394  082d 90ae03e8      	ldw	y,#1000
4395  0831 cd0000        	call	c_vmul
4397  0834 ae0014        	ldw	x,#L25
4398  0837 cd0000        	call	c_ldiv
4400  083a be02          	ldw	x,c_lreg+2
4401  083c bf08          	ldw	_pwm_u,x
4402  083e 200c          	jra	L1712
4403  0840               L1322:
4404                     ; 902 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4406  0840 b605          	ld	a,_flags
4407  0842 a520          	bcp	a,#32
4408  0844 2706          	jreq	L1712
4409                     ; 904 		pwm_u=0;
4411  0846 5f            	clrw	x
4412  0847 bf08          	ldw	_pwm_u,x
4413                     ; 905 		pwm_i=0;
4415  0849 5f            	clrw	x
4416  084a bf0a          	ldw	_pwm_i,x
4417  084c               L1712:
4418                     ; 933 if(pwm_u>1000)pwm_u=1000;
4420  084c 9c            	rvf
4421  084d be08          	ldw	x,_pwm_u
4422  084f a303e9        	cpw	x,#1001
4423  0852 2f05          	jrslt	L5522
4426  0854 ae03e8        	ldw	x,#1000
4427  0857 bf08          	ldw	_pwm_u,x
4428  0859               L5522:
4429                     ; 934 if(pwm_i>1000)pwm_i=1000;
4431  0859 9c            	rvf
4432  085a be0a          	ldw	x,_pwm_i
4433  085c a303e9        	cpw	x,#1001
4434  085f 2f05          	jrslt	L7522
4437  0861 ae03e8        	ldw	x,#1000
4438  0864 bf0a          	ldw	_pwm_i,x
4439  0866               L7522:
4440                     ; 937 }
4443  0866 5b05          	addw	sp,#5
4444  0868 81            	ret
4497                     	switch	.const
4498  0018               L26:
4499  0018 00000258      	dc.l	600
4500  001c               L46:
4501  001c 000003e8      	dc.l	1000
4502  0020               L66:
4503  0020 00000708      	dc.l	1800
4504                     ; 940 void matemat(void)
4504                     ; 941 {
4505                     	switch	.text
4506  0869               _matemat:
4508  0869 5208          	subw	sp,#8
4509       00000008      OFST:	set	8
4512                     ; 965 I=adc_buff_[4];
4514  086b ce0107        	ldw	x,_adc_buff_+8
4515  086e cf0010        	ldw	_I,x
4516                     ; 966 temp_SL=adc_buff_[4];
4518  0871 ce0107        	ldw	x,_adc_buff_+8
4519  0874 cd0000        	call	c_itolx
4521  0877 96            	ldw	x,sp
4522  0878 1c0005        	addw	x,#OFST-3
4523  087b cd0000        	call	c_rtol
4525                     ; 967 temp_SL-=ee_K[0][0];
4527  087e ce001a        	ldw	x,_ee_K
4528  0881 cd0000        	call	c_itolx
4530  0884 96            	ldw	x,sp
4531  0885 1c0005        	addw	x,#OFST-3
4532  0888 cd0000        	call	c_lgsub
4534                     ; 968 if(temp_SL<0) temp_SL=0;
4536  088b 9c            	rvf
4537  088c 0d05          	tnz	(OFST-3,sp)
4538  088e 2e0a          	jrsge	L7722
4541  0890 ae0000        	ldw	x,#0
4542  0893 1f07          	ldw	(OFST-1,sp),x
4543  0895 ae0000        	ldw	x,#0
4544  0898 1f05          	ldw	(OFST-3,sp),x
4545  089a               L7722:
4546                     ; 969 temp_SL*=ee_K[0][1];
4548  089a ce001c        	ldw	x,_ee_K+2
4549  089d cd0000        	call	c_itolx
4551  08a0 96            	ldw	x,sp
4552  08a1 1c0005        	addw	x,#OFST-3
4553  08a4 cd0000        	call	c_lgmul
4555                     ; 970 temp_SL/=600;
4557  08a7 96            	ldw	x,sp
4558  08a8 1c0005        	addw	x,#OFST-3
4559  08ab cd0000        	call	c_ltor
4561  08ae ae0018        	ldw	x,#L26
4562  08b1 cd0000        	call	c_ldiv
4564  08b4 96            	ldw	x,sp
4565  08b5 1c0005        	addw	x,#OFST-3
4566  08b8 cd0000        	call	c_rtol
4568                     ; 971 I=(signed short)temp_SL;
4570  08bb 1e07          	ldw	x,(OFST-1,sp)
4571  08bd cf0010        	ldw	_I,x
4572                     ; 974 temp_SL=(signed long)adc_buff_[1];//1;
4574                     ; 975 temp_SL=(signed long)adc_buff_[3];//1;
4576  08c0 ce0105        	ldw	x,_adc_buff_+6
4577  08c3 cd0000        	call	c_itolx
4579  08c6 96            	ldw	x,sp
4580  08c7 1c0005        	addw	x,#OFST-3
4581  08ca cd0000        	call	c_rtol
4583                     ; 977 if(temp_SL<0) temp_SL=0;
4585  08cd 9c            	rvf
4586  08ce 0d05          	tnz	(OFST-3,sp)
4587  08d0 2e0a          	jrsge	L1032
4590  08d2 ae0000        	ldw	x,#0
4591  08d5 1f07          	ldw	(OFST-1,sp),x
4592  08d7 ae0000        	ldw	x,#0
4593  08da 1f05          	ldw	(OFST-3,sp),x
4594  08dc               L1032:
4595                     ; 978 temp_SL*=(signed long)ee_K[2][1];
4597  08dc ce0024        	ldw	x,_ee_K+10
4598  08df cd0000        	call	c_itolx
4600  08e2 96            	ldw	x,sp
4601  08e3 1c0005        	addw	x,#OFST-3
4602  08e6 cd0000        	call	c_lgmul
4604                     ; 979 temp_SL/=1000L;
4606  08e9 96            	ldw	x,sp
4607  08ea 1c0005        	addw	x,#OFST-3
4608  08ed cd0000        	call	c_ltor
4610  08f0 ae001c        	ldw	x,#L46
4611  08f3 cd0000        	call	c_ldiv
4613  08f6 96            	ldw	x,sp
4614  08f7 1c0005        	addw	x,#OFST-3
4615  08fa cd0000        	call	c_rtol
4617                     ; 980 Ui=(unsigned short)temp_SL;
4619  08fd 1e07          	ldw	x,(OFST-1,sp)
4620  08ff cf000c        	ldw	_Ui,x
4621                     ; 982 temp_SL=(signed long)adc_buff_5;
4623  0902 ce00fd        	ldw	x,_adc_buff_5
4624  0905 cd0000        	call	c_itolx
4626  0908 96            	ldw	x,sp
4627  0909 1c0005        	addw	x,#OFST-3
4628  090c cd0000        	call	c_rtol
4630                     ; 984 if(temp_SL<0) temp_SL=0;
4632  090f 9c            	rvf
4633  0910 0d05          	tnz	(OFST-3,sp)
4634  0912 2e0a          	jrsge	L3032
4637  0914 ae0000        	ldw	x,#0
4638  0917 1f07          	ldw	(OFST-1,sp),x
4639  0919 ae0000        	ldw	x,#0
4640  091c 1f05          	ldw	(OFST-3,sp),x
4641  091e               L3032:
4642                     ; 985 temp_SL*=(signed long)ee_K[4][1];
4644  091e ce002c        	ldw	x,_ee_K+18
4645  0921 cd0000        	call	c_itolx
4647  0924 96            	ldw	x,sp
4648  0925 1c0005        	addw	x,#OFST-3
4649  0928 cd0000        	call	c_lgmul
4651                     ; 986 temp_SL/=1000L;
4653  092b 96            	ldw	x,sp
4654  092c 1c0005        	addw	x,#OFST-3
4655  092f cd0000        	call	c_ltor
4657  0932 ae001c        	ldw	x,#L46
4658  0935 cd0000        	call	c_ldiv
4660  0938 96            	ldw	x,sp
4661  0939 1c0005        	addw	x,#OFST-3
4662  093c cd0000        	call	c_rtol
4664                     ; 987 Usum=(unsigned short)temp_SL;
4666  093f 1e07          	ldw	x,(OFST-1,sp)
4667  0941 cf0006        	ldw	_Usum,x
4668                     ; 991 temp_SL=adc_buff_[3];
4670  0944 ce0105        	ldw	x,_adc_buff_+6
4671  0947 cd0000        	call	c_itolx
4673  094a 96            	ldw	x,sp
4674  094b 1c0005        	addw	x,#OFST-3
4675  094e cd0000        	call	c_rtol
4677                     ; 993 if(temp_SL<0) temp_SL=0;
4679  0951 9c            	rvf
4680  0952 0d05          	tnz	(OFST-3,sp)
4681  0954 2e0a          	jrsge	L5032
4684  0956 ae0000        	ldw	x,#0
4685  0959 1f07          	ldw	(OFST-1,sp),x
4686  095b ae0000        	ldw	x,#0
4687  095e 1f05          	ldw	(OFST-3,sp),x
4688  0960               L5032:
4689                     ; 994 temp_SL*=ee_K[1][1];
4691  0960 ce0020        	ldw	x,_ee_K+6
4692  0963 cd0000        	call	c_itolx
4694  0966 96            	ldw	x,sp
4695  0967 1c0005        	addw	x,#OFST-3
4696  096a cd0000        	call	c_lgmul
4698                     ; 995 temp_SL/=1800;
4700  096d 96            	ldw	x,sp
4701  096e 1c0005        	addw	x,#OFST-3
4702  0971 cd0000        	call	c_ltor
4704  0974 ae0020        	ldw	x,#L66
4705  0977 cd0000        	call	c_ldiv
4707  097a 96            	ldw	x,sp
4708  097b 1c0005        	addw	x,#OFST-3
4709  097e cd0000        	call	c_rtol
4711                     ; 996 Un=(unsigned short)temp_SL;
4713  0981 1e07          	ldw	x,(OFST-1,sp)
4714  0983 cf000e        	ldw	_Un,x
4715                     ; 1001 temp_SL=adc_buff_[2];
4717  0986 ce0103        	ldw	x,_adc_buff_+4
4718  0989 cd0000        	call	c_itolx
4720  098c 96            	ldw	x,sp
4721  098d 1c0005        	addw	x,#OFST-3
4722  0990 cd0000        	call	c_rtol
4724                     ; 1002 temp_SL*=ee_K[3][1];
4726  0993 ce0028        	ldw	x,_ee_K+14
4727  0996 cd0000        	call	c_itolx
4729  0999 96            	ldw	x,sp
4730  099a 1c0005        	addw	x,#OFST-3
4731  099d cd0000        	call	c_lgmul
4733                     ; 1003 temp_SL/=1000;
4735  09a0 96            	ldw	x,sp
4736  09a1 1c0005        	addw	x,#OFST-3
4737  09a4 cd0000        	call	c_ltor
4739  09a7 ae001c        	ldw	x,#L46
4740  09aa cd0000        	call	c_ldiv
4742  09ad 96            	ldw	x,sp
4743  09ae 1c0005        	addw	x,#OFST-3
4744  09b1 cd0000        	call	c_rtol
4746                     ; 1004 T=(signed short)(temp_SL-273L);
4748  09b4 7b08          	ld	a,(OFST+0,sp)
4749  09b6 5f            	clrw	x
4750  09b7 4d            	tnz	a
4751  09b8 2a01          	jrpl	L07
4752  09ba 53            	cplw	x
4753  09bb               L07:
4754  09bb 97            	ld	xl,a
4755  09bc 1d0111        	subw	x,#273
4756  09bf 01            	rrwa	x,a
4757  09c0 b772          	ld	_T,a
4758  09c2 02            	rlwa	x,a
4759                     ; 1005 if(T<-30)T=-30;
4761  09c3 9c            	rvf
4762  09c4 b672          	ld	a,_T
4763  09c6 a1e2          	cp	a,#226
4764  09c8 2e04          	jrsge	L7032
4767  09ca 35e20072      	mov	_T,#226
4768  09ce               L7032:
4769                     ; 1006 if(T>120)T=120;
4771  09ce 9c            	rvf
4772  09cf b672          	ld	a,_T
4773  09d1 a179          	cp	a,#121
4774  09d3 2f04          	jrslt	L1132
4777  09d5 35780072      	mov	_T,#120
4778  09d9               L1132:
4779                     ; 1010 Uin=Usum-Ui;
4781  09d9 ce0006        	ldw	x,_Usum
4782  09dc 72b0000c      	subw	x,_Ui
4783  09e0 cf0004        	ldw	_Uin,x
4784                     ; 1011 if(link==ON)
4786  09e3 b66d          	ld	a,_link
4787  09e5 a155          	cp	a,#85
4788  09e7 260c          	jrne	L3132
4789                     ; 1013 	Unecc=U_out_const-Uin;
4791  09e9 ce0008        	ldw	x,_U_out_const
4792  09ec 72b00004      	subw	x,_Uin
4793  09f0 cf000a        	ldw	_Unecc,x
4795  09f3 200a          	jra	L5132
4796  09f5               L3132:
4797                     ; 1022 else Unecc=ee_UAVT-Uin;
4799  09f5 ce000c        	ldw	x,_ee_UAVT
4800  09f8 72b00004      	subw	x,_Uin
4801  09fc cf000a        	ldw	_Unecc,x
4802  09ff               L5132:
4803                     ; 1031 temp_SL=(signed long)(T-ee_tsign);
4805  09ff 5f            	clrw	x
4806  0a00 b672          	ld	a,_T
4807  0a02 2a01          	jrpl	L27
4808  0a04 53            	cplw	x
4809  0a05               L27:
4810  0a05 97            	ld	xl,a
4811  0a06 72b0000e      	subw	x,_ee_tsign
4812  0a0a cd0000        	call	c_itolx
4814  0a0d 96            	ldw	x,sp
4815  0a0e 1c0005        	addw	x,#OFST-3
4816  0a11 cd0000        	call	c_rtol
4818                     ; 1032 temp_SL*=1000L;
4820  0a14 ae03e8        	ldw	x,#1000
4821  0a17 bf02          	ldw	c_lreg+2,x
4822  0a19 ae0000        	ldw	x,#0
4823  0a1c bf00          	ldw	c_lreg,x
4824  0a1e 96            	ldw	x,sp
4825  0a1f 1c0005        	addw	x,#OFST-3
4826  0a22 cd0000        	call	c_lgmul
4828                     ; 1033 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4830  0a25 ce0010        	ldw	x,_ee_tmax
4831  0a28 72b0000e      	subw	x,_ee_tsign
4832  0a2c cd0000        	call	c_itolx
4834  0a2f 96            	ldw	x,sp
4835  0a30 1c0001        	addw	x,#OFST-7
4836  0a33 cd0000        	call	c_rtol
4838  0a36 96            	ldw	x,sp
4839  0a37 1c0005        	addw	x,#OFST-3
4840  0a3a cd0000        	call	c_ltor
4842  0a3d 96            	ldw	x,sp
4843  0a3e 1c0001        	addw	x,#OFST-7
4844  0a41 cd0000        	call	c_ldiv
4846  0a44 96            	ldw	x,sp
4847  0a45 1c0005        	addw	x,#OFST-3
4848  0a48 cd0000        	call	c_rtol
4850                     ; 1035 vol_i_temp_avar=(unsigned short)temp_SL; 
4852  0a4b 1e07          	ldw	x,(OFST-1,sp)
4853  0a4d bf06          	ldw	_vol_i_temp_avar,x
4854                     ; 1037 debug_info_to_uku[0]=pwm_u;
4856  0a4f be08          	ldw	x,_pwm_u
4857  0a51 bf01          	ldw	_debug_info_to_uku,x
4858                     ; 1038 debug_info_to_uku[1]=vol_i_temp;
4860  0a53 be60          	ldw	x,_vol_i_temp
4861  0a55 bf03          	ldw	_debug_info_to_uku+2,x
4862                     ; 1040 }
4865  0a57 5b08          	addw	sp,#8
4866  0a59 81            	ret
4897                     ; 1043 void temper_drv(void)		//1 Hz
4897                     ; 1044 {
4898                     	switch	.text
4899  0a5a               _temper_drv:
4903                     ; 1046 if(T>ee_tsign) tsign_cnt++;
4905  0a5a 9c            	rvf
4906  0a5b 5f            	clrw	x
4907  0a5c b672          	ld	a,_T
4908  0a5e 2a01          	jrpl	L67
4909  0a60 53            	cplw	x
4910  0a61               L67:
4911  0a61 97            	ld	xl,a
4912  0a62 c3000e        	cpw	x,_ee_tsign
4913  0a65 2d09          	jrsle	L7232
4916  0a67 be59          	ldw	x,_tsign_cnt
4917  0a69 1c0001        	addw	x,#1
4918  0a6c bf59          	ldw	_tsign_cnt,x
4920  0a6e 201d          	jra	L1332
4921  0a70               L7232:
4922                     ; 1047 else if (T<(ee_tsign-1)) tsign_cnt--;
4924  0a70 9c            	rvf
4925  0a71 ce000e        	ldw	x,_ee_tsign
4926  0a74 5a            	decw	x
4927  0a75 905f          	clrw	y
4928  0a77 b672          	ld	a,_T
4929  0a79 2a02          	jrpl	L001
4930  0a7b 9053          	cplw	y
4931  0a7d               L001:
4932  0a7d 9097          	ld	yl,a
4933  0a7f 90bf00        	ldw	c_y,y
4934  0a82 b300          	cpw	x,c_y
4935  0a84 2d07          	jrsle	L1332
4938  0a86 be59          	ldw	x,_tsign_cnt
4939  0a88 1d0001        	subw	x,#1
4940  0a8b bf59          	ldw	_tsign_cnt,x
4941  0a8d               L1332:
4942                     ; 1049 gran(&tsign_cnt,0,60);
4944  0a8d ae003c        	ldw	x,#60
4945  0a90 89            	pushw	x
4946  0a91 5f            	clrw	x
4947  0a92 89            	pushw	x
4948  0a93 ae0059        	ldw	x,#_tsign_cnt
4949  0a96 cd00d5        	call	_gran
4951  0a99 5b04          	addw	sp,#4
4952                     ; 1051 if(tsign_cnt>=55)
4954  0a9b 9c            	rvf
4955  0a9c be59          	ldw	x,_tsign_cnt
4956  0a9e a30037        	cpw	x,#55
4957  0aa1 2f16          	jrslt	L5332
4958                     ; 1053 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4960  0aa3 3d54          	tnz	_jp_mode
4961  0aa5 2606          	jrne	L3432
4963  0aa7 b605          	ld	a,_flags
4964  0aa9 a540          	bcp	a,#64
4965  0aab 2706          	jreq	L1432
4966  0aad               L3432:
4968  0aad b654          	ld	a,_jp_mode
4969  0aaf a103          	cp	a,#3
4970  0ab1 2612          	jrne	L5432
4971  0ab3               L1432:
4974  0ab3 72140005      	bset	_flags,#2
4975  0ab7 200c          	jra	L5432
4976  0ab9               L5332:
4977                     ; 1055 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
4979  0ab9 9c            	rvf
4980  0aba be59          	ldw	x,_tsign_cnt
4981  0abc a30006        	cpw	x,#6
4982  0abf 2e04          	jrsge	L5432
4985  0ac1 72150005      	bres	_flags,#2
4986  0ac5               L5432:
4987                     ; 1060 if(T>ee_tmax) tmax_cnt++;
4989  0ac5 9c            	rvf
4990  0ac6 5f            	clrw	x
4991  0ac7 b672          	ld	a,_T
4992  0ac9 2a01          	jrpl	L201
4993  0acb 53            	cplw	x
4994  0acc               L201:
4995  0acc 97            	ld	xl,a
4996  0acd c30010        	cpw	x,_ee_tmax
4997  0ad0 2d09          	jrsle	L1532
5000  0ad2 be57          	ldw	x,_tmax_cnt
5001  0ad4 1c0001        	addw	x,#1
5002  0ad7 bf57          	ldw	_tmax_cnt,x
5004  0ad9 201d          	jra	L3532
5005  0adb               L1532:
5006                     ; 1061 else if (T<(ee_tmax-1)) tmax_cnt--;
5008  0adb 9c            	rvf
5009  0adc ce0010        	ldw	x,_ee_tmax
5010  0adf 5a            	decw	x
5011  0ae0 905f          	clrw	y
5012  0ae2 b672          	ld	a,_T
5013  0ae4 2a02          	jrpl	L401
5014  0ae6 9053          	cplw	y
5015  0ae8               L401:
5016  0ae8 9097          	ld	yl,a
5017  0aea 90bf00        	ldw	c_y,y
5018  0aed b300          	cpw	x,c_y
5019  0aef 2d07          	jrsle	L3532
5022  0af1 be57          	ldw	x,_tmax_cnt
5023  0af3 1d0001        	subw	x,#1
5024  0af6 bf57          	ldw	_tmax_cnt,x
5025  0af8               L3532:
5026                     ; 1063 gran(&tmax_cnt,0,60);
5028  0af8 ae003c        	ldw	x,#60
5029  0afb 89            	pushw	x
5030  0afc 5f            	clrw	x
5031  0afd 89            	pushw	x
5032  0afe ae0057        	ldw	x,#_tmax_cnt
5033  0b01 cd00d5        	call	_gran
5035  0b04 5b04          	addw	sp,#4
5036                     ; 1065 if(tmax_cnt>=55)
5038  0b06 9c            	rvf
5039  0b07 be57          	ldw	x,_tmax_cnt
5040  0b09 a30037        	cpw	x,#55
5041  0b0c 2f16          	jrslt	L7532
5042                     ; 1067 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5044  0b0e 3d54          	tnz	_jp_mode
5045  0b10 2606          	jrne	L5632
5047  0b12 b605          	ld	a,_flags
5048  0b14 a540          	bcp	a,#64
5049  0b16 2706          	jreq	L3632
5050  0b18               L5632:
5052  0b18 b654          	ld	a,_jp_mode
5053  0b1a a103          	cp	a,#3
5054  0b1c 2612          	jrne	L7632
5055  0b1e               L3632:
5058  0b1e 72120005      	bset	_flags,#1
5059  0b22 200c          	jra	L7632
5060  0b24               L7532:
5061                     ; 1069 else if (tmax_cnt<=5) flags&=0b11111101;
5063  0b24 9c            	rvf
5064  0b25 be57          	ldw	x,_tmax_cnt
5065  0b27 a30006        	cpw	x,#6
5066  0b2a 2e04          	jrsge	L7632
5069  0b2c 72130005      	bres	_flags,#1
5070  0b30               L7632:
5071                     ; 1072 } 
5074  0b30 81            	ret
5106                     ; 1075 void u_drv(void)		//1Hz
5106                     ; 1076 { 
5107                     	switch	.text
5108  0b31               _u_drv:
5112                     ; 1077 if(jp_mode!=jp3)
5114  0b31 b654          	ld	a,_jp_mode
5115  0b33 a103          	cp	a,#3
5116  0b35 2774          	jreq	L3042
5117                     ; 1079 	if(Ui>ee_Umax)umax_cnt++;
5119  0b37 9c            	rvf
5120  0b38 ce000c        	ldw	x,_Ui
5121  0b3b c30014        	cpw	x,_ee_Umax
5122  0b3e 2d09          	jrsle	L5042
5125  0b40 be70          	ldw	x,_umax_cnt
5126  0b42 1c0001        	addw	x,#1
5127  0b45 bf70          	ldw	_umax_cnt,x
5129  0b47 2003          	jra	L7042
5130  0b49               L5042:
5131                     ; 1080 	else umax_cnt=0;
5133  0b49 5f            	clrw	x
5134  0b4a bf70          	ldw	_umax_cnt,x
5135  0b4c               L7042:
5136                     ; 1081 	gran(&umax_cnt,0,10);
5138  0b4c ae000a        	ldw	x,#10
5139  0b4f 89            	pushw	x
5140  0b50 5f            	clrw	x
5141  0b51 89            	pushw	x
5142  0b52 ae0070        	ldw	x,#_umax_cnt
5143  0b55 cd00d5        	call	_gran
5145  0b58 5b04          	addw	sp,#4
5146                     ; 1082 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5148  0b5a 9c            	rvf
5149  0b5b be70          	ldw	x,_umax_cnt
5150  0b5d a3000a        	cpw	x,#10
5151  0b60 2f04          	jrslt	L1142
5154  0b62 72160005      	bset	_flags,#3
5155  0b66               L1142:
5156                     ; 1085 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5158  0b66 9c            	rvf
5159  0b67 ce000c        	ldw	x,_Ui
5160  0b6a c3000e        	cpw	x,_Un
5161  0b6d 2e1d          	jrsge	L3142
5163  0b6f 9c            	rvf
5164  0b70 ce000e        	ldw	x,_Un
5165  0b73 72b0000c      	subw	x,_Ui
5166  0b77 c30012        	cpw	x,_ee_dU
5167  0b7a 2d10          	jrsle	L3142
5169  0b7c c65005        	ld	a,20485
5170  0b7f a504          	bcp	a,#4
5171  0b81 2609          	jrne	L3142
5174  0b83 be6e          	ldw	x,_umin_cnt
5175  0b85 1c0001        	addw	x,#1
5176  0b88 bf6e          	ldw	_umin_cnt,x
5178  0b8a 2003          	jra	L5142
5179  0b8c               L3142:
5180                     ; 1086 	else umin_cnt=0;
5182  0b8c 5f            	clrw	x
5183  0b8d bf6e          	ldw	_umin_cnt,x
5184  0b8f               L5142:
5185                     ; 1087 	gran(&umin_cnt,0,10);	
5187  0b8f ae000a        	ldw	x,#10
5188  0b92 89            	pushw	x
5189  0b93 5f            	clrw	x
5190  0b94 89            	pushw	x
5191  0b95 ae006e        	ldw	x,#_umin_cnt
5192  0b98 cd00d5        	call	_gran
5194  0b9b 5b04          	addw	sp,#4
5195                     ; 1088 	if(umin_cnt>=10)flags|=0b00010000;	  
5197  0b9d 9c            	rvf
5198  0b9e be6e          	ldw	x,_umin_cnt
5199  0ba0 a3000a        	cpw	x,#10
5200  0ba3 2f71          	jrslt	L1242
5203  0ba5 72180005      	bset	_flags,#4
5204  0ba9 206b          	jra	L1242
5205  0bab               L3042:
5206                     ; 1090 else if(jp_mode==jp3)
5208  0bab b654          	ld	a,_jp_mode
5209  0bad a103          	cp	a,#3
5210  0baf 2665          	jrne	L1242
5211                     ; 1092 	if(Ui>700)umax_cnt++;
5213  0bb1 9c            	rvf
5214  0bb2 ce000c        	ldw	x,_Ui
5215  0bb5 a302bd        	cpw	x,#701
5216  0bb8 2f09          	jrslt	L5242
5219  0bba be70          	ldw	x,_umax_cnt
5220  0bbc 1c0001        	addw	x,#1
5221  0bbf bf70          	ldw	_umax_cnt,x
5223  0bc1 2003          	jra	L7242
5224  0bc3               L5242:
5225                     ; 1093 	else umax_cnt=0;
5227  0bc3 5f            	clrw	x
5228  0bc4 bf70          	ldw	_umax_cnt,x
5229  0bc6               L7242:
5230                     ; 1094 	gran(&umax_cnt,0,10);
5232  0bc6 ae000a        	ldw	x,#10
5233  0bc9 89            	pushw	x
5234  0bca 5f            	clrw	x
5235  0bcb 89            	pushw	x
5236  0bcc ae0070        	ldw	x,#_umax_cnt
5237  0bcf cd00d5        	call	_gran
5239  0bd2 5b04          	addw	sp,#4
5240                     ; 1095 	if(umax_cnt>=10)flags|=0b00001000;
5242  0bd4 9c            	rvf
5243  0bd5 be70          	ldw	x,_umax_cnt
5244  0bd7 a3000a        	cpw	x,#10
5245  0bda 2f04          	jrslt	L1342
5248  0bdc 72160005      	bset	_flags,#3
5249  0be0               L1342:
5250                     ; 1098 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5252  0be0 9c            	rvf
5253  0be1 ce000c        	ldw	x,_Ui
5254  0be4 a300c8        	cpw	x,#200
5255  0be7 2e10          	jrsge	L3342
5257  0be9 c65005        	ld	a,20485
5258  0bec a504          	bcp	a,#4
5259  0bee 2609          	jrne	L3342
5262  0bf0 be6e          	ldw	x,_umin_cnt
5263  0bf2 1c0001        	addw	x,#1
5264  0bf5 bf6e          	ldw	_umin_cnt,x
5266  0bf7 2003          	jra	L5342
5267  0bf9               L3342:
5268                     ; 1099 	else umin_cnt=0;
5270  0bf9 5f            	clrw	x
5271  0bfa bf6e          	ldw	_umin_cnt,x
5272  0bfc               L5342:
5273                     ; 1100 	gran(&umin_cnt,0,10);	
5275  0bfc ae000a        	ldw	x,#10
5276  0bff 89            	pushw	x
5277  0c00 5f            	clrw	x
5278  0c01 89            	pushw	x
5279  0c02 ae006e        	ldw	x,#_umin_cnt
5280  0c05 cd00d5        	call	_gran
5282  0c08 5b04          	addw	sp,#4
5283                     ; 1101 	if(umin_cnt>=10)flags|=0b00010000;	  
5285  0c0a 9c            	rvf
5286  0c0b be6e          	ldw	x,_umin_cnt
5287  0c0d a3000a        	cpw	x,#10
5288  0c10 2f04          	jrslt	L1242
5291  0c12 72180005      	bset	_flags,#4
5292  0c16               L1242:
5293                     ; 1103 }
5296  0c16 81            	ret
5322                     ; 1128 void apv_start(void)
5322                     ; 1129 {
5323                     	switch	.text
5324  0c17               _apv_start:
5328                     ; 1130 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5330  0c17 3d4f          	tnz	_apv_cnt
5331  0c19 2624          	jrne	L1542
5333  0c1b 3d50          	tnz	_apv_cnt+1
5334  0c1d 2620          	jrne	L1542
5336  0c1f 3d51          	tnz	_apv_cnt+2
5337  0c21 261c          	jrne	L1542
5339                     	btst	_bAPV
5340  0c28 2515          	jrult	L1542
5341                     ; 1132 	apv_cnt[0]=60;
5343  0c2a 353c004f      	mov	_apv_cnt,#60
5344                     ; 1133 	apv_cnt[1]=60;
5346  0c2e 353c0050      	mov	_apv_cnt+1,#60
5347                     ; 1134 	apv_cnt[2]=60;
5349  0c32 353c0051      	mov	_apv_cnt+2,#60
5350                     ; 1135 	apv_cnt_=3600;
5352  0c36 ae0e10        	ldw	x,#3600
5353  0c39 bf4d          	ldw	_apv_cnt_,x
5354                     ; 1136 	bAPV=1;	
5356  0c3b 72100002      	bset	_bAPV
5357  0c3f               L1542:
5358                     ; 1138 }
5361  0c3f 81            	ret
5387                     ; 1141 void apv_stop(void)
5387                     ; 1142 {
5388                     	switch	.text
5389  0c40               _apv_stop:
5393                     ; 1143 apv_cnt[0]=0;
5395  0c40 3f4f          	clr	_apv_cnt
5396                     ; 1144 apv_cnt[1]=0;
5398  0c42 3f50          	clr	_apv_cnt+1
5399                     ; 1145 apv_cnt[2]=0;
5401  0c44 3f51          	clr	_apv_cnt+2
5402                     ; 1146 apv_cnt_=0;	
5404  0c46 5f            	clrw	x
5405  0c47 bf4d          	ldw	_apv_cnt_,x
5406                     ; 1147 bAPV=0;
5408  0c49 72110002      	bres	_bAPV
5409                     ; 1148 }
5412  0c4d 81            	ret
5447                     ; 1152 void apv_hndl(void)
5447                     ; 1153 {
5448                     	switch	.text
5449  0c4e               _apv_hndl:
5453                     ; 1154 if(apv_cnt[0])
5455  0c4e 3d4f          	tnz	_apv_cnt
5456  0c50 271e          	jreq	L3742
5457                     ; 1156 	apv_cnt[0]--;
5459  0c52 3a4f          	dec	_apv_cnt
5460                     ; 1157 	if(apv_cnt[0]==0)
5462  0c54 3d4f          	tnz	_apv_cnt
5463  0c56 265a          	jrne	L7742
5464                     ; 1159 		flags&=0b11100001;
5466  0c58 b605          	ld	a,_flags
5467  0c5a a4e1          	and	a,#225
5468  0c5c b705          	ld	_flags,a
5469                     ; 1160 		tsign_cnt=0;
5471  0c5e 5f            	clrw	x
5472  0c5f bf59          	ldw	_tsign_cnt,x
5473                     ; 1161 		tmax_cnt=0;
5475  0c61 5f            	clrw	x
5476  0c62 bf57          	ldw	_tmax_cnt,x
5477                     ; 1162 		umax_cnt=0;
5479  0c64 5f            	clrw	x
5480  0c65 bf70          	ldw	_umax_cnt,x
5481                     ; 1163 		umin_cnt=0;
5483  0c67 5f            	clrw	x
5484  0c68 bf6e          	ldw	_umin_cnt,x
5485                     ; 1165 		led_drv_cnt=30;
5487  0c6a 351e0016      	mov	_led_drv_cnt,#30
5488  0c6e 2042          	jra	L7742
5489  0c70               L3742:
5490                     ; 1168 else if(apv_cnt[1])
5492  0c70 3d50          	tnz	_apv_cnt+1
5493  0c72 271e          	jreq	L1052
5494                     ; 1170 	apv_cnt[1]--;
5496  0c74 3a50          	dec	_apv_cnt+1
5497                     ; 1171 	if(apv_cnt[1]==0)
5499  0c76 3d50          	tnz	_apv_cnt+1
5500  0c78 2638          	jrne	L7742
5501                     ; 1173 		flags&=0b11100001;
5503  0c7a b605          	ld	a,_flags
5504  0c7c a4e1          	and	a,#225
5505  0c7e b705          	ld	_flags,a
5506                     ; 1174 		tsign_cnt=0;
5508  0c80 5f            	clrw	x
5509  0c81 bf59          	ldw	_tsign_cnt,x
5510                     ; 1175 		tmax_cnt=0;
5512  0c83 5f            	clrw	x
5513  0c84 bf57          	ldw	_tmax_cnt,x
5514                     ; 1176 		umax_cnt=0;
5516  0c86 5f            	clrw	x
5517  0c87 bf70          	ldw	_umax_cnt,x
5518                     ; 1177 		umin_cnt=0;
5520  0c89 5f            	clrw	x
5521  0c8a bf6e          	ldw	_umin_cnt,x
5522                     ; 1179 		led_drv_cnt=30;
5524  0c8c 351e0016      	mov	_led_drv_cnt,#30
5525  0c90 2020          	jra	L7742
5526  0c92               L1052:
5527                     ; 1182 else if(apv_cnt[2])
5529  0c92 3d51          	tnz	_apv_cnt+2
5530  0c94 271c          	jreq	L7742
5531                     ; 1184 	apv_cnt[2]--;
5533  0c96 3a51          	dec	_apv_cnt+2
5534                     ; 1185 	if(apv_cnt[2]==0)
5536  0c98 3d51          	tnz	_apv_cnt+2
5537  0c9a 2616          	jrne	L7742
5538                     ; 1187 		flags&=0b11100001;
5540  0c9c b605          	ld	a,_flags
5541  0c9e a4e1          	and	a,#225
5542  0ca0 b705          	ld	_flags,a
5543                     ; 1188 		tsign_cnt=0;
5545  0ca2 5f            	clrw	x
5546  0ca3 bf59          	ldw	_tsign_cnt,x
5547                     ; 1189 		tmax_cnt=0;
5549  0ca5 5f            	clrw	x
5550  0ca6 bf57          	ldw	_tmax_cnt,x
5551                     ; 1190 		umax_cnt=0;
5553  0ca8 5f            	clrw	x
5554  0ca9 bf70          	ldw	_umax_cnt,x
5555                     ; 1191 		umin_cnt=0;          
5557  0cab 5f            	clrw	x
5558  0cac bf6e          	ldw	_umin_cnt,x
5559                     ; 1193 		led_drv_cnt=30;
5561  0cae 351e0016      	mov	_led_drv_cnt,#30
5562  0cb2               L7742:
5563                     ; 1197 if(apv_cnt_)
5565  0cb2 be4d          	ldw	x,_apv_cnt_
5566  0cb4 2712          	jreq	L3152
5567                     ; 1199 	apv_cnt_--;
5569  0cb6 be4d          	ldw	x,_apv_cnt_
5570  0cb8 1d0001        	subw	x,#1
5571  0cbb bf4d          	ldw	_apv_cnt_,x
5572                     ; 1200 	if(apv_cnt_==0) 
5574  0cbd be4d          	ldw	x,_apv_cnt_
5575  0cbf 2607          	jrne	L3152
5576                     ; 1202 		bAPV=0;
5578  0cc1 72110002      	bres	_bAPV
5579                     ; 1203 		apv_start();
5581  0cc5 cd0c17        	call	_apv_start
5583  0cc8               L3152:
5584                     ; 1207 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5586  0cc8 be6e          	ldw	x,_umin_cnt
5587  0cca 261e          	jrne	L7152
5589  0ccc be70          	ldw	x,_umax_cnt
5590  0cce 261a          	jrne	L7152
5592  0cd0 c65005        	ld	a,20485
5593  0cd3 a504          	bcp	a,#4
5594  0cd5 2613          	jrne	L7152
5595                     ; 1209 	if(cnt_apv_off<20)
5597  0cd7 b64c          	ld	a,_cnt_apv_off
5598  0cd9 a114          	cp	a,#20
5599  0cdb 240f          	jruge	L5252
5600                     ; 1211 		cnt_apv_off++;
5602  0cdd 3c4c          	inc	_cnt_apv_off
5603                     ; 1212 		if(cnt_apv_off>=20)
5605  0cdf b64c          	ld	a,_cnt_apv_off
5606  0ce1 a114          	cp	a,#20
5607  0ce3 2507          	jrult	L5252
5608                     ; 1214 			apv_stop();
5610  0ce5 cd0c40        	call	_apv_stop
5612  0ce8 2002          	jra	L5252
5613  0cea               L7152:
5614                     ; 1218 else cnt_apv_off=0;	
5616  0cea 3f4c          	clr	_cnt_apv_off
5617  0cec               L5252:
5618                     ; 1220 }
5621  0cec 81            	ret
5624                     	switch	.ubsct
5625  0000               L7252_flags_old:
5626  0000 00            	ds.b	1
5662                     ; 1223 void flags_drv(void)
5662                     ; 1224 {
5663                     	switch	.text
5664  0ced               _flags_drv:
5668                     ; 1226 if(jp_mode!=jp3) 
5670  0ced b654          	ld	a,_jp_mode
5671  0cef a103          	cp	a,#3
5672  0cf1 2723          	jreq	L7452
5673                     ; 1228 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5675  0cf3 b605          	ld	a,_flags
5676  0cf5 a508          	bcp	a,#8
5677  0cf7 2706          	jreq	L5552
5679  0cf9 b600          	ld	a,L7252_flags_old
5680  0cfb a508          	bcp	a,#8
5681  0cfd 270c          	jreq	L3552
5682  0cff               L5552:
5684  0cff b605          	ld	a,_flags
5685  0d01 a510          	bcp	a,#16
5686  0d03 2726          	jreq	L1652
5688  0d05 b600          	ld	a,L7252_flags_old
5689  0d07 a510          	bcp	a,#16
5690  0d09 2620          	jrne	L1652
5691  0d0b               L3552:
5692                     ; 1230     		if(link==OFF)apv_start();
5694  0d0b b66d          	ld	a,_link
5695  0d0d a1aa          	cp	a,#170
5696  0d0f 261a          	jrne	L1652
5699  0d11 cd0c17        	call	_apv_start
5701  0d14 2015          	jra	L1652
5702  0d16               L7452:
5703                     ; 1233 else if(jp_mode==jp3) 
5705  0d16 b654          	ld	a,_jp_mode
5706  0d18 a103          	cp	a,#3
5707  0d1a 260f          	jrne	L1652
5708                     ; 1235 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5710  0d1c b605          	ld	a,_flags
5711  0d1e a508          	bcp	a,#8
5712  0d20 2709          	jreq	L1652
5714  0d22 b600          	ld	a,L7252_flags_old
5715  0d24 a508          	bcp	a,#8
5716  0d26 2603          	jrne	L1652
5717                     ; 1237     		apv_start();
5719  0d28 cd0c17        	call	_apv_start
5721  0d2b               L1652:
5722                     ; 1240 flags_old=flags;
5724  0d2b 450500        	mov	L7252_flags_old,_flags
5725                     ; 1242 } 
5728  0d2e 81            	ret
5763                     ; 1379 void adr_drv_v4(char in)
5763                     ; 1380 {
5764                     	switch	.text
5765  0d2f               _adr_drv_v4:
5769                     ; 1381 if(adress!=in)adress=in;
5771  0d2f c100f7        	cp	a,_adress
5772  0d32 2703          	jreq	L5062
5775  0d34 c700f7        	ld	_adress,a
5776  0d37               L5062:
5777                     ; 1382 }
5780  0d37 81            	ret
5809                     ; 1385 void adr_drv_v3(void)
5809                     ; 1386 {
5810                     	switch	.text
5811  0d38               _adr_drv_v3:
5813  0d38 88            	push	a
5814       00000001      OFST:	set	1
5817                     ; 1392 GPIOB->DDR&=~(1<<0);
5819  0d39 72115007      	bres	20487,#0
5820                     ; 1393 GPIOB->CR1&=~(1<<0);
5822  0d3d 72115008      	bres	20488,#0
5823                     ; 1394 GPIOB->CR2&=~(1<<0);
5825  0d41 72115009      	bres	20489,#0
5826                     ; 1395 ADC2->CR2=0x08;
5828  0d45 35085402      	mov	21506,#8
5829                     ; 1396 ADC2->CR1=0x40;
5831  0d49 35405401      	mov	21505,#64
5832                     ; 1397 ADC2->CSR=0x20+0;
5834  0d4d 35205400      	mov	21504,#32
5835                     ; 1398 ADC2->CR1|=1;
5837  0d51 72105401      	bset	21505,#0
5838                     ; 1399 ADC2->CR1|=1;
5840  0d55 72105401      	bset	21505,#0
5841                     ; 1400 adr_drv_stat=1;
5843  0d59 35010002      	mov	_adr_drv_stat,#1
5844  0d5d               L7162:
5845                     ; 1401 while(adr_drv_stat==1);
5848  0d5d b602          	ld	a,_adr_drv_stat
5849  0d5f a101          	cp	a,#1
5850  0d61 27fa          	jreq	L7162
5851                     ; 1403 GPIOB->DDR&=~(1<<1);
5853  0d63 72135007      	bres	20487,#1
5854                     ; 1404 GPIOB->CR1&=~(1<<1);
5856  0d67 72135008      	bres	20488,#1
5857                     ; 1405 GPIOB->CR2&=~(1<<1);
5859  0d6b 72135009      	bres	20489,#1
5860                     ; 1406 ADC2->CR2=0x08;
5862  0d6f 35085402      	mov	21506,#8
5863                     ; 1407 ADC2->CR1=0x40;
5865  0d73 35405401      	mov	21505,#64
5866                     ; 1408 ADC2->CSR=0x20+1;
5868  0d77 35215400      	mov	21504,#33
5869                     ; 1409 ADC2->CR1|=1;
5871  0d7b 72105401      	bset	21505,#0
5872                     ; 1410 ADC2->CR1|=1;
5874  0d7f 72105401      	bset	21505,#0
5875                     ; 1411 adr_drv_stat=3;
5877  0d83 35030002      	mov	_adr_drv_stat,#3
5878  0d87               L5262:
5879                     ; 1412 while(adr_drv_stat==3);
5882  0d87 b602          	ld	a,_adr_drv_stat
5883  0d89 a103          	cp	a,#3
5884  0d8b 27fa          	jreq	L5262
5885                     ; 1414 GPIOE->DDR&=~(1<<6);
5887  0d8d 721d5016      	bres	20502,#6
5888                     ; 1415 GPIOE->CR1&=~(1<<6);
5890  0d91 721d5017      	bres	20503,#6
5891                     ; 1416 GPIOE->CR2&=~(1<<6);
5893  0d95 721d5018      	bres	20504,#6
5894                     ; 1417 ADC2->CR2=0x08;
5896  0d99 35085402      	mov	21506,#8
5897                     ; 1418 ADC2->CR1=0x40;
5899  0d9d 35405401      	mov	21505,#64
5900                     ; 1419 ADC2->CSR=0x20+9;
5902  0da1 35295400      	mov	21504,#41
5903                     ; 1420 ADC2->CR1|=1;
5905  0da5 72105401      	bset	21505,#0
5906                     ; 1421 ADC2->CR1|=1;
5908  0da9 72105401      	bset	21505,#0
5909                     ; 1422 adr_drv_stat=5;
5911  0dad 35050002      	mov	_adr_drv_stat,#5
5912  0db1               L3362:
5913                     ; 1423 while(adr_drv_stat==5);
5916  0db1 b602          	ld	a,_adr_drv_stat
5917  0db3 a105          	cp	a,#5
5918  0db5 27fa          	jreq	L3362
5919                     ; 1427 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5921  0db7 9c            	rvf
5922  0db8 ce00ff        	ldw	x,_adc_buff_
5923  0dbb a3022a        	cpw	x,#554
5924  0dbe 2f0f          	jrslt	L1462
5926  0dc0 9c            	rvf
5927  0dc1 ce00ff        	ldw	x,_adc_buff_
5928  0dc4 a30253        	cpw	x,#595
5929  0dc7 2e06          	jrsge	L1462
5932  0dc9 725f00f8      	clr	_adr
5934  0dcd 204c          	jra	L3462
5935  0dcf               L1462:
5936                     ; 1428 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5938  0dcf 9c            	rvf
5939  0dd0 ce00ff        	ldw	x,_adc_buff_
5940  0dd3 a3036d        	cpw	x,#877
5941  0dd6 2f0f          	jrslt	L5462
5943  0dd8 9c            	rvf
5944  0dd9 ce00ff        	ldw	x,_adc_buff_
5945  0ddc a30396        	cpw	x,#918
5946  0ddf 2e06          	jrsge	L5462
5949  0de1 350100f8      	mov	_adr,#1
5951  0de5 2034          	jra	L3462
5952  0de7               L5462:
5953                     ; 1429 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5955  0de7 9c            	rvf
5956  0de8 ce00ff        	ldw	x,_adc_buff_
5957  0deb a302a3        	cpw	x,#675
5958  0dee 2f0f          	jrslt	L1562
5960  0df0 9c            	rvf
5961  0df1 ce00ff        	ldw	x,_adc_buff_
5962  0df4 a302cc        	cpw	x,#716
5963  0df7 2e06          	jrsge	L1562
5966  0df9 350200f8      	mov	_adr,#2
5968  0dfd 201c          	jra	L3462
5969  0dff               L1562:
5970                     ; 1430 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5972  0dff 9c            	rvf
5973  0e00 ce00ff        	ldw	x,_adc_buff_
5974  0e03 a303e3        	cpw	x,#995
5975  0e06 2f0f          	jrslt	L5562
5977  0e08 9c            	rvf
5978  0e09 ce00ff        	ldw	x,_adc_buff_
5979  0e0c a3040c        	cpw	x,#1036
5980  0e0f 2e06          	jrsge	L5562
5983  0e11 350300f8      	mov	_adr,#3
5985  0e15 2004          	jra	L3462
5986  0e17               L5562:
5987                     ; 1431 else adr[0]=5;
5989  0e17 350500f8      	mov	_adr,#5
5990  0e1b               L3462:
5991                     ; 1433 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5993  0e1b 9c            	rvf
5994  0e1c ce0101        	ldw	x,_adc_buff_+2
5995  0e1f a3022a        	cpw	x,#554
5996  0e22 2f0f          	jrslt	L1662
5998  0e24 9c            	rvf
5999  0e25 ce0101        	ldw	x,_adc_buff_+2
6000  0e28 a30253        	cpw	x,#595
6001  0e2b 2e06          	jrsge	L1662
6004  0e2d 725f00f9      	clr	_adr+1
6006  0e31 204c          	jra	L3662
6007  0e33               L1662:
6008                     ; 1434 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6010  0e33 9c            	rvf
6011  0e34 ce0101        	ldw	x,_adc_buff_+2
6012  0e37 a3036d        	cpw	x,#877
6013  0e3a 2f0f          	jrslt	L5662
6015  0e3c 9c            	rvf
6016  0e3d ce0101        	ldw	x,_adc_buff_+2
6017  0e40 a30396        	cpw	x,#918
6018  0e43 2e06          	jrsge	L5662
6021  0e45 350100f9      	mov	_adr+1,#1
6023  0e49 2034          	jra	L3662
6024  0e4b               L5662:
6025                     ; 1435 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6027  0e4b 9c            	rvf
6028  0e4c ce0101        	ldw	x,_adc_buff_+2
6029  0e4f a302a3        	cpw	x,#675
6030  0e52 2f0f          	jrslt	L1762
6032  0e54 9c            	rvf
6033  0e55 ce0101        	ldw	x,_adc_buff_+2
6034  0e58 a302cc        	cpw	x,#716
6035  0e5b 2e06          	jrsge	L1762
6038  0e5d 350200f9      	mov	_adr+1,#2
6040  0e61 201c          	jra	L3662
6041  0e63               L1762:
6042                     ; 1436 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6044  0e63 9c            	rvf
6045  0e64 ce0101        	ldw	x,_adc_buff_+2
6046  0e67 a303e3        	cpw	x,#995
6047  0e6a 2f0f          	jrslt	L5762
6049  0e6c 9c            	rvf
6050  0e6d ce0101        	ldw	x,_adc_buff_+2
6051  0e70 a3040c        	cpw	x,#1036
6052  0e73 2e06          	jrsge	L5762
6055  0e75 350300f9      	mov	_adr+1,#3
6057  0e79 2004          	jra	L3662
6058  0e7b               L5762:
6059                     ; 1437 else adr[1]=5;
6061  0e7b 350500f9      	mov	_adr+1,#5
6062  0e7f               L3662:
6063                     ; 1439 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6065  0e7f 9c            	rvf
6066  0e80 ce0111        	ldw	x,_adc_buff_+18
6067  0e83 a3022a        	cpw	x,#554
6068  0e86 2f0f          	jrslt	L1072
6070  0e88 9c            	rvf
6071  0e89 ce0111        	ldw	x,_adc_buff_+18
6072  0e8c a30253        	cpw	x,#595
6073  0e8f 2e06          	jrsge	L1072
6076  0e91 725f00fa      	clr	_adr+2
6078  0e95 204c          	jra	L3072
6079  0e97               L1072:
6080                     ; 1440 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6082  0e97 9c            	rvf
6083  0e98 ce0111        	ldw	x,_adc_buff_+18
6084  0e9b a3036d        	cpw	x,#877
6085  0e9e 2f0f          	jrslt	L5072
6087  0ea0 9c            	rvf
6088  0ea1 ce0111        	ldw	x,_adc_buff_+18
6089  0ea4 a30396        	cpw	x,#918
6090  0ea7 2e06          	jrsge	L5072
6093  0ea9 350100fa      	mov	_adr+2,#1
6095  0ead 2034          	jra	L3072
6096  0eaf               L5072:
6097                     ; 1441 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6099  0eaf 9c            	rvf
6100  0eb0 ce0111        	ldw	x,_adc_buff_+18
6101  0eb3 a302a3        	cpw	x,#675
6102  0eb6 2f0f          	jrslt	L1172
6104  0eb8 9c            	rvf
6105  0eb9 ce0111        	ldw	x,_adc_buff_+18
6106  0ebc a302cc        	cpw	x,#716
6107  0ebf 2e06          	jrsge	L1172
6110  0ec1 350200fa      	mov	_adr+2,#2
6112  0ec5 201c          	jra	L3072
6113  0ec7               L1172:
6114                     ; 1442 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6116  0ec7 9c            	rvf
6117  0ec8 ce0111        	ldw	x,_adc_buff_+18
6118  0ecb a303e3        	cpw	x,#995
6119  0ece 2f0f          	jrslt	L5172
6121  0ed0 9c            	rvf
6122  0ed1 ce0111        	ldw	x,_adc_buff_+18
6123  0ed4 a3040c        	cpw	x,#1036
6124  0ed7 2e06          	jrsge	L5172
6127  0ed9 350300fa      	mov	_adr+2,#3
6129  0edd 2004          	jra	L3072
6130  0edf               L5172:
6131                     ; 1443 else adr[2]=5;
6133  0edf 350500fa      	mov	_adr+2,#5
6134  0ee3               L3072:
6135                     ; 1447 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6137  0ee3 c600f8        	ld	a,_adr
6138  0ee6 a105          	cp	a,#5
6139  0ee8 270e          	jreq	L3272
6141  0eea c600f9        	ld	a,_adr+1
6142  0eed a105          	cp	a,#5
6143  0eef 2707          	jreq	L3272
6145  0ef1 c600fa        	ld	a,_adr+2
6146  0ef4 a105          	cp	a,#5
6147  0ef6 2606          	jrne	L1272
6148  0ef8               L3272:
6149                     ; 1450 	adress_error=1;
6151  0ef8 350100f6      	mov	_adress_error,#1
6153  0efc               L7272:
6154                     ; 1461 }
6157  0efc 84            	pop	a
6158  0efd 81            	ret
6159  0efe               L1272:
6160                     ; 1454 	if(adr[2]&0x02) bps_class=bpsIPS;
6162  0efe c600fa        	ld	a,_adr+2
6163  0f01 a502          	bcp	a,#2
6164  0f03 2706          	jreq	L1372
6167  0f05 3501000b      	mov	_bps_class,#1
6169  0f09 2002          	jra	L3372
6170  0f0b               L1372:
6171                     ; 1455 	else bps_class=bpsIBEP;
6173  0f0b 3f0b          	clr	_bps_class
6174  0f0d               L3372:
6175                     ; 1457 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6177  0f0d c600fa        	ld	a,_adr+2
6178  0f10 a401          	and	a,#1
6179  0f12 97            	ld	xl,a
6180  0f13 a610          	ld	a,#16
6181  0f15 42            	mul	x,a
6182  0f16 9f            	ld	a,xl
6183  0f17 6b01          	ld	(OFST+0,sp),a
6184  0f19 c600f9        	ld	a,_adr+1
6185  0f1c 48            	sll	a
6186  0f1d 48            	sll	a
6187  0f1e cb00f8        	add	a,_adr
6188  0f21 1b01          	add	a,(OFST+0,sp)
6189  0f23 c700f7        	ld	_adress,a
6190  0f26 20d4          	jra	L7272
6213                     ; 1511 void init_CAN(void) {
6214                     	switch	.text
6215  0f28               _init_CAN:
6219                     ; 1512 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6221  0f28 72135420      	bres	21536,#1
6222                     ; 1513 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6224  0f2c 72105420      	bset	21536,#0
6226  0f30               L7472:
6227                     ; 1514 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6229  0f30 c65421        	ld	a,21537
6230  0f33 a501          	bcp	a,#1
6231  0f35 27f9          	jreq	L7472
6232                     ; 1516 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6234  0f37 72185420      	bset	21536,#4
6235                     ; 1518 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6237  0f3b 35025427      	mov	21543,#2
6238                     ; 1527 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6240  0f3f 35135428      	mov	21544,#19
6241                     ; 1528 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6243  0f43 35c05429      	mov	21545,#192
6244                     ; 1529 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6246  0f47 357f542c      	mov	21548,#127
6247                     ; 1530 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6249  0f4b 35e0542d      	mov	21549,#224
6250                     ; 1532 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6252  0f4f 35315430      	mov	21552,#49
6253                     ; 1533 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6255  0f53 35c05431      	mov	21553,#192
6256                     ; 1534 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6258  0f57 357f5434      	mov	21556,#127
6259                     ; 1535 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6261  0f5b 35e05435      	mov	21557,#224
6262                     ; 1539 	CAN->PSR= 6;									// set page 6
6264  0f5f 35065427      	mov	21543,#6
6265                     ; 1544 	CAN->Page.Config.FMR1&=~3;								//mask mode
6267  0f63 c65430        	ld	a,21552
6268  0f66 a4fc          	and	a,#252
6269  0f68 c75430        	ld	21552,a
6270                     ; 1550 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6272  0f6b 35065432      	mov	21554,#6
6273                     ; 1551 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6275  0f6f 35605432      	mov	21554,#96
6276                     ; 1554 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6278  0f73 72105432      	bset	21554,#0
6279                     ; 1555 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6281  0f77 72185432      	bset	21554,#4
6282                     ; 1558 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6284  0f7b 35065427      	mov	21543,#6
6285                     ; 1560 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6287  0f7f 3509542c      	mov	21548,#9
6288                     ; 1561 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6290  0f83 35e7542d      	mov	21549,#231
6291                     ; 1563 	CAN->IER|=(1<<1);
6293  0f87 72125425      	bset	21541,#1
6294                     ; 1566 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6296  0f8b 72115420      	bres	21536,#0
6298  0f8f               L5572:
6299                     ; 1567 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6301  0f8f c65421        	ld	a,21537
6302  0f92 a501          	bcp	a,#1
6303  0f94 26f9          	jrne	L5572
6304                     ; 1568 }
6307  0f96 81            	ret
6415                     ; 1571 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6415                     ; 1572 {
6416                     	switch	.text
6417  0f97               _can_transmit:
6419  0f97 89            	pushw	x
6420       00000000      OFST:	set	0
6423                     ; 1574 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6425  0f98 b676          	ld	a,_can_buff_wr_ptr
6426  0f9a a104          	cp	a,#4
6427  0f9c 2502          	jrult	L7303
6430  0f9e 3f76          	clr	_can_buff_wr_ptr
6431  0fa0               L7303:
6432                     ; 1576 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6434  0fa0 b676          	ld	a,_can_buff_wr_ptr
6435  0fa2 97            	ld	xl,a
6436  0fa3 a610          	ld	a,#16
6437  0fa5 42            	mul	x,a
6438  0fa6 1601          	ldw	y,(OFST+1,sp)
6439  0fa8 a606          	ld	a,#6
6440  0faa               L031:
6441  0faa 9054          	srlw	y
6442  0fac 4a            	dec	a
6443  0fad 26fb          	jrne	L031
6444  0faf 909f          	ld	a,yl
6445  0fb1 e777          	ld	(_can_out_buff,x),a
6446                     ; 1577 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6448  0fb3 b676          	ld	a,_can_buff_wr_ptr
6449  0fb5 97            	ld	xl,a
6450  0fb6 a610          	ld	a,#16
6451  0fb8 42            	mul	x,a
6452  0fb9 7b02          	ld	a,(OFST+2,sp)
6453  0fbb 48            	sll	a
6454  0fbc 48            	sll	a
6455  0fbd e778          	ld	(_can_out_buff+1,x),a
6456                     ; 1579 can_out_buff[can_buff_wr_ptr][2]=data0;
6458  0fbf b676          	ld	a,_can_buff_wr_ptr
6459  0fc1 97            	ld	xl,a
6460  0fc2 a610          	ld	a,#16
6461  0fc4 42            	mul	x,a
6462  0fc5 7b05          	ld	a,(OFST+5,sp)
6463  0fc7 e779          	ld	(_can_out_buff+2,x),a
6464                     ; 1580 can_out_buff[can_buff_wr_ptr][3]=data1;
6466  0fc9 b676          	ld	a,_can_buff_wr_ptr
6467  0fcb 97            	ld	xl,a
6468  0fcc a610          	ld	a,#16
6469  0fce 42            	mul	x,a
6470  0fcf 7b06          	ld	a,(OFST+6,sp)
6471  0fd1 e77a          	ld	(_can_out_buff+3,x),a
6472                     ; 1581 can_out_buff[can_buff_wr_ptr][4]=data2;
6474  0fd3 b676          	ld	a,_can_buff_wr_ptr
6475  0fd5 97            	ld	xl,a
6476  0fd6 a610          	ld	a,#16
6477  0fd8 42            	mul	x,a
6478  0fd9 7b07          	ld	a,(OFST+7,sp)
6479  0fdb e77b          	ld	(_can_out_buff+4,x),a
6480                     ; 1582 can_out_buff[can_buff_wr_ptr][5]=data3;
6482  0fdd b676          	ld	a,_can_buff_wr_ptr
6483  0fdf 97            	ld	xl,a
6484  0fe0 a610          	ld	a,#16
6485  0fe2 42            	mul	x,a
6486  0fe3 7b08          	ld	a,(OFST+8,sp)
6487  0fe5 e77c          	ld	(_can_out_buff+5,x),a
6488                     ; 1583 can_out_buff[can_buff_wr_ptr][6]=data4;
6490  0fe7 b676          	ld	a,_can_buff_wr_ptr
6491  0fe9 97            	ld	xl,a
6492  0fea a610          	ld	a,#16
6493  0fec 42            	mul	x,a
6494  0fed 7b09          	ld	a,(OFST+9,sp)
6495  0fef e77d          	ld	(_can_out_buff+6,x),a
6496                     ; 1584 can_out_buff[can_buff_wr_ptr][7]=data5;
6498  0ff1 b676          	ld	a,_can_buff_wr_ptr
6499  0ff3 97            	ld	xl,a
6500  0ff4 a610          	ld	a,#16
6501  0ff6 42            	mul	x,a
6502  0ff7 7b0a          	ld	a,(OFST+10,sp)
6503  0ff9 e77e          	ld	(_can_out_buff+7,x),a
6504                     ; 1585 can_out_buff[can_buff_wr_ptr][8]=data6;
6506  0ffb b676          	ld	a,_can_buff_wr_ptr
6507  0ffd 97            	ld	xl,a
6508  0ffe a610          	ld	a,#16
6509  1000 42            	mul	x,a
6510  1001 7b0b          	ld	a,(OFST+11,sp)
6511  1003 e77f          	ld	(_can_out_buff+8,x),a
6512                     ; 1586 can_out_buff[can_buff_wr_ptr][9]=data7;
6514  1005 b676          	ld	a,_can_buff_wr_ptr
6515  1007 97            	ld	xl,a
6516  1008 a610          	ld	a,#16
6517  100a 42            	mul	x,a
6518  100b 7b0c          	ld	a,(OFST+12,sp)
6519  100d e780          	ld	(_can_out_buff+9,x),a
6520                     ; 1588 can_buff_wr_ptr++;
6522  100f 3c76          	inc	_can_buff_wr_ptr
6523                     ; 1589 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6525  1011 b676          	ld	a,_can_buff_wr_ptr
6526  1013 a104          	cp	a,#4
6527  1015 2502          	jrult	L1403
6530  1017 3f76          	clr	_can_buff_wr_ptr
6531  1019               L1403:
6532                     ; 1590 } 
6535  1019 85            	popw	x
6536  101a 81            	ret
6565                     ; 1593 void can_tx_hndl(void)
6565                     ; 1594 {
6566                     	switch	.text
6567  101b               _can_tx_hndl:
6571                     ; 1595 if(bTX_FREE)
6573  101b 3d03          	tnz	_bTX_FREE
6574  101d 2757          	jreq	L3503
6575                     ; 1597 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6577  101f b675          	ld	a,_can_buff_rd_ptr
6578  1021 b176          	cp	a,_can_buff_wr_ptr
6579  1023 275f          	jreq	L1603
6580                     ; 1599 		bTX_FREE=0;
6582  1025 3f03          	clr	_bTX_FREE
6583                     ; 1601 		CAN->PSR= 0;
6585  1027 725f5427      	clr	21543
6586                     ; 1602 		CAN->Page.TxMailbox.MDLCR=8;
6588  102b 35085429      	mov	21545,#8
6589                     ; 1603 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6591  102f b675          	ld	a,_can_buff_rd_ptr
6592  1031 97            	ld	xl,a
6593  1032 a610          	ld	a,#16
6594  1034 42            	mul	x,a
6595  1035 e677          	ld	a,(_can_out_buff,x)
6596  1037 c7542a        	ld	21546,a
6597                     ; 1604 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6599  103a b675          	ld	a,_can_buff_rd_ptr
6600  103c 97            	ld	xl,a
6601  103d a610          	ld	a,#16
6602  103f 42            	mul	x,a
6603  1040 e678          	ld	a,(_can_out_buff+1,x)
6604  1042 c7542b        	ld	21547,a
6605                     ; 1606 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6607  1045 b675          	ld	a,_can_buff_rd_ptr
6608  1047 97            	ld	xl,a
6609  1048 a610          	ld	a,#16
6610  104a 42            	mul	x,a
6611  104b 01            	rrwa	x,a
6612  104c ab79          	add	a,#_can_out_buff+2
6613  104e 2401          	jrnc	L431
6614  1050 5c            	incw	x
6615  1051               L431:
6616  1051 5f            	clrw	x
6617  1052 97            	ld	xl,a
6618  1053 bf00          	ldw	c_x,x
6619  1055 ae0008        	ldw	x,#8
6620  1058               L631:
6621  1058 5a            	decw	x
6622  1059 92d600        	ld	a,([c_x],x)
6623  105c d7542e        	ld	(21550,x),a
6624  105f 5d            	tnzw	x
6625  1060 26f6          	jrne	L631
6626                     ; 1608 		can_buff_rd_ptr++;
6628  1062 3c75          	inc	_can_buff_rd_ptr
6629                     ; 1609 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6631  1064 b675          	ld	a,_can_buff_rd_ptr
6632  1066 a104          	cp	a,#4
6633  1068 2502          	jrult	L7503
6636  106a 3f75          	clr	_can_buff_rd_ptr
6637  106c               L7503:
6638                     ; 1611 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6640  106c 72105428      	bset	21544,#0
6641                     ; 1612 		CAN->IER|=(1<<0);
6643  1070 72105425      	bset	21541,#0
6644  1074 200e          	jra	L1603
6645  1076               L3503:
6646                     ; 1617 	tx_busy_cnt++;
6648  1076 3c74          	inc	_tx_busy_cnt
6649                     ; 1618 	if(tx_busy_cnt>=100)
6651  1078 b674          	ld	a,_tx_busy_cnt
6652  107a a164          	cp	a,#100
6653  107c 2506          	jrult	L1603
6654                     ; 1620 		tx_busy_cnt=0;
6656  107e 3f74          	clr	_tx_busy_cnt
6657                     ; 1621 		bTX_FREE=1;
6659  1080 35010003      	mov	_bTX_FREE,#1
6660  1084               L1603:
6661                     ; 1624 }
6664  1084 81            	ret
6779                     ; 1650 void can_in_an(void)
6779                     ; 1651 {
6780                     	switch	.text
6781  1085               _can_in_an:
6783  1085 5207          	subw	sp,#7
6784       00000007      OFST:	set	7
6787                     ; 1661 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6789  1087 b6cd          	ld	a,_mess+6
6790  1089 c100f7        	cp	a,_adress
6791  108c 2703          	jreq	L651
6792  108e cc11c6        	jp	L1213
6793  1091               L651:
6795  1091 b6ce          	ld	a,_mess+7
6796  1093 c100f7        	cp	a,_adress
6797  1096 2703          	jreq	L061
6798  1098 cc11c6        	jp	L1213
6799  109b               L061:
6801  109b b6cf          	ld	a,_mess+8
6802  109d a1ed          	cp	a,#237
6803  109f 2703          	jreq	L261
6804  10a1 cc11c6        	jp	L1213
6805  10a4               L261:
6806                     ; 1664 	can_error_cnt=0;
6808  10a4 3f73          	clr	_can_error_cnt
6809                     ; 1666 	bMAIN=0;
6811  10a6 72110001      	bres	_bMAIN
6812                     ; 1667  	flags_tu=mess[9];
6814  10aa 45d06a        	mov	_flags_tu,_mess+9
6815                     ; 1668  	if(flags_tu&0b00000001)
6817  10ad b66a          	ld	a,_flags_tu
6818  10af a501          	bcp	a,#1
6819  10b1 2706          	jreq	L3213
6820                     ; 1673  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6822  10b3 721a0005      	bset	_flags,#5
6824  10b7 2008          	jra	L5213
6825  10b9               L3213:
6826                     ; 1684  				flags&=0b11011111; 
6828  10b9 721b0005      	bres	_flags,#5
6829                     ; 1685  				off_bp_cnt=5*EE_TZAS;
6831  10bd 350f005d      	mov	_off_bp_cnt,#15
6832  10c1               L5213:
6833                     ; 1691  	if(flags_tu&0b00000010) flags|=0b01000000;
6835  10c1 b66a          	ld	a,_flags_tu
6836  10c3 a502          	bcp	a,#2
6837  10c5 2706          	jreq	L7213
6840  10c7 721c0005      	bset	_flags,#6
6842  10cb 2004          	jra	L1313
6843  10cd               L7213:
6844                     ; 1692  	else flags&=0b10111111; 
6846  10cd 721d0005      	bres	_flags,#6
6847  10d1               L1313:
6848                     ; 1694  	U_out_const=mess[10]+mess[11]*256;
6850  10d1 b6d2          	ld	a,_mess+11
6851  10d3 5f            	clrw	x
6852  10d4 97            	ld	xl,a
6853  10d5 4f            	clr	a
6854  10d6 02            	rlwa	x,a
6855  10d7 01            	rrwa	x,a
6856  10d8 bbd1          	add	a,_mess+10
6857  10da 2401          	jrnc	L241
6858  10dc 5c            	incw	x
6859  10dd               L241:
6860  10dd c70009        	ld	_U_out_const+1,a
6861  10e0 9f            	ld	a,xl
6862  10e1 c70008        	ld	_U_out_const,a
6863                     ; 1695  	vol_i_temp=mess[12]+mess[13]*256;  
6865  10e4 b6d4          	ld	a,_mess+13
6866  10e6 5f            	clrw	x
6867  10e7 97            	ld	xl,a
6868  10e8 4f            	clr	a
6869  10e9 02            	rlwa	x,a
6870  10ea 01            	rrwa	x,a
6871  10eb bbd3          	add	a,_mess+12
6872  10ed 2401          	jrnc	L441
6873  10ef 5c            	incw	x
6874  10f0               L441:
6875  10f0 b761          	ld	_vol_i_temp+1,a
6876  10f2 9f            	ld	a,xl
6877  10f3 b760          	ld	_vol_i_temp,a
6878                     ; 1705 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6880  10f5 b608          	ld	a,_vent_resurs_tx_cnt
6881  10f7 a102          	cp	a,#2
6882  10f9 2507          	jrult	L3313
6885  10fb ce0000        	ldw	x,_vent_resurs
6886  10fe bf41          	ldw	_plazma_int+4,x
6888  1100 2004          	jra	L5313
6889  1102               L3313:
6890                     ; 1706 	else plazma_int[2]=vent_resurs_sec_cnt;
6892  1102 be09          	ldw	x,_vent_resurs_sec_cnt
6893  1104 bf41          	ldw	_plazma_int+4,x
6894  1106               L5313:
6895                     ; 1707  	rotor_int=flags_tu+(((short)flags)<<8);
6897  1106 b605          	ld	a,_flags
6898  1108 5f            	clrw	x
6899  1109 97            	ld	xl,a
6900  110a 4f            	clr	a
6901  110b 02            	rlwa	x,a
6902  110c 01            	rrwa	x,a
6903  110d bb6a          	add	a,_flags_tu
6904  110f 2401          	jrnc	L641
6905  1111 5c            	incw	x
6906  1112               L641:
6907  1112 b718          	ld	_rotor_int+1,a
6908  1114 9f            	ld	a,xl
6909  1115 b717          	ld	_rotor_int,a
6910                     ; 1708 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6912  1117 3b000c        	push	_Ui
6913  111a 3b000d        	push	_Ui+1
6914  111d 3b000e        	push	_Un
6915  1120 3b000f        	push	_Un+1
6916  1123 3b0010        	push	_I
6917  1126 3b0011        	push	_I+1
6918  1129 4bda          	push	#218
6919  112b 3b00f7        	push	_adress
6920  112e ae018e        	ldw	x,#398
6921  1131 cd0f97        	call	_can_transmit
6923  1134 5b08          	addw	sp,#8
6924                     ; 1709 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6926  1136 3b0006        	push	_Usum
6927  1139 3b0007        	push	_Usum+1
6928  113c 3b0069        	push	__x_+1
6929  113f 3b0005        	push	_flags
6930  1142 b608          	ld	a,_vent_resurs_tx_cnt
6931  1144 5f            	clrw	x
6932  1145 97            	ld	xl,a
6933  1146 d60000        	ld	a,(_vent_resurs_buff,x)
6934  1149 88            	push	a
6935  114a 3b0072        	push	_T
6936  114d 4bdb          	push	#219
6937  114f 3b00f7        	push	_adress
6938  1152 ae018e        	ldw	x,#398
6939  1155 cd0f97        	call	_can_transmit
6941  1158 5b08          	addw	sp,#8
6942                     ; 1710 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6944  115a 3b0005        	push	_debug_info_to_uku+4
6945  115d 3b0006        	push	_debug_info_to_uku+5
6946  1160 3b0003        	push	_debug_info_to_uku+2
6947  1163 3b0004        	push	_debug_info_to_uku+3
6948  1166 3b0001        	push	_debug_info_to_uku
6949  1169 3b0002        	push	_debug_info_to_uku+1
6950  116c 4bdc          	push	#220
6951  116e 3b00f7        	push	_adress
6952  1171 ae018e        	ldw	x,#398
6953  1174 cd0f97        	call	_can_transmit
6955  1177 5b08          	addw	sp,#8
6956                     ; 1711      link_cnt=0;
6958  1179 5f            	clrw	x
6959  117a bf6b          	ldw	_link_cnt,x
6960                     ; 1712      link=ON;
6962  117c 3555006d      	mov	_link,#85
6963                     ; 1714      if(flags_tu&0b10000000)
6965  1180 b66a          	ld	a,_flags_tu
6966  1182 a580          	bcp	a,#128
6967  1184 2716          	jreq	L7313
6968                     ; 1716      	if(!res_fl)
6970  1186 725d000b      	tnz	_res_fl
6971  118a 2626          	jrne	L3413
6972                     ; 1718      		res_fl=1;
6974  118c a601          	ld	a,#1
6975  118e ae000b        	ldw	x,#_res_fl
6976  1191 cd0000        	call	c_eewrc
6978                     ; 1719      		bRES=1;
6980  1194 3501000c      	mov	_bRES,#1
6981                     ; 1720      		res_fl_cnt=0;
6983  1198 3f4b          	clr	_res_fl_cnt
6984  119a 2016          	jra	L3413
6985  119c               L7313:
6986                     ; 1725      	if(main_cnt>20)
6988  119c 9c            	rvf
6989  119d ce0255        	ldw	x,_main_cnt
6990  11a0 a30015        	cpw	x,#21
6991  11a3 2f0d          	jrslt	L3413
6992                     ; 1727     			if(res_fl)
6994  11a5 725d000b      	tnz	_res_fl
6995  11a9 2707          	jreq	L3413
6996                     ; 1729      			res_fl=0;
6998  11ab 4f            	clr	a
6999  11ac ae000b        	ldw	x,#_res_fl
7000  11af cd0000        	call	c_eewrc
7002  11b2               L3413:
7003                     ; 1734       if(res_fl_)
7005  11b2 725d000a      	tnz	_res_fl_
7006  11b6 2603          	jrne	L461
7007  11b8 cc172d        	jp	L5603
7008  11bb               L461:
7009                     ; 1736       	res_fl_=0;
7011  11bb 4f            	clr	a
7012  11bc ae000a        	ldw	x,#_res_fl_
7013  11bf cd0000        	call	c_eewrc
7015  11c2 ac2d172d      	jpf	L5603
7016  11c6               L1213:
7017                     ; 1739 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7019  11c6 b6cd          	ld	a,_mess+6
7020  11c8 c100f7        	cp	a,_adress
7021  11cb 2703          	jreq	L661
7022  11cd cc1443        	jp	L5513
7023  11d0               L661:
7025  11d0 b6ce          	ld	a,_mess+7
7026  11d2 c100f7        	cp	a,_adress
7027  11d5 2703          	jreq	L071
7028  11d7 cc1443        	jp	L5513
7029  11da               L071:
7031  11da b6cf          	ld	a,_mess+8
7032  11dc a1ee          	cp	a,#238
7033  11de 2703          	jreq	L271
7034  11e0 cc1443        	jp	L5513
7035  11e3               L271:
7037  11e3 b6d0          	ld	a,_mess+9
7038  11e5 b1d1          	cp	a,_mess+10
7039  11e7 2703          	jreq	L471
7040  11e9 cc1443        	jp	L5513
7041  11ec               L471:
7042                     ; 1741 	rotor_int++;
7044  11ec be17          	ldw	x,_rotor_int
7045  11ee 1c0001        	addw	x,#1
7046  11f1 bf17          	ldw	_rotor_int,x
7047                     ; 1742 	if((mess[9]&0xf0)==0x20)
7049  11f3 b6d0          	ld	a,_mess+9
7050  11f5 a4f0          	and	a,#240
7051  11f7 a120          	cp	a,#32
7052  11f9 2673          	jrne	L7513
7053                     ; 1744 		if((mess[9]&0x0f)==0x01)
7055  11fb b6d0          	ld	a,_mess+9
7056  11fd a40f          	and	a,#15
7057  11ff a101          	cp	a,#1
7058  1201 260d          	jrne	L1613
7059                     ; 1746 			ee_K[0][0]=adc_buff_[4];
7061  1203 ce0107        	ldw	x,_adc_buff_+8
7062  1206 89            	pushw	x
7063  1207 ae001a        	ldw	x,#_ee_K
7064  120a cd0000        	call	c_eewrw
7066  120d 85            	popw	x
7068  120e 204a          	jra	L3613
7069  1210               L1613:
7070                     ; 1748 		else if((mess[9]&0x0f)==0x02)
7072  1210 b6d0          	ld	a,_mess+9
7073  1212 a40f          	and	a,#15
7074  1214 a102          	cp	a,#2
7075  1216 260b          	jrne	L5613
7076                     ; 1750 			ee_K[0][1]++;
7078  1218 ce001c        	ldw	x,_ee_K+2
7079  121b 1c0001        	addw	x,#1
7080  121e cf001c        	ldw	_ee_K+2,x
7082  1221 2037          	jra	L3613
7083  1223               L5613:
7084                     ; 1752 		else if((mess[9]&0x0f)==0x03)
7086  1223 b6d0          	ld	a,_mess+9
7087  1225 a40f          	and	a,#15
7088  1227 a103          	cp	a,#3
7089  1229 260b          	jrne	L1713
7090                     ; 1754 			ee_K[0][1]+=10;
7092  122b ce001c        	ldw	x,_ee_K+2
7093  122e 1c000a        	addw	x,#10
7094  1231 cf001c        	ldw	_ee_K+2,x
7096  1234 2024          	jra	L3613
7097  1236               L1713:
7098                     ; 1756 		else if((mess[9]&0x0f)==0x04)
7100  1236 b6d0          	ld	a,_mess+9
7101  1238 a40f          	and	a,#15
7102  123a a104          	cp	a,#4
7103  123c 260b          	jrne	L5713
7104                     ; 1758 			ee_K[0][1]--;
7106  123e ce001c        	ldw	x,_ee_K+2
7107  1241 1d0001        	subw	x,#1
7108  1244 cf001c        	ldw	_ee_K+2,x
7110  1247 2011          	jra	L3613
7111  1249               L5713:
7112                     ; 1760 		else if((mess[9]&0x0f)==0x05)
7114  1249 b6d0          	ld	a,_mess+9
7115  124b a40f          	and	a,#15
7116  124d a105          	cp	a,#5
7117  124f 2609          	jrne	L3613
7118                     ; 1762 			ee_K[0][1]-=10;
7120  1251 ce001c        	ldw	x,_ee_K+2
7121  1254 1d000a        	subw	x,#10
7122  1257 cf001c        	ldw	_ee_K+2,x
7123  125a               L3613:
7124                     ; 1764 		granee(&ee_K[0][1],50,3000);									
7126  125a ae0bb8        	ldw	x,#3000
7127  125d 89            	pushw	x
7128  125e ae0032        	ldw	x,#50
7129  1261 89            	pushw	x
7130  1262 ae001c        	ldw	x,#_ee_K+2
7131  1265 cd00f6        	call	_granee
7133  1268 5b04          	addw	sp,#4
7135  126a ac281428      	jpf	L3023
7136  126e               L7513:
7137                     ; 1766 	else if((mess[9]&0xf0)==0x10)
7139  126e b6d0          	ld	a,_mess+9
7140  1270 a4f0          	and	a,#240
7141  1272 a110          	cp	a,#16
7142  1274 2673          	jrne	L5023
7143                     ; 1768 		if((mess[9]&0x0f)==0x01)
7145  1276 b6d0          	ld	a,_mess+9
7146  1278 a40f          	and	a,#15
7147  127a a101          	cp	a,#1
7148  127c 260d          	jrne	L7023
7149                     ; 1770 			ee_K[1][0]=adc_buff_[1];
7151  127e ce0101        	ldw	x,_adc_buff_+2
7152  1281 89            	pushw	x
7153  1282 ae001e        	ldw	x,#_ee_K+4
7154  1285 cd0000        	call	c_eewrw
7156  1288 85            	popw	x
7158  1289 204a          	jra	L1123
7159  128b               L7023:
7160                     ; 1772 		else if((mess[9]&0x0f)==0x02)
7162  128b b6d0          	ld	a,_mess+9
7163  128d a40f          	and	a,#15
7164  128f a102          	cp	a,#2
7165  1291 260b          	jrne	L3123
7166                     ; 1774 			ee_K[1][1]++;
7168  1293 ce0020        	ldw	x,_ee_K+6
7169  1296 1c0001        	addw	x,#1
7170  1299 cf0020        	ldw	_ee_K+6,x
7172  129c 2037          	jra	L1123
7173  129e               L3123:
7174                     ; 1776 		else if((mess[9]&0x0f)==0x03)
7176  129e b6d0          	ld	a,_mess+9
7177  12a0 a40f          	and	a,#15
7178  12a2 a103          	cp	a,#3
7179  12a4 260b          	jrne	L7123
7180                     ; 1778 			ee_K[1][1]+=10;
7182  12a6 ce0020        	ldw	x,_ee_K+6
7183  12a9 1c000a        	addw	x,#10
7184  12ac cf0020        	ldw	_ee_K+6,x
7186  12af 2024          	jra	L1123
7187  12b1               L7123:
7188                     ; 1780 		else if((mess[9]&0x0f)==0x04)
7190  12b1 b6d0          	ld	a,_mess+9
7191  12b3 a40f          	and	a,#15
7192  12b5 a104          	cp	a,#4
7193  12b7 260b          	jrne	L3223
7194                     ; 1782 			ee_K[1][1]--;
7196  12b9 ce0020        	ldw	x,_ee_K+6
7197  12bc 1d0001        	subw	x,#1
7198  12bf cf0020        	ldw	_ee_K+6,x
7200  12c2 2011          	jra	L1123
7201  12c4               L3223:
7202                     ; 1784 		else if((mess[9]&0x0f)==0x05)
7204  12c4 b6d0          	ld	a,_mess+9
7205  12c6 a40f          	and	a,#15
7206  12c8 a105          	cp	a,#5
7207  12ca 2609          	jrne	L1123
7208                     ; 1786 			ee_K[1][1]-=10;
7210  12cc ce0020        	ldw	x,_ee_K+6
7211  12cf 1d000a        	subw	x,#10
7212  12d2 cf0020        	ldw	_ee_K+6,x
7213  12d5               L1123:
7214                     ; 1791 		granee(&ee_K[1][1],10,30000);
7216  12d5 ae7530        	ldw	x,#30000
7217  12d8 89            	pushw	x
7218  12d9 ae000a        	ldw	x,#10
7219  12dc 89            	pushw	x
7220  12dd ae0020        	ldw	x,#_ee_K+6
7221  12e0 cd00f6        	call	_granee
7223  12e3 5b04          	addw	sp,#4
7225  12e5 ac281428      	jpf	L3023
7226  12e9               L5023:
7227                     ; 1795 	else if((mess[9]&0xf0)==0x00)
7229  12e9 b6d0          	ld	a,_mess+9
7230  12eb a5f0          	bcp	a,#240
7231  12ed 2673          	jrne	L3323
7232                     ; 1797 		if((mess[9]&0x0f)==0x01)
7234  12ef b6d0          	ld	a,_mess+9
7235  12f1 a40f          	and	a,#15
7236  12f3 a101          	cp	a,#1
7237  12f5 260d          	jrne	L5323
7238                     ; 1799 			ee_K[2][0]=adc_buff_[2];
7240  12f7 ce0103        	ldw	x,_adc_buff_+4
7241  12fa 89            	pushw	x
7242  12fb ae0022        	ldw	x,#_ee_K+8
7243  12fe cd0000        	call	c_eewrw
7245  1301 85            	popw	x
7247  1302 204a          	jra	L7323
7248  1304               L5323:
7249                     ; 1801 		else if((mess[9]&0x0f)==0x02)
7251  1304 b6d0          	ld	a,_mess+9
7252  1306 a40f          	and	a,#15
7253  1308 a102          	cp	a,#2
7254  130a 260b          	jrne	L1423
7255                     ; 1803 			ee_K[2][1]++;
7257  130c ce0024        	ldw	x,_ee_K+10
7258  130f 1c0001        	addw	x,#1
7259  1312 cf0024        	ldw	_ee_K+10,x
7261  1315 2037          	jra	L7323
7262  1317               L1423:
7263                     ; 1805 		else if((mess[9]&0x0f)==0x03)
7265  1317 b6d0          	ld	a,_mess+9
7266  1319 a40f          	and	a,#15
7267  131b a103          	cp	a,#3
7268  131d 260b          	jrne	L5423
7269                     ; 1807 			ee_K[2][1]+=10;
7271  131f ce0024        	ldw	x,_ee_K+10
7272  1322 1c000a        	addw	x,#10
7273  1325 cf0024        	ldw	_ee_K+10,x
7275  1328 2024          	jra	L7323
7276  132a               L5423:
7277                     ; 1809 		else if((mess[9]&0x0f)==0x04)
7279  132a b6d0          	ld	a,_mess+9
7280  132c a40f          	and	a,#15
7281  132e a104          	cp	a,#4
7282  1330 260b          	jrne	L1523
7283                     ; 1811 			ee_K[2][1]--;
7285  1332 ce0024        	ldw	x,_ee_K+10
7286  1335 1d0001        	subw	x,#1
7287  1338 cf0024        	ldw	_ee_K+10,x
7289  133b 2011          	jra	L7323
7290  133d               L1523:
7291                     ; 1813 		else if((mess[9]&0x0f)==0x05)
7293  133d b6d0          	ld	a,_mess+9
7294  133f a40f          	and	a,#15
7295  1341 a105          	cp	a,#5
7296  1343 2609          	jrne	L7323
7297                     ; 1815 			ee_K[2][1]-=10;
7299  1345 ce0024        	ldw	x,_ee_K+10
7300  1348 1d000a        	subw	x,#10
7301  134b cf0024        	ldw	_ee_K+10,x
7302  134e               L7323:
7303                     ; 1820 		granee(&ee_K[2][1],10,30000);
7305  134e ae7530        	ldw	x,#30000
7306  1351 89            	pushw	x
7307  1352 ae000a        	ldw	x,#10
7308  1355 89            	pushw	x
7309  1356 ae0024        	ldw	x,#_ee_K+10
7310  1359 cd00f6        	call	_granee
7312  135c 5b04          	addw	sp,#4
7314  135e ac281428      	jpf	L3023
7315  1362               L3323:
7316                     ; 1824 	else if((mess[9]&0xf0)==0x30)
7318  1362 b6d0          	ld	a,_mess+9
7319  1364 a4f0          	and	a,#240
7320  1366 a130          	cp	a,#48
7321  1368 265c          	jrne	L1623
7322                     ; 1826 		if((mess[9]&0x0f)==0x02)
7324  136a b6d0          	ld	a,_mess+9
7325  136c a40f          	and	a,#15
7326  136e a102          	cp	a,#2
7327  1370 260b          	jrne	L3623
7328                     ; 1828 			ee_K[3][1]++;
7330  1372 ce0028        	ldw	x,_ee_K+14
7331  1375 1c0001        	addw	x,#1
7332  1378 cf0028        	ldw	_ee_K+14,x
7334  137b 2037          	jra	L5623
7335  137d               L3623:
7336                     ; 1830 		else if((mess[9]&0x0f)==0x03)
7338  137d b6d0          	ld	a,_mess+9
7339  137f a40f          	and	a,#15
7340  1381 a103          	cp	a,#3
7341  1383 260b          	jrne	L7623
7342                     ; 1832 			ee_K[3][1]+=10;
7344  1385 ce0028        	ldw	x,_ee_K+14
7345  1388 1c000a        	addw	x,#10
7346  138b cf0028        	ldw	_ee_K+14,x
7348  138e 2024          	jra	L5623
7349  1390               L7623:
7350                     ; 1834 		else if((mess[9]&0x0f)==0x04)
7352  1390 b6d0          	ld	a,_mess+9
7353  1392 a40f          	and	a,#15
7354  1394 a104          	cp	a,#4
7355  1396 260b          	jrne	L3723
7356                     ; 1836 			ee_K[3][1]--;
7358  1398 ce0028        	ldw	x,_ee_K+14
7359  139b 1d0001        	subw	x,#1
7360  139e cf0028        	ldw	_ee_K+14,x
7362  13a1 2011          	jra	L5623
7363  13a3               L3723:
7364                     ; 1838 		else if((mess[9]&0x0f)==0x05)
7366  13a3 b6d0          	ld	a,_mess+9
7367  13a5 a40f          	and	a,#15
7368  13a7 a105          	cp	a,#5
7369  13a9 2609          	jrne	L5623
7370                     ; 1840 			ee_K[3][1]-=10;
7372  13ab ce0028        	ldw	x,_ee_K+14
7373  13ae 1d000a        	subw	x,#10
7374  13b1 cf0028        	ldw	_ee_K+14,x
7375  13b4               L5623:
7376                     ; 1842 		granee(&ee_K[3][1],300,517);									
7378  13b4 ae0205        	ldw	x,#517
7379  13b7 89            	pushw	x
7380  13b8 ae012c        	ldw	x,#300
7381  13bb 89            	pushw	x
7382  13bc ae0028        	ldw	x,#_ee_K+14
7383  13bf cd00f6        	call	_granee
7385  13c2 5b04          	addw	sp,#4
7387  13c4 2062          	jra	L3023
7388  13c6               L1623:
7389                     ; 1845 	else if((mess[9]&0xf0)==0x50)
7391  13c6 b6d0          	ld	a,_mess+9
7392  13c8 a4f0          	and	a,#240
7393  13ca a150          	cp	a,#80
7394  13cc 265a          	jrne	L3023
7395                     ; 1847 		if((mess[9]&0x0f)==0x02)
7397  13ce b6d0          	ld	a,_mess+9
7398  13d0 a40f          	and	a,#15
7399  13d2 a102          	cp	a,#2
7400  13d4 260b          	jrne	L5033
7401                     ; 1849 			ee_K[4][1]++;
7403  13d6 ce002c        	ldw	x,_ee_K+18
7404  13d9 1c0001        	addw	x,#1
7405  13dc cf002c        	ldw	_ee_K+18,x
7407  13df 2037          	jra	L7033
7408  13e1               L5033:
7409                     ; 1851 		else if((mess[9]&0x0f)==0x03)
7411  13e1 b6d0          	ld	a,_mess+9
7412  13e3 a40f          	and	a,#15
7413  13e5 a103          	cp	a,#3
7414  13e7 260b          	jrne	L1133
7415                     ; 1853 			ee_K[4][1]+=10;
7417  13e9 ce002c        	ldw	x,_ee_K+18
7418  13ec 1c000a        	addw	x,#10
7419  13ef cf002c        	ldw	_ee_K+18,x
7421  13f2 2024          	jra	L7033
7422  13f4               L1133:
7423                     ; 1855 		else if((mess[9]&0x0f)==0x04)
7425  13f4 b6d0          	ld	a,_mess+9
7426  13f6 a40f          	and	a,#15
7427  13f8 a104          	cp	a,#4
7428  13fa 260b          	jrne	L5133
7429                     ; 1857 			ee_K[4][1]--;
7431  13fc ce002c        	ldw	x,_ee_K+18
7432  13ff 1d0001        	subw	x,#1
7433  1402 cf002c        	ldw	_ee_K+18,x
7435  1405 2011          	jra	L7033
7436  1407               L5133:
7437                     ; 1859 		else if((mess[9]&0x0f)==0x05)
7439  1407 b6d0          	ld	a,_mess+9
7440  1409 a40f          	and	a,#15
7441  140b a105          	cp	a,#5
7442  140d 2609          	jrne	L7033
7443                     ; 1861 			ee_K[4][1]-=10;
7445  140f ce002c        	ldw	x,_ee_K+18
7446  1412 1d000a        	subw	x,#10
7447  1415 cf002c        	ldw	_ee_K+18,x
7448  1418               L7033:
7449                     ; 1863 		granee(&ee_K[4][1],10,30000);									
7451  1418 ae7530        	ldw	x,#30000
7452  141b 89            	pushw	x
7453  141c ae000a        	ldw	x,#10
7454  141f 89            	pushw	x
7455  1420 ae002c        	ldw	x,#_ee_K+18
7456  1423 cd00f6        	call	_granee
7458  1426 5b04          	addw	sp,#4
7459  1428               L3023:
7460                     ; 1866 	link_cnt=0;
7462  1428 5f            	clrw	x
7463  1429 bf6b          	ldw	_link_cnt,x
7464                     ; 1867      link=ON;
7466  142b 3555006d      	mov	_link,#85
7467                     ; 1868      if(res_fl_)
7469  142f 725d000a      	tnz	_res_fl_
7470  1433 2603          	jrne	L671
7471  1435 cc172d        	jp	L5603
7472  1438               L671:
7473                     ; 1870       	res_fl_=0;
7475  1438 4f            	clr	a
7476  1439 ae000a        	ldw	x,#_res_fl_
7477  143c cd0000        	call	c_eewrc
7479  143f ac2d172d      	jpf	L5603
7480  1443               L5513:
7481                     ; 1876 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7483  1443 b6cd          	ld	a,_mess+6
7484  1445 a1ff          	cp	a,#255
7485  1447 2703          	jreq	L002
7486  1449 cc14d7        	jp	L7233
7487  144c               L002:
7489  144c b6ce          	ld	a,_mess+7
7490  144e a1ff          	cp	a,#255
7491  1450 2703          	jreq	L202
7492  1452 cc14d7        	jp	L7233
7493  1455               L202:
7495  1455 b6cf          	ld	a,_mess+8
7496  1457 a162          	cp	a,#98
7497  1459 267c          	jrne	L7233
7498                     ; 1879 	tempSS=mess[9]+(mess[10]*256);
7500  145b b6d1          	ld	a,_mess+10
7501  145d 5f            	clrw	x
7502  145e 97            	ld	xl,a
7503  145f 4f            	clr	a
7504  1460 02            	rlwa	x,a
7505  1461 01            	rrwa	x,a
7506  1462 bbd0          	add	a,_mess+9
7507  1464 2401          	jrnc	L051
7508  1466 5c            	incw	x
7509  1467               L051:
7510  1467 02            	rlwa	x,a
7511  1468 1f03          	ldw	(OFST-4,sp),x
7512  146a 01            	rrwa	x,a
7513                     ; 1880 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7515  146b ce0014        	ldw	x,_ee_Umax
7516  146e 1303          	cpw	x,(OFST-4,sp)
7517  1470 270a          	jreq	L1333
7520  1472 1e03          	ldw	x,(OFST-4,sp)
7521  1474 89            	pushw	x
7522  1475 ae0014        	ldw	x,#_ee_Umax
7523  1478 cd0000        	call	c_eewrw
7525  147b 85            	popw	x
7526  147c               L1333:
7527                     ; 1881 	tempSS=mess[11]+(mess[12]*256);
7529  147c b6d3          	ld	a,_mess+12
7530  147e 5f            	clrw	x
7531  147f 97            	ld	xl,a
7532  1480 4f            	clr	a
7533  1481 02            	rlwa	x,a
7534  1482 01            	rrwa	x,a
7535  1483 bbd2          	add	a,_mess+11
7536  1485 2401          	jrnc	L251
7537  1487 5c            	incw	x
7538  1488               L251:
7539  1488 02            	rlwa	x,a
7540  1489 1f03          	ldw	(OFST-4,sp),x
7541  148b 01            	rrwa	x,a
7542                     ; 1882 	if(ee_dU!=tempSS) ee_dU=tempSS;
7544  148c ce0012        	ldw	x,_ee_dU
7545  148f 1303          	cpw	x,(OFST-4,sp)
7546  1491 270a          	jreq	L3333
7549  1493 1e03          	ldw	x,(OFST-4,sp)
7550  1495 89            	pushw	x
7551  1496 ae0012        	ldw	x,#_ee_dU
7552  1499 cd0000        	call	c_eewrw
7554  149c 85            	popw	x
7555  149d               L3333:
7556                     ; 1883 	if((mess[13]&0x0f)==0x5)
7558  149d b6d4          	ld	a,_mess+13
7559  149f a40f          	and	a,#15
7560  14a1 a105          	cp	a,#5
7561  14a3 261a          	jrne	L5333
7562                     ; 1885 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7564  14a5 ce0006        	ldw	x,_ee_AVT_MODE
7565  14a8 a30055        	cpw	x,#85
7566  14ab 2603          	jrne	L402
7567  14ad cc172d        	jp	L5603
7568  14b0               L402:
7571  14b0 ae0055        	ldw	x,#85
7572  14b3 89            	pushw	x
7573  14b4 ae0006        	ldw	x,#_ee_AVT_MODE
7574  14b7 cd0000        	call	c_eewrw
7576  14ba 85            	popw	x
7577  14bb ac2d172d      	jpf	L5603
7578  14bf               L5333:
7579                     ; 1887 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7581  14bf ce0006        	ldw	x,_ee_AVT_MODE
7582  14c2 a30055        	cpw	x,#85
7583  14c5 2703          	jreq	L602
7584  14c7 cc172d        	jp	L5603
7585  14ca               L602:
7588  14ca 5f            	clrw	x
7589  14cb 89            	pushw	x
7590  14cc ae0006        	ldw	x,#_ee_AVT_MODE
7591  14cf cd0000        	call	c_eewrw
7593  14d2 85            	popw	x
7594  14d3 ac2d172d      	jpf	L5603
7595  14d7               L7233:
7596                     ; 1890 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7598  14d7 b6cd          	ld	a,_mess+6
7599  14d9 a1ff          	cp	a,#255
7600  14db 2703          	jreq	L012
7601  14dd cc1593        	jp	L7433
7602  14e0               L012:
7604  14e0 b6ce          	ld	a,_mess+7
7605  14e2 a1ff          	cp	a,#255
7606  14e4 2703          	jreq	L212
7607  14e6 cc1593        	jp	L7433
7608  14e9               L212:
7610  14e9 b6cf          	ld	a,_mess+8
7611  14eb a126          	cp	a,#38
7612  14ed 2709          	jreq	L1533
7614  14ef b6cf          	ld	a,_mess+8
7615  14f1 a129          	cp	a,#41
7616  14f3 2703          	jreq	L412
7617  14f5 cc1593        	jp	L7433
7618  14f8               L412:
7619  14f8               L1533:
7620                     ; 1893 	tempSS=mess[9]+(mess[10]*256);
7622  14f8 b6d1          	ld	a,_mess+10
7623  14fa 5f            	clrw	x
7624  14fb 97            	ld	xl,a
7625  14fc 4f            	clr	a
7626  14fd 02            	rlwa	x,a
7627  14fe 01            	rrwa	x,a
7628  14ff bbd0          	add	a,_mess+9
7629  1501 2401          	jrnc	L451
7630  1503 5c            	incw	x
7631  1504               L451:
7632  1504 02            	rlwa	x,a
7633  1505 1f03          	ldw	(OFST-4,sp),x
7634  1507 01            	rrwa	x,a
7635                     ; 1895 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7637  1508 ce000c        	ldw	x,_ee_UAVT
7638  150b 1303          	cpw	x,(OFST-4,sp)
7639  150d 270a          	jreq	L3533
7642  150f 1e03          	ldw	x,(OFST-4,sp)
7643  1511 89            	pushw	x
7644  1512 ae000c        	ldw	x,#_ee_UAVT
7645  1515 cd0000        	call	c_eewrw
7647  1518 85            	popw	x
7648  1519               L3533:
7649                     ; 1896 	tempSS=(signed short)mess[11];
7651  1519 b6d2          	ld	a,_mess+11
7652  151b 5f            	clrw	x
7653  151c 97            	ld	xl,a
7654  151d 1f03          	ldw	(OFST-4,sp),x
7655                     ; 1897 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7657  151f ce0010        	ldw	x,_ee_tmax
7658  1522 1303          	cpw	x,(OFST-4,sp)
7659  1524 270a          	jreq	L5533
7662  1526 1e03          	ldw	x,(OFST-4,sp)
7663  1528 89            	pushw	x
7664  1529 ae0010        	ldw	x,#_ee_tmax
7665  152c cd0000        	call	c_eewrw
7667  152f 85            	popw	x
7668  1530               L5533:
7669                     ; 1898 	tempSS=(signed short)mess[12];
7671  1530 b6d3          	ld	a,_mess+12
7672  1532 5f            	clrw	x
7673  1533 97            	ld	xl,a
7674  1534 1f03          	ldw	(OFST-4,sp),x
7675                     ; 1899 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7677  1536 ce000e        	ldw	x,_ee_tsign
7678  1539 1303          	cpw	x,(OFST-4,sp)
7679  153b 270a          	jreq	L7533
7682  153d 1e03          	ldw	x,(OFST-4,sp)
7683  153f 89            	pushw	x
7684  1540 ae000e        	ldw	x,#_ee_tsign
7685  1543 cd0000        	call	c_eewrw
7687  1546 85            	popw	x
7688  1547               L7533:
7689                     ; 1902 	if(mess[8]==MEM_KF1)
7691  1547 b6cf          	ld	a,_mess+8
7692  1549 a126          	cp	a,#38
7693  154b 260e          	jrne	L1633
7694                     ; 1904 		if(ee_DEVICE!=0)ee_DEVICE=0;
7696  154d ce0004        	ldw	x,_ee_DEVICE
7697  1550 2709          	jreq	L1633
7700  1552 5f            	clrw	x
7701  1553 89            	pushw	x
7702  1554 ae0004        	ldw	x,#_ee_DEVICE
7703  1557 cd0000        	call	c_eewrw
7705  155a 85            	popw	x
7706  155b               L1633:
7707                     ; 1907 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7709  155b b6cf          	ld	a,_mess+8
7710  155d a129          	cp	a,#41
7711  155f 2703          	jreq	L612
7712  1561 cc172d        	jp	L5603
7713  1564               L612:
7714                     ; 1909 		if(ee_DEVICE!=1)ee_DEVICE=1;
7716  1564 ce0004        	ldw	x,_ee_DEVICE
7717  1567 a30001        	cpw	x,#1
7718  156a 270b          	jreq	L7633
7721  156c ae0001        	ldw	x,#1
7722  156f 89            	pushw	x
7723  1570 ae0004        	ldw	x,#_ee_DEVICE
7724  1573 cd0000        	call	c_eewrw
7726  1576 85            	popw	x
7727  1577               L7633:
7728                     ; 1910 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7730  1577 b6d4          	ld	a,_mess+13
7731  1579 5f            	clrw	x
7732  157a 97            	ld	xl,a
7733  157b c30002        	cpw	x,_ee_IMAXVENT
7734  157e 2603          	jrne	L022
7735  1580 cc172d        	jp	L5603
7736  1583               L022:
7739  1583 b6d4          	ld	a,_mess+13
7740  1585 5f            	clrw	x
7741  1586 97            	ld	xl,a
7742  1587 89            	pushw	x
7743  1588 ae0002        	ldw	x,#_ee_IMAXVENT
7744  158b cd0000        	call	c_eewrw
7746  158e 85            	popw	x
7747  158f ac2d172d      	jpf	L5603
7748  1593               L7433:
7749                     ; 1915 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7751  1593 b6cd          	ld	a,_mess+6
7752  1595 c100f7        	cp	a,_adress
7753  1598 262d          	jrne	L5733
7755  159a b6ce          	ld	a,_mess+7
7756  159c c100f7        	cp	a,_adress
7757  159f 2626          	jrne	L5733
7759  15a1 b6cf          	ld	a,_mess+8
7760  15a3 a116          	cp	a,#22
7761  15a5 2620          	jrne	L5733
7763  15a7 b6d0          	ld	a,_mess+9
7764  15a9 a163          	cp	a,#99
7765  15ab 261a          	jrne	L5733
7766                     ; 1917 	flags&=0b11100001;
7768  15ad b605          	ld	a,_flags
7769  15af a4e1          	and	a,#225
7770  15b1 b705          	ld	_flags,a
7771                     ; 1918 	tsign_cnt=0;
7773  15b3 5f            	clrw	x
7774  15b4 bf59          	ldw	_tsign_cnt,x
7775                     ; 1919 	tmax_cnt=0;
7777  15b6 5f            	clrw	x
7778  15b7 bf57          	ldw	_tmax_cnt,x
7779                     ; 1920 	umax_cnt=0;
7781  15b9 5f            	clrw	x
7782  15ba bf70          	ldw	_umax_cnt,x
7783                     ; 1921 	umin_cnt=0;
7785  15bc 5f            	clrw	x
7786  15bd bf6e          	ldw	_umin_cnt,x
7787                     ; 1922 	led_drv_cnt=30;
7789  15bf 351e0016      	mov	_led_drv_cnt,#30
7791  15c3 ac2d172d      	jpf	L5603
7792  15c7               L5733:
7793                     ; 1925 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7795  15c7 b6cd          	ld	a,_mess+6
7796  15c9 c100f7        	cp	a,_adress
7797  15cc 2620          	jrne	L1043
7799  15ce b6ce          	ld	a,_mess+7
7800  15d0 c100f7        	cp	a,_adress
7801  15d3 2619          	jrne	L1043
7803  15d5 b6cf          	ld	a,_mess+8
7804  15d7 a116          	cp	a,#22
7805  15d9 2613          	jrne	L1043
7807  15db b6d0          	ld	a,_mess+9
7808  15dd a164          	cp	a,#100
7809  15df 260d          	jrne	L1043
7810                     ; 1927 	vent_resurs=0;
7812  15e1 5f            	clrw	x
7813  15e2 89            	pushw	x
7814  15e3 ae0000        	ldw	x,#_vent_resurs
7815  15e6 cd0000        	call	c_eewrw
7817  15e9 85            	popw	x
7819  15ea ac2d172d      	jpf	L5603
7820  15ee               L1043:
7821                     ; 1931 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7823  15ee b6cd          	ld	a,_mess+6
7824  15f0 a1ff          	cp	a,#255
7825  15f2 265f          	jrne	L5043
7827  15f4 b6ce          	ld	a,_mess+7
7828  15f6 a1ff          	cp	a,#255
7829  15f8 2659          	jrne	L5043
7831  15fa b6cf          	ld	a,_mess+8
7832  15fc a116          	cp	a,#22
7833  15fe 2653          	jrne	L5043
7835  1600 b6d0          	ld	a,_mess+9
7836  1602 a116          	cp	a,#22
7837  1604 264d          	jrne	L5043
7838                     ; 1933 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7840  1606 b6d1          	ld	a,_mess+10
7841  1608 a155          	cp	a,#85
7842  160a 260f          	jrne	L7043
7844  160c b6d2          	ld	a,_mess+11
7845  160e a155          	cp	a,#85
7846  1610 2609          	jrne	L7043
7849  1612 be68          	ldw	x,__x_
7850  1614 1c0001        	addw	x,#1
7851  1617 bf68          	ldw	__x_,x
7853  1619 2024          	jra	L1143
7854  161b               L7043:
7855                     ; 1934 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7857  161b b6d1          	ld	a,_mess+10
7858  161d a166          	cp	a,#102
7859  161f 260f          	jrne	L3143
7861  1621 b6d2          	ld	a,_mess+11
7862  1623 a166          	cp	a,#102
7863  1625 2609          	jrne	L3143
7866  1627 be68          	ldw	x,__x_
7867  1629 1d0001        	subw	x,#1
7868  162c bf68          	ldw	__x_,x
7870  162e 200f          	jra	L1143
7871  1630               L3143:
7872                     ; 1935 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7874  1630 b6d1          	ld	a,_mess+10
7875  1632 a177          	cp	a,#119
7876  1634 2609          	jrne	L1143
7878  1636 b6d2          	ld	a,_mess+11
7879  1638 a177          	cp	a,#119
7880  163a 2603          	jrne	L1143
7883  163c 5f            	clrw	x
7884  163d bf68          	ldw	__x_,x
7885  163f               L1143:
7886                     ; 1936      gran(&_x_,-XMAX,XMAX);
7888  163f ae0019        	ldw	x,#25
7889  1642 89            	pushw	x
7890  1643 aeffe7        	ldw	x,#65511
7891  1646 89            	pushw	x
7892  1647 ae0068        	ldw	x,#__x_
7893  164a cd00d5        	call	_gran
7895  164d 5b04          	addw	sp,#4
7897  164f ac2d172d      	jpf	L5603
7898  1653               L5043:
7899                     ; 1938 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7901  1653 b6cd          	ld	a,_mess+6
7902  1655 c100f7        	cp	a,_adress
7903  1658 2635          	jrne	L3243
7905  165a b6ce          	ld	a,_mess+7
7906  165c c100f7        	cp	a,_adress
7907  165f 262e          	jrne	L3243
7909  1661 b6cf          	ld	a,_mess+8
7910  1663 a116          	cp	a,#22
7911  1665 2628          	jrne	L3243
7913  1667 b6d0          	ld	a,_mess+9
7914  1669 b1d1          	cp	a,_mess+10
7915  166b 2622          	jrne	L3243
7917  166d b6d0          	ld	a,_mess+9
7918  166f a1ee          	cp	a,#238
7919  1671 261c          	jrne	L3243
7920                     ; 1940 	rotor_int++;
7922  1673 be17          	ldw	x,_rotor_int
7923  1675 1c0001        	addw	x,#1
7924  1678 bf17          	ldw	_rotor_int,x
7925                     ; 1941      tempI=pwm_u;
7927                     ; 1943 	UU_AVT=Un;
7929  167a ce000e        	ldw	x,_Un
7930  167d 89            	pushw	x
7931  167e ae0008        	ldw	x,#_UU_AVT
7932  1681 cd0000        	call	c_eewrw
7934  1684 85            	popw	x
7935                     ; 1944 	delay_ms(100);
7937  1685 ae0064        	ldw	x,#100
7938  1688 cd0121        	call	_delay_ms
7941  168b ac2d172d      	jpf	L5603
7942  168f               L3243:
7943                     ; 1950 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7945  168f b6ce          	ld	a,_mess+7
7946  1691 a1da          	cp	a,#218
7947  1693 2653          	jrne	L7243
7949  1695 b6cd          	ld	a,_mess+6
7950  1697 c100f7        	cp	a,_adress
7951  169a 274c          	jreq	L7243
7953  169c b6cd          	ld	a,_mess+6
7954  169e a106          	cp	a,#6
7955  16a0 2446          	jruge	L7243
7956                     ; 1952 	i_main_bps_cnt[mess[6]]=0;
7958  16a2 b6cd          	ld	a,_mess+6
7959  16a4 5f            	clrw	x
7960  16a5 97            	ld	xl,a
7961  16a6 6f13          	clr	(_i_main_bps_cnt,x)
7962                     ; 1953 	i_main_flag[mess[6]]=1;
7964  16a8 b6cd          	ld	a,_mess+6
7965  16aa 5f            	clrw	x
7966  16ab 97            	ld	xl,a
7967  16ac a601          	ld	a,#1
7968  16ae e71e          	ld	(_i_main_flag,x),a
7969                     ; 1954 	if(bMAIN)
7971                     	btst	_bMAIN
7972  16b5 2476          	jruge	L5603
7973                     ; 1956 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7975  16b7 b6d0          	ld	a,_mess+9
7976  16b9 5f            	clrw	x
7977  16ba 97            	ld	xl,a
7978  16bb 4f            	clr	a
7979  16bc 02            	rlwa	x,a
7980  16bd 1f01          	ldw	(OFST-6,sp),x
7981  16bf b6cf          	ld	a,_mess+8
7982  16c1 5f            	clrw	x
7983  16c2 97            	ld	xl,a
7984  16c3 72fb01        	addw	x,(OFST-6,sp)
7985  16c6 b6cd          	ld	a,_mess+6
7986  16c8 905f          	clrw	y
7987  16ca 9097          	ld	yl,a
7988  16cc 9058          	sllw	y
7989  16ce 90ef24        	ldw	(_i_main,y),x
7990                     ; 1957 		i_main[adress]=I;
7992  16d1 c600f7        	ld	a,_adress
7993  16d4 5f            	clrw	x
7994  16d5 97            	ld	xl,a
7995  16d6 58            	sllw	x
7996  16d7 90ce0010      	ldw	y,_I
7997  16db ef24          	ldw	(_i_main,x),y
7998                     ; 1958      	i_main_flag[adress]=1;
8000  16dd c600f7        	ld	a,_adress
8001  16e0 5f            	clrw	x
8002  16e1 97            	ld	xl,a
8003  16e2 a601          	ld	a,#1
8004  16e4 e71e          	ld	(_i_main_flag,x),a
8005  16e6 2045          	jra	L5603
8006  16e8               L7243:
8007                     ; 1962 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8009  16e8 b6ce          	ld	a,_mess+7
8010  16ea a1db          	cp	a,#219
8011  16ec 263f          	jrne	L5603
8013  16ee b6cd          	ld	a,_mess+6
8014  16f0 c100f7        	cp	a,_adress
8015  16f3 2738          	jreq	L5603
8017  16f5 b6cd          	ld	a,_mess+6
8018  16f7 a106          	cp	a,#6
8019  16f9 2432          	jruge	L5603
8020                     ; 1964 	i_main_bps_cnt[mess[6]]=0;
8022  16fb b6cd          	ld	a,_mess+6
8023  16fd 5f            	clrw	x
8024  16fe 97            	ld	xl,a
8025  16ff 6f13          	clr	(_i_main_bps_cnt,x)
8026                     ; 1965 	i_main_flag[mess[6]]=1;		
8028  1701 b6cd          	ld	a,_mess+6
8029  1703 5f            	clrw	x
8030  1704 97            	ld	xl,a
8031  1705 a601          	ld	a,#1
8032  1707 e71e          	ld	(_i_main_flag,x),a
8033                     ; 1966 	if(bMAIN)
8035                     	btst	_bMAIN
8036  170e 241d          	jruge	L5603
8037                     ; 1968 		if(mess[9]==0)i_main_flag[i]=1;
8039  1710 3dd0          	tnz	_mess+9
8040  1712 260a          	jrne	L1443
8043  1714 7b07          	ld	a,(OFST+0,sp)
8044  1716 5f            	clrw	x
8045  1717 97            	ld	xl,a
8046  1718 a601          	ld	a,#1
8047  171a e71e          	ld	(_i_main_flag,x),a
8049  171c 2006          	jra	L3443
8050  171e               L1443:
8051                     ; 1969 		else i_main_flag[i]=0;
8053  171e 7b07          	ld	a,(OFST+0,sp)
8054  1720 5f            	clrw	x
8055  1721 97            	ld	xl,a
8056  1722 6f1e          	clr	(_i_main_flag,x)
8057  1724               L3443:
8058                     ; 1970 		i_main_flag[adress]=1;
8060  1724 c600f7        	ld	a,_adress
8061  1727 5f            	clrw	x
8062  1728 97            	ld	xl,a
8063  1729 a601          	ld	a,#1
8064  172b e71e          	ld	(_i_main_flag,x),a
8065  172d               L5603:
8066                     ; 1976 can_in_an_end:
8066                     ; 1977 bCAN_RX=0;
8068  172d 3f04          	clr	_bCAN_RX
8069                     ; 1978 }   
8072  172f 5b07          	addw	sp,#7
8073  1731 81            	ret
8096                     ; 1981 void t4_init(void){
8097                     	switch	.text
8098  1732               _t4_init:
8102                     ; 1982 	TIM4->PSCR = 4;
8104  1732 35045345      	mov	21317,#4
8105                     ; 1983 	TIM4->ARR= 61;
8107  1736 353d5346      	mov	21318,#61
8108                     ; 1984 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8110  173a 72105341      	bset	21313,#0
8111                     ; 1986 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8113  173e 35855340      	mov	21312,#133
8114                     ; 1988 }
8117  1742 81            	ret
8140                     ; 1991 void t1_init(void)
8140                     ; 1992 {
8141                     	switch	.text
8142  1743               _t1_init:
8146                     ; 1993 TIM1->ARRH= 0x03;
8148  1743 35035262      	mov	21090,#3
8149                     ; 1994 TIM1->ARRL= 0xff;
8151  1747 35ff5263      	mov	21091,#255
8152                     ; 1995 TIM1->CCR1H= 0x00;	
8154  174b 725f5265      	clr	21093
8155                     ; 1996 TIM1->CCR1L= 0xff;
8157  174f 35ff5266      	mov	21094,#255
8158                     ; 1997 TIM1->CCR2H= 0x00;	
8160  1753 725f5267      	clr	21095
8161                     ; 1998 TIM1->CCR2L= 0x00;
8163  1757 725f5268      	clr	21096
8164                     ; 1999 TIM1->CCR3H= 0x00;	
8166  175b 725f5269      	clr	21097
8167                     ; 2000 TIM1->CCR3L= 0x64;
8169  175f 3564526a      	mov	21098,#100
8170                     ; 2002 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8172  1763 35685258      	mov	21080,#104
8173                     ; 2003 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8175  1767 35685259      	mov	21081,#104
8176                     ; 2004 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8178  176b 3568525a      	mov	21082,#104
8179                     ; 2005 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8181  176f 3511525c      	mov	21084,#17
8182                     ; 2006 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8184  1773 3501525d      	mov	21085,#1
8185                     ; 2007 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8187  1777 35815250      	mov	21072,#129
8188                     ; 2008 TIM1->BKR|= TIM1_BKR_AOE;
8190  177b 721c526d      	bset	21101,#6
8191                     ; 2009 }
8194  177f 81            	ret
8219                     ; 2013 void adc2_init(void)
8219                     ; 2014 {
8220                     	switch	.text
8221  1780               _adc2_init:
8225                     ; 2015 adc_plazma[0]++;
8227  1780 beb9          	ldw	x,_adc_plazma
8228  1782 1c0001        	addw	x,#1
8229  1785 bfb9          	ldw	_adc_plazma,x
8230                     ; 2039 GPIOB->DDR&=~(1<<4);
8232  1787 72195007      	bres	20487,#4
8233                     ; 2040 GPIOB->CR1&=~(1<<4);
8235  178b 72195008      	bres	20488,#4
8236                     ; 2041 GPIOB->CR2&=~(1<<4);
8238  178f 72195009      	bres	20489,#4
8239                     ; 2043 GPIOB->DDR&=~(1<<5);
8241  1793 721b5007      	bres	20487,#5
8242                     ; 2044 GPIOB->CR1&=~(1<<5);
8244  1797 721b5008      	bres	20488,#5
8245                     ; 2045 GPIOB->CR2&=~(1<<5);
8247  179b 721b5009      	bres	20489,#5
8248                     ; 2047 GPIOB->DDR&=~(1<<6);
8250  179f 721d5007      	bres	20487,#6
8251                     ; 2048 GPIOB->CR1&=~(1<<6);
8253  17a3 721d5008      	bres	20488,#6
8254                     ; 2049 GPIOB->CR2&=~(1<<6);
8256  17a7 721d5009      	bres	20489,#6
8257                     ; 2051 GPIOB->DDR&=~(1<<7);
8259  17ab 721f5007      	bres	20487,#7
8260                     ; 2052 GPIOB->CR1&=~(1<<7);
8262  17af 721f5008      	bres	20488,#7
8263                     ; 2053 GPIOB->CR2&=~(1<<7);
8265  17b3 721f5009      	bres	20489,#7
8266                     ; 2055 GPIOB->DDR&=~(1<<2);
8268  17b7 72155007      	bres	20487,#2
8269                     ; 2056 GPIOB->CR1&=~(1<<2);
8271  17bb 72155008      	bres	20488,#2
8272                     ; 2057 GPIOB->CR2&=~(1<<2);
8274  17bf 72155009      	bres	20489,#2
8275                     ; 2066 ADC2->TDRL=0xff;
8277  17c3 35ff5407      	mov	21511,#255
8278                     ; 2068 ADC2->CR2=0x08;
8280  17c7 35085402      	mov	21506,#8
8281                     ; 2069 ADC2->CR1=0x40;
8283  17cb 35405401      	mov	21505,#64
8284                     ; 2072 	if(adc_ch==5)ADC2->CSR=0x22;
8286  17cf b6c6          	ld	a,_adc_ch
8287  17d1 a105          	cp	a,#5
8288  17d3 2606          	jrne	L5743
8291  17d5 35225400      	mov	21504,#34
8293  17d9 2007          	jra	L7743
8294  17db               L5743:
8295                     ; 2073 	else ADC2->CSR=0x20+adc_ch+3;
8297  17db b6c6          	ld	a,_adc_ch
8298  17dd ab23          	add	a,#35
8299  17df c75400        	ld	21504,a
8300  17e2               L7743:
8301                     ; 2075 	ADC2->CR1|=1;
8303  17e2 72105401      	bset	21505,#0
8304                     ; 2076 	ADC2->CR1|=1;
8306  17e6 72105401      	bset	21505,#0
8307                     ; 2079 adc_plazma[1]=adc_ch;
8309  17ea b6c6          	ld	a,_adc_ch
8310  17ec 5f            	clrw	x
8311  17ed 97            	ld	xl,a
8312  17ee bfbb          	ldw	_adc_plazma+2,x
8313                     ; 2080 }
8316  17f0 81            	ret
8352                     ; 2088 @far @interrupt void TIM4_UPD_Interrupt (void) 
8352                     ; 2089 {
8354                     	switch	.text
8355  17f1               f_TIM4_UPD_Interrupt:
8359                     ; 2090 TIM4->SR1&=~TIM4_SR1_UIF;
8361  17f1 72115342      	bres	21314,#0
8362                     ; 2092 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8364  17f5 3c12          	inc	_pwm_vent_cnt
8365  17f7 b612          	ld	a,_pwm_vent_cnt
8366  17f9 a10a          	cp	a,#10
8367  17fb 2502          	jrult	L1153
8370  17fd 3f12          	clr	_pwm_vent_cnt
8371  17ff               L1153:
8372                     ; 2093 GPIOB->ODR|=(1<<3);
8374  17ff 72165005      	bset	20485,#3
8375                     ; 2094 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8377  1803 b612          	ld	a,_pwm_vent_cnt
8378  1805 a105          	cp	a,#5
8379  1807 2504          	jrult	L3153
8382  1809 72175005      	bres	20485,#3
8383  180d               L3153:
8384                     ; 2098 if(++t0_cnt00>=10)
8386  180d 9c            	rvf
8387  180e ce0000        	ldw	x,_t0_cnt00
8388  1811 1c0001        	addw	x,#1
8389  1814 cf0000        	ldw	_t0_cnt00,x
8390  1817 a3000a        	cpw	x,#10
8391  181a 2f08          	jrslt	L5153
8392                     ; 2100 	t0_cnt00=0;
8394  181c 5f            	clrw	x
8395  181d cf0000        	ldw	_t0_cnt00,x
8396                     ; 2101 	b1000Hz=1;
8398  1820 72100004      	bset	_b1000Hz
8399  1824               L5153:
8400                     ; 2104 if(++t0_cnt0>=100)
8402  1824 9c            	rvf
8403  1825 ce0002        	ldw	x,_t0_cnt0
8404  1828 1c0001        	addw	x,#1
8405  182b cf0002        	ldw	_t0_cnt0,x
8406  182e a30064        	cpw	x,#100
8407  1831 2f54          	jrslt	L7153
8408                     ; 2106 	t0_cnt0=0;
8410  1833 5f            	clrw	x
8411  1834 cf0002        	ldw	_t0_cnt0,x
8412                     ; 2107 	b100Hz=1;
8414  1837 72100009      	bset	_b100Hz
8415                     ; 2109 	if(++t0_cnt1>=10)
8417  183b 725c0004      	inc	_t0_cnt1
8418  183f c60004        	ld	a,_t0_cnt1
8419  1842 a10a          	cp	a,#10
8420  1844 2508          	jrult	L1253
8421                     ; 2111 		t0_cnt1=0;
8423  1846 725f0004      	clr	_t0_cnt1
8424                     ; 2112 		b10Hz=1;
8426  184a 72100008      	bset	_b10Hz
8427  184e               L1253:
8428                     ; 2115 	if(++t0_cnt2>=20)
8430  184e 725c0005      	inc	_t0_cnt2
8431  1852 c60005        	ld	a,_t0_cnt2
8432  1855 a114          	cp	a,#20
8433  1857 2508          	jrult	L3253
8434                     ; 2117 		t0_cnt2=0;
8436  1859 725f0005      	clr	_t0_cnt2
8437                     ; 2118 		b5Hz=1;
8439  185d 72100007      	bset	_b5Hz
8440  1861               L3253:
8441                     ; 2122 	if(++t0_cnt4>=50)
8443  1861 725c0007      	inc	_t0_cnt4
8444  1865 c60007        	ld	a,_t0_cnt4
8445  1868 a132          	cp	a,#50
8446  186a 2508          	jrult	L5253
8447                     ; 2124 		t0_cnt4=0;
8449  186c 725f0007      	clr	_t0_cnt4
8450                     ; 2125 		b2Hz=1;
8452  1870 72100006      	bset	_b2Hz
8453  1874               L5253:
8454                     ; 2128 	if(++t0_cnt3>=100)
8456  1874 725c0006      	inc	_t0_cnt3
8457  1878 c60006        	ld	a,_t0_cnt3
8458  187b a164          	cp	a,#100
8459  187d 2508          	jrult	L7153
8460                     ; 2130 		t0_cnt3=0;
8462  187f 725f0006      	clr	_t0_cnt3
8463                     ; 2131 		b1Hz=1;
8465  1883 72100005      	bset	_b1Hz
8466  1887               L7153:
8467                     ; 2137 }
8470  1887 80            	iret
8495                     ; 2140 @far @interrupt void CAN_RX_Interrupt (void) 
8495                     ; 2141 {
8496                     	switch	.text
8497  1888               f_CAN_RX_Interrupt:
8501                     ; 2143 CAN->PSR= 7;									// page 7 - read messsage
8503  1888 35075427      	mov	21543,#7
8504                     ; 2145 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8506  188c ae000e        	ldw	x,#14
8507  188f               L432:
8508  188f d65427        	ld	a,(21543,x)
8509  1892 e7c6          	ld	(_mess-1,x),a
8510  1894 5a            	decw	x
8511  1895 26f8          	jrne	L432
8512                     ; 2156 bCAN_RX=1;
8514  1897 35010004      	mov	_bCAN_RX,#1
8515                     ; 2157 CAN->RFR|=(1<<5);
8517  189b 721a5424      	bset	21540,#5
8518                     ; 2159 }
8521  189f 80            	iret
8544                     ; 2162 @far @interrupt void CAN_TX_Interrupt (void) 
8544                     ; 2163 {
8545                     	switch	.text
8546  18a0               f_CAN_TX_Interrupt:
8550                     ; 2164 if((CAN->TSR)&(1<<0))
8552  18a0 c65422        	ld	a,21538
8553  18a3 a501          	bcp	a,#1
8554  18a5 2708          	jreq	L1553
8555                     ; 2166 	bTX_FREE=1;	
8557  18a7 35010003      	mov	_bTX_FREE,#1
8558                     ; 2168 	CAN->TSR|=(1<<0);
8560  18ab 72105422      	bset	21538,#0
8561  18af               L1553:
8562                     ; 2170 }
8565  18af 80            	iret
8645                     ; 2173 @far @interrupt void ADC2_EOC_Interrupt (void) {
8646                     	switch	.text
8647  18b0               f_ADC2_EOC_Interrupt:
8649       0000000d      OFST:	set	13
8650  18b0 be00          	ldw	x,c_x
8651  18b2 89            	pushw	x
8652  18b3 be00          	ldw	x,c_y
8653  18b5 89            	pushw	x
8654  18b6 be02          	ldw	x,c_lreg+2
8655  18b8 89            	pushw	x
8656  18b9 be00          	ldw	x,c_lreg
8657  18bb 89            	pushw	x
8658  18bc 520d          	subw	sp,#13
8661                     ; 2178 adc_plazma[2]++;
8663  18be bebd          	ldw	x,_adc_plazma+4
8664  18c0 1c0001        	addw	x,#1
8665  18c3 bfbd          	ldw	_adc_plazma+4,x
8666                     ; 2185 ADC2->CSR&=~(1<<7);
8668  18c5 721f5400      	bres	21504,#7
8669                     ; 2187 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8671  18c9 c65405        	ld	a,21509
8672  18cc b703          	ld	c_lreg+3,a
8673  18ce 3f02          	clr	c_lreg+2
8674  18d0 3f01          	clr	c_lreg+1
8675  18d2 3f00          	clr	c_lreg
8676  18d4 96            	ldw	x,sp
8677  18d5 1c0001        	addw	x,#OFST-12
8678  18d8 cd0000        	call	c_rtol
8680  18db c65404        	ld	a,21508
8681  18de 5f            	clrw	x
8682  18df 97            	ld	xl,a
8683  18e0 90ae0100      	ldw	y,#256
8684  18e4 cd0000        	call	c_umul
8686  18e7 96            	ldw	x,sp
8687  18e8 1c0001        	addw	x,#OFST-12
8688  18eb cd0000        	call	c_ladd
8690  18ee 96            	ldw	x,sp
8691  18ef 1c000a        	addw	x,#OFST-3
8692  18f2 cd0000        	call	c_rtol
8694                     ; 2192 if(adr_drv_stat==1)
8696  18f5 b602          	ld	a,_adr_drv_stat
8697  18f7 a101          	cp	a,#1
8698  18f9 260b          	jrne	L1163
8699                     ; 2194 	adr_drv_stat=2;
8701  18fb 35020002      	mov	_adr_drv_stat,#2
8702                     ; 2195 	adc_buff_[0]=temp_adc;
8704  18ff 1e0c          	ldw	x,(OFST-1,sp)
8705  1901 cf00ff        	ldw	_adc_buff_,x
8707  1904 2020          	jra	L3163
8708  1906               L1163:
8709                     ; 2198 else if(adr_drv_stat==3)
8711  1906 b602          	ld	a,_adr_drv_stat
8712  1908 a103          	cp	a,#3
8713  190a 260b          	jrne	L5163
8714                     ; 2200 	adr_drv_stat=4;
8716  190c 35040002      	mov	_adr_drv_stat,#4
8717                     ; 2201 	adc_buff_[1]=temp_adc;
8719  1910 1e0c          	ldw	x,(OFST-1,sp)
8720  1912 cf0101        	ldw	_adc_buff_+2,x
8722  1915 200f          	jra	L3163
8723  1917               L5163:
8724                     ; 2204 else if(adr_drv_stat==5)
8726  1917 b602          	ld	a,_adr_drv_stat
8727  1919 a105          	cp	a,#5
8728  191b 2609          	jrne	L3163
8729                     ; 2206 	adr_drv_stat=6;
8731  191d 35060002      	mov	_adr_drv_stat,#6
8732                     ; 2207 	adc_buff_[9]=temp_adc;
8734  1921 1e0c          	ldw	x,(OFST-1,sp)
8735  1923 cf0111        	ldw	_adc_buff_+18,x
8736  1926               L3163:
8737                     ; 2210 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8739  1926 b6b7          	ld	a,_adc_cnt_cnt
8740  1928 5f            	clrw	x
8741  1929 97            	ld	xl,a
8742  192a 58            	sllw	x
8743  192b 1f03          	ldw	(OFST-10,sp),x
8744  192d b6c6          	ld	a,_adc_ch
8745  192f 97            	ld	xl,a
8746  1930 a610          	ld	a,#16
8747  1932 42            	mul	x,a
8748  1933 72fb03        	addw	x,(OFST-10,sp)
8749  1936 160c          	ldw	y,(OFST-1,sp)
8750  1938 df0056        	ldw	(_adc_buff_buff,x),y
8751                     ; 2212 adc_ch++;
8753  193b 3cc6          	inc	_adc_ch
8754                     ; 2213 if(adc_ch>=6)
8756  193d b6c6          	ld	a,_adc_ch
8757  193f a106          	cp	a,#6
8758  1941 2516          	jrult	L3263
8759                     ; 2215 	adc_ch=0;
8761  1943 3fc6          	clr	_adc_ch
8762                     ; 2216 	adc_cnt_cnt++;
8764  1945 3cb7          	inc	_adc_cnt_cnt
8765                     ; 2217 	if(adc_cnt_cnt>=8)
8767  1947 b6b7          	ld	a,_adc_cnt_cnt
8768  1949 a108          	cp	a,#8
8769  194b 250c          	jrult	L3263
8770                     ; 2219 		adc_cnt_cnt=0;
8772  194d 3fb7          	clr	_adc_cnt_cnt
8773                     ; 2220 		adc_cnt++;
8775  194f 3cc5          	inc	_adc_cnt
8776                     ; 2221 		if(adc_cnt>=16)
8778  1951 b6c5          	ld	a,_adc_cnt
8779  1953 a110          	cp	a,#16
8780  1955 2502          	jrult	L3263
8781                     ; 2223 			adc_cnt=0;
8783  1957 3fc5          	clr	_adc_cnt
8784  1959               L3263:
8785                     ; 2227 if(adc_cnt_cnt==0)
8787  1959 3db7          	tnz	_adc_cnt_cnt
8788  195b 2660          	jrne	L1363
8789                     ; 2231 	tempSS=0;
8791  195d ae0000        	ldw	x,#0
8792  1960 1f07          	ldw	(OFST-6,sp),x
8793  1962 ae0000        	ldw	x,#0
8794  1965 1f05          	ldw	(OFST-8,sp),x
8795                     ; 2232 	for(i=0;i<8;i++)
8797  1967 0f09          	clr	(OFST-4,sp)
8798  1969               L3363:
8799                     ; 2234 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8801  1969 7b09          	ld	a,(OFST-4,sp)
8802  196b 5f            	clrw	x
8803  196c 97            	ld	xl,a
8804  196d 58            	sllw	x
8805  196e 1f03          	ldw	(OFST-10,sp),x
8806  1970 b6c6          	ld	a,_adc_ch
8807  1972 97            	ld	xl,a
8808  1973 a610          	ld	a,#16
8809  1975 42            	mul	x,a
8810  1976 72fb03        	addw	x,(OFST-10,sp)
8811  1979 de0056        	ldw	x,(_adc_buff_buff,x)
8812  197c cd0000        	call	c_itolx
8814  197f 96            	ldw	x,sp
8815  1980 1c0005        	addw	x,#OFST-8
8816  1983 cd0000        	call	c_lgadd
8818                     ; 2232 	for(i=0;i<8;i++)
8820  1986 0c09          	inc	(OFST-4,sp)
8823  1988 7b09          	ld	a,(OFST-4,sp)
8824  198a a108          	cp	a,#8
8825  198c 25db          	jrult	L3363
8826                     ; 2236 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8828  198e 96            	ldw	x,sp
8829  198f 1c0005        	addw	x,#OFST-8
8830  1992 cd0000        	call	c_ltor
8832  1995 a603          	ld	a,#3
8833  1997 cd0000        	call	c_lrsh
8835  199a be02          	ldw	x,c_lreg+2
8836  199c b6c5          	ld	a,_adc_cnt
8837  199e 905f          	clrw	y
8838  19a0 9097          	ld	yl,a
8839  19a2 9058          	sllw	y
8840  19a4 1703          	ldw	(OFST-10,sp),y
8841  19a6 b6c6          	ld	a,_adc_ch
8842  19a8 905f          	clrw	y
8843  19aa 9097          	ld	yl,a
8844  19ac 9058          	sllw	y
8845  19ae 9058          	sllw	y
8846  19b0 9058          	sllw	y
8847  19b2 9058          	sllw	y
8848  19b4 9058          	sllw	y
8849  19b6 72f903        	addw	y,(OFST-10,sp)
8850  19b9 90df0113      	ldw	(_adc_buff,y),x
8851  19bd               L1363:
8852                     ; 2240 if((adc_cnt&0x03)==0)
8854  19bd b6c5          	ld	a,_adc_cnt
8855  19bf a503          	bcp	a,#3
8856  19c1 264b          	jrne	L1463
8857                     ; 2244 	tempSS=0;
8859  19c3 ae0000        	ldw	x,#0
8860  19c6 1f07          	ldw	(OFST-6,sp),x
8861  19c8 ae0000        	ldw	x,#0
8862  19cb 1f05          	ldw	(OFST-8,sp),x
8863                     ; 2245 	for(i=0;i<16;i++)
8865  19cd 0f09          	clr	(OFST-4,sp)
8866  19cf               L3463:
8867                     ; 2247 		tempSS+=(signed long)adc_buff[adc_ch][i];
8869  19cf 7b09          	ld	a,(OFST-4,sp)
8870  19d1 5f            	clrw	x
8871  19d2 97            	ld	xl,a
8872  19d3 58            	sllw	x
8873  19d4 1f03          	ldw	(OFST-10,sp),x
8874  19d6 b6c6          	ld	a,_adc_ch
8875  19d8 97            	ld	xl,a
8876  19d9 a620          	ld	a,#32
8877  19db 42            	mul	x,a
8878  19dc 72fb03        	addw	x,(OFST-10,sp)
8879  19df de0113        	ldw	x,(_adc_buff,x)
8880  19e2 cd0000        	call	c_itolx
8882  19e5 96            	ldw	x,sp
8883  19e6 1c0005        	addw	x,#OFST-8
8884  19e9 cd0000        	call	c_lgadd
8886                     ; 2245 	for(i=0;i<16;i++)
8888  19ec 0c09          	inc	(OFST-4,sp)
8891  19ee 7b09          	ld	a,(OFST-4,sp)
8892  19f0 a110          	cp	a,#16
8893  19f2 25db          	jrult	L3463
8894                     ; 2249 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8896  19f4 96            	ldw	x,sp
8897  19f5 1c0005        	addw	x,#OFST-8
8898  19f8 cd0000        	call	c_ltor
8900  19fb a604          	ld	a,#4
8901  19fd cd0000        	call	c_lrsh
8903  1a00 be02          	ldw	x,c_lreg+2
8904  1a02 b6c6          	ld	a,_adc_ch
8905  1a04 905f          	clrw	y
8906  1a06 9097          	ld	yl,a
8907  1a08 9058          	sllw	y
8908  1a0a 90df00ff      	ldw	(_adc_buff_,y),x
8909  1a0e               L1463:
8910                     ; 2256 if(adc_ch==0)adc_buff_5=temp_adc;
8912  1a0e 3dc6          	tnz	_adc_ch
8913  1a10 2605          	jrne	L1563
8916  1a12 1e0c          	ldw	x,(OFST-1,sp)
8917  1a14 cf00fd        	ldw	_adc_buff_5,x
8918  1a17               L1563:
8919                     ; 2257 if(adc_ch==2)adc_buff_1=temp_adc;
8921  1a17 b6c6          	ld	a,_adc_ch
8922  1a19 a102          	cp	a,#2
8923  1a1b 2605          	jrne	L3563
8926  1a1d 1e0c          	ldw	x,(OFST-1,sp)
8927  1a1f cf00fb        	ldw	_adc_buff_1,x
8928  1a22               L3563:
8929                     ; 2259 adc_plazma_short++;
8931  1a22 bec3          	ldw	x,_adc_plazma_short
8932  1a24 1c0001        	addw	x,#1
8933  1a27 bfc3          	ldw	_adc_plazma_short,x
8934                     ; 2261 }
8937  1a29 5b0d          	addw	sp,#13
8938  1a2b 85            	popw	x
8939  1a2c bf00          	ldw	c_lreg,x
8940  1a2e 85            	popw	x
8941  1a2f bf02          	ldw	c_lreg+2,x
8942  1a31 85            	popw	x
8943  1a32 bf00          	ldw	c_y,x
8944  1a34 85            	popw	x
8945  1a35 bf00          	ldw	c_x,x
8946  1a37 80            	iret
9004                     ; 2270 main()
9004                     ; 2271 {
9006                     	switch	.text
9007  1a38               _main:
9011                     ; 2273 CLK->ECKR|=1;
9013  1a38 721050c1      	bset	20673,#0
9015  1a3c               L7663:
9016                     ; 2274 while((CLK->ECKR & 2) == 0);
9018  1a3c c650c1        	ld	a,20673
9019  1a3f a502          	bcp	a,#2
9020  1a41 27f9          	jreq	L7663
9021                     ; 2275 CLK->SWCR|=2;
9023  1a43 721250c5      	bset	20677,#1
9024                     ; 2276 CLK->SWR=0xB4;
9026  1a47 35b450c4      	mov	20676,#180
9027                     ; 2278 delay_ms(200);
9029  1a4b ae00c8        	ldw	x,#200
9030  1a4e cd0121        	call	_delay_ms
9032                     ; 2279 FLASH_DUKR=0xae;
9034  1a51 35ae5064      	mov	_FLASH_DUKR,#174
9035                     ; 2280 FLASH_DUKR=0x56;
9037  1a55 35565064      	mov	_FLASH_DUKR,#86
9038                     ; 2281 enableInterrupts();
9041  1a59 9a            rim
9043                     ; 2284 adr_drv_v3();
9046  1a5a cd0d38        	call	_adr_drv_v3
9048                     ; 2288 t4_init();
9050  1a5d cd1732        	call	_t4_init
9052                     ; 2290 		GPIOG->DDR|=(1<<0);
9054  1a60 72105020      	bset	20512,#0
9055                     ; 2291 		GPIOG->CR1|=(1<<0);
9057  1a64 72105021      	bset	20513,#0
9058                     ; 2292 		GPIOG->CR2&=~(1<<0);	
9060  1a68 72115022      	bres	20514,#0
9061                     ; 2295 		GPIOG->DDR&=~(1<<1);
9063  1a6c 72135020      	bres	20512,#1
9064                     ; 2296 		GPIOG->CR1|=(1<<1);
9066  1a70 72125021      	bset	20513,#1
9067                     ; 2297 		GPIOG->CR2&=~(1<<1);
9069  1a74 72135022      	bres	20514,#1
9070                     ; 2299 init_CAN();
9072  1a78 cd0f28        	call	_init_CAN
9074                     ; 2304 GPIOC->DDR|=(1<<1);
9076  1a7b 7212500c      	bset	20492,#1
9077                     ; 2305 GPIOC->CR1|=(1<<1);
9079  1a7f 7212500d      	bset	20493,#1
9080                     ; 2306 GPIOC->CR2|=(1<<1);
9082  1a83 7212500e      	bset	20494,#1
9083                     ; 2308 GPIOC->DDR|=(1<<2);
9085  1a87 7214500c      	bset	20492,#2
9086                     ; 2309 GPIOC->CR1|=(1<<2);
9088  1a8b 7214500d      	bset	20493,#2
9089                     ; 2310 GPIOC->CR2|=(1<<2);
9091  1a8f 7214500e      	bset	20494,#2
9092                     ; 2317 t1_init();
9094  1a93 cd1743        	call	_t1_init
9096                     ; 2319 GPIOA->DDR|=(1<<5);
9098  1a96 721a5002      	bset	20482,#5
9099                     ; 2320 GPIOA->CR1|=(1<<5);
9101  1a9a 721a5003      	bset	20483,#5
9102                     ; 2321 GPIOA->CR2&=~(1<<5);
9104  1a9e 721b5004      	bres	20484,#5
9105                     ; 2327 GPIOB->DDR&=~(1<<3);
9107  1aa2 72175007      	bres	20487,#3
9108                     ; 2328 GPIOB->CR1&=~(1<<3);
9110  1aa6 72175008      	bres	20488,#3
9111                     ; 2329 GPIOB->CR2&=~(1<<3);
9113  1aaa 72175009      	bres	20489,#3
9114                     ; 2331 GPIOC->DDR|=(1<<3);
9116  1aae 7216500c      	bset	20492,#3
9117                     ; 2332 GPIOC->CR1|=(1<<3);
9119  1ab2 7216500d      	bset	20493,#3
9120                     ; 2333 GPIOC->CR2|=(1<<3);
9122  1ab6 7216500e      	bset	20494,#3
9123  1aba               L3763:
9124                     ; 2339 	if(b1000Hz)
9126                     	btst	_b1000Hz
9127  1abf 2407          	jruge	L7763
9128                     ; 2341 		b1000Hz=0;
9130  1ac1 72110004      	bres	_b1000Hz
9131                     ; 2343 		adc2_init();
9133  1ac5 cd1780        	call	_adc2_init
9135  1ac8               L7763:
9136                     ; 2346 	if(bCAN_RX)
9138  1ac8 3d04          	tnz	_bCAN_RX
9139  1aca 2705          	jreq	L1073
9140                     ; 2348 		bCAN_RX=0;
9142  1acc 3f04          	clr	_bCAN_RX
9143                     ; 2349 		can_in_an();	
9145  1ace cd1085        	call	_can_in_an
9147  1ad1               L1073:
9148                     ; 2351 	if(b100Hz)
9150                     	btst	_b100Hz
9151  1ad6 2407          	jruge	L3073
9152                     ; 2353 		b100Hz=0;
9154  1ad8 72110009      	bres	_b100Hz
9155                     ; 2363 		can_tx_hndl();
9157  1adc cd101b        	call	_can_tx_hndl
9159  1adf               L3073:
9160                     ; 2366 	if(b10Hz)
9162                     	btst	_b10Hz
9163  1ae4 2425          	jruge	L5073
9164                     ; 2368 		b10Hz=0;
9166  1ae6 72110008      	bres	_b10Hz
9167                     ; 2370 		matemat();
9169  1aea cd0869        	call	_matemat
9171                     ; 2371 		led_drv(); 
9173  1aed cd03ee        	call	_led_drv
9175                     ; 2372 	  link_drv();
9177  1af0 cd04dc        	call	_link_drv
9179                     ; 2374 	  JP_drv();
9181  1af3 cd0451        	call	_JP_drv
9183                     ; 2375 	  flags_drv();
9185  1af6 cd0ced        	call	_flags_drv
9187                     ; 2377 		if(main_cnt10<100)main_cnt10++;
9189  1af9 9c            	rvf
9190  1afa ce0253        	ldw	x,_main_cnt10
9191  1afd a30064        	cpw	x,#100
9192  1b00 2e09          	jrsge	L5073
9195  1b02 ce0253        	ldw	x,_main_cnt10
9196  1b05 1c0001        	addw	x,#1
9197  1b08 cf0253        	ldw	_main_cnt10,x
9198  1b0b               L5073:
9199                     ; 2380 	if(b5Hz)
9201                     	btst	_b5Hz
9202  1b10 241c          	jruge	L1173
9203                     ; 2382 		b5Hz=0;
9205  1b12 72110007      	bres	_b5Hz
9206                     ; 2384 		pwr_drv();		//воздействие на силу
9208  1b16 cd06ac        	call	_pwr_drv
9210                     ; 2385 		led_hndl();
9212  1b19 cd0163        	call	_led_hndl
9214                     ; 2387 		vent_drv();
9216  1b1c cd0534        	call	_vent_drv
9218                     ; 2389 		if(main_cnt1<1000)main_cnt1++;
9220  1b1f 9c            	rvf
9221  1b20 be5b          	ldw	x,_main_cnt1
9222  1b22 a303e8        	cpw	x,#1000
9223  1b25 2e07          	jrsge	L1173
9226  1b27 be5b          	ldw	x,_main_cnt1
9227  1b29 1c0001        	addw	x,#1
9228  1b2c bf5b          	ldw	_main_cnt1,x
9229  1b2e               L1173:
9230                     ; 2392 	if(b2Hz)
9232                     	btst	_b2Hz
9233  1b33 2404          	jruge	L5173
9234                     ; 2394 		b2Hz=0;
9236  1b35 72110006      	bres	_b2Hz
9237  1b39               L5173:
9238                     ; 2403 	if(b1Hz)
9240                     	btst	_b1Hz
9241  1b3e 2503cc1aba    	jruge	L3763
9242                     ; 2405 		b1Hz=0;
9244  1b43 72110005      	bres	_b1Hz
9245                     ; 2407 	  pwr_hndl();		//вычисление воздействий на силу
9247  1b47 cd06f1        	call	_pwr_hndl
9249                     ; 2408 		temper_drv();			//вычисление аварий температуры
9251  1b4a cd0a5a        	call	_temper_drv
9253                     ; 2409 		u_drv();
9255  1b4d cd0b31        	call	_u_drv
9257                     ; 2411 		if(main_cnt<1000)main_cnt++;
9259  1b50 9c            	rvf
9260  1b51 ce0255        	ldw	x,_main_cnt
9261  1b54 a303e8        	cpw	x,#1000
9262  1b57 2e09          	jrsge	L1273
9265  1b59 ce0255        	ldw	x,_main_cnt
9266  1b5c 1c0001        	addw	x,#1
9267  1b5f cf0255        	ldw	_main_cnt,x
9268  1b62               L1273:
9269                     ; 2412   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9271  1b62 b66d          	ld	a,_link
9272  1b64 a1aa          	cp	a,#170
9273  1b66 2706          	jreq	L5273
9275  1b68 b654          	ld	a,_jp_mode
9276  1b6a a103          	cp	a,#3
9277  1b6c 2603          	jrne	L3273
9278  1b6e               L5273:
9281  1b6e cd0c4e        	call	_apv_hndl
9283  1b71               L3273:
9284                     ; 2415   		can_error_cnt++;
9286  1b71 3c73          	inc	_can_error_cnt
9287                     ; 2416   		if(can_error_cnt>=10)
9289  1b73 b673          	ld	a,_can_error_cnt
9290  1b75 a10a          	cp	a,#10
9291  1b77 2505          	jrult	L7273
9292                     ; 2418   			can_error_cnt=0;
9294  1b79 3f73          	clr	_can_error_cnt
9295                     ; 2419 				init_CAN();
9297  1b7b cd0f28        	call	_init_CAN
9299  1b7e               L7273:
9300                     ; 2429 		vent_resurs_hndl();
9302  1b7e cd0000        	call	_vent_resurs_hndl
9304  1b81 acba1aba      	jpf	L3763
10542                     	xdef	_main
10543                     	xdef	f_ADC2_EOC_Interrupt
10544                     	xdef	f_CAN_TX_Interrupt
10545                     	xdef	f_CAN_RX_Interrupt
10546                     	xdef	f_TIM4_UPD_Interrupt
10547                     	xdef	_adc2_init
10548                     	xdef	_t1_init
10549                     	xdef	_t4_init
10550                     	xdef	_can_in_an
10551                     	xdef	_can_tx_hndl
10552                     	xdef	_can_transmit
10553                     	xdef	_init_CAN
10554                     	xdef	_adr_drv_v3
10555                     	xdef	_adr_drv_v4
10556                     	xdef	_flags_drv
10557                     	xdef	_apv_hndl
10558                     	xdef	_apv_stop
10559                     	xdef	_apv_start
10560                     	xdef	_u_drv
10561                     	xdef	_temper_drv
10562                     	xdef	_matemat
10563                     	xdef	_pwr_hndl
10564                     	xdef	_pwr_drv
10565                     	xdef	_vent_drv
10566                     	xdef	_link_drv
10567                     	xdef	_JP_drv
10568                     	xdef	_led_drv
10569                     	xdef	_led_hndl
10570                     	xdef	_delay_ms
10571                     	xdef	_granee
10572                     	xdef	_gran
10573                     	xdef	_vent_resurs_hndl
10574                     	switch	.ubsct
10575  0001               _debug_info_to_uku:
10576  0001 000000000000  	ds.b	6
10577                     	xdef	_debug_info_to_uku
10578  0007               _pwm_u_cnt:
10579  0007 00            	ds.b	1
10580                     	xdef	_pwm_u_cnt
10581  0008               _vent_resurs_tx_cnt:
10582  0008 00            	ds.b	1
10583                     	xdef	_vent_resurs_tx_cnt
10584                     	switch	.bss
10585  0000               _vent_resurs_buff:
10586  0000 00000000      	ds.b	4
10587                     	xdef	_vent_resurs_buff
10588                     	switch	.ubsct
10589  0009               _vent_resurs_sec_cnt:
10590  0009 0000          	ds.b	2
10591                     	xdef	_vent_resurs_sec_cnt
10592                     .eeprom:	section	.data
10593  0000               _vent_resurs:
10594  0000 0000          	ds.b	2
10595                     	xdef	_vent_resurs
10596  0002               _ee_IMAXVENT:
10597  0002 0000          	ds.b	2
10598                     	xdef	_ee_IMAXVENT
10599                     	switch	.ubsct
10600  000b               _bps_class:
10601  000b 00            	ds.b	1
10602                     	xdef	_bps_class
10603  000c               _vent_pwm_integr_cnt:
10604  000c 0000          	ds.b	2
10605                     	xdef	_vent_pwm_integr_cnt
10606  000e               _vent_pwm_integr:
10607  000e 0000          	ds.b	2
10608                     	xdef	_vent_pwm_integr
10609  0010               _vent_pwm:
10610  0010 0000          	ds.b	2
10611                     	xdef	_vent_pwm
10612  0012               _pwm_vent_cnt:
10613  0012 00            	ds.b	1
10614                     	xdef	_pwm_vent_cnt
10615                     	switch	.eeprom
10616  0004               _ee_DEVICE:
10617  0004 0000          	ds.b	2
10618                     	xdef	_ee_DEVICE
10619  0006               _ee_AVT_MODE:
10620  0006 0000          	ds.b	2
10621                     	xdef	_ee_AVT_MODE
10622                     	switch	.ubsct
10623  0013               _i_main_bps_cnt:
10624  0013 000000000000  	ds.b	6
10625                     	xdef	_i_main_bps_cnt
10626  0019               _i_main_sigma:
10627  0019 0000          	ds.b	2
10628                     	xdef	_i_main_sigma
10629  001b               _i_main_num_of_bps:
10630  001b 00            	ds.b	1
10631                     	xdef	_i_main_num_of_bps
10632  001c               _i_main_avg:
10633  001c 0000          	ds.b	2
10634                     	xdef	_i_main_avg
10635  001e               _i_main_flag:
10636  001e 000000000000  	ds.b	6
10637                     	xdef	_i_main_flag
10638  0024               _i_main:
10639  0024 000000000000  	ds.b	12
10640                     	xdef	_i_main
10641  0030               _x:
10642  0030 000000000000  	ds.b	12
10643                     	xdef	_x
10644                     	xdef	_volum_u_main_
10645                     	switch	.eeprom
10646  0008               _UU_AVT:
10647  0008 0000          	ds.b	2
10648                     	xdef	_UU_AVT
10649                     	switch	.ubsct
10650  003c               _cnt_net_drv:
10651  003c 00            	ds.b	1
10652                     	xdef	_cnt_net_drv
10653                     	switch	.bit
10654  0001               _bMAIN:
10655  0001 00            	ds.b	1
10656                     	xdef	_bMAIN
10657                     	switch	.ubsct
10658  003d               _plazma_int:
10659  003d 000000000000  	ds.b	6
10660                     	xdef	_plazma_int
10661                     	xdef	_rotor_int
10662  0043               _led_green_buff:
10663  0043 00000000      	ds.b	4
10664                     	xdef	_led_green_buff
10665  0047               _led_red_buff:
10666  0047 00000000      	ds.b	4
10667                     	xdef	_led_red_buff
10668                     	xdef	_led_drv_cnt
10669                     	xdef	_led_green
10670                     	xdef	_led_red
10671  004b               _res_fl_cnt:
10672  004b 00            	ds.b	1
10673                     	xdef	_res_fl_cnt
10674                     	xdef	_bRES_
10675                     	xdef	_bRES
10676                     	switch	.eeprom
10677  000a               _res_fl_:
10678  000a 00            	ds.b	1
10679                     	xdef	_res_fl_
10680  000b               _res_fl:
10681  000b 00            	ds.b	1
10682                     	xdef	_res_fl
10683                     	switch	.ubsct
10684  004c               _cnt_apv_off:
10685  004c 00            	ds.b	1
10686                     	xdef	_cnt_apv_off
10687                     	switch	.bit
10688  0002               _bAPV:
10689  0002 00            	ds.b	1
10690                     	xdef	_bAPV
10691                     	switch	.ubsct
10692  004d               _apv_cnt_:
10693  004d 0000          	ds.b	2
10694                     	xdef	_apv_cnt_
10695  004f               _apv_cnt:
10696  004f 000000        	ds.b	3
10697                     	xdef	_apv_cnt
10698                     	xdef	_bBL_IPS
10699                     	switch	.bit
10700  0003               _bBL:
10701  0003 00            	ds.b	1
10702                     	xdef	_bBL
10703                     	switch	.ubsct
10704  0052               _cnt_JP1:
10705  0052 00            	ds.b	1
10706                     	xdef	_cnt_JP1
10707  0053               _cnt_JP0:
10708  0053 00            	ds.b	1
10709                     	xdef	_cnt_JP0
10710  0054               _jp_mode:
10711  0054 00            	ds.b	1
10712                     	xdef	_jp_mode
10713  0055               _pwm_u_:
10714  0055 0000          	ds.b	2
10715                     	xdef	_pwm_u_
10716                     	xdef	_pwm_i
10717                     	xdef	_pwm_u
10718  0057               _tmax_cnt:
10719  0057 0000          	ds.b	2
10720                     	xdef	_tmax_cnt
10721  0059               _tsign_cnt:
10722  0059 0000          	ds.b	2
10723                     	xdef	_tsign_cnt
10724                     	switch	.eeprom
10725  000c               _ee_UAVT:
10726  000c 0000          	ds.b	2
10727                     	xdef	_ee_UAVT
10728  000e               _ee_tsign:
10729  000e 0000          	ds.b	2
10730                     	xdef	_ee_tsign
10731  0010               _ee_tmax:
10732  0010 0000          	ds.b	2
10733                     	xdef	_ee_tmax
10734  0012               _ee_dU:
10735  0012 0000          	ds.b	2
10736                     	xdef	_ee_dU
10737  0014               _ee_Umax:
10738  0014 0000          	ds.b	2
10739                     	xdef	_ee_Umax
10740  0016               _ee_TZAS:
10741  0016 0000          	ds.b	2
10742                     	xdef	_ee_TZAS
10743                     	switch	.ubsct
10744  005b               _main_cnt1:
10745  005b 0000          	ds.b	2
10746                     	xdef	_main_cnt1
10747  005d               _off_bp_cnt:
10748  005d 00            	ds.b	1
10749                     	xdef	_off_bp_cnt
10750                     	xdef	_vol_i_temp_avar
10751  005e               _flags_tu_cnt_off:
10752  005e 00            	ds.b	1
10753                     	xdef	_flags_tu_cnt_off
10754  005f               _flags_tu_cnt_on:
10755  005f 00            	ds.b	1
10756                     	xdef	_flags_tu_cnt_on
10757  0060               _vol_i_temp:
10758  0060 0000          	ds.b	2
10759                     	xdef	_vol_i_temp
10760  0062               _vol_u_temp:
10761  0062 0000          	ds.b	2
10762                     	xdef	_vol_u_temp
10763                     	switch	.eeprom
10764  0018               __x_ee_:
10765  0018 0000          	ds.b	2
10766                     	xdef	__x_ee_
10767                     	switch	.ubsct
10768  0064               __x_cnt:
10769  0064 0000          	ds.b	2
10770                     	xdef	__x_cnt
10771  0066               __x__:
10772  0066 0000          	ds.b	2
10773                     	xdef	__x__
10774  0068               __x_:
10775  0068 0000          	ds.b	2
10776                     	xdef	__x_
10777  006a               _flags_tu:
10778  006a 00            	ds.b	1
10779                     	xdef	_flags_tu
10780                     	xdef	_flags
10781  006b               _link_cnt:
10782  006b 0000          	ds.b	2
10783                     	xdef	_link_cnt
10784  006d               _link:
10785  006d 00            	ds.b	1
10786                     	xdef	_link
10787  006e               _umin_cnt:
10788  006e 0000          	ds.b	2
10789                     	xdef	_umin_cnt
10790  0070               _umax_cnt:
10791  0070 0000          	ds.b	2
10792                     	xdef	_umax_cnt
10793                     	switch	.eeprom
10794  001a               _ee_K:
10795  001a 000000000000  	ds.b	20
10796                     	xdef	_ee_K
10797                     	switch	.ubsct
10798  0072               _T:
10799  0072 00            	ds.b	1
10800                     	xdef	_T
10801                     	switch	.bss
10802  0004               _Uin:
10803  0004 0000          	ds.b	2
10804                     	xdef	_Uin
10805  0006               _Usum:
10806  0006 0000          	ds.b	2
10807                     	xdef	_Usum
10808  0008               _U_out_const:
10809  0008 0000          	ds.b	2
10810                     	xdef	_U_out_const
10811  000a               _Unecc:
10812  000a 0000          	ds.b	2
10813                     	xdef	_Unecc
10814  000c               _Ui:
10815  000c 0000          	ds.b	2
10816                     	xdef	_Ui
10817  000e               _Un:
10818  000e 0000          	ds.b	2
10819                     	xdef	_Un
10820  0010               _I:
10821  0010 0000          	ds.b	2
10822                     	xdef	_I
10823                     	switch	.ubsct
10824  0073               _can_error_cnt:
10825  0073 00            	ds.b	1
10826                     	xdef	_can_error_cnt
10827                     	xdef	_bCAN_RX
10828  0074               _tx_busy_cnt:
10829  0074 00            	ds.b	1
10830                     	xdef	_tx_busy_cnt
10831                     	xdef	_bTX_FREE
10832  0075               _can_buff_rd_ptr:
10833  0075 00            	ds.b	1
10834                     	xdef	_can_buff_rd_ptr
10835  0076               _can_buff_wr_ptr:
10836  0076 00            	ds.b	1
10837                     	xdef	_can_buff_wr_ptr
10838  0077               _can_out_buff:
10839  0077 000000000000  	ds.b	64
10840                     	xdef	_can_out_buff
10841                     	switch	.bss
10842  0012               _pwm_u_buff_cnt:
10843  0012 00            	ds.b	1
10844                     	xdef	_pwm_u_buff_cnt
10845  0013               _pwm_u_buff_ptr:
10846  0013 00            	ds.b	1
10847                     	xdef	_pwm_u_buff_ptr
10848  0014               _pwm_u_buff_:
10849  0014 0000          	ds.b	2
10850                     	xdef	_pwm_u_buff_
10851  0016               _pwm_u_buff:
10852  0016 000000000000  	ds.b	64
10853                     	xdef	_pwm_u_buff
10854                     	switch	.ubsct
10855  00b7               _adc_cnt_cnt:
10856  00b7 00            	ds.b	1
10857                     	xdef	_adc_cnt_cnt
10858                     	switch	.bss
10859  0056               _adc_buff_buff:
10860  0056 000000000000  	ds.b	160
10861                     	xdef	_adc_buff_buff
10862  00f6               _adress_error:
10863  00f6 00            	ds.b	1
10864                     	xdef	_adress_error
10865  00f7               _adress:
10866  00f7 00            	ds.b	1
10867                     	xdef	_adress
10868  00f8               _adr:
10869  00f8 000000        	ds.b	3
10870                     	xdef	_adr
10871                     	xdef	_adr_drv_stat
10872                     	xdef	_led_ind
10873                     	switch	.ubsct
10874  00b8               _led_ind_cnt:
10875  00b8 00            	ds.b	1
10876                     	xdef	_led_ind_cnt
10877  00b9               _adc_plazma:
10878  00b9 000000000000  	ds.b	10
10879                     	xdef	_adc_plazma
10880  00c3               _adc_plazma_short:
10881  00c3 0000          	ds.b	2
10882                     	xdef	_adc_plazma_short
10883  00c5               _adc_cnt:
10884  00c5 00            	ds.b	1
10885                     	xdef	_adc_cnt
10886  00c6               _adc_ch:
10887  00c6 00            	ds.b	1
10888                     	xdef	_adc_ch
10889                     	switch	.bss
10890  00fb               _adc_buff_1:
10891  00fb 0000          	ds.b	2
10892                     	xdef	_adc_buff_1
10893  00fd               _adc_buff_5:
10894  00fd 0000          	ds.b	2
10895                     	xdef	_adc_buff_5
10896  00ff               _adc_buff_:
10897  00ff 000000000000  	ds.b	20
10898                     	xdef	_adc_buff_
10899  0113               _adc_buff:
10900  0113 000000000000  	ds.b	320
10901                     	xdef	_adc_buff
10902  0253               _main_cnt10:
10903  0253 0000          	ds.b	2
10904                     	xdef	_main_cnt10
10905  0255               _main_cnt:
10906  0255 0000          	ds.b	2
10907                     	xdef	_main_cnt
10908                     	switch	.ubsct
10909  00c7               _mess:
10910  00c7 000000000000  	ds.b	14
10911                     	xdef	_mess
10912                     	switch	.bit
10913  0004               _b1000Hz:
10914  0004 00            	ds.b	1
10915                     	xdef	_b1000Hz
10916  0005               _b1Hz:
10917  0005 00            	ds.b	1
10918                     	xdef	_b1Hz
10919  0006               _b2Hz:
10920  0006 00            	ds.b	1
10921                     	xdef	_b2Hz
10922  0007               _b5Hz:
10923  0007 00            	ds.b	1
10924                     	xdef	_b5Hz
10925  0008               _b10Hz:
10926  0008 00            	ds.b	1
10927                     	xdef	_b10Hz
10928  0009               _b100Hz:
10929  0009 00            	ds.b	1
10930                     	xdef	_b100Hz
10931                     	xdef	_t0_cnt4
10932                     	xdef	_t0_cnt3
10933                     	xdef	_t0_cnt2
10934                     	xdef	_t0_cnt1
10935                     	xdef	_t0_cnt0
10936                     	xdef	_t0_cnt00
10937                     	xref	_abs
10938                     	xdef	_bVENT_BLOCK
10939                     	xref.b	c_lreg
10940                     	xref.b	c_x
10941                     	xref.b	c_y
10961                     	xref	c_lrsh
10962                     	xref	c_umul
10963                     	xref	c_lgsub
10964                     	xref	c_lgrsh
10965                     	xref	c_lgadd
10966                     	xref	c_idiv
10967                     	xref	c_sdivx
10968                     	xref	c_imul
10969                     	xref	c_lsbc
10970                     	xref	c_ladd
10971                     	xref	c_lsub
10972                     	xref	c_ldiv
10973                     	xref	c_lgmul
10974                     	xref	c_itolx
10975                     	xref	c_eewrc
10976                     	xref	c_ltor
10977                     	xref	c_lgadc
10978                     	xref	c_rtol
10979                     	xref	c_vmul
10980                     	xref	c_eewrw
10981                     	xref	c_lcmp
10982                     	xref	c_uitolx
10983                     	end
