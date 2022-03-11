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
2270                     ; 198 void vent_resurs_hndl(void)
2270                     ; 199 {
2271                     	scross	off
2272                     	switch	.text
2273  0000               _vent_resurs_hndl:
2275  0000 88            	push	a
2276       00000001      OFST:	set	1
2279                     ; 201 if(vent_pwm>100)vent_resurs_sec_cnt++;
2281  0001 9c            	rvf
2282  0002 be10          	ldw	x,_vent_pwm
2283  0004 a30065        	cpw	x,#101
2284  0007 2f07          	jrslt	L7441
2287  0009 be09          	ldw	x,_vent_resurs_sec_cnt
2288  000b 1c0001        	addw	x,#1
2289  000e bf09          	ldw	_vent_resurs_sec_cnt,x
2290  0010               L7441:
2291                     ; 202 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2293  0010 be09          	ldw	x,_vent_resurs_sec_cnt
2294  0012 a30e11        	cpw	x,#3601
2295  0015 251b          	jrult	L1541
2296                     ; 204 	if(vent_resurs<60000)vent_resurs++;
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
2312                     ; 205 	vent_resurs_sec_cnt=0;
2314  002f 5f            	clrw	x
2315  0030 bf09          	ldw	_vent_resurs_sec_cnt,x
2316  0032               L1541:
2317                     ; 210 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2319  0032 c60001        	ld	a,_vent_resurs+1
2320  0035 a40f          	and	a,#15
2321  0037 c70008        	ld	_vent_resurs_buff,a
2322                     ; 211 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2324  003a c60001        	ld	a,_vent_resurs+1
2325  003d a4f0          	and	a,#240
2326  003f 4e            	swap	a
2327  0040 a40f          	and	a,#15
2328  0042 aa40          	or	a,#64
2329  0044 c70009        	ld	_vent_resurs_buff+1,a
2330                     ; 212 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
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
2344  0059 c7000a        	ld	_vent_resurs_buff+2,a
2345                     ; 213 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
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
2363  0073 c7000b        	ld	_vent_resurs_buff+3,a
2364                     ; 215 temp=vent_resurs_buff[0]&0x0f;
2366  0076 c60008        	ld	a,_vent_resurs_buff
2367  0079 a40f          	and	a,#15
2368  007b 6b01          	ld	(OFST+0,sp),a
2369                     ; 216 temp^=vent_resurs_buff[1]&0x0f;
2371  007d c60009        	ld	a,_vent_resurs_buff+1
2372  0080 a40f          	and	a,#15
2373  0082 1801          	xor	a,(OFST+0,sp)
2374  0084 6b01          	ld	(OFST+0,sp),a
2375                     ; 217 temp^=vent_resurs_buff[2]&0x0f;
2377  0086 c6000a        	ld	a,_vent_resurs_buff+2
2378  0089 a40f          	and	a,#15
2379  008b 1801          	xor	a,(OFST+0,sp)
2380  008d 6b01          	ld	(OFST+0,sp),a
2381                     ; 218 temp^=vent_resurs_buff[3]&0x0f;
2383  008f c6000b        	ld	a,_vent_resurs_buff+3
2384  0092 a40f          	and	a,#15
2385  0094 1801          	xor	a,(OFST+0,sp)
2386  0096 6b01          	ld	(OFST+0,sp),a
2387                     ; 220 vent_resurs_buff[0]|=(temp&0x03)<<4;
2389  0098 7b01          	ld	a,(OFST+0,sp)
2390  009a a403          	and	a,#3
2391  009c 97            	ld	xl,a
2392  009d a610          	ld	a,#16
2393  009f 42            	mul	x,a
2394  00a0 9f            	ld	a,xl
2395  00a1 ca0008        	or	a,_vent_resurs_buff
2396  00a4 c70008        	ld	_vent_resurs_buff,a
2397                     ; 221 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2399  00a7 7b01          	ld	a,(OFST+0,sp)
2400  00a9 a40c          	and	a,#12
2401  00ab 48            	sll	a
2402  00ac 48            	sll	a
2403  00ad ca0009        	or	a,_vent_resurs_buff+1
2404  00b0 c70009        	ld	_vent_resurs_buff+1,a
2405                     ; 222 vent_resurs_buff[2]|=(temp&0x30);
2407  00b3 7b01          	ld	a,(OFST+0,sp)
2408  00b5 a430          	and	a,#48
2409  00b7 ca000a        	or	a,_vent_resurs_buff+2
2410  00ba c7000a        	ld	_vent_resurs_buff+2,a
2411                     ; 223 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2413  00bd 7b01          	ld	a,(OFST+0,sp)
2414  00bf a4c0          	and	a,#192
2415  00c1 44            	srl	a
2416  00c2 44            	srl	a
2417  00c3 ca000b        	or	a,_vent_resurs_buff+3
2418  00c6 c7000b        	ld	_vent_resurs_buff+3,a
2419                     ; 226 vent_resurs_tx_cnt++;
2421  00c9 3c08          	inc	_vent_resurs_tx_cnt
2422                     ; 227 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2424  00cb b608          	ld	a,_vent_resurs_tx_cnt
2425  00cd a104          	cp	a,#4
2426  00cf 2502          	jrult	L5541
2429  00d1 3f08          	clr	_vent_resurs_tx_cnt
2430  00d3               L5541:
2431                     ; 230 }
2434  00d3 84            	pop	a
2435  00d4 81            	ret
2488                     ; 233 void gran(signed short *adr, signed short min, signed short max)
2488                     ; 234 {
2489                     	switch	.text
2490  00d5               _gran:
2492  00d5 89            	pushw	x
2493       00000000      OFST:	set	0
2496                     ; 235 if (*adr<min) *adr=min;
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
2510                     ; 236 if (*adr>max) *adr=max; 
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
2526                     ; 237 } 
2529  00f4 85            	popw	x
2530  00f5 81            	ret
2583                     ; 240 void granee(@eeprom signed short *adr, signed short min, signed short max)
2583                     ; 241 {
2584                     	switch	.text
2585  00f6               _granee:
2587  00f6 89            	pushw	x
2588       00000000      OFST:	set	0
2591                     ; 242 if (*adr<min) *adr=min;
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
2609                     ; 243 if (*adr>max) *adr=max; 
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
2628                     ; 244 }
2631  011f 85            	popw	x
2632  0120 81            	ret
2693                     ; 247 long delay_ms(short in)
2693                     ; 248 {
2694                     	switch	.text
2695  0121               _delay_ms:
2697  0121 520c          	subw	sp,#12
2698       0000000c      OFST:	set	12
2701                     ; 251 i=((long)in)*100UL;
2703  0123 90ae0064      	ldw	y,#100
2704  0127 cd0000        	call	c_vmul
2706  012a 96            	ldw	x,sp
2707  012b 1c0005        	addw	x,#OFST-7
2708  012e cd0000        	call	c_rtol
2710                     ; 253 for(ii=0;ii<i;ii++)
2712  0131 ae0000        	ldw	x,#0
2713  0134 1f0b          	ldw	(OFST-1,sp),x
2714  0136 ae0000        	ldw	x,#0
2715  0139 1f09          	ldw	(OFST-3,sp),x
2717  013b 2012          	jra	L1061
2718  013d               L5751:
2719                     ; 255 		iii++;
2721  013d 96            	ldw	x,sp
2722  013e 1c0001        	addw	x,#OFST-11
2723  0141 a601          	ld	a,#1
2724  0143 cd0000        	call	c_lgadc
2726                     ; 253 for(ii=0;ii<i;ii++)
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
2746                     ; 258 }
2749  0160 5b0c          	addw	sp,#12
2750  0162 81            	ret
2783                     ; 261 void led_hndl(void)
2783                     ; 262 {
2784                     	switch	.text
2785  0163               _led_hndl:
2789                     ; 263 if(adress_error)
2791  0163 725d00fe      	tnz	_adress_error
2792  0167 2714          	jreq	L5161
2793                     ; 265 	led_red=0x55555555L;
2795  0169 ae5555        	ldw	x,#21845
2796  016c bf10          	ldw	_led_red+2,x
2797  016e ae5555        	ldw	x,#21845
2798  0171 bf0e          	ldw	_led_red,x
2799                     ; 266 	led_green=0x55555555L;
2801  0173 ae5555        	ldw	x,#21845
2802  0176 bf14          	ldw	_led_green+2,x
2803  0178 ae5555        	ldw	x,#21845
2804  017b bf12          	ldw	_led_green,x
2805  017d               L5161:
2806                     ; 284 	if(jp_mode!=jp3)
2808  017d b654          	ld	a,_jp_mode
2809  017f a103          	cp	a,#3
2810  0181 2603          	jrne	L02
2811  0183 cc0311        	jp	L7161
2812  0186               L02:
2813                     ; 286 		if(main_cnt1<(5*EE_TZAS))
2815  0186 9c            	rvf
2816  0187 be5b          	ldw	x,_main_cnt1
2817  0189 a3000f        	cpw	x,#15
2818  018c 2e18          	jrsge	L1261
2819                     ; 288 			led_red=0x00000000L;
2821  018e ae0000        	ldw	x,#0
2822  0191 bf10          	ldw	_led_red+2,x
2823  0193 ae0000        	ldw	x,#0
2824  0196 bf0e          	ldw	_led_red,x
2825                     ; 289 			led_green=0x0303030fL;
2827  0198 ae030f        	ldw	x,#783
2828  019b bf14          	ldw	_led_green+2,x
2829  019d ae0303        	ldw	x,#771
2830  01a0 bf12          	ldw	_led_green,x
2832  01a2 acd202d2      	jpf	L3261
2833  01a6               L1261:
2834                     ; 292 		else if((link==ON)&&(flags_tu&0b10000000))
2836  01a6 b66d          	ld	a,_link
2837  01a8 a155          	cp	a,#85
2838  01aa 261e          	jrne	L5261
2840  01ac b66a          	ld	a,_flags_tu
2841  01ae a580          	bcp	a,#128
2842  01b0 2718          	jreq	L5261
2843                     ; 294 			led_red=0x00055555L;
2845  01b2 ae5555        	ldw	x,#21845
2846  01b5 bf10          	ldw	_led_red+2,x
2847  01b7 ae0005        	ldw	x,#5
2848  01ba bf0e          	ldw	_led_red,x
2849                     ; 295 			led_green=0xffffffffL;
2851  01bc aeffff        	ldw	x,#65535
2852  01bf bf14          	ldw	_led_green+2,x
2853  01c1 aeffff        	ldw	x,#-1
2854  01c4 bf12          	ldw	_led_green,x
2856  01c6 acd202d2      	jpf	L3261
2857  01ca               L5261:
2858                     ; 298 		else if(((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(100+(5*EE_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
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
2876                     ; 300 			led_red=0x00000000L;
2878  01e7 ae0000        	ldw	x,#0
2879  01ea bf10          	ldw	_led_red+2,x
2880  01ec ae0000        	ldw	x,#0
2881  01ef bf0e          	ldw	_led_red,x
2882                     ; 301 			led_green=0xffffffffL;	
2884  01f1 aeffff        	ldw	x,#65535
2885  01f4 bf14          	ldw	_led_green+2,x
2886  01f6 aeffff        	ldw	x,#-1
2887  01f9 bf12          	ldw	_led_green,x
2889  01fb acd202d2      	jpf	L3261
2890  01ff               L1361:
2891                     ; 304 		else  if(link==OFF)
2893  01ff b66d          	ld	a,_link
2894  0201 a1aa          	cp	a,#170
2895  0203 2618          	jrne	L5361
2896                     ; 306 			led_red=0x55555555L;
2898  0205 ae5555        	ldw	x,#21845
2899  0208 bf10          	ldw	_led_red+2,x
2900  020a ae5555        	ldw	x,#21845
2901  020d bf0e          	ldw	_led_red,x
2902                     ; 307 			led_green=0xffffffffL;
2904  020f aeffff        	ldw	x,#65535
2905  0212 bf14          	ldw	_led_green+2,x
2906  0214 aeffff        	ldw	x,#-1
2907  0217 bf12          	ldw	_led_green,x
2909  0219 acd202d2      	jpf	L3261
2910  021d               L5361:
2911                     ; 310 		else if((link==ON)&&((flags&0b00111110)==0))
2913  021d b66d          	ld	a,_link
2914  021f a155          	cp	a,#85
2915  0221 261d          	jrne	L1461
2917  0223 b605          	ld	a,_flags
2918  0225 a53e          	bcp	a,#62
2919  0227 2617          	jrne	L1461
2920                     ; 312 			led_red=0x00000000L;
2922  0229 ae0000        	ldw	x,#0
2923  022c bf10          	ldw	_led_red+2,x
2924  022e ae0000        	ldw	x,#0
2925  0231 bf0e          	ldw	_led_red,x
2926                     ; 313 			led_green=0xffffffffL;
2928  0233 aeffff        	ldw	x,#65535
2929  0236 bf14          	ldw	_led_green+2,x
2930  0238 aeffff        	ldw	x,#-1
2931  023b bf12          	ldw	_led_green,x
2933  023d cc02d2        	jra	L3261
2934  0240               L1461:
2935                     ; 316 		else if((flags&0b00111110)==0b00000100)
2937  0240 b605          	ld	a,_flags
2938  0242 a43e          	and	a,#62
2939  0244 a104          	cp	a,#4
2940  0246 2616          	jrne	L5461
2941                     ; 318 			led_red=0x00010001L;
2943  0248 ae0001        	ldw	x,#1
2944  024b bf10          	ldw	_led_red+2,x
2945  024d ae0001        	ldw	x,#1
2946  0250 bf0e          	ldw	_led_red,x
2947                     ; 319 			led_green=0xffffffffL;	
2949  0252 aeffff        	ldw	x,#65535
2950  0255 bf14          	ldw	_led_green+2,x
2951  0257 aeffff        	ldw	x,#-1
2952  025a bf12          	ldw	_led_green,x
2954  025c 2074          	jra	L3261
2955  025e               L5461:
2956                     ; 321 		else if(flags&0b00000010)
2958  025e b605          	ld	a,_flags
2959  0260 a502          	bcp	a,#2
2960  0262 2716          	jreq	L1561
2961                     ; 323 			led_red=0x00010001L;
2963  0264 ae0001        	ldw	x,#1
2964  0267 bf10          	ldw	_led_red+2,x
2965  0269 ae0001        	ldw	x,#1
2966  026c bf0e          	ldw	_led_red,x
2967                     ; 324 			led_green=0x00000000L;	
2969  026e ae0000        	ldw	x,#0
2970  0271 bf14          	ldw	_led_green+2,x
2971  0273 ae0000        	ldw	x,#0
2972  0276 bf12          	ldw	_led_green,x
2974  0278 2058          	jra	L3261
2975  027a               L1561:
2976                     ; 326 		else if(flags&0b00001000)
2978  027a b605          	ld	a,_flags
2979  027c a508          	bcp	a,#8
2980  027e 2716          	jreq	L5561
2981                     ; 328 			led_red=0x00090009L;
2983  0280 ae0009        	ldw	x,#9
2984  0283 bf10          	ldw	_led_red+2,x
2985  0285 ae0009        	ldw	x,#9
2986  0288 bf0e          	ldw	_led_red,x
2987                     ; 329 			led_green=0x00000000L;	
2989  028a ae0000        	ldw	x,#0
2990  028d bf14          	ldw	_led_green+2,x
2991  028f ae0000        	ldw	x,#0
2992  0292 bf12          	ldw	_led_green,x
2994  0294 203c          	jra	L3261
2995  0296               L5561:
2996                     ; 331 		else if(flags&0b00010000)
2998  0296 b605          	ld	a,_flags
2999  0298 a510          	bcp	a,#16
3000  029a 2716          	jreq	L1661
3001                     ; 333 			led_red=0x00490049L;
3003  029c ae0049        	ldw	x,#73
3004  029f bf10          	ldw	_led_red+2,x
3005  02a1 ae0049        	ldw	x,#73
3006  02a4 bf0e          	ldw	_led_red,x
3007                     ; 334 			led_green=0x00000000L;	
3009  02a6 ae0000        	ldw	x,#0
3010  02a9 bf14          	ldw	_led_green+2,x
3011  02ab ae0000        	ldw	x,#0
3012  02ae bf12          	ldw	_led_green,x
3014  02b0 2020          	jra	L3261
3015  02b2               L1661:
3016                     ; 337 		else if((link==ON)&&(flags&0b00100000))
3018  02b2 b66d          	ld	a,_link
3019  02b4 a155          	cp	a,#85
3020  02b6 261a          	jrne	L3261
3022  02b8 b605          	ld	a,_flags
3023  02ba a520          	bcp	a,#32
3024  02bc 2714          	jreq	L3261
3025                     ; 339 			led_red=0x00000000L;
3027  02be ae0000        	ldw	x,#0
3028  02c1 bf10          	ldw	_led_red+2,x
3029  02c3 ae0000        	ldw	x,#0
3030  02c6 bf0e          	ldw	_led_red,x
3031                     ; 340 			led_green=0x00030003L;
3033  02c8 ae0003        	ldw	x,#3
3034  02cb bf14          	ldw	_led_green+2,x
3035  02cd ae0003        	ldw	x,#3
3036  02d0 bf12          	ldw	_led_green,x
3037  02d2               L3261:
3038                     ; 343 		if((jp_mode==jp1))
3040  02d2 b654          	ld	a,_jp_mode
3041  02d4 a101          	cp	a,#1
3042  02d6 2618          	jrne	L7661
3043                     ; 345 			led_red=0x00000000L;
3045  02d8 ae0000        	ldw	x,#0
3046  02db bf10          	ldw	_led_red+2,x
3047  02dd ae0000        	ldw	x,#0
3048  02e0 bf0e          	ldw	_led_red,x
3049                     ; 346 			led_green=0x33333333L;
3051  02e2 ae3333        	ldw	x,#13107
3052  02e5 bf14          	ldw	_led_green+2,x
3053  02e7 ae3333        	ldw	x,#13107
3054  02ea bf12          	ldw	_led_green,x
3056  02ec aced03ed      	jpf	L5761
3057  02f0               L7661:
3058                     ; 348 		else if((jp_mode==jp2))
3060  02f0 b654          	ld	a,_jp_mode
3061  02f2 a102          	cp	a,#2
3062  02f4 2703          	jreq	L22
3063  02f6 cc03ed        	jp	L5761
3064  02f9               L22:
3065                     ; 350 			led_red=0xccccccccL;
3067  02f9 aecccc        	ldw	x,#52428
3068  02fc bf10          	ldw	_led_red+2,x
3069  02fe aecccc        	ldw	x,#-13108
3070  0301 bf0e          	ldw	_led_red,x
3071                     ; 351 			led_green=0x00000000L;
3073  0303 ae0000        	ldw	x,#0
3074  0306 bf14          	ldw	_led_green+2,x
3075  0308 ae0000        	ldw	x,#0
3076  030b bf12          	ldw	_led_green,x
3077  030d aced03ed      	jpf	L5761
3078  0311               L7161:
3079                     ; 356 	else if(jp_mode==jp3)
3081  0311 b654          	ld	a,_jp_mode
3082  0313 a103          	cp	a,#3
3083  0315 2703          	jreq	L42
3084  0317 cc03ed        	jp	L5761
3085  031a               L42:
3086                     ; 358 		if(main_cnt1<(5*EE_TZAS))
3088  031a 9c            	rvf
3089  031b be5b          	ldw	x,_main_cnt1
3090  031d a3000f        	cpw	x,#15
3091  0320 2e18          	jrsge	L1071
3092                     ; 360 			led_red=0x00000000L;
3094  0322 ae0000        	ldw	x,#0
3095  0325 bf10          	ldw	_led_red+2,x
3096  0327 ae0000        	ldw	x,#0
3097  032a bf0e          	ldw	_led_red,x
3098                     ; 361 			led_green=0x03030303L;
3100  032c ae0303        	ldw	x,#771
3101  032f bf14          	ldw	_led_green+2,x
3102  0331 ae0303        	ldw	x,#771
3103  0334 bf12          	ldw	_led_green,x
3105  0336 aced03ed      	jpf	L5761
3106  033a               L1071:
3107                     ; 363 		else if((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(70+(5*EE_TZAS))))
3109  033a 9c            	rvf
3110  033b be5b          	ldw	x,_main_cnt1
3111  033d a30010        	cpw	x,#16
3112  0340 2f1f          	jrslt	L5071
3114  0342 9c            	rvf
3115  0343 be5b          	ldw	x,_main_cnt1
3116  0345 a30055        	cpw	x,#85
3117  0348 2e17          	jrsge	L5071
3118                     ; 365 			led_red=0x00000000L;
3120  034a ae0000        	ldw	x,#0
3121  034d bf10          	ldw	_led_red+2,x
3122  034f ae0000        	ldw	x,#0
3123  0352 bf0e          	ldw	_led_red,x
3124                     ; 366 			led_green=0xffffffffL;	
3126  0354 aeffff        	ldw	x,#65535
3127  0357 bf14          	ldw	_led_green+2,x
3128  0359 aeffff        	ldw	x,#-1
3129  035c bf12          	ldw	_led_green,x
3131  035e cc03ed        	jra	L5761
3132  0361               L5071:
3133                     ; 369 		else if((flags&0b00011110)==0)
3135  0361 b605          	ld	a,_flags
3136  0363 a51e          	bcp	a,#30
3137  0365 2616          	jrne	L1171
3138                     ; 371 			led_red=0x00000000L;
3140  0367 ae0000        	ldw	x,#0
3141  036a bf10          	ldw	_led_red+2,x
3142  036c ae0000        	ldw	x,#0
3143  036f bf0e          	ldw	_led_red,x
3144                     ; 372 			led_green=0xffffffffL;
3146  0371 aeffff        	ldw	x,#65535
3147  0374 bf14          	ldw	_led_green+2,x
3148  0376 aeffff        	ldw	x,#-1
3149  0379 bf12          	ldw	_led_green,x
3151  037b 2070          	jra	L5761
3152  037d               L1171:
3153                     ; 376 		else if((flags&0b00111110)==0b00000100)
3155  037d b605          	ld	a,_flags
3156  037f a43e          	and	a,#62
3157  0381 a104          	cp	a,#4
3158  0383 2616          	jrne	L5171
3159                     ; 378 			led_red=0x00010001L;
3161  0385 ae0001        	ldw	x,#1
3162  0388 bf10          	ldw	_led_red+2,x
3163  038a ae0001        	ldw	x,#1
3164  038d bf0e          	ldw	_led_red,x
3165                     ; 379 			led_green=0xffffffffL;	
3167  038f aeffff        	ldw	x,#65535
3168  0392 bf14          	ldw	_led_green+2,x
3169  0394 aeffff        	ldw	x,#-1
3170  0397 bf12          	ldw	_led_green,x
3172  0399 2052          	jra	L5761
3173  039b               L5171:
3174                     ; 381 		else if(flags&0b00000010)
3176  039b b605          	ld	a,_flags
3177  039d a502          	bcp	a,#2
3178  039f 2716          	jreq	L1271
3179                     ; 383 			led_red=0x00010001L;
3181  03a1 ae0001        	ldw	x,#1
3182  03a4 bf10          	ldw	_led_red+2,x
3183  03a6 ae0001        	ldw	x,#1
3184  03a9 bf0e          	ldw	_led_red,x
3185                     ; 384 			led_green=0x00000000L;	
3187  03ab ae0000        	ldw	x,#0
3188  03ae bf14          	ldw	_led_green+2,x
3189  03b0 ae0000        	ldw	x,#0
3190  03b3 bf12          	ldw	_led_green,x
3192  03b5 2036          	jra	L5761
3193  03b7               L1271:
3194                     ; 386 		else if(flags&0b00001000)
3196  03b7 b605          	ld	a,_flags
3197  03b9 a508          	bcp	a,#8
3198  03bb 2716          	jreq	L5271
3199                     ; 388 			led_red=0x00090009L;
3201  03bd ae0009        	ldw	x,#9
3202  03c0 bf10          	ldw	_led_red+2,x
3203  03c2 ae0009        	ldw	x,#9
3204  03c5 bf0e          	ldw	_led_red,x
3205                     ; 389 			led_green=0x00000000L;	
3207  03c7 ae0000        	ldw	x,#0
3208  03ca bf14          	ldw	_led_green+2,x
3209  03cc ae0000        	ldw	x,#0
3210  03cf bf12          	ldw	_led_green,x
3212  03d1 201a          	jra	L5761
3213  03d3               L5271:
3214                     ; 391 		else if(flags&0b00010000)
3216  03d3 b605          	ld	a,_flags
3217  03d5 a510          	bcp	a,#16
3218  03d7 2714          	jreq	L5761
3219                     ; 393 			led_red=0x00490049L;
3221  03d9 ae0049        	ldw	x,#73
3222  03dc bf10          	ldw	_led_red+2,x
3223  03de ae0049        	ldw	x,#73
3224  03e1 bf0e          	ldw	_led_red,x
3225                     ; 394 			led_green=0xffffffffL;	
3227  03e3 aeffff        	ldw	x,#65535
3228  03e6 bf14          	ldw	_led_green+2,x
3229  03e8 aeffff        	ldw	x,#-1
3230  03eb bf12          	ldw	_led_green,x
3231  03ed               L5761:
3232                     ; 554 }
3235  03ed 81            	ret
3263                     ; 557 void led_drv(void)
3263                     ; 558 {
3264                     	switch	.text
3265  03ee               _led_drv:
3269                     ; 560 GPIOA->DDR|=(1<<4);
3271  03ee 72185002      	bset	20482,#4
3272                     ; 561 GPIOA->CR1|=(1<<4);
3274  03f2 72185003      	bset	20483,#4
3275                     ; 562 GPIOA->CR2&=~(1<<4);
3277  03f6 72195004      	bres	20484,#4
3278                     ; 563 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3280  03fa b64a          	ld	a,_led_red_buff+3
3281  03fc a501          	bcp	a,#1
3282  03fe 2706          	jreq	L3471
3285  0400 72185000      	bset	20480,#4
3287  0404 2004          	jra	L5471
3288  0406               L3471:
3289                     ; 564 else GPIOA->ODR&=~(1<<4); 
3291  0406 72195000      	bres	20480,#4
3292  040a               L5471:
3293                     ; 567 GPIOA->DDR|=(1<<5);
3295  040a 721a5002      	bset	20482,#5
3296                     ; 568 GPIOA->CR1|=(1<<5);
3298  040e 721a5003      	bset	20483,#5
3299                     ; 569 GPIOA->CR2&=~(1<<5);	
3301  0412 721b5004      	bres	20484,#5
3302                     ; 570 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3304  0416 b646          	ld	a,_led_green_buff+3
3305  0418 a501          	bcp	a,#1
3306  041a 2706          	jreq	L7471
3309  041c 721a5000      	bset	20480,#5
3311  0420 2004          	jra	L1571
3312  0422               L7471:
3313                     ; 571 else GPIOA->ODR&=~(1<<5);
3315  0422 721b5000      	bres	20480,#5
3316  0426               L1571:
3317                     ; 574 led_red_buff>>=1;
3319  0426 3747          	sra	_led_red_buff
3320  0428 3648          	rrc	_led_red_buff+1
3321  042a 3649          	rrc	_led_red_buff+2
3322  042c 364a          	rrc	_led_red_buff+3
3323                     ; 575 led_green_buff>>=1;
3325  042e 3743          	sra	_led_green_buff
3326  0430 3644          	rrc	_led_green_buff+1
3327  0432 3645          	rrc	_led_green_buff+2
3328  0434 3646          	rrc	_led_green_buff+3
3329                     ; 576 if(++led_drv_cnt>32)
3331  0436 3c16          	inc	_led_drv_cnt
3332  0438 b616          	ld	a,_led_drv_cnt
3333  043a a121          	cp	a,#33
3334  043c 2512          	jrult	L3571
3335                     ; 578 	led_drv_cnt=0;
3337  043e 3f16          	clr	_led_drv_cnt
3338                     ; 579 	led_red_buff=led_red;
3340  0440 be10          	ldw	x,_led_red+2
3341  0442 bf49          	ldw	_led_red_buff+2,x
3342  0444 be0e          	ldw	x,_led_red
3343  0446 bf47          	ldw	_led_red_buff,x
3344                     ; 580 	led_green_buff=led_green;
3346  0448 be14          	ldw	x,_led_green+2
3347  044a bf45          	ldw	_led_green_buff+2,x
3348  044c be12          	ldw	x,_led_green
3349  044e bf43          	ldw	_led_green_buff,x
3350  0450               L3571:
3351                     ; 586 } 
3354  0450 81            	ret
3380                     ; 589 void JP_drv(void)
3380                     ; 590 {
3381                     	switch	.text
3382  0451               _JP_drv:
3386                     ; 592 GPIOD->DDR&=~(1<<6);
3388  0451 721d5011      	bres	20497,#6
3389                     ; 593 GPIOD->CR1|=(1<<6);
3391  0455 721c5012      	bset	20498,#6
3392                     ; 594 GPIOD->CR2&=~(1<<6);
3394  0459 721d5013      	bres	20499,#6
3395                     ; 596 GPIOD->DDR&=~(1<<7);
3397  045d 721f5011      	bres	20497,#7
3398                     ; 597 GPIOD->CR1|=(1<<7);
3400  0461 721e5012      	bset	20498,#7
3401                     ; 598 GPIOD->CR2&=~(1<<7);
3403  0465 721f5013      	bres	20499,#7
3404                     ; 600 if(GPIOD->IDR&(1<<6))
3406  0469 c65010        	ld	a,20496
3407  046c a540          	bcp	a,#64
3408  046e 270a          	jreq	L5671
3409                     ; 602 	if(cnt_JP0<10)
3411  0470 b653          	ld	a,_cnt_JP0
3412  0472 a10a          	cp	a,#10
3413  0474 2411          	jruge	L1771
3414                     ; 604 		cnt_JP0++;
3416  0476 3c53          	inc	_cnt_JP0
3417  0478 200d          	jra	L1771
3418  047a               L5671:
3419                     ; 607 else if(!(GPIOD->IDR&(1<<6)))
3421  047a c65010        	ld	a,20496
3422  047d a540          	bcp	a,#64
3423  047f 2606          	jrne	L1771
3424                     ; 609 	if(cnt_JP0)
3426  0481 3d53          	tnz	_cnt_JP0
3427  0483 2702          	jreq	L1771
3428                     ; 611 		cnt_JP0--;
3430  0485 3a53          	dec	_cnt_JP0
3431  0487               L1771:
3432                     ; 615 if(GPIOD->IDR&(1<<7))
3434  0487 c65010        	ld	a,20496
3435  048a a580          	bcp	a,#128
3436  048c 270a          	jreq	L7771
3437                     ; 617 	if(cnt_JP1<10)
3439  048e b652          	ld	a,_cnt_JP1
3440  0490 a10a          	cp	a,#10
3441  0492 2411          	jruge	L3002
3442                     ; 619 		cnt_JP1++;
3444  0494 3c52          	inc	_cnt_JP1
3445  0496 200d          	jra	L3002
3446  0498               L7771:
3447                     ; 622 else if(!(GPIOD->IDR&(1<<7)))
3449  0498 c65010        	ld	a,20496
3450  049b a580          	bcp	a,#128
3451  049d 2606          	jrne	L3002
3452                     ; 624 	if(cnt_JP1)
3454  049f 3d52          	tnz	_cnt_JP1
3455  04a1 2702          	jreq	L3002
3456                     ; 626 		cnt_JP1--;
3458  04a3 3a52          	dec	_cnt_JP1
3459  04a5               L3002:
3460                     ; 631 if((cnt_JP0==10)&&(cnt_JP1==10))
3462  04a5 b653          	ld	a,_cnt_JP0
3463  04a7 a10a          	cp	a,#10
3464  04a9 2608          	jrne	L1102
3466  04ab b652          	ld	a,_cnt_JP1
3467  04ad a10a          	cp	a,#10
3468  04af 2602          	jrne	L1102
3469                     ; 633 	jp_mode=jp0;
3471  04b1 3f54          	clr	_jp_mode
3472  04b3               L1102:
3473                     ; 635 if((cnt_JP0==0)&&(cnt_JP1==10))
3475  04b3 3d53          	tnz	_cnt_JP0
3476  04b5 260a          	jrne	L3102
3478  04b7 b652          	ld	a,_cnt_JP1
3479  04b9 a10a          	cp	a,#10
3480  04bb 2604          	jrne	L3102
3481                     ; 637 	jp_mode=jp1;
3483  04bd 35010054      	mov	_jp_mode,#1
3484  04c1               L3102:
3485                     ; 639 if((cnt_JP0==10)&&(cnt_JP1==0))
3487  04c1 b653          	ld	a,_cnt_JP0
3488  04c3 a10a          	cp	a,#10
3489  04c5 2608          	jrne	L5102
3491  04c7 3d52          	tnz	_cnt_JP1
3492  04c9 2604          	jrne	L5102
3493                     ; 641 	jp_mode=jp2;
3495  04cb 35020054      	mov	_jp_mode,#2
3496  04cf               L5102:
3497                     ; 643 if((cnt_JP0==0)&&(cnt_JP1==0))
3499  04cf 3d53          	tnz	_cnt_JP0
3500  04d1 2608          	jrne	L7102
3502  04d3 3d52          	tnz	_cnt_JP1
3503  04d5 2604          	jrne	L7102
3504                     ; 645 	jp_mode=jp3;
3506  04d7 35030054      	mov	_jp_mode,#3
3507  04db               L7102:
3508                     ; 648 }
3511  04db 81            	ret
3543                     ; 651 void link_drv(void)		//10Hz
3543                     ; 652 {
3544                     	switch	.text
3545  04dc               _link_drv:
3549                     ; 653 if(jp_mode!=jp3)
3551  04dc b654          	ld	a,_jp_mode
3552  04de a103          	cp	a,#3
3553  04e0 274d          	jreq	L1302
3554                     ; 655 	if(link_cnt<602)link_cnt++;
3556  04e2 9c            	rvf
3557  04e3 be6b          	ldw	x,_link_cnt
3558  04e5 a3025a        	cpw	x,#602
3559  04e8 2e07          	jrsge	L3302
3562  04ea be6b          	ldw	x,_link_cnt
3563  04ec 1c0001        	addw	x,#1
3564  04ef bf6b          	ldw	_link_cnt,x
3565  04f1               L3302:
3566                     ; 656 	if(link_cnt==90)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
3568  04f1 be6b          	ldw	x,_link_cnt
3569  04f3 a3005a        	cpw	x,#90
3570  04f6 2606          	jrne	L5302
3573  04f8 b605          	ld	a,_flags
3574  04fa a4c1          	and	a,#193
3575  04fc b705          	ld	_flags,a
3576  04fe               L5302:
3577                     ; 657 	if(link_cnt==100)
3579  04fe be6b          	ldw	x,_link_cnt
3580  0500 a30064        	cpw	x,#100
3581  0503 262e          	jrne	L7402
3582                     ; 659 		link=OFF;
3584  0505 35aa006d      	mov	_link,#170
3585                     ; 664 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
3587  0509 b60b          	ld	a,_bps_class
3588  050b a101          	cp	a,#1
3589  050d 2606          	jrne	L1402
3592  050f 72100001      	bset	_bMAIN
3594  0513 2004          	jra	L3402
3595  0515               L1402:
3596                     ; 665 		else bMAIN=0;
3598  0515 72110001      	bres	_bMAIN
3599  0519               L3402:
3600                     ; 667 		cnt_net_drv=0;
3602  0519 3f3c          	clr	_cnt_net_drv
3603                     ; 668     		if(!res_fl_)
3605  051b 725d000a      	tnz	_res_fl_
3606  051f 2612          	jrne	L7402
3607                     ; 670 	    		bRES_=1;
3609  0521 3501000d      	mov	_bRES_,#1
3610                     ; 671 	    		res_fl_=1;
3612  0525 a601          	ld	a,#1
3613  0527 ae000a        	ldw	x,#_res_fl_
3614  052a cd0000        	call	c_eewrc
3616  052d 2004          	jra	L7402
3617  052f               L1302:
3618                     ; 675 else link=OFF;	
3620  052f 35aa006d      	mov	_link,#170
3621  0533               L7402:
3622                     ; 676 } 
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
3705                     ; 680 void vent_drv(void)
3705                     ; 681 {
3706                     	switch	.text
3707  0534               _vent_drv:
3709  0534 520c          	subw	sp,#12
3710       0000000c      OFST:	set	12
3713                     ; 684 	short vent_pwm_i_necc=400;
3715  0536 ae0190        	ldw	x,#400
3716  0539 1f05          	ldw	(OFST-7,sp),x
3717                     ; 685 	short vent_pwm_t_necc=400;
3719  053b ae0190        	ldw	x,#400
3720  053e 1f07          	ldw	(OFST-5,sp),x
3721                     ; 686 	short vent_pwm_max_necc=400;
3723                     ; 692 	tempSL=(signed long)I;
3725  0540 ce0018        	ldw	x,_I
3726  0543 cd0000        	call	c_itolx
3728  0546 96            	ldw	x,sp
3729  0547 1c0009        	addw	x,#OFST-3
3730  054a cd0000        	call	c_rtol
3732                     ; 693 	tempSL*=(signed long)Ui;
3734  054d ce0014        	ldw	x,_Ui
3735  0550 cd0000        	call	c_itolx
3737  0553 96            	ldw	x,sp
3738  0554 1c0009        	addw	x,#OFST-3
3739  0557 cd0000        	call	c_lgmul
3741                     ; 694 	tempSL/=100L;
3743  055a 96            	ldw	x,sp
3744  055b 1c0009        	addw	x,#OFST-3
3745  055e cd0000        	call	c_ltor
3747  0561 ae0004        	ldw	x,#L63
3748  0564 cd0000        	call	c_ldiv
3750  0567 96            	ldw	x,sp
3751  0568 1c0009        	addw	x,#OFST-3
3752  056b cd0000        	call	c_rtol
3754                     ; 702 	if(tempSL>3000L)vent_pwm_i_necc=1000;
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
3772                     ; 703 	else if(tempSL<300L)vent_pwm_i_necc=0;
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
3790                     ; 704 	else vent_pwm_i_necc=(short)(400L + ((tempSL-300L)/4L));
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
3808                     ; 705 	gran(&vent_pwm_i_necc,0,1000);
3810  05b7 ae03e8        	ldw	x,#1000
3811  05ba 89            	pushw	x
3812  05bb 5f            	clrw	x
3813  05bc 89            	pushw	x
3814  05bd 96            	ldw	x,sp
3815  05be 1c0009        	addw	x,#OFST-3
3816  05c1 cd00d5        	call	_gran
3818  05c4 5b04          	addw	sp,#4
3819                     ; 707 	tempSL=(signed long)T;
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
3833                     ; 708 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
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
3854                     ; 709 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
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
3872                     ; 710 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
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
3885                     ; 711 	gran(&vent_pwm_t_necc,0,1000);
3887  0625 ae03e8        	ldw	x,#1000
3888  0628 89            	pushw	x
3889  0629 5f            	clrw	x
3890  062a 89            	pushw	x
3891  062b 96            	ldw	x,sp
3892  062c 1c000b        	addw	x,#OFST-1
3893  062f cd00d5        	call	_gran
3895  0632 5b04          	addw	sp,#4
3896                     ; 713 	vent_pwm_max_necc=vent_pwm_i_necc;
3898  0634 1e05          	ldw	x,(OFST-7,sp)
3899  0636 1f03          	ldw	(OFST-9,sp),x
3900                     ; 714 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3902  0638 9c            	rvf
3903  0639 1e07          	ldw	x,(OFST-5,sp)
3904  063b 1305          	cpw	x,(OFST-7,sp)
3905  063d 2d04          	jrsle	L3212
3908  063f 1e07          	ldw	x,(OFST-5,sp)
3909  0641 1f03          	ldw	(OFST-9,sp),x
3910  0643               L3212:
3911                     ; 716 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3913  0643 9c            	rvf
3914  0644 be10          	ldw	x,_vent_pwm
3915  0646 1303          	cpw	x,(OFST-9,sp)
3916  0648 2e07          	jrsge	L5212
3919  064a be10          	ldw	x,_vent_pwm
3920  064c 1c000a        	addw	x,#10
3921  064f bf10          	ldw	_vent_pwm,x
3922  0651               L5212:
3923                     ; 717 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3925  0651 9c            	rvf
3926  0652 be10          	ldw	x,_vent_pwm
3927  0654 1303          	cpw	x,(OFST-9,sp)
3928  0656 2d07          	jrsle	L7212
3931  0658 be10          	ldw	x,_vent_pwm
3932  065a 1d000a        	subw	x,#10
3933  065d bf10          	ldw	_vent_pwm,x
3934  065f               L7212:
3935                     ; 718 	gran(&vent_pwm,0,1000);
3937  065f ae03e8        	ldw	x,#1000
3938  0662 89            	pushw	x
3939  0663 5f            	clrw	x
3940  0664 89            	pushw	x
3941  0665 ae0010        	ldw	x,#_vent_pwm
3942  0668 cd00d5        	call	_gran
3944  066b 5b04          	addw	sp,#4
3945                     ; 724 	if(vent_pwm_integr_cnt<10)
3947  066d 9c            	rvf
3948  066e be0c          	ldw	x,_vent_pwm_integr_cnt
3949  0670 a3000a        	cpw	x,#10
3950  0673 2e26          	jrsge	L1312
3951                     ; 726 		vent_pwm_integr_cnt++;
3953  0675 be0c          	ldw	x,_vent_pwm_integr_cnt
3954  0677 1c0001        	addw	x,#1
3955  067a bf0c          	ldw	_vent_pwm_integr_cnt,x
3956                     ; 727 		if(vent_pwm_integr_cnt>=10)
3958  067c 9c            	rvf
3959  067d be0c          	ldw	x,_vent_pwm_integr_cnt
3960  067f a3000a        	cpw	x,#10
3961  0682 2f17          	jrslt	L1312
3962                     ; 729 			vent_pwm_integr_cnt=0;
3964  0684 5f            	clrw	x
3965  0685 bf0c          	ldw	_vent_pwm_integr_cnt,x
3966                     ; 730 			vent_pwm_integr=((vent_pwm_integr*9)+vent_pwm)/10;
3968  0687 be0e          	ldw	x,_vent_pwm_integr
3969  0689 90ae0009      	ldw	y,#9
3970  068d cd0000        	call	c_imul
3972  0690 72bb0010      	addw	x,_vent_pwm
3973  0694 a60a          	ld	a,#10
3974  0696 cd0000        	call	c_sdivx
3976  0699 bf0e          	ldw	_vent_pwm_integr,x
3977  069b               L1312:
3978                     ; 733 	gran(&vent_pwm_integr,0,1000);
3980  069b ae03e8        	ldw	x,#1000
3981  069e 89            	pushw	x
3982  069f 5f            	clrw	x
3983  06a0 89            	pushw	x
3984  06a1 ae000e        	ldw	x,#_vent_pwm_integr
3985  06a4 cd00d5        	call	_gran
3987  06a7 5b04          	addw	sp,#4
3988                     ; 737 }
3991  06a9 5b0c          	addw	sp,#12
3992  06ab 81            	ret
4021                     ; 742 void pwr_drv(void)
4021                     ; 743 {
4022                     	switch	.text
4023  06ac               _pwr_drv:
4027                     ; 804 gran(&pwm_u,10,2000);
4029  06ac ae07d0        	ldw	x,#2000
4030  06af 89            	pushw	x
4031  06b0 ae000a        	ldw	x,#10
4032  06b3 89            	pushw	x
4033  06b4 ae0008        	ldw	x,#_pwm_u
4034  06b7 cd00d5        	call	_gran
4036  06ba 5b04          	addw	sp,#4
4037                     ; 806 gran(&pwm_i,10,alfa_pwm_max_t);
4039  06bc ce0006        	ldw	x,_alfa_pwm_max_t
4040  06bf 89            	pushw	x
4041  06c0 ae000a        	ldw	x,#10
4042  06c3 89            	pushw	x
4043  06c4 ae000a        	ldw	x,#_pwm_i
4044  06c7 cd00d5        	call	_gran
4046  06ca 5b04          	addw	sp,#4
4047                     ; 807 gran(&pwm_i,10,alfa_pwm_max_i);
4049  06cc ce0004        	ldw	x,_alfa_pwm_max_i
4050  06cf 89            	pushw	x
4051  06d0 ae000a        	ldw	x,#10
4052  06d3 89            	pushw	x
4053  06d4 ae000a        	ldw	x,#_pwm_i
4054  06d7 cd00d5        	call	_gran
4056  06da 5b04          	addw	sp,#4
4057                     ; 808 gran(&pwm_i,10,2000);
4059  06dc ae07d0        	ldw	x,#2000
4060  06df 89            	pushw	x
4061  06e0 ae000a        	ldw	x,#10
4062  06e3 89            	pushw	x
4063  06e4 ae000a        	ldw	x,#_pwm_i
4064  06e7 cd00d5        	call	_gran
4066  06ea 5b04          	addw	sp,#4
4067                     ; 817 TIM1->CCR2H= (char)(pwm_u/256);	
4069  06ec be08          	ldw	x,_pwm_u
4070  06ee 90ae0100      	ldw	y,#256
4071  06f2 cd0000        	call	c_idiv
4073  06f5 9f            	ld	a,xl
4074  06f6 c75267        	ld	21095,a
4075                     ; 818 TIM1->CCR2L= (char)pwm_u;
4077  06f9 5500095268    	mov	21096,_pwm_u+1
4078                     ; 820 TIM1->CCR1H= (char)(pwm_i/256);	
4080  06fe be0a          	ldw	x,_pwm_i
4081  0700 90ae0100      	ldw	y,#256
4082  0704 cd0000        	call	c_idiv
4084  0707 9f            	ld	a,xl
4085  0708 c75265        	ld	21093,a
4086                     ; 821 TIM1->CCR1L= (char)pwm_i;
4088  070b 55000b5266    	mov	21094,_pwm_i+1
4089                     ; 823 TIM1->CCR3H= (char)(vent_pwm_integr/128);	
4091  0710 be0e          	ldw	x,_vent_pwm_integr
4092  0712 90ae0080      	ldw	y,#128
4093  0716 cd0000        	call	c_idiv
4095  0719 9f            	ld	a,xl
4096  071a c75269        	ld	21097,a
4097                     ; 824 TIM1->CCR3L= (char)(vent_pwm_integr*2);
4099  071d b60f          	ld	a,_vent_pwm_integr+1
4100  071f 48            	sll	a
4101  0720 c7526a        	ld	21098,a
4102                     ; 825 }
4105  0723 81            	ret
4145                     ; 830 void alfa_hndl(void)				
4145                     ; 831 {
4146                     	switch	.text
4147  0724               _alfa_hndl:
4149  0724 89            	pushw	x
4150       00000002      OFST:	set	2
4153                     ; 833 if(T<=60)alfa_pwm_max_t=2000;
4155  0725 9c            	rvf
4156  0726 b672          	ld	a,_T
4157  0728 a13d          	cp	a,#61
4158  072a 2e08          	jrsge	L3612
4161  072c ae07d0        	ldw	x,#2000
4162  072f cf0006        	ldw	_alfa_pwm_max_t,x
4164  0732 2050          	jra	L5612
4165  0734               L3612:
4166                     ; 834 else if(T>=80)alfa_pwm_max_t=1200;
4168  0734 9c            	rvf
4169  0735 b672          	ld	a,_T
4170  0737 a150          	cp	a,#80
4171  0739 2f08          	jrslt	L7612
4174  073b ae04b0        	ldw	x,#1200
4175  073e cf0006        	ldw	_alfa_pwm_max_t,x
4177  0741 2041          	jra	L5612
4178  0743               L7612:
4179                     ; 837 	short temp=T;
4181  0743 5f            	clrw	x
4182  0744 b672          	ld	a,_T
4183  0746 2a01          	jrpl	L45
4184  0748 53            	cplw	x
4185  0749               L45:
4186  0749 97            	ld	xl,a
4187  074a 1f01          	ldw	(OFST-1,sp),x
4188                     ; 838 	temp=temp-60;
4190  074c 1e01          	ldw	x,(OFST-1,sp)
4191  074e 1d003c        	subw	x,#60
4192  0751 1f01          	ldw	(OFST-1,sp),x
4193                     ; 839 	temp*=80;
4195  0753 1e01          	ldw	x,(OFST-1,sp)
4196  0755 90ae0050      	ldw	y,#80
4197  0759 cd0000        	call	c_imul
4199  075c 1f01          	ldw	(OFST-1,sp),x
4200                     ; 840 	temp/=2;
4202  075e 1e01          	ldw	x,(OFST-1,sp)
4203  0760 a602          	ld	a,#2
4204  0762 cd0000        	call	c_sdivx
4206  0765 1f01          	ldw	(OFST-1,sp),x
4207                     ; 841 	if(temp>800)temp=800;
4209  0767 9c            	rvf
4210  0768 1e01          	ldw	x,(OFST-1,sp)
4211  076a a30321        	cpw	x,#801
4212  076d 2f05          	jrslt	L3712
4215  076f ae0320        	ldw	x,#800
4216  0772 1f01          	ldw	(OFST-1,sp),x
4217  0774               L3712:
4218                     ; 842 	if(temp<0)temp=0;
4220  0774 9c            	rvf
4221  0775 1e01          	ldw	x,(OFST-1,sp)
4222  0777 2e03          	jrsge	L5712
4225  0779 5f            	clrw	x
4226  077a 1f01          	ldw	(OFST-1,sp),x
4227  077c               L5712:
4228                     ; 843 	alfa_pwm_max_t=1200+temp;
4230  077c 1e01          	ldw	x,(OFST-1,sp)
4231  077e 1c04b0        	addw	x,#1200
4232  0781 cf0006        	ldw	_alfa_pwm_max_t,x
4233  0784               L5612:
4234                     ; 846 if(I>=750)
4236  0784 9c            	rvf
4237  0785 ce0018        	ldw	x,_I
4238  0788 a302ee        	cpw	x,#750
4239  078b 2f23          	jrslt	L7712
4240                     ; 848 	if(alfa_pwm_max_i_cnt__<10)
4242  078d 9c            	rvf
4243  078e ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4244  0791 a3000a        	cpw	x,#10
4245  0794 2e31          	jrsge	L5022
4246                     ; 850 		alfa_pwm_max_i_cnt__++;
4248  0796 ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4249  0799 1c0001        	addw	x,#1
4250  079c cf0000        	ldw	_alfa_pwm_max_i_cnt__,x
4251                     ; 851 		if(alfa_pwm_max_i_cnt__>=10)alfa_pwm_max_i_cnt=60;
4253  079f 9c            	rvf
4254  07a0 ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4255  07a3 a3000a        	cpw	x,#10
4256  07a6 2f1f          	jrslt	L5022
4259  07a8 ae003c        	ldw	x,#60
4260  07ab cf0002        	ldw	_alfa_pwm_max_i_cnt,x
4261  07ae 2017          	jra	L5022
4262  07b0               L7712:
4263                     ; 854 else if(I<500)
4265  07b0 9c            	rvf
4266  07b1 ce0018        	ldw	x,_I
4267  07b4 a301f4        	cpw	x,#500
4268  07b7 2e0e          	jrsge	L5022
4269                     ; 856 	if(alfa_pwm_max_i_cnt__)
4271  07b9 ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4272  07bc 2709          	jreq	L5022
4273                     ; 858 		alfa_pwm_max_i_cnt__--;	
4275  07be ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4276  07c1 1d0001        	subw	x,#1
4277  07c4 cf0000        	ldw	_alfa_pwm_max_i_cnt__,x
4278  07c7               L5022:
4279                     ; 862 if(alfa_pwm_max_i_cnt)
4281  07c7 ce0002        	ldw	x,_alfa_pwm_max_i_cnt
4282  07ca 2711          	jreq	L3122
4283                     ; 864 	alfa_pwm_max_i_cnt--;
4285  07cc ce0002        	ldw	x,_alfa_pwm_max_i_cnt
4286  07cf 1d0001        	subw	x,#1
4287  07d2 cf0002        	ldw	_alfa_pwm_max_i_cnt,x
4288                     ; 865 	alfa_pwm_max_i=1200;	
4290  07d5 ae04b0        	ldw	x,#1200
4291  07d8 cf0004        	ldw	_alfa_pwm_max_i,x
4293  07db 2006          	jra	L5122
4294  07dd               L3122:
4295                     ; 869 	alfa_pwm_max_i=2000;
4297  07dd ae07d0        	ldw	x,#2000
4298  07e0 cf0004        	ldw	_alfa_pwm_max_i,x
4299  07e3               L5122:
4300                     ; 871 }
4303  07e3 85            	popw	x
4304  07e4 81            	ret
4361                     	switch	.const
4362  0018               L06:
4363  0018 0000028a      	dc.l	650
4364                     ; 876 void pwr_hndl(void)				
4364                     ; 877 {
4365                     	switch	.text
4366  07e5               _pwr_hndl:
4368  07e5 5205          	subw	sp,#5
4369       00000005      OFST:	set	5
4372                     ; 878 if(jp_mode==jp3)
4374  07e7 b654          	ld	a,_jp_mode
4375  07e9 a103          	cp	a,#3
4376  07eb 260a          	jrne	L1422
4377                     ; 880 	pwm_u=0;
4379  07ed 5f            	clrw	x
4380  07ee bf08          	ldw	_pwm_u,x
4381                     ; 881 	pwm_i=0;
4383  07f0 5f            	clrw	x
4384  07f1 bf0a          	ldw	_pwm_i,x
4386  07f3 ac170917      	jpf	L3422
4387  07f7               L1422:
4388                     ; 883 else if(jp_mode==jp2)
4390  07f7 b654          	ld	a,_jp_mode
4391  07f9 a102          	cp	a,#2
4392  07fb 260c          	jrne	L5422
4393                     ; 885 	pwm_u=0;
4395  07fd 5f            	clrw	x
4396  07fe bf08          	ldw	_pwm_u,x
4397                     ; 886 	pwm_i=0x7ff;
4399  0800 ae07ff        	ldw	x,#2047
4400  0803 bf0a          	ldw	_pwm_i,x
4402  0805 ac170917      	jpf	L3422
4403  0809               L5422:
4404                     ; 888 else if(jp_mode==jp1)
4406  0809 b654          	ld	a,_jp_mode
4407  080b a101          	cp	a,#1
4408  080d 260e          	jrne	L1522
4409                     ; 890 	pwm_u=0x7ff;
4411  080f ae07ff        	ldw	x,#2047
4412  0812 bf08          	ldw	_pwm_u,x
4413                     ; 891 	pwm_i=0x7ff;
4415  0814 ae07ff        	ldw	x,#2047
4416  0817 bf0a          	ldw	_pwm_i,x
4418  0819 ac170917      	jpf	L3422
4419  081d               L1522:
4420                     ; 902 else if(link==OFF)
4422  081d b66d          	ld	a,_link
4423  081f a1aa          	cp	a,#170
4424  0821 2703          	jreq	L26
4425  0823 cc08c5        	jp	L5522
4426  0826               L26:
4427                     ; 904 	pwm_i=0x7ff;
4429  0826 ae07ff        	ldw	x,#2047
4430  0829 bf0a          	ldw	_pwm_i,x
4431                     ; 905 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4433  082b ce0012        	ldw	x,_Unecc
4434  082e 90ae07d0      	ldw	y,#2000
4435  0832 cd0000        	call	c_vmul
4437  0835 ae0018        	ldw	x,#L06
4438  0838 cd0000        	call	c_ldiv
4440  083b be02          	ldw	x,c_lreg+2
4441  083d bf55          	ldw	_pwm_u_,x
4442                     ; 909 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4444  083f c6001b        	ld	a,_pwm_u_buff_ptr
4445  0842 5f            	clrw	x
4446  0843 97            	ld	xl,a
4447  0844 58            	sllw	x
4448  0845 90be55        	ldw	y,_pwm_u_
4449  0848 df001e        	ldw	(_pwm_u_buff,x),y
4450                     ; 910 	pwm_u_buff_ptr++;
4452  084b 725c001b      	inc	_pwm_u_buff_ptr
4453                     ; 911 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4455  084f c6001b        	ld	a,_pwm_u_buff_ptr
4456  0852 a110          	cp	a,#16
4457  0854 2504          	jrult	L7522
4460  0856 725f001b      	clr	_pwm_u_buff_ptr
4461  085a               L7522:
4462                     ; 915 		tempSL=0;
4464  085a ae0000        	ldw	x,#0
4465  085d 1f03          	ldw	(OFST-2,sp),x
4466  085f ae0000        	ldw	x,#0
4467  0862 1f01          	ldw	(OFST-4,sp),x
4468                     ; 916 		for(i=0;i<16;i++)
4470  0864 0f05          	clr	(OFST+0,sp)
4471  0866               L1622:
4472                     ; 918 			tempSL+=(signed long)pwm_u_buff[i];
4474  0866 7b05          	ld	a,(OFST+0,sp)
4475  0868 5f            	clrw	x
4476  0869 97            	ld	xl,a
4477  086a 58            	sllw	x
4478  086b de001e        	ldw	x,(_pwm_u_buff,x)
4479  086e cd0000        	call	c_itolx
4481  0871 96            	ldw	x,sp
4482  0872 1c0001        	addw	x,#OFST-4
4483  0875 cd0000        	call	c_lgadd
4485                     ; 916 		for(i=0;i<16;i++)
4487  0878 0c05          	inc	(OFST+0,sp)
4490  087a 7b05          	ld	a,(OFST+0,sp)
4491  087c a110          	cp	a,#16
4492  087e 25e6          	jrult	L1622
4493                     ; 920 		tempSL>>=4;
4495  0880 96            	ldw	x,sp
4496  0881 1c0001        	addw	x,#OFST-4
4497  0884 a604          	ld	a,#4
4498  0886 cd0000        	call	c_lgrsh
4500                     ; 921 		pwm_u_buff_=(signed short)tempSL;
4502  0889 1e03          	ldw	x,(OFST-2,sp)
4503  088b cf001c        	ldw	_pwm_u_buff_,x
4504                     ; 923 	pwm_u=pwm_u_;
4506  088e be55          	ldw	x,_pwm_u_
4507  0890 bf08          	ldw	_pwm_u,x
4508                     ; 924 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4510  0892 9c            	rvf
4511  0893 ce0014        	ldw	x,_Ui
4512  0896 72b00012      	subw	x,_Unecc
4513  089a cd0000        	call	_abs
4515  089d a30014        	cpw	x,#20
4516  08a0 2e06          	jrsge	L7622
4519  08a2 725c001a      	inc	_pwm_u_buff_cnt
4521  08a6 2004          	jra	L1722
4522  08a8               L7622:
4523                     ; 925 	else pwm_u_buff_cnt=0;
4525  08a8 725f001a      	clr	_pwm_u_buff_cnt
4526  08ac               L1722:
4527                     ; 927 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4529  08ac c6001a        	ld	a,_pwm_u_buff_cnt
4530  08af a114          	cp	a,#20
4531  08b1 2504          	jrult	L3722
4534  08b3 3514001a      	mov	_pwm_u_buff_cnt,#20
4535  08b7               L3722:
4536                     ; 928 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4538  08b7 c6001a        	ld	a,_pwm_u_buff_cnt
4539  08ba a10f          	cp	a,#15
4540  08bc 2559          	jrult	L3422
4543  08be ce001c        	ldw	x,_pwm_u_buff_
4544  08c1 bf08          	ldw	_pwm_u,x
4545  08c3 2052          	jra	L3422
4546  08c5               L5522:
4547                     ; 932 else	if(link==ON)				//если есть связьvol_i_temp_avar
4549  08c5 b66d          	ld	a,_link
4550  08c7 a155          	cp	a,#85
4551  08c9 264c          	jrne	L3422
4552                     ; 934 	if((flags&0b00100000)==0)	//если нет блокировки извне
4554  08cb b605          	ld	a,_flags
4555  08cd a520          	bcp	a,#32
4556  08cf 263a          	jrne	L3032
4557                     ; 941 		else*/ if(flags&0b00011010)					//если есть аварии
4559  08d1 b605          	ld	a,_flags
4560  08d3 a51a          	bcp	a,#26
4561  08d5 2706          	jreq	L5032
4562                     ; 943 			pwm_u=0;								//то полный стоп
4564  08d7 5f            	clrw	x
4565  08d8 bf08          	ldw	_pwm_u,x
4566                     ; 944 			pwm_i=0;
4568  08da 5f            	clrw	x
4569  08db bf0a          	ldw	_pwm_i,x
4570  08dd               L5032:
4571                     ; 947 		if(vol_i_temp==2000)
4573  08dd be60          	ldw	x,_vol_i_temp
4574  08df a307d0        	cpw	x,#2000
4575  08e2 260c          	jrne	L7032
4576                     ; 949 			pwm_u=1500;
4578  08e4 ae05dc        	ldw	x,#1500
4579  08e7 bf08          	ldw	_pwm_u,x
4580                     ; 950 			pwm_i=2000;
4582  08e9 ae07d0        	ldw	x,#2000
4583  08ec bf0a          	ldw	_pwm_i,x
4585  08ee 2027          	jra	L3422
4586  08f0               L7032:
4587                     ; 963 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4589  08f0 ce0012        	ldw	x,_Unecc
4590  08f3 90ae07d0      	ldw	y,#2000
4591  08f7 cd0000        	call	c_vmul
4593  08fa ae0018        	ldw	x,#L06
4594  08fd cd0000        	call	c_ldiv
4596  0900 be02          	ldw	x,c_lreg+2
4597  0902 bf08          	ldw	_pwm_u,x
4598                     ; 964 			pwm_i=2000;
4600  0904 ae07d0        	ldw	x,#2000
4601  0907 bf0a          	ldw	_pwm_i,x
4602  0909 200c          	jra	L3422
4603  090b               L3032:
4604                     ; 970 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4606  090b b605          	ld	a,_flags
4607  090d a520          	bcp	a,#32
4608  090f 2706          	jreq	L3422
4609                     ; 972 		pwm_u=0;
4611  0911 5f            	clrw	x
4612  0912 bf08          	ldw	_pwm_u,x
4613                     ; 973 		pwm_i=0;
4615  0914 5f            	clrw	x
4616  0915 bf0a          	ldw	_pwm_i,x
4617  0917               L3422:
4618                     ; 1001 if(pwm_u>2000)pwm_u=2000;
4620  0917 9c            	rvf
4621  0918 be08          	ldw	x,_pwm_u
4622  091a a307d1        	cpw	x,#2001
4623  091d 2f05          	jrslt	L7132
4626  091f ae07d0        	ldw	x,#2000
4627  0922 bf08          	ldw	_pwm_u,x
4628  0924               L7132:
4629                     ; 1002 if(pwm_i>2000)pwm_i=2000;
4631  0924 9c            	rvf
4632  0925 be0a          	ldw	x,_pwm_i
4633  0927 a307d1        	cpw	x,#2001
4634  092a 2f05          	jrslt	L1232
4637  092c ae07d0        	ldw	x,#2000
4638  092f bf0a          	ldw	_pwm_i,x
4639  0931               L1232:
4640                     ; 1005 }
4643  0931 5b05          	addw	sp,#5
4644  0933 81            	ret
4697                     	switch	.const
4698  001c               L66:
4699  001c 00000258      	dc.l	600
4700  0020               L07:
4701  0020 000003e8      	dc.l	1000
4702  0024               L27:
4703  0024 00000708      	dc.l	1800
4704                     ; 1008 void matemat(void)
4704                     ; 1009 {
4705                     	switch	.text
4706  0934               _matemat:
4708  0934 5208          	subw	sp,#8
4709       00000008      OFST:	set	8
4712                     ; 1033 I=adc_buff_[4];
4714  0936 ce010f        	ldw	x,_adc_buff_+8
4715  0939 cf0018        	ldw	_I,x
4716                     ; 1034 temp_SL=adc_buff_[4];
4718  093c ce010f        	ldw	x,_adc_buff_+8
4719  093f cd0000        	call	c_itolx
4721  0942 96            	ldw	x,sp
4722  0943 1c0005        	addw	x,#OFST-3
4723  0946 cd0000        	call	c_rtol
4725                     ; 1035 temp_SL-=ee_K[0][0];
4727  0949 ce001a        	ldw	x,_ee_K
4728  094c cd0000        	call	c_itolx
4730  094f 96            	ldw	x,sp
4731  0950 1c0005        	addw	x,#OFST-3
4732  0953 cd0000        	call	c_lgsub
4734                     ; 1036 if(temp_SL<0) temp_SL=0;
4736  0956 9c            	rvf
4737  0957 0d05          	tnz	(OFST-3,sp)
4738  0959 2e0a          	jrsge	L1432
4741  095b ae0000        	ldw	x,#0
4742  095e 1f07          	ldw	(OFST-1,sp),x
4743  0960 ae0000        	ldw	x,#0
4744  0963 1f05          	ldw	(OFST-3,sp),x
4745  0965               L1432:
4746                     ; 1037 temp_SL*=ee_K[0][1];
4748  0965 ce001c        	ldw	x,_ee_K+2
4749  0968 cd0000        	call	c_itolx
4751  096b 96            	ldw	x,sp
4752  096c 1c0005        	addw	x,#OFST-3
4753  096f cd0000        	call	c_lgmul
4755                     ; 1038 temp_SL/=600;
4757  0972 96            	ldw	x,sp
4758  0973 1c0005        	addw	x,#OFST-3
4759  0976 cd0000        	call	c_ltor
4761  0979 ae001c        	ldw	x,#L66
4762  097c cd0000        	call	c_ldiv
4764  097f 96            	ldw	x,sp
4765  0980 1c0005        	addw	x,#OFST-3
4766  0983 cd0000        	call	c_rtol
4768                     ; 1039 I=(signed short)temp_SL;
4770  0986 1e07          	ldw	x,(OFST-1,sp)
4771  0988 cf0018        	ldw	_I,x
4772                     ; 1042 temp_SL=(signed long)adc_buff_[1];//1;
4774                     ; 1043 temp_SL=(signed long)adc_buff_[3];//1;
4776  098b ce010d        	ldw	x,_adc_buff_+6
4777  098e cd0000        	call	c_itolx
4779  0991 96            	ldw	x,sp
4780  0992 1c0005        	addw	x,#OFST-3
4781  0995 cd0000        	call	c_rtol
4783                     ; 1045 if(temp_SL<0) temp_SL=0;
4785  0998 9c            	rvf
4786  0999 0d05          	tnz	(OFST-3,sp)
4787  099b 2e0a          	jrsge	L3432
4790  099d ae0000        	ldw	x,#0
4791  09a0 1f07          	ldw	(OFST-1,sp),x
4792  09a2 ae0000        	ldw	x,#0
4793  09a5 1f05          	ldw	(OFST-3,sp),x
4794  09a7               L3432:
4795                     ; 1046 temp_SL*=(signed long)ee_K[2][1];
4797  09a7 ce0024        	ldw	x,_ee_K+10
4798  09aa cd0000        	call	c_itolx
4800  09ad 96            	ldw	x,sp
4801  09ae 1c0005        	addw	x,#OFST-3
4802  09b1 cd0000        	call	c_lgmul
4804                     ; 1047 temp_SL/=1000L;
4806  09b4 96            	ldw	x,sp
4807  09b5 1c0005        	addw	x,#OFST-3
4808  09b8 cd0000        	call	c_ltor
4810  09bb ae0020        	ldw	x,#L07
4811  09be cd0000        	call	c_ldiv
4813  09c1 96            	ldw	x,sp
4814  09c2 1c0005        	addw	x,#OFST-3
4815  09c5 cd0000        	call	c_rtol
4817                     ; 1048 Ui=(unsigned short)temp_SL;
4819  09c8 1e07          	ldw	x,(OFST-1,sp)
4820  09ca cf0014        	ldw	_Ui,x
4821                     ; 1050 temp_SL=(signed long)adc_buff_5;
4823  09cd ce0105        	ldw	x,_adc_buff_5
4824  09d0 cd0000        	call	c_itolx
4826  09d3 96            	ldw	x,sp
4827  09d4 1c0005        	addw	x,#OFST-3
4828  09d7 cd0000        	call	c_rtol
4830                     ; 1052 if(temp_SL<0) temp_SL=0;
4832  09da 9c            	rvf
4833  09db 0d05          	tnz	(OFST-3,sp)
4834  09dd 2e0a          	jrsge	L5432
4837  09df ae0000        	ldw	x,#0
4838  09e2 1f07          	ldw	(OFST-1,sp),x
4839  09e4 ae0000        	ldw	x,#0
4840  09e7 1f05          	ldw	(OFST-3,sp),x
4841  09e9               L5432:
4842                     ; 1053 temp_SL*=(signed long)ee_K[4][1];
4844  09e9 ce002c        	ldw	x,_ee_K+18
4845  09ec cd0000        	call	c_itolx
4847  09ef 96            	ldw	x,sp
4848  09f0 1c0005        	addw	x,#OFST-3
4849  09f3 cd0000        	call	c_lgmul
4851                     ; 1054 temp_SL/=1000L;
4853  09f6 96            	ldw	x,sp
4854  09f7 1c0005        	addw	x,#OFST-3
4855  09fa cd0000        	call	c_ltor
4857  09fd ae0020        	ldw	x,#L07
4858  0a00 cd0000        	call	c_ldiv
4860  0a03 96            	ldw	x,sp
4861  0a04 1c0005        	addw	x,#OFST-3
4862  0a07 cd0000        	call	c_rtol
4864                     ; 1055 Usum=(unsigned short)temp_SL;
4866  0a0a 1e07          	ldw	x,(OFST-1,sp)
4867  0a0c cf000e        	ldw	_Usum,x
4868                     ; 1059 temp_SL=adc_buff_[3];
4870  0a0f ce010d        	ldw	x,_adc_buff_+6
4871  0a12 cd0000        	call	c_itolx
4873  0a15 96            	ldw	x,sp
4874  0a16 1c0005        	addw	x,#OFST-3
4875  0a19 cd0000        	call	c_rtol
4877                     ; 1061 if(temp_SL<0) temp_SL=0;
4879  0a1c 9c            	rvf
4880  0a1d 0d05          	tnz	(OFST-3,sp)
4881  0a1f 2e0a          	jrsge	L7432
4884  0a21 ae0000        	ldw	x,#0
4885  0a24 1f07          	ldw	(OFST-1,sp),x
4886  0a26 ae0000        	ldw	x,#0
4887  0a29 1f05          	ldw	(OFST-3,sp),x
4888  0a2b               L7432:
4889                     ; 1062 temp_SL*=ee_K[1][1];
4891  0a2b ce0020        	ldw	x,_ee_K+6
4892  0a2e cd0000        	call	c_itolx
4894  0a31 96            	ldw	x,sp
4895  0a32 1c0005        	addw	x,#OFST-3
4896  0a35 cd0000        	call	c_lgmul
4898                     ; 1063 temp_SL/=1800;
4900  0a38 96            	ldw	x,sp
4901  0a39 1c0005        	addw	x,#OFST-3
4902  0a3c cd0000        	call	c_ltor
4904  0a3f ae0024        	ldw	x,#L27
4905  0a42 cd0000        	call	c_ldiv
4907  0a45 96            	ldw	x,sp
4908  0a46 1c0005        	addw	x,#OFST-3
4909  0a49 cd0000        	call	c_rtol
4911                     ; 1064 Un=(unsigned short)temp_SL;
4913  0a4c 1e07          	ldw	x,(OFST-1,sp)
4914  0a4e cf0016        	ldw	_Un,x
4915                     ; 1069 temp_SL=adc_buff_[2];
4917  0a51 ce010b        	ldw	x,_adc_buff_+4
4918  0a54 cd0000        	call	c_itolx
4920  0a57 96            	ldw	x,sp
4921  0a58 1c0005        	addw	x,#OFST-3
4922  0a5b cd0000        	call	c_rtol
4924                     ; 1070 temp_SL*=ee_K[3][1];
4926  0a5e ce0028        	ldw	x,_ee_K+14
4927  0a61 cd0000        	call	c_itolx
4929  0a64 96            	ldw	x,sp
4930  0a65 1c0005        	addw	x,#OFST-3
4931  0a68 cd0000        	call	c_lgmul
4933                     ; 1071 temp_SL/=1000;
4935  0a6b 96            	ldw	x,sp
4936  0a6c 1c0005        	addw	x,#OFST-3
4937  0a6f cd0000        	call	c_ltor
4939  0a72 ae0020        	ldw	x,#L07
4940  0a75 cd0000        	call	c_ldiv
4942  0a78 96            	ldw	x,sp
4943  0a79 1c0005        	addw	x,#OFST-3
4944  0a7c cd0000        	call	c_rtol
4946                     ; 1072 T=(signed short)(temp_SL-273L);
4948  0a7f 7b08          	ld	a,(OFST+0,sp)
4949  0a81 5f            	clrw	x
4950  0a82 4d            	tnz	a
4951  0a83 2a01          	jrpl	L47
4952  0a85 53            	cplw	x
4953  0a86               L47:
4954  0a86 97            	ld	xl,a
4955  0a87 1d0111        	subw	x,#273
4956  0a8a 01            	rrwa	x,a
4957  0a8b b772          	ld	_T,a
4958  0a8d 02            	rlwa	x,a
4959                     ; 1073 if(T<-30)T=-30;
4961  0a8e 9c            	rvf
4962  0a8f b672          	ld	a,_T
4963  0a91 a1e2          	cp	a,#226
4964  0a93 2e04          	jrsge	L1532
4967  0a95 35e20072      	mov	_T,#226
4968  0a99               L1532:
4969                     ; 1074 if(T>120)T=120;
4971  0a99 9c            	rvf
4972  0a9a b672          	ld	a,_T
4973  0a9c a179          	cp	a,#121
4974  0a9e 2f04          	jrslt	L3532
4977  0aa0 35780072      	mov	_T,#120
4978  0aa4               L3532:
4979                     ; 1078 Uin=Usum-Ui;
4981  0aa4 ce000e        	ldw	x,_Usum
4982  0aa7 72b00014      	subw	x,_Ui
4983  0aab cf000c        	ldw	_Uin,x
4984                     ; 1079 if(link==ON)
4986  0aae b66d          	ld	a,_link
4987  0ab0 a155          	cp	a,#85
4988  0ab2 2610          	jrne	L5532
4989                     ; 1081 	Unecc=U_out_const-Uin+vol_i_temp;
4991  0ab4 ce0010        	ldw	x,_U_out_const
4992  0ab7 72b0000c      	subw	x,_Uin
4993  0abb 72bb0060      	addw	x,_vol_i_temp
4994  0abf cf0012        	ldw	_Unecc,x
4996  0ac2 200a          	jra	L7532
4997  0ac4               L5532:
4998                     ; 1090 else Unecc=ee_UAVT-Uin;
5000  0ac4 ce000c        	ldw	x,_ee_UAVT
5001  0ac7 72b0000c      	subw	x,_Uin
5002  0acb cf0012        	ldw	_Unecc,x
5003  0ace               L7532:
5004                     ; 1098 if(Unecc<0)Unecc=0;
5006  0ace 9c            	rvf
5007  0acf ce0012        	ldw	x,_Unecc
5008  0ad2 2e04          	jrsge	L1632
5011  0ad4 5f            	clrw	x
5012  0ad5 cf0012        	ldw	_Unecc,x
5013  0ad8               L1632:
5014                     ; 1099 temp_SL=(signed long)(T-ee_tsign);
5016  0ad8 5f            	clrw	x
5017  0ad9 b672          	ld	a,_T
5018  0adb 2a01          	jrpl	L67
5019  0add 53            	cplw	x
5020  0ade               L67:
5021  0ade 97            	ld	xl,a
5022  0adf 72b0000e      	subw	x,_ee_tsign
5023  0ae3 cd0000        	call	c_itolx
5025  0ae6 96            	ldw	x,sp
5026  0ae7 1c0005        	addw	x,#OFST-3
5027  0aea cd0000        	call	c_rtol
5029                     ; 1100 temp_SL*=1000L;
5031  0aed ae03e8        	ldw	x,#1000
5032  0af0 bf02          	ldw	c_lreg+2,x
5033  0af2 ae0000        	ldw	x,#0
5034  0af5 bf00          	ldw	c_lreg,x
5035  0af7 96            	ldw	x,sp
5036  0af8 1c0005        	addw	x,#OFST-3
5037  0afb cd0000        	call	c_lgmul
5039                     ; 1101 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5041  0afe ce0010        	ldw	x,_ee_tmax
5042  0b01 72b0000e      	subw	x,_ee_tsign
5043  0b05 cd0000        	call	c_itolx
5045  0b08 96            	ldw	x,sp
5046  0b09 1c0001        	addw	x,#OFST-7
5047  0b0c cd0000        	call	c_rtol
5049  0b0f 96            	ldw	x,sp
5050  0b10 1c0005        	addw	x,#OFST-3
5051  0b13 cd0000        	call	c_ltor
5053  0b16 96            	ldw	x,sp
5054  0b17 1c0001        	addw	x,#OFST-7
5055  0b1a cd0000        	call	c_ldiv
5057  0b1d 96            	ldw	x,sp
5058  0b1e 1c0005        	addw	x,#OFST-3
5059  0b21 cd0000        	call	c_rtol
5061                     ; 1103 vol_i_temp_avar=(unsigned short)temp_SL; 
5063  0b24 1e07          	ldw	x,(OFST-1,sp)
5064  0b26 bf06          	ldw	_vol_i_temp_avar,x
5065                     ; 1105 debug_info_to_uku[0]=pwm_u;
5067  0b28 be08          	ldw	x,_pwm_u
5068  0b2a bf01          	ldw	_debug_info_to_uku,x
5069                     ; 1106 debug_info_to_uku[1]=Unecc;
5071  0b2c ce0012        	ldw	x,_Unecc
5072  0b2f bf03          	ldw	_debug_info_to_uku+2,x
5073                     ; 1108 }
5076  0b31 5b08          	addw	sp,#8
5077  0b33 81            	ret
5108                     ; 1111 void temper_drv(void)		//1 Hz
5108                     ; 1112 {
5109                     	switch	.text
5110  0b34               _temper_drv:
5114                     ; 1114 if(T>ee_tsign) tsign_cnt++;
5116  0b34 9c            	rvf
5117  0b35 5f            	clrw	x
5118  0b36 b672          	ld	a,_T
5119  0b38 2a01          	jrpl	L201
5120  0b3a 53            	cplw	x
5121  0b3b               L201:
5122  0b3b 97            	ld	xl,a
5123  0b3c c3000e        	cpw	x,_ee_tsign
5124  0b3f 2d09          	jrsle	L3732
5127  0b41 be59          	ldw	x,_tsign_cnt
5128  0b43 1c0001        	addw	x,#1
5129  0b46 bf59          	ldw	_tsign_cnt,x
5131  0b48 201d          	jra	L5732
5132  0b4a               L3732:
5133                     ; 1115 else if (T<(ee_tsign-1)) tsign_cnt--;
5135  0b4a 9c            	rvf
5136  0b4b ce000e        	ldw	x,_ee_tsign
5137  0b4e 5a            	decw	x
5138  0b4f 905f          	clrw	y
5139  0b51 b672          	ld	a,_T
5140  0b53 2a02          	jrpl	L401
5141  0b55 9053          	cplw	y
5142  0b57               L401:
5143  0b57 9097          	ld	yl,a
5144  0b59 90bf00        	ldw	c_y,y
5145  0b5c b300          	cpw	x,c_y
5146  0b5e 2d07          	jrsle	L5732
5149  0b60 be59          	ldw	x,_tsign_cnt
5150  0b62 1d0001        	subw	x,#1
5151  0b65 bf59          	ldw	_tsign_cnt,x
5152  0b67               L5732:
5153                     ; 1117 gran(&tsign_cnt,0,60);
5155  0b67 ae003c        	ldw	x,#60
5156  0b6a 89            	pushw	x
5157  0b6b 5f            	clrw	x
5158  0b6c 89            	pushw	x
5159  0b6d ae0059        	ldw	x,#_tsign_cnt
5160  0b70 cd00d5        	call	_gran
5162  0b73 5b04          	addw	sp,#4
5163                     ; 1119 if(tsign_cnt>=55)
5165  0b75 9c            	rvf
5166  0b76 be59          	ldw	x,_tsign_cnt
5167  0b78 a30037        	cpw	x,#55
5168  0b7b 2f16          	jrslt	L1042
5169                     ; 1121 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5171  0b7d 3d54          	tnz	_jp_mode
5172  0b7f 2606          	jrne	L7042
5174  0b81 b605          	ld	a,_flags
5175  0b83 a540          	bcp	a,#64
5176  0b85 2706          	jreq	L5042
5177  0b87               L7042:
5179  0b87 b654          	ld	a,_jp_mode
5180  0b89 a103          	cp	a,#3
5181  0b8b 2612          	jrne	L1142
5182  0b8d               L5042:
5185  0b8d 72140005      	bset	_flags,#2
5186  0b91 200c          	jra	L1142
5187  0b93               L1042:
5188                     ; 1123 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5190  0b93 9c            	rvf
5191  0b94 be59          	ldw	x,_tsign_cnt
5192  0b96 a30006        	cpw	x,#6
5193  0b99 2e04          	jrsge	L1142
5196  0b9b 72150005      	bres	_flags,#2
5197  0b9f               L1142:
5198                     ; 1128 if(T>ee_tmax) tmax_cnt++;
5200  0b9f 9c            	rvf
5201  0ba0 5f            	clrw	x
5202  0ba1 b672          	ld	a,_T
5203  0ba3 2a01          	jrpl	L601
5204  0ba5 53            	cplw	x
5205  0ba6               L601:
5206  0ba6 97            	ld	xl,a
5207  0ba7 c30010        	cpw	x,_ee_tmax
5208  0baa 2d09          	jrsle	L5142
5211  0bac be57          	ldw	x,_tmax_cnt
5212  0bae 1c0001        	addw	x,#1
5213  0bb1 bf57          	ldw	_tmax_cnt,x
5215  0bb3 201d          	jra	L7142
5216  0bb5               L5142:
5217                     ; 1129 else if (T<(ee_tmax-1)) tmax_cnt--;
5219  0bb5 9c            	rvf
5220  0bb6 ce0010        	ldw	x,_ee_tmax
5221  0bb9 5a            	decw	x
5222  0bba 905f          	clrw	y
5223  0bbc b672          	ld	a,_T
5224  0bbe 2a02          	jrpl	L011
5225  0bc0 9053          	cplw	y
5226  0bc2               L011:
5227  0bc2 9097          	ld	yl,a
5228  0bc4 90bf00        	ldw	c_y,y
5229  0bc7 b300          	cpw	x,c_y
5230  0bc9 2d07          	jrsle	L7142
5233  0bcb be57          	ldw	x,_tmax_cnt
5234  0bcd 1d0001        	subw	x,#1
5235  0bd0 bf57          	ldw	_tmax_cnt,x
5236  0bd2               L7142:
5237                     ; 1131 gran(&tmax_cnt,0,60);
5239  0bd2 ae003c        	ldw	x,#60
5240  0bd5 89            	pushw	x
5241  0bd6 5f            	clrw	x
5242  0bd7 89            	pushw	x
5243  0bd8 ae0057        	ldw	x,#_tmax_cnt
5244  0bdb cd00d5        	call	_gran
5246  0bde 5b04          	addw	sp,#4
5247                     ; 1133 if(tmax_cnt>=55)
5249  0be0 9c            	rvf
5250  0be1 be57          	ldw	x,_tmax_cnt
5251  0be3 a30037        	cpw	x,#55
5252  0be6 2f16          	jrslt	L3242
5253                     ; 1135 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5255  0be8 3d54          	tnz	_jp_mode
5256  0bea 2606          	jrne	L1342
5258  0bec b605          	ld	a,_flags
5259  0bee a540          	bcp	a,#64
5260  0bf0 2706          	jreq	L7242
5261  0bf2               L1342:
5263  0bf2 b654          	ld	a,_jp_mode
5264  0bf4 a103          	cp	a,#3
5265  0bf6 2612          	jrne	L3342
5266  0bf8               L7242:
5269  0bf8 72120005      	bset	_flags,#1
5270  0bfc 200c          	jra	L3342
5271  0bfe               L3242:
5272                     ; 1137 else if (tmax_cnt<=5) flags&=0b11111101;
5274  0bfe 9c            	rvf
5275  0bff be57          	ldw	x,_tmax_cnt
5276  0c01 a30006        	cpw	x,#6
5277  0c04 2e04          	jrsge	L3342
5280  0c06 72130005      	bres	_flags,#1
5281  0c0a               L3342:
5282                     ; 1140 } 
5285  0c0a 81            	ret
5317                     ; 1143 void u_drv(void)		//1Hz
5317                     ; 1144 { 
5318                     	switch	.text
5319  0c0b               _u_drv:
5323                     ; 1145 if(jp_mode!=jp3)
5325  0c0b b654          	ld	a,_jp_mode
5326  0c0d a103          	cp	a,#3
5327  0c0f 2774          	jreq	L7442
5328                     ; 1147 	if(Ui>ee_Umax)umax_cnt++;
5330  0c11 9c            	rvf
5331  0c12 ce0014        	ldw	x,_Ui
5332  0c15 c30014        	cpw	x,_ee_Umax
5333  0c18 2d09          	jrsle	L1542
5336  0c1a be70          	ldw	x,_umax_cnt
5337  0c1c 1c0001        	addw	x,#1
5338  0c1f bf70          	ldw	_umax_cnt,x
5340  0c21 2003          	jra	L3542
5341  0c23               L1542:
5342                     ; 1148 	else umax_cnt=0;
5344  0c23 5f            	clrw	x
5345  0c24 bf70          	ldw	_umax_cnt,x
5346  0c26               L3542:
5347                     ; 1149 	gran(&umax_cnt,0,10);
5349  0c26 ae000a        	ldw	x,#10
5350  0c29 89            	pushw	x
5351  0c2a 5f            	clrw	x
5352  0c2b 89            	pushw	x
5353  0c2c ae0070        	ldw	x,#_umax_cnt
5354  0c2f cd00d5        	call	_gran
5356  0c32 5b04          	addw	sp,#4
5357                     ; 1150 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5359  0c34 9c            	rvf
5360  0c35 be70          	ldw	x,_umax_cnt
5361  0c37 a3000a        	cpw	x,#10
5362  0c3a 2f04          	jrslt	L5542
5365  0c3c 72160005      	bset	_flags,#3
5366  0c40               L5542:
5367                     ; 1153 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5369  0c40 9c            	rvf
5370  0c41 ce0014        	ldw	x,_Ui
5371  0c44 c30016        	cpw	x,_Un
5372  0c47 2e1d          	jrsge	L7542
5374  0c49 9c            	rvf
5375  0c4a ce0016        	ldw	x,_Un
5376  0c4d 72b00014      	subw	x,_Ui
5377  0c51 c30012        	cpw	x,_ee_dU
5378  0c54 2d10          	jrsle	L7542
5380  0c56 c65005        	ld	a,20485
5381  0c59 a504          	bcp	a,#4
5382  0c5b 2609          	jrne	L7542
5385  0c5d be6e          	ldw	x,_umin_cnt
5386  0c5f 1c0001        	addw	x,#1
5387  0c62 bf6e          	ldw	_umin_cnt,x
5389  0c64 2003          	jra	L1642
5390  0c66               L7542:
5391                     ; 1154 	else umin_cnt=0;
5393  0c66 5f            	clrw	x
5394  0c67 bf6e          	ldw	_umin_cnt,x
5395  0c69               L1642:
5396                     ; 1155 	gran(&umin_cnt,0,10);	
5398  0c69 ae000a        	ldw	x,#10
5399  0c6c 89            	pushw	x
5400  0c6d 5f            	clrw	x
5401  0c6e 89            	pushw	x
5402  0c6f ae006e        	ldw	x,#_umin_cnt
5403  0c72 cd00d5        	call	_gran
5405  0c75 5b04          	addw	sp,#4
5406                     ; 1156 	if(umin_cnt>=10)flags|=0b00010000;	  
5408  0c77 9c            	rvf
5409  0c78 be6e          	ldw	x,_umin_cnt
5410  0c7a a3000a        	cpw	x,#10
5411  0c7d 2f71          	jrslt	L5642
5414  0c7f 72180005      	bset	_flags,#4
5415  0c83 206b          	jra	L5642
5416  0c85               L7442:
5417                     ; 1158 else if(jp_mode==jp3)
5419  0c85 b654          	ld	a,_jp_mode
5420  0c87 a103          	cp	a,#3
5421  0c89 2665          	jrne	L5642
5422                     ; 1160 	if(Ui>700)umax_cnt++;
5424  0c8b 9c            	rvf
5425  0c8c ce0014        	ldw	x,_Ui
5426  0c8f a302bd        	cpw	x,#701
5427  0c92 2f09          	jrslt	L1742
5430  0c94 be70          	ldw	x,_umax_cnt
5431  0c96 1c0001        	addw	x,#1
5432  0c99 bf70          	ldw	_umax_cnt,x
5434  0c9b 2003          	jra	L3742
5435  0c9d               L1742:
5436                     ; 1161 	else umax_cnt=0;
5438  0c9d 5f            	clrw	x
5439  0c9e bf70          	ldw	_umax_cnt,x
5440  0ca0               L3742:
5441                     ; 1162 	gran(&umax_cnt,0,10);
5443  0ca0 ae000a        	ldw	x,#10
5444  0ca3 89            	pushw	x
5445  0ca4 5f            	clrw	x
5446  0ca5 89            	pushw	x
5447  0ca6 ae0070        	ldw	x,#_umax_cnt
5448  0ca9 cd00d5        	call	_gran
5450  0cac 5b04          	addw	sp,#4
5451                     ; 1163 	if(umax_cnt>=10)flags|=0b00001000;
5453  0cae 9c            	rvf
5454  0caf be70          	ldw	x,_umax_cnt
5455  0cb1 a3000a        	cpw	x,#10
5456  0cb4 2f04          	jrslt	L5742
5459  0cb6 72160005      	bset	_flags,#3
5460  0cba               L5742:
5461                     ; 1166 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5463  0cba 9c            	rvf
5464  0cbb ce0014        	ldw	x,_Ui
5465  0cbe a300c8        	cpw	x,#200
5466  0cc1 2e10          	jrsge	L7742
5468  0cc3 c65005        	ld	a,20485
5469  0cc6 a504          	bcp	a,#4
5470  0cc8 2609          	jrne	L7742
5473  0cca be6e          	ldw	x,_umin_cnt
5474  0ccc 1c0001        	addw	x,#1
5475  0ccf bf6e          	ldw	_umin_cnt,x
5477  0cd1 2003          	jra	L1052
5478  0cd3               L7742:
5479                     ; 1167 	else umin_cnt=0;
5481  0cd3 5f            	clrw	x
5482  0cd4 bf6e          	ldw	_umin_cnt,x
5483  0cd6               L1052:
5484                     ; 1168 	gran(&umin_cnt,0,10);	
5486  0cd6 ae000a        	ldw	x,#10
5487  0cd9 89            	pushw	x
5488  0cda 5f            	clrw	x
5489  0cdb 89            	pushw	x
5490  0cdc ae006e        	ldw	x,#_umin_cnt
5491  0cdf cd00d5        	call	_gran
5493  0ce2 5b04          	addw	sp,#4
5494                     ; 1169 	if(umin_cnt>=10)flags|=0b00010000;	  
5496  0ce4 9c            	rvf
5497  0ce5 be6e          	ldw	x,_umin_cnt
5498  0ce7 a3000a        	cpw	x,#10
5499  0cea 2f04          	jrslt	L5642
5502  0cec 72180005      	bset	_flags,#4
5503  0cf0               L5642:
5504                     ; 1171 }
5507  0cf0 81            	ret
5533                     ; 1196 void apv_start(void)
5533                     ; 1197 {
5534                     	switch	.text
5535  0cf1               _apv_start:
5539                     ; 1198 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5541  0cf1 3d4f          	tnz	_apv_cnt
5542  0cf3 2624          	jrne	L5152
5544  0cf5 3d50          	tnz	_apv_cnt+1
5545  0cf7 2620          	jrne	L5152
5547  0cf9 3d51          	tnz	_apv_cnt+2
5548  0cfb 261c          	jrne	L5152
5550                     	btst	_bAPV
5551  0d02 2515          	jrult	L5152
5552                     ; 1200 	apv_cnt[0]=60;
5554  0d04 353c004f      	mov	_apv_cnt,#60
5555                     ; 1201 	apv_cnt[1]=60;
5557  0d08 353c0050      	mov	_apv_cnt+1,#60
5558                     ; 1202 	apv_cnt[2]=60;
5560  0d0c 353c0051      	mov	_apv_cnt+2,#60
5561                     ; 1203 	apv_cnt_=3600;
5563  0d10 ae0e10        	ldw	x,#3600
5564  0d13 bf4d          	ldw	_apv_cnt_,x
5565                     ; 1204 	bAPV=1;	
5567  0d15 72100002      	bset	_bAPV
5568  0d19               L5152:
5569                     ; 1206 }
5572  0d19 81            	ret
5598                     ; 1209 void apv_stop(void)
5598                     ; 1210 {
5599                     	switch	.text
5600  0d1a               _apv_stop:
5604                     ; 1211 apv_cnt[0]=0;
5606  0d1a 3f4f          	clr	_apv_cnt
5607                     ; 1212 apv_cnt[1]=0;
5609  0d1c 3f50          	clr	_apv_cnt+1
5610                     ; 1213 apv_cnt[2]=0;
5612  0d1e 3f51          	clr	_apv_cnt+2
5613                     ; 1214 apv_cnt_=0;	
5615  0d20 5f            	clrw	x
5616  0d21 bf4d          	ldw	_apv_cnt_,x
5617                     ; 1215 bAPV=0;
5619  0d23 72110002      	bres	_bAPV
5620                     ; 1216 }
5623  0d27 81            	ret
5658                     ; 1220 void apv_hndl(void)
5658                     ; 1221 {
5659                     	switch	.text
5660  0d28               _apv_hndl:
5664                     ; 1222 if(apv_cnt[0])
5666  0d28 3d4f          	tnz	_apv_cnt
5667  0d2a 271e          	jreq	L7352
5668                     ; 1224 	apv_cnt[0]--;
5670  0d2c 3a4f          	dec	_apv_cnt
5671                     ; 1225 	if(apv_cnt[0]==0)
5673  0d2e 3d4f          	tnz	_apv_cnt
5674  0d30 265a          	jrne	L3452
5675                     ; 1227 		flags&=0b11100001;
5677  0d32 b605          	ld	a,_flags
5678  0d34 a4e1          	and	a,#225
5679  0d36 b705          	ld	_flags,a
5680                     ; 1228 		tsign_cnt=0;
5682  0d38 5f            	clrw	x
5683  0d39 bf59          	ldw	_tsign_cnt,x
5684                     ; 1229 		tmax_cnt=0;
5686  0d3b 5f            	clrw	x
5687  0d3c bf57          	ldw	_tmax_cnt,x
5688                     ; 1230 		umax_cnt=0;
5690  0d3e 5f            	clrw	x
5691  0d3f bf70          	ldw	_umax_cnt,x
5692                     ; 1231 		umin_cnt=0;
5694  0d41 5f            	clrw	x
5695  0d42 bf6e          	ldw	_umin_cnt,x
5696                     ; 1233 		led_drv_cnt=30;
5698  0d44 351e0016      	mov	_led_drv_cnt,#30
5699  0d48 2042          	jra	L3452
5700  0d4a               L7352:
5701                     ; 1236 else if(apv_cnt[1])
5703  0d4a 3d50          	tnz	_apv_cnt+1
5704  0d4c 271e          	jreq	L5452
5705                     ; 1238 	apv_cnt[1]--;
5707  0d4e 3a50          	dec	_apv_cnt+1
5708                     ; 1239 	if(apv_cnt[1]==0)
5710  0d50 3d50          	tnz	_apv_cnt+1
5711  0d52 2638          	jrne	L3452
5712                     ; 1241 		flags&=0b11100001;
5714  0d54 b605          	ld	a,_flags
5715  0d56 a4e1          	and	a,#225
5716  0d58 b705          	ld	_flags,a
5717                     ; 1242 		tsign_cnt=0;
5719  0d5a 5f            	clrw	x
5720  0d5b bf59          	ldw	_tsign_cnt,x
5721                     ; 1243 		tmax_cnt=0;
5723  0d5d 5f            	clrw	x
5724  0d5e bf57          	ldw	_tmax_cnt,x
5725                     ; 1244 		umax_cnt=0;
5727  0d60 5f            	clrw	x
5728  0d61 bf70          	ldw	_umax_cnt,x
5729                     ; 1245 		umin_cnt=0;
5731  0d63 5f            	clrw	x
5732  0d64 bf6e          	ldw	_umin_cnt,x
5733                     ; 1247 		led_drv_cnt=30;
5735  0d66 351e0016      	mov	_led_drv_cnt,#30
5736  0d6a 2020          	jra	L3452
5737  0d6c               L5452:
5738                     ; 1250 else if(apv_cnt[2])
5740  0d6c 3d51          	tnz	_apv_cnt+2
5741  0d6e 271c          	jreq	L3452
5742                     ; 1252 	apv_cnt[2]--;
5744  0d70 3a51          	dec	_apv_cnt+2
5745                     ; 1253 	if(apv_cnt[2]==0)
5747  0d72 3d51          	tnz	_apv_cnt+2
5748  0d74 2616          	jrne	L3452
5749                     ; 1255 		flags&=0b11100001;
5751  0d76 b605          	ld	a,_flags
5752  0d78 a4e1          	and	a,#225
5753  0d7a b705          	ld	_flags,a
5754                     ; 1256 		tsign_cnt=0;
5756  0d7c 5f            	clrw	x
5757  0d7d bf59          	ldw	_tsign_cnt,x
5758                     ; 1257 		tmax_cnt=0;
5760  0d7f 5f            	clrw	x
5761  0d80 bf57          	ldw	_tmax_cnt,x
5762                     ; 1258 		umax_cnt=0;
5764  0d82 5f            	clrw	x
5765  0d83 bf70          	ldw	_umax_cnt,x
5766                     ; 1259 		umin_cnt=0;          
5768  0d85 5f            	clrw	x
5769  0d86 bf6e          	ldw	_umin_cnt,x
5770                     ; 1261 		led_drv_cnt=30;
5772  0d88 351e0016      	mov	_led_drv_cnt,#30
5773  0d8c               L3452:
5774                     ; 1265 if(apv_cnt_)
5776  0d8c be4d          	ldw	x,_apv_cnt_
5777  0d8e 2712          	jreq	L7552
5778                     ; 1267 	apv_cnt_--;
5780  0d90 be4d          	ldw	x,_apv_cnt_
5781  0d92 1d0001        	subw	x,#1
5782  0d95 bf4d          	ldw	_apv_cnt_,x
5783                     ; 1268 	if(apv_cnt_==0) 
5785  0d97 be4d          	ldw	x,_apv_cnt_
5786  0d99 2607          	jrne	L7552
5787                     ; 1270 		bAPV=0;
5789  0d9b 72110002      	bres	_bAPV
5790                     ; 1271 		apv_start();
5792  0d9f cd0cf1        	call	_apv_start
5794  0da2               L7552:
5795                     ; 1275 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5797  0da2 be6e          	ldw	x,_umin_cnt
5798  0da4 261e          	jrne	L3652
5800  0da6 be70          	ldw	x,_umax_cnt
5801  0da8 261a          	jrne	L3652
5803  0daa c65005        	ld	a,20485
5804  0dad a504          	bcp	a,#4
5805  0daf 2613          	jrne	L3652
5806                     ; 1277 	if(cnt_apv_off<20)
5808  0db1 b64c          	ld	a,_cnt_apv_off
5809  0db3 a114          	cp	a,#20
5810  0db5 240f          	jruge	L1752
5811                     ; 1279 		cnt_apv_off++;
5813  0db7 3c4c          	inc	_cnt_apv_off
5814                     ; 1280 		if(cnt_apv_off>=20)
5816  0db9 b64c          	ld	a,_cnt_apv_off
5817  0dbb a114          	cp	a,#20
5818  0dbd 2507          	jrult	L1752
5819                     ; 1282 			apv_stop();
5821  0dbf cd0d1a        	call	_apv_stop
5823  0dc2 2002          	jra	L1752
5824  0dc4               L3652:
5825                     ; 1286 else cnt_apv_off=0;	
5827  0dc4 3f4c          	clr	_cnt_apv_off
5828  0dc6               L1752:
5829                     ; 1288 }
5832  0dc6 81            	ret
5835                     	switch	.ubsct
5836  0000               L3752_flags_old:
5837  0000 00            	ds.b	1
5873                     ; 1291 void flags_drv(void)
5873                     ; 1292 {
5874                     	switch	.text
5875  0dc7               _flags_drv:
5879                     ; 1294 if(jp_mode!=jp3) 
5881  0dc7 b654          	ld	a,_jp_mode
5882  0dc9 a103          	cp	a,#3
5883  0dcb 2723          	jreq	L3162
5884                     ; 1296 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5886  0dcd b605          	ld	a,_flags
5887  0dcf a508          	bcp	a,#8
5888  0dd1 2706          	jreq	L1262
5890  0dd3 b600          	ld	a,L3752_flags_old
5891  0dd5 a508          	bcp	a,#8
5892  0dd7 270c          	jreq	L7162
5893  0dd9               L1262:
5895  0dd9 b605          	ld	a,_flags
5896  0ddb a510          	bcp	a,#16
5897  0ddd 2726          	jreq	L5262
5899  0ddf b600          	ld	a,L3752_flags_old
5900  0de1 a510          	bcp	a,#16
5901  0de3 2620          	jrne	L5262
5902  0de5               L7162:
5903                     ; 1298     		if(link==OFF)apv_start();
5905  0de5 b66d          	ld	a,_link
5906  0de7 a1aa          	cp	a,#170
5907  0de9 261a          	jrne	L5262
5910  0deb cd0cf1        	call	_apv_start
5912  0dee 2015          	jra	L5262
5913  0df0               L3162:
5914                     ; 1301 else if(jp_mode==jp3) 
5916  0df0 b654          	ld	a,_jp_mode
5917  0df2 a103          	cp	a,#3
5918  0df4 260f          	jrne	L5262
5919                     ; 1303 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5921  0df6 b605          	ld	a,_flags
5922  0df8 a508          	bcp	a,#8
5923  0dfa 2709          	jreq	L5262
5925  0dfc b600          	ld	a,L3752_flags_old
5926  0dfe a508          	bcp	a,#8
5927  0e00 2603          	jrne	L5262
5928                     ; 1305     		apv_start();
5930  0e02 cd0cf1        	call	_apv_start
5932  0e05               L5262:
5933                     ; 1308 flags_old=flags;
5935  0e05 450500        	mov	L3752_flags_old,_flags
5936                     ; 1310 } 
5939  0e08 81            	ret
5974                     ; 1447 void adr_drv_v4(char in)
5974                     ; 1448 {
5975                     	switch	.text
5976  0e09               _adr_drv_v4:
5980                     ; 1449 if(adress!=in)adress=in;
5982  0e09 c100ff        	cp	a,_adress
5983  0e0c 2703          	jreq	L1562
5986  0e0e c700ff        	ld	_adress,a
5987  0e11               L1562:
5988                     ; 1450 }
5991  0e11 81            	ret
6020                     ; 1453 void adr_drv_v3(void)
6020                     ; 1454 {
6021                     	switch	.text
6022  0e12               _adr_drv_v3:
6024  0e12 88            	push	a
6025       00000001      OFST:	set	1
6028                     ; 1460 GPIOB->DDR&=~(1<<0);
6030  0e13 72115007      	bres	20487,#0
6031                     ; 1461 GPIOB->CR1&=~(1<<0);
6033  0e17 72115008      	bres	20488,#0
6034                     ; 1462 GPIOB->CR2&=~(1<<0);
6036  0e1b 72115009      	bres	20489,#0
6037                     ; 1463 ADC2->CR2=0x08;
6039  0e1f 35085402      	mov	21506,#8
6040                     ; 1464 ADC2->CR1=0x40;
6042  0e23 35405401      	mov	21505,#64
6043                     ; 1465 ADC2->CSR=0x20+0;
6045  0e27 35205400      	mov	21504,#32
6046                     ; 1466 ADC2->CR1|=1;
6048  0e2b 72105401      	bset	21505,#0
6049                     ; 1467 ADC2->CR1|=1;
6051  0e2f 72105401      	bset	21505,#0
6052                     ; 1468 adr_drv_stat=1;
6054  0e33 35010002      	mov	_adr_drv_stat,#1
6055  0e37               L3662:
6056                     ; 1469 while(adr_drv_stat==1);
6059  0e37 b602          	ld	a,_adr_drv_stat
6060  0e39 a101          	cp	a,#1
6061  0e3b 27fa          	jreq	L3662
6062                     ; 1471 GPIOB->DDR&=~(1<<1);
6064  0e3d 72135007      	bres	20487,#1
6065                     ; 1472 GPIOB->CR1&=~(1<<1);
6067  0e41 72135008      	bres	20488,#1
6068                     ; 1473 GPIOB->CR2&=~(1<<1);
6070  0e45 72135009      	bres	20489,#1
6071                     ; 1474 ADC2->CR2=0x08;
6073  0e49 35085402      	mov	21506,#8
6074                     ; 1475 ADC2->CR1=0x40;
6076  0e4d 35405401      	mov	21505,#64
6077                     ; 1476 ADC2->CSR=0x20+1;
6079  0e51 35215400      	mov	21504,#33
6080                     ; 1477 ADC2->CR1|=1;
6082  0e55 72105401      	bset	21505,#0
6083                     ; 1478 ADC2->CR1|=1;
6085  0e59 72105401      	bset	21505,#0
6086                     ; 1479 adr_drv_stat=3;
6088  0e5d 35030002      	mov	_adr_drv_stat,#3
6089  0e61               L1762:
6090                     ; 1480 while(adr_drv_stat==3);
6093  0e61 b602          	ld	a,_adr_drv_stat
6094  0e63 a103          	cp	a,#3
6095  0e65 27fa          	jreq	L1762
6096                     ; 1482 GPIOE->DDR&=~(1<<6);
6098  0e67 721d5016      	bres	20502,#6
6099                     ; 1483 GPIOE->CR1&=~(1<<6);
6101  0e6b 721d5017      	bres	20503,#6
6102                     ; 1484 GPIOE->CR2&=~(1<<6);
6104  0e6f 721d5018      	bres	20504,#6
6105                     ; 1485 ADC2->CR2=0x08;
6107  0e73 35085402      	mov	21506,#8
6108                     ; 1486 ADC2->CR1=0x40;
6110  0e77 35405401      	mov	21505,#64
6111                     ; 1487 ADC2->CSR=0x20+9;
6113  0e7b 35295400      	mov	21504,#41
6114                     ; 1488 ADC2->CR1|=1;
6116  0e7f 72105401      	bset	21505,#0
6117                     ; 1489 ADC2->CR1|=1;
6119  0e83 72105401      	bset	21505,#0
6120                     ; 1490 adr_drv_stat=5;
6122  0e87 35050002      	mov	_adr_drv_stat,#5
6123  0e8b               L7762:
6124                     ; 1491 while(adr_drv_stat==5);
6127  0e8b b602          	ld	a,_adr_drv_stat
6128  0e8d a105          	cp	a,#5
6129  0e8f 27fa          	jreq	L7762
6130                     ; 1495 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6132  0e91 9c            	rvf
6133  0e92 ce0107        	ldw	x,_adc_buff_
6134  0e95 a3022a        	cpw	x,#554
6135  0e98 2f0f          	jrslt	L5072
6137  0e9a 9c            	rvf
6138  0e9b ce0107        	ldw	x,_adc_buff_
6139  0e9e a30253        	cpw	x,#595
6140  0ea1 2e06          	jrsge	L5072
6143  0ea3 725f0100      	clr	_adr
6145  0ea7 204c          	jra	L7072
6146  0ea9               L5072:
6147                     ; 1496 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6149  0ea9 9c            	rvf
6150  0eaa ce0107        	ldw	x,_adc_buff_
6151  0ead a3036d        	cpw	x,#877
6152  0eb0 2f0f          	jrslt	L1172
6154  0eb2 9c            	rvf
6155  0eb3 ce0107        	ldw	x,_adc_buff_
6156  0eb6 a30396        	cpw	x,#918
6157  0eb9 2e06          	jrsge	L1172
6160  0ebb 35010100      	mov	_adr,#1
6162  0ebf 2034          	jra	L7072
6163  0ec1               L1172:
6164                     ; 1497 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6166  0ec1 9c            	rvf
6167  0ec2 ce0107        	ldw	x,_adc_buff_
6168  0ec5 a302a3        	cpw	x,#675
6169  0ec8 2f0f          	jrslt	L5172
6171  0eca 9c            	rvf
6172  0ecb ce0107        	ldw	x,_adc_buff_
6173  0ece a302cc        	cpw	x,#716
6174  0ed1 2e06          	jrsge	L5172
6177  0ed3 35020100      	mov	_adr,#2
6179  0ed7 201c          	jra	L7072
6180  0ed9               L5172:
6181                     ; 1498 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6183  0ed9 9c            	rvf
6184  0eda ce0107        	ldw	x,_adc_buff_
6185  0edd a303e3        	cpw	x,#995
6186  0ee0 2f0f          	jrslt	L1272
6188  0ee2 9c            	rvf
6189  0ee3 ce0107        	ldw	x,_adc_buff_
6190  0ee6 a3040c        	cpw	x,#1036
6191  0ee9 2e06          	jrsge	L1272
6194  0eeb 35030100      	mov	_adr,#3
6196  0eef 2004          	jra	L7072
6197  0ef1               L1272:
6198                     ; 1499 else adr[0]=5;
6200  0ef1 35050100      	mov	_adr,#5
6201  0ef5               L7072:
6202                     ; 1501 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6204  0ef5 9c            	rvf
6205  0ef6 ce0109        	ldw	x,_adc_buff_+2
6206  0ef9 a3022a        	cpw	x,#554
6207  0efc 2f0f          	jrslt	L5272
6209  0efe 9c            	rvf
6210  0eff ce0109        	ldw	x,_adc_buff_+2
6211  0f02 a30253        	cpw	x,#595
6212  0f05 2e06          	jrsge	L5272
6215  0f07 725f0101      	clr	_adr+1
6217  0f0b 204c          	jra	L7272
6218  0f0d               L5272:
6219                     ; 1502 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6221  0f0d 9c            	rvf
6222  0f0e ce0109        	ldw	x,_adc_buff_+2
6223  0f11 a3036d        	cpw	x,#877
6224  0f14 2f0f          	jrslt	L1372
6226  0f16 9c            	rvf
6227  0f17 ce0109        	ldw	x,_adc_buff_+2
6228  0f1a a30396        	cpw	x,#918
6229  0f1d 2e06          	jrsge	L1372
6232  0f1f 35010101      	mov	_adr+1,#1
6234  0f23 2034          	jra	L7272
6235  0f25               L1372:
6236                     ; 1503 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6238  0f25 9c            	rvf
6239  0f26 ce0109        	ldw	x,_adc_buff_+2
6240  0f29 a302a3        	cpw	x,#675
6241  0f2c 2f0f          	jrslt	L5372
6243  0f2e 9c            	rvf
6244  0f2f ce0109        	ldw	x,_adc_buff_+2
6245  0f32 a302cc        	cpw	x,#716
6246  0f35 2e06          	jrsge	L5372
6249  0f37 35020101      	mov	_adr+1,#2
6251  0f3b 201c          	jra	L7272
6252  0f3d               L5372:
6253                     ; 1504 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6255  0f3d 9c            	rvf
6256  0f3e ce0109        	ldw	x,_adc_buff_+2
6257  0f41 a303e3        	cpw	x,#995
6258  0f44 2f0f          	jrslt	L1472
6260  0f46 9c            	rvf
6261  0f47 ce0109        	ldw	x,_adc_buff_+2
6262  0f4a a3040c        	cpw	x,#1036
6263  0f4d 2e06          	jrsge	L1472
6266  0f4f 35030101      	mov	_adr+1,#3
6268  0f53 2004          	jra	L7272
6269  0f55               L1472:
6270                     ; 1505 else adr[1]=5;
6272  0f55 35050101      	mov	_adr+1,#5
6273  0f59               L7272:
6274                     ; 1507 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6276  0f59 9c            	rvf
6277  0f5a ce0119        	ldw	x,_adc_buff_+18
6278  0f5d a3022a        	cpw	x,#554
6279  0f60 2f0f          	jrslt	L5472
6281  0f62 9c            	rvf
6282  0f63 ce0119        	ldw	x,_adc_buff_+18
6283  0f66 a30253        	cpw	x,#595
6284  0f69 2e06          	jrsge	L5472
6287  0f6b 725f0102      	clr	_adr+2
6289  0f6f 204c          	jra	L7472
6290  0f71               L5472:
6291                     ; 1508 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6293  0f71 9c            	rvf
6294  0f72 ce0119        	ldw	x,_adc_buff_+18
6295  0f75 a3036d        	cpw	x,#877
6296  0f78 2f0f          	jrslt	L1572
6298  0f7a 9c            	rvf
6299  0f7b ce0119        	ldw	x,_adc_buff_+18
6300  0f7e a30396        	cpw	x,#918
6301  0f81 2e06          	jrsge	L1572
6304  0f83 35010102      	mov	_adr+2,#1
6306  0f87 2034          	jra	L7472
6307  0f89               L1572:
6308                     ; 1509 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6310  0f89 9c            	rvf
6311  0f8a ce0119        	ldw	x,_adc_buff_+18
6312  0f8d a302a3        	cpw	x,#675
6313  0f90 2f0f          	jrslt	L5572
6315  0f92 9c            	rvf
6316  0f93 ce0119        	ldw	x,_adc_buff_+18
6317  0f96 a302cc        	cpw	x,#716
6318  0f99 2e06          	jrsge	L5572
6321  0f9b 35020102      	mov	_adr+2,#2
6323  0f9f 201c          	jra	L7472
6324  0fa1               L5572:
6325                     ; 1510 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6327  0fa1 9c            	rvf
6328  0fa2 ce0119        	ldw	x,_adc_buff_+18
6329  0fa5 a303e3        	cpw	x,#995
6330  0fa8 2f0f          	jrslt	L1672
6332  0faa 9c            	rvf
6333  0fab ce0119        	ldw	x,_adc_buff_+18
6334  0fae a3040c        	cpw	x,#1036
6335  0fb1 2e06          	jrsge	L1672
6338  0fb3 35030102      	mov	_adr+2,#3
6340  0fb7 2004          	jra	L7472
6341  0fb9               L1672:
6342                     ; 1511 else adr[2]=5;
6344  0fb9 35050102      	mov	_adr+2,#5
6345  0fbd               L7472:
6346                     ; 1515 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6348  0fbd c60100        	ld	a,_adr
6349  0fc0 a105          	cp	a,#5
6350  0fc2 270e          	jreq	L7672
6352  0fc4 c60101        	ld	a,_adr+1
6353  0fc7 a105          	cp	a,#5
6354  0fc9 2707          	jreq	L7672
6356  0fcb c60102        	ld	a,_adr+2
6357  0fce a105          	cp	a,#5
6358  0fd0 2606          	jrne	L5672
6359  0fd2               L7672:
6360                     ; 1518 	adress_error=1;
6362  0fd2 350100fe      	mov	_adress_error,#1
6364  0fd6               L3772:
6365                     ; 1529 }
6368  0fd6 84            	pop	a
6369  0fd7 81            	ret
6370  0fd8               L5672:
6371                     ; 1522 	if(adr[2]&0x02) bps_class=bpsIPS;
6373  0fd8 c60102        	ld	a,_adr+2
6374  0fdb a502          	bcp	a,#2
6375  0fdd 2706          	jreq	L5772
6378  0fdf 3501000b      	mov	_bps_class,#1
6380  0fe3 2002          	jra	L7772
6381  0fe5               L5772:
6382                     ; 1523 	else bps_class=bpsIBEP;
6384  0fe5 3f0b          	clr	_bps_class
6385  0fe7               L7772:
6386                     ; 1525 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6388  0fe7 c60102        	ld	a,_adr+2
6389  0fea a401          	and	a,#1
6390  0fec 97            	ld	xl,a
6391  0fed a610          	ld	a,#16
6392  0fef 42            	mul	x,a
6393  0ff0 9f            	ld	a,xl
6394  0ff1 6b01          	ld	(OFST+0,sp),a
6395  0ff3 c60101        	ld	a,_adr+1
6396  0ff6 48            	sll	a
6397  0ff7 48            	sll	a
6398  0ff8 cb0100        	add	a,_adr
6399  0ffb 1b01          	add	a,(OFST+0,sp)
6400  0ffd c700ff        	ld	_adress,a
6401  1000 20d4          	jra	L3772
6424                     ; 1579 void init_CAN(void) {
6425                     	switch	.text
6426  1002               _init_CAN:
6430                     ; 1580 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6432  1002 72135420      	bres	21536,#1
6433                     ; 1581 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6435  1006 72105420      	bset	21536,#0
6437  100a               L3103:
6438                     ; 1582 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6440  100a c65421        	ld	a,21537
6441  100d a501          	bcp	a,#1
6442  100f 27f9          	jreq	L3103
6443                     ; 1584 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6445  1011 72185420      	bset	21536,#4
6446                     ; 1586 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6448  1015 35025427      	mov	21543,#2
6449                     ; 1595 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6451  1019 35135428      	mov	21544,#19
6452                     ; 1596 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6454  101d 35c05429      	mov	21545,#192
6455                     ; 1597 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6457  1021 357f542c      	mov	21548,#127
6458                     ; 1598 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6460  1025 35e0542d      	mov	21549,#224
6461                     ; 1600 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6463  1029 35315430      	mov	21552,#49
6464                     ; 1601 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6466  102d 35c05431      	mov	21553,#192
6467                     ; 1602 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6469  1031 357f5434      	mov	21556,#127
6470                     ; 1603 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6472  1035 35e05435      	mov	21557,#224
6473                     ; 1607 	CAN->PSR= 6;									// set page 6
6475  1039 35065427      	mov	21543,#6
6476                     ; 1612 	CAN->Page.Config.FMR1&=~3;								//mask mode
6478  103d c65430        	ld	a,21552
6479  1040 a4fc          	and	a,#252
6480  1042 c75430        	ld	21552,a
6481                     ; 1618 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6483  1045 35065432      	mov	21554,#6
6484                     ; 1619 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6486  1049 35605432      	mov	21554,#96
6487                     ; 1622 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6489  104d 72105432      	bset	21554,#0
6490                     ; 1623 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6492  1051 72185432      	bset	21554,#4
6493                     ; 1626 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6495  1055 35065427      	mov	21543,#6
6496                     ; 1628 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6498  1059 35d3542c      	mov	21548,#211
6499                     ; 1629 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6501  105d 35e7542d      	mov	21549,#231
6502                     ; 1631 	CAN->IER|=(1<<1);
6504  1061 72125425      	bset	21541,#1
6505                     ; 1634 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6507  1065 72115420      	bres	21536,#0
6509  1069               L1203:
6510                     ; 1635 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6512  1069 c65421        	ld	a,21537
6513  106c a501          	bcp	a,#1
6514  106e 26f9          	jrne	L1203
6515                     ; 1636 }
6518  1070 81            	ret
6626                     ; 1639 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6626                     ; 1640 {
6627                     	switch	.text
6628  1071               _can_transmit:
6630  1071 89            	pushw	x
6631       00000000      OFST:	set	0
6634                     ; 1642 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6636  1072 b676          	ld	a,_can_buff_wr_ptr
6637  1074 a104          	cp	a,#4
6638  1076 2502          	jrult	L3013
6641  1078 3f76          	clr	_can_buff_wr_ptr
6642  107a               L3013:
6643                     ; 1644 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6645  107a b676          	ld	a,_can_buff_wr_ptr
6646  107c 97            	ld	xl,a
6647  107d a610          	ld	a,#16
6648  107f 42            	mul	x,a
6649  1080 1601          	ldw	y,(OFST+1,sp)
6650  1082 a606          	ld	a,#6
6651  1084               L431:
6652  1084 9054          	srlw	y
6653  1086 4a            	dec	a
6654  1087 26fb          	jrne	L431
6655  1089 909f          	ld	a,yl
6656  108b e777          	ld	(_can_out_buff,x),a
6657                     ; 1645 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6659  108d b676          	ld	a,_can_buff_wr_ptr
6660  108f 97            	ld	xl,a
6661  1090 a610          	ld	a,#16
6662  1092 42            	mul	x,a
6663  1093 7b02          	ld	a,(OFST+2,sp)
6664  1095 48            	sll	a
6665  1096 48            	sll	a
6666  1097 e778          	ld	(_can_out_buff+1,x),a
6667                     ; 1647 can_out_buff[can_buff_wr_ptr][2]=data0;
6669  1099 b676          	ld	a,_can_buff_wr_ptr
6670  109b 97            	ld	xl,a
6671  109c a610          	ld	a,#16
6672  109e 42            	mul	x,a
6673  109f 7b05          	ld	a,(OFST+5,sp)
6674  10a1 e779          	ld	(_can_out_buff+2,x),a
6675                     ; 1648 can_out_buff[can_buff_wr_ptr][3]=data1;
6677  10a3 b676          	ld	a,_can_buff_wr_ptr
6678  10a5 97            	ld	xl,a
6679  10a6 a610          	ld	a,#16
6680  10a8 42            	mul	x,a
6681  10a9 7b06          	ld	a,(OFST+6,sp)
6682  10ab e77a          	ld	(_can_out_buff+3,x),a
6683                     ; 1649 can_out_buff[can_buff_wr_ptr][4]=data2;
6685  10ad b676          	ld	a,_can_buff_wr_ptr
6686  10af 97            	ld	xl,a
6687  10b0 a610          	ld	a,#16
6688  10b2 42            	mul	x,a
6689  10b3 7b07          	ld	a,(OFST+7,sp)
6690  10b5 e77b          	ld	(_can_out_buff+4,x),a
6691                     ; 1650 can_out_buff[can_buff_wr_ptr][5]=data3;
6693  10b7 b676          	ld	a,_can_buff_wr_ptr
6694  10b9 97            	ld	xl,a
6695  10ba a610          	ld	a,#16
6696  10bc 42            	mul	x,a
6697  10bd 7b08          	ld	a,(OFST+8,sp)
6698  10bf e77c          	ld	(_can_out_buff+5,x),a
6699                     ; 1651 can_out_buff[can_buff_wr_ptr][6]=data4;
6701  10c1 b676          	ld	a,_can_buff_wr_ptr
6702  10c3 97            	ld	xl,a
6703  10c4 a610          	ld	a,#16
6704  10c6 42            	mul	x,a
6705  10c7 7b09          	ld	a,(OFST+9,sp)
6706  10c9 e77d          	ld	(_can_out_buff+6,x),a
6707                     ; 1652 can_out_buff[can_buff_wr_ptr][7]=data5;
6709  10cb b676          	ld	a,_can_buff_wr_ptr
6710  10cd 97            	ld	xl,a
6711  10ce a610          	ld	a,#16
6712  10d0 42            	mul	x,a
6713  10d1 7b0a          	ld	a,(OFST+10,sp)
6714  10d3 e77e          	ld	(_can_out_buff+7,x),a
6715                     ; 1653 can_out_buff[can_buff_wr_ptr][8]=data6;
6717  10d5 b676          	ld	a,_can_buff_wr_ptr
6718  10d7 97            	ld	xl,a
6719  10d8 a610          	ld	a,#16
6720  10da 42            	mul	x,a
6721  10db 7b0b          	ld	a,(OFST+11,sp)
6722  10dd e77f          	ld	(_can_out_buff+8,x),a
6723                     ; 1654 can_out_buff[can_buff_wr_ptr][9]=data7;
6725  10df b676          	ld	a,_can_buff_wr_ptr
6726  10e1 97            	ld	xl,a
6727  10e2 a610          	ld	a,#16
6728  10e4 42            	mul	x,a
6729  10e5 7b0c          	ld	a,(OFST+12,sp)
6730  10e7 e780          	ld	(_can_out_buff+9,x),a
6731                     ; 1656 can_buff_wr_ptr++;
6733  10e9 3c76          	inc	_can_buff_wr_ptr
6734                     ; 1657 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6736  10eb b676          	ld	a,_can_buff_wr_ptr
6737  10ed a104          	cp	a,#4
6738  10ef 2502          	jrult	L5013
6741  10f1 3f76          	clr	_can_buff_wr_ptr
6742  10f3               L5013:
6743                     ; 1658 } 
6746  10f3 85            	popw	x
6747  10f4 81            	ret
6776                     ; 1661 void can_tx_hndl(void)
6776                     ; 1662 {
6777                     	switch	.text
6778  10f5               _can_tx_hndl:
6782                     ; 1663 if(bTX_FREE)
6784  10f5 3d03          	tnz	_bTX_FREE
6785  10f7 2757          	jreq	L7113
6786                     ; 1665 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6788  10f9 b675          	ld	a,_can_buff_rd_ptr
6789  10fb b176          	cp	a,_can_buff_wr_ptr
6790  10fd 275f          	jreq	L5213
6791                     ; 1667 		bTX_FREE=0;
6793  10ff 3f03          	clr	_bTX_FREE
6794                     ; 1669 		CAN->PSR= 0;
6796  1101 725f5427      	clr	21543
6797                     ; 1670 		CAN->Page.TxMailbox.MDLCR=8;
6799  1105 35085429      	mov	21545,#8
6800                     ; 1671 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6802  1109 b675          	ld	a,_can_buff_rd_ptr
6803  110b 97            	ld	xl,a
6804  110c a610          	ld	a,#16
6805  110e 42            	mul	x,a
6806  110f e677          	ld	a,(_can_out_buff,x)
6807  1111 c7542a        	ld	21546,a
6808                     ; 1672 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6810  1114 b675          	ld	a,_can_buff_rd_ptr
6811  1116 97            	ld	xl,a
6812  1117 a610          	ld	a,#16
6813  1119 42            	mul	x,a
6814  111a e678          	ld	a,(_can_out_buff+1,x)
6815  111c c7542b        	ld	21547,a
6816                     ; 1674 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6818  111f b675          	ld	a,_can_buff_rd_ptr
6819  1121 97            	ld	xl,a
6820  1122 a610          	ld	a,#16
6821  1124 42            	mul	x,a
6822  1125 01            	rrwa	x,a
6823  1126 ab79          	add	a,#_can_out_buff+2
6824  1128 2401          	jrnc	L041
6825  112a 5c            	incw	x
6826  112b               L041:
6827  112b 5f            	clrw	x
6828  112c 97            	ld	xl,a
6829  112d bf00          	ldw	c_x,x
6830  112f ae0008        	ldw	x,#8
6831  1132               L241:
6832  1132 5a            	decw	x
6833  1133 92d600        	ld	a,([c_x],x)
6834  1136 d7542e        	ld	(21550,x),a
6835  1139 5d            	tnzw	x
6836  113a 26f6          	jrne	L241
6837                     ; 1676 		can_buff_rd_ptr++;
6839  113c 3c75          	inc	_can_buff_rd_ptr
6840                     ; 1677 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6842  113e b675          	ld	a,_can_buff_rd_ptr
6843  1140 a104          	cp	a,#4
6844  1142 2502          	jrult	L3213
6847  1144 3f75          	clr	_can_buff_rd_ptr
6848  1146               L3213:
6849                     ; 1679 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6851  1146 72105428      	bset	21544,#0
6852                     ; 1680 		CAN->IER|=(1<<0);
6854  114a 72105425      	bset	21541,#0
6855  114e 200e          	jra	L5213
6856  1150               L7113:
6857                     ; 1685 	tx_busy_cnt++;
6859  1150 3c74          	inc	_tx_busy_cnt
6860                     ; 1686 	if(tx_busy_cnt>=100)
6862  1152 b674          	ld	a,_tx_busy_cnt
6863  1154 a164          	cp	a,#100
6864  1156 2506          	jrult	L5213
6865                     ; 1688 		tx_busy_cnt=0;
6867  1158 3f74          	clr	_tx_busy_cnt
6868                     ; 1689 		bTX_FREE=1;
6870  115a 35010003      	mov	_bTX_FREE,#1
6871  115e               L5213:
6872                     ; 1692 }
6875  115e 81            	ret
6990                     ; 1718 void can_in_an(void)
6990                     ; 1719 {
6991                     	switch	.text
6992  115f               _can_in_an:
6994  115f 5207          	subw	sp,#7
6995       00000007      OFST:	set	7
6998                     ; 1729 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7000  1161 b6cd          	ld	a,_mess+6
7001  1163 c100ff        	cp	a,_adress
7002  1166 2703          	jreq	L261
7003  1168 cc12a0        	jp	L5613
7004  116b               L261:
7006  116b b6ce          	ld	a,_mess+7
7007  116d c100ff        	cp	a,_adress
7008  1170 2703          	jreq	L461
7009  1172 cc12a0        	jp	L5613
7010  1175               L461:
7012  1175 b6cf          	ld	a,_mess+8
7013  1177 a1ed          	cp	a,#237
7014  1179 2703          	jreq	L661
7015  117b cc12a0        	jp	L5613
7016  117e               L661:
7017                     ; 1732 	can_error_cnt=0;
7019  117e 3f73          	clr	_can_error_cnt
7020                     ; 1734 	bMAIN=0;
7022  1180 72110001      	bres	_bMAIN
7023                     ; 1735  	flags_tu=mess[9];
7025  1184 45d06a        	mov	_flags_tu,_mess+9
7026                     ; 1736  	if(flags_tu&0b00000001)
7028  1187 b66a          	ld	a,_flags_tu
7029  1189 a501          	bcp	a,#1
7030  118b 2706          	jreq	L7613
7031                     ; 1741  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7033  118d 721a0005      	bset	_flags,#5
7035  1191 2008          	jra	L1713
7036  1193               L7613:
7037                     ; 1752  				flags&=0b11011111; 
7039  1193 721b0005      	bres	_flags,#5
7040                     ; 1753  				off_bp_cnt=5*EE_TZAS;
7042  1197 350f005d      	mov	_off_bp_cnt,#15
7043  119b               L1713:
7044                     ; 1759  	if(flags_tu&0b00000010) flags|=0b01000000;
7046  119b b66a          	ld	a,_flags_tu
7047  119d a502          	bcp	a,#2
7048  119f 2706          	jreq	L3713
7051  11a1 721c0005      	bset	_flags,#6
7053  11a5 2004          	jra	L5713
7054  11a7               L3713:
7055                     ; 1760  	else flags&=0b10111111; 
7057  11a7 721d0005      	bres	_flags,#6
7058  11ab               L5713:
7059                     ; 1762  	U_out_const=mess[10]+mess[11]*256;
7061  11ab b6d2          	ld	a,_mess+11
7062  11ad 5f            	clrw	x
7063  11ae 97            	ld	xl,a
7064  11af 4f            	clr	a
7065  11b0 02            	rlwa	x,a
7066  11b1 01            	rrwa	x,a
7067  11b2 bbd1          	add	a,_mess+10
7068  11b4 2401          	jrnc	L641
7069  11b6 5c            	incw	x
7070  11b7               L641:
7071  11b7 c70011        	ld	_U_out_const+1,a
7072  11ba 9f            	ld	a,xl
7073  11bb c70010        	ld	_U_out_const,a
7074                     ; 1763  	vol_i_temp=mess[12]+mess[13]*256;  
7076  11be b6d4          	ld	a,_mess+13
7077  11c0 5f            	clrw	x
7078  11c1 97            	ld	xl,a
7079  11c2 4f            	clr	a
7080  11c3 02            	rlwa	x,a
7081  11c4 01            	rrwa	x,a
7082  11c5 bbd3          	add	a,_mess+12
7083  11c7 2401          	jrnc	L051
7084  11c9 5c            	incw	x
7085  11ca               L051:
7086  11ca b761          	ld	_vol_i_temp+1,a
7087  11cc 9f            	ld	a,xl
7088  11cd b760          	ld	_vol_i_temp,a
7089                     ; 1773 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7091  11cf b608          	ld	a,_vent_resurs_tx_cnt
7092  11d1 a102          	cp	a,#2
7093  11d3 2507          	jrult	L7713
7096  11d5 ce0000        	ldw	x,_vent_resurs
7097  11d8 bf41          	ldw	_plazma_int+4,x
7099  11da 2004          	jra	L1023
7100  11dc               L7713:
7101                     ; 1774 	else plazma_int[2]=vent_resurs_sec_cnt;
7103  11dc be09          	ldw	x,_vent_resurs_sec_cnt
7104  11de bf41          	ldw	_plazma_int+4,x
7105  11e0               L1023:
7106                     ; 1775  	rotor_int=flags_tu+(((short)flags)<<8);
7108  11e0 b605          	ld	a,_flags
7109  11e2 5f            	clrw	x
7110  11e3 97            	ld	xl,a
7111  11e4 4f            	clr	a
7112  11e5 02            	rlwa	x,a
7113  11e6 01            	rrwa	x,a
7114  11e7 bb6a          	add	a,_flags_tu
7115  11e9 2401          	jrnc	L251
7116  11eb 5c            	incw	x
7117  11ec               L251:
7118  11ec b718          	ld	_rotor_int+1,a
7119  11ee 9f            	ld	a,xl
7120  11ef b717          	ld	_rotor_int,a
7121                     ; 1776 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7123  11f1 3b0014        	push	_Ui
7124  11f4 3b0015        	push	_Ui+1
7125  11f7 3b0016        	push	_Un
7126  11fa 3b0017        	push	_Un+1
7127  11fd 3b0018        	push	_I
7128  1200 3b0019        	push	_I+1
7129  1203 4bda          	push	#218
7130  1205 3b00ff        	push	_adress
7131  1208 ae018e        	ldw	x,#398
7132  120b cd1071        	call	_can_transmit
7134  120e 5b08          	addw	sp,#8
7135                     ; 1777 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7137  1210 3b000e        	push	_Usum
7138  1213 3b000f        	push	_Usum+1
7139  1216 3b0069        	push	__x_+1
7140  1219 3b0005        	push	_flags
7141  121c b608          	ld	a,_vent_resurs_tx_cnt
7142  121e 5f            	clrw	x
7143  121f 97            	ld	xl,a
7144  1220 d60008        	ld	a,(_vent_resurs_buff,x)
7145  1223 88            	push	a
7146  1224 3b0072        	push	_T
7147  1227 4bdb          	push	#219
7148  1229 3b00ff        	push	_adress
7149  122c ae018e        	ldw	x,#398
7150  122f cd1071        	call	_can_transmit
7152  1232 5b08          	addw	sp,#8
7153                     ; 1778 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7155  1234 3b0005        	push	_debug_info_to_uku+4
7156  1237 3b0006        	push	_debug_info_to_uku+5
7157  123a 3b0003        	push	_debug_info_to_uku+2
7158  123d 3b0004        	push	_debug_info_to_uku+3
7159  1240 3b0001        	push	_debug_info_to_uku
7160  1243 3b0002        	push	_debug_info_to_uku+1
7161  1246 4bdc          	push	#220
7162  1248 3b00ff        	push	_adress
7163  124b ae018e        	ldw	x,#398
7164  124e cd1071        	call	_can_transmit
7166  1251 5b08          	addw	sp,#8
7167                     ; 1779      link_cnt=0;
7169  1253 5f            	clrw	x
7170  1254 bf6b          	ldw	_link_cnt,x
7171                     ; 1780      link=ON;
7173  1256 3555006d      	mov	_link,#85
7174                     ; 1782      if(flags_tu&0b10000000)
7176  125a b66a          	ld	a,_flags_tu
7177  125c a580          	bcp	a,#128
7178  125e 2716          	jreq	L3023
7179                     ; 1784      	if(!res_fl)
7181  1260 725d000b      	tnz	_res_fl
7182  1264 2626          	jrne	L7023
7183                     ; 1786      		res_fl=1;
7185  1266 a601          	ld	a,#1
7186  1268 ae000b        	ldw	x,#_res_fl
7187  126b cd0000        	call	c_eewrc
7189                     ; 1787      		bRES=1;
7191  126e 3501000c      	mov	_bRES,#1
7192                     ; 1788      		res_fl_cnt=0;
7194  1272 3f4b          	clr	_res_fl_cnt
7195  1274 2016          	jra	L7023
7196  1276               L3023:
7197                     ; 1793      	if(main_cnt>20)
7199  1276 9c            	rvf
7200  1277 ce025d        	ldw	x,_main_cnt
7201  127a a30015        	cpw	x,#21
7202  127d 2f0d          	jrslt	L7023
7203                     ; 1795     			if(res_fl)
7205  127f 725d000b      	tnz	_res_fl
7206  1283 2707          	jreq	L7023
7207                     ; 1797      			res_fl=0;
7209  1285 4f            	clr	a
7210  1286 ae000b        	ldw	x,#_res_fl
7211  1289 cd0000        	call	c_eewrc
7213  128c               L7023:
7214                     ; 1802       if(res_fl_)
7216  128c 725d000a      	tnz	_res_fl_
7217  1290 2603          	jrne	L071
7218  1292 cc1807        	jp	L1313
7219  1295               L071:
7220                     ; 1804       	res_fl_=0;
7222  1295 4f            	clr	a
7223  1296 ae000a        	ldw	x,#_res_fl_
7224  1299 cd0000        	call	c_eewrc
7226  129c ac071807      	jpf	L1313
7227  12a0               L5613:
7228                     ; 1807 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7230  12a0 b6cd          	ld	a,_mess+6
7231  12a2 c100ff        	cp	a,_adress
7232  12a5 2703          	jreq	L271
7233  12a7 cc151d        	jp	L1223
7234  12aa               L271:
7236  12aa b6ce          	ld	a,_mess+7
7237  12ac c100ff        	cp	a,_adress
7238  12af 2703          	jreq	L471
7239  12b1 cc151d        	jp	L1223
7240  12b4               L471:
7242  12b4 b6cf          	ld	a,_mess+8
7243  12b6 a1ee          	cp	a,#238
7244  12b8 2703          	jreq	L671
7245  12ba cc151d        	jp	L1223
7246  12bd               L671:
7248  12bd b6d0          	ld	a,_mess+9
7249  12bf b1d1          	cp	a,_mess+10
7250  12c1 2703          	jreq	L002
7251  12c3 cc151d        	jp	L1223
7252  12c6               L002:
7253                     ; 1809 	rotor_int++;
7255  12c6 be17          	ldw	x,_rotor_int
7256  12c8 1c0001        	addw	x,#1
7257  12cb bf17          	ldw	_rotor_int,x
7258                     ; 1810 	if((mess[9]&0xf0)==0x20)
7260  12cd b6d0          	ld	a,_mess+9
7261  12cf a4f0          	and	a,#240
7262  12d1 a120          	cp	a,#32
7263  12d3 2673          	jrne	L3223
7264                     ; 1812 		if((mess[9]&0x0f)==0x01)
7266  12d5 b6d0          	ld	a,_mess+9
7267  12d7 a40f          	and	a,#15
7268  12d9 a101          	cp	a,#1
7269  12db 260d          	jrne	L5223
7270                     ; 1814 			ee_K[0][0]=adc_buff_[4];
7272  12dd ce010f        	ldw	x,_adc_buff_+8
7273  12e0 89            	pushw	x
7274  12e1 ae001a        	ldw	x,#_ee_K
7275  12e4 cd0000        	call	c_eewrw
7277  12e7 85            	popw	x
7279  12e8 204a          	jra	L7223
7280  12ea               L5223:
7281                     ; 1816 		else if((mess[9]&0x0f)==0x02)
7283  12ea b6d0          	ld	a,_mess+9
7284  12ec a40f          	and	a,#15
7285  12ee a102          	cp	a,#2
7286  12f0 260b          	jrne	L1323
7287                     ; 1818 			ee_K[0][1]++;
7289  12f2 ce001c        	ldw	x,_ee_K+2
7290  12f5 1c0001        	addw	x,#1
7291  12f8 cf001c        	ldw	_ee_K+2,x
7293  12fb 2037          	jra	L7223
7294  12fd               L1323:
7295                     ; 1820 		else if((mess[9]&0x0f)==0x03)
7297  12fd b6d0          	ld	a,_mess+9
7298  12ff a40f          	and	a,#15
7299  1301 a103          	cp	a,#3
7300  1303 260b          	jrne	L5323
7301                     ; 1822 			ee_K[0][1]+=10;
7303  1305 ce001c        	ldw	x,_ee_K+2
7304  1308 1c000a        	addw	x,#10
7305  130b cf001c        	ldw	_ee_K+2,x
7307  130e 2024          	jra	L7223
7308  1310               L5323:
7309                     ; 1824 		else if((mess[9]&0x0f)==0x04)
7311  1310 b6d0          	ld	a,_mess+9
7312  1312 a40f          	and	a,#15
7313  1314 a104          	cp	a,#4
7314  1316 260b          	jrne	L1423
7315                     ; 1826 			ee_K[0][1]--;
7317  1318 ce001c        	ldw	x,_ee_K+2
7318  131b 1d0001        	subw	x,#1
7319  131e cf001c        	ldw	_ee_K+2,x
7321  1321 2011          	jra	L7223
7322  1323               L1423:
7323                     ; 1828 		else if((mess[9]&0x0f)==0x05)
7325  1323 b6d0          	ld	a,_mess+9
7326  1325 a40f          	and	a,#15
7327  1327 a105          	cp	a,#5
7328  1329 2609          	jrne	L7223
7329                     ; 1830 			ee_K[0][1]-=10;
7331  132b ce001c        	ldw	x,_ee_K+2
7332  132e 1d000a        	subw	x,#10
7333  1331 cf001c        	ldw	_ee_K+2,x
7334  1334               L7223:
7335                     ; 1832 		granee(&ee_K[0][1],50,3000);									
7337  1334 ae0bb8        	ldw	x,#3000
7338  1337 89            	pushw	x
7339  1338 ae0032        	ldw	x,#50
7340  133b 89            	pushw	x
7341  133c ae001c        	ldw	x,#_ee_K+2
7342  133f cd00f6        	call	_granee
7344  1342 5b04          	addw	sp,#4
7346  1344 ac021502      	jpf	L7423
7347  1348               L3223:
7348                     ; 1834 	else if((mess[9]&0xf0)==0x10)
7350  1348 b6d0          	ld	a,_mess+9
7351  134a a4f0          	and	a,#240
7352  134c a110          	cp	a,#16
7353  134e 2673          	jrne	L1523
7354                     ; 1836 		if((mess[9]&0x0f)==0x01)
7356  1350 b6d0          	ld	a,_mess+9
7357  1352 a40f          	and	a,#15
7358  1354 a101          	cp	a,#1
7359  1356 260d          	jrne	L3523
7360                     ; 1838 			ee_K[1][0]=adc_buff_[1];
7362  1358 ce0109        	ldw	x,_adc_buff_+2
7363  135b 89            	pushw	x
7364  135c ae001e        	ldw	x,#_ee_K+4
7365  135f cd0000        	call	c_eewrw
7367  1362 85            	popw	x
7369  1363 204a          	jra	L5523
7370  1365               L3523:
7371                     ; 1840 		else if((mess[9]&0x0f)==0x02)
7373  1365 b6d0          	ld	a,_mess+9
7374  1367 a40f          	and	a,#15
7375  1369 a102          	cp	a,#2
7376  136b 260b          	jrne	L7523
7377                     ; 1842 			ee_K[1][1]++;
7379  136d ce0020        	ldw	x,_ee_K+6
7380  1370 1c0001        	addw	x,#1
7381  1373 cf0020        	ldw	_ee_K+6,x
7383  1376 2037          	jra	L5523
7384  1378               L7523:
7385                     ; 1844 		else if((mess[9]&0x0f)==0x03)
7387  1378 b6d0          	ld	a,_mess+9
7388  137a a40f          	and	a,#15
7389  137c a103          	cp	a,#3
7390  137e 260b          	jrne	L3623
7391                     ; 1846 			ee_K[1][1]+=10;
7393  1380 ce0020        	ldw	x,_ee_K+6
7394  1383 1c000a        	addw	x,#10
7395  1386 cf0020        	ldw	_ee_K+6,x
7397  1389 2024          	jra	L5523
7398  138b               L3623:
7399                     ; 1848 		else if((mess[9]&0x0f)==0x04)
7401  138b b6d0          	ld	a,_mess+9
7402  138d a40f          	and	a,#15
7403  138f a104          	cp	a,#4
7404  1391 260b          	jrne	L7623
7405                     ; 1850 			ee_K[1][1]--;
7407  1393 ce0020        	ldw	x,_ee_K+6
7408  1396 1d0001        	subw	x,#1
7409  1399 cf0020        	ldw	_ee_K+6,x
7411  139c 2011          	jra	L5523
7412  139e               L7623:
7413                     ; 1852 		else if((mess[9]&0x0f)==0x05)
7415  139e b6d0          	ld	a,_mess+9
7416  13a0 a40f          	and	a,#15
7417  13a2 a105          	cp	a,#5
7418  13a4 2609          	jrne	L5523
7419                     ; 1854 			ee_K[1][1]-=10;
7421  13a6 ce0020        	ldw	x,_ee_K+6
7422  13a9 1d000a        	subw	x,#10
7423  13ac cf0020        	ldw	_ee_K+6,x
7424  13af               L5523:
7425                     ; 1859 		granee(&ee_K[1][1],10,30000);
7427  13af ae7530        	ldw	x,#30000
7428  13b2 89            	pushw	x
7429  13b3 ae000a        	ldw	x,#10
7430  13b6 89            	pushw	x
7431  13b7 ae0020        	ldw	x,#_ee_K+6
7432  13ba cd00f6        	call	_granee
7434  13bd 5b04          	addw	sp,#4
7436  13bf ac021502      	jpf	L7423
7437  13c3               L1523:
7438                     ; 1863 	else if((mess[9]&0xf0)==0x00)
7440  13c3 b6d0          	ld	a,_mess+9
7441  13c5 a5f0          	bcp	a,#240
7442  13c7 2673          	jrne	L7723
7443                     ; 1865 		if((mess[9]&0x0f)==0x01)
7445  13c9 b6d0          	ld	a,_mess+9
7446  13cb a40f          	and	a,#15
7447  13cd a101          	cp	a,#1
7448  13cf 260d          	jrne	L1033
7449                     ; 1867 			ee_K[2][0]=adc_buff_[2];
7451  13d1 ce010b        	ldw	x,_adc_buff_+4
7452  13d4 89            	pushw	x
7453  13d5 ae0022        	ldw	x,#_ee_K+8
7454  13d8 cd0000        	call	c_eewrw
7456  13db 85            	popw	x
7458  13dc 204a          	jra	L3033
7459  13de               L1033:
7460                     ; 1869 		else if((mess[9]&0x0f)==0x02)
7462  13de b6d0          	ld	a,_mess+9
7463  13e0 a40f          	and	a,#15
7464  13e2 a102          	cp	a,#2
7465  13e4 260b          	jrne	L5033
7466                     ; 1871 			ee_K[2][1]++;
7468  13e6 ce0024        	ldw	x,_ee_K+10
7469  13e9 1c0001        	addw	x,#1
7470  13ec cf0024        	ldw	_ee_K+10,x
7472  13ef 2037          	jra	L3033
7473  13f1               L5033:
7474                     ; 1873 		else if((mess[9]&0x0f)==0x03)
7476  13f1 b6d0          	ld	a,_mess+9
7477  13f3 a40f          	and	a,#15
7478  13f5 a103          	cp	a,#3
7479  13f7 260b          	jrne	L1133
7480                     ; 1875 			ee_K[2][1]+=10;
7482  13f9 ce0024        	ldw	x,_ee_K+10
7483  13fc 1c000a        	addw	x,#10
7484  13ff cf0024        	ldw	_ee_K+10,x
7486  1402 2024          	jra	L3033
7487  1404               L1133:
7488                     ; 1877 		else if((mess[9]&0x0f)==0x04)
7490  1404 b6d0          	ld	a,_mess+9
7491  1406 a40f          	and	a,#15
7492  1408 a104          	cp	a,#4
7493  140a 260b          	jrne	L5133
7494                     ; 1879 			ee_K[2][1]--;
7496  140c ce0024        	ldw	x,_ee_K+10
7497  140f 1d0001        	subw	x,#1
7498  1412 cf0024        	ldw	_ee_K+10,x
7500  1415 2011          	jra	L3033
7501  1417               L5133:
7502                     ; 1881 		else if((mess[9]&0x0f)==0x05)
7504  1417 b6d0          	ld	a,_mess+9
7505  1419 a40f          	and	a,#15
7506  141b a105          	cp	a,#5
7507  141d 2609          	jrne	L3033
7508                     ; 1883 			ee_K[2][1]-=10;
7510  141f ce0024        	ldw	x,_ee_K+10
7511  1422 1d000a        	subw	x,#10
7512  1425 cf0024        	ldw	_ee_K+10,x
7513  1428               L3033:
7514                     ; 1888 		granee(&ee_K[2][1],10,30000);
7516  1428 ae7530        	ldw	x,#30000
7517  142b 89            	pushw	x
7518  142c ae000a        	ldw	x,#10
7519  142f 89            	pushw	x
7520  1430 ae0024        	ldw	x,#_ee_K+10
7521  1433 cd00f6        	call	_granee
7523  1436 5b04          	addw	sp,#4
7525  1438 ac021502      	jpf	L7423
7526  143c               L7723:
7527                     ; 1892 	else if((mess[9]&0xf0)==0x30)
7529  143c b6d0          	ld	a,_mess+9
7530  143e a4f0          	and	a,#240
7531  1440 a130          	cp	a,#48
7532  1442 265c          	jrne	L5233
7533                     ; 1894 		if((mess[9]&0x0f)==0x02)
7535  1444 b6d0          	ld	a,_mess+9
7536  1446 a40f          	and	a,#15
7537  1448 a102          	cp	a,#2
7538  144a 260b          	jrne	L7233
7539                     ; 1896 			ee_K[3][1]++;
7541  144c ce0028        	ldw	x,_ee_K+14
7542  144f 1c0001        	addw	x,#1
7543  1452 cf0028        	ldw	_ee_K+14,x
7545  1455 2037          	jra	L1333
7546  1457               L7233:
7547                     ; 1898 		else if((mess[9]&0x0f)==0x03)
7549  1457 b6d0          	ld	a,_mess+9
7550  1459 a40f          	and	a,#15
7551  145b a103          	cp	a,#3
7552  145d 260b          	jrne	L3333
7553                     ; 1900 			ee_K[3][1]+=10;
7555  145f ce0028        	ldw	x,_ee_K+14
7556  1462 1c000a        	addw	x,#10
7557  1465 cf0028        	ldw	_ee_K+14,x
7559  1468 2024          	jra	L1333
7560  146a               L3333:
7561                     ; 1902 		else if((mess[9]&0x0f)==0x04)
7563  146a b6d0          	ld	a,_mess+9
7564  146c a40f          	and	a,#15
7565  146e a104          	cp	a,#4
7566  1470 260b          	jrne	L7333
7567                     ; 1904 			ee_K[3][1]--;
7569  1472 ce0028        	ldw	x,_ee_K+14
7570  1475 1d0001        	subw	x,#1
7571  1478 cf0028        	ldw	_ee_K+14,x
7573  147b 2011          	jra	L1333
7574  147d               L7333:
7575                     ; 1906 		else if((mess[9]&0x0f)==0x05)
7577  147d b6d0          	ld	a,_mess+9
7578  147f a40f          	and	a,#15
7579  1481 a105          	cp	a,#5
7580  1483 2609          	jrne	L1333
7581                     ; 1908 			ee_K[3][1]-=10;
7583  1485 ce0028        	ldw	x,_ee_K+14
7584  1488 1d000a        	subw	x,#10
7585  148b cf0028        	ldw	_ee_K+14,x
7586  148e               L1333:
7587                     ; 1910 		granee(&ee_K[3][1],300,517);									
7589  148e ae0205        	ldw	x,#517
7590  1491 89            	pushw	x
7591  1492 ae012c        	ldw	x,#300
7592  1495 89            	pushw	x
7593  1496 ae0028        	ldw	x,#_ee_K+14
7594  1499 cd00f6        	call	_granee
7596  149c 5b04          	addw	sp,#4
7598  149e 2062          	jra	L7423
7599  14a0               L5233:
7600                     ; 1913 	else if((mess[9]&0xf0)==0x50)
7602  14a0 b6d0          	ld	a,_mess+9
7603  14a2 a4f0          	and	a,#240
7604  14a4 a150          	cp	a,#80
7605  14a6 265a          	jrne	L7423
7606                     ; 1915 		if((mess[9]&0x0f)==0x02)
7608  14a8 b6d0          	ld	a,_mess+9
7609  14aa a40f          	and	a,#15
7610  14ac a102          	cp	a,#2
7611  14ae 260b          	jrne	L1533
7612                     ; 1917 			ee_K[4][1]++;
7614  14b0 ce002c        	ldw	x,_ee_K+18
7615  14b3 1c0001        	addw	x,#1
7616  14b6 cf002c        	ldw	_ee_K+18,x
7618  14b9 2037          	jra	L3533
7619  14bb               L1533:
7620                     ; 1919 		else if((mess[9]&0x0f)==0x03)
7622  14bb b6d0          	ld	a,_mess+9
7623  14bd a40f          	and	a,#15
7624  14bf a103          	cp	a,#3
7625  14c1 260b          	jrne	L5533
7626                     ; 1921 			ee_K[4][1]+=10;
7628  14c3 ce002c        	ldw	x,_ee_K+18
7629  14c6 1c000a        	addw	x,#10
7630  14c9 cf002c        	ldw	_ee_K+18,x
7632  14cc 2024          	jra	L3533
7633  14ce               L5533:
7634                     ; 1923 		else if((mess[9]&0x0f)==0x04)
7636  14ce b6d0          	ld	a,_mess+9
7637  14d0 a40f          	and	a,#15
7638  14d2 a104          	cp	a,#4
7639  14d4 260b          	jrne	L1633
7640                     ; 1925 			ee_K[4][1]--;
7642  14d6 ce002c        	ldw	x,_ee_K+18
7643  14d9 1d0001        	subw	x,#1
7644  14dc cf002c        	ldw	_ee_K+18,x
7646  14df 2011          	jra	L3533
7647  14e1               L1633:
7648                     ; 1927 		else if((mess[9]&0x0f)==0x05)
7650  14e1 b6d0          	ld	a,_mess+9
7651  14e3 a40f          	and	a,#15
7652  14e5 a105          	cp	a,#5
7653  14e7 2609          	jrne	L3533
7654                     ; 1929 			ee_K[4][1]-=10;
7656  14e9 ce002c        	ldw	x,_ee_K+18
7657  14ec 1d000a        	subw	x,#10
7658  14ef cf002c        	ldw	_ee_K+18,x
7659  14f2               L3533:
7660                     ; 1931 		granee(&ee_K[4][1],10,30000);									
7662  14f2 ae7530        	ldw	x,#30000
7663  14f5 89            	pushw	x
7664  14f6 ae000a        	ldw	x,#10
7665  14f9 89            	pushw	x
7666  14fa ae002c        	ldw	x,#_ee_K+18
7667  14fd cd00f6        	call	_granee
7669  1500 5b04          	addw	sp,#4
7670  1502               L7423:
7671                     ; 1934 	link_cnt=0;
7673  1502 5f            	clrw	x
7674  1503 bf6b          	ldw	_link_cnt,x
7675                     ; 1935      link=ON;
7677  1505 3555006d      	mov	_link,#85
7678                     ; 1936      if(res_fl_)
7680  1509 725d000a      	tnz	_res_fl_
7681  150d 2603          	jrne	L202
7682  150f cc1807        	jp	L1313
7683  1512               L202:
7684                     ; 1938       	res_fl_=0;
7686  1512 4f            	clr	a
7687  1513 ae000a        	ldw	x,#_res_fl_
7688  1516 cd0000        	call	c_eewrc
7690  1519 ac071807      	jpf	L1313
7691  151d               L1223:
7692                     ; 1944 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7694  151d b6cd          	ld	a,_mess+6
7695  151f a1ff          	cp	a,#255
7696  1521 2703          	jreq	L402
7697  1523 cc15b1        	jp	L3733
7698  1526               L402:
7700  1526 b6ce          	ld	a,_mess+7
7701  1528 a1ff          	cp	a,#255
7702  152a 2703          	jreq	L602
7703  152c cc15b1        	jp	L3733
7704  152f               L602:
7706  152f b6cf          	ld	a,_mess+8
7707  1531 a162          	cp	a,#98
7708  1533 267c          	jrne	L3733
7709                     ; 1947 	tempSS=mess[9]+(mess[10]*256);
7711  1535 b6d1          	ld	a,_mess+10
7712  1537 5f            	clrw	x
7713  1538 97            	ld	xl,a
7714  1539 4f            	clr	a
7715  153a 02            	rlwa	x,a
7716  153b 01            	rrwa	x,a
7717  153c bbd0          	add	a,_mess+9
7718  153e 2401          	jrnc	L451
7719  1540 5c            	incw	x
7720  1541               L451:
7721  1541 02            	rlwa	x,a
7722  1542 1f03          	ldw	(OFST-4,sp),x
7723  1544 01            	rrwa	x,a
7724                     ; 1948 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7726  1545 ce0014        	ldw	x,_ee_Umax
7727  1548 1303          	cpw	x,(OFST-4,sp)
7728  154a 270a          	jreq	L5733
7731  154c 1e03          	ldw	x,(OFST-4,sp)
7732  154e 89            	pushw	x
7733  154f ae0014        	ldw	x,#_ee_Umax
7734  1552 cd0000        	call	c_eewrw
7736  1555 85            	popw	x
7737  1556               L5733:
7738                     ; 1949 	tempSS=mess[11]+(mess[12]*256);
7740  1556 b6d3          	ld	a,_mess+12
7741  1558 5f            	clrw	x
7742  1559 97            	ld	xl,a
7743  155a 4f            	clr	a
7744  155b 02            	rlwa	x,a
7745  155c 01            	rrwa	x,a
7746  155d bbd2          	add	a,_mess+11
7747  155f 2401          	jrnc	L651
7748  1561 5c            	incw	x
7749  1562               L651:
7750  1562 02            	rlwa	x,a
7751  1563 1f03          	ldw	(OFST-4,sp),x
7752  1565 01            	rrwa	x,a
7753                     ; 1950 	if(ee_dU!=tempSS) ee_dU=tempSS;
7755  1566 ce0012        	ldw	x,_ee_dU
7756  1569 1303          	cpw	x,(OFST-4,sp)
7757  156b 270a          	jreq	L7733
7760  156d 1e03          	ldw	x,(OFST-4,sp)
7761  156f 89            	pushw	x
7762  1570 ae0012        	ldw	x,#_ee_dU
7763  1573 cd0000        	call	c_eewrw
7765  1576 85            	popw	x
7766  1577               L7733:
7767                     ; 1951 	if((mess[13]&0x0f)==0x5)
7769  1577 b6d4          	ld	a,_mess+13
7770  1579 a40f          	and	a,#15
7771  157b a105          	cp	a,#5
7772  157d 261a          	jrne	L1043
7773                     ; 1953 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7775  157f ce0006        	ldw	x,_ee_AVT_MODE
7776  1582 a30055        	cpw	x,#85
7777  1585 2603          	jrne	L012
7778  1587 cc1807        	jp	L1313
7779  158a               L012:
7782  158a ae0055        	ldw	x,#85
7783  158d 89            	pushw	x
7784  158e ae0006        	ldw	x,#_ee_AVT_MODE
7785  1591 cd0000        	call	c_eewrw
7787  1594 85            	popw	x
7788  1595 ac071807      	jpf	L1313
7789  1599               L1043:
7790                     ; 1955 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7792  1599 ce0006        	ldw	x,_ee_AVT_MODE
7793  159c a30055        	cpw	x,#85
7794  159f 2703          	jreq	L212
7795  15a1 cc1807        	jp	L1313
7796  15a4               L212:
7799  15a4 5f            	clrw	x
7800  15a5 89            	pushw	x
7801  15a6 ae0006        	ldw	x,#_ee_AVT_MODE
7802  15a9 cd0000        	call	c_eewrw
7804  15ac 85            	popw	x
7805  15ad ac071807      	jpf	L1313
7806  15b1               L3733:
7807                     ; 1958 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7809  15b1 b6cd          	ld	a,_mess+6
7810  15b3 a1ff          	cp	a,#255
7811  15b5 2703          	jreq	L412
7812  15b7 cc166d        	jp	L3143
7813  15ba               L412:
7815  15ba b6ce          	ld	a,_mess+7
7816  15bc a1ff          	cp	a,#255
7817  15be 2703          	jreq	L612
7818  15c0 cc166d        	jp	L3143
7819  15c3               L612:
7821  15c3 b6cf          	ld	a,_mess+8
7822  15c5 a126          	cp	a,#38
7823  15c7 2709          	jreq	L5143
7825  15c9 b6cf          	ld	a,_mess+8
7826  15cb a129          	cp	a,#41
7827  15cd 2703          	jreq	L022
7828  15cf cc166d        	jp	L3143
7829  15d2               L022:
7830  15d2               L5143:
7831                     ; 1961 	tempSS=mess[9]+(mess[10]*256);
7833  15d2 b6d1          	ld	a,_mess+10
7834  15d4 5f            	clrw	x
7835  15d5 97            	ld	xl,a
7836  15d6 4f            	clr	a
7837  15d7 02            	rlwa	x,a
7838  15d8 01            	rrwa	x,a
7839  15d9 bbd0          	add	a,_mess+9
7840  15db 2401          	jrnc	L061
7841  15dd 5c            	incw	x
7842  15de               L061:
7843  15de 02            	rlwa	x,a
7844  15df 1f03          	ldw	(OFST-4,sp),x
7845  15e1 01            	rrwa	x,a
7846                     ; 1963 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7848  15e2 ce000c        	ldw	x,_ee_UAVT
7849  15e5 1303          	cpw	x,(OFST-4,sp)
7850  15e7 270a          	jreq	L7143
7853  15e9 1e03          	ldw	x,(OFST-4,sp)
7854  15eb 89            	pushw	x
7855  15ec ae000c        	ldw	x,#_ee_UAVT
7856  15ef cd0000        	call	c_eewrw
7858  15f2 85            	popw	x
7859  15f3               L7143:
7860                     ; 1964 	tempSS=(signed short)mess[11];
7862  15f3 b6d2          	ld	a,_mess+11
7863  15f5 5f            	clrw	x
7864  15f6 97            	ld	xl,a
7865  15f7 1f03          	ldw	(OFST-4,sp),x
7866                     ; 1965 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7868  15f9 ce0010        	ldw	x,_ee_tmax
7869  15fc 1303          	cpw	x,(OFST-4,sp)
7870  15fe 270a          	jreq	L1243
7873  1600 1e03          	ldw	x,(OFST-4,sp)
7874  1602 89            	pushw	x
7875  1603 ae0010        	ldw	x,#_ee_tmax
7876  1606 cd0000        	call	c_eewrw
7878  1609 85            	popw	x
7879  160a               L1243:
7880                     ; 1966 	tempSS=(signed short)mess[12];
7882  160a b6d3          	ld	a,_mess+12
7883  160c 5f            	clrw	x
7884  160d 97            	ld	xl,a
7885  160e 1f03          	ldw	(OFST-4,sp),x
7886                     ; 1967 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7888  1610 ce000e        	ldw	x,_ee_tsign
7889  1613 1303          	cpw	x,(OFST-4,sp)
7890  1615 270a          	jreq	L3243
7893  1617 1e03          	ldw	x,(OFST-4,sp)
7894  1619 89            	pushw	x
7895  161a ae000e        	ldw	x,#_ee_tsign
7896  161d cd0000        	call	c_eewrw
7898  1620 85            	popw	x
7899  1621               L3243:
7900                     ; 1970 	if(mess[8]==MEM_KF1)
7902  1621 b6cf          	ld	a,_mess+8
7903  1623 a126          	cp	a,#38
7904  1625 260e          	jrne	L5243
7905                     ; 1972 		if(ee_DEVICE!=0)ee_DEVICE=0;
7907  1627 ce0004        	ldw	x,_ee_DEVICE
7908  162a 2709          	jreq	L5243
7911  162c 5f            	clrw	x
7912  162d 89            	pushw	x
7913  162e ae0004        	ldw	x,#_ee_DEVICE
7914  1631 cd0000        	call	c_eewrw
7916  1634 85            	popw	x
7917  1635               L5243:
7918                     ; 1975 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7920  1635 b6cf          	ld	a,_mess+8
7921  1637 a129          	cp	a,#41
7922  1639 2703          	jreq	L222
7923  163b cc1807        	jp	L1313
7924  163e               L222:
7925                     ; 1977 		if(ee_DEVICE!=1)ee_DEVICE=1;
7927  163e ce0004        	ldw	x,_ee_DEVICE
7928  1641 a30001        	cpw	x,#1
7929  1644 270b          	jreq	L3343
7932  1646 ae0001        	ldw	x,#1
7933  1649 89            	pushw	x
7934  164a ae0004        	ldw	x,#_ee_DEVICE
7935  164d cd0000        	call	c_eewrw
7937  1650 85            	popw	x
7938  1651               L3343:
7939                     ; 1978 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7941  1651 b6d4          	ld	a,_mess+13
7942  1653 5f            	clrw	x
7943  1654 97            	ld	xl,a
7944  1655 c30002        	cpw	x,_ee_IMAXVENT
7945  1658 2603          	jrne	L422
7946  165a cc1807        	jp	L1313
7947  165d               L422:
7950  165d b6d4          	ld	a,_mess+13
7951  165f 5f            	clrw	x
7952  1660 97            	ld	xl,a
7953  1661 89            	pushw	x
7954  1662 ae0002        	ldw	x,#_ee_IMAXVENT
7955  1665 cd0000        	call	c_eewrw
7957  1668 85            	popw	x
7958  1669 ac071807      	jpf	L1313
7959  166d               L3143:
7960                     ; 1983 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7962  166d b6cd          	ld	a,_mess+6
7963  166f c100ff        	cp	a,_adress
7964  1672 262d          	jrne	L1443
7966  1674 b6ce          	ld	a,_mess+7
7967  1676 c100ff        	cp	a,_adress
7968  1679 2626          	jrne	L1443
7970  167b b6cf          	ld	a,_mess+8
7971  167d a116          	cp	a,#22
7972  167f 2620          	jrne	L1443
7974  1681 b6d0          	ld	a,_mess+9
7975  1683 a163          	cp	a,#99
7976  1685 261a          	jrne	L1443
7977                     ; 1985 	flags&=0b11100001;
7979  1687 b605          	ld	a,_flags
7980  1689 a4e1          	and	a,#225
7981  168b b705          	ld	_flags,a
7982                     ; 1986 	tsign_cnt=0;
7984  168d 5f            	clrw	x
7985  168e bf59          	ldw	_tsign_cnt,x
7986                     ; 1987 	tmax_cnt=0;
7988  1690 5f            	clrw	x
7989  1691 bf57          	ldw	_tmax_cnt,x
7990                     ; 1988 	umax_cnt=0;
7992  1693 5f            	clrw	x
7993  1694 bf70          	ldw	_umax_cnt,x
7994                     ; 1989 	umin_cnt=0;
7996  1696 5f            	clrw	x
7997  1697 bf6e          	ldw	_umin_cnt,x
7998                     ; 1990 	led_drv_cnt=30;
8000  1699 351e0016      	mov	_led_drv_cnt,#30
8002  169d ac071807      	jpf	L1313
8003  16a1               L1443:
8004                     ; 1993 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8006  16a1 b6cd          	ld	a,_mess+6
8007  16a3 c100ff        	cp	a,_adress
8008  16a6 2620          	jrne	L5443
8010  16a8 b6ce          	ld	a,_mess+7
8011  16aa c100ff        	cp	a,_adress
8012  16ad 2619          	jrne	L5443
8014  16af b6cf          	ld	a,_mess+8
8015  16b1 a116          	cp	a,#22
8016  16b3 2613          	jrne	L5443
8018  16b5 b6d0          	ld	a,_mess+9
8019  16b7 a164          	cp	a,#100
8020  16b9 260d          	jrne	L5443
8021                     ; 1995 	vent_resurs=0;
8023  16bb 5f            	clrw	x
8024  16bc 89            	pushw	x
8025  16bd ae0000        	ldw	x,#_vent_resurs
8026  16c0 cd0000        	call	c_eewrw
8028  16c3 85            	popw	x
8030  16c4 ac071807      	jpf	L1313
8031  16c8               L5443:
8032                     ; 1999 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8034  16c8 b6cd          	ld	a,_mess+6
8035  16ca a1ff          	cp	a,#255
8036  16cc 265f          	jrne	L1543
8038  16ce b6ce          	ld	a,_mess+7
8039  16d0 a1ff          	cp	a,#255
8040  16d2 2659          	jrne	L1543
8042  16d4 b6cf          	ld	a,_mess+8
8043  16d6 a116          	cp	a,#22
8044  16d8 2653          	jrne	L1543
8046  16da b6d0          	ld	a,_mess+9
8047  16dc a116          	cp	a,#22
8048  16de 264d          	jrne	L1543
8049                     ; 2001 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8051  16e0 b6d1          	ld	a,_mess+10
8052  16e2 a155          	cp	a,#85
8053  16e4 260f          	jrne	L3543
8055  16e6 b6d2          	ld	a,_mess+11
8056  16e8 a155          	cp	a,#85
8057  16ea 2609          	jrne	L3543
8060  16ec be68          	ldw	x,__x_
8061  16ee 1c0001        	addw	x,#1
8062  16f1 bf68          	ldw	__x_,x
8064  16f3 2024          	jra	L5543
8065  16f5               L3543:
8066                     ; 2002 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8068  16f5 b6d1          	ld	a,_mess+10
8069  16f7 a166          	cp	a,#102
8070  16f9 260f          	jrne	L7543
8072  16fb b6d2          	ld	a,_mess+11
8073  16fd a166          	cp	a,#102
8074  16ff 2609          	jrne	L7543
8077  1701 be68          	ldw	x,__x_
8078  1703 1d0001        	subw	x,#1
8079  1706 bf68          	ldw	__x_,x
8081  1708 200f          	jra	L5543
8082  170a               L7543:
8083                     ; 2003 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8085  170a b6d1          	ld	a,_mess+10
8086  170c a177          	cp	a,#119
8087  170e 2609          	jrne	L5543
8089  1710 b6d2          	ld	a,_mess+11
8090  1712 a177          	cp	a,#119
8091  1714 2603          	jrne	L5543
8094  1716 5f            	clrw	x
8095  1717 bf68          	ldw	__x_,x
8096  1719               L5543:
8097                     ; 2004      gran(&_x_,-XMAX,XMAX);
8099  1719 ae0019        	ldw	x,#25
8100  171c 89            	pushw	x
8101  171d aeffe7        	ldw	x,#65511
8102  1720 89            	pushw	x
8103  1721 ae0068        	ldw	x,#__x_
8104  1724 cd00d5        	call	_gran
8106  1727 5b04          	addw	sp,#4
8108  1729 ac071807      	jpf	L1313
8109  172d               L1543:
8110                     ; 2006 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8112  172d b6cd          	ld	a,_mess+6
8113  172f c100ff        	cp	a,_adress
8114  1732 2635          	jrne	L7643
8116  1734 b6ce          	ld	a,_mess+7
8117  1736 c100ff        	cp	a,_adress
8118  1739 262e          	jrne	L7643
8120  173b b6cf          	ld	a,_mess+8
8121  173d a116          	cp	a,#22
8122  173f 2628          	jrne	L7643
8124  1741 b6d0          	ld	a,_mess+9
8125  1743 b1d1          	cp	a,_mess+10
8126  1745 2622          	jrne	L7643
8128  1747 b6d0          	ld	a,_mess+9
8129  1749 a1ee          	cp	a,#238
8130  174b 261c          	jrne	L7643
8131                     ; 2008 	rotor_int++;
8133  174d be17          	ldw	x,_rotor_int
8134  174f 1c0001        	addw	x,#1
8135  1752 bf17          	ldw	_rotor_int,x
8136                     ; 2009      tempI=pwm_u;
8138                     ; 2011 	UU_AVT=Un;
8140  1754 ce0016        	ldw	x,_Un
8141  1757 89            	pushw	x
8142  1758 ae0008        	ldw	x,#_UU_AVT
8143  175b cd0000        	call	c_eewrw
8145  175e 85            	popw	x
8146                     ; 2012 	delay_ms(100);
8148  175f ae0064        	ldw	x,#100
8149  1762 cd0121        	call	_delay_ms
8152  1765 ac071807      	jpf	L1313
8153  1769               L7643:
8154                     ; 2018 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8156  1769 b6ce          	ld	a,_mess+7
8157  176b a1da          	cp	a,#218
8158  176d 2653          	jrne	L3743
8160  176f b6cd          	ld	a,_mess+6
8161  1771 c100ff        	cp	a,_adress
8162  1774 274c          	jreq	L3743
8164  1776 b6cd          	ld	a,_mess+6
8165  1778 a106          	cp	a,#6
8166  177a 2446          	jruge	L3743
8167                     ; 2020 	i_main_bps_cnt[mess[6]]=0;
8169  177c b6cd          	ld	a,_mess+6
8170  177e 5f            	clrw	x
8171  177f 97            	ld	xl,a
8172  1780 6f13          	clr	(_i_main_bps_cnt,x)
8173                     ; 2021 	i_main_flag[mess[6]]=1;
8175  1782 b6cd          	ld	a,_mess+6
8176  1784 5f            	clrw	x
8177  1785 97            	ld	xl,a
8178  1786 a601          	ld	a,#1
8179  1788 e71e          	ld	(_i_main_flag,x),a
8180                     ; 2022 	if(bMAIN)
8182                     	btst	_bMAIN
8183  178f 2476          	jruge	L1313
8184                     ; 2024 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8186  1791 b6d0          	ld	a,_mess+9
8187  1793 5f            	clrw	x
8188  1794 97            	ld	xl,a
8189  1795 4f            	clr	a
8190  1796 02            	rlwa	x,a
8191  1797 1f01          	ldw	(OFST-6,sp),x
8192  1799 b6cf          	ld	a,_mess+8
8193  179b 5f            	clrw	x
8194  179c 97            	ld	xl,a
8195  179d 72fb01        	addw	x,(OFST-6,sp)
8196  17a0 b6cd          	ld	a,_mess+6
8197  17a2 905f          	clrw	y
8198  17a4 9097          	ld	yl,a
8199  17a6 9058          	sllw	y
8200  17a8 90ef24        	ldw	(_i_main,y),x
8201                     ; 2025 		i_main[adress]=I;
8203  17ab c600ff        	ld	a,_adress
8204  17ae 5f            	clrw	x
8205  17af 97            	ld	xl,a
8206  17b0 58            	sllw	x
8207  17b1 90ce0018      	ldw	y,_I
8208  17b5 ef24          	ldw	(_i_main,x),y
8209                     ; 2026      	i_main_flag[adress]=1;
8211  17b7 c600ff        	ld	a,_adress
8212  17ba 5f            	clrw	x
8213  17bb 97            	ld	xl,a
8214  17bc a601          	ld	a,#1
8215  17be e71e          	ld	(_i_main_flag,x),a
8216  17c0 2045          	jra	L1313
8217  17c2               L3743:
8218                     ; 2030 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8220  17c2 b6ce          	ld	a,_mess+7
8221  17c4 a1db          	cp	a,#219
8222  17c6 263f          	jrne	L1313
8224  17c8 b6cd          	ld	a,_mess+6
8225  17ca c100ff        	cp	a,_adress
8226  17cd 2738          	jreq	L1313
8228  17cf b6cd          	ld	a,_mess+6
8229  17d1 a106          	cp	a,#6
8230  17d3 2432          	jruge	L1313
8231                     ; 2032 	i_main_bps_cnt[mess[6]]=0;
8233  17d5 b6cd          	ld	a,_mess+6
8234  17d7 5f            	clrw	x
8235  17d8 97            	ld	xl,a
8236  17d9 6f13          	clr	(_i_main_bps_cnt,x)
8237                     ; 2033 	i_main_flag[mess[6]]=1;		
8239  17db b6cd          	ld	a,_mess+6
8240  17dd 5f            	clrw	x
8241  17de 97            	ld	xl,a
8242  17df a601          	ld	a,#1
8243  17e1 e71e          	ld	(_i_main_flag,x),a
8244                     ; 2034 	if(bMAIN)
8246                     	btst	_bMAIN
8247  17e8 241d          	jruge	L1313
8248                     ; 2036 		if(mess[9]==0)i_main_flag[i]=1;
8250  17ea 3dd0          	tnz	_mess+9
8251  17ec 260a          	jrne	L5053
8254  17ee 7b07          	ld	a,(OFST+0,sp)
8255  17f0 5f            	clrw	x
8256  17f1 97            	ld	xl,a
8257  17f2 a601          	ld	a,#1
8258  17f4 e71e          	ld	(_i_main_flag,x),a
8260  17f6 2006          	jra	L7053
8261  17f8               L5053:
8262                     ; 2037 		else i_main_flag[i]=0;
8264  17f8 7b07          	ld	a,(OFST+0,sp)
8265  17fa 5f            	clrw	x
8266  17fb 97            	ld	xl,a
8267  17fc 6f1e          	clr	(_i_main_flag,x)
8268  17fe               L7053:
8269                     ; 2038 		i_main_flag[adress]=1;
8271  17fe c600ff        	ld	a,_adress
8272  1801 5f            	clrw	x
8273  1802 97            	ld	xl,a
8274  1803 a601          	ld	a,#1
8275  1805 e71e          	ld	(_i_main_flag,x),a
8276  1807               L1313:
8277                     ; 2044 can_in_an_end:
8277                     ; 2045 bCAN_RX=0;
8279  1807 3f04          	clr	_bCAN_RX
8280                     ; 2046 }   
8283  1809 5b07          	addw	sp,#7
8284  180b 81            	ret
8307                     ; 2049 void t4_init(void){
8308                     	switch	.text
8309  180c               _t4_init:
8313                     ; 2050 	TIM4->PSCR = 6;
8315  180c 35065345      	mov	21317,#6
8316                     ; 2051 	TIM4->ARR= 61;
8318  1810 353d5346      	mov	21318,#61
8319                     ; 2052 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8321  1814 72105341      	bset	21313,#0
8322                     ; 2054 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8324  1818 35855340      	mov	21312,#133
8325                     ; 2056 }
8328  181c 81            	ret
8351                     ; 2059 void t1_init(void)
8351                     ; 2060 {
8352                     	switch	.text
8353  181d               _t1_init:
8357                     ; 2061 TIM1->ARRH= 0x07;
8359  181d 35075262      	mov	21090,#7
8360                     ; 2062 TIM1->ARRL= 0xff;
8362  1821 35ff5263      	mov	21091,#255
8363                     ; 2063 TIM1->CCR1H= 0x00;	
8365  1825 725f5265      	clr	21093
8366                     ; 2064 TIM1->CCR1L= 0xff;
8368  1829 35ff5266      	mov	21094,#255
8369                     ; 2065 TIM1->CCR2H= 0x00;	
8371  182d 725f5267      	clr	21095
8372                     ; 2066 TIM1->CCR2L= 0x00;
8374  1831 725f5268      	clr	21096
8375                     ; 2067 TIM1->CCR3H= 0x00;	
8377  1835 725f5269      	clr	21097
8378                     ; 2068 TIM1->CCR3L= 0x64;
8380  1839 3564526a      	mov	21098,#100
8381                     ; 2070 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8383  183d 35685258      	mov	21080,#104
8384                     ; 2071 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8386  1841 35685259      	mov	21081,#104
8387                     ; 2072 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8389  1845 3568525a      	mov	21082,#104
8390                     ; 2073 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8392  1849 3511525c      	mov	21084,#17
8393                     ; 2074 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8395  184d 3501525d      	mov	21085,#1
8396                     ; 2075 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8398  1851 35815250      	mov	21072,#129
8399                     ; 2076 TIM1->BKR|= TIM1_BKR_AOE;
8401  1855 721c526d      	bset	21101,#6
8402                     ; 2077 }
8405  1859 81            	ret
8430                     ; 2081 void adc2_init(void)
8430                     ; 2082 {
8431                     	switch	.text
8432  185a               _adc2_init:
8436                     ; 2083 adc_plazma[0]++;
8438  185a beb9          	ldw	x,_adc_plazma
8439  185c 1c0001        	addw	x,#1
8440  185f bfb9          	ldw	_adc_plazma,x
8441                     ; 2107 GPIOB->DDR&=~(1<<4);
8443  1861 72195007      	bres	20487,#4
8444                     ; 2108 GPIOB->CR1&=~(1<<4);
8446  1865 72195008      	bres	20488,#4
8447                     ; 2109 GPIOB->CR2&=~(1<<4);
8449  1869 72195009      	bres	20489,#4
8450                     ; 2111 GPIOB->DDR&=~(1<<5);
8452  186d 721b5007      	bres	20487,#5
8453                     ; 2112 GPIOB->CR1&=~(1<<5);
8455  1871 721b5008      	bres	20488,#5
8456                     ; 2113 GPIOB->CR2&=~(1<<5);
8458  1875 721b5009      	bres	20489,#5
8459                     ; 2115 GPIOB->DDR&=~(1<<6);
8461  1879 721d5007      	bres	20487,#6
8462                     ; 2116 GPIOB->CR1&=~(1<<6);
8464  187d 721d5008      	bres	20488,#6
8465                     ; 2117 GPIOB->CR2&=~(1<<6);
8467  1881 721d5009      	bres	20489,#6
8468                     ; 2119 GPIOB->DDR&=~(1<<7);
8470  1885 721f5007      	bres	20487,#7
8471                     ; 2120 GPIOB->CR1&=~(1<<7);
8473  1889 721f5008      	bres	20488,#7
8474                     ; 2121 GPIOB->CR2&=~(1<<7);
8476  188d 721f5009      	bres	20489,#7
8477                     ; 2123 GPIOB->DDR&=~(1<<2);
8479  1891 72155007      	bres	20487,#2
8480                     ; 2124 GPIOB->CR1&=~(1<<2);
8482  1895 72155008      	bres	20488,#2
8483                     ; 2125 GPIOB->CR2&=~(1<<2);
8485  1899 72155009      	bres	20489,#2
8486                     ; 2134 ADC2->TDRL=0xff;
8488  189d 35ff5407      	mov	21511,#255
8489                     ; 2136 ADC2->CR2=0x08;
8491  18a1 35085402      	mov	21506,#8
8492                     ; 2137 ADC2->CR1=0x60;
8494  18a5 35605401      	mov	21505,#96
8495                     ; 2140 	if(adc_ch==5)ADC2->CSR=0x22;
8497  18a9 b6c6          	ld	a,_adc_ch
8498  18ab a105          	cp	a,#5
8499  18ad 2606          	jrne	L1453
8502  18af 35225400      	mov	21504,#34
8504  18b3 2007          	jra	L3453
8505  18b5               L1453:
8506                     ; 2141 	else ADC2->CSR=0x20+adc_ch+3;
8508  18b5 b6c6          	ld	a,_adc_ch
8509  18b7 ab23          	add	a,#35
8510  18b9 c75400        	ld	21504,a
8511  18bc               L3453:
8512                     ; 2143 	ADC2->CR1|=1;
8514  18bc 72105401      	bset	21505,#0
8515                     ; 2144 	ADC2->CR1|=1;
8517  18c0 72105401      	bset	21505,#0
8518                     ; 2147 adc_plazma[1]=adc_ch;
8520  18c4 b6c6          	ld	a,_adc_ch
8521  18c6 5f            	clrw	x
8522  18c7 97            	ld	xl,a
8523  18c8 bfbb          	ldw	_adc_plazma+2,x
8524                     ; 2148 }
8527  18ca 81            	ret
8563                     ; 2156 @far @interrupt void TIM4_UPD_Interrupt (void) 
8563                     ; 2157 {
8565                     	switch	.text
8566  18cb               f_TIM4_UPD_Interrupt:
8570                     ; 2158 TIM4->SR1&=~TIM4_SR1_UIF;
8572  18cb 72115342      	bres	21314,#0
8573                     ; 2160 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8575  18cf 3c12          	inc	_pwm_vent_cnt
8576  18d1 b612          	ld	a,_pwm_vent_cnt
8577  18d3 a10a          	cp	a,#10
8578  18d5 2502          	jrult	L5553
8581  18d7 3f12          	clr	_pwm_vent_cnt
8582  18d9               L5553:
8583                     ; 2161 GPIOB->ODR|=(1<<3);
8585  18d9 72165005      	bset	20485,#3
8586                     ; 2162 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8588  18dd b612          	ld	a,_pwm_vent_cnt
8589  18df a105          	cp	a,#5
8590  18e1 2504          	jrult	L7553
8593  18e3 72175005      	bres	20485,#3
8594  18e7               L7553:
8595                     ; 2166 if(++t0_cnt00>=10)
8597  18e7 9c            	rvf
8598  18e8 ce0000        	ldw	x,_t0_cnt00
8599  18eb 1c0001        	addw	x,#1
8600  18ee cf0000        	ldw	_t0_cnt00,x
8601  18f1 a3000a        	cpw	x,#10
8602  18f4 2f08          	jrslt	L1653
8603                     ; 2168 	t0_cnt00=0;
8605  18f6 5f            	clrw	x
8606  18f7 cf0000        	ldw	_t0_cnt00,x
8607                     ; 2169 	b1000Hz=1;
8609  18fa 72100004      	bset	_b1000Hz
8610  18fe               L1653:
8611                     ; 2172 if(++t0_cnt0>=100)
8613  18fe 9c            	rvf
8614  18ff ce0002        	ldw	x,_t0_cnt0
8615  1902 1c0001        	addw	x,#1
8616  1905 cf0002        	ldw	_t0_cnt0,x
8617  1908 a30064        	cpw	x,#100
8618  190b 2f54          	jrslt	L3653
8619                     ; 2174 	t0_cnt0=0;
8621  190d 5f            	clrw	x
8622  190e cf0002        	ldw	_t0_cnt0,x
8623                     ; 2175 	b100Hz=1;
8625  1911 72100009      	bset	_b100Hz
8626                     ; 2177 	if(++t0_cnt1>=10)
8628  1915 725c0004      	inc	_t0_cnt1
8629  1919 c60004        	ld	a,_t0_cnt1
8630  191c a10a          	cp	a,#10
8631  191e 2508          	jrult	L5653
8632                     ; 2179 		t0_cnt1=0;
8634  1920 725f0004      	clr	_t0_cnt1
8635                     ; 2180 		b10Hz=1;
8637  1924 72100008      	bset	_b10Hz
8638  1928               L5653:
8639                     ; 2183 	if(++t0_cnt2>=20)
8641  1928 725c0005      	inc	_t0_cnt2
8642  192c c60005        	ld	a,_t0_cnt2
8643  192f a114          	cp	a,#20
8644  1931 2508          	jrult	L7653
8645                     ; 2185 		t0_cnt2=0;
8647  1933 725f0005      	clr	_t0_cnt2
8648                     ; 2186 		b5Hz=1;
8650  1937 72100007      	bset	_b5Hz
8651  193b               L7653:
8652                     ; 2190 	if(++t0_cnt4>=50)
8654  193b 725c0007      	inc	_t0_cnt4
8655  193f c60007        	ld	a,_t0_cnt4
8656  1942 a132          	cp	a,#50
8657  1944 2508          	jrult	L1753
8658                     ; 2192 		t0_cnt4=0;
8660  1946 725f0007      	clr	_t0_cnt4
8661                     ; 2193 		b2Hz=1;
8663  194a 72100006      	bset	_b2Hz
8664  194e               L1753:
8665                     ; 2196 	if(++t0_cnt3>=100)
8667  194e 725c0006      	inc	_t0_cnt3
8668  1952 c60006        	ld	a,_t0_cnt3
8669  1955 a164          	cp	a,#100
8670  1957 2508          	jrult	L3653
8671                     ; 2198 		t0_cnt3=0;
8673  1959 725f0006      	clr	_t0_cnt3
8674                     ; 2199 		b1Hz=1;
8676  195d 72100005      	bset	_b1Hz
8677  1961               L3653:
8678                     ; 2205 }
8681  1961 80            	iret
8706                     ; 2208 @far @interrupt void CAN_RX_Interrupt (void) 
8706                     ; 2209 {
8707                     	switch	.text
8708  1962               f_CAN_RX_Interrupt:
8712                     ; 2211 CAN->PSR= 7;									// page 7 - read messsage
8714  1962 35075427      	mov	21543,#7
8715                     ; 2213 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8717  1966 ae000e        	ldw	x,#14
8718  1969               L042:
8719  1969 d65427        	ld	a,(21543,x)
8720  196c e7c6          	ld	(_mess-1,x),a
8721  196e 5a            	decw	x
8722  196f 26f8          	jrne	L042
8723                     ; 2224 bCAN_RX=1;
8725  1971 35010004      	mov	_bCAN_RX,#1
8726                     ; 2225 CAN->RFR|=(1<<5);
8728  1975 721a5424      	bset	21540,#5
8729                     ; 2227 }
8732  1979 80            	iret
8755                     ; 2230 @far @interrupt void CAN_TX_Interrupt (void) 
8755                     ; 2231 {
8756                     	switch	.text
8757  197a               f_CAN_TX_Interrupt:
8761                     ; 2232 if((CAN->TSR)&(1<<0))
8763  197a c65422        	ld	a,21538
8764  197d a501          	bcp	a,#1
8765  197f 2708          	jreq	L5163
8766                     ; 2234 	bTX_FREE=1;	
8768  1981 35010003      	mov	_bTX_FREE,#1
8769                     ; 2236 	CAN->TSR|=(1<<0);
8771  1985 72105422      	bset	21538,#0
8772  1989               L5163:
8773                     ; 2238 }
8776  1989 80            	iret
8856                     ; 2241 @far @interrupt void ADC2_EOC_Interrupt (void) {
8857                     	switch	.text
8858  198a               f_ADC2_EOC_Interrupt:
8860       0000000d      OFST:	set	13
8861  198a be00          	ldw	x,c_x
8862  198c 89            	pushw	x
8863  198d be00          	ldw	x,c_y
8864  198f 89            	pushw	x
8865  1990 be02          	ldw	x,c_lreg+2
8866  1992 89            	pushw	x
8867  1993 be00          	ldw	x,c_lreg
8868  1995 89            	pushw	x
8869  1996 520d          	subw	sp,#13
8872                     ; 2246 adc_plazma[2]++;
8874  1998 bebd          	ldw	x,_adc_plazma+4
8875  199a 1c0001        	addw	x,#1
8876  199d bfbd          	ldw	_adc_plazma+4,x
8877                     ; 2253 ADC2->CSR&=~(1<<7);
8879  199f 721f5400      	bres	21504,#7
8880                     ; 2255 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8882  19a3 c65405        	ld	a,21509
8883  19a6 b703          	ld	c_lreg+3,a
8884  19a8 3f02          	clr	c_lreg+2
8885  19aa 3f01          	clr	c_lreg+1
8886  19ac 3f00          	clr	c_lreg
8887  19ae 96            	ldw	x,sp
8888  19af 1c0001        	addw	x,#OFST-12
8889  19b2 cd0000        	call	c_rtol
8891  19b5 c65404        	ld	a,21508
8892  19b8 5f            	clrw	x
8893  19b9 97            	ld	xl,a
8894  19ba 90ae0100      	ldw	y,#256
8895  19be cd0000        	call	c_umul
8897  19c1 96            	ldw	x,sp
8898  19c2 1c0001        	addw	x,#OFST-12
8899  19c5 cd0000        	call	c_ladd
8901  19c8 96            	ldw	x,sp
8902  19c9 1c000a        	addw	x,#OFST-3
8903  19cc cd0000        	call	c_rtol
8905                     ; 2260 if(adr_drv_stat==1)
8907  19cf b602          	ld	a,_adr_drv_stat
8908  19d1 a101          	cp	a,#1
8909  19d3 260b          	jrne	L5563
8910                     ; 2262 	adr_drv_stat=2;
8912  19d5 35020002      	mov	_adr_drv_stat,#2
8913                     ; 2263 	adc_buff_[0]=temp_adc;
8915  19d9 1e0c          	ldw	x,(OFST-1,sp)
8916  19db cf0107        	ldw	_adc_buff_,x
8918  19de 2020          	jra	L7563
8919  19e0               L5563:
8920                     ; 2266 else if(adr_drv_stat==3)
8922  19e0 b602          	ld	a,_adr_drv_stat
8923  19e2 a103          	cp	a,#3
8924  19e4 260b          	jrne	L1663
8925                     ; 2268 	adr_drv_stat=4;
8927  19e6 35040002      	mov	_adr_drv_stat,#4
8928                     ; 2269 	adc_buff_[1]=temp_adc;
8930  19ea 1e0c          	ldw	x,(OFST-1,sp)
8931  19ec cf0109        	ldw	_adc_buff_+2,x
8933  19ef 200f          	jra	L7563
8934  19f1               L1663:
8935                     ; 2272 else if(adr_drv_stat==5)
8937  19f1 b602          	ld	a,_adr_drv_stat
8938  19f3 a105          	cp	a,#5
8939  19f5 2609          	jrne	L7563
8940                     ; 2274 	adr_drv_stat=6;
8942  19f7 35060002      	mov	_adr_drv_stat,#6
8943                     ; 2275 	adc_buff_[9]=temp_adc;
8945  19fb 1e0c          	ldw	x,(OFST-1,sp)
8946  19fd cf0119        	ldw	_adc_buff_+18,x
8947  1a00               L7563:
8948                     ; 2278 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8950  1a00 b6b7          	ld	a,_adc_cnt_cnt
8951  1a02 5f            	clrw	x
8952  1a03 97            	ld	xl,a
8953  1a04 58            	sllw	x
8954  1a05 1f03          	ldw	(OFST-10,sp),x
8955  1a07 b6c6          	ld	a,_adc_ch
8956  1a09 97            	ld	xl,a
8957  1a0a a610          	ld	a,#16
8958  1a0c 42            	mul	x,a
8959  1a0d 72fb03        	addw	x,(OFST-10,sp)
8960  1a10 160c          	ldw	y,(OFST-1,sp)
8961  1a12 df005e        	ldw	(_adc_buff_buff,x),y
8962                     ; 2280 adc_ch++;
8964  1a15 3cc6          	inc	_adc_ch
8965                     ; 2281 if(adc_ch>=6)
8967  1a17 b6c6          	ld	a,_adc_ch
8968  1a19 a106          	cp	a,#6
8969  1a1b 2516          	jrult	L7663
8970                     ; 2283 	adc_ch=0;
8972  1a1d 3fc6          	clr	_adc_ch
8973                     ; 2284 	adc_cnt_cnt++;
8975  1a1f 3cb7          	inc	_adc_cnt_cnt
8976                     ; 2285 	if(adc_cnt_cnt>=8)
8978  1a21 b6b7          	ld	a,_adc_cnt_cnt
8979  1a23 a108          	cp	a,#8
8980  1a25 250c          	jrult	L7663
8981                     ; 2287 		adc_cnt_cnt=0;
8983  1a27 3fb7          	clr	_adc_cnt_cnt
8984                     ; 2288 		adc_cnt++;
8986  1a29 3cc5          	inc	_adc_cnt
8987                     ; 2289 		if(adc_cnt>=16)
8989  1a2b b6c5          	ld	a,_adc_cnt
8990  1a2d a110          	cp	a,#16
8991  1a2f 2502          	jrult	L7663
8992                     ; 2291 			adc_cnt=0;
8994  1a31 3fc5          	clr	_adc_cnt
8995  1a33               L7663:
8996                     ; 2295 if(adc_cnt_cnt==0)
8998  1a33 3db7          	tnz	_adc_cnt_cnt
8999  1a35 2660          	jrne	L5763
9000                     ; 2299 	tempSS=0;
9002  1a37 ae0000        	ldw	x,#0
9003  1a3a 1f07          	ldw	(OFST-6,sp),x
9004  1a3c ae0000        	ldw	x,#0
9005  1a3f 1f05          	ldw	(OFST-8,sp),x
9006                     ; 2300 	for(i=0;i<8;i++)
9008  1a41 0f09          	clr	(OFST-4,sp)
9009  1a43               L7763:
9010                     ; 2302 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9012  1a43 7b09          	ld	a,(OFST-4,sp)
9013  1a45 5f            	clrw	x
9014  1a46 97            	ld	xl,a
9015  1a47 58            	sllw	x
9016  1a48 1f03          	ldw	(OFST-10,sp),x
9017  1a4a b6c6          	ld	a,_adc_ch
9018  1a4c 97            	ld	xl,a
9019  1a4d a610          	ld	a,#16
9020  1a4f 42            	mul	x,a
9021  1a50 72fb03        	addw	x,(OFST-10,sp)
9022  1a53 de005e        	ldw	x,(_adc_buff_buff,x)
9023  1a56 cd0000        	call	c_itolx
9025  1a59 96            	ldw	x,sp
9026  1a5a 1c0005        	addw	x,#OFST-8
9027  1a5d cd0000        	call	c_lgadd
9029                     ; 2300 	for(i=0;i<8;i++)
9031  1a60 0c09          	inc	(OFST-4,sp)
9034  1a62 7b09          	ld	a,(OFST-4,sp)
9035  1a64 a108          	cp	a,#8
9036  1a66 25db          	jrult	L7763
9037                     ; 2304 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9039  1a68 96            	ldw	x,sp
9040  1a69 1c0005        	addw	x,#OFST-8
9041  1a6c cd0000        	call	c_ltor
9043  1a6f a603          	ld	a,#3
9044  1a71 cd0000        	call	c_lrsh
9046  1a74 be02          	ldw	x,c_lreg+2
9047  1a76 b6c5          	ld	a,_adc_cnt
9048  1a78 905f          	clrw	y
9049  1a7a 9097          	ld	yl,a
9050  1a7c 9058          	sllw	y
9051  1a7e 1703          	ldw	(OFST-10,sp),y
9052  1a80 b6c6          	ld	a,_adc_ch
9053  1a82 905f          	clrw	y
9054  1a84 9097          	ld	yl,a
9055  1a86 9058          	sllw	y
9056  1a88 9058          	sllw	y
9057  1a8a 9058          	sllw	y
9058  1a8c 9058          	sllw	y
9059  1a8e 9058          	sllw	y
9060  1a90 72f903        	addw	y,(OFST-10,sp)
9061  1a93 90df011b      	ldw	(_adc_buff,y),x
9062  1a97               L5763:
9063                     ; 2308 if((adc_cnt&0x03)==0)
9065  1a97 b6c5          	ld	a,_adc_cnt
9066  1a99 a503          	bcp	a,#3
9067  1a9b 264b          	jrne	L5073
9068                     ; 2312 	tempSS=0;
9070  1a9d ae0000        	ldw	x,#0
9071  1aa0 1f07          	ldw	(OFST-6,sp),x
9072  1aa2 ae0000        	ldw	x,#0
9073  1aa5 1f05          	ldw	(OFST-8,sp),x
9074                     ; 2313 	for(i=0;i<16;i++)
9076  1aa7 0f09          	clr	(OFST-4,sp)
9077  1aa9               L7073:
9078                     ; 2315 		tempSS+=(signed long)adc_buff[adc_ch][i];
9080  1aa9 7b09          	ld	a,(OFST-4,sp)
9081  1aab 5f            	clrw	x
9082  1aac 97            	ld	xl,a
9083  1aad 58            	sllw	x
9084  1aae 1f03          	ldw	(OFST-10,sp),x
9085  1ab0 b6c6          	ld	a,_adc_ch
9086  1ab2 97            	ld	xl,a
9087  1ab3 a620          	ld	a,#32
9088  1ab5 42            	mul	x,a
9089  1ab6 72fb03        	addw	x,(OFST-10,sp)
9090  1ab9 de011b        	ldw	x,(_adc_buff,x)
9091  1abc cd0000        	call	c_itolx
9093  1abf 96            	ldw	x,sp
9094  1ac0 1c0005        	addw	x,#OFST-8
9095  1ac3 cd0000        	call	c_lgadd
9097                     ; 2313 	for(i=0;i<16;i++)
9099  1ac6 0c09          	inc	(OFST-4,sp)
9102  1ac8 7b09          	ld	a,(OFST-4,sp)
9103  1aca a110          	cp	a,#16
9104  1acc 25db          	jrult	L7073
9105                     ; 2317 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9107  1ace 96            	ldw	x,sp
9108  1acf 1c0005        	addw	x,#OFST-8
9109  1ad2 cd0000        	call	c_ltor
9111  1ad5 a604          	ld	a,#4
9112  1ad7 cd0000        	call	c_lrsh
9114  1ada be02          	ldw	x,c_lreg+2
9115  1adc b6c6          	ld	a,_adc_ch
9116  1ade 905f          	clrw	y
9117  1ae0 9097          	ld	yl,a
9118  1ae2 9058          	sllw	y
9119  1ae4 90df0107      	ldw	(_adc_buff_,y),x
9120  1ae8               L5073:
9121                     ; 2324 if(adc_ch==0)adc_buff_5=temp_adc;
9123  1ae8 3dc6          	tnz	_adc_ch
9124  1aea 2605          	jrne	L5173
9127  1aec 1e0c          	ldw	x,(OFST-1,sp)
9128  1aee cf0105        	ldw	_adc_buff_5,x
9129  1af1               L5173:
9130                     ; 2325 if(adc_ch==2)adc_buff_1=temp_adc;
9132  1af1 b6c6          	ld	a,_adc_ch
9133  1af3 a102          	cp	a,#2
9134  1af5 2605          	jrne	L7173
9137  1af7 1e0c          	ldw	x,(OFST-1,sp)
9138  1af9 cf0103        	ldw	_adc_buff_1,x
9139  1afc               L7173:
9140                     ; 2327 adc_plazma_short++;
9142  1afc bec3          	ldw	x,_adc_plazma_short
9143  1afe 1c0001        	addw	x,#1
9144  1b01 bfc3          	ldw	_adc_plazma_short,x
9145                     ; 2329 }
9148  1b03 5b0d          	addw	sp,#13
9149  1b05 85            	popw	x
9150  1b06 bf00          	ldw	c_lreg,x
9151  1b08 85            	popw	x
9152  1b09 bf02          	ldw	c_lreg+2,x
9153  1b0b 85            	popw	x
9154  1b0c bf00          	ldw	c_y,x
9155  1b0e 85            	popw	x
9156  1b0f bf00          	ldw	c_x,x
9157  1b11 80            	iret
9216                     ; 2338 main()
9216                     ; 2339 {
9218                     	switch	.text
9219  1b12               _main:
9223                     ; 2341 CLK->ECKR|=1;
9225  1b12 721050c1      	bset	20673,#0
9227  1b16               L3373:
9228                     ; 2342 while((CLK->ECKR & 2) == 0);
9230  1b16 c650c1        	ld	a,20673
9231  1b19 a502          	bcp	a,#2
9232  1b1b 27f9          	jreq	L3373
9233                     ; 2343 CLK->SWCR|=2;
9235  1b1d 721250c5      	bset	20677,#1
9236                     ; 2344 CLK->SWR=0xB4;
9238  1b21 35b450c4      	mov	20676,#180
9239                     ; 2346 delay_ms(200);
9241  1b25 ae00c8        	ldw	x,#200
9242  1b28 cd0121        	call	_delay_ms
9244                     ; 2347 FLASH_DUKR=0xae;
9246  1b2b 35ae5064      	mov	_FLASH_DUKR,#174
9247                     ; 2348 FLASH_DUKR=0x56;
9249  1b2f 35565064      	mov	_FLASH_DUKR,#86
9250                     ; 2349 enableInterrupts();
9253  1b33 9a            rim
9255                     ; 2352 adr_drv_v3();
9258  1b34 cd0e12        	call	_adr_drv_v3
9260                     ; 2356 t4_init();
9262  1b37 cd180c        	call	_t4_init
9264                     ; 2358 		GPIOG->DDR|=(1<<0);
9266  1b3a 72105020      	bset	20512,#0
9267                     ; 2359 		GPIOG->CR1|=(1<<0);
9269  1b3e 72105021      	bset	20513,#0
9270                     ; 2360 		GPIOG->CR2&=~(1<<0);	
9272  1b42 72115022      	bres	20514,#0
9273                     ; 2363 		GPIOG->DDR&=~(1<<1);
9275  1b46 72135020      	bres	20512,#1
9276                     ; 2364 		GPIOG->CR1|=(1<<1);
9278  1b4a 72125021      	bset	20513,#1
9279                     ; 2365 		GPIOG->CR2&=~(1<<1);
9281  1b4e 72135022      	bres	20514,#1
9282                     ; 2367 init_CAN();
9284  1b52 cd1002        	call	_init_CAN
9286                     ; 2372 GPIOC->DDR|=(1<<1);
9288  1b55 7212500c      	bset	20492,#1
9289                     ; 2373 GPIOC->CR1|=(1<<1);
9291  1b59 7212500d      	bset	20493,#1
9292                     ; 2374 GPIOC->CR2|=(1<<1);
9294  1b5d 7212500e      	bset	20494,#1
9295                     ; 2376 GPIOC->DDR|=(1<<2);
9297  1b61 7214500c      	bset	20492,#2
9298                     ; 2377 GPIOC->CR1|=(1<<2);
9300  1b65 7214500d      	bset	20493,#2
9301                     ; 2378 GPIOC->CR2|=(1<<2);
9303  1b69 7214500e      	bset	20494,#2
9304                     ; 2385 t1_init();
9306  1b6d cd181d        	call	_t1_init
9308                     ; 2387 GPIOA->DDR|=(1<<5);
9310  1b70 721a5002      	bset	20482,#5
9311                     ; 2388 GPIOA->CR1|=(1<<5);
9313  1b74 721a5003      	bset	20483,#5
9314                     ; 2389 GPIOA->CR2&=~(1<<5);
9316  1b78 721b5004      	bres	20484,#5
9317                     ; 2395 GPIOB->DDR&=~(1<<3);
9319  1b7c 72175007      	bres	20487,#3
9320                     ; 2396 GPIOB->CR1&=~(1<<3);
9322  1b80 72175008      	bres	20488,#3
9323                     ; 2397 GPIOB->CR2&=~(1<<3);
9325  1b84 72175009      	bres	20489,#3
9326                     ; 2399 GPIOC->DDR|=(1<<3);
9328  1b88 7216500c      	bset	20492,#3
9329                     ; 2400 GPIOC->CR1|=(1<<3);
9331  1b8c 7216500d      	bset	20493,#3
9332                     ; 2401 GPIOC->CR2|=(1<<3);
9334  1b90 7216500e      	bset	20494,#3
9335  1b94               L7373:
9336                     ; 2407 	if(b1000Hz)
9338                     	btst	_b1000Hz
9339  1b99 2407          	jruge	L3473
9340                     ; 2409 		b1000Hz=0;
9342  1b9b 72110004      	bres	_b1000Hz
9343                     ; 2411 		adc2_init();
9345  1b9f cd185a        	call	_adc2_init
9347  1ba2               L3473:
9348                     ; 2414 	if(bCAN_RX)
9350  1ba2 3d04          	tnz	_bCAN_RX
9351  1ba4 2705          	jreq	L5473
9352                     ; 2416 		bCAN_RX=0;
9354  1ba6 3f04          	clr	_bCAN_RX
9355                     ; 2417 		can_in_an();	
9357  1ba8 cd115f        	call	_can_in_an
9359  1bab               L5473:
9360                     ; 2419 	if(b100Hz)
9362                     	btst	_b100Hz
9363  1bb0 2407          	jruge	L7473
9364                     ; 2421 		b100Hz=0;
9366  1bb2 72110009      	bres	_b100Hz
9367                     ; 2431 		can_tx_hndl();
9369  1bb6 cd10f5        	call	_can_tx_hndl
9371  1bb9               L7473:
9372                     ; 2434 	if(b10Hz)
9374                     	btst	_b10Hz
9375  1bbe 2425          	jruge	L1573
9376                     ; 2436 		b10Hz=0;
9378  1bc0 72110008      	bres	_b10Hz
9379                     ; 2438 		matemat();
9381  1bc4 cd0934        	call	_matemat
9383                     ; 2439 		led_drv(); 
9385  1bc7 cd03ee        	call	_led_drv
9387                     ; 2440 	  link_drv();
9389  1bca cd04dc        	call	_link_drv
9391                     ; 2442 	  JP_drv();
9393  1bcd cd0451        	call	_JP_drv
9395                     ; 2443 	  flags_drv();
9397  1bd0 cd0dc7        	call	_flags_drv
9399                     ; 2445 		if(main_cnt10<100)main_cnt10++;
9401  1bd3 9c            	rvf
9402  1bd4 ce025b        	ldw	x,_main_cnt10
9403  1bd7 a30064        	cpw	x,#100
9404  1bda 2e09          	jrsge	L1573
9407  1bdc ce025b        	ldw	x,_main_cnt10
9408  1bdf 1c0001        	addw	x,#1
9409  1be2 cf025b        	ldw	_main_cnt10,x
9410  1be5               L1573:
9411                     ; 2448 	if(b5Hz)
9413                     	btst	_b5Hz
9414  1bea 241c          	jruge	L5573
9415                     ; 2450 		b5Hz=0;
9417  1bec 72110007      	bres	_b5Hz
9418                     ; 2456 		pwr_drv();		//воздействие на силу
9420  1bf0 cd06ac        	call	_pwr_drv
9422                     ; 2457 		led_hndl();
9424  1bf3 cd0163        	call	_led_hndl
9426                     ; 2459 		vent_drv();
9428  1bf6 cd0534        	call	_vent_drv
9430                     ; 2461 		if(main_cnt1<1000)main_cnt1++;
9432  1bf9 9c            	rvf
9433  1bfa be5b          	ldw	x,_main_cnt1
9434  1bfc a303e8        	cpw	x,#1000
9435  1bff 2e07          	jrsge	L5573
9438  1c01 be5b          	ldw	x,_main_cnt1
9439  1c03 1c0001        	addw	x,#1
9440  1c06 bf5b          	ldw	_main_cnt1,x
9441  1c08               L5573:
9442                     ; 2464 	if(b2Hz)
9444                     	btst	_b2Hz
9445  1c0d 2404          	jruge	L1673
9446                     ; 2466 		b2Hz=0;
9448  1c0f 72110006      	bres	_b2Hz
9449  1c13               L1673:
9450                     ; 2475 	if(b1Hz)
9452                     	btst	_b1Hz
9453  1c18 2503cc1b94    	jruge	L7373
9454                     ; 2477 		b1Hz=0;
9456  1c1d 72110005      	bres	_b1Hz
9457                     ; 2479 	  pwr_hndl();		//вычисление воздействий на силу
9459  1c21 cd07e5        	call	_pwr_hndl
9461                     ; 2480 		temper_drv();			//вычисление аварий температуры
9463  1c24 cd0b34        	call	_temper_drv
9465                     ; 2481 		u_drv();
9467  1c27 cd0c0b        	call	_u_drv
9469                     ; 2483 		if(main_cnt<1000)main_cnt++;
9471  1c2a 9c            	rvf
9472  1c2b ce025d        	ldw	x,_main_cnt
9473  1c2e a303e8        	cpw	x,#1000
9474  1c31 2e09          	jrsge	L5673
9477  1c33 ce025d        	ldw	x,_main_cnt
9478  1c36 1c0001        	addw	x,#1
9479  1c39 cf025d        	ldw	_main_cnt,x
9480  1c3c               L5673:
9481                     ; 2484   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9483  1c3c b66d          	ld	a,_link
9484  1c3e a1aa          	cp	a,#170
9485  1c40 2706          	jreq	L1773
9487  1c42 b654          	ld	a,_jp_mode
9488  1c44 a103          	cp	a,#3
9489  1c46 2603          	jrne	L7673
9490  1c48               L1773:
9493  1c48 cd0d28        	call	_apv_hndl
9495  1c4b               L7673:
9496                     ; 2487   		can_error_cnt++;
9498  1c4b 3c73          	inc	_can_error_cnt
9499                     ; 2488   		if(can_error_cnt>=10)
9501  1c4d b673          	ld	a,_can_error_cnt
9502  1c4f a10a          	cp	a,#10
9503  1c51 2505          	jrult	L3773
9504                     ; 2490   			can_error_cnt=0;
9506  1c53 3f73          	clr	_can_error_cnt
9507                     ; 2491 				init_CAN();
9509  1c55 cd1002        	call	_init_CAN
9511  1c58               L3773:
9512                     ; 2501 		vent_resurs_hndl();
9514  1c58 cd0000        	call	_vent_resurs_hndl
9516                     ; 2502 		alfa_hndl();
9518  1c5b cd0724        	call	_alfa_hndl
9520  1c5e ac941b94      	jpf	L7373
10795                     	xdef	_main
10796                     	xdef	f_ADC2_EOC_Interrupt
10797                     	xdef	f_CAN_TX_Interrupt
10798                     	xdef	f_CAN_RX_Interrupt
10799                     	xdef	f_TIM4_UPD_Interrupt
10800                     	xdef	_adc2_init
10801                     	xdef	_t1_init
10802                     	xdef	_t4_init
10803                     	xdef	_can_in_an
10804                     	xdef	_can_tx_hndl
10805                     	xdef	_can_transmit
10806                     	xdef	_init_CAN
10807                     	xdef	_adr_drv_v3
10808                     	xdef	_adr_drv_v4
10809                     	xdef	_flags_drv
10810                     	xdef	_apv_hndl
10811                     	xdef	_apv_stop
10812                     	xdef	_apv_start
10813                     	xdef	_u_drv
10814                     	xdef	_temper_drv
10815                     	xdef	_matemat
10816                     	xdef	_pwr_hndl
10817                     	xdef	_alfa_hndl
10818                     	xdef	_pwr_drv
10819                     	xdef	_vent_drv
10820                     	xdef	_link_drv
10821                     	xdef	_JP_drv
10822                     	xdef	_led_drv
10823                     	xdef	_led_hndl
10824                     	xdef	_delay_ms
10825                     	xdef	_granee
10826                     	xdef	_gran
10827                     	xdef	_vent_resurs_hndl
10828                     	switch	.bss
10829  0000               _alfa_pwm_max_i_cnt__:
10830  0000 0000          	ds.b	2
10831                     	xdef	_alfa_pwm_max_i_cnt__
10832  0002               _alfa_pwm_max_i_cnt:
10833  0002 0000          	ds.b	2
10834                     	xdef	_alfa_pwm_max_i_cnt
10835  0004               _alfa_pwm_max_i:
10836  0004 0000          	ds.b	2
10837                     	xdef	_alfa_pwm_max_i
10838  0006               _alfa_pwm_max_t:
10839  0006 0000          	ds.b	2
10840                     	xdef	_alfa_pwm_max_t
10841                     	switch	.ubsct
10842  0001               _debug_info_to_uku:
10843  0001 000000000000  	ds.b	6
10844                     	xdef	_debug_info_to_uku
10845  0007               _pwm_u_cnt:
10846  0007 00            	ds.b	1
10847                     	xdef	_pwm_u_cnt
10848  0008               _vent_resurs_tx_cnt:
10849  0008 00            	ds.b	1
10850                     	xdef	_vent_resurs_tx_cnt
10851                     	switch	.bss
10852  0008               _vent_resurs_buff:
10853  0008 00000000      	ds.b	4
10854                     	xdef	_vent_resurs_buff
10855                     	switch	.ubsct
10856  0009               _vent_resurs_sec_cnt:
10857  0009 0000          	ds.b	2
10858                     	xdef	_vent_resurs_sec_cnt
10859                     .eeprom:	section	.data
10860  0000               _vent_resurs:
10861  0000 0000          	ds.b	2
10862                     	xdef	_vent_resurs
10863  0002               _ee_IMAXVENT:
10864  0002 0000          	ds.b	2
10865                     	xdef	_ee_IMAXVENT
10866                     	switch	.ubsct
10867  000b               _bps_class:
10868  000b 00            	ds.b	1
10869                     	xdef	_bps_class
10870  000c               _vent_pwm_integr_cnt:
10871  000c 0000          	ds.b	2
10872                     	xdef	_vent_pwm_integr_cnt
10873  000e               _vent_pwm_integr:
10874  000e 0000          	ds.b	2
10875                     	xdef	_vent_pwm_integr
10876  0010               _vent_pwm:
10877  0010 0000          	ds.b	2
10878                     	xdef	_vent_pwm
10879  0012               _pwm_vent_cnt:
10880  0012 00            	ds.b	1
10881                     	xdef	_pwm_vent_cnt
10882                     	switch	.eeprom
10883  0004               _ee_DEVICE:
10884  0004 0000          	ds.b	2
10885                     	xdef	_ee_DEVICE
10886  0006               _ee_AVT_MODE:
10887  0006 0000          	ds.b	2
10888                     	xdef	_ee_AVT_MODE
10889                     	switch	.ubsct
10890  0013               _i_main_bps_cnt:
10891  0013 000000000000  	ds.b	6
10892                     	xdef	_i_main_bps_cnt
10893  0019               _i_main_sigma:
10894  0019 0000          	ds.b	2
10895                     	xdef	_i_main_sigma
10896  001b               _i_main_num_of_bps:
10897  001b 00            	ds.b	1
10898                     	xdef	_i_main_num_of_bps
10899  001c               _i_main_avg:
10900  001c 0000          	ds.b	2
10901                     	xdef	_i_main_avg
10902  001e               _i_main_flag:
10903  001e 000000000000  	ds.b	6
10904                     	xdef	_i_main_flag
10905  0024               _i_main:
10906  0024 000000000000  	ds.b	12
10907                     	xdef	_i_main
10908  0030               _x:
10909  0030 000000000000  	ds.b	12
10910                     	xdef	_x
10911                     	xdef	_volum_u_main_
10912                     	switch	.eeprom
10913  0008               _UU_AVT:
10914  0008 0000          	ds.b	2
10915                     	xdef	_UU_AVT
10916                     	switch	.ubsct
10917  003c               _cnt_net_drv:
10918  003c 00            	ds.b	1
10919                     	xdef	_cnt_net_drv
10920                     	switch	.bit
10921  0001               _bMAIN:
10922  0001 00            	ds.b	1
10923                     	xdef	_bMAIN
10924                     	switch	.ubsct
10925  003d               _plazma_int:
10926  003d 000000000000  	ds.b	6
10927                     	xdef	_plazma_int
10928                     	xdef	_rotor_int
10929  0043               _led_green_buff:
10930  0043 00000000      	ds.b	4
10931                     	xdef	_led_green_buff
10932  0047               _led_red_buff:
10933  0047 00000000      	ds.b	4
10934                     	xdef	_led_red_buff
10935                     	xdef	_led_drv_cnt
10936                     	xdef	_led_green
10937                     	xdef	_led_red
10938  004b               _res_fl_cnt:
10939  004b 00            	ds.b	1
10940                     	xdef	_res_fl_cnt
10941                     	xdef	_bRES_
10942                     	xdef	_bRES
10943                     	switch	.eeprom
10944  000a               _res_fl_:
10945  000a 00            	ds.b	1
10946                     	xdef	_res_fl_
10947  000b               _res_fl:
10948  000b 00            	ds.b	1
10949                     	xdef	_res_fl
10950                     	switch	.ubsct
10951  004c               _cnt_apv_off:
10952  004c 00            	ds.b	1
10953                     	xdef	_cnt_apv_off
10954                     	switch	.bit
10955  0002               _bAPV:
10956  0002 00            	ds.b	1
10957                     	xdef	_bAPV
10958                     	switch	.ubsct
10959  004d               _apv_cnt_:
10960  004d 0000          	ds.b	2
10961                     	xdef	_apv_cnt_
10962  004f               _apv_cnt:
10963  004f 000000        	ds.b	3
10964                     	xdef	_apv_cnt
10965                     	xdef	_bBL_IPS
10966                     	switch	.bit
10967  0003               _bBL:
10968  0003 00            	ds.b	1
10969                     	xdef	_bBL
10970                     	switch	.ubsct
10971  0052               _cnt_JP1:
10972  0052 00            	ds.b	1
10973                     	xdef	_cnt_JP1
10974  0053               _cnt_JP0:
10975  0053 00            	ds.b	1
10976                     	xdef	_cnt_JP0
10977  0054               _jp_mode:
10978  0054 00            	ds.b	1
10979                     	xdef	_jp_mode
10980  0055               _pwm_u_:
10981  0055 0000          	ds.b	2
10982                     	xdef	_pwm_u_
10983                     	xdef	_pwm_i
10984                     	xdef	_pwm_u
10985  0057               _tmax_cnt:
10986  0057 0000          	ds.b	2
10987                     	xdef	_tmax_cnt
10988  0059               _tsign_cnt:
10989  0059 0000          	ds.b	2
10990                     	xdef	_tsign_cnt
10991                     	switch	.eeprom
10992  000c               _ee_UAVT:
10993  000c 0000          	ds.b	2
10994                     	xdef	_ee_UAVT
10995  000e               _ee_tsign:
10996  000e 0000          	ds.b	2
10997                     	xdef	_ee_tsign
10998  0010               _ee_tmax:
10999  0010 0000          	ds.b	2
11000                     	xdef	_ee_tmax
11001  0012               _ee_dU:
11002  0012 0000          	ds.b	2
11003                     	xdef	_ee_dU
11004  0014               _ee_Umax:
11005  0014 0000          	ds.b	2
11006                     	xdef	_ee_Umax
11007  0016               _ee_TZAS:
11008  0016 0000          	ds.b	2
11009                     	xdef	_ee_TZAS
11010                     	switch	.ubsct
11011  005b               _main_cnt1:
11012  005b 0000          	ds.b	2
11013                     	xdef	_main_cnt1
11014  005d               _off_bp_cnt:
11015  005d 00            	ds.b	1
11016                     	xdef	_off_bp_cnt
11017                     	xdef	_vol_i_temp_avar
11018  005e               _flags_tu_cnt_off:
11019  005e 00            	ds.b	1
11020                     	xdef	_flags_tu_cnt_off
11021  005f               _flags_tu_cnt_on:
11022  005f 00            	ds.b	1
11023                     	xdef	_flags_tu_cnt_on
11024  0060               _vol_i_temp:
11025  0060 0000          	ds.b	2
11026                     	xdef	_vol_i_temp
11027  0062               _vol_u_temp:
11028  0062 0000          	ds.b	2
11029                     	xdef	_vol_u_temp
11030                     	switch	.eeprom
11031  0018               __x_ee_:
11032  0018 0000          	ds.b	2
11033                     	xdef	__x_ee_
11034                     	switch	.ubsct
11035  0064               __x_cnt:
11036  0064 0000          	ds.b	2
11037                     	xdef	__x_cnt
11038  0066               __x__:
11039  0066 0000          	ds.b	2
11040                     	xdef	__x__
11041  0068               __x_:
11042  0068 0000          	ds.b	2
11043                     	xdef	__x_
11044  006a               _flags_tu:
11045  006a 00            	ds.b	1
11046                     	xdef	_flags_tu
11047                     	xdef	_flags
11048  006b               _link_cnt:
11049  006b 0000          	ds.b	2
11050                     	xdef	_link_cnt
11051  006d               _link:
11052  006d 00            	ds.b	1
11053                     	xdef	_link
11054  006e               _umin_cnt:
11055  006e 0000          	ds.b	2
11056                     	xdef	_umin_cnt
11057  0070               _umax_cnt:
11058  0070 0000          	ds.b	2
11059                     	xdef	_umax_cnt
11060                     	switch	.eeprom
11061  001a               _ee_K:
11062  001a 000000000000  	ds.b	20
11063                     	xdef	_ee_K
11064                     	switch	.ubsct
11065  0072               _T:
11066  0072 00            	ds.b	1
11067                     	xdef	_T
11068                     	switch	.bss
11069  000c               _Uin:
11070  000c 0000          	ds.b	2
11071                     	xdef	_Uin
11072  000e               _Usum:
11073  000e 0000          	ds.b	2
11074                     	xdef	_Usum
11075  0010               _U_out_const:
11076  0010 0000          	ds.b	2
11077                     	xdef	_U_out_const
11078  0012               _Unecc:
11079  0012 0000          	ds.b	2
11080                     	xdef	_Unecc
11081  0014               _Ui:
11082  0014 0000          	ds.b	2
11083                     	xdef	_Ui
11084  0016               _Un:
11085  0016 0000          	ds.b	2
11086                     	xdef	_Un
11087  0018               _I:
11088  0018 0000          	ds.b	2
11089                     	xdef	_I
11090                     	switch	.ubsct
11091  0073               _can_error_cnt:
11092  0073 00            	ds.b	1
11093                     	xdef	_can_error_cnt
11094                     	xdef	_bCAN_RX
11095  0074               _tx_busy_cnt:
11096  0074 00            	ds.b	1
11097                     	xdef	_tx_busy_cnt
11098                     	xdef	_bTX_FREE
11099  0075               _can_buff_rd_ptr:
11100  0075 00            	ds.b	1
11101                     	xdef	_can_buff_rd_ptr
11102  0076               _can_buff_wr_ptr:
11103  0076 00            	ds.b	1
11104                     	xdef	_can_buff_wr_ptr
11105  0077               _can_out_buff:
11106  0077 000000000000  	ds.b	64
11107                     	xdef	_can_out_buff
11108                     	switch	.bss
11109  001a               _pwm_u_buff_cnt:
11110  001a 00            	ds.b	1
11111                     	xdef	_pwm_u_buff_cnt
11112  001b               _pwm_u_buff_ptr:
11113  001b 00            	ds.b	1
11114                     	xdef	_pwm_u_buff_ptr
11115  001c               _pwm_u_buff_:
11116  001c 0000          	ds.b	2
11117                     	xdef	_pwm_u_buff_
11118  001e               _pwm_u_buff:
11119  001e 000000000000  	ds.b	64
11120                     	xdef	_pwm_u_buff
11121                     	switch	.ubsct
11122  00b7               _adc_cnt_cnt:
11123  00b7 00            	ds.b	1
11124                     	xdef	_adc_cnt_cnt
11125                     	switch	.bss
11126  005e               _adc_buff_buff:
11127  005e 000000000000  	ds.b	160
11128                     	xdef	_adc_buff_buff
11129  00fe               _adress_error:
11130  00fe 00            	ds.b	1
11131                     	xdef	_adress_error
11132  00ff               _adress:
11133  00ff 00            	ds.b	1
11134                     	xdef	_adress
11135  0100               _adr:
11136  0100 000000        	ds.b	3
11137                     	xdef	_adr
11138                     	xdef	_adr_drv_stat
11139                     	xdef	_led_ind
11140                     	switch	.ubsct
11141  00b8               _led_ind_cnt:
11142  00b8 00            	ds.b	1
11143                     	xdef	_led_ind_cnt
11144  00b9               _adc_plazma:
11145  00b9 000000000000  	ds.b	10
11146                     	xdef	_adc_plazma
11147  00c3               _adc_plazma_short:
11148  00c3 0000          	ds.b	2
11149                     	xdef	_adc_plazma_short
11150  00c5               _adc_cnt:
11151  00c5 00            	ds.b	1
11152                     	xdef	_adc_cnt
11153  00c6               _adc_ch:
11154  00c6 00            	ds.b	1
11155                     	xdef	_adc_ch
11156                     	switch	.bss
11157  0103               _adc_buff_1:
11158  0103 0000          	ds.b	2
11159                     	xdef	_adc_buff_1
11160  0105               _adc_buff_5:
11161  0105 0000          	ds.b	2
11162                     	xdef	_adc_buff_5
11163  0107               _adc_buff_:
11164  0107 000000000000  	ds.b	20
11165                     	xdef	_adc_buff_
11166  011b               _adc_buff:
11167  011b 000000000000  	ds.b	320
11168                     	xdef	_adc_buff
11169  025b               _main_cnt10:
11170  025b 0000          	ds.b	2
11171                     	xdef	_main_cnt10
11172  025d               _main_cnt:
11173  025d 0000          	ds.b	2
11174                     	xdef	_main_cnt
11175                     	switch	.ubsct
11176  00c7               _mess:
11177  00c7 000000000000  	ds.b	14
11178                     	xdef	_mess
11179                     	switch	.bit
11180  0004               _b1000Hz:
11181  0004 00            	ds.b	1
11182                     	xdef	_b1000Hz
11183  0005               _b1Hz:
11184  0005 00            	ds.b	1
11185                     	xdef	_b1Hz
11186  0006               _b2Hz:
11187  0006 00            	ds.b	1
11188                     	xdef	_b2Hz
11189  0007               _b5Hz:
11190  0007 00            	ds.b	1
11191                     	xdef	_b5Hz
11192  0008               _b10Hz:
11193  0008 00            	ds.b	1
11194                     	xdef	_b10Hz
11195  0009               _b100Hz:
11196  0009 00            	ds.b	1
11197                     	xdef	_b100Hz
11198                     	xdef	_t0_cnt4
11199                     	xdef	_t0_cnt3
11200                     	xdef	_t0_cnt2
11201                     	xdef	_t0_cnt1
11202                     	xdef	_t0_cnt0
11203                     	xdef	_t0_cnt00
11204                     	xref	_abs
11205                     	xdef	_bVENT_BLOCK
11206                     	xref.b	c_lreg
11207                     	xref.b	c_x
11208                     	xref.b	c_y
11228                     	xref	c_lrsh
11229                     	xref	c_umul
11230                     	xref	c_lgsub
11231                     	xref	c_lgrsh
11232                     	xref	c_lgadd
11233                     	xref	c_idiv
11234                     	xref	c_sdivx
11235                     	xref	c_imul
11236                     	xref	c_lsbc
11237                     	xref	c_ladd
11238                     	xref	c_lsub
11239                     	xref	c_ldiv
11240                     	xref	c_lgmul
11241                     	xref	c_itolx
11242                     	xref	c_eewrc
11243                     	xref	c_ltor
11244                     	xref	c_lgadc
11245                     	xref	c_rtol
11246                     	xref	c_vmul
11247                     	xref	c_eewrw
11248                     	xref	c_lcmp
11249                     	xref	c_uitolx
11250                     	end
