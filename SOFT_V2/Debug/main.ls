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
3278                     ; 555 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//����� ���� � led_red_buff 1 � �� ����� 1
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
3302                     ; 562 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//����� ���� � led_green_buff 1 � �� ����� 1
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
3566                     ; 648 	if(link_cnt==90)flags&=0xc1;		//���� ���������� ����� ������ ����� ���������� ��� ������ � ������� ����������
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
3585                     ; 656 		if(bps_class==bpsIPS)bMAIN=1;	//���� ��� ��������� ��� ������ - �������� ����� �������;
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
4152  06ff ac330833      	jpf	L1712
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
4168  0711 ac330833      	jpf	L1712
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
4184  0725 ac330833      	jpf	L1712
4185  0729               L7712:
4186                     ; 844 else if(link==OFF)
4188  0729 b66d          	ld	a,_link
4189  072b a1aa          	cp	a,#170
4190  072d 2703          	jreq	L45
4191  072f cc07d1        	jp	L3022
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
4306  07c8 2569          	jrult	L1712
4309  07ca ce0014        	ldw	x,_pwm_u_buff_
4310  07cd bf08          	ldw	_pwm_u,x
4311  07cf 2062          	jra	L1712
4312  07d1               L3022:
4313                     ; 871 else	if(link==ON)				//���� ���� �����vol_i_temp_avar
4315  07d1 b66d          	ld	a,_link
4316  07d3 a155          	cp	a,#85
4317  07d5 265c          	jrne	L1712
4318                     ; 873 	if((flags&0b00100000)==0)	//���� ��� ���������� �����
4320  07d7 b605          	ld	a,_flags
4321  07d9 a520          	bcp	a,#32
4322  07db 264a          	jrne	L1322
4323                     ; 875 		if(((flags&0b00011010)==0b00000000)) 	//���� ��� ������ ��� ���� ��� �������������
4325  07dd b605          	ld	a,_flags
4326  07df a51a          	bcp	a,#26
4327  07e1 260b          	jrne	L3322
4328                     ; 877 			pwm_u=vol_i_temp;					//���������� �� ������ + ������������ �����
4330  07e3 be60          	ldw	x,_vol_i_temp
4331  07e5 bf08          	ldw	_pwm_u,x
4332                     ; 878 			pwm_i=1000;
4334  07e7 ae03e8        	ldw	x,#1000
4335  07ea bf0a          	ldw	_pwm_i,x
4337  07ec 200c          	jra	L5322
4338  07ee               L3322:
4339                     ; 880 		else if(flags&0b00011010)					//���� ���� ������
4341  07ee b605          	ld	a,_flags
4342  07f0 a51a          	bcp	a,#26
4343  07f2 2706          	jreq	L5322
4344                     ; 882 			pwm_u=0;								//�� ������ ����
4346  07f4 5f            	clrw	x
4347  07f5 bf08          	ldw	_pwm_u,x
4348                     ; 883 			pwm_i=0;
4350  07f7 5f            	clrw	x
4351  07f8 bf0a          	ldw	_pwm_i,x
4352  07fa               L5322:
4353                     ; 886 		if(vol_i_temp==1000)
4355  07fa be60          	ldw	x,_vol_i_temp
4356  07fc a303e8        	cpw	x,#1000
4357  07ff 260a          	jrne	L3422
4358                     ; 888 			pwm_u=1000;
4360  0801 ae03e8        	ldw	x,#1000
4361  0804 bf08          	ldw	_pwm_u,x
4362                     ; 889 			pwm_i=1000;
4364  0806 ae03e8        	ldw	x,#1000
4365  0809 bf0a          	ldw	_pwm_i,x
4367  080b               L3422:
4368                     ; 896 		if(pwm_u_cnt)
4370  080b 3d07          	tnz	_pwm_u_cnt
4371  080d 2724          	jreq	L1712
4372                     ; 898 			pwm_u_cnt--;
4374  080f 3a07          	dec	_pwm_u_cnt
4375                     ; 899 			pwm_u=(short)((1000L*((long)Unecc))/650L);
4377  0811 ce000a        	ldw	x,_Unecc
4378  0814 90ae03e8      	ldw	y,#1000
4379  0818 cd0000        	call	c_vmul
4381  081b ae0014        	ldw	x,#L25
4382  081e cd0000        	call	c_ldiv
4384  0821 be02          	ldw	x,c_lreg+2
4385  0823 bf08          	ldw	_pwm_u,x
4386  0825 200c          	jra	L1712
4387  0827               L1322:
4388                     ; 902 	else if(flags&0b00100000)	//���� ������������ ����� �� ������ ����������
4390  0827 b605          	ld	a,_flags
4391  0829 a520          	bcp	a,#32
4392  082b 2706          	jreq	L1712
4393                     ; 904 		pwm_u=0;
4395  082d 5f            	clrw	x
4396  082e bf08          	ldw	_pwm_u,x
4397                     ; 905 		pwm_i=0;
4399  0830 5f            	clrw	x
4400  0831 bf0a          	ldw	_pwm_i,x
4401  0833               L1712:
4402                     ; 933 if(pwm_u>1000)pwm_u=1000;
4404  0833 9c            	rvf
4405  0834 be08          	ldw	x,_pwm_u
4406  0836 a303e9        	cpw	x,#1001
4407  0839 2f05          	jrslt	L3522
4410  083b ae03e8        	ldw	x,#1000
4411  083e bf08          	ldw	_pwm_u,x
4412  0840               L3522:
4413                     ; 934 if(pwm_i>1000)pwm_i=1000;
4415  0840 9c            	rvf
4416  0841 be0a          	ldw	x,_pwm_i
4417  0843 a303e9        	cpw	x,#1001
4418  0846 2f05          	jrslt	L5522
4421  0848 ae03e8        	ldw	x,#1000
4422  084b bf0a          	ldw	_pwm_i,x
4423  084d               L5522:
4424                     ; 937 }
4427  084d 5b05          	addw	sp,#5
4428  084f 81            	ret
4481                     	switch	.const
4482  0018               L06:
4483  0018 00000258      	dc.l	600
4484  001c               L26:
4485  001c 000003e8      	dc.l	1000
4486  0020               L46:
4487  0020 00000708      	dc.l	1800
4488                     ; 940 void matemat(void)
4488                     ; 941 {
4489                     	switch	.text
4490  0850               _matemat:
4492  0850 5208          	subw	sp,#8
4493       00000008      OFST:	set	8
4496                     ; 965 I=adc_buff_[4];
4498  0852 ce0107        	ldw	x,_adc_buff_+8
4499  0855 cf0010        	ldw	_I,x
4500                     ; 966 temp_SL=adc_buff_[4];
4502  0858 ce0107        	ldw	x,_adc_buff_+8
4503  085b cd0000        	call	c_itolx
4505  085e 96            	ldw	x,sp
4506  085f 1c0005        	addw	x,#OFST-3
4507  0862 cd0000        	call	c_rtol
4509                     ; 967 temp_SL-=ee_K[0][0];
4511  0865 ce001a        	ldw	x,_ee_K
4512  0868 cd0000        	call	c_itolx
4514  086b 96            	ldw	x,sp
4515  086c 1c0005        	addw	x,#OFST-3
4516  086f cd0000        	call	c_lgsub
4518                     ; 968 if(temp_SL<0) temp_SL=0;
4520  0872 9c            	rvf
4521  0873 0d05          	tnz	(OFST-3,sp)
4522  0875 2e0a          	jrsge	L5722
4525  0877 ae0000        	ldw	x,#0
4526  087a 1f07          	ldw	(OFST-1,sp),x
4527  087c ae0000        	ldw	x,#0
4528  087f 1f05          	ldw	(OFST-3,sp),x
4529  0881               L5722:
4530                     ; 969 temp_SL*=ee_K[0][1];
4532  0881 ce001c        	ldw	x,_ee_K+2
4533  0884 cd0000        	call	c_itolx
4535  0887 96            	ldw	x,sp
4536  0888 1c0005        	addw	x,#OFST-3
4537  088b cd0000        	call	c_lgmul
4539                     ; 970 temp_SL/=600;
4541  088e 96            	ldw	x,sp
4542  088f 1c0005        	addw	x,#OFST-3
4543  0892 cd0000        	call	c_ltor
4545  0895 ae0018        	ldw	x,#L06
4546  0898 cd0000        	call	c_ldiv
4548  089b 96            	ldw	x,sp
4549  089c 1c0005        	addw	x,#OFST-3
4550  089f cd0000        	call	c_rtol
4552                     ; 971 I=(signed short)temp_SL;
4554  08a2 1e07          	ldw	x,(OFST-1,sp)
4555  08a4 cf0010        	ldw	_I,x
4556                     ; 974 temp_SL=(signed long)adc_buff_[1];//1;
4558                     ; 975 temp_SL=(signed long)adc_buff_[3];//1;
4560  08a7 ce0105        	ldw	x,_adc_buff_+6
4561  08aa cd0000        	call	c_itolx
4563  08ad 96            	ldw	x,sp
4564  08ae 1c0005        	addw	x,#OFST-3
4565  08b1 cd0000        	call	c_rtol
4567                     ; 977 if(temp_SL<0) temp_SL=0;
4569  08b4 9c            	rvf
4570  08b5 0d05          	tnz	(OFST-3,sp)
4571  08b7 2e0a          	jrsge	L7722
4574  08b9 ae0000        	ldw	x,#0
4575  08bc 1f07          	ldw	(OFST-1,sp),x
4576  08be ae0000        	ldw	x,#0
4577  08c1 1f05          	ldw	(OFST-3,sp),x
4578  08c3               L7722:
4579                     ; 978 temp_SL*=(signed long)ee_K[2][1];
4581  08c3 ce0024        	ldw	x,_ee_K+10
4582  08c6 cd0000        	call	c_itolx
4584  08c9 96            	ldw	x,sp
4585  08ca 1c0005        	addw	x,#OFST-3
4586  08cd cd0000        	call	c_lgmul
4588                     ; 979 temp_SL/=1000L;
4590  08d0 96            	ldw	x,sp
4591  08d1 1c0005        	addw	x,#OFST-3
4592  08d4 cd0000        	call	c_ltor
4594  08d7 ae001c        	ldw	x,#L26
4595  08da cd0000        	call	c_ldiv
4597  08dd 96            	ldw	x,sp
4598  08de 1c0005        	addw	x,#OFST-3
4599  08e1 cd0000        	call	c_rtol
4601                     ; 980 Ui=(unsigned short)temp_SL;
4603  08e4 1e07          	ldw	x,(OFST-1,sp)
4604  08e6 cf000c        	ldw	_Ui,x
4605                     ; 982 temp_SL=(signed long)adc_buff_5;
4607  08e9 ce00fd        	ldw	x,_adc_buff_5
4608  08ec cd0000        	call	c_itolx
4610  08ef 96            	ldw	x,sp
4611  08f0 1c0005        	addw	x,#OFST-3
4612  08f3 cd0000        	call	c_rtol
4614                     ; 984 if(temp_SL<0) temp_SL=0;
4616  08f6 9c            	rvf
4617  08f7 0d05          	tnz	(OFST-3,sp)
4618  08f9 2e0a          	jrsge	L1032
4621  08fb ae0000        	ldw	x,#0
4622  08fe 1f07          	ldw	(OFST-1,sp),x
4623  0900 ae0000        	ldw	x,#0
4624  0903 1f05          	ldw	(OFST-3,sp),x
4625  0905               L1032:
4626                     ; 985 temp_SL*=(signed long)ee_K[4][1];
4628  0905 ce002c        	ldw	x,_ee_K+18
4629  0908 cd0000        	call	c_itolx
4631  090b 96            	ldw	x,sp
4632  090c 1c0005        	addw	x,#OFST-3
4633  090f cd0000        	call	c_lgmul
4635                     ; 986 temp_SL/=1000L;
4637  0912 96            	ldw	x,sp
4638  0913 1c0005        	addw	x,#OFST-3
4639  0916 cd0000        	call	c_ltor
4641  0919 ae001c        	ldw	x,#L26
4642  091c cd0000        	call	c_ldiv
4644  091f 96            	ldw	x,sp
4645  0920 1c0005        	addw	x,#OFST-3
4646  0923 cd0000        	call	c_rtol
4648                     ; 987 Usum=(unsigned short)temp_SL;
4650  0926 1e07          	ldw	x,(OFST-1,sp)
4651  0928 cf0006        	ldw	_Usum,x
4652                     ; 991 temp_SL=adc_buff_[3];
4654  092b ce0105        	ldw	x,_adc_buff_+6
4655  092e cd0000        	call	c_itolx
4657  0931 96            	ldw	x,sp
4658  0932 1c0005        	addw	x,#OFST-3
4659  0935 cd0000        	call	c_rtol
4661                     ; 993 if(temp_SL<0) temp_SL=0;
4663  0938 9c            	rvf
4664  0939 0d05          	tnz	(OFST-3,sp)
4665  093b 2e0a          	jrsge	L3032
4668  093d ae0000        	ldw	x,#0
4669  0940 1f07          	ldw	(OFST-1,sp),x
4670  0942 ae0000        	ldw	x,#0
4671  0945 1f05          	ldw	(OFST-3,sp),x
4672  0947               L3032:
4673                     ; 994 temp_SL*=ee_K[1][1];
4675  0947 ce0020        	ldw	x,_ee_K+6
4676  094a cd0000        	call	c_itolx
4678  094d 96            	ldw	x,sp
4679  094e 1c0005        	addw	x,#OFST-3
4680  0951 cd0000        	call	c_lgmul
4682                     ; 995 temp_SL/=1800;
4684  0954 96            	ldw	x,sp
4685  0955 1c0005        	addw	x,#OFST-3
4686  0958 cd0000        	call	c_ltor
4688  095b ae0020        	ldw	x,#L46
4689  095e cd0000        	call	c_ldiv
4691  0961 96            	ldw	x,sp
4692  0962 1c0005        	addw	x,#OFST-3
4693  0965 cd0000        	call	c_rtol
4695                     ; 996 Un=(unsigned short)temp_SL;
4697  0968 1e07          	ldw	x,(OFST-1,sp)
4698  096a cf000e        	ldw	_Un,x
4699                     ; 1001 temp_SL=adc_buff_[2];
4701  096d ce0103        	ldw	x,_adc_buff_+4
4702  0970 cd0000        	call	c_itolx
4704  0973 96            	ldw	x,sp
4705  0974 1c0005        	addw	x,#OFST-3
4706  0977 cd0000        	call	c_rtol
4708                     ; 1002 temp_SL*=ee_K[3][1];
4710  097a ce0028        	ldw	x,_ee_K+14
4711  097d cd0000        	call	c_itolx
4713  0980 96            	ldw	x,sp
4714  0981 1c0005        	addw	x,#OFST-3
4715  0984 cd0000        	call	c_lgmul
4717                     ; 1003 temp_SL/=1000;
4719  0987 96            	ldw	x,sp
4720  0988 1c0005        	addw	x,#OFST-3
4721  098b cd0000        	call	c_ltor
4723  098e ae001c        	ldw	x,#L26
4724  0991 cd0000        	call	c_ldiv
4726  0994 96            	ldw	x,sp
4727  0995 1c0005        	addw	x,#OFST-3
4728  0998 cd0000        	call	c_rtol
4730                     ; 1004 T=(signed short)(temp_SL-273L);
4732  099b 7b08          	ld	a,(OFST+0,sp)
4733  099d 5f            	clrw	x
4734  099e 4d            	tnz	a
4735  099f 2a01          	jrpl	L66
4736  09a1 53            	cplw	x
4737  09a2               L66:
4738  09a2 97            	ld	xl,a
4739  09a3 1d0111        	subw	x,#273
4740  09a6 01            	rrwa	x,a
4741  09a7 b772          	ld	_T,a
4742  09a9 02            	rlwa	x,a
4743                     ; 1005 if(T<-30)T=-30;
4745  09aa 9c            	rvf
4746  09ab b672          	ld	a,_T
4747  09ad a1e2          	cp	a,#226
4748  09af 2e04          	jrsge	L5032
4751  09b1 35e20072      	mov	_T,#226
4752  09b5               L5032:
4753                     ; 1006 if(T>120)T=120;
4755  09b5 9c            	rvf
4756  09b6 b672          	ld	a,_T
4757  09b8 a179          	cp	a,#121
4758  09ba 2f04          	jrslt	L7032
4761  09bc 35780072      	mov	_T,#120
4762  09c0               L7032:
4763                     ; 1010 Uin=Usum-Ui;
4765  09c0 ce0006        	ldw	x,_Usum
4766  09c3 72b0000c      	subw	x,_Ui
4767  09c7 cf0004        	ldw	_Uin,x
4768                     ; 1011 if(link==ON)
4770  09ca b66d          	ld	a,_link
4771  09cc a155          	cp	a,#85
4772  09ce 260c          	jrne	L1132
4773                     ; 1013 	Unecc=U_out_const-Uin;
4775  09d0 ce0008        	ldw	x,_U_out_const
4776  09d3 72b00004      	subw	x,_Uin
4777  09d7 cf000a        	ldw	_Unecc,x
4779  09da 200a          	jra	L3132
4780  09dc               L1132:
4781                     ; 1022 else Unecc=ee_UAVT-Uin;
4783  09dc ce000c        	ldw	x,_ee_UAVT
4784  09df 72b00004      	subw	x,_Uin
4785  09e3 cf000a        	ldw	_Unecc,x
4786  09e6               L3132:
4787                     ; 1031 temp_SL=(signed long)(T-ee_tsign);
4789  09e6 5f            	clrw	x
4790  09e7 b672          	ld	a,_T
4791  09e9 2a01          	jrpl	L07
4792  09eb 53            	cplw	x
4793  09ec               L07:
4794  09ec 97            	ld	xl,a
4795  09ed 72b0000e      	subw	x,_ee_tsign
4796  09f1 cd0000        	call	c_itolx
4798  09f4 96            	ldw	x,sp
4799  09f5 1c0005        	addw	x,#OFST-3
4800  09f8 cd0000        	call	c_rtol
4802                     ; 1032 temp_SL*=1000L;
4804  09fb ae03e8        	ldw	x,#1000
4805  09fe bf02          	ldw	c_lreg+2,x
4806  0a00 ae0000        	ldw	x,#0
4807  0a03 bf00          	ldw	c_lreg,x
4808  0a05 96            	ldw	x,sp
4809  0a06 1c0005        	addw	x,#OFST-3
4810  0a09 cd0000        	call	c_lgmul
4812                     ; 1033 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4814  0a0c ce0010        	ldw	x,_ee_tmax
4815  0a0f 72b0000e      	subw	x,_ee_tsign
4816  0a13 cd0000        	call	c_itolx
4818  0a16 96            	ldw	x,sp
4819  0a17 1c0001        	addw	x,#OFST-7
4820  0a1a cd0000        	call	c_rtol
4822  0a1d 96            	ldw	x,sp
4823  0a1e 1c0005        	addw	x,#OFST-3
4824  0a21 cd0000        	call	c_ltor
4826  0a24 96            	ldw	x,sp
4827  0a25 1c0001        	addw	x,#OFST-7
4828  0a28 cd0000        	call	c_ldiv
4830  0a2b 96            	ldw	x,sp
4831  0a2c 1c0005        	addw	x,#OFST-3
4832  0a2f cd0000        	call	c_rtol
4834                     ; 1035 vol_i_temp_avar=(unsigned short)temp_SL; 
4836  0a32 1e07          	ldw	x,(OFST-1,sp)
4837  0a34 bf06          	ldw	_vol_i_temp_avar,x
4838                     ; 1037 debug_info_to_uku[0]=pwm_u;
4840  0a36 be08          	ldw	x,_pwm_u
4841  0a38 bf01          	ldw	_debug_info_to_uku,x
4842                     ; 1038 debug_info_to_uku[1]=vol_i_temp;
4844  0a3a be60          	ldw	x,_vol_i_temp
4845  0a3c bf03          	ldw	_debug_info_to_uku+2,x
4846                     ; 1040 }
4849  0a3e 5b08          	addw	sp,#8
4850  0a40 81            	ret
4881                     ; 1043 void temper_drv(void)		//1 Hz
4881                     ; 1044 {
4882                     	switch	.text
4883  0a41               _temper_drv:
4887                     ; 1046 if(T>ee_tsign) tsign_cnt++;
4889  0a41 9c            	rvf
4890  0a42 5f            	clrw	x
4891  0a43 b672          	ld	a,_T
4892  0a45 2a01          	jrpl	L47
4893  0a47 53            	cplw	x
4894  0a48               L47:
4895  0a48 97            	ld	xl,a
4896  0a49 c3000e        	cpw	x,_ee_tsign
4897  0a4c 2d09          	jrsle	L5232
4900  0a4e be59          	ldw	x,_tsign_cnt
4901  0a50 1c0001        	addw	x,#1
4902  0a53 bf59          	ldw	_tsign_cnt,x
4904  0a55 201d          	jra	L7232
4905  0a57               L5232:
4906                     ; 1047 else if (T<(ee_tsign-1)) tsign_cnt--;
4908  0a57 9c            	rvf
4909  0a58 ce000e        	ldw	x,_ee_tsign
4910  0a5b 5a            	decw	x
4911  0a5c 905f          	clrw	y
4912  0a5e b672          	ld	a,_T
4913  0a60 2a02          	jrpl	L67
4914  0a62 9053          	cplw	y
4915  0a64               L67:
4916  0a64 9097          	ld	yl,a
4917  0a66 90bf00        	ldw	c_y,y
4918  0a69 b300          	cpw	x,c_y
4919  0a6b 2d07          	jrsle	L7232
4922  0a6d be59          	ldw	x,_tsign_cnt
4923  0a6f 1d0001        	subw	x,#1
4924  0a72 bf59          	ldw	_tsign_cnt,x
4925  0a74               L7232:
4926                     ; 1049 gran(&tsign_cnt,0,60);
4928  0a74 ae003c        	ldw	x,#60
4929  0a77 89            	pushw	x
4930  0a78 5f            	clrw	x
4931  0a79 89            	pushw	x
4932  0a7a ae0059        	ldw	x,#_tsign_cnt
4933  0a7d cd00d5        	call	_gran
4935  0a80 5b04          	addw	sp,#4
4936                     ; 1051 if(tsign_cnt>=55)
4938  0a82 9c            	rvf
4939  0a83 be59          	ldw	x,_tsign_cnt
4940  0a85 a30037        	cpw	x,#55
4941  0a88 2f16          	jrslt	L3332
4942                     ; 1053 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //������� ��� ��������� 
4944  0a8a 3d54          	tnz	_jp_mode
4945  0a8c 2606          	jrne	L1432
4947  0a8e b605          	ld	a,_flags
4948  0a90 a540          	bcp	a,#64
4949  0a92 2706          	jreq	L7332
4950  0a94               L1432:
4952  0a94 b654          	ld	a,_jp_mode
4953  0a96 a103          	cp	a,#3
4954  0a98 2612          	jrne	L3432
4955  0a9a               L7332:
4958  0a9a 72140005      	bset	_flags,#2
4959  0a9e 200c          	jra	L3432
4960  0aa0               L3332:
4961                     ; 1055 else if (tsign_cnt<=5) flags&=0b11111011;	//�������� ��� ���������
4963  0aa0 9c            	rvf
4964  0aa1 be59          	ldw	x,_tsign_cnt
4965  0aa3 a30006        	cpw	x,#6
4966  0aa6 2e04          	jrsge	L3432
4969  0aa8 72150005      	bres	_flags,#2
4970  0aac               L3432:
4971                     ; 1060 if(T>ee_tmax) tmax_cnt++;
4973  0aac 9c            	rvf
4974  0aad 5f            	clrw	x
4975  0aae b672          	ld	a,_T
4976  0ab0 2a01          	jrpl	L001
4977  0ab2 53            	cplw	x
4978  0ab3               L001:
4979  0ab3 97            	ld	xl,a
4980  0ab4 c30010        	cpw	x,_ee_tmax
4981  0ab7 2d09          	jrsle	L7432
4984  0ab9 be57          	ldw	x,_tmax_cnt
4985  0abb 1c0001        	addw	x,#1
4986  0abe bf57          	ldw	_tmax_cnt,x
4988  0ac0 201d          	jra	L1532
4989  0ac2               L7432:
4990                     ; 1061 else if (T<(ee_tmax-1)) tmax_cnt--;
4992  0ac2 9c            	rvf
4993  0ac3 ce0010        	ldw	x,_ee_tmax
4994  0ac6 5a            	decw	x
4995  0ac7 905f          	clrw	y
4996  0ac9 b672          	ld	a,_T
4997  0acb 2a02          	jrpl	L201
4998  0acd 9053          	cplw	y
4999  0acf               L201:
5000  0acf 9097          	ld	yl,a
5001  0ad1 90bf00        	ldw	c_y,y
5002  0ad4 b300          	cpw	x,c_y
5003  0ad6 2d07          	jrsle	L1532
5006  0ad8 be57          	ldw	x,_tmax_cnt
5007  0ada 1d0001        	subw	x,#1
5008  0add bf57          	ldw	_tmax_cnt,x
5009  0adf               L1532:
5010                     ; 1063 gran(&tmax_cnt,0,60);
5012  0adf ae003c        	ldw	x,#60
5013  0ae2 89            	pushw	x
5014  0ae3 5f            	clrw	x
5015  0ae4 89            	pushw	x
5016  0ae5 ae0057        	ldw	x,#_tmax_cnt
5017  0ae8 cd00d5        	call	_gran
5019  0aeb 5b04          	addw	sp,#4
5020                     ; 1065 if(tmax_cnt>=55)
5022  0aed 9c            	rvf
5023  0aee be57          	ldw	x,_tmax_cnt
5024  0af0 a30037        	cpw	x,#55
5025  0af3 2f16          	jrslt	L5532
5026                     ; 1067 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5028  0af5 3d54          	tnz	_jp_mode
5029  0af7 2606          	jrne	L3632
5031  0af9 b605          	ld	a,_flags
5032  0afb a540          	bcp	a,#64
5033  0afd 2706          	jreq	L1632
5034  0aff               L3632:
5036  0aff b654          	ld	a,_jp_mode
5037  0b01 a103          	cp	a,#3
5038  0b03 2612          	jrne	L5632
5039  0b05               L1632:
5042  0b05 72120005      	bset	_flags,#1
5043  0b09 200c          	jra	L5632
5044  0b0b               L5532:
5045                     ; 1069 else if (tmax_cnt<=5) flags&=0b11111101;
5047  0b0b 9c            	rvf
5048  0b0c be57          	ldw	x,_tmax_cnt
5049  0b0e a30006        	cpw	x,#6
5050  0b11 2e04          	jrsge	L5632
5053  0b13 72130005      	bres	_flags,#1
5054  0b17               L5632:
5055                     ; 1072 } 
5058  0b17 81            	ret
5090                     ; 1075 void u_drv(void)		//1Hz
5090                     ; 1076 { 
5091                     	switch	.text
5092  0b18               _u_drv:
5096                     ; 1077 if(jp_mode!=jp3)
5098  0b18 b654          	ld	a,_jp_mode
5099  0b1a a103          	cp	a,#3
5100  0b1c 2774          	jreq	L1042
5101                     ; 1079 	if(Ui>ee_Umax)umax_cnt++;
5103  0b1e 9c            	rvf
5104  0b1f ce000c        	ldw	x,_Ui
5105  0b22 c30014        	cpw	x,_ee_Umax
5106  0b25 2d09          	jrsle	L3042
5109  0b27 be70          	ldw	x,_umax_cnt
5110  0b29 1c0001        	addw	x,#1
5111  0b2c bf70          	ldw	_umax_cnt,x
5113  0b2e 2003          	jra	L5042
5114  0b30               L3042:
5115                     ; 1080 	else umax_cnt=0;
5117  0b30 5f            	clrw	x
5118  0b31 bf70          	ldw	_umax_cnt,x
5119  0b33               L5042:
5120                     ; 1081 	gran(&umax_cnt,0,10);
5122  0b33 ae000a        	ldw	x,#10
5123  0b36 89            	pushw	x
5124  0b37 5f            	clrw	x
5125  0b38 89            	pushw	x
5126  0b39 ae0070        	ldw	x,#_umax_cnt
5127  0b3c cd00d5        	call	_gran
5129  0b3f 5b04          	addw	sp,#4
5130                     ; 1082 	if(umax_cnt>=10)flags|=0b00001000; 	//������� ������ �� ���������� ����������
5132  0b41 9c            	rvf
5133  0b42 be70          	ldw	x,_umax_cnt
5134  0b44 a3000a        	cpw	x,#10
5135  0b47 2f04          	jrslt	L7042
5138  0b49 72160005      	bset	_flags,#3
5139  0b4d               L7042:
5140                     ; 1085 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5142  0b4d 9c            	rvf
5143  0b4e ce000c        	ldw	x,_Ui
5144  0b51 c3000e        	cpw	x,_Un
5145  0b54 2e1d          	jrsge	L1142
5147  0b56 9c            	rvf
5148  0b57 ce000e        	ldw	x,_Un
5149  0b5a 72b0000c      	subw	x,_Ui
5150  0b5e c30012        	cpw	x,_ee_dU
5151  0b61 2d10          	jrsle	L1142
5153  0b63 c65005        	ld	a,20485
5154  0b66 a504          	bcp	a,#4
5155  0b68 2609          	jrne	L1142
5158  0b6a be6e          	ldw	x,_umin_cnt
5159  0b6c 1c0001        	addw	x,#1
5160  0b6f bf6e          	ldw	_umin_cnt,x
5162  0b71 2003          	jra	L3142
5163  0b73               L1142:
5164                     ; 1086 	else umin_cnt=0;
5166  0b73 5f            	clrw	x
5167  0b74 bf6e          	ldw	_umin_cnt,x
5168  0b76               L3142:
5169                     ; 1087 	gran(&umin_cnt,0,10);	
5171  0b76 ae000a        	ldw	x,#10
5172  0b79 89            	pushw	x
5173  0b7a 5f            	clrw	x
5174  0b7b 89            	pushw	x
5175  0b7c ae006e        	ldw	x,#_umin_cnt
5176  0b7f cd00d5        	call	_gran
5178  0b82 5b04          	addw	sp,#4
5179                     ; 1088 	if(umin_cnt>=10)flags|=0b00010000;	  
5181  0b84 9c            	rvf
5182  0b85 be6e          	ldw	x,_umin_cnt
5183  0b87 a3000a        	cpw	x,#10
5184  0b8a 2f71          	jrslt	L7142
5187  0b8c 72180005      	bset	_flags,#4
5188  0b90 206b          	jra	L7142
5189  0b92               L1042:
5190                     ; 1090 else if(jp_mode==jp3)
5192  0b92 b654          	ld	a,_jp_mode
5193  0b94 a103          	cp	a,#3
5194  0b96 2665          	jrne	L7142
5195                     ; 1092 	if(Ui>700)umax_cnt++;
5197  0b98 9c            	rvf
5198  0b99 ce000c        	ldw	x,_Ui
5199  0b9c a302bd        	cpw	x,#701
5200  0b9f 2f09          	jrslt	L3242
5203  0ba1 be70          	ldw	x,_umax_cnt
5204  0ba3 1c0001        	addw	x,#1
5205  0ba6 bf70          	ldw	_umax_cnt,x
5207  0ba8 2003          	jra	L5242
5208  0baa               L3242:
5209                     ; 1093 	else umax_cnt=0;
5211  0baa 5f            	clrw	x
5212  0bab bf70          	ldw	_umax_cnt,x
5213  0bad               L5242:
5214                     ; 1094 	gran(&umax_cnt,0,10);
5216  0bad ae000a        	ldw	x,#10
5217  0bb0 89            	pushw	x
5218  0bb1 5f            	clrw	x
5219  0bb2 89            	pushw	x
5220  0bb3 ae0070        	ldw	x,#_umax_cnt
5221  0bb6 cd00d5        	call	_gran
5223  0bb9 5b04          	addw	sp,#4
5224                     ; 1095 	if(umax_cnt>=10)flags|=0b00001000;
5226  0bbb 9c            	rvf
5227  0bbc be70          	ldw	x,_umax_cnt
5228  0bbe a3000a        	cpw	x,#10
5229  0bc1 2f04          	jrslt	L7242
5232  0bc3 72160005      	bset	_flags,#3
5233  0bc7               L7242:
5234                     ; 1098 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5236  0bc7 9c            	rvf
5237  0bc8 ce000c        	ldw	x,_Ui
5238  0bcb a300c8        	cpw	x,#200
5239  0bce 2e10          	jrsge	L1342
5241  0bd0 c65005        	ld	a,20485
5242  0bd3 a504          	bcp	a,#4
5243  0bd5 2609          	jrne	L1342
5246  0bd7 be6e          	ldw	x,_umin_cnt
5247  0bd9 1c0001        	addw	x,#1
5248  0bdc bf6e          	ldw	_umin_cnt,x
5250  0bde 2003          	jra	L3342
5251  0be0               L1342:
5252                     ; 1099 	else umin_cnt=0;
5254  0be0 5f            	clrw	x
5255  0be1 bf6e          	ldw	_umin_cnt,x
5256  0be3               L3342:
5257                     ; 1100 	gran(&umin_cnt,0,10);	
5259  0be3 ae000a        	ldw	x,#10
5260  0be6 89            	pushw	x
5261  0be7 5f            	clrw	x
5262  0be8 89            	pushw	x
5263  0be9 ae006e        	ldw	x,#_umin_cnt
5264  0bec cd00d5        	call	_gran
5266  0bef 5b04          	addw	sp,#4
5267                     ; 1101 	if(umin_cnt>=10)flags|=0b00010000;	  
5269  0bf1 9c            	rvf
5270  0bf2 be6e          	ldw	x,_umin_cnt
5271  0bf4 a3000a        	cpw	x,#10
5272  0bf7 2f04          	jrslt	L7142
5275  0bf9 72180005      	bset	_flags,#4
5276  0bfd               L7142:
5277                     ; 1103 }
5280  0bfd 81            	ret
5306                     ; 1128 void apv_start(void)
5306                     ; 1129 {
5307                     	switch	.text
5308  0bfe               _apv_start:
5312                     ; 1130 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5314  0bfe 3d4f          	tnz	_apv_cnt
5315  0c00 2624          	jrne	L7442
5317  0c02 3d50          	tnz	_apv_cnt+1
5318  0c04 2620          	jrne	L7442
5320  0c06 3d51          	tnz	_apv_cnt+2
5321  0c08 261c          	jrne	L7442
5323                     	btst	_bAPV
5324  0c0f 2515          	jrult	L7442
5325                     ; 1132 	apv_cnt[0]=60;
5327  0c11 353c004f      	mov	_apv_cnt,#60
5328                     ; 1133 	apv_cnt[1]=60;
5330  0c15 353c0050      	mov	_apv_cnt+1,#60
5331                     ; 1134 	apv_cnt[2]=60;
5333  0c19 353c0051      	mov	_apv_cnt+2,#60
5334                     ; 1135 	apv_cnt_=3600;
5336  0c1d ae0e10        	ldw	x,#3600
5337  0c20 bf4d          	ldw	_apv_cnt_,x
5338                     ; 1136 	bAPV=1;	
5340  0c22 72100002      	bset	_bAPV
5341  0c26               L7442:
5342                     ; 1138 }
5345  0c26 81            	ret
5371                     ; 1141 void apv_stop(void)
5371                     ; 1142 {
5372                     	switch	.text
5373  0c27               _apv_stop:
5377                     ; 1143 apv_cnt[0]=0;
5379  0c27 3f4f          	clr	_apv_cnt
5380                     ; 1144 apv_cnt[1]=0;
5382  0c29 3f50          	clr	_apv_cnt+1
5383                     ; 1145 apv_cnt[2]=0;
5385  0c2b 3f51          	clr	_apv_cnt+2
5386                     ; 1146 apv_cnt_=0;	
5388  0c2d 5f            	clrw	x
5389  0c2e bf4d          	ldw	_apv_cnt_,x
5390                     ; 1147 bAPV=0;
5392  0c30 72110002      	bres	_bAPV
5393                     ; 1148 }
5396  0c34 81            	ret
5431                     ; 1152 void apv_hndl(void)
5431                     ; 1153 {
5432                     	switch	.text
5433  0c35               _apv_hndl:
5437                     ; 1154 if(apv_cnt[0])
5439  0c35 3d4f          	tnz	_apv_cnt
5440  0c37 271e          	jreq	L1742
5441                     ; 1156 	apv_cnt[0]--;
5443  0c39 3a4f          	dec	_apv_cnt
5444                     ; 1157 	if(apv_cnt[0]==0)
5446  0c3b 3d4f          	tnz	_apv_cnt
5447  0c3d 265a          	jrne	L5742
5448                     ; 1159 		flags&=0b11100001;
5450  0c3f b605          	ld	a,_flags
5451  0c41 a4e1          	and	a,#225
5452  0c43 b705          	ld	_flags,a
5453                     ; 1160 		tsign_cnt=0;
5455  0c45 5f            	clrw	x
5456  0c46 bf59          	ldw	_tsign_cnt,x
5457                     ; 1161 		tmax_cnt=0;
5459  0c48 5f            	clrw	x
5460  0c49 bf57          	ldw	_tmax_cnt,x
5461                     ; 1162 		umax_cnt=0;
5463  0c4b 5f            	clrw	x
5464  0c4c bf70          	ldw	_umax_cnt,x
5465                     ; 1163 		umin_cnt=0;
5467  0c4e 5f            	clrw	x
5468  0c4f bf6e          	ldw	_umin_cnt,x
5469                     ; 1165 		led_drv_cnt=30;
5471  0c51 351e0016      	mov	_led_drv_cnt,#30
5472  0c55 2042          	jra	L5742
5473  0c57               L1742:
5474                     ; 1168 else if(apv_cnt[1])
5476  0c57 3d50          	tnz	_apv_cnt+1
5477  0c59 271e          	jreq	L7742
5478                     ; 1170 	apv_cnt[1]--;
5480  0c5b 3a50          	dec	_apv_cnt+1
5481                     ; 1171 	if(apv_cnt[1]==0)
5483  0c5d 3d50          	tnz	_apv_cnt+1
5484  0c5f 2638          	jrne	L5742
5485                     ; 1173 		flags&=0b11100001;
5487  0c61 b605          	ld	a,_flags
5488  0c63 a4e1          	and	a,#225
5489  0c65 b705          	ld	_flags,a
5490                     ; 1174 		tsign_cnt=0;
5492  0c67 5f            	clrw	x
5493  0c68 bf59          	ldw	_tsign_cnt,x
5494                     ; 1175 		tmax_cnt=0;
5496  0c6a 5f            	clrw	x
5497  0c6b bf57          	ldw	_tmax_cnt,x
5498                     ; 1176 		umax_cnt=0;
5500  0c6d 5f            	clrw	x
5501  0c6e bf70          	ldw	_umax_cnt,x
5502                     ; 1177 		umin_cnt=0;
5504  0c70 5f            	clrw	x
5505  0c71 bf6e          	ldw	_umin_cnt,x
5506                     ; 1179 		led_drv_cnt=30;
5508  0c73 351e0016      	mov	_led_drv_cnt,#30
5509  0c77 2020          	jra	L5742
5510  0c79               L7742:
5511                     ; 1182 else if(apv_cnt[2])
5513  0c79 3d51          	tnz	_apv_cnt+2
5514  0c7b 271c          	jreq	L5742
5515                     ; 1184 	apv_cnt[2]--;
5517  0c7d 3a51          	dec	_apv_cnt+2
5518                     ; 1185 	if(apv_cnt[2]==0)
5520  0c7f 3d51          	tnz	_apv_cnt+2
5521  0c81 2616          	jrne	L5742
5522                     ; 1187 		flags&=0b11100001;
5524  0c83 b605          	ld	a,_flags
5525  0c85 a4e1          	and	a,#225
5526  0c87 b705          	ld	_flags,a
5527                     ; 1188 		tsign_cnt=0;
5529  0c89 5f            	clrw	x
5530  0c8a bf59          	ldw	_tsign_cnt,x
5531                     ; 1189 		tmax_cnt=0;
5533  0c8c 5f            	clrw	x
5534  0c8d bf57          	ldw	_tmax_cnt,x
5535                     ; 1190 		umax_cnt=0;
5537  0c8f 5f            	clrw	x
5538  0c90 bf70          	ldw	_umax_cnt,x
5539                     ; 1191 		umin_cnt=0;          
5541  0c92 5f            	clrw	x
5542  0c93 bf6e          	ldw	_umin_cnt,x
5543                     ; 1193 		led_drv_cnt=30;
5545  0c95 351e0016      	mov	_led_drv_cnt,#30
5546  0c99               L5742:
5547                     ; 1197 if(apv_cnt_)
5549  0c99 be4d          	ldw	x,_apv_cnt_
5550  0c9b 2712          	jreq	L1152
5551                     ; 1199 	apv_cnt_--;
5553  0c9d be4d          	ldw	x,_apv_cnt_
5554  0c9f 1d0001        	subw	x,#1
5555  0ca2 bf4d          	ldw	_apv_cnt_,x
5556                     ; 1200 	if(apv_cnt_==0) 
5558  0ca4 be4d          	ldw	x,_apv_cnt_
5559  0ca6 2607          	jrne	L1152
5560                     ; 1202 		bAPV=0;
5562  0ca8 72110002      	bres	_bAPV
5563                     ; 1203 		apv_start();
5565  0cac cd0bfe        	call	_apv_start
5567  0caf               L1152:
5568                     ; 1207 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5570  0caf be6e          	ldw	x,_umin_cnt
5571  0cb1 261e          	jrne	L5152
5573  0cb3 be70          	ldw	x,_umax_cnt
5574  0cb5 261a          	jrne	L5152
5576  0cb7 c65005        	ld	a,20485
5577  0cba a504          	bcp	a,#4
5578  0cbc 2613          	jrne	L5152
5579                     ; 1209 	if(cnt_apv_off<20)
5581  0cbe b64c          	ld	a,_cnt_apv_off
5582  0cc0 a114          	cp	a,#20
5583  0cc2 240f          	jruge	L3252
5584                     ; 1211 		cnt_apv_off++;
5586  0cc4 3c4c          	inc	_cnt_apv_off
5587                     ; 1212 		if(cnt_apv_off>=20)
5589  0cc6 b64c          	ld	a,_cnt_apv_off
5590  0cc8 a114          	cp	a,#20
5591  0cca 2507          	jrult	L3252
5592                     ; 1214 			apv_stop();
5594  0ccc cd0c27        	call	_apv_stop
5596  0ccf 2002          	jra	L3252
5597  0cd1               L5152:
5598                     ; 1218 else cnt_apv_off=0;	
5600  0cd1 3f4c          	clr	_cnt_apv_off
5601  0cd3               L3252:
5602                     ; 1220 }
5605  0cd3 81            	ret
5608                     	switch	.ubsct
5609  0000               L5252_flags_old:
5610  0000 00            	ds.b	1
5646                     ; 1223 void flags_drv(void)
5646                     ; 1224 {
5647                     	switch	.text
5648  0cd4               _flags_drv:
5652                     ; 1226 if(jp_mode!=jp3) 
5654  0cd4 b654          	ld	a,_jp_mode
5655  0cd6 a103          	cp	a,#3
5656  0cd8 2723          	jreq	L5452
5657                     ; 1228 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5659  0cda b605          	ld	a,_flags
5660  0cdc a508          	bcp	a,#8
5661  0cde 2706          	jreq	L3552
5663  0ce0 b600          	ld	a,L5252_flags_old
5664  0ce2 a508          	bcp	a,#8
5665  0ce4 270c          	jreq	L1552
5666  0ce6               L3552:
5668  0ce6 b605          	ld	a,_flags
5669  0ce8 a510          	bcp	a,#16
5670  0cea 2726          	jreq	L7552
5672  0cec b600          	ld	a,L5252_flags_old
5673  0cee a510          	bcp	a,#16
5674  0cf0 2620          	jrne	L7552
5675  0cf2               L1552:
5676                     ; 1230     		if(link==OFF)apv_start();
5678  0cf2 b66d          	ld	a,_link
5679  0cf4 a1aa          	cp	a,#170
5680  0cf6 261a          	jrne	L7552
5683  0cf8 cd0bfe        	call	_apv_start
5685  0cfb 2015          	jra	L7552
5686  0cfd               L5452:
5687                     ; 1233 else if(jp_mode==jp3) 
5689  0cfd b654          	ld	a,_jp_mode
5690  0cff a103          	cp	a,#3
5691  0d01 260f          	jrne	L7552
5692                     ; 1235 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5694  0d03 b605          	ld	a,_flags
5695  0d05 a508          	bcp	a,#8
5696  0d07 2709          	jreq	L7552
5698  0d09 b600          	ld	a,L5252_flags_old
5699  0d0b a508          	bcp	a,#8
5700  0d0d 2603          	jrne	L7552
5701                     ; 1237     		apv_start();
5703  0d0f cd0bfe        	call	_apv_start
5705  0d12               L7552:
5706                     ; 1240 flags_old=flags;
5708  0d12 450500        	mov	L5252_flags_old,_flags
5709                     ; 1242 } 
5712  0d15 81            	ret
5747                     ; 1379 void adr_drv_v4(char in)
5747                     ; 1380 {
5748                     	switch	.text
5749  0d16               _adr_drv_v4:
5753                     ; 1381 if(adress!=in)adress=in;
5755  0d16 c100f7        	cp	a,_adress
5756  0d19 2703          	jreq	L3062
5759  0d1b c700f7        	ld	_adress,a
5760  0d1e               L3062:
5761                     ; 1382 }
5764  0d1e 81            	ret
5793                     ; 1385 void adr_drv_v3(void)
5793                     ; 1386 {
5794                     	switch	.text
5795  0d1f               _adr_drv_v3:
5797  0d1f 88            	push	a
5798       00000001      OFST:	set	1
5801                     ; 1392 GPIOB->DDR&=~(1<<0);
5803  0d20 72115007      	bres	20487,#0
5804                     ; 1393 GPIOB->CR1&=~(1<<0);
5806  0d24 72115008      	bres	20488,#0
5807                     ; 1394 GPIOB->CR2&=~(1<<0);
5809  0d28 72115009      	bres	20489,#0
5810                     ; 1395 ADC2->CR2=0x08;
5812  0d2c 35085402      	mov	21506,#8
5813                     ; 1396 ADC2->CR1=0x40;
5815  0d30 35405401      	mov	21505,#64
5816                     ; 1397 ADC2->CSR=0x20+0;
5818  0d34 35205400      	mov	21504,#32
5819                     ; 1398 ADC2->CR1|=1;
5821  0d38 72105401      	bset	21505,#0
5822                     ; 1399 ADC2->CR1|=1;
5824  0d3c 72105401      	bset	21505,#0
5825                     ; 1400 adr_drv_stat=1;
5827  0d40 35010002      	mov	_adr_drv_stat,#1
5828  0d44               L5162:
5829                     ; 1401 while(adr_drv_stat==1);
5832  0d44 b602          	ld	a,_adr_drv_stat
5833  0d46 a101          	cp	a,#1
5834  0d48 27fa          	jreq	L5162
5835                     ; 1403 GPIOB->DDR&=~(1<<1);
5837  0d4a 72135007      	bres	20487,#1
5838                     ; 1404 GPIOB->CR1&=~(1<<1);
5840  0d4e 72135008      	bres	20488,#1
5841                     ; 1405 GPIOB->CR2&=~(1<<1);
5843  0d52 72135009      	bres	20489,#1
5844                     ; 1406 ADC2->CR2=0x08;
5846  0d56 35085402      	mov	21506,#8
5847                     ; 1407 ADC2->CR1=0x40;
5849  0d5a 35405401      	mov	21505,#64
5850                     ; 1408 ADC2->CSR=0x20+1;
5852  0d5e 35215400      	mov	21504,#33
5853                     ; 1409 ADC2->CR1|=1;
5855  0d62 72105401      	bset	21505,#0
5856                     ; 1410 ADC2->CR1|=1;
5858  0d66 72105401      	bset	21505,#0
5859                     ; 1411 adr_drv_stat=3;
5861  0d6a 35030002      	mov	_adr_drv_stat,#3
5862  0d6e               L3262:
5863                     ; 1412 while(adr_drv_stat==3);
5866  0d6e b602          	ld	a,_adr_drv_stat
5867  0d70 a103          	cp	a,#3
5868  0d72 27fa          	jreq	L3262
5869                     ; 1414 GPIOE->DDR&=~(1<<6);
5871  0d74 721d5016      	bres	20502,#6
5872                     ; 1415 GPIOE->CR1&=~(1<<6);
5874  0d78 721d5017      	bres	20503,#6
5875                     ; 1416 GPIOE->CR2&=~(1<<6);
5877  0d7c 721d5018      	bres	20504,#6
5878                     ; 1417 ADC2->CR2=0x08;
5880  0d80 35085402      	mov	21506,#8
5881                     ; 1418 ADC2->CR1=0x40;
5883  0d84 35405401      	mov	21505,#64
5884                     ; 1419 ADC2->CSR=0x20+9;
5886  0d88 35295400      	mov	21504,#41
5887                     ; 1420 ADC2->CR1|=1;
5889  0d8c 72105401      	bset	21505,#0
5890                     ; 1421 ADC2->CR1|=1;
5892  0d90 72105401      	bset	21505,#0
5893                     ; 1422 adr_drv_stat=5;
5895  0d94 35050002      	mov	_adr_drv_stat,#5
5896  0d98               L1362:
5897                     ; 1423 while(adr_drv_stat==5);
5900  0d98 b602          	ld	a,_adr_drv_stat
5901  0d9a a105          	cp	a,#5
5902  0d9c 27fa          	jreq	L1362
5903                     ; 1427 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5905  0d9e 9c            	rvf
5906  0d9f ce00ff        	ldw	x,_adc_buff_
5907  0da2 a3022a        	cpw	x,#554
5908  0da5 2f0f          	jrslt	L7362
5910  0da7 9c            	rvf
5911  0da8 ce00ff        	ldw	x,_adc_buff_
5912  0dab a30253        	cpw	x,#595
5913  0dae 2e06          	jrsge	L7362
5916  0db0 725f00f8      	clr	_adr
5918  0db4 204c          	jra	L1462
5919  0db6               L7362:
5920                     ; 1428 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5922  0db6 9c            	rvf
5923  0db7 ce00ff        	ldw	x,_adc_buff_
5924  0dba a3036d        	cpw	x,#877
5925  0dbd 2f0f          	jrslt	L3462
5927  0dbf 9c            	rvf
5928  0dc0 ce00ff        	ldw	x,_adc_buff_
5929  0dc3 a30396        	cpw	x,#918
5930  0dc6 2e06          	jrsge	L3462
5933  0dc8 350100f8      	mov	_adr,#1
5935  0dcc 2034          	jra	L1462
5936  0dce               L3462:
5937                     ; 1429 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5939  0dce 9c            	rvf
5940  0dcf ce00ff        	ldw	x,_adc_buff_
5941  0dd2 a302a3        	cpw	x,#675
5942  0dd5 2f0f          	jrslt	L7462
5944  0dd7 9c            	rvf
5945  0dd8 ce00ff        	ldw	x,_adc_buff_
5946  0ddb a302cc        	cpw	x,#716
5947  0dde 2e06          	jrsge	L7462
5950  0de0 350200f8      	mov	_adr,#2
5952  0de4 201c          	jra	L1462
5953  0de6               L7462:
5954                     ; 1430 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5956  0de6 9c            	rvf
5957  0de7 ce00ff        	ldw	x,_adc_buff_
5958  0dea a303e3        	cpw	x,#995
5959  0ded 2f0f          	jrslt	L3562
5961  0def 9c            	rvf
5962  0df0 ce00ff        	ldw	x,_adc_buff_
5963  0df3 a3040c        	cpw	x,#1036
5964  0df6 2e06          	jrsge	L3562
5967  0df8 350300f8      	mov	_adr,#3
5969  0dfc 2004          	jra	L1462
5970  0dfe               L3562:
5971                     ; 1431 else adr[0]=5;
5973  0dfe 350500f8      	mov	_adr,#5
5974  0e02               L1462:
5975                     ; 1433 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5977  0e02 9c            	rvf
5978  0e03 ce0101        	ldw	x,_adc_buff_+2
5979  0e06 a3022a        	cpw	x,#554
5980  0e09 2f0f          	jrslt	L7562
5982  0e0b 9c            	rvf
5983  0e0c ce0101        	ldw	x,_adc_buff_+2
5984  0e0f a30253        	cpw	x,#595
5985  0e12 2e06          	jrsge	L7562
5988  0e14 725f00f9      	clr	_adr+1
5990  0e18 204c          	jra	L1662
5991  0e1a               L7562:
5992                     ; 1434 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
5994  0e1a 9c            	rvf
5995  0e1b ce0101        	ldw	x,_adc_buff_+2
5996  0e1e a3036d        	cpw	x,#877
5997  0e21 2f0f          	jrslt	L3662
5999  0e23 9c            	rvf
6000  0e24 ce0101        	ldw	x,_adc_buff_+2
6001  0e27 a30396        	cpw	x,#918
6002  0e2a 2e06          	jrsge	L3662
6005  0e2c 350100f9      	mov	_adr+1,#1
6007  0e30 2034          	jra	L1662
6008  0e32               L3662:
6009                     ; 1435 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6011  0e32 9c            	rvf
6012  0e33 ce0101        	ldw	x,_adc_buff_+2
6013  0e36 a302a3        	cpw	x,#675
6014  0e39 2f0f          	jrslt	L7662
6016  0e3b 9c            	rvf
6017  0e3c ce0101        	ldw	x,_adc_buff_+2
6018  0e3f a302cc        	cpw	x,#716
6019  0e42 2e06          	jrsge	L7662
6022  0e44 350200f9      	mov	_adr+1,#2
6024  0e48 201c          	jra	L1662
6025  0e4a               L7662:
6026                     ; 1436 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6028  0e4a 9c            	rvf
6029  0e4b ce0101        	ldw	x,_adc_buff_+2
6030  0e4e a303e3        	cpw	x,#995
6031  0e51 2f0f          	jrslt	L3762
6033  0e53 9c            	rvf
6034  0e54 ce0101        	ldw	x,_adc_buff_+2
6035  0e57 a3040c        	cpw	x,#1036
6036  0e5a 2e06          	jrsge	L3762
6039  0e5c 350300f9      	mov	_adr+1,#3
6041  0e60 2004          	jra	L1662
6042  0e62               L3762:
6043                     ; 1437 else adr[1]=5;
6045  0e62 350500f9      	mov	_adr+1,#5
6046  0e66               L1662:
6047                     ; 1439 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6049  0e66 9c            	rvf
6050  0e67 ce0111        	ldw	x,_adc_buff_+18
6051  0e6a a3022a        	cpw	x,#554
6052  0e6d 2f0f          	jrslt	L7762
6054  0e6f 9c            	rvf
6055  0e70 ce0111        	ldw	x,_adc_buff_+18
6056  0e73 a30253        	cpw	x,#595
6057  0e76 2e06          	jrsge	L7762
6060  0e78 725f00fa      	clr	_adr+2
6062  0e7c 204c          	jra	L1072
6063  0e7e               L7762:
6064                     ; 1440 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6066  0e7e 9c            	rvf
6067  0e7f ce0111        	ldw	x,_adc_buff_+18
6068  0e82 a3036d        	cpw	x,#877
6069  0e85 2f0f          	jrslt	L3072
6071  0e87 9c            	rvf
6072  0e88 ce0111        	ldw	x,_adc_buff_+18
6073  0e8b a30396        	cpw	x,#918
6074  0e8e 2e06          	jrsge	L3072
6077  0e90 350100fa      	mov	_adr+2,#1
6079  0e94 2034          	jra	L1072
6080  0e96               L3072:
6081                     ; 1441 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6083  0e96 9c            	rvf
6084  0e97 ce0111        	ldw	x,_adc_buff_+18
6085  0e9a a302a3        	cpw	x,#675
6086  0e9d 2f0f          	jrslt	L7072
6088  0e9f 9c            	rvf
6089  0ea0 ce0111        	ldw	x,_adc_buff_+18
6090  0ea3 a302cc        	cpw	x,#716
6091  0ea6 2e06          	jrsge	L7072
6094  0ea8 350200fa      	mov	_adr+2,#2
6096  0eac 201c          	jra	L1072
6097  0eae               L7072:
6098                     ; 1442 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6100  0eae 9c            	rvf
6101  0eaf ce0111        	ldw	x,_adc_buff_+18
6102  0eb2 a303e3        	cpw	x,#995
6103  0eb5 2f0f          	jrslt	L3172
6105  0eb7 9c            	rvf
6106  0eb8 ce0111        	ldw	x,_adc_buff_+18
6107  0ebb a3040c        	cpw	x,#1036
6108  0ebe 2e06          	jrsge	L3172
6111  0ec0 350300fa      	mov	_adr+2,#3
6113  0ec4 2004          	jra	L1072
6114  0ec6               L3172:
6115                     ; 1443 else adr[2]=5;
6117  0ec6 350500fa      	mov	_adr+2,#5
6118  0eca               L1072:
6119                     ; 1447 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6121  0eca c600f8        	ld	a,_adr
6122  0ecd a105          	cp	a,#5
6123  0ecf 270e          	jreq	L1272
6125  0ed1 c600f9        	ld	a,_adr+1
6126  0ed4 a105          	cp	a,#5
6127  0ed6 2707          	jreq	L1272
6129  0ed8 c600fa        	ld	a,_adr+2
6130  0edb a105          	cp	a,#5
6131  0edd 2606          	jrne	L7172
6132  0edf               L1272:
6133                     ; 1450 	adress_error=1;
6135  0edf 350100f6      	mov	_adress_error,#1
6137  0ee3               L5272:
6138                     ; 1461 }
6141  0ee3 84            	pop	a
6142  0ee4 81            	ret
6143  0ee5               L7172:
6144                     ; 1454 	if(adr[2]&0x02) bps_class=bpsIPS;
6146  0ee5 c600fa        	ld	a,_adr+2
6147  0ee8 a502          	bcp	a,#2
6148  0eea 2706          	jreq	L7272
6151  0eec 3501000b      	mov	_bps_class,#1
6153  0ef0 2002          	jra	L1372
6154  0ef2               L7272:
6155                     ; 1455 	else bps_class=bpsIBEP;
6157  0ef2 3f0b          	clr	_bps_class
6158  0ef4               L1372:
6159                     ; 1457 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6161  0ef4 c600fa        	ld	a,_adr+2
6162  0ef7 a401          	and	a,#1
6163  0ef9 97            	ld	xl,a
6164  0efa a610          	ld	a,#16
6165  0efc 42            	mul	x,a
6166  0efd 9f            	ld	a,xl
6167  0efe 6b01          	ld	(OFST+0,sp),a
6168  0f00 c600f9        	ld	a,_adr+1
6169  0f03 48            	sll	a
6170  0f04 48            	sll	a
6171  0f05 cb00f8        	add	a,_adr
6172  0f08 1b01          	add	a,(OFST+0,sp)
6173  0f0a c700f7        	ld	_adress,a
6174  0f0d 20d4          	jra	L5272
6197                     ; 1511 void init_CAN(void) {
6198                     	switch	.text
6199  0f0f               _init_CAN:
6203                     ; 1512 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6205  0f0f 72135420      	bres	21536,#1
6206                     ; 1513 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6208  0f13 72105420      	bset	21536,#0
6210  0f17               L5472:
6211                     ; 1514 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6213  0f17 c65421        	ld	a,21537
6214  0f1a a501          	bcp	a,#1
6215  0f1c 27f9          	jreq	L5472
6216                     ; 1516 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6218  0f1e 72185420      	bset	21536,#4
6219                     ; 1518 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6221  0f22 35025427      	mov	21543,#2
6222                     ; 1527 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6224  0f26 35135428      	mov	21544,#19
6225                     ; 1528 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6227  0f2a 35c05429      	mov	21545,#192
6228                     ; 1529 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6230  0f2e 357f542c      	mov	21548,#127
6231                     ; 1530 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6233  0f32 35e0542d      	mov	21549,#224
6234                     ; 1532 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6236  0f36 35315430      	mov	21552,#49
6237                     ; 1533 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6239  0f3a 35c05431      	mov	21553,#192
6240                     ; 1534 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6242  0f3e 357f5434      	mov	21556,#127
6243                     ; 1535 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6245  0f42 35e05435      	mov	21557,#224
6246                     ; 1539 	CAN->PSR= 6;									// set page 6
6248  0f46 35065427      	mov	21543,#6
6249                     ; 1544 	CAN->Page.Config.FMR1&=~3;								//mask mode
6251  0f4a c65430        	ld	a,21552
6252  0f4d a4fc          	and	a,#252
6253  0f4f c75430        	ld	21552,a
6254                     ; 1550 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6256  0f52 35065432      	mov	21554,#6
6257                     ; 1551 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6259  0f56 35605432      	mov	21554,#96
6260                     ; 1554 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6262  0f5a 72105432      	bset	21554,#0
6263                     ; 1555 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6265  0f5e 72185432      	bset	21554,#4
6266                     ; 1558 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6268  0f62 35065427      	mov	21543,#6
6269                     ; 1560 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6271  0f66 3509542c      	mov	21548,#9
6272                     ; 1561 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6274  0f6a 35e7542d      	mov	21549,#231
6275                     ; 1563 	CAN->IER|=(1<<1);
6277  0f6e 72125425      	bset	21541,#1
6278                     ; 1566 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6280  0f72 72115420      	bres	21536,#0
6282  0f76               L3572:
6283                     ; 1567 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6285  0f76 c65421        	ld	a,21537
6286  0f79 a501          	bcp	a,#1
6287  0f7b 26f9          	jrne	L3572
6288                     ; 1568 }
6291  0f7d 81            	ret
6399                     ; 1571 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6399                     ; 1572 {
6400                     	switch	.text
6401  0f7e               _can_transmit:
6403  0f7e 89            	pushw	x
6404       00000000      OFST:	set	0
6407                     ; 1574 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6409  0f7f b676          	ld	a,_can_buff_wr_ptr
6410  0f81 a104          	cp	a,#4
6411  0f83 2502          	jrult	L5303
6414  0f85 3f76          	clr	_can_buff_wr_ptr
6415  0f87               L5303:
6416                     ; 1576 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6418  0f87 b676          	ld	a,_can_buff_wr_ptr
6419  0f89 97            	ld	xl,a
6420  0f8a a610          	ld	a,#16
6421  0f8c 42            	mul	x,a
6422  0f8d 1601          	ldw	y,(OFST+1,sp)
6423  0f8f a606          	ld	a,#6
6424  0f91               L621:
6425  0f91 9054          	srlw	y
6426  0f93 4a            	dec	a
6427  0f94 26fb          	jrne	L621
6428  0f96 909f          	ld	a,yl
6429  0f98 e777          	ld	(_can_out_buff,x),a
6430                     ; 1577 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6432  0f9a b676          	ld	a,_can_buff_wr_ptr
6433  0f9c 97            	ld	xl,a
6434  0f9d a610          	ld	a,#16
6435  0f9f 42            	mul	x,a
6436  0fa0 7b02          	ld	a,(OFST+2,sp)
6437  0fa2 48            	sll	a
6438  0fa3 48            	sll	a
6439  0fa4 e778          	ld	(_can_out_buff+1,x),a
6440                     ; 1579 can_out_buff[can_buff_wr_ptr][2]=data0;
6442  0fa6 b676          	ld	a,_can_buff_wr_ptr
6443  0fa8 97            	ld	xl,a
6444  0fa9 a610          	ld	a,#16
6445  0fab 42            	mul	x,a
6446  0fac 7b05          	ld	a,(OFST+5,sp)
6447  0fae e779          	ld	(_can_out_buff+2,x),a
6448                     ; 1580 can_out_buff[can_buff_wr_ptr][3]=data1;
6450  0fb0 b676          	ld	a,_can_buff_wr_ptr
6451  0fb2 97            	ld	xl,a
6452  0fb3 a610          	ld	a,#16
6453  0fb5 42            	mul	x,a
6454  0fb6 7b06          	ld	a,(OFST+6,sp)
6455  0fb8 e77a          	ld	(_can_out_buff+3,x),a
6456                     ; 1581 can_out_buff[can_buff_wr_ptr][4]=data2;
6458  0fba b676          	ld	a,_can_buff_wr_ptr
6459  0fbc 97            	ld	xl,a
6460  0fbd a610          	ld	a,#16
6461  0fbf 42            	mul	x,a
6462  0fc0 7b07          	ld	a,(OFST+7,sp)
6463  0fc2 e77b          	ld	(_can_out_buff+4,x),a
6464                     ; 1582 can_out_buff[can_buff_wr_ptr][5]=data3;
6466  0fc4 b676          	ld	a,_can_buff_wr_ptr
6467  0fc6 97            	ld	xl,a
6468  0fc7 a610          	ld	a,#16
6469  0fc9 42            	mul	x,a
6470  0fca 7b08          	ld	a,(OFST+8,sp)
6471  0fcc e77c          	ld	(_can_out_buff+5,x),a
6472                     ; 1583 can_out_buff[can_buff_wr_ptr][6]=data4;
6474  0fce b676          	ld	a,_can_buff_wr_ptr
6475  0fd0 97            	ld	xl,a
6476  0fd1 a610          	ld	a,#16
6477  0fd3 42            	mul	x,a
6478  0fd4 7b09          	ld	a,(OFST+9,sp)
6479  0fd6 e77d          	ld	(_can_out_buff+6,x),a
6480                     ; 1584 can_out_buff[can_buff_wr_ptr][7]=data5;
6482  0fd8 b676          	ld	a,_can_buff_wr_ptr
6483  0fda 97            	ld	xl,a
6484  0fdb a610          	ld	a,#16
6485  0fdd 42            	mul	x,a
6486  0fde 7b0a          	ld	a,(OFST+10,sp)
6487  0fe0 e77e          	ld	(_can_out_buff+7,x),a
6488                     ; 1585 can_out_buff[can_buff_wr_ptr][8]=data6;
6490  0fe2 b676          	ld	a,_can_buff_wr_ptr
6491  0fe4 97            	ld	xl,a
6492  0fe5 a610          	ld	a,#16
6493  0fe7 42            	mul	x,a
6494  0fe8 7b0b          	ld	a,(OFST+11,sp)
6495  0fea e77f          	ld	(_can_out_buff+8,x),a
6496                     ; 1586 can_out_buff[can_buff_wr_ptr][9]=data7;
6498  0fec b676          	ld	a,_can_buff_wr_ptr
6499  0fee 97            	ld	xl,a
6500  0fef a610          	ld	a,#16
6501  0ff1 42            	mul	x,a
6502  0ff2 7b0c          	ld	a,(OFST+12,sp)
6503  0ff4 e780          	ld	(_can_out_buff+9,x),a
6504                     ; 1588 can_buff_wr_ptr++;
6506  0ff6 3c76          	inc	_can_buff_wr_ptr
6507                     ; 1589 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6509  0ff8 b676          	ld	a,_can_buff_wr_ptr
6510  0ffa a104          	cp	a,#4
6511  0ffc 2502          	jrult	L7303
6514  0ffe 3f76          	clr	_can_buff_wr_ptr
6515  1000               L7303:
6516                     ; 1590 } 
6519  1000 85            	popw	x
6520  1001 81            	ret
6549                     ; 1593 void can_tx_hndl(void)
6549                     ; 1594 {
6550                     	switch	.text
6551  1002               _can_tx_hndl:
6555                     ; 1595 if(bTX_FREE)
6557  1002 3d03          	tnz	_bTX_FREE
6558  1004 2757          	jreq	L1503
6559                     ; 1597 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6561  1006 b675          	ld	a,_can_buff_rd_ptr
6562  1008 b176          	cp	a,_can_buff_wr_ptr
6563  100a 275f          	jreq	L7503
6564                     ; 1599 		bTX_FREE=0;
6566  100c 3f03          	clr	_bTX_FREE
6567                     ; 1601 		CAN->PSR= 0;
6569  100e 725f5427      	clr	21543
6570                     ; 1602 		CAN->Page.TxMailbox.MDLCR=8;
6572  1012 35085429      	mov	21545,#8
6573                     ; 1603 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6575  1016 b675          	ld	a,_can_buff_rd_ptr
6576  1018 97            	ld	xl,a
6577  1019 a610          	ld	a,#16
6578  101b 42            	mul	x,a
6579  101c e677          	ld	a,(_can_out_buff,x)
6580  101e c7542a        	ld	21546,a
6581                     ; 1604 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6583  1021 b675          	ld	a,_can_buff_rd_ptr
6584  1023 97            	ld	xl,a
6585  1024 a610          	ld	a,#16
6586  1026 42            	mul	x,a
6587  1027 e678          	ld	a,(_can_out_buff+1,x)
6588  1029 c7542b        	ld	21547,a
6589                     ; 1606 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6591  102c b675          	ld	a,_can_buff_rd_ptr
6592  102e 97            	ld	xl,a
6593  102f a610          	ld	a,#16
6594  1031 42            	mul	x,a
6595  1032 01            	rrwa	x,a
6596  1033 ab79          	add	a,#_can_out_buff+2
6597  1035 2401          	jrnc	L231
6598  1037 5c            	incw	x
6599  1038               L231:
6600  1038 5f            	clrw	x
6601  1039 97            	ld	xl,a
6602  103a bf00          	ldw	c_x,x
6603  103c ae0008        	ldw	x,#8
6604  103f               L431:
6605  103f 5a            	decw	x
6606  1040 92d600        	ld	a,([c_x],x)
6607  1043 d7542e        	ld	(21550,x),a
6608  1046 5d            	tnzw	x
6609  1047 26f6          	jrne	L431
6610                     ; 1608 		can_buff_rd_ptr++;
6612  1049 3c75          	inc	_can_buff_rd_ptr
6613                     ; 1609 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6615  104b b675          	ld	a,_can_buff_rd_ptr
6616  104d a104          	cp	a,#4
6617  104f 2502          	jrult	L5503
6620  1051 3f75          	clr	_can_buff_rd_ptr
6621  1053               L5503:
6622                     ; 1611 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6624  1053 72105428      	bset	21544,#0
6625                     ; 1612 		CAN->IER|=(1<<0);
6627  1057 72105425      	bset	21541,#0
6628  105b 200e          	jra	L7503
6629  105d               L1503:
6630                     ; 1617 	tx_busy_cnt++;
6632  105d 3c74          	inc	_tx_busy_cnt
6633                     ; 1618 	if(tx_busy_cnt>=100)
6635  105f b674          	ld	a,_tx_busy_cnt
6636  1061 a164          	cp	a,#100
6637  1063 2506          	jrult	L7503
6638                     ; 1620 		tx_busy_cnt=0;
6640  1065 3f74          	clr	_tx_busy_cnt
6641                     ; 1621 		bTX_FREE=1;
6643  1067 35010003      	mov	_bTX_FREE,#1
6644  106b               L7503:
6645                     ; 1624 }
6648  106b 81            	ret
6763                     ; 1650 void can_in_an(void)
6763                     ; 1651 {
6764                     	switch	.text
6765  106c               _can_in_an:
6767  106c 5207          	subw	sp,#7
6768       00000007      OFST:	set	7
6771                     ; 1661 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6773  106e b6cd          	ld	a,_mess+6
6774  1070 c100f7        	cp	a,_adress
6775  1073 2703          	jreq	L451
6776  1075 cc11ad        	jp	L7113
6777  1078               L451:
6779  1078 b6ce          	ld	a,_mess+7
6780  107a c100f7        	cp	a,_adress
6781  107d 2703          	jreq	L651
6782  107f cc11ad        	jp	L7113
6783  1082               L651:
6785  1082 b6cf          	ld	a,_mess+8
6786  1084 a1ed          	cp	a,#237
6787  1086 2703          	jreq	L061
6788  1088 cc11ad        	jp	L7113
6789  108b               L061:
6790                     ; 1664 	can_error_cnt=0;
6792  108b 3f73          	clr	_can_error_cnt
6793                     ; 1666 	bMAIN=0;
6795  108d 72110001      	bres	_bMAIN
6796                     ; 1667  	flags_tu=mess[9];
6798  1091 45d06a        	mov	_flags_tu,_mess+9
6799                     ; 1668  	if(flags_tu&0b00000001)
6801  1094 b66a          	ld	a,_flags_tu
6802  1096 a501          	bcp	a,#1
6803  1098 2706          	jreq	L1213
6804                     ; 1673  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6806  109a 721a0005      	bset	_flags,#5
6808  109e 2008          	jra	L3213
6809  10a0               L1213:
6810                     ; 1684  				flags&=0b11011111; 
6812  10a0 721b0005      	bres	_flags,#5
6813                     ; 1685  				off_bp_cnt=5*EE_TZAS;
6815  10a4 350f005d      	mov	_off_bp_cnt,#15
6816  10a8               L3213:
6817                     ; 1691  	if(flags_tu&0b00000010) flags|=0b01000000;
6819  10a8 b66a          	ld	a,_flags_tu
6820  10aa a502          	bcp	a,#2
6821  10ac 2706          	jreq	L5213
6824  10ae 721c0005      	bset	_flags,#6
6826  10b2 2004          	jra	L7213
6827  10b4               L5213:
6828                     ; 1692  	else flags&=0b10111111; 
6830  10b4 721d0005      	bres	_flags,#6
6831  10b8               L7213:
6832                     ; 1694  	U_out_const=mess[10]+mess[11]*256;
6834  10b8 b6d2          	ld	a,_mess+11
6835  10ba 5f            	clrw	x
6836  10bb 97            	ld	xl,a
6837  10bc 4f            	clr	a
6838  10bd 02            	rlwa	x,a
6839  10be 01            	rrwa	x,a
6840  10bf bbd1          	add	a,_mess+10
6841  10c1 2401          	jrnc	L041
6842  10c3 5c            	incw	x
6843  10c4               L041:
6844  10c4 c70009        	ld	_U_out_const+1,a
6845  10c7 9f            	ld	a,xl
6846  10c8 c70008        	ld	_U_out_const,a
6847                     ; 1695  	vol_i_temp=mess[12]+mess[13]*256;  
6849  10cb b6d4          	ld	a,_mess+13
6850  10cd 5f            	clrw	x
6851  10ce 97            	ld	xl,a
6852  10cf 4f            	clr	a
6853  10d0 02            	rlwa	x,a
6854  10d1 01            	rrwa	x,a
6855  10d2 bbd3          	add	a,_mess+12
6856  10d4 2401          	jrnc	L241
6857  10d6 5c            	incw	x
6858  10d7               L241:
6859  10d7 b761          	ld	_vol_i_temp+1,a
6860  10d9 9f            	ld	a,xl
6861  10da b760          	ld	_vol_i_temp,a
6862                     ; 1705 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6864  10dc b608          	ld	a,_vent_resurs_tx_cnt
6865  10de a102          	cp	a,#2
6866  10e0 2507          	jrult	L1313
6869  10e2 ce0000        	ldw	x,_vent_resurs
6870  10e5 bf41          	ldw	_plazma_int+4,x
6872  10e7 2004          	jra	L3313
6873  10e9               L1313:
6874                     ; 1706 	else plazma_int[2]=vent_resurs_sec_cnt;
6876  10e9 be09          	ldw	x,_vent_resurs_sec_cnt
6877  10eb bf41          	ldw	_plazma_int+4,x
6878  10ed               L3313:
6879                     ; 1707  	rotor_int=flags_tu+(((short)flags)<<8);
6881  10ed b605          	ld	a,_flags
6882  10ef 5f            	clrw	x
6883  10f0 97            	ld	xl,a
6884  10f1 4f            	clr	a
6885  10f2 02            	rlwa	x,a
6886  10f3 01            	rrwa	x,a
6887  10f4 bb6a          	add	a,_flags_tu
6888  10f6 2401          	jrnc	L441
6889  10f8 5c            	incw	x
6890  10f9               L441:
6891  10f9 b718          	ld	_rotor_int+1,a
6892  10fb 9f            	ld	a,xl
6893  10fc b717          	ld	_rotor_int,a
6894                     ; 1708 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6896  10fe 3b000c        	push	_Ui
6897  1101 3b000d        	push	_Ui+1
6898  1104 3b000e        	push	_Un
6899  1107 3b000f        	push	_Un+1
6900  110a 3b0010        	push	_I
6901  110d 3b0011        	push	_I+1
6902  1110 4bda          	push	#218
6903  1112 3b00f7        	push	_adress
6904  1115 ae018e        	ldw	x,#398
6905  1118 cd0f7e        	call	_can_transmit
6907  111b 5b08          	addw	sp,#8
6908                     ; 1709 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6910  111d 3b0006        	push	_Usum
6911  1120 3b0007        	push	_Usum+1
6912  1123 3b0069        	push	__x_+1
6913  1126 3b0005        	push	_flags
6914  1129 b608          	ld	a,_vent_resurs_tx_cnt
6915  112b 5f            	clrw	x
6916  112c 97            	ld	xl,a
6917  112d d60000        	ld	a,(_vent_resurs_buff,x)
6918  1130 88            	push	a
6919  1131 3b0072        	push	_T
6920  1134 4bdb          	push	#219
6921  1136 3b00f7        	push	_adress
6922  1139 ae018e        	ldw	x,#398
6923  113c cd0f7e        	call	_can_transmit
6925  113f 5b08          	addw	sp,#8
6926                     ; 1710 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6928  1141 3b0005        	push	_debug_info_to_uku+4
6929  1144 3b0006        	push	_debug_info_to_uku+5
6930  1147 3b0003        	push	_debug_info_to_uku+2
6931  114a 3b0004        	push	_debug_info_to_uku+3
6932  114d 3b0001        	push	_debug_info_to_uku
6933  1150 3b0002        	push	_debug_info_to_uku+1
6934  1153 4bdc          	push	#220
6935  1155 3b00f7        	push	_adress
6936  1158 ae018e        	ldw	x,#398
6937  115b cd0f7e        	call	_can_transmit
6939  115e 5b08          	addw	sp,#8
6940                     ; 1711      link_cnt=0;
6942  1160 5f            	clrw	x
6943  1161 bf6b          	ldw	_link_cnt,x
6944                     ; 1712      link=ON;
6946  1163 3555006d      	mov	_link,#85
6947                     ; 1714      if(flags_tu&0b10000000)
6949  1167 b66a          	ld	a,_flags_tu
6950  1169 a580          	bcp	a,#128
6951  116b 2716          	jreq	L5313
6952                     ; 1716      	if(!res_fl)
6954  116d 725d000b      	tnz	_res_fl
6955  1171 2626          	jrne	L1413
6956                     ; 1718      		res_fl=1;
6958  1173 a601          	ld	a,#1
6959  1175 ae000b        	ldw	x,#_res_fl
6960  1178 cd0000        	call	c_eewrc
6962                     ; 1719      		bRES=1;
6964  117b 3501000c      	mov	_bRES,#1
6965                     ; 1720      		res_fl_cnt=0;
6967  117f 3f4b          	clr	_res_fl_cnt
6968  1181 2016          	jra	L1413
6969  1183               L5313:
6970                     ; 1725      	if(main_cnt>20)
6972  1183 9c            	rvf
6973  1184 ce0255        	ldw	x,_main_cnt
6974  1187 a30015        	cpw	x,#21
6975  118a 2f0d          	jrslt	L1413
6976                     ; 1727     			if(res_fl)
6978  118c 725d000b      	tnz	_res_fl
6979  1190 2707          	jreq	L1413
6980                     ; 1729      			res_fl=0;
6982  1192 4f            	clr	a
6983  1193 ae000b        	ldw	x,#_res_fl
6984  1196 cd0000        	call	c_eewrc
6986  1199               L1413:
6987                     ; 1734       if(res_fl_)
6989  1199 725d000a      	tnz	_res_fl_
6990  119d 2603          	jrne	L261
6991  119f cc1714        	jp	L3603
6992  11a2               L261:
6993                     ; 1736       	res_fl_=0;
6995  11a2 4f            	clr	a
6996  11a3 ae000a        	ldw	x,#_res_fl_
6997  11a6 cd0000        	call	c_eewrc
6999  11a9 ac141714      	jpf	L3603
7000  11ad               L7113:
7001                     ; 1739 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7003  11ad b6cd          	ld	a,_mess+6
7004  11af c100f7        	cp	a,_adress
7005  11b2 2703          	jreq	L461
7006  11b4 cc142a        	jp	L3513
7007  11b7               L461:
7009  11b7 b6ce          	ld	a,_mess+7
7010  11b9 c100f7        	cp	a,_adress
7011  11bc 2703          	jreq	L661
7012  11be cc142a        	jp	L3513
7013  11c1               L661:
7015  11c1 b6cf          	ld	a,_mess+8
7016  11c3 a1ee          	cp	a,#238
7017  11c5 2703          	jreq	L071
7018  11c7 cc142a        	jp	L3513
7019  11ca               L071:
7021  11ca b6d0          	ld	a,_mess+9
7022  11cc b1d1          	cp	a,_mess+10
7023  11ce 2703          	jreq	L271
7024  11d0 cc142a        	jp	L3513
7025  11d3               L271:
7026                     ; 1741 	rotor_int++;
7028  11d3 be17          	ldw	x,_rotor_int
7029  11d5 1c0001        	addw	x,#1
7030  11d8 bf17          	ldw	_rotor_int,x
7031                     ; 1742 	if((mess[9]&0xf0)==0x20)
7033  11da b6d0          	ld	a,_mess+9
7034  11dc a4f0          	and	a,#240
7035  11de a120          	cp	a,#32
7036  11e0 2673          	jrne	L5513
7037                     ; 1744 		if((mess[9]&0x0f)==0x01)
7039  11e2 b6d0          	ld	a,_mess+9
7040  11e4 a40f          	and	a,#15
7041  11e6 a101          	cp	a,#1
7042  11e8 260d          	jrne	L7513
7043                     ; 1746 			ee_K[0][0]=adc_buff_[4];
7045  11ea ce0107        	ldw	x,_adc_buff_+8
7046  11ed 89            	pushw	x
7047  11ee ae001a        	ldw	x,#_ee_K
7048  11f1 cd0000        	call	c_eewrw
7050  11f4 85            	popw	x
7052  11f5 204a          	jra	L1613
7053  11f7               L7513:
7054                     ; 1748 		else if((mess[9]&0x0f)==0x02)
7056  11f7 b6d0          	ld	a,_mess+9
7057  11f9 a40f          	and	a,#15
7058  11fb a102          	cp	a,#2
7059  11fd 260b          	jrne	L3613
7060                     ; 1750 			ee_K[0][1]++;
7062  11ff ce001c        	ldw	x,_ee_K+2
7063  1202 1c0001        	addw	x,#1
7064  1205 cf001c        	ldw	_ee_K+2,x
7066  1208 2037          	jra	L1613
7067  120a               L3613:
7068                     ; 1752 		else if((mess[9]&0x0f)==0x03)
7070  120a b6d0          	ld	a,_mess+9
7071  120c a40f          	and	a,#15
7072  120e a103          	cp	a,#3
7073  1210 260b          	jrne	L7613
7074                     ; 1754 			ee_K[0][1]+=10;
7076  1212 ce001c        	ldw	x,_ee_K+2
7077  1215 1c000a        	addw	x,#10
7078  1218 cf001c        	ldw	_ee_K+2,x
7080  121b 2024          	jra	L1613
7081  121d               L7613:
7082                     ; 1756 		else if((mess[9]&0x0f)==0x04)
7084  121d b6d0          	ld	a,_mess+9
7085  121f a40f          	and	a,#15
7086  1221 a104          	cp	a,#4
7087  1223 260b          	jrne	L3713
7088                     ; 1758 			ee_K[0][1]--;
7090  1225 ce001c        	ldw	x,_ee_K+2
7091  1228 1d0001        	subw	x,#1
7092  122b cf001c        	ldw	_ee_K+2,x
7094  122e 2011          	jra	L1613
7095  1230               L3713:
7096                     ; 1760 		else if((mess[9]&0x0f)==0x05)
7098  1230 b6d0          	ld	a,_mess+9
7099  1232 a40f          	and	a,#15
7100  1234 a105          	cp	a,#5
7101  1236 2609          	jrne	L1613
7102                     ; 1762 			ee_K[0][1]-=10;
7104  1238 ce001c        	ldw	x,_ee_K+2
7105  123b 1d000a        	subw	x,#10
7106  123e cf001c        	ldw	_ee_K+2,x
7107  1241               L1613:
7108                     ; 1764 		granee(&ee_K[0][1],50,3000);									
7110  1241 ae0bb8        	ldw	x,#3000
7111  1244 89            	pushw	x
7112  1245 ae0032        	ldw	x,#50
7113  1248 89            	pushw	x
7114  1249 ae001c        	ldw	x,#_ee_K+2
7115  124c cd00f6        	call	_granee
7117  124f 5b04          	addw	sp,#4
7119  1251 ac0f140f      	jpf	L1023
7120  1255               L5513:
7121                     ; 1766 	else if((mess[9]&0xf0)==0x10)
7123  1255 b6d0          	ld	a,_mess+9
7124  1257 a4f0          	and	a,#240
7125  1259 a110          	cp	a,#16
7126  125b 2673          	jrne	L3023
7127                     ; 1768 		if((mess[9]&0x0f)==0x01)
7129  125d b6d0          	ld	a,_mess+9
7130  125f a40f          	and	a,#15
7131  1261 a101          	cp	a,#1
7132  1263 260d          	jrne	L5023
7133                     ; 1770 			ee_K[1][0]=adc_buff_[1];
7135  1265 ce0101        	ldw	x,_adc_buff_+2
7136  1268 89            	pushw	x
7137  1269 ae001e        	ldw	x,#_ee_K+4
7138  126c cd0000        	call	c_eewrw
7140  126f 85            	popw	x
7142  1270 204a          	jra	L7023
7143  1272               L5023:
7144                     ; 1772 		else if((mess[9]&0x0f)==0x02)
7146  1272 b6d0          	ld	a,_mess+9
7147  1274 a40f          	and	a,#15
7148  1276 a102          	cp	a,#2
7149  1278 260b          	jrne	L1123
7150                     ; 1774 			ee_K[1][1]++;
7152  127a ce0020        	ldw	x,_ee_K+6
7153  127d 1c0001        	addw	x,#1
7154  1280 cf0020        	ldw	_ee_K+6,x
7156  1283 2037          	jra	L7023
7157  1285               L1123:
7158                     ; 1776 		else if((mess[9]&0x0f)==0x03)
7160  1285 b6d0          	ld	a,_mess+9
7161  1287 a40f          	and	a,#15
7162  1289 a103          	cp	a,#3
7163  128b 260b          	jrne	L5123
7164                     ; 1778 			ee_K[1][1]+=10;
7166  128d ce0020        	ldw	x,_ee_K+6
7167  1290 1c000a        	addw	x,#10
7168  1293 cf0020        	ldw	_ee_K+6,x
7170  1296 2024          	jra	L7023
7171  1298               L5123:
7172                     ; 1780 		else if((mess[9]&0x0f)==0x04)
7174  1298 b6d0          	ld	a,_mess+9
7175  129a a40f          	and	a,#15
7176  129c a104          	cp	a,#4
7177  129e 260b          	jrne	L1223
7178                     ; 1782 			ee_K[1][1]--;
7180  12a0 ce0020        	ldw	x,_ee_K+6
7181  12a3 1d0001        	subw	x,#1
7182  12a6 cf0020        	ldw	_ee_K+6,x
7184  12a9 2011          	jra	L7023
7185  12ab               L1223:
7186                     ; 1784 		else if((mess[9]&0x0f)==0x05)
7188  12ab b6d0          	ld	a,_mess+9
7189  12ad a40f          	and	a,#15
7190  12af a105          	cp	a,#5
7191  12b1 2609          	jrne	L7023
7192                     ; 1786 			ee_K[1][1]-=10;
7194  12b3 ce0020        	ldw	x,_ee_K+6
7195  12b6 1d000a        	subw	x,#10
7196  12b9 cf0020        	ldw	_ee_K+6,x
7197  12bc               L7023:
7198                     ; 1791 		granee(&ee_K[1][1],10,30000);
7200  12bc ae7530        	ldw	x,#30000
7201  12bf 89            	pushw	x
7202  12c0 ae000a        	ldw	x,#10
7203  12c3 89            	pushw	x
7204  12c4 ae0020        	ldw	x,#_ee_K+6
7205  12c7 cd00f6        	call	_granee
7207  12ca 5b04          	addw	sp,#4
7209  12cc ac0f140f      	jpf	L1023
7210  12d0               L3023:
7211                     ; 1795 	else if((mess[9]&0xf0)==0x00)
7213  12d0 b6d0          	ld	a,_mess+9
7214  12d2 a5f0          	bcp	a,#240
7215  12d4 2673          	jrne	L1323
7216                     ; 1797 		if((mess[9]&0x0f)==0x01)
7218  12d6 b6d0          	ld	a,_mess+9
7219  12d8 a40f          	and	a,#15
7220  12da a101          	cp	a,#1
7221  12dc 260d          	jrne	L3323
7222                     ; 1799 			ee_K[2][0]=adc_buff_[2];
7224  12de ce0103        	ldw	x,_adc_buff_+4
7225  12e1 89            	pushw	x
7226  12e2 ae0022        	ldw	x,#_ee_K+8
7227  12e5 cd0000        	call	c_eewrw
7229  12e8 85            	popw	x
7231  12e9 204a          	jra	L5323
7232  12eb               L3323:
7233                     ; 1801 		else if((mess[9]&0x0f)==0x02)
7235  12eb b6d0          	ld	a,_mess+9
7236  12ed a40f          	and	a,#15
7237  12ef a102          	cp	a,#2
7238  12f1 260b          	jrne	L7323
7239                     ; 1803 			ee_K[2][1]++;
7241  12f3 ce0024        	ldw	x,_ee_K+10
7242  12f6 1c0001        	addw	x,#1
7243  12f9 cf0024        	ldw	_ee_K+10,x
7245  12fc 2037          	jra	L5323
7246  12fe               L7323:
7247                     ; 1805 		else if((mess[9]&0x0f)==0x03)
7249  12fe b6d0          	ld	a,_mess+9
7250  1300 a40f          	and	a,#15
7251  1302 a103          	cp	a,#3
7252  1304 260b          	jrne	L3423
7253                     ; 1807 			ee_K[2][1]+=10;
7255  1306 ce0024        	ldw	x,_ee_K+10
7256  1309 1c000a        	addw	x,#10
7257  130c cf0024        	ldw	_ee_K+10,x
7259  130f 2024          	jra	L5323
7260  1311               L3423:
7261                     ; 1809 		else if((mess[9]&0x0f)==0x04)
7263  1311 b6d0          	ld	a,_mess+9
7264  1313 a40f          	and	a,#15
7265  1315 a104          	cp	a,#4
7266  1317 260b          	jrne	L7423
7267                     ; 1811 			ee_K[2][1]--;
7269  1319 ce0024        	ldw	x,_ee_K+10
7270  131c 1d0001        	subw	x,#1
7271  131f cf0024        	ldw	_ee_K+10,x
7273  1322 2011          	jra	L5323
7274  1324               L7423:
7275                     ; 1813 		else if((mess[9]&0x0f)==0x05)
7277  1324 b6d0          	ld	a,_mess+9
7278  1326 a40f          	and	a,#15
7279  1328 a105          	cp	a,#5
7280  132a 2609          	jrne	L5323
7281                     ; 1815 			ee_K[2][1]-=10;
7283  132c ce0024        	ldw	x,_ee_K+10
7284  132f 1d000a        	subw	x,#10
7285  1332 cf0024        	ldw	_ee_K+10,x
7286  1335               L5323:
7287                     ; 1820 		granee(&ee_K[2][1],10,30000);
7289  1335 ae7530        	ldw	x,#30000
7290  1338 89            	pushw	x
7291  1339 ae000a        	ldw	x,#10
7292  133c 89            	pushw	x
7293  133d ae0024        	ldw	x,#_ee_K+10
7294  1340 cd00f6        	call	_granee
7296  1343 5b04          	addw	sp,#4
7298  1345 ac0f140f      	jpf	L1023
7299  1349               L1323:
7300                     ; 1824 	else if((mess[9]&0xf0)==0x30)
7302  1349 b6d0          	ld	a,_mess+9
7303  134b a4f0          	and	a,#240
7304  134d a130          	cp	a,#48
7305  134f 265c          	jrne	L7523
7306                     ; 1826 		if((mess[9]&0x0f)==0x02)
7308  1351 b6d0          	ld	a,_mess+9
7309  1353 a40f          	and	a,#15
7310  1355 a102          	cp	a,#2
7311  1357 260b          	jrne	L1623
7312                     ; 1828 			ee_K[3][1]++;
7314  1359 ce0028        	ldw	x,_ee_K+14
7315  135c 1c0001        	addw	x,#1
7316  135f cf0028        	ldw	_ee_K+14,x
7318  1362 2037          	jra	L3623
7319  1364               L1623:
7320                     ; 1830 		else if((mess[9]&0x0f)==0x03)
7322  1364 b6d0          	ld	a,_mess+9
7323  1366 a40f          	and	a,#15
7324  1368 a103          	cp	a,#3
7325  136a 260b          	jrne	L5623
7326                     ; 1832 			ee_K[3][1]+=10;
7328  136c ce0028        	ldw	x,_ee_K+14
7329  136f 1c000a        	addw	x,#10
7330  1372 cf0028        	ldw	_ee_K+14,x
7332  1375 2024          	jra	L3623
7333  1377               L5623:
7334                     ; 1834 		else if((mess[9]&0x0f)==0x04)
7336  1377 b6d0          	ld	a,_mess+9
7337  1379 a40f          	and	a,#15
7338  137b a104          	cp	a,#4
7339  137d 260b          	jrne	L1723
7340                     ; 1836 			ee_K[3][1]--;
7342  137f ce0028        	ldw	x,_ee_K+14
7343  1382 1d0001        	subw	x,#1
7344  1385 cf0028        	ldw	_ee_K+14,x
7346  1388 2011          	jra	L3623
7347  138a               L1723:
7348                     ; 1838 		else if((mess[9]&0x0f)==0x05)
7350  138a b6d0          	ld	a,_mess+9
7351  138c a40f          	and	a,#15
7352  138e a105          	cp	a,#5
7353  1390 2609          	jrne	L3623
7354                     ; 1840 			ee_K[3][1]-=10;
7356  1392 ce0028        	ldw	x,_ee_K+14
7357  1395 1d000a        	subw	x,#10
7358  1398 cf0028        	ldw	_ee_K+14,x
7359  139b               L3623:
7360                     ; 1842 		granee(&ee_K[3][1],300,517);									
7362  139b ae0205        	ldw	x,#517
7363  139e 89            	pushw	x
7364  139f ae012c        	ldw	x,#300
7365  13a2 89            	pushw	x
7366  13a3 ae0028        	ldw	x,#_ee_K+14
7367  13a6 cd00f6        	call	_granee
7369  13a9 5b04          	addw	sp,#4
7371  13ab 2062          	jra	L1023
7372  13ad               L7523:
7373                     ; 1845 	else if((mess[9]&0xf0)==0x50)
7375  13ad b6d0          	ld	a,_mess+9
7376  13af a4f0          	and	a,#240
7377  13b1 a150          	cp	a,#80
7378  13b3 265a          	jrne	L1023
7379                     ; 1847 		if((mess[9]&0x0f)==0x02)
7381  13b5 b6d0          	ld	a,_mess+9
7382  13b7 a40f          	and	a,#15
7383  13b9 a102          	cp	a,#2
7384  13bb 260b          	jrne	L3033
7385                     ; 1849 			ee_K[4][1]++;
7387  13bd ce002c        	ldw	x,_ee_K+18
7388  13c0 1c0001        	addw	x,#1
7389  13c3 cf002c        	ldw	_ee_K+18,x
7391  13c6 2037          	jra	L5033
7392  13c8               L3033:
7393                     ; 1851 		else if((mess[9]&0x0f)==0x03)
7395  13c8 b6d0          	ld	a,_mess+9
7396  13ca a40f          	and	a,#15
7397  13cc a103          	cp	a,#3
7398  13ce 260b          	jrne	L7033
7399                     ; 1853 			ee_K[4][1]+=10;
7401  13d0 ce002c        	ldw	x,_ee_K+18
7402  13d3 1c000a        	addw	x,#10
7403  13d6 cf002c        	ldw	_ee_K+18,x
7405  13d9 2024          	jra	L5033
7406  13db               L7033:
7407                     ; 1855 		else if((mess[9]&0x0f)==0x04)
7409  13db b6d0          	ld	a,_mess+9
7410  13dd a40f          	and	a,#15
7411  13df a104          	cp	a,#4
7412  13e1 260b          	jrne	L3133
7413                     ; 1857 			ee_K[4][1]--;
7415  13e3 ce002c        	ldw	x,_ee_K+18
7416  13e6 1d0001        	subw	x,#1
7417  13e9 cf002c        	ldw	_ee_K+18,x
7419  13ec 2011          	jra	L5033
7420  13ee               L3133:
7421                     ; 1859 		else if((mess[9]&0x0f)==0x05)
7423  13ee b6d0          	ld	a,_mess+9
7424  13f0 a40f          	and	a,#15
7425  13f2 a105          	cp	a,#5
7426  13f4 2609          	jrne	L5033
7427                     ; 1861 			ee_K[4][1]-=10;
7429  13f6 ce002c        	ldw	x,_ee_K+18
7430  13f9 1d000a        	subw	x,#10
7431  13fc cf002c        	ldw	_ee_K+18,x
7432  13ff               L5033:
7433                     ; 1863 		granee(&ee_K[4][1],10,30000);									
7435  13ff ae7530        	ldw	x,#30000
7436  1402 89            	pushw	x
7437  1403 ae000a        	ldw	x,#10
7438  1406 89            	pushw	x
7439  1407 ae002c        	ldw	x,#_ee_K+18
7440  140a cd00f6        	call	_granee
7442  140d 5b04          	addw	sp,#4
7443  140f               L1023:
7444                     ; 1866 	link_cnt=0;
7446  140f 5f            	clrw	x
7447  1410 bf6b          	ldw	_link_cnt,x
7448                     ; 1867      link=ON;
7450  1412 3555006d      	mov	_link,#85
7451                     ; 1868      if(res_fl_)
7453  1416 725d000a      	tnz	_res_fl_
7454  141a 2603          	jrne	L471
7455  141c cc1714        	jp	L3603
7456  141f               L471:
7457                     ; 1870       	res_fl_=0;
7459  141f 4f            	clr	a
7460  1420 ae000a        	ldw	x,#_res_fl_
7461  1423 cd0000        	call	c_eewrc
7463  1426 ac141714      	jpf	L3603
7464  142a               L3513:
7465                     ; 1876 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7467  142a b6cd          	ld	a,_mess+6
7468  142c a1ff          	cp	a,#255
7469  142e 2703          	jreq	L671
7470  1430 cc14be        	jp	L5233
7471  1433               L671:
7473  1433 b6ce          	ld	a,_mess+7
7474  1435 a1ff          	cp	a,#255
7475  1437 2703          	jreq	L002
7476  1439 cc14be        	jp	L5233
7477  143c               L002:
7479  143c b6cf          	ld	a,_mess+8
7480  143e a162          	cp	a,#98
7481  1440 267c          	jrne	L5233
7482                     ; 1879 	tempSS=mess[9]+(mess[10]*256);
7484  1442 b6d1          	ld	a,_mess+10
7485  1444 5f            	clrw	x
7486  1445 97            	ld	xl,a
7487  1446 4f            	clr	a
7488  1447 02            	rlwa	x,a
7489  1448 01            	rrwa	x,a
7490  1449 bbd0          	add	a,_mess+9
7491  144b 2401          	jrnc	L641
7492  144d 5c            	incw	x
7493  144e               L641:
7494  144e 02            	rlwa	x,a
7495  144f 1f03          	ldw	(OFST-4,sp),x
7496  1451 01            	rrwa	x,a
7497                     ; 1880 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7499  1452 ce0014        	ldw	x,_ee_Umax
7500  1455 1303          	cpw	x,(OFST-4,sp)
7501  1457 270a          	jreq	L7233
7504  1459 1e03          	ldw	x,(OFST-4,sp)
7505  145b 89            	pushw	x
7506  145c ae0014        	ldw	x,#_ee_Umax
7507  145f cd0000        	call	c_eewrw
7509  1462 85            	popw	x
7510  1463               L7233:
7511                     ; 1881 	tempSS=mess[11]+(mess[12]*256);
7513  1463 b6d3          	ld	a,_mess+12
7514  1465 5f            	clrw	x
7515  1466 97            	ld	xl,a
7516  1467 4f            	clr	a
7517  1468 02            	rlwa	x,a
7518  1469 01            	rrwa	x,a
7519  146a bbd2          	add	a,_mess+11
7520  146c 2401          	jrnc	L051
7521  146e 5c            	incw	x
7522  146f               L051:
7523  146f 02            	rlwa	x,a
7524  1470 1f03          	ldw	(OFST-4,sp),x
7525  1472 01            	rrwa	x,a
7526                     ; 1882 	if(ee_dU!=tempSS) ee_dU=tempSS;
7528  1473 ce0012        	ldw	x,_ee_dU
7529  1476 1303          	cpw	x,(OFST-4,sp)
7530  1478 270a          	jreq	L1333
7533  147a 1e03          	ldw	x,(OFST-4,sp)
7534  147c 89            	pushw	x
7535  147d ae0012        	ldw	x,#_ee_dU
7536  1480 cd0000        	call	c_eewrw
7538  1483 85            	popw	x
7539  1484               L1333:
7540                     ; 1883 	if((mess[13]&0x0f)==0x5)
7542  1484 b6d4          	ld	a,_mess+13
7543  1486 a40f          	and	a,#15
7544  1488 a105          	cp	a,#5
7545  148a 261a          	jrne	L3333
7546                     ; 1885 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7548  148c ce0006        	ldw	x,_ee_AVT_MODE
7549  148f a30055        	cpw	x,#85
7550  1492 2603          	jrne	L202
7551  1494 cc1714        	jp	L3603
7552  1497               L202:
7555  1497 ae0055        	ldw	x,#85
7556  149a 89            	pushw	x
7557  149b ae0006        	ldw	x,#_ee_AVT_MODE
7558  149e cd0000        	call	c_eewrw
7560  14a1 85            	popw	x
7561  14a2 ac141714      	jpf	L3603
7562  14a6               L3333:
7563                     ; 1887 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7565  14a6 ce0006        	ldw	x,_ee_AVT_MODE
7566  14a9 a30055        	cpw	x,#85
7567  14ac 2703          	jreq	L402
7568  14ae cc1714        	jp	L3603
7569  14b1               L402:
7572  14b1 5f            	clrw	x
7573  14b2 89            	pushw	x
7574  14b3 ae0006        	ldw	x,#_ee_AVT_MODE
7575  14b6 cd0000        	call	c_eewrw
7577  14b9 85            	popw	x
7578  14ba ac141714      	jpf	L3603
7579  14be               L5233:
7580                     ; 1890 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7582  14be b6cd          	ld	a,_mess+6
7583  14c0 a1ff          	cp	a,#255
7584  14c2 2703          	jreq	L602
7585  14c4 cc157a        	jp	L5433
7586  14c7               L602:
7588  14c7 b6ce          	ld	a,_mess+7
7589  14c9 a1ff          	cp	a,#255
7590  14cb 2703          	jreq	L012
7591  14cd cc157a        	jp	L5433
7592  14d0               L012:
7594  14d0 b6cf          	ld	a,_mess+8
7595  14d2 a126          	cp	a,#38
7596  14d4 2709          	jreq	L7433
7598  14d6 b6cf          	ld	a,_mess+8
7599  14d8 a129          	cp	a,#41
7600  14da 2703          	jreq	L212
7601  14dc cc157a        	jp	L5433
7602  14df               L212:
7603  14df               L7433:
7604                     ; 1893 	tempSS=mess[9]+(mess[10]*256);
7606  14df b6d1          	ld	a,_mess+10
7607  14e1 5f            	clrw	x
7608  14e2 97            	ld	xl,a
7609  14e3 4f            	clr	a
7610  14e4 02            	rlwa	x,a
7611  14e5 01            	rrwa	x,a
7612  14e6 bbd0          	add	a,_mess+9
7613  14e8 2401          	jrnc	L251
7614  14ea 5c            	incw	x
7615  14eb               L251:
7616  14eb 02            	rlwa	x,a
7617  14ec 1f03          	ldw	(OFST-4,sp),x
7618  14ee 01            	rrwa	x,a
7619                     ; 1895 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7621  14ef ce000c        	ldw	x,_ee_UAVT
7622  14f2 1303          	cpw	x,(OFST-4,sp)
7623  14f4 270a          	jreq	L1533
7626  14f6 1e03          	ldw	x,(OFST-4,sp)
7627  14f8 89            	pushw	x
7628  14f9 ae000c        	ldw	x,#_ee_UAVT
7629  14fc cd0000        	call	c_eewrw
7631  14ff 85            	popw	x
7632  1500               L1533:
7633                     ; 1896 	tempSS=(signed short)mess[11];
7635  1500 b6d2          	ld	a,_mess+11
7636  1502 5f            	clrw	x
7637  1503 97            	ld	xl,a
7638  1504 1f03          	ldw	(OFST-4,sp),x
7639                     ; 1897 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7641  1506 ce0010        	ldw	x,_ee_tmax
7642  1509 1303          	cpw	x,(OFST-4,sp)
7643  150b 270a          	jreq	L3533
7646  150d 1e03          	ldw	x,(OFST-4,sp)
7647  150f 89            	pushw	x
7648  1510 ae0010        	ldw	x,#_ee_tmax
7649  1513 cd0000        	call	c_eewrw
7651  1516 85            	popw	x
7652  1517               L3533:
7653                     ; 1898 	tempSS=(signed short)mess[12];
7655  1517 b6d3          	ld	a,_mess+12
7656  1519 5f            	clrw	x
7657  151a 97            	ld	xl,a
7658  151b 1f03          	ldw	(OFST-4,sp),x
7659                     ; 1899 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7661  151d ce000e        	ldw	x,_ee_tsign
7662  1520 1303          	cpw	x,(OFST-4,sp)
7663  1522 270a          	jreq	L5533
7666  1524 1e03          	ldw	x,(OFST-4,sp)
7667  1526 89            	pushw	x
7668  1527 ae000e        	ldw	x,#_ee_tsign
7669  152a cd0000        	call	c_eewrw
7671  152d 85            	popw	x
7672  152e               L5533:
7673                     ; 1902 	if(mess[8]==MEM_KF1)
7675  152e b6cf          	ld	a,_mess+8
7676  1530 a126          	cp	a,#38
7677  1532 260e          	jrne	L7533
7678                     ; 1904 		if(ee_DEVICE!=0)ee_DEVICE=0;
7680  1534 ce0004        	ldw	x,_ee_DEVICE
7681  1537 2709          	jreq	L7533
7684  1539 5f            	clrw	x
7685  153a 89            	pushw	x
7686  153b ae0004        	ldw	x,#_ee_DEVICE
7687  153e cd0000        	call	c_eewrw
7689  1541 85            	popw	x
7690  1542               L7533:
7691                     ; 1907 	if(mess[8]==MEM_KF4)	//MEM_KF4 �������� ������ ���, ��� ����� ������ ���������� ������ � ���, ��������-���������, ������ �� ��� ����
7693  1542 b6cf          	ld	a,_mess+8
7694  1544 a129          	cp	a,#41
7695  1546 2703          	jreq	L412
7696  1548 cc1714        	jp	L3603
7697  154b               L412:
7698                     ; 1909 		if(ee_DEVICE!=1)ee_DEVICE=1;
7700  154b ce0004        	ldw	x,_ee_DEVICE
7701  154e a30001        	cpw	x,#1
7702  1551 270b          	jreq	L5633
7705  1553 ae0001        	ldw	x,#1
7706  1556 89            	pushw	x
7707  1557 ae0004        	ldw	x,#_ee_DEVICE
7708  155a cd0000        	call	c_eewrw
7710  155d 85            	popw	x
7711  155e               L5633:
7712                     ; 1910 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7714  155e b6d4          	ld	a,_mess+13
7715  1560 5f            	clrw	x
7716  1561 97            	ld	xl,a
7717  1562 c30002        	cpw	x,_ee_IMAXVENT
7718  1565 2603          	jrne	L612
7719  1567 cc1714        	jp	L3603
7720  156a               L612:
7723  156a b6d4          	ld	a,_mess+13
7724  156c 5f            	clrw	x
7725  156d 97            	ld	xl,a
7726  156e 89            	pushw	x
7727  156f ae0002        	ldw	x,#_ee_IMAXVENT
7728  1572 cd0000        	call	c_eewrw
7730  1575 85            	popw	x
7731  1576 ac141714      	jpf	L3603
7732  157a               L5433:
7733                     ; 1915 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7735  157a b6cd          	ld	a,_mess+6
7736  157c c100f7        	cp	a,_adress
7737  157f 262d          	jrne	L3733
7739  1581 b6ce          	ld	a,_mess+7
7740  1583 c100f7        	cp	a,_adress
7741  1586 2626          	jrne	L3733
7743  1588 b6cf          	ld	a,_mess+8
7744  158a a116          	cp	a,#22
7745  158c 2620          	jrne	L3733
7747  158e b6d0          	ld	a,_mess+9
7748  1590 a163          	cp	a,#99
7749  1592 261a          	jrne	L3733
7750                     ; 1917 	flags&=0b11100001;
7752  1594 b605          	ld	a,_flags
7753  1596 a4e1          	and	a,#225
7754  1598 b705          	ld	_flags,a
7755                     ; 1918 	tsign_cnt=0;
7757  159a 5f            	clrw	x
7758  159b bf59          	ldw	_tsign_cnt,x
7759                     ; 1919 	tmax_cnt=0;
7761  159d 5f            	clrw	x
7762  159e bf57          	ldw	_tmax_cnt,x
7763                     ; 1920 	umax_cnt=0;
7765  15a0 5f            	clrw	x
7766  15a1 bf70          	ldw	_umax_cnt,x
7767                     ; 1921 	umin_cnt=0;
7769  15a3 5f            	clrw	x
7770  15a4 bf6e          	ldw	_umin_cnt,x
7771                     ; 1922 	led_drv_cnt=30;
7773  15a6 351e0016      	mov	_led_drv_cnt,#30
7775  15aa ac141714      	jpf	L3603
7776  15ae               L3733:
7777                     ; 1925 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7779  15ae b6cd          	ld	a,_mess+6
7780  15b0 c100f7        	cp	a,_adress
7781  15b3 2620          	jrne	L7733
7783  15b5 b6ce          	ld	a,_mess+7
7784  15b7 c100f7        	cp	a,_adress
7785  15ba 2619          	jrne	L7733
7787  15bc b6cf          	ld	a,_mess+8
7788  15be a116          	cp	a,#22
7789  15c0 2613          	jrne	L7733
7791  15c2 b6d0          	ld	a,_mess+9
7792  15c4 a164          	cp	a,#100
7793  15c6 260d          	jrne	L7733
7794                     ; 1927 	vent_resurs=0;
7796  15c8 5f            	clrw	x
7797  15c9 89            	pushw	x
7798  15ca ae0000        	ldw	x,#_vent_resurs
7799  15cd cd0000        	call	c_eewrw
7801  15d0 85            	popw	x
7803  15d1 ac141714      	jpf	L3603
7804  15d5               L7733:
7805                     ; 1931 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7807  15d5 b6cd          	ld	a,_mess+6
7808  15d7 a1ff          	cp	a,#255
7809  15d9 265f          	jrne	L3043
7811  15db b6ce          	ld	a,_mess+7
7812  15dd a1ff          	cp	a,#255
7813  15df 2659          	jrne	L3043
7815  15e1 b6cf          	ld	a,_mess+8
7816  15e3 a116          	cp	a,#22
7817  15e5 2653          	jrne	L3043
7819  15e7 b6d0          	ld	a,_mess+9
7820  15e9 a116          	cp	a,#22
7821  15eb 264d          	jrne	L3043
7822                     ; 1933 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7824  15ed b6d1          	ld	a,_mess+10
7825  15ef a155          	cp	a,#85
7826  15f1 260f          	jrne	L5043
7828  15f3 b6d2          	ld	a,_mess+11
7829  15f5 a155          	cp	a,#85
7830  15f7 2609          	jrne	L5043
7833  15f9 be68          	ldw	x,__x_
7834  15fb 1c0001        	addw	x,#1
7835  15fe bf68          	ldw	__x_,x
7837  1600 2024          	jra	L7043
7838  1602               L5043:
7839                     ; 1934 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7841  1602 b6d1          	ld	a,_mess+10
7842  1604 a166          	cp	a,#102
7843  1606 260f          	jrne	L1143
7845  1608 b6d2          	ld	a,_mess+11
7846  160a a166          	cp	a,#102
7847  160c 2609          	jrne	L1143
7850  160e be68          	ldw	x,__x_
7851  1610 1d0001        	subw	x,#1
7852  1613 bf68          	ldw	__x_,x
7854  1615 200f          	jra	L7043
7855  1617               L1143:
7856                     ; 1935 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7858  1617 b6d1          	ld	a,_mess+10
7859  1619 a177          	cp	a,#119
7860  161b 2609          	jrne	L7043
7862  161d b6d2          	ld	a,_mess+11
7863  161f a177          	cp	a,#119
7864  1621 2603          	jrne	L7043
7867  1623 5f            	clrw	x
7868  1624 bf68          	ldw	__x_,x
7869  1626               L7043:
7870                     ; 1936      gran(&_x_,-XMAX,XMAX);
7872  1626 ae0019        	ldw	x,#25
7873  1629 89            	pushw	x
7874  162a aeffe7        	ldw	x,#65511
7875  162d 89            	pushw	x
7876  162e ae0068        	ldw	x,#__x_
7877  1631 cd00d5        	call	_gran
7879  1634 5b04          	addw	sp,#4
7881  1636 ac141714      	jpf	L3603
7882  163a               L3043:
7883                     ; 1938 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7885  163a b6cd          	ld	a,_mess+6
7886  163c c100f7        	cp	a,_adress
7887  163f 2635          	jrne	L1243
7889  1641 b6ce          	ld	a,_mess+7
7890  1643 c100f7        	cp	a,_adress
7891  1646 262e          	jrne	L1243
7893  1648 b6cf          	ld	a,_mess+8
7894  164a a116          	cp	a,#22
7895  164c 2628          	jrne	L1243
7897  164e b6d0          	ld	a,_mess+9
7898  1650 b1d1          	cp	a,_mess+10
7899  1652 2622          	jrne	L1243
7901  1654 b6d0          	ld	a,_mess+9
7902  1656 a1ee          	cp	a,#238
7903  1658 261c          	jrne	L1243
7904                     ; 1940 	rotor_int++;
7906  165a be17          	ldw	x,_rotor_int
7907  165c 1c0001        	addw	x,#1
7908  165f bf17          	ldw	_rotor_int,x
7909                     ; 1941      tempI=pwm_u;
7911                     ; 1943 	UU_AVT=Un;
7913  1661 ce000e        	ldw	x,_Un
7914  1664 89            	pushw	x
7915  1665 ae0008        	ldw	x,#_UU_AVT
7916  1668 cd0000        	call	c_eewrw
7918  166b 85            	popw	x
7919                     ; 1944 	delay_ms(100);
7921  166c ae0064        	ldw	x,#100
7922  166f cd0121        	call	_delay_ms
7925  1672 ac141714      	jpf	L3603
7926  1676               L1243:
7927                     ; 1950 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7929  1676 b6ce          	ld	a,_mess+7
7930  1678 a1da          	cp	a,#218
7931  167a 2653          	jrne	L5243
7933  167c b6cd          	ld	a,_mess+6
7934  167e c100f7        	cp	a,_adress
7935  1681 274c          	jreq	L5243
7937  1683 b6cd          	ld	a,_mess+6
7938  1685 a106          	cp	a,#6
7939  1687 2446          	jruge	L5243
7940                     ; 1952 	i_main_bps_cnt[mess[6]]=0;
7942  1689 b6cd          	ld	a,_mess+6
7943  168b 5f            	clrw	x
7944  168c 97            	ld	xl,a
7945  168d 6f13          	clr	(_i_main_bps_cnt,x)
7946                     ; 1953 	i_main_flag[mess[6]]=1;
7948  168f b6cd          	ld	a,_mess+6
7949  1691 5f            	clrw	x
7950  1692 97            	ld	xl,a
7951  1693 a601          	ld	a,#1
7952  1695 e71e          	ld	(_i_main_flag,x),a
7953                     ; 1954 	if(bMAIN)
7955                     	btst	_bMAIN
7956  169c 2476          	jruge	L3603
7957                     ; 1956 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7959  169e b6d0          	ld	a,_mess+9
7960  16a0 5f            	clrw	x
7961  16a1 97            	ld	xl,a
7962  16a2 4f            	clr	a
7963  16a3 02            	rlwa	x,a
7964  16a4 1f01          	ldw	(OFST-6,sp),x
7965  16a6 b6cf          	ld	a,_mess+8
7966  16a8 5f            	clrw	x
7967  16a9 97            	ld	xl,a
7968  16aa 72fb01        	addw	x,(OFST-6,sp)
7969  16ad b6cd          	ld	a,_mess+6
7970  16af 905f          	clrw	y
7971  16b1 9097          	ld	yl,a
7972  16b3 9058          	sllw	y
7973  16b5 90ef24        	ldw	(_i_main,y),x
7974                     ; 1957 		i_main[adress]=I;
7976  16b8 c600f7        	ld	a,_adress
7977  16bb 5f            	clrw	x
7978  16bc 97            	ld	xl,a
7979  16bd 58            	sllw	x
7980  16be 90ce0010      	ldw	y,_I
7981  16c2 ef24          	ldw	(_i_main,x),y
7982                     ; 1958      	i_main_flag[adress]=1;
7984  16c4 c600f7        	ld	a,_adress
7985  16c7 5f            	clrw	x
7986  16c8 97            	ld	xl,a
7987  16c9 a601          	ld	a,#1
7988  16cb e71e          	ld	(_i_main_flag,x),a
7989  16cd 2045          	jra	L3603
7990  16cf               L5243:
7991                     ; 1962 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7993  16cf b6ce          	ld	a,_mess+7
7994  16d1 a1db          	cp	a,#219
7995  16d3 263f          	jrne	L3603
7997  16d5 b6cd          	ld	a,_mess+6
7998  16d7 c100f7        	cp	a,_adress
7999  16da 2738          	jreq	L3603
8001  16dc b6cd          	ld	a,_mess+6
8002  16de a106          	cp	a,#6
8003  16e0 2432          	jruge	L3603
8004                     ; 1964 	i_main_bps_cnt[mess[6]]=0;
8006  16e2 b6cd          	ld	a,_mess+6
8007  16e4 5f            	clrw	x
8008  16e5 97            	ld	xl,a
8009  16e6 6f13          	clr	(_i_main_bps_cnt,x)
8010                     ; 1965 	i_main_flag[mess[6]]=1;		
8012  16e8 b6cd          	ld	a,_mess+6
8013  16ea 5f            	clrw	x
8014  16eb 97            	ld	xl,a
8015  16ec a601          	ld	a,#1
8016  16ee e71e          	ld	(_i_main_flag,x),a
8017                     ; 1966 	if(bMAIN)
8019                     	btst	_bMAIN
8020  16f5 241d          	jruge	L3603
8021                     ; 1968 		if(mess[9]==0)i_main_flag[i]=1;
8023  16f7 3dd0          	tnz	_mess+9
8024  16f9 260a          	jrne	L7343
8027  16fb 7b07          	ld	a,(OFST+0,sp)
8028  16fd 5f            	clrw	x
8029  16fe 97            	ld	xl,a
8030  16ff a601          	ld	a,#1
8031  1701 e71e          	ld	(_i_main_flag,x),a
8033  1703 2006          	jra	L1443
8034  1705               L7343:
8035                     ; 1969 		else i_main_flag[i]=0;
8037  1705 7b07          	ld	a,(OFST+0,sp)
8038  1707 5f            	clrw	x
8039  1708 97            	ld	xl,a
8040  1709 6f1e          	clr	(_i_main_flag,x)
8041  170b               L1443:
8042                     ; 1970 		i_main_flag[adress]=1;
8044  170b c600f7        	ld	a,_adress
8045  170e 5f            	clrw	x
8046  170f 97            	ld	xl,a
8047  1710 a601          	ld	a,#1
8048  1712 e71e          	ld	(_i_main_flag,x),a
8049  1714               L3603:
8050                     ; 1976 can_in_an_end:
8050                     ; 1977 bCAN_RX=0;
8052  1714 3f04          	clr	_bCAN_RX
8053                     ; 1978 }   
8056  1716 5b07          	addw	sp,#7
8057  1718 81            	ret
8080                     ; 1981 void t4_init(void){
8081                     	switch	.text
8082  1719               _t4_init:
8086                     ; 1982 	TIM4->PSCR = 4;
8088  1719 35045345      	mov	21317,#4
8089                     ; 1983 	TIM4->ARR= 61;
8091  171d 353d5346      	mov	21318,#61
8092                     ; 1984 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8094  1721 72105341      	bset	21313,#0
8095                     ; 1986 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8097  1725 35855340      	mov	21312,#133
8098                     ; 1988 }
8101  1729 81            	ret
8124                     ; 1991 void t1_init(void)
8124                     ; 1992 {
8125                     	switch	.text
8126  172a               _t1_init:
8130                     ; 1993 TIM1->ARRH= 0x03;
8132  172a 35035262      	mov	21090,#3
8133                     ; 1994 TIM1->ARRL= 0xff;
8135  172e 35ff5263      	mov	21091,#255
8136                     ; 1995 TIM1->CCR1H= 0x00;	
8138  1732 725f5265      	clr	21093
8139                     ; 1996 TIM1->CCR1L= 0xff;
8141  1736 35ff5266      	mov	21094,#255
8142                     ; 1997 TIM1->CCR2H= 0x00;	
8144  173a 725f5267      	clr	21095
8145                     ; 1998 TIM1->CCR2L= 0x00;
8147  173e 725f5268      	clr	21096
8148                     ; 1999 TIM1->CCR3H= 0x00;	
8150  1742 725f5269      	clr	21097
8151                     ; 2000 TIM1->CCR3L= 0x64;
8153  1746 3564526a      	mov	21098,#100
8154                     ; 2002 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8156  174a 35685258      	mov	21080,#104
8157                     ; 2003 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8159  174e 35685259      	mov	21081,#104
8160                     ; 2004 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8162  1752 3568525a      	mov	21082,#104
8163                     ; 2005 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8165  1756 3511525c      	mov	21084,#17
8166                     ; 2006 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8168  175a 3501525d      	mov	21085,#1
8169                     ; 2007 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8171  175e 35815250      	mov	21072,#129
8172                     ; 2008 TIM1->BKR|= TIM1_BKR_AOE;
8174  1762 721c526d      	bset	21101,#6
8175                     ; 2009 }
8178  1766 81            	ret
8203                     ; 2013 void adc2_init(void)
8203                     ; 2014 {
8204                     	switch	.text
8205  1767               _adc2_init:
8209                     ; 2015 adc_plazma[0]++;
8211  1767 beb9          	ldw	x,_adc_plazma
8212  1769 1c0001        	addw	x,#1
8213  176c bfb9          	ldw	_adc_plazma,x
8214                     ; 2039 GPIOB->DDR&=~(1<<4);
8216  176e 72195007      	bres	20487,#4
8217                     ; 2040 GPIOB->CR1&=~(1<<4);
8219  1772 72195008      	bres	20488,#4
8220                     ; 2041 GPIOB->CR2&=~(1<<4);
8222  1776 72195009      	bres	20489,#4
8223                     ; 2043 GPIOB->DDR&=~(1<<5);
8225  177a 721b5007      	bres	20487,#5
8226                     ; 2044 GPIOB->CR1&=~(1<<5);
8228  177e 721b5008      	bres	20488,#5
8229                     ; 2045 GPIOB->CR2&=~(1<<5);
8231  1782 721b5009      	bres	20489,#5
8232                     ; 2047 GPIOB->DDR&=~(1<<6);
8234  1786 721d5007      	bres	20487,#6
8235                     ; 2048 GPIOB->CR1&=~(1<<6);
8237  178a 721d5008      	bres	20488,#6
8238                     ; 2049 GPIOB->CR2&=~(1<<6);
8240  178e 721d5009      	bres	20489,#6
8241                     ; 2051 GPIOB->DDR&=~(1<<7);
8243  1792 721f5007      	bres	20487,#7
8244                     ; 2052 GPIOB->CR1&=~(1<<7);
8246  1796 721f5008      	bres	20488,#7
8247                     ; 2053 GPIOB->CR2&=~(1<<7);
8249  179a 721f5009      	bres	20489,#7
8250                     ; 2055 GPIOB->DDR&=~(1<<2);
8252  179e 72155007      	bres	20487,#2
8253                     ; 2056 GPIOB->CR1&=~(1<<2);
8255  17a2 72155008      	bres	20488,#2
8256                     ; 2057 GPIOB->CR2&=~(1<<2);
8258  17a6 72155009      	bres	20489,#2
8259                     ; 2066 ADC2->TDRL=0xff;
8261  17aa 35ff5407      	mov	21511,#255
8262                     ; 2068 ADC2->CR2=0x08;
8264  17ae 35085402      	mov	21506,#8
8265                     ; 2069 ADC2->CR1=0x40;
8267  17b2 35405401      	mov	21505,#64
8268                     ; 2072 	if(adc_ch==5)ADC2->CSR=0x22;
8270  17b6 b6c6          	ld	a,_adc_ch
8271  17b8 a105          	cp	a,#5
8272  17ba 2606          	jrne	L3743
8275  17bc 35225400      	mov	21504,#34
8277  17c0 2007          	jra	L5743
8278  17c2               L3743:
8279                     ; 2073 	else ADC2->CSR=0x20+adc_ch+3;
8281  17c2 b6c6          	ld	a,_adc_ch
8282  17c4 ab23          	add	a,#35
8283  17c6 c75400        	ld	21504,a
8284  17c9               L5743:
8285                     ; 2075 	ADC2->CR1|=1;
8287  17c9 72105401      	bset	21505,#0
8288                     ; 2076 	ADC2->CR1|=1;
8290  17cd 72105401      	bset	21505,#0
8291                     ; 2079 adc_plazma[1]=adc_ch;
8293  17d1 b6c6          	ld	a,_adc_ch
8294  17d3 5f            	clrw	x
8295  17d4 97            	ld	xl,a
8296  17d5 bfbb          	ldw	_adc_plazma+2,x
8297                     ; 2080 }
8300  17d7 81            	ret
8336                     ; 2088 @far @interrupt void TIM4_UPD_Interrupt (void) 
8336                     ; 2089 {
8338                     	switch	.text
8339  17d8               f_TIM4_UPD_Interrupt:
8343                     ; 2090 TIM4->SR1&=~TIM4_SR1_UIF;
8345  17d8 72115342      	bres	21314,#0
8346                     ; 2092 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8348  17dc 3c12          	inc	_pwm_vent_cnt
8349  17de b612          	ld	a,_pwm_vent_cnt
8350  17e0 a10a          	cp	a,#10
8351  17e2 2502          	jrult	L7053
8354  17e4 3f12          	clr	_pwm_vent_cnt
8355  17e6               L7053:
8356                     ; 2093 GPIOB->ODR|=(1<<3);
8358  17e6 72165005      	bset	20485,#3
8359                     ; 2094 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8361  17ea b612          	ld	a,_pwm_vent_cnt
8362  17ec a105          	cp	a,#5
8363  17ee 2504          	jrult	L1153
8366  17f0 72175005      	bres	20485,#3
8367  17f4               L1153:
8368                     ; 2098 if(++t0_cnt00>=10)
8370  17f4 9c            	rvf
8371  17f5 ce0000        	ldw	x,_t0_cnt00
8372  17f8 1c0001        	addw	x,#1
8373  17fb cf0000        	ldw	_t0_cnt00,x
8374  17fe a3000a        	cpw	x,#10
8375  1801 2f08          	jrslt	L3153
8376                     ; 2100 	t0_cnt00=0;
8378  1803 5f            	clrw	x
8379  1804 cf0000        	ldw	_t0_cnt00,x
8380                     ; 2101 	b1000Hz=1;
8382  1807 72100004      	bset	_b1000Hz
8383  180b               L3153:
8384                     ; 2104 if(++t0_cnt0>=100)
8386  180b 9c            	rvf
8387  180c ce0002        	ldw	x,_t0_cnt0
8388  180f 1c0001        	addw	x,#1
8389  1812 cf0002        	ldw	_t0_cnt0,x
8390  1815 a30064        	cpw	x,#100
8391  1818 2f54          	jrslt	L5153
8392                     ; 2106 	t0_cnt0=0;
8394  181a 5f            	clrw	x
8395  181b cf0002        	ldw	_t0_cnt0,x
8396                     ; 2107 	b100Hz=1;
8398  181e 72100009      	bset	_b100Hz
8399                     ; 2109 	if(++t0_cnt1>=10)
8401  1822 725c0004      	inc	_t0_cnt1
8402  1826 c60004        	ld	a,_t0_cnt1
8403  1829 a10a          	cp	a,#10
8404  182b 2508          	jrult	L7153
8405                     ; 2111 		t0_cnt1=0;
8407  182d 725f0004      	clr	_t0_cnt1
8408                     ; 2112 		b10Hz=1;
8410  1831 72100008      	bset	_b10Hz
8411  1835               L7153:
8412                     ; 2115 	if(++t0_cnt2>=20)
8414  1835 725c0005      	inc	_t0_cnt2
8415  1839 c60005        	ld	a,_t0_cnt2
8416  183c a114          	cp	a,#20
8417  183e 2508          	jrult	L1253
8418                     ; 2117 		t0_cnt2=0;
8420  1840 725f0005      	clr	_t0_cnt2
8421                     ; 2118 		b5Hz=1;
8423  1844 72100007      	bset	_b5Hz
8424  1848               L1253:
8425                     ; 2122 	if(++t0_cnt4>=50)
8427  1848 725c0007      	inc	_t0_cnt4
8428  184c c60007        	ld	a,_t0_cnt4
8429  184f a132          	cp	a,#50
8430  1851 2508          	jrult	L3253
8431                     ; 2124 		t0_cnt4=0;
8433  1853 725f0007      	clr	_t0_cnt4
8434                     ; 2125 		b2Hz=1;
8436  1857 72100006      	bset	_b2Hz
8437  185b               L3253:
8438                     ; 2128 	if(++t0_cnt3>=100)
8440  185b 725c0006      	inc	_t0_cnt3
8441  185f c60006        	ld	a,_t0_cnt3
8442  1862 a164          	cp	a,#100
8443  1864 2508          	jrult	L5153
8444                     ; 2130 		t0_cnt3=0;
8446  1866 725f0006      	clr	_t0_cnt3
8447                     ; 2131 		b1Hz=1;
8449  186a 72100005      	bset	_b1Hz
8450  186e               L5153:
8451                     ; 2137 }
8454  186e 80            	iret
8479                     ; 2140 @far @interrupt void CAN_RX_Interrupt (void) 
8479                     ; 2141 {
8480                     	switch	.text
8481  186f               f_CAN_RX_Interrupt:
8485                     ; 2143 CAN->PSR= 7;									// page 7 - read messsage
8487  186f 35075427      	mov	21543,#7
8488                     ; 2145 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8490  1873 ae000e        	ldw	x,#14
8491  1876               L232:
8492  1876 d65427        	ld	a,(21543,x)
8493  1879 e7c6          	ld	(_mess-1,x),a
8494  187b 5a            	decw	x
8495  187c 26f8          	jrne	L232
8496                     ; 2156 bCAN_RX=1;
8498  187e 35010004      	mov	_bCAN_RX,#1
8499                     ; 2157 CAN->RFR|=(1<<5);
8501  1882 721a5424      	bset	21540,#5
8502                     ; 2159 }
8505  1886 80            	iret
8528                     ; 2162 @far @interrupt void CAN_TX_Interrupt (void) 
8528                     ; 2163 {
8529                     	switch	.text
8530  1887               f_CAN_TX_Interrupt:
8534                     ; 2164 if((CAN->TSR)&(1<<0))
8536  1887 c65422        	ld	a,21538
8537  188a a501          	bcp	a,#1
8538  188c 2708          	jreq	L7453
8539                     ; 2166 	bTX_FREE=1;	
8541  188e 35010003      	mov	_bTX_FREE,#1
8542                     ; 2168 	CAN->TSR|=(1<<0);
8544  1892 72105422      	bset	21538,#0
8545  1896               L7453:
8546                     ; 2170 }
8549  1896 80            	iret
8629                     ; 2173 @far @interrupt void ADC2_EOC_Interrupt (void) {
8630                     	switch	.text
8631  1897               f_ADC2_EOC_Interrupt:
8633       0000000d      OFST:	set	13
8634  1897 be00          	ldw	x,c_x
8635  1899 89            	pushw	x
8636  189a be00          	ldw	x,c_y
8637  189c 89            	pushw	x
8638  189d be02          	ldw	x,c_lreg+2
8639  189f 89            	pushw	x
8640  18a0 be00          	ldw	x,c_lreg
8641  18a2 89            	pushw	x
8642  18a3 520d          	subw	sp,#13
8645                     ; 2178 adc_plazma[2]++;
8647  18a5 bebd          	ldw	x,_adc_plazma+4
8648  18a7 1c0001        	addw	x,#1
8649  18aa bfbd          	ldw	_adc_plazma+4,x
8650                     ; 2185 ADC2->CSR&=~(1<<7);
8652  18ac 721f5400      	bres	21504,#7
8653                     ; 2187 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8655  18b0 c65405        	ld	a,21509
8656  18b3 b703          	ld	c_lreg+3,a
8657  18b5 3f02          	clr	c_lreg+2
8658  18b7 3f01          	clr	c_lreg+1
8659  18b9 3f00          	clr	c_lreg
8660  18bb 96            	ldw	x,sp
8661  18bc 1c0001        	addw	x,#OFST-12
8662  18bf cd0000        	call	c_rtol
8664  18c2 c65404        	ld	a,21508
8665  18c5 5f            	clrw	x
8666  18c6 97            	ld	xl,a
8667  18c7 90ae0100      	ldw	y,#256
8668  18cb cd0000        	call	c_umul
8670  18ce 96            	ldw	x,sp
8671  18cf 1c0001        	addw	x,#OFST-12
8672  18d2 cd0000        	call	c_ladd
8674  18d5 96            	ldw	x,sp
8675  18d6 1c000a        	addw	x,#OFST-3
8676  18d9 cd0000        	call	c_rtol
8678                     ; 2192 if(adr_drv_stat==1)
8680  18dc b602          	ld	a,_adr_drv_stat
8681  18de a101          	cp	a,#1
8682  18e0 260b          	jrne	L7063
8683                     ; 2194 	adr_drv_stat=2;
8685  18e2 35020002      	mov	_adr_drv_stat,#2
8686                     ; 2195 	adc_buff_[0]=temp_adc;
8688  18e6 1e0c          	ldw	x,(OFST-1,sp)
8689  18e8 cf00ff        	ldw	_adc_buff_,x
8691  18eb 2020          	jra	L1163
8692  18ed               L7063:
8693                     ; 2198 else if(adr_drv_stat==3)
8695  18ed b602          	ld	a,_adr_drv_stat
8696  18ef a103          	cp	a,#3
8697  18f1 260b          	jrne	L3163
8698                     ; 2200 	adr_drv_stat=4;
8700  18f3 35040002      	mov	_adr_drv_stat,#4
8701                     ; 2201 	adc_buff_[1]=temp_adc;
8703  18f7 1e0c          	ldw	x,(OFST-1,sp)
8704  18f9 cf0101        	ldw	_adc_buff_+2,x
8706  18fc 200f          	jra	L1163
8707  18fe               L3163:
8708                     ; 2204 else if(adr_drv_stat==5)
8710  18fe b602          	ld	a,_adr_drv_stat
8711  1900 a105          	cp	a,#5
8712  1902 2609          	jrne	L1163
8713                     ; 2206 	adr_drv_stat=6;
8715  1904 35060002      	mov	_adr_drv_stat,#6
8716                     ; 2207 	adc_buff_[9]=temp_adc;
8718  1908 1e0c          	ldw	x,(OFST-1,sp)
8719  190a cf0111        	ldw	_adc_buff_+18,x
8720  190d               L1163:
8721                     ; 2210 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8723  190d b6b7          	ld	a,_adc_cnt_cnt
8724  190f 5f            	clrw	x
8725  1910 97            	ld	xl,a
8726  1911 58            	sllw	x
8727  1912 1f03          	ldw	(OFST-10,sp),x
8728  1914 b6c6          	ld	a,_adc_ch
8729  1916 97            	ld	xl,a
8730  1917 a610          	ld	a,#16
8731  1919 42            	mul	x,a
8732  191a 72fb03        	addw	x,(OFST-10,sp)
8733  191d 160c          	ldw	y,(OFST-1,sp)
8734  191f df0056        	ldw	(_adc_buff_buff,x),y
8735                     ; 2212 adc_ch++;
8737  1922 3cc6          	inc	_adc_ch
8738                     ; 2213 if(adc_ch>=6)
8740  1924 b6c6          	ld	a,_adc_ch
8741  1926 a106          	cp	a,#6
8742  1928 2516          	jrult	L1263
8743                     ; 2215 	adc_ch=0;
8745  192a 3fc6          	clr	_adc_ch
8746                     ; 2216 	adc_cnt_cnt++;
8748  192c 3cb7          	inc	_adc_cnt_cnt
8749                     ; 2217 	if(adc_cnt_cnt>=8)
8751  192e b6b7          	ld	a,_adc_cnt_cnt
8752  1930 a108          	cp	a,#8
8753  1932 250c          	jrult	L1263
8754                     ; 2219 		adc_cnt_cnt=0;
8756  1934 3fb7          	clr	_adc_cnt_cnt
8757                     ; 2220 		adc_cnt++;
8759  1936 3cc5          	inc	_adc_cnt
8760                     ; 2221 		if(adc_cnt>=16)
8762  1938 b6c5          	ld	a,_adc_cnt
8763  193a a110          	cp	a,#16
8764  193c 2502          	jrult	L1263
8765                     ; 2223 			adc_cnt=0;
8767  193e 3fc5          	clr	_adc_cnt
8768  1940               L1263:
8769                     ; 2227 if(adc_cnt_cnt==0)
8771  1940 3db7          	tnz	_adc_cnt_cnt
8772  1942 2660          	jrne	L7263
8773                     ; 2231 	tempSS=0;
8775  1944 ae0000        	ldw	x,#0
8776  1947 1f07          	ldw	(OFST-6,sp),x
8777  1949 ae0000        	ldw	x,#0
8778  194c 1f05          	ldw	(OFST-8,sp),x
8779                     ; 2232 	for(i=0;i<8;i++)
8781  194e 0f09          	clr	(OFST-4,sp)
8782  1950               L1363:
8783                     ; 2234 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8785  1950 7b09          	ld	a,(OFST-4,sp)
8786  1952 5f            	clrw	x
8787  1953 97            	ld	xl,a
8788  1954 58            	sllw	x
8789  1955 1f03          	ldw	(OFST-10,sp),x
8790  1957 b6c6          	ld	a,_adc_ch
8791  1959 97            	ld	xl,a
8792  195a a610          	ld	a,#16
8793  195c 42            	mul	x,a
8794  195d 72fb03        	addw	x,(OFST-10,sp)
8795  1960 de0056        	ldw	x,(_adc_buff_buff,x)
8796  1963 cd0000        	call	c_itolx
8798  1966 96            	ldw	x,sp
8799  1967 1c0005        	addw	x,#OFST-8
8800  196a cd0000        	call	c_lgadd
8802                     ; 2232 	for(i=0;i<8;i++)
8804  196d 0c09          	inc	(OFST-4,sp)
8807  196f 7b09          	ld	a,(OFST-4,sp)
8808  1971 a108          	cp	a,#8
8809  1973 25db          	jrult	L1363
8810                     ; 2236 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8812  1975 96            	ldw	x,sp
8813  1976 1c0005        	addw	x,#OFST-8
8814  1979 cd0000        	call	c_ltor
8816  197c a603          	ld	a,#3
8817  197e cd0000        	call	c_lrsh
8819  1981 be02          	ldw	x,c_lreg+2
8820  1983 b6c5          	ld	a,_adc_cnt
8821  1985 905f          	clrw	y
8822  1987 9097          	ld	yl,a
8823  1989 9058          	sllw	y
8824  198b 1703          	ldw	(OFST-10,sp),y
8825  198d b6c6          	ld	a,_adc_ch
8826  198f 905f          	clrw	y
8827  1991 9097          	ld	yl,a
8828  1993 9058          	sllw	y
8829  1995 9058          	sllw	y
8830  1997 9058          	sllw	y
8831  1999 9058          	sllw	y
8832  199b 9058          	sllw	y
8833  199d 72f903        	addw	y,(OFST-10,sp)
8834  19a0 90df0113      	ldw	(_adc_buff,y),x
8835  19a4               L7263:
8836                     ; 2240 if((adc_cnt&0x03)==0)
8838  19a4 b6c5          	ld	a,_adc_cnt
8839  19a6 a503          	bcp	a,#3
8840  19a8 264b          	jrne	L7363
8841                     ; 2244 	tempSS=0;
8843  19aa ae0000        	ldw	x,#0
8844  19ad 1f07          	ldw	(OFST-6,sp),x
8845  19af ae0000        	ldw	x,#0
8846  19b2 1f05          	ldw	(OFST-8,sp),x
8847                     ; 2245 	for(i=0;i<16;i++)
8849  19b4 0f09          	clr	(OFST-4,sp)
8850  19b6               L1463:
8851                     ; 2247 		tempSS+=(signed long)adc_buff[adc_ch][i];
8853  19b6 7b09          	ld	a,(OFST-4,sp)
8854  19b8 5f            	clrw	x
8855  19b9 97            	ld	xl,a
8856  19ba 58            	sllw	x
8857  19bb 1f03          	ldw	(OFST-10,sp),x
8858  19bd b6c6          	ld	a,_adc_ch
8859  19bf 97            	ld	xl,a
8860  19c0 a620          	ld	a,#32
8861  19c2 42            	mul	x,a
8862  19c3 72fb03        	addw	x,(OFST-10,sp)
8863  19c6 de0113        	ldw	x,(_adc_buff,x)
8864  19c9 cd0000        	call	c_itolx
8866  19cc 96            	ldw	x,sp
8867  19cd 1c0005        	addw	x,#OFST-8
8868  19d0 cd0000        	call	c_lgadd
8870                     ; 2245 	for(i=0;i<16;i++)
8872  19d3 0c09          	inc	(OFST-4,sp)
8875  19d5 7b09          	ld	a,(OFST-4,sp)
8876  19d7 a110          	cp	a,#16
8877  19d9 25db          	jrult	L1463
8878                     ; 2249 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8880  19db 96            	ldw	x,sp
8881  19dc 1c0005        	addw	x,#OFST-8
8882  19df cd0000        	call	c_ltor
8884  19e2 a604          	ld	a,#4
8885  19e4 cd0000        	call	c_lrsh
8887  19e7 be02          	ldw	x,c_lreg+2
8888  19e9 b6c6          	ld	a,_adc_ch
8889  19eb 905f          	clrw	y
8890  19ed 9097          	ld	yl,a
8891  19ef 9058          	sllw	y
8892  19f1 90df00ff      	ldw	(_adc_buff_,y),x
8893  19f5               L7363:
8894                     ; 2256 if(adc_ch==0)adc_buff_5=temp_adc;
8896  19f5 3dc6          	tnz	_adc_ch
8897  19f7 2605          	jrne	L7463
8900  19f9 1e0c          	ldw	x,(OFST-1,sp)
8901  19fb cf00fd        	ldw	_adc_buff_5,x
8902  19fe               L7463:
8903                     ; 2257 if(adc_ch==2)adc_buff_1=temp_adc;
8905  19fe b6c6          	ld	a,_adc_ch
8906  1a00 a102          	cp	a,#2
8907  1a02 2605          	jrne	L1563
8910  1a04 1e0c          	ldw	x,(OFST-1,sp)
8911  1a06 cf00fb        	ldw	_adc_buff_1,x
8912  1a09               L1563:
8913                     ; 2259 adc_plazma_short++;
8915  1a09 bec3          	ldw	x,_adc_plazma_short
8916  1a0b 1c0001        	addw	x,#1
8917  1a0e bfc3          	ldw	_adc_plazma_short,x
8918                     ; 2261 }
8921  1a10 5b0d          	addw	sp,#13
8922  1a12 85            	popw	x
8923  1a13 bf00          	ldw	c_lreg,x
8924  1a15 85            	popw	x
8925  1a16 bf02          	ldw	c_lreg+2,x
8926  1a18 85            	popw	x
8927  1a19 bf00          	ldw	c_y,x
8928  1a1b 85            	popw	x
8929  1a1c bf00          	ldw	c_x,x
8930  1a1e 80            	iret
8988                     ; 2270 main()
8988                     ; 2271 {
8990                     	switch	.text
8991  1a1f               _main:
8995                     ; 2273 CLK->ECKR|=1;
8997  1a1f 721050c1      	bset	20673,#0
8999  1a23               L5663:
9000                     ; 2274 while((CLK->ECKR & 2) == 0);
9002  1a23 c650c1        	ld	a,20673
9003  1a26 a502          	bcp	a,#2
9004  1a28 27f9          	jreq	L5663
9005                     ; 2275 CLK->SWCR|=2;
9007  1a2a 721250c5      	bset	20677,#1
9008                     ; 2276 CLK->SWR=0xB4;
9010  1a2e 35b450c4      	mov	20676,#180
9011                     ; 2278 delay_ms(200);
9013  1a32 ae00c8        	ldw	x,#200
9014  1a35 cd0121        	call	_delay_ms
9016                     ; 2279 FLASH_DUKR=0xae;
9018  1a38 35ae5064      	mov	_FLASH_DUKR,#174
9019                     ; 2280 FLASH_DUKR=0x56;
9021  1a3c 35565064      	mov	_FLASH_DUKR,#86
9022                     ; 2281 enableInterrupts();
9025  1a40 9a            rim
9027                     ; 2284 adr_drv_v3();
9030  1a41 cd0d1f        	call	_adr_drv_v3
9032                     ; 2288 t4_init();
9034  1a44 cd1719        	call	_t4_init
9036                     ; 2290 		GPIOG->DDR|=(1<<0);
9038  1a47 72105020      	bset	20512,#0
9039                     ; 2291 		GPIOG->CR1|=(1<<0);
9041  1a4b 72105021      	bset	20513,#0
9042                     ; 2292 		GPIOG->CR2&=~(1<<0);	
9044  1a4f 72115022      	bres	20514,#0
9045                     ; 2295 		GPIOG->DDR&=~(1<<1);
9047  1a53 72135020      	bres	20512,#1
9048                     ; 2296 		GPIOG->CR1|=(1<<1);
9050  1a57 72125021      	bset	20513,#1
9051                     ; 2297 		GPIOG->CR2&=~(1<<1);
9053  1a5b 72135022      	bres	20514,#1
9054                     ; 2299 init_CAN();
9056  1a5f cd0f0f        	call	_init_CAN
9058                     ; 2304 GPIOC->DDR|=(1<<1);
9060  1a62 7212500c      	bset	20492,#1
9061                     ; 2305 GPIOC->CR1|=(1<<1);
9063  1a66 7212500d      	bset	20493,#1
9064                     ; 2306 GPIOC->CR2|=(1<<1);
9066  1a6a 7212500e      	bset	20494,#1
9067                     ; 2308 GPIOC->DDR|=(1<<2);
9069  1a6e 7214500c      	bset	20492,#2
9070                     ; 2309 GPIOC->CR1|=(1<<2);
9072  1a72 7214500d      	bset	20493,#2
9073                     ; 2310 GPIOC->CR2|=(1<<2);
9075  1a76 7214500e      	bset	20494,#2
9076                     ; 2317 t1_init();
9078  1a7a cd172a        	call	_t1_init
9080                     ; 2319 GPIOA->DDR|=(1<<5);
9082  1a7d 721a5002      	bset	20482,#5
9083                     ; 2320 GPIOA->CR1|=(1<<5);
9085  1a81 721a5003      	bset	20483,#5
9086                     ; 2321 GPIOA->CR2&=~(1<<5);
9088  1a85 721b5004      	bres	20484,#5
9089                     ; 2327 GPIOB->DDR&=~(1<<3);
9091  1a89 72175007      	bres	20487,#3
9092                     ; 2328 GPIOB->CR1&=~(1<<3);
9094  1a8d 72175008      	bres	20488,#3
9095                     ; 2329 GPIOB->CR2&=~(1<<3);
9097  1a91 72175009      	bres	20489,#3
9098                     ; 2331 GPIOC->DDR|=(1<<3);
9100  1a95 7216500c      	bset	20492,#3
9101                     ; 2332 GPIOC->CR1|=(1<<3);
9103  1a99 7216500d      	bset	20493,#3
9104                     ; 2333 GPIOC->CR2|=(1<<3);
9106  1a9d 7216500e      	bset	20494,#3
9107  1aa1               L1763:
9108                     ; 2339 	if(b1000Hz)
9110                     	btst	_b1000Hz
9111  1aa6 2407          	jruge	L5763
9112                     ; 2341 		b1000Hz=0;
9114  1aa8 72110004      	bres	_b1000Hz
9115                     ; 2343 		adc2_init();
9117  1aac cd1767        	call	_adc2_init
9119  1aaf               L5763:
9120                     ; 2346 	if(bCAN_RX)
9122  1aaf 3d04          	tnz	_bCAN_RX
9123  1ab1 2705          	jreq	L7763
9124                     ; 2348 		bCAN_RX=0;
9126  1ab3 3f04          	clr	_bCAN_RX
9127                     ; 2349 		can_in_an();	
9129  1ab5 cd106c        	call	_can_in_an
9131  1ab8               L7763:
9132                     ; 2351 	if(b100Hz)
9134                     	btst	_b100Hz
9135  1abd 2407          	jruge	L1073
9136                     ; 2353 		b100Hz=0;
9138  1abf 72110009      	bres	_b100Hz
9139                     ; 2363 		can_tx_hndl();
9141  1ac3 cd1002        	call	_can_tx_hndl
9143  1ac6               L1073:
9144                     ; 2366 	if(b10Hz)
9146                     	btst	_b10Hz
9147  1acb 2425          	jruge	L3073
9148                     ; 2368 		b10Hz=0;
9150  1acd 72110008      	bres	_b10Hz
9151                     ; 2370 		matemat();
9153  1ad1 cd0850        	call	_matemat
9155                     ; 2371 		led_drv(); 
9157  1ad4 cd03ee        	call	_led_drv
9159                     ; 2372 	  link_drv();
9161  1ad7 cd04dc        	call	_link_drv
9163                     ; 2374 	  JP_drv();
9165  1ada cd0451        	call	_JP_drv
9167                     ; 2375 	  flags_drv();
9169  1add cd0cd4        	call	_flags_drv
9171                     ; 2377 		if(main_cnt10<100)main_cnt10++;
9173  1ae0 9c            	rvf
9174  1ae1 ce0253        	ldw	x,_main_cnt10
9175  1ae4 a30064        	cpw	x,#100
9176  1ae7 2e09          	jrsge	L3073
9179  1ae9 ce0253        	ldw	x,_main_cnt10
9180  1aec 1c0001        	addw	x,#1
9181  1aef cf0253        	ldw	_main_cnt10,x
9182  1af2               L3073:
9183                     ; 2380 	if(b5Hz)
9185                     	btst	_b5Hz
9186  1af7 241c          	jruge	L7073
9187                     ; 2382 		b5Hz=0;
9189  1af9 72110007      	bres	_b5Hz
9190                     ; 2384 		pwr_drv();		//����������� �� ����
9192  1afd cd06ac        	call	_pwr_drv
9194                     ; 2385 		led_hndl();
9196  1b00 cd0163        	call	_led_hndl
9198                     ; 2387 		vent_drv();
9200  1b03 cd0534        	call	_vent_drv
9202                     ; 2389 		if(main_cnt1<1000)main_cnt1++;
9204  1b06 9c            	rvf
9205  1b07 be5b          	ldw	x,_main_cnt1
9206  1b09 a303e8        	cpw	x,#1000
9207  1b0c 2e07          	jrsge	L7073
9210  1b0e be5b          	ldw	x,_main_cnt1
9211  1b10 1c0001        	addw	x,#1
9212  1b13 bf5b          	ldw	_main_cnt1,x
9213  1b15               L7073:
9214                     ; 2392 	if(b2Hz)
9216                     	btst	_b2Hz
9217  1b1a 2404          	jruge	L3173
9218                     ; 2394 		b2Hz=0;
9220  1b1c 72110006      	bres	_b2Hz
9221  1b20               L3173:
9222                     ; 2403 	if(b1Hz)
9224                     	btst	_b1Hz
9225  1b25 2503cc1aa1    	jruge	L1763
9226                     ; 2405 		b1Hz=0;
9228  1b2a 72110005      	bres	_b1Hz
9229                     ; 2407 	  pwr_hndl();		//���������� ����������� �� ����
9231  1b2e cd06f1        	call	_pwr_hndl
9233                     ; 2408 		temper_drv();			//���������� ������ �����������
9235  1b31 cd0a41        	call	_temper_drv
9237                     ; 2409 		u_drv();
9239  1b34 cd0b18        	call	_u_drv
9241                     ; 2411 		if(main_cnt<1000)main_cnt++;
9243  1b37 9c            	rvf
9244  1b38 ce0255        	ldw	x,_main_cnt
9245  1b3b a303e8        	cpw	x,#1000
9246  1b3e 2e09          	jrsge	L7173
9249  1b40 ce0255        	ldw	x,_main_cnt
9250  1b43 1c0001        	addw	x,#1
9251  1b46 cf0255        	ldw	_main_cnt,x
9252  1b49               L7173:
9253                     ; 2412   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9255  1b49 b66d          	ld	a,_link
9256  1b4b a1aa          	cp	a,#170
9257  1b4d 2706          	jreq	L3273
9259  1b4f b654          	ld	a,_jp_mode
9260  1b51 a103          	cp	a,#3
9261  1b53 2603          	jrne	L1273
9262  1b55               L3273:
9265  1b55 cd0c35        	call	_apv_hndl
9267  1b58               L1273:
9268                     ; 2415   		can_error_cnt++;
9270  1b58 3c73          	inc	_can_error_cnt
9271                     ; 2416   		if(can_error_cnt>=10)
9273  1b5a b673          	ld	a,_can_error_cnt
9274  1b5c a10a          	cp	a,#10
9275  1b5e 2505          	jrult	L5273
9276                     ; 2418   			can_error_cnt=0;
9278  1b60 3f73          	clr	_can_error_cnt
9279                     ; 2419 				init_CAN();
9281  1b62 cd0f0f        	call	_init_CAN
9283  1b65               L5273:
9284                     ; 2429 		vent_resurs_hndl();
9286  1b65 cd0000        	call	_vent_resurs_hndl
9288  1b68 aca11aa1      	jpf	L1763
10526                     	xdef	_main
10527                     	xdef	f_ADC2_EOC_Interrupt
10528                     	xdef	f_CAN_TX_Interrupt
10529                     	xdef	f_CAN_RX_Interrupt
10530                     	xdef	f_TIM4_UPD_Interrupt
10531                     	xdef	_adc2_init
10532                     	xdef	_t1_init
10533                     	xdef	_t4_init
10534                     	xdef	_can_in_an
10535                     	xdef	_can_tx_hndl
10536                     	xdef	_can_transmit
10537                     	xdef	_init_CAN
10538                     	xdef	_adr_drv_v3
10539                     	xdef	_adr_drv_v4
10540                     	xdef	_flags_drv
10541                     	xdef	_apv_hndl
10542                     	xdef	_apv_stop
10543                     	xdef	_apv_start
10544                     	xdef	_u_drv
10545                     	xdef	_temper_drv
10546                     	xdef	_matemat
10547                     	xdef	_pwr_hndl
10548                     	xdef	_pwr_drv
10549                     	xdef	_vent_drv
10550                     	xdef	_link_drv
10551                     	xdef	_JP_drv
10552                     	xdef	_led_drv
10553                     	xdef	_led_hndl
10554                     	xdef	_delay_ms
10555                     	xdef	_granee
10556                     	xdef	_gran
10557                     	xdef	_vent_resurs_hndl
10558                     	switch	.ubsct
10559  0001               _debug_info_to_uku:
10560  0001 000000000000  	ds.b	6
10561                     	xdef	_debug_info_to_uku
10562  0007               _pwm_u_cnt:
10563  0007 00            	ds.b	1
10564                     	xdef	_pwm_u_cnt
10565  0008               _vent_resurs_tx_cnt:
10566  0008 00            	ds.b	1
10567                     	xdef	_vent_resurs_tx_cnt
10568                     	switch	.bss
10569  0000               _vent_resurs_buff:
10570  0000 00000000      	ds.b	4
10571                     	xdef	_vent_resurs_buff
10572                     	switch	.ubsct
10573  0009               _vent_resurs_sec_cnt:
10574  0009 0000          	ds.b	2
10575                     	xdef	_vent_resurs_sec_cnt
10576                     .eeprom:	section	.data
10577  0000               _vent_resurs:
10578  0000 0000          	ds.b	2
10579                     	xdef	_vent_resurs
10580  0002               _ee_IMAXVENT:
10581  0002 0000          	ds.b	2
10582                     	xdef	_ee_IMAXVENT
10583                     	switch	.ubsct
10584  000b               _bps_class:
10585  000b 00            	ds.b	1
10586                     	xdef	_bps_class
10587  000c               _vent_pwm_integr_cnt:
10588  000c 0000          	ds.b	2
10589                     	xdef	_vent_pwm_integr_cnt
10590  000e               _vent_pwm_integr:
10591  000e 0000          	ds.b	2
10592                     	xdef	_vent_pwm_integr
10593  0010               _vent_pwm:
10594  0010 0000          	ds.b	2
10595                     	xdef	_vent_pwm
10596  0012               _pwm_vent_cnt:
10597  0012 00            	ds.b	1
10598                     	xdef	_pwm_vent_cnt
10599                     	switch	.eeprom
10600  0004               _ee_DEVICE:
10601  0004 0000          	ds.b	2
10602                     	xdef	_ee_DEVICE
10603  0006               _ee_AVT_MODE:
10604  0006 0000          	ds.b	2
10605                     	xdef	_ee_AVT_MODE
10606                     	switch	.ubsct
10607  0013               _i_main_bps_cnt:
10608  0013 000000000000  	ds.b	6
10609                     	xdef	_i_main_bps_cnt
10610  0019               _i_main_sigma:
10611  0019 0000          	ds.b	2
10612                     	xdef	_i_main_sigma
10613  001b               _i_main_num_of_bps:
10614  001b 00            	ds.b	1
10615                     	xdef	_i_main_num_of_bps
10616  001c               _i_main_avg:
10617  001c 0000          	ds.b	2
10618                     	xdef	_i_main_avg
10619  001e               _i_main_flag:
10620  001e 000000000000  	ds.b	6
10621                     	xdef	_i_main_flag
10622  0024               _i_main:
10623  0024 000000000000  	ds.b	12
10624                     	xdef	_i_main
10625  0030               _x:
10626  0030 000000000000  	ds.b	12
10627                     	xdef	_x
10628                     	xdef	_volum_u_main_
10629                     	switch	.eeprom
10630  0008               _UU_AVT:
10631  0008 0000          	ds.b	2
10632                     	xdef	_UU_AVT
10633                     	switch	.ubsct
10634  003c               _cnt_net_drv:
10635  003c 00            	ds.b	1
10636                     	xdef	_cnt_net_drv
10637                     	switch	.bit
10638  0001               _bMAIN:
10639  0001 00            	ds.b	1
10640                     	xdef	_bMAIN
10641                     	switch	.ubsct
10642  003d               _plazma_int:
10643  003d 000000000000  	ds.b	6
10644                     	xdef	_plazma_int
10645                     	xdef	_rotor_int
10646  0043               _led_green_buff:
10647  0043 00000000      	ds.b	4
10648                     	xdef	_led_green_buff
10649  0047               _led_red_buff:
10650  0047 00000000      	ds.b	4
10651                     	xdef	_led_red_buff
10652                     	xdef	_led_drv_cnt
10653                     	xdef	_led_green
10654                     	xdef	_led_red
10655  004b               _res_fl_cnt:
10656  004b 00            	ds.b	1
10657                     	xdef	_res_fl_cnt
10658                     	xdef	_bRES_
10659                     	xdef	_bRES
10660                     	switch	.eeprom
10661  000a               _res_fl_:
10662  000a 00            	ds.b	1
10663                     	xdef	_res_fl_
10664  000b               _res_fl:
10665  000b 00            	ds.b	1
10666                     	xdef	_res_fl
10667                     	switch	.ubsct
10668  004c               _cnt_apv_off:
10669  004c 00            	ds.b	1
10670                     	xdef	_cnt_apv_off
10671                     	switch	.bit
10672  0002               _bAPV:
10673  0002 00            	ds.b	1
10674                     	xdef	_bAPV
10675                     	switch	.ubsct
10676  004d               _apv_cnt_:
10677  004d 0000          	ds.b	2
10678                     	xdef	_apv_cnt_
10679  004f               _apv_cnt:
10680  004f 000000        	ds.b	3
10681                     	xdef	_apv_cnt
10682                     	xdef	_bBL_IPS
10683                     	switch	.bit
10684  0003               _bBL:
10685  0003 00            	ds.b	1
10686                     	xdef	_bBL
10687                     	switch	.ubsct
10688  0052               _cnt_JP1:
10689  0052 00            	ds.b	1
10690                     	xdef	_cnt_JP1
10691  0053               _cnt_JP0:
10692  0053 00            	ds.b	1
10693                     	xdef	_cnt_JP0
10694  0054               _jp_mode:
10695  0054 00            	ds.b	1
10696                     	xdef	_jp_mode
10697  0055               _pwm_u_:
10698  0055 0000          	ds.b	2
10699                     	xdef	_pwm_u_
10700                     	xdef	_pwm_i
10701                     	xdef	_pwm_u
10702  0057               _tmax_cnt:
10703  0057 0000          	ds.b	2
10704                     	xdef	_tmax_cnt
10705  0059               _tsign_cnt:
10706  0059 0000          	ds.b	2
10707                     	xdef	_tsign_cnt
10708                     	switch	.eeprom
10709  000c               _ee_UAVT:
10710  000c 0000          	ds.b	2
10711                     	xdef	_ee_UAVT
10712  000e               _ee_tsign:
10713  000e 0000          	ds.b	2
10714                     	xdef	_ee_tsign
10715  0010               _ee_tmax:
10716  0010 0000          	ds.b	2
10717                     	xdef	_ee_tmax
10718  0012               _ee_dU:
10719  0012 0000          	ds.b	2
10720                     	xdef	_ee_dU
10721  0014               _ee_Umax:
10722  0014 0000          	ds.b	2
10723                     	xdef	_ee_Umax
10724  0016               _ee_TZAS:
10725  0016 0000          	ds.b	2
10726                     	xdef	_ee_TZAS
10727                     	switch	.ubsct
10728  005b               _main_cnt1:
10729  005b 0000          	ds.b	2
10730                     	xdef	_main_cnt1
10731  005d               _off_bp_cnt:
10732  005d 00            	ds.b	1
10733                     	xdef	_off_bp_cnt
10734                     	xdef	_vol_i_temp_avar
10735  005e               _flags_tu_cnt_off:
10736  005e 00            	ds.b	1
10737                     	xdef	_flags_tu_cnt_off
10738  005f               _flags_tu_cnt_on:
10739  005f 00            	ds.b	1
10740                     	xdef	_flags_tu_cnt_on
10741  0060               _vol_i_temp:
10742  0060 0000          	ds.b	2
10743                     	xdef	_vol_i_temp
10744  0062               _vol_u_temp:
10745  0062 0000          	ds.b	2
10746                     	xdef	_vol_u_temp
10747                     	switch	.eeprom
10748  0018               __x_ee_:
10749  0018 0000          	ds.b	2
10750                     	xdef	__x_ee_
10751                     	switch	.ubsct
10752  0064               __x_cnt:
10753  0064 0000          	ds.b	2
10754                     	xdef	__x_cnt
10755  0066               __x__:
10756  0066 0000          	ds.b	2
10757                     	xdef	__x__
10758  0068               __x_:
10759  0068 0000          	ds.b	2
10760                     	xdef	__x_
10761  006a               _flags_tu:
10762  006a 00            	ds.b	1
10763                     	xdef	_flags_tu
10764                     	xdef	_flags
10765  006b               _link_cnt:
10766  006b 0000          	ds.b	2
10767                     	xdef	_link_cnt
10768  006d               _link:
10769  006d 00            	ds.b	1
10770                     	xdef	_link
10771  006e               _umin_cnt:
10772  006e 0000          	ds.b	2
10773                     	xdef	_umin_cnt
10774  0070               _umax_cnt:
10775  0070 0000          	ds.b	2
10776                     	xdef	_umax_cnt
10777                     	switch	.eeprom
10778  001a               _ee_K:
10779  001a 000000000000  	ds.b	20
10780                     	xdef	_ee_K
10781                     	switch	.ubsct
10782  0072               _T:
10783  0072 00            	ds.b	1
10784                     	xdef	_T
10785                     	switch	.bss
10786  0004               _Uin:
10787  0004 0000          	ds.b	2
10788                     	xdef	_Uin
10789  0006               _Usum:
10790  0006 0000          	ds.b	2
10791                     	xdef	_Usum
10792  0008               _U_out_const:
10793  0008 0000          	ds.b	2
10794                     	xdef	_U_out_const
10795  000a               _Unecc:
10796  000a 0000          	ds.b	2
10797                     	xdef	_Unecc
10798  000c               _Ui:
10799  000c 0000          	ds.b	2
10800                     	xdef	_Ui
10801  000e               _Un:
10802  000e 0000          	ds.b	2
10803                     	xdef	_Un
10804  0010               _I:
10805  0010 0000          	ds.b	2
10806                     	xdef	_I
10807                     	switch	.ubsct
10808  0073               _can_error_cnt:
10809  0073 00            	ds.b	1
10810                     	xdef	_can_error_cnt
10811                     	xdef	_bCAN_RX
10812  0074               _tx_busy_cnt:
10813  0074 00            	ds.b	1
10814                     	xdef	_tx_busy_cnt
10815                     	xdef	_bTX_FREE
10816  0075               _can_buff_rd_ptr:
10817  0075 00            	ds.b	1
10818                     	xdef	_can_buff_rd_ptr
10819  0076               _can_buff_wr_ptr:
10820  0076 00            	ds.b	1
10821                     	xdef	_can_buff_wr_ptr
10822  0077               _can_out_buff:
10823  0077 000000000000  	ds.b	64
10824                     	xdef	_can_out_buff
10825                     	switch	.bss
10826  0012               _pwm_u_buff_cnt:
10827  0012 00            	ds.b	1
10828                     	xdef	_pwm_u_buff_cnt
10829  0013               _pwm_u_buff_ptr:
10830  0013 00            	ds.b	1
10831                     	xdef	_pwm_u_buff_ptr
10832  0014               _pwm_u_buff_:
10833  0014 0000          	ds.b	2
10834                     	xdef	_pwm_u_buff_
10835  0016               _pwm_u_buff:
10836  0016 000000000000  	ds.b	64
10837                     	xdef	_pwm_u_buff
10838                     	switch	.ubsct
10839  00b7               _adc_cnt_cnt:
10840  00b7 00            	ds.b	1
10841                     	xdef	_adc_cnt_cnt
10842                     	switch	.bss
10843  0056               _adc_buff_buff:
10844  0056 000000000000  	ds.b	160
10845                     	xdef	_adc_buff_buff
10846  00f6               _adress_error:
10847  00f6 00            	ds.b	1
10848                     	xdef	_adress_error
10849  00f7               _adress:
10850  00f7 00            	ds.b	1
10851                     	xdef	_adress
10852  00f8               _adr:
10853  00f8 000000        	ds.b	3
10854                     	xdef	_adr
10855                     	xdef	_adr_drv_stat
10856                     	xdef	_led_ind
10857                     	switch	.ubsct
10858  00b8               _led_ind_cnt:
10859  00b8 00            	ds.b	1
10860                     	xdef	_led_ind_cnt
10861  00b9               _adc_plazma:
10862  00b9 000000000000  	ds.b	10
10863                     	xdef	_adc_plazma
10864  00c3               _adc_plazma_short:
10865  00c3 0000          	ds.b	2
10866                     	xdef	_adc_plazma_short
10867  00c5               _adc_cnt:
10868  00c5 00            	ds.b	1
10869                     	xdef	_adc_cnt
10870  00c6               _adc_ch:
10871  00c6 00            	ds.b	1
10872                     	xdef	_adc_ch
10873                     	switch	.bss
10874  00fb               _adc_buff_1:
10875  00fb 0000          	ds.b	2
10876                     	xdef	_adc_buff_1
10877  00fd               _adc_buff_5:
10878  00fd 0000          	ds.b	2
10879                     	xdef	_adc_buff_5
10880  00ff               _adc_buff_:
10881  00ff 000000000000  	ds.b	20
10882                     	xdef	_adc_buff_
10883  0113               _adc_buff:
10884  0113 000000000000  	ds.b	320
10885                     	xdef	_adc_buff
10886  0253               _main_cnt10:
10887  0253 0000          	ds.b	2
10888                     	xdef	_main_cnt10
10889  0255               _main_cnt:
10890  0255 0000          	ds.b	2
10891                     	xdef	_main_cnt
10892                     	switch	.ubsct
10893  00c7               _mess:
10894  00c7 000000000000  	ds.b	14
10895                     	xdef	_mess
10896                     	switch	.bit
10897  0004               _b1000Hz:
10898  0004 00            	ds.b	1
10899                     	xdef	_b1000Hz
10900  0005               _b1Hz:
10901  0005 00            	ds.b	1
10902                     	xdef	_b1Hz
10903  0006               _b2Hz:
10904  0006 00            	ds.b	1
10905                     	xdef	_b2Hz
10906  0007               _b5Hz:
10907  0007 00            	ds.b	1
10908                     	xdef	_b5Hz
10909  0008               _b10Hz:
10910  0008 00            	ds.b	1
10911                     	xdef	_b10Hz
10912  0009               _b100Hz:
10913  0009 00            	ds.b	1
10914                     	xdef	_b100Hz
10915                     	xdef	_t0_cnt4
10916                     	xdef	_t0_cnt3
10917                     	xdef	_t0_cnt2
10918                     	xdef	_t0_cnt1
10919                     	xdef	_t0_cnt0
10920                     	xdef	_t0_cnt00
10921                     	xref	_abs
10922                     	xdef	_bVENT_BLOCK
10923                     	xref.b	c_lreg
10924                     	xref.b	c_x
10925                     	xref.b	c_y
10945                     	xref	c_lrsh
10946                     	xref	c_umul
10947                     	xref	c_lgsub
10948                     	xref	c_lgrsh
10949                     	xref	c_lgadd
10950                     	xref	c_idiv
10951                     	xref	c_sdivx
10952                     	xref	c_imul
10953                     	xref	c_lsbc
10954                     	xref	c_ladd
10955                     	xref	c_lsub
10956                     	xref	c_ldiv
10957                     	xref	c_lgmul
10958                     	xref	c_itolx
10959                     	xref	c_eewrc
10960                     	xref	c_ltor
10961                     	xref	c_lgadc
10962                     	xref	c_rtol
10963                     	xref	c_vmul
10964                     	xref	c_eewrw
10965                     	xref	c_lcmp
10966                     	xref	c_uitolx
10967                     	end
