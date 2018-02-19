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
3703  0014               L64:
3704  0014 00000190      	dc.l	400
3705                     ; 672 void vent_drv(void)
3705                     ; 673 {
3706                     	switch	.text
3707  0534               _vent_drv:
3709  0534 520c          	subw	sp,#12
3710       0000000c      OFST:	set	12
3713                     ; 676 	short vent_pwm_i_necc=400;
3715  0536 ae0190        	ldw	x,#400
3716  0539 1f05          	ldw	(OFST-7,sp),x
3717                     ; 677 	short vent_pwm_t_necc=400;
3719  053b ae0190        	ldw	x,#400
3720  053e 1f07          	ldw	(OFST-5,sp),x
3721                     ; 678 	short vent_pwm_max_necc=400;
3723                     ; 684 	tempSL=(signed long)I;
3725  0540 ce0010        	ldw	x,_I
3726  0543 cd0000        	call	c_itolx
3728  0546 96            	ldw	x,sp
3729  0547 1c0009        	addw	x,#OFST-3
3730  054a cd0000        	call	c_rtol
3732                     ; 685 	tempSL*=(signed long)Ui;
3734  054d ce000c        	ldw	x,_Ui
3735  0550 cd0000        	call	c_itolx
3737  0553 96            	ldw	x,sp
3738  0554 1c0009        	addw	x,#OFST-3
3739  0557 cd0000        	call	c_lgmul
3741                     ; 686 	tempSL/=100L;
3743  055a 96            	ldw	x,sp
3744  055b 1c0009        	addw	x,#OFST-3
3745  055e cd0000        	call	c_ltor
3747  0561 ae0004        	ldw	x,#L63
3748  0564 cd0000        	call	c_ldiv
3750  0567 96            	ldw	x,sp
3751  0568 1c0009        	addw	x,#OFST-3
3752  056b cd0000        	call	c_rtol
3754                     ; 694 	if(tempSL>3000L)vent_pwm_i_necc=1000;
3756  056e 9c            	rvf
3757  056f 96            	ldw	x,sp
3758  0570 1c0009        	addw	x,#OFST-3
3759  0573 cd0000        	call	c_ltor
3761  0576 ae0008        	ldw	x,#L04
3762  0579 cd0000        	call	c_lcmp
3764  057c 2f07          	jrslt	L3012
3767  057e ae03e8        	ldw	x,#1000
3768  0581 1f05          	ldw	(OFST-7,sp),x
3770  0583 2032          	jra	L5012
3771  0585               L3012:
3772                     ; 695 	else if(tempSL<300L)vent_pwm_i_necc=0;
3774  0585 9c            	rvf
3775  0586 96            	ldw	x,sp
3776  0587 1c0009        	addw	x,#OFST-3
3777  058a cd0000        	call	c_ltor
3779  058d ae000c        	ldw	x,#L24
3780  0590 cd0000        	call	c_lcmp
3782  0593 2e05          	jrsge	L7012
3785  0595 5f            	clrw	x
3786  0596 1f05          	ldw	(OFST-7,sp),x
3788  0598 201d          	jra	L5012
3789  059a               L7012:
3790                     ; 696 	else vent_pwm_i_necc=(short)(400L + ((tempSL-300L)/4L));
3792  059a 96            	ldw	x,sp
3793  059b 1c0009        	addw	x,#OFST-3
3794  059e cd0000        	call	c_ltor
3796  05a1 ae000c        	ldw	x,#L24
3797  05a4 cd0000        	call	c_lsub
3799  05a7 ae0010        	ldw	x,#L44
3800  05aa cd0000        	call	c_ldiv
3802  05ad ae0014        	ldw	x,#L64
3803  05b0 cd0000        	call	c_ladd
3805  05b3 be02          	ldw	x,c_lreg+2
3806  05b5 1f05          	ldw	(OFST-7,sp),x
3807  05b7               L5012:
3808                     ; 697 	gran(&vent_pwm_i_necc,0,1000);
3810  05b7 ae03e8        	ldw	x,#1000
3811  05ba 89            	pushw	x
3812  05bb 5f            	clrw	x
3813  05bc 89            	pushw	x
3814  05bd 96            	ldw	x,sp
3815  05be 1c0009        	addw	x,#OFST-3
3816  05c1 cd00d5        	call	_gran
3818  05c4 5b04          	addw	sp,#4
3819                     ; 699 	tempSL=(signed long)T;
3821  05c6 b672          	ld	a,_T
3822  05c8 b703          	ld	c_lreg+3,a
3823  05ca 48            	sll	a
3824  05cb 4f            	clr	a
3825  05cc a200          	sbc	a,#0
3826  05ce b702          	ld	c_lreg+2,a
3827  05d0 b701          	ld	c_lreg+1,a
3828  05d2 b700          	ld	c_lreg,a
3829  05d4 96            	ldw	x,sp
3830  05d5 1c0009        	addw	x,#OFST-3
3831  05d8 cd0000        	call	c_rtol
3833                     ; 700 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
3835  05db 9c            	rvf
3836  05dc ce000e        	ldw	x,_ee_tsign
3837  05df cd0000        	call	c_itolx
3839  05e2 a61e          	ld	a,#30
3840  05e4 cd0000        	call	c_lsbc
3842  05e7 96            	ldw	x,sp
3843  05e8 1c0009        	addw	x,#OFST-3
3844  05eb cd0000        	call	c_lcmp
3846  05ee 2f05          	jrslt	L3112
3849  05f0 5f            	clrw	x
3850  05f1 1f07          	ldw	(OFST-5,sp),x
3852  05f3 2030          	jra	L5112
3853  05f5               L3112:
3854                     ; 701 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
3856  05f5 9c            	rvf
3857  05f6 ce000e        	ldw	x,_ee_tsign
3858  05f9 cd0000        	call	c_itolx
3860  05fc 96            	ldw	x,sp
3861  05fd 1c0009        	addw	x,#OFST-3
3862  0600 cd0000        	call	c_lcmp
3864  0603 2c07          	jrsgt	L7112
3867  0605 ae03e8        	ldw	x,#1000
3868  0608 1f07          	ldw	(OFST-5,sp),x
3870  060a 2019          	jra	L5112
3871  060c               L7112:
3872                     ; 702 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
3874  060c ce000e        	ldw	x,_ee_tsign
3875  060f 1d001e        	subw	x,#30
3876  0612 1f01          	ldw	(OFST-11,sp),x
3877  0614 1e0b          	ldw	x,(OFST-1,sp)
3878  0616 72f001        	subw	x,(OFST-11,sp)
3879  0619 90ae0014      	ldw	y,#20
3880  061d cd0000        	call	c_imul
3882  0620 1c0190        	addw	x,#400
3883  0623 1f07          	ldw	(OFST-5,sp),x
3884  0625               L5112:
3885                     ; 703 	gran(&vent_pwm_t_necc,0,1000);
3887  0625 ae03e8        	ldw	x,#1000
3888  0628 89            	pushw	x
3889  0629 5f            	clrw	x
3890  062a 89            	pushw	x
3891  062b 96            	ldw	x,sp
3892  062c 1c000b        	addw	x,#OFST-1
3893  062f cd00d5        	call	_gran
3895  0632 5b04          	addw	sp,#4
3896                     ; 705 	vent_pwm_max_necc=vent_pwm_i_necc;
3898  0634 1e05          	ldw	x,(OFST-7,sp)
3899  0636 1f03          	ldw	(OFST-9,sp),x
3900                     ; 706 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3902  0638 9c            	rvf
3903  0639 1e07          	ldw	x,(OFST-5,sp)
3904  063b 1305          	cpw	x,(OFST-7,sp)
3905  063d 2d04          	jrsle	L3212
3908  063f 1e07          	ldw	x,(OFST-5,sp)
3909  0641 1f03          	ldw	(OFST-9,sp),x
3910  0643               L3212:
3911                     ; 708 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3913  0643 9c            	rvf
3914  0644 be10          	ldw	x,_vent_pwm
3915  0646 1303          	cpw	x,(OFST-9,sp)
3916  0648 2e07          	jrsge	L5212
3919  064a be10          	ldw	x,_vent_pwm
3920  064c 1c000a        	addw	x,#10
3921  064f bf10          	ldw	_vent_pwm,x
3922  0651               L5212:
3923                     ; 709 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3925  0651 9c            	rvf
3926  0652 be10          	ldw	x,_vent_pwm
3927  0654 1303          	cpw	x,(OFST-9,sp)
3928  0656 2d07          	jrsle	L7212
3931  0658 be10          	ldw	x,_vent_pwm
3932  065a 1d000a        	subw	x,#10
3933  065d bf10          	ldw	_vent_pwm,x
3934  065f               L7212:
3935                     ; 710 	gran(&vent_pwm,0,1000);
3937  065f ae03e8        	ldw	x,#1000
3938  0662 89            	pushw	x
3939  0663 5f            	clrw	x
3940  0664 89            	pushw	x
3941  0665 ae0010        	ldw	x,#_vent_pwm
3942  0668 cd00d5        	call	_gran
3944  066b 5b04          	addw	sp,#4
3945                     ; 716 	if(vent_pwm_integr_cnt<10)
3947  066d 9c            	rvf
3948  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3949  0670 a3000a        	cpw	x,#10
3950  0673 2e26          	jrsge	L1312
3951                     ; 718 		vent_pwm_integr_cnt++;
3953  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3954  0677 1c0001        	addw	x,#1
3955  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3956                     ; 719 		if(vent_pwm_integr_cnt>=10)
3958  067c 9c            	rvf
3959  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3960  067f a3000a        	cpw	x,#10
3961  0682 2f17          	jrslt	L1312
3962                     ; 721 			vent_pwm_integr_cnt=0;
3964  0684 5f            	clrw	x
3965  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3966                     ; 722 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3968  0687 be0e          	ldw	x,_vent_pwm_integr
3969  0689 90ae0009      	ldw	y,#9
3970  068d cd0000        	call	c_imul
3972  0690 72bb0010      	addw	x,_vent_pwm
3973  0694 a60a          	ld	a,#10
3974  0696 cd0000        	call	c_sdivx
3976  0699 bf0e          	ldw	_vent_pwm_integr,x
3977  069b               L1312:
3978                     ; 725 	gran(&vent_pwm_integr,0,1000);
3980  069b ae03e8        	ldw	x,#1000
3981  069e 89            	pushw	x
3982  069f 5f            	clrw	x
3983  06a0 89            	pushw	x
3984  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3985  06a4 cd00d5        	call	_gran
3987  06a7 5b04          	addw	sp,#4
3988                     ; 729 }
3991  06a9 5b0c          	addw	sp,#12
3992  06ab 81            	ret
4018                     ; 734 void pwr_drv(void)
4018                     ; 735 {
4019                     	switch	.text
4020  06ac               _pwr_drv:
4024                     ; 806 TIM1->CCR2H= (char)(pwm_u/256);	
4026  06ac be08          	ldw	x,_pwm_u
4027  06ae 90ae0100      	ldw	y,#256
4028  06b2 cd0000        	call	c_idiv
4030  06b5 9f            	ld	a,xl
4031  06b6 c75267        	ld	21095,a
4032                     ; 807 TIM1->CCR2L= (char)pwm_u;
4034  06b9 5500095268    	mov	21096,_pwm_u+1
4035                     ; 809 TIM1->CCR1H= (char)(pwm_i/256);	
4037  06be be0a          	ldw	x,_pwm_i
4038  06c0 90ae0100      	ldw	y,#256
4039  06c4 cd0000        	call	c_idiv
4041  06c7 9f            	ld	a,xl
4042  06c8 c75265        	ld	21093,a
4043                     ; 810 TIM1->CCR1L= (char)pwm_i;
4045  06cb 55000b5266    	mov	21094,_pwm_i+1
4046                     ; 812 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4048  06d0 be0e          	ldw	x,_vent_pwm_integr
4049  06d2 90ae0080      	ldw	y,#128
4050  06d6 cd0000        	call	c_idiv
4052  06d9 9f            	ld	a,xl
4053  06da c75269        	ld	21097,a
4054                     ; 813 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4056  06dd b60f          	ld	a,_vent_pwm_integr+1
4057  06df 48            	sll	a
4058  06e0 c7526a        	ld	21098,a
4059                     ; 814 }
4062  06e3 81            	ret
4120                     	switch	.const
4121  0018               L45:
4122  0018 0000028a      	dc.l	650
4123                     ; 819 void pwr_hndl(void)				
4123                     ; 820 {
4124                     	switch	.text
4125  06e4               _pwr_hndl:
4127  06e4 5205          	subw	sp,#5
4128       00000005      OFST:	set	5
4131                     ; 821 if(jp_mode==jp3)
4133  06e6 b654          	ld	a,_jp_mode
4134  06e8 a103          	cp	a,#3
4135  06ea 260a          	jrne	L7612
4136                     ; 823 	pwm_u=0;
4138  06ec 5f            	clrw	x
4139  06ed bf08          	ldw	_pwm_u,x
4140                     ; 824 	pwm_i=0;
4142  06ef 5f            	clrw	x
4143  06f0 bf0a          	ldw	_pwm_i,x
4145  06f2 ac3f083f      	jpf	L1712
4146  06f6               L7612:
4147                     ; 826 else if(jp_mode==jp2)
4149  06f6 b654          	ld	a,_jp_mode
4150  06f8 a102          	cp	a,#2
4151  06fa 260c          	jrne	L3712
4152                     ; 828 	pwm_u=0;
4154  06fc 5f            	clrw	x
4155  06fd bf08          	ldw	_pwm_u,x
4156                     ; 829 	pwm_i=0x7ff;
4158  06ff ae07ff        	ldw	x,#2047
4159  0702 bf0a          	ldw	_pwm_i,x
4161  0704 ac3f083f      	jpf	L1712
4162  0708               L3712:
4163                     ; 831 else if(jp_mode==jp1)
4165  0708 b654          	ld	a,_jp_mode
4166  070a a101          	cp	a,#1
4167  070c 260e          	jrne	L7712
4168                     ; 833 	pwm_u=0x7ff;
4170  070e ae07ff        	ldw	x,#2047
4171  0711 bf08          	ldw	_pwm_u,x
4172                     ; 834 	pwm_i=0x7ff;
4174  0713 ae07ff        	ldw	x,#2047
4175  0716 bf0a          	ldw	_pwm_i,x
4177  0718 ac3f083f      	jpf	L1712
4178  071c               L7712:
4179                     ; 845 else if(link==OFF)
4181  071c b66d          	ld	a,_link
4182  071e a1aa          	cp	a,#170
4183  0720 2703          	jreq	L65
4184  0722 cc07c7        	jp	L3022
4185  0725               L65:
4186                     ; 847 	pwm_i=0x7ff;
4188  0725 ae07ff        	ldw	x,#2047
4189  0728 bf0a          	ldw	_pwm_i,x
4190                     ; 848 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4192  072a ce000a        	ldw	x,_Unecc
4193  072d 90ae07d0      	ldw	y,#2000
4194  0731 cd0000        	call	c_vmul
4196  0734 ae0018        	ldw	x,#L45
4197  0737 cd0000        	call	c_ldiv
4199  073a be02          	ldw	x,c_lreg+2
4200  073c bf55          	ldw	_pwm_u_,x
4201                     ; 852 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4203  073e c60013        	ld	a,_pwm_u_buff_ptr
4204  0741 5f            	clrw	x
4205  0742 97            	ld	xl,a
4206  0743 58            	sllw	x
4207  0744 90be55        	ldw	y,_pwm_u_
4208  0747 df0016        	ldw	(_pwm_u_buff,x),y
4209                     ; 853 	pwm_u_buff_ptr++;
4211  074a 725c0013      	inc	_pwm_u_buff_ptr
4212                     ; 854 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4214  074e c60013        	ld	a,_pwm_u_buff_ptr
4215  0751 a110          	cp	a,#16
4216  0753 2504          	jrult	L5022
4219  0755 725f0013      	clr	_pwm_u_buff_ptr
4220  0759               L5022:
4221                     ; 858 		tempSL=0;
4223  0759 ae0000        	ldw	x,#0
4224  075c 1f03          	ldw	(OFST-2,sp),x
4225  075e ae0000        	ldw	x,#0
4226  0761 1f01          	ldw	(OFST-4,sp),x
4227                     ; 859 		for(i=0;i<16;i++)
4229  0763 0f05          	clr	(OFST+0,sp)
4230  0765               L7022:
4231                     ; 861 			tempSL+=(signed long)pwm_u_buff[i];
4233  0765 7b05          	ld	a,(OFST+0,sp)
4234  0767 5f            	clrw	x
4235  0768 97            	ld	xl,a
4236  0769 58            	sllw	x
4237  076a de0016        	ldw	x,(_pwm_u_buff,x)
4238  076d cd0000        	call	c_itolx
4240  0770 96            	ldw	x,sp
4241  0771 1c0001        	addw	x,#OFST-4
4242  0774 cd0000        	call	c_lgadd
4244                     ; 859 		for(i=0;i<16;i++)
4246  0777 0c05          	inc	(OFST+0,sp)
4249  0779 7b05          	ld	a,(OFST+0,sp)
4250  077b a110          	cp	a,#16
4251  077d 25e6          	jrult	L7022
4252                     ; 863 		tempSL>>=4;
4254  077f 96            	ldw	x,sp
4255  0780 1c0001        	addw	x,#OFST-4
4256  0783 a604          	ld	a,#4
4257  0785 cd0000        	call	c_lgrsh
4259                     ; 864 		pwm_u_buff_=(signed short)tempSL;
4261  0788 1e03          	ldw	x,(OFST-2,sp)
4262  078a cf0014        	ldw	_pwm_u_buff_,x
4263                     ; 866 	pwm_u=pwm_u_;
4265  078d be55          	ldw	x,_pwm_u_
4266  078f bf08          	ldw	_pwm_u,x
4267                     ; 867 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4269  0791 9c            	rvf
4270  0792 ce000c        	ldw	x,_Ui
4271  0795 72b0000a      	subw	x,_Unecc
4272  0799 cd0000        	call	_abs
4274  079c a30014        	cpw	x,#20
4275  079f 2e06          	jrsge	L5122
4278  07a1 725c0012      	inc	_pwm_u_buff_cnt
4280  07a5 2004          	jra	L7122
4281  07a7               L5122:
4282                     ; 868 	else pwm_u_buff_cnt=0;
4284  07a7 725f0012      	clr	_pwm_u_buff_cnt
4285  07ab               L7122:
4286                     ; 870 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4288  07ab c60012        	ld	a,_pwm_u_buff_cnt
4289  07ae a114          	cp	a,#20
4290  07b0 2504          	jrult	L1222
4293  07b2 35140012      	mov	_pwm_u_buff_cnt,#20
4294  07b6               L1222:
4295                     ; 871 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4297  07b6 c60012        	ld	a,_pwm_u_buff_cnt
4298  07b9 a10f          	cp	a,#15
4299  07bb 2403          	jruge	L06
4300  07bd cc083f        	jp	L1712
4301  07c0               L06:
4304  07c0 ce0014        	ldw	x,_pwm_u_buff_
4305  07c3 bf08          	ldw	_pwm_u,x
4306  07c5 2078          	jra	L1712
4307  07c7               L3022:
4308                     ; 875 else	if(link==ON)				//если есть связьvol_i_temp_avar
4310  07c7 b66d          	ld	a,_link
4311  07c9 a155          	cp	a,#85
4312  07cb 2672          	jrne	L1712
4313                     ; 877 	if((flags&0b00100000)==0)	//если нет блокировки извне
4315  07cd b605          	ld	a,_flags
4316  07cf a520          	bcp	a,#32
4317  07d1 2660          	jrne	L1322
4318                     ; 879 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4320  07d3 b605          	ld	a,_flags
4321  07d5 a51a          	bcp	a,#26
4322  07d7 260b          	jrne	L3322
4323                     ; 881 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4325  07d9 be60          	ldw	x,_vol_i_temp
4326  07db bf08          	ldw	_pwm_u,x
4327                     ; 882 			pwm_i=2000;
4329  07dd ae07d0        	ldw	x,#2000
4330  07e0 bf0a          	ldw	_pwm_i,x
4332  07e2 200c          	jra	L5322
4333  07e4               L3322:
4334                     ; 884 		else if(flags&0b00011010)					//если есть аварии
4336  07e4 b605          	ld	a,_flags
4337  07e6 a51a          	bcp	a,#26
4338  07e8 2706          	jreq	L5322
4339                     ; 886 			pwm_u=0;								//то полный стоп
4341  07ea 5f            	clrw	x
4342  07eb bf08          	ldw	_pwm_u,x
4343                     ; 887 			pwm_i=0;
4345  07ed 5f            	clrw	x
4346  07ee bf0a          	ldw	_pwm_i,x
4347  07f0               L5322:
4348                     ; 890 		if(vol_i_temp==2000)
4350  07f0 be60          	ldw	x,_vol_i_temp
4351  07f2 a307d0        	cpw	x,#2000
4352  07f5 260c          	jrne	L1422
4353                     ; 892 			pwm_u=2000;
4355  07f7 ae07d0        	ldw	x,#2000
4356  07fa bf08          	ldw	_pwm_u,x
4357                     ; 893 			pwm_i=2000;
4359  07fc ae07d0        	ldw	x,#2000
4360  07ff bf0a          	ldw	_pwm_i,x
4362  0801 2014          	jra	L3422
4363  0803               L1422:
4364                     ; 897 			if((abs((int)(Ui-Unecc)))>50)	pwm_u_cnt=19;
4366  0803 9c            	rvf
4367  0804 ce000c        	ldw	x,_Ui
4368  0807 72b0000a      	subw	x,_Unecc
4369  080b cd0000        	call	_abs
4371  080e a30033        	cpw	x,#51
4372  0811 2f04          	jrslt	L3422
4375  0813 35130007      	mov	_pwm_u_cnt,#19
4376  0817               L3422:
4377                     ; 900 		if(pwm_u_cnt)
4379  0817 3d07          	tnz	_pwm_u_cnt
4380  0819 2724          	jreq	L1712
4381                     ; 902 			pwm_u_cnt--;
4383  081b 3a07          	dec	_pwm_u_cnt
4384                     ; 903 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4386  081d ce000a        	ldw	x,_Unecc
4387  0820 90ae07d0      	ldw	y,#2000
4388  0824 cd0000        	call	c_vmul
4390  0827 ae0018        	ldw	x,#L45
4391  082a cd0000        	call	c_ldiv
4393  082d be02          	ldw	x,c_lreg+2
4394  082f bf08          	ldw	_pwm_u,x
4395  0831 200c          	jra	L1712
4396  0833               L1322:
4397                     ; 906 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4399  0833 b605          	ld	a,_flags
4400  0835 a520          	bcp	a,#32
4401  0837 2706          	jreq	L1712
4402                     ; 908 		pwm_u=0;
4404  0839 5f            	clrw	x
4405  083a bf08          	ldw	_pwm_u,x
4406                     ; 909 		pwm_i=0;
4408  083c 5f            	clrw	x
4409  083d bf0a          	ldw	_pwm_i,x
4410  083f               L1712:
4411                     ; 937 if(pwm_u>2000)pwm_u=2000;
4413  083f 9c            	rvf
4414  0840 be08          	ldw	x,_pwm_u
4415  0842 a307d1        	cpw	x,#2001
4416  0845 2f05          	jrslt	L5522
4419  0847 ae07d0        	ldw	x,#2000
4420  084a bf08          	ldw	_pwm_u,x
4421  084c               L5522:
4422                     ; 938 if(pwm_i>2000)pwm_i=2000;
4424  084c 9c            	rvf
4425  084d be0a          	ldw	x,_pwm_i
4426  084f a307d1        	cpw	x,#2001
4427  0852 2f05          	jrslt	L7522
4430  0854 ae07d0        	ldw	x,#2000
4431  0857 bf0a          	ldw	_pwm_i,x
4432  0859               L7522:
4433                     ; 941 }
4436  0859 5b05          	addw	sp,#5
4437  085b 81            	ret
4490                     	switch	.const
4491  001c               L46:
4492  001c 00000258      	dc.l	600
4493  0020               L66:
4494  0020 000003e8      	dc.l	1000
4495  0024               L07:
4496  0024 00000708      	dc.l	1800
4497                     ; 944 void matemat(void)
4497                     ; 945 {
4498                     	switch	.text
4499  085c               _matemat:
4501  085c 5208          	subw	sp,#8
4502       00000008      OFST:	set	8
4505                     ; 969 I=adc_buff_[4];
4507  085e ce0107        	ldw	x,_adc_buff_+8
4508  0861 cf0010        	ldw	_I,x
4509                     ; 970 temp_SL=adc_buff_[4];
4511  0864 ce0107        	ldw	x,_adc_buff_+8
4512  0867 cd0000        	call	c_itolx
4514  086a 96            	ldw	x,sp
4515  086b 1c0005        	addw	x,#OFST-3
4516  086e cd0000        	call	c_rtol
4518                     ; 971 temp_SL-=ee_K[0][0];
4520  0871 ce001a        	ldw	x,_ee_K
4521  0874 cd0000        	call	c_itolx
4523  0877 96            	ldw	x,sp
4524  0878 1c0005        	addw	x,#OFST-3
4525  087b cd0000        	call	c_lgsub
4527                     ; 972 if(temp_SL<0) temp_SL=0;
4529  087e 9c            	rvf
4530  087f 0d05          	tnz	(OFST-3,sp)
4531  0881 2e0a          	jrsge	L7722
4534  0883 ae0000        	ldw	x,#0
4535  0886 1f07          	ldw	(OFST-1,sp),x
4536  0888 ae0000        	ldw	x,#0
4537  088b 1f05          	ldw	(OFST-3,sp),x
4538  088d               L7722:
4539                     ; 973 temp_SL*=ee_K[0][1];
4541  088d ce001c        	ldw	x,_ee_K+2
4542  0890 cd0000        	call	c_itolx
4544  0893 96            	ldw	x,sp
4545  0894 1c0005        	addw	x,#OFST-3
4546  0897 cd0000        	call	c_lgmul
4548                     ; 974 temp_SL/=600;
4550  089a 96            	ldw	x,sp
4551  089b 1c0005        	addw	x,#OFST-3
4552  089e cd0000        	call	c_ltor
4554  08a1 ae001c        	ldw	x,#L46
4555  08a4 cd0000        	call	c_ldiv
4557  08a7 96            	ldw	x,sp
4558  08a8 1c0005        	addw	x,#OFST-3
4559  08ab cd0000        	call	c_rtol
4561                     ; 975 I=(signed short)temp_SL;
4563  08ae 1e07          	ldw	x,(OFST-1,sp)
4564  08b0 cf0010        	ldw	_I,x
4565                     ; 978 temp_SL=(signed long)adc_buff_[1];//1;
4567                     ; 979 temp_SL=(signed long)adc_buff_[3];//1;
4569  08b3 ce0105        	ldw	x,_adc_buff_+6
4570  08b6 cd0000        	call	c_itolx
4572  08b9 96            	ldw	x,sp
4573  08ba 1c0005        	addw	x,#OFST-3
4574  08bd cd0000        	call	c_rtol
4576                     ; 981 if(temp_SL<0) temp_SL=0;
4578  08c0 9c            	rvf
4579  08c1 0d05          	tnz	(OFST-3,sp)
4580  08c3 2e0a          	jrsge	L1032
4583  08c5 ae0000        	ldw	x,#0
4584  08c8 1f07          	ldw	(OFST-1,sp),x
4585  08ca ae0000        	ldw	x,#0
4586  08cd 1f05          	ldw	(OFST-3,sp),x
4587  08cf               L1032:
4588                     ; 982 temp_SL*=(signed long)ee_K[2][1];
4590  08cf ce0024        	ldw	x,_ee_K+10
4591  08d2 cd0000        	call	c_itolx
4593  08d5 96            	ldw	x,sp
4594  08d6 1c0005        	addw	x,#OFST-3
4595  08d9 cd0000        	call	c_lgmul
4597                     ; 983 temp_SL/=1000L;
4599  08dc 96            	ldw	x,sp
4600  08dd 1c0005        	addw	x,#OFST-3
4601  08e0 cd0000        	call	c_ltor
4603  08e3 ae0020        	ldw	x,#L66
4604  08e6 cd0000        	call	c_ldiv
4606  08e9 96            	ldw	x,sp
4607  08ea 1c0005        	addw	x,#OFST-3
4608  08ed cd0000        	call	c_rtol
4610                     ; 984 Ui=(unsigned short)temp_SL;
4612  08f0 1e07          	ldw	x,(OFST-1,sp)
4613  08f2 cf000c        	ldw	_Ui,x
4614                     ; 986 temp_SL=(signed long)adc_buff_5;
4616  08f5 ce00fd        	ldw	x,_adc_buff_5
4617  08f8 cd0000        	call	c_itolx
4619  08fb 96            	ldw	x,sp
4620  08fc 1c0005        	addw	x,#OFST-3
4621  08ff cd0000        	call	c_rtol
4623                     ; 988 if(temp_SL<0) temp_SL=0;
4625  0902 9c            	rvf
4626  0903 0d05          	tnz	(OFST-3,sp)
4627  0905 2e0a          	jrsge	L3032
4630  0907 ae0000        	ldw	x,#0
4631  090a 1f07          	ldw	(OFST-1,sp),x
4632  090c ae0000        	ldw	x,#0
4633  090f 1f05          	ldw	(OFST-3,sp),x
4634  0911               L3032:
4635                     ; 989 temp_SL*=(signed long)ee_K[4][1];
4637  0911 ce002c        	ldw	x,_ee_K+18
4638  0914 cd0000        	call	c_itolx
4640  0917 96            	ldw	x,sp
4641  0918 1c0005        	addw	x,#OFST-3
4642  091b cd0000        	call	c_lgmul
4644                     ; 990 temp_SL/=1000L;
4646  091e 96            	ldw	x,sp
4647  091f 1c0005        	addw	x,#OFST-3
4648  0922 cd0000        	call	c_ltor
4650  0925 ae0020        	ldw	x,#L66
4651  0928 cd0000        	call	c_ldiv
4653  092b 96            	ldw	x,sp
4654  092c 1c0005        	addw	x,#OFST-3
4655  092f cd0000        	call	c_rtol
4657                     ; 991 Usum=(unsigned short)temp_SL;
4659  0932 1e07          	ldw	x,(OFST-1,sp)
4660  0934 cf0006        	ldw	_Usum,x
4661                     ; 995 temp_SL=adc_buff_[3];
4663  0937 ce0105        	ldw	x,_adc_buff_+6
4664  093a cd0000        	call	c_itolx
4666  093d 96            	ldw	x,sp
4667  093e 1c0005        	addw	x,#OFST-3
4668  0941 cd0000        	call	c_rtol
4670                     ; 997 if(temp_SL<0) temp_SL=0;
4672  0944 9c            	rvf
4673  0945 0d05          	tnz	(OFST-3,sp)
4674  0947 2e0a          	jrsge	L5032
4677  0949 ae0000        	ldw	x,#0
4678  094c 1f07          	ldw	(OFST-1,sp),x
4679  094e ae0000        	ldw	x,#0
4680  0951 1f05          	ldw	(OFST-3,sp),x
4681  0953               L5032:
4682                     ; 998 temp_SL*=ee_K[1][1];
4684  0953 ce0020        	ldw	x,_ee_K+6
4685  0956 cd0000        	call	c_itolx
4687  0959 96            	ldw	x,sp
4688  095a 1c0005        	addw	x,#OFST-3
4689  095d cd0000        	call	c_lgmul
4691                     ; 999 temp_SL/=1800;
4693  0960 96            	ldw	x,sp
4694  0961 1c0005        	addw	x,#OFST-3
4695  0964 cd0000        	call	c_ltor
4697  0967 ae0024        	ldw	x,#L07
4698  096a cd0000        	call	c_ldiv
4700  096d 96            	ldw	x,sp
4701  096e 1c0005        	addw	x,#OFST-3
4702  0971 cd0000        	call	c_rtol
4704                     ; 1000 Un=(unsigned short)temp_SL;
4706  0974 1e07          	ldw	x,(OFST-1,sp)
4707  0976 cf000e        	ldw	_Un,x
4708                     ; 1005 temp_SL=adc_buff_[2];
4710  0979 ce0103        	ldw	x,_adc_buff_+4
4711  097c cd0000        	call	c_itolx
4713  097f 96            	ldw	x,sp
4714  0980 1c0005        	addw	x,#OFST-3
4715  0983 cd0000        	call	c_rtol
4717                     ; 1006 temp_SL*=ee_K[3][1];
4719  0986 ce0028        	ldw	x,_ee_K+14
4720  0989 cd0000        	call	c_itolx
4722  098c 96            	ldw	x,sp
4723  098d 1c0005        	addw	x,#OFST-3
4724  0990 cd0000        	call	c_lgmul
4726                     ; 1007 temp_SL/=1000;
4728  0993 96            	ldw	x,sp
4729  0994 1c0005        	addw	x,#OFST-3
4730  0997 cd0000        	call	c_ltor
4732  099a ae0020        	ldw	x,#L66
4733  099d cd0000        	call	c_ldiv
4735  09a0 96            	ldw	x,sp
4736  09a1 1c0005        	addw	x,#OFST-3
4737  09a4 cd0000        	call	c_rtol
4739                     ; 1008 T=(signed short)(temp_SL-273L);
4741  09a7 7b08          	ld	a,(OFST+0,sp)
4742  09a9 5f            	clrw	x
4743  09aa 4d            	tnz	a
4744  09ab 2a01          	jrpl	L27
4745  09ad 53            	cplw	x
4746  09ae               L27:
4747  09ae 97            	ld	xl,a
4748  09af 1d0111        	subw	x,#273
4749  09b2 01            	rrwa	x,a
4750  09b3 b772          	ld	_T,a
4751  09b5 02            	rlwa	x,a
4752                     ; 1009 if(T<-30)T=-30;
4754  09b6 9c            	rvf
4755  09b7 b672          	ld	a,_T
4756  09b9 a1e2          	cp	a,#226
4757  09bb 2e04          	jrsge	L7032
4760  09bd 35e20072      	mov	_T,#226
4761  09c1               L7032:
4762                     ; 1010 if(T>120)T=120;
4764  09c1 9c            	rvf
4765  09c2 b672          	ld	a,_T
4766  09c4 a179          	cp	a,#121
4767  09c6 2f04          	jrslt	L1132
4770  09c8 35780072      	mov	_T,#120
4771  09cc               L1132:
4772                     ; 1014 Uin=Usum-Ui;
4774  09cc ce0006        	ldw	x,_Usum
4775  09cf 72b0000c      	subw	x,_Ui
4776  09d3 cf0004        	ldw	_Uin,x
4777                     ; 1015 if(link==ON)
4779  09d6 b66d          	ld	a,_link
4780  09d8 a155          	cp	a,#85
4781  09da 260c          	jrne	L3132
4782                     ; 1017 	Unecc=U_out_const-Uin;
4784  09dc ce0008        	ldw	x,_U_out_const
4785  09df 72b00004      	subw	x,_Uin
4786  09e3 cf000a        	ldw	_Unecc,x
4788  09e6 200a          	jra	L5132
4789  09e8               L3132:
4790                     ; 1026 else Unecc=ee_UAVT-Uin;
4792  09e8 ce000c        	ldw	x,_ee_UAVT
4793  09eb 72b00004      	subw	x,_Uin
4794  09ef cf000a        	ldw	_Unecc,x
4795  09f2               L5132:
4796                     ; 1035 temp_SL=(signed long)(T-ee_tsign);
4798  09f2 5f            	clrw	x
4799  09f3 b672          	ld	a,_T
4800  09f5 2a01          	jrpl	L47
4801  09f7 53            	cplw	x
4802  09f8               L47:
4803  09f8 97            	ld	xl,a
4804  09f9 72b0000e      	subw	x,_ee_tsign
4805  09fd cd0000        	call	c_itolx
4807  0a00 96            	ldw	x,sp
4808  0a01 1c0005        	addw	x,#OFST-3
4809  0a04 cd0000        	call	c_rtol
4811                     ; 1036 temp_SL*=1000L;
4813  0a07 ae03e8        	ldw	x,#1000
4814  0a0a bf02          	ldw	c_lreg+2,x
4815  0a0c ae0000        	ldw	x,#0
4816  0a0f bf00          	ldw	c_lreg,x
4817  0a11 96            	ldw	x,sp
4818  0a12 1c0005        	addw	x,#OFST-3
4819  0a15 cd0000        	call	c_lgmul
4821                     ; 1037 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4823  0a18 ce0010        	ldw	x,_ee_tmax
4824  0a1b 72b0000e      	subw	x,_ee_tsign
4825  0a1f cd0000        	call	c_itolx
4827  0a22 96            	ldw	x,sp
4828  0a23 1c0001        	addw	x,#OFST-7
4829  0a26 cd0000        	call	c_rtol
4831  0a29 96            	ldw	x,sp
4832  0a2a 1c0005        	addw	x,#OFST-3
4833  0a2d cd0000        	call	c_ltor
4835  0a30 96            	ldw	x,sp
4836  0a31 1c0001        	addw	x,#OFST-7
4837  0a34 cd0000        	call	c_ldiv
4839  0a37 96            	ldw	x,sp
4840  0a38 1c0005        	addw	x,#OFST-3
4841  0a3b cd0000        	call	c_rtol
4843                     ; 1039 vol_i_temp_avar=(unsigned short)temp_SL; 
4845  0a3e 1e07          	ldw	x,(OFST-1,sp)
4846  0a40 bf06          	ldw	_vol_i_temp_avar,x
4847                     ; 1041 debug_info_to_uku[0]=pwm_u;
4849  0a42 be08          	ldw	x,_pwm_u
4850  0a44 bf01          	ldw	_debug_info_to_uku,x
4851                     ; 1042 debug_info_to_uku[1]=vol_i_temp;
4853  0a46 be60          	ldw	x,_vol_i_temp
4854  0a48 bf03          	ldw	_debug_info_to_uku+2,x
4855                     ; 1044 }
4858  0a4a 5b08          	addw	sp,#8
4859  0a4c 81            	ret
4890                     ; 1047 void temper_drv(void)		//1 Hz
4890                     ; 1048 {
4891                     	switch	.text
4892  0a4d               _temper_drv:
4896                     ; 1050 if(T>ee_tsign) tsign_cnt++;
4898  0a4d 9c            	rvf
4899  0a4e 5f            	clrw	x
4900  0a4f b672          	ld	a,_T
4901  0a51 2a01          	jrpl	L001
4902  0a53 53            	cplw	x
4903  0a54               L001:
4904  0a54 97            	ld	xl,a
4905  0a55 c3000e        	cpw	x,_ee_tsign
4906  0a58 2d09          	jrsle	L7232
4909  0a5a be59          	ldw	x,_tsign_cnt
4910  0a5c 1c0001        	addw	x,#1
4911  0a5f bf59          	ldw	_tsign_cnt,x
4913  0a61 201d          	jra	L1332
4914  0a63               L7232:
4915                     ; 1051 else if (T<(ee_tsign-1)) tsign_cnt--;
4917  0a63 9c            	rvf
4918  0a64 ce000e        	ldw	x,_ee_tsign
4919  0a67 5a            	decw	x
4920  0a68 905f          	clrw	y
4921  0a6a b672          	ld	a,_T
4922  0a6c 2a02          	jrpl	L201
4923  0a6e 9053          	cplw	y
4924  0a70               L201:
4925  0a70 9097          	ld	yl,a
4926  0a72 90bf00        	ldw	c_y,y
4927  0a75 b300          	cpw	x,c_y
4928  0a77 2d07          	jrsle	L1332
4931  0a79 be59          	ldw	x,_tsign_cnt
4932  0a7b 1d0001        	subw	x,#1
4933  0a7e bf59          	ldw	_tsign_cnt,x
4934  0a80               L1332:
4935                     ; 1053 gran(&tsign_cnt,0,60);
4937  0a80 ae003c        	ldw	x,#60
4938  0a83 89            	pushw	x
4939  0a84 5f            	clrw	x
4940  0a85 89            	pushw	x
4941  0a86 ae0059        	ldw	x,#_tsign_cnt
4942  0a89 cd00d5        	call	_gran
4944  0a8c 5b04          	addw	sp,#4
4945                     ; 1055 if(tsign_cnt>=55)
4947  0a8e 9c            	rvf
4948  0a8f be59          	ldw	x,_tsign_cnt
4949  0a91 a30037        	cpw	x,#55
4950  0a94 2f16          	jrslt	L5332
4951                     ; 1057 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4953  0a96 3d54          	tnz	_jp_mode
4954  0a98 2606          	jrne	L3432
4956  0a9a b605          	ld	a,_flags
4957  0a9c a540          	bcp	a,#64
4958  0a9e 2706          	jreq	L1432
4959  0aa0               L3432:
4961  0aa0 b654          	ld	a,_jp_mode
4962  0aa2 a103          	cp	a,#3
4963  0aa4 2612          	jrne	L5432
4964  0aa6               L1432:
4967  0aa6 72140005      	bset	_flags,#2
4968  0aaa 200c          	jra	L5432
4969  0aac               L5332:
4970                     ; 1059 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
4972  0aac 9c            	rvf
4973  0aad be59          	ldw	x,_tsign_cnt
4974  0aaf a30006        	cpw	x,#6
4975  0ab2 2e04          	jrsge	L5432
4978  0ab4 72150005      	bres	_flags,#2
4979  0ab8               L5432:
4980                     ; 1064 if(T>ee_tmax) tmax_cnt++;
4982  0ab8 9c            	rvf
4983  0ab9 5f            	clrw	x
4984  0aba b672          	ld	a,_T
4985  0abc 2a01          	jrpl	L401
4986  0abe 53            	cplw	x
4987  0abf               L401:
4988  0abf 97            	ld	xl,a
4989  0ac0 c30010        	cpw	x,_ee_tmax
4990  0ac3 2d09          	jrsle	L1532
4993  0ac5 be57          	ldw	x,_tmax_cnt
4994  0ac7 1c0001        	addw	x,#1
4995  0aca bf57          	ldw	_tmax_cnt,x
4997  0acc 201d          	jra	L3532
4998  0ace               L1532:
4999                     ; 1065 else if (T<(ee_tmax-1)) tmax_cnt--;
5001  0ace 9c            	rvf
5002  0acf ce0010        	ldw	x,_ee_tmax
5003  0ad2 5a            	decw	x
5004  0ad3 905f          	clrw	y
5005  0ad5 b672          	ld	a,_T
5006  0ad7 2a02          	jrpl	L601
5007  0ad9 9053          	cplw	y
5008  0adb               L601:
5009  0adb 9097          	ld	yl,a
5010  0add 90bf00        	ldw	c_y,y
5011  0ae0 b300          	cpw	x,c_y
5012  0ae2 2d07          	jrsle	L3532
5015  0ae4 be57          	ldw	x,_tmax_cnt
5016  0ae6 1d0001        	subw	x,#1
5017  0ae9 bf57          	ldw	_tmax_cnt,x
5018  0aeb               L3532:
5019                     ; 1067 gran(&tmax_cnt,0,60);
5021  0aeb ae003c        	ldw	x,#60
5022  0aee 89            	pushw	x
5023  0aef 5f            	clrw	x
5024  0af0 89            	pushw	x
5025  0af1 ae0057        	ldw	x,#_tmax_cnt
5026  0af4 cd00d5        	call	_gran
5028  0af7 5b04          	addw	sp,#4
5029                     ; 1069 if(tmax_cnt>=55)
5031  0af9 9c            	rvf
5032  0afa be57          	ldw	x,_tmax_cnt
5033  0afc a30037        	cpw	x,#55
5034  0aff 2f16          	jrslt	L7532
5035                     ; 1071 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5037  0b01 3d54          	tnz	_jp_mode
5038  0b03 2606          	jrne	L5632
5040  0b05 b605          	ld	a,_flags
5041  0b07 a540          	bcp	a,#64
5042  0b09 2706          	jreq	L3632
5043  0b0b               L5632:
5045  0b0b b654          	ld	a,_jp_mode
5046  0b0d a103          	cp	a,#3
5047  0b0f 2612          	jrne	L7632
5048  0b11               L3632:
5051  0b11 72120005      	bset	_flags,#1
5052  0b15 200c          	jra	L7632
5053  0b17               L7532:
5054                     ; 1073 else if (tmax_cnt<=5) flags&=0b11111101;
5056  0b17 9c            	rvf
5057  0b18 be57          	ldw	x,_tmax_cnt
5058  0b1a a30006        	cpw	x,#6
5059  0b1d 2e04          	jrsge	L7632
5062  0b1f 72130005      	bres	_flags,#1
5063  0b23               L7632:
5064                     ; 1076 } 
5067  0b23 81            	ret
5099                     ; 1079 void u_drv(void)		//1Hz
5099                     ; 1080 { 
5100                     	switch	.text
5101  0b24               _u_drv:
5105                     ; 1081 if(jp_mode!=jp3)
5107  0b24 b654          	ld	a,_jp_mode
5108  0b26 a103          	cp	a,#3
5109  0b28 2774          	jreq	L3042
5110                     ; 1083 	if(Ui>ee_Umax)umax_cnt++;
5112  0b2a 9c            	rvf
5113  0b2b ce000c        	ldw	x,_Ui
5114  0b2e c30014        	cpw	x,_ee_Umax
5115  0b31 2d09          	jrsle	L5042
5118  0b33 be70          	ldw	x,_umax_cnt
5119  0b35 1c0001        	addw	x,#1
5120  0b38 bf70          	ldw	_umax_cnt,x
5122  0b3a 2003          	jra	L7042
5123  0b3c               L5042:
5124                     ; 1084 	else umax_cnt=0;
5126  0b3c 5f            	clrw	x
5127  0b3d bf70          	ldw	_umax_cnt,x
5128  0b3f               L7042:
5129                     ; 1085 	gran(&umax_cnt,0,10);
5131  0b3f ae000a        	ldw	x,#10
5132  0b42 89            	pushw	x
5133  0b43 5f            	clrw	x
5134  0b44 89            	pushw	x
5135  0b45 ae0070        	ldw	x,#_umax_cnt
5136  0b48 cd00d5        	call	_gran
5138  0b4b 5b04          	addw	sp,#4
5139                     ; 1086 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5141  0b4d 9c            	rvf
5142  0b4e be70          	ldw	x,_umax_cnt
5143  0b50 a3000a        	cpw	x,#10
5144  0b53 2f04          	jrslt	L1142
5147  0b55 72160005      	bset	_flags,#3
5148  0b59               L1142:
5149                     ; 1089 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5151  0b59 9c            	rvf
5152  0b5a ce000c        	ldw	x,_Ui
5153  0b5d c3000e        	cpw	x,_Un
5154  0b60 2e1d          	jrsge	L3142
5156  0b62 9c            	rvf
5157  0b63 ce000e        	ldw	x,_Un
5158  0b66 72b0000c      	subw	x,_Ui
5159  0b6a c30012        	cpw	x,_ee_dU
5160  0b6d 2d10          	jrsle	L3142
5162  0b6f c65005        	ld	a,20485
5163  0b72 a504          	bcp	a,#4
5164  0b74 2609          	jrne	L3142
5167  0b76 be6e          	ldw	x,_umin_cnt
5168  0b78 1c0001        	addw	x,#1
5169  0b7b bf6e          	ldw	_umin_cnt,x
5171  0b7d 2003          	jra	L5142
5172  0b7f               L3142:
5173                     ; 1090 	else umin_cnt=0;
5175  0b7f 5f            	clrw	x
5176  0b80 bf6e          	ldw	_umin_cnt,x
5177  0b82               L5142:
5178                     ; 1091 	gran(&umin_cnt,0,10);	
5180  0b82 ae000a        	ldw	x,#10
5181  0b85 89            	pushw	x
5182  0b86 5f            	clrw	x
5183  0b87 89            	pushw	x
5184  0b88 ae006e        	ldw	x,#_umin_cnt
5185  0b8b cd00d5        	call	_gran
5187  0b8e 5b04          	addw	sp,#4
5188                     ; 1092 	if(umin_cnt>=10)flags|=0b00010000;	  
5190  0b90 9c            	rvf
5191  0b91 be6e          	ldw	x,_umin_cnt
5192  0b93 a3000a        	cpw	x,#10
5193  0b96 2f71          	jrslt	L1242
5196  0b98 72180005      	bset	_flags,#4
5197  0b9c 206b          	jra	L1242
5198  0b9e               L3042:
5199                     ; 1094 else if(jp_mode==jp3)
5201  0b9e b654          	ld	a,_jp_mode
5202  0ba0 a103          	cp	a,#3
5203  0ba2 2665          	jrne	L1242
5204                     ; 1096 	if(Ui>700)umax_cnt++;
5206  0ba4 9c            	rvf
5207  0ba5 ce000c        	ldw	x,_Ui
5208  0ba8 a302bd        	cpw	x,#701
5209  0bab 2f09          	jrslt	L5242
5212  0bad be70          	ldw	x,_umax_cnt
5213  0baf 1c0001        	addw	x,#1
5214  0bb2 bf70          	ldw	_umax_cnt,x
5216  0bb4 2003          	jra	L7242
5217  0bb6               L5242:
5218                     ; 1097 	else umax_cnt=0;
5220  0bb6 5f            	clrw	x
5221  0bb7 bf70          	ldw	_umax_cnt,x
5222  0bb9               L7242:
5223                     ; 1098 	gran(&umax_cnt,0,10);
5225  0bb9 ae000a        	ldw	x,#10
5226  0bbc 89            	pushw	x
5227  0bbd 5f            	clrw	x
5228  0bbe 89            	pushw	x
5229  0bbf ae0070        	ldw	x,#_umax_cnt
5230  0bc2 cd00d5        	call	_gran
5232  0bc5 5b04          	addw	sp,#4
5233                     ; 1099 	if(umax_cnt>=10)flags|=0b00001000;
5235  0bc7 9c            	rvf
5236  0bc8 be70          	ldw	x,_umax_cnt
5237  0bca a3000a        	cpw	x,#10
5238  0bcd 2f04          	jrslt	L1342
5241  0bcf 72160005      	bset	_flags,#3
5242  0bd3               L1342:
5243                     ; 1102 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5245  0bd3 9c            	rvf
5246  0bd4 ce000c        	ldw	x,_Ui
5247  0bd7 a300c8        	cpw	x,#200
5248  0bda 2e10          	jrsge	L3342
5250  0bdc c65005        	ld	a,20485
5251  0bdf a504          	bcp	a,#4
5252  0be1 2609          	jrne	L3342
5255  0be3 be6e          	ldw	x,_umin_cnt
5256  0be5 1c0001        	addw	x,#1
5257  0be8 bf6e          	ldw	_umin_cnt,x
5259  0bea 2003          	jra	L5342
5260  0bec               L3342:
5261                     ; 1103 	else umin_cnt=0;
5263  0bec 5f            	clrw	x
5264  0bed bf6e          	ldw	_umin_cnt,x
5265  0bef               L5342:
5266                     ; 1104 	gran(&umin_cnt,0,10);	
5268  0bef ae000a        	ldw	x,#10
5269  0bf2 89            	pushw	x
5270  0bf3 5f            	clrw	x
5271  0bf4 89            	pushw	x
5272  0bf5 ae006e        	ldw	x,#_umin_cnt
5273  0bf8 cd00d5        	call	_gran
5275  0bfb 5b04          	addw	sp,#4
5276                     ; 1105 	if(umin_cnt>=10)flags|=0b00010000;	  
5278  0bfd 9c            	rvf
5279  0bfe be6e          	ldw	x,_umin_cnt
5280  0c00 a3000a        	cpw	x,#10
5281  0c03 2f04          	jrslt	L1242
5284  0c05 72180005      	bset	_flags,#4
5285  0c09               L1242:
5286                     ; 1107 }
5289  0c09 81            	ret
5315                     ; 1132 void apv_start(void)
5315                     ; 1133 {
5316                     	switch	.text
5317  0c0a               _apv_start:
5321                     ; 1134 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5323  0c0a 3d4f          	tnz	_apv_cnt
5324  0c0c 2624          	jrne	L1542
5326  0c0e 3d50          	tnz	_apv_cnt+1
5327  0c10 2620          	jrne	L1542
5329  0c12 3d51          	tnz	_apv_cnt+2
5330  0c14 261c          	jrne	L1542
5332                     	btst	_bAPV
5333  0c1b 2515          	jrult	L1542
5334                     ; 1136 	apv_cnt[0]=60;
5336  0c1d 353c004f      	mov	_apv_cnt,#60
5337                     ; 1137 	apv_cnt[1]=60;
5339  0c21 353c0050      	mov	_apv_cnt+1,#60
5340                     ; 1138 	apv_cnt[2]=60;
5342  0c25 353c0051      	mov	_apv_cnt+2,#60
5343                     ; 1139 	apv_cnt_=3600;
5345  0c29 ae0e10        	ldw	x,#3600
5346  0c2c bf4d          	ldw	_apv_cnt_,x
5347                     ; 1140 	bAPV=1;	
5349  0c2e 72100002      	bset	_bAPV
5350  0c32               L1542:
5351                     ; 1142 }
5354  0c32 81            	ret
5380                     ; 1145 void apv_stop(void)
5380                     ; 1146 {
5381                     	switch	.text
5382  0c33               _apv_stop:
5386                     ; 1147 apv_cnt[0]=0;
5388  0c33 3f4f          	clr	_apv_cnt
5389                     ; 1148 apv_cnt[1]=0;
5391  0c35 3f50          	clr	_apv_cnt+1
5392                     ; 1149 apv_cnt[2]=0;
5394  0c37 3f51          	clr	_apv_cnt+2
5395                     ; 1150 apv_cnt_=0;	
5397  0c39 5f            	clrw	x
5398  0c3a bf4d          	ldw	_apv_cnt_,x
5399                     ; 1151 bAPV=0;
5401  0c3c 72110002      	bres	_bAPV
5402                     ; 1152 }
5405  0c40 81            	ret
5440                     ; 1156 void apv_hndl(void)
5440                     ; 1157 {
5441                     	switch	.text
5442  0c41               _apv_hndl:
5446                     ; 1158 if(apv_cnt[0])
5448  0c41 3d4f          	tnz	_apv_cnt
5449  0c43 271e          	jreq	L3742
5450                     ; 1160 	apv_cnt[0]--;
5452  0c45 3a4f          	dec	_apv_cnt
5453                     ; 1161 	if(apv_cnt[0]==0)
5455  0c47 3d4f          	tnz	_apv_cnt
5456  0c49 265a          	jrne	L7742
5457                     ; 1163 		flags&=0b11100001;
5459  0c4b b605          	ld	a,_flags
5460  0c4d a4e1          	and	a,#225
5461  0c4f b705          	ld	_flags,a
5462                     ; 1164 		tsign_cnt=0;
5464  0c51 5f            	clrw	x
5465  0c52 bf59          	ldw	_tsign_cnt,x
5466                     ; 1165 		tmax_cnt=0;
5468  0c54 5f            	clrw	x
5469  0c55 bf57          	ldw	_tmax_cnt,x
5470                     ; 1166 		umax_cnt=0;
5472  0c57 5f            	clrw	x
5473  0c58 bf70          	ldw	_umax_cnt,x
5474                     ; 1167 		umin_cnt=0;
5476  0c5a 5f            	clrw	x
5477  0c5b bf6e          	ldw	_umin_cnt,x
5478                     ; 1169 		led_drv_cnt=30;
5480  0c5d 351e0016      	mov	_led_drv_cnt,#30
5481  0c61 2042          	jra	L7742
5482  0c63               L3742:
5483                     ; 1172 else if(apv_cnt[1])
5485  0c63 3d50          	tnz	_apv_cnt+1
5486  0c65 271e          	jreq	L1052
5487                     ; 1174 	apv_cnt[1]--;
5489  0c67 3a50          	dec	_apv_cnt+1
5490                     ; 1175 	if(apv_cnt[1]==0)
5492  0c69 3d50          	tnz	_apv_cnt+1
5493  0c6b 2638          	jrne	L7742
5494                     ; 1177 		flags&=0b11100001;
5496  0c6d b605          	ld	a,_flags
5497  0c6f a4e1          	and	a,#225
5498  0c71 b705          	ld	_flags,a
5499                     ; 1178 		tsign_cnt=0;
5501  0c73 5f            	clrw	x
5502  0c74 bf59          	ldw	_tsign_cnt,x
5503                     ; 1179 		tmax_cnt=0;
5505  0c76 5f            	clrw	x
5506  0c77 bf57          	ldw	_tmax_cnt,x
5507                     ; 1180 		umax_cnt=0;
5509  0c79 5f            	clrw	x
5510  0c7a bf70          	ldw	_umax_cnt,x
5511                     ; 1181 		umin_cnt=0;
5513  0c7c 5f            	clrw	x
5514  0c7d bf6e          	ldw	_umin_cnt,x
5515                     ; 1183 		led_drv_cnt=30;
5517  0c7f 351e0016      	mov	_led_drv_cnt,#30
5518  0c83 2020          	jra	L7742
5519  0c85               L1052:
5520                     ; 1186 else if(apv_cnt[2])
5522  0c85 3d51          	tnz	_apv_cnt+2
5523  0c87 271c          	jreq	L7742
5524                     ; 1188 	apv_cnt[2]--;
5526  0c89 3a51          	dec	_apv_cnt+2
5527                     ; 1189 	if(apv_cnt[2]==0)
5529  0c8b 3d51          	tnz	_apv_cnt+2
5530  0c8d 2616          	jrne	L7742
5531                     ; 1191 		flags&=0b11100001;
5533  0c8f b605          	ld	a,_flags
5534  0c91 a4e1          	and	a,#225
5535  0c93 b705          	ld	_flags,a
5536                     ; 1192 		tsign_cnt=0;
5538  0c95 5f            	clrw	x
5539  0c96 bf59          	ldw	_tsign_cnt,x
5540                     ; 1193 		tmax_cnt=0;
5542  0c98 5f            	clrw	x
5543  0c99 bf57          	ldw	_tmax_cnt,x
5544                     ; 1194 		umax_cnt=0;
5546  0c9b 5f            	clrw	x
5547  0c9c bf70          	ldw	_umax_cnt,x
5548                     ; 1195 		umin_cnt=0;          
5550  0c9e 5f            	clrw	x
5551  0c9f bf6e          	ldw	_umin_cnt,x
5552                     ; 1197 		led_drv_cnt=30;
5554  0ca1 351e0016      	mov	_led_drv_cnt,#30
5555  0ca5               L7742:
5556                     ; 1201 if(apv_cnt_)
5558  0ca5 be4d          	ldw	x,_apv_cnt_
5559  0ca7 2712          	jreq	L3152
5560                     ; 1203 	apv_cnt_--;
5562  0ca9 be4d          	ldw	x,_apv_cnt_
5563  0cab 1d0001        	subw	x,#1
5564  0cae bf4d          	ldw	_apv_cnt_,x
5565                     ; 1204 	if(apv_cnt_==0) 
5567  0cb0 be4d          	ldw	x,_apv_cnt_
5568  0cb2 2607          	jrne	L3152
5569                     ; 1206 		bAPV=0;
5571  0cb4 72110002      	bres	_bAPV
5572                     ; 1207 		apv_start();
5574  0cb8 cd0c0a        	call	_apv_start
5576  0cbb               L3152:
5577                     ; 1211 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5579  0cbb be6e          	ldw	x,_umin_cnt
5580  0cbd 261e          	jrne	L7152
5582  0cbf be70          	ldw	x,_umax_cnt
5583  0cc1 261a          	jrne	L7152
5585  0cc3 c65005        	ld	a,20485
5586  0cc6 a504          	bcp	a,#4
5587  0cc8 2613          	jrne	L7152
5588                     ; 1213 	if(cnt_apv_off<20)
5590  0cca b64c          	ld	a,_cnt_apv_off
5591  0ccc a114          	cp	a,#20
5592  0cce 240f          	jruge	L5252
5593                     ; 1215 		cnt_apv_off++;
5595  0cd0 3c4c          	inc	_cnt_apv_off
5596                     ; 1216 		if(cnt_apv_off>=20)
5598  0cd2 b64c          	ld	a,_cnt_apv_off
5599  0cd4 a114          	cp	a,#20
5600  0cd6 2507          	jrult	L5252
5601                     ; 1218 			apv_stop();
5603  0cd8 cd0c33        	call	_apv_stop
5605  0cdb 2002          	jra	L5252
5606  0cdd               L7152:
5607                     ; 1222 else cnt_apv_off=0;	
5609  0cdd 3f4c          	clr	_cnt_apv_off
5610  0cdf               L5252:
5611                     ; 1224 }
5614  0cdf 81            	ret
5617                     	switch	.ubsct
5618  0000               L7252_flags_old:
5619  0000 00            	ds.b	1
5655                     ; 1227 void flags_drv(void)
5655                     ; 1228 {
5656                     	switch	.text
5657  0ce0               _flags_drv:
5661                     ; 1230 if(jp_mode!=jp3) 
5663  0ce0 b654          	ld	a,_jp_mode
5664  0ce2 a103          	cp	a,#3
5665  0ce4 2723          	jreq	L7452
5666                     ; 1232 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5668  0ce6 b605          	ld	a,_flags
5669  0ce8 a508          	bcp	a,#8
5670  0cea 2706          	jreq	L5552
5672  0cec b600          	ld	a,L7252_flags_old
5673  0cee a508          	bcp	a,#8
5674  0cf0 270c          	jreq	L3552
5675  0cf2               L5552:
5677  0cf2 b605          	ld	a,_flags
5678  0cf4 a510          	bcp	a,#16
5679  0cf6 2726          	jreq	L1652
5681  0cf8 b600          	ld	a,L7252_flags_old
5682  0cfa a510          	bcp	a,#16
5683  0cfc 2620          	jrne	L1652
5684  0cfe               L3552:
5685                     ; 1234     		if(link==OFF)apv_start();
5687  0cfe b66d          	ld	a,_link
5688  0d00 a1aa          	cp	a,#170
5689  0d02 261a          	jrne	L1652
5692  0d04 cd0c0a        	call	_apv_start
5694  0d07 2015          	jra	L1652
5695  0d09               L7452:
5696                     ; 1237 else if(jp_mode==jp3) 
5698  0d09 b654          	ld	a,_jp_mode
5699  0d0b a103          	cp	a,#3
5700  0d0d 260f          	jrne	L1652
5701                     ; 1239 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5703  0d0f b605          	ld	a,_flags
5704  0d11 a508          	bcp	a,#8
5705  0d13 2709          	jreq	L1652
5707  0d15 b600          	ld	a,L7252_flags_old
5708  0d17 a508          	bcp	a,#8
5709  0d19 2603          	jrne	L1652
5710                     ; 1241     		apv_start();
5712  0d1b cd0c0a        	call	_apv_start
5714  0d1e               L1652:
5715                     ; 1244 flags_old=flags;
5717  0d1e 450500        	mov	L7252_flags_old,_flags
5718                     ; 1246 } 
5721  0d21 81            	ret
5756                     ; 1383 void adr_drv_v4(char in)
5756                     ; 1384 {
5757                     	switch	.text
5758  0d22               _adr_drv_v4:
5762                     ; 1385 if(adress!=in)adress=in;
5764  0d22 c100f7        	cp	a,_adress
5765  0d25 2703          	jreq	L5062
5768  0d27 c700f7        	ld	_adress,a
5769  0d2a               L5062:
5770                     ; 1386 }
5773  0d2a 81            	ret
5802                     ; 1389 void adr_drv_v3(void)
5802                     ; 1390 {
5803                     	switch	.text
5804  0d2b               _adr_drv_v3:
5806  0d2b 88            	push	a
5807       00000001      OFST:	set	1
5810                     ; 1396 GPIOB->DDR&=~(1<<0);
5812  0d2c 72115007      	bres	20487,#0
5813                     ; 1397 GPIOB->CR1&=~(1<<0);
5815  0d30 72115008      	bres	20488,#0
5816                     ; 1398 GPIOB->CR2&=~(1<<0);
5818  0d34 72115009      	bres	20489,#0
5819                     ; 1399 ADC2->CR2=0x08;
5821  0d38 35085402      	mov	21506,#8
5822                     ; 1400 ADC2->CR1=0x40;
5824  0d3c 35405401      	mov	21505,#64
5825                     ; 1401 ADC2->CSR=0x20+0;
5827  0d40 35205400      	mov	21504,#32
5828                     ; 1402 ADC2->CR1|=1;
5830  0d44 72105401      	bset	21505,#0
5831                     ; 1403 ADC2->CR1|=1;
5833  0d48 72105401      	bset	21505,#0
5834                     ; 1404 adr_drv_stat=1;
5836  0d4c 35010002      	mov	_adr_drv_stat,#1
5837  0d50               L7162:
5838                     ; 1405 while(adr_drv_stat==1);
5841  0d50 b602          	ld	a,_adr_drv_stat
5842  0d52 a101          	cp	a,#1
5843  0d54 27fa          	jreq	L7162
5844                     ; 1407 GPIOB->DDR&=~(1<<1);
5846  0d56 72135007      	bres	20487,#1
5847                     ; 1408 GPIOB->CR1&=~(1<<1);
5849  0d5a 72135008      	bres	20488,#1
5850                     ; 1409 GPIOB->CR2&=~(1<<1);
5852  0d5e 72135009      	bres	20489,#1
5853                     ; 1410 ADC2->CR2=0x08;
5855  0d62 35085402      	mov	21506,#8
5856                     ; 1411 ADC2->CR1=0x40;
5858  0d66 35405401      	mov	21505,#64
5859                     ; 1412 ADC2->CSR=0x20+1;
5861  0d6a 35215400      	mov	21504,#33
5862                     ; 1413 ADC2->CR1|=1;
5864  0d6e 72105401      	bset	21505,#0
5865                     ; 1414 ADC2->CR1|=1;
5867  0d72 72105401      	bset	21505,#0
5868                     ; 1415 adr_drv_stat=3;
5870  0d76 35030002      	mov	_adr_drv_stat,#3
5871  0d7a               L5262:
5872                     ; 1416 while(adr_drv_stat==3);
5875  0d7a b602          	ld	a,_adr_drv_stat
5876  0d7c a103          	cp	a,#3
5877  0d7e 27fa          	jreq	L5262
5878                     ; 1418 GPIOE->DDR&=~(1<<6);
5880  0d80 721d5016      	bres	20502,#6
5881                     ; 1419 GPIOE->CR1&=~(1<<6);
5883  0d84 721d5017      	bres	20503,#6
5884                     ; 1420 GPIOE->CR2&=~(1<<6);
5886  0d88 721d5018      	bres	20504,#6
5887                     ; 1421 ADC2->CR2=0x08;
5889  0d8c 35085402      	mov	21506,#8
5890                     ; 1422 ADC2->CR1=0x40;
5892  0d90 35405401      	mov	21505,#64
5893                     ; 1423 ADC2->CSR=0x20+9;
5895  0d94 35295400      	mov	21504,#41
5896                     ; 1424 ADC2->CR1|=1;
5898  0d98 72105401      	bset	21505,#0
5899                     ; 1425 ADC2->CR1|=1;
5901  0d9c 72105401      	bset	21505,#0
5902                     ; 1426 adr_drv_stat=5;
5904  0da0 35050002      	mov	_adr_drv_stat,#5
5905  0da4               L3362:
5906                     ; 1427 while(adr_drv_stat==5);
5909  0da4 b602          	ld	a,_adr_drv_stat
5910  0da6 a105          	cp	a,#5
5911  0da8 27fa          	jreq	L3362
5912                     ; 1431 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5914  0daa 9c            	rvf
5915  0dab ce00ff        	ldw	x,_adc_buff_
5916  0dae a3022a        	cpw	x,#554
5917  0db1 2f0f          	jrslt	L1462
5919  0db3 9c            	rvf
5920  0db4 ce00ff        	ldw	x,_adc_buff_
5921  0db7 a30253        	cpw	x,#595
5922  0dba 2e06          	jrsge	L1462
5925  0dbc 725f00f8      	clr	_adr
5927  0dc0 204c          	jra	L3462
5928  0dc2               L1462:
5929                     ; 1432 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5931  0dc2 9c            	rvf
5932  0dc3 ce00ff        	ldw	x,_adc_buff_
5933  0dc6 a3036d        	cpw	x,#877
5934  0dc9 2f0f          	jrslt	L5462
5936  0dcb 9c            	rvf
5937  0dcc ce00ff        	ldw	x,_adc_buff_
5938  0dcf a30396        	cpw	x,#918
5939  0dd2 2e06          	jrsge	L5462
5942  0dd4 350100f8      	mov	_adr,#1
5944  0dd8 2034          	jra	L3462
5945  0dda               L5462:
5946                     ; 1433 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5948  0dda 9c            	rvf
5949  0ddb ce00ff        	ldw	x,_adc_buff_
5950  0dde a302a3        	cpw	x,#675
5951  0de1 2f0f          	jrslt	L1562
5953  0de3 9c            	rvf
5954  0de4 ce00ff        	ldw	x,_adc_buff_
5955  0de7 a302cc        	cpw	x,#716
5956  0dea 2e06          	jrsge	L1562
5959  0dec 350200f8      	mov	_adr,#2
5961  0df0 201c          	jra	L3462
5962  0df2               L1562:
5963                     ; 1434 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5965  0df2 9c            	rvf
5966  0df3 ce00ff        	ldw	x,_adc_buff_
5967  0df6 a303e3        	cpw	x,#995
5968  0df9 2f0f          	jrslt	L5562
5970  0dfb 9c            	rvf
5971  0dfc ce00ff        	ldw	x,_adc_buff_
5972  0dff a3040c        	cpw	x,#1036
5973  0e02 2e06          	jrsge	L5562
5976  0e04 350300f8      	mov	_adr,#3
5978  0e08 2004          	jra	L3462
5979  0e0a               L5562:
5980                     ; 1435 else adr[0]=5;
5982  0e0a 350500f8      	mov	_adr,#5
5983  0e0e               L3462:
5984                     ; 1437 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5986  0e0e 9c            	rvf
5987  0e0f ce0101        	ldw	x,_adc_buff_+2
5988  0e12 a3022a        	cpw	x,#554
5989  0e15 2f0f          	jrslt	L1662
5991  0e17 9c            	rvf
5992  0e18 ce0101        	ldw	x,_adc_buff_+2
5993  0e1b a30253        	cpw	x,#595
5994  0e1e 2e06          	jrsge	L1662
5997  0e20 725f00f9      	clr	_adr+1
5999  0e24 204c          	jra	L3662
6000  0e26               L1662:
6001                     ; 1438 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6003  0e26 9c            	rvf
6004  0e27 ce0101        	ldw	x,_adc_buff_+2
6005  0e2a a3036d        	cpw	x,#877
6006  0e2d 2f0f          	jrslt	L5662
6008  0e2f 9c            	rvf
6009  0e30 ce0101        	ldw	x,_adc_buff_+2
6010  0e33 a30396        	cpw	x,#918
6011  0e36 2e06          	jrsge	L5662
6014  0e38 350100f9      	mov	_adr+1,#1
6016  0e3c 2034          	jra	L3662
6017  0e3e               L5662:
6018                     ; 1439 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6020  0e3e 9c            	rvf
6021  0e3f ce0101        	ldw	x,_adc_buff_+2
6022  0e42 a302a3        	cpw	x,#675
6023  0e45 2f0f          	jrslt	L1762
6025  0e47 9c            	rvf
6026  0e48 ce0101        	ldw	x,_adc_buff_+2
6027  0e4b a302cc        	cpw	x,#716
6028  0e4e 2e06          	jrsge	L1762
6031  0e50 350200f9      	mov	_adr+1,#2
6033  0e54 201c          	jra	L3662
6034  0e56               L1762:
6035                     ; 1440 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6037  0e56 9c            	rvf
6038  0e57 ce0101        	ldw	x,_adc_buff_+2
6039  0e5a a303e3        	cpw	x,#995
6040  0e5d 2f0f          	jrslt	L5762
6042  0e5f 9c            	rvf
6043  0e60 ce0101        	ldw	x,_adc_buff_+2
6044  0e63 a3040c        	cpw	x,#1036
6045  0e66 2e06          	jrsge	L5762
6048  0e68 350300f9      	mov	_adr+1,#3
6050  0e6c 2004          	jra	L3662
6051  0e6e               L5762:
6052                     ; 1441 else adr[1]=5;
6054  0e6e 350500f9      	mov	_adr+1,#5
6055  0e72               L3662:
6056                     ; 1443 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6058  0e72 9c            	rvf
6059  0e73 ce0111        	ldw	x,_adc_buff_+18
6060  0e76 a3022a        	cpw	x,#554
6061  0e79 2f0f          	jrslt	L1072
6063  0e7b 9c            	rvf
6064  0e7c ce0111        	ldw	x,_adc_buff_+18
6065  0e7f a30253        	cpw	x,#595
6066  0e82 2e06          	jrsge	L1072
6069  0e84 725f00fa      	clr	_adr+2
6071  0e88 204c          	jra	L3072
6072  0e8a               L1072:
6073                     ; 1444 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6075  0e8a 9c            	rvf
6076  0e8b ce0111        	ldw	x,_adc_buff_+18
6077  0e8e a3036d        	cpw	x,#877
6078  0e91 2f0f          	jrslt	L5072
6080  0e93 9c            	rvf
6081  0e94 ce0111        	ldw	x,_adc_buff_+18
6082  0e97 a30396        	cpw	x,#918
6083  0e9a 2e06          	jrsge	L5072
6086  0e9c 350100fa      	mov	_adr+2,#1
6088  0ea0 2034          	jra	L3072
6089  0ea2               L5072:
6090                     ; 1445 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6092  0ea2 9c            	rvf
6093  0ea3 ce0111        	ldw	x,_adc_buff_+18
6094  0ea6 a302a3        	cpw	x,#675
6095  0ea9 2f0f          	jrslt	L1172
6097  0eab 9c            	rvf
6098  0eac ce0111        	ldw	x,_adc_buff_+18
6099  0eaf a302cc        	cpw	x,#716
6100  0eb2 2e06          	jrsge	L1172
6103  0eb4 350200fa      	mov	_adr+2,#2
6105  0eb8 201c          	jra	L3072
6106  0eba               L1172:
6107                     ; 1446 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6109  0eba 9c            	rvf
6110  0ebb ce0111        	ldw	x,_adc_buff_+18
6111  0ebe a303e3        	cpw	x,#995
6112  0ec1 2f0f          	jrslt	L5172
6114  0ec3 9c            	rvf
6115  0ec4 ce0111        	ldw	x,_adc_buff_+18
6116  0ec7 a3040c        	cpw	x,#1036
6117  0eca 2e06          	jrsge	L5172
6120  0ecc 350300fa      	mov	_adr+2,#3
6122  0ed0 2004          	jra	L3072
6123  0ed2               L5172:
6124                     ; 1447 else adr[2]=5;
6126  0ed2 350500fa      	mov	_adr+2,#5
6127  0ed6               L3072:
6128                     ; 1451 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6130  0ed6 c600f8        	ld	a,_adr
6131  0ed9 a105          	cp	a,#5
6132  0edb 270e          	jreq	L3272
6134  0edd c600f9        	ld	a,_adr+1
6135  0ee0 a105          	cp	a,#5
6136  0ee2 2707          	jreq	L3272
6138  0ee4 c600fa        	ld	a,_adr+2
6139  0ee7 a105          	cp	a,#5
6140  0ee9 2606          	jrne	L1272
6141  0eeb               L3272:
6142                     ; 1454 	adress_error=1;
6144  0eeb 350100f6      	mov	_adress_error,#1
6146  0eef               L7272:
6147                     ; 1465 }
6150  0eef 84            	pop	a
6151  0ef0 81            	ret
6152  0ef1               L1272:
6153                     ; 1458 	if(adr[2]&0x02) bps_class=bpsIPS;
6155  0ef1 c600fa        	ld	a,_adr+2
6156  0ef4 a502          	bcp	a,#2
6157  0ef6 2706          	jreq	L1372
6160  0ef8 3501000b      	mov	_bps_class,#1
6162  0efc 2002          	jra	L3372
6163  0efe               L1372:
6164                     ; 1459 	else bps_class=bpsIBEP;
6166  0efe 3f0b          	clr	_bps_class
6167  0f00               L3372:
6168                     ; 1461 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6170  0f00 c600fa        	ld	a,_adr+2
6171  0f03 a401          	and	a,#1
6172  0f05 97            	ld	xl,a
6173  0f06 a610          	ld	a,#16
6174  0f08 42            	mul	x,a
6175  0f09 9f            	ld	a,xl
6176  0f0a 6b01          	ld	(OFST+0,sp),a
6177  0f0c c600f9        	ld	a,_adr+1
6178  0f0f 48            	sll	a
6179  0f10 48            	sll	a
6180  0f11 cb00f8        	add	a,_adr
6181  0f14 1b01          	add	a,(OFST+0,sp)
6182  0f16 c700f7        	ld	_adress,a
6183  0f19 20d4          	jra	L7272
6206                     ; 1515 void init_CAN(void) {
6207                     	switch	.text
6208  0f1b               _init_CAN:
6212                     ; 1516 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6214  0f1b 72135420      	bres	21536,#1
6215                     ; 1517 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6217  0f1f 72105420      	bset	21536,#0
6219  0f23               L7472:
6220                     ; 1518 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6222  0f23 c65421        	ld	a,21537
6223  0f26 a501          	bcp	a,#1
6224  0f28 27f9          	jreq	L7472
6225                     ; 1520 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6227  0f2a 72185420      	bset	21536,#4
6228                     ; 1522 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6230  0f2e 35025427      	mov	21543,#2
6231                     ; 1531 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6233  0f32 35135428      	mov	21544,#19
6234                     ; 1532 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6236  0f36 35c05429      	mov	21545,#192
6237                     ; 1533 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6239  0f3a 357f542c      	mov	21548,#127
6240                     ; 1534 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6242  0f3e 35e0542d      	mov	21549,#224
6243                     ; 1536 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6245  0f42 35315430      	mov	21552,#49
6246                     ; 1537 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6248  0f46 35c05431      	mov	21553,#192
6249                     ; 1538 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6251  0f4a 357f5434      	mov	21556,#127
6252                     ; 1539 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6254  0f4e 35e05435      	mov	21557,#224
6255                     ; 1543 	CAN->PSR= 6;									// set page 6
6257  0f52 35065427      	mov	21543,#6
6258                     ; 1548 	CAN->Page.Config.FMR1&=~3;								//mask mode
6260  0f56 c65430        	ld	a,21552
6261  0f59 a4fc          	and	a,#252
6262  0f5b c75430        	ld	21552,a
6263                     ; 1554 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6265  0f5e 35065432      	mov	21554,#6
6266                     ; 1555 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6268  0f62 35605432      	mov	21554,#96
6269                     ; 1558 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6271  0f66 72105432      	bset	21554,#0
6272                     ; 1559 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6274  0f6a 72185432      	bset	21554,#4
6275                     ; 1562 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6277  0f6e 35065427      	mov	21543,#6
6278                     ; 1564 	CAN->Page.Config.BTR1= 19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6280  0f72 3513542c      	mov	21548,#19
6281                     ; 1565 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6283  0f76 35e7542d      	mov	21549,#231
6284                     ; 1567 	CAN->IER|=(1<<1);
6286  0f7a 72125425      	bset	21541,#1
6287                     ; 1570 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6289  0f7e 72115420      	bres	21536,#0
6291  0f82               L5572:
6292                     ; 1571 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6294  0f82 c65421        	ld	a,21537
6295  0f85 a501          	bcp	a,#1
6296  0f87 26f9          	jrne	L5572
6297                     ; 1572 }
6300  0f89 81            	ret
6408                     ; 1575 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6408                     ; 1576 {
6409                     	switch	.text
6410  0f8a               _can_transmit:
6412  0f8a 89            	pushw	x
6413       00000000      OFST:	set	0
6416                     ; 1578 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6418  0f8b b676          	ld	a,_can_buff_wr_ptr
6419  0f8d a104          	cp	a,#4
6420  0f8f 2502          	jrult	L7303
6423  0f91 3f76          	clr	_can_buff_wr_ptr
6424  0f93               L7303:
6425                     ; 1580 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6427  0f93 b676          	ld	a,_can_buff_wr_ptr
6428  0f95 97            	ld	xl,a
6429  0f96 a610          	ld	a,#16
6430  0f98 42            	mul	x,a
6431  0f99 1601          	ldw	y,(OFST+1,sp)
6432  0f9b a606          	ld	a,#6
6433  0f9d               L231:
6434  0f9d 9054          	srlw	y
6435  0f9f 4a            	dec	a
6436  0fa0 26fb          	jrne	L231
6437  0fa2 909f          	ld	a,yl
6438  0fa4 e777          	ld	(_can_out_buff,x),a
6439                     ; 1581 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6441  0fa6 b676          	ld	a,_can_buff_wr_ptr
6442  0fa8 97            	ld	xl,a
6443  0fa9 a610          	ld	a,#16
6444  0fab 42            	mul	x,a
6445  0fac 7b02          	ld	a,(OFST+2,sp)
6446  0fae 48            	sll	a
6447  0faf 48            	sll	a
6448  0fb0 e778          	ld	(_can_out_buff+1,x),a
6449                     ; 1583 can_out_buff[can_buff_wr_ptr][2]=data0;
6451  0fb2 b676          	ld	a,_can_buff_wr_ptr
6452  0fb4 97            	ld	xl,a
6453  0fb5 a610          	ld	a,#16
6454  0fb7 42            	mul	x,a
6455  0fb8 7b05          	ld	a,(OFST+5,sp)
6456  0fba e779          	ld	(_can_out_buff+2,x),a
6457                     ; 1584 can_out_buff[can_buff_wr_ptr][3]=data1;
6459  0fbc b676          	ld	a,_can_buff_wr_ptr
6460  0fbe 97            	ld	xl,a
6461  0fbf a610          	ld	a,#16
6462  0fc1 42            	mul	x,a
6463  0fc2 7b06          	ld	a,(OFST+6,sp)
6464  0fc4 e77a          	ld	(_can_out_buff+3,x),a
6465                     ; 1585 can_out_buff[can_buff_wr_ptr][4]=data2;
6467  0fc6 b676          	ld	a,_can_buff_wr_ptr
6468  0fc8 97            	ld	xl,a
6469  0fc9 a610          	ld	a,#16
6470  0fcb 42            	mul	x,a
6471  0fcc 7b07          	ld	a,(OFST+7,sp)
6472  0fce e77b          	ld	(_can_out_buff+4,x),a
6473                     ; 1586 can_out_buff[can_buff_wr_ptr][5]=data3;
6475  0fd0 b676          	ld	a,_can_buff_wr_ptr
6476  0fd2 97            	ld	xl,a
6477  0fd3 a610          	ld	a,#16
6478  0fd5 42            	mul	x,a
6479  0fd6 7b08          	ld	a,(OFST+8,sp)
6480  0fd8 e77c          	ld	(_can_out_buff+5,x),a
6481                     ; 1587 can_out_buff[can_buff_wr_ptr][6]=data4;
6483  0fda b676          	ld	a,_can_buff_wr_ptr
6484  0fdc 97            	ld	xl,a
6485  0fdd a610          	ld	a,#16
6486  0fdf 42            	mul	x,a
6487  0fe0 7b09          	ld	a,(OFST+9,sp)
6488  0fe2 e77d          	ld	(_can_out_buff+6,x),a
6489                     ; 1588 can_out_buff[can_buff_wr_ptr][7]=data5;
6491  0fe4 b676          	ld	a,_can_buff_wr_ptr
6492  0fe6 97            	ld	xl,a
6493  0fe7 a610          	ld	a,#16
6494  0fe9 42            	mul	x,a
6495  0fea 7b0a          	ld	a,(OFST+10,sp)
6496  0fec e77e          	ld	(_can_out_buff+7,x),a
6497                     ; 1589 can_out_buff[can_buff_wr_ptr][8]=data6;
6499  0fee b676          	ld	a,_can_buff_wr_ptr
6500  0ff0 97            	ld	xl,a
6501  0ff1 a610          	ld	a,#16
6502  0ff3 42            	mul	x,a
6503  0ff4 7b0b          	ld	a,(OFST+11,sp)
6504  0ff6 e77f          	ld	(_can_out_buff+8,x),a
6505                     ; 1590 can_out_buff[can_buff_wr_ptr][9]=data7;
6507  0ff8 b676          	ld	a,_can_buff_wr_ptr
6508  0ffa 97            	ld	xl,a
6509  0ffb a610          	ld	a,#16
6510  0ffd 42            	mul	x,a
6511  0ffe 7b0c          	ld	a,(OFST+12,sp)
6512  1000 e780          	ld	(_can_out_buff+9,x),a
6513                     ; 1592 can_buff_wr_ptr++;
6515  1002 3c76          	inc	_can_buff_wr_ptr
6516                     ; 1593 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6518  1004 b676          	ld	a,_can_buff_wr_ptr
6519  1006 a104          	cp	a,#4
6520  1008 2502          	jrult	L1403
6523  100a 3f76          	clr	_can_buff_wr_ptr
6524  100c               L1403:
6525                     ; 1594 } 
6528  100c 85            	popw	x
6529  100d 81            	ret
6558                     ; 1597 void can_tx_hndl(void)
6558                     ; 1598 {
6559                     	switch	.text
6560  100e               _can_tx_hndl:
6564                     ; 1599 if(bTX_FREE)
6566  100e 3d03          	tnz	_bTX_FREE
6567  1010 2757          	jreq	L3503
6568                     ; 1601 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6570  1012 b675          	ld	a,_can_buff_rd_ptr
6571  1014 b176          	cp	a,_can_buff_wr_ptr
6572  1016 275f          	jreq	L1603
6573                     ; 1603 		bTX_FREE=0;
6575  1018 3f03          	clr	_bTX_FREE
6576                     ; 1605 		CAN->PSR= 0;
6578  101a 725f5427      	clr	21543
6579                     ; 1606 		CAN->Page.TxMailbox.MDLCR=8;
6581  101e 35085429      	mov	21545,#8
6582                     ; 1607 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6584  1022 b675          	ld	a,_can_buff_rd_ptr
6585  1024 97            	ld	xl,a
6586  1025 a610          	ld	a,#16
6587  1027 42            	mul	x,a
6588  1028 e677          	ld	a,(_can_out_buff,x)
6589  102a c7542a        	ld	21546,a
6590                     ; 1608 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6592  102d b675          	ld	a,_can_buff_rd_ptr
6593  102f 97            	ld	xl,a
6594  1030 a610          	ld	a,#16
6595  1032 42            	mul	x,a
6596  1033 e678          	ld	a,(_can_out_buff+1,x)
6597  1035 c7542b        	ld	21547,a
6598                     ; 1610 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6600  1038 b675          	ld	a,_can_buff_rd_ptr
6601  103a 97            	ld	xl,a
6602  103b a610          	ld	a,#16
6603  103d 42            	mul	x,a
6604  103e 01            	rrwa	x,a
6605  103f ab79          	add	a,#_can_out_buff+2
6606  1041 2401          	jrnc	L631
6607  1043 5c            	incw	x
6608  1044               L631:
6609  1044 5f            	clrw	x
6610  1045 97            	ld	xl,a
6611  1046 bf00          	ldw	c_x,x
6612  1048 ae0008        	ldw	x,#8
6613  104b               L041:
6614  104b 5a            	decw	x
6615  104c 92d600        	ld	a,([c_x],x)
6616  104f d7542e        	ld	(21550,x),a
6617  1052 5d            	tnzw	x
6618  1053 26f6          	jrne	L041
6619                     ; 1612 		can_buff_rd_ptr++;
6621  1055 3c75          	inc	_can_buff_rd_ptr
6622                     ; 1613 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6624  1057 b675          	ld	a,_can_buff_rd_ptr
6625  1059 a104          	cp	a,#4
6626  105b 2502          	jrult	L7503
6629  105d 3f75          	clr	_can_buff_rd_ptr
6630  105f               L7503:
6631                     ; 1615 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6633  105f 72105428      	bset	21544,#0
6634                     ; 1616 		CAN->IER|=(1<<0);
6636  1063 72105425      	bset	21541,#0
6637  1067 200e          	jra	L1603
6638  1069               L3503:
6639                     ; 1621 	tx_busy_cnt++;
6641  1069 3c74          	inc	_tx_busy_cnt
6642                     ; 1622 	if(tx_busy_cnt>=100)
6644  106b b674          	ld	a,_tx_busy_cnt
6645  106d a164          	cp	a,#100
6646  106f 2506          	jrult	L1603
6647                     ; 1624 		tx_busy_cnt=0;
6649  1071 3f74          	clr	_tx_busy_cnt
6650                     ; 1625 		bTX_FREE=1;
6652  1073 35010003      	mov	_bTX_FREE,#1
6653  1077               L1603:
6654                     ; 1628 }
6657  1077 81            	ret
6772                     ; 1654 void can_in_an(void)
6772                     ; 1655 {
6773                     	switch	.text
6774  1078               _can_in_an:
6776  1078 5207          	subw	sp,#7
6777       00000007      OFST:	set	7
6780                     ; 1665 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6782  107a b6cd          	ld	a,_mess+6
6783  107c c100f7        	cp	a,_adress
6784  107f 2703          	jreq	L061
6785  1081 cc11b9        	jp	L1213
6786  1084               L061:
6788  1084 b6ce          	ld	a,_mess+7
6789  1086 c100f7        	cp	a,_adress
6790  1089 2703          	jreq	L261
6791  108b cc11b9        	jp	L1213
6792  108e               L261:
6794  108e b6cf          	ld	a,_mess+8
6795  1090 a1ed          	cp	a,#237
6796  1092 2703          	jreq	L461
6797  1094 cc11b9        	jp	L1213
6798  1097               L461:
6799                     ; 1668 	can_error_cnt=0;
6801  1097 3f73          	clr	_can_error_cnt
6802                     ; 1670 	bMAIN=0;
6804  1099 72110001      	bres	_bMAIN
6805                     ; 1671  	flags_tu=mess[9];
6807  109d 45d06a        	mov	_flags_tu,_mess+9
6808                     ; 1672  	if(flags_tu&0b00000001)
6810  10a0 b66a          	ld	a,_flags_tu
6811  10a2 a501          	bcp	a,#1
6812  10a4 2706          	jreq	L3213
6813                     ; 1677  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6815  10a6 721a0005      	bset	_flags,#5
6817  10aa 2008          	jra	L5213
6818  10ac               L3213:
6819                     ; 1688  				flags&=0b11011111; 
6821  10ac 721b0005      	bres	_flags,#5
6822                     ; 1689  				off_bp_cnt=5*EE_TZAS;
6824  10b0 350f005d      	mov	_off_bp_cnt,#15
6825  10b4               L5213:
6826                     ; 1695  	if(flags_tu&0b00000010) flags|=0b01000000;
6828  10b4 b66a          	ld	a,_flags_tu
6829  10b6 a502          	bcp	a,#2
6830  10b8 2706          	jreq	L7213
6833  10ba 721c0005      	bset	_flags,#6
6835  10be 2004          	jra	L1313
6836  10c0               L7213:
6837                     ; 1696  	else flags&=0b10111111; 
6839  10c0 721d0005      	bres	_flags,#6
6840  10c4               L1313:
6841                     ; 1698  	U_out_const=mess[10]+mess[11]*256;
6843  10c4 b6d2          	ld	a,_mess+11
6844  10c6 5f            	clrw	x
6845  10c7 97            	ld	xl,a
6846  10c8 4f            	clr	a
6847  10c9 02            	rlwa	x,a
6848  10ca 01            	rrwa	x,a
6849  10cb bbd1          	add	a,_mess+10
6850  10cd 2401          	jrnc	L441
6851  10cf 5c            	incw	x
6852  10d0               L441:
6853  10d0 c70009        	ld	_U_out_const+1,a
6854  10d3 9f            	ld	a,xl
6855  10d4 c70008        	ld	_U_out_const,a
6856                     ; 1699  	vol_i_temp=mess[12]+mess[13]*256;  
6858  10d7 b6d4          	ld	a,_mess+13
6859  10d9 5f            	clrw	x
6860  10da 97            	ld	xl,a
6861  10db 4f            	clr	a
6862  10dc 02            	rlwa	x,a
6863  10dd 01            	rrwa	x,a
6864  10de bbd3          	add	a,_mess+12
6865  10e0 2401          	jrnc	L641
6866  10e2 5c            	incw	x
6867  10e3               L641:
6868  10e3 b761          	ld	_vol_i_temp+1,a
6869  10e5 9f            	ld	a,xl
6870  10e6 b760          	ld	_vol_i_temp,a
6871                     ; 1709 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6873  10e8 b608          	ld	a,_vent_resurs_tx_cnt
6874  10ea a102          	cp	a,#2
6875  10ec 2507          	jrult	L3313
6878  10ee ce0000        	ldw	x,_vent_resurs
6879  10f1 bf41          	ldw	_plazma_int+4,x
6881  10f3 2004          	jra	L5313
6882  10f5               L3313:
6883                     ; 1710 	else plazma_int[2]=vent_resurs_sec_cnt;
6885  10f5 be09          	ldw	x,_vent_resurs_sec_cnt
6886  10f7 bf41          	ldw	_plazma_int+4,x
6887  10f9               L5313:
6888                     ; 1711  	rotor_int=flags_tu+(((short)flags)<<8);
6890  10f9 b605          	ld	a,_flags
6891  10fb 5f            	clrw	x
6892  10fc 97            	ld	xl,a
6893  10fd 4f            	clr	a
6894  10fe 02            	rlwa	x,a
6895  10ff 01            	rrwa	x,a
6896  1100 bb6a          	add	a,_flags_tu
6897  1102 2401          	jrnc	L051
6898  1104 5c            	incw	x
6899  1105               L051:
6900  1105 b718          	ld	_rotor_int+1,a
6901  1107 9f            	ld	a,xl
6902  1108 b717          	ld	_rotor_int,a
6903                     ; 1712 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6905  110a 3b000c        	push	_Ui
6906  110d 3b000d        	push	_Ui+1
6907  1110 3b000e        	push	_Un
6908  1113 3b000f        	push	_Un+1
6909  1116 3b0010        	push	_I
6910  1119 3b0011        	push	_I+1
6911  111c 4bda          	push	#218
6912  111e 3b00f7        	push	_adress
6913  1121 ae018e        	ldw	x,#398
6914  1124 cd0f8a        	call	_can_transmit
6916  1127 5b08          	addw	sp,#8
6917                     ; 1713 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6919  1129 3b0006        	push	_Usum
6920  112c 3b0007        	push	_Usum+1
6921  112f 3b0069        	push	__x_+1
6922  1132 3b0005        	push	_flags
6923  1135 b608          	ld	a,_vent_resurs_tx_cnt
6924  1137 5f            	clrw	x
6925  1138 97            	ld	xl,a
6926  1139 d60000        	ld	a,(_vent_resurs_buff,x)
6927  113c 88            	push	a
6928  113d 3b0072        	push	_T
6929  1140 4bdb          	push	#219
6930  1142 3b00f7        	push	_adress
6931  1145 ae018e        	ldw	x,#398
6932  1148 cd0f8a        	call	_can_transmit
6934  114b 5b08          	addw	sp,#8
6935                     ; 1714 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6937  114d 3b0005        	push	_debug_info_to_uku+4
6938  1150 3b0006        	push	_debug_info_to_uku+5
6939  1153 3b0003        	push	_debug_info_to_uku+2
6940  1156 3b0004        	push	_debug_info_to_uku+3
6941  1159 3b0001        	push	_debug_info_to_uku
6942  115c 3b0002        	push	_debug_info_to_uku+1
6943  115f 4bdc          	push	#220
6944  1161 3b00f7        	push	_adress
6945  1164 ae018e        	ldw	x,#398
6946  1167 cd0f8a        	call	_can_transmit
6948  116a 5b08          	addw	sp,#8
6949                     ; 1715      link_cnt=0;
6951  116c 5f            	clrw	x
6952  116d bf6b          	ldw	_link_cnt,x
6953                     ; 1716      link=ON;
6955  116f 3555006d      	mov	_link,#85
6956                     ; 1718      if(flags_tu&0b10000000)
6958  1173 b66a          	ld	a,_flags_tu
6959  1175 a580          	bcp	a,#128
6960  1177 2716          	jreq	L7313
6961                     ; 1720      	if(!res_fl)
6963  1179 725d000b      	tnz	_res_fl
6964  117d 2626          	jrne	L3413
6965                     ; 1722      		res_fl=1;
6967  117f a601          	ld	a,#1
6968  1181 ae000b        	ldw	x,#_res_fl
6969  1184 cd0000        	call	c_eewrc
6971                     ; 1723      		bRES=1;
6973  1187 3501000c      	mov	_bRES,#1
6974                     ; 1724      		res_fl_cnt=0;
6976  118b 3f4b          	clr	_res_fl_cnt
6977  118d 2016          	jra	L3413
6978  118f               L7313:
6979                     ; 1729      	if(main_cnt>20)
6981  118f 9c            	rvf
6982  1190 ce0255        	ldw	x,_main_cnt
6983  1193 a30015        	cpw	x,#21
6984  1196 2f0d          	jrslt	L3413
6985                     ; 1731     			if(res_fl)
6987  1198 725d000b      	tnz	_res_fl
6988  119c 2707          	jreq	L3413
6989                     ; 1733      			res_fl=0;
6991  119e 4f            	clr	a
6992  119f ae000b        	ldw	x,#_res_fl
6993  11a2 cd0000        	call	c_eewrc
6995  11a5               L3413:
6996                     ; 1738       if(res_fl_)
6998  11a5 725d000a      	tnz	_res_fl_
6999  11a9 2603          	jrne	L661
7000  11ab cc1720        	jp	L5603
7001  11ae               L661:
7002                     ; 1740       	res_fl_=0;
7004  11ae 4f            	clr	a
7005  11af ae000a        	ldw	x,#_res_fl_
7006  11b2 cd0000        	call	c_eewrc
7008  11b5 ac201720      	jpf	L5603
7009  11b9               L1213:
7010                     ; 1743 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7012  11b9 b6cd          	ld	a,_mess+6
7013  11bb c100f7        	cp	a,_adress
7014  11be 2703          	jreq	L071
7015  11c0 cc1436        	jp	L5513
7016  11c3               L071:
7018  11c3 b6ce          	ld	a,_mess+7
7019  11c5 c100f7        	cp	a,_adress
7020  11c8 2703          	jreq	L271
7021  11ca cc1436        	jp	L5513
7022  11cd               L271:
7024  11cd b6cf          	ld	a,_mess+8
7025  11cf a1ee          	cp	a,#238
7026  11d1 2703          	jreq	L471
7027  11d3 cc1436        	jp	L5513
7028  11d6               L471:
7030  11d6 b6d0          	ld	a,_mess+9
7031  11d8 b1d1          	cp	a,_mess+10
7032  11da 2703          	jreq	L671
7033  11dc cc1436        	jp	L5513
7034  11df               L671:
7035                     ; 1745 	rotor_int++;
7037  11df be17          	ldw	x,_rotor_int
7038  11e1 1c0001        	addw	x,#1
7039  11e4 bf17          	ldw	_rotor_int,x
7040                     ; 1746 	if((mess[9]&0xf0)==0x20)
7042  11e6 b6d0          	ld	a,_mess+9
7043  11e8 a4f0          	and	a,#240
7044  11ea a120          	cp	a,#32
7045  11ec 2673          	jrne	L7513
7046                     ; 1748 		if((mess[9]&0x0f)==0x01)
7048  11ee b6d0          	ld	a,_mess+9
7049  11f0 a40f          	and	a,#15
7050  11f2 a101          	cp	a,#1
7051  11f4 260d          	jrne	L1613
7052                     ; 1750 			ee_K[0][0]=adc_buff_[4];
7054  11f6 ce0107        	ldw	x,_adc_buff_+8
7055  11f9 89            	pushw	x
7056  11fa ae001a        	ldw	x,#_ee_K
7057  11fd cd0000        	call	c_eewrw
7059  1200 85            	popw	x
7061  1201 204a          	jra	L3613
7062  1203               L1613:
7063                     ; 1752 		else if((mess[9]&0x0f)==0x02)
7065  1203 b6d0          	ld	a,_mess+9
7066  1205 a40f          	and	a,#15
7067  1207 a102          	cp	a,#2
7068  1209 260b          	jrne	L5613
7069                     ; 1754 			ee_K[0][1]++;
7071  120b ce001c        	ldw	x,_ee_K+2
7072  120e 1c0001        	addw	x,#1
7073  1211 cf001c        	ldw	_ee_K+2,x
7075  1214 2037          	jra	L3613
7076  1216               L5613:
7077                     ; 1756 		else if((mess[9]&0x0f)==0x03)
7079  1216 b6d0          	ld	a,_mess+9
7080  1218 a40f          	and	a,#15
7081  121a a103          	cp	a,#3
7082  121c 260b          	jrne	L1713
7083                     ; 1758 			ee_K[0][1]+=10;
7085  121e ce001c        	ldw	x,_ee_K+2
7086  1221 1c000a        	addw	x,#10
7087  1224 cf001c        	ldw	_ee_K+2,x
7089  1227 2024          	jra	L3613
7090  1229               L1713:
7091                     ; 1760 		else if((mess[9]&0x0f)==0x04)
7093  1229 b6d0          	ld	a,_mess+9
7094  122b a40f          	and	a,#15
7095  122d a104          	cp	a,#4
7096  122f 260b          	jrne	L5713
7097                     ; 1762 			ee_K[0][1]--;
7099  1231 ce001c        	ldw	x,_ee_K+2
7100  1234 1d0001        	subw	x,#1
7101  1237 cf001c        	ldw	_ee_K+2,x
7103  123a 2011          	jra	L3613
7104  123c               L5713:
7105                     ; 1764 		else if((mess[9]&0x0f)==0x05)
7107  123c b6d0          	ld	a,_mess+9
7108  123e a40f          	and	a,#15
7109  1240 a105          	cp	a,#5
7110  1242 2609          	jrne	L3613
7111                     ; 1766 			ee_K[0][1]-=10;
7113  1244 ce001c        	ldw	x,_ee_K+2
7114  1247 1d000a        	subw	x,#10
7115  124a cf001c        	ldw	_ee_K+2,x
7116  124d               L3613:
7117                     ; 1768 		granee(&ee_K[0][1],50,3000);									
7119  124d ae0bb8        	ldw	x,#3000
7120  1250 89            	pushw	x
7121  1251 ae0032        	ldw	x,#50
7122  1254 89            	pushw	x
7123  1255 ae001c        	ldw	x,#_ee_K+2
7124  1258 cd00f6        	call	_granee
7126  125b 5b04          	addw	sp,#4
7128  125d ac1b141b      	jpf	L3023
7129  1261               L7513:
7130                     ; 1770 	else if((mess[9]&0xf0)==0x10)
7132  1261 b6d0          	ld	a,_mess+9
7133  1263 a4f0          	and	a,#240
7134  1265 a110          	cp	a,#16
7135  1267 2673          	jrne	L5023
7136                     ; 1772 		if((mess[9]&0x0f)==0x01)
7138  1269 b6d0          	ld	a,_mess+9
7139  126b a40f          	and	a,#15
7140  126d a101          	cp	a,#1
7141  126f 260d          	jrne	L7023
7142                     ; 1774 			ee_K[1][0]=adc_buff_[1];
7144  1271 ce0101        	ldw	x,_adc_buff_+2
7145  1274 89            	pushw	x
7146  1275 ae001e        	ldw	x,#_ee_K+4
7147  1278 cd0000        	call	c_eewrw
7149  127b 85            	popw	x
7151  127c 204a          	jra	L1123
7152  127e               L7023:
7153                     ; 1776 		else if((mess[9]&0x0f)==0x02)
7155  127e b6d0          	ld	a,_mess+9
7156  1280 a40f          	and	a,#15
7157  1282 a102          	cp	a,#2
7158  1284 260b          	jrne	L3123
7159                     ; 1778 			ee_K[1][1]++;
7161  1286 ce0020        	ldw	x,_ee_K+6
7162  1289 1c0001        	addw	x,#1
7163  128c cf0020        	ldw	_ee_K+6,x
7165  128f 2037          	jra	L1123
7166  1291               L3123:
7167                     ; 1780 		else if((mess[9]&0x0f)==0x03)
7169  1291 b6d0          	ld	a,_mess+9
7170  1293 a40f          	and	a,#15
7171  1295 a103          	cp	a,#3
7172  1297 260b          	jrne	L7123
7173                     ; 1782 			ee_K[1][1]+=10;
7175  1299 ce0020        	ldw	x,_ee_K+6
7176  129c 1c000a        	addw	x,#10
7177  129f cf0020        	ldw	_ee_K+6,x
7179  12a2 2024          	jra	L1123
7180  12a4               L7123:
7181                     ; 1784 		else if((mess[9]&0x0f)==0x04)
7183  12a4 b6d0          	ld	a,_mess+9
7184  12a6 a40f          	and	a,#15
7185  12a8 a104          	cp	a,#4
7186  12aa 260b          	jrne	L3223
7187                     ; 1786 			ee_K[1][1]--;
7189  12ac ce0020        	ldw	x,_ee_K+6
7190  12af 1d0001        	subw	x,#1
7191  12b2 cf0020        	ldw	_ee_K+6,x
7193  12b5 2011          	jra	L1123
7194  12b7               L3223:
7195                     ; 1788 		else if((mess[9]&0x0f)==0x05)
7197  12b7 b6d0          	ld	a,_mess+9
7198  12b9 a40f          	and	a,#15
7199  12bb a105          	cp	a,#5
7200  12bd 2609          	jrne	L1123
7201                     ; 1790 			ee_K[1][1]-=10;
7203  12bf ce0020        	ldw	x,_ee_K+6
7204  12c2 1d000a        	subw	x,#10
7205  12c5 cf0020        	ldw	_ee_K+6,x
7206  12c8               L1123:
7207                     ; 1795 		granee(&ee_K[1][1],10,30000);
7209  12c8 ae7530        	ldw	x,#30000
7210  12cb 89            	pushw	x
7211  12cc ae000a        	ldw	x,#10
7212  12cf 89            	pushw	x
7213  12d0 ae0020        	ldw	x,#_ee_K+6
7214  12d3 cd00f6        	call	_granee
7216  12d6 5b04          	addw	sp,#4
7218  12d8 ac1b141b      	jpf	L3023
7219  12dc               L5023:
7220                     ; 1799 	else if((mess[9]&0xf0)==0x00)
7222  12dc b6d0          	ld	a,_mess+9
7223  12de a5f0          	bcp	a,#240
7224  12e0 2673          	jrne	L3323
7225                     ; 1801 		if((mess[9]&0x0f)==0x01)
7227  12e2 b6d0          	ld	a,_mess+9
7228  12e4 a40f          	and	a,#15
7229  12e6 a101          	cp	a,#1
7230  12e8 260d          	jrne	L5323
7231                     ; 1803 			ee_K[2][0]=adc_buff_[2];
7233  12ea ce0103        	ldw	x,_adc_buff_+4
7234  12ed 89            	pushw	x
7235  12ee ae0022        	ldw	x,#_ee_K+8
7236  12f1 cd0000        	call	c_eewrw
7238  12f4 85            	popw	x
7240  12f5 204a          	jra	L7323
7241  12f7               L5323:
7242                     ; 1805 		else if((mess[9]&0x0f)==0x02)
7244  12f7 b6d0          	ld	a,_mess+9
7245  12f9 a40f          	and	a,#15
7246  12fb a102          	cp	a,#2
7247  12fd 260b          	jrne	L1423
7248                     ; 1807 			ee_K[2][1]++;
7250  12ff ce0024        	ldw	x,_ee_K+10
7251  1302 1c0001        	addw	x,#1
7252  1305 cf0024        	ldw	_ee_K+10,x
7254  1308 2037          	jra	L7323
7255  130a               L1423:
7256                     ; 1809 		else if((mess[9]&0x0f)==0x03)
7258  130a b6d0          	ld	a,_mess+9
7259  130c a40f          	and	a,#15
7260  130e a103          	cp	a,#3
7261  1310 260b          	jrne	L5423
7262                     ; 1811 			ee_K[2][1]+=10;
7264  1312 ce0024        	ldw	x,_ee_K+10
7265  1315 1c000a        	addw	x,#10
7266  1318 cf0024        	ldw	_ee_K+10,x
7268  131b 2024          	jra	L7323
7269  131d               L5423:
7270                     ; 1813 		else if((mess[9]&0x0f)==0x04)
7272  131d b6d0          	ld	a,_mess+9
7273  131f a40f          	and	a,#15
7274  1321 a104          	cp	a,#4
7275  1323 260b          	jrne	L1523
7276                     ; 1815 			ee_K[2][1]--;
7278  1325 ce0024        	ldw	x,_ee_K+10
7279  1328 1d0001        	subw	x,#1
7280  132b cf0024        	ldw	_ee_K+10,x
7282  132e 2011          	jra	L7323
7283  1330               L1523:
7284                     ; 1817 		else if((mess[9]&0x0f)==0x05)
7286  1330 b6d0          	ld	a,_mess+9
7287  1332 a40f          	and	a,#15
7288  1334 a105          	cp	a,#5
7289  1336 2609          	jrne	L7323
7290                     ; 1819 			ee_K[2][1]-=10;
7292  1338 ce0024        	ldw	x,_ee_K+10
7293  133b 1d000a        	subw	x,#10
7294  133e cf0024        	ldw	_ee_K+10,x
7295  1341               L7323:
7296                     ; 1824 		granee(&ee_K[2][1],10,30000);
7298  1341 ae7530        	ldw	x,#30000
7299  1344 89            	pushw	x
7300  1345 ae000a        	ldw	x,#10
7301  1348 89            	pushw	x
7302  1349 ae0024        	ldw	x,#_ee_K+10
7303  134c cd00f6        	call	_granee
7305  134f 5b04          	addw	sp,#4
7307  1351 ac1b141b      	jpf	L3023
7308  1355               L3323:
7309                     ; 1828 	else if((mess[9]&0xf0)==0x30)
7311  1355 b6d0          	ld	a,_mess+9
7312  1357 a4f0          	and	a,#240
7313  1359 a130          	cp	a,#48
7314  135b 265c          	jrne	L1623
7315                     ; 1830 		if((mess[9]&0x0f)==0x02)
7317  135d b6d0          	ld	a,_mess+9
7318  135f a40f          	and	a,#15
7319  1361 a102          	cp	a,#2
7320  1363 260b          	jrne	L3623
7321                     ; 1832 			ee_K[3][1]++;
7323  1365 ce0028        	ldw	x,_ee_K+14
7324  1368 1c0001        	addw	x,#1
7325  136b cf0028        	ldw	_ee_K+14,x
7327  136e 2037          	jra	L5623
7328  1370               L3623:
7329                     ; 1834 		else if((mess[9]&0x0f)==0x03)
7331  1370 b6d0          	ld	a,_mess+9
7332  1372 a40f          	and	a,#15
7333  1374 a103          	cp	a,#3
7334  1376 260b          	jrne	L7623
7335                     ; 1836 			ee_K[3][1]+=10;
7337  1378 ce0028        	ldw	x,_ee_K+14
7338  137b 1c000a        	addw	x,#10
7339  137e cf0028        	ldw	_ee_K+14,x
7341  1381 2024          	jra	L5623
7342  1383               L7623:
7343                     ; 1838 		else if((mess[9]&0x0f)==0x04)
7345  1383 b6d0          	ld	a,_mess+9
7346  1385 a40f          	and	a,#15
7347  1387 a104          	cp	a,#4
7348  1389 260b          	jrne	L3723
7349                     ; 1840 			ee_K[3][1]--;
7351  138b ce0028        	ldw	x,_ee_K+14
7352  138e 1d0001        	subw	x,#1
7353  1391 cf0028        	ldw	_ee_K+14,x
7355  1394 2011          	jra	L5623
7356  1396               L3723:
7357                     ; 1842 		else if((mess[9]&0x0f)==0x05)
7359  1396 b6d0          	ld	a,_mess+9
7360  1398 a40f          	and	a,#15
7361  139a a105          	cp	a,#5
7362  139c 2609          	jrne	L5623
7363                     ; 1844 			ee_K[3][1]-=10;
7365  139e ce0028        	ldw	x,_ee_K+14
7366  13a1 1d000a        	subw	x,#10
7367  13a4 cf0028        	ldw	_ee_K+14,x
7368  13a7               L5623:
7369                     ; 1846 		granee(&ee_K[3][1],300,517);									
7371  13a7 ae0205        	ldw	x,#517
7372  13aa 89            	pushw	x
7373  13ab ae012c        	ldw	x,#300
7374  13ae 89            	pushw	x
7375  13af ae0028        	ldw	x,#_ee_K+14
7376  13b2 cd00f6        	call	_granee
7378  13b5 5b04          	addw	sp,#4
7380  13b7 2062          	jra	L3023
7381  13b9               L1623:
7382                     ; 1849 	else if((mess[9]&0xf0)==0x50)
7384  13b9 b6d0          	ld	a,_mess+9
7385  13bb a4f0          	and	a,#240
7386  13bd a150          	cp	a,#80
7387  13bf 265a          	jrne	L3023
7388                     ; 1851 		if((mess[9]&0x0f)==0x02)
7390  13c1 b6d0          	ld	a,_mess+9
7391  13c3 a40f          	and	a,#15
7392  13c5 a102          	cp	a,#2
7393  13c7 260b          	jrne	L5033
7394                     ; 1853 			ee_K[4][1]++;
7396  13c9 ce002c        	ldw	x,_ee_K+18
7397  13cc 1c0001        	addw	x,#1
7398  13cf cf002c        	ldw	_ee_K+18,x
7400  13d2 2037          	jra	L7033
7401  13d4               L5033:
7402                     ; 1855 		else if((mess[9]&0x0f)==0x03)
7404  13d4 b6d0          	ld	a,_mess+9
7405  13d6 a40f          	and	a,#15
7406  13d8 a103          	cp	a,#3
7407  13da 260b          	jrne	L1133
7408                     ; 1857 			ee_K[4][1]+=10;
7410  13dc ce002c        	ldw	x,_ee_K+18
7411  13df 1c000a        	addw	x,#10
7412  13e2 cf002c        	ldw	_ee_K+18,x
7414  13e5 2024          	jra	L7033
7415  13e7               L1133:
7416                     ; 1859 		else if((mess[9]&0x0f)==0x04)
7418  13e7 b6d0          	ld	a,_mess+9
7419  13e9 a40f          	and	a,#15
7420  13eb a104          	cp	a,#4
7421  13ed 260b          	jrne	L5133
7422                     ; 1861 			ee_K[4][1]--;
7424  13ef ce002c        	ldw	x,_ee_K+18
7425  13f2 1d0001        	subw	x,#1
7426  13f5 cf002c        	ldw	_ee_K+18,x
7428  13f8 2011          	jra	L7033
7429  13fa               L5133:
7430                     ; 1863 		else if((mess[9]&0x0f)==0x05)
7432  13fa b6d0          	ld	a,_mess+9
7433  13fc a40f          	and	a,#15
7434  13fe a105          	cp	a,#5
7435  1400 2609          	jrne	L7033
7436                     ; 1865 			ee_K[4][1]-=10;
7438  1402 ce002c        	ldw	x,_ee_K+18
7439  1405 1d000a        	subw	x,#10
7440  1408 cf002c        	ldw	_ee_K+18,x
7441  140b               L7033:
7442                     ; 1867 		granee(&ee_K[4][1],10,30000);									
7444  140b ae7530        	ldw	x,#30000
7445  140e 89            	pushw	x
7446  140f ae000a        	ldw	x,#10
7447  1412 89            	pushw	x
7448  1413 ae002c        	ldw	x,#_ee_K+18
7449  1416 cd00f6        	call	_granee
7451  1419 5b04          	addw	sp,#4
7452  141b               L3023:
7453                     ; 1870 	link_cnt=0;
7455  141b 5f            	clrw	x
7456  141c bf6b          	ldw	_link_cnt,x
7457                     ; 1871      link=ON;
7459  141e 3555006d      	mov	_link,#85
7460                     ; 1872      if(res_fl_)
7462  1422 725d000a      	tnz	_res_fl_
7463  1426 2603          	jrne	L002
7464  1428 cc1720        	jp	L5603
7465  142b               L002:
7466                     ; 1874       	res_fl_=0;
7468  142b 4f            	clr	a
7469  142c ae000a        	ldw	x,#_res_fl_
7470  142f cd0000        	call	c_eewrc
7472  1432 ac201720      	jpf	L5603
7473  1436               L5513:
7474                     ; 1880 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7476  1436 b6cd          	ld	a,_mess+6
7477  1438 a1ff          	cp	a,#255
7478  143a 2703          	jreq	L202
7479  143c cc14ca        	jp	L7233
7480  143f               L202:
7482  143f b6ce          	ld	a,_mess+7
7483  1441 a1ff          	cp	a,#255
7484  1443 2703          	jreq	L402
7485  1445 cc14ca        	jp	L7233
7486  1448               L402:
7488  1448 b6cf          	ld	a,_mess+8
7489  144a a162          	cp	a,#98
7490  144c 267c          	jrne	L7233
7491                     ; 1883 	tempSS=mess[9]+(mess[10]*256);
7493  144e b6d1          	ld	a,_mess+10
7494  1450 5f            	clrw	x
7495  1451 97            	ld	xl,a
7496  1452 4f            	clr	a
7497  1453 02            	rlwa	x,a
7498  1454 01            	rrwa	x,a
7499  1455 bbd0          	add	a,_mess+9
7500  1457 2401          	jrnc	L251
7501  1459 5c            	incw	x
7502  145a               L251:
7503  145a 02            	rlwa	x,a
7504  145b 1f03          	ldw	(OFST-4,sp),x
7505  145d 01            	rrwa	x,a
7506                     ; 1884 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7508  145e ce0014        	ldw	x,_ee_Umax
7509  1461 1303          	cpw	x,(OFST-4,sp)
7510  1463 270a          	jreq	L1333
7513  1465 1e03          	ldw	x,(OFST-4,sp)
7514  1467 89            	pushw	x
7515  1468 ae0014        	ldw	x,#_ee_Umax
7516  146b cd0000        	call	c_eewrw
7518  146e 85            	popw	x
7519  146f               L1333:
7520                     ; 1885 	tempSS=mess[11]+(mess[12]*256);
7522  146f b6d3          	ld	a,_mess+12
7523  1471 5f            	clrw	x
7524  1472 97            	ld	xl,a
7525  1473 4f            	clr	a
7526  1474 02            	rlwa	x,a
7527  1475 01            	rrwa	x,a
7528  1476 bbd2          	add	a,_mess+11
7529  1478 2401          	jrnc	L451
7530  147a 5c            	incw	x
7531  147b               L451:
7532  147b 02            	rlwa	x,a
7533  147c 1f03          	ldw	(OFST-4,sp),x
7534  147e 01            	rrwa	x,a
7535                     ; 1886 	if(ee_dU!=tempSS) ee_dU=tempSS;
7537  147f ce0012        	ldw	x,_ee_dU
7538  1482 1303          	cpw	x,(OFST-4,sp)
7539  1484 270a          	jreq	L3333
7542  1486 1e03          	ldw	x,(OFST-4,sp)
7543  1488 89            	pushw	x
7544  1489 ae0012        	ldw	x,#_ee_dU
7545  148c cd0000        	call	c_eewrw
7547  148f 85            	popw	x
7548  1490               L3333:
7549                     ; 1887 	if((mess[13]&0x0f)==0x5)
7551  1490 b6d4          	ld	a,_mess+13
7552  1492 a40f          	and	a,#15
7553  1494 a105          	cp	a,#5
7554  1496 261a          	jrne	L5333
7555                     ; 1889 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7557  1498 ce0006        	ldw	x,_ee_AVT_MODE
7558  149b a30055        	cpw	x,#85
7559  149e 2603          	jrne	L602
7560  14a0 cc1720        	jp	L5603
7561  14a3               L602:
7564  14a3 ae0055        	ldw	x,#85
7565  14a6 89            	pushw	x
7566  14a7 ae0006        	ldw	x,#_ee_AVT_MODE
7567  14aa cd0000        	call	c_eewrw
7569  14ad 85            	popw	x
7570  14ae ac201720      	jpf	L5603
7571  14b2               L5333:
7572                     ; 1891 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7574  14b2 ce0006        	ldw	x,_ee_AVT_MODE
7575  14b5 a30055        	cpw	x,#85
7576  14b8 2703          	jreq	L012
7577  14ba cc1720        	jp	L5603
7578  14bd               L012:
7581  14bd 5f            	clrw	x
7582  14be 89            	pushw	x
7583  14bf ae0006        	ldw	x,#_ee_AVT_MODE
7584  14c2 cd0000        	call	c_eewrw
7586  14c5 85            	popw	x
7587  14c6 ac201720      	jpf	L5603
7588  14ca               L7233:
7589                     ; 1894 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7591  14ca b6cd          	ld	a,_mess+6
7592  14cc a1ff          	cp	a,#255
7593  14ce 2703          	jreq	L212
7594  14d0 cc1586        	jp	L7433
7595  14d3               L212:
7597  14d3 b6ce          	ld	a,_mess+7
7598  14d5 a1ff          	cp	a,#255
7599  14d7 2703          	jreq	L412
7600  14d9 cc1586        	jp	L7433
7601  14dc               L412:
7603  14dc b6cf          	ld	a,_mess+8
7604  14de a126          	cp	a,#38
7605  14e0 2709          	jreq	L1533
7607  14e2 b6cf          	ld	a,_mess+8
7608  14e4 a129          	cp	a,#41
7609  14e6 2703          	jreq	L612
7610  14e8 cc1586        	jp	L7433
7611  14eb               L612:
7612  14eb               L1533:
7613                     ; 1897 	tempSS=mess[9]+(mess[10]*256);
7615  14eb b6d1          	ld	a,_mess+10
7616  14ed 5f            	clrw	x
7617  14ee 97            	ld	xl,a
7618  14ef 4f            	clr	a
7619  14f0 02            	rlwa	x,a
7620  14f1 01            	rrwa	x,a
7621  14f2 bbd0          	add	a,_mess+9
7622  14f4 2401          	jrnc	L651
7623  14f6 5c            	incw	x
7624  14f7               L651:
7625  14f7 02            	rlwa	x,a
7626  14f8 1f03          	ldw	(OFST-4,sp),x
7627  14fa 01            	rrwa	x,a
7628                     ; 1899 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7630  14fb ce000c        	ldw	x,_ee_UAVT
7631  14fe 1303          	cpw	x,(OFST-4,sp)
7632  1500 270a          	jreq	L3533
7635  1502 1e03          	ldw	x,(OFST-4,sp)
7636  1504 89            	pushw	x
7637  1505 ae000c        	ldw	x,#_ee_UAVT
7638  1508 cd0000        	call	c_eewrw
7640  150b 85            	popw	x
7641  150c               L3533:
7642                     ; 1900 	tempSS=(signed short)mess[11];
7644  150c b6d2          	ld	a,_mess+11
7645  150e 5f            	clrw	x
7646  150f 97            	ld	xl,a
7647  1510 1f03          	ldw	(OFST-4,sp),x
7648                     ; 1901 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7650  1512 ce0010        	ldw	x,_ee_tmax
7651  1515 1303          	cpw	x,(OFST-4,sp)
7652  1517 270a          	jreq	L5533
7655  1519 1e03          	ldw	x,(OFST-4,sp)
7656  151b 89            	pushw	x
7657  151c ae0010        	ldw	x,#_ee_tmax
7658  151f cd0000        	call	c_eewrw
7660  1522 85            	popw	x
7661  1523               L5533:
7662                     ; 1902 	tempSS=(signed short)mess[12];
7664  1523 b6d3          	ld	a,_mess+12
7665  1525 5f            	clrw	x
7666  1526 97            	ld	xl,a
7667  1527 1f03          	ldw	(OFST-4,sp),x
7668                     ; 1903 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7670  1529 ce000e        	ldw	x,_ee_tsign
7671  152c 1303          	cpw	x,(OFST-4,sp)
7672  152e 270a          	jreq	L7533
7675  1530 1e03          	ldw	x,(OFST-4,sp)
7676  1532 89            	pushw	x
7677  1533 ae000e        	ldw	x,#_ee_tsign
7678  1536 cd0000        	call	c_eewrw
7680  1539 85            	popw	x
7681  153a               L7533:
7682                     ; 1906 	if(mess[8]==MEM_KF1)
7684  153a b6cf          	ld	a,_mess+8
7685  153c a126          	cp	a,#38
7686  153e 260e          	jrne	L1633
7687                     ; 1908 		if(ee_DEVICE!=0)ee_DEVICE=0;
7689  1540 ce0004        	ldw	x,_ee_DEVICE
7690  1543 2709          	jreq	L1633
7693  1545 5f            	clrw	x
7694  1546 89            	pushw	x
7695  1547 ae0004        	ldw	x,#_ee_DEVICE
7696  154a cd0000        	call	c_eewrw
7698  154d 85            	popw	x
7699  154e               L1633:
7700                     ; 1911 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7702  154e b6cf          	ld	a,_mess+8
7703  1550 a129          	cp	a,#41
7704  1552 2703          	jreq	L022
7705  1554 cc1720        	jp	L5603
7706  1557               L022:
7707                     ; 1913 		if(ee_DEVICE!=1)ee_DEVICE=1;
7709  1557 ce0004        	ldw	x,_ee_DEVICE
7710  155a a30001        	cpw	x,#1
7711  155d 270b          	jreq	L7633
7714  155f ae0001        	ldw	x,#1
7715  1562 89            	pushw	x
7716  1563 ae0004        	ldw	x,#_ee_DEVICE
7717  1566 cd0000        	call	c_eewrw
7719  1569 85            	popw	x
7720  156a               L7633:
7721                     ; 1914 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7723  156a b6d4          	ld	a,_mess+13
7724  156c 5f            	clrw	x
7725  156d 97            	ld	xl,a
7726  156e c30002        	cpw	x,_ee_IMAXVENT
7727  1571 2603          	jrne	L222
7728  1573 cc1720        	jp	L5603
7729  1576               L222:
7732  1576 b6d4          	ld	a,_mess+13
7733  1578 5f            	clrw	x
7734  1579 97            	ld	xl,a
7735  157a 89            	pushw	x
7736  157b ae0002        	ldw	x,#_ee_IMAXVENT
7737  157e cd0000        	call	c_eewrw
7739  1581 85            	popw	x
7740  1582 ac201720      	jpf	L5603
7741  1586               L7433:
7742                     ; 1919 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7744  1586 b6cd          	ld	a,_mess+6
7745  1588 c100f7        	cp	a,_adress
7746  158b 262d          	jrne	L5733
7748  158d b6ce          	ld	a,_mess+7
7749  158f c100f7        	cp	a,_adress
7750  1592 2626          	jrne	L5733
7752  1594 b6cf          	ld	a,_mess+8
7753  1596 a116          	cp	a,#22
7754  1598 2620          	jrne	L5733
7756  159a b6d0          	ld	a,_mess+9
7757  159c a163          	cp	a,#99
7758  159e 261a          	jrne	L5733
7759                     ; 1921 	flags&=0b11100001;
7761  15a0 b605          	ld	a,_flags
7762  15a2 a4e1          	and	a,#225
7763  15a4 b705          	ld	_flags,a
7764                     ; 1922 	tsign_cnt=0;
7766  15a6 5f            	clrw	x
7767  15a7 bf59          	ldw	_tsign_cnt,x
7768                     ; 1923 	tmax_cnt=0;
7770  15a9 5f            	clrw	x
7771  15aa bf57          	ldw	_tmax_cnt,x
7772                     ; 1924 	umax_cnt=0;
7774  15ac 5f            	clrw	x
7775  15ad bf70          	ldw	_umax_cnt,x
7776                     ; 1925 	umin_cnt=0;
7778  15af 5f            	clrw	x
7779  15b0 bf6e          	ldw	_umin_cnt,x
7780                     ; 1926 	led_drv_cnt=30;
7782  15b2 351e0016      	mov	_led_drv_cnt,#30
7784  15b6 ac201720      	jpf	L5603
7785  15ba               L5733:
7786                     ; 1929 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7788  15ba b6cd          	ld	a,_mess+6
7789  15bc c100f7        	cp	a,_adress
7790  15bf 2620          	jrne	L1043
7792  15c1 b6ce          	ld	a,_mess+7
7793  15c3 c100f7        	cp	a,_adress
7794  15c6 2619          	jrne	L1043
7796  15c8 b6cf          	ld	a,_mess+8
7797  15ca a116          	cp	a,#22
7798  15cc 2613          	jrne	L1043
7800  15ce b6d0          	ld	a,_mess+9
7801  15d0 a164          	cp	a,#100
7802  15d2 260d          	jrne	L1043
7803                     ; 1931 	vent_resurs=0;
7805  15d4 5f            	clrw	x
7806  15d5 89            	pushw	x
7807  15d6 ae0000        	ldw	x,#_vent_resurs
7808  15d9 cd0000        	call	c_eewrw
7810  15dc 85            	popw	x
7812  15dd ac201720      	jpf	L5603
7813  15e1               L1043:
7814                     ; 1935 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7816  15e1 b6cd          	ld	a,_mess+6
7817  15e3 a1ff          	cp	a,#255
7818  15e5 265f          	jrne	L5043
7820  15e7 b6ce          	ld	a,_mess+7
7821  15e9 a1ff          	cp	a,#255
7822  15eb 2659          	jrne	L5043
7824  15ed b6cf          	ld	a,_mess+8
7825  15ef a116          	cp	a,#22
7826  15f1 2653          	jrne	L5043
7828  15f3 b6d0          	ld	a,_mess+9
7829  15f5 a116          	cp	a,#22
7830  15f7 264d          	jrne	L5043
7831                     ; 1937 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7833  15f9 b6d1          	ld	a,_mess+10
7834  15fb a155          	cp	a,#85
7835  15fd 260f          	jrne	L7043
7837  15ff b6d2          	ld	a,_mess+11
7838  1601 a155          	cp	a,#85
7839  1603 2609          	jrne	L7043
7842  1605 be68          	ldw	x,__x_
7843  1607 1c0001        	addw	x,#1
7844  160a bf68          	ldw	__x_,x
7846  160c 2024          	jra	L1143
7847  160e               L7043:
7848                     ; 1938 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7850  160e b6d1          	ld	a,_mess+10
7851  1610 a166          	cp	a,#102
7852  1612 260f          	jrne	L3143
7854  1614 b6d2          	ld	a,_mess+11
7855  1616 a166          	cp	a,#102
7856  1618 2609          	jrne	L3143
7859  161a be68          	ldw	x,__x_
7860  161c 1d0001        	subw	x,#1
7861  161f bf68          	ldw	__x_,x
7863  1621 200f          	jra	L1143
7864  1623               L3143:
7865                     ; 1939 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7867  1623 b6d1          	ld	a,_mess+10
7868  1625 a177          	cp	a,#119
7869  1627 2609          	jrne	L1143
7871  1629 b6d2          	ld	a,_mess+11
7872  162b a177          	cp	a,#119
7873  162d 2603          	jrne	L1143
7876  162f 5f            	clrw	x
7877  1630 bf68          	ldw	__x_,x
7878  1632               L1143:
7879                     ; 1940      gran(&_x_,-XMAX,XMAX);
7881  1632 ae0019        	ldw	x,#25
7882  1635 89            	pushw	x
7883  1636 aeffe7        	ldw	x,#65511
7884  1639 89            	pushw	x
7885  163a ae0068        	ldw	x,#__x_
7886  163d cd00d5        	call	_gran
7888  1640 5b04          	addw	sp,#4
7890  1642 ac201720      	jpf	L5603
7891  1646               L5043:
7892                     ; 1942 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7894  1646 b6cd          	ld	a,_mess+6
7895  1648 c100f7        	cp	a,_adress
7896  164b 2635          	jrne	L3243
7898  164d b6ce          	ld	a,_mess+7
7899  164f c100f7        	cp	a,_adress
7900  1652 262e          	jrne	L3243
7902  1654 b6cf          	ld	a,_mess+8
7903  1656 a116          	cp	a,#22
7904  1658 2628          	jrne	L3243
7906  165a b6d0          	ld	a,_mess+9
7907  165c b1d1          	cp	a,_mess+10
7908  165e 2622          	jrne	L3243
7910  1660 b6d0          	ld	a,_mess+9
7911  1662 a1ee          	cp	a,#238
7912  1664 261c          	jrne	L3243
7913                     ; 1944 	rotor_int++;
7915  1666 be17          	ldw	x,_rotor_int
7916  1668 1c0001        	addw	x,#1
7917  166b bf17          	ldw	_rotor_int,x
7918                     ; 1945      tempI=pwm_u;
7920                     ; 1947 	UU_AVT=Un;
7922  166d ce000e        	ldw	x,_Un
7923  1670 89            	pushw	x
7924  1671 ae0008        	ldw	x,#_UU_AVT
7925  1674 cd0000        	call	c_eewrw
7927  1677 85            	popw	x
7928                     ; 1948 	delay_ms(100);
7930  1678 ae0064        	ldw	x,#100
7931  167b cd0121        	call	_delay_ms
7934  167e ac201720      	jpf	L5603
7935  1682               L3243:
7936                     ; 1954 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7938  1682 b6ce          	ld	a,_mess+7
7939  1684 a1da          	cp	a,#218
7940  1686 2653          	jrne	L7243
7942  1688 b6cd          	ld	a,_mess+6
7943  168a c100f7        	cp	a,_adress
7944  168d 274c          	jreq	L7243
7946  168f b6cd          	ld	a,_mess+6
7947  1691 a106          	cp	a,#6
7948  1693 2446          	jruge	L7243
7949                     ; 1956 	i_main_bps_cnt[mess[6]]=0;
7951  1695 b6cd          	ld	a,_mess+6
7952  1697 5f            	clrw	x
7953  1698 97            	ld	xl,a
7954  1699 6f13          	clr	(_i_main_bps_cnt,x)
7955                     ; 1957 	i_main_flag[mess[6]]=1;
7957  169b b6cd          	ld	a,_mess+6
7958  169d 5f            	clrw	x
7959  169e 97            	ld	xl,a
7960  169f a601          	ld	a,#1
7961  16a1 e71e          	ld	(_i_main_flag,x),a
7962                     ; 1958 	if(bMAIN)
7964                     	btst	_bMAIN
7965  16a8 2476          	jruge	L5603
7966                     ; 1960 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7968  16aa b6d0          	ld	a,_mess+9
7969  16ac 5f            	clrw	x
7970  16ad 97            	ld	xl,a
7971  16ae 4f            	clr	a
7972  16af 02            	rlwa	x,a
7973  16b0 1f01          	ldw	(OFST-6,sp),x
7974  16b2 b6cf          	ld	a,_mess+8
7975  16b4 5f            	clrw	x
7976  16b5 97            	ld	xl,a
7977  16b6 72fb01        	addw	x,(OFST-6,sp)
7978  16b9 b6cd          	ld	a,_mess+6
7979  16bb 905f          	clrw	y
7980  16bd 9097          	ld	yl,a
7981  16bf 9058          	sllw	y
7982  16c1 90ef24        	ldw	(_i_main,y),x
7983                     ; 1961 		i_main[adress]=I;
7985  16c4 c600f7        	ld	a,_adress
7986  16c7 5f            	clrw	x
7987  16c8 97            	ld	xl,a
7988  16c9 58            	sllw	x
7989  16ca 90ce0010      	ldw	y,_I
7990  16ce ef24          	ldw	(_i_main,x),y
7991                     ; 1962      	i_main_flag[adress]=1;
7993  16d0 c600f7        	ld	a,_adress
7994  16d3 5f            	clrw	x
7995  16d4 97            	ld	xl,a
7996  16d5 a601          	ld	a,#1
7997  16d7 e71e          	ld	(_i_main_flag,x),a
7998  16d9 2045          	jra	L5603
7999  16db               L7243:
8000                     ; 1966 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8002  16db b6ce          	ld	a,_mess+7
8003  16dd a1db          	cp	a,#219
8004  16df 263f          	jrne	L5603
8006  16e1 b6cd          	ld	a,_mess+6
8007  16e3 c100f7        	cp	a,_adress
8008  16e6 2738          	jreq	L5603
8010  16e8 b6cd          	ld	a,_mess+6
8011  16ea a106          	cp	a,#6
8012  16ec 2432          	jruge	L5603
8013                     ; 1968 	i_main_bps_cnt[mess[6]]=0;
8015  16ee b6cd          	ld	a,_mess+6
8016  16f0 5f            	clrw	x
8017  16f1 97            	ld	xl,a
8018  16f2 6f13          	clr	(_i_main_bps_cnt,x)
8019                     ; 1969 	i_main_flag[mess[6]]=1;		
8021  16f4 b6cd          	ld	a,_mess+6
8022  16f6 5f            	clrw	x
8023  16f7 97            	ld	xl,a
8024  16f8 a601          	ld	a,#1
8025  16fa e71e          	ld	(_i_main_flag,x),a
8026                     ; 1970 	if(bMAIN)
8028                     	btst	_bMAIN
8029  1701 241d          	jruge	L5603
8030                     ; 1972 		if(mess[9]==0)i_main_flag[i]=1;
8032  1703 3dd0          	tnz	_mess+9
8033  1705 260a          	jrne	L1443
8036  1707 7b07          	ld	a,(OFST+0,sp)
8037  1709 5f            	clrw	x
8038  170a 97            	ld	xl,a
8039  170b a601          	ld	a,#1
8040  170d e71e          	ld	(_i_main_flag,x),a
8042  170f 2006          	jra	L3443
8043  1711               L1443:
8044                     ; 1973 		else i_main_flag[i]=0;
8046  1711 7b07          	ld	a,(OFST+0,sp)
8047  1713 5f            	clrw	x
8048  1714 97            	ld	xl,a
8049  1715 6f1e          	clr	(_i_main_flag,x)
8050  1717               L3443:
8051                     ; 1974 		i_main_flag[adress]=1;
8053  1717 c600f7        	ld	a,_adress
8054  171a 5f            	clrw	x
8055  171b 97            	ld	xl,a
8056  171c a601          	ld	a,#1
8057  171e e71e          	ld	(_i_main_flag,x),a
8058  1720               L5603:
8059                     ; 1980 can_in_an_end:
8059                     ; 1981 bCAN_RX=0;
8061  1720 3f04          	clr	_bCAN_RX
8062                     ; 1982 }   
8065  1722 5b07          	addw	sp,#7
8066  1724 81            	ret
8089                     ; 1985 void t4_init(void){
8090                     	switch	.text
8091  1725               _t4_init:
8095                     ; 1986 	TIM4->PSCR = 6;
8097  1725 35065345      	mov	21317,#6
8098                     ; 1987 	TIM4->ARR= 61;
8100  1729 353d5346      	mov	21318,#61
8101                     ; 1988 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8103  172d 72105341      	bset	21313,#0
8104                     ; 1990 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8106  1731 35855340      	mov	21312,#133
8107                     ; 1992 }
8110  1735 81            	ret
8133                     ; 1995 void t1_init(void)
8133                     ; 1996 {
8134                     	switch	.text
8135  1736               _t1_init:
8139                     ; 1997 TIM1->ARRH= 0x07;
8141  1736 35075262      	mov	21090,#7
8142                     ; 1998 TIM1->ARRL= 0xff;
8144  173a 35ff5263      	mov	21091,#255
8145                     ; 1999 TIM1->CCR1H= 0x00;	
8147  173e 725f5265      	clr	21093
8148                     ; 2000 TIM1->CCR1L= 0xff;
8150  1742 35ff5266      	mov	21094,#255
8151                     ; 2001 TIM1->CCR2H= 0x00;	
8153  1746 725f5267      	clr	21095
8154                     ; 2002 TIM1->CCR2L= 0x00;
8156  174a 725f5268      	clr	21096
8157                     ; 2003 TIM1->CCR3H= 0x00;	
8159  174e 725f5269      	clr	21097
8160                     ; 2004 TIM1->CCR3L= 0x64;
8162  1752 3564526a      	mov	21098,#100
8163                     ; 2006 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8165  1756 35685258      	mov	21080,#104
8166                     ; 2007 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8168  175a 35685259      	mov	21081,#104
8169                     ; 2008 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8171  175e 3568525a      	mov	21082,#104
8172                     ; 2009 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8174  1762 3511525c      	mov	21084,#17
8175                     ; 2010 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8177  1766 3501525d      	mov	21085,#1
8178                     ; 2011 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8180  176a 35815250      	mov	21072,#129
8181                     ; 2012 TIM1->BKR|= TIM1_BKR_AOE;
8183  176e 721c526d      	bset	21101,#6
8184                     ; 2013 }
8187  1772 81            	ret
8212                     ; 2017 void adc2_init(void)
8212                     ; 2018 {
8213                     	switch	.text
8214  1773               _adc2_init:
8218                     ; 2019 adc_plazma[0]++;
8220  1773 beb9          	ldw	x,_adc_plazma
8221  1775 1c0001        	addw	x,#1
8222  1778 bfb9          	ldw	_adc_plazma,x
8223                     ; 2043 GPIOB->DDR&=~(1<<4);
8225  177a 72195007      	bres	20487,#4
8226                     ; 2044 GPIOB->CR1&=~(1<<4);
8228  177e 72195008      	bres	20488,#4
8229                     ; 2045 GPIOB->CR2&=~(1<<4);
8231  1782 72195009      	bres	20489,#4
8232                     ; 2047 GPIOB->DDR&=~(1<<5);
8234  1786 721b5007      	bres	20487,#5
8235                     ; 2048 GPIOB->CR1&=~(1<<5);
8237  178a 721b5008      	bres	20488,#5
8238                     ; 2049 GPIOB->CR2&=~(1<<5);
8240  178e 721b5009      	bres	20489,#5
8241                     ; 2051 GPIOB->DDR&=~(1<<6);
8243  1792 721d5007      	bres	20487,#6
8244                     ; 2052 GPIOB->CR1&=~(1<<6);
8246  1796 721d5008      	bres	20488,#6
8247                     ; 2053 GPIOB->CR2&=~(1<<6);
8249  179a 721d5009      	bres	20489,#6
8250                     ; 2055 GPIOB->DDR&=~(1<<7);
8252  179e 721f5007      	bres	20487,#7
8253                     ; 2056 GPIOB->CR1&=~(1<<7);
8255  17a2 721f5008      	bres	20488,#7
8256                     ; 2057 GPIOB->CR2&=~(1<<7);
8258  17a6 721f5009      	bres	20489,#7
8259                     ; 2059 GPIOB->DDR&=~(1<<2);
8261  17aa 72155007      	bres	20487,#2
8262                     ; 2060 GPIOB->CR1&=~(1<<2);
8264  17ae 72155008      	bres	20488,#2
8265                     ; 2061 GPIOB->CR2&=~(1<<2);
8267  17b2 72155009      	bres	20489,#2
8268                     ; 2070 ADC2->TDRL=0xff;
8270  17b6 35ff5407      	mov	21511,#255
8271                     ; 2072 ADC2->CR2=0x08;
8273  17ba 35085402      	mov	21506,#8
8274                     ; 2073 ADC2->CR1=0x60;
8276  17be 35605401      	mov	21505,#96
8277                     ; 2076 	if(adc_ch==5)ADC2->CSR=0x22;
8279  17c2 b6c6          	ld	a,_adc_ch
8280  17c4 a105          	cp	a,#5
8281  17c6 2606          	jrne	L5743
8284  17c8 35225400      	mov	21504,#34
8286  17cc 2007          	jra	L7743
8287  17ce               L5743:
8288                     ; 2077 	else ADC2->CSR=0x20+adc_ch+3;
8290  17ce b6c6          	ld	a,_adc_ch
8291  17d0 ab23          	add	a,#35
8292  17d2 c75400        	ld	21504,a
8293  17d5               L7743:
8294                     ; 2079 	ADC2->CR1|=1;
8296  17d5 72105401      	bset	21505,#0
8297                     ; 2080 	ADC2->CR1|=1;
8299  17d9 72105401      	bset	21505,#0
8300                     ; 2083 adc_plazma[1]=adc_ch;
8302  17dd b6c6          	ld	a,_adc_ch
8303  17df 5f            	clrw	x
8304  17e0 97            	ld	xl,a
8305  17e1 bfbb          	ldw	_adc_plazma+2,x
8306                     ; 2084 }
8309  17e3 81            	ret
8345                     ; 2092 @far @interrupt void TIM4_UPD_Interrupt (void) 
8345                     ; 2093 {
8347                     	switch	.text
8348  17e4               f_TIM4_UPD_Interrupt:
8352                     ; 2094 TIM4->SR1&=~TIM4_SR1_UIF;
8354  17e4 72115342      	bres	21314,#0
8355                     ; 2096 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8357  17e8 3c12          	inc	_pwm_vent_cnt
8358  17ea b612          	ld	a,_pwm_vent_cnt
8359  17ec a10a          	cp	a,#10
8360  17ee 2502          	jrult	L1153
8363  17f0 3f12          	clr	_pwm_vent_cnt
8364  17f2               L1153:
8365                     ; 2097 GPIOB->ODR|=(1<<3);
8367  17f2 72165005      	bset	20485,#3
8368                     ; 2098 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8370  17f6 b612          	ld	a,_pwm_vent_cnt
8371  17f8 a105          	cp	a,#5
8372  17fa 2504          	jrult	L3153
8375  17fc 72175005      	bres	20485,#3
8376  1800               L3153:
8377                     ; 2102 if(++t0_cnt00>=10)
8379  1800 9c            	rvf
8380  1801 ce0000        	ldw	x,_t0_cnt00
8381  1804 1c0001        	addw	x,#1
8382  1807 cf0000        	ldw	_t0_cnt00,x
8383  180a a3000a        	cpw	x,#10
8384  180d 2f08          	jrslt	L5153
8385                     ; 2104 	t0_cnt00=0;
8387  180f 5f            	clrw	x
8388  1810 cf0000        	ldw	_t0_cnt00,x
8389                     ; 2105 	b1000Hz=1;
8391  1813 72100004      	bset	_b1000Hz
8392  1817               L5153:
8393                     ; 2108 if(++t0_cnt0>=100)
8395  1817 9c            	rvf
8396  1818 ce0002        	ldw	x,_t0_cnt0
8397  181b 1c0001        	addw	x,#1
8398  181e cf0002        	ldw	_t0_cnt0,x
8399  1821 a30064        	cpw	x,#100
8400  1824 2f54          	jrslt	L7153
8401                     ; 2110 	t0_cnt0=0;
8403  1826 5f            	clrw	x
8404  1827 cf0002        	ldw	_t0_cnt0,x
8405                     ; 2111 	b100Hz=1;
8407  182a 72100009      	bset	_b100Hz
8408                     ; 2113 	if(++t0_cnt1>=10)
8410  182e 725c0004      	inc	_t0_cnt1
8411  1832 c60004        	ld	a,_t0_cnt1
8412  1835 a10a          	cp	a,#10
8413  1837 2508          	jrult	L1253
8414                     ; 2115 		t0_cnt1=0;
8416  1839 725f0004      	clr	_t0_cnt1
8417                     ; 2116 		b10Hz=1;
8419  183d 72100008      	bset	_b10Hz
8420  1841               L1253:
8421                     ; 2119 	if(++t0_cnt2>=20)
8423  1841 725c0005      	inc	_t0_cnt2
8424  1845 c60005        	ld	a,_t0_cnt2
8425  1848 a114          	cp	a,#20
8426  184a 2508          	jrult	L3253
8427                     ; 2121 		t0_cnt2=0;
8429  184c 725f0005      	clr	_t0_cnt2
8430                     ; 2122 		b5Hz=1;
8432  1850 72100007      	bset	_b5Hz
8433  1854               L3253:
8434                     ; 2126 	if(++t0_cnt4>=50)
8436  1854 725c0007      	inc	_t0_cnt4
8437  1858 c60007        	ld	a,_t0_cnt4
8438  185b a132          	cp	a,#50
8439  185d 2508          	jrult	L5253
8440                     ; 2128 		t0_cnt4=0;
8442  185f 725f0007      	clr	_t0_cnt4
8443                     ; 2129 		b2Hz=1;
8445  1863 72100006      	bset	_b2Hz
8446  1867               L5253:
8447                     ; 2132 	if(++t0_cnt3>=100)
8449  1867 725c0006      	inc	_t0_cnt3
8450  186b c60006        	ld	a,_t0_cnt3
8451  186e a164          	cp	a,#100
8452  1870 2508          	jrult	L7153
8453                     ; 2134 		t0_cnt3=0;
8455  1872 725f0006      	clr	_t0_cnt3
8456                     ; 2135 		b1Hz=1;
8458  1876 72100005      	bset	_b1Hz
8459  187a               L7153:
8460                     ; 2141 }
8463  187a 80            	iret
8488                     ; 2144 @far @interrupt void CAN_RX_Interrupt (void) 
8488                     ; 2145 {
8489                     	switch	.text
8490  187b               f_CAN_RX_Interrupt:
8494                     ; 2147 CAN->PSR= 7;									// page 7 - read messsage
8496  187b 35075427      	mov	21543,#7
8497                     ; 2149 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8499  187f ae000e        	ldw	x,#14
8500  1882               L632:
8501  1882 d65427        	ld	a,(21543,x)
8502  1885 e7c6          	ld	(_mess-1,x),a
8503  1887 5a            	decw	x
8504  1888 26f8          	jrne	L632
8505                     ; 2160 bCAN_RX=1;
8507  188a 35010004      	mov	_bCAN_RX,#1
8508                     ; 2161 CAN->RFR|=(1<<5);
8510  188e 721a5424      	bset	21540,#5
8511                     ; 2163 }
8514  1892 80            	iret
8537                     ; 2166 @far @interrupt void CAN_TX_Interrupt (void) 
8537                     ; 2167 {
8538                     	switch	.text
8539  1893               f_CAN_TX_Interrupt:
8543                     ; 2168 if((CAN->TSR)&(1<<0))
8545  1893 c65422        	ld	a,21538
8546  1896 a501          	bcp	a,#1
8547  1898 2708          	jreq	L1553
8548                     ; 2170 	bTX_FREE=1;	
8550  189a 35010003      	mov	_bTX_FREE,#1
8551                     ; 2172 	CAN->TSR|=(1<<0);
8553  189e 72105422      	bset	21538,#0
8554  18a2               L1553:
8555                     ; 2174 }
8558  18a2 80            	iret
8638                     ; 2177 @far @interrupt void ADC2_EOC_Interrupt (void) {
8639                     	switch	.text
8640  18a3               f_ADC2_EOC_Interrupt:
8642       0000000d      OFST:	set	13
8643  18a3 be00          	ldw	x,c_x
8644  18a5 89            	pushw	x
8645  18a6 be00          	ldw	x,c_y
8646  18a8 89            	pushw	x
8647  18a9 be02          	ldw	x,c_lreg+2
8648  18ab 89            	pushw	x
8649  18ac be00          	ldw	x,c_lreg
8650  18ae 89            	pushw	x
8651  18af 520d          	subw	sp,#13
8654                     ; 2182 adc_plazma[2]++;
8656  18b1 bebd          	ldw	x,_adc_plazma+4
8657  18b3 1c0001        	addw	x,#1
8658  18b6 bfbd          	ldw	_adc_plazma+4,x
8659                     ; 2189 ADC2->CSR&=~(1<<7);
8661  18b8 721f5400      	bres	21504,#7
8662                     ; 2191 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8664  18bc c65405        	ld	a,21509
8665  18bf b703          	ld	c_lreg+3,a
8666  18c1 3f02          	clr	c_lreg+2
8667  18c3 3f01          	clr	c_lreg+1
8668  18c5 3f00          	clr	c_lreg
8669  18c7 96            	ldw	x,sp
8670  18c8 1c0001        	addw	x,#OFST-12
8671  18cb cd0000        	call	c_rtol
8673  18ce c65404        	ld	a,21508
8674  18d1 5f            	clrw	x
8675  18d2 97            	ld	xl,a
8676  18d3 90ae0100      	ldw	y,#256
8677  18d7 cd0000        	call	c_umul
8679  18da 96            	ldw	x,sp
8680  18db 1c0001        	addw	x,#OFST-12
8681  18de cd0000        	call	c_ladd
8683  18e1 96            	ldw	x,sp
8684  18e2 1c000a        	addw	x,#OFST-3
8685  18e5 cd0000        	call	c_rtol
8687                     ; 2196 if(adr_drv_stat==1)
8689  18e8 b602          	ld	a,_adr_drv_stat
8690  18ea a101          	cp	a,#1
8691  18ec 260b          	jrne	L1163
8692                     ; 2198 	adr_drv_stat=2;
8694  18ee 35020002      	mov	_adr_drv_stat,#2
8695                     ; 2199 	adc_buff_[0]=temp_adc;
8697  18f2 1e0c          	ldw	x,(OFST-1,sp)
8698  18f4 cf00ff        	ldw	_adc_buff_,x
8700  18f7 2020          	jra	L3163
8701  18f9               L1163:
8702                     ; 2202 else if(adr_drv_stat==3)
8704  18f9 b602          	ld	a,_adr_drv_stat
8705  18fb a103          	cp	a,#3
8706  18fd 260b          	jrne	L5163
8707                     ; 2204 	adr_drv_stat=4;
8709  18ff 35040002      	mov	_adr_drv_stat,#4
8710                     ; 2205 	adc_buff_[1]=temp_adc;
8712  1903 1e0c          	ldw	x,(OFST-1,sp)
8713  1905 cf0101        	ldw	_adc_buff_+2,x
8715  1908 200f          	jra	L3163
8716  190a               L5163:
8717                     ; 2208 else if(adr_drv_stat==5)
8719  190a b602          	ld	a,_adr_drv_stat
8720  190c a105          	cp	a,#5
8721  190e 2609          	jrne	L3163
8722                     ; 2210 	adr_drv_stat=6;
8724  1910 35060002      	mov	_adr_drv_stat,#6
8725                     ; 2211 	adc_buff_[9]=temp_adc;
8727  1914 1e0c          	ldw	x,(OFST-1,sp)
8728  1916 cf0111        	ldw	_adc_buff_+18,x
8729  1919               L3163:
8730                     ; 2214 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8732  1919 b6b7          	ld	a,_adc_cnt_cnt
8733  191b 5f            	clrw	x
8734  191c 97            	ld	xl,a
8735  191d 58            	sllw	x
8736  191e 1f03          	ldw	(OFST-10,sp),x
8737  1920 b6c6          	ld	a,_adc_ch
8738  1922 97            	ld	xl,a
8739  1923 a610          	ld	a,#16
8740  1925 42            	mul	x,a
8741  1926 72fb03        	addw	x,(OFST-10,sp)
8742  1929 160c          	ldw	y,(OFST-1,sp)
8743  192b df0056        	ldw	(_adc_buff_buff,x),y
8744                     ; 2216 adc_ch++;
8746  192e 3cc6          	inc	_adc_ch
8747                     ; 2217 if(adc_ch>=6)
8749  1930 b6c6          	ld	a,_adc_ch
8750  1932 a106          	cp	a,#6
8751  1934 2516          	jrult	L3263
8752                     ; 2219 	adc_ch=0;
8754  1936 3fc6          	clr	_adc_ch
8755                     ; 2220 	adc_cnt_cnt++;
8757  1938 3cb7          	inc	_adc_cnt_cnt
8758                     ; 2221 	if(adc_cnt_cnt>=8)
8760  193a b6b7          	ld	a,_adc_cnt_cnt
8761  193c a108          	cp	a,#8
8762  193e 250c          	jrult	L3263
8763                     ; 2223 		adc_cnt_cnt=0;
8765  1940 3fb7          	clr	_adc_cnt_cnt
8766                     ; 2224 		adc_cnt++;
8768  1942 3cc5          	inc	_adc_cnt
8769                     ; 2225 		if(adc_cnt>=16)
8771  1944 b6c5          	ld	a,_adc_cnt
8772  1946 a110          	cp	a,#16
8773  1948 2502          	jrult	L3263
8774                     ; 2227 			adc_cnt=0;
8776  194a 3fc5          	clr	_adc_cnt
8777  194c               L3263:
8778                     ; 2231 if(adc_cnt_cnt==0)
8780  194c 3db7          	tnz	_adc_cnt_cnt
8781  194e 2660          	jrne	L1363
8782                     ; 2235 	tempSS=0;
8784  1950 ae0000        	ldw	x,#0
8785  1953 1f07          	ldw	(OFST-6,sp),x
8786  1955 ae0000        	ldw	x,#0
8787  1958 1f05          	ldw	(OFST-8,sp),x
8788                     ; 2236 	for(i=0;i<8;i++)
8790  195a 0f09          	clr	(OFST-4,sp)
8791  195c               L3363:
8792                     ; 2238 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8794  195c 7b09          	ld	a,(OFST-4,sp)
8795  195e 5f            	clrw	x
8796  195f 97            	ld	xl,a
8797  1960 58            	sllw	x
8798  1961 1f03          	ldw	(OFST-10,sp),x
8799  1963 b6c6          	ld	a,_adc_ch
8800  1965 97            	ld	xl,a
8801  1966 a610          	ld	a,#16
8802  1968 42            	mul	x,a
8803  1969 72fb03        	addw	x,(OFST-10,sp)
8804  196c de0056        	ldw	x,(_adc_buff_buff,x)
8805  196f cd0000        	call	c_itolx
8807  1972 96            	ldw	x,sp
8808  1973 1c0005        	addw	x,#OFST-8
8809  1976 cd0000        	call	c_lgadd
8811                     ; 2236 	for(i=0;i<8;i++)
8813  1979 0c09          	inc	(OFST-4,sp)
8816  197b 7b09          	ld	a,(OFST-4,sp)
8817  197d a108          	cp	a,#8
8818  197f 25db          	jrult	L3363
8819                     ; 2240 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8821  1981 96            	ldw	x,sp
8822  1982 1c0005        	addw	x,#OFST-8
8823  1985 cd0000        	call	c_ltor
8825  1988 a603          	ld	a,#3
8826  198a cd0000        	call	c_lrsh
8828  198d be02          	ldw	x,c_lreg+2
8829  198f b6c5          	ld	a,_adc_cnt
8830  1991 905f          	clrw	y
8831  1993 9097          	ld	yl,a
8832  1995 9058          	sllw	y
8833  1997 1703          	ldw	(OFST-10,sp),y
8834  1999 b6c6          	ld	a,_adc_ch
8835  199b 905f          	clrw	y
8836  199d 9097          	ld	yl,a
8837  199f 9058          	sllw	y
8838  19a1 9058          	sllw	y
8839  19a3 9058          	sllw	y
8840  19a5 9058          	sllw	y
8841  19a7 9058          	sllw	y
8842  19a9 72f903        	addw	y,(OFST-10,sp)
8843  19ac 90df0113      	ldw	(_adc_buff,y),x
8844  19b0               L1363:
8845                     ; 2244 if((adc_cnt&0x03)==0)
8847  19b0 b6c5          	ld	a,_adc_cnt
8848  19b2 a503          	bcp	a,#3
8849  19b4 264b          	jrne	L1463
8850                     ; 2248 	tempSS=0;
8852  19b6 ae0000        	ldw	x,#0
8853  19b9 1f07          	ldw	(OFST-6,sp),x
8854  19bb ae0000        	ldw	x,#0
8855  19be 1f05          	ldw	(OFST-8,sp),x
8856                     ; 2249 	for(i=0;i<16;i++)
8858  19c0 0f09          	clr	(OFST-4,sp)
8859  19c2               L3463:
8860                     ; 2251 		tempSS+=(signed long)adc_buff[adc_ch][i];
8862  19c2 7b09          	ld	a,(OFST-4,sp)
8863  19c4 5f            	clrw	x
8864  19c5 97            	ld	xl,a
8865  19c6 58            	sllw	x
8866  19c7 1f03          	ldw	(OFST-10,sp),x
8867  19c9 b6c6          	ld	a,_adc_ch
8868  19cb 97            	ld	xl,a
8869  19cc a620          	ld	a,#32
8870  19ce 42            	mul	x,a
8871  19cf 72fb03        	addw	x,(OFST-10,sp)
8872  19d2 de0113        	ldw	x,(_adc_buff,x)
8873  19d5 cd0000        	call	c_itolx
8875  19d8 96            	ldw	x,sp
8876  19d9 1c0005        	addw	x,#OFST-8
8877  19dc cd0000        	call	c_lgadd
8879                     ; 2249 	for(i=0;i<16;i++)
8881  19df 0c09          	inc	(OFST-4,sp)
8884  19e1 7b09          	ld	a,(OFST-4,sp)
8885  19e3 a110          	cp	a,#16
8886  19e5 25db          	jrult	L3463
8887                     ; 2253 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8889  19e7 96            	ldw	x,sp
8890  19e8 1c0005        	addw	x,#OFST-8
8891  19eb cd0000        	call	c_ltor
8893  19ee a604          	ld	a,#4
8894  19f0 cd0000        	call	c_lrsh
8896  19f3 be02          	ldw	x,c_lreg+2
8897  19f5 b6c6          	ld	a,_adc_ch
8898  19f7 905f          	clrw	y
8899  19f9 9097          	ld	yl,a
8900  19fb 9058          	sllw	y
8901  19fd 90df00ff      	ldw	(_adc_buff_,y),x
8902  1a01               L1463:
8903                     ; 2260 if(adc_ch==0)adc_buff_5=temp_adc;
8905  1a01 3dc6          	tnz	_adc_ch
8906  1a03 2605          	jrne	L1563
8909  1a05 1e0c          	ldw	x,(OFST-1,sp)
8910  1a07 cf00fd        	ldw	_adc_buff_5,x
8911  1a0a               L1563:
8912                     ; 2261 if(adc_ch==2)adc_buff_1=temp_adc;
8914  1a0a b6c6          	ld	a,_adc_ch
8915  1a0c a102          	cp	a,#2
8916  1a0e 2605          	jrne	L3563
8919  1a10 1e0c          	ldw	x,(OFST-1,sp)
8920  1a12 cf00fb        	ldw	_adc_buff_1,x
8921  1a15               L3563:
8922                     ; 2263 adc_plazma_short++;
8924  1a15 bec3          	ldw	x,_adc_plazma_short
8925  1a17 1c0001        	addw	x,#1
8926  1a1a bfc3          	ldw	_adc_plazma_short,x
8927                     ; 2265 }
8930  1a1c 5b0d          	addw	sp,#13
8931  1a1e 85            	popw	x
8932  1a1f bf00          	ldw	c_lreg,x
8933  1a21 85            	popw	x
8934  1a22 bf02          	ldw	c_lreg+2,x
8935  1a24 85            	popw	x
8936  1a25 bf00          	ldw	c_y,x
8937  1a27 85            	popw	x
8938  1a28 bf00          	ldw	c_x,x
8939  1a2a 80            	iret
8997                     ; 2274 main()
8997                     ; 2275 {
8999                     	switch	.text
9000  1a2b               _main:
9004                     ; 2277 CLK->ECKR|=1;
9006  1a2b 721050c1      	bset	20673,#0
9008  1a2f               L7663:
9009                     ; 2278 while((CLK->ECKR & 2) == 0);
9011  1a2f c650c1        	ld	a,20673
9012  1a32 a502          	bcp	a,#2
9013  1a34 27f9          	jreq	L7663
9014                     ; 2279 CLK->SWCR|=2;
9016  1a36 721250c5      	bset	20677,#1
9017                     ; 2280 CLK->SWR=0xB4;
9019  1a3a 35b450c4      	mov	20676,#180
9020                     ; 2282 delay_ms(200);
9022  1a3e ae00c8        	ldw	x,#200
9023  1a41 cd0121        	call	_delay_ms
9025                     ; 2283 FLASH_DUKR=0xae;
9027  1a44 35ae5064      	mov	_FLASH_DUKR,#174
9028                     ; 2284 FLASH_DUKR=0x56;
9030  1a48 35565064      	mov	_FLASH_DUKR,#86
9031                     ; 2285 enableInterrupts();
9034  1a4c 9a            rim
9036                     ; 2288 adr_drv_v3();
9039  1a4d cd0d2b        	call	_adr_drv_v3
9041                     ; 2292 t4_init();
9043  1a50 cd1725        	call	_t4_init
9045                     ; 2294 		GPIOG->DDR|=(1<<0);
9047  1a53 72105020      	bset	20512,#0
9048                     ; 2295 		GPIOG->CR1|=(1<<0);
9050  1a57 72105021      	bset	20513,#0
9051                     ; 2296 		GPIOG->CR2&=~(1<<0);	
9053  1a5b 72115022      	bres	20514,#0
9054                     ; 2299 		GPIOG->DDR&=~(1<<1);
9056  1a5f 72135020      	bres	20512,#1
9057                     ; 2300 		GPIOG->CR1|=(1<<1);
9059  1a63 72125021      	bset	20513,#1
9060                     ; 2301 		GPIOG->CR2&=~(1<<1);
9062  1a67 72135022      	bres	20514,#1
9063                     ; 2303 init_CAN();
9065  1a6b cd0f1b        	call	_init_CAN
9067                     ; 2308 GPIOC->DDR|=(1<<1);
9069  1a6e 7212500c      	bset	20492,#1
9070                     ; 2309 GPIOC->CR1|=(1<<1);
9072  1a72 7212500d      	bset	20493,#1
9073                     ; 2310 GPIOC->CR2|=(1<<1);
9075  1a76 7212500e      	bset	20494,#1
9076                     ; 2312 GPIOC->DDR|=(1<<2);
9078  1a7a 7214500c      	bset	20492,#2
9079                     ; 2313 GPIOC->CR1|=(1<<2);
9081  1a7e 7214500d      	bset	20493,#2
9082                     ; 2314 GPIOC->CR2|=(1<<2);
9084  1a82 7214500e      	bset	20494,#2
9085                     ; 2321 t1_init();
9087  1a86 cd1736        	call	_t1_init
9089                     ; 2323 GPIOA->DDR|=(1<<5);
9091  1a89 721a5002      	bset	20482,#5
9092                     ; 2324 GPIOA->CR1|=(1<<5);
9094  1a8d 721a5003      	bset	20483,#5
9095                     ; 2325 GPIOA->CR2&=~(1<<5);
9097  1a91 721b5004      	bres	20484,#5
9098                     ; 2331 GPIOB->DDR&=~(1<<3);
9100  1a95 72175007      	bres	20487,#3
9101                     ; 2332 GPIOB->CR1&=~(1<<3);
9103  1a99 72175008      	bres	20488,#3
9104                     ; 2333 GPIOB->CR2&=~(1<<3);
9106  1a9d 72175009      	bres	20489,#3
9107                     ; 2335 GPIOC->DDR|=(1<<3);
9109  1aa1 7216500c      	bset	20492,#3
9110                     ; 2336 GPIOC->CR1|=(1<<3);
9112  1aa5 7216500d      	bset	20493,#3
9113                     ; 2337 GPIOC->CR2|=(1<<3);
9115  1aa9 7216500e      	bset	20494,#3
9116  1aad               L3763:
9117                     ; 2343 	if(b1000Hz)
9119                     	btst	_b1000Hz
9120  1ab2 2407          	jruge	L7763
9121                     ; 2345 		b1000Hz=0;
9123  1ab4 72110004      	bres	_b1000Hz
9124                     ; 2347 		adc2_init();
9126  1ab8 cd1773        	call	_adc2_init
9128  1abb               L7763:
9129                     ; 2350 	if(bCAN_RX)
9131  1abb 3d04          	tnz	_bCAN_RX
9132  1abd 2705          	jreq	L1073
9133                     ; 2352 		bCAN_RX=0;
9135  1abf 3f04          	clr	_bCAN_RX
9136                     ; 2353 		can_in_an();	
9138  1ac1 cd1078        	call	_can_in_an
9140  1ac4               L1073:
9141                     ; 2355 	if(b100Hz)
9143                     	btst	_b100Hz
9144  1ac9 2407          	jruge	L3073
9145                     ; 2357 		b100Hz=0;
9147  1acb 72110009      	bres	_b100Hz
9148                     ; 2367 		can_tx_hndl();
9150  1acf cd100e        	call	_can_tx_hndl
9152  1ad2               L3073:
9153                     ; 2370 	if(b10Hz)
9155                     	btst	_b10Hz
9156  1ad7 2425          	jruge	L5073
9157                     ; 2372 		b10Hz=0;
9159  1ad9 72110008      	bres	_b10Hz
9160                     ; 2374 		matemat();
9162  1add cd085c        	call	_matemat
9164                     ; 2375 		led_drv(); 
9166  1ae0 cd03ee        	call	_led_drv
9168                     ; 2376 	  link_drv();
9170  1ae3 cd04dc        	call	_link_drv
9172                     ; 2378 	  JP_drv();
9174  1ae6 cd0451        	call	_JP_drv
9176                     ; 2379 	  flags_drv();
9178  1ae9 cd0ce0        	call	_flags_drv
9180                     ; 2381 		if(main_cnt10<100)main_cnt10++;
9182  1aec 9c            	rvf
9183  1aed ce0253        	ldw	x,_main_cnt10
9184  1af0 a30064        	cpw	x,#100
9185  1af3 2e09          	jrsge	L5073
9188  1af5 ce0253        	ldw	x,_main_cnt10
9189  1af8 1c0001        	addw	x,#1
9190  1afb cf0253        	ldw	_main_cnt10,x
9191  1afe               L5073:
9192                     ; 2384 	if(b5Hz)
9194                     	btst	_b5Hz
9195  1b03 241c          	jruge	L1173
9196                     ; 2386 		b5Hz=0;
9198  1b05 72110007      	bres	_b5Hz
9199                     ; 2392 		pwr_drv();		//воздействие на силу
9201  1b09 cd06ac        	call	_pwr_drv
9203                     ; 2393 		led_hndl();
9205  1b0c cd0163        	call	_led_hndl
9207                     ; 2395 		vent_drv();
9209  1b0f cd0534        	call	_vent_drv
9211                     ; 2397 		if(main_cnt1<1000)main_cnt1++;
9213  1b12 9c            	rvf
9214  1b13 be5b          	ldw	x,_main_cnt1
9215  1b15 a303e8        	cpw	x,#1000
9216  1b18 2e07          	jrsge	L1173
9219  1b1a be5b          	ldw	x,_main_cnt1
9220  1b1c 1c0001        	addw	x,#1
9221  1b1f bf5b          	ldw	_main_cnt1,x
9222  1b21               L1173:
9223                     ; 2400 	if(b2Hz)
9225                     	btst	_b2Hz
9226  1b26 2404          	jruge	L5173
9227                     ; 2402 		b2Hz=0;
9229  1b28 72110006      	bres	_b2Hz
9230  1b2c               L5173:
9231                     ; 2411 	if(b1Hz)
9233                     	btst	_b1Hz
9234  1b31 2503cc1aad    	jruge	L3763
9235                     ; 2413 		b1Hz=0;
9237  1b36 72110005      	bres	_b1Hz
9238                     ; 2415 	  pwr_hndl();		//вычисление воздействий на силу
9240  1b3a cd06e4        	call	_pwr_hndl
9242                     ; 2416 		temper_drv();			//вычисление аварий температуры
9244  1b3d cd0a4d        	call	_temper_drv
9246                     ; 2417 		u_drv();
9248  1b40 cd0b24        	call	_u_drv
9250                     ; 2419 		if(main_cnt<1000)main_cnt++;
9252  1b43 9c            	rvf
9253  1b44 ce0255        	ldw	x,_main_cnt
9254  1b47 a303e8        	cpw	x,#1000
9255  1b4a 2e09          	jrsge	L1273
9258  1b4c ce0255        	ldw	x,_main_cnt
9259  1b4f 1c0001        	addw	x,#1
9260  1b52 cf0255        	ldw	_main_cnt,x
9261  1b55               L1273:
9262                     ; 2420   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9264  1b55 b66d          	ld	a,_link
9265  1b57 a1aa          	cp	a,#170
9266  1b59 2706          	jreq	L5273
9268  1b5b b654          	ld	a,_jp_mode
9269  1b5d a103          	cp	a,#3
9270  1b5f 2603          	jrne	L3273
9271  1b61               L5273:
9274  1b61 cd0c41        	call	_apv_hndl
9276  1b64               L3273:
9277                     ; 2423   		can_error_cnt++;
9279  1b64 3c73          	inc	_can_error_cnt
9280                     ; 2424   		if(can_error_cnt>=10)
9282  1b66 b673          	ld	a,_can_error_cnt
9283  1b68 a10a          	cp	a,#10
9284  1b6a 2505          	jrult	L7273
9285                     ; 2426   			can_error_cnt=0;
9287  1b6c 3f73          	clr	_can_error_cnt
9288                     ; 2427 				init_CAN();
9290  1b6e cd0f1b        	call	_init_CAN
9292  1b71               L7273:
9293                     ; 2437 		vent_resurs_hndl();
9295  1b71 cd0000        	call	_vent_resurs_hndl
9297  1b74 acad1aad      	jpf	L3763
10535                     	xdef	_main
10536                     	xdef	f_ADC2_EOC_Interrupt
10537                     	xdef	f_CAN_TX_Interrupt
10538                     	xdef	f_CAN_RX_Interrupt
10539                     	xdef	f_TIM4_UPD_Interrupt
10540                     	xdef	_adc2_init
10541                     	xdef	_t1_init
10542                     	xdef	_t4_init
10543                     	xdef	_can_in_an
10544                     	xdef	_can_tx_hndl
10545                     	xdef	_can_transmit
10546                     	xdef	_init_CAN
10547                     	xdef	_adr_drv_v3
10548                     	xdef	_adr_drv_v4
10549                     	xdef	_flags_drv
10550                     	xdef	_apv_hndl
10551                     	xdef	_apv_stop
10552                     	xdef	_apv_start
10553                     	xdef	_u_drv
10554                     	xdef	_temper_drv
10555                     	xdef	_matemat
10556                     	xdef	_pwr_hndl
10557                     	xdef	_pwr_drv
10558                     	xdef	_vent_drv
10559                     	xdef	_link_drv
10560                     	xdef	_JP_drv
10561                     	xdef	_led_drv
10562                     	xdef	_led_hndl
10563                     	xdef	_delay_ms
10564                     	xdef	_granee
10565                     	xdef	_gran
10566                     	xdef	_vent_resurs_hndl
10567                     	switch	.ubsct
10568  0001               _debug_info_to_uku:
10569  0001 000000000000  	ds.b	6
10570                     	xdef	_debug_info_to_uku
10571  0007               _pwm_u_cnt:
10572  0007 00            	ds.b	1
10573                     	xdef	_pwm_u_cnt
10574  0008               _vent_resurs_tx_cnt:
10575  0008 00            	ds.b	1
10576                     	xdef	_vent_resurs_tx_cnt
10577                     	switch	.bss
10578  0000               _vent_resurs_buff:
10579  0000 00000000      	ds.b	4
10580                     	xdef	_vent_resurs_buff
10581                     	switch	.ubsct
10582  0009               _vent_resurs_sec_cnt:
10583  0009 0000          	ds.b	2
10584                     	xdef	_vent_resurs_sec_cnt
10585                     .eeprom:	section	.data
10586  0000               _vent_resurs:
10587  0000 0000          	ds.b	2
10588                     	xdef	_vent_resurs
10589  0002               _ee_IMAXVENT:
10590  0002 0000          	ds.b	2
10591                     	xdef	_ee_IMAXVENT
10592                     	switch	.ubsct
10593  000b               _bps_class:
10594  000b 00            	ds.b	1
10595                     	xdef	_bps_class
10596  000c               _vent_pwm_integr_cnt:
10597  000c 0000          	ds.b	2
10598                     	xdef	_vent_pwm_integr_cnt
10599  000e               _vent_pwm_integr:
10600  000e 0000          	ds.b	2
10601                     	xdef	_vent_pwm_integr
10602  0010               _vent_pwm:
10603  0010 0000          	ds.b	2
10604                     	xdef	_vent_pwm
10605  0012               _pwm_vent_cnt:
10606  0012 00            	ds.b	1
10607                     	xdef	_pwm_vent_cnt
10608                     	switch	.eeprom
10609  0004               _ee_DEVICE:
10610  0004 0000          	ds.b	2
10611                     	xdef	_ee_DEVICE
10612  0006               _ee_AVT_MODE:
10613  0006 0000          	ds.b	2
10614                     	xdef	_ee_AVT_MODE
10615                     	switch	.ubsct
10616  0013               _i_main_bps_cnt:
10617  0013 000000000000  	ds.b	6
10618                     	xdef	_i_main_bps_cnt
10619  0019               _i_main_sigma:
10620  0019 0000          	ds.b	2
10621                     	xdef	_i_main_sigma
10622  001b               _i_main_num_of_bps:
10623  001b 00            	ds.b	1
10624                     	xdef	_i_main_num_of_bps
10625  001c               _i_main_avg:
10626  001c 0000          	ds.b	2
10627                     	xdef	_i_main_avg
10628  001e               _i_main_flag:
10629  001e 000000000000  	ds.b	6
10630                     	xdef	_i_main_flag
10631  0024               _i_main:
10632  0024 000000000000  	ds.b	12
10633                     	xdef	_i_main
10634  0030               _x:
10635  0030 000000000000  	ds.b	12
10636                     	xdef	_x
10637                     	xdef	_volum_u_main_
10638                     	switch	.eeprom
10639  0008               _UU_AVT:
10640  0008 0000          	ds.b	2
10641                     	xdef	_UU_AVT
10642                     	switch	.ubsct
10643  003c               _cnt_net_drv:
10644  003c 00            	ds.b	1
10645                     	xdef	_cnt_net_drv
10646                     	switch	.bit
10647  0001               _bMAIN:
10648  0001 00            	ds.b	1
10649                     	xdef	_bMAIN
10650                     	switch	.ubsct
10651  003d               _plazma_int:
10652  003d 000000000000  	ds.b	6
10653                     	xdef	_plazma_int
10654                     	xdef	_rotor_int
10655  0043               _led_green_buff:
10656  0043 00000000      	ds.b	4
10657                     	xdef	_led_green_buff
10658  0047               _led_red_buff:
10659  0047 00000000      	ds.b	4
10660                     	xdef	_led_red_buff
10661                     	xdef	_led_drv_cnt
10662                     	xdef	_led_green
10663                     	xdef	_led_red
10664  004b               _res_fl_cnt:
10665  004b 00            	ds.b	1
10666                     	xdef	_res_fl_cnt
10667                     	xdef	_bRES_
10668                     	xdef	_bRES
10669                     	switch	.eeprom
10670  000a               _res_fl_:
10671  000a 00            	ds.b	1
10672                     	xdef	_res_fl_
10673  000b               _res_fl:
10674  000b 00            	ds.b	1
10675                     	xdef	_res_fl
10676                     	switch	.ubsct
10677  004c               _cnt_apv_off:
10678  004c 00            	ds.b	1
10679                     	xdef	_cnt_apv_off
10680                     	switch	.bit
10681  0002               _bAPV:
10682  0002 00            	ds.b	1
10683                     	xdef	_bAPV
10684                     	switch	.ubsct
10685  004d               _apv_cnt_:
10686  004d 0000          	ds.b	2
10687                     	xdef	_apv_cnt_
10688  004f               _apv_cnt:
10689  004f 000000        	ds.b	3
10690                     	xdef	_apv_cnt
10691                     	xdef	_bBL_IPS
10692                     	switch	.bit
10693  0003               _bBL:
10694  0003 00            	ds.b	1
10695                     	xdef	_bBL
10696                     	switch	.ubsct
10697  0052               _cnt_JP1:
10698  0052 00            	ds.b	1
10699                     	xdef	_cnt_JP1
10700  0053               _cnt_JP0:
10701  0053 00            	ds.b	1
10702                     	xdef	_cnt_JP0
10703  0054               _jp_mode:
10704  0054 00            	ds.b	1
10705                     	xdef	_jp_mode
10706  0055               _pwm_u_:
10707  0055 0000          	ds.b	2
10708                     	xdef	_pwm_u_
10709                     	xdef	_pwm_i
10710                     	xdef	_pwm_u
10711  0057               _tmax_cnt:
10712  0057 0000          	ds.b	2
10713                     	xdef	_tmax_cnt
10714  0059               _tsign_cnt:
10715  0059 0000          	ds.b	2
10716                     	xdef	_tsign_cnt
10717                     	switch	.eeprom
10718  000c               _ee_UAVT:
10719  000c 0000          	ds.b	2
10720                     	xdef	_ee_UAVT
10721  000e               _ee_tsign:
10722  000e 0000          	ds.b	2
10723                     	xdef	_ee_tsign
10724  0010               _ee_tmax:
10725  0010 0000          	ds.b	2
10726                     	xdef	_ee_tmax
10727  0012               _ee_dU:
10728  0012 0000          	ds.b	2
10729                     	xdef	_ee_dU
10730  0014               _ee_Umax:
10731  0014 0000          	ds.b	2
10732                     	xdef	_ee_Umax
10733  0016               _ee_TZAS:
10734  0016 0000          	ds.b	2
10735                     	xdef	_ee_TZAS
10736                     	switch	.ubsct
10737  005b               _main_cnt1:
10738  005b 0000          	ds.b	2
10739                     	xdef	_main_cnt1
10740  005d               _off_bp_cnt:
10741  005d 00            	ds.b	1
10742                     	xdef	_off_bp_cnt
10743                     	xdef	_vol_i_temp_avar
10744  005e               _flags_tu_cnt_off:
10745  005e 00            	ds.b	1
10746                     	xdef	_flags_tu_cnt_off
10747  005f               _flags_tu_cnt_on:
10748  005f 00            	ds.b	1
10749                     	xdef	_flags_tu_cnt_on
10750  0060               _vol_i_temp:
10751  0060 0000          	ds.b	2
10752                     	xdef	_vol_i_temp
10753  0062               _vol_u_temp:
10754  0062 0000          	ds.b	2
10755                     	xdef	_vol_u_temp
10756                     	switch	.eeprom
10757  0018               __x_ee_:
10758  0018 0000          	ds.b	2
10759                     	xdef	__x_ee_
10760                     	switch	.ubsct
10761  0064               __x_cnt:
10762  0064 0000          	ds.b	2
10763                     	xdef	__x_cnt
10764  0066               __x__:
10765  0066 0000          	ds.b	2
10766                     	xdef	__x__
10767  0068               __x_:
10768  0068 0000          	ds.b	2
10769                     	xdef	__x_
10770  006a               _flags_tu:
10771  006a 00            	ds.b	1
10772                     	xdef	_flags_tu
10773                     	xdef	_flags
10774  006b               _link_cnt:
10775  006b 0000          	ds.b	2
10776                     	xdef	_link_cnt
10777  006d               _link:
10778  006d 00            	ds.b	1
10779                     	xdef	_link
10780  006e               _umin_cnt:
10781  006e 0000          	ds.b	2
10782                     	xdef	_umin_cnt
10783  0070               _umax_cnt:
10784  0070 0000          	ds.b	2
10785                     	xdef	_umax_cnt
10786                     	switch	.eeprom
10787  001a               _ee_K:
10788  001a 000000000000  	ds.b	20
10789                     	xdef	_ee_K
10790                     	switch	.ubsct
10791  0072               _T:
10792  0072 00            	ds.b	1
10793                     	xdef	_T
10794                     	switch	.bss
10795  0004               _Uin:
10796  0004 0000          	ds.b	2
10797                     	xdef	_Uin
10798  0006               _Usum:
10799  0006 0000          	ds.b	2
10800                     	xdef	_Usum
10801  0008               _U_out_const:
10802  0008 0000          	ds.b	2
10803                     	xdef	_U_out_const
10804  000a               _Unecc:
10805  000a 0000          	ds.b	2
10806                     	xdef	_Unecc
10807  000c               _Ui:
10808  000c 0000          	ds.b	2
10809                     	xdef	_Ui
10810  000e               _Un:
10811  000e 0000          	ds.b	2
10812                     	xdef	_Un
10813  0010               _I:
10814  0010 0000          	ds.b	2
10815                     	xdef	_I
10816                     	switch	.ubsct
10817  0073               _can_error_cnt:
10818  0073 00            	ds.b	1
10819                     	xdef	_can_error_cnt
10820                     	xdef	_bCAN_RX
10821  0074               _tx_busy_cnt:
10822  0074 00            	ds.b	1
10823                     	xdef	_tx_busy_cnt
10824                     	xdef	_bTX_FREE
10825  0075               _can_buff_rd_ptr:
10826  0075 00            	ds.b	1
10827                     	xdef	_can_buff_rd_ptr
10828  0076               _can_buff_wr_ptr:
10829  0076 00            	ds.b	1
10830                     	xdef	_can_buff_wr_ptr
10831  0077               _can_out_buff:
10832  0077 000000000000  	ds.b	64
10833                     	xdef	_can_out_buff
10834                     	switch	.bss
10835  0012               _pwm_u_buff_cnt:
10836  0012 00            	ds.b	1
10837                     	xdef	_pwm_u_buff_cnt
10838  0013               _pwm_u_buff_ptr:
10839  0013 00            	ds.b	1
10840                     	xdef	_pwm_u_buff_ptr
10841  0014               _pwm_u_buff_:
10842  0014 0000          	ds.b	2
10843                     	xdef	_pwm_u_buff_
10844  0016               _pwm_u_buff:
10845  0016 000000000000  	ds.b	64
10846                     	xdef	_pwm_u_buff
10847                     	switch	.ubsct
10848  00b7               _adc_cnt_cnt:
10849  00b7 00            	ds.b	1
10850                     	xdef	_adc_cnt_cnt
10851                     	switch	.bss
10852  0056               _adc_buff_buff:
10853  0056 000000000000  	ds.b	160
10854                     	xdef	_adc_buff_buff
10855  00f6               _adress_error:
10856  00f6 00            	ds.b	1
10857                     	xdef	_adress_error
10858  00f7               _adress:
10859  00f7 00            	ds.b	1
10860                     	xdef	_adress
10861  00f8               _adr:
10862  00f8 000000        	ds.b	3
10863                     	xdef	_adr
10864                     	xdef	_adr_drv_stat
10865                     	xdef	_led_ind
10866                     	switch	.ubsct
10867  00b8               _led_ind_cnt:
10868  00b8 00            	ds.b	1
10869                     	xdef	_led_ind_cnt
10870  00b9               _adc_plazma:
10871  00b9 000000000000  	ds.b	10
10872                     	xdef	_adc_plazma
10873  00c3               _adc_plazma_short:
10874  00c3 0000          	ds.b	2
10875                     	xdef	_adc_plazma_short
10876  00c5               _adc_cnt:
10877  00c5 00            	ds.b	1
10878                     	xdef	_adc_cnt
10879  00c6               _adc_ch:
10880  00c6 00            	ds.b	1
10881                     	xdef	_adc_ch
10882                     	switch	.bss
10883  00fb               _adc_buff_1:
10884  00fb 0000          	ds.b	2
10885                     	xdef	_adc_buff_1
10886  00fd               _adc_buff_5:
10887  00fd 0000          	ds.b	2
10888                     	xdef	_adc_buff_5
10889  00ff               _adc_buff_:
10890  00ff 000000000000  	ds.b	20
10891                     	xdef	_adc_buff_
10892  0113               _adc_buff:
10893  0113 000000000000  	ds.b	320
10894                     	xdef	_adc_buff
10895  0253               _main_cnt10:
10896  0253 0000          	ds.b	2
10897                     	xdef	_main_cnt10
10898  0255               _main_cnt:
10899  0255 0000          	ds.b	2
10900                     	xdef	_main_cnt
10901                     	switch	.ubsct
10902  00c7               _mess:
10903  00c7 000000000000  	ds.b	14
10904                     	xdef	_mess
10905                     	switch	.bit
10906  0004               _b1000Hz:
10907  0004 00            	ds.b	1
10908                     	xdef	_b1000Hz
10909  0005               _b1Hz:
10910  0005 00            	ds.b	1
10911                     	xdef	_b1Hz
10912  0006               _b2Hz:
10913  0006 00            	ds.b	1
10914                     	xdef	_b2Hz
10915  0007               _b5Hz:
10916  0007 00            	ds.b	1
10917                     	xdef	_b5Hz
10918  0008               _b10Hz:
10919  0008 00            	ds.b	1
10920                     	xdef	_b10Hz
10921  0009               _b100Hz:
10922  0009 00            	ds.b	1
10923                     	xdef	_b100Hz
10924                     	xdef	_t0_cnt4
10925                     	xdef	_t0_cnt3
10926                     	xdef	_t0_cnt2
10927                     	xdef	_t0_cnt1
10928                     	xdef	_t0_cnt0
10929                     	xdef	_t0_cnt00
10930                     	xref	_abs
10931                     	xdef	_bVENT_BLOCK
10932                     	xref.b	c_lreg
10933                     	xref.b	c_x
10934                     	xref.b	c_y
10954                     	xref	c_lrsh
10955                     	xref	c_umul
10956                     	xref	c_lgsub
10957                     	xref	c_lgrsh
10958                     	xref	c_lgadd
10959                     	xref	c_idiv
10960                     	xref	c_sdivx
10961                     	xref	c_imul
10962                     	xref	c_lsbc
10963                     	xref	c_ladd
10964                     	xref	c_lsub
10965                     	xref	c_ldiv
10966                     	xref	c_lgmul
10967                     	xref	c_itolx
10968                     	xref	c_eewrc
10969                     	xref	c_ltor
10970                     	xref	c_lgadc
10971                     	xref	c_rtol
10972                     	xref	c_vmul
10973                     	xref	c_eewrw
10974                     	xref	c_lcmp
10975                     	xref	c_uitolx
10976                     	end
