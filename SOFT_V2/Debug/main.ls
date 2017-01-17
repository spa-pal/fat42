   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2172                     	bsct
2173  0000               _t0_cnt0:
2174  0000 0000          	dc.w	0
2175  0002               _t0_cnt1:
2176  0002 00            	dc.b	0
2177  0003               _t0_cnt2:
2178  0003 00            	dc.b	0
2179  0004               _t0_cnt3:
2180  0004 00            	dc.b	0
2181  0005               _t0_cnt4:
2182  0005 00            	dc.b	0
2183  0006               _led_ind:
2184  0006 05            	dc.b	5
2185  0007               _adr_drv_stat:
2186  0007 00            	dc.b	0
2187  0008               _bTX_FREE:
2188  0008 01            	dc.b	1
2189  0009               _bCAN_RX:
2190  0009 00            	dc.b	0
2191  000a               _flags:
2192  000a 00            	dc.b	0
2193  000b               _pwm_u:
2194  000b 00c8          	dc.w	200
2195  000d               _pwm_i:
2196  000d 0032          	dc.w	50
2197                     .bit:	section	.data,bit
2198  0000               _bBL_IPS:
2199  0000 00            	dc.b	0
2200                     	bsct
2201  000f               _bRES:
2202  000f 00            	dc.b	0
2203  0010               _bRES_:
2204  0010 00            	dc.b	0
2205  0011               _led_red:
2206  0011 00000000      	dc.l	0
2207  0015               _led_green:
2208  0015 03030303      	dc.l	50529027
2209  0019               _led_drv_cnt:
2210  0019 1e            	dc.b	30
2211  001a               _rotor_int:
2212  001a 007b          	dc.w	123
2213  001c               _volum_u_main_:
2214  001c 02bc          	dc.w	700
2273                     ; 166 void gran(signed short *adr, signed short min, signed short max)
2273                     ; 167 {
2275                     	switch	.text
2276  0000               _gran:
2278  0000 89            	pushw	x
2279       00000000      OFST:	set	0
2282                     ; 168 if (*adr<min) *adr=min;
2284  0001 9c            	rvf
2285  0002 9093          	ldw	y,x
2286  0004 51            	exgw	x,y
2287  0005 fe            	ldw	x,(x)
2288  0006 1305          	cpw	x,(OFST+5,sp)
2289  0008 51            	exgw	x,y
2290  0009 2e03          	jrsge	L7541
2293  000b 1605          	ldw	y,(OFST+5,sp)
2294  000d ff            	ldw	(x),y
2295  000e               L7541:
2296                     ; 169 if (*adr>max) *adr=max; 
2298  000e 9c            	rvf
2299  000f 1e01          	ldw	x,(OFST+1,sp)
2300  0011 9093          	ldw	y,x
2301  0013 51            	exgw	x,y
2302  0014 fe            	ldw	x,(x)
2303  0015 1307          	cpw	x,(OFST+7,sp)
2304  0017 51            	exgw	x,y
2305  0018 2d05          	jrsle	L1641
2308  001a 1e01          	ldw	x,(OFST+1,sp)
2309  001c 1607          	ldw	y,(OFST+7,sp)
2310  001e ff            	ldw	(x),y
2311  001f               L1641:
2312                     ; 170 } 
2315  001f 85            	popw	x
2316  0020 81            	ret
2369                     ; 173 void granee(@eeprom signed short *adr, signed short min, signed short max)
2369                     ; 174 {
2370                     	switch	.text
2371  0021               _granee:
2373  0021 89            	pushw	x
2374       00000000      OFST:	set	0
2377                     ; 175 if (*adr<min) *adr=min;
2379  0022 9c            	rvf
2380  0023 9093          	ldw	y,x
2381  0025 51            	exgw	x,y
2382  0026 fe            	ldw	x,(x)
2383  0027 1305          	cpw	x,(OFST+5,sp)
2384  0029 51            	exgw	x,y
2385  002a 2e09          	jrsge	L1151
2388  002c 1e05          	ldw	x,(OFST+5,sp)
2389  002e 89            	pushw	x
2390  002f 1e03          	ldw	x,(OFST+3,sp)
2391  0031 cd0000        	call	c_eewrw
2393  0034 85            	popw	x
2394  0035               L1151:
2395                     ; 176 if (*adr>max) *adr=max; 
2397  0035 9c            	rvf
2398  0036 1e01          	ldw	x,(OFST+1,sp)
2399  0038 9093          	ldw	y,x
2400  003a 51            	exgw	x,y
2401  003b fe            	ldw	x,(x)
2402  003c 1307          	cpw	x,(OFST+7,sp)
2403  003e 51            	exgw	x,y
2404  003f 2d09          	jrsle	L3151
2407  0041 1e07          	ldw	x,(OFST+7,sp)
2408  0043 89            	pushw	x
2409  0044 1e03          	ldw	x,(OFST+3,sp)
2410  0046 cd0000        	call	c_eewrw
2412  0049 85            	popw	x
2413  004a               L3151:
2414                     ; 177 }
2417  004a 85            	popw	x
2418  004b 81            	ret
2479                     ; 180 long delay_ms(short in)
2479                     ; 181 {
2480                     	switch	.text
2481  004c               _delay_ms:
2483  004c 520c          	subw	sp,#12
2484       0000000c      OFST:	set	12
2487                     ; 184 i=((long)in)*100UL;
2489  004e 90ae0064      	ldw	y,#100
2490  0052 cd0000        	call	c_vmul
2492  0055 96            	ldw	x,sp
2493  0056 1c0005        	addw	x,#OFST-7
2494  0059 cd0000        	call	c_rtol
2496                     ; 186 for(ii=0;ii<i;ii++)
2498  005c ae0000        	ldw	x,#0
2499  005f 1f0b          	ldw	(OFST-1,sp),x
2500  0061 ae0000        	ldw	x,#0
2501  0064 1f09          	ldw	(OFST-3,sp),x
2503  0066 2012          	jra	L3551
2504  0068               L7451:
2505                     ; 188 		iii++;
2507  0068 96            	ldw	x,sp
2508  0069 1c0001        	addw	x,#OFST-11
2509  006c a601          	ld	a,#1
2510  006e cd0000        	call	c_lgadc
2512                     ; 186 for(ii=0;ii<i;ii++)
2514  0071 96            	ldw	x,sp
2515  0072 1c0009        	addw	x,#OFST-3
2516  0075 a601          	ld	a,#1
2517  0077 cd0000        	call	c_lgadc
2519  007a               L3551:
2522  007a 9c            	rvf
2523  007b 96            	ldw	x,sp
2524  007c 1c0009        	addw	x,#OFST-3
2525  007f cd0000        	call	c_ltor
2527  0082 96            	ldw	x,sp
2528  0083 1c0005        	addw	x,#OFST-7
2529  0086 cd0000        	call	c_lcmp
2531  0089 2fdd          	jrslt	L7451
2532                     ; 191 }
2535  008b 5b0c          	addw	sp,#12
2536  008d 81            	ret
2572                     ; 194 void led_hndl(void)
2572                     ; 195 {
2573                     	switch	.text
2574  008e               _led_hndl:
2578                     ; 196 if(adress_error)
2580  008e 725d0000      	tnz	_adress_error
2581  0092 2718          	jreq	L7651
2582                     ; 198 	led_red=0x55555555L;
2584  0094 ae5555        	ldw	x,#21845
2585  0097 bf13          	ldw	_led_red+2,x
2586  0099 ae5555        	ldw	x,#21845
2587  009c bf11          	ldw	_led_red,x
2588                     ; 199 	led_green=0x55555555L;
2590  009e ae5555        	ldw	x,#21845
2591  00a1 bf17          	ldw	_led_green+2,x
2592  00a3 ae5555        	ldw	x,#21845
2593  00a6 bf15          	ldw	_led_green,x
2595  00a8 ac100710      	jpf	L1751
2596  00ac               L7651:
2597                     ; 215 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2599  00ac 3d05          	tnz	_bps_class
2600  00ae 2703          	jreq	L41
2601  00b0 cc0363        	jp	L3751
2602  00b3               L41:
2603                     ; 217 	if(jp_mode!=jp3)
2605  00b3 b64b          	ld	a,_jp_mode
2606  00b5 a103          	cp	a,#3
2607  00b7 2603          	jrne	L61
2608  00b9 cc025f        	jp	L5751
2609  00bc               L61:
2610                     ; 219 		if(main_cnt1<(5*ee_TZAS))
2612  00bc 9c            	rvf
2613  00bd ce0014        	ldw	x,_ee_TZAS
2614  00c0 90ae0005      	ldw	y,#5
2615  00c4 cd0000        	call	c_imul
2617  00c7 b350          	cpw	x,_main_cnt1
2618  00c9 2d18          	jrsle	L7751
2619                     ; 221 			led_red=0x00000000L;
2621  00cb ae0000        	ldw	x,#0
2622  00ce bf13          	ldw	_led_red+2,x
2623  00d0 ae0000        	ldw	x,#0
2624  00d3 bf11          	ldw	_led_red,x
2625                     ; 222 			led_green=0x03030303L;
2627  00d5 ae0303        	ldw	x,#771
2628  00d8 bf17          	ldw	_led_green+2,x
2629  00da ae0303        	ldw	x,#771
2630  00dd bf15          	ldw	_led_green,x
2632  00df ac200220      	jpf	L1061
2633  00e3               L7751:
2634                     ; 225 		else if((link==ON)&&(flags_tu&0b10000000))
2636  00e3 b663          	ld	a,_link
2637  00e5 a155          	cp	a,#85
2638  00e7 261e          	jrne	L3061
2640  00e9 b661          	ld	a,_flags_tu
2641  00eb a580          	bcp	a,#128
2642  00ed 2718          	jreq	L3061
2643                     ; 227 			led_red=0x00055555L;
2645  00ef ae5555        	ldw	x,#21845
2646  00f2 bf13          	ldw	_led_red+2,x
2647  00f4 ae0005        	ldw	x,#5
2648  00f7 bf11          	ldw	_led_red,x
2649                     ; 228 			led_green=0xffffffffL;
2651  00f9 aeffff        	ldw	x,#65535
2652  00fc bf17          	ldw	_led_green+2,x
2653  00fe aeffff        	ldw	x,#-1
2654  0101 bf15          	ldw	_led_green,x
2656  0103 ac200220      	jpf	L1061
2657  0107               L3061:
2658                     ; 231 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2660  0107 9c            	rvf
2661  0108 ce0014        	ldw	x,_ee_TZAS
2662  010b 90ae0005      	ldw	y,#5
2663  010f cd0000        	call	c_imul
2665  0112 b350          	cpw	x,_main_cnt1
2666  0114 2e37          	jrsge	L7061
2668  0116 9c            	rvf
2669  0117 ce0014        	ldw	x,_ee_TZAS
2670  011a 90ae0005      	ldw	y,#5
2671  011e cd0000        	call	c_imul
2673  0121 1c0064        	addw	x,#100
2674  0124 b350          	cpw	x,_main_cnt1
2675  0126 2d25          	jrsle	L7061
2677  0128 ce0004        	ldw	x,_ee_AVT_MODE
2678  012b a30055        	cpw	x,#85
2679  012e 271d          	jreq	L7061
2681  0130 ce0002        	ldw	x,_ee_DEVICE
2682  0133 2618          	jrne	L7061
2683                     ; 233 			led_red=0x00000000L;
2685  0135 ae0000        	ldw	x,#0
2686  0138 bf13          	ldw	_led_red+2,x
2687  013a ae0000        	ldw	x,#0
2688  013d bf11          	ldw	_led_red,x
2689                     ; 234 			led_green=0xffffffffL;	
2691  013f aeffff        	ldw	x,#65535
2692  0142 bf17          	ldw	_led_green+2,x
2693  0144 aeffff        	ldw	x,#-1
2694  0147 bf15          	ldw	_led_green,x
2696  0149 ac200220      	jpf	L1061
2697  014d               L7061:
2698                     ; 237 		else  if(link==OFF)
2700  014d b663          	ld	a,_link
2701  014f a1aa          	cp	a,#170
2702  0151 2618          	jrne	L3161
2703                     ; 239 			led_red=0x55555555L;
2705  0153 ae5555        	ldw	x,#21845
2706  0156 bf13          	ldw	_led_red+2,x
2707  0158 ae5555        	ldw	x,#21845
2708  015b bf11          	ldw	_led_red,x
2709                     ; 240 			led_green=0xffffffffL;
2711  015d aeffff        	ldw	x,#65535
2712  0160 bf17          	ldw	_led_green+2,x
2713  0162 aeffff        	ldw	x,#-1
2714  0165 bf15          	ldw	_led_green,x
2716  0167 ac200220      	jpf	L1061
2717  016b               L3161:
2718                     ; 243 		else if((link==ON)&&((flags&0b00111110)==0))
2720  016b b663          	ld	a,_link
2721  016d a155          	cp	a,#85
2722  016f 261d          	jrne	L7161
2724  0171 b60a          	ld	a,_flags
2725  0173 a53e          	bcp	a,#62
2726  0175 2617          	jrne	L7161
2727                     ; 245 			led_red=0x00000000L;
2729  0177 ae0000        	ldw	x,#0
2730  017a bf13          	ldw	_led_red+2,x
2731  017c ae0000        	ldw	x,#0
2732  017f bf11          	ldw	_led_red,x
2733                     ; 246 			led_green=0xffffffffL;
2735  0181 aeffff        	ldw	x,#65535
2736  0184 bf17          	ldw	_led_green+2,x
2737  0186 aeffff        	ldw	x,#-1
2738  0189 bf15          	ldw	_led_green,x
2740  018b cc0220        	jra	L1061
2741  018e               L7161:
2742                     ; 249 		else if((flags&0b00111110)==0b00000100)
2744  018e b60a          	ld	a,_flags
2745  0190 a43e          	and	a,#62
2746  0192 a104          	cp	a,#4
2747  0194 2616          	jrne	L3261
2748                     ; 251 			led_red=0x00010001L;
2750  0196 ae0001        	ldw	x,#1
2751  0199 bf13          	ldw	_led_red+2,x
2752  019b ae0001        	ldw	x,#1
2753  019e bf11          	ldw	_led_red,x
2754                     ; 252 			led_green=0xffffffffL;	
2756  01a0 aeffff        	ldw	x,#65535
2757  01a3 bf17          	ldw	_led_green+2,x
2758  01a5 aeffff        	ldw	x,#-1
2759  01a8 bf15          	ldw	_led_green,x
2761  01aa 2074          	jra	L1061
2762  01ac               L3261:
2763                     ; 254 		else if(flags&0b00000010)
2765  01ac b60a          	ld	a,_flags
2766  01ae a502          	bcp	a,#2
2767  01b0 2716          	jreq	L7261
2768                     ; 256 			led_red=0x00010001L;
2770  01b2 ae0001        	ldw	x,#1
2771  01b5 bf13          	ldw	_led_red+2,x
2772  01b7 ae0001        	ldw	x,#1
2773  01ba bf11          	ldw	_led_red,x
2774                     ; 257 			led_green=0x00000000L;	
2776  01bc ae0000        	ldw	x,#0
2777  01bf bf17          	ldw	_led_green+2,x
2778  01c1 ae0000        	ldw	x,#0
2779  01c4 bf15          	ldw	_led_green,x
2781  01c6 2058          	jra	L1061
2782  01c8               L7261:
2783                     ; 259 		else if(flags&0b00001000)
2785  01c8 b60a          	ld	a,_flags
2786  01ca a508          	bcp	a,#8
2787  01cc 2716          	jreq	L3361
2788                     ; 261 			led_red=0x00090009L;
2790  01ce ae0009        	ldw	x,#9
2791  01d1 bf13          	ldw	_led_red+2,x
2792  01d3 ae0009        	ldw	x,#9
2793  01d6 bf11          	ldw	_led_red,x
2794                     ; 262 			led_green=0x00000000L;	
2796  01d8 ae0000        	ldw	x,#0
2797  01db bf17          	ldw	_led_green+2,x
2798  01dd ae0000        	ldw	x,#0
2799  01e0 bf15          	ldw	_led_green,x
2801  01e2 203c          	jra	L1061
2802  01e4               L3361:
2803                     ; 264 		else if(flags&0b00010000)
2805  01e4 b60a          	ld	a,_flags
2806  01e6 a510          	bcp	a,#16
2807  01e8 2716          	jreq	L7361
2808                     ; 266 			led_red=0x00490049L;
2810  01ea ae0049        	ldw	x,#73
2811  01ed bf13          	ldw	_led_red+2,x
2812  01ef ae0049        	ldw	x,#73
2813  01f2 bf11          	ldw	_led_red,x
2814                     ; 267 			led_green=0x00000000L;	
2816  01f4 ae0000        	ldw	x,#0
2817  01f7 bf17          	ldw	_led_green+2,x
2818  01f9 ae0000        	ldw	x,#0
2819  01fc bf15          	ldw	_led_green,x
2821  01fe 2020          	jra	L1061
2822  0200               L7361:
2823                     ; 270 		else if((link==ON)&&(flags&0b00100000))
2825  0200 b663          	ld	a,_link
2826  0202 a155          	cp	a,#85
2827  0204 261a          	jrne	L1061
2829  0206 b60a          	ld	a,_flags
2830  0208 a520          	bcp	a,#32
2831  020a 2714          	jreq	L1061
2832                     ; 272 			led_red=0x00000000L;
2834  020c ae0000        	ldw	x,#0
2835  020f bf13          	ldw	_led_red+2,x
2836  0211 ae0000        	ldw	x,#0
2837  0214 bf11          	ldw	_led_red,x
2838                     ; 273 			led_green=0x00030003L;
2840  0216 ae0003        	ldw	x,#3
2841  0219 bf17          	ldw	_led_green+2,x
2842  021b ae0003        	ldw	x,#3
2843  021e bf15          	ldw	_led_green,x
2844  0220               L1061:
2845                     ; 276 		if((jp_mode==jp1))
2847  0220 b64b          	ld	a,_jp_mode
2848  0222 a101          	cp	a,#1
2849  0224 2618          	jrne	L5461
2850                     ; 278 			led_red=0x00000000L;
2852  0226 ae0000        	ldw	x,#0
2853  0229 bf13          	ldw	_led_red+2,x
2854  022b ae0000        	ldw	x,#0
2855  022e bf11          	ldw	_led_red,x
2856                     ; 279 			led_green=0x33333333L;
2858  0230 ae3333        	ldw	x,#13107
2859  0233 bf17          	ldw	_led_green+2,x
2860  0235 ae3333        	ldw	x,#13107
2861  0238 bf15          	ldw	_led_green,x
2863  023a ac100710      	jpf	L1751
2864  023e               L5461:
2865                     ; 281 		else if((jp_mode==jp2))
2867  023e b64b          	ld	a,_jp_mode
2868  0240 a102          	cp	a,#2
2869  0242 2703          	jreq	L02
2870  0244 cc0710        	jp	L1751
2871  0247               L02:
2872                     ; 283 			led_red=0xccccccccL;
2874  0247 aecccc        	ldw	x,#52428
2875  024a bf13          	ldw	_led_red+2,x
2876  024c aecccc        	ldw	x,#-13108
2877  024f bf11          	ldw	_led_red,x
2878                     ; 284 			led_green=0x00000000L;
2880  0251 ae0000        	ldw	x,#0
2881  0254 bf17          	ldw	_led_green+2,x
2882  0256 ae0000        	ldw	x,#0
2883  0259 bf15          	ldw	_led_green,x
2884  025b ac100710      	jpf	L1751
2885  025f               L5751:
2886                     ; 287 	else if(jp_mode==jp3)
2888  025f b64b          	ld	a,_jp_mode
2889  0261 a103          	cp	a,#3
2890  0263 2703          	jreq	L22
2891  0265 cc0710        	jp	L1751
2892  0268               L22:
2893                     ; 289 		if(main_cnt1<(5*ee_TZAS))
2895  0268 9c            	rvf
2896  0269 ce0014        	ldw	x,_ee_TZAS
2897  026c 90ae0005      	ldw	y,#5
2898  0270 cd0000        	call	c_imul
2900  0273 b350          	cpw	x,_main_cnt1
2901  0275 2d18          	jrsle	L7561
2902                     ; 291 			led_red=0x00000000L;
2904  0277 ae0000        	ldw	x,#0
2905  027a bf13          	ldw	_led_red+2,x
2906  027c ae0000        	ldw	x,#0
2907  027f bf11          	ldw	_led_red,x
2908                     ; 292 			led_green=0x03030303L;
2910  0281 ae0303        	ldw	x,#771
2911  0284 bf17          	ldw	_led_green+2,x
2912  0286 ae0303        	ldw	x,#771
2913  0289 bf15          	ldw	_led_green,x
2915  028b ac100710      	jpf	L1751
2916  028f               L7561:
2917                     ; 294 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
2919  028f 9c            	rvf
2920  0290 ce0014        	ldw	x,_ee_TZAS
2921  0293 90ae0005      	ldw	y,#5
2922  0297 cd0000        	call	c_imul
2924  029a b350          	cpw	x,_main_cnt1
2925  029c 2e2a          	jrsge	L3661
2927  029e 9c            	rvf
2928  029f ce0014        	ldw	x,_ee_TZAS
2929  02a2 90ae0005      	ldw	y,#5
2930  02a6 cd0000        	call	c_imul
2932  02a9 1c0046        	addw	x,#70
2933  02ac b350          	cpw	x,_main_cnt1
2934  02ae 2d18          	jrsle	L3661
2935                     ; 296 			led_red=0x00000000L;
2937  02b0 ae0000        	ldw	x,#0
2938  02b3 bf13          	ldw	_led_red+2,x
2939  02b5 ae0000        	ldw	x,#0
2940  02b8 bf11          	ldw	_led_red,x
2941                     ; 297 			led_green=0xffffffffL;	
2943  02ba aeffff        	ldw	x,#65535
2944  02bd bf17          	ldw	_led_green+2,x
2945  02bf aeffff        	ldw	x,#-1
2946  02c2 bf15          	ldw	_led_green,x
2948  02c4 ac100710      	jpf	L1751
2949  02c8               L3661:
2950                     ; 300 		else if((flags&0b00011110)==0)
2952  02c8 b60a          	ld	a,_flags
2953  02ca a51e          	bcp	a,#30
2954  02cc 2618          	jrne	L7661
2955                     ; 302 			led_red=0x00000000L;
2957  02ce ae0000        	ldw	x,#0
2958  02d1 bf13          	ldw	_led_red+2,x
2959  02d3 ae0000        	ldw	x,#0
2960  02d6 bf11          	ldw	_led_red,x
2961                     ; 303 			led_green=0xffffffffL;
2963  02d8 aeffff        	ldw	x,#65535
2964  02db bf17          	ldw	_led_green+2,x
2965  02dd aeffff        	ldw	x,#-1
2966  02e0 bf15          	ldw	_led_green,x
2968  02e2 ac100710      	jpf	L1751
2969  02e6               L7661:
2970                     ; 307 		else if((flags&0b00111110)==0b00000100)
2972  02e6 b60a          	ld	a,_flags
2973  02e8 a43e          	and	a,#62
2974  02ea a104          	cp	a,#4
2975  02ec 2618          	jrne	L3761
2976                     ; 309 			led_red=0x00010001L;
2978  02ee ae0001        	ldw	x,#1
2979  02f1 bf13          	ldw	_led_red+2,x
2980  02f3 ae0001        	ldw	x,#1
2981  02f6 bf11          	ldw	_led_red,x
2982                     ; 310 			led_green=0xffffffffL;	
2984  02f8 aeffff        	ldw	x,#65535
2985  02fb bf17          	ldw	_led_green+2,x
2986  02fd aeffff        	ldw	x,#-1
2987  0300 bf15          	ldw	_led_green,x
2989  0302 ac100710      	jpf	L1751
2990  0306               L3761:
2991                     ; 312 		else if(flags&0b00000010)
2993  0306 b60a          	ld	a,_flags
2994  0308 a502          	bcp	a,#2
2995  030a 2718          	jreq	L7761
2996                     ; 314 			led_red=0x00010001L;
2998  030c ae0001        	ldw	x,#1
2999  030f bf13          	ldw	_led_red+2,x
3000  0311 ae0001        	ldw	x,#1
3001  0314 bf11          	ldw	_led_red,x
3002                     ; 315 			led_green=0x00000000L;	
3004  0316 ae0000        	ldw	x,#0
3005  0319 bf17          	ldw	_led_green+2,x
3006  031b ae0000        	ldw	x,#0
3007  031e bf15          	ldw	_led_green,x
3009  0320 ac100710      	jpf	L1751
3010  0324               L7761:
3011                     ; 317 		else if(flags&0b00001000)
3013  0324 b60a          	ld	a,_flags
3014  0326 a508          	bcp	a,#8
3015  0328 2718          	jreq	L3071
3016                     ; 319 			led_red=0x00090009L;
3018  032a ae0009        	ldw	x,#9
3019  032d bf13          	ldw	_led_red+2,x
3020  032f ae0009        	ldw	x,#9
3021  0332 bf11          	ldw	_led_red,x
3022                     ; 320 			led_green=0x00000000L;	
3024  0334 ae0000        	ldw	x,#0
3025  0337 bf17          	ldw	_led_green+2,x
3026  0339 ae0000        	ldw	x,#0
3027  033c bf15          	ldw	_led_green,x
3029  033e ac100710      	jpf	L1751
3030  0342               L3071:
3031                     ; 322 		else if(flags&0b00010000)
3033  0342 b60a          	ld	a,_flags
3034  0344 a510          	bcp	a,#16
3035  0346 2603          	jrne	L42
3036  0348 cc0710        	jp	L1751
3037  034b               L42:
3038                     ; 324 			led_red=0x00490049L;
3040  034b ae0049        	ldw	x,#73
3041  034e bf13          	ldw	_led_red+2,x
3042  0350 ae0049        	ldw	x,#73
3043  0353 bf11          	ldw	_led_red,x
3044                     ; 325 			led_green=0xffffffffL;	
3046  0355 aeffff        	ldw	x,#65535
3047  0358 bf17          	ldw	_led_green+2,x
3048  035a aeffff        	ldw	x,#-1
3049  035d bf15          	ldw	_led_green,x
3050  035f ac100710      	jpf	L1751
3051  0363               L3751:
3052                     ; 329 else if(bps_class==bpsIPS)	//если блок ИПСный
3054  0363 b605          	ld	a,_bps_class
3055  0365 a101          	cp	a,#1
3056  0367 2703          	jreq	L62
3057  0369 cc0710        	jp	L1751
3058  036c               L62:
3059                     ; 331 	if(jp_mode!=jp3)
3061  036c b64b          	ld	a,_jp_mode
3062  036e a103          	cp	a,#3
3063  0370 2603          	jrne	L03
3064  0372 cc061c        	jp	L5171
3065  0375               L03:
3066                     ; 333 		if(main_cnt1<(5*ee_TZAS))
3068  0375 9c            	rvf
3069  0376 ce0014        	ldw	x,_ee_TZAS
3070  0379 90ae0005      	ldw	y,#5
3071  037d cd0000        	call	c_imul
3073  0380 b350          	cpw	x,_main_cnt1
3074  0382 2d18          	jrsle	L7171
3075                     ; 335 			led_red=0x00000000L;
3077  0384 ae0000        	ldw	x,#0
3078  0387 bf13          	ldw	_led_red+2,x
3079  0389 ae0000        	ldw	x,#0
3080  038c bf11          	ldw	_led_red,x
3081                     ; 336 			led_green=0x03030303L;
3083  038e ae0303        	ldw	x,#771
3084  0391 bf17          	ldw	_led_green+2,x
3085  0393 ae0303        	ldw	x,#771
3086  0396 bf15          	ldw	_led_green,x
3088  0398 acdd05dd      	jpf	L1271
3089  039c               L7171:
3090                     ; 339 		else if((link==ON)&&(flags_tu&0b10000000))
3092  039c b663          	ld	a,_link
3093  039e a155          	cp	a,#85
3094  03a0 261e          	jrne	L3271
3096  03a2 b661          	ld	a,_flags_tu
3097  03a4 a580          	bcp	a,#128
3098  03a6 2718          	jreq	L3271
3099                     ; 341 			led_red=0x00055555L;
3101  03a8 ae5555        	ldw	x,#21845
3102  03ab bf13          	ldw	_led_red+2,x
3103  03ad ae0005        	ldw	x,#5
3104  03b0 bf11          	ldw	_led_red,x
3105                     ; 342 			led_green=0xffffffffL;
3107  03b2 aeffff        	ldw	x,#65535
3108  03b5 bf17          	ldw	_led_green+2,x
3109  03b7 aeffff        	ldw	x,#-1
3110  03ba bf15          	ldw	_led_green,x
3112  03bc acdd05dd      	jpf	L1271
3113  03c0               L3271:
3114                     ; 345 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3116  03c0 9c            	rvf
3117  03c1 ce0014        	ldw	x,_ee_TZAS
3118  03c4 90ae0005      	ldw	y,#5
3119  03c8 cd0000        	call	c_imul
3121  03cb b350          	cpw	x,_main_cnt1
3122  03cd 2e37          	jrsge	L7271
3124  03cf 9c            	rvf
3125  03d0 ce0014        	ldw	x,_ee_TZAS
3126  03d3 90ae0005      	ldw	y,#5
3127  03d7 cd0000        	call	c_imul
3129  03da 1c0064        	addw	x,#100
3130  03dd b350          	cpw	x,_main_cnt1
3131  03df 2d25          	jrsle	L7271
3133  03e1 ce0004        	ldw	x,_ee_AVT_MODE
3134  03e4 a30055        	cpw	x,#85
3135  03e7 271d          	jreq	L7271
3137  03e9 ce0002        	ldw	x,_ee_DEVICE
3138  03ec 2618          	jrne	L7271
3139                     ; 347 			led_red=0x00000000L;
3141  03ee ae0000        	ldw	x,#0
3142  03f1 bf13          	ldw	_led_red+2,x
3143  03f3 ae0000        	ldw	x,#0
3144  03f6 bf11          	ldw	_led_red,x
3145                     ; 348 			led_green=0xffffffffL;	
3147  03f8 aeffff        	ldw	x,#65535
3148  03fb bf17          	ldw	_led_green+2,x
3149  03fd aeffff        	ldw	x,#-1
3150  0400 bf15          	ldw	_led_green,x
3152  0402 acdd05dd      	jpf	L1271
3153  0406               L7271:
3154                     ; 351 		else  if(link==OFF)
3156  0406 b663          	ld	a,_link
3157  0408 a1aa          	cp	a,#170
3158  040a 2703          	jreq	L23
3159  040c cc0528        	jp	L3371
3160  040f               L23:
3161                     ; 353 			if((flags&0b00011110)==0)
3163  040f b60a          	ld	a,_flags
3164  0411 a51e          	bcp	a,#30
3165  0413 262d          	jrne	L5371
3166                     ; 355 				led_red=0x00000000L;
3168  0415 ae0000        	ldw	x,#0
3169  0418 bf13          	ldw	_led_red+2,x
3170  041a ae0000        	ldw	x,#0
3171  041d bf11          	ldw	_led_red,x
3172                     ; 356 				if(bMAIN)led_green=0xfffffff5L;
3174                     	btst	_bMAIN
3175  0424 240e          	jruge	L7371
3178  0426 aefff5        	ldw	x,#65525
3179  0429 bf17          	ldw	_led_green+2,x
3180  042b aeffff        	ldw	x,#-1
3181  042e bf15          	ldw	_led_green,x
3183  0430 acdd05dd      	jpf	L1271
3184  0434               L7371:
3185                     ; 357 				else led_green=0xffffffffL;
3187  0434 aeffff        	ldw	x,#65535
3188  0437 bf17          	ldw	_led_green+2,x
3189  0439 aeffff        	ldw	x,#-1
3190  043c bf15          	ldw	_led_green,x
3191  043e acdd05dd      	jpf	L1271
3192  0442               L5371:
3193                     ; 360 			else if((flags&0b00111110)==0b00000100)
3195  0442 b60a          	ld	a,_flags
3196  0444 a43e          	and	a,#62
3197  0446 a104          	cp	a,#4
3198  0448 262d          	jrne	L5471
3199                     ; 362 				led_red=0x00010001L;
3201  044a ae0001        	ldw	x,#1
3202  044d bf13          	ldw	_led_red+2,x
3203  044f ae0001        	ldw	x,#1
3204  0452 bf11          	ldw	_led_red,x
3205                     ; 363 				if(bMAIN)led_green=0xfffffff5L;
3207                     	btst	_bMAIN
3208  0459 240e          	jruge	L7471
3211  045b aefff5        	ldw	x,#65525
3212  045e bf17          	ldw	_led_green+2,x
3213  0460 aeffff        	ldw	x,#-1
3214  0463 bf15          	ldw	_led_green,x
3216  0465 acdd05dd      	jpf	L1271
3217  0469               L7471:
3218                     ; 364 				else led_green=0xffffffffL;	
3220  0469 aeffff        	ldw	x,#65535
3221  046c bf17          	ldw	_led_green+2,x
3222  046e aeffff        	ldw	x,#-1
3223  0471 bf15          	ldw	_led_green,x
3224  0473 acdd05dd      	jpf	L1271
3225  0477               L5471:
3226                     ; 366 			else if(flags&0b00000010)
3228  0477 b60a          	ld	a,_flags
3229  0479 a502          	bcp	a,#2
3230  047b 272d          	jreq	L5571
3231                     ; 368 				led_red=0x00010001L;
3233  047d ae0001        	ldw	x,#1
3234  0480 bf13          	ldw	_led_red+2,x
3235  0482 ae0001        	ldw	x,#1
3236  0485 bf11          	ldw	_led_red,x
3237                     ; 369 				if(bMAIN)led_green=0x00000005L;
3239                     	btst	_bMAIN
3240  048c 240e          	jruge	L7571
3243  048e ae0005        	ldw	x,#5
3244  0491 bf17          	ldw	_led_green+2,x
3245  0493 ae0000        	ldw	x,#0
3246  0496 bf15          	ldw	_led_green,x
3248  0498 acdd05dd      	jpf	L1271
3249  049c               L7571:
3250                     ; 370 				else led_green=0x00000000L;
3252  049c ae0000        	ldw	x,#0
3253  049f bf17          	ldw	_led_green+2,x
3254  04a1 ae0000        	ldw	x,#0
3255  04a4 bf15          	ldw	_led_green,x
3256  04a6 acdd05dd      	jpf	L1271
3257  04aa               L5571:
3258                     ; 372 			else if(flags&0b00001000)
3260  04aa b60a          	ld	a,_flags
3261  04ac a508          	bcp	a,#8
3262  04ae 272d          	jreq	L5671
3263                     ; 374 				led_red=0x00090009L;
3265  04b0 ae0009        	ldw	x,#9
3266  04b3 bf13          	ldw	_led_red+2,x
3267  04b5 ae0009        	ldw	x,#9
3268  04b8 bf11          	ldw	_led_red,x
3269                     ; 375 				if(bMAIN)led_green=0x00000005L;
3271                     	btst	_bMAIN
3272  04bf 240e          	jruge	L7671
3275  04c1 ae0005        	ldw	x,#5
3276  04c4 bf17          	ldw	_led_green+2,x
3277  04c6 ae0000        	ldw	x,#0
3278  04c9 bf15          	ldw	_led_green,x
3280  04cb acdd05dd      	jpf	L1271
3281  04cf               L7671:
3282                     ; 376 				else led_green=0x00000000L;	
3284  04cf ae0000        	ldw	x,#0
3285  04d2 bf17          	ldw	_led_green+2,x
3286  04d4 ae0000        	ldw	x,#0
3287  04d7 bf15          	ldw	_led_green,x
3288  04d9 acdd05dd      	jpf	L1271
3289  04dd               L5671:
3290                     ; 378 			else if(flags&0b00010000)
3292  04dd b60a          	ld	a,_flags
3293  04df a510          	bcp	a,#16
3294  04e1 272d          	jreq	L5771
3295                     ; 380 				led_red=0x00490049L;
3297  04e3 ae0049        	ldw	x,#73
3298  04e6 bf13          	ldw	_led_red+2,x
3299  04e8 ae0049        	ldw	x,#73
3300  04eb bf11          	ldw	_led_red,x
3301                     ; 381 				if(bMAIN)led_green=0x00000005L;
3303                     	btst	_bMAIN
3304  04f2 240e          	jruge	L7771
3307  04f4 ae0005        	ldw	x,#5
3308  04f7 bf17          	ldw	_led_green+2,x
3309  04f9 ae0000        	ldw	x,#0
3310  04fc bf15          	ldw	_led_green,x
3312  04fe acdd05dd      	jpf	L1271
3313  0502               L7771:
3314                     ; 382 				else led_green=0x00000000L;	
3316  0502 ae0000        	ldw	x,#0
3317  0505 bf17          	ldw	_led_green+2,x
3318  0507 ae0000        	ldw	x,#0
3319  050a bf15          	ldw	_led_green,x
3320  050c acdd05dd      	jpf	L1271
3321  0510               L5771:
3322                     ; 386 				led_red=0x55555555L;
3324  0510 ae5555        	ldw	x,#21845
3325  0513 bf13          	ldw	_led_red+2,x
3326  0515 ae5555        	ldw	x,#21845
3327  0518 bf11          	ldw	_led_red,x
3328                     ; 387 				led_green=0xffffffffL;
3330  051a aeffff        	ldw	x,#65535
3331  051d bf17          	ldw	_led_green+2,x
3332  051f aeffff        	ldw	x,#-1
3333  0522 bf15          	ldw	_led_green,x
3334  0524 acdd05dd      	jpf	L1271
3335  0528               L3371:
3336                     ; 403 		else if((link==ON)&&((flags&0b00111110)==0))
3338  0528 b663          	ld	a,_link
3339  052a a155          	cp	a,#85
3340  052c 261d          	jrne	L7002
3342  052e b60a          	ld	a,_flags
3343  0530 a53e          	bcp	a,#62
3344  0532 2617          	jrne	L7002
3345                     ; 405 			led_red=0x00000000L;
3347  0534 ae0000        	ldw	x,#0
3348  0537 bf13          	ldw	_led_red+2,x
3349  0539 ae0000        	ldw	x,#0
3350  053c bf11          	ldw	_led_red,x
3351                     ; 406 			led_green=0xffffffffL;
3353  053e aeffff        	ldw	x,#65535
3354  0541 bf17          	ldw	_led_green+2,x
3355  0543 aeffff        	ldw	x,#-1
3356  0546 bf15          	ldw	_led_green,x
3358  0548 cc05dd        	jra	L1271
3359  054b               L7002:
3360                     ; 409 		else if((flags&0b00111110)==0b00000100)
3362  054b b60a          	ld	a,_flags
3363  054d a43e          	and	a,#62
3364  054f a104          	cp	a,#4
3365  0551 2616          	jrne	L3102
3366                     ; 411 			led_red=0x00010001L;
3368  0553 ae0001        	ldw	x,#1
3369  0556 bf13          	ldw	_led_red+2,x
3370  0558 ae0001        	ldw	x,#1
3371  055b bf11          	ldw	_led_red,x
3372                     ; 412 			led_green=0xffffffffL;	
3374  055d aeffff        	ldw	x,#65535
3375  0560 bf17          	ldw	_led_green+2,x
3376  0562 aeffff        	ldw	x,#-1
3377  0565 bf15          	ldw	_led_green,x
3379  0567 2074          	jra	L1271
3380  0569               L3102:
3381                     ; 414 		else if(flags&0b00000010)
3383  0569 b60a          	ld	a,_flags
3384  056b a502          	bcp	a,#2
3385  056d 2716          	jreq	L7102
3386                     ; 416 			led_red=0x00010001L;
3388  056f ae0001        	ldw	x,#1
3389  0572 bf13          	ldw	_led_red+2,x
3390  0574 ae0001        	ldw	x,#1
3391  0577 bf11          	ldw	_led_red,x
3392                     ; 417 			led_green=0x00000000L;	
3394  0579 ae0000        	ldw	x,#0
3395  057c bf17          	ldw	_led_green+2,x
3396  057e ae0000        	ldw	x,#0
3397  0581 bf15          	ldw	_led_green,x
3399  0583 2058          	jra	L1271
3400  0585               L7102:
3401                     ; 419 		else if(flags&0b00001000)
3403  0585 b60a          	ld	a,_flags
3404  0587 a508          	bcp	a,#8
3405  0589 2716          	jreq	L3202
3406                     ; 421 			led_red=0x00090009L;
3408  058b ae0009        	ldw	x,#9
3409  058e bf13          	ldw	_led_red+2,x
3410  0590 ae0009        	ldw	x,#9
3411  0593 bf11          	ldw	_led_red,x
3412                     ; 422 			led_green=0x00000000L;	
3414  0595 ae0000        	ldw	x,#0
3415  0598 bf17          	ldw	_led_green+2,x
3416  059a ae0000        	ldw	x,#0
3417  059d bf15          	ldw	_led_green,x
3419  059f 203c          	jra	L1271
3420  05a1               L3202:
3421                     ; 424 		else if(flags&0b00010000)
3423  05a1 b60a          	ld	a,_flags
3424  05a3 a510          	bcp	a,#16
3425  05a5 2716          	jreq	L7202
3426                     ; 426 			led_red=0x00490049L;
3428  05a7 ae0049        	ldw	x,#73
3429  05aa bf13          	ldw	_led_red+2,x
3430  05ac ae0049        	ldw	x,#73
3431  05af bf11          	ldw	_led_red,x
3432                     ; 427 			led_green=0x00000000L;	
3434  05b1 ae0000        	ldw	x,#0
3435  05b4 bf17          	ldw	_led_green+2,x
3436  05b6 ae0000        	ldw	x,#0
3437  05b9 bf15          	ldw	_led_green,x
3439  05bb 2020          	jra	L1271
3440  05bd               L7202:
3441                     ; 430 		else if((link==ON)&&(flags&0b00100000))
3443  05bd b663          	ld	a,_link
3444  05bf a155          	cp	a,#85
3445  05c1 261a          	jrne	L1271
3447  05c3 b60a          	ld	a,_flags
3448  05c5 a520          	bcp	a,#32
3449  05c7 2714          	jreq	L1271
3450                     ; 432 			led_red=0x00000000L;
3452  05c9 ae0000        	ldw	x,#0
3453  05cc bf13          	ldw	_led_red+2,x
3454  05ce ae0000        	ldw	x,#0
3455  05d1 bf11          	ldw	_led_red,x
3456                     ; 433 			led_green=0x00030003L;
3458  05d3 ae0003        	ldw	x,#3
3459  05d6 bf17          	ldw	_led_green+2,x
3460  05d8 ae0003        	ldw	x,#3
3461  05db bf15          	ldw	_led_green,x
3462  05dd               L1271:
3463                     ; 436 		if((jp_mode==jp1))
3465  05dd b64b          	ld	a,_jp_mode
3466  05df a101          	cp	a,#1
3467  05e1 2618          	jrne	L5302
3468                     ; 438 			led_red=0x00000000L;
3470  05e3 ae0000        	ldw	x,#0
3471  05e6 bf13          	ldw	_led_red+2,x
3472  05e8 ae0000        	ldw	x,#0
3473  05eb bf11          	ldw	_led_red,x
3474                     ; 439 			led_green=0x33333333L;
3476  05ed ae3333        	ldw	x,#13107
3477  05f0 bf17          	ldw	_led_green+2,x
3478  05f2 ae3333        	ldw	x,#13107
3479  05f5 bf15          	ldw	_led_green,x
3481  05f7 ac100710      	jpf	L1751
3482  05fb               L5302:
3483                     ; 441 		else if((jp_mode==jp2))
3485  05fb b64b          	ld	a,_jp_mode
3486  05fd a102          	cp	a,#2
3487  05ff 2703          	jreq	L43
3488  0601 cc0710        	jp	L1751
3489  0604               L43:
3490                     ; 445 			led_red=0xccccccccL;
3492  0604 aecccc        	ldw	x,#52428
3493  0607 bf13          	ldw	_led_red+2,x
3494  0609 aecccc        	ldw	x,#-13108
3495  060c bf11          	ldw	_led_red,x
3496                     ; 446 			led_green=0x00000000L;
3498  060e ae0000        	ldw	x,#0
3499  0611 bf17          	ldw	_led_green+2,x
3500  0613 ae0000        	ldw	x,#0
3501  0616 bf15          	ldw	_led_green,x
3502  0618 ac100710      	jpf	L1751
3503  061c               L5171:
3504                     ; 449 	else if(jp_mode==jp3)
3506  061c b64b          	ld	a,_jp_mode
3507  061e a103          	cp	a,#3
3508  0620 2703          	jreq	L63
3509  0622 cc0710        	jp	L1751
3510  0625               L63:
3511                     ; 451 		if(main_cnt1<(5*ee_TZAS))
3513  0625 9c            	rvf
3514  0626 ce0014        	ldw	x,_ee_TZAS
3515  0629 90ae0005      	ldw	y,#5
3516  062d cd0000        	call	c_imul
3518  0630 b350          	cpw	x,_main_cnt1
3519  0632 2d18          	jrsle	L7402
3520                     ; 453 			led_red=0x00000000L;
3522  0634 ae0000        	ldw	x,#0
3523  0637 bf13          	ldw	_led_red+2,x
3524  0639 ae0000        	ldw	x,#0
3525  063c bf11          	ldw	_led_red,x
3526                     ; 454 			led_green=0x03030303L;
3528  063e ae0303        	ldw	x,#771
3529  0641 bf17          	ldw	_led_green+2,x
3530  0643 ae0303        	ldw	x,#771
3531  0646 bf15          	ldw	_led_green,x
3533  0648 ac100710      	jpf	L1751
3534  064c               L7402:
3535                     ; 456 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3537  064c 9c            	rvf
3538  064d ce0014        	ldw	x,_ee_TZAS
3539  0650 90ae0005      	ldw	y,#5
3540  0654 cd0000        	call	c_imul
3542  0657 b350          	cpw	x,_main_cnt1
3543  0659 2e29          	jrsge	L3502
3545  065b 9c            	rvf
3546  065c ce0014        	ldw	x,_ee_TZAS
3547  065f 90ae0005      	ldw	y,#5
3548  0663 cd0000        	call	c_imul
3550  0666 1c0046        	addw	x,#70
3551  0669 b350          	cpw	x,_main_cnt1
3552  066b 2d17          	jrsle	L3502
3553                     ; 458 			led_red=0x00000000L;
3555  066d ae0000        	ldw	x,#0
3556  0670 bf13          	ldw	_led_red+2,x
3557  0672 ae0000        	ldw	x,#0
3558  0675 bf11          	ldw	_led_red,x
3559                     ; 459 			led_green=0xffffffffL;	
3561  0677 aeffff        	ldw	x,#65535
3562  067a bf17          	ldw	_led_green+2,x
3563  067c aeffff        	ldw	x,#-1
3564  067f bf15          	ldw	_led_green,x
3566  0681 cc0710        	jra	L1751
3567  0684               L3502:
3568                     ; 462 		else if((flags&0b00011110)==0)
3570  0684 b60a          	ld	a,_flags
3571  0686 a51e          	bcp	a,#30
3572  0688 2616          	jrne	L7502
3573                     ; 464 			led_red=0x00000000L;
3575  068a ae0000        	ldw	x,#0
3576  068d bf13          	ldw	_led_red+2,x
3577  068f ae0000        	ldw	x,#0
3578  0692 bf11          	ldw	_led_red,x
3579                     ; 465 			led_green=0xffffffffL;
3581  0694 aeffff        	ldw	x,#65535
3582  0697 bf17          	ldw	_led_green+2,x
3583  0699 aeffff        	ldw	x,#-1
3584  069c bf15          	ldw	_led_green,x
3586  069e 2070          	jra	L1751
3587  06a0               L7502:
3588                     ; 469 		else if((flags&0b00111110)==0b00000100)
3590  06a0 b60a          	ld	a,_flags
3591  06a2 a43e          	and	a,#62
3592  06a4 a104          	cp	a,#4
3593  06a6 2616          	jrne	L3602
3594                     ; 471 			led_red=0x00010001L;
3596  06a8 ae0001        	ldw	x,#1
3597  06ab bf13          	ldw	_led_red+2,x
3598  06ad ae0001        	ldw	x,#1
3599  06b0 bf11          	ldw	_led_red,x
3600                     ; 472 			led_green=0xffffffffL;	
3602  06b2 aeffff        	ldw	x,#65535
3603  06b5 bf17          	ldw	_led_green+2,x
3604  06b7 aeffff        	ldw	x,#-1
3605  06ba bf15          	ldw	_led_green,x
3607  06bc 2052          	jra	L1751
3608  06be               L3602:
3609                     ; 474 		else if(flags&0b00000010)
3611  06be b60a          	ld	a,_flags
3612  06c0 a502          	bcp	a,#2
3613  06c2 2716          	jreq	L7602
3614                     ; 476 			led_red=0x00010001L;
3616  06c4 ae0001        	ldw	x,#1
3617  06c7 bf13          	ldw	_led_red+2,x
3618  06c9 ae0001        	ldw	x,#1
3619  06cc bf11          	ldw	_led_red,x
3620                     ; 477 			led_green=0x00000000L;	
3622  06ce ae0000        	ldw	x,#0
3623  06d1 bf17          	ldw	_led_green+2,x
3624  06d3 ae0000        	ldw	x,#0
3625  06d6 bf15          	ldw	_led_green,x
3627  06d8 2036          	jra	L1751
3628  06da               L7602:
3629                     ; 479 		else if(flags&0b00001000)
3631  06da b60a          	ld	a,_flags
3632  06dc a508          	bcp	a,#8
3633  06de 2716          	jreq	L3702
3634                     ; 481 			led_red=0x00090009L;
3636  06e0 ae0009        	ldw	x,#9
3637  06e3 bf13          	ldw	_led_red+2,x
3638  06e5 ae0009        	ldw	x,#9
3639  06e8 bf11          	ldw	_led_red,x
3640                     ; 482 			led_green=0x00000000L;	
3642  06ea ae0000        	ldw	x,#0
3643  06ed bf17          	ldw	_led_green+2,x
3644  06ef ae0000        	ldw	x,#0
3645  06f2 bf15          	ldw	_led_green,x
3647  06f4 201a          	jra	L1751
3648  06f6               L3702:
3649                     ; 484 		else if(flags&0b00010000)
3651  06f6 b60a          	ld	a,_flags
3652  06f8 a510          	bcp	a,#16
3653  06fa 2714          	jreq	L1751
3654                     ; 486 			led_red=0x00490049L;
3656  06fc ae0049        	ldw	x,#73
3657  06ff bf13          	ldw	_led_red+2,x
3658  0701 ae0049        	ldw	x,#73
3659  0704 bf11          	ldw	_led_red,x
3660                     ; 487 			led_green=0xffffffffL;	
3662  0706 aeffff        	ldw	x,#65535
3663  0709 bf17          	ldw	_led_green+2,x
3664  070b aeffff        	ldw	x,#-1
3665  070e bf15          	ldw	_led_green,x
3666  0710               L1751:
3667                     ; 491 }
3670  0710 81            	ret
3698                     ; 494 void led_drv(void)
3698                     ; 495 {
3699                     	switch	.text
3700  0711               _led_drv:
3704                     ; 497 GPIOA->DDR|=(1<<6);
3706  0711 721c5002      	bset	20482,#6
3707                     ; 498 GPIOA->CR1|=(1<<6);
3709  0715 721c5003      	bset	20483,#6
3710                     ; 499 GPIOA->CR2&=~(1<<6);
3712  0719 721d5004      	bres	20484,#6
3713                     ; 500 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<6); 	//Горит если в led_red_buff 1 и на ножке 1
3715  071d b641          	ld	a,_led_red_buff+3
3716  071f a501          	bcp	a,#1
3717  0721 2706          	jreq	L1112
3720  0723 721c5000      	bset	20480,#6
3722  0727 2004          	jra	L3112
3723  0729               L1112:
3724                     ; 501 else GPIOA->ODR&=~(1<<6); 
3726  0729 721d5000      	bres	20480,#6
3727  072d               L3112:
3728                     ; 504 GPIOA->DDR|=(1<<5);
3730  072d 721a5002      	bset	20482,#5
3731                     ; 505 GPIOA->CR1|=(1<<5);
3733  0731 721a5003      	bset	20483,#5
3734                     ; 506 GPIOA->CR2&=~(1<<5);	
3736  0735 721b5004      	bres	20484,#5
3737                     ; 507 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3739  0739 b63d          	ld	a,_led_green_buff+3
3740  073b a501          	bcp	a,#1
3741  073d 2706          	jreq	L5112
3744  073f 721a5000      	bset	20480,#5
3746  0743 2004          	jra	L7112
3747  0745               L5112:
3748                     ; 508 else GPIOA->ODR&=~(1<<5);
3750  0745 721b5000      	bres	20480,#5
3751  0749               L7112:
3752                     ; 511 led_red_buff>>=1;
3754  0749 373e          	sra	_led_red_buff
3755  074b 363f          	rrc	_led_red_buff+1
3756  074d 3640          	rrc	_led_red_buff+2
3757  074f 3641          	rrc	_led_red_buff+3
3758                     ; 512 led_green_buff>>=1;
3760  0751 373a          	sra	_led_green_buff
3761  0753 363b          	rrc	_led_green_buff+1
3762  0755 363c          	rrc	_led_green_buff+2
3763  0757 363d          	rrc	_led_green_buff+3
3764                     ; 513 if(++led_drv_cnt>32)
3766  0759 3c19          	inc	_led_drv_cnt
3767  075b b619          	ld	a,_led_drv_cnt
3768  075d a121          	cp	a,#33
3769  075f 2512          	jrult	L1212
3770                     ; 515 	led_drv_cnt=0;
3772  0761 3f19          	clr	_led_drv_cnt
3773                     ; 516 	led_red_buff=led_red;
3775  0763 be13          	ldw	x,_led_red+2
3776  0765 bf40          	ldw	_led_red_buff+2,x
3777  0767 be11          	ldw	x,_led_red
3778  0769 bf3e          	ldw	_led_red_buff,x
3779                     ; 517 	led_green_buff=led_green;
3781  076b be17          	ldw	x,_led_green+2
3782  076d bf3c          	ldw	_led_green_buff+2,x
3783  076f be15          	ldw	x,_led_green
3784  0771 bf3a          	ldw	_led_green_buff,x
3785  0773               L1212:
3786                     ; 523 } 
3789  0773 81            	ret
3815                     ; 526 void JP_drv(void)
3815                     ; 527 {
3816                     	switch	.text
3817  0774               _JP_drv:
3821                     ; 529 GPIOD->DDR&=~(1<<6);
3823  0774 721d5011      	bres	20497,#6
3824                     ; 530 GPIOD->CR1|=(1<<6);
3826  0778 721c5012      	bset	20498,#6
3827                     ; 531 GPIOD->CR2&=~(1<<6);
3829  077c 721d5013      	bres	20499,#6
3830                     ; 533 GPIOD->DDR&=~(1<<7);
3832  0780 721f5011      	bres	20497,#7
3833                     ; 534 GPIOD->CR1|=(1<<7);
3835  0784 721e5012      	bset	20498,#7
3836                     ; 535 GPIOD->CR2&=~(1<<7);
3838  0788 721f5013      	bres	20499,#7
3839                     ; 537 if(GPIOD->IDR&(1<<6))
3841  078c c65010        	ld	a,20496
3842  078f a540          	bcp	a,#64
3843  0791 270a          	jreq	L3312
3844                     ; 539 	if(cnt_JP0<10)
3846  0793 b64a          	ld	a,_cnt_JP0
3847  0795 a10a          	cp	a,#10
3848  0797 2411          	jruge	L7312
3849                     ; 541 		cnt_JP0++;
3851  0799 3c4a          	inc	_cnt_JP0
3852  079b 200d          	jra	L7312
3853  079d               L3312:
3854                     ; 544 else if(!(GPIOD->IDR&(1<<6)))
3856  079d c65010        	ld	a,20496
3857  07a0 a540          	bcp	a,#64
3858  07a2 2606          	jrne	L7312
3859                     ; 546 	if(cnt_JP0)
3861  07a4 3d4a          	tnz	_cnt_JP0
3862  07a6 2702          	jreq	L7312
3863                     ; 548 		cnt_JP0--;
3865  07a8 3a4a          	dec	_cnt_JP0
3866  07aa               L7312:
3867                     ; 552 if(GPIOD->IDR&(1<<7))
3869  07aa c65010        	ld	a,20496
3870  07ad a580          	bcp	a,#128
3871  07af 270a          	jreq	L5412
3872                     ; 554 	if(cnt_JP1<10)
3874  07b1 b649          	ld	a,_cnt_JP1
3875  07b3 a10a          	cp	a,#10
3876  07b5 2411          	jruge	L1512
3877                     ; 556 		cnt_JP1++;
3879  07b7 3c49          	inc	_cnt_JP1
3880  07b9 200d          	jra	L1512
3881  07bb               L5412:
3882                     ; 559 else if(!(GPIOD->IDR&(1<<7)))
3884  07bb c65010        	ld	a,20496
3885  07be a580          	bcp	a,#128
3886  07c0 2606          	jrne	L1512
3887                     ; 561 	if(cnt_JP1)
3889  07c2 3d49          	tnz	_cnt_JP1
3890  07c4 2702          	jreq	L1512
3891                     ; 563 		cnt_JP1--;
3893  07c6 3a49          	dec	_cnt_JP1
3894  07c8               L1512:
3895                     ; 568 if((cnt_JP0==10)&&(cnt_JP1==10))
3897  07c8 b64a          	ld	a,_cnt_JP0
3898  07ca a10a          	cp	a,#10
3899  07cc 2608          	jrne	L7512
3901  07ce b649          	ld	a,_cnt_JP1
3902  07d0 a10a          	cp	a,#10
3903  07d2 2602          	jrne	L7512
3904                     ; 570 	jp_mode=jp0;
3906  07d4 3f4b          	clr	_jp_mode
3907  07d6               L7512:
3908                     ; 572 if((cnt_JP0==0)&&(cnt_JP1==10))
3910  07d6 3d4a          	tnz	_cnt_JP0
3911  07d8 260a          	jrne	L1612
3913  07da b649          	ld	a,_cnt_JP1
3914  07dc a10a          	cp	a,#10
3915  07de 2604          	jrne	L1612
3916                     ; 574 	jp_mode=jp1;
3918  07e0 3501004b      	mov	_jp_mode,#1
3919  07e4               L1612:
3920                     ; 576 if((cnt_JP0==10)&&(cnt_JP1==0))
3922  07e4 b64a          	ld	a,_cnt_JP0
3923  07e6 a10a          	cp	a,#10
3924  07e8 2608          	jrne	L3612
3926  07ea 3d49          	tnz	_cnt_JP1
3927  07ec 2604          	jrne	L3612
3928                     ; 578 	jp_mode=jp2;
3930  07ee 3502004b      	mov	_jp_mode,#2
3931  07f2               L3612:
3932                     ; 580 if((cnt_JP0==0)&&(cnt_JP1==0))
3934  07f2 3d4a          	tnz	_cnt_JP0
3935  07f4 2608          	jrne	L5612
3937  07f6 3d49          	tnz	_cnt_JP1
3938  07f8 2604          	jrne	L5612
3939                     ; 582 	jp_mode=jp3;
3941  07fa 3503004b      	mov	_jp_mode,#3
3942  07fe               L5612:
3943                     ; 585 }
3946  07fe 81            	ret
3978                     ; 588 void link_drv(void)		//10Hz
3978                     ; 589 {
3979                     	switch	.text
3980  07ff               _link_drv:
3984                     ; 590 if(jp_mode!=jp3)
3986  07ff b64b          	ld	a,_jp_mode
3987  0801 a103          	cp	a,#3
3988  0803 2744          	jreq	L7712
3989                     ; 592 	if(link_cnt<52)link_cnt++;
3991  0805 b662          	ld	a,_link_cnt
3992  0807 a134          	cp	a,#52
3993  0809 2402          	jruge	L1022
3996  080b 3c62          	inc	_link_cnt
3997  080d               L1022:
3998                     ; 593 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4000  080d b662          	ld	a,_link_cnt
4001  080f a131          	cp	a,#49
4002  0811 2606          	jrne	L3022
4005  0813 b60a          	ld	a,_flags
4006  0815 a4c1          	and	a,#193
4007  0817 b70a          	ld	_flags,a
4008  0819               L3022:
4009                     ; 594 	if(link_cnt==50)
4011  0819 b662          	ld	a,_link_cnt
4012  081b a132          	cp	a,#50
4013  081d 262e          	jrne	L5122
4014                     ; 596 		link=OFF;
4016  081f 35aa0063      	mov	_link,#170
4017                     ; 601 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4019  0823 b605          	ld	a,_bps_class
4020  0825 a101          	cp	a,#1
4021  0827 2606          	jrne	L7022
4024  0829 72100001      	bset	_bMAIN
4026  082d 2004          	jra	L1122
4027  082f               L7022:
4028                     ; 602 		else bMAIN=0;
4030  082f 72110001      	bres	_bMAIN
4031  0833               L1122:
4032                     ; 604 		cnt_net_drv=0;
4034  0833 3f33          	clr	_cnt_net_drv
4035                     ; 605     		if(!res_fl_)
4037  0835 725d0008      	tnz	_res_fl_
4038  0839 2612          	jrne	L5122
4039                     ; 607 	    		bRES_=1;
4041  083b 35010010      	mov	_bRES_,#1
4042                     ; 608 	    		res_fl_=1;
4044  083f a601          	ld	a,#1
4045  0841 ae0008        	ldw	x,#_res_fl_
4046  0844 cd0000        	call	c_eewrc
4048  0847 2004          	jra	L5122
4049  0849               L7712:
4050                     ; 612 else link=OFF;	
4052  0849 35aa0063      	mov	_link,#170
4053  084d               L5122:
4054                     ; 613 } 
4057  084d 81            	ret
4126                     .const:	section	.text
4127  0000               L05:
4128  0000 0000000b      	dc.l	11
4129  0004               L25:
4130  0004 00000001      	dc.l	1
4131                     ; 617 void vent_drv(void)
4131                     ; 618 {
4132                     	switch	.text
4133  084e               _vent_drv:
4135  084e 520e          	subw	sp,#14
4136       0000000e      OFST:	set	14
4139                     ; 621 	short vent_pwm_i_necc=400;
4141  0850 ae0190        	ldw	x,#400
4142  0853 1f07          	ldw	(OFST-7,sp),x
4143                     ; 622 	short vent_pwm_t_necc=400;
4145  0855 ae0190        	ldw	x,#400
4146  0858 1f09          	ldw	(OFST-5,sp),x
4147                     ; 623 	short vent_pwm_max_necc=400;
4149                     ; 628 	tempSL=36000L/(signed long)ee_Umax;
4151  085a ce0012        	ldw	x,_ee_Umax
4152  085d cd0000        	call	c_itolx
4154  0860 96            	ldw	x,sp
4155  0861 1c0001        	addw	x,#OFST-13
4156  0864 cd0000        	call	c_rtol
4158  0867 ae8ca0        	ldw	x,#36000
4159  086a bf02          	ldw	c_lreg+2,x
4160  086c ae0000        	ldw	x,#0
4161  086f bf00          	ldw	c_lreg,x
4162  0871 96            	ldw	x,sp
4163  0872 1c0001        	addw	x,#OFST-13
4164  0875 cd0000        	call	c_ldiv
4166  0878 96            	ldw	x,sp
4167  0879 1c000b        	addw	x,#OFST-3
4168  087c cd0000        	call	c_rtol
4170                     ; 629 	tempSL=(signed long)I/tempSL;
4172  087f be6f          	ldw	x,_I
4173  0881 cd0000        	call	c_itolx
4175  0884 96            	ldw	x,sp
4176  0885 1c000b        	addw	x,#OFST-3
4177  0888 cd0000        	call	c_ldiv
4179  088b 96            	ldw	x,sp
4180  088c 1c000b        	addw	x,#OFST-3
4181  088f cd0000        	call	c_rtol
4183                     ; 631 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4185  0892 ce0002        	ldw	x,_ee_DEVICE
4186  0895 a30001        	cpw	x,#1
4187  0898 2613          	jrne	L1522
4190  089a be6f          	ldw	x,_I
4191  089c 90ce0000      	ldw	y,_ee_IMAXVENT
4192  08a0 cd0000        	call	c_idiv
4194  08a3 cd0000        	call	c_itolx
4196  08a6 96            	ldw	x,sp
4197  08a7 1c000b        	addw	x,#OFST-3
4198  08aa cd0000        	call	c_rtol
4200  08ad               L1522:
4201                     ; 633 	if(tempSL>10)vent_pwm_i_necc=1000;
4203  08ad 9c            	rvf
4204  08ae 96            	ldw	x,sp
4205  08af 1c000b        	addw	x,#OFST-3
4206  08b2 cd0000        	call	c_ltor
4208  08b5 ae0000        	ldw	x,#L05
4209  08b8 cd0000        	call	c_lcmp
4211  08bb 2f07          	jrslt	L3522
4214  08bd ae03e8        	ldw	x,#1000
4215  08c0 1f07          	ldw	(OFST-7,sp),x
4217  08c2 2025          	jra	L5522
4218  08c4               L3522:
4219                     ; 634 	else if(tempSL<1)vent_pwm_i_necc=400;
4221  08c4 9c            	rvf
4222  08c5 96            	ldw	x,sp
4223  08c6 1c000b        	addw	x,#OFST-3
4224  08c9 cd0000        	call	c_ltor
4226  08cc ae0004        	ldw	x,#L25
4227  08cf cd0000        	call	c_lcmp
4229  08d2 2e07          	jrsge	L7522
4232  08d4 ae0190        	ldw	x,#400
4233  08d7 1f07          	ldw	(OFST-7,sp),x
4235  08d9 200e          	jra	L5522
4236  08db               L7522:
4237                     ; 635 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4239  08db 1e0d          	ldw	x,(OFST-1,sp)
4240  08dd 90ae003c      	ldw	y,#60
4241  08e1 cd0000        	call	c_imul
4243  08e4 1c0190        	addw	x,#400
4244  08e7 1f07          	ldw	(OFST-7,sp),x
4245  08e9               L5522:
4246                     ; 636 	gran(&vent_pwm_i_necc,400,1000);
4248  08e9 ae03e8        	ldw	x,#1000
4249  08ec 89            	pushw	x
4250  08ed ae0190        	ldw	x,#400
4251  08f0 89            	pushw	x
4252  08f1 96            	ldw	x,sp
4253  08f2 1c000b        	addw	x,#OFST-3
4254  08f5 cd0000        	call	_gran
4256  08f8 5b04          	addw	sp,#4
4257                     ; 638 	tempSL=(signed long)T;
4259  08fa b668          	ld	a,_T
4260  08fc b703          	ld	c_lreg+3,a
4261  08fe 48            	sll	a
4262  08ff 4f            	clr	a
4263  0900 a200          	sbc	a,#0
4264  0902 b702          	ld	c_lreg+2,a
4265  0904 b701          	ld	c_lreg+1,a
4266  0906 b700          	ld	c_lreg,a
4267  0908 96            	ldw	x,sp
4268  0909 1c000b        	addw	x,#OFST-3
4269  090c cd0000        	call	c_rtol
4271                     ; 639 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4273  090f 9c            	rvf
4274  0910 ce000c        	ldw	x,_ee_tsign
4275  0913 cd0000        	call	c_itolx
4277  0916 a61e          	ld	a,#30
4278  0918 cd0000        	call	c_lsbc
4280  091b 96            	ldw	x,sp
4281  091c 1c000b        	addw	x,#OFST-3
4282  091f cd0000        	call	c_lcmp
4284  0922 2f07          	jrslt	L3622
4287  0924 ae0190        	ldw	x,#400
4288  0927 1f09          	ldw	(OFST-5,sp),x
4290  0929 2030          	jra	L5622
4291  092b               L3622:
4292                     ; 640 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4294  092b 9c            	rvf
4295  092c ce000c        	ldw	x,_ee_tsign
4296  092f cd0000        	call	c_itolx
4298  0932 96            	ldw	x,sp
4299  0933 1c000b        	addw	x,#OFST-3
4300  0936 cd0000        	call	c_lcmp
4302  0939 2c07          	jrsgt	L7622
4305  093b ae03e8        	ldw	x,#1000
4306  093e 1f09          	ldw	(OFST-5,sp),x
4308  0940 2019          	jra	L5622
4309  0942               L7622:
4310                     ; 641 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4312  0942 ce000c        	ldw	x,_ee_tsign
4313  0945 1d001e        	subw	x,#30
4314  0948 1f03          	ldw	(OFST-11,sp),x
4315  094a 1e0d          	ldw	x,(OFST-1,sp)
4316  094c 72f003        	subw	x,(OFST-11,sp)
4317  094f 90ae0014      	ldw	y,#20
4318  0953 cd0000        	call	c_imul
4320  0956 1c0190        	addw	x,#400
4321  0959 1f09          	ldw	(OFST-5,sp),x
4322  095b               L5622:
4323                     ; 642 	gran(&vent_pwm_t_necc,400,1000);
4325  095b ae03e8        	ldw	x,#1000
4326  095e 89            	pushw	x
4327  095f ae0190        	ldw	x,#400
4328  0962 89            	pushw	x
4329  0963 96            	ldw	x,sp
4330  0964 1c000d        	addw	x,#OFST-1
4331  0967 cd0000        	call	_gran
4333  096a 5b04          	addw	sp,#4
4334                     ; 644 	vent_pwm_max_necc=vent_pwm_i_necc;
4336  096c 1e07          	ldw	x,(OFST-7,sp)
4337  096e 1f05          	ldw	(OFST-9,sp),x
4338                     ; 645 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4340  0970 9c            	rvf
4341  0971 1e09          	ldw	x,(OFST-5,sp)
4342  0973 1307          	cpw	x,(OFST-7,sp)
4343  0975 2d04          	jrsle	L3722
4346  0977 1e09          	ldw	x,(OFST-5,sp)
4347  0979 1f05          	ldw	(OFST-9,sp),x
4348  097b               L3722:
4349                     ; 647 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4351  097b 9c            	rvf
4352  097c be06          	ldw	x,_vent_pwm
4353  097e 1305          	cpw	x,(OFST-9,sp)
4354  0980 2e07          	jrsge	L5722
4357  0982 be06          	ldw	x,_vent_pwm
4358  0984 1c000a        	addw	x,#10
4359  0987 bf06          	ldw	_vent_pwm,x
4360  0989               L5722:
4361                     ; 648 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4363  0989 9c            	rvf
4364  098a be06          	ldw	x,_vent_pwm
4365  098c 1305          	cpw	x,(OFST-9,sp)
4366  098e 2d07          	jrsle	L7722
4369  0990 be06          	ldw	x,_vent_pwm
4370  0992 1d000a        	subw	x,#10
4371  0995 bf06          	ldw	_vent_pwm,x
4372  0997               L7722:
4373                     ; 649 	gran(&vent_pwm,400,1000);
4375  0997 ae03e8        	ldw	x,#1000
4376  099a 89            	pushw	x
4377  099b ae0190        	ldw	x,#400
4378  099e 89            	pushw	x
4379  099f ae0006        	ldw	x,#_vent_pwm
4380  09a2 cd0000        	call	_gran
4382  09a5 5b04          	addw	sp,#4
4383                     ; 651 }
4386  09a7 5b0e          	addw	sp,#14
4387  09a9 81            	ret
4421                     ; 656 void pwr_drv(void)
4421                     ; 657 {
4422                     	switch	.text
4423  09aa               _pwr_drv:
4427                     ; 661 BLOCK_INIT
4429  09aa 72145007      	bset	20487,#2
4432  09ae 72145008      	bset	20488,#2
4435  09b2 72155009      	bres	20489,#2
4436                     ; 663 if(main_cnt1<1500)main_cnt1++;
4438  09b6 9c            	rvf
4439  09b7 be50          	ldw	x,_main_cnt1
4440  09b9 a305dc        	cpw	x,#1500
4441  09bc 2e07          	jrsge	L1132
4444  09be be50          	ldw	x,_main_cnt1
4445  09c0 1c0001        	addw	x,#1
4446  09c3 bf50          	ldw	_main_cnt1,x
4447  09c5               L1132:
4448                     ; 665 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4450  09c5 9c            	rvf
4451  09c6 ce0014        	ldw	x,_ee_TZAS
4452  09c9 90ae0005      	ldw	y,#5
4453  09cd cd0000        	call	c_imul
4455  09d0 b350          	cpw	x,_main_cnt1
4456  09d2 2d0d          	jrsle	L3132
4458  09d4 b605          	ld	a,_bps_class
4459  09d6 a101          	cp	a,#1
4460  09d8 2707          	jreq	L3132
4461                     ; 667 	BLOCK_ON
4463  09da 72145005      	bset	20485,#2
4465  09de cc0a67        	jra	L5132
4466  09e1               L3132:
4467                     ; 670 else if(bps_class==bpsIPS)
4469  09e1 b605          	ld	a,_bps_class
4470  09e3 a101          	cp	a,#1
4471  09e5 261a          	jrne	L7132
4472                     ; 673 		if(bBL_IPS)
4474                     	btst	_bBL_IPS
4475  09ec 2406          	jruge	L1232
4476                     ; 675 			 BLOCK_ON
4478  09ee 72145005      	bset	20485,#2
4480  09f2 2073          	jra	L5132
4481  09f4               L1232:
4482                     ; 678 		else if(!bBL_IPS)
4484                     	btst	_bBL_IPS
4485  09f9 256c          	jrult	L5132
4486                     ; 680 			  BLOCK_OFF
4488  09fb 72155005      	bres	20485,#2
4489  09ff 2066          	jra	L5132
4490  0a01               L7132:
4491                     ; 684 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4493  0a01 9c            	rvf
4494  0a02 ce0014        	ldw	x,_ee_TZAS
4495  0a05 90ae0005      	ldw	y,#5
4496  0a09 cd0000        	call	c_imul
4498  0a0c b350          	cpw	x,_main_cnt1
4499  0a0e 2e3f          	jrsge	L1332
4501  0a10 9c            	rvf
4502  0a11 ce0014        	ldw	x,_ee_TZAS
4503  0a14 90ae0005      	ldw	y,#5
4504  0a18 cd0000        	call	c_imul
4506  0a1b 1c0046        	addw	x,#70
4507  0a1e b350          	cpw	x,_main_cnt1
4508  0a20 2d2d          	jrsle	L1332
4509                     ; 686 	if(bps_class==bpsIPS)
4511  0a22 b605          	ld	a,_bps_class
4512  0a24 a101          	cp	a,#1
4513  0a26 2606          	jrne	L3332
4514                     ; 688 		  BLOCK_OFF
4516  0a28 72155005      	bres	20485,#2
4518  0a2c 2039          	jra	L5132
4519  0a2e               L3332:
4520                     ; 691 	else if(bps_class==bpsIBEP)
4522  0a2e 3d05          	tnz	_bps_class
4523  0a30 2635          	jrne	L5132
4524                     ; 693 		if(ee_DEVICE)
4526  0a32 ce0002        	ldw	x,_ee_DEVICE
4527  0a35 2712          	jreq	L1432
4528                     ; 695 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4530  0a37 b60a          	ld	a,_flags
4531  0a39 a520          	bcp	a,#32
4532  0a3b 2706          	jreq	L3432
4535  0a3d 72145005      	bset	20485,#2
4537  0a41 2024          	jra	L5132
4538  0a43               L3432:
4539                     ; 696 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4541  0a43 72155005      	bres	20485,#2
4542  0a47 201e          	jra	L5132
4543  0a49               L1432:
4544                     ; 700 			BLOCK_OFF
4546  0a49 72155005      	bres	20485,#2
4547  0a4d 2018          	jra	L5132
4548  0a4f               L1332:
4549                     ; 705 else if(bBL)
4551                     	btst	_bBL
4552  0a54 2406          	jruge	L3532
4553                     ; 707 	BLOCK_ON
4555  0a56 72145005      	bset	20485,#2
4557  0a5a 200b          	jra	L5132
4558  0a5c               L3532:
4559                     ; 710 else if(!bBL)
4561                     	btst	_bBL
4562  0a61 2504          	jrult	L5132
4563                     ; 712 	BLOCK_OFF
4565  0a63 72155005      	bres	20485,#2
4566  0a67               L5132:
4567                     ; 716 gran(&pwm_u,2,1020);
4569  0a67 ae03fc        	ldw	x,#1020
4570  0a6a 89            	pushw	x
4571  0a6b ae0002        	ldw	x,#2
4572  0a6e 89            	pushw	x
4573  0a6f ae000b        	ldw	x,#_pwm_u
4574  0a72 cd0000        	call	_gran
4576  0a75 5b04          	addw	sp,#4
4577                     ; 726 TIM1->CCR2H= (char)(pwm_u/256);	
4579  0a77 be0b          	ldw	x,_pwm_u
4580  0a79 90ae0100      	ldw	y,#256
4581  0a7d cd0000        	call	c_idiv
4583  0a80 9f            	ld	a,xl
4584  0a81 c75267        	ld	21095,a
4585                     ; 727 TIM1->CCR2L= (char)pwm_u;
4587  0a84 55000c5268    	mov	21096,_pwm_u+1
4588                     ; 729 TIM1->CCR1H= (char)(pwm_i/256);	
4590  0a89 be0d          	ldw	x,_pwm_i
4591  0a8b 90ae0100      	ldw	y,#256
4592  0a8f cd0000        	call	c_idiv
4594  0a92 9f            	ld	a,xl
4595  0a93 c75265        	ld	21093,a
4596                     ; 730 TIM1->CCR1L= (char)pwm_i;
4598  0a96 55000e5266    	mov	21094,_pwm_i+1
4599                     ; 732 TIM1->CCR3H= (char)(vent_pwm/256);	
4601  0a9b be06          	ldw	x,_vent_pwm
4602  0a9d 90ae0100      	ldw	y,#256
4603  0aa1 cd0000        	call	c_idiv
4605  0aa4 9f            	ld	a,xl
4606  0aa5 c75269        	ld	21097,a
4607                     ; 733 TIM1->CCR3L= (char)vent_pwm;
4609  0aa8 550007526a    	mov	21098,_vent_pwm+1
4610                     ; 734 }
4613  0aad 81            	ret
4651                     ; 739 void pwr_hndl(void)				
4651                     ; 740 {
4652                     	switch	.text
4653  0aae               _pwr_hndl:
4657                     ; 741 if(jp_mode==jp3)
4659  0aae b64b          	ld	a,_jp_mode
4660  0ab0 a103          	cp	a,#3
4661  0ab2 2627          	jrne	L1732
4662                     ; 743 	if((flags&0b00001010)==0)
4664  0ab4 b60a          	ld	a,_flags
4665  0ab6 a50a          	bcp	a,#10
4666  0ab8 260d          	jrne	L3732
4667                     ; 745 		pwm_u=500;
4669  0aba ae01f4        	ldw	x,#500
4670  0abd bf0b          	ldw	_pwm_u,x
4671                     ; 747 		bBL=0;
4673  0abf 72110003      	bres	_bBL
4675  0ac3 acc90bc9      	jpf	L1042
4676  0ac7               L3732:
4677                     ; 749 	else if(flags&0b00001010)
4679  0ac7 b60a          	ld	a,_flags
4680  0ac9 a50a          	bcp	a,#10
4681  0acb 2603          	jrne	L06
4682  0acd cc0bc9        	jp	L1042
4683  0ad0               L06:
4684                     ; 751 		pwm_u=0;
4686  0ad0 5f            	clrw	x
4687  0ad1 bf0b          	ldw	_pwm_u,x
4688                     ; 753 		bBL=1;
4690  0ad3 72100003      	bset	_bBL
4691  0ad7 acc90bc9      	jpf	L1042
4692  0adb               L1732:
4693                     ; 757 else if(jp_mode==jp2)
4695  0adb b64b          	ld	a,_jp_mode
4696  0add a102          	cp	a,#2
4697  0adf 2610          	jrne	L3042
4698                     ; 759 	pwm_u=0;
4700  0ae1 5f            	clrw	x
4701  0ae2 bf0b          	ldw	_pwm_u,x
4702                     ; 760 	pwm_i=0x3ff;
4704  0ae4 ae03ff        	ldw	x,#1023
4705  0ae7 bf0d          	ldw	_pwm_i,x
4706                     ; 761 	bBL=0;
4708  0ae9 72110003      	bres	_bBL
4710  0aed acc90bc9      	jpf	L1042
4711  0af1               L3042:
4712                     ; 763 else if(jp_mode==jp1)
4714  0af1 b64b          	ld	a,_jp_mode
4715  0af3 a101          	cp	a,#1
4716  0af5 2612          	jrne	L7042
4717                     ; 765 	pwm_u=0x3ff;
4719  0af7 ae03ff        	ldw	x,#1023
4720  0afa bf0b          	ldw	_pwm_u,x
4721                     ; 766 	pwm_i=0x3ff;
4723  0afc ae03ff        	ldw	x,#1023
4724  0aff bf0d          	ldw	_pwm_i,x
4725                     ; 767 	bBL=0;
4727  0b01 72110003      	bres	_bBL
4729  0b05 acc90bc9      	jpf	L1042
4730  0b09               L7042:
4731                     ; 770 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4733                     	btst	_bMAIN
4734  0b0e 2417          	jruge	L3142
4736  0b10 b663          	ld	a,_link
4737  0b12 a155          	cp	a,#85
4738  0b14 2611          	jrne	L3142
4739                     ; 772 	pwm_u=volum_u_main_;
4741  0b16 be1c          	ldw	x,_volum_u_main_
4742  0b18 bf0b          	ldw	_pwm_u,x
4743                     ; 773 	pwm_i=0x3ff;
4745  0b1a ae03ff        	ldw	x,#1023
4746  0b1d bf0d          	ldw	_pwm_i,x
4747                     ; 774 	bBL_IPS=0;
4749  0b1f 72110000      	bres	_bBL_IPS
4751  0b23 acc90bc9      	jpf	L1042
4752  0b27               L3142:
4753                     ; 777 else if(link==OFF)
4755  0b27 b663          	ld	a,_link
4756  0b29 a1aa          	cp	a,#170
4757  0b2b 2650          	jrne	L7142
4758                     ; 786  	if(ee_DEVICE)
4760  0b2d ce0002        	ldw	x,_ee_DEVICE
4761  0b30 270d          	jreq	L1242
4762                     ; 788 		pwm_u=0x00;
4764  0b32 5f            	clrw	x
4765  0b33 bf0b          	ldw	_pwm_u,x
4766                     ; 789 		pwm_i=0x00;
4768  0b35 5f            	clrw	x
4769  0b36 bf0d          	ldw	_pwm_i,x
4770                     ; 790 		bBL=1;
4772  0b38 72100003      	bset	_bBL
4774  0b3c cc0bc9        	jra	L1042
4775  0b3f               L1242:
4776                     ; 794 		if((flags&0b00011010)==0)
4778  0b3f b60a          	ld	a,_flags
4779  0b41 a51a          	bcp	a,#26
4780  0b43 2622          	jrne	L5242
4781                     ; 796 			pwm_u=ee_U_AVT;
4783  0b45 ce000a        	ldw	x,_ee_U_AVT
4784  0b48 bf0b          	ldw	_pwm_u,x
4785                     ; 797 			gran(&pwm_u,0,1020);
4787  0b4a ae03fc        	ldw	x,#1020
4788  0b4d 89            	pushw	x
4789  0b4e 5f            	clrw	x
4790  0b4f 89            	pushw	x
4791  0b50 ae000b        	ldw	x,#_pwm_u
4792  0b53 cd0000        	call	_gran
4794  0b56 5b04          	addw	sp,#4
4795                     ; 798 		    	pwm_i=0x3ff;
4797  0b58 ae03ff        	ldw	x,#1023
4798  0b5b bf0d          	ldw	_pwm_i,x
4799                     ; 799 			bBL=0;
4801  0b5d 72110003      	bres	_bBL
4802                     ; 800 			bBL_IPS=0;
4804  0b61 72110000      	bres	_bBL_IPS
4806  0b65 2062          	jra	L1042
4807  0b67               L5242:
4808                     ; 802 		else if(flags&0b00011010)
4810  0b67 b60a          	ld	a,_flags
4811  0b69 a51a          	bcp	a,#26
4812  0b6b 275c          	jreq	L1042
4813                     ; 804 			pwm_u=0;
4815  0b6d 5f            	clrw	x
4816  0b6e bf0b          	ldw	_pwm_u,x
4817                     ; 805 			pwm_i=0;
4819  0b70 5f            	clrw	x
4820  0b71 bf0d          	ldw	_pwm_i,x
4821                     ; 806 			bBL=1;
4823  0b73 72100003      	bset	_bBL
4824                     ; 807 			bBL_IPS=1;
4826  0b77 72100000      	bset	_bBL_IPS
4827  0b7b 204c          	jra	L1042
4828  0b7d               L7142:
4829                     ; 816 else	if(link==ON)				//если есть связь
4831  0b7d b663          	ld	a,_link
4832  0b7f a155          	cp	a,#85
4833  0b81 2646          	jrne	L1042
4834                     ; 818 	if((flags&0b00100000)==0)	//если нет блокировки извне
4836  0b83 b60a          	ld	a,_flags
4837  0b85 a520          	bcp	a,#32
4838  0b87 2630          	jrne	L7342
4839                     ; 820 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4841  0b89 b60a          	ld	a,_flags
4842  0b8b a51a          	bcp	a,#26
4843  0b8d 2706          	jreq	L3442
4845  0b8f b60a          	ld	a,_flags
4846  0b91 a540          	bcp	a,#64
4847  0b93 2712          	jreq	L1442
4848  0b95               L3442:
4849                     ; 822 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4851  0b95 be5f          	ldw	x,__x_
4852  0b97 72bb0059      	addw	x,_vol_u_temp
4853  0b9b bf0b          	ldw	_pwm_u,x
4854                     ; 823 		    	pwm_i=vol_i_temp;
4856  0b9d be57          	ldw	x,_vol_i_temp
4857  0b9f bf0d          	ldw	_pwm_i,x
4858                     ; 824 			bBL=0;
4860  0ba1 72110003      	bres	_bBL
4862  0ba5 2022          	jra	L1042
4863  0ba7               L1442:
4864                     ; 826 		else if(flags&0b00011010)					//если есть аварии
4866  0ba7 b60a          	ld	a,_flags
4867  0ba9 a51a          	bcp	a,#26
4868  0bab 271c          	jreq	L1042
4869                     ; 828 			pwm_u=0;								//то полный стоп
4871  0bad 5f            	clrw	x
4872  0bae bf0b          	ldw	_pwm_u,x
4873                     ; 829 			pwm_i=0;
4875  0bb0 5f            	clrw	x
4876  0bb1 bf0d          	ldw	_pwm_i,x
4877                     ; 830 			bBL=1;
4879  0bb3 72100003      	bset	_bBL
4880  0bb7 2010          	jra	L1042
4881  0bb9               L7342:
4882                     ; 833 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4884  0bb9 b60a          	ld	a,_flags
4885  0bbb a520          	bcp	a,#32
4886  0bbd 270a          	jreq	L1042
4887                     ; 835 		pwm_u=0;
4889  0bbf 5f            	clrw	x
4890  0bc0 bf0b          	ldw	_pwm_u,x
4891                     ; 836 	    	pwm_i=0;
4893  0bc2 5f            	clrw	x
4894  0bc3 bf0d          	ldw	_pwm_i,x
4895                     ; 837 		bBL=1;
4897  0bc5 72100003      	bset	_bBL
4898  0bc9               L1042:
4899                     ; 843 }
4902  0bc9 81            	ret
4944                     	switch	.const
4945  0008               L46:
4946  0008 00000258      	dc.l	600
4947  000c               L66:
4948  000c 00000708      	dc.l	1800
4949  0010               L07:
4950  0010 000003e8      	dc.l	1000
4951                     ; 846 void matemat(void)
4951                     ; 847 {
4952                     	switch	.text
4953  0bca               _matemat:
4955  0bca 5204          	subw	sp,#4
4956       00000004      OFST:	set	4
4959                     ; 868 temp_SL=adc_buff_[4];
4961  0bcc ce000d        	ldw	x,_adc_buff_+8
4962  0bcf cd0000        	call	c_itolx
4964  0bd2 96            	ldw	x,sp
4965  0bd3 1c0001        	addw	x,#OFST-3
4966  0bd6 cd0000        	call	c_rtol
4968                     ; 869 temp_SL-=ee_K[0][0];
4970  0bd9 ce0018        	ldw	x,_ee_K
4971  0bdc cd0000        	call	c_itolx
4973  0bdf 96            	ldw	x,sp
4974  0be0 1c0001        	addw	x,#OFST-3
4975  0be3 cd0000        	call	c_lgsub
4977                     ; 870 if(temp_SL<0) temp_SL=0;
4979  0be6 9c            	rvf
4980  0be7 0d01          	tnz	(OFST-3,sp)
4981  0be9 2e0a          	jrsge	L3742
4984  0beb ae0000        	ldw	x,#0
4985  0bee 1f03          	ldw	(OFST-1,sp),x
4986  0bf0 ae0000        	ldw	x,#0
4987  0bf3 1f01          	ldw	(OFST-3,sp),x
4988  0bf5               L3742:
4989                     ; 871 temp_SL*=ee_K[0][1];
4991  0bf5 ce001a        	ldw	x,_ee_K+2
4992  0bf8 cd0000        	call	c_itolx
4994  0bfb 96            	ldw	x,sp
4995  0bfc 1c0001        	addw	x,#OFST-3
4996  0bff cd0000        	call	c_lgmul
4998                     ; 872 temp_SL/=600;
5000  0c02 96            	ldw	x,sp
5001  0c03 1c0001        	addw	x,#OFST-3
5002  0c06 cd0000        	call	c_ltor
5004  0c09 ae0008        	ldw	x,#L46
5005  0c0c cd0000        	call	c_ldiv
5007  0c0f 96            	ldw	x,sp
5008  0c10 1c0001        	addw	x,#OFST-3
5009  0c13 cd0000        	call	c_rtol
5011                     ; 873 I=(signed short)temp_SL;
5013  0c16 1e03          	ldw	x,(OFST-1,sp)
5014  0c18 bf6f          	ldw	_I,x
5015                     ; 878 temp_SL=(signed long)adc_buff_[1];
5017  0c1a ce0007        	ldw	x,_adc_buff_+2
5018  0c1d cd0000        	call	c_itolx
5020  0c20 96            	ldw	x,sp
5021  0c21 1c0001        	addw	x,#OFST-3
5022  0c24 cd0000        	call	c_rtol
5024                     ; 880 if(temp_SL<0) temp_SL=0;
5026  0c27 9c            	rvf
5027  0c28 0d01          	tnz	(OFST-3,sp)
5028  0c2a 2e0a          	jrsge	L5742
5031  0c2c ae0000        	ldw	x,#0
5032  0c2f 1f03          	ldw	(OFST-1,sp),x
5033  0c31 ae0000        	ldw	x,#0
5034  0c34 1f01          	ldw	(OFST-3,sp),x
5035  0c36               L5742:
5036                     ; 881 temp_SL*=(signed long)ee_K[2][1];
5038  0c36 ce0022        	ldw	x,_ee_K+10
5039  0c39 cd0000        	call	c_itolx
5041  0c3c 96            	ldw	x,sp
5042  0c3d 1c0001        	addw	x,#OFST-3
5043  0c40 cd0000        	call	c_lgmul
5045                     ; 882 temp_SL/=1800L;
5047  0c43 96            	ldw	x,sp
5048  0c44 1c0001        	addw	x,#OFST-3
5049  0c47 cd0000        	call	c_ltor
5051  0c4a ae000c        	ldw	x,#L66
5052  0c4d cd0000        	call	c_ldiv
5054  0c50 96            	ldw	x,sp
5055  0c51 1c0001        	addw	x,#OFST-3
5056  0c54 cd0000        	call	c_rtol
5058                     ; 883 Ui=(unsigned short)temp_SL;
5060  0c57 1e03          	ldw	x,(OFST-1,sp)
5061  0c59 bf6b          	ldw	_Ui,x
5062                     ; 890 temp_SL=adc_buff_[3];
5064  0c5b ce000b        	ldw	x,_adc_buff_+6
5065  0c5e cd0000        	call	c_itolx
5067  0c61 96            	ldw	x,sp
5068  0c62 1c0001        	addw	x,#OFST-3
5069  0c65 cd0000        	call	c_rtol
5071                     ; 892 if(temp_SL<0) temp_SL=0;
5073  0c68 9c            	rvf
5074  0c69 0d01          	tnz	(OFST-3,sp)
5075  0c6b 2e0a          	jrsge	L7742
5078  0c6d ae0000        	ldw	x,#0
5079  0c70 1f03          	ldw	(OFST-1,sp),x
5080  0c72 ae0000        	ldw	x,#0
5081  0c75 1f01          	ldw	(OFST-3,sp),x
5082  0c77               L7742:
5083                     ; 893 temp_SL*=ee_K[1][1];
5085  0c77 ce001e        	ldw	x,_ee_K+6
5086  0c7a cd0000        	call	c_itolx
5088  0c7d 96            	ldw	x,sp
5089  0c7e 1c0001        	addw	x,#OFST-3
5090  0c81 cd0000        	call	c_lgmul
5092                     ; 894 temp_SL/=1800;
5094  0c84 96            	ldw	x,sp
5095  0c85 1c0001        	addw	x,#OFST-3
5096  0c88 cd0000        	call	c_ltor
5098  0c8b ae000c        	ldw	x,#L66
5099  0c8e cd0000        	call	c_ldiv
5101  0c91 96            	ldw	x,sp
5102  0c92 1c0001        	addw	x,#OFST-3
5103  0c95 cd0000        	call	c_rtol
5105                     ; 895 Un=(unsigned short)temp_SL;
5107  0c98 1e03          	ldw	x,(OFST-1,sp)
5108  0c9a bf6d          	ldw	_Un,x
5109                     ; 898 temp_SL=adc_buff_[2];
5111  0c9c ce0009        	ldw	x,_adc_buff_+4
5112  0c9f cd0000        	call	c_itolx
5114  0ca2 96            	ldw	x,sp
5115  0ca3 1c0001        	addw	x,#OFST-3
5116  0ca6 cd0000        	call	c_rtol
5118                     ; 899 temp_SL*=ee_K[3][1];
5120  0ca9 ce0026        	ldw	x,_ee_K+14
5121  0cac cd0000        	call	c_itolx
5123  0caf 96            	ldw	x,sp
5124  0cb0 1c0001        	addw	x,#OFST-3
5125  0cb3 cd0000        	call	c_lgmul
5127                     ; 900 temp_SL/=1000;
5129  0cb6 96            	ldw	x,sp
5130  0cb7 1c0001        	addw	x,#OFST-3
5131  0cba cd0000        	call	c_ltor
5133  0cbd ae0010        	ldw	x,#L07
5134  0cc0 cd0000        	call	c_ldiv
5136  0cc3 96            	ldw	x,sp
5137  0cc4 1c0001        	addw	x,#OFST-3
5138  0cc7 cd0000        	call	c_rtol
5140                     ; 901 T=(signed short)(temp_SL-273L);
5142  0cca 7b04          	ld	a,(OFST+0,sp)
5143  0ccc 5f            	clrw	x
5144  0ccd 4d            	tnz	a
5145  0cce 2a01          	jrpl	L27
5146  0cd0 53            	cplw	x
5147  0cd1               L27:
5148  0cd1 97            	ld	xl,a
5149  0cd2 1d0111        	subw	x,#273
5150  0cd5 01            	rrwa	x,a
5151  0cd6 b768          	ld	_T,a
5152  0cd8 02            	rlwa	x,a
5153                     ; 902 if(T<-30)T=-30;
5155  0cd9 9c            	rvf
5156  0cda b668          	ld	a,_T
5157  0cdc a1e2          	cp	a,#226
5158  0cde 2e04          	jrsge	L1052
5161  0ce0 35e20068      	mov	_T,#226
5162  0ce4               L1052:
5163                     ; 903 if(T>120)T=120;
5165  0ce4 9c            	rvf
5166  0ce5 b668          	ld	a,_T
5167  0ce7 a179          	cp	a,#121
5168  0ce9 2f04          	jrslt	L3052
5171  0ceb 35780068      	mov	_T,#120
5172  0cef               L3052:
5173                     ; 905 Udb=flags;
5175  0cef b60a          	ld	a,_flags
5176  0cf1 5f            	clrw	x
5177  0cf2 97            	ld	xl,a
5178  0cf3 bf69          	ldw	_Udb,x
5179                     ; 913 }
5182  0cf5 5b04          	addw	sp,#4
5183  0cf7 81            	ret
5214                     ; 916 void temper_drv(void)		//1 Hz
5214                     ; 917 {
5215                     	switch	.text
5216  0cf8               _temper_drv:
5220                     ; 919 if(T>ee_tsign) tsign_cnt++;
5222  0cf8 9c            	rvf
5223  0cf9 5f            	clrw	x
5224  0cfa b668          	ld	a,_T
5225  0cfc 2a01          	jrpl	L67
5226  0cfe 53            	cplw	x
5227  0cff               L67:
5228  0cff 97            	ld	xl,a
5229  0d00 c3000c        	cpw	x,_ee_tsign
5230  0d03 2d09          	jrsle	L5152
5233  0d05 be4e          	ldw	x,_tsign_cnt
5234  0d07 1c0001        	addw	x,#1
5235  0d0a bf4e          	ldw	_tsign_cnt,x
5237  0d0c 201d          	jra	L7152
5238  0d0e               L5152:
5239                     ; 920 else if (T<(ee_tsign-1)) tsign_cnt--;
5241  0d0e 9c            	rvf
5242  0d0f ce000c        	ldw	x,_ee_tsign
5243  0d12 5a            	decw	x
5244  0d13 905f          	clrw	y
5245  0d15 b668          	ld	a,_T
5246  0d17 2a02          	jrpl	L001
5247  0d19 9053          	cplw	y
5248  0d1b               L001:
5249  0d1b 9097          	ld	yl,a
5250  0d1d 90bf00        	ldw	c_y,y
5251  0d20 b300          	cpw	x,c_y
5252  0d22 2d07          	jrsle	L7152
5255  0d24 be4e          	ldw	x,_tsign_cnt
5256  0d26 1d0001        	subw	x,#1
5257  0d29 bf4e          	ldw	_tsign_cnt,x
5258  0d2b               L7152:
5259                     ; 922 gran(&tsign_cnt,0,60);
5261  0d2b ae003c        	ldw	x,#60
5262  0d2e 89            	pushw	x
5263  0d2f 5f            	clrw	x
5264  0d30 89            	pushw	x
5265  0d31 ae004e        	ldw	x,#_tsign_cnt
5266  0d34 cd0000        	call	_gran
5268  0d37 5b04          	addw	sp,#4
5269                     ; 924 if(tsign_cnt>=55)
5271  0d39 9c            	rvf
5272  0d3a be4e          	ldw	x,_tsign_cnt
5273  0d3c a30037        	cpw	x,#55
5274  0d3f 2f16          	jrslt	L3252
5275                     ; 926 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5277  0d41 3d4b          	tnz	_jp_mode
5278  0d43 2606          	jrne	L1352
5280  0d45 b60a          	ld	a,_flags
5281  0d47 a540          	bcp	a,#64
5282  0d49 2706          	jreq	L7252
5283  0d4b               L1352:
5285  0d4b b64b          	ld	a,_jp_mode
5286  0d4d a103          	cp	a,#3
5287  0d4f 2612          	jrne	L3352
5288  0d51               L7252:
5291  0d51 7214000a      	bset	_flags,#2
5292  0d55 200c          	jra	L3352
5293  0d57               L3252:
5294                     ; 928 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5296  0d57 9c            	rvf
5297  0d58 be4e          	ldw	x,_tsign_cnt
5298  0d5a a30006        	cpw	x,#6
5299  0d5d 2e04          	jrsge	L3352
5302  0d5f 7215000a      	bres	_flags,#2
5303  0d63               L3352:
5304                     ; 933 if(T>ee_tmax) tmax_cnt++;
5306  0d63 9c            	rvf
5307  0d64 5f            	clrw	x
5308  0d65 b668          	ld	a,_T
5309  0d67 2a01          	jrpl	L201
5310  0d69 53            	cplw	x
5311  0d6a               L201:
5312  0d6a 97            	ld	xl,a
5313  0d6b c3000e        	cpw	x,_ee_tmax
5314  0d6e 2d09          	jrsle	L7352
5317  0d70 be4c          	ldw	x,_tmax_cnt
5318  0d72 1c0001        	addw	x,#1
5319  0d75 bf4c          	ldw	_tmax_cnt,x
5321  0d77 201d          	jra	L1452
5322  0d79               L7352:
5323                     ; 934 else if (T<(ee_tmax-1)) tmax_cnt--;
5325  0d79 9c            	rvf
5326  0d7a ce000e        	ldw	x,_ee_tmax
5327  0d7d 5a            	decw	x
5328  0d7e 905f          	clrw	y
5329  0d80 b668          	ld	a,_T
5330  0d82 2a02          	jrpl	L401
5331  0d84 9053          	cplw	y
5332  0d86               L401:
5333  0d86 9097          	ld	yl,a
5334  0d88 90bf00        	ldw	c_y,y
5335  0d8b b300          	cpw	x,c_y
5336  0d8d 2d07          	jrsle	L1452
5339  0d8f be4c          	ldw	x,_tmax_cnt
5340  0d91 1d0001        	subw	x,#1
5341  0d94 bf4c          	ldw	_tmax_cnt,x
5342  0d96               L1452:
5343                     ; 936 gran(&tmax_cnt,0,60);
5345  0d96 ae003c        	ldw	x,#60
5346  0d99 89            	pushw	x
5347  0d9a 5f            	clrw	x
5348  0d9b 89            	pushw	x
5349  0d9c ae004c        	ldw	x,#_tmax_cnt
5350  0d9f cd0000        	call	_gran
5352  0da2 5b04          	addw	sp,#4
5353                     ; 938 if(tmax_cnt>=55)
5355  0da4 9c            	rvf
5356  0da5 be4c          	ldw	x,_tmax_cnt
5357  0da7 a30037        	cpw	x,#55
5358  0daa 2f16          	jrslt	L5452
5359                     ; 940 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5361  0dac 3d4b          	tnz	_jp_mode
5362  0dae 2606          	jrne	L3552
5364  0db0 b60a          	ld	a,_flags
5365  0db2 a540          	bcp	a,#64
5366  0db4 2706          	jreq	L1552
5367  0db6               L3552:
5369  0db6 b64b          	ld	a,_jp_mode
5370  0db8 a103          	cp	a,#3
5371  0dba 2612          	jrne	L5552
5372  0dbc               L1552:
5375  0dbc 7212000a      	bset	_flags,#1
5376  0dc0 200c          	jra	L5552
5377  0dc2               L5452:
5378                     ; 942 else if (tmax_cnt<=5) flags&=0b11111101;
5380  0dc2 9c            	rvf
5381  0dc3 be4c          	ldw	x,_tmax_cnt
5382  0dc5 a30006        	cpw	x,#6
5383  0dc8 2e04          	jrsge	L5552
5386  0dca 7213000a      	bres	_flags,#1
5387  0dce               L5552:
5388                     ; 945 } 
5391  0dce 81            	ret
5423                     ; 948 void u_drv(void)		//1Hz
5423                     ; 949 { 
5424                     	switch	.text
5425  0dcf               _u_drv:
5429                     ; 950 if(jp_mode!=jp3)
5431  0dcf b64b          	ld	a,_jp_mode
5432  0dd1 a103          	cp	a,#3
5433  0dd3 2770          	jreq	L1752
5434                     ; 952 	if(Ui>ee_Umax)umax_cnt++;
5436  0dd5 9c            	rvf
5437  0dd6 be6b          	ldw	x,_Ui
5438  0dd8 c30012        	cpw	x,_ee_Umax
5439  0ddb 2d09          	jrsle	L3752
5442  0ddd be66          	ldw	x,_umax_cnt
5443  0ddf 1c0001        	addw	x,#1
5444  0de2 bf66          	ldw	_umax_cnt,x
5446  0de4 2003          	jra	L5752
5447  0de6               L3752:
5448                     ; 953 	else umax_cnt=0;
5450  0de6 5f            	clrw	x
5451  0de7 bf66          	ldw	_umax_cnt,x
5452  0de9               L5752:
5453                     ; 954 	gran(&umax_cnt,0,10);
5455  0de9 ae000a        	ldw	x,#10
5456  0dec 89            	pushw	x
5457  0ded 5f            	clrw	x
5458  0dee 89            	pushw	x
5459  0def ae0066        	ldw	x,#_umax_cnt
5460  0df2 cd0000        	call	_gran
5462  0df5 5b04          	addw	sp,#4
5463                     ; 955 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5465  0df7 9c            	rvf
5466  0df8 be66          	ldw	x,_umax_cnt
5467  0dfa a3000a        	cpw	x,#10
5468  0dfd 2f04          	jrslt	L7752
5471  0dff 7216000a      	bset	_flags,#3
5472  0e03               L7752:
5473                     ; 958 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5475  0e03 9c            	rvf
5476  0e04 be6b          	ldw	x,_Ui
5477  0e06 b36d          	cpw	x,_Un
5478  0e08 2e1c          	jrsge	L1062
5480  0e0a 9c            	rvf
5481  0e0b be6d          	ldw	x,_Un
5482  0e0d 72b0006b      	subw	x,_Ui
5483  0e11 c30010        	cpw	x,_ee_dU
5484  0e14 2d10          	jrsle	L1062
5486  0e16 c65005        	ld	a,20485
5487  0e19 a504          	bcp	a,#4
5488  0e1b 2609          	jrne	L1062
5491  0e1d be64          	ldw	x,_umin_cnt
5492  0e1f 1c0001        	addw	x,#1
5493  0e22 bf64          	ldw	_umin_cnt,x
5495  0e24 2003          	jra	L3062
5496  0e26               L1062:
5497                     ; 959 	else umin_cnt=0;
5499  0e26 5f            	clrw	x
5500  0e27 bf64          	ldw	_umin_cnt,x
5501  0e29               L3062:
5502                     ; 960 	gran(&umin_cnt,0,10);	
5504  0e29 ae000a        	ldw	x,#10
5505  0e2c 89            	pushw	x
5506  0e2d 5f            	clrw	x
5507  0e2e 89            	pushw	x
5508  0e2f ae0064        	ldw	x,#_umin_cnt
5509  0e32 cd0000        	call	_gran
5511  0e35 5b04          	addw	sp,#4
5512                     ; 961 	if(umin_cnt>=10)flags|=0b00010000;	  
5514  0e37 9c            	rvf
5515  0e38 be64          	ldw	x,_umin_cnt
5516  0e3a a3000a        	cpw	x,#10
5517  0e3d 2f6f          	jrslt	L7062
5520  0e3f 7218000a      	bset	_flags,#4
5521  0e43 2069          	jra	L7062
5522  0e45               L1752:
5523                     ; 963 else if(jp_mode==jp3)
5525  0e45 b64b          	ld	a,_jp_mode
5526  0e47 a103          	cp	a,#3
5527  0e49 2663          	jrne	L7062
5528                     ; 965 	if(Ui>700)umax_cnt++;
5530  0e4b 9c            	rvf
5531  0e4c be6b          	ldw	x,_Ui
5532  0e4e a302bd        	cpw	x,#701
5533  0e51 2f09          	jrslt	L3162
5536  0e53 be66          	ldw	x,_umax_cnt
5537  0e55 1c0001        	addw	x,#1
5538  0e58 bf66          	ldw	_umax_cnt,x
5540  0e5a 2003          	jra	L5162
5541  0e5c               L3162:
5542                     ; 966 	else umax_cnt=0;
5544  0e5c 5f            	clrw	x
5545  0e5d bf66          	ldw	_umax_cnt,x
5546  0e5f               L5162:
5547                     ; 967 	gran(&umax_cnt,0,10);
5549  0e5f ae000a        	ldw	x,#10
5550  0e62 89            	pushw	x
5551  0e63 5f            	clrw	x
5552  0e64 89            	pushw	x
5553  0e65 ae0066        	ldw	x,#_umax_cnt
5554  0e68 cd0000        	call	_gran
5556  0e6b 5b04          	addw	sp,#4
5557                     ; 968 	if(umax_cnt>=10)flags|=0b00001000;
5559  0e6d 9c            	rvf
5560  0e6e be66          	ldw	x,_umax_cnt
5561  0e70 a3000a        	cpw	x,#10
5562  0e73 2f04          	jrslt	L7162
5565  0e75 7216000a      	bset	_flags,#3
5566  0e79               L7162:
5567                     ; 971 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5569  0e79 9c            	rvf
5570  0e7a be6b          	ldw	x,_Ui
5571  0e7c a300c8        	cpw	x,#200
5572  0e7f 2e10          	jrsge	L1262
5574  0e81 c65005        	ld	a,20485
5575  0e84 a504          	bcp	a,#4
5576  0e86 2609          	jrne	L1262
5579  0e88 be64          	ldw	x,_umin_cnt
5580  0e8a 1c0001        	addw	x,#1
5581  0e8d bf64          	ldw	_umin_cnt,x
5583  0e8f 2003          	jra	L3262
5584  0e91               L1262:
5585                     ; 972 	else umin_cnt=0;
5587  0e91 5f            	clrw	x
5588  0e92 bf64          	ldw	_umin_cnt,x
5589  0e94               L3262:
5590                     ; 973 	gran(&umin_cnt,0,10);	
5592  0e94 ae000a        	ldw	x,#10
5593  0e97 89            	pushw	x
5594  0e98 5f            	clrw	x
5595  0e99 89            	pushw	x
5596  0e9a ae0064        	ldw	x,#_umin_cnt
5597  0e9d cd0000        	call	_gran
5599  0ea0 5b04          	addw	sp,#4
5600                     ; 974 	if(umin_cnt>=10)flags|=0b00010000;	  
5602  0ea2 9c            	rvf
5603  0ea3 be64          	ldw	x,_umin_cnt
5604  0ea5 a3000a        	cpw	x,#10
5605  0ea8 2f04          	jrslt	L7062
5608  0eaa 7218000a      	bset	_flags,#4
5609  0eae               L7062:
5610                     ; 976 }
5613  0eae 81            	ret
5640                     ; 979 void x_drv(void)
5640                     ; 980 {
5641                     	switch	.text
5642  0eaf               _x_drv:
5646                     ; 981 if(_x__==_x_)
5648  0eaf be5d          	ldw	x,__x__
5649  0eb1 b35f          	cpw	x,__x_
5650  0eb3 262a          	jrne	L7362
5651                     ; 983 	if(_x_cnt<60)
5653  0eb5 9c            	rvf
5654  0eb6 be5b          	ldw	x,__x_cnt
5655  0eb8 a3003c        	cpw	x,#60
5656  0ebb 2e25          	jrsge	L7462
5657                     ; 985 		_x_cnt++;
5659  0ebd be5b          	ldw	x,__x_cnt
5660  0ebf 1c0001        	addw	x,#1
5661  0ec2 bf5b          	ldw	__x_cnt,x
5662                     ; 986 		if(_x_cnt>=60)
5664  0ec4 9c            	rvf
5665  0ec5 be5b          	ldw	x,__x_cnt
5666  0ec7 a3003c        	cpw	x,#60
5667  0eca 2f16          	jrslt	L7462
5668                     ; 988 			if(_x_ee_!=_x_)_x_ee_=_x_;
5670  0ecc ce0016        	ldw	x,__x_ee_
5671  0ecf b35f          	cpw	x,__x_
5672  0ed1 270f          	jreq	L7462
5675  0ed3 be5f          	ldw	x,__x_
5676  0ed5 89            	pushw	x
5677  0ed6 ae0016        	ldw	x,#__x_ee_
5678  0ed9 cd0000        	call	c_eewrw
5680  0edc 85            	popw	x
5681  0edd 2003          	jra	L7462
5682  0edf               L7362:
5683                     ; 993 else _x_cnt=0;
5685  0edf 5f            	clrw	x
5686  0ee0 bf5b          	ldw	__x_cnt,x
5687  0ee2               L7462:
5688                     ; 995 if(_x_cnt>60) _x_cnt=0;	
5690  0ee2 9c            	rvf
5691  0ee3 be5b          	ldw	x,__x_cnt
5692  0ee5 a3003d        	cpw	x,#61
5693  0ee8 2f03          	jrslt	L1562
5696  0eea 5f            	clrw	x
5697  0eeb bf5b          	ldw	__x_cnt,x
5698  0eed               L1562:
5699                     ; 997 _x__=_x_;
5701  0eed be5f          	ldw	x,__x_
5702  0eef bf5d          	ldw	__x__,x
5703                     ; 998 }
5706  0ef1 81            	ret
5732                     ; 1001 void apv_start(void)
5732                     ; 1002 {
5733                     	switch	.text
5734  0ef2               _apv_start:
5738                     ; 1003 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5740  0ef2 3d46          	tnz	_apv_cnt
5741  0ef4 2624          	jrne	L3662
5743  0ef6 3d47          	tnz	_apv_cnt+1
5744  0ef8 2620          	jrne	L3662
5746  0efa 3d48          	tnz	_apv_cnt+2
5747  0efc 261c          	jrne	L3662
5749                     	btst	_bAPV
5750  0f03 2515          	jrult	L3662
5751                     ; 1005 	apv_cnt[0]=60;
5753  0f05 353c0046      	mov	_apv_cnt,#60
5754                     ; 1006 	apv_cnt[1]=60;
5756  0f09 353c0047      	mov	_apv_cnt+1,#60
5757                     ; 1007 	apv_cnt[2]=60;
5759  0f0d 353c0048      	mov	_apv_cnt+2,#60
5760                     ; 1008 	apv_cnt_=3600;
5762  0f11 ae0e10        	ldw	x,#3600
5763  0f14 bf44          	ldw	_apv_cnt_,x
5764                     ; 1009 	bAPV=1;	
5766  0f16 72100002      	bset	_bAPV
5767  0f1a               L3662:
5768                     ; 1011 }
5771  0f1a 81            	ret
5797                     ; 1014 void apv_stop(void)
5797                     ; 1015 {
5798                     	switch	.text
5799  0f1b               _apv_stop:
5803                     ; 1016 apv_cnt[0]=0;
5805  0f1b 3f46          	clr	_apv_cnt
5806                     ; 1017 apv_cnt[1]=0;
5808  0f1d 3f47          	clr	_apv_cnt+1
5809                     ; 1018 apv_cnt[2]=0;
5811  0f1f 3f48          	clr	_apv_cnt+2
5812                     ; 1019 apv_cnt_=0;	
5814  0f21 5f            	clrw	x
5815  0f22 bf44          	ldw	_apv_cnt_,x
5816                     ; 1020 bAPV=0;
5818  0f24 72110002      	bres	_bAPV
5819                     ; 1021 }
5822  0f28 81            	ret
5857                     ; 1025 void apv_hndl(void)
5857                     ; 1026 {
5858                     	switch	.text
5859  0f29               _apv_hndl:
5863                     ; 1027 if(apv_cnt[0])
5865  0f29 3d46          	tnz	_apv_cnt
5866  0f2b 271e          	jreq	L5072
5867                     ; 1029 	apv_cnt[0]--;
5869  0f2d 3a46          	dec	_apv_cnt
5870                     ; 1030 	if(apv_cnt[0]==0)
5872  0f2f 3d46          	tnz	_apv_cnt
5873  0f31 265a          	jrne	L1172
5874                     ; 1032 		flags&=0b11100001;
5876  0f33 b60a          	ld	a,_flags
5877  0f35 a4e1          	and	a,#225
5878  0f37 b70a          	ld	_flags,a
5879                     ; 1033 		tsign_cnt=0;
5881  0f39 5f            	clrw	x
5882  0f3a bf4e          	ldw	_tsign_cnt,x
5883                     ; 1034 		tmax_cnt=0;
5885  0f3c 5f            	clrw	x
5886  0f3d bf4c          	ldw	_tmax_cnt,x
5887                     ; 1035 		umax_cnt=0;
5889  0f3f 5f            	clrw	x
5890  0f40 bf66          	ldw	_umax_cnt,x
5891                     ; 1036 		umin_cnt=0;
5893  0f42 5f            	clrw	x
5894  0f43 bf64          	ldw	_umin_cnt,x
5895                     ; 1038 		led_drv_cnt=30;
5897  0f45 351e0019      	mov	_led_drv_cnt,#30
5898  0f49 2042          	jra	L1172
5899  0f4b               L5072:
5900                     ; 1041 else if(apv_cnt[1])
5902  0f4b 3d47          	tnz	_apv_cnt+1
5903  0f4d 271e          	jreq	L3172
5904                     ; 1043 	apv_cnt[1]--;
5906  0f4f 3a47          	dec	_apv_cnt+1
5907                     ; 1044 	if(apv_cnt[1]==0)
5909  0f51 3d47          	tnz	_apv_cnt+1
5910  0f53 2638          	jrne	L1172
5911                     ; 1046 		flags&=0b11100001;
5913  0f55 b60a          	ld	a,_flags
5914  0f57 a4e1          	and	a,#225
5915  0f59 b70a          	ld	_flags,a
5916                     ; 1047 		tsign_cnt=0;
5918  0f5b 5f            	clrw	x
5919  0f5c bf4e          	ldw	_tsign_cnt,x
5920                     ; 1048 		tmax_cnt=0;
5922  0f5e 5f            	clrw	x
5923  0f5f bf4c          	ldw	_tmax_cnt,x
5924                     ; 1049 		umax_cnt=0;
5926  0f61 5f            	clrw	x
5927  0f62 bf66          	ldw	_umax_cnt,x
5928                     ; 1050 		umin_cnt=0;
5930  0f64 5f            	clrw	x
5931  0f65 bf64          	ldw	_umin_cnt,x
5932                     ; 1052 		led_drv_cnt=30;
5934  0f67 351e0019      	mov	_led_drv_cnt,#30
5935  0f6b 2020          	jra	L1172
5936  0f6d               L3172:
5937                     ; 1055 else if(apv_cnt[2])
5939  0f6d 3d48          	tnz	_apv_cnt+2
5940  0f6f 271c          	jreq	L1172
5941                     ; 1057 	apv_cnt[2]--;
5943  0f71 3a48          	dec	_apv_cnt+2
5944                     ; 1058 	if(apv_cnt[2]==0)
5946  0f73 3d48          	tnz	_apv_cnt+2
5947  0f75 2616          	jrne	L1172
5948                     ; 1060 		flags&=0b11100001;
5950  0f77 b60a          	ld	a,_flags
5951  0f79 a4e1          	and	a,#225
5952  0f7b b70a          	ld	_flags,a
5953                     ; 1061 		tsign_cnt=0;
5955  0f7d 5f            	clrw	x
5956  0f7e bf4e          	ldw	_tsign_cnt,x
5957                     ; 1062 		tmax_cnt=0;
5959  0f80 5f            	clrw	x
5960  0f81 bf4c          	ldw	_tmax_cnt,x
5961                     ; 1063 		umax_cnt=0;
5963  0f83 5f            	clrw	x
5964  0f84 bf66          	ldw	_umax_cnt,x
5965                     ; 1064 		umin_cnt=0;          
5967  0f86 5f            	clrw	x
5968  0f87 bf64          	ldw	_umin_cnt,x
5969                     ; 1066 		led_drv_cnt=30;
5971  0f89 351e0019      	mov	_led_drv_cnt,#30
5972  0f8d               L1172:
5973                     ; 1070 if(apv_cnt_)
5975  0f8d be44          	ldw	x,_apv_cnt_
5976  0f8f 2712          	jreq	L5272
5977                     ; 1072 	apv_cnt_--;
5979  0f91 be44          	ldw	x,_apv_cnt_
5980  0f93 1d0001        	subw	x,#1
5981  0f96 bf44          	ldw	_apv_cnt_,x
5982                     ; 1073 	if(apv_cnt_==0) 
5984  0f98 be44          	ldw	x,_apv_cnt_
5985  0f9a 2607          	jrne	L5272
5986                     ; 1075 		bAPV=0;
5988  0f9c 72110002      	bres	_bAPV
5989                     ; 1076 		apv_start();
5991  0fa0 cd0ef2        	call	_apv_start
5993  0fa3               L5272:
5994                     ; 1080 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5996  0fa3 be64          	ldw	x,_umin_cnt
5997  0fa5 261e          	jrne	L1372
5999  0fa7 be66          	ldw	x,_umax_cnt
6000  0fa9 261a          	jrne	L1372
6002  0fab c65005        	ld	a,20485
6003  0fae a504          	bcp	a,#4
6004  0fb0 2613          	jrne	L1372
6005                     ; 1082 	if(cnt_apv_off<20)
6007  0fb2 b643          	ld	a,_cnt_apv_off
6008  0fb4 a114          	cp	a,#20
6009  0fb6 240f          	jruge	L7372
6010                     ; 1084 		cnt_apv_off++;
6012  0fb8 3c43          	inc	_cnt_apv_off
6013                     ; 1085 		if(cnt_apv_off>=20)
6015  0fba b643          	ld	a,_cnt_apv_off
6016  0fbc a114          	cp	a,#20
6017  0fbe 2507          	jrult	L7372
6018                     ; 1087 			apv_stop();
6020  0fc0 cd0f1b        	call	_apv_stop
6022  0fc3 2002          	jra	L7372
6023  0fc5               L1372:
6024                     ; 1091 else cnt_apv_off=0;	
6026  0fc5 3f43          	clr	_cnt_apv_off
6027  0fc7               L7372:
6028                     ; 1093 }
6031  0fc7 81            	ret
6034                     	switch	.ubsct
6035  0000               L1472_flags_old:
6036  0000 00            	ds.b	1
6072                     ; 1096 void flags_drv(void)
6072                     ; 1097 {
6073                     	switch	.text
6074  0fc8               _flags_drv:
6078                     ; 1099 if(jp_mode!=jp3) 
6080  0fc8 b64b          	ld	a,_jp_mode
6081  0fca a103          	cp	a,#3
6082  0fcc 2723          	jreq	L1672
6083                     ; 1101 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6085  0fce b60a          	ld	a,_flags
6086  0fd0 a508          	bcp	a,#8
6087  0fd2 2706          	jreq	L7672
6089  0fd4 b600          	ld	a,L1472_flags_old
6090  0fd6 a508          	bcp	a,#8
6091  0fd8 270c          	jreq	L5672
6092  0fda               L7672:
6094  0fda b60a          	ld	a,_flags
6095  0fdc a510          	bcp	a,#16
6096  0fde 2726          	jreq	L3772
6098  0fe0 b600          	ld	a,L1472_flags_old
6099  0fe2 a510          	bcp	a,#16
6100  0fe4 2620          	jrne	L3772
6101  0fe6               L5672:
6102                     ; 1103     		if(link==OFF)apv_start();
6104  0fe6 b663          	ld	a,_link
6105  0fe8 a1aa          	cp	a,#170
6106  0fea 261a          	jrne	L3772
6109  0fec cd0ef2        	call	_apv_start
6111  0fef 2015          	jra	L3772
6112  0ff1               L1672:
6113                     ; 1106 else if(jp_mode==jp3) 
6115  0ff1 b64b          	ld	a,_jp_mode
6116  0ff3 a103          	cp	a,#3
6117  0ff5 260f          	jrne	L3772
6118                     ; 1108 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6120  0ff7 b60a          	ld	a,_flags
6121  0ff9 a508          	bcp	a,#8
6122  0ffb 2709          	jreq	L3772
6124  0ffd b600          	ld	a,L1472_flags_old
6125  0fff a508          	bcp	a,#8
6126  1001 2603          	jrne	L3772
6127                     ; 1110     		apv_start();
6129  1003 cd0ef2        	call	_apv_start
6131  1006               L3772:
6132                     ; 1113 flags_old=flags;
6134  1006 450a00        	mov	L1472_flags_old,_flags
6135                     ; 1115 } 
6138  1009 81            	ret
6172                     ; 1254 char adr_gran(signed short in)
6172                     ; 1255 {
6173                     	switch	.text
6174  100a               _adr_gran:
6176  100a 89            	pushw	x
6177       00000000      OFST:	set	0
6180                     ; 1256 if(in>1000)return 1;
6182  100b 9c            	rvf
6183  100c a303e9        	cpw	x,#1001
6184  100f 2f04          	jrslt	L7103
6187  1011 a601          	ld	a,#1
6189  1013 2011          	jra	L421
6190  1015               L7103:
6191                     ; 1257 else if((in>60)&&(in<140))return 0;
6193  1015 9c            	rvf
6194  1016 1e01          	ldw	x,(OFST+1,sp)
6195  1018 a3003d        	cpw	x,#61
6196  101b 2f0b          	jrslt	L3203
6198  101d 9c            	rvf
6199  101e 1e01          	ldw	x,(OFST+1,sp)
6200  1020 a3008c        	cpw	x,#140
6201  1023 2e03          	jrsge	L3203
6204  1025 4f            	clr	a
6206  1026               L421:
6208  1026 85            	popw	x
6209  1027 81            	ret
6210  1028               L3203:
6211                     ; 1258 else return 100;
6213  1028 a664          	ld	a,#100
6215  102a 20fa          	jra	L421
6244                     ; 1262 void adr_drv_v3(void)
6244                     ; 1263 {
6245                     	switch	.text
6246  102c               _adr_drv_v3:
6248  102c 88            	push	a
6249       00000001      OFST:	set	1
6252                     ; 1269 GPIOB->DDR&=~(1<<0);
6254  102d 72115007      	bres	20487,#0
6255                     ; 1270 GPIOB->CR1&=~(1<<0);
6257  1031 72115008      	bres	20488,#0
6258                     ; 1271 GPIOB->CR2&=~(1<<0);
6260  1035 72115009      	bres	20489,#0
6261                     ; 1272 ADC2->CR2=0x08;
6263  1039 35085402      	mov	21506,#8
6264                     ; 1273 ADC2->CR1=0x40;
6266  103d 35405401      	mov	21505,#64
6267                     ; 1274 ADC2->CSR=0x20+0;
6269  1041 35205400      	mov	21504,#32
6270                     ; 1275 ADC2->CR1|=1;
6272  1045 72105401      	bset	21505,#0
6273                     ; 1276 ADC2->CR1|=1;
6275  1049 72105401      	bset	21505,#0
6276                     ; 1277 adr_drv_stat=1;
6278  104d 35010007      	mov	_adr_drv_stat,#1
6279  1051               L7303:
6280                     ; 1278 while(adr_drv_stat==1);
6283  1051 b607          	ld	a,_adr_drv_stat
6284  1053 a101          	cp	a,#1
6285  1055 27fa          	jreq	L7303
6286                     ; 1280 GPIOB->DDR&=~(1<<1);
6288  1057 72135007      	bres	20487,#1
6289                     ; 1281 GPIOB->CR1&=~(1<<1);
6291  105b 72135008      	bres	20488,#1
6292                     ; 1282 GPIOB->CR2&=~(1<<1);
6294  105f 72135009      	bres	20489,#1
6295                     ; 1283 ADC2->CR2=0x08;
6297  1063 35085402      	mov	21506,#8
6298                     ; 1284 ADC2->CR1=0x40;
6300  1067 35405401      	mov	21505,#64
6301                     ; 1285 ADC2->CSR=0x20+1;
6303  106b 35215400      	mov	21504,#33
6304                     ; 1286 ADC2->CR1|=1;
6306  106f 72105401      	bset	21505,#0
6307                     ; 1287 ADC2->CR1|=1;
6309  1073 72105401      	bset	21505,#0
6310                     ; 1288 adr_drv_stat=3;
6312  1077 35030007      	mov	_adr_drv_stat,#3
6313  107b               L5403:
6314                     ; 1289 while(adr_drv_stat==3);
6317  107b b607          	ld	a,_adr_drv_stat
6318  107d a103          	cp	a,#3
6319  107f 27fa          	jreq	L5403
6320                     ; 1291 GPIOE->DDR&=~(1<<6);
6322  1081 721d5016      	bres	20502,#6
6323                     ; 1292 GPIOE->CR1&=~(1<<6);
6325  1085 721d5017      	bres	20503,#6
6326                     ; 1293 GPIOE->CR2&=~(1<<6);
6328  1089 721d5018      	bres	20504,#6
6329                     ; 1294 ADC2->CR2=0x08;
6331  108d 35085402      	mov	21506,#8
6332                     ; 1295 ADC2->CR1=0x40;
6334  1091 35405401      	mov	21505,#64
6335                     ; 1296 ADC2->CSR=0x20+9;
6337  1095 35295400      	mov	21504,#41
6338                     ; 1297 ADC2->CR1|=1;
6340  1099 72105401      	bset	21505,#0
6341                     ; 1298 ADC2->CR1|=1;
6343  109d 72105401      	bset	21505,#0
6344                     ; 1299 adr_drv_stat=5;
6346  10a1 35050007      	mov	_adr_drv_stat,#5
6347  10a5               L3503:
6348                     ; 1300 while(adr_drv_stat==5);
6351  10a5 b607          	ld	a,_adr_drv_stat
6352  10a7 a105          	cp	a,#5
6353  10a9 27fa          	jreq	L3503
6354                     ; 1304 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6356  10ab 9c            	rvf
6357  10ac ce0005        	ldw	x,_adc_buff_
6358  10af a3022a        	cpw	x,#554
6359  10b2 2f0f          	jrslt	L1603
6361  10b4 9c            	rvf
6362  10b5 ce0005        	ldw	x,_adc_buff_
6363  10b8 a30253        	cpw	x,#595
6364  10bb 2e06          	jrsge	L1603
6367  10bd 725f0002      	clr	_adr
6369  10c1 204c          	jra	L3603
6370  10c3               L1603:
6371                     ; 1305 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6373  10c3 9c            	rvf
6374  10c4 ce0005        	ldw	x,_adc_buff_
6375  10c7 a3036d        	cpw	x,#877
6376  10ca 2f0f          	jrslt	L5603
6378  10cc 9c            	rvf
6379  10cd ce0005        	ldw	x,_adc_buff_
6380  10d0 a30396        	cpw	x,#918
6381  10d3 2e06          	jrsge	L5603
6384  10d5 35010002      	mov	_adr,#1
6386  10d9 2034          	jra	L3603
6387  10db               L5603:
6388                     ; 1306 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6390  10db 9c            	rvf
6391  10dc ce0005        	ldw	x,_adc_buff_
6392  10df a302a3        	cpw	x,#675
6393  10e2 2f0f          	jrslt	L1703
6395  10e4 9c            	rvf
6396  10e5 ce0005        	ldw	x,_adc_buff_
6397  10e8 a302cc        	cpw	x,#716
6398  10eb 2e06          	jrsge	L1703
6401  10ed 35020002      	mov	_adr,#2
6403  10f1 201c          	jra	L3603
6404  10f3               L1703:
6405                     ; 1307 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6407  10f3 9c            	rvf
6408  10f4 ce0005        	ldw	x,_adc_buff_
6409  10f7 a303e3        	cpw	x,#995
6410  10fa 2f0f          	jrslt	L5703
6412  10fc 9c            	rvf
6413  10fd ce0005        	ldw	x,_adc_buff_
6414  1100 a3040c        	cpw	x,#1036
6415  1103 2e06          	jrsge	L5703
6418  1105 35030002      	mov	_adr,#3
6420  1109 2004          	jra	L3603
6421  110b               L5703:
6422                     ; 1308 else adr[0]=5;
6424  110b 35050002      	mov	_adr,#5
6425  110f               L3603:
6426                     ; 1310 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6428  110f 9c            	rvf
6429  1110 ce0007        	ldw	x,_adc_buff_+2
6430  1113 a3022a        	cpw	x,#554
6431  1116 2f0f          	jrslt	L1013
6433  1118 9c            	rvf
6434  1119 ce0007        	ldw	x,_adc_buff_+2
6435  111c a30253        	cpw	x,#595
6436  111f 2e06          	jrsge	L1013
6439  1121 725f0003      	clr	_adr+1
6441  1125 204c          	jra	L3013
6442  1127               L1013:
6443                     ; 1311 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6445  1127 9c            	rvf
6446  1128 ce0007        	ldw	x,_adc_buff_+2
6447  112b a3036d        	cpw	x,#877
6448  112e 2f0f          	jrslt	L5013
6450  1130 9c            	rvf
6451  1131 ce0007        	ldw	x,_adc_buff_+2
6452  1134 a30396        	cpw	x,#918
6453  1137 2e06          	jrsge	L5013
6456  1139 35010003      	mov	_adr+1,#1
6458  113d 2034          	jra	L3013
6459  113f               L5013:
6460                     ; 1312 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6462  113f 9c            	rvf
6463  1140 ce0007        	ldw	x,_adc_buff_+2
6464  1143 a302a3        	cpw	x,#675
6465  1146 2f0f          	jrslt	L1113
6467  1148 9c            	rvf
6468  1149 ce0007        	ldw	x,_adc_buff_+2
6469  114c a302cc        	cpw	x,#716
6470  114f 2e06          	jrsge	L1113
6473  1151 35020003      	mov	_adr+1,#2
6475  1155 201c          	jra	L3013
6476  1157               L1113:
6477                     ; 1313 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6479  1157 9c            	rvf
6480  1158 ce0007        	ldw	x,_adc_buff_+2
6481  115b a303e3        	cpw	x,#995
6482  115e 2f0f          	jrslt	L5113
6484  1160 9c            	rvf
6485  1161 ce0007        	ldw	x,_adc_buff_+2
6486  1164 a3040c        	cpw	x,#1036
6487  1167 2e06          	jrsge	L5113
6490  1169 35030003      	mov	_adr+1,#3
6492  116d 2004          	jra	L3013
6493  116f               L5113:
6494                     ; 1314 else adr[1]=5;
6496  116f 35050003      	mov	_adr+1,#5
6497  1173               L3013:
6498                     ; 1316 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6500  1173 9c            	rvf
6501  1174 ce0017        	ldw	x,_adc_buff_+18
6502  1177 a3022a        	cpw	x,#554
6503  117a 2f0f          	jrslt	L1213
6505  117c 9c            	rvf
6506  117d ce0017        	ldw	x,_adc_buff_+18
6507  1180 a30253        	cpw	x,#595
6508  1183 2e06          	jrsge	L1213
6511  1185 725f0004      	clr	_adr+2
6513  1189 204c          	jra	L3213
6514  118b               L1213:
6515                     ; 1317 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6517  118b 9c            	rvf
6518  118c ce0017        	ldw	x,_adc_buff_+18
6519  118f a3036d        	cpw	x,#877
6520  1192 2f0f          	jrslt	L5213
6522  1194 9c            	rvf
6523  1195 ce0017        	ldw	x,_adc_buff_+18
6524  1198 a30396        	cpw	x,#918
6525  119b 2e06          	jrsge	L5213
6528  119d 35010004      	mov	_adr+2,#1
6530  11a1 2034          	jra	L3213
6531  11a3               L5213:
6532                     ; 1318 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6534  11a3 9c            	rvf
6535  11a4 ce0017        	ldw	x,_adc_buff_+18
6536  11a7 a302a3        	cpw	x,#675
6537  11aa 2f0f          	jrslt	L1313
6539  11ac 9c            	rvf
6540  11ad ce0017        	ldw	x,_adc_buff_+18
6541  11b0 a302cc        	cpw	x,#716
6542  11b3 2e06          	jrsge	L1313
6545  11b5 35020004      	mov	_adr+2,#2
6547  11b9 201c          	jra	L3213
6548  11bb               L1313:
6549                     ; 1319 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6551  11bb 9c            	rvf
6552  11bc ce0017        	ldw	x,_adc_buff_+18
6553  11bf a303e3        	cpw	x,#995
6554  11c2 2f0f          	jrslt	L5313
6556  11c4 9c            	rvf
6557  11c5 ce0017        	ldw	x,_adc_buff_+18
6558  11c8 a3040c        	cpw	x,#1036
6559  11cb 2e06          	jrsge	L5313
6562  11cd 35030004      	mov	_adr+2,#3
6564  11d1 2004          	jra	L3213
6565  11d3               L5313:
6566                     ; 1320 else adr[2]=5;
6568  11d3 35050004      	mov	_adr+2,#5
6569  11d7               L3213:
6570                     ; 1324 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6572  11d7 c60002        	ld	a,_adr
6573  11da a105          	cp	a,#5
6574  11dc 270e          	jreq	L3413
6576  11de c60003        	ld	a,_adr+1
6577  11e1 a105          	cp	a,#5
6578  11e3 2707          	jreq	L3413
6580  11e5 c60004        	ld	a,_adr+2
6581  11e8 a105          	cp	a,#5
6582  11ea 2606          	jrne	L1413
6583  11ec               L3413:
6584                     ; 1327 	adress_error=1;
6586  11ec 35010000      	mov	_adress_error,#1
6588  11f0               L7413:
6589                     ; 1338 }
6592  11f0 84            	pop	a
6593  11f1 81            	ret
6594  11f2               L1413:
6595                     ; 1331 	if(adr[2]&0x02) bps_class=bpsIPS;
6597  11f2 c60004        	ld	a,_adr+2
6598  11f5 a502          	bcp	a,#2
6599  11f7 2706          	jreq	L1513
6602  11f9 35010005      	mov	_bps_class,#1
6604  11fd 2002          	jra	L3513
6605  11ff               L1513:
6606                     ; 1332 	else bps_class=bpsIBEP;
6608  11ff 3f05          	clr	_bps_class
6609  1201               L3513:
6610                     ; 1334 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6612  1201 c60004        	ld	a,_adr+2
6613  1204 a401          	and	a,#1
6614  1206 97            	ld	xl,a
6615  1207 a610          	ld	a,#16
6616  1209 42            	mul	x,a
6617  120a 9f            	ld	a,xl
6618  120b 6b01          	ld	(OFST+0,sp),a
6619  120d c60003        	ld	a,_adr+1
6620  1210 48            	sll	a
6621  1211 48            	sll	a
6622  1212 cb0002        	add	a,_adr
6623  1215 1b01          	add	a,(OFST+0,sp)
6624  1217 c70001        	ld	_adress,a
6625  121a 20d4          	jra	L7413
6685                     ; 1342 void adr_drv_v4(void)
6685                     ; 1343 {
6686                     	switch	.text
6687  121c               _adr_drv_v4:
6689  121c 5209          	subw	sp,#9
6690       00000009      OFST:	set	9
6693                     ; 1349 GPIOB->DDR&=~(1<<0);
6695  121e 72115007      	bres	20487,#0
6696                     ; 1350 GPIOB->CR1&=~(1<<0);
6698  1222 72115008      	bres	20488,#0
6699                     ; 1351 GPIOB->CR2&=~(1<<0);
6701  1226 72115009      	bres	20489,#0
6702                     ; 1352 ADC2->CR2=0x08;
6704  122a 35085402      	mov	21506,#8
6705                     ; 1353 ADC2->CR1=0x40;
6707  122e 35405401      	mov	21505,#64
6708                     ; 1354 ADC2->CSR=0x20+0;
6710  1232 35205400      	mov	21504,#32
6711                     ; 1355 ADC2->CR1|=1;
6713  1236 72105401      	bset	21505,#0
6714                     ; 1356 ADC2->CR1|=1;
6716  123a 72105401      	bset	21505,#0
6717                     ; 1357 adr_drv_stat=1;
6719  123e 35010007      	mov	_adr_drv_stat,#1
6720  1242               L3023:
6721                     ; 1358 while(adr_drv_stat==1);
6724  1242 b607          	ld	a,_adr_drv_stat
6725  1244 a101          	cp	a,#1
6726  1246 27fa          	jreq	L3023
6727                     ; 1360 GPIOB->DDR&=~(1<<1);
6729  1248 72135007      	bres	20487,#1
6730                     ; 1361 GPIOB->CR1&=~(1<<1);
6732  124c 72135008      	bres	20488,#1
6733                     ; 1362 GPIOB->CR2&=~(1<<1);
6735  1250 72135009      	bres	20489,#1
6736                     ; 1363 ADC2->CR2=0x08;
6738  1254 35085402      	mov	21506,#8
6739                     ; 1364 ADC2->CR1=0x40;
6741  1258 35405401      	mov	21505,#64
6742                     ; 1365 ADC2->CSR=0x20+1;
6744  125c 35215400      	mov	21504,#33
6745                     ; 1366 ADC2->CR1|=1;
6747  1260 72105401      	bset	21505,#0
6748                     ; 1367 ADC2->CR1|=1;
6750  1264 72105401      	bset	21505,#0
6751                     ; 1368 adr_drv_stat=3;
6753  1268 35030007      	mov	_adr_drv_stat,#3
6754  126c               L1123:
6755                     ; 1369 while(adr_drv_stat==3);
6758  126c b607          	ld	a,_adr_drv_stat
6759  126e a103          	cp	a,#3
6760  1270 27fa          	jreq	L1123
6761                     ; 1371 GPIOE->DDR&=~(1<<6);
6763  1272 721d5016      	bres	20502,#6
6764                     ; 1372 GPIOE->CR1&=~(1<<6);
6766  1276 721d5017      	bres	20503,#6
6767                     ; 1373 GPIOE->CR2&=~(1<<6);
6769  127a 721d5018      	bres	20504,#6
6770                     ; 1374 ADC2->CR2=0x08;
6772  127e 35085402      	mov	21506,#8
6773                     ; 1375 ADC2->CR1=0x40;
6775  1282 35405401      	mov	21505,#64
6776                     ; 1376 ADC2->CSR=0x20+9;
6778  1286 35295400      	mov	21504,#41
6779                     ; 1377 ADC2->CR1|=1;
6781  128a 72105401      	bset	21505,#0
6782                     ; 1378 ADC2->CR1|=1;
6784  128e 72105401      	bset	21505,#0
6785                     ; 1379 adr_drv_stat=5;
6787  1292 35050007      	mov	_adr_drv_stat,#5
6788  1296               L7123:
6789                     ; 1380 while(adr_drv_stat==5);
6792  1296 b607          	ld	a,_adr_drv_stat
6793  1298 a105          	cp	a,#5
6794  129a 27fa          	jreq	L7123
6795                     ; 1382 aaa[0]=adr_gran(adc_buff_[0]);
6797  129c ce0005        	ldw	x,_adc_buff_
6798  129f cd100a        	call	_adr_gran
6800  12a2 6b07          	ld	(OFST-2,sp),a
6801                     ; 1383 tempSI=adc_buff_[0]/260;
6803  12a4 ce0005        	ldw	x,_adc_buff_
6804  12a7 90ae0104      	ldw	y,#260
6805  12ab cd0000        	call	c_idiv
6807  12ae 1f05          	ldw	(OFST-4,sp),x
6808                     ; 1384 gran(&tempSI,0,3);
6810  12b0 ae0003        	ldw	x,#3
6811  12b3 89            	pushw	x
6812  12b4 5f            	clrw	x
6813  12b5 89            	pushw	x
6814  12b6 96            	ldw	x,sp
6815  12b7 1c0009        	addw	x,#OFST+0
6816  12ba cd0000        	call	_gran
6818  12bd 5b04          	addw	sp,#4
6819                     ; 1385 aaaa[0]=(char)tempSI;
6821  12bf 7b06          	ld	a,(OFST-3,sp)
6822  12c1 6b02          	ld	(OFST-7,sp),a
6823                     ; 1387 aaa[1]=adr_gran(adc_buff_[1]);
6825  12c3 ce0007        	ldw	x,_adc_buff_+2
6826  12c6 cd100a        	call	_adr_gran
6828  12c9 6b08          	ld	(OFST-1,sp),a
6829                     ; 1388 tempSI=adc_buff_[1]/260;
6831  12cb ce0007        	ldw	x,_adc_buff_+2
6832  12ce 90ae0104      	ldw	y,#260
6833  12d2 cd0000        	call	c_idiv
6835  12d5 1f05          	ldw	(OFST-4,sp),x
6836                     ; 1389 gran(&tempSI,0,3);
6838  12d7 ae0003        	ldw	x,#3
6839  12da 89            	pushw	x
6840  12db 5f            	clrw	x
6841  12dc 89            	pushw	x
6842  12dd 96            	ldw	x,sp
6843  12de 1c0009        	addw	x,#OFST+0
6844  12e1 cd0000        	call	_gran
6846  12e4 5b04          	addw	sp,#4
6847                     ; 1390 aaaa[1]=(char)tempSI;
6849  12e6 7b06          	ld	a,(OFST-3,sp)
6850  12e8 6b03          	ld	(OFST-6,sp),a
6851                     ; 1392 aaa[2]=adr_gran(adc_buff_[9]);
6853  12ea ce0017        	ldw	x,_adc_buff_+18
6854  12ed cd100a        	call	_adr_gran
6856  12f0 6b09          	ld	(OFST+0,sp),a
6857                     ; 1393 tempSI=adc_buff_[2]/260;
6859  12f2 ce0009        	ldw	x,_adc_buff_+4
6860  12f5 90ae0104      	ldw	y,#260
6861  12f9 cd0000        	call	c_idiv
6863  12fc 1f05          	ldw	(OFST-4,sp),x
6864                     ; 1394 gran(&tempSI,0,3);
6866  12fe ae0003        	ldw	x,#3
6867  1301 89            	pushw	x
6868  1302 5f            	clrw	x
6869  1303 89            	pushw	x
6870  1304 96            	ldw	x,sp
6871  1305 1c0009        	addw	x,#OFST+0
6872  1308 cd0000        	call	_gran
6874  130b 5b04          	addw	sp,#4
6875                     ; 1395 aaaa[2]=(char)tempSI;
6877  130d 7b06          	ld	a,(OFST-3,sp)
6878  130f 6b04          	ld	(OFST-5,sp),a
6879                     ; 1398 adress=100;
6881  1311 35640001      	mov	_adress,#100
6882                     ; 1401 if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
6884  1315 7b07          	ld	a,(OFST-2,sp)
6885  1317 a164          	cp	a,#100
6886  1319 2734          	jreq	L5223
6888  131b 7b08          	ld	a,(OFST-1,sp)
6889  131d a164          	cp	a,#100
6890  131f 272e          	jreq	L5223
6892  1321 7b09          	ld	a,(OFST+0,sp)
6893  1323 a164          	cp	a,#100
6894  1325 2728          	jreq	L5223
6895                     ; 1403 	if(aaa[0]==0)
6897  1327 0d07          	tnz	(OFST-2,sp)
6898  1329 2610          	jrne	L7223
6899                     ; 1405 		if(aaa[1]==0)adress=3;
6901  132b 0d08          	tnz	(OFST-1,sp)
6902  132d 2606          	jrne	L1323
6905  132f 35030001      	mov	_adress,#3
6907  1333 2046          	jra	L5423
6908  1335               L1323:
6909                     ; 1406 		else adress=0;
6911  1335 725f0001      	clr	_adress
6912  1339 2040          	jra	L5423
6913  133b               L7223:
6914                     ; 1408 	else if(aaa[1]==0)adress=1;	
6916  133b 0d08          	tnz	(OFST-1,sp)
6917  133d 2606          	jrne	L7323
6920  133f 35010001      	mov	_adress,#1
6922  1343 2036          	jra	L5423
6923  1345               L7323:
6924                     ; 1409 	else if(aaa[2]==0)adress=2;
6926  1345 0d09          	tnz	(OFST+0,sp)
6927  1347 2632          	jrne	L5423
6930  1349 35020001      	mov	_adress,#2
6931  134d 202c          	jra	L5423
6932  134f               L5223:
6933                     ; 1413 else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adress=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
6935  134f 7b07          	ld	a,(OFST-2,sp)
6936  1351 a164          	cp	a,#100
6937  1353 2622          	jrne	L7423
6939  1355 7b08          	ld	a,(OFST-1,sp)
6940  1357 a164          	cp	a,#100
6941  1359 261c          	jrne	L7423
6943  135b 7b09          	ld	a,(OFST+0,sp)
6944  135d a164          	cp	a,#100
6945  135f 2616          	jrne	L7423
6948  1361 7b04          	ld	a,(OFST-5,sp)
6949  1363 97            	ld	xl,a
6950  1364 a610          	ld	a,#16
6951  1366 42            	mul	x,a
6952  1367 9f            	ld	a,xl
6953  1368 6b01          	ld	(OFST-8,sp),a
6954  136a 7b03          	ld	a,(OFST-6,sp)
6955  136c 48            	sll	a
6956  136d 48            	sll	a
6957  136e 1b02          	add	a,(OFST-7,sp)
6958  1370 1b01          	add	a,(OFST-8,sp)
6959  1372 c70001        	ld	_adress,a
6961  1375 2004          	jra	L5423
6962  1377               L7423:
6963                     ; 1417 else adress=100;
6965  1377 35640001      	mov	_adress,#100
6966  137b               L5423:
6967                     ; 1419 plazma_adress[0]=aaa[0];
6969  137b 7b07          	ld	a,(OFST-2,sp)
6970  137d 5f            	clrw	x
6971  137e 97            	ld	xl,a
6972  137f bf01          	ldw	_plazma_adress,x
6973                     ; 1420 plazma_adress[1]=aaa[1];
6975  1381 7b08          	ld	a,(OFST-1,sp)
6976  1383 5f            	clrw	x
6977  1384 97            	ld	xl,a
6978  1385 bf03          	ldw	_plazma_adress+2,x
6979                     ; 1421 plazma_adress[2]=aaa[2];
6981  1387 7b09          	ld	a,(OFST+0,sp)
6982  1389 5f            	clrw	x
6983  138a 97            	ld	xl,a
6984  138b bf05          	ldw	_plazma_adress+4,x
6985                     ; 1425 }
6988  138d 5b09          	addw	sp,#9
6989  138f 81            	ret
7033                     ; 1429 void volum_u_main_drv(void)
7033                     ; 1430 {
7034                     	switch	.text
7035  1390               _volum_u_main_drv:
7037  1390 88            	push	a
7038       00000001      OFST:	set	1
7041                     ; 1433 if(bMAIN)
7043                     	btst	_bMAIN
7044  1396 2503          	jrult	L431
7045  1398 cc14e1        	jp	L1723
7046  139b               L431:
7047                     ; 1435 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7049  139b 9c            	rvf
7050  139c ce0006        	ldw	x,_UU_AVT
7051  139f 1d000a        	subw	x,#10
7052  13a2 b36d          	cpw	x,_Un
7053  13a4 2d09          	jrsle	L3723
7056  13a6 be1c          	ldw	x,_volum_u_main_
7057  13a8 1c0005        	addw	x,#5
7058  13ab bf1c          	ldw	_volum_u_main_,x
7060  13ad 2036          	jra	L5723
7061  13af               L3723:
7062                     ; 1436 	else if(Un<(UU_AVT-1))volum_u_main_++;
7064  13af 9c            	rvf
7065  13b0 ce0006        	ldw	x,_UU_AVT
7066  13b3 5a            	decw	x
7067  13b4 b36d          	cpw	x,_Un
7068  13b6 2d09          	jrsle	L7723
7071  13b8 be1c          	ldw	x,_volum_u_main_
7072  13ba 1c0001        	addw	x,#1
7073  13bd bf1c          	ldw	_volum_u_main_,x
7075  13bf 2024          	jra	L5723
7076  13c1               L7723:
7077                     ; 1437 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7079  13c1 9c            	rvf
7080  13c2 ce0006        	ldw	x,_UU_AVT
7081  13c5 1c000a        	addw	x,#10
7082  13c8 b36d          	cpw	x,_Un
7083  13ca 2e09          	jrsge	L3033
7086  13cc be1c          	ldw	x,_volum_u_main_
7087  13ce 1d000a        	subw	x,#10
7088  13d1 bf1c          	ldw	_volum_u_main_,x
7090  13d3 2010          	jra	L5723
7091  13d5               L3033:
7092                     ; 1438 	else if(Un>(UU_AVT+1))volum_u_main_--;
7094  13d5 9c            	rvf
7095  13d6 ce0006        	ldw	x,_UU_AVT
7096  13d9 5c            	incw	x
7097  13da b36d          	cpw	x,_Un
7098  13dc 2e07          	jrsge	L5723
7101  13de be1c          	ldw	x,_volum_u_main_
7102  13e0 1d0001        	subw	x,#1
7103  13e3 bf1c          	ldw	_volum_u_main_,x
7104  13e5               L5723:
7105                     ; 1439 	if(volum_u_main_>1020)volum_u_main_=1020;
7107  13e5 9c            	rvf
7108  13e6 be1c          	ldw	x,_volum_u_main_
7109  13e8 a303fd        	cpw	x,#1021
7110  13eb 2f05          	jrslt	L1133
7113  13ed ae03fc        	ldw	x,#1020
7114  13f0 bf1c          	ldw	_volum_u_main_,x
7115  13f2               L1133:
7116                     ; 1440 	if(volum_u_main_<0)volum_u_main_=0;
7118  13f2 9c            	rvf
7119  13f3 be1c          	ldw	x,_volum_u_main_
7120  13f5 2e03          	jrsge	L3133
7123  13f7 5f            	clrw	x
7124  13f8 bf1c          	ldw	_volum_u_main_,x
7125  13fa               L3133:
7126                     ; 1443 	i_main_sigma=0;
7128  13fa 5f            	clrw	x
7129  13fb bf10          	ldw	_i_main_sigma,x
7130                     ; 1444 	i_main_num_of_bps=0;
7132  13fd 3f12          	clr	_i_main_num_of_bps
7133                     ; 1445 	for(i=0;i<6;i++)
7135  13ff 0f01          	clr	(OFST+0,sp)
7136  1401               L5133:
7137                     ; 1447 		if(i_main_flag[i])
7139  1401 7b01          	ld	a,(OFST+0,sp)
7140  1403 5f            	clrw	x
7141  1404 97            	ld	xl,a
7142  1405 6d15          	tnz	(_i_main_flag,x)
7143  1407 2719          	jreq	L3233
7144                     ; 1449 			i_main_sigma+=i_main[i];
7146  1409 7b01          	ld	a,(OFST+0,sp)
7147  140b 5f            	clrw	x
7148  140c 97            	ld	xl,a
7149  140d 58            	sllw	x
7150  140e ee1b          	ldw	x,(_i_main,x)
7151  1410 72bb0010      	addw	x,_i_main_sigma
7152  1414 bf10          	ldw	_i_main_sigma,x
7153                     ; 1450 			i_main_flag[i]=1;
7155  1416 7b01          	ld	a,(OFST+0,sp)
7156  1418 5f            	clrw	x
7157  1419 97            	ld	xl,a
7158  141a a601          	ld	a,#1
7159  141c e715          	ld	(_i_main_flag,x),a
7160                     ; 1451 			i_main_num_of_bps++;
7162  141e 3c12          	inc	_i_main_num_of_bps
7164  1420 2006          	jra	L5233
7165  1422               L3233:
7166                     ; 1455 			i_main_flag[i]=0;	
7168  1422 7b01          	ld	a,(OFST+0,sp)
7169  1424 5f            	clrw	x
7170  1425 97            	ld	xl,a
7171  1426 6f15          	clr	(_i_main_flag,x)
7172  1428               L5233:
7173                     ; 1445 	for(i=0;i<6;i++)
7175  1428 0c01          	inc	(OFST+0,sp)
7178  142a 7b01          	ld	a,(OFST+0,sp)
7179  142c a106          	cp	a,#6
7180  142e 25d1          	jrult	L5133
7181                     ; 1458 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7183  1430 be10          	ldw	x,_i_main_sigma
7184  1432 b612          	ld	a,_i_main_num_of_bps
7185  1434 905f          	clrw	y
7186  1436 9097          	ld	yl,a
7187  1438 cd0000        	call	c_idiv
7189  143b bf13          	ldw	_i_main_avg,x
7190                     ; 1459 	for(i=0;i<6;i++)
7192  143d 0f01          	clr	(OFST+0,sp)
7193  143f               L7233:
7194                     ; 1461 		if(i_main_flag[i])
7196  143f 7b01          	ld	a,(OFST+0,sp)
7197  1441 5f            	clrw	x
7198  1442 97            	ld	xl,a
7199  1443 6d15          	tnz	(_i_main_flag,x)
7200  1445 2603cc14d6    	jreq	L5333
7201                     ; 1463 			if(i_main[i]<(i_main_avg-10))x[i]++;
7203  144a 9c            	rvf
7204  144b 7b01          	ld	a,(OFST+0,sp)
7205  144d 5f            	clrw	x
7206  144e 97            	ld	xl,a
7207  144f 58            	sllw	x
7208  1450 90be13        	ldw	y,_i_main_avg
7209  1453 72a2000a      	subw	y,#10
7210  1457 90bf00        	ldw	c_y,y
7211  145a 9093          	ldw	y,x
7212  145c 90ee1b        	ldw	y,(_i_main,y)
7213  145f 90b300        	cpw	y,c_y
7214  1462 2e11          	jrsge	L7333
7217  1464 7b01          	ld	a,(OFST+0,sp)
7218  1466 5f            	clrw	x
7219  1467 97            	ld	xl,a
7220  1468 58            	sllw	x
7221  1469 9093          	ldw	y,x
7222  146b ee27          	ldw	x,(_x,x)
7223  146d 1c0001        	addw	x,#1
7224  1470 90ef27        	ldw	(_x,y),x
7226  1473 2029          	jra	L1433
7227  1475               L7333:
7228                     ; 1464 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7230  1475 9c            	rvf
7231  1476 7b01          	ld	a,(OFST+0,sp)
7232  1478 5f            	clrw	x
7233  1479 97            	ld	xl,a
7234  147a 58            	sllw	x
7235  147b 90be13        	ldw	y,_i_main_avg
7236  147e 72a9000a      	addw	y,#10
7237  1482 90bf00        	ldw	c_y,y
7238  1485 9093          	ldw	y,x
7239  1487 90ee1b        	ldw	y,(_i_main,y)
7240  148a 90b300        	cpw	y,c_y
7241  148d 2d0f          	jrsle	L1433
7244  148f 7b01          	ld	a,(OFST+0,sp)
7245  1491 5f            	clrw	x
7246  1492 97            	ld	xl,a
7247  1493 58            	sllw	x
7248  1494 9093          	ldw	y,x
7249  1496 ee27          	ldw	x,(_x,x)
7250  1498 1d0001        	subw	x,#1
7251  149b 90ef27        	ldw	(_x,y),x
7252  149e               L1433:
7253                     ; 1465 			if(x[i]>100)x[i]=100;
7255  149e 9c            	rvf
7256  149f 7b01          	ld	a,(OFST+0,sp)
7257  14a1 5f            	clrw	x
7258  14a2 97            	ld	xl,a
7259  14a3 58            	sllw	x
7260  14a4 9093          	ldw	y,x
7261  14a6 90ee27        	ldw	y,(_x,y)
7262  14a9 90a30065      	cpw	y,#101
7263  14ad 2f0b          	jrslt	L5433
7266  14af 7b01          	ld	a,(OFST+0,sp)
7267  14b1 5f            	clrw	x
7268  14b2 97            	ld	xl,a
7269  14b3 58            	sllw	x
7270  14b4 90ae0064      	ldw	y,#100
7271  14b8 ef27          	ldw	(_x,x),y
7272  14ba               L5433:
7273                     ; 1466 			if(x[i]<-100)x[i]=-100;
7275  14ba 9c            	rvf
7276  14bb 7b01          	ld	a,(OFST+0,sp)
7277  14bd 5f            	clrw	x
7278  14be 97            	ld	xl,a
7279  14bf 58            	sllw	x
7280  14c0 9093          	ldw	y,x
7281  14c2 90ee27        	ldw	y,(_x,y)
7282  14c5 90a3ff9c      	cpw	y,#65436
7283  14c9 2e0b          	jrsge	L5333
7286  14cb 7b01          	ld	a,(OFST+0,sp)
7287  14cd 5f            	clrw	x
7288  14ce 97            	ld	xl,a
7289  14cf 58            	sllw	x
7290  14d0 90aeff9c      	ldw	y,#65436
7291  14d4 ef27          	ldw	(_x,x),y
7292  14d6               L5333:
7293                     ; 1459 	for(i=0;i<6;i++)
7295  14d6 0c01          	inc	(OFST+0,sp)
7298  14d8 7b01          	ld	a,(OFST+0,sp)
7299  14da a106          	cp	a,#6
7300  14dc 2403cc143f    	jrult	L7233
7301  14e1               L1723:
7302                     ; 1473 }
7305  14e1 84            	pop	a
7306  14e2 81            	ret
7329                     ; 1476 void init_CAN(void) {
7330                     	switch	.text
7331  14e3               _init_CAN:
7335                     ; 1477 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7337  14e3 72135420      	bres	21536,#1
7338                     ; 1478 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7340  14e7 72105420      	bset	21536,#0
7342  14eb               L3633:
7343                     ; 1479 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7345  14eb c65421        	ld	a,21537
7346  14ee a501          	bcp	a,#1
7347  14f0 27f9          	jreq	L3633
7348                     ; 1481 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7350  14f2 72185420      	bset	21536,#4
7351                     ; 1483 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7353  14f6 35025427      	mov	21543,#2
7354                     ; 1492 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7356  14fa 35135428      	mov	21544,#19
7357                     ; 1493 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7359  14fe 35c05429      	mov	21545,#192
7360                     ; 1494 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7362  1502 357f542c      	mov	21548,#127
7363                     ; 1495 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7365  1506 35e0542d      	mov	21549,#224
7366                     ; 1497 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7368  150a 35315430      	mov	21552,#49
7369                     ; 1498 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7371  150e 35c05431      	mov	21553,#192
7372                     ; 1499 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7374  1512 357f5434      	mov	21556,#127
7375                     ; 1500 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7377  1516 35e05435      	mov	21557,#224
7378                     ; 1504 	CAN->PSR= 6;									// set page 6
7380  151a 35065427      	mov	21543,#6
7381                     ; 1509 	CAN->Page.Config.FMR1&=~3;								//mask mode
7383  151e c65430        	ld	a,21552
7384  1521 a4fc          	and	a,#252
7385  1523 c75430        	ld	21552,a
7386                     ; 1515 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7388  1526 35065432      	mov	21554,#6
7389                     ; 1516 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7391  152a 35605432      	mov	21554,#96
7392                     ; 1519 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7394  152e 72105432      	bset	21554,#0
7395                     ; 1520 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7397  1532 72185432      	bset	21554,#4
7398                     ; 1523 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7400  1536 35065427      	mov	21543,#6
7401                     ; 1525 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7403  153a 3509542c      	mov	21548,#9
7404                     ; 1526 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7406  153e 35e7542d      	mov	21549,#231
7407                     ; 1528 	CAN->IER|=(1<<1);
7409  1542 72125425      	bset	21541,#1
7410                     ; 1531 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7412  1546 72115420      	bres	21536,#0
7414  154a               L1733:
7415                     ; 1532 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7417  154a c65421        	ld	a,21537
7418  154d a501          	bcp	a,#1
7419  154f 26f9          	jrne	L1733
7420                     ; 1533 }
7423  1551 81            	ret
7531                     ; 1536 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7531                     ; 1537 {
7532                     	switch	.text
7533  1552               _can_transmit:
7535  1552 89            	pushw	x
7536       00000000      OFST:	set	0
7539                     ; 1539 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7541  1553 b674          	ld	a,_can_buff_wr_ptr
7542  1555 a104          	cp	a,#4
7543  1557 2502          	jrult	L3543
7546  1559 3f74          	clr	_can_buff_wr_ptr
7547  155b               L3543:
7548                     ; 1541 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7550  155b b674          	ld	a,_can_buff_wr_ptr
7551  155d 97            	ld	xl,a
7552  155e a610          	ld	a,#16
7553  1560 42            	mul	x,a
7554  1561 1601          	ldw	y,(OFST+1,sp)
7555  1563 a606          	ld	a,#6
7556  1565               L241:
7557  1565 9054          	srlw	y
7558  1567 4a            	dec	a
7559  1568 26fb          	jrne	L241
7560  156a 909f          	ld	a,yl
7561  156c e775          	ld	(_can_out_buff,x),a
7562                     ; 1542 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7564  156e b674          	ld	a,_can_buff_wr_ptr
7565  1570 97            	ld	xl,a
7566  1571 a610          	ld	a,#16
7567  1573 42            	mul	x,a
7568  1574 7b02          	ld	a,(OFST+2,sp)
7569  1576 48            	sll	a
7570  1577 48            	sll	a
7571  1578 e776          	ld	(_can_out_buff+1,x),a
7572                     ; 1544 can_out_buff[can_buff_wr_ptr][2]=data0;
7574  157a b674          	ld	a,_can_buff_wr_ptr
7575  157c 97            	ld	xl,a
7576  157d a610          	ld	a,#16
7577  157f 42            	mul	x,a
7578  1580 7b05          	ld	a,(OFST+5,sp)
7579  1582 e777          	ld	(_can_out_buff+2,x),a
7580                     ; 1545 can_out_buff[can_buff_wr_ptr][3]=data1;
7582  1584 b674          	ld	a,_can_buff_wr_ptr
7583  1586 97            	ld	xl,a
7584  1587 a610          	ld	a,#16
7585  1589 42            	mul	x,a
7586  158a 7b06          	ld	a,(OFST+6,sp)
7587  158c e778          	ld	(_can_out_buff+3,x),a
7588                     ; 1546 can_out_buff[can_buff_wr_ptr][4]=data2;
7590  158e b674          	ld	a,_can_buff_wr_ptr
7591  1590 97            	ld	xl,a
7592  1591 a610          	ld	a,#16
7593  1593 42            	mul	x,a
7594  1594 7b07          	ld	a,(OFST+7,sp)
7595  1596 e779          	ld	(_can_out_buff+4,x),a
7596                     ; 1547 can_out_buff[can_buff_wr_ptr][5]=data3;
7598  1598 b674          	ld	a,_can_buff_wr_ptr
7599  159a 97            	ld	xl,a
7600  159b a610          	ld	a,#16
7601  159d 42            	mul	x,a
7602  159e 7b08          	ld	a,(OFST+8,sp)
7603  15a0 e77a          	ld	(_can_out_buff+5,x),a
7604                     ; 1548 can_out_buff[can_buff_wr_ptr][6]=data4;
7606  15a2 b674          	ld	a,_can_buff_wr_ptr
7607  15a4 97            	ld	xl,a
7608  15a5 a610          	ld	a,#16
7609  15a7 42            	mul	x,a
7610  15a8 7b09          	ld	a,(OFST+9,sp)
7611  15aa e77b          	ld	(_can_out_buff+6,x),a
7612                     ; 1549 can_out_buff[can_buff_wr_ptr][7]=data5;
7614  15ac b674          	ld	a,_can_buff_wr_ptr
7615  15ae 97            	ld	xl,a
7616  15af a610          	ld	a,#16
7617  15b1 42            	mul	x,a
7618  15b2 7b0a          	ld	a,(OFST+10,sp)
7619  15b4 e77c          	ld	(_can_out_buff+7,x),a
7620                     ; 1550 can_out_buff[can_buff_wr_ptr][8]=data6;
7622  15b6 b674          	ld	a,_can_buff_wr_ptr
7623  15b8 97            	ld	xl,a
7624  15b9 a610          	ld	a,#16
7625  15bb 42            	mul	x,a
7626  15bc 7b0b          	ld	a,(OFST+11,sp)
7627  15be e77d          	ld	(_can_out_buff+8,x),a
7628                     ; 1551 can_out_buff[can_buff_wr_ptr][9]=data7;
7630  15c0 b674          	ld	a,_can_buff_wr_ptr
7631  15c2 97            	ld	xl,a
7632  15c3 a610          	ld	a,#16
7633  15c5 42            	mul	x,a
7634  15c6 7b0c          	ld	a,(OFST+12,sp)
7635  15c8 e77e          	ld	(_can_out_buff+9,x),a
7636                     ; 1553 can_buff_wr_ptr++;
7638  15ca 3c74          	inc	_can_buff_wr_ptr
7639                     ; 1554 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7641  15cc b674          	ld	a,_can_buff_wr_ptr
7642  15ce a104          	cp	a,#4
7643  15d0 2502          	jrult	L5543
7646  15d2 3f74          	clr	_can_buff_wr_ptr
7647  15d4               L5543:
7648                     ; 1555 } 
7651  15d4 85            	popw	x
7652  15d5 81            	ret
7681                     ; 1558 void can_tx_hndl(void)
7681                     ; 1559 {
7682                     	switch	.text
7683  15d6               _can_tx_hndl:
7687                     ; 1560 if(bTX_FREE)
7689  15d6 3d08          	tnz	_bTX_FREE
7690  15d8 2757          	jreq	L7643
7691                     ; 1562 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7693  15da b673          	ld	a,_can_buff_rd_ptr
7694  15dc b174          	cp	a,_can_buff_wr_ptr
7695  15de 275f          	jreq	L5743
7696                     ; 1564 		bTX_FREE=0;
7698  15e0 3f08          	clr	_bTX_FREE
7699                     ; 1566 		CAN->PSR= 0;
7701  15e2 725f5427      	clr	21543
7702                     ; 1567 		CAN->Page.TxMailbox.MDLCR=8;
7704  15e6 35085429      	mov	21545,#8
7705                     ; 1568 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7707  15ea b673          	ld	a,_can_buff_rd_ptr
7708  15ec 97            	ld	xl,a
7709  15ed a610          	ld	a,#16
7710  15ef 42            	mul	x,a
7711  15f0 e675          	ld	a,(_can_out_buff,x)
7712  15f2 c7542a        	ld	21546,a
7713                     ; 1569 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7715  15f5 b673          	ld	a,_can_buff_rd_ptr
7716  15f7 97            	ld	xl,a
7717  15f8 a610          	ld	a,#16
7718  15fa 42            	mul	x,a
7719  15fb e676          	ld	a,(_can_out_buff+1,x)
7720  15fd c7542b        	ld	21547,a
7721                     ; 1571 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7723  1600 b673          	ld	a,_can_buff_rd_ptr
7724  1602 97            	ld	xl,a
7725  1603 a610          	ld	a,#16
7726  1605 42            	mul	x,a
7727  1606 01            	rrwa	x,a
7728  1607 ab77          	add	a,#_can_out_buff+2
7729  1609 2401          	jrnc	L641
7730  160b 5c            	incw	x
7731  160c               L641:
7732  160c 5f            	clrw	x
7733  160d 97            	ld	xl,a
7734  160e bf00          	ldw	c_x,x
7735  1610 ae0008        	ldw	x,#8
7736  1613               L051:
7737  1613 5a            	decw	x
7738  1614 92d600        	ld	a,([c_x],x)
7739  1617 d7542e        	ld	(21550,x),a
7740  161a 5d            	tnzw	x
7741  161b 26f6          	jrne	L051
7742                     ; 1573 		can_buff_rd_ptr++;
7744  161d 3c73          	inc	_can_buff_rd_ptr
7745                     ; 1574 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7747  161f b673          	ld	a,_can_buff_rd_ptr
7748  1621 a104          	cp	a,#4
7749  1623 2502          	jrult	L3743
7752  1625 3f73          	clr	_can_buff_rd_ptr
7753  1627               L3743:
7754                     ; 1576 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7756  1627 72105428      	bset	21544,#0
7757                     ; 1577 		CAN->IER|=(1<<0);
7759  162b 72105425      	bset	21541,#0
7760  162f 200e          	jra	L5743
7761  1631               L7643:
7762                     ; 1582 	tx_busy_cnt++;
7764  1631 3c72          	inc	_tx_busy_cnt
7765                     ; 1583 	if(tx_busy_cnt>=100)
7767  1633 b672          	ld	a,_tx_busy_cnt
7768  1635 a164          	cp	a,#100
7769  1637 2506          	jrult	L5743
7770                     ; 1585 		tx_busy_cnt=0;
7772  1639 3f72          	clr	_tx_busy_cnt
7773                     ; 1586 		bTX_FREE=1;
7775  163b 35010008      	mov	_bTX_FREE,#1
7776  163f               L5743:
7777                     ; 1589 }
7780  163f 81            	ret
7819                     ; 1592 void net_drv(void)
7819                     ; 1593 { 
7820                     	switch	.text
7821  1640               _net_drv:
7825                     ; 1595 if(bMAIN)
7827                     	btst	_bMAIN
7828  1645 2503          	jrult	L451
7829  1647 cc16ed        	jp	L1153
7830  164a               L451:
7831                     ; 1597 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7833  164a 3c33          	inc	_cnt_net_drv
7834  164c b633          	ld	a,_cnt_net_drv
7835  164e a107          	cp	a,#7
7836  1650 2502          	jrult	L3153
7839  1652 3f33          	clr	_cnt_net_drv
7840  1654               L3153:
7841                     ; 1599 	if(cnt_net_drv<=5) 
7843  1654 b633          	ld	a,_cnt_net_drv
7844  1656 a106          	cp	a,#6
7845  1658 244c          	jruge	L5153
7846                     ; 1601 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7848  165a 4be8          	push	#232
7849  165c 4be8          	push	#232
7850  165e b633          	ld	a,_cnt_net_drv
7851  1660 5f            	clrw	x
7852  1661 97            	ld	xl,a
7853  1662 58            	sllw	x
7854  1663 ee27          	ldw	x,(_x,x)
7855  1665 72bb001c      	addw	x,_volum_u_main_
7856  1669 90ae0100      	ldw	y,#256
7857  166d cd0000        	call	c_idiv
7859  1670 9f            	ld	a,xl
7860  1671 88            	push	a
7861  1672 b633          	ld	a,_cnt_net_drv
7862  1674 5f            	clrw	x
7863  1675 97            	ld	xl,a
7864  1676 58            	sllw	x
7865  1677 e628          	ld	a,(_x+1,x)
7866  1679 bb1d          	add	a,_volum_u_main_+1
7867  167b 88            	push	a
7868  167c 4b00          	push	#0
7869  167e 4bed          	push	#237
7870  1680 3b0033        	push	_cnt_net_drv
7871  1683 3b0033        	push	_cnt_net_drv
7872  1686 ae009e        	ldw	x,#158
7873  1689 cd1552        	call	_can_transmit
7875  168c 5b08          	addw	sp,#8
7876                     ; 1602 		i_main_bps_cnt[cnt_net_drv]++;
7878  168e b633          	ld	a,_cnt_net_drv
7879  1690 5f            	clrw	x
7880  1691 97            	ld	xl,a
7881  1692 6c0a          	inc	(_i_main_bps_cnt,x)
7882                     ; 1603 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7884  1694 b633          	ld	a,_cnt_net_drv
7885  1696 5f            	clrw	x
7886  1697 97            	ld	xl,a
7887  1698 e60a          	ld	a,(_i_main_bps_cnt,x)
7888  169a a10b          	cp	a,#11
7889  169c 254f          	jrult	L1153
7892  169e b633          	ld	a,_cnt_net_drv
7893  16a0 5f            	clrw	x
7894  16a1 97            	ld	xl,a
7895  16a2 6f15          	clr	(_i_main_flag,x)
7896  16a4 2047          	jra	L1153
7897  16a6               L5153:
7898                     ; 1605 	else if(cnt_net_drv==6)
7900  16a6 b633          	ld	a,_cnt_net_drv
7901  16a8 a106          	cp	a,#6
7902  16aa 2641          	jrne	L1153
7903                     ; 1607 		plazma_int[2]=pwm_u;
7905  16ac be0b          	ldw	x,_pwm_u
7906  16ae bf38          	ldw	_plazma_int+4,x
7907                     ; 1608 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7909  16b0 3b006b        	push	_Ui
7910  16b3 3b006c        	push	_Ui+1
7911  16b6 3b006d        	push	_Un
7912  16b9 3b006e        	push	_Un+1
7913  16bc 3b006f        	push	_I
7914  16bf 3b0070        	push	_I+1
7915  16c2 4bda          	push	#218
7916  16c4 3b0001        	push	_adress
7917  16c7 ae018e        	ldw	x,#398
7918  16ca cd1552        	call	_can_transmit
7920  16cd 5b08          	addw	sp,#8
7921                     ; 1609 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7923  16cf 3b0038        	push	_plazma_int+4
7924  16d2 3b0039        	push	_plazma_int+5
7925  16d5 3b0060        	push	__x_+1
7926  16d8 3b000a        	push	_flags
7927  16db 4b00          	push	#0
7928  16dd 3b0068        	push	_T
7929  16e0 4bdb          	push	#219
7930  16e2 3b0001        	push	_adress
7931  16e5 ae018e        	ldw	x,#398
7932  16e8 cd1552        	call	_can_transmit
7934  16eb 5b08          	addw	sp,#8
7935  16ed               L1153:
7936                     ; 1612 }
7939  16ed 81            	ret
8049                     ; 1615 void can_in_an(void)
8049                     ; 1616 {
8050                     	switch	.text
8051  16ee               _can_in_an:
8053  16ee 5205          	subw	sp,#5
8054       00000005      OFST:	set	5
8057                     ; 1626 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8059  16f0 b6ca          	ld	a,_mess+6
8060  16f2 c10001        	cp	a,_adress
8061  16f5 2703          	jreq	L002
8062  16f7 cc1804        	jp	L1653
8063  16fa               L002:
8065  16fa b6cb          	ld	a,_mess+7
8066  16fc c10001        	cp	a,_adress
8067  16ff 2703          	jreq	L202
8068  1701 cc1804        	jp	L1653
8069  1704               L202:
8071  1704 b6cc          	ld	a,_mess+8
8072  1706 a1ed          	cp	a,#237
8073  1708 2703          	jreq	L402
8074  170a cc1804        	jp	L1653
8075  170d               L402:
8076                     ; 1629 	can_error_cnt=0;
8078  170d 3f71          	clr	_can_error_cnt
8079                     ; 1631 	bMAIN=0;
8081  170f 72110001      	bres	_bMAIN
8082                     ; 1632  	flags_tu=mess[9];
8084  1713 45cd61        	mov	_flags_tu,_mess+9
8085                     ; 1633  	if(flags_tu&0b00000001)
8087  1716 b661          	ld	a,_flags_tu
8088  1718 a501          	bcp	a,#1
8089  171a 2706          	jreq	L3653
8090                     ; 1638  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8092  171c 721a000a      	bset	_flags,#5
8094  1720 200e          	jra	L5653
8095  1722               L3653:
8096                     ; 1649  				flags&=0b11011111; 
8098  1722 721b000a      	bres	_flags,#5
8099                     ; 1650  				off_bp_cnt=5*ee_TZAS;
8101  1726 c60015        	ld	a,_ee_TZAS+1
8102  1729 97            	ld	xl,a
8103  172a a605          	ld	a,#5
8104  172c 42            	mul	x,a
8105  172d 9f            	ld	a,xl
8106  172e b754          	ld	_off_bp_cnt,a
8107  1730               L5653:
8108                     ; 1656  	if(flags_tu&0b00000010) flags|=0b01000000;
8110  1730 b661          	ld	a,_flags_tu
8111  1732 a502          	bcp	a,#2
8112  1734 2706          	jreq	L7653
8115  1736 721c000a      	bset	_flags,#6
8117  173a 2004          	jra	L1753
8118  173c               L7653:
8119                     ; 1657  	else flags&=0b10111111; 
8121  173c 721d000a      	bres	_flags,#6
8122  1740               L1753:
8123                     ; 1659  	vol_u_temp=mess[10]+mess[11]*256;
8125  1740 b6cf          	ld	a,_mess+11
8126  1742 5f            	clrw	x
8127  1743 97            	ld	xl,a
8128  1744 4f            	clr	a
8129  1745 02            	rlwa	x,a
8130  1746 01            	rrwa	x,a
8131  1747 bbce          	add	a,_mess+10
8132  1749 2401          	jrnc	L061
8133  174b 5c            	incw	x
8134  174c               L061:
8135  174c b75a          	ld	_vol_u_temp+1,a
8136  174e 9f            	ld	a,xl
8137  174f b759          	ld	_vol_u_temp,a
8138                     ; 1660  	vol_i_temp=mess[12]+mess[13]*256;  
8140  1751 b6d1          	ld	a,_mess+13
8141  1753 5f            	clrw	x
8142  1754 97            	ld	xl,a
8143  1755 4f            	clr	a
8144  1756 02            	rlwa	x,a
8145  1757 01            	rrwa	x,a
8146  1758 bbd0          	add	a,_mess+12
8147  175a 2401          	jrnc	L261
8148  175c 5c            	incw	x
8149  175d               L261:
8150  175d b758          	ld	_vol_i_temp+1,a
8151  175f 9f            	ld	a,xl
8152  1760 b757          	ld	_vol_i_temp,a
8153                     ; 1669 	plazma_int[2]=T;
8155  1762 5f            	clrw	x
8156  1763 b668          	ld	a,_T
8157  1765 2a01          	jrpl	L461
8158  1767 53            	cplw	x
8159  1768               L461:
8160  1768 97            	ld	xl,a
8161  1769 bf38          	ldw	_plazma_int+4,x
8162                     ; 1670  	rotor_int=flags_tu+(((short)flags)<<8);
8164  176b b60a          	ld	a,_flags
8165  176d 5f            	clrw	x
8166  176e 97            	ld	xl,a
8167  176f 4f            	clr	a
8168  1770 02            	rlwa	x,a
8169  1771 01            	rrwa	x,a
8170  1772 bb61          	add	a,_flags_tu
8171  1774 2401          	jrnc	L661
8172  1776 5c            	incw	x
8173  1777               L661:
8174  1777 b71b          	ld	_rotor_int+1,a
8175  1779 9f            	ld	a,xl
8176  177a b71a          	ld	_rotor_int,a
8177                     ; 1671 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8179  177c 3b006b        	push	_Ui
8180  177f 3b006c        	push	_Ui+1
8181  1782 3b006d        	push	_Un
8182  1785 3b006e        	push	_Un+1
8183  1788 3b006f        	push	_I
8184  178b 3b0070        	push	_I+1
8185  178e 4bda          	push	#218
8186  1790 3b0001        	push	_adress
8187  1793 ae018e        	ldw	x,#398
8188  1796 cd1552        	call	_can_transmit
8190  1799 5b08          	addw	sp,#8
8191                     ; 1672 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8193  179b 3b0038        	push	_plazma_int+4
8194  179e 3b0039        	push	_plazma_int+5
8195  17a1 3b0060        	push	__x_+1
8196  17a4 3b000a        	push	_flags
8197  17a7 4b00          	push	#0
8198  17a9 3b0068        	push	_T
8199  17ac 4bdb          	push	#219
8200  17ae 3b0001        	push	_adress
8201  17b1 ae018e        	ldw	x,#398
8202  17b4 cd1552        	call	_can_transmit
8204  17b7 5b08          	addw	sp,#8
8205                     ; 1673      link_cnt=0;
8207  17b9 3f62          	clr	_link_cnt
8208                     ; 1674      link=ON;
8210  17bb 35550063      	mov	_link,#85
8211                     ; 1676      if(flags_tu&0b10000000)
8213  17bf b661          	ld	a,_flags_tu
8214  17c1 a580          	bcp	a,#128
8215  17c3 2716          	jreq	L3753
8216                     ; 1678      	if(!res_fl)
8218  17c5 725d0009      	tnz	_res_fl
8219  17c9 2625          	jrne	L7753
8220                     ; 1680      		res_fl=1;
8222  17cb a601          	ld	a,#1
8223  17cd ae0009        	ldw	x,#_res_fl
8224  17d0 cd0000        	call	c_eewrc
8226                     ; 1681      		bRES=1;
8228  17d3 3501000f      	mov	_bRES,#1
8229                     ; 1682      		res_fl_cnt=0;
8231  17d7 3f42          	clr	_res_fl_cnt
8232  17d9 2015          	jra	L7753
8233  17db               L3753:
8234                     ; 1687      	if(main_cnt>20)
8236  17db 9c            	rvf
8237  17dc be52          	ldw	x,_main_cnt
8238  17de a30015        	cpw	x,#21
8239  17e1 2f0d          	jrslt	L7753
8240                     ; 1689     			if(res_fl)
8242  17e3 725d0009      	tnz	_res_fl
8243  17e7 2707          	jreq	L7753
8244                     ; 1691      			res_fl=0;
8246  17e9 4f            	clr	a
8247  17ea ae0009        	ldw	x,#_res_fl
8248  17ed cd0000        	call	c_eewrc
8250  17f0               L7753:
8251                     ; 1696       if(res_fl_)
8253  17f0 725d0008      	tnz	_res_fl_
8254  17f4 2603          	jrne	L602
8255  17f6 cc1d27        	jp	L5253
8256  17f9               L602:
8257                     ; 1698       	res_fl_=0;
8259  17f9 4f            	clr	a
8260  17fa ae0008        	ldw	x,#_res_fl_
8261  17fd cd0000        	call	c_eewrc
8263  1800 ac271d27      	jpf	L5253
8264  1804               L1653:
8265                     ; 1701 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8267  1804 b6ca          	ld	a,_mess+6
8268  1806 c10001        	cp	a,_adress
8269  1809 2703          	jreq	L012
8270  180b cc1a1a        	jp	L1163
8271  180e               L012:
8273  180e b6cb          	ld	a,_mess+7
8274  1810 c10001        	cp	a,_adress
8275  1813 2703          	jreq	L212
8276  1815 cc1a1a        	jp	L1163
8277  1818               L212:
8279  1818 b6cc          	ld	a,_mess+8
8280  181a a1ee          	cp	a,#238
8281  181c 2703          	jreq	L412
8282  181e cc1a1a        	jp	L1163
8283  1821               L412:
8285  1821 b6cd          	ld	a,_mess+9
8286  1823 b1ce          	cp	a,_mess+10
8287  1825 2703          	jreq	L612
8288  1827 cc1a1a        	jp	L1163
8289  182a               L612:
8290                     ; 1703 	rotor_int++;
8292  182a be1a          	ldw	x,_rotor_int
8293  182c 1c0001        	addw	x,#1
8294  182f bf1a          	ldw	_rotor_int,x
8295                     ; 1704 	if((mess[9]&0xf0)==0x20)
8297  1831 b6cd          	ld	a,_mess+9
8298  1833 a4f0          	and	a,#240
8299  1835 a120          	cp	a,#32
8300  1837 2673          	jrne	L3163
8301                     ; 1706 		if((mess[9]&0x0f)==0x01)
8303  1839 b6cd          	ld	a,_mess+9
8304  183b a40f          	and	a,#15
8305  183d a101          	cp	a,#1
8306  183f 260d          	jrne	L5163
8307                     ; 1708 			ee_K[0][0]=adc_buff_[4];
8309  1841 ce000d        	ldw	x,_adc_buff_+8
8310  1844 89            	pushw	x
8311  1845 ae0018        	ldw	x,#_ee_K
8312  1848 cd0000        	call	c_eewrw
8314  184b 85            	popw	x
8316  184c 204a          	jra	L7163
8317  184e               L5163:
8318                     ; 1710 		else if((mess[9]&0x0f)==0x02)
8320  184e b6cd          	ld	a,_mess+9
8321  1850 a40f          	and	a,#15
8322  1852 a102          	cp	a,#2
8323  1854 260b          	jrne	L1263
8324                     ; 1712 			ee_K[0][1]++;
8326  1856 ce001a        	ldw	x,_ee_K+2
8327  1859 1c0001        	addw	x,#1
8328  185c cf001a        	ldw	_ee_K+2,x
8330  185f 2037          	jra	L7163
8331  1861               L1263:
8332                     ; 1714 		else if((mess[9]&0x0f)==0x03)
8334  1861 b6cd          	ld	a,_mess+9
8335  1863 a40f          	and	a,#15
8336  1865 a103          	cp	a,#3
8337  1867 260b          	jrne	L5263
8338                     ; 1716 			ee_K[0][1]+=10;
8340  1869 ce001a        	ldw	x,_ee_K+2
8341  186c 1c000a        	addw	x,#10
8342  186f cf001a        	ldw	_ee_K+2,x
8344  1872 2024          	jra	L7163
8345  1874               L5263:
8346                     ; 1718 		else if((mess[9]&0x0f)==0x04)
8348  1874 b6cd          	ld	a,_mess+9
8349  1876 a40f          	and	a,#15
8350  1878 a104          	cp	a,#4
8351  187a 260b          	jrne	L1363
8352                     ; 1720 			ee_K[0][1]--;
8354  187c ce001a        	ldw	x,_ee_K+2
8355  187f 1d0001        	subw	x,#1
8356  1882 cf001a        	ldw	_ee_K+2,x
8358  1885 2011          	jra	L7163
8359  1887               L1363:
8360                     ; 1722 		else if((mess[9]&0x0f)==0x05)
8362  1887 b6cd          	ld	a,_mess+9
8363  1889 a40f          	and	a,#15
8364  188b a105          	cp	a,#5
8365  188d 2609          	jrne	L7163
8366                     ; 1724 			ee_K[0][1]-=10;
8368  188f ce001a        	ldw	x,_ee_K+2
8369  1892 1d000a        	subw	x,#10
8370  1895 cf001a        	ldw	_ee_K+2,x
8371  1898               L7163:
8372                     ; 1726 		granee(&ee_K[0][1],50,3000);									
8374  1898 ae0bb8        	ldw	x,#3000
8375  189b 89            	pushw	x
8376  189c ae0032        	ldw	x,#50
8377  189f 89            	pushw	x
8378  18a0 ae001a        	ldw	x,#_ee_K+2
8379  18a3 cd0021        	call	_granee
8381  18a6 5b04          	addw	sp,#4
8383  18a8 ac001a00      	jpf	L7363
8384  18ac               L3163:
8385                     ; 1728 	else if((mess[9]&0xf0)==0x10)
8387  18ac b6cd          	ld	a,_mess+9
8388  18ae a4f0          	and	a,#240
8389  18b0 a110          	cp	a,#16
8390  18b2 2673          	jrne	L1463
8391                     ; 1730 		if((mess[9]&0x0f)==0x01)
8393  18b4 b6cd          	ld	a,_mess+9
8394  18b6 a40f          	and	a,#15
8395  18b8 a101          	cp	a,#1
8396  18ba 260d          	jrne	L3463
8397                     ; 1732 			ee_K[1][0]=adc_buff_[1];
8399  18bc ce0007        	ldw	x,_adc_buff_+2
8400  18bf 89            	pushw	x
8401  18c0 ae001c        	ldw	x,#_ee_K+4
8402  18c3 cd0000        	call	c_eewrw
8404  18c6 85            	popw	x
8406  18c7 204a          	jra	L5463
8407  18c9               L3463:
8408                     ; 1734 		else if((mess[9]&0x0f)==0x02)
8410  18c9 b6cd          	ld	a,_mess+9
8411  18cb a40f          	and	a,#15
8412  18cd a102          	cp	a,#2
8413  18cf 260b          	jrne	L7463
8414                     ; 1736 			ee_K[1][1]++;
8416  18d1 ce001e        	ldw	x,_ee_K+6
8417  18d4 1c0001        	addw	x,#1
8418  18d7 cf001e        	ldw	_ee_K+6,x
8420  18da 2037          	jra	L5463
8421  18dc               L7463:
8422                     ; 1738 		else if((mess[9]&0x0f)==0x03)
8424  18dc b6cd          	ld	a,_mess+9
8425  18de a40f          	and	a,#15
8426  18e0 a103          	cp	a,#3
8427  18e2 260b          	jrne	L3563
8428                     ; 1740 			ee_K[1][1]+=10;
8430  18e4 ce001e        	ldw	x,_ee_K+6
8431  18e7 1c000a        	addw	x,#10
8432  18ea cf001e        	ldw	_ee_K+6,x
8434  18ed 2024          	jra	L5463
8435  18ef               L3563:
8436                     ; 1742 		else if((mess[9]&0x0f)==0x04)
8438  18ef b6cd          	ld	a,_mess+9
8439  18f1 a40f          	and	a,#15
8440  18f3 a104          	cp	a,#4
8441  18f5 260b          	jrne	L7563
8442                     ; 1744 			ee_K[1][1]--;
8444  18f7 ce001e        	ldw	x,_ee_K+6
8445  18fa 1d0001        	subw	x,#1
8446  18fd cf001e        	ldw	_ee_K+6,x
8448  1900 2011          	jra	L5463
8449  1902               L7563:
8450                     ; 1746 		else if((mess[9]&0x0f)==0x05)
8452  1902 b6cd          	ld	a,_mess+9
8453  1904 a40f          	and	a,#15
8454  1906 a105          	cp	a,#5
8455  1908 2609          	jrne	L5463
8456                     ; 1748 			ee_K[1][1]-=10;
8458  190a ce001e        	ldw	x,_ee_K+6
8459  190d 1d000a        	subw	x,#10
8460  1910 cf001e        	ldw	_ee_K+6,x
8461  1913               L5463:
8462                     ; 1753 		granee(&ee_K[1][1],10,30000);
8464  1913 ae7530        	ldw	x,#30000
8465  1916 89            	pushw	x
8466  1917 ae000a        	ldw	x,#10
8467  191a 89            	pushw	x
8468  191b ae001e        	ldw	x,#_ee_K+6
8469  191e cd0021        	call	_granee
8471  1921 5b04          	addw	sp,#4
8473  1923 ac001a00      	jpf	L7363
8474  1927               L1463:
8475                     ; 1757 	else if((mess[9]&0xf0)==0x00)
8477  1927 b6cd          	ld	a,_mess+9
8478  1929 a5f0          	bcp	a,#240
8479  192b 2671          	jrne	L7663
8480                     ; 1759 		if((mess[9]&0x0f)==0x01)
8482  192d b6cd          	ld	a,_mess+9
8483  192f a40f          	and	a,#15
8484  1931 a101          	cp	a,#1
8485  1933 260d          	jrne	L1763
8486                     ; 1761 			ee_K[2][0]=adc_buff_[2];
8488  1935 ce0009        	ldw	x,_adc_buff_+4
8489  1938 89            	pushw	x
8490  1939 ae0020        	ldw	x,#_ee_K+8
8491  193c cd0000        	call	c_eewrw
8493  193f 85            	popw	x
8495  1940 204a          	jra	L3763
8496  1942               L1763:
8497                     ; 1763 		else if((mess[9]&0x0f)==0x02)
8499  1942 b6cd          	ld	a,_mess+9
8500  1944 a40f          	and	a,#15
8501  1946 a102          	cp	a,#2
8502  1948 260b          	jrne	L5763
8503                     ; 1765 			ee_K[2][1]++;
8505  194a ce0022        	ldw	x,_ee_K+10
8506  194d 1c0001        	addw	x,#1
8507  1950 cf0022        	ldw	_ee_K+10,x
8509  1953 2037          	jra	L3763
8510  1955               L5763:
8511                     ; 1767 		else if((mess[9]&0x0f)==0x03)
8513  1955 b6cd          	ld	a,_mess+9
8514  1957 a40f          	and	a,#15
8515  1959 a103          	cp	a,#3
8516  195b 260b          	jrne	L1073
8517                     ; 1769 			ee_K[2][1]+=10;
8519  195d ce0022        	ldw	x,_ee_K+10
8520  1960 1c000a        	addw	x,#10
8521  1963 cf0022        	ldw	_ee_K+10,x
8523  1966 2024          	jra	L3763
8524  1968               L1073:
8525                     ; 1771 		else if((mess[9]&0x0f)==0x04)
8527  1968 b6cd          	ld	a,_mess+9
8528  196a a40f          	and	a,#15
8529  196c a104          	cp	a,#4
8530  196e 260b          	jrne	L5073
8531                     ; 1773 			ee_K[2][1]--;
8533  1970 ce0022        	ldw	x,_ee_K+10
8534  1973 1d0001        	subw	x,#1
8535  1976 cf0022        	ldw	_ee_K+10,x
8537  1979 2011          	jra	L3763
8538  197b               L5073:
8539                     ; 1775 		else if((mess[9]&0x0f)==0x05)
8541  197b b6cd          	ld	a,_mess+9
8542  197d a40f          	and	a,#15
8543  197f a105          	cp	a,#5
8544  1981 2609          	jrne	L3763
8545                     ; 1777 			ee_K[2][1]-=10;
8547  1983 ce0022        	ldw	x,_ee_K+10
8548  1986 1d000a        	subw	x,#10
8549  1989 cf0022        	ldw	_ee_K+10,x
8550  198c               L3763:
8551                     ; 1782 		granee(&ee_K[2][1],10,30000);
8553  198c ae7530        	ldw	x,#30000
8554  198f 89            	pushw	x
8555  1990 ae000a        	ldw	x,#10
8556  1993 89            	pushw	x
8557  1994 ae0022        	ldw	x,#_ee_K+10
8558  1997 cd0021        	call	_granee
8560  199a 5b04          	addw	sp,#4
8562  199c 2062          	jra	L7363
8563  199e               L7663:
8564                     ; 1786 	else if((mess[9]&0xf0)==0x30)
8566  199e b6cd          	ld	a,_mess+9
8567  19a0 a4f0          	and	a,#240
8568  19a2 a130          	cp	a,#48
8569  19a4 265a          	jrne	L7363
8570                     ; 1788 		if((mess[9]&0x0f)==0x02)
8572  19a6 b6cd          	ld	a,_mess+9
8573  19a8 a40f          	and	a,#15
8574  19aa a102          	cp	a,#2
8575  19ac 260b          	jrne	L7173
8576                     ; 1790 			ee_K[3][1]++;
8578  19ae ce0026        	ldw	x,_ee_K+14
8579  19b1 1c0001        	addw	x,#1
8580  19b4 cf0026        	ldw	_ee_K+14,x
8582  19b7 2037          	jra	L1273
8583  19b9               L7173:
8584                     ; 1792 		else if((mess[9]&0x0f)==0x03)
8586  19b9 b6cd          	ld	a,_mess+9
8587  19bb a40f          	and	a,#15
8588  19bd a103          	cp	a,#3
8589  19bf 260b          	jrne	L3273
8590                     ; 1794 			ee_K[3][1]+=10;
8592  19c1 ce0026        	ldw	x,_ee_K+14
8593  19c4 1c000a        	addw	x,#10
8594  19c7 cf0026        	ldw	_ee_K+14,x
8596  19ca 2024          	jra	L1273
8597  19cc               L3273:
8598                     ; 1796 		else if((mess[9]&0x0f)==0x04)
8600  19cc b6cd          	ld	a,_mess+9
8601  19ce a40f          	and	a,#15
8602  19d0 a104          	cp	a,#4
8603  19d2 260b          	jrne	L7273
8604                     ; 1798 			ee_K[3][1]--;
8606  19d4 ce0026        	ldw	x,_ee_K+14
8607  19d7 1d0001        	subw	x,#1
8608  19da cf0026        	ldw	_ee_K+14,x
8610  19dd 2011          	jra	L1273
8611  19df               L7273:
8612                     ; 1800 		else if((mess[9]&0x0f)==0x05)
8614  19df b6cd          	ld	a,_mess+9
8615  19e1 a40f          	and	a,#15
8616  19e3 a105          	cp	a,#5
8617  19e5 2609          	jrne	L1273
8618                     ; 1802 			ee_K[3][1]-=10;
8620  19e7 ce0026        	ldw	x,_ee_K+14
8621  19ea 1d000a        	subw	x,#10
8622  19ed cf0026        	ldw	_ee_K+14,x
8623  19f0               L1273:
8624                     ; 1804 		granee(&ee_K[3][1],300,517);									
8626  19f0 ae0205        	ldw	x,#517
8627  19f3 89            	pushw	x
8628  19f4 ae012c        	ldw	x,#300
8629  19f7 89            	pushw	x
8630  19f8 ae0026        	ldw	x,#_ee_K+14
8631  19fb cd0021        	call	_granee
8633  19fe 5b04          	addw	sp,#4
8634  1a00               L7363:
8635                     ; 1807 	link_cnt=0;
8637  1a00 3f62          	clr	_link_cnt
8638                     ; 1808      link=ON;
8640  1a02 35550063      	mov	_link,#85
8641                     ; 1809      if(res_fl_)
8643  1a06 725d0008      	tnz	_res_fl_
8644  1a0a 2603          	jrne	L022
8645  1a0c cc1d27        	jp	L5253
8646  1a0f               L022:
8647                     ; 1811       	res_fl_=0;
8649  1a0f 4f            	clr	a
8650  1a10 ae0008        	ldw	x,#_res_fl_
8651  1a13 cd0000        	call	c_eewrc
8653  1a16 ac271d27      	jpf	L5253
8654  1a1a               L1163:
8655                     ; 1817 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8657  1a1a b6ca          	ld	a,_mess+6
8658  1a1c a1ff          	cp	a,#255
8659  1a1e 2703          	jreq	L222
8660  1a20 cc1aae        	jp	L1473
8661  1a23               L222:
8663  1a23 b6cb          	ld	a,_mess+7
8664  1a25 a1ff          	cp	a,#255
8665  1a27 2703          	jreq	L422
8666  1a29 cc1aae        	jp	L1473
8667  1a2c               L422:
8669  1a2c b6cc          	ld	a,_mess+8
8670  1a2e a162          	cp	a,#98
8671  1a30 267c          	jrne	L1473
8672                     ; 1820 	tempSS=mess[9]+(mess[10]*256);
8674  1a32 b6ce          	ld	a,_mess+10
8675  1a34 5f            	clrw	x
8676  1a35 97            	ld	xl,a
8677  1a36 4f            	clr	a
8678  1a37 02            	rlwa	x,a
8679  1a38 01            	rrwa	x,a
8680  1a39 bbcd          	add	a,_mess+9
8681  1a3b 2401          	jrnc	L071
8682  1a3d 5c            	incw	x
8683  1a3e               L071:
8684  1a3e 02            	rlwa	x,a
8685  1a3f 1f04          	ldw	(OFST-1,sp),x
8686  1a41 01            	rrwa	x,a
8687                     ; 1821 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8689  1a42 ce0012        	ldw	x,_ee_Umax
8690  1a45 1304          	cpw	x,(OFST-1,sp)
8691  1a47 270a          	jreq	L3473
8694  1a49 1e04          	ldw	x,(OFST-1,sp)
8695  1a4b 89            	pushw	x
8696  1a4c ae0012        	ldw	x,#_ee_Umax
8697  1a4f cd0000        	call	c_eewrw
8699  1a52 85            	popw	x
8700  1a53               L3473:
8701                     ; 1822 	tempSS=mess[11]+(mess[12]*256);
8703  1a53 b6d0          	ld	a,_mess+12
8704  1a55 5f            	clrw	x
8705  1a56 97            	ld	xl,a
8706  1a57 4f            	clr	a
8707  1a58 02            	rlwa	x,a
8708  1a59 01            	rrwa	x,a
8709  1a5a bbcf          	add	a,_mess+11
8710  1a5c 2401          	jrnc	L271
8711  1a5e 5c            	incw	x
8712  1a5f               L271:
8713  1a5f 02            	rlwa	x,a
8714  1a60 1f04          	ldw	(OFST-1,sp),x
8715  1a62 01            	rrwa	x,a
8716                     ; 1823 	if(ee_dU!=tempSS) ee_dU=tempSS;
8718  1a63 ce0010        	ldw	x,_ee_dU
8719  1a66 1304          	cpw	x,(OFST-1,sp)
8720  1a68 270a          	jreq	L5473
8723  1a6a 1e04          	ldw	x,(OFST-1,sp)
8724  1a6c 89            	pushw	x
8725  1a6d ae0010        	ldw	x,#_ee_dU
8726  1a70 cd0000        	call	c_eewrw
8728  1a73 85            	popw	x
8729  1a74               L5473:
8730                     ; 1824 	if((mess[13]&0x0f)==0x5)
8732  1a74 b6d1          	ld	a,_mess+13
8733  1a76 a40f          	and	a,#15
8734  1a78 a105          	cp	a,#5
8735  1a7a 261a          	jrne	L7473
8736                     ; 1826 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8738  1a7c ce0004        	ldw	x,_ee_AVT_MODE
8739  1a7f a30055        	cpw	x,#85
8740  1a82 2603          	jrne	L622
8741  1a84 cc1d27        	jp	L5253
8742  1a87               L622:
8745  1a87 ae0055        	ldw	x,#85
8746  1a8a 89            	pushw	x
8747  1a8b ae0004        	ldw	x,#_ee_AVT_MODE
8748  1a8e cd0000        	call	c_eewrw
8750  1a91 85            	popw	x
8751  1a92 ac271d27      	jpf	L5253
8752  1a96               L7473:
8753                     ; 1828 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8755  1a96 ce0004        	ldw	x,_ee_AVT_MODE
8756  1a99 a30055        	cpw	x,#85
8757  1a9c 2703          	jreq	L032
8758  1a9e cc1d27        	jp	L5253
8759  1aa1               L032:
8762  1aa1 5f            	clrw	x
8763  1aa2 89            	pushw	x
8764  1aa3 ae0004        	ldw	x,#_ee_AVT_MODE
8765  1aa6 cd0000        	call	c_eewrw
8767  1aa9 85            	popw	x
8768  1aaa ac271d27      	jpf	L5253
8769  1aae               L1473:
8770                     ; 1831 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8772  1aae b6ca          	ld	a,_mess+6
8773  1ab0 a1ff          	cp	a,#255
8774  1ab2 2703          	jreq	L232
8775  1ab4 cc1b85        	jp	L1673
8776  1ab7               L232:
8778  1ab7 b6cb          	ld	a,_mess+7
8779  1ab9 a1ff          	cp	a,#255
8780  1abb 2703          	jreq	L432
8781  1abd cc1b85        	jp	L1673
8782  1ac0               L432:
8784  1ac0 b6cc          	ld	a,_mess+8
8785  1ac2 a126          	cp	a,#38
8786  1ac4 2709          	jreq	L3673
8788  1ac6 b6cc          	ld	a,_mess+8
8789  1ac8 a129          	cp	a,#41
8790  1aca 2703          	jreq	L632
8791  1acc cc1b85        	jp	L1673
8792  1acf               L632:
8793  1acf               L3673:
8794                     ; 1834 	tempSS=mess[9]+(mess[10]*256);
8796  1acf b6ce          	ld	a,_mess+10
8797  1ad1 5f            	clrw	x
8798  1ad2 97            	ld	xl,a
8799  1ad3 4f            	clr	a
8800  1ad4 02            	rlwa	x,a
8801  1ad5 01            	rrwa	x,a
8802  1ad6 bbcd          	add	a,_mess+9
8803  1ad8 2401          	jrnc	L471
8804  1ada 5c            	incw	x
8805  1adb               L471:
8806  1adb 02            	rlwa	x,a
8807  1adc 1f04          	ldw	(OFST-1,sp),x
8808  1ade 01            	rrwa	x,a
8809                     ; 1835 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8811  1adf ce000e        	ldw	x,_ee_tmax
8812  1ae2 1304          	cpw	x,(OFST-1,sp)
8813  1ae4 270a          	jreq	L5673
8816  1ae6 1e04          	ldw	x,(OFST-1,sp)
8817  1ae8 89            	pushw	x
8818  1ae9 ae000e        	ldw	x,#_ee_tmax
8819  1aec cd0000        	call	c_eewrw
8821  1aef 85            	popw	x
8822  1af0               L5673:
8823                     ; 1836 	tempSS=mess[11]+(mess[12]*256);
8825  1af0 b6d0          	ld	a,_mess+12
8826  1af2 5f            	clrw	x
8827  1af3 97            	ld	xl,a
8828  1af4 4f            	clr	a
8829  1af5 02            	rlwa	x,a
8830  1af6 01            	rrwa	x,a
8831  1af7 bbcf          	add	a,_mess+11
8832  1af9 2401          	jrnc	L671
8833  1afb 5c            	incw	x
8834  1afc               L671:
8835  1afc 02            	rlwa	x,a
8836  1afd 1f04          	ldw	(OFST-1,sp),x
8837  1aff 01            	rrwa	x,a
8838                     ; 1837 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8840  1b00 ce000c        	ldw	x,_ee_tsign
8841  1b03 1304          	cpw	x,(OFST-1,sp)
8842  1b05 270a          	jreq	L7673
8845  1b07 1e04          	ldw	x,(OFST-1,sp)
8846  1b09 89            	pushw	x
8847  1b0a ae000c        	ldw	x,#_ee_tsign
8848  1b0d cd0000        	call	c_eewrw
8850  1b10 85            	popw	x
8851  1b11               L7673:
8852                     ; 1840 	if(mess[8]==MEM_KF1)
8854  1b11 b6cc          	ld	a,_mess+8
8855  1b13 a126          	cp	a,#38
8856  1b15 2623          	jrne	L1773
8857                     ; 1842 		if(ee_DEVICE!=0)ee_DEVICE=0;
8859  1b17 ce0002        	ldw	x,_ee_DEVICE
8860  1b1a 2709          	jreq	L3773
8863  1b1c 5f            	clrw	x
8864  1b1d 89            	pushw	x
8865  1b1e ae0002        	ldw	x,#_ee_DEVICE
8866  1b21 cd0000        	call	c_eewrw
8868  1b24 85            	popw	x
8869  1b25               L3773:
8870                     ; 1843 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8872  1b25 b6d1          	ld	a,_mess+13
8873  1b27 5f            	clrw	x
8874  1b28 97            	ld	xl,a
8875  1b29 c30014        	cpw	x,_ee_TZAS
8876  1b2c 270c          	jreq	L1773
8879  1b2e b6d1          	ld	a,_mess+13
8880  1b30 5f            	clrw	x
8881  1b31 97            	ld	xl,a
8882  1b32 89            	pushw	x
8883  1b33 ae0014        	ldw	x,#_ee_TZAS
8884  1b36 cd0000        	call	c_eewrw
8886  1b39 85            	popw	x
8887  1b3a               L1773:
8888                     ; 1845 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8890  1b3a b6cc          	ld	a,_mess+8
8891  1b3c a129          	cp	a,#41
8892  1b3e 2703          	jreq	L042
8893  1b40 cc1d27        	jp	L5253
8894  1b43               L042:
8895                     ; 1847 		if(ee_DEVICE!=1)ee_DEVICE=1;
8897  1b43 ce0002        	ldw	x,_ee_DEVICE
8898  1b46 a30001        	cpw	x,#1
8899  1b49 270b          	jreq	L1004
8902  1b4b ae0001        	ldw	x,#1
8903  1b4e 89            	pushw	x
8904  1b4f ae0002        	ldw	x,#_ee_DEVICE
8905  1b52 cd0000        	call	c_eewrw
8907  1b55 85            	popw	x
8908  1b56               L1004:
8909                     ; 1848 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8911  1b56 b6d1          	ld	a,_mess+13
8912  1b58 5f            	clrw	x
8913  1b59 97            	ld	xl,a
8914  1b5a c30000        	cpw	x,_ee_IMAXVENT
8915  1b5d 270c          	jreq	L3004
8918  1b5f b6d1          	ld	a,_mess+13
8919  1b61 5f            	clrw	x
8920  1b62 97            	ld	xl,a
8921  1b63 89            	pushw	x
8922  1b64 ae0000        	ldw	x,#_ee_IMAXVENT
8923  1b67 cd0000        	call	c_eewrw
8925  1b6a 85            	popw	x
8926  1b6b               L3004:
8927                     ; 1849 			if(ee_TZAS!=3) ee_TZAS=3;
8929  1b6b ce0014        	ldw	x,_ee_TZAS
8930  1b6e a30003        	cpw	x,#3
8931  1b71 2603          	jrne	L242
8932  1b73 cc1d27        	jp	L5253
8933  1b76               L242:
8936  1b76 ae0003        	ldw	x,#3
8937  1b79 89            	pushw	x
8938  1b7a ae0014        	ldw	x,#_ee_TZAS
8939  1b7d cd0000        	call	c_eewrw
8941  1b80 85            	popw	x
8942  1b81 ac271d27      	jpf	L5253
8943  1b85               L1673:
8944                     ; 1853 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8946  1b85 b6ca          	ld	a,_mess+6
8947  1b87 c10001        	cp	a,_adress
8948  1b8a 262d          	jrne	L1104
8950  1b8c b6cb          	ld	a,_mess+7
8951  1b8e c10001        	cp	a,_adress
8952  1b91 2626          	jrne	L1104
8954  1b93 b6cc          	ld	a,_mess+8
8955  1b95 a116          	cp	a,#22
8956  1b97 2620          	jrne	L1104
8958  1b99 b6cd          	ld	a,_mess+9
8959  1b9b a163          	cp	a,#99
8960  1b9d 261a          	jrne	L1104
8961                     ; 1855 	flags&=0b11100001;
8963  1b9f b60a          	ld	a,_flags
8964  1ba1 a4e1          	and	a,#225
8965  1ba3 b70a          	ld	_flags,a
8966                     ; 1856 	tsign_cnt=0;
8968  1ba5 5f            	clrw	x
8969  1ba6 bf4e          	ldw	_tsign_cnt,x
8970                     ; 1857 	tmax_cnt=0;
8972  1ba8 5f            	clrw	x
8973  1ba9 bf4c          	ldw	_tmax_cnt,x
8974                     ; 1858 	umax_cnt=0;
8976  1bab 5f            	clrw	x
8977  1bac bf66          	ldw	_umax_cnt,x
8978                     ; 1859 	umin_cnt=0;
8980  1bae 5f            	clrw	x
8981  1baf bf64          	ldw	_umin_cnt,x
8982                     ; 1860 	led_drv_cnt=30;
8984  1bb1 351e0019      	mov	_led_drv_cnt,#30
8986  1bb5 ac271d27      	jpf	L5253
8987  1bb9               L1104:
8988                     ; 1862 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8990  1bb9 b6ca          	ld	a,_mess+6
8991  1bbb a1ff          	cp	a,#255
8992  1bbd 265f          	jrne	L5104
8994  1bbf b6cb          	ld	a,_mess+7
8995  1bc1 a1ff          	cp	a,#255
8996  1bc3 2659          	jrne	L5104
8998  1bc5 b6cc          	ld	a,_mess+8
8999  1bc7 a116          	cp	a,#22
9000  1bc9 2653          	jrne	L5104
9002  1bcb b6cd          	ld	a,_mess+9
9003  1bcd a116          	cp	a,#22
9004  1bcf 264d          	jrne	L5104
9005                     ; 1864 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9007  1bd1 b6ce          	ld	a,_mess+10
9008  1bd3 a155          	cp	a,#85
9009  1bd5 260f          	jrne	L7104
9011  1bd7 b6cf          	ld	a,_mess+11
9012  1bd9 a155          	cp	a,#85
9013  1bdb 2609          	jrne	L7104
9016  1bdd be5f          	ldw	x,__x_
9017  1bdf 1c0001        	addw	x,#1
9018  1be2 bf5f          	ldw	__x_,x
9020  1be4 2024          	jra	L1204
9021  1be6               L7104:
9022                     ; 1865 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9024  1be6 b6ce          	ld	a,_mess+10
9025  1be8 a166          	cp	a,#102
9026  1bea 260f          	jrne	L3204
9028  1bec b6cf          	ld	a,_mess+11
9029  1bee a166          	cp	a,#102
9030  1bf0 2609          	jrne	L3204
9033  1bf2 be5f          	ldw	x,__x_
9034  1bf4 1d0001        	subw	x,#1
9035  1bf7 bf5f          	ldw	__x_,x
9037  1bf9 200f          	jra	L1204
9038  1bfb               L3204:
9039                     ; 1866 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9041  1bfb b6ce          	ld	a,_mess+10
9042  1bfd a177          	cp	a,#119
9043  1bff 2609          	jrne	L1204
9045  1c01 b6cf          	ld	a,_mess+11
9046  1c03 a177          	cp	a,#119
9047  1c05 2603          	jrne	L1204
9050  1c07 5f            	clrw	x
9051  1c08 bf5f          	ldw	__x_,x
9052  1c0a               L1204:
9053                     ; 1867      gran(&_x_,-XMAX,XMAX);
9055  1c0a ae0019        	ldw	x,#25
9056  1c0d 89            	pushw	x
9057  1c0e aeffe7        	ldw	x,#65511
9058  1c11 89            	pushw	x
9059  1c12 ae005f        	ldw	x,#__x_
9060  1c15 cd0000        	call	_gran
9062  1c18 5b04          	addw	sp,#4
9064  1c1a ac271d27      	jpf	L5253
9065  1c1e               L5104:
9066                     ; 1869 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9068  1c1e b6ca          	ld	a,_mess+6
9069  1c20 c10001        	cp	a,_adress
9070  1c23 2665          	jrne	L3304
9072  1c25 b6cb          	ld	a,_mess+7
9073  1c27 c10001        	cp	a,_adress
9074  1c2a 265e          	jrne	L3304
9076  1c2c b6cc          	ld	a,_mess+8
9077  1c2e a116          	cp	a,#22
9078  1c30 2658          	jrne	L3304
9080  1c32 b6cd          	ld	a,_mess+9
9081  1c34 b1ce          	cp	a,_mess+10
9082  1c36 2652          	jrne	L3304
9084  1c38 b6cd          	ld	a,_mess+9
9085  1c3a a1ee          	cp	a,#238
9086  1c3c 264c          	jrne	L3304
9087                     ; 1871 	rotor_int++;
9089  1c3e be1a          	ldw	x,_rotor_int
9090  1c40 1c0001        	addw	x,#1
9091  1c43 bf1a          	ldw	_rotor_int,x
9092                     ; 1872      tempI=pwm_u;
9094  1c45 be0b          	ldw	x,_pwm_u
9095  1c47 1f04          	ldw	(OFST-1,sp),x
9096                     ; 1873 	ee_U_AVT=tempI;
9098  1c49 1e04          	ldw	x,(OFST-1,sp)
9099  1c4b 89            	pushw	x
9100  1c4c ae000a        	ldw	x,#_ee_U_AVT
9101  1c4f cd0000        	call	c_eewrw
9103  1c52 85            	popw	x
9104                     ; 1874 	UU_AVT=Un;
9106  1c53 be6d          	ldw	x,_Un
9107  1c55 89            	pushw	x
9108  1c56 ae0006        	ldw	x,#_UU_AVT
9109  1c59 cd0000        	call	c_eewrw
9111  1c5c 85            	popw	x
9112                     ; 1875 	delay_ms(100);
9114  1c5d ae0064        	ldw	x,#100
9115  1c60 cd004c        	call	_delay_ms
9117                     ; 1876 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9119  1c63 ce000a        	ldw	x,_ee_U_AVT
9120  1c66 1304          	cpw	x,(OFST-1,sp)
9121  1c68 2703          	jreq	L442
9122  1c6a cc1d27        	jp	L5253
9123  1c6d               L442:
9126  1c6d 4b00          	push	#0
9127  1c6f 4b00          	push	#0
9128  1c71 4b00          	push	#0
9129  1c73 4b00          	push	#0
9130  1c75 4bdd          	push	#221
9131  1c77 4bdd          	push	#221
9132  1c79 4b91          	push	#145
9133  1c7b 3b0001        	push	_adress
9134  1c7e ae018e        	ldw	x,#398
9135  1c81 cd1552        	call	_can_transmit
9137  1c84 5b08          	addw	sp,#8
9138  1c86 ac271d27      	jpf	L5253
9139  1c8a               L3304:
9140                     ; 1881 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9142  1c8a b6cb          	ld	a,_mess+7
9143  1c8c a1da          	cp	a,#218
9144  1c8e 2652          	jrne	L1404
9146  1c90 b6ca          	ld	a,_mess+6
9147  1c92 c10001        	cp	a,_adress
9148  1c95 274b          	jreq	L1404
9150  1c97 b6ca          	ld	a,_mess+6
9151  1c99 a106          	cp	a,#6
9152  1c9b 2445          	jruge	L1404
9153                     ; 1883 	i_main_bps_cnt[mess[6]]=0;
9155  1c9d b6ca          	ld	a,_mess+6
9156  1c9f 5f            	clrw	x
9157  1ca0 97            	ld	xl,a
9158  1ca1 6f0a          	clr	(_i_main_bps_cnt,x)
9159                     ; 1884 	i_main_flag[mess[6]]=1;
9161  1ca3 b6ca          	ld	a,_mess+6
9162  1ca5 5f            	clrw	x
9163  1ca6 97            	ld	xl,a
9164  1ca7 a601          	ld	a,#1
9165  1ca9 e715          	ld	(_i_main_flag,x),a
9166                     ; 1885 	if(bMAIN)
9168                     	btst	_bMAIN
9169  1cb0 2475          	jruge	L5253
9170                     ; 1887 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9172  1cb2 b6cd          	ld	a,_mess+9
9173  1cb4 5f            	clrw	x
9174  1cb5 97            	ld	xl,a
9175  1cb6 4f            	clr	a
9176  1cb7 02            	rlwa	x,a
9177  1cb8 1f01          	ldw	(OFST-4,sp),x
9178  1cba b6cc          	ld	a,_mess+8
9179  1cbc 5f            	clrw	x
9180  1cbd 97            	ld	xl,a
9181  1cbe 72fb01        	addw	x,(OFST-4,sp)
9182  1cc1 b6ca          	ld	a,_mess+6
9183  1cc3 905f          	clrw	y
9184  1cc5 9097          	ld	yl,a
9185  1cc7 9058          	sllw	y
9186  1cc9 90ef1b        	ldw	(_i_main,y),x
9187                     ; 1888 		i_main[adress]=I;
9189  1ccc c60001        	ld	a,_adress
9190  1ccf 5f            	clrw	x
9191  1cd0 97            	ld	xl,a
9192  1cd1 58            	sllw	x
9193  1cd2 90be6f        	ldw	y,_I
9194  1cd5 ef1b          	ldw	(_i_main,x),y
9195                     ; 1889      	i_main_flag[adress]=1;
9197  1cd7 c60001        	ld	a,_adress
9198  1cda 5f            	clrw	x
9199  1cdb 97            	ld	xl,a
9200  1cdc a601          	ld	a,#1
9201  1cde e715          	ld	(_i_main_flag,x),a
9202  1ce0 2045          	jra	L5253
9203  1ce2               L1404:
9204                     ; 1893 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9206  1ce2 b6cb          	ld	a,_mess+7
9207  1ce4 a1db          	cp	a,#219
9208  1ce6 263f          	jrne	L5253
9210  1ce8 b6ca          	ld	a,_mess+6
9211  1cea c10001        	cp	a,_adress
9212  1ced 2738          	jreq	L5253
9214  1cef b6ca          	ld	a,_mess+6
9215  1cf1 a106          	cp	a,#6
9216  1cf3 2432          	jruge	L5253
9217                     ; 1895 	i_main_bps_cnt[mess[6]]=0;
9219  1cf5 b6ca          	ld	a,_mess+6
9220  1cf7 5f            	clrw	x
9221  1cf8 97            	ld	xl,a
9222  1cf9 6f0a          	clr	(_i_main_bps_cnt,x)
9223                     ; 1896 	i_main_flag[mess[6]]=1;		
9225  1cfb b6ca          	ld	a,_mess+6
9226  1cfd 5f            	clrw	x
9227  1cfe 97            	ld	xl,a
9228  1cff a601          	ld	a,#1
9229  1d01 e715          	ld	(_i_main_flag,x),a
9230                     ; 1897 	if(bMAIN)
9232                     	btst	_bMAIN
9233  1d08 241d          	jruge	L5253
9234                     ; 1899 		if(mess[9]==0)i_main_flag[i]=1;
9236  1d0a 3dcd          	tnz	_mess+9
9237  1d0c 260a          	jrne	L3504
9240  1d0e 7b03          	ld	a,(OFST-2,sp)
9241  1d10 5f            	clrw	x
9242  1d11 97            	ld	xl,a
9243  1d12 a601          	ld	a,#1
9244  1d14 e715          	ld	(_i_main_flag,x),a
9246  1d16 2006          	jra	L5504
9247  1d18               L3504:
9248                     ; 1900 		else i_main_flag[i]=0;
9250  1d18 7b03          	ld	a,(OFST-2,sp)
9251  1d1a 5f            	clrw	x
9252  1d1b 97            	ld	xl,a
9253  1d1c 6f15          	clr	(_i_main_flag,x)
9254  1d1e               L5504:
9255                     ; 1901 		i_main_flag[adress]=1;
9257  1d1e c60001        	ld	a,_adress
9258  1d21 5f            	clrw	x
9259  1d22 97            	ld	xl,a
9260  1d23 a601          	ld	a,#1
9261  1d25 e715          	ld	(_i_main_flag,x),a
9262  1d27               L5253:
9263                     ; 1907 can_in_an_end:
9263                     ; 1908 bCAN_RX=0;
9265  1d27 3f09          	clr	_bCAN_RX
9266                     ; 1909 }   
9269  1d29 5b05          	addw	sp,#5
9270  1d2b 81            	ret
9293                     ; 1912 void t4_init(void){
9294                     	switch	.text
9295  1d2c               _t4_init:
9299                     ; 1913 	TIM4->PSCR = 4;
9301  1d2c 35045345      	mov	21317,#4
9302                     ; 1914 	TIM4->ARR= 77;
9304  1d30 354d5346      	mov	21318,#77
9305                     ; 1915 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9307  1d34 72105341      	bset	21313,#0
9308                     ; 1917 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9310  1d38 35855340      	mov	21312,#133
9311                     ; 1919 }
9314  1d3c 81            	ret
9337                     ; 1922 void t1_init(void)
9337                     ; 1923 {
9338                     	switch	.text
9339  1d3d               _t1_init:
9343                     ; 1924 TIM1->ARRH= 0x03;
9345  1d3d 35035262      	mov	21090,#3
9346                     ; 1925 TIM1->ARRL= 0xff;
9348  1d41 35ff5263      	mov	21091,#255
9349                     ; 1926 TIM1->CCR1H= 0x00;	
9351  1d45 725f5265      	clr	21093
9352                     ; 1927 TIM1->CCR1L= 0xff;
9354  1d49 35ff5266      	mov	21094,#255
9355                     ; 1928 TIM1->CCR2H= 0x00;	
9357  1d4d 725f5267      	clr	21095
9358                     ; 1929 TIM1->CCR2L= 0x00;
9360  1d51 725f5268      	clr	21096
9361                     ; 1930 TIM1->CCR3H= 0x00;	
9363  1d55 725f5269      	clr	21097
9364                     ; 1931 TIM1->CCR3L= 0x64;
9366  1d59 3564526a      	mov	21098,#100
9367                     ; 1933 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9369  1d5d 35685258      	mov	21080,#104
9370                     ; 1934 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9372  1d61 35685259      	mov	21081,#104
9373                     ; 1935 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9375  1d65 3568525a      	mov	21082,#104
9376                     ; 1936 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9378  1d69 3511525c      	mov	21084,#17
9379                     ; 1937 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9381  1d6d 3501525d      	mov	21085,#1
9382                     ; 1938 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9384  1d71 35815250      	mov	21072,#129
9385                     ; 1939 TIM1->BKR|= TIM1_BKR_AOE;
9387  1d75 721c526d      	bset	21101,#6
9388                     ; 1940 }
9391  1d79 81            	ret
9416                     ; 1944 void adc2_init(void)
9416                     ; 1945 {
9417                     	switch	.text
9418  1d7a               _adc2_init:
9422                     ; 1946 adc_plazma[0]++;
9424  1d7a beb6          	ldw	x,_adc_plazma
9425  1d7c 1c0001        	addw	x,#1
9426  1d7f bfb6          	ldw	_adc_plazma,x
9427                     ; 1970 GPIOB->DDR&=~(1<<4);
9429  1d81 72195007      	bres	20487,#4
9430                     ; 1971 GPIOB->CR1&=~(1<<4);
9432  1d85 72195008      	bres	20488,#4
9433                     ; 1972 GPIOB->CR2&=~(1<<4);
9435  1d89 72195009      	bres	20489,#4
9436                     ; 1974 GPIOB->DDR&=~(1<<5);
9438  1d8d 721b5007      	bres	20487,#5
9439                     ; 1975 GPIOB->CR1&=~(1<<5);
9441  1d91 721b5008      	bres	20488,#5
9442                     ; 1976 GPIOB->CR2&=~(1<<5);
9444  1d95 721b5009      	bres	20489,#5
9445                     ; 1978 GPIOB->DDR&=~(1<<6);
9447  1d99 721d5007      	bres	20487,#6
9448                     ; 1979 GPIOB->CR1&=~(1<<6);
9450  1d9d 721d5008      	bres	20488,#6
9451                     ; 1980 GPIOB->CR2&=~(1<<6);
9453  1da1 721d5009      	bres	20489,#6
9454                     ; 1982 GPIOB->DDR&=~(1<<7);
9456  1da5 721f5007      	bres	20487,#7
9457                     ; 1983 GPIOB->CR1&=~(1<<7);
9459  1da9 721f5008      	bres	20488,#7
9460                     ; 1984 GPIOB->CR2&=~(1<<7);
9462  1dad 721f5009      	bres	20489,#7
9463                     ; 1994 ADC2->TDRL=0xff;
9465  1db1 35ff5407      	mov	21511,#255
9466                     ; 1996 ADC2->CR2=0x08;
9468  1db5 35085402      	mov	21506,#8
9469                     ; 1997 ADC2->CR1=0x40;
9471  1db9 35405401      	mov	21505,#64
9472                     ; 2000 	ADC2->CSR=0x20+adc_ch+3;
9474  1dbd b6c3          	ld	a,_adc_ch
9475  1dbf ab23          	add	a,#35
9476  1dc1 c75400        	ld	21504,a
9477                     ; 2002 	ADC2->CR1|=1;
9479  1dc4 72105401      	bset	21505,#0
9480                     ; 2003 	ADC2->CR1|=1;
9482  1dc8 72105401      	bset	21505,#0
9483                     ; 2006 adc_plazma[1]=adc_ch;
9485  1dcc b6c3          	ld	a,_adc_ch
9486  1dce 5f            	clrw	x
9487  1dcf 97            	ld	xl,a
9488  1dd0 bfb8          	ldw	_adc_plazma+2,x
9489                     ; 2007 }
9492  1dd2 81            	ret
9526                     ; 2016 @far @interrupt void TIM4_UPD_Interrupt (void) 
9526                     ; 2017 {
9528                     	switch	.text
9529  1dd3               f_TIM4_UPD_Interrupt:
9533                     ; 2018 TIM4->SR1&=~TIM4_SR1_UIF;
9535  1dd3 72115342      	bres	21314,#0
9536                     ; 2020 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9538  1dd7 3c09          	inc	_pwm_vent_cnt
9539  1dd9 b609          	ld	a,_pwm_vent_cnt
9540  1ddb a10a          	cp	a,#10
9541  1ddd 2502          	jrult	L7114
9544  1ddf 3f09          	clr	_pwm_vent_cnt
9545  1de1               L7114:
9546                     ; 2021 GPIOB->ODR|=(1<<3);
9548  1de1 72165005      	bset	20485,#3
9549                     ; 2022 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9551  1de5 b609          	ld	a,_pwm_vent_cnt
9552  1de7 a105          	cp	a,#5
9553  1de9 2504          	jrult	L1214
9556  1deb 72175005      	bres	20485,#3
9557  1def               L1214:
9558                     ; 2027 if(++t0_cnt0>=100)
9560  1def 9c            	rvf
9561  1df0 be00          	ldw	x,_t0_cnt0
9562  1df2 1c0001        	addw	x,#1
9563  1df5 bf00          	ldw	_t0_cnt0,x
9564  1df7 a30064        	cpw	x,#100
9565  1dfa 2f3f          	jrslt	L3214
9566                     ; 2029 	t0_cnt0=0;
9568  1dfc 5f            	clrw	x
9569  1dfd bf00          	ldw	_t0_cnt0,x
9570                     ; 2030 	b100Hz=1;
9572  1dff 72100008      	bset	_b100Hz
9573                     ; 2032 	if(++t0_cnt1>=10)
9575  1e03 3c02          	inc	_t0_cnt1
9576  1e05 b602          	ld	a,_t0_cnt1
9577  1e07 a10a          	cp	a,#10
9578  1e09 2506          	jrult	L5214
9579                     ; 2034 		t0_cnt1=0;
9581  1e0b 3f02          	clr	_t0_cnt1
9582                     ; 2035 		b10Hz=1;
9584  1e0d 72100007      	bset	_b10Hz
9585  1e11               L5214:
9586                     ; 2038 	if(++t0_cnt2>=20)
9588  1e11 3c03          	inc	_t0_cnt2
9589  1e13 b603          	ld	a,_t0_cnt2
9590  1e15 a114          	cp	a,#20
9591  1e17 2506          	jrult	L7214
9592                     ; 2040 		t0_cnt2=0;
9594  1e19 3f03          	clr	_t0_cnt2
9595                     ; 2041 		b5Hz=1;
9597  1e1b 72100006      	bset	_b5Hz
9598  1e1f               L7214:
9599                     ; 2045 	if(++t0_cnt4>=50)
9601  1e1f 3c05          	inc	_t0_cnt4
9602  1e21 b605          	ld	a,_t0_cnt4
9603  1e23 a132          	cp	a,#50
9604  1e25 2506          	jrult	L1314
9605                     ; 2047 		t0_cnt4=0;
9607  1e27 3f05          	clr	_t0_cnt4
9608                     ; 2048 		b2Hz=1;
9610  1e29 72100005      	bset	_b2Hz
9611  1e2d               L1314:
9612                     ; 2051 	if(++t0_cnt3>=100)
9614  1e2d 3c04          	inc	_t0_cnt3
9615  1e2f b604          	ld	a,_t0_cnt3
9616  1e31 a164          	cp	a,#100
9617  1e33 2506          	jrult	L3214
9618                     ; 2053 		t0_cnt3=0;
9620  1e35 3f04          	clr	_t0_cnt3
9621                     ; 2054 		b1Hz=1;
9623  1e37 72100004      	bset	_b1Hz
9624  1e3b               L3214:
9625                     ; 2060 }
9628  1e3b 80            	iret
9653                     ; 2063 @far @interrupt void CAN_RX_Interrupt (void) 
9653                     ; 2064 {
9654                     	switch	.text
9655  1e3c               f_CAN_RX_Interrupt:
9659                     ; 2066 CAN->PSR= 7;									// page 7 - read messsage
9661  1e3c 35075427      	mov	21543,#7
9662                     ; 2068 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9664  1e40 ae000e        	ldw	x,#14
9665  1e43               L062:
9666  1e43 d65427        	ld	a,(21543,x)
9667  1e46 e7c3          	ld	(_mess-1,x),a
9668  1e48 5a            	decw	x
9669  1e49 26f8          	jrne	L062
9670                     ; 2079 bCAN_RX=1;
9672  1e4b 35010009      	mov	_bCAN_RX,#1
9673                     ; 2080 CAN->RFR|=(1<<5);
9675  1e4f 721a5424      	bset	21540,#5
9676                     ; 2082 }
9679  1e53 80            	iret
9702                     ; 2085 @far @interrupt void CAN_TX_Interrupt (void) 
9702                     ; 2086 {
9703                     	switch	.text
9704  1e54               f_CAN_TX_Interrupt:
9708                     ; 2087 if((CAN->TSR)&(1<<0))
9710  1e54 c65422        	ld	a,21538
9711  1e57 a501          	bcp	a,#1
9712  1e59 2708          	jreq	L5514
9713                     ; 2089 	bTX_FREE=1;	
9715  1e5b 35010008      	mov	_bTX_FREE,#1
9716                     ; 2091 	CAN->TSR|=(1<<0);
9718  1e5f 72105422      	bset	21538,#0
9719  1e63               L5514:
9720                     ; 2093 }
9723  1e63 80            	iret
9781                     ; 2096 @far @interrupt void ADC2_EOC_Interrupt (void) {
9782                     	switch	.text
9783  1e64               f_ADC2_EOC_Interrupt:
9785       00000009      OFST:	set	9
9786  1e64 be00          	ldw	x,c_x
9787  1e66 89            	pushw	x
9788  1e67 be00          	ldw	x,c_y
9789  1e69 89            	pushw	x
9790  1e6a be02          	ldw	x,c_lreg+2
9791  1e6c 89            	pushw	x
9792  1e6d be00          	ldw	x,c_lreg
9793  1e6f 89            	pushw	x
9794  1e70 5209          	subw	sp,#9
9797                     ; 2101 adc_plazma[2]++;
9799  1e72 beba          	ldw	x,_adc_plazma+4
9800  1e74 1c0001        	addw	x,#1
9801  1e77 bfba          	ldw	_adc_plazma+4,x
9802                     ; 2108 ADC2->CSR&=~(1<<7);
9804  1e79 721f5400      	bres	21504,#7
9805                     ; 2110 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9807  1e7d c65405        	ld	a,21509
9808  1e80 b703          	ld	c_lreg+3,a
9809  1e82 3f02          	clr	c_lreg+2
9810  1e84 3f01          	clr	c_lreg+1
9811  1e86 3f00          	clr	c_lreg
9812  1e88 96            	ldw	x,sp
9813  1e89 1c0001        	addw	x,#OFST-8
9814  1e8c cd0000        	call	c_rtol
9816  1e8f c65404        	ld	a,21508
9817  1e92 5f            	clrw	x
9818  1e93 97            	ld	xl,a
9819  1e94 90ae0100      	ldw	y,#256
9820  1e98 cd0000        	call	c_umul
9822  1e9b 96            	ldw	x,sp
9823  1e9c 1c0001        	addw	x,#OFST-8
9824  1e9f cd0000        	call	c_ladd
9826  1ea2 96            	ldw	x,sp
9827  1ea3 1c0006        	addw	x,#OFST-3
9828  1ea6 cd0000        	call	c_rtol
9830                     ; 2115 if(adr_drv_stat==1)
9832  1ea9 b607          	ld	a,_adr_drv_stat
9833  1eab a101          	cp	a,#1
9834  1ead 260b          	jrne	L5024
9835                     ; 2117 	adr_drv_stat=2;
9837  1eaf 35020007      	mov	_adr_drv_stat,#2
9838                     ; 2118 	adc_buff_[0]=temp_adc;
9840  1eb3 1e08          	ldw	x,(OFST-1,sp)
9841  1eb5 cf0005        	ldw	_adc_buff_,x
9843  1eb8 2020          	jra	L7024
9844  1eba               L5024:
9845                     ; 2121 else if(adr_drv_stat==3)
9847  1eba b607          	ld	a,_adr_drv_stat
9848  1ebc a103          	cp	a,#3
9849  1ebe 260b          	jrne	L1124
9850                     ; 2123 	adr_drv_stat=4;
9852  1ec0 35040007      	mov	_adr_drv_stat,#4
9853                     ; 2124 	adc_buff_[1]=temp_adc;
9855  1ec4 1e08          	ldw	x,(OFST-1,sp)
9856  1ec6 cf0007        	ldw	_adc_buff_+2,x
9858  1ec9 200f          	jra	L7024
9859  1ecb               L1124:
9860                     ; 2127 else if(adr_drv_stat==5)
9862  1ecb b607          	ld	a,_adr_drv_stat
9863  1ecd a105          	cp	a,#5
9864  1ecf 2609          	jrne	L7024
9865                     ; 2129 	adr_drv_stat=6;
9867  1ed1 35060007      	mov	_adr_drv_stat,#6
9868                     ; 2130 	adc_buff_[9]=temp_adc;
9870  1ed5 1e08          	ldw	x,(OFST-1,sp)
9871  1ed7 cf0017        	ldw	_adc_buff_+18,x
9872  1eda               L7024:
9873                     ; 2133 adc_buff[adc_ch][adc_cnt]=temp_adc;
9875  1eda b6c2          	ld	a,_adc_cnt
9876  1edc 5f            	clrw	x
9877  1edd 97            	ld	xl,a
9878  1ede 58            	sllw	x
9879  1edf 1f03          	ldw	(OFST-6,sp),x
9880  1ee1 b6c3          	ld	a,_adc_ch
9881  1ee3 97            	ld	xl,a
9882  1ee4 a620          	ld	a,#32
9883  1ee6 42            	mul	x,a
9884  1ee7 72fb03        	addw	x,(OFST-6,sp)
9885  1eea 1608          	ldw	y,(OFST-1,sp)
9886  1eec df0019        	ldw	(_adc_buff,x),y
9887                     ; 2139 adc_ch++;
9889  1eef 3cc3          	inc	_adc_ch
9890                     ; 2140 if(adc_ch>=5)
9892  1ef1 b6c3          	ld	a,_adc_ch
9893  1ef3 a105          	cp	a,#5
9894  1ef5 250c          	jrult	L7124
9895                     ; 2143 	adc_ch=0;
9897  1ef7 3fc3          	clr	_adc_ch
9898                     ; 2144 	adc_cnt++;
9900  1ef9 3cc2          	inc	_adc_cnt
9901                     ; 2145 	if(adc_cnt>=16)
9903  1efb b6c2          	ld	a,_adc_cnt
9904  1efd a110          	cp	a,#16
9905  1eff 2502          	jrult	L7124
9906                     ; 2147 		adc_cnt=0;
9908  1f01 3fc2          	clr	_adc_cnt
9909  1f03               L7124:
9910                     ; 2151 if((adc_cnt&0x03)==0)
9912  1f03 b6c2          	ld	a,_adc_cnt
9913  1f05 a503          	bcp	a,#3
9914  1f07 264b          	jrne	L3224
9915                     ; 2155 	tempSS=0;
9917  1f09 ae0000        	ldw	x,#0
9918  1f0c 1f08          	ldw	(OFST-1,sp),x
9919  1f0e ae0000        	ldw	x,#0
9920  1f11 1f06          	ldw	(OFST-3,sp),x
9921                     ; 2156 	for(i=0;i<16;i++)
9923  1f13 0f05          	clr	(OFST-4,sp)
9924  1f15               L5224:
9925                     ; 2158 		tempSS+=(signed long)adc_buff[adc_ch][i];
9927  1f15 7b05          	ld	a,(OFST-4,sp)
9928  1f17 5f            	clrw	x
9929  1f18 97            	ld	xl,a
9930  1f19 58            	sllw	x
9931  1f1a 1f03          	ldw	(OFST-6,sp),x
9932  1f1c b6c3          	ld	a,_adc_ch
9933  1f1e 97            	ld	xl,a
9934  1f1f a620          	ld	a,#32
9935  1f21 42            	mul	x,a
9936  1f22 72fb03        	addw	x,(OFST-6,sp)
9937  1f25 de0019        	ldw	x,(_adc_buff,x)
9938  1f28 cd0000        	call	c_itolx
9940  1f2b 96            	ldw	x,sp
9941  1f2c 1c0006        	addw	x,#OFST-3
9942  1f2f cd0000        	call	c_lgadd
9944                     ; 2156 	for(i=0;i<16;i++)
9946  1f32 0c05          	inc	(OFST-4,sp)
9949  1f34 7b05          	ld	a,(OFST-4,sp)
9950  1f36 a110          	cp	a,#16
9951  1f38 25db          	jrult	L5224
9952                     ; 2160 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9954  1f3a 96            	ldw	x,sp
9955  1f3b 1c0006        	addw	x,#OFST-3
9956  1f3e cd0000        	call	c_ltor
9958  1f41 a604          	ld	a,#4
9959  1f43 cd0000        	call	c_lrsh
9961  1f46 be02          	ldw	x,c_lreg+2
9962  1f48 b6c3          	ld	a,_adc_ch
9963  1f4a 905f          	clrw	y
9964  1f4c 9097          	ld	yl,a
9965  1f4e 9058          	sllw	y
9966  1f50 90df0005      	ldw	(_adc_buff_,y),x
9967  1f54               L3224:
9968                     ; 2171 adc_plazma_short++;
9970  1f54 bec0          	ldw	x,_adc_plazma_short
9971  1f56 1c0001        	addw	x,#1
9972  1f59 bfc0          	ldw	_adc_plazma_short,x
9973                     ; 2186 }
9976  1f5b 5b09          	addw	sp,#9
9977  1f5d 85            	popw	x
9978  1f5e bf00          	ldw	c_lreg,x
9979  1f60 85            	popw	x
9980  1f61 bf02          	ldw	c_lreg+2,x
9981  1f63 85            	popw	x
9982  1f64 bf00          	ldw	c_y,x
9983  1f66 85            	popw	x
9984  1f67 bf00          	ldw	c_x,x
9985  1f69 80            	iret
10048                     ; 2194 main()
10048                     ; 2195 {
10050                     	switch	.text
10051  1f6a               _main:
10055                     ; 2197 CLK->ECKR|=1;
10057  1f6a 721050c1      	bset	20673,#0
10059  1f6e               L5424:
10060                     ; 2198 while((CLK->ECKR & 2) == 0);
10062  1f6e c650c1        	ld	a,20673
10063  1f71 a502          	bcp	a,#2
10064  1f73 27f9          	jreq	L5424
10065                     ; 2199 CLK->SWCR|=2;
10067  1f75 721250c5      	bset	20677,#1
10068                     ; 2200 CLK->SWR=0xB4;
10070  1f79 35b450c4      	mov	20676,#180
10071                     ; 2202 delay_ms(200);
10073  1f7d ae00c8        	ldw	x,#200
10074  1f80 cd004c        	call	_delay_ms
10076                     ; 2203 FLASH_DUKR=0xae;
10078  1f83 35ae5064      	mov	_FLASH_DUKR,#174
10079                     ; 2204 FLASH_DUKR=0x56;
10081  1f87 35565064      	mov	_FLASH_DUKR,#86
10082                     ; 2205 enableInterrupts();
10085  1f8b 9a            rim
10087                     ; 2207 delay_ms(100);
10090  1f8c ae0064        	ldw	x,#100
10091  1f8f cd004c        	call	_delay_ms
10093                     ; 2208 delay_ms(100);
10095  1f92 ae0064        	ldw	x,#100
10096  1f95 cd004c        	call	_delay_ms
10098                     ; 2209 delay_ms(100);
10100  1f98 ae0064        	ldw	x,#100
10101  1f9b cd004c        	call	_delay_ms
10103                     ; 2210 delay_ms(100);
10105  1f9e ae0064        	ldw	x,#100
10106  1fa1 cd004c        	call	_delay_ms
10108                     ; 2211 delay_ms(100);
10110  1fa4 ae0064        	ldw	x,#100
10111  1fa7 cd004c        	call	_delay_ms
10113                     ; 2213 adr_drv_v4();
10115  1faa cd121c        	call	_adr_drv_v4
10117                     ; 2217 t4_init();
10119  1fad cd1d2c        	call	_t4_init
10121                     ; 2219 		GPIOG->DDR|=(1<<0);
10123  1fb0 72105020      	bset	20512,#0
10124                     ; 2220 		GPIOG->CR1|=(1<<0);
10126  1fb4 72105021      	bset	20513,#0
10127                     ; 2221 		GPIOG->CR2&=~(1<<0);	
10129  1fb8 72115022      	bres	20514,#0
10130                     ; 2224 		GPIOG->DDR&=~(1<<1);
10132  1fbc 72135020      	bres	20512,#1
10133                     ; 2225 		GPIOG->CR1|=(1<<1);
10135  1fc0 72125021      	bset	20513,#1
10136                     ; 2226 		GPIOG->CR2&=~(1<<1);
10138  1fc4 72135022      	bres	20514,#1
10139                     ; 2228 init_CAN();
10141  1fc8 cd14e3        	call	_init_CAN
10143                     ; 2233 GPIOC->DDR|=(1<<1);
10145  1fcb 7212500c      	bset	20492,#1
10146                     ; 2234 GPIOC->CR1|=(1<<1);
10148  1fcf 7212500d      	bset	20493,#1
10149                     ; 2235 GPIOC->CR2|=(1<<1);
10151  1fd3 7212500e      	bset	20494,#1
10152                     ; 2237 GPIOC->DDR|=(1<<2);
10154  1fd7 7214500c      	bset	20492,#2
10155                     ; 2238 GPIOC->CR1|=(1<<2);
10157  1fdb 7214500d      	bset	20493,#2
10158                     ; 2239 GPIOC->CR2|=(1<<2);
10160  1fdf 7214500e      	bset	20494,#2
10161                     ; 2246 t1_init();
10163  1fe3 cd1d3d        	call	_t1_init
10165                     ; 2248 GPIOA->DDR|=(1<<5);
10167  1fe6 721a5002      	bset	20482,#5
10168                     ; 2249 GPIOA->CR1|=(1<<5);
10170  1fea 721a5003      	bset	20483,#5
10171                     ; 2250 GPIOA->CR2&=~(1<<5);
10173  1fee 721b5004      	bres	20484,#5
10174                     ; 2256 GPIOB->DDR|=(1<<3);
10176  1ff2 72165007      	bset	20487,#3
10177                     ; 2257 GPIOB->CR1|=(1<<3);
10179  1ff6 72165008      	bset	20488,#3
10180                     ; 2258 GPIOB->CR2|=(1<<3);
10182  1ffa 72165009      	bset	20489,#3
10183                     ; 2260 GPIOC->DDR|=(1<<3);
10185  1ffe 7216500c      	bset	20492,#3
10186                     ; 2261 GPIOC->CR1|=(1<<3);
10188  2002 7216500d      	bset	20493,#3
10189                     ; 2262 GPIOC->CR2|=(1<<3);
10191  2006 7216500e      	bset	20494,#3
10192                     ; 2265 if(bps_class==bpsIPS) 
10194  200a b605          	ld	a,_bps_class
10195  200c a101          	cp	a,#1
10196  200e 260a          	jrne	L3524
10197                     ; 2267 	pwm_u=ee_U_AVT;
10199  2010 ce000a        	ldw	x,_ee_U_AVT
10200  2013 bf0b          	ldw	_pwm_u,x
10201                     ; 2268 	volum_u_main_=ee_U_AVT;
10203  2015 ce000a        	ldw	x,_ee_U_AVT
10204  2018 bf1c          	ldw	_volum_u_main_,x
10205  201a               L3524:
10206                     ; 2275 	if(bCAN_RX)
10208  201a 3d09          	tnz	_bCAN_RX
10209  201c 2705          	jreq	L7524
10210                     ; 2277 		bCAN_RX=0;
10212  201e 3f09          	clr	_bCAN_RX
10213                     ; 2278 		can_in_an();	
10215  2020 cd16ee        	call	_can_in_an
10217  2023               L7524:
10218                     ; 2280 	if(b100Hz)
10220                     	btst	_b100Hz
10221  2028 240a          	jruge	L1624
10222                     ; 2282 		b100Hz=0;
10224  202a 72110008      	bres	_b100Hz
10225                     ; 2291 		adc2_init();
10227  202e cd1d7a        	call	_adc2_init
10229                     ; 2292 		can_tx_hndl();
10231  2031 cd15d6        	call	_can_tx_hndl
10233  2034               L1624:
10234                     ; 2295 	if(b10Hz)
10236                     	btst	_b10Hz
10237  2039 2419          	jruge	L3624
10238                     ; 2297 		b10Hz=0;
10240  203b 72110007      	bres	_b10Hz
10241                     ; 2299           matemat();
10243  203f cd0bca        	call	_matemat
10245                     ; 2300 	    	led_drv(); 
10247  2042 cd0711        	call	_led_drv
10249                     ; 2301 	     link_drv();
10251  2045 cd07ff        	call	_link_drv
10253                     ; 2302 	     pwr_hndl();		//вычисление воздействий на силу
10255  2048 cd0aae        	call	_pwr_hndl
10257                     ; 2303 	     JP_drv();
10259  204b cd0774        	call	_JP_drv
10261                     ; 2304 	     flags_drv();
10263  204e cd0fc8        	call	_flags_drv
10265                     ; 2305 		net_drv();
10267  2051 cd1640        	call	_net_drv
10269  2054               L3624:
10270                     ; 2308 	if(b5Hz)
10272                     	btst	_b5Hz
10273  2059 240d          	jruge	L5624
10274                     ; 2310 		b5Hz=0;
10276  205b 72110006      	bres	_b5Hz
10277                     ; 2312 		pwr_drv();		//воздействие на силу
10279  205f cd09aa        	call	_pwr_drv
10281                     ; 2313 		led_hndl();
10283  2062 cd008e        	call	_led_hndl
10285                     ; 2315 		vent_drv();
10287  2065 cd084e        	call	_vent_drv
10289  2068               L5624:
10290                     ; 2318 	if(b2Hz)
10292                     	btst	_b2Hz
10293  206d 2404          	jruge	L7624
10294                     ; 2320 		b2Hz=0;
10296  206f 72110005      	bres	_b2Hz
10297  2073               L7624:
10298                     ; 2329 	if(b1Hz)
10300                     	btst	_b1Hz
10301  2078 24a0          	jruge	L3524
10302                     ; 2331 		b1Hz=0;
10304  207a 72110004      	bres	_b1Hz
10305                     ; 2333 		temper_drv();			//вычисление аварий температуры
10307  207e cd0cf8        	call	_temper_drv
10309                     ; 2334 		u_drv();
10311  2081 cd0dcf        	call	_u_drv
10313                     ; 2335           x_drv();
10315  2084 cd0eaf        	call	_x_drv
10317                     ; 2336           if(main_cnt<1000)main_cnt++;
10319  2087 9c            	rvf
10320  2088 be52          	ldw	x,_main_cnt
10321  208a a303e8        	cpw	x,#1000
10322  208d 2e07          	jrsge	L3724
10325  208f be52          	ldw	x,_main_cnt
10326  2091 1c0001        	addw	x,#1
10327  2094 bf52          	ldw	_main_cnt,x
10328  2096               L3724:
10329                     ; 2337   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10331  2096 b663          	ld	a,_link
10332  2098 a1aa          	cp	a,#170
10333  209a 2706          	jreq	L7724
10335  209c b64b          	ld	a,_jp_mode
10336  209e a103          	cp	a,#3
10337  20a0 2603          	jrne	L5724
10338  20a2               L7724:
10341  20a2 cd0f29        	call	_apv_hndl
10343  20a5               L5724:
10344                     ; 2340   		can_error_cnt++;
10346  20a5 3c71          	inc	_can_error_cnt
10347                     ; 2341   		if(can_error_cnt>=10)
10349  20a7 b671          	ld	a,_can_error_cnt
10350  20a9 a10a          	cp	a,#10
10351  20ab 2505          	jrult	L1034
10352                     ; 2343   			can_error_cnt=0;
10354  20ad 3f71          	clr	_can_error_cnt
10355                     ; 2344 			init_CAN();
10357  20af cd14e3        	call	_init_CAN
10359  20b2               L1034:
10360                     ; 2348 		volum_u_main_drv();
10362  20b2 cd1390        	call	_volum_u_main_drv
10364                     ; 2350 		pwm_stat++;
10366  20b5 3c08          	inc	_pwm_stat
10367                     ; 2351 		if(pwm_stat>=10)pwm_stat=0;
10369  20b7 b608          	ld	a,_pwm_stat
10370  20b9 a10a          	cp	a,#10
10371  20bb 2502          	jrult	L3034
10374  20bd 3f08          	clr	_pwm_stat
10375  20bf               L3034:
10376                     ; 2352 adc_plazma_short++;
10378  20bf bec0          	ldw	x,_adc_plazma_short
10379  20c1 1c0001        	addw	x,#1
10380  20c4 bfc0          	ldw	_adc_plazma_short,x
10381  20c6 ac1a201a      	jpf	L3524
11405                     	xdef	_main
11406                     	xdef	f_ADC2_EOC_Interrupt
11407                     	xdef	f_CAN_TX_Interrupt
11408                     	xdef	f_CAN_RX_Interrupt
11409                     	xdef	f_TIM4_UPD_Interrupt
11410                     	xdef	_adc2_init
11411                     	xdef	_t1_init
11412                     	xdef	_t4_init
11413                     	xdef	_can_in_an
11414                     	xdef	_net_drv
11415                     	xdef	_can_tx_hndl
11416                     	xdef	_can_transmit
11417                     	xdef	_init_CAN
11418                     	xdef	_volum_u_main_drv
11419                     	xdef	_adr_drv_v4
11420                     	xdef	_adr_drv_v3
11421                     	xdef	_adr_gran
11422                     	xdef	_flags_drv
11423                     	xdef	_apv_hndl
11424                     	xdef	_apv_stop
11425                     	xdef	_apv_start
11426                     	xdef	_x_drv
11427                     	xdef	_u_drv
11428                     	xdef	_temper_drv
11429                     	xdef	_matemat
11430                     	xdef	_pwr_hndl
11431                     	xdef	_pwr_drv
11432                     	xdef	_vent_drv
11433                     	xdef	_link_drv
11434                     	xdef	_JP_drv
11435                     	xdef	_led_drv
11436                     	xdef	_led_hndl
11437                     	xdef	_delay_ms
11438                     	xdef	_granee
11439                     	xdef	_gran
11440                     	switch	.ubsct
11441  0001               _plazma_adress:
11442  0001 00000000      	ds.b	4
11443                     	xdef	_plazma_adress
11444                     .eeprom:	section	.data
11445  0000               _ee_IMAXVENT:
11446  0000 0000          	ds.b	2
11447                     	xdef	_ee_IMAXVENT
11448                     	switch	.ubsct
11449  0005               _bps_class:
11450  0005 00            	ds.b	1
11451                     	xdef	_bps_class
11452  0006               _vent_pwm:
11453  0006 0000          	ds.b	2
11454                     	xdef	_vent_pwm
11455  0008               _pwm_stat:
11456  0008 00            	ds.b	1
11457                     	xdef	_pwm_stat
11458  0009               _pwm_vent_cnt:
11459  0009 00            	ds.b	1
11460                     	xdef	_pwm_vent_cnt
11461                     	switch	.eeprom
11462  0002               _ee_DEVICE:
11463  0002 0000          	ds.b	2
11464                     	xdef	_ee_DEVICE
11465  0004               _ee_AVT_MODE:
11466  0004 0000          	ds.b	2
11467                     	xdef	_ee_AVT_MODE
11468                     	switch	.ubsct
11469  000a               _i_main_bps_cnt:
11470  000a 000000000000  	ds.b	6
11471                     	xdef	_i_main_bps_cnt
11472  0010               _i_main_sigma:
11473  0010 0000          	ds.b	2
11474                     	xdef	_i_main_sigma
11475  0012               _i_main_num_of_bps:
11476  0012 00            	ds.b	1
11477                     	xdef	_i_main_num_of_bps
11478  0013               _i_main_avg:
11479  0013 0000          	ds.b	2
11480                     	xdef	_i_main_avg
11481  0015               _i_main_flag:
11482  0015 000000000000  	ds.b	6
11483                     	xdef	_i_main_flag
11484  001b               _i_main:
11485  001b 000000000000  	ds.b	12
11486                     	xdef	_i_main
11487  0027               _x:
11488  0027 000000000000  	ds.b	12
11489                     	xdef	_x
11490                     	xdef	_volum_u_main_
11491                     	switch	.eeprom
11492  0006               _UU_AVT:
11493  0006 0000          	ds.b	2
11494                     	xdef	_UU_AVT
11495                     	switch	.ubsct
11496  0033               _cnt_net_drv:
11497  0033 00            	ds.b	1
11498                     	xdef	_cnt_net_drv
11499                     	switch	.bit
11500  0001               _bMAIN:
11501  0001 00            	ds.b	1
11502                     	xdef	_bMAIN
11503                     	switch	.ubsct
11504  0034               _plazma_int:
11505  0034 000000000000  	ds.b	6
11506                     	xdef	_plazma_int
11507                     	xdef	_rotor_int
11508  003a               _led_green_buff:
11509  003a 00000000      	ds.b	4
11510                     	xdef	_led_green_buff
11511  003e               _led_red_buff:
11512  003e 00000000      	ds.b	4
11513                     	xdef	_led_red_buff
11514                     	xdef	_led_drv_cnt
11515                     	xdef	_led_green
11516                     	xdef	_led_red
11517  0042               _res_fl_cnt:
11518  0042 00            	ds.b	1
11519                     	xdef	_res_fl_cnt
11520                     	xdef	_bRES_
11521                     	xdef	_bRES
11522                     	switch	.eeprom
11523  0008               _res_fl_:
11524  0008 00            	ds.b	1
11525                     	xdef	_res_fl_
11526  0009               _res_fl:
11527  0009 00            	ds.b	1
11528                     	xdef	_res_fl
11529                     	switch	.ubsct
11530  0043               _cnt_apv_off:
11531  0043 00            	ds.b	1
11532                     	xdef	_cnt_apv_off
11533                     	switch	.bit
11534  0002               _bAPV:
11535  0002 00            	ds.b	1
11536                     	xdef	_bAPV
11537                     	switch	.ubsct
11538  0044               _apv_cnt_:
11539  0044 0000          	ds.b	2
11540                     	xdef	_apv_cnt_
11541  0046               _apv_cnt:
11542  0046 000000        	ds.b	3
11543                     	xdef	_apv_cnt
11544                     	xdef	_bBL_IPS
11545                     	switch	.bit
11546  0003               _bBL:
11547  0003 00            	ds.b	1
11548                     	xdef	_bBL
11549                     	switch	.ubsct
11550  0049               _cnt_JP1:
11551  0049 00            	ds.b	1
11552                     	xdef	_cnt_JP1
11553  004a               _cnt_JP0:
11554  004a 00            	ds.b	1
11555                     	xdef	_cnt_JP0
11556  004b               _jp_mode:
11557  004b 00            	ds.b	1
11558                     	xdef	_jp_mode
11559                     	xdef	_pwm_i
11560                     	xdef	_pwm_u
11561  004c               _tmax_cnt:
11562  004c 0000          	ds.b	2
11563                     	xdef	_tmax_cnt
11564  004e               _tsign_cnt:
11565  004e 0000          	ds.b	2
11566                     	xdef	_tsign_cnt
11567                     	switch	.eeprom
11568  000a               _ee_U_AVT:
11569  000a 0000          	ds.b	2
11570                     	xdef	_ee_U_AVT
11571  000c               _ee_tsign:
11572  000c 0000          	ds.b	2
11573                     	xdef	_ee_tsign
11574  000e               _ee_tmax:
11575  000e 0000          	ds.b	2
11576                     	xdef	_ee_tmax
11577  0010               _ee_dU:
11578  0010 0000          	ds.b	2
11579                     	xdef	_ee_dU
11580  0012               _ee_Umax:
11581  0012 0000          	ds.b	2
11582                     	xdef	_ee_Umax
11583  0014               _ee_TZAS:
11584  0014 0000          	ds.b	2
11585                     	xdef	_ee_TZAS
11586                     	switch	.ubsct
11587  0050               _main_cnt1:
11588  0050 0000          	ds.b	2
11589                     	xdef	_main_cnt1
11590  0052               _main_cnt:
11591  0052 0000          	ds.b	2
11592                     	xdef	_main_cnt
11593  0054               _off_bp_cnt:
11594  0054 00            	ds.b	1
11595                     	xdef	_off_bp_cnt
11596  0055               _flags_tu_cnt_off:
11597  0055 00            	ds.b	1
11598                     	xdef	_flags_tu_cnt_off
11599  0056               _flags_tu_cnt_on:
11600  0056 00            	ds.b	1
11601                     	xdef	_flags_tu_cnt_on
11602  0057               _vol_i_temp:
11603  0057 0000          	ds.b	2
11604                     	xdef	_vol_i_temp
11605  0059               _vol_u_temp:
11606  0059 0000          	ds.b	2
11607                     	xdef	_vol_u_temp
11608                     	switch	.eeprom
11609  0016               __x_ee_:
11610  0016 0000          	ds.b	2
11611                     	xdef	__x_ee_
11612                     	switch	.ubsct
11613  005b               __x_cnt:
11614  005b 0000          	ds.b	2
11615                     	xdef	__x_cnt
11616  005d               __x__:
11617  005d 0000          	ds.b	2
11618                     	xdef	__x__
11619  005f               __x_:
11620  005f 0000          	ds.b	2
11621                     	xdef	__x_
11622  0061               _flags_tu:
11623  0061 00            	ds.b	1
11624                     	xdef	_flags_tu
11625                     	xdef	_flags
11626  0062               _link_cnt:
11627  0062 00            	ds.b	1
11628                     	xdef	_link_cnt
11629  0063               _link:
11630  0063 00            	ds.b	1
11631                     	xdef	_link
11632  0064               _umin_cnt:
11633  0064 0000          	ds.b	2
11634                     	xdef	_umin_cnt
11635  0066               _umax_cnt:
11636  0066 0000          	ds.b	2
11637                     	xdef	_umax_cnt
11638                     	switch	.eeprom
11639  0018               _ee_K:
11640  0018 000000000000  	ds.b	16
11641                     	xdef	_ee_K
11642                     	switch	.ubsct
11643  0068               _T:
11644  0068 00            	ds.b	1
11645                     	xdef	_T
11646  0069               _Udb:
11647  0069 0000          	ds.b	2
11648                     	xdef	_Udb
11649  006b               _Ui:
11650  006b 0000          	ds.b	2
11651                     	xdef	_Ui
11652  006d               _Un:
11653  006d 0000          	ds.b	2
11654                     	xdef	_Un
11655  006f               _I:
11656  006f 0000          	ds.b	2
11657                     	xdef	_I
11658  0071               _can_error_cnt:
11659  0071 00            	ds.b	1
11660                     	xdef	_can_error_cnt
11661                     	xdef	_bCAN_RX
11662  0072               _tx_busy_cnt:
11663  0072 00            	ds.b	1
11664                     	xdef	_tx_busy_cnt
11665                     	xdef	_bTX_FREE
11666  0073               _can_buff_rd_ptr:
11667  0073 00            	ds.b	1
11668                     	xdef	_can_buff_rd_ptr
11669  0074               _can_buff_wr_ptr:
11670  0074 00            	ds.b	1
11671                     	xdef	_can_buff_wr_ptr
11672  0075               _can_out_buff:
11673  0075 000000000000  	ds.b	64
11674                     	xdef	_can_out_buff
11675                     	switch	.bss
11676  0000               _adress_error:
11677  0000 00            	ds.b	1
11678                     	xdef	_adress_error
11679  0001               _adress:
11680  0001 00            	ds.b	1
11681                     	xdef	_adress
11682  0002               _adr:
11683  0002 000000        	ds.b	3
11684                     	xdef	_adr
11685                     	xdef	_adr_drv_stat
11686                     	xdef	_led_ind
11687                     	switch	.ubsct
11688  00b5               _led_ind_cnt:
11689  00b5 00            	ds.b	1
11690                     	xdef	_led_ind_cnt
11691  00b6               _adc_plazma:
11692  00b6 000000000000  	ds.b	10
11693                     	xdef	_adc_plazma
11694  00c0               _adc_plazma_short:
11695  00c0 0000          	ds.b	2
11696                     	xdef	_adc_plazma_short
11697  00c2               _adc_cnt:
11698  00c2 00            	ds.b	1
11699                     	xdef	_adc_cnt
11700  00c3               _adc_ch:
11701  00c3 00            	ds.b	1
11702                     	xdef	_adc_ch
11703                     	switch	.bss
11704  0005               _adc_buff_:
11705  0005 000000000000  	ds.b	20
11706                     	xdef	_adc_buff_
11707  0019               _adc_buff:
11708  0019 000000000000  	ds.b	320
11709                     	xdef	_adc_buff
11710                     	switch	.ubsct
11711  00c4               _mess:
11712  00c4 000000000000  	ds.b	14
11713                     	xdef	_mess
11714                     	switch	.bit
11715  0004               _b1Hz:
11716  0004 00            	ds.b	1
11717                     	xdef	_b1Hz
11718  0005               _b2Hz:
11719  0005 00            	ds.b	1
11720                     	xdef	_b2Hz
11721  0006               _b5Hz:
11722  0006 00            	ds.b	1
11723                     	xdef	_b5Hz
11724  0007               _b10Hz:
11725  0007 00            	ds.b	1
11726                     	xdef	_b10Hz
11727  0008               _b100Hz:
11728  0008 00            	ds.b	1
11729                     	xdef	_b100Hz
11730                     	xdef	_t0_cnt4
11731                     	xdef	_t0_cnt3
11732                     	xdef	_t0_cnt2
11733                     	xdef	_t0_cnt1
11734                     	xdef	_t0_cnt0
11735                     	xref.b	c_lreg
11736                     	xref.b	c_x
11737                     	xref.b	c_y
11757                     	xref	c_lrsh
11758                     	xref	c_lgadd
11759                     	xref	c_ladd
11760                     	xref	c_umul
11761                     	xref	c_lgmul
11762                     	xref	c_lgsub
11763                     	xref	c_lsbc
11764                     	xref	c_idiv
11765                     	xref	c_ldiv
11766                     	xref	c_itolx
11767                     	xref	c_eewrc
11768                     	xref	c_imul
11769                     	xref	c_lcmp
11770                     	xref	c_ltor
11771                     	xref	c_lgadc
11772                     	xref	c_rtol
11773                     	xref	c_vmul
11774                     	xref	c_eewrw
11775                     	end
