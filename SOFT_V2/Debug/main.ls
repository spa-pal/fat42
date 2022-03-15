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
4282  07cb 2711          	jreq	L3122
4283                     ; 865 	alfa_pwm_max_i_cnt--;
4285  07cd ce0002        	ldw	x,_alfa_pwm_max_i_cnt
4286  07d0 1d0001        	subw	x,#1
4287  07d3 cf0002        	ldw	_alfa_pwm_max_i_cnt,x
4288                     ; 866 	alfa_pwm_max_i=1200;	
4290  07d6 ae04b0        	ldw	x,#1200
4291  07d9 cf0004        	ldw	_alfa_pwm_max_i,x
4293  07dc 2006          	jra	L5122
4294  07de               L3122:
4295                     ; 870 	alfa_pwm_max_i=2000;
4297  07de ae07d0        	ldw	x,#2000
4298  07e1 cf0004        	ldw	_alfa_pwm_max_i,x
4299  07e4               L5122:
4300                     ; 872 }
4303  07e4 85            	popw	x
4304  07e5 81            	ret
4361                     	switch	.const
4362  0018               L06:
4363  0018 0000028a      	dc.l	650
4364                     ; 877 void pwr_hndl(void)				
4364                     ; 878 {
4365                     	switch	.text
4366  07e6               _pwr_hndl:
4368  07e6 5205          	subw	sp,#5
4369       00000005      OFST:	set	5
4372                     ; 879 if(jp_mode==jp3)
4374  07e8 b654          	ld	a,_jp_mode
4375  07ea a103          	cp	a,#3
4376  07ec 260a          	jrne	L1422
4377                     ; 881 	pwm_u=0;
4379  07ee 5f            	clrw	x
4380  07ef bf08          	ldw	_pwm_u,x
4381                     ; 882 	pwm_i=0;
4383  07f1 5f            	clrw	x
4384  07f2 bf0a          	ldw	_pwm_i,x
4386  07f4 ac1c091c      	jpf	L3422
4387  07f8               L1422:
4388                     ; 884 else if(jp_mode==jp2)
4390  07f8 b654          	ld	a,_jp_mode
4391  07fa a102          	cp	a,#2
4392  07fc 260c          	jrne	L5422
4393                     ; 886 	pwm_u=0;
4395  07fe 5f            	clrw	x
4396  07ff bf08          	ldw	_pwm_u,x
4397                     ; 887 	pwm_i=0x7ff;
4399  0801 ae07ff        	ldw	x,#2047
4400  0804 bf0a          	ldw	_pwm_i,x
4402  0806 ac1c091c      	jpf	L3422
4403  080a               L5422:
4404                     ; 889 else if(jp_mode==jp1)
4406  080a b654          	ld	a,_jp_mode
4407  080c a101          	cp	a,#1
4408  080e 260e          	jrne	L1522
4409                     ; 891 	pwm_u=0x7ff;
4411  0810 ae07ff        	ldw	x,#2047
4412  0813 bf08          	ldw	_pwm_u,x
4413                     ; 892 	pwm_i=0x7ff;
4415  0815 ae07ff        	ldw	x,#2047
4416  0818 bf0a          	ldw	_pwm_i,x
4418  081a ac1c091c      	jpf	L3422
4419  081e               L1522:
4420                     ; 903 else if(link==OFF)
4422  081e b66d          	ld	a,_link
4423  0820 a1aa          	cp	a,#170
4424  0822 2703          	jreq	L26
4425  0824 cc08c6        	jp	L5522
4426  0827               L26:
4427                     ; 905 	pwm_i=0x7ff;
4429  0827 ae07ff        	ldw	x,#2047
4430  082a bf0a          	ldw	_pwm_i,x
4431                     ; 906 	pwm_u_=(short)((2000L*((long)Unecc))/650L);
4433  082c ce0012        	ldw	x,_Unecc
4434  082f 90ae07d0      	ldw	y,#2000
4435  0833 cd0000        	call	c_vmul
4437  0836 ae0018        	ldw	x,#L06
4438  0839 cd0000        	call	c_ldiv
4440  083c be02          	ldw	x,c_lreg+2
4441  083e bf55          	ldw	_pwm_u_,x
4442                     ; 910 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4444  0840 c6001b        	ld	a,_pwm_u_buff_ptr
4445  0843 5f            	clrw	x
4446  0844 97            	ld	xl,a
4447  0845 58            	sllw	x
4448  0846 90be55        	ldw	y,_pwm_u_
4449  0849 df001e        	ldw	(_pwm_u_buff,x),y
4450                     ; 911 	pwm_u_buff_ptr++;
4452  084c 725c001b      	inc	_pwm_u_buff_ptr
4453                     ; 912 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4455  0850 c6001b        	ld	a,_pwm_u_buff_ptr
4456  0853 a110          	cp	a,#16
4457  0855 2504          	jrult	L7522
4460  0857 725f001b      	clr	_pwm_u_buff_ptr
4461  085b               L7522:
4462                     ; 916 		tempSL=0;
4464  085b ae0000        	ldw	x,#0
4465  085e 1f03          	ldw	(OFST-2,sp),x
4466  0860 ae0000        	ldw	x,#0
4467  0863 1f01          	ldw	(OFST-4,sp),x
4468                     ; 917 		for(i=0;i<16;i++)
4470  0865 0f05          	clr	(OFST+0,sp)
4471  0867               L1622:
4472                     ; 919 			tempSL+=(signed long)pwm_u_buff[i];
4474  0867 7b05          	ld	a,(OFST+0,sp)
4475  0869 5f            	clrw	x
4476  086a 97            	ld	xl,a
4477  086b 58            	sllw	x
4478  086c de001e        	ldw	x,(_pwm_u_buff,x)
4479  086f cd0000        	call	c_itolx
4481  0872 96            	ldw	x,sp
4482  0873 1c0001        	addw	x,#OFST-4
4483  0876 cd0000        	call	c_lgadd
4485                     ; 917 		for(i=0;i<16;i++)
4487  0879 0c05          	inc	(OFST+0,sp)
4490  087b 7b05          	ld	a,(OFST+0,sp)
4491  087d a110          	cp	a,#16
4492  087f 25e6          	jrult	L1622
4493                     ; 921 		tempSL>>=4;
4495  0881 96            	ldw	x,sp
4496  0882 1c0001        	addw	x,#OFST-4
4497  0885 a604          	ld	a,#4
4498  0887 cd0000        	call	c_lgrsh
4500                     ; 922 		pwm_u_buff_=(signed short)tempSL;
4502  088a 1e03          	ldw	x,(OFST-2,sp)
4503  088c cf001c        	ldw	_pwm_u_buff_,x
4504                     ; 924 	pwm_u=pwm_u_;
4506  088f be55          	ldw	x,_pwm_u_
4507  0891 bf08          	ldw	_pwm_u,x
4508                     ; 925 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4510  0893 9c            	rvf
4511  0894 ce0014        	ldw	x,_Ui
4512  0897 72b00012      	subw	x,_Unecc
4513  089b cd0000        	call	_abs
4515  089e a30014        	cpw	x,#20
4516  08a1 2e06          	jrsge	L7622
4519  08a3 725c001a      	inc	_pwm_u_buff_cnt
4521  08a7 2004          	jra	L1722
4522  08a9               L7622:
4523                     ; 926 	else pwm_u_buff_cnt=0;
4525  08a9 725f001a      	clr	_pwm_u_buff_cnt
4526  08ad               L1722:
4527                     ; 928 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4529  08ad c6001a        	ld	a,_pwm_u_buff_cnt
4530  08b0 a114          	cp	a,#20
4531  08b2 2504          	jrult	L3722
4534  08b4 3514001a      	mov	_pwm_u_buff_cnt,#20
4535  08b8               L3722:
4536                     ; 929 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4538  08b8 c6001a        	ld	a,_pwm_u_buff_cnt
4539  08bb a10f          	cp	a,#15
4540  08bd 255d          	jrult	L3422
4543  08bf ce001c        	ldw	x,_pwm_u_buff_
4544  08c2 bf08          	ldw	_pwm_u,x
4545  08c4 2056          	jra	L3422
4546  08c6               L5522:
4547                     ; 933 else	if(link==ON)				//если есть связьvol_i_temp_avar
4549  08c6 b66d          	ld	a,_link
4550  08c8 a155          	cp	a,#85
4551  08ca 2650          	jrne	L3422
4552                     ; 935 	if((flags&0b00100000)==0)	//если нет блокировки извне
4554  08cc b605          	ld	a,_flags
4555  08ce a520          	bcp	a,#32
4556  08d0 263e          	jrne	L3032
4557                     ; 942 		else*/ if(flags&0b00011010)					//если есть аварии
4559  08d2 b605          	ld	a,_flags
4560  08d4 a51a          	bcp	a,#26
4561  08d6 2706          	jreq	L5032
4562                     ; 944 			pwm_u=0;								//то полный стоп
4564  08d8 5f            	clrw	x
4565  08d9 bf08          	ldw	_pwm_u,x
4566                     ; 945 			pwm_i=0;
4568  08db 5f            	clrw	x
4569  08dc bf0a          	ldw	_pwm_i,x
4570  08de               L5032:
4571                     ; 948 		if(vol_i_temp==2000)
4573  08de be60          	ldw	x,_vol_i_temp
4574  08e0 a307d0        	cpw	x,#2000
4575  08e3 260c          	jrne	L7032
4576                     ; 950 			pwm_u=1500;
4578  08e5 ae05dc        	ldw	x,#1500
4579  08e8 bf08          	ldw	_pwm_u,x
4580                     ; 951 			pwm_i=2000;
4582  08ea ae07d0        	ldw	x,#2000
4583  08ed bf0a          	ldw	_pwm_i,x
4585  08ef 202b          	jra	L3422
4586  08f1               L7032:
4587                     ; 964 			pwm_u=(short)((2000L*((long)Unecc))/650L);
4589  08f1 ce0012        	ldw	x,_Unecc
4590  08f4 90ae07d0      	ldw	y,#2000
4591  08f8 cd0000        	call	c_vmul
4593  08fb ae0018        	ldw	x,#L06
4594  08fe cd0000        	call	c_ldiv
4596  0901 be02          	ldw	x,c_lreg+2
4597  0903 bf08          	ldw	_pwm_u,x
4598                     ; 965 			pwm_i=2000;
4600  0905 ae07d0        	ldw	x,#2000
4601  0908 bf0a          	ldw	_pwm_i,x
4602                     ; 966 			pwm_u=vol_i_temp;
4604  090a be60          	ldw	x,_vol_i_temp
4605  090c bf08          	ldw	_pwm_u,x
4606  090e 200c          	jra	L3422
4607  0910               L3032:
4608                     ; 972 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4610  0910 b605          	ld	a,_flags
4611  0912 a520          	bcp	a,#32
4612  0914 2706          	jreq	L3422
4613                     ; 974 		pwm_u=0;
4615  0916 5f            	clrw	x
4616  0917 bf08          	ldw	_pwm_u,x
4617                     ; 975 		pwm_i=0;
4619  0919 5f            	clrw	x
4620  091a bf0a          	ldw	_pwm_i,x
4621  091c               L3422:
4622                     ; 1003 if(pwm_u>2000)pwm_u=2000;
4624  091c 9c            	rvf
4625  091d be08          	ldw	x,_pwm_u
4626  091f a307d1        	cpw	x,#2001
4627  0922 2f05          	jrslt	L7132
4630  0924 ae07d0        	ldw	x,#2000
4631  0927 bf08          	ldw	_pwm_u,x
4632  0929               L7132:
4633                     ; 1004 if(pwm_i>2000)pwm_i=2000;
4635  0929 9c            	rvf
4636  092a be0a          	ldw	x,_pwm_i
4637  092c a307d1        	cpw	x,#2001
4638  092f 2f05          	jrslt	L1232
4641  0931 ae07d0        	ldw	x,#2000
4642  0934 bf0a          	ldw	_pwm_i,x
4643  0936               L1232:
4644                     ; 1007 }
4647  0936 5b05          	addw	sp,#5
4648  0938 81            	ret
4701                     	switch	.const
4702  001c               L66:
4703  001c 00000258      	dc.l	600
4704  0020               L07:
4705  0020 000003e8      	dc.l	1000
4706  0024               L27:
4707  0024 00000708      	dc.l	1800
4708                     ; 1010 void matemat(void)
4708                     ; 1011 {
4709                     	switch	.text
4710  0939               _matemat:
4712  0939 5208          	subw	sp,#8
4713       00000008      OFST:	set	8
4716                     ; 1035 I=adc_buff_[4];
4718  093b ce010f        	ldw	x,_adc_buff_+8
4719  093e cf0018        	ldw	_I,x
4720                     ; 1036 temp_SL=adc_buff_[4];
4722  0941 ce010f        	ldw	x,_adc_buff_+8
4723  0944 cd0000        	call	c_itolx
4725  0947 96            	ldw	x,sp
4726  0948 1c0005        	addw	x,#OFST-3
4727  094b cd0000        	call	c_rtol
4729                     ; 1037 temp_SL-=ee_K[0][0];
4731  094e ce001a        	ldw	x,_ee_K
4732  0951 cd0000        	call	c_itolx
4734  0954 96            	ldw	x,sp
4735  0955 1c0005        	addw	x,#OFST-3
4736  0958 cd0000        	call	c_lgsub
4738                     ; 1038 if(temp_SL<0) temp_SL=0;
4740  095b 9c            	rvf
4741  095c 0d05          	tnz	(OFST-3,sp)
4742  095e 2e0a          	jrsge	L1432
4745  0960 ae0000        	ldw	x,#0
4746  0963 1f07          	ldw	(OFST-1,sp),x
4747  0965 ae0000        	ldw	x,#0
4748  0968 1f05          	ldw	(OFST-3,sp),x
4749  096a               L1432:
4750                     ; 1039 temp_SL*=ee_K[0][1];
4752  096a ce001c        	ldw	x,_ee_K+2
4753  096d cd0000        	call	c_itolx
4755  0970 96            	ldw	x,sp
4756  0971 1c0005        	addw	x,#OFST-3
4757  0974 cd0000        	call	c_lgmul
4759                     ; 1040 temp_SL/=600;
4761  0977 96            	ldw	x,sp
4762  0978 1c0005        	addw	x,#OFST-3
4763  097b cd0000        	call	c_ltor
4765  097e ae001c        	ldw	x,#L66
4766  0981 cd0000        	call	c_ldiv
4768  0984 96            	ldw	x,sp
4769  0985 1c0005        	addw	x,#OFST-3
4770  0988 cd0000        	call	c_rtol
4772                     ; 1041 I=(signed short)temp_SL;
4774  098b 1e07          	ldw	x,(OFST-1,sp)
4775  098d cf0018        	ldw	_I,x
4776                     ; 1044 temp_SL=(signed long)adc_buff_[1];//1;
4778                     ; 1045 temp_SL=(signed long)adc_buff_[3];//1;
4780  0990 ce010d        	ldw	x,_adc_buff_+6
4781  0993 cd0000        	call	c_itolx
4783  0996 96            	ldw	x,sp
4784  0997 1c0005        	addw	x,#OFST-3
4785  099a cd0000        	call	c_rtol
4787                     ; 1047 if(temp_SL<0) temp_SL=0;
4789  099d 9c            	rvf
4790  099e 0d05          	tnz	(OFST-3,sp)
4791  09a0 2e0a          	jrsge	L3432
4794  09a2 ae0000        	ldw	x,#0
4795  09a5 1f07          	ldw	(OFST-1,sp),x
4796  09a7 ae0000        	ldw	x,#0
4797  09aa 1f05          	ldw	(OFST-3,sp),x
4798  09ac               L3432:
4799                     ; 1048 temp_SL*=(signed long)ee_K[2][1];
4801  09ac ce0024        	ldw	x,_ee_K+10
4802  09af cd0000        	call	c_itolx
4804  09b2 96            	ldw	x,sp
4805  09b3 1c0005        	addw	x,#OFST-3
4806  09b6 cd0000        	call	c_lgmul
4808                     ; 1049 temp_SL/=1000L;
4810  09b9 96            	ldw	x,sp
4811  09ba 1c0005        	addw	x,#OFST-3
4812  09bd cd0000        	call	c_ltor
4814  09c0 ae0020        	ldw	x,#L07
4815  09c3 cd0000        	call	c_ldiv
4817  09c6 96            	ldw	x,sp
4818  09c7 1c0005        	addw	x,#OFST-3
4819  09ca cd0000        	call	c_rtol
4821                     ; 1050 Ui=(unsigned short)temp_SL;
4823  09cd 1e07          	ldw	x,(OFST-1,sp)
4824  09cf cf0014        	ldw	_Ui,x
4825                     ; 1052 temp_SL=(signed long)adc_buff_5;
4827  09d2 ce0105        	ldw	x,_adc_buff_5
4828  09d5 cd0000        	call	c_itolx
4830  09d8 96            	ldw	x,sp
4831  09d9 1c0005        	addw	x,#OFST-3
4832  09dc cd0000        	call	c_rtol
4834                     ; 1054 if(temp_SL<0) temp_SL=0;
4836  09df 9c            	rvf
4837  09e0 0d05          	tnz	(OFST-3,sp)
4838  09e2 2e0a          	jrsge	L5432
4841  09e4 ae0000        	ldw	x,#0
4842  09e7 1f07          	ldw	(OFST-1,sp),x
4843  09e9 ae0000        	ldw	x,#0
4844  09ec 1f05          	ldw	(OFST-3,sp),x
4845  09ee               L5432:
4846                     ; 1055 temp_SL*=(signed long)ee_K[4][1];
4848  09ee ce002c        	ldw	x,_ee_K+18
4849  09f1 cd0000        	call	c_itolx
4851  09f4 96            	ldw	x,sp
4852  09f5 1c0005        	addw	x,#OFST-3
4853  09f8 cd0000        	call	c_lgmul
4855                     ; 1056 temp_SL/=1000L;
4857  09fb 96            	ldw	x,sp
4858  09fc 1c0005        	addw	x,#OFST-3
4859  09ff cd0000        	call	c_ltor
4861  0a02 ae0020        	ldw	x,#L07
4862  0a05 cd0000        	call	c_ldiv
4864  0a08 96            	ldw	x,sp
4865  0a09 1c0005        	addw	x,#OFST-3
4866  0a0c cd0000        	call	c_rtol
4868                     ; 1057 Usum=(unsigned short)temp_SL;
4870  0a0f 1e07          	ldw	x,(OFST-1,sp)
4871  0a11 cf000e        	ldw	_Usum,x
4872                     ; 1061 temp_SL=adc_buff_[3];
4874  0a14 ce010d        	ldw	x,_adc_buff_+6
4875  0a17 cd0000        	call	c_itolx
4877  0a1a 96            	ldw	x,sp
4878  0a1b 1c0005        	addw	x,#OFST-3
4879  0a1e cd0000        	call	c_rtol
4881                     ; 1063 if(temp_SL<0) temp_SL=0;
4883  0a21 9c            	rvf
4884  0a22 0d05          	tnz	(OFST-3,sp)
4885  0a24 2e0a          	jrsge	L7432
4888  0a26 ae0000        	ldw	x,#0
4889  0a29 1f07          	ldw	(OFST-1,sp),x
4890  0a2b ae0000        	ldw	x,#0
4891  0a2e 1f05          	ldw	(OFST-3,sp),x
4892  0a30               L7432:
4893                     ; 1064 temp_SL*=ee_K[1][1];
4895  0a30 ce0020        	ldw	x,_ee_K+6
4896  0a33 cd0000        	call	c_itolx
4898  0a36 96            	ldw	x,sp
4899  0a37 1c0005        	addw	x,#OFST-3
4900  0a3a cd0000        	call	c_lgmul
4902                     ; 1065 temp_SL/=1800;
4904  0a3d 96            	ldw	x,sp
4905  0a3e 1c0005        	addw	x,#OFST-3
4906  0a41 cd0000        	call	c_ltor
4908  0a44 ae0024        	ldw	x,#L27
4909  0a47 cd0000        	call	c_ldiv
4911  0a4a 96            	ldw	x,sp
4912  0a4b 1c0005        	addw	x,#OFST-3
4913  0a4e cd0000        	call	c_rtol
4915                     ; 1066 Un=(unsigned short)temp_SL;
4917  0a51 1e07          	ldw	x,(OFST-1,sp)
4918  0a53 cf0016        	ldw	_Un,x
4919                     ; 1071 temp_SL=adc_buff_[2];
4921  0a56 ce010b        	ldw	x,_adc_buff_+4
4922  0a59 cd0000        	call	c_itolx
4924  0a5c 96            	ldw	x,sp
4925  0a5d 1c0005        	addw	x,#OFST-3
4926  0a60 cd0000        	call	c_rtol
4928                     ; 1072 temp_SL*=ee_K[3][1];
4930  0a63 ce0028        	ldw	x,_ee_K+14
4931  0a66 cd0000        	call	c_itolx
4933  0a69 96            	ldw	x,sp
4934  0a6a 1c0005        	addw	x,#OFST-3
4935  0a6d cd0000        	call	c_lgmul
4937                     ; 1073 temp_SL/=1000;
4939  0a70 96            	ldw	x,sp
4940  0a71 1c0005        	addw	x,#OFST-3
4941  0a74 cd0000        	call	c_ltor
4943  0a77 ae0020        	ldw	x,#L07
4944  0a7a cd0000        	call	c_ldiv
4946  0a7d 96            	ldw	x,sp
4947  0a7e 1c0005        	addw	x,#OFST-3
4948  0a81 cd0000        	call	c_rtol
4950                     ; 1074 T=(signed short)(temp_SL-273L);
4952  0a84 7b08          	ld	a,(OFST+0,sp)
4953  0a86 5f            	clrw	x
4954  0a87 4d            	tnz	a
4955  0a88 2a01          	jrpl	L47
4956  0a8a 53            	cplw	x
4957  0a8b               L47:
4958  0a8b 97            	ld	xl,a
4959  0a8c 1d0111        	subw	x,#273
4960  0a8f 01            	rrwa	x,a
4961  0a90 b772          	ld	_T,a
4962  0a92 02            	rlwa	x,a
4963                     ; 1075 if(T<-30)T=-30;
4965  0a93 9c            	rvf
4966  0a94 b672          	ld	a,_T
4967  0a96 a1e2          	cp	a,#226
4968  0a98 2e04          	jrsge	L1532
4971  0a9a 35e20072      	mov	_T,#226
4972  0a9e               L1532:
4973                     ; 1076 if(T>120)T=120;
4975  0a9e 9c            	rvf
4976  0a9f b672          	ld	a,_T
4977  0aa1 a179          	cp	a,#121
4978  0aa3 2f04          	jrslt	L3532
4981  0aa5 35780072      	mov	_T,#120
4982  0aa9               L3532:
4983                     ; 1080 Uin=Usum-Ui;
4985  0aa9 ce000e        	ldw	x,_Usum
4986  0aac 72b00014      	subw	x,_Ui
4987  0ab0 cf000c        	ldw	_Uin,x
4988                     ; 1081 if(link==ON)
4990  0ab3 b66d          	ld	a,_link
4991  0ab5 a155          	cp	a,#85
4992  0ab7 2610          	jrne	L5532
4993                     ; 1083 	Unecc=U_out_const-Uin+vol_i_temp;
4995  0ab9 ce0010        	ldw	x,_U_out_const
4996  0abc 72b0000c      	subw	x,_Uin
4997  0ac0 72bb0060      	addw	x,_vol_i_temp
4998  0ac4 cf0012        	ldw	_Unecc,x
5000  0ac7 200a          	jra	L7532
5001  0ac9               L5532:
5002                     ; 1092 else Unecc=ee_UAVT-Uin;
5004  0ac9 ce000c        	ldw	x,_ee_UAVT
5005  0acc 72b0000c      	subw	x,_Uin
5006  0ad0 cf0012        	ldw	_Unecc,x
5007  0ad3               L7532:
5008                     ; 1100 if(Unecc<0)Unecc=0;
5010  0ad3 9c            	rvf
5011  0ad4 ce0012        	ldw	x,_Unecc
5012  0ad7 2e04          	jrsge	L1632
5015  0ad9 5f            	clrw	x
5016  0ada cf0012        	ldw	_Unecc,x
5017  0add               L1632:
5018                     ; 1101 temp_SL=(signed long)(T-ee_tsign);
5020  0add 5f            	clrw	x
5021  0ade b672          	ld	a,_T
5022  0ae0 2a01          	jrpl	L67
5023  0ae2 53            	cplw	x
5024  0ae3               L67:
5025  0ae3 97            	ld	xl,a
5026  0ae4 72b0000e      	subw	x,_ee_tsign
5027  0ae8 cd0000        	call	c_itolx
5029  0aeb 96            	ldw	x,sp
5030  0aec 1c0005        	addw	x,#OFST-3
5031  0aef cd0000        	call	c_rtol
5033                     ; 1102 temp_SL*=1000L;
5035  0af2 ae03e8        	ldw	x,#1000
5036  0af5 bf02          	ldw	c_lreg+2,x
5037  0af7 ae0000        	ldw	x,#0
5038  0afa bf00          	ldw	c_lreg,x
5039  0afc 96            	ldw	x,sp
5040  0afd 1c0005        	addw	x,#OFST-3
5041  0b00 cd0000        	call	c_lgmul
5043                     ; 1103 temp_SL/=(signed long)(ee_tmax-ee_tsign);
5045  0b03 ce0010        	ldw	x,_ee_tmax
5046  0b06 72b0000e      	subw	x,_ee_tsign
5047  0b0a cd0000        	call	c_itolx
5049  0b0d 96            	ldw	x,sp
5050  0b0e 1c0001        	addw	x,#OFST-7
5051  0b11 cd0000        	call	c_rtol
5053  0b14 96            	ldw	x,sp
5054  0b15 1c0005        	addw	x,#OFST-3
5055  0b18 cd0000        	call	c_ltor
5057  0b1b 96            	ldw	x,sp
5058  0b1c 1c0001        	addw	x,#OFST-7
5059  0b1f cd0000        	call	c_ldiv
5061  0b22 96            	ldw	x,sp
5062  0b23 1c0005        	addw	x,#OFST-3
5063  0b26 cd0000        	call	c_rtol
5065                     ; 1105 vol_i_temp_avar=(unsigned short)temp_SL; 
5067  0b29 1e07          	ldw	x,(OFST-1,sp)
5068  0b2b bf06          	ldw	_vol_i_temp_avar,x
5069                     ; 1107 debug_info_to_uku[0]=pwm_u;
5071  0b2d be08          	ldw	x,_pwm_u
5072  0b2f bf01          	ldw	_debug_info_to_uku,x
5073                     ; 1108 debug_info_to_uku[1]=Unecc;
5075  0b31 ce0012        	ldw	x,_Unecc
5076  0b34 bf03          	ldw	_debug_info_to_uku+2,x
5077                     ; 1110 }
5080  0b36 5b08          	addw	sp,#8
5081  0b38 81            	ret
5112                     ; 1113 void temper_drv(void)		//1 Hz
5112                     ; 1114 {
5113                     	switch	.text
5114  0b39               _temper_drv:
5118                     ; 1116 if(T>ee_tsign) tsign_cnt++;
5120  0b39 9c            	rvf
5121  0b3a 5f            	clrw	x
5122  0b3b b672          	ld	a,_T
5123  0b3d 2a01          	jrpl	L201
5124  0b3f 53            	cplw	x
5125  0b40               L201:
5126  0b40 97            	ld	xl,a
5127  0b41 c3000e        	cpw	x,_ee_tsign
5128  0b44 2d09          	jrsle	L3732
5131  0b46 be59          	ldw	x,_tsign_cnt
5132  0b48 1c0001        	addw	x,#1
5133  0b4b bf59          	ldw	_tsign_cnt,x
5135  0b4d 201d          	jra	L5732
5136  0b4f               L3732:
5137                     ; 1117 else if (T<(ee_tsign-1)) tsign_cnt--;
5139  0b4f 9c            	rvf
5140  0b50 ce000e        	ldw	x,_ee_tsign
5141  0b53 5a            	decw	x
5142  0b54 905f          	clrw	y
5143  0b56 b672          	ld	a,_T
5144  0b58 2a02          	jrpl	L401
5145  0b5a 9053          	cplw	y
5146  0b5c               L401:
5147  0b5c 9097          	ld	yl,a
5148  0b5e 90bf00        	ldw	c_y,y
5149  0b61 b300          	cpw	x,c_y
5150  0b63 2d07          	jrsle	L5732
5153  0b65 be59          	ldw	x,_tsign_cnt
5154  0b67 1d0001        	subw	x,#1
5155  0b6a bf59          	ldw	_tsign_cnt,x
5156  0b6c               L5732:
5157                     ; 1119 gran(&tsign_cnt,0,60);
5159  0b6c ae003c        	ldw	x,#60
5160  0b6f 89            	pushw	x
5161  0b70 5f            	clrw	x
5162  0b71 89            	pushw	x
5163  0b72 ae0059        	ldw	x,#_tsign_cnt
5164  0b75 cd00d5        	call	_gran
5166  0b78 5b04          	addw	sp,#4
5167                     ; 1121 if(tsign_cnt>=55)
5169  0b7a 9c            	rvf
5170  0b7b be59          	ldw	x,_tsign_cnt
5171  0b7d a30037        	cpw	x,#55
5172  0b80 2f16          	jrslt	L1042
5173                     ; 1123 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5175  0b82 3d54          	tnz	_jp_mode
5176  0b84 2606          	jrne	L7042
5178  0b86 b605          	ld	a,_flags
5179  0b88 a540          	bcp	a,#64
5180  0b8a 2706          	jreq	L5042
5181  0b8c               L7042:
5183  0b8c b654          	ld	a,_jp_mode
5184  0b8e a103          	cp	a,#3
5185  0b90 2612          	jrne	L1142
5186  0b92               L5042:
5189  0b92 72140005      	bset	_flags,#2
5190  0b96 200c          	jra	L1142
5191  0b98               L1042:
5192                     ; 1125 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5194  0b98 9c            	rvf
5195  0b99 be59          	ldw	x,_tsign_cnt
5196  0b9b a30006        	cpw	x,#6
5197  0b9e 2e04          	jrsge	L1142
5200  0ba0 72150005      	bres	_flags,#2
5201  0ba4               L1142:
5202                     ; 1130 if(T>ee_tmax) tmax_cnt++;
5204  0ba4 9c            	rvf
5205  0ba5 5f            	clrw	x
5206  0ba6 b672          	ld	a,_T
5207  0ba8 2a01          	jrpl	L601
5208  0baa 53            	cplw	x
5209  0bab               L601:
5210  0bab 97            	ld	xl,a
5211  0bac c30010        	cpw	x,_ee_tmax
5212  0baf 2d09          	jrsle	L5142
5215  0bb1 be57          	ldw	x,_tmax_cnt
5216  0bb3 1c0001        	addw	x,#1
5217  0bb6 bf57          	ldw	_tmax_cnt,x
5219  0bb8 201d          	jra	L7142
5220  0bba               L5142:
5221                     ; 1131 else if (T<(ee_tmax-1)) tmax_cnt--;
5223  0bba 9c            	rvf
5224  0bbb ce0010        	ldw	x,_ee_tmax
5225  0bbe 5a            	decw	x
5226  0bbf 905f          	clrw	y
5227  0bc1 b672          	ld	a,_T
5228  0bc3 2a02          	jrpl	L011
5229  0bc5 9053          	cplw	y
5230  0bc7               L011:
5231  0bc7 9097          	ld	yl,a
5232  0bc9 90bf00        	ldw	c_y,y
5233  0bcc b300          	cpw	x,c_y
5234  0bce 2d07          	jrsle	L7142
5237  0bd0 be57          	ldw	x,_tmax_cnt
5238  0bd2 1d0001        	subw	x,#1
5239  0bd5 bf57          	ldw	_tmax_cnt,x
5240  0bd7               L7142:
5241                     ; 1133 gran(&tmax_cnt,0,60);
5243  0bd7 ae003c        	ldw	x,#60
5244  0bda 89            	pushw	x
5245  0bdb 5f            	clrw	x
5246  0bdc 89            	pushw	x
5247  0bdd ae0057        	ldw	x,#_tmax_cnt
5248  0be0 cd00d5        	call	_gran
5250  0be3 5b04          	addw	sp,#4
5251                     ; 1135 if(tmax_cnt>=55)
5253  0be5 9c            	rvf
5254  0be6 be57          	ldw	x,_tmax_cnt
5255  0be8 a30037        	cpw	x,#55
5256  0beb 2f16          	jrslt	L3242
5257                     ; 1137 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5259  0bed 3d54          	tnz	_jp_mode
5260  0bef 2606          	jrne	L1342
5262  0bf1 b605          	ld	a,_flags
5263  0bf3 a540          	bcp	a,#64
5264  0bf5 2706          	jreq	L7242
5265  0bf7               L1342:
5267  0bf7 b654          	ld	a,_jp_mode
5268  0bf9 a103          	cp	a,#3
5269  0bfb 2612          	jrne	L3342
5270  0bfd               L7242:
5273  0bfd 72120005      	bset	_flags,#1
5274  0c01 200c          	jra	L3342
5275  0c03               L3242:
5276                     ; 1139 else if (tmax_cnt<=5) flags&=0b11111101;
5278  0c03 9c            	rvf
5279  0c04 be57          	ldw	x,_tmax_cnt
5280  0c06 a30006        	cpw	x,#6
5281  0c09 2e04          	jrsge	L3342
5284  0c0b 72130005      	bres	_flags,#1
5285  0c0f               L3342:
5286                     ; 1142 } 
5289  0c0f 81            	ret
5321                     ; 1145 void u_drv(void)		//1Hz
5321                     ; 1146 { 
5322                     	switch	.text
5323  0c10               _u_drv:
5327                     ; 1147 if(jp_mode!=jp3)
5329  0c10 b654          	ld	a,_jp_mode
5330  0c12 a103          	cp	a,#3
5331  0c14 2774          	jreq	L7442
5332                     ; 1149 	if(Ui>ee_Umax)umax_cnt++;
5334  0c16 9c            	rvf
5335  0c17 ce0014        	ldw	x,_Ui
5336  0c1a c30014        	cpw	x,_ee_Umax
5337  0c1d 2d09          	jrsle	L1542
5340  0c1f be70          	ldw	x,_umax_cnt
5341  0c21 1c0001        	addw	x,#1
5342  0c24 bf70          	ldw	_umax_cnt,x
5344  0c26 2003          	jra	L3542
5345  0c28               L1542:
5346                     ; 1150 	else umax_cnt=0;
5348  0c28 5f            	clrw	x
5349  0c29 bf70          	ldw	_umax_cnt,x
5350  0c2b               L3542:
5351                     ; 1151 	gran(&umax_cnt,0,10);
5353  0c2b ae000a        	ldw	x,#10
5354  0c2e 89            	pushw	x
5355  0c2f 5f            	clrw	x
5356  0c30 89            	pushw	x
5357  0c31 ae0070        	ldw	x,#_umax_cnt
5358  0c34 cd00d5        	call	_gran
5360  0c37 5b04          	addw	sp,#4
5361                     ; 1152 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5363  0c39 9c            	rvf
5364  0c3a be70          	ldw	x,_umax_cnt
5365  0c3c a3000a        	cpw	x,#10
5366  0c3f 2f04          	jrslt	L5542
5369  0c41 72160005      	bset	_flags,#3
5370  0c45               L5542:
5371                     ; 1155 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5373  0c45 9c            	rvf
5374  0c46 ce0014        	ldw	x,_Ui
5375  0c49 c30016        	cpw	x,_Un
5376  0c4c 2e1d          	jrsge	L7542
5378  0c4e 9c            	rvf
5379  0c4f ce0016        	ldw	x,_Un
5380  0c52 72b00014      	subw	x,_Ui
5381  0c56 c30012        	cpw	x,_ee_dU
5382  0c59 2d10          	jrsle	L7542
5384  0c5b c65005        	ld	a,20485
5385  0c5e a504          	bcp	a,#4
5386  0c60 2609          	jrne	L7542
5389  0c62 be6e          	ldw	x,_umin_cnt
5390  0c64 1c0001        	addw	x,#1
5391  0c67 bf6e          	ldw	_umin_cnt,x
5393  0c69 2003          	jra	L1642
5394  0c6b               L7542:
5395                     ; 1156 	else umin_cnt=0;
5397  0c6b 5f            	clrw	x
5398  0c6c bf6e          	ldw	_umin_cnt,x
5399  0c6e               L1642:
5400                     ; 1157 	gran(&umin_cnt,0,10);	
5402  0c6e ae000a        	ldw	x,#10
5403  0c71 89            	pushw	x
5404  0c72 5f            	clrw	x
5405  0c73 89            	pushw	x
5406  0c74 ae006e        	ldw	x,#_umin_cnt
5407  0c77 cd00d5        	call	_gran
5409  0c7a 5b04          	addw	sp,#4
5410                     ; 1158 	if(umin_cnt>=10)flags|=0b00010000;	  
5412  0c7c 9c            	rvf
5413  0c7d be6e          	ldw	x,_umin_cnt
5414  0c7f a3000a        	cpw	x,#10
5415  0c82 2f71          	jrslt	L5642
5418  0c84 72180005      	bset	_flags,#4
5419  0c88 206b          	jra	L5642
5420  0c8a               L7442:
5421                     ; 1160 else if(jp_mode==jp3)
5423  0c8a b654          	ld	a,_jp_mode
5424  0c8c a103          	cp	a,#3
5425  0c8e 2665          	jrne	L5642
5426                     ; 1162 	if(Ui>700)umax_cnt++;
5428  0c90 9c            	rvf
5429  0c91 ce0014        	ldw	x,_Ui
5430  0c94 a302bd        	cpw	x,#701
5431  0c97 2f09          	jrslt	L1742
5434  0c99 be70          	ldw	x,_umax_cnt
5435  0c9b 1c0001        	addw	x,#1
5436  0c9e bf70          	ldw	_umax_cnt,x
5438  0ca0 2003          	jra	L3742
5439  0ca2               L1742:
5440                     ; 1163 	else umax_cnt=0;
5442  0ca2 5f            	clrw	x
5443  0ca3 bf70          	ldw	_umax_cnt,x
5444  0ca5               L3742:
5445                     ; 1164 	gran(&umax_cnt,0,10);
5447  0ca5 ae000a        	ldw	x,#10
5448  0ca8 89            	pushw	x
5449  0ca9 5f            	clrw	x
5450  0caa 89            	pushw	x
5451  0cab ae0070        	ldw	x,#_umax_cnt
5452  0cae cd00d5        	call	_gran
5454  0cb1 5b04          	addw	sp,#4
5455                     ; 1165 	if(umax_cnt>=10)flags|=0b00001000;
5457  0cb3 9c            	rvf
5458  0cb4 be70          	ldw	x,_umax_cnt
5459  0cb6 a3000a        	cpw	x,#10
5460  0cb9 2f04          	jrslt	L5742
5463  0cbb 72160005      	bset	_flags,#3
5464  0cbf               L5742:
5465                     ; 1168 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5467  0cbf 9c            	rvf
5468  0cc0 ce0014        	ldw	x,_Ui
5469  0cc3 a300c8        	cpw	x,#200
5470  0cc6 2e10          	jrsge	L7742
5472  0cc8 c65005        	ld	a,20485
5473  0ccb a504          	bcp	a,#4
5474  0ccd 2609          	jrne	L7742
5477  0ccf be6e          	ldw	x,_umin_cnt
5478  0cd1 1c0001        	addw	x,#1
5479  0cd4 bf6e          	ldw	_umin_cnt,x
5481  0cd6 2003          	jra	L1052
5482  0cd8               L7742:
5483                     ; 1169 	else umin_cnt=0;
5485  0cd8 5f            	clrw	x
5486  0cd9 bf6e          	ldw	_umin_cnt,x
5487  0cdb               L1052:
5488                     ; 1170 	gran(&umin_cnt,0,10);	
5490  0cdb ae000a        	ldw	x,#10
5491  0cde 89            	pushw	x
5492  0cdf 5f            	clrw	x
5493  0ce0 89            	pushw	x
5494  0ce1 ae006e        	ldw	x,#_umin_cnt
5495  0ce4 cd00d5        	call	_gran
5497  0ce7 5b04          	addw	sp,#4
5498                     ; 1171 	if(umin_cnt>=10)flags|=0b00010000;	  
5500  0ce9 9c            	rvf
5501  0cea be6e          	ldw	x,_umin_cnt
5502  0cec a3000a        	cpw	x,#10
5503  0cef 2f04          	jrslt	L5642
5506  0cf1 72180005      	bset	_flags,#4
5507  0cf5               L5642:
5508                     ; 1173 }
5511  0cf5 81            	ret
5537                     ; 1198 void apv_start(void)
5537                     ; 1199 {
5538                     	switch	.text
5539  0cf6               _apv_start:
5543                     ; 1200 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5545  0cf6 3d4f          	tnz	_apv_cnt
5546  0cf8 2624          	jrne	L5152
5548  0cfa 3d50          	tnz	_apv_cnt+1
5549  0cfc 2620          	jrne	L5152
5551  0cfe 3d51          	tnz	_apv_cnt+2
5552  0d00 261c          	jrne	L5152
5554                     	btst	_bAPV
5555  0d07 2515          	jrult	L5152
5556                     ; 1202 	apv_cnt[0]=60;
5558  0d09 353c004f      	mov	_apv_cnt,#60
5559                     ; 1203 	apv_cnt[1]=60;
5561  0d0d 353c0050      	mov	_apv_cnt+1,#60
5562                     ; 1204 	apv_cnt[2]=60;
5564  0d11 353c0051      	mov	_apv_cnt+2,#60
5565                     ; 1205 	apv_cnt_=3600;
5567  0d15 ae0e10        	ldw	x,#3600
5568  0d18 bf4d          	ldw	_apv_cnt_,x
5569                     ; 1206 	bAPV=1;	
5571  0d1a 72100002      	bset	_bAPV
5572  0d1e               L5152:
5573                     ; 1208 }
5576  0d1e 81            	ret
5602                     ; 1211 void apv_stop(void)
5602                     ; 1212 {
5603                     	switch	.text
5604  0d1f               _apv_stop:
5608                     ; 1213 apv_cnt[0]=0;
5610  0d1f 3f4f          	clr	_apv_cnt
5611                     ; 1214 apv_cnt[1]=0;
5613  0d21 3f50          	clr	_apv_cnt+1
5614                     ; 1215 apv_cnt[2]=0;
5616  0d23 3f51          	clr	_apv_cnt+2
5617                     ; 1216 apv_cnt_=0;	
5619  0d25 5f            	clrw	x
5620  0d26 bf4d          	ldw	_apv_cnt_,x
5621                     ; 1217 bAPV=0;
5623  0d28 72110002      	bres	_bAPV
5624                     ; 1218 }
5627  0d2c 81            	ret
5662                     ; 1222 void apv_hndl(void)
5662                     ; 1223 {
5663                     	switch	.text
5664  0d2d               _apv_hndl:
5668                     ; 1224 if(apv_cnt[0])
5670  0d2d 3d4f          	tnz	_apv_cnt
5671  0d2f 271e          	jreq	L7352
5672                     ; 1226 	apv_cnt[0]--;
5674  0d31 3a4f          	dec	_apv_cnt
5675                     ; 1227 	if(apv_cnt[0]==0)
5677  0d33 3d4f          	tnz	_apv_cnt
5678  0d35 265a          	jrne	L3452
5679                     ; 1229 		flags&=0b11100001;
5681  0d37 b605          	ld	a,_flags
5682  0d39 a4e1          	and	a,#225
5683  0d3b b705          	ld	_flags,a
5684                     ; 1230 		tsign_cnt=0;
5686  0d3d 5f            	clrw	x
5687  0d3e bf59          	ldw	_tsign_cnt,x
5688                     ; 1231 		tmax_cnt=0;
5690  0d40 5f            	clrw	x
5691  0d41 bf57          	ldw	_tmax_cnt,x
5692                     ; 1232 		umax_cnt=0;
5694  0d43 5f            	clrw	x
5695  0d44 bf70          	ldw	_umax_cnt,x
5696                     ; 1233 		umin_cnt=0;
5698  0d46 5f            	clrw	x
5699  0d47 bf6e          	ldw	_umin_cnt,x
5700                     ; 1235 		led_drv_cnt=30;
5702  0d49 351e0016      	mov	_led_drv_cnt,#30
5703  0d4d 2042          	jra	L3452
5704  0d4f               L7352:
5705                     ; 1238 else if(apv_cnt[1])
5707  0d4f 3d50          	tnz	_apv_cnt+1
5708  0d51 271e          	jreq	L5452
5709                     ; 1240 	apv_cnt[1]--;
5711  0d53 3a50          	dec	_apv_cnt+1
5712                     ; 1241 	if(apv_cnt[1]==0)
5714  0d55 3d50          	tnz	_apv_cnt+1
5715  0d57 2638          	jrne	L3452
5716                     ; 1243 		flags&=0b11100001;
5718  0d59 b605          	ld	a,_flags
5719  0d5b a4e1          	and	a,#225
5720  0d5d b705          	ld	_flags,a
5721                     ; 1244 		tsign_cnt=0;
5723  0d5f 5f            	clrw	x
5724  0d60 bf59          	ldw	_tsign_cnt,x
5725                     ; 1245 		tmax_cnt=0;
5727  0d62 5f            	clrw	x
5728  0d63 bf57          	ldw	_tmax_cnt,x
5729                     ; 1246 		umax_cnt=0;
5731  0d65 5f            	clrw	x
5732  0d66 bf70          	ldw	_umax_cnt,x
5733                     ; 1247 		umin_cnt=0;
5735  0d68 5f            	clrw	x
5736  0d69 bf6e          	ldw	_umin_cnt,x
5737                     ; 1249 		led_drv_cnt=30;
5739  0d6b 351e0016      	mov	_led_drv_cnt,#30
5740  0d6f 2020          	jra	L3452
5741  0d71               L5452:
5742                     ; 1252 else if(apv_cnt[2])
5744  0d71 3d51          	tnz	_apv_cnt+2
5745  0d73 271c          	jreq	L3452
5746                     ; 1254 	apv_cnt[2]--;
5748  0d75 3a51          	dec	_apv_cnt+2
5749                     ; 1255 	if(apv_cnt[2]==0)
5751  0d77 3d51          	tnz	_apv_cnt+2
5752  0d79 2616          	jrne	L3452
5753                     ; 1257 		flags&=0b11100001;
5755  0d7b b605          	ld	a,_flags
5756  0d7d a4e1          	and	a,#225
5757  0d7f b705          	ld	_flags,a
5758                     ; 1258 		tsign_cnt=0;
5760  0d81 5f            	clrw	x
5761  0d82 bf59          	ldw	_tsign_cnt,x
5762                     ; 1259 		tmax_cnt=0;
5764  0d84 5f            	clrw	x
5765  0d85 bf57          	ldw	_tmax_cnt,x
5766                     ; 1260 		umax_cnt=0;
5768  0d87 5f            	clrw	x
5769  0d88 bf70          	ldw	_umax_cnt,x
5770                     ; 1261 		umin_cnt=0;          
5772  0d8a 5f            	clrw	x
5773  0d8b bf6e          	ldw	_umin_cnt,x
5774                     ; 1263 		led_drv_cnt=30;
5776  0d8d 351e0016      	mov	_led_drv_cnt,#30
5777  0d91               L3452:
5778                     ; 1267 if(apv_cnt_)
5780  0d91 be4d          	ldw	x,_apv_cnt_
5781  0d93 2712          	jreq	L7552
5782                     ; 1269 	apv_cnt_--;
5784  0d95 be4d          	ldw	x,_apv_cnt_
5785  0d97 1d0001        	subw	x,#1
5786  0d9a bf4d          	ldw	_apv_cnt_,x
5787                     ; 1270 	if(apv_cnt_==0) 
5789  0d9c be4d          	ldw	x,_apv_cnt_
5790  0d9e 2607          	jrne	L7552
5791                     ; 1272 		bAPV=0;
5793  0da0 72110002      	bres	_bAPV
5794                     ; 1273 		apv_start();
5796  0da4 cd0cf6        	call	_apv_start
5798  0da7               L7552:
5799                     ; 1277 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5801  0da7 be6e          	ldw	x,_umin_cnt
5802  0da9 261e          	jrne	L3652
5804  0dab be70          	ldw	x,_umax_cnt
5805  0dad 261a          	jrne	L3652
5807  0daf c65005        	ld	a,20485
5808  0db2 a504          	bcp	a,#4
5809  0db4 2613          	jrne	L3652
5810                     ; 1279 	if(cnt_apv_off<20)
5812  0db6 b64c          	ld	a,_cnt_apv_off
5813  0db8 a114          	cp	a,#20
5814  0dba 240f          	jruge	L1752
5815                     ; 1281 		cnt_apv_off++;
5817  0dbc 3c4c          	inc	_cnt_apv_off
5818                     ; 1282 		if(cnt_apv_off>=20)
5820  0dbe b64c          	ld	a,_cnt_apv_off
5821  0dc0 a114          	cp	a,#20
5822  0dc2 2507          	jrult	L1752
5823                     ; 1284 			apv_stop();
5825  0dc4 cd0d1f        	call	_apv_stop
5827  0dc7 2002          	jra	L1752
5828  0dc9               L3652:
5829                     ; 1288 else cnt_apv_off=0;	
5831  0dc9 3f4c          	clr	_cnt_apv_off
5832  0dcb               L1752:
5833                     ; 1290 }
5836  0dcb 81            	ret
5839                     	switch	.ubsct
5840  0000               L3752_flags_old:
5841  0000 00            	ds.b	1
5877                     ; 1293 void flags_drv(void)
5877                     ; 1294 {
5878                     	switch	.text
5879  0dcc               _flags_drv:
5883                     ; 1296 if(jp_mode!=jp3) 
5885  0dcc b654          	ld	a,_jp_mode
5886  0dce a103          	cp	a,#3
5887  0dd0 2723          	jreq	L3162
5888                     ; 1298 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5890  0dd2 b605          	ld	a,_flags
5891  0dd4 a508          	bcp	a,#8
5892  0dd6 2706          	jreq	L1262
5894  0dd8 b600          	ld	a,L3752_flags_old
5895  0dda a508          	bcp	a,#8
5896  0ddc 270c          	jreq	L7162
5897  0dde               L1262:
5899  0dde b605          	ld	a,_flags
5900  0de0 a510          	bcp	a,#16
5901  0de2 2726          	jreq	L5262
5903  0de4 b600          	ld	a,L3752_flags_old
5904  0de6 a510          	bcp	a,#16
5905  0de8 2620          	jrne	L5262
5906  0dea               L7162:
5907                     ; 1300     		if(link==OFF)apv_start();
5909  0dea b66d          	ld	a,_link
5910  0dec a1aa          	cp	a,#170
5911  0dee 261a          	jrne	L5262
5914  0df0 cd0cf6        	call	_apv_start
5916  0df3 2015          	jra	L5262
5917  0df5               L3162:
5918                     ; 1303 else if(jp_mode==jp3) 
5920  0df5 b654          	ld	a,_jp_mode
5921  0df7 a103          	cp	a,#3
5922  0df9 260f          	jrne	L5262
5923                     ; 1305 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5925  0dfb b605          	ld	a,_flags
5926  0dfd a508          	bcp	a,#8
5927  0dff 2709          	jreq	L5262
5929  0e01 b600          	ld	a,L3752_flags_old
5930  0e03 a508          	bcp	a,#8
5931  0e05 2603          	jrne	L5262
5932                     ; 1307     		apv_start();
5934  0e07 cd0cf6        	call	_apv_start
5936  0e0a               L5262:
5937                     ; 1310 flags_old=flags;
5939  0e0a 450500        	mov	L3752_flags_old,_flags
5940                     ; 1312 } 
5943  0e0d 81            	ret
5978                     ; 1449 void adr_drv_v4(char in)
5978                     ; 1450 {
5979                     	switch	.text
5980  0e0e               _adr_drv_v4:
5984                     ; 1451 if(adress!=in)adress=in;
5986  0e0e c100ff        	cp	a,_adress
5987  0e11 2703          	jreq	L1562
5990  0e13 c700ff        	ld	_adress,a
5991  0e16               L1562:
5992                     ; 1452 }
5995  0e16 81            	ret
6024                     ; 1455 void adr_drv_v3(void)
6024                     ; 1456 {
6025                     	switch	.text
6026  0e17               _adr_drv_v3:
6028  0e17 88            	push	a
6029       00000001      OFST:	set	1
6032                     ; 1462 GPIOB->DDR&=~(1<<0);
6034  0e18 72115007      	bres	20487,#0
6035                     ; 1463 GPIOB->CR1&=~(1<<0);
6037  0e1c 72115008      	bres	20488,#0
6038                     ; 1464 GPIOB->CR2&=~(1<<0);
6040  0e20 72115009      	bres	20489,#0
6041                     ; 1465 ADC2->CR2=0x08;
6043  0e24 35085402      	mov	21506,#8
6044                     ; 1466 ADC2->CR1=0x40;
6046  0e28 35405401      	mov	21505,#64
6047                     ; 1467 ADC2->CSR=0x20+0;
6049  0e2c 35205400      	mov	21504,#32
6050                     ; 1468 ADC2->CR1|=1;
6052  0e30 72105401      	bset	21505,#0
6053                     ; 1469 ADC2->CR1|=1;
6055  0e34 72105401      	bset	21505,#0
6056                     ; 1470 adr_drv_stat=1;
6058  0e38 35010002      	mov	_adr_drv_stat,#1
6059  0e3c               L3662:
6060                     ; 1471 while(adr_drv_stat==1);
6063  0e3c b602          	ld	a,_adr_drv_stat
6064  0e3e a101          	cp	a,#1
6065  0e40 27fa          	jreq	L3662
6066                     ; 1473 GPIOB->DDR&=~(1<<1);
6068  0e42 72135007      	bres	20487,#1
6069                     ; 1474 GPIOB->CR1&=~(1<<1);
6071  0e46 72135008      	bres	20488,#1
6072                     ; 1475 GPIOB->CR2&=~(1<<1);
6074  0e4a 72135009      	bres	20489,#1
6075                     ; 1476 ADC2->CR2=0x08;
6077  0e4e 35085402      	mov	21506,#8
6078                     ; 1477 ADC2->CR1=0x40;
6080  0e52 35405401      	mov	21505,#64
6081                     ; 1478 ADC2->CSR=0x20+1;
6083  0e56 35215400      	mov	21504,#33
6084                     ; 1479 ADC2->CR1|=1;
6086  0e5a 72105401      	bset	21505,#0
6087                     ; 1480 ADC2->CR1|=1;
6089  0e5e 72105401      	bset	21505,#0
6090                     ; 1481 adr_drv_stat=3;
6092  0e62 35030002      	mov	_adr_drv_stat,#3
6093  0e66               L1762:
6094                     ; 1482 while(adr_drv_stat==3);
6097  0e66 b602          	ld	a,_adr_drv_stat
6098  0e68 a103          	cp	a,#3
6099  0e6a 27fa          	jreq	L1762
6100                     ; 1484 GPIOE->DDR&=~(1<<6);
6102  0e6c 721d5016      	bres	20502,#6
6103                     ; 1485 GPIOE->CR1&=~(1<<6);
6105  0e70 721d5017      	bres	20503,#6
6106                     ; 1486 GPIOE->CR2&=~(1<<6);
6108  0e74 721d5018      	bres	20504,#6
6109                     ; 1487 ADC2->CR2=0x08;
6111  0e78 35085402      	mov	21506,#8
6112                     ; 1488 ADC2->CR1=0x40;
6114  0e7c 35405401      	mov	21505,#64
6115                     ; 1489 ADC2->CSR=0x20+9;
6117  0e80 35295400      	mov	21504,#41
6118                     ; 1490 ADC2->CR1|=1;
6120  0e84 72105401      	bset	21505,#0
6121                     ; 1491 ADC2->CR1|=1;
6123  0e88 72105401      	bset	21505,#0
6124                     ; 1492 adr_drv_stat=5;
6126  0e8c 35050002      	mov	_adr_drv_stat,#5
6127  0e90               L7762:
6128                     ; 1493 while(adr_drv_stat==5);
6131  0e90 b602          	ld	a,_adr_drv_stat
6132  0e92 a105          	cp	a,#5
6133  0e94 27fa          	jreq	L7762
6134                     ; 1497 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6136  0e96 9c            	rvf
6137  0e97 ce0107        	ldw	x,_adc_buff_
6138  0e9a a3022a        	cpw	x,#554
6139  0e9d 2f0f          	jrslt	L5072
6141  0e9f 9c            	rvf
6142  0ea0 ce0107        	ldw	x,_adc_buff_
6143  0ea3 a30253        	cpw	x,#595
6144  0ea6 2e06          	jrsge	L5072
6147  0ea8 725f0100      	clr	_adr
6149  0eac 204c          	jra	L7072
6150  0eae               L5072:
6151                     ; 1498 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6153  0eae 9c            	rvf
6154  0eaf ce0107        	ldw	x,_adc_buff_
6155  0eb2 a3036d        	cpw	x,#877
6156  0eb5 2f0f          	jrslt	L1172
6158  0eb7 9c            	rvf
6159  0eb8 ce0107        	ldw	x,_adc_buff_
6160  0ebb a30396        	cpw	x,#918
6161  0ebe 2e06          	jrsge	L1172
6164  0ec0 35010100      	mov	_adr,#1
6166  0ec4 2034          	jra	L7072
6167  0ec6               L1172:
6168                     ; 1499 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6170  0ec6 9c            	rvf
6171  0ec7 ce0107        	ldw	x,_adc_buff_
6172  0eca a302a3        	cpw	x,#675
6173  0ecd 2f0f          	jrslt	L5172
6175  0ecf 9c            	rvf
6176  0ed0 ce0107        	ldw	x,_adc_buff_
6177  0ed3 a302cc        	cpw	x,#716
6178  0ed6 2e06          	jrsge	L5172
6181  0ed8 35020100      	mov	_adr,#2
6183  0edc 201c          	jra	L7072
6184  0ede               L5172:
6185                     ; 1500 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6187  0ede 9c            	rvf
6188  0edf ce0107        	ldw	x,_adc_buff_
6189  0ee2 a303e3        	cpw	x,#995
6190  0ee5 2f0f          	jrslt	L1272
6192  0ee7 9c            	rvf
6193  0ee8 ce0107        	ldw	x,_adc_buff_
6194  0eeb a3040c        	cpw	x,#1036
6195  0eee 2e06          	jrsge	L1272
6198  0ef0 35030100      	mov	_adr,#3
6200  0ef4 2004          	jra	L7072
6201  0ef6               L1272:
6202                     ; 1501 else adr[0]=5;
6204  0ef6 35050100      	mov	_adr,#5
6205  0efa               L7072:
6206                     ; 1503 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6208  0efa 9c            	rvf
6209  0efb ce0109        	ldw	x,_adc_buff_+2
6210  0efe a3022a        	cpw	x,#554
6211  0f01 2f0f          	jrslt	L5272
6213  0f03 9c            	rvf
6214  0f04 ce0109        	ldw	x,_adc_buff_+2
6215  0f07 a30253        	cpw	x,#595
6216  0f0a 2e06          	jrsge	L5272
6219  0f0c 725f0101      	clr	_adr+1
6221  0f10 204c          	jra	L7272
6222  0f12               L5272:
6223                     ; 1504 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6225  0f12 9c            	rvf
6226  0f13 ce0109        	ldw	x,_adc_buff_+2
6227  0f16 a3036d        	cpw	x,#877
6228  0f19 2f0f          	jrslt	L1372
6230  0f1b 9c            	rvf
6231  0f1c ce0109        	ldw	x,_adc_buff_+2
6232  0f1f a30396        	cpw	x,#918
6233  0f22 2e06          	jrsge	L1372
6236  0f24 35010101      	mov	_adr+1,#1
6238  0f28 2034          	jra	L7272
6239  0f2a               L1372:
6240                     ; 1505 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6242  0f2a 9c            	rvf
6243  0f2b ce0109        	ldw	x,_adc_buff_+2
6244  0f2e a302a3        	cpw	x,#675
6245  0f31 2f0f          	jrslt	L5372
6247  0f33 9c            	rvf
6248  0f34 ce0109        	ldw	x,_adc_buff_+2
6249  0f37 a302cc        	cpw	x,#716
6250  0f3a 2e06          	jrsge	L5372
6253  0f3c 35020101      	mov	_adr+1,#2
6255  0f40 201c          	jra	L7272
6256  0f42               L5372:
6257                     ; 1506 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6259  0f42 9c            	rvf
6260  0f43 ce0109        	ldw	x,_adc_buff_+2
6261  0f46 a303e3        	cpw	x,#995
6262  0f49 2f0f          	jrslt	L1472
6264  0f4b 9c            	rvf
6265  0f4c ce0109        	ldw	x,_adc_buff_+2
6266  0f4f a3040c        	cpw	x,#1036
6267  0f52 2e06          	jrsge	L1472
6270  0f54 35030101      	mov	_adr+1,#3
6272  0f58 2004          	jra	L7272
6273  0f5a               L1472:
6274                     ; 1507 else adr[1]=5;
6276  0f5a 35050101      	mov	_adr+1,#5
6277  0f5e               L7272:
6278                     ; 1509 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6280  0f5e 9c            	rvf
6281  0f5f ce0119        	ldw	x,_adc_buff_+18
6282  0f62 a3022a        	cpw	x,#554
6283  0f65 2f0f          	jrslt	L5472
6285  0f67 9c            	rvf
6286  0f68 ce0119        	ldw	x,_adc_buff_+18
6287  0f6b a30253        	cpw	x,#595
6288  0f6e 2e06          	jrsge	L5472
6291  0f70 725f0102      	clr	_adr+2
6293  0f74 204c          	jra	L7472
6294  0f76               L5472:
6295                     ; 1510 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6297  0f76 9c            	rvf
6298  0f77 ce0119        	ldw	x,_adc_buff_+18
6299  0f7a a3036d        	cpw	x,#877
6300  0f7d 2f0f          	jrslt	L1572
6302  0f7f 9c            	rvf
6303  0f80 ce0119        	ldw	x,_adc_buff_+18
6304  0f83 a30396        	cpw	x,#918
6305  0f86 2e06          	jrsge	L1572
6308  0f88 35010102      	mov	_adr+2,#1
6310  0f8c 2034          	jra	L7472
6311  0f8e               L1572:
6312                     ; 1511 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6314  0f8e 9c            	rvf
6315  0f8f ce0119        	ldw	x,_adc_buff_+18
6316  0f92 a302a3        	cpw	x,#675
6317  0f95 2f0f          	jrslt	L5572
6319  0f97 9c            	rvf
6320  0f98 ce0119        	ldw	x,_adc_buff_+18
6321  0f9b a302cc        	cpw	x,#716
6322  0f9e 2e06          	jrsge	L5572
6325  0fa0 35020102      	mov	_adr+2,#2
6327  0fa4 201c          	jra	L7472
6328  0fa6               L5572:
6329                     ; 1512 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6331  0fa6 9c            	rvf
6332  0fa7 ce0119        	ldw	x,_adc_buff_+18
6333  0faa a303e3        	cpw	x,#995
6334  0fad 2f0f          	jrslt	L1672
6336  0faf 9c            	rvf
6337  0fb0 ce0119        	ldw	x,_adc_buff_+18
6338  0fb3 a3040c        	cpw	x,#1036
6339  0fb6 2e06          	jrsge	L1672
6342  0fb8 35030102      	mov	_adr+2,#3
6344  0fbc 2004          	jra	L7472
6345  0fbe               L1672:
6346                     ; 1513 else adr[2]=5;
6348  0fbe 35050102      	mov	_adr+2,#5
6349  0fc2               L7472:
6350                     ; 1517 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6352  0fc2 c60100        	ld	a,_adr
6353  0fc5 a105          	cp	a,#5
6354  0fc7 270e          	jreq	L7672
6356  0fc9 c60101        	ld	a,_adr+1
6357  0fcc a105          	cp	a,#5
6358  0fce 2707          	jreq	L7672
6360  0fd0 c60102        	ld	a,_adr+2
6361  0fd3 a105          	cp	a,#5
6362  0fd5 2606          	jrne	L5672
6363  0fd7               L7672:
6364                     ; 1520 	adress_error=1;
6366  0fd7 350100fe      	mov	_adress_error,#1
6368  0fdb               L3772:
6369                     ; 1531 }
6372  0fdb 84            	pop	a
6373  0fdc 81            	ret
6374  0fdd               L5672:
6375                     ; 1524 	if(adr[2]&0x02) bps_class=bpsIPS;
6377  0fdd c60102        	ld	a,_adr+2
6378  0fe0 a502          	bcp	a,#2
6379  0fe2 2706          	jreq	L5772
6382  0fe4 3501000b      	mov	_bps_class,#1
6384  0fe8 2002          	jra	L7772
6385  0fea               L5772:
6386                     ; 1525 	else bps_class=bpsIBEP;
6388  0fea 3f0b          	clr	_bps_class
6389  0fec               L7772:
6390                     ; 1527 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6392  0fec c60102        	ld	a,_adr+2
6393  0fef a401          	and	a,#1
6394  0ff1 97            	ld	xl,a
6395  0ff2 a610          	ld	a,#16
6396  0ff4 42            	mul	x,a
6397  0ff5 9f            	ld	a,xl
6398  0ff6 6b01          	ld	(OFST+0,sp),a
6399  0ff8 c60101        	ld	a,_adr+1
6400  0ffb 48            	sll	a
6401  0ffc 48            	sll	a
6402  0ffd cb0100        	add	a,_adr
6403  1000 1b01          	add	a,(OFST+0,sp)
6404  1002 c700ff        	ld	_adress,a
6405  1005 20d4          	jra	L3772
6428                     ; 1581 void init_CAN(void) {
6429                     	switch	.text
6430  1007               _init_CAN:
6434                     ; 1582 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6436  1007 72135420      	bres	21536,#1
6437                     ; 1583 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6439  100b 72105420      	bset	21536,#0
6441  100f               L3103:
6442                     ; 1584 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6444  100f c65421        	ld	a,21537
6445  1012 a501          	bcp	a,#1
6446  1014 27f9          	jreq	L3103
6447                     ; 1586 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6449  1016 72185420      	bset	21536,#4
6450                     ; 1588 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6452  101a 35025427      	mov	21543,#2
6453                     ; 1597 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6455  101e 35135428      	mov	21544,#19
6456                     ; 1598 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6458  1022 35c05429      	mov	21545,#192
6459                     ; 1599 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6461  1026 357f542c      	mov	21548,#127
6462                     ; 1600 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6464  102a 35e0542d      	mov	21549,#224
6465                     ; 1602 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6467  102e 35315430      	mov	21552,#49
6468                     ; 1603 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6470  1032 35c05431      	mov	21553,#192
6471                     ; 1604 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6473  1036 357f5434      	mov	21556,#127
6474                     ; 1605 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6476  103a 35e05435      	mov	21557,#224
6477                     ; 1609 	CAN->PSR= 6;									// set page 6
6479  103e 35065427      	mov	21543,#6
6480                     ; 1614 	CAN->Page.Config.FMR1&=~3;								//mask mode
6482  1042 c65430        	ld	a,21552
6483  1045 a4fc          	and	a,#252
6484  1047 c75430        	ld	21552,a
6485                     ; 1620 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6487  104a 35065432      	mov	21554,#6
6488                     ; 1621 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6490  104e 35605432      	mov	21554,#96
6491                     ; 1624 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6493  1052 72105432      	bset	21554,#0
6494                     ; 1625 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6496  1056 72185432      	bset	21554,#4
6497                     ; 1628 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6499  105a 35065427      	mov	21543,#6
6500                     ; 1630 	CAN->Page.Config.BTR1= (3<<6)|19;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6502  105e 35d3542c      	mov	21548,#211
6503                     ; 1631 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6505  1062 35e7542d      	mov	21549,#231
6506                     ; 1633 	CAN->IER|=(1<<1);
6508  1066 72125425      	bset	21541,#1
6509                     ; 1636 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6511  106a 72115420      	bres	21536,#0
6513  106e               L1203:
6514                     ; 1637 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6516  106e c65421        	ld	a,21537
6517  1071 a501          	bcp	a,#1
6518  1073 26f9          	jrne	L1203
6519                     ; 1638 }
6522  1075 81            	ret
6630                     ; 1641 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6630                     ; 1642 {
6631                     	switch	.text
6632  1076               _can_transmit:
6634  1076 89            	pushw	x
6635       00000000      OFST:	set	0
6638                     ; 1644 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6640  1077 b676          	ld	a,_can_buff_wr_ptr
6641  1079 a104          	cp	a,#4
6642  107b 2502          	jrult	L3013
6645  107d 3f76          	clr	_can_buff_wr_ptr
6646  107f               L3013:
6647                     ; 1646 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6649  107f b676          	ld	a,_can_buff_wr_ptr
6650  1081 97            	ld	xl,a
6651  1082 a610          	ld	a,#16
6652  1084 42            	mul	x,a
6653  1085 1601          	ldw	y,(OFST+1,sp)
6654  1087 a606          	ld	a,#6
6655  1089               L431:
6656  1089 9054          	srlw	y
6657  108b 4a            	dec	a
6658  108c 26fb          	jrne	L431
6659  108e 909f          	ld	a,yl
6660  1090 e777          	ld	(_can_out_buff,x),a
6661                     ; 1647 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6663  1092 b676          	ld	a,_can_buff_wr_ptr
6664  1094 97            	ld	xl,a
6665  1095 a610          	ld	a,#16
6666  1097 42            	mul	x,a
6667  1098 7b02          	ld	a,(OFST+2,sp)
6668  109a 48            	sll	a
6669  109b 48            	sll	a
6670  109c e778          	ld	(_can_out_buff+1,x),a
6671                     ; 1649 can_out_buff[can_buff_wr_ptr][2]=data0;
6673  109e b676          	ld	a,_can_buff_wr_ptr
6674  10a0 97            	ld	xl,a
6675  10a1 a610          	ld	a,#16
6676  10a3 42            	mul	x,a
6677  10a4 7b05          	ld	a,(OFST+5,sp)
6678  10a6 e779          	ld	(_can_out_buff+2,x),a
6679                     ; 1650 can_out_buff[can_buff_wr_ptr][3]=data1;
6681  10a8 b676          	ld	a,_can_buff_wr_ptr
6682  10aa 97            	ld	xl,a
6683  10ab a610          	ld	a,#16
6684  10ad 42            	mul	x,a
6685  10ae 7b06          	ld	a,(OFST+6,sp)
6686  10b0 e77a          	ld	(_can_out_buff+3,x),a
6687                     ; 1651 can_out_buff[can_buff_wr_ptr][4]=data2;
6689  10b2 b676          	ld	a,_can_buff_wr_ptr
6690  10b4 97            	ld	xl,a
6691  10b5 a610          	ld	a,#16
6692  10b7 42            	mul	x,a
6693  10b8 7b07          	ld	a,(OFST+7,sp)
6694  10ba e77b          	ld	(_can_out_buff+4,x),a
6695                     ; 1652 can_out_buff[can_buff_wr_ptr][5]=data3;
6697  10bc b676          	ld	a,_can_buff_wr_ptr
6698  10be 97            	ld	xl,a
6699  10bf a610          	ld	a,#16
6700  10c1 42            	mul	x,a
6701  10c2 7b08          	ld	a,(OFST+8,sp)
6702  10c4 e77c          	ld	(_can_out_buff+5,x),a
6703                     ; 1653 can_out_buff[can_buff_wr_ptr][6]=data4;
6705  10c6 b676          	ld	a,_can_buff_wr_ptr
6706  10c8 97            	ld	xl,a
6707  10c9 a610          	ld	a,#16
6708  10cb 42            	mul	x,a
6709  10cc 7b09          	ld	a,(OFST+9,sp)
6710  10ce e77d          	ld	(_can_out_buff+6,x),a
6711                     ; 1654 can_out_buff[can_buff_wr_ptr][7]=data5;
6713  10d0 b676          	ld	a,_can_buff_wr_ptr
6714  10d2 97            	ld	xl,a
6715  10d3 a610          	ld	a,#16
6716  10d5 42            	mul	x,a
6717  10d6 7b0a          	ld	a,(OFST+10,sp)
6718  10d8 e77e          	ld	(_can_out_buff+7,x),a
6719                     ; 1655 can_out_buff[can_buff_wr_ptr][8]=data6;
6721  10da b676          	ld	a,_can_buff_wr_ptr
6722  10dc 97            	ld	xl,a
6723  10dd a610          	ld	a,#16
6724  10df 42            	mul	x,a
6725  10e0 7b0b          	ld	a,(OFST+11,sp)
6726  10e2 e77f          	ld	(_can_out_buff+8,x),a
6727                     ; 1656 can_out_buff[can_buff_wr_ptr][9]=data7;
6729  10e4 b676          	ld	a,_can_buff_wr_ptr
6730  10e6 97            	ld	xl,a
6731  10e7 a610          	ld	a,#16
6732  10e9 42            	mul	x,a
6733  10ea 7b0c          	ld	a,(OFST+12,sp)
6734  10ec e780          	ld	(_can_out_buff+9,x),a
6735                     ; 1658 can_buff_wr_ptr++;
6737  10ee 3c76          	inc	_can_buff_wr_ptr
6738                     ; 1659 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6740  10f0 b676          	ld	a,_can_buff_wr_ptr
6741  10f2 a104          	cp	a,#4
6742  10f4 2502          	jrult	L5013
6745  10f6 3f76          	clr	_can_buff_wr_ptr
6746  10f8               L5013:
6747                     ; 1660 } 
6750  10f8 85            	popw	x
6751  10f9 81            	ret
6780                     ; 1663 void can_tx_hndl(void)
6780                     ; 1664 {
6781                     	switch	.text
6782  10fa               _can_tx_hndl:
6786                     ; 1665 if(bTX_FREE)
6788  10fa 3d03          	tnz	_bTX_FREE
6789  10fc 2757          	jreq	L7113
6790                     ; 1667 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6792  10fe b675          	ld	a,_can_buff_rd_ptr
6793  1100 b176          	cp	a,_can_buff_wr_ptr
6794  1102 275f          	jreq	L5213
6795                     ; 1669 		bTX_FREE=0;
6797  1104 3f03          	clr	_bTX_FREE
6798                     ; 1671 		CAN->PSR= 0;
6800  1106 725f5427      	clr	21543
6801                     ; 1672 		CAN->Page.TxMailbox.MDLCR=8;
6803  110a 35085429      	mov	21545,#8
6804                     ; 1673 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6806  110e b675          	ld	a,_can_buff_rd_ptr
6807  1110 97            	ld	xl,a
6808  1111 a610          	ld	a,#16
6809  1113 42            	mul	x,a
6810  1114 e677          	ld	a,(_can_out_buff,x)
6811  1116 c7542a        	ld	21546,a
6812                     ; 1674 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6814  1119 b675          	ld	a,_can_buff_rd_ptr
6815  111b 97            	ld	xl,a
6816  111c a610          	ld	a,#16
6817  111e 42            	mul	x,a
6818  111f e678          	ld	a,(_can_out_buff+1,x)
6819  1121 c7542b        	ld	21547,a
6820                     ; 1676 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6822  1124 b675          	ld	a,_can_buff_rd_ptr
6823  1126 97            	ld	xl,a
6824  1127 a610          	ld	a,#16
6825  1129 42            	mul	x,a
6826  112a 01            	rrwa	x,a
6827  112b ab79          	add	a,#_can_out_buff+2
6828  112d 2401          	jrnc	L041
6829  112f 5c            	incw	x
6830  1130               L041:
6831  1130 5f            	clrw	x
6832  1131 97            	ld	xl,a
6833  1132 bf00          	ldw	c_x,x
6834  1134 ae0008        	ldw	x,#8
6835  1137               L241:
6836  1137 5a            	decw	x
6837  1138 92d600        	ld	a,([c_x],x)
6838  113b d7542e        	ld	(21550,x),a
6839  113e 5d            	tnzw	x
6840  113f 26f6          	jrne	L241
6841                     ; 1678 		can_buff_rd_ptr++;
6843  1141 3c75          	inc	_can_buff_rd_ptr
6844                     ; 1679 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6846  1143 b675          	ld	a,_can_buff_rd_ptr
6847  1145 a104          	cp	a,#4
6848  1147 2502          	jrult	L3213
6851  1149 3f75          	clr	_can_buff_rd_ptr
6852  114b               L3213:
6853                     ; 1681 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6855  114b 72105428      	bset	21544,#0
6856                     ; 1682 		CAN->IER|=(1<<0);
6858  114f 72105425      	bset	21541,#0
6859  1153 200e          	jra	L5213
6860  1155               L7113:
6861                     ; 1687 	tx_busy_cnt++;
6863  1155 3c74          	inc	_tx_busy_cnt
6864                     ; 1688 	if(tx_busy_cnt>=100)
6866  1157 b674          	ld	a,_tx_busy_cnt
6867  1159 a164          	cp	a,#100
6868  115b 2506          	jrult	L5213
6869                     ; 1690 		tx_busy_cnt=0;
6871  115d 3f74          	clr	_tx_busy_cnt
6872                     ; 1691 		bTX_FREE=1;
6874  115f 35010003      	mov	_bTX_FREE,#1
6875  1163               L5213:
6876                     ; 1694 }
6879  1163 81            	ret
6994                     ; 1720 void can_in_an(void)
6994                     ; 1721 {
6995                     	switch	.text
6996  1164               _can_in_an:
6998  1164 5207          	subw	sp,#7
6999       00000007      OFST:	set	7
7002                     ; 1731 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7004  1166 b6cd          	ld	a,_mess+6
7005  1168 c100ff        	cp	a,_adress
7006  116b 2703          	jreq	L261
7007  116d cc12a5        	jp	L5613
7008  1170               L261:
7010  1170 b6ce          	ld	a,_mess+7
7011  1172 c100ff        	cp	a,_adress
7012  1175 2703          	jreq	L461
7013  1177 cc12a5        	jp	L5613
7014  117a               L461:
7016  117a b6cf          	ld	a,_mess+8
7017  117c a1ed          	cp	a,#237
7018  117e 2703          	jreq	L661
7019  1180 cc12a5        	jp	L5613
7020  1183               L661:
7021                     ; 1734 	can_error_cnt=0;
7023  1183 3f73          	clr	_can_error_cnt
7024                     ; 1736 	bMAIN=0;
7026  1185 72110001      	bres	_bMAIN
7027                     ; 1737  	flags_tu=mess[9];
7029  1189 45d06a        	mov	_flags_tu,_mess+9
7030                     ; 1738  	if(flags_tu&0b00000001)
7032  118c b66a          	ld	a,_flags_tu
7033  118e a501          	bcp	a,#1
7034  1190 2706          	jreq	L7613
7035                     ; 1743  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7037  1192 721a0005      	bset	_flags,#5
7039  1196 2008          	jra	L1713
7040  1198               L7613:
7041                     ; 1754  				flags&=0b11011111; 
7043  1198 721b0005      	bres	_flags,#5
7044                     ; 1755  				off_bp_cnt=5*EE_TZAS;
7046  119c 350f005d      	mov	_off_bp_cnt,#15
7047  11a0               L1713:
7048                     ; 1761  	if(flags_tu&0b00000010) flags|=0b01000000;
7050  11a0 b66a          	ld	a,_flags_tu
7051  11a2 a502          	bcp	a,#2
7052  11a4 2706          	jreq	L3713
7055  11a6 721c0005      	bset	_flags,#6
7057  11aa 2004          	jra	L5713
7058  11ac               L3713:
7059                     ; 1762  	else flags&=0b10111111; 
7061  11ac 721d0005      	bres	_flags,#6
7062  11b0               L5713:
7063                     ; 1764  	U_out_const=mess[10]+mess[11]*256;
7065  11b0 b6d2          	ld	a,_mess+11
7066  11b2 5f            	clrw	x
7067  11b3 97            	ld	xl,a
7068  11b4 4f            	clr	a
7069  11b5 02            	rlwa	x,a
7070  11b6 01            	rrwa	x,a
7071  11b7 bbd1          	add	a,_mess+10
7072  11b9 2401          	jrnc	L641
7073  11bb 5c            	incw	x
7074  11bc               L641:
7075  11bc c70011        	ld	_U_out_const+1,a
7076  11bf 9f            	ld	a,xl
7077  11c0 c70010        	ld	_U_out_const,a
7078                     ; 1765  	vol_i_temp=mess[12]+mess[13]*256;  
7080  11c3 b6d4          	ld	a,_mess+13
7081  11c5 5f            	clrw	x
7082  11c6 97            	ld	xl,a
7083  11c7 4f            	clr	a
7084  11c8 02            	rlwa	x,a
7085  11c9 01            	rrwa	x,a
7086  11ca bbd3          	add	a,_mess+12
7087  11cc 2401          	jrnc	L051
7088  11ce 5c            	incw	x
7089  11cf               L051:
7090  11cf b761          	ld	_vol_i_temp+1,a
7091  11d1 9f            	ld	a,xl
7092  11d2 b760          	ld	_vol_i_temp,a
7093                     ; 1775 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
7095  11d4 b608          	ld	a,_vent_resurs_tx_cnt
7096  11d6 a102          	cp	a,#2
7097  11d8 2507          	jrult	L7713
7100  11da ce0000        	ldw	x,_vent_resurs
7101  11dd bf41          	ldw	_plazma_int+4,x
7103  11df 2004          	jra	L1023
7104  11e1               L7713:
7105                     ; 1776 	else plazma_int[2]=vent_resurs_sec_cnt;
7107  11e1 be09          	ldw	x,_vent_resurs_sec_cnt
7108  11e3 bf41          	ldw	_plazma_int+4,x
7109  11e5               L1023:
7110                     ; 1777  	rotor_int=flags_tu+(((short)flags)<<8);
7112  11e5 b605          	ld	a,_flags
7113  11e7 5f            	clrw	x
7114  11e8 97            	ld	xl,a
7115  11e9 4f            	clr	a
7116  11ea 02            	rlwa	x,a
7117  11eb 01            	rrwa	x,a
7118  11ec bb6a          	add	a,_flags_tu
7119  11ee 2401          	jrnc	L251
7120  11f0 5c            	incw	x
7121  11f1               L251:
7122  11f1 b718          	ld	_rotor_int+1,a
7123  11f3 9f            	ld	a,xl
7124  11f4 b717          	ld	_rotor_int,a
7125                     ; 1778 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7127  11f6 3b0014        	push	_Ui
7128  11f9 3b0015        	push	_Ui+1
7129  11fc 3b0016        	push	_Un
7130  11ff 3b0017        	push	_Un+1
7131  1202 3b0018        	push	_I
7132  1205 3b0019        	push	_I+1
7133  1208 4bda          	push	#218
7134  120a 3b00ff        	push	_adress
7135  120d ae018e        	ldw	x,#398
7136  1210 cd1076        	call	_can_transmit
7138  1213 5b08          	addw	sp,#8
7139                     ; 1779 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
7141  1215 3b000e        	push	_Usum
7142  1218 3b000f        	push	_Usum+1
7143  121b 3b0069        	push	__x_+1
7144  121e 3b0005        	push	_flags
7145  1221 b608          	ld	a,_vent_resurs_tx_cnt
7146  1223 5f            	clrw	x
7147  1224 97            	ld	xl,a
7148  1225 d60008        	ld	a,(_vent_resurs_buff,x)
7149  1228 88            	push	a
7150  1229 3b0072        	push	_T
7151  122c 4bdb          	push	#219
7152  122e 3b00ff        	push	_adress
7153  1231 ae018e        	ldw	x,#398
7154  1234 cd1076        	call	_can_transmit
7156  1237 5b08          	addw	sp,#8
7157                     ; 1780 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
7159  1239 3b0005        	push	_debug_info_to_uku+4
7160  123c 3b0006        	push	_debug_info_to_uku+5
7161  123f 3b0003        	push	_debug_info_to_uku+2
7162  1242 3b0004        	push	_debug_info_to_uku+3
7163  1245 3b0001        	push	_debug_info_to_uku
7164  1248 3b0002        	push	_debug_info_to_uku+1
7165  124b 4bdc          	push	#220
7166  124d 3b00ff        	push	_adress
7167  1250 ae018e        	ldw	x,#398
7168  1253 cd1076        	call	_can_transmit
7170  1256 5b08          	addw	sp,#8
7171                     ; 1781      link_cnt=0;
7173  1258 5f            	clrw	x
7174  1259 bf6b          	ldw	_link_cnt,x
7175                     ; 1782      link=ON;
7177  125b 3555006d      	mov	_link,#85
7178                     ; 1784      if(flags_tu&0b10000000)
7180  125f b66a          	ld	a,_flags_tu
7181  1261 a580          	bcp	a,#128
7182  1263 2716          	jreq	L3023
7183                     ; 1786      	if(!res_fl)
7185  1265 725d000b      	tnz	_res_fl
7186  1269 2626          	jrne	L7023
7187                     ; 1788      		res_fl=1;
7189  126b a601          	ld	a,#1
7190  126d ae000b        	ldw	x,#_res_fl
7191  1270 cd0000        	call	c_eewrc
7193                     ; 1789      		bRES=1;
7195  1273 3501000c      	mov	_bRES,#1
7196                     ; 1790      		res_fl_cnt=0;
7198  1277 3f4b          	clr	_res_fl_cnt
7199  1279 2016          	jra	L7023
7200  127b               L3023:
7201                     ; 1795      	if(main_cnt>20)
7203  127b 9c            	rvf
7204  127c ce025d        	ldw	x,_main_cnt
7205  127f a30015        	cpw	x,#21
7206  1282 2f0d          	jrslt	L7023
7207                     ; 1797     			if(res_fl)
7209  1284 725d000b      	tnz	_res_fl
7210  1288 2707          	jreq	L7023
7211                     ; 1799      			res_fl=0;
7213  128a 4f            	clr	a
7214  128b ae000b        	ldw	x,#_res_fl
7215  128e cd0000        	call	c_eewrc
7217  1291               L7023:
7218                     ; 1804       if(res_fl_)
7220  1291 725d000a      	tnz	_res_fl_
7221  1295 2603          	jrne	L071
7222  1297 cc180c        	jp	L1313
7223  129a               L071:
7224                     ; 1806       	res_fl_=0;
7226  129a 4f            	clr	a
7227  129b ae000a        	ldw	x,#_res_fl_
7228  129e cd0000        	call	c_eewrc
7230  12a1 ac0c180c      	jpf	L1313
7231  12a5               L5613:
7232                     ; 1809 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7234  12a5 b6cd          	ld	a,_mess+6
7235  12a7 c100ff        	cp	a,_adress
7236  12aa 2703          	jreq	L271
7237  12ac cc1522        	jp	L1223
7238  12af               L271:
7240  12af b6ce          	ld	a,_mess+7
7241  12b1 c100ff        	cp	a,_adress
7242  12b4 2703          	jreq	L471
7243  12b6 cc1522        	jp	L1223
7244  12b9               L471:
7246  12b9 b6cf          	ld	a,_mess+8
7247  12bb a1ee          	cp	a,#238
7248  12bd 2703          	jreq	L671
7249  12bf cc1522        	jp	L1223
7250  12c2               L671:
7252  12c2 b6d0          	ld	a,_mess+9
7253  12c4 b1d1          	cp	a,_mess+10
7254  12c6 2703          	jreq	L002
7255  12c8 cc1522        	jp	L1223
7256  12cb               L002:
7257                     ; 1811 	rotor_int++;
7259  12cb be17          	ldw	x,_rotor_int
7260  12cd 1c0001        	addw	x,#1
7261  12d0 bf17          	ldw	_rotor_int,x
7262                     ; 1812 	if((mess[9]&0xf0)==0x20)
7264  12d2 b6d0          	ld	a,_mess+9
7265  12d4 a4f0          	and	a,#240
7266  12d6 a120          	cp	a,#32
7267  12d8 2673          	jrne	L3223
7268                     ; 1814 		if((mess[9]&0x0f)==0x01)
7270  12da b6d0          	ld	a,_mess+9
7271  12dc a40f          	and	a,#15
7272  12de a101          	cp	a,#1
7273  12e0 260d          	jrne	L5223
7274                     ; 1816 			ee_K[0][0]=adc_buff_[4];
7276  12e2 ce010f        	ldw	x,_adc_buff_+8
7277  12e5 89            	pushw	x
7278  12e6 ae001a        	ldw	x,#_ee_K
7279  12e9 cd0000        	call	c_eewrw
7281  12ec 85            	popw	x
7283  12ed 204a          	jra	L7223
7284  12ef               L5223:
7285                     ; 1818 		else if((mess[9]&0x0f)==0x02)
7287  12ef b6d0          	ld	a,_mess+9
7288  12f1 a40f          	and	a,#15
7289  12f3 a102          	cp	a,#2
7290  12f5 260b          	jrne	L1323
7291                     ; 1820 			ee_K[0][1]++;
7293  12f7 ce001c        	ldw	x,_ee_K+2
7294  12fa 1c0001        	addw	x,#1
7295  12fd cf001c        	ldw	_ee_K+2,x
7297  1300 2037          	jra	L7223
7298  1302               L1323:
7299                     ; 1822 		else if((mess[9]&0x0f)==0x03)
7301  1302 b6d0          	ld	a,_mess+9
7302  1304 a40f          	and	a,#15
7303  1306 a103          	cp	a,#3
7304  1308 260b          	jrne	L5323
7305                     ; 1824 			ee_K[0][1]+=10;
7307  130a ce001c        	ldw	x,_ee_K+2
7308  130d 1c000a        	addw	x,#10
7309  1310 cf001c        	ldw	_ee_K+2,x
7311  1313 2024          	jra	L7223
7312  1315               L5323:
7313                     ; 1826 		else if((mess[9]&0x0f)==0x04)
7315  1315 b6d0          	ld	a,_mess+9
7316  1317 a40f          	and	a,#15
7317  1319 a104          	cp	a,#4
7318  131b 260b          	jrne	L1423
7319                     ; 1828 			ee_K[0][1]--;
7321  131d ce001c        	ldw	x,_ee_K+2
7322  1320 1d0001        	subw	x,#1
7323  1323 cf001c        	ldw	_ee_K+2,x
7325  1326 2011          	jra	L7223
7326  1328               L1423:
7327                     ; 1830 		else if((mess[9]&0x0f)==0x05)
7329  1328 b6d0          	ld	a,_mess+9
7330  132a a40f          	and	a,#15
7331  132c a105          	cp	a,#5
7332  132e 2609          	jrne	L7223
7333                     ; 1832 			ee_K[0][1]-=10;
7335  1330 ce001c        	ldw	x,_ee_K+2
7336  1333 1d000a        	subw	x,#10
7337  1336 cf001c        	ldw	_ee_K+2,x
7338  1339               L7223:
7339                     ; 1834 		granee(&ee_K[0][1],50,3000);									
7341  1339 ae0bb8        	ldw	x,#3000
7342  133c 89            	pushw	x
7343  133d ae0032        	ldw	x,#50
7344  1340 89            	pushw	x
7345  1341 ae001c        	ldw	x,#_ee_K+2
7346  1344 cd00f6        	call	_granee
7348  1347 5b04          	addw	sp,#4
7350  1349 ac071507      	jpf	L7423
7351  134d               L3223:
7352                     ; 1836 	else if((mess[9]&0xf0)==0x10)
7354  134d b6d0          	ld	a,_mess+9
7355  134f a4f0          	and	a,#240
7356  1351 a110          	cp	a,#16
7357  1353 2673          	jrne	L1523
7358                     ; 1838 		if((mess[9]&0x0f)==0x01)
7360  1355 b6d0          	ld	a,_mess+9
7361  1357 a40f          	and	a,#15
7362  1359 a101          	cp	a,#1
7363  135b 260d          	jrne	L3523
7364                     ; 1840 			ee_K[1][0]=adc_buff_[1];
7366  135d ce0109        	ldw	x,_adc_buff_+2
7367  1360 89            	pushw	x
7368  1361 ae001e        	ldw	x,#_ee_K+4
7369  1364 cd0000        	call	c_eewrw
7371  1367 85            	popw	x
7373  1368 204a          	jra	L5523
7374  136a               L3523:
7375                     ; 1842 		else if((mess[9]&0x0f)==0x02)
7377  136a b6d0          	ld	a,_mess+9
7378  136c a40f          	and	a,#15
7379  136e a102          	cp	a,#2
7380  1370 260b          	jrne	L7523
7381                     ; 1844 			ee_K[1][1]++;
7383  1372 ce0020        	ldw	x,_ee_K+6
7384  1375 1c0001        	addw	x,#1
7385  1378 cf0020        	ldw	_ee_K+6,x
7387  137b 2037          	jra	L5523
7388  137d               L7523:
7389                     ; 1846 		else if((mess[9]&0x0f)==0x03)
7391  137d b6d0          	ld	a,_mess+9
7392  137f a40f          	and	a,#15
7393  1381 a103          	cp	a,#3
7394  1383 260b          	jrne	L3623
7395                     ; 1848 			ee_K[1][1]+=10;
7397  1385 ce0020        	ldw	x,_ee_K+6
7398  1388 1c000a        	addw	x,#10
7399  138b cf0020        	ldw	_ee_K+6,x
7401  138e 2024          	jra	L5523
7402  1390               L3623:
7403                     ; 1850 		else if((mess[9]&0x0f)==0x04)
7405  1390 b6d0          	ld	a,_mess+9
7406  1392 a40f          	and	a,#15
7407  1394 a104          	cp	a,#4
7408  1396 260b          	jrne	L7623
7409                     ; 1852 			ee_K[1][1]--;
7411  1398 ce0020        	ldw	x,_ee_K+6
7412  139b 1d0001        	subw	x,#1
7413  139e cf0020        	ldw	_ee_K+6,x
7415  13a1 2011          	jra	L5523
7416  13a3               L7623:
7417                     ; 1854 		else if((mess[9]&0x0f)==0x05)
7419  13a3 b6d0          	ld	a,_mess+9
7420  13a5 a40f          	and	a,#15
7421  13a7 a105          	cp	a,#5
7422  13a9 2609          	jrne	L5523
7423                     ; 1856 			ee_K[1][1]-=10;
7425  13ab ce0020        	ldw	x,_ee_K+6
7426  13ae 1d000a        	subw	x,#10
7427  13b1 cf0020        	ldw	_ee_K+6,x
7428  13b4               L5523:
7429                     ; 1861 		granee(&ee_K[1][1],10,30000);
7431  13b4 ae7530        	ldw	x,#30000
7432  13b7 89            	pushw	x
7433  13b8 ae000a        	ldw	x,#10
7434  13bb 89            	pushw	x
7435  13bc ae0020        	ldw	x,#_ee_K+6
7436  13bf cd00f6        	call	_granee
7438  13c2 5b04          	addw	sp,#4
7440  13c4 ac071507      	jpf	L7423
7441  13c8               L1523:
7442                     ; 1865 	else if((mess[9]&0xf0)==0x00)
7444  13c8 b6d0          	ld	a,_mess+9
7445  13ca a5f0          	bcp	a,#240
7446  13cc 2673          	jrne	L7723
7447                     ; 1867 		if((mess[9]&0x0f)==0x01)
7449  13ce b6d0          	ld	a,_mess+9
7450  13d0 a40f          	and	a,#15
7451  13d2 a101          	cp	a,#1
7452  13d4 260d          	jrne	L1033
7453                     ; 1869 			ee_K[2][0]=adc_buff_[2];
7455  13d6 ce010b        	ldw	x,_adc_buff_+4
7456  13d9 89            	pushw	x
7457  13da ae0022        	ldw	x,#_ee_K+8
7458  13dd cd0000        	call	c_eewrw
7460  13e0 85            	popw	x
7462  13e1 204a          	jra	L3033
7463  13e3               L1033:
7464                     ; 1871 		else if((mess[9]&0x0f)==0x02)
7466  13e3 b6d0          	ld	a,_mess+9
7467  13e5 a40f          	and	a,#15
7468  13e7 a102          	cp	a,#2
7469  13e9 260b          	jrne	L5033
7470                     ; 1873 			ee_K[2][1]++;
7472  13eb ce0024        	ldw	x,_ee_K+10
7473  13ee 1c0001        	addw	x,#1
7474  13f1 cf0024        	ldw	_ee_K+10,x
7476  13f4 2037          	jra	L3033
7477  13f6               L5033:
7478                     ; 1875 		else if((mess[9]&0x0f)==0x03)
7480  13f6 b6d0          	ld	a,_mess+9
7481  13f8 a40f          	and	a,#15
7482  13fa a103          	cp	a,#3
7483  13fc 260b          	jrne	L1133
7484                     ; 1877 			ee_K[2][1]+=10;
7486  13fe ce0024        	ldw	x,_ee_K+10
7487  1401 1c000a        	addw	x,#10
7488  1404 cf0024        	ldw	_ee_K+10,x
7490  1407 2024          	jra	L3033
7491  1409               L1133:
7492                     ; 1879 		else if((mess[9]&0x0f)==0x04)
7494  1409 b6d0          	ld	a,_mess+9
7495  140b a40f          	and	a,#15
7496  140d a104          	cp	a,#4
7497  140f 260b          	jrne	L5133
7498                     ; 1881 			ee_K[2][1]--;
7500  1411 ce0024        	ldw	x,_ee_K+10
7501  1414 1d0001        	subw	x,#1
7502  1417 cf0024        	ldw	_ee_K+10,x
7504  141a 2011          	jra	L3033
7505  141c               L5133:
7506                     ; 1883 		else if((mess[9]&0x0f)==0x05)
7508  141c b6d0          	ld	a,_mess+9
7509  141e a40f          	and	a,#15
7510  1420 a105          	cp	a,#5
7511  1422 2609          	jrne	L3033
7512                     ; 1885 			ee_K[2][1]-=10;
7514  1424 ce0024        	ldw	x,_ee_K+10
7515  1427 1d000a        	subw	x,#10
7516  142a cf0024        	ldw	_ee_K+10,x
7517  142d               L3033:
7518                     ; 1890 		granee(&ee_K[2][1],10,30000);
7520  142d ae7530        	ldw	x,#30000
7521  1430 89            	pushw	x
7522  1431 ae000a        	ldw	x,#10
7523  1434 89            	pushw	x
7524  1435 ae0024        	ldw	x,#_ee_K+10
7525  1438 cd00f6        	call	_granee
7527  143b 5b04          	addw	sp,#4
7529  143d ac071507      	jpf	L7423
7530  1441               L7723:
7531                     ; 1894 	else if((mess[9]&0xf0)==0x30)
7533  1441 b6d0          	ld	a,_mess+9
7534  1443 a4f0          	and	a,#240
7535  1445 a130          	cp	a,#48
7536  1447 265c          	jrne	L5233
7537                     ; 1896 		if((mess[9]&0x0f)==0x02)
7539  1449 b6d0          	ld	a,_mess+9
7540  144b a40f          	and	a,#15
7541  144d a102          	cp	a,#2
7542  144f 260b          	jrne	L7233
7543                     ; 1898 			ee_K[3][1]++;
7545  1451 ce0028        	ldw	x,_ee_K+14
7546  1454 1c0001        	addw	x,#1
7547  1457 cf0028        	ldw	_ee_K+14,x
7549  145a 2037          	jra	L1333
7550  145c               L7233:
7551                     ; 1900 		else if((mess[9]&0x0f)==0x03)
7553  145c b6d0          	ld	a,_mess+9
7554  145e a40f          	and	a,#15
7555  1460 a103          	cp	a,#3
7556  1462 260b          	jrne	L3333
7557                     ; 1902 			ee_K[3][1]+=10;
7559  1464 ce0028        	ldw	x,_ee_K+14
7560  1467 1c000a        	addw	x,#10
7561  146a cf0028        	ldw	_ee_K+14,x
7563  146d 2024          	jra	L1333
7564  146f               L3333:
7565                     ; 1904 		else if((mess[9]&0x0f)==0x04)
7567  146f b6d0          	ld	a,_mess+9
7568  1471 a40f          	and	a,#15
7569  1473 a104          	cp	a,#4
7570  1475 260b          	jrne	L7333
7571                     ; 1906 			ee_K[3][1]--;
7573  1477 ce0028        	ldw	x,_ee_K+14
7574  147a 1d0001        	subw	x,#1
7575  147d cf0028        	ldw	_ee_K+14,x
7577  1480 2011          	jra	L1333
7578  1482               L7333:
7579                     ; 1908 		else if((mess[9]&0x0f)==0x05)
7581  1482 b6d0          	ld	a,_mess+9
7582  1484 a40f          	and	a,#15
7583  1486 a105          	cp	a,#5
7584  1488 2609          	jrne	L1333
7585                     ; 1910 			ee_K[3][1]-=10;
7587  148a ce0028        	ldw	x,_ee_K+14
7588  148d 1d000a        	subw	x,#10
7589  1490 cf0028        	ldw	_ee_K+14,x
7590  1493               L1333:
7591                     ; 1912 		granee(&ee_K[3][1],300,517);									
7593  1493 ae0205        	ldw	x,#517
7594  1496 89            	pushw	x
7595  1497 ae012c        	ldw	x,#300
7596  149a 89            	pushw	x
7597  149b ae0028        	ldw	x,#_ee_K+14
7598  149e cd00f6        	call	_granee
7600  14a1 5b04          	addw	sp,#4
7602  14a3 2062          	jra	L7423
7603  14a5               L5233:
7604                     ; 1915 	else if((mess[9]&0xf0)==0x50)
7606  14a5 b6d0          	ld	a,_mess+9
7607  14a7 a4f0          	and	a,#240
7608  14a9 a150          	cp	a,#80
7609  14ab 265a          	jrne	L7423
7610                     ; 1917 		if((mess[9]&0x0f)==0x02)
7612  14ad b6d0          	ld	a,_mess+9
7613  14af a40f          	and	a,#15
7614  14b1 a102          	cp	a,#2
7615  14b3 260b          	jrne	L1533
7616                     ; 1919 			ee_K[4][1]++;
7618  14b5 ce002c        	ldw	x,_ee_K+18
7619  14b8 1c0001        	addw	x,#1
7620  14bb cf002c        	ldw	_ee_K+18,x
7622  14be 2037          	jra	L3533
7623  14c0               L1533:
7624                     ; 1921 		else if((mess[9]&0x0f)==0x03)
7626  14c0 b6d0          	ld	a,_mess+9
7627  14c2 a40f          	and	a,#15
7628  14c4 a103          	cp	a,#3
7629  14c6 260b          	jrne	L5533
7630                     ; 1923 			ee_K[4][1]+=10;
7632  14c8 ce002c        	ldw	x,_ee_K+18
7633  14cb 1c000a        	addw	x,#10
7634  14ce cf002c        	ldw	_ee_K+18,x
7636  14d1 2024          	jra	L3533
7637  14d3               L5533:
7638                     ; 1925 		else if((mess[9]&0x0f)==0x04)
7640  14d3 b6d0          	ld	a,_mess+9
7641  14d5 a40f          	and	a,#15
7642  14d7 a104          	cp	a,#4
7643  14d9 260b          	jrne	L1633
7644                     ; 1927 			ee_K[4][1]--;
7646  14db ce002c        	ldw	x,_ee_K+18
7647  14de 1d0001        	subw	x,#1
7648  14e1 cf002c        	ldw	_ee_K+18,x
7650  14e4 2011          	jra	L3533
7651  14e6               L1633:
7652                     ; 1929 		else if((mess[9]&0x0f)==0x05)
7654  14e6 b6d0          	ld	a,_mess+9
7655  14e8 a40f          	and	a,#15
7656  14ea a105          	cp	a,#5
7657  14ec 2609          	jrne	L3533
7658                     ; 1931 			ee_K[4][1]-=10;
7660  14ee ce002c        	ldw	x,_ee_K+18
7661  14f1 1d000a        	subw	x,#10
7662  14f4 cf002c        	ldw	_ee_K+18,x
7663  14f7               L3533:
7664                     ; 1933 		granee(&ee_K[4][1],10,30000);									
7666  14f7 ae7530        	ldw	x,#30000
7667  14fa 89            	pushw	x
7668  14fb ae000a        	ldw	x,#10
7669  14fe 89            	pushw	x
7670  14ff ae002c        	ldw	x,#_ee_K+18
7671  1502 cd00f6        	call	_granee
7673  1505 5b04          	addw	sp,#4
7674  1507               L7423:
7675                     ; 1936 	link_cnt=0;
7677  1507 5f            	clrw	x
7678  1508 bf6b          	ldw	_link_cnt,x
7679                     ; 1937      link=ON;
7681  150a 3555006d      	mov	_link,#85
7682                     ; 1938      if(res_fl_)
7684  150e 725d000a      	tnz	_res_fl_
7685  1512 2603          	jrne	L202
7686  1514 cc180c        	jp	L1313
7687  1517               L202:
7688                     ; 1940       	res_fl_=0;
7690  1517 4f            	clr	a
7691  1518 ae000a        	ldw	x,#_res_fl_
7692  151b cd0000        	call	c_eewrc
7694  151e ac0c180c      	jpf	L1313
7695  1522               L1223:
7696                     ; 1946 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7698  1522 b6cd          	ld	a,_mess+6
7699  1524 a1ff          	cp	a,#255
7700  1526 2703          	jreq	L402
7701  1528 cc15b6        	jp	L3733
7702  152b               L402:
7704  152b b6ce          	ld	a,_mess+7
7705  152d a1ff          	cp	a,#255
7706  152f 2703          	jreq	L602
7707  1531 cc15b6        	jp	L3733
7708  1534               L602:
7710  1534 b6cf          	ld	a,_mess+8
7711  1536 a162          	cp	a,#98
7712  1538 267c          	jrne	L3733
7713                     ; 1949 	tempSS=mess[9]+(mess[10]*256);
7715  153a b6d1          	ld	a,_mess+10
7716  153c 5f            	clrw	x
7717  153d 97            	ld	xl,a
7718  153e 4f            	clr	a
7719  153f 02            	rlwa	x,a
7720  1540 01            	rrwa	x,a
7721  1541 bbd0          	add	a,_mess+9
7722  1543 2401          	jrnc	L451
7723  1545 5c            	incw	x
7724  1546               L451:
7725  1546 02            	rlwa	x,a
7726  1547 1f03          	ldw	(OFST-4,sp),x
7727  1549 01            	rrwa	x,a
7728                     ; 1950 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7730  154a ce0014        	ldw	x,_ee_Umax
7731  154d 1303          	cpw	x,(OFST-4,sp)
7732  154f 270a          	jreq	L5733
7735  1551 1e03          	ldw	x,(OFST-4,sp)
7736  1553 89            	pushw	x
7737  1554 ae0014        	ldw	x,#_ee_Umax
7738  1557 cd0000        	call	c_eewrw
7740  155a 85            	popw	x
7741  155b               L5733:
7742                     ; 1951 	tempSS=mess[11]+(mess[12]*256);
7744  155b b6d3          	ld	a,_mess+12
7745  155d 5f            	clrw	x
7746  155e 97            	ld	xl,a
7747  155f 4f            	clr	a
7748  1560 02            	rlwa	x,a
7749  1561 01            	rrwa	x,a
7750  1562 bbd2          	add	a,_mess+11
7751  1564 2401          	jrnc	L651
7752  1566 5c            	incw	x
7753  1567               L651:
7754  1567 02            	rlwa	x,a
7755  1568 1f03          	ldw	(OFST-4,sp),x
7756  156a 01            	rrwa	x,a
7757                     ; 1952 	if(ee_dU!=tempSS) ee_dU=tempSS;
7759  156b ce0012        	ldw	x,_ee_dU
7760  156e 1303          	cpw	x,(OFST-4,sp)
7761  1570 270a          	jreq	L7733
7764  1572 1e03          	ldw	x,(OFST-4,sp)
7765  1574 89            	pushw	x
7766  1575 ae0012        	ldw	x,#_ee_dU
7767  1578 cd0000        	call	c_eewrw
7769  157b 85            	popw	x
7770  157c               L7733:
7771                     ; 1953 	if((mess[13]&0x0f)==0x5)
7773  157c b6d4          	ld	a,_mess+13
7774  157e a40f          	and	a,#15
7775  1580 a105          	cp	a,#5
7776  1582 261a          	jrne	L1043
7777                     ; 1955 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7779  1584 ce0006        	ldw	x,_ee_AVT_MODE
7780  1587 a30055        	cpw	x,#85
7781  158a 2603          	jrne	L012
7782  158c cc180c        	jp	L1313
7783  158f               L012:
7786  158f ae0055        	ldw	x,#85
7787  1592 89            	pushw	x
7788  1593 ae0006        	ldw	x,#_ee_AVT_MODE
7789  1596 cd0000        	call	c_eewrw
7791  1599 85            	popw	x
7792  159a ac0c180c      	jpf	L1313
7793  159e               L1043:
7794                     ; 1957 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7796  159e ce0006        	ldw	x,_ee_AVT_MODE
7797  15a1 a30055        	cpw	x,#85
7798  15a4 2703          	jreq	L212
7799  15a6 cc180c        	jp	L1313
7800  15a9               L212:
7803  15a9 5f            	clrw	x
7804  15aa 89            	pushw	x
7805  15ab ae0006        	ldw	x,#_ee_AVT_MODE
7806  15ae cd0000        	call	c_eewrw
7808  15b1 85            	popw	x
7809  15b2 ac0c180c      	jpf	L1313
7810  15b6               L3733:
7811                     ; 1960 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7813  15b6 b6cd          	ld	a,_mess+6
7814  15b8 a1ff          	cp	a,#255
7815  15ba 2703          	jreq	L412
7816  15bc cc1672        	jp	L3143
7817  15bf               L412:
7819  15bf b6ce          	ld	a,_mess+7
7820  15c1 a1ff          	cp	a,#255
7821  15c3 2703          	jreq	L612
7822  15c5 cc1672        	jp	L3143
7823  15c8               L612:
7825  15c8 b6cf          	ld	a,_mess+8
7826  15ca a126          	cp	a,#38
7827  15cc 2709          	jreq	L5143
7829  15ce b6cf          	ld	a,_mess+8
7830  15d0 a129          	cp	a,#41
7831  15d2 2703          	jreq	L022
7832  15d4 cc1672        	jp	L3143
7833  15d7               L022:
7834  15d7               L5143:
7835                     ; 1963 	tempSS=mess[9]+(mess[10]*256);
7837  15d7 b6d1          	ld	a,_mess+10
7838  15d9 5f            	clrw	x
7839  15da 97            	ld	xl,a
7840  15db 4f            	clr	a
7841  15dc 02            	rlwa	x,a
7842  15dd 01            	rrwa	x,a
7843  15de bbd0          	add	a,_mess+9
7844  15e0 2401          	jrnc	L061
7845  15e2 5c            	incw	x
7846  15e3               L061:
7847  15e3 02            	rlwa	x,a
7848  15e4 1f03          	ldw	(OFST-4,sp),x
7849  15e6 01            	rrwa	x,a
7850                     ; 1965 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7852  15e7 ce000c        	ldw	x,_ee_UAVT
7853  15ea 1303          	cpw	x,(OFST-4,sp)
7854  15ec 270a          	jreq	L7143
7857  15ee 1e03          	ldw	x,(OFST-4,sp)
7858  15f0 89            	pushw	x
7859  15f1 ae000c        	ldw	x,#_ee_UAVT
7860  15f4 cd0000        	call	c_eewrw
7862  15f7 85            	popw	x
7863  15f8               L7143:
7864                     ; 1966 	tempSS=(signed short)mess[11];
7866  15f8 b6d2          	ld	a,_mess+11
7867  15fa 5f            	clrw	x
7868  15fb 97            	ld	xl,a
7869  15fc 1f03          	ldw	(OFST-4,sp),x
7870                     ; 1967 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7872  15fe ce0010        	ldw	x,_ee_tmax
7873  1601 1303          	cpw	x,(OFST-4,sp)
7874  1603 270a          	jreq	L1243
7877  1605 1e03          	ldw	x,(OFST-4,sp)
7878  1607 89            	pushw	x
7879  1608 ae0010        	ldw	x,#_ee_tmax
7880  160b cd0000        	call	c_eewrw
7882  160e 85            	popw	x
7883  160f               L1243:
7884                     ; 1968 	tempSS=(signed short)mess[12];
7886  160f b6d3          	ld	a,_mess+12
7887  1611 5f            	clrw	x
7888  1612 97            	ld	xl,a
7889  1613 1f03          	ldw	(OFST-4,sp),x
7890                     ; 1969 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7892  1615 ce000e        	ldw	x,_ee_tsign
7893  1618 1303          	cpw	x,(OFST-4,sp)
7894  161a 270a          	jreq	L3243
7897  161c 1e03          	ldw	x,(OFST-4,sp)
7898  161e 89            	pushw	x
7899  161f ae000e        	ldw	x,#_ee_tsign
7900  1622 cd0000        	call	c_eewrw
7902  1625 85            	popw	x
7903  1626               L3243:
7904                     ; 1972 	if(mess[8]==MEM_KF1)
7906  1626 b6cf          	ld	a,_mess+8
7907  1628 a126          	cp	a,#38
7908  162a 260e          	jrne	L5243
7909                     ; 1974 		if(ee_DEVICE!=0)ee_DEVICE=0;
7911  162c ce0004        	ldw	x,_ee_DEVICE
7912  162f 2709          	jreq	L5243
7915  1631 5f            	clrw	x
7916  1632 89            	pushw	x
7917  1633 ae0004        	ldw	x,#_ee_DEVICE
7918  1636 cd0000        	call	c_eewrw
7920  1639 85            	popw	x
7921  163a               L5243:
7922                     ; 1977 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7924  163a b6cf          	ld	a,_mess+8
7925  163c a129          	cp	a,#41
7926  163e 2703          	jreq	L222
7927  1640 cc180c        	jp	L1313
7928  1643               L222:
7929                     ; 1979 		if(ee_DEVICE!=1)ee_DEVICE=1;
7931  1643 ce0004        	ldw	x,_ee_DEVICE
7932  1646 a30001        	cpw	x,#1
7933  1649 270b          	jreq	L3343
7936  164b ae0001        	ldw	x,#1
7937  164e 89            	pushw	x
7938  164f ae0004        	ldw	x,#_ee_DEVICE
7939  1652 cd0000        	call	c_eewrw
7941  1655 85            	popw	x
7942  1656               L3343:
7943                     ; 1980 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7945  1656 b6d4          	ld	a,_mess+13
7946  1658 5f            	clrw	x
7947  1659 97            	ld	xl,a
7948  165a c30002        	cpw	x,_ee_IMAXVENT
7949  165d 2603          	jrne	L422
7950  165f cc180c        	jp	L1313
7951  1662               L422:
7954  1662 b6d4          	ld	a,_mess+13
7955  1664 5f            	clrw	x
7956  1665 97            	ld	xl,a
7957  1666 89            	pushw	x
7958  1667 ae0002        	ldw	x,#_ee_IMAXVENT
7959  166a cd0000        	call	c_eewrw
7961  166d 85            	popw	x
7962  166e ac0c180c      	jpf	L1313
7963  1672               L3143:
7964                     ; 1985 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7966  1672 b6cd          	ld	a,_mess+6
7967  1674 c100ff        	cp	a,_adress
7968  1677 262d          	jrne	L1443
7970  1679 b6ce          	ld	a,_mess+7
7971  167b c100ff        	cp	a,_adress
7972  167e 2626          	jrne	L1443
7974  1680 b6cf          	ld	a,_mess+8
7975  1682 a116          	cp	a,#22
7976  1684 2620          	jrne	L1443
7978  1686 b6d0          	ld	a,_mess+9
7979  1688 a163          	cp	a,#99
7980  168a 261a          	jrne	L1443
7981                     ; 1987 	flags&=0b11100001;
7983  168c b605          	ld	a,_flags
7984  168e a4e1          	and	a,#225
7985  1690 b705          	ld	_flags,a
7986                     ; 1988 	tsign_cnt=0;
7988  1692 5f            	clrw	x
7989  1693 bf59          	ldw	_tsign_cnt,x
7990                     ; 1989 	tmax_cnt=0;
7992  1695 5f            	clrw	x
7993  1696 bf57          	ldw	_tmax_cnt,x
7994                     ; 1990 	umax_cnt=0;
7996  1698 5f            	clrw	x
7997  1699 bf70          	ldw	_umax_cnt,x
7998                     ; 1991 	umin_cnt=0;
8000  169b 5f            	clrw	x
8001  169c bf6e          	ldw	_umin_cnt,x
8002                     ; 1992 	led_drv_cnt=30;
8004  169e 351e0016      	mov	_led_drv_cnt,#30
8006  16a2 ac0c180c      	jpf	L1313
8007  16a6               L1443:
8008                     ; 1995 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8010  16a6 b6cd          	ld	a,_mess+6
8011  16a8 c100ff        	cp	a,_adress
8012  16ab 2620          	jrne	L5443
8014  16ad b6ce          	ld	a,_mess+7
8015  16af c100ff        	cp	a,_adress
8016  16b2 2619          	jrne	L5443
8018  16b4 b6cf          	ld	a,_mess+8
8019  16b6 a116          	cp	a,#22
8020  16b8 2613          	jrne	L5443
8022  16ba b6d0          	ld	a,_mess+9
8023  16bc a164          	cp	a,#100
8024  16be 260d          	jrne	L5443
8025                     ; 1997 	vent_resurs=0;
8027  16c0 5f            	clrw	x
8028  16c1 89            	pushw	x
8029  16c2 ae0000        	ldw	x,#_vent_resurs
8030  16c5 cd0000        	call	c_eewrw
8032  16c8 85            	popw	x
8034  16c9 ac0c180c      	jpf	L1313
8035  16cd               L5443:
8036                     ; 2001 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8038  16cd b6cd          	ld	a,_mess+6
8039  16cf a1ff          	cp	a,#255
8040  16d1 265f          	jrne	L1543
8042  16d3 b6ce          	ld	a,_mess+7
8043  16d5 a1ff          	cp	a,#255
8044  16d7 2659          	jrne	L1543
8046  16d9 b6cf          	ld	a,_mess+8
8047  16db a116          	cp	a,#22
8048  16dd 2653          	jrne	L1543
8050  16df b6d0          	ld	a,_mess+9
8051  16e1 a116          	cp	a,#22
8052  16e3 264d          	jrne	L1543
8053                     ; 2003 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8055  16e5 b6d1          	ld	a,_mess+10
8056  16e7 a155          	cp	a,#85
8057  16e9 260f          	jrne	L3543
8059  16eb b6d2          	ld	a,_mess+11
8060  16ed a155          	cp	a,#85
8061  16ef 2609          	jrne	L3543
8064  16f1 be68          	ldw	x,__x_
8065  16f3 1c0001        	addw	x,#1
8066  16f6 bf68          	ldw	__x_,x
8068  16f8 2024          	jra	L5543
8069  16fa               L3543:
8070                     ; 2004 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8072  16fa b6d1          	ld	a,_mess+10
8073  16fc a166          	cp	a,#102
8074  16fe 260f          	jrne	L7543
8076  1700 b6d2          	ld	a,_mess+11
8077  1702 a166          	cp	a,#102
8078  1704 2609          	jrne	L7543
8081  1706 be68          	ldw	x,__x_
8082  1708 1d0001        	subw	x,#1
8083  170b bf68          	ldw	__x_,x
8085  170d 200f          	jra	L5543
8086  170f               L7543:
8087                     ; 2005 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8089  170f b6d1          	ld	a,_mess+10
8090  1711 a177          	cp	a,#119
8091  1713 2609          	jrne	L5543
8093  1715 b6d2          	ld	a,_mess+11
8094  1717 a177          	cp	a,#119
8095  1719 2603          	jrne	L5543
8098  171b 5f            	clrw	x
8099  171c bf68          	ldw	__x_,x
8100  171e               L5543:
8101                     ; 2006      gran(&_x_,-XMAX,XMAX);
8103  171e ae0019        	ldw	x,#25
8104  1721 89            	pushw	x
8105  1722 aeffe7        	ldw	x,#65511
8106  1725 89            	pushw	x
8107  1726 ae0068        	ldw	x,#__x_
8108  1729 cd00d5        	call	_gran
8110  172c 5b04          	addw	sp,#4
8112  172e ac0c180c      	jpf	L1313
8113  1732               L1543:
8114                     ; 2008 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8116  1732 b6cd          	ld	a,_mess+6
8117  1734 c100ff        	cp	a,_adress
8118  1737 2635          	jrne	L7643
8120  1739 b6ce          	ld	a,_mess+7
8121  173b c100ff        	cp	a,_adress
8122  173e 262e          	jrne	L7643
8124  1740 b6cf          	ld	a,_mess+8
8125  1742 a116          	cp	a,#22
8126  1744 2628          	jrne	L7643
8128  1746 b6d0          	ld	a,_mess+9
8129  1748 b1d1          	cp	a,_mess+10
8130  174a 2622          	jrne	L7643
8132  174c b6d0          	ld	a,_mess+9
8133  174e a1ee          	cp	a,#238
8134  1750 261c          	jrne	L7643
8135                     ; 2010 	rotor_int++;
8137  1752 be17          	ldw	x,_rotor_int
8138  1754 1c0001        	addw	x,#1
8139  1757 bf17          	ldw	_rotor_int,x
8140                     ; 2011      tempI=pwm_u;
8142                     ; 2013 	UU_AVT=Un;
8144  1759 ce0016        	ldw	x,_Un
8145  175c 89            	pushw	x
8146  175d ae0008        	ldw	x,#_UU_AVT
8147  1760 cd0000        	call	c_eewrw
8149  1763 85            	popw	x
8150                     ; 2014 	delay_ms(100);
8152  1764 ae0064        	ldw	x,#100
8153  1767 cd0121        	call	_delay_ms
8156  176a ac0c180c      	jpf	L1313
8157  176e               L7643:
8158                     ; 2020 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8160  176e b6ce          	ld	a,_mess+7
8161  1770 a1da          	cp	a,#218
8162  1772 2653          	jrne	L3743
8164  1774 b6cd          	ld	a,_mess+6
8165  1776 c100ff        	cp	a,_adress
8166  1779 274c          	jreq	L3743
8168  177b b6cd          	ld	a,_mess+6
8169  177d a106          	cp	a,#6
8170  177f 2446          	jruge	L3743
8171                     ; 2022 	i_main_bps_cnt[mess[6]]=0;
8173  1781 b6cd          	ld	a,_mess+6
8174  1783 5f            	clrw	x
8175  1784 97            	ld	xl,a
8176  1785 6f13          	clr	(_i_main_bps_cnt,x)
8177                     ; 2023 	i_main_flag[mess[6]]=1;
8179  1787 b6cd          	ld	a,_mess+6
8180  1789 5f            	clrw	x
8181  178a 97            	ld	xl,a
8182  178b a601          	ld	a,#1
8183  178d e71e          	ld	(_i_main_flag,x),a
8184                     ; 2024 	if(bMAIN)
8186                     	btst	_bMAIN
8187  1794 2476          	jruge	L1313
8188                     ; 2026 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8190  1796 b6d0          	ld	a,_mess+9
8191  1798 5f            	clrw	x
8192  1799 97            	ld	xl,a
8193  179a 4f            	clr	a
8194  179b 02            	rlwa	x,a
8195  179c 1f01          	ldw	(OFST-6,sp),x
8196  179e b6cf          	ld	a,_mess+8
8197  17a0 5f            	clrw	x
8198  17a1 97            	ld	xl,a
8199  17a2 72fb01        	addw	x,(OFST-6,sp)
8200  17a5 b6cd          	ld	a,_mess+6
8201  17a7 905f          	clrw	y
8202  17a9 9097          	ld	yl,a
8203  17ab 9058          	sllw	y
8204  17ad 90ef24        	ldw	(_i_main,y),x
8205                     ; 2027 		i_main[adress]=I;
8207  17b0 c600ff        	ld	a,_adress
8208  17b3 5f            	clrw	x
8209  17b4 97            	ld	xl,a
8210  17b5 58            	sllw	x
8211  17b6 90ce0018      	ldw	y,_I
8212  17ba ef24          	ldw	(_i_main,x),y
8213                     ; 2028      	i_main_flag[adress]=1;
8215  17bc c600ff        	ld	a,_adress
8216  17bf 5f            	clrw	x
8217  17c0 97            	ld	xl,a
8218  17c1 a601          	ld	a,#1
8219  17c3 e71e          	ld	(_i_main_flag,x),a
8220  17c5 2045          	jra	L1313
8221  17c7               L3743:
8222                     ; 2032 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8224  17c7 b6ce          	ld	a,_mess+7
8225  17c9 a1db          	cp	a,#219
8226  17cb 263f          	jrne	L1313
8228  17cd b6cd          	ld	a,_mess+6
8229  17cf c100ff        	cp	a,_adress
8230  17d2 2738          	jreq	L1313
8232  17d4 b6cd          	ld	a,_mess+6
8233  17d6 a106          	cp	a,#6
8234  17d8 2432          	jruge	L1313
8235                     ; 2034 	i_main_bps_cnt[mess[6]]=0;
8237  17da b6cd          	ld	a,_mess+6
8238  17dc 5f            	clrw	x
8239  17dd 97            	ld	xl,a
8240  17de 6f13          	clr	(_i_main_bps_cnt,x)
8241                     ; 2035 	i_main_flag[mess[6]]=1;		
8243  17e0 b6cd          	ld	a,_mess+6
8244  17e2 5f            	clrw	x
8245  17e3 97            	ld	xl,a
8246  17e4 a601          	ld	a,#1
8247  17e6 e71e          	ld	(_i_main_flag,x),a
8248                     ; 2036 	if(bMAIN)
8250                     	btst	_bMAIN
8251  17ed 241d          	jruge	L1313
8252                     ; 2038 		if(mess[9]==0)i_main_flag[i]=1;
8254  17ef 3dd0          	tnz	_mess+9
8255  17f1 260a          	jrne	L5053
8258  17f3 7b07          	ld	a,(OFST+0,sp)
8259  17f5 5f            	clrw	x
8260  17f6 97            	ld	xl,a
8261  17f7 a601          	ld	a,#1
8262  17f9 e71e          	ld	(_i_main_flag,x),a
8264  17fb 2006          	jra	L7053
8265  17fd               L5053:
8266                     ; 2039 		else i_main_flag[i]=0;
8268  17fd 7b07          	ld	a,(OFST+0,sp)
8269  17ff 5f            	clrw	x
8270  1800 97            	ld	xl,a
8271  1801 6f1e          	clr	(_i_main_flag,x)
8272  1803               L7053:
8273                     ; 2040 		i_main_flag[adress]=1;
8275  1803 c600ff        	ld	a,_adress
8276  1806 5f            	clrw	x
8277  1807 97            	ld	xl,a
8278  1808 a601          	ld	a,#1
8279  180a e71e          	ld	(_i_main_flag,x),a
8280  180c               L1313:
8281                     ; 2046 can_in_an_end:
8281                     ; 2047 bCAN_RX=0;
8283  180c 3f04          	clr	_bCAN_RX
8284                     ; 2048 }   
8287  180e 5b07          	addw	sp,#7
8288  1810 81            	ret
8311                     ; 2051 void t4_init(void){
8312                     	switch	.text
8313  1811               _t4_init:
8317                     ; 2052 	TIM4->PSCR = 6;
8319  1811 35065345      	mov	21317,#6
8320                     ; 2053 	TIM4->ARR= 61;
8322  1815 353d5346      	mov	21318,#61
8323                     ; 2054 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8325  1819 72105341      	bset	21313,#0
8326                     ; 2056 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8328  181d 35855340      	mov	21312,#133
8329                     ; 2058 }
8332  1821 81            	ret
8355                     ; 2061 void t1_init(void)
8355                     ; 2062 {
8356                     	switch	.text
8357  1822               _t1_init:
8361                     ; 2063 TIM1->ARRH= 0x07;
8363  1822 35075262      	mov	21090,#7
8364                     ; 2064 TIM1->ARRL= 0xff;
8366  1826 35ff5263      	mov	21091,#255
8367                     ; 2065 TIM1->CCR1H= 0x00;	
8369  182a 725f5265      	clr	21093
8370                     ; 2066 TIM1->CCR1L= 0xff;
8372  182e 35ff5266      	mov	21094,#255
8373                     ; 2067 TIM1->CCR2H= 0x00;	
8375  1832 725f5267      	clr	21095
8376                     ; 2068 TIM1->CCR2L= 0x00;
8378  1836 725f5268      	clr	21096
8379                     ; 2069 TIM1->CCR3H= 0x00;	
8381  183a 725f5269      	clr	21097
8382                     ; 2070 TIM1->CCR3L= 0x64;
8384  183e 3564526a      	mov	21098,#100
8385                     ; 2072 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8387  1842 35685258      	mov	21080,#104
8388                     ; 2073 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8390  1846 35685259      	mov	21081,#104
8391                     ; 2074 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8393  184a 3568525a      	mov	21082,#104
8394                     ; 2075 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8396  184e 3511525c      	mov	21084,#17
8397                     ; 2076 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8399  1852 3501525d      	mov	21085,#1
8400                     ; 2077 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8402  1856 35815250      	mov	21072,#129
8403                     ; 2078 TIM1->BKR|= TIM1_BKR_AOE;
8405  185a 721c526d      	bset	21101,#6
8406                     ; 2079 }
8409  185e 81            	ret
8434                     ; 2083 void adc2_init(void)
8434                     ; 2084 {
8435                     	switch	.text
8436  185f               _adc2_init:
8440                     ; 2085 adc_plazma[0]++;
8442  185f beb9          	ldw	x,_adc_plazma
8443  1861 1c0001        	addw	x,#1
8444  1864 bfb9          	ldw	_adc_plazma,x
8445                     ; 2109 GPIOB->DDR&=~(1<<4);
8447  1866 72195007      	bres	20487,#4
8448                     ; 2110 GPIOB->CR1&=~(1<<4);
8450  186a 72195008      	bres	20488,#4
8451                     ; 2111 GPIOB->CR2&=~(1<<4);
8453  186e 72195009      	bres	20489,#4
8454                     ; 2113 GPIOB->DDR&=~(1<<5);
8456  1872 721b5007      	bres	20487,#5
8457                     ; 2114 GPIOB->CR1&=~(1<<5);
8459  1876 721b5008      	bres	20488,#5
8460                     ; 2115 GPIOB->CR2&=~(1<<5);
8462  187a 721b5009      	bres	20489,#5
8463                     ; 2117 GPIOB->DDR&=~(1<<6);
8465  187e 721d5007      	bres	20487,#6
8466                     ; 2118 GPIOB->CR1&=~(1<<6);
8468  1882 721d5008      	bres	20488,#6
8469                     ; 2119 GPIOB->CR2&=~(1<<6);
8471  1886 721d5009      	bres	20489,#6
8472                     ; 2121 GPIOB->DDR&=~(1<<7);
8474  188a 721f5007      	bres	20487,#7
8475                     ; 2122 GPIOB->CR1&=~(1<<7);
8477  188e 721f5008      	bres	20488,#7
8478                     ; 2123 GPIOB->CR2&=~(1<<7);
8480  1892 721f5009      	bres	20489,#7
8481                     ; 2125 GPIOB->DDR&=~(1<<2);
8483  1896 72155007      	bres	20487,#2
8484                     ; 2126 GPIOB->CR1&=~(1<<2);
8486  189a 72155008      	bres	20488,#2
8487                     ; 2127 GPIOB->CR2&=~(1<<2);
8489  189e 72155009      	bres	20489,#2
8490                     ; 2136 ADC2->TDRL=0xff;
8492  18a2 35ff5407      	mov	21511,#255
8493                     ; 2138 ADC2->CR2=0x08;
8495  18a6 35085402      	mov	21506,#8
8496                     ; 2139 ADC2->CR1=0x60;
8498  18aa 35605401      	mov	21505,#96
8499                     ; 2142 	if(adc_ch==5)ADC2->CSR=0x22;
8501  18ae b6c6          	ld	a,_adc_ch
8502  18b0 a105          	cp	a,#5
8503  18b2 2606          	jrne	L1453
8506  18b4 35225400      	mov	21504,#34
8508  18b8 2007          	jra	L3453
8509  18ba               L1453:
8510                     ; 2143 	else ADC2->CSR=0x20+adc_ch+3;
8512  18ba b6c6          	ld	a,_adc_ch
8513  18bc ab23          	add	a,#35
8514  18be c75400        	ld	21504,a
8515  18c1               L3453:
8516                     ; 2145 	ADC2->CR1|=1;
8518  18c1 72105401      	bset	21505,#0
8519                     ; 2146 	ADC2->CR1|=1;
8521  18c5 72105401      	bset	21505,#0
8522                     ; 2149 adc_plazma[1]=adc_ch;
8524  18c9 b6c6          	ld	a,_adc_ch
8525  18cb 5f            	clrw	x
8526  18cc 97            	ld	xl,a
8527  18cd bfbb          	ldw	_adc_plazma+2,x
8528                     ; 2150 }
8531  18cf 81            	ret
8567                     ; 2158 @far @interrupt void TIM4_UPD_Interrupt (void) 
8567                     ; 2159 {
8569                     	switch	.text
8570  18d0               f_TIM4_UPD_Interrupt:
8574                     ; 2160 TIM4->SR1&=~TIM4_SR1_UIF;
8576  18d0 72115342      	bres	21314,#0
8577                     ; 2162 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8579  18d4 3c12          	inc	_pwm_vent_cnt
8580  18d6 b612          	ld	a,_pwm_vent_cnt
8581  18d8 a10a          	cp	a,#10
8582  18da 2502          	jrult	L5553
8585  18dc 3f12          	clr	_pwm_vent_cnt
8586  18de               L5553:
8587                     ; 2163 GPIOB->ODR|=(1<<3);
8589  18de 72165005      	bset	20485,#3
8590                     ; 2164 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8592  18e2 b612          	ld	a,_pwm_vent_cnt
8593  18e4 a105          	cp	a,#5
8594  18e6 2504          	jrult	L7553
8597  18e8 72175005      	bres	20485,#3
8598  18ec               L7553:
8599                     ; 2168 if(++t0_cnt00>=10)
8601  18ec 9c            	rvf
8602  18ed ce0000        	ldw	x,_t0_cnt00
8603  18f0 1c0001        	addw	x,#1
8604  18f3 cf0000        	ldw	_t0_cnt00,x
8605  18f6 a3000a        	cpw	x,#10
8606  18f9 2f08          	jrslt	L1653
8607                     ; 2170 	t0_cnt00=0;
8609  18fb 5f            	clrw	x
8610  18fc cf0000        	ldw	_t0_cnt00,x
8611                     ; 2171 	b1000Hz=1;
8613  18ff 72100004      	bset	_b1000Hz
8614  1903               L1653:
8615                     ; 2174 if(++t0_cnt0>=100)
8617  1903 9c            	rvf
8618  1904 ce0002        	ldw	x,_t0_cnt0
8619  1907 1c0001        	addw	x,#1
8620  190a cf0002        	ldw	_t0_cnt0,x
8621  190d a30064        	cpw	x,#100
8622  1910 2f54          	jrslt	L3653
8623                     ; 2176 	t0_cnt0=0;
8625  1912 5f            	clrw	x
8626  1913 cf0002        	ldw	_t0_cnt0,x
8627                     ; 2177 	b100Hz=1;
8629  1916 72100009      	bset	_b100Hz
8630                     ; 2179 	if(++t0_cnt1>=10)
8632  191a 725c0004      	inc	_t0_cnt1
8633  191e c60004        	ld	a,_t0_cnt1
8634  1921 a10a          	cp	a,#10
8635  1923 2508          	jrult	L5653
8636                     ; 2181 		t0_cnt1=0;
8638  1925 725f0004      	clr	_t0_cnt1
8639                     ; 2182 		b10Hz=1;
8641  1929 72100008      	bset	_b10Hz
8642  192d               L5653:
8643                     ; 2185 	if(++t0_cnt2>=20)
8645  192d 725c0005      	inc	_t0_cnt2
8646  1931 c60005        	ld	a,_t0_cnt2
8647  1934 a114          	cp	a,#20
8648  1936 2508          	jrult	L7653
8649                     ; 2187 		t0_cnt2=0;
8651  1938 725f0005      	clr	_t0_cnt2
8652                     ; 2188 		b5Hz=1;
8654  193c 72100007      	bset	_b5Hz
8655  1940               L7653:
8656                     ; 2192 	if(++t0_cnt4>=50)
8658  1940 725c0007      	inc	_t0_cnt4
8659  1944 c60007        	ld	a,_t0_cnt4
8660  1947 a132          	cp	a,#50
8661  1949 2508          	jrult	L1753
8662                     ; 2194 		t0_cnt4=0;
8664  194b 725f0007      	clr	_t0_cnt4
8665                     ; 2195 		b2Hz=1;
8667  194f 72100006      	bset	_b2Hz
8668  1953               L1753:
8669                     ; 2198 	if(++t0_cnt3>=100)
8671  1953 725c0006      	inc	_t0_cnt3
8672  1957 c60006        	ld	a,_t0_cnt3
8673  195a a164          	cp	a,#100
8674  195c 2508          	jrult	L3653
8675                     ; 2200 		t0_cnt3=0;
8677  195e 725f0006      	clr	_t0_cnt3
8678                     ; 2201 		b1Hz=1;
8680  1962 72100005      	bset	_b1Hz
8681  1966               L3653:
8682                     ; 2207 }
8685  1966 80            	iret
8710                     ; 2210 @far @interrupt void CAN_RX_Interrupt (void) 
8710                     ; 2211 {
8711                     	switch	.text
8712  1967               f_CAN_RX_Interrupt:
8716                     ; 2213 CAN->PSR= 7;									// page 7 - read messsage
8718  1967 35075427      	mov	21543,#7
8719                     ; 2215 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8721  196b ae000e        	ldw	x,#14
8722  196e               L042:
8723  196e d65427        	ld	a,(21543,x)
8724  1971 e7c6          	ld	(_mess-1,x),a
8725  1973 5a            	decw	x
8726  1974 26f8          	jrne	L042
8727                     ; 2226 bCAN_RX=1;
8729  1976 35010004      	mov	_bCAN_RX,#1
8730                     ; 2227 CAN->RFR|=(1<<5);
8732  197a 721a5424      	bset	21540,#5
8733                     ; 2229 }
8736  197e 80            	iret
8759                     ; 2232 @far @interrupt void CAN_TX_Interrupt (void) 
8759                     ; 2233 {
8760                     	switch	.text
8761  197f               f_CAN_TX_Interrupt:
8765                     ; 2234 if((CAN->TSR)&(1<<0))
8767  197f c65422        	ld	a,21538
8768  1982 a501          	bcp	a,#1
8769  1984 2708          	jreq	L5163
8770                     ; 2236 	bTX_FREE=1;	
8772  1986 35010003      	mov	_bTX_FREE,#1
8773                     ; 2238 	CAN->TSR|=(1<<0);
8775  198a 72105422      	bset	21538,#0
8776  198e               L5163:
8777                     ; 2240 }
8780  198e 80            	iret
8860                     ; 2243 @far @interrupt void ADC2_EOC_Interrupt (void) {
8861                     	switch	.text
8862  198f               f_ADC2_EOC_Interrupt:
8864       0000000d      OFST:	set	13
8865  198f be00          	ldw	x,c_x
8866  1991 89            	pushw	x
8867  1992 be00          	ldw	x,c_y
8868  1994 89            	pushw	x
8869  1995 be02          	ldw	x,c_lreg+2
8870  1997 89            	pushw	x
8871  1998 be00          	ldw	x,c_lreg
8872  199a 89            	pushw	x
8873  199b 520d          	subw	sp,#13
8876                     ; 2248 adc_plazma[2]++;
8878  199d bebd          	ldw	x,_adc_plazma+4
8879  199f 1c0001        	addw	x,#1
8880  19a2 bfbd          	ldw	_adc_plazma+4,x
8881                     ; 2255 ADC2->CSR&=~(1<<7);
8883  19a4 721f5400      	bres	21504,#7
8884                     ; 2257 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8886  19a8 c65405        	ld	a,21509
8887  19ab b703          	ld	c_lreg+3,a
8888  19ad 3f02          	clr	c_lreg+2
8889  19af 3f01          	clr	c_lreg+1
8890  19b1 3f00          	clr	c_lreg
8891  19b3 96            	ldw	x,sp
8892  19b4 1c0001        	addw	x,#OFST-12
8893  19b7 cd0000        	call	c_rtol
8895  19ba c65404        	ld	a,21508
8896  19bd 5f            	clrw	x
8897  19be 97            	ld	xl,a
8898  19bf 90ae0100      	ldw	y,#256
8899  19c3 cd0000        	call	c_umul
8901  19c6 96            	ldw	x,sp
8902  19c7 1c0001        	addw	x,#OFST-12
8903  19ca cd0000        	call	c_ladd
8905  19cd 96            	ldw	x,sp
8906  19ce 1c000a        	addw	x,#OFST-3
8907  19d1 cd0000        	call	c_rtol
8909                     ; 2262 if(adr_drv_stat==1)
8911  19d4 b602          	ld	a,_adr_drv_stat
8912  19d6 a101          	cp	a,#1
8913  19d8 260b          	jrne	L5563
8914                     ; 2264 	adr_drv_stat=2;
8916  19da 35020002      	mov	_adr_drv_stat,#2
8917                     ; 2265 	adc_buff_[0]=temp_adc;
8919  19de 1e0c          	ldw	x,(OFST-1,sp)
8920  19e0 cf0107        	ldw	_adc_buff_,x
8922  19e3 2020          	jra	L7563
8923  19e5               L5563:
8924                     ; 2268 else if(adr_drv_stat==3)
8926  19e5 b602          	ld	a,_adr_drv_stat
8927  19e7 a103          	cp	a,#3
8928  19e9 260b          	jrne	L1663
8929                     ; 2270 	adr_drv_stat=4;
8931  19eb 35040002      	mov	_adr_drv_stat,#4
8932                     ; 2271 	adc_buff_[1]=temp_adc;
8934  19ef 1e0c          	ldw	x,(OFST-1,sp)
8935  19f1 cf0109        	ldw	_adc_buff_+2,x
8937  19f4 200f          	jra	L7563
8938  19f6               L1663:
8939                     ; 2274 else if(adr_drv_stat==5)
8941  19f6 b602          	ld	a,_adr_drv_stat
8942  19f8 a105          	cp	a,#5
8943  19fa 2609          	jrne	L7563
8944                     ; 2276 	adr_drv_stat=6;
8946  19fc 35060002      	mov	_adr_drv_stat,#6
8947                     ; 2277 	adc_buff_[9]=temp_adc;
8949  1a00 1e0c          	ldw	x,(OFST-1,sp)
8950  1a02 cf0119        	ldw	_adc_buff_+18,x
8951  1a05               L7563:
8952                     ; 2280 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8954  1a05 b6b7          	ld	a,_adc_cnt_cnt
8955  1a07 5f            	clrw	x
8956  1a08 97            	ld	xl,a
8957  1a09 58            	sllw	x
8958  1a0a 1f03          	ldw	(OFST-10,sp),x
8959  1a0c b6c6          	ld	a,_adc_ch
8960  1a0e 97            	ld	xl,a
8961  1a0f a610          	ld	a,#16
8962  1a11 42            	mul	x,a
8963  1a12 72fb03        	addw	x,(OFST-10,sp)
8964  1a15 160c          	ldw	y,(OFST-1,sp)
8965  1a17 df005e        	ldw	(_adc_buff_buff,x),y
8966                     ; 2282 adc_ch++;
8968  1a1a 3cc6          	inc	_adc_ch
8969                     ; 2283 if(adc_ch>=6)
8971  1a1c b6c6          	ld	a,_adc_ch
8972  1a1e a106          	cp	a,#6
8973  1a20 2516          	jrult	L7663
8974                     ; 2285 	adc_ch=0;
8976  1a22 3fc6          	clr	_adc_ch
8977                     ; 2286 	adc_cnt_cnt++;
8979  1a24 3cb7          	inc	_adc_cnt_cnt
8980                     ; 2287 	if(adc_cnt_cnt>=8)
8982  1a26 b6b7          	ld	a,_adc_cnt_cnt
8983  1a28 a108          	cp	a,#8
8984  1a2a 250c          	jrult	L7663
8985                     ; 2289 		adc_cnt_cnt=0;
8987  1a2c 3fb7          	clr	_adc_cnt_cnt
8988                     ; 2290 		adc_cnt++;
8990  1a2e 3cc5          	inc	_adc_cnt
8991                     ; 2291 		if(adc_cnt>=16)
8993  1a30 b6c5          	ld	a,_adc_cnt
8994  1a32 a110          	cp	a,#16
8995  1a34 2502          	jrult	L7663
8996                     ; 2293 			adc_cnt=0;
8998  1a36 3fc5          	clr	_adc_cnt
8999  1a38               L7663:
9000                     ; 2297 if(adc_cnt_cnt==0)
9002  1a38 3db7          	tnz	_adc_cnt_cnt
9003  1a3a 2660          	jrne	L5763
9004                     ; 2301 	tempSS=0;
9006  1a3c ae0000        	ldw	x,#0
9007  1a3f 1f07          	ldw	(OFST-6,sp),x
9008  1a41 ae0000        	ldw	x,#0
9009  1a44 1f05          	ldw	(OFST-8,sp),x
9010                     ; 2302 	for(i=0;i<8;i++)
9012  1a46 0f09          	clr	(OFST-4,sp)
9013  1a48               L7763:
9014                     ; 2304 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
9016  1a48 7b09          	ld	a,(OFST-4,sp)
9017  1a4a 5f            	clrw	x
9018  1a4b 97            	ld	xl,a
9019  1a4c 58            	sllw	x
9020  1a4d 1f03          	ldw	(OFST-10,sp),x
9021  1a4f b6c6          	ld	a,_adc_ch
9022  1a51 97            	ld	xl,a
9023  1a52 a610          	ld	a,#16
9024  1a54 42            	mul	x,a
9025  1a55 72fb03        	addw	x,(OFST-10,sp)
9026  1a58 de005e        	ldw	x,(_adc_buff_buff,x)
9027  1a5b cd0000        	call	c_itolx
9029  1a5e 96            	ldw	x,sp
9030  1a5f 1c0005        	addw	x,#OFST-8
9031  1a62 cd0000        	call	c_lgadd
9033                     ; 2302 	for(i=0;i<8;i++)
9035  1a65 0c09          	inc	(OFST-4,sp)
9038  1a67 7b09          	ld	a,(OFST-4,sp)
9039  1a69 a108          	cp	a,#8
9040  1a6b 25db          	jrult	L7763
9041                     ; 2306 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
9043  1a6d 96            	ldw	x,sp
9044  1a6e 1c0005        	addw	x,#OFST-8
9045  1a71 cd0000        	call	c_ltor
9047  1a74 a603          	ld	a,#3
9048  1a76 cd0000        	call	c_lrsh
9050  1a79 be02          	ldw	x,c_lreg+2
9051  1a7b b6c5          	ld	a,_adc_cnt
9052  1a7d 905f          	clrw	y
9053  1a7f 9097          	ld	yl,a
9054  1a81 9058          	sllw	y
9055  1a83 1703          	ldw	(OFST-10,sp),y
9056  1a85 b6c6          	ld	a,_adc_ch
9057  1a87 905f          	clrw	y
9058  1a89 9097          	ld	yl,a
9059  1a8b 9058          	sllw	y
9060  1a8d 9058          	sllw	y
9061  1a8f 9058          	sllw	y
9062  1a91 9058          	sllw	y
9063  1a93 9058          	sllw	y
9064  1a95 72f903        	addw	y,(OFST-10,sp)
9065  1a98 90df011b      	ldw	(_adc_buff,y),x
9066  1a9c               L5763:
9067                     ; 2310 if((adc_cnt&0x03)==0)
9069  1a9c b6c5          	ld	a,_adc_cnt
9070  1a9e a503          	bcp	a,#3
9071  1aa0 264b          	jrne	L5073
9072                     ; 2314 	tempSS=0;
9074  1aa2 ae0000        	ldw	x,#0
9075  1aa5 1f07          	ldw	(OFST-6,sp),x
9076  1aa7 ae0000        	ldw	x,#0
9077  1aaa 1f05          	ldw	(OFST-8,sp),x
9078                     ; 2315 	for(i=0;i<16;i++)
9080  1aac 0f09          	clr	(OFST-4,sp)
9081  1aae               L7073:
9082                     ; 2317 		tempSS+=(signed long)adc_buff[adc_ch][i];
9084  1aae 7b09          	ld	a,(OFST-4,sp)
9085  1ab0 5f            	clrw	x
9086  1ab1 97            	ld	xl,a
9087  1ab2 58            	sllw	x
9088  1ab3 1f03          	ldw	(OFST-10,sp),x
9089  1ab5 b6c6          	ld	a,_adc_ch
9090  1ab7 97            	ld	xl,a
9091  1ab8 a620          	ld	a,#32
9092  1aba 42            	mul	x,a
9093  1abb 72fb03        	addw	x,(OFST-10,sp)
9094  1abe de011b        	ldw	x,(_adc_buff,x)
9095  1ac1 cd0000        	call	c_itolx
9097  1ac4 96            	ldw	x,sp
9098  1ac5 1c0005        	addw	x,#OFST-8
9099  1ac8 cd0000        	call	c_lgadd
9101                     ; 2315 	for(i=0;i<16;i++)
9103  1acb 0c09          	inc	(OFST-4,sp)
9106  1acd 7b09          	ld	a,(OFST-4,sp)
9107  1acf a110          	cp	a,#16
9108  1ad1 25db          	jrult	L7073
9109                     ; 2319 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9111  1ad3 96            	ldw	x,sp
9112  1ad4 1c0005        	addw	x,#OFST-8
9113  1ad7 cd0000        	call	c_ltor
9115  1ada a604          	ld	a,#4
9116  1adc cd0000        	call	c_lrsh
9118  1adf be02          	ldw	x,c_lreg+2
9119  1ae1 b6c6          	ld	a,_adc_ch
9120  1ae3 905f          	clrw	y
9121  1ae5 9097          	ld	yl,a
9122  1ae7 9058          	sllw	y
9123  1ae9 90df0107      	ldw	(_adc_buff_,y),x
9124  1aed               L5073:
9125                     ; 2326 if(adc_ch==0)adc_buff_5=temp_adc;
9127  1aed 3dc6          	tnz	_adc_ch
9128  1aef 2605          	jrne	L5173
9131  1af1 1e0c          	ldw	x,(OFST-1,sp)
9132  1af3 cf0105        	ldw	_adc_buff_5,x
9133  1af6               L5173:
9134                     ; 2327 if(adc_ch==2)adc_buff_1=temp_adc;
9136  1af6 b6c6          	ld	a,_adc_ch
9137  1af8 a102          	cp	a,#2
9138  1afa 2605          	jrne	L7173
9141  1afc 1e0c          	ldw	x,(OFST-1,sp)
9142  1afe cf0103        	ldw	_adc_buff_1,x
9143  1b01               L7173:
9144                     ; 2329 adc_plazma_short++;
9146  1b01 bec3          	ldw	x,_adc_plazma_short
9147  1b03 1c0001        	addw	x,#1
9148  1b06 bfc3          	ldw	_adc_plazma_short,x
9149                     ; 2331 }
9152  1b08 5b0d          	addw	sp,#13
9153  1b0a 85            	popw	x
9154  1b0b bf00          	ldw	c_lreg,x
9155  1b0d 85            	popw	x
9156  1b0e bf02          	ldw	c_lreg+2,x
9157  1b10 85            	popw	x
9158  1b11 bf00          	ldw	c_y,x
9159  1b13 85            	popw	x
9160  1b14 bf00          	ldw	c_x,x
9161  1b16 80            	iret
9220                     ; 2340 main()
9220                     ; 2341 {
9222                     	switch	.text
9223  1b17               _main:
9227                     ; 2343 CLK->ECKR|=1;
9229  1b17 721050c1      	bset	20673,#0
9231  1b1b               L3373:
9232                     ; 2344 while((CLK->ECKR & 2) == 0);
9234  1b1b c650c1        	ld	a,20673
9235  1b1e a502          	bcp	a,#2
9236  1b20 27f9          	jreq	L3373
9237                     ; 2345 CLK->SWCR|=2;
9239  1b22 721250c5      	bset	20677,#1
9240                     ; 2346 CLK->SWR=0xB4;
9242  1b26 35b450c4      	mov	20676,#180
9243                     ; 2348 delay_ms(200);
9245  1b2a ae00c8        	ldw	x,#200
9246  1b2d cd0121        	call	_delay_ms
9248                     ; 2349 FLASH_DUKR=0xae;
9250  1b30 35ae5064      	mov	_FLASH_DUKR,#174
9251                     ; 2350 FLASH_DUKR=0x56;
9253  1b34 35565064      	mov	_FLASH_DUKR,#86
9254                     ; 2351 enableInterrupts();
9257  1b38 9a            rim
9259                     ; 2354 adr_drv_v3();
9262  1b39 cd0e17        	call	_adr_drv_v3
9264                     ; 2358 t4_init();
9266  1b3c cd1811        	call	_t4_init
9268                     ; 2360 		GPIOG->DDR|=(1<<0);
9270  1b3f 72105020      	bset	20512,#0
9271                     ; 2361 		GPIOG->CR1|=(1<<0);
9273  1b43 72105021      	bset	20513,#0
9274                     ; 2362 		GPIOG->CR2&=~(1<<0);	
9276  1b47 72115022      	bres	20514,#0
9277                     ; 2365 		GPIOG->DDR&=~(1<<1);
9279  1b4b 72135020      	bres	20512,#1
9280                     ; 2366 		GPIOG->CR1|=(1<<1);
9282  1b4f 72125021      	bset	20513,#1
9283                     ; 2367 		GPIOG->CR2&=~(1<<1);
9285  1b53 72135022      	bres	20514,#1
9286                     ; 2369 init_CAN();
9288  1b57 cd1007        	call	_init_CAN
9290                     ; 2374 GPIOC->DDR|=(1<<1);
9292  1b5a 7212500c      	bset	20492,#1
9293                     ; 2375 GPIOC->CR1|=(1<<1);
9295  1b5e 7212500d      	bset	20493,#1
9296                     ; 2376 GPIOC->CR2|=(1<<1);
9298  1b62 7212500e      	bset	20494,#1
9299                     ; 2378 GPIOC->DDR|=(1<<2);
9301  1b66 7214500c      	bset	20492,#2
9302                     ; 2379 GPIOC->CR1|=(1<<2);
9304  1b6a 7214500d      	bset	20493,#2
9305                     ; 2380 GPIOC->CR2|=(1<<2);
9307  1b6e 7214500e      	bset	20494,#2
9308                     ; 2387 t1_init();
9310  1b72 cd1822        	call	_t1_init
9312                     ; 2389 GPIOA->DDR|=(1<<5);
9314  1b75 721a5002      	bset	20482,#5
9315                     ; 2390 GPIOA->CR1|=(1<<5);
9317  1b79 721a5003      	bset	20483,#5
9318                     ; 2391 GPIOA->CR2&=~(1<<5);
9320  1b7d 721b5004      	bres	20484,#5
9321                     ; 2397 GPIOB->DDR&=~(1<<3);
9323  1b81 72175007      	bres	20487,#3
9324                     ; 2398 GPIOB->CR1&=~(1<<3);
9326  1b85 72175008      	bres	20488,#3
9327                     ; 2399 GPIOB->CR2&=~(1<<3);
9329  1b89 72175009      	bres	20489,#3
9330                     ; 2401 GPIOC->DDR|=(1<<3);
9332  1b8d 7216500c      	bset	20492,#3
9333                     ; 2402 GPIOC->CR1|=(1<<3);
9335  1b91 7216500d      	bset	20493,#3
9336                     ; 2403 GPIOC->CR2|=(1<<3);
9338  1b95 7216500e      	bset	20494,#3
9339  1b99               L7373:
9340                     ; 2409 	if(b1000Hz)
9342                     	btst	_b1000Hz
9343  1b9e 2407          	jruge	L3473
9344                     ; 2411 		b1000Hz=0;
9346  1ba0 72110004      	bres	_b1000Hz
9347                     ; 2413 		adc2_init();
9349  1ba4 cd185f        	call	_adc2_init
9351  1ba7               L3473:
9352                     ; 2416 	if(bCAN_RX)
9354  1ba7 3d04          	tnz	_bCAN_RX
9355  1ba9 2705          	jreq	L5473
9356                     ; 2418 		bCAN_RX=0;
9358  1bab 3f04          	clr	_bCAN_RX
9359                     ; 2419 		can_in_an();	
9361  1bad cd1164        	call	_can_in_an
9363  1bb0               L5473:
9364                     ; 2421 	if(b100Hz)
9366                     	btst	_b100Hz
9367  1bb5 2407          	jruge	L7473
9368                     ; 2423 		b100Hz=0;
9370  1bb7 72110009      	bres	_b100Hz
9371                     ; 2433 		can_tx_hndl();
9373  1bbb cd10fa        	call	_can_tx_hndl
9375  1bbe               L7473:
9376                     ; 2436 	if(b10Hz)
9378                     	btst	_b10Hz
9379  1bc3 2425          	jruge	L1573
9380                     ; 2438 		b10Hz=0;
9382  1bc5 72110008      	bres	_b10Hz
9383                     ; 2440 		matemat();
9385  1bc9 cd0939        	call	_matemat
9387                     ; 2441 		led_drv(); 
9389  1bcc cd03ee        	call	_led_drv
9391                     ; 2442 	  link_drv();
9393  1bcf cd04dc        	call	_link_drv
9395                     ; 2444 	  JP_drv();
9397  1bd2 cd0451        	call	_JP_drv
9399                     ; 2445 	  flags_drv();
9401  1bd5 cd0dcc        	call	_flags_drv
9403                     ; 2447 		if(main_cnt10<100)main_cnt10++;
9405  1bd8 9c            	rvf
9406  1bd9 ce025b        	ldw	x,_main_cnt10
9407  1bdc a30064        	cpw	x,#100
9408  1bdf 2e09          	jrsge	L1573
9411  1be1 ce025b        	ldw	x,_main_cnt10
9412  1be4 1c0001        	addw	x,#1
9413  1be7 cf025b        	ldw	_main_cnt10,x
9414  1bea               L1573:
9415                     ; 2450 	if(b5Hz)
9417                     	btst	_b5Hz
9418  1bef 241c          	jruge	L5573
9419                     ; 2452 		b5Hz=0;
9421  1bf1 72110007      	bres	_b5Hz
9422                     ; 2458 		pwr_drv();		//воздействие на силу
9424  1bf5 cd06ac        	call	_pwr_drv
9426                     ; 2459 		led_hndl();
9428  1bf8 cd0163        	call	_led_hndl
9430                     ; 2461 		vent_drv();
9432  1bfb cd0534        	call	_vent_drv
9434                     ; 2463 		if(main_cnt1<1000)main_cnt1++;
9436  1bfe 9c            	rvf
9437  1bff be5b          	ldw	x,_main_cnt1
9438  1c01 a303e8        	cpw	x,#1000
9439  1c04 2e07          	jrsge	L5573
9442  1c06 be5b          	ldw	x,_main_cnt1
9443  1c08 1c0001        	addw	x,#1
9444  1c0b bf5b          	ldw	_main_cnt1,x
9445  1c0d               L5573:
9446                     ; 2466 	if(b2Hz)
9448                     	btst	_b2Hz
9449  1c12 2404          	jruge	L1673
9450                     ; 2468 		b2Hz=0;
9452  1c14 72110006      	bres	_b2Hz
9453  1c18               L1673:
9454                     ; 2477 	if(b1Hz)
9456                     	btst	_b1Hz
9457  1c1d 2503cc1b99    	jruge	L7373
9458                     ; 2479 		b1Hz=0;
9460  1c22 72110005      	bres	_b1Hz
9461                     ; 2481 	  pwr_hndl();		//вычисление воздействий на силу
9463  1c26 cd07e6        	call	_pwr_hndl
9465                     ; 2482 		temper_drv();			//вычисление аварий температуры
9467  1c29 cd0b39        	call	_temper_drv
9469                     ; 2483 		u_drv();
9471  1c2c cd0c10        	call	_u_drv
9473                     ; 2485 		if(main_cnt<1000)main_cnt++;
9475  1c2f 9c            	rvf
9476  1c30 ce025d        	ldw	x,_main_cnt
9477  1c33 a303e8        	cpw	x,#1000
9478  1c36 2e09          	jrsge	L5673
9481  1c38 ce025d        	ldw	x,_main_cnt
9482  1c3b 1c0001        	addw	x,#1
9483  1c3e cf025d        	ldw	_main_cnt,x
9484  1c41               L5673:
9485                     ; 2486   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9487  1c41 b66d          	ld	a,_link
9488  1c43 a1aa          	cp	a,#170
9489  1c45 2706          	jreq	L1773
9491  1c47 b654          	ld	a,_jp_mode
9492  1c49 a103          	cp	a,#3
9493  1c4b 2603          	jrne	L7673
9494  1c4d               L1773:
9497  1c4d cd0d2d        	call	_apv_hndl
9499  1c50               L7673:
9500                     ; 2489   		can_error_cnt++;
9502  1c50 3c73          	inc	_can_error_cnt
9503                     ; 2490   		if(can_error_cnt>=10)
9505  1c52 b673          	ld	a,_can_error_cnt
9506  1c54 a10a          	cp	a,#10
9507  1c56 2505          	jrult	L3773
9508                     ; 2492   			can_error_cnt=0;
9510  1c58 3f73          	clr	_can_error_cnt
9511                     ; 2493 				init_CAN();
9513  1c5a cd1007        	call	_init_CAN
9515  1c5d               L3773:
9516                     ; 2503 		vent_resurs_hndl();
9518  1c5d cd0000        	call	_vent_resurs_hndl
9520                     ; 2504 		alfa_hndl();
9522  1c60 cd0724        	call	_alfa_hndl
9524  1c63 ac991b99      	jpf	L7373
10799                     	xdef	_main
10800                     	xdef	f_ADC2_EOC_Interrupt
10801                     	xdef	f_CAN_TX_Interrupt
10802                     	xdef	f_CAN_RX_Interrupt
10803                     	xdef	f_TIM4_UPD_Interrupt
10804                     	xdef	_adc2_init
10805                     	xdef	_t1_init
10806                     	xdef	_t4_init
10807                     	xdef	_can_in_an
10808                     	xdef	_can_tx_hndl
10809                     	xdef	_can_transmit
10810                     	xdef	_init_CAN
10811                     	xdef	_adr_drv_v3
10812                     	xdef	_adr_drv_v4
10813                     	xdef	_flags_drv
10814                     	xdef	_apv_hndl
10815                     	xdef	_apv_stop
10816                     	xdef	_apv_start
10817                     	xdef	_u_drv
10818                     	xdef	_temper_drv
10819                     	xdef	_matemat
10820                     	xdef	_pwr_hndl
10821                     	xdef	_alfa_hndl
10822                     	xdef	_pwr_drv
10823                     	xdef	_vent_drv
10824                     	xdef	_link_drv
10825                     	xdef	_JP_drv
10826                     	xdef	_led_drv
10827                     	xdef	_led_hndl
10828                     	xdef	_delay_ms
10829                     	xdef	_granee
10830                     	xdef	_gran
10831                     	xdef	_vent_resurs_hndl
10832                     	switch	.bss
10833  0000               _alfa_pwm_max_i_cnt__:
10834  0000 0000          	ds.b	2
10835                     	xdef	_alfa_pwm_max_i_cnt__
10836  0002               _alfa_pwm_max_i_cnt:
10837  0002 0000          	ds.b	2
10838                     	xdef	_alfa_pwm_max_i_cnt
10839  0004               _alfa_pwm_max_i:
10840  0004 0000          	ds.b	2
10841                     	xdef	_alfa_pwm_max_i
10842  0006               _alfa_pwm_max_t:
10843  0006 0000          	ds.b	2
10844                     	xdef	_alfa_pwm_max_t
10845                     	switch	.ubsct
10846  0001               _debug_info_to_uku:
10847  0001 000000000000  	ds.b	6
10848                     	xdef	_debug_info_to_uku
10849  0007               _pwm_u_cnt:
10850  0007 00            	ds.b	1
10851                     	xdef	_pwm_u_cnt
10852  0008               _vent_resurs_tx_cnt:
10853  0008 00            	ds.b	1
10854                     	xdef	_vent_resurs_tx_cnt
10855                     	switch	.bss
10856  0008               _vent_resurs_buff:
10857  0008 00000000      	ds.b	4
10858                     	xdef	_vent_resurs_buff
10859                     	switch	.ubsct
10860  0009               _vent_resurs_sec_cnt:
10861  0009 0000          	ds.b	2
10862                     	xdef	_vent_resurs_sec_cnt
10863                     .eeprom:	section	.data
10864  0000               _vent_resurs:
10865  0000 0000          	ds.b	2
10866                     	xdef	_vent_resurs
10867  0002               _ee_IMAXVENT:
10868  0002 0000          	ds.b	2
10869                     	xdef	_ee_IMAXVENT
10870                     	switch	.ubsct
10871  000b               _bps_class:
10872  000b 00            	ds.b	1
10873                     	xdef	_bps_class
10874  000c               _vent_pwm_integr_cnt:
10875  000c 0000          	ds.b	2
10876                     	xdef	_vent_pwm_integr_cnt
10877  000e               _vent_pwm_integr:
10878  000e 0000          	ds.b	2
10879                     	xdef	_vent_pwm_integr
10880  0010               _vent_pwm:
10881  0010 0000          	ds.b	2
10882                     	xdef	_vent_pwm
10883  0012               _pwm_vent_cnt:
10884  0012 00            	ds.b	1
10885                     	xdef	_pwm_vent_cnt
10886                     	switch	.eeprom
10887  0004               _ee_DEVICE:
10888  0004 0000          	ds.b	2
10889                     	xdef	_ee_DEVICE
10890  0006               _ee_AVT_MODE:
10891  0006 0000          	ds.b	2
10892                     	xdef	_ee_AVT_MODE
10893                     	switch	.ubsct
10894  0013               _i_main_bps_cnt:
10895  0013 000000000000  	ds.b	6
10896                     	xdef	_i_main_bps_cnt
10897  0019               _i_main_sigma:
10898  0019 0000          	ds.b	2
10899                     	xdef	_i_main_sigma
10900  001b               _i_main_num_of_bps:
10901  001b 00            	ds.b	1
10902                     	xdef	_i_main_num_of_bps
10903  001c               _i_main_avg:
10904  001c 0000          	ds.b	2
10905                     	xdef	_i_main_avg
10906  001e               _i_main_flag:
10907  001e 000000000000  	ds.b	6
10908                     	xdef	_i_main_flag
10909  0024               _i_main:
10910  0024 000000000000  	ds.b	12
10911                     	xdef	_i_main
10912  0030               _x:
10913  0030 000000000000  	ds.b	12
10914                     	xdef	_x
10915                     	xdef	_volum_u_main_
10916                     	switch	.eeprom
10917  0008               _UU_AVT:
10918  0008 0000          	ds.b	2
10919                     	xdef	_UU_AVT
10920                     	switch	.ubsct
10921  003c               _cnt_net_drv:
10922  003c 00            	ds.b	1
10923                     	xdef	_cnt_net_drv
10924                     	switch	.bit
10925  0001               _bMAIN:
10926  0001 00            	ds.b	1
10927                     	xdef	_bMAIN
10928                     	switch	.ubsct
10929  003d               _plazma_int:
10930  003d 000000000000  	ds.b	6
10931                     	xdef	_plazma_int
10932                     	xdef	_rotor_int
10933  0043               _led_green_buff:
10934  0043 00000000      	ds.b	4
10935                     	xdef	_led_green_buff
10936  0047               _led_red_buff:
10937  0047 00000000      	ds.b	4
10938                     	xdef	_led_red_buff
10939                     	xdef	_led_drv_cnt
10940                     	xdef	_led_green
10941                     	xdef	_led_red
10942  004b               _res_fl_cnt:
10943  004b 00            	ds.b	1
10944                     	xdef	_res_fl_cnt
10945                     	xdef	_bRES_
10946                     	xdef	_bRES
10947                     	switch	.eeprom
10948  000a               _res_fl_:
10949  000a 00            	ds.b	1
10950                     	xdef	_res_fl_
10951  000b               _res_fl:
10952  000b 00            	ds.b	1
10953                     	xdef	_res_fl
10954                     	switch	.ubsct
10955  004c               _cnt_apv_off:
10956  004c 00            	ds.b	1
10957                     	xdef	_cnt_apv_off
10958                     	switch	.bit
10959  0002               _bAPV:
10960  0002 00            	ds.b	1
10961                     	xdef	_bAPV
10962                     	switch	.ubsct
10963  004d               _apv_cnt_:
10964  004d 0000          	ds.b	2
10965                     	xdef	_apv_cnt_
10966  004f               _apv_cnt:
10967  004f 000000        	ds.b	3
10968                     	xdef	_apv_cnt
10969                     	xdef	_bBL_IPS
10970                     	switch	.bit
10971  0003               _bBL:
10972  0003 00            	ds.b	1
10973                     	xdef	_bBL
10974                     	switch	.ubsct
10975  0052               _cnt_JP1:
10976  0052 00            	ds.b	1
10977                     	xdef	_cnt_JP1
10978  0053               _cnt_JP0:
10979  0053 00            	ds.b	1
10980                     	xdef	_cnt_JP0
10981  0054               _jp_mode:
10982  0054 00            	ds.b	1
10983                     	xdef	_jp_mode
10984  0055               _pwm_u_:
10985  0055 0000          	ds.b	2
10986                     	xdef	_pwm_u_
10987                     	xdef	_pwm_i
10988                     	xdef	_pwm_u
10989  0057               _tmax_cnt:
10990  0057 0000          	ds.b	2
10991                     	xdef	_tmax_cnt
10992  0059               _tsign_cnt:
10993  0059 0000          	ds.b	2
10994                     	xdef	_tsign_cnt
10995                     	switch	.eeprom
10996  000c               _ee_UAVT:
10997  000c 0000          	ds.b	2
10998                     	xdef	_ee_UAVT
10999  000e               _ee_tsign:
11000  000e 0000          	ds.b	2
11001                     	xdef	_ee_tsign
11002  0010               _ee_tmax:
11003  0010 0000          	ds.b	2
11004                     	xdef	_ee_tmax
11005  0012               _ee_dU:
11006  0012 0000          	ds.b	2
11007                     	xdef	_ee_dU
11008  0014               _ee_Umax:
11009  0014 0000          	ds.b	2
11010                     	xdef	_ee_Umax
11011  0016               _ee_TZAS:
11012  0016 0000          	ds.b	2
11013                     	xdef	_ee_TZAS
11014                     	switch	.ubsct
11015  005b               _main_cnt1:
11016  005b 0000          	ds.b	2
11017                     	xdef	_main_cnt1
11018  005d               _off_bp_cnt:
11019  005d 00            	ds.b	1
11020                     	xdef	_off_bp_cnt
11021                     	xdef	_vol_i_temp_avar
11022  005e               _flags_tu_cnt_off:
11023  005e 00            	ds.b	1
11024                     	xdef	_flags_tu_cnt_off
11025  005f               _flags_tu_cnt_on:
11026  005f 00            	ds.b	1
11027                     	xdef	_flags_tu_cnt_on
11028  0060               _vol_i_temp:
11029  0060 0000          	ds.b	2
11030                     	xdef	_vol_i_temp
11031  0062               _vol_u_temp:
11032  0062 0000          	ds.b	2
11033                     	xdef	_vol_u_temp
11034                     	switch	.eeprom
11035  0018               __x_ee_:
11036  0018 0000          	ds.b	2
11037                     	xdef	__x_ee_
11038                     	switch	.ubsct
11039  0064               __x_cnt:
11040  0064 0000          	ds.b	2
11041                     	xdef	__x_cnt
11042  0066               __x__:
11043  0066 0000          	ds.b	2
11044                     	xdef	__x__
11045  0068               __x_:
11046  0068 0000          	ds.b	2
11047                     	xdef	__x_
11048  006a               _flags_tu:
11049  006a 00            	ds.b	1
11050                     	xdef	_flags_tu
11051                     	xdef	_flags
11052  006b               _link_cnt:
11053  006b 0000          	ds.b	2
11054                     	xdef	_link_cnt
11055  006d               _link:
11056  006d 00            	ds.b	1
11057                     	xdef	_link
11058  006e               _umin_cnt:
11059  006e 0000          	ds.b	2
11060                     	xdef	_umin_cnt
11061  0070               _umax_cnt:
11062  0070 0000          	ds.b	2
11063                     	xdef	_umax_cnt
11064                     	switch	.eeprom
11065  001a               _ee_K:
11066  001a 000000000000  	ds.b	20
11067                     	xdef	_ee_K
11068                     	switch	.ubsct
11069  0072               _T:
11070  0072 00            	ds.b	1
11071                     	xdef	_T
11072                     	switch	.bss
11073  000c               _Uin:
11074  000c 0000          	ds.b	2
11075                     	xdef	_Uin
11076  000e               _Usum:
11077  000e 0000          	ds.b	2
11078                     	xdef	_Usum
11079  0010               _U_out_const:
11080  0010 0000          	ds.b	2
11081                     	xdef	_U_out_const
11082  0012               _Unecc:
11083  0012 0000          	ds.b	2
11084                     	xdef	_Unecc
11085  0014               _Ui:
11086  0014 0000          	ds.b	2
11087                     	xdef	_Ui
11088  0016               _Un:
11089  0016 0000          	ds.b	2
11090                     	xdef	_Un
11091  0018               _I:
11092  0018 0000          	ds.b	2
11093                     	xdef	_I
11094                     	switch	.ubsct
11095  0073               _can_error_cnt:
11096  0073 00            	ds.b	1
11097                     	xdef	_can_error_cnt
11098                     	xdef	_bCAN_RX
11099  0074               _tx_busy_cnt:
11100  0074 00            	ds.b	1
11101                     	xdef	_tx_busy_cnt
11102                     	xdef	_bTX_FREE
11103  0075               _can_buff_rd_ptr:
11104  0075 00            	ds.b	1
11105                     	xdef	_can_buff_rd_ptr
11106  0076               _can_buff_wr_ptr:
11107  0076 00            	ds.b	1
11108                     	xdef	_can_buff_wr_ptr
11109  0077               _can_out_buff:
11110  0077 000000000000  	ds.b	64
11111                     	xdef	_can_out_buff
11112                     	switch	.bss
11113  001a               _pwm_u_buff_cnt:
11114  001a 00            	ds.b	1
11115                     	xdef	_pwm_u_buff_cnt
11116  001b               _pwm_u_buff_ptr:
11117  001b 00            	ds.b	1
11118                     	xdef	_pwm_u_buff_ptr
11119  001c               _pwm_u_buff_:
11120  001c 0000          	ds.b	2
11121                     	xdef	_pwm_u_buff_
11122  001e               _pwm_u_buff:
11123  001e 000000000000  	ds.b	64
11124                     	xdef	_pwm_u_buff
11125                     	switch	.ubsct
11126  00b7               _adc_cnt_cnt:
11127  00b7 00            	ds.b	1
11128                     	xdef	_adc_cnt_cnt
11129                     	switch	.bss
11130  005e               _adc_buff_buff:
11131  005e 000000000000  	ds.b	160
11132                     	xdef	_adc_buff_buff
11133  00fe               _adress_error:
11134  00fe 00            	ds.b	1
11135                     	xdef	_adress_error
11136  00ff               _adress:
11137  00ff 00            	ds.b	1
11138                     	xdef	_adress
11139  0100               _adr:
11140  0100 000000        	ds.b	3
11141                     	xdef	_adr
11142                     	xdef	_adr_drv_stat
11143                     	xdef	_led_ind
11144                     	switch	.ubsct
11145  00b8               _led_ind_cnt:
11146  00b8 00            	ds.b	1
11147                     	xdef	_led_ind_cnt
11148  00b9               _adc_plazma:
11149  00b9 000000000000  	ds.b	10
11150                     	xdef	_adc_plazma
11151  00c3               _adc_plazma_short:
11152  00c3 0000          	ds.b	2
11153                     	xdef	_adc_plazma_short
11154  00c5               _adc_cnt:
11155  00c5 00            	ds.b	1
11156                     	xdef	_adc_cnt
11157  00c6               _adc_ch:
11158  00c6 00            	ds.b	1
11159                     	xdef	_adc_ch
11160                     	switch	.bss
11161  0103               _adc_buff_1:
11162  0103 0000          	ds.b	2
11163                     	xdef	_adc_buff_1
11164  0105               _adc_buff_5:
11165  0105 0000          	ds.b	2
11166                     	xdef	_adc_buff_5
11167  0107               _adc_buff_:
11168  0107 000000000000  	ds.b	20
11169                     	xdef	_adc_buff_
11170  011b               _adc_buff:
11171  011b 000000000000  	ds.b	320
11172                     	xdef	_adc_buff
11173  025b               _main_cnt10:
11174  025b 0000          	ds.b	2
11175                     	xdef	_main_cnt10
11176  025d               _main_cnt:
11177  025d 0000          	ds.b	2
11178                     	xdef	_main_cnt
11179                     	switch	.ubsct
11180  00c7               _mess:
11181  00c7 000000000000  	ds.b	14
11182                     	xdef	_mess
11183                     	switch	.bit
11184  0004               _b1000Hz:
11185  0004 00            	ds.b	1
11186                     	xdef	_b1000Hz
11187  0005               _b1Hz:
11188  0005 00            	ds.b	1
11189                     	xdef	_b1Hz
11190  0006               _b2Hz:
11191  0006 00            	ds.b	1
11192                     	xdef	_b2Hz
11193  0007               _b5Hz:
11194  0007 00            	ds.b	1
11195                     	xdef	_b5Hz
11196  0008               _b10Hz:
11197  0008 00            	ds.b	1
11198                     	xdef	_b10Hz
11199  0009               _b100Hz:
11200  0009 00            	ds.b	1
11201                     	xdef	_b100Hz
11202                     	xdef	_t0_cnt4
11203                     	xdef	_t0_cnt3
11204                     	xdef	_t0_cnt2
11205                     	xdef	_t0_cnt1
11206                     	xdef	_t0_cnt0
11207                     	xdef	_t0_cnt00
11208                     	xref	_abs
11209                     	xdef	_bVENT_BLOCK
11210                     	xref.b	c_lreg
11211                     	xref.b	c_x
11212                     	xref.b	c_y
11232                     	xref	c_lrsh
11233                     	xref	c_umul
11234                     	xref	c_lgsub
11235                     	xref	c_lgrsh
11236                     	xref	c_lgadd
11237                     	xref	c_idiv
11238                     	xref	c_sdivx
11239                     	xref	c_imul
11240                     	xref	c_lsbc
11241                     	xref	c_ladd
11242                     	xref	c_lsub
11243                     	xref	c_ldiv
11244                     	xref	c_lgmul
11245                     	xref	c_itolx
11246                     	xref	c_eewrc
11247                     	xref	c_ltor
11248                     	xref	c_lgadc
11249                     	xref	c_rtol
11250                     	xref	c_vmul
11251                     	xref	c_eewrw
11252                     	xref	c_lcmp
11253                     	xref	c_uitolx
11254                     	end
