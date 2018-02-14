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
3870                     ; 702 	else vent_pwm_t_necc=(short)(150L+(28L*(tempSL-(((signed long)ee_tsign)-30L))));
3872  060c ce000e        	ldw	x,_ee_tsign
3873  060f 1d001e        	subw	x,#30
3874  0612 1f01          	ldw	(OFST-11,sp),x
3875  0614 1e0b          	ldw	x,(OFST-1,sp)
3876  0616 72f001        	subw	x,(OFST-11,sp)
3877  0619 90ae001c      	ldw	y,#28
3878  061d cd0000        	call	c_imul
3880  0620 1c0096        	addw	x,#150
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
3943                     ; 716 	if(vent_pwm_integr_cnt<10)
3945  066d 9c            	rvf
3946  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3947  0670 a3000a        	cpw	x,#10
3948  0673 2e26          	jrsge	L1312
3949                     ; 718 		vent_pwm_integr_cnt++;
3951  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3952  0677 1c0001        	addw	x,#1
3953  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3954                     ; 719 		if(vent_pwm_integr_cnt>=10)
3956  067c 9c            	rvf
3957  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3958  067f a3000a        	cpw	x,#10
3959  0682 2f17          	jrslt	L1312
3960                     ; 721 			vent_pwm_integr_cnt=0;
3962  0684 5f            	clrw	x
3963  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3964                     ; 722 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3966  0687 be0e          	ldw	x,_vent_pwm_integr
3967  0689 90ae0009      	ldw	y,#9
3968  068d cd0000        	call	c_imul
3970  0690 72bb0010      	addw	x,_vent_pwm
3971  0694 a60a          	ld	a,#10
3972  0696 cd0000        	call	c_sdivx
3974  0699 bf0e          	ldw	_vent_pwm_integr,x
3975  069b               L1312:
3976                     ; 725 	gran(&vent_pwm_integr,0,1000);
3978  069b ae03e8        	ldw	x,#1000
3979  069e 89            	pushw	x
3980  069f 5f            	clrw	x
3981  06a0 89            	pushw	x
3982  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3983  06a4 cd00d5        	call	_gran
3985  06a7 5b04          	addw	sp,#4
3986                     ; 729 }
3989  06a9 5b0c          	addw	sp,#12
3990  06ab 81            	ret
4016                     ; 734 void pwr_drv(void)
4016                     ; 735 {
4017                     	switch	.text
4018  06ac               _pwr_drv:
4022                     ; 806 TIM1->CCR2H= (char)(pwm_u/256);	
4024  06ac be08          	ldw	x,_pwm_u
4025  06ae 90ae0100      	ldw	y,#256
4026  06b2 cd0000        	call	c_idiv
4028  06b5 9f            	ld	a,xl
4029  06b6 c75267        	ld	21095,a
4030                     ; 807 TIM1->CCR2L= (char)pwm_u;
4032  06b9 5500095268    	mov	21096,_pwm_u+1
4033                     ; 809 TIM1->CCR1H= (char)(pwm_i/256);	
4035  06be be0a          	ldw	x,_pwm_i
4036  06c0 90ae0100      	ldw	y,#256
4037  06c4 cd0000        	call	c_idiv
4039  06c7 9f            	ld	a,xl
4040  06c8 c75265        	ld	21093,a
4041                     ; 810 TIM1->CCR1L= (char)pwm_i;
4043  06cb 55000b5266    	mov	21094,_pwm_i+1
4044                     ; 812 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4046  06d0 be0e          	ldw	x,_vent_pwm_integr
4047  06d2 90ae0080      	ldw	y,#128
4048  06d6 cd0000        	call	c_idiv
4050  06d9 9f            	ld	a,xl
4051  06da c75269        	ld	21097,a
4052                     ; 813 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4054  06dd b60f          	ld	a,_vent_pwm_integr+1
4055  06df 48            	sll	a
4056  06e0 c7526a        	ld	21098,a
4057                     ; 814 }
4060  06e3 81            	ret
4118                     	switch	.const
4119  0014               L25:
4120  0014 0000028a      	dc.l	650
4121                     ; 819 void pwr_hndl(void)				
4121                     ; 820 {
4122                     	switch	.text
4123  06e4               _pwr_hndl:
4125  06e4 5205          	subw	sp,#5
4126       00000005      OFST:	set	5
4129                     ; 821 if(jp_mode==jp3)
4131  06e6 b654          	ld	a,_jp_mode
4132  06e8 a103          	cp	a,#3
4133  06ea 260a          	jrne	L7612
4134                     ; 823 	pwm_u=0;
4136  06ec 5f            	clrw	x
4137  06ed bf08          	ldw	_pwm_u,x
4138                     ; 824 	pwm_i=0;
4140  06ef 5f            	clrw	x
4141  06f0 bf0a          	ldw	_pwm_i,x
4143  06f2 ac3f083f      	jpf	L1712
4144  06f6               L7612:
4145                     ; 826 else if(jp_mode==jp2)
4147  06f6 b654          	ld	a,_jp_mode
4148  06f8 a102          	cp	a,#2
4149  06fa 260c          	jrne	L3712
4150                     ; 828 	pwm_u=0;
4152  06fc 5f            	clrw	x
4153  06fd bf08          	ldw	_pwm_u,x
4154                     ; 829 	pwm_i=0x7ff;
4156  06ff ae07ff        	ldw	x,#2047
4157  0702 bf0a          	ldw	_pwm_i,x
4159  0704 ac3f083f      	jpf	L1712
4160  0708               L3712:
4161                     ; 831 else if(jp_mode==jp1)
4163  0708 b654          	ld	a,_jp_mode
4164  070a a101          	cp	a,#1
4165  070c 260e          	jrne	L7712
4166                     ; 833 	pwm_u=0x7ff;
4168  070e ae07ff        	ldw	x,#2047
4169  0711 bf08          	ldw	_pwm_u,x
4170                     ; 834 	pwm_i=0x7ff;
4172  0713 ae07ff        	ldw	x,#2047
4173  0716 bf0a          	ldw	_pwm_i,x
4175  0718 ac3f083f      	jpf	L1712
4176  071c               L7712:
4177                     ; 845 else if(link==OFF)
4179  071c b66d          	ld	a,_link
4180  071e a1aa          	cp	a,#170
4181  0720 2703          	jreq	L45
4182  0722 cc07c7        	jp	L3022
4183  0725               L45:
4184                     ; 847 	pwm_i=0x7ff;
4186  0725 ae07ff        	ldw	x,#2047
4187  0728 bf0a          	ldw	_pwm_i,x
4188                     ; 848 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4190  072a ce000a        	ldw	x,_Unecc
4191  072d 90ae07d0      	ldw	y,#2000
4192  0731 cd0000        	call	c_vmul
4194  0734 ae0014        	ldw	x,#L25
4195  0737 cd0000        	call	c_ldiv
4197  073a be02          	ldw	x,c_lreg+2
4198  073c bf55          	ldw	_pwm_u_,x
4199                     ; 852 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4201  073e c60013        	ld	a,_pwm_u_buff_ptr
4202  0741 5f            	clrw	x
4203  0742 97            	ld	xl,a
4204  0743 58            	sllw	x
4205  0744 90be55        	ldw	y,_pwm_u_
4206  0747 df0016        	ldw	(_pwm_u_buff,x),y
4207                     ; 853 	pwm_u_buff_ptr++;
4209  074a 725c0013      	inc	_pwm_u_buff_ptr
4210                     ; 854 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4212  074e c60013        	ld	a,_pwm_u_buff_ptr
4213  0751 a110          	cp	a,#16
4214  0753 2504          	jrult	L5022
4217  0755 725f0013      	clr	_pwm_u_buff_ptr
4218  0759               L5022:
4219                     ; 858 		tempSL=0;
4221  0759 ae0000        	ldw	x,#0
4222  075c 1f03          	ldw	(OFST-2,sp),x
4223  075e ae0000        	ldw	x,#0
4224  0761 1f01          	ldw	(OFST-4,sp),x
4225                     ; 859 		for(i=0;i<16;i++)
4227  0763 0f05          	clr	(OFST+0,sp)
4228  0765               L7022:
4229                     ; 861 			tempSL+=(signed long)pwm_u_buff[i];
4231  0765 7b05          	ld	a,(OFST+0,sp)
4232  0767 5f            	clrw	x
4233  0768 97            	ld	xl,a
4234  0769 58            	sllw	x
4235  076a de0016        	ldw	x,(_pwm_u_buff,x)
4236  076d cd0000        	call	c_itolx
4238  0770 96            	ldw	x,sp
4239  0771 1c0001        	addw	x,#OFST-4
4240  0774 cd0000        	call	c_lgadd
4242                     ; 859 		for(i=0;i<16;i++)
4244  0777 0c05          	inc	(OFST+0,sp)
4247  0779 7b05          	ld	a,(OFST+0,sp)
4248  077b a110          	cp	a,#16
4249  077d 25e6          	jrult	L7022
4250                     ; 863 		tempSL>>=4;
4252  077f 96            	ldw	x,sp
4253  0780 1c0001        	addw	x,#OFST-4
4254  0783 a604          	ld	a,#4
4255  0785 cd0000        	call	c_lgrsh
4257                     ; 864 		pwm_u_buff_=(signed short)tempSL;
4259  0788 1e03          	ldw	x,(OFST-2,sp)
4260  078a cf0014        	ldw	_pwm_u_buff_,x
4261                     ; 866 	pwm_u=pwm_u_;
4263  078d be55          	ldw	x,_pwm_u_
4264  078f bf08          	ldw	_pwm_u,x
4265                     ; 867 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4267  0791 9c            	rvf
4268  0792 ce000c        	ldw	x,_Ui
4269  0795 72b0000a      	subw	x,_Unecc
4270  0799 cd0000        	call	_abs
4272  079c a30014        	cpw	x,#20
4273  079f 2e06          	jrsge	L5122
4276  07a1 725c0012      	inc	_pwm_u_buff_cnt
4278  07a5 2004          	jra	L7122
4279  07a7               L5122:
4280                     ; 868 	else pwm_u_buff_cnt=0;
4282  07a7 725f0012      	clr	_pwm_u_buff_cnt
4283  07ab               L7122:
4284                     ; 870 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4286  07ab c60012        	ld	a,_pwm_u_buff_cnt
4287  07ae a114          	cp	a,#20
4288  07b0 2504          	jrult	L1222
4291  07b2 35140012      	mov	_pwm_u_buff_cnt,#20
4292  07b6               L1222:
4293                     ; 871 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4295  07b6 c60012        	ld	a,_pwm_u_buff_cnt
4296  07b9 a10f          	cp	a,#15
4297  07bb 2403          	jruge	L65
4298  07bd cc083f        	jp	L1712
4299  07c0               L65:
4302  07c0 ce0014        	ldw	x,_pwm_u_buff_
4303  07c3 bf08          	ldw	_pwm_u,x
4304  07c5 2078          	jra	L1712
4305  07c7               L3022:
4306                     ; 875 else	if(link==ON)				//если есть связьvol_i_temp_avar
4308  07c7 b66d          	ld	a,_link
4309  07c9 a155          	cp	a,#85
4310  07cb 2672          	jrne	L1712
4311                     ; 877 	if((flags&0b00100000)==0)	//если нет блокировки извне
4313  07cd b605          	ld	a,_flags
4314  07cf a520          	bcp	a,#32
4315  07d1 2660          	jrne	L1322
4316                     ; 879 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4318  07d3 b605          	ld	a,_flags
4319  07d5 a51a          	bcp	a,#26
4320  07d7 260b          	jrne	L3322
4321                     ; 881 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4323  07d9 be60          	ldw	x,_vol_i_temp
4324  07db bf08          	ldw	_pwm_u,x
4325                     ; 882 			pwm_i=2000;
4327  07dd ae07d0        	ldw	x,#2000
4328  07e0 bf0a          	ldw	_pwm_i,x
4330  07e2 200c          	jra	L5322
4331  07e4               L3322:
4332                     ; 884 		else if(flags&0b00011010)					//если есть аварии
4334  07e4 b605          	ld	a,_flags
4335  07e6 a51a          	bcp	a,#26
4336  07e8 2706          	jreq	L5322
4337                     ; 886 			pwm_u=0;								//то полный стоп
4339  07ea 5f            	clrw	x
4340  07eb bf08          	ldw	_pwm_u,x
4341                     ; 887 			pwm_i=0;
4343  07ed 5f            	clrw	x
4344  07ee bf0a          	ldw	_pwm_i,x
4345  07f0               L5322:
4346                     ; 890 		if(vol_i_temp==2000)
4348  07f0 be60          	ldw	x,_vol_i_temp
4349  07f2 a307d0        	cpw	x,#2000
4350  07f5 260c          	jrne	L1422
4351                     ; 892 			pwm_u=2000;
4353  07f7 ae07d0        	ldw	x,#2000
4354  07fa bf08          	ldw	_pwm_u,x
4355                     ; 893 			pwm_i=2000;
4357  07fc ae07d0        	ldw	x,#2000
4358  07ff bf0a          	ldw	_pwm_i,x
4360  0801 2014          	jra	L3422
4361  0803               L1422:
4362                     ; 897 			if((abs((int)(Ui-Unecc)))>50)	pwm_u_cnt=19;
4364  0803 9c            	rvf
4365  0804 ce000c        	ldw	x,_Ui
4366  0807 72b0000a      	subw	x,_Unecc
4367  080b cd0000        	call	_abs
4369  080e a30033        	cpw	x,#51
4370  0811 2f04          	jrslt	L3422
4373  0813 35130007      	mov	_pwm_u_cnt,#19
4374  0817               L3422:
4375                     ; 900 		if(pwm_u_cnt)
4377  0817 3d07          	tnz	_pwm_u_cnt
4378  0819 2724          	jreq	L1712
4379                     ; 902 			pwm_u_cnt--;
4381  081b 3a07          	dec	_pwm_u_cnt
4382                     ; 903 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4384  081d ce000a        	ldw	x,_Unecc
4385  0820 90ae07d0      	ldw	y,#2000
4386  0824 cd0000        	call	c_vmul
4388  0827 ae0014        	ldw	x,#L25
4389  082a cd0000        	call	c_ldiv
4391  082d be02          	ldw	x,c_lreg+2
4392  082f bf08          	ldw	_pwm_u,x
4393  0831 200c          	jra	L1712
4394  0833               L1322:
4395                     ; 906 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4397  0833 b605          	ld	a,_flags
4398  0835 a520          	bcp	a,#32
4399  0837 2706          	jreq	L1712
4400                     ; 908 		pwm_u=0;
4402  0839 5f            	clrw	x
4403  083a bf08          	ldw	_pwm_u,x
4404                     ; 909 		pwm_i=0;
4406  083c 5f            	clrw	x
4407  083d bf0a          	ldw	_pwm_i,x
4408  083f               L1712:
4409                     ; 937 if(pwm_u>2000)pwm_u=2000;
4411  083f 9c            	rvf
4412  0840 be08          	ldw	x,_pwm_u
4413  0842 a307d1        	cpw	x,#2001
4414  0845 2f05          	jrslt	L5522
4417  0847 ae07d0        	ldw	x,#2000
4418  084a bf08          	ldw	_pwm_u,x
4419  084c               L5522:
4420                     ; 938 if(pwm_i>2000)pwm_i=2000;
4422  084c 9c            	rvf
4423  084d be0a          	ldw	x,_pwm_i
4424  084f a307d1        	cpw	x,#2001
4425  0852 2f05          	jrslt	L7522
4428  0854 ae07d0        	ldw	x,#2000
4429  0857 bf0a          	ldw	_pwm_i,x
4430  0859               L7522:
4431                     ; 941 }
4434  0859 5b05          	addw	sp,#5
4435  085b 81            	ret
4488                     	switch	.const
4489  0018               L26:
4490  0018 00000258      	dc.l	600
4491  001c               L46:
4492  001c 000003e8      	dc.l	1000
4493  0020               L66:
4494  0020 00000708      	dc.l	1800
4495                     ; 944 void matemat(void)
4495                     ; 945 {
4496                     	switch	.text
4497  085c               _matemat:
4499  085c 5208          	subw	sp,#8
4500       00000008      OFST:	set	8
4503                     ; 969 I=adc_buff_[4];
4505  085e ce0107        	ldw	x,_adc_buff_+8
4506  0861 cf0010        	ldw	_I,x
4507                     ; 970 temp_SL=adc_buff_[4];
4509  0864 ce0107        	ldw	x,_adc_buff_+8
4510  0867 cd0000        	call	c_itolx
4512  086a 96            	ldw	x,sp
4513  086b 1c0005        	addw	x,#OFST-3
4514  086e cd0000        	call	c_rtol
4516                     ; 971 temp_SL-=ee_K[0][0];
4518  0871 ce001a        	ldw	x,_ee_K
4519  0874 cd0000        	call	c_itolx
4521  0877 96            	ldw	x,sp
4522  0878 1c0005        	addw	x,#OFST-3
4523  087b cd0000        	call	c_lgsub
4525                     ; 972 if(temp_SL<0) temp_SL=0;
4527  087e 9c            	rvf
4528  087f 0d05          	tnz	(OFST-3,sp)
4529  0881 2e0a          	jrsge	L7722
4532  0883 ae0000        	ldw	x,#0
4533  0886 1f07          	ldw	(OFST-1,sp),x
4534  0888 ae0000        	ldw	x,#0
4535  088b 1f05          	ldw	(OFST-3,sp),x
4536  088d               L7722:
4537                     ; 973 temp_SL*=ee_K[0][1];
4539  088d ce001c        	ldw	x,_ee_K+2
4540  0890 cd0000        	call	c_itolx
4542  0893 96            	ldw	x,sp
4543  0894 1c0005        	addw	x,#OFST-3
4544  0897 cd0000        	call	c_lgmul
4546                     ; 974 temp_SL/=600;
4548  089a 96            	ldw	x,sp
4549  089b 1c0005        	addw	x,#OFST-3
4550  089e cd0000        	call	c_ltor
4552  08a1 ae0018        	ldw	x,#L26
4553  08a4 cd0000        	call	c_ldiv
4555  08a7 96            	ldw	x,sp
4556  08a8 1c0005        	addw	x,#OFST-3
4557  08ab cd0000        	call	c_rtol
4559                     ; 975 I=(signed short)temp_SL;
4561  08ae 1e07          	ldw	x,(OFST-1,sp)
4562  08b0 cf0010        	ldw	_I,x
4563                     ; 978 temp_SL=(signed long)adc_buff_[1];//1;
4565                     ; 979 temp_SL=(signed long)adc_buff_[3];//1;
4567  08b3 ce0105        	ldw	x,_adc_buff_+6
4568  08b6 cd0000        	call	c_itolx
4570  08b9 96            	ldw	x,sp
4571  08ba 1c0005        	addw	x,#OFST-3
4572  08bd cd0000        	call	c_rtol
4574                     ; 981 if(temp_SL<0) temp_SL=0;
4576  08c0 9c            	rvf
4577  08c1 0d05          	tnz	(OFST-3,sp)
4578  08c3 2e0a          	jrsge	L1032
4581  08c5 ae0000        	ldw	x,#0
4582  08c8 1f07          	ldw	(OFST-1,sp),x
4583  08ca ae0000        	ldw	x,#0
4584  08cd 1f05          	ldw	(OFST-3,sp),x
4585  08cf               L1032:
4586                     ; 982 temp_SL*=(signed long)ee_K[2][1];
4588  08cf ce0024        	ldw	x,_ee_K+10
4589  08d2 cd0000        	call	c_itolx
4591  08d5 96            	ldw	x,sp
4592  08d6 1c0005        	addw	x,#OFST-3
4593  08d9 cd0000        	call	c_lgmul
4595                     ; 983 temp_SL/=1000L;
4597  08dc 96            	ldw	x,sp
4598  08dd 1c0005        	addw	x,#OFST-3
4599  08e0 cd0000        	call	c_ltor
4601  08e3 ae001c        	ldw	x,#L46
4602  08e6 cd0000        	call	c_ldiv
4604  08e9 96            	ldw	x,sp
4605  08ea 1c0005        	addw	x,#OFST-3
4606  08ed cd0000        	call	c_rtol
4608                     ; 984 Ui=(unsigned short)temp_SL;
4610  08f0 1e07          	ldw	x,(OFST-1,sp)
4611  08f2 cf000c        	ldw	_Ui,x
4612                     ; 986 temp_SL=(signed long)adc_buff_5;
4614  08f5 ce00fd        	ldw	x,_adc_buff_5
4615  08f8 cd0000        	call	c_itolx
4617  08fb 96            	ldw	x,sp
4618  08fc 1c0005        	addw	x,#OFST-3
4619  08ff cd0000        	call	c_rtol
4621                     ; 988 if(temp_SL<0) temp_SL=0;
4623  0902 9c            	rvf
4624  0903 0d05          	tnz	(OFST-3,sp)
4625  0905 2e0a          	jrsge	L3032
4628  0907 ae0000        	ldw	x,#0
4629  090a 1f07          	ldw	(OFST-1,sp),x
4630  090c ae0000        	ldw	x,#0
4631  090f 1f05          	ldw	(OFST-3,sp),x
4632  0911               L3032:
4633                     ; 989 temp_SL*=(signed long)ee_K[4][1];
4635  0911 ce002c        	ldw	x,_ee_K+18
4636  0914 cd0000        	call	c_itolx
4638  0917 96            	ldw	x,sp
4639  0918 1c0005        	addw	x,#OFST-3
4640  091b cd0000        	call	c_lgmul
4642                     ; 990 temp_SL/=1000L;
4644  091e 96            	ldw	x,sp
4645  091f 1c0005        	addw	x,#OFST-3
4646  0922 cd0000        	call	c_ltor
4648  0925 ae001c        	ldw	x,#L46
4649  0928 cd0000        	call	c_ldiv
4651  092b 96            	ldw	x,sp
4652  092c 1c0005        	addw	x,#OFST-3
4653  092f cd0000        	call	c_rtol
4655                     ; 991 Usum=(unsigned short)temp_SL;
4657  0932 1e07          	ldw	x,(OFST-1,sp)
4658  0934 cf0006        	ldw	_Usum,x
4659                     ; 995 temp_SL=adc_buff_[3];
4661  0937 ce0105        	ldw	x,_adc_buff_+6
4662  093a cd0000        	call	c_itolx
4664  093d 96            	ldw	x,sp
4665  093e 1c0005        	addw	x,#OFST-3
4666  0941 cd0000        	call	c_rtol
4668                     ; 997 if(temp_SL<0) temp_SL=0;
4670  0944 9c            	rvf
4671  0945 0d05          	tnz	(OFST-3,sp)
4672  0947 2e0a          	jrsge	L5032
4675  0949 ae0000        	ldw	x,#0
4676  094c 1f07          	ldw	(OFST-1,sp),x
4677  094e ae0000        	ldw	x,#0
4678  0951 1f05          	ldw	(OFST-3,sp),x
4679  0953               L5032:
4680                     ; 998 temp_SL*=ee_K[1][1];
4682  0953 ce0020        	ldw	x,_ee_K+6
4683  0956 cd0000        	call	c_itolx
4685  0959 96            	ldw	x,sp
4686  095a 1c0005        	addw	x,#OFST-3
4687  095d cd0000        	call	c_lgmul
4689                     ; 999 temp_SL/=1800;
4691  0960 96            	ldw	x,sp
4692  0961 1c0005        	addw	x,#OFST-3
4693  0964 cd0000        	call	c_ltor
4695  0967 ae0020        	ldw	x,#L66
4696  096a cd0000        	call	c_ldiv
4698  096d 96            	ldw	x,sp
4699  096e 1c0005        	addw	x,#OFST-3
4700  0971 cd0000        	call	c_rtol
4702                     ; 1000 Un=(unsigned short)temp_SL;
4704  0974 1e07          	ldw	x,(OFST-1,sp)
4705  0976 cf000e        	ldw	_Un,x
4706                     ; 1005 temp_SL=adc_buff_[2];
4708  0979 ce0103        	ldw	x,_adc_buff_+4
4709  097c cd0000        	call	c_itolx
4711  097f 96            	ldw	x,sp
4712  0980 1c0005        	addw	x,#OFST-3
4713  0983 cd0000        	call	c_rtol
4715                     ; 1006 temp_SL*=ee_K[3][1];
4717  0986 ce0028        	ldw	x,_ee_K+14
4718  0989 cd0000        	call	c_itolx
4720  098c 96            	ldw	x,sp
4721  098d 1c0005        	addw	x,#OFST-3
4722  0990 cd0000        	call	c_lgmul
4724                     ; 1007 temp_SL/=1000;
4726  0993 96            	ldw	x,sp
4727  0994 1c0005        	addw	x,#OFST-3
4728  0997 cd0000        	call	c_ltor
4730  099a ae001c        	ldw	x,#L46
4731  099d cd0000        	call	c_ldiv
4733  09a0 96            	ldw	x,sp
4734  09a1 1c0005        	addw	x,#OFST-3
4735  09a4 cd0000        	call	c_rtol
4737                     ; 1008 T=(signed short)(temp_SL-273L);
4739  09a7 7b08          	ld	a,(OFST+0,sp)
4740  09a9 5f            	clrw	x
4741  09aa 4d            	tnz	a
4742  09ab 2a01          	jrpl	L07
4743  09ad 53            	cplw	x
4744  09ae               L07:
4745  09ae 97            	ld	xl,a
4746  09af 1d0111        	subw	x,#273
4747  09b2 01            	rrwa	x,a
4748  09b3 b772          	ld	_T,a
4749  09b5 02            	rlwa	x,a
4750                     ; 1009 if(T<-30)T=-30;
4752  09b6 9c            	rvf
4753  09b7 b672          	ld	a,_T
4754  09b9 a1e2          	cp	a,#226
4755  09bb 2e04          	jrsge	L7032
4758  09bd 35e20072      	mov	_T,#226
4759  09c1               L7032:
4760                     ; 1010 if(T>120)T=120;
4762  09c1 9c            	rvf
4763  09c2 b672          	ld	a,_T
4764  09c4 a179          	cp	a,#121
4765  09c6 2f04          	jrslt	L1132
4768  09c8 35780072      	mov	_T,#120
4769  09cc               L1132:
4770                     ; 1014 Uin=Usum-Ui;
4772  09cc ce0006        	ldw	x,_Usum
4773  09cf 72b0000c      	subw	x,_Ui
4774  09d3 cf0004        	ldw	_Uin,x
4775                     ; 1015 if(link==ON)
4777  09d6 b66d          	ld	a,_link
4778  09d8 a155          	cp	a,#85
4779  09da 260c          	jrne	L3132
4780                     ; 1017 	Unecc=U_out_const-Uin;
4782  09dc ce0008        	ldw	x,_U_out_const
4783  09df 72b00004      	subw	x,_Uin
4784  09e3 cf000a        	ldw	_Unecc,x
4786  09e6 200a          	jra	L5132
4787  09e8               L3132:
4788                     ; 1026 else Unecc=ee_UAVT-Uin;
4790  09e8 ce000c        	ldw	x,_ee_UAVT
4791  09eb 72b00004      	subw	x,_Uin
4792  09ef cf000a        	ldw	_Unecc,x
4793  09f2               L5132:
4794                     ; 1035 temp_SL=(signed long)(T-ee_tsign);
4796  09f2 5f            	clrw	x
4797  09f3 b672          	ld	a,_T
4798  09f5 2a01          	jrpl	L27
4799  09f7 53            	cplw	x
4800  09f8               L27:
4801  09f8 97            	ld	xl,a
4802  09f9 72b0000e      	subw	x,_ee_tsign
4803  09fd cd0000        	call	c_itolx
4805  0a00 96            	ldw	x,sp
4806  0a01 1c0005        	addw	x,#OFST-3
4807  0a04 cd0000        	call	c_rtol
4809                     ; 1036 temp_SL*=1000L;
4811  0a07 ae03e8        	ldw	x,#1000
4812  0a0a bf02          	ldw	c_lreg+2,x
4813  0a0c ae0000        	ldw	x,#0
4814  0a0f bf00          	ldw	c_lreg,x
4815  0a11 96            	ldw	x,sp
4816  0a12 1c0005        	addw	x,#OFST-3
4817  0a15 cd0000        	call	c_lgmul
4819                     ; 1037 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4821  0a18 ce0010        	ldw	x,_ee_tmax
4822  0a1b 72b0000e      	subw	x,_ee_tsign
4823  0a1f cd0000        	call	c_itolx
4825  0a22 96            	ldw	x,sp
4826  0a23 1c0001        	addw	x,#OFST-7
4827  0a26 cd0000        	call	c_rtol
4829  0a29 96            	ldw	x,sp
4830  0a2a 1c0005        	addw	x,#OFST-3
4831  0a2d cd0000        	call	c_ltor
4833  0a30 96            	ldw	x,sp
4834  0a31 1c0001        	addw	x,#OFST-7
4835  0a34 cd0000        	call	c_ldiv
4837  0a37 96            	ldw	x,sp
4838  0a38 1c0005        	addw	x,#OFST-3
4839  0a3b cd0000        	call	c_rtol
4841                     ; 1039 vol_i_temp_avar=(unsigned short)temp_SL; 
4843  0a3e 1e07          	ldw	x,(OFST-1,sp)
4844  0a40 bf06          	ldw	_vol_i_temp_avar,x
4845                     ; 1041 debug_info_to_uku[0]=pwm_u;
4847  0a42 be08          	ldw	x,_pwm_u
4848  0a44 bf01          	ldw	_debug_info_to_uku,x
4849                     ; 1042 debug_info_to_uku[1]=vol_i_temp;
4851  0a46 be60          	ldw	x,_vol_i_temp
4852  0a48 bf03          	ldw	_debug_info_to_uku+2,x
4853                     ; 1044 }
4856  0a4a 5b08          	addw	sp,#8
4857  0a4c 81            	ret
4888                     ; 1047 void temper_drv(void)		//1 Hz
4888                     ; 1048 {
4889                     	switch	.text
4890  0a4d               _temper_drv:
4894                     ; 1050 if(T>ee_tsign) tsign_cnt++;
4896  0a4d 9c            	rvf
4897  0a4e 5f            	clrw	x
4898  0a4f b672          	ld	a,_T
4899  0a51 2a01          	jrpl	L67
4900  0a53 53            	cplw	x
4901  0a54               L67:
4902  0a54 97            	ld	xl,a
4903  0a55 c3000e        	cpw	x,_ee_tsign
4904  0a58 2d09          	jrsle	L7232
4907  0a5a be59          	ldw	x,_tsign_cnt
4908  0a5c 1c0001        	addw	x,#1
4909  0a5f bf59          	ldw	_tsign_cnt,x
4911  0a61 201d          	jra	L1332
4912  0a63               L7232:
4913                     ; 1051 else if (T<(ee_tsign-1)) tsign_cnt--;
4915  0a63 9c            	rvf
4916  0a64 ce000e        	ldw	x,_ee_tsign
4917  0a67 5a            	decw	x
4918  0a68 905f          	clrw	y
4919  0a6a b672          	ld	a,_T
4920  0a6c 2a02          	jrpl	L001
4921  0a6e 9053          	cplw	y
4922  0a70               L001:
4923  0a70 9097          	ld	yl,a
4924  0a72 90bf00        	ldw	c_y,y
4925  0a75 b300          	cpw	x,c_y
4926  0a77 2d07          	jrsle	L1332
4929  0a79 be59          	ldw	x,_tsign_cnt
4930  0a7b 1d0001        	subw	x,#1
4931  0a7e bf59          	ldw	_tsign_cnt,x
4932  0a80               L1332:
4933                     ; 1053 gran(&tsign_cnt,0,60);
4935  0a80 ae003c        	ldw	x,#60
4936  0a83 89            	pushw	x
4937  0a84 5f            	clrw	x
4938  0a85 89            	pushw	x
4939  0a86 ae0059        	ldw	x,#_tsign_cnt
4940  0a89 cd00d5        	call	_gran
4942  0a8c 5b04          	addw	sp,#4
4943                     ; 1055 if(tsign_cnt>=55)
4945  0a8e 9c            	rvf
4946  0a8f be59          	ldw	x,_tsign_cnt
4947  0a91 a30037        	cpw	x,#55
4948  0a94 2f16          	jrslt	L5332
4949                     ; 1057 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4951  0a96 3d54          	tnz	_jp_mode
4952  0a98 2606          	jrne	L3432
4954  0a9a b605          	ld	a,_flags
4955  0a9c a540          	bcp	a,#64
4956  0a9e 2706          	jreq	L1432
4957  0aa0               L3432:
4959  0aa0 b654          	ld	a,_jp_mode
4960  0aa2 a103          	cp	a,#3
4961  0aa4 2612          	jrne	L5432
4962  0aa6               L1432:
4965  0aa6 72140005      	bset	_flags,#2
4966  0aaa 200c          	jra	L5432
4967  0aac               L5332:
4968                     ; 1059 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
4970  0aac 9c            	rvf
4971  0aad be59          	ldw	x,_tsign_cnt
4972  0aaf a30006        	cpw	x,#6
4973  0ab2 2e04          	jrsge	L5432
4976  0ab4 72150005      	bres	_flags,#2
4977  0ab8               L5432:
4978                     ; 1064 if(T>ee_tmax) tmax_cnt++;
4980  0ab8 9c            	rvf
4981  0ab9 5f            	clrw	x
4982  0aba b672          	ld	a,_T
4983  0abc 2a01          	jrpl	L201
4984  0abe 53            	cplw	x
4985  0abf               L201:
4986  0abf 97            	ld	xl,a
4987  0ac0 c30010        	cpw	x,_ee_tmax
4988  0ac3 2d09          	jrsle	L1532
4991  0ac5 be57          	ldw	x,_tmax_cnt
4992  0ac7 1c0001        	addw	x,#1
4993  0aca bf57          	ldw	_tmax_cnt,x
4995  0acc 201d          	jra	L3532
4996  0ace               L1532:
4997                     ; 1065 else if (T<(ee_tmax-1)) tmax_cnt--;
4999  0ace 9c            	rvf
5000  0acf ce0010        	ldw	x,_ee_tmax
5001  0ad2 5a            	decw	x
5002  0ad3 905f          	clrw	y
5003  0ad5 b672          	ld	a,_T
5004  0ad7 2a02          	jrpl	L401
5005  0ad9 9053          	cplw	y
5006  0adb               L401:
5007  0adb 9097          	ld	yl,a
5008  0add 90bf00        	ldw	c_y,y
5009  0ae0 b300          	cpw	x,c_y
5010  0ae2 2d07          	jrsle	L3532
5013  0ae4 be57          	ldw	x,_tmax_cnt
5014  0ae6 1d0001        	subw	x,#1
5015  0ae9 bf57          	ldw	_tmax_cnt,x
5016  0aeb               L3532:
5017                     ; 1067 gran(&tmax_cnt,0,60);
5019  0aeb ae003c        	ldw	x,#60
5020  0aee 89            	pushw	x
5021  0aef 5f            	clrw	x
5022  0af0 89            	pushw	x
5023  0af1 ae0057        	ldw	x,#_tmax_cnt
5024  0af4 cd00d5        	call	_gran
5026  0af7 5b04          	addw	sp,#4
5027                     ; 1069 if(tmax_cnt>=55)
5029  0af9 9c            	rvf
5030  0afa be57          	ldw	x,_tmax_cnt
5031  0afc a30037        	cpw	x,#55
5032  0aff 2f16          	jrslt	L7532
5033                     ; 1071 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5035  0b01 3d54          	tnz	_jp_mode
5036  0b03 2606          	jrne	L5632
5038  0b05 b605          	ld	a,_flags
5039  0b07 a540          	bcp	a,#64
5040  0b09 2706          	jreq	L3632
5041  0b0b               L5632:
5043  0b0b b654          	ld	a,_jp_mode
5044  0b0d a103          	cp	a,#3
5045  0b0f 2612          	jrne	L7632
5046  0b11               L3632:
5049  0b11 72120005      	bset	_flags,#1
5050  0b15 200c          	jra	L7632
5051  0b17               L7532:
5052                     ; 1073 else if (tmax_cnt<=5) flags&=0b11111101;
5054  0b17 9c            	rvf
5055  0b18 be57          	ldw	x,_tmax_cnt
5056  0b1a a30006        	cpw	x,#6
5057  0b1d 2e04          	jrsge	L7632
5060  0b1f 72130005      	bres	_flags,#1
5061  0b23               L7632:
5062                     ; 1076 } 
5065  0b23 81            	ret
5097                     ; 1079 void u_drv(void)		//1Hz
5097                     ; 1080 { 
5098                     	switch	.text
5099  0b24               _u_drv:
5103                     ; 1081 if(jp_mode!=jp3)
5105  0b24 b654          	ld	a,_jp_mode
5106  0b26 a103          	cp	a,#3
5107  0b28 2774          	jreq	L3042
5108                     ; 1083 	if(Ui>ee_Umax)umax_cnt++;
5110  0b2a 9c            	rvf
5111  0b2b ce000c        	ldw	x,_Ui
5112  0b2e c30014        	cpw	x,_ee_Umax
5113  0b31 2d09          	jrsle	L5042
5116  0b33 be70          	ldw	x,_umax_cnt
5117  0b35 1c0001        	addw	x,#1
5118  0b38 bf70          	ldw	_umax_cnt,x
5120  0b3a 2003          	jra	L7042
5121  0b3c               L5042:
5122                     ; 1084 	else umax_cnt=0;
5124  0b3c 5f            	clrw	x
5125  0b3d bf70          	ldw	_umax_cnt,x
5126  0b3f               L7042:
5127                     ; 1085 	gran(&umax_cnt,0,10);
5129  0b3f ae000a        	ldw	x,#10
5130  0b42 89            	pushw	x
5131  0b43 5f            	clrw	x
5132  0b44 89            	pushw	x
5133  0b45 ae0070        	ldw	x,#_umax_cnt
5134  0b48 cd00d5        	call	_gran
5136  0b4b 5b04          	addw	sp,#4
5137                     ; 1086 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5139  0b4d 9c            	rvf
5140  0b4e be70          	ldw	x,_umax_cnt
5141  0b50 a3000a        	cpw	x,#10
5142  0b53 2f04          	jrslt	L1142
5145  0b55 72160005      	bset	_flags,#3
5146  0b59               L1142:
5147                     ; 1089 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5149  0b59 9c            	rvf
5150  0b5a ce000c        	ldw	x,_Ui
5151  0b5d c3000e        	cpw	x,_Un
5152  0b60 2e1d          	jrsge	L3142
5154  0b62 9c            	rvf
5155  0b63 ce000e        	ldw	x,_Un
5156  0b66 72b0000c      	subw	x,_Ui
5157  0b6a c30012        	cpw	x,_ee_dU
5158  0b6d 2d10          	jrsle	L3142
5160  0b6f c65005        	ld	a,20485
5161  0b72 a504          	bcp	a,#4
5162  0b74 2609          	jrne	L3142
5165  0b76 be6e          	ldw	x,_umin_cnt
5166  0b78 1c0001        	addw	x,#1
5167  0b7b bf6e          	ldw	_umin_cnt,x
5169  0b7d 2003          	jra	L5142
5170  0b7f               L3142:
5171                     ; 1090 	else umin_cnt=0;
5173  0b7f 5f            	clrw	x
5174  0b80 bf6e          	ldw	_umin_cnt,x
5175  0b82               L5142:
5176                     ; 1091 	gran(&umin_cnt,0,10);	
5178  0b82 ae000a        	ldw	x,#10
5179  0b85 89            	pushw	x
5180  0b86 5f            	clrw	x
5181  0b87 89            	pushw	x
5182  0b88 ae006e        	ldw	x,#_umin_cnt
5183  0b8b cd00d5        	call	_gran
5185  0b8e 5b04          	addw	sp,#4
5186                     ; 1092 	if(umin_cnt>=10)flags|=0b00010000;	  
5188  0b90 9c            	rvf
5189  0b91 be6e          	ldw	x,_umin_cnt
5190  0b93 a3000a        	cpw	x,#10
5191  0b96 2f71          	jrslt	L1242
5194  0b98 72180005      	bset	_flags,#4
5195  0b9c 206b          	jra	L1242
5196  0b9e               L3042:
5197                     ; 1094 else if(jp_mode==jp3)
5199  0b9e b654          	ld	a,_jp_mode
5200  0ba0 a103          	cp	a,#3
5201  0ba2 2665          	jrne	L1242
5202                     ; 1096 	if(Ui>700)umax_cnt++;
5204  0ba4 9c            	rvf
5205  0ba5 ce000c        	ldw	x,_Ui
5206  0ba8 a302bd        	cpw	x,#701
5207  0bab 2f09          	jrslt	L5242
5210  0bad be70          	ldw	x,_umax_cnt
5211  0baf 1c0001        	addw	x,#1
5212  0bb2 bf70          	ldw	_umax_cnt,x
5214  0bb4 2003          	jra	L7242
5215  0bb6               L5242:
5216                     ; 1097 	else umax_cnt=0;
5218  0bb6 5f            	clrw	x
5219  0bb7 bf70          	ldw	_umax_cnt,x
5220  0bb9               L7242:
5221                     ; 1098 	gran(&umax_cnt,0,10);
5223  0bb9 ae000a        	ldw	x,#10
5224  0bbc 89            	pushw	x
5225  0bbd 5f            	clrw	x
5226  0bbe 89            	pushw	x
5227  0bbf ae0070        	ldw	x,#_umax_cnt
5228  0bc2 cd00d5        	call	_gran
5230  0bc5 5b04          	addw	sp,#4
5231                     ; 1099 	if(umax_cnt>=10)flags|=0b00001000;
5233  0bc7 9c            	rvf
5234  0bc8 be70          	ldw	x,_umax_cnt
5235  0bca a3000a        	cpw	x,#10
5236  0bcd 2f04          	jrslt	L1342
5239  0bcf 72160005      	bset	_flags,#3
5240  0bd3               L1342:
5241                     ; 1102 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5243  0bd3 9c            	rvf
5244  0bd4 ce000c        	ldw	x,_Ui
5245  0bd7 a300c8        	cpw	x,#200
5246  0bda 2e10          	jrsge	L3342
5248  0bdc c65005        	ld	a,20485
5249  0bdf a504          	bcp	a,#4
5250  0be1 2609          	jrne	L3342
5253  0be3 be6e          	ldw	x,_umin_cnt
5254  0be5 1c0001        	addw	x,#1
5255  0be8 bf6e          	ldw	_umin_cnt,x
5257  0bea 2003          	jra	L5342
5258  0bec               L3342:
5259                     ; 1103 	else umin_cnt=0;
5261  0bec 5f            	clrw	x
5262  0bed bf6e          	ldw	_umin_cnt,x
5263  0bef               L5342:
5264                     ; 1104 	gran(&umin_cnt,0,10);	
5266  0bef ae000a        	ldw	x,#10
5267  0bf2 89            	pushw	x
5268  0bf3 5f            	clrw	x
5269  0bf4 89            	pushw	x
5270  0bf5 ae006e        	ldw	x,#_umin_cnt
5271  0bf8 cd00d5        	call	_gran
5273  0bfb 5b04          	addw	sp,#4
5274                     ; 1105 	if(umin_cnt>=10)flags|=0b00010000;	  
5276  0bfd 9c            	rvf
5277  0bfe be6e          	ldw	x,_umin_cnt
5278  0c00 a3000a        	cpw	x,#10
5279  0c03 2f04          	jrslt	L1242
5282  0c05 72180005      	bset	_flags,#4
5283  0c09               L1242:
5284                     ; 1107 }
5287  0c09 81            	ret
5313                     ; 1132 void apv_start(void)
5313                     ; 1133 {
5314                     	switch	.text
5315  0c0a               _apv_start:
5319                     ; 1134 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5321  0c0a 3d4f          	tnz	_apv_cnt
5322  0c0c 2624          	jrne	L1542
5324  0c0e 3d50          	tnz	_apv_cnt+1
5325  0c10 2620          	jrne	L1542
5327  0c12 3d51          	tnz	_apv_cnt+2
5328  0c14 261c          	jrne	L1542
5330                     	btst	_bAPV
5331  0c1b 2515          	jrult	L1542
5332                     ; 1136 	apv_cnt[0]=60;
5334  0c1d 353c004f      	mov	_apv_cnt,#60
5335                     ; 1137 	apv_cnt[1]=60;
5337  0c21 353c0050      	mov	_apv_cnt+1,#60
5338                     ; 1138 	apv_cnt[2]=60;
5340  0c25 353c0051      	mov	_apv_cnt+2,#60
5341                     ; 1139 	apv_cnt_=3600;
5343  0c29 ae0e10        	ldw	x,#3600
5344  0c2c bf4d          	ldw	_apv_cnt_,x
5345                     ; 1140 	bAPV=1;	
5347  0c2e 72100002      	bset	_bAPV
5348  0c32               L1542:
5349                     ; 1142 }
5352  0c32 81            	ret
5378                     ; 1145 void apv_stop(void)
5378                     ; 1146 {
5379                     	switch	.text
5380  0c33               _apv_stop:
5384                     ; 1147 apv_cnt[0]=0;
5386  0c33 3f4f          	clr	_apv_cnt
5387                     ; 1148 apv_cnt[1]=0;
5389  0c35 3f50          	clr	_apv_cnt+1
5390                     ; 1149 apv_cnt[2]=0;
5392  0c37 3f51          	clr	_apv_cnt+2
5393                     ; 1150 apv_cnt_=0;	
5395  0c39 5f            	clrw	x
5396  0c3a bf4d          	ldw	_apv_cnt_,x
5397                     ; 1151 bAPV=0;
5399  0c3c 72110002      	bres	_bAPV
5400                     ; 1152 }
5403  0c40 81            	ret
5438                     ; 1156 void apv_hndl(void)
5438                     ; 1157 {
5439                     	switch	.text
5440  0c41               _apv_hndl:
5444                     ; 1158 if(apv_cnt[0])
5446  0c41 3d4f          	tnz	_apv_cnt
5447  0c43 271e          	jreq	L3742
5448                     ; 1160 	apv_cnt[0]--;
5450  0c45 3a4f          	dec	_apv_cnt
5451                     ; 1161 	if(apv_cnt[0]==0)
5453  0c47 3d4f          	tnz	_apv_cnt
5454  0c49 265a          	jrne	L7742
5455                     ; 1163 		flags&=0b11100001;
5457  0c4b b605          	ld	a,_flags
5458  0c4d a4e1          	and	a,#225
5459  0c4f b705          	ld	_flags,a
5460                     ; 1164 		tsign_cnt=0;
5462  0c51 5f            	clrw	x
5463  0c52 bf59          	ldw	_tsign_cnt,x
5464                     ; 1165 		tmax_cnt=0;
5466  0c54 5f            	clrw	x
5467  0c55 bf57          	ldw	_tmax_cnt,x
5468                     ; 1166 		umax_cnt=0;
5470  0c57 5f            	clrw	x
5471  0c58 bf70          	ldw	_umax_cnt,x
5472                     ; 1167 		umin_cnt=0;
5474  0c5a 5f            	clrw	x
5475  0c5b bf6e          	ldw	_umin_cnt,x
5476                     ; 1169 		led_drv_cnt=30;
5478  0c5d 351e0016      	mov	_led_drv_cnt,#30
5479  0c61 2042          	jra	L7742
5480  0c63               L3742:
5481                     ; 1172 else if(apv_cnt[1])
5483  0c63 3d50          	tnz	_apv_cnt+1
5484  0c65 271e          	jreq	L1052
5485                     ; 1174 	apv_cnt[1]--;
5487  0c67 3a50          	dec	_apv_cnt+1
5488                     ; 1175 	if(apv_cnt[1]==0)
5490  0c69 3d50          	tnz	_apv_cnt+1
5491  0c6b 2638          	jrne	L7742
5492                     ; 1177 		flags&=0b11100001;
5494  0c6d b605          	ld	a,_flags
5495  0c6f a4e1          	and	a,#225
5496  0c71 b705          	ld	_flags,a
5497                     ; 1178 		tsign_cnt=0;
5499  0c73 5f            	clrw	x
5500  0c74 bf59          	ldw	_tsign_cnt,x
5501                     ; 1179 		tmax_cnt=0;
5503  0c76 5f            	clrw	x
5504  0c77 bf57          	ldw	_tmax_cnt,x
5505                     ; 1180 		umax_cnt=0;
5507  0c79 5f            	clrw	x
5508  0c7a bf70          	ldw	_umax_cnt,x
5509                     ; 1181 		umin_cnt=0;
5511  0c7c 5f            	clrw	x
5512  0c7d bf6e          	ldw	_umin_cnt,x
5513                     ; 1183 		led_drv_cnt=30;
5515  0c7f 351e0016      	mov	_led_drv_cnt,#30
5516  0c83 2020          	jra	L7742
5517  0c85               L1052:
5518                     ; 1186 else if(apv_cnt[2])
5520  0c85 3d51          	tnz	_apv_cnt+2
5521  0c87 271c          	jreq	L7742
5522                     ; 1188 	apv_cnt[2]--;
5524  0c89 3a51          	dec	_apv_cnt+2
5525                     ; 1189 	if(apv_cnt[2]==0)
5527  0c8b 3d51          	tnz	_apv_cnt+2
5528  0c8d 2616          	jrne	L7742
5529                     ; 1191 		flags&=0b11100001;
5531  0c8f b605          	ld	a,_flags
5532  0c91 a4e1          	and	a,#225
5533  0c93 b705          	ld	_flags,a
5534                     ; 1192 		tsign_cnt=0;
5536  0c95 5f            	clrw	x
5537  0c96 bf59          	ldw	_tsign_cnt,x
5538                     ; 1193 		tmax_cnt=0;
5540  0c98 5f            	clrw	x
5541  0c99 bf57          	ldw	_tmax_cnt,x
5542                     ; 1194 		umax_cnt=0;
5544  0c9b 5f            	clrw	x
5545  0c9c bf70          	ldw	_umax_cnt,x
5546                     ; 1195 		umin_cnt=0;          
5548  0c9e 5f            	clrw	x
5549  0c9f bf6e          	ldw	_umin_cnt,x
5550                     ; 1197 		led_drv_cnt=30;
5552  0ca1 351e0016      	mov	_led_drv_cnt,#30
5553  0ca5               L7742:
5554                     ; 1201 if(apv_cnt_)
5556  0ca5 be4d          	ldw	x,_apv_cnt_
5557  0ca7 2712          	jreq	L3152
5558                     ; 1203 	apv_cnt_--;
5560  0ca9 be4d          	ldw	x,_apv_cnt_
5561  0cab 1d0001        	subw	x,#1
5562  0cae bf4d          	ldw	_apv_cnt_,x
5563                     ; 1204 	if(apv_cnt_==0) 
5565  0cb0 be4d          	ldw	x,_apv_cnt_
5566  0cb2 2607          	jrne	L3152
5567                     ; 1206 		bAPV=0;
5569  0cb4 72110002      	bres	_bAPV
5570                     ; 1207 		apv_start();
5572  0cb8 cd0c0a        	call	_apv_start
5574  0cbb               L3152:
5575                     ; 1211 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5577  0cbb be6e          	ldw	x,_umin_cnt
5578  0cbd 261e          	jrne	L7152
5580  0cbf be70          	ldw	x,_umax_cnt
5581  0cc1 261a          	jrne	L7152
5583  0cc3 c65005        	ld	a,20485
5584  0cc6 a504          	bcp	a,#4
5585  0cc8 2613          	jrne	L7152
5586                     ; 1213 	if(cnt_apv_off<20)
5588  0cca b64c          	ld	a,_cnt_apv_off
5589  0ccc a114          	cp	a,#20
5590  0cce 240f          	jruge	L5252
5591                     ; 1215 		cnt_apv_off++;
5593  0cd0 3c4c          	inc	_cnt_apv_off
5594                     ; 1216 		if(cnt_apv_off>=20)
5596  0cd2 b64c          	ld	a,_cnt_apv_off
5597  0cd4 a114          	cp	a,#20
5598  0cd6 2507          	jrult	L5252
5599                     ; 1218 			apv_stop();
5601  0cd8 cd0c33        	call	_apv_stop
5603  0cdb 2002          	jra	L5252
5604  0cdd               L7152:
5605                     ; 1222 else cnt_apv_off=0;	
5607  0cdd 3f4c          	clr	_cnt_apv_off
5608  0cdf               L5252:
5609                     ; 1224 }
5612  0cdf 81            	ret
5615                     	switch	.ubsct
5616  0000               L7252_flags_old:
5617  0000 00            	ds.b	1
5653                     ; 1227 void flags_drv(void)
5653                     ; 1228 {
5654                     	switch	.text
5655  0ce0               _flags_drv:
5659                     ; 1230 if(jp_mode!=jp3) 
5661  0ce0 b654          	ld	a,_jp_mode
5662  0ce2 a103          	cp	a,#3
5663  0ce4 2723          	jreq	L7452
5664                     ; 1232 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5666  0ce6 b605          	ld	a,_flags
5667  0ce8 a508          	bcp	a,#8
5668  0cea 2706          	jreq	L5552
5670  0cec b600          	ld	a,L7252_flags_old
5671  0cee a508          	bcp	a,#8
5672  0cf0 270c          	jreq	L3552
5673  0cf2               L5552:
5675  0cf2 b605          	ld	a,_flags
5676  0cf4 a510          	bcp	a,#16
5677  0cf6 2726          	jreq	L1652
5679  0cf8 b600          	ld	a,L7252_flags_old
5680  0cfa a510          	bcp	a,#16
5681  0cfc 2620          	jrne	L1652
5682  0cfe               L3552:
5683                     ; 1234     		if(link==OFF)apv_start();
5685  0cfe b66d          	ld	a,_link
5686  0d00 a1aa          	cp	a,#170
5687  0d02 261a          	jrne	L1652
5690  0d04 cd0c0a        	call	_apv_start
5692  0d07 2015          	jra	L1652
5693  0d09               L7452:
5694                     ; 1237 else if(jp_mode==jp3) 
5696  0d09 b654          	ld	a,_jp_mode
5697  0d0b a103          	cp	a,#3
5698  0d0d 260f          	jrne	L1652
5699                     ; 1239 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5701  0d0f b605          	ld	a,_flags
5702  0d11 a508          	bcp	a,#8
5703  0d13 2709          	jreq	L1652
5705  0d15 b600          	ld	a,L7252_flags_old
5706  0d17 a508          	bcp	a,#8
5707  0d19 2603          	jrne	L1652
5708                     ; 1241     		apv_start();
5710  0d1b cd0c0a        	call	_apv_start
5712  0d1e               L1652:
5713                     ; 1244 flags_old=flags;
5715  0d1e 450500        	mov	L7252_flags_old,_flags
5716                     ; 1246 } 
5719  0d21 81            	ret
5754                     ; 1383 void adr_drv_v4(char in)
5754                     ; 1384 {
5755                     	switch	.text
5756  0d22               _adr_drv_v4:
5760                     ; 1385 if(adress!=in)adress=in;
5762  0d22 c100f7        	cp	a,_adress
5763  0d25 2703          	jreq	L5062
5766  0d27 c700f7        	ld	_adress,a
5767  0d2a               L5062:
5768                     ; 1386 }
5771  0d2a 81            	ret
5800                     ; 1389 void adr_drv_v3(void)
5800                     ; 1390 {
5801                     	switch	.text
5802  0d2b               _adr_drv_v3:
5804  0d2b 88            	push	a
5805       00000001      OFST:	set	1
5808                     ; 1396 GPIOB->DDR&=~(1<<0);
5810  0d2c 72115007      	bres	20487,#0
5811                     ; 1397 GPIOB->CR1&=~(1<<0);
5813  0d30 72115008      	bres	20488,#0
5814                     ; 1398 GPIOB->CR2&=~(1<<0);
5816  0d34 72115009      	bres	20489,#0
5817                     ; 1399 ADC2->CR2=0x08;
5819  0d38 35085402      	mov	21506,#8
5820                     ; 1400 ADC2->CR1=0x40;
5822  0d3c 35405401      	mov	21505,#64
5823                     ; 1401 ADC2->CSR=0x20+0;
5825  0d40 35205400      	mov	21504,#32
5826                     ; 1402 ADC2->CR1|=1;
5828  0d44 72105401      	bset	21505,#0
5829                     ; 1403 ADC2->CR1|=1;
5831  0d48 72105401      	bset	21505,#0
5832                     ; 1404 adr_drv_stat=1;
5834  0d4c 35010002      	mov	_adr_drv_stat,#1
5835  0d50               L7162:
5836                     ; 1405 while(adr_drv_stat==1);
5839  0d50 b602          	ld	a,_adr_drv_stat
5840  0d52 a101          	cp	a,#1
5841  0d54 27fa          	jreq	L7162
5842                     ; 1407 GPIOB->DDR&=~(1<<1);
5844  0d56 72135007      	bres	20487,#1
5845                     ; 1408 GPIOB->CR1&=~(1<<1);
5847  0d5a 72135008      	bres	20488,#1
5848                     ; 1409 GPIOB->CR2&=~(1<<1);
5850  0d5e 72135009      	bres	20489,#1
5851                     ; 1410 ADC2->CR2=0x08;
5853  0d62 35085402      	mov	21506,#8
5854                     ; 1411 ADC2->CR1=0x40;
5856  0d66 35405401      	mov	21505,#64
5857                     ; 1412 ADC2->CSR=0x20+1;
5859  0d6a 35215400      	mov	21504,#33
5860                     ; 1413 ADC2->CR1|=1;
5862  0d6e 72105401      	bset	21505,#0
5863                     ; 1414 ADC2->CR1|=1;
5865  0d72 72105401      	bset	21505,#0
5866                     ; 1415 adr_drv_stat=3;
5868  0d76 35030002      	mov	_adr_drv_stat,#3
5869  0d7a               L5262:
5870                     ; 1416 while(adr_drv_stat==3);
5873  0d7a b602          	ld	a,_adr_drv_stat
5874  0d7c a103          	cp	a,#3
5875  0d7e 27fa          	jreq	L5262
5876                     ; 1418 GPIOE->DDR&=~(1<<6);
5878  0d80 721d5016      	bres	20502,#6
5879                     ; 1419 GPIOE->CR1&=~(1<<6);
5881  0d84 721d5017      	bres	20503,#6
5882                     ; 1420 GPIOE->CR2&=~(1<<6);
5884  0d88 721d5018      	bres	20504,#6
5885                     ; 1421 ADC2->CR2=0x08;
5887  0d8c 35085402      	mov	21506,#8
5888                     ; 1422 ADC2->CR1=0x40;
5890  0d90 35405401      	mov	21505,#64
5891                     ; 1423 ADC2->CSR=0x20+9;
5893  0d94 35295400      	mov	21504,#41
5894                     ; 1424 ADC2->CR1|=1;
5896  0d98 72105401      	bset	21505,#0
5897                     ; 1425 ADC2->CR1|=1;
5899  0d9c 72105401      	bset	21505,#0
5900                     ; 1426 adr_drv_stat=5;
5902  0da0 35050002      	mov	_adr_drv_stat,#5
5903  0da4               L3362:
5904                     ; 1427 while(adr_drv_stat==5);
5907  0da4 b602          	ld	a,_adr_drv_stat
5908  0da6 a105          	cp	a,#5
5909  0da8 27fa          	jreq	L3362
5910                     ; 1431 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5912  0daa 9c            	rvf
5913  0dab ce00ff        	ldw	x,_adc_buff_
5914  0dae a3022a        	cpw	x,#554
5915  0db1 2f0f          	jrslt	L1462
5917  0db3 9c            	rvf
5918  0db4 ce00ff        	ldw	x,_adc_buff_
5919  0db7 a30253        	cpw	x,#595
5920  0dba 2e06          	jrsge	L1462
5923  0dbc 725f00f8      	clr	_adr
5925  0dc0 204c          	jra	L3462
5926  0dc2               L1462:
5927                     ; 1432 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5929  0dc2 9c            	rvf
5930  0dc3 ce00ff        	ldw	x,_adc_buff_
5931  0dc6 a3036d        	cpw	x,#877
5932  0dc9 2f0f          	jrslt	L5462
5934  0dcb 9c            	rvf
5935  0dcc ce00ff        	ldw	x,_adc_buff_
5936  0dcf a30396        	cpw	x,#918
5937  0dd2 2e06          	jrsge	L5462
5940  0dd4 350100f8      	mov	_adr,#1
5942  0dd8 2034          	jra	L3462
5943  0dda               L5462:
5944                     ; 1433 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5946  0dda 9c            	rvf
5947  0ddb ce00ff        	ldw	x,_adc_buff_
5948  0dde a302a3        	cpw	x,#675
5949  0de1 2f0f          	jrslt	L1562
5951  0de3 9c            	rvf
5952  0de4 ce00ff        	ldw	x,_adc_buff_
5953  0de7 a302cc        	cpw	x,#716
5954  0dea 2e06          	jrsge	L1562
5957  0dec 350200f8      	mov	_adr,#2
5959  0df0 201c          	jra	L3462
5960  0df2               L1562:
5961                     ; 1434 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5963  0df2 9c            	rvf
5964  0df3 ce00ff        	ldw	x,_adc_buff_
5965  0df6 a303e3        	cpw	x,#995
5966  0df9 2f0f          	jrslt	L5562
5968  0dfb 9c            	rvf
5969  0dfc ce00ff        	ldw	x,_adc_buff_
5970  0dff a3040c        	cpw	x,#1036
5971  0e02 2e06          	jrsge	L5562
5974  0e04 350300f8      	mov	_adr,#3
5976  0e08 2004          	jra	L3462
5977  0e0a               L5562:
5978                     ; 1435 else adr[0]=5;
5980  0e0a 350500f8      	mov	_adr,#5
5981  0e0e               L3462:
5982                     ; 1437 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5984  0e0e 9c            	rvf
5985  0e0f ce0101        	ldw	x,_adc_buff_+2
5986  0e12 a3022a        	cpw	x,#554
5987  0e15 2f0f          	jrslt	L1662
5989  0e17 9c            	rvf
5990  0e18 ce0101        	ldw	x,_adc_buff_+2
5991  0e1b a30253        	cpw	x,#595
5992  0e1e 2e06          	jrsge	L1662
5995  0e20 725f00f9      	clr	_adr+1
5997  0e24 204c          	jra	L3662
5998  0e26               L1662:
5999                     ; 1438 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6001  0e26 9c            	rvf
6002  0e27 ce0101        	ldw	x,_adc_buff_+2
6003  0e2a a3036d        	cpw	x,#877
6004  0e2d 2f0f          	jrslt	L5662
6006  0e2f 9c            	rvf
6007  0e30 ce0101        	ldw	x,_adc_buff_+2
6008  0e33 a30396        	cpw	x,#918
6009  0e36 2e06          	jrsge	L5662
6012  0e38 350100f9      	mov	_adr+1,#1
6014  0e3c 2034          	jra	L3662
6015  0e3e               L5662:
6016                     ; 1439 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6018  0e3e 9c            	rvf
6019  0e3f ce0101        	ldw	x,_adc_buff_+2
6020  0e42 a302a3        	cpw	x,#675
6021  0e45 2f0f          	jrslt	L1762
6023  0e47 9c            	rvf
6024  0e48 ce0101        	ldw	x,_adc_buff_+2
6025  0e4b a302cc        	cpw	x,#716
6026  0e4e 2e06          	jrsge	L1762
6029  0e50 350200f9      	mov	_adr+1,#2
6031  0e54 201c          	jra	L3662
6032  0e56               L1762:
6033                     ; 1440 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6035  0e56 9c            	rvf
6036  0e57 ce0101        	ldw	x,_adc_buff_+2
6037  0e5a a303e3        	cpw	x,#995
6038  0e5d 2f0f          	jrslt	L5762
6040  0e5f 9c            	rvf
6041  0e60 ce0101        	ldw	x,_adc_buff_+2
6042  0e63 a3040c        	cpw	x,#1036
6043  0e66 2e06          	jrsge	L5762
6046  0e68 350300f9      	mov	_adr+1,#3
6048  0e6c 2004          	jra	L3662
6049  0e6e               L5762:
6050                     ; 1441 else adr[1]=5;
6052  0e6e 350500f9      	mov	_adr+1,#5
6053  0e72               L3662:
6054                     ; 1443 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6056  0e72 9c            	rvf
6057  0e73 ce0111        	ldw	x,_adc_buff_+18
6058  0e76 a3022a        	cpw	x,#554
6059  0e79 2f0f          	jrslt	L1072
6061  0e7b 9c            	rvf
6062  0e7c ce0111        	ldw	x,_adc_buff_+18
6063  0e7f a30253        	cpw	x,#595
6064  0e82 2e06          	jrsge	L1072
6067  0e84 725f00fa      	clr	_adr+2
6069  0e88 204c          	jra	L3072
6070  0e8a               L1072:
6071                     ; 1444 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6073  0e8a 9c            	rvf
6074  0e8b ce0111        	ldw	x,_adc_buff_+18
6075  0e8e a3036d        	cpw	x,#877
6076  0e91 2f0f          	jrslt	L5072
6078  0e93 9c            	rvf
6079  0e94 ce0111        	ldw	x,_adc_buff_+18
6080  0e97 a30396        	cpw	x,#918
6081  0e9a 2e06          	jrsge	L5072
6084  0e9c 350100fa      	mov	_adr+2,#1
6086  0ea0 2034          	jra	L3072
6087  0ea2               L5072:
6088                     ; 1445 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6090  0ea2 9c            	rvf
6091  0ea3 ce0111        	ldw	x,_adc_buff_+18
6092  0ea6 a302a3        	cpw	x,#675
6093  0ea9 2f0f          	jrslt	L1172
6095  0eab 9c            	rvf
6096  0eac ce0111        	ldw	x,_adc_buff_+18
6097  0eaf a302cc        	cpw	x,#716
6098  0eb2 2e06          	jrsge	L1172
6101  0eb4 350200fa      	mov	_adr+2,#2
6103  0eb8 201c          	jra	L3072
6104  0eba               L1172:
6105                     ; 1446 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6107  0eba 9c            	rvf
6108  0ebb ce0111        	ldw	x,_adc_buff_+18
6109  0ebe a303e3        	cpw	x,#995
6110  0ec1 2f0f          	jrslt	L5172
6112  0ec3 9c            	rvf
6113  0ec4 ce0111        	ldw	x,_adc_buff_+18
6114  0ec7 a3040c        	cpw	x,#1036
6115  0eca 2e06          	jrsge	L5172
6118  0ecc 350300fa      	mov	_adr+2,#3
6120  0ed0 2004          	jra	L3072
6121  0ed2               L5172:
6122                     ; 1447 else adr[2]=5;
6124  0ed2 350500fa      	mov	_adr+2,#5
6125  0ed6               L3072:
6126                     ; 1451 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6128  0ed6 c600f8        	ld	a,_adr
6129  0ed9 a105          	cp	a,#5
6130  0edb 270e          	jreq	L3272
6132  0edd c600f9        	ld	a,_adr+1
6133  0ee0 a105          	cp	a,#5
6134  0ee2 2707          	jreq	L3272
6136  0ee4 c600fa        	ld	a,_adr+2
6137  0ee7 a105          	cp	a,#5
6138  0ee9 2606          	jrne	L1272
6139  0eeb               L3272:
6140                     ; 1454 	adress_error=1;
6142  0eeb 350100f6      	mov	_adress_error,#1
6144  0eef               L7272:
6145                     ; 1465 }
6148  0eef 84            	pop	a
6149  0ef0 81            	ret
6150  0ef1               L1272:
6151                     ; 1458 	if(adr[2]&0x02) bps_class=bpsIPS;
6153  0ef1 c600fa        	ld	a,_adr+2
6154  0ef4 a502          	bcp	a,#2
6155  0ef6 2706          	jreq	L1372
6158  0ef8 3501000b      	mov	_bps_class,#1
6160  0efc 2002          	jra	L3372
6161  0efe               L1372:
6162                     ; 1459 	else bps_class=bpsIBEP;
6164  0efe 3f0b          	clr	_bps_class
6165  0f00               L3372:
6166                     ; 1461 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6168  0f00 c600fa        	ld	a,_adr+2
6169  0f03 a401          	and	a,#1
6170  0f05 97            	ld	xl,a
6171  0f06 a610          	ld	a,#16
6172  0f08 42            	mul	x,a
6173  0f09 9f            	ld	a,xl
6174  0f0a 6b01          	ld	(OFST+0,sp),a
6175  0f0c c600f9        	ld	a,_adr+1
6176  0f0f 48            	sll	a
6177  0f10 48            	sll	a
6178  0f11 cb00f8        	add	a,_adr
6179  0f14 1b01          	add	a,(OFST+0,sp)
6180  0f16 c700f7        	ld	_adress,a
6181  0f19 20d4          	jra	L7272
6204                     ; 1515 void init_CAN(void) {
6205                     	switch	.text
6206  0f1b               _init_CAN:
6210                     ; 1516 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6212  0f1b 72135420      	bres	21536,#1
6213                     ; 1517 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6215  0f1f 72105420      	bset	21536,#0
6217  0f23               L7472:
6218                     ; 1518 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6220  0f23 c65421        	ld	a,21537
6221  0f26 a501          	bcp	a,#1
6222  0f28 27f9          	jreq	L7472
6223                     ; 1520 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6225  0f2a 72185420      	bset	21536,#4
6226                     ; 1522 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6228  0f2e 35025427      	mov	21543,#2
6229                     ; 1531 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6231  0f32 35135428      	mov	21544,#19
6232                     ; 1532 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6234  0f36 35c05429      	mov	21545,#192
6235                     ; 1533 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6237  0f3a 357f542c      	mov	21548,#127
6238                     ; 1534 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6240  0f3e 35e0542d      	mov	21549,#224
6241                     ; 1536 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6243  0f42 35315430      	mov	21552,#49
6244                     ; 1537 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6246  0f46 35c05431      	mov	21553,#192
6247                     ; 1538 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6249  0f4a 357f5434      	mov	21556,#127
6250                     ; 1539 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6252  0f4e 35e05435      	mov	21557,#224
6253                     ; 1543 	CAN->PSR= 6;									// set page 6
6255  0f52 35065427      	mov	21543,#6
6256                     ; 1548 	CAN->Page.Config.FMR1&=~3;								//mask mode
6258  0f56 c65430        	ld	a,21552
6259  0f59 a4fc          	and	a,#252
6260  0f5b c75430        	ld	21552,a
6261                     ; 1554 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6263  0f5e 35065432      	mov	21554,#6
6264                     ; 1555 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6266  0f62 35605432      	mov	21554,#96
6267                     ; 1558 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6269  0f66 72105432      	bset	21554,#0
6270                     ; 1559 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6272  0f6a 72185432      	bset	21554,#4
6273                     ; 1562 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6275  0f6e 35065427      	mov	21543,#6
6276                     ; 1564 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6278  0f72 3509542c      	mov	21548,#9
6279                     ; 1565 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6281  0f76 35e7542d      	mov	21549,#231
6282                     ; 1567 	CAN->IER|=(1<<1);
6284  0f7a 72125425      	bset	21541,#1
6285                     ; 1570 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6287  0f7e 72115420      	bres	21536,#0
6289  0f82               L5572:
6290                     ; 1571 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6292  0f82 c65421        	ld	a,21537
6293  0f85 a501          	bcp	a,#1
6294  0f87 26f9          	jrne	L5572
6295                     ; 1572 }
6298  0f89 81            	ret
6406                     ; 1575 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6406                     ; 1576 {
6407                     	switch	.text
6408  0f8a               _can_transmit:
6410  0f8a 89            	pushw	x
6411       00000000      OFST:	set	0
6414                     ; 1578 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6416  0f8b b676          	ld	a,_can_buff_wr_ptr
6417  0f8d a104          	cp	a,#4
6418  0f8f 2502          	jrult	L7303
6421  0f91 3f76          	clr	_can_buff_wr_ptr
6422  0f93               L7303:
6423                     ; 1580 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6425  0f93 b676          	ld	a,_can_buff_wr_ptr
6426  0f95 97            	ld	xl,a
6427  0f96 a610          	ld	a,#16
6428  0f98 42            	mul	x,a
6429  0f99 1601          	ldw	y,(OFST+1,sp)
6430  0f9b a606          	ld	a,#6
6431  0f9d               L031:
6432  0f9d 9054          	srlw	y
6433  0f9f 4a            	dec	a
6434  0fa0 26fb          	jrne	L031
6435  0fa2 909f          	ld	a,yl
6436  0fa4 e777          	ld	(_can_out_buff,x),a
6437                     ; 1581 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6439  0fa6 b676          	ld	a,_can_buff_wr_ptr
6440  0fa8 97            	ld	xl,a
6441  0fa9 a610          	ld	a,#16
6442  0fab 42            	mul	x,a
6443  0fac 7b02          	ld	a,(OFST+2,sp)
6444  0fae 48            	sll	a
6445  0faf 48            	sll	a
6446  0fb0 e778          	ld	(_can_out_buff+1,x),a
6447                     ; 1583 can_out_buff[can_buff_wr_ptr][2]=data0;
6449  0fb2 b676          	ld	a,_can_buff_wr_ptr
6450  0fb4 97            	ld	xl,a
6451  0fb5 a610          	ld	a,#16
6452  0fb7 42            	mul	x,a
6453  0fb8 7b05          	ld	a,(OFST+5,sp)
6454  0fba e779          	ld	(_can_out_buff+2,x),a
6455                     ; 1584 can_out_buff[can_buff_wr_ptr][3]=data1;
6457  0fbc b676          	ld	a,_can_buff_wr_ptr
6458  0fbe 97            	ld	xl,a
6459  0fbf a610          	ld	a,#16
6460  0fc1 42            	mul	x,a
6461  0fc2 7b06          	ld	a,(OFST+6,sp)
6462  0fc4 e77a          	ld	(_can_out_buff+3,x),a
6463                     ; 1585 can_out_buff[can_buff_wr_ptr][4]=data2;
6465  0fc6 b676          	ld	a,_can_buff_wr_ptr
6466  0fc8 97            	ld	xl,a
6467  0fc9 a610          	ld	a,#16
6468  0fcb 42            	mul	x,a
6469  0fcc 7b07          	ld	a,(OFST+7,sp)
6470  0fce e77b          	ld	(_can_out_buff+4,x),a
6471                     ; 1586 can_out_buff[can_buff_wr_ptr][5]=data3;
6473  0fd0 b676          	ld	a,_can_buff_wr_ptr
6474  0fd2 97            	ld	xl,a
6475  0fd3 a610          	ld	a,#16
6476  0fd5 42            	mul	x,a
6477  0fd6 7b08          	ld	a,(OFST+8,sp)
6478  0fd8 e77c          	ld	(_can_out_buff+5,x),a
6479                     ; 1587 can_out_buff[can_buff_wr_ptr][6]=data4;
6481  0fda b676          	ld	a,_can_buff_wr_ptr
6482  0fdc 97            	ld	xl,a
6483  0fdd a610          	ld	a,#16
6484  0fdf 42            	mul	x,a
6485  0fe0 7b09          	ld	a,(OFST+9,sp)
6486  0fe2 e77d          	ld	(_can_out_buff+6,x),a
6487                     ; 1588 can_out_buff[can_buff_wr_ptr][7]=data5;
6489  0fe4 b676          	ld	a,_can_buff_wr_ptr
6490  0fe6 97            	ld	xl,a
6491  0fe7 a610          	ld	a,#16
6492  0fe9 42            	mul	x,a
6493  0fea 7b0a          	ld	a,(OFST+10,sp)
6494  0fec e77e          	ld	(_can_out_buff+7,x),a
6495                     ; 1589 can_out_buff[can_buff_wr_ptr][8]=data6;
6497  0fee b676          	ld	a,_can_buff_wr_ptr
6498  0ff0 97            	ld	xl,a
6499  0ff1 a610          	ld	a,#16
6500  0ff3 42            	mul	x,a
6501  0ff4 7b0b          	ld	a,(OFST+11,sp)
6502  0ff6 e77f          	ld	(_can_out_buff+8,x),a
6503                     ; 1590 can_out_buff[can_buff_wr_ptr][9]=data7;
6505  0ff8 b676          	ld	a,_can_buff_wr_ptr
6506  0ffa 97            	ld	xl,a
6507  0ffb a610          	ld	a,#16
6508  0ffd 42            	mul	x,a
6509  0ffe 7b0c          	ld	a,(OFST+12,sp)
6510  1000 e780          	ld	(_can_out_buff+9,x),a
6511                     ; 1592 can_buff_wr_ptr++;
6513  1002 3c76          	inc	_can_buff_wr_ptr
6514                     ; 1593 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6516  1004 b676          	ld	a,_can_buff_wr_ptr
6517  1006 a104          	cp	a,#4
6518  1008 2502          	jrult	L1403
6521  100a 3f76          	clr	_can_buff_wr_ptr
6522  100c               L1403:
6523                     ; 1594 } 
6526  100c 85            	popw	x
6527  100d 81            	ret
6556                     ; 1597 void can_tx_hndl(void)
6556                     ; 1598 {
6557                     	switch	.text
6558  100e               _can_tx_hndl:
6562                     ; 1599 if(bTX_FREE)
6564  100e 3d03          	tnz	_bTX_FREE
6565  1010 2757          	jreq	L3503
6566                     ; 1601 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6568  1012 b675          	ld	a,_can_buff_rd_ptr
6569  1014 b176          	cp	a,_can_buff_wr_ptr
6570  1016 275f          	jreq	L1603
6571                     ; 1603 		bTX_FREE=0;
6573  1018 3f03          	clr	_bTX_FREE
6574                     ; 1605 		CAN->PSR= 0;
6576  101a 725f5427      	clr	21543
6577                     ; 1606 		CAN->Page.TxMailbox.MDLCR=8;
6579  101e 35085429      	mov	21545,#8
6580                     ; 1607 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6582  1022 b675          	ld	a,_can_buff_rd_ptr
6583  1024 97            	ld	xl,a
6584  1025 a610          	ld	a,#16
6585  1027 42            	mul	x,a
6586  1028 e677          	ld	a,(_can_out_buff,x)
6587  102a c7542a        	ld	21546,a
6588                     ; 1608 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6590  102d b675          	ld	a,_can_buff_rd_ptr
6591  102f 97            	ld	xl,a
6592  1030 a610          	ld	a,#16
6593  1032 42            	mul	x,a
6594  1033 e678          	ld	a,(_can_out_buff+1,x)
6595  1035 c7542b        	ld	21547,a
6596                     ; 1610 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6598  1038 b675          	ld	a,_can_buff_rd_ptr
6599  103a 97            	ld	xl,a
6600  103b a610          	ld	a,#16
6601  103d 42            	mul	x,a
6602  103e 01            	rrwa	x,a
6603  103f ab79          	add	a,#_can_out_buff+2
6604  1041 2401          	jrnc	L431
6605  1043 5c            	incw	x
6606  1044               L431:
6607  1044 5f            	clrw	x
6608  1045 97            	ld	xl,a
6609  1046 bf00          	ldw	c_x,x
6610  1048 ae0008        	ldw	x,#8
6611  104b               L631:
6612  104b 5a            	decw	x
6613  104c 92d600        	ld	a,([c_x],x)
6614  104f d7542e        	ld	(21550,x),a
6615  1052 5d            	tnzw	x
6616  1053 26f6          	jrne	L631
6617                     ; 1612 		can_buff_rd_ptr++;
6619  1055 3c75          	inc	_can_buff_rd_ptr
6620                     ; 1613 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6622  1057 b675          	ld	a,_can_buff_rd_ptr
6623  1059 a104          	cp	a,#4
6624  105b 2502          	jrult	L7503
6627  105d 3f75          	clr	_can_buff_rd_ptr
6628  105f               L7503:
6629                     ; 1615 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6631  105f 72105428      	bset	21544,#0
6632                     ; 1616 		CAN->IER|=(1<<0);
6634  1063 72105425      	bset	21541,#0
6635  1067 200e          	jra	L1603
6636  1069               L3503:
6637                     ; 1621 	tx_busy_cnt++;
6639  1069 3c74          	inc	_tx_busy_cnt
6640                     ; 1622 	if(tx_busy_cnt>=100)
6642  106b b674          	ld	a,_tx_busy_cnt
6643  106d a164          	cp	a,#100
6644  106f 2506          	jrult	L1603
6645                     ; 1624 		tx_busy_cnt=0;
6647  1071 3f74          	clr	_tx_busy_cnt
6648                     ; 1625 		bTX_FREE=1;
6650  1073 35010003      	mov	_bTX_FREE,#1
6651  1077               L1603:
6652                     ; 1628 }
6655  1077 81            	ret
6770                     ; 1654 void can_in_an(void)
6770                     ; 1655 {
6771                     	switch	.text
6772  1078               _can_in_an:
6774  1078 5207          	subw	sp,#7
6775       00000007      OFST:	set	7
6778                     ; 1665 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6780  107a b6cd          	ld	a,_mess+6
6781  107c c100f7        	cp	a,_adress
6782  107f 2703          	jreq	L651
6783  1081 cc11b9        	jp	L1213
6784  1084               L651:
6786  1084 b6ce          	ld	a,_mess+7
6787  1086 c100f7        	cp	a,_adress
6788  1089 2703          	jreq	L061
6789  108b cc11b9        	jp	L1213
6790  108e               L061:
6792  108e b6cf          	ld	a,_mess+8
6793  1090 a1ed          	cp	a,#237
6794  1092 2703          	jreq	L261
6795  1094 cc11b9        	jp	L1213
6796  1097               L261:
6797                     ; 1668 	can_error_cnt=0;
6799  1097 3f73          	clr	_can_error_cnt
6800                     ; 1670 	bMAIN=0;
6802  1099 72110001      	bres	_bMAIN
6803                     ; 1671  	flags_tu=mess[9];
6805  109d 45d06a        	mov	_flags_tu,_mess+9
6806                     ; 1672  	if(flags_tu&0b00000001)
6808  10a0 b66a          	ld	a,_flags_tu
6809  10a2 a501          	bcp	a,#1
6810  10a4 2706          	jreq	L3213
6811                     ; 1677  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6813  10a6 721a0005      	bset	_flags,#5
6815  10aa 2008          	jra	L5213
6816  10ac               L3213:
6817                     ; 1688  				flags&=0b11011111; 
6819  10ac 721b0005      	bres	_flags,#5
6820                     ; 1689  				off_bp_cnt=5*EE_TZAS;
6822  10b0 350f005d      	mov	_off_bp_cnt,#15
6823  10b4               L5213:
6824                     ; 1695  	if(flags_tu&0b00000010) flags|=0b01000000;
6826  10b4 b66a          	ld	a,_flags_tu
6827  10b6 a502          	bcp	a,#2
6828  10b8 2706          	jreq	L7213
6831  10ba 721c0005      	bset	_flags,#6
6833  10be 2004          	jra	L1313
6834  10c0               L7213:
6835                     ; 1696  	else flags&=0b10111111; 
6837  10c0 721d0005      	bres	_flags,#6
6838  10c4               L1313:
6839                     ; 1698  	U_out_const=mess[10]+mess[11]*256;
6841  10c4 b6d2          	ld	a,_mess+11
6842  10c6 5f            	clrw	x
6843  10c7 97            	ld	xl,a
6844  10c8 4f            	clr	a
6845  10c9 02            	rlwa	x,a
6846  10ca 01            	rrwa	x,a
6847  10cb bbd1          	add	a,_mess+10
6848  10cd 2401          	jrnc	L241
6849  10cf 5c            	incw	x
6850  10d0               L241:
6851  10d0 c70009        	ld	_U_out_const+1,a
6852  10d3 9f            	ld	a,xl
6853  10d4 c70008        	ld	_U_out_const,a
6854                     ; 1699  	vol_i_temp=mess[12]+mess[13]*256;  
6856  10d7 b6d4          	ld	a,_mess+13
6857  10d9 5f            	clrw	x
6858  10da 97            	ld	xl,a
6859  10db 4f            	clr	a
6860  10dc 02            	rlwa	x,a
6861  10dd 01            	rrwa	x,a
6862  10de bbd3          	add	a,_mess+12
6863  10e0 2401          	jrnc	L441
6864  10e2 5c            	incw	x
6865  10e3               L441:
6866  10e3 b761          	ld	_vol_i_temp+1,a
6867  10e5 9f            	ld	a,xl
6868  10e6 b760          	ld	_vol_i_temp,a
6869                     ; 1709 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6871  10e8 b608          	ld	a,_vent_resurs_tx_cnt
6872  10ea a102          	cp	a,#2
6873  10ec 2507          	jrult	L3313
6876  10ee ce0000        	ldw	x,_vent_resurs
6877  10f1 bf41          	ldw	_plazma_int+4,x
6879  10f3 2004          	jra	L5313
6880  10f5               L3313:
6881                     ; 1710 	else plazma_int[2]=vent_resurs_sec_cnt;
6883  10f5 be09          	ldw	x,_vent_resurs_sec_cnt
6884  10f7 bf41          	ldw	_plazma_int+4,x
6885  10f9               L5313:
6886                     ; 1711  	rotor_int=flags_tu+(((short)flags)<<8);
6888  10f9 b605          	ld	a,_flags
6889  10fb 5f            	clrw	x
6890  10fc 97            	ld	xl,a
6891  10fd 4f            	clr	a
6892  10fe 02            	rlwa	x,a
6893  10ff 01            	rrwa	x,a
6894  1100 bb6a          	add	a,_flags_tu
6895  1102 2401          	jrnc	L641
6896  1104 5c            	incw	x
6897  1105               L641:
6898  1105 b718          	ld	_rotor_int+1,a
6899  1107 9f            	ld	a,xl
6900  1108 b717          	ld	_rotor_int,a
6901                     ; 1712 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6903  110a 3b000c        	push	_Ui
6904  110d 3b000d        	push	_Ui+1
6905  1110 3b000e        	push	_Un
6906  1113 3b000f        	push	_Un+1
6907  1116 3b0010        	push	_I
6908  1119 3b0011        	push	_I+1
6909  111c 4bda          	push	#218
6910  111e 3b00f7        	push	_adress
6911  1121 ae018e        	ldw	x,#398
6912  1124 cd0f8a        	call	_can_transmit
6914  1127 5b08          	addw	sp,#8
6915                     ; 1713 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6917  1129 3b0006        	push	_Usum
6918  112c 3b0007        	push	_Usum+1
6919  112f 3b0069        	push	__x_+1
6920  1132 3b0005        	push	_flags
6921  1135 b608          	ld	a,_vent_resurs_tx_cnt
6922  1137 5f            	clrw	x
6923  1138 97            	ld	xl,a
6924  1139 d60000        	ld	a,(_vent_resurs_buff,x)
6925  113c 88            	push	a
6926  113d 3b0072        	push	_T
6927  1140 4bdb          	push	#219
6928  1142 3b00f7        	push	_adress
6929  1145 ae018e        	ldw	x,#398
6930  1148 cd0f8a        	call	_can_transmit
6932  114b 5b08          	addw	sp,#8
6933                     ; 1714 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6935  114d 3b0005        	push	_debug_info_to_uku+4
6936  1150 3b0006        	push	_debug_info_to_uku+5
6937  1153 3b0003        	push	_debug_info_to_uku+2
6938  1156 3b0004        	push	_debug_info_to_uku+3
6939  1159 3b0001        	push	_debug_info_to_uku
6940  115c 3b0002        	push	_debug_info_to_uku+1
6941  115f 4bdc          	push	#220
6942  1161 3b00f7        	push	_adress
6943  1164 ae018e        	ldw	x,#398
6944  1167 cd0f8a        	call	_can_transmit
6946  116a 5b08          	addw	sp,#8
6947                     ; 1715      link_cnt=0;
6949  116c 5f            	clrw	x
6950  116d bf6b          	ldw	_link_cnt,x
6951                     ; 1716      link=ON;
6953  116f 3555006d      	mov	_link,#85
6954                     ; 1718      if(flags_tu&0b10000000)
6956  1173 b66a          	ld	a,_flags_tu
6957  1175 a580          	bcp	a,#128
6958  1177 2716          	jreq	L7313
6959                     ; 1720      	if(!res_fl)
6961  1179 725d000b      	tnz	_res_fl
6962  117d 2626          	jrne	L3413
6963                     ; 1722      		res_fl=1;
6965  117f a601          	ld	a,#1
6966  1181 ae000b        	ldw	x,#_res_fl
6967  1184 cd0000        	call	c_eewrc
6969                     ; 1723      		bRES=1;
6971  1187 3501000c      	mov	_bRES,#1
6972                     ; 1724      		res_fl_cnt=0;
6974  118b 3f4b          	clr	_res_fl_cnt
6975  118d 2016          	jra	L3413
6976  118f               L7313:
6977                     ; 1729      	if(main_cnt>20)
6979  118f 9c            	rvf
6980  1190 ce0255        	ldw	x,_main_cnt
6981  1193 a30015        	cpw	x,#21
6982  1196 2f0d          	jrslt	L3413
6983                     ; 1731     			if(res_fl)
6985  1198 725d000b      	tnz	_res_fl
6986  119c 2707          	jreq	L3413
6987                     ; 1733      			res_fl=0;
6989  119e 4f            	clr	a
6990  119f ae000b        	ldw	x,#_res_fl
6991  11a2 cd0000        	call	c_eewrc
6993  11a5               L3413:
6994                     ; 1738       if(res_fl_)
6996  11a5 725d000a      	tnz	_res_fl_
6997  11a9 2603          	jrne	L461
6998  11ab cc1720        	jp	L5603
6999  11ae               L461:
7000                     ; 1740       	res_fl_=0;
7002  11ae 4f            	clr	a
7003  11af ae000a        	ldw	x,#_res_fl_
7004  11b2 cd0000        	call	c_eewrc
7006  11b5 ac201720      	jpf	L5603
7007  11b9               L1213:
7008                     ; 1743 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7010  11b9 b6cd          	ld	a,_mess+6
7011  11bb c100f7        	cp	a,_adress
7012  11be 2703          	jreq	L661
7013  11c0 cc1436        	jp	L5513
7014  11c3               L661:
7016  11c3 b6ce          	ld	a,_mess+7
7017  11c5 c100f7        	cp	a,_adress
7018  11c8 2703          	jreq	L071
7019  11ca cc1436        	jp	L5513
7020  11cd               L071:
7022  11cd b6cf          	ld	a,_mess+8
7023  11cf a1ee          	cp	a,#238
7024  11d1 2703          	jreq	L271
7025  11d3 cc1436        	jp	L5513
7026  11d6               L271:
7028  11d6 b6d0          	ld	a,_mess+9
7029  11d8 b1d1          	cp	a,_mess+10
7030  11da 2703          	jreq	L471
7031  11dc cc1436        	jp	L5513
7032  11df               L471:
7033                     ; 1745 	rotor_int++;
7035  11df be17          	ldw	x,_rotor_int
7036  11e1 1c0001        	addw	x,#1
7037  11e4 bf17          	ldw	_rotor_int,x
7038                     ; 1746 	if((mess[9]&0xf0)==0x20)
7040  11e6 b6d0          	ld	a,_mess+9
7041  11e8 a4f0          	and	a,#240
7042  11ea a120          	cp	a,#32
7043  11ec 2673          	jrne	L7513
7044                     ; 1748 		if((mess[9]&0x0f)==0x01)
7046  11ee b6d0          	ld	a,_mess+9
7047  11f0 a40f          	and	a,#15
7048  11f2 a101          	cp	a,#1
7049  11f4 260d          	jrne	L1613
7050                     ; 1750 			ee_K[0][0]=adc_buff_[4];
7052  11f6 ce0107        	ldw	x,_adc_buff_+8
7053  11f9 89            	pushw	x
7054  11fa ae001a        	ldw	x,#_ee_K
7055  11fd cd0000        	call	c_eewrw
7057  1200 85            	popw	x
7059  1201 204a          	jra	L3613
7060  1203               L1613:
7061                     ; 1752 		else if((mess[9]&0x0f)==0x02)
7063  1203 b6d0          	ld	a,_mess+9
7064  1205 a40f          	and	a,#15
7065  1207 a102          	cp	a,#2
7066  1209 260b          	jrne	L5613
7067                     ; 1754 			ee_K[0][1]++;
7069  120b ce001c        	ldw	x,_ee_K+2
7070  120e 1c0001        	addw	x,#1
7071  1211 cf001c        	ldw	_ee_K+2,x
7073  1214 2037          	jra	L3613
7074  1216               L5613:
7075                     ; 1756 		else if((mess[9]&0x0f)==0x03)
7077  1216 b6d0          	ld	a,_mess+9
7078  1218 a40f          	and	a,#15
7079  121a a103          	cp	a,#3
7080  121c 260b          	jrne	L1713
7081                     ; 1758 			ee_K[0][1]+=10;
7083  121e ce001c        	ldw	x,_ee_K+2
7084  1221 1c000a        	addw	x,#10
7085  1224 cf001c        	ldw	_ee_K+2,x
7087  1227 2024          	jra	L3613
7088  1229               L1713:
7089                     ; 1760 		else if((mess[9]&0x0f)==0x04)
7091  1229 b6d0          	ld	a,_mess+9
7092  122b a40f          	and	a,#15
7093  122d a104          	cp	a,#4
7094  122f 260b          	jrne	L5713
7095                     ; 1762 			ee_K[0][1]--;
7097  1231 ce001c        	ldw	x,_ee_K+2
7098  1234 1d0001        	subw	x,#1
7099  1237 cf001c        	ldw	_ee_K+2,x
7101  123a 2011          	jra	L3613
7102  123c               L5713:
7103                     ; 1764 		else if((mess[9]&0x0f)==0x05)
7105  123c b6d0          	ld	a,_mess+9
7106  123e a40f          	and	a,#15
7107  1240 a105          	cp	a,#5
7108  1242 2609          	jrne	L3613
7109                     ; 1766 			ee_K[0][1]-=10;
7111  1244 ce001c        	ldw	x,_ee_K+2
7112  1247 1d000a        	subw	x,#10
7113  124a cf001c        	ldw	_ee_K+2,x
7114  124d               L3613:
7115                     ; 1768 		granee(&ee_K[0][1],50,3000);									
7117  124d ae0bb8        	ldw	x,#3000
7118  1250 89            	pushw	x
7119  1251 ae0032        	ldw	x,#50
7120  1254 89            	pushw	x
7121  1255 ae001c        	ldw	x,#_ee_K+2
7122  1258 cd00f6        	call	_granee
7124  125b 5b04          	addw	sp,#4
7126  125d ac1b141b      	jpf	L3023
7127  1261               L7513:
7128                     ; 1770 	else if((mess[9]&0xf0)==0x10)
7130  1261 b6d0          	ld	a,_mess+9
7131  1263 a4f0          	and	a,#240
7132  1265 a110          	cp	a,#16
7133  1267 2673          	jrne	L5023
7134                     ; 1772 		if((mess[9]&0x0f)==0x01)
7136  1269 b6d0          	ld	a,_mess+9
7137  126b a40f          	and	a,#15
7138  126d a101          	cp	a,#1
7139  126f 260d          	jrne	L7023
7140                     ; 1774 			ee_K[1][0]=adc_buff_[1];
7142  1271 ce0101        	ldw	x,_adc_buff_+2
7143  1274 89            	pushw	x
7144  1275 ae001e        	ldw	x,#_ee_K+4
7145  1278 cd0000        	call	c_eewrw
7147  127b 85            	popw	x
7149  127c 204a          	jra	L1123
7150  127e               L7023:
7151                     ; 1776 		else if((mess[9]&0x0f)==0x02)
7153  127e b6d0          	ld	a,_mess+9
7154  1280 a40f          	and	a,#15
7155  1282 a102          	cp	a,#2
7156  1284 260b          	jrne	L3123
7157                     ; 1778 			ee_K[1][1]++;
7159  1286 ce0020        	ldw	x,_ee_K+6
7160  1289 1c0001        	addw	x,#1
7161  128c cf0020        	ldw	_ee_K+6,x
7163  128f 2037          	jra	L1123
7164  1291               L3123:
7165                     ; 1780 		else if((mess[9]&0x0f)==0x03)
7167  1291 b6d0          	ld	a,_mess+9
7168  1293 a40f          	and	a,#15
7169  1295 a103          	cp	a,#3
7170  1297 260b          	jrne	L7123
7171                     ; 1782 			ee_K[1][1]+=10;
7173  1299 ce0020        	ldw	x,_ee_K+6
7174  129c 1c000a        	addw	x,#10
7175  129f cf0020        	ldw	_ee_K+6,x
7177  12a2 2024          	jra	L1123
7178  12a4               L7123:
7179                     ; 1784 		else if((mess[9]&0x0f)==0x04)
7181  12a4 b6d0          	ld	a,_mess+9
7182  12a6 a40f          	and	a,#15
7183  12a8 a104          	cp	a,#4
7184  12aa 260b          	jrne	L3223
7185                     ; 1786 			ee_K[1][1]--;
7187  12ac ce0020        	ldw	x,_ee_K+6
7188  12af 1d0001        	subw	x,#1
7189  12b2 cf0020        	ldw	_ee_K+6,x
7191  12b5 2011          	jra	L1123
7192  12b7               L3223:
7193                     ; 1788 		else if((mess[9]&0x0f)==0x05)
7195  12b7 b6d0          	ld	a,_mess+9
7196  12b9 a40f          	and	a,#15
7197  12bb a105          	cp	a,#5
7198  12bd 2609          	jrne	L1123
7199                     ; 1790 			ee_K[1][1]-=10;
7201  12bf ce0020        	ldw	x,_ee_K+6
7202  12c2 1d000a        	subw	x,#10
7203  12c5 cf0020        	ldw	_ee_K+6,x
7204  12c8               L1123:
7205                     ; 1795 		granee(&ee_K[1][1],10,30000);
7207  12c8 ae7530        	ldw	x,#30000
7208  12cb 89            	pushw	x
7209  12cc ae000a        	ldw	x,#10
7210  12cf 89            	pushw	x
7211  12d0 ae0020        	ldw	x,#_ee_K+6
7212  12d3 cd00f6        	call	_granee
7214  12d6 5b04          	addw	sp,#4
7216  12d8 ac1b141b      	jpf	L3023
7217  12dc               L5023:
7218                     ; 1799 	else if((mess[9]&0xf0)==0x00)
7220  12dc b6d0          	ld	a,_mess+9
7221  12de a5f0          	bcp	a,#240
7222  12e0 2673          	jrne	L3323
7223                     ; 1801 		if((mess[9]&0x0f)==0x01)
7225  12e2 b6d0          	ld	a,_mess+9
7226  12e4 a40f          	and	a,#15
7227  12e6 a101          	cp	a,#1
7228  12e8 260d          	jrne	L5323
7229                     ; 1803 			ee_K[2][0]=adc_buff_[2];
7231  12ea ce0103        	ldw	x,_adc_buff_+4
7232  12ed 89            	pushw	x
7233  12ee ae0022        	ldw	x,#_ee_K+8
7234  12f1 cd0000        	call	c_eewrw
7236  12f4 85            	popw	x
7238  12f5 204a          	jra	L7323
7239  12f7               L5323:
7240                     ; 1805 		else if((mess[9]&0x0f)==0x02)
7242  12f7 b6d0          	ld	a,_mess+9
7243  12f9 a40f          	and	a,#15
7244  12fb a102          	cp	a,#2
7245  12fd 260b          	jrne	L1423
7246                     ; 1807 			ee_K[2][1]++;
7248  12ff ce0024        	ldw	x,_ee_K+10
7249  1302 1c0001        	addw	x,#1
7250  1305 cf0024        	ldw	_ee_K+10,x
7252  1308 2037          	jra	L7323
7253  130a               L1423:
7254                     ; 1809 		else if((mess[9]&0x0f)==0x03)
7256  130a b6d0          	ld	a,_mess+9
7257  130c a40f          	and	a,#15
7258  130e a103          	cp	a,#3
7259  1310 260b          	jrne	L5423
7260                     ; 1811 			ee_K[2][1]+=10;
7262  1312 ce0024        	ldw	x,_ee_K+10
7263  1315 1c000a        	addw	x,#10
7264  1318 cf0024        	ldw	_ee_K+10,x
7266  131b 2024          	jra	L7323
7267  131d               L5423:
7268                     ; 1813 		else if((mess[9]&0x0f)==0x04)
7270  131d b6d0          	ld	a,_mess+9
7271  131f a40f          	and	a,#15
7272  1321 a104          	cp	a,#4
7273  1323 260b          	jrne	L1523
7274                     ; 1815 			ee_K[2][1]--;
7276  1325 ce0024        	ldw	x,_ee_K+10
7277  1328 1d0001        	subw	x,#1
7278  132b cf0024        	ldw	_ee_K+10,x
7280  132e 2011          	jra	L7323
7281  1330               L1523:
7282                     ; 1817 		else if((mess[9]&0x0f)==0x05)
7284  1330 b6d0          	ld	a,_mess+9
7285  1332 a40f          	and	a,#15
7286  1334 a105          	cp	a,#5
7287  1336 2609          	jrne	L7323
7288                     ; 1819 			ee_K[2][1]-=10;
7290  1338 ce0024        	ldw	x,_ee_K+10
7291  133b 1d000a        	subw	x,#10
7292  133e cf0024        	ldw	_ee_K+10,x
7293  1341               L7323:
7294                     ; 1824 		granee(&ee_K[2][1],10,30000);
7296  1341 ae7530        	ldw	x,#30000
7297  1344 89            	pushw	x
7298  1345 ae000a        	ldw	x,#10
7299  1348 89            	pushw	x
7300  1349 ae0024        	ldw	x,#_ee_K+10
7301  134c cd00f6        	call	_granee
7303  134f 5b04          	addw	sp,#4
7305  1351 ac1b141b      	jpf	L3023
7306  1355               L3323:
7307                     ; 1828 	else if((mess[9]&0xf0)==0x30)
7309  1355 b6d0          	ld	a,_mess+9
7310  1357 a4f0          	and	a,#240
7311  1359 a130          	cp	a,#48
7312  135b 265c          	jrne	L1623
7313                     ; 1830 		if((mess[9]&0x0f)==0x02)
7315  135d b6d0          	ld	a,_mess+9
7316  135f a40f          	and	a,#15
7317  1361 a102          	cp	a,#2
7318  1363 260b          	jrne	L3623
7319                     ; 1832 			ee_K[3][1]++;
7321  1365 ce0028        	ldw	x,_ee_K+14
7322  1368 1c0001        	addw	x,#1
7323  136b cf0028        	ldw	_ee_K+14,x
7325  136e 2037          	jra	L5623
7326  1370               L3623:
7327                     ; 1834 		else if((mess[9]&0x0f)==0x03)
7329  1370 b6d0          	ld	a,_mess+9
7330  1372 a40f          	and	a,#15
7331  1374 a103          	cp	a,#3
7332  1376 260b          	jrne	L7623
7333                     ; 1836 			ee_K[3][1]+=10;
7335  1378 ce0028        	ldw	x,_ee_K+14
7336  137b 1c000a        	addw	x,#10
7337  137e cf0028        	ldw	_ee_K+14,x
7339  1381 2024          	jra	L5623
7340  1383               L7623:
7341                     ; 1838 		else if((mess[9]&0x0f)==0x04)
7343  1383 b6d0          	ld	a,_mess+9
7344  1385 a40f          	and	a,#15
7345  1387 a104          	cp	a,#4
7346  1389 260b          	jrne	L3723
7347                     ; 1840 			ee_K[3][1]--;
7349  138b ce0028        	ldw	x,_ee_K+14
7350  138e 1d0001        	subw	x,#1
7351  1391 cf0028        	ldw	_ee_K+14,x
7353  1394 2011          	jra	L5623
7354  1396               L3723:
7355                     ; 1842 		else if((mess[9]&0x0f)==0x05)
7357  1396 b6d0          	ld	a,_mess+9
7358  1398 a40f          	and	a,#15
7359  139a a105          	cp	a,#5
7360  139c 2609          	jrne	L5623
7361                     ; 1844 			ee_K[3][1]-=10;
7363  139e ce0028        	ldw	x,_ee_K+14
7364  13a1 1d000a        	subw	x,#10
7365  13a4 cf0028        	ldw	_ee_K+14,x
7366  13a7               L5623:
7367                     ; 1846 		granee(&ee_K[3][1],300,517);									
7369  13a7 ae0205        	ldw	x,#517
7370  13aa 89            	pushw	x
7371  13ab ae012c        	ldw	x,#300
7372  13ae 89            	pushw	x
7373  13af ae0028        	ldw	x,#_ee_K+14
7374  13b2 cd00f6        	call	_granee
7376  13b5 5b04          	addw	sp,#4
7378  13b7 2062          	jra	L3023
7379  13b9               L1623:
7380                     ; 1849 	else if((mess[9]&0xf0)==0x50)
7382  13b9 b6d0          	ld	a,_mess+9
7383  13bb a4f0          	and	a,#240
7384  13bd a150          	cp	a,#80
7385  13bf 265a          	jrne	L3023
7386                     ; 1851 		if((mess[9]&0x0f)==0x02)
7388  13c1 b6d0          	ld	a,_mess+9
7389  13c3 a40f          	and	a,#15
7390  13c5 a102          	cp	a,#2
7391  13c7 260b          	jrne	L5033
7392                     ; 1853 			ee_K[4][1]++;
7394  13c9 ce002c        	ldw	x,_ee_K+18
7395  13cc 1c0001        	addw	x,#1
7396  13cf cf002c        	ldw	_ee_K+18,x
7398  13d2 2037          	jra	L7033
7399  13d4               L5033:
7400                     ; 1855 		else if((mess[9]&0x0f)==0x03)
7402  13d4 b6d0          	ld	a,_mess+9
7403  13d6 a40f          	and	a,#15
7404  13d8 a103          	cp	a,#3
7405  13da 260b          	jrne	L1133
7406                     ; 1857 			ee_K[4][1]+=10;
7408  13dc ce002c        	ldw	x,_ee_K+18
7409  13df 1c000a        	addw	x,#10
7410  13e2 cf002c        	ldw	_ee_K+18,x
7412  13e5 2024          	jra	L7033
7413  13e7               L1133:
7414                     ; 1859 		else if((mess[9]&0x0f)==0x04)
7416  13e7 b6d0          	ld	a,_mess+9
7417  13e9 a40f          	and	a,#15
7418  13eb a104          	cp	a,#4
7419  13ed 260b          	jrne	L5133
7420                     ; 1861 			ee_K[4][1]--;
7422  13ef ce002c        	ldw	x,_ee_K+18
7423  13f2 1d0001        	subw	x,#1
7424  13f5 cf002c        	ldw	_ee_K+18,x
7426  13f8 2011          	jra	L7033
7427  13fa               L5133:
7428                     ; 1863 		else if((mess[9]&0x0f)==0x05)
7430  13fa b6d0          	ld	a,_mess+9
7431  13fc a40f          	and	a,#15
7432  13fe a105          	cp	a,#5
7433  1400 2609          	jrne	L7033
7434                     ; 1865 			ee_K[4][1]-=10;
7436  1402 ce002c        	ldw	x,_ee_K+18
7437  1405 1d000a        	subw	x,#10
7438  1408 cf002c        	ldw	_ee_K+18,x
7439  140b               L7033:
7440                     ; 1867 		granee(&ee_K[4][1],10,30000);									
7442  140b ae7530        	ldw	x,#30000
7443  140e 89            	pushw	x
7444  140f ae000a        	ldw	x,#10
7445  1412 89            	pushw	x
7446  1413 ae002c        	ldw	x,#_ee_K+18
7447  1416 cd00f6        	call	_granee
7449  1419 5b04          	addw	sp,#4
7450  141b               L3023:
7451                     ; 1870 	link_cnt=0;
7453  141b 5f            	clrw	x
7454  141c bf6b          	ldw	_link_cnt,x
7455                     ; 1871      link=ON;
7457  141e 3555006d      	mov	_link,#85
7458                     ; 1872      if(res_fl_)
7460  1422 725d000a      	tnz	_res_fl_
7461  1426 2603          	jrne	L671
7462  1428 cc1720        	jp	L5603
7463  142b               L671:
7464                     ; 1874       	res_fl_=0;
7466  142b 4f            	clr	a
7467  142c ae000a        	ldw	x,#_res_fl_
7468  142f cd0000        	call	c_eewrc
7470  1432 ac201720      	jpf	L5603
7471  1436               L5513:
7472                     ; 1880 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7474  1436 b6cd          	ld	a,_mess+6
7475  1438 a1ff          	cp	a,#255
7476  143a 2703          	jreq	L002
7477  143c cc14ca        	jp	L7233
7478  143f               L002:
7480  143f b6ce          	ld	a,_mess+7
7481  1441 a1ff          	cp	a,#255
7482  1443 2703          	jreq	L202
7483  1445 cc14ca        	jp	L7233
7484  1448               L202:
7486  1448 b6cf          	ld	a,_mess+8
7487  144a a162          	cp	a,#98
7488  144c 267c          	jrne	L7233
7489                     ; 1883 	tempSS=mess[9]+(mess[10]*256);
7491  144e b6d1          	ld	a,_mess+10
7492  1450 5f            	clrw	x
7493  1451 97            	ld	xl,a
7494  1452 4f            	clr	a
7495  1453 02            	rlwa	x,a
7496  1454 01            	rrwa	x,a
7497  1455 bbd0          	add	a,_mess+9
7498  1457 2401          	jrnc	L051
7499  1459 5c            	incw	x
7500  145a               L051:
7501  145a 02            	rlwa	x,a
7502  145b 1f03          	ldw	(OFST-4,sp),x
7503  145d 01            	rrwa	x,a
7504                     ; 1884 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7506  145e ce0014        	ldw	x,_ee_Umax
7507  1461 1303          	cpw	x,(OFST-4,sp)
7508  1463 270a          	jreq	L1333
7511  1465 1e03          	ldw	x,(OFST-4,sp)
7512  1467 89            	pushw	x
7513  1468 ae0014        	ldw	x,#_ee_Umax
7514  146b cd0000        	call	c_eewrw
7516  146e 85            	popw	x
7517  146f               L1333:
7518                     ; 1885 	tempSS=mess[11]+(mess[12]*256);
7520  146f b6d3          	ld	a,_mess+12
7521  1471 5f            	clrw	x
7522  1472 97            	ld	xl,a
7523  1473 4f            	clr	a
7524  1474 02            	rlwa	x,a
7525  1475 01            	rrwa	x,a
7526  1476 bbd2          	add	a,_mess+11
7527  1478 2401          	jrnc	L251
7528  147a 5c            	incw	x
7529  147b               L251:
7530  147b 02            	rlwa	x,a
7531  147c 1f03          	ldw	(OFST-4,sp),x
7532  147e 01            	rrwa	x,a
7533                     ; 1886 	if(ee_dU!=tempSS) ee_dU=tempSS;
7535  147f ce0012        	ldw	x,_ee_dU
7536  1482 1303          	cpw	x,(OFST-4,sp)
7537  1484 270a          	jreq	L3333
7540  1486 1e03          	ldw	x,(OFST-4,sp)
7541  1488 89            	pushw	x
7542  1489 ae0012        	ldw	x,#_ee_dU
7543  148c cd0000        	call	c_eewrw
7545  148f 85            	popw	x
7546  1490               L3333:
7547                     ; 1887 	if((mess[13]&0x0f)==0x5)
7549  1490 b6d4          	ld	a,_mess+13
7550  1492 a40f          	and	a,#15
7551  1494 a105          	cp	a,#5
7552  1496 261a          	jrne	L5333
7553                     ; 1889 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7555  1498 ce0006        	ldw	x,_ee_AVT_MODE
7556  149b a30055        	cpw	x,#85
7557  149e 2603          	jrne	L402
7558  14a0 cc1720        	jp	L5603
7559  14a3               L402:
7562  14a3 ae0055        	ldw	x,#85
7563  14a6 89            	pushw	x
7564  14a7 ae0006        	ldw	x,#_ee_AVT_MODE
7565  14aa cd0000        	call	c_eewrw
7567  14ad 85            	popw	x
7568  14ae ac201720      	jpf	L5603
7569  14b2               L5333:
7570                     ; 1891 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7572  14b2 ce0006        	ldw	x,_ee_AVT_MODE
7573  14b5 a30055        	cpw	x,#85
7574  14b8 2703          	jreq	L602
7575  14ba cc1720        	jp	L5603
7576  14bd               L602:
7579  14bd 5f            	clrw	x
7580  14be 89            	pushw	x
7581  14bf ae0006        	ldw	x,#_ee_AVT_MODE
7582  14c2 cd0000        	call	c_eewrw
7584  14c5 85            	popw	x
7585  14c6 ac201720      	jpf	L5603
7586  14ca               L7233:
7587                     ; 1894 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7589  14ca b6cd          	ld	a,_mess+6
7590  14cc a1ff          	cp	a,#255
7591  14ce 2703          	jreq	L012
7592  14d0 cc1586        	jp	L7433
7593  14d3               L012:
7595  14d3 b6ce          	ld	a,_mess+7
7596  14d5 a1ff          	cp	a,#255
7597  14d7 2703          	jreq	L212
7598  14d9 cc1586        	jp	L7433
7599  14dc               L212:
7601  14dc b6cf          	ld	a,_mess+8
7602  14de a126          	cp	a,#38
7603  14e0 2709          	jreq	L1533
7605  14e2 b6cf          	ld	a,_mess+8
7606  14e4 a129          	cp	a,#41
7607  14e6 2703          	jreq	L412
7608  14e8 cc1586        	jp	L7433
7609  14eb               L412:
7610  14eb               L1533:
7611                     ; 1897 	tempSS=mess[9]+(mess[10]*256);
7613  14eb b6d1          	ld	a,_mess+10
7614  14ed 5f            	clrw	x
7615  14ee 97            	ld	xl,a
7616  14ef 4f            	clr	a
7617  14f0 02            	rlwa	x,a
7618  14f1 01            	rrwa	x,a
7619  14f2 bbd0          	add	a,_mess+9
7620  14f4 2401          	jrnc	L451
7621  14f6 5c            	incw	x
7622  14f7               L451:
7623  14f7 02            	rlwa	x,a
7624  14f8 1f03          	ldw	(OFST-4,sp),x
7625  14fa 01            	rrwa	x,a
7626                     ; 1899 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7628  14fb ce000c        	ldw	x,_ee_UAVT
7629  14fe 1303          	cpw	x,(OFST-4,sp)
7630  1500 270a          	jreq	L3533
7633  1502 1e03          	ldw	x,(OFST-4,sp)
7634  1504 89            	pushw	x
7635  1505 ae000c        	ldw	x,#_ee_UAVT
7636  1508 cd0000        	call	c_eewrw
7638  150b 85            	popw	x
7639  150c               L3533:
7640                     ; 1900 	tempSS=(signed short)mess[11];
7642  150c b6d2          	ld	a,_mess+11
7643  150e 5f            	clrw	x
7644  150f 97            	ld	xl,a
7645  1510 1f03          	ldw	(OFST-4,sp),x
7646                     ; 1901 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7648  1512 ce0010        	ldw	x,_ee_tmax
7649  1515 1303          	cpw	x,(OFST-4,sp)
7650  1517 270a          	jreq	L5533
7653  1519 1e03          	ldw	x,(OFST-4,sp)
7654  151b 89            	pushw	x
7655  151c ae0010        	ldw	x,#_ee_tmax
7656  151f cd0000        	call	c_eewrw
7658  1522 85            	popw	x
7659  1523               L5533:
7660                     ; 1902 	tempSS=(signed short)mess[12];
7662  1523 b6d3          	ld	a,_mess+12
7663  1525 5f            	clrw	x
7664  1526 97            	ld	xl,a
7665  1527 1f03          	ldw	(OFST-4,sp),x
7666                     ; 1903 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7668  1529 ce000e        	ldw	x,_ee_tsign
7669  152c 1303          	cpw	x,(OFST-4,sp)
7670  152e 270a          	jreq	L7533
7673  1530 1e03          	ldw	x,(OFST-4,sp)
7674  1532 89            	pushw	x
7675  1533 ae000e        	ldw	x,#_ee_tsign
7676  1536 cd0000        	call	c_eewrw
7678  1539 85            	popw	x
7679  153a               L7533:
7680                     ; 1906 	if(mess[8]==MEM_KF1)
7682  153a b6cf          	ld	a,_mess+8
7683  153c a126          	cp	a,#38
7684  153e 260e          	jrne	L1633
7685                     ; 1908 		if(ee_DEVICE!=0)ee_DEVICE=0;
7687  1540 ce0004        	ldw	x,_ee_DEVICE
7688  1543 2709          	jreq	L1633
7691  1545 5f            	clrw	x
7692  1546 89            	pushw	x
7693  1547 ae0004        	ldw	x,#_ee_DEVICE
7694  154a cd0000        	call	c_eewrw
7696  154d 85            	popw	x
7697  154e               L1633:
7698                     ; 1911 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7700  154e b6cf          	ld	a,_mess+8
7701  1550 a129          	cp	a,#41
7702  1552 2703          	jreq	L612
7703  1554 cc1720        	jp	L5603
7704  1557               L612:
7705                     ; 1913 		if(ee_DEVICE!=1)ee_DEVICE=1;
7707  1557 ce0004        	ldw	x,_ee_DEVICE
7708  155a a30001        	cpw	x,#1
7709  155d 270b          	jreq	L7633
7712  155f ae0001        	ldw	x,#1
7713  1562 89            	pushw	x
7714  1563 ae0004        	ldw	x,#_ee_DEVICE
7715  1566 cd0000        	call	c_eewrw
7717  1569 85            	popw	x
7718  156a               L7633:
7719                     ; 1914 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7721  156a b6d4          	ld	a,_mess+13
7722  156c 5f            	clrw	x
7723  156d 97            	ld	xl,a
7724  156e c30002        	cpw	x,_ee_IMAXVENT
7725  1571 2603          	jrne	L022
7726  1573 cc1720        	jp	L5603
7727  1576               L022:
7730  1576 b6d4          	ld	a,_mess+13
7731  1578 5f            	clrw	x
7732  1579 97            	ld	xl,a
7733  157a 89            	pushw	x
7734  157b ae0002        	ldw	x,#_ee_IMAXVENT
7735  157e cd0000        	call	c_eewrw
7737  1581 85            	popw	x
7738  1582 ac201720      	jpf	L5603
7739  1586               L7433:
7740                     ; 1919 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7742  1586 b6cd          	ld	a,_mess+6
7743  1588 c100f7        	cp	a,_adress
7744  158b 262d          	jrne	L5733
7746  158d b6ce          	ld	a,_mess+7
7747  158f c100f7        	cp	a,_adress
7748  1592 2626          	jrne	L5733
7750  1594 b6cf          	ld	a,_mess+8
7751  1596 a116          	cp	a,#22
7752  1598 2620          	jrne	L5733
7754  159a b6d0          	ld	a,_mess+9
7755  159c a163          	cp	a,#99
7756  159e 261a          	jrne	L5733
7757                     ; 1921 	flags&=0b11100001;
7759  15a0 b605          	ld	a,_flags
7760  15a2 a4e1          	and	a,#225
7761  15a4 b705          	ld	_flags,a
7762                     ; 1922 	tsign_cnt=0;
7764  15a6 5f            	clrw	x
7765  15a7 bf59          	ldw	_tsign_cnt,x
7766                     ; 1923 	tmax_cnt=0;
7768  15a9 5f            	clrw	x
7769  15aa bf57          	ldw	_tmax_cnt,x
7770                     ; 1924 	umax_cnt=0;
7772  15ac 5f            	clrw	x
7773  15ad bf70          	ldw	_umax_cnt,x
7774                     ; 1925 	umin_cnt=0;
7776  15af 5f            	clrw	x
7777  15b0 bf6e          	ldw	_umin_cnt,x
7778                     ; 1926 	led_drv_cnt=30;
7780  15b2 351e0016      	mov	_led_drv_cnt,#30
7782  15b6 ac201720      	jpf	L5603
7783  15ba               L5733:
7784                     ; 1929 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7786  15ba b6cd          	ld	a,_mess+6
7787  15bc c100f7        	cp	a,_adress
7788  15bf 2620          	jrne	L1043
7790  15c1 b6ce          	ld	a,_mess+7
7791  15c3 c100f7        	cp	a,_adress
7792  15c6 2619          	jrne	L1043
7794  15c8 b6cf          	ld	a,_mess+8
7795  15ca a116          	cp	a,#22
7796  15cc 2613          	jrne	L1043
7798  15ce b6d0          	ld	a,_mess+9
7799  15d0 a164          	cp	a,#100
7800  15d2 260d          	jrne	L1043
7801                     ; 1931 	vent_resurs=0;
7803  15d4 5f            	clrw	x
7804  15d5 89            	pushw	x
7805  15d6 ae0000        	ldw	x,#_vent_resurs
7806  15d9 cd0000        	call	c_eewrw
7808  15dc 85            	popw	x
7810  15dd ac201720      	jpf	L5603
7811  15e1               L1043:
7812                     ; 1935 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7814  15e1 b6cd          	ld	a,_mess+6
7815  15e3 a1ff          	cp	a,#255
7816  15e5 265f          	jrne	L5043
7818  15e7 b6ce          	ld	a,_mess+7
7819  15e9 a1ff          	cp	a,#255
7820  15eb 2659          	jrne	L5043
7822  15ed b6cf          	ld	a,_mess+8
7823  15ef a116          	cp	a,#22
7824  15f1 2653          	jrne	L5043
7826  15f3 b6d0          	ld	a,_mess+9
7827  15f5 a116          	cp	a,#22
7828  15f7 264d          	jrne	L5043
7829                     ; 1937 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7831  15f9 b6d1          	ld	a,_mess+10
7832  15fb a155          	cp	a,#85
7833  15fd 260f          	jrne	L7043
7835  15ff b6d2          	ld	a,_mess+11
7836  1601 a155          	cp	a,#85
7837  1603 2609          	jrne	L7043
7840  1605 be68          	ldw	x,__x_
7841  1607 1c0001        	addw	x,#1
7842  160a bf68          	ldw	__x_,x
7844  160c 2024          	jra	L1143
7845  160e               L7043:
7846                     ; 1938 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7848  160e b6d1          	ld	a,_mess+10
7849  1610 a166          	cp	a,#102
7850  1612 260f          	jrne	L3143
7852  1614 b6d2          	ld	a,_mess+11
7853  1616 a166          	cp	a,#102
7854  1618 2609          	jrne	L3143
7857  161a be68          	ldw	x,__x_
7858  161c 1d0001        	subw	x,#1
7859  161f bf68          	ldw	__x_,x
7861  1621 200f          	jra	L1143
7862  1623               L3143:
7863                     ; 1939 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7865  1623 b6d1          	ld	a,_mess+10
7866  1625 a177          	cp	a,#119
7867  1627 2609          	jrne	L1143
7869  1629 b6d2          	ld	a,_mess+11
7870  162b a177          	cp	a,#119
7871  162d 2603          	jrne	L1143
7874  162f 5f            	clrw	x
7875  1630 bf68          	ldw	__x_,x
7876  1632               L1143:
7877                     ; 1940      gran(&_x_,-XMAX,XMAX);
7879  1632 ae0019        	ldw	x,#25
7880  1635 89            	pushw	x
7881  1636 aeffe7        	ldw	x,#65511
7882  1639 89            	pushw	x
7883  163a ae0068        	ldw	x,#__x_
7884  163d cd00d5        	call	_gran
7886  1640 5b04          	addw	sp,#4
7888  1642 ac201720      	jpf	L5603
7889  1646               L5043:
7890                     ; 1942 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7892  1646 b6cd          	ld	a,_mess+6
7893  1648 c100f7        	cp	a,_adress
7894  164b 2635          	jrne	L3243
7896  164d b6ce          	ld	a,_mess+7
7897  164f c100f7        	cp	a,_adress
7898  1652 262e          	jrne	L3243
7900  1654 b6cf          	ld	a,_mess+8
7901  1656 a116          	cp	a,#22
7902  1658 2628          	jrne	L3243
7904  165a b6d0          	ld	a,_mess+9
7905  165c b1d1          	cp	a,_mess+10
7906  165e 2622          	jrne	L3243
7908  1660 b6d0          	ld	a,_mess+9
7909  1662 a1ee          	cp	a,#238
7910  1664 261c          	jrne	L3243
7911                     ; 1944 	rotor_int++;
7913  1666 be17          	ldw	x,_rotor_int
7914  1668 1c0001        	addw	x,#1
7915  166b bf17          	ldw	_rotor_int,x
7916                     ; 1945      tempI=pwm_u;
7918                     ; 1947 	UU_AVT=Un;
7920  166d ce000e        	ldw	x,_Un
7921  1670 89            	pushw	x
7922  1671 ae0008        	ldw	x,#_UU_AVT
7923  1674 cd0000        	call	c_eewrw
7925  1677 85            	popw	x
7926                     ; 1948 	delay_ms(100);
7928  1678 ae0064        	ldw	x,#100
7929  167b cd0121        	call	_delay_ms
7932  167e ac201720      	jpf	L5603
7933  1682               L3243:
7934                     ; 1954 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7936  1682 b6ce          	ld	a,_mess+7
7937  1684 a1da          	cp	a,#218
7938  1686 2653          	jrne	L7243
7940  1688 b6cd          	ld	a,_mess+6
7941  168a c100f7        	cp	a,_adress
7942  168d 274c          	jreq	L7243
7944  168f b6cd          	ld	a,_mess+6
7945  1691 a106          	cp	a,#6
7946  1693 2446          	jruge	L7243
7947                     ; 1956 	i_main_bps_cnt[mess[6]]=0;
7949  1695 b6cd          	ld	a,_mess+6
7950  1697 5f            	clrw	x
7951  1698 97            	ld	xl,a
7952  1699 6f13          	clr	(_i_main_bps_cnt,x)
7953                     ; 1957 	i_main_flag[mess[6]]=1;
7955  169b b6cd          	ld	a,_mess+6
7956  169d 5f            	clrw	x
7957  169e 97            	ld	xl,a
7958  169f a601          	ld	a,#1
7959  16a1 e71e          	ld	(_i_main_flag,x),a
7960                     ; 1958 	if(bMAIN)
7962                     	btst	_bMAIN
7963  16a8 2476          	jruge	L5603
7964                     ; 1960 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7966  16aa b6d0          	ld	a,_mess+9
7967  16ac 5f            	clrw	x
7968  16ad 97            	ld	xl,a
7969  16ae 4f            	clr	a
7970  16af 02            	rlwa	x,a
7971  16b0 1f01          	ldw	(OFST-6,sp),x
7972  16b2 b6cf          	ld	a,_mess+8
7973  16b4 5f            	clrw	x
7974  16b5 97            	ld	xl,a
7975  16b6 72fb01        	addw	x,(OFST-6,sp)
7976  16b9 b6cd          	ld	a,_mess+6
7977  16bb 905f          	clrw	y
7978  16bd 9097          	ld	yl,a
7979  16bf 9058          	sllw	y
7980  16c1 90ef24        	ldw	(_i_main,y),x
7981                     ; 1961 		i_main[adress]=I;
7983  16c4 c600f7        	ld	a,_adress
7984  16c7 5f            	clrw	x
7985  16c8 97            	ld	xl,a
7986  16c9 58            	sllw	x
7987  16ca 90ce0010      	ldw	y,_I
7988  16ce ef24          	ldw	(_i_main,x),y
7989                     ; 1962      	i_main_flag[adress]=1;
7991  16d0 c600f7        	ld	a,_adress
7992  16d3 5f            	clrw	x
7993  16d4 97            	ld	xl,a
7994  16d5 a601          	ld	a,#1
7995  16d7 e71e          	ld	(_i_main_flag,x),a
7996  16d9 2045          	jra	L5603
7997  16db               L7243:
7998                     ; 1966 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8000  16db b6ce          	ld	a,_mess+7
8001  16dd a1db          	cp	a,#219
8002  16df 263f          	jrne	L5603
8004  16e1 b6cd          	ld	a,_mess+6
8005  16e3 c100f7        	cp	a,_adress
8006  16e6 2738          	jreq	L5603
8008  16e8 b6cd          	ld	a,_mess+6
8009  16ea a106          	cp	a,#6
8010  16ec 2432          	jruge	L5603
8011                     ; 1968 	i_main_bps_cnt[mess[6]]=0;
8013  16ee b6cd          	ld	a,_mess+6
8014  16f0 5f            	clrw	x
8015  16f1 97            	ld	xl,a
8016  16f2 6f13          	clr	(_i_main_bps_cnt,x)
8017                     ; 1969 	i_main_flag[mess[6]]=1;		
8019  16f4 b6cd          	ld	a,_mess+6
8020  16f6 5f            	clrw	x
8021  16f7 97            	ld	xl,a
8022  16f8 a601          	ld	a,#1
8023  16fa e71e          	ld	(_i_main_flag,x),a
8024                     ; 1970 	if(bMAIN)
8026                     	btst	_bMAIN
8027  1701 241d          	jruge	L5603
8028                     ; 1972 		if(mess[9]==0)i_main_flag[i]=1;
8030  1703 3dd0          	tnz	_mess+9
8031  1705 260a          	jrne	L1443
8034  1707 7b07          	ld	a,(OFST+0,sp)
8035  1709 5f            	clrw	x
8036  170a 97            	ld	xl,a
8037  170b a601          	ld	a,#1
8038  170d e71e          	ld	(_i_main_flag,x),a
8040  170f 2006          	jra	L3443
8041  1711               L1443:
8042                     ; 1973 		else i_main_flag[i]=0;
8044  1711 7b07          	ld	a,(OFST+0,sp)
8045  1713 5f            	clrw	x
8046  1714 97            	ld	xl,a
8047  1715 6f1e          	clr	(_i_main_flag,x)
8048  1717               L3443:
8049                     ; 1974 		i_main_flag[adress]=1;
8051  1717 c600f7        	ld	a,_adress
8052  171a 5f            	clrw	x
8053  171b 97            	ld	xl,a
8054  171c a601          	ld	a,#1
8055  171e e71e          	ld	(_i_main_flag,x),a
8056  1720               L5603:
8057                     ; 1980 can_in_an_end:
8057                     ; 1981 bCAN_RX=0;
8059  1720 3f04          	clr	_bCAN_RX
8060                     ; 1982 }   
8063  1722 5b07          	addw	sp,#7
8064  1724 81            	ret
8087                     ; 1985 void t4_init(void){
8088                     	switch	.text
8089  1725               _t4_init:
8093                     ; 1986 	TIM4->PSCR = 4;
8095  1725 35045345      	mov	21317,#4
8096                     ; 1987 	TIM4->ARR= 61;
8098  1729 353d5346      	mov	21318,#61
8099                     ; 1988 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8101  172d 72105341      	bset	21313,#0
8102                     ; 1990 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8104  1731 35855340      	mov	21312,#133
8105                     ; 1992 }
8108  1735 81            	ret
8131                     ; 1995 void t1_init(void)
8131                     ; 1996 {
8132                     	switch	.text
8133  1736               _t1_init:
8137                     ; 1997 TIM1->ARRH= 0x07;
8139  1736 35075262      	mov	21090,#7
8140                     ; 1998 TIM1->ARRL= 0xff;
8142  173a 35ff5263      	mov	21091,#255
8143                     ; 1999 TIM1->CCR1H= 0x00;	
8145  173e 725f5265      	clr	21093
8146                     ; 2000 TIM1->CCR1L= 0xff;
8148  1742 35ff5266      	mov	21094,#255
8149                     ; 2001 TIM1->CCR2H= 0x00;	
8151  1746 725f5267      	clr	21095
8152                     ; 2002 TIM1->CCR2L= 0x00;
8154  174a 725f5268      	clr	21096
8155                     ; 2003 TIM1->CCR3H= 0x00;	
8157  174e 725f5269      	clr	21097
8158                     ; 2004 TIM1->CCR3L= 0x64;
8160  1752 3564526a      	mov	21098,#100
8161                     ; 2006 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8163  1756 35685258      	mov	21080,#104
8164                     ; 2007 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8166  175a 35685259      	mov	21081,#104
8167                     ; 2008 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8169  175e 3568525a      	mov	21082,#104
8170                     ; 2009 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8172  1762 3511525c      	mov	21084,#17
8173                     ; 2010 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8175  1766 3501525d      	mov	21085,#1
8176                     ; 2011 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8178  176a 35815250      	mov	21072,#129
8179                     ; 2012 TIM1->BKR|= TIM1_BKR_AOE;
8181  176e 721c526d      	bset	21101,#6
8182                     ; 2013 }
8185  1772 81            	ret
8210                     ; 2017 void adc2_init(void)
8210                     ; 2018 {
8211                     	switch	.text
8212  1773               _adc2_init:
8216                     ; 2019 adc_plazma[0]++;
8218  1773 beb9          	ldw	x,_adc_plazma
8219  1775 1c0001        	addw	x,#1
8220  1778 bfb9          	ldw	_adc_plazma,x
8221                     ; 2043 GPIOB->DDR&=~(1<<4);
8223  177a 72195007      	bres	20487,#4
8224                     ; 2044 GPIOB->CR1&=~(1<<4);
8226  177e 72195008      	bres	20488,#4
8227                     ; 2045 GPIOB->CR2&=~(1<<4);
8229  1782 72195009      	bres	20489,#4
8230                     ; 2047 GPIOB->DDR&=~(1<<5);
8232  1786 721b5007      	bres	20487,#5
8233                     ; 2048 GPIOB->CR1&=~(1<<5);
8235  178a 721b5008      	bres	20488,#5
8236                     ; 2049 GPIOB->CR2&=~(1<<5);
8238  178e 721b5009      	bres	20489,#5
8239                     ; 2051 GPIOB->DDR&=~(1<<6);
8241  1792 721d5007      	bres	20487,#6
8242                     ; 2052 GPIOB->CR1&=~(1<<6);
8244  1796 721d5008      	bres	20488,#6
8245                     ; 2053 GPIOB->CR2&=~(1<<6);
8247  179a 721d5009      	bres	20489,#6
8248                     ; 2055 GPIOB->DDR&=~(1<<7);
8250  179e 721f5007      	bres	20487,#7
8251                     ; 2056 GPIOB->CR1&=~(1<<7);
8253  17a2 721f5008      	bres	20488,#7
8254                     ; 2057 GPIOB->CR2&=~(1<<7);
8256  17a6 721f5009      	bres	20489,#7
8257                     ; 2059 GPIOB->DDR&=~(1<<2);
8259  17aa 72155007      	bres	20487,#2
8260                     ; 2060 GPIOB->CR1&=~(1<<2);
8262  17ae 72155008      	bres	20488,#2
8263                     ; 2061 GPIOB->CR2&=~(1<<2);
8265  17b2 72155009      	bres	20489,#2
8266                     ; 2070 ADC2->TDRL=0xff;
8268  17b6 35ff5407      	mov	21511,#255
8269                     ; 2072 ADC2->CR2=0x08;
8271  17ba 35085402      	mov	21506,#8
8272                     ; 2073 ADC2->CR1=0x40;
8274  17be 35405401      	mov	21505,#64
8275                     ; 2076 	if(adc_ch==5)ADC2->CSR=0x22;
8277  17c2 b6c6          	ld	a,_adc_ch
8278  17c4 a105          	cp	a,#5
8279  17c6 2606          	jrne	L5743
8282  17c8 35225400      	mov	21504,#34
8284  17cc 2007          	jra	L7743
8285  17ce               L5743:
8286                     ; 2077 	else ADC2->CSR=0x20+adc_ch+3;
8288  17ce b6c6          	ld	a,_adc_ch
8289  17d0 ab23          	add	a,#35
8290  17d2 c75400        	ld	21504,a
8291  17d5               L7743:
8292                     ; 2079 	ADC2->CR1|=1;
8294  17d5 72105401      	bset	21505,#0
8295                     ; 2080 	ADC2->CR1|=1;
8297  17d9 72105401      	bset	21505,#0
8298                     ; 2083 adc_plazma[1]=adc_ch;
8300  17dd b6c6          	ld	a,_adc_ch
8301  17df 5f            	clrw	x
8302  17e0 97            	ld	xl,a
8303  17e1 bfbb          	ldw	_adc_plazma+2,x
8304                     ; 2084 }
8307  17e3 81            	ret
8343                     ; 2092 @far @interrupt void TIM4_UPD_Interrupt (void) 
8343                     ; 2093 {
8345                     	switch	.text
8346  17e4               f_TIM4_UPD_Interrupt:
8350                     ; 2094 TIM4->SR1&=~TIM4_SR1_UIF;
8352  17e4 72115342      	bres	21314,#0
8353                     ; 2096 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8355  17e8 3c12          	inc	_pwm_vent_cnt
8356  17ea b612          	ld	a,_pwm_vent_cnt
8357  17ec a10a          	cp	a,#10
8358  17ee 2502          	jrult	L1153
8361  17f0 3f12          	clr	_pwm_vent_cnt
8362  17f2               L1153:
8363                     ; 2097 GPIOB->ODR|=(1<<3);
8365  17f2 72165005      	bset	20485,#3
8366                     ; 2098 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8368  17f6 b612          	ld	a,_pwm_vent_cnt
8369  17f8 a105          	cp	a,#5
8370  17fa 2504          	jrult	L3153
8373  17fc 72175005      	bres	20485,#3
8374  1800               L3153:
8375                     ; 2102 if(++t0_cnt00>=10)
8377  1800 9c            	rvf
8378  1801 ce0000        	ldw	x,_t0_cnt00
8379  1804 1c0001        	addw	x,#1
8380  1807 cf0000        	ldw	_t0_cnt00,x
8381  180a a3000a        	cpw	x,#10
8382  180d 2f08          	jrslt	L5153
8383                     ; 2104 	t0_cnt00=0;
8385  180f 5f            	clrw	x
8386  1810 cf0000        	ldw	_t0_cnt00,x
8387                     ; 2105 	b1000Hz=1;
8389  1813 72100004      	bset	_b1000Hz
8390  1817               L5153:
8391                     ; 2108 if(++t0_cnt0>=100)
8393  1817 9c            	rvf
8394  1818 ce0002        	ldw	x,_t0_cnt0
8395  181b 1c0001        	addw	x,#1
8396  181e cf0002        	ldw	_t0_cnt0,x
8397  1821 a30064        	cpw	x,#100
8398  1824 2f54          	jrslt	L7153
8399                     ; 2110 	t0_cnt0=0;
8401  1826 5f            	clrw	x
8402  1827 cf0002        	ldw	_t0_cnt0,x
8403                     ; 2111 	b100Hz=1;
8405  182a 72100009      	bset	_b100Hz
8406                     ; 2113 	if(++t0_cnt1>=10)
8408  182e 725c0004      	inc	_t0_cnt1
8409  1832 c60004        	ld	a,_t0_cnt1
8410  1835 a10a          	cp	a,#10
8411  1837 2508          	jrult	L1253
8412                     ; 2115 		t0_cnt1=0;
8414  1839 725f0004      	clr	_t0_cnt1
8415                     ; 2116 		b10Hz=1;
8417  183d 72100008      	bset	_b10Hz
8418  1841               L1253:
8419                     ; 2119 	if(++t0_cnt2>=20)
8421  1841 725c0005      	inc	_t0_cnt2
8422  1845 c60005        	ld	a,_t0_cnt2
8423  1848 a114          	cp	a,#20
8424  184a 2508          	jrult	L3253
8425                     ; 2121 		t0_cnt2=0;
8427  184c 725f0005      	clr	_t0_cnt2
8428                     ; 2122 		b5Hz=1;
8430  1850 72100007      	bset	_b5Hz
8431  1854               L3253:
8432                     ; 2126 	if(++t0_cnt4>=50)
8434  1854 725c0007      	inc	_t0_cnt4
8435  1858 c60007        	ld	a,_t0_cnt4
8436  185b a132          	cp	a,#50
8437  185d 2508          	jrult	L5253
8438                     ; 2128 		t0_cnt4=0;
8440  185f 725f0007      	clr	_t0_cnt4
8441                     ; 2129 		b2Hz=1;
8443  1863 72100006      	bset	_b2Hz
8444  1867               L5253:
8445                     ; 2132 	if(++t0_cnt3>=100)
8447  1867 725c0006      	inc	_t0_cnt3
8448  186b c60006        	ld	a,_t0_cnt3
8449  186e a164          	cp	a,#100
8450  1870 2508          	jrult	L7153
8451                     ; 2134 		t0_cnt3=0;
8453  1872 725f0006      	clr	_t0_cnt3
8454                     ; 2135 		b1Hz=1;
8456  1876 72100005      	bset	_b1Hz
8457  187a               L7153:
8458                     ; 2141 }
8461  187a 80            	iret
8486                     ; 2144 @far @interrupt void CAN_RX_Interrupt (void) 
8486                     ; 2145 {
8487                     	switch	.text
8488  187b               f_CAN_RX_Interrupt:
8492                     ; 2147 CAN->PSR= 7;									// page 7 - read messsage
8494  187b 35075427      	mov	21543,#7
8495                     ; 2149 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8497  187f ae000e        	ldw	x,#14
8498  1882               L432:
8499  1882 d65427        	ld	a,(21543,x)
8500  1885 e7c6          	ld	(_mess-1,x),a
8501  1887 5a            	decw	x
8502  1888 26f8          	jrne	L432
8503                     ; 2160 bCAN_RX=1;
8505  188a 35010004      	mov	_bCAN_RX,#1
8506                     ; 2161 CAN->RFR|=(1<<5);
8508  188e 721a5424      	bset	21540,#5
8509                     ; 2163 }
8512  1892 80            	iret
8535                     ; 2166 @far @interrupt void CAN_TX_Interrupt (void) 
8535                     ; 2167 {
8536                     	switch	.text
8537  1893               f_CAN_TX_Interrupt:
8541                     ; 2168 if((CAN->TSR)&(1<<0))
8543  1893 c65422        	ld	a,21538
8544  1896 a501          	bcp	a,#1
8545  1898 2708          	jreq	L1553
8546                     ; 2170 	bTX_FREE=1;	
8548  189a 35010003      	mov	_bTX_FREE,#1
8549                     ; 2172 	CAN->TSR|=(1<<0);
8551  189e 72105422      	bset	21538,#0
8552  18a2               L1553:
8553                     ; 2174 }
8556  18a2 80            	iret
8636                     ; 2177 @far @interrupt void ADC2_EOC_Interrupt (void) {
8637                     	switch	.text
8638  18a3               f_ADC2_EOC_Interrupt:
8640       0000000d      OFST:	set	13
8641  18a3 be00          	ldw	x,c_x
8642  18a5 89            	pushw	x
8643  18a6 be00          	ldw	x,c_y
8644  18a8 89            	pushw	x
8645  18a9 be02          	ldw	x,c_lreg+2
8646  18ab 89            	pushw	x
8647  18ac be00          	ldw	x,c_lreg
8648  18ae 89            	pushw	x
8649  18af 520d          	subw	sp,#13
8652                     ; 2182 adc_plazma[2]++;
8654  18b1 bebd          	ldw	x,_adc_plazma+4
8655  18b3 1c0001        	addw	x,#1
8656  18b6 bfbd          	ldw	_adc_plazma+4,x
8657                     ; 2189 ADC2->CSR&=~(1<<7);
8659  18b8 721f5400      	bres	21504,#7
8660                     ; 2191 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8662  18bc c65405        	ld	a,21509
8663  18bf b703          	ld	c_lreg+3,a
8664  18c1 3f02          	clr	c_lreg+2
8665  18c3 3f01          	clr	c_lreg+1
8666  18c5 3f00          	clr	c_lreg
8667  18c7 96            	ldw	x,sp
8668  18c8 1c0001        	addw	x,#OFST-12
8669  18cb cd0000        	call	c_rtol
8671  18ce c65404        	ld	a,21508
8672  18d1 5f            	clrw	x
8673  18d2 97            	ld	xl,a
8674  18d3 90ae0100      	ldw	y,#256
8675  18d7 cd0000        	call	c_umul
8677  18da 96            	ldw	x,sp
8678  18db 1c0001        	addw	x,#OFST-12
8679  18de cd0000        	call	c_ladd
8681  18e1 96            	ldw	x,sp
8682  18e2 1c000a        	addw	x,#OFST-3
8683  18e5 cd0000        	call	c_rtol
8685                     ; 2196 if(adr_drv_stat==1)
8687  18e8 b602          	ld	a,_adr_drv_stat
8688  18ea a101          	cp	a,#1
8689  18ec 260b          	jrne	L1163
8690                     ; 2198 	adr_drv_stat=2;
8692  18ee 35020002      	mov	_adr_drv_stat,#2
8693                     ; 2199 	adc_buff_[0]=temp_adc;
8695  18f2 1e0c          	ldw	x,(OFST-1,sp)
8696  18f4 cf00ff        	ldw	_adc_buff_,x
8698  18f7 2020          	jra	L3163
8699  18f9               L1163:
8700                     ; 2202 else if(adr_drv_stat==3)
8702  18f9 b602          	ld	a,_adr_drv_stat
8703  18fb a103          	cp	a,#3
8704  18fd 260b          	jrne	L5163
8705                     ; 2204 	adr_drv_stat=4;
8707  18ff 35040002      	mov	_adr_drv_stat,#4
8708                     ; 2205 	adc_buff_[1]=temp_adc;
8710  1903 1e0c          	ldw	x,(OFST-1,sp)
8711  1905 cf0101        	ldw	_adc_buff_+2,x
8713  1908 200f          	jra	L3163
8714  190a               L5163:
8715                     ; 2208 else if(adr_drv_stat==5)
8717  190a b602          	ld	a,_adr_drv_stat
8718  190c a105          	cp	a,#5
8719  190e 2609          	jrne	L3163
8720                     ; 2210 	adr_drv_stat=6;
8722  1910 35060002      	mov	_adr_drv_stat,#6
8723                     ; 2211 	adc_buff_[9]=temp_adc;
8725  1914 1e0c          	ldw	x,(OFST-1,sp)
8726  1916 cf0111        	ldw	_adc_buff_+18,x
8727  1919               L3163:
8728                     ; 2214 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8730  1919 b6b7          	ld	a,_adc_cnt_cnt
8731  191b 5f            	clrw	x
8732  191c 97            	ld	xl,a
8733  191d 58            	sllw	x
8734  191e 1f03          	ldw	(OFST-10,sp),x
8735  1920 b6c6          	ld	a,_adc_ch
8736  1922 97            	ld	xl,a
8737  1923 a610          	ld	a,#16
8738  1925 42            	mul	x,a
8739  1926 72fb03        	addw	x,(OFST-10,sp)
8740  1929 160c          	ldw	y,(OFST-1,sp)
8741  192b df0056        	ldw	(_adc_buff_buff,x),y
8742                     ; 2216 adc_ch++;
8744  192e 3cc6          	inc	_adc_ch
8745                     ; 2217 if(adc_ch>=6)
8747  1930 b6c6          	ld	a,_adc_ch
8748  1932 a106          	cp	a,#6
8749  1934 2516          	jrult	L3263
8750                     ; 2219 	adc_ch=0;
8752  1936 3fc6          	clr	_adc_ch
8753                     ; 2220 	adc_cnt_cnt++;
8755  1938 3cb7          	inc	_adc_cnt_cnt
8756                     ; 2221 	if(adc_cnt_cnt>=8)
8758  193a b6b7          	ld	a,_adc_cnt_cnt
8759  193c a108          	cp	a,#8
8760  193e 250c          	jrult	L3263
8761                     ; 2223 		adc_cnt_cnt=0;
8763  1940 3fb7          	clr	_adc_cnt_cnt
8764                     ; 2224 		adc_cnt++;
8766  1942 3cc5          	inc	_adc_cnt
8767                     ; 2225 		if(adc_cnt>=16)
8769  1944 b6c5          	ld	a,_adc_cnt
8770  1946 a110          	cp	a,#16
8771  1948 2502          	jrult	L3263
8772                     ; 2227 			adc_cnt=0;
8774  194a 3fc5          	clr	_adc_cnt
8775  194c               L3263:
8776                     ; 2231 if(adc_cnt_cnt==0)
8778  194c 3db7          	tnz	_adc_cnt_cnt
8779  194e 2660          	jrne	L1363
8780                     ; 2235 	tempSS=0;
8782  1950 ae0000        	ldw	x,#0
8783  1953 1f07          	ldw	(OFST-6,sp),x
8784  1955 ae0000        	ldw	x,#0
8785  1958 1f05          	ldw	(OFST-8,sp),x
8786                     ; 2236 	for(i=0;i<8;i++)
8788  195a 0f09          	clr	(OFST-4,sp)
8789  195c               L3363:
8790                     ; 2238 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8792  195c 7b09          	ld	a,(OFST-4,sp)
8793  195e 5f            	clrw	x
8794  195f 97            	ld	xl,a
8795  1960 58            	sllw	x
8796  1961 1f03          	ldw	(OFST-10,sp),x
8797  1963 b6c6          	ld	a,_adc_ch
8798  1965 97            	ld	xl,a
8799  1966 a610          	ld	a,#16
8800  1968 42            	mul	x,a
8801  1969 72fb03        	addw	x,(OFST-10,sp)
8802  196c de0056        	ldw	x,(_adc_buff_buff,x)
8803  196f cd0000        	call	c_itolx
8805  1972 96            	ldw	x,sp
8806  1973 1c0005        	addw	x,#OFST-8
8807  1976 cd0000        	call	c_lgadd
8809                     ; 2236 	for(i=0;i<8;i++)
8811  1979 0c09          	inc	(OFST-4,sp)
8814  197b 7b09          	ld	a,(OFST-4,sp)
8815  197d a108          	cp	a,#8
8816  197f 25db          	jrult	L3363
8817                     ; 2240 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8819  1981 96            	ldw	x,sp
8820  1982 1c0005        	addw	x,#OFST-8
8821  1985 cd0000        	call	c_ltor
8823  1988 a603          	ld	a,#3
8824  198a cd0000        	call	c_lrsh
8826  198d be02          	ldw	x,c_lreg+2
8827  198f b6c5          	ld	a,_adc_cnt
8828  1991 905f          	clrw	y
8829  1993 9097          	ld	yl,a
8830  1995 9058          	sllw	y
8831  1997 1703          	ldw	(OFST-10,sp),y
8832  1999 b6c6          	ld	a,_adc_ch
8833  199b 905f          	clrw	y
8834  199d 9097          	ld	yl,a
8835  199f 9058          	sllw	y
8836  19a1 9058          	sllw	y
8837  19a3 9058          	sllw	y
8838  19a5 9058          	sllw	y
8839  19a7 9058          	sllw	y
8840  19a9 72f903        	addw	y,(OFST-10,sp)
8841  19ac 90df0113      	ldw	(_adc_buff,y),x
8842  19b0               L1363:
8843                     ; 2244 if((adc_cnt&0x03)==0)
8845  19b0 b6c5          	ld	a,_adc_cnt
8846  19b2 a503          	bcp	a,#3
8847  19b4 264b          	jrne	L1463
8848                     ; 2248 	tempSS=0;
8850  19b6 ae0000        	ldw	x,#0
8851  19b9 1f07          	ldw	(OFST-6,sp),x
8852  19bb ae0000        	ldw	x,#0
8853  19be 1f05          	ldw	(OFST-8,sp),x
8854                     ; 2249 	for(i=0;i<16;i++)
8856  19c0 0f09          	clr	(OFST-4,sp)
8857  19c2               L3463:
8858                     ; 2251 		tempSS+=(signed long)adc_buff[adc_ch][i];
8860  19c2 7b09          	ld	a,(OFST-4,sp)
8861  19c4 5f            	clrw	x
8862  19c5 97            	ld	xl,a
8863  19c6 58            	sllw	x
8864  19c7 1f03          	ldw	(OFST-10,sp),x
8865  19c9 b6c6          	ld	a,_adc_ch
8866  19cb 97            	ld	xl,a
8867  19cc a620          	ld	a,#32
8868  19ce 42            	mul	x,a
8869  19cf 72fb03        	addw	x,(OFST-10,sp)
8870  19d2 de0113        	ldw	x,(_adc_buff,x)
8871  19d5 cd0000        	call	c_itolx
8873  19d8 96            	ldw	x,sp
8874  19d9 1c0005        	addw	x,#OFST-8
8875  19dc cd0000        	call	c_lgadd
8877                     ; 2249 	for(i=0;i<16;i++)
8879  19df 0c09          	inc	(OFST-4,sp)
8882  19e1 7b09          	ld	a,(OFST-4,sp)
8883  19e3 a110          	cp	a,#16
8884  19e5 25db          	jrult	L3463
8885                     ; 2253 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8887  19e7 96            	ldw	x,sp
8888  19e8 1c0005        	addw	x,#OFST-8
8889  19eb cd0000        	call	c_ltor
8891  19ee a604          	ld	a,#4
8892  19f0 cd0000        	call	c_lrsh
8894  19f3 be02          	ldw	x,c_lreg+2
8895  19f5 b6c6          	ld	a,_adc_ch
8896  19f7 905f          	clrw	y
8897  19f9 9097          	ld	yl,a
8898  19fb 9058          	sllw	y
8899  19fd 90df00ff      	ldw	(_adc_buff_,y),x
8900  1a01               L1463:
8901                     ; 2260 if(adc_ch==0)adc_buff_5=temp_adc;
8903  1a01 3dc6          	tnz	_adc_ch
8904  1a03 2605          	jrne	L1563
8907  1a05 1e0c          	ldw	x,(OFST-1,sp)
8908  1a07 cf00fd        	ldw	_adc_buff_5,x
8909  1a0a               L1563:
8910                     ; 2261 if(adc_ch==2)adc_buff_1=temp_adc;
8912  1a0a b6c6          	ld	a,_adc_ch
8913  1a0c a102          	cp	a,#2
8914  1a0e 2605          	jrne	L3563
8917  1a10 1e0c          	ldw	x,(OFST-1,sp)
8918  1a12 cf00fb        	ldw	_adc_buff_1,x
8919  1a15               L3563:
8920                     ; 2263 adc_plazma_short++;
8922  1a15 bec3          	ldw	x,_adc_plazma_short
8923  1a17 1c0001        	addw	x,#1
8924  1a1a bfc3          	ldw	_adc_plazma_short,x
8925                     ; 2265 }
8928  1a1c 5b0d          	addw	sp,#13
8929  1a1e 85            	popw	x
8930  1a1f bf00          	ldw	c_lreg,x
8931  1a21 85            	popw	x
8932  1a22 bf02          	ldw	c_lreg+2,x
8933  1a24 85            	popw	x
8934  1a25 bf00          	ldw	c_y,x
8935  1a27 85            	popw	x
8936  1a28 bf00          	ldw	c_x,x
8937  1a2a 80            	iret
8995                     ; 2274 main()
8995                     ; 2275 {
8997                     	switch	.text
8998  1a2b               _main:
9002                     ; 2277 CLK->ECKR|=1;
9004  1a2b 721050c1      	bset	20673,#0
9006  1a2f               L7663:
9007                     ; 2278 while((CLK->ECKR & 2) == 0);
9009  1a2f c650c1        	ld	a,20673
9010  1a32 a502          	bcp	a,#2
9011  1a34 27f9          	jreq	L7663
9012                     ; 2279 CLK->SWCR|=2;
9014  1a36 721250c5      	bset	20677,#1
9015                     ; 2280 CLK->SWR=0xB4;
9017  1a3a 35b450c4      	mov	20676,#180
9018                     ; 2282 delay_ms(200);
9020  1a3e ae00c8        	ldw	x,#200
9021  1a41 cd0121        	call	_delay_ms
9023                     ; 2283 FLASH_DUKR=0xae;
9025  1a44 35ae5064      	mov	_FLASH_DUKR,#174
9026                     ; 2284 FLASH_DUKR=0x56;
9028  1a48 35565064      	mov	_FLASH_DUKR,#86
9029                     ; 2285 enableInterrupts();
9032  1a4c 9a            rim
9034                     ; 2288 adr_drv_v3();
9037  1a4d cd0d2b        	call	_adr_drv_v3
9039                     ; 2292 t4_init();
9041  1a50 cd1725        	call	_t4_init
9043                     ; 2294 		GPIOG->DDR|=(1<<0);
9045  1a53 72105020      	bset	20512,#0
9046                     ; 2295 		GPIOG->CR1|=(1<<0);
9048  1a57 72105021      	bset	20513,#0
9049                     ; 2296 		GPIOG->CR2&=~(1<<0);	
9051  1a5b 72115022      	bres	20514,#0
9052                     ; 2299 		GPIOG->DDR&=~(1<<1);
9054  1a5f 72135020      	bres	20512,#1
9055                     ; 2300 		GPIOG->CR1|=(1<<1);
9057  1a63 72125021      	bset	20513,#1
9058                     ; 2301 		GPIOG->CR2&=~(1<<1);
9060  1a67 72135022      	bres	20514,#1
9061                     ; 2303 init_CAN();
9063  1a6b cd0f1b        	call	_init_CAN
9065                     ; 2308 GPIOC->DDR|=(1<<1);
9067  1a6e 7212500c      	bset	20492,#1
9068                     ; 2309 GPIOC->CR1|=(1<<1);
9070  1a72 7212500d      	bset	20493,#1
9071                     ; 2310 GPIOC->CR2|=(1<<1);
9073  1a76 7212500e      	bset	20494,#1
9074                     ; 2312 GPIOC->DDR|=(1<<2);
9076  1a7a 7214500c      	bset	20492,#2
9077                     ; 2313 GPIOC->CR1|=(1<<2);
9079  1a7e 7214500d      	bset	20493,#2
9080                     ; 2314 GPIOC->CR2|=(1<<2);
9082  1a82 7214500e      	bset	20494,#2
9083                     ; 2321 t1_init();
9085  1a86 cd1736        	call	_t1_init
9087                     ; 2323 GPIOA->DDR|=(1<<5);
9089  1a89 721a5002      	bset	20482,#5
9090                     ; 2324 GPIOA->CR1|=(1<<5);
9092  1a8d 721a5003      	bset	20483,#5
9093                     ; 2325 GPIOA->CR2&=~(1<<5);
9095  1a91 721b5004      	bres	20484,#5
9096                     ; 2331 GPIOB->DDR&=~(1<<3);
9098  1a95 72175007      	bres	20487,#3
9099                     ; 2332 GPIOB->CR1&=~(1<<3);
9101  1a99 72175008      	bres	20488,#3
9102                     ; 2333 GPIOB->CR2&=~(1<<3);
9104  1a9d 72175009      	bres	20489,#3
9105                     ; 2335 GPIOC->DDR|=(1<<3);
9107  1aa1 7216500c      	bset	20492,#3
9108                     ; 2336 GPIOC->CR1|=(1<<3);
9110  1aa5 7216500d      	bset	20493,#3
9111                     ; 2337 GPIOC->CR2|=(1<<3);
9113  1aa9 7216500e      	bset	20494,#3
9114  1aad               L3763:
9115                     ; 2343 	if(b1000Hz)
9117                     	btst	_b1000Hz
9118  1ab2 2407          	jruge	L7763
9119                     ; 2345 		b1000Hz=0;
9121  1ab4 72110004      	bres	_b1000Hz
9122                     ; 2347 		adc2_init();
9124  1ab8 cd1773        	call	_adc2_init
9126  1abb               L7763:
9127                     ; 2350 	if(bCAN_RX)
9129  1abb 3d04          	tnz	_bCAN_RX
9130  1abd 2705          	jreq	L1073
9131                     ; 2352 		bCAN_RX=0;
9133  1abf 3f04          	clr	_bCAN_RX
9134                     ; 2353 		can_in_an();	
9136  1ac1 cd1078        	call	_can_in_an
9138  1ac4               L1073:
9139                     ; 2355 	if(b100Hz)
9141                     	btst	_b100Hz
9142  1ac9 2407          	jruge	L3073
9143                     ; 2357 		b100Hz=0;
9145  1acb 72110009      	bres	_b100Hz
9146                     ; 2367 		can_tx_hndl();
9148  1acf cd100e        	call	_can_tx_hndl
9150  1ad2               L3073:
9151                     ; 2370 	if(b10Hz)
9153                     	btst	_b10Hz
9154  1ad7 2425          	jruge	L5073
9155                     ; 2372 		b10Hz=0;
9157  1ad9 72110008      	bres	_b10Hz
9158                     ; 2374 		matemat();
9160  1add cd085c        	call	_matemat
9162                     ; 2375 		led_drv(); 
9164  1ae0 cd03ee        	call	_led_drv
9166                     ; 2376 	  link_drv();
9168  1ae3 cd04dc        	call	_link_drv
9170                     ; 2378 	  JP_drv();
9172  1ae6 cd0451        	call	_JP_drv
9174                     ; 2379 	  flags_drv();
9176  1ae9 cd0ce0        	call	_flags_drv
9178                     ; 2381 		if(main_cnt10<100)main_cnt10++;
9180  1aec 9c            	rvf
9181  1aed ce0253        	ldw	x,_main_cnt10
9182  1af0 a30064        	cpw	x,#100
9183  1af3 2e09          	jrsge	L5073
9186  1af5 ce0253        	ldw	x,_main_cnt10
9187  1af8 1c0001        	addw	x,#1
9188  1afb cf0253        	ldw	_main_cnt10,x
9189  1afe               L5073:
9190                     ; 2384 	if(b5Hz)
9192                     	btst	_b5Hz
9193  1b03 241c          	jruge	L1173
9194                     ; 2386 		b5Hz=0;
9196  1b05 72110007      	bres	_b5Hz
9197                     ; 2392 		pwr_drv();		//воздействие на силу
9199  1b09 cd06ac        	call	_pwr_drv
9201                     ; 2393 		led_hndl();
9203  1b0c cd0163        	call	_led_hndl
9205                     ; 2395 		vent_drv();
9207  1b0f cd0534        	call	_vent_drv
9209                     ; 2397 		if(main_cnt1<1000)main_cnt1++;
9211  1b12 9c            	rvf
9212  1b13 be5b          	ldw	x,_main_cnt1
9213  1b15 a303e8        	cpw	x,#1000
9214  1b18 2e07          	jrsge	L1173
9217  1b1a be5b          	ldw	x,_main_cnt1
9218  1b1c 1c0001        	addw	x,#1
9219  1b1f bf5b          	ldw	_main_cnt1,x
9220  1b21               L1173:
9221                     ; 2400 	if(b2Hz)
9223                     	btst	_b2Hz
9224  1b26 2404          	jruge	L5173
9225                     ; 2402 		b2Hz=0;
9227  1b28 72110006      	bres	_b2Hz
9228  1b2c               L5173:
9229                     ; 2411 	if(b1Hz)
9231                     	btst	_b1Hz
9232  1b31 2503cc1aad    	jruge	L3763
9233                     ; 2413 		b1Hz=0;
9235  1b36 72110005      	bres	_b1Hz
9236                     ; 2415 	  pwr_hndl();		//вычисление воздействий на силу
9238  1b3a cd06e4        	call	_pwr_hndl
9240                     ; 2416 		temper_drv();			//вычисление аварий температуры
9242  1b3d cd0a4d        	call	_temper_drv
9244                     ; 2417 		u_drv();
9246  1b40 cd0b24        	call	_u_drv
9248                     ; 2419 		if(main_cnt<1000)main_cnt++;
9250  1b43 9c            	rvf
9251  1b44 ce0255        	ldw	x,_main_cnt
9252  1b47 a303e8        	cpw	x,#1000
9253  1b4a 2e09          	jrsge	L1273
9256  1b4c ce0255        	ldw	x,_main_cnt
9257  1b4f 1c0001        	addw	x,#1
9258  1b52 cf0255        	ldw	_main_cnt,x
9259  1b55               L1273:
9260                     ; 2420   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9262  1b55 b66d          	ld	a,_link
9263  1b57 a1aa          	cp	a,#170
9264  1b59 2706          	jreq	L5273
9266  1b5b b654          	ld	a,_jp_mode
9267  1b5d a103          	cp	a,#3
9268  1b5f 2603          	jrne	L3273
9269  1b61               L5273:
9272  1b61 cd0c41        	call	_apv_hndl
9274  1b64               L3273:
9275                     ; 2423   		can_error_cnt++;
9277  1b64 3c73          	inc	_can_error_cnt
9278                     ; 2424   		if(can_error_cnt>=10)
9280  1b66 b673          	ld	a,_can_error_cnt
9281  1b68 a10a          	cp	a,#10
9282  1b6a 2505          	jrult	L7273
9283                     ; 2426   			can_error_cnt=0;
9285  1b6c 3f73          	clr	_can_error_cnt
9286                     ; 2427 				init_CAN();
9288  1b6e cd0f1b        	call	_init_CAN
9290  1b71               L7273:
9291                     ; 2437 		vent_resurs_hndl();
9293  1b71 cd0000        	call	_vent_resurs_hndl
9295  1b74 acad1aad      	jpf	L3763
10533                     	xdef	_main
10534                     	xdef	f_ADC2_EOC_Interrupt
10535                     	xdef	f_CAN_TX_Interrupt
10536                     	xdef	f_CAN_RX_Interrupt
10537                     	xdef	f_TIM4_UPD_Interrupt
10538                     	xdef	_adc2_init
10539                     	xdef	_t1_init
10540                     	xdef	_t4_init
10541                     	xdef	_can_in_an
10542                     	xdef	_can_tx_hndl
10543                     	xdef	_can_transmit
10544                     	xdef	_init_CAN
10545                     	xdef	_adr_drv_v3
10546                     	xdef	_adr_drv_v4
10547                     	xdef	_flags_drv
10548                     	xdef	_apv_hndl
10549                     	xdef	_apv_stop
10550                     	xdef	_apv_start
10551                     	xdef	_u_drv
10552                     	xdef	_temper_drv
10553                     	xdef	_matemat
10554                     	xdef	_pwr_hndl
10555                     	xdef	_pwr_drv
10556                     	xdef	_vent_drv
10557                     	xdef	_link_drv
10558                     	xdef	_JP_drv
10559                     	xdef	_led_drv
10560                     	xdef	_led_hndl
10561                     	xdef	_delay_ms
10562                     	xdef	_granee
10563                     	xdef	_gran
10564                     	xdef	_vent_resurs_hndl
10565                     	switch	.ubsct
10566  0001               _debug_info_to_uku:
10567  0001 000000000000  	ds.b	6
10568                     	xdef	_debug_info_to_uku
10569  0007               _pwm_u_cnt:
10570  0007 00            	ds.b	1
10571                     	xdef	_pwm_u_cnt
10572  0008               _vent_resurs_tx_cnt:
10573  0008 00            	ds.b	1
10574                     	xdef	_vent_resurs_tx_cnt
10575                     	switch	.bss
10576  0000               _vent_resurs_buff:
10577  0000 00000000      	ds.b	4
10578                     	xdef	_vent_resurs_buff
10579                     	switch	.ubsct
10580  0009               _vent_resurs_sec_cnt:
10581  0009 0000          	ds.b	2
10582                     	xdef	_vent_resurs_sec_cnt
10583                     .eeprom:	section	.data
10584  0000               _vent_resurs:
10585  0000 0000          	ds.b	2
10586                     	xdef	_vent_resurs
10587  0002               _ee_IMAXVENT:
10588  0002 0000          	ds.b	2
10589                     	xdef	_ee_IMAXVENT
10590                     	switch	.ubsct
10591  000b               _bps_class:
10592  000b 00            	ds.b	1
10593                     	xdef	_bps_class
10594  000c               _vent_pwm_integr_cnt:
10595  000c 0000          	ds.b	2
10596                     	xdef	_vent_pwm_integr_cnt
10597  000e               _vent_pwm_integr:
10598  000e 0000          	ds.b	2
10599                     	xdef	_vent_pwm_integr
10600  0010               _vent_pwm:
10601  0010 0000          	ds.b	2
10602                     	xdef	_vent_pwm
10603  0012               _pwm_vent_cnt:
10604  0012 00            	ds.b	1
10605                     	xdef	_pwm_vent_cnt
10606                     	switch	.eeprom
10607  0004               _ee_DEVICE:
10608  0004 0000          	ds.b	2
10609                     	xdef	_ee_DEVICE
10610  0006               _ee_AVT_MODE:
10611  0006 0000          	ds.b	2
10612                     	xdef	_ee_AVT_MODE
10613                     	switch	.ubsct
10614  0013               _i_main_bps_cnt:
10615  0013 000000000000  	ds.b	6
10616                     	xdef	_i_main_bps_cnt
10617  0019               _i_main_sigma:
10618  0019 0000          	ds.b	2
10619                     	xdef	_i_main_sigma
10620  001b               _i_main_num_of_bps:
10621  001b 00            	ds.b	1
10622                     	xdef	_i_main_num_of_bps
10623  001c               _i_main_avg:
10624  001c 0000          	ds.b	2
10625                     	xdef	_i_main_avg
10626  001e               _i_main_flag:
10627  001e 000000000000  	ds.b	6
10628                     	xdef	_i_main_flag
10629  0024               _i_main:
10630  0024 000000000000  	ds.b	12
10631                     	xdef	_i_main
10632  0030               _x:
10633  0030 000000000000  	ds.b	12
10634                     	xdef	_x
10635                     	xdef	_volum_u_main_
10636                     	switch	.eeprom
10637  0008               _UU_AVT:
10638  0008 0000          	ds.b	2
10639                     	xdef	_UU_AVT
10640                     	switch	.ubsct
10641  003c               _cnt_net_drv:
10642  003c 00            	ds.b	1
10643                     	xdef	_cnt_net_drv
10644                     	switch	.bit
10645  0001               _bMAIN:
10646  0001 00            	ds.b	1
10647                     	xdef	_bMAIN
10648                     	switch	.ubsct
10649  003d               _plazma_int:
10650  003d 000000000000  	ds.b	6
10651                     	xdef	_plazma_int
10652                     	xdef	_rotor_int
10653  0043               _led_green_buff:
10654  0043 00000000      	ds.b	4
10655                     	xdef	_led_green_buff
10656  0047               _led_red_buff:
10657  0047 00000000      	ds.b	4
10658                     	xdef	_led_red_buff
10659                     	xdef	_led_drv_cnt
10660                     	xdef	_led_green
10661                     	xdef	_led_red
10662  004b               _res_fl_cnt:
10663  004b 00            	ds.b	1
10664                     	xdef	_res_fl_cnt
10665                     	xdef	_bRES_
10666                     	xdef	_bRES
10667                     	switch	.eeprom
10668  000a               _res_fl_:
10669  000a 00            	ds.b	1
10670                     	xdef	_res_fl_
10671  000b               _res_fl:
10672  000b 00            	ds.b	1
10673                     	xdef	_res_fl
10674                     	switch	.ubsct
10675  004c               _cnt_apv_off:
10676  004c 00            	ds.b	1
10677                     	xdef	_cnt_apv_off
10678                     	switch	.bit
10679  0002               _bAPV:
10680  0002 00            	ds.b	1
10681                     	xdef	_bAPV
10682                     	switch	.ubsct
10683  004d               _apv_cnt_:
10684  004d 0000          	ds.b	2
10685                     	xdef	_apv_cnt_
10686  004f               _apv_cnt:
10687  004f 000000        	ds.b	3
10688                     	xdef	_apv_cnt
10689                     	xdef	_bBL_IPS
10690                     	switch	.bit
10691  0003               _bBL:
10692  0003 00            	ds.b	1
10693                     	xdef	_bBL
10694                     	switch	.ubsct
10695  0052               _cnt_JP1:
10696  0052 00            	ds.b	1
10697                     	xdef	_cnt_JP1
10698  0053               _cnt_JP0:
10699  0053 00            	ds.b	1
10700                     	xdef	_cnt_JP0
10701  0054               _jp_mode:
10702  0054 00            	ds.b	1
10703                     	xdef	_jp_mode
10704  0055               _pwm_u_:
10705  0055 0000          	ds.b	2
10706                     	xdef	_pwm_u_
10707                     	xdef	_pwm_i
10708                     	xdef	_pwm_u
10709  0057               _tmax_cnt:
10710  0057 0000          	ds.b	2
10711                     	xdef	_tmax_cnt
10712  0059               _tsign_cnt:
10713  0059 0000          	ds.b	2
10714                     	xdef	_tsign_cnt
10715                     	switch	.eeprom
10716  000c               _ee_UAVT:
10717  000c 0000          	ds.b	2
10718                     	xdef	_ee_UAVT
10719  000e               _ee_tsign:
10720  000e 0000          	ds.b	2
10721                     	xdef	_ee_tsign
10722  0010               _ee_tmax:
10723  0010 0000          	ds.b	2
10724                     	xdef	_ee_tmax
10725  0012               _ee_dU:
10726  0012 0000          	ds.b	2
10727                     	xdef	_ee_dU
10728  0014               _ee_Umax:
10729  0014 0000          	ds.b	2
10730                     	xdef	_ee_Umax
10731  0016               _ee_TZAS:
10732  0016 0000          	ds.b	2
10733                     	xdef	_ee_TZAS
10734                     	switch	.ubsct
10735  005b               _main_cnt1:
10736  005b 0000          	ds.b	2
10737                     	xdef	_main_cnt1
10738  005d               _off_bp_cnt:
10739  005d 00            	ds.b	1
10740                     	xdef	_off_bp_cnt
10741                     	xdef	_vol_i_temp_avar
10742  005e               _flags_tu_cnt_off:
10743  005e 00            	ds.b	1
10744                     	xdef	_flags_tu_cnt_off
10745  005f               _flags_tu_cnt_on:
10746  005f 00            	ds.b	1
10747                     	xdef	_flags_tu_cnt_on
10748  0060               _vol_i_temp:
10749  0060 0000          	ds.b	2
10750                     	xdef	_vol_i_temp
10751  0062               _vol_u_temp:
10752  0062 0000          	ds.b	2
10753                     	xdef	_vol_u_temp
10754                     	switch	.eeprom
10755  0018               __x_ee_:
10756  0018 0000          	ds.b	2
10757                     	xdef	__x_ee_
10758                     	switch	.ubsct
10759  0064               __x_cnt:
10760  0064 0000          	ds.b	2
10761                     	xdef	__x_cnt
10762  0066               __x__:
10763  0066 0000          	ds.b	2
10764                     	xdef	__x__
10765  0068               __x_:
10766  0068 0000          	ds.b	2
10767                     	xdef	__x_
10768  006a               _flags_tu:
10769  006a 00            	ds.b	1
10770                     	xdef	_flags_tu
10771                     	xdef	_flags
10772  006b               _link_cnt:
10773  006b 0000          	ds.b	2
10774                     	xdef	_link_cnt
10775  006d               _link:
10776  006d 00            	ds.b	1
10777                     	xdef	_link
10778  006e               _umin_cnt:
10779  006e 0000          	ds.b	2
10780                     	xdef	_umin_cnt
10781  0070               _umax_cnt:
10782  0070 0000          	ds.b	2
10783                     	xdef	_umax_cnt
10784                     	switch	.eeprom
10785  001a               _ee_K:
10786  001a 000000000000  	ds.b	20
10787                     	xdef	_ee_K
10788                     	switch	.ubsct
10789  0072               _T:
10790  0072 00            	ds.b	1
10791                     	xdef	_T
10792                     	switch	.bss
10793  0004               _Uin:
10794  0004 0000          	ds.b	2
10795                     	xdef	_Uin
10796  0006               _Usum:
10797  0006 0000          	ds.b	2
10798                     	xdef	_Usum
10799  0008               _U_out_const:
10800  0008 0000          	ds.b	2
10801                     	xdef	_U_out_const
10802  000a               _Unecc:
10803  000a 0000          	ds.b	2
10804                     	xdef	_Unecc
10805  000c               _Ui:
10806  000c 0000          	ds.b	2
10807                     	xdef	_Ui
10808  000e               _Un:
10809  000e 0000          	ds.b	2
10810                     	xdef	_Un
10811  0010               _I:
10812  0010 0000          	ds.b	2
10813                     	xdef	_I
10814                     	switch	.ubsct
10815  0073               _can_error_cnt:
10816  0073 00            	ds.b	1
10817                     	xdef	_can_error_cnt
10818                     	xdef	_bCAN_RX
10819  0074               _tx_busy_cnt:
10820  0074 00            	ds.b	1
10821                     	xdef	_tx_busy_cnt
10822                     	xdef	_bTX_FREE
10823  0075               _can_buff_rd_ptr:
10824  0075 00            	ds.b	1
10825                     	xdef	_can_buff_rd_ptr
10826  0076               _can_buff_wr_ptr:
10827  0076 00            	ds.b	1
10828                     	xdef	_can_buff_wr_ptr
10829  0077               _can_out_buff:
10830  0077 000000000000  	ds.b	64
10831                     	xdef	_can_out_buff
10832                     	switch	.bss
10833  0012               _pwm_u_buff_cnt:
10834  0012 00            	ds.b	1
10835                     	xdef	_pwm_u_buff_cnt
10836  0013               _pwm_u_buff_ptr:
10837  0013 00            	ds.b	1
10838                     	xdef	_pwm_u_buff_ptr
10839  0014               _pwm_u_buff_:
10840  0014 0000          	ds.b	2
10841                     	xdef	_pwm_u_buff_
10842  0016               _pwm_u_buff:
10843  0016 000000000000  	ds.b	64
10844                     	xdef	_pwm_u_buff
10845                     	switch	.ubsct
10846  00b7               _adc_cnt_cnt:
10847  00b7 00            	ds.b	1
10848                     	xdef	_adc_cnt_cnt
10849                     	switch	.bss
10850  0056               _adc_buff_buff:
10851  0056 000000000000  	ds.b	160
10852                     	xdef	_adc_buff_buff
10853  00f6               _adress_error:
10854  00f6 00            	ds.b	1
10855                     	xdef	_adress_error
10856  00f7               _adress:
10857  00f7 00            	ds.b	1
10858                     	xdef	_adress
10859  00f8               _adr:
10860  00f8 000000        	ds.b	3
10861                     	xdef	_adr
10862                     	xdef	_adr_drv_stat
10863                     	xdef	_led_ind
10864                     	switch	.ubsct
10865  00b8               _led_ind_cnt:
10866  00b8 00            	ds.b	1
10867                     	xdef	_led_ind_cnt
10868  00b9               _adc_plazma:
10869  00b9 000000000000  	ds.b	10
10870                     	xdef	_adc_plazma
10871  00c3               _adc_plazma_short:
10872  00c3 0000          	ds.b	2
10873                     	xdef	_adc_plazma_short
10874  00c5               _adc_cnt:
10875  00c5 00            	ds.b	1
10876                     	xdef	_adc_cnt
10877  00c6               _adc_ch:
10878  00c6 00            	ds.b	1
10879                     	xdef	_adc_ch
10880                     	switch	.bss
10881  00fb               _adc_buff_1:
10882  00fb 0000          	ds.b	2
10883                     	xdef	_adc_buff_1
10884  00fd               _adc_buff_5:
10885  00fd 0000          	ds.b	2
10886                     	xdef	_adc_buff_5
10887  00ff               _adc_buff_:
10888  00ff 000000000000  	ds.b	20
10889                     	xdef	_adc_buff_
10890  0113               _adc_buff:
10891  0113 000000000000  	ds.b	320
10892                     	xdef	_adc_buff
10893  0253               _main_cnt10:
10894  0253 0000          	ds.b	2
10895                     	xdef	_main_cnt10
10896  0255               _main_cnt:
10897  0255 0000          	ds.b	2
10898                     	xdef	_main_cnt
10899                     	switch	.ubsct
10900  00c7               _mess:
10901  00c7 000000000000  	ds.b	14
10902                     	xdef	_mess
10903                     	switch	.bit
10904  0004               _b1000Hz:
10905  0004 00            	ds.b	1
10906                     	xdef	_b1000Hz
10907  0005               _b1Hz:
10908  0005 00            	ds.b	1
10909                     	xdef	_b1Hz
10910  0006               _b2Hz:
10911  0006 00            	ds.b	1
10912                     	xdef	_b2Hz
10913  0007               _b5Hz:
10914  0007 00            	ds.b	1
10915                     	xdef	_b5Hz
10916  0008               _b10Hz:
10917  0008 00            	ds.b	1
10918                     	xdef	_b10Hz
10919  0009               _b100Hz:
10920  0009 00            	ds.b	1
10921                     	xdef	_b100Hz
10922                     	xdef	_t0_cnt4
10923                     	xdef	_t0_cnt3
10924                     	xdef	_t0_cnt2
10925                     	xdef	_t0_cnt1
10926                     	xdef	_t0_cnt0
10927                     	xdef	_t0_cnt00
10928                     	xref	_abs
10929                     	xdef	_bVENT_BLOCK
10930                     	xref.b	c_lreg
10931                     	xref.b	c_x
10932                     	xref.b	c_y
10952                     	xref	c_lrsh
10953                     	xref	c_umul
10954                     	xref	c_lgsub
10955                     	xref	c_lgrsh
10956                     	xref	c_lgadd
10957                     	xref	c_idiv
10958                     	xref	c_sdivx
10959                     	xref	c_imul
10960                     	xref	c_lsbc
10961                     	xref	c_ladd
10962                     	xref	c_lsub
10963                     	xref	c_ldiv
10964                     	xref	c_lgmul
10965                     	xref	c_itolx
10966                     	xref	c_eewrc
10967                     	xref	c_ltor
10968                     	xref	c_lgadc
10969                     	xref	c_rtol
10970                     	xref	c_vmul
10971                     	xref	c_eewrw
10972                     	xref	c_lcmp
10973                     	xref	c_uitolx
10974                     	end
