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
4796                     ; 1034 if(Unecc<0)Unecc=0;
4798  09f2 9c            	rvf
4799  09f3 ce000a        	ldw	x,_Unecc
4800  09f6 2e04          	jrsge	L7132
4803  09f8 5f            	clrw	x
4804  09f9 cf000a        	ldw	_Unecc,x
4805  09fc               L7132:
4806                     ; 1035 temp_SL=(signed long)(T-ee_tsign);
4808  09fc 5f            	clrw	x
4809  09fd b672          	ld	a,_T
4810  09ff 2a01          	jrpl	L47
4811  0a01 53            	cplw	x
4812  0a02               L47:
4813  0a02 97            	ld	xl,a
4814  0a03 72b0000e      	subw	x,_ee_tsign
4815  0a07 cd0000        	call	c_itolx
4817  0a0a 96            	ldw	x,sp
4818  0a0b 1c0005        	addw	x,#OFST-3
4819  0a0e cd0000        	call	c_rtol
4821                     ; 1036 temp_SL*=1000L;
4823  0a11 ae03e8        	ldw	x,#1000
4824  0a14 bf02          	ldw	c_lreg+2,x
4825  0a16 ae0000        	ldw	x,#0
4826  0a19 bf00          	ldw	c_lreg,x
4827  0a1b 96            	ldw	x,sp
4828  0a1c 1c0005        	addw	x,#OFST-3
4829  0a1f cd0000        	call	c_lgmul
4831                     ; 1037 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4833  0a22 ce0010        	ldw	x,_ee_tmax
4834  0a25 72b0000e      	subw	x,_ee_tsign
4835  0a29 cd0000        	call	c_itolx
4837  0a2c 96            	ldw	x,sp
4838  0a2d 1c0001        	addw	x,#OFST-7
4839  0a30 cd0000        	call	c_rtol
4841  0a33 96            	ldw	x,sp
4842  0a34 1c0005        	addw	x,#OFST-3
4843  0a37 cd0000        	call	c_ltor
4845  0a3a 96            	ldw	x,sp
4846  0a3b 1c0001        	addw	x,#OFST-7
4847  0a3e cd0000        	call	c_ldiv
4849  0a41 96            	ldw	x,sp
4850  0a42 1c0005        	addw	x,#OFST-3
4851  0a45 cd0000        	call	c_rtol
4853                     ; 1039 vol_i_temp_avar=(unsigned short)temp_SL; 
4855  0a48 1e07          	ldw	x,(OFST-1,sp)
4856  0a4a bf06          	ldw	_vol_i_temp_avar,x
4857                     ; 1041 debug_info_to_uku[0]=pwm_u;
4859  0a4c be08          	ldw	x,_pwm_u
4860  0a4e bf01          	ldw	_debug_info_to_uku,x
4861                     ; 1042 debug_info_to_uku[1]=vol_i_temp;
4863  0a50 be60          	ldw	x,_vol_i_temp
4864  0a52 bf03          	ldw	_debug_info_to_uku+2,x
4865                     ; 1044 }
4868  0a54 5b08          	addw	sp,#8
4869  0a56 81            	ret
4900                     ; 1047 void temper_drv(void)		//1 Hz
4900                     ; 1048 {
4901                     	switch	.text
4902  0a57               _temper_drv:
4906                     ; 1050 if(T>ee_tsign) tsign_cnt++;
4908  0a57 9c            	rvf
4909  0a58 5f            	clrw	x
4910  0a59 b672          	ld	a,_T
4911  0a5b 2a01          	jrpl	L001
4912  0a5d 53            	cplw	x
4913  0a5e               L001:
4914  0a5e 97            	ld	xl,a
4915  0a5f c3000e        	cpw	x,_ee_tsign
4916  0a62 2d09          	jrsle	L1332
4919  0a64 be59          	ldw	x,_tsign_cnt
4920  0a66 1c0001        	addw	x,#1
4921  0a69 bf59          	ldw	_tsign_cnt,x
4923  0a6b 201d          	jra	L3332
4924  0a6d               L1332:
4925                     ; 1051 else if (T<(ee_tsign-1)) tsign_cnt--;
4927  0a6d 9c            	rvf
4928  0a6e ce000e        	ldw	x,_ee_tsign
4929  0a71 5a            	decw	x
4930  0a72 905f          	clrw	y
4931  0a74 b672          	ld	a,_T
4932  0a76 2a02          	jrpl	L201
4933  0a78 9053          	cplw	y
4934  0a7a               L201:
4935  0a7a 9097          	ld	yl,a
4936  0a7c 90bf00        	ldw	c_y,y
4937  0a7f b300          	cpw	x,c_y
4938  0a81 2d07          	jrsle	L3332
4941  0a83 be59          	ldw	x,_tsign_cnt
4942  0a85 1d0001        	subw	x,#1
4943  0a88 bf59          	ldw	_tsign_cnt,x
4944  0a8a               L3332:
4945                     ; 1053 gran(&tsign_cnt,0,60);
4947  0a8a ae003c        	ldw	x,#60
4948  0a8d 89            	pushw	x
4949  0a8e 5f            	clrw	x
4950  0a8f 89            	pushw	x
4951  0a90 ae0059        	ldw	x,#_tsign_cnt
4952  0a93 cd00d5        	call	_gran
4954  0a96 5b04          	addw	sp,#4
4955                     ; 1055 if(tsign_cnt>=55)
4957  0a98 9c            	rvf
4958  0a99 be59          	ldw	x,_tsign_cnt
4959  0a9b a30037        	cpw	x,#55
4960  0a9e 2f16          	jrslt	L7332
4961                     ; 1057 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4963  0aa0 3d54          	tnz	_jp_mode
4964  0aa2 2606          	jrne	L5432
4966  0aa4 b605          	ld	a,_flags
4967  0aa6 a540          	bcp	a,#64
4968  0aa8 2706          	jreq	L3432
4969  0aaa               L5432:
4971  0aaa b654          	ld	a,_jp_mode
4972  0aac a103          	cp	a,#3
4973  0aae 2612          	jrne	L7432
4974  0ab0               L3432:
4977  0ab0 72140005      	bset	_flags,#2
4978  0ab4 200c          	jra	L7432
4979  0ab6               L7332:
4980                     ; 1059 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
4982  0ab6 9c            	rvf
4983  0ab7 be59          	ldw	x,_tsign_cnt
4984  0ab9 a30006        	cpw	x,#6
4985  0abc 2e04          	jrsge	L7432
4988  0abe 72150005      	bres	_flags,#2
4989  0ac2               L7432:
4990                     ; 1064 if(T>ee_tmax) tmax_cnt++;
4992  0ac2 9c            	rvf
4993  0ac3 5f            	clrw	x
4994  0ac4 b672          	ld	a,_T
4995  0ac6 2a01          	jrpl	L401
4996  0ac8 53            	cplw	x
4997  0ac9               L401:
4998  0ac9 97            	ld	xl,a
4999  0aca c30010        	cpw	x,_ee_tmax
5000  0acd 2d09          	jrsle	L3532
5003  0acf be57          	ldw	x,_tmax_cnt
5004  0ad1 1c0001        	addw	x,#1
5005  0ad4 bf57          	ldw	_tmax_cnt,x
5007  0ad6 201d          	jra	L5532
5008  0ad8               L3532:
5009                     ; 1065 else if (T<(ee_tmax-1)) tmax_cnt--;
5011  0ad8 9c            	rvf
5012  0ad9 ce0010        	ldw	x,_ee_tmax
5013  0adc 5a            	decw	x
5014  0add 905f          	clrw	y
5015  0adf b672          	ld	a,_T
5016  0ae1 2a02          	jrpl	L601
5017  0ae3 9053          	cplw	y
5018  0ae5               L601:
5019  0ae5 9097          	ld	yl,a
5020  0ae7 90bf00        	ldw	c_y,y
5021  0aea b300          	cpw	x,c_y
5022  0aec 2d07          	jrsle	L5532
5025  0aee be57          	ldw	x,_tmax_cnt
5026  0af0 1d0001        	subw	x,#1
5027  0af3 bf57          	ldw	_tmax_cnt,x
5028  0af5               L5532:
5029                     ; 1067 gran(&tmax_cnt,0,60);
5031  0af5 ae003c        	ldw	x,#60
5032  0af8 89            	pushw	x
5033  0af9 5f            	clrw	x
5034  0afa 89            	pushw	x
5035  0afb ae0057        	ldw	x,#_tmax_cnt
5036  0afe cd00d5        	call	_gran
5038  0b01 5b04          	addw	sp,#4
5039                     ; 1069 if(tmax_cnt>=55)
5041  0b03 9c            	rvf
5042  0b04 be57          	ldw	x,_tmax_cnt
5043  0b06 a30037        	cpw	x,#55
5044  0b09 2f16          	jrslt	L1632
5045                     ; 1071 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5047  0b0b 3d54          	tnz	_jp_mode
5048  0b0d 2606          	jrne	L7632
5050  0b0f b605          	ld	a,_flags
5051  0b11 a540          	bcp	a,#64
5052  0b13 2706          	jreq	L5632
5053  0b15               L7632:
5055  0b15 b654          	ld	a,_jp_mode
5056  0b17 a103          	cp	a,#3
5057  0b19 2612          	jrne	L1732
5058  0b1b               L5632:
5061  0b1b 72120005      	bset	_flags,#1
5062  0b1f 200c          	jra	L1732
5063  0b21               L1632:
5064                     ; 1073 else if (tmax_cnt<=5) flags&=0b11111101;
5066  0b21 9c            	rvf
5067  0b22 be57          	ldw	x,_tmax_cnt
5068  0b24 a30006        	cpw	x,#6
5069  0b27 2e04          	jrsge	L1732
5072  0b29 72130005      	bres	_flags,#1
5073  0b2d               L1732:
5074                     ; 1076 } 
5077  0b2d 81            	ret
5109                     ; 1079 void u_drv(void)		//1Hz
5109                     ; 1080 { 
5110                     	switch	.text
5111  0b2e               _u_drv:
5115                     ; 1081 if(jp_mode!=jp3)
5117  0b2e b654          	ld	a,_jp_mode
5118  0b30 a103          	cp	a,#3
5119  0b32 2774          	jreq	L5042
5120                     ; 1083 	if(Ui>ee_Umax)umax_cnt++;
5122  0b34 9c            	rvf
5123  0b35 ce000c        	ldw	x,_Ui
5124  0b38 c30014        	cpw	x,_ee_Umax
5125  0b3b 2d09          	jrsle	L7042
5128  0b3d be70          	ldw	x,_umax_cnt
5129  0b3f 1c0001        	addw	x,#1
5130  0b42 bf70          	ldw	_umax_cnt,x
5132  0b44 2003          	jra	L1142
5133  0b46               L7042:
5134                     ; 1084 	else umax_cnt=0;
5136  0b46 5f            	clrw	x
5137  0b47 bf70          	ldw	_umax_cnt,x
5138  0b49               L1142:
5139                     ; 1085 	gran(&umax_cnt,0,10);
5141  0b49 ae000a        	ldw	x,#10
5142  0b4c 89            	pushw	x
5143  0b4d 5f            	clrw	x
5144  0b4e 89            	pushw	x
5145  0b4f ae0070        	ldw	x,#_umax_cnt
5146  0b52 cd00d5        	call	_gran
5148  0b55 5b04          	addw	sp,#4
5149                     ; 1086 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5151  0b57 9c            	rvf
5152  0b58 be70          	ldw	x,_umax_cnt
5153  0b5a a3000a        	cpw	x,#10
5154  0b5d 2f04          	jrslt	L3142
5157  0b5f 72160005      	bset	_flags,#3
5158  0b63               L3142:
5159                     ; 1089 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5161  0b63 9c            	rvf
5162  0b64 ce000c        	ldw	x,_Ui
5163  0b67 c3000e        	cpw	x,_Un
5164  0b6a 2e1d          	jrsge	L5142
5166  0b6c 9c            	rvf
5167  0b6d ce000e        	ldw	x,_Un
5168  0b70 72b0000c      	subw	x,_Ui
5169  0b74 c30012        	cpw	x,_ee_dU
5170  0b77 2d10          	jrsle	L5142
5172  0b79 c65005        	ld	a,20485
5173  0b7c a504          	bcp	a,#4
5174  0b7e 2609          	jrne	L5142
5177  0b80 be6e          	ldw	x,_umin_cnt
5178  0b82 1c0001        	addw	x,#1
5179  0b85 bf6e          	ldw	_umin_cnt,x
5181  0b87 2003          	jra	L7142
5182  0b89               L5142:
5183                     ; 1090 	else umin_cnt=0;
5185  0b89 5f            	clrw	x
5186  0b8a bf6e          	ldw	_umin_cnt,x
5187  0b8c               L7142:
5188                     ; 1091 	gran(&umin_cnt,0,10);	
5190  0b8c ae000a        	ldw	x,#10
5191  0b8f 89            	pushw	x
5192  0b90 5f            	clrw	x
5193  0b91 89            	pushw	x
5194  0b92 ae006e        	ldw	x,#_umin_cnt
5195  0b95 cd00d5        	call	_gran
5197  0b98 5b04          	addw	sp,#4
5198                     ; 1092 	if(umin_cnt>=10)flags|=0b00010000;	  
5200  0b9a 9c            	rvf
5201  0b9b be6e          	ldw	x,_umin_cnt
5202  0b9d a3000a        	cpw	x,#10
5203  0ba0 2f71          	jrslt	L3242
5206  0ba2 72180005      	bset	_flags,#4
5207  0ba6 206b          	jra	L3242
5208  0ba8               L5042:
5209                     ; 1094 else if(jp_mode==jp3)
5211  0ba8 b654          	ld	a,_jp_mode
5212  0baa a103          	cp	a,#3
5213  0bac 2665          	jrne	L3242
5214                     ; 1096 	if(Ui>700)umax_cnt++;
5216  0bae 9c            	rvf
5217  0baf ce000c        	ldw	x,_Ui
5218  0bb2 a302bd        	cpw	x,#701
5219  0bb5 2f09          	jrslt	L7242
5222  0bb7 be70          	ldw	x,_umax_cnt
5223  0bb9 1c0001        	addw	x,#1
5224  0bbc bf70          	ldw	_umax_cnt,x
5226  0bbe 2003          	jra	L1342
5227  0bc0               L7242:
5228                     ; 1097 	else umax_cnt=0;
5230  0bc0 5f            	clrw	x
5231  0bc1 bf70          	ldw	_umax_cnt,x
5232  0bc3               L1342:
5233                     ; 1098 	gran(&umax_cnt,0,10);
5235  0bc3 ae000a        	ldw	x,#10
5236  0bc6 89            	pushw	x
5237  0bc7 5f            	clrw	x
5238  0bc8 89            	pushw	x
5239  0bc9 ae0070        	ldw	x,#_umax_cnt
5240  0bcc cd00d5        	call	_gran
5242  0bcf 5b04          	addw	sp,#4
5243                     ; 1099 	if(umax_cnt>=10)flags|=0b00001000;
5245  0bd1 9c            	rvf
5246  0bd2 be70          	ldw	x,_umax_cnt
5247  0bd4 a3000a        	cpw	x,#10
5248  0bd7 2f04          	jrslt	L3342
5251  0bd9 72160005      	bset	_flags,#3
5252  0bdd               L3342:
5253                     ; 1102 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5255  0bdd 9c            	rvf
5256  0bde ce000c        	ldw	x,_Ui
5257  0be1 a300c8        	cpw	x,#200
5258  0be4 2e10          	jrsge	L5342
5260  0be6 c65005        	ld	a,20485
5261  0be9 a504          	bcp	a,#4
5262  0beb 2609          	jrne	L5342
5265  0bed be6e          	ldw	x,_umin_cnt
5266  0bef 1c0001        	addw	x,#1
5267  0bf2 bf6e          	ldw	_umin_cnt,x
5269  0bf4 2003          	jra	L7342
5270  0bf6               L5342:
5271                     ; 1103 	else umin_cnt=0;
5273  0bf6 5f            	clrw	x
5274  0bf7 bf6e          	ldw	_umin_cnt,x
5275  0bf9               L7342:
5276                     ; 1104 	gran(&umin_cnt,0,10);	
5278  0bf9 ae000a        	ldw	x,#10
5279  0bfc 89            	pushw	x
5280  0bfd 5f            	clrw	x
5281  0bfe 89            	pushw	x
5282  0bff ae006e        	ldw	x,#_umin_cnt
5283  0c02 cd00d5        	call	_gran
5285  0c05 5b04          	addw	sp,#4
5286                     ; 1105 	if(umin_cnt>=10)flags|=0b00010000;	  
5288  0c07 9c            	rvf
5289  0c08 be6e          	ldw	x,_umin_cnt
5290  0c0a a3000a        	cpw	x,#10
5291  0c0d 2f04          	jrslt	L3242
5294  0c0f 72180005      	bset	_flags,#4
5295  0c13               L3242:
5296                     ; 1107 }
5299  0c13 81            	ret
5325                     ; 1132 void apv_start(void)
5325                     ; 1133 {
5326                     	switch	.text
5327  0c14               _apv_start:
5331                     ; 1134 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5333  0c14 3d4f          	tnz	_apv_cnt
5334  0c16 2624          	jrne	L3542
5336  0c18 3d50          	tnz	_apv_cnt+1
5337  0c1a 2620          	jrne	L3542
5339  0c1c 3d51          	tnz	_apv_cnt+2
5340  0c1e 261c          	jrne	L3542
5342                     	btst	_bAPV
5343  0c25 2515          	jrult	L3542
5344                     ; 1136 	apv_cnt[0]=60;
5346  0c27 353c004f      	mov	_apv_cnt,#60
5347                     ; 1137 	apv_cnt[1]=60;
5349  0c2b 353c0050      	mov	_apv_cnt+1,#60
5350                     ; 1138 	apv_cnt[2]=60;
5352  0c2f 353c0051      	mov	_apv_cnt+2,#60
5353                     ; 1139 	apv_cnt_=3600;
5355  0c33 ae0e10        	ldw	x,#3600
5356  0c36 bf4d          	ldw	_apv_cnt_,x
5357                     ; 1140 	bAPV=1;	
5359  0c38 72100002      	bset	_bAPV
5360  0c3c               L3542:
5361                     ; 1142 }
5364  0c3c 81            	ret
5390                     ; 1145 void apv_stop(void)
5390                     ; 1146 {
5391                     	switch	.text
5392  0c3d               _apv_stop:
5396                     ; 1147 apv_cnt[0]=0;
5398  0c3d 3f4f          	clr	_apv_cnt
5399                     ; 1148 apv_cnt[1]=0;
5401  0c3f 3f50          	clr	_apv_cnt+1
5402                     ; 1149 apv_cnt[2]=0;
5404  0c41 3f51          	clr	_apv_cnt+2
5405                     ; 1150 apv_cnt_=0;	
5407  0c43 5f            	clrw	x
5408  0c44 bf4d          	ldw	_apv_cnt_,x
5409                     ; 1151 bAPV=0;
5411  0c46 72110002      	bres	_bAPV
5412                     ; 1152 }
5415  0c4a 81            	ret
5450                     ; 1156 void apv_hndl(void)
5450                     ; 1157 {
5451                     	switch	.text
5452  0c4b               _apv_hndl:
5456                     ; 1158 if(apv_cnt[0])
5458  0c4b 3d4f          	tnz	_apv_cnt
5459  0c4d 271e          	jreq	L5742
5460                     ; 1160 	apv_cnt[0]--;
5462  0c4f 3a4f          	dec	_apv_cnt
5463                     ; 1161 	if(apv_cnt[0]==0)
5465  0c51 3d4f          	tnz	_apv_cnt
5466  0c53 265a          	jrne	L1052
5467                     ; 1163 		flags&=0b11100001;
5469  0c55 b605          	ld	a,_flags
5470  0c57 a4e1          	and	a,#225
5471  0c59 b705          	ld	_flags,a
5472                     ; 1164 		tsign_cnt=0;
5474  0c5b 5f            	clrw	x
5475  0c5c bf59          	ldw	_tsign_cnt,x
5476                     ; 1165 		tmax_cnt=0;
5478  0c5e 5f            	clrw	x
5479  0c5f bf57          	ldw	_tmax_cnt,x
5480                     ; 1166 		umax_cnt=0;
5482  0c61 5f            	clrw	x
5483  0c62 bf70          	ldw	_umax_cnt,x
5484                     ; 1167 		umin_cnt=0;
5486  0c64 5f            	clrw	x
5487  0c65 bf6e          	ldw	_umin_cnt,x
5488                     ; 1169 		led_drv_cnt=30;
5490  0c67 351e0016      	mov	_led_drv_cnt,#30
5491  0c6b 2042          	jra	L1052
5492  0c6d               L5742:
5493                     ; 1172 else if(apv_cnt[1])
5495  0c6d 3d50          	tnz	_apv_cnt+1
5496  0c6f 271e          	jreq	L3052
5497                     ; 1174 	apv_cnt[1]--;
5499  0c71 3a50          	dec	_apv_cnt+1
5500                     ; 1175 	if(apv_cnt[1]==0)
5502  0c73 3d50          	tnz	_apv_cnt+1
5503  0c75 2638          	jrne	L1052
5504                     ; 1177 		flags&=0b11100001;
5506  0c77 b605          	ld	a,_flags
5507  0c79 a4e1          	and	a,#225
5508  0c7b b705          	ld	_flags,a
5509                     ; 1178 		tsign_cnt=0;
5511  0c7d 5f            	clrw	x
5512  0c7e bf59          	ldw	_tsign_cnt,x
5513                     ; 1179 		tmax_cnt=0;
5515  0c80 5f            	clrw	x
5516  0c81 bf57          	ldw	_tmax_cnt,x
5517                     ; 1180 		umax_cnt=0;
5519  0c83 5f            	clrw	x
5520  0c84 bf70          	ldw	_umax_cnt,x
5521                     ; 1181 		umin_cnt=0;
5523  0c86 5f            	clrw	x
5524  0c87 bf6e          	ldw	_umin_cnt,x
5525                     ; 1183 		led_drv_cnt=30;
5527  0c89 351e0016      	mov	_led_drv_cnt,#30
5528  0c8d 2020          	jra	L1052
5529  0c8f               L3052:
5530                     ; 1186 else if(apv_cnt[2])
5532  0c8f 3d51          	tnz	_apv_cnt+2
5533  0c91 271c          	jreq	L1052
5534                     ; 1188 	apv_cnt[2]--;
5536  0c93 3a51          	dec	_apv_cnt+2
5537                     ; 1189 	if(apv_cnt[2]==0)
5539  0c95 3d51          	tnz	_apv_cnt+2
5540  0c97 2616          	jrne	L1052
5541                     ; 1191 		flags&=0b11100001;
5543  0c99 b605          	ld	a,_flags
5544  0c9b a4e1          	and	a,#225
5545  0c9d b705          	ld	_flags,a
5546                     ; 1192 		tsign_cnt=0;
5548  0c9f 5f            	clrw	x
5549  0ca0 bf59          	ldw	_tsign_cnt,x
5550                     ; 1193 		tmax_cnt=0;
5552  0ca2 5f            	clrw	x
5553  0ca3 bf57          	ldw	_tmax_cnt,x
5554                     ; 1194 		umax_cnt=0;
5556  0ca5 5f            	clrw	x
5557  0ca6 bf70          	ldw	_umax_cnt,x
5558                     ; 1195 		umin_cnt=0;          
5560  0ca8 5f            	clrw	x
5561  0ca9 bf6e          	ldw	_umin_cnt,x
5562                     ; 1197 		led_drv_cnt=30;
5564  0cab 351e0016      	mov	_led_drv_cnt,#30
5565  0caf               L1052:
5566                     ; 1201 if(apv_cnt_)
5568  0caf be4d          	ldw	x,_apv_cnt_
5569  0cb1 2712          	jreq	L5152
5570                     ; 1203 	apv_cnt_--;
5572  0cb3 be4d          	ldw	x,_apv_cnt_
5573  0cb5 1d0001        	subw	x,#1
5574  0cb8 bf4d          	ldw	_apv_cnt_,x
5575                     ; 1204 	if(apv_cnt_==0) 
5577  0cba be4d          	ldw	x,_apv_cnt_
5578  0cbc 2607          	jrne	L5152
5579                     ; 1206 		bAPV=0;
5581  0cbe 72110002      	bres	_bAPV
5582                     ; 1207 		apv_start();
5584  0cc2 cd0c14        	call	_apv_start
5586  0cc5               L5152:
5587                     ; 1211 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5589  0cc5 be6e          	ldw	x,_umin_cnt
5590  0cc7 261e          	jrne	L1252
5592  0cc9 be70          	ldw	x,_umax_cnt
5593  0ccb 261a          	jrne	L1252
5595  0ccd c65005        	ld	a,20485
5596  0cd0 a504          	bcp	a,#4
5597  0cd2 2613          	jrne	L1252
5598                     ; 1213 	if(cnt_apv_off<20)
5600  0cd4 b64c          	ld	a,_cnt_apv_off
5601  0cd6 a114          	cp	a,#20
5602  0cd8 240f          	jruge	L7252
5603                     ; 1215 		cnt_apv_off++;
5605  0cda 3c4c          	inc	_cnt_apv_off
5606                     ; 1216 		if(cnt_apv_off>=20)
5608  0cdc b64c          	ld	a,_cnt_apv_off
5609  0cde a114          	cp	a,#20
5610  0ce0 2507          	jrult	L7252
5611                     ; 1218 			apv_stop();
5613  0ce2 cd0c3d        	call	_apv_stop
5615  0ce5 2002          	jra	L7252
5616  0ce7               L1252:
5617                     ; 1222 else cnt_apv_off=0;	
5619  0ce7 3f4c          	clr	_cnt_apv_off
5620  0ce9               L7252:
5621                     ; 1224 }
5624  0ce9 81            	ret
5627                     	switch	.ubsct
5628  0000               L1352_flags_old:
5629  0000 00            	ds.b	1
5665                     ; 1227 void flags_drv(void)
5665                     ; 1228 {
5666                     	switch	.text
5667  0cea               _flags_drv:
5671                     ; 1230 if(jp_mode!=jp3) 
5673  0cea b654          	ld	a,_jp_mode
5674  0cec a103          	cp	a,#3
5675  0cee 2723          	jreq	L1552
5676                     ; 1232 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5678  0cf0 b605          	ld	a,_flags
5679  0cf2 a508          	bcp	a,#8
5680  0cf4 2706          	jreq	L7552
5682  0cf6 b600          	ld	a,L1352_flags_old
5683  0cf8 a508          	bcp	a,#8
5684  0cfa 270c          	jreq	L5552
5685  0cfc               L7552:
5687  0cfc b605          	ld	a,_flags
5688  0cfe a510          	bcp	a,#16
5689  0d00 2726          	jreq	L3652
5691  0d02 b600          	ld	a,L1352_flags_old
5692  0d04 a510          	bcp	a,#16
5693  0d06 2620          	jrne	L3652
5694  0d08               L5552:
5695                     ; 1234     		if(link==OFF)apv_start();
5697  0d08 b66d          	ld	a,_link
5698  0d0a a1aa          	cp	a,#170
5699  0d0c 261a          	jrne	L3652
5702  0d0e cd0c14        	call	_apv_start
5704  0d11 2015          	jra	L3652
5705  0d13               L1552:
5706                     ; 1237 else if(jp_mode==jp3) 
5708  0d13 b654          	ld	a,_jp_mode
5709  0d15 a103          	cp	a,#3
5710  0d17 260f          	jrne	L3652
5711                     ; 1239 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5713  0d19 b605          	ld	a,_flags
5714  0d1b a508          	bcp	a,#8
5715  0d1d 2709          	jreq	L3652
5717  0d1f b600          	ld	a,L1352_flags_old
5718  0d21 a508          	bcp	a,#8
5719  0d23 2603          	jrne	L3652
5720                     ; 1241     		apv_start();
5722  0d25 cd0c14        	call	_apv_start
5724  0d28               L3652:
5725                     ; 1244 flags_old=flags;
5727  0d28 450500        	mov	L1352_flags_old,_flags
5728                     ; 1246 } 
5731  0d2b 81            	ret
5766                     ; 1383 void adr_drv_v4(char in)
5766                     ; 1384 {
5767                     	switch	.text
5768  0d2c               _adr_drv_v4:
5772                     ; 1385 if(adress!=in)adress=in;
5774  0d2c c100f7        	cp	a,_adress
5775  0d2f 2703          	jreq	L7062
5778  0d31 c700f7        	ld	_adress,a
5779  0d34               L7062:
5780                     ; 1386 }
5783  0d34 81            	ret
5812                     ; 1389 void adr_drv_v3(void)
5812                     ; 1390 {
5813                     	switch	.text
5814  0d35               _adr_drv_v3:
5816  0d35 88            	push	a
5817       00000001      OFST:	set	1
5820                     ; 1396 GPIOB->DDR&=~(1<<0);
5822  0d36 72115007      	bres	20487,#0
5823                     ; 1397 GPIOB->CR1&=~(1<<0);
5825  0d3a 72115008      	bres	20488,#0
5826                     ; 1398 GPIOB->CR2&=~(1<<0);
5828  0d3e 72115009      	bres	20489,#0
5829                     ; 1399 ADC2->CR2=0x08;
5831  0d42 35085402      	mov	21506,#8
5832                     ; 1400 ADC2->CR1=0x40;
5834  0d46 35405401      	mov	21505,#64
5835                     ; 1401 ADC2->CSR=0x20+0;
5837  0d4a 35205400      	mov	21504,#32
5838                     ; 1402 ADC2->CR1|=1;
5840  0d4e 72105401      	bset	21505,#0
5841                     ; 1403 ADC2->CR1|=1;
5843  0d52 72105401      	bset	21505,#0
5844                     ; 1404 adr_drv_stat=1;
5846  0d56 35010002      	mov	_adr_drv_stat,#1
5847  0d5a               L1262:
5848                     ; 1405 while(adr_drv_stat==1);
5851  0d5a b602          	ld	a,_adr_drv_stat
5852  0d5c a101          	cp	a,#1
5853  0d5e 27fa          	jreq	L1262
5854                     ; 1407 GPIOB->DDR&=~(1<<1);
5856  0d60 72135007      	bres	20487,#1
5857                     ; 1408 GPIOB->CR1&=~(1<<1);
5859  0d64 72135008      	bres	20488,#1
5860                     ; 1409 GPIOB->CR2&=~(1<<1);
5862  0d68 72135009      	bres	20489,#1
5863                     ; 1410 ADC2->CR2=0x08;
5865  0d6c 35085402      	mov	21506,#8
5866                     ; 1411 ADC2->CR1=0x40;
5868  0d70 35405401      	mov	21505,#64
5869                     ; 1412 ADC2->CSR=0x20+1;
5871  0d74 35215400      	mov	21504,#33
5872                     ; 1413 ADC2->CR1|=1;
5874  0d78 72105401      	bset	21505,#0
5875                     ; 1414 ADC2->CR1|=1;
5877  0d7c 72105401      	bset	21505,#0
5878                     ; 1415 adr_drv_stat=3;
5880  0d80 35030002      	mov	_adr_drv_stat,#3
5881  0d84               L7262:
5882                     ; 1416 while(adr_drv_stat==3);
5885  0d84 b602          	ld	a,_adr_drv_stat
5886  0d86 a103          	cp	a,#3
5887  0d88 27fa          	jreq	L7262
5888                     ; 1418 GPIOE->DDR&=~(1<<6);
5890  0d8a 721d5016      	bres	20502,#6
5891                     ; 1419 GPIOE->CR1&=~(1<<6);
5893  0d8e 721d5017      	bres	20503,#6
5894                     ; 1420 GPIOE->CR2&=~(1<<6);
5896  0d92 721d5018      	bres	20504,#6
5897                     ; 1421 ADC2->CR2=0x08;
5899  0d96 35085402      	mov	21506,#8
5900                     ; 1422 ADC2->CR1=0x40;
5902  0d9a 35405401      	mov	21505,#64
5903                     ; 1423 ADC2->CSR=0x20+9;
5905  0d9e 35295400      	mov	21504,#41
5906                     ; 1424 ADC2->CR1|=1;
5908  0da2 72105401      	bset	21505,#0
5909                     ; 1425 ADC2->CR1|=1;
5911  0da6 72105401      	bset	21505,#0
5912                     ; 1426 adr_drv_stat=5;
5914  0daa 35050002      	mov	_adr_drv_stat,#5
5915  0dae               L5362:
5916                     ; 1427 while(adr_drv_stat==5);
5919  0dae b602          	ld	a,_adr_drv_stat
5920  0db0 a105          	cp	a,#5
5921  0db2 27fa          	jreq	L5362
5922                     ; 1431 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5924  0db4 9c            	rvf
5925  0db5 ce00ff        	ldw	x,_adc_buff_
5926  0db8 a3022a        	cpw	x,#554
5927  0dbb 2f0f          	jrslt	L3462
5929  0dbd 9c            	rvf
5930  0dbe ce00ff        	ldw	x,_adc_buff_
5931  0dc1 a30253        	cpw	x,#595
5932  0dc4 2e06          	jrsge	L3462
5935  0dc6 725f00f8      	clr	_adr
5937  0dca 204c          	jra	L5462
5938  0dcc               L3462:
5939                     ; 1432 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5941  0dcc 9c            	rvf
5942  0dcd ce00ff        	ldw	x,_adc_buff_
5943  0dd0 a3036d        	cpw	x,#877
5944  0dd3 2f0f          	jrslt	L7462
5946  0dd5 9c            	rvf
5947  0dd6 ce00ff        	ldw	x,_adc_buff_
5948  0dd9 a30396        	cpw	x,#918
5949  0ddc 2e06          	jrsge	L7462
5952  0dde 350100f8      	mov	_adr,#1
5954  0de2 2034          	jra	L5462
5955  0de4               L7462:
5956                     ; 1433 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5958  0de4 9c            	rvf
5959  0de5 ce00ff        	ldw	x,_adc_buff_
5960  0de8 a302a3        	cpw	x,#675
5961  0deb 2f0f          	jrslt	L3562
5963  0ded 9c            	rvf
5964  0dee ce00ff        	ldw	x,_adc_buff_
5965  0df1 a302cc        	cpw	x,#716
5966  0df4 2e06          	jrsge	L3562
5969  0df6 350200f8      	mov	_adr,#2
5971  0dfa 201c          	jra	L5462
5972  0dfc               L3562:
5973                     ; 1434 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5975  0dfc 9c            	rvf
5976  0dfd ce00ff        	ldw	x,_adc_buff_
5977  0e00 a303e3        	cpw	x,#995
5978  0e03 2f0f          	jrslt	L7562
5980  0e05 9c            	rvf
5981  0e06 ce00ff        	ldw	x,_adc_buff_
5982  0e09 a3040c        	cpw	x,#1036
5983  0e0c 2e06          	jrsge	L7562
5986  0e0e 350300f8      	mov	_adr,#3
5988  0e12 2004          	jra	L5462
5989  0e14               L7562:
5990                     ; 1435 else adr[0]=5;
5992  0e14 350500f8      	mov	_adr,#5
5993  0e18               L5462:
5994                     ; 1437 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5996  0e18 9c            	rvf
5997  0e19 ce0101        	ldw	x,_adc_buff_+2
5998  0e1c a3022a        	cpw	x,#554
5999  0e1f 2f0f          	jrslt	L3662
6001  0e21 9c            	rvf
6002  0e22 ce0101        	ldw	x,_adc_buff_+2
6003  0e25 a30253        	cpw	x,#595
6004  0e28 2e06          	jrsge	L3662
6007  0e2a 725f00f9      	clr	_adr+1
6009  0e2e 204c          	jra	L5662
6010  0e30               L3662:
6011                     ; 1438 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6013  0e30 9c            	rvf
6014  0e31 ce0101        	ldw	x,_adc_buff_+2
6015  0e34 a3036d        	cpw	x,#877
6016  0e37 2f0f          	jrslt	L7662
6018  0e39 9c            	rvf
6019  0e3a ce0101        	ldw	x,_adc_buff_+2
6020  0e3d a30396        	cpw	x,#918
6021  0e40 2e06          	jrsge	L7662
6024  0e42 350100f9      	mov	_adr+1,#1
6026  0e46 2034          	jra	L5662
6027  0e48               L7662:
6028                     ; 1439 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6030  0e48 9c            	rvf
6031  0e49 ce0101        	ldw	x,_adc_buff_+2
6032  0e4c a302a3        	cpw	x,#675
6033  0e4f 2f0f          	jrslt	L3762
6035  0e51 9c            	rvf
6036  0e52 ce0101        	ldw	x,_adc_buff_+2
6037  0e55 a302cc        	cpw	x,#716
6038  0e58 2e06          	jrsge	L3762
6041  0e5a 350200f9      	mov	_adr+1,#2
6043  0e5e 201c          	jra	L5662
6044  0e60               L3762:
6045                     ; 1440 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6047  0e60 9c            	rvf
6048  0e61 ce0101        	ldw	x,_adc_buff_+2
6049  0e64 a303e3        	cpw	x,#995
6050  0e67 2f0f          	jrslt	L7762
6052  0e69 9c            	rvf
6053  0e6a ce0101        	ldw	x,_adc_buff_+2
6054  0e6d a3040c        	cpw	x,#1036
6055  0e70 2e06          	jrsge	L7762
6058  0e72 350300f9      	mov	_adr+1,#3
6060  0e76 2004          	jra	L5662
6061  0e78               L7762:
6062                     ; 1441 else adr[1]=5;
6064  0e78 350500f9      	mov	_adr+1,#5
6065  0e7c               L5662:
6066                     ; 1443 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6068  0e7c 9c            	rvf
6069  0e7d ce0111        	ldw	x,_adc_buff_+18
6070  0e80 a3022a        	cpw	x,#554
6071  0e83 2f0f          	jrslt	L3072
6073  0e85 9c            	rvf
6074  0e86 ce0111        	ldw	x,_adc_buff_+18
6075  0e89 a30253        	cpw	x,#595
6076  0e8c 2e06          	jrsge	L3072
6079  0e8e 725f00fa      	clr	_adr+2
6081  0e92 204c          	jra	L5072
6082  0e94               L3072:
6083                     ; 1444 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6085  0e94 9c            	rvf
6086  0e95 ce0111        	ldw	x,_adc_buff_+18
6087  0e98 a3036d        	cpw	x,#877
6088  0e9b 2f0f          	jrslt	L7072
6090  0e9d 9c            	rvf
6091  0e9e ce0111        	ldw	x,_adc_buff_+18
6092  0ea1 a30396        	cpw	x,#918
6093  0ea4 2e06          	jrsge	L7072
6096  0ea6 350100fa      	mov	_adr+2,#1
6098  0eaa 2034          	jra	L5072
6099  0eac               L7072:
6100                     ; 1445 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6102  0eac 9c            	rvf
6103  0ead ce0111        	ldw	x,_adc_buff_+18
6104  0eb0 a302a3        	cpw	x,#675
6105  0eb3 2f0f          	jrslt	L3172
6107  0eb5 9c            	rvf
6108  0eb6 ce0111        	ldw	x,_adc_buff_+18
6109  0eb9 a302cc        	cpw	x,#716
6110  0ebc 2e06          	jrsge	L3172
6113  0ebe 350200fa      	mov	_adr+2,#2
6115  0ec2 201c          	jra	L5072
6116  0ec4               L3172:
6117                     ; 1446 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6119  0ec4 9c            	rvf
6120  0ec5 ce0111        	ldw	x,_adc_buff_+18
6121  0ec8 a303e3        	cpw	x,#995
6122  0ecb 2f0f          	jrslt	L7172
6124  0ecd 9c            	rvf
6125  0ece ce0111        	ldw	x,_adc_buff_+18
6126  0ed1 a3040c        	cpw	x,#1036
6127  0ed4 2e06          	jrsge	L7172
6130  0ed6 350300fa      	mov	_adr+2,#3
6132  0eda 2004          	jra	L5072
6133  0edc               L7172:
6134                     ; 1447 else adr[2]=5;
6136  0edc 350500fa      	mov	_adr+2,#5
6137  0ee0               L5072:
6138                     ; 1451 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6140  0ee0 c600f8        	ld	a,_adr
6141  0ee3 a105          	cp	a,#5
6142  0ee5 270e          	jreq	L5272
6144  0ee7 c600f9        	ld	a,_adr+1
6145  0eea a105          	cp	a,#5
6146  0eec 2707          	jreq	L5272
6148  0eee c600fa        	ld	a,_adr+2
6149  0ef1 a105          	cp	a,#5
6150  0ef3 2606          	jrne	L3272
6151  0ef5               L5272:
6152                     ; 1454 	adress_error=1;
6154  0ef5 350100f6      	mov	_adress_error,#1
6156  0ef9               L1372:
6157                     ; 1465 }
6160  0ef9 84            	pop	a
6161  0efa 81            	ret
6162  0efb               L3272:
6163                     ; 1458 	if(adr[2]&0x02) bps_class=bpsIPS;
6165  0efb c600fa        	ld	a,_adr+2
6166  0efe a502          	bcp	a,#2
6167  0f00 2706          	jreq	L3372
6170  0f02 3501000b      	mov	_bps_class,#1
6172  0f06 2002          	jra	L5372
6173  0f08               L3372:
6174                     ; 1459 	else bps_class=bpsIBEP;
6176  0f08 3f0b          	clr	_bps_class
6177  0f0a               L5372:
6178                     ; 1461 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6180  0f0a c600fa        	ld	a,_adr+2
6181  0f0d a401          	and	a,#1
6182  0f0f 97            	ld	xl,a
6183  0f10 a610          	ld	a,#16
6184  0f12 42            	mul	x,a
6185  0f13 9f            	ld	a,xl
6186  0f14 6b01          	ld	(OFST+0,sp),a
6187  0f16 c600f9        	ld	a,_adr+1
6188  0f19 48            	sll	a
6189  0f1a 48            	sll	a
6190  0f1b cb00f8        	add	a,_adr
6191  0f1e 1b01          	add	a,(OFST+0,sp)
6192  0f20 c700f7        	ld	_adress,a
6193  0f23 20d4          	jra	L1372
6216                     ; 1515 void init_CAN(void) {
6217                     	switch	.text
6218  0f25               _init_CAN:
6222                     ; 1516 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6224  0f25 72135420      	bres	21536,#1
6225                     ; 1517 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6227  0f29 72105420      	bset	21536,#0
6229  0f2d               L1572:
6230                     ; 1518 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6232  0f2d c65421        	ld	a,21537
6233  0f30 a501          	bcp	a,#1
6234  0f32 27f9          	jreq	L1572
6235                     ; 1520 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6237  0f34 72185420      	bset	21536,#4
6238                     ; 1522 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6240  0f38 35025427      	mov	21543,#2
6241                     ; 1531 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6243  0f3c 35135428      	mov	21544,#19
6244                     ; 1532 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6246  0f40 35c05429      	mov	21545,#192
6247                     ; 1533 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6249  0f44 357f542c      	mov	21548,#127
6250                     ; 1534 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6252  0f48 35e0542d      	mov	21549,#224
6253                     ; 1536 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6255  0f4c 35315430      	mov	21552,#49
6256                     ; 1537 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6258  0f50 35c05431      	mov	21553,#192
6259                     ; 1538 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6261  0f54 357f5434      	mov	21556,#127
6262                     ; 1539 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6264  0f58 35e05435      	mov	21557,#224
6265                     ; 1543 	CAN->PSR= 6;									// set page 6
6267  0f5c 35065427      	mov	21543,#6
6268                     ; 1548 	CAN->Page.Config.FMR1&=~3;								//mask mode
6270  0f60 c65430        	ld	a,21552
6271  0f63 a4fc          	and	a,#252
6272  0f65 c75430        	ld	21552,a
6273                     ; 1554 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6275  0f68 35065432      	mov	21554,#6
6276                     ; 1555 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6278  0f6c 35605432      	mov	21554,#96
6279                     ; 1558 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6281  0f70 72105432      	bset	21554,#0
6282                     ; 1559 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6284  0f74 72185432      	bset	21554,#4
6285                     ; 1562 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6287  0f78 35065427      	mov	21543,#6
6288                     ; 1564 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6290  0f7c 35d3542c      	mov	21548,#211
6291                     ; 1565 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6293  0f80 35e7542d      	mov	21549,#231
6294                     ; 1567 	CAN->IER|=(1<<1);
6296  0f84 72125425      	bset	21541,#1
6297                     ; 1570 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6299  0f88 72115420      	bres	21536,#0
6301  0f8c               L7572:
6302                     ; 1571 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6304  0f8c c65421        	ld	a,21537
6305  0f8f a501          	bcp	a,#1
6306  0f91 26f9          	jrne	L7572
6307                     ; 1572 }
6310  0f93 81            	ret
6418                     ; 1575 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6418                     ; 1576 {
6419                     	switch	.text
6420  0f94               _can_transmit:
6422  0f94 89            	pushw	x
6423       00000000      OFST:	set	0
6426                     ; 1578 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6428  0f95 b676          	ld	a,_can_buff_wr_ptr
6429  0f97 a104          	cp	a,#4
6430  0f99 2502          	jrult	L1403
6433  0f9b 3f76          	clr	_can_buff_wr_ptr
6434  0f9d               L1403:
6435                     ; 1580 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6437  0f9d b676          	ld	a,_can_buff_wr_ptr
6438  0f9f 97            	ld	xl,a
6439  0fa0 a610          	ld	a,#16
6440  0fa2 42            	mul	x,a
6441  0fa3 1601          	ldw	y,(OFST+1,sp)
6442  0fa5 a606          	ld	a,#6
6443  0fa7               L231:
6444  0fa7 9054          	srlw	y
6445  0fa9 4a            	dec	a
6446  0faa 26fb          	jrne	L231
6447  0fac 909f          	ld	a,yl
6448  0fae e777          	ld	(_can_out_buff,x),a
6449                     ; 1581 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6451  0fb0 b676          	ld	a,_can_buff_wr_ptr
6452  0fb2 97            	ld	xl,a
6453  0fb3 a610          	ld	a,#16
6454  0fb5 42            	mul	x,a
6455  0fb6 7b02          	ld	a,(OFST+2,sp)
6456  0fb8 48            	sll	a
6457  0fb9 48            	sll	a
6458  0fba e778          	ld	(_can_out_buff+1,x),a
6459                     ; 1583 can_out_buff[can_buff_wr_ptr][2]=data0;
6461  0fbc b676          	ld	a,_can_buff_wr_ptr
6462  0fbe 97            	ld	xl,a
6463  0fbf a610          	ld	a,#16
6464  0fc1 42            	mul	x,a
6465  0fc2 7b05          	ld	a,(OFST+5,sp)
6466  0fc4 e779          	ld	(_can_out_buff+2,x),a
6467                     ; 1584 can_out_buff[can_buff_wr_ptr][3]=data1;
6469  0fc6 b676          	ld	a,_can_buff_wr_ptr
6470  0fc8 97            	ld	xl,a
6471  0fc9 a610          	ld	a,#16
6472  0fcb 42            	mul	x,a
6473  0fcc 7b06          	ld	a,(OFST+6,sp)
6474  0fce e77a          	ld	(_can_out_buff+3,x),a
6475                     ; 1585 can_out_buff[can_buff_wr_ptr][4]=data2;
6477  0fd0 b676          	ld	a,_can_buff_wr_ptr
6478  0fd2 97            	ld	xl,a
6479  0fd3 a610          	ld	a,#16
6480  0fd5 42            	mul	x,a
6481  0fd6 7b07          	ld	a,(OFST+7,sp)
6482  0fd8 e77b          	ld	(_can_out_buff+4,x),a
6483                     ; 1586 can_out_buff[can_buff_wr_ptr][5]=data3;
6485  0fda b676          	ld	a,_can_buff_wr_ptr
6486  0fdc 97            	ld	xl,a
6487  0fdd a610          	ld	a,#16
6488  0fdf 42            	mul	x,a
6489  0fe0 7b08          	ld	a,(OFST+8,sp)
6490  0fe2 e77c          	ld	(_can_out_buff+5,x),a
6491                     ; 1587 can_out_buff[can_buff_wr_ptr][6]=data4;
6493  0fe4 b676          	ld	a,_can_buff_wr_ptr
6494  0fe6 97            	ld	xl,a
6495  0fe7 a610          	ld	a,#16
6496  0fe9 42            	mul	x,a
6497  0fea 7b09          	ld	a,(OFST+9,sp)
6498  0fec e77d          	ld	(_can_out_buff+6,x),a
6499                     ; 1588 can_out_buff[can_buff_wr_ptr][7]=data5;
6501  0fee b676          	ld	a,_can_buff_wr_ptr
6502  0ff0 97            	ld	xl,a
6503  0ff1 a610          	ld	a,#16
6504  0ff3 42            	mul	x,a
6505  0ff4 7b0a          	ld	a,(OFST+10,sp)
6506  0ff6 e77e          	ld	(_can_out_buff+7,x),a
6507                     ; 1589 can_out_buff[can_buff_wr_ptr][8]=data6;
6509  0ff8 b676          	ld	a,_can_buff_wr_ptr
6510  0ffa 97            	ld	xl,a
6511  0ffb a610          	ld	a,#16
6512  0ffd 42            	mul	x,a
6513  0ffe 7b0b          	ld	a,(OFST+11,sp)
6514  1000 e77f          	ld	(_can_out_buff+8,x),a
6515                     ; 1590 can_out_buff[can_buff_wr_ptr][9]=data7;
6517  1002 b676          	ld	a,_can_buff_wr_ptr
6518  1004 97            	ld	xl,a
6519  1005 a610          	ld	a,#16
6520  1007 42            	mul	x,a
6521  1008 7b0c          	ld	a,(OFST+12,sp)
6522  100a e780          	ld	(_can_out_buff+9,x),a
6523                     ; 1592 can_buff_wr_ptr++;
6525  100c 3c76          	inc	_can_buff_wr_ptr
6526                     ; 1593 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6528  100e b676          	ld	a,_can_buff_wr_ptr
6529  1010 a104          	cp	a,#4
6530  1012 2502          	jrult	L3403
6533  1014 3f76          	clr	_can_buff_wr_ptr
6534  1016               L3403:
6535                     ; 1594 } 
6538  1016 85            	popw	x
6539  1017 81            	ret
6568                     ; 1597 void can_tx_hndl(void)
6568                     ; 1598 {
6569                     	switch	.text
6570  1018               _can_tx_hndl:
6574                     ; 1599 if(bTX_FREE)
6576  1018 3d03          	tnz	_bTX_FREE
6577  101a 2757          	jreq	L5503
6578                     ; 1601 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6580  101c b675          	ld	a,_can_buff_rd_ptr
6581  101e b176          	cp	a,_can_buff_wr_ptr
6582  1020 275f          	jreq	L3603
6583                     ; 1603 		bTX_FREE=0;
6585  1022 3f03          	clr	_bTX_FREE
6586                     ; 1605 		CAN->PSR= 0;
6588  1024 725f5427      	clr	21543
6589                     ; 1606 		CAN->Page.TxMailbox.MDLCR=8;
6591  1028 35085429      	mov	21545,#8
6592                     ; 1607 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6594  102c b675          	ld	a,_can_buff_rd_ptr
6595  102e 97            	ld	xl,a
6596  102f a610          	ld	a,#16
6597  1031 42            	mul	x,a
6598  1032 e677          	ld	a,(_can_out_buff,x)
6599  1034 c7542a        	ld	21546,a
6600                     ; 1608 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6602  1037 b675          	ld	a,_can_buff_rd_ptr
6603  1039 97            	ld	xl,a
6604  103a a610          	ld	a,#16
6605  103c 42            	mul	x,a
6606  103d e678          	ld	a,(_can_out_buff+1,x)
6607  103f c7542b        	ld	21547,a
6608                     ; 1610 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6610  1042 b675          	ld	a,_can_buff_rd_ptr
6611  1044 97            	ld	xl,a
6612  1045 a610          	ld	a,#16
6613  1047 42            	mul	x,a
6614  1048 01            	rrwa	x,a
6615  1049 ab79          	add	a,#_can_out_buff+2
6616  104b 2401          	jrnc	L631
6617  104d 5c            	incw	x
6618  104e               L631:
6619  104e 5f            	clrw	x
6620  104f 97            	ld	xl,a
6621  1050 bf00          	ldw	c_x,x
6622  1052 ae0008        	ldw	x,#8
6623  1055               L041:
6624  1055 5a            	decw	x
6625  1056 92d600        	ld	a,([c_x],x)
6626  1059 d7542e        	ld	(21550,x),a
6627  105c 5d            	tnzw	x
6628  105d 26f6          	jrne	L041
6629                     ; 1612 		can_buff_rd_ptr++;
6631  105f 3c75          	inc	_can_buff_rd_ptr
6632                     ; 1613 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6634  1061 b675          	ld	a,_can_buff_rd_ptr
6635  1063 a104          	cp	a,#4
6636  1065 2502          	jrult	L1603
6639  1067 3f75          	clr	_can_buff_rd_ptr
6640  1069               L1603:
6641                     ; 1615 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6643  1069 72105428      	bset	21544,#0
6644                     ; 1616 		CAN->IER|=(1<<0);
6646  106d 72105425      	bset	21541,#0
6647  1071 200e          	jra	L3603
6648  1073               L5503:
6649                     ; 1621 	tx_busy_cnt++;
6651  1073 3c74          	inc	_tx_busy_cnt
6652                     ; 1622 	if(tx_busy_cnt>=100)
6654  1075 b674          	ld	a,_tx_busy_cnt
6655  1077 a164          	cp	a,#100
6656  1079 2506          	jrult	L3603
6657                     ; 1624 		tx_busy_cnt=0;
6659  107b 3f74          	clr	_tx_busy_cnt
6660                     ; 1625 		bTX_FREE=1;
6662  107d 35010003      	mov	_bTX_FREE,#1
6663  1081               L3603:
6664                     ; 1628 }
6667  1081 81            	ret
6782                     ; 1654 void can_in_an(void)
6782                     ; 1655 {
6783                     	switch	.text
6784  1082               _can_in_an:
6786  1082 5207          	subw	sp,#7
6787       00000007      OFST:	set	7
6790                     ; 1665 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6792  1084 b6cd          	ld	a,_mess+6
6793  1086 c100f7        	cp	a,_adress
6794  1089 2703          	jreq	L061
6795  108b cc11c3        	jp	L3213
6796  108e               L061:
6798  108e b6ce          	ld	a,_mess+7
6799  1090 c100f7        	cp	a,_adress
6800  1093 2703          	jreq	L261
6801  1095 cc11c3        	jp	L3213
6802  1098               L261:
6804  1098 b6cf          	ld	a,_mess+8
6805  109a a1ed          	cp	a,#237
6806  109c 2703          	jreq	L461
6807  109e cc11c3        	jp	L3213
6808  10a1               L461:
6809                     ; 1668 	can_error_cnt=0;
6811  10a1 3f73          	clr	_can_error_cnt
6812                     ; 1670 	bMAIN=0;
6814  10a3 72110001      	bres	_bMAIN
6815                     ; 1671  	flags_tu=mess[9];
6817  10a7 45d06a        	mov	_flags_tu,_mess+9
6818                     ; 1672  	if(flags_tu&0b00000001)
6820  10aa b66a          	ld	a,_flags_tu
6821  10ac a501          	bcp	a,#1
6822  10ae 2706          	jreq	L5213
6823                     ; 1677  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6825  10b0 721a0005      	bset	_flags,#5
6827  10b4 2008          	jra	L7213
6828  10b6               L5213:
6829                     ; 1688  				flags&=0b11011111; 
6831  10b6 721b0005      	bres	_flags,#5
6832                     ; 1689  				off_bp_cnt=5*EE_TZAS;
6834  10ba 350f005d      	mov	_off_bp_cnt,#15
6835  10be               L7213:
6836                     ; 1695  	if(flags_tu&0b00000010) flags|=0b01000000;
6838  10be b66a          	ld	a,_flags_tu
6839  10c0 a502          	bcp	a,#2
6840  10c2 2706          	jreq	L1313
6843  10c4 721c0005      	bset	_flags,#6
6845  10c8 2004          	jra	L3313
6846  10ca               L1313:
6847                     ; 1696  	else flags&=0b10111111; 
6849  10ca 721d0005      	bres	_flags,#6
6850  10ce               L3313:
6851                     ; 1698  	U_out_const=mess[10]+mess[11]*256;
6853  10ce b6d2          	ld	a,_mess+11
6854  10d0 5f            	clrw	x
6855  10d1 97            	ld	xl,a
6856  10d2 4f            	clr	a
6857  10d3 02            	rlwa	x,a
6858  10d4 01            	rrwa	x,a
6859  10d5 bbd1          	add	a,_mess+10
6860  10d7 2401          	jrnc	L441
6861  10d9 5c            	incw	x
6862  10da               L441:
6863  10da c70009        	ld	_U_out_const+1,a
6864  10dd 9f            	ld	a,xl
6865  10de c70008        	ld	_U_out_const,a
6866                     ; 1699  	vol_i_temp=mess[12]+mess[13]*256;  
6868  10e1 b6d4          	ld	a,_mess+13
6869  10e3 5f            	clrw	x
6870  10e4 97            	ld	xl,a
6871  10e5 4f            	clr	a
6872  10e6 02            	rlwa	x,a
6873  10e7 01            	rrwa	x,a
6874  10e8 bbd3          	add	a,_mess+12
6875  10ea 2401          	jrnc	L641
6876  10ec 5c            	incw	x
6877  10ed               L641:
6878  10ed b761          	ld	_vol_i_temp+1,a
6879  10ef 9f            	ld	a,xl
6880  10f0 b760          	ld	_vol_i_temp,a
6881                     ; 1709 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6883  10f2 b608          	ld	a,_vent_resurs_tx_cnt
6884  10f4 a102          	cp	a,#2
6885  10f6 2507          	jrult	L5313
6888  10f8 ce0000        	ldw	x,_vent_resurs
6889  10fb bf41          	ldw	_plazma_int+4,x
6891  10fd 2004          	jra	L7313
6892  10ff               L5313:
6893                     ; 1710 	else plazma_int[2]=vent_resurs_sec_cnt;
6895  10ff be09          	ldw	x,_vent_resurs_sec_cnt
6896  1101 bf41          	ldw	_plazma_int+4,x
6897  1103               L7313:
6898                     ; 1711  	rotor_int=flags_tu+(((short)flags)<<8);
6900  1103 b605          	ld	a,_flags
6901  1105 5f            	clrw	x
6902  1106 97            	ld	xl,a
6903  1107 4f            	clr	a
6904  1108 02            	rlwa	x,a
6905  1109 01            	rrwa	x,a
6906  110a bb6a          	add	a,_flags_tu
6907  110c 2401          	jrnc	L051
6908  110e 5c            	incw	x
6909  110f               L051:
6910  110f b718          	ld	_rotor_int+1,a
6911  1111 9f            	ld	a,xl
6912  1112 b717          	ld	_rotor_int,a
6913                     ; 1712 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6915  1114 3b000c        	push	_Ui
6916  1117 3b000d        	push	_Ui+1
6917  111a 3b000e        	push	_Un
6918  111d 3b000f        	push	_Un+1
6919  1120 3b0010        	push	_I
6920  1123 3b0011        	push	_I+1
6921  1126 4bda          	push	#218
6922  1128 3b00f7        	push	_adress
6923  112b ae018e        	ldw	x,#398
6924  112e cd0f94        	call	_can_transmit
6926  1131 5b08          	addw	sp,#8
6927                     ; 1713 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6929  1133 3b0006        	push	_Usum
6930  1136 3b0007        	push	_Usum+1
6931  1139 3b0069        	push	__x_+1
6932  113c 3b0005        	push	_flags
6933  113f b608          	ld	a,_vent_resurs_tx_cnt
6934  1141 5f            	clrw	x
6935  1142 97            	ld	xl,a
6936  1143 d60000        	ld	a,(_vent_resurs_buff,x)
6937  1146 88            	push	a
6938  1147 3b0072        	push	_T
6939  114a 4bdb          	push	#219
6940  114c 3b00f7        	push	_adress
6941  114f ae018e        	ldw	x,#398
6942  1152 cd0f94        	call	_can_transmit
6944  1155 5b08          	addw	sp,#8
6945                     ; 1714 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6947  1157 3b0005        	push	_debug_info_to_uku+4
6948  115a 3b0006        	push	_debug_info_to_uku+5
6949  115d 3b0003        	push	_debug_info_to_uku+2
6950  1160 3b0004        	push	_debug_info_to_uku+3
6951  1163 3b0001        	push	_debug_info_to_uku
6952  1166 3b0002        	push	_debug_info_to_uku+1
6953  1169 4bdc          	push	#220
6954  116b 3b00f7        	push	_adress
6955  116e ae018e        	ldw	x,#398
6956  1171 cd0f94        	call	_can_transmit
6958  1174 5b08          	addw	sp,#8
6959                     ; 1715      link_cnt=0;
6961  1176 5f            	clrw	x
6962  1177 bf6b          	ldw	_link_cnt,x
6963                     ; 1716      link=ON;
6965  1179 3555006d      	mov	_link,#85
6966                     ; 1718      if(flags_tu&0b10000000)
6968  117d b66a          	ld	a,_flags_tu
6969  117f a580          	bcp	a,#128
6970  1181 2716          	jreq	L1413
6971                     ; 1720      	if(!res_fl)
6973  1183 725d000b      	tnz	_res_fl
6974  1187 2626          	jrne	L5413
6975                     ; 1722      		res_fl=1;
6977  1189 a601          	ld	a,#1
6978  118b ae000b        	ldw	x,#_res_fl
6979  118e cd0000        	call	c_eewrc
6981                     ; 1723      		bRES=1;
6983  1191 3501000c      	mov	_bRES,#1
6984                     ; 1724      		res_fl_cnt=0;
6986  1195 3f4b          	clr	_res_fl_cnt
6987  1197 2016          	jra	L5413
6988  1199               L1413:
6989                     ; 1729      	if(main_cnt>20)
6991  1199 9c            	rvf
6992  119a ce0255        	ldw	x,_main_cnt
6993  119d a30015        	cpw	x,#21
6994  11a0 2f0d          	jrslt	L5413
6995                     ; 1731     			if(res_fl)
6997  11a2 725d000b      	tnz	_res_fl
6998  11a6 2707          	jreq	L5413
6999                     ; 1733      			res_fl=0;
7001  11a8 4f            	clr	a
7002  11a9 ae000b        	ldw	x,#_res_fl
7003  11ac cd0000        	call	c_eewrc
7005  11af               L5413:
7006                     ; 1738       if(res_fl_)
7008  11af 725d000a      	tnz	_res_fl_
7009  11b3 2603          	jrne	L661
7010  11b5 cc172a        	jp	L7603
7011  11b8               L661:
7012                     ; 1740       	res_fl_=0;
7014  11b8 4f            	clr	a
7015  11b9 ae000a        	ldw	x,#_res_fl_
7016  11bc cd0000        	call	c_eewrc
7018  11bf ac2a172a      	jpf	L7603
7019  11c3               L3213:
7020                     ; 1743 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7022  11c3 b6cd          	ld	a,_mess+6
7023  11c5 c100f7        	cp	a,_adress
7024  11c8 2703          	jreq	L071
7025  11ca cc1440        	jp	L7513
7026  11cd               L071:
7028  11cd b6ce          	ld	a,_mess+7
7029  11cf c100f7        	cp	a,_adress
7030  11d2 2703          	jreq	L271
7031  11d4 cc1440        	jp	L7513
7032  11d7               L271:
7034  11d7 b6cf          	ld	a,_mess+8
7035  11d9 a1ee          	cp	a,#238
7036  11db 2703          	jreq	L471
7037  11dd cc1440        	jp	L7513
7038  11e0               L471:
7040  11e0 b6d0          	ld	a,_mess+9
7041  11e2 b1d1          	cp	a,_mess+10
7042  11e4 2703          	jreq	L671
7043  11e6 cc1440        	jp	L7513
7044  11e9               L671:
7045                     ; 1745 	rotor_int++;
7047  11e9 be17          	ldw	x,_rotor_int
7048  11eb 1c0001        	addw	x,#1
7049  11ee bf17          	ldw	_rotor_int,x
7050                     ; 1746 	if((mess[9]&0xf0)==0x20)
7052  11f0 b6d0          	ld	a,_mess+9
7053  11f2 a4f0          	and	a,#240
7054  11f4 a120          	cp	a,#32
7055  11f6 2673          	jrne	L1613
7056                     ; 1748 		if((mess[9]&0x0f)==0x01)
7058  11f8 b6d0          	ld	a,_mess+9
7059  11fa a40f          	and	a,#15
7060  11fc a101          	cp	a,#1
7061  11fe 260d          	jrne	L3613
7062                     ; 1750 			ee_K[0][0]=adc_buff_[4];
7064  1200 ce0107        	ldw	x,_adc_buff_+8
7065  1203 89            	pushw	x
7066  1204 ae001a        	ldw	x,#_ee_K
7067  1207 cd0000        	call	c_eewrw
7069  120a 85            	popw	x
7071  120b 204a          	jra	L5613
7072  120d               L3613:
7073                     ; 1752 		else if((mess[9]&0x0f)==0x02)
7075  120d b6d0          	ld	a,_mess+9
7076  120f a40f          	and	a,#15
7077  1211 a102          	cp	a,#2
7078  1213 260b          	jrne	L7613
7079                     ; 1754 			ee_K[0][1]++;
7081  1215 ce001c        	ldw	x,_ee_K+2
7082  1218 1c0001        	addw	x,#1
7083  121b cf001c        	ldw	_ee_K+2,x
7085  121e 2037          	jra	L5613
7086  1220               L7613:
7087                     ; 1756 		else if((mess[9]&0x0f)==0x03)
7089  1220 b6d0          	ld	a,_mess+9
7090  1222 a40f          	and	a,#15
7091  1224 a103          	cp	a,#3
7092  1226 260b          	jrne	L3713
7093                     ; 1758 			ee_K[0][1]+=10;
7095  1228 ce001c        	ldw	x,_ee_K+2
7096  122b 1c000a        	addw	x,#10
7097  122e cf001c        	ldw	_ee_K+2,x
7099  1231 2024          	jra	L5613
7100  1233               L3713:
7101                     ; 1760 		else if((mess[9]&0x0f)==0x04)
7103  1233 b6d0          	ld	a,_mess+9
7104  1235 a40f          	and	a,#15
7105  1237 a104          	cp	a,#4
7106  1239 260b          	jrne	L7713
7107                     ; 1762 			ee_K[0][1]--;
7109  123b ce001c        	ldw	x,_ee_K+2
7110  123e 1d0001        	subw	x,#1
7111  1241 cf001c        	ldw	_ee_K+2,x
7113  1244 2011          	jra	L5613
7114  1246               L7713:
7115                     ; 1764 		else if((mess[9]&0x0f)==0x05)
7117  1246 b6d0          	ld	a,_mess+9
7118  1248 a40f          	and	a,#15
7119  124a a105          	cp	a,#5
7120  124c 2609          	jrne	L5613
7121                     ; 1766 			ee_K[0][1]-=10;
7123  124e ce001c        	ldw	x,_ee_K+2
7124  1251 1d000a        	subw	x,#10
7125  1254 cf001c        	ldw	_ee_K+2,x
7126  1257               L5613:
7127                     ; 1768 		granee(&ee_K[0][1],50,3000);									
7129  1257 ae0bb8        	ldw	x,#3000
7130  125a 89            	pushw	x
7131  125b ae0032        	ldw	x,#50
7132  125e 89            	pushw	x
7133  125f ae001c        	ldw	x,#_ee_K+2
7134  1262 cd00f6        	call	_granee
7136  1265 5b04          	addw	sp,#4
7138  1267 ac251425      	jpf	L5023
7139  126b               L1613:
7140                     ; 1770 	else if((mess[9]&0xf0)==0x10)
7142  126b b6d0          	ld	a,_mess+9
7143  126d a4f0          	and	a,#240
7144  126f a110          	cp	a,#16
7145  1271 2673          	jrne	L7023
7146                     ; 1772 		if((mess[9]&0x0f)==0x01)
7148  1273 b6d0          	ld	a,_mess+9
7149  1275 a40f          	and	a,#15
7150  1277 a101          	cp	a,#1
7151  1279 260d          	jrne	L1123
7152                     ; 1774 			ee_K[1][0]=adc_buff_[1];
7154  127b ce0101        	ldw	x,_adc_buff_+2
7155  127e 89            	pushw	x
7156  127f ae001e        	ldw	x,#_ee_K+4
7157  1282 cd0000        	call	c_eewrw
7159  1285 85            	popw	x
7161  1286 204a          	jra	L3123
7162  1288               L1123:
7163                     ; 1776 		else if((mess[9]&0x0f)==0x02)
7165  1288 b6d0          	ld	a,_mess+9
7166  128a a40f          	and	a,#15
7167  128c a102          	cp	a,#2
7168  128e 260b          	jrne	L5123
7169                     ; 1778 			ee_K[1][1]++;
7171  1290 ce0020        	ldw	x,_ee_K+6
7172  1293 1c0001        	addw	x,#1
7173  1296 cf0020        	ldw	_ee_K+6,x
7175  1299 2037          	jra	L3123
7176  129b               L5123:
7177                     ; 1780 		else if((mess[9]&0x0f)==0x03)
7179  129b b6d0          	ld	a,_mess+9
7180  129d a40f          	and	a,#15
7181  129f a103          	cp	a,#3
7182  12a1 260b          	jrne	L1223
7183                     ; 1782 			ee_K[1][1]+=10;
7185  12a3 ce0020        	ldw	x,_ee_K+6
7186  12a6 1c000a        	addw	x,#10
7187  12a9 cf0020        	ldw	_ee_K+6,x
7189  12ac 2024          	jra	L3123
7190  12ae               L1223:
7191                     ; 1784 		else if((mess[9]&0x0f)==0x04)
7193  12ae b6d0          	ld	a,_mess+9
7194  12b0 a40f          	and	a,#15
7195  12b2 a104          	cp	a,#4
7196  12b4 260b          	jrne	L5223
7197                     ; 1786 			ee_K[1][1]--;
7199  12b6 ce0020        	ldw	x,_ee_K+6
7200  12b9 1d0001        	subw	x,#1
7201  12bc cf0020        	ldw	_ee_K+6,x
7203  12bf 2011          	jra	L3123
7204  12c1               L5223:
7205                     ; 1788 		else if((mess[9]&0x0f)==0x05)
7207  12c1 b6d0          	ld	a,_mess+9
7208  12c3 a40f          	and	a,#15
7209  12c5 a105          	cp	a,#5
7210  12c7 2609          	jrne	L3123
7211                     ; 1790 			ee_K[1][1]-=10;
7213  12c9 ce0020        	ldw	x,_ee_K+6
7214  12cc 1d000a        	subw	x,#10
7215  12cf cf0020        	ldw	_ee_K+6,x
7216  12d2               L3123:
7217                     ; 1795 		granee(&ee_K[1][1],10,30000);
7219  12d2 ae7530        	ldw	x,#30000
7220  12d5 89            	pushw	x
7221  12d6 ae000a        	ldw	x,#10
7222  12d9 89            	pushw	x
7223  12da ae0020        	ldw	x,#_ee_K+6
7224  12dd cd00f6        	call	_granee
7226  12e0 5b04          	addw	sp,#4
7228  12e2 ac251425      	jpf	L5023
7229  12e6               L7023:
7230                     ; 1799 	else if((mess[9]&0xf0)==0x00)
7232  12e6 b6d0          	ld	a,_mess+9
7233  12e8 a5f0          	bcp	a,#240
7234  12ea 2673          	jrne	L5323
7235                     ; 1801 		if((mess[9]&0x0f)==0x01)
7237  12ec b6d0          	ld	a,_mess+9
7238  12ee a40f          	and	a,#15
7239  12f0 a101          	cp	a,#1
7240  12f2 260d          	jrne	L7323
7241                     ; 1803 			ee_K[2][0]=adc_buff_[2];
7243  12f4 ce0103        	ldw	x,_adc_buff_+4
7244  12f7 89            	pushw	x
7245  12f8 ae0022        	ldw	x,#_ee_K+8
7246  12fb cd0000        	call	c_eewrw
7248  12fe 85            	popw	x
7250  12ff 204a          	jra	L1423
7251  1301               L7323:
7252                     ; 1805 		else if((mess[9]&0x0f)==0x02)
7254  1301 b6d0          	ld	a,_mess+9
7255  1303 a40f          	and	a,#15
7256  1305 a102          	cp	a,#2
7257  1307 260b          	jrne	L3423
7258                     ; 1807 			ee_K[2][1]++;
7260  1309 ce0024        	ldw	x,_ee_K+10
7261  130c 1c0001        	addw	x,#1
7262  130f cf0024        	ldw	_ee_K+10,x
7264  1312 2037          	jra	L1423
7265  1314               L3423:
7266                     ; 1809 		else if((mess[9]&0x0f)==0x03)
7268  1314 b6d0          	ld	a,_mess+9
7269  1316 a40f          	and	a,#15
7270  1318 a103          	cp	a,#3
7271  131a 260b          	jrne	L7423
7272                     ; 1811 			ee_K[2][1]+=10;
7274  131c ce0024        	ldw	x,_ee_K+10
7275  131f 1c000a        	addw	x,#10
7276  1322 cf0024        	ldw	_ee_K+10,x
7278  1325 2024          	jra	L1423
7279  1327               L7423:
7280                     ; 1813 		else if((mess[9]&0x0f)==0x04)
7282  1327 b6d0          	ld	a,_mess+9
7283  1329 a40f          	and	a,#15
7284  132b a104          	cp	a,#4
7285  132d 260b          	jrne	L3523
7286                     ; 1815 			ee_K[2][1]--;
7288  132f ce0024        	ldw	x,_ee_K+10
7289  1332 1d0001        	subw	x,#1
7290  1335 cf0024        	ldw	_ee_K+10,x
7292  1338 2011          	jra	L1423
7293  133a               L3523:
7294                     ; 1817 		else if((mess[9]&0x0f)==0x05)
7296  133a b6d0          	ld	a,_mess+9
7297  133c a40f          	and	a,#15
7298  133e a105          	cp	a,#5
7299  1340 2609          	jrne	L1423
7300                     ; 1819 			ee_K[2][1]-=10;
7302  1342 ce0024        	ldw	x,_ee_K+10
7303  1345 1d000a        	subw	x,#10
7304  1348 cf0024        	ldw	_ee_K+10,x
7305  134b               L1423:
7306                     ; 1824 		granee(&ee_K[2][1],10,30000);
7308  134b ae7530        	ldw	x,#30000
7309  134e 89            	pushw	x
7310  134f ae000a        	ldw	x,#10
7311  1352 89            	pushw	x
7312  1353 ae0024        	ldw	x,#_ee_K+10
7313  1356 cd00f6        	call	_granee
7315  1359 5b04          	addw	sp,#4
7317  135b ac251425      	jpf	L5023
7318  135f               L5323:
7319                     ; 1828 	else if((mess[9]&0xf0)==0x30)
7321  135f b6d0          	ld	a,_mess+9
7322  1361 a4f0          	and	a,#240
7323  1363 a130          	cp	a,#48
7324  1365 265c          	jrne	L3623
7325                     ; 1830 		if((mess[9]&0x0f)==0x02)
7327  1367 b6d0          	ld	a,_mess+9
7328  1369 a40f          	and	a,#15
7329  136b a102          	cp	a,#2
7330  136d 260b          	jrne	L5623
7331                     ; 1832 			ee_K[3][1]++;
7333  136f ce0028        	ldw	x,_ee_K+14
7334  1372 1c0001        	addw	x,#1
7335  1375 cf0028        	ldw	_ee_K+14,x
7337  1378 2037          	jra	L7623
7338  137a               L5623:
7339                     ; 1834 		else if((mess[9]&0x0f)==0x03)
7341  137a b6d0          	ld	a,_mess+9
7342  137c a40f          	and	a,#15
7343  137e a103          	cp	a,#3
7344  1380 260b          	jrne	L1723
7345                     ; 1836 			ee_K[3][1]+=10;
7347  1382 ce0028        	ldw	x,_ee_K+14
7348  1385 1c000a        	addw	x,#10
7349  1388 cf0028        	ldw	_ee_K+14,x
7351  138b 2024          	jra	L7623
7352  138d               L1723:
7353                     ; 1838 		else if((mess[9]&0x0f)==0x04)
7355  138d b6d0          	ld	a,_mess+9
7356  138f a40f          	and	a,#15
7357  1391 a104          	cp	a,#4
7358  1393 260b          	jrne	L5723
7359                     ; 1840 			ee_K[3][1]--;
7361  1395 ce0028        	ldw	x,_ee_K+14
7362  1398 1d0001        	subw	x,#1
7363  139b cf0028        	ldw	_ee_K+14,x
7365  139e 2011          	jra	L7623
7366  13a0               L5723:
7367                     ; 1842 		else if((mess[9]&0x0f)==0x05)
7369  13a0 b6d0          	ld	a,_mess+9
7370  13a2 a40f          	and	a,#15
7371  13a4 a105          	cp	a,#5
7372  13a6 2609          	jrne	L7623
7373                     ; 1844 			ee_K[3][1]-=10;
7375  13a8 ce0028        	ldw	x,_ee_K+14
7376  13ab 1d000a        	subw	x,#10
7377  13ae cf0028        	ldw	_ee_K+14,x
7378  13b1               L7623:
7379                     ; 1846 		granee(&ee_K[3][1],300,517);									
7381  13b1 ae0205        	ldw	x,#517
7382  13b4 89            	pushw	x
7383  13b5 ae012c        	ldw	x,#300
7384  13b8 89            	pushw	x
7385  13b9 ae0028        	ldw	x,#_ee_K+14
7386  13bc cd00f6        	call	_granee
7388  13bf 5b04          	addw	sp,#4
7390  13c1 2062          	jra	L5023
7391  13c3               L3623:
7392                     ; 1849 	else if((mess[9]&0xf0)==0x50)
7394  13c3 b6d0          	ld	a,_mess+9
7395  13c5 a4f0          	and	a,#240
7396  13c7 a150          	cp	a,#80
7397  13c9 265a          	jrne	L5023
7398                     ; 1851 		if((mess[9]&0x0f)==0x02)
7400  13cb b6d0          	ld	a,_mess+9
7401  13cd a40f          	and	a,#15
7402  13cf a102          	cp	a,#2
7403  13d1 260b          	jrne	L7033
7404                     ; 1853 			ee_K[4][1]++;
7406  13d3 ce002c        	ldw	x,_ee_K+18
7407  13d6 1c0001        	addw	x,#1
7408  13d9 cf002c        	ldw	_ee_K+18,x
7410  13dc 2037          	jra	L1133
7411  13de               L7033:
7412                     ; 1855 		else if((mess[9]&0x0f)==0x03)
7414  13de b6d0          	ld	a,_mess+9
7415  13e0 a40f          	and	a,#15
7416  13e2 a103          	cp	a,#3
7417  13e4 260b          	jrne	L3133
7418                     ; 1857 			ee_K[4][1]+=10;
7420  13e6 ce002c        	ldw	x,_ee_K+18
7421  13e9 1c000a        	addw	x,#10
7422  13ec cf002c        	ldw	_ee_K+18,x
7424  13ef 2024          	jra	L1133
7425  13f1               L3133:
7426                     ; 1859 		else if((mess[9]&0x0f)==0x04)
7428  13f1 b6d0          	ld	a,_mess+9
7429  13f3 a40f          	and	a,#15
7430  13f5 a104          	cp	a,#4
7431  13f7 260b          	jrne	L7133
7432                     ; 1861 			ee_K[4][1]--;
7434  13f9 ce002c        	ldw	x,_ee_K+18
7435  13fc 1d0001        	subw	x,#1
7436  13ff cf002c        	ldw	_ee_K+18,x
7438  1402 2011          	jra	L1133
7439  1404               L7133:
7440                     ; 1863 		else if((mess[9]&0x0f)==0x05)
7442  1404 b6d0          	ld	a,_mess+9
7443  1406 a40f          	and	a,#15
7444  1408 a105          	cp	a,#5
7445  140a 2609          	jrne	L1133
7446                     ; 1865 			ee_K[4][1]-=10;
7448  140c ce002c        	ldw	x,_ee_K+18
7449  140f 1d000a        	subw	x,#10
7450  1412 cf002c        	ldw	_ee_K+18,x
7451  1415               L1133:
7452                     ; 1867 		granee(&ee_K[4][1],10,30000);									
7454  1415 ae7530        	ldw	x,#30000
7455  1418 89            	pushw	x
7456  1419 ae000a        	ldw	x,#10
7457  141c 89            	pushw	x
7458  141d ae002c        	ldw	x,#_ee_K+18
7459  1420 cd00f6        	call	_granee
7461  1423 5b04          	addw	sp,#4
7462  1425               L5023:
7463                     ; 1870 	link_cnt=0;
7465  1425 5f            	clrw	x
7466  1426 bf6b          	ldw	_link_cnt,x
7467                     ; 1871      link=ON;
7469  1428 3555006d      	mov	_link,#85
7470                     ; 1872      if(res_fl_)
7472  142c 725d000a      	tnz	_res_fl_
7473  1430 2603          	jrne	L002
7474  1432 cc172a        	jp	L7603
7475  1435               L002:
7476                     ; 1874       	res_fl_=0;
7478  1435 4f            	clr	a
7479  1436 ae000a        	ldw	x,#_res_fl_
7480  1439 cd0000        	call	c_eewrc
7482  143c ac2a172a      	jpf	L7603
7483  1440               L7513:
7484                     ; 1880 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7486  1440 b6cd          	ld	a,_mess+6
7487  1442 a1ff          	cp	a,#255
7488  1444 2703          	jreq	L202
7489  1446 cc14d4        	jp	L1333
7490  1449               L202:
7492  1449 b6ce          	ld	a,_mess+7
7493  144b a1ff          	cp	a,#255
7494  144d 2703          	jreq	L402
7495  144f cc14d4        	jp	L1333
7496  1452               L402:
7498  1452 b6cf          	ld	a,_mess+8
7499  1454 a162          	cp	a,#98
7500  1456 267c          	jrne	L1333
7501                     ; 1883 	tempSS=mess[9]+(mess[10]*256);
7503  1458 b6d1          	ld	a,_mess+10
7504  145a 5f            	clrw	x
7505  145b 97            	ld	xl,a
7506  145c 4f            	clr	a
7507  145d 02            	rlwa	x,a
7508  145e 01            	rrwa	x,a
7509  145f bbd0          	add	a,_mess+9
7510  1461 2401          	jrnc	L251
7511  1463 5c            	incw	x
7512  1464               L251:
7513  1464 02            	rlwa	x,a
7514  1465 1f03          	ldw	(OFST-4,sp),x
7515  1467 01            	rrwa	x,a
7516                     ; 1884 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7518  1468 ce0014        	ldw	x,_ee_Umax
7519  146b 1303          	cpw	x,(OFST-4,sp)
7520  146d 270a          	jreq	L3333
7523  146f 1e03          	ldw	x,(OFST-4,sp)
7524  1471 89            	pushw	x
7525  1472 ae0014        	ldw	x,#_ee_Umax
7526  1475 cd0000        	call	c_eewrw
7528  1478 85            	popw	x
7529  1479               L3333:
7530                     ; 1885 	tempSS=mess[11]+(mess[12]*256);
7532  1479 b6d3          	ld	a,_mess+12
7533  147b 5f            	clrw	x
7534  147c 97            	ld	xl,a
7535  147d 4f            	clr	a
7536  147e 02            	rlwa	x,a
7537  147f 01            	rrwa	x,a
7538  1480 bbd2          	add	a,_mess+11
7539  1482 2401          	jrnc	L451
7540  1484 5c            	incw	x
7541  1485               L451:
7542  1485 02            	rlwa	x,a
7543  1486 1f03          	ldw	(OFST-4,sp),x
7544  1488 01            	rrwa	x,a
7545                     ; 1886 	if(ee_dU!=tempSS) ee_dU=tempSS;
7547  1489 ce0012        	ldw	x,_ee_dU
7548  148c 1303          	cpw	x,(OFST-4,sp)
7549  148e 270a          	jreq	L5333
7552  1490 1e03          	ldw	x,(OFST-4,sp)
7553  1492 89            	pushw	x
7554  1493 ae0012        	ldw	x,#_ee_dU
7555  1496 cd0000        	call	c_eewrw
7557  1499 85            	popw	x
7558  149a               L5333:
7559                     ; 1887 	if((mess[13]&0x0f)==0x5)
7561  149a b6d4          	ld	a,_mess+13
7562  149c a40f          	and	a,#15
7563  149e a105          	cp	a,#5
7564  14a0 261a          	jrne	L7333
7565                     ; 1889 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7567  14a2 ce0006        	ldw	x,_ee_AVT_MODE
7568  14a5 a30055        	cpw	x,#85
7569  14a8 2603          	jrne	L602
7570  14aa cc172a        	jp	L7603
7571  14ad               L602:
7574  14ad ae0055        	ldw	x,#85
7575  14b0 89            	pushw	x
7576  14b1 ae0006        	ldw	x,#_ee_AVT_MODE
7577  14b4 cd0000        	call	c_eewrw
7579  14b7 85            	popw	x
7580  14b8 ac2a172a      	jpf	L7603
7581  14bc               L7333:
7582                     ; 1891 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7584  14bc ce0006        	ldw	x,_ee_AVT_MODE
7585  14bf a30055        	cpw	x,#85
7586  14c2 2703          	jreq	L012
7587  14c4 cc172a        	jp	L7603
7588  14c7               L012:
7591  14c7 5f            	clrw	x
7592  14c8 89            	pushw	x
7593  14c9 ae0006        	ldw	x,#_ee_AVT_MODE
7594  14cc cd0000        	call	c_eewrw
7596  14cf 85            	popw	x
7597  14d0 ac2a172a      	jpf	L7603
7598  14d4               L1333:
7599                     ; 1894 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7601  14d4 b6cd          	ld	a,_mess+6
7602  14d6 a1ff          	cp	a,#255
7603  14d8 2703          	jreq	L212
7604  14da cc1590        	jp	L1533
7605  14dd               L212:
7607  14dd b6ce          	ld	a,_mess+7
7608  14df a1ff          	cp	a,#255
7609  14e1 2703          	jreq	L412
7610  14e3 cc1590        	jp	L1533
7611  14e6               L412:
7613  14e6 b6cf          	ld	a,_mess+8
7614  14e8 a126          	cp	a,#38
7615  14ea 2709          	jreq	L3533
7617  14ec b6cf          	ld	a,_mess+8
7618  14ee a129          	cp	a,#41
7619  14f0 2703          	jreq	L612
7620  14f2 cc1590        	jp	L1533
7621  14f5               L612:
7622  14f5               L3533:
7623                     ; 1897 	tempSS=mess[9]+(mess[10]*256);
7625  14f5 b6d1          	ld	a,_mess+10
7626  14f7 5f            	clrw	x
7627  14f8 97            	ld	xl,a
7628  14f9 4f            	clr	a
7629  14fa 02            	rlwa	x,a
7630  14fb 01            	rrwa	x,a
7631  14fc bbd0          	add	a,_mess+9
7632  14fe 2401          	jrnc	L651
7633  1500 5c            	incw	x
7634  1501               L651:
7635  1501 02            	rlwa	x,a
7636  1502 1f03          	ldw	(OFST-4,sp),x
7637  1504 01            	rrwa	x,a
7638                     ; 1899 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7640  1505 ce000c        	ldw	x,_ee_UAVT
7641  1508 1303          	cpw	x,(OFST-4,sp)
7642  150a 270a          	jreq	L5533
7645  150c 1e03          	ldw	x,(OFST-4,sp)
7646  150e 89            	pushw	x
7647  150f ae000c        	ldw	x,#_ee_UAVT
7648  1512 cd0000        	call	c_eewrw
7650  1515 85            	popw	x
7651  1516               L5533:
7652                     ; 1900 	tempSS=(signed short)mess[11];
7654  1516 b6d2          	ld	a,_mess+11
7655  1518 5f            	clrw	x
7656  1519 97            	ld	xl,a
7657  151a 1f03          	ldw	(OFST-4,sp),x
7658                     ; 1901 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7660  151c ce0010        	ldw	x,_ee_tmax
7661  151f 1303          	cpw	x,(OFST-4,sp)
7662  1521 270a          	jreq	L7533
7665  1523 1e03          	ldw	x,(OFST-4,sp)
7666  1525 89            	pushw	x
7667  1526 ae0010        	ldw	x,#_ee_tmax
7668  1529 cd0000        	call	c_eewrw
7670  152c 85            	popw	x
7671  152d               L7533:
7672                     ; 1902 	tempSS=(signed short)mess[12];
7674  152d b6d3          	ld	a,_mess+12
7675  152f 5f            	clrw	x
7676  1530 97            	ld	xl,a
7677  1531 1f03          	ldw	(OFST-4,sp),x
7678                     ; 1903 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7680  1533 ce000e        	ldw	x,_ee_tsign
7681  1536 1303          	cpw	x,(OFST-4,sp)
7682  1538 270a          	jreq	L1633
7685  153a 1e03          	ldw	x,(OFST-4,sp)
7686  153c 89            	pushw	x
7687  153d ae000e        	ldw	x,#_ee_tsign
7688  1540 cd0000        	call	c_eewrw
7690  1543 85            	popw	x
7691  1544               L1633:
7692                     ; 1906 	if(mess[8]==MEM_KF1)
7694  1544 b6cf          	ld	a,_mess+8
7695  1546 a126          	cp	a,#38
7696  1548 260e          	jrne	L3633
7697                     ; 1908 		if(ee_DEVICE!=0)ee_DEVICE=0;
7699  154a ce0004        	ldw	x,_ee_DEVICE
7700  154d 2709          	jreq	L3633
7703  154f 5f            	clrw	x
7704  1550 89            	pushw	x
7705  1551 ae0004        	ldw	x,#_ee_DEVICE
7706  1554 cd0000        	call	c_eewrw
7708  1557 85            	popw	x
7709  1558               L3633:
7710                     ; 1911 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7712  1558 b6cf          	ld	a,_mess+8
7713  155a a129          	cp	a,#41
7714  155c 2703          	jreq	L022
7715  155e cc172a        	jp	L7603
7716  1561               L022:
7717                     ; 1913 		if(ee_DEVICE!=1)ee_DEVICE=1;
7719  1561 ce0004        	ldw	x,_ee_DEVICE
7720  1564 a30001        	cpw	x,#1
7721  1567 270b          	jreq	L1733
7724  1569 ae0001        	ldw	x,#1
7725  156c 89            	pushw	x
7726  156d ae0004        	ldw	x,#_ee_DEVICE
7727  1570 cd0000        	call	c_eewrw
7729  1573 85            	popw	x
7730  1574               L1733:
7731                     ; 1914 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7733  1574 b6d4          	ld	a,_mess+13
7734  1576 5f            	clrw	x
7735  1577 97            	ld	xl,a
7736  1578 c30002        	cpw	x,_ee_IMAXVENT
7737  157b 2603          	jrne	L222
7738  157d cc172a        	jp	L7603
7739  1580               L222:
7742  1580 b6d4          	ld	a,_mess+13
7743  1582 5f            	clrw	x
7744  1583 97            	ld	xl,a
7745  1584 89            	pushw	x
7746  1585 ae0002        	ldw	x,#_ee_IMAXVENT
7747  1588 cd0000        	call	c_eewrw
7749  158b 85            	popw	x
7750  158c ac2a172a      	jpf	L7603
7751  1590               L1533:
7752                     ; 1919 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7754  1590 b6cd          	ld	a,_mess+6
7755  1592 c100f7        	cp	a,_adress
7756  1595 262d          	jrne	L7733
7758  1597 b6ce          	ld	a,_mess+7
7759  1599 c100f7        	cp	a,_adress
7760  159c 2626          	jrne	L7733
7762  159e b6cf          	ld	a,_mess+8
7763  15a0 a116          	cp	a,#22
7764  15a2 2620          	jrne	L7733
7766  15a4 b6d0          	ld	a,_mess+9
7767  15a6 a163          	cp	a,#99
7768  15a8 261a          	jrne	L7733
7769                     ; 1921 	flags&=0b11100001;
7771  15aa b605          	ld	a,_flags
7772  15ac a4e1          	and	a,#225
7773  15ae b705          	ld	_flags,a
7774                     ; 1922 	tsign_cnt=0;
7776  15b0 5f            	clrw	x
7777  15b1 bf59          	ldw	_tsign_cnt,x
7778                     ; 1923 	tmax_cnt=0;
7780  15b3 5f            	clrw	x
7781  15b4 bf57          	ldw	_tmax_cnt,x
7782                     ; 1924 	umax_cnt=0;
7784  15b6 5f            	clrw	x
7785  15b7 bf70          	ldw	_umax_cnt,x
7786                     ; 1925 	umin_cnt=0;
7788  15b9 5f            	clrw	x
7789  15ba bf6e          	ldw	_umin_cnt,x
7790                     ; 1926 	led_drv_cnt=30;
7792  15bc 351e0016      	mov	_led_drv_cnt,#30
7794  15c0 ac2a172a      	jpf	L7603
7795  15c4               L7733:
7796                     ; 1929 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7798  15c4 b6cd          	ld	a,_mess+6
7799  15c6 c100f7        	cp	a,_adress
7800  15c9 2620          	jrne	L3043
7802  15cb b6ce          	ld	a,_mess+7
7803  15cd c100f7        	cp	a,_adress
7804  15d0 2619          	jrne	L3043
7806  15d2 b6cf          	ld	a,_mess+8
7807  15d4 a116          	cp	a,#22
7808  15d6 2613          	jrne	L3043
7810  15d8 b6d0          	ld	a,_mess+9
7811  15da a164          	cp	a,#100
7812  15dc 260d          	jrne	L3043
7813                     ; 1931 	vent_resurs=0;
7815  15de 5f            	clrw	x
7816  15df 89            	pushw	x
7817  15e0 ae0000        	ldw	x,#_vent_resurs
7818  15e3 cd0000        	call	c_eewrw
7820  15e6 85            	popw	x
7822  15e7 ac2a172a      	jpf	L7603
7823  15eb               L3043:
7824                     ; 1935 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7826  15eb b6cd          	ld	a,_mess+6
7827  15ed a1ff          	cp	a,#255
7828  15ef 265f          	jrne	L7043
7830  15f1 b6ce          	ld	a,_mess+7
7831  15f3 a1ff          	cp	a,#255
7832  15f5 2659          	jrne	L7043
7834  15f7 b6cf          	ld	a,_mess+8
7835  15f9 a116          	cp	a,#22
7836  15fb 2653          	jrne	L7043
7838  15fd b6d0          	ld	a,_mess+9
7839  15ff a116          	cp	a,#22
7840  1601 264d          	jrne	L7043
7841                     ; 1937 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7843  1603 b6d1          	ld	a,_mess+10
7844  1605 a155          	cp	a,#85
7845  1607 260f          	jrne	L1143
7847  1609 b6d2          	ld	a,_mess+11
7848  160b a155          	cp	a,#85
7849  160d 2609          	jrne	L1143
7852  160f be68          	ldw	x,__x_
7853  1611 1c0001        	addw	x,#1
7854  1614 bf68          	ldw	__x_,x
7856  1616 2024          	jra	L3143
7857  1618               L1143:
7858                     ; 1938 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7860  1618 b6d1          	ld	a,_mess+10
7861  161a a166          	cp	a,#102
7862  161c 260f          	jrne	L5143
7864  161e b6d2          	ld	a,_mess+11
7865  1620 a166          	cp	a,#102
7866  1622 2609          	jrne	L5143
7869  1624 be68          	ldw	x,__x_
7870  1626 1d0001        	subw	x,#1
7871  1629 bf68          	ldw	__x_,x
7873  162b 200f          	jra	L3143
7874  162d               L5143:
7875                     ; 1939 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7877  162d b6d1          	ld	a,_mess+10
7878  162f a177          	cp	a,#119
7879  1631 2609          	jrne	L3143
7881  1633 b6d2          	ld	a,_mess+11
7882  1635 a177          	cp	a,#119
7883  1637 2603          	jrne	L3143
7886  1639 5f            	clrw	x
7887  163a bf68          	ldw	__x_,x
7888  163c               L3143:
7889                     ; 1940      gran(&_x_,-XMAX,XMAX);
7891  163c ae0019        	ldw	x,#25
7892  163f 89            	pushw	x
7893  1640 aeffe7        	ldw	x,#65511
7894  1643 89            	pushw	x
7895  1644 ae0068        	ldw	x,#__x_
7896  1647 cd00d5        	call	_gran
7898  164a 5b04          	addw	sp,#4
7900  164c ac2a172a      	jpf	L7603
7901  1650               L7043:
7902                     ; 1942 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7904  1650 b6cd          	ld	a,_mess+6
7905  1652 c100f7        	cp	a,_adress
7906  1655 2635          	jrne	L5243
7908  1657 b6ce          	ld	a,_mess+7
7909  1659 c100f7        	cp	a,_adress
7910  165c 262e          	jrne	L5243
7912  165e b6cf          	ld	a,_mess+8
7913  1660 a116          	cp	a,#22
7914  1662 2628          	jrne	L5243
7916  1664 b6d0          	ld	a,_mess+9
7917  1666 b1d1          	cp	a,_mess+10
7918  1668 2622          	jrne	L5243
7920  166a b6d0          	ld	a,_mess+9
7921  166c a1ee          	cp	a,#238
7922  166e 261c          	jrne	L5243
7923                     ; 1944 	rotor_int++;
7925  1670 be17          	ldw	x,_rotor_int
7926  1672 1c0001        	addw	x,#1
7927  1675 bf17          	ldw	_rotor_int,x
7928                     ; 1945      tempI=pwm_u;
7930                     ; 1947 	UU_AVT=Un;
7932  1677 ce000e        	ldw	x,_Un
7933  167a 89            	pushw	x
7934  167b ae0008        	ldw	x,#_UU_AVT
7935  167e cd0000        	call	c_eewrw
7937  1681 85            	popw	x
7938                     ; 1948 	delay_ms(100);
7940  1682 ae0064        	ldw	x,#100
7941  1685 cd0121        	call	_delay_ms
7944  1688 ac2a172a      	jpf	L7603
7945  168c               L5243:
7946                     ; 1954 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7948  168c b6ce          	ld	a,_mess+7
7949  168e a1da          	cp	a,#218
7950  1690 2653          	jrne	L1343
7952  1692 b6cd          	ld	a,_mess+6
7953  1694 c100f7        	cp	a,_adress
7954  1697 274c          	jreq	L1343
7956  1699 b6cd          	ld	a,_mess+6
7957  169b a106          	cp	a,#6
7958  169d 2446          	jruge	L1343
7959                     ; 1956 	i_main_bps_cnt[mess[6]]=0;
7961  169f b6cd          	ld	a,_mess+6
7962  16a1 5f            	clrw	x
7963  16a2 97            	ld	xl,a
7964  16a3 6f13          	clr	(_i_main_bps_cnt,x)
7965                     ; 1957 	i_main_flag[mess[6]]=1;
7967  16a5 b6cd          	ld	a,_mess+6
7968  16a7 5f            	clrw	x
7969  16a8 97            	ld	xl,a
7970  16a9 a601          	ld	a,#1
7971  16ab e71e          	ld	(_i_main_flag,x),a
7972                     ; 1958 	if(bMAIN)
7974                     	btst	_bMAIN
7975  16b2 2476          	jruge	L7603
7976                     ; 1960 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7978  16b4 b6d0          	ld	a,_mess+9
7979  16b6 5f            	clrw	x
7980  16b7 97            	ld	xl,a
7981  16b8 4f            	clr	a
7982  16b9 02            	rlwa	x,a
7983  16ba 1f01          	ldw	(OFST-6,sp),x
7984  16bc b6cf          	ld	a,_mess+8
7985  16be 5f            	clrw	x
7986  16bf 97            	ld	xl,a
7987  16c0 72fb01        	addw	x,(OFST-6,sp)
7988  16c3 b6cd          	ld	a,_mess+6
7989  16c5 905f          	clrw	y
7990  16c7 9097          	ld	yl,a
7991  16c9 9058          	sllw	y
7992  16cb 90ef24        	ldw	(_i_main,y),x
7993                     ; 1961 		i_main[adress]=I;
7995  16ce c600f7        	ld	a,_adress
7996  16d1 5f            	clrw	x
7997  16d2 97            	ld	xl,a
7998  16d3 58            	sllw	x
7999  16d4 90ce0010      	ldw	y,_I
8000  16d8 ef24          	ldw	(_i_main,x),y
8001                     ; 1962      	i_main_flag[adress]=1;
8003  16da c600f7        	ld	a,_adress
8004  16dd 5f            	clrw	x
8005  16de 97            	ld	xl,a
8006  16df a601          	ld	a,#1
8007  16e1 e71e          	ld	(_i_main_flag,x),a
8008  16e3 2045          	jra	L7603
8009  16e5               L1343:
8010                     ; 1966 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8012  16e5 b6ce          	ld	a,_mess+7
8013  16e7 a1db          	cp	a,#219
8014  16e9 263f          	jrne	L7603
8016  16eb b6cd          	ld	a,_mess+6
8017  16ed c100f7        	cp	a,_adress
8018  16f0 2738          	jreq	L7603
8020  16f2 b6cd          	ld	a,_mess+6
8021  16f4 a106          	cp	a,#6
8022  16f6 2432          	jruge	L7603
8023                     ; 1968 	i_main_bps_cnt[mess[6]]=0;
8025  16f8 b6cd          	ld	a,_mess+6
8026  16fa 5f            	clrw	x
8027  16fb 97            	ld	xl,a
8028  16fc 6f13          	clr	(_i_main_bps_cnt,x)
8029                     ; 1969 	i_main_flag[mess[6]]=1;		
8031  16fe b6cd          	ld	a,_mess+6
8032  1700 5f            	clrw	x
8033  1701 97            	ld	xl,a
8034  1702 a601          	ld	a,#1
8035  1704 e71e          	ld	(_i_main_flag,x),a
8036                     ; 1970 	if(bMAIN)
8038                     	btst	_bMAIN
8039  170b 241d          	jruge	L7603
8040                     ; 1972 		if(mess[9]==0)i_main_flag[i]=1;
8042  170d 3dd0          	tnz	_mess+9
8043  170f 260a          	jrne	L3443
8046  1711 7b07          	ld	a,(OFST+0,sp)
8047  1713 5f            	clrw	x
8048  1714 97            	ld	xl,a
8049  1715 a601          	ld	a,#1
8050  1717 e71e          	ld	(_i_main_flag,x),a
8052  1719 2006          	jra	L5443
8053  171b               L3443:
8054                     ; 1973 		else i_main_flag[i]=0;
8056  171b 7b07          	ld	a,(OFST+0,sp)
8057  171d 5f            	clrw	x
8058  171e 97            	ld	xl,a
8059  171f 6f1e          	clr	(_i_main_flag,x)
8060  1721               L5443:
8061                     ; 1974 		i_main_flag[adress]=1;
8063  1721 c600f7        	ld	a,_adress
8064  1724 5f            	clrw	x
8065  1725 97            	ld	xl,a
8066  1726 a601          	ld	a,#1
8067  1728 e71e          	ld	(_i_main_flag,x),a
8068  172a               L7603:
8069                     ; 1980 can_in_an_end:
8069                     ; 1981 bCAN_RX=0;
8071  172a 3f04          	clr	_bCAN_RX
8072                     ; 1982 }   
8075  172c 5b07          	addw	sp,#7
8076  172e 81            	ret
8099                     ; 1985 void t4_init(void){
8100                     	switch	.text
8101  172f               _t4_init:
8105                     ; 1986 	TIM4->PSCR = 6;
8107  172f 35065345      	mov	21317,#6
8108                     ; 1987 	TIM4->ARR= 61;
8110  1733 353d5346      	mov	21318,#61
8111                     ; 1988 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8113  1737 72105341      	bset	21313,#0
8114                     ; 1990 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8116  173b 35855340      	mov	21312,#133
8117                     ; 1992 }
8120  173f 81            	ret
8143                     ; 1995 void t1_init(void)
8143                     ; 1996 {
8144                     	switch	.text
8145  1740               _t1_init:
8149                     ; 1997 TIM1->ARRH= 0x07;
8151  1740 35075262      	mov	21090,#7
8152                     ; 1998 TIM1->ARRL= 0xff;
8154  1744 35ff5263      	mov	21091,#255
8155                     ; 1999 TIM1->CCR1H= 0x00;	
8157  1748 725f5265      	clr	21093
8158                     ; 2000 TIM1->CCR1L= 0xff;
8160  174c 35ff5266      	mov	21094,#255
8161                     ; 2001 TIM1->CCR2H= 0x00;	
8163  1750 725f5267      	clr	21095
8164                     ; 2002 TIM1->CCR2L= 0x00;
8166  1754 725f5268      	clr	21096
8167                     ; 2003 TIM1->CCR3H= 0x00;	
8169  1758 725f5269      	clr	21097
8170                     ; 2004 TIM1->CCR3L= 0x64;
8172  175c 3564526a      	mov	21098,#100
8173                     ; 2006 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8175  1760 35685258      	mov	21080,#104
8176                     ; 2007 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8178  1764 35685259      	mov	21081,#104
8179                     ; 2008 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8181  1768 3568525a      	mov	21082,#104
8182                     ; 2009 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8184  176c 3511525c      	mov	21084,#17
8185                     ; 2010 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8187  1770 3501525d      	mov	21085,#1
8188                     ; 2011 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8190  1774 35815250      	mov	21072,#129
8191                     ; 2012 TIM1->BKR|= TIM1_BKR_AOE;
8193  1778 721c526d      	bset	21101,#6
8194                     ; 2013 }
8197  177c 81            	ret
8222                     ; 2017 void adc2_init(void)
8222                     ; 2018 {
8223                     	switch	.text
8224  177d               _adc2_init:
8228                     ; 2019 adc_plazma[0]++;
8230  177d beb9          	ldw	x,_adc_plazma
8231  177f 1c0001        	addw	x,#1
8232  1782 bfb9          	ldw	_adc_plazma,x
8233                     ; 2043 GPIOB->DDR&=~(1<<4);
8235  1784 72195007      	bres	20487,#4
8236                     ; 2044 GPIOB->CR1&=~(1<<4);
8238  1788 72195008      	bres	20488,#4
8239                     ; 2045 GPIOB->CR2&=~(1<<4);
8241  178c 72195009      	bres	20489,#4
8242                     ; 2047 GPIOB->DDR&=~(1<<5);
8244  1790 721b5007      	bres	20487,#5
8245                     ; 2048 GPIOB->CR1&=~(1<<5);
8247  1794 721b5008      	bres	20488,#5
8248                     ; 2049 GPIOB->CR2&=~(1<<5);
8250  1798 721b5009      	bres	20489,#5
8251                     ; 2051 GPIOB->DDR&=~(1<<6);
8253  179c 721d5007      	bres	20487,#6
8254                     ; 2052 GPIOB->CR1&=~(1<<6);
8256  17a0 721d5008      	bres	20488,#6
8257                     ; 2053 GPIOB->CR2&=~(1<<6);
8259  17a4 721d5009      	bres	20489,#6
8260                     ; 2055 GPIOB->DDR&=~(1<<7);
8262  17a8 721f5007      	bres	20487,#7
8263                     ; 2056 GPIOB->CR1&=~(1<<7);
8265  17ac 721f5008      	bres	20488,#7
8266                     ; 2057 GPIOB->CR2&=~(1<<7);
8268  17b0 721f5009      	bres	20489,#7
8269                     ; 2059 GPIOB->DDR&=~(1<<2);
8271  17b4 72155007      	bres	20487,#2
8272                     ; 2060 GPIOB->CR1&=~(1<<2);
8274  17b8 72155008      	bres	20488,#2
8275                     ; 2061 GPIOB->CR2&=~(1<<2);
8277  17bc 72155009      	bres	20489,#2
8278                     ; 2070 ADC2->TDRL=0xff;
8280  17c0 35ff5407      	mov	21511,#255
8281                     ; 2072 ADC2->CR2=0x08;
8283  17c4 35085402      	mov	21506,#8
8284                     ; 2073 ADC2->CR1=0x60;
8286  17c8 35605401      	mov	21505,#96
8287                     ; 2076 	if(adc_ch==5)ADC2->CSR=0x22;
8289  17cc b6c6          	ld	a,_adc_ch
8290  17ce a105          	cp	a,#5
8291  17d0 2606          	jrne	L7743
8294  17d2 35225400      	mov	21504,#34
8296  17d6 2007          	jra	L1053
8297  17d8               L7743:
8298                     ; 2077 	else ADC2->CSR=0x20+adc_ch+3;
8300  17d8 b6c6          	ld	a,_adc_ch
8301  17da ab23          	add	a,#35
8302  17dc c75400        	ld	21504,a
8303  17df               L1053:
8304                     ; 2079 	ADC2->CR1|=1;
8306  17df 72105401      	bset	21505,#0
8307                     ; 2080 	ADC2->CR1|=1;
8309  17e3 72105401      	bset	21505,#0
8310                     ; 2083 adc_plazma[1]=adc_ch;
8312  17e7 b6c6          	ld	a,_adc_ch
8313  17e9 5f            	clrw	x
8314  17ea 97            	ld	xl,a
8315  17eb bfbb          	ldw	_adc_plazma+2,x
8316                     ; 2084 }
8319  17ed 81            	ret
8355                     ; 2092 @far @interrupt void TIM4_UPD_Interrupt (void) 
8355                     ; 2093 {
8357                     	switch	.text
8358  17ee               f_TIM4_UPD_Interrupt:
8362                     ; 2094 TIM4->SR1&=~TIM4_SR1_UIF;
8364  17ee 72115342      	bres	21314,#0
8365                     ; 2096 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8367  17f2 3c12          	inc	_pwm_vent_cnt
8368  17f4 b612          	ld	a,_pwm_vent_cnt
8369  17f6 a10a          	cp	a,#10
8370  17f8 2502          	jrult	L3153
8373  17fa 3f12          	clr	_pwm_vent_cnt
8374  17fc               L3153:
8375                     ; 2097 GPIOB->ODR|=(1<<3);
8377  17fc 72165005      	bset	20485,#3
8378                     ; 2098 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8380  1800 b612          	ld	a,_pwm_vent_cnt
8381  1802 a105          	cp	a,#5
8382  1804 2504          	jrult	L5153
8385  1806 72175005      	bres	20485,#3
8386  180a               L5153:
8387                     ; 2102 if(++t0_cnt00>=10)
8389  180a 9c            	rvf
8390  180b ce0000        	ldw	x,_t0_cnt00
8391  180e 1c0001        	addw	x,#1
8392  1811 cf0000        	ldw	_t0_cnt00,x
8393  1814 a3000a        	cpw	x,#10
8394  1817 2f08          	jrslt	L7153
8395                     ; 2104 	t0_cnt00=0;
8397  1819 5f            	clrw	x
8398  181a cf0000        	ldw	_t0_cnt00,x
8399                     ; 2105 	b1000Hz=1;
8401  181d 72100004      	bset	_b1000Hz
8402  1821               L7153:
8403                     ; 2108 if(++t0_cnt0>=100)
8405  1821 9c            	rvf
8406  1822 ce0002        	ldw	x,_t0_cnt0
8407  1825 1c0001        	addw	x,#1
8408  1828 cf0002        	ldw	_t0_cnt0,x
8409  182b a30064        	cpw	x,#100
8410  182e 2f54          	jrslt	L1253
8411                     ; 2110 	t0_cnt0=0;
8413  1830 5f            	clrw	x
8414  1831 cf0002        	ldw	_t0_cnt0,x
8415                     ; 2111 	b100Hz=1;
8417  1834 72100009      	bset	_b100Hz
8418                     ; 2113 	if(++t0_cnt1>=10)
8420  1838 725c0004      	inc	_t0_cnt1
8421  183c c60004        	ld	a,_t0_cnt1
8422  183f a10a          	cp	a,#10
8423  1841 2508          	jrult	L3253
8424                     ; 2115 		t0_cnt1=0;
8426  1843 725f0004      	clr	_t0_cnt1
8427                     ; 2116 		b10Hz=1;
8429  1847 72100008      	bset	_b10Hz
8430  184b               L3253:
8431                     ; 2119 	if(++t0_cnt2>=20)
8433  184b 725c0005      	inc	_t0_cnt2
8434  184f c60005        	ld	a,_t0_cnt2
8435  1852 a114          	cp	a,#20
8436  1854 2508          	jrult	L5253
8437                     ; 2121 		t0_cnt2=0;
8439  1856 725f0005      	clr	_t0_cnt2
8440                     ; 2122 		b5Hz=1;
8442  185a 72100007      	bset	_b5Hz
8443  185e               L5253:
8444                     ; 2126 	if(++t0_cnt4>=50)
8446  185e 725c0007      	inc	_t0_cnt4
8447  1862 c60007        	ld	a,_t0_cnt4
8448  1865 a132          	cp	a,#50
8449  1867 2508          	jrult	L7253
8450                     ; 2128 		t0_cnt4=0;
8452  1869 725f0007      	clr	_t0_cnt4
8453                     ; 2129 		b2Hz=1;
8455  186d 72100006      	bset	_b2Hz
8456  1871               L7253:
8457                     ; 2132 	if(++t0_cnt3>=100)
8459  1871 725c0006      	inc	_t0_cnt3
8460  1875 c60006        	ld	a,_t0_cnt3
8461  1878 a164          	cp	a,#100
8462  187a 2508          	jrult	L1253
8463                     ; 2134 		t0_cnt3=0;
8465  187c 725f0006      	clr	_t0_cnt3
8466                     ; 2135 		b1Hz=1;
8468  1880 72100005      	bset	_b1Hz
8469  1884               L1253:
8470                     ; 2141 }
8473  1884 80            	iret
8498                     ; 2144 @far @interrupt void CAN_RX_Interrupt (void) 
8498                     ; 2145 {
8499                     	switch	.text
8500  1885               f_CAN_RX_Interrupt:
8504                     ; 2147 CAN->PSR= 7;									// page 7 - read messsage
8506  1885 35075427      	mov	21543,#7
8507                     ; 2149 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8509  1889 ae000e        	ldw	x,#14
8510  188c               L632:
8511  188c d65427        	ld	a,(21543,x)
8512  188f e7c6          	ld	(_mess-1,x),a
8513  1891 5a            	decw	x
8514  1892 26f8          	jrne	L632
8515                     ; 2160 bCAN_RX=1;
8517  1894 35010004      	mov	_bCAN_RX,#1
8518                     ; 2161 CAN->RFR|=(1<<5);
8520  1898 721a5424      	bset	21540,#5
8521                     ; 2163 }
8524  189c 80            	iret
8547                     ; 2166 @far @interrupt void CAN_TX_Interrupt (void) 
8547                     ; 2167 {
8548                     	switch	.text
8549  189d               f_CAN_TX_Interrupt:
8553                     ; 2168 if((CAN->TSR)&(1<<0))
8555  189d c65422        	ld	a,21538
8556  18a0 a501          	bcp	a,#1
8557  18a2 2708          	jreq	L3553
8558                     ; 2170 	bTX_FREE=1;	
8560  18a4 35010003      	mov	_bTX_FREE,#1
8561                     ; 2172 	CAN->TSR|=(1<<0);
8563  18a8 72105422      	bset	21538,#0
8564  18ac               L3553:
8565                     ; 2174 }
8568  18ac 80            	iret
8648                     ; 2177 @far @interrupt void ADC2_EOC_Interrupt (void) {
8649                     	switch	.text
8650  18ad               f_ADC2_EOC_Interrupt:
8652       0000000d      OFST:	set	13
8653  18ad be00          	ldw	x,c_x
8654  18af 89            	pushw	x
8655  18b0 be00          	ldw	x,c_y
8656  18b2 89            	pushw	x
8657  18b3 be02          	ldw	x,c_lreg+2
8658  18b5 89            	pushw	x
8659  18b6 be00          	ldw	x,c_lreg
8660  18b8 89            	pushw	x
8661  18b9 520d          	subw	sp,#13
8664                     ; 2182 adc_plazma[2]++;
8666  18bb bebd          	ldw	x,_adc_plazma+4
8667  18bd 1c0001        	addw	x,#1
8668  18c0 bfbd          	ldw	_adc_plazma+4,x
8669                     ; 2189 ADC2->CSR&=~(1<<7);
8671  18c2 721f5400      	bres	21504,#7
8672                     ; 2191 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8674  18c6 c65405        	ld	a,21509
8675  18c9 b703          	ld	c_lreg+3,a
8676  18cb 3f02          	clr	c_lreg+2
8677  18cd 3f01          	clr	c_lreg+1
8678  18cf 3f00          	clr	c_lreg
8679  18d1 96            	ldw	x,sp
8680  18d2 1c0001        	addw	x,#OFST-12
8681  18d5 cd0000        	call	c_rtol
8683  18d8 c65404        	ld	a,21508
8684  18db 5f            	clrw	x
8685  18dc 97            	ld	xl,a
8686  18dd 90ae0100      	ldw	y,#256
8687  18e1 cd0000        	call	c_umul
8689  18e4 96            	ldw	x,sp
8690  18e5 1c0001        	addw	x,#OFST-12
8691  18e8 cd0000        	call	c_ladd
8693  18eb 96            	ldw	x,sp
8694  18ec 1c000a        	addw	x,#OFST-3
8695  18ef cd0000        	call	c_rtol
8697                     ; 2196 if(adr_drv_stat==1)
8699  18f2 b602          	ld	a,_adr_drv_stat
8700  18f4 a101          	cp	a,#1
8701  18f6 260b          	jrne	L3163
8702                     ; 2198 	adr_drv_stat=2;
8704  18f8 35020002      	mov	_adr_drv_stat,#2
8705                     ; 2199 	adc_buff_[0]=temp_adc;
8707  18fc 1e0c          	ldw	x,(OFST-1,sp)
8708  18fe cf00ff        	ldw	_adc_buff_,x
8710  1901 2020          	jra	L5163
8711  1903               L3163:
8712                     ; 2202 else if(adr_drv_stat==3)
8714  1903 b602          	ld	a,_adr_drv_stat
8715  1905 a103          	cp	a,#3
8716  1907 260b          	jrne	L7163
8717                     ; 2204 	adr_drv_stat=4;
8719  1909 35040002      	mov	_adr_drv_stat,#4
8720                     ; 2205 	adc_buff_[1]=temp_adc;
8722  190d 1e0c          	ldw	x,(OFST-1,sp)
8723  190f cf0101        	ldw	_adc_buff_+2,x
8725  1912 200f          	jra	L5163
8726  1914               L7163:
8727                     ; 2208 else if(adr_drv_stat==5)
8729  1914 b602          	ld	a,_adr_drv_stat
8730  1916 a105          	cp	a,#5
8731  1918 2609          	jrne	L5163
8732                     ; 2210 	adr_drv_stat=6;
8734  191a 35060002      	mov	_adr_drv_stat,#6
8735                     ; 2211 	adc_buff_[9]=temp_adc;
8737  191e 1e0c          	ldw	x,(OFST-1,sp)
8738  1920 cf0111        	ldw	_adc_buff_+18,x
8739  1923               L5163:
8740                     ; 2214 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8742  1923 b6b7          	ld	a,_adc_cnt_cnt
8743  1925 5f            	clrw	x
8744  1926 97            	ld	xl,a
8745  1927 58            	sllw	x
8746  1928 1f03          	ldw	(OFST-10,sp),x
8747  192a b6c6          	ld	a,_adc_ch
8748  192c 97            	ld	xl,a
8749  192d a610          	ld	a,#16
8750  192f 42            	mul	x,a
8751  1930 72fb03        	addw	x,(OFST-10,sp)
8752  1933 160c          	ldw	y,(OFST-1,sp)
8753  1935 df0056        	ldw	(_adc_buff_buff,x),y
8754                     ; 2216 adc_ch++;
8756  1938 3cc6          	inc	_adc_ch
8757                     ; 2217 if(adc_ch>=6)
8759  193a b6c6          	ld	a,_adc_ch
8760  193c a106          	cp	a,#6
8761  193e 2516          	jrult	L5263
8762                     ; 2219 	adc_ch=0;
8764  1940 3fc6          	clr	_adc_ch
8765                     ; 2220 	adc_cnt_cnt++;
8767  1942 3cb7          	inc	_adc_cnt_cnt
8768                     ; 2221 	if(adc_cnt_cnt>=8)
8770  1944 b6b7          	ld	a,_adc_cnt_cnt
8771  1946 a108          	cp	a,#8
8772  1948 250c          	jrult	L5263
8773                     ; 2223 		adc_cnt_cnt=0;
8775  194a 3fb7          	clr	_adc_cnt_cnt
8776                     ; 2224 		adc_cnt++;
8778  194c 3cc5          	inc	_adc_cnt
8779                     ; 2225 		if(adc_cnt>=16)
8781  194e b6c5          	ld	a,_adc_cnt
8782  1950 a110          	cp	a,#16
8783  1952 2502          	jrult	L5263
8784                     ; 2227 			adc_cnt=0;
8786  1954 3fc5          	clr	_adc_cnt
8787  1956               L5263:
8788                     ; 2231 if(adc_cnt_cnt==0)
8790  1956 3db7          	tnz	_adc_cnt_cnt
8791  1958 2660          	jrne	L3363
8792                     ; 2235 	tempSS=0;
8794  195a ae0000        	ldw	x,#0
8795  195d 1f07          	ldw	(OFST-6,sp),x
8796  195f ae0000        	ldw	x,#0
8797  1962 1f05          	ldw	(OFST-8,sp),x
8798                     ; 2236 	for(i=0;i<8;i++)
8800  1964 0f09          	clr	(OFST-4,sp)
8801  1966               L5363:
8802                     ; 2238 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8804  1966 7b09          	ld	a,(OFST-4,sp)
8805  1968 5f            	clrw	x
8806  1969 97            	ld	xl,a
8807  196a 58            	sllw	x
8808  196b 1f03          	ldw	(OFST-10,sp),x
8809  196d b6c6          	ld	a,_adc_ch
8810  196f 97            	ld	xl,a
8811  1970 a610          	ld	a,#16
8812  1972 42            	mul	x,a
8813  1973 72fb03        	addw	x,(OFST-10,sp)
8814  1976 de0056        	ldw	x,(_adc_buff_buff,x)
8815  1979 cd0000        	call	c_itolx
8817  197c 96            	ldw	x,sp
8818  197d 1c0005        	addw	x,#OFST-8
8819  1980 cd0000        	call	c_lgadd
8821                     ; 2236 	for(i=0;i<8;i++)
8823  1983 0c09          	inc	(OFST-4,sp)
8826  1985 7b09          	ld	a,(OFST-4,sp)
8827  1987 a108          	cp	a,#8
8828  1989 25db          	jrult	L5363
8829                     ; 2240 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8831  198b 96            	ldw	x,sp
8832  198c 1c0005        	addw	x,#OFST-8
8833  198f cd0000        	call	c_ltor
8835  1992 a603          	ld	a,#3
8836  1994 cd0000        	call	c_lrsh
8838  1997 be02          	ldw	x,c_lreg+2
8839  1999 b6c5          	ld	a,_adc_cnt
8840  199b 905f          	clrw	y
8841  199d 9097          	ld	yl,a
8842  199f 9058          	sllw	y
8843  19a1 1703          	ldw	(OFST-10,sp),y
8844  19a3 b6c6          	ld	a,_adc_ch
8845  19a5 905f          	clrw	y
8846  19a7 9097          	ld	yl,a
8847  19a9 9058          	sllw	y
8848  19ab 9058          	sllw	y
8849  19ad 9058          	sllw	y
8850  19af 9058          	sllw	y
8851  19b1 9058          	sllw	y
8852  19b3 72f903        	addw	y,(OFST-10,sp)
8853  19b6 90df0113      	ldw	(_adc_buff,y),x
8854  19ba               L3363:
8855                     ; 2244 if((adc_cnt&0x03)==0)
8857  19ba b6c5          	ld	a,_adc_cnt
8858  19bc a503          	bcp	a,#3
8859  19be 264b          	jrne	L3463
8860                     ; 2248 	tempSS=0;
8862  19c0 ae0000        	ldw	x,#0
8863  19c3 1f07          	ldw	(OFST-6,sp),x
8864  19c5 ae0000        	ldw	x,#0
8865  19c8 1f05          	ldw	(OFST-8,sp),x
8866                     ; 2249 	for(i=0;i<16;i++)
8868  19ca 0f09          	clr	(OFST-4,sp)
8869  19cc               L5463:
8870                     ; 2251 		tempSS+=(signed long)adc_buff[adc_ch][i];
8872  19cc 7b09          	ld	a,(OFST-4,sp)
8873  19ce 5f            	clrw	x
8874  19cf 97            	ld	xl,a
8875  19d0 58            	sllw	x
8876  19d1 1f03          	ldw	(OFST-10,sp),x
8877  19d3 b6c6          	ld	a,_adc_ch
8878  19d5 97            	ld	xl,a
8879  19d6 a620          	ld	a,#32
8880  19d8 42            	mul	x,a
8881  19d9 72fb03        	addw	x,(OFST-10,sp)
8882  19dc de0113        	ldw	x,(_adc_buff,x)
8883  19df cd0000        	call	c_itolx
8885  19e2 96            	ldw	x,sp
8886  19e3 1c0005        	addw	x,#OFST-8
8887  19e6 cd0000        	call	c_lgadd
8889                     ; 2249 	for(i=0;i<16;i++)
8891  19e9 0c09          	inc	(OFST-4,sp)
8894  19eb 7b09          	ld	a,(OFST-4,sp)
8895  19ed a110          	cp	a,#16
8896  19ef 25db          	jrult	L5463
8897                     ; 2253 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8899  19f1 96            	ldw	x,sp
8900  19f2 1c0005        	addw	x,#OFST-8
8901  19f5 cd0000        	call	c_ltor
8903  19f8 a604          	ld	a,#4
8904  19fa cd0000        	call	c_lrsh
8906  19fd be02          	ldw	x,c_lreg+2
8907  19ff b6c6          	ld	a,_adc_ch
8908  1a01 905f          	clrw	y
8909  1a03 9097          	ld	yl,a
8910  1a05 9058          	sllw	y
8911  1a07 90df00ff      	ldw	(_adc_buff_,y),x
8912  1a0b               L3463:
8913                     ; 2260 if(adc_ch==0)adc_buff_5=temp_adc;
8915  1a0b 3dc6          	tnz	_adc_ch
8916  1a0d 2605          	jrne	L3563
8919  1a0f 1e0c          	ldw	x,(OFST-1,sp)
8920  1a11 cf00fd        	ldw	_adc_buff_5,x
8921  1a14               L3563:
8922                     ; 2261 if(adc_ch==2)adc_buff_1=temp_adc;
8924  1a14 b6c6          	ld	a,_adc_ch
8925  1a16 a102          	cp	a,#2
8926  1a18 2605          	jrne	L5563
8929  1a1a 1e0c          	ldw	x,(OFST-1,sp)
8930  1a1c cf00fb        	ldw	_adc_buff_1,x
8931  1a1f               L5563:
8932                     ; 2263 adc_plazma_short++;
8934  1a1f bec3          	ldw	x,_adc_plazma_short
8935  1a21 1c0001        	addw	x,#1
8936  1a24 bfc3          	ldw	_adc_plazma_short,x
8937                     ; 2265 }
8940  1a26 5b0d          	addw	sp,#13
8941  1a28 85            	popw	x
8942  1a29 bf00          	ldw	c_lreg,x
8943  1a2b 85            	popw	x
8944  1a2c bf02          	ldw	c_lreg+2,x
8945  1a2e 85            	popw	x
8946  1a2f bf00          	ldw	c_y,x
8947  1a31 85            	popw	x
8948  1a32 bf00          	ldw	c_x,x
8949  1a34 80            	iret
9007                     ; 2274 main()
9007                     ; 2275 {
9009                     	switch	.text
9010  1a35               _main:
9014                     ; 2277 CLK->ECKR|=1;
9016  1a35 721050c1      	bset	20673,#0
9018  1a39               L1763:
9019                     ; 2278 while((CLK->ECKR & 2) == 0);
9021  1a39 c650c1        	ld	a,20673
9022  1a3c a502          	bcp	a,#2
9023  1a3e 27f9          	jreq	L1763
9024                     ; 2279 CLK->SWCR|=2;
9026  1a40 721250c5      	bset	20677,#1
9027                     ; 2280 CLK->SWR=0xB4;
9029  1a44 35b450c4      	mov	20676,#180
9030                     ; 2282 delay_ms(200);
9032  1a48 ae00c8        	ldw	x,#200
9033  1a4b cd0121        	call	_delay_ms
9035                     ; 2283 FLASH_DUKR=0xae;
9037  1a4e 35ae5064      	mov	_FLASH_DUKR,#174
9038                     ; 2284 FLASH_DUKR=0x56;
9040  1a52 35565064      	mov	_FLASH_DUKR,#86
9041                     ; 2285 enableInterrupts();
9044  1a56 9a            rim
9046                     ; 2288 adr_drv_v3();
9049  1a57 cd0d35        	call	_adr_drv_v3
9051                     ; 2292 t4_init();
9053  1a5a cd172f        	call	_t4_init
9055                     ; 2294 		GPIOG->DDR|=(1<<0);
9057  1a5d 72105020      	bset	20512,#0
9058                     ; 2295 		GPIOG->CR1|=(1<<0);
9060  1a61 72105021      	bset	20513,#0
9061                     ; 2296 		GPIOG->CR2&=~(1<<0);	
9063  1a65 72115022      	bres	20514,#0
9064                     ; 2299 		GPIOG->DDR&=~(1<<1);
9066  1a69 72135020      	bres	20512,#1
9067                     ; 2300 		GPIOG->CR1|=(1<<1);
9069  1a6d 72125021      	bset	20513,#1
9070                     ; 2301 		GPIOG->CR2&=~(1<<1);
9072  1a71 72135022      	bres	20514,#1
9073                     ; 2303 init_CAN();
9075  1a75 cd0f25        	call	_init_CAN
9077                     ; 2308 GPIOC->DDR|=(1<<1);
9079  1a78 7212500c      	bset	20492,#1
9080                     ; 2309 GPIOC->CR1|=(1<<1);
9082  1a7c 7212500d      	bset	20493,#1
9083                     ; 2310 GPIOC->CR2|=(1<<1);
9085  1a80 7212500e      	bset	20494,#1
9086                     ; 2312 GPIOC->DDR|=(1<<2);
9088  1a84 7214500c      	bset	20492,#2
9089                     ; 2313 GPIOC->CR1|=(1<<2);
9091  1a88 7214500d      	bset	20493,#2
9092                     ; 2314 GPIOC->CR2|=(1<<2);
9094  1a8c 7214500e      	bset	20494,#2
9095                     ; 2321 t1_init();
9097  1a90 cd1740        	call	_t1_init
9099                     ; 2323 GPIOA->DDR|=(1<<5);
9101  1a93 721a5002      	bset	20482,#5
9102                     ; 2324 GPIOA->CR1|=(1<<5);
9104  1a97 721a5003      	bset	20483,#5
9105                     ; 2325 GPIOA->CR2&=~(1<<5);
9107  1a9b 721b5004      	bres	20484,#5
9108                     ; 2331 GPIOB->DDR&=~(1<<3);
9110  1a9f 72175007      	bres	20487,#3
9111                     ; 2332 GPIOB->CR1&=~(1<<3);
9113  1aa3 72175008      	bres	20488,#3
9114                     ; 2333 GPIOB->CR2&=~(1<<3);
9116  1aa7 72175009      	bres	20489,#3
9117                     ; 2335 GPIOC->DDR|=(1<<3);
9119  1aab 7216500c      	bset	20492,#3
9120                     ; 2336 GPIOC->CR1|=(1<<3);
9122  1aaf 7216500d      	bset	20493,#3
9123                     ; 2337 GPIOC->CR2|=(1<<3);
9125  1ab3 7216500e      	bset	20494,#3
9126  1ab7               L5763:
9127                     ; 2343 	if(b1000Hz)
9129                     	btst	_b1000Hz
9130  1abc 2407          	jruge	L1073
9131                     ; 2345 		b1000Hz=0;
9133  1abe 72110004      	bres	_b1000Hz
9134                     ; 2347 		adc2_init();
9136  1ac2 cd177d        	call	_adc2_init
9138  1ac5               L1073:
9139                     ; 2350 	if(bCAN_RX)
9141  1ac5 3d04          	tnz	_bCAN_RX
9142  1ac7 2705          	jreq	L3073
9143                     ; 2352 		bCAN_RX=0;
9145  1ac9 3f04          	clr	_bCAN_RX
9146                     ; 2353 		can_in_an();	
9148  1acb cd1082        	call	_can_in_an
9150  1ace               L3073:
9151                     ; 2355 	if(b100Hz)
9153                     	btst	_b100Hz
9154  1ad3 2407          	jruge	L5073
9155                     ; 2357 		b100Hz=0;
9157  1ad5 72110009      	bres	_b100Hz
9158                     ; 2367 		can_tx_hndl();
9160  1ad9 cd1018        	call	_can_tx_hndl
9162  1adc               L5073:
9163                     ; 2370 	if(b10Hz)
9165                     	btst	_b10Hz
9166  1ae1 2425          	jruge	L7073
9167                     ; 2372 		b10Hz=0;
9169  1ae3 72110008      	bres	_b10Hz
9170                     ; 2374 		matemat();
9172  1ae7 cd085c        	call	_matemat
9174                     ; 2375 		led_drv(); 
9176  1aea cd03ee        	call	_led_drv
9178                     ; 2376 	  link_drv();
9180  1aed cd04dc        	call	_link_drv
9182                     ; 2378 	  JP_drv();
9184  1af0 cd0451        	call	_JP_drv
9186                     ; 2379 	  flags_drv();
9188  1af3 cd0cea        	call	_flags_drv
9190                     ; 2381 		if(main_cnt10<100)main_cnt10++;
9192  1af6 9c            	rvf
9193  1af7 ce0253        	ldw	x,_main_cnt10
9194  1afa a30064        	cpw	x,#100
9195  1afd 2e09          	jrsge	L7073
9198  1aff ce0253        	ldw	x,_main_cnt10
9199  1b02 1c0001        	addw	x,#1
9200  1b05 cf0253        	ldw	_main_cnt10,x
9201  1b08               L7073:
9202                     ; 2384 	if(b5Hz)
9204                     	btst	_b5Hz
9205  1b0d 241c          	jruge	L3173
9206                     ; 2386 		b5Hz=0;
9208  1b0f 72110007      	bres	_b5Hz
9209                     ; 2392 		pwr_drv();		//воздействие на силу
9211  1b13 cd06ac        	call	_pwr_drv
9213                     ; 2393 		led_hndl();
9215  1b16 cd0163        	call	_led_hndl
9217                     ; 2395 		vent_drv();
9219  1b19 cd0534        	call	_vent_drv
9221                     ; 2397 		if(main_cnt1<1000)main_cnt1++;
9223  1b1c 9c            	rvf
9224  1b1d be5b          	ldw	x,_main_cnt1
9225  1b1f a303e8        	cpw	x,#1000
9226  1b22 2e07          	jrsge	L3173
9229  1b24 be5b          	ldw	x,_main_cnt1
9230  1b26 1c0001        	addw	x,#1
9231  1b29 bf5b          	ldw	_main_cnt1,x
9232  1b2b               L3173:
9233                     ; 2400 	if(b2Hz)
9235                     	btst	_b2Hz
9236  1b30 2404          	jruge	L7173
9237                     ; 2402 		b2Hz=0;
9239  1b32 72110006      	bres	_b2Hz
9240  1b36               L7173:
9241                     ; 2411 	if(b1Hz)
9243                     	btst	_b1Hz
9244  1b3b 2503cc1ab7    	jruge	L5763
9245                     ; 2413 		b1Hz=0;
9247  1b40 72110005      	bres	_b1Hz
9248                     ; 2415 	  pwr_hndl();		//вычисление воздействий на силу
9250  1b44 cd06e4        	call	_pwr_hndl
9252                     ; 2416 		temper_drv();			//вычисление аварий температуры
9254  1b47 cd0a57        	call	_temper_drv
9256                     ; 2417 		u_drv();
9258  1b4a cd0b2e        	call	_u_drv
9260                     ; 2419 		if(main_cnt<1000)main_cnt++;
9262  1b4d 9c            	rvf
9263  1b4e ce0255        	ldw	x,_main_cnt
9264  1b51 a303e8        	cpw	x,#1000
9265  1b54 2e09          	jrsge	L3273
9268  1b56 ce0255        	ldw	x,_main_cnt
9269  1b59 1c0001        	addw	x,#1
9270  1b5c cf0255        	ldw	_main_cnt,x
9271  1b5f               L3273:
9272                     ; 2420   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9274  1b5f b66d          	ld	a,_link
9275  1b61 a1aa          	cp	a,#170
9276  1b63 2706          	jreq	L7273
9278  1b65 b654          	ld	a,_jp_mode
9279  1b67 a103          	cp	a,#3
9280  1b69 2603          	jrne	L5273
9281  1b6b               L7273:
9284  1b6b cd0c4b        	call	_apv_hndl
9286  1b6e               L5273:
9287                     ; 2423   		can_error_cnt++;
9289  1b6e 3c73          	inc	_can_error_cnt
9290                     ; 2424   		if(can_error_cnt>=10)
9292  1b70 b673          	ld	a,_can_error_cnt
9293  1b72 a10a          	cp	a,#10
9294  1b74 2505          	jrult	L1373
9295                     ; 2426   			can_error_cnt=0;
9297  1b76 3f73          	clr	_can_error_cnt
9298                     ; 2427 				init_CAN();
9300  1b78 cd0f25        	call	_init_CAN
9302  1b7b               L1373:
9303                     ; 2437 		vent_resurs_hndl();
9305  1b7b cd0000        	call	_vent_resurs_hndl
9307  1b7e acb71ab7      	jpf	L5763
10545                     	xdef	_main
10546                     	xdef	f_ADC2_EOC_Interrupt
10547                     	xdef	f_CAN_TX_Interrupt
10548                     	xdef	f_CAN_RX_Interrupt
10549                     	xdef	f_TIM4_UPD_Interrupt
10550                     	xdef	_adc2_init
10551                     	xdef	_t1_init
10552                     	xdef	_t4_init
10553                     	xdef	_can_in_an
10554                     	xdef	_can_tx_hndl
10555                     	xdef	_can_transmit
10556                     	xdef	_init_CAN
10557                     	xdef	_adr_drv_v3
10558                     	xdef	_adr_drv_v4
10559                     	xdef	_flags_drv
10560                     	xdef	_apv_hndl
10561                     	xdef	_apv_stop
10562                     	xdef	_apv_start
10563                     	xdef	_u_drv
10564                     	xdef	_temper_drv
10565                     	xdef	_matemat
10566                     	xdef	_pwr_hndl
10567                     	xdef	_pwr_drv
10568                     	xdef	_vent_drv
10569                     	xdef	_link_drv
10570                     	xdef	_JP_drv
10571                     	xdef	_led_drv
10572                     	xdef	_led_hndl
10573                     	xdef	_delay_ms
10574                     	xdef	_granee
10575                     	xdef	_gran
10576                     	xdef	_vent_resurs_hndl
10577                     	switch	.ubsct
10578  0001               _debug_info_to_uku:
10579  0001 000000000000  	ds.b	6
10580                     	xdef	_debug_info_to_uku
10581  0007               _pwm_u_cnt:
10582  0007 00            	ds.b	1
10583                     	xdef	_pwm_u_cnt
10584  0008               _vent_resurs_tx_cnt:
10585  0008 00            	ds.b	1
10586                     	xdef	_vent_resurs_tx_cnt
10587                     	switch	.bss
10588  0000               _vent_resurs_buff:
10589  0000 00000000      	ds.b	4
10590                     	xdef	_vent_resurs_buff
10591                     	switch	.ubsct
10592  0009               _vent_resurs_sec_cnt:
10593  0009 0000          	ds.b	2
10594                     	xdef	_vent_resurs_sec_cnt
10595                     .eeprom:	section	.data
10596  0000               _vent_resurs:
10597  0000 0000          	ds.b	2
10598                     	xdef	_vent_resurs
10599  0002               _ee_IMAXVENT:
10600  0002 0000          	ds.b	2
10601                     	xdef	_ee_IMAXVENT
10602                     	switch	.ubsct
10603  000b               _bps_class:
10604  000b 00            	ds.b	1
10605                     	xdef	_bps_class
10606  000c               _vent_pwm_integr_cnt:
10607  000c 0000          	ds.b	2
10608                     	xdef	_vent_pwm_integr_cnt
10609  000e               _vent_pwm_integr:
10610  000e 0000          	ds.b	2
10611                     	xdef	_vent_pwm_integr
10612  0010               _vent_pwm:
10613  0010 0000          	ds.b	2
10614                     	xdef	_vent_pwm
10615  0012               _pwm_vent_cnt:
10616  0012 00            	ds.b	1
10617                     	xdef	_pwm_vent_cnt
10618                     	switch	.eeprom
10619  0004               _ee_DEVICE:
10620  0004 0000          	ds.b	2
10621                     	xdef	_ee_DEVICE
10622  0006               _ee_AVT_MODE:
10623  0006 0000          	ds.b	2
10624                     	xdef	_ee_AVT_MODE
10625                     	switch	.ubsct
10626  0013               _i_main_bps_cnt:
10627  0013 000000000000  	ds.b	6
10628                     	xdef	_i_main_bps_cnt
10629  0019               _i_main_sigma:
10630  0019 0000          	ds.b	2
10631                     	xdef	_i_main_sigma
10632  001b               _i_main_num_of_bps:
10633  001b 00            	ds.b	1
10634                     	xdef	_i_main_num_of_bps
10635  001c               _i_main_avg:
10636  001c 0000          	ds.b	2
10637                     	xdef	_i_main_avg
10638  001e               _i_main_flag:
10639  001e 000000000000  	ds.b	6
10640                     	xdef	_i_main_flag
10641  0024               _i_main:
10642  0024 000000000000  	ds.b	12
10643                     	xdef	_i_main
10644  0030               _x:
10645  0030 000000000000  	ds.b	12
10646                     	xdef	_x
10647                     	xdef	_volum_u_main_
10648                     	switch	.eeprom
10649  0008               _UU_AVT:
10650  0008 0000          	ds.b	2
10651                     	xdef	_UU_AVT
10652                     	switch	.ubsct
10653  003c               _cnt_net_drv:
10654  003c 00            	ds.b	1
10655                     	xdef	_cnt_net_drv
10656                     	switch	.bit
10657  0001               _bMAIN:
10658  0001 00            	ds.b	1
10659                     	xdef	_bMAIN
10660                     	switch	.ubsct
10661  003d               _plazma_int:
10662  003d 000000000000  	ds.b	6
10663                     	xdef	_plazma_int
10664                     	xdef	_rotor_int
10665  0043               _led_green_buff:
10666  0043 00000000      	ds.b	4
10667                     	xdef	_led_green_buff
10668  0047               _led_red_buff:
10669  0047 00000000      	ds.b	4
10670                     	xdef	_led_red_buff
10671                     	xdef	_led_drv_cnt
10672                     	xdef	_led_green
10673                     	xdef	_led_red
10674  004b               _res_fl_cnt:
10675  004b 00            	ds.b	1
10676                     	xdef	_res_fl_cnt
10677                     	xdef	_bRES_
10678                     	xdef	_bRES
10679                     	switch	.eeprom
10680  000a               _res_fl_:
10681  000a 00            	ds.b	1
10682                     	xdef	_res_fl_
10683  000b               _res_fl:
10684  000b 00            	ds.b	1
10685                     	xdef	_res_fl
10686                     	switch	.ubsct
10687  004c               _cnt_apv_off:
10688  004c 00            	ds.b	1
10689                     	xdef	_cnt_apv_off
10690                     	switch	.bit
10691  0002               _bAPV:
10692  0002 00            	ds.b	1
10693                     	xdef	_bAPV
10694                     	switch	.ubsct
10695  004d               _apv_cnt_:
10696  004d 0000          	ds.b	2
10697                     	xdef	_apv_cnt_
10698  004f               _apv_cnt:
10699  004f 000000        	ds.b	3
10700                     	xdef	_apv_cnt
10701                     	xdef	_bBL_IPS
10702                     	switch	.bit
10703  0003               _bBL:
10704  0003 00            	ds.b	1
10705                     	xdef	_bBL
10706                     	switch	.ubsct
10707  0052               _cnt_JP1:
10708  0052 00            	ds.b	1
10709                     	xdef	_cnt_JP1
10710  0053               _cnt_JP0:
10711  0053 00            	ds.b	1
10712                     	xdef	_cnt_JP0
10713  0054               _jp_mode:
10714  0054 00            	ds.b	1
10715                     	xdef	_jp_mode
10716  0055               _pwm_u_:
10717  0055 0000          	ds.b	2
10718                     	xdef	_pwm_u_
10719                     	xdef	_pwm_i
10720                     	xdef	_pwm_u
10721  0057               _tmax_cnt:
10722  0057 0000          	ds.b	2
10723                     	xdef	_tmax_cnt
10724  0059               _tsign_cnt:
10725  0059 0000          	ds.b	2
10726                     	xdef	_tsign_cnt
10727                     	switch	.eeprom
10728  000c               _ee_UAVT:
10729  000c 0000          	ds.b	2
10730                     	xdef	_ee_UAVT
10731  000e               _ee_tsign:
10732  000e 0000          	ds.b	2
10733                     	xdef	_ee_tsign
10734  0010               _ee_tmax:
10735  0010 0000          	ds.b	2
10736                     	xdef	_ee_tmax
10737  0012               _ee_dU:
10738  0012 0000          	ds.b	2
10739                     	xdef	_ee_dU
10740  0014               _ee_Umax:
10741  0014 0000          	ds.b	2
10742                     	xdef	_ee_Umax
10743  0016               _ee_TZAS:
10744  0016 0000          	ds.b	2
10745                     	xdef	_ee_TZAS
10746                     	switch	.ubsct
10747  005b               _main_cnt1:
10748  005b 0000          	ds.b	2
10749                     	xdef	_main_cnt1
10750  005d               _off_bp_cnt:
10751  005d 00            	ds.b	1
10752                     	xdef	_off_bp_cnt
10753                     	xdef	_vol_i_temp_avar
10754  005e               _flags_tu_cnt_off:
10755  005e 00            	ds.b	1
10756                     	xdef	_flags_tu_cnt_off
10757  005f               _flags_tu_cnt_on:
10758  005f 00            	ds.b	1
10759                     	xdef	_flags_tu_cnt_on
10760  0060               _vol_i_temp:
10761  0060 0000          	ds.b	2
10762                     	xdef	_vol_i_temp
10763  0062               _vol_u_temp:
10764  0062 0000          	ds.b	2
10765                     	xdef	_vol_u_temp
10766                     	switch	.eeprom
10767  0018               __x_ee_:
10768  0018 0000          	ds.b	2
10769                     	xdef	__x_ee_
10770                     	switch	.ubsct
10771  0064               __x_cnt:
10772  0064 0000          	ds.b	2
10773                     	xdef	__x_cnt
10774  0066               __x__:
10775  0066 0000          	ds.b	2
10776                     	xdef	__x__
10777  0068               __x_:
10778  0068 0000          	ds.b	2
10779                     	xdef	__x_
10780  006a               _flags_tu:
10781  006a 00            	ds.b	1
10782                     	xdef	_flags_tu
10783                     	xdef	_flags
10784  006b               _link_cnt:
10785  006b 0000          	ds.b	2
10786                     	xdef	_link_cnt
10787  006d               _link:
10788  006d 00            	ds.b	1
10789                     	xdef	_link
10790  006e               _umin_cnt:
10791  006e 0000          	ds.b	2
10792                     	xdef	_umin_cnt
10793  0070               _umax_cnt:
10794  0070 0000          	ds.b	2
10795                     	xdef	_umax_cnt
10796                     	switch	.eeprom
10797  001a               _ee_K:
10798  001a 000000000000  	ds.b	20
10799                     	xdef	_ee_K
10800                     	switch	.ubsct
10801  0072               _T:
10802  0072 00            	ds.b	1
10803                     	xdef	_T
10804                     	switch	.bss
10805  0004               _Uin:
10806  0004 0000          	ds.b	2
10807                     	xdef	_Uin
10808  0006               _Usum:
10809  0006 0000          	ds.b	2
10810                     	xdef	_Usum
10811  0008               _U_out_const:
10812  0008 0000          	ds.b	2
10813                     	xdef	_U_out_const
10814  000a               _Unecc:
10815  000a 0000          	ds.b	2
10816                     	xdef	_Unecc
10817  000c               _Ui:
10818  000c 0000          	ds.b	2
10819                     	xdef	_Ui
10820  000e               _Un:
10821  000e 0000          	ds.b	2
10822                     	xdef	_Un
10823  0010               _I:
10824  0010 0000          	ds.b	2
10825                     	xdef	_I
10826                     	switch	.ubsct
10827  0073               _can_error_cnt:
10828  0073 00            	ds.b	1
10829                     	xdef	_can_error_cnt
10830                     	xdef	_bCAN_RX
10831  0074               _tx_busy_cnt:
10832  0074 00            	ds.b	1
10833                     	xdef	_tx_busy_cnt
10834                     	xdef	_bTX_FREE
10835  0075               _can_buff_rd_ptr:
10836  0075 00            	ds.b	1
10837                     	xdef	_can_buff_rd_ptr
10838  0076               _can_buff_wr_ptr:
10839  0076 00            	ds.b	1
10840                     	xdef	_can_buff_wr_ptr
10841  0077               _can_out_buff:
10842  0077 000000000000  	ds.b	64
10843                     	xdef	_can_out_buff
10844                     	switch	.bss
10845  0012               _pwm_u_buff_cnt:
10846  0012 00            	ds.b	1
10847                     	xdef	_pwm_u_buff_cnt
10848  0013               _pwm_u_buff_ptr:
10849  0013 00            	ds.b	1
10850                     	xdef	_pwm_u_buff_ptr
10851  0014               _pwm_u_buff_:
10852  0014 0000          	ds.b	2
10853                     	xdef	_pwm_u_buff_
10854  0016               _pwm_u_buff:
10855  0016 000000000000  	ds.b	64
10856                     	xdef	_pwm_u_buff
10857                     	switch	.ubsct
10858  00b7               _adc_cnt_cnt:
10859  00b7 00            	ds.b	1
10860                     	xdef	_adc_cnt_cnt
10861                     	switch	.bss
10862  0056               _adc_buff_buff:
10863  0056 000000000000  	ds.b	160
10864                     	xdef	_adc_buff_buff
10865  00f6               _adress_error:
10866  00f6 00            	ds.b	1
10867                     	xdef	_adress_error
10868  00f7               _adress:
10869  00f7 00            	ds.b	1
10870                     	xdef	_adress
10871  00f8               _adr:
10872  00f8 000000        	ds.b	3
10873                     	xdef	_adr
10874                     	xdef	_adr_drv_stat
10875                     	xdef	_led_ind
10876                     	switch	.ubsct
10877  00b8               _led_ind_cnt:
10878  00b8 00            	ds.b	1
10879                     	xdef	_led_ind_cnt
10880  00b9               _adc_plazma:
10881  00b9 000000000000  	ds.b	10
10882                     	xdef	_adc_plazma
10883  00c3               _adc_plazma_short:
10884  00c3 0000          	ds.b	2
10885                     	xdef	_adc_plazma_short
10886  00c5               _adc_cnt:
10887  00c5 00            	ds.b	1
10888                     	xdef	_adc_cnt
10889  00c6               _adc_ch:
10890  00c6 00            	ds.b	1
10891                     	xdef	_adc_ch
10892                     	switch	.bss
10893  00fb               _adc_buff_1:
10894  00fb 0000          	ds.b	2
10895                     	xdef	_adc_buff_1
10896  00fd               _adc_buff_5:
10897  00fd 0000          	ds.b	2
10898                     	xdef	_adc_buff_5
10899  00ff               _adc_buff_:
10900  00ff 000000000000  	ds.b	20
10901                     	xdef	_adc_buff_
10902  0113               _adc_buff:
10903  0113 000000000000  	ds.b	320
10904                     	xdef	_adc_buff
10905  0253               _main_cnt10:
10906  0253 0000          	ds.b	2
10907                     	xdef	_main_cnt10
10908  0255               _main_cnt:
10909  0255 0000          	ds.b	2
10910                     	xdef	_main_cnt
10911                     	switch	.ubsct
10912  00c7               _mess:
10913  00c7 000000000000  	ds.b	14
10914                     	xdef	_mess
10915                     	switch	.bit
10916  0004               _b1000Hz:
10917  0004 00            	ds.b	1
10918                     	xdef	_b1000Hz
10919  0005               _b1Hz:
10920  0005 00            	ds.b	1
10921                     	xdef	_b1Hz
10922  0006               _b2Hz:
10923  0006 00            	ds.b	1
10924                     	xdef	_b2Hz
10925  0007               _b5Hz:
10926  0007 00            	ds.b	1
10927                     	xdef	_b5Hz
10928  0008               _b10Hz:
10929  0008 00            	ds.b	1
10930                     	xdef	_b10Hz
10931  0009               _b100Hz:
10932  0009 00            	ds.b	1
10933                     	xdef	_b100Hz
10934                     	xdef	_t0_cnt4
10935                     	xdef	_t0_cnt3
10936                     	xdef	_t0_cnt2
10937                     	xdef	_t0_cnt1
10938                     	xdef	_t0_cnt0
10939                     	xdef	_t0_cnt00
10940                     	xref	_abs
10941                     	xdef	_bVENT_BLOCK
10942                     	xref.b	c_lreg
10943                     	xref.b	c_x
10944                     	xref.b	c_y
10964                     	xref	c_lrsh
10965                     	xref	c_umul
10966                     	xref	c_lgsub
10967                     	xref	c_lgrsh
10968                     	xref	c_lgadd
10969                     	xref	c_idiv
10970                     	xref	c_sdivx
10971                     	xref	c_imul
10972                     	xref	c_lsbc
10973                     	xref	c_ladd
10974                     	xref	c_lsub
10975                     	xref	c_ldiv
10976                     	xref	c_lgmul
10977                     	xref	c_itolx
10978                     	xref	c_eewrc
10979                     	xref	c_ltor
10980                     	xref	c_lgadc
10981                     	xref	c_rtol
10982                     	xref	c_vmul
10983                     	xref	c_eewrw
10984                     	xref	c_lcmp
10985                     	xref	c_uitolx
10986                     	end
