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
4019                     ; 734 void pwr_drv(void)
4019                     ; 735 {
4020                     	switch	.text
4021  06ac               _pwr_drv:
4025                     ; 796 gran(&pwm_u,10,2000);
4027  06ac ae07d0        	ldw	x,#2000
4028  06af 89            	pushw	x
4029  06b0 ae000a        	ldw	x,#10
4030  06b3 89            	pushw	x
4031  06b4 ae0008        	ldw	x,#_pwm_u
4032  06b7 cd00d5        	call	_gran
4034  06ba 5b04          	addw	sp,#4
4035                     ; 806 TIM1->CCR2H= (char)(pwm_u/256);	
4037  06bc be08          	ldw	x,_pwm_u
4038  06be 90ae0100      	ldw	y,#256
4039  06c2 cd0000        	call	c_idiv
4041  06c5 9f            	ld	a,xl
4042  06c6 c75267        	ld	21095,a
4043                     ; 807 TIM1->CCR2L= (char)pwm_u;
4045  06c9 5500095268    	mov	21096,_pwm_u+1
4046                     ; 809 TIM1->CCR1H= (char)(pwm_i/256);	
4048  06ce be0a          	ldw	x,_pwm_i
4049  06d0 90ae0100      	ldw	y,#256
4050  06d4 cd0000        	call	c_idiv
4052  06d7 9f            	ld	a,xl
4053  06d8 c75265        	ld	21093,a
4054                     ; 810 TIM1->CCR1L= (char)pwm_i;
4056  06db 55000b5266    	mov	21094,_pwm_i+1
4057                     ; 812 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4059  06e0 be0e          	ldw	x,_vent_pwm_integr
4060  06e2 90ae0080      	ldw	y,#128
4061  06e6 cd0000        	call	c_idiv
4063  06e9 9f            	ld	a,xl
4064  06ea c75269        	ld	21097,a
4065                     ; 813 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4067  06ed b60f          	ld	a,_vent_pwm_integr+1
4068  06ef 48            	sll	a
4069  06f0 c7526a        	ld	21098,a
4070                     ; 814 }
4073  06f3 81            	ret
4130                     	switch	.const
4131  0018               L45:
4132  0018 0000028a      	dc.l	650
4133                     ; 819 void pwr_hndl(void)				
4133                     ; 820 {
4134                     	switch	.text
4135  06f4               _pwr_hndl:
4137  06f4 5205          	subw	sp,#5
4138       00000005      OFST:	set	5
4141                     ; 821 if(jp_mode==jp3)
4143  06f6 b654          	ld	a,_jp_mode
4144  06f8 a103          	cp	a,#3
4145  06fa 260a          	jrne	L7612
4146                     ; 823 	pwm_u=0;
4148  06fc 5f            	clrw	x
4149  06fd bf08          	ldw	_pwm_u,x
4150                     ; 824 	pwm_i=0;
4152  06ff 5f            	clrw	x
4153  0700 bf0a          	ldw	_pwm_i,x
4155  0702 ac260826      	jpf	L1712
4156  0706               L7612:
4157                     ; 826 else if(jp_mode==jp2)
4159  0706 b654          	ld	a,_jp_mode
4160  0708 a102          	cp	a,#2
4161  070a 260c          	jrne	L3712
4162                     ; 828 	pwm_u=0;
4164  070c 5f            	clrw	x
4165  070d bf08          	ldw	_pwm_u,x
4166                     ; 829 	pwm_i=0x7ff;
4168  070f ae07ff        	ldw	x,#2047
4169  0712 bf0a          	ldw	_pwm_i,x
4171  0714 ac260826      	jpf	L1712
4172  0718               L3712:
4173                     ; 831 else if(jp_mode==jp1)
4175  0718 b654          	ld	a,_jp_mode
4176  071a a101          	cp	a,#1
4177  071c 260e          	jrne	L7712
4178                     ; 833 	pwm_u=0x7ff;
4180  071e ae07ff        	ldw	x,#2047
4181  0721 bf08          	ldw	_pwm_u,x
4182                     ; 834 	pwm_i=0x7ff;
4184  0723 ae07ff        	ldw	x,#2047
4185  0726 bf0a          	ldw	_pwm_i,x
4187  0728 ac260826      	jpf	L1712
4188  072c               L7712:
4189                     ; 845 else if(link==OFF)
4191  072c b66d          	ld	a,_link
4192  072e a1aa          	cp	a,#170
4193  0730 2703          	jreq	L65
4194  0732 cc07d4        	jp	L3022
4195  0735               L65:
4196                     ; 847 	pwm_i=0x7ff;
4198  0735 ae07ff        	ldw	x,#2047
4199  0738 bf0a          	ldw	_pwm_i,x
4200                     ; 848 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4202  073a ce000a        	ldw	x,_Unecc
4203  073d 90ae07d0      	ldw	y,#2000
4204  0741 cd0000        	call	c_vmul
4206  0744 ae0018        	ldw	x,#L45
4207  0747 cd0000        	call	c_ldiv
4209  074a be02          	ldw	x,c_lreg+2
4210  074c bf55          	ldw	_pwm_u_,x
4211                     ; 852 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4213  074e c60013        	ld	a,_pwm_u_buff_ptr
4214  0751 5f            	clrw	x
4215  0752 97            	ld	xl,a
4216  0753 58            	sllw	x
4217  0754 90be55        	ldw	y,_pwm_u_
4218  0757 df0016        	ldw	(_pwm_u_buff,x),y
4219                     ; 853 	pwm_u_buff_ptr++;
4221  075a 725c0013      	inc	_pwm_u_buff_ptr
4222                     ; 854 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4224  075e c60013        	ld	a,_pwm_u_buff_ptr
4225  0761 a110          	cp	a,#16
4226  0763 2504          	jrult	L5022
4229  0765 725f0013      	clr	_pwm_u_buff_ptr
4230  0769               L5022:
4231                     ; 858 		tempSL=0;
4233  0769 ae0000        	ldw	x,#0
4234  076c 1f03          	ldw	(OFST-2,sp),x
4235  076e ae0000        	ldw	x,#0
4236  0771 1f01          	ldw	(OFST-4,sp),x
4237                     ; 859 		for(i=0;i<16;i++)
4239  0773 0f05          	clr	(OFST+0,sp)
4240  0775               L7022:
4241                     ; 861 			tempSL+=(signed long)pwm_u_buff[i];
4243  0775 7b05          	ld	a,(OFST+0,sp)
4244  0777 5f            	clrw	x
4245  0778 97            	ld	xl,a
4246  0779 58            	sllw	x
4247  077a de0016        	ldw	x,(_pwm_u_buff,x)
4248  077d cd0000        	call	c_itolx
4250  0780 96            	ldw	x,sp
4251  0781 1c0001        	addw	x,#OFST-4
4252  0784 cd0000        	call	c_lgadd
4254                     ; 859 		for(i=0;i<16;i++)
4256  0787 0c05          	inc	(OFST+0,sp)
4259  0789 7b05          	ld	a,(OFST+0,sp)
4260  078b a110          	cp	a,#16
4261  078d 25e6          	jrult	L7022
4262                     ; 863 		tempSL>>=4;
4264  078f 96            	ldw	x,sp
4265  0790 1c0001        	addw	x,#OFST-4
4266  0793 a604          	ld	a,#4
4267  0795 cd0000        	call	c_lgrsh
4269                     ; 864 		pwm_u_buff_=(signed short)tempSL;
4271  0798 1e03          	ldw	x,(OFST-2,sp)
4272  079a cf0014        	ldw	_pwm_u_buff_,x
4273                     ; 866 	pwm_u=pwm_u_;
4275  079d be55          	ldw	x,_pwm_u_
4276  079f bf08          	ldw	_pwm_u,x
4277                     ; 867 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4279  07a1 9c            	rvf
4280  07a2 ce000c        	ldw	x,_Ui
4281  07a5 72b0000a      	subw	x,_Unecc
4282  07a9 cd0000        	call	_abs
4284  07ac a30014        	cpw	x,#20
4285  07af 2e06          	jrsge	L5122
4288  07b1 725c0012      	inc	_pwm_u_buff_cnt
4290  07b5 2004          	jra	L7122
4291  07b7               L5122:
4292                     ; 868 	else pwm_u_buff_cnt=0;
4294  07b7 725f0012      	clr	_pwm_u_buff_cnt
4295  07bb               L7122:
4296                     ; 870 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4298  07bb c60012        	ld	a,_pwm_u_buff_cnt
4299  07be a114          	cp	a,#20
4300  07c0 2504          	jrult	L1222
4303  07c2 35140012      	mov	_pwm_u_buff_cnt,#20
4304  07c6               L1222:
4305                     ; 871 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4307  07c6 c60012        	ld	a,_pwm_u_buff_cnt
4308  07c9 a10f          	cp	a,#15
4309  07cb 2559          	jrult	L1712
4312  07cd ce0014        	ldw	x,_pwm_u_buff_
4313  07d0 bf08          	ldw	_pwm_u,x
4314  07d2 2052          	jra	L1712
4315  07d4               L3022:
4316                     ; 875 else	if(link==ON)				//если есть связьvol_i_temp_avar
4318  07d4 b66d          	ld	a,_link
4319  07d6 a155          	cp	a,#85
4320  07d8 264c          	jrne	L1712
4321                     ; 877 	if((flags&0b00100000)==0)	//если нет блокировки извне
4323  07da b605          	ld	a,_flags
4324  07dc a520          	bcp	a,#32
4325  07de 263a          	jrne	L1322
4326                     ; 884 		else*/ if(flags&0b00011010)					//если есть аварии
4328  07e0 b605          	ld	a,_flags
4329  07e2 a51a          	bcp	a,#26
4330  07e4 2706          	jreq	L3322
4331                     ; 886 			pwm_u=0;								//то полный стоп
4333  07e6 5f            	clrw	x
4334  07e7 bf08          	ldw	_pwm_u,x
4335                     ; 887 			pwm_i=0;
4337  07e9 5f            	clrw	x
4338  07ea bf0a          	ldw	_pwm_i,x
4339  07ec               L3322:
4340                     ; 890 		if(vol_i_temp==2000)
4342  07ec be60          	ldw	x,_vol_i_temp
4343  07ee a307d0        	cpw	x,#2000
4344  07f1 260c          	jrne	L5322
4345                     ; 892 			pwm_u=1500;
4347  07f3 ae05dc        	ldw	x,#1500
4348  07f6 bf08          	ldw	_pwm_u,x
4349                     ; 893 			pwm_i=2000;
4351  07f8 ae07d0        	ldw	x,#2000
4352  07fb bf0a          	ldw	_pwm_i,x
4354  07fd 2027          	jra	L1712
4355  07ff               L5322:
4356                     ; 906 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4358  07ff ce000a        	ldw	x,_Unecc
4359  0802 90ae07d0      	ldw	y,#2000
4360  0806 cd0000        	call	c_vmul
4362  0809 ae0018        	ldw	x,#L45
4363  080c cd0000        	call	c_ldiv
4365  080f be02          	ldw	x,c_lreg+2
4366  0811 bf08          	ldw	_pwm_u,x
4367                     ; 907 			pwm_i=2000;
4369  0813 ae07d0        	ldw	x,#2000
4370  0816 bf0a          	ldw	_pwm_i,x
4371  0818 200c          	jra	L1712
4372  081a               L1322:
4373                     ; 913 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4375  081a b605          	ld	a,_flags
4376  081c a520          	bcp	a,#32
4377  081e 2706          	jreq	L1712
4378                     ; 915 		pwm_u=0;
4380  0820 5f            	clrw	x
4381  0821 bf08          	ldw	_pwm_u,x
4382                     ; 916 		pwm_i=0;
4384  0823 5f            	clrw	x
4385  0824 bf0a          	ldw	_pwm_i,x
4386  0826               L1712:
4387                     ; 944 if(pwm_u>2000)pwm_u=2000;
4389  0826 9c            	rvf
4390  0827 be08          	ldw	x,_pwm_u
4391  0829 a307d1        	cpw	x,#2001
4392  082c 2f05          	jrslt	L5422
4395  082e ae07d0        	ldw	x,#2000
4396  0831 bf08          	ldw	_pwm_u,x
4397  0833               L5422:
4398                     ; 945 if(pwm_i>2000)pwm_i=2000;
4400  0833 9c            	rvf
4401  0834 be0a          	ldw	x,_pwm_i
4402  0836 a307d1        	cpw	x,#2001
4403  0839 2f05          	jrslt	L7422
4406  083b ae07d0        	ldw	x,#2000
4407  083e bf0a          	ldw	_pwm_i,x
4408  0840               L7422:
4409                     ; 948 }
4412  0840 5b05          	addw	sp,#5
4413  0842 81            	ret
4466                     	switch	.const
4467  001c               L26:
4468  001c 00000258      	dc.l	600
4469  0020               L46:
4470  0020 000003e8      	dc.l	1000
4471  0024               L66:
4472  0024 00000708      	dc.l	1800
4473                     ; 951 void matemat(void)
4473                     ; 952 {
4474                     	switch	.text
4475  0843               _matemat:
4477  0843 5208          	subw	sp,#8
4478       00000008      OFST:	set	8
4481                     ; 976 I=adc_buff_[4];
4483  0845 ce0107        	ldw	x,_adc_buff_+8
4484  0848 cf0010        	ldw	_I,x
4485                     ; 977 temp_SL=adc_buff_[4];
4487  084b ce0107        	ldw	x,_adc_buff_+8
4488  084e cd0000        	call	c_itolx
4490  0851 96            	ldw	x,sp
4491  0852 1c0005        	addw	x,#OFST-3
4492  0855 cd0000        	call	c_rtol
4494                     ; 978 temp_SL-=ee_K[0][0];
4496  0858 ce001a        	ldw	x,_ee_K
4497  085b cd0000        	call	c_itolx
4499  085e 96            	ldw	x,sp
4500  085f 1c0005        	addw	x,#OFST-3
4501  0862 cd0000        	call	c_lgsub
4503                     ; 979 if(temp_SL<0) temp_SL=0;
4505  0865 9c            	rvf
4506  0866 0d05          	tnz	(OFST-3,sp)
4507  0868 2e0a          	jrsge	L7622
4510  086a ae0000        	ldw	x,#0
4511  086d 1f07          	ldw	(OFST-1,sp),x
4512  086f ae0000        	ldw	x,#0
4513  0872 1f05          	ldw	(OFST-3,sp),x
4514  0874               L7622:
4515                     ; 980 temp_SL*=ee_K[0][1];
4517  0874 ce001c        	ldw	x,_ee_K+2
4518  0877 cd0000        	call	c_itolx
4520  087a 96            	ldw	x,sp
4521  087b 1c0005        	addw	x,#OFST-3
4522  087e cd0000        	call	c_lgmul
4524                     ; 981 temp_SL/=600;
4526  0881 96            	ldw	x,sp
4527  0882 1c0005        	addw	x,#OFST-3
4528  0885 cd0000        	call	c_ltor
4530  0888 ae001c        	ldw	x,#L26
4531  088b cd0000        	call	c_ldiv
4533  088e 96            	ldw	x,sp
4534  088f 1c0005        	addw	x,#OFST-3
4535  0892 cd0000        	call	c_rtol
4537                     ; 982 I=(signed short)temp_SL;
4539  0895 1e07          	ldw	x,(OFST-1,sp)
4540  0897 cf0010        	ldw	_I,x
4541                     ; 985 temp_SL=(signed long)adc_buff_[1];//1;
4543                     ; 986 temp_SL=(signed long)adc_buff_[3];//1;
4545  089a ce0105        	ldw	x,_adc_buff_+6
4546  089d cd0000        	call	c_itolx
4548  08a0 96            	ldw	x,sp
4549  08a1 1c0005        	addw	x,#OFST-3
4550  08a4 cd0000        	call	c_rtol
4552                     ; 988 if(temp_SL<0) temp_SL=0;
4554  08a7 9c            	rvf
4555  08a8 0d05          	tnz	(OFST-3,sp)
4556  08aa 2e0a          	jrsge	L1722
4559  08ac ae0000        	ldw	x,#0
4560  08af 1f07          	ldw	(OFST-1,sp),x
4561  08b1 ae0000        	ldw	x,#0
4562  08b4 1f05          	ldw	(OFST-3,sp),x
4563  08b6               L1722:
4564                     ; 989 temp_SL*=(signed long)ee_K[2][1];
4566  08b6 ce0024        	ldw	x,_ee_K+10
4567  08b9 cd0000        	call	c_itolx
4569  08bc 96            	ldw	x,sp
4570  08bd 1c0005        	addw	x,#OFST-3
4571  08c0 cd0000        	call	c_lgmul
4573                     ; 990 temp_SL/=1000L;
4575  08c3 96            	ldw	x,sp
4576  08c4 1c0005        	addw	x,#OFST-3
4577  08c7 cd0000        	call	c_ltor
4579  08ca ae0020        	ldw	x,#L46
4580  08cd cd0000        	call	c_ldiv
4582  08d0 96            	ldw	x,sp
4583  08d1 1c0005        	addw	x,#OFST-3
4584  08d4 cd0000        	call	c_rtol
4586                     ; 991 Ui=(unsigned short)temp_SL;
4588  08d7 1e07          	ldw	x,(OFST-1,sp)
4589  08d9 cf000c        	ldw	_Ui,x
4590                     ; 993 temp_SL=(signed long)adc_buff_5;
4592  08dc ce00fd        	ldw	x,_adc_buff_5
4593  08df cd0000        	call	c_itolx
4595  08e2 96            	ldw	x,sp
4596  08e3 1c0005        	addw	x,#OFST-3
4597  08e6 cd0000        	call	c_rtol
4599                     ; 995 if(temp_SL<0) temp_SL=0;
4601  08e9 9c            	rvf
4602  08ea 0d05          	tnz	(OFST-3,sp)
4603  08ec 2e0a          	jrsge	L3722
4606  08ee ae0000        	ldw	x,#0
4607  08f1 1f07          	ldw	(OFST-1,sp),x
4608  08f3 ae0000        	ldw	x,#0
4609  08f6 1f05          	ldw	(OFST-3,sp),x
4610  08f8               L3722:
4611                     ; 996 temp_SL*=(signed long)ee_K[4][1];
4613  08f8 ce002c        	ldw	x,_ee_K+18
4614  08fb cd0000        	call	c_itolx
4616  08fe 96            	ldw	x,sp
4617  08ff 1c0005        	addw	x,#OFST-3
4618  0902 cd0000        	call	c_lgmul
4620                     ; 997 temp_SL/=1000L;
4622  0905 96            	ldw	x,sp
4623  0906 1c0005        	addw	x,#OFST-3
4624  0909 cd0000        	call	c_ltor
4626  090c ae0020        	ldw	x,#L46
4627  090f cd0000        	call	c_ldiv
4629  0912 96            	ldw	x,sp
4630  0913 1c0005        	addw	x,#OFST-3
4631  0916 cd0000        	call	c_rtol
4633                     ; 998 Usum=(unsigned short)temp_SL;
4635  0919 1e07          	ldw	x,(OFST-1,sp)
4636  091b cf0006        	ldw	_Usum,x
4637                     ; 1002 temp_SL=adc_buff_[3];
4639  091e ce0105        	ldw	x,_adc_buff_+6
4640  0921 cd0000        	call	c_itolx
4642  0924 96            	ldw	x,sp
4643  0925 1c0005        	addw	x,#OFST-3
4644  0928 cd0000        	call	c_rtol
4646                     ; 1004 if(temp_SL<0) temp_SL=0;
4648  092b 9c            	rvf
4649  092c 0d05          	tnz	(OFST-3,sp)
4650  092e 2e0a          	jrsge	L5722
4653  0930 ae0000        	ldw	x,#0
4654  0933 1f07          	ldw	(OFST-1,sp),x
4655  0935 ae0000        	ldw	x,#0
4656  0938 1f05          	ldw	(OFST-3,sp),x
4657  093a               L5722:
4658                     ; 1005 temp_SL*=ee_K[1][1];
4660  093a ce0020        	ldw	x,_ee_K+6
4661  093d cd0000        	call	c_itolx
4663  0940 96            	ldw	x,sp
4664  0941 1c0005        	addw	x,#OFST-3
4665  0944 cd0000        	call	c_lgmul
4667                     ; 1006 temp_SL/=1800;
4669  0947 96            	ldw	x,sp
4670  0948 1c0005        	addw	x,#OFST-3
4671  094b cd0000        	call	c_ltor
4673  094e ae0024        	ldw	x,#L66
4674  0951 cd0000        	call	c_ldiv
4676  0954 96            	ldw	x,sp
4677  0955 1c0005        	addw	x,#OFST-3
4678  0958 cd0000        	call	c_rtol
4680                     ; 1007 Un=(unsigned short)temp_SL;
4682  095b 1e07          	ldw	x,(OFST-1,sp)
4683  095d cf000e        	ldw	_Un,x
4684                     ; 1012 temp_SL=adc_buff_[2];
4686  0960 ce0103        	ldw	x,_adc_buff_+4
4687  0963 cd0000        	call	c_itolx
4689  0966 96            	ldw	x,sp
4690  0967 1c0005        	addw	x,#OFST-3
4691  096a cd0000        	call	c_rtol
4693                     ; 1013 temp_SL*=ee_K[3][1];
4695  096d ce0028        	ldw	x,_ee_K+14
4696  0970 cd0000        	call	c_itolx
4698  0973 96            	ldw	x,sp
4699  0974 1c0005        	addw	x,#OFST-3
4700  0977 cd0000        	call	c_lgmul
4702                     ; 1014 temp_SL/=1000;
4704  097a 96            	ldw	x,sp
4705  097b 1c0005        	addw	x,#OFST-3
4706  097e cd0000        	call	c_ltor
4708  0981 ae0020        	ldw	x,#L46
4709  0984 cd0000        	call	c_ldiv
4711  0987 96            	ldw	x,sp
4712  0988 1c0005        	addw	x,#OFST-3
4713  098b cd0000        	call	c_rtol
4715                     ; 1015 T=(signed short)(temp_SL-273L);
4717  098e 7b08          	ld	a,(OFST+0,sp)
4718  0990 5f            	clrw	x
4719  0991 4d            	tnz	a
4720  0992 2a01          	jrpl	L07
4721  0994 53            	cplw	x
4722  0995               L07:
4723  0995 97            	ld	xl,a
4724  0996 1d0111        	subw	x,#273
4725  0999 01            	rrwa	x,a
4726  099a b772          	ld	_T,a
4727  099c 02            	rlwa	x,a
4728                     ; 1016 if(T<-30)T=-30;
4730  099d 9c            	rvf
4731  099e b672          	ld	a,_T
4732  09a0 a1e2          	cp	a,#226
4733  09a2 2e04          	jrsge	L7722
4736  09a4 35e20072      	mov	_T,#226
4737  09a8               L7722:
4738                     ; 1017 if(T>120)T=120;
4740  09a8 9c            	rvf
4741  09a9 b672          	ld	a,_T
4742  09ab a179          	cp	a,#121
4743  09ad 2f04          	jrslt	L1032
4746  09af 35780072      	mov	_T,#120
4747  09b3               L1032:
4748                     ; 1021 Uin=Usum-Ui;
4750  09b3 ce0006        	ldw	x,_Usum
4751  09b6 72b0000c      	subw	x,_Ui
4752  09ba cf0004        	ldw	_Uin,x
4753                     ; 1022 if(link==ON)
4755  09bd b66d          	ld	a,_link
4756  09bf a155          	cp	a,#85
4757  09c1 2610          	jrne	L3032
4758                     ; 1024 	Unecc=U_out_const-Uin+vol_i_temp;
4760  09c3 ce0008        	ldw	x,_U_out_const
4761  09c6 72b00004      	subw	x,_Uin
4762  09ca 72bb0060      	addw	x,_vol_i_temp
4763  09ce cf000a        	ldw	_Unecc,x
4765  09d1 200a          	jra	L5032
4766  09d3               L3032:
4767                     ; 1033 else Unecc=ee_UAVT-Uin;
4769  09d3 ce000c        	ldw	x,_ee_UAVT
4770  09d6 72b00004      	subw	x,_Uin
4771  09da cf000a        	ldw	_Unecc,x
4772  09dd               L5032:
4773                     ; 1041 if(Unecc<0)Unecc=0;
4775  09dd 9c            	rvf
4776  09de ce000a        	ldw	x,_Unecc
4777  09e1 2e04          	jrsge	L7032
4780  09e3 5f            	clrw	x
4781  09e4 cf000a        	ldw	_Unecc,x
4782  09e7               L7032:
4783                     ; 1042 temp_SL=(signed long)(T-ee_tsign);
4785  09e7 5f            	clrw	x
4786  09e8 b672          	ld	a,_T
4787  09ea 2a01          	jrpl	L27
4788  09ec 53            	cplw	x
4789  09ed               L27:
4790  09ed 97            	ld	xl,a
4791  09ee 72b0000e      	subw	x,_ee_tsign
4792  09f2 cd0000        	call	c_itolx
4794  09f5 96            	ldw	x,sp
4795  09f6 1c0005        	addw	x,#OFST-3
4796  09f9 cd0000        	call	c_rtol
4798                     ; 1043 temp_SL*=1000L;
4800  09fc ae03e8        	ldw	x,#1000
4801  09ff bf02          	ldw	c_lreg+2,x
4802  0a01 ae0000        	ldw	x,#0
4803  0a04 bf00          	ldw	c_lreg,x
4804  0a06 96            	ldw	x,sp
4805  0a07 1c0005        	addw	x,#OFST-3
4806  0a0a cd0000        	call	c_lgmul
4808                     ; 1044 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4810  0a0d ce0010        	ldw	x,_ee_tmax
4811  0a10 72b0000e      	subw	x,_ee_tsign
4812  0a14 cd0000        	call	c_itolx
4814  0a17 96            	ldw	x,sp
4815  0a18 1c0001        	addw	x,#OFST-7
4816  0a1b cd0000        	call	c_rtol
4818  0a1e 96            	ldw	x,sp
4819  0a1f 1c0005        	addw	x,#OFST-3
4820  0a22 cd0000        	call	c_ltor
4822  0a25 96            	ldw	x,sp
4823  0a26 1c0001        	addw	x,#OFST-7
4824  0a29 cd0000        	call	c_ldiv
4826  0a2c 96            	ldw	x,sp
4827  0a2d 1c0005        	addw	x,#OFST-3
4828  0a30 cd0000        	call	c_rtol
4830                     ; 1046 vol_i_temp_avar=(unsigned short)temp_SL; 
4832  0a33 1e07          	ldw	x,(OFST-1,sp)
4833  0a35 bf06          	ldw	_vol_i_temp_avar,x
4834                     ; 1048 debug_info_to_uku[0]=pwm_u;
4836  0a37 be08          	ldw	x,_pwm_u
4837  0a39 bf01          	ldw	_debug_info_to_uku,x
4838                     ; 1049 debug_info_to_uku[1]=Unecc;
4840  0a3b ce000a        	ldw	x,_Unecc
4841  0a3e bf03          	ldw	_debug_info_to_uku+2,x
4842                     ; 1051 }
4845  0a40 5b08          	addw	sp,#8
4846  0a42 81            	ret
4877                     ; 1054 void temper_drv(void)		//1 Hz
4877                     ; 1055 {
4878                     	switch	.text
4879  0a43               _temper_drv:
4883                     ; 1057 if(T>ee_tsign) tsign_cnt++;
4885  0a43 9c            	rvf
4886  0a44 5f            	clrw	x
4887  0a45 b672          	ld	a,_T
4888  0a47 2a01          	jrpl	L67
4889  0a49 53            	cplw	x
4890  0a4a               L67:
4891  0a4a 97            	ld	xl,a
4892  0a4b c3000e        	cpw	x,_ee_tsign
4893  0a4e 2d09          	jrsle	L1232
4896  0a50 be59          	ldw	x,_tsign_cnt
4897  0a52 1c0001        	addw	x,#1
4898  0a55 bf59          	ldw	_tsign_cnt,x
4900  0a57 201d          	jra	L3232
4901  0a59               L1232:
4902                     ; 1058 else if (T<(ee_tsign-1)) tsign_cnt--;
4904  0a59 9c            	rvf
4905  0a5a ce000e        	ldw	x,_ee_tsign
4906  0a5d 5a            	decw	x
4907  0a5e 905f          	clrw	y
4908  0a60 b672          	ld	a,_T
4909  0a62 2a02          	jrpl	L001
4910  0a64 9053          	cplw	y
4911  0a66               L001:
4912  0a66 9097          	ld	yl,a
4913  0a68 90bf00        	ldw	c_y,y
4914  0a6b b300          	cpw	x,c_y
4915  0a6d 2d07          	jrsle	L3232
4918  0a6f be59          	ldw	x,_tsign_cnt
4919  0a71 1d0001        	subw	x,#1
4920  0a74 bf59          	ldw	_tsign_cnt,x
4921  0a76               L3232:
4922                     ; 1060 gran(&tsign_cnt,0,60);
4924  0a76 ae003c        	ldw	x,#60
4925  0a79 89            	pushw	x
4926  0a7a 5f            	clrw	x
4927  0a7b 89            	pushw	x
4928  0a7c ae0059        	ldw	x,#_tsign_cnt
4929  0a7f cd00d5        	call	_gran
4931  0a82 5b04          	addw	sp,#4
4932                     ; 1062 if(tsign_cnt>=55)
4934  0a84 9c            	rvf
4935  0a85 be59          	ldw	x,_tsign_cnt
4936  0a87 a30037        	cpw	x,#55
4937  0a8a 2f16          	jrslt	L7232
4938                     ; 1064 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4940  0a8c 3d54          	tnz	_jp_mode
4941  0a8e 2606          	jrne	L5332
4943  0a90 b605          	ld	a,_flags
4944  0a92 a540          	bcp	a,#64
4945  0a94 2706          	jreq	L3332
4946  0a96               L5332:
4948  0a96 b654          	ld	a,_jp_mode
4949  0a98 a103          	cp	a,#3
4950  0a9a 2612          	jrne	L7332
4951  0a9c               L3332:
4954  0a9c 72140005      	bset	_flags,#2
4955  0aa0 200c          	jra	L7332
4956  0aa2               L7232:
4957                     ; 1066 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
4959  0aa2 9c            	rvf
4960  0aa3 be59          	ldw	x,_tsign_cnt
4961  0aa5 a30006        	cpw	x,#6
4962  0aa8 2e04          	jrsge	L7332
4965  0aaa 72150005      	bres	_flags,#2
4966  0aae               L7332:
4967                     ; 1071 if(T>ee_tmax) tmax_cnt++;
4969  0aae 9c            	rvf
4970  0aaf 5f            	clrw	x
4971  0ab0 b672          	ld	a,_T
4972  0ab2 2a01          	jrpl	L201
4973  0ab4 53            	cplw	x
4974  0ab5               L201:
4975  0ab5 97            	ld	xl,a
4976  0ab6 c30010        	cpw	x,_ee_tmax
4977  0ab9 2d09          	jrsle	L3432
4980  0abb be57          	ldw	x,_tmax_cnt
4981  0abd 1c0001        	addw	x,#1
4982  0ac0 bf57          	ldw	_tmax_cnt,x
4984  0ac2 201d          	jra	L5432
4985  0ac4               L3432:
4986                     ; 1072 else if (T<(ee_tmax-1)) tmax_cnt--;
4988  0ac4 9c            	rvf
4989  0ac5 ce0010        	ldw	x,_ee_tmax
4990  0ac8 5a            	decw	x
4991  0ac9 905f          	clrw	y
4992  0acb b672          	ld	a,_T
4993  0acd 2a02          	jrpl	L401
4994  0acf 9053          	cplw	y
4995  0ad1               L401:
4996  0ad1 9097          	ld	yl,a
4997  0ad3 90bf00        	ldw	c_y,y
4998  0ad6 b300          	cpw	x,c_y
4999  0ad8 2d07          	jrsle	L5432
5002  0ada be57          	ldw	x,_tmax_cnt
5003  0adc 1d0001        	subw	x,#1
5004  0adf bf57          	ldw	_tmax_cnt,x
5005  0ae1               L5432:
5006                     ; 1074 gran(&tmax_cnt,0,60);
5008  0ae1 ae003c        	ldw	x,#60
5009  0ae4 89            	pushw	x
5010  0ae5 5f            	clrw	x
5011  0ae6 89            	pushw	x
5012  0ae7 ae0057        	ldw	x,#_tmax_cnt
5013  0aea cd00d5        	call	_gran
5015  0aed 5b04          	addw	sp,#4
5016                     ; 1076 if(tmax_cnt>=55)
5018  0aef 9c            	rvf
5019  0af0 be57          	ldw	x,_tmax_cnt
5020  0af2 a30037        	cpw	x,#55
5021  0af5 2f16          	jrslt	L1532
5022                     ; 1078 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5024  0af7 3d54          	tnz	_jp_mode
5025  0af9 2606          	jrne	L7532
5027  0afb b605          	ld	a,_flags
5028  0afd a540          	bcp	a,#64
5029  0aff 2706          	jreq	L5532
5030  0b01               L7532:
5032  0b01 b654          	ld	a,_jp_mode
5033  0b03 a103          	cp	a,#3
5034  0b05 2612          	jrne	L1632
5035  0b07               L5532:
5038  0b07 72120005      	bset	_flags,#1
5039  0b0b 200c          	jra	L1632
5040  0b0d               L1532:
5041                     ; 1080 else if (tmax_cnt<=5) flags&=0b11111101;
5043  0b0d 9c            	rvf
5044  0b0e be57          	ldw	x,_tmax_cnt
5045  0b10 a30006        	cpw	x,#6
5046  0b13 2e04          	jrsge	L1632
5049  0b15 72130005      	bres	_flags,#1
5050  0b19               L1632:
5051                     ; 1083 } 
5054  0b19 81            	ret
5086                     ; 1086 void u_drv(void)		//1Hz
5086                     ; 1087 { 
5087                     	switch	.text
5088  0b1a               _u_drv:
5092                     ; 1088 if(jp_mode!=jp3)
5094  0b1a b654          	ld	a,_jp_mode
5095  0b1c a103          	cp	a,#3
5096  0b1e 2774          	jreq	L5732
5097                     ; 1090 	if(Ui>ee_Umax)umax_cnt++;
5099  0b20 9c            	rvf
5100  0b21 ce000c        	ldw	x,_Ui
5101  0b24 c30014        	cpw	x,_ee_Umax
5102  0b27 2d09          	jrsle	L7732
5105  0b29 be70          	ldw	x,_umax_cnt
5106  0b2b 1c0001        	addw	x,#1
5107  0b2e bf70          	ldw	_umax_cnt,x
5109  0b30 2003          	jra	L1042
5110  0b32               L7732:
5111                     ; 1091 	else umax_cnt=0;
5113  0b32 5f            	clrw	x
5114  0b33 bf70          	ldw	_umax_cnt,x
5115  0b35               L1042:
5116                     ; 1092 	gran(&umax_cnt,0,10);
5118  0b35 ae000a        	ldw	x,#10
5119  0b38 89            	pushw	x
5120  0b39 5f            	clrw	x
5121  0b3a 89            	pushw	x
5122  0b3b ae0070        	ldw	x,#_umax_cnt
5123  0b3e cd00d5        	call	_gran
5125  0b41 5b04          	addw	sp,#4
5126                     ; 1093 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5128  0b43 9c            	rvf
5129  0b44 be70          	ldw	x,_umax_cnt
5130  0b46 a3000a        	cpw	x,#10
5131  0b49 2f04          	jrslt	L3042
5134  0b4b 72160005      	bset	_flags,#3
5135  0b4f               L3042:
5136                     ; 1096 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5138  0b4f 9c            	rvf
5139  0b50 ce000c        	ldw	x,_Ui
5140  0b53 c3000e        	cpw	x,_Un
5141  0b56 2e1d          	jrsge	L5042
5143  0b58 9c            	rvf
5144  0b59 ce000e        	ldw	x,_Un
5145  0b5c 72b0000c      	subw	x,_Ui
5146  0b60 c30012        	cpw	x,_ee_dU
5147  0b63 2d10          	jrsle	L5042
5149  0b65 c65005        	ld	a,20485
5150  0b68 a504          	bcp	a,#4
5151  0b6a 2609          	jrne	L5042
5154  0b6c be6e          	ldw	x,_umin_cnt
5155  0b6e 1c0001        	addw	x,#1
5156  0b71 bf6e          	ldw	_umin_cnt,x
5158  0b73 2003          	jra	L7042
5159  0b75               L5042:
5160                     ; 1097 	else umin_cnt=0;
5162  0b75 5f            	clrw	x
5163  0b76 bf6e          	ldw	_umin_cnt,x
5164  0b78               L7042:
5165                     ; 1098 	gran(&umin_cnt,0,10);	
5167  0b78 ae000a        	ldw	x,#10
5168  0b7b 89            	pushw	x
5169  0b7c 5f            	clrw	x
5170  0b7d 89            	pushw	x
5171  0b7e ae006e        	ldw	x,#_umin_cnt
5172  0b81 cd00d5        	call	_gran
5174  0b84 5b04          	addw	sp,#4
5175                     ; 1099 	if(umin_cnt>=10)flags|=0b00010000;	  
5177  0b86 9c            	rvf
5178  0b87 be6e          	ldw	x,_umin_cnt
5179  0b89 a3000a        	cpw	x,#10
5180  0b8c 2f71          	jrslt	L3142
5183  0b8e 72180005      	bset	_flags,#4
5184  0b92 206b          	jra	L3142
5185  0b94               L5732:
5186                     ; 1101 else if(jp_mode==jp3)
5188  0b94 b654          	ld	a,_jp_mode
5189  0b96 a103          	cp	a,#3
5190  0b98 2665          	jrne	L3142
5191                     ; 1103 	if(Ui>700)umax_cnt++;
5193  0b9a 9c            	rvf
5194  0b9b ce000c        	ldw	x,_Ui
5195  0b9e a302bd        	cpw	x,#701
5196  0ba1 2f09          	jrslt	L7142
5199  0ba3 be70          	ldw	x,_umax_cnt
5200  0ba5 1c0001        	addw	x,#1
5201  0ba8 bf70          	ldw	_umax_cnt,x
5203  0baa 2003          	jra	L1242
5204  0bac               L7142:
5205                     ; 1104 	else umax_cnt=0;
5207  0bac 5f            	clrw	x
5208  0bad bf70          	ldw	_umax_cnt,x
5209  0baf               L1242:
5210                     ; 1105 	gran(&umax_cnt,0,10);
5212  0baf ae000a        	ldw	x,#10
5213  0bb2 89            	pushw	x
5214  0bb3 5f            	clrw	x
5215  0bb4 89            	pushw	x
5216  0bb5 ae0070        	ldw	x,#_umax_cnt
5217  0bb8 cd00d5        	call	_gran
5219  0bbb 5b04          	addw	sp,#4
5220                     ; 1106 	if(umax_cnt>=10)flags|=0b00001000;
5222  0bbd 9c            	rvf
5223  0bbe be70          	ldw	x,_umax_cnt
5224  0bc0 a3000a        	cpw	x,#10
5225  0bc3 2f04          	jrslt	L3242
5228  0bc5 72160005      	bset	_flags,#3
5229  0bc9               L3242:
5230                     ; 1109 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5232  0bc9 9c            	rvf
5233  0bca ce000c        	ldw	x,_Ui
5234  0bcd a300c8        	cpw	x,#200
5235  0bd0 2e10          	jrsge	L5242
5237  0bd2 c65005        	ld	a,20485
5238  0bd5 a504          	bcp	a,#4
5239  0bd7 2609          	jrne	L5242
5242  0bd9 be6e          	ldw	x,_umin_cnt
5243  0bdb 1c0001        	addw	x,#1
5244  0bde bf6e          	ldw	_umin_cnt,x
5246  0be0 2003          	jra	L7242
5247  0be2               L5242:
5248                     ; 1110 	else umin_cnt=0;
5250  0be2 5f            	clrw	x
5251  0be3 bf6e          	ldw	_umin_cnt,x
5252  0be5               L7242:
5253                     ; 1111 	gran(&umin_cnt,0,10);	
5255  0be5 ae000a        	ldw	x,#10
5256  0be8 89            	pushw	x
5257  0be9 5f            	clrw	x
5258  0bea 89            	pushw	x
5259  0beb ae006e        	ldw	x,#_umin_cnt
5260  0bee cd00d5        	call	_gran
5262  0bf1 5b04          	addw	sp,#4
5263                     ; 1112 	if(umin_cnt>=10)flags|=0b00010000;	  
5265  0bf3 9c            	rvf
5266  0bf4 be6e          	ldw	x,_umin_cnt
5267  0bf6 a3000a        	cpw	x,#10
5268  0bf9 2f04          	jrslt	L3142
5271  0bfb 72180005      	bset	_flags,#4
5272  0bff               L3142:
5273                     ; 1114 }
5276  0bff 81            	ret
5302                     ; 1139 void apv_start(void)
5302                     ; 1140 {
5303                     	switch	.text
5304  0c00               _apv_start:
5308                     ; 1141 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5310  0c00 3d4f          	tnz	_apv_cnt
5311  0c02 2624          	jrne	L3442
5313  0c04 3d50          	tnz	_apv_cnt+1
5314  0c06 2620          	jrne	L3442
5316  0c08 3d51          	tnz	_apv_cnt+2
5317  0c0a 261c          	jrne	L3442
5319                     	btst	_bAPV
5320  0c11 2515          	jrult	L3442
5321                     ; 1143 	apv_cnt[0]=60;
5323  0c13 353c004f      	mov	_apv_cnt,#60
5324                     ; 1144 	apv_cnt[1]=60;
5326  0c17 353c0050      	mov	_apv_cnt+1,#60
5327                     ; 1145 	apv_cnt[2]=60;
5329  0c1b 353c0051      	mov	_apv_cnt+2,#60
5330                     ; 1146 	apv_cnt_=3600;
5332  0c1f ae0e10        	ldw	x,#3600
5333  0c22 bf4d          	ldw	_apv_cnt_,x
5334                     ; 1147 	bAPV=1;	
5336  0c24 72100002      	bset	_bAPV
5337  0c28               L3442:
5338                     ; 1149 }
5341  0c28 81            	ret
5367                     ; 1152 void apv_stop(void)
5367                     ; 1153 {
5368                     	switch	.text
5369  0c29               _apv_stop:
5373                     ; 1154 apv_cnt[0]=0;
5375  0c29 3f4f          	clr	_apv_cnt
5376                     ; 1155 apv_cnt[1]=0;
5378  0c2b 3f50          	clr	_apv_cnt+1
5379                     ; 1156 apv_cnt[2]=0;
5381  0c2d 3f51          	clr	_apv_cnt+2
5382                     ; 1157 apv_cnt_=0;	
5384  0c2f 5f            	clrw	x
5385  0c30 bf4d          	ldw	_apv_cnt_,x
5386                     ; 1158 bAPV=0;
5388  0c32 72110002      	bres	_bAPV
5389                     ; 1159 }
5392  0c36 81            	ret
5427                     ; 1163 void apv_hndl(void)
5427                     ; 1164 {
5428                     	switch	.text
5429  0c37               _apv_hndl:
5433                     ; 1165 if(apv_cnt[0])
5435  0c37 3d4f          	tnz	_apv_cnt
5436  0c39 271e          	jreq	L5642
5437                     ; 1167 	apv_cnt[0]--;
5439  0c3b 3a4f          	dec	_apv_cnt
5440                     ; 1168 	if(apv_cnt[0]==0)
5442  0c3d 3d4f          	tnz	_apv_cnt
5443  0c3f 265a          	jrne	L1742
5444                     ; 1170 		flags&=0b11100001;
5446  0c41 b605          	ld	a,_flags
5447  0c43 a4e1          	and	a,#225
5448  0c45 b705          	ld	_flags,a
5449                     ; 1171 		tsign_cnt=0;
5451  0c47 5f            	clrw	x
5452  0c48 bf59          	ldw	_tsign_cnt,x
5453                     ; 1172 		tmax_cnt=0;
5455  0c4a 5f            	clrw	x
5456  0c4b bf57          	ldw	_tmax_cnt,x
5457                     ; 1173 		umax_cnt=0;
5459  0c4d 5f            	clrw	x
5460  0c4e bf70          	ldw	_umax_cnt,x
5461                     ; 1174 		umin_cnt=0;
5463  0c50 5f            	clrw	x
5464  0c51 bf6e          	ldw	_umin_cnt,x
5465                     ; 1176 		led_drv_cnt=30;
5467  0c53 351e0016      	mov	_led_drv_cnt,#30
5468  0c57 2042          	jra	L1742
5469  0c59               L5642:
5470                     ; 1179 else if(apv_cnt[1])
5472  0c59 3d50          	tnz	_apv_cnt+1
5473  0c5b 271e          	jreq	L3742
5474                     ; 1181 	apv_cnt[1]--;
5476  0c5d 3a50          	dec	_apv_cnt+1
5477                     ; 1182 	if(apv_cnt[1]==0)
5479  0c5f 3d50          	tnz	_apv_cnt+1
5480  0c61 2638          	jrne	L1742
5481                     ; 1184 		flags&=0b11100001;
5483  0c63 b605          	ld	a,_flags
5484  0c65 a4e1          	and	a,#225
5485  0c67 b705          	ld	_flags,a
5486                     ; 1185 		tsign_cnt=0;
5488  0c69 5f            	clrw	x
5489  0c6a bf59          	ldw	_tsign_cnt,x
5490                     ; 1186 		tmax_cnt=0;
5492  0c6c 5f            	clrw	x
5493  0c6d bf57          	ldw	_tmax_cnt,x
5494                     ; 1187 		umax_cnt=0;
5496  0c6f 5f            	clrw	x
5497  0c70 bf70          	ldw	_umax_cnt,x
5498                     ; 1188 		umin_cnt=0;
5500  0c72 5f            	clrw	x
5501  0c73 bf6e          	ldw	_umin_cnt,x
5502                     ; 1190 		led_drv_cnt=30;
5504  0c75 351e0016      	mov	_led_drv_cnt,#30
5505  0c79 2020          	jra	L1742
5506  0c7b               L3742:
5507                     ; 1193 else if(apv_cnt[2])
5509  0c7b 3d51          	tnz	_apv_cnt+2
5510  0c7d 271c          	jreq	L1742
5511                     ; 1195 	apv_cnt[2]--;
5513  0c7f 3a51          	dec	_apv_cnt+2
5514                     ; 1196 	if(apv_cnt[2]==0)
5516  0c81 3d51          	tnz	_apv_cnt+2
5517  0c83 2616          	jrne	L1742
5518                     ; 1198 		flags&=0b11100001;
5520  0c85 b605          	ld	a,_flags
5521  0c87 a4e1          	and	a,#225
5522  0c89 b705          	ld	_flags,a
5523                     ; 1199 		tsign_cnt=0;
5525  0c8b 5f            	clrw	x
5526  0c8c bf59          	ldw	_tsign_cnt,x
5527                     ; 1200 		tmax_cnt=0;
5529  0c8e 5f            	clrw	x
5530  0c8f bf57          	ldw	_tmax_cnt,x
5531                     ; 1201 		umax_cnt=0;
5533  0c91 5f            	clrw	x
5534  0c92 bf70          	ldw	_umax_cnt,x
5535                     ; 1202 		umin_cnt=0;          
5537  0c94 5f            	clrw	x
5538  0c95 bf6e          	ldw	_umin_cnt,x
5539                     ; 1204 		led_drv_cnt=30;
5541  0c97 351e0016      	mov	_led_drv_cnt,#30
5542  0c9b               L1742:
5543                     ; 1208 if(apv_cnt_)
5545  0c9b be4d          	ldw	x,_apv_cnt_
5546  0c9d 2712          	jreq	L5052
5547                     ; 1210 	apv_cnt_--;
5549  0c9f be4d          	ldw	x,_apv_cnt_
5550  0ca1 1d0001        	subw	x,#1
5551  0ca4 bf4d          	ldw	_apv_cnt_,x
5552                     ; 1211 	if(apv_cnt_==0) 
5554  0ca6 be4d          	ldw	x,_apv_cnt_
5555  0ca8 2607          	jrne	L5052
5556                     ; 1213 		bAPV=0;
5558  0caa 72110002      	bres	_bAPV
5559                     ; 1214 		apv_start();
5561  0cae cd0c00        	call	_apv_start
5563  0cb1               L5052:
5564                     ; 1218 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5566  0cb1 be6e          	ldw	x,_umin_cnt
5567  0cb3 261e          	jrne	L1152
5569  0cb5 be70          	ldw	x,_umax_cnt
5570  0cb7 261a          	jrne	L1152
5572  0cb9 c65005        	ld	a,20485
5573  0cbc a504          	bcp	a,#4
5574  0cbe 2613          	jrne	L1152
5575                     ; 1220 	if(cnt_apv_off<20)
5577  0cc0 b64c          	ld	a,_cnt_apv_off
5578  0cc2 a114          	cp	a,#20
5579  0cc4 240f          	jruge	L7152
5580                     ; 1222 		cnt_apv_off++;
5582  0cc6 3c4c          	inc	_cnt_apv_off
5583                     ; 1223 		if(cnt_apv_off>=20)
5585  0cc8 b64c          	ld	a,_cnt_apv_off
5586  0cca a114          	cp	a,#20
5587  0ccc 2507          	jrult	L7152
5588                     ; 1225 			apv_stop();
5590  0cce cd0c29        	call	_apv_stop
5592  0cd1 2002          	jra	L7152
5593  0cd3               L1152:
5594                     ; 1229 else cnt_apv_off=0;	
5596  0cd3 3f4c          	clr	_cnt_apv_off
5597  0cd5               L7152:
5598                     ; 1231 }
5601  0cd5 81            	ret
5604                     	switch	.ubsct
5605  0000               L1252_flags_old:
5606  0000 00            	ds.b	1
5642                     ; 1234 void flags_drv(void)
5642                     ; 1235 {
5643                     	switch	.text
5644  0cd6               _flags_drv:
5648                     ; 1237 if(jp_mode!=jp3) 
5650  0cd6 b654          	ld	a,_jp_mode
5651  0cd8 a103          	cp	a,#3
5652  0cda 2723          	jreq	L1452
5653                     ; 1239 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5655  0cdc b605          	ld	a,_flags
5656  0cde a508          	bcp	a,#8
5657  0ce0 2706          	jreq	L7452
5659  0ce2 b600          	ld	a,L1252_flags_old
5660  0ce4 a508          	bcp	a,#8
5661  0ce6 270c          	jreq	L5452
5662  0ce8               L7452:
5664  0ce8 b605          	ld	a,_flags
5665  0cea a510          	bcp	a,#16
5666  0cec 2726          	jreq	L3552
5668  0cee b600          	ld	a,L1252_flags_old
5669  0cf0 a510          	bcp	a,#16
5670  0cf2 2620          	jrne	L3552
5671  0cf4               L5452:
5672                     ; 1241     		if(link==OFF)apv_start();
5674  0cf4 b66d          	ld	a,_link
5675  0cf6 a1aa          	cp	a,#170
5676  0cf8 261a          	jrne	L3552
5679  0cfa cd0c00        	call	_apv_start
5681  0cfd 2015          	jra	L3552
5682  0cff               L1452:
5683                     ; 1244 else if(jp_mode==jp3) 
5685  0cff b654          	ld	a,_jp_mode
5686  0d01 a103          	cp	a,#3
5687  0d03 260f          	jrne	L3552
5688                     ; 1246 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5690  0d05 b605          	ld	a,_flags
5691  0d07 a508          	bcp	a,#8
5692  0d09 2709          	jreq	L3552
5694  0d0b b600          	ld	a,L1252_flags_old
5695  0d0d a508          	bcp	a,#8
5696  0d0f 2603          	jrne	L3552
5697                     ; 1248     		apv_start();
5699  0d11 cd0c00        	call	_apv_start
5701  0d14               L3552:
5702                     ; 1251 flags_old=flags;
5704  0d14 450500        	mov	L1252_flags_old,_flags
5705                     ; 1253 } 
5708  0d17 81            	ret
5743                     ; 1390 void adr_drv_v4(char in)
5743                     ; 1391 {
5744                     	switch	.text
5745  0d18               _adr_drv_v4:
5749                     ; 1392 if(adress!=in)adress=in;
5751  0d18 c100f7        	cp	a,_adress
5752  0d1b 2703          	jreq	L7752
5755  0d1d c700f7        	ld	_adress,a
5756  0d20               L7752:
5757                     ; 1393 }
5760  0d20 81            	ret
5789                     ; 1396 void adr_drv_v3(void)
5789                     ; 1397 {
5790                     	switch	.text
5791  0d21               _adr_drv_v3:
5793  0d21 88            	push	a
5794       00000001      OFST:	set	1
5797                     ; 1403 GPIOB->DDR&=~(1<<0);
5799  0d22 72115007      	bres	20487,#0
5800                     ; 1404 GPIOB->CR1&=~(1<<0);
5802  0d26 72115008      	bres	20488,#0
5803                     ; 1405 GPIOB->CR2&=~(1<<0);
5805  0d2a 72115009      	bres	20489,#0
5806                     ; 1406 ADC2->CR2=0x08;
5808  0d2e 35085402      	mov	21506,#8
5809                     ; 1407 ADC2->CR1=0x40;
5811  0d32 35405401      	mov	21505,#64
5812                     ; 1408 ADC2->CSR=0x20+0;
5814  0d36 35205400      	mov	21504,#32
5815                     ; 1409 ADC2->CR1|=1;
5817  0d3a 72105401      	bset	21505,#0
5818                     ; 1410 ADC2->CR1|=1;
5820  0d3e 72105401      	bset	21505,#0
5821                     ; 1411 adr_drv_stat=1;
5823  0d42 35010002      	mov	_adr_drv_stat,#1
5824  0d46               L1162:
5825                     ; 1412 while(adr_drv_stat==1);
5828  0d46 b602          	ld	a,_adr_drv_stat
5829  0d48 a101          	cp	a,#1
5830  0d4a 27fa          	jreq	L1162
5831                     ; 1414 GPIOB->DDR&=~(1<<1);
5833  0d4c 72135007      	bres	20487,#1
5834                     ; 1415 GPIOB->CR1&=~(1<<1);
5836  0d50 72135008      	bres	20488,#1
5837                     ; 1416 GPIOB->CR2&=~(1<<1);
5839  0d54 72135009      	bres	20489,#1
5840                     ; 1417 ADC2->CR2=0x08;
5842  0d58 35085402      	mov	21506,#8
5843                     ; 1418 ADC2->CR1=0x40;
5845  0d5c 35405401      	mov	21505,#64
5846                     ; 1419 ADC2->CSR=0x20+1;
5848  0d60 35215400      	mov	21504,#33
5849                     ; 1420 ADC2->CR1|=1;
5851  0d64 72105401      	bset	21505,#0
5852                     ; 1421 ADC2->CR1|=1;
5854  0d68 72105401      	bset	21505,#0
5855                     ; 1422 adr_drv_stat=3;
5857  0d6c 35030002      	mov	_adr_drv_stat,#3
5858  0d70               L7162:
5859                     ; 1423 while(adr_drv_stat==3);
5862  0d70 b602          	ld	a,_adr_drv_stat
5863  0d72 a103          	cp	a,#3
5864  0d74 27fa          	jreq	L7162
5865                     ; 1425 GPIOE->DDR&=~(1<<6);
5867  0d76 721d5016      	bres	20502,#6
5868                     ; 1426 GPIOE->CR1&=~(1<<6);
5870  0d7a 721d5017      	bres	20503,#6
5871                     ; 1427 GPIOE->CR2&=~(1<<6);
5873  0d7e 721d5018      	bres	20504,#6
5874                     ; 1428 ADC2->CR2=0x08;
5876  0d82 35085402      	mov	21506,#8
5877                     ; 1429 ADC2->CR1=0x40;
5879  0d86 35405401      	mov	21505,#64
5880                     ; 1430 ADC2->CSR=0x20+9;
5882  0d8a 35295400      	mov	21504,#41
5883                     ; 1431 ADC2->CR1|=1;
5885  0d8e 72105401      	bset	21505,#0
5886                     ; 1432 ADC2->CR1|=1;
5888  0d92 72105401      	bset	21505,#0
5889                     ; 1433 adr_drv_stat=5;
5891  0d96 35050002      	mov	_adr_drv_stat,#5
5892  0d9a               L5262:
5893                     ; 1434 while(adr_drv_stat==5);
5896  0d9a b602          	ld	a,_adr_drv_stat
5897  0d9c a105          	cp	a,#5
5898  0d9e 27fa          	jreq	L5262
5899                     ; 1438 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5901  0da0 9c            	rvf
5902  0da1 ce00ff        	ldw	x,_adc_buff_
5903  0da4 a3022a        	cpw	x,#554
5904  0da7 2f0f          	jrslt	L3362
5906  0da9 9c            	rvf
5907  0daa ce00ff        	ldw	x,_adc_buff_
5908  0dad a30253        	cpw	x,#595
5909  0db0 2e06          	jrsge	L3362
5912  0db2 725f00f8      	clr	_adr
5914  0db6 204c          	jra	L5362
5915  0db8               L3362:
5916                     ; 1439 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5918  0db8 9c            	rvf
5919  0db9 ce00ff        	ldw	x,_adc_buff_
5920  0dbc a3036d        	cpw	x,#877
5921  0dbf 2f0f          	jrslt	L7362
5923  0dc1 9c            	rvf
5924  0dc2 ce00ff        	ldw	x,_adc_buff_
5925  0dc5 a30396        	cpw	x,#918
5926  0dc8 2e06          	jrsge	L7362
5929  0dca 350100f8      	mov	_adr,#1
5931  0dce 2034          	jra	L5362
5932  0dd0               L7362:
5933                     ; 1440 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5935  0dd0 9c            	rvf
5936  0dd1 ce00ff        	ldw	x,_adc_buff_
5937  0dd4 a302a3        	cpw	x,#675
5938  0dd7 2f0f          	jrslt	L3462
5940  0dd9 9c            	rvf
5941  0dda ce00ff        	ldw	x,_adc_buff_
5942  0ddd a302cc        	cpw	x,#716
5943  0de0 2e06          	jrsge	L3462
5946  0de2 350200f8      	mov	_adr,#2
5948  0de6 201c          	jra	L5362
5949  0de8               L3462:
5950                     ; 1441 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5952  0de8 9c            	rvf
5953  0de9 ce00ff        	ldw	x,_adc_buff_
5954  0dec a303e3        	cpw	x,#995
5955  0def 2f0f          	jrslt	L7462
5957  0df1 9c            	rvf
5958  0df2 ce00ff        	ldw	x,_adc_buff_
5959  0df5 a3040c        	cpw	x,#1036
5960  0df8 2e06          	jrsge	L7462
5963  0dfa 350300f8      	mov	_adr,#3
5965  0dfe 2004          	jra	L5362
5966  0e00               L7462:
5967                     ; 1442 else adr[0]=5;
5969  0e00 350500f8      	mov	_adr,#5
5970  0e04               L5362:
5971                     ; 1444 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5973  0e04 9c            	rvf
5974  0e05 ce0101        	ldw	x,_adc_buff_+2
5975  0e08 a3022a        	cpw	x,#554
5976  0e0b 2f0f          	jrslt	L3562
5978  0e0d 9c            	rvf
5979  0e0e ce0101        	ldw	x,_adc_buff_+2
5980  0e11 a30253        	cpw	x,#595
5981  0e14 2e06          	jrsge	L3562
5984  0e16 725f00f9      	clr	_adr+1
5986  0e1a 204c          	jra	L5562
5987  0e1c               L3562:
5988                     ; 1445 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
5990  0e1c 9c            	rvf
5991  0e1d ce0101        	ldw	x,_adc_buff_+2
5992  0e20 a3036d        	cpw	x,#877
5993  0e23 2f0f          	jrslt	L7562
5995  0e25 9c            	rvf
5996  0e26 ce0101        	ldw	x,_adc_buff_+2
5997  0e29 a30396        	cpw	x,#918
5998  0e2c 2e06          	jrsge	L7562
6001  0e2e 350100f9      	mov	_adr+1,#1
6003  0e32 2034          	jra	L5562
6004  0e34               L7562:
6005                     ; 1446 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6007  0e34 9c            	rvf
6008  0e35 ce0101        	ldw	x,_adc_buff_+2
6009  0e38 a302a3        	cpw	x,#675
6010  0e3b 2f0f          	jrslt	L3662
6012  0e3d 9c            	rvf
6013  0e3e ce0101        	ldw	x,_adc_buff_+2
6014  0e41 a302cc        	cpw	x,#716
6015  0e44 2e06          	jrsge	L3662
6018  0e46 350200f9      	mov	_adr+1,#2
6020  0e4a 201c          	jra	L5562
6021  0e4c               L3662:
6022                     ; 1447 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6024  0e4c 9c            	rvf
6025  0e4d ce0101        	ldw	x,_adc_buff_+2
6026  0e50 a303e3        	cpw	x,#995
6027  0e53 2f0f          	jrslt	L7662
6029  0e55 9c            	rvf
6030  0e56 ce0101        	ldw	x,_adc_buff_+2
6031  0e59 a3040c        	cpw	x,#1036
6032  0e5c 2e06          	jrsge	L7662
6035  0e5e 350300f9      	mov	_adr+1,#3
6037  0e62 2004          	jra	L5562
6038  0e64               L7662:
6039                     ; 1448 else adr[1]=5;
6041  0e64 350500f9      	mov	_adr+1,#5
6042  0e68               L5562:
6043                     ; 1450 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6045  0e68 9c            	rvf
6046  0e69 ce0111        	ldw	x,_adc_buff_+18
6047  0e6c a3022a        	cpw	x,#554
6048  0e6f 2f0f          	jrslt	L3762
6050  0e71 9c            	rvf
6051  0e72 ce0111        	ldw	x,_adc_buff_+18
6052  0e75 a30253        	cpw	x,#595
6053  0e78 2e06          	jrsge	L3762
6056  0e7a 725f00fa      	clr	_adr+2
6058  0e7e 204c          	jra	L5762
6059  0e80               L3762:
6060                     ; 1451 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6062  0e80 9c            	rvf
6063  0e81 ce0111        	ldw	x,_adc_buff_+18
6064  0e84 a3036d        	cpw	x,#877
6065  0e87 2f0f          	jrslt	L7762
6067  0e89 9c            	rvf
6068  0e8a ce0111        	ldw	x,_adc_buff_+18
6069  0e8d a30396        	cpw	x,#918
6070  0e90 2e06          	jrsge	L7762
6073  0e92 350100fa      	mov	_adr+2,#1
6075  0e96 2034          	jra	L5762
6076  0e98               L7762:
6077                     ; 1452 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6079  0e98 9c            	rvf
6080  0e99 ce0111        	ldw	x,_adc_buff_+18
6081  0e9c a302a3        	cpw	x,#675
6082  0e9f 2f0f          	jrslt	L3072
6084  0ea1 9c            	rvf
6085  0ea2 ce0111        	ldw	x,_adc_buff_+18
6086  0ea5 a302cc        	cpw	x,#716
6087  0ea8 2e06          	jrsge	L3072
6090  0eaa 350200fa      	mov	_adr+2,#2
6092  0eae 201c          	jra	L5762
6093  0eb0               L3072:
6094                     ; 1453 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6096  0eb0 9c            	rvf
6097  0eb1 ce0111        	ldw	x,_adc_buff_+18
6098  0eb4 a303e3        	cpw	x,#995
6099  0eb7 2f0f          	jrslt	L7072
6101  0eb9 9c            	rvf
6102  0eba ce0111        	ldw	x,_adc_buff_+18
6103  0ebd a3040c        	cpw	x,#1036
6104  0ec0 2e06          	jrsge	L7072
6107  0ec2 350300fa      	mov	_adr+2,#3
6109  0ec6 2004          	jra	L5762
6110  0ec8               L7072:
6111                     ; 1454 else adr[2]=5;
6113  0ec8 350500fa      	mov	_adr+2,#5
6114  0ecc               L5762:
6115                     ; 1458 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6117  0ecc c600f8        	ld	a,_adr
6118  0ecf a105          	cp	a,#5
6119  0ed1 270e          	jreq	L5172
6121  0ed3 c600f9        	ld	a,_adr+1
6122  0ed6 a105          	cp	a,#5
6123  0ed8 2707          	jreq	L5172
6125  0eda c600fa        	ld	a,_adr+2
6126  0edd a105          	cp	a,#5
6127  0edf 2606          	jrne	L3172
6128  0ee1               L5172:
6129                     ; 1461 	adress_error=1;
6131  0ee1 350100f6      	mov	_adress_error,#1
6133  0ee5               L1272:
6134                     ; 1472 }
6137  0ee5 84            	pop	a
6138  0ee6 81            	ret
6139  0ee7               L3172:
6140                     ; 1465 	if(adr[2]&0x02) bps_class=bpsIPS;
6142  0ee7 c600fa        	ld	a,_adr+2
6143  0eea a502          	bcp	a,#2
6144  0eec 2706          	jreq	L3272
6147  0eee 3501000b      	mov	_bps_class,#1
6149  0ef2 2002          	jra	L5272
6150  0ef4               L3272:
6151                     ; 1466 	else bps_class=bpsIBEP;
6153  0ef4 3f0b          	clr	_bps_class
6154  0ef6               L5272:
6155                     ; 1468 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6157  0ef6 c600fa        	ld	a,_adr+2
6158  0ef9 a401          	and	a,#1
6159  0efb 97            	ld	xl,a
6160  0efc a610          	ld	a,#16
6161  0efe 42            	mul	x,a
6162  0eff 9f            	ld	a,xl
6163  0f00 6b01          	ld	(OFST+0,sp),a
6164  0f02 c600f9        	ld	a,_adr+1
6165  0f05 48            	sll	a
6166  0f06 48            	sll	a
6167  0f07 cb00f8        	add	a,_adr
6168  0f0a 1b01          	add	a,(OFST+0,sp)
6169  0f0c c700f7        	ld	_adress,a
6170  0f0f 20d4          	jra	L1272
6193                     ; 1522 void init_CAN(void) {
6194                     	switch	.text
6195  0f11               _init_CAN:
6199                     ; 1523 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6201  0f11 72135420      	bres	21536,#1
6202                     ; 1524 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6204  0f15 72105420      	bset	21536,#0
6206  0f19               L1472:
6207                     ; 1525 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6209  0f19 c65421        	ld	a,21537
6210  0f1c a501          	bcp	a,#1
6211  0f1e 27f9          	jreq	L1472
6212                     ; 1527 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6214  0f20 72185420      	bset	21536,#4
6215                     ; 1529 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6217  0f24 35025427      	mov	21543,#2
6218                     ; 1538 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6220  0f28 35135428      	mov	21544,#19
6221                     ; 1539 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6223  0f2c 35c05429      	mov	21545,#192
6224                     ; 1540 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6226  0f30 357f542c      	mov	21548,#127
6227                     ; 1541 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6229  0f34 35e0542d      	mov	21549,#224
6230                     ; 1543 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6232  0f38 35315430      	mov	21552,#49
6233                     ; 1544 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6235  0f3c 35c05431      	mov	21553,#192
6236                     ; 1545 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6238  0f40 357f5434      	mov	21556,#127
6239                     ; 1546 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6241  0f44 35e05435      	mov	21557,#224
6242                     ; 1550 	CAN->PSR= 6;									// set page 6
6244  0f48 35065427      	mov	21543,#6
6245                     ; 1555 	CAN->Page.Config.FMR1&=~3;								//mask mode
6247  0f4c c65430        	ld	a,21552
6248  0f4f a4fc          	and	a,#252
6249  0f51 c75430        	ld	21552,a
6250                     ; 1561 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6252  0f54 35065432      	mov	21554,#6
6253                     ; 1562 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6255  0f58 35605432      	mov	21554,#96
6256                     ; 1565 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6258  0f5c 72105432      	bset	21554,#0
6259                     ; 1566 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6261  0f60 72185432      	bset	21554,#4
6262                     ; 1569 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6264  0f64 35065427      	mov	21543,#6
6265                     ; 1571 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6267  0f68 35d3542c      	mov	21548,#211
6268                     ; 1572 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6270  0f6c 35e7542d      	mov	21549,#231
6271                     ; 1574 	CAN->IER|=(1<<1);
6273  0f70 72125425      	bset	21541,#1
6274                     ; 1577 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6276  0f74 72115420      	bres	21536,#0
6278  0f78               L7472:
6279                     ; 1578 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6281  0f78 c65421        	ld	a,21537
6282  0f7b a501          	bcp	a,#1
6283  0f7d 26f9          	jrne	L7472
6284                     ; 1579 }
6287  0f7f 81            	ret
6395                     ; 1582 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6395                     ; 1583 {
6396                     	switch	.text
6397  0f80               _can_transmit:
6399  0f80 89            	pushw	x
6400       00000000      OFST:	set	0
6403                     ; 1585 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6405  0f81 b676          	ld	a,_can_buff_wr_ptr
6406  0f83 a104          	cp	a,#4
6407  0f85 2502          	jrult	L1303
6410  0f87 3f76          	clr	_can_buff_wr_ptr
6411  0f89               L1303:
6412                     ; 1587 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6414  0f89 b676          	ld	a,_can_buff_wr_ptr
6415  0f8b 97            	ld	xl,a
6416  0f8c a610          	ld	a,#16
6417  0f8e 42            	mul	x,a
6418  0f8f 1601          	ldw	y,(OFST+1,sp)
6419  0f91 a606          	ld	a,#6
6420  0f93               L031:
6421  0f93 9054          	srlw	y
6422  0f95 4a            	dec	a
6423  0f96 26fb          	jrne	L031
6424  0f98 909f          	ld	a,yl
6425  0f9a e777          	ld	(_can_out_buff,x),a
6426                     ; 1588 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6428  0f9c b676          	ld	a,_can_buff_wr_ptr
6429  0f9e 97            	ld	xl,a
6430  0f9f a610          	ld	a,#16
6431  0fa1 42            	mul	x,a
6432  0fa2 7b02          	ld	a,(OFST+2,sp)
6433  0fa4 48            	sll	a
6434  0fa5 48            	sll	a
6435  0fa6 e778          	ld	(_can_out_buff+1,x),a
6436                     ; 1590 can_out_buff[can_buff_wr_ptr][2]=data0;
6438  0fa8 b676          	ld	a,_can_buff_wr_ptr
6439  0faa 97            	ld	xl,a
6440  0fab a610          	ld	a,#16
6441  0fad 42            	mul	x,a
6442  0fae 7b05          	ld	a,(OFST+5,sp)
6443  0fb0 e779          	ld	(_can_out_buff+2,x),a
6444                     ; 1591 can_out_buff[can_buff_wr_ptr][3]=data1;
6446  0fb2 b676          	ld	a,_can_buff_wr_ptr
6447  0fb4 97            	ld	xl,a
6448  0fb5 a610          	ld	a,#16
6449  0fb7 42            	mul	x,a
6450  0fb8 7b06          	ld	a,(OFST+6,sp)
6451  0fba e77a          	ld	(_can_out_buff+3,x),a
6452                     ; 1592 can_out_buff[can_buff_wr_ptr][4]=data2;
6454  0fbc b676          	ld	a,_can_buff_wr_ptr
6455  0fbe 97            	ld	xl,a
6456  0fbf a610          	ld	a,#16
6457  0fc1 42            	mul	x,a
6458  0fc2 7b07          	ld	a,(OFST+7,sp)
6459  0fc4 e77b          	ld	(_can_out_buff+4,x),a
6460                     ; 1593 can_out_buff[can_buff_wr_ptr][5]=data3;
6462  0fc6 b676          	ld	a,_can_buff_wr_ptr
6463  0fc8 97            	ld	xl,a
6464  0fc9 a610          	ld	a,#16
6465  0fcb 42            	mul	x,a
6466  0fcc 7b08          	ld	a,(OFST+8,sp)
6467  0fce e77c          	ld	(_can_out_buff+5,x),a
6468                     ; 1594 can_out_buff[can_buff_wr_ptr][6]=data4;
6470  0fd0 b676          	ld	a,_can_buff_wr_ptr
6471  0fd2 97            	ld	xl,a
6472  0fd3 a610          	ld	a,#16
6473  0fd5 42            	mul	x,a
6474  0fd6 7b09          	ld	a,(OFST+9,sp)
6475  0fd8 e77d          	ld	(_can_out_buff+6,x),a
6476                     ; 1595 can_out_buff[can_buff_wr_ptr][7]=data5;
6478  0fda b676          	ld	a,_can_buff_wr_ptr
6479  0fdc 97            	ld	xl,a
6480  0fdd a610          	ld	a,#16
6481  0fdf 42            	mul	x,a
6482  0fe0 7b0a          	ld	a,(OFST+10,sp)
6483  0fe2 e77e          	ld	(_can_out_buff+7,x),a
6484                     ; 1596 can_out_buff[can_buff_wr_ptr][8]=data6;
6486  0fe4 b676          	ld	a,_can_buff_wr_ptr
6487  0fe6 97            	ld	xl,a
6488  0fe7 a610          	ld	a,#16
6489  0fe9 42            	mul	x,a
6490  0fea 7b0b          	ld	a,(OFST+11,sp)
6491  0fec e77f          	ld	(_can_out_buff+8,x),a
6492                     ; 1597 can_out_buff[can_buff_wr_ptr][9]=data7;
6494  0fee b676          	ld	a,_can_buff_wr_ptr
6495  0ff0 97            	ld	xl,a
6496  0ff1 a610          	ld	a,#16
6497  0ff3 42            	mul	x,a
6498  0ff4 7b0c          	ld	a,(OFST+12,sp)
6499  0ff6 e780          	ld	(_can_out_buff+9,x),a
6500                     ; 1599 can_buff_wr_ptr++;
6502  0ff8 3c76          	inc	_can_buff_wr_ptr
6503                     ; 1600 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6505  0ffa b676          	ld	a,_can_buff_wr_ptr
6506  0ffc a104          	cp	a,#4
6507  0ffe 2502          	jrult	L3303
6510  1000 3f76          	clr	_can_buff_wr_ptr
6511  1002               L3303:
6512                     ; 1601 } 
6515  1002 85            	popw	x
6516  1003 81            	ret
6545                     ; 1604 void can_tx_hndl(void)
6545                     ; 1605 {
6546                     	switch	.text
6547  1004               _can_tx_hndl:
6551                     ; 1606 if(bTX_FREE)
6553  1004 3d03          	tnz	_bTX_FREE
6554  1006 2757          	jreq	L5403
6555                     ; 1608 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6557  1008 b675          	ld	a,_can_buff_rd_ptr
6558  100a b176          	cp	a,_can_buff_wr_ptr
6559  100c 275f          	jreq	L3503
6560                     ; 1610 		bTX_FREE=0;
6562  100e 3f03          	clr	_bTX_FREE
6563                     ; 1612 		CAN->PSR= 0;
6565  1010 725f5427      	clr	21543
6566                     ; 1613 		CAN->Page.TxMailbox.MDLCR=8;
6568  1014 35085429      	mov	21545,#8
6569                     ; 1614 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6571  1018 b675          	ld	a,_can_buff_rd_ptr
6572  101a 97            	ld	xl,a
6573  101b a610          	ld	a,#16
6574  101d 42            	mul	x,a
6575  101e e677          	ld	a,(_can_out_buff,x)
6576  1020 c7542a        	ld	21546,a
6577                     ; 1615 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6579  1023 b675          	ld	a,_can_buff_rd_ptr
6580  1025 97            	ld	xl,a
6581  1026 a610          	ld	a,#16
6582  1028 42            	mul	x,a
6583  1029 e678          	ld	a,(_can_out_buff+1,x)
6584  102b c7542b        	ld	21547,a
6585                     ; 1617 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6587  102e b675          	ld	a,_can_buff_rd_ptr
6588  1030 97            	ld	xl,a
6589  1031 a610          	ld	a,#16
6590  1033 42            	mul	x,a
6591  1034 01            	rrwa	x,a
6592  1035 ab79          	add	a,#_can_out_buff+2
6593  1037 2401          	jrnc	L431
6594  1039 5c            	incw	x
6595  103a               L431:
6596  103a 5f            	clrw	x
6597  103b 97            	ld	xl,a
6598  103c bf00          	ldw	c_x,x
6599  103e ae0008        	ldw	x,#8
6600  1041               L631:
6601  1041 5a            	decw	x
6602  1042 92d600        	ld	a,([c_x],x)
6603  1045 d7542e        	ld	(21550,x),a
6604  1048 5d            	tnzw	x
6605  1049 26f6          	jrne	L631
6606                     ; 1619 		can_buff_rd_ptr++;
6608  104b 3c75          	inc	_can_buff_rd_ptr
6609                     ; 1620 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6611  104d b675          	ld	a,_can_buff_rd_ptr
6612  104f a104          	cp	a,#4
6613  1051 2502          	jrult	L1503
6616  1053 3f75          	clr	_can_buff_rd_ptr
6617  1055               L1503:
6618                     ; 1622 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6620  1055 72105428      	bset	21544,#0
6621                     ; 1623 		CAN->IER|=(1<<0);
6623  1059 72105425      	bset	21541,#0
6624  105d 200e          	jra	L3503
6625  105f               L5403:
6626                     ; 1628 	tx_busy_cnt++;
6628  105f 3c74          	inc	_tx_busy_cnt
6629                     ; 1629 	if(tx_busy_cnt>=100)
6631  1061 b674          	ld	a,_tx_busy_cnt
6632  1063 a164          	cp	a,#100
6633  1065 2506          	jrult	L3503
6634                     ; 1631 		tx_busy_cnt=0;
6636  1067 3f74          	clr	_tx_busy_cnt
6637                     ; 1632 		bTX_FREE=1;
6639  1069 35010003      	mov	_bTX_FREE,#1
6640  106d               L3503:
6641                     ; 1635 }
6644  106d 81            	ret
6759                     ; 1661 void can_in_an(void)
6759                     ; 1662 {
6760                     	switch	.text
6761  106e               _can_in_an:
6763  106e 5207          	subw	sp,#7
6764       00000007      OFST:	set	7
6767                     ; 1672 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6769  1070 b6cd          	ld	a,_mess+6
6770  1072 c100f7        	cp	a,_adress
6771  1075 2703          	jreq	L651
6772  1077 cc11af        	jp	L3113
6773  107a               L651:
6775  107a b6ce          	ld	a,_mess+7
6776  107c c100f7        	cp	a,_adress
6777  107f 2703          	jreq	L061
6778  1081 cc11af        	jp	L3113
6779  1084               L061:
6781  1084 b6cf          	ld	a,_mess+8
6782  1086 a1ed          	cp	a,#237
6783  1088 2703          	jreq	L261
6784  108a cc11af        	jp	L3113
6785  108d               L261:
6786                     ; 1675 	can_error_cnt=0;
6788  108d 3f73          	clr	_can_error_cnt
6789                     ; 1677 	bMAIN=0;
6791  108f 72110001      	bres	_bMAIN
6792                     ; 1678  	flags_tu=mess[9];
6794  1093 45d06a        	mov	_flags_tu,_mess+9
6795                     ; 1679  	if(flags_tu&0b00000001)
6797  1096 b66a          	ld	a,_flags_tu
6798  1098 a501          	bcp	a,#1
6799  109a 2706          	jreq	L5113
6800                     ; 1684  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6802  109c 721a0005      	bset	_flags,#5
6804  10a0 2008          	jra	L7113
6805  10a2               L5113:
6806                     ; 1695  				flags&=0b11011111; 
6808  10a2 721b0005      	bres	_flags,#5
6809                     ; 1696  				off_bp_cnt=5*EE_TZAS;
6811  10a6 350f005d      	mov	_off_bp_cnt,#15
6812  10aa               L7113:
6813                     ; 1702  	if(flags_tu&0b00000010) flags|=0b01000000;
6815  10aa b66a          	ld	a,_flags_tu
6816  10ac a502          	bcp	a,#2
6817  10ae 2706          	jreq	L1213
6820  10b0 721c0005      	bset	_flags,#6
6822  10b4 2004          	jra	L3213
6823  10b6               L1213:
6824                     ; 1703  	else flags&=0b10111111; 
6826  10b6 721d0005      	bres	_flags,#6
6827  10ba               L3213:
6828                     ; 1705  	U_out_const=mess[10]+mess[11]*256;
6830  10ba b6d2          	ld	a,_mess+11
6831  10bc 5f            	clrw	x
6832  10bd 97            	ld	xl,a
6833  10be 4f            	clr	a
6834  10bf 02            	rlwa	x,a
6835  10c0 01            	rrwa	x,a
6836  10c1 bbd1          	add	a,_mess+10
6837  10c3 2401          	jrnc	L241
6838  10c5 5c            	incw	x
6839  10c6               L241:
6840  10c6 c70009        	ld	_U_out_const+1,a
6841  10c9 9f            	ld	a,xl
6842  10ca c70008        	ld	_U_out_const,a
6843                     ; 1706  	vol_i_temp=mess[12]+mess[13]*256;  
6845  10cd b6d4          	ld	a,_mess+13
6846  10cf 5f            	clrw	x
6847  10d0 97            	ld	xl,a
6848  10d1 4f            	clr	a
6849  10d2 02            	rlwa	x,a
6850  10d3 01            	rrwa	x,a
6851  10d4 bbd3          	add	a,_mess+12
6852  10d6 2401          	jrnc	L441
6853  10d8 5c            	incw	x
6854  10d9               L441:
6855  10d9 b761          	ld	_vol_i_temp+1,a
6856  10db 9f            	ld	a,xl
6857  10dc b760          	ld	_vol_i_temp,a
6858                     ; 1716 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6860  10de b608          	ld	a,_vent_resurs_tx_cnt
6861  10e0 a102          	cp	a,#2
6862  10e2 2507          	jrult	L5213
6865  10e4 ce0000        	ldw	x,_vent_resurs
6866  10e7 bf41          	ldw	_plazma_int+4,x
6868  10e9 2004          	jra	L7213
6869  10eb               L5213:
6870                     ; 1717 	else plazma_int[2]=vent_resurs_sec_cnt;
6872  10eb be09          	ldw	x,_vent_resurs_sec_cnt
6873  10ed bf41          	ldw	_plazma_int+4,x
6874  10ef               L7213:
6875                     ; 1718  	rotor_int=flags_tu+(((short)flags)<<8);
6877  10ef b605          	ld	a,_flags
6878  10f1 5f            	clrw	x
6879  10f2 97            	ld	xl,a
6880  10f3 4f            	clr	a
6881  10f4 02            	rlwa	x,a
6882  10f5 01            	rrwa	x,a
6883  10f6 bb6a          	add	a,_flags_tu
6884  10f8 2401          	jrnc	L641
6885  10fa 5c            	incw	x
6886  10fb               L641:
6887  10fb b718          	ld	_rotor_int+1,a
6888  10fd 9f            	ld	a,xl
6889  10fe b717          	ld	_rotor_int,a
6890                     ; 1719 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6892  1100 3b000c        	push	_Ui
6893  1103 3b000d        	push	_Ui+1
6894  1106 3b000e        	push	_Un
6895  1109 3b000f        	push	_Un+1
6896  110c 3b0010        	push	_I
6897  110f 3b0011        	push	_I+1
6898  1112 4bda          	push	#218
6899  1114 3b00f7        	push	_adress
6900  1117 ae018e        	ldw	x,#398
6901  111a cd0f80        	call	_can_transmit
6903  111d 5b08          	addw	sp,#8
6904                     ; 1720 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6906  111f 3b0006        	push	_Usum
6907  1122 3b0007        	push	_Usum+1
6908  1125 3b0069        	push	__x_+1
6909  1128 3b0005        	push	_flags
6910  112b b608          	ld	a,_vent_resurs_tx_cnt
6911  112d 5f            	clrw	x
6912  112e 97            	ld	xl,a
6913  112f d60000        	ld	a,(_vent_resurs_buff,x)
6914  1132 88            	push	a
6915  1133 3b0072        	push	_T
6916  1136 4bdb          	push	#219
6917  1138 3b00f7        	push	_adress
6918  113b ae018e        	ldw	x,#398
6919  113e cd0f80        	call	_can_transmit
6921  1141 5b08          	addw	sp,#8
6922                     ; 1721 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6924  1143 3b0005        	push	_debug_info_to_uku+4
6925  1146 3b0006        	push	_debug_info_to_uku+5
6926  1149 3b0003        	push	_debug_info_to_uku+2
6927  114c 3b0004        	push	_debug_info_to_uku+3
6928  114f 3b0001        	push	_debug_info_to_uku
6929  1152 3b0002        	push	_debug_info_to_uku+1
6930  1155 4bdc          	push	#220
6931  1157 3b00f7        	push	_adress
6932  115a ae018e        	ldw	x,#398
6933  115d cd0f80        	call	_can_transmit
6935  1160 5b08          	addw	sp,#8
6936                     ; 1722      link_cnt=0;
6938  1162 5f            	clrw	x
6939  1163 bf6b          	ldw	_link_cnt,x
6940                     ; 1723      link=ON;
6942  1165 3555006d      	mov	_link,#85
6943                     ; 1725      if(flags_tu&0b10000000)
6945  1169 b66a          	ld	a,_flags_tu
6946  116b a580          	bcp	a,#128
6947  116d 2716          	jreq	L1313
6948                     ; 1727      	if(!res_fl)
6950  116f 725d000b      	tnz	_res_fl
6951  1173 2626          	jrne	L5313
6952                     ; 1729      		res_fl=1;
6954  1175 a601          	ld	a,#1
6955  1177 ae000b        	ldw	x,#_res_fl
6956  117a cd0000        	call	c_eewrc
6958                     ; 1730      		bRES=1;
6960  117d 3501000c      	mov	_bRES,#1
6961                     ; 1731      		res_fl_cnt=0;
6963  1181 3f4b          	clr	_res_fl_cnt
6964  1183 2016          	jra	L5313
6965  1185               L1313:
6966                     ; 1736      	if(main_cnt>20)
6968  1185 9c            	rvf
6969  1186 ce0255        	ldw	x,_main_cnt
6970  1189 a30015        	cpw	x,#21
6971  118c 2f0d          	jrslt	L5313
6972                     ; 1738     			if(res_fl)
6974  118e 725d000b      	tnz	_res_fl
6975  1192 2707          	jreq	L5313
6976                     ; 1740      			res_fl=0;
6978  1194 4f            	clr	a
6979  1195 ae000b        	ldw	x,#_res_fl
6980  1198 cd0000        	call	c_eewrc
6982  119b               L5313:
6983                     ; 1745       if(res_fl_)
6985  119b 725d000a      	tnz	_res_fl_
6986  119f 2603          	jrne	L461
6987  11a1 cc1716        	jp	L7503
6988  11a4               L461:
6989                     ; 1747       	res_fl_=0;
6991  11a4 4f            	clr	a
6992  11a5 ae000a        	ldw	x,#_res_fl_
6993  11a8 cd0000        	call	c_eewrc
6995  11ab ac161716      	jpf	L7503
6996  11af               L3113:
6997                     ; 1750 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
6999  11af b6cd          	ld	a,_mess+6
7000  11b1 c100f7        	cp	a,_adress
7001  11b4 2703          	jreq	L661
7002  11b6 cc142c        	jp	L7413
7003  11b9               L661:
7005  11b9 b6ce          	ld	a,_mess+7
7006  11bb c100f7        	cp	a,_adress
7007  11be 2703          	jreq	L071
7008  11c0 cc142c        	jp	L7413
7009  11c3               L071:
7011  11c3 b6cf          	ld	a,_mess+8
7012  11c5 a1ee          	cp	a,#238
7013  11c7 2703          	jreq	L271
7014  11c9 cc142c        	jp	L7413
7015  11cc               L271:
7017  11cc b6d0          	ld	a,_mess+9
7018  11ce b1d1          	cp	a,_mess+10
7019  11d0 2703          	jreq	L471
7020  11d2 cc142c        	jp	L7413
7021  11d5               L471:
7022                     ; 1752 	rotor_int++;
7024  11d5 be17          	ldw	x,_rotor_int
7025  11d7 1c0001        	addw	x,#1
7026  11da bf17          	ldw	_rotor_int,x
7027                     ; 1753 	if((mess[9]&0xf0)==0x20)
7029  11dc b6d0          	ld	a,_mess+9
7030  11de a4f0          	and	a,#240
7031  11e0 a120          	cp	a,#32
7032  11e2 2673          	jrne	L1513
7033                     ; 1755 		if((mess[9]&0x0f)==0x01)
7035  11e4 b6d0          	ld	a,_mess+9
7036  11e6 a40f          	and	a,#15
7037  11e8 a101          	cp	a,#1
7038  11ea 260d          	jrne	L3513
7039                     ; 1757 			ee_K[0][0]=adc_buff_[4];
7041  11ec ce0107        	ldw	x,_adc_buff_+8
7042  11ef 89            	pushw	x
7043  11f0 ae001a        	ldw	x,#_ee_K
7044  11f3 cd0000        	call	c_eewrw
7046  11f6 85            	popw	x
7048  11f7 204a          	jra	L5513
7049  11f9               L3513:
7050                     ; 1759 		else if((mess[9]&0x0f)==0x02)
7052  11f9 b6d0          	ld	a,_mess+9
7053  11fb a40f          	and	a,#15
7054  11fd a102          	cp	a,#2
7055  11ff 260b          	jrne	L7513
7056                     ; 1761 			ee_K[0][1]++;
7058  1201 ce001c        	ldw	x,_ee_K+2
7059  1204 1c0001        	addw	x,#1
7060  1207 cf001c        	ldw	_ee_K+2,x
7062  120a 2037          	jra	L5513
7063  120c               L7513:
7064                     ; 1763 		else if((mess[9]&0x0f)==0x03)
7066  120c b6d0          	ld	a,_mess+9
7067  120e a40f          	and	a,#15
7068  1210 a103          	cp	a,#3
7069  1212 260b          	jrne	L3613
7070                     ; 1765 			ee_K[0][1]+=10;
7072  1214 ce001c        	ldw	x,_ee_K+2
7073  1217 1c000a        	addw	x,#10
7074  121a cf001c        	ldw	_ee_K+2,x
7076  121d 2024          	jra	L5513
7077  121f               L3613:
7078                     ; 1767 		else if((mess[9]&0x0f)==0x04)
7080  121f b6d0          	ld	a,_mess+9
7081  1221 a40f          	and	a,#15
7082  1223 a104          	cp	a,#4
7083  1225 260b          	jrne	L7613
7084                     ; 1769 			ee_K[0][1]--;
7086  1227 ce001c        	ldw	x,_ee_K+2
7087  122a 1d0001        	subw	x,#1
7088  122d cf001c        	ldw	_ee_K+2,x
7090  1230 2011          	jra	L5513
7091  1232               L7613:
7092                     ; 1771 		else if((mess[9]&0x0f)==0x05)
7094  1232 b6d0          	ld	a,_mess+9
7095  1234 a40f          	and	a,#15
7096  1236 a105          	cp	a,#5
7097  1238 2609          	jrne	L5513
7098                     ; 1773 			ee_K[0][1]-=10;
7100  123a ce001c        	ldw	x,_ee_K+2
7101  123d 1d000a        	subw	x,#10
7102  1240 cf001c        	ldw	_ee_K+2,x
7103  1243               L5513:
7104                     ; 1775 		granee(&ee_K[0][1],50,3000);									
7106  1243 ae0bb8        	ldw	x,#3000
7107  1246 89            	pushw	x
7108  1247 ae0032        	ldw	x,#50
7109  124a 89            	pushw	x
7110  124b ae001c        	ldw	x,#_ee_K+2
7111  124e cd00f6        	call	_granee
7113  1251 5b04          	addw	sp,#4
7115  1253 ac111411      	jpf	L5713
7116  1257               L1513:
7117                     ; 1777 	else if((mess[9]&0xf0)==0x10)
7119  1257 b6d0          	ld	a,_mess+9
7120  1259 a4f0          	and	a,#240
7121  125b a110          	cp	a,#16
7122  125d 2673          	jrne	L7713
7123                     ; 1779 		if((mess[9]&0x0f)==0x01)
7125  125f b6d0          	ld	a,_mess+9
7126  1261 a40f          	and	a,#15
7127  1263 a101          	cp	a,#1
7128  1265 260d          	jrne	L1023
7129                     ; 1781 			ee_K[1][0]=adc_buff_[1];
7131  1267 ce0101        	ldw	x,_adc_buff_+2
7132  126a 89            	pushw	x
7133  126b ae001e        	ldw	x,#_ee_K+4
7134  126e cd0000        	call	c_eewrw
7136  1271 85            	popw	x
7138  1272 204a          	jra	L3023
7139  1274               L1023:
7140                     ; 1783 		else if((mess[9]&0x0f)==0x02)
7142  1274 b6d0          	ld	a,_mess+9
7143  1276 a40f          	and	a,#15
7144  1278 a102          	cp	a,#2
7145  127a 260b          	jrne	L5023
7146                     ; 1785 			ee_K[1][1]++;
7148  127c ce0020        	ldw	x,_ee_K+6
7149  127f 1c0001        	addw	x,#1
7150  1282 cf0020        	ldw	_ee_K+6,x
7152  1285 2037          	jra	L3023
7153  1287               L5023:
7154                     ; 1787 		else if((mess[9]&0x0f)==0x03)
7156  1287 b6d0          	ld	a,_mess+9
7157  1289 a40f          	and	a,#15
7158  128b a103          	cp	a,#3
7159  128d 260b          	jrne	L1123
7160                     ; 1789 			ee_K[1][1]+=10;
7162  128f ce0020        	ldw	x,_ee_K+6
7163  1292 1c000a        	addw	x,#10
7164  1295 cf0020        	ldw	_ee_K+6,x
7166  1298 2024          	jra	L3023
7167  129a               L1123:
7168                     ; 1791 		else if((mess[9]&0x0f)==0x04)
7170  129a b6d0          	ld	a,_mess+9
7171  129c a40f          	and	a,#15
7172  129e a104          	cp	a,#4
7173  12a0 260b          	jrne	L5123
7174                     ; 1793 			ee_K[1][1]--;
7176  12a2 ce0020        	ldw	x,_ee_K+6
7177  12a5 1d0001        	subw	x,#1
7178  12a8 cf0020        	ldw	_ee_K+6,x
7180  12ab 2011          	jra	L3023
7181  12ad               L5123:
7182                     ; 1795 		else if((mess[9]&0x0f)==0x05)
7184  12ad b6d0          	ld	a,_mess+9
7185  12af a40f          	and	a,#15
7186  12b1 a105          	cp	a,#5
7187  12b3 2609          	jrne	L3023
7188                     ; 1797 			ee_K[1][1]-=10;
7190  12b5 ce0020        	ldw	x,_ee_K+6
7191  12b8 1d000a        	subw	x,#10
7192  12bb cf0020        	ldw	_ee_K+6,x
7193  12be               L3023:
7194                     ; 1802 		granee(&ee_K[1][1],10,30000);
7196  12be ae7530        	ldw	x,#30000
7197  12c1 89            	pushw	x
7198  12c2 ae000a        	ldw	x,#10
7199  12c5 89            	pushw	x
7200  12c6 ae0020        	ldw	x,#_ee_K+6
7201  12c9 cd00f6        	call	_granee
7203  12cc 5b04          	addw	sp,#4
7205  12ce ac111411      	jpf	L5713
7206  12d2               L7713:
7207                     ; 1806 	else if((mess[9]&0xf0)==0x00)
7209  12d2 b6d0          	ld	a,_mess+9
7210  12d4 a5f0          	bcp	a,#240
7211  12d6 2673          	jrne	L5223
7212                     ; 1808 		if((mess[9]&0x0f)==0x01)
7214  12d8 b6d0          	ld	a,_mess+9
7215  12da a40f          	and	a,#15
7216  12dc a101          	cp	a,#1
7217  12de 260d          	jrne	L7223
7218                     ; 1810 			ee_K[2][0]=adc_buff_[2];
7220  12e0 ce0103        	ldw	x,_adc_buff_+4
7221  12e3 89            	pushw	x
7222  12e4 ae0022        	ldw	x,#_ee_K+8
7223  12e7 cd0000        	call	c_eewrw
7225  12ea 85            	popw	x
7227  12eb 204a          	jra	L1323
7228  12ed               L7223:
7229                     ; 1812 		else if((mess[9]&0x0f)==0x02)
7231  12ed b6d0          	ld	a,_mess+9
7232  12ef a40f          	and	a,#15
7233  12f1 a102          	cp	a,#2
7234  12f3 260b          	jrne	L3323
7235                     ; 1814 			ee_K[2][1]++;
7237  12f5 ce0024        	ldw	x,_ee_K+10
7238  12f8 1c0001        	addw	x,#1
7239  12fb cf0024        	ldw	_ee_K+10,x
7241  12fe 2037          	jra	L1323
7242  1300               L3323:
7243                     ; 1816 		else if((mess[9]&0x0f)==0x03)
7245  1300 b6d0          	ld	a,_mess+9
7246  1302 a40f          	and	a,#15
7247  1304 a103          	cp	a,#3
7248  1306 260b          	jrne	L7323
7249                     ; 1818 			ee_K[2][1]+=10;
7251  1308 ce0024        	ldw	x,_ee_K+10
7252  130b 1c000a        	addw	x,#10
7253  130e cf0024        	ldw	_ee_K+10,x
7255  1311 2024          	jra	L1323
7256  1313               L7323:
7257                     ; 1820 		else if((mess[9]&0x0f)==0x04)
7259  1313 b6d0          	ld	a,_mess+9
7260  1315 a40f          	and	a,#15
7261  1317 a104          	cp	a,#4
7262  1319 260b          	jrne	L3423
7263                     ; 1822 			ee_K[2][1]--;
7265  131b ce0024        	ldw	x,_ee_K+10
7266  131e 1d0001        	subw	x,#1
7267  1321 cf0024        	ldw	_ee_K+10,x
7269  1324 2011          	jra	L1323
7270  1326               L3423:
7271                     ; 1824 		else if((mess[9]&0x0f)==0x05)
7273  1326 b6d0          	ld	a,_mess+9
7274  1328 a40f          	and	a,#15
7275  132a a105          	cp	a,#5
7276  132c 2609          	jrne	L1323
7277                     ; 1826 			ee_K[2][1]-=10;
7279  132e ce0024        	ldw	x,_ee_K+10
7280  1331 1d000a        	subw	x,#10
7281  1334 cf0024        	ldw	_ee_K+10,x
7282  1337               L1323:
7283                     ; 1831 		granee(&ee_K[2][1],10,30000);
7285  1337 ae7530        	ldw	x,#30000
7286  133a 89            	pushw	x
7287  133b ae000a        	ldw	x,#10
7288  133e 89            	pushw	x
7289  133f ae0024        	ldw	x,#_ee_K+10
7290  1342 cd00f6        	call	_granee
7292  1345 5b04          	addw	sp,#4
7294  1347 ac111411      	jpf	L5713
7295  134b               L5223:
7296                     ; 1835 	else if((mess[9]&0xf0)==0x30)
7298  134b b6d0          	ld	a,_mess+9
7299  134d a4f0          	and	a,#240
7300  134f a130          	cp	a,#48
7301  1351 265c          	jrne	L3523
7302                     ; 1837 		if((mess[9]&0x0f)==0x02)
7304  1353 b6d0          	ld	a,_mess+9
7305  1355 a40f          	and	a,#15
7306  1357 a102          	cp	a,#2
7307  1359 260b          	jrne	L5523
7308                     ; 1839 			ee_K[3][1]++;
7310  135b ce0028        	ldw	x,_ee_K+14
7311  135e 1c0001        	addw	x,#1
7312  1361 cf0028        	ldw	_ee_K+14,x
7314  1364 2037          	jra	L7523
7315  1366               L5523:
7316                     ; 1841 		else if((mess[9]&0x0f)==0x03)
7318  1366 b6d0          	ld	a,_mess+9
7319  1368 a40f          	and	a,#15
7320  136a a103          	cp	a,#3
7321  136c 260b          	jrne	L1623
7322                     ; 1843 			ee_K[3][1]+=10;
7324  136e ce0028        	ldw	x,_ee_K+14
7325  1371 1c000a        	addw	x,#10
7326  1374 cf0028        	ldw	_ee_K+14,x
7328  1377 2024          	jra	L7523
7329  1379               L1623:
7330                     ; 1845 		else if((mess[9]&0x0f)==0x04)
7332  1379 b6d0          	ld	a,_mess+9
7333  137b a40f          	and	a,#15
7334  137d a104          	cp	a,#4
7335  137f 260b          	jrne	L5623
7336                     ; 1847 			ee_K[3][1]--;
7338  1381 ce0028        	ldw	x,_ee_K+14
7339  1384 1d0001        	subw	x,#1
7340  1387 cf0028        	ldw	_ee_K+14,x
7342  138a 2011          	jra	L7523
7343  138c               L5623:
7344                     ; 1849 		else if((mess[9]&0x0f)==0x05)
7346  138c b6d0          	ld	a,_mess+9
7347  138e a40f          	and	a,#15
7348  1390 a105          	cp	a,#5
7349  1392 2609          	jrne	L7523
7350                     ; 1851 			ee_K[3][1]-=10;
7352  1394 ce0028        	ldw	x,_ee_K+14
7353  1397 1d000a        	subw	x,#10
7354  139a cf0028        	ldw	_ee_K+14,x
7355  139d               L7523:
7356                     ; 1853 		granee(&ee_K[3][1],300,517);									
7358  139d ae0205        	ldw	x,#517
7359  13a0 89            	pushw	x
7360  13a1 ae012c        	ldw	x,#300
7361  13a4 89            	pushw	x
7362  13a5 ae0028        	ldw	x,#_ee_K+14
7363  13a8 cd00f6        	call	_granee
7365  13ab 5b04          	addw	sp,#4
7367  13ad 2062          	jra	L5713
7368  13af               L3523:
7369                     ; 1856 	else if((mess[9]&0xf0)==0x50)
7371  13af b6d0          	ld	a,_mess+9
7372  13b1 a4f0          	and	a,#240
7373  13b3 a150          	cp	a,#80
7374  13b5 265a          	jrne	L5713
7375                     ; 1858 		if((mess[9]&0x0f)==0x02)
7377  13b7 b6d0          	ld	a,_mess+9
7378  13b9 a40f          	and	a,#15
7379  13bb a102          	cp	a,#2
7380  13bd 260b          	jrne	L7723
7381                     ; 1860 			ee_K[4][1]++;
7383  13bf ce002c        	ldw	x,_ee_K+18
7384  13c2 1c0001        	addw	x,#1
7385  13c5 cf002c        	ldw	_ee_K+18,x
7387  13c8 2037          	jra	L1033
7388  13ca               L7723:
7389                     ; 1862 		else if((mess[9]&0x0f)==0x03)
7391  13ca b6d0          	ld	a,_mess+9
7392  13cc a40f          	and	a,#15
7393  13ce a103          	cp	a,#3
7394  13d0 260b          	jrne	L3033
7395                     ; 1864 			ee_K[4][1]+=10;
7397  13d2 ce002c        	ldw	x,_ee_K+18
7398  13d5 1c000a        	addw	x,#10
7399  13d8 cf002c        	ldw	_ee_K+18,x
7401  13db 2024          	jra	L1033
7402  13dd               L3033:
7403                     ; 1866 		else if((mess[9]&0x0f)==0x04)
7405  13dd b6d0          	ld	a,_mess+9
7406  13df a40f          	and	a,#15
7407  13e1 a104          	cp	a,#4
7408  13e3 260b          	jrne	L7033
7409                     ; 1868 			ee_K[4][1]--;
7411  13e5 ce002c        	ldw	x,_ee_K+18
7412  13e8 1d0001        	subw	x,#1
7413  13eb cf002c        	ldw	_ee_K+18,x
7415  13ee 2011          	jra	L1033
7416  13f0               L7033:
7417                     ; 1870 		else if((mess[9]&0x0f)==0x05)
7419  13f0 b6d0          	ld	a,_mess+9
7420  13f2 a40f          	and	a,#15
7421  13f4 a105          	cp	a,#5
7422  13f6 2609          	jrne	L1033
7423                     ; 1872 			ee_K[4][1]-=10;
7425  13f8 ce002c        	ldw	x,_ee_K+18
7426  13fb 1d000a        	subw	x,#10
7427  13fe cf002c        	ldw	_ee_K+18,x
7428  1401               L1033:
7429                     ; 1874 		granee(&ee_K[4][1],10,30000);									
7431  1401 ae7530        	ldw	x,#30000
7432  1404 89            	pushw	x
7433  1405 ae000a        	ldw	x,#10
7434  1408 89            	pushw	x
7435  1409 ae002c        	ldw	x,#_ee_K+18
7436  140c cd00f6        	call	_granee
7438  140f 5b04          	addw	sp,#4
7439  1411               L5713:
7440                     ; 1877 	link_cnt=0;
7442  1411 5f            	clrw	x
7443  1412 bf6b          	ldw	_link_cnt,x
7444                     ; 1878      link=ON;
7446  1414 3555006d      	mov	_link,#85
7447                     ; 1879      if(res_fl_)
7449  1418 725d000a      	tnz	_res_fl_
7450  141c 2603          	jrne	L671
7451  141e cc1716        	jp	L7503
7452  1421               L671:
7453                     ; 1881       	res_fl_=0;
7455  1421 4f            	clr	a
7456  1422 ae000a        	ldw	x,#_res_fl_
7457  1425 cd0000        	call	c_eewrc
7459  1428 ac161716      	jpf	L7503
7460  142c               L7413:
7461                     ; 1887 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7463  142c b6cd          	ld	a,_mess+6
7464  142e a1ff          	cp	a,#255
7465  1430 2703          	jreq	L002
7466  1432 cc14c0        	jp	L1233
7467  1435               L002:
7469  1435 b6ce          	ld	a,_mess+7
7470  1437 a1ff          	cp	a,#255
7471  1439 2703          	jreq	L202
7472  143b cc14c0        	jp	L1233
7473  143e               L202:
7475  143e b6cf          	ld	a,_mess+8
7476  1440 a162          	cp	a,#98
7477  1442 267c          	jrne	L1233
7478                     ; 1890 	tempSS=mess[9]+(mess[10]*256);
7480  1444 b6d1          	ld	a,_mess+10
7481  1446 5f            	clrw	x
7482  1447 97            	ld	xl,a
7483  1448 4f            	clr	a
7484  1449 02            	rlwa	x,a
7485  144a 01            	rrwa	x,a
7486  144b bbd0          	add	a,_mess+9
7487  144d 2401          	jrnc	L051
7488  144f 5c            	incw	x
7489  1450               L051:
7490  1450 02            	rlwa	x,a
7491  1451 1f03          	ldw	(OFST-4,sp),x
7492  1453 01            	rrwa	x,a
7493                     ; 1891 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7495  1454 ce0014        	ldw	x,_ee_Umax
7496  1457 1303          	cpw	x,(OFST-4,sp)
7497  1459 270a          	jreq	L3233
7500  145b 1e03          	ldw	x,(OFST-4,sp)
7501  145d 89            	pushw	x
7502  145e ae0014        	ldw	x,#_ee_Umax
7503  1461 cd0000        	call	c_eewrw
7505  1464 85            	popw	x
7506  1465               L3233:
7507                     ; 1892 	tempSS=mess[11]+(mess[12]*256);
7509  1465 b6d3          	ld	a,_mess+12
7510  1467 5f            	clrw	x
7511  1468 97            	ld	xl,a
7512  1469 4f            	clr	a
7513  146a 02            	rlwa	x,a
7514  146b 01            	rrwa	x,a
7515  146c bbd2          	add	a,_mess+11
7516  146e 2401          	jrnc	L251
7517  1470 5c            	incw	x
7518  1471               L251:
7519  1471 02            	rlwa	x,a
7520  1472 1f03          	ldw	(OFST-4,sp),x
7521  1474 01            	rrwa	x,a
7522                     ; 1893 	if(ee_dU!=tempSS) ee_dU=tempSS;
7524  1475 ce0012        	ldw	x,_ee_dU
7525  1478 1303          	cpw	x,(OFST-4,sp)
7526  147a 270a          	jreq	L5233
7529  147c 1e03          	ldw	x,(OFST-4,sp)
7530  147e 89            	pushw	x
7531  147f ae0012        	ldw	x,#_ee_dU
7532  1482 cd0000        	call	c_eewrw
7534  1485 85            	popw	x
7535  1486               L5233:
7536                     ; 1894 	if((mess[13]&0x0f)==0x5)
7538  1486 b6d4          	ld	a,_mess+13
7539  1488 a40f          	and	a,#15
7540  148a a105          	cp	a,#5
7541  148c 261a          	jrne	L7233
7542                     ; 1896 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7544  148e ce0006        	ldw	x,_ee_AVT_MODE
7545  1491 a30055        	cpw	x,#85
7546  1494 2603          	jrne	L402
7547  1496 cc1716        	jp	L7503
7548  1499               L402:
7551  1499 ae0055        	ldw	x,#85
7552  149c 89            	pushw	x
7553  149d ae0006        	ldw	x,#_ee_AVT_MODE
7554  14a0 cd0000        	call	c_eewrw
7556  14a3 85            	popw	x
7557  14a4 ac161716      	jpf	L7503
7558  14a8               L7233:
7559                     ; 1898 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7561  14a8 ce0006        	ldw	x,_ee_AVT_MODE
7562  14ab a30055        	cpw	x,#85
7563  14ae 2703          	jreq	L602
7564  14b0 cc1716        	jp	L7503
7565  14b3               L602:
7568  14b3 5f            	clrw	x
7569  14b4 89            	pushw	x
7570  14b5 ae0006        	ldw	x,#_ee_AVT_MODE
7571  14b8 cd0000        	call	c_eewrw
7573  14bb 85            	popw	x
7574  14bc ac161716      	jpf	L7503
7575  14c0               L1233:
7576                     ; 1901 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7578  14c0 b6cd          	ld	a,_mess+6
7579  14c2 a1ff          	cp	a,#255
7580  14c4 2703          	jreq	L012
7581  14c6 cc157c        	jp	L1433
7582  14c9               L012:
7584  14c9 b6ce          	ld	a,_mess+7
7585  14cb a1ff          	cp	a,#255
7586  14cd 2703          	jreq	L212
7587  14cf cc157c        	jp	L1433
7588  14d2               L212:
7590  14d2 b6cf          	ld	a,_mess+8
7591  14d4 a126          	cp	a,#38
7592  14d6 2709          	jreq	L3433
7594  14d8 b6cf          	ld	a,_mess+8
7595  14da a129          	cp	a,#41
7596  14dc 2703          	jreq	L412
7597  14de cc157c        	jp	L1433
7598  14e1               L412:
7599  14e1               L3433:
7600                     ; 1904 	tempSS=mess[9]+(mess[10]*256);
7602  14e1 b6d1          	ld	a,_mess+10
7603  14e3 5f            	clrw	x
7604  14e4 97            	ld	xl,a
7605  14e5 4f            	clr	a
7606  14e6 02            	rlwa	x,a
7607  14e7 01            	rrwa	x,a
7608  14e8 bbd0          	add	a,_mess+9
7609  14ea 2401          	jrnc	L451
7610  14ec 5c            	incw	x
7611  14ed               L451:
7612  14ed 02            	rlwa	x,a
7613  14ee 1f03          	ldw	(OFST-4,sp),x
7614  14f0 01            	rrwa	x,a
7615                     ; 1906 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7617  14f1 ce000c        	ldw	x,_ee_UAVT
7618  14f4 1303          	cpw	x,(OFST-4,sp)
7619  14f6 270a          	jreq	L5433
7622  14f8 1e03          	ldw	x,(OFST-4,sp)
7623  14fa 89            	pushw	x
7624  14fb ae000c        	ldw	x,#_ee_UAVT
7625  14fe cd0000        	call	c_eewrw
7627  1501 85            	popw	x
7628  1502               L5433:
7629                     ; 1907 	tempSS=(signed short)mess[11];
7631  1502 b6d2          	ld	a,_mess+11
7632  1504 5f            	clrw	x
7633  1505 97            	ld	xl,a
7634  1506 1f03          	ldw	(OFST-4,sp),x
7635                     ; 1908 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7637  1508 ce0010        	ldw	x,_ee_tmax
7638  150b 1303          	cpw	x,(OFST-4,sp)
7639  150d 270a          	jreq	L7433
7642  150f 1e03          	ldw	x,(OFST-4,sp)
7643  1511 89            	pushw	x
7644  1512 ae0010        	ldw	x,#_ee_tmax
7645  1515 cd0000        	call	c_eewrw
7647  1518 85            	popw	x
7648  1519               L7433:
7649                     ; 1909 	tempSS=(signed short)mess[12];
7651  1519 b6d3          	ld	a,_mess+12
7652  151b 5f            	clrw	x
7653  151c 97            	ld	xl,a
7654  151d 1f03          	ldw	(OFST-4,sp),x
7655                     ; 1910 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7657  151f ce000e        	ldw	x,_ee_tsign
7658  1522 1303          	cpw	x,(OFST-4,sp)
7659  1524 270a          	jreq	L1533
7662  1526 1e03          	ldw	x,(OFST-4,sp)
7663  1528 89            	pushw	x
7664  1529 ae000e        	ldw	x,#_ee_tsign
7665  152c cd0000        	call	c_eewrw
7667  152f 85            	popw	x
7668  1530               L1533:
7669                     ; 1913 	if(mess[8]==MEM_KF1)
7671  1530 b6cf          	ld	a,_mess+8
7672  1532 a126          	cp	a,#38
7673  1534 260e          	jrne	L3533
7674                     ; 1915 		if(ee_DEVICE!=0)ee_DEVICE=0;
7676  1536 ce0004        	ldw	x,_ee_DEVICE
7677  1539 2709          	jreq	L3533
7680  153b 5f            	clrw	x
7681  153c 89            	pushw	x
7682  153d ae0004        	ldw	x,#_ee_DEVICE
7683  1540 cd0000        	call	c_eewrw
7685  1543 85            	popw	x
7686  1544               L3533:
7687                     ; 1918 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7689  1544 b6cf          	ld	a,_mess+8
7690  1546 a129          	cp	a,#41
7691  1548 2703          	jreq	L612
7692  154a cc1716        	jp	L7503
7693  154d               L612:
7694                     ; 1920 		if(ee_DEVICE!=1)ee_DEVICE=1;
7696  154d ce0004        	ldw	x,_ee_DEVICE
7697  1550 a30001        	cpw	x,#1
7698  1553 270b          	jreq	L1633
7701  1555 ae0001        	ldw	x,#1
7702  1558 89            	pushw	x
7703  1559 ae0004        	ldw	x,#_ee_DEVICE
7704  155c cd0000        	call	c_eewrw
7706  155f 85            	popw	x
7707  1560               L1633:
7708                     ; 1921 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7710  1560 b6d4          	ld	a,_mess+13
7711  1562 5f            	clrw	x
7712  1563 97            	ld	xl,a
7713  1564 c30002        	cpw	x,_ee_IMAXVENT
7714  1567 2603          	jrne	L022
7715  1569 cc1716        	jp	L7503
7716  156c               L022:
7719  156c b6d4          	ld	a,_mess+13
7720  156e 5f            	clrw	x
7721  156f 97            	ld	xl,a
7722  1570 89            	pushw	x
7723  1571 ae0002        	ldw	x,#_ee_IMAXVENT
7724  1574 cd0000        	call	c_eewrw
7726  1577 85            	popw	x
7727  1578 ac161716      	jpf	L7503
7728  157c               L1433:
7729                     ; 1926 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7731  157c b6cd          	ld	a,_mess+6
7732  157e c100f7        	cp	a,_adress
7733  1581 262d          	jrne	L7633
7735  1583 b6ce          	ld	a,_mess+7
7736  1585 c100f7        	cp	a,_adress
7737  1588 2626          	jrne	L7633
7739  158a b6cf          	ld	a,_mess+8
7740  158c a116          	cp	a,#22
7741  158e 2620          	jrne	L7633
7743  1590 b6d0          	ld	a,_mess+9
7744  1592 a163          	cp	a,#99
7745  1594 261a          	jrne	L7633
7746                     ; 1928 	flags&=0b11100001;
7748  1596 b605          	ld	a,_flags
7749  1598 a4e1          	and	a,#225
7750  159a b705          	ld	_flags,a
7751                     ; 1929 	tsign_cnt=0;
7753  159c 5f            	clrw	x
7754  159d bf59          	ldw	_tsign_cnt,x
7755                     ; 1930 	tmax_cnt=0;
7757  159f 5f            	clrw	x
7758  15a0 bf57          	ldw	_tmax_cnt,x
7759                     ; 1931 	umax_cnt=0;
7761  15a2 5f            	clrw	x
7762  15a3 bf70          	ldw	_umax_cnt,x
7763                     ; 1932 	umin_cnt=0;
7765  15a5 5f            	clrw	x
7766  15a6 bf6e          	ldw	_umin_cnt,x
7767                     ; 1933 	led_drv_cnt=30;
7769  15a8 351e0016      	mov	_led_drv_cnt,#30
7771  15ac ac161716      	jpf	L7503
7772  15b0               L7633:
7773                     ; 1936 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7775  15b0 b6cd          	ld	a,_mess+6
7776  15b2 c100f7        	cp	a,_adress
7777  15b5 2620          	jrne	L3733
7779  15b7 b6ce          	ld	a,_mess+7
7780  15b9 c100f7        	cp	a,_adress
7781  15bc 2619          	jrne	L3733
7783  15be b6cf          	ld	a,_mess+8
7784  15c0 a116          	cp	a,#22
7785  15c2 2613          	jrne	L3733
7787  15c4 b6d0          	ld	a,_mess+9
7788  15c6 a164          	cp	a,#100
7789  15c8 260d          	jrne	L3733
7790                     ; 1938 	vent_resurs=0;
7792  15ca 5f            	clrw	x
7793  15cb 89            	pushw	x
7794  15cc ae0000        	ldw	x,#_vent_resurs
7795  15cf cd0000        	call	c_eewrw
7797  15d2 85            	popw	x
7799  15d3 ac161716      	jpf	L7503
7800  15d7               L3733:
7801                     ; 1942 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7803  15d7 b6cd          	ld	a,_mess+6
7804  15d9 a1ff          	cp	a,#255
7805  15db 265f          	jrne	L7733
7807  15dd b6ce          	ld	a,_mess+7
7808  15df a1ff          	cp	a,#255
7809  15e1 2659          	jrne	L7733
7811  15e3 b6cf          	ld	a,_mess+8
7812  15e5 a116          	cp	a,#22
7813  15e7 2653          	jrne	L7733
7815  15e9 b6d0          	ld	a,_mess+9
7816  15eb a116          	cp	a,#22
7817  15ed 264d          	jrne	L7733
7818                     ; 1944 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7820  15ef b6d1          	ld	a,_mess+10
7821  15f1 a155          	cp	a,#85
7822  15f3 260f          	jrne	L1043
7824  15f5 b6d2          	ld	a,_mess+11
7825  15f7 a155          	cp	a,#85
7826  15f9 2609          	jrne	L1043
7829  15fb be68          	ldw	x,__x_
7830  15fd 1c0001        	addw	x,#1
7831  1600 bf68          	ldw	__x_,x
7833  1602 2024          	jra	L3043
7834  1604               L1043:
7835                     ; 1945 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7837  1604 b6d1          	ld	a,_mess+10
7838  1606 a166          	cp	a,#102
7839  1608 260f          	jrne	L5043
7841  160a b6d2          	ld	a,_mess+11
7842  160c a166          	cp	a,#102
7843  160e 2609          	jrne	L5043
7846  1610 be68          	ldw	x,__x_
7847  1612 1d0001        	subw	x,#1
7848  1615 bf68          	ldw	__x_,x
7850  1617 200f          	jra	L3043
7851  1619               L5043:
7852                     ; 1946 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7854  1619 b6d1          	ld	a,_mess+10
7855  161b a177          	cp	a,#119
7856  161d 2609          	jrne	L3043
7858  161f b6d2          	ld	a,_mess+11
7859  1621 a177          	cp	a,#119
7860  1623 2603          	jrne	L3043
7863  1625 5f            	clrw	x
7864  1626 bf68          	ldw	__x_,x
7865  1628               L3043:
7866                     ; 1947      gran(&_x_,-XMAX,XMAX);
7868  1628 ae0019        	ldw	x,#25
7869  162b 89            	pushw	x
7870  162c aeffe7        	ldw	x,#65511
7871  162f 89            	pushw	x
7872  1630 ae0068        	ldw	x,#__x_
7873  1633 cd00d5        	call	_gran
7875  1636 5b04          	addw	sp,#4
7877  1638 ac161716      	jpf	L7503
7878  163c               L7733:
7879                     ; 1949 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7881  163c b6cd          	ld	a,_mess+6
7882  163e c100f7        	cp	a,_adress
7883  1641 2635          	jrne	L5143
7885  1643 b6ce          	ld	a,_mess+7
7886  1645 c100f7        	cp	a,_adress
7887  1648 262e          	jrne	L5143
7889  164a b6cf          	ld	a,_mess+8
7890  164c a116          	cp	a,#22
7891  164e 2628          	jrne	L5143
7893  1650 b6d0          	ld	a,_mess+9
7894  1652 b1d1          	cp	a,_mess+10
7895  1654 2622          	jrne	L5143
7897  1656 b6d0          	ld	a,_mess+9
7898  1658 a1ee          	cp	a,#238
7899  165a 261c          	jrne	L5143
7900                     ; 1951 	rotor_int++;
7902  165c be17          	ldw	x,_rotor_int
7903  165e 1c0001        	addw	x,#1
7904  1661 bf17          	ldw	_rotor_int,x
7905                     ; 1952      tempI=pwm_u;
7907                     ; 1954 	UU_AVT=Un;
7909  1663 ce000e        	ldw	x,_Un
7910  1666 89            	pushw	x
7911  1667 ae0008        	ldw	x,#_UU_AVT
7912  166a cd0000        	call	c_eewrw
7914  166d 85            	popw	x
7915                     ; 1955 	delay_ms(100);
7917  166e ae0064        	ldw	x,#100
7918  1671 cd0121        	call	_delay_ms
7921  1674 ac161716      	jpf	L7503
7922  1678               L5143:
7923                     ; 1961 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7925  1678 b6ce          	ld	a,_mess+7
7926  167a a1da          	cp	a,#218
7927  167c 2653          	jrne	L1243
7929  167e b6cd          	ld	a,_mess+6
7930  1680 c100f7        	cp	a,_adress
7931  1683 274c          	jreq	L1243
7933  1685 b6cd          	ld	a,_mess+6
7934  1687 a106          	cp	a,#6
7935  1689 2446          	jruge	L1243
7936                     ; 1963 	i_main_bps_cnt[mess[6]]=0;
7938  168b b6cd          	ld	a,_mess+6
7939  168d 5f            	clrw	x
7940  168e 97            	ld	xl,a
7941  168f 6f13          	clr	(_i_main_bps_cnt,x)
7942                     ; 1964 	i_main_flag[mess[6]]=1;
7944  1691 b6cd          	ld	a,_mess+6
7945  1693 5f            	clrw	x
7946  1694 97            	ld	xl,a
7947  1695 a601          	ld	a,#1
7948  1697 e71e          	ld	(_i_main_flag,x),a
7949                     ; 1965 	if(bMAIN)
7951                     	btst	_bMAIN
7952  169e 2476          	jruge	L7503
7953                     ; 1967 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7955  16a0 b6d0          	ld	a,_mess+9
7956  16a2 5f            	clrw	x
7957  16a3 97            	ld	xl,a
7958  16a4 4f            	clr	a
7959  16a5 02            	rlwa	x,a
7960  16a6 1f01          	ldw	(OFST-6,sp),x
7961  16a8 b6cf          	ld	a,_mess+8
7962  16aa 5f            	clrw	x
7963  16ab 97            	ld	xl,a
7964  16ac 72fb01        	addw	x,(OFST-6,sp)
7965  16af b6cd          	ld	a,_mess+6
7966  16b1 905f          	clrw	y
7967  16b3 9097          	ld	yl,a
7968  16b5 9058          	sllw	y
7969  16b7 90ef24        	ldw	(_i_main,y),x
7970                     ; 1968 		i_main[adress]=I;
7972  16ba c600f7        	ld	a,_adress
7973  16bd 5f            	clrw	x
7974  16be 97            	ld	xl,a
7975  16bf 58            	sllw	x
7976  16c0 90ce0010      	ldw	y,_I
7977  16c4 ef24          	ldw	(_i_main,x),y
7978                     ; 1969      	i_main_flag[adress]=1;
7980  16c6 c600f7        	ld	a,_adress
7981  16c9 5f            	clrw	x
7982  16ca 97            	ld	xl,a
7983  16cb a601          	ld	a,#1
7984  16cd e71e          	ld	(_i_main_flag,x),a
7985  16cf 2045          	jra	L7503
7986  16d1               L1243:
7987                     ; 1973 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7989  16d1 b6ce          	ld	a,_mess+7
7990  16d3 a1db          	cp	a,#219
7991  16d5 263f          	jrne	L7503
7993  16d7 b6cd          	ld	a,_mess+6
7994  16d9 c100f7        	cp	a,_adress
7995  16dc 2738          	jreq	L7503
7997  16de b6cd          	ld	a,_mess+6
7998  16e0 a106          	cp	a,#6
7999  16e2 2432          	jruge	L7503
8000                     ; 1975 	i_main_bps_cnt[mess[6]]=0;
8002  16e4 b6cd          	ld	a,_mess+6
8003  16e6 5f            	clrw	x
8004  16e7 97            	ld	xl,a
8005  16e8 6f13          	clr	(_i_main_bps_cnt,x)
8006                     ; 1976 	i_main_flag[mess[6]]=1;		
8008  16ea b6cd          	ld	a,_mess+6
8009  16ec 5f            	clrw	x
8010  16ed 97            	ld	xl,a
8011  16ee a601          	ld	a,#1
8012  16f0 e71e          	ld	(_i_main_flag,x),a
8013                     ; 1977 	if(bMAIN)
8015                     	btst	_bMAIN
8016  16f7 241d          	jruge	L7503
8017                     ; 1979 		if(mess[9]==0)i_main_flag[i]=1;
8019  16f9 3dd0          	tnz	_mess+9
8020  16fb 260a          	jrne	L3343
8023  16fd 7b07          	ld	a,(OFST+0,sp)
8024  16ff 5f            	clrw	x
8025  1700 97            	ld	xl,a
8026  1701 a601          	ld	a,#1
8027  1703 e71e          	ld	(_i_main_flag,x),a
8029  1705 2006          	jra	L5343
8030  1707               L3343:
8031                     ; 1980 		else i_main_flag[i]=0;
8033  1707 7b07          	ld	a,(OFST+0,sp)
8034  1709 5f            	clrw	x
8035  170a 97            	ld	xl,a
8036  170b 6f1e          	clr	(_i_main_flag,x)
8037  170d               L5343:
8038                     ; 1981 		i_main_flag[adress]=1;
8040  170d c600f7        	ld	a,_adress
8041  1710 5f            	clrw	x
8042  1711 97            	ld	xl,a
8043  1712 a601          	ld	a,#1
8044  1714 e71e          	ld	(_i_main_flag,x),a
8045  1716               L7503:
8046                     ; 1987 can_in_an_end:
8046                     ; 1988 bCAN_RX=0;
8048  1716 3f04          	clr	_bCAN_RX
8049                     ; 1989 }   
8052  1718 5b07          	addw	sp,#7
8053  171a 81            	ret
8076                     ; 1992 void t4_init(void){
8077                     	switch	.text
8078  171b               _t4_init:
8082                     ; 1993 	TIM4->PSCR = 6;
8084  171b 35065345      	mov	21317,#6
8085                     ; 1994 	TIM4->ARR= 61;
8087  171f 353d5346      	mov	21318,#61
8088                     ; 1995 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8090  1723 72105341      	bset	21313,#0
8091                     ; 1997 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8093  1727 35855340      	mov	21312,#133
8094                     ; 1999 }
8097  172b 81            	ret
8120                     ; 2002 void t1_init(void)
8120                     ; 2003 {
8121                     	switch	.text
8122  172c               _t1_init:
8126                     ; 2004 TIM1->ARRH= 0x07;
8128  172c 35075262      	mov	21090,#7
8129                     ; 2005 TIM1->ARRL= 0xff;
8131  1730 35ff5263      	mov	21091,#255
8132                     ; 2006 TIM1->CCR1H= 0x00;	
8134  1734 725f5265      	clr	21093
8135                     ; 2007 TIM1->CCR1L= 0xff;
8137  1738 35ff5266      	mov	21094,#255
8138                     ; 2008 TIM1->CCR2H= 0x00;	
8140  173c 725f5267      	clr	21095
8141                     ; 2009 TIM1->CCR2L= 0x00;
8143  1740 725f5268      	clr	21096
8144                     ; 2010 TIM1->CCR3H= 0x00;	
8146  1744 725f5269      	clr	21097
8147                     ; 2011 TIM1->CCR3L= 0x64;
8149  1748 3564526a      	mov	21098,#100
8150                     ; 2013 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8152  174c 35685258      	mov	21080,#104
8153                     ; 2014 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8155  1750 35685259      	mov	21081,#104
8156                     ; 2015 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8158  1754 3568525a      	mov	21082,#104
8159                     ; 2016 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8161  1758 3511525c      	mov	21084,#17
8162                     ; 2017 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8164  175c 3501525d      	mov	21085,#1
8165                     ; 2018 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8167  1760 35815250      	mov	21072,#129
8168                     ; 2019 TIM1->BKR|= TIM1_BKR_AOE;
8170  1764 721c526d      	bset	21101,#6
8171                     ; 2020 }
8174  1768 81            	ret
8199                     ; 2024 void adc2_init(void)
8199                     ; 2025 {
8200                     	switch	.text
8201  1769               _adc2_init:
8205                     ; 2026 adc_plazma[0]++;
8207  1769 beb9          	ldw	x,_adc_plazma
8208  176b 1c0001        	addw	x,#1
8209  176e bfb9          	ldw	_adc_plazma,x
8210                     ; 2050 GPIOB->DDR&=~(1<<4);
8212  1770 72195007      	bres	20487,#4
8213                     ; 2051 GPIOB->CR1&=~(1<<4);
8215  1774 72195008      	bres	20488,#4
8216                     ; 2052 GPIOB->CR2&=~(1<<4);
8218  1778 72195009      	bres	20489,#4
8219                     ; 2054 GPIOB->DDR&=~(1<<5);
8221  177c 721b5007      	bres	20487,#5
8222                     ; 2055 GPIOB->CR1&=~(1<<5);
8224  1780 721b5008      	bres	20488,#5
8225                     ; 2056 GPIOB->CR2&=~(1<<5);
8227  1784 721b5009      	bres	20489,#5
8228                     ; 2058 GPIOB->DDR&=~(1<<6);
8230  1788 721d5007      	bres	20487,#6
8231                     ; 2059 GPIOB->CR1&=~(1<<6);
8233  178c 721d5008      	bres	20488,#6
8234                     ; 2060 GPIOB->CR2&=~(1<<6);
8236  1790 721d5009      	bres	20489,#6
8237                     ; 2062 GPIOB->DDR&=~(1<<7);
8239  1794 721f5007      	bres	20487,#7
8240                     ; 2063 GPIOB->CR1&=~(1<<7);
8242  1798 721f5008      	bres	20488,#7
8243                     ; 2064 GPIOB->CR2&=~(1<<7);
8245  179c 721f5009      	bres	20489,#7
8246                     ; 2066 GPIOB->DDR&=~(1<<2);
8248  17a0 72155007      	bres	20487,#2
8249                     ; 2067 GPIOB->CR1&=~(1<<2);
8251  17a4 72155008      	bres	20488,#2
8252                     ; 2068 GPIOB->CR2&=~(1<<2);
8254  17a8 72155009      	bres	20489,#2
8255                     ; 2077 ADC2->TDRL=0xff;
8257  17ac 35ff5407      	mov	21511,#255
8258                     ; 2079 ADC2->CR2=0x08;
8260  17b0 35085402      	mov	21506,#8
8261                     ; 2080 ADC2->CR1=0x60;
8263  17b4 35605401      	mov	21505,#96
8264                     ; 2083 	if(adc_ch==5)ADC2->CSR=0x22;
8266  17b8 b6c6          	ld	a,_adc_ch
8267  17ba a105          	cp	a,#5
8268  17bc 2606          	jrne	L7643
8271  17be 35225400      	mov	21504,#34
8273  17c2 2007          	jra	L1743
8274  17c4               L7643:
8275                     ; 2084 	else ADC2->CSR=0x20+adc_ch+3;
8277  17c4 b6c6          	ld	a,_adc_ch
8278  17c6 ab23          	add	a,#35
8279  17c8 c75400        	ld	21504,a
8280  17cb               L1743:
8281                     ; 2086 	ADC2->CR1|=1;
8283  17cb 72105401      	bset	21505,#0
8284                     ; 2087 	ADC2->CR1|=1;
8286  17cf 72105401      	bset	21505,#0
8287                     ; 2090 adc_plazma[1]=adc_ch;
8289  17d3 b6c6          	ld	a,_adc_ch
8290  17d5 5f            	clrw	x
8291  17d6 97            	ld	xl,a
8292  17d7 bfbb          	ldw	_adc_plazma+2,x
8293                     ; 2091 }
8296  17d9 81            	ret
8332                     ; 2099 @far @interrupt void TIM4_UPD_Interrupt (void) 
8332                     ; 2100 {
8334                     	switch	.text
8335  17da               f_TIM4_UPD_Interrupt:
8339                     ; 2101 TIM4->SR1&=~TIM4_SR1_UIF;
8341  17da 72115342      	bres	21314,#0
8342                     ; 2103 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8344  17de 3c12          	inc	_pwm_vent_cnt
8345  17e0 b612          	ld	a,_pwm_vent_cnt
8346  17e2 a10a          	cp	a,#10
8347  17e4 2502          	jrult	L3053
8350  17e6 3f12          	clr	_pwm_vent_cnt
8351  17e8               L3053:
8352                     ; 2104 GPIOB->ODR|=(1<<3);
8354  17e8 72165005      	bset	20485,#3
8355                     ; 2105 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8357  17ec b612          	ld	a,_pwm_vent_cnt
8358  17ee a105          	cp	a,#5
8359  17f0 2504          	jrult	L5053
8362  17f2 72175005      	bres	20485,#3
8363  17f6               L5053:
8364                     ; 2109 if(++t0_cnt00>=10)
8366  17f6 9c            	rvf
8367  17f7 ce0000        	ldw	x,_t0_cnt00
8368  17fa 1c0001        	addw	x,#1
8369  17fd cf0000        	ldw	_t0_cnt00,x
8370  1800 a3000a        	cpw	x,#10
8371  1803 2f08          	jrslt	L7053
8372                     ; 2111 	t0_cnt00=0;
8374  1805 5f            	clrw	x
8375  1806 cf0000        	ldw	_t0_cnt00,x
8376                     ; 2112 	b1000Hz=1;
8378  1809 72100004      	bset	_b1000Hz
8379  180d               L7053:
8380                     ; 2115 if(++t0_cnt0>=100)
8382  180d 9c            	rvf
8383  180e ce0002        	ldw	x,_t0_cnt0
8384  1811 1c0001        	addw	x,#1
8385  1814 cf0002        	ldw	_t0_cnt0,x
8386  1817 a30064        	cpw	x,#100
8387  181a 2f54          	jrslt	L1153
8388                     ; 2117 	t0_cnt0=0;
8390  181c 5f            	clrw	x
8391  181d cf0002        	ldw	_t0_cnt0,x
8392                     ; 2118 	b100Hz=1;
8394  1820 72100009      	bset	_b100Hz
8395                     ; 2120 	if(++t0_cnt1>=10)
8397  1824 725c0004      	inc	_t0_cnt1
8398  1828 c60004        	ld	a,_t0_cnt1
8399  182b a10a          	cp	a,#10
8400  182d 2508          	jrult	L3153
8401                     ; 2122 		t0_cnt1=0;
8403  182f 725f0004      	clr	_t0_cnt1
8404                     ; 2123 		b10Hz=1;
8406  1833 72100008      	bset	_b10Hz
8407  1837               L3153:
8408                     ; 2126 	if(++t0_cnt2>=20)
8410  1837 725c0005      	inc	_t0_cnt2
8411  183b c60005        	ld	a,_t0_cnt2
8412  183e a114          	cp	a,#20
8413  1840 2508          	jrult	L5153
8414                     ; 2128 		t0_cnt2=0;
8416  1842 725f0005      	clr	_t0_cnt2
8417                     ; 2129 		b5Hz=1;
8419  1846 72100007      	bset	_b5Hz
8420  184a               L5153:
8421                     ; 2133 	if(++t0_cnt4>=50)
8423  184a 725c0007      	inc	_t0_cnt4
8424  184e c60007        	ld	a,_t0_cnt4
8425  1851 a132          	cp	a,#50
8426  1853 2508          	jrult	L7153
8427                     ; 2135 		t0_cnt4=0;
8429  1855 725f0007      	clr	_t0_cnt4
8430                     ; 2136 		b2Hz=1;
8432  1859 72100006      	bset	_b2Hz
8433  185d               L7153:
8434                     ; 2139 	if(++t0_cnt3>=100)
8436  185d 725c0006      	inc	_t0_cnt3
8437  1861 c60006        	ld	a,_t0_cnt3
8438  1864 a164          	cp	a,#100
8439  1866 2508          	jrult	L1153
8440                     ; 2141 		t0_cnt3=0;
8442  1868 725f0006      	clr	_t0_cnt3
8443                     ; 2142 		b1Hz=1;
8445  186c 72100005      	bset	_b1Hz
8446  1870               L1153:
8447                     ; 2148 }
8450  1870 80            	iret
8475                     ; 2151 @far @interrupt void CAN_RX_Interrupt (void) 
8475                     ; 2152 {
8476                     	switch	.text
8477  1871               f_CAN_RX_Interrupt:
8481                     ; 2154 CAN->PSR= 7;									// page 7 - read messsage
8483  1871 35075427      	mov	21543,#7
8484                     ; 2156 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8486  1875 ae000e        	ldw	x,#14
8487  1878               L432:
8488  1878 d65427        	ld	a,(21543,x)
8489  187b e7c6          	ld	(_mess-1,x),a
8490  187d 5a            	decw	x
8491  187e 26f8          	jrne	L432
8492                     ; 2167 bCAN_RX=1;
8494  1880 35010004      	mov	_bCAN_RX,#1
8495                     ; 2168 CAN->RFR|=(1<<5);
8497  1884 721a5424      	bset	21540,#5
8498                     ; 2170 }
8501  1888 80            	iret
8524                     ; 2173 @far @interrupt void CAN_TX_Interrupt (void) 
8524                     ; 2174 {
8525                     	switch	.text
8526  1889               f_CAN_TX_Interrupt:
8530                     ; 2175 if((CAN->TSR)&(1<<0))
8532  1889 c65422        	ld	a,21538
8533  188c a501          	bcp	a,#1
8534  188e 2708          	jreq	L3453
8535                     ; 2177 	bTX_FREE=1;	
8537  1890 35010003      	mov	_bTX_FREE,#1
8538                     ; 2179 	CAN->TSR|=(1<<0);
8540  1894 72105422      	bset	21538,#0
8541  1898               L3453:
8542                     ; 2181 }
8545  1898 80            	iret
8625                     ; 2184 @far @interrupt void ADC2_EOC_Interrupt (void) {
8626                     	switch	.text
8627  1899               f_ADC2_EOC_Interrupt:
8629       0000000d      OFST:	set	13
8630  1899 be00          	ldw	x,c_x
8631  189b 89            	pushw	x
8632  189c be00          	ldw	x,c_y
8633  189e 89            	pushw	x
8634  189f be02          	ldw	x,c_lreg+2
8635  18a1 89            	pushw	x
8636  18a2 be00          	ldw	x,c_lreg
8637  18a4 89            	pushw	x
8638  18a5 520d          	subw	sp,#13
8641                     ; 2189 adc_plazma[2]++;
8643  18a7 bebd          	ldw	x,_adc_plazma+4
8644  18a9 1c0001        	addw	x,#1
8645  18ac bfbd          	ldw	_adc_plazma+4,x
8646                     ; 2196 ADC2->CSR&=~(1<<7);
8648  18ae 721f5400      	bres	21504,#7
8649                     ; 2198 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8651  18b2 c65405        	ld	a,21509
8652  18b5 b703          	ld	c_lreg+3,a
8653  18b7 3f02          	clr	c_lreg+2
8654  18b9 3f01          	clr	c_lreg+1
8655  18bb 3f00          	clr	c_lreg
8656  18bd 96            	ldw	x,sp
8657  18be 1c0001        	addw	x,#OFST-12
8658  18c1 cd0000        	call	c_rtol
8660  18c4 c65404        	ld	a,21508
8661  18c7 5f            	clrw	x
8662  18c8 97            	ld	xl,a
8663  18c9 90ae0100      	ldw	y,#256
8664  18cd cd0000        	call	c_umul
8666  18d0 96            	ldw	x,sp
8667  18d1 1c0001        	addw	x,#OFST-12
8668  18d4 cd0000        	call	c_ladd
8670  18d7 96            	ldw	x,sp
8671  18d8 1c000a        	addw	x,#OFST-3
8672  18db cd0000        	call	c_rtol
8674                     ; 2203 if(adr_drv_stat==1)
8676  18de b602          	ld	a,_adr_drv_stat
8677  18e0 a101          	cp	a,#1
8678  18e2 260b          	jrne	L3063
8679                     ; 2205 	adr_drv_stat=2;
8681  18e4 35020002      	mov	_adr_drv_stat,#2
8682                     ; 2206 	adc_buff_[0]=temp_adc;
8684  18e8 1e0c          	ldw	x,(OFST-1,sp)
8685  18ea cf00ff        	ldw	_adc_buff_,x
8687  18ed 2020          	jra	L5063
8688  18ef               L3063:
8689                     ; 2209 else if(adr_drv_stat==3)
8691  18ef b602          	ld	a,_adr_drv_stat
8692  18f1 a103          	cp	a,#3
8693  18f3 260b          	jrne	L7063
8694                     ; 2211 	adr_drv_stat=4;
8696  18f5 35040002      	mov	_adr_drv_stat,#4
8697                     ; 2212 	adc_buff_[1]=temp_adc;
8699  18f9 1e0c          	ldw	x,(OFST-1,sp)
8700  18fb cf0101        	ldw	_adc_buff_+2,x
8702  18fe 200f          	jra	L5063
8703  1900               L7063:
8704                     ; 2215 else if(adr_drv_stat==5)
8706  1900 b602          	ld	a,_adr_drv_stat
8707  1902 a105          	cp	a,#5
8708  1904 2609          	jrne	L5063
8709                     ; 2217 	adr_drv_stat=6;
8711  1906 35060002      	mov	_adr_drv_stat,#6
8712                     ; 2218 	adc_buff_[9]=temp_adc;
8714  190a 1e0c          	ldw	x,(OFST-1,sp)
8715  190c cf0111        	ldw	_adc_buff_+18,x
8716  190f               L5063:
8717                     ; 2221 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8719  190f b6b7          	ld	a,_adc_cnt_cnt
8720  1911 5f            	clrw	x
8721  1912 97            	ld	xl,a
8722  1913 58            	sllw	x
8723  1914 1f03          	ldw	(OFST-10,sp),x
8724  1916 b6c6          	ld	a,_adc_ch
8725  1918 97            	ld	xl,a
8726  1919 a610          	ld	a,#16
8727  191b 42            	mul	x,a
8728  191c 72fb03        	addw	x,(OFST-10,sp)
8729  191f 160c          	ldw	y,(OFST-1,sp)
8730  1921 df0056        	ldw	(_adc_buff_buff,x),y
8731                     ; 2223 adc_ch++;
8733  1924 3cc6          	inc	_adc_ch
8734                     ; 2224 if(adc_ch>=6)
8736  1926 b6c6          	ld	a,_adc_ch
8737  1928 a106          	cp	a,#6
8738  192a 2516          	jrult	L5163
8739                     ; 2226 	adc_ch=0;
8741  192c 3fc6          	clr	_adc_ch
8742                     ; 2227 	adc_cnt_cnt++;
8744  192e 3cb7          	inc	_adc_cnt_cnt
8745                     ; 2228 	if(adc_cnt_cnt>=8)
8747  1930 b6b7          	ld	a,_adc_cnt_cnt
8748  1932 a108          	cp	a,#8
8749  1934 250c          	jrult	L5163
8750                     ; 2230 		adc_cnt_cnt=0;
8752  1936 3fb7          	clr	_adc_cnt_cnt
8753                     ; 2231 		adc_cnt++;
8755  1938 3cc5          	inc	_adc_cnt
8756                     ; 2232 		if(adc_cnt>=16)
8758  193a b6c5          	ld	a,_adc_cnt
8759  193c a110          	cp	a,#16
8760  193e 2502          	jrult	L5163
8761                     ; 2234 			adc_cnt=0;
8763  1940 3fc5          	clr	_adc_cnt
8764  1942               L5163:
8765                     ; 2238 if(adc_cnt_cnt==0)
8767  1942 3db7          	tnz	_adc_cnt_cnt
8768  1944 2660          	jrne	L3263
8769                     ; 2242 	tempSS=0;
8771  1946 ae0000        	ldw	x,#0
8772  1949 1f07          	ldw	(OFST-6,sp),x
8773  194b ae0000        	ldw	x,#0
8774  194e 1f05          	ldw	(OFST-8,sp),x
8775                     ; 2243 	for(i=0;i<8;i++)
8777  1950 0f09          	clr	(OFST-4,sp)
8778  1952               L5263:
8779                     ; 2245 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8781  1952 7b09          	ld	a,(OFST-4,sp)
8782  1954 5f            	clrw	x
8783  1955 97            	ld	xl,a
8784  1956 58            	sllw	x
8785  1957 1f03          	ldw	(OFST-10,sp),x
8786  1959 b6c6          	ld	a,_adc_ch
8787  195b 97            	ld	xl,a
8788  195c a610          	ld	a,#16
8789  195e 42            	mul	x,a
8790  195f 72fb03        	addw	x,(OFST-10,sp)
8791  1962 de0056        	ldw	x,(_adc_buff_buff,x)
8792  1965 cd0000        	call	c_itolx
8794  1968 96            	ldw	x,sp
8795  1969 1c0005        	addw	x,#OFST-8
8796  196c cd0000        	call	c_lgadd
8798                     ; 2243 	for(i=0;i<8;i++)
8800  196f 0c09          	inc	(OFST-4,sp)
8803  1971 7b09          	ld	a,(OFST-4,sp)
8804  1973 a108          	cp	a,#8
8805  1975 25db          	jrult	L5263
8806                     ; 2247 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8808  1977 96            	ldw	x,sp
8809  1978 1c0005        	addw	x,#OFST-8
8810  197b cd0000        	call	c_ltor
8812  197e a603          	ld	a,#3
8813  1980 cd0000        	call	c_lrsh
8815  1983 be02          	ldw	x,c_lreg+2
8816  1985 b6c5          	ld	a,_adc_cnt
8817  1987 905f          	clrw	y
8818  1989 9097          	ld	yl,a
8819  198b 9058          	sllw	y
8820  198d 1703          	ldw	(OFST-10,sp),y
8821  198f b6c6          	ld	a,_adc_ch
8822  1991 905f          	clrw	y
8823  1993 9097          	ld	yl,a
8824  1995 9058          	sllw	y
8825  1997 9058          	sllw	y
8826  1999 9058          	sllw	y
8827  199b 9058          	sllw	y
8828  199d 9058          	sllw	y
8829  199f 72f903        	addw	y,(OFST-10,sp)
8830  19a2 90df0113      	ldw	(_adc_buff,y),x
8831  19a6               L3263:
8832                     ; 2251 if((adc_cnt&0x03)==0)
8834  19a6 b6c5          	ld	a,_adc_cnt
8835  19a8 a503          	bcp	a,#3
8836  19aa 264b          	jrne	L3363
8837                     ; 2255 	tempSS=0;
8839  19ac ae0000        	ldw	x,#0
8840  19af 1f07          	ldw	(OFST-6,sp),x
8841  19b1 ae0000        	ldw	x,#0
8842  19b4 1f05          	ldw	(OFST-8,sp),x
8843                     ; 2256 	for(i=0;i<16;i++)
8845  19b6 0f09          	clr	(OFST-4,sp)
8846  19b8               L5363:
8847                     ; 2258 		tempSS+=(signed long)adc_buff[adc_ch][i];
8849  19b8 7b09          	ld	a,(OFST-4,sp)
8850  19ba 5f            	clrw	x
8851  19bb 97            	ld	xl,a
8852  19bc 58            	sllw	x
8853  19bd 1f03          	ldw	(OFST-10,sp),x
8854  19bf b6c6          	ld	a,_adc_ch
8855  19c1 97            	ld	xl,a
8856  19c2 a620          	ld	a,#32
8857  19c4 42            	mul	x,a
8858  19c5 72fb03        	addw	x,(OFST-10,sp)
8859  19c8 de0113        	ldw	x,(_adc_buff,x)
8860  19cb cd0000        	call	c_itolx
8862  19ce 96            	ldw	x,sp
8863  19cf 1c0005        	addw	x,#OFST-8
8864  19d2 cd0000        	call	c_lgadd
8866                     ; 2256 	for(i=0;i<16;i++)
8868  19d5 0c09          	inc	(OFST-4,sp)
8871  19d7 7b09          	ld	a,(OFST-4,sp)
8872  19d9 a110          	cp	a,#16
8873  19db 25db          	jrult	L5363
8874                     ; 2260 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8876  19dd 96            	ldw	x,sp
8877  19de 1c0005        	addw	x,#OFST-8
8878  19e1 cd0000        	call	c_ltor
8880  19e4 a604          	ld	a,#4
8881  19e6 cd0000        	call	c_lrsh
8883  19e9 be02          	ldw	x,c_lreg+2
8884  19eb b6c6          	ld	a,_adc_ch
8885  19ed 905f          	clrw	y
8886  19ef 9097          	ld	yl,a
8887  19f1 9058          	sllw	y
8888  19f3 90df00ff      	ldw	(_adc_buff_,y),x
8889  19f7               L3363:
8890                     ; 2267 if(adc_ch==0)adc_buff_5=temp_adc;
8892  19f7 3dc6          	tnz	_adc_ch
8893  19f9 2605          	jrne	L3463
8896  19fb 1e0c          	ldw	x,(OFST-1,sp)
8897  19fd cf00fd        	ldw	_adc_buff_5,x
8898  1a00               L3463:
8899                     ; 2268 if(adc_ch==2)adc_buff_1=temp_adc;
8901  1a00 b6c6          	ld	a,_adc_ch
8902  1a02 a102          	cp	a,#2
8903  1a04 2605          	jrne	L5463
8906  1a06 1e0c          	ldw	x,(OFST-1,sp)
8907  1a08 cf00fb        	ldw	_adc_buff_1,x
8908  1a0b               L5463:
8909                     ; 2270 adc_plazma_short++;
8911  1a0b bec3          	ldw	x,_adc_plazma_short
8912  1a0d 1c0001        	addw	x,#1
8913  1a10 bfc3          	ldw	_adc_plazma_short,x
8914                     ; 2272 }
8917  1a12 5b0d          	addw	sp,#13
8918  1a14 85            	popw	x
8919  1a15 bf00          	ldw	c_lreg,x
8920  1a17 85            	popw	x
8921  1a18 bf02          	ldw	c_lreg+2,x
8922  1a1a 85            	popw	x
8923  1a1b bf00          	ldw	c_y,x
8924  1a1d 85            	popw	x
8925  1a1e bf00          	ldw	c_x,x
8926  1a20 80            	iret
8984                     ; 2281 main()
8984                     ; 2282 {
8986                     	switch	.text
8987  1a21               _main:
8991                     ; 2284 CLK->ECKR|=1;
8993  1a21 721050c1      	bset	20673,#0
8995  1a25               L1663:
8996                     ; 2285 while((CLK->ECKR & 2) == 0);
8998  1a25 c650c1        	ld	a,20673
8999  1a28 a502          	bcp	a,#2
9000  1a2a 27f9          	jreq	L1663
9001                     ; 2286 CLK->SWCR|=2;
9003  1a2c 721250c5      	bset	20677,#1
9004                     ; 2287 CLK->SWR=0xB4;
9006  1a30 35b450c4      	mov	20676,#180
9007                     ; 2289 delay_ms(200);
9009  1a34 ae00c8        	ldw	x,#200
9010  1a37 cd0121        	call	_delay_ms
9012                     ; 2290 FLASH_DUKR=0xae;
9014  1a3a 35ae5064      	mov	_FLASH_DUKR,#174
9015                     ; 2291 FLASH_DUKR=0x56;
9017  1a3e 35565064      	mov	_FLASH_DUKR,#86
9018                     ; 2292 enableInterrupts();
9021  1a42 9a            rim
9023                     ; 2295 adr_drv_v3();
9026  1a43 cd0d21        	call	_adr_drv_v3
9028                     ; 2299 t4_init();
9030  1a46 cd171b        	call	_t4_init
9032                     ; 2301 		GPIOG->DDR|=(1<<0);
9034  1a49 72105020      	bset	20512,#0
9035                     ; 2302 		GPIOG->CR1|=(1<<0);
9037  1a4d 72105021      	bset	20513,#0
9038                     ; 2303 		GPIOG->CR2&=~(1<<0);	
9040  1a51 72115022      	bres	20514,#0
9041                     ; 2306 		GPIOG->DDR&=~(1<<1);
9043  1a55 72135020      	bres	20512,#1
9044                     ; 2307 		GPIOG->CR1|=(1<<1);
9046  1a59 72125021      	bset	20513,#1
9047                     ; 2308 		GPIOG->CR2&=~(1<<1);
9049  1a5d 72135022      	bres	20514,#1
9050                     ; 2310 init_CAN();
9052  1a61 cd0f11        	call	_init_CAN
9054                     ; 2315 GPIOC->DDR|=(1<<1);
9056  1a64 7212500c      	bset	20492,#1
9057                     ; 2316 GPIOC->CR1|=(1<<1);
9059  1a68 7212500d      	bset	20493,#1
9060                     ; 2317 GPIOC->CR2|=(1<<1);
9062  1a6c 7212500e      	bset	20494,#1
9063                     ; 2319 GPIOC->DDR|=(1<<2);
9065  1a70 7214500c      	bset	20492,#2
9066                     ; 2320 GPIOC->CR1|=(1<<2);
9068  1a74 7214500d      	bset	20493,#2
9069                     ; 2321 GPIOC->CR2|=(1<<2);
9071  1a78 7214500e      	bset	20494,#2
9072                     ; 2328 t1_init();
9074  1a7c cd172c        	call	_t1_init
9076                     ; 2330 GPIOA->DDR|=(1<<5);
9078  1a7f 721a5002      	bset	20482,#5
9079                     ; 2331 GPIOA->CR1|=(1<<5);
9081  1a83 721a5003      	bset	20483,#5
9082                     ; 2332 GPIOA->CR2&=~(1<<5);
9084  1a87 721b5004      	bres	20484,#5
9085                     ; 2338 GPIOB->DDR&=~(1<<3);
9087  1a8b 72175007      	bres	20487,#3
9088                     ; 2339 GPIOB->CR1&=~(1<<3);
9090  1a8f 72175008      	bres	20488,#3
9091                     ; 2340 GPIOB->CR2&=~(1<<3);
9093  1a93 72175009      	bres	20489,#3
9094                     ; 2342 GPIOC->DDR|=(1<<3);
9096  1a97 7216500c      	bset	20492,#3
9097                     ; 2343 GPIOC->CR1|=(1<<3);
9099  1a9b 7216500d      	bset	20493,#3
9100                     ; 2344 GPIOC->CR2|=(1<<3);
9102  1a9f 7216500e      	bset	20494,#3
9103  1aa3               L5663:
9104                     ; 2350 	if(b1000Hz)
9106                     	btst	_b1000Hz
9107  1aa8 2407          	jruge	L1763
9108                     ; 2352 		b1000Hz=0;
9110  1aaa 72110004      	bres	_b1000Hz
9111                     ; 2354 		adc2_init();
9113  1aae cd1769        	call	_adc2_init
9115  1ab1               L1763:
9116                     ; 2357 	if(bCAN_RX)
9118  1ab1 3d04          	tnz	_bCAN_RX
9119  1ab3 2705          	jreq	L3763
9120                     ; 2359 		bCAN_RX=0;
9122  1ab5 3f04          	clr	_bCAN_RX
9123                     ; 2360 		can_in_an();	
9125  1ab7 cd106e        	call	_can_in_an
9127  1aba               L3763:
9128                     ; 2362 	if(b100Hz)
9130                     	btst	_b100Hz
9131  1abf 2407          	jruge	L5763
9132                     ; 2364 		b100Hz=0;
9134  1ac1 72110009      	bres	_b100Hz
9135                     ; 2374 		can_tx_hndl();
9137  1ac5 cd1004        	call	_can_tx_hndl
9139  1ac8               L5763:
9140                     ; 2377 	if(b10Hz)
9142                     	btst	_b10Hz
9143  1acd 2425          	jruge	L7763
9144                     ; 2379 		b10Hz=0;
9146  1acf 72110008      	bres	_b10Hz
9147                     ; 2381 		matemat();
9149  1ad3 cd0843        	call	_matemat
9151                     ; 2382 		led_drv(); 
9153  1ad6 cd03ee        	call	_led_drv
9155                     ; 2383 	  link_drv();
9157  1ad9 cd04dc        	call	_link_drv
9159                     ; 2385 	  JP_drv();
9161  1adc cd0451        	call	_JP_drv
9163                     ; 2386 	  flags_drv();
9165  1adf cd0cd6        	call	_flags_drv
9167                     ; 2388 		if(main_cnt10<100)main_cnt10++;
9169  1ae2 9c            	rvf
9170  1ae3 ce0253        	ldw	x,_main_cnt10
9171  1ae6 a30064        	cpw	x,#100
9172  1ae9 2e09          	jrsge	L7763
9175  1aeb ce0253        	ldw	x,_main_cnt10
9176  1aee 1c0001        	addw	x,#1
9177  1af1 cf0253        	ldw	_main_cnt10,x
9178  1af4               L7763:
9179                     ; 2391 	if(b5Hz)
9181                     	btst	_b5Hz
9182  1af9 241c          	jruge	L3073
9183                     ; 2393 		b5Hz=0;
9185  1afb 72110007      	bres	_b5Hz
9186                     ; 2399 		pwr_drv();		//воздействие на силу
9188  1aff cd06ac        	call	_pwr_drv
9190                     ; 2400 		led_hndl();
9192  1b02 cd0163        	call	_led_hndl
9194                     ; 2402 		vent_drv();
9196  1b05 cd0534        	call	_vent_drv
9198                     ; 2404 		if(main_cnt1<1000)main_cnt1++;
9200  1b08 9c            	rvf
9201  1b09 be5b          	ldw	x,_main_cnt1
9202  1b0b a303e8        	cpw	x,#1000
9203  1b0e 2e07          	jrsge	L3073
9206  1b10 be5b          	ldw	x,_main_cnt1
9207  1b12 1c0001        	addw	x,#1
9208  1b15 bf5b          	ldw	_main_cnt1,x
9209  1b17               L3073:
9210                     ; 2407 	if(b2Hz)
9212                     	btst	_b2Hz
9213  1b1c 2404          	jruge	L7073
9214                     ; 2409 		b2Hz=0;
9216  1b1e 72110006      	bres	_b2Hz
9217  1b22               L7073:
9218                     ; 2418 	if(b1Hz)
9220                     	btst	_b1Hz
9221  1b27 2503cc1aa3    	jruge	L5663
9222                     ; 2420 		b1Hz=0;
9224  1b2c 72110005      	bres	_b1Hz
9225                     ; 2422 	  pwr_hndl();		//вычисление воздействий на силу
9227  1b30 cd06f4        	call	_pwr_hndl
9229                     ; 2423 		temper_drv();			//вычисление аварий температуры
9231  1b33 cd0a43        	call	_temper_drv
9233                     ; 2424 		u_drv();
9235  1b36 cd0b1a        	call	_u_drv
9237                     ; 2426 		if(main_cnt<1000)main_cnt++;
9239  1b39 9c            	rvf
9240  1b3a ce0255        	ldw	x,_main_cnt
9241  1b3d a303e8        	cpw	x,#1000
9242  1b40 2e09          	jrsge	L3173
9245  1b42 ce0255        	ldw	x,_main_cnt
9246  1b45 1c0001        	addw	x,#1
9247  1b48 cf0255        	ldw	_main_cnt,x
9248  1b4b               L3173:
9249                     ; 2427   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9251  1b4b b66d          	ld	a,_link
9252  1b4d a1aa          	cp	a,#170
9253  1b4f 2706          	jreq	L7173
9255  1b51 b654          	ld	a,_jp_mode
9256  1b53 a103          	cp	a,#3
9257  1b55 2603          	jrne	L5173
9258  1b57               L7173:
9261  1b57 cd0c37        	call	_apv_hndl
9263  1b5a               L5173:
9264                     ; 2430   		can_error_cnt++;
9266  1b5a 3c73          	inc	_can_error_cnt
9267                     ; 2431   		if(can_error_cnt>=10)
9269  1b5c b673          	ld	a,_can_error_cnt
9270  1b5e a10a          	cp	a,#10
9271  1b60 2505          	jrult	L1273
9272                     ; 2433   			can_error_cnt=0;
9274  1b62 3f73          	clr	_can_error_cnt
9275                     ; 2434 				init_CAN();
9277  1b64 cd0f11        	call	_init_CAN
9279  1b67               L1273:
9280                     ; 2444 		vent_resurs_hndl();
9282  1b67 cd0000        	call	_vent_resurs_hndl
9284  1b6a aca31aa3      	jpf	L5663
10522                     	xdef	_main
10523                     	xdef	f_ADC2_EOC_Interrupt
10524                     	xdef	f_CAN_TX_Interrupt
10525                     	xdef	f_CAN_RX_Interrupt
10526                     	xdef	f_TIM4_UPD_Interrupt
10527                     	xdef	_adc2_init
10528                     	xdef	_t1_init
10529                     	xdef	_t4_init
10530                     	xdef	_can_in_an
10531                     	xdef	_can_tx_hndl
10532                     	xdef	_can_transmit
10533                     	xdef	_init_CAN
10534                     	xdef	_adr_drv_v3
10535                     	xdef	_adr_drv_v4
10536                     	xdef	_flags_drv
10537                     	xdef	_apv_hndl
10538                     	xdef	_apv_stop
10539                     	xdef	_apv_start
10540                     	xdef	_u_drv
10541                     	xdef	_temper_drv
10542                     	xdef	_matemat
10543                     	xdef	_pwr_hndl
10544                     	xdef	_pwr_drv
10545                     	xdef	_vent_drv
10546                     	xdef	_link_drv
10547                     	xdef	_JP_drv
10548                     	xdef	_led_drv
10549                     	xdef	_led_hndl
10550                     	xdef	_delay_ms
10551                     	xdef	_granee
10552                     	xdef	_gran
10553                     	xdef	_vent_resurs_hndl
10554                     	switch	.ubsct
10555  0001               _debug_info_to_uku:
10556  0001 000000000000  	ds.b	6
10557                     	xdef	_debug_info_to_uku
10558  0007               _pwm_u_cnt:
10559  0007 00            	ds.b	1
10560                     	xdef	_pwm_u_cnt
10561  0008               _vent_resurs_tx_cnt:
10562  0008 00            	ds.b	1
10563                     	xdef	_vent_resurs_tx_cnt
10564                     	switch	.bss
10565  0000               _vent_resurs_buff:
10566  0000 00000000      	ds.b	4
10567                     	xdef	_vent_resurs_buff
10568                     	switch	.ubsct
10569  0009               _vent_resurs_sec_cnt:
10570  0009 0000          	ds.b	2
10571                     	xdef	_vent_resurs_sec_cnt
10572                     .eeprom:	section	.data
10573  0000               _vent_resurs:
10574  0000 0000          	ds.b	2
10575                     	xdef	_vent_resurs
10576  0002               _ee_IMAXVENT:
10577  0002 0000          	ds.b	2
10578                     	xdef	_ee_IMAXVENT
10579                     	switch	.ubsct
10580  000b               _bps_class:
10581  000b 00            	ds.b	1
10582                     	xdef	_bps_class
10583  000c               _vent_pwm_integr_cnt:
10584  000c 0000          	ds.b	2
10585                     	xdef	_vent_pwm_integr_cnt
10586  000e               _vent_pwm_integr:
10587  000e 0000          	ds.b	2
10588                     	xdef	_vent_pwm_integr
10589  0010               _vent_pwm:
10590  0010 0000          	ds.b	2
10591                     	xdef	_vent_pwm
10592  0012               _pwm_vent_cnt:
10593  0012 00            	ds.b	1
10594                     	xdef	_pwm_vent_cnt
10595                     	switch	.eeprom
10596  0004               _ee_DEVICE:
10597  0004 0000          	ds.b	2
10598                     	xdef	_ee_DEVICE
10599  0006               _ee_AVT_MODE:
10600  0006 0000          	ds.b	2
10601                     	xdef	_ee_AVT_MODE
10602                     	switch	.ubsct
10603  0013               _i_main_bps_cnt:
10604  0013 000000000000  	ds.b	6
10605                     	xdef	_i_main_bps_cnt
10606  0019               _i_main_sigma:
10607  0019 0000          	ds.b	2
10608                     	xdef	_i_main_sigma
10609  001b               _i_main_num_of_bps:
10610  001b 00            	ds.b	1
10611                     	xdef	_i_main_num_of_bps
10612  001c               _i_main_avg:
10613  001c 0000          	ds.b	2
10614                     	xdef	_i_main_avg
10615  001e               _i_main_flag:
10616  001e 000000000000  	ds.b	6
10617                     	xdef	_i_main_flag
10618  0024               _i_main:
10619  0024 000000000000  	ds.b	12
10620                     	xdef	_i_main
10621  0030               _x:
10622  0030 000000000000  	ds.b	12
10623                     	xdef	_x
10624                     	xdef	_volum_u_main_
10625                     	switch	.eeprom
10626  0008               _UU_AVT:
10627  0008 0000          	ds.b	2
10628                     	xdef	_UU_AVT
10629                     	switch	.ubsct
10630  003c               _cnt_net_drv:
10631  003c 00            	ds.b	1
10632                     	xdef	_cnt_net_drv
10633                     	switch	.bit
10634  0001               _bMAIN:
10635  0001 00            	ds.b	1
10636                     	xdef	_bMAIN
10637                     	switch	.ubsct
10638  003d               _plazma_int:
10639  003d 000000000000  	ds.b	6
10640                     	xdef	_plazma_int
10641                     	xdef	_rotor_int
10642  0043               _led_green_buff:
10643  0043 00000000      	ds.b	4
10644                     	xdef	_led_green_buff
10645  0047               _led_red_buff:
10646  0047 00000000      	ds.b	4
10647                     	xdef	_led_red_buff
10648                     	xdef	_led_drv_cnt
10649                     	xdef	_led_green
10650                     	xdef	_led_red
10651  004b               _res_fl_cnt:
10652  004b 00            	ds.b	1
10653                     	xdef	_res_fl_cnt
10654                     	xdef	_bRES_
10655                     	xdef	_bRES
10656                     	switch	.eeprom
10657  000a               _res_fl_:
10658  000a 00            	ds.b	1
10659                     	xdef	_res_fl_
10660  000b               _res_fl:
10661  000b 00            	ds.b	1
10662                     	xdef	_res_fl
10663                     	switch	.ubsct
10664  004c               _cnt_apv_off:
10665  004c 00            	ds.b	1
10666                     	xdef	_cnt_apv_off
10667                     	switch	.bit
10668  0002               _bAPV:
10669  0002 00            	ds.b	1
10670                     	xdef	_bAPV
10671                     	switch	.ubsct
10672  004d               _apv_cnt_:
10673  004d 0000          	ds.b	2
10674                     	xdef	_apv_cnt_
10675  004f               _apv_cnt:
10676  004f 000000        	ds.b	3
10677                     	xdef	_apv_cnt
10678                     	xdef	_bBL_IPS
10679                     	switch	.bit
10680  0003               _bBL:
10681  0003 00            	ds.b	1
10682                     	xdef	_bBL
10683                     	switch	.ubsct
10684  0052               _cnt_JP1:
10685  0052 00            	ds.b	1
10686                     	xdef	_cnt_JP1
10687  0053               _cnt_JP0:
10688  0053 00            	ds.b	1
10689                     	xdef	_cnt_JP0
10690  0054               _jp_mode:
10691  0054 00            	ds.b	1
10692                     	xdef	_jp_mode
10693  0055               _pwm_u_:
10694  0055 0000          	ds.b	2
10695                     	xdef	_pwm_u_
10696                     	xdef	_pwm_i
10697                     	xdef	_pwm_u
10698  0057               _tmax_cnt:
10699  0057 0000          	ds.b	2
10700                     	xdef	_tmax_cnt
10701  0059               _tsign_cnt:
10702  0059 0000          	ds.b	2
10703                     	xdef	_tsign_cnt
10704                     	switch	.eeprom
10705  000c               _ee_UAVT:
10706  000c 0000          	ds.b	2
10707                     	xdef	_ee_UAVT
10708  000e               _ee_tsign:
10709  000e 0000          	ds.b	2
10710                     	xdef	_ee_tsign
10711  0010               _ee_tmax:
10712  0010 0000          	ds.b	2
10713                     	xdef	_ee_tmax
10714  0012               _ee_dU:
10715  0012 0000          	ds.b	2
10716                     	xdef	_ee_dU
10717  0014               _ee_Umax:
10718  0014 0000          	ds.b	2
10719                     	xdef	_ee_Umax
10720  0016               _ee_TZAS:
10721  0016 0000          	ds.b	2
10722                     	xdef	_ee_TZAS
10723                     	switch	.ubsct
10724  005b               _main_cnt1:
10725  005b 0000          	ds.b	2
10726                     	xdef	_main_cnt1
10727  005d               _off_bp_cnt:
10728  005d 00            	ds.b	1
10729                     	xdef	_off_bp_cnt
10730                     	xdef	_vol_i_temp_avar
10731  005e               _flags_tu_cnt_off:
10732  005e 00            	ds.b	1
10733                     	xdef	_flags_tu_cnt_off
10734  005f               _flags_tu_cnt_on:
10735  005f 00            	ds.b	1
10736                     	xdef	_flags_tu_cnt_on
10737  0060               _vol_i_temp:
10738  0060 0000          	ds.b	2
10739                     	xdef	_vol_i_temp
10740  0062               _vol_u_temp:
10741  0062 0000          	ds.b	2
10742                     	xdef	_vol_u_temp
10743                     	switch	.eeprom
10744  0018               __x_ee_:
10745  0018 0000          	ds.b	2
10746                     	xdef	__x_ee_
10747                     	switch	.ubsct
10748  0064               __x_cnt:
10749  0064 0000          	ds.b	2
10750                     	xdef	__x_cnt
10751  0066               __x__:
10752  0066 0000          	ds.b	2
10753                     	xdef	__x__
10754  0068               __x_:
10755  0068 0000          	ds.b	2
10756                     	xdef	__x_
10757  006a               _flags_tu:
10758  006a 00            	ds.b	1
10759                     	xdef	_flags_tu
10760                     	xdef	_flags
10761  006b               _link_cnt:
10762  006b 0000          	ds.b	2
10763                     	xdef	_link_cnt
10764  006d               _link:
10765  006d 00            	ds.b	1
10766                     	xdef	_link
10767  006e               _umin_cnt:
10768  006e 0000          	ds.b	2
10769                     	xdef	_umin_cnt
10770  0070               _umax_cnt:
10771  0070 0000          	ds.b	2
10772                     	xdef	_umax_cnt
10773                     	switch	.eeprom
10774  001a               _ee_K:
10775  001a 000000000000  	ds.b	20
10776                     	xdef	_ee_K
10777                     	switch	.ubsct
10778  0072               _T:
10779  0072 00            	ds.b	1
10780                     	xdef	_T
10781                     	switch	.bss
10782  0004               _Uin:
10783  0004 0000          	ds.b	2
10784                     	xdef	_Uin
10785  0006               _Usum:
10786  0006 0000          	ds.b	2
10787                     	xdef	_Usum
10788  0008               _U_out_const:
10789  0008 0000          	ds.b	2
10790                     	xdef	_U_out_const
10791  000a               _Unecc:
10792  000a 0000          	ds.b	2
10793                     	xdef	_Unecc
10794  000c               _Ui:
10795  000c 0000          	ds.b	2
10796                     	xdef	_Ui
10797  000e               _Un:
10798  000e 0000          	ds.b	2
10799                     	xdef	_Un
10800  0010               _I:
10801  0010 0000          	ds.b	2
10802                     	xdef	_I
10803                     	switch	.ubsct
10804  0073               _can_error_cnt:
10805  0073 00            	ds.b	1
10806                     	xdef	_can_error_cnt
10807                     	xdef	_bCAN_RX
10808  0074               _tx_busy_cnt:
10809  0074 00            	ds.b	1
10810                     	xdef	_tx_busy_cnt
10811                     	xdef	_bTX_FREE
10812  0075               _can_buff_rd_ptr:
10813  0075 00            	ds.b	1
10814                     	xdef	_can_buff_rd_ptr
10815  0076               _can_buff_wr_ptr:
10816  0076 00            	ds.b	1
10817                     	xdef	_can_buff_wr_ptr
10818  0077               _can_out_buff:
10819  0077 000000000000  	ds.b	64
10820                     	xdef	_can_out_buff
10821                     	switch	.bss
10822  0012               _pwm_u_buff_cnt:
10823  0012 00            	ds.b	1
10824                     	xdef	_pwm_u_buff_cnt
10825  0013               _pwm_u_buff_ptr:
10826  0013 00            	ds.b	1
10827                     	xdef	_pwm_u_buff_ptr
10828  0014               _pwm_u_buff_:
10829  0014 0000          	ds.b	2
10830                     	xdef	_pwm_u_buff_
10831  0016               _pwm_u_buff:
10832  0016 000000000000  	ds.b	64
10833                     	xdef	_pwm_u_buff
10834                     	switch	.ubsct
10835  00b7               _adc_cnt_cnt:
10836  00b7 00            	ds.b	1
10837                     	xdef	_adc_cnt_cnt
10838                     	switch	.bss
10839  0056               _adc_buff_buff:
10840  0056 000000000000  	ds.b	160
10841                     	xdef	_adc_buff_buff
10842  00f6               _adress_error:
10843  00f6 00            	ds.b	1
10844                     	xdef	_adress_error
10845  00f7               _adress:
10846  00f7 00            	ds.b	1
10847                     	xdef	_adress
10848  00f8               _adr:
10849  00f8 000000        	ds.b	3
10850                     	xdef	_adr
10851                     	xdef	_adr_drv_stat
10852                     	xdef	_led_ind
10853                     	switch	.ubsct
10854  00b8               _led_ind_cnt:
10855  00b8 00            	ds.b	1
10856                     	xdef	_led_ind_cnt
10857  00b9               _adc_plazma:
10858  00b9 000000000000  	ds.b	10
10859                     	xdef	_adc_plazma
10860  00c3               _adc_plazma_short:
10861  00c3 0000          	ds.b	2
10862                     	xdef	_adc_plazma_short
10863  00c5               _adc_cnt:
10864  00c5 00            	ds.b	1
10865                     	xdef	_adc_cnt
10866  00c6               _adc_ch:
10867  00c6 00            	ds.b	1
10868                     	xdef	_adc_ch
10869                     	switch	.bss
10870  00fb               _adc_buff_1:
10871  00fb 0000          	ds.b	2
10872                     	xdef	_adc_buff_1
10873  00fd               _adc_buff_5:
10874  00fd 0000          	ds.b	2
10875                     	xdef	_adc_buff_5
10876  00ff               _adc_buff_:
10877  00ff 000000000000  	ds.b	20
10878                     	xdef	_adc_buff_
10879  0113               _adc_buff:
10880  0113 000000000000  	ds.b	320
10881                     	xdef	_adc_buff
10882  0253               _main_cnt10:
10883  0253 0000          	ds.b	2
10884                     	xdef	_main_cnt10
10885  0255               _main_cnt:
10886  0255 0000          	ds.b	2
10887                     	xdef	_main_cnt
10888                     	switch	.ubsct
10889  00c7               _mess:
10890  00c7 000000000000  	ds.b	14
10891                     	xdef	_mess
10892                     	switch	.bit
10893  0004               _b1000Hz:
10894  0004 00            	ds.b	1
10895                     	xdef	_b1000Hz
10896  0005               _b1Hz:
10897  0005 00            	ds.b	1
10898                     	xdef	_b1Hz
10899  0006               _b2Hz:
10900  0006 00            	ds.b	1
10901                     	xdef	_b2Hz
10902  0007               _b5Hz:
10903  0007 00            	ds.b	1
10904                     	xdef	_b5Hz
10905  0008               _b10Hz:
10906  0008 00            	ds.b	1
10907                     	xdef	_b10Hz
10908  0009               _b100Hz:
10909  0009 00            	ds.b	1
10910                     	xdef	_b100Hz
10911                     	xdef	_t0_cnt4
10912                     	xdef	_t0_cnt3
10913                     	xdef	_t0_cnt2
10914                     	xdef	_t0_cnt1
10915                     	xdef	_t0_cnt0
10916                     	xdef	_t0_cnt00
10917                     	xref	_abs
10918                     	xdef	_bVENT_BLOCK
10919                     	xref.b	c_lreg
10920                     	xref.b	c_x
10921                     	xref.b	c_y
10941                     	xref	c_lrsh
10942                     	xref	c_umul
10943                     	xref	c_lgsub
10944                     	xref	c_lgrsh
10945                     	xref	c_lgadd
10946                     	xref	c_idiv
10947                     	xref	c_sdivx
10948                     	xref	c_imul
10949                     	xref	c_lsbc
10950                     	xref	c_ladd
10951                     	xref	c_lsub
10952                     	xref	c_ldiv
10953                     	xref	c_lgmul
10954                     	xref	c_itolx
10955                     	xref	c_eewrc
10956                     	xref	c_ltor
10957                     	xref	c_lgadc
10958                     	xref	c_rtol
10959                     	xref	c_vmul
10960                     	xref	c_eewrw
10961                     	xref	c_lcmp
10962                     	xref	c_uitolx
10963                     	end
