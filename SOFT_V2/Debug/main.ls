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
4140                     	switch	.const
4141  0018               L45:
4142  0018 0000028a      	dc.l	650
4143                     ; 819 void pwr_hndl(void)				
4143                     ; 820 {
4144                     	switch	.text
4145  06f4               _pwr_hndl:
4147  06f4 5205          	subw	sp,#5
4148       00000005      OFST:	set	5
4151                     ; 821 if(jp_mode==jp3)
4153  06f6 b654          	ld	a,_jp_mode
4154  06f8 a103          	cp	a,#3
4155  06fa 260a          	jrne	L3712
4156                     ; 823 	pwm_u=0;
4158  06fc 5f            	clrw	x
4159  06fd bf08          	ldw	_pwm_u,x
4160                     ; 824 	pwm_i=0;
4162  06ff 5f            	clrw	x
4163  0700 bf0a          	ldw	_pwm_i,x
4165  0702 ac5a085a      	jpf	L5712
4166  0706               L3712:
4167                     ; 826 else if(jp_mode==jp2)
4169  0706 b654          	ld	a,_jp_mode
4170  0708 a102          	cp	a,#2
4171  070a 260c          	jrne	L7712
4172                     ; 828 	pwm_u=0;
4174  070c 5f            	clrw	x
4175  070d bf08          	ldw	_pwm_u,x
4176                     ; 829 	pwm_i=0x7ff;
4178  070f ae07ff        	ldw	x,#2047
4179  0712 bf0a          	ldw	_pwm_i,x
4181  0714 ac5a085a      	jpf	L5712
4182  0718               L7712:
4183                     ; 831 else if(jp_mode==jp1)
4185  0718 b654          	ld	a,_jp_mode
4186  071a a101          	cp	a,#1
4187  071c 260e          	jrne	L3022
4188                     ; 833 	pwm_u=0x7ff;
4190  071e ae07ff        	ldw	x,#2047
4191  0721 bf08          	ldw	_pwm_u,x
4192                     ; 834 	pwm_i=0x7ff;
4194  0723 ae07ff        	ldw	x,#2047
4195  0726 bf0a          	ldw	_pwm_i,x
4197  0728 ac5a085a      	jpf	L5712
4198  072c               L3022:
4199                     ; 845 else if(link==OFF)
4201  072c b66d          	ld	a,_link
4202  072e a1aa          	cp	a,#170
4203  0730 2703          	jreq	L65
4204  0732 cc07d9        	jp	L7022
4205  0735               L65:
4206                     ; 847 	pwm_i=0x7ff;
4208  0735 ae07ff        	ldw	x,#2047
4209  0738 bf0a          	ldw	_pwm_i,x
4210                     ; 848 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4212  073a ce000a        	ldw	x,_Unecc
4213  073d 90ae07d0      	ldw	y,#2000
4214  0741 cd0000        	call	c_vmul
4216  0744 ae0018        	ldw	x,#L45
4217  0747 cd0000        	call	c_ldiv
4219  074a be02          	ldw	x,c_lreg+2
4220  074c bf55          	ldw	_pwm_u_,x
4221                     ; 852 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4223  074e c60013        	ld	a,_pwm_u_buff_ptr
4224  0751 5f            	clrw	x
4225  0752 97            	ld	xl,a
4226  0753 58            	sllw	x
4227  0754 90be55        	ldw	y,_pwm_u_
4228  0757 df0016        	ldw	(_pwm_u_buff,x),y
4229                     ; 853 	pwm_u_buff_ptr++;
4231  075a 725c0013      	inc	_pwm_u_buff_ptr
4232                     ; 854 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4234  075e c60013        	ld	a,_pwm_u_buff_ptr
4235  0761 a110          	cp	a,#16
4236  0763 2504          	jrult	L1122
4239  0765 725f0013      	clr	_pwm_u_buff_ptr
4240  0769               L1122:
4241                     ; 858 		tempSL=0;
4243  0769 ae0000        	ldw	x,#0
4244  076c 1f03          	ldw	(OFST-2,sp),x
4245  076e ae0000        	ldw	x,#0
4246  0771 1f01          	ldw	(OFST-4,sp),x
4247                     ; 859 		for(i=0;i<16;i++)
4249  0773 0f05          	clr	(OFST+0,sp)
4250  0775               L3122:
4251                     ; 861 			tempSL+=(signed long)pwm_u_buff[i];
4253  0775 7b05          	ld	a,(OFST+0,sp)
4254  0777 5f            	clrw	x
4255  0778 97            	ld	xl,a
4256  0779 58            	sllw	x
4257  077a de0016        	ldw	x,(_pwm_u_buff,x)
4258  077d cd0000        	call	c_itolx
4260  0780 96            	ldw	x,sp
4261  0781 1c0001        	addw	x,#OFST-4
4262  0784 cd0000        	call	c_lgadd
4264                     ; 859 		for(i=0;i<16;i++)
4266  0787 0c05          	inc	(OFST+0,sp)
4269  0789 7b05          	ld	a,(OFST+0,sp)
4270  078b a110          	cp	a,#16
4271  078d 25e6          	jrult	L3122
4272                     ; 863 		tempSL>>=4;
4274  078f 96            	ldw	x,sp
4275  0790 1c0001        	addw	x,#OFST-4
4276  0793 a604          	ld	a,#4
4277  0795 cd0000        	call	c_lgrsh
4279                     ; 864 		pwm_u_buff_=(signed short)tempSL;
4281  0798 1e03          	ldw	x,(OFST-2,sp)
4282  079a cf0014        	ldw	_pwm_u_buff_,x
4283                     ; 866 	pwm_u=pwm_u_;
4285  079d be55          	ldw	x,_pwm_u_
4286  079f bf08          	ldw	_pwm_u,x
4287                     ; 867 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4289  07a1 9c            	rvf
4290  07a2 ce000c        	ldw	x,_Ui
4291  07a5 72b0000a      	subw	x,_Unecc
4292  07a9 cd0000        	call	_abs
4294  07ac a30014        	cpw	x,#20
4295  07af 2e06          	jrsge	L1222
4298  07b1 725c0012      	inc	_pwm_u_buff_cnt
4300  07b5 2004          	jra	L3222
4301  07b7               L1222:
4302                     ; 868 	else pwm_u_buff_cnt=0;
4304  07b7 725f0012      	clr	_pwm_u_buff_cnt
4305  07bb               L3222:
4306                     ; 870 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4308  07bb c60012        	ld	a,_pwm_u_buff_cnt
4309  07be a114          	cp	a,#20
4310  07c0 2504          	jrult	L5222
4313  07c2 35140012      	mov	_pwm_u_buff_cnt,#20
4314  07c6               L5222:
4315                     ; 871 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4317  07c6 c60012        	ld	a,_pwm_u_buff_cnt
4318  07c9 a10f          	cp	a,#15
4319  07cb 2403          	jruge	L06
4320  07cd cc085a        	jp	L5712
4321  07d0               L06:
4324  07d0 ce0014        	ldw	x,_pwm_u_buff_
4325  07d3 bf08          	ldw	_pwm_u,x
4326  07d5 ac5a085a      	jpf	L5712
4327  07d9               L7022:
4328                     ; 875 else	if(link==ON)				//если есть связьvol_i_temp_avar
4330  07d9 b66d          	ld	a,_link
4331  07db a155          	cp	a,#85
4332  07dd 267b          	jrne	L5712
4333                     ; 877 	if((flags&0b00100000)==0)	//если нет блокировки извне
4335  07df b605          	ld	a,_flags
4336  07e1 a520          	bcp	a,#32
4337  07e3 2669          	jrne	L5322
4338                     ; 879 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4340  07e5 b605          	ld	a,_flags
4341  07e7 a51a          	bcp	a,#26
4342  07e9 260b          	jrne	L7322
4343                     ; 881 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4345  07eb be60          	ldw	x,_vol_i_temp
4346  07ed bf08          	ldw	_pwm_u,x
4347                     ; 882 			pwm_i=2000;
4349  07ef ae07d0        	ldw	x,#2000
4350  07f2 bf0a          	ldw	_pwm_i,x
4352  07f4 200c          	jra	L1422
4353  07f6               L7322:
4354                     ; 884 		else if(flags&0b00011010)					//если есть аварии
4356  07f6 b605          	ld	a,_flags
4357  07f8 a51a          	bcp	a,#26
4358  07fa 2706          	jreq	L1422
4359                     ; 886 			pwm_u=0;								//то полный стоп
4361  07fc 5f            	clrw	x
4362  07fd bf08          	ldw	_pwm_u,x
4363                     ; 887 			pwm_i=0;
4365  07ff 5f            	clrw	x
4366  0800 bf0a          	ldw	_pwm_i,x
4367  0802               L1422:
4368                     ; 890 		if(vol_i_temp==2000)
4370  0802 be60          	ldw	x,_vol_i_temp
4371  0804 a307d0        	cpw	x,#2000
4372  0807 260c          	jrne	L5422
4373                     ; 892 			pwm_u=2000;
4375  0809 ae07d0        	ldw	x,#2000
4376  080c bf08          	ldw	_pwm_u,x
4377                     ; 893 			pwm_i=2000;
4379  080e ae07d0        	ldw	x,#2000
4380  0811 bf0a          	ldw	_pwm_i,x
4382  0813 201d          	jra	L7422
4383  0815               L5422:
4384                     ; 898 			tempI=(int)(Ui-Unecc);
4386  0815 ce000c        	ldw	x,_Ui
4387  0818 72b0000a      	subw	x,_Unecc
4388  081c 1f04          	ldw	(OFST-1,sp),x
4389                     ; 899 			if((tempI>20)||(tempI<-80))pwm_u_cnt=19;
4391  081e 9c            	rvf
4392  081f 1e04          	ldw	x,(OFST-1,sp)
4393  0821 a30015        	cpw	x,#21
4394  0824 2e08          	jrsge	L3522
4396  0826 9c            	rvf
4397  0827 1e04          	ldw	x,(OFST-1,sp)
4398  0829 a3ffb0        	cpw	x,#65456
4399  082c 2e04          	jrsge	L7422
4400  082e               L3522:
4403  082e 35130007      	mov	_pwm_u_cnt,#19
4404  0832               L7422:
4405                     ; 903 		if(pwm_u_cnt)
4407  0832 3d07          	tnz	_pwm_u_cnt
4408  0834 2724          	jreq	L5712
4409                     ; 905 			pwm_u_cnt--;
4411  0836 3a07          	dec	_pwm_u_cnt
4412                     ; 906 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4414  0838 ce000a        	ldw	x,_Unecc
4415  083b 90ae07d0      	ldw	y,#2000
4416  083f cd0000        	call	c_vmul
4418  0842 ae0018        	ldw	x,#L45
4419  0845 cd0000        	call	c_ldiv
4421  0848 be02          	ldw	x,c_lreg+2
4422  084a bf08          	ldw	_pwm_u,x
4423  084c 200c          	jra	L5712
4424  084e               L5322:
4425                     ; 909 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4427  084e b605          	ld	a,_flags
4428  0850 a520          	bcp	a,#32
4429  0852 2706          	jreq	L5712
4430                     ; 911 		pwm_u=0;
4432  0854 5f            	clrw	x
4433  0855 bf08          	ldw	_pwm_u,x
4434                     ; 912 		pwm_i=0;
4436  0857 5f            	clrw	x
4437  0858 bf0a          	ldw	_pwm_i,x
4438  085a               L5712:
4439                     ; 940 if(pwm_u>2000)pwm_u=2000;
4441  085a 9c            	rvf
4442  085b be08          	ldw	x,_pwm_u
4443  085d a307d1        	cpw	x,#2001
4444  0860 2f05          	jrslt	L3622
4447  0862 ae07d0        	ldw	x,#2000
4448  0865 bf08          	ldw	_pwm_u,x
4449  0867               L3622:
4450                     ; 941 if(pwm_i>2000)pwm_i=2000;
4452  0867 9c            	rvf
4453  0868 be0a          	ldw	x,_pwm_i
4454  086a a307d1        	cpw	x,#2001
4455  086d 2f05          	jrslt	L5622
4458  086f ae07d0        	ldw	x,#2000
4459  0872 bf0a          	ldw	_pwm_i,x
4460  0874               L5622:
4461                     ; 944 }
4464  0874 5b05          	addw	sp,#5
4465  0876 81            	ret
4518                     	switch	.const
4519  001c               L46:
4520  001c 00000258      	dc.l	600
4521  0020               L66:
4522  0020 000003e8      	dc.l	1000
4523  0024               L07:
4524  0024 00000708      	dc.l	1800
4525                     ; 947 void matemat(void)
4525                     ; 948 {
4526                     	switch	.text
4527  0877               _matemat:
4529  0877 5208          	subw	sp,#8
4530       00000008      OFST:	set	8
4533                     ; 972 I=adc_buff_[4];
4535  0879 ce0107        	ldw	x,_adc_buff_+8
4536  087c cf0010        	ldw	_I,x
4537                     ; 973 temp_SL=adc_buff_[4];
4539  087f ce0107        	ldw	x,_adc_buff_+8
4540  0882 cd0000        	call	c_itolx
4542  0885 96            	ldw	x,sp
4543  0886 1c0005        	addw	x,#OFST-3
4544  0889 cd0000        	call	c_rtol
4546                     ; 974 temp_SL-=ee_K[0][0];
4548  088c ce001a        	ldw	x,_ee_K
4549  088f cd0000        	call	c_itolx
4551  0892 96            	ldw	x,sp
4552  0893 1c0005        	addw	x,#OFST-3
4553  0896 cd0000        	call	c_lgsub
4555                     ; 975 if(temp_SL<0) temp_SL=0;
4557  0899 9c            	rvf
4558  089a 0d05          	tnz	(OFST-3,sp)
4559  089c 2e0a          	jrsge	L5032
4562  089e ae0000        	ldw	x,#0
4563  08a1 1f07          	ldw	(OFST-1,sp),x
4564  08a3 ae0000        	ldw	x,#0
4565  08a6 1f05          	ldw	(OFST-3,sp),x
4566  08a8               L5032:
4567                     ; 976 temp_SL*=ee_K[0][1];
4569  08a8 ce001c        	ldw	x,_ee_K+2
4570  08ab cd0000        	call	c_itolx
4572  08ae 96            	ldw	x,sp
4573  08af 1c0005        	addw	x,#OFST-3
4574  08b2 cd0000        	call	c_lgmul
4576                     ; 977 temp_SL/=600;
4578  08b5 96            	ldw	x,sp
4579  08b6 1c0005        	addw	x,#OFST-3
4580  08b9 cd0000        	call	c_ltor
4582  08bc ae001c        	ldw	x,#L46
4583  08bf cd0000        	call	c_ldiv
4585  08c2 96            	ldw	x,sp
4586  08c3 1c0005        	addw	x,#OFST-3
4587  08c6 cd0000        	call	c_rtol
4589                     ; 978 I=(signed short)temp_SL;
4591  08c9 1e07          	ldw	x,(OFST-1,sp)
4592  08cb cf0010        	ldw	_I,x
4593                     ; 981 temp_SL=(signed long)adc_buff_[1];//1;
4595                     ; 982 temp_SL=(signed long)adc_buff_[3];//1;
4597  08ce ce0105        	ldw	x,_adc_buff_+6
4598  08d1 cd0000        	call	c_itolx
4600  08d4 96            	ldw	x,sp
4601  08d5 1c0005        	addw	x,#OFST-3
4602  08d8 cd0000        	call	c_rtol
4604                     ; 984 if(temp_SL<0) temp_SL=0;
4606  08db 9c            	rvf
4607  08dc 0d05          	tnz	(OFST-3,sp)
4608  08de 2e0a          	jrsge	L7032
4611  08e0 ae0000        	ldw	x,#0
4612  08e3 1f07          	ldw	(OFST-1,sp),x
4613  08e5 ae0000        	ldw	x,#0
4614  08e8 1f05          	ldw	(OFST-3,sp),x
4615  08ea               L7032:
4616                     ; 985 temp_SL*=(signed long)ee_K[2][1];
4618  08ea ce0024        	ldw	x,_ee_K+10
4619  08ed cd0000        	call	c_itolx
4621  08f0 96            	ldw	x,sp
4622  08f1 1c0005        	addw	x,#OFST-3
4623  08f4 cd0000        	call	c_lgmul
4625                     ; 986 temp_SL/=1000L;
4627  08f7 96            	ldw	x,sp
4628  08f8 1c0005        	addw	x,#OFST-3
4629  08fb cd0000        	call	c_ltor
4631  08fe ae0020        	ldw	x,#L66
4632  0901 cd0000        	call	c_ldiv
4634  0904 96            	ldw	x,sp
4635  0905 1c0005        	addw	x,#OFST-3
4636  0908 cd0000        	call	c_rtol
4638                     ; 987 Ui=(unsigned short)temp_SL;
4640  090b 1e07          	ldw	x,(OFST-1,sp)
4641  090d cf000c        	ldw	_Ui,x
4642                     ; 989 temp_SL=(signed long)adc_buff_5;
4644  0910 ce00fd        	ldw	x,_adc_buff_5
4645  0913 cd0000        	call	c_itolx
4647  0916 96            	ldw	x,sp
4648  0917 1c0005        	addw	x,#OFST-3
4649  091a cd0000        	call	c_rtol
4651                     ; 991 if(temp_SL<0) temp_SL=0;
4653  091d 9c            	rvf
4654  091e 0d05          	tnz	(OFST-3,sp)
4655  0920 2e0a          	jrsge	L1132
4658  0922 ae0000        	ldw	x,#0
4659  0925 1f07          	ldw	(OFST-1,sp),x
4660  0927 ae0000        	ldw	x,#0
4661  092a 1f05          	ldw	(OFST-3,sp),x
4662  092c               L1132:
4663                     ; 992 temp_SL*=(signed long)ee_K[4][1];
4665  092c ce002c        	ldw	x,_ee_K+18
4666  092f cd0000        	call	c_itolx
4668  0932 96            	ldw	x,sp
4669  0933 1c0005        	addw	x,#OFST-3
4670  0936 cd0000        	call	c_lgmul
4672                     ; 993 temp_SL/=1000L;
4674  0939 96            	ldw	x,sp
4675  093a 1c0005        	addw	x,#OFST-3
4676  093d cd0000        	call	c_ltor
4678  0940 ae0020        	ldw	x,#L66
4679  0943 cd0000        	call	c_ldiv
4681  0946 96            	ldw	x,sp
4682  0947 1c0005        	addw	x,#OFST-3
4683  094a cd0000        	call	c_rtol
4685                     ; 994 Usum=(unsigned short)temp_SL;
4687  094d 1e07          	ldw	x,(OFST-1,sp)
4688  094f cf0006        	ldw	_Usum,x
4689                     ; 998 temp_SL=adc_buff_[3];
4691  0952 ce0105        	ldw	x,_adc_buff_+6
4692  0955 cd0000        	call	c_itolx
4694  0958 96            	ldw	x,sp
4695  0959 1c0005        	addw	x,#OFST-3
4696  095c cd0000        	call	c_rtol
4698                     ; 1000 if(temp_SL<0) temp_SL=0;
4700  095f 9c            	rvf
4701  0960 0d05          	tnz	(OFST-3,sp)
4702  0962 2e0a          	jrsge	L3132
4705  0964 ae0000        	ldw	x,#0
4706  0967 1f07          	ldw	(OFST-1,sp),x
4707  0969 ae0000        	ldw	x,#0
4708  096c 1f05          	ldw	(OFST-3,sp),x
4709  096e               L3132:
4710                     ; 1001 temp_SL*=ee_K[1][1];
4712  096e ce0020        	ldw	x,_ee_K+6
4713  0971 cd0000        	call	c_itolx
4715  0974 96            	ldw	x,sp
4716  0975 1c0005        	addw	x,#OFST-3
4717  0978 cd0000        	call	c_lgmul
4719                     ; 1002 temp_SL/=1800;
4721  097b 96            	ldw	x,sp
4722  097c 1c0005        	addw	x,#OFST-3
4723  097f cd0000        	call	c_ltor
4725  0982 ae0024        	ldw	x,#L07
4726  0985 cd0000        	call	c_ldiv
4728  0988 96            	ldw	x,sp
4729  0989 1c0005        	addw	x,#OFST-3
4730  098c cd0000        	call	c_rtol
4732                     ; 1003 Un=(unsigned short)temp_SL;
4734  098f 1e07          	ldw	x,(OFST-1,sp)
4735  0991 cf000e        	ldw	_Un,x
4736                     ; 1008 temp_SL=adc_buff_[2];
4738  0994 ce0103        	ldw	x,_adc_buff_+4
4739  0997 cd0000        	call	c_itolx
4741  099a 96            	ldw	x,sp
4742  099b 1c0005        	addw	x,#OFST-3
4743  099e cd0000        	call	c_rtol
4745                     ; 1009 temp_SL*=ee_K[3][1];
4747  09a1 ce0028        	ldw	x,_ee_K+14
4748  09a4 cd0000        	call	c_itolx
4750  09a7 96            	ldw	x,sp
4751  09a8 1c0005        	addw	x,#OFST-3
4752  09ab cd0000        	call	c_lgmul
4754                     ; 1010 temp_SL/=1000;
4756  09ae 96            	ldw	x,sp
4757  09af 1c0005        	addw	x,#OFST-3
4758  09b2 cd0000        	call	c_ltor
4760  09b5 ae0020        	ldw	x,#L66
4761  09b8 cd0000        	call	c_ldiv
4763  09bb 96            	ldw	x,sp
4764  09bc 1c0005        	addw	x,#OFST-3
4765  09bf cd0000        	call	c_rtol
4767                     ; 1011 T=(signed short)(temp_SL-273L);
4769  09c2 7b08          	ld	a,(OFST+0,sp)
4770  09c4 5f            	clrw	x
4771  09c5 4d            	tnz	a
4772  09c6 2a01          	jrpl	L27
4773  09c8 53            	cplw	x
4774  09c9               L27:
4775  09c9 97            	ld	xl,a
4776  09ca 1d0111        	subw	x,#273
4777  09cd 01            	rrwa	x,a
4778  09ce b772          	ld	_T,a
4779  09d0 02            	rlwa	x,a
4780                     ; 1012 if(T<-30)T=-30;
4782  09d1 9c            	rvf
4783  09d2 b672          	ld	a,_T
4784  09d4 a1e2          	cp	a,#226
4785  09d6 2e04          	jrsge	L5132
4788  09d8 35e20072      	mov	_T,#226
4789  09dc               L5132:
4790                     ; 1013 if(T>120)T=120;
4792  09dc 9c            	rvf
4793  09dd b672          	ld	a,_T
4794  09df a179          	cp	a,#121
4795  09e1 2f04          	jrslt	L7132
4798  09e3 35780072      	mov	_T,#120
4799  09e7               L7132:
4800                     ; 1017 Uin=Usum-Ui;
4802  09e7 ce0006        	ldw	x,_Usum
4803  09ea 72b0000c      	subw	x,_Ui
4804  09ee cf0004        	ldw	_Uin,x
4805                     ; 1018 if(link==ON)
4807  09f1 b66d          	ld	a,_link
4808  09f3 a155          	cp	a,#85
4809  09f5 260c          	jrne	L1232
4810                     ; 1020 	Unecc=U_out_const-Uin;
4812  09f7 ce0008        	ldw	x,_U_out_const
4813  09fa 72b00004      	subw	x,_Uin
4814  09fe cf000a        	ldw	_Unecc,x
4816  0a01 200a          	jra	L3232
4817  0a03               L1232:
4818                     ; 1029 else Unecc=ee_UAVT-Uin;
4820  0a03 ce000c        	ldw	x,_ee_UAVT
4821  0a06 72b00004      	subw	x,_Uin
4822  0a0a cf000a        	ldw	_Unecc,x
4823  0a0d               L3232:
4824                     ; 1037 if(Unecc<0)Unecc=0;
4826  0a0d 9c            	rvf
4827  0a0e ce000a        	ldw	x,_Unecc
4828  0a11 2e04          	jrsge	L5232
4831  0a13 5f            	clrw	x
4832  0a14 cf000a        	ldw	_Unecc,x
4833  0a17               L5232:
4834                     ; 1038 temp_SL=(signed long)(T-ee_tsign);
4836  0a17 5f            	clrw	x
4837  0a18 b672          	ld	a,_T
4838  0a1a 2a01          	jrpl	L47
4839  0a1c 53            	cplw	x
4840  0a1d               L47:
4841  0a1d 97            	ld	xl,a
4842  0a1e 72b0000e      	subw	x,_ee_tsign
4843  0a22 cd0000        	call	c_itolx
4845  0a25 96            	ldw	x,sp
4846  0a26 1c0005        	addw	x,#OFST-3
4847  0a29 cd0000        	call	c_rtol
4849                     ; 1039 temp_SL*=1000L;
4851  0a2c ae03e8        	ldw	x,#1000
4852  0a2f bf02          	ldw	c_lreg+2,x
4853  0a31 ae0000        	ldw	x,#0
4854  0a34 bf00          	ldw	c_lreg,x
4855  0a36 96            	ldw	x,sp
4856  0a37 1c0005        	addw	x,#OFST-3
4857  0a3a cd0000        	call	c_lgmul
4859                     ; 1040 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4861  0a3d ce0010        	ldw	x,_ee_tmax
4862  0a40 72b0000e      	subw	x,_ee_tsign
4863  0a44 cd0000        	call	c_itolx
4865  0a47 96            	ldw	x,sp
4866  0a48 1c0001        	addw	x,#OFST-7
4867  0a4b cd0000        	call	c_rtol
4869  0a4e 96            	ldw	x,sp
4870  0a4f 1c0005        	addw	x,#OFST-3
4871  0a52 cd0000        	call	c_ltor
4873  0a55 96            	ldw	x,sp
4874  0a56 1c0001        	addw	x,#OFST-7
4875  0a59 cd0000        	call	c_ldiv
4877  0a5c 96            	ldw	x,sp
4878  0a5d 1c0005        	addw	x,#OFST-3
4879  0a60 cd0000        	call	c_rtol
4881                     ; 1042 vol_i_temp_avar=(unsigned short)temp_SL; 
4883  0a63 1e07          	ldw	x,(OFST-1,sp)
4884  0a65 bf06          	ldw	_vol_i_temp_avar,x
4885                     ; 1044 debug_info_to_uku[0]=pwm_u;
4887  0a67 be08          	ldw	x,_pwm_u
4888  0a69 bf01          	ldw	_debug_info_to_uku,x
4889                     ; 1045 debug_info_to_uku[1]=vol_i_temp;
4891  0a6b be60          	ldw	x,_vol_i_temp
4892  0a6d bf03          	ldw	_debug_info_to_uku+2,x
4893                     ; 1047 }
4896  0a6f 5b08          	addw	sp,#8
4897  0a71 81            	ret
4928                     ; 1050 void temper_drv(void)		//1 Hz
4928                     ; 1051 {
4929                     	switch	.text
4930  0a72               _temper_drv:
4934                     ; 1053 if(T>ee_tsign) tsign_cnt++;
4936  0a72 9c            	rvf
4937  0a73 5f            	clrw	x
4938  0a74 b672          	ld	a,_T
4939  0a76 2a01          	jrpl	L001
4940  0a78 53            	cplw	x
4941  0a79               L001:
4942  0a79 97            	ld	xl,a
4943  0a7a c3000e        	cpw	x,_ee_tsign
4944  0a7d 2d09          	jrsle	L7332
4947  0a7f be59          	ldw	x,_tsign_cnt
4948  0a81 1c0001        	addw	x,#1
4949  0a84 bf59          	ldw	_tsign_cnt,x
4951  0a86 201d          	jra	L1432
4952  0a88               L7332:
4953                     ; 1054 else if (T<(ee_tsign-1)) tsign_cnt--;
4955  0a88 9c            	rvf
4956  0a89 ce000e        	ldw	x,_ee_tsign
4957  0a8c 5a            	decw	x
4958  0a8d 905f          	clrw	y
4959  0a8f b672          	ld	a,_T
4960  0a91 2a02          	jrpl	L201
4961  0a93 9053          	cplw	y
4962  0a95               L201:
4963  0a95 9097          	ld	yl,a
4964  0a97 90bf00        	ldw	c_y,y
4965  0a9a b300          	cpw	x,c_y
4966  0a9c 2d07          	jrsle	L1432
4969  0a9e be59          	ldw	x,_tsign_cnt
4970  0aa0 1d0001        	subw	x,#1
4971  0aa3 bf59          	ldw	_tsign_cnt,x
4972  0aa5               L1432:
4973                     ; 1056 gran(&tsign_cnt,0,60);
4975  0aa5 ae003c        	ldw	x,#60
4976  0aa8 89            	pushw	x
4977  0aa9 5f            	clrw	x
4978  0aaa 89            	pushw	x
4979  0aab ae0059        	ldw	x,#_tsign_cnt
4980  0aae cd00d5        	call	_gran
4982  0ab1 5b04          	addw	sp,#4
4983                     ; 1058 if(tsign_cnt>=55)
4985  0ab3 9c            	rvf
4986  0ab4 be59          	ldw	x,_tsign_cnt
4987  0ab6 a30037        	cpw	x,#55
4988  0ab9 2f16          	jrslt	L5432
4989                     ; 1060 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4991  0abb 3d54          	tnz	_jp_mode
4992  0abd 2606          	jrne	L3532
4994  0abf b605          	ld	a,_flags
4995  0ac1 a540          	bcp	a,#64
4996  0ac3 2706          	jreq	L1532
4997  0ac5               L3532:
4999  0ac5 b654          	ld	a,_jp_mode
5000  0ac7 a103          	cp	a,#3
5001  0ac9 2612          	jrne	L5532
5002  0acb               L1532:
5005  0acb 72140005      	bset	_flags,#2
5006  0acf 200c          	jra	L5532
5007  0ad1               L5432:
5008                     ; 1062 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5010  0ad1 9c            	rvf
5011  0ad2 be59          	ldw	x,_tsign_cnt
5012  0ad4 a30006        	cpw	x,#6
5013  0ad7 2e04          	jrsge	L5532
5016  0ad9 72150005      	bres	_flags,#2
5017  0add               L5532:
5018                     ; 1067 if(T>ee_tmax) tmax_cnt++;
5020  0add 9c            	rvf
5021  0ade 5f            	clrw	x
5022  0adf b672          	ld	a,_T
5023  0ae1 2a01          	jrpl	L401
5024  0ae3 53            	cplw	x
5025  0ae4               L401:
5026  0ae4 97            	ld	xl,a
5027  0ae5 c30010        	cpw	x,_ee_tmax
5028  0ae8 2d09          	jrsle	L1632
5031  0aea be57          	ldw	x,_tmax_cnt
5032  0aec 1c0001        	addw	x,#1
5033  0aef bf57          	ldw	_tmax_cnt,x
5035  0af1 201d          	jra	L3632
5036  0af3               L1632:
5037                     ; 1068 else if (T<(ee_tmax-1)) tmax_cnt--;
5039  0af3 9c            	rvf
5040  0af4 ce0010        	ldw	x,_ee_tmax
5041  0af7 5a            	decw	x
5042  0af8 905f          	clrw	y
5043  0afa b672          	ld	a,_T
5044  0afc 2a02          	jrpl	L601
5045  0afe 9053          	cplw	y
5046  0b00               L601:
5047  0b00 9097          	ld	yl,a
5048  0b02 90bf00        	ldw	c_y,y
5049  0b05 b300          	cpw	x,c_y
5050  0b07 2d07          	jrsle	L3632
5053  0b09 be57          	ldw	x,_tmax_cnt
5054  0b0b 1d0001        	subw	x,#1
5055  0b0e bf57          	ldw	_tmax_cnt,x
5056  0b10               L3632:
5057                     ; 1070 gran(&tmax_cnt,0,60);
5059  0b10 ae003c        	ldw	x,#60
5060  0b13 89            	pushw	x
5061  0b14 5f            	clrw	x
5062  0b15 89            	pushw	x
5063  0b16 ae0057        	ldw	x,#_tmax_cnt
5064  0b19 cd00d5        	call	_gran
5066  0b1c 5b04          	addw	sp,#4
5067                     ; 1072 if(tmax_cnt>=55)
5069  0b1e 9c            	rvf
5070  0b1f be57          	ldw	x,_tmax_cnt
5071  0b21 a30037        	cpw	x,#55
5072  0b24 2f16          	jrslt	L7632
5073                     ; 1074 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5075  0b26 3d54          	tnz	_jp_mode
5076  0b28 2606          	jrne	L5732
5078  0b2a b605          	ld	a,_flags
5079  0b2c a540          	bcp	a,#64
5080  0b2e 2706          	jreq	L3732
5081  0b30               L5732:
5083  0b30 b654          	ld	a,_jp_mode
5084  0b32 a103          	cp	a,#3
5085  0b34 2612          	jrne	L7732
5086  0b36               L3732:
5089  0b36 72120005      	bset	_flags,#1
5090  0b3a 200c          	jra	L7732
5091  0b3c               L7632:
5092                     ; 1076 else if (tmax_cnt<=5) flags&=0b11111101;
5094  0b3c 9c            	rvf
5095  0b3d be57          	ldw	x,_tmax_cnt
5096  0b3f a30006        	cpw	x,#6
5097  0b42 2e04          	jrsge	L7732
5100  0b44 72130005      	bres	_flags,#1
5101  0b48               L7732:
5102                     ; 1079 } 
5105  0b48 81            	ret
5137                     ; 1082 void u_drv(void)		//1Hz
5137                     ; 1083 { 
5138                     	switch	.text
5139  0b49               _u_drv:
5143                     ; 1084 if(jp_mode!=jp3)
5145  0b49 b654          	ld	a,_jp_mode
5146  0b4b a103          	cp	a,#3
5147  0b4d 2774          	jreq	L3142
5148                     ; 1086 	if(Ui>ee_Umax)umax_cnt++;
5150  0b4f 9c            	rvf
5151  0b50 ce000c        	ldw	x,_Ui
5152  0b53 c30014        	cpw	x,_ee_Umax
5153  0b56 2d09          	jrsle	L5142
5156  0b58 be70          	ldw	x,_umax_cnt
5157  0b5a 1c0001        	addw	x,#1
5158  0b5d bf70          	ldw	_umax_cnt,x
5160  0b5f 2003          	jra	L7142
5161  0b61               L5142:
5162                     ; 1087 	else umax_cnt=0;
5164  0b61 5f            	clrw	x
5165  0b62 bf70          	ldw	_umax_cnt,x
5166  0b64               L7142:
5167                     ; 1088 	gran(&umax_cnt,0,10);
5169  0b64 ae000a        	ldw	x,#10
5170  0b67 89            	pushw	x
5171  0b68 5f            	clrw	x
5172  0b69 89            	pushw	x
5173  0b6a ae0070        	ldw	x,#_umax_cnt
5174  0b6d cd00d5        	call	_gran
5176  0b70 5b04          	addw	sp,#4
5177                     ; 1089 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5179  0b72 9c            	rvf
5180  0b73 be70          	ldw	x,_umax_cnt
5181  0b75 a3000a        	cpw	x,#10
5182  0b78 2f04          	jrslt	L1242
5185  0b7a 72160005      	bset	_flags,#3
5186  0b7e               L1242:
5187                     ; 1092 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5189  0b7e 9c            	rvf
5190  0b7f ce000c        	ldw	x,_Ui
5191  0b82 c3000e        	cpw	x,_Un
5192  0b85 2e1d          	jrsge	L3242
5194  0b87 9c            	rvf
5195  0b88 ce000e        	ldw	x,_Un
5196  0b8b 72b0000c      	subw	x,_Ui
5197  0b8f c30012        	cpw	x,_ee_dU
5198  0b92 2d10          	jrsle	L3242
5200  0b94 c65005        	ld	a,20485
5201  0b97 a504          	bcp	a,#4
5202  0b99 2609          	jrne	L3242
5205  0b9b be6e          	ldw	x,_umin_cnt
5206  0b9d 1c0001        	addw	x,#1
5207  0ba0 bf6e          	ldw	_umin_cnt,x
5209  0ba2 2003          	jra	L5242
5210  0ba4               L3242:
5211                     ; 1093 	else umin_cnt=0;
5213  0ba4 5f            	clrw	x
5214  0ba5 bf6e          	ldw	_umin_cnt,x
5215  0ba7               L5242:
5216                     ; 1094 	gran(&umin_cnt,0,10);	
5218  0ba7 ae000a        	ldw	x,#10
5219  0baa 89            	pushw	x
5220  0bab 5f            	clrw	x
5221  0bac 89            	pushw	x
5222  0bad ae006e        	ldw	x,#_umin_cnt
5223  0bb0 cd00d5        	call	_gran
5225  0bb3 5b04          	addw	sp,#4
5226                     ; 1095 	if(umin_cnt>=10)flags|=0b00010000;	  
5228  0bb5 9c            	rvf
5229  0bb6 be6e          	ldw	x,_umin_cnt
5230  0bb8 a3000a        	cpw	x,#10
5231  0bbb 2f71          	jrslt	L1342
5234  0bbd 72180005      	bset	_flags,#4
5235  0bc1 206b          	jra	L1342
5236  0bc3               L3142:
5237                     ; 1097 else if(jp_mode==jp3)
5239  0bc3 b654          	ld	a,_jp_mode
5240  0bc5 a103          	cp	a,#3
5241  0bc7 2665          	jrne	L1342
5242                     ; 1099 	if(Ui>700)umax_cnt++;
5244  0bc9 9c            	rvf
5245  0bca ce000c        	ldw	x,_Ui
5246  0bcd a302bd        	cpw	x,#701
5247  0bd0 2f09          	jrslt	L5342
5250  0bd2 be70          	ldw	x,_umax_cnt
5251  0bd4 1c0001        	addw	x,#1
5252  0bd7 bf70          	ldw	_umax_cnt,x
5254  0bd9 2003          	jra	L7342
5255  0bdb               L5342:
5256                     ; 1100 	else umax_cnt=0;
5258  0bdb 5f            	clrw	x
5259  0bdc bf70          	ldw	_umax_cnt,x
5260  0bde               L7342:
5261                     ; 1101 	gran(&umax_cnt,0,10);
5263  0bde ae000a        	ldw	x,#10
5264  0be1 89            	pushw	x
5265  0be2 5f            	clrw	x
5266  0be3 89            	pushw	x
5267  0be4 ae0070        	ldw	x,#_umax_cnt
5268  0be7 cd00d5        	call	_gran
5270  0bea 5b04          	addw	sp,#4
5271                     ; 1102 	if(umax_cnt>=10)flags|=0b00001000;
5273  0bec 9c            	rvf
5274  0bed be70          	ldw	x,_umax_cnt
5275  0bef a3000a        	cpw	x,#10
5276  0bf2 2f04          	jrslt	L1442
5279  0bf4 72160005      	bset	_flags,#3
5280  0bf8               L1442:
5281                     ; 1105 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5283  0bf8 9c            	rvf
5284  0bf9 ce000c        	ldw	x,_Ui
5285  0bfc a300c8        	cpw	x,#200
5286  0bff 2e10          	jrsge	L3442
5288  0c01 c65005        	ld	a,20485
5289  0c04 a504          	bcp	a,#4
5290  0c06 2609          	jrne	L3442
5293  0c08 be6e          	ldw	x,_umin_cnt
5294  0c0a 1c0001        	addw	x,#1
5295  0c0d bf6e          	ldw	_umin_cnt,x
5297  0c0f 2003          	jra	L5442
5298  0c11               L3442:
5299                     ; 1106 	else umin_cnt=0;
5301  0c11 5f            	clrw	x
5302  0c12 bf6e          	ldw	_umin_cnt,x
5303  0c14               L5442:
5304                     ; 1107 	gran(&umin_cnt,0,10);	
5306  0c14 ae000a        	ldw	x,#10
5307  0c17 89            	pushw	x
5308  0c18 5f            	clrw	x
5309  0c19 89            	pushw	x
5310  0c1a ae006e        	ldw	x,#_umin_cnt
5311  0c1d cd00d5        	call	_gran
5313  0c20 5b04          	addw	sp,#4
5314                     ; 1108 	if(umin_cnt>=10)flags|=0b00010000;	  
5316  0c22 9c            	rvf
5317  0c23 be6e          	ldw	x,_umin_cnt
5318  0c25 a3000a        	cpw	x,#10
5319  0c28 2f04          	jrslt	L1342
5322  0c2a 72180005      	bset	_flags,#4
5323  0c2e               L1342:
5324                     ; 1110 }
5327  0c2e 81            	ret
5353                     ; 1135 void apv_start(void)
5353                     ; 1136 {
5354                     	switch	.text
5355  0c2f               _apv_start:
5359                     ; 1137 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5361  0c2f 3d4f          	tnz	_apv_cnt
5362  0c31 2624          	jrne	L1642
5364  0c33 3d50          	tnz	_apv_cnt+1
5365  0c35 2620          	jrne	L1642
5367  0c37 3d51          	tnz	_apv_cnt+2
5368  0c39 261c          	jrne	L1642
5370                     	btst	_bAPV
5371  0c40 2515          	jrult	L1642
5372                     ; 1139 	apv_cnt[0]=60;
5374  0c42 353c004f      	mov	_apv_cnt,#60
5375                     ; 1140 	apv_cnt[1]=60;
5377  0c46 353c0050      	mov	_apv_cnt+1,#60
5378                     ; 1141 	apv_cnt[2]=60;
5380  0c4a 353c0051      	mov	_apv_cnt+2,#60
5381                     ; 1142 	apv_cnt_=3600;
5383  0c4e ae0e10        	ldw	x,#3600
5384  0c51 bf4d          	ldw	_apv_cnt_,x
5385                     ; 1143 	bAPV=1;	
5387  0c53 72100002      	bset	_bAPV
5388  0c57               L1642:
5389                     ; 1145 }
5392  0c57 81            	ret
5418                     ; 1148 void apv_stop(void)
5418                     ; 1149 {
5419                     	switch	.text
5420  0c58               _apv_stop:
5424                     ; 1150 apv_cnt[0]=0;
5426  0c58 3f4f          	clr	_apv_cnt
5427                     ; 1151 apv_cnt[1]=0;
5429  0c5a 3f50          	clr	_apv_cnt+1
5430                     ; 1152 apv_cnt[2]=0;
5432  0c5c 3f51          	clr	_apv_cnt+2
5433                     ; 1153 apv_cnt_=0;	
5435  0c5e 5f            	clrw	x
5436  0c5f bf4d          	ldw	_apv_cnt_,x
5437                     ; 1154 bAPV=0;
5439  0c61 72110002      	bres	_bAPV
5440                     ; 1155 }
5443  0c65 81            	ret
5478                     ; 1159 void apv_hndl(void)
5478                     ; 1160 {
5479                     	switch	.text
5480  0c66               _apv_hndl:
5484                     ; 1161 if(apv_cnt[0])
5486  0c66 3d4f          	tnz	_apv_cnt
5487  0c68 271e          	jreq	L3052
5488                     ; 1163 	apv_cnt[0]--;
5490  0c6a 3a4f          	dec	_apv_cnt
5491                     ; 1164 	if(apv_cnt[0]==0)
5493  0c6c 3d4f          	tnz	_apv_cnt
5494  0c6e 265a          	jrne	L7052
5495                     ; 1166 		flags&=0b11100001;
5497  0c70 b605          	ld	a,_flags
5498  0c72 a4e1          	and	a,#225
5499  0c74 b705          	ld	_flags,a
5500                     ; 1167 		tsign_cnt=0;
5502  0c76 5f            	clrw	x
5503  0c77 bf59          	ldw	_tsign_cnt,x
5504                     ; 1168 		tmax_cnt=0;
5506  0c79 5f            	clrw	x
5507  0c7a bf57          	ldw	_tmax_cnt,x
5508                     ; 1169 		umax_cnt=0;
5510  0c7c 5f            	clrw	x
5511  0c7d bf70          	ldw	_umax_cnt,x
5512                     ; 1170 		umin_cnt=0;
5514  0c7f 5f            	clrw	x
5515  0c80 bf6e          	ldw	_umin_cnt,x
5516                     ; 1172 		led_drv_cnt=30;
5518  0c82 351e0016      	mov	_led_drv_cnt,#30
5519  0c86 2042          	jra	L7052
5520  0c88               L3052:
5521                     ; 1175 else if(apv_cnt[1])
5523  0c88 3d50          	tnz	_apv_cnt+1
5524  0c8a 271e          	jreq	L1152
5525                     ; 1177 	apv_cnt[1]--;
5527  0c8c 3a50          	dec	_apv_cnt+1
5528                     ; 1178 	if(apv_cnt[1]==0)
5530  0c8e 3d50          	tnz	_apv_cnt+1
5531  0c90 2638          	jrne	L7052
5532                     ; 1180 		flags&=0b11100001;
5534  0c92 b605          	ld	a,_flags
5535  0c94 a4e1          	and	a,#225
5536  0c96 b705          	ld	_flags,a
5537                     ; 1181 		tsign_cnt=0;
5539  0c98 5f            	clrw	x
5540  0c99 bf59          	ldw	_tsign_cnt,x
5541                     ; 1182 		tmax_cnt=0;
5543  0c9b 5f            	clrw	x
5544  0c9c bf57          	ldw	_tmax_cnt,x
5545                     ; 1183 		umax_cnt=0;
5547  0c9e 5f            	clrw	x
5548  0c9f bf70          	ldw	_umax_cnt,x
5549                     ; 1184 		umin_cnt=0;
5551  0ca1 5f            	clrw	x
5552  0ca2 bf6e          	ldw	_umin_cnt,x
5553                     ; 1186 		led_drv_cnt=30;
5555  0ca4 351e0016      	mov	_led_drv_cnt,#30
5556  0ca8 2020          	jra	L7052
5557  0caa               L1152:
5558                     ; 1189 else if(apv_cnt[2])
5560  0caa 3d51          	tnz	_apv_cnt+2
5561  0cac 271c          	jreq	L7052
5562                     ; 1191 	apv_cnt[2]--;
5564  0cae 3a51          	dec	_apv_cnt+2
5565                     ; 1192 	if(apv_cnt[2]==0)
5567  0cb0 3d51          	tnz	_apv_cnt+2
5568  0cb2 2616          	jrne	L7052
5569                     ; 1194 		flags&=0b11100001;
5571  0cb4 b605          	ld	a,_flags
5572  0cb6 a4e1          	and	a,#225
5573  0cb8 b705          	ld	_flags,a
5574                     ; 1195 		tsign_cnt=0;
5576  0cba 5f            	clrw	x
5577  0cbb bf59          	ldw	_tsign_cnt,x
5578                     ; 1196 		tmax_cnt=0;
5580  0cbd 5f            	clrw	x
5581  0cbe bf57          	ldw	_tmax_cnt,x
5582                     ; 1197 		umax_cnt=0;
5584  0cc0 5f            	clrw	x
5585  0cc1 bf70          	ldw	_umax_cnt,x
5586                     ; 1198 		umin_cnt=0;          
5588  0cc3 5f            	clrw	x
5589  0cc4 bf6e          	ldw	_umin_cnt,x
5590                     ; 1200 		led_drv_cnt=30;
5592  0cc6 351e0016      	mov	_led_drv_cnt,#30
5593  0cca               L7052:
5594                     ; 1204 if(apv_cnt_)
5596  0cca be4d          	ldw	x,_apv_cnt_
5597  0ccc 2712          	jreq	L3252
5598                     ; 1206 	apv_cnt_--;
5600  0cce be4d          	ldw	x,_apv_cnt_
5601  0cd0 1d0001        	subw	x,#1
5602  0cd3 bf4d          	ldw	_apv_cnt_,x
5603                     ; 1207 	if(apv_cnt_==0) 
5605  0cd5 be4d          	ldw	x,_apv_cnt_
5606  0cd7 2607          	jrne	L3252
5607                     ; 1209 		bAPV=0;
5609  0cd9 72110002      	bres	_bAPV
5610                     ; 1210 		apv_start();
5612  0cdd cd0c2f        	call	_apv_start
5614  0ce0               L3252:
5615                     ; 1214 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5617  0ce0 be6e          	ldw	x,_umin_cnt
5618  0ce2 261e          	jrne	L7252
5620  0ce4 be70          	ldw	x,_umax_cnt
5621  0ce6 261a          	jrne	L7252
5623  0ce8 c65005        	ld	a,20485
5624  0ceb a504          	bcp	a,#4
5625  0ced 2613          	jrne	L7252
5626                     ; 1216 	if(cnt_apv_off<20)
5628  0cef b64c          	ld	a,_cnt_apv_off
5629  0cf1 a114          	cp	a,#20
5630  0cf3 240f          	jruge	L5352
5631                     ; 1218 		cnt_apv_off++;
5633  0cf5 3c4c          	inc	_cnt_apv_off
5634                     ; 1219 		if(cnt_apv_off>=20)
5636  0cf7 b64c          	ld	a,_cnt_apv_off
5637  0cf9 a114          	cp	a,#20
5638  0cfb 2507          	jrult	L5352
5639                     ; 1221 			apv_stop();
5641  0cfd cd0c58        	call	_apv_stop
5643  0d00 2002          	jra	L5352
5644  0d02               L7252:
5645                     ; 1225 else cnt_apv_off=0;	
5647  0d02 3f4c          	clr	_cnt_apv_off
5648  0d04               L5352:
5649                     ; 1227 }
5652  0d04 81            	ret
5655                     	switch	.ubsct
5656  0000               L7352_flags_old:
5657  0000 00            	ds.b	1
5693                     ; 1230 void flags_drv(void)
5693                     ; 1231 {
5694                     	switch	.text
5695  0d05               _flags_drv:
5699                     ; 1233 if(jp_mode!=jp3) 
5701  0d05 b654          	ld	a,_jp_mode
5702  0d07 a103          	cp	a,#3
5703  0d09 2723          	jreq	L7552
5704                     ; 1235 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5706  0d0b b605          	ld	a,_flags
5707  0d0d a508          	bcp	a,#8
5708  0d0f 2706          	jreq	L5652
5710  0d11 b600          	ld	a,L7352_flags_old
5711  0d13 a508          	bcp	a,#8
5712  0d15 270c          	jreq	L3652
5713  0d17               L5652:
5715  0d17 b605          	ld	a,_flags
5716  0d19 a510          	bcp	a,#16
5717  0d1b 2726          	jreq	L1752
5719  0d1d b600          	ld	a,L7352_flags_old
5720  0d1f a510          	bcp	a,#16
5721  0d21 2620          	jrne	L1752
5722  0d23               L3652:
5723                     ; 1237     		if(link==OFF)apv_start();
5725  0d23 b66d          	ld	a,_link
5726  0d25 a1aa          	cp	a,#170
5727  0d27 261a          	jrne	L1752
5730  0d29 cd0c2f        	call	_apv_start
5732  0d2c 2015          	jra	L1752
5733  0d2e               L7552:
5734                     ; 1240 else if(jp_mode==jp3) 
5736  0d2e b654          	ld	a,_jp_mode
5737  0d30 a103          	cp	a,#3
5738  0d32 260f          	jrne	L1752
5739                     ; 1242 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5741  0d34 b605          	ld	a,_flags
5742  0d36 a508          	bcp	a,#8
5743  0d38 2709          	jreq	L1752
5745  0d3a b600          	ld	a,L7352_flags_old
5746  0d3c a508          	bcp	a,#8
5747  0d3e 2603          	jrne	L1752
5748                     ; 1244     		apv_start();
5750  0d40 cd0c2f        	call	_apv_start
5752  0d43               L1752:
5753                     ; 1247 flags_old=flags;
5755  0d43 450500        	mov	L7352_flags_old,_flags
5756                     ; 1249 } 
5759  0d46 81            	ret
5794                     ; 1386 void adr_drv_v4(char in)
5794                     ; 1387 {
5795                     	switch	.text
5796  0d47               _adr_drv_v4:
5800                     ; 1388 if(adress!=in)adress=in;
5802  0d47 c100f7        	cp	a,_adress
5803  0d4a 2703          	jreq	L5162
5806  0d4c c700f7        	ld	_adress,a
5807  0d4f               L5162:
5808                     ; 1389 }
5811  0d4f 81            	ret
5840                     ; 1392 void adr_drv_v3(void)
5840                     ; 1393 {
5841                     	switch	.text
5842  0d50               _adr_drv_v3:
5844  0d50 88            	push	a
5845       00000001      OFST:	set	1
5848                     ; 1399 GPIOB->DDR&=~(1<<0);
5850  0d51 72115007      	bres	20487,#0
5851                     ; 1400 GPIOB->CR1&=~(1<<0);
5853  0d55 72115008      	bres	20488,#0
5854                     ; 1401 GPIOB->CR2&=~(1<<0);
5856  0d59 72115009      	bres	20489,#0
5857                     ; 1402 ADC2->CR2=0x08;
5859  0d5d 35085402      	mov	21506,#8
5860                     ; 1403 ADC2->CR1=0x40;
5862  0d61 35405401      	mov	21505,#64
5863                     ; 1404 ADC2->CSR=0x20+0;
5865  0d65 35205400      	mov	21504,#32
5866                     ; 1405 ADC2->CR1|=1;
5868  0d69 72105401      	bset	21505,#0
5869                     ; 1406 ADC2->CR1|=1;
5871  0d6d 72105401      	bset	21505,#0
5872                     ; 1407 adr_drv_stat=1;
5874  0d71 35010002      	mov	_adr_drv_stat,#1
5875  0d75               L7262:
5876                     ; 1408 while(adr_drv_stat==1);
5879  0d75 b602          	ld	a,_adr_drv_stat
5880  0d77 a101          	cp	a,#1
5881  0d79 27fa          	jreq	L7262
5882                     ; 1410 GPIOB->DDR&=~(1<<1);
5884  0d7b 72135007      	bres	20487,#1
5885                     ; 1411 GPIOB->CR1&=~(1<<1);
5887  0d7f 72135008      	bres	20488,#1
5888                     ; 1412 GPIOB->CR2&=~(1<<1);
5890  0d83 72135009      	bres	20489,#1
5891                     ; 1413 ADC2->CR2=0x08;
5893  0d87 35085402      	mov	21506,#8
5894                     ; 1414 ADC2->CR1=0x40;
5896  0d8b 35405401      	mov	21505,#64
5897                     ; 1415 ADC2->CSR=0x20+1;
5899  0d8f 35215400      	mov	21504,#33
5900                     ; 1416 ADC2->CR1|=1;
5902  0d93 72105401      	bset	21505,#0
5903                     ; 1417 ADC2->CR1|=1;
5905  0d97 72105401      	bset	21505,#0
5906                     ; 1418 adr_drv_stat=3;
5908  0d9b 35030002      	mov	_adr_drv_stat,#3
5909  0d9f               L5362:
5910                     ; 1419 while(adr_drv_stat==3);
5913  0d9f b602          	ld	a,_adr_drv_stat
5914  0da1 a103          	cp	a,#3
5915  0da3 27fa          	jreq	L5362
5916                     ; 1421 GPIOE->DDR&=~(1<<6);
5918  0da5 721d5016      	bres	20502,#6
5919                     ; 1422 GPIOE->CR1&=~(1<<6);
5921  0da9 721d5017      	bres	20503,#6
5922                     ; 1423 GPIOE->CR2&=~(1<<6);
5924  0dad 721d5018      	bres	20504,#6
5925                     ; 1424 ADC2->CR2=0x08;
5927  0db1 35085402      	mov	21506,#8
5928                     ; 1425 ADC2->CR1=0x40;
5930  0db5 35405401      	mov	21505,#64
5931                     ; 1426 ADC2->CSR=0x20+9;
5933  0db9 35295400      	mov	21504,#41
5934                     ; 1427 ADC2->CR1|=1;
5936  0dbd 72105401      	bset	21505,#0
5937                     ; 1428 ADC2->CR1|=1;
5939  0dc1 72105401      	bset	21505,#0
5940                     ; 1429 adr_drv_stat=5;
5942  0dc5 35050002      	mov	_adr_drv_stat,#5
5943  0dc9               L3462:
5944                     ; 1430 while(adr_drv_stat==5);
5947  0dc9 b602          	ld	a,_adr_drv_stat
5948  0dcb a105          	cp	a,#5
5949  0dcd 27fa          	jreq	L3462
5950                     ; 1434 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5952  0dcf 9c            	rvf
5953  0dd0 ce00ff        	ldw	x,_adc_buff_
5954  0dd3 a3022a        	cpw	x,#554
5955  0dd6 2f0f          	jrslt	L1562
5957  0dd8 9c            	rvf
5958  0dd9 ce00ff        	ldw	x,_adc_buff_
5959  0ddc a30253        	cpw	x,#595
5960  0ddf 2e06          	jrsge	L1562
5963  0de1 725f00f8      	clr	_adr
5965  0de5 204c          	jra	L3562
5966  0de7               L1562:
5967                     ; 1435 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5969  0de7 9c            	rvf
5970  0de8 ce00ff        	ldw	x,_adc_buff_
5971  0deb a3036d        	cpw	x,#877
5972  0dee 2f0f          	jrslt	L5562
5974  0df0 9c            	rvf
5975  0df1 ce00ff        	ldw	x,_adc_buff_
5976  0df4 a30396        	cpw	x,#918
5977  0df7 2e06          	jrsge	L5562
5980  0df9 350100f8      	mov	_adr,#1
5982  0dfd 2034          	jra	L3562
5983  0dff               L5562:
5984                     ; 1436 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5986  0dff 9c            	rvf
5987  0e00 ce00ff        	ldw	x,_adc_buff_
5988  0e03 a302a3        	cpw	x,#675
5989  0e06 2f0f          	jrslt	L1662
5991  0e08 9c            	rvf
5992  0e09 ce00ff        	ldw	x,_adc_buff_
5993  0e0c a302cc        	cpw	x,#716
5994  0e0f 2e06          	jrsge	L1662
5997  0e11 350200f8      	mov	_adr,#2
5999  0e15 201c          	jra	L3562
6000  0e17               L1662:
6001                     ; 1437 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6003  0e17 9c            	rvf
6004  0e18 ce00ff        	ldw	x,_adc_buff_
6005  0e1b a303e3        	cpw	x,#995
6006  0e1e 2f0f          	jrslt	L5662
6008  0e20 9c            	rvf
6009  0e21 ce00ff        	ldw	x,_adc_buff_
6010  0e24 a3040c        	cpw	x,#1036
6011  0e27 2e06          	jrsge	L5662
6014  0e29 350300f8      	mov	_adr,#3
6016  0e2d 2004          	jra	L3562
6017  0e2f               L5662:
6018                     ; 1438 else adr[0]=5;
6020  0e2f 350500f8      	mov	_adr,#5
6021  0e33               L3562:
6022                     ; 1440 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6024  0e33 9c            	rvf
6025  0e34 ce0101        	ldw	x,_adc_buff_+2
6026  0e37 a3022a        	cpw	x,#554
6027  0e3a 2f0f          	jrslt	L1762
6029  0e3c 9c            	rvf
6030  0e3d ce0101        	ldw	x,_adc_buff_+2
6031  0e40 a30253        	cpw	x,#595
6032  0e43 2e06          	jrsge	L1762
6035  0e45 725f00f9      	clr	_adr+1
6037  0e49 204c          	jra	L3762
6038  0e4b               L1762:
6039                     ; 1441 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6041  0e4b 9c            	rvf
6042  0e4c ce0101        	ldw	x,_adc_buff_+2
6043  0e4f a3036d        	cpw	x,#877
6044  0e52 2f0f          	jrslt	L5762
6046  0e54 9c            	rvf
6047  0e55 ce0101        	ldw	x,_adc_buff_+2
6048  0e58 a30396        	cpw	x,#918
6049  0e5b 2e06          	jrsge	L5762
6052  0e5d 350100f9      	mov	_adr+1,#1
6054  0e61 2034          	jra	L3762
6055  0e63               L5762:
6056                     ; 1442 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6058  0e63 9c            	rvf
6059  0e64 ce0101        	ldw	x,_adc_buff_+2
6060  0e67 a302a3        	cpw	x,#675
6061  0e6a 2f0f          	jrslt	L1072
6063  0e6c 9c            	rvf
6064  0e6d ce0101        	ldw	x,_adc_buff_+2
6065  0e70 a302cc        	cpw	x,#716
6066  0e73 2e06          	jrsge	L1072
6069  0e75 350200f9      	mov	_adr+1,#2
6071  0e79 201c          	jra	L3762
6072  0e7b               L1072:
6073                     ; 1443 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6075  0e7b 9c            	rvf
6076  0e7c ce0101        	ldw	x,_adc_buff_+2
6077  0e7f a303e3        	cpw	x,#995
6078  0e82 2f0f          	jrslt	L5072
6080  0e84 9c            	rvf
6081  0e85 ce0101        	ldw	x,_adc_buff_+2
6082  0e88 a3040c        	cpw	x,#1036
6083  0e8b 2e06          	jrsge	L5072
6086  0e8d 350300f9      	mov	_adr+1,#3
6088  0e91 2004          	jra	L3762
6089  0e93               L5072:
6090                     ; 1444 else adr[1]=5;
6092  0e93 350500f9      	mov	_adr+1,#5
6093  0e97               L3762:
6094                     ; 1446 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6096  0e97 9c            	rvf
6097  0e98 ce0111        	ldw	x,_adc_buff_+18
6098  0e9b a3022a        	cpw	x,#554
6099  0e9e 2f0f          	jrslt	L1172
6101  0ea0 9c            	rvf
6102  0ea1 ce0111        	ldw	x,_adc_buff_+18
6103  0ea4 a30253        	cpw	x,#595
6104  0ea7 2e06          	jrsge	L1172
6107  0ea9 725f00fa      	clr	_adr+2
6109  0ead 204c          	jra	L3172
6110  0eaf               L1172:
6111                     ; 1447 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6113  0eaf 9c            	rvf
6114  0eb0 ce0111        	ldw	x,_adc_buff_+18
6115  0eb3 a3036d        	cpw	x,#877
6116  0eb6 2f0f          	jrslt	L5172
6118  0eb8 9c            	rvf
6119  0eb9 ce0111        	ldw	x,_adc_buff_+18
6120  0ebc a30396        	cpw	x,#918
6121  0ebf 2e06          	jrsge	L5172
6124  0ec1 350100fa      	mov	_adr+2,#1
6126  0ec5 2034          	jra	L3172
6127  0ec7               L5172:
6128                     ; 1448 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6130  0ec7 9c            	rvf
6131  0ec8 ce0111        	ldw	x,_adc_buff_+18
6132  0ecb a302a3        	cpw	x,#675
6133  0ece 2f0f          	jrslt	L1272
6135  0ed0 9c            	rvf
6136  0ed1 ce0111        	ldw	x,_adc_buff_+18
6137  0ed4 a302cc        	cpw	x,#716
6138  0ed7 2e06          	jrsge	L1272
6141  0ed9 350200fa      	mov	_adr+2,#2
6143  0edd 201c          	jra	L3172
6144  0edf               L1272:
6145                     ; 1449 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6147  0edf 9c            	rvf
6148  0ee0 ce0111        	ldw	x,_adc_buff_+18
6149  0ee3 a303e3        	cpw	x,#995
6150  0ee6 2f0f          	jrslt	L5272
6152  0ee8 9c            	rvf
6153  0ee9 ce0111        	ldw	x,_adc_buff_+18
6154  0eec a3040c        	cpw	x,#1036
6155  0eef 2e06          	jrsge	L5272
6158  0ef1 350300fa      	mov	_adr+2,#3
6160  0ef5 2004          	jra	L3172
6161  0ef7               L5272:
6162                     ; 1450 else adr[2]=5;
6164  0ef7 350500fa      	mov	_adr+2,#5
6165  0efb               L3172:
6166                     ; 1454 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6168  0efb c600f8        	ld	a,_adr
6169  0efe a105          	cp	a,#5
6170  0f00 270e          	jreq	L3372
6172  0f02 c600f9        	ld	a,_adr+1
6173  0f05 a105          	cp	a,#5
6174  0f07 2707          	jreq	L3372
6176  0f09 c600fa        	ld	a,_adr+2
6177  0f0c a105          	cp	a,#5
6178  0f0e 2606          	jrne	L1372
6179  0f10               L3372:
6180                     ; 1457 	adress_error=1;
6182  0f10 350100f6      	mov	_adress_error,#1
6184  0f14               L7372:
6185                     ; 1468 }
6188  0f14 84            	pop	a
6189  0f15 81            	ret
6190  0f16               L1372:
6191                     ; 1461 	if(adr[2]&0x02) bps_class=bpsIPS;
6193  0f16 c600fa        	ld	a,_adr+2
6194  0f19 a502          	bcp	a,#2
6195  0f1b 2706          	jreq	L1472
6198  0f1d 3501000b      	mov	_bps_class,#1
6200  0f21 2002          	jra	L3472
6201  0f23               L1472:
6202                     ; 1462 	else bps_class=bpsIBEP;
6204  0f23 3f0b          	clr	_bps_class
6205  0f25               L3472:
6206                     ; 1464 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6208  0f25 c600fa        	ld	a,_adr+2
6209  0f28 a401          	and	a,#1
6210  0f2a 97            	ld	xl,a
6211  0f2b a610          	ld	a,#16
6212  0f2d 42            	mul	x,a
6213  0f2e 9f            	ld	a,xl
6214  0f2f 6b01          	ld	(OFST+0,sp),a
6215  0f31 c600f9        	ld	a,_adr+1
6216  0f34 48            	sll	a
6217  0f35 48            	sll	a
6218  0f36 cb00f8        	add	a,_adr
6219  0f39 1b01          	add	a,(OFST+0,sp)
6220  0f3b c700f7        	ld	_adress,a
6221  0f3e 20d4          	jra	L7372
6244                     ; 1518 void init_CAN(void) {
6245                     	switch	.text
6246  0f40               _init_CAN:
6250                     ; 1519 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6252  0f40 72135420      	bres	21536,#1
6253                     ; 1520 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6255  0f44 72105420      	bset	21536,#0
6257  0f48               L7572:
6258                     ; 1521 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6260  0f48 c65421        	ld	a,21537
6261  0f4b a501          	bcp	a,#1
6262  0f4d 27f9          	jreq	L7572
6263                     ; 1523 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6265  0f4f 72185420      	bset	21536,#4
6266                     ; 1525 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6268  0f53 35025427      	mov	21543,#2
6269                     ; 1534 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6271  0f57 35135428      	mov	21544,#19
6272                     ; 1535 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6274  0f5b 35c05429      	mov	21545,#192
6275                     ; 1536 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6277  0f5f 357f542c      	mov	21548,#127
6278                     ; 1537 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6280  0f63 35e0542d      	mov	21549,#224
6281                     ; 1539 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6283  0f67 35315430      	mov	21552,#49
6284                     ; 1540 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6286  0f6b 35c05431      	mov	21553,#192
6287                     ; 1541 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6289  0f6f 357f5434      	mov	21556,#127
6290                     ; 1542 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6292  0f73 35e05435      	mov	21557,#224
6293                     ; 1546 	CAN->PSR= 6;									// set page 6
6295  0f77 35065427      	mov	21543,#6
6296                     ; 1551 	CAN->Page.Config.FMR1&=~3;								//mask mode
6298  0f7b c65430        	ld	a,21552
6299  0f7e a4fc          	and	a,#252
6300  0f80 c75430        	ld	21552,a
6301                     ; 1557 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6303  0f83 35065432      	mov	21554,#6
6304                     ; 1558 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6306  0f87 35605432      	mov	21554,#96
6307                     ; 1561 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6309  0f8b 72105432      	bset	21554,#0
6310                     ; 1562 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6312  0f8f 72185432      	bset	21554,#4
6313                     ; 1565 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6315  0f93 35065427      	mov	21543,#6
6316                     ; 1567 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6318  0f97 35d3542c      	mov	21548,#211
6319                     ; 1568 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6321  0f9b 35e7542d      	mov	21549,#231
6322                     ; 1570 	CAN->IER|=(1<<1);
6324  0f9f 72125425      	bset	21541,#1
6325                     ; 1573 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6327  0fa3 72115420      	bres	21536,#0
6329  0fa7               L5672:
6330                     ; 1574 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6332  0fa7 c65421        	ld	a,21537
6333  0faa a501          	bcp	a,#1
6334  0fac 26f9          	jrne	L5672
6335                     ; 1575 }
6338  0fae 81            	ret
6446                     ; 1578 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6446                     ; 1579 {
6447                     	switch	.text
6448  0faf               _can_transmit:
6450  0faf 89            	pushw	x
6451       00000000      OFST:	set	0
6454                     ; 1581 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6456  0fb0 b676          	ld	a,_can_buff_wr_ptr
6457  0fb2 a104          	cp	a,#4
6458  0fb4 2502          	jrult	L7403
6461  0fb6 3f76          	clr	_can_buff_wr_ptr
6462  0fb8               L7403:
6463                     ; 1583 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6465  0fb8 b676          	ld	a,_can_buff_wr_ptr
6466  0fba 97            	ld	xl,a
6467  0fbb a610          	ld	a,#16
6468  0fbd 42            	mul	x,a
6469  0fbe 1601          	ldw	y,(OFST+1,sp)
6470  0fc0 a606          	ld	a,#6
6471  0fc2               L231:
6472  0fc2 9054          	srlw	y
6473  0fc4 4a            	dec	a
6474  0fc5 26fb          	jrne	L231
6475  0fc7 909f          	ld	a,yl
6476  0fc9 e777          	ld	(_can_out_buff,x),a
6477                     ; 1584 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6479  0fcb b676          	ld	a,_can_buff_wr_ptr
6480  0fcd 97            	ld	xl,a
6481  0fce a610          	ld	a,#16
6482  0fd0 42            	mul	x,a
6483  0fd1 7b02          	ld	a,(OFST+2,sp)
6484  0fd3 48            	sll	a
6485  0fd4 48            	sll	a
6486  0fd5 e778          	ld	(_can_out_buff+1,x),a
6487                     ; 1586 can_out_buff[can_buff_wr_ptr][2]=data0;
6489  0fd7 b676          	ld	a,_can_buff_wr_ptr
6490  0fd9 97            	ld	xl,a
6491  0fda a610          	ld	a,#16
6492  0fdc 42            	mul	x,a
6493  0fdd 7b05          	ld	a,(OFST+5,sp)
6494  0fdf e779          	ld	(_can_out_buff+2,x),a
6495                     ; 1587 can_out_buff[can_buff_wr_ptr][3]=data1;
6497  0fe1 b676          	ld	a,_can_buff_wr_ptr
6498  0fe3 97            	ld	xl,a
6499  0fe4 a610          	ld	a,#16
6500  0fe6 42            	mul	x,a
6501  0fe7 7b06          	ld	a,(OFST+6,sp)
6502  0fe9 e77a          	ld	(_can_out_buff+3,x),a
6503                     ; 1588 can_out_buff[can_buff_wr_ptr][4]=data2;
6505  0feb b676          	ld	a,_can_buff_wr_ptr
6506  0fed 97            	ld	xl,a
6507  0fee a610          	ld	a,#16
6508  0ff0 42            	mul	x,a
6509  0ff1 7b07          	ld	a,(OFST+7,sp)
6510  0ff3 e77b          	ld	(_can_out_buff+4,x),a
6511                     ; 1589 can_out_buff[can_buff_wr_ptr][5]=data3;
6513  0ff5 b676          	ld	a,_can_buff_wr_ptr
6514  0ff7 97            	ld	xl,a
6515  0ff8 a610          	ld	a,#16
6516  0ffa 42            	mul	x,a
6517  0ffb 7b08          	ld	a,(OFST+8,sp)
6518  0ffd e77c          	ld	(_can_out_buff+5,x),a
6519                     ; 1590 can_out_buff[can_buff_wr_ptr][6]=data4;
6521  0fff b676          	ld	a,_can_buff_wr_ptr
6522  1001 97            	ld	xl,a
6523  1002 a610          	ld	a,#16
6524  1004 42            	mul	x,a
6525  1005 7b09          	ld	a,(OFST+9,sp)
6526  1007 e77d          	ld	(_can_out_buff+6,x),a
6527                     ; 1591 can_out_buff[can_buff_wr_ptr][7]=data5;
6529  1009 b676          	ld	a,_can_buff_wr_ptr
6530  100b 97            	ld	xl,a
6531  100c a610          	ld	a,#16
6532  100e 42            	mul	x,a
6533  100f 7b0a          	ld	a,(OFST+10,sp)
6534  1011 e77e          	ld	(_can_out_buff+7,x),a
6535                     ; 1592 can_out_buff[can_buff_wr_ptr][8]=data6;
6537  1013 b676          	ld	a,_can_buff_wr_ptr
6538  1015 97            	ld	xl,a
6539  1016 a610          	ld	a,#16
6540  1018 42            	mul	x,a
6541  1019 7b0b          	ld	a,(OFST+11,sp)
6542  101b e77f          	ld	(_can_out_buff+8,x),a
6543                     ; 1593 can_out_buff[can_buff_wr_ptr][9]=data7;
6545  101d b676          	ld	a,_can_buff_wr_ptr
6546  101f 97            	ld	xl,a
6547  1020 a610          	ld	a,#16
6548  1022 42            	mul	x,a
6549  1023 7b0c          	ld	a,(OFST+12,sp)
6550  1025 e780          	ld	(_can_out_buff+9,x),a
6551                     ; 1595 can_buff_wr_ptr++;
6553  1027 3c76          	inc	_can_buff_wr_ptr
6554                     ; 1596 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6556  1029 b676          	ld	a,_can_buff_wr_ptr
6557  102b a104          	cp	a,#4
6558  102d 2502          	jrult	L1503
6561  102f 3f76          	clr	_can_buff_wr_ptr
6562  1031               L1503:
6563                     ; 1597 } 
6566  1031 85            	popw	x
6567  1032 81            	ret
6596                     ; 1600 void can_tx_hndl(void)
6596                     ; 1601 {
6597                     	switch	.text
6598  1033               _can_tx_hndl:
6602                     ; 1602 if(bTX_FREE)
6604  1033 3d03          	tnz	_bTX_FREE
6605  1035 2757          	jreq	L3603
6606                     ; 1604 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6608  1037 b675          	ld	a,_can_buff_rd_ptr
6609  1039 b176          	cp	a,_can_buff_wr_ptr
6610  103b 275f          	jreq	L1703
6611                     ; 1606 		bTX_FREE=0;
6613  103d 3f03          	clr	_bTX_FREE
6614                     ; 1608 		CAN->PSR= 0;
6616  103f 725f5427      	clr	21543
6617                     ; 1609 		CAN->Page.TxMailbox.MDLCR=8;
6619  1043 35085429      	mov	21545,#8
6620                     ; 1610 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6622  1047 b675          	ld	a,_can_buff_rd_ptr
6623  1049 97            	ld	xl,a
6624  104a a610          	ld	a,#16
6625  104c 42            	mul	x,a
6626  104d e677          	ld	a,(_can_out_buff,x)
6627  104f c7542a        	ld	21546,a
6628                     ; 1611 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6630  1052 b675          	ld	a,_can_buff_rd_ptr
6631  1054 97            	ld	xl,a
6632  1055 a610          	ld	a,#16
6633  1057 42            	mul	x,a
6634  1058 e678          	ld	a,(_can_out_buff+1,x)
6635  105a c7542b        	ld	21547,a
6636                     ; 1613 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6638  105d b675          	ld	a,_can_buff_rd_ptr
6639  105f 97            	ld	xl,a
6640  1060 a610          	ld	a,#16
6641  1062 42            	mul	x,a
6642  1063 01            	rrwa	x,a
6643  1064 ab79          	add	a,#_can_out_buff+2
6644  1066 2401          	jrnc	L631
6645  1068 5c            	incw	x
6646  1069               L631:
6647  1069 5f            	clrw	x
6648  106a 97            	ld	xl,a
6649  106b bf00          	ldw	c_x,x
6650  106d ae0008        	ldw	x,#8
6651  1070               L041:
6652  1070 5a            	decw	x
6653  1071 92d600        	ld	a,([c_x],x)
6654  1074 d7542e        	ld	(21550,x),a
6655  1077 5d            	tnzw	x
6656  1078 26f6          	jrne	L041
6657                     ; 1615 		can_buff_rd_ptr++;
6659  107a 3c75          	inc	_can_buff_rd_ptr
6660                     ; 1616 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6662  107c b675          	ld	a,_can_buff_rd_ptr
6663  107e a104          	cp	a,#4
6664  1080 2502          	jrult	L7603
6667  1082 3f75          	clr	_can_buff_rd_ptr
6668  1084               L7603:
6669                     ; 1618 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6671  1084 72105428      	bset	21544,#0
6672                     ; 1619 		CAN->IER|=(1<<0);
6674  1088 72105425      	bset	21541,#0
6675  108c 200e          	jra	L1703
6676  108e               L3603:
6677                     ; 1624 	tx_busy_cnt++;
6679  108e 3c74          	inc	_tx_busy_cnt
6680                     ; 1625 	if(tx_busy_cnt>=100)
6682  1090 b674          	ld	a,_tx_busy_cnt
6683  1092 a164          	cp	a,#100
6684  1094 2506          	jrult	L1703
6685                     ; 1627 		tx_busy_cnt=0;
6687  1096 3f74          	clr	_tx_busy_cnt
6688                     ; 1628 		bTX_FREE=1;
6690  1098 35010003      	mov	_bTX_FREE,#1
6691  109c               L1703:
6692                     ; 1631 }
6695  109c 81            	ret
6810                     ; 1657 void can_in_an(void)
6810                     ; 1658 {
6811                     	switch	.text
6812  109d               _can_in_an:
6814  109d 5207          	subw	sp,#7
6815       00000007      OFST:	set	7
6818                     ; 1668 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6820  109f b6cd          	ld	a,_mess+6
6821  10a1 c100f7        	cp	a,_adress
6822  10a4 2703          	jreq	L061
6823  10a6 cc11de        	jp	L1313
6824  10a9               L061:
6826  10a9 b6ce          	ld	a,_mess+7
6827  10ab c100f7        	cp	a,_adress
6828  10ae 2703          	jreq	L261
6829  10b0 cc11de        	jp	L1313
6830  10b3               L261:
6832  10b3 b6cf          	ld	a,_mess+8
6833  10b5 a1ed          	cp	a,#237
6834  10b7 2703          	jreq	L461
6835  10b9 cc11de        	jp	L1313
6836  10bc               L461:
6837                     ; 1671 	can_error_cnt=0;
6839  10bc 3f73          	clr	_can_error_cnt
6840                     ; 1673 	bMAIN=0;
6842  10be 72110001      	bres	_bMAIN
6843                     ; 1674  	flags_tu=mess[9];
6845  10c2 45d06a        	mov	_flags_tu,_mess+9
6846                     ; 1675  	if(flags_tu&0b00000001)
6848  10c5 b66a          	ld	a,_flags_tu
6849  10c7 a501          	bcp	a,#1
6850  10c9 2706          	jreq	L3313
6851                     ; 1680  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6853  10cb 721a0005      	bset	_flags,#5
6855  10cf 2008          	jra	L5313
6856  10d1               L3313:
6857                     ; 1691  				flags&=0b11011111; 
6859  10d1 721b0005      	bres	_flags,#5
6860                     ; 1692  				off_bp_cnt=5*EE_TZAS;
6862  10d5 350f005d      	mov	_off_bp_cnt,#15
6863  10d9               L5313:
6864                     ; 1698  	if(flags_tu&0b00000010) flags|=0b01000000;
6866  10d9 b66a          	ld	a,_flags_tu
6867  10db a502          	bcp	a,#2
6868  10dd 2706          	jreq	L7313
6871  10df 721c0005      	bset	_flags,#6
6873  10e3 2004          	jra	L1413
6874  10e5               L7313:
6875                     ; 1699  	else flags&=0b10111111; 
6877  10e5 721d0005      	bres	_flags,#6
6878  10e9               L1413:
6879                     ; 1701  	U_out_const=mess[10]+mess[11]*256;
6881  10e9 b6d2          	ld	a,_mess+11
6882  10eb 5f            	clrw	x
6883  10ec 97            	ld	xl,a
6884  10ed 4f            	clr	a
6885  10ee 02            	rlwa	x,a
6886  10ef 01            	rrwa	x,a
6887  10f0 bbd1          	add	a,_mess+10
6888  10f2 2401          	jrnc	L441
6889  10f4 5c            	incw	x
6890  10f5               L441:
6891  10f5 c70009        	ld	_U_out_const+1,a
6892  10f8 9f            	ld	a,xl
6893  10f9 c70008        	ld	_U_out_const,a
6894                     ; 1702  	vol_i_temp=mess[12]+mess[13]*256;  
6896  10fc b6d4          	ld	a,_mess+13
6897  10fe 5f            	clrw	x
6898  10ff 97            	ld	xl,a
6899  1100 4f            	clr	a
6900  1101 02            	rlwa	x,a
6901  1102 01            	rrwa	x,a
6902  1103 bbd3          	add	a,_mess+12
6903  1105 2401          	jrnc	L641
6904  1107 5c            	incw	x
6905  1108               L641:
6906  1108 b761          	ld	_vol_i_temp+1,a
6907  110a 9f            	ld	a,xl
6908  110b b760          	ld	_vol_i_temp,a
6909                     ; 1712 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6911  110d b608          	ld	a,_vent_resurs_tx_cnt
6912  110f a102          	cp	a,#2
6913  1111 2507          	jrult	L3413
6916  1113 ce0000        	ldw	x,_vent_resurs
6917  1116 bf41          	ldw	_plazma_int+4,x
6919  1118 2004          	jra	L5413
6920  111a               L3413:
6921                     ; 1713 	else plazma_int[2]=vent_resurs_sec_cnt;
6923  111a be09          	ldw	x,_vent_resurs_sec_cnt
6924  111c bf41          	ldw	_plazma_int+4,x
6925  111e               L5413:
6926                     ; 1714  	rotor_int=flags_tu+(((short)flags)<<8);
6928  111e b605          	ld	a,_flags
6929  1120 5f            	clrw	x
6930  1121 97            	ld	xl,a
6931  1122 4f            	clr	a
6932  1123 02            	rlwa	x,a
6933  1124 01            	rrwa	x,a
6934  1125 bb6a          	add	a,_flags_tu
6935  1127 2401          	jrnc	L051
6936  1129 5c            	incw	x
6937  112a               L051:
6938  112a b718          	ld	_rotor_int+1,a
6939  112c 9f            	ld	a,xl
6940  112d b717          	ld	_rotor_int,a
6941                     ; 1715 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6943  112f 3b000c        	push	_Ui
6944  1132 3b000d        	push	_Ui+1
6945  1135 3b000e        	push	_Un
6946  1138 3b000f        	push	_Un+1
6947  113b 3b0010        	push	_I
6948  113e 3b0011        	push	_I+1
6949  1141 4bda          	push	#218
6950  1143 3b00f7        	push	_adress
6951  1146 ae018e        	ldw	x,#398
6952  1149 cd0faf        	call	_can_transmit
6954  114c 5b08          	addw	sp,#8
6955                     ; 1716 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6957  114e 3b0006        	push	_Usum
6958  1151 3b0007        	push	_Usum+1
6959  1154 3b0069        	push	__x_+1
6960  1157 3b0005        	push	_flags
6961  115a b608          	ld	a,_vent_resurs_tx_cnt
6962  115c 5f            	clrw	x
6963  115d 97            	ld	xl,a
6964  115e d60000        	ld	a,(_vent_resurs_buff,x)
6965  1161 88            	push	a
6966  1162 3b0072        	push	_T
6967  1165 4bdb          	push	#219
6968  1167 3b00f7        	push	_adress
6969  116a ae018e        	ldw	x,#398
6970  116d cd0faf        	call	_can_transmit
6972  1170 5b08          	addw	sp,#8
6973                     ; 1717 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6975  1172 3b0005        	push	_debug_info_to_uku+4
6976  1175 3b0006        	push	_debug_info_to_uku+5
6977  1178 3b0003        	push	_debug_info_to_uku+2
6978  117b 3b0004        	push	_debug_info_to_uku+3
6979  117e 3b0001        	push	_debug_info_to_uku
6980  1181 3b0002        	push	_debug_info_to_uku+1
6981  1184 4bdc          	push	#220
6982  1186 3b00f7        	push	_adress
6983  1189 ae018e        	ldw	x,#398
6984  118c cd0faf        	call	_can_transmit
6986  118f 5b08          	addw	sp,#8
6987                     ; 1718      link_cnt=0;
6989  1191 5f            	clrw	x
6990  1192 bf6b          	ldw	_link_cnt,x
6991                     ; 1719      link=ON;
6993  1194 3555006d      	mov	_link,#85
6994                     ; 1721      if(flags_tu&0b10000000)
6996  1198 b66a          	ld	a,_flags_tu
6997  119a a580          	bcp	a,#128
6998  119c 2716          	jreq	L7413
6999                     ; 1723      	if(!res_fl)
7001  119e 725d000b      	tnz	_res_fl
7002  11a2 2626          	jrne	L3513
7003                     ; 1725      		res_fl=1;
7005  11a4 a601          	ld	a,#1
7006  11a6 ae000b        	ldw	x,#_res_fl
7007  11a9 cd0000        	call	c_eewrc
7009                     ; 1726      		bRES=1;
7011  11ac 3501000c      	mov	_bRES,#1
7012                     ; 1727      		res_fl_cnt=0;
7014  11b0 3f4b          	clr	_res_fl_cnt
7015  11b2 2016          	jra	L3513
7016  11b4               L7413:
7017                     ; 1732      	if(main_cnt>20)
7019  11b4 9c            	rvf
7020  11b5 ce0255        	ldw	x,_main_cnt
7021  11b8 a30015        	cpw	x,#21
7022  11bb 2f0d          	jrslt	L3513
7023                     ; 1734     			if(res_fl)
7025  11bd 725d000b      	tnz	_res_fl
7026  11c1 2707          	jreq	L3513
7027                     ; 1736      			res_fl=0;
7029  11c3 4f            	clr	a
7030  11c4 ae000b        	ldw	x,#_res_fl
7031  11c7 cd0000        	call	c_eewrc
7033  11ca               L3513:
7034                     ; 1741       if(res_fl_)
7036  11ca 725d000a      	tnz	_res_fl_
7037  11ce 2603          	jrne	L661
7038  11d0 cc1745        	jp	L5703
7039  11d3               L661:
7040                     ; 1743       	res_fl_=0;
7042  11d3 4f            	clr	a
7043  11d4 ae000a        	ldw	x,#_res_fl_
7044  11d7 cd0000        	call	c_eewrc
7046  11da ac451745      	jpf	L5703
7047  11de               L1313:
7048                     ; 1746 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7050  11de b6cd          	ld	a,_mess+6
7051  11e0 c100f7        	cp	a,_adress
7052  11e3 2703          	jreq	L071
7053  11e5 cc145b        	jp	L5613
7054  11e8               L071:
7056  11e8 b6ce          	ld	a,_mess+7
7057  11ea c100f7        	cp	a,_adress
7058  11ed 2703          	jreq	L271
7059  11ef cc145b        	jp	L5613
7060  11f2               L271:
7062  11f2 b6cf          	ld	a,_mess+8
7063  11f4 a1ee          	cp	a,#238
7064  11f6 2703          	jreq	L471
7065  11f8 cc145b        	jp	L5613
7066  11fb               L471:
7068  11fb b6d0          	ld	a,_mess+9
7069  11fd b1d1          	cp	a,_mess+10
7070  11ff 2703          	jreq	L671
7071  1201 cc145b        	jp	L5613
7072  1204               L671:
7073                     ; 1748 	rotor_int++;
7075  1204 be17          	ldw	x,_rotor_int
7076  1206 1c0001        	addw	x,#1
7077  1209 bf17          	ldw	_rotor_int,x
7078                     ; 1749 	if((mess[9]&0xf0)==0x20)
7080  120b b6d0          	ld	a,_mess+9
7081  120d a4f0          	and	a,#240
7082  120f a120          	cp	a,#32
7083  1211 2673          	jrne	L7613
7084                     ; 1751 		if((mess[9]&0x0f)==0x01)
7086  1213 b6d0          	ld	a,_mess+9
7087  1215 a40f          	and	a,#15
7088  1217 a101          	cp	a,#1
7089  1219 260d          	jrne	L1713
7090                     ; 1753 			ee_K[0][0]=adc_buff_[4];
7092  121b ce0107        	ldw	x,_adc_buff_+8
7093  121e 89            	pushw	x
7094  121f ae001a        	ldw	x,#_ee_K
7095  1222 cd0000        	call	c_eewrw
7097  1225 85            	popw	x
7099  1226 204a          	jra	L3713
7100  1228               L1713:
7101                     ; 1755 		else if((mess[9]&0x0f)==0x02)
7103  1228 b6d0          	ld	a,_mess+9
7104  122a a40f          	and	a,#15
7105  122c a102          	cp	a,#2
7106  122e 260b          	jrne	L5713
7107                     ; 1757 			ee_K[0][1]++;
7109  1230 ce001c        	ldw	x,_ee_K+2
7110  1233 1c0001        	addw	x,#1
7111  1236 cf001c        	ldw	_ee_K+2,x
7113  1239 2037          	jra	L3713
7114  123b               L5713:
7115                     ; 1759 		else if((mess[9]&0x0f)==0x03)
7117  123b b6d0          	ld	a,_mess+9
7118  123d a40f          	and	a,#15
7119  123f a103          	cp	a,#3
7120  1241 260b          	jrne	L1023
7121                     ; 1761 			ee_K[0][1]+=10;
7123  1243 ce001c        	ldw	x,_ee_K+2
7124  1246 1c000a        	addw	x,#10
7125  1249 cf001c        	ldw	_ee_K+2,x
7127  124c 2024          	jra	L3713
7128  124e               L1023:
7129                     ; 1763 		else if((mess[9]&0x0f)==0x04)
7131  124e b6d0          	ld	a,_mess+9
7132  1250 a40f          	and	a,#15
7133  1252 a104          	cp	a,#4
7134  1254 260b          	jrne	L5023
7135                     ; 1765 			ee_K[0][1]--;
7137  1256 ce001c        	ldw	x,_ee_K+2
7138  1259 1d0001        	subw	x,#1
7139  125c cf001c        	ldw	_ee_K+2,x
7141  125f 2011          	jra	L3713
7142  1261               L5023:
7143                     ; 1767 		else if((mess[9]&0x0f)==0x05)
7145  1261 b6d0          	ld	a,_mess+9
7146  1263 a40f          	and	a,#15
7147  1265 a105          	cp	a,#5
7148  1267 2609          	jrne	L3713
7149                     ; 1769 			ee_K[0][1]-=10;
7151  1269 ce001c        	ldw	x,_ee_K+2
7152  126c 1d000a        	subw	x,#10
7153  126f cf001c        	ldw	_ee_K+2,x
7154  1272               L3713:
7155                     ; 1771 		granee(&ee_K[0][1],50,3000);									
7157  1272 ae0bb8        	ldw	x,#3000
7158  1275 89            	pushw	x
7159  1276 ae0032        	ldw	x,#50
7160  1279 89            	pushw	x
7161  127a ae001c        	ldw	x,#_ee_K+2
7162  127d cd00f6        	call	_granee
7164  1280 5b04          	addw	sp,#4
7166  1282 ac401440      	jpf	L3123
7167  1286               L7613:
7168                     ; 1773 	else if((mess[9]&0xf0)==0x10)
7170  1286 b6d0          	ld	a,_mess+9
7171  1288 a4f0          	and	a,#240
7172  128a a110          	cp	a,#16
7173  128c 2673          	jrne	L5123
7174                     ; 1775 		if((mess[9]&0x0f)==0x01)
7176  128e b6d0          	ld	a,_mess+9
7177  1290 a40f          	and	a,#15
7178  1292 a101          	cp	a,#1
7179  1294 260d          	jrne	L7123
7180                     ; 1777 			ee_K[1][0]=adc_buff_[1];
7182  1296 ce0101        	ldw	x,_adc_buff_+2
7183  1299 89            	pushw	x
7184  129a ae001e        	ldw	x,#_ee_K+4
7185  129d cd0000        	call	c_eewrw
7187  12a0 85            	popw	x
7189  12a1 204a          	jra	L1223
7190  12a3               L7123:
7191                     ; 1779 		else if((mess[9]&0x0f)==0x02)
7193  12a3 b6d0          	ld	a,_mess+9
7194  12a5 a40f          	and	a,#15
7195  12a7 a102          	cp	a,#2
7196  12a9 260b          	jrne	L3223
7197                     ; 1781 			ee_K[1][1]++;
7199  12ab ce0020        	ldw	x,_ee_K+6
7200  12ae 1c0001        	addw	x,#1
7201  12b1 cf0020        	ldw	_ee_K+6,x
7203  12b4 2037          	jra	L1223
7204  12b6               L3223:
7205                     ; 1783 		else if((mess[9]&0x0f)==0x03)
7207  12b6 b6d0          	ld	a,_mess+9
7208  12b8 a40f          	and	a,#15
7209  12ba a103          	cp	a,#3
7210  12bc 260b          	jrne	L7223
7211                     ; 1785 			ee_K[1][1]+=10;
7213  12be ce0020        	ldw	x,_ee_K+6
7214  12c1 1c000a        	addw	x,#10
7215  12c4 cf0020        	ldw	_ee_K+6,x
7217  12c7 2024          	jra	L1223
7218  12c9               L7223:
7219                     ; 1787 		else if((mess[9]&0x0f)==0x04)
7221  12c9 b6d0          	ld	a,_mess+9
7222  12cb a40f          	and	a,#15
7223  12cd a104          	cp	a,#4
7224  12cf 260b          	jrne	L3323
7225                     ; 1789 			ee_K[1][1]--;
7227  12d1 ce0020        	ldw	x,_ee_K+6
7228  12d4 1d0001        	subw	x,#1
7229  12d7 cf0020        	ldw	_ee_K+6,x
7231  12da 2011          	jra	L1223
7232  12dc               L3323:
7233                     ; 1791 		else if((mess[9]&0x0f)==0x05)
7235  12dc b6d0          	ld	a,_mess+9
7236  12de a40f          	and	a,#15
7237  12e0 a105          	cp	a,#5
7238  12e2 2609          	jrne	L1223
7239                     ; 1793 			ee_K[1][1]-=10;
7241  12e4 ce0020        	ldw	x,_ee_K+6
7242  12e7 1d000a        	subw	x,#10
7243  12ea cf0020        	ldw	_ee_K+6,x
7244  12ed               L1223:
7245                     ; 1798 		granee(&ee_K[1][1],10,30000);
7247  12ed ae7530        	ldw	x,#30000
7248  12f0 89            	pushw	x
7249  12f1 ae000a        	ldw	x,#10
7250  12f4 89            	pushw	x
7251  12f5 ae0020        	ldw	x,#_ee_K+6
7252  12f8 cd00f6        	call	_granee
7254  12fb 5b04          	addw	sp,#4
7256  12fd ac401440      	jpf	L3123
7257  1301               L5123:
7258                     ; 1802 	else if((mess[9]&0xf0)==0x00)
7260  1301 b6d0          	ld	a,_mess+9
7261  1303 a5f0          	bcp	a,#240
7262  1305 2673          	jrne	L3423
7263                     ; 1804 		if((mess[9]&0x0f)==0x01)
7265  1307 b6d0          	ld	a,_mess+9
7266  1309 a40f          	and	a,#15
7267  130b a101          	cp	a,#1
7268  130d 260d          	jrne	L5423
7269                     ; 1806 			ee_K[2][0]=adc_buff_[2];
7271  130f ce0103        	ldw	x,_adc_buff_+4
7272  1312 89            	pushw	x
7273  1313 ae0022        	ldw	x,#_ee_K+8
7274  1316 cd0000        	call	c_eewrw
7276  1319 85            	popw	x
7278  131a 204a          	jra	L7423
7279  131c               L5423:
7280                     ; 1808 		else if((mess[9]&0x0f)==0x02)
7282  131c b6d0          	ld	a,_mess+9
7283  131e a40f          	and	a,#15
7284  1320 a102          	cp	a,#2
7285  1322 260b          	jrne	L1523
7286                     ; 1810 			ee_K[2][1]++;
7288  1324 ce0024        	ldw	x,_ee_K+10
7289  1327 1c0001        	addw	x,#1
7290  132a cf0024        	ldw	_ee_K+10,x
7292  132d 2037          	jra	L7423
7293  132f               L1523:
7294                     ; 1812 		else if((mess[9]&0x0f)==0x03)
7296  132f b6d0          	ld	a,_mess+9
7297  1331 a40f          	and	a,#15
7298  1333 a103          	cp	a,#3
7299  1335 260b          	jrne	L5523
7300                     ; 1814 			ee_K[2][1]+=10;
7302  1337 ce0024        	ldw	x,_ee_K+10
7303  133a 1c000a        	addw	x,#10
7304  133d cf0024        	ldw	_ee_K+10,x
7306  1340 2024          	jra	L7423
7307  1342               L5523:
7308                     ; 1816 		else if((mess[9]&0x0f)==0x04)
7310  1342 b6d0          	ld	a,_mess+9
7311  1344 a40f          	and	a,#15
7312  1346 a104          	cp	a,#4
7313  1348 260b          	jrne	L1623
7314                     ; 1818 			ee_K[2][1]--;
7316  134a ce0024        	ldw	x,_ee_K+10
7317  134d 1d0001        	subw	x,#1
7318  1350 cf0024        	ldw	_ee_K+10,x
7320  1353 2011          	jra	L7423
7321  1355               L1623:
7322                     ; 1820 		else if((mess[9]&0x0f)==0x05)
7324  1355 b6d0          	ld	a,_mess+9
7325  1357 a40f          	and	a,#15
7326  1359 a105          	cp	a,#5
7327  135b 2609          	jrne	L7423
7328                     ; 1822 			ee_K[2][1]-=10;
7330  135d ce0024        	ldw	x,_ee_K+10
7331  1360 1d000a        	subw	x,#10
7332  1363 cf0024        	ldw	_ee_K+10,x
7333  1366               L7423:
7334                     ; 1827 		granee(&ee_K[2][1],10,30000);
7336  1366 ae7530        	ldw	x,#30000
7337  1369 89            	pushw	x
7338  136a ae000a        	ldw	x,#10
7339  136d 89            	pushw	x
7340  136e ae0024        	ldw	x,#_ee_K+10
7341  1371 cd00f6        	call	_granee
7343  1374 5b04          	addw	sp,#4
7345  1376 ac401440      	jpf	L3123
7346  137a               L3423:
7347                     ; 1831 	else if((mess[9]&0xf0)==0x30)
7349  137a b6d0          	ld	a,_mess+9
7350  137c a4f0          	and	a,#240
7351  137e a130          	cp	a,#48
7352  1380 265c          	jrne	L1723
7353                     ; 1833 		if((mess[9]&0x0f)==0x02)
7355  1382 b6d0          	ld	a,_mess+9
7356  1384 a40f          	and	a,#15
7357  1386 a102          	cp	a,#2
7358  1388 260b          	jrne	L3723
7359                     ; 1835 			ee_K[3][1]++;
7361  138a ce0028        	ldw	x,_ee_K+14
7362  138d 1c0001        	addw	x,#1
7363  1390 cf0028        	ldw	_ee_K+14,x
7365  1393 2037          	jra	L5723
7366  1395               L3723:
7367                     ; 1837 		else if((mess[9]&0x0f)==0x03)
7369  1395 b6d0          	ld	a,_mess+9
7370  1397 a40f          	and	a,#15
7371  1399 a103          	cp	a,#3
7372  139b 260b          	jrne	L7723
7373                     ; 1839 			ee_K[3][1]+=10;
7375  139d ce0028        	ldw	x,_ee_K+14
7376  13a0 1c000a        	addw	x,#10
7377  13a3 cf0028        	ldw	_ee_K+14,x
7379  13a6 2024          	jra	L5723
7380  13a8               L7723:
7381                     ; 1841 		else if((mess[9]&0x0f)==0x04)
7383  13a8 b6d0          	ld	a,_mess+9
7384  13aa a40f          	and	a,#15
7385  13ac a104          	cp	a,#4
7386  13ae 260b          	jrne	L3033
7387                     ; 1843 			ee_K[3][1]--;
7389  13b0 ce0028        	ldw	x,_ee_K+14
7390  13b3 1d0001        	subw	x,#1
7391  13b6 cf0028        	ldw	_ee_K+14,x
7393  13b9 2011          	jra	L5723
7394  13bb               L3033:
7395                     ; 1845 		else if((mess[9]&0x0f)==0x05)
7397  13bb b6d0          	ld	a,_mess+9
7398  13bd a40f          	and	a,#15
7399  13bf a105          	cp	a,#5
7400  13c1 2609          	jrne	L5723
7401                     ; 1847 			ee_K[3][1]-=10;
7403  13c3 ce0028        	ldw	x,_ee_K+14
7404  13c6 1d000a        	subw	x,#10
7405  13c9 cf0028        	ldw	_ee_K+14,x
7406  13cc               L5723:
7407                     ; 1849 		granee(&ee_K[3][1],300,517);									
7409  13cc ae0205        	ldw	x,#517
7410  13cf 89            	pushw	x
7411  13d0 ae012c        	ldw	x,#300
7412  13d3 89            	pushw	x
7413  13d4 ae0028        	ldw	x,#_ee_K+14
7414  13d7 cd00f6        	call	_granee
7416  13da 5b04          	addw	sp,#4
7418  13dc 2062          	jra	L3123
7419  13de               L1723:
7420                     ; 1852 	else if((mess[9]&0xf0)==0x50)
7422  13de b6d0          	ld	a,_mess+9
7423  13e0 a4f0          	and	a,#240
7424  13e2 a150          	cp	a,#80
7425  13e4 265a          	jrne	L3123
7426                     ; 1854 		if((mess[9]&0x0f)==0x02)
7428  13e6 b6d0          	ld	a,_mess+9
7429  13e8 a40f          	and	a,#15
7430  13ea a102          	cp	a,#2
7431  13ec 260b          	jrne	L5133
7432                     ; 1856 			ee_K[4][1]++;
7434  13ee ce002c        	ldw	x,_ee_K+18
7435  13f1 1c0001        	addw	x,#1
7436  13f4 cf002c        	ldw	_ee_K+18,x
7438  13f7 2037          	jra	L7133
7439  13f9               L5133:
7440                     ; 1858 		else if((mess[9]&0x0f)==0x03)
7442  13f9 b6d0          	ld	a,_mess+9
7443  13fb a40f          	and	a,#15
7444  13fd a103          	cp	a,#3
7445  13ff 260b          	jrne	L1233
7446                     ; 1860 			ee_K[4][1]+=10;
7448  1401 ce002c        	ldw	x,_ee_K+18
7449  1404 1c000a        	addw	x,#10
7450  1407 cf002c        	ldw	_ee_K+18,x
7452  140a 2024          	jra	L7133
7453  140c               L1233:
7454                     ; 1862 		else if((mess[9]&0x0f)==0x04)
7456  140c b6d0          	ld	a,_mess+9
7457  140e a40f          	and	a,#15
7458  1410 a104          	cp	a,#4
7459  1412 260b          	jrne	L5233
7460                     ; 1864 			ee_K[4][1]--;
7462  1414 ce002c        	ldw	x,_ee_K+18
7463  1417 1d0001        	subw	x,#1
7464  141a cf002c        	ldw	_ee_K+18,x
7466  141d 2011          	jra	L7133
7467  141f               L5233:
7468                     ; 1866 		else if((mess[9]&0x0f)==0x05)
7470  141f b6d0          	ld	a,_mess+9
7471  1421 a40f          	and	a,#15
7472  1423 a105          	cp	a,#5
7473  1425 2609          	jrne	L7133
7474                     ; 1868 			ee_K[4][1]-=10;
7476  1427 ce002c        	ldw	x,_ee_K+18
7477  142a 1d000a        	subw	x,#10
7478  142d cf002c        	ldw	_ee_K+18,x
7479  1430               L7133:
7480                     ; 1870 		granee(&ee_K[4][1],10,30000);									
7482  1430 ae7530        	ldw	x,#30000
7483  1433 89            	pushw	x
7484  1434 ae000a        	ldw	x,#10
7485  1437 89            	pushw	x
7486  1438 ae002c        	ldw	x,#_ee_K+18
7487  143b cd00f6        	call	_granee
7489  143e 5b04          	addw	sp,#4
7490  1440               L3123:
7491                     ; 1873 	link_cnt=0;
7493  1440 5f            	clrw	x
7494  1441 bf6b          	ldw	_link_cnt,x
7495                     ; 1874      link=ON;
7497  1443 3555006d      	mov	_link,#85
7498                     ; 1875      if(res_fl_)
7500  1447 725d000a      	tnz	_res_fl_
7501  144b 2603          	jrne	L002
7502  144d cc1745        	jp	L5703
7503  1450               L002:
7504                     ; 1877       	res_fl_=0;
7506  1450 4f            	clr	a
7507  1451 ae000a        	ldw	x,#_res_fl_
7508  1454 cd0000        	call	c_eewrc
7510  1457 ac451745      	jpf	L5703
7511  145b               L5613:
7512                     ; 1883 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7514  145b b6cd          	ld	a,_mess+6
7515  145d a1ff          	cp	a,#255
7516  145f 2703          	jreq	L202
7517  1461 cc14ef        	jp	L7333
7518  1464               L202:
7520  1464 b6ce          	ld	a,_mess+7
7521  1466 a1ff          	cp	a,#255
7522  1468 2703          	jreq	L402
7523  146a cc14ef        	jp	L7333
7524  146d               L402:
7526  146d b6cf          	ld	a,_mess+8
7527  146f a162          	cp	a,#98
7528  1471 267c          	jrne	L7333
7529                     ; 1886 	tempSS=mess[9]+(mess[10]*256);
7531  1473 b6d1          	ld	a,_mess+10
7532  1475 5f            	clrw	x
7533  1476 97            	ld	xl,a
7534  1477 4f            	clr	a
7535  1478 02            	rlwa	x,a
7536  1479 01            	rrwa	x,a
7537  147a bbd0          	add	a,_mess+9
7538  147c 2401          	jrnc	L251
7539  147e 5c            	incw	x
7540  147f               L251:
7541  147f 02            	rlwa	x,a
7542  1480 1f03          	ldw	(OFST-4,sp),x
7543  1482 01            	rrwa	x,a
7544                     ; 1887 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7546  1483 ce0014        	ldw	x,_ee_Umax
7547  1486 1303          	cpw	x,(OFST-4,sp)
7548  1488 270a          	jreq	L1433
7551  148a 1e03          	ldw	x,(OFST-4,sp)
7552  148c 89            	pushw	x
7553  148d ae0014        	ldw	x,#_ee_Umax
7554  1490 cd0000        	call	c_eewrw
7556  1493 85            	popw	x
7557  1494               L1433:
7558                     ; 1888 	tempSS=mess[11]+(mess[12]*256);
7560  1494 b6d3          	ld	a,_mess+12
7561  1496 5f            	clrw	x
7562  1497 97            	ld	xl,a
7563  1498 4f            	clr	a
7564  1499 02            	rlwa	x,a
7565  149a 01            	rrwa	x,a
7566  149b bbd2          	add	a,_mess+11
7567  149d 2401          	jrnc	L451
7568  149f 5c            	incw	x
7569  14a0               L451:
7570  14a0 02            	rlwa	x,a
7571  14a1 1f03          	ldw	(OFST-4,sp),x
7572  14a3 01            	rrwa	x,a
7573                     ; 1889 	if(ee_dU!=tempSS) ee_dU=tempSS;
7575  14a4 ce0012        	ldw	x,_ee_dU
7576  14a7 1303          	cpw	x,(OFST-4,sp)
7577  14a9 270a          	jreq	L3433
7580  14ab 1e03          	ldw	x,(OFST-4,sp)
7581  14ad 89            	pushw	x
7582  14ae ae0012        	ldw	x,#_ee_dU
7583  14b1 cd0000        	call	c_eewrw
7585  14b4 85            	popw	x
7586  14b5               L3433:
7587                     ; 1890 	if((mess[13]&0x0f)==0x5)
7589  14b5 b6d4          	ld	a,_mess+13
7590  14b7 a40f          	and	a,#15
7591  14b9 a105          	cp	a,#5
7592  14bb 261a          	jrne	L5433
7593                     ; 1892 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7595  14bd ce0006        	ldw	x,_ee_AVT_MODE
7596  14c0 a30055        	cpw	x,#85
7597  14c3 2603          	jrne	L602
7598  14c5 cc1745        	jp	L5703
7599  14c8               L602:
7602  14c8 ae0055        	ldw	x,#85
7603  14cb 89            	pushw	x
7604  14cc ae0006        	ldw	x,#_ee_AVT_MODE
7605  14cf cd0000        	call	c_eewrw
7607  14d2 85            	popw	x
7608  14d3 ac451745      	jpf	L5703
7609  14d7               L5433:
7610                     ; 1894 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7612  14d7 ce0006        	ldw	x,_ee_AVT_MODE
7613  14da a30055        	cpw	x,#85
7614  14dd 2703          	jreq	L012
7615  14df cc1745        	jp	L5703
7616  14e2               L012:
7619  14e2 5f            	clrw	x
7620  14e3 89            	pushw	x
7621  14e4 ae0006        	ldw	x,#_ee_AVT_MODE
7622  14e7 cd0000        	call	c_eewrw
7624  14ea 85            	popw	x
7625  14eb ac451745      	jpf	L5703
7626  14ef               L7333:
7627                     ; 1897 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7629  14ef b6cd          	ld	a,_mess+6
7630  14f1 a1ff          	cp	a,#255
7631  14f3 2703          	jreq	L212
7632  14f5 cc15ab        	jp	L7533
7633  14f8               L212:
7635  14f8 b6ce          	ld	a,_mess+7
7636  14fa a1ff          	cp	a,#255
7637  14fc 2703          	jreq	L412
7638  14fe cc15ab        	jp	L7533
7639  1501               L412:
7641  1501 b6cf          	ld	a,_mess+8
7642  1503 a126          	cp	a,#38
7643  1505 2709          	jreq	L1633
7645  1507 b6cf          	ld	a,_mess+8
7646  1509 a129          	cp	a,#41
7647  150b 2703          	jreq	L612
7648  150d cc15ab        	jp	L7533
7649  1510               L612:
7650  1510               L1633:
7651                     ; 1900 	tempSS=mess[9]+(mess[10]*256);
7653  1510 b6d1          	ld	a,_mess+10
7654  1512 5f            	clrw	x
7655  1513 97            	ld	xl,a
7656  1514 4f            	clr	a
7657  1515 02            	rlwa	x,a
7658  1516 01            	rrwa	x,a
7659  1517 bbd0          	add	a,_mess+9
7660  1519 2401          	jrnc	L651
7661  151b 5c            	incw	x
7662  151c               L651:
7663  151c 02            	rlwa	x,a
7664  151d 1f03          	ldw	(OFST-4,sp),x
7665  151f 01            	rrwa	x,a
7666                     ; 1902 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7668  1520 ce000c        	ldw	x,_ee_UAVT
7669  1523 1303          	cpw	x,(OFST-4,sp)
7670  1525 270a          	jreq	L3633
7673  1527 1e03          	ldw	x,(OFST-4,sp)
7674  1529 89            	pushw	x
7675  152a ae000c        	ldw	x,#_ee_UAVT
7676  152d cd0000        	call	c_eewrw
7678  1530 85            	popw	x
7679  1531               L3633:
7680                     ; 1903 	tempSS=(signed short)mess[11];
7682  1531 b6d2          	ld	a,_mess+11
7683  1533 5f            	clrw	x
7684  1534 97            	ld	xl,a
7685  1535 1f03          	ldw	(OFST-4,sp),x
7686                     ; 1904 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7688  1537 ce0010        	ldw	x,_ee_tmax
7689  153a 1303          	cpw	x,(OFST-4,sp)
7690  153c 270a          	jreq	L5633
7693  153e 1e03          	ldw	x,(OFST-4,sp)
7694  1540 89            	pushw	x
7695  1541 ae0010        	ldw	x,#_ee_tmax
7696  1544 cd0000        	call	c_eewrw
7698  1547 85            	popw	x
7699  1548               L5633:
7700                     ; 1905 	tempSS=(signed short)mess[12];
7702  1548 b6d3          	ld	a,_mess+12
7703  154a 5f            	clrw	x
7704  154b 97            	ld	xl,a
7705  154c 1f03          	ldw	(OFST-4,sp),x
7706                     ; 1906 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7708  154e ce000e        	ldw	x,_ee_tsign
7709  1551 1303          	cpw	x,(OFST-4,sp)
7710  1553 270a          	jreq	L7633
7713  1555 1e03          	ldw	x,(OFST-4,sp)
7714  1557 89            	pushw	x
7715  1558 ae000e        	ldw	x,#_ee_tsign
7716  155b cd0000        	call	c_eewrw
7718  155e 85            	popw	x
7719  155f               L7633:
7720                     ; 1909 	if(mess[8]==MEM_KF1)
7722  155f b6cf          	ld	a,_mess+8
7723  1561 a126          	cp	a,#38
7724  1563 260e          	jrne	L1733
7725                     ; 1911 		if(ee_DEVICE!=0)ee_DEVICE=0;
7727  1565 ce0004        	ldw	x,_ee_DEVICE
7728  1568 2709          	jreq	L1733
7731  156a 5f            	clrw	x
7732  156b 89            	pushw	x
7733  156c ae0004        	ldw	x,#_ee_DEVICE
7734  156f cd0000        	call	c_eewrw
7736  1572 85            	popw	x
7737  1573               L1733:
7738                     ; 1914 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7740  1573 b6cf          	ld	a,_mess+8
7741  1575 a129          	cp	a,#41
7742  1577 2703          	jreq	L022
7743  1579 cc1745        	jp	L5703
7744  157c               L022:
7745                     ; 1916 		if(ee_DEVICE!=1)ee_DEVICE=1;
7747  157c ce0004        	ldw	x,_ee_DEVICE
7748  157f a30001        	cpw	x,#1
7749  1582 270b          	jreq	L7733
7752  1584 ae0001        	ldw	x,#1
7753  1587 89            	pushw	x
7754  1588 ae0004        	ldw	x,#_ee_DEVICE
7755  158b cd0000        	call	c_eewrw
7757  158e 85            	popw	x
7758  158f               L7733:
7759                     ; 1917 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7761  158f b6d4          	ld	a,_mess+13
7762  1591 5f            	clrw	x
7763  1592 97            	ld	xl,a
7764  1593 c30002        	cpw	x,_ee_IMAXVENT
7765  1596 2603          	jrne	L222
7766  1598 cc1745        	jp	L5703
7767  159b               L222:
7770  159b b6d4          	ld	a,_mess+13
7771  159d 5f            	clrw	x
7772  159e 97            	ld	xl,a
7773  159f 89            	pushw	x
7774  15a0 ae0002        	ldw	x,#_ee_IMAXVENT
7775  15a3 cd0000        	call	c_eewrw
7777  15a6 85            	popw	x
7778  15a7 ac451745      	jpf	L5703
7779  15ab               L7533:
7780                     ; 1922 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7782  15ab b6cd          	ld	a,_mess+6
7783  15ad c100f7        	cp	a,_adress
7784  15b0 262d          	jrne	L5043
7786  15b2 b6ce          	ld	a,_mess+7
7787  15b4 c100f7        	cp	a,_adress
7788  15b7 2626          	jrne	L5043
7790  15b9 b6cf          	ld	a,_mess+8
7791  15bb a116          	cp	a,#22
7792  15bd 2620          	jrne	L5043
7794  15bf b6d0          	ld	a,_mess+9
7795  15c1 a163          	cp	a,#99
7796  15c3 261a          	jrne	L5043
7797                     ; 1924 	flags&=0b11100001;
7799  15c5 b605          	ld	a,_flags
7800  15c7 a4e1          	and	a,#225
7801  15c9 b705          	ld	_flags,a
7802                     ; 1925 	tsign_cnt=0;
7804  15cb 5f            	clrw	x
7805  15cc bf59          	ldw	_tsign_cnt,x
7806                     ; 1926 	tmax_cnt=0;
7808  15ce 5f            	clrw	x
7809  15cf bf57          	ldw	_tmax_cnt,x
7810                     ; 1927 	umax_cnt=0;
7812  15d1 5f            	clrw	x
7813  15d2 bf70          	ldw	_umax_cnt,x
7814                     ; 1928 	umin_cnt=0;
7816  15d4 5f            	clrw	x
7817  15d5 bf6e          	ldw	_umin_cnt,x
7818                     ; 1929 	led_drv_cnt=30;
7820  15d7 351e0016      	mov	_led_drv_cnt,#30
7822  15db ac451745      	jpf	L5703
7823  15df               L5043:
7824                     ; 1932 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7826  15df b6cd          	ld	a,_mess+6
7827  15e1 c100f7        	cp	a,_adress
7828  15e4 2620          	jrne	L1143
7830  15e6 b6ce          	ld	a,_mess+7
7831  15e8 c100f7        	cp	a,_adress
7832  15eb 2619          	jrne	L1143
7834  15ed b6cf          	ld	a,_mess+8
7835  15ef a116          	cp	a,#22
7836  15f1 2613          	jrne	L1143
7838  15f3 b6d0          	ld	a,_mess+9
7839  15f5 a164          	cp	a,#100
7840  15f7 260d          	jrne	L1143
7841                     ; 1934 	vent_resurs=0;
7843  15f9 5f            	clrw	x
7844  15fa 89            	pushw	x
7845  15fb ae0000        	ldw	x,#_vent_resurs
7846  15fe cd0000        	call	c_eewrw
7848  1601 85            	popw	x
7850  1602 ac451745      	jpf	L5703
7851  1606               L1143:
7852                     ; 1938 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7854  1606 b6cd          	ld	a,_mess+6
7855  1608 a1ff          	cp	a,#255
7856  160a 265f          	jrne	L5143
7858  160c b6ce          	ld	a,_mess+7
7859  160e a1ff          	cp	a,#255
7860  1610 2659          	jrne	L5143
7862  1612 b6cf          	ld	a,_mess+8
7863  1614 a116          	cp	a,#22
7864  1616 2653          	jrne	L5143
7866  1618 b6d0          	ld	a,_mess+9
7867  161a a116          	cp	a,#22
7868  161c 264d          	jrne	L5143
7869                     ; 1940 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7871  161e b6d1          	ld	a,_mess+10
7872  1620 a155          	cp	a,#85
7873  1622 260f          	jrne	L7143
7875  1624 b6d2          	ld	a,_mess+11
7876  1626 a155          	cp	a,#85
7877  1628 2609          	jrne	L7143
7880  162a be68          	ldw	x,__x_
7881  162c 1c0001        	addw	x,#1
7882  162f bf68          	ldw	__x_,x
7884  1631 2024          	jra	L1243
7885  1633               L7143:
7886                     ; 1941 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7888  1633 b6d1          	ld	a,_mess+10
7889  1635 a166          	cp	a,#102
7890  1637 260f          	jrne	L3243
7892  1639 b6d2          	ld	a,_mess+11
7893  163b a166          	cp	a,#102
7894  163d 2609          	jrne	L3243
7897  163f be68          	ldw	x,__x_
7898  1641 1d0001        	subw	x,#1
7899  1644 bf68          	ldw	__x_,x
7901  1646 200f          	jra	L1243
7902  1648               L3243:
7903                     ; 1942 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7905  1648 b6d1          	ld	a,_mess+10
7906  164a a177          	cp	a,#119
7907  164c 2609          	jrne	L1243
7909  164e b6d2          	ld	a,_mess+11
7910  1650 a177          	cp	a,#119
7911  1652 2603          	jrne	L1243
7914  1654 5f            	clrw	x
7915  1655 bf68          	ldw	__x_,x
7916  1657               L1243:
7917                     ; 1943      gran(&_x_,-XMAX,XMAX);
7919  1657 ae0019        	ldw	x,#25
7920  165a 89            	pushw	x
7921  165b aeffe7        	ldw	x,#65511
7922  165e 89            	pushw	x
7923  165f ae0068        	ldw	x,#__x_
7924  1662 cd00d5        	call	_gran
7926  1665 5b04          	addw	sp,#4
7928  1667 ac451745      	jpf	L5703
7929  166b               L5143:
7930                     ; 1945 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7932  166b b6cd          	ld	a,_mess+6
7933  166d c100f7        	cp	a,_adress
7934  1670 2635          	jrne	L3343
7936  1672 b6ce          	ld	a,_mess+7
7937  1674 c100f7        	cp	a,_adress
7938  1677 262e          	jrne	L3343
7940  1679 b6cf          	ld	a,_mess+8
7941  167b a116          	cp	a,#22
7942  167d 2628          	jrne	L3343
7944  167f b6d0          	ld	a,_mess+9
7945  1681 b1d1          	cp	a,_mess+10
7946  1683 2622          	jrne	L3343
7948  1685 b6d0          	ld	a,_mess+9
7949  1687 a1ee          	cp	a,#238
7950  1689 261c          	jrne	L3343
7951                     ; 1947 	rotor_int++;
7953  168b be17          	ldw	x,_rotor_int
7954  168d 1c0001        	addw	x,#1
7955  1690 bf17          	ldw	_rotor_int,x
7956                     ; 1948      tempI=pwm_u;
7958                     ; 1950 	UU_AVT=Un;
7960  1692 ce000e        	ldw	x,_Un
7961  1695 89            	pushw	x
7962  1696 ae0008        	ldw	x,#_UU_AVT
7963  1699 cd0000        	call	c_eewrw
7965  169c 85            	popw	x
7966                     ; 1951 	delay_ms(100);
7968  169d ae0064        	ldw	x,#100
7969  16a0 cd0121        	call	_delay_ms
7972  16a3 ac451745      	jpf	L5703
7973  16a7               L3343:
7974                     ; 1957 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7976  16a7 b6ce          	ld	a,_mess+7
7977  16a9 a1da          	cp	a,#218
7978  16ab 2653          	jrne	L7343
7980  16ad b6cd          	ld	a,_mess+6
7981  16af c100f7        	cp	a,_adress
7982  16b2 274c          	jreq	L7343
7984  16b4 b6cd          	ld	a,_mess+6
7985  16b6 a106          	cp	a,#6
7986  16b8 2446          	jruge	L7343
7987                     ; 1959 	i_main_bps_cnt[mess[6]]=0;
7989  16ba b6cd          	ld	a,_mess+6
7990  16bc 5f            	clrw	x
7991  16bd 97            	ld	xl,a
7992  16be 6f13          	clr	(_i_main_bps_cnt,x)
7993                     ; 1960 	i_main_flag[mess[6]]=1;
7995  16c0 b6cd          	ld	a,_mess+6
7996  16c2 5f            	clrw	x
7997  16c3 97            	ld	xl,a
7998  16c4 a601          	ld	a,#1
7999  16c6 e71e          	ld	(_i_main_flag,x),a
8000                     ; 1961 	if(bMAIN)
8002                     	btst	_bMAIN
8003  16cd 2476          	jruge	L5703
8004                     ; 1963 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8006  16cf b6d0          	ld	a,_mess+9
8007  16d1 5f            	clrw	x
8008  16d2 97            	ld	xl,a
8009  16d3 4f            	clr	a
8010  16d4 02            	rlwa	x,a
8011  16d5 1f01          	ldw	(OFST-6,sp),x
8012  16d7 b6cf          	ld	a,_mess+8
8013  16d9 5f            	clrw	x
8014  16da 97            	ld	xl,a
8015  16db 72fb01        	addw	x,(OFST-6,sp)
8016  16de b6cd          	ld	a,_mess+6
8017  16e0 905f          	clrw	y
8018  16e2 9097          	ld	yl,a
8019  16e4 9058          	sllw	y
8020  16e6 90ef24        	ldw	(_i_main,y),x
8021                     ; 1964 		i_main[adress]=I;
8023  16e9 c600f7        	ld	a,_adress
8024  16ec 5f            	clrw	x
8025  16ed 97            	ld	xl,a
8026  16ee 58            	sllw	x
8027  16ef 90ce0010      	ldw	y,_I
8028  16f3 ef24          	ldw	(_i_main,x),y
8029                     ; 1965      	i_main_flag[adress]=1;
8031  16f5 c600f7        	ld	a,_adress
8032  16f8 5f            	clrw	x
8033  16f9 97            	ld	xl,a
8034  16fa a601          	ld	a,#1
8035  16fc e71e          	ld	(_i_main_flag,x),a
8036  16fe 2045          	jra	L5703
8037  1700               L7343:
8038                     ; 1969 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8040  1700 b6ce          	ld	a,_mess+7
8041  1702 a1db          	cp	a,#219
8042  1704 263f          	jrne	L5703
8044  1706 b6cd          	ld	a,_mess+6
8045  1708 c100f7        	cp	a,_adress
8046  170b 2738          	jreq	L5703
8048  170d b6cd          	ld	a,_mess+6
8049  170f a106          	cp	a,#6
8050  1711 2432          	jruge	L5703
8051                     ; 1971 	i_main_bps_cnt[mess[6]]=0;
8053  1713 b6cd          	ld	a,_mess+6
8054  1715 5f            	clrw	x
8055  1716 97            	ld	xl,a
8056  1717 6f13          	clr	(_i_main_bps_cnt,x)
8057                     ; 1972 	i_main_flag[mess[6]]=1;		
8059  1719 b6cd          	ld	a,_mess+6
8060  171b 5f            	clrw	x
8061  171c 97            	ld	xl,a
8062  171d a601          	ld	a,#1
8063  171f e71e          	ld	(_i_main_flag,x),a
8064                     ; 1973 	if(bMAIN)
8066                     	btst	_bMAIN
8067  1726 241d          	jruge	L5703
8068                     ; 1975 		if(mess[9]==0)i_main_flag[i]=1;
8070  1728 3dd0          	tnz	_mess+9
8071  172a 260a          	jrne	L1543
8074  172c 7b07          	ld	a,(OFST+0,sp)
8075  172e 5f            	clrw	x
8076  172f 97            	ld	xl,a
8077  1730 a601          	ld	a,#1
8078  1732 e71e          	ld	(_i_main_flag,x),a
8080  1734 2006          	jra	L3543
8081  1736               L1543:
8082                     ; 1976 		else i_main_flag[i]=0;
8084  1736 7b07          	ld	a,(OFST+0,sp)
8085  1738 5f            	clrw	x
8086  1739 97            	ld	xl,a
8087  173a 6f1e          	clr	(_i_main_flag,x)
8088  173c               L3543:
8089                     ; 1977 		i_main_flag[adress]=1;
8091  173c c600f7        	ld	a,_adress
8092  173f 5f            	clrw	x
8093  1740 97            	ld	xl,a
8094  1741 a601          	ld	a,#1
8095  1743 e71e          	ld	(_i_main_flag,x),a
8096  1745               L5703:
8097                     ; 1983 can_in_an_end:
8097                     ; 1984 bCAN_RX=0;
8099  1745 3f04          	clr	_bCAN_RX
8100                     ; 1985 }   
8103  1747 5b07          	addw	sp,#7
8104  1749 81            	ret
8127                     ; 1988 void t4_init(void){
8128                     	switch	.text
8129  174a               _t4_init:
8133                     ; 1989 	TIM4->PSCR = 6;
8135  174a 35065345      	mov	21317,#6
8136                     ; 1990 	TIM4->ARR= 61;
8138  174e 353d5346      	mov	21318,#61
8139                     ; 1991 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8141  1752 72105341      	bset	21313,#0
8142                     ; 1993 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8144  1756 35855340      	mov	21312,#133
8145                     ; 1995 }
8148  175a 81            	ret
8171                     ; 1998 void t1_init(void)
8171                     ; 1999 {
8172                     	switch	.text
8173  175b               _t1_init:
8177                     ; 2000 TIM1->ARRH= 0x07;
8179  175b 35075262      	mov	21090,#7
8180                     ; 2001 TIM1->ARRL= 0xff;
8182  175f 35ff5263      	mov	21091,#255
8183                     ; 2002 TIM1->CCR1H= 0x00;	
8185  1763 725f5265      	clr	21093
8186                     ; 2003 TIM1->CCR1L= 0xff;
8188  1767 35ff5266      	mov	21094,#255
8189                     ; 2004 TIM1->CCR2H= 0x00;	
8191  176b 725f5267      	clr	21095
8192                     ; 2005 TIM1->CCR2L= 0x00;
8194  176f 725f5268      	clr	21096
8195                     ; 2006 TIM1->CCR3H= 0x00;	
8197  1773 725f5269      	clr	21097
8198                     ; 2007 TIM1->CCR3L= 0x64;
8200  1777 3564526a      	mov	21098,#100
8201                     ; 2009 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8203  177b 35685258      	mov	21080,#104
8204                     ; 2010 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8206  177f 35685259      	mov	21081,#104
8207                     ; 2011 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8209  1783 3568525a      	mov	21082,#104
8210                     ; 2012 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8212  1787 3511525c      	mov	21084,#17
8213                     ; 2013 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8215  178b 3501525d      	mov	21085,#1
8216                     ; 2014 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8218  178f 35815250      	mov	21072,#129
8219                     ; 2015 TIM1->BKR|= TIM1_BKR_AOE;
8221  1793 721c526d      	bset	21101,#6
8222                     ; 2016 }
8225  1797 81            	ret
8250                     ; 2020 void adc2_init(void)
8250                     ; 2021 {
8251                     	switch	.text
8252  1798               _adc2_init:
8256                     ; 2022 adc_plazma[0]++;
8258  1798 beb9          	ldw	x,_adc_plazma
8259  179a 1c0001        	addw	x,#1
8260  179d bfb9          	ldw	_adc_plazma,x
8261                     ; 2046 GPIOB->DDR&=~(1<<4);
8263  179f 72195007      	bres	20487,#4
8264                     ; 2047 GPIOB->CR1&=~(1<<4);
8266  17a3 72195008      	bres	20488,#4
8267                     ; 2048 GPIOB->CR2&=~(1<<4);
8269  17a7 72195009      	bres	20489,#4
8270                     ; 2050 GPIOB->DDR&=~(1<<5);
8272  17ab 721b5007      	bres	20487,#5
8273                     ; 2051 GPIOB->CR1&=~(1<<5);
8275  17af 721b5008      	bres	20488,#5
8276                     ; 2052 GPIOB->CR2&=~(1<<5);
8278  17b3 721b5009      	bres	20489,#5
8279                     ; 2054 GPIOB->DDR&=~(1<<6);
8281  17b7 721d5007      	bres	20487,#6
8282                     ; 2055 GPIOB->CR1&=~(1<<6);
8284  17bb 721d5008      	bres	20488,#6
8285                     ; 2056 GPIOB->CR2&=~(1<<6);
8287  17bf 721d5009      	bres	20489,#6
8288                     ; 2058 GPIOB->DDR&=~(1<<7);
8290  17c3 721f5007      	bres	20487,#7
8291                     ; 2059 GPIOB->CR1&=~(1<<7);
8293  17c7 721f5008      	bres	20488,#7
8294                     ; 2060 GPIOB->CR2&=~(1<<7);
8296  17cb 721f5009      	bres	20489,#7
8297                     ; 2062 GPIOB->DDR&=~(1<<2);
8299  17cf 72155007      	bres	20487,#2
8300                     ; 2063 GPIOB->CR1&=~(1<<2);
8302  17d3 72155008      	bres	20488,#2
8303                     ; 2064 GPIOB->CR2&=~(1<<2);
8305  17d7 72155009      	bres	20489,#2
8306                     ; 2073 ADC2->TDRL=0xff;
8308  17db 35ff5407      	mov	21511,#255
8309                     ; 2075 ADC2->CR2=0x08;
8311  17df 35085402      	mov	21506,#8
8312                     ; 2076 ADC2->CR1=0x60;
8314  17e3 35605401      	mov	21505,#96
8315                     ; 2079 	if(adc_ch==5)ADC2->CSR=0x22;
8317  17e7 b6c6          	ld	a,_adc_ch
8318  17e9 a105          	cp	a,#5
8319  17eb 2606          	jrne	L5053
8322  17ed 35225400      	mov	21504,#34
8324  17f1 2007          	jra	L7053
8325  17f3               L5053:
8326                     ; 2080 	else ADC2->CSR=0x20+adc_ch+3;
8328  17f3 b6c6          	ld	a,_adc_ch
8329  17f5 ab23          	add	a,#35
8330  17f7 c75400        	ld	21504,a
8331  17fa               L7053:
8332                     ; 2082 	ADC2->CR1|=1;
8334  17fa 72105401      	bset	21505,#0
8335                     ; 2083 	ADC2->CR1|=1;
8337  17fe 72105401      	bset	21505,#0
8338                     ; 2086 adc_plazma[1]=adc_ch;
8340  1802 b6c6          	ld	a,_adc_ch
8341  1804 5f            	clrw	x
8342  1805 97            	ld	xl,a
8343  1806 bfbb          	ldw	_adc_plazma+2,x
8344                     ; 2087 }
8347  1808 81            	ret
8383                     ; 2095 @far @interrupt void TIM4_UPD_Interrupt (void) 
8383                     ; 2096 {
8385                     	switch	.text
8386  1809               f_TIM4_UPD_Interrupt:
8390                     ; 2097 TIM4->SR1&=~TIM4_SR1_UIF;
8392  1809 72115342      	bres	21314,#0
8393                     ; 2099 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8395  180d 3c12          	inc	_pwm_vent_cnt
8396  180f b612          	ld	a,_pwm_vent_cnt
8397  1811 a10a          	cp	a,#10
8398  1813 2502          	jrult	L1253
8401  1815 3f12          	clr	_pwm_vent_cnt
8402  1817               L1253:
8403                     ; 2100 GPIOB->ODR|=(1<<3);
8405  1817 72165005      	bset	20485,#3
8406                     ; 2101 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8408  181b b612          	ld	a,_pwm_vent_cnt
8409  181d a105          	cp	a,#5
8410  181f 2504          	jrult	L3253
8413  1821 72175005      	bres	20485,#3
8414  1825               L3253:
8415                     ; 2105 if(++t0_cnt00>=10)
8417  1825 9c            	rvf
8418  1826 ce0000        	ldw	x,_t0_cnt00
8419  1829 1c0001        	addw	x,#1
8420  182c cf0000        	ldw	_t0_cnt00,x
8421  182f a3000a        	cpw	x,#10
8422  1832 2f08          	jrslt	L5253
8423                     ; 2107 	t0_cnt00=0;
8425  1834 5f            	clrw	x
8426  1835 cf0000        	ldw	_t0_cnt00,x
8427                     ; 2108 	b1000Hz=1;
8429  1838 72100004      	bset	_b1000Hz
8430  183c               L5253:
8431                     ; 2111 if(++t0_cnt0>=100)
8433  183c 9c            	rvf
8434  183d ce0002        	ldw	x,_t0_cnt0
8435  1840 1c0001        	addw	x,#1
8436  1843 cf0002        	ldw	_t0_cnt0,x
8437  1846 a30064        	cpw	x,#100
8438  1849 2f54          	jrslt	L7253
8439                     ; 2113 	t0_cnt0=0;
8441  184b 5f            	clrw	x
8442  184c cf0002        	ldw	_t0_cnt0,x
8443                     ; 2114 	b100Hz=1;
8445  184f 72100009      	bset	_b100Hz
8446                     ; 2116 	if(++t0_cnt1>=10)
8448  1853 725c0004      	inc	_t0_cnt1
8449  1857 c60004        	ld	a,_t0_cnt1
8450  185a a10a          	cp	a,#10
8451  185c 2508          	jrult	L1353
8452                     ; 2118 		t0_cnt1=0;
8454  185e 725f0004      	clr	_t0_cnt1
8455                     ; 2119 		b10Hz=1;
8457  1862 72100008      	bset	_b10Hz
8458  1866               L1353:
8459                     ; 2122 	if(++t0_cnt2>=20)
8461  1866 725c0005      	inc	_t0_cnt2
8462  186a c60005        	ld	a,_t0_cnt2
8463  186d a114          	cp	a,#20
8464  186f 2508          	jrult	L3353
8465                     ; 2124 		t0_cnt2=0;
8467  1871 725f0005      	clr	_t0_cnt2
8468                     ; 2125 		b5Hz=1;
8470  1875 72100007      	bset	_b5Hz
8471  1879               L3353:
8472                     ; 2129 	if(++t0_cnt4>=50)
8474  1879 725c0007      	inc	_t0_cnt4
8475  187d c60007        	ld	a,_t0_cnt4
8476  1880 a132          	cp	a,#50
8477  1882 2508          	jrult	L5353
8478                     ; 2131 		t0_cnt4=0;
8480  1884 725f0007      	clr	_t0_cnt4
8481                     ; 2132 		b2Hz=1;
8483  1888 72100006      	bset	_b2Hz
8484  188c               L5353:
8485                     ; 2135 	if(++t0_cnt3>=100)
8487  188c 725c0006      	inc	_t0_cnt3
8488  1890 c60006        	ld	a,_t0_cnt3
8489  1893 a164          	cp	a,#100
8490  1895 2508          	jrult	L7253
8491                     ; 2137 		t0_cnt3=0;
8493  1897 725f0006      	clr	_t0_cnt3
8494                     ; 2138 		b1Hz=1;
8496  189b 72100005      	bset	_b1Hz
8497  189f               L7253:
8498                     ; 2144 }
8501  189f 80            	iret
8526                     ; 2147 @far @interrupt void CAN_RX_Interrupt (void) 
8526                     ; 2148 {
8527                     	switch	.text
8528  18a0               f_CAN_RX_Interrupt:
8532                     ; 2150 CAN->PSR= 7;									// page 7 - read messsage
8534  18a0 35075427      	mov	21543,#7
8535                     ; 2152 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8537  18a4 ae000e        	ldw	x,#14
8538  18a7               L632:
8539  18a7 d65427        	ld	a,(21543,x)
8540  18aa e7c6          	ld	(_mess-1,x),a
8541  18ac 5a            	decw	x
8542  18ad 26f8          	jrne	L632
8543                     ; 2163 bCAN_RX=1;
8545  18af 35010004      	mov	_bCAN_RX,#1
8546                     ; 2164 CAN->RFR|=(1<<5);
8548  18b3 721a5424      	bset	21540,#5
8549                     ; 2166 }
8552  18b7 80            	iret
8575                     ; 2169 @far @interrupt void CAN_TX_Interrupt (void) 
8575                     ; 2170 {
8576                     	switch	.text
8577  18b8               f_CAN_TX_Interrupt:
8581                     ; 2171 if((CAN->TSR)&(1<<0))
8583  18b8 c65422        	ld	a,21538
8584  18bb a501          	bcp	a,#1
8585  18bd 2708          	jreq	L1653
8586                     ; 2173 	bTX_FREE=1;	
8588  18bf 35010003      	mov	_bTX_FREE,#1
8589                     ; 2175 	CAN->TSR|=(1<<0);
8591  18c3 72105422      	bset	21538,#0
8592  18c7               L1653:
8593                     ; 2177 }
8596  18c7 80            	iret
8676                     ; 2180 @far @interrupt void ADC2_EOC_Interrupt (void) {
8677                     	switch	.text
8678  18c8               f_ADC2_EOC_Interrupt:
8680       0000000d      OFST:	set	13
8681  18c8 be00          	ldw	x,c_x
8682  18ca 89            	pushw	x
8683  18cb be00          	ldw	x,c_y
8684  18cd 89            	pushw	x
8685  18ce be02          	ldw	x,c_lreg+2
8686  18d0 89            	pushw	x
8687  18d1 be00          	ldw	x,c_lreg
8688  18d3 89            	pushw	x
8689  18d4 520d          	subw	sp,#13
8692                     ; 2185 adc_plazma[2]++;
8694  18d6 bebd          	ldw	x,_adc_plazma+4
8695  18d8 1c0001        	addw	x,#1
8696  18db bfbd          	ldw	_adc_plazma+4,x
8697                     ; 2192 ADC2->CSR&=~(1<<7);
8699  18dd 721f5400      	bres	21504,#7
8700                     ; 2194 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8702  18e1 c65405        	ld	a,21509
8703  18e4 b703          	ld	c_lreg+3,a
8704  18e6 3f02          	clr	c_lreg+2
8705  18e8 3f01          	clr	c_lreg+1
8706  18ea 3f00          	clr	c_lreg
8707  18ec 96            	ldw	x,sp
8708  18ed 1c0001        	addw	x,#OFST-12
8709  18f0 cd0000        	call	c_rtol
8711  18f3 c65404        	ld	a,21508
8712  18f6 5f            	clrw	x
8713  18f7 97            	ld	xl,a
8714  18f8 90ae0100      	ldw	y,#256
8715  18fc cd0000        	call	c_umul
8717  18ff 96            	ldw	x,sp
8718  1900 1c0001        	addw	x,#OFST-12
8719  1903 cd0000        	call	c_ladd
8721  1906 96            	ldw	x,sp
8722  1907 1c000a        	addw	x,#OFST-3
8723  190a cd0000        	call	c_rtol
8725                     ; 2199 if(adr_drv_stat==1)
8727  190d b602          	ld	a,_adr_drv_stat
8728  190f a101          	cp	a,#1
8729  1911 260b          	jrne	L1263
8730                     ; 2201 	adr_drv_stat=2;
8732  1913 35020002      	mov	_adr_drv_stat,#2
8733                     ; 2202 	adc_buff_[0]=temp_adc;
8735  1917 1e0c          	ldw	x,(OFST-1,sp)
8736  1919 cf00ff        	ldw	_adc_buff_,x
8738  191c 2020          	jra	L3263
8739  191e               L1263:
8740                     ; 2205 else if(adr_drv_stat==3)
8742  191e b602          	ld	a,_adr_drv_stat
8743  1920 a103          	cp	a,#3
8744  1922 260b          	jrne	L5263
8745                     ; 2207 	adr_drv_stat=4;
8747  1924 35040002      	mov	_adr_drv_stat,#4
8748                     ; 2208 	adc_buff_[1]=temp_adc;
8750  1928 1e0c          	ldw	x,(OFST-1,sp)
8751  192a cf0101        	ldw	_adc_buff_+2,x
8753  192d 200f          	jra	L3263
8754  192f               L5263:
8755                     ; 2211 else if(adr_drv_stat==5)
8757  192f b602          	ld	a,_adr_drv_stat
8758  1931 a105          	cp	a,#5
8759  1933 2609          	jrne	L3263
8760                     ; 2213 	adr_drv_stat=6;
8762  1935 35060002      	mov	_adr_drv_stat,#6
8763                     ; 2214 	adc_buff_[9]=temp_adc;
8765  1939 1e0c          	ldw	x,(OFST-1,sp)
8766  193b cf0111        	ldw	_adc_buff_+18,x
8767  193e               L3263:
8768                     ; 2217 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8770  193e b6b7          	ld	a,_adc_cnt_cnt
8771  1940 5f            	clrw	x
8772  1941 97            	ld	xl,a
8773  1942 58            	sllw	x
8774  1943 1f03          	ldw	(OFST-10,sp),x
8775  1945 b6c6          	ld	a,_adc_ch
8776  1947 97            	ld	xl,a
8777  1948 a610          	ld	a,#16
8778  194a 42            	mul	x,a
8779  194b 72fb03        	addw	x,(OFST-10,sp)
8780  194e 160c          	ldw	y,(OFST-1,sp)
8781  1950 df0056        	ldw	(_adc_buff_buff,x),y
8782                     ; 2219 adc_ch++;
8784  1953 3cc6          	inc	_adc_ch
8785                     ; 2220 if(adc_ch>=6)
8787  1955 b6c6          	ld	a,_adc_ch
8788  1957 a106          	cp	a,#6
8789  1959 2516          	jrult	L3363
8790                     ; 2222 	adc_ch=0;
8792  195b 3fc6          	clr	_adc_ch
8793                     ; 2223 	adc_cnt_cnt++;
8795  195d 3cb7          	inc	_adc_cnt_cnt
8796                     ; 2224 	if(adc_cnt_cnt>=8)
8798  195f b6b7          	ld	a,_adc_cnt_cnt
8799  1961 a108          	cp	a,#8
8800  1963 250c          	jrult	L3363
8801                     ; 2226 		adc_cnt_cnt=0;
8803  1965 3fb7          	clr	_adc_cnt_cnt
8804                     ; 2227 		adc_cnt++;
8806  1967 3cc5          	inc	_adc_cnt
8807                     ; 2228 		if(adc_cnt>=16)
8809  1969 b6c5          	ld	a,_adc_cnt
8810  196b a110          	cp	a,#16
8811  196d 2502          	jrult	L3363
8812                     ; 2230 			adc_cnt=0;
8814  196f 3fc5          	clr	_adc_cnt
8815  1971               L3363:
8816                     ; 2234 if(adc_cnt_cnt==0)
8818  1971 3db7          	tnz	_adc_cnt_cnt
8819  1973 2660          	jrne	L1463
8820                     ; 2238 	tempSS=0;
8822  1975 ae0000        	ldw	x,#0
8823  1978 1f07          	ldw	(OFST-6,sp),x
8824  197a ae0000        	ldw	x,#0
8825  197d 1f05          	ldw	(OFST-8,sp),x
8826                     ; 2239 	for(i=0;i<8;i++)
8828  197f 0f09          	clr	(OFST-4,sp)
8829  1981               L3463:
8830                     ; 2241 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8832  1981 7b09          	ld	a,(OFST-4,sp)
8833  1983 5f            	clrw	x
8834  1984 97            	ld	xl,a
8835  1985 58            	sllw	x
8836  1986 1f03          	ldw	(OFST-10,sp),x
8837  1988 b6c6          	ld	a,_adc_ch
8838  198a 97            	ld	xl,a
8839  198b a610          	ld	a,#16
8840  198d 42            	mul	x,a
8841  198e 72fb03        	addw	x,(OFST-10,sp)
8842  1991 de0056        	ldw	x,(_adc_buff_buff,x)
8843  1994 cd0000        	call	c_itolx
8845  1997 96            	ldw	x,sp
8846  1998 1c0005        	addw	x,#OFST-8
8847  199b cd0000        	call	c_lgadd
8849                     ; 2239 	for(i=0;i<8;i++)
8851  199e 0c09          	inc	(OFST-4,sp)
8854  19a0 7b09          	ld	a,(OFST-4,sp)
8855  19a2 a108          	cp	a,#8
8856  19a4 25db          	jrult	L3463
8857                     ; 2243 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8859  19a6 96            	ldw	x,sp
8860  19a7 1c0005        	addw	x,#OFST-8
8861  19aa cd0000        	call	c_ltor
8863  19ad a603          	ld	a,#3
8864  19af cd0000        	call	c_lrsh
8866  19b2 be02          	ldw	x,c_lreg+2
8867  19b4 b6c5          	ld	a,_adc_cnt
8868  19b6 905f          	clrw	y
8869  19b8 9097          	ld	yl,a
8870  19ba 9058          	sllw	y
8871  19bc 1703          	ldw	(OFST-10,sp),y
8872  19be b6c6          	ld	a,_adc_ch
8873  19c0 905f          	clrw	y
8874  19c2 9097          	ld	yl,a
8875  19c4 9058          	sllw	y
8876  19c6 9058          	sllw	y
8877  19c8 9058          	sllw	y
8878  19ca 9058          	sllw	y
8879  19cc 9058          	sllw	y
8880  19ce 72f903        	addw	y,(OFST-10,sp)
8881  19d1 90df0113      	ldw	(_adc_buff,y),x
8882  19d5               L1463:
8883                     ; 2247 if((adc_cnt&0x03)==0)
8885  19d5 b6c5          	ld	a,_adc_cnt
8886  19d7 a503          	bcp	a,#3
8887  19d9 264b          	jrne	L1563
8888                     ; 2251 	tempSS=0;
8890  19db ae0000        	ldw	x,#0
8891  19de 1f07          	ldw	(OFST-6,sp),x
8892  19e0 ae0000        	ldw	x,#0
8893  19e3 1f05          	ldw	(OFST-8,sp),x
8894                     ; 2252 	for(i=0;i<16;i++)
8896  19e5 0f09          	clr	(OFST-4,sp)
8897  19e7               L3563:
8898                     ; 2254 		tempSS+=(signed long)adc_buff[adc_ch][i];
8900  19e7 7b09          	ld	a,(OFST-4,sp)
8901  19e9 5f            	clrw	x
8902  19ea 97            	ld	xl,a
8903  19eb 58            	sllw	x
8904  19ec 1f03          	ldw	(OFST-10,sp),x
8905  19ee b6c6          	ld	a,_adc_ch
8906  19f0 97            	ld	xl,a
8907  19f1 a620          	ld	a,#32
8908  19f3 42            	mul	x,a
8909  19f4 72fb03        	addw	x,(OFST-10,sp)
8910  19f7 de0113        	ldw	x,(_adc_buff,x)
8911  19fa cd0000        	call	c_itolx
8913  19fd 96            	ldw	x,sp
8914  19fe 1c0005        	addw	x,#OFST-8
8915  1a01 cd0000        	call	c_lgadd
8917                     ; 2252 	for(i=0;i<16;i++)
8919  1a04 0c09          	inc	(OFST-4,sp)
8922  1a06 7b09          	ld	a,(OFST-4,sp)
8923  1a08 a110          	cp	a,#16
8924  1a0a 25db          	jrult	L3563
8925                     ; 2256 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8927  1a0c 96            	ldw	x,sp
8928  1a0d 1c0005        	addw	x,#OFST-8
8929  1a10 cd0000        	call	c_ltor
8931  1a13 a604          	ld	a,#4
8932  1a15 cd0000        	call	c_lrsh
8934  1a18 be02          	ldw	x,c_lreg+2
8935  1a1a b6c6          	ld	a,_adc_ch
8936  1a1c 905f          	clrw	y
8937  1a1e 9097          	ld	yl,a
8938  1a20 9058          	sllw	y
8939  1a22 90df00ff      	ldw	(_adc_buff_,y),x
8940  1a26               L1563:
8941                     ; 2263 if(adc_ch==0)adc_buff_5=temp_adc;
8943  1a26 3dc6          	tnz	_adc_ch
8944  1a28 2605          	jrne	L1663
8947  1a2a 1e0c          	ldw	x,(OFST-1,sp)
8948  1a2c cf00fd        	ldw	_adc_buff_5,x
8949  1a2f               L1663:
8950                     ; 2264 if(adc_ch==2)adc_buff_1=temp_adc;
8952  1a2f b6c6          	ld	a,_adc_ch
8953  1a31 a102          	cp	a,#2
8954  1a33 2605          	jrne	L3663
8957  1a35 1e0c          	ldw	x,(OFST-1,sp)
8958  1a37 cf00fb        	ldw	_adc_buff_1,x
8959  1a3a               L3663:
8960                     ; 2266 adc_plazma_short++;
8962  1a3a bec3          	ldw	x,_adc_plazma_short
8963  1a3c 1c0001        	addw	x,#1
8964  1a3f bfc3          	ldw	_adc_plazma_short,x
8965                     ; 2268 }
8968  1a41 5b0d          	addw	sp,#13
8969  1a43 85            	popw	x
8970  1a44 bf00          	ldw	c_lreg,x
8971  1a46 85            	popw	x
8972  1a47 bf02          	ldw	c_lreg+2,x
8973  1a49 85            	popw	x
8974  1a4a bf00          	ldw	c_y,x
8975  1a4c 85            	popw	x
8976  1a4d bf00          	ldw	c_x,x
8977  1a4f 80            	iret
9035                     ; 2277 main()
9035                     ; 2278 {
9037                     	switch	.text
9038  1a50               _main:
9042                     ; 2280 CLK->ECKR|=1;
9044  1a50 721050c1      	bset	20673,#0
9046  1a54               L7763:
9047                     ; 2281 while((CLK->ECKR & 2) == 0);
9049  1a54 c650c1        	ld	a,20673
9050  1a57 a502          	bcp	a,#2
9051  1a59 27f9          	jreq	L7763
9052                     ; 2282 CLK->SWCR|=2;
9054  1a5b 721250c5      	bset	20677,#1
9055                     ; 2283 CLK->SWR=0xB4;
9057  1a5f 35b450c4      	mov	20676,#180
9058                     ; 2285 delay_ms(200);
9060  1a63 ae00c8        	ldw	x,#200
9061  1a66 cd0121        	call	_delay_ms
9063                     ; 2286 FLASH_DUKR=0xae;
9065  1a69 35ae5064      	mov	_FLASH_DUKR,#174
9066                     ; 2287 FLASH_DUKR=0x56;
9068  1a6d 35565064      	mov	_FLASH_DUKR,#86
9069                     ; 2288 enableInterrupts();
9072  1a71 9a            rim
9074                     ; 2291 adr_drv_v3();
9077  1a72 cd0d50        	call	_adr_drv_v3
9079                     ; 2295 t4_init();
9081  1a75 cd174a        	call	_t4_init
9083                     ; 2297 		GPIOG->DDR|=(1<<0);
9085  1a78 72105020      	bset	20512,#0
9086                     ; 2298 		GPIOG->CR1|=(1<<0);
9088  1a7c 72105021      	bset	20513,#0
9089                     ; 2299 		GPIOG->CR2&=~(1<<0);	
9091  1a80 72115022      	bres	20514,#0
9092                     ; 2302 		GPIOG->DDR&=~(1<<1);
9094  1a84 72135020      	bres	20512,#1
9095                     ; 2303 		GPIOG->CR1|=(1<<1);
9097  1a88 72125021      	bset	20513,#1
9098                     ; 2304 		GPIOG->CR2&=~(1<<1);
9100  1a8c 72135022      	bres	20514,#1
9101                     ; 2306 init_CAN();
9103  1a90 cd0f40        	call	_init_CAN
9105                     ; 2311 GPIOC->DDR|=(1<<1);
9107  1a93 7212500c      	bset	20492,#1
9108                     ; 2312 GPIOC->CR1|=(1<<1);
9110  1a97 7212500d      	bset	20493,#1
9111                     ; 2313 GPIOC->CR2|=(1<<1);
9113  1a9b 7212500e      	bset	20494,#1
9114                     ; 2315 GPIOC->DDR|=(1<<2);
9116  1a9f 7214500c      	bset	20492,#2
9117                     ; 2316 GPIOC->CR1|=(1<<2);
9119  1aa3 7214500d      	bset	20493,#2
9120                     ; 2317 GPIOC->CR2|=(1<<2);
9122  1aa7 7214500e      	bset	20494,#2
9123                     ; 2324 t1_init();
9125  1aab cd175b        	call	_t1_init
9127                     ; 2326 GPIOA->DDR|=(1<<5);
9129  1aae 721a5002      	bset	20482,#5
9130                     ; 2327 GPIOA->CR1|=(1<<5);
9132  1ab2 721a5003      	bset	20483,#5
9133                     ; 2328 GPIOA->CR2&=~(1<<5);
9135  1ab6 721b5004      	bres	20484,#5
9136                     ; 2334 GPIOB->DDR&=~(1<<3);
9138  1aba 72175007      	bres	20487,#3
9139                     ; 2335 GPIOB->CR1&=~(1<<3);
9141  1abe 72175008      	bres	20488,#3
9142                     ; 2336 GPIOB->CR2&=~(1<<3);
9144  1ac2 72175009      	bres	20489,#3
9145                     ; 2338 GPIOC->DDR|=(1<<3);
9147  1ac6 7216500c      	bset	20492,#3
9148                     ; 2339 GPIOC->CR1|=(1<<3);
9150  1aca 7216500d      	bset	20493,#3
9151                     ; 2340 GPIOC->CR2|=(1<<3);
9153  1ace 7216500e      	bset	20494,#3
9154  1ad2               L3073:
9155                     ; 2346 	if(b1000Hz)
9157                     	btst	_b1000Hz
9158  1ad7 2407          	jruge	L7073
9159                     ; 2348 		b1000Hz=0;
9161  1ad9 72110004      	bres	_b1000Hz
9162                     ; 2350 		adc2_init();
9164  1add cd1798        	call	_adc2_init
9166  1ae0               L7073:
9167                     ; 2353 	if(bCAN_RX)
9169  1ae0 3d04          	tnz	_bCAN_RX
9170  1ae2 2705          	jreq	L1173
9171                     ; 2355 		bCAN_RX=0;
9173  1ae4 3f04          	clr	_bCAN_RX
9174                     ; 2356 		can_in_an();	
9176  1ae6 cd109d        	call	_can_in_an
9178  1ae9               L1173:
9179                     ; 2358 	if(b100Hz)
9181                     	btst	_b100Hz
9182  1aee 2407          	jruge	L3173
9183                     ; 2360 		b100Hz=0;
9185  1af0 72110009      	bres	_b100Hz
9186                     ; 2370 		can_tx_hndl();
9188  1af4 cd1033        	call	_can_tx_hndl
9190  1af7               L3173:
9191                     ; 2373 	if(b10Hz)
9193                     	btst	_b10Hz
9194  1afc 2425          	jruge	L5173
9195                     ; 2375 		b10Hz=0;
9197  1afe 72110008      	bres	_b10Hz
9198                     ; 2377 		matemat();
9200  1b02 cd0877        	call	_matemat
9202                     ; 2378 		led_drv(); 
9204  1b05 cd03ee        	call	_led_drv
9206                     ; 2379 	  link_drv();
9208  1b08 cd04dc        	call	_link_drv
9210                     ; 2381 	  JP_drv();
9212  1b0b cd0451        	call	_JP_drv
9214                     ; 2382 	  flags_drv();
9216  1b0e cd0d05        	call	_flags_drv
9218                     ; 2384 		if(main_cnt10<100)main_cnt10++;
9220  1b11 9c            	rvf
9221  1b12 ce0253        	ldw	x,_main_cnt10
9222  1b15 a30064        	cpw	x,#100
9223  1b18 2e09          	jrsge	L5173
9226  1b1a ce0253        	ldw	x,_main_cnt10
9227  1b1d 1c0001        	addw	x,#1
9228  1b20 cf0253        	ldw	_main_cnt10,x
9229  1b23               L5173:
9230                     ; 2387 	if(b5Hz)
9232                     	btst	_b5Hz
9233  1b28 241c          	jruge	L1273
9234                     ; 2389 		b5Hz=0;
9236  1b2a 72110007      	bres	_b5Hz
9237                     ; 2395 		pwr_drv();		//воздействие на силу
9239  1b2e cd06ac        	call	_pwr_drv
9241                     ; 2396 		led_hndl();
9243  1b31 cd0163        	call	_led_hndl
9245                     ; 2398 		vent_drv();
9247  1b34 cd0534        	call	_vent_drv
9249                     ; 2400 		if(main_cnt1<1000)main_cnt1++;
9251  1b37 9c            	rvf
9252  1b38 be5b          	ldw	x,_main_cnt1
9253  1b3a a303e8        	cpw	x,#1000
9254  1b3d 2e07          	jrsge	L1273
9257  1b3f be5b          	ldw	x,_main_cnt1
9258  1b41 1c0001        	addw	x,#1
9259  1b44 bf5b          	ldw	_main_cnt1,x
9260  1b46               L1273:
9261                     ; 2403 	if(b2Hz)
9263                     	btst	_b2Hz
9264  1b4b 2404          	jruge	L5273
9265                     ; 2405 		b2Hz=0;
9267  1b4d 72110006      	bres	_b2Hz
9268  1b51               L5273:
9269                     ; 2414 	if(b1Hz)
9271                     	btst	_b1Hz
9272  1b56 2503cc1ad2    	jruge	L3073
9273                     ; 2416 		b1Hz=0;
9275  1b5b 72110005      	bres	_b1Hz
9276                     ; 2418 	  pwr_hndl();		//вычисление воздействий на силу
9278  1b5f cd06f4        	call	_pwr_hndl
9280                     ; 2419 		temper_drv();			//вычисление аварий температуры
9282  1b62 cd0a72        	call	_temper_drv
9284                     ; 2420 		u_drv();
9286  1b65 cd0b49        	call	_u_drv
9288                     ; 2422 		if(main_cnt<1000)main_cnt++;
9290  1b68 9c            	rvf
9291  1b69 ce0255        	ldw	x,_main_cnt
9292  1b6c a303e8        	cpw	x,#1000
9293  1b6f 2e09          	jrsge	L1373
9296  1b71 ce0255        	ldw	x,_main_cnt
9297  1b74 1c0001        	addw	x,#1
9298  1b77 cf0255        	ldw	_main_cnt,x
9299  1b7a               L1373:
9300                     ; 2423   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9302  1b7a b66d          	ld	a,_link
9303  1b7c a1aa          	cp	a,#170
9304  1b7e 2706          	jreq	L5373
9306  1b80 b654          	ld	a,_jp_mode
9307  1b82 a103          	cp	a,#3
9308  1b84 2603          	jrne	L3373
9309  1b86               L5373:
9312  1b86 cd0c66        	call	_apv_hndl
9314  1b89               L3373:
9315                     ; 2426   		can_error_cnt++;
9317  1b89 3c73          	inc	_can_error_cnt
9318                     ; 2427   		if(can_error_cnt>=10)
9320  1b8b b673          	ld	a,_can_error_cnt
9321  1b8d a10a          	cp	a,#10
9322  1b8f 2505          	jrult	L7373
9323                     ; 2429   			can_error_cnt=0;
9325  1b91 3f73          	clr	_can_error_cnt
9326                     ; 2430 				init_CAN();
9328  1b93 cd0f40        	call	_init_CAN
9330  1b96               L7373:
9331                     ; 2440 		vent_resurs_hndl();
9333  1b96 cd0000        	call	_vent_resurs_hndl
9335  1b99 acd21ad2      	jpf	L3073
10573                     	xdef	_main
10574                     	xdef	f_ADC2_EOC_Interrupt
10575                     	xdef	f_CAN_TX_Interrupt
10576                     	xdef	f_CAN_RX_Interrupt
10577                     	xdef	f_TIM4_UPD_Interrupt
10578                     	xdef	_adc2_init
10579                     	xdef	_t1_init
10580                     	xdef	_t4_init
10581                     	xdef	_can_in_an
10582                     	xdef	_can_tx_hndl
10583                     	xdef	_can_transmit
10584                     	xdef	_init_CAN
10585                     	xdef	_adr_drv_v3
10586                     	xdef	_adr_drv_v4
10587                     	xdef	_flags_drv
10588                     	xdef	_apv_hndl
10589                     	xdef	_apv_stop
10590                     	xdef	_apv_start
10591                     	xdef	_u_drv
10592                     	xdef	_temper_drv
10593                     	xdef	_matemat
10594                     	xdef	_pwr_hndl
10595                     	xdef	_pwr_drv
10596                     	xdef	_vent_drv
10597                     	xdef	_link_drv
10598                     	xdef	_JP_drv
10599                     	xdef	_led_drv
10600                     	xdef	_led_hndl
10601                     	xdef	_delay_ms
10602                     	xdef	_granee
10603                     	xdef	_gran
10604                     	xdef	_vent_resurs_hndl
10605                     	switch	.ubsct
10606  0001               _debug_info_to_uku:
10607  0001 000000000000  	ds.b	6
10608                     	xdef	_debug_info_to_uku
10609  0007               _pwm_u_cnt:
10610  0007 00            	ds.b	1
10611                     	xdef	_pwm_u_cnt
10612  0008               _vent_resurs_tx_cnt:
10613  0008 00            	ds.b	1
10614                     	xdef	_vent_resurs_tx_cnt
10615                     	switch	.bss
10616  0000               _vent_resurs_buff:
10617  0000 00000000      	ds.b	4
10618                     	xdef	_vent_resurs_buff
10619                     	switch	.ubsct
10620  0009               _vent_resurs_sec_cnt:
10621  0009 0000          	ds.b	2
10622                     	xdef	_vent_resurs_sec_cnt
10623                     .eeprom:	section	.data
10624  0000               _vent_resurs:
10625  0000 0000          	ds.b	2
10626                     	xdef	_vent_resurs
10627  0002               _ee_IMAXVENT:
10628  0002 0000          	ds.b	2
10629                     	xdef	_ee_IMAXVENT
10630                     	switch	.ubsct
10631  000b               _bps_class:
10632  000b 00            	ds.b	1
10633                     	xdef	_bps_class
10634  000c               _vent_pwm_integr_cnt:
10635  000c 0000          	ds.b	2
10636                     	xdef	_vent_pwm_integr_cnt
10637  000e               _vent_pwm_integr:
10638  000e 0000          	ds.b	2
10639                     	xdef	_vent_pwm_integr
10640  0010               _vent_pwm:
10641  0010 0000          	ds.b	2
10642                     	xdef	_vent_pwm
10643  0012               _pwm_vent_cnt:
10644  0012 00            	ds.b	1
10645                     	xdef	_pwm_vent_cnt
10646                     	switch	.eeprom
10647  0004               _ee_DEVICE:
10648  0004 0000          	ds.b	2
10649                     	xdef	_ee_DEVICE
10650  0006               _ee_AVT_MODE:
10651  0006 0000          	ds.b	2
10652                     	xdef	_ee_AVT_MODE
10653                     	switch	.ubsct
10654  0013               _i_main_bps_cnt:
10655  0013 000000000000  	ds.b	6
10656                     	xdef	_i_main_bps_cnt
10657  0019               _i_main_sigma:
10658  0019 0000          	ds.b	2
10659                     	xdef	_i_main_sigma
10660  001b               _i_main_num_of_bps:
10661  001b 00            	ds.b	1
10662                     	xdef	_i_main_num_of_bps
10663  001c               _i_main_avg:
10664  001c 0000          	ds.b	2
10665                     	xdef	_i_main_avg
10666  001e               _i_main_flag:
10667  001e 000000000000  	ds.b	6
10668                     	xdef	_i_main_flag
10669  0024               _i_main:
10670  0024 000000000000  	ds.b	12
10671                     	xdef	_i_main
10672  0030               _x:
10673  0030 000000000000  	ds.b	12
10674                     	xdef	_x
10675                     	xdef	_volum_u_main_
10676                     	switch	.eeprom
10677  0008               _UU_AVT:
10678  0008 0000          	ds.b	2
10679                     	xdef	_UU_AVT
10680                     	switch	.ubsct
10681  003c               _cnt_net_drv:
10682  003c 00            	ds.b	1
10683                     	xdef	_cnt_net_drv
10684                     	switch	.bit
10685  0001               _bMAIN:
10686  0001 00            	ds.b	1
10687                     	xdef	_bMAIN
10688                     	switch	.ubsct
10689  003d               _plazma_int:
10690  003d 000000000000  	ds.b	6
10691                     	xdef	_plazma_int
10692                     	xdef	_rotor_int
10693  0043               _led_green_buff:
10694  0043 00000000      	ds.b	4
10695                     	xdef	_led_green_buff
10696  0047               _led_red_buff:
10697  0047 00000000      	ds.b	4
10698                     	xdef	_led_red_buff
10699                     	xdef	_led_drv_cnt
10700                     	xdef	_led_green
10701                     	xdef	_led_red
10702  004b               _res_fl_cnt:
10703  004b 00            	ds.b	1
10704                     	xdef	_res_fl_cnt
10705                     	xdef	_bRES_
10706                     	xdef	_bRES
10707                     	switch	.eeprom
10708  000a               _res_fl_:
10709  000a 00            	ds.b	1
10710                     	xdef	_res_fl_
10711  000b               _res_fl:
10712  000b 00            	ds.b	1
10713                     	xdef	_res_fl
10714                     	switch	.ubsct
10715  004c               _cnt_apv_off:
10716  004c 00            	ds.b	1
10717                     	xdef	_cnt_apv_off
10718                     	switch	.bit
10719  0002               _bAPV:
10720  0002 00            	ds.b	1
10721                     	xdef	_bAPV
10722                     	switch	.ubsct
10723  004d               _apv_cnt_:
10724  004d 0000          	ds.b	2
10725                     	xdef	_apv_cnt_
10726  004f               _apv_cnt:
10727  004f 000000        	ds.b	3
10728                     	xdef	_apv_cnt
10729                     	xdef	_bBL_IPS
10730                     	switch	.bit
10731  0003               _bBL:
10732  0003 00            	ds.b	1
10733                     	xdef	_bBL
10734                     	switch	.ubsct
10735  0052               _cnt_JP1:
10736  0052 00            	ds.b	1
10737                     	xdef	_cnt_JP1
10738  0053               _cnt_JP0:
10739  0053 00            	ds.b	1
10740                     	xdef	_cnt_JP0
10741  0054               _jp_mode:
10742  0054 00            	ds.b	1
10743                     	xdef	_jp_mode
10744  0055               _pwm_u_:
10745  0055 0000          	ds.b	2
10746                     	xdef	_pwm_u_
10747                     	xdef	_pwm_i
10748                     	xdef	_pwm_u
10749  0057               _tmax_cnt:
10750  0057 0000          	ds.b	2
10751                     	xdef	_tmax_cnt
10752  0059               _tsign_cnt:
10753  0059 0000          	ds.b	2
10754                     	xdef	_tsign_cnt
10755                     	switch	.eeprom
10756  000c               _ee_UAVT:
10757  000c 0000          	ds.b	2
10758                     	xdef	_ee_UAVT
10759  000e               _ee_tsign:
10760  000e 0000          	ds.b	2
10761                     	xdef	_ee_tsign
10762  0010               _ee_tmax:
10763  0010 0000          	ds.b	2
10764                     	xdef	_ee_tmax
10765  0012               _ee_dU:
10766  0012 0000          	ds.b	2
10767                     	xdef	_ee_dU
10768  0014               _ee_Umax:
10769  0014 0000          	ds.b	2
10770                     	xdef	_ee_Umax
10771  0016               _ee_TZAS:
10772  0016 0000          	ds.b	2
10773                     	xdef	_ee_TZAS
10774                     	switch	.ubsct
10775  005b               _main_cnt1:
10776  005b 0000          	ds.b	2
10777                     	xdef	_main_cnt1
10778  005d               _off_bp_cnt:
10779  005d 00            	ds.b	1
10780                     	xdef	_off_bp_cnt
10781                     	xdef	_vol_i_temp_avar
10782  005e               _flags_tu_cnt_off:
10783  005e 00            	ds.b	1
10784                     	xdef	_flags_tu_cnt_off
10785  005f               _flags_tu_cnt_on:
10786  005f 00            	ds.b	1
10787                     	xdef	_flags_tu_cnt_on
10788  0060               _vol_i_temp:
10789  0060 0000          	ds.b	2
10790                     	xdef	_vol_i_temp
10791  0062               _vol_u_temp:
10792  0062 0000          	ds.b	2
10793                     	xdef	_vol_u_temp
10794                     	switch	.eeprom
10795  0018               __x_ee_:
10796  0018 0000          	ds.b	2
10797                     	xdef	__x_ee_
10798                     	switch	.ubsct
10799  0064               __x_cnt:
10800  0064 0000          	ds.b	2
10801                     	xdef	__x_cnt
10802  0066               __x__:
10803  0066 0000          	ds.b	2
10804                     	xdef	__x__
10805  0068               __x_:
10806  0068 0000          	ds.b	2
10807                     	xdef	__x_
10808  006a               _flags_tu:
10809  006a 00            	ds.b	1
10810                     	xdef	_flags_tu
10811                     	xdef	_flags
10812  006b               _link_cnt:
10813  006b 0000          	ds.b	2
10814                     	xdef	_link_cnt
10815  006d               _link:
10816  006d 00            	ds.b	1
10817                     	xdef	_link
10818  006e               _umin_cnt:
10819  006e 0000          	ds.b	2
10820                     	xdef	_umin_cnt
10821  0070               _umax_cnt:
10822  0070 0000          	ds.b	2
10823                     	xdef	_umax_cnt
10824                     	switch	.eeprom
10825  001a               _ee_K:
10826  001a 000000000000  	ds.b	20
10827                     	xdef	_ee_K
10828                     	switch	.ubsct
10829  0072               _T:
10830  0072 00            	ds.b	1
10831                     	xdef	_T
10832                     	switch	.bss
10833  0004               _Uin:
10834  0004 0000          	ds.b	2
10835                     	xdef	_Uin
10836  0006               _Usum:
10837  0006 0000          	ds.b	2
10838                     	xdef	_Usum
10839  0008               _U_out_const:
10840  0008 0000          	ds.b	2
10841                     	xdef	_U_out_const
10842  000a               _Unecc:
10843  000a 0000          	ds.b	2
10844                     	xdef	_Unecc
10845  000c               _Ui:
10846  000c 0000          	ds.b	2
10847                     	xdef	_Ui
10848  000e               _Un:
10849  000e 0000          	ds.b	2
10850                     	xdef	_Un
10851  0010               _I:
10852  0010 0000          	ds.b	2
10853                     	xdef	_I
10854                     	switch	.ubsct
10855  0073               _can_error_cnt:
10856  0073 00            	ds.b	1
10857                     	xdef	_can_error_cnt
10858                     	xdef	_bCAN_RX
10859  0074               _tx_busy_cnt:
10860  0074 00            	ds.b	1
10861                     	xdef	_tx_busy_cnt
10862                     	xdef	_bTX_FREE
10863  0075               _can_buff_rd_ptr:
10864  0075 00            	ds.b	1
10865                     	xdef	_can_buff_rd_ptr
10866  0076               _can_buff_wr_ptr:
10867  0076 00            	ds.b	1
10868                     	xdef	_can_buff_wr_ptr
10869  0077               _can_out_buff:
10870  0077 000000000000  	ds.b	64
10871                     	xdef	_can_out_buff
10872                     	switch	.bss
10873  0012               _pwm_u_buff_cnt:
10874  0012 00            	ds.b	1
10875                     	xdef	_pwm_u_buff_cnt
10876  0013               _pwm_u_buff_ptr:
10877  0013 00            	ds.b	1
10878                     	xdef	_pwm_u_buff_ptr
10879  0014               _pwm_u_buff_:
10880  0014 0000          	ds.b	2
10881                     	xdef	_pwm_u_buff_
10882  0016               _pwm_u_buff:
10883  0016 000000000000  	ds.b	64
10884                     	xdef	_pwm_u_buff
10885                     	switch	.ubsct
10886  00b7               _adc_cnt_cnt:
10887  00b7 00            	ds.b	1
10888                     	xdef	_adc_cnt_cnt
10889                     	switch	.bss
10890  0056               _adc_buff_buff:
10891  0056 000000000000  	ds.b	160
10892                     	xdef	_adc_buff_buff
10893  00f6               _adress_error:
10894  00f6 00            	ds.b	1
10895                     	xdef	_adress_error
10896  00f7               _adress:
10897  00f7 00            	ds.b	1
10898                     	xdef	_adress
10899  00f8               _adr:
10900  00f8 000000        	ds.b	3
10901                     	xdef	_adr
10902                     	xdef	_adr_drv_stat
10903                     	xdef	_led_ind
10904                     	switch	.ubsct
10905  00b8               _led_ind_cnt:
10906  00b8 00            	ds.b	1
10907                     	xdef	_led_ind_cnt
10908  00b9               _adc_plazma:
10909  00b9 000000000000  	ds.b	10
10910                     	xdef	_adc_plazma
10911  00c3               _adc_plazma_short:
10912  00c3 0000          	ds.b	2
10913                     	xdef	_adc_plazma_short
10914  00c5               _adc_cnt:
10915  00c5 00            	ds.b	1
10916                     	xdef	_adc_cnt
10917  00c6               _adc_ch:
10918  00c6 00            	ds.b	1
10919                     	xdef	_adc_ch
10920                     	switch	.bss
10921  00fb               _adc_buff_1:
10922  00fb 0000          	ds.b	2
10923                     	xdef	_adc_buff_1
10924  00fd               _adc_buff_5:
10925  00fd 0000          	ds.b	2
10926                     	xdef	_adc_buff_5
10927  00ff               _adc_buff_:
10928  00ff 000000000000  	ds.b	20
10929                     	xdef	_adc_buff_
10930  0113               _adc_buff:
10931  0113 000000000000  	ds.b	320
10932                     	xdef	_adc_buff
10933  0253               _main_cnt10:
10934  0253 0000          	ds.b	2
10935                     	xdef	_main_cnt10
10936  0255               _main_cnt:
10937  0255 0000          	ds.b	2
10938                     	xdef	_main_cnt
10939                     	switch	.ubsct
10940  00c7               _mess:
10941  00c7 000000000000  	ds.b	14
10942                     	xdef	_mess
10943                     	switch	.bit
10944  0004               _b1000Hz:
10945  0004 00            	ds.b	1
10946                     	xdef	_b1000Hz
10947  0005               _b1Hz:
10948  0005 00            	ds.b	1
10949                     	xdef	_b1Hz
10950  0006               _b2Hz:
10951  0006 00            	ds.b	1
10952                     	xdef	_b2Hz
10953  0007               _b5Hz:
10954  0007 00            	ds.b	1
10955                     	xdef	_b5Hz
10956  0008               _b10Hz:
10957  0008 00            	ds.b	1
10958                     	xdef	_b10Hz
10959  0009               _b100Hz:
10960  0009 00            	ds.b	1
10961                     	xdef	_b100Hz
10962                     	xdef	_t0_cnt4
10963                     	xdef	_t0_cnt3
10964                     	xdef	_t0_cnt2
10965                     	xdef	_t0_cnt1
10966                     	xdef	_t0_cnt0
10967                     	xdef	_t0_cnt00
10968                     	xref	_abs
10969                     	xdef	_bVENT_BLOCK
10970                     	xref.b	c_lreg
10971                     	xref.b	c_x
10972                     	xref.b	c_y
10992                     	xref	c_lrsh
10993                     	xref	c_umul
10994                     	xref	c_lgsub
10995                     	xref	c_lgrsh
10996                     	xref	c_lgadd
10997                     	xref	c_idiv
10998                     	xref	c_sdivx
10999                     	xref	c_imul
11000                     	xref	c_lsbc
11001                     	xref	c_ladd
11002                     	xref	c_lsub
11003                     	xref	c_ldiv
11004                     	xref	c_lgmul
11005                     	xref	c_itolx
11006                     	xref	c_eewrc
11007                     	xref	c_ltor
11008                     	xref	c_lgadc
11009                     	xref	c_rtol
11010                     	xref	c_vmul
11011                     	xref	c_eewrw
11012                     	xref	c_lcmp
11013                     	xref	c_uitolx
11014                     	end
