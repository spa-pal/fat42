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
4164  0732 2051          	jra	L5612
4165  0734               L3612:
4166                     ; 834 else if(T>=80)alfa_pwm_max_t=1200;
4168  0734 9c            	rvf
4169  0735 b672          	ld	a,_T
4170  0737 a150          	cp	a,#80
4171  0739 2f08          	jrslt	L7612
4174  073b ae04b0        	ldw	x,#1200
4175  073e cf0006        	ldw	_alfa_pwm_max_t,x
4177  0741 2042          	jra	L5612
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
4193                     ; 839 	temp*=54;
4195  0753 1e01          	ldw	x,(OFST-1,sp)
4196  0755 90ae0036      	ldw	y,#54
4197  0759 cd0000        	call	c_imul
4199  075c 1f01          	ldw	(OFST-1,sp),x
4200                     ; 840 	temp/=2;
4202  075e 1e01          	ldw	x,(OFST-1,sp)
4203  0760 a602          	ld	a,#2
4204  0762 cd0000        	call	c_sdivx
4206  0765 1f01          	ldw	(OFST-1,sp),x
4207                     ; 841 	if(temp>540)temp=540;
4209  0767 9c            	rvf
4210  0768 1e01          	ldw	x,(OFST-1,sp)
4211  076a a3021d        	cpw	x,#541
4212  076d 2f05          	jrslt	L3712
4215  076f ae021c        	ldw	x,#540
4216  0772 1f01          	ldw	(OFST-1,sp),x
4217  0774               L3712:
4218                     ; 842 	if(temp<0)temp=0;
4220  0774 9c            	rvf
4221  0775 1e01          	ldw	x,(OFST-1,sp)
4222  0777 2e03          	jrsge	L5712
4225  0779 5f            	clrw	x
4226  077a 1f01          	ldw	(OFST-1,sp),x
4227  077c               L5712:
4228                     ; 843 	alfa_pwm_max_t=2000-temp;
4230  077c ae07d0        	ldw	x,#2000
4231  077f 72f001        	subw	x,(OFST-1,sp)
4232  0782 cf0006        	ldw	_alfa_pwm_max_t,x
4233  0785               L5612:
4234                     ; 847 if(I>=550)
4236  0785 9c            	rvf
4237  0786 ce0018        	ldw	x,_I
4238  0789 a30226        	cpw	x,#550
4239  078c 2f23          	jrslt	L7712
4240                     ; 849 	if(alfa_pwm_max_i_cnt__<5)
4242  078e 9c            	rvf
4243  078f ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4244  0792 a30005        	cpw	x,#5
4245  0795 2e31          	jrsge	L5022
4246                     ; 851 		alfa_pwm_max_i_cnt__++;
4248  0797 ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4249  079a 1c0001        	addw	x,#1
4250  079d cf0000        	ldw	_alfa_pwm_max_i_cnt__,x
4251                     ; 852 		if(alfa_pwm_max_i_cnt__>=5)alfa_pwm_max_i_cnt=30;
4253  07a0 9c            	rvf
4254  07a1 ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4255  07a4 a30005        	cpw	x,#5
4256  07a7 2f1f          	jrslt	L5022
4259  07a9 ae001e        	ldw	x,#30
4260  07ac cf0002        	ldw	_alfa_pwm_max_i_cnt,x
4261  07af 2017          	jra	L5022
4262  07b1               L7712:
4263                     ; 855 else if(I<500)
4265  07b1 9c            	rvf
4266  07b2 ce0018        	ldw	x,_I
4267  07b5 a301f4        	cpw	x,#500
4268  07b8 2e0e          	jrsge	L5022
4269                     ; 857 	if(alfa_pwm_max_i_cnt__)
4271  07ba ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4272  07bd 2709          	jreq	L5022
4273                     ; 859 		alfa_pwm_max_i_cnt__--;	
4275  07bf ce0000        	ldw	x,_alfa_pwm_max_i_cnt__
4276  07c2 1d0001        	subw	x,#1
4277  07c5 cf0000        	ldw	_alfa_pwm_max_i_cnt__,x
4278  07c8               L5022:
4279                     ; 863 if(alfa_pwm_max_i_cnt)
4281  07c8 ce0002        	ldw	x,_alfa_pwm_max_i_cnt
4282  07cb 271a          	jreq	L3122
4283                     ; 865 	alfa_pwm_max_i_cnt--;
4285  07cd ce0002        	ldw	x,_alfa_pwm_max_i_cnt
4286  07d0 1d0001        	subw	x,#1
4287  07d3 cf0002        	ldw	_alfa_pwm_max_i_cnt,x
4288                     ; 866 	if(alfa_pwm_max_i_cnt==0)alfa_pwm_max_i_cnt__=0;
4290  07d6 ce0002        	ldw	x,_alfa_pwm_max_i_cnt
4291  07d9 2604          	jrne	L5122
4294  07db 5f            	clrw	x
4295  07dc cf0000        	ldw	_alfa_pwm_max_i_cnt__,x
4296  07df               L5122:
4297                     ; 867 	alfa_pwm_max_i=1460;	
4299  07df ae05b4        	ldw	x,#1460
4300  07e2 cf0004        	ldw	_alfa_pwm_max_i,x
4302  07e5 2006          	jra	L7122
4303  07e7               L3122:
4304                     ; 871 	alfa_pwm_max_i=2000;
4306  07e7 ae07d0        	ldw	x,#2000
4307  07ea cf0004        	ldw	_alfa_pwm_max_i,x
4308  07ed               L7122:
4309                     ; 873 }
4312  07ed 85            	popw	x
4313  07ee 81            	ret
4370                     	switch	.const
4371  0018               L06:
4372  0018 0000028a      	dc.l	650
4373                     ; 878 void pwr_hndl(void)				
4373                     ; 879 {
4374                     	switch	.text
4375  07ef               _pwr_hndl:
4377  07ef 5205          	subw	sp,#5
4378       00000005      OFST:	set	5
4381                     ; 880 if(jp_mode==jp3)
4383  07f1 b654          	ld	a,_jp_mode
4384  07f3 a103          	cp	a,#3
4385  07f5 260a          	jrne	L3422
4386                     ; 882 	pwm_u=0;
4388  07f7 5f            	clrw	x
4389  07f8 bf08          	ldw	_pwm_u,x
4390                     ; 883 	pwm_i=0;
4392  07fa 5f            	clrw	x
4393  07fb bf0a          	ldw	_pwm_i,x
4395  07fd ac210921      	jpf	L5422
4396  0801               L3422:
4397                     ; 885 else if(jp_mode==jp2)
4399  0801 b654          	ld	a,_jp_mode
4400  0803 a102          	cp	a,#2
4401  0805 260c          	jrne	L7422
4402                     ; 887 	pwm_u=0;
4404  0807 5f            	clrw	x
4405  0808 bf08          	ldw	_pwm_u,x
4406                     ; 888 	pwm_i=0x7ff;
4408  080a ae07ff        	ldw	x,#2047
4409  080d bf0a          	ldw	_pwm_i,x
4411  080f ac210921      	jpf	L5422
4412  0813               L7422:
4413                     ; 890 else if(jp_mode==jp1)
4415  0813 b654          	ld	a,_jp_mode
4416  0815 a101          	cp	a,#1
4417  0817 260e          	jrne	L3522
4418                     ; 892 	pwm_u=0x7ff;
4420  0819 ae07ff        	ldw	x,#2047
4421  081c bf08          	ldw	_pwm_u,x
4422                     ; 893 	pwm_i=0x7ff;
4424  081e ae07ff        	ldw	x,#2047
4425  0821 bf0a          	ldw	_pwm_i,x
4427  0823 ac210921      	jpf	L5422
4428  0827               L3522:
4429                     ; 904 else if(link==OFF)
4431  0827 b66d          	ld	a,_link
4432  0829 a1aa          	cp	a,#170
4433  082b 2703          	jreq	L26
4434  082d cc08cf        	jp	L7522
4435  0830               L26:
4436                     ; 906 	pwm_i=0x7ff;
4438  0830 ae07ff        	ldw	x,#2047
4439  0833 bf0a          	ldw	_pwm_i,x
4440                     ; 907 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4442  0835 ce0012        	ldw	x,_Unecc
4443  0838 90ae07d0      	ldw	y,#2000
4444  083c cd0000        	call	c_vmul
4446  083f ae0018        	ldw	x,#L06
4447  0842 cd0000        	call	c_ldiv
4449  0845 be02          	ldw	x,c_lreg+2
4450  0847 bf55          	ldw	_pwm_u_,x
4451                     ; 911 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4453  0849 c6001b        	ld	a,_pwm_u_buff_ptr
4454  084c 5f            	clrw	x
4455  084d 97            	ld	xl,a
4456  084e 58            	sllw	x
4457  084f 90be55        	ldw	y,_pwm_u_
4458  0852 df001e        	ldw	(_pwm_u_buff,x),y
4459                     ; 912 	pwm_u_buff_ptr++;
4461  0855 725c001b      	inc	_pwm_u_buff_ptr
4462                     ; 913 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4464  0859 c6001b        	ld	a,_pwm_u_buff_ptr
4465  085c a110          	cp	a,#16
4466  085e 2504          	jrult	L1622
4469  0860 725f001b      	clr	_pwm_u_buff_ptr
4470  0864               L1622:
4471                     ; 917 		tempSL=0;
4473  0864 ae0000        	ldw	x,#0
4474  0867 1f03          	ldw	(OFST-2,sp),x
4475  0869 ae0000        	ldw	x,#0
4476  086c 1f01          	ldw	(OFST-4,sp),x
4477                     ; 918 		for(i=0;i<16;i++)
4479  086e 0f05          	clr	(OFST+0,sp)
4480  0870               L3622:
4481                     ; 920 			tempSL+=(signed long)pwm_u_buff[i];
4483  0870 7b05          	ld	a,(OFST+0,sp)
4484  0872 5f            	clrw	x
4485  0873 97            	ld	xl,a
4486  0874 58            	sllw	x
4487  0875 de001e        	ldw	x,(_pwm_u_buff,x)
4488  0878 cd0000        	call	c_itolx
4490  087b 96            	ldw	x,sp
4491  087c 1c0001        	addw	x,#OFST-4
4492  087f cd0000        	call	c_lgadd
4494                     ; 918 		for(i=0;i<16;i++)
4496  0882 0c05          	inc	(OFST+0,sp)
4499  0884 7b05          	ld	a,(OFST+0,sp)
4500  0886 a110          	cp	a,#16
4501  0888 25e6          	jrult	L3622
4502                     ; 922 		tempSL>>=4;
4504  088a 96            	ldw	x,sp
4505  088b 1c0001        	addw	x,#OFST-4
4506  088e a604          	ld	a,#4
4507  0890 cd0000        	call	c_lgrsh
4509                     ; 923 		pwm_u_buff_=(signed short)tempSL;
4511  0893 1e03          	ldw	x,(OFST-2,sp)
4512  0895 cf001c        	ldw	_pwm_u_buff_,x
4513                     ; 925 	pwm_u=pwm_u_;
4515  0898 be55          	ldw	x,_pwm_u_
4516  089a bf08          	ldw	_pwm_u,x
4517                     ; 926 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4519  089c 9c            	rvf
4520  089d ce0014        	ldw	x,_Ui
4521  08a0 72b00012      	subw	x,_Unecc
4522  08a4 cd0000        	call	_abs
4524  08a7 a30014        	cpw	x,#20
4525  08aa 2e06          	jrsge	L1722
4528  08ac 725c001a      	inc	_pwm_u_buff_cnt
4530  08b0 2004          	jra	L3722
4531  08b2               L1722:
4532                     ; 927 	else pwm_u_buff_cnt=0;
4534  08b2 725f001a      	clr	_pwm_u_buff_cnt
4535  08b6               L3722:
4536                     ; 929 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4538  08b6 c6001a        	ld	a,_pwm_u_buff_cnt
4539  08b9 a114          	cp	a,#20
4540  08bb 2504          	jrult	L5722
4543  08bd 3514001a      	mov	_pwm_u_buff_cnt,#20
4544  08c1               L5722:
4545                     ; 930 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4547  08c1 c6001a        	ld	a,_pwm_u_buff_cnt
4548  08c4 a10f          	cp	a,#15
4549  08c6 2559          	jrult	L5422
4552  08c8 ce001c        	ldw	x,_pwm_u_buff_
4553  08cb bf08          	ldw	_pwm_u,x
4554  08cd 2052          	jra	L5422
4555  08cf               L7522:
4556                     ; 934 else	if(link==ON)				//если есть связьvol_i_temp_avar
4558  08cf b66d          	ld	a,_link
4559  08d1 a155          	cp	a,#85
4560  08d3 264c          	jrne	L5422
4561                     ; 936 	if((flags&0b00100000)==0)	//если нет блокировки извне
4563  08d5 b605          	ld	a,_flags
4564  08d7 a520          	bcp	a,#32
4565  08d9 263a          	jrne	L5032
4566                     ; 943 		else*/ if(flags&0b00011010)					//если есть аварии
4568  08db b605          	ld	a,_flags
4569  08dd a51a          	bcp	a,#26
4570  08df 2706          	jreq	L7032
4571                     ; 945 			pwm_u=0;								//то полный стоп
4573  08e1 5f            	clrw	x
4574  08e2 bf08          	ldw	_pwm_u,x
4575                     ; 946 			pwm_i=0;
4577  08e4 5f            	clrw	x
4578  08e5 bf0a          	ldw	_pwm_i,x
4579  08e7               L7032:
4580                     ; 949 		if(vol_i_temp==2000)
4582  08e7 be60          	ldw	x,_vol_i_temp
4583  08e9 a307d0        	cpw	x,#2000
4584  08ec 260c          	jrne	L1132
4585                     ; 951 			pwm_u=1500;
4587  08ee ae05dc        	ldw	x,#1500
4588  08f1 bf08          	ldw	_pwm_u,x
4589                     ; 952 			pwm_i=2000;
4591  08f3 ae07d0        	ldw	x,#2000
4592  08f6 bf0a          	ldw	_pwm_i,x
4594  08f8 2027          	jra	L5422
4595  08fa               L1132:
4596                     ; 965 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4598  08fa ce0012        	ldw	x,_Unecc
4599  08fd 90ae07d0      	ldw	y,#2000
4600  0901 cd0000        	call	c_vmul
4602  0904 ae0018        	ldw	x,#L06
4603  0907 cd0000        	call	c_ldiv
4605  090a be02          	ldw	x,c_lreg+2
4606  090c bf08          	ldw	_pwm_u,x
4607                     ; 967 			pwm_i=2000;
4609  090e ae07d0        	ldw	x,#2000
4610  0911 bf0a          	ldw	_pwm_i,x
4611  0913 200c          	jra	L5422
4612  0915               L5032:
4613                     ; 974 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4615  0915 b605          	ld	a,_flags
4616  0917 a520          	bcp	a,#32
4617  0919 2706          	jreq	L5422
4618                     ; 976 		pwm_u=0;
4620  091b 5f            	clrw	x
4621  091c bf08          	ldw	_pwm_u,x
4622                     ; 977 		pwm_i=0;
4624  091e 5f            	clrw	x
4625  091f bf0a          	ldw	_pwm_i,x
4626  0921               L5422:
4627                     ; 1005 if(pwm_u>2000)pwm_u=2000;
4629  0921 9c            	rvf
4630  0922 be08          	ldw	x,_pwm_u
4631  0924 a307d1        	cpw	x,#2001
4632  0927 2f05          	jrslt	L1232
4635  0929 ae07d0        	ldw	x,#2000
4636  092c bf08          	ldw	_pwm_u,x
4637  092e               L1232:
4638                     ; 1006 if(pwm_i>2000)pwm_i=2000;
4640  092e 9c            	rvf
4641  092f be0a          	ldw	x,_pwm_i
4642  0931 a307d1        	cpw	x,#2001
4643  0934 2f05          	jrslt	L3232
4646  0936 ae07d0        	ldw	x,#2000
4647  0939 bf0a          	ldw	_pwm_i,x
4648  093b               L3232:
4649                     ; 1009 }
4652  093b 5b05          	addw	sp,#5
4653  093d 81            	ret
4706                     	switch	.const
4707  001c               L66:
4708  001c 00000258      	dc.l	600
4709  0020               L07:
4710  0020 000003e8      	dc.l	1000
4711  0024               L27:
4712  0024 00000708      	dc.l	1800
4713                     ; 1012 void matemat(void)
4713                     ; 1013 {
4714                     	switch	.text
4715  093e               _matemat:
4717  093e 5208          	subw	sp,#8
4718       00000008      OFST:	set	8
4721                     ; 1037 I=adc_buff_[4];
4723  0940 ce010f        	ldw	x,_adc_buff_+8
4724  0943 cf0018        	ldw	_I,x
4725                     ; 1038 temp_SL=adc_buff_[4];
4727  0946 ce010f        	ldw	x,_adc_buff_+8
4728  0949 cd0000        	call	c_itolx
4730  094c 96            	ldw	x,sp
4731  094d 1c0005        	addw	x,#OFST-3
4732  0950 cd0000        	call	c_rtol
4734                     ; 1039 temp_SL-=ee_K[0][0];
4736  0953 ce001a        	ldw	x,_ee_K
4737  0956 cd0000        	call	c_itolx
4739  0959 96            	ldw	x,sp
4740  095a 1c0005        	addw	x,#OFST-3
4741  095d cd0000        	call	c_lgsub
4743                     ; 1040 if(temp_SL<0) temp_SL=0;
4745  0960 9c            	rvf
4746  0961 0d05          	tnz	(OFST-3,sp)
4747  0963 2e0a          	jrsge	L3432
4750  0965 ae0000        	ldw	x,#0
4751  0968 1f07          	ldw	(OFST-1,sp),x
4752  096a ae0000        	ldw	x,#0
4753  096d 1f05          	ldw	(OFST-3,sp),x
4754  096f               L3432:
4755                     ; 1041 temp_SL*=ee_K[0][1];
4757  096f ce001c        	ldw	x,_ee_K+2
4758  0972 cd0000        	call	c_itolx
4760  0975 96            	ldw	x,sp
4761  0976 1c0005        	addw	x,#OFST-3
4762  0979 cd0000        	call	c_lgmul
4764                     ; 1042 temp_SL/=600;
4766  097c 96            	ldw	x,sp
4767  097d 1c0005        	addw	x,#OFST-3
4768  0980 cd0000        	call	c_ltor
4770  0983 ae001c        	ldw	x,#L66
4771  0986 cd0000        	call	c_ldiv
4773  0989 96            	ldw	x,sp
4774  098a 1c0005        	addw	x,#OFST-3
4775  098d cd0000        	call	c_rtol
4777                     ; 1043 I=(signed short)temp_SL;
4779  0990 1e07          	ldw	x,(OFST-1,sp)
4780  0992 cf0018        	ldw	_I,x
4781                     ; 1046 temp_SL=(signed long)adc_buff_[1];//1;
4783                     ; 1047 temp_SL=(signed long)adc_buff_[3];//1;
4785  0995 ce010d        	ldw	x,_adc_buff_+6
4786  0998 cd0000        	call	c_itolx
4788  099b 96            	ldw	x,sp
4789  099c 1c0005        	addw	x,#OFST-3
4790  099f cd0000        	call	c_rtol
4792                     ; 1049 if(temp_SL<0) temp_SL=0;
4794  09a2 9c            	rvf
4795  09a3 0d05          	tnz	(OFST-3,sp)
4796  09a5 2e0a          	jrsge	L5432
4799  09a7 ae0000        	ldw	x,#0
4800  09aa 1f07          	ldw	(OFST-1,sp),x
4801  09ac ae0000        	ldw	x,#0
4802  09af 1f05          	ldw	(OFST-3,sp),x
4803  09b1               L5432:
4804                     ; 1050 temp_SL*=(signed long)ee_K[2][1];
4806  09b1 ce0024        	ldw	x,_ee_K+10
4807  09b4 cd0000        	call	c_itolx
4809  09b7 96            	ldw	x,sp
4810  09b8 1c0005        	addw	x,#OFST-3
4811  09bb cd0000        	call	c_lgmul
4813                     ; 1051 temp_SL/=1000L;
4815  09be 96            	ldw	x,sp
4816  09bf 1c0005        	addw	x,#OFST-3
4817  09c2 cd0000        	call	c_ltor
4819  09c5 ae0020        	ldw	x,#L07
4820  09c8 cd0000        	call	c_ldiv
4822  09cb 96            	ldw	x,sp
4823  09cc 1c0005        	addw	x,#OFST-3
4824  09cf cd0000        	call	c_rtol
4826                     ; 1052 Ui=(unsigned short)temp_SL;
4828  09d2 1e07          	ldw	x,(OFST-1,sp)
4829  09d4 cf0014        	ldw	_Ui,x
4830                     ; 1054 temp_SL=(signed long)adc_buff_5;
4832  09d7 ce0105        	ldw	x,_adc_buff_5
4833  09da cd0000        	call	c_itolx
4835  09dd 96            	ldw	x,sp
4836  09de 1c0005        	addw	x,#OFST-3
4837  09e1 cd0000        	call	c_rtol
4839                     ; 1056 if(temp_SL<0) temp_SL=0;
4841  09e4 9c            	rvf
4842  09e5 0d05          	tnz	(OFST-3,sp)
4843  09e7 2e0a          	jrsge	L7432
4846  09e9 ae0000        	ldw	x,#0
4847  09ec 1f07          	ldw	(OFST-1,sp),x
4848  09ee ae0000        	ldw	x,#0
4849  09f1 1f05          	ldw	(OFST-3,sp),x
4850  09f3               L7432:
4851                     ; 1057 temp_SL*=(signed long)ee_K[4][1];
4853  09f3 ce002c        	ldw	x,_ee_K+18
4854  09f6 cd0000        	call	c_itolx
4856  09f9 96            	ldw	x,sp
4857  09fa 1c0005        	addw	x,#OFST-3
4858  09fd cd0000        	call	c_lgmul
4860                     ; 1058 temp_SL/=1000L;
4862  0a00 96            	ldw	x,sp
4863  0a01 1c0005        	addw	x,#OFST-3
4864  0a04 cd0000        	call	c_ltor
4866  0a07 ae0020        	ldw	x,#L07
4867  0a0a cd0000        	call	c_ldiv
4869  0a0d 96            	ldw	x,sp
4870  0a0e 1c0005        	addw	x,#OFST-3
4871  0a11 cd0000        	call	c_rtol
4873                     ; 1059 Usum=(unsigned short)temp_SL;
4875  0a14 1e07          	ldw	x,(OFST-1,sp)
4876  0a16 cf000e        	ldw	_Usum,x
4877                     ; 1063 temp_SL=adc_buff_[3];
4879  0a19 ce010d        	ldw	x,_adc_buff_+6
4880  0a1c cd0000        	call	c_itolx
4882  0a1f 96            	ldw	x,sp
4883  0a20 1c0005        	addw	x,#OFST-3
4884  0a23 cd0000        	call	c_rtol
4886                     ; 1065 if(temp_SL<0) temp_SL=0;
4888  0a26 9c            	rvf
4889  0a27 0d05          	tnz	(OFST-3,sp)
4890  0a29 2e0a          	jrsge	L1532
4893  0a2b ae0000        	ldw	x,#0
4894  0a2e 1f07          	ldw	(OFST-1,sp),x
4895  0a30 ae0000        	ldw	x,#0
4896  0a33 1f05          	ldw	(OFST-3,sp),x
4897  0a35               L1532:
4898                     ; 1066 temp_SL*=ee_K[1][1];
4900  0a35 ce0020        	ldw	x,_ee_K+6
4901  0a38 cd0000        	call	c_itolx
4903  0a3b 96            	ldw	x,sp
4904  0a3c 1c0005        	addw	x,#OFST-3
4905  0a3f cd0000        	call	c_lgmul
4907                     ; 1067 temp_SL/=1800;
4909  0a42 96            	ldw	x,sp
4910  0a43 1c0005        	addw	x,#OFST-3
4911  0a46 cd0000        	call	c_ltor
4913  0a49 ae0024        	ldw	x,#L27
4914  0a4c cd0000        	call	c_ldiv
4916  0a4f 96            	ldw	x,sp
4917  0a50 1c0005        	addw	x,#OFST-3
4918  0a53 cd0000        	call	c_rtol
4920                     ; 1068 Un=(unsigned short)temp_SL;
4922  0a56 1e07          	ldw	x,(OFST-1,sp)
4923  0a58 cf0016        	ldw	_Un,x
4924                     ; 1073 temp_SL=adc_buff_[2];
4926  0a5b ce010b        	ldw	x,_adc_buff_+4
4927  0a5e cd0000        	call	c_itolx
4929  0a61 96            	ldw	x,sp
4930  0a62 1c0005        	addw	x,#OFST-3
4931  0a65 cd0000        	call	c_rtol
4933                     ; 1074 temp_SL*=ee_K[3][1];
4935  0a68 ce0028        	ldw	x,_ee_K+14
4936  0a6b cd0000        	call	c_itolx
4938  0a6e 96            	ldw	x,sp
4939  0a6f 1c0005        	addw	x,#OFST-3
4940  0a72 cd0000        	call	c_lgmul
4942                     ; 1075 temp_SL/=1000;
4944  0a75 96            	ldw	x,sp
4945  0a76 1c0005        	addw	x,#OFST-3
4946  0a79 cd0000        	call	c_ltor
4948  0a7c ae0020        	ldw	x,#L07
4949  0a7f cd0000        	call	c_ldiv
4951  0a82 96            	ldw	x,sp
4952  0a83 1c0005        	addw	x,#OFST-3
4953  0a86 cd0000        	call	c_rtol
4955                     ; 1076 T=(signed short)(temp_SL-273L);
4957  0a89 7b08          	ld	a,(OFST+0,sp)
4958  0a8b 5f            	clrw	x
4959  0a8c 4d            	tnz	a
4960  0a8d 2a01          	jrpl	L47
4961  0a8f 53            	cplw	x
4962  0a90               L47:
4963  0a90 97            	ld	xl,a
4964  0a91 1d0111        	subw	x,#273
4965  0a94 01            	rrwa	x,a
4966  0a95 b772          	ld	_T,a
4967  0a97 02            	rlwa	x,a
4968                     ; 1077 if(T<-30)T=-30;
4970  0a98 9c            	rvf
4971  0a99 b672          	ld	a,_T
4972  0a9b a1e2          	cp	a,#226
4973  0a9d 2e04          	jrsge	L3532
4976  0a9f 35e20072      	mov	_T,#226
4977  0aa3               L3532:
4978                     ; 1078 if(T>120)T=120;
4980  0aa3 9c            	rvf
4981  0aa4 b672          	ld	a,_T
4982  0aa6 a179          	cp	a,#121
4983  0aa8 2f04          	jrslt	L5532
4986  0aaa 35780072      	mov	_T,#120
4987  0aae               L5532:
4988                     ; 1082 Uin=Usum-Ui;
4990  0aae ce000e        	ldw	x,_Usum
4991  0ab1 72b00014      	subw	x,_Ui
4992  0ab5 cf000c        	ldw	_Uin,x
4993                     ; 1083 if(link==ON)
4995  0ab8 b66d          	ld	a,_link
4996  0aba a155          	cp	a,#85
4997  0abc 2610          	jrne	L7532
4998                     ; 1085 	Unecc=U_out_const-Uin+vol_i_temp;
5000  0abe ce0010        	ldw	x,_U_out_const
5001  0ac1 72b0000c      	subw	x,_Uin
5002  0ac5 72bb0060      	addw	x,_vol_i_temp
5003  0ac9 cf0012        	ldw	_Unecc,x
5005  0acc 200a          	jra	L1632
5006  0ace               L7532:
5007                     ; 1094 else Unecc=ee_UAVT-Uin;
5009  0ace ce000c        	ldw	x,_ee_UAVT
5010  0ad1 72b0000c      	subw	x,_Uin
5011  0ad5 cf0012        	ldw	_Unecc,x
5012  0ad8               L1632:
5013                     ; 1102 if(Unecc<0)Unecc=0;
5015  0ad8 9c            	rvf
5016  0ad9 ce0012        	ldw	x,_Unecc
5017  0adc 2e04          	jrsge	L3632
5020  0ade 5f            	clrw	x
5021  0adf cf0012        	ldw	_Unecc,x
5022  0ae2               L3632:
5023                     ; 1103 temp_SL=(signed long)(T-ee_tsign);
5025  0ae2 5f            	clrw	x
5026  0ae3 b672          	ld	a,_T
5027  0ae5 2a01          	jrpl	L67
5028  0ae7 53            	cplw	x
5029  0ae8               L67:
5030  0ae8 97            	ld	xl,a
5031  0ae9 72b0000e      	subw	x,_ee_tsign
5032  0aed cd0000        	call	c_itolx
5034  0af0 96            	ldw	x,sp
5035  0af1 1c0005        	addw	x,#OFST-3
5036  0af4 cd0000        	call	c_rtol
5038                     ; 1104 temp_SL*=1000L;
5040  0af7 ae03e8        	ldw	x,#1000
5041  0afa bf02          	ldw	c_lreg+2,x
5042  0afc ae0000        	ldw	x,#0
5043  0aff bf00          	ldw	c_lreg,x
5044  0b01 96            	ldw	x,sp
5045  0b02 1c0005        	addw	x,#OFST-3
5046  0b05 cd0000        	call	c_lgmul
5048                     ; 1105 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5050  0b08 ce0010        	ldw	x,_ee_tmax
5051  0b0b 72b0000e      	subw	x,_ee_tsign
5052  0b0f cd0000        	call	c_itolx
5054  0b12 96            	ldw	x,sp
5055  0b13 1c0001        	addw	x,#OFST-7
5056  0b16 cd0000        	call	c_rtol
5058  0b19 96            	ldw	x,sp
5059  0b1a 1c0005        	addw	x,#OFST-3
5060  0b1d cd0000        	call	c_ltor
5062  0b20 96            	ldw	x,sp
5063  0b21 1c0001        	addw	x,#OFST-7
5064  0b24 cd0000        	call	c_ldiv
5066  0b27 96            	ldw	x,sp
5067  0b28 1c0005        	addw	x,#OFST-3
5068  0b2b cd0000        	call	c_rtol
5070                     ; 1107 vol_i_temp_avar=(unsigned short)temp_SL; 
5072  0b2e 1e07          	ldw	x,(OFST-1,sp)
5073  0b30 bf06          	ldw	_vol_i_temp_avar,x
5074                     ; 1109 debug_info_to_uku[0]=pwm_u;
5076  0b32 be08          	ldw	x,_pwm_u
5077  0b34 bf01          	ldw	_debug_info_to_uku,x
5078                     ; 1110 debug_info_to_uku[1]=Unecc;
5080  0b36 ce0012        	ldw	x,_Unecc
5081  0b39 bf03          	ldw	_debug_info_to_uku+2,x
5082                     ; 1112 }
5085  0b3b 5b08          	addw	sp,#8
5086  0b3d 81            	ret
5117                     ; 1115 void temper_drv(void)		//1 Hz
5117                     ; 1116 {
5118                     	switch	.text
5119  0b3e               _temper_drv:
5123                     ; 1118 if(T>ee_tsign) tsign_cnt++;
5125  0b3e 9c            	rvf
5126  0b3f 5f            	clrw	x
5127  0b40 b672          	ld	a,_T
5128  0b42 2a01          	jrpl	L201
5129  0b44 53            	cplw	x
5130  0b45               L201:
5131  0b45 97            	ld	xl,a
5132  0b46 c3000e        	cpw	x,_ee_tsign
5133  0b49 2d09          	jrsle	L5732
5136  0b4b be59          	ldw	x,_tsign_cnt
5137  0b4d 1c0001        	addw	x,#1
5138  0b50 bf59          	ldw	_tsign_cnt,x
5140  0b52 201d          	jra	L7732
5141  0b54               L5732:
5142                     ; 1119 else if (T<(ee_tsign-1)) tsign_cnt--;
5144  0b54 9c            	rvf
5145  0b55 ce000e        	ldw	x,_ee_tsign
5146  0b58 5a            	decw	x
5147  0b59 905f          	clrw	y
5148  0b5b b672          	ld	a,_T
5149  0b5d 2a02          	jrpl	L401
5150  0b5f 9053          	cplw	y
5151  0b61               L401:
5152  0b61 9097          	ld	yl,a
5153  0b63 90bf00        	ldw	c_y,y
5154  0b66 b300          	cpw	x,c_y
5155  0b68 2d07          	jrsle	L7732
5158  0b6a be59          	ldw	x,_tsign_cnt
5159  0b6c 1d0001        	subw	x,#1
5160  0b6f bf59          	ldw	_tsign_cnt,x
5161  0b71               L7732:
5162                     ; 1121 gran(&tsign_cnt,0,60);
5164  0b71 ae003c        	ldw	x,#60
5165  0b74 89            	pushw	x
5166  0b75 5f            	clrw	x
5167  0b76 89            	pushw	x
5168  0b77 ae0059        	ldw	x,#_tsign_cnt
5169  0b7a cd00d5        	call	_gran
5171  0b7d 5b04          	addw	sp,#4
5172                     ; 1123 if(tsign_cnt>=55)
5174  0b7f 9c            	rvf
5175  0b80 be59          	ldw	x,_tsign_cnt
5176  0b82 a30037        	cpw	x,#55
5177  0b85 2f16          	jrslt	L3042
5178                     ; 1125 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5180  0b87 3d54          	tnz	_jp_mode
5181  0b89 2606          	jrne	L1142
5183  0b8b b605          	ld	a,_flags
5184  0b8d a540          	bcp	a,#64
5185  0b8f 2706          	jreq	L7042
5186  0b91               L1142:
5188  0b91 b654          	ld	a,_jp_mode
5189  0b93 a103          	cp	a,#3
5190  0b95 2612          	jrne	L3142
5191  0b97               L7042:
5194  0b97 72140005      	bset	_flags,#2
5195  0b9b 200c          	jra	L3142
5196  0b9d               L3042:
5197                     ; 1127 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5199  0b9d 9c            	rvf
5200  0b9e be59          	ldw	x,_tsign_cnt
5201  0ba0 a30006        	cpw	x,#6
5202  0ba3 2e04          	jrsge	L3142
5205  0ba5 72150005      	bres	_flags,#2
5206  0ba9               L3142:
5207                     ; 1132 if(T>ee_tmax) tmax_cnt++;
5209  0ba9 9c            	rvf
5210  0baa 5f            	clrw	x
5211  0bab b672          	ld	a,_T
5212  0bad 2a01          	jrpl	L601
5213  0baf 53            	cplw	x
5214  0bb0               L601:
5215  0bb0 97            	ld	xl,a
5216  0bb1 c30010        	cpw	x,_ee_tmax
5217  0bb4 2d09          	jrsle	L7142
5220  0bb6 be57          	ldw	x,_tmax_cnt
5221  0bb8 1c0001        	addw	x,#1
5222  0bbb bf57          	ldw	_tmax_cnt,x
5224  0bbd 201d          	jra	L1242
5225  0bbf               L7142:
5226                     ; 1133 else if (T<(ee_tmax-1)) tmax_cnt--;
5228  0bbf 9c            	rvf
5229  0bc0 ce0010        	ldw	x,_ee_tmax
5230  0bc3 5a            	decw	x
5231  0bc4 905f          	clrw	y
5232  0bc6 b672          	ld	a,_T
5233  0bc8 2a02          	jrpl	L011
5234  0bca 9053          	cplw	y
5235  0bcc               L011:
5236  0bcc 9097          	ld	yl,a
5237  0bce 90bf00        	ldw	c_y,y
5238  0bd1 b300          	cpw	x,c_y
5239  0bd3 2d07          	jrsle	L1242
5242  0bd5 be57          	ldw	x,_tmax_cnt
5243  0bd7 1d0001        	subw	x,#1
5244  0bda bf57          	ldw	_tmax_cnt,x
5245  0bdc               L1242:
5246                     ; 1135 gran(&tmax_cnt,0,60);
5248  0bdc ae003c        	ldw	x,#60
5249  0bdf 89            	pushw	x
5250  0be0 5f            	clrw	x
5251  0be1 89            	pushw	x
5252  0be2 ae0057        	ldw	x,#_tmax_cnt
5253  0be5 cd00d5        	call	_gran
5255  0be8 5b04          	addw	sp,#4
5256                     ; 1137 if(tmax_cnt>=55)
5258  0bea 9c            	rvf
5259  0beb be57          	ldw	x,_tmax_cnt
5260  0bed a30037        	cpw	x,#55
5261  0bf0 2f16          	jrslt	L5242
5262                     ; 1139 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5264  0bf2 3d54          	tnz	_jp_mode
5265  0bf4 2606          	jrne	L3342
5267  0bf6 b605          	ld	a,_flags
5268  0bf8 a540          	bcp	a,#64
5269  0bfa 2706          	jreq	L1342
5270  0bfc               L3342:
5272  0bfc b654          	ld	a,_jp_mode
5273  0bfe a103          	cp	a,#3
5274  0c00 2612          	jrne	L5342
5275  0c02               L1342:
5278  0c02 72120005      	bset	_flags,#1
5279  0c06 200c          	jra	L5342
5280  0c08               L5242:
5281                     ; 1141 else if (tmax_cnt<=5) flags&=0b11111101;
5283  0c08 9c            	rvf
5284  0c09 be57          	ldw	x,_tmax_cnt
5285  0c0b a30006        	cpw	x,#6
5286  0c0e 2e04          	jrsge	L5342
5289  0c10 72130005      	bres	_flags,#1
5290  0c14               L5342:
5291                     ; 1144 } 
5294  0c14 81            	ret
5326                     ; 1147 void u_drv(void)		//1Hz
5326                     ; 1148 { 
5327                     	switch	.text
5328  0c15               _u_drv:
5332                     ; 1149 if(jp_mode!=jp3)
5334  0c15 b654          	ld	a,_jp_mode
5335  0c17 a103          	cp	a,#3
5336  0c19 2774          	jreq	L1542
5337                     ; 1151 	if(Ui>ee_Umax)umax_cnt++;
5339  0c1b 9c            	rvf
5340  0c1c ce0014        	ldw	x,_Ui
5341  0c1f c30014        	cpw	x,_ee_Umax
5342  0c22 2d09          	jrsle	L3542
5345  0c24 be70          	ldw	x,_umax_cnt
5346  0c26 1c0001        	addw	x,#1
5347  0c29 bf70          	ldw	_umax_cnt,x
5349  0c2b 2003          	jra	L5542
5350  0c2d               L3542:
5351                     ; 1152 	else umax_cnt=0;
5353  0c2d 5f            	clrw	x
5354  0c2e bf70          	ldw	_umax_cnt,x
5355  0c30               L5542:
5356                     ; 1153 	gran(&umax_cnt,0,10);
5358  0c30 ae000a        	ldw	x,#10
5359  0c33 89            	pushw	x
5360  0c34 5f            	clrw	x
5361  0c35 89            	pushw	x
5362  0c36 ae0070        	ldw	x,#_umax_cnt
5363  0c39 cd00d5        	call	_gran
5365  0c3c 5b04          	addw	sp,#4
5366                     ; 1154 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5368  0c3e 9c            	rvf
5369  0c3f be70          	ldw	x,_umax_cnt
5370  0c41 a3000a        	cpw	x,#10
5371  0c44 2f04          	jrslt	L7542
5374  0c46 72160005      	bset	_flags,#3
5375  0c4a               L7542:
5376                     ; 1157 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5378  0c4a 9c            	rvf
5379  0c4b ce0014        	ldw	x,_Ui
5380  0c4e c30016        	cpw	x,_Un
5381  0c51 2e1d          	jrsge	L1642
5383  0c53 9c            	rvf
5384  0c54 ce0016        	ldw	x,_Un
5385  0c57 72b00014      	subw	x,_Ui
5386  0c5b c30012        	cpw	x,_ee_dU
5387  0c5e 2d10          	jrsle	L1642
5389  0c60 c65005        	ld	a,20485
5390  0c63 a504          	bcp	a,#4
5391  0c65 2609          	jrne	L1642
5394  0c67 be6e          	ldw	x,_umin_cnt
5395  0c69 1c0001        	addw	x,#1
5396  0c6c bf6e          	ldw	_umin_cnt,x
5398  0c6e 2003          	jra	L3642
5399  0c70               L1642:
5400                     ; 1158 	else umin_cnt=0;
5402  0c70 5f            	clrw	x
5403  0c71 bf6e          	ldw	_umin_cnt,x
5404  0c73               L3642:
5405                     ; 1159 	gran(&umin_cnt,0,10);	
5407  0c73 ae000a        	ldw	x,#10
5408  0c76 89            	pushw	x
5409  0c77 5f            	clrw	x
5410  0c78 89            	pushw	x
5411  0c79 ae006e        	ldw	x,#_umin_cnt
5412  0c7c cd00d5        	call	_gran
5414  0c7f 5b04          	addw	sp,#4
5415                     ; 1160 	if(umin_cnt>=10)flags|=0b00010000;	  
5417  0c81 9c            	rvf
5418  0c82 be6e          	ldw	x,_umin_cnt
5419  0c84 a3000a        	cpw	x,#10
5420  0c87 2f71          	jrslt	L7642
5423  0c89 72180005      	bset	_flags,#4
5424  0c8d 206b          	jra	L7642
5425  0c8f               L1542:
5426                     ; 1162 else if(jp_mode==jp3)
5428  0c8f b654          	ld	a,_jp_mode
5429  0c91 a103          	cp	a,#3
5430  0c93 2665          	jrne	L7642
5431                     ; 1164 	if(Ui>700)umax_cnt++;
5433  0c95 9c            	rvf
5434  0c96 ce0014        	ldw	x,_Ui
5435  0c99 a302bd        	cpw	x,#701
5436  0c9c 2f09          	jrslt	L3742
5439  0c9e be70          	ldw	x,_umax_cnt
5440  0ca0 1c0001        	addw	x,#1
5441  0ca3 bf70          	ldw	_umax_cnt,x
5443  0ca5 2003          	jra	L5742
5444  0ca7               L3742:
5445                     ; 1165 	else umax_cnt=0;
5447  0ca7 5f            	clrw	x
5448  0ca8 bf70          	ldw	_umax_cnt,x
5449  0caa               L5742:
5450                     ; 1166 	gran(&umax_cnt,0,10);
5452  0caa ae000a        	ldw	x,#10
5453  0cad 89            	pushw	x
5454  0cae 5f            	clrw	x
5455  0caf 89            	pushw	x
5456  0cb0 ae0070        	ldw	x,#_umax_cnt
5457  0cb3 cd00d5        	call	_gran
5459  0cb6 5b04          	addw	sp,#4
5460                     ; 1167 	if(umax_cnt>=10)flags|=0b00001000;
5462  0cb8 9c            	rvf
5463  0cb9 be70          	ldw	x,_umax_cnt
5464  0cbb a3000a        	cpw	x,#10
5465  0cbe 2f04          	jrslt	L7742
5468  0cc0 72160005      	bset	_flags,#3
5469  0cc4               L7742:
5470                     ; 1170 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5472  0cc4 9c            	rvf
5473  0cc5 ce0014        	ldw	x,_Ui
5474  0cc8 a300c8        	cpw	x,#200
5475  0ccb 2e10          	jrsge	L1052
5477  0ccd c65005        	ld	a,20485
5478  0cd0 a504          	bcp	a,#4
5479  0cd2 2609          	jrne	L1052
5482  0cd4 be6e          	ldw	x,_umin_cnt
5483  0cd6 1c0001        	addw	x,#1
5484  0cd9 bf6e          	ldw	_umin_cnt,x
5486  0cdb 2003          	jra	L3052
5487  0cdd               L1052:
5488                     ; 1171 	else umin_cnt=0;
5490  0cdd 5f            	clrw	x
5491  0cde bf6e          	ldw	_umin_cnt,x
5492  0ce0               L3052:
5493                     ; 1172 	gran(&umin_cnt,0,10);	
5495  0ce0 ae000a        	ldw	x,#10
5496  0ce3 89            	pushw	x
5497  0ce4 5f            	clrw	x
5498  0ce5 89            	pushw	x
5499  0ce6 ae006e        	ldw	x,#_umin_cnt
5500  0ce9 cd00d5        	call	_gran
5502  0cec 5b04          	addw	sp,#4
5503                     ; 1173 	if(umin_cnt>=10)flags|=0b00010000;	  
5505  0cee 9c            	rvf
5506  0cef be6e          	ldw	x,_umin_cnt
5507  0cf1 a3000a        	cpw	x,#10
5508  0cf4 2f04          	jrslt	L7642
5511  0cf6 72180005      	bset	_flags,#4
5512  0cfa               L7642:
5513                     ; 1175 }
5516  0cfa 81            	ret
5542                     ; 1200 void apv_start(void)
5542                     ; 1201 {
5543                     	switch	.text
5544  0cfb               _apv_start:
5548                     ; 1202 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5550  0cfb 3d4f          	tnz	_apv_cnt
5551  0cfd 2624          	jrne	L7152
5553  0cff 3d50          	tnz	_apv_cnt+1
5554  0d01 2620          	jrne	L7152
5556  0d03 3d51          	tnz	_apv_cnt+2
5557  0d05 261c          	jrne	L7152
5559                     	btst	_bAPV
5560  0d0c 2515          	jrult	L7152
5561                     ; 1204 	apv_cnt[0]=60;
5563  0d0e 353c004f      	mov	_apv_cnt,#60
5564                     ; 1205 	apv_cnt[1]=60;
5566  0d12 353c0050      	mov	_apv_cnt+1,#60
5567                     ; 1206 	apv_cnt[2]=60;
5569  0d16 353c0051      	mov	_apv_cnt+2,#60
5570                     ; 1207 	apv_cnt_=3600;
5572  0d1a ae0e10        	ldw	x,#3600
5573  0d1d bf4d          	ldw	_apv_cnt_,x
5574                     ; 1208 	bAPV=1;	
5576  0d1f 72100002      	bset	_bAPV
5577  0d23               L7152:
5578                     ; 1210 }
5581  0d23 81            	ret
5607                     ; 1213 void apv_stop(void)
5607                     ; 1214 {
5608                     	switch	.text
5609  0d24               _apv_stop:
5613                     ; 1215 apv_cnt[0]=0;
5615  0d24 3f4f          	clr	_apv_cnt
5616                     ; 1216 apv_cnt[1]=0;
5618  0d26 3f50          	clr	_apv_cnt+1
5619                     ; 1217 apv_cnt[2]=0;
5621  0d28 3f51          	clr	_apv_cnt+2
5622                     ; 1218 apv_cnt_=0;	
5624  0d2a 5f            	clrw	x
5625  0d2b bf4d          	ldw	_apv_cnt_,x
5626                     ; 1219 bAPV=0;
5628  0d2d 72110002      	bres	_bAPV
5629                     ; 1220 }
5632  0d31 81            	ret
5667                     ; 1224 void apv_hndl(void)
5667                     ; 1225 {
5668                     	switch	.text
5669  0d32               _apv_hndl:
5673                     ; 1226 if(apv_cnt[0])
5675  0d32 3d4f          	tnz	_apv_cnt
5676  0d34 271e          	jreq	L1452
5677                     ; 1228 	apv_cnt[0]--;
5679  0d36 3a4f          	dec	_apv_cnt
5680                     ; 1229 	if(apv_cnt[0]==0)
5682  0d38 3d4f          	tnz	_apv_cnt
5683  0d3a 265a          	jrne	L5452
5684                     ; 1231 		flags&=0b11100001;
5686  0d3c b605          	ld	a,_flags
5687  0d3e a4e1          	and	a,#225
5688  0d40 b705          	ld	_flags,a
5689                     ; 1232 		tsign_cnt=0;
5691  0d42 5f            	clrw	x
5692  0d43 bf59          	ldw	_tsign_cnt,x
5693                     ; 1233 		tmax_cnt=0;
5695  0d45 5f            	clrw	x
5696  0d46 bf57          	ldw	_tmax_cnt,x
5697                     ; 1234 		umax_cnt=0;
5699  0d48 5f            	clrw	x
5700  0d49 bf70          	ldw	_umax_cnt,x
5701                     ; 1235 		umin_cnt=0;
5703  0d4b 5f            	clrw	x
5704  0d4c bf6e          	ldw	_umin_cnt,x
5705                     ; 1237 		led_drv_cnt=30;
5707  0d4e 351e0016      	mov	_led_drv_cnt,#30
5708  0d52 2042          	jra	L5452
5709  0d54               L1452:
5710                     ; 1240 else if(apv_cnt[1])
5712  0d54 3d50          	tnz	_apv_cnt+1
5713  0d56 271e          	jreq	L7452
5714                     ; 1242 	apv_cnt[1]--;
5716  0d58 3a50          	dec	_apv_cnt+1
5717                     ; 1243 	if(apv_cnt[1]==0)
5719  0d5a 3d50          	tnz	_apv_cnt+1
5720  0d5c 2638          	jrne	L5452
5721                     ; 1245 		flags&=0b11100001;
5723  0d5e b605          	ld	a,_flags
5724  0d60 a4e1          	and	a,#225
5725  0d62 b705          	ld	_flags,a
5726                     ; 1246 		tsign_cnt=0;
5728  0d64 5f            	clrw	x
5729  0d65 bf59          	ldw	_tsign_cnt,x
5730                     ; 1247 		tmax_cnt=0;
5732  0d67 5f            	clrw	x
5733  0d68 bf57          	ldw	_tmax_cnt,x
5734                     ; 1248 		umax_cnt=0;
5736  0d6a 5f            	clrw	x
5737  0d6b bf70          	ldw	_umax_cnt,x
5738                     ; 1249 		umin_cnt=0;
5740  0d6d 5f            	clrw	x
5741  0d6e bf6e          	ldw	_umin_cnt,x
5742                     ; 1251 		led_drv_cnt=30;
5744  0d70 351e0016      	mov	_led_drv_cnt,#30
5745  0d74 2020          	jra	L5452
5746  0d76               L7452:
5747                     ; 1254 else if(apv_cnt[2])
5749  0d76 3d51          	tnz	_apv_cnt+2
5750  0d78 271c          	jreq	L5452
5751                     ; 1256 	apv_cnt[2]--;
5753  0d7a 3a51          	dec	_apv_cnt+2
5754                     ; 1257 	if(apv_cnt[2]==0)
5756  0d7c 3d51          	tnz	_apv_cnt+2
5757  0d7e 2616          	jrne	L5452
5758                     ; 1259 		flags&=0b11100001;
5760  0d80 b605          	ld	a,_flags
5761  0d82 a4e1          	and	a,#225
5762  0d84 b705          	ld	_flags,a
5763                     ; 1260 		tsign_cnt=0;
5765  0d86 5f            	clrw	x
5766  0d87 bf59          	ldw	_tsign_cnt,x
5767                     ; 1261 		tmax_cnt=0;
5769  0d89 5f            	clrw	x
5770  0d8a bf57          	ldw	_tmax_cnt,x
5771                     ; 1262 		umax_cnt=0;
5773  0d8c 5f            	clrw	x
5774  0d8d bf70          	ldw	_umax_cnt,x
5775                     ; 1263 		umin_cnt=0;          
5777  0d8f 5f            	clrw	x
5778  0d90 bf6e          	ldw	_umin_cnt,x
5779                     ; 1265 		led_drv_cnt=30;
5781  0d92 351e0016      	mov	_led_drv_cnt,#30
5782  0d96               L5452:
5783                     ; 1269 if(apv_cnt_)
5785  0d96 be4d          	ldw	x,_apv_cnt_
5786  0d98 2712          	jreq	L1652
5787                     ; 1271 	apv_cnt_--;
5789  0d9a be4d          	ldw	x,_apv_cnt_
5790  0d9c 1d0001        	subw	x,#1
5791  0d9f bf4d          	ldw	_apv_cnt_,x
5792                     ; 1272 	if(apv_cnt_==0) 
5794  0da1 be4d          	ldw	x,_apv_cnt_
5795  0da3 2607          	jrne	L1652
5796                     ; 1274 		bAPV=0;
5798  0da5 72110002      	bres	_bAPV
5799                     ; 1275 		apv_start();
5801  0da9 cd0cfb        	call	_apv_start
5803  0dac               L1652:
5804                     ; 1279 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5806  0dac be6e          	ldw	x,_umin_cnt
5807  0dae 261e          	jrne	L5652
5809  0db0 be70          	ldw	x,_umax_cnt
5810  0db2 261a          	jrne	L5652
5812  0db4 c65005        	ld	a,20485
5813  0db7 a504          	bcp	a,#4
5814  0db9 2613          	jrne	L5652
5815                     ; 1281 	if(cnt_apv_off<20)
5817  0dbb b64c          	ld	a,_cnt_apv_off
5818  0dbd a114          	cp	a,#20
5819  0dbf 240f          	jruge	L3752
5820                     ; 1283 		cnt_apv_off++;
5822  0dc1 3c4c          	inc	_cnt_apv_off
5823                     ; 1284 		if(cnt_apv_off>=20)
5825  0dc3 b64c          	ld	a,_cnt_apv_off
5826  0dc5 a114          	cp	a,#20
5827  0dc7 2507          	jrult	L3752
5828                     ; 1286 			apv_stop();
5830  0dc9 cd0d24        	call	_apv_stop
5832  0dcc 2002          	jra	L3752
5833  0dce               L5652:
5834                     ; 1290 else cnt_apv_off=0;	
5836  0dce 3f4c          	clr	_cnt_apv_off
5837  0dd0               L3752:
5838                     ; 1292 }
5841  0dd0 81            	ret
5844                     	switch	.ubsct
5845  0000               L5752_flags_old:
5846  0000 00            	ds.b	1
5882                     ; 1295 void flags_drv(void)
5882                     ; 1296 {
5883                     	switch	.text
5884  0dd1               _flags_drv:
5888                     ; 1298 if(jp_mode!=jp3) 
5890  0dd1 b654          	ld	a,_jp_mode
5891  0dd3 a103          	cp	a,#3
5892  0dd5 2723          	jreq	L5162
5893                     ; 1300 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5895  0dd7 b605          	ld	a,_flags
5896  0dd9 a508          	bcp	a,#8
5897  0ddb 2706          	jreq	L3262
5899  0ddd b600          	ld	a,L5752_flags_old
5900  0ddf a508          	bcp	a,#8
5901  0de1 270c          	jreq	L1262
5902  0de3               L3262:
5904  0de3 b605          	ld	a,_flags
5905  0de5 a510          	bcp	a,#16
5906  0de7 2726          	jreq	L7262
5908  0de9 b600          	ld	a,L5752_flags_old
5909  0deb a510          	bcp	a,#16
5910  0ded 2620          	jrne	L7262
5911  0def               L1262:
5912                     ; 1302     		if(link==OFF)apv_start();
5914  0def b66d          	ld	a,_link
5915  0df1 a1aa          	cp	a,#170
5916  0df3 261a          	jrne	L7262
5919  0df5 cd0cfb        	call	_apv_start
5921  0df8 2015          	jra	L7262
5922  0dfa               L5162:
5923                     ; 1305 else if(jp_mode==jp3) 
5925  0dfa b654          	ld	a,_jp_mode
5926  0dfc a103          	cp	a,#3
5927  0dfe 260f          	jrne	L7262
5928                     ; 1307 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5930  0e00 b605          	ld	a,_flags
5931  0e02 a508          	bcp	a,#8
5932  0e04 2709          	jreq	L7262
5934  0e06 b600          	ld	a,L5752_flags_old
5935  0e08 a508          	bcp	a,#8
5936  0e0a 2603          	jrne	L7262
5937                     ; 1309     		apv_start();
5939  0e0c cd0cfb        	call	_apv_start
5941  0e0f               L7262:
5942                     ; 1312 flags_old=flags;
5944  0e0f 450500        	mov	L5752_flags_old,_flags
5945                     ; 1314 } 
5948  0e12 81            	ret
5983                     ; 1451 void adr_drv_v4(char in)
5983                     ; 1452 {
5984                     	switch	.text
5985  0e13               _adr_drv_v4:
5989                     ; 1453 if(adress!=in)adress=in;
5991  0e13 c100ff        	cp	a,_adress
5992  0e16 2703          	jreq	L3562
5995  0e18 c700ff        	ld	_adress,a
5996  0e1b               L3562:
5997                     ; 1454 }
6000  0e1b 81            	ret
6029                     ; 1457 void adr_drv_v3(void)
6029                     ; 1458 {
6030                     	switch	.text
6031  0e1c               _adr_drv_v3:
6033  0e1c 88            	push	a
6034       00000001      OFST:	set	1
6037                     ; 1464 GPIOB->DDR&=~(1<<0);
6039  0e1d 72115007      	bres	20487,#0
6040                     ; 1465 GPIOB->CR1&=~(1<<0);
6042  0e21 72115008      	bres	20488,#0
6043                     ; 1466 GPIOB->CR2&=~(1<<0);
6045  0e25 72115009      	bres	20489,#0
6046                     ; 1467 ADC2->CR2=0x08;
6048  0e29 35085402      	mov	21506,#8
6049                     ; 1468 ADC2->CR1=0x40;
6051  0e2d 35405401      	mov	21505,#64
6052                     ; 1469 ADC2->CSR=0x20+0;
6054  0e31 35205400      	mov	21504,#32
6055                     ; 1470 ADC2->CR1|=1;
6057  0e35 72105401      	bset	21505,#0
6058                     ; 1471 ADC2->CR1|=1;
6060  0e39 72105401      	bset	21505,#0
6061                     ; 1472 adr_drv_stat=1;
6063  0e3d 35010002      	mov	_adr_drv_stat,#1
6064  0e41               L5662:
6065                     ; 1473 while(adr_drv_stat==1);
6068  0e41 b602          	ld	a,_adr_drv_stat
6069  0e43 a101          	cp	a,#1
6070  0e45 27fa          	jreq	L5662
6071                     ; 1475 GPIOB->DDR&=~(1<<1);
6073  0e47 72135007      	bres	20487,#1
6074                     ; 1476 GPIOB->CR1&=~(1<<1);
6076  0e4b 72135008      	bres	20488,#1
6077                     ; 1477 GPIOB->CR2&=~(1<<1);
6079  0e4f 72135009      	bres	20489,#1
6080                     ; 1478 ADC2->CR2=0x08;
6082  0e53 35085402      	mov	21506,#8
6083                     ; 1479 ADC2->CR1=0x40;
6085  0e57 35405401      	mov	21505,#64
6086                     ; 1480 ADC2->CSR=0x20+1;
6088  0e5b 35215400      	mov	21504,#33
6089                     ; 1481 ADC2->CR1|=1;
6091  0e5f 72105401      	bset	21505,#0
6092                     ; 1482 ADC2->CR1|=1;
6094  0e63 72105401      	bset	21505,#0
6095                     ; 1483 adr_drv_stat=3;
6097  0e67 35030002      	mov	_adr_drv_stat,#3
6098  0e6b               L3762:
6099                     ; 1484 while(adr_drv_stat==3);
6102  0e6b b602          	ld	a,_adr_drv_stat
6103  0e6d a103          	cp	a,#3
6104  0e6f 27fa          	jreq	L3762
6105                     ; 1486 GPIOE->DDR&=~(1<<6);
6107  0e71 721d5016      	bres	20502,#6
6108                     ; 1487 GPIOE->CR1&=~(1<<6);
6110  0e75 721d5017      	bres	20503,#6
6111                     ; 1488 GPIOE->CR2&=~(1<<6);
6113  0e79 721d5018      	bres	20504,#6
6114                     ; 1489 ADC2->CR2=0x08;
6116  0e7d 35085402      	mov	21506,#8
6117                     ; 1490 ADC2->CR1=0x40;
6119  0e81 35405401      	mov	21505,#64
6120                     ; 1491 ADC2->CSR=0x20+9;
6122  0e85 35295400      	mov	21504,#41
6123                     ; 1492 ADC2->CR1|=1;
6125  0e89 72105401      	bset	21505,#0
6126                     ; 1493 ADC2->CR1|=1;
6128  0e8d 72105401      	bset	21505,#0
6129                     ; 1494 adr_drv_stat=5;
6131  0e91 35050002      	mov	_adr_drv_stat,#5
6132  0e95               L1072:
6133                     ; 1495 while(adr_drv_stat==5);
6136  0e95 b602          	ld	a,_adr_drv_stat
6137  0e97 a105          	cp	a,#5
6138  0e99 27fa          	jreq	L1072
6139                     ; 1499 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6141  0e9b 9c            	rvf
6142  0e9c ce0107        	ldw	x,_adc_buff_
6143  0e9f a3022a        	cpw	x,#554
6144  0ea2 2f0f          	jrslt	L7072
6146  0ea4 9c            	rvf
6147  0ea5 ce0107        	ldw	x,_adc_buff_
6148  0ea8 a30253        	cpw	x,#595
6149  0eab 2e06          	jrsge	L7072
6152  0ead 725f0100      	clr	_adr
6154  0eb1 204c          	jra	L1172
6155  0eb3               L7072:
6156                     ; 1500 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6158  0eb3 9c            	rvf
6159  0eb4 ce0107        	ldw	x,_adc_buff_
6160  0eb7 a3036d        	cpw	x,#877
6161  0eba 2f0f          	jrslt	L3172
6163  0ebc 9c            	rvf
6164  0ebd ce0107        	ldw	x,_adc_buff_
6165  0ec0 a30396        	cpw	x,#918
6166  0ec3 2e06          	jrsge	L3172
6169  0ec5 35010100      	mov	_adr,#1
6171  0ec9 2034          	jra	L1172
6172  0ecb               L3172:
6173                     ; 1501 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6175  0ecb 9c            	rvf
6176  0ecc ce0107        	ldw	x,_adc_buff_
6177  0ecf a302a3        	cpw	x,#675
6178  0ed2 2f0f          	jrslt	L7172
6180  0ed4 9c            	rvf
6181  0ed5 ce0107        	ldw	x,_adc_buff_
6182  0ed8 a302cc        	cpw	x,#716
6183  0edb 2e06          	jrsge	L7172
6186  0edd 35020100      	mov	_adr,#2
6188  0ee1 201c          	jra	L1172
6189  0ee3               L7172:
6190                     ; 1502 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6192  0ee3 9c            	rvf
6193  0ee4 ce0107        	ldw	x,_adc_buff_
6194  0ee7 a303e3        	cpw	x,#995
6195  0eea 2f0f          	jrslt	L3272
6197  0eec 9c            	rvf
6198  0eed ce0107        	ldw	x,_adc_buff_
6199  0ef0 a3040c        	cpw	x,#1036
6200  0ef3 2e06          	jrsge	L3272
6203  0ef5 35030100      	mov	_adr,#3
6205  0ef9 2004          	jra	L1172
6206  0efb               L3272:
6207                     ; 1503 else adr[0]=5;
6209  0efb 35050100      	mov	_adr,#5
6210  0eff               L1172:
6211                     ; 1505 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6213  0eff 9c            	rvf
6214  0f00 ce0109        	ldw	x,_adc_buff_+2
6215  0f03 a3022a        	cpw	x,#554
6216  0f06 2f0f          	jrslt	L7272
6218  0f08 9c            	rvf
6219  0f09 ce0109        	ldw	x,_adc_buff_+2
6220  0f0c a30253        	cpw	x,#595
6221  0f0f 2e06          	jrsge	L7272
6224  0f11 725f0101      	clr	_adr+1
6226  0f15 204c          	jra	L1372
6227  0f17               L7272:
6228                     ; 1506 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6230  0f17 9c            	rvf
6231  0f18 ce0109        	ldw	x,_adc_buff_+2
6232  0f1b a3036d        	cpw	x,#877
6233  0f1e 2f0f          	jrslt	L3372
6235  0f20 9c            	rvf
6236  0f21 ce0109        	ldw	x,_adc_buff_+2
6237  0f24 a30396        	cpw	x,#918
6238  0f27 2e06          	jrsge	L3372
6241  0f29 35010101      	mov	_adr+1,#1
6243  0f2d 2034          	jra	L1372
6244  0f2f               L3372:
6245                     ; 1507 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6247  0f2f 9c            	rvf
6248  0f30 ce0109        	ldw	x,_adc_buff_+2
6249  0f33 a302a3        	cpw	x,#675
6250  0f36 2f0f          	jrslt	L7372
6252  0f38 9c            	rvf
6253  0f39 ce0109        	ldw	x,_adc_buff_+2
6254  0f3c a302cc        	cpw	x,#716
6255  0f3f 2e06          	jrsge	L7372
6258  0f41 35020101      	mov	_adr+1,#2
6260  0f45 201c          	jra	L1372
6261  0f47               L7372:
6262                     ; 1508 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6264  0f47 9c            	rvf
6265  0f48 ce0109        	ldw	x,_adc_buff_+2
6266  0f4b a303e3        	cpw	x,#995
6267  0f4e 2f0f          	jrslt	L3472
6269  0f50 9c            	rvf
6270  0f51 ce0109        	ldw	x,_adc_buff_+2
6271  0f54 a3040c        	cpw	x,#1036
6272  0f57 2e06          	jrsge	L3472
6275  0f59 35030101      	mov	_adr+1,#3
6277  0f5d 2004          	jra	L1372
6278  0f5f               L3472:
6279                     ; 1509 else adr[1]=5;
6281  0f5f 35050101      	mov	_adr+1,#5
6282  0f63               L1372:
6283                     ; 1511 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6285  0f63 9c            	rvf
6286  0f64 ce0119        	ldw	x,_adc_buff_+18
6287  0f67 a3022a        	cpw	x,#554
6288  0f6a 2f0f          	jrslt	L7472
6290  0f6c 9c            	rvf
6291  0f6d ce0119        	ldw	x,_adc_buff_+18
6292  0f70 a30253        	cpw	x,#595
6293  0f73 2e06          	jrsge	L7472
6296  0f75 725f0102      	clr	_adr+2
6298  0f79 204c          	jra	L1572
6299  0f7b               L7472:
6300                     ; 1512 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6302  0f7b 9c            	rvf
6303  0f7c ce0119        	ldw	x,_adc_buff_+18
6304  0f7f a3036d        	cpw	x,#877
6305  0f82 2f0f          	jrslt	L3572
6307  0f84 9c            	rvf
6308  0f85 ce0119        	ldw	x,_adc_buff_+18
6309  0f88 a30396        	cpw	x,#918
6310  0f8b 2e06          	jrsge	L3572
6313  0f8d 35010102      	mov	_adr+2,#1
6315  0f91 2034          	jra	L1572
6316  0f93               L3572:
6317                     ; 1513 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6319  0f93 9c            	rvf
6320  0f94 ce0119        	ldw	x,_adc_buff_+18
6321  0f97 a302a3        	cpw	x,#675
6322  0f9a 2f0f          	jrslt	L7572
6324  0f9c 9c            	rvf
6325  0f9d ce0119        	ldw	x,_adc_buff_+18
6326  0fa0 a302cc        	cpw	x,#716
6327  0fa3 2e06          	jrsge	L7572
6330  0fa5 35020102      	mov	_adr+2,#2
6332  0fa9 201c          	jra	L1572
6333  0fab               L7572:
6334                     ; 1514 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6336  0fab 9c            	rvf
6337  0fac ce0119        	ldw	x,_adc_buff_+18
6338  0faf a303e3        	cpw	x,#995
6339  0fb2 2f0f          	jrslt	L3672
6341  0fb4 9c            	rvf
6342  0fb5 ce0119        	ldw	x,_adc_buff_+18
6343  0fb8 a3040c        	cpw	x,#1036
6344  0fbb 2e06          	jrsge	L3672
6347  0fbd 35030102      	mov	_adr+2,#3
6349  0fc1 2004          	jra	L1572
6350  0fc3               L3672:
6351                     ; 1515 else adr[2]=5;
6353  0fc3 35050102      	mov	_adr+2,#5
6354  0fc7               L1572:
6355                     ; 1519 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6357  0fc7 c60100        	ld	a,_adr
6358  0fca a105          	cp	a,#5
6359  0fcc 270e          	jreq	L1772
6361  0fce c60101        	ld	a,_adr+1
6362  0fd1 a105          	cp	a,#5
6363  0fd3 2707          	jreq	L1772
6365  0fd5 c60102        	ld	a,_adr+2
6366  0fd8 a105          	cp	a,#5
6367  0fda 2606          	jrne	L7672
6368  0fdc               L1772:
6369                     ; 1522 	adress_error=1;
6371  0fdc 350100fe      	mov	_adress_error,#1
6373  0fe0               L5772:
6374                     ; 1533 }
6377  0fe0 84            	pop	a
6378  0fe1 81            	ret
6379  0fe2               L7672:
6380                     ; 1526 	if(adr[2]&0x02) bps_class=bpsIPS;
6382  0fe2 c60102        	ld	a,_adr+2
6383  0fe5 a502          	bcp	a,#2
6384  0fe7 2706          	jreq	L7772
6387  0fe9 3501000b      	mov	_bps_class,#1
6389  0fed 2002          	jra	L1003
6390  0fef               L7772:
6391                     ; 1527 	else bps_class=bpsIBEP;
6393  0fef 3f0b          	clr	_bps_class
6394  0ff1               L1003:
6395                     ; 1529 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6397  0ff1 c60102        	ld	a,_adr+2
6398  0ff4 a401          	and	a,#1
6399  0ff6 97            	ld	xl,a
6400  0ff7 a610          	ld	a,#16
6401  0ff9 42            	mul	x,a
6402  0ffa 9f            	ld	a,xl
6403  0ffb 6b01          	ld	(OFST+0,sp),a
6404  0ffd c60101        	ld	a,_adr+1
6405  1000 48            	sll	a
6406  1001 48            	sll	a
6407  1002 cb0100        	add	a,_adr
6408  1005 1b01          	add	a,(OFST+0,sp)
6409  1007 c700ff        	ld	_adress,a
6410  100a 20d4          	jra	L5772
6433                     ; 1583 void init_CAN(void) {
6434                     	switch	.text
6435  100c               _init_CAN:
6439                     ; 1584 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6441  100c 72135420      	bres	21536,#1
6442                     ; 1585 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6444  1010 72105420      	bset	21536,#0
6446  1014               L5103:
6447                     ; 1586 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6449  1014 c65421        	ld	a,21537
6450  1017 a501          	bcp	a,#1
6451  1019 27f9          	jreq	L5103
6452                     ; 1588 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6454  101b 72185420      	bset	21536,#4
6455                     ; 1590 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6457  101f 35025427      	mov	21543,#2
6458                     ; 1599 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6460  1023 35135428      	mov	21544,#19
6461                     ; 1600 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6463  1027 35c05429      	mov	21545,#192
6464                     ; 1601 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6466  102b 357f542c      	mov	21548,#127
6467                     ; 1602 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6469  102f 35e0542d      	mov	21549,#224
6470                     ; 1604 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6472  1033 35315430      	mov	21552,#49
6473                     ; 1605 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6475  1037 35c05431      	mov	21553,#192
6476                     ; 1606 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6478  103b 357f5434      	mov	21556,#127
6479                     ; 1607 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6481  103f 35e05435      	mov	21557,#224
6482                     ; 1611 	CAN->PSR= 6;									// set page 6
6484  1043 35065427      	mov	21543,#6
6485                     ; 1616 	CAN->Page.Config.FMR1&=~3;								//mask mode
6487  1047 c65430        	ld	a,21552
6488  104a a4fc          	and	a,#252
6489  104c c75430        	ld	21552,a
6490                     ; 1622 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6492  104f 35065432      	mov	21554,#6
6493                     ; 1623 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6495  1053 35605432      	mov	21554,#96
6496                     ; 1626 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6498  1057 72105432      	bset	21554,#0
6499                     ; 1627 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6501  105b 72185432      	bset	21554,#4
6502                     ; 1630 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6504  105f 35065427      	mov	21543,#6
6505                     ; 1632 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6507  1063 35d3542c      	mov	21548,#211
6508                     ; 1633 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6510  1067 35e7542d      	mov	21549,#231
6511                     ; 1635 	CAN->IER|=(1<<1);
6513  106b 72125425      	bset	21541,#1
6514                     ; 1638 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6516  106f 72115420      	bres	21536,#0
6518  1073               L3203:
6519                     ; 1639 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6521  1073 c65421        	ld	a,21537
6522  1076 a501          	bcp	a,#1
6523  1078 26f9          	jrne	L3203
6524                     ; 1640 }
6527  107a 81            	ret
6635                     ; 1643 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6635                     ; 1644 {
6636                     	switch	.text
6637  107b               _can_transmit:
6639  107b 89            	pushw	x
6640       00000000      OFST:	set	0
6643                     ; 1646 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6645  107c b676          	ld	a,_can_buff_wr_ptr
6646  107e a104          	cp	a,#4
6647  1080 2502          	jrult	L5013
6650  1082 3f76          	clr	_can_buff_wr_ptr
6651  1084               L5013:
6652                     ; 1648 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6654  1084 b676          	ld	a,_can_buff_wr_ptr
6655  1086 97            	ld	xl,a
6656  1087 a610          	ld	a,#16
6657  1089 42            	mul	x,a
6658  108a 1601          	ldw	y,(OFST+1,sp)
6659  108c a606          	ld	a,#6
6660  108e               L431:
6661  108e 9054          	srlw	y
6662  1090 4a            	dec	a
6663  1091 26fb          	jrne	L431
6664  1093 909f          	ld	a,yl
6665  1095 e777          	ld	(_can_out_buff,x),a
6666                     ; 1649 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6668  1097 b676          	ld	a,_can_buff_wr_ptr
6669  1099 97            	ld	xl,a
6670  109a a610          	ld	a,#16
6671  109c 42            	mul	x,a
6672  109d 7b02          	ld	a,(OFST+2,sp)
6673  109f 48            	sll	a
6674  10a0 48            	sll	a
6675  10a1 e778          	ld	(_can_out_buff+1,x),a
6676                     ; 1651 can_out_buff[can_buff_wr_ptr][2]=data0;
6678  10a3 b676          	ld	a,_can_buff_wr_ptr
6679  10a5 97            	ld	xl,a
6680  10a6 a610          	ld	a,#16
6681  10a8 42            	mul	x,a
6682  10a9 7b05          	ld	a,(OFST+5,sp)
6683  10ab e779          	ld	(_can_out_buff+2,x),a
6684                     ; 1652 can_out_buff[can_buff_wr_ptr][3]=data1;
6686  10ad b676          	ld	a,_can_buff_wr_ptr
6687  10af 97            	ld	xl,a
6688  10b0 a610          	ld	a,#16
6689  10b2 42            	mul	x,a
6690  10b3 7b06          	ld	a,(OFST+6,sp)
6691  10b5 e77a          	ld	(_can_out_buff+3,x),a
6692                     ; 1653 can_out_buff[can_buff_wr_ptr][4]=data2;
6694  10b7 b676          	ld	a,_can_buff_wr_ptr
6695  10b9 97            	ld	xl,a
6696  10ba a610          	ld	a,#16
6697  10bc 42            	mul	x,a
6698  10bd 7b07          	ld	a,(OFST+7,sp)
6699  10bf e77b          	ld	(_can_out_buff+4,x),a
6700                     ; 1654 can_out_buff[can_buff_wr_ptr][5]=data3;
6702  10c1 b676          	ld	a,_can_buff_wr_ptr
6703  10c3 97            	ld	xl,a
6704  10c4 a610          	ld	a,#16
6705  10c6 42            	mul	x,a
6706  10c7 7b08          	ld	a,(OFST+8,sp)
6707  10c9 e77c          	ld	(_can_out_buff+5,x),a
6708                     ; 1655 can_out_buff[can_buff_wr_ptr][6]=data4;
6710  10cb b676          	ld	a,_can_buff_wr_ptr
6711  10cd 97            	ld	xl,a
6712  10ce a610          	ld	a,#16
6713  10d0 42            	mul	x,a
6714  10d1 7b09          	ld	a,(OFST+9,sp)
6715  10d3 e77d          	ld	(_can_out_buff+6,x),a
6716                     ; 1656 can_out_buff[can_buff_wr_ptr][7]=data5;
6718  10d5 b676          	ld	a,_can_buff_wr_ptr
6719  10d7 97            	ld	xl,a
6720  10d8 a610          	ld	a,#16
6721  10da 42            	mul	x,a
6722  10db 7b0a          	ld	a,(OFST+10,sp)
6723  10dd e77e          	ld	(_can_out_buff+7,x),a
6724                     ; 1657 can_out_buff[can_buff_wr_ptr][8]=data6;
6726  10df b676          	ld	a,_can_buff_wr_ptr
6727  10e1 97            	ld	xl,a
6728  10e2 a610          	ld	a,#16
6729  10e4 42            	mul	x,a
6730  10e5 7b0b          	ld	a,(OFST+11,sp)
6731  10e7 e77f          	ld	(_can_out_buff+8,x),a
6732                     ; 1658 can_out_buff[can_buff_wr_ptr][9]=data7;
6734  10e9 b676          	ld	a,_can_buff_wr_ptr
6735  10eb 97            	ld	xl,a
6736  10ec a610          	ld	a,#16
6737  10ee 42            	mul	x,a
6738  10ef 7b0c          	ld	a,(OFST+12,sp)
6739  10f1 e780          	ld	(_can_out_buff+9,x),a
6740                     ; 1660 can_buff_wr_ptr++;
6742  10f3 3c76          	inc	_can_buff_wr_ptr
6743                     ; 1661 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6745  10f5 b676          	ld	a,_can_buff_wr_ptr
6746  10f7 a104          	cp	a,#4
6747  10f9 2502          	jrult	L7013
6750  10fb 3f76          	clr	_can_buff_wr_ptr
6751  10fd               L7013:
6752                     ; 1662 } 
6755  10fd 85            	popw	x
6756  10fe 81            	ret
6785                     ; 1665 void can_tx_hndl(void)
6785                     ; 1666 {
6786                     	switch	.text
6787  10ff               _can_tx_hndl:
6791                     ; 1667 if(bTX_FREE)
6793  10ff 3d03          	tnz	_bTX_FREE
6794  1101 2757          	jreq	L1213
6795                     ; 1669 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6797  1103 b675          	ld	a,_can_buff_rd_ptr
6798  1105 b176          	cp	a,_can_buff_wr_ptr
6799  1107 275f          	jreq	L7213
6800                     ; 1671 		bTX_FREE=0;
6802  1109 3f03          	clr	_bTX_FREE
6803                     ; 1673 		CAN->PSR= 0;
6805  110b 725f5427      	clr	21543
6806                     ; 1674 		CAN->Page.TxMailbox.MDLCR=8;
6808  110f 35085429      	mov	21545,#8
6809                     ; 1675 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6811  1113 b675          	ld	a,_can_buff_rd_ptr
6812  1115 97            	ld	xl,a
6813  1116 a610          	ld	a,#16
6814  1118 42            	mul	x,a
6815  1119 e677          	ld	a,(_can_out_buff,x)
6816  111b c7542a        	ld	21546,a
6817                     ; 1676 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6819  111e b675          	ld	a,_can_buff_rd_ptr
6820  1120 97            	ld	xl,a
6821  1121 a610          	ld	a,#16
6822  1123 42            	mul	x,a
6823  1124 e678          	ld	a,(_can_out_buff+1,x)
6824  1126 c7542b        	ld	21547,a
6825                     ; 1678 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6827  1129 b675          	ld	a,_can_buff_rd_ptr
6828  112b 97            	ld	xl,a
6829  112c a610          	ld	a,#16
6830  112e 42            	mul	x,a
6831  112f 01            	rrwa	x,a
6832  1130 ab79          	add	a,#_can_out_buff+2
6833  1132 2401          	jrnc	L041
6834  1134 5c            	incw	x
6835  1135               L041:
6836  1135 5f            	clrw	x
6837  1136 97            	ld	xl,a
6838  1137 bf00          	ldw	c_x,x
6839  1139 ae0008        	ldw	x,#8
6840  113c               L241:
6841  113c 5a            	decw	x
6842  113d 92d600        	ld	a,([c_x],x)
6843  1140 d7542e        	ld	(21550,x),a
6844  1143 5d            	tnzw	x
6845  1144 26f6          	jrne	L241
6846                     ; 1680 		can_buff_rd_ptr++;
6848  1146 3c75          	inc	_can_buff_rd_ptr
6849                     ; 1681 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6851  1148 b675          	ld	a,_can_buff_rd_ptr
6852  114a a104          	cp	a,#4
6853  114c 2502          	jrult	L5213
6856  114e 3f75          	clr	_can_buff_rd_ptr
6857  1150               L5213:
6858                     ; 1683 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6860  1150 72105428      	bset	21544,#0
6861                     ; 1684 		CAN->IER|=(1<<0);
6863  1154 72105425      	bset	21541,#0
6864  1158 200e          	jra	L7213
6865  115a               L1213:
6866                     ; 1689 	tx_busy_cnt++;
6868  115a 3c74          	inc	_tx_busy_cnt
6869                     ; 1690 	if(tx_busy_cnt>=100)
6871  115c b674          	ld	a,_tx_busy_cnt
6872  115e a164          	cp	a,#100
6873  1160 2506          	jrult	L7213
6874                     ; 1692 		tx_busy_cnt=0;
6876  1162 3f74          	clr	_tx_busy_cnt
6877                     ; 1693 		bTX_FREE=1;
6879  1164 35010003      	mov	_bTX_FREE,#1
6880  1168               L7213:
6881                     ; 1696 }
6884  1168 81            	ret
6999                     ; 1722 void can_in_an(void)
6999                     ; 1723 {
7000                     	switch	.text
7001  1169               _can_in_an:
7003  1169 5207          	subw	sp,#7
7004       00000007      OFST:	set	7
7007                     ; 1733 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7009  116b b6cd          	ld	a,_mess+6
7010  116d c100ff        	cp	a,_adress
7011  1170 2703          	jreq	L261
7012  1172 cc12aa        	jp	L7613
7013  1175               L261:
7015  1175 b6ce          	ld	a,_mess+7
7016  1177 c100ff        	cp	a,_adress
7017  117a 2703          	jreq	L461
7018  117c cc12aa        	jp	L7613
7019  117f               L461:
7021  117f b6cf          	ld	a,_mess+8
7022  1181 a1ed          	cp	a,#237
7023  1183 2703          	jreq	L661
7024  1185 cc12aa        	jp	L7613
7025  1188               L661:
7026                     ; 1736 	can_error_cnt=0;
7028  1188 3f73          	clr	_can_error_cnt
7029                     ; 1738 	bMAIN=0;
7031  118a 72110001      	bres	_bMAIN
7032                     ; 1739  	flags_tu=mess[9];
7034  118e 45d06a        	mov	_flags_tu,_mess+9
7035                     ; 1740  	if(flags_tu&0b00000001)
7037  1191 b66a          	ld	a,_flags_tu
7038  1193 a501          	bcp	a,#1
7039  1195 2706          	jreq	L1713
7040                     ; 1745  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7042  1197 721a0005      	bset	_flags,#5
7044  119b 2008          	jra	L3713
7045  119d               L1713:
7046                     ; 1756  				flags&=0b11011111; 
7048  119d 721b0005      	bres	_flags,#5
7049                     ; 1757  				off_bp_cnt=5*EE_TZAS;
7051  11a1 350f005d      	mov	_off_bp_cnt,#15
7052  11a5               L3713:
7053                     ; 1763  	if(flags_tu&0b00000010) flags|=0b01000000;
7055  11a5 b66a          	ld	a,_flags_tu
7056  11a7 a502          	bcp	a,#2
7057  11a9 2706          	jreq	L5713
7060  11ab 721c0005      	bset	_flags,#6
7062  11af 2004          	jra	L7713
7063  11b1               L5713:
7064                     ; 1764  	else flags&=0b10111111; 
7066  11b1 721d0005      	bres	_flags,#6
7067  11b5               L7713:
7068                     ; 1766  	U_out_const=mess[10]+mess[11]*256;
7070  11b5 b6d2          	ld	a,_mess+11
7071  11b7 5f            	clrw	x
7072  11b8 97            	ld	xl,a
7073  11b9 4f            	clr	a
7074  11ba 02            	rlwa	x,a
7075  11bb 01            	rrwa	x,a
7076  11bc bbd1          	add	a,_mess+10
7077  11be 2401          	jrnc	L641
7078  11c0 5c            	incw	x
7079  11c1               L641:
7080  11c1 c70011        	ld	_U_out_const+1,a
7081  11c4 9f            	ld	a,xl
7082  11c5 c70010        	ld	_U_out_const,a
7083                     ; 1767  	vol_i_temp=mess[12]+mess[13]*256;  
7085  11c8 b6d4          	ld	a,_mess+13
7086  11ca 5f            	clrw	x
7087  11cb 97            	ld	xl,a
7088  11cc 4f            	clr	a
7089  11cd 02            	rlwa	x,a
7090  11ce 01            	rrwa	x,a
7091  11cf bbd3          	add	a,_mess+12
7092  11d1 2401          	jrnc	L051
7093  11d3 5c            	incw	x
7094  11d4               L051:
7095  11d4 b761          	ld	_vol_i_temp+1,a
7096  11d6 9f            	ld	a,xl
7097  11d7 b760          	ld	_vol_i_temp,a
7098                     ; 1777 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7100  11d9 b608          	ld	a,_vent_resurs_tx_cnt
7101  11db a102          	cp	a,#2
7102  11dd 2507          	jrult	L1023
7105  11df ce0000        	ldw	x,_vent_resurs
7106  11e2 bf41          	ldw	_plazma_int+4,x
7108  11e4 2004          	jra	L3023
7109  11e6               L1023:
7110                     ; 1778 	else plazma_int[2]=vent_resurs_sec_cnt;
7112  11e6 be09          	ldw	x,_vent_resurs_sec_cnt
7113  11e8 bf41          	ldw	_plazma_int+4,x
7114  11ea               L3023:
7115                     ; 1779  	rotor_int=flags_tu+(((short)flags)<<8);
7117  11ea b605          	ld	a,_flags
7118  11ec 5f            	clrw	x
7119  11ed 97            	ld	xl,a
7120  11ee 4f            	clr	a
7121  11ef 02            	rlwa	x,a
7122  11f0 01            	rrwa	x,a
7123  11f1 bb6a          	add	a,_flags_tu
7124  11f3 2401          	jrnc	L251
7125  11f5 5c            	incw	x
7126  11f6               L251:
7127  11f6 b718          	ld	_rotor_int+1,a
7128  11f8 9f            	ld	a,xl
7129  11f9 b717          	ld	_rotor_int,a
7130                     ; 1780 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7132  11fb 3b0014        	push	_Ui
7133  11fe 3b0015        	push	_Ui+1
7134  1201 3b0016        	push	_Un
7135  1204 3b0017        	push	_Un+1
7136  1207 3b0018        	push	_I
7137  120a 3b0019        	push	_I+1
7138  120d 4bda          	push	#218
7139  120f 3b00ff        	push	_adress
7140  1212 ae018e        	ldw	x,#398
7141  1215 cd107b        	call	_can_transmit
7143  1218 5b08          	addw	sp,#8
7144                     ; 1781 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7146  121a 3b000e        	push	_Usum
7147  121d 3b000f        	push	_Usum+1
7148  1220 3b0069        	push	__x_+1
7149  1223 3b0005        	push	_flags
7150  1226 b608          	ld	a,_vent_resurs_tx_cnt
7151  1228 5f            	clrw	x
7152  1229 97            	ld	xl,a
7153  122a d60008        	ld	a,(_vent_resurs_buff,x)
7154  122d 88            	push	a
7155  122e 3b0072        	push	_T
7156  1231 4bdb          	push	#219
7157  1233 3b00ff        	push	_adress
7158  1236 ae018e        	ldw	x,#398
7159  1239 cd107b        	call	_can_transmit
7161  123c 5b08          	addw	sp,#8
7162                     ; 1782 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7164  123e 3b0005        	push	_debug_info_to_uku+4
7165  1241 3b0006        	push	_debug_info_to_uku+5
7166  1244 3b0003        	push	_debug_info_to_uku+2
7167  1247 3b0004        	push	_debug_info_to_uku+3
7168  124a 3b0001        	push	_debug_info_to_uku
7169  124d 3b0002        	push	_debug_info_to_uku+1
7170  1250 4bdc          	push	#220
7171  1252 3b00ff        	push	_adress
7172  1255 ae018e        	ldw	x,#398
7173  1258 cd107b        	call	_can_transmit
7175  125b 5b08          	addw	sp,#8
7176                     ; 1783      link_cnt=0;
7178  125d 5f            	clrw	x
7179  125e bf6b          	ldw	_link_cnt,x
7180                     ; 1784      link=ON;
7182  1260 3555006d      	mov	_link,#85
7183                     ; 1786      if(flags_tu&0b10000000)
7185  1264 b66a          	ld	a,_flags_tu
7186  1266 a580          	bcp	a,#128
7187  1268 2716          	jreq	L5023
7188                     ; 1788      	if(!res_fl)
7190  126a 725d000b      	tnz	_res_fl
7191  126e 2626          	jrne	L1123
7192                     ; 1790      		res_fl=1;
7194  1270 a601          	ld	a,#1
7195  1272 ae000b        	ldw	x,#_res_fl
7196  1275 cd0000        	call	c_eewrc
7198                     ; 1791      		bRES=1;
7200  1278 3501000c      	mov	_bRES,#1
7201                     ; 1792      		res_fl_cnt=0;
7203  127c 3f4b          	clr	_res_fl_cnt
7204  127e 2016          	jra	L1123
7205  1280               L5023:
7206                     ; 1797      	if(main_cnt>20)
7208  1280 9c            	rvf
7209  1281 ce025d        	ldw	x,_main_cnt
7210  1284 a30015        	cpw	x,#21
7211  1287 2f0d          	jrslt	L1123
7212                     ; 1799     			if(res_fl)
7214  1289 725d000b      	tnz	_res_fl
7215  128d 2707          	jreq	L1123
7216                     ; 1801      			res_fl=0;
7218  128f 4f            	clr	a
7219  1290 ae000b        	ldw	x,#_res_fl
7220  1293 cd0000        	call	c_eewrc
7222  1296               L1123:
7223                     ; 1806       if(res_fl_)
7225  1296 725d000a      	tnz	_res_fl_
7226  129a 2603          	jrne	L071
7227  129c cc1811        	jp	L3313
7228  129f               L071:
7229                     ; 1808       	res_fl_=0;
7231  129f 4f            	clr	a
7232  12a0 ae000a        	ldw	x,#_res_fl_
7233  12a3 cd0000        	call	c_eewrc
7235  12a6 ac111811      	jpf	L3313
7236  12aa               L7613:
7237                     ; 1811 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7239  12aa b6cd          	ld	a,_mess+6
7240  12ac c100ff        	cp	a,_adress
7241  12af 2703          	jreq	L271
7242  12b1 cc1527        	jp	L3223
7243  12b4               L271:
7245  12b4 b6ce          	ld	a,_mess+7
7246  12b6 c100ff        	cp	a,_adress
7247  12b9 2703          	jreq	L471
7248  12bb cc1527        	jp	L3223
7249  12be               L471:
7251  12be b6cf          	ld	a,_mess+8
7252  12c0 a1ee          	cp	a,#238
7253  12c2 2703          	jreq	L671
7254  12c4 cc1527        	jp	L3223
7255  12c7               L671:
7257  12c7 b6d0          	ld	a,_mess+9
7258  12c9 b1d1          	cp	a,_mess+10
7259  12cb 2703          	jreq	L002
7260  12cd cc1527        	jp	L3223
7261  12d0               L002:
7262                     ; 1813 	rotor_int++;
7264  12d0 be17          	ldw	x,_rotor_int
7265  12d2 1c0001        	addw	x,#1
7266  12d5 bf17          	ldw	_rotor_int,x
7267                     ; 1814 	if((mess[9]&0xf0)==0x20)
7269  12d7 b6d0          	ld	a,_mess+9
7270  12d9 a4f0          	and	a,#240
7271  12db a120          	cp	a,#32
7272  12dd 2673          	jrne	L5223
7273                     ; 1816 		if((mess[9]&0x0f)==0x01)
7275  12df b6d0          	ld	a,_mess+9
7276  12e1 a40f          	and	a,#15
7277  12e3 a101          	cp	a,#1
7278  12e5 260d          	jrne	L7223
7279                     ; 1818 			ee_K[0][0]=adc_buff_[4];
7281  12e7 ce010f        	ldw	x,_adc_buff_+8
7282  12ea 89            	pushw	x
7283  12eb ae001a        	ldw	x,#_ee_K
7284  12ee cd0000        	call	c_eewrw
7286  12f1 85            	popw	x
7288  12f2 204a          	jra	L1323
7289  12f4               L7223:
7290                     ; 1820 		else if((mess[9]&0x0f)==0x02)
7292  12f4 b6d0          	ld	a,_mess+9
7293  12f6 a40f          	and	a,#15
7294  12f8 a102          	cp	a,#2
7295  12fa 260b          	jrne	L3323
7296                     ; 1822 			ee_K[0][1]++;
7298  12fc ce001c        	ldw	x,_ee_K+2
7299  12ff 1c0001        	addw	x,#1
7300  1302 cf001c        	ldw	_ee_K+2,x
7302  1305 2037          	jra	L1323
7303  1307               L3323:
7304                     ; 1824 		else if((mess[9]&0x0f)==0x03)
7306  1307 b6d0          	ld	a,_mess+9
7307  1309 a40f          	and	a,#15
7308  130b a103          	cp	a,#3
7309  130d 260b          	jrne	L7323
7310                     ; 1826 			ee_K[0][1]+=10;
7312  130f ce001c        	ldw	x,_ee_K+2
7313  1312 1c000a        	addw	x,#10
7314  1315 cf001c        	ldw	_ee_K+2,x
7316  1318 2024          	jra	L1323
7317  131a               L7323:
7318                     ; 1828 		else if((mess[9]&0x0f)==0x04)
7320  131a b6d0          	ld	a,_mess+9
7321  131c a40f          	and	a,#15
7322  131e a104          	cp	a,#4
7323  1320 260b          	jrne	L3423
7324                     ; 1830 			ee_K[0][1]--;
7326  1322 ce001c        	ldw	x,_ee_K+2
7327  1325 1d0001        	subw	x,#1
7328  1328 cf001c        	ldw	_ee_K+2,x
7330  132b 2011          	jra	L1323
7331  132d               L3423:
7332                     ; 1832 		else if((mess[9]&0x0f)==0x05)
7334  132d b6d0          	ld	a,_mess+9
7335  132f a40f          	and	a,#15
7336  1331 a105          	cp	a,#5
7337  1333 2609          	jrne	L1323
7338                     ; 1834 			ee_K[0][1]-=10;
7340  1335 ce001c        	ldw	x,_ee_K+2
7341  1338 1d000a        	subw	x,#10
7342  133b cf001c        	ldw	_ee_K+2,x
7343  133e               L1323:
7344                     ; 1836 		granee(&ee_K[0][1],50,3000);									
7346  133e ae0bb8        	ldw	x,#3000
7347  1341 89            	pushw	x
7348  1342 ae0032        	ldw	x,#50
7349  1345 89            	pushw	x
7350  1346 ae001c        	ldw	x,#_ee_K+2
7351  1349 cd00f6        	call	_granee
7353  134c 5b04          	addw	sp,#4
7355  134e ac0c150c      	jpf	L1523
7356  1352               L5223:
7357                     ; 1838 	else if((mess[9]&0xf0)==0x10)
7359  1352 b6d0          	ld	a,_mess+9
7360  1354 a4f0          	and	a,#240
7361  1356 a110          	cp	a,#16
7362  1358 2673          	jrne	L3523
7363                     ; 1840 		if((mess[9]&0x0f)==0x01)
7365  135a b6d0          	ld	a,_mess+9
7366  135c a40f          	and	a,#15
7367  135e a101          	cp	a,#1
7368  1360 260d          	jrne	L5523
7369                     ; 1842 			ee_K[1][0]=adc_buff_[1];
7371  1362 ce0109        	ldw	x,_adc_buff_+2
7372  1365 89            	pushw	x
7373  1366 ae001e        	ldw	x,#_ee_K+4
7374  1369 cd0000        	call	c_eewrw
7376  136c 85            	popw	x
7378  136d 204a          	jra	L7523
7379  136f               L5523:
7380                     ; 1844 		else if((mess[9]&0x0f)==0x02)
7382  136f b6d0          	ld	a,_mess+9
7383  1371 a40f          	and	a,#15
7384  1373 a102          	cp	a,#2
7385  1375 260b          	jrne	L1623
7386                     ; 1846 			ee_K[1][1]++;
7388  1377 ce0020        	ldw	x,_ee_K+6
7389  137a 1c0001        	addw	x,#1
7390  137d cf0020        	ldw	_ee_K+6,x
7392  1380 2037          	jra	L7523
7393  1382               L1623:
7394                     ; 1848 		else if((mess[9]&0x0f)==0x03)
7396  1382 b6d0          	ld	a,_mess+9
7397  1384 a40f          	and	a,#15
7398  1386 a103          	cp	a,#3
7399  1388 260b          	jrne	L5623
7400                     ; 1850 			ee_K[1][1]+=10;
7402  138a ce0020        	ldw	x,_ee_K+6
7403  138d 1c000a        	addw	x,#10
7404  1390 cf0020        	ldw	_ee_K+6,x
7406  1393 2024          	jra	L7523
7407  1395               L5623:
7408                     ; 1852 		else if((mess[9]&0x0f)==0x04)
7410  1395 b6d0          	ld	a,_mess+9
7411  1397 a40f          	and	a,#15
7412  1399 a104          	cp	a,#4
7413  139b 260b          	jrne	L1723
7414                     ; 1854 			ee_K[1][1]--;
7416  139d ce0020        	ldw	x,_ee_K+6
7417  13a0 1d0001        	subw	x,#1
7418  13a3 cf0020        	ldw	_ee_K+6,x
7420  13a6 2011          	jra	L7523
7421  13a8               L1723:
7422                     ; 1856 		else if((mess[9]&0x0f)==0x05)
7424  13a8 b6d0          	ld	a,_mess+9
7425  13aa a40f          	and	a,#15
7426  13ac a105          	cp	a,#5
7427  13ae 2609          	jrne	L7523
7428                     ; 1858 			ee_K[1][1]-=10;
7430  13b0 ce0020        	ldw	x,_ee_K+6
7431  13b3 1d000a        	subw	x,#10
7432  13b6 cf0020        	ldw	_ee_K+6,x
7433  13b9               L7523:
7434                     ; 1863 		granee(&ee_K[1][1],10,30000);
7436  13b9 ae7530        	ldw	x,#30000
7437  13bc 89            	pushw	x
7438  13bd ae000a        	ldw	x,#10
7439  13c0 89            	pushw	x
7440  13c1 ae0020        	ldw	x,#_ee_K+6
7441  13c4 cd00f6        	call	_granee
7443  13c7 5b04          	addw	sp,#4
7445  13c9 ac0c150c      	jpf	L1523
7446  13cd               L3523:
7447                     ; 1867 	else if((mess[9]&0xf0)==0x00)
7449  13cd b6d0          	ld	a,_mess+9
7450  13cf a5f0          	bcp	a,#240
7451  13d1 2673          	jrne	L1033
7452                     ; 1869 		if((mess[9]&0x0f)==0x01)
7454  13d3 b6d0          	ld	a,_mess+9
7455  13d5 a40f          	and	a,#15
7456  13d7 a101          	cp	a,#1
7457  13d9 260d          	jrne	L3033
7458                     ; 1871 			ee_K[2][0]=adc_buff_[2];
7460  13db ce010b        	ldw	x,_adc_buff_+4
7461  13de 89            	pushw	x
7462  13df ae0022        	ldw	x,#_ee_K+8
7463  13e2 cd0000        	call	c_eewrw
7465  13e5 85            	popw	x
7467  13e6 204a          	jra	L5033
7468  13e8               L3033:
7469                     ; 1873 		else if((mess[9]&0x0f)==0x02)
7471  13e8 b6d0          	ld	a,_mess+9
7472  13ea a40f          	and	a,#15
7473  13ec a102          	cp	a,#2
7474  13ee 260b          	jrne	L7033
7475                     ; 1875 			ee_K[2][1]++;
7477  13f0 ce0024        	ldw	x,_ee_K+10
7478  13f3 1c0001        	addw	x,#1
7479  13f6 cf0024        	ldw	_ee_K+10,x
7481  13f9 2037          	jra	L5033
7482  13fb               L7033:
7483                     ; 1877 		else if((mess[9]&0x0f)==0x03)
7485  13fb b6d0          	ld	a,_mess+9
7486  13fd a40f          	and	a,#15
7487  13ff a103          	cp	a,#3
7488  1401 260b          	jrne	L3133
7489                     ; 1879 			ee_K[2][1]+=10;
7491  1403 ce0024        	ldw	x,_ee_K+10
7492  1406 1c000a        	addw	x,#10
7493  1409 cf0024        	ldw	_ee_K+10,x
7495  140c 2024          	jra	L5033
7496  140e               L3133:
7497                     ; 1881 		else if((mess[9]&0x0f)==0x04)
7499  140e b6d0          	ld	a,_mess+9
7500  1410 a40f          	and	a,#15
7501  1412 a104          	cp	a,#4
7502  1414 260b          	jrne	L7133
7503                     ; 1883 			ee_K[2][1]--;
7505  1416 ce0024        	ldw	x,_ee_K+10
7506  1419 1d0001        	subw	x,#1
7507  141c cf0024        	ldw	_ee_K+10,x
7509  141f 2011          	jra	L5033
7510  1421               L7133:
7511                     ; 1885 		else if((mess[9]&0x0f)==0x05)
7513  1421 b6d0          	ld	a,_mess+9
7514  1423 a40f          	and	a,#15
7515  1425 a105          	cp	a,#5
7516  1427 2609          	jrne	L5033
7517                     ; 1887 			ee_K[2][1]-=10;
7519  1429 ce0024        	ldw	x,_ee_K+10
7520  142c 1d000a        	subw	x,#10
7521  142f cf0024        	ldw	_ee_K+10,x
7522  1432               L5033:
7523                     ; 1892 		granee(&ee_K[2][1],10,30000);
7525  1432 ae7530        	ldw	x,#30000
7526  1435 89            	pushw	x
7527  1436 ae000a        	ldw	x,#10
7528  1439 89            	pushw	x
7529  143a ae0024        	ldw	x,#_ee_K+10
7530  143d cd00f6        	call	_granee
7532  1440 5b04          	addw	sp,#4
7534  1442 ac0c150c      	jpf	L1523
7535  1446               L1033:
7536                     ; 1896 	else if((mess[9]&0xf0)==0x30)
7538  1446 b6d0          	ld	a,_mess+9
7539  1448 a4f0          	and	a,#240
7540  144a a130          	cp	a,#48
7541  144c 265c          	jrne	L7233
7542                     ; 1898 		if((mess[9]&0x0f)==0x02)
7544  144e b6d0          	ld	a,_mess+9
7545  1450 a40f          	and	a,#15
7546  1452 a102          	cp	a,#2
7547  1454 260b          	jrne	L1333
7548                     ; 1900 			ee_K[3][1]++;
7550  1456 ce0028        	ldw	x,_ee_K+14
7551  1459 1c0001        	addw	x,#1
7552  145c cf0028        	ldw	_ee_K+14,x
7554  145f 2037          	jra	L3333
7555  1461               L1333:
7556                     ; 1902 		else if((mess[9]&0x0f)==0x03)
7558  1461 b6d0          	ld	a,_mess+9
7559  1463 a40f          	and	a,#15
7560  1465 a103          	cp	a,#3
7561  1467 260b          	jrne	L5333
7562                     ; 1904 			ee_K[3][1]+=10;
7564  1469 ce0028        	ldw	x,_ee_K+14
7565  146c 1c000a        	addw	x,#10
7566  146f cf0028        	ldw	_ee_K+14,x
7568  1472 2024          	jra	L3333
7569  1474               L5333:
7570                     ; 1906 		else if((mess[9]&0x0f)==0x04)
7572  1474 b6d0          	ld	a,_mess+9
7573  1476 a40f          	and	a,#15
7574  1478 a104          	cp	a,#4
7575  147a 260b          	jrne	L1433
7576                     ; 1908 			ee_K[3][1]--;
7578  147c ce0028        	ldw	x,_ee_K+14
7579  147f 1d0001        	subw	x,#1
7580  1482 cf0028        	ldw	_ee_K+14,x
7582  1485 2011          	jra	L3333
7583  1487               L1433:
7584                     ; 1910 		else if((mess[9]&0x0f)==0x05)
7586  1487 b6d0          	ld	a,_mess+9
7587  1489 a40f          	and	a,#15
7588  148b a105          	cp	a,#5
7589  148d 2609          	jrne	L3333
7590                     ; 1912 			ee_K[3][1]-=10;
7592  148f ce0028        	ldw	x,_ee_K+14
7593  1492 1d000a        	subw	x,#10
7594  1495 cf0028        	ldw	_ee_K+14,x
7595  1498               L3333:
7596                     ; 1914 		granee(&ee_K[3][1],300,517);									
7598  1498 ae0205        	ldw	x,#517
7599  149b 89            	pushw	x
7600  149c ae012c        	ldw	x,#300
7601  149f 89            	pushw	x
7602  14a0 ae0028        	ldw	x,#_ee_K+14
7603  14a3 cd00f6        	call	_granee
7605  14a6 5b04          	addw	sp,#4
7607  14a8 2062          	jra	L1523
7608  14aa               L7233:
7609                     ; 1917 	else if((mess[9]&0xf0)==0x50)
7611  14aa b6d0          	ld	a,_mess+9
7612  14ac a4f0          	and	a,#240
7613  14ae a150          	cp	a,#80
7614  14b0 265a          	jrne	L1523
7615                     ; 1919 		if((mess[9]&0x0f)==0x02)
7617  14b2 b6d0          	ld	a,_mess+9
7618  14b4 a40f          	and	a,#15
7619  14b6 a102          	cp	a,#2
7620  14b8 260b          	jrne	L3533
7621                     ; 1921 			ee_K[4][1]++;
7623  14ba ce002c        	ldw	x,_ee_K+18
7624  14bd 1c0001        	addw	x,#1
7625  14c0 cf002c        	ldw	_ee_K+18,x
7627  14c3 2037          	jra	L5533
7628  14c5               L3533:
7629                     ; 1923 		else if((mess[9]&0x0f)==0x03)
7631  14c5 b6d0          	ld	a,_mess+9
7632  14c7 a40f          	and	a,#15
7633  14c9 a103          	cp	a,#3
7634  14cb 260b          	jrne	L7533
7635                     ; 1925 			ee_K[4][1]+=10;
7637  14cd ce002c        	ldw	x,_ee_K+18
7638  14d0 1c000a        	addw	x,#10
7639  14d3 cf002c        	ldw	_ee_K+18,x
7641  14d6 2024          	jra	L5533
7642  14d8               L7533:
7643                     ; 1927 		else if((mess[9]&0x0f)==0x04)
7645  14d8 b6d0          	ld	a,_mess+9
7646  14da a40f          	and	a,#15
7647  14dc a104          	cp	a,#4
7648  14de 260b          	jrne	L3633
7649                     ; 1929 			ee_K[4][1]--;
7651  14e0 ce002c        	ldw	x,_ee_K+18
7652  14e3 1d0001        	subw	x,#1
7653  14e6 cf002c        	ldw	_ee_K+18,x
7655  14e9 2011          	jra	L5533
7656  14eb               L3633:
7657                     ; 1931 		else if((mess[9]&0x0f)==0x05)
7659  14eb b6d0          	ld	a,_mess+9
7660  14ed a40f          	and	a,#15
7661  14ef a105          	cp	a,#5
7662  14f1 2609          	jrne	L5533
7663                     ; 1933 			ee_K[4][1]-=10;
7665  14f3 ce002c        	ldw	x,_ee_K+18
7666  14f6 1d000a        	subw	x,#10
7667  14f9 cf002c        	ldw	_ee_K+18,x
7668  14fc               L5533:
7669                     ; 1935 		granee(&ee_K[4][1],10,30000);									
7671  14fc ae7530        	ldw	x,#30000
7672  14ff 89            	pushw	x
7673  1500 ae000a        	ldw	x,#10
7674  1503 89            	pushw	x
7675  1504 ae002c        	ldw	x,#_ee_K+18
7676  1507 cd00f6        	call	_granee
7678  150a 5b04          	addw	sp,#4
7679  150c               L1523:
7680                     ; 1938 	link_cnt=0;
7682  150c 5f            	clrw	x
7683  150d bf6b          	ldw	_link_cnt,x
7684                     ; 1939      link=ON;
7686  150f 3555006d      	mov	_link,#85
7687                     ; 1940      if(res_fl_)
7689  1513 725d000a      	tnz	_res_fl_
7690  1517 2603          	jrne	L202
7691  1519 cc1811        	jp	L3313
7692  151c               L202:
7693                     ; 1942       	res_fl_=0;
7695  151c 4f            	clr	a
7696  151d ae000a        	ldw	x,#_res_fl_
7697  1520 cd0000        	call	c_eewrc
7699  1523 ac111811      	jpf	L3313
7700  1527               L3223:
7701                     ; 1948 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7703  1527 b6cd          	ld	a,_mess+6
7704  1529 a1ff          	cp	a,#255
7705  152b 2703          	jreq	L402
7706  152d cc15bb        	jp	L5733
7707  1530               L402:
7709  1530 b6ce          	ld	a,_mess+7
7710  1532 a1ff          	cp	a,#255
7711  1534 2703          	jreq	L602
7712  1536 cc15bb        	jp	L5733
7713  1539               L602:
7715  1539 b6cf          	ld	a,_mess+8
7716  153b a162          	cp	a,#98
7717  153d 267c          	jrne	L5733
7718                     ; 1951 	tempSS=mess[9]+(mess[10]*256);
7720  153f b6d1          	ld	a,_mess+10
7721  1541 5f            	clrw	x
7722  1542 97            	ld	xl,a
7723  1543 4f            	clr	a
7724  1544 02            	rlwa	x,a
7725  1545 01            	rrwa	x,a
7726  1546 bbd0          	add	a,_mess+9
7727  1548 2401          	jrnc	L451
7728  154a 5c            	incw	x
7729  154b               L451:
7730  154b 02            	rlwa	x,a
7731  154c 1f03          	ldw	(OFST-4,sp),x
7732  154e 01            	rrwa	x,a
7733                     ; 1952 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7735  154f ce0014        	ldw	x,_ee_Umax
7736  1552 1303          	cpw	x,(OFST-4,sp)
7737  1554 270a          	jreq	L7733
7740  1556 1e03          	ldw	x,(OFST-4,sp)
7741  1558 89            	pushw	x
7742  1559 ae0014        	ldw	x,#_ee_Umax
7743  155c cd0000        	call	c_eewrw
7745  155f 85            	popw	x
7746  1560               L7733:
7747                     ; 1953 	tempSS=mess[11]+(mess[12]*256);
7749  1560 b6d3          	ld	a,_mess+12
7750  1562 5f            	clrw	x
7751  1563 97            	ld	xl,a
7752  1564 4f            	clr	a
7753  1565 02            	rlwa	x,a
7754  1566 01            	rrwa	x,a
7755  1567 bbd2          	add	a,_mess+11
7756  1569 2401          	jrnc	L651
7757  156b 5c            	incw	x
7758  156c               L651:
7759  156c 02            	rlwa	x,a
7760  156d 1f03          	ldw	(OFST-4,sp),x
7761  156f 01            	rrwa	x,a
7762                     ; 1954 	if(ee_dU!=tempSS) ee_dU=tempSS;
7764  1570 ce0012        	ldw	x,_ee_dU
7765  1573 1303          	cpw	x,(OFST-4,sp)
7766  1575 270a          	jreq	L1043
7769  1577 1e03          	ldw	x,(OFST-4,sp)
7770  1579 89            	pushw	x
7771  157a ae0012        	ldw	x,#_ee_dU
7772  157d cd0000        	call	c_eewrw
7774  1580 85            	popw	x
7775  1581               L1043:
7776                     ; 1955 	if((mess[13]&0x0f)==0x5)
7778  1581 b6d4          	ld	a,_mess+13
7779  1583 a40f          	and	a,#15
7780  1585 a105          	cp	a,#5
7781  1587 261a          	jrne	L3043
7782                     ; 1957 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7784  1589 ce0006        	ldw	x,_ee_AVT_MODE
7785  158c a30055        	cpw	x,#85
7786  158f 2603          	jrne	L012
7787  1591 cc1811        	jp	L3313
7788  1594               L012:
7791  1594 ae0055        	ldw	x,#85
7792  1597 89            	pushw	x
7793  1598 ae0006        	ldw	x,#_ee_AVT_MODE
7794  159b cd0000        	call	c_eewrw
7796  159e 85            	popw	x
7797  159f ac111811      	jpf	L3313
7798  15a3               L3043:
7799                     ; 1959 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7801  15a3 ce0006        	ldw	x,_ee_AVT_MODE
7802  15a6 a30055        	cpw	x,#85
7803  15a9 2703          	jreq	L212
7804  15ab cc1811        	jp	L3313
7805  15ae               L212:
7808  15ae 5f            	clrw	x
7809  15af 89            	pushw	x
7810  15b0 ae0006        	ldw	x,#_ee_AVT_MODE
7811  15b3 cd0000        	call	c_eewrw
7813  15b6 85            	popw	x
7814  15b7 ac111811      	jpf	L3313
7815  15bb               L5733:
7816                     ; 1962 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7818  15bb b6cd          	ld	a,_mess+6
7819  15bd a1ff          	cp	a,#255
7820  15bf 2703          	jreq	L412
7821  15c1 cc1677        	jp	L5143
7822  15c4               L412:
7824  15c4 b6ce          	ld	a,_mess+7
7825  15c6 a1ff          	cp	a,#255
7826  15c8 2703          	jreq	L612
7827  15ca cc1677        	jp	L5143
7828  15cd               L612:
7830  15cd b6cf          	ld	a,_mess+8
7831  15cf a126          	cp	a,#38
7832  15d1 2709          	jreq	L7143
7834  15d3 b6cf          	ld	a,_mess+8
7835  15d5 a129          	cp	a,#41
7836  15d7 2703          	jreq	L022
7837  15d9 cc1677        	jp	L5143
7838  15dc               L022:
7839  15dc               L7143:
7840                     ; 1965 	tempSS=mess[9]+(mess[10]*256);
7842  15dc b6d1          	ld	a,_mess+10
7843  15de 5f            	clrw	x
7844  15df 97            	ld	xl,a
7845  15e0 4f            	clr	a
7846  15e1 02            	rlwa	x,a
7847  15e2 01            	rrwa	x,a
7848  15e3 bbd0          	add	a,_mess+9
7849  15e5 2401          	jrnc	L061
7850  15e7 5c            	incw	x
7851  15e8               L061:
7852  15e8 02            	rlwa	x,a
7853  15e9 1f03          	ldw	(OFST-4,sp),x
7854  15eb 01            	rrwa	x,a
7855                     ; 1967 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7857  15ec ce000c        	ldw	x,_ee_UAVT
7858  15ef 1303          	cpw	x,(OFST-4,sp)
7859  15f1 270a          	jreq	L1243
7862  15f3 1e03          	ldw	x,(OFST-4,sp)
7863  15f5 89            	pushw	x
7864  15f6 ae000c        	ldw	x,#_ee_UAVT
7865  15f9 cd0000        	call	c_eewrw
7867  15fc 85            	popw	x
7868  15fd               L1243:
7869                     ; 1968 	tempSS=(signed short)mess[11];
7871  15fd b6d2          	ld	a,_mess+11
7872  15ff 5f            	clrw	x
7873  1600 97            	ld	xl,a
7874  1601 1f03          	ldw	(OFST-4,sp),x
7875                     ; 1969 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7877  1603 ce0010        	ldw	x,_ee_tmax
7878  1606 1303          	cpw	x,(OFST-4,sp)
7879  1608 270a          	jreq	L3243
7882  160a 1e03          	ldw	x,(OFST-4,sp)
7883  160c 89            	pushw	x
7884  160d ae0010        	ldw	x,#_ee_tmax
7885  1610 cd0000        	call	c_eewrw
7887  1613 85            	popw	x
7888  1614               L3243:
7889                     ; 1970 	tempSS=(signed short)mess[12];
7891  1614 b6d3          	ld	a,_mess+12
7892  1616 5f            	clrw	x
7893  1617 97            	ld	xl,a
7894  1618 1f03          	ldw	(OFST-4,sp),x
7895                     ; 1971 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7897  161a ce000e        	ldw	x,_ee_tsign
7898  161d 1303          	cpw	x,(OFST-4,sp)
7899  161f 270a          	jreq	L5243
7902  1621 1e03          	ldw	x,(OFST-4,sp)
7903  1623 89            	pushw	x
7904  1624 ae000e        	ldw	x,#_ee_tsign
7905  1627 cd0000        	call	c_eewrw
7907  162a 85            	popw	x
7908  162b               L5243:
7909                     ; 1974 	if(mess[8]==MEM_KF1)
7911  162b b6cf          	ld	a,_mess+8
7912  162d a126          	cp	a,#38
7913  162f 260e          	jrne	L7243
7914                     ; 1976 		if(ee_DEVICE!=0)ee_DEVICE=0;
7916  1631 ce0004        	ldw	x,_ee_DEVICE
7917  1634 2709          	jreq	L7243
7920  1636 5f            	clrw	x
7921  1637 89            	pushw	x
7922  1638 ae0004        	ldw	x,#_ee_DEVICE
7923  163b cd0000        	call	c_eewrw
7925  163e 85            	popw	x
7926  163f               L7243:
7927                     ; 1979 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7929  163f b6cf          	ld	a,_mess+8
7930  1641 a129          	cp	a,#41
7931  1643 2703          	jreq	L222
7932  1645 cc1811        	jp	L3313
7933  1648               L222:
7934                     ; 1981 		if(ee_DEVICE!=1)ee_DEVICE=1;
7936  1648 ce0004        	ldw	x,_ee_DEVICE
7937  164b a30001        	cpw	x,#1
7938  164e 270b          	jreq	L5343
7941  1650 ae0001        	ldw	x,#1
7942  1653 89            	pushw	x
7943  1654 ae0004        	ldw	x,#_ee_DEVICE
7944  1657 cd0000        	call	c_eewrw
7946  165a 85            	popw	x
7947  165b               L5343:
7948                     ; 1982 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7950  165b b6d4          	ld	a,_mess+13
7951  165d 5f            	clrw	x
7952  165e 97            	ld	xl,a
7953  165f c30002        	cpw	x,_ee_IMAXVENT
7954  1662 2603          	jrne	L422
7955  1664 cc1811        	jp	L3313
7956  1667               L422:
7959  1667 b6d4          	ld	a,_mess+13
7960  1669 5f            	clrw	x
7961  166a 97            	ld	xl,a
7962  166b 89            	pushw	x
7963  166c ae0002        	ldw	x,#_ee_IMAXVENT
7964  166f cd0000        	call	c_eewrw
7966  1672 85            	popw	x
7967  1673 ac111811      	jpf	L3313
7968  1677               L5143:
7969                     ; 1987 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7971  1677 b6cd          	ld	a,_mess+6
7972  1679 c100ff        	cp	a,_adress
7973  167c 262d          	jrne	L3443
7975  167e b6ce          	ld	a,_mess+7
7976  1680 c100ff        	cp	a,_adress
7977  1683 2626          	jrne	L3443
7979  1685 b6cf          	ld	a,_mess+8
7980  1687 a116          	cp	a,#22
7981  1689 2620          	jrne	L3443
7983  168b b6d0          	ld	a,_mess+9
7984  168d a163          	cp	a,#99
7985  168f 261a          	jrne	L3443
7986                     ; 1989 	flags&=0b11100001;
7988  1691 b605          	ld	a,_flags
7989  1693 a4e1          	and	a,#225
7990  1695 b705          	ld	_flags,a
7991                     ; 1990 	tsign_cnt=0;
7993  1697 5f            	clrw	x
7994  1698 bf59          	ldw	_tsign_cnt,x
7995                     ; 1991 	tmax_cnt=0;
7997  169a 5f            	clrw	x
7998  169b bf57          	ldw	_tmax_cnt,x
7999                     ; 1992 	umax_cnt=0;
8001  169d 5f            	clrw	x
8002  169e bf70          	ldw	_umax_cnt,x
8003                     ; 1993 	umin_cnt=0;
8005  16a0 5f            	clrw	x
8006  16a1 bf6e          	ldw	_umin_cnt,x
8007                     ; 1994 	led_drv_cnt=30;
8009  16a3 351e0016      	mov	_led_drv_cnt,#30
8011  16a7 ac111811      	jpf	L3313
8012  16ab               L3443:
8013                     ; 1997 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8015  16ab b6cd          	ld	a,_mess+6
8016  16ad c100ff        	cp	a,_adress
8017  16b0 2620          	jrne	L7443
8019  16b2 b6ce          	ld	a,_mess+7
8020  16b4 c100ff        	cp	a,_adress
8021  16b7 2619          	jrne	L7443
8023  16b9 b6cf          	ld	a,_mess+8
8024  16bb a116          	cp	a,#22
8025  16bd 2613          	jrne	L7443
8027  16bf b6d0          	ld	a,_mess+9
8028  16c1 a164          	cp	a,#100
8029  16c3 260d          	jrne	L7443
8030                     ; 1999 	vent_resurs=0;
8032  16c5 5f            	clrw	x
8033  16c6 89            	pushw	x
8034  16c7 ae0000        	ldw	x,#_vent_resurs
8035  16ca cd0000        	call	c_eewrw
8037  16cd 85            	popw	x
8039  16ce ac111811      	jpf	L3313
8040  16d2               L7443:
8041                     ; 2003 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8043  16d2 b6cd          	ld	a,_mess+6
8044  16d4 a1ff          	cp	a,#255
8045  16d6 265f          	jrne	L3543
8047  16d8 b6ce          	ld	a,_mess+7
8048  16da a1ff          	cp	a,#255
8049  16dc 2659          	jrne	L3543
8051  16de b6cf          	ld	a,_mess+8
8052  16e0 a116          	cp	a,#22
8053  16e2 2653          	jrne	L3543
8055  16e4 b6d0          	ld	a,_mess+9
8056  16e6 a116          	cp	a,#22
8057  16e8 264d          	jrne	L3543
8058                     ; 2005 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8060  16ea b6d1          	ld	a,_mess+10
8061  16ec a155          	cp	a,#85
8062  16ee 260f          	jrne	L5543
8064  16f0 b6d2          	ld	a,_mess+11
8065  16f2 a155          	cp	a,#85
8066  16f4 2609          	jrne	L5543
8069  16f6 be68          	ldw	x,__x_
8070  16f8 1c0001        	addw	x,#1
8071  16fb bf68          	ldw	__x_,x
8073  16fd 2024          	jra	L7543
8074  16ff               L5543:
8075                     ; 2006 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8077  16ff b6d1          	ld	a,_mess+10
8078  1701 a166          	cp	a,#102
8079  1703 260f          	jrne	L1643
8081  1705 b6d2          	ld	a,_mess+11
8082  1707 a166          	cp	a,#102
8083  1709 2609          	jrne	L1643
8086  170b be68          	ldw	x,__x_
8087  170d 1d0001        	subw	x,#1
8088  1710 bf68          	ldw	__x_,x
8090  1712 200f          	jra	L7543
8091  1714               L1643:
8092                     ; 2007 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8094  1714 b6d1          	ld	a,_mess+10
8095  1716 a177          	cp	a,#119
8096  1718 2609          	jrne	L7543
8098  171a b6d2          	ld	a,_mess+11
8099  171c a177          	cp	a,#119
8100  171e 2603          	jrne	L7543
8103  1720 5f            	clrw	x
8104  1721 bf68          	ldw	__x_,x
8105  1723               L7543:
8106                     ; 2008      gran(&_x_,-XMAX,XMAX);
8108  1723 ae0019        	ldw	x,#25
8109  1726 89            	pushw	x
8110  1727 aeffe7        	ldw	x,#65511
8111  172a 89            	pushw	x
8112  172b ae0068        	ldw	x,#__x_
8113  172e cd00d5        	call	_gran
8115  1731 5b04          	addw	sp,#4
8117  1733 ac111811      	jpf	L3313
8118  1737               L3543:
8119                     ; 2010 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8121  1737 b6cd          	ld	a,_mess+6
8122  1739 c100ff        	cp	a,_adress
8123  173c 2635          	jrne	L1743
8125  173e b6ce          	ld	a,_mess+7
8126  1740 c100ff        	cp	a,_adress
8127  1743 262e          	jrne	L1743
8129  1745 b6cf          	ld	a,_mess+8
8130  1747 a116          	cp	a,#22
8131  1749 2628          	jrne	L1743
8133  174b b6d0          	ld	a,_mess+9
8134  174d b1d1          	cp	a,_mess+10
8135  174f 2622          	jrne	L1743
8137  1751 b6d0          	ld	a,_mess+9
8138  1753 a1ee          	cp	a,#238
8139  1755 261c          	jrne	L1743
8140                     ; 2012 	rotor_int++;
8142  1757 be17          	ldw	x,_rotor_int
8143  1759 1c0001        	addw	x,#1
8144  175c bf17          	ldw	_rotor_int,x
8145                     ; 2013      tempI=pwm_u;
8147                     ; 2015 	UU_AVT=Un;
8149  175e ce0016        	ldw	x,_Un
8150  1761 89            	pushw	x
8151  1762 ae0008        	ldw	x,#_UU_AVT
8152  1765 cd0000        	call	c_eewrw
8154  1768 85            	popw	x
8155                     ; 2016 	delay_ms(100);
8157  1769 ae0064        	ldw	x,#100
8158  176c cd0121        	call	_delay_ms
8161  176f ac111811      	jpf	L3313
8162  1773               L1743:
8163                     ; 2022 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8165  1773 b6ce          	ld	a,_mess+7
8166  1775 a1da          	cp	a,#218
8167  1777 2653          	jrne	L5743
8169  1779 b6cd          	ld	a,_mess+6
8170  177b c100ff        	cp	a,_adress
8171  177e 274c          	jreq	L5743
8173  1780 b6cd          	ld	a,_mess+6
8174  1782 a106          	cp	a,#6
8175  1784 2446          	jruge	L5743
8176                     ; 2024 	i_main_bps_cnt[mess[6]]=0;
8178  1786 b6cd          	ld	a,_mess+6
8179  1788 5f            	clrw	x
8180  1789 97            	ld	xl,a
8181  178a 6f13          	clr	(_i_main_bps_cnt,x)
8182                     ; 2025 	i_main_flag[mess[6]]=1;
8184  178c b6cd          	ld	a,_mess+6
8185  178e 5f            	clrw	x
8186  178f 97            	ld	xl,a
8187  1790 a601          	ld	a,#1
8188  1792 e71e          	ld	(_i_main_flag,x),a
8189                     ; 2026 	if(bMAIN)
8191                     	btst	_bMAIN
8192  1799 2476          	jruge	L3313
8193                     ; 2028 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8195  179b b6d0          	ld	a,_mess+9
8196  179d 5f            	clrw	x
8197  179e 97            	ld	xl,a
8198  179f 4f            	clr	a
8199  17a0 02            	rlwa	x,a
8200  17a1 1f01          	ldw	(OFST-6,sp),x
8201  17a3 b6cf          	ld	a,_mess+8
8202  17a5 5f            	clrw	x
8203  17a6 97            	ld	xl,a
8204  17a7 72fb01        	addw	x,(OFST-6,sp)
8205  17aa b6cd          	ld	a,_mess+6
8206  17ac 905f          	clrw	y
8207  17ae 9097          	ld	yl,a
8208  17b0 9058          	sllw	y
8209  17b2 90ef24        	ldw	(_i_main,y),x
8210                     ; 2029 		i_main[adress]=I;
8212  17b5 c600ff        	ld	a,_adress
8213  17b8 5f            	clrw	x
8214  17b9 97            	ld	xl,a
8215  17ba 58            	sllw	x
8216  17bb 90ce0018      	ldw	y,_I
8217  17bf ef24          	ldw	(_i_main,x),y
8218                     ; 2030      	i_main_flag[adress]=1;
8220  17c1 c600ff        	ld	a,_adress
8221  17c4 5f            	clrw	x
8222  17c5 97            	ld	xl,a
8223  17c6 a601          	ld	a,#1
8224  17c8 e71e          	ld	(_i_main_flag,x),a
8225  17ca 2045          	jra	L3313
8226  17cc               L5743:
8227                     ; 2034 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8229  17cc b6ce          	ld	a,_mess+7
8230  17ce a1db          	cp	a,#219
8231  17d0 263f          	jrne	L3313
8233  17d2 b6cd          	ld	a,_mess+6
8234  17d4 c100ff        	cp	a,_adress
8235  17d7 2738          	jreq	L3313
8237  17d9 b6cd          	ld	a,_mess+6
8238  17db a106          	cp	a,#6
8239  17dd 2432          	jruge	L3313
8240                     ; 2036 	i_main_bps_cnt[mess[6]]=0;
8242  17df b6cd          	ld	a,_mess+6
8243  17e1 5f            	clrw	x
8244  17e2 97            	ld	xl,a
8245  17e3 6f13          	clr	(_i_main_bps_cnt,x)
8246                     ; 2037 	i_main_flag[mess[6]]=1;		
8248  17e5 b6cd          	ld	a,_mess+6
8249  17e7 5f            	clrw	x
8250  17e8 97            	ld	xl,a
8251  17e9 a601          	ld	a,#1
8252  17eb e71e          	ld	(_i_main_flag,x),a
8253                     ; 2038 	if(bMAIN)
8255                     	btst	_bMAIN
8256  17f2 241d          	jruge	L3313
8257                     ; 2040 		if(mess[9]==0)i_main_flag[i]=1;
8259  17f4 3dd0          	tnz	_mess+9
8260  17f6 260a          	jrne	L7053
8263  17f8 7b07          	ld	a,(OFST+0,sp)
8264  17fa 5f            	clrw	x
8265  17fb 97            	ld	xl,a
8266  17fc a601          	ld	a,#1
8267  17fe e71e          	ld	(_i_main_flag,x),a
8269  1800 2006          	jra	L1153
8270  1802               L7053:
8271                     ; 2041 		else i_main_flag[i]=0;
8273  1802 7b07          	ld	a,(OFST+0,sp)
8274  1804 5f            	clrw	x
8275  1805 97            	ld	xl,a
8276  1806 6f1e          	clr	(_i_main_flag,x)
8277  1808               L1153:
8278                     ; 2042 		i_main_flag[adress]=1;
8280  1808 c600ff        	ld	a,_adress
8281  180b 5f            	clrw	x
8282  180c 97            	ld	xl,a
8283  180d a601          	ld	a,#1
8284  180f e71e          	ld	(_i_main_flag,x),a
8285  1811               L3313:
8286                     ; 2048 can_in_an_end:
8286                     ; 2049 bCAN_RX=0;
8288  1811 3f04          	clr	_bCAN_RX
8289                     ; 2050 }   
8292  1813 5b07          	addw	sp,#7
8293  1815 81            	ret
8316                     ; 2053 void t4_init(void){
8317                     	switch	.text
8318  1816               _t4_init:
8322                     ; 2054 	TIM4->PSCR = 6;
8324  1816 35065345      	mov	21317,#6
8325                     ; 2055 	TIM4->ARR= 61;
8327  181a 353d5346      	mov	21318,#61
8328                     ; 2056 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8330  181e 72105341      	bset	21313,#0
8331                     ; 2058 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8333  1822 35855340      	mov	21312,#133
8334                     ; 2060 }
8337  1826 81            	ret
8360                     ; 2063 void t1_init(void)
8360                     ; 2064 {
8361                     	switch	.text
8362  1827               _t1_init:
8366                     ; 2065 TIM1->ARRH= 0x07;
8368  1827 35075262      	mov	21090,#7
8369                     ; 2066 TIM1->ARRL= 0xff;
8371  182b 35ff5263      	mov	21091,#255
8372                     ; 2067 TIM1->CCR1H= 0x00;	
8374  182f 725f5265      	clr	21093
8375                     ; 2068 TIM1->CCR1L= 0xff;
8377  1833 35ff5266      	mov	21094,#255
8378                     ; 2069 TIM1->CCR2H= 0x00;	
8380  1837 725f5267      	clr	21095
8381                     ; 2070 TIM1->CCR2L= 0x00;
8383  183b 725f5268      	clr	21096
8384                     ; 2071 TIM1->CCR3H= 0x00;	
8386  183f 725f5269      	clr	21097
8387                     ; 2072 TIM1->CCR3L= 0x64;
8389  1843 3564526a      	mov	21098,#100
8390                     ; 2074 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8392  1847 35685258      	mov	21080,#104
8393                     ; 2075 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8395  184b 35685259      	mov	21081,#104
8396                     ; 2076 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8398  184f 3568525a      	mov	21082,#104
8399                     ; 2077 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8401  1853 3511525c      	mov	21084,#17
8402                     ; 2078 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8404  1857 3501525d      	mov	21085,#1
8405                     ; 2079 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8407  185b 35815250      	mov	21072,#129
8408                     ; 2080 TIM1->BKR|= TIM1_BKR_AOE;
8410  185f 721c526d      	bset	21101,#6
8411                     ; 2081 }
8414  1863 81            	ret
8439                     ; 2085 void adc2_init(void)
8439                     ; 2086 {
8440                     	switch	.text
8441  1864               _adc2_init:
8445                     ; 2087 adc_plazma[0]++;
8447  1864 beb9          	ldw	x,_adc_plazma
8448  1866 1c0001        	addw	x,#1
8449  1869 bfb9          	ldw	_adc_plazma,x
8450                     ; 2111 GPIOB->DDR&=~(1<<4);
8452  186b 72195007      	bres	20487,#4
8453                     ; 2112 GPIOB->CR1&=~(1<<4);
8455  186f 72195008      	bres	20488,#4
8456                     ; 2113 GPIOB->CR2&=~(1<<4);
8458  1873 72195009      	bres	20489,#4
8459                     ; 2115 GPIOB->DDR&=~(1<<5);
8461  1877 721b5007      	bres	20487,#5
8462                     ; 2116 GPIOB->CR1&=~(1<<5);
8464  187b 721b5008      	bres	20488,#5
8465                     ; 2117 GPIOB->CR2&=~(1<<5);
8467  187f 721b5009      	bres	20489,#5
8468                     ; 2119 GPIOB->DDR&=~(1<<6);
8470  1883 721d5007      	bres	20487,#6
8471                     ; 2120 GPIOB->CR1&=~(1<<6);
8473  1887 721d5008      	bres	20488,#6
8474                     ; 2121 GPIOB->CR2&=~(1<<6);
8476  188b 721d5009      	bres	20489,#6
8477                     ; 2123 GPIOB->DDR&=~(1<<7);
8479  188f 721f5007      	bres	20487,#7
8480                     ; 2124 GPIOB->CR1&=~(1<<7);
8482  1893 721f5008      	bres	20488,#7
8483                     ; 2125 GPIOB->CR2&=~(1<<7);
8485  1897 721f5009      	bres	20489,#7
8486                     ; 2127 GPIOB->DDR&=~(1<<2);
8488  189b 72155007      	bres	20487,#2
8489                     ; 2128 GPIOB->CR1&=~(1<<2);
8491  189f 72155008      	bres	20488,#2
8492                     ; 2129 GPIOB->CR2&=~(1<<2);
8494  18a3 72155009      	bres	20489,#2
8495                     ; 2138 ADC2->TDRL=0xff;
8497  18a7 35ff5407      	mov	21511,#255
8498                     ; 2140 ADC2->CR2=0x08;
8500  18ab 35085402      	mov	21506,#8
8501                     ; 2141 ADC2->CR1=0x60;
8503  18af 35605401      	mov	21505,#96
8504                     ; 2144 	if(adc_ch==5)ADC2->CSR=0x22;
8506  18b3 b6c6          	ld	a,_adc_ch
8507  18b5 a105          	cp	a,#5
8508  18b7 2606          	jrne	L3453
8511  18b9 35225400      	mov	21504,#34
8513  18bd 2007          	jra	L5453
8514  18bf               L3453:
8515                     ; 2145 	else ADC2->CSR=0x20+adc_ch+3;
8517  18bf b6c6          	ld	a,_adc_ch
8518  18c1 ab23          	add	a,#35
8519  18c3 c75400        	ld	21504,a
8520  18c6               L5453:
8521                     ; 2147 	ADC2->CR1|=1;
8523  18c6 72105401      	bset	21505,#0
8524                     ; 2148 	ADC2->CR1|=1;
8526  18ca 72105401      	bset	21505,#0
8527                     ; 2151 adc_plazma[1]=adc_ch;
8529  18ce b6c6          	ld	a,_adc_ch
8530  18d0 5f            	clrw	x
8531  18d1 97            	ld	xl,a
8532  18d2 bfbb          	ldw	_adc_plazma+2,x
8533                     ; 2152 }
8536  18d4 81            	ret
8572                     ; 2160 @far @interrupt void TIM4_UPD_Interrupt (void) 
8572                     ; 2161 {
8574                     	switch	.text
8575  18d5               f_TIM4_UPD_Interrupt:
8579                     ; 2162 TIM4->SR1&=~TIM4_SR1_UIF;
8581  18d5 72115342      	bres	21314,#0
8582                     ; 2164 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8584  18d9 3c12          	inc	_pwm_vent_cnt
8585  18db b612          	ld	a,_pwm_vent_cnt
8586  18dd a10a          	cp	a,#10
8587  18df 2502          	jrult	L7553
8590  18e1 3f12          	clr	_pwm_vent_cnt
8591  18e3               L7553:
8592                     ; 2165 GPIOB->ODR|=(1<<3);
8594  18e3 72165005      	bset	20485,#3
8595                     ; 2166 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8597  18e7 b612          	ld	a,_pwm_vent_cnt
8598  18e9 a105          	cp	a,#5
8599  18eb 2504          	jrult	L1653
8602  18ed 72175005      	bres	20485,#3
8603  18f1               L1653:
8604                     ; 2170 if(++t0_cnt00>=10)
8606  18f1 9c            	rvf
8607  18f2 ce0000        	ldw	x,_t0_cnt00
8608  18f5 1c0001        	addw	x,#1
8609  18f8 cf0000        	ldw	_t0_cnt00,x
8610  18fb a3000a        	cpw	x,#10
8611  18fe 2f08          	jrslt	L3653
8612                     ; 2172 	t0_cnt00=0;
8614  1900 5f            	clrw	x
8615  1901 cf0000        	ldw	_t0_cnt00,x
8616                     ; 2173 	b1000Hz=1;
8618  1904 72100004      	bset	_b1000Hz
8619  1908               L3653:
8620                     ; 2176 if(++t0_cnt0>=100)
8622  1908 9c            	rvf
8623  1909 ce0002        	ldw	x,_t0_cnt0
8624  190c 1c0001        	addw	x,#1
8625  190f cf0002        	ldw	_t0_cnt0,x
8626  1912 a30064        	cpw	x,#100
8627  1915 2f54          	jrslt	L5653
8628                     ; 2178 	t0_cnt0=0;
8630  1917 5f            	clrw	x
8631  1918 cf0002        	ldw	_t0_cnt0,x
8632                     ; 2179 	b100Hz=1;
8634  191b 72100009      	bset	_b100Hz
8635                     ; 2181 	if(++t0_cnt1>=10)
8637  191f 725c0004      	inc	_t0_cnt1
8638  1923 c60004        	ld	a,_t0_cnt1
8639  1926 a10a          	cp	a,#10
8640  1928 2508          	jrult	L7653
8641                     ; 2183 		t0_cnt1=0;
8643  192a 725f0004      	clr	_t0_cnt1
8644                     ; 2184 		b10Hz=1;
8646  192e 72100008      	bset	_b10Hz
8647  1932               L7653:
8648                     ; 2187 	if(++t0_cnt2>=20)
8650  1932 725c0005      	inc	_t0_cnt2
8651  1936 c60005        	ld	a,_t0_cnt2
8652  1939 a114          	cp	a,#20
8653  193b 2508          	jrult	L1753
8654                     ; 2189 		t0_cnt2=0;
8656  193d 725f0005      	clr	_t0_cnt2
8657                     ; 2190 		b5Hz=1;
8659  1941 72100007      	bset	_b5Hz
8660  1945               L1753:
8661                     ; 2194 	if(++t0_cnt4>=50)
8663  1945 725c0007      	inc	_t0_cnt4
8664  1949 c60007        	ld	a,_t0_cnt4
8665  194c a132          	cp	a,#50
8666  194e 2508          	jrult	L3753
8667                     ; 2196 		t0_cnt4=0;
8669  1950 725f0007      	clr	_t0_cnt4
8670                     ; 2197 		b2Hz=1;
8672  1954 72100006      	bset	_b2Hz
8673  1958               L3753:
8674                     ; 2200 	if(++t0_cnt3>=100)
8676  1958 725c0006      	inc	_t0_cnt3
8677  195c c60006        	ld	a,_t0_cnt3
8678  195f a164          	cp	a,#100
8679  1961 2508          	jrult	L5653
8680                     ; 2202 		t0_cnt3=0;
8682  1963 725f0006      	clr	_t0_cnt3
8683                     ; 2203 		b1Hz=1;
8685  1967 72100005      	bset	_b1Hz
8686  196b               L5653:
8687                     ; 2209 }
8690  196b 80            	iret
8715                     ; 2212 @far @interrupt void CAN_RX_Interrupt (void) 
8715                     ; 2213 {
8716                     	switch	.text
8717  196c               f_CAN_RX_Interrupt:
8721                     ; 2215 CAN->PSR= 7;									// page 7 - read messsage
8723  196c 35075427      	mov	21543,#7
8724                     ; 2217 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8726  1970 ae000e        	ldw	x,#14
8727  1973               L042:
8728  1973 d65427        	ld	a,(21543,x)
8729  1976 e7c6          	ld	(_mess-1,x),a
8730  1978 5a            	decw	x
8731  1979 26f8          	jrne	L042
8732                     ; 2228 bCAN_RX=1;
8734  197b 35010004      	mov	_bCAN_RX,#1
8735                     ; 2229 CAN->RFR|=(1<<5);
8737  197f 721a5424      	bset	21540,#5
8738                     ; 2231 }
8741  1983 80            	iret
8764                     ; 2234 @far @interrupt void CAN_TX_Interrupt (void) 
8764                     ; 2235 {
8765                     	switch	.text
8766  1984               f_CAN_TX_Interrupt:
8770                     ; 2236 if((CAN->TSR)&(1<<0))
8772  1984 c65422        	ld	a,21538
8773  1987 a501          	bcp	a,#1
8774  1989 2708          	jreq	L7163
8775                     ; 2238 	bTX_FREE=1;	
8777  198b 35010003      	mov	_bTX_FREE,#1
8778                     ; 2240 	CAN->TSR|=(1<<0);
8780  198f 72105422      	bset	21538,#0
8781  1993               L7163:
8782                     ; 2242 }
8785  1993 80            	iret
8865                     ; 2245 @far @interrupt void ADC2_EOC_Interrupt (void) {
8866                     	switch	.text
8867  1994               f_ADC2_EOC_Interrupt:
8869       0000000d      OFST:	set	13
8870  1994 be00          	ldw	x,c_x
8871  1996 89            	pushw	x
8872  1997 be00          	ldw	x,c_y
8873  1999 89            	pushw	x
8874  199a be02          	ldw	x,c_lreg+2
8875  199c 89            	pushw	x
8876  199d be00          	ldw	x,c_lreg
8877  199f 89            	pushw	x
8878  19a0 520d          	subw	sp,#13
8881                     ; 2250 adc_plazma[2]++;
8883  19a2 bebd          	ldw	x,_adc_plazma+4
8884  19a4 1c0001        	addw	x,#1
8885  19a7 bfbd          	ldw	_adc_plazma+4,x
8886                     ; 2257 ADC2->CSR&=~(1<<7);
8888  19a9 721f5400      	bres	21504,#7
8889                     ; 2259 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8891  19ad c65405        	ld	a,21509
8892  19b0 b703          	ld	c_lreg+3,a
8893  19b2 3f02          	clr	c_lreg+2
8894  19b4 3f01          	clr	c_lreg+1
8895  19b6 3f00          	clr	c_lreg
8896  19b8 96            	ldw	x,sp
8897  19b9 1c0001        	addw	x,#OFST-12
8898  19bc cd0000        	call	c_rtol
8900  19bf c65404        	ld	a,21508
8901  19c2 5f            	clrw	x
8902  19c3 97            	ld	xl,a
8903  19c4 90ae0100      	ldw	y,#256
8904  19c8 cd0000        	call	c_umul
8906  19cb 96            	ldw	x,sp
8907  19cc 1c0001        	addw	x,#OFST-12
8908  19cf cd0000        	call	c_ladd
8910  19d2 96            	ldw	x,sp
8911  19d3 1c000a        	addw	x,#OFST-3
8912  19d6 cd0000        	call	c_rtol
8914                     ; 2264 if(adr_drv_stat==1)
8916  19d9 b602          	ld	a,_adr_drv_stat
8917  19db a101          	cp	a,#1
8918  19dd 260b          	jrne	L7563
8919                     ; 2266 	adr_drv_stat=2;
8921  19df 35020002      	mov	_adr_drv_stat,#2
8922                     ; 2267 	adc_buff_[0]=temp_adc;
8924  19e3 1e0c          	ldw	x,(OFST-1,sp)
8925  19e5 cf0107        	ldw	_adc_buff_,x
8927  19e8 2020          	jra	L1663
8928  19ea               L7563:
8929                     ; 2270 else if(adr_drv_stat==3)
8931  19ea b602          	ld	a,_adr_drv_stat
8932  19ec a103          	cp	a,#3
8933  19ee 260b          	jrne	L3663
8934                     ; 2272 	adr_drv_stat=4;
8936  19f0 35040002      	mov	_adr_drv_stat,#4
8937                     ; 2273 	adc_buff_[1]=temp_adc;
8939  19f4 1e0c          	ldw	x,(OFST-1,sp)
8940  19f6 cf0109        	ldw	_adc_buff_+2,x
8942  19f9 200f          	jra	L1663
8943  19fb               L3663:
8944                     ; 2276 else if(adr_drv_stat==5)
8946  19fb b602          	ld	a,_adr_drv_stat
8947  19fd a105          	cp	a,#5
8948  19ff 2609          	jrne	L1663
8949                     ; 2278 	adr_drv_stat=6;
8951  1a01 35060002      	mov	_adr_drv_stat,#6
8952                     ; 2279 	adc_buff_[9]=temp_adc;
8954  1a05 1e0c          	ldw	x,(OFST-1,sp)
8955  1a07 cf0119        	ldw	_adc_buff_+18,x
8956  1a0a               L1663:
8957                     ; 2282 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8959  1a0a b6b7          	ld	a,_adc_cnt_cnt
8960  1a0c 5f            	clrw	x
8961  1a0d 97            	ld	xl,a
8962  1a0e 58            	sllw	x
8963  1a0f 1f03          	ldw	(OFST-10,sp),x
8964  1a11 b6c6          	ld	a,_adc_ch
8965  1a13 97            	ld	xl,a
8966  1a14 a610          	ld	a,#16
8967  1a16 42            	mul	x,a
8968  1a17 72fb03        	addw	x,(OFST-10,sp)
8969  1a1a 160c          	ldw	y,(OFST-1,sp)
8970  1a1c df005e        	ldw	(_adc_buff_buff,x),y
8971                     ; 2284 adc_ch++;
8973  1a1f 3cc6          	inc	_adc_ch
8974                     ; 2285 if(adc_ch>=6)
8976  1a21 b6c6          	ld	a,_adc_ch
8977  1a23 a106          	cp	a,#6
8978  1a25 2516          	jrult	L1763
8979                     ; 2287 	adc_ch=0;
8981  1a27 3fc6          	clr	_adc_ch
8982                     ; 2288 	adc_cnt_cnt++;
8984  1a29 3cb7          	inc	_adc_cnt_cnt
8985                     ; 2289 	if(adc_cnt_cnt>=8)
8987  1a2b b6b7          	ld	a,_adc_cnt_cnt
8988  1a2d a108          	cp	a,#8
8989  1a2f 250c          	jrult	L1763
8990                     ; 2291 		adc_cnt_cnt=0;
8992  1a31 3fb7          	clr	_adc_cnt_cnt
8993                     ; 2292 		adc_cnt++;
8995  1a33 3cc5          	inc	_adc_cnt
8996                     ; 2293 		if(adc_cnt>=16)
8998  1a35 b6c5          	ld	a,_adc_cnt
8999  1a37 a110          	cp	a,#16
9000  1a39 2502          	jrult	L1763
9001                     ; 2295 			adc_cnt=0;
9003  1a3b 3fc5          	clr	_adc_cnt
9004  1a3d               L1763:
9005                     ; 2299 if(adc_cnt_cnt==0)
9007  1a3d 3db7          	tnz	_adc_cnt_cnt
9008  1a3f 2660          	jrne	L7763
9009                     ; 2303 	tempSS=0;
9011  1a41 ae0000        	ldw	x,#0
9012  1a44 1f07          	ldw	(OFST-6,sp),x
9013  1a46 ae0000        	ldw	x,#0
9014  1a49 1f05          	ldw	(OFST-8,sp),x
9015                     ; 2304 	for(i=0;i<8;i++)
9017  1a4b 0f09          	clr	(OFST-4,sp)
9018  1a4d               L1073:
9019                     ; 2306 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9021  1a4d 7b09          	ld	a,(OFST-4,sp)
9022  1a4f 5f            	clrw	x
9023  1a50 97            	ld	xl,a
9024  1a51 58            	sllw	x
9025  1a52 1f03          	ldw	(OFST-10,sp),x
9026  1a54 b6c6          	ld	a,_adc_ch
9027  1a56 97            	ld	xl,a
9028  1a57 a610          	ld	a,#16
9029  1a59 42            	mul	x,a
9030  1a5a 72fb03        	addw	x,(OFST-10,sp)
9031  1a5d de005e        	ldw	x,(_adc_buff_buff,x)
9032  1a60 cd0000        	call	c_itolx
9034  1a63 96            	ldw	x,sp
9035  1a64 1c0005        	addw	x,#OFST-8
9036  1a67 cd0000        	call	c_lgadd
9038                     ; 2304 	for(i=0;i<8;i++)
9040  1a6a 0c09          	inc	(OFST-4,sp)
9043  1a6c 7b09          	ld	a,(OFST-4,sp)
9044  1a6e a108          	cp	a,#8
9045  1a70 25db          	jrult	L1073
9046                     ; 2308 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9048  1a72 96            	ldw	x,sp
9049  1a73 1c0005        	addw	x,#OFST-8
9050  1a76 cd0000        	call	c_ltor
9052  1a79 a603          	ld	a,#3
9053  1a7b cd0000        	call	c_lrsh
9055  1a7e be02          	ldw	x,c_lreg+2
9056  1a80 b6c5          	ld	a,_adc_cnt
9057  1a82 905f          	clrw	y
9058  1a84 9097          	ld	yl,a
9059  1a86 9058          	sllw	y
9060  1a88 1703          	ldw	(OFST-10,sp),y
9061  1a8a b6c6          	ld	a,_adc_ch
9062  1a8c 905f          	clrw	y
9063  1a8e 9097          	ld	yl,a
9064  1a90 9058          	sllw	y
9065  1a92 9058          	sllw	y
9066  1a94 9058          	sllw	y
9067  1a96 9058          	sllw	y
9068  1a98 9058          	sllw	y
9069  1a9a 72f903        	addw	y,(OFST-10,sp)
9070  1a9d 90df011b      	ldw	(_adc_buff,y),x
9071  1aa1               L7763:
9072                     ; 2312 if((adc_cnt&0x03)==0)
9074  1aa1 b6c5          	ld	a,_adc_cnt
9075  1aa3 a503          	bcp	a,#3
9076  1aa5 264b          	jrne	L7073
9077                     ; 2316 	tempSS=0;
9079  1aa7 ae0000        	ldw	x,#0
9080  1aaa 1f07          	ldw	(OFST-6,sp),x
9081  1aac ae0000        	ldw	x,#0
9082  1aaf 1f05          	ldw	(OFST-8,sp),x
9083                     ; 2317 	for(i=0;i<16;i++)
9085  1ab1 0f09          	clr	(OFST-4,sp)
9086  1ab3               L1173:
9087                     ; 2319 		tempSS+=(signed long)adc_buff[adc_ch][i];
9089  1ab3 7b09          	ld	a,(OFST-4,sp)
9090  1ab5 5f            	clrw	x
9091  1ab6 97            	ld	xl,a
9092  1ab7 58            	sllw	x
9093  1ab8 1f03          	ldw	(OFST-10,sp),x
9094  1aba b6c6          	ld	a,_adc_ch
9095  1abc 97            	ld	xl,a
9096  1abd a620          	ld	a,#32
9097  1abf 42            	mul	x,a
9098  1ac0 72fb03        	addw	x,(OFST-10,sp)
9099  1ac3 de011b        	ldw	x,(_adc_buff,x)
9100  1ac6 cd0000        	call	c_itolx
9102  1ac9 96            	ldw	x,sp
9103  1aca 1c0005        	addw	x,#OFST-8
9104  1acd cd0000        	call	c_lgadd
9106                     ; 2317 	for(i=0;i<16;i++)
9108  1ad0 0c09          	inc	(OFST-4,sp)
9111  1ad2 7b09          	ld	a,(OFST-4,sp)
9112  1ad4 a110          	cp	a,#16
9113  1ad6 25db          	jrult	L1173
9114                     ; 2321 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9116  1ad8 96            	ldw	x,sp
9117  1ad9 1c0005        	addw	x,#OFST-8
9118  1adc cd0000        	call	c_ltor
9120  1adf a604          	ld	a,#4
9121  1ae1 cd0000        	call	c_lrsh
9123  1ae4 be02          	ldw	x,c_lreg+2
9124  1ae6 b6c6          	ld	a,_adc_ch
9125  1ae8 905f          	clrw	y
9126  1aea 9097          	ld	yl,a
9127  1aec 9058          	sllw	y
9128  1aee 90df0107      	ldw	(_adc_buff_,y),x
9129  1af2               L7073:
9130                     ; 2328 if(adc_ch==0)adc_buff_5=temp_adc;
9132  1af2 3dc6          	tnz	_adc_ch
9133  1af4 2605          	jrne	L7173
9136  1af6 1e0c          	ldw	x,(OFST-1,sp)
9137  1af8 cf0105        	ldw	_adc_buff_5,x
9138  1afb               L7173:
9139                     ; 2329 if(adc_ch==2)adc_buff_1=temp_adc;
9141  1afb b6c6          	ld	a,_adc_ch
9142  1afd a102          	cp	a,#2
9143  1aff 2605          	jrne	L1273
9146  1b01 1e0c          	ldw	x,(OFST-1,sp)
9147  1b03 cf0103        	ldw	_adc_buff_1,x
9148  1b06               L1273:
9149                     ; 2331 adc_plazma_short++;
9151  1b06 bec3          	ldw	x,_adc_plazma_short
9152  1b08 1c0001        	addw	x,#1
9153  1b0b bfc3          	ldw	_adc_plazma_short,x
9154                     ; 2333 }
9157  1b0d 5b0d          	addw	sp,#13
9158  1b0f 85            	popw	x
9159  1b10 bf00          	ldw	c_lreg,x
9160  1b12 85            	popw	x
9161  1b13 bf02          	ldw	c_lreg+2,x
9162  1b15 85            	popw	x
9163  1b16 bf00          	ldw	c_y,x
9164  1b18 85            	popw	x
9165  1b19 bf00          	ldw	c_x,x
9166  1b1b 80            	iret
9225                     ; 2342 main()
9225                     ; 2343 {
9227                     	switch	.text
9228  1b1c               _main:
9232                     ; 2345 CLK->ECKR|=1;
9234  1b1c 721050c1      	bset	20673,#0
9236  1b20               L5373:
9237                     ; 2346 while((CLK->ECKR & 2) == 0);
9239  1b20 c650c1        	ld	a,20673
9240  1b23 a502          	bcp	a,#2
9241  1b25 27f9          	jreq	L5373
9242                     ; 2347 CLK->SWCR|=2;
9244  1b27 721250c5      	bset	20677,#1
9245                     ; 2348 CLK->SWR=0xB4;
9247  1b2b 35b450c4      	mov	20676,#180
9248                     ; 2350 delay_ms(200);
9250  1b2f ae00c8        	ldw	x,#200
9251  1b32 cd0121        	call	_delay_ms
9253                     ; 2351 FLASH_DUKR=0xae;
9255  1b35 35ae5064      	mov	_FLASH_DUKR,#174
9256                     ; 2352 FLASH_DUKR=0x56;
9258  1b39 35565064      	mov	_FLASH_DUKR,#86
9259                     ; 2353 enableInterrupts();
9262  1b3d 9a            rim
9264                     ; 2356 adr_drv_v3();
9267  1b3e cd0e1c        	call	_adr_drv_v3
9269                     ; 2360 t4_init();
9271  1b41 cd1816        	call	_t4_init
9273                     ; 2362 		GPIOG->DDR|=(1<<0);
9275  1b44 72105020      	bset	20512,#0
9276                     ; 2363 		GPIOG->CR1|=(1<<0);
9278  1b48 72105021      	bset	20513,#0
9279                     ; 2364 		GPIOG->CR2&=~(1<<0);	
9281  1b4c 72115022      	bres	20514,#0
9282                     ; 2367 		GPIOG->DDR&=~(1<<1);
9284  1b50 72135020      	bres	20512,#1
9285                     ; 2368 		GPIOG->CR1|=(1<<1);
9287  1b54 72125021      	bset	20513,#1
9288                     ; 2369 		GPIOG->CR2&=~(1<<1);
9290  1b58 72135022      	bres	20514,#1
9291                     ; 2371 init_CAN();
9293  1b5c cd100c        	call	_init_CAN
9295                     ; 2376 GPIOC->DDR|=(1<<1);
9297  1b5f 7212500c      	bset	20492,#1
9298                     ; 2377 GPIOC->CR1|=(1<<1);
9300  1b63 7212500d      	bset	20493,#1
9301                     ; 2378 GPIOC->CR2|=(1<<1);
9303  1b67 7212500e      	bset	20494,#1
9304                     ; 2380 GPIOC->DDR|=(1<<2);
9306  1b6b 7214500c      	bset	20492,#2
9307                     ; 2381 GPIOC->CR1|=(1<<2);
9309  1b6f 7214500d      	bset	20493,#2
9310                     ; 2382 GPIOC->CR2|=(1<<2);
9312  1b73 7214500e      	bset	20494,#2
9313                     ; 2389 t1_init();
9315  1b77 cd1827        	call	_t1_init
9317                     ; 2391 GPIOA->DDR|=(1<<5);
9319  1b7a 721a5002      	bset	20482,#5
9320                     ; 2392 GPIOA->CR1|=(1<<5);
9322  1b7e 721a5003      	bset	20483,#5
9323                     ; 2393 GPIOA->CR2&=~(1<<5);
9325  1b82 721b5004      	bres	20484,#5
9326                     ; 2399 GPIOB->DDR&=~(1<<3);
9328  1b86 72175007      	bres	20487,#3
9329                     ; 2400 GPIOB->CR1&=~(1<<3);
9331  1b8a 72175008      	bres	20488,#3
9332                     ; 2401 GPIOB->CR2&=~(1<<3);
9334  1b8e 72175009      	bres	20489,#3
9335                     ; 2403 GPIOC->DDR|=(1<<3);
9337  1b92 7216500c      	bset	20492,#3
9338                     ; 2404 GPIOC->CR1|=(1<<3);
9340  1b96 7216500d      	bset	20493,#3
9341                     ; 2405 GPIOC->CR2|=(1<<3);
9343  1b9a 7216500e      	bset	20494,#3
9344  1b9e               L1473:
9345                     ; 2411 	if(b1000Hz)
9347                     	btst	_b1000Hz
9348  1ba3 2407          	jruge	L5473
9349                     ; 2413 		b1000Hz=0;
9351  1ba5 72110004      	bres	_b1000Hz
9352                     ; 2415 		adc2_init();
9354  1ba9 cd1864        	call	_adc2_init
9356  1bac               L5473:
9357                     ; 2418 	if(bCAN_RX)
9359  1bac 3d04          	tnz	_bCAN_RX
9360  1bae 2705          	jreq	L7473
9361                     ; 2420 		bCAN_RX=0;
9363  1bb0 3f04          	clr	_bCAN_RX
9364                     ; 2421 		can_in_an();	
9366  1bb2 cd1169        	call	_can_in_an
9368  1bb5               L7473:
9369                     ; 2423 	if(b100Hz)
9371                     	btst	_b100Hz
9372  1bba 2407          	jruge	L1573
9373                     ; 2425 		b100Hz=0;
9375  1bbc 72110009      	bres	_b100Hz
9376                     ; 2435 		can_tx_hndl();
9378  1bc0 cd10ff        	call	_can_tx_hndl
9380  1bc3               L1573:
9381                     ; 2438 	if(b10Hz)
9383                     	btst	_b10Hz
9384  1bc8 2425          	jruge	L3573
9385                     ; 2440 		b10Hz=0;
9387  1bca 72110008      	bres	_b10Hz
9388                     ; 2442 		matemat();
9390  1bce cd093e        	call	_matemat
9392                     ; 2443 		led_drv(); 
9394  1bd1 cd03ee        	call	_led_drv
9396                     ; 2444 	  link_drv();
9398  1bd4 cd04dc        	call	_link_drv
9400                     ; 2446 	  JP_drv();
9402  1bd7 cd0451        	call	_JP_drv
9404                     ; 2447 	  flags_drv();
9406  1bda cd0dd1        	call	_flags_drv
9408                     ; 2449 		if(main_cnt10<100)main_cnt10++;
9410  1bdd 9c            	rvf
9411  1bde ce025b        	ldw	x,_main_cnt10
9412  1be1 a30064        	cpw	x,#100
9413  1be4 2e09          	jrsge	L3573
9416  1be6 ce025b        	ldw	x,_main_cnt10
9417  1be9 1c0001        	addw	x,#1
9418  1bec cf025b        	ldw	_main_cnt10,x
9419  1bef               L3573:
9420                     ; 2452 	if(b5Hz)
9422                     	btst	_b5Hz
9423  1bf4 241c          	jruge	L7573
9424                     ; 2454 		b5Hz=0;
9426  1bf6 72110007      	bres	_b5Hz
9427                     ; 2460 		pwr_drv();		//воздействие на силу
9429  1bfa cd06ac        	call	_pwr_drv
9431                     ; 2461 		led_hndl();
9433  1bfd cd0163        	call	_led_hndl
9435                     ; 2463 		vent_drv();
9437  1c00 cd0534        	call	_vent_drv
9439                     ; 2465 		if(main_cnt1<1000)main_cnt1++;
9441  1c03 9c            	rvf
9442  1c04 be5b          	ldw	x,_main_cnt1
9443  1c06 a303e8        	cpw	x,#1000
9444  1c09 2e07          	jrsge	L7573
9447  1c0b be5b          	ldw	x,_main_cnt1
9448  1c0d 1c0001        	addw	x,#1
9449  1c10 bf5b          	ldw	_main_cnt1,x
9450  1c12               L7573:
9451                     ; 2468 	if(b2Hz)
9453                     	btst	_b2Hz
9454  1c17 2404          	jruge	L3673
9455                     ; 2470 		b2Hz=0;
9457  1c19 72110006      	bres	_b2Hz
9458  1c1d               L3673:
9459                     ; 2479 	if(b1Hz)
9461                     	btst	_b1Hz
9462  1c22 2503cc1b9e    	jruge	L1473
9463                     ; 2481 		b1Hz=0;
9465  1c27 72110005      	bres	_b1Hz
9466                     ; 2483 	  pwr_hndl();		//вычисление воздействий на силу
9468  1c2b cd07ef        	call	_pwr_hndl
9470                     ; 2484 		temper_drv();			//вычисление аварий температуры
9472  1c2e cd0b3e        	call	_temper_drv
9474                     ; 2485 		u_drv();
9476  1c31 cd0c15        	call	_u_drv
9478                     ; 2487 		if(main_cnt<1000)main_cnt++;
9480  1c34 9c            	rvf
9481  1c35 ce025d        	ldw	x,_main_cnt
9482  1c38 a303e8        	cpw	x,#1000
9483  1c3b 2e09          	jrsge	L7673
9486  1c3d ce025d        	ldw	x,_main_cnt
9487  1c40 1c0001        	addw	x,#1
9488  1c43 cf025d        	ldw	_main_cnt,x
9489  1c46               L7673:
9490                     ; 2488   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9492  1c46 b66d          	ld	a,_link
9493  1c48 a1aa          	cp	a,#170
9494  1c4a 2706          	jreq	L3773
9496  1c4c b654          	ld	a,_jp_mode
9497  1c4e a103          	cp	a,#3
9498  1c50 2603          	jrne	L1773
9499  1c52               L3773:
9502  1c52 cd0d32        	call	_apv_hndl
9504  1c55               L1773:
9505                     ; 2491   		can_error_cnt++;
9507  1c55 3c73          	inc	_can_error_cnt
9508                     ; 2492   		if(can_error_cnt>=10)
9510  1c57 b673          	ld	a,_can_error_cnt
9511  1c59 a10a          	cp	a,#10
9512  1c5b 2505          	jrult	L5773
9513                     ; 2494   			can_error_cnt=0;
9515  1c5d 3f73          	clr	_can_error_cnt
9516                     ; 2495 				init_CAN();
9518  1c5f cd100c        	call	_init_CAN
9520  1c62               L5773:
9521                     ; 2505 		vent_resurs_hndl();
9523  1c62 cd0000        	call	_vent_resurs_hndl
9525                     ; 2506 		alfa_hndl();
9527  1c65 cd0724        	call	_alfa_hndl
9529  1c68 ac9e1b9e      	jpf	L1473
10804                     	xdef	_main
10805                     	xdef	f_ADC2_EOC_Interrupt
10806                     	xdef	f_CAN_TX_Interrupt
10807                     	xdef	f_CAN_RX_Interrupt
10808                     	xdef	f_TIM4_UPD_Interrupt
10809                     	xdef	_adc2_init
10810                     	xdef	_t1_init
10811                     	xdef	_t4_init
10812                     	xdef	_can_in_an
10813                     	xdef	_can_tx_hndl
10814                     	xdef	_can_transmit
10815                     	xdef	_init_CAN
10816                     	xdef	_adr_drv_v3
10817                     	xdef	_adr_drv_v4
10818                     	xdef	_flags_drv
10819                     	xdef	_apv_hndl
10820                     	xdef	_apv_stop
10821                     	xdef	_apv_start
10822                     	xdef	_u_drv
10823                     	xdef	_temper_drv
10824                     	xdef	_matemat
10825                     	xdef	_pwr_hndl
10826                     	xdef	_alfa_hndl
10827                     	xdef	_pwr_drv
10828                     	xdef	_vent_drv
10829                     	xdef	_link_drv
10830                     	xdef	_JP_drv
10831                     	xdef	_led_drv
10832                     	xdef	_led_hndl
10833                     	xdef	_delay_ms
10834                     	xdef	_granee
10835                     	xdef	_gran
10836                     	xdef	_vent_resurs_hndl
10837                     	switch	.bss
10838  0000               _alfa_pwm_max_i_cnt__:
10839  0000 0000          	ds.b	2
10840                     	xdef	_alfa_pwm_max_i_cnt__
10841  0002               _alfa_pwm_max_i_cnt:
10842  0002 0000          	ds.b	2
10843                     	xdef	_alfa_pwm_max_i_cnt
10844  0004               _alfa_pwm_max_i:
10845  0004 0000          	ds.b	2
10846                     	xdef	_alfa_pwm_max_i
10847  0006               _alfa_pwm_max_t:
10848  0006 0000          	ds.b	2
10849                     	xdef	_alfa_pwm_max_t
10850                     	switch	.ubsct
10851  0001               _debug_info_to_uku:
10852  0001 000000000000  	ds.b	6
10853                     	xdef	_debug_info_to_uku
10854  0007               _pwm_u_cnt:
10855  0007 00            	ds.b	1
10856                     	xdef	_pwm_u_cnt
10857  0008               _vent_resurs_tx_cnt:
10858  0008 00            	ds.b	1
10859                     	xdef	_vent_resurs_tx_cnt
10860                     	switch	.bss
10861  0008               _vent_resurs_buff:
10862  0008 00000000      	ds.b	4
10863                     	xdef	_vent_resurs_buff
10864                     	switch	.ubsct
10865  0009               _vent_resurs_sec_cnt:
10866  0009 0000          	ds.b	2
10867                     	xdef	_vent_resurs_sec_cnt
10868                     .eeprom:	section	.data
10869  0000               _vent_resurs:
10870  0000 0000          	ds.b	2
10871                     	xdef	_vent_resurs
10872  0002               _ee_IMAXVENT:
10873  0002 0000          	ds.b	2
10874                     	xdef	_ee_IMAXVENT
10875                     	switch	.ubsct
10876  000b               _bps_class:
10877  000b 00            	ds.b	1
10878                     	xdef	_bps_class
10879  000c               _vent_pwm_integr_cnt:
10880  000c 0000          	ds.b	2
10881                     	xdef	_vent_pwm_integr_cnt
10882  000e               _vent_pwm_integr:
10883  000e 0000          	ds.b	2
10884                     	xdef	_vent_pwm_integr
10885  0010               _vent_pwm:
10886  0010 0000          	ds.b	2
10887                     	xdef	_vent_pwm
10888  0012               _pwm_vent_cnt:
10889  0012 00            	ds.b	1
10890                     	xdef	_pwm_vent_cnt
10891                     	switch	.eeprom
10892  0004               _ee_DEVICE:
10893  0004 0000          	ds.b	2
10894                     	xdef	_ee_DEVICE
10895  0006               _ee_AVT_MODE:
10896  0006 0000          	ds.b	2
10897                     	xdef	_ee_AVT_MODE
10898                     	switch	.ubsct
10899  0013               _i_main_bps_cnt:
10900  0013 000000000000  	ds.b	6
10901                     	xdef	_i_main_bps_cnt
10902  0019               _i_main_sigma:
10903  0019 0000          	ds.b	2
10904                     	xdef	_i_main_sigma
10905  001b               _i_main_num_of_bps:
10906  001b 00            	ds.b	1
10907                     	xdef	_i_main_num_of_bps
10908  001c               _i_main_avg:
10909  001c 0000          	ds.b	2
10910                     	xdef	_i_main_avg
10911  001e               _i_main_flag:
10912  001e 000000000000  	ds.b	6
10913                     	xdef	_i_main_flag
10914  0024               _i_main:
10915  0024 000000000000  	ds.b	12
10916                     	xdef	_i_main
10917  0030               _x:
10918  0030 000000000000  	ds.b	12
10919                     	xdef	_x
10920                     	xdef	_volum_u_main_
10921                     	switch	.eeprom
10922  0008               _UU_AVT:
10923  0008 0000          	ds.b	2
10924                     	xdef	_UU_AVT
10925                     	switch	.ubsct
10926  003c               _cnt_net_drv:
10927  003c 00            	ds.b	1
10928                     	xdef	_cnt_net_drv
10929                     	switch	.bit
10930  0001               _bMAIN:
10931  0001 00            	ds.b	1
10932                     	xdef	_bMAIN
10933                     	switch	.ubsct
10934  003d               _plazma_int:
10935  003d 000000000000  	ds.b	6
10936                     	xdef	_plazma_int
10937                     	xdef	_rotor_int
10938  0043               _led_green_buff:
10939  0043 00000000      	ds.b	4
10940                     	xdef	_led_green_buff
10941  0047               _led_red_buff:
10942  0047 00000000      	ds.b	4
10943                     	xdef	_led_red_buff
10944                     	xdef	_led_drv_cnt
10945                     	xdef	_led_green
10946                     	xdef	_led_red
10947  004b               _res_fl_cnt:
10948  004b 00            	ds.b	1
10949                     	xdef	_res_fl_cnt
10950                     	xdef	_bRES_
10951                     	xdef	_bRES
10952                     	switch	.eeprom
10953  000a               _res_fl_:
10954  000a 00            	ds.b	1
10955                     	xdef	_res_fl_
10956  000b               _res_fl:
10957  000b 00            	ds.b	1
10958                     	xdef	_res_fl
10959                     	switch	.ubsct
10960  004c               _cnt_apv_off:
10961  004c 00            	ds.b	1
10962                     	xdef	_cnt_apv_off
10963                     	switch	.bit
10964  0002               _bAPV:
10965  0002 00            	ds.b	1
10966                     	xdef	_bAPV
10967                     	switch	.ubsct
10968  004d               _apv_cnt_:
10969  004d 0000          	ds.b	2
10970                     	xdef	_apv_cnt_
10971  004f               _apv_cnt:
10972  004f 000000        	ds.b	3
10973                     	xdef	_apv_cnt
10974                     	xdef	_bBL_IPS
10975                     	switch	.bit
10976  0003               _bBL:
10977  0003 00            	ds.b	1
10978                     	xdef	_bBL
10979                     	switch	.ubsct
10980  0052               _cnt_JP1:
10981  0052 00            	ds.b	1
10982                     	xdef	_cnt_JP1
10983  0053               _cnt_JP0:
10984  0053 00            	ds.b	1
10985                     	xdef	_cnt_JP0
10986  0054               _jp_mode:
10987  0054 00            	ds.b	1
10988                     	xdef	_jp_mode
10989  0055               _pwm_u_:
10990  0055 0000          	ds.b	2
10991                     	xdef	_pwm_u_
10992                     	xdef	_pwm_i
10993                     	xdef	_pwm_u
10994  0057               _tmax_cnt:
10995  0057 0000          	ds.b	2
10996                     	xdef	_tmax_cnt
10997  0059               _tsign_cnt:
10998  0059 0000          	ds.b	2
10999                     	xdef	_tsign_cnt
11000                     	switch	.eeprom
11001  000c               _ee_UAVT:
11002  000c 0000          	ds.b	2
11003                     	xdef	_ee_UAVT
11004  000e               _ee_tsign:
11005  000e 0000          	ds.b	2
11006                     	xdef	_ee_tsign
11007  0010               _ee_tmax:
11008  0010 0000          	ds.b	2
11009                     	xdef	_ee_tmax
11010  0012               _ee_dU:
11011  0012 0000          	ds.b	2
11012                     	xdef	_ee_dU
11013  0014               _ee_Umax:
11014  0014 0000          	ds.b	2
11015                     	xdef	_ee_Umax
11016  0016               _ee_TZAS:
11017  0016 0000          	ds.b	2
11018                     	xdef	_ee_TZAS
11019                     	switch	.ubsct
11020  005b               _main_cnt1:
11021  005b 0000          	ds.b	2
11022                     	xdef	_main_cnt1
11023  005d               _off_bp_cnt:
11024  005d 00            	ds.b	1
11025                     	xdef	_off_bp_cnt
11026                     	xdef	_vol_i_temp_avar
11027  005e               _flags_tu_cnt_off:
11028  005e 00            	ds.b	1
11029                     	xdef	_flags_tu_cnt_off
11030  005f               _flags_tu_cnt_on:
11031  005f 00            	ds.b	1
11032                     	xdef	_flags_tu_cnt_on
11033  0060               _vol_i_temp:
11034  0060 0000          	ds.b	2
11035                     	xdef	_vol_i_temp
11036  0062               _vol_u_temp:
11037  0062 0000          	ds.b	2
11038                     	xdef	_vol_u_temp
11039                     	switch	.eeprom
11040  0018               __x_ee_:
11041  0018 0000          	ds.b	2
11042                     	xdef	__x_ee_
11043                     	switch	.ubsct
11044  0064               __x_cnt:
11045  0064 0000          	ds.b	2
11046                     	xdef	__x_cnt
11047  0066               __x__:
11048  0066 0000          	ds.b	2
11049                     	xdef	__x__
11050  0068               __x_:
11051  0068 0000          	ds.b	2
11052                     	xdef	__x_
11053  006a               _flags_tu:
11054  006a 00            	ds.b	1
11055                     	xdef	_flags_tu
11056                     	xdef	_flags
11057  006b               _link_cnt:
11058  006b 0000          	ds.b	2
11059                     	xdef	_link_cnt
11060  006d               _link:
11061  006d 00            	ds.b	1
11062                     	xdef	_link
11063  006e               _umin_cnt:
11064  006e 0000          	ds.b	2
11065                     	xdef	_umin_cnt
11066  0070               _umax_cnt:
11067  0070 0000          	ds.b	2
11068                     	xdef	_umax_cnt
11069                     	switch	.eeprom
11070  001a               _ee_K:
11071  001a 000000000000  	ds.b	20
11072                     	xdef	_ee_K
11073                     	switch	.ubsct
11074  0072               _T:
11075  0072 00            	ds.b	1
11076                     	xdef	_T
11077                     	switch	.bss
11078  000c               _Uin:
11079  000c 0000          	ds.b	2
11080                     	xdef	_Uin
11081  000e               _Usum:
11082  000e 0000          	ds.b	2
11083                     	xdef	_Usum
11084  0010               _U_out_const:
11085  0010 0000          	ds.b	2
11086                     	xdef	_U_out_const
11087  0012               _Unecc:
11088  0012 0000          	ds.b	2
11089                     	xdef	_Unecc
11090  0014               _Ui:
11091  0014 0000          	ds.b	2
11092                     	xdef	_Ui
11093  0016               _Un:
11094  0016 0000          	ds.b	2
11095                     	xdef	_Un
11096  0018               _I:
11097  0018 0000          	ds.b	2
11098                     	xdef	_I
11099                     	switch	.ubsct
11100  0073               _can_error_cnt:
11101  0073 00            	ds.b	1
11102                     	xdef	_can_error_cnt
11103                     	xdef	_bCAN_RX
11104  0074               _tx_busy_cnt:
11105  0074 00            	ds.b	1
11106                     	xdef	_tx_busy_cnt
11107                     	xdef	_bTX_FREE
11108  0075               _can_buff_rd_ptr:
11109  0075 00            	ds.b	1
11110                     	xdef	_can_buff_rd_ptr
11111  0076               _can_buff_wr_ptr:
11112  0076 00            	ds.b	1
11113                     	xdef	_can_buff_wr_ptr
11114  0077               _can_out_buff:
11115  0077 000000000000  	ds.b	64
11116                     	xdef	_can_out_buff
11117                     	switch	.bss
11118  001a               _pwm_u_buff_cnt:
11119  001a 00            	ds.b	1
11120                     	xdef	_pwm_u_buff_cnt
11121  001b               _pwm_u_buff_ptr:
11122  001b 00            	ds.b	1
11123                     	xdef	_pwm_u_buff_ptr
11124  001c               _pwm_u_buff_:
11125  001c 0000          	ds.b	2
11126                     	xdef	_pwm_u_buff_
11127  001e               _pwm_u_buff:
11128  001e 000000000000  	ds.b	64
11129                     	xdef	_pwm_u_buff
11130                     	switch	.ubsct
11131  00b7               _adc_cnt_cnt:
11132  00b7 00            	ds.b	1
11133                     	xdef	_adc_cnt_cnt
11134                     	switch	.bss
11135  005e               _adc_buff_buff:
11136  005e 000000000000  	ds.b	160
11137                     	xdef	_adc_buff_buff
11138  00fe               _adress_error:
11139  00fe 00            	ds.b	1
11140                     	xdef	_adress_error
11141  00ff               _adress:
11142  00ff 00            	ds.b	1
11143                     	xdef	_adress
11144  0100               _adr:
11145  0100 000000        	ds.b	3
11146                     	xdef	_adr
11147                     	xdef	_adr_drv_stat
11148                     	xdef	_led_ind
11149                     	switch	.ubsct
11150  00b8               _led_ind_cnt:
11151  00b8 00            	ds.b	1
11152                     	xdef	_led_ind_cnt
11153  00b9               _adc_plazma:
11154  00b9 000000000000  	ds.b	10
11155                     	xdef	_adc_plazma
11156  00c3               _adc_plazma_short:
11157  00c3 0000          	ds.b	2
11158                     	xdef	_adc_plazma_short
11159  00c5               _adc_cnt:
11160  00c5 00            	ds.b	1
11161                     	xdef	_adc_cnt
11162  00c6               _adc_ch:
11163  00c6 00            	ds.b	1
11164                     	xdef	_adc_ch
11165                     	switch	.bss
11166  0103               _adc_buff_1:
11167  0103 0000          	ds.b	2
11168                     	xdef	_adc_buff_1
11169  0105               _adc_buff_5:
11170  0105 0000          	ds.b	2
11171                     	xdef	_adc_buff_5
11172  0107               _adc_buff_:
11173  0107 000000000000  	ds.b	20
11174                     	xdef	_adc_buff_
11175  011b               _adc_buff:
11176  011b 000000000000  	ds.b	320
11177                     	xdef	_adc_buff
11178  025b               _main_cnt10:
11179  025b 0000          	ds.b	2
11180                     	xdef	_main_cnt10
11181  025d               _main_cnt:
11182  025d 0000          	ds.b	2
11183                     	xdef	_main_cnt
11184                     	switch	.ubsct
11185  00c7               _mess:
11186  00c7 000000000000  	ds.b	14
11187                     	xdef	_mess
11188                     	switch	.bit
11189  0004               _b1000Hz:
11190  0004 00            	ds.b	1
11191                     	xdef	_b1000Hz
11192  0005               _b1Hz:
11193  0005 00            	ds.b	1
11194                     	xdef	_b1Hz
11195  0006               _b2Hz:
11196  0006 00            	ds.b	1
11197                     	xdef	_b2Hz
11198  0007               _b5Hz:
11199  0007 00            	ds.b	1
11200                     	xdef	_b5Hz
11201  0008               _b10Hz:
11202  0008 00            	ds.b	1
11203                     	xdef	_b10Hz
11204  0009               _b100Hz:
11205  0009 00            	ds.b	1
11206                     	xdef	_b100Hz
11207                     	xdef	_t0_cnt4
11208                     	xdef	_t0_cnt3
11209                     	xdef	_t0_cnt2
11210                     	xdef	_t0_cnt1
11211                     	xdef	_t0_cnt0
11212                     	xdef	_t0_cnt00
11213                     	xref	_abs
11214                     	xdef	_bVENT_BLOCK
11215                     	xref.b	c_lreg
11216                     	xref.b	c_x
11217                     	xref.b	c_y
11237                     	xref	c_lrsh
11238                     	xref	c_umul
11239                     	xref	c_lgsub
11240                     	xref	c_lgrsh
11241                     	xref	c_lgadd
11242                     	xref	c_idiv
11243                     	xref	c_sdivx
11244                     	xref	c_imul
11245                     	xref	c_lsbc
11246                     	xref	c_ladd
11247                     	xref	c_lsub
11248                     	xref	c_ldiv
11249                     	xref	c_lgmul
11250                     	xref	c_itolx
11251                     	xref	c_eewrc
11252                     	xref	c_ltor
11253                     	xref	c_lgadc
11254                     	xref	c_rtol
11255                     	xref	c_vmul
11256                     	xref	c_eewrw
11257                     	xref	c_lcmp
11258                     	xref	c_uitolx
11259                     	end
