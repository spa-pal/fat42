   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _bVENT_BLOCK:
  17  0000 00            	dc.b	0
2175                     	bsct
2176  0001               _t0_cnt0:
2177  0001 0000          	dc.w	0
2178  0003               _t0_cnt1:
2179  0003 00            	dc.b	0
2180  0004               _t0_cnt2:
2181  0004 00            	dc.b	0
2182  0005               _t0_cnt3:
2183  0005 00            	dc.b	0
2184  0006               _t0_cnt4:
2185  0006 00            	dc.b	0
2186  0007               _led_ind:
2187  0007 05            	dc.b	5
2188  0008               _adr_drv_stat:
2189  0008 00            	dc.b	0
2190  0009               _bTX_FREE:
2191  0009 01            	dc.b	1
2192  000a               _bCAN_RX:
2193  000a 00            	dc.b	0
2194  000b               _flags:
2195  000b 00            	dc.b	0
2196  000c               _pwm_u:
2197  000c 00c8          	dc.w	200
2198  000e               _pwm_i:
2199  000e 0032          	dc.w	50
2200                     .bit:	section	.data,bit
2201  0000               _bBL_IPS:
2202  0000 00            	dc.b	0
2203                     	bsct
2204  0010               _bRES:
2205  0010 00            	dc.b	0
2206  0011               _bRES_:
2207  0011 00            	dc.b	0
2208  0012               _led_red:
2209  0012 00000000      	dc.l	0
2210  0016               _led_green:
2211  0016 03030303      	dc.l	50529027
2212  001a               _led_drv_cnt:
2213  001a 1e            	dc.b	30
2214  001b               _rotor_int:
2215  001b 007b          	dc.w	123
2216  001d               _volum_u_main_:
2217  001d 02bc          	dc.w	700
2276                     ; 164 void gran(signed short *adr, signed short min, signed short max)
2276                     ; 165 {
2278                     	switch	.text
2279  0000               _gran:
2281  0000 89            	pushw	x
2282       00000000      OFST:	set	0
2285                     ; 166 if (*adr<min) *adr=min;
2287  0001 9c            	rvf
2288  0002 9093          	ldw	y,x
2289  0004 51            	exgw	x,y
2290  0005 fe            	ldw	x,(x)
2291  0006 1305          	cpw	x,(OFST+5,sp)
2292  0008 51            	exgw	x,y
2293  0009 2e03          	jrsge	L7541
2296  000b 1605          	ldw	y,(OFST+5,sp)
2297  000d ff            	ldw	(x),y
2298  000e               L7541:
2299                     ; 167 if (*adr>max) *adr=max; 
2301  000e 9c            	rvf
2302  000f 1e01          	ldw	x,(OFST+1,sp)
2303  0011 9093          	ldw	y,x
2304  0013 51            	exgw	x,y
2305  0014 fe            	ldw	x,(x)
2306  0015 1307          	cpw	x,(OFST+7,sp)
2307  0017 51            	exgw	x,y
2308  0018 2d05          	jrsle	L1641
2311  001a 1e01          	ldw	x,(OFST+1,sp)
2312  001c 1607          	ldw	y,(OFST+7,sp)
2313  001e ff            	ldw	(x),y
2314  001f               L1641:
2315                     ; 168 } 
2318  001f 85            	popw	x
2319  0020 81            	ret
2372                     ; 171 void granee(@eeprom signed short *adr, signed short min, signed short max)
2372                     ; 172 {
2373                     	switch	.text
2374  0021               _granee:
2376  0021 89            	pushw	x
2377       00000000      OFST:	set	0
2380                     ; 173 if (*adr<min) *adr=min;
2382  0022 9c            	rvf
2383  0023 9093          	ldw	y,x
2384  0025 51            	exgw	x,y
2385  0026 fe            	ldw	x,(x)
2386  0027 1305          	cpw	x,(OFST+5,sp)
2387  0029 51            	exgw	x,y
2388  002a 2e09          	jrsge	L1151
2391  002c 1e05          	ldw	x,(OFST+5,sp)
2392  002e 89            	pushw	x
2393  002f 1e03          	ldw	x,(OFST+3,sp)
2394  0031 cd0000        	call	c_eewrw
2396  0034 85            	popw	x
2397  0035               L1151:
2398                     ; 174 if (*adr>max) *adr=max; 
2400  0035 9c            	rvf
2401  0036 1e01          	ldw	x,(OFST+1,sp)
2402  0038 9093          	ldw	y,x
2403  003a 51            	exgw	x,y
2404  003b fe            	ldw	x,(x)
2405  003c 1307          	cpw	x,(OFST+7,sp)
2406  003e 51            	exgw	x,y
2407  003f 2d09          	jrsle	L3151
2410  0041 1e07          	ldw	x,(OFST+7,sp)
2411  0043 89            	pushw	x
2412  0044 1e03          	ldw	x,(OFST+3,sp)
2413  0046 cd0000        	call	c_eewrw
2415  0049 85            	popw	x
2416  004a               L3151:
2417                     ; 175 }
2420  004a 85            	popw	x
2421  004b 81            	ret
2482                     ; 178 long delay_ms(short in)
2482                     ; 179 {
2483                     	switch	.text
2484  004c               _delay_ms:
2486  004c 520c          	subw	sp,#12
2487       0000000c      OFST:	set	12
2490                     ; 182 i=((long)in)*100UL;
2492  004e 90ae0064      	ldw	y,#100
2493  0052 cd0000        	call	c_vmul
2495  0055 96            	ldw	x,sp
2496  0056 1c0005        	addw	x,#OFST-7
2497  0059 cd0000        	call	c_rtol
2499                     ; 184 for(ii=0;ii<i;ii++)
2501  005c ae0000        	ldw	x,#0
2502  005f 1f0b          	ldw	(OFST-1,sp),x
2503  0061 ae0000        	ldw	x,#0
2504  0064 1f09          	ldw	(OFST-3,sp),x
2506  0066 2012          	jra	L3551
2507  0068               L7451:
2508                     ; 186 		iii++;
2510  0068 96            	ldw	x,sp
2511  0069 1c0001        	addw	x,#OFST-11
2512  006c a601          	ld	a,#1
2513  006e cd0000        	call	c_lgadc
2515                     ; 184 for(ii=0;ii<i;ii++)
2517  0071 96            	ldw	x,sp
2518  0072 1c0009        	addw	x,#OFST-3
2519  0075 a601          	ld	a,#1
2520  0077 cd0000        	call	c_lgadc
2522  007a               L3551:
2525  007a 9c            	rvf
2526  007b 96            	ldw	x,sp
2527  007c 1c0009        	addw	x,#OFST-3
2528  007f cd0000        	call	c_ltor
2530  0082 96            	ldw	x,sp
2531  0083 1c0005        	addw	x,#OFST-7
2532  0086 cd0000        	call	c_lcmp
2534  0089 2fdd          	jrslt	L7451
2535                     ; 189 }
2538  008b 5b0c          	addw	sp,#12
2539  008d 81            	ret
2575                     ; 192 void led_hndl(void)
2575                     ; 193 {
2576                     	switch	.text
2577  008e               _led_hndl:
2581                     ; 194 if(adress_error)
2583  008e 725d0000      	tnz	_adress_error
2584  0092 2718          	jreq	L7651
2585                     ; 196 	led_red=0x55555555L;
2587  0094 ae5555        	ldw	x,#21845
2588  0097 bf14          	ldw	_led_red+2,x
2589  0099 ae5555        	ldw	x,#21845
2590  009c bf12          	ldw	_led_red,x
2591                     ; 197 	led_green=0x55555555L;
2593  009e ae5555        	ldw	x,#21845
2594  00a1 bf18          	ldw	_led_green+2,x
2595  00a3 ae5555        	ldw	x,#21845
2596  00a6 bf16          	ldw	_led_green,x
2598  00a8 ac100710      	jpf	L1751
2599  00ac               L7651:
2600                     ; 213 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2602  00ac 3d01          	tnz	_bps_class
2603  00ae 2703          	jreq	L41
2604  00b0 cc0363        	jp	L3751
2605  00b3               L41:
2606                     ; 215 	if(jp_mode!=jp3)
2608  00b3 b647          	ld	a,_jp_mode
2609  00b5 a103          	cp	a,#3
2610  00b7 2603          	jrne	L61
2611  00b9 cc025f        	jp	L5751
2612  00bc               L61:
2613                     ; 217 		if(main_cnt1<(5*ee_TZAS))
2615  00bc 9c            	rvf
2616  00bd ce0014        	ldw	x,_ee_TZAS
2617  00c0 90ae0005      	ldw	y,#5
2618  00c4 cd0000        	call	c_imul
2620  00c7 b34c          	cpw	x,_main_cnt1
2621  00c9 2d18          	jrsle	L7751
2622                     ; 219 			led_red=0x00000000L;
2624  00cb ae0000        	ldw	x,#0
2625  00ce bf14          	ldw	_led_red+2,x
2626  00d0 ae0000        	ldw	x,#0
2627  00d3 bf12          	ldw	_led_red,x
2628                     ; 220 			led_green=0x03030303L;
2630  00d5 ae0303        	ldw	x,#771
2631  00d8 bf18          	ldw	_led_green+2,x
2632  00da ae0303        	ldw	x,#771
2633  00dd bf16          	ldw	_led_green,x
2635  00df ac200220      	jpf	L1061
2636  00e3               L7751:
2637                     ; 223 		else if((link==ON)&&(flags_tu&0b10000000))
2639  00e3 b65f          	ld	a,_link
2640  00e5 a155          	cp	a,#85
2641  00e7 261e          	jrne	L3061
2643  00e9 b65d          	ld	a,_flags_tu
2644  00eb a580          	bcp	a,#128
2645  00ed 2718          	jreq	L3061
2646                     ; 225 			led_red=0x00055555L;
2648  00ef ae5555        	ldw	x,#21845
2649  00f2 bf14          	ldw	_led_red+2,x
2650  00f4 ae0005        	ldw	x,#5
2651  00f7 bf12          	ldw	_led_red,x
2652                     ; 226 			led_green=0xffffffffL;
2654  00f9 aeffff        	ldw	x,#65535
2655  00fc bf18          	ldw	_led_green+2,x
2656  00fe aeffff        	ldw	x,#-1
2657  0101 bf16          	ldw	_led_green,x
2659  0103 ac200220      	jpf	L1061
2660  0107               L3061:
2661                     ; 229 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2663  0107 9c            	rvf
2664  0108 ce0014        	ldw	x,_ee_TZAS
2665  010b 90ae0005      	ldw	y,#5
2666  010f cd0000        	call	c_imul
2668  0112 b34c          	cpw	x,_main_cnt1
2669  0114 2e37          	jrsge	L7061
2671  0116 9c            	rvf
2672  0117 ce0014        	ldw	x,_ee_TZAS
2673  011a 90ae0005      	ldw	y,#5
2674  011e cd0000        	call	c_imul
2676  0121 1c0064        	addw	x,#100
2677  0124 b34c          	cpw	x,_main_cnt1
2678  0126 2d25          	jrsle	L7061
2680  0128 ce0004        	ldw	x,_ee_AVT_MODE
2681  012b a30055        	cpw	x,#85
2682  012e 271d          	jreq	L7061
2684  0130 ce0002        	ldw	x,_ee_DEVICE
2685  0133 2618          	jrne	L7061
2686                     ; 231 			led_red=0x00000000L;
2688  0135 ae0000        	ldw	x,#0
2689  0138 bf14          	ldw	_led_red+2,x
2690  013a ae0000        	ldw	x,#0
2691  013d bf12          	ldw	_led_red,x
2692                     ; 232 			led_green=0xffffffffL;	
2694  013f aeffff        	ldw	x,#65535
2695  0142 bf18          	ldw	_led_green+2,x
2696  0144 aeffff        	ldw	x,#-1
2697  0147 bf16          	ldw	_led_green,x
2699  0149 ac200220      	jpf	L1061
2700  014d               L7061:
2701                     ; 235 		else  if(link==OFF)
2703  014d b65f          	ld	a,_link
2704  014f a1aa          	cp	a,#170
2705  0151 2618          	jrne	L3161
2706                     ; 237 			led_red=0x55555555L;
2708  0153 ae5555        	ldw	x,#21845
2709  0156 bf14          	ldw	_led_red+2,x
2710  0158 ae5555        	ldw	x,#21845
2711  015b bf12          	ldw	_led_red,x
2712                     ; 238 			led_green=0xffffffffL;
2714  015d aeffff        	ldw	x,#65535
2715  0160 bf18          	ldw	_led_green+2,x
2716  0162 aeffff        	ldw	x,#-1
2717  0165 bf16          	ldw	_led_green,x
2719  0167 ac200220      	jpf	L1061
2720  016b               L3161:
2721                     ; 241 		else if((link==ON)&&((flags&0b00111110)==0))
2723  016b b65f          	ld	a,_link
2724  016d a155          	cp	a,#85
2725  016f 261d          	jrne	L7161
2727  0171 b60b          	ld	a,_flags
2728  0173 a53e          	bcp	a,#62
2729  0175 2617          	jrne	L7161
2730                     ; 243 			led_red=0x00000000L;
2732  0177 ae0000        	ldw	x,#0
2733  017a bf14          	ldw	_led_red+2,x
2734  017c ae0000        	ldw	x,#0
2735  017f bf12          	ldw	_led_red,x
2736                     ; 244 			led_green=0xffffffffL;
2738  0181 aeffff        	ldw	x,#65535
2739  0184 bf18          	ldw	_led_green+2,x
2740  0186 aeffff        	ldw	x,#-1
2741  0189 bf16          	ldw	_led_green,x
2743  018b cc0220        	jra	L1061
2744  018e               L7161:
2745                     ; 247 		else if((flags&0b00111110)==0b00000100)
2747  018e b60b          	ld	a,_flags
2748  0190 a43e          	and	a,#62
2749  0192 a104          	cp	a,#4
2750  0194 2616          	jrne	L3261
2751                     ; 249 			led_red=0x00010001L;
2753  0196 ae0001        	ldw	x,#1
2754  0199 bf14          	ldw	_led_red+2,x
2755  019b ae0001        	ldw	x,#1
2756  019e bf12          	ldw	_led_red,x
2757                     ; 250 			led_green=0xffffffffL;	
2759  01a0 aeffff        	ldw	x,#65535
2760  01a3 bf18          	ldw	_led_green+2,x
2761  01a5 aeffff        	ldw	x,#-1
2762  01a8 bf16          	ldw	_led_green,x
2764  01aa 2074          	jra	L1061
2765  01ac               L3261:
2766                     ; 252 		else if(flags&0b00000010)
2768  01ac b60b          	ld	a,_flags
2769  01ae a502          	bcp	a,#2
2770  01b0 2716          	jreq	L7261
2771                     ; 254 			led_red=0x00010001L;
2773  01b2 ae0001        	ldw	x,#1
2774  01b5 bf14          	ldw	_led_red+2,x
2775  01b7 ae0001        	ldw	x,#1
2776  01ba bf12          	ldw	_led_red,x
2777                     ; 255 			led_green=0x00000000L;	
2779  01bc ae0000        	ldw	x,#0
2780  01bf bf18          	ldw	_led_green+2,x
2781  01c1 ae0000        	ldw	x,#0
2782  01c4 bf16          	ldw	_led_green,x
2784  01c6 2058          	jra	L1061
2785  01c8               L7261:
2786                     ; 257 		else if(flags&0b00001000)
2788  01c8 b60b          	ld	a,_flags
2789  01ca a508          	bcp	a,#8
2790  01cc 2716          	jreq	L3361
2791                     ; 259 			led_red=0x00090009L;
2793  01ce ae0009        	ldw	x,#9
2794  01d1 bf14          	ldw	_led_red+2,x
2795  01d3 ae0009        	ldw	x,#9
2796  01d6 bf12          	ldw	_led_red,x
2797                     ; 260 			led_green=0x00000000L;	
2799  01d8 ae0000        	ldw	x,#0
2800  01db bf18          	ldw	_led_green+2,x
2801  01dd ae0000        	ldw	x,#0
2802  01e0 bf16          	ldw	_led_green,x
2804  01e2 203c          	jra	L1061
2805  01e4               L3361:
2806                     ; 262 		else if(flags&0b00010000)
2808  01e4 b60b          	ld	a,_flags
2809  01e6 a510          	bcp	a,#16
2810  01e8 2716          	jreq	L7361
2811                     ; 264 			led_red=0x00490049L;
2813  01ea ae0049        	ldw	x,#73
2814  01ed bf14          	ldw	_led_red+2,x
2815  01ef ae0049        	ldw	x,#73
2816  01f2 bf12          	ldw	_led_red,x
2817                     ; 265 			led_green=0x00000000L;	
2819  01f4 ae0000        	ldw	x,#0
2820  01f7 bf18          	ldw	_led_green+2,x
2821  01f9 ae0000        	ldw	x,#0
2822  01fc bf16          	ldw	_led_green,x
2824  01fe 2020          	jra	L1061
2825  0200               L7361:
2826                     ; 268 		else if((link==ON)&&(flags&0b00100000))
2828  0200 b65f          	ld	a,_link
2829  0202 a155          	cp	a,#85
2830  0204 261a          	jrne	L1061
2832  0206 b60b          	ld	a,_flags
2833  0208 a520          	bcp	a,#32
2834  020a 2714          	jreq	L1061
2835                     ; 270 			led_red=0x00000000L;
2837  020c ae0000        	ldw	x,#0
2838  020f bf14          	ldw	_led_red+2,x
2839  0211 ae0000        	ldw	x,#0
2840  0214 bf12          	ldw	_led_red,x
2841                     ; 271 			led_green=0x00030003L;
2843  0216 ae0003        	ldw	x,#3
2844  0219 bf18          	ldw	_led_green+2,x
2845  021b ae0003        	ldw	x,#3
2846  021e bf16          	ldw	_led_green,x
2847  0220               L1061:
2848                     ; 274 		if((jp_mode==jp1))
2850  0220 b647          	ld	a,_jp_mode
2851  0222 a101          	cp	a,#1
2852  0224 2618          	jrne	L5461
2853                     ; 276 			led_red=0x00000000L;
2855  0226 ae0000        	ldw	x,#0
2856  0229 bf14          	ldw	_led_red+2,x
2857  022b ae0000        	ldw	x,#0
2858  022e bf12          	ldw	_led_red,x
2859                     ; 277 			led_green=0x33333333L;
2861  0230 ae3333        	ldw	x,#13107
2862  0233 bf18          	ldw	_led_green+2,x
2863  0235 ae3333        	ldw	x,#13107
2864  0238 bf16          	ldw	_led_green,x
2866  023a ac100710      	jpf	L1751
2867  023e               L5461:
2868                     ; 279 		else if((jp_mode==jp2))
2870  023e b647          	ld	a,_jp_mode
2871  0240 a102          	cp	a,#2
2872  0242 2703          	jreq	L02
2873  0244 cc0710        	jp	L1751
2874  0247               L02:
2875                     ; 281 			led_red=0xccccccccL;
2877  0247 aecccc        	ldw	x,#52428
2878  024a bf14          	ldw	_led_red+2,x
2879  024c aecccc        	ldw	x,#-13108
2880  024f bf12          	ldw	_led_red,x
2881                     ; 282 			led_green=0x00000000L;
2883  0251 ae0000        	ldw	x,#0
2884  0254 bf18          	ldw	_led_green+2,x
2885  0256 ae0000        	ldw	x,#0
2886  0259 bf16          	ldw	_led_green,x
2887  025b ac100710      	jpf	L1751
2888  025f               L5751:
2889                     ; 285 	else if(jp_mode==jp3)
2891  025f b647          	ld	a,_jp_mode
2892  0261 a103          	cp	a,#3
2893  0263 2703          	jreq	L22
2894  0265 cc0710        	jp	L1751
2895  0268               L22:
2896                     ; 287 		if(main_cnt1<(5*ee_TZAS))
2898  0268 9c            	rvf
2899  0269 ce0014        	ldw	x,_ee_TZAS
2900  026c 90ae0005      	ldw	y,#5
2901  0270 cd0000        	call	c_imul
2903  0273 b34c          	cpw	x,_main_cnt1
2904  0275 2d18          	jrsle	L7561
2905                     ; 289 			led_red=0x00000000L;
2907  0277 ae0000        	ldw	x,#0
2908  027a bf14          	ldw	_led_red+2,x
2909  027c ae0000        	ldw	x,#0
2910  027f bf12          	ldw	_led_red,x
2911                     ; 290 			led_green=0x03030303L;
2913  0281 ae0303        	ldw	x,#771
2914  0284 bf18          	ldw	_led_green+2,x
2915  0286 ae0303        	ldw	x,#771
2916  0289 bf16          	ldw	_led_green,x
2918  028b ac100710      	jpf	L1751
2919  028f               L7561:
2920                     ; 292 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
2922  028f 9c            	rvf
2923  0290 ce0014        	ldw	x,_ee_TZAS
2924  0293 90ae0005      	ldw	y,#5
2925  0297 cd0000        	call	c_imul
2927  029a b34c          	cpw	x,_main_cnt1
2928  029c 2e2a          	jrsge	L3661
2930  029e 9c            	rvf
2931  029f ce0014        	ldw	x,_ee_TZAS
2932  02a2 90ae0005      	ldw	y,#5
2933  02a6 cd0000        	call	c_imul
2935  02a9 1c0046        	addw	x,#70
2936  02ac b34c          	cpw	x,_main_cnt1
2937  02ae 2d18          	jrsle	L3661
2938                     ; 294 			led_red=0x00000000L;
2940  02b0 ae0000        	ldw	x,#0
2941  02b3 bf14          	ldw	_led_red+2,x
2942  02b5 ae0000        	ldw	x,#0
2943  02b8 bf12          	ldw	_led_red,x
2944                     ; 295 			led_green=0xffffffffL;	
2946  02ba aeffff        	ldw	x,#65535
2947  02bd bf18          	ldw	_led_green+2,x
2948  02bf aeffff        	ldw	x,#-1
2949  02c2 bf16          	ldw	_led_green,x
2951  02c4 ac100710      	jpf	L1751
2952  02c8               L3661:
2953                     ; 298 		else if((flags&0b00011110)==0)
2955  02c8 b60b          	ld	a,_flags
2956  02ca a51e          	bcp	a,#30
2957  02cc 2618          	jrne	L7661
2958                     ; 300 			led_red=0x00000000L;
2960  02ce ae0000        	ldw	x,#0
2961  02d1 bf14          	ldw	_led_red+2,x
2962  02d3 ae0000        	ldw	x,#0
2963  02d6 bf12          	ldw	_led_red,x
2964                     ; 301 			led_green=0xffffffffL;
2966  02d8 aeffff        	ldw	x,#65535
2967  02db bf18          	ldw	_led_green+2,x
2968  02dd aeffff        	ldw	x,#-1
2969  02e0 bf16          	ldw	_led_green,x
2971  02e2 ac100710      	jpf	L1751
2972  02e6               L7661:
2973                     ; 305 		else if((flags&0b00111110)==0b00000100)
2975  02e6 b60b          	ld	a,_flags
2976  02e8 a43e          	and	a,#62
2977  02ea a104          	cp	a,#4
2978  02ec 2618          	jrne	L3761
2979                     ; 307 			led_red=0x00010001L;
2981  02ee ae0001        	ldw	x,#1
2982  02f1 bf14          	ldw	_led_red+2,x
2983  02f3 ae0001        	ldw	x,#1
2984  02f6 bf12          	ldw	_led_red,x
2985                     ; 308 			led_green=0xffffffffL;	
2987  02f8 aeffff        	ldw	x,#65535
2988  02fb bf18          	ldw	_led_green+2,x
2989  02fd aeffff        	ldw	x,#-1
2990  0300 bf16          	ldw	_led_green,x
2992  0302 ac100710      	jpf	L1751
2993  0306               L3761:
2994                     ; 310 		else if(flags&0b00000010)
2996  0306 b60b          	ld	a,_flags
2997  0308 a502          	bcp	a,#2
2998  030a 2718          	jreq	L7761
2999                     ; 312 			led_red=0x00010001L;
3001  030c ae0001        	ldw	x,#1
3002  030f bf14          	ldw	_led_red+2,x
3003  0311 ae0001        	ldw	x,#1
3004  0314 bf12          	ldw	_led_red,x
3005                     ; 313 			led_green=0x00000000L;	
3007  0316 ae0000        	ldw	x,#0
3008  0319 bf18          	ldw	_led_green+2,x
3009  031b ae0000        	ldw	x,#0
3010  031e bf16          	ldw	_led_green,x
3012  0320 ac100710      	jpf	L1751
3013  0324               L7761:
3014                     ; 315 		else if(flags&0b00001000)
3016  0324 b60b          	ld	a,_flags
3017  0326 a508          	bcp	a,#8
3018  0328 2718          	jreq	L3071
3019                     ; 317 			led_red=0x00090009L;
3021  032a ae0009        	ldw	x,#9
3022  032d bf14          	ldw	_led_red+2,x
3023  032f ae0009        	ldw	x,#9
3024  0332 bf12          	ldw	_led_red,x
3025                     ; 318 			led_green=0x00000000L;	
3027  0334 ae0000        	ldw	x,#0
3028  0337 bf18          	ldw	_led_green+2,x
3029  0339 ae0000        	ldw	x,#0
3030  033c bf16          	ldw	_led_green,x
3032  033e ac100710      	jpf	L1751
3033  0342               L3071:
3034                     ; 320 		else if(flags&0b00010000)
3036  0342 b60b          	ld	a,_flags
3037  0344 a510          	bcp	a,#16
3038  0346 2603          	jrne	L42
3039  0348 cc0710        	jp	L1751
3040  034b               L42:
3041                     ; 322 			led_red=0x00490049L;
3043  034b ae0049        	ldw	x,#73
3044  034e bf14          	ldw	_led_red+2,x
3045  0350 ae0049        	ldw	x,#73
3046  0353 bf12          	ldw	_led_red,x
3047                     ; 323 			led_green=0xffffffffL;	
3049  0355 aeffff        	ldw	x,#65535
3050  0358 bf18          	ldw	_led_green+2,x
3051  035a aeffff        	ldw	x,#-1
3052  035d bf16          	ldw	_led_green,x
3053  035f ac100710      	jpf	L1751
3054  0363               L3751:
3055                     ; 327 else if(bps_class==bpsIPS)	//если блок ИПСный
3057  0363 b601          	ld	a,_bps_class
3058  0365 a101          	cp	a,#1
3059  0367 2703          	jreq	L62
3060  0369 cc0710        	jp	L1751
3061  036c               L62:
3062                     ; 329 	if(jp_mode!=jp3)
3064  036c b647          	ld	a,_jp_mode
3065  036e a103          	cp	a,#3
3066  0370 2603          	jrne	L03
3067  0372 cc061c        	jp	L5171
3068  0375               L03:
3069                     ; 331 		if(main_cnt1<(5*ee_TZAS))
3071  0375 9c            	rvf
3072  0376 ce0014        	ldw	x,_ee_TZAS
3073  0379 90ae0005      	ldw	y,#5
3074  037d cd0000        	call	c_imul
3076  0380 b34c          	cpw	x,_main_cnt1
3077  0382 2d18          	jrsle	L7171
3078                     ; 333 			led_red=0x00000000L;
3080  0384 ae0000        	ldw	x,#0
3081  0387 bf14          	ldw	_led_red+2,x
3082  0389 ae0000        	ldw	x,#0
3083  038c bf12          	ldw	_led_red,x
3084                     ; 334 			led_green=0x03030303L;
3086  038e ae0303        	ldw	x,#771
3087  0391 bf18          	ldw	_led_green+2,x
3088  0393 ae0303        	ldw	x,#771
3089  0396 bf16          	ldw	_led_green,x
3091  0398 acdd05dd      	jpf	L1271
3092  039c               L7171:
3093                     ; 337 		else if((link==ON)&&(flags_tu&0b10000000))
3095  039c b65f          	ld	a,_link
3096  039e a155          	cp	a,#85
3097  03a0 261e          	jrne	L3271
3099  03a2 b65d          	ld	a,_flags_tu
3100  03a4 a580          	bcp	a,#128
3101  03a6 2718          	jreq	L3271
3102                     ; 339 			led_red=0x00055555L;
3104  03a8 ae5555        	ldw	x,#21845
3105  03ab bf14          	ldw	_led_red+2,x
3106  03ad ae0005        	ldw	x,#5
3107  03b0 bf12          	ldw	_led_red,x
3108                     ; 340 			led_green=0xffffffffL;
3110  03b2 aeffff        	ldw	x,#65535
3111  03b5 bf18          	ldw	_led_green+2,x
3112  03b7 aeffff        	ldw	x,#-1
3113  03ba bf16          	ldw	_led_green,x
3115  03bc acdd05dd      	jpf	L1271
3116  03c0               L3271:
3117                     ; 343 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3119  03c0 9c            	rvf
3120  03c1 ce0014        	ldw	x,_ee_TZAS
3121  03c4 90ae0005      	ldw	y,#5
3122  03c8 cd0000        	call	c_imul
3124  03cb b34c          	cpw	x,_main_cnt1
3125  03cd 2e37          	jrsge	L7271
3127  03cf 9c            	rvf
3128  03d0 ce0014        	ldw	x,_ee_TZAS
3129  03d3 90ae0005      	ldw	y,#5
3130  03d7 cd0000        	call	c_imul
3132  03da 1c0064        	addw	x,#100
3133  03dd b34c          	cpw	x,_main_cnt1
3134  03df 2d25          	jrsle	L7271
3136  03e1 ce0004        	ldw	x,_ee_AVT_MODE
3137  03e4 a30055        	cpw	x,#85
3138  03e7 271d          	jreq	L7271
3140  03e9 ce0002        	ldw	x,_ee_DEVICE
3141  03ec 2618          	jrne	L7271
3142                     ; 345 			led_red=0x00000000L;
3144  03ee ae0000        	ldw	x,#0
3145  03f1 bf14          	ldw	_led_red+2,x
3146  03f3 ae0000        	ldw	x,#0
3147  03f6 bf12          	ldw	_led_red,x
3148                     ; 346 			led_green=0xffffffffL;	
3150  03f8 aeffff        	ldw	x,#65535
3151  03fb bf18          	ldw	_led_green+2,x
3152  03fd aeffff        	ldw	x,#-1
3153  0400 bf16          	ldw	_led_green,x
3155  0402 acdd05dd      	jpf	L1271
3156  0406               L7271:
3157                     ; 349 		else  if(link==OFF)
3159  0406 b65f          	ld	a,_link
3160  0408 a1aa          	cp	a,#170
3161  040a 2703          	jreq	L23
3162  040c cc0528        	jp	L3371
3163  040f               L23:
3164                     ; 351 			if((flags&0b00011110)==0)
3166  040f b60b          	ld	a,_flags
3167  0411 a51e          	bcp	a,#30
3168  0413 262d          	jrne	L5371
3169                     ; 353 				led_red=0x00000000L;
3171  0415 ae0000        	ldw	x,#0
3172  0418 bf14          	ldw	_led_red+2,x
3173  041a ae0000        	ldw	x,#0
3174  041d bf12          	ldw	_led_red,x
3175                     ; 354 				if(bMAIN)led_green=0xfffffff5L;
3177                     	btst	_bMAIN
3178  0424 240e          	jruge	L7371
3181  0426 aefff5        	ldw	x,#65525
3182  0429 bf18          	ldw	_led_green+2,x
3183  042b aeffff        	ldw	x,#-1
3184  042e bf16          	ldw	_led_green,x
3186  0430 acdd05dd      	jpf	L1271
3187  0434               L7371:
3188                     ; 355 				else led_green=0xffffffffL;
3190  0434 aeffff        	ldw	x,#65535
3191  0437 bf18          	ldw	_led_green+2,x
3192  0439 aeffff        	ldw	x,#-1
3193  043c bf16          	ldw	_led_green,x
3194  043e acdd05dd      	jpf	L1271
3195  0442               L5371:
3196                     ; 358 			else if((flags&0b00111110)==0b00000100)
3198  0442 b60b          	ld	a,_flags
3199  0444 a43e          	and	a,#62
3200  0446 a104          	cp	a,#4
3201  0448 262d          	jrne	L5471
3202                     ; 360 				led_red=0x00010001L;
3204  044a ae0001        	ldw	x,#1
3205  044d bf14          	ldw	_led_red+2,x
3206  044f ae0001        	ldw	x,#1
3207  0452 bf12          	ldw	_led_red,x
3208                     ; 361 				if(bMAIN)led_green=0xfffffff5L;
3210                     	btst	_bMAIN
3211  0459 240e          	jruge	L7471
3214  045b aefff5        	ldw	x,#65525
3215  045e bf18          	ldw	_led_green+2,x
3216  0460 aeffff        	ldw	x,#-1
3217  0463 bf16          	ldw	_led_green,x
3219  0465 acdd05dd      	jpf	L1271
3220  0469               L7471:
3221                     ; 362 				else led_green=0xffffffffL;	
3223  0469 aeffff        	ldw	x,#65535
3224  046c bf18          	ldw	_led_green+2,x
3225  046e aeffff        	ldw	x,#-1
3226  0471 bf16          	ldw	_led_green,x
3227  0473 acdd05dd      	jpf	L1271
3228  0477               L5471:
3229                     ; 364 			else if(flags&0b00000010)
3231  0477 b60b          	ld	a,_flags
3232  0479 a502          	bcp	a,#2
3233  047b 272d          	jreq	L5571
3234                     ; 366 				led_red=0x00010001L;
3236  047d ae0001        	ldw	x,#1
3237  0480 bf14          	ldw	_led_red+2,x
3238  0482 ae0001        	ldw	x,#1
3239  0485 bf12          	ldw	_led_red,x
3240                     ; 367 				if(bMAIN)led_green=0x00000005L;
3242                     	btst	_bMAIN
3243  048c 240e          	jruge	L7571
3246  048e ae0005        	ldw	x,#5
3247  0491 bf18          	ldw	_led_green+2,x
3248  0493 ae0000        	ldw	x,#0
3249  0496 bf16          	ldw	_led_green,x
3251  0498 acdd05dd      	jpf	L1271
3252  049c               L7571:
3253                     ; 368 				else led_green=0x00000000L;
3255  049c ae0000        	ldw	x,#0
3256  049f bf18          	ldw	_led_green+2,x
3257  04a1 ae0000        	ldw	x,#0
3258  04a4 bf16          	ldw	_led_green,x
3259  04a6 acdd05dd      	jpf	L1271
3260  04aa               L5571:
3261                     ; 370 			else if(flags&0b00001000)
3263  04aa b60b          	ld	a,_flags
3264  04ac a508          	bcp	a,#8
3265  04ae 272d          	jreq	L5671
3266                     ; 372 				led_red=0x00090009L;
3268  04b0 ae0009        	ldw	x,#9
3269  04b3 bf14          	ldw	_led_red+2,x
3270  04b5 ae0009        	ldw	x,#9
3271  04b8 bf12          	ldw	_led_red,x
3272                     ; 373 				if(bMAIN)led_green=0x00000005L;
3274                     	btst	_bMAIN
3275  04bf 240e          	jruge	L7671
3278  04c1 ae0005        	ldw	x,#5
3279  04c4 bf18          	ldw	_led_green+2,x
3280  04c6 ae0000        	ldw	x,#0
3281  04c9 bf16          	ldw	_led_green,x
3283  04cb acdd05dd      	jpf	L1271
3284  04cf               L7671:
3285                     ; 374 				else led_green=0x00000000L;	
3287  04cf ae0000        	ldw	x,#0
3288  04d2 bf18          	ldw	_led_green+2,x
3289  04d4 ae0000        	ldw	x,#0
3290  04d7 bf16          	ldw	_led_green,x
3291  04d9 acdd05dd      	jpf	L1271
3292  04dd               L5671:
3293                     ; 376 			else if(flags&0b00010000)
3295  04dd b60b          	ld	a,_flags
3296  04df a510          	bcp	a,#16
3297  04e1 272d          	jreq	L5771
3298                     ; 378 				led_red=0x00490049L;
3300  04e3 ae0049        	ldw	x,#73
3301  04e6 bf14          	ldw	_led_red+2,x
3302  04e8 ae0049        	ldw	x,#73
3303  04eb bf12          	ldw	_led_red,x
3304                     ; 379 				if(bMAIN)led_green=0x00000005L;
3306                     	btst	_bMAIN
3307  04f2 240e          	jruge	L7771
3310  04f4 ae0005        	ldw	x,#5
3311  04f7 bf18          	ldw	_led_green+2,x
3312  04f9 ae0000        	ldw	x,#0
3313  04fc bf16          	ldw	_led_green,x
3315  04fe acdd05dd      	jpf	L1271
3316  0502               L7771:
3317                     ; 380 				else led_green=0x00000000L;	
3319  0502 ae0000        	ldw	x,#0
3320  0505 bf18          	ldw	_led_green+2,x
3321  0507 ae0000        	ldw	x,#0
3322  050a bf16          	ldw	_led_green,x
3323  050c acdd05dd      	jpf	L1271
3324  0510               L5771:
3325                     ; 384 				led_red=0x55555555L;
3327  0510 ae5555        	ldw	x,#21845
3328  0513 bf14          	ldw	_led_red+2,x
3329  0515 ae5555        	ldw	x,#21845
3330  0518 bf12          	ldw	_led_red,x
3331                     ; 385 				led_green=0xffffffffL;
3333  051a aeffff        	ldw	x,#65535
3334  051d bf18          	ldw	_led_green+2,x
3335  051f aeffff        	ldw	x,#-1
3336  0522 bf16          	ldw	_led_green,x
3337  0524 acdd05dd      	jpf	L1271
3338  0528               L3371:
3339                     ; 401 		else if((link==ON)&&((flags&0b00111110)==0))
3341  0528 b65f          	ld	a,_link
3342  052a a155          	cp	a,#85
3343  052c 261d          	jrne	L7002
3345  052e b60b          	ld	a,_flags
3346  0530 a53e          	bcp	a,#62
3347  0532 2617          	jrne	L7002
3348                     ; 403 			led_red=0x00000000L;
3350  0534 ae0000        	ldw	x,#0
3351  0537 bf14          	ldw	_led_red+2,x
3352  0539 ae0000        	ldw	x,#0
3353  053c bf12          	ldw	_led_red,x
3354                     ; 404 			led_green=0xffffffffL;
3356  053e aeffff        	ldw	x,#65535
3357  0541 bf18          	ldw	_led_green+2,x
3358  0543 aeffff        	ldw	x,#-1
3359  0546 bf16          	ldw	_led_green,x
3361  0548 cc05dd        	jra	L1271
3362  054b               L7002:
3363                     ; 407 		else if((flags&0b00111110)==0b00000100)
3365  054b b60b          	ld	a,_flags
3366  054d a43e          	and	a,#62
3367  054f a104          	cp	a,#4
3368  0551 2616          	jrne	L3102
3369                     ; 409 			led_red=0x00010001L;
3371  0553 ae0001        	ldw	x,#1
3372  0556 bf14          	ldw	_led_red+2,x
3373  0558 ae0001        	ldw	x,#1
3374  055b bf12          	ldw	_led_red,x
3375                     ; 410 			led_green=0xffffffffL;	
3377  055d aeffff        	ldw	x,#65535
3378  0560 bf18          	ldw	_led_green+2,x
3379  0562 aeffff        	ldw	x,#-1
3380  0565 bf16          	ldw	_led_green,x
3382  0567 2074          	jra	L1271
3383  0569               L3102:
3384                     ; 412 		else if(flags&0b00000010)
3386  0569 b60b          	ld	a,_flags
3387  056b a502          	bcp	a,#2
3388  056d 2716          	jreq	L7102
3389                     ; 414 			led_red=0x00010001L;
3391  056f ae0001        	ldw	x,#1
3392  0572 bf14          	ldw	_led_red+2,x
3393  0574 ae0001        	ldw	x,#1
3394  0577 bf12          	ldw	_led_red,x
3395                     ; 415 			led_green=0x00000000L;	
3397  0579 ae0000        	ldw	x,#0
3398  057c bf18          	ldw	_led_green+2,x
3399  057e ae0000        	ldw	x,#0
3400  0581 bf16          	ldw	_led_green,x
3402  0583 2058          	jra	L1271
3403  0585               L7102:
3404                     ; 417 		else if(flags&0b00001000)
3406  0585 b60b          	ld	a,_flags
3407  0587 a508          	bcp	a,#8
3408  0589 2716          	jreq	L3202
3409                     ; 419 			led_red=0x00090009L;
3411  058b ae0009        	ldw	x,#9
3412  058e bf14          	ldw	_led_red+2,x
3413  0590 ae0009        	ldw	x,#9
3414  0593 bf12          	ldw	_led_red,x
3415                     ; 420 			led_green=0x00000000L;	
3417  0595 ae0000        	ldw	x,#0
3418  0598 bf18          	ldw	_led_green+2,x
3419  059a ae0000        	ldw	x,#0
3420  059d bf16          	ldw	_led_green,x
3422  059f 203c          	jra	L1271
3423  05a1               L3202:
3424                     ; 422 		else if(flags&0b00010000)
3426  05a1 b60b          	ld	a,_flags
3427  05a3 a510          	bcp	a,#16
3428  05a5 2716          	jreq	L7202
3429                     ; 424 			led_red=0x00490049L;
3431  05a7 ae0049        	ldw	x,#73
3432  05aa bf14          	ldw	_led_red+2,x
3433  05ac ae0049        	ldw	x,#73
3434  05af bf12          	ldw	_led_red,x
3435                     ; 425 			led_green=0x00000000L;	
3437  05b1 ae0000        	ldw	x,#0
3438  05b4 bf18          	ldw	_led_green+2,x
3439  05b6 ae0000        	ldw	x,#0
3440  05b9 bf16          	ldw	_led_green,x
3442  05bb 2020          	jra	L1271
3443  05bd               L7202:
3444                     ; 428 		else if((link==ON)&&(flags&0b00100000))
3446  05bd b65f          	ld	a,_link
3447  05bf a155          	cp	a,#85
3448  05c1 261a          	jrne	L1271
3450  05c3 b60b          	ld	a,_flags
3451  05c5 a520          	bcp	a,#32
3452  05c7 2714          	jreq	L1271
3453                     ; 430 			led_red=0x00000000L;
3455  05c9 ae0000        	ldw	x,#0
3456  05cc bf14          	ldw	_led_red+2,x
3457  05ce ae0000        	ldw	x,#0
3458  05d1 bf12          	ldw	_led_red,x
3459                     ; 431 			led_green=0x00030003L;
3461  05d3 ae0003        	ldw	x,#3
3462  05d6 bf18          	ldw	_led_green+2,x
3463  05d8 ae0003        	ldw	x,#3
3464  05db bf16          	ldw	_led_green,x
3465  05dd               L1271:
3466                     ; 434 		if((jp_mode==jp1))
3468  05dd b647          	ld	a,_jp_mode
3469  05df a101          	cp	a,#1
3470  05e1 2618          	jrne	L5302
3471                     ; 436 			led_red=0x00000000L;
3473  05e3 ae0000        	ldw	x,#0
3474  05e6 bf14          	ldw	_led_red+2,x
3475  05e8 ae0000        	ldw	x,#0
3476  05eb bf12          	ldw	_led_red,x
3477                     ; 437 			led_green=0x33333333L;
3479  05ed ae3333        	ldw	x,#13107
3480  05f0 bf18          	ldw	_led_green+2,x
3481  05f2 ae3333        	ldw	x,#13107
3482  05f5 bf16          	ldw	_led_green,x
3484  05f7 ac100710      	jpf	L1751
3485  05fb               L5302:
3486                     ; 439 		else if((jp_mode==jp2))
3488  05fb b647          	ld	a,_jp_mode
3489  05fd a102          	cp	a,#2
3490  05ff 2703          	jreq	L43
3491  0601 cc0710        	jp	L1751
3492  0604               L43:
3493                     ; 443 			led_red=0xccccccccL;
3495  0604 aecccc        	ldw	x,#52428
3496  0607 bf14          	ldw	_led_red+2,x
3497  0609 aecccc        	ldw	x,#-13108
3498  060c bf12          	ldw	_led_red,x
3499                     ; 444 			led_green=0x00000000L;
3501  060e ae0000        	ldw	x,#0
3502  0611 bf18          	ldw	_led_green+2,x
3503  0613 ae0000        	ldw	x,#0
3504  0616 bf16          	ldw	_led_green,x
3505  0618 ac100710      	jpf	L1751
3506  061c               L5171:
3507                     ; 447 	else if(jp_mode==jp3)
3509  061c b647          	ld	a,_jp_mode
3510  061e a103          	cp	a,#3
3511  0620 2703          	jreq	L63
3512  0622 cc0710        	jp	L1751
3513  0625               L63:
3514                     ; 449 		if(main_cnt1<(5*ee_TZAS))
3516  0625 9c            	rvf
3517  0626 ce0014        	ldw	x,_ee_TZAS
3518  0629 90ae0005      	ldw	y,#5
3519  062d cd0000        	call	c_imul
3521  0630 b34c          	cpw	x,_main_cnt1
3522  0632 2d18          	jrsle	L7402
3523                     ; 451 			led_red=0x00000000L;
3525  0634 ae0000        	ldw	x,#0
3526  0637 bf14          	ldw	_led_red+2,x
3527  0639 ae0000        	ldw	x,#0
3528  063c bf12          	ldw	_led_red,x
3529                     ; 452 			led_green=0x03030303L;
3531  063e ae0303        	ldw	x,#771
3532  0641 bf18          	ldw	_led_green+2,x
3533  0643 ae0303        	ldw	x,#771
3534  0646 bf16          	ldw	_led_green,x
3536  0648 ac100710      	jpf	L1751
3537  064c               L7402:
3538                     ; 454 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3540  064c 9c            	rvf
3541  064d ce0014        	ldw	x,_ee_TZAS
3542  0650 90ae0005      	ldw	y,#5
3543  0654 cd0000        	call	c_imul
3545  0657 b34c          	cpw	x,_main_cnt1
3546  0659 2e29          	jrsge	L3502
3548  065b 9c            	rvf
3549  065c ce0014        	ldw	x,_ee_TZAS
3550  065f 90ae0005      	ldw	y,#5
3551  0663 cd0000        	call	c_imul
3553  0666 1c0046        	addw	x,#70
3554  0669 b34c          	cpw	x,_main_cnt1
3555  066b 2d17          	jrsle	L3502
3556                     ; 456 			led_red=0x00000000L;
3558  066d ae0000        	ldw	x,#0
3559  0670 bf14          	ldw	_led_red+2,x
3560  0672 ae0000        	ldw	x,#0
3561  0675 bf12          	ldw	_led_red,x
3562                     ; 457 			led_green=0xffffffffL;	
3564  0677 aeffff        	ldw	x,#65535
3565  067a bf18          	ldw	_led_green+2,x
3566  067c aeffff        	ldw	x,#-1
3567  067f bf16          	ldw	_led_green,x
3569  0681 cc0710        	jra	L1751
3570  0684               L3502:
3571                     ; 460 		else if((flags&0b00011110)==0)
3573  0684 b60b          	ld	a,_flags
3574  0686 a51e          	bcp	a,#30
3575  0688 2616          	jrne	L7502
3576                     ; 462 			led_red=0x00000000L;
3578  068a ae0000        	ldw	x,#0
3579  068d bf14          	ldw	_led_red+2,x
3580  068f ae0000        	ldw	x,#0
3581  0692 bf12          	ldw	_led_red,x
3582                     ; 463 			led_green=0xffffffffL;
3584  0694 aeffff        	ldw	x,#65535
3585  0697 bf18          	ldw	_led_green+2,x
3586  0699 aeffff        	ldw	x,#-1
3587  069c bf16          	ldw	_led_green,x
3589  069e 2070          	jra	L1751
3590  06a0               L7502:
3591                     ; 467 		else if((flags&0b00111110)==0b00000100)
3593  06a0 b60b          	ld	a,_flags
3594  06a2 a43e          	and	a,#62
3595  06a4 a104          	cp	a,#4
3596  06a6 2616          	jrne	L3602
3597                     ; 469 			led_red=0x00010001L;
3599  06a8 ae0001        	ldw	x,#1
3600  06ab bf14          	ldw	_led_red+2,x
3601  06ad ae0001        	ldw	x,#1
3602  06b0 bf12          	ldw	_led_red,x
3603                     ; 470 			led_green=0xffffffffL;	
3605  06b2 aeffff        	ldw	x,#65535
3606  06b5 bf18          	ldw	_led_green+2,x
3607  06b7 aeffff        	ldw	x,#-1
3608  06ba bf16          	ldw	_led_green,x
3610  06bc 2052          	jra	L1751
3611  06be               L3602:
3612                     ; 472 		else if(flags&0b00000010)
3614  06be b60b          	ld	a,_flags
3615  06c0 a502          	bcp	a,#2
3616  06c2 2716          	jreq	L7602
3617                     ; 474 			led_red=0x00010001L;
3619  06c4 ae0001        	ldw	x,#1
3620  06c7 bf14          	ldw	_led_red+2,x
3621  06c9 ae0001        	ldw	x,#1
3622  06cc bf12          	ldw	_led_red,x
3623                     ; 475 			led_green=0x00000000L;	
3625  06ce ae0000        	ldw	x,#0
3626  06d1 bf18          	ldw	_led_green+2,x
3627  06d3 ae0000        	ldw	x,#0
3628  06d6 bf16          	ldw	_led_green,x
3630  06d8 2036          	jra	L1751
3631  06da               L7602:
3632                     ; 477 		else if(flags&0b00001000)
3634  06da b60b          	ld	a,_flags
3635  06dc a508          	bcp	a,#8
3636  06de 2716          	jreq	L3702
3637                     ; 479 			led_red=0x00090009L;
3639  06e0 ae0009        	ldw	x,#9
3640  06e3 bf14          	ldw	_led_red+2,x
3641  06e5 ae0009        	ldw	x,#9
3642  06e8 bf12          	ldw	_led_red,x
3643                     ; 480 			led_green=0x00000000L;	
3645  06ea ae0000        	ldw	x,#0
3646  06ed bf18          	ldw	_led_green+2,x
3647  06ef ae0000        	ldw	x,#0
3648  06f2 bf16          	ldw	_led_green,x
3650  06f4 201a          	jra	L1751
3651  06f6               L3702:
3652                     ; 482 		else if(flags&0b00010000)
3654  06f6 b60b          	ld	a,_flags
3655  06f8 a510          	bcp	a,#16
3656  06fa 2714          	jreq	L1751
3657                     ; 484 			led_red=0x00490049L;
3659  06fc ae0049        	ldw	x,#73
3660  06ff bf14          	ldw	_led_red+2,x
3661  0701 ae0049        	ldw	x,#73
3662  0704 bf12          	ldw	_led_red,x
3663                     ; 485 			led_green=0xffffffffL;	
3665  0706 aeffff        	ldw	x,#65535
3666  0709 bf18          	ldw	_led_green+2,x
3667  070b aeffff        	ldw	x,#-1
3668  070e bf16          	ldw	_led_green,x
3669  0710               L1751:
3670                     ; 489 }
3673  0710 81            	ret
3701                     ; 492 void led_drv(void)
3701                     ; 493 {
3702                     	switch	.text
3703  0711               _led_drv:
3707                     ; 495 GPIOA->DDR|=(1<<4);
3709  0711 72185002      	bset	20482,#4
3710                     ; 496 GPIOA->CR1|=(1<<4);
3712  0715 72185003      	bset	20483,#4
3713                     ; 497 GPIOA->CR2&=~(1<<4);
3715  0719 72195004      	bres	20484,#4
3716                     ; 498 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3718  071d b63d          	ld	a,_led_red_buff+3
3719  071f a501          	bcp	a,#1
3720  0721 2706          	jreq	L1112
3723  0723 72185000      	bset	20480,#4
3725  0727 2004          	jra	L3112
3726  0729               L1112:
3727                     ; 499 else GPIOA->ODR&=~(1<<4); 
3729  0729 72195000      	bres	20480,#4
3730  072d               L3112:
3731                     ; 502 GPIOA->DDR|=(1<<5);
3733  072d 721a5002      	bset	20482,#5
3734                     ; 503 GPIOA->CR1|=(1<<5);
3736  0731 721a5003      	bset	20483,#5
3737                     ; 504 GPIOA->CR2&=~(1<<5);	
3739  0735 721b5004      	bres	20484,#5
3740                     ; 505 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3742  0739 b639          	ld	a,_led_green_buff+3
3743  073b a501          	bcp	a,#1
3744  073d 2706          	jreq	L5112
3747  073f 721a5000      	bset	20480,#5
3749  0743 2004          	jra	L7112
3750  0745               L5112:
3751                     ; 506 else GPIOA->ODR&=~(1<<5);
3753  0745 721b5000      	bres	20480,#5
3754  0749               L7112:
3755                     ; 509 led_red_buff>>=1;
3757  0749 373a          	sra	_led_red_buff
3758  074b 363b          	rrc	_led_red_buff+1
3759  074d 363c          	rrc	_led_red_buff+2
3760  074f 363d          	rrc	_led_red_buff+3
3761                     ; 510 led_green_buff>>=1;
3763  0751 3736          	sra	_led_green_buff
3764  0753 3637          	rrc	_led_green_buff+1
3765  0755 3638          	rrc	_led_green_buff+2
3766  0757 3639          	rrc	_led_green_buff+3
3767                     ; 511 if(++led_drv_cnt>32)
3769  0759 3c1a          	inc	_led_drv_cnt
3770  075b b61a          	ld	a,_led_drv_cnt
3771  075d a121          	cp	a,#33
3772  075f 2512          	jrult	L1212
3773                     ; 513 	led_drv_cnt=0;
3775  0761 3f1a          	clr	_led_drv_cnt
3776                     ; 514 	led_red_buff=led_red;
3778  0763 be14          	ldw	x,_led_red+2
3779  0765 bf3c          	ldw	_led_red_buff+2,x
3780  0767 be12          	ldw	x,_led_red
3781  0769 bf3a          	ldw	_led_red_buff,x
3782                     ; 515 	led_green_buff=led_green;
3784  076b be18          	ldw	x,_led_green+2
3785  076d bf38          	ldw	_led_green_buff+2,x
3786  076f be16          	ldw	x,_led_green
3787  0771 bf36          	ldw	_led_green_buff,x
3788  0773               L1212:
3789                     ; 521 } 
3792  0773 81            	ret
3818                     ; 524 void JP_drv(void)
3818                     ; 525 {
3819                     	switch	.text
3820  0774               _JP_drv:
3824                     ; 527 GPIOD->DDR&=~(1<<6);
3826  0774 721d5011      	bres	20497,#6
3827                     ; 528 GPIOD->CR1|=(1<<6);
3829  0778 721c5012      	bset	20498,#6
3830                     ; 529 GPIOD->CR2&=~(1<<6);
3832  077c 721d5013      	bres	20499,#6
3833                     ; 531 GPIOD->DDR&=~(1<<7);
3835  0780 721f5011      	bres	20497,#7
3836                     ; 532 GPIOD->CR1|=(1<<7);
3838  0784 721e5012      	bset	20498,#7
3839                     ; 533 GPIOD->CR2&=~(1<<7);
3841  0788 721f5013      	bres	20499,#7
3842                     ; 535 if(GPIOD->IDR&(1<<6))
3844  078c c65010        	ld	a,20496
3845  078f a540          	bcp	a,#64
3846  0791 270a          	jreq	L3312
3847                     ; 537 	if(cnt_JP0<10)
3849  0793 b646          	ld	a,_cnt_JP0
3850  0795 a10a          	cp	a,#10
3851  0797 2411          	jruge	L7312
3852                     ; 539 		cnt_JP0++;
3854  0799 3c46          	inc	_cnt_JP0
3855  079b 200d          	jra	L7312
3856  079d               L3312:
3857                     ; 542 else if(!(GPIOD->IDR&(1<<6)))
3859  079d c65010        	ld	a,20496
3860  07a0 a540          	bcp	a,#64
3861  07a2 2606          	jrne	L7312
3862                     ; 544 	if(cnt_JP0)
3864  07a4 3d46          	tnz	_cnt_JP0
3865  07a6 2702          	jreq	L7312
3866                     ; 546 		cnt_JP0--;
3868  07a8 3a46          	dec	_cnt_JP0
3869  07aa               L7312:
3870                     ; 550 if(GPIOD->IDR&(1<<7))
3872  07aa c65010        	ld	a,20496
3873  07ad a580          	bcp	a,#128
3874  07af 270a          	jreq	L5412
3875                     ; 552 	if(cnt_JP1<10)
3877  07b1 b645          	ld	a,_cnt_JP1
3878  07b3 a10a          	cp	a,#10
3879  07b5 2411          	jruge	L1512
3880                     ; 554 		cnt_JP1++;
3882  07b7 3c45          	inc	_cnt_JP1
3883  07b9 200d          	jra	L1512
3884  07bb               L5412:
3885                     ; 557 else if(!(GPIOD->IDR&(1<<7)))
3887  07bb c65010        	ld	a,20496
3888  07be a580          	bcp	a,#128
3889  07c0 2606          	jrne	L1512
3890                     ; 559 	if(cnt_JP1)
3892  07c2 3d45          	tnz	_cnt_JP1
3893  07c4 2702          	jreq	L1512
3894                     ; 561 		cnt_JP1--;
3896  07c6 3a45          	dec	_cnt_JP1
3897  07c8               L1512:
3898                     ; 566 if((cnt_JP0==10)&&(cnt_JP1==10))
3900  07c8 b646          	ld	a,_cnt_JP0
3901  07ca a10a          	cp	a,#10
3902  07cc 2608          	jrne	L7512
3904  07ce b645          	ld	a,_cnt_JP1
3905  07d0 a10a          	cp	a,#10
3906  07d2 2602          	jrne	L7512
3907                     ; 568 	jp_mode=jp0;
3909  07d4 3f47          	clr	_jp_mode
3910  07d6               L7512:
3911                     ; 570 if((cnt_JP0==0)&&(cnt_JP1==10))
3913  07d6 3d46          	tnz	_cnt_JP0
3914  07d8 260a          	jrne	L1612
3916  07da b645          	ld	a,_cnt_JP1
3917  07dc a10a          	cp	a,#10
3918  07de 2604          	jrne	L1612
3919                     ; 572 	jp_mode=jp1;
3921  07e0 35010047      	mov	_jp_mode,#1
3922  07e4               L1612:
3923                     ; 574 if((cnt_JP0==10)&&(cnt_JP1==0))
3925  07e4 b646          	ld	a,_cnt_JP0
3926  07e6 a10a          	cp	a,#10
3927  07e8 2608          	jrne	L3612
3929  07ea 3d45          	tnz	_cnt_JP1
3930  07ec 2604          	jrne	L3612
3931                     ; 576 	jp_mode=jp2;
3933  07ee 35020047      	mov	_jp_mode,#2
3934  07f2               L3612:
3935                     ; 578 if((cnt_JP0==0)&&(cnt_JP1==0))
3937  07f2 3d46          	tnz	_cnt_JP0
3938  07f4 2608          	jrne	L5612
3940  07f6 3d45          	tnz	_cnt_JP1
3941  07f8 2604          	jrne	L5612
3942                     ; 580 	jp_mode=jp3;
3944  07fa 35030047      	mov	_jp_mode,#3
3945  07fe               L5612:
3946                     ; 583 }
3949  07fe 81            	ret
3981                     ; 586 void link_drv(void)		//10Hz
3981                     ; 587 {
3982                     	switch	.text
3983  07ff               _link_drv:
3987                     ; 588 if(jp_mode!=jp3)
3989  07ff b647          	ld	a,_jp_mode
3990  0801 a103          	cp	a,#3
3991  0803 2744          	jreq	L7712
3992                     ; 590 	if(link_cnt<52)link_cnt++;
3994  0805 b65e          	ld	a,_link_cnt
3995  0807 a134          	cp	a,#52
3996  0809 2402          	jruge	L1022
3999  080b 3c5e          	inc	_link_cnt
4000  080d               L1022:
4001                     ; 591 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4003  080d b65e          	ld	a,_link_cnt
4004  080f a131          	cp	a,#49
4005  0811 2606          	jrne	L3022
4008  0813 b60b          	ld	a,_flags
4009  0815 a4c1          	and	a,#193
4010  0817 b70b          	ld	_flags,a
4011  0819               L3022:
4012                     ; 592 	if(link_cnt==50)
4014  0819 b65e          	ld	a,_link_cnt
4015  081b a132          	cp	a,#50
4016  081d 262e          	jrne	L5122
4017                     ; 594 		link=OFF;
4019  081f 35aa005f      	mov	_link,#170
4020                     ; 599 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4022  0823 b601          	ld	a,_bps_class
4023  0825 a101          	cp	a,#1
4024  0827 2606          	jrne	L7022
4027  0829 72100001      	bset	_bMAIN
4029  082d 2004          	jra	L1122
4030  082f               L7022:
4031                     ; 600 		else bMAIN=0;
4033  082f 72110001      	bres	_bMAIN
4034  0833               L1122:
4035                     ; 602 		cnt_net_drv=0;
4037  0833 3f2f          	clr	_cnt_net_drv
4038                     ; 603     		if(!res_fl_)
4040  0835 725d0008      	tnz	_res_fl_
4041  0839 2612          	jrne	L5122
4042                     ; 605 	    		bRES_=1;
4044  083b 35010011      	mov	_bRES_,#1
4045                     ; 606 	    		res_fl_=1;
4047  083f a601          	ld	a,#1
4048  0841 ae0008        	ldw	x,#_res_fl_
4049  0844 cd0000        	call	c_eewrc
4051  0847 2004          	jra	L5122
4052  0849               L7712:
4053                     ; 610 else link=OFF;	
4055  0849 35aa005f      	mov	_link,#170
4056  084d               L5122:
4057                     ; 611 } 
4060  084d 81            	ret
4130                     .const:	section	.text
4131  0000               L05:
4132  0000 0000000b      	dc.l	11
4133  0004               L25:
4134  0004 00000001      	dc.l	1
4135                     ; 615 void vent_drv(void)
4135                     ; 616 {
4136                     	switch	.text
4137  084e               _vent_drv:
4139  084e 520e          	subw	sp,#14
4140       0000000e      OFST:	set	14
4143                     ; 619 	short vent_pwm_i_necc=400;
4145  0850 ae0190        	ldw	x,#400
4146  0853 1f07          	ldw	(OFST-7,sp),x
4147                     ; 620 	short vent_pwm_t_necc=400;
4149  0855 ae0190        	ldw	x,#400
4150  0858 1f09          	ldw	(OFST-5,sp),x
4151                     ; 621 	short vent_pwm_max_necc=400;
4153                     ; 626 	tempSL=36000L/(signed long)ee_Umax;
4155  085a ce0012        	ldw	x,_ee_Umax
4156  085d cd0000        	call	c_itolx
4158  0860 96            	ldw	x,sp
4159  0861 1c0001        	addw	x,#OFST-13
4160  0864 cd0000        	call	c_rtol
4162  0867 ae8ca0        	ldw	x,#36000
4163  086a bf02          	ldw	c_lreg+2,x
4164  086c ae0000        	ldw	x,#0
4165  086f bf00          	ldw	c_lreg,x
4166  0871 96            	ldw	x,sp
4167  0872 1c0001        	addw	x,#OFST-13
4168  0875 cd0000        	call	c_ldiv
4170  0878 96            	ldw	x,sp
4171  0879 1c000b        	addw	x,#OFST-3
4172  087c cd0000        	call	c_rtol
4174                     ; 627 	tempSL=(signed long)I/tempSL;
4176  087f be6b          	ldw	x,_I
4177  0881 cd0000        	call	c_itolx
4179  0884 96            	ldw	x,sp
4180  0885 1c000b        	addw	x,#OFST-3
4181  0888 cd0000        	call	c_ldiv
4183  088b 96            	ldw	x,sp
4184  088c 1c000b        	addw	x,#OFST-3
4185  088f cd0000        	call	c_rtol
4187                     ; 629 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4189  0892 ce0002        	ldw	x,_ee_DEVICE
4190  0895 a30001        	cpw	x,#1
4191  0898 2613          	jrne	L1522
4194  089a be6b          	ldw	x,_I
4195  089c 90ce0000      	ldw	y,_ee_IMAXVENT
4196  08a0 cd0000        	call	c_idiv
4198  08a3 cd0000        	call	c_itolx
4200  08a6 96            	ldw	x,sp
4201  08a7 1c000b        	addw	x,#OFST-3
4202  08aa cd0000        	call	c_rtol
4204  08ad               L1522:
4205                     ; 631 	if(tempSL>10)vent_pwm_i_necc=1000;
4207  08ad 9c            	rvf
4208  08ae 96            	ldw	x,sp
4209  08af 1c000b        	addw	x,#OFST-3
4210  08b2 cd0000        	call	c_ltor
4212  08b5 ae0000        	ldw	x,#L05
4213  08b8 cd0000        	call	c_lcmp
4215  08bb 2f07          	jrslt	L3522
4218  08bd ae03e8        	ldw	x,#1000
4219  08c0 1f07          	ldw	(OFST-7,sp),x
4221  08c2 2025          	jra	L5522
4222  08c4               L3522:
4223                     ; 632 	else if(tempSL<1)vent_pwm_i_necc=400;
4225  08c4 9c            	rvf
4226  08c5 96            	ldw	x,sp
4227  08c6 1c000b        	addw	x,#OFST-3
4228  08c9 cd0000        	call	c_ltor
4230  08cc ae0004        	ldw	x,#L25
4231  08cf cd0000        	call	c_lcmp
4233  08d2 2e07          	jrsge	L7522
4236  08d4 ae0190        	ldw	x,#400
4237  08d7 1f07          	ldw	(OFST-7,sp),x
4239  08d9 200e          	jra	L5522
4240  08db               L7522:
4241                     ; 633 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4243  08db 1e0d          	ldw	x,(OFST-1,sp)
4244  08dd 90ae003c      	ldw	y,#60
4245  08e1 cd0000        	call	c_imul
4247  08e4 1c0190        	addw	x,#400
4248  08e7 1f07          	ldw	(OFST-7,sp),x
4249  08e9               L5522:
4250                     ; 634 	gran(&vent_pwm_i_necc,400,1000);
4252  08e9 ae03e8        	ldw	x,#1000
4253  08ec 89            	pushw	x
4254  08ed ae0190        	ldw	x,#400
4255  08f0 89            	pushw	x
4256  08f1 96            	ldw	x,sp
4257  08f2 1c000b        	addw	x,#OFST-3
4258  08f5 cd0000        	call	_gran
4260  08f8 5b04          	addw	sp,#4
4261                     ; 636 	tempSL=(signed long)T;
4263  08fa b664          	ld	a,_T
4264  08fc b703          	ld	c_lreg+3,a
4265  08fe 48            	sll	a
4266  08ff 4f            	clr	a
4267  0900 a200          	sbc	a,#0
4268  0902 b702          	ld	c_lreg+2,a
4269  0904 b701          	ld	c_lreg+1,a
4270  0906 b700          	ld	c_lreg,a
4271  0908 96            	ldw	x,sp
4272  0909 1c000b        	addw	x,#OFST-3
4273  090c cd0000        	call	c_rtol
4275                     ; 637 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4277  090f 9c            	rvf
4278  0910 ce000c        	ldw	x,_ee_tsign
4279  0913 cd0000        	call	c_itolx
4281  0916 a61e          	ld	a,#30
4282  0918 cd0000        	call	c_lsbc
4284  091b 96            	ldw	x,sp
4285  091c 1c000b        	addw	x,#OFST-3
4286  091f cd0000        	call	c_lcmp
4288  0922 2f07          	jrslt	L3622
4291  0924 ae0190        	ldw	x,#400
4292  0927 1f09          	ldw	(OFST-5,sp),x
4294  0929 2030          	jra	L5622
4295  092b               L3622:
4296                     ; 638 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4298  092b 9c            	rvf
4299  092c ce000c        	ldw	x,_ee_tsign
4300  092f cd0000        	call	c_itolx
4302  0932 96            	ldw	x,sp
4303  0933 1c000b        	addw	x,#OFST-3
4304  0936 cd0000        	call	c_lcmp
4306  0939 2c07          	jrsgt	L7622
4309  093b ae03e8        	ldw	x,#1000
4310  093e 1f09          	ldw	(OFST-5,sp),x
4312  0940 2019          	jra	L5622
4313  0942               L7622:
4314                     ; 639 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4316  0942 ce000c        	ldw	x,_ee_tsign
4317  0945 1d001e        	subw	x,#30
4318  0948 1f03          	ldw	(OFST-11,sp),x
4319  094a 1e0d          	ldw	x,(OFST-1,sp)
4320  094c 72f003        	subw	x,(OFST-11,sp)
4321  094f 90ae0014      	ldw	y,#20
4322  0953 cd0000        	call	c_imul
4324  0956 1c0190        	addw	x,#400
4325  0959 1f09          	ldw	(OFST-5,sp),x
4326  095b               L5622:
4327                     ; 640 	gran(&vent_pwm_t_necc,400,1000);
4329  095b ae03e8        	ldw	x,#1000
4330  095e 89            	pushw	x
4331  095f ae0190        	ldw	x,#400
4332  0962 89            	pushw	x
4333  0963 96            	ldw	x,sp
4334  0964 1c000d        	addw	x,#OFST-1
4335  0967 cd0000        	call	_gran
4337  096a 5b04          	addw	sp,#4
4338                     ; 642 	vent_pwm_max_necc=vent_pwm_i_necc;
4340  096c 1e07          	ldw	x,(OFST-7,sp)
4341  096e 1f05          	ldw	(OFST-9,sp),x
4342                     ; 643 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4344  0970 9c            	rvf
4345  0971 1e09          	ldw	x,(OFST-5,sp)
4346  0973 1307          	cpw	x,(OFST-7,sp)
4347  0975 2d04          	jrsle	L3722
4350  0977 1e09          	ldw	x,(OFST-5,sp)
4351  0979 1f05          	ldw	(OFST-9,sp),x
4352  097b               L3722:
4353                     ; 645 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4355  097b 9c            	rvf
4356  097c be02          	ldw	x,_vent_pwm
4357  097e 1305          	cpw	x,(OFST-9,sp)
4358  0980 2e07          	jrsge	L5722
4361  0982 be02          	ldw	x,_vent_pwm
4362  0984 1c000a        	addw	x,#10
4363  0987 bf02          	ldw	_vent_pwm,x
4364  0989               L5722:
4365                     ; 646 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4367  0989 9c            	rvf
4368  098a be02          	ldw	x,_vent_pwm
4369  098c 1305          	cpw	x,(OFST-9,sp)
4370  098e 2d07          	jrsle	L7722
4373  0990 be02          	ldw	x,_vent_pwm
4374  0992 1d000a        	subw	x,#10
4375  0995 bf02          	ldw	_vent_pwm,x
4376  0997               L7722:
4377                     ; 647 	gran(&vent_pwm,400,1000);
4379  0997 ae03e8        	ldw	x,#1000
4380  099a 89            	pushw	x
4381  099b ae0190        	ldw	x,#400
4382  099e 89            	pushw	x
4383  099f ae0002        	ldw	x,#_vent_pwm
4384  09a2 cd0000        	call	_gran
4386  09a5 5b04          	addw	sp,#4
4387                     ; 651 	if(bVENT_BLOCK)vent_pwm=0;
4389  09a7 3d00          	tnz	_bVENT_BLOCK
4390  09a9 2703          	jreq	L1032
4393  09ab 5f            	clrw	x
4394  09ac bf02          	ldw	_vent_pwm,x
4395  09ae               L1032:
4396                     ; 652 }
4399  09ae 5b0e          	addw	sp,#14
4400  09b0 81            	ret
4435                     ; 657 void pwr_drv(void)
4435                     ; 658 {
4436                     	switch	.text
4437  09b1               _pwr_drv:
4441                     ; 662 BLOCK_INIT
4443  09b1 72145007      	bset	20487,#2
4446  09b5 72145008      	bset	20488,#2
4449  09b9 72155009      	bres	20489,#2
4450                     ; 664 if(main_cnt1<1500)main_cnt1++;
4452  09bd 9c            	rvf
4453  09be be4c          	ldw	x,_main_cnt1
4454  09c0 a305dc        	cpw	x,#1500
4455  09c3 2e07          	jrsge	L3132
4458  09c5 be4c          	ldw	x,_main_cnt1
4459  09c7 1c0001        	addw	x,#1
4460  09ca bf4c          	ldw	_main_cnt1,x
4461  09cc               L3132:
4462                     ; 666 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4464  09cc 9c            	rvf
4465  09cd ce0014        	ldw	x,_ee_TZAS
4466  09d0 90ae0005      	ldw	y,#5
4467  09d4 cd0000        	call	c_imul
4469  09d7 b34c          	cpw	x,_main_cnt1
4470  09d9 2d12          	jrsle	L5132
4472  09db b601          	ld	a,_bps_class
4473  09dd a101          	cp	a,#1
4474  09df 270c          	jreq	L5132
4475                     ; 668 	BLOCK_ON
4477  09e1 72145005      	bset	20485,#2
4480  09e5 35010000      	mov	_bVENT_BLOCK,#1
4482  09e9 ac8a0a8a      	jpf	L7132
4483  09ed               L5132:
4484                     ; 671 else if(bps_class==bpsIPS)
4486  09ed b601          	ld	a,_bps_class
4487  09ef a101          	cp	a,#1
4488  09f1 2621          	jrne	L1232
4489                     ; 674 		if(bBL_IPS)
4491                     	btst	_bBL_IPS
4492  09f8 240b          	jruge	L3232
4493                     ; 676 			 BLOCK_ON
4495  09fa 72145005      	bset	20485,#2
4498  09fe 35010000      	mov	_bVENT_BLOCK,#1
4500  0a02 cc0a8a        	jra	L7132
4501  0a05               L3232:
4502                     ; 679 		else if(!bBL_IPS)
4504                     	btst	_bBL_IPS
4505  0a0a 257e          	jrult	L7132
4506                     ; 681 			  BLOCK_OFF
4508  0a0c 72155005      	bres	20485,#2
4511  0a10 3f00          	clr	_bVENT_BLOCK
4512  0a12 2076          	jra	L7132
4513  0a14               L1232:
4514                     ; 685 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4516  0a14 9c            	rvf
4517  0a15 ce0014        	ldw	x,_ee_TZAS
4518  0a18 90ae0005      	ldw	y,#5
4519  0a1c cd0000        	call	c_imul
4521  0a1f b34c          	cpw	x,_main_cnt1
4522  0a21 2e49          	jrsge	L3332
4524  0a23 9c            	rvf
4525  0a24 ce0014        	ldw	x,_ee_TZAS
4526  0a27 90ae0005      	ldw	y,#5
4527  0a2b cd0000        	call	c_imul
4529  0a2e 1c0046        	addw	x,#70
4530  0a31 b34c          	cpw	x,_main_cnt1
4531  0a33 2d37          	jrsle	L3332
4532                     ; 687 	if(bps_class==bpsIPS)
4534  0a35 b601          	ld	a,_bps_class
4535  0a37 a101          	cp	a,#1
4536  0a39 2608          	jrne	L5332
4537                     ; 689 		  BLOCK_OFF
4539  0a3b 72155005      	bres	20485,#2
4542  0a3f 3f00          	clr	_bVENT_BLOCK
4544  0a41 2047          	jra	L7132
4545  0a43               L5332:
4546                     ; 692 	else if(bps_class==bpsIBEP)
4548  0a43 3d01          	tnz	_bps_class
4549  0a45 2643          	jrne	L7132
4550                     ; 694 		if(ee_DEVICE)
4552  0a47 ce0002        	ldw	x,_ee_DEVICE
4553  0a4a 2718          	jreq	L3432
4554                     ; 696 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4556  0a4c b60b          	ld	a,_flags
4557  0a4e a520          	bcp	a,#32
4558  0a50 270a          	jreq	L5432
4561  0a52 72145005      	bset	20485,#2
4564  0a56 35010000      	mov	_bVENT_BLOCK,#1
4566  0a5a 202e          	jra	L7132
4567  0a5c               L5432:
4568                     ; 697 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4570  0a5c 72155005      	bres	20485,#2
4573  0a60 3f00          	clr	_bVENT_BLOCK
4574  0a62 2026          	jra	L7132
4575  0a64               L3432:
4576                     ; 701 			BLOCK_OFF
4578  0a64 72155005      	bres	20485,#2
4581  0a68 3f00          	clr	_bVENT_BLOCK
4582  0a6a 201e          	jra	L7132
4583  0a6c               L3332:
4584                     ; 706 else if(bBL)
4586                     	btst	_bBL
4587  0a71 240a          	jruge	L5532
4588                     ; 708 	BLOCK_ON
4590  0a73 72145005      	bset	20485,#2
4593  0a77 35010000      	mov	_bVENT_BLOCK,#1
4595  0a7b 200d          	jra	L7132
4596  0a7d               L5532:
4597                     ; 711 else if(!bBL)
4599                     	btst	_bBL
4600  0a82 2506          	jrult	L7132
4601                     ; 713 	BLOCK_OFF
4603  0a84 72155005      	bres	20485,#2
4606  0a88 3f00          	clr	_bVENT_BLOCK
4607  0a8a               L7132:
4608                     ; 717 gran(&pwm_u,2,1020);
4610  0a8a ae03fc        	ldw	x,#1020
4611  0a8d 89            	pushw	x
4612  0a8e ae0002        	ldw	x,#2
4613  0a91 89            	pushw	x
4614  0a92 ae000c        	ldw	x,#_pwm_u
4615  0a95 cd0000        	call	_gran
4617  0a98 5b04          	addw	sp,#4
4618                     ; 727 TIM1->CCR2H= (char)(pwm_u/256);	
4620  0a9a be0c          	ldw	x,_pwm_u
4621  0a9c 90ae0100      	ldw	y,#256
4622  0aa0 cd0000        	call	c_idiv
4624  0aa3 9f            	ld	a,xl
4625  0aa4 c75267        	ld	21095,a
4626                     ; 728 TIM1->CCR2L= (char)pwm_u;
4628  0aa7 55000d5268    	mov	21096,_pwm_u+1
4629                     ; 730 TIM1->CCR1H= (char)(pwm_i/256);	
4631  0aac be0e          	ldw	x,_pwm_i
4632  0aae 90ae0100      	ldw	y,#256
4633  0ab2 cd0000        	call	c_idiv
4635  0ab5 9f            	ld	a,xl
4636  0ab6 c75265        	ld	21093,a
4637                     ; 731 TIM1->CCR1L= (char)pwm_i;
4639  0ab9 55000f5266    	mov	21094,_pwm_i+1
4640                     ; 733 TIM1->CCR3H= (char)(vent_pwm/256);	
4642  0abe be02          	ldw	x,_vent_pwm
4643  0ac0 90ae0100      	ldw	y,#256
4644  0ac4 cd0000        	call	c_idiv
4646  0ac7 9f            	ld	a,xl
4647  0ac8 c75269        	ld	21097,a
4648                     ; 734 TIM1->CCR3L= (char)vent_pwm;
4650  0acb 550003526a    	mov	21098,_vent_pwm+1
4651                     ; 735 }
4654  0ad0 81            	ret
4692                     ; 740 void pwr_hndl(void)				
4692                     ; 741 {
4693                     	switch	.text
4694  0ad1               _pwr_hndl:
4698                     ; 742 if(jp_mode==jp3)
4700  0ad1 b647          	ld	a,_jp_mode
4701  0ad3 a103          	cp	a,#3
4702  0ad5 2627          	jrne	L3732
4703                     ; 744 	if((flags&0b00001010)==0)
4705  0ad7 b60b          	ld	a,_flags
4706  0ad9 a50a          	bcp	a,#10
4707  0adb 260d          	jrne	L5732
4708                     ; 746 		pwm_u=500;
4710  0add ae01f4        	ldw	x,#500
4711  0ae0 bf0c          	ldw	_pwm_u,x
4712                     ; 748 		bBL=0;
4714  0ae2 72110003      	bres	_bBL
4716  0ae6 acec0bec      	jpf	L3042
4717  0aea               L5732:
4718                     ; 750 	else if(flags&0b00001010)
4720  0aea b60b          	ld	a,_flags
4721  0aec a50a          	bcp	a,#10
4722  0aee 2603          	jrne	L06
4723  0af0 cc0bec        	jp	L3042
4724  0af3               L06:
4725                     ; 752 		pwm_u=0;
4727  0af3 5f            	clrw	x
4728  0af4 bf0c          	ldw	_pwm_u,x
4729                     ; 754 		bBL=1;
4731  0af6 72100003      	bset	_bBL
4732  0afa acec0bec      	jpf	L3042
4733  0afe               L3732:
4734                     ; 758 else if(jp_mode==jp2)
4736  0afe b647          	ld	a,_jp_mode
4737  0b00 a102          	cp	a,#2
4738  0b02 2610          	jrne	L5042
4739                     ; 760 	pwm_u=0;
4741  0b04 5f            	clrw	x
4742  0b05 bf0c          	ldw	_pwm_u,x
4743                     ; 761 	pwm_i=0x3ff;
4745  0b07 ae03ff        	ldw	x,#1023
4746  0b0a bf0e          	ldw	_pwm_i,x
4747                     ; 762 	bBL=0;
4749  0b0c 72110003      	bres	_bBL
4751  0b10 acec0bec      	jpf	L3042
4752  0b14               L5042:
4753                     ; 764 else if(jp_mode==jp1)
4755  0b14 b647          	ld	a,_jp_mode
4756  0b16 a101          	cp	a,#1
4757  0b18 2612          	jrne	L1142
4758                     ; 766 	pwm_u=0x3ff;
4760  0b1a ae03ff        	ldw	x,#1023
4761  0b1d bf0c          	ldw	_pwm_u,x
4762                     ; 767 	pwm_i=0x3ff;
4764  0b1f ae03ff        	ldw	x,#1023
4765  0b22 bf0e          	ldw	_pwm_i,x
4766                     ; 768 	bBL=0;
4768  0b24 72110003      	bres	_bBL
4770  0b28 acec0bec      	jpf	L3042
4771  0b2c               L1142:
4772                     ; 771 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4774                     	btst	_bMAIN
4775  0b31 2417          	jruge	L5142
4777  0b33 b65f          	ld	a,_link
4778  0b35 a155          	cp	a,#85
4779  0b37 2611          	jrne	L5142
4780                     ; 773 	pwm_u=volum_u_main_;
4782  0b39 be1d          	ldw	x,_volum_u_main_
4783  0b3b bf0c          	ldw	_pwm_u,x
4784                     ; 774 	pwm_i=0x3ff;
4786  0b3d ae03ff        	ldw	x,#1023
4787  0b40 bf0e          	ldw	_pwm_i,x
4788                     ; 775 	bBL_IPS=0;
4790  0b42 72110000      	bres	_bBL_IPS
4792  0b46 acec0bec      	jpf	L3042
4793  0b4a               L5142:
4794                     ; 778 else if(link==OFF)
4796  0b4a b65f          	ld	a,_link
4797  0b4c a1aa          	cp	a,#170
4798  0b4e 2650          	jrne	L1242
4799                     ; 787  	if(ee_DEVICE)
4801  0b50 ce0002        	ldw	x,_ee_DEVICE
4802  0b53 270d          	jreq	L3242
4803                     ; 789 		pwm_u=0x00;
4805  0b55 5f            	clrw	x
4806  0b56 bf0c          	ldw	_pwm_u,x
4807                     ; 790 		pwm_i=0x00;
4809  0b58 5f            	clrw	x
4810  0b59 bf0e          	ldw	_pwm_i,x
4811                     ; 791 		bBL=1;
4813  0b5b 72100003      	bset	_bBL
4815  0b5f cc0bec        	jra	L3042
4816  0b62               L3242:
4817                     ; 795 		if((flags&0b00011010)==0)
4819  0b62 b60b          	ld	a,_flags
4820  0b64 a51a          	bcp	a,#26
4821  0b66 2622          	jrne	L7242
4822                     ; 797 			pwm_u=ee_U_AVT;
4824  0b68 ce000a        	ldw	x,_ee_U_AVT
4825  0b6b bf0c          	ldw	_pwm_u,x
4826                     ; 798 			gran(&pwm_u,0,1020);
4828  0b6d ae03fc        	ldw	x,#1020
4829  0b70 89            	pushw	x
4830  0b71 5f            	clrw	x
4831  0b72 89            	pushw	x
4832  0b73 ae000c        	ldw	x,#_pwm_u
4833  0b76 cd0000        	call	_gran
4835  0b79 5b04          	addw	sp,#4
4836                     ; 799 		    	pwm_i=0x3ff;
4838  0b7b ae03ff        	ldw	x,#1023
4839  0b7e bf0e          	ldw	_pwm_i,x
4840                     ; 800 			bBL=0;
4842  0b80 72110003      	bres	_bBL
4843                     ; 801 			bBL_IPS=0;
4845  0b84 72110000      	bres	_bBL_IPS
4847  0b88 2062          	jra	L3042
4848  0b8a               L7242:
4849                     ; 803 		else if(flags&0b00011010)
4851  0b8a b60b          	ld	a,_flags
4852  0b8c a51a          	bcp	a,#26
4853  0b8e 275c          	jreq	L3042
4854                     ; 805 			pwm_u=0;
4856  0b90 5f            	clrw	x
4857  0b91 bf0c          	ldw	_pwm_u,x
4858                     ; 806 			pwm_i=0;
4860  0b93 5f            	clrw	x
4861  0b94 bf0e          	ldw	_pwm_i,x
4862                     ; 807 			bBL=1;
4864  0b96 72100003      	bset	_bBL
4865                     ; 808 			bBL_IPS=1;
4867  0b9a 72100000      	bset	_bBL_IPS
4868  0b9e 204c          	jra	L3042
4869  0ba0               L1242:
4870                     ; 817 else	if(link==ON)				//если есть связь
4872  0ba0 b65f          	ld	a,_link
4873  0ba2 a155          	cp	a,#85
4874  0ba4 2646          	jrne	L3042
4875                     ; 819 	if((flags&0b00100000)==0)	//если нет блокировки извне
4877  0ba6 b60b          	ld	a,_flags
4878  0ba8 a520          	bcp	a,#32
4879  0baa 2630          	jrne	L1442
4880                     ; 821 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4882  0bac b60b          	ld	a,_flags
4883  0bae a51a          	bcp	a,#26
4884  0bb0 2706          	jreq	L5442
4886  0bb2 b60b          	ld	a,_flags
4887  0bb4 a540          	bcp	a,#64
4888  0bb6 2712          	jreq	L3442
4889  0bb8               L5442:
4890                     ; 823 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4892  0bb8 be5b          	ldw	x,__x_
4893  0bba 72bb0055      	addw	x,_vol_u_temp
4894  0bbe bf0c          	ldw	_pwm_u,x
4895                     ; 824 		    	pwm_i=vol_i_temp;
4897  0bc0 be53          	ldw	x,_vol_i_temp
4898  0bc2 bf0e          	ldw	_pwm_i,x
4899                     ; 825 			bBL=0;
4901  0bc4 72110003      	bres	_bBL
4903  0bc8 2022          	jra	L3042
4904  0bca               L3442:
4905                     ; 827 		else if(flags&0b00011010)					//если есть аварии
4907  0bca b60b          	ld	a,_flags
4908  0bcc a51a          	bcp	a,#26
4909  0bce 271c          	jreq	L3042
4910                     ; 829 			pwm_u=0;								//то полный стоп
4912  0bd0 5f            	clrw	x
4913  0bd1 bf0c          	ldw	_pwm_u,x
4914                     ; 830 			pwm_i=0;
4916  0bd3 5f            	clrw	x
4917  0bd4 bf0e          	ldw	_pwm_i,x
4918                     ; 831 			bBL=1;
4920  0bd6 72100003      	bset	_bBL
4921  0bda 2010          	jra	L3042
4922  0bdc               L1442:
4923                     ; 834 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4925  0bdc b60b          	ld	a,_flags
4926  0bde a520          	bcp	a,#32
4927  0be0 270a          	jreq	L3042
4928                     ; 836 		pwm_u=0;
4930  0be2 5f            	clrw	x
4931  0be3 bf0c          	ldw	_pwm_u,x
4932                     ; 837 	    	pwm_i=0;
4934  0be5 5f            	clrw	x
4935  0be6 bf0e          	ldw	_pwm_i,x
4936                     ; 838 		bBL=1;
4938  0be8 72100003      	bset	_bBL
4939  0bec               L3042:
4940                     ; 844 }
4943  0bec 81            	ret
4985                     	switch	.const
4986  0008               L46:
4987  0008 00000258      	dc.l	600
4988  000c               L66:
4989  000c 000003e8      	dc.l	1000
4990  0010               L07:
4991  0010 00000708      	dc.l	1800
4992                     ; 847 void matemat(void)
4992                     ; 848 {
4993                     	switch	.text
4994  0bed               _matemat:
4996  0bed 5204          	subw	sp,#4
4997       00000004      OFST:	set	4
5000                     ; 869 temp_SL=adc_buff_[4];
5002  0bef ce000d        	ldw	x,_adc_buff_+8
5003  0bf2 cd0000        	call	c_itolx
5005  0bf5 96            	ldw	x,sp
5006  0bf6 1c0001        	addw	x,#OFST-3
5007  0bf9 cd0000        	call	c_rtol
5009                     ; 870 temp_SL-=ee_K[0][0];
5011  0bfc ce0018        	ldw	x,_ee_K
5012  0bff cd0000        	call	c_itolx
5014  0c02 96            	ldw	x,sp
5015  0c03 1c0001        	addw	x,#OFST-3
5016  0c06 cd0000        	call	c_lgsub
5018                     ; 871 if(temp_SL<0) temp_SL=0;
5020  0c09 9c            	rvf
5021  0c0a 0d01          	tnz	(OFST-3,sp)
5022  0c0c 2e0a          	jrsge	L5742
5025  0c0e ae0000        	ldw	x,#0
5026  0c11 1f03          	ldw	(OFST-1,sp),x
5027  0c13 ae0000        	ldw	x,#0
5028  0c16 1f01          	ldw	(OFST-3,sp),x
5029  0c18               L5742:
5030                     ; 872 temp_SL*=ee_K[0][1];
5032  0c18 ce001a        	ldw	x,_ee_K+2
5033  0c1b cd0000        	call	c_itolx
5035  0c1e 96            	ldw	x,sp
5036  0c1f 1c0001        	addw	x,#OFST-3
5037  0c22 cd0000        	call	c_lgmul
5039                     ; 873 temp_SL/=600;
5041  0c25 96            	ldw	x,sp
5042  0c26 1c0001        	addw	x,#OFST-3
5043  0c29 cd0000        	call	c_ltor
5045  0c2c ae0008        	ldw	x,#L46
5046  0c2f cd0000        	call	c_ldiv
5048  0c32 96            	ldw	x,sp
5049  0c33 1c0001        	addw	x,#OFST-3
5050  0c36 cd0000        	call	c_rtol
5052                     ; 874 I=(signed short)temp_SL;
5054  0c39 1e03          	ldw	x,(OFST-1,sp)
5055  0c3b bf6b          	ldw	_I,x
5056                     ; 879 temp_SL=(signed long)adc_buff_[1];
5058  0c3d ce0007        	ldw	x,_adc_buff_+2
5059  0c40 cd0000        	call	c_itolx
5061  0c43 96            	ldw	x,sp
5062  0c44 1c0001        	addw	x,#OFST-3
5063  0c47 cd0000        	call	c_rtol
5065                     ; 881 if(temp_SL<0) temp_SL=0;
5067  0c4a 9c            	rvf
5068  0c4b 0d01          	tnz	(OFST-3,sp)
5069  0c4d 2e0a          	jrsge	L7742
5072  0c4f ae0000        	ldw	x,#0
5073  0c52 1f03          	ldw	(OFST-1,sp),x
5074  0c54 ae0000        	ldw	x,#0
5075  0c57 1f01          	ldw	(OFST-3,sp),x
5076  0c59               L7742:
5077                     ; 882 temp_SL*=(signed long)ee_K[2][1];
5079  0c59 ce0022        	ldw	x,_ee_K+10
5080  0c5c cd0000        	call	c_itolx
5082  0c5f 96            	ldw	x,sp
5083  0c60 1c0001        	addw	x,#OFST-3
5084  0c63 cd0000        	call	c_lgmul
5086                     ; 883 temp_SL/=1000L;
5088  0c66 96            	ldw	x,sp
5089  0c67 1c0001        	addw	x,#OFST-3
5090  0c6a cd0000        	call	c_ltor
5092  0c6d ae000c        	ldw	x,#L66
5093  0c70 cd0000        	call	c_ldiv
5095  0c73 96            	ldw	x,sp
5096  0c74 1c0001        	addw	x,#OFST-3
5097  0c77 cd0000        	call	c_rtol
5099                     ; 884 Ui=(unsigned short)temp_SL;
5101  0c7a 1e03          	ldw	x,(OFST-1,sp)
5102  0c7c bf67          	ldw	_Ui,x
5103                     ; 891 temp_SL=adc_buff_[3];
5105  0c7e ce000b        	ldw	x,_adc_buff_+6
5106  0c81 cd0000        	call	c_itolx
5108  0c84 96            	ldw	x,sp
5109  0c85 1c0001        	addw	x,#OFST-3
5110  0c88 cd0000        	call	c_rtol
5112                     ; 893 if(temp_SL<0) temp_SL=0;
5114  0c8b 9c            	rvf
5115  0c8c 0d01          	tnz	(OFST-3,sp)
5116  0c8e 2e0a          	jrsge	L1052
5119  0c90 ae0000        	ldw	x,#0
5120  0c93 1f03          	ldw	(OFST-1,sp),x
5121  0c95 ae0000        	ldw	x,#0
5122  0c98 1f01          	ldw	(OFST-3,sp),x
5123  0c9a               L1052:
5124                     ; 894 temp_SL*=ee_K[1][1];
5126  0c9a ce001e        	ldw	x,_ee_K+6
5127  0c9d cd0000        	call	c_itolx
5129  0ca0 96            	ldw	x,sp
5130  0ca1 1c0001        	addw	x,#OFST-3
5131  0ca4 cd0000        	call	c_lgmul
5133                     ; 895 temp_SL/=1800;
5135  0ca7 96            	ldw	x,sp
5136  0ca8 1c0001        	addw	x,#OFST-3
5137  0cab cd0000        	call	c_ltor
5139  0cae ae0010        	ldw	x,#L07
5140  0cb1 cd0000        	call	c_ldiv
5142  0cb4 96            	ldw	x,sp
5143  0cb5 1c0001        	addw	x,#OFST-3
5144  0cb8 cd0000        	call	c_rtol
5146                     ; 896 Un=(unsigned short)temp_SL;
5148  0cbb 1e03          	ldw	x,(OFST-1,sp)
5149  0cbd bf69          	ldw	_Un,x
5150                     ; 899 temp_SL=adc_buff_[2];
5152  0cbf ce0009        	ldw	x,_adc_buff_+4
5153  0cc2 cd0000        	call	c_itolx
5155  0cc5 96            	ldw	x,sp
5156  0cc6 1c0001        	addw	x,#OFST-3
5157  0cc9 cd0000        	call	c_rtol
5159                     ; 900 temp_SL*=ee_K[3][1];
5161  0ccc ce0026        	ldw	x,_ee_K+14
5162  0ccf cd0000        	call	c_itolx
5164  0cd2 96            	ldw	x,sp
5165  0cd3 1c0001        	addw	x,#OFST-3
5166  0cd6 cd0000        	call	c_lgmul
5168                     ; 901 temp_SL/=1000;
5170  0cd9 96            	ldw	x,sp
5171  0cda 1c0001        	addw	x,#OFST-3
5172  0cdd cd0000        	call	c_ltor
5174  0ce0 ae000c        	ldw	x,#L66
5175  0ce3 cd0000        	call	c_ldiv
5177  0ce6 96            	ldw	x,sp
5178  0ce7 1c0001        	addw	x,#OFST-3
5179  0cea cd0000        	call	c_rtol
5181                     ; 902 T=(signed short)(temp_SL-273L);
5183  0ced 7b04          	ld	a,(OFST+0,sp)
5184  0cef 5f            	clrw	x
5185  0cf0 4d            	tnz	a
5186  0cf1 2a01          	jrpl	L27
5187  0cf3 53            	cplw	x
5188  0cf4               L27:
5189  0cf4 97            	ld	xl,a
5190  0cf5 1d0111        	subw	x,#273
5191  0cf8 01            	rrwa	x,a
5192  0cf9 b764          	ld	_T,a
5193  0cfb 02            	rlwa	x,a
5194                     ; 903 if(T<-30)T=-30;
5196  0cfc 9c            	rvf
5197  0cfd b664          	ld	a,_T
5198  0cff a1e2          	cp	a,#226
5199  0d01 2e04          	jrsge	L3052
5202  0d03 35e20064      	mov	_T,#226
5203  0d07               L3052:
5204                     ; 904 if(T>120)T=120;
5206  0d07 9c            	rvf
5207  0d08 b664          	ld	a,_T
5208  0d0a a179          	cp	a,#121
5209  0d0c 2f04          	jrslt	L5052
5212  0d0e 35780064      	mov	_T,#120
5213  0d12               L5052:
5214                     ; 906 Udb=flags;
5216  0d12 b60b          	ld	a,_flags
5217  0d14 5f            	clrw	x
5218  0d15 97            	ld	xl,a
5219  0d16 bf65          	ldw	_Udb,x
5220                     ; 912 }
5223  0d18 5b04          	addw	sp,#4
5224  0d1a 81            	ret
5255                     ; 915 void temper_drv(void)		//1 Hz
5255                     ; 916 {
5256                     	switch	.text
5257  0d1b               _temper_drv:
5261                     ; 918 if(T>ee_tsign) tsign_cnt++;
5263  0d1b 9c            	rvf
5264  0d1c 5f            	clrw	x
5265  0d1d b664          	ld	a,_T
5266  0d1f 2a01          	jrpl	L67
5267  0d21 53            	cplw	x
5268  0d22               L67:
5269  0d22 97            	ld	xl,a
5270  0d23 c3000c        	cpw	x,_ee_tsign
5271  0d26 2d09          	jrsle	L7152
5274  0d28 be4a          	ldw	x,_tsign_cnt
5275  0d2a 1c0001        	addw	x,#1
5276  0d2d bf4a          	ldw	_tsign_cnt,x
5278  0d2f 201d          	jra	L1252
5279  0d31               L7152:
5280                     ; 919 else if (T<(ee_tsign-1)) tsign_cnt--;
5282  0d31 9c            	rvf
5283  0d32 ce000c        	ldw	x,_ee_tsign
5284  0d35 5a            	decw	x
5285  0d36 905f          	clrw	y
5286  0d38 b664          	ld	a,_T
5287  0d3a 2a02          	jrpl	L001
5288  0d3c 9053          	cplw	y
5289  0d3e               L001:
5290  0d3e 9097          	ld	yl,a
5291  0d40 90bf00        	ldw	c_y,y
5292  0d43 b300          	cpw	x,c_y
5293  0d45 2d07          	jrsle	L1252
5296  0d47 be4a          	ldw	x,_tsign_cnt
5297  0d49 1d0001        	subw	x,#1
5298  0d4c bf4a          	ldw	_tsign_cnt,x
5299  0d4e               L1252:
5300                     ; 921 gran(&tsign_cnt,0,60);
5302  0d4e ae003c        	ldw	x,#60
5303  0d51 89            	pushw	x
5304  0d52 5f            	clrw	x
5305  0d53 89            	pushw	x
5306  0d54 ae004a        	ldw	x,#_tsign_cnt
5307  0d57 cd0000        	call	_gran
5309  0d5a 5b04          	addw	sp,#4
5310                     ; 923 if(tsign_cnt>=55)
5312  0d5c 9c            	rvf
5313  0d5d be4a          	ldw	x,_tsign_cnt
5314  0d5f a30037        	cpw	x,#55
5315  0d62 2f16          	jrslt	L5252
5316                     ; 925 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5318  0d64 3d47          	tnz	_jp_mode
5319  0d66 2606          	jrne	L3352
5321  0d68 b60b          	ld	a,_flags
5322  0d6a a540          	bcp	a,#64
5323  0d6c 2706          	jreq	L1352
5324  0d6e               L3352:
5326  0d6e b647          	ld	a,_jp_mode
5327  0d70 a103          	cp	a,#3
5328  0d72 2612          	jrne	L5352
5329  0d74               L1352:
5332  0d74 7214000b      	bset	_flags,#2
5333  0d78 200c          	jra	L5352
5334  0d7a               L5252:
5335                     ; 927 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5337  0d7a 9c            	rvf
5338  0d7b be4a          	ldw	x,_tsign_cnt
5339  0d7d a30006        	cpw	x,#6
5340  0d80 2e04          	jrsge	L5352
5343  0d82 7215000b      	bres	_flags,#2
5344  0d86               L5352:
5345                     ; 932 if(T>ee_tmax) tmax_cnt++;
5347  0d86 9c            	rvf
5348  0d87 5f            	clrw	x
5349  0d88 b664          	ld	a,_T
5350  0d8a 2a01          	jrpl	L201
5351  0d8c 53            	cplw	x
5352  0d8d               L201:
5353  0d8d 97            	ld	xl,a
5354  0d8e c3000e        	cpw	x,_ee_tmax
5355  0d91 2d09          	jrsle	L1452
5358  0d93 be48          	ldw	x,_tmax_cnt
5359  0d95 1c0001        	addw	x,#1
5360  0d98 bf48          	ldw	_tmax_cnt,x
5362  0d9a 201d          	jra	L3452
5363  0d9c               L1452:
5364                     ; 933 else if (T<(ee_tmax-1)) tmax_cnt--;
5366  0d9c 9c            	rvf
5367  0d9d ce000e        	ldw	x,_ee_tmax
5368  0da0 5a            	decw	x
5369  0da1 905f          	clrw	y
5370  0da3 b664          	ld	a,_T
5371  0da5 2a02          	jrpl	L401
5372  0da7 9053          	cplw	y
5373  0da9               L401:
5374  0da9 9097          	ld	yl,a
5375  0dab 90bf00        	ldw	c_y,y
5376  0dae b300          	cpw	x,c_y
5377  0db0 2d07          	jrsle	L3452
5380  0db2 be48          	ldw	x,_tmax_cnt
5381  0db4 1d0001        	subw	x,#1
5382  0db7 bf48          	ldw	_tmax_cnt,x
5383  0db9               L3452:
5384                     ; 935 gran(&tmax_cnt,0,60);
5386  0db9 ae003c        	ldw	x,#60
5387  0dbc 89            	pushw	x
5388  0dbd 5f            	clrw	x
5389  0dbe 89            	pushw	x
5390  0dbf ae0048        	ldw	x,#_tmax_cnt
5391  0dc2 cd0000        	call	_gran
5393  0dc5 5b04          	addw	sp,#4
5394                     ; 937 if(tmax_cnt>=55)
5396  0dc7 9c            	rvf
5397  0dc8 be48          	ldw	x,_tmax_cnt
5398  0dca a30037        	cpw	x,#55
5399  0dcd 2f16          	jrslt	L7452
5400                     ; 939 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5402  0dcf 3d47          	tnz	_jp_mode
5403  0dd1 2606          	jrne	L5552
5405  0dd3 b60b          	ld	a,_flags
5406  0dd5 a540          	bcp	a,#64
5407  0dd7 2706          	jreq	L3552
5408  0dd9               L5552:
5410  0dd9 b647          	ld	a,_jp_mode
5411  0ddb a103          	cp	a,#3
5412  0ddd 2612          	jrne	L7552
5413  0ddf               L3552:
5416  0ddf 7212000b      	bset	_flags,#1
5417  0de3 200c          	jra	L7552
5418  0de5               L7452:
5419                     ; 941 else if (tmax_cnt<=5) flags&=0b11111101;
5421  0de5 9c            	rvf
5422  0de6 be48          	ldw	x,_tmax_cnt
5423  0de8 a30006        	cpw	x,#6
5424  0deb 2e04          	jrsge	L7552
5427  0ded 7213000b      	bres	_flags,#1
5428  0df1               L7552:
5429                     ; 944 } 
5432  0df1 81            	ret
5464                     ; 947 void u_drv(void)		//1Hz
5464                     ; 948 { 
5465                     	switch	.text
5466  0df2               _u_drv:
5470                     ; 949 if(jp_mode!=jp3)
5472  0df2 b647          	ld	a,_jp_mode
5473  0df4 a103          	cp	a,#3
5474  0df6 2770          	jreq	L3752
5475                     ; 951 	if(Ui>ee_Umax)umax_cnt++;
5477  0df8 9c            	rvf
5478  0df9 be67          	ldw	x,_Ui
5479  0dfb c30012        	cpw	x,_ee_Umax
5480  0dfe 2d09          	jrsle	L5752
5483  0e00 be62          	ldw	x,_umax_cnt
5484  0e02 1c0001        	addw	x,#1
5485  0e05 bf62          	ldw	_umax_cnt,x
5487  0e07 2003          	jra	L7752
5488  0e09               L5752:
5489                     ; 952 	else umax_cnt=0;
5491  0e09 5f            	clrw	x
5492  0e0a bf62          	ldw	_umax_cnt,x
5493  0e0c               L7752:
5494                     ; 953 	gran(&umax_cnt,0,10);
5496  0e0c ae000a        	ldw	x,#10
5497  0e0f 89            	pushw	x
5498  0e10 5f            	clrw	x
5499  0e11 89            	pushw	x
5500  0e12 ae0062        	ldw	x,#_umax_cnt
5501  0e15 cd0000        	call	_gran
5503  0e18 5b04          	addw	sp,#4
5504                     ; 954 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5506  0e1a 9c            	rvf
5507  0e1b be62          	ldw	x,_umax_cnt
5508  0e1d a3000a        	cpw	x,#10
5509  0e20 2f04          	jrslt	L1062
5512  0e22 7216000b      	bset	_flags,#3
5513  0e26               L1062:
5514                     ; 957 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5516  0e26 9c            	rvf
5517  0e27 be67          	ldw	x,_Ui
5518  0e29 b369          	cpw	x,_Un
5519  0e2b 2e1c          	jrsge	L3062
5521  0e2d 9c            	rvf
5522  0e2e be69          	ldw	x,_Un
5523  0e30 72b00067      	subw	x,_Ui
5524  0e34 c30010        	cpw	x,_ee_dU
5525  0e37 2d10          	jrsle	L3062
5527  0e39 c65005        	ld	a,20485
5528  0e3c a504          	bcp	a,#4
5529  0e3e 2609          	jrne	L3062
5532  0e40 be60          	ldw	x,_umin_cnt
5533  0e42 1c0001        	addw	x,#1
5534  0e45 bf60          	ldw	_umin_cnt,x
5536  0e47 2003          	jra	L5062
5537  0e49               L3062:
5538                     ; 958 	else umin_cnt=0;
5540  0e49 5f            	clrw	x
5541  0e4a bf60          	ldw	_umin_cnt,x
5542  0e4c               L5062:
5543                     ; 959 	gran(&umin_cnt,0,10);	
5545  0e4c ae000a        	ldw	x,#10
5546  0e4f 89            	pushw	x
5547  0e50 5f            	clrw	x
5548  0e51 89            	pushw	x
5549  0e52 ae0060        	ldw	x,#_umin_cnt
5550  0e55 cd0000        	call	_gran
5552  0e58 5b04          	addw	sp,#4
5553                     ; 960 	if(umin_cnt>=10)flags|=0b00010000;	  
5555  0e5a 9c            	rvf
5556  0e5b be60          	ldw	x,_umin_cnt
5557  0e5d a3000a        	cpw	x,#10
5558  0e60 2f6f          	jrslt	L1162
5561  0e62 7218000b      	bset	_flags,#4
5562  0e66 2069          	jra	L1162
5563  0e68               L3752:
5564                     ; 962 else if(jp_mode==jp3)
5566  0e68 b647          	ld	a,_jp_mode
5567  0e6a a103          	cp	a,#3
5568  0e6c 2663          	jrne	L1162
5569                     ; 964 	if(Ui>700)umax_cnt++;
5571  0e6e 9c            	rvf
5572  0e6f be67          	ldw	x,_Ui
5573  0e71 a302bd        	cpw	x,#701
5574  0e74 2f09          	jrslt	L5162
5577  0e76 be62          	ldw	x,_umax_cnt
5578  0e78 1c0001        	addw	x,#1
5579  0e7b bf62          	ldw	_umax_cnt,x
5581  0e7d 2003          	jra	L7162
5582  0e7f               L5162:
5583                     ; 965 	else umax_cnt=0;
5585  0e7f 5f            	clrw	x
5586  0e80 bf62          	ldw	_umax_cnt,x
5587  0e82               L7162:
5588                     ; 966 	gran(&umax_cnt,0,10);
5590  0e82 ae000a        	ldw	x,#10
5591  0e85 89            	pushw	x
5592  0e86 5f            	clrw	x
5593  0e87 89            	pushw	x
5594  0e88 ae0062        	ldw	x,#_umax_cnt
5595  0e8b cd0000        	call	_gran
5597  0e8e 5b04          	addw	sp,#4
5598                     ; 967 	if(umax_cnt>=10)flags|=0b00001000;
5600  0e90 9c            	rvf
5601  0e91 be62          	ldw	x,_umax_cnt
5602  0e93 a3000a        	cpw	x,#10
5603  0e96 2f04          	jrslt	L1262
5606  0e98 7216000b      	bset	_flags,#3
5607  0e9c               L1262:
5608                     ; 970 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5610  0e9c 9c            	rvf
5611  0e9d be67          	ldw	x,_Ui
5612  0e9f a300c8        	cpw	x,#200
5613  0ea2 2e10          	jrsge	L3262
5615  0ea4 c65005        	ld	a,20485
5616  0ea7 a504          	bcp	a,#4
5617  0ea9 2609          	jrne	L3262
5620  0eab be60          	ldw	x,_umin_cnt
5621  0ead 1c0001        	addw	x,#1
5622  0eb0 bf60          	ldw	_umin_cnt,x
5624  0eb2 2003          	jra	L5262
5625  0eb4               L3262:
5626                     ; 971 	else umin_cnt=0;
5628  0eb4 5f            	clrw	x
5629  0eb5 bf60          	ldw	_umin_cnt,x
5630  0eb7               L5262:
5631                     ; 972 	gran(&umin_cnt,0,10);	
5633  0eb7 ae000a        	ldw	x,#10
5634  0eba 89            	pushw	x
5635  0ebb 5f            	clrw	x
5636  0ebc 89            	pushw	x
5637  0ebd ae0060        	ldw	x,#_umin_cnt
5638  0ec0 cd0000        	call	_gran
5640  0ec3 5b04          	addw	sp,#4
5641                     ; 973 	if(umin_cnt>=10)flags|=0b00010000;	  
5643  0ec5 9c            	rvf
5644  0ec6 be60          	ldw	x,_umin_cnt
5645  0ec8 a3000a        	cpw	x,#10
5646  0ecb 2f04          	jrslt	L1162
5649  0ecd 7218000b      	bset	_flags,#4
5650  0ed1               L1162:
5651                     ; 975 }
5654  0ed1 81            	ret
5681                     ; 978 void x_drv(void)
5681                     ; 979 {
5682                     	switch	.text
5683  0ed2               _x_drv:
5687                     ; 980 if(_x__==_x_)
5689  0ed2 be59          	ldw	x,__x__
5690  0ed4 b35b          	cpw	x,__x_
5691  0ed6 262a          	jrne	L1462
5692                     ; 982 	if(_x_cnt<60)
5694  0ed8 9c            	rvf
5695  0ed9 be57          	ldw	x,__x_cnt
5696  0edb a3003c        	cpw	x,#60
5697  0ede 2e25          	jrsge	L1562
5698                     ; 984 		_x_cnt++;
5700  0ee0 be57          	ldw	x,__x_cnt
5701  0ee2 1c0001        	addw	x,#1
5702  0ee5 bf57          	ldw	__x_cnt,x
5703                     ; 985 		if(_x_cnt>=60)
5705  0ee7 9c            	rvf
5706  0ee8 be57          	ldw	x,__x_cnt
5707  0eea a3003c        	cpw	x,#60
5708  0eed 2f16          	jrslt	L1562
5709                     ; 987 			if(_x_ee_!=_x_)_x_ee_=_x_;
5711  0eef ce0016        	ldw	x,__x_ee_
5712  0ef2 b35b          	cpw	x,__x_
5713  0ef4 270f          	jreq	L1562
5716  0ef6 be5b          	ldw	x,__x_
5717  0ef8 89            	pushw	x
5718  0ef9 ae0016        	ldw	x,#__x_ee_
5719  0efc cd0000        	call	c_eewrw
5721  0eff 85            	popw	x
5722  0f00 2003          	jra	L1562
5723  0f02               L1462:
5724                     ; 992 else _x_cnt=0;
5726  0f02 5f            	clrw	x
5727  0f03 bf57          	ldw	__x_cnt,x
5728  0f05               L1562:
5729                     ; 994 if(_x_cnt>60) _x_cnt=0;	
5731  0f05 9c            	rvf
5732  0f06 be57          	ldw	x,__x_cnt
5733  0f08 a3003d        	cpw	x,#61
5734  0f0b 2f03          	jrslt	L3562
5737  0f0d 5f            	clrw	x
5738  0f0e bf57          	ldw	__x_cnt,x
5739  0f10               L3562:
5740                     ; 996 _x__=_x_;
5742  0f10 be5b          	ldw	x,__x_
5743  0f12 bf59          	ldw	__x__,x
5744                     ; 997 }
5747  0f14 81            	ret
5773                     ; 1000 void apv_start(void)
5773                     ; 1001 {
5774                     	switch	.text
5775  0f15               _apv_start:
5779                     ; 1002 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5781  0f15 3d42          	tnz	_apv_cnt
5782  0f17 2624          	jrne	L5662
5784  0f19 3d43          	tnz	_apv_cnt+1
5785  0f1b 2620          	jrne	L5662
5787  0f1d 3d44          	tnz	_apv_cnt+2
5788  0f1f 261c          	jrne	L5662
5790                     	btst	_bAPV
5791  0f26 2515          	jrult	L5662
5792                     ; 1004 	apv_cnt[0]=60;
5794  0f28 353c0042      	mov	_apv_cnt,#60
5795                     ; 1005 	apv_cnt[1]=60;
5797  0f2c 353c0043      	mov	_apv_cnt+1,#60
5798                     ; 1006 	apv_cnt[2]=60;
5800  0f30 353c0044      	mov	_apv_cnt+2,#60
5801                     ; 1007 	apv_cnt_=3600;
5803  0f34 ae0e10        	ldw	x,#3600
5804  0f37 bf40          	ldw	_apv_cnt_,x
5805                     ; 1008 	bAPV=1;	
5807  0f39 72100002      	bset	_bAPV
5808  0f3d               L5662:
5809                     ; 1010 }
5812  0f3d 81            	ret
5838                     ; 1013 void apv_stop(void)
5838                     ; 1014 {
5839                     	switch	.text
5840  0f3e               _apv_stop:
5844                     ; 1015 apv_cnt[0]=0;
5846  0f3e 3f42          	clr	_apv_cnt
5847                     ; 1016 apv_cnt[1]=0;
5849  0f40 3f43          	clr	_apv_cnt+1
5850                     ; 1017 apv_cnt[2]=0;
5852  0f42 3f44          	clr	_apv_cnt+2
5853                     ; 1018 apv_cnt_=0;	
5855  0f44 5f            	clrw	x
5856  0f45 bf40          	ldw	_apv_cnt_,x
5857                     ; 1019 bAPV=0;
5859  0f47 72110002      	bres	_bAPV
5860                     ; 1020 }
5863  0f4b 81            	ret
5898                     ; 1024 void apv_hndl(void)
5898                     ; 1025 {
5899                     	switch	.text
5900  0f4c               _apv_hndl:
5904                     ; 1026 if(apv_cnt[0])
5906  0f4c 3d42          	tnz	_apv_cnt
5907  0f4e 271e          	jreq	L7072
5908                     ; 1028 	apv_cnt[0]--;
5910  0f50 3a42          	dec	_apv_cnt
5911                     ; 1029 	if(apv_cnt[0]==0)
5913  0f52 3d42          	tnz	_apv_cnt
5914  0f54 265a          	jrne	L3172
5915                     ; 1031 		flags&=0b11100001;
5917  0f56 b60b          	ld	a,_flags
5918  0f58 a4e1          	and	a,#225
5919  0f5a b70b          	ld	_flags,a
5920                     ; 1032 		tsign_cnt=0;
5922  0f5c 5f            	clrw	x
5923  0f5d bf4a          	ldw	_tsign_cnt,x
5924                     ; 1033 		tmax_cnt=0;
5926  0f5f 5f            	clrw	x
5927  0f60 bf48          	ldw	_tmax_cnt,x
5928                     ; 1034 		umax_cnt=0;
5930  0f62 5f            	clrw	x
5931  0f63 bf62          	ldw	_umax_cnt,x
5932                     ; 1035 		umin_cnt=0;
5934  0f65 5f            	clrw	x
5935  0f66 bf60          	ldw	_umin_cnt,x
5936                     ; 1037 		led_drv_cnt=30;
5938  0f68 351e001a      	mov	_led_drv_cnt,#30
5939  0f6c 2042          	jra	L3172
5940  0f6e               L7072:
5941                     ; 1040 else if(apv_cnt[1])
5943  0f6e 3d43          	tnz	_apv_cnt+1
5944  0f70 271e          	jreq	L5172
5945                     ; 1042 	apv_cnt[1]--;
5947  0f72 3a43          	dec	_apv_cnt+1
5948                     ; 1043 	if(apv_cnt[1]==0)
5950  0f74 3d43          	tnz	_apv_cnt+1
5951  0f76 2638          	jrne	L3172
5952                     ; 1045 		flags&=0b11100001;
5954  0f78 b60b          	ld	a,_flags
5955  0f7a a4e1          	and	a,#225
5956  0f7c b70b          	ld	_flags,a
5957                     ; 1046 		tsign_cnt=0;
5959  0f7e 5f            	clrw	x
5960  0f7f bf4a          	ldw	_tsign_cnt,x
5961                     ; 1047 		tmax_cnt=0;
5963  0f81 5f            	clrw	x
5964  0f82 bf48          	ldw	_tmax_cnt,x
5965                     ; 1048 		umax_cnt=0;
5967  0f84 5f            	clrw	x
5968  0f85 bf62          	ldw	_umax_cnt,x
5969                     ; 1049 		umin_cnt=0;
5971  0f87 5f            	clrw	x
5972  0f88 bf60          	ldw	_umin_cnt,x
5973                     ; 1051 		led_drv_cnt=30;
5975  0f8a 351e001a      	mov	_led_drv_cnt,#30
5976  0f8e 2020          	jra	L3172
5977  0f90               L5172:
5978                     ; 1054 else if(apv_cnt[2])
5980  0f90 3d44          	tnz	_apv_cnt+2
5981  0f92 271c          	jreq	L3172
5982                     ; 1056 	apv_cnt[2]--;
5984  0f94 3a44          	dec	_apv_cnt+2
5985                     ; 1057 	if(apv_cnt[2]==0)
5987  0f96 3d44          	tnz	_apv_cnt+2
5988  0f98 2616          	jrne	L3172
5989                     ; 1059 		flags&=0b11100001;
5991  0f9a b60b          	ld	a,_flags
5992  0f9c a4e1          	and	a,#225
5993  0f9e b70b          	ld	_flags,a
5994                     ; 1060 		tsign_cnt=0;
5996  0fa0 5f            	clrw	x
5997  0fa1 bf4a          	ldw	_tsign_cnt,x
5998                     ; 1061 		tmax_cnt=0;
6000  0fa3 5f            	clrw	x
6001  0fa4 bf48          	ldw	_tmax_cnt,x
6002                     ; 1062 		umax_cnt=0;
6004  0fa6 5f            	clrw	x
6005  0fa7 bf62          	ldw	_umax_cnt,x
6006                     ; 1063 		umin_cnt=0;          
6008  0fa9 5f            	clrw	x
6009  0faa bf60          	ldw	_umin_cnt,x
6010                     ; 1065 		led_drv_cnt=30;
6012  0fac 351e001a      	mov	_led_drv_cnt,#30
6013  0fb0               L3172:
6014                     ; 1069 if(apv_cnt_)
6016  0fb0 be40          	ldw	x,_apv_cnt_
6017  0fb2 2712          	jreq	L7272
6018                     ; 1071 	apv_cnt_--;
6020  0fb4 be40          	ldw	x,_apv_cnt_
6021  0fb6 1d0001        	subw	x,#1
6022  0fb9 bf40          	ldw	_apv_cnt_,x
6023                     ; 1072 	if(apv_cnt_==0) 
6025  0fbb be40          	ldw	x,_apv_cnt_
6026  0fbd 2607          	jrne	L7272
6027                     ; 1074 		bAPV=0;
6029  0fbf 72110002      	bres	_bAPV
6030                     ; 1075 		apv_start();
6032  0fc3 cd0f15        	call	_apv_start
6034  0fc6               L7272:
6035                     ; 1079 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6037  0fc6 be60          	ldw	x,_umin_cnt
6038  0fc8 261e          	jrne	L3372
6040  0fca be62          	ldw	x,_umax_cnt
6041  0fcc 261a          	jrne	L3372
6043  0fce c65005        	ld	a,20485
6044  0fd1 a504          	bcp	a,#4
6045  0fd3 2613          	jrne	L3372
6046                     ; 1081 	if(cnt_apv_off<20)
6048  0fd5 b63f          	ld	a,_cnt_apv_off
6049  0fd7 a114          	cp	a,#20
6050  0fd9 240f          	jruge	L1472
6051                     ; 1083 		cnt_apv_off++;
6053  0fdb 3c3f          	inc	_cnt_apv_off
6054                     ; 1084 		if(cnt_apv_off>=20)
6056  0fdd b63f          	ld	a,_cnt_apv_off
6057  0fdf a114          	cp	a,#20
6058  0fe1 2507          	jrult	L1472
6059                     ; 1086 			apv_stop();
6061  0fe3 cd0f3e        	call	_apv_stop
6063  0fe6 2002          	jra	L1472
6064  0fe8               L3372:
6065                     ; 1090 else cnt_apv_off=0;	
6067  0fe8 3f3f          	clr	_cnt_apv_off
6068  0fea               L1472:
6069                     ; 1092 }
6072  0fea 81            	ret
6075                     	switch	.ubsct
6076  0000               L3472_flags_old:
6077  0000 00            	ds.b	1
6113                     ; 1095 void flags_drv(void)
6113                     ; 1096 {
6114                     	switch	.text
6115  0feb               _flags_drv:
6119                     ; 1098 if(jp_mode!=jp3) 
6121  0feb b647          	ld	a,_jp_mode
6122  0fed a103          	cp	a,#3
6123  0fef 2723          	jreq	L3672
6124                     ; 1100 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6126  0ff1 b60b          	ld	a,_flags
6127  0ff3 a508          	bcp	a,#8
6128  0ff5 2706          	jreq	L1772
6130  0ff7 b600          	ld	a,L3472_flags_old
6131  0ff9 a508          	bcp	a,#8
6132  0ffb 270c          	jreq	L7672
6133  0ffd               L1772:
6135  0ffd b60b          	ld	a,_flags
6136  0fff a510          	bcp	a,#16
6137  1001 2726          	jreq	L5772
6139  1003 b600          	ld	a,L3472_flags_old
6140  1005 a510          	bcp	a,#16
6141  1007 2620          	jrne	L5772
6142  1009               L7672:
6143                     ; 1102     		if(link==OFF)apv_start();
6145  1009 b65f          	ld	a,_link
6146  100b a1aa          	cp	a,#170
6147  100d 261a          	jrne	L5772
6150  100f cd0f15        	call	_apv_start
6152  1012 2015          	jra	L5772
6153  1014               L3672:
6154                     ; 1105 else if(jp_mode==jp3) 
6156  1014 b647          	ld	a,_jp_mode
6157  1016 a103          	cp	a,#3
6158  1018 260f          	jrne	L5772
6159                     ; 1107 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6161  101a b60b          	ld	a,_flags
6162  101c a508          	bcp	a,#8
6163  101e 2709          	jreq	L5772
6165  1020 b600          	ld	a,L3472_flags_old
6166  1022 a508          	bcp	a,#8
6167  1024 2603          	jrne	L5772
6168                     ; 1109     		apv_start();
6170  1026 cd0f15        	call	_apv_start
6172  1029               L5772:
6173                     ; 1112 flags_old=flags;
6175  1029 450b00        	mov	L3472_flags_old,_flags
6176                     ; 1114 } 
6179  102c 81            	ret
6214                     ; 1251 void adr_drv_v4(char in)
6214                     ; 1252 {
6215                     	switch	.text
6216  102d               _adr_drv_v4:
6220                     ; 1253 if(adress!=in)adress=in;
6222  102d c10001        	cp	a,_adress
6223  1030 2703          	jreq	L1203
6226  1032 c70001        	ld	_adress,a
6227  1035               L1203:
6228                     ; 1254 }
6231  1035 81            	ret
6260                     ; 1257 void adr_drv_v3(void)
6260                     ; 1258 {
6261                     	switch	.text
6262  1036               _adr_drv_v3:
6264  1036 88            	push	a
6265       00000001      OFST:	set	1
6268                     ; 1264 GPIOB->DDR&=~(1<<0);
6270  1037 72115007      	bres	20487,#0
6271                     ; 1265 GPIOB->CR1&=~(1<<0);
6273  103b 72115008      	bres	20488,#0
6274                     ; 1266 GPIOB->CR2&=~(1<<0);
6276  103f 72115009      	bres	20489,#0
6277                     ; 1267 ADC2->CR2=0x08;
6279  1043 35085402      	mov	21506,#8
6280                     ; 1268 ADC2->CR1=0x40;
6282  1047 35405401      	mov	21505,#64
6283                     ; 1269 ADC2->CSR=0x20+0;
6285  104b 35205400      	mov	21504,#32
6286                     ; 1270 ADC2->CR1|=1;
6288  104f 72105401      	bset	21505,#0
6289                     ; 1271 ADC2->CR1|=1;
6291  1053 72105401      	bset	21505,#0
6292                     ; 1272 adr_drv_stat=1;
6294  1057 35010008      	mov	_adr_drv_stat,#1
6295  105b               L3303:
6296                     ; 1273 while(adr_drv_stat==1);
6299  105b b608          	ld	a,_adr_drv_stat
6300  105d a101          	cp	a,#1
6301  105f 27fa          	jreq	L3303
6302                     ; 1275 GPIOB->DDR&=~(1<<1);
6304  1061 72135007      	bres	20487,#1
6305                     ; 1276 GPIOB->CR1&=~(1<<1);
6307  1065 72135008      	bres	20488,#1
6308                     ; 1277 GPIOB->CR2&=~(1<<1);
6310  1069 72135009      	bres	20489,#1
6311                     ; 1278 ADC2->CR2=0x08;
6313  106d 35085402      	mov	21506,#8
6314                     ; 1279 ADC2->CR1=0x40;
6316  1071 35405401      	mov	21505,#64
6317                     ; 1280 ADC2->CSR=0x20+1;
6319  1075 35215400      	mov	21504,#33
6320                     ; 1281 ADC2->CR1|=1;
6322  1079 72105401      	bset	21505,#0
6323                     ; 1282 ADC2->CR1|=1;
6325  107d 72105401      	bset	21505,#0
6326                     ; 1283 adr_drv_stat=3;
6328  1081 35030008      	mov	_adr_drv_stat,#3
6329  1085               L1403:
6330                     ; 1284 while(adr_drv_stat==3);
6333  1085 b608          	ld	a,_adr_drv_stat
6334  1087 a103          	cp	a,#3
6335  1089 27fa          	jreq	L1403
6336                     ; 1286 GPIOE->DDR&=~(1<<6);
6338  108b 721d5016      	bres	20502,#6
6339                     ; 1287 GPIOE->CR1&=~(1<<6);
6341  108f 721d5017      	bres	20503,#6
6342                     ; 1288 GPIOE->CR2&=~(1<<6);
6344  1093 721d5018      	bres	20504,#6
6345                     ; 1289 ADC2->CR2=0x08;
6347  1097 35085402      	mov	21506,#8
6348                     ; 1290 ADC2->CR1=0x40;
6350  109b 35405401      	mov	21505,#64
6351                     ; 1291 ADC2->CSR=0x20+9;
6353  109f 35295400      	mov	21504,#41
6354                     ; 1292 ADC2->CR1|=1;
6356  10a3 72105401      	bset	21505,#0
6357                     ; 1293 ADC2->CR1|=1;
6359  10a7 72105401      	bset	21505,#0
6360                     ; 1294 adr_drv_stat=5;
6362  10ab 35050008      	mov	_adr_drv_stat,#5
6363  10af               L7403:
6364                     ; 1295 while(adr_drv_stat==5);
6367  10af b608          	ld	a,_adr_drv_stat
6368  10b1 a105          	cp	a,#5
6369  10b3 27fa          	jreq	L7403
6370                     ; 1299 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6372  10b5 9c            	rvf
6373  10b6 ce0005        	ldw	x,_adc_buff_
6374  10b9 a3022a        	cpw	x,#554
6375  10bc 2f0f          	jrslt	L5503
6377  10be 9c            	rvf
6378  10bf ce0005        	ldw	x,_adc_buff_
6379  10c2 a30253        	cpw	x,#595
6380  10c5 2e06          	jrsge	L5503
6383  10c7 725f0002      	clr	_adr
6385  10cb 204c          	jra	L7503
6386  10cd               L5503:
6387                     ; 1300 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6389  10cd 9c            	rvf
6390  10ce ce0005        	ldw	x,_adc_buff_
6391  10d1 a3036d        	cpw	x,#877
6392  10d4 2f0f          	jrslt	L1603
6394  10d6 9c            	rvf
6395  10d7 ce0005        	ldw	x,_adc_buff_
6396  10da a30396        	cpw	x,#918
6397  10dd 2e06          	jrsge	L1603
6400  10df 35010002      	mov	_adr,#1
6402  10e3 2034          	jra	L7503
6403  10e5               L1603:
6404                     ; 1301 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6406  10e5 9c            	rvf
6407  10e6 ce0005        	ldw	x,_adc_buff_
6408  10e9 a302a3        	cpw	x,#675
6409  10ec 2f0f          	jrslt	L5603
6411  10ee 9c            	rvf
6412  10ef ce0005        	ldw	x,_adc_buff_
6413  10f2 a302cc        	cpw	x,#716
6414  10f5 2e06          	jrsge	L5603
6417  10f7 35020002      	mov	_adr,#2
6419  10fb 201c          	jra	L7503
6420  10fd               L5603:
6421                     ; 1302 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6423  10fd 9c            	rvf
6424  10fe ce0005        	ldw	x,_adc_buff_
6425  1101 a303e3        	cpw	x,#995
6426  1104 2f0f          	jrslt	L1703
6428  1106 9c            	rvf
6429  1107 ce0005        	ldw	x,_adc_buff_
6430  110a a3040c        	cpw	x,#1036
6431  110d 2e06          	jrsge	L1703
6434  110f 35030002      	mov	_adr,#3
6436  1113 2004          	jra	L7503
6437  1115               L1703:
6438                     ; 1303 else adr[0]=5;
6440  1115 35050002      	mov	_adr,#5
6441  1119               L7503:
6442                     ; 1305 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6444  1119 9c            	rvf
6445  111a ce0007        	ldw	x,_adc_buff_+2
6446  111d a3022a        	cpw	x,#554
6447  1120 2f0f          	jrslt	L5703
6449  1122 9c            	rvf
6450  1123 ce0007        	ldw	x,_adc_buff_+2
6451  1126 a30253        	cpw	x,#595
6452  1129 2e06          	jrsge	L5703
6455  112b 725f0003      	clr	_adr+1
6457  112f 204c          	jra	L7703
6458  1131               L5703:
6459                     ; 1306 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6461  1131 9c            	rvf
6462  1132 ce0007        	ldw	x,_adc_buff_+2
6463  1135 a3036d        	cpw	x,#877
6464  1138 2f0f          	jrslt	L1013
6466  113a 9c            	rvf
6467  113b ce0007        	ldw	x,_adc_buff_+2
6468  113e a30396        	cpw	x,#918
6469  1141 2e06          	jrsge	L1013
6472  1143 35010003      	mov	_adr+1,#1
6474  1147 2034          	jra	L7703
6475  1149               L1013:
6476                     ; 1307 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6478  1149 9c            	rvf
6479  114a ce0007        	ldw	x,_adc_buff_+2
6480  114d a302a3        	cpw	x,#675
6481  1150 2f0f          	jrslt	L5013
6483  1152 9c            	rvf
6484  1153 ce0007        	ldw	x,_adc_buff_+2
6485  1156 a302cc        	cpw	x,#716
6486  1159 2e06          	jrsge	L5013
6489  115b 35020003      	mov	_adr+1,#2
6491  115f 201c          	jra	L7703
6492  1161               L5013:
6493                     ; 1308 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6495  1161 9c            	rvf
6496  1162 ce0007        	ldw	x,_adc_buff_+2
6497  1165 a303e3        	cpw	x,#995
6498  1168 2f0f          	jrslt	L1113
6500  116a 9c            	rvf
6501  116b ce0007        	ldw	x,_adc_buff_+2
6502  116e a3040c        	cpw	x,#1036
6503  1171 2e06          	jrsge	L1113
6506  1173 35030003      	mov	_adr+1,#3
6508  1177 2004          	jra	L7703
6509  1179               L1113:
6510                     ; 1309 else adr[1]=5;
6512  1179 35050003      	mov	_adr+1,#5
6513  117d               L7703:
6514                     ; 1311 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6516  117d 9c            	rvf
6517  117e ce0017        	ldw	x,_adc_buff_+18
6518  1181 a3022a        	cpw	x,#554
6519  1184 2f0f          	jrslt	L5113
6521  1186 9c            	rvf
6522  1187 ce0017        	ldw	x,_adc_buff_+18
6523  118a a30253        	cpw	x,#595
6524  118d 2e06          	jrsge	L5113
6527  118f 725f0004      	clr	_adr+2
6529  1193 204c          	jra	L7113
6530  1195               L5113:
6531                     ; 1312 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6533  1195 9c            	rvf
6534  1196 ce0017        	ldw	x,_adc_buff_+18
6535  1199 a3036d        	cpw	x,#877
6536  119c 2f0f          	jrslt	L1213
6538  119e 9c            	rvf
6539  119f ce0017        	ldw	x,_adc_buff_+18
6540  11a2 a30396        	cpw	x,#918
6541  11a5 2e06          	jrsge	L1213
6544  11a7 35010004      	mov	_adr+2,#1
6546  11ab 2034          	jra	L7113
6547  11ad               L1213:
6548                     ; 1313 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6550  11ad 9c            	rvf
6551  11ae ce0017        	ldw	x,_adc_buff_+18
6552  11b1 a302a3        	cpw	x,#675
6553  11b4 2f0f          	jrslt	L5213
6555  11b6 9c            	rvf
6556  11b7 ce0017        	ldw	x,_adc_buff_+18
6557  11ba a302cc        	cpw	x,#716
6558  11bd 2e06          	jrsge	L5213
6561  11bf 35020004      	mov	_adr+2,#2
6563  11c3 201c          	jra	L7113
6564  11c5               L5213:
6565                     ; 1314 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6567  11c5 9c            	rvf
6568  11c6 ce0017        	ldw	x,_adc_buff_+18
6569  11c9 a303e3        	cpw	x,#995
6570  11cc 2f0f          	jrslt	L1313
6572  11ce 9c            	rvf
6573  11cf ce0017        	ldw	x,_adc_buff_+18
6574  11d2 a3040c        	cpw	x,#1036
6575  11d5 2e06          	jrsge	L1313
6578  11d7 35030004      	mov	_adr+2,#3
6580  11db 2004          	jra	L7113
6581  11dd               L1313:
6582                     ; 1315 else adr[2]=5;
6584  11dd 35050004      	mov	_adr+2,#5
6585  11e1               L7113:
6586                     ; 1319 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6588  11e1 c60002        	ld	a,_adr
6589  11e4 a105          	cp	a,#5
6590  11e6 270e          	jreq	L7313
6592  11e8 c60003        	ld	a,_adr+1
6593  11eb a105          	cp	a,#5
6594  11ed 2707          	jreq	L7313
6596  11ef c60004        	ld	a,_adr+2
6597  11f2 a105          	cp	a,#5
6598  11f4 2606          	jrne	L5313
6599  11f6               L7313:
6600                     ; 1322 	adress_error=1;
6602  11f6 35010000      	mov	_adress_error,#1
6604  11fa               L3413:
6605                     ; 1333 }
6608  11fa 84            	pop	a
6609  11fb 81            	ret
6610  11fc               L5313:
6611                     ; 1326 	if(adr[2]&0x02) bps_class=bpsIPS;
6613  11fc c60004        	ld	a,_adr+2
6614  11ff a502          	bcp	a,#2
6615  1201 2706          	jreq	L5413
6618  1203 35010001      	mov	_bps_class,#1
6620  1207 2002          	jra	L7413
6621  1209               L5413:
6622                     ; 1327 	else bps_class=bpsIBEP;
6624  1209 3f01          	clr	_bps_class
6625  120b               L7413:
6626                     ; 1329 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6628  120b c60004        	ld	a,_adr+2
6629  120e a401          	and	a,#1
6630  1210 97            	ld	xl,a
6631  1211 a610          	ld	a,#16
6632  1213 42            	mul	x,a
6633  1214 9f            	ld	a,xl
6634  1215 6b01          	ld	(OFST+0,sp),a
6635  1217 c60003        	ld	a,_adr+1
6636  121a 48            	sll	a
6637  121b 48            	sll	a
6638  121c cb0002        	add	a,_adr
6639  121f 1b01          	add	a,(OFST+0,sp)
6640  1221 c70001        	ld	_adress,a
6641  1224 20d4          	jra	L3413
6685                     ; 1336 void volum_u_main_drv(void)
6685                     ; 1337 {
6686                     	switch	.text
6687  1226               _volum_u_main_drv:
6689  1226 88            	push	a
6690       00000001      OFST:	set	1
6693                     ; 1340 if(bMAIN)
6695                     	btst	_bMAIN
6696  122c 2503          	jrult	L031
6697  122e cc1377        	jp	L7613
6698  1231               L031:
6699                     ; 1342 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6701  1231 9c            	rvf
6702  1232 ce0006        	ldw	x,_UU_AVT
6703  1235 1d000a        	subw	x,#10
6704  1238 b369          	cpw	x,_Un
6705  123a 2d09          	jrsle	L1713
6708  123c be1d          	ldw	x,_volum_u_main_
6709  123e 1c0005        	addw	x,#5
6710  1241 bf1d          	ldw	_volum_u_main_,x
6712  1243 2036          	jra	L3713
6713  1245               L1713:
6714                     ; 1343 	else if(Un<(UU_AVT-1))volum_u_main_++;
6716  1245 9c            	rvf
6717  1246 ce0006        	ldw	x,_UU_AVT
6718  1249 5a            	decw	x
6719  124a b369          	cpw	x,_Un
6720  124c 2d09          	jrsle	L5713
6723  124e be1d          	ldw	x,_volum_u_main_
6724  1250 1c0001        	addw	x,#1
6725  1253 bf1d          	ldw	_volum_u_main_,x
6727  1255 2024          	jra	L3713
6728  1257               L5713:
6729                     ; 1344 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
6731  1257 9c            	rvf
6732  1258 ce0006        	ldw	x,_UU_AVT
6733  125b 1c000a        	addw	x,#10
6734  125e b369          	cpw	x,_Un
6735  1260 2e09          	jrsge	L1023
6738  1262 be1d          	ldw	x,_volum_u_main_
6739  1264 1d000a        	subw	x,#10
6740  1267 bf1d          	ldw	_volum_u_main_,x
6742  1269 2010          	jra	L3713
6743  126b               L1023:
6744                     ; 1345 	else if(Un>(UU_AVT+1))volum_u_main_--;
6746  126b 9c            	rvf
6747  126c ce0006        	ldw	x,_UU_AVT
6748  126f 5c            	incw	x
6749  1270 b369          	cpw	x,_Un
6750  1272 2e07          	jrsge	L3713
6753  1274 be1d          	ldw	x,_volum_u_main_
6754  1276 1d0001        	subw	x,#1
6755  1279 bf1d          	ldw	_volum_u_main_,x
6756  127b               L3713:
6757                     ; 1346 	if(volum_u_main_>1020)volum_u_main_=1020;
6759  127b 9c            	rvf
6760  127c be1d          	ldw	x,_volum_u_main_
6761  127e a303fd        	cpw	x,#1021
6762  1281 2f05          	jrslt	L7023
6765  1283 ae03fc        	ldw	x,#1020
6766  1286 bf1d          	ldw	_volum_u_main_,x
6767  1288               L7023:
6768                     ; 1347 	if(volum_u_main_<0)volum_u_main_=0;
6770  1288 9c            	rvf
6771  1289 be1d          	ldw	x,_volum_u_main_
6772  128b 2e03          	jrsge	L1123
6775  128d 5f            	clrw	x
6776  128e bf1d          	ldw	_volum_u_main_,x
6777  1290               L1123:
6778                     ; 1350 	i_main_sigma=0;
6780  1290 5f            	clrw	x
6781  1291 bf0c          	ldw	_i_main_sigma,x
6782                     ; 1351 	i_main_num_of_bps=0;
6784  1293 3f0e          	clr	_i_main_num_of_bps
6785                     ; 1352 	for(i=0;i<6;i++)
6787  1295 0f01          	clr	(OFST+0,sp)
6788  1297               L3123:
6789                     ; 1354 		if(i_main_flag[i])
6791  1297 7b01          	ld	a,(OFST+0,sp)
6792  1299 5f            	clrw	x
6793  129a 97            	ld	xl,a
6794  129b 6d11          	tnz	(_i_main_flag,x)
6795  129d 2719          	jreq	L1223
6796                     ; 1356 			i_main_sigma+=i_main[i];
6798  129f 7b01          	ld	a,(OFST+0,sp)
6799  12a1 5f            	clrw	x
6800  12a2 97            	ld	xl,a
6801  12a3 58            	sllw	x
6802  12a4 ee17          	ldw	x,(_i_main,x)
6803  12a6 72bb000c      	addw	x,_i_main_sigma
6804  12aa bf0c          	ldw	_i_main_sigma,x
6805                     ; 1357 			i_main_flag[i]=1;
6807  12ac 7b01          	ld	a,(OFST+0,sp)
6808  12ae 5f            	clrw	x
6809  12af 97            	ld	xl,a
6810  12b0 a601          	ld	a,#1
6811  12b2 e711          	ld	(_i_main_flag,x),a
6812                     ; 1358 			i_main_num_of_bps++;
6814  12b4 3c0e          	inc	_i_main_num_of_bps
6816  12b6 2006          	jra	L3223
6817  12b8               L1223:
6818                     ; 1362 			i_main_flag[i]=0;	
6820  12b8 7b01          	ld	a,(OFST+0,sp)
6821  12ba 5f            	clrw	x
6822  12bb 97            	ld	xl,a
6823  12bc 6f11          	clr	(_i_main_flag,x)
6824  12be               L3223:
6825                     ; 1352 	for(i=0;i<6;i++)
6827  12be 0c01          	inc	(OFST+0,sp)
6830  12c0 7b01          	ld	a,(OFST+0,sp)
6831  12c2 a106          	cp	a,#6
6832  12c4 25d1          	jrult	L3123
6833                     ; 1365 	i_main_avg=i_main_sigma/i_main_num_of_bps;
6835  12c6 be0c          	ldw	x,_i_main_sigma
6836  12c8 b60e          	ld	a,_i_main_num_of_bps
6837  12ca 905f          	clrw	y
6838  12cc 9097          	ld	yl,a
6839  12ce cd0000        	call	c_idiv
6841  12d1 bf0f          	ldw	_i_main_avg,x
6842                     ; 1366 	for(i=0;i<6;i++)
6844  12d3 0f01          	clr	(OFST+0,sp)
6845  12d5               L5223:
6846                     ; 1368 		if(i_main_flag[i])
6848  12d5 7b01          	ld	a,(OFST+0,sp)
6849  12d7 5f            	clrw	x
6850  12d8 97            	ld	xl,a
6851  12d9 6d11          	tnz	(_i_main_flag,x)
6852  12db 2603cc136c    	jreq	L3323
6853                     ; 1370 			if(i_main[i]<(i_main_avg-10))x[i]++;
6855  12e0 9c            	rvf
6856  12e1 7b01          	ld	a,(OFST+0,sp)
6857  12e3 5f            	clrw	x
6858  12e4 97            	ld	xl,a
6859  12e5 58            	sllw	x
6860  12e6 90be0f        	ldw	y,_i_main_avg
6861  12e9 72a2000a      	subw	y,#10
6862  12ed 90bf00        	ldw	c_y,y
6863  12f0 9093          	ldw	y,x
6864  12f2 90ee17        	ldw	y,(_i_main,y)
6865  12f5 90b300        	cpw	y,c_y
6866  12f8 2e11          	jrsge	L5323
6869  12fa 7b01          	ld	a,(OFST+0,sp)
6870  12fc 5f            	clrw	x
6871  12fd 97            	ld	xl,a
6872  12fe 58            	sllw	x
6873  12ff 9093          	ldw	y,x
6874  1301 ee23          	ldw	x,(_x,x)
6875  1303 1c0001        	addw	x,#1
6876  1306 90ef23        	ldw	(_x,y),x
6878  1309 2029          	jra	L7323
6879  130b               L5323:
6880                     ; 1371 			else if(i_main[i]>(i_main_avg+10))x[i]--;
6882  130b 9c            	rvf
6883  130c 7b01          	ld	a,(OFST+0,sp)
6884  130e 5f            	clrw	x
6885  130f 97            	ld	xl,a
6886  1310 58            	sllw	x
6887  1311 90be0f        	ldw	y,_i_main_avg
6888  1314 72a9000a      	addw	y,#10
6889  1318 90bf00        	ldw	c_y,y
6890  131b 9093          	ldw	y,x
6891  131d 90ee17        	ldw	y,(_i_main,y)
6892  1320 90b300        	cpw	y,c_y
6893  1323 2d0f          	jrsle	L7323
6896  1325 7b01          	ld	a,(OFST+0,sp)
6897  1327 5f            	clrw	x
6898  1328 97            	ld	xl,a
6899  1329 58            	sllw	x
6900  132a 9093          	ldw	y,x
6901  132c ee23          	ldw	x,(_x,x)
6902  132e 1d0001        	subw	x,#1
6903  1331 90ef23        	ldw	(_x,y),x
6904  1334               L7323:
6905                     ; 1372 			if(x[i]>100)x[i]=100;
6907  1334 9c            	rvf
6908  1335 7b01          	ld	a,(OFST+0,sp)
6909  1337 5f            	clrw	x
6910  1338 97            	ld	xl,a
6911  1339 58            	sllw	x
6912  133a 9093          	ldw	y,x
6913  133c 90ee23        	ldw	y,(_x,y)
6914  133f 90a30065      	cpw	y,#101
6915  1343 2f0b          	jrslt	L3423
6918  1345 7b01          	ld	a,(OFST+0,sp)
6919  1347 5f            	clrw	x
6920  1348 97            	ld	xl,a
6921  1349 58            	sllw	x
6922  134a 90ae0064      	ldw	y,#100
6923  134e ef23          	ldw	(_x,x),y
6924  1350               L3423:
6925                     ; 1373 			if(x[i]<-100)x[i]=-100;
6927  1350 9c            	rvf
6928  1351 7b01          	ld	a,(OFST+0,sp)
6929  1353 5f            	clrw	x
6930  1354 97            	ld	xl,a
6931  1355 58            	sllw	x
6932  1356 9093          	ldw	y,x
6933  1358 90ee23        	ldw	y,(_x,y)
6934  135b 90a3ff9c      	cpw	y,#65436
6935  135f 2e0b          	jrsge	L3323
6938  1361 7b01          	ld	a,(OFST+0,sp)
6939  1363 5f            	clrw	x
6940  1364 97            	ld	xl,a
6941  1365 58            	sllw	x
6942  1366 90aeff9c      	ldw	y,#65436
6943  136a ef23          	ldw	(_x,x),y
6944  136c               L3323:
6945                     ; 1366 	for(i=0;i<6;i++)
6947  136c 0c01          	inc	(OFST+0,sp)
6950  136e 7b01          	ld	a,(OFST+0,sp)
6951  1370 a106          	cp	a,#6
6952  1372 2403cc12d5    	jrult	L5223
6953  1377               L7613:
6954                     ; 1380 }
6957  1377 84            	pop	a
6958  1378 81            	ret
6981                     ; 1383 void init_CAN(void) {
6982                     	switch	.text
6983  1379               _init_CAN:
6987                     ; 1384 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6989  1379 72135420      	bres	21536,#1
6990                     ; 1385 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6992  137d 72105420      	bset	21536,#0
6994  1381               L1623:
6995                     ; 1386 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6997  1381 c65421        	ld	a,21537
6998  1384 a501          	bcp	a,#1
6999  1386 27f9          	jreq	L1623
7000                     ; 1388 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7002  1388 72185420      	bset	21536,#4
7003                     ; 1390 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7005  138c 35025427      	mov	21543,#2
7006                     ; 1399 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7008  1390 35135428      	mov	21544,#19
7009                     ; 1400 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7011  1394 35c05429      	mov	21545,#192
7012                     ; 1401 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7014  1398 357f542c      	mov	21548,#127
7015                     ; 1402 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7017  139c 35e0542d      	mov	21549,#224
7018                     ; 1404 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7020  13a0 35315430      	mov	21552,#49
7021                     ; 1405 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7023  13a4 35c05431      	mov	21553,#192
7024                     ; 1406 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7026  13a8 357f5434      	mov	21556,#127
7027                     ; 1407 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7029  13ac 35e05435      	mov	21557,#224
7030                     ; 1411 	CAN->PSR= 6;									// set page 6
7032  13b0 35065427      	mov	21543,#6
7033                     ; 1416 	CAN->Page.Config.FMR1&=~3;								//mask mode
7035  13b4 c65430        	ld	a,21552
7036  13b7 a4fc          	and	a,#252
7037  13b9 c75430        	ld	21552,a
7038                     ; 1422 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7040  13bc 35065432      	mov	21554,#6
7041                     ; 1423 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7043  13c0 35605432      	mov	21554,#96
7044                     ; 1426 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7046  13c4 72105432      	bset	21554,#0
7047                     ; 1427 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7049  13c8 72185432      	bset	21554,#4
7050                     ; 1430 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7052  13cc 35065427      	mov	21543,#6
7053                     ; 1432 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7055  13d0 3509542c      	mov	21548,#9
7056                     ; 1433 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7058  13d4 35e7542d      	mov	21549,#231
7059                     ; 1435 	CAN->IER|=(1<<1);
7061  13d8 72125425      	bset	21541,#1
7062                     ; 1438 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7064  13dc 72115420      	bres	21536,#0
7066  13e0               L7623:
7067                     ; 1439 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7069  13e0 c65421        	ld	a,21537
7070  13e3 a501          	bcp	a,#1
7071  13e5 26f9          	jrne	L7623
7072                     ; 1440 }
7075  13e7 81            	ret
7183                     ; 1443 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7183                     ; 1444 {
7184                     	switch	.text
7185  13e8               _can_transmit:
7187  13e8 89            	pushw	x
7188       00000000      OFST:	set	0
7191                     ; 1446 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7193  13e9 b670          	ld	a,_can_buff_wr_ptr
7194  13eb a104          	cp	a,#4
7195  13ed 2502          	jrult	L1533
7198  13ef 3f70          	clr	_can_buff_wr_ptr
7199  13f1               L1533:
7200                     ; 1448 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7202  13f1 b670          	ld	a,_can_buff_wr_ptr
7203  13f3 97            	ld	xl,a
7204  13f4 a610          	ld	a,#16
7205  13f6 42            	mul	x,a
7206  13f7 1601          	ldw	y,(OFST+1,sp)
7207  13f9 a606          	ld	a,#6
7208  13fb               L631:
7209  13fb 9054          	srlw	y
7210  13fd 4a            	dec	a
7211  13fe 26fb          	jrne	L631
7212  1400 909f          	ld	a,yl
7213  1402 e771          	ld	(_can_out_buff,x),a
7214                     ; 1449 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7216  1404 b670          	ld	a,_can_buff_wr_ptr
7217  1406 97            	ld	xl,a
7218  1407 a610          	ld	a,#16
7219  1409 42            	mul	x,a
7220  140a 7b02          	ld	a,(OFST+2,sp)
7221  140c 48            	sll	a
7222  140d 48            	sll	a
7223  140e e772          	ld	(_can_out_buff+1,x),a
7224                     ; 1451 can_out_buff[can_buff_wr_ptr][2]=data0;
7226  1410 b670          	ld	a,_can_buff_wr_ptr
7227  1412 97            	ld	xl,a
7228  1413 a610          	ld	a,#16
7229  1415 42            	mul	x,a
7230  1416 7b05          	ld	a,(OFST+5,sp)
7231  1418 e773          	ld	(_can_out_buff+2,x),a
7232                     ; 1452 can_out_buff[can_buff_wr_ptr][3]=data1;
7234  141a b670          	ld	a,_can_buff_wr_ptr
7235  141c 97            	ld	xl,a
7236  141d a610          	ld	a,#16
7237  141f 42            	mul	x,a
7238  1420 7b06          	ld	a,(OFST+6,sp)
7239  1422 e774          	ld	(_can_out_buff+3,x),a
7240                     ; 1453 can_out_buff[can_buff_wr_ptr][4]=data2;
7242  1424 b670          	ld	a,_can_buff_wr_ptr
7243  1426 97            	ld	xl,a
7244  1427 a610          	ld	a,#16
7245  1429 42            	mul	x,a
7246  142a 7b07          	ld	a,(OFST+7,sp)
7247  142c e775          	ld	(_can_out_buff+4,x),a
7248                     ; 1454 can_out_buff[can_buff_wr_ptr][5]=data3;
7250  142e b670          	ld	a,_can_buff_wr_ptr
7251  1430 97            	ld	xl,a
7252  1431 a610          	ld	a,#16
7253  1433 42            	mul	x,a
7254  1434 7b08          	ld	a,(OFST+8,sp)
7255  1436 e776          	ld	(_can_out_buff+5,x),a
7256                     ; 1455 can_out_buff[can_buff_wr_ptr][6]=data4;
7258  1438 b670          	ld	a,_can_buff_wr_ptr
7259  143a 97            	ld	xl,a
7260  143b a610          	ld	a,#16
7261  143d 42            	mul	x,a
7262  143e 7b09          	ld	a,(OFST+9,sp)
7263  1440 e777          	ld	(_can_out_buff+6,x),a
7264                     ; 1456 can_out_buff[can_buff_wr_ptr][7]=data5;
7266  1442 b670          	ld	a,_can_buff_wr_ptr
7267  1444 97            	ld	xl,a
7268  1445 a610          	ld	a,#16
7269  1447 42            	mul	x,a
7270  1448 7b0a          	ld	a,(OFST+10,sp)
7271  144a e778          	ld	(_can_out_buff+7,x),a
7272                     ; 1457 can_out_buff[can_buff_wr_ptr][8]=data6;
7274  144c b670          	ld	a,_can_buff_wr_ptr
7275  144e 97            	ld	xl,a
7276  144f a610          	ld	a,#16
7277  1451 42            	mul	x,a
7278  1452 7b0b          	ld	a,(OFST+11,sp)
7279  1454 e779          	ld	(_can_out_buff+8,x),a
7280                     ; 1458 can_out_buff[can_buff_wr_ptr][9]=data7;
7282  1456 b670          	ld	a,_can_buff_wr_ptr
7283  1458 97            	ld	xl,a
7284  1459 a610          	ld	a,#16
7285  145b 42            	mul	x,a
7286  145c 7b0c          	ld	a,(OFST+12,sp)
7287  145e e77a          	ld	(_can_out_buff+9,x),a
7288                     ; 1460 can_buff_wr_ptr++;
7290  1460 3c70          	inc	_can_buff_wr_ptr
7291                     ; 1461 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7293  1462 b670          	ld	a,_can_buff_wr_ptr
7294  1464 a104          	cp	a,#4
7295  1466 2502          	jrult	L3533
7298  1468 3f70          	clr	_can_buff_wr_ptr
7299  146a               L3533:
7300                     ; 1462 } 
7303  146a 85            	popw	x
7304  146b 81            	ret
7333                     ; 1465 void can_tx_hndl(void)
7333                     ; 1466 {
7334                     	switch	.text
7335  146c               _can_tx_hndl:
7339                     ; 1467 if(bTX_FREE)
7341  146c 3d09          	tnz	_bTX_FREE
7342  146e 2757          	jreq	L5633
7343                     ; 1469 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7345  1470 b66f          	ld	a,_can_buff_rd_ptr
7346  1472 b170          	cp	a,_can_buff_wr_ptr
7347  1474 275f          	jreq	L3733
7348                     ; 1471 		bTX_FREE=0;
7350  1476 3f09          	clr	_bTX_FREE
7351                     ; 1473 		CAN->PSR= 0;
7353  1478 725f5427      	clr	21543
7354                     ; 1474 		CAN->Page.TxMailbox.MDLCR=8;
7356  147c 35085429      	mov	21545,#8
7357                     ; 1475 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7359  1480 b66f          	ld	a,_can_buff_rd_ptr
7360  1482 97            	ld	xl,a
7361  1483 a610          	ld	a,#16
7362  1485 42            	mul	x,a
7363  1486 e671          	ld	a,(_can_out_buff,x)
7364  1488 c7542a        	ld	21546,a
7365                     ; 1476 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7367  148b b66f          	ld	a,_can_buff_rd_ptr
7368  148d 97            	ld	xl,a
7369  148e a610          	ld	a,#16
7370  1490 42            	mul	x,a
7371  1491 e672          	ld	a,(_can_out_buff+1,x)
7372  1493 c7542b        	ld	21547,a
7373                     ; 1478 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7375  1496 b66f          	ld	a,_can_buff_rd_ptr
7376  1498 97            	ld	xl,a
7377  1499 a610          	ld	a,#16
7378  149b 42            	mul	x,a
7379  149c 01            	rrwa	x,a
7380  149d ab73          	add	a,#_can_out_buff+2
7381  149f 2401          	jrnc	L241
7382  14a1 5c            	incw	x
7383  14a2               L241:
7384  14a2 5f            	clrw	x
7385  14a3 97            	ld	xl,a
7386  14a4 bf00          	ldw	c_x,x
7387  14a6 ae0008        	ldw	x,#8
7388  14a9               L441:
7389  14a9 5a            	decw	x
7390  14aa 92d600        	ld	a,([c_x],x)
7391  14ad d7542e        	ld	(21550,x),a
7392  14b0 5d            	tnzw	x
7393  14b1 26f6          	jrne	L441
7394                     ; 1480 		can_buff_rd_ptr++;
7396  14b3 3c6f          	inc	_can_buff_rd_ptr
7397                     ; 1481 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7399  14b5 b66f          	ld	a,_can_buff_rd_ptr
7400  14b7 a104          	cp	a,#4
7401  14b9 2502          	jrult	L1733
7404  14bb 3f6f          	clr	_can_buff_rd_ptr
7405  14bd               L1733:
7406                     ; 1483 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7408  14bd 72105428      	bset	21544,#0
7409                     ; 1484 		CAN->IER|=(1<<0);
7411  14c1 72105425      	bset	21541,#0
7412  14c5 200e          	jra	L3733
7413  14c7               L5633:
7414                     ; 1489 	tx_busy_cnt++;
7416  14c7 3c6e          	inc	_tx_busy_cnt
7417                     ; 1490 	if(tx_busy_cnt>=100)
7419  14c9 b66e          	ld	a,_tx_busy_cnt
7420  14cb a164          	cp	a,#100
7421  14cd 2506          	jrult	L3733
7422                     ; 1492 		tx_busy_cnt=0;
7424  14cf 3f6e          	clr	_tx_busy_cnt
7425                     ; 1493 		bTX_FREE=1;
7427  14d1 35010009      	mov	_bTX_FREE,#1
7428  14d5               L3733:
7429                     ; 1496 }
7432  14d5 81            	ret
7471                     ; 1499 void net_drv(void)
7471                     ; 1500 { 
7472                     	switch	.text
7473  14d6               _net_drv:
7477                     ; 1502 if(bMAIN)
7479                     	btst	_bMAIN
7480  14db 2503          	jrult	L051
7481  14dd cc1583        	jp	L7043
7482  14e0               L051:
7483                     ; 1504 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7485  14e0 3c2f          	inc	_cnt_net_drv
7486  14e2 b62f          	ld	a,_cnt_net_drv
7487  14e4 a107          	cp	a,#7
7488  14e6 2502          	jrult	L1143
7491  14e8 3f2f          	clr	_cnt_net_drv
7492  14ea               L1143:
7493                     ; 1506 	if(cnt_net_drv<=5) 
7495  14ea b62f          	ld	a,_cnt_net_drv
7496  14ec a106          	cp	a,#6
7497  14ee 244c          	jruge	L3143
7498                     ; 1508 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7500  14f0 4be8          	push	#232
7501  14f2 4be8          	push	#232
7502  14f4 b62f          	ld	a,_cnt_net_drv
7503  14f6 5f            	clrw	x
7504  14f7 97            	ld	xl,a
7505  14f8 58            	sllw	x
7506  14f9 ee23          	ldw	x,(_x,x)
7507  14fb 72bb001d      	addw	x,_volum_u_main_
7508  14ff 90ae0100      	ldw	y,#256
7509  1503 cd0000        	call	c_idiv
7511  1506 9f            	ld	a,xl
7512  1507 88            	push	a
7513  1508 b62f          	ld	a,_cnt_net_drv
7514  150a 5f            	clrw	x
7515  150b 97            	ld	xl,a
7516  150c 58            	sllw	x
7517  150d e624          	ld	a,(_x+1,x)
7518  150f bb1e          	add	a,_volum_u_main_+1
7519  1511 88            	push	a
7520  1512 4b00          	push	#0
7521  1514 4bed          	push	#237
7522  1516 3b002f        	push	_cnt_net_drv
7523  1519 3b002f        	push	_cnt_net_drv
7524  151c ae009e        	ldw	x,#158
7525  151f cd13e8        	call	_can_transmit
7527  1522 5b08          	addw	sp,#8
7528                     ; 1509 		i_main_bps_cnt[cnt_net_drv]++;
7530  1524 b62f          	ld	a,_cnt_net_drv
7531  1526 5f            	clrw	x
7532  1527 97            	ld	xl,a
7533  1528 6c06          	inc	(_i_main_bps_cnt,x)
7534                     ; 1510 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7536  152a b62f          	ld	a,_cnt_net_drv
7537  152c 5f            	clrw	x
7538  152d 97            	ld	xl,a
7539  152e e606          	ld	a,(_i_main_bps_cnt,x)
7540  1530 a10b          	cp	a,#11
7541  1532 254f          	jrult	L7043
7544  1534 b62f          	ld	a,_cnt_net_drv
7545  1536 5f            	clrw	x
7546  1537 97            	ld	xl,a
7547  1538 6f11          	clr	(_i_main_flag,x)
7548  153a 2047          	jra	L7043
7549  153c               L3143:
7550                     ; 1512 	else if(cnt_net_drv==6)
7552  153c b62f          	ld	a,_cnt_net_drv
7553  153e a106          	cp	a,#6
7554  1540 2641          	jrne	L7043
7555                     ; 1514 		plazma_int[2]=pwm_u;
7557  1542 be0c          	ldw	x,_pwm_u
7558  1544 bf34          	ldw	_plazma_int+4,x
7559                     ; 1515 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7561  1546 3b0067        	push	_Ui
7562  1549 3b0068        	push	_Ui+1
7563  154c 3b0069        	push	_Un
7564  154f 3b006a        	push	_Un+1
7565  1552 3b006b        	push	_I
7566  1555 3b006c        	push	_I+1
7567  1558 4bda          	push	#218
7568  155a 3b0001        	push	_adress
7569  155d ae018e        	ldw	x,#398
7570  1560 cd13e8        	call	_can_transmit
7572  1563 5b08          	addw	sp,#8
7573                     ; 1516 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7575  1565 3b0034        	push	_plazma_int+4
7576  1568 3b0035        	push	_plazma_int+5
7577  156b 3b005c        	push	__x_+1
7578  156e 3b000b        	push	_flags
7579  1571 4b00          	push	#0
7580  1573 3b0064        	push	_T
7581  1576 4bdb          	push	#219
7582  1578 3b0001        	push	_adress
7583  157b ae018e        	ldw	x,#398
7584  157e cd13e8        	call	_can_transmit
7586  1581 5b08          	addw	sp,#8
7587  1583               L7043:
7588                     ; 1519 }
7591  1583 81            	ret
7701                     ; 1522 void can_in_an(void)
7701                     ; 1523 {
7702                     	switch	.text
7703  1584               _can_in_an:
7705  1584 5205          	subw	sp,#5
7706       00000005      OFST:	set	5
7709                     ; 1533 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7711  1586 b6c6          	ld	a,_mess+6
7712  1588 c10001        	cp	a,_adress
7713  158b 2703          	jreq	L471
7714  158d cc169a        	jp	L7543
7715  1590               L471:
7717  1590 b6c7          	ld	a,_mess+7
7718  1592 c10001        	cp	a,_adress
7719  1595 2703          	jreq	L671
7720  1597 cc169a        	jp	L7543
7721  159a               L671:
7723  159a b6c8          	ld	a,_mess+8
7724  159c a1ed          	cp	a,#237
7725  159e 2703          	jreq	L002
7726  15a0 cc169a        	jp	L7543
7727  15a3               L002:
7728                     ; 1536 	can_error_cnt=0;
7730  15a3 3f6d          	clr	_can_error_cnt
7731                     ; 1538 	bMAIN=0;
7733  15a5 72110001      	bres	_bMAIN
7734                     ; 1539  	flags_tu=mess[9];
7736  15a9 45c95d        	mov	_flags_tu,_mess+9
7737                     ; 1540  	if(flags_tu&0b00000001)
7739  15ac b65d          	ld	a,_flags_tu
7740  15ae a501          	bcp	a,#1
7741  15b0 2706          	jreq	L1643
7742                     ; 1545  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7744  15b2 721a000b      	bset	_flags,#5
7746  15b6 200e          	jra	L3643
7747  15b8               L1643:
7748                     ; 1556  				flags&=0b11011111; 
7750  15b8 721b000b      	bres	_flags,#5
7751                     ; 1557  				off_bp_cnt=5*ee_TZAS;
7753  15bc c60015        	ld	a,_ee_TZAS+1
7754  15bf 97            	ld	xl,a
7755  15c0 a605          	ld	a,#5
7756  15c2 42            	mul	x,a
7757  15c3 9f            	ld	a,xl
7758  15c4 b750          	ld	_off_bp_cnt,a
7759  15c6               L3643:
7760                     ; 1563  	if(flags_tu&0b00000010) flags|=0b01000000;
7762  15c6 b65d          	ld	a,_flags_tu
7763  15c8 a502          	bcp	a,#2
7764  15ca 2706          	jreq	L5643
7767  15cc 721c000b      	bset	_flags,#6
7769  15d0 2004          	jra	L7643
7770  15d2               L5643:
7771                     ; 1564  	else flags&=0b10111111; 
7773  15d2 721d000b      	bres	_flags,#6
7774  15d6               L7643:
7775                     ; 1566  	vol_u_temp=mess[10]+mess[11]*256;
7777  15d6 b6cb          	ld	a,_mess+11
7778  15d8 5f            	clrw	x
7779  15d9 97            	ld	xl,a
7780  15da 4f            	clr	a
7781  15db 02            	rlwa	x,a
7782  15dc 01            	rrwa	x,a
7783  15dd bbca          	add	a,_mess+10
7784  15df 2401          	jrnc	L451
7785  15e1 5c            	incw	x
7786  15e2               L451:
7787  15e2 b756          	ld	_vol_u_temp+1,a
7788  15e4 9f            	ld	a,xl
7789  15e5 b755          	ld	_vol_u_temp,a
7790                     ; 1567  	vol_i_temp=mess[12]+mess[13]*256;  
7792  15e7 b6cd          	ld	a,_mess+13
7793  15e9 5f            	clrw	x
7794  15ea 97            	ld	xl,a
7795  15eb 4f            	clr	a
7796  15ec 02            	rlwa	x,a
7797  15ed 01            	rrwa	x,a
7798  15ee bbcc          	add	a,_mess+12
7799  15f0 2401          	jrnc	L651
7800  15f2 5c            	incw	x
7801  15f3               L651:
7802  15f3 b754          	ld	_vol_i_temp+1,a
7803  15f5 9f            	ld	a,xl
7804  15f6 b753          	ld	_vol_i_temp,a
7805                     ; 1576 	plazma_int[2]=T;
7807  15f8 5f            	clrw	x
7808  15f9 b664          	ld	a,_T
7809  15fb 2a01          	jrpl	L061
7810  15fd 53            	cplw	x
7811  15fe               L061:
7812  15fe 97            	ld	xl,a
7813  15ff bf34          	ldw	_plazma_int+4,x
7814                     ; 1577  	rotor_int=flags_tu+(((short)flags)<<8);
7816  1601 b60b          	ld	a,_flags
7817  1603 5f            	clrw	x
7818  1604 97            	ld	xl,a
7819  1605 4f            	clr	a
7820  1606 02            	rlwa	x,a
7821  1607 01            	rrwa	x,a
7822  1608 bb5d          	add	a,_flags_tu
7823  160a 2401          	jrnc	L261
7824  160c 5c            	incw	x
7825  160d               L261:
7826  160d b71c          	ld	_rotor_int+1,a
7827  160f 9f            	ld	a,xl
7828  1610 b71b          	ld	_rotor_int,a
7829                     ; 1578 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7831  1612 3b0067        	push	_Ui
7832  1615 3b0068        	push	_Ui+1
7833  1618 3b0069        	push	_Un
7834  161b 3b006a        	push	_Un+1
7835  161e 3b006b        	push	_I
7836  1621 3b006c        	push	_I+1
7837  1624 4bda          	push	#218
7838  1626 3b0001        	push	_adress
7839  1629 ae018e        	ldw	x,#398
7840  162c cd13e8        	call	_can_transmit
7842  162f 5b08          	addw	sp,#8
7843                     ; 1579 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7845  1631 3b0034        	push	_plazma_int+4
7846  1634 3b0035        	push	_plazma_int+5
7847  1637 3b005c        	push	__x_+1
7848  163a 3b000b        	push	_flags
7849  163d 4b00          	push	#0
7850  163f 3b0064        	push	_T
7851  1642 4bdb          	push	#219
7852  1644 3b0001        	push	_adress
7853  1647 ae018e        	ldw	x,#398
7854  164a cd13e8        	call	_can_transmit
7856  164d 5b08          	addw	sp,#8
7857                     ; 1580      link_cnt=0;
7859  164f 3f5e          	clr	_link_cnt
7860                     ; 1581      link=ON;
7862  1651 3555005f      	mov	_link,#85
7863                     ; 1583      if(flags_tu&0b10000000)
7865  1655 b65d          	ld	a,_flags_tu
7866  1657 a580          	bcp	a,#128
7867  1659 2716          	jreq	L1743
7868                     ; 1585      	if(!res_fl)
7870  165b 725d0009      	tnz	_res_fl
7871  165f 2625          	jrne	L5743
7872                     ; 1587      		res_fl=1;
7874  1661 a601          	ld	a,#1
7875  1663 ae0009        	ldw	x,#_res_fl
7876  1666 cd0000        	call	c_eewrc
7878                     ; 1588      		bRES=1;
7880  1669 35010010      	mov	_bRES,#1
7881                     ; 1589      		res_fl_cnt=0;
7883  166d 3f3e          	clr	_res_fl_cnt
7884  166f 2015          	jra	L5743
7885  1671               L1743:
7886                     ; 1594      	if(main_cnt>20)
7888  1671 9c            	rvf
7889  1672 be4e          	ldw	x,_main_cnt
7890  1674 a30015        	cpw	x,#21
7891  1677 2f0d          	jrslt	L5743
7892                     ; 1596     			if(res_fl)
7894  1679 725d0009      	tnz	_res_fl
7895  167d 2707          	jreq	L5743
7896                     ; 1598      			res_fl=0;
7898  167f 4f            	clr	a
7899  1680 ae0009        	ldw	x,#_res_fl
7900  1683 cd0000        	call	c_eewrc
7902  1686               L5743:
7903                     ; 1603       if(res_fl_)
7905  1686 725d0008      	tnz	_res_fl_
7906  168a 2603          	jrne	L202
7907  168c cc1bbd        	jp	L3243
7908  168f               L202:
7909                     ; 1605       	res_fl_=0;
7911  168f 4f            	clr	a
7912  1690 ae0008        	ldw	x,#_res_fl_
7913  1693 cd0000        	call	c_eewrc
7915  1696 acbd1bbd      	jpf	L3243
7916  169a               L7543:
7917                     ; 1608 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7919  169a b6c6          	ld	a,_mess+6
7920  169c c10001        	cp	a,_adress
7921  169f 2703          	jreq	L402
7922  16a1 cc18b0        	jp	L7053
7923  16a4               L402:
7925  16a4 b6c7          	ld	a,_mess+7
7926  16a6 c10001        	cp	a,_adress
7927  16a9 2703          	jreq	L602
7928  16ab cc18b0        	jp	L7053
7929  16ae               L602:
7931  16ae b6c8          	ld	a,_mess+8
7932  16b0 a1ee          	cp	a,#238
7933  16b2 2703          	jreq	L012
7934  16b4 cc18b0        	jp	L7053
7935  16b7               L012:
7937  16b7 b6c9          	ld	a,_mess+9
7938  16b9 b1ca          	cp	a,_mess+10
7939  16bb 2703          	jreq	L212
7940  16bd cc18b0        	jp	L7053
7941  16c0               L212:
7942                     ; 1610 	rotor_int++;
7944  16c0 be1b          	ldw	x,_rotor_int
7945  16c2 1c0001        	addw	x,#1
7946  16c5 bf1b          	ldw	_rotor_int,x
7947                     ; 1611 	if((mess[9]&0xf0)==0x20)
7949  16c7 b6c9          	ld	a,_mess+9
7950  16c9 a4f0          	and	a,#240
7951  16cb a120          	cp	a,#32
7952  16cd 2673          	jrne	L1153
7953                     ; 1613 		if((mess[9]&0x0f)==0x01)
7955  16cf b6c9          	ld	a,_mess+9
7956  16d1 a40f          	and	a,#15
7957  16d3 a101          	cp	a,#1
7958  16d5 260d          	jrne	L3153
7959                     ; 1615 			ee_K[0][0]=adc_buff_[4];
7961  16d7 ce000d        	ldw	x,_adc_buff_+8
7962  16da 89            	pushw	x
7963  16db ae0018        	ldw	x,#_ee_K
7964  16de cd0000        	call	c_eewrw
7966  16e1 85            	popw	x
7968  16e2 204a          	jra	L5153
7969  16e4               L3153:
7970                     ; 1617 		else if((mess[9]&0x0f)==0x02)
7972  16e4 b6c9          	ld	a,_mess+9
7973  16e6 a40f          	and	a,#15
7974  16e8 a102          	cp	a,#2
7975  16ea 260b          	jrne	L7153
7976                     ; 1619 			ee_K[0][1]++;
7978  16ec ce001a        	ldw	x,_ee_K+2
7979  16ef 1c0001        	addw	x,#1
7980  16f2 cf001a        	ldw	_ee_K+2,x
7982  16f5 2037          	jra	L5153
7983  16f7               L7153:
7984                     ; 1621 		else if((mess[9]&0x0f)==0x03)
7986  16f7 b6c9          	ld	a,_mess+9
7987  16f9 a40f          	and	a,#15
7988  16fb a103          	cp	a,#3
7989  16fd 260b          	jrne	L3253
7990                     ; 1623 			ee_K[0][1]+=10;
7992  16ff ce001a        	ldw	x,_ee_K+2
7993  1702 1c000a        	addw	x,#10
7994  1705 cf001a        	ldw	_ee_K+2,x
7996  1708 2024          	jra	L5153
7997  170a               L3253:
7998                     ; 1625 		else if((mess[9]&0x0f)==0x04)
8000  170a b6c9          	ld	a,_mess+9
8001  170c a40f          	and	a,#15
8002  170e a104          	cp	a,#4
8003  1710 260b          	jrne	L7253
8004                     ; 1627 			ee_K[0][1]--;
8006  1712 ce001a        	ldw	x,_ee_K+2
8007  1715 1d0001        	subw	x,#1
8008  1718 cf001a        	ldw	_ee_K+2,x
8010  171b 2011          	jra	L5153
8011  171d               L7253:
8012                     ; 1629 		else if((mess[9]&0x0f)==0x05)
8014  171d b6c9          	ld	a,_mess+9
8015  171f a40f          	and	a,#15
8016  1721 a105          	cp	a,#5
8017  1723 2609          	jrne	L5153
8018                     ; 1631 			ee_K[0][1]-=10;
8020  1725 ce001a        	ldw	x,_ee_K+2
8021  1728 1d000a        	subw	x,#10
8022  172b cf001a        	ldw	_ee_K+2,x
8023  172e               L5153:
8024                     ; 1633 		granee(&ee_K[0][1],50,3000);									
8026  172e ae0bb8        	ldw	x,#3000
8027  1731 89            	pushw	x
8028  1732 ae0032        	ldw	x,#50
8029  1735 89            	pushw	x
8030  1736 ae001a        	ldw	x,#_ee_K+2
8031  1739 cd0021        	call	_granee
8033  173c 5b04          	addw	sp,#4
8035  173e ac961896      	jpf	L5353
8036  1742               L1153:
8037                     ; 1635 	else if((mess[9]&0xf0)==0x10)
8039  1742 b6c9          	ld	a,_mess+9
8040  1744 a4f0          	and	a,#240
8041  1746 a110          	cp	a,#16
8042  1748 2673          	jrne	L7353
8043                     ; 1637 		if((mess[9]&0x0f)==0x01)
8045  174a b6c9          	ld	a,_mess+9
8046  174c a40f          	and	a,#15
8047  174e a101          	cp	a,#1
8048  1750 260d          	jrne	L1453
8049                     ; 1639 			ee_K[1][0]=adc_buff_[1];
8051  1752 ce0007        	ldw	x,_adc_buff_+2
8052  1755 89            	pushw	x
8053  1756 ae001c        	ldw	x,#_ee_K+4
8054  1759 cd0000        	call	c_eewrw
8056  175c 85            	popw	x
8058  175d 204a          	jra	L3453
8059  175f               L1453:
8060                     ; 1641 		else if((mess[9]&0x0f)==0x02)
8062  175f b6c9          	ld	a,_mess+9
8063  1761 a40f          	and	a,#15
8064  1763 a102          	cp	a,#2
8065  1765 260b          	jrne	L5453
8066                     ; 1643 			ee_K[1][1]++;
8068  1767 ce001e        	ldw	x,_ee_K+6
8069  176a 1c0001        	addw	x,#1
8070  176d cf001e        	ldw	_ee_K+6,x
8072  1770 2037          	jra	L3453
8073  1772               L5453:
8074                     ; 1645 		else if((mess[9]&0x0f)==0x03)
8076  1772 b6c9          	ld	a,_mess+9
8077  1774 a40f          	and	a,#15
8078  1776 a103          	cp	a,#3
8079  1778 260b          	jrne	L1553
8080                     ; 1647 			ee_K[1][1]+=10;
8082  177a ce001e        	ldw	x,_ee_K+6
8083  177d 1c000a        	addw	x,#10
8084  1780 cf001e        	ldw	_ee_K+6,x
8086  1783 2024          	jra	L3453
8087  1785               L1553:
8088                     ; 1649 		else if((mess[9]&0x0f)==0x04)
8090  1785 b6c9          	ld	a,_mess+9
8091  1787 a40f          	and	a,#15
8092  1789 a104          	cp	a,#4
8093  178b 260b          	jrne	L5553
8094                     ; 1651 			ee_K[1][1]--;
8096  178d ce001e        	ldw	x,_ee_K+6
8097  1790 1d0001        	subw	x,#1
8098  1793 cf001e        	ldw	_ee_K+6,x
8100  1796 2011          	jra	L3453
8101  1798               L5553:
8102                     ; 1653 		else if((mess[9]&0x0f)==0x05)
8104  1798 b6c9          	ld	a,_mess+9
8105  179a a40f          	and	a,#15
8106  179c a105          	cp	a,#5
8107  179e 2609          	jrne	L3453
8108                     ; 1655 			ee_K[1][1]-=10;
8110  17a0 ce001e        	ldw	x,_ee_K+6
8111  17a3 1d000a        	subw	x,#10
8112  17a6 cf001e        	ldw	_ee_K+6,x
8113  17a9               L3453:
8114                     ; 1660 		granee(&ee_K[1][1],10,30000);
8116  17a9 ae7530        	ldw	x,#30000
8117  17ac 89            	pushw	x
8118  17ad ae000a        	ldw	x,#10
8119  17b0 89            	pushw	x
8120  17b1 ae001e        	ldw	x,#_ee_K+6
8121  17b4 cd0021        	call	_granee
8123  17b7 5b04          	addw	sp,#4
8125  17b9 ac961896      	jpf	L5353
8126  17bd               L7353:
8127                     ; 1664 	else if((mess[9]&0xf0)==0x00)
8129  17bd b6c9          	ld	a,_mess+9
8130  17bf a5f0          	bcp	a,#240
8131  17c1 2671          	jrne	L5653
8132                     ; 1666 		if((mess[9]&0x0f)==0x01)
8134  17c3 b6c9          	ld	a,_mess+9
8135  17c5 a40f          	and	a,#15
8136  17c7 a101          	cp	a,#1
8137  17c9 260d          	jrne	L7653
8138                     ; 1668 			ee_K[2][0]=adc_buff_[2];
8140  17cb ce0009        	ldw	x,_adc_buff_+4
8141  17ce 89            	pushw	x
8142  17cf ae0020        	ldw	x,#_ee_K+8
8143  17d2 cd0000        	call	c_eewrw
8145  17d5 85            	popw	x
8147  17d6 204a          	jra	L1753
8148  17d8               L7653:
8149                     ; 1670 		else if((mess[9]&0x0f)==0x02)
8151  17d8 b6c9          	ld	a,_mess+9
8152  17da a40f          	and	a,#15
8153  17dc a102          	cp	a,#2
8154  17de 260b          	jrne	L3753
8155                     ; 1672 			ee_K[2][1]++;
8157  17e0 ce0022        	ldw	x,_ee_K+10
8158  17e3 1c0001        	addw	x,#1
8159  17e6 cf0022        	ldw	_ee_K+10,x
8161  17e9 2037          	jra	L1753
8162  17eb               L3753:
8163                     ; 1674 		else if((mess[9]&0x0f)==0x03)
8165  17eb b6c9          	ld	a,_mess+9
8166  17ed a40f          	and	a,#15
8167  17ef a103          	cp	a,#3
8168  17f1 260b          	jrne	L7753
8169                     ; 1676 			ee_K[2][1]+=10;
8171  17f3 ce0022        	ldw	x,_ee_K+10
8172  17f6 1c000a        	addw	x,#10
8173  17f9 cf0022        	ldw	_ee_K+10,x
8175  17fc 2024          	jra	L1753
8176  17fe               L7753:
8177                     ; 1678 		else if((mess[9]&0x0f)==0x04)
8179  17fe b6c9          	ld	a,_mess+9
8180  1800 a40f          	and	a,#15
8181  1802 a104          	cp	a,#4
8182  1804 260b          	jrne	L3063
8183                     ; 1680 			ee_K[2][1]--;
8185  1806 ce0022        	ldw	x,_ee_K+10
8186  1809 1d0001        	subw	x,#1
8187  180c cf0022        	ldw	_ee_K+10,x
8189  180f 2011          	jra	L1753
8190  1811               L3063:
8191                     ; 1682 		else if((mess[9]&0x0f)==0x05)
8193  1811 b6c9          	ld	a,_mess+9
8194  1813 a40f          	and	a,#15
8195  1815 a105          	cp	a,#5
8196  1817 2609          	jrne	L1753
8197                     ; 1684 			ee_K[2][1]-=10;
8199  1819 ce0022        	ldw	x,_ee_K+10
8200  181c 1d000a        	subw	x,#10
8201  181f cf0022        	ldw	_ee_K+10,x
8202  1822               L1753:
8203                     ; 1689 		granee(&ee_K[2][1],10,30000);
8205  1822 ae7530        	ldw	x,#30000
8206  1825 89            	pushw	x
8207  1826 ae000a        	ldw	x,#10
8208  1829 89            	pushw	x
8209  182a ae0022        	ldw	x,#_ee_K+10
8210  182d cd0021        	call	_granee
8212  1830 5b04          	addw	sp,#4
8214  1832 2062          	jra	L5353
8215  1834               L5653:
8216                     ; 1693 	else if((mess[9]&0xf0)==0x30)
8218  1834 b6c9          	ld	a,_mess+9
8219  1836 a4f0          	and	a,#240
8220  1838 a130          	cp	a,#48
8221  183a 265a          	jrne	L5353
8222                     ; 1695 		if((mess[9]&0x0f)==0x02)
8224  183c b6c9          	ld	a,_mess+9
8225  183e a40f          	and	a,#15
8226  1840 a102          	cp	a,#2
8227  1842 260b          	jrne	L5163
8228                     ; 1697 			ee_K[3][1]++;
8230  1844 ce0026        	ldw	x,_ee_K+14
8231  1847 1c0001        	addw	x,#1
8232  184a cf0026        	ldw	_ee_K+14,x
8234  184d 2037          	jra	L7163
8235  184f               L5163:
8236                     ; 1699 		else if((mess[9]&0x0f)==0x03)
8238  184f b6c9          	ld	a,_mess+9
8239  1851 a40f          	and	a,#15
8240  1853 a103          	cp	a,#3
8241  1855 260b          	jrne	L1263
8242                     ; 1701 			ee_K[3][1]+=10;
8244  1857 ce0026        	ldw	x,_ee_K+14
8245  185a 1c000a        	addw	x,#10
8246  185d cf0026        	ldw	_ee_K+14,x
8248  1860 2024          	jra	L7163
8249  1862               L1263:
8250                     ; 1703 		else if((mess[9]&0x0f)==0x04)
8252  1862 b6c9          	ld	a,_mess+9
8253  1864 a40f          	and	a,#15
8254  1866 a104          	cp	a,#4
8255  1868 260b          	jrne	L5263
8256                     ; 1705 			ee_K[3][1]--;
8258  186a ce0026        	ldw	x,_ee_K+14
8259  186d 1d0001        	subw	x,#1
8260  1870 cf0026        	ldw	_ee_K+14,x
8262  1873 2011          	jra	L7163
8263  1875               L5263:
8264                     ; 1707 		else if((mess[9]&0x0f)==0x05)
8266  1875 b6c9          	ld	a,_mess+9
8267  1877 a40f          	and	a,#15
8268  1879 a105          	cp	a,#5
8269  187b 2609          	jrne	L7163
8270                     ; 1709 			ee_K[3][1]-=10;
8272  187d ce0026        	ldw	x,_ee_K+14
8273  1880 1d000a        	subw	x,#10
8274  1883 cf0026        	ldw	_ee_K+14,x
8275  1886               L7163:
8276                     ; 1711 		granee(&ee_K[3][1],300,517);									
8278  1886 ae0205        	ldw	x,#517
8279  1889 89            	pushw	x
8280  188a ae012c        	ldw	x,#300
8281  188d 89            	pushw	x
8282  188e ae0026        	ldw	x,#_ee_K+14
8283  1891 cd0021        	call	_granee
8285  1894 5b04          	addw	sp,#4
8286  1896               L5353:
8287                     ; 1714 	link_cnt=0;
8289  1896 3f5e          	clr	_link_cnt
8290                     ; 1715      link=ON;
8292  1898 3555005f      	mov	_link,#85
8293                     ; 1716      if(res_fl_)
8295  189c 725d0008      	tnz	_res_fl_
8296  18a0 2603          	jrne	L412
8297  18a2 cc1bbd        	jp	L3243
8298  18a5               L412:
8299                     ; 1718       	res_fl_=0;
8301  18a5 4f            	clr	a
8302  18a6 ae0008        	ldw	x,#_res_fl_
8303  18a9 cd0000        	call	c_eewrc
8305  18ac acbd1bbd      	jpf	L3243
8306  18b0               L7053:
8307                     ; 1724 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8309  18b0 b6c6          	ld	a,_mess+6
8310  18b2 a1ff          	cp	a,#255
8311  18b4 2703          	jreq	L612
8312  18b6 cc1944        	jp	L7363
8313  18b9               L612:
8315  18b9 b6c7          	ld	a,_mess+7
8316  18bb a1ff          	cp	a,#255
8317  18bd 2703          	jreq	L022
8318  18bf cc1944        	jp	L7363
8319  18c2               L022:
8321  18c2 b6c8          	ld	a,_mess+8
8322  18c4 a162          	cp	a,#98
8323  18c6 267c          	jrne	L7363
8324                     ; 1727 	tempSS=mess[9]+(mess[10]*256);
8326  18c8 b6ca          	ld	a,_mess+10
8327  18ca 5f            	clrw	x
8328  18cb 97            	ld	xl,a
8329  18cc 4f            	clr	a
8330  18cd 02            	rlwa	x,a
8331  18ce 01            	rrwa	x,a
8332  18cf bbc9          	add	a,_mess+9
8333  18d1 2401          	jrnc	L461
8334  18d3 5c            	incw	x
8335  18d4               L461:
8336  18d4 02            	rlwa	x,a
8337  18d5 1f04          	ldw	(OFST-1,sp),x
8338  18d7 01            	rrwa	x,a
8339                     ; 1728 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8341  18d8 ce0012        	ldw	x,_ee_Umax
8342  18db 1304          	cpw	x,(OFST-1,sp)
8343  18dd 270a          	jreq	L1463
8346  18df 1e04          	ldw	x,(OFST-1,sp)
8347  18e1 89            	pushw	x
8348  18e2 ae0012        	ldw	x,#_ee_Umax
8349  18e5 cd0000        	call	c_eewrw
8351  18e8 85            	popw	x
8352  18e9               L1463:
8353                     ; 1729 	tempSS=mess[11]+(mess[12]*256);
8355  18e9 b6cc          	ld	a,_mess+12
8356  18eb 5f            	clrw	x
8357  18ec 97            	ld	xl,a
8358  18ed 4f            	clr	a
8359  18ee 02            	rlwa	x,a
8360  18ef 01            	rrwa	x,a
8361  18f0 bbcb          	add	a,_mess+11
8362  18f2 2401          	jrnc	L661
8363  18f4 5c            	incw	x
8364  18f5               L661:
8365  18f5 02            	rlwa	x,a
8366  18f6 1f04          	ldw	(OFST-1,sp),x
8367  18f8 01            	rrwa	x,a
8368                     ; 1730 	if(ee_dU!=tempSS) ee_dU=tempSS;
8370  18f9 ce0010        	ldw	x,_ee_dU
8371  18fc 1304          	cpw	x,(OFST-1,sp)
8372  18fe 270a          	jreq	L3463
8375  1900 1e04          	ldw	x,(OFST-1,sp)
8376  1902 89            	pushw	x
8377  1903 ae0010        	ldw	x,#_ee_dU
8378  1906 cd0000        	call	c_eewrw
8380  1909 85            	popw	x
8381  190a               L3463:
8382                     ; 1731 	if((mess[13]&0x0f)==0x5)
8384  190a b6cd          	ld	a,_mess+13
8385  190c a40f          	and	a,#15
8386  190e a105          	cp	a,#5
8387  1910 261a          	jrne	L5463
8388                     ; 1733 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8390  1912 ce0004        	ldw	x,_ee_AVT_MODE
8391  1915 a30055        	cpw	x,#85
8392  1918 2603          	jrne	L222
8393  191a cc1bbd        	jp	L3243
8394  191d               L222:
8397  191d ae0055        	ldw	x,#85
8398  1920 89            	pushw	x
8399  1921 ae0004        	ldw	x,#_ee_AVT_MODE
8400  1924 cd0000        	call	c_eewrw
8402  1927 85            	popw	x
8403  1928 acbd1bbd      	jpf	L3243
8404  192c               L5463:
8405                     ; 1735 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8407  192c ce0004        	ldw	x,_ee_AVT_MODE
8408  192f a30055        	cpw	x,#85
8409  1932 2703          	jreq	L422
8410  1934 cc1bbd        	jp	L3243
8411  1937               L422:
8414  1937 5f            	clrw	x
8415  1938 89            	pushw	x
8416  1939 ae0004        	ldw	x,#_ee_AVT_MODE
8417  193c cd0000        	call	c_eewrw
8419  193f 85            	popw	x
8420  1940 acbd1bbd      	jpf	L3243
8421  1944               L7363:
8422                     ; 1738 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8424  1944 b6c6          	ld	a,_mess+6
8425  1946 a1ff          	cp	a,#255
8426  1948 2703          	jreq	L622
8427  194a cc1a1b        	jp	L7563
8428  194d               L622:
8430  194d b6c7          	ld	a,_mess+7
8431  194f a1ff          	cp	a,#255
8432  1951 2703          	jreq	L032
8433  1953 cc1a1b        	jp	L7563
8434  1956               L032:
8436  1956 b6c8          	ld	a,_mess+8
8437  1958 a126          	cp	a,#38
8438  195a 2709          	jreq	L1663
8440  195c b6c8          	ld	a,_mess+8
8441  195e a129          	cp	a,#41
8442  1960 2703          	jreq	L232
8443  1962 cc1a1b        	jp	L7563
8444  1965               L232:
8445  1965               L1663:
8446                     ; 1741 	tempSS=mess[9]+(mess[10]*256);
8448  1965 b6ca          	ld	a,_mess+10
8449  1967 5f            	clrw	x
8450  1968 97            	ld	xl,a
8451  1969 4f            	clr	a
8452  196a 02            	rlwa	x,a
8453  196b 01            	rrwa	x,a
8454  196c bbc9          	add	a,_mess+9
8455  196e 2401          	jrnc	L071
8456  1970 5c            	incw	x
8457  1971               L071:
8458  1971 02            	rlwa	x,a
8459  1972 1f04          	ldw	(OFST-1,sp),x
8460  1974 01            	rrwa	x,a
8461                     ; 1742 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8463  1975 ce000e        	ldw	x,_ee_tmax
8464  1978 1304          	cpw	x,(OFST-1,sp)
8465  197a 270a          	jreq	L3663
8468  197c 1e04          	ldw	x,(OFST-1,sp)
8469  197e 89            	pushw	x
8470  197f ae000e        	ldw	x,#_ee_tmax
8471  1982 cd0000        	call	c_eewrw
8473  1985 85            	popw	x
8474  1986               L3663:
8475                     ; 1743 	tempSS=mess[11]+(mess[12]*256);
8477  1986 b6cc          	ld	a,_mess+12
8478  1988 5f            	clrw	x
8479  1989 97            	ld	xl,a
8480  198a 4f            	clr	a
8481  198b 02            	rlwa	x,a
8482  198c 01            	rrwa	x,a
8483  198d bbcb          	add	a,_mess+11
8484  198f 2401          	jrnc	L271
8485  1991 5c            	incw	x
8486  1992               L271:
8487  1992 02            	rlwa	x,a
8488  1993 1f04          	ldw	(OFST-1,sp),x
8489  1995 01            	rrwa	x,a
8490                     ; 1744 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8492  1996 ce000c        	ldw	x,_ee_tsign
8493  1999 1304          	cpw	x,(OFST-1,sp)
8494  199b 270a          	jreq	L5663
8497  199d 1e04          	ldw	x,(OFST-1,sp)
8498  199f 89            	pushw	x
8499  19a0 ae000c        	ldw	x,#_ee_tsign
8500  19a3 cd0000        	call	c_eewrw
8502  19a6 85            	popw	x
8503  19a7               L5663:
8504                     ; 1747 	if(mess[8]==MEM_KF1)
8506  19a7 b6c8          	ld	a,_mess+8
8507  19a9 a126          	cp	a,#38
8508  19ab 2623          	jrne	L7663
8509                     ; 1749 		if(ee_DEVICE!=0)ee_DEVICE=0;
8511  19ad ce0002        	ldw	x,_ee_DEVICE
8512  19b0 2709          	jreq	L1763
8515  19b2 5f            	clrw	x
8516  19b3 89            	pushw	x
8517  19b4 ae0002        	ldw	x,#_ee_DEVICE
8518  19b7 cd0000        	call	c_eewrw
8520  19ba 85            	popw	x
8521  19bb               L1763:
8522                     ; 1750 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8524  19bb b6cd          	ld	a,_mess+13
8525  19bd 5f            	clrw	x
8526  19be 97            	ld	xl,a
8527  19bf c30014        	cpw	x,_ee_TZAS
8528  19c2 270c          	jreq	L7663
8531  19c4 b6cd          	ld	a,_mess+13
8532  19c6 5f            	clrw	x
8533  19c7 97            	ld	xl,a
8534  19c8 89            	pushw	x
8535  19c9 ae0014        	ldw	x,#_ee_TZAS
8536  19cc cd0000        	call	c_eewrw
8538  19cf 85            	popw	x
8539  19d0               L7663:
8540                     ; 1752 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8542  19d0 b6c8          	ld	a,_mess+8
8543  19d2 a129          	cp	a,#41
8544  19d4 2703          	jreq	L432
8545  19d6 cc1bbd        	jp	L3243
8546  19d9               L432:
8547                     ; 1754 		if(ee_DEVICE!=1)ee_DEVICE=1;
8549  19d9 ce0002        	ldw	x,_ee_DEVICE
8550  19dc a30001        	cpw	x,#1
8551  19df 270b          	jreq	L7763
8554  19e1 ae0001        	ldw	x,#1
8555  19e4 89            	pushw	x
8556  19e5 ae0002        	ldw	x,#_ee_DEVICE
8557  19e8 cd0000        	call	c_eewrw
8559  19eb 85            	popw	x
8560  19ec               L7763:
8561                     ; 1755 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8563  19ec b6cd          	ld	a,_mess+13
8564  19ee 5f            	clrw	x
8565  19ef 97            	ld	xl,a
8566  19f0 c30000        	cpw	x,_ee_IMAXVENT
8567  19f3 270c          	jreq	L1073
8570  19f5 b6cd          	ld	a,_mess+13
8571  19f7 5f            	clrw	x
8572  19f8 97            	ld	xl,a
8573  19f9 89            	pushw	x
8574  19fa ae0000        	ldw	x,#_ee_IMAXVENT
8575  19fd cd0000        	call	c_eewrw
8577  1a00 85            	popw	x
8578  1a01               L1073:
8579                     ; 1756 			if(ee_TZAS!=3) ee_TZAS=3;
8581  1a01 ce0014        	ldw	x,_ee_TZAS
8582  1a04 a30003        	cpw	x,#3
8583  1a07 2603          	jrne	L632
8584  1a09 cc1bbd        	jp	L3243
8585  1a0c               L632:
8588  1a0c ae0003        	ldw	x,#3
8589  1a0f 89            	pushw	x
8590  1a10 ae0014        	ldw	x,#_ee_TZAS
8591  1a13 cd0000        	call	c_eewrw
8593  1a16 85            	popw	x
8594  1a17 acbd1bbd      	jpf	L3243
8595  1a1b               L7563:
8596                     ; 1760 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8598  1a1b b6c6          	ld	a,_mess+6
8599  1a1d c10001        	cp	a,_adress
8600  1a20 262d          	jrne	L7073
8602  1a22 b6c7          	ld	a,_mess+7
8603  1a24 c10001        	cp	a,_adress
8604  1a27 2626          	jrne	L7073
8606  1a29 b6c8          	ld	a,_mess+8
8607  1a2b a116          	cp	a,#22
8608  1a2d 2620          	jrne	L7073
8610  1a2f b6c9          	ld	a,_mess+9
8611  1a31 a163          	cp	a,#99
8612  1a33 261a          	jrne	L7073
8613                     ; 1762 	flags&=0b11100001;
8615  1a35 b60b          	ld	a,_flags
8616  1a37 a4e1          	and	a,#225
8617  1a39 b70b          	ld	_flags,a
8618                     ; 1763 	tsign_cnt=0;
8620  1a3b 5f            	clrw	x
8621  1a3c bf4a          	ldw	_tsign_cnt,x
8622                     ; 1764 	tmax_cnt=0;
8624  1a3e 5f            	clrw	x
8625  1a3f bf48          	ldw	_tmax_cnt,x
8626                     ; 1765 	umax_cnt=0;
8628  1a41 5f            	clrw	x
8629  1a42 bf62          	ldw	_umax_cnt,x
8630                     ; 1766 	umin_cnt=0;
8632  1a44 5f            	clrw	x
8633  1a45 bf60          	ldw	_umin_cnt,x
8634                     ; 1767 	led_drv_cnt=30;
8636  1a47 351e001a      	mov	_led_drv_cnt,#30
8638  1a4b acbd1bbd      	jpf	L3243
8639  1a4f               L7073:
8640                     ; 1769 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8642  1a4f b6c6          	ld	a,_mess+6
8643  1a51 a1ff          	cp	a,#255
8644  1a53 265f          	jrne	L3173
8646  1a55 b6c7          	ld	a,_mess+7
8647  1a57 a1ff          	cp	a,#255
8648  1a59 2659          	jrne	L3173
8650  1a5b b6c8          	ld	a,_mess+8
8651  1a5d a116          	cp	a,#22
8652  1a5f 2653          	jrne	L3173
8654  1a61 b6c9          	ld	a,_mess+9
8655  1a63 a116          	cp	a,#22
8656  1a65 264d          	jrne	L3173
8657                     ; 1771 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8659  1a67 b6ca          	ld	a,_mess+10
8660  1a69 a155          	cp	a,#85
8661  1a6b 260f          	jrne	L5173
8663  1a6d b6cb          	ld	a,_mess+11
8664  1a6f a155          	cp	a,#85
8665  1a71 2609          	jrne	L5173
8668  1a73 be5b          	ldw	x,__x_
8669  1a75 1c0001        	addw	x,#1
8670  1a78 bf5b          	ldw	__x_,x
8672  1a7a 2024          	jra	L7173
8673  1a7c               L5173:
8674                     ; 1772 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8676  1a7c b6ca          	ld	a,_mess+10
8677  1a7e a166          	cp	a,#102
8678  1a80 260f          	jrne	L1273
8680  1a82 b6cb          	ld	a,_mess+11
8681  1a84 a166          	cp	a,#102
8682  1a86 2609          	jrne	L1273
8685  1a88 be5b          	ldw	x,__x_
8686  1a8a 1d0001        	subw	x,#1
8687  1a8d bf5b          	ldw	__x_,x
8689  1a8f 200f          	jra	L7173
8690  1a91               L1273:
8691                     ; 1773 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8693  1a91 b6ca          	ld	a,_mess+10
8694  1a93 a177          	cp	a,#119
8695  1a95 2609          	jrne	L7173
8697  1a97 b6cb          	ld	a,_mess+11
8698  1a99 a177          	cp	a,#119
8699  1a9b 2603          	jrne	L7173
8702  1a9d 5f            	clrw	x
8703  1a9e bf5b          	ldw	__x_,x
8704  1aa0               L7173:
8705                     ; 1774      gran(&_x_,-XMAX,XMAX);
8707  1aa0 ae0019        	ldw	x,#25
8708  1aa3 89            	pushw	x
8709  1aa4 aeffe7        	ldw	x,#65511
8710  1aa7 89            	pushw	x
8711  1aa8 ae005b        	ldw	x,#__x_
8712  1aab cd0000        	call	_gran
8714  1aae 5b04          	addw	sp,#4
8716  1ab0 acbd1bbd      	jpf	L3243
8717  1ab4               L3173:
8718                     ; 1776 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8720  1ab4 b6c6          	ld	a,_mess+6
8721  1ab6 c10001        	cp	a,_adress
8722  1ab9 2665          	jrne	L1373
8724  1abb b6c7          	ld	a,_mess+7
8725  1abd c10001        	cp	a,_adress
8726  1ac0 265e          	jrne	L1373
8728  1ac2 b6c8          	ld	a,_mess+8
8729  1ac4 a116          	cp	a,#22
8730  1ac6 2658          	jrne	L1373
8732  1ac8 b6c9          	ld	a,_mess+9
8733  1aca b1ca          	cp	a,_mess+10
8734  1acc 2652          	jrne	L1373
8736  1ace b6c9          	ld	a,_mess+9
8737  1ad0 a1ee          	cp	a,#238
8738  1ad2 264c          	jrne	L1373
8739                     ; 1778 	rotor_int++;
8741  1ad4 be1b          	ldw	x,_rotor_int
8742  1ad6 1c0001        	addw	x,#1
8743  1ad9 bf1b          	ldw	_rotor_int,x
8744                     ; 1779      tempI=pwm_u;
8746  1adb be0c          	ldw	x,_pwm_u
8747  1add 1f04          	ldw	(OFST-1,sp),x
8748                     ; 1780 	ee_U_AVT=tempI;
8750  1adf 1e04          	ldw	x,(OFST-1,sp)
8751  1ae1 89            	pushw	x
8752  1ae2 ae000a        	ldw	x,#_ee_U_AVT
8753  1ae5 cd0000        	call	c_eewrw
8755  1ae8 85            	popw	x
8756                     ; 1781 	UU_AVT=Un;
8758  1ae9 be69          	ldw	x,_Un
8759  1aeb 89            	pushw	x
8760  1aec ae0006        	ldw	x,#_UU_AVT
8761  1aef cd0000        	call	c_eewrw
8763  1af2 85            	popw	x
8764                     ; 1782 	delay_ms(100);
8766  1af3 ae0064        	ldw	x,#100
8767  1af6 cd004c        	call	_delay_ms
8769                     ; 1783 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
8771  1af9 ce000a        	ldw	x,_ee_U_AVT
8772  1afc 1304          	cpw	x,(OFST-1,sp)
8773  1afe 2703          	jreq	L042
8774  1b00 cc1bbd        	jp	L3243
8775  1b03               L042:
8778  1b03 4b00          	push	#0
8779  1b05 4b00          	push	#0
8780  1b07 4b00          	push	#0
8781  1b09 4b00          	push	#0
8782  1b0b 4bdd          	push	#221
8783  1b0d 4bdd          	push	#221
8784  1b0f 4b91          	push	#145
8785  1b11 3b0001        	push	_adress
8786  1b14 ae018e        	ldw	x,#398
8787  1b17 cd13e8        	call	_can_transmit
8789  1b1a 5b08          	addw	sp,#8
8790  1b1c acbd1bbd      	jpf	L3243
8791  1b20               L1373:
8792                     ; 1788 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8794  1b20 b6c7          	ld	a,_mess+7
8795  1b22 a1da          	cp	a,#218
8796  1b24 2652          	jrne	L7373
8798  1b26 b6c6          	ld	a,_mess+6
8799  1b28 c10001        	cp	a,_adress
8800  1b2b 274b          	jreq	L7373
8802  1b2d b6c6          	ld	a,_mess+6
8803  1b2f a106          	cp	a,#6
8804  1b31 2445          	jruge	L7373
8805                     ; 1790 	i_main_bps_cnt[mess[6]]=0;
8807  1b33 b6c6          	ld	a,_mess+6
8808  1b35 5f            	clrw	x
8809  1b36 97            	ld	xl,a
8810  1b37 6f06          	clr	(_i_main_bps_cnt,x)
8811                     ; 1791 	i_main_flag[mess[6]]=1;
8813  1b39 b6c6          	ld	a,_mess+6
8814  1b3b 5f            	clrw	x
8815  1b3c 97            	ld	xl,a
8816  1b3d a601          	ld	a,#1
8817  1b3f e711          	ld	(_i_main_flag,x),a
8818                     ; 1792 	if(bMAIN)
8820                     	btst	_bMAIN
8821  1b46 2475          	jruge	L3243
8822                     ; 1794 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8824  1b48 b6c9          	ld	a,_mess+9
8825  1b4a 5f            	clrw	x
8826  1b4b 97            	ld	xl,a
8827  1b4c 4f            	clr	a
8828  1b4d 02            	rlwa	x,a
8829  1b4e 1f01          	ldw	(OFST-4,sp),x
8830  1b50 b6c8          	ld	a,_mess+8
8831  1b52 5f            	clrw	x
8832  1b53 97            	ld	xl,a
8833  1b54 72fb01        	addw	x,(OFST-4,sp)
8834  1b57 b6c6          	ld	a,_mess+6
8835  1b59 905f          	clrw	y
8836  1b5b 9097          	ld	yl,a
8837  1b5d 9058          	sllw	y
8838  1b5f 90ef17        	ldw	(_i_main,y),x
8839                     ; 1795 		i_main[adress]=I;
8841  1b62 c60001        	ld	a,_adress
8842  1b65 5f            	clrw	x
8843  1b66 97            	ld	xl,a
8844  1b67 58            	sllw	x
8845  1b68 90be6b        	ldw	y,_I
8846  1b6b ef17          	ldw	(_i_main,x),y
8847                     ; 1796      	i_main_flag[adress]=1;
8849  1b6d c60001        	ld	a,_adress
8850  1b70 5f            	clrw	x
8851  1b71 97            	ld	xl,a
8852  1b72 a601          	ld	a,#1
8853  1b74 e711          	ld	(_i_main_flag,x),a
8854  1b76 2045          	jra	L3243
8855  1b78               L7373:
8856                     ; 1800 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8858  1b78 b6c7          	ld	a,_mess+7
8859  1b7a a1db          	cp	a,#219
8860  1b7c 263f          	jrne	L3243
8862  1b7e b6c6          	ld	a,_mess+6
8863  1b80 c10001        	cp	a,_adress
8864  1b83 2738          	jreq	L3243
8866  1b85 b6c6          	ld	a,_mess+6
8867  1b87 a106          	cp	a,#6
8868  1b89 2432          	jruge	L3243
8869                     ; 1802 	i_main_bps_cnt[mess[6]]=0;
8871  1b8b b6c6          	ld	a,_mess+6
8872  1b8d 5f            	clrw	x
8873  1b8e 97            	ld	xl,a
8874  1b8f 6f06          	clr	(_i_main_bps_cnt,x)
8875                     ; 1803 	i_main_flag[mess[6]]=1;		
8877  1b91 b6c6          	ld	a,_mess+6
8878  1b93 5f            	clrw	x
8879  1b94 97            	ld	xl,a
8880  1b95 a601          	ld	a,#1
8881  1b97 e711          	ld	(_i_main_flag,x),a
8882                     ; 1804 	if(bMAIN)
8884                     	btst	_bMAIN
8885  1b9e 241d          	jruge	L3243
8886                     ; 1806 		if(mess[9]==0)i_main_flag[i]=1;
8888  1ba0 3dc9          	tnz	_mess+9
8889  1ba2 260a          	jrne	L1573
8892  1ba4 7b03          	ld	a,(OFST-2,sp)
8893  1ba6 5f            	clrw	x
8894  1ba7 97            	ld	xl,a
8895  1ba8 a601          	ld	a,#1
8896  1baa e711          	ld	(_i_main_flag,x),a
8898  1bac 2006          	jra	L3573
8899  1bae               L1573:
8900                     ; 1807 		else i_main_flag[i]=0;
8902  1bae 7b03          	ld	a,(OFST-2,sp)
8903  1bb0 5f            	clrw	x
8904  1bb1 97            	ld	xl,a
8905  1bb2 6f11          	clr	(_i_main_flag,x)
8906  1bb4               L3573:
8907                     ; 1808 		i_main_flag[adress]=1;
8909  1bb4 c60001        	ld	a,_adress
8910  1bb7 5f            	clrw	x
8911  1bb8 97            	ld	xl,a
8912  1bb9 a601          	ld	a,#1
8913  1bbb e711          	ld	(_i_main_flag,x),a
8914  1bbd               L3243:
8915                     ; 1814 can_in_an_end:
8915                     ; 1815 bCAN_RX=0;
8917  1bbd 3f0a          	clr	_bCAN_RX
8918                     ; 1816 }   
8921  1bbf 5b05          	addw	sp,#5
8922  1bc1 81            	ret
8945                     ; 1819 void t4_init(void){
8946                     	switch	.text
8947  1bc2               _t4_init:
8951                     ; 1820 	TIM4->PSCR = 4;
8953  1bc2 35045345      	mov	21317,#4
8954                     ; 1821 	TIM4->ARR= 77;
8956  1bc6 354d5346      	mov	21318,#77
8957                     ; 1822 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8959  1bca 72105341      	bset	21313,#0
8960                     ; 1824 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8962  1bce 35855340      	mov	21312,#133
8963                     ; 1826 }
8966  1bd2 81            	ret
8989                     ; 1829 void t1_init(void)
8989                     ; 1830 {
8990                     	switch	.text
8991  1bd3               _t1_init:
8995                     ; 1831 TIM1->ARRH= 0x03;
8997  1bd3 35035262      	mov	21090,#3
8998                     ; 1832 TIM1->ARRL= 0xff;
9000  1bd7 35ff5263      	mov	21091,#255
9001                     ; 1833 TIM1->CCR1H= 0x00;	
9003  1bdb 725f5265      	clr	21093
9004                     ; 1834 TIM1->CCR1L= 0xff;
9006  1bdf 35ff5266      	mov	21094,#255
9007                     ; 1835 TIM1->CCR2H= 0x00;	
9009  1be3 725f5267      	clr	21095
9010                     ; 1836 TIM1->CCR2L= 0x00;
9012  1be7 725f5268      	clr	21096
9013                     ; 1837 TIM1->CCR3H= 0x00;	
9015  1beb 725f5269      	clr	21097
9016                     ; 1838 TIM1->CCR3L= 0x64;
9018  1bef 3564526a      	mov	21098,#100
9019                     ; 1840 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9021  1bf3 35685258      	mov	21080,#104
9022                     ; 1841 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9024  1bf7 35685259      	mov	21081,#104
9025                     ; 1842 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9027  1bfb 3568525a      	mov	21082,#104
9028                     ; 1843 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9030  1bff 3511525c      	mov	21084,#17
9031                     ; 1844 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9033  1c03 3501525d      	mov	21085,#1
9034                     ; 1845 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9036  1c07 35815250      	mov	21072,#129
9037                     ; 1846 TIM1->BKR|= TIM1_BKR_AOE;
9039  1c0b 721c526d      	bset	21101,#6
9040                     ; 1847 }
9043  1c0f 81            	ret
9068                     ; 1851 void adc2_init(void)
9068                     ; 1852 {
9069                     	switch	.text
9070  1c10               _adc2_init:
9074                     ; 1853 adc_plazma[0]++;
9076  1c10 beb2          	ldw	x,_adc_plazma
9077  1c12 1c0001        	addw	x,#1
9078  1c15 bfb2          	ldw	_adc_plazma,x
9079                     ; 1877 GPIOB->DDR&=~(1<<4);
9081  1c17 72195007      	bres	20487,#4
9082                     ; 1878 GPIOB->CR1&=~(1<<4);
9084  1c1b 72195008      	bres	20488,#4
9085                     ; 1879 GPIOB->CR2&=~(1<<4);
9087  1c1f 72195009      	bres	20489,#4
9088                     ; 1881 GPIOB->DDR&=~(1<<5);
9090  1c23 721b5007      	bres	20487,#5
9091                     ; 1882 GPIOB->CR1&=~(1<<5);
9093  1c27 721b5008      	bres	20488,#5
9094                     ; 1883 GPIOB->CR2&=~(1<<5);
9096  1c2b 721b5009      	bres	20489,#5
9097                     ; 1885 GPIOB->DDR&=~(1<<6);
9099  1c2f 721d5007      	bres	20487,#6
9100                     ; 1886 GPIOB->CR1&=~(1<<6);
9102  1c33 721d5008      	bres	20488,#6
9103                     ; 1887 GPIOB->CR2&=~(1<<6);
9105  1c37 721d5009      	bres	20489,#6
9106                     ; 1889 GPIOB->DDR&=~(1<<7);
9108  1c3b 721f5007      	bres	20487,#7
9109                     ; 1890 GPIOB->CR1&=~(1<<7);
9111  1c3f 721f5008      	bres	20488,#7
9112                     ; 1891 GPIOB->CR2&=~(1<<7);
9114  1c43 721f5009      	bres	20489,#7
9115                     ; 1901 ADC2->TDRL=0xff;
9117  1c47 35ff5407      	mov	21511,#255
9118                     ; 1903 ADC2->CR2=0x08;
9120  1c4b 35085402      	mov	21506,#8
9121                     ; 1904 ADC2->CR1=0x40;
9123  1c4f 35405401      	mov	21505,#64
9124                     ; 1907 	ADC2->CSR=0x20+adc_ch+3;
9126  1c53 b6bf          	ld	a,_adc_ch
9127  1c55 ab23          	add	a,#35
9128  1c57 c75400        	ld	21504,a
9129                     ; 1909 	ADC2->CR1|=1;
9131  1c5a 72105401      	bset	21505,#0
9132                     ; 1910 	ADC2->CR1|=1;
9134  1c5e 72105401      	bset	21505,#0
9135                     ; 1913 adc_plazma[1]=adc_ch;
9137  1c62 b6bf          	ld	a,_adc_ch
9138  1c64 5f            	clrw	x
9139  1c65 97            	ld	xl,a
9140  1c66 bfb4          	ldw	_adc_plazma+2,x
9141                     ; 1914 }
9144  1c68 81            	ret
9178                     ; 1923 @far @interrupt void TIM4_UPD_Interrupt (void) 
9178                     ; 1924 {
9180                     	switch	.text
9181  1c69               f_TIM4_UPD_Interrupt:
9185                     ; 1925 TIM4->SR1&=~TIM4_SR1_UIF;
9187  1c69 72115342      	bres	21314,#0
9188                     ; 1927 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9190  1c6d 3c05          	inc	_pwm_vent_cnt
9191  1c6f b605          	ld	a,_pwm_vent_cnt
9192  1c71 a10a          	cp	a,#10
9193  1c73 2502          	jrult	L5104
9196  1c75 3f05          	clr	_pwm_vent_cnt
9197  1c77               L5104:
9198                     ; 1928 GPIOB->ODR|=(1<<3);
9200  1c77 72165005      	bset	20485,#3
9201                     ; 1929 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9203  1c7b b605          	ld	a,_pwm_vent_cnt
9204  1c7d a105          	cp	a,#5
9205  1c7f 2504          	jrult	L7104
9208  1c81 72175005      	bres	20485,#3
9209  1c85               L7104:
9210                     ; 1934 if(++t0_cnt0>=100)
9212  1c85 9c            	rvf
9213  1c86 be01          	ldw	x,_t0_cnt0
9214  1c88 1c0001        	addw	x,#1
9215  1c8b bf01          	ldw	_t0_cnt0,x
9216  1c8d a30064        	cpw	x,#100
9217  1c90 2f3f          	jrslt	L1204
9218                     ; 1936 	t0_cnt0=0;
9220  1c92 5f            	clrw	x
9221  1c93 bf01          	ldw	_t0_cnt0,x
9222                     ; 1937 	b100Hz=1;
9224  1c95 72100008      	bset	_b100Hz
9225                     ; 1939 	if(++t0_cnt1>=10)
9227  1c99 3c03          	inc	_t0_cnt1
9228  1c9b b603          	ld	a,_t0_cnt1
9229  1c9d a10a          	cp	a,#10
9230  1c9f 2506          	jrult	L3204
9231                     ; 1941 		t0_cnt1=0;
9233  1ca1 3f03          	clr	_t0_cnt1
9234                     ; 1942 		b10Hz=1;
9236  1ca3 72100007      	bset	_b10Hz
9237  1ca7               L3204:
9238                     ; 1945 	if(++t0_cnt2>=20)
9240  1ca7 3c04          	inc	_t0_cnt2
9241  1ca9 b604          	ld	a,_t0_cnt2
9242  1cab a114          	cp	a,#20
9243  1cad 2506          	jrult	L5204
9244                     ; 1947 		t0_cnt2=0;
9246  1caf 3f04          	clr	_t0_cnt2
9247                     ; 1948 		b5Hz=1;
9249  1cb1 72100006      	bset	_b5Hz
9250  1cb5               L5204:
9251                     ; 1952 	if(++t0_cnt4>=50)
9253  1cb5 3c06          	inc	_t0_cnt4
9254  1cb7 b606          	ld	a,_t0_cnt4
9255  1cb9 a132          	cp	a,#50
9256  1cbb 2506          	jrult	L7204
9257                     ; 1954 		t0_cnt4=0;
9259  1cbd 3f06          	clr	_t0_cnt4
9260                     ; 1955 		b2Hz=1;
9262  1cbf 72100005      	bset	_b2Hz
9263  1cc3               L7204:
9264                     ; 1958 	if(++t0_cnt3>=100)
9266  1cc3 3c05          	inc	_t0_cnt3
9267  1cc5 b605          	ld	a,_t0_cnt3
9268  1cc7 a164          	cp	a,#100
9269  1cc9 2506          	jrult	L1204
9270                     ; 1960 		t0_cnt3=0;
9272  1ccb 3f05          	clr	_t0_cnt3
9273                     ; 1961 		b1Hz=1;
9275  1ccd 72100004      	bset	_b1Hz
9276  1cd1               L1204:
9277                     ; 1967 }
9280  1cd1 80            	iret
9305                     ; 1970 @far @interrupt void CAN_RX_Interrupt (void) 
9305                     ; 1971 {
9306                     	switch	.text
9307  1cd2               f_CAN_RX_Interrupt:
9311                     ; 1973 CAN->PSR= 7;									// page 7 - read messsage
9313  1cd2 35075427      	mov	21543,#7
9314                     ; 1975 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9316  1cd6 ae000e        	ldw	x,#14
9317  1cd9               L452:
9318  1cd9 d65427        	ld	a,(21543,x)
9319  1cdc e7bf          	ld	(_mess-1,x),a
9320  1cde 5a            	decw	x
9321  1cdf 26f8          	jrne	L452
9322                     ; 1986 bCAN_RX=1;
9324  1ce1 3501000a      	mov	_bCAN_RX,#1
9325                     ; 1987 CAN->RFR|=(1<<5);
9327  1ce5 721a5424      	bset	21540,#5
9328                     ; 1989 }
9331  1ce9 80            	iret
9354                     ; 1992 @far @interrupt void CAN_TX_Interrupt (void) 
9354                     ; 1993 {
9355                     	switch	.text
9356  1cea               f_CAN_TX_Interrupt:
9360                     ; 1994 if((CAN->TSR)&(1<<0))
9362  1cea c65422        	ld	a,21538
9363  1ced a501          	bcp	a,#1
9364  1cef 2708          	jreq	L3504
9365                     ; 1996 	bTX_FREE=1;	
9367  1cf1 35010009      	mov	_bTX_FREE,#1
9368                     ; 1998 	CAN->TSR|=(1<<0);
9370  1cf5 72105422      	bset	21538,#0
9371  1cf9               L3504:
9372                     ; 2000 }
9375  1cf9 80            	iret
9433                     ; 2003 @far @interrupt void ADC2_EOC_Interrupt (void) {
9434                     	switch	.text
9435  1cfa               f_ADC2_EOC_Interrupt:
9437       00000009      OFST:	set	9
9438  1cfa be00          	ldw	x,c_x
9439  1cfc 89            	pushw	x
9440  1cfd be00          	ldw	x,c_y
9441  1cff 89            	pushw	x
9442  1d00 be02          	ldw	x,c_lreg+2
9443  1d02 89            	pushw	x
9444  1d03 be00          	ldw	x,c_lreg
9445  1d05 89            	pushw	x
9446  1d06 5209          	subw	sp,#9
9449                     ; 2008 adc_plazma[2]++;
9451  1d08 beb6          	ldw	x,_adc_plazma+4
9452  1d0a 1c0001        	addw	x,#1
9453  1d0d bfb6          	ldw	_adc_plazma+4,x
9454                     ; 2015 ADC2->CSR&=~(1<<7);
9456  1d0f 721f5400      	bres	21504,#7
9457                     ; 2017 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9459  1d13 c65405        	ld	a,21509
9460  1d16 b703          	ld	c_lreg+3,a
9461  1d18 3f02          	clr	c_lreg+2
9462  1d1a 3f01          	clr	c_lreg+1
9463  1d1c 3f00          	clr	c_lreg
9464  1d1e 96            	ldw	x,sp
9465  1d1f 1c0001        	addw	x,#OFST-8
9466  1d22 cd0000        	call	c_rtol
9468  1d25 c65404        	ld	a,21508
9469  1d28 5f            	clrw	x
9470  1d29 97            	ld	xl,a
9471  1d2a 90ae0100      	ldw	y,#256
9472  1d2e cd0000        	call	c_umul
9474  1d31 96            	ldw	x,sp
9475  1d32 1c0001        	addw	x,#OFST-8
9476  1d35 cd0000        	call	c_ladd
9478  1d38 96            	ldw	x,sp
9479  1d39 1c0006        	addw	x,#OFST-3
9480  1d3c cd0000        	call	c_rtol
9482                     ; 2022 if(adr_drv_stat==1)
9484  1d3f b608          	ld	a,_adr_drv_stat
9485  1d41 a101          	cp	a,#1
9486  1d43 260b          	jrne	L3014
9487                     ; 2024 	adr_drv_stat=2;
9489  1d45 35020008      	mov	_adr_drv_stat,#2
9490                     ; 2025 	adc_buff_[0]=temp_adc;
9492  1d49 1e08          	ldw	x,(OFST-1,sp)
9493  1d4b cf0005        	ldw	_adc_buff_,x
9495  1d4e 2020          	jra	L5014
9496  1d50               L3014:
9497                     ; 2028 else if(adr_drv_stat==3)
9499  1d50 b608          	ld	a,_adr_drv_stat
9500  1d52 a103          	cp	a,#3
9501  1d54 260b          	jrne	L7014
9502                     ; 2030 	adr_drv_stat=4;
9504  1d56 35040008      	mov	_adr_drv_stat,#4
9505                     ; 2031 	adc_buff_[1]=temp_adc;
9507  1d5a 1e08          	ldw	x,(OFST-1,sp)
9508  1d5c cf0007        	ldw	_adc_buff_+2,x
9510  1d5f 200f          	jra	L5014
9511  1d61               L7014:
9512                     ; 2034 else if(adr_drv_stat==5)
9514  1d61 b608          	ld	a,_adr_drv_stat
9515  1d63 a105          	cp	a,#5
9516  1d65 2609          	jrne	L5014
9517                     ; 2036 	adr_drv_stat=6;
9519  1d67 35060008      	mov	_adr_drv_stat,#6
9520                     ; 2037 	adc_buff_[9]=temp_adc;
9522  1d6b 1e08          	ldw	x,(OFST-1,sp)
9523  1d6d cf0017        	ldw	_adc_buff_+18,x
9524  1d70               L5014:
9525                     ; 2040 adc_buff[adc_ch][adc_cnt]=temp_adc;
9527  1d70 b6be          	ld	a,_adc_cnt
9528  1d72 5f            	clrw	x
9529  1d73 97            	ld	xl,a
9530  1d74 58            	sllw	x
9531  1d75 1f03          	ldw	(OFST-6,sp),x
9532  1d77 b6bf          	ld	a,_adc_ch
9533  1d79 97            	ld	xl,a
9534  1d7a a620          	ld	a,#32
9535  1d7c 42            	mul	x,a
9536  1d7d 72fb03        	addw	x,(OFST-6,sp)
9537  1d80 1608          	ldw	y,(OFST-1,sp)
9538  1d82 df0019        	ldw	(_adc_buff,x),y
9539                     ; 2046 adc_ch++;
9541  1d85 3cbf          	inc	_adc_ch
9542                     ; 2047 if(adc_ch>=5)
9544  1d87 b6bf          	ld	a,_adc_ch
9545  1d89 a105          	cp	a,#5
9546  1d8b 250c          	jrult	L5114
9547                     ; 2050 	adc_ch=0;
9549  1d8d 3fbf          	clr	_adc_ch
9550                     ; 2051 	adc_cnt++;
9552  1d8f 3cbe          	inc	_adc_cnt
9553                     ; 2052 	if(adc_cnt>=16)
9555  1d91 b6be          	ld	a,_adc_cnt
9556  1d93 a110          	cp	a,#16
9557  1d95 2502          	jrult	L5114
9558                     ; 2054 		adc_cnt=0;
9560  1d97 3fbe          	clr	_adc_cnt
9561  1d99               L5114:
9562                     ; 2058 if((adc_cnt&0x03)==0)
9564  1d99 b6be          	ld	a,_adc_cnt
9565  1d9b a503          	bcp	a,#3
9566  1d9d 264b          	jrne	L1214
9567                     ; 2062 	tempSS=0;
9569  1d9f ae0000        	ldw	x,#0
9570  1da2 1f08          	ldw	(OFST-1,sp),x
9571  1da4 ae0000        	ldw	x,#0
9572  1da7 1f06          	ldw	(OFST-3,sp),x
9573                     ; 2063 	for(i=0;i<16;i++)
9575  1da9 0f05          	clr	(OFST-4,sp)
9576  1dab               L3214:
9577                     ; 2065 		tempSS+=(signed long)adc_buff[adc_ch][i];
9579  1dab 7b05          	ld	a,(OFST-4,sp)
9580  1dad 5f            	clrw	x
9581  1dae 97            	ld	xl,a
9582  1daf 58            	sllw	x
9583  1db0 1f03          	ldw	(OFST-6,sp),x
9584  1db2 b6bf          	ld	a,_adc_ch
9585  1db4 97            	ld	xl,a
9586  1db5 a620          	ld	a,#32
9587  1db7 42            	mul	x,a
9588  1db8 72fb03        	addw	x,(OFST-6,sp)
9589  1dbb de0019        	ldw	x,(_adc_buff,x)
9590  1dbe cd0000        	call	c_itolx
9592  1dc1 96            	ldw	x,sp
9593  1dc2 1c0006        	addw	x,#OFST-3
9594  1dc5 cd0000        	call	c_lgadd
9596                     ; 2063 	for(i=0;i<16;i++)
9598  1dc8 0c05          	inc	(OFST-4,sp)
9601  1dca 7b05          	ld	a,(OFST-4,sp)
9602  1dcc a110          	cp	a,#16
9603  1dce 25db          	jrult	L3214
9604                     ; 2067 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9606  1dd0 96            	ldw	x,sp
9607  1dd1 1c0006        	addw	x,#OFST-3
9608  1dd4 cd0000        	call	c_ltor
9610  1dd7 a604          	ld	a,#4
9611  1dd9 cd0000        	call	c_lrsh
9613  1ddc be02          	ldw	x,c_lreg+2
9614  1dde b6bf          	ld	a,_adc_ch
9615  1de0 905f          	clrw	y
9616  1de2 9097          	ld	yl,a
9617  1de4 9058          	sllw	y
9618  1de6 90df0005      	ldw	(_adc_buff_,y),x
9619  1dea               L1214:
9620                     ; 2078 adc_plazma_short++;
9622  1dea bebc          	ldw	x,_adc_plazma_short
9623  1dec 1c0001        	addw	x,#1
9624  1def bfbc          	ldw	_adc_plazma_short,x
9625                     ; 2093 }
9628  1df1 5b09          	addw	sp,#9
9629  1df3 85            	popw	x
9630  1df4 bf00          	ldw	c_lreg,x
9631  1df6 85            	popw	x
9632  1df7 bf02          	ldw	c_lreg+2,x
9633  1df9 85            	popw	x
9634  1dfa bf00          	ldw	c_y,x
9635  1dfc 85            	popw	x
9636  1dfd bf00          	ldw	c_x,x
9637  1dff 80            	iret
9700                     ; 2101 main()
9700                     ; 2102 {
9702                     	switch	.text
9703  1e00               _main:
9707                     ; 2104 CLK->ECKR|=1;
9709  1e00 721050c1      	bset	20673,#0
9711  1e04               L3414:
9712                     ; 2105 while((CLK->ECKR & 2) == 0);
9714  1e04 c650c1        	ld	a,20673
9715  1e07 a502          	bcp	a,#2
9716  1e09 27f9          	jreq	L3414
9717                     ; 2106 CLK->SWCR|=2;
9719  1e0b 721250c5      	bset	20677,#1
9720                     ; 2107 CLK->SWR=0xB4;
9722  1e0f 35b450c4      	mov	20676,#180
9723                     ; 2109 delay_ms(200);
9725  1e13 ae00c8        	ldw	x,#200
9726  1e16 cd004c        	call	_delay_ms
9728                     ; 2110 FLASH_DUKR=0xae;
9730  1e19 35ae5064      	mov	_FLASH_DUKR,#174
9731                     ; 2111 FLASH_DUKR=0x56;
9733  1e1d 35565064      	mov	_FLASH_DUKR,#86
9734                     ; 2112 enableInterrupts();
9737  1e21 9a            rim
9739                     ; 2115 adr_drv_v3();
9742  1e22 cd1036        	call	_adr_drv_v3
9744                     ; 2119 t4_init();
9746  1e25 cd1bc2        	call	_t4_init
9748                     ; 2121 		GPIOG->DDR|=(1<<0);
9750  1e28 72105020      	bset	20512,#0
9751                     ; 2122 		GPIOG->CR1|=(1<<0);
9753  1e2c 72105021      	bset	20513,#0
9754                     ; 2123 		GPIOG->CR2&=~(1<<0);	
9756  1e30 72115022      	bres	20514,#0
9757                     ; 2126 		GPIOG->DDR&=~(1<<1);
9759  1e34 72135020      	bres	20512,#1
9760                     ; 2127 		GPIOG->CR1|=(1<<1);
9762  1e38 72125021      	bset	20513,#1
9763                     ; 2128 		GPIOG->CR2&=~(1<<1);
9765  1e3c 72135022      	bres	20514,#1
9766                     ; 2130 init_CAN();
9768  1e40 cd1379        	call	_init_CAN
9770                     ; 2135 GPIOC->DDR|=(1<<1);
9772  1e43 7212500c      	bset	20492,#1
9773                     ; 2136 GPIOC->CR1|=(1<<1);
9775  1e47 7212500d      	bset	20493,#1
9776                     ; 2137 GPIOC->CR2|=(1<<1);
9778  1e4b 7212500e      	bset	20494,#1
9779                     ; 2139 GPIOC->DDR|=(1<<2);
9781  1e4f 7214500c      	bset	20492,#2
9782                     ; 2140 GPIOC->CR1|=(1<<2);
9784  1e53 7214500d      	bset	20493,#2
9785                     ; 2141 GPIOC->CR2|=(1<<2);
9787  1e57 7214500e      	bset	20494,#2
9788                     ; 2148 t1_init();
9790  1e5b cd1bd3        	call	_t1_init
9792                     ; 2150 GPIOA->DDR|=(1<<5);
9794  1e5e 721a5002      	bset	20482,#5
9795                     ; 2151 GPIOA->CR1|=(1<<5);
9797  1e62 721a5003      	bset	20483,#5
9798                     ; 2152 GPIOA->CR2&=~(1<<5);
9800  1e66 721b5004      	bres	20484,#5
9801                     ; 2158 GPIOB->DDR&=~(1<<3);
9803  1e6a 72175007      	bres	20487,#3
9804                     ; 2159 GPIOB->CR1&=~(1<<3);
9806  1e6e 72175008      	bres	20488,#3
9807                     ; 2160 GPIOB->CR2&=~(1<<3);
9809  1e72 72175009      	bres	20489,#3
9810                     ; 2162 GPIOC->DDR|=(1<<3);
9812  1e76 7216500c      	bset	20492,#3
9813                     ; 2163 GPIOC->CR1|=(1<<3);
9815  1e7a 7216500d      	bset	20493,#3
9816                     ; 2164 GPIOC->CR2|=(1<<3);
9818  1e7e 7216500e      	bset	20494,#3
9819                     ; 2167 if(bps_class==bpsIPS) 
9821  1e82 b601          	ld	a,_bps_class
9822  1e84 a101          	cp	a,#1
9823  1e86 260a          	jrne	L1514
9824                     ; 2169 	pwm_u=ee_U_AVT;
9826  1e88 ce000a        	ldw	x,_ee_U_AVT
9827  1e8b bf0c          	ldw	_pwm_u,x
9828                     ; 2170 	volum_u_main_=ee_U_AVT;
9830  1e8d ce000a        	ldw	x,_ee_U_AVT
9831  1e90 bf1d          	ldw	_volum_u_main_,x
9832  1e92               L1514:
9833                     ; 2177 	if(bCAN_RX)
9835  1e92 3d0a          	tnz	_bCAN_RX
9836  1e94 2705          	jreq	L5514
9837                     ; 2179 		bCAN_RX=0;
9839  1e96 3f0a          	clr	_bCAN_RX
9840                     ; 2180 		can_in_an();	
9842  1e98 cd1584        	call	_can_in_an
9844  1e9b               L5514:
9845                     ; 2182 	if(b100Hz)
9847                     	btst	_b100Hz
9848  1ea0 240a          	jruge	L7514
9849                     ; 2184 		b100Hz=0;
9851  1ea2 72110008      	bres	_b100Hz
9852                     ; 2193 		adc2_init();
9854  1ea6 cd1c10        	call	_adc2_init
9856                     ; 2194 		can_tx_hndl();
9858  1ea9 cd146c        	call	_can_tx_hndl
9860  1eac               L7514:
9861                     ; 2197 	if(b10Hz)
9863                     	btst	_b10Hz
9864  1eb1 2419          	jruge	L1614
9865                     ; 2199 		b10Hz=0;
9867  1eb3 72110007      	bres	_b10Hz
9868                     ; 2201           matemat();
9870  1eb7 cd0bed        	call	_matemat
9872                     ; 2202 	    	led_drv(); 
9874  1eba cd0711        	call	_led_drv
9876                     ; 2203 	     link_drv();
9878  1ebd cd07ff        	call	_link_drv
9880                     ; 2204 	     pwr_hndl();		//вычисление воздействий на силу
9882  1ec0 cd0ad1        	call	_pwr_hndl
9884                     ; 2205 	     JP_drv();
9886  1ec3 cd0774        	call	_JP_drv
9888                     ; 2206 	     flags_drv();
9890  1ec6 cd0feb        	call	_flags_drv
9892                     ; 2207 		net_drv();
9894  1ec9 cd14d6        	call	_net_drv
9896  1ecc               L1614:
9897                     ; 2210 	if(b5Hz)
9899                     	btst	_b5Hz
9900  1ed1 240d          	jruge	L3614
9901                     ; 2212 		b5Hz=0;
9903  1ed3 72110006      	bres	_b5Hz
9904                     ; 2214 		pwr_drv();		//воздействие на силу
9906  1ed7 cd09b1        	call	_pwr_drv
9908                     ; 2215 		led_hndl();
9910  1eda cd008e        	call	_led_hndl
9912                     ; 2217 		vent_drv();
9914  1edd cd084e        	call	_vent_drv
9916  1ee0               L3614:
9917                     ; 2220 	if(b2Hz)
9919                     	btst	_b2Hz
9920  1ee5 2404          	jruge	L5614
9921                     ; 2222 		b2Hz=0;
9923  1ee7 72110005      	bres	_b2Hz
9924  1eeb               L5614:
9925                     ; 2231 	if(b1Hz)
9927                     	btst	_b1Hz
9928  1ef0 24a0          	jruge	L1514
9929                     ; 2233 		b1Hz=0;
9931  1ef2 72110004      	bres	_b1Hz
9932                     ; 2235 		temper_drv();			//вычисление аварий температуры
9934  1ef6 cd0d1b        	call	_temper_drv
9936                     ; 2236 		u_drv();
9938  1ef9 cd0df2        	call	_u_drv
9940                     ; 2237           x_drv();
9942  1efc cd0ed2        	call	_x_drv
9944                     ; 2238           if(main_cnt<1000)main_cnt++;
9946  1eff 9c            	rvf
9947  1f00 be4e          	ldw	x,_main_cnt
9948  1f02 a303e8        	cpw	x,#1000
9949  1f05 2e07          	jrsge	L1714
9952  1f07 be4e          	ldw	x,_main_cnt
9953  1f09 1c0001        	addw	x,#1
9954  1f0c bf4e          	ldw	_main_cnt,x
9955  1f0e               L1714:
9956                     ; 2239   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9958  1f0e b65f          	ld	a,_link
9959  1f10 a1aa          	cp	a,#170
9960  1f12 2706          	jreq	L5714
9962  1f14 b647          	ld	a,_jp_mode
9963  1f16 a103          	cp	a,#3
9964  1f18 2603          	jrne	L3714
9965  1f1a               L5714:
9968  1f1a cd0f4c        	call	_apv_hndl
9970  1f1d               L3714:
9971                     ; 2242   		can_error_cnt++;
9973  1f1d 3c6d          	inc	_can_error_cnt
9974                     ; 2243   		if(can_error_cnt>=10)
9976  1f1f b66d          	ld	a,_can_error_cnt
9977  1f21 a10a          	cp	a,#10
9978  1f23 2505          	jrult	L7714
9979                     ; 2245   			can_error_cnt=0;
9981  1f25 3f6d          	clr	_can_error_cnt
9982                     ; 2246 			init_CAN();
9984  1f27 cd1379        	call	_init_CAN
9986  1f2a               L7714:
9987                     ; 2250 		volum_u_main_drv();
9989  1f2a cd1226        	call	_volum_u_main_drv
9991                     ; 2252 		pwm_stat++;
9993  1f2d 3c04          	inc	_pwm_stat
9994                     ; 2253 		if(pwm_stat>=10)pwm_stat=0;
9996  1f2f b604          	ld	a,_pwm_stat
9997  1f31 a10a          	cp	a,#10
9998  1f33 2502          	jrult	L1024
10001  1f35 3f04          	clr	_pwm_stat
10002  1f37               L1024:
10003                     ; 2254 adc_plazma_short++;
10005  1f37 bebc          	ldw	x,_adc_plazma_short
10006  1f39 1c0001        	addw	x,#1
10007  1f3c bfbc          	ldw	_adc_plazma_short,x
10008  1f3e ac921e92      	jpf	L1514
11031                     	xdef	_main
11032                     	xdef	f_ADC2_EOC_Interrupt
11033                     	xdef	f_CAN_TX_Interrupt
11034                     	xdef	f_CAN_RX_Interrupt
11035                     	xdef	f_TIM4_UPD_Interrupt
11036                     	xdef	_adc2_init
11037                     	xdef	_t1_init
11038                     	xdef	_t4_init
11039                     	xdef	_can_in_an
11040                     	xdef	_net_drv
11041                     	xdef	_can_tx_hndl
11042                     	xdef	_can_transmit
11043                     	xdef	_init_CAN
11044                     	xdef	_volum_u_main_drv
11045                     	xdef	_adr_drv_v3
11046                     	xdef	_adr_drv_v4
11047                     	xdef	_flags_drv
11048                     	xdef	_apv_hndl
11049                     	xdef	_apv_stop
11050                     	xdef	_apv_start
11051                     	xdef	_x_drv
11052                     	xdef	_u_drv
11053                     	xdef	_temper_drv
11054                     	xdef	_matemat
11055                     	xdef	_pwr_hndl
11056                     	xdef	_pwr_drv
11057                     	xdef	_vent_drv
11058                     	xdef	_link_drv
11059                     	xdef	_JP_drv
11060                     	xdef	_led_drv
11061                     	xdef	_led_hndl
11062                     	xdef	_delay_ms
11063                     	xdef	_granee
11064                     	xdef	_gran
11065                     .eeprom:	section	.data
11066  0000               _ee_IMAXVENT:
11067  0000 0000          	ds.b	2
11068                     	xdef	_ee_IMAXVENT
11069                     	switch	.ubsct
11070  0001               _bps_class:
11071  0001 00            	ds.b	1
11072                     	xdef	_bps_class
11073  0002               _vent_pwm:
11074  0002 0000          	ds.b	2
11075                     	xdef	_vent_pwm
11076  0004               _pwm_stat:
11077  0004 00            	ds.b	1
11078                     	xdef	_pwm_stat
11079  0005               _pwm_vent_cnt:
11080  0005 00            	ds.b	1
11081                     	xdef	_pwm_vent_cnt
11082                     	switch	.eeprom
11083  0002               _ee_DEVICE:
11084  0002 0000          	ds.b	2
11085                     	xdef	_ee_DEVICE
11086  0004               _ee_AVT_MODE:
11087  0004 0000          	ds.b	2
11088                     	xdef	_ee_AVT_MODE
11089                     	switch	.ubsct
11090  0006               _i_main_bps_cnt:
11091  0006 000000000000  	ds.b	6
11092                     	xdef	_i_main_bps_cnt
11093  000c               _i_main_sigma:
11094  000c 0000          	ds.b	2
11095                     	xdef	_i_main_sigma
11096  000e               _i_main_num_of_bps:
11097  000e 00            	ds.b	1
11098                     	xdef	_i_main_num_of_bps
11099  000f               _i_main_avg:
11100  000f 0000          	ds.b	2
11101                     	xdef	_i_main_avg
11102  0011               _i_main_flag:
11103  0011 000000000000  	ds.b	6
11104                     	xdef	_i_main_flag
11105  0017               _i_main:
11106  0017 000000000000  	ds.b	12
11107                     	xdef	_i_main
11108  0023               _x:
11109  0023 000000000000  	ds.b	12
11110                     	xdef	_x
11111                     	xdef	_volum_u_main_
11112                     	switch	.eeprom
11113  0006               _UU_AVT:
11114  0006 0000          	ds.b	2
11115                     	xdef	_UU_AVT
11116                     	switch	.ubsct
11117  002f               _cnt_net_drv:
11118  002f 00            	ds.b	1
11119                     	xdef	_cnt_net_drv
11120                     	switch	.bit
11121  0001               _bMAIN:
11122  0001 00            	ds.b	1
11123                     	xdef	_bMAIN
11124                     	switch	.ubsct
11125  0030               _plazma_int:
11126  0030 000000000000  	ds.b	6
11127                     	xdef	_plazma_int
11128                     	xdef	_rotor_int
11129  0036               _led_green_buff:
11130  0036 00000000      	ds.b	4
11131                     	xdef	_led_green_buff
11132  003a               _led_red_buff:
11133  003a 00000000      	ds.b	4
11134                     	xdef	_led_red_buff
11135                     	xdef	_led_drv_cnt
11136                     	xdef	_led_green
11137                     	xdef	_led_red
11138  003e               _res_fl_cnt:
11139  003e 00            	ds.b	1
11140                     	xdef	_res_fl_cnt
11141                     	xdef	_bRES_
11142                     	xdef	_bRES
11143                     	switch	.eeprom
11144  0008               _res_fl_:
11145  0008 00            	ds.b	1
11146                     	xdef	_res_fl_
11147  0009               _res_fl:
11148  0009 00            	ds.b	1
11149                     	xdef	_res_fl
11150                     	switch	.ubsct
11151  003f               _cnt_apv_off:
11152  003f 00            	ds.b	1
11153                     	xdef	_cnt_apv_off
11154                     	switch	.bit
11155  0002               _bAPV:
11156  0002 00            	ds.b	1
11157                     	xdef	_bAPV
11158                     	switch	.ubsct
11159  0040               _apv_cnt_:
11160  0040 0000          	ds.b	2
11161                     	xdef	_apv_cnt_
11162  0042               _apv_cnt:
11163  0042 000000        	ds.b	3
11164                     	xdef	_apv_cnt
11165                     	xdef	_bBL_IPS
11166                     	switch	.bit
11167  0003               _bBL:
11168  0003 00            	ds.b	1
11169                     	xdef	_bBL
11170                     	switch	.ubsct
11171  0045               _cnt_JP1:
11172  0045 00            	ds.b	1
11173                     	xdef	_cnt_JP1
11174  0046               _cnt_JP0:
11175  0046 00            	ds.b	1
11176                     	xdef	_cnt_JP0
11177  0047               _jp_mode:
11178  0047 00            	ds.b	1
11179                     	xdef	_jp_mode
11180                     	xdef	_pwm_i
11181                     	xdef	_pwm_u
11182  0048               _tmax_cnt:
11183  0048 0000          	ds.b	2
11184                     	xdef	_tmax_cnt
11185  004a               _tsign_cnt:
11186  004a 0000          	ds.b	2
11187                     	xdef	_tsign_cnt
11188                     	switch	.eeprom
11189  000a               _ee_U_AVT:
11190  000a 0000          	ds.b	2
11191                     	xdef	_ee_U_AVT
11192  000c               _ee_tsign:
11193  000c 0000          	ds.b	2
11194                     	xdef	_ee_tsign
11195  000e               _ee_tmax:
11196  000e 0000          	ds.b	2
11197                     	xdef	_ee_tmax
11198  0010               _ee_dU:
11199  0010 0000          	ds.b	2
11200                     	xdef	_ee_dU
11201  0012               _ee_Umax:
11202  0012 0000          	ds.b	2
11203                     	xdef	_ee_Umax
11204  0014               _ee_TZAS:
11205  0014 0000          	ds.b	2
11206                     	xdef	_ee_TZAS
11207                     	switch	.ubsct
11208  004c               _main_cnt1:
11209  004c 0000          	ds.b	2
11210                     	xdef	_main_cnt1
11211  004e               _main_cnt:
11212  004e 0000          	ds.b	2
11213                     	xdef	_main_cnt
11214  0050               _off_bp_cnt:
11215  0050 00            	ds.b	1
11216                     	xdef	_off_bp_cnt
11217  0051               _flags_tu_cnt_off:
11218  0051 00            	ds.b	1
11219                     	xdef	_flags_tu_cnt_off
11220  0052               _flags_tu_cnt_on:
11221  0052 00            	ds.b	1
11222                     	xdef	_flags_tu_cnt_on
11223  0053               _vol_i_temp:
11224  0053 0000          	ds.b	2
11225                     	xdef	_vol_i_temp
11226  0055               _vol_u_temp:
11227  0055 0000          	ds.b	2
11228                     	xdef	_vol_u_temp
11229                     	switch	.eeprom
11230  0016               __x_ee_:
11231  0016 0000          	ds.b	2
11232                     	xdef	__x_ee_
11233                     	switch	.ubsct
11234  0057               __x_cnt:
11235  0057 0000          	ds.b	2
11236                     	xdef	__x_cnt
11237  0059               __x__:
11238  0059 0000          	ds.b	2
11239                     	xdef	__x__
11240  005b               __x_:
11241  005b 0000          	ds.b	2
11242                     	xdef	__x_
11243  005d               _flags_tu:
11244  005d 00            	ds.b	1
11245                     	xdef	_flags_tu
11246                     	xdef	_flags
11247  005e               _link_cnt:
11248  005e 00            	ds.b	1
11249                     	xdef	_link_cnt
11250  005f               _link:
11251  005f 00            	ds.b	1
11252                     	xdef	_link
11253  0060               _umin_cnt:
11254  0060 0000          	ds.b	2
11255                     	xdef	_umin_cnt
11256  0062               _umax_cnt:
11257  0062 0000          	ds.b	2
11258                     	xdef	_umax_cnt
11259                     	switch	.eeprom
11260  0018               _ee_K:
11261  0018 000000000000  	ds.b	16
11262                     	xdef	_ee_K
11263                     	switch	.ubsct
11264  0064               _T:
11265  0064 00            	ds.b	1
11266                     	xdef	_T
11267  0065               _Udb:
11268  0065 0000          	ds.b	2
11269                     	xdef	_Udb
11270  0067               _Ui:
11271  0067 0000          	ds.b	2
11272                     	xdef	_Ui
11273  0069               _Un:
11274  0069 0000          	ds.b	2
11275                     	xdef	_Un
11276  006b               _I:
11277  006b 0000          	ds.b	2
11278                     	xdef	_I
11279  006d               _can_error_cnt:
11280  006d 00            	ds.b	1
11281                     	xdef	_can_error_cnt
11282                     	xdef	_bCAN_RX
11283  006e               _tx_busy_cnt:
11284  006e 00            	ds.b	1
11285                     	xdef	_tx_busy_cnt
11286                     	xdef	_bTX_FREE
11287  006f               _can_buff_rd_ptr:
11288  006f 00            	ds.b	1
11289                     	xdef	_can_buff_rd_ptr
11290  0070               _can_buff_wr_ptr:
11291  0070 00            	ds.b	1
11292                     	xdef	_can_buff_wr_ptr
11293  0071               _can_out_buff:
11294  0071 000000000000  	ds.b	64
11295                     	xdef	_can_out_buff
11296                     	switch	.bss
11297  0000               _adress_error:
11298  0000 00            	ds.b	1
11299                     	xdef	_adress_error
11300  0001               _adress:
11301  0001 00            	ds.b	1
11302                     	xdef	_adress
11303  0002               _adr:
11304  0002 000000        	ds.b	3
11305                     	xdef	_adr
11306                     	xdef	_adr_drv_stat
11307                     	xdef	_led_ind
11308                     	switch	.ubsct
11309  00b1               _led_ind_cnt:
11310  00b1 00            	ds.b	1
11311                     	xdef	_led_ind_cnt
11312  00b2               _adc_plazma:
11313  00b2 000000000000  	ds.b	10
11314                     	xdef	_adc_plazma
11315  00bc               _adc_plazma_short:
11316  00bc 0000          	ds.b	2
11317                     	xdef	_adc_plazma_short
11318  00be               _adc_cnt:
11319  00be 00            	ds.b	1
11320                     	xdef	_adc_cnt
11321  00bf               _adc_ch:
11322  00bf 00            	ds.b	1
11323                     	xdef	_adc_ch
11324                     	switch	.bss
11325  0005               _adc_buff_:
11326  0005 000000000000  	ds.b	20
11327                     	xdef	_adc_buff_
11328  0019               _adc_buff:
11329  0019 000000000000  	ds.b	320
11330                     	xdef	_adc_buff
11331                     	switch	.ubsct
11332  00c0               _mess:
11333  00c0 000000000000  	ds.b	14
11334                     	xdef	_mess
11335                     	switch	.bit
11336  0004               _b1Hz:
11337  0004 00            	ds.b	1
11338                     	xdef	_b1Hz
11339  0005               _b2Hz:
11340  0005 00            	ds.b	1
11341                     	xdef	_b2Hz
11342  0006               _b5Hz:
11343  0006 00            	ds.b	1
11344                     	xdef	_b5Hz
11345  0007               _b10Hz:
11346  0007 00            	ds.b	1
11347                     	xdef	_b10Hz
11348  0008               _b100Hz:
11349  0008 00            	ds.b	1
11350                     	xdef	_b100Hz
11351                     	xdef	_t0_cnt4
11352                     	xdef	_t0_cnt3
11353                     	xdef	_t0_cnt2
11354                     	xdef	_t0_cnt1
11355                     	xdef	_t0_cnt0
11356                     	xdef	_bVENT_BLOCK
11357                     	xref.b	c_lreg
11358                     	xref.b	c_x
11359                     	xref.b	c_y
11379                     	xref	c_lrsh
11380                     	xref	c_lgadd
11381                     	xref	c_ladd
11382                     	xref	c_umul
11383                     	xref	c_lgmul
11384                     	xref	c_lgsub
11385                     	xref	c_lsbc
11386                     	xref	c_idiv
11387                     	xref	c_ldiv
11388                     	xref	c_itolx
11389                     	xref	c_eewrc
11390                     	xref	c_imul
11391                     	xref	c_lcmp
11392                     	xref	c_ltor
11393                     	xref	c_lgadc
11394                     	xref	c_rtol
11395                     	xref	c_vmul
11396                     	xref	c_eewrw
11397                     	end
