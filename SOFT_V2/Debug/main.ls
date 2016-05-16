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
2273                     ; 164 void gran(signed short *adr, signed short min, signed short max)
2273                     ; 165 {
2275                     	switch	.text
2276  0000               _gran:
2278  0000 89            	pushw	x
2279       00000000      OFST:	set	0
2282                     ; 166 if (*adr<min) *adr=min;
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
2296                     ; 167 if (*adr>max) *adr=max; 
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
2312                     ; 168 } 
2315  001f 85            	popw	x
2316  0020 81            	ret
2369                     ; 171 void granee(@eeprom signed short *adr, signed short min, signed short max)
2369                     ; 172 {
2370                     	switch	.text
2371  0021               _granee:
2373  0021 89            	pushw	x
2374       00000000      OFST:	set	0
2377                     ; 173 if (*adr<min) *adr=min;
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
2395                     ; 174 if (*adr>max) *adr=max; 
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
2414                     ; 175 }
2417  004a 85            	popw	x
2418  004b 81            	ret
2479                     ; 178 long delay_ms(short in)
2479                     ; 179 {
2480                     	switch	.text
2481  004c               _delay_ms:
2483  004c 520c          	subw	sp,#12
2484       0000000c      OFST:	set	12
2487                     ; 182 i=((long)in)*100UL;
2489  004e 90ae0064      	ldw	y,#100
2490  0052 cd0000        	call	c_vmul
2492  0055 96            	ldw	x,sp
2493  0056 1c0005        	addw	x,#OFST-7
2494  0059 cd0000        	call	c_rtol
2496                     ; 184 for(ii=0;ii<i;ii++)
2498  005c ae0000        	ldw	x,#0
2499  005f 1f0b          	ldw	(OFST-1,sp),x
2500  0061 ae0000        	ldw	x,#0
2501  0064 1f09          	ldw	(OFST-3,sp),x
2503  0066 2012          	jra	L3551
2504  0068               L7451:
2505                     ; 186 		iii++;
2507  0068 96            	ldw	x,sp
2508  0069 1c0001        	addw	x,#OFST-11
2509  006c a601          	ld	a,#1
2510  006e cd0000        	call	c_lgadc
2512                     ; 184 for(ii=0;ii<i;ii++)
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
2532                     ; 189 }
2535  008b 5b0c          	addw	sp,#12
2536  008d 81            	ret
2572                     ; 192 void led_hndl(void)
2572                     ; 193 {
2573                     	switch	.text
2574  008e               _led_hndl:
2578                     ; 194 if(adress_error)
2580  008e 725d0000      	tnz	_adress_error
2581  0092 2718          	jreq	L7651
2582                     ; 196 	led_red=0x55555555L;
2584  0094 ae5555        	ldw	x,#21845
2585  0097 bf13          	ldw	_led_red+2,x
2586  0099 ae5555        	ldw	x,#21845
2587  009c bf11          	ldw	_led_red,x
2588                     ; 197 	led_green=0x55555555L;
2590  009e ae5555        	ldw	x,#21845
2591  00a1 bf17          	ldw	_led_green+2,x
2592  00a3 ae5555        	ldw	x,#21845
2593  00a6 bf15          	ldw	_led_green,x
2595  00a8 ac100710      	jpf	L1751
2596  00ac               L7651:
2597                     ; 213 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2599  00ac 3d01          	tnz	_bps_class
2600  00ae 2703          	jreq	L41
2601  00b0 cc0363        	jp	L3751
2602  00b3               L41:
2603                     ; 215 	if(jp_mode!=jp3)
2605  00b3 b647          	ld	a,_jp_mode
2606  00b5 a103          	cp	a,#3
2607  00b7 2603          	jrne	L61
2608  00b9 cc025f        	jp	L5751
2609  00bc               L61:
2610                     ; 217 		if(main_cnt1<(5*ee_TZAS))
2612  00bc 9c            	rvf
2613  00bd ce0014        	ldw	x,_ee_TZAS
2614  00c0 90ae0005      	ldw	y,#5
2615  00c4 cd0000        	call	c_imul
2617  00c7 b34c          	cpw	x,_main_cnt1
2618  00c9 2d18          	jrsle	L7751
2619                     ; 219 			led_red=0x00000000L;
2621  00cb ae0000        	ldw	x,#0
2622  00ce bf13          	ldw	_led_red+2,x
2623  00d0 ae0000        	ldw	x,#0
2624  00d3 bf11          	ldw	_led_red,x
2625                     ; 220 			led_green=0x03030303L;
2627  00d5 ae0303        	ldw	x,#771
2628  00d8 bf17          	ldw	_led_green+2,x
2629  00da ae0303        	ldw	x,#771
2630  00dd bf15          	ldw	_led_green,x
2632  00df ac200220      	jpf	L1061
2633  00e3               L7751:
2634                     ; 223 		else if((link==ON)&&(flags_tu&0b10000000))
2636  00e3 b65f          	ld	a,_link
2637  00e5 a155          	cp	a,#85
2638  00e7 261e          	jrne	L3061
2640  00e9 b65d          	ld	a,_flags_tu
2641  00eb a580          	bcp	a,#128
2642  00ed 2718          	jreq	L3061
2643                     ; 225 			led_red=0x00055555L;
2645  00ef ae5555        	ldw	x,#21845
2646  00f2 bf13          	ldw	_led_red+2,x
2647  00f4 ae0005        	ldw	x,#5
2648  00f7 bf11          	ldw	_led_red,x
2649                     ; 226 			led_green=0xffffffffL;
2651  00f9 aeffff        	ldw	x,#65535
2652  00fc bf17          	ldw	_led_green+2,x
2653  00fe aeffff        	ldw	x,#-1
2654  0101 bf15          	ldw	_led_green,x
2656  0103 ac200220      	jpf	L1061
2657  0107               L3061:
2658                     ; 229 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2660  0107 9c            	rvf
2661  0108 ce0014        	ldw	x,_ee_TZAS
2662  010b 90ae0005      	ldw	y,#5
2663  010f cd0000        	call	c_imul
2665  0112 b34c          	cpw	x,_main_cnt1
2666  0114 2e37          	jrsge	L7061
2668  0116 9c            	rvf
2669  0117 ce0014        	ldw	x,_ee_TZAS
2670  011a 90ae0005      	ldw	y,#5
2671  011e cd0000        	call	c_imul
2673  0121 1c0064        	addw	x,#100
2674  0124 b34c          	cpw	x,_main_cnt1
2675  0126 2d25          	jrsle	L7061
2677  0128 ce0004        	ldw	x,_ee_AVT_MODE
2678  012b a30055        	cpw	x,#85
2679  012e 271d          	jreq	L7061
2681  0130 ce0002        	ldw	x,_ee_DEVICE
2682  0133 2618          	jrne	L7061
2683                     ; 231 			led_red=0x00000000L;
2685  0135 ae0000        	ldw	x,#0
2686  0138 bf13          	ldw	_led_red+2,x
2687  013a ae0000        	ldw	x,#0
2688  013d bf11          	ldw	_led_red,x
2689                     ; 232 			led_green=0xffffffffL;	
2691  013f aeffff        	ldw	x,#65535
2692  0142 bf17          	ldw	_led_green+2,x
2693  0144 aeffff        	ldw	x,#-1
2694  0147 bf15          	ldw	_led_green,x
2696  0149 ac200220      	jpf	L1061
2697  014d               L7061:
2698                     ; 235 		else  if(link==OFF)
2700  014d b65f          	ld	a,_link
2701  014f a1aa          	cp	a,#170
2702  0151 2618          	jrne	L3161
2703                     ; 237 			led_red=0x55555555L;
2705  0153 ae5555        	ldw	x,#21845
2706  0156 bf13          	ldw	_led_red+2,x
2707  0158 ae5555        	ldw	x,#21845
2708  015b bf11          	ldw	_led_red,x
2709                     ; 238 			led_green=0xffffffffL;
2711  015d aeffff        	ldw	x,#65535
2712  0160 bf17          	ldw	_led_green+2,x
2713  0162 aeffff        	ldw	x,#-1
2714  0165 bf15          	ldw	_led_green,x
2716  0167 ac200220      	jpf	L1061
2717  016b               L3161:
2718                     ; 241 		else if((link==ON)&&((flags&0b00111110)==0))
2720  016b b65f          	ld	a,_link
2721  016d a155          	cp	a,#85
2722  016f 261d          	jrne	L7161
2724  0171 b60a          	ld	a,_flags
2725  0173 a53e          	bcp	a,#62
2726  0175 2617          	jrne	L7161
2727                     ; 243 			led_red=0x00000000L;
2729  0177 ae0000        	ldw	x,#0
2730  017a bf13          	ldw	_led_red+2,x
2731  017c ae0000        	ldw	x,#0
2732  017f bf11          	ldw	_led_red,x
2733                     ; 244 			led_green=0xffffffffL;
2735  0181 aeffff        	ldw	x,#65535
2736  0184 bf17          	ldw	_led_green+2,x
2737  0186 aeffff        	ldw	x,#-1
2738  0189 bf15          	ldw	_led_green,x
2740  018b cc0220        	jra	L1061
2741  018e               L7161:
2742                     ; 247 		else if((flags&0b00111110)==0b00000100)
2744  018e b60a          	ld	a,_flags
2745  0190 a43e          	and	a,#62
2746  0192 a104          	cp	a,#4
2747  0194 2616          	jrne	L3261
2748                     ; 249 			led_red=0x00010001L;
2750  0196 ae0001        	ldw	x,#1
2751  0199 bf13          	ldw	_led_red+2,x
2752  019b ae0001        	ldw	x,#1
2753  019e bf11          	ldw	_led_red,x
2754                     ; 250 			led_green=0xffffffffL;	
2756  01a0 aeffff        	ldw	x,#65535
2757  01a3 bf17          	ldw	_led_green+2,x
2758  01a5 aeffff        	ldw	x,#-1
2759  01a8 bf15          	ldw	_led_green,x
2761  01aa 2074          	jra	L1061
2762  01ac               L3261:
2763                     ; 252 		else if(flags&0b00000010)
2765  01ac b60a          	ld	a,_flags
2766  01ae a502          	bcp	a,#2
2767  01b0 2716          	jreq	L7261
2768                     ; 254 			led_red=0x00010001L;
2770  01b2 ae0001        	ldw	x,#1
2771  01b5 bf13          	ldw	_led_red+2,x
2772  01b7 ae0001        	ldw	x,#1
2773  01ba bf11          	ldw	_led_red,x
2774                     ; 255 			led_green=0x00000000L;	
2776  01bc ae0000        	ldw	x,#0
2777  01bf bf17          	ldw	_led_green+2,x
2778  01c1 ae0000        	ldw	x,#0
2779  01c4 bf15          	ldw	_led_green,x
2781  01c6 2058          	jra	L1061
2782  01c8               L7261:
2783                     ; 257 		else if(flags&0b00001000)
2785  01c8 b60a          	ld	a,_flags
2786  01ca a508          	bcp	a,#8
2787  01cc 2716          	jreq	L3361
2788                     ; 259 			led_red=0x00090009L;
2790  01ce ae0009        	ldw	x,#9
2791  01d1 bf13          	ldw	_led_red+2,x
2792  01d3 ae0009        	ldw	x,#9
2793  01d6 bf11          	ldw	_led_red,x
2794                     ; 260 			led_green=0x00000000L;	
2796  01d8 ae0000        	ldw	x,#0
2797  01db bf17          	ldw	_led_green+2,x
2798  01dd ae0000        	ldw	x,#0
2799  01e0 bf15          	ldw	_led_green,x
2801  01e2 203c          	jra	L1061
2802  01e4               L3361:
2803                     ; 262 		else if(flags&0b00010000)
2805  01e4 b60a          	ld	a,_flags
2806  01e6 a510          	bcp	a,#16
2807  01e8 2716          	jreq	L7361
2808                     ; 264 			led_red=0x00490049L;
2810  01ea ae0049        	ldw	x,#73
2811  01ed bf13          	ldw	_led_red+2,x
2812  01ef ae0049        	ldw	x,#73
2813  01f2 bf11          	ldw	_led_red,x
2814                     ; 265 			led_green=0x00000000L;	
2816  01f4 ae0000        	ldw	x,#0
2817  01f7 bf17          	ldw	_led_green+2,x
2818  01f9 ae0000        	ldw	x,#0
2819  01fc bf15          	ldw	_led_green,x
2821  01fe 2020          	jra	L1061
2822  0200               L7361:
2823                     ; 268 		else if((link==ON)&&(flags&0b00100000))
2825  0200 b65f          	ld	a,_link
2826  0202 a155          	cp	a,#85
2827  0204 261a          	jrne	L1061
2829  0206 b60a          	ld	a,_flags
2830  0208 a520          	bcp	a,#32
2831  020a 2714          	jreq	L1061
2832                     ; 270 			led_red=0x00000000L;
2834  020c ae0000        	ldw	x,#0
2835  020f bf13          	ldw	_led_red+2,x
2836  0211 ae0000        	ldw	x,#0
2837  0214 bf11          	ldw	_led_red,x
2838                     ; 271 			led_green=0x00030003L;
2840  0216 ae0003        	ldw	x,#3
2841  0219 bf17          	ldw	_led_green+2,x
2842  021b ae0003        	ldw	x,#3
2843  021e bf15          	ldw	_led_green,x
2844  0220               L1061:
2845                     ; 274 		if((jp_mode==jp1))
2847  0220 b647          	ld	a,_jp_mode
2848  0222 a101          	cp	a,#1
2849  0224 2618          	jrne	L5461
2850                     ; 276 			led_red=0x00000000L;
2852  0226 ae0000        	ldw	x,#0
2853  0229 bf13          	ldw	_led_red+2,x
2854  022b ae0000        	ldw	x,#0
2855  022e bf11          	ldw	_led_red,x
2856                     ; 277 			led_green=0x33333333L;
2858  0230 ae3333        	ldw	x,#13107
2859  0233 bf17          	ldw	_led_green+2,x
2860  0235 ae3333        	ldw	x,#13107
2861  0238 bf15          	ldw	_led_green,x
2863  023a ac100710      	jpf	L1751
2864  023e               L5461:
2865                     ; 279 		else if((jp_mode==jp2))
2867  023e b647          	ld	a,_jp_mode
2868  0240 a102          	cp	a,#2
2869  0242 2703          	jreq	L02
2870  0244 cc0710        	jp	L1751
2871  0247               L02:
2872                     ; 281 			led_red=0xccccccccL;
2874  0247 aecccc        	ldw	x,#52428
2875  024a bf13          	ldw	_led_red+2,x
2876  024c aecccc        	ldw	x,#-13108
2877  024f bf11          	ldw	_led_red,x
2878                     ; 282 			led_green=0x00000000L;
2880  0251 ae0000        	ldw	x,#0
2881  0254 bf17          	ldw	_led_green+2,x
2882  0256 ae0000        	ldw	x,#0
2883  0259 bf15          	ldw	_led_green,x
2884  025b ac100710      	jpf	L1751
2885  025f               L5751:
2886                     ; 285 	else if(jp_mode==jp3)
2888  025f b647          	ld	a,_jp_mode
2889  0261 a103          	cp	a,#3
2890  0263 2703          	jreq	L22
2891  0265 cc0710        	jp	L1751
2892  0268               L22:
2893                     ; 287 		if(main_cnt1<(5*ee_TZAS))
2895  0268 9c            	rvf
2896  0269 ce0014        	ldw	x,_ee_TZAS
2897  026c 90ae0005      	ldw	y,#5
2898  0270 cd0000        	call	c_imul
2900  0273 b34c          	cpw	x,_main_cnt1
2901  0275 2d18          	jrsle	L7561
2902                     ; 289 			led_red=0x00000000L;
2904  0277 ae0000        	ldw	x,#0
2905  027a bf13          	ldw	_led_red+2,x
2906  027c ae0000        	ldw	x,#0
2907  027f bf11          	ldw	_led_red,x
2908                     ; 290 			led_green=0x03030303L;
2910  0281 ae0303        	ldw	x,#771
2911  0284 bf17          	ldw	_led_green+2,x
2912  0286 ae0303        	ldw	x,#771
2913  0289 bf15          	ldw	_led_green,x
2915  028b ac100710      	jpf	L1751
2916  028f               L7561:
2917                     ; 292 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
2919  028f 9c            	rvf
2920  0290 ce0014        	ldw	x,_ee_TZAS
2921  0293 90ae0005      	ldw	y,#5
2922  0297 cd0000        	call	c_imul
2924  029a b34c          	cpw	x,_main_cnt1
2925  029c 2e2a          	jrsge	L3661
2927  029e 9c            	rvf
2928  029f ce0014        	ldw	x,_ee_TZAS
2929  02a2 90ae0005      	ldw	y,#5
2930  02a6 cd0000        	call	c_imul
2932  02a9 1c0046        	addw	x,#70
2933  02ac b34c          	cpw	x,_main_cnt1
2934  02ae 2d18          	jrsle	L3661
2935                     ; 294 			led_red=0x00000000L;
2937  02b0 ae0000        	ldw	x,#0
2938  02b3 bf13          	ldw	_led_red+2,x
2939  02b5 ae0000        	ldw	x,#0
2940  02b8 bf11          	ldw	_led_red,x
2941                     ; 295 			led_green=0xffffffffL;	
2943  02ba aeffff        	ldw	x,#65535
2944  02bd bf17          	ldw	_led_green+2,x
2945  02bf aeffff        	ldw	x,#-1
2946  02c2 bf15          	ldw	_led_green,x
2948  02c4 ac100710      	jpf	L1751
2949  02c8               L3661:
2950                     ; 298 		else if((flags&0b00011110)==0)
2952  02c8 b60a          	ld	a,_flags
2953  02ca a51e          	bcp	a,#30
2954  02cc 2618          	jrne	L7661
2955                     ; 300 			led_red=0x00000000L;
2957  02ce ae0000        	ldw	x,#0
2958  02d1 bf13          	ldw	_led_red+2,x
2959  02d3 ae0000        	ldw	x,#0
2960  02d6 bf11          	ldw	_led_red,x
2961                     ; 301 			led_green=0xffffffffL;
2963  02d8 aeffff        	ldw	x,#65535
2964  02db bf17          	ldw	_led_green+2,x
2965  02dd aeffff        	ldw	x,#-1
2966  02e0 bf15          	ldw	_led_green,x
2968  02e2 ac100710      	jpf	L1751
2969  02e6               L7661:
2970                     ; 305 		else if((flags&0b00111110)==0b00000100)
2972  02e6 b60a          	ld	a,_flags
2973  02e8 a43e          	and	a,#62
2974  02ea a104          	cp	a,#4
2975  02ec 2618          	jrne	L3761
2976                     ; 307 			led_red=0x00010001L;
2978  02ee ae0001        	ldw	x,#1
2979  02f1 bf13          	ldw	_led_red+2,x
2980  02f3 ae0001        	ldw	x,#1
2981  02f6 bf11          	ldw	_led_red,x
2982                     ; 308 			led_green=0xffffffffL;	
2984  02f8 aeffff        	ldw	x,#65535
2985  02fb bf17          	ldw	_led_green+2,x
2986  02fd aeffff        	ldw	x,#-1
2987  0300 bf15          	ldw	_led_green,x
2989  0302 ac100710      	jpf	L1751
2990  0306               L3761:
2991                     ; 310 		else if(flags&0b00000010)
2993  0306 b60a          	ld	a,_flags
2994  0308 a502          	bcp	a,#2
2995  030a 2718          	jreq	L7761
2996                     ; 312 			led_red=0x00010001L;
2998  030c ae0001        	ldw	x,#1
2999  030f bf13          	ldw	_led_red+2,x
3000  0311 ae0001        	ldw	x,#1
3001  0314 bf11          	ldw	_led_red,x
3002                     ; 313 			led_green=0x00000000L;	
3004  0316 ae0000        	ldw	x,#0
3005  0319 bf17          	ldw	_led_green+2,x
3006  031b ae0000        	ldw	x,#0
3007  031e bf15          	ldw	_led_green,x
3009  0320 ac100710      	jpf	L1751
3010  0324               L7761:
3011                     ; 315 		else if(flags&0b00001000)
3013  0324 b60a          	ld	a,_flags
3014  0326 a508          	bcp	a,#8
3015  0328 2718          	jreq	L3071
3016                     ; 317 			led_red=0x00090009L;
3018  032a ae0009        	ldw	x,#9
3019  032d bf13          	ldw	_led_red+2,x
3020  032f ae0009        	ldw	x,#9
3021  0332 bf11          	ldw	_led_red,x
3022                     ; 318 			led_green=0x00000000L;	
3024  0334 ae0000        	ldw	x,#0
3025  0337 bf17          	ldw	_led_green+2,x
3026  0339 ae0000        	ldw	x,#0
3027  033c bf15          	ldw	_led_green,x
3029  033e ac100710      	jpf	L1751
3030  0342               L3071:
3031                     ; 320 		else if(flags&0b00010000)
3033  0342 b60a          	ld	a,_flags
3034  0344 a510          	bcp	a,#16
3035  0346 2603          	jrne	L42
3036  0348 cc0710        	jp	L1751
3037  034b               L42:
3038                     ; 322 			led_red=0x00490049L;
3040  034b ae0049        	ldw	x,#73
3041  034e bf13          	ldw	_led_red+2,x
3042  0350 ae0049        	ldw	x,#73
3043  0353 bf11          	ldw	_led_red,x
3044                     ; 323 			led_green=0xffffffffL;	
3046  0355 aeffff        	ldw	x,#65535
3047  0358 bf17          	ldw	_led_green+2,x
3048  035a aeffff        	ldw	x,#-1
3049  035d bf15          	ldw	_led_green,x
3050  035f ac100710      	jpf	L1751
3051  0363               L3751:
3052                     ; 327 else if(bps_class==bpsIPS)	//если блок ИПСный
3054  0363 b601          	ld	a,_bps_class
3055  0365 a101          	cp	a,#1
3056  0367 2703          	jreq	L62
3057  0369 cc0710        	jp	L1751
3058  036c               L62:
3059                     ; 329 	if(jp_mode!=jp3)
3061  036c b647          	ld	a,_jp_mode
3062  036e a103          	cp	a,#3
3063  0370 2603          	jrne	L03
3064  0372 cc061c        	jp	L5171
3065  0375               L03:
3066                     ; 331 		if(main_cnt1<(5*ee_TZAS))
3068  0375 9c            	rvf
3069  0376 ce0014        	ldw	x,_ee_TZAS
3070  0379 90ae0005      	ldw	y,#5
3071  037d cd0000        	call	c_imul
3073  0380 b34c          	cpw	x,_main_cnt1
3074  0382 2d18          	jrsle	L7171
3075                     ; 333 			led_red=0x00000000L;
3077  0384 ae0000        	ldw	x,#0
3078  0387 bf13          	ldw	_led_red+2,x
3079  0389 ae0000        	ldw	x,#0
3080  038c bf11          	ldw	_led_red,x
3081                     ; 334 			led_green=0x03030303L;
3083  038e ae0303        	ldw	x,#771
3084  0391 bf17          	ldw	_led_green+2,x
3085  0393 ae0303        	ldw	x,#771
3086  0396 bf15          	ldw	_led_green,x
3088  0398 acdd05dd      	jpf	L1271
3089  039c               L7171:
3090                     ; 337 		else if((link==ON)&&(flags_tu&0b10000000))
3092  039c b65f          	ld	a,_link
3093  039e a155          	cp	a,#85
3094  03a0 261e          	jrne	L3271
3096  03a2 b65d          	ld	a,_flags_tu
3097  03a4 a580          	bcp	a,#128
3098  03a6 2718          	jreq	L3271
3099                     ; 339 			led_red=0x00055555L;
3101  03a8 ae5555        	ldw	x,#21845
3102  03ab bf13          	ldw	_led_red+2,x
3103  03ad ae0005        	ldw	x,#5
3104  03b0 bf11          	ldw	_led_red,x
3105                     ; 340 			led_green=0xffffffffL;
3107  03b2 aeffff        	ldw	x,#65535
3108  03b5 bf17          	ldw	_led_green+2,x
3109  03b7 aeffff        	ldw	x,#-1
3110  03ba bf15          	ldw	_led_green,x
3112  03bc acdd05dd      	jpf	L1271
3113  03c0               L3271:
3114                     ; 343 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3116  03c0 9c            	rvf
3117  03c1 ce0014        	ldw	x,_ee_TZAS
3118  03c4 90ae0005      	ldw	y,#5
3119  03c8 cd0000        	call	c_imul
3121  03cb b34c          	cpw	x,_main_cnt1
3122  03cd 2e37          	jrsge	L7271
3124  03cf 9c            	rvf
3125  03d0 ce0014        	ldw	x,_ee_TZAS
3126  03d3 90ae0005      	ldw	y,#5
3127  03d7 cd0000        	call	c_imul
3129  03da 1c0064        	addw	x,#100
3130  03dd b34c          	cpw	x,_main_cnt1
3131  03df 2d25          	jrsle	L7271
3133  03e1 ce0004        	ldw	x,_ee_AVT_MODE
3134  03e4 a30055        	cpw	x,#85
3135  03e7 271d          	jreq	L7271
3137  03e9 ce0002        	ldw	x,_ee_DEVICE
3138  03ec 2618          	jrne	L7271
3139                     ; 345 			led_red=0x00000000L;
3141  03ee ae0000        	ldw	x,#0
3142  03f1 bf13          	ldw	_led_red+2,x
3143  03f3 ae0000        	ldw	x,#0
3144  03f6 bf11          	ldw	_led_red,x
3145                     ; 346 			led_green=0xffffffffL;	
3147  03f8 aeffff        	ldw	x,#65535
3148  03fb bf17          	ldw	_led_green+2,x
3149  03fd aeffff        	ldw	x,#-1
3150  0400 bf15          	ldw	_led_green,x
3152  0402 acdd05dd      	jpf	L1271
3153  0406               L7271:
3154                     ; 349 		else  if(link==OFF)
3156  0406 b65f          	ld	a,_link
3157  0408 a1aa          	cp	a,#170
3158  040a 2703          	jreq	L23
3159  040c cc0528        	jp	L3371
3160  040f               L23:
3161                     ; 351 			if((flags&0b00011110)==0)
3163  040f b60a          	ld	a,_flags
3164  0411 a51e          	bcp	a,#30
3165  0413 262d          	jrne	L5371
3166                     ; 353 				led_red=0x00000000L;
3168  0415 ae0000        	ldw	x,#0
3169  0418 bf13          	ldw	_led_red+2,x
3170  041a ae0000        	ldw	x,#0
3171  041d bf11          	ldw	_led_red,x
3172                     ; 354 				if(bMAIN)led_green=0xfffffff5L;
3174                     	btst	_bMAIN
3175  0424 240e          	jruge	L7371
3178  0426 aefff5        	ldw	x,#65525
3179  0429 bf17          	ldw	_led_green+2,x
3180  042b aeffff        	ldw	x,#-1
3181  042e bf15          	ldw	_led_green,x
3183  0430 acdd05dd      	jpf	L1271
3184  0434               L7371:
3185                     ; 355 				else led_green=0xffffffffL;
3187  0434 aeffff        	ldw	x,#65535
3188  0437 bf17          	ldw	_led_green+2,x
3189  0439 aeffff        	ldw	x,#-1
3190  043c bf15          	ldw	_led_green,x
3191  043e acdd05dd      	jpf	L1271
3192  0442               L5371:
3193                     ; 358 			else if((flags&0b00111110)==0b00000100)
3195  0442 b60a          	ld	a,_flags
3196  0444 a43e          	and	a,#62
3197  0446 a104          	cp	a,#4
3198  0448 262d          	jrne	L5471
3199                     ; 360 				led_red=0x00010001L;
3201  044a ae0001        	ldw	x,#1
3202  044d bf13          	ldw	_led_red+2,x
3203  044f ae0001        	ldw	x,#1
3204  0452 bf11          	ldw	_led_red,x
3205                     ; 361 				if(bMAIN)led_green=0xfffffff5L;
3207                     	btst	_bMAIN
3208  0459 240e          	jruge	L7471
3211  045b aefff5        	ldw	x,#65525
3212  045e bf17          	ldw	_led_green+2,x
3213  0460 aeffff        	ldw	x,#-1
3214  0463 bf15          	ldw	_led_green,x
3216  0465 acdd05dd      	jpf	L1271
3217  0469               L7471:
3218                     ; 362 				else led_green=0xffffffffL;	
3220  0469 aeffff        	ldw	x,#65535
3221  046c bf17          	ldw	_led_green+2,x
3222  046e aeffff        	ldw	x,#-1
3223  0471 bf15          	ldw	_led_green,x
3224  0473 acdd05dd      	jpf	L1271
3225  0477               L5471:
3226                     ; 364 			else if(flags&0b00000010)
3228  0477 b60a          	ld	a,_flags
3229  0479 a502          	bcp	a,#2
3230  047b 272d          	jreq	L5571
3231                     ; 366 				led_red=0x00010001L;
3233  047d ae0001        	ldw	x,#1
3234  0480 bf13          	ldw	_led_red+2,x
3235  0482 ae0001        	ldw	x,#1
3236  0485 bf11          	ldw	_led_red,x
3237                     ; 367 				if(bMAIN)led_green=0x00000005L;
3239                     	btst	_bMAIN
3240  048c 240e          	jruge	L7571
3243  048e ae0005        	ldw	x,#5
3244  0491 bf17          	ldw	_led_green+2,x
3245  0493 ae0000        	ldw	x,#0
3246  0496 bf15          	ldw	_led_green,x
3248  0498 acdd05dd      	jpf	L1271
3249  049c               L7571:
3250                     ; 368 				else led_green=0x00000000L;
3252  049c ae0000        	ldw	x,#0
3253  049f bf17          	ldw	_led_green+2,x
3254  04a1 ae0000        	ldw	x,#0
3255  04a4 bf15          	ldw	_led_green,x
3256  04a6 acdd05dd      	jpf	L1271
3257  04aa               L5571:
3258                     ; 370 			else if(flags&0b00001000)
3260  04aa b60a          	ld	a,_flags
3261  04ac a508          	bcp	a,#8
3262  04ae 272d          	jreq	L5671
3263                     ; 372 				led_red=0x00090009L;
3265  04b0 ae0009        	ldw	x,#9
3266  04b3 bf13          	ldw	_led_red+2,x
3267  04b5 ae0009        	ldw	x,#9
3268  04b8 bf11          	ldw	_led_red,x
3269                     ; 373 				if(bMAIN)led_green=0x00000005L;
3271                     	btst	_bMAIN
3272  04bf 240e          	jruge	L7671
3275  04c1 ae0005        	ldw	x,#5
3276  04c4 bf17          	ldw	_led_green+2,x
3277  04c6 ae0000        	ldw	x,#0
3278  04c9 bf15          	ldw	_led_green,x
3280  04cb acdd05dd      	jpf	L1271
3281  04cf               L7671:
3282                     ; 374 				else led_green=0x00000000L;	
3284  04cf ae0000        	ldw	x,#0
3285  04d2 bf17          	ldw	_led_green+2,x
3286  04d4 ae0000        	ldw	x,#0
3287  04d7 bf15          	ldw	_led_green,x
3288  04d9 acdd05dd      	jpf	L1271
3289  04dd               L5671:
3290                     ; 376 			else if(flags&0b00010000)
3292  04dd b60a          	ld	a,_flags
3293  04df a510          	bcp	a,#16
3294  04e1 272d          	jreq	L5771
3295                     ; 378 				led_red=0x00490049L;
3297  04e3 ae0049        	ldw	x,#73
3298  04e6 bf13          	ldw	_led_red+2,x
3299  04e8 ae0049        	ldw	x,#73
3300  04eb bf11          	ldw	_led_red,x
3301                     ; 379 				if(bMAIN)led_green=0x00000005L;
3303                     	btst	_bMAIN
3304  04f2 240e          	jruge	L7771
3307  04f4 ae0005        	ldw	x,#5
3308  04f7 bf17          	ldw	_led_green+2,x
3309  04f9 ae0000        	ldw	x,#0
3310  04fc bf15          	ldw	_led_green,x
3312  04fe acdd05dd      	jpf	L1271
3313  0502               L7771:
3314                     ; 380 				else led_green=0x00000000L;	
3316  0502 ae0000        	ldw	x,#0
3317  0505 bf17          	ldw	_led_green+2,x
3318  0507 ae0000        	ldw	x,#0
3319  050a bf15          	ldw	_led_green,x
3320  050c acdd05dd      	jpf	L1271
3321  0510               L5771:
3322                     ; 384 				led_red=0x55555555L;
3324  0510 ae5555        	ldw	x,#21845
3325  0513 bf13          	ldw	_led_red+2,x
3326  0515 ae5555        	ldw	x,#21845
3327  0518 bf11          	ldw	_led_red,x
3328                     ; 385 				led_green=0xffffffffL;
3330  051a aeffff        	ldw	x,#65535
3331  051d bf17          	ldw	_led_green+2,x
3332  051f aeffff        	ldw	x,#-1
3333  0522 bf15          	ldw	_led_green,x
3334  0524 acdd05dd      	jpf	L1271
3335  0528               L3371:
3336                     ; 401 		else if((link==ON)&&((flags&0b00111110)==0))
3338  0528 b65f          	ld	a,_link
3339  052a a155          	cp	a,#85
3340  052c 261d          	jrne	L7002
3342  052e b60a          	ld	a,_flags
3343  0530 a53e          	bcp	a,#62
3344  0532 2617          	jrne	L7002
3345                     ; 403 			led_red=0x00000000L;
3347  0534 ae0000        	ldw	x,#0
3348  0537 bf13          	ldw	_led_red+2,x
3349  0539 ae0000        	ldw	x,#0
3350  053c bf11          	ldw	_led_red,x
3351                     ; 404 			led_green=0xffffffffL;
3353  053e aeffff        	ldw	x,#65535
3354  0541 bf17          	ldw	_led_green+2,x
3355  0543 aeffff        	ldw	x,#-1
3356  0546 bf15          	ldw	_led_green,x
3358  0548 cc05dd        	jra	L1271
3359  054b               L7002:
3360                     ; 407 		else if((flags&0b00111110)==0b00000100)
3362  054b b60a          	ld	a,_flags
3363  054d a43e          	and	a,#62
3364  054f a104          	cp	a,#4
3365  0551 2616          	jrne	L3102
3366                     ; 409 			led_red=0x00010001L;
3368  0553 ae0001        	ldw	x,#1
3369  0556 bf13          	ldw	_led_red+2,x
3370  0558 ae0001        	ldw	x,#1
3371  055b bf11          	ldw	_led_red,x
3372                     ; 410 			led_green=0xffffffffL;	
3374  055d aeffff        	ldw	x,#65535
3375  0560 bf17          	ldw	_led_green+2,x
3376  0562 aeffff        	ldw	x,#-1
3377  0565 bf15          	ldw	_led_green,x
3379  0567 2074          	jra	L1271
3380  0569               L3102:
3381                     ; 412 		else if(flags&0b00000010)
3383  0569 b60a          	ld	a,_flags
3384  056b a502          	bcp	a,#2
3385  056d 2716          	jreq	L7102
3386                     ; 414 			led_red=0x00010001L;
3388  056f ae0001        	ldw	x,#1
3389  0572 bf13          	ldw	_led_red+2,x
3390  0574 ae0001        	ldw	x,#1
3391  0577 bf11          	ldw	_led_red,x
3392                     ; 415 			led_green=0x00000000L;	
3394  0579 ae0000        	ldw	x,#0
3395  057c bf17          	ldw	_led_green+2,x
3396  057e ae0000        	ldw	x,#0
3397  0581 bf15          	ldw	_led_green,x
3399  0583 2058          	jra	L1271
3400  0585               L7102:
3401                     ; 417 		else if(flags&0b00001000)
3403  0585 b60a          	ld	a,_flags
3404  0587 a508          	bcp	a,#8
3405  0589 2716          	jreq	L3202
3406                     ; 419 			led_red=0x00090009L;
3408  058b ae0009        	ldw	x,#9
3409  058e bf13          	ldw	_led_red+2,x
3410  0590 ae0009        	ldw	x,#9
3411  0593 bf11          	ldw	_led_red,x
3412                     ; 420 			led_green=0x00000000L;	
3414  0595 ae0000        	ldw	x,#0
3415  0598 bf17          	ldw	_led_green+2,x
3416  059a ae0000        	ldw	x,#0
3417  059d bf15          	ldw	_led_green,x
3419  059f 203c          	jra	L1271
3420  05a1               L3202:
3421                     ; 422 		else if(flags&0b00010000)
3423  05a1 b60a          	ld	a,_flags
3424  05a3 a510          	bcp	a,#16
3425  05a5 2716          	jreq	L7202
3426                     ; 424 			led_red=0x00490049L;
3428  05a7 ae0049        	ldw	x,#73
3429  05aa bf13          	ldw	_led_red+2,x
3430  05ac ae0049        	ldw	x,#73
3431  05af bf11          	ldw	_led_red,x
3432                     ; 425 			led_green=0x00000000L;	
3434  05b1 ae0000        	ldw	x,#0
3435  05b4 bf17          	ldw	_led_green+2,x
3436  05b6 ae0000        	ldw	x,#0
3437  05b9 bf15          	ldw	_led_green,x
3439  05bb 2020          	jra	L1271
3440  05bd               L7202:
3441                     ; 428 		else if((link==ON)&&(flags&0b00100000))
3443  05bd b65f          	ld	a,_link
3444  05bf a155          	cp	a,#85
3445  05c1 261a          	jrne	L1271
3447  05c3 b60a          	ld	a,_flags
3448  05c5 a520          	bcp	a,#32
3449  05c7 2714          	jreq	L1271
3450                     ; 430 			led_red=0x00000000L;
3452  05c9 ae0000        	ldw	x,#0
3453  05cc bf13          	ldw	_led_red+2,x
3454  05ce ae0000        	ldw	x,#0
3455  05d1 bf11          	ldw	_led_red,x
3456                     ; 431 			led_green=0x00030003L;
3458  05d3 ae0003        	ldw	x,#3
3459  05d6 bf17          	ldw	_led_green+2,x
3460  05d8 ae0003        	ldw	x,#3
3461  05db bf15          	ldw	_led_green,x
3462  05dd               L1271:
3463                     ; 434 		if((jp_mode==jp1))
3465  05dd b647          	ld	a,_jp_mode
3466  05df a101          	cp	a,#1
3467  05e1 2618          	jrne	L5302
3468                     ; 436 			led_red=0x00000000L;
3470  05e3 ae0000        	ldw	x,#0
3471  05e6 bf13          	ldw	_led_red+2,x
3472  05e8 ae0000        	ldw	x,#0
3473  05eb bf11          	ldw	_led_red,x
3474                     ; 437 			led_green=0x33333333L;
3476  05ed ae3333        	ldw	x,#13107
3477  05f0 bf17          	ldw	_led_green+2,x
3478  05f2 ae3333        	ldw	x,#13107
3479  05f5 bf15          	ldw	_led_green,x
3481  05f7 ac100710      	jpf	L1751
3482  05fb               L5302:
3483                     ; 439 		else if((jp_mode==jp2))
3485  05fb b647          	ld	a,_jp_mode
3486  05fd a102          	cp	a,#2
3487  05ff 2703          	jreq	L43
3488  0601 cc0710        	jp	L1751
3489  0604               L43:
3490                     ; 443 			led_red=0xccccccccL;
3492  0604 aecccc        	ldw	x,#52428
3493  0607 bf13          	ldw	_led_red+2,x
3494  0609 aecccc        	ldw	x,#-13108
3495  060c bf11          	ldw	_led_red,x
3496                     ; 444 			led_green=0x00000000L;
3498  060e ae0000        	ldw	x,#0
3499  0611 bf17          	ldw	_led_green+2,x
3500  0613 ae0000        	ldw	x,#0
3501  0616 bf15          	ldw	_led_green,x
3502  0618 ac100710      	jpf	L1751
3503  061c               L5171:
3504                     ; 447 	else if(jp_mode==jp3)
3506  061c b647          	ld	a,_jp_mode
3507  061e a103          	cp	a,#3
3508  0620 2703          	jreq	L63
3509  0622 cc0710        	jp	L1751
3510  0625               L63:
3511                     ; 449 		if(main_cnt1<(5*ee_TZAS))
3513  0625 9c            	rvf
3514  0626 ce0014        	ldw	x,_ee_TZAS
3515  0629 90ae0005      	ldw	y,#5
3516  062d cd0000        	call	c_imul
3518  0630 b34c          	cpw	x,_main_cnt1
3519  0632 2d18          	jrsle	L7402
3520                     ; 451 			led_red=0x00000000L;
3522  0634 ae0000        	ldw	x,#0
3523  0637 bf13          	ldw	_led_red+2,x
3524  0639 ae0000        	ldw	x,#0
3525  063c bf11          	ldw	_led_red,x
3526                     ; 452 			led_green=0x03030303L;
3528  063e ae0303        	ldw	x,#771
3529  0641 bf17          	ldw	_led_green+2,x
3530  0643 ae0303        	ldw	x,#771
3531  0646 bf15          	ldw	_led_green,x
3533  0648 ac100710      	jpf	L1751
3534  064c               L7402:
3535                     ; 454 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3537  064c 9c            	rvf
3538  064d ce0014        	ldw	x,_ee_TZAS
3539  0650 90ae0005      	ldw	y,#5
3540  0654 cd0000        	call	c_imul
3542  0657 b34c          	cpw	x,_main_cnt1
3543  0659 2e29          	jrsge	L3502
3545  065b 9c            	rvf
3546  065c ce0014        	ldw	x,_ee_TZAS
3547  065f 90ae0005      	ldw	y,#5
3548  0663 cd0000        	call	c_imul
3550  0666 1c0046        	addw	x,#70
3551  0669 b34c          	cpw	x,_main_cnt1
3552  066b 2d17          	jrsle	L3502
3553                     ; 456 			led_red=0x00000000L;
3555  066d ae0000        	ldw	x,#0
3556  0670 bf13          	ldw	_led_red+2,x
3557  0672 ae0000        	ldw	x,#0
3558  0675 bf11          	ldw	_led_red,x
3559                     ; 457 			led_green=0xffffffffL;	
3561  0677 aeffff        	ldw	x,#65535
3562  067a bf17          	ldw	_led_green+2,x
3563  067c aeffff        	ldw	x,#-1
3564  067f bf15          	ldw	_led_green,x
3566  0681 cc0710        	jra	L1751
3567  0684               L3502:
3568                     ; 460 		else if((flags&0b00011110)==0)
3570  0684 b60a          	ld	a,_flags
3571  0686 a51e          	bcp	a,#30
3572  0688 2616          	jrne	L7502
3573                     ; 462 			led_red=0x00000000L;
3575  068a ae0000        	ldw	x,#0
3576  068d bf13          	ldw	_led_red+2,x
3577  068f ae0000        	ldw	x,#0
3578  0692 bf11          	ldw	_led_red,x
3579                     ; 463 			led_green=0xffffffffL;
3581  0694 aeffff        	ldw	x,#65535
3582  0697 bf17          	ldw	_led_green+2,x
3583  0699 aeffff        	ldw	x,#-1
3584  069c bf15          	ldw	_led_green,x
3586  069e 2070          	jra	L1751
3587  06a0               L7502:
3588                     ; 467 		else if((flags&0b00111110)==0b00000100)
3590  06a0 b60a          	ld	a,_flags
3591  06a2 a43e          	and	a,#62
3592  06a4 a104          	cp	a,#4
3593  06a6 2616          	jrne	L3602
3594                     ; 469 			led_red=0x00010001L;
3596  06a8 ae0001        	ldw	x,#1
3597  06ab bf13          	ldw	_led_red+2,x
3598  06ad ae0001        	ldw	x,#1
3599  06b0 bf11          	ldw	_led_red,x
3600                     ; 470 			led_green=0xffffffffL;	
3602  06b2 aeffff        	ldw	x,#65535
3603  06b5 bf17          	ldw	_led_green+2,x
3604  06b7 aeffff        	ldw	x,#-1
3605  06ba bf15          	ldw	_led_green,x
3607  06bc 2052          	jra	L1751
3608  06be               L3602:
3609                     ; 472 		else if(flags&0b00000010)
3611  06be b60a          	ld	a,_flags
3612  06c0 a502          	bcp	a,#2
3613  06c2 2716          	jreq	L7602
3614                     ; 474 			led_red=0x00010001L;
3616  06c4 ae0001        	ldw	x,#1
3617  06c7 bf13          	ldw	_led_red+2,x
3618  06c9 ae0001        	ldw	x,#1
3619  06cc bf11          	ldw	_led_red,x
3620                     ; 475 			led_green=0x00000000L;	
3622  06ce ae0000        	ldw	x,#0
3623  06d1 bf17          	ldw	_led_green+2,x
3624  06d3 ae0000        	ldw	x,#0
3625  06d6 bf15          	ldw	_led_green,x
3627  06d8 2036          	jra	L1751
3628  06da               L7602:
3629                     ; 477 		else if(flags&0b00001000)
3631  06da b60a          	ld	a,_flags
3632  06dc a508          	bcp	a,#8
3633  06de 2716          	jreq	L3702
3634                     ; 479 			led_red=0x00090009L;
3636  06e0 ae0009        	ldw	x,#9
3637  06e3 bf13          	ldw	_led_red+2,x
3638  06e5 ae0009        	ldw	x,#9
3639  06e8 bf11          	ldw	_led_red,x
3640                     ; 480 			led_green=0x00000000L;	
3642  06ea ae0000        	ldw	x,#0
3643  06ed bf17          	ldw	_led_green+2,x
3644  06ef ae0000        	ldw	x,#0
3645  06f2 bf15          	ldw	_led_green,x
3647  06f4 201a          	jra	L1751
3648  06f6               L3702:
3649                     ; 482 		else if(flags&0b00010000)
3651  06f6 b60a          	ld	a,_flags
3652  06f8 a510          	bcp	a,#16
3653  06fa 2714          	jreq	L1751
3654                     ; 484 			led_red=0x00490049L;
3656  06fc ae0049        	ldw	x,#73
3657  06ff bf13          	ldw	_led_red+2,x
3658  0701 ae0049        	ldw	x,#73
3659  0704 bf11          	ldw	_led_red,x
3660                     ; 485 			led_green=0xffffffffL;	
3662  0706 aeffff        	ldw	x,#65535
3663  0709 bf17          	ldw	_led_green+2,x
3664  070b aeffff        	ldw	x,#-1
3665  070e bf15          	ldw	_led_green,x
3666  0710               L1751:
3667                     ; 489 }
3670  0710 81            	ret
3699                     ; 492 void led_drv(void)
3699                     ; 493 {
3700                     	switch	.text
3701  0711               _led_drv:
3705                     ; 495 GPIOA->DDR|=(1<<4);
3707  0711 72185002      	bset	20482,#4
3708                     ; 496 GPIOA->CR1|=(1<<4);
3710  0715 72185003      	bset	20483,#4
3711                     ; 497 GPIOA->CR2&=~(1<<4);
3713  0719 72195004      	bres	20484,#4
3714                     ; 498 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3716  071d b63d          	ld	a,_led_red_buff+3
3717  071f a501          	bcp	a,#1
3718  0721 2706          	jreq	L1112
3721  0723 72185000      	bset	20480,#4
3723  0727 2004          	jra	L3112
3724  0729               L1112:
3725                     ; 499 else GPIOA->ODR&=~(1<<4); 
3727  0729 72195000      	bres	20480,#4
3728  072d               L3112:
3729                     ; 502 GPIOA->DDR|=(1<<5);
3731  072d 721a5002      	bset	20482,#5
3732                     ; 503 GPIOA->CR1|=(1<<5);
3734  0731 721a5003      	bset	20483,#5
3735                     ; 504 GPIOA->CR2&=~(1<<5);	
3737  0735 721b5004      	bres	20484,#5
3738                     ; 505 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3740  0739 b639          	ld	a,_led_green_buff+3
3741  073b a501          	bcp	a,#1
3742  073d 2706          	jreq	L5112
3745  073f 721a5000      	bset	20480,#5
3747  0743 2004          	jra	L7112
3748  0745               L5112:
3749                     ; 506 else GPIOA->ODR&=~(1<<5);
3751  0745 721b5000      	bres	20480,#5
3752  0749               L7112:
3753                     ; 509 led_red_buff>>=1;
3755  0749 373a          	sra	_led_red_buff
3756  074b 363b          	rrc	_led_red_buff+1
3757  074d 363c          	rrc	_led_red_buff+2
3758  074f 363d          	rrc	_led_red_buff+3
3759                     ; 510 led_green_buff>>=1;
3761  0751 3736          	sra	_led_green_buff
3762  0753 3637          	rrc	_led_green_buff+1
3763  0755 3638          	rrc	_led_green_buff+2
3764  0757 3639          	rrc	_led_green_buff+3
3765                     ; 511 if(++led_drv_cnt>32)
3767  0759 3c19          	inc	_led_drv_cnt
3768  075b b619          	ld	a,_led_drv_cnt
3769  075d a121          	cp	a,#33
3770  075f 2512          	jrult	L1212
3771                     ; 513 	led_drv_cnt=0;
3773  0761 3f19          	clr	_led_drv_cnt
3774                     ; 514 	led_red_buff=led_red;
3776  0763 be13          	ldw	x,_led_red+2
3777  0765 bf3c          	ldw	_led_red_buff+2,x
3778  0767 be11          	ldw	x,_led_red
3779  0769 bf3a          	ldw	_led_red_buff,x
3780                     ; 515 	led_green_buff=led_green;
3782  076b be17          	ldw	x,_led_green+2
3783  076d bf38          	ldw	_led_green_buff+2,x
3784  076f be15          	ldw	x,_led_green
3785  0771 bf36          	ldw	_led_green_buff,x
3786  0773               L1212:
3787                     ; 523 GPIOB->DDR|=(1<<3);
3789  0773 72165007      	bset	20487,#3
3790                     ; 524 GPIOB->CR1|=(1<<3);
3792  0777 72165008      	bset	20488,#3
3793                     ; 525 GPIOB->CR2&=~(1<<3);
3795  077b 72175009      	bres	20489,#3
3796                     ; 526 if((flags&0b00011010)==0) GPIOB->ODR|=(1<<3); 	//Если нет аварий то реле под ток
3798  077f b60a          	ld	a,_flags
3799  0781 a51a          	bcp	a,#26
3800  0783 2606          	jrne	L3212
3803  0785 72165005      	bset	20485,#3
3805  0789 2004          	jra	L5212
3806  078b               L3212:
3807                     ; 527 else GPIOB->ODR&=~(1<<3);					//Если есть то обесточиваем 
3809  078b 72175005      	bres	20485,#3
3810  078f               L5212:
3811                     ; 529 } 
3814  078f 81            	ret
3840                     ; 532 void JP_drv(void)
3840                     ; 533 {
3841                     	switch	.text
3842  0790               _JP_drv:
3846                     ; 535 GPIOD->DDR&=~(1<<6);
3848  0790 721d5011      	bres	20497,#6
3849                     ; 536 GPIOD->CR1|=(1<<6);
3851  0794 721c5012      	bset	20498,#6
3852                     ; 537 GPIOD->CR2&=~(1<<6);
3854  0798 721d5013      	bres	20499,#6
3855                     ; 539 GPIOD->DDR&=~(1<<7);
3857  079c 721f5011      	bres	20497,#7
3858                     ; 540 GPIOD->CR1|=(1<<7);
3860  07a0 721e5012      	bset	20498,#7
3861                     ; 541 GPIOD->CR2&=~(1<<7);
3863  07a4 721f5013      	bres	20499,#7
3864                     ; 543 if(GPIOD->IDR&(1<<6))
3866  07a8 c65010        	ld	a,20496
3867  07ab a540          	bcp	a,#64
3868  07ad 270a          	jreq	L7312
3869                     ; 545 	if(cnt_JP0<10)
3871  07af b646          	ld	a,_cnt_JP0
3872  07b1 a10a          	cp	a,#10
3873  07b3 2411          	jruge	L3412
3874                     ; 547 		cnt_JP0++;
3876  07b5 3c46          	inc	_cnt_JP0
3877  07b7 200d          	jra	L3412
3878  07b9               L7312:
3879                     ; 550 else if(!(GPIOD->IDR&(1<<6)))
3881  07b9 c65010        	ld	a,20496
3882  07bc a540          	bcp	a,#64
3883  07be 2606          	jrne	L3412
3884                     ; 552 	if(cnt_JP0)
3886  07c0 3d46          	tnz	_cnt_JP0
3887  07c2 2702          	jreq	L3412
3888                     ; 554 		cnt_JP0--;
3890  07c4 3a46          	dec	_cnt_JP0
3891  07c6               L3412:
3892                     ; 558 if(GPIOD->IDR&(1<<7))
3894  07c6 c65010        	ld	a,20496
3895  07c9 a580          	bcp	a,#128
3896  07cb 270a          	jreq	L1512
3897                     ; 560 	if(cnt_JP1<10)
3899  07cd b645          	ld	a,_cnt_JP1
3900  07cf a10a          	cp	a,#10
3901  07d1 2411          	jruge	L5512
3902                     ; 562 		cnt_JP1++;
3904  07d3 3c45          	inc	_cnt_JP1
3905  07d5 200d          	jra	L5512
3906  07d7               L1512:
3907                     ; 565 else if(!(GPIOD->IDR&(1<<7)))
3909  07d7 c65010        	ld	a,20496
3910  07da a580          	bcp	a,#128
3911  07dc 2606          	jrne	L5512
3912                     ; 567 	if(cnt_JP1)
3914  07de 3d45          	tnz	_cnt_JP1
3915  07e0 2702          	jreq	L5512
3916                     ; 569 		cnt_JP1--;
3918  07e2 3a45          	dec	_cnt_JP1
3919  07e4               L5512:
3920                     ; 574 if((cnt_JP0==10)&&(cnt_JP1==10))
3922  07e4 b646          	ld	a,_cnt_JP0
3923  07e6 a10a          	cp	a,#10
3924  07e8 2608          	jrne	L3612
3926  07ea b645          	ld	a,_cnt_JP1
3927  07ec a10a          	cp	a,#10
3928  07ee 2602          	jrne	L3612
3929                     ; 576 	jp_mode=jp0;
3931  07f0 3f47          	clr	_jp_mode
3932  07f2               L3612:
3933                     ; 578 if((cnt_JP0==0)&&(cnt_JP1==10))
3935  07f2 3d46          	tnz	_cnt_JP0
3936  07f4 260a          	jrne	L5612
3938  07f6 b645          	ld	a,_cnt_JP1
3939  07f8 a10a          	cp	a,#10
3940  07fa 2604          	jrne	L5612
3941                     ; 580 	jp_mode=jp1;
3943  07fc 35010047      	mov	_jp_mode,#1
3944  0800               L5612:
3945                     ; 582 if((cnt_JP0==10)&&(cnt_JP1==0))
3947  0800 b646          	ld	a,_cnt_JP0
3948  0802 a10a          	cp	a,#10
3949  0804 2608          	jrne	L7612
3951  0806 3d45          	tnz	_cnt_JP1
3952  0808 2604          	jrne	L7612
3953                     ; 584 	jp_mode=jp2;
3955  080a 35020047      	mov	_jp_mode,#2
3956  080e               L7612:
3957                     ; 586 if((cnt_JP0==0)&&(cnt_JP1==0))
3959  080e 3d46          	tnz	_cnt_JP0
3960  0810 2608          	jrne	L1712
3962  0812 3d45          	tnz	_cnt_JP1
3963  0814 2604          	jrne	L1712
3964                     ; 588 	jp_mode=jp3;
3966  0816 35030047      	mov	_jp_mode,#3
3967  081a               L1712:
3968                     ; 591 }
3971  081a 81            	ret
4003                     ; 594 void link_drv(void)		//10Hz
4003                     ; 595 {
4004                     	switch	.text
4005  081b               _link_drv:
4009                     ; 596 if(jp_mode!=jp3)
4011  081b b647          	ld	a,_jp_mode
4012  081d a103          	cp	a,#3
4013  081f 2744          	jreq	L3022
4014                     ; 598 	if(link_cnt<52)link_cnt++;
4016  0821 b65e          	ld	a,_link_cnt
4017  0823 a134          	cp	a,#52
4018  0825 2402          	jruge	L5022
4021  0827 3c5e          	inc	_link_cnt
4022  0829               L5022:
4023                     ; 599 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4025  0829 b65e          	ld	a,_link_cnt
4026  082b a131          	cp	a,#49
4027  082d 2606          	jrne	L7022
4030  082f b60a          	ld	a,_flags
4031  0831 a4c1          	and	a,#193
4032  0833 b70a          	ld	_flags,a
4033  0835               L7022:
4034                     ; 600 	if(link_cnt==50)
4036  0835 b65e          	ld	a,_link_cnt
4037  0837 a132          	cp	a,#50
4038  0839 262e          	jrne	L1222
4039                     ; 602 		link=OFF;
4041  083b 35aa005f      	mov	_link,#170
4042                     ; 607 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4044  083f b601          	ld	a,_bps_class
4045  0841 a101          	cp	a,#1
4046  0843 2606          	jrne	L3122
4049  0845 72100001      	bset	_bMAIN
4051  0849 2004          	jra	L5122
4052  084b               L3122:
4053                     ; 608 		else bMAIN=0;
4055  084b 72110001      	bres	_bMAIN
4056  084f               L5122:
4057                     ; 610 		cnt_net_drv=0;
4059  084f 3f2f          	clr	_cnt_net_drv
4060                     ; 611     		if(!res_fl_)
4062  0851 725d0008      	tnz	_res_fl_
4063  0855 2612          	jrne	L1222
4064                     ; 613 	    		bRES_=1;
4066  0857 35010010      	mov	_bRES_,#1
4067                     ; 614 	    		res_fl_=1;
4069  085b a601          	ld	a,#1
4070  085d ae0008        	ldw	x,#_res_fl_
4071  0860 cd0000        	call	c_eewrc
4073  0863 2004          	jra	L1222
4074  0865               L3022:
4075                     ; 618 else link=OFF;	
4077  0865 35aa005f      	mov	_link,#170
4078  0869               L1222:
4079                     ; 619 } 
4082  0869 81            	ret
4151                     .const:	section	.text
4152  0000               L05:
4153  0000 0000000b      	dc.l	11
4154  0004               L25:
4155  0004 00000001      	dc.l	1
4156                     ; 623 void vent_drv(void)
4156                     ; 624 {
4157                     	switch	.text
4158  086a               _vent_drv:
4160  086a 520e          	subw	sp,#14
4161       0000000e      OFST:	set	14
4164                     ; 627 	short vent_pwm_i_necc=400;
4166  086c ae0190        	ldw	x,#400
4167  086f 1f07          	ldw	(OFST-7,sp),x
4168                     ; 628 	short vent_pwm_t_necc=400;
4170  0871 ae0190        	ldw	x,#400
4171  0874 1f09          	ldw	(OFST-5,sp),x
4172                     ; 629 	short vent_pwm_max_necc=400;
4174                     ; 634 	tempSL=36000L/(signed long)ee_Umax;
4176  0876 ce0012        	ldw	x,_ee_Umax
4177  0879 cd0000        	call	c_itolx
4179  087c 96            	ldw	x,sp
4180  087d 1c0001        	addw	x,#OFST-13
4181  0880 cd0000        	call	c_rtol
4183  0883 ae8ca0        	ldw	x,#36000
4184  0886 bf02          	ldw	c_lreg+2,x
4185  0888 ae0000        	ldw	x,#0
4186  088b bf00          	ldw	c_lreg,x
4187  088d 96            	ldw	x,sp
4188  088e 1c0001        	addw	x,#OFST-13
4189  0891 cd0000        	call	c_ldiv
4191  0894 96            	ldw	x,sp
4192  0895 1c000b        	addw	x,#OFST-3
4193  0898 cd0000        	call	c_rtol
4195                     ; 635 	tempSL=(signed long)I/tempSL;
4197  089b be6b          	ldw	x,_I
4198  089d cd0000        	call	c_itolx
4200  08a0 96            	ldw	x,sp
4201  08a1 1c000b        	addw	x,#OFST-3
4202  08a4 cd0000        	call	c_ldiv
4204  08a7 96            	ldw	x,sp
4205  08a8 1c000b        	addw	x,#OFST-3
4206  08ab cd0000        	call	c_rtol
4208                     ; 637 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4210  08ae ce0002        	ldw	x,_ee_DEVICE
4211  08b1 a30001        	cpw	x,#1
4212  08b4 2613          	jrne	L5522
4215  08b6 be6b          	ldw	x,_I
4216  08b8 90ce0000      	ldw	y,_ee_IMAXVENT
4217  08bc cd0000        	call	c_idiv
4219  08bf cd0000        	call	c_itolx
4221  08c2 96            	ldw	x,sp
4222  08c3 1c000b        	addw	x,#OFST-3
4223  08c6 cd0000        	call	c_rtol
4225  08c9               L5522:
4226                     ; 639 	if(tempSL>10)vent_pwm_i_necc=1000;
4228  08c9 9c            	rvf
4229  08ca 96            	ldw	x,sp
4230  08cb 1c000b        	addw	x,#OFST-3
4231  08ce cd0000        	call	c_ltor
4233  08d1 ae0000        	ldw	x,#L05
4234  08d4 cd0000        	call	c_lcmp
4236  08d7 2f07          	jrslt	L7522
4239  08d9 ae03e8        	ldw	x,#1000
4240  08dc 1f07          	ldw	(OFST-7,sp),x
4242  08de 2025          	jra	L1622
4243  08e0               L7522:
4244                     ; 640 	else if(tempSL<1)vent_pwm_i_necc=400;
4246  08e0 9c            	rvf
4247  08e1 96            	ldw	x,sp
4248  08e2 1c000b        	addw	x,#OFST-3
4249  08e5 cd0000        	call	c_ltor
4251  08e8 ae0004        	ldw	x,#L25
4252  08eb cd0000        	call	c_lcmp
4254  08ee 2e07          	jrsge	L3622
4257  08f0 ae0190        	ldw	x,#400
4258  08f3 1f07          	ldw	(OFST-7,sp),x
4260  08f5 200e          	jra	L1622
4261  08f7               L3622:
4262                     ; 641 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4264  08f7 1e0d          	ldw	x,(OFST-1,sp)
4265  08f9 90ae003c      	ldw	y,#60
4266  08fd cd0000        	call	c_imul
4268  0900 1c0190        	addw	x,#400
4269  0903 1f07          	ldw	(OFST-7,sp),x
4270  0905               L1622:
4271                     ; 642 	gran(&vent_pwm_i_necc,400,1000);
4273  0905 ae03e8        	ldw	x,#1000
4274  0908 89            	pushw	x
4275  0909 ae0190        	ldw	x,#400
4276  090c 89            	pushw	x
4277  090d 96            	ldw	x,sp
4278  090e 1c000b        	addw	x,#OFST-3
4279  0911 cd0000        	call	_gran
4281  0914 5b04          	addw	sp,#4
4282                     ; 644 	tempSL=(signed long)T;
4284  0916 b664          	ld	a,_T
4285  0918 b703          	ld	c_lreg+3,a
4286  091a 48            	sll	a
4287  091b 4f            	clr	a
4288  091c a200          	sbc	a,#0
4289  091e b702          	ld	c_lreg+2,a
4290  0920 b701          	ld	c_lreg+1,a
4291  0922 b700          	ld	c_lreg,a
4292  0924 96            	ldw	x,sp
4293  0925 1c000b        	addw	x,#OFST-3
4294  0928 cd0000        	call	c_rtol
4296                     ; 645 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4298  092b 9c            	rvf
4299  092c ce000c        	ldw	x,_ee_tsign
4300  092f cd0000        	call	c_itolx
4302  0932 a61e          	ld	a,#30
4303  0934 cd0000        	call	c_lsbc
4305  0937 96            	ldw	x,sp
4306  0938 1c000b        	addw	x,#OFST-3
4307  093b cd0000        	call	c_lcmp
4309  093e 2f07          	jrslt	L7622
4312  0940 ae0190        	ldw	x,#400
4313  0943 1f09          	ldw	(OFST-5,sp),x
4315  0945 2030          	jra	L1722
4316  0947               L7622:
4317                     ; 646 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4319  0947 9c            	rvf
4320  0948 ce000c        	ldw	x,_ee_tsign
4321  094b cd0000        	call	c_itolx
4323  094e 96            	ldw	x,sp
4324  094f 1c000b        	addw	x,#OFST-3
4325  0952 cd0000        	call	c_lcmp
4327  0955 2c07          	jrsgt	L3722
4330  0957 ae03e8        	ldw	x,#1000
4331  095a 1f09          	ldw	(OFST-5,sp),x
4333  095c 2019          	jra	L1722
4334  095e               L3722:
4335                     ; 647 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4337  095e ce000c        	ldw	x,_ee_tsign
4338  0961 1d001e        	subw	x,#30
4339  0964 1f03          	ldw	(OFST-11,sp),x
4340  0966 1e0d          	ldw	x,(OFST-1,sp)
4341  0968 72f003        	subw	x,(OFST-11,sp)
4342  096b 90ae0014      	ldw	y,#20
4343  096f cd0000        	call	c_imul
4345  0972 1c0190        	addw	x,#400
4346  0975 1f09          	ldw	(OFST-5,sp),x
4347  0977               L1722:
4348                     ; 648 	gran(&vent_pwm_t_necc,400,1000);
4350  0977 ae03e8        	ldw	x,#1000
4351  097a 89            	pushw	x
4352  097b ae0190        	ldw	x,#400
4353  097e 89            	pushw	x
4354  097f 96            	ldw	x,sp
4355  0980 1c000d        	addw	x,#OFST-1
4356  0983 cd0000        	call	_gran
4358  0986 5b04          	addw	sp,#4
4359                     ; 650 	vent_pwm_max_necc=vent_pwm_i_necc;
4361  0988 1e07          	ldw	x,(OFST-7,sp)
4362  098a 1f05          	ldw	(OFST-9,sp),x
4363                     ; 651 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4365  098c 9c            	rvf
4366  098d 1e09          	ldw	x,(OFST-5,sp)
4367  098f 1307          	cpw	x,(OFST-7,sp)
4368  0991 2d04          	jrsle	L7722
4371  0993 1e09          	ldw	x,(OFST-5,sp)
4372  0995 1f05          	ldw	(OFST-9,sp),x
4373  0997               L7722:
4374                     ; 653 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4376  0997 9c            	rvf
4377  0998 be02          	ldw	x,_vent_pwm
4378  099a 1305          	cpw	x,(OFST-9,sp)
4379  099c 2e07          	jrsge	L1032
4382  099e be02          	ldw	x,_vent_pwm
4383  09a0 1c000a        	addw	x,#10
4384  09a3 bf02          	ldw	_vent_pwm,x
4385  09a5               L1032:
4386                     ; 654 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4388  09a5 9c            	rvf
4389  09a6 be02          	ldw	x,_vent_pwm
4390  09a8 1305          	cpw	x,(OFST-9,sp)
4391  09aa 2d07          	jrsle	L3032
4394  09ac be02          	ldw	x,_vent_pwm
4395  09ae 1d000a        	subw	x,#10
4396  09b1 bf02          	ldw	_vent_pwm,x
4397  09b3               L3032:
4398                     ; 655 	gran(&vent_pwm,400,1000);
4400  09b3 ae03e8        	ldw	x,#1000
4401  09b6 89            	pushw	x
4402  09b7 ae0190        	ldw	x,#400
4403  09ba 89            	pushw	x
4404  09bb ae0002        	ldw	x,#_vent_pwm
4405  09be cd0000        	call	_gran
4407  09c1 5b04          	addw	sp,#4
4408                     ; 657 	vent_pwm=1000-vent_pwm;	// Для нового блока. Там похоже нужна инверсия
4410  09c3 ae03e8        	ldw	x,#1000
4411  09c6 72b00002      	subw	x,_vent_pwm
4412  09ca bf02          	ldw	_vent_pwm,x
4413                     ; 659 }
4416  09cc 5b0e          	addw	sp,#14
4417  09ce 81            	ret
4451                     ; 664 void pwr_drv(void)
4451                     ; 665 {
4452                     	switch	.text
4453  09cf               _pwr_drv:
4457                     ; 669 BLOCK_INIT
4459  09cf 72145007      	bset	20487,#2
4462  09d3 72145008      	bset	20488,#2
4465  09d7 72155009      	bres	20489,#2
4466                     ; 671 if(main_cnt1<1500)main_cnt1++;
4468  09db 9c            	rvf
4469  09dc be4c          	ldw	x,_main_cnt1
4470  09de a305dc        	cpw	x,#1500
4471  09e1 2e07          	jrsge	L5132
4474  09e3 be4c          	ldw	x,_main_cnt1
4475  09e5 1c0001        	addw	x,#1
4476  09e8 bf4c          	ldw	_main_cnt1,x
4477  09ea               L5132:
4478                     ; 673 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4480  09ea 9c            	rvf
4481  09eb ce0014        	ldw	x,_ee_TZAS
4482  09ee 90ae0005      	ldw	y,#5
4483  09f2 cd0000        	call	c_imul
4485  09f5 b34c          	cpw	x,_main_cnt1
4486  09f7 2d0d          	jrsle	L7132
4488  09f9 b601          	ld	a,_bps_class
4489  09fb a101          	cp	a,#1
4490  09fd 2707          	jreq	L7132
4491                     ; 675 	BLOCK_ON
4493  09ff 72145005      	bset	20485,#2
4495  0a03 cc0a8c        	jra	L1232
4496  0a06               L7132:
4497                     ; 678 else if(bps_class==bpsIPS)
4499  0a06 b601          	ld	a,_bps_class
4500  0a08 a101          	cp	a,#1
4501  0a0a 261a          	jrne	L3232
4502                     ; 681 		if(bBL_IPS)
4504                     	btst	_bBL_IPS
4505  0a11 2406          	jruge	L5232
4506                     ; 683 			 BLOCK_ON
4508  0a13 72145005      	bset	20485,#2
4510  0a17 2073          	jra	L1232
4511  0a19               L5232:
4512                     ; 686 		else if(!bBL_IPS)
4514                     	btst	_bBL_IPS
4515  0a1e 256c          	jrult	L1232
4516                     ; 688 			  BLOCK_OFF
4518  0a20 72155005      	bres	20485,#2
4519  0a24 2066          	jra	L1232
4520  0a26               L3232:
4521                     ; 692 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4523  0a26 9c            	rvf
4524  0a27 ce0014        	ldw	x,_ee_TZAS
4525  0a2a 90ae0005      	ldw	y,#5
4526  0a2e cd0000        	call	c_imul
4528  0a31 b34c          	cpw	x,_main_cnt1
4529  0a33 2e3f          	jrsge	L5332
4531  0a35 9c            	rvf
4532  0a36 ce0014        	ldw	x,_ee_TZAS
4533  0a39 90ae0005      	ldw	y,#5
4534  0a3d cd0000        	call	c_imul
4536  0a40 1c0046        	addw	x,#70
4537  0a43 b34c          	cpw	x,_main_cnt1
4538  0a45 2d2d          	jrsle	L5332
4539                     ; 694 	if(bps_class==bpsIPS)
4541  0a47 b601          	ld	a,_bps_class
4542  0a49 a101          	cp	a,#1
4543  0a4b 2606          	jrne	L7332
4544                     ; 696 		  BLOCK_OFF
4546  0a4d 72155005      	bres	20485,#2
4548  0a51 2039          	jra	L1232
4549  0a53               L7332:
4550                     ; 699 	else if(bps_class==bpsIBEP)
4552  0a53 3d01          	tnz	_bps_class
4553  0a55 2635          	jrne	L1232
4554                     ; 701 		if(ee_DEVICE)
4556  0a57 ce0002        	ldw	x,_ee_DEVICE
4557  0a5a 2712          	jreq	L5432
4558                     ; 703 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4560  0a5c b60a          	ld	a,_flags
4561  0a5e a520          	bcp	a,#32
4562  0a60 2706          	jreq	L7432
4565  0a62 72145005      	bset	20485,#2
4567  0a66 2024          	jra	L1232
4568  0a68               L7432:
4569                     ; 704 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4571  0a68 72155005      	bres	20485,#2
4572  0a6c 201e          	jra	L1232
4573  0a6e               L5432:
4574                     ; 708 			BLOCK_OFF
4576  0a6e 72155005      	bres	20485,#2
4577  0a72 2018          	jra	L1232
4578  0a74               L5332:
4579                     ; 713 else if(bBL)
4581                     	btst	_bBL
4582  0a79 2406          	jruge	L7532
4583                     ; 715 	BLOCK_ON
4585  0a7b 72145005      	bset	20485,#2
4587  0a7f 200b          	jra	L1232
4588  0a81               L7532:
4589                     ; 718 else if(!bBL)
4591                     	btst	_bBL
4592  0a86 2504          	jrult	L1232
4593                     ; 720 	BLOCK_OFF
4595  0a88 72155005      	bres	20485,#2
4596  0a8c               L1232:
4597                     ; 724 gran(&pwm_u,2,1020);
4599  0a8c ae03fc        	ldw	x,#1020
4600  0a8f 89            	pushw	x
4601  0a90 ae0002        	ldw	x,#2
4602  0a93 89            	pushw	x
4603  0a94 ae000b        	ldw	x,#_pwm_u
4604  0a97 cd0000        	call	_gran
4606  0a9a 5b04          	addw	sp,#4
4607                     ; 734 TIM1->CCR2H= (char)(pwm_u/256);	
4609  0a9c be0b          	ldw	x,_pwm_u
4610  0a9e 90ae0100      	ldw	y,#256
4611  0aa2 cd0000        	call	c_idiv
4613  0aa5 9f            	ld	a,xl
4614  0aa6 c75267        	ld	21095,a
4615                     ; 735 TIM1->CCR2L= (char)pwm_u;
4617  0aa9 55000c5268    	mov	21096,_pwm_u+1
4618                     ; 737 TIM1->CCR1H= (char)(pwm_i/256);	
4620  0aae be0d          	ldw	x,_pwm_i
4621  0ab0 90ae0100      	ldw	y,#256
4622  0ab4 cd0000        	call	c_idiv
4624  0ab7 9f            	ld	a,xl
4625  0ab8 c75265        	ld	21093,a
4626                     ; 738 TIM1->CCR1L= (char)pwm_i;
4628  0abb 55000e5266    	mov	21094,_pwm_i+1
4629                     ; 740 TIM1->CCR3H= (char)(vent_pwm/256);	
4631  0ac0 be02          	ldw	x,_vent_pwm
4632  0ac2 90ae0100      	ldw	y,#256
4633  0ac6 cd0000        	call	c_idiv
4635  0ac9 9f            	ld	a,xl
4636  0aca c75269        	ld	21097,a
4637                     ; 741 TIM1->CCR3L= (char)vent_pwm;
4639  0acd 550003526a    	mov	21098,_vent_pwm+1
4640                     ; 742 }
4643  0ad2 81            	ret
4681                     ; 747 void pwr_hndl(void)				
4681                     ; 748 {
4682                     	switch	.text
4683  0ad3               _pwr_hndl:
4687                     ; 749 if(jp_mode==jp3)
4689  0ad3 b647          	ld	a,_jp_mode
4690  0ad5 a103          	cp	a,#3
4691  0ad7 2627          	jrne	L5732
4692                     ; 751 	if((flags&0b00001010)==0)
4694  0ad9 b60a          	ld	a,_flags
4695  0adb a50a          	bcp	a,#10
4696  0add 260d          	jrne	L7732
4697                     ; 753 		pwm_u=500;
4699  0adf ae01f4        	ldw	x,#500
4700  0ae2 bf0b          	ldw	_pwm_u,x
4701                     ; 755 		bBL=0;
4703  0ae4 72110003      	bres	_bBL
4705  0ae8 acee0bee      	jpf	L5042
4706  0aec               L7732:
4707                     ; 757 	else if(flags&0b00001010)
4709  0aec b60a          	ld	a,_flags
4710  0aee a50a          	bcp	a,#10
4711  0af0 2603          	jrne	L06
4712  0af2 cc0bee        	jp	L5042
4713  0af5               L06:
4714                     ; 759 		pwm_u=0;
4716  0af5 5f            	clrw	x
4717  0af6 bf0b          	ldw	_pwm_u,x
4718                     ; 761 		bBL=1;
4720  0af8 72100003      	bset	_bBL
4721  0afc acee0bee      	jpf	L5042
4722  0b00               L5732:
4723                     ; 765 else if(jp_mode==jp2)
4725  0b00 b647          	ld	a,_jp_mode
4726  0b02 a102          	cp	a,#2
4727  0b04 2610          	jrne	L7042
4728                     ; 767 	pwm_u=0;
4730  0b06 5f            	clrw	x
4731  0b07 bf0b          	ldw	_pwm_u,x
4732                     ; 768 	pwm_i=0x3ff;
4734  0b09 ae03ff        	ldw	x,#1023
4735  0b0c bf0d          	ldw	_pwm_i,x
4736                     ; 769 	bBL=0;
4738  0b0e 72110003      	bres	_bBL
4740  0b12 acee0bee      	jpf	L5042
4741  0b16               L7042:
4742                     ; 771 else if(jp_mode==jp1)
4744  0b16 b647          	ld	a,_jp_mode
4745  0b18 a101          	cp	a,#1
4746  0b1a 2612          	jrne	L3142
4747                     ; 773 	pwm_u=0x3ff;
4749  0b1c ae03ff        	ldw	x,#1023
4750  0b1f bf0b          	ldw	_pwm_u,x
4751                     ; 774 	pwm_i=0x3ff;
4753  0b21 ae03ff        	ldw	x,#1023
4754  0b24 bf0d          	ldw	_pwm_i,x
4755                     ; 775 	bBL=0;
4757  0b26 72110003      	bres	_bBL
4759  0b2a acee0bee      	jpf	L5042
4760  0b2e               L3142:
4761                     ; 778 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4763                     	btst	_bMAIN
4764  0b33 2417          	jruge	L7142
4766  0b35 b65f          	ld	a,_link
4767  0b37 a155          	cp	a,#85
4768  0b39 2611          	jrne	L7142
4769                     ; 780 	pwm_u=volum_u_main_;
4771  0b3b be1c          	ldw	x,_volum_u_main_
4772  0b3d bf0b          	ldw	_pwm_u,x
4773                     ; 781 	pwm_i=0x3ff;
4775  0b3f ae03ff        	ldw	x,#1023
4776  0b42 bf0d          	ldw	_pwm_i,x
4777                     ; 782 	bBL_IPS=0;
4779  0b44 72110000      	bres	_bBL_IPS
4781  0b48 acee0bee      	jpf	L5042
4782  0b4c               L7142:
4783                     ; 785 else if(link==OFF)
4785  0b4c b65f          	ld	a,_link
4786  0b4e a1aa          	cp	a,#170
4787  0b50 2650          	jrne	L3242
4788                     ; 794  	if(ee_DEVICE)
4790  0b52 ce0002        	ldw	x,_ee_DEVICE
4791  0b55 270d          	jreq	L5242
4792                     ; 796 		pwm_u=0x00;
4794  0b57 5f            	clrw	x
4795  0b58 bf0b          	ldw	_pwm_u,x
4796                     ; 797 		pwm_i=0x00;
4798  0b5a 5f            	clrw	x
4799  0b5b bf0d          	ldw	_pwm_i,x
4800                     ; 798 		bBL=1;
4802  0b5d 72100003      	bset	_bBL
4804  0b61 cc0bee        	jra	L5042
4805  0b64               L5242:
4806                     ; 802 		if((flags&0b00011010)==0)
4808  0b64 b60a          	ld	a,_flags
4809  0b66 a51a          	bcp	a,#26
4810  0b68 2622          	jrne	L1342
4811                     ; 804 			pwm_u=ee_U_AVT;
4813  0b6a ce000a        	ldw	x,_ee_U_AVT
4814  0b6d bf0b          	ldw	_pwm_u,x
4815                     ; 805 			gran(&pwm_u,0,1020);
4817  0b6f ae03fc        	ldw	x,#1020
4818  0b72 89            	pushw	x
4819  0b73 5f            	clrw	x
4820  0b74 89            	pushw	x
4821  0b75 ae000b        	ldw	x,#_pwm_u
4822  0b78 cd0000        	call	_gran
4824  0b7b 5b04          	addw	sp,#4
4825                     ; 806 		    	pwm_i=0x3ff;
4827  0b7d ae03ff        	ldw	x,#1023
4828  0b80 bf0d          	ldw	_pwm_i,x
4829                     ; 807 			bBL=0;
4831  0b82 72110003      	bres	_bBL
4832                     ; 808 			bBL_IPS=0;
4834  0b86 72110000      	bres	_bBL_IPS
4836  0b8a 2062          	jra	L5042
4837  0b8c               L1342:
4838                     ; 810 		else if(flags&0b00011010)
4840  0b8c b60a          	ld	a,_flags
4841  0b8e a51a          	bcp	a,#26
4842  0b90 275c          	jreq	L5042
4843                     ; 812 			pwm_u=0;
4845  0b92 5f            	clrw	x
4846  0b93 bf0b          	ldw	_pwm_u,x
4847                     ; 813 			pwm_i=0;
4849  0b95 5f            	clrw	x
4850  0b96 bf0d          	ldw	_pwm_i,x
4851                     ; 814 			bBL=1;
4853  0b98 72100003      	bset	_bBL
4854                     ; 815 			bBL_IPS=1;
4856  0b9c 72100000      	bset	_bBL_IPS
4857  0ba0 204c          	jra	L5042
4858  0ba2               L3242:
4859                     ; 824 else	if(link==ON)				//если есть связь
4861  0ba2 b65f          	ld	a,_link
4862  0ba4 a155          	cp	a,#85
4863  0ba6 2646          	jrne	L5042
4864                     ; 826 	if((flags&0b00100000)==0)	//если нет блокировки извне
4866  0ba8 b60a          	ld	a,_flags
4867  0baa a520          	bcp	a,#32
4868  0bac 2630          	jrne	L3442
4869                     ; 828 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4871  0bae b60a          	ld	a,_flags
4872  0bb0 a51a          	bcp	a,#26
4873  0bb2 2706          	jreq	L7442
4875  0bb4 b60a          	ld	a,_flags
4876  0bb6 a540          	bcp	a,#64
4877  0bb8 2712          	jreq	L5442
4878  0bba               L7442:
4879                     ; 830 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4881  0bba be5b          	ldw	x,__x_
4882  0bbc 72bb0055      	addw	x,_vol_u_temp
4883  0bc0 bf0b          	ldw	_pwm_u,x
4884                     ; 831 		    	pwm_i=vol_i_temp;
4886  0bc2 be53          	ldw	x,_vol_i_temp
4887  0bc4 bf0d          	ldw	_pwm_i,x
4888                     ; 832 			bBL=0;
4890  0bc6 72110003      	bres	_bBL
4892  0bca 2022          	jra	L5042
4893  0bcc               L5442:
4894                     ; 834 		else if(flags&0b00011010)					//если есть аварии
4896  0bcc b60a          	ld	a,_flags
4897  0bce a51a          	bcp	a,#26
4898  0bd0 271c          	jreq	L5042
4899                     ; 836 			pwm_u=0;								//то полный стоп
4901  0bd2 5f            	clrw	x
4902  0bd3 bf0b          	ldw	_pwm_u,x
4903                     ; 837 			pwm_i=0;
4905  0bd5 5f            	clrw	x
4906  0bd6 bf0d          	ldw	_pwm_i,x
4907                     ; 838 			bBL=1;
4909  0bd8 72100003      	bset	_bBL
4910  0bdc 2010          	jra	L5042
4911  0bde               L3442:
4912                     ; 841 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4914  0bde b60a          	ld	a,_flags
4915  0be0 a520          	bcp	a,#32
4916  0be2 270a          	jreq	L5042
4917                     ; 843 		pwm_u=0;
4919  0be4 5f            	clrw	x
4920  0be5 bf0b          	ldw	_pwm_u,x
4921                     ; 844 	    	pwm_i=0;
4923  0be7 5f            	clrw	x
4924  0be8 bf0d          	ldw	_pwm_i,x
4925                     ; 845 		bBL=1;
4927  0bea 72100003      	bset	_bBL
4928  0bee               L5042:
4929                     ; 851 }
4932  0bee 81            	ret
4974                     	switch	.const
4975  0008               L46:
4976  0008 00000258      	dc.l	600
4977  000c               L66:
4978  000c 00000708      	dc.l	1800
4979  0010               L07:
4980  0010 000003e8      	dc.l	1000
4981                     ; 854 void matemat(void)
4981                     ; 855 {
4982                     	switch	.text
4983  0bef               _matemat:
4985  0bef 5204          	subw	sp,#4
4986       00000004      OFST:	set	4
4989                     ; 876 temp_SL=adc_buff_[4];
4991  0bf1 ce000d        	ldw	x,_adc_buff_+8
4992  0bf4 cd0000        	call	c_itolx
4994  0bf7 96            	ldw	x,sp
4995  0bf8 1c0001        	addw	x,#OFST-3
4996  0bfb cd0000        	call	c_rtol
4998                     ; 877 temp_SL-=ee_K[0][0];
5000  0bfe ce0018        	ldw	x,_ee_K
5001  0c01 cd0000        	call	c_itolx
5003  0c04 96            	ldw	x,sp
5004  0c05 1c0001        	addw	x,#OFST-3
5005  0c08 cd0000        	call	c_lgsub
5007                     ; 878 if(temp_SL<0) temp_SL=0;
5009  0c0b 9c            	rvf
5010  0c0c 0d01          	tnz	(OFST-3,sp)
5011  0c0e 2e0a          	jrsge	L7742
5014  0c10 ae0000        	ldw	x,#0
5015  0c13 1f03          	ldw	(OFST-1,sp),x
5016  0c15 ae0000        	ldw	x,#0
5017  0c18 1f01          	ldw	(OFST-3,sp),x
5018  0c1a               L7742:
5019                     ; 879 temp_SL*=ee_K[0][1];
5021  0c1a ce001a        	ldw	x,_ee_K+2
5022  0c1d cd0000        	call	c_itolx
5024  0c20 96            	ldw	x,sp
5025  0c21 1c0001        	addw	x,#OFST-3
5026  0c24 cd0000        	call	c_lgmul
5028                     ; 880 temp_SL/=600;
5030  0c27 96            	ldw	x,sp
5031  0c28 1c0001        	addw	x,#OFST-3
5032  0c2b cd0000        	call	c_ltor
5034  0c2e ae0008        	ldw	x,#L46
5035  0c31 cd0000        	call	c_ldiv
5037  0c34 96            	ldw	x,sp
5038  0c35 1c0001        	addw	x,#OFST-3
5039  0c38 cd0000        	call	c_rtol
5041                     ; 881 I=(signed short)temp_SL;
5043  0c3b 1e03          	ldw	x,(OFST-1,sp)
5044  0c3d bf6b          	ldw	_I,x
5045                     ; 886 temp_SL=(signed long)adc_buff_[1];
5047  0c3f ce0007        	ldw	x,_adc_buff_+2
5048  0c42 cd0000        	call	c_itolx
5050  0c45 96            	ldw	x,sp
5051  0c46 1c0001        	addw	x,#OFST-3
5052  0c49 cd0000        	call	c_rtol
5054                     ; 888 if(temp_SL<0) temp_SL=0;
5056  0c4c 9c            	rvf
5057  0c4d 0d01          	tnz	(OFST-3,sp)
5058  0c4f 2e0a          	jrsge	L1052
5061  0c51 ae0000        	ldw	x,#0
5062  0c54 1f03          	ldw	(OFST-1,sp),x
5063  0c56 ae0000        	ldw	x,#0
5064  0c59 1f01          	ldw	(OFST-3,sp),x
5065  0c5b               L1052:
5066                     ; 889 temp_SL*=(signed long)ee_K[2][1];
5068  0c5b ce0022        	ldw	x,_ee_K+10
5069  0c5e cd0000        	call	c_itolx
5071  0c61 96            	ldw	x,sp
5072  0c62 1c0001        	addw	x,#OFST-3
5073  0c65 cd0000        	call	c_lgmul
5075                     ; 890 temp_SL/=1800L;
5077  0c68 96            	ldw	x,sp
5078  0c69 1c0001        	addw	x,#OFST-3
5079  0c6c cd0000        	call	c_ltor
5081  0c6f ae000c        	ldw	x,#L66
5082  0c72 cd0000        	call	c_ldiv
5084  0c75 96            	ldw	x,sp
5085  0c76 1c0001        	addw	x,#OFST-3
5086  0c79 cd0000        	call	c_rtol
5088                     ; 891 Ui=(unsigned short)temp_SL;
5090  0c7c 1e03          	ldw	x,(OFST-1,sp)
5091  0c7e bf67          	ldw	_Ui,x
5092                     ; 898 temp_SL=adc_buff_[3];
5094  0c80 ce000b        	ldw	x,_adc_buff_+6
5095  0c83 cd0000        	call	c_itolx
5097  0c86 96            	ldw	x,sp
5098  0c87 1c0001        	addw	x,#OFST-3
5099  0c8a cd0000        	call	c_rtol
5101                     ; 900 if(temp_SL<0) temp_SL=0;
5103  0c8d 9c            	rvf
5104  0c8e 0d01          	tnz	(OFST-3,sp)
5105  0c90 2e0a          	jrsge	L3052
5108  0c92 ae0000        	ldw	x,#0
5109  0c95 1f03          	ldw	(OFST-1,sp),x
5110  0c97 ae0000        	ldw	x,#0
5111  0c9a 1f01          	ldw	(OFST-3,sp),x
5112  0c9c               L3052:
5113                     ; 901 temp_SL*=ee_K[1][1];
5115  0c9c ce001e        	ldw	x,_ee_K+6
5116  0c9f cd0000        	call	c_itolx
5118  0ca2 96            	ldw	x,sp
5119  0ca3 1c0001        	addw	x,#OFST-3
5120  0ca6 cd0000        	call	c_lgmul
5122                     ; 902 temp_SL/=1800;
5124  0ca9 96            	ldw	x,sp
5125  0caa 1c0001        	addw	x,#OFST-3
5126  0cad cd0000        	call	c_ltor
5128  0cb0 ae000c        	ldw	x,#L66
5129  0cb3 cd0000        	call	c_ldiv
5131  0cb6 96            	ldw	x,sp
5132  0cb7 1c0001        	addw	x,#OFST-3
5133  0cba cd0000        	call	c_rtol
5135                     ; 903 Un=(unsigned short)temp_SL;
5137  0cbd 1e03          	ldw	x,(OFST-1,sp)
5138  0cbf bf69          	ldw	_Un,x
5139                     ; 906 temp_SL=adc_buff_[2];
5141  0cc1 ce0009        	ldw	x,_adc_buff_+4
5142  0cc4 cd0000        	call	c_itolx
5144  0cc7 96            	ldw	x,sp
5145  0cc8 1c0001        	addw	x,#OFST-3
5146  0ccb cd0000        	call	c_rtol
5148                     ; 907 temp_SL*=ee_K[3][1];
5150  0cce ce0026        	ldw	x,_ee_K+14
5151  0cd1 cd0000        	call	c_itolx
5153  0cd4 96            	ldw	x,sp
5154  0cd5 1c0001        	addw	x,#OFST-3
5155  0cd8 cd0000        	call	c_lgmul
5157                     ; 908 temp_SL/=1000;
5159  0cdb 96            	ldw	x,sp
5160  0cdc 1c0001        	addw	x,#OFST-3
5161  0cdf cd0000        	call	c_ltor
5163  0ce2 ae0010        	ldw	x,#L07
5164  0ce5 cd0000        	call	c_ldiv
5166  0ce8 96            	ldw	x,sp
5167  0ce9 1c0001        	addw	x,#OFST-3
5168  0cec cd0000        	call	c_rtol
5170                     ; 909 T=(signed short)(temp_SL-273L);
5172  0cef 7b04          	ld	a,(OFST+0,sp)
5173  0cf1 5f            	clrw	x
5174  0cf2 4d            	tnz	a
5175  0cf3 2a01          	jrpl	L27
5176  0cf5 53            	cplw	x
5177  0cf6               L27:
5178  0cf6 97            	ld	xl,a
5179  0cf7 1d0111        	subw	x,#273
5180  0cfa 01            	rrwa	x,a
5181  0cfb b764          	ld	_T,a
5182  0cfd 02            	rlwa	x,a
5183                     ; 910 if(T<-30)T=-30;
5185  0cfe 9c            	rvf
5186  0cff b664          	ld	a,_T
5187  0d01 a1e2          	cp	a,#226
5188  0d03 2e04          	jrsge	L5052
5191  0d05 35e20064      	mov	_T,#226
5192  0d09               L5052:
5193                     ; 911 if(T>120)T=120;
5195  0d09 9c            	rvf
5196  0d0a b664          	ld	a,_T
5197  0d0c a179          	cp	a,#121
5198  0d0e 2f04          	jrslt	L7052
5201  0d10 35780064      	mov	_T,#120
5202  0d14               L7052:
5203                     ; 913 Udb=flags;
5205  0d14 b60a          	ld	a,_flags
5206  0d16 5f            	clrw	x
5207  0d17 97            	ld	xl,a
5208  0d18 bf65          	ldw	_Udb,x
5209                     ; 919 }
5212  0d1a 5b04          	addw	sp,#4
5213  0d1c 81            	ret
5244                     ; 922 void temper_drv(void)		//1 Hz
5244                     ; 923 {
5245                     	switch	.text
5246  0d1d               _temper_drv:
5250                     ; 925 if(T>ee_tsign) tsign_cnt++;
5252  0d1d 9c            	rvf
5253  0d1e 5f            	clrw	x
5254  0d1f b664          	ld	a,_T
5255  0d21 2a01          	jrpl	L67
5256  0d23 53            	cplw	x
5257  0d24               L67:
5258  0d24 97            	ld	xl,a
5259  0d25 c3000c        	cpw	x,_ee_tsign
5260  0d28 2d09          	jrsle	L1252
5263  0d2a be4a          	ldw	x,_tsign_cnt
5264  0d2c 1c0001        	addw	x,#1
5265  0d2f bf4a          	ldw	_tsign_cnt,x
5267  0d31 201d          	jra	L3252
5268  0d33               L1252:
5269                     ; 926 else if (T<(ee_tsign-1)) tsign_cnt--;
5271  0d33 9c            	rvf
5272  0d34 ce000c        	ldw	x,_ee_tsign
5273  0d37 5a            	decw	x
5274  0d38 905f          	clrw	y
5275  0d3a b664          	ld	a,_T
5276  0d3c 2a02          	jrpl	L001
5277  0d3e 9053          	cplw	y
5278  0d40               L001:
5279  0d40 9097          	ld	yl,a
5280  0d42 90bf00        	ldw	c_y,y
5281  0d45 b300          	cpw	x,c_y
5282  0d47 2d07          	jrsle	L3252
5285  0d49 be4a          	ldw	x,_tsign_cnt
5286  0d4b 1d0001        	subw	x,#1
5287  0d4e bf4a          	ldw	_tsign_cnt,x
5288  0d50               L3252:
5289                     ; 928 gran(&tsign_cnt,0,60);
5291  0d50 ae003c        	ldw	x,#60
5292  0d53 89            	pushw	x
5293  0d54 5f            	clrw	x
5294  0d55 89            	pushw	x
5295  0d56 ae004a        	ldw	x,#_tsign_cnt
5296  0d59 cd0000        	call	_gran
5298  0d5c 5b04          	addw	sp,#4
5299                     ; 930 if(tsign_cnt>=55)
5301  0d5e 9c            	rvf
5302  0d5f be4a          	ldw	x,_tsign_cnt
5303  0d61 a30037        	cpw	x,#55
5304  0d64 2f16          	jrslt	L7252
5305                     ; 932 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5307  0d66 3d47          	tnz	_jp_mode
5308  0d68 2606          	jrne	L5352
5310  0d6a b60a          	ld	a,_flags
5311  0d6c a540          	bcp	a,#64
5312  0d6e 2706          	jreq	L3352
5313  0d70               L5352:
5315  0d70 b647          	ld	a,_jp_mode
5316  0d72 a103          	cp	a,#3
5317  0d74 2612          	jrne	L7352
5318  0d76               L3352:
5321  0d76 7214000a      	bset	_flags,#2
5322  0d7a 200c          	jra	L7352
5323  0d7c               L7252:
5324                     ; 934 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5326  0d7c 9c            	rvf
5327  0d7d be4a          	ldw	x,_tsign_cnt
5328  0d7f a30006        	cpw	x,#6
5329  0d82 2e04          	jrsge	L7352
5332  0d84 7215000a      	bres	_flags,#2
5333  0d88               L7352:
5334                     ; 939 if(T>ee_tmax) tmax_cnt++;
5336  0d88 9c            	rvf
5337  0d89 5f            	clrw	x
5338  0d8a b664          	ld	a,_T
5339  0d8c 2a01          	jrpl	L201
5340  0d8e 53            	cplw	x
5341  0d8f               L201:
5342  0d8f 97            	ld	xl,a
5343  0d90 c3000e        	cpw	x,_ee_tmax
5344  0d93 2d09          	jrsle	L3452
5347  0d95 be48          	ldw	x,_tmax_cnt
5348  0d97 1c0001        	addw	x,#1
5349  0d9a bf48          	ldw	_tmax_cnt,x
5351  0d9c 201d          	jra	L5452
5352  0d9e               L3452:
5353                     ; 940 else if (T<(ee_tmax-1)) tmax_cnt--;
5355  0d9e 9c            	rvf
5356  0d9f ce000e        	ldw	x,_ee_tmax
5357  0da2 5a            	decw	x
5358  0da3 905f          	clrw	y
5359  0da5 b664          	ld	a,_T
5360  0da7 2a02          	jrpl	L401
5361  0da9 9053          	cplw	y
5362  0dab               L401:
5363  0dab 9097          	ld	yl,a
5364  0dad 90bf00        	ldw	c_y,y
5365  0db0 b300          	cpw	x,c_y
5366  0db2 2d07          	jrsle	L5452
5369  0db4 be48          	ldw	x,_tmax_cnt
5370  0db6 1d0001        	subw	x,#1
5371  0db9 bf48          	ldw	_tmax_cnt,x
5372  0dbb               L5452:
5373                     ; 942 gran(&tmax_cnt,0,60);
5375  0dbb ae003c        	ldw	x,#60
5376  0dbe 89            	pushw	x
5377  0dbf 5f            	clrw	x
5378  0dc0 89            	pushw	x
5379  0dc1 ae0048        	ldw	x,#_tmax_cnt
5380  0dc4 cd0000        	call	_gran
5382  0dc7 5b04          	addw	sp,#4
5383                     ; 944 if(tmax_cnt>=55)
5385  0dc9 9c            	rvf
5386  0dca be48          	ldw	x,_tmax_cnt
5387  0dcc a30037        	cpw	x,#55
5388  0dcf 2f16          	jrslt	L1552
5389                     ; 946 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5391  0dd1 3d47          	tnz	_jp_mode
5392  0dd3 2606          	jrne	L7552
5394  0dd5 b60a          	ld	a,_flags
5395  0dd7 a540          	bcp	a,#64
5396  0dd9 2706          	jreq	L5552
5397  0ddb               L7552:
5399  0ddb b647          	ld	a,_jp_mode
5400  0ddd a103          	cp	a,#3
5401  0ddf 2612          	jrne	L1652
5402  0de1               L5552:
5405  0de1 7212000a      	bset	_flags,#1
5406  0de5 200c          	jra	L1652
5407  0de7               L1552:
5408                     ; 948 else if (tmax_cnt<=5) flags&=0b11111101;
5410  0de7 9c            	rvf
5411  0de8 be48          	ldw	x,_tmax_cnt
5412  0dea a30006        	cpw	x,#6
5413  0ded 2e04          	jrsge	L1652
5416  0def 7213000a      	bres	_flags,#1
5417  0df3               L1652:
5418                     ; 951 } 
5421  0df3 81            	ret
5453                     ; 954 void u_drv(void)		//1Hz
5453                     ; 955 { 
5454                     	switch	.text
5455  0df4               _u_drv:
5459                     ; 956 if(jp_mode!=jp3)
5461  0df4 b647          	ld	a,_jp_mode
5462  0df6 a103          	cp	a,#3
5463  0df8 2770          	jreq	L5752
5464                     ; 958 	if(Ui>ee_Umax)umax_cnt++;
5466  0dfa 9c            	rvf
5467  0dfb be67          	ldw	x,_Ui
5468  0dfd c30012        	cpw	x,_ee_Umax
5469  0e00 2d09          	jrsle	L7752
5472  0e02 be62          	ldw	x,_umax_cnt
5473  0e04 1c0001        	addw	x,#1
5474  0e07 bf62          	ldw	_umax_cnt,x
5476  0e09 2003          	jra	L1062
5477  0e0b               L7752:
5478                     ; 959 	else umax_cnt=0;
5480  0e0b 5f            	clrw	x
5481  0e0c bf62          	ldw	_umax_cnt,x
5482  0e0e               L1062:
5483                     ; 960 	gran(&umax_cnt,0,10);
5485  0e0e ae000a        	ldw	x,#10
5486  0e11 89            	pushw	x
5487  0e12 5f            	clrw	x
5488  0e13 89            	pushw	x
5489  0e14 ae0062        	ldw	x,#_umax_cnt
5490  0e17 cd0000        	call	_gran
5492  0e1a 5b04          	addw	sp,#4
5493                     ; 961 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5495  0e1c 9c            	rvf
5496  0e1d be62          	ldw	x,_umax_cnt
5497  0e1f a3000a        	cpw	x,#10
5498  0e22 2f04          	jrslt	L3062
5501  0e24 7216000a      	bset	_flags,#3
5502  0e28               L3062:
5503                     ; 964 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5505  0e28 9c            	rvf
5506  0e29 be67          	ldw	x,_Ui
5507  0e2b b369          	cpw	x,_Un
5508  0e2d 2e1c          	jrsge	L5062
5510  0e2f 9c            	rvf
5511  0e30 be69          	ldw	x,_Un
5512  0e32 72b00067      	subw	x,_Ui
5513  0e36 c30010        	cpw	x,_ee_dU
5514  0e39 2d10          	jrsle	L5062
5516  0e3b c65005        	ld	a,20485
5517  0e3e a504          	bcp	a,#4
5518  0e40 2609          	jrne	L5062
5521  0e42 be60          	ldw	x,_umin_cnt
5522  0e44 1c0001        	addw	x,#1
5523  0e47 bf60          	ldw	_umin_cnt,x
5525  0e49 2003          	jra	L7062
5526  0e4b               L5062:
5527                     ; 965 	else umin_cnt=0;
5529  0e4b 5f            	clrw	x
5530  0e4c bf60          	ldw	_umin_cnt,x
5531  0e4e               L7062:
5532                     ; 966 	gran(&umin_cnt,0,10);	
5534  0e4e ae000a        	ldw	x,#10
5535  0e51 89            	pushw	x
5536  0e52 5f            	clrw	x
5537  0e53 89            	pushw	x
5538  0e54 ae0060        	ldw	x,#_umin_cnt
5539  0e57 cd0000        	call	_gran
5541  0e5a 5b04          	addw	sp,#4
5542                     ; 967 	if(umin_cnt>=10)flags|=0b00010000;	  
5544  0e5c 9c            	rvf
5545  0e5d be60          	ldw	x,_umin_cnt
5546  0e5f a3000a        	cpw	x,#10
5547  0e62 2f6f          	jrslt	L3162
5550  0e64 7218000a      	bset	_flags,#4
5551  0e68 2069          	jra	L3162
5552  0e6a               L5752:
5553                     ; 969 else if(jp_mode==jp3)
5555  0e6a b647          	ld	a,_jp_mode
5556  0e6c a103          	cp	a,#3
5557  0e6e 2663          	jrne	L3162
5558                     ; 971 	if(Ui>700)umax_cnt++;
5560  0e70 9c            	rvf
5561  0e71 be67          	ldw	x,_Ui
5562  0e73 a302bd        	cpw	x,#701
5563  0e76 2f09          	jrslt	L7162
5566  0e78 be62          	ldw	x,_umax_cnt
5567  0e7a 1c0001        	addw	x,#1
5568  0e7d bf62          	ldw	_umax_cnt,x
5570  0e7f 2003          	jra	L1262
5571  0e81               L7162:
5572                     ; 972 	else umax_cnt=0;
5574  0e81 5f            	clrw	x
5575  0e82 bf62          	ldw	_umax_cnt,x
5576  0e84               L1262:
5577                     ; 973 	gran(&umax_cnt,0,10);
5579  0e84 ae000a        	ldw	x,#10
5580  0e87 89            	pushw	x
5581  0e88 5f            	clrw	x
5582  0e89 89            	pushw	x
5583  0e8a ae0062        	ldw	x,#_umax_cnt
5584  0e8d cd0000        	call	_gran
5586  0e90 5b04          	addw	sp,#4
5587                     ; 974 	if(umax_cnt>=10)flags|=0b00001000;
5589  0e92 9c            	rvf
5590  0e93 be62          	ldw	x,_umax_cnt
5591  0e95 a3000a        	cpw	x,#10
5592  0e98 2f04          	jrslt	L3262
5595  0e9a 7216000a      	bset	_flags,#3
5596  0e9e               L3262:
5597                     ; 977 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5599  0e9e 9c            	rvf
5600  0e9f be67          	ldw	x,_Ui
5601  0ea1 a300c8        	cpw	x,#200
5602  0ea4 2e10          	jrsge	L5262
5604  0ea6 c65005        	ld	a,20485
5605  0ea9 a504          	bcp	a,#4
5606  0eab 2609          	jrne	L5262
5609  0ead be60          	ldw	x,_umin_cnt
5610  0eaf 1c0001        	addw	x,#1
5611  0eb2 bf60          	ldw	_umin_cnt,x
5613  0eb4 2003          	jra	L7262
5614  0eb6               L5262:
5615                     ; 978 	else umin_cnt=0;
5617  0eb6 5f            	clrw	x
5618  0eb7 bf60          	ldw	_umin_cnt,x
5619  0eb9               L7262:
5620                     ; 979 	gran(&umin_cnt,0,10);	
5622  0eb9 ae000a        	ldw	x,#10
5623  0ebc 89            	pushw	x
5624  0ebd 5f            	clrw	x
5625  0ebe 89            	pushw	x
5626  0ebf ae0060        	ldw	x,#_umin_cnt
5627  0ec2 cd0000        	call	_gran
5629  0ec5 5b04          	addw	sp,#4
5630                     ; 980 	if(umin_cnt>=10)flags|=0b00010000;	  
5632  0ec7 9c            	rvf
5633  0ec8 be60          	ldw	x,_umin_cnt
5634  0eca a3000a        	cpw	x,#10
5635  0ecd 2f04          	jrslt	L3162
5638  0ecf 7218000a      	bset	_flags,#4
5639  0ed3               L3162:
5640                     ; 982 }
5643  0ed3 81            	ret
5670                     ; 985 void x_drv(void)
5670                     ; 986 {
5671                     	switch	.text
5672  0ed4               _x_drv:
5676                     ; 987 if(_x__==_x_)
5678  0ed4 be59          	ldw	x,__x__
5679  0ed6 b35b          	cpw	x,__x_
5680  0ed8 262a          	jrne	L3462
5681                     ; 989 	if(_x_cnt<60)
5683  0eda 9c            	rvf
5684  0edb be57          	ldw	x,__x_cnt
5685  0edd a3003c        	cpw	x,#60
5686  0ee0 2e25          	jrsge	L3562
5687                     ; 991 		_x_cnt++;
5689  0ee2 be57          	ldw	x,__x_cnt
5690  0ee4 1c0001        	addw	x,#1
5691  0ee7 bf57          	ldw	__x_cnt,x
5692                     ; 992 		if(_x_cnt>=60)
5694  0ee9 9c            	rvf
5695  0eea be57          	ldw	x,__x_cnt
5696  0eec a3003c        	cpw	x,#60
5697  0eef 2f16          	jrslt	L3562
5698                     ; 994 			if(_x_ee_!=_x_)_x_ee_=_x_;
5700  0ef1 ce0016        	ldw	x,__x_ee_
5701  0ef4 b35b          	cpw	x,__x_
5702  0ef6 270f          	jreq	L3562
5705  0ef8 be5b          	ldw	x,__x_
5706  0efa 89            	pushw	x
5707  0efb ae0016        	ldw	x,#__x_ee_
5708  0efe cd0000        	call	c_eewrw
5710  0f01 85            	popw	x
5711  0f02 2003          	jra	L3562
5712  0f04               L3462:
5713                     ; 999 else _x_cnt=0;
5715  0f04 5f            	clrw	x
5716  0f05 bf57          	ldw	__x_cnt,x
5717  0f07               L3562:
5718                     ; 1001 if(_x_cnt>60) _x_cnt=0;	
5720  0f07 9c            	rvf
5721  0f08 be57          	ldw	x,__x_cnt
5722  0f0a a3003d        	cpw	x,#61
5723  0f0d 2f03          	jrslt	L5562
5726  0f0f 5f            	clrw	x
5727  0f10 bf57          	ldw	__x_cnt,x
5728  0f12               L5562:
5729                     ; 1003 _x__=_x_;
5731  0f12 be5b          	ldw	x,__x_
5732  0f14 bf59          	ldw	__x__,x
5733                     ; 1004 }
5736  0f16 81            	ret
5762                     ; 1007 void apv_start(void)
5762                     ; 1008 {
5763                     	switch	.text
5764  0f17               _apv_start:
5768                     ; 1009 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5770  0f17 3d42          	tnz	_apv_cnt
5771  0f19 2624          	jrne	L7662
5773  0f1b 3d43          	tnz	_apv_cnt+1
5774  0f1d 2620          	jrne	L7662
5776  0f1f 3d44          	tnz	_apv_cnt+2
5777  0f21 261c          	jrne	L7662
5779                     	btst	_bAPV
5780  0f28 2515          	jrult	L7662
5781                     ; 1011 	apv_cnt[0]=60;
5783  0f2a 353c0042      	mov	_apv_cnt,#60
5784                     ; 1012 	apv_cnt[1]=60;
5786  0f2e 353c0043      	mov	_apv_cnt+1,#60
5787                     ; 1013 	apv_cnt[2]=60;
5789  0f32 353c0044      	mov	_apv_cnt+2,#60
5790                     ; 1014 	apv_cnt_=3600;
5792  0f36 ae0e10        	ldw	x,#3600
5793  0f39 bf40          	ldw	_apv_cnt_,x
5794                     ; 1015 	bAPV=1;	
5796  0f3b 72100002      	bset	_bAPV
5797  0f3f               L7662:
5798                     ; 1017 }
5801  0f3f 81            	ret
5827                     ; 1020 void apv_stop(void)
5827                     ; 1021 {
5828                     	switch	.text
5829  0f40               _apv_stop:
5833                     ; 1022 apv_cnt[0]=0;
5835  0f40 3f42          	clr	_apv_cnt
5836                     ; 1023 apv_cnt[1]=0;
5838  0f42 3f43          	clr	_apv_cnt+1
5839                     ; 1024 apv_cnt[2]=0;
5841  0f44 3f44          	clr	_apv_cnt+2
5842                     ; 1025 apv_cnt_=0;	
5844  0f46 5f            	clrw	x
5845  0f47 bf40          	ldw	_apv_cnt_,x
5846                     ; 1026 bAPV=0;
5848  0f49 72110002      	bres	_bAPV
5849                     ; 1027 }
5852  0f4d 81            	ret
5887                     ; 1031 void apv_hndl(void)
5887                     ; 1032 {
5888                     	switch	.text
5889  0f4e               _apv_hndl:
5893                     ; 1033 if(apv_cnt[0])
5895  0f4e 3d42          	tnz	_apv_cnt
5896  0f50 271e          	jreq	L1172
5897                     ; 1035 	apv_cnt[0]--;
5899  0f52 3a42          	dec	_apv_cnt
5900                     ; 1036 	if(apv_cnt[0]==0)
5902  0f54 3d42          	tnz	_apv_cnt
5903  0f56 265a          	jrne	L5172
5904                     ; 1038 		flags&=0b11100001;
5906  0f58 b60a          	ld	a,_flags
5907  0f5a a4e1          	and	a,#225
5908  0f5c b70a          	ld	_flags,a
5909                     ; 1039 		tsign_cnt=0;
5911  0f5e 5f            	clrw	x
5912  0f5f bf4a          	ldw	_tsign_cnt,x
5913                     ; 1040 		tmax_cnt=0;
5915  0f61 5f            	clrw	x
5916  0f62 bf48          	ldw	_tmax_cnt,x
5917                     ; 1041 		umax_cnt=0;
5919  0f64 5f            	clrw	x
5920  0f65 bf62          	ldw	_umax_cnt,x
5921                     ; 1042 		umin_cnt=0;
5923  0f67 5f            	clrw	x
5924  0f68 bf60          	ldw	_umin_cnt,x
5925                     ; 1044 		led_drv_cnt=30;
5927  0f6a 351e0019      	mov	_led_drv_cnt,#30
5928  0f6e 2042          	jra	L5172
5929  0f70               L1172:
5930                     ; 1047 else if(apv_cnt[1])
5932  0f70 3d43          	tnz	_apv_cnt+1
5933  0f72 271e          	jreq	L7172
5934                     ; 1049 	apv_cnt[1]--;
5936  0f74 3a43          	dec	_apv_cnt+1
5937                     ; 1050 	if(apv_cnt[1]==0)
5939  0f76 3d43          	tnz	_apv_cnt+1
5940  0f78 2638          	jrne	L5172
5941                     ; 1052 		flags&=0b11100001;
5943  0f7a b60a          	ld	a,_flags
5944  0f7c a4e1          	and	a,#225
5945  0f7e b70a          	ld	_flags,a
5946                     ; 1053 		tsign_cnt=0;
5948  0f80 5f            	clrw	x
5949  0f81 bf4a          	ldw	_tsign_cnt,x
5950                     ; 1054 		tmax_cnt=0;
5952  0f83 5f            	clrw	x
5953  0f84 bf48          	ldw	_tmax_cnt,x
5954                     ; 1055 		umax_cnt=0;
5956  0f86 5f            	clrw	x
5957  0f87 bf62          	ldw	_umax_cnt,x
5958                     ; 1056 		umin_cnt=0;
5960  0f89 5f            	clrw	x
5961  0f8a bf60          	ldw	_umin_cnt,x
5962                     ; 1058 		led_drv_cnt=30;
5964  0f8c 351e0019      	mov	_led_drv_cnt,#30
5965  0f90 2020          	jra	L5172
5966  0f92               L7172:
5967                     ; 1061 else if(apv_cnt[2])
5969  0f92 3d44          	tnz	_apv_cnt+2
5970  0f94 271c          	jreq	L5172
5971                     ; 1063 	apv_cnt[2]--;
5973  0f96 3a44          	dec	_apv_cnt+2
5974                     ; 1064 	if(apv_cnt[2]==0)
5976  0f98 3d44          	tnz	_apv_cnt+2
5977  0f9a 2616          	jrne	L5172
5978                     ; 1066 		flags&=0b11100001;
5980  0f9c b60a          	ld	a,_flags
5981  0f9e a4e1          	and	a,#225
5982  0fa0 b70a          	ld	_flags,a
5983                     ; 1067 		tsign_cnt=0;
5985  0fa2 5f            	clrw	x
5986  0fa3 bf4a          	ldw	_tsign_cnt,x
5987                     ; 1068 		tmax_cnt=0;
5989  0fa5 5f            	clrw	x
5990  0fa6 bf48          	ldw	_tmax_cnt,x
5991                     ; 1069 		umax_cnt=0;
5993  0fa8 5f            	clrw	x
5994  0fa9 bf62          	ldw	_umax_cnt,x
5995                     ; 1070 		umin_cnt=0;          
5997  0fab 5f            	clrw	x
5998  0fac bf60          	ldw	_umin_cnt,x
5999                     ; 1072 		led_drv_cnt=30;
6001  0fae 351e0019      	mov	_led_drv_cnt,#30
6002  0fb2               L5172:
6003                     ; 1076 if(apv_cnt_)
6005  0fb2 be40          	ldw	x,_apv_cnt_
6006  0fb4 2712          	jreq	L1372
6007                     ; 1078 	apv_cnt_--;
6009  0fb6 be40          	ldw	x,_apv_cnt_
6010  0fb8 1d0001        	subw	x,#1
6011  0fbb bf40          	ldw	_apv_cnt_,x
6012                     ; 1079 	if(apv_cnt_==0) 
6014  0fbd be40          	ldw	x,_apv_cnt_
6015  0fbf 2607          	jrne	L1372
6016                     ; 1081 		bAPV=0;
6018  0fc1 72110002      	bres	_bAPV
6019                     ; 1082 		apv_start();
6021  0fc5 cd0f17        	call	_apv_start
6023  0fc8               L1372:
6024                     ; 1086 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6026  0fc8 be60          	ldw	x,_umin_cnt
6027  0fca 261e          	jrne	L5372
6029  0fcc be62          	ldw	x,_umax_cnt
6030  0fce 261a          	jrne	L5372
6032  0fd0 c65005        	ld	a,20485
6033  0fd3 a504          	bcp	a,#4
6034  0fd5 2613          	jrne	L5372
6035                     ; 1088 	if(cnt_apv_off<20)
6037  0fd7 b63f          	ld	a,_cnt_apv_off
6038  0fd9 a114          	cp	a,#20
6039  0fdb 240f          	jruge	L3472
6040                     ; 1090 		cnt_apv_off++;
6042  0fdd 3c3f          	inc	_cnt_apv_off
6043                     ; 1091 		if(cnt_apv_off>=20)
6045  0fdf b63f          	ld	a,_cnt_apv_off
6046  0fe1 a114          	cp	a,#20
6047  0fe3 2507          	jrult	L3472
6048                     ; 1093 			apv_stop();
6050  0fe5 cd0f40        	call	_apv_stop
6052  0fe8 2002          	jra	L3472
6053  0fea               L5372:
6054                     ; 1097 else cnt_apv_off=0;	
6056  0fea 3f3f          	clr	_cnt_apv_off
6057  0fec               L3472:
6058                     ; 1099 }
6061  0fec 81            	ret
6064                     	switch	.ubsct
6065  0000               L5472_flags_old:
6066  0000 00            	ds.b	1
6102                     ; 1102 void flags_drv(void)
6102                     ; 1103 {
6103                     	switch	.text
6104  0fed               _flags_drv:
6108                     ; 1105 if(jp_mode!=jp3) 
6110  0fed b647          	ld	a,_jp_mode
6111  0fef a103          	cp	a,#3
6112  0ff1 2723          	jreq	L5672
6113                     ; 1107 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6115  0ff3 b60a          	ld	a,_flags
6116  0ff5 a508          	bcp	a,#8
6117  0ff7 2706          	jreq	L3772
6119  0ff9 b600          	ld	a,L5472_flags_old
6120  0ffb a508          	bcp	a,#8
6121  0ffd 270c          	jreq	L1772
6122  0fff               L3772:
6124  0fff b60a          	ld	a,_flags
6125  1001 a510          	bcp	a,#16
6126  1003 2726          	jreq	L7772
6128  1005 b600          	ld	a,L5472_flags_old
6129  1007 a510          	bcp	a,#16
6130  1009 2620          	jrne	L7772
6131  100b               L1772:
6132                     ; 1109     		if(link==OFF)apv_start();
6134  100b b65f          	ld	a,_link
6135  100d a1aa          	cp	a,#170
6136  100f 261a          	jrne	L7772
6139  1011 cd0f17        	call	_apv_start
6141  1014 2015          	jra	L7772
6142  1016               L5672:
6143                     ; 1112 else if(jp_mode==jp3) 
6145  1016 b647          	ld	a,_jp_mode
6146  1018 a103          	cp	a,#3
6147  101a 260f          	jrne	L7772
6148                     ; 1114 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6150  101c b60a          	ld	a,_flags
6151  101e a508          	bcp	a,#8
6152  1020 2709          	jreq	L7772
6154  1022 b600          	ld	a,L5472_flags_old
6155  1024 a508          	bcp	a,#8
6156  1026 2603          	jrne	L7772
6157                     ; 1116     		apv_start();
6159  1028 cd0f17        	call	_apv_start
6161  102b               L7772:
6162                     ; 1119 flags_old=flags;
6164  102b 450a00        	mov	L5472_flags_old,_flags
6165                     ; 1121 } 
6168  102e 81            	ret
6203                     ; 1258 void adr_drv_v4(char in)
6203                     ; 1259 {
6204                     	switch	.text
6205  102f               _adr_drv_v4:
6209                     ; 1260 if(adress!=in)adress=in;
6211  102f c10001        	cp	a,_adress
6212  1032 2703          	jreq	L3203
6215  1034 c70001        	ld	_adress,a
6216  1037               L3203:
6217                     ; 1261 }
6220  1037 81            	ret
6249                     ; 1264 void adr_drv_v3(void)
6249                     ; 1265 {
6250                     	switch	.text
6251  1038               _adr_drv_v3:
6253  1038 88            	push	a
6254       00000001      OFST:	set	1
6257                     ; 1271 GPIOB->DDR&=~(1<<0);
6259  1039 72115007      	bres	20487,#0
6260                     ; 1272 GPIOB->CR1&=~(1<<0);
6262  103d 72115008      	bres	20488,#0
6263                     ; 1273 GPIOB->CR2&=~(1<<0);
6265  1041 72115009      	bres	20489,#0
6266                     ; 1274 ADC2->CR2=0x08;
6268  1045 35085402      	mov	21506,#8
6269                     ; 1275 ADC2->CR1=0x40;
6271  1049 35405401      	mov	21505,#64
6272                     ; 1276 ADC2->CSR=0x20+0;
6274  104d 35205400      	mov	21504,#32
6275                     ; 1277 ADC2->CR1|=1;
6277  1051 72105401      	bset	21505,#0
6278                     ; 1278 ADC2->CR1|=1;
6280  1055 72105401      	bset	21505,#0
6281                     ; 1279 adr_drv_stat=1;
6283  1059 35010007      	mov	_adr_drv_stat,#1
6284  105d               L5303:
6285                     ; 1280 while(adr_drv_stat==1);
6288  105d b607          	ld	a,_adr_drv_stat
6289  105f a101          	cp	a,#1
6290  1061 27fa          	jreq	L5303
6291                     ; 1282 GPIOB->DDR&=~(1<<1);
6293  1063 72135007      	bres	20487,#1
6294                     ; 1283 GPIOB->CR1&=~(1<<1);
6296  1067 72135008      	bres	20488,#1
6297                     ; 1284 GPIOB->CR2&=~(1<<1);
6299  106b 72135009      	bres	20489,#1
6300                     ; 1285 ADC2->CR2=0x08;
6302  106f 35085402      	mov	21506,#8
6303                     ; 1286 ADC2->CR1=0x40;
6305  1073 35405401      	mov	21505,#64
6306                     ; 1287 ADC2->CSR=0x20+1;
6308  1077 35215400      	mov	21504,#33
6309                     ; 1288 ADC2->CR1|=1;
6311  107b 72105401      	bset	21505,#0
6312                     ; 1289 ADC2->CR1|=1;
6314  107f 72105401      	bset	21505,#0
6315                     ; 1290 adr_drv_stat=3;
6317  1083 35030007      	mov	_adr_drv_stat,#3
6318  1087               L3403:
6319                     ; 1291 while(adr_drv_stat==3);
6322  1087 b607          	ld	a,_adr_drv_stat
6323  1089 a103          	cp	a,#3
6324  108b 27fa          	jreq	L3403
6325                     ; 1293 GPIOE->DDR&=~(1<<6);
6327  108d 721d5016      	bres	20502,#6
6328                     ; 1294 GPIOE->CR1&=~(1<<6);
6330  1091 721d5017      	bres	20503,#6
6331                     ; 1295 GPIOE->CR2&=~(1<<6);
6333  1095 721d5018      	bres	20504,#6
6334                     ; 1296 ADC2->CR2=0x08;
6336  1099 35085402      	mov	21506,#8
6337                     ; 1297 ADC2->CR1=0x40;
6339  109d 35405401      	mov	21505,#64
6340                     ; 1298 ADC2->CSR=0x20+9;
6342  10a1 35295400      	mov	21504,#41
6343                     ; 1299 ADC2->CR1|=1;
6345  10a5 72105401      	bset	21505,#0
6346                     ; 1300 ADC2->CR1|=1;
6348  10a9 72105401      	bset	21505,#0
6349                     ; 1301 adr_drv_stat=5;
6351  10ad 35050007      	mov	_adr_drv_stat,#5
6352  10b1               L1503:
6353                     ; 1302 while(adr_drv_stat==5);
6356  10b1 b607          	ld	a,_adr_drv_stat
6357  10b3 a105          	cp	a,#5
6358  10b5 27fa          	jreq	L1503
6359                     ; 1306 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6361  10b7 9c            	rvf
6362  10b8 ce0005        	ldw	x,_adc_buff_
6363  10bb a3022a        	cpw	x,#554
6364  10be 2f0f          	jrslt	L7503
6366  10c0 9c            	rvf
6367  10c1 ce0005        	ldw	x,_adc_buff_
6368  10c4 a30253        	cpw	x,#595
6369  10c7 2e06          	jrsge	L7503
6372  10c9 725f0002      	clr	_adr
6374  10cd 204c          	jra	L1603
6375  10cf               L7503:
6376                     ; 1307 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6378  10cf 9c            	rvf
6379  10d0 ce0005        	ldw	x,_adc_buff_
6380  10d3 a3036d        	cpw	x,#877
6381  10d6 2f0f          	jrslt	L3603
6383  10d8 9c            	rvf
6384  10d9 ce0005        	ldw	x,_adc_buff_
6385  10dc a30396        	cpw	x,#918
6386  10df 2e06          	jrsge	L3603
6389  10e1 35010002      	mov	_adr,#1
6391  10e5 2034          	jra	L1603
6392  10e7               L3603:
6393                     ; 1308 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6395  10e7 9c            	rvf
6396  10e8 ce0005        	ldw	x,_adc_buff_
6397  10eb a302a3        	cpw	x,#675
6398  10ee 2f0f          	jrslt	L7603
6400  10f0 9c            	rvf
6401  10f1 ce0005        	ldw	x,_adc_buff_
6402  10f4 a302cc        	cpw	x,#716
6403  10f7 2e06          	jrsge	L7603
6406  10f9 35020002      	mov	_adr,#2
6408  10fd 201c          	jra	L1603
6409  10ff               L7603:
6410                     ; 1309 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6412  10ff 9c            	rvf
6413  1100 ce0005        	ldw	x,_adc_buff_
6414  1103 a303e3        	cpw	x,#995
6415  1106 2f0f          	jrslt	L3703
6417  1108 9c            	rvf
6418  1109 ce0005        	ldw	x,_adc_buff_
6419  110c a3040c        	cpw	x,#1036
6420  110f 2e06          	jrsge	L3703
6423  1111 35030002      	mov	_adr,#3
6425  1115 2004          	jra	L1603
6426  1117               L3703:
6427                     ; 1310 else adr[0]=5;
6429  1117 35050002      	mov	_adr,#5
6430  111b               L1603:
6431                     ; 1312 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6433  111b 9c            	rvf
6434  111c ce0007        	ldw	x,_adc_buff_+2
6435  111f a3022a        	cpw	x,#554
6436  1122 2f0f          	jrslt	L7703
6438  1124 9c            	rvf
6439  1125 ce0007        	ldw	x,_adc_buff_+2
6440  1128 a30253        	cpw	x,#595
6441  112b 2e06          	jrsge	L7703
6444  112d 725f0003      	clr	_adr+1
6446  1131 204c          	jra	L1013
6447  1133               L7703:
6448                     ; 1313 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6450  1133 9c            	rvf
6451  1134 ce0007        	ldw	x,_adc_buff_+2
6452  1137 a3036d        	cpw	x,#877
6453  113a 2f0f          	jrslt	L3013
6455  113c 9c            	rvf
6456  113d ce0007        	ldw	x,_adc_buff_+2
6457  1140 a30396        	cpw	x,#918
6458  1143 2e06          	jrsge	L3013
6461  1145 35010003      	mov	_adr+1,#1
6463  1149 2034          	jra	L1013
6464  114b               L3013:
6465                     ; 1314 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6467  114b 9c            	rvf
6468  114c ce0007        	ldw	x,_adc_buff_+2
6469  114f a302a3        	cpw	x,#675
6470  1152 2f0f          	jrslt	L7013
6472  1154 9c            	rvf
6473  1155 ce0007        	ldw	x,_adc_buff_+2
6474  1158 a302cc        	cpw	x,#716
6475  115b 2e06          	jrsge	L7013
6478  115d 35020003      	mov	_adr+1,#2
6480  1161 201c          	jra	L1013
6481  1163               L7013:
6482                     ; 1315 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6484  1163 9c            	rvf
6485  1164 ce0007        	ldw	x,_adc_buff_+2
6486  1167 a303e3        	cpw	x,#995
6487  116a 2f0f          	jrslt	L3113
6489  116c 9c            	rvf
6490  116d ce0007        	ldw	x,_adc_buff_+2
6491  1170 a3040c        	cpw	x,#1036
6492  1173 2e06          	jrsge	L3113
6495  1175 35030003      	mov	_adr+1,#3
6497  1179 2004          	jra	L1013
6498  117b               L3113:
6499                     ; 1316 else adr[1]=5;
6501  117b 35050003      	mov	_adr+1,#5
6502  117f               L1013:
6503                     ; 1318 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6505  117f 9c            	rvf
6506  1180 ce0017        	ldw	x,_adc_buff_+18
6507  1183 a3022a        	cpw	x,#554
6508  1186 2f0f          	jrslt	L7113
6510  1188 9c            	rvf
6511  1189 ce0017        	ldw	x,_adc_buff_+18
6512  118c a30253        	cpw	x,#595
6513  118f 2e06          	jrsge	L7113
6516  1191 725f0004      	clr	_adr+2
6518  1195 204c          	jra	L1213
6519  1197               L7113:
6520                     ; 1319 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6522  1197 9c            	rvf
6523  1198 ce0017        	ldw	x,_adc_buff_+18
6524  119b a3036d        	cpw	x,#877
6525  119e 2f0f          	jrslt	L3213
6527  11a0 9c            	rvf
6528  11a1 ce0017        	ldw	x,_adc_buff_+18
6529  11a4 a30396        	cpw	x,#918
6530  11a7 2e06          	jrsge	L3213
6533  11a9 35010004      	mov	_adr+2,#1
6535  11ad 2034          	jra	L1213
6536  11af               L3213:
6537                     ; 1320 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6539  11af 9c            	rvf
6540  11b0 ce0017        	ldw	x,_adc_buff_+18
6541  11b3 a302a3        	cpw	x,#675
6542  11b6 2f0f          	jrslt	L7213
6544  11b8 9c            	rvf
6545  11b9 ce0017        	ldw	x,_adc_buff_+18
6546  11bc a302cc        	cpw	x,#716
6547  11bf 2e06          	jrsge	L7213
6550  11c1 35020004      	mov	_adr+2,#2
6552  11c5 201c          	jra	L1213
6553  11c7               L7213:
6554                     ; 1321 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6556  11c7 9c            	rvf
6557  11c8 ce0017        	ldw	x,_adc_buff_+18
6558  11cb a303e3        	cpw	x,#995
6559  11ce 2f0f          	jrslt	L3313
6561  11d0 9c            	rvf
6562  11d1 ce0017        	ldw	x,_adc_buff_+18
6563  11d4 a3040c        	cpw	x,#1036
6564  11d7 2e06          	jrsge	L3313
6567  11d9 35030004      	mov	_adr+2,#3
6569  11dd 2004          	jra	L1213
6570  11df               L3313:
6571                     ; 1322 else adr[2]=5;
6573  11df 35050004      	mov	_adr+2,#5
6574  11e3               L1213:
6575                     ; 1326 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6577  11e3 c60002        	ld	a,_adr
6578  11e6 a105          	cp	a,#5
6579  11e8 270e          	jreq	L1413
6581  11ea c60003        	ld	a,_adr+1
6582  11ed a105          	cp	a,#5
6583  11ef 2707          	jreq	L1413
6585  11f1 c60004        	ld	a,_adr+2
6586  11f4 a105          	cp	a,#5
6587  11f6 2606          	jrne	L7313
6588  11f8               L1413:
6589                     ; 1329 	adress_error=1;
6591  11f8 35010000      	mov	_adress_error,#1
6593  11fc               L5413:
6594                     ; 1340 }
6597  11fc 84            	pop	a
6598  11fd 81            	ret
6599  11fe               L7313:
6600                     ; 1333 	if(adr[2]&0x02) bps_class=bpsIPS;
6602  11fe c60004        	ld	a,_adr+2
6603  1201 a502          	bcp	a,#2
6604  1203 2706          	jreq	L7413
6607  1205 35010001      	mov	_bps_class,#1
6609  1209 2002          	jra	L1513
6610  120b               L7413:
6611                     ; 1334 	else bps_class=bpsIBEP;
6613  120b 3f01          	clr	_bps_class
6614  120d               L1513:
6615                     ; 1336 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6617  120d c60004        	ld	a,_adr+2
6618  1210 a401          	and	a,#1
6619  1212 97            	ld	xl,a
6620  1213 a610          	ld	a,#16
6621  1215 42            	mul	x,a
6622  1216 9f            	ld	a,xl
6623  1217 6b01          	ld	(OFST+0,sp),a
6624  1219 c60003        	ld	a,_adr+1
6625  121c 48            	sll	a
6626  121d 48            	sll	a
6627  121e cb0002        	add	a,_adr
6628  1221 1b01          	add	a,(OFST+0,sp)
6629  1223 c70001        	ld	_adress,a
6630  1226 20d4          	jra	L5413
6674                     ; 1343 void volum_u_main_drv(void)
6674                     ; 1344 {
6675                     	switch	.text
6676  1228               _volum_u_main_drv:
6678  1228 88            	push	a
6679       00000001      OFST:	set	1
6682                     ; 1347 if(bMAIN)
6684                     	btst	_bMAIN
6685  122e 2503          	jrult	L031
6686  1230 cc1379        	jp	L1713
6687  1233               L031:
6688                     ; 1349 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6690  1233 9c            	rvf
6691  1234 ce0006        	ldw	x,_UU_AVT
6692  1237 1d000a        	subw	x,#10
6693  123a b369          	cpw	x,_Un
6694  123c 2d09          	jrsle	L3713
6697  123e be1c          	ldw	x,_volum_u_main_
6698  1240 1c0005        	addw	x,#5
6699  1243 bf1c          	ldw	_volum_u_main_,x
6701  1245 2036          	jra	L5713
6702  1247               L3713:
6703                     ; 1350 	else if(Un<(UU_AVT-1))volum_u_main_++;
6705  1247 9c            	rvf
6706  1248 ce0006        	ldw	x,_UU_AVT
6707  124b 5a            	decw	x
6708  124c b369          	cpw	x,_Un
6709  124e 2d09          	jrsle	L7713
6712  1250 be1c          	ldw	x,_volum_u_main_
6713  1252 1c0001        	addw	x,#1
6714  1255 bf1c          	ldw	_volum_u_main_,x
6716  1257 2024          	jra	L5713
6717  1259               L7713:
6718                     ; 1351 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
6720  1259 9c            	rvf
6721  125a ce0006        	ldw	x,_UU_AVT
6722  125d 1c000a        	addw	x,#10
6723  1260 b369          	cpw	x,_Un
6724  1262 2e09          	jrsge	L3023
6727  1264 be1c          	ldw	x,_volum_u_main_
6728  1266 1d000a        	subw	x,#10
6729  1269 bf1c          	ldw	_volum_u_main_,x
6731  126b 2010          	jra	L5713
6732  126d               L3023:
6733                     ; 1352 	else if(Un>(UU_AVT+1))volum_u_main_--;
6735  126d 9c            	rvf
6736  126e ce0006        	ldw	x,_UU_AVT
6737  1271 5c            	incw	x
6738  1272 b369          	cpw	x,_Un
6739  1274 2e07          	jrsge	L5713
6742  1276 be1c          	ldw	x,_volum_u_main_
6743  1278 1d0001        	subw	x,#1
6744  127b bf1c          	ldw	_volum_u_main_,x
6745  127d               L5713:
6746                     ; 1353 	if(volum_u_main_>1020)volum_u_main_=1020;
6748  127d 9c            	rvf
6749  127e be1c          	ldw	x,_volum_u_main_
6750  1280 a303fd        	cpw	x,#1021
6751  1283 2f05          	jrslt	L1123
6754  1285 ae03fc        	ldw	x,#1020
6755  1288 bf1c          	ldw	_volum_u_main_,x
6756  128a               L1123:
6757                     ; 1354 	if(volum_u_main_<0)volum_u_main_=0;
6759  128a 9c            	rvf
6760  128b be1c          	ldw	x,_volum_u_main_
6761  128d 2e03          	jrsge	L3123
6764  128f 5f            	clrw	x
6765  1290 bf1c          	ldw	_volum_u_main_,x
6766  1292               L3123:
6767                     ; 1357 	i_main_sigma=0;
6769  1292 5f            	clrw	x
6770  1293 bf0c          	ldw	_i_main_sigma,x
6771                     ; 1358 	i_main_num_of_bps=0;
6773  1295 3f0e          	clr	_i_main_num_of_bps
6774                     ; 1359 	for(i=0;i<6;i++)
6776  1297 0f01          	clr	(OFST+0,sp)
6777  1299               L5123:
6778                     ; 1361 		if(i_main_flag[i])
6780  1299 7b01          	ld	a,(OFST+0,sp)
6781  129b 5f            	clrw	x
6782  129c 97            	ld	xl,a
6783  129d 6d11          	tnz	(_i_main_flag,x)
6784  129f 2719          	jreq	L3223
6785                     ; 1363 			i_main_sigma+=i_main[i];
6787  12a1 7b01          	ld	a,(OFST+0,sp)
6788  12a3 5f            	clrw	x
6789  12a4 97            	ld	xl,a
6790  12a5 58            	sllw	x
6791  12a6 ee17          	ldw	x,(_i_main,x)
6792  12a8 72bb000c      	addw	x,_i_main_sigma
6793  12ac bf0c          	ldw	_i_main_sigma,x
6794                     ; 1364 			i_main_flag[i]=1;
6796  12ae 7b01          	ld	a,(OFST+0,sp)
6797  12b0 5f            	clrw	x
6798  12b1 97            	ld	xl,a
6799  12b2 a601          	ld	a,#1
6800  12b4 e711          	ld	(_i_main_flag,x),a
6801                     ; 1365 			i_main_num_of_bps++;
6803  12b6 3c0e          	inc	_i_main_num_of_bps
6805  12b8 2006          	jra	L5223
6806  12ba               L3223:
6807                     ; 1369 			i_main_flag[i]=0;	
6809  12ba 7b01          	ld	a,(OFST+0,sp)
6810  12bc 5f            	clrw	x
6811  12bd 97            	ld	xl,a
6812  12be 6f11          	clr	(_i_main_flag,x)
6813  12c0               L5223:
6814                     ; 1359 	for(i=0;i<6;i++)
6816  12c0 0c01          	inc	(OFST+0,sp)
6819  12c2 7b01          	ld	a,(OFST+0,sp)
6820  12c4 a106          	cp	a,#6
6821  12c6 25d1          	jrult	L5123
6822                     ; 1372 	i_main_avg=i_main_sigma/i_main_num_of_bps;
6824  12c8 be0c          	ldw	x,_i_main_sigma
6825  12ca b60e          	ld	a,_i_main_num_of_bps
6826  12cc 905f          	clrw	y
6827  12ce 9097          	ld	yl,a
6828  12d0 cd0000        	call	c_idiv
6830  12d3 bf0f          	ldw	_i_main_avg,x
6831                     ; 1373 	for(i=0;i<6;i++)
6833  12d5 0f01          	clr	(OFST+0,sp)
6834  12d7               L7223:
6835                     ; 1375 		if(i_main_flag[i])
6837  12d7 7b01          	ld	a,(OFST+0,sp)
6838  12d9 5f            	clrw	x
6839  12da 97            	ld	xl,a
6840  12db 6d11          	tnz	(_i_main_flag,x)
6841  12dd 2603cc136e    	jreq	L5323
6842                     ; 1377 			if(i_main[i]<(i_main_avg-10))x[i]++;
6844  12e2 9c            	rvf
6845  12e3 7b01          	ld	a,(OFST+0,sp)
6846  12e5 5f            	clrw	x
6847  12e6 97            	ld	xl,a
6848  12e7 58            	sllw	x
6849  12e8 90be0f        	ldw	y,_i_main_avg
6850  12eb 72a2000a      	subw	y,#10
6851  12ef 90bf00        	ldw	c_y,y
6852  12f2 9093          	ldw	y,x
6853  12f4 90ee17        	ldw	y,(_i_main,y)
6854  12f7 90b300        	cpw	y,c_y
6855  12fa 2e11          	jrsge	L7323
6858  12fc 7b01          	ld	a,(OFST+0,sp)
6859  12fe 5f            	clrw	x
6860  12ff 97            	ld	xl,a
6861  1300 58            	sllw	x
6862  1301 9093          	ldw	y,x
6863  1303 ee23          	ldw	x,(_x,x)
6864  1305 1c0001        	addw	x,#1
6865  1308 90ef23        	ldw	(_x,y),x
6867  130b 2029          	jra	L1423
6868  130d               L7323:
6869                     ; 1378 			else if(i_main[i]>(i_main_avg+10))x[i]--;
6871  130d 9c            	rvf
6872  130e 7b01          	ld	a,(OFST+0,sp)
6873  1310 5f            	clrw	x
6874  1311 97            	ld	xl,a
6875  1312 58            	sllw	x
6876  1313 90be0f        	ldw	y,_i_main_avg
6877  1316 72a9000a      	addw	y,#10
6878  131a 90bf00        	ldw	c_y,y
6879  131d 9093          	ldw	y,x
6880  131f 90ee17        	ldw	y,(_i_main,y)
6881  1322 90b300        	cpw	y,c_y
6882  1325 2d0f          	jrsle	L1423
6885  1327 7b01          	ld	a,(OFST+0,sp)
6886  1329 5f            	clrw	x
6887  132a 97            	ld	xl,a
6888  132b 58            	sllw	x
6889  132c 9093          	ldw	y,x
6890  132e ee23          	ldw	x,(_x,x)
6891  1330 1d0001        	subw	x,#1
6892  1333 90ef23        	ldw	(_x,y),x
6893  1336               L1423:
6894                     ; 1379 			if(x[i]>100)x[i]=100;
6896  1336 9c            	rvf
6897  1337 7b01          	ld	a,(OFST+0,sp)
6898  1339 5f            	clrw	x
6899  133a 97            	ld	xl,a
6900  133b 58            	sllw	x
6901  133c 9093          	ldw	y,x
6902  133e 90ee23        	ldw	y,(_x,y)
6903  1341 90a30065      	cpw	y,#101
6904  1345 2f0b          	jrslt	L5423
6907  1347 7b01          	ld	a,(OFST+0,sp)
6908  1349 5f            	clrw	x
6909  134a 97            	ld	xl,a
6910  134b 58            	sllw	x
6911  134c 90ae0064      	ldw	y,#100
6912  1350 ef23          	ldw	(_x,x),y
6913  1352               L5423:
6914                     ; 1380 			if(x[i]<-100)x[i]=-100;
6916  1352 9c            	rvf
6917  1353 7b01          	ld	a,(OFST+0,sp)
6918  1355 5f            	clrw	x
6919  1356 97            	ld	xl,a
6920  1357 58            	sllw	x
6921  1358 9093          	ldw	y,x
6922  135a 90ee23        	ldw	y,(_x,y)
6923  135d 90a3ff9c      	cpw	y,#65436
6924  1361 2e0b          	jrsge	L5323
6927  1363 7b01          	ld	a,(OFST+0,sp)
6928  1365 5f            	clrw	x
6929  1366 97            	ld	xl,a
6930  1367 58            	sllw	x
6931  1368 90aeff9c      	ldw	y,#65436
6932  136c ef23          	ldw	(_x,x),y
6933  136e               L5323:
6934                     ; 1373 	for(i=0;i<6;i++)
6936  136e 0c01          	inc	(OFST+0,sp)
6939  1370 7b01          	ld	a,(OFST+0,sp)
6940  1372 a106          	cp	a,#6
6941  1374 2403cc12d7    	jrult	L7223
6942  1379               L1713:
6943                     ; 1387 }
6946  1379 84            	pop	a
6947  137a 81            	ret
6970                     ; 1390 void init_CAN(void) {
6971                     	switch	.text
6972  137b               _init_CAN:
6976                     ; 1391 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6978  137b 72135420      	bres	21536,#1
6979                     ; 1392 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6981  137f 72105420      	bset	21536,#0
6983  1383               L3623:
6984                     ; 1393 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6986  1383 c65421        	ld	a,21537
6987  1386 a501          	bcp	a,#1
6988  1388 27f9          	jreq	L3623
6989                     ; 1395 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6991  138a 72185420      	bset	21536,#4
6992                     ; 1397 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6994  138e 35025427      	mov	21543,#2
6995                     ; 1406 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6997  1392 35135428      	mov	21544,#19
6998                     ; 1407 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7000  1396 35c05429      	mov	21545,#192
7001                     ; 1408 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7003  139a 357f542c      	mov	21548,#127
7004                     ; 1409 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7006  139e 35e0542d      	mov	21549,#224
7007                     ; 1411 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7009  13a2 35315430      	mov	21552,#49
7010                     ; 1412 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7012  13a6 35c05431      	mov	21553,#192
7013                     ; 1413 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7015  13aa 357f5434      	mov	21556,#127
7016                     ; 1414 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7018  13ae 35e05435      	mov	21557,#224
7019                     ; 1418 	CAN->PSR= 6;									// set page 6
7021  13b2 35065427      	mov	21543,#6
7022                     ; 1423 	CAN->Page.Config.FMR1&=~3;								//mask mode
7024  13b6 c65430        	ld	a,21552
7025  13b9 a4fc          	and	a,#252
7026  13bb c75430        	ld	21552,a
7027                     ; 1429 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7029  13be 35065432      	mov	21554,#6
7030                     ; 1430 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7032  13c2 35605432      	mov	21554,#96
7033                     ; 1433 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7035  13c6 72105432      	bset	21554,#0
7036                     ; 1434 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7038  13ca 72185432      	bset	21554,#4
7039                     ; 1437 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7041  13ce 35065427      	mov	21543,#6
7042                     ; 1439 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7044  13d2 3509542c      	mov	21548,#9
7045                     ; 1440 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7047  13d6 35e7542d      	mov	21549,#231
7048                     ; 1442 	CAN->IER|=(1<<1);
7050  13da 72125425      	bset	21541,#1
7051                     ; 1445 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7053  13de 72115420      	bres	21536,#0
7055  13e2               L1723:
7056                     ; 1446 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7058  13e2 c65421        	ld	a,21537
7059  13e5 a501          	bcp	a,#1
7060  13e7 26f9          	jrne	L1723
7061                     ; 1447 }
7064  13e9 81            	ret
7172                     ; 1450 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7172                     ; 1451 {
7173                     	switch	.text
7174  13ea               _can_transmit:
7176  13ea 89            	pushw	x
7177       00000000      OFST:	set	0
7180                     ; 1453 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7182  13eb b670          	ld	a,_can_buff_wr_ptr
7183  13ed a104          	cp	a,#4
7184  13ef 2502          	jrult	L3533
7187  13f1 3f70          	clr	_can_buff_wr_ptr
7188  13f3               L3533:
7189                     ; 1455 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7191  13f3 b670          	ld	a,_can_buff_wr_ptr
7192  13f5 97            	ld	xl,a
7193  13f6 a610          	ld	a,#16
7194  13f8 42            	mul	x,a
7195  13f9 1601          	ldw	y,(OFST+1,sp)
7196  13fb a606          	ld	a,#6
7197  13fd               L631:
7198  13fd 9054          	srlw	y
7199  13ff 4a            	dec	a
7200  1400 26fb          	jrne	L631
7201  1402 909f          	ld	a,yl
7202  1404 e771          	ld	(_can_out_buff,x),a
7203                     ; 1456 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7205  1406 b670          	ld	a,_can_buff_wr_ptr
7206  1408 97            	ld	xl,a
7207  1409 a610          	ld	a,#16
7208  140b 42            	mul	x,a
7209  140c 7b02          	ld	a,(OFST+2,sp)
7210  140e 48            	sll	a
7211  140f 48            	sll	a
7212  1410 e772          	ld	(_can_out_buff+1,x),a
7213                     ; 1458 can_out_buff[can_buff_wr_ptr][2]=data0;
7215  1412 b670          	ld	a,_can_buff_wr_ptr
7216  1414 97            	ld	xl,a
7217  1415 a610          	ld	a,#16
7218  1417 42            	mul	x,a
7219  1418 7b05          	ld	a,(OFST+5,sp)
7220  141a e773          	ld	(_can_out_buff+2,x),a
7221                     ; 1459 can_out_buff[can_buff_wr_ptr][3]=data1;
7223  141c b670          	ld	a,_can_buff_wr_ptr
7224  141e 97            	ld	xl,a
7225  141f a610          	ld	a,#16
7226  1421 42            	mul	x,a
7227  1422 7b06          	ld	a,(OFST+6,sp)
7228  1424 e774          	ld	(_can_out_buff+3,x),a
7229                     ; 1460 can_out_buff[can_buff_wr_ptr][4]=data2;
7231  1426 b670          	ld	a,_can_buff_wr_ptr
7232  1428 97            	ld	xl,a
7233  1429 a610          	ld	a,#16
7234  142b 42            	mul	x,a
7235  142c 7b07          	ld	a,(OFST+7,sp)
7236  142e e775          	ld	(_can_out_buff+4,x),a
7237                     ; 1461 can_out_buff[can_buff_wr_ptr][5]=data3;
7239  1430 b670          	ld	a,_can_buff_wr_ptr
7240  1432 97            	ld	xl,a
7241  1433 a610          	ld	a,#16
7242  1435 42            	mul	x,a
7243  1436 7b08          	ld	a,(OFST+8,sp)
7244  1438 e776          	ld	(_can_out_buff+5,x),a
7245                     ; 1462 can_out_buff[can_buff_wr_ptr][6]=data4;
7247  143a b670          	ld	a,_can_buff_wr_ptr
7248  143c 97            	ld	xl,a
7249  143d a610          	ld	a,#16
7250  143f 42            	mul	x,a
7251  1440 7b09          	ld	a,(OFST+9,sp)
7252  1442 e777          	ld	(_can_out_buff+6,x),a
7253                     ; 1463 can_out_buff[can_buff_wr_ptr][7]=data5;
7255  1444 b670          	ld	a,_can_buff_wr_ptr
7256  1446 97            	ld	xl,a
7257  1447 a610          	ld	a,#16
7258  1449 42            	mul	x,a
7259  144a 7b0a          	ld	a,(OFST+10,sp)
7260  144c e778          	ld	(_can_out_buff+7,x),a
7261                     ; 1464 can_out_buff[can_buff_wr_ptr][8]=data6;
7263  144e b670          	ld	a,_can_buff_wr_ptr
7264  1450 97            	ld	xl,a
7265  1451 a610          	ld	a,#16
7266  1453 42            	mul	x,a
7267  1454 7b0b          	ld	a,(OFST+11,sp)
7268  1456 e779          	ld	(_can_out_buff+8,x),a
7269                     ; 1465 can_out_buff[can_buff_wr_ptr][9]=data7;
7271  1458 b670          	ld	a,_can_buff_wr_ptr
7272  145a 97            	ld	xl,a
7273  145b a610          	ld	a,#16
7274  145d 42            	mul	x,a
7275  145e 7b0c          	ld	a,(OFST+12,sp)
7276  1460 e77a          	ld	(_can_out_buff+9,x),a
7277                     ; 1467 can_buff_wr_ptr++;
7279  1462 3c70          	inc	_can_buff_wr_ptr
7280                     ; 1468 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7282  1464 b670          	ld	a,_can_buff_wr_ptr
7283  1466 a104          	cp	a,#4
7284  1468 2502          	jrult	L5533
7287  146a 3f70          	clr	_can_buff_wr_ptr
7288  146c               L5533:
7289                     ; 1469 } 
7292  146c 85            	popw	x
7293  146d 81            	ret
7322                     ; 1472 void can_tx_hndl(void)
7322                     ; 1473 {
7323                     	switch	.text
7324  146e               _can_tx_hndl:
7328                     ; 1474 if(bTX_FREE)
7330  146e 3d08          	tnz	_bTX_FREE
7331  1470 2757          	jreq	L7633
7332                     ; 1476 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7334  1472 b66f          	ld	a,_can_buff_rd_ptr
7335  1474 b170          	cp	a,_can_buff_wr_ptr
7336  1476 275f          	jreq	L5733
7337                     ; 1478 		bTX_FREE=0;
7339  1478 3f08          	clr	_bTX_FREE
7340                     ; 1480 		CAN->PSR= 0;
7342  147a 725f5427      	clr	21543
7343                     ; 1481 		CAN->Page.TxMailbox.MDLCR=8;
7345  147e 35085429      	mov	21545,#8
7346                     ; 1482 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7348  1482 b66f          	ld	a,_can_buff_rd_ptr
7349  1484 97            	ld	xl,a
7350  1485 a610          	ld	a,#16
7351  1487 42            	mul	x,a
7352  1488 e671          	ld	a,(_can_out_buff,x)
7353  148a c7542a        	ld	21546,a
7354                     ; 1483 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7356  148d b66f          	ld	a,_can_buff_rd_ptr
7357  148f 97            	ld	xl,a
7358  1490 a610          	ld	a,#16
7359  1492 42            	mul	x,a
7360  1493 e672          	ld	a,(_can_out_buff+1,x)
7361  1495 c7542b        	ld	21547,a
7362                     ; 1485 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7364  1498 b66f          	ld	a,_can_buff_rd_ptr
7365  149a 97            	ld	xl,a
7366  149b a610          	ld	a,#16
7367  149d 42            	mul	x,a
7368  149e 01            	rrwa	x,a
7369  149f ab73          	add	a,#_can_out_buff+2
7370  14a1 2401          	jrnc	L241
7371  14a3 5c            	incw	x
7372  14a4               L241:
7373  14a4 5f            	clrw	x
7374  14a5 97            	ld	xl,a
7375  14a6 bf00          	ldw	c_x,x
7376  14a8 ae0008        	ldw	x,#8
7377  14ab               L441:
7378  14ab 5a            	decw	x
7379  14ac 92d600        	ld	a,([c_x],x)
7380  14af d7542e        	ld	(21550,x),a
7381  14b2 5d            	tnzw	x
7382  14b3 26f6          	jrne	L441
7383                     ; 1487 		can_buff_rd_ptr++;
7385  14b5 3c6f          	inc	_can_buff_rd_ptr
7386                     ; 1488 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7388  14b7 b66f          	ld	a,_can_buff_rd_ptr
7389  14b9 a104          	cp	a,#4
7390  14bb 2502          	jrult	L3733
7393  14bd 3f6f          	clr	_can_buff_rd_ptr
7394  14bf               L3733:
7395                     ; 1490 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7397  14bf 72105428      	bset	21544,#0
7398                     ; 1491 		CAN->IER|=(1<<0);
7400  14c3 72105425      	bset	21541,#0
7401  14c7 200e          	jra	L5733
7402  14c9               L7633:
7403                     ; 1496 	tx_busy_cnt++;
7405  14c9 3c6e          	inc	_tx_busy_cnt
7406                     ; 1497 	if(tx_busy_cnt>=100)
7408  14cb b66e          	ld	a,_tx_busy_cnt
7409  14cd a164          	cp	a,#100
7410  14cf 2506          	jrult	L5733
7411                     ; 1499 		tx_busy_cnt=0;
7413  14d1 3f6e          	clr	_tx_busy_cnt
7414                     ; 1500 		bTX_FREE=1;
7416  14d3 35010008      	mov	_bTX_FREE,#1
7417  14d7               L5733:
7418                     ; 1503 }
7421  14d7 81            	ret
7460                     ; 1506 void net_drv(void)
7460                     ; 1507 { 
7461                     	switch	.text
7462  14d8               _net_drv:
7466                     ; 1509 if(bMAIN)
7468                     	btst	_bMAIN
7469  14dd 2503          	jrult	L051
7470  14df cc1585        	jp	L1143
7471  14e2               L051:
7472                     ; 1511 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7474  14e2 3c2f          	inc	_cnt_net_drv
7475  14e4 b62f          	ld	a,_cnt_net_drv
7476  14e6 a107          	cp	a,#7
7477  14e8 2502          	jrult	L3143
7480  14ea 3f2f          	clr	_cnt_net_drv
7481  14ec               L3143:
7482                     ; 1513 	if(cnt_net_drv<=5) 
7484  14ec b62f          	ld	a,_cnt_net_drv
7485  14ee a106          	cp	a,#6
7486  14f0 244c          	jruge	L5143
7487                     ; 1515 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7489  14f2 4be8          	push	#232
7490  14f4 4be8          	push	#232
7491  14f6 b62f          	ld	a,_cnt_net_drv
7492  14f8 5f            	clrw	x
7493  14f9 97            	ld	xl,a
7494  14fa 58            	sllw	x
7495  14fb ee23          	ldw	x,(_x,x)
7496  14fd 72bb001c      	addw	x,_volum_u_main_
7497  1501 90ae0100      	ldw	y,#256
7498  1505 cd0000        	call	c_idiv
7500  1508 9f            	ld	a,xl
7501  1509 88            	push	a
7502  150a b62f          	ld	a,_cnt_net_drv
7503  150c 5f            	clrw	x
7504  150d 97            	ld	xl,a
7505  150e 58            	sllw	x
7506  150f e624          	ld	a,(_x+1,x)
7507  1511 bb1d          	add	a,_volum_u_main_+1
7508  1513 88            	push	a
7509  1514 4b00          	push	#0
7510  1516 4bed          	push	#237
7511  1518 3b002f        	push	_cnt_net_drv
7512  151b 3b002f        	push	_cnt_net_drv
7513  151e ae009e        	ldw	x,#158
7514  1521 cd13ea        	call	_can_transmit
7516  1524 5b08          	addw	sp,#8
7517                     ; 1516 		i_main_bps_cnt[cnt_net_drv]++;
7519  1526 b62f          	ld	a,_cnt_net_drv
7520  1528 5f            	clrw	x
7521  1529 97            	ld	xl,a
7522  152a 6c06          	inc	(_i_main_bps_cnt,x)
7523                     ; 1517 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7525  152c b62f          	ld	a,_cnt_net_drv
7526  152e 5f            	clrw	x
7527  152f 97            	ld	xl,a
7528  1530 e606          	ld	a,(_i_main_bps_cnt,x)
7529  1532 a10b          	cp	a,#11
7530  1534 254f          	jrult	L1143
7533  1536 b62f          	ld	a,_cnt_net_drv
7534  1538 5f            	clrw	x
7535  1539 97            	ld	xl,a
7536  153a 6f11          	clr	(_i_main_flag,x)
7537  153c 2047          	jra	L1143
7538  153e               L5143:
7539                     ; 1519 	else if(cnt_net_drv==6)
7541  153e b62f          	ld	a,_cnt_net_drv
7542  1540 a106          	cp	a,#6
7543  1542 2641          	jrne	L1143
7544                     ; 1521 		plazma_int[2]=pwm_u;
7546  1544 be0b          	ldw	x,_pwm_u
7547  1546 bf34          	ldw	_plazma_int+4,x
7548                     ; 1522 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7550  1548 3b0067        	push	_Ui
7551  154b 3b0068        	push	_Ui+1
7552  154e 3b0069        	push	_Un
7553  1551 3b006a        	push	_Un+1
7554  1554 3b006b        	push	_I
7555  1557 3b006c        	push	_I+1
7556  155a 4bda          	push	#218
7557  155c 3b0001        	push	_adress
7558  155f ae018e        	ldw	x,#398
7559  1562 cd13ea        	call	_can_transmit
7561  1565 5b08          	addw	sp,#8
7562                     ; 1523 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7564  1567 3b0034        	push	_plazma_int+4
7565  156a 3b0035        	push	_plazma_int+5
7566  156d 3b005c        	push	__x_+1
7567  1570 3b000a        	push	_flags
7568  1573 4b00          	push	#0
7569  1575 3b0064        	push	_T
7570  1578 4bdb          	push	#219
7571  157a 3b0001        	push	_adress
7572  157d ae018e        	ldw	x,#398
7573  1580 cd13ea        	call	_can_transmit
7575  1583 5b08          	addw	sp,#8
7576  1585               L1143:
7577                     ; 1526 }
7580  1585 81            	ret
7690                     ; 1529 void can_in_an(void)
7690                     ; 1530 {
7691                     	switch	.text
7692  1586               _can_in_an:
7694  1586 5205          	subw	sp,#5
7695       00000005      OFST:	set	5
7698                     ; 1540 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7700  1588 b6c6          	ld	a,_mess+6
7701  158a c10001        	cp	a,_adress
7702  158d 2703          	jreq	L471
7703  158f cc169c        	jp	L1643
7704  1592               L471:
7706  1592 b6c7          	ld	a,_mess+7
7707  1594 c10001        	cp	a,_adress
7708  1597 2703          	jreq	L671
7709  1599 cc169c        	jp	L1643
7710  159c               L671:
7712  159c b6c8          	ld	a,_mess+8
7713  159e a1ed          	cp	a,#237
7714  15a0 2703          	jreq	L002
7715  15a2 cc169c        	jp	L1643
7716  15a5               L002:
7717                     ; 1543 	can_error_cnt=0;
7719  15a5 3f6d          	clr	_can_error_cnt
7720                     ; 1545 	bMAIN=0;
7722  15a7 72110001      	bres	_bMAIN
7723                     ; 1546  	flags_tu=mess[9];
7725  15ab 45c95d        	mov	_flags_tu,_mess+9
7726                     ; 1547  	if(flags_tu&0b00000001)
7728  15ae b65d          	ld	a,_flags_tu
7729  15b0 a501          	bcp	a,#1
7730  15b2 2706          	jreq	L3643
7731                     ; 1552  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7733  15b4 721a000a      	bset	_flags,#5
7735  15b8 200e          	jra	L5643
7736  15ba               L3643:
7737                     ; 1563  				flags&=0b11011111; 
7739  15ba 721b000a      	bres	_flags,#5
7740                     ; 1564  				off_bp_cnt=5*ee_TZAS;
7742  15be c60015        	ld	a,_ee_TZAS+1
7743  15c1 97            	ld	xl,a
7744  15c2 a605          	ld	a,#5
7745  15c4 42            	mul	x,a
7746  15c5 9f            	ld	a,xl
7747  15c6 b750          	ld	_off_bp_cnt,a
7748  15c8               L5643:
7749                     ; 1570  	if(flags_tu&0b00000010) flags|=0b01000000;
7751  15c8 b65d          	ld	a,_flags_tu
7752  15ca a502          	bcp	a,#2
7753  15cc 2706          	jreq	L7643
7756  15ce 721c000a      	bset	_flags,#6
7758  15d2 2004          	jra	L1743
7759  15d4               L7643:
7760                     ; 1571  	else flags&=0b10111111; 
7762  15d4 721d000a      	bres	_flags,#6
7763  15d8               L1743:
7764                     ; 1573  	vol_u_temp=mess[10]+mess[11]*256;
7766  15d8 b6cb          	ld	a,_mess+11
7767  15da 5f            	clrw	x
7768  15db 97            	ld	xl,a
7769  15dc 4f            	clr	a
7770  15dd 02            	rlwa	x,a
7771  15de 01            	rrwa	x,a
7772  15df bbca          	add	a,_mess+10
7773  15e1 2401          	jrnc	L451
7774  15e3 5c            	incw	x
7775  15e4               L451:
7776  15e4 b756          	ld	_vol_u_temp+1,a
7777  15e6 9f            	ld	a,xl
7778  15e7 b755          	ld	_vol_u_temp,a
7779                     ; 1574  	vol_i_temp=mess[12]+mess[13]*256;  
7781  15e9 b6cd          	ld	a,_mess+13
7782  15eb 5f            	clrw	x
7783  15ec 97            	ld	xl,a
7784  15ed 4f            	clr	a
7785  15ee 02            	rlwa	x,a
7786  15ef 01            	rrwa	x,a
7787  15f0 bbcc          	add	a,_mess+12
7788  15f2 2401          	jrnc	L651
7789  15f4 5c            	incw	x
7790  15f5               L651:
7791  15f5 b754          	ld	_vol_i_temp+1,a
7792  15f7 9f            	ld	a,xl
7793  15f8 b753          	ld	_vol_i_temp,a
7794                     ; 1583 	plazma_int[2]=T;
7796  15fa 5f            	clrw	x
7797  15fb b664          	ld	a,_T
7798  15fd 2a01          	jrpl	L061
7799  15ff 53            	cplw	x
7800  1600               L061:
7801  1600 97            	ld	xl,a
7802  1601 bf34          	ldw	_plazma_int+4,x
7803                     ; 1584  	rotor_int=flags_tu+(((short)flags)<<8);
7805  1603 b60a          	ld	a,_flags
7806  1605 5f            	clrw	x
7807  1606 97            	ld	xl,a
7808  1607 4f            	clr	a
7809  1608 02            	rlwa	x,a
7810  1609 01            	rrwa	x,a
7811  160a bb5d          	add	a,_flags_tu
7812  160c 2401          	jrnc	L261
7813  160e 5c            	incw	x
7814  160f               L261:
7815  160f b71b          	ld	_rotor_int+1,a
7816  1611 9f            	ld	a,xl
7817  1612 b71a          	ld	_rotor_int,a
7818                     ; 1585 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7820  1614 3b0067        	push	_Ui
7821  1617 3b0068        	push	_Ui+1
7822  161a 3b0069        	push	_Un
7823  161d 3b006a        	push	_Un+1
7824  1620 3b006b        	push	_I
7825  1623 3b006c        	push	_I+1
7826  1626 4bda          	push	#218
7827  1628 3b0001        	push	_adress
7828  162b ae018e        	ldw	x,#398
7829  162e cd13ea        	call	_can_transmit
7831  1631 5b08          	addw	sp,#8
7832                     ; 1586 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7834  1633 3b0034        	push	_plazma_int+4
7835  1636 3b0035        	push	_plazma_int+5
7836  1639 3b005c        	push	__x_+1
7837  163c 3b000a        	push	_flags
7838  163f 4b00          	push	#0
7839  1641 3b0064        	push	_T
7840  1644 4bdb          	push	#219
7841  1646 3b0001        	push	_adress
7842  1649 ae018e        	ldw	x,#398
7843  164c cd13ea        	call	_can_transmit
7845  164f 5b08          	addw	sp,#8
7846                     ; 1587      link_cnt=0;
7848  1651 3f5e          	clr	_link_cnt
7849                     ; 1588      link=ON;
7851  1653 3555005f      	mov	_link,#85
7852                     ; 1590      if(flags_tu&0b10000000)
7854  1657 b65d          	ld	a,_flags_tu
7855  1659 a580          	bcp	a,#128
7856  165b 2716          	jreq	L3743
7857                     ; 1592      	if(!res_fl)
7859  165d 725d0009      	tnz	_res_fl
7860  1661 2625          	jrne	L7743
7861                     ; 1594      		res_fl=1;
7863  1663 a601          	ld	a,#1
7864  1665 ae0009        	ldw	x,#_res_fl
7865  1668 cd0000        	call	c_eewrc
7867                     ; 1595      		bRES=1;
7869  166b 3501000f      	mov	_bRES,#1
7870                     ; 1596      		res_fl_cnt=0;
7872  166f 3f3e          	clr	_res_fl_cnt
7873  1671 2015          	jra	L7743
7874  1673               L3743:
7875                     ; 1601      	if(main_cnt>20)
7877  1673 9c            	rvf
7878  1674 be4e          	ldw	x,_main_cnt
7879  1676 a30015        	cpw	x,#21
7880  1679 2f0d          	jrslt	L7743
7881                     ; 1603     			if(res_fl)
7883  167b 725d0009      	tnz	_res_fl
7884  167f 2707          	jreq	L7743
7885                     ; 1605      			res_fl=0;
7887  1681 4f            	clr	a
7888  1682 ae0009        	ldw	x,#_res_fl
7889  1685 cd0000        	call	c_eewrc
7891  1688               L7743:
7892                     ; 1610       if(res_fl_)
7894  1688 725d0008      	tnz	_res_fl_
7895  168c 2603          	jrne	L202
7896  168e cc1bbf        	jp	L5243
7897  1691               L202:
7898                     ; 1612       	res_fl_=0;
7900  1691 4f            	clr	a
7901  1692 ae0008        	ldw	x,#_res_fl_
7902  1695 cd0000        	call	c_eewrc
7904  1698 acbf1bbf      	jpf	L5243
7905  169c               L1643:
7906                     ; 1615 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7908  169c b6c6          	ld	a,_mess+6
7909  169e c10001        	cp	a,_adress
7910  16a1 2703          	jreq	L402
7911  16a3 cc18b2        	jp	L1153
7912  16a6               L402:
7914  16a6 b6c7          	ld	a,_mess+7
7915  16a8 c10001        	cp	a,_adress
7916  16ab 2703          	jreq	L602
7917  16ad cc18b2        	jp	L1153
7918  16b0               L602:
7920  16b0 b6c8          	ld	a,_mess+8
7921  16b2 a1ee          	cp	a,#238
7922  16b4 2703          	jreq	L012
7923  16b6 cc18b2        	jp	L1153
7924  16b9               L012:
7926  16b9 b6c9          	ld	a,_mess+9
7927  16bb b1ca          	cp	a,_mess+10
7928  16bd 2703          	jreq	L212
7929  16bf cc18b2        	jp	L1153
7930  16c2               L212:
7931                     ; 1617 	rotor_int++;
7933  16c2 be1a          	ldw	x,_rotor_int
7934  16c4 1c0001        	addw	x,#1
7935  16c7 bf1a          	ldw	_rotor_int,x
7936                     ; 1618 	if((mess[9]&0xf0)==0x20)
7938  16c9 b6c9          	ld	a,_mess+9
7939  16cb a4f0          	and	a,#240
7940  16cd a120          	cp	a,#32
7941  16cf 2673          	jrne	L3153
7942                     ; 1620 		if((mess[9]&0x0f)==0x01)
7944  16d1 b6c9          	ld	a,_mess+9
7945  16d3 a40f          	and	a,#15
7946  16d5 a101          	cp	a,#1
7947  16d7 260d          	jrne	L5153
7948                     ; 1622 			ee_K[0][0]=adc_buff_[4];
7950  16d9 ce000d        	ldw	x,_adc_buff_+8
7951  16dc 89            	pushw	x
7952  16dd ae0018        	ldw	x,#_ee_K
7953  16e0 cd0000        	call	c_eewrw
7955  16e3 85            	popw	x
7957  16e4 204a          	jra	L7153
7958  16e6               L5153:
7959                     ; 1624 		else if((mess[9]&0x0f)==0x02)
7961  16e6 b6c9          	ld	a,_mess+9
7962  16e8 a40f          	and	a,#15
7963  16ea a102          	cp	a,#2
7964  16ec 260b          	jrne	L1253
7965                     ; 1626 			ee_K[0][1]++;
7967  16ee ce001a        	ldw	x,_ee_K+2
7968  16f1 1c0001        	addw	x,#1
7969  16f4 cf001a        	ldw	_ee_K+2,x
7971  16f7 2037          	jra	L7153
7972  16f9               L1253:
7973                     ; 1628 		else if((mess[9]&0x0f)==0x03)
7975  16f9 b6c9          	ld	a,_mess+9
7976  16fb a40f          	and	a,#15
7977  16fd a103          	cp	a,#3
7978  16ff 260b          	jrne	L5253
7979                     ; 1630 			ee_K[0][1]+=10;
7981  1701 ce001a        	ldw	x,_ee_K+2
7982  1704 1c000a        	addw	x,#10
7983  1707 cf001a        	ldw	_ee_K+2,x
7985  170a 2024          	jra	L7153
7986  170c               L5253:
7987                     ; 1632 		else if((mess[9]&0x0f)==0x04)
7989  170c b6c9          	ld	a,_mess+9
7990  170e a40f          	and	a,#15
7991  1710 a104          	cp	a,#4
7992  1712 260b          	jrne	L1353
7993                     ; 1634 			ee_K[0][1]--;
7995  1714 ce001a        	ldw	x,_ee_K+2
7996  1717 1d0001        	subw	x,#1
7997  171a cf001a        	ldw	_ee_K+2,x
7999  171d 2011          	jra	L7153
8000  171f               L1353:
8001                     ; 1636 		else if((mess[9]&0x0f)==0x05)
8003  171f b6c9          	ld	a,_mess+9
8004  1721 a40f          	and	a,#15
8005  1723 a105          	cp	a,#5
8006  1725 2609          	jrne	L7153
8007                     ; 1638 			ee_K[0][1]-=10;
8009  1727 ce001a        	ldw	x,_ee_K+2
8010  172a 1d000a        	subw	x,#10
8011  172d cf001a        	ldw	_ee_K+2,x
8012  1730               L7153:
8013                     ; 1640 		granee(&ee_K[0][1],50,3000);									
8015  1730 ae0bb8        	ldw	x,#3000
8016  1733 89            	pushw	x
8017  1734 ae0032        	ldw	x,#50
8018  1737 89            	pushw	x
8019  1738 ae001a        	ldw	x,#_ee_K+2
8020  173b cd0021        	call	_granee
8022  173e 5b04          	addw	sp,#4
8024  1740 ac981898      	jpf	L7353
8025  1744               L3153:
8026                     ; 1642 	else if((mess[9]&0xf0)==0x10)
8028  1744 b6c9          	ld	a,_mess+9
8029  1746 a4f0          	and	a,#240
8030  1748 a110          	cp	a,#16
8031  174a 2673          	jrne	L1453
8032                     ; 1644 		if((mess[9]&0x0f)==0x01)
8034  174c b6c9          	ld	a,_mess+9
8035  174e a40f          	and	a,#15
8036  1750 a101          	cp	a,#1
8037  1752 260d          	jrne	L3453
8038                     ; 1646 			ee_K[1][0]=adc_buff_[1];
8040  1754 ce0007        	ldw	x,_adc_buff_+2
8041  1757 89            	pushw	x
8042  1758 ae001c        	ldw	x,#_ee_K+4
8043  175b cd0000        	call	c_eewrw
8045  175e 85            	popw	x
8047  175f 204a          	jra	L5453
8048  1761               L3453:
8049                     ; 1648 		else if((mess[9]&0x0f)==0x02)
8051  1761 b6c9          	ld	a,_mess+9
8052  1763 a40f          	and	a,#15
8053  1765 a102          	cp	a,#2
8054  1767 260b          	jrne	L7453
8055                     ; 1650 			ee_K[1][1]++;
8057  1769 ce001e        	ldw	x,_ee_K+6
8058  176c 1c0001        	addw	x,#1
8059  176f cf001e        	ldw	_ee_K+6,x
8061  1772 2037          	jra	L5453
8062  1774               L7453:
8063                     ; 1652 		else if((mess[9]&0x0f)==0x03)
8065  1774 b6c9          	ld	a,_mess+9
8066  1776 a40f          	and	a,#15
8067  1778 a103          	cp	a,#3
8068  177a 260b          	jrne	L3553
8069                     ; 1654 			ee_K[1][1]+=10;
8071  177c ce001e        	ldw	x,_ee_K+6
8072  177f 1c000a        	addw	x,#10
8073  1782 cf001e        	ldw	_ee_K+6,x
8075  1785 2024          	jra	L5453
8076  1787               L3553:
8077                     ; 1656 		else if((mess[9]&0x0f)==0x04)
8079  1787 b6c9          	ld	a,_mess+9
8080  1789 a40f          	and	a,#15
8081  178b a104          	cp	a,#4
8082  178d 260b          	jrne	L7553
8083                     ; 1658 			ee_K[1][1]--;
8085  178f ce001e        	ldw	x,_ee_K+6
8086  1792 1d0001        	subw	x,#1
8087  1795 cf001e        	ldw	_ee_K+6,x
8089  1798 2011          	jra	L5453
8090  179a               L7553:
8091                     ; 1660 		else if((mess[9]&0x0f)==0x05)
8093  179a b6c9          	ld	a,_mess+9
8094  179c a40f          	and	a,#15
8095  179e a105          	cp	a,#5
8096  17a0 2609          	jrne	L5453
8097                     ; 1662 			ee_K[1][1]-=10;
8099  17a2 ce001e        	ldw	x,_ee_K+6
8100  17a5 1d000a        	subw	x,#10
8101  17a8 cf001e        	ldw	_ee_K+6,x
8102  17ab               L5453:
8103                     ; 1667 		granee(&ee_K[1][1],10,30000);
8105  17ab ae7530        	ldw	x,#30000
8106  17ae 89            	pushw	x
8107  17af ae000a        	ldw	x,#10
8108  17b2 89            	pushw	x
8109  17b3 ae001e        	ldw	x,#_ee_K+6
8110  17b6 cd0021        	call	_granee
8112  17b9 5b04          	addw	sp,#4
8114  17bb ac981898      	jpf	L7353
8115  17bf               L1453:
8116                     ; 1671 	else if((mess[9]&0xf0)==0x00)
8118  17bf b6c9          	ld	a,_mess+9
8119  17c1 a5f0          	bcp	a,#240
8120  17c3 2671          	jrne	L7653
8121                     ; 1673 		if((mess[9]&0x0f)==0x01)
8123  17c5 b6c9          	ld	a,_mess+9
8124  17c7 a40f          	and	a,#15
8125  17c9 a101          	cp	a,#1
8126  17cb 260d          	jrne	L1753
8127                     ; 1675 			ee_K[2][0]=adc_buff_[2];
8129  17cd ce0009        	ldw	x,_adc_buff_+4
8130  17d0 89            	pushw	x
8131  17d1 ae0020        	ldw	x,#_ee_K+8
8132  17d4 cd0000        	call	c_eewrw
8134  17d7 85            	popw	x
8136  17d8 204a          	jra	L3753
8137  17da               L1753:
8138                     ; 1677 		else if((mess[9]&0x0f)==0x02)
8140  17da b6c9          	ld	a,_mess+9
8141  17dc a40f          	and	a,#15
8142  17de a102          	cp	a,#2
8143  17e0 260b          	jrne	L5753
8144                     ; 1679 			ee_K[2][1]++;
8146  17e2 ce0022        	ldw	x,_ee_K+10
8147  17e5 1c0001        	addw	x,#1
8148  17e8 cf0022        	ldw	_ee_K+10,x
8150  17eb 2037          	jra	L3753
8151  17ed               L5753:
8152                     ; 1681 		else if((mess[9]&0x0f)==0x03)
8154  17ed b6c9          	ld	a,_mess+9
8155  17ef a40f          	and	a,#15
8156  17f1 a103          	cp	a,#3
8157  17f3 260b          	jrne	L1063
8158                     ; 1683 			ee_K[2][1]+=10;
8160  17f5 ce0022        	ldw	x,_ee_K+10
8161  17f8 1c000a        	addw	x,#10
8162  17fb cf0022        	ldw	_ee_K+10,x
8164  17fe 2024          	jra	L3753
8165  1800               L1063:
8166                     ; 1685 		else if((mess[9]&0x0f)==0x04)
8168  1800 b6c9          	ld	a,_mess+9
8169  1802 a40f          	and	a,#15
8170  1804 a104          	cp	a,#4
8171  1806 260b          	jrne	L5063
8172                     ; 1687 			ee_K[2][1]--;
8174  1808 ce0022        	ldw	x,_ee_K+10
8175  180b 1d0001        	subw	x,#1
8176  180e cf0022        	ldw	_ee_K+10,x
8178  1811 2011          	jra	L3753
8179  1813               L5063:
8180                     ; 1689 		else if((mess[9]&0x0f)==0x05)
8182  1813 b6c9          	ld	a,_mess+9
8183  1815 a40f          	and	a,#15
8184  1817 a105          	cp	a,#5
8185  1819 2609          	jrne	L3753
8186                     ; 1691 			ee_K[2][1]-=10;
8188  181b ce0022        	ldw	x,_ee_K+10
8189  181e 1d000a        	subw	x,#10
8190  1821 cf0022        	ldw	_ee_K+10,x
8191  1824               L3753:
8192                     ; 1696 		granee(&ee_K[2][1],10,30000);
8194  1824 ae7530        	ldw	x,#30000
8195  1827 89            	pushw	x
8196  1828 ae000a        	ldw	x,#10
8197  182b 89            	pushw	x
8198  182c ae0022        	ldw	x,#_ee_K+10
8199  182f cd0021        	call	_granee
8201  1832 5b04          	addw	sp,#4
8203  1834 2062          	jra	L7353
8204  1836               L7653:
8205                     ; 1700 	else if((mess[9]&0xf0)==0x30)
8207  1836 b6c9          	ld	a,_mess+9
8208  1838 a4f0          	and	a,#240
8209  183a a130          	cp	a,#48
8210  183c 265a          	jrne	L7353
8211                     ; 1702 		if((mess[9]&0x0f)==0x02)
8213  183e b6c9          	ld	a,_mess+9
8214  1840 a40f          	and	a,#15
8215  1842 a102          	cp	a,#2
8216  1844 260b          	jrne	L7163
8217                     ; 1704 			ee_K[3][1]++;
8219  1846 ce0026        	ldw	x,_ee_K+14
8220  1849 1c0001        	addw	x,#1
8221  184c cf0026        	ldw	_ee_K+14,x
8223  184f 2037          	jra	L1263
8224  1851               L7163:
8225                     ; 1706 		else if((mess[9]&0x0f)==0x03)
8227  1851 b6c9          	ld	a,_mess+9
8228  1853 a40f          	and	a,#15
8229  1855 a103          	cp	a,#3
8230  1857 260b          	jrne	L3263
8231                     ; 1708 			ee_K[3][1]+=10;
8233  1859 ce0026        	ldw	x,_ee_K+14
8234  185c 1c000a        	addw	x,#10
8235  185f cf0026        	ldw	_ee_K+14,x
8237  1862 2024          	jra	L1263
8238  1864               L3263:
8239                     ; 1710 		else if((mess[9]&0x0f)==0x04)
8241  1864 b6c9          	ld	a,_mess+9
8242  1866 a40f          	and	a,#15
8243  1868 a104          	cp	a,#4
8244  186a 260b          	jrne	L7263
8245                     ; 1712 			ee_K[3][1]--;
8247  186c ce0026        	ldw	x,_ee_K+14
8248  186f 1d0001        	subw	x,#1
8249  1872 cf0026        	ldw	_ee_K+14,x
8251  1875 2011          	jra	L1263
8252  1877               L7263:
8253                     ; 1714 		else if((mess[9]&0x0f)==0x05)
8255  1877 b6c9          	ld	a,_mess+9
8256  1879 a40f          	and	a,#15
8257  187b a105          	cp	a,#5
8258  187d 2609          	jrne	L1263
8259                     ; 1716 			ee_K[3][1]-=10;
8261  187f ce0026        	ldw	x,_ee_K+14
8262  1882 1d000a        	subw	x,#10
8263  1885 cf0026        	ldw	_ee_K+14,x
8264  1888               L1263:
8265                     ; 1718 		granee(&ee_K[3][1],300,517);									
8267  1888 ae0205        	ldw	x,#517
8268  188b 89            	pushw	x
8269  188c ae012c        	ldw	x,#300
8270  188f 89            	pushw	x
8271  1890 ae0026        	ldw	x,#_ee_K+14
8272  1893 cd0021        	call	_granee
8274  1896 5b04          	addw	sp,#4
8275  1898               L7353:
8276                     ; 1721 	link_cnt=0;
8278  1898 3f5e          	clr	_link_cnt
8279                     ; 1722      link=ON;
8281  189a 3555005f      	mov	_link,#85
8282                     ; 1723      if(res_fl_)
8284  189e 725d0008      	tnz	_res_fl_
8285  18a2 2603          	jrne	L412
8286  18a4 cc1bbf        	jp	L5243
8287  18a7               L412:
8288                     ; 1725       	res_fl_=0;
8290  18a7 4f            	clr	a
8291  18a8 ae0008        	ldw	x,#_res_fl_
8292  18ab cd0000        	call	c_eewrc
8294  18ae acbf1bbf      	jpf	L5243
8295  18b2               L1153:
8296                     ; 1731 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8298  18b2 b6c6          	ld	a,_mess+6
8299  18b4 a1ff          	cp	a,#255
8300  18b6 2703          	jreq	L612
8301  18b8 cc1946        	jp	L1463
8302  18bb               L612:
8304  18bb b6c7          	ld	a,_mess+7
8305  18bd a1ff          	cp	a,#255
8306  18bf 2703          	jreq	L022
8307  18c1 cc1946        	jp	L1463
8308  18c4               L022:
8310  18c4 b6c8          	ld	a,_mess+8
8311  18c6 a162          	cp	a,#98
8312  18c8 267c          	jrne	L1463
8313                     ; 1734 	tempSS=mess[9]+(mess[10]*256);
8315  18ca b6ca          	ld	a,_mess+10
8316  18cc 5f            	clrw	x
8317  18cd 97            	ld	xl,a
8318  18ce 4f            	clr	a
8319  18cf 02            	rlwa	x,a
8320  18d0 01            	rrwa	x,a
8321  18d1 bbc9          	add	a,_mess+9
8322  18d3 2401          	jrnc	L461
8323  18d5 5c            	incw	x
8324  18d6               L461:
8325  18d6 02            	rlwa	x,a
8326  18d7 1f04          	ldw	(OFST-1,sp),x
8327  18d9 01            	rrwa	x,a
8328                     ; 1735 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8330  18da ce0012        	ldw	x,_ee_Umax
8331  18dd 1304          	cpw	x,(OFST-1,sp)
8332  18df 270a          	jreq	L3463
8335  18e1 1e04          	ldw	x,(OFST-1,sp)
8336  18e3 89            	pushw	x
8337  18e4 ae0012        	ldw	x,#_ee_Umax
8338  18e7 cd0000        	call	c_eewrw
8340  18ea 85            	popw	x
8341  18eb               L3463:
8342                     ; 1736 	tempSS=mess[11]+(mess[12]*256);
8344  18eb b6cc          	ld	a,_mess+12
8345  18ed 5f            	clrw	x
8346  18ee 97            	ld	xl,a
8347  18ef 4f            	clr	a
8348  18f0 02            	rlwa	x,a
8349  18f1 01            	rrwa	x,a
8350  18f2 bbcb          	add	a,_mess+11
8351  18f4 2401          	jrnc	L661
8352  18f6 5c            	incw	x
8353  18f7               L661:
8354  18f7 02            	rlwa	x,a
8355  18f8 1f04          	ldw	(OFST-1,sp),x
8356  18fa 01            	rrwa	x,a
8357                     ; 1737 	if(ee_dU!=tempSS) ee_dU=tempSS;
8359  18fb ce0010        	ldw	x,_ee_dU
8360  18fe 1304          	cpw	x,(OFST-1,sp)
8361  1900 270a          	jreq	L5463
8364  1902 1e04          	ldw	x,(OFST-1,sp)
8365  1904 89            	pushw	x
8366  1905 ae0010        	ldw	x,#_ee_dU
8367  1908 cd0000        	call	c_eewrw
8369  190b 85            	popw	x
8370  190c               L5463:
8371                     ; 1738 	if((mess[13]&0x0f)==0x5)
8373  190c b6cd          	ld	a,_mess+13
8374  190e a40f          	and	a,#15
8375  1910 a105          	cp	a,#5
8376  1912 261a          	jrne	L7463
8377                     ; 1740 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8379  1914 ce0004        	ldw	x,_ee_AVT_MODE
8380  1917 a30055        	cpw	x,#85
8381  191a 2603          	jrne	L222
8382  191c cc1bbf        	jp	L5243
8383  191f               L222:
8386  191f ae0055        	ldw	x,#85
8387  1922 89            	pushw	x
8388  1923 ae0004        	ldw	x,#_ee_AVT_MODE
8389  1926 cd0000        	call	c_eewrw
8391  1929 85            	popw	x
8392  192a acbf1bbf      	jpf	L5243
8393  192e               L7463:
8394                     ; 1742 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8396  192e ce0004        	ldw	x,_ee_AVT_MODE
8397  1931 a30055        	cpw	x,#85
8398  1934 2703          	jreq	L422
8399  1936 cc1bbf        	jp	L5243
8400  1939               L422:
8403  1939 5f            	clrw	x
8404  193a 89            	pushw	x
8405  193b ae0004        	ldw	x,#_ee_AVT_MODE
8406  193e cd0000        	call	c_eewrw
8408  1941 85            	popw	x
8409  1942 acbf1bbf      	jpf	L5243
8410  1946               L1463:
8411                     ; 1745 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8413  1946 b6c6          	ld	a,_mess+6
8414  1948 a1ff          	cp	a,#255
8415  194a 2703          	jreq	L622
8416  194c cc1a1d        	jp	L1663
8417  194f               L622:
8419  194f b6c7          	ld	a,_mess+7
8420  1951 a1ff          	cp	a,#255
8421  1953 2703          	jreq	L032
8422  1955 cc1a1d        	jp	L1663
8423  1958               L032:
8425  1958 b6c8          	ld	a,_mess+8
8426  195a a126          	cp	a,#38
8427  195c 2709          	jreq	L3663
8429  195e b6c8          	ld	a,_mess+8
8430  1960 a129          	cp	a,#41
8431  1962 2703          	jreq	L232
8432  1964 cc1a1d        	jp	L1663
8433  1967               L232:
8434  1967               L3663:
8435                     ; 1748 	tempSS=mess[9]+(mess[10]*256);
8437  1967 b6ca          	ld	a,_mess+10
8438  1969 5f            	clrw	x
8439  196a 97            	ld	xl,a
8440  196b 4f            	clr	a
8441  196c 02            	rlwa	x,a
8442  196d 01            	rrwa	x,a
8443  196e bbc9          	add	a,_mess+9
8444  1970 2401          	jrnc	L071
8445  1972 5c            	incw	x
8446  1973               L071:
8447  1973 02            	rlwa	x,a
8448  1974 1f04          	ldw	(OFST-1,sp),x
8449  1976 01            	rrwa	x,a
8450                     ; 1749 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8452  1977 ce000e        	ldw	x,_ee_tmax
8453  197a 1304          	cpw	x,(OFST-1,sp)
8454  197c 270a          	jreq	L5663
8457  197e 1e04          	ldw	x,(OFST-1,sp)
8458  1980 89            	pushw	x
8459  1981 ae000e        	ldw	x,#_ee_tmax
8460  1984 cd0000        	call	c_eewrw
8462  1987 85            	popw	x
8463  1988               L5663:
8464                     ; 1750 	tempSS=mess[11]+(mess[12]*256);
8466  1988 b6cc          	ld	a,_mess+12
8467  198a 5f            	clrw	x
8468  198b 97            	ld	xl,a
8469  198c 4f            	clr	a
8470  198d 02            	rlwa	x,a
8471  198e 01            	rrwa	x,a
8472  198f bbcb          	add	a,_mess+11
8473  1991 2401          	jrnc	L271
8474  1993 5c            	incw	x
8475  1994               L271:
8476  1994 02            	rlwa	x,a
8477  1995 1f04          	ldw	(OFST-1,sp),x
8478  1997 01            	rrwa	x,a
8479                     ; 1751 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8481  1998 ce000c        	ldw	x,_ee_tsign
8482  199b 1304          	cpw	x,(OFST-1,sp)
8483  199d 270a          	jreq	L7663
8486  199f 1e04          	ldw	x,(OFST-1,sp)
8487  19a1 89            	pushw	x
8488  19a2 ae000c        	ldw	x,#_ee_tsign
8489  19a5 cd0000        	call	c_eewrw
8491  19a8 85            	popw	x
8492  19a9               L7663:
8493                     ; 1754 	if(mess[8]==MEM_KF1)
8495  19a9 b6c8          	ld	a,_mess+8
8496  19ab a126          	cp	a,#38
8497  19ad 2623          	jrne	L1763
8498                     ; 1756 		if(ee_DEVICE!=0)ee_DEVICE=0;
8500  19af ce0002        	ldw	x,_ee_DEVICE
8501  19b2 2709          	jreq	L3763
8504  19b4 5f            	clrw	x
8505  19b5 89            	pushw	x
8506  19b6 ae0002        	ldw	x,#_ee_DEVICE
8507  19b9 cd0000        	call	c_eewrw
8509  19bc 85            	popw	x
8510  19bd               L3763:
8511                     ; 1757 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8513  19bd b6cd          	ld	a,_mess+13
8514  19bf 5f            	clrw	x
8515  19c0 97            	ld	xl,a
8516  19c1 c30014        	cpw	x,_ee_TZAS
8517  19c4 270c          	jreq	L1763
8520  19c6 b6cd          	ld	a,_mess+13
8521  19c8 5f            	clrw	x
8522  19c9 97            	ld	xl,a
8523  19ca 89            	pushw	x
8524  19cb ae0014        	ldw	x,#_ee_TZAS
8525  19ce cd0000        	call	c_eewrw
8527  19d1 85            	popw	x
8528  19d2               L1763:
8529                     ; 1759 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8531  19d2 b6c8          	ld	a,_mess+8
8532  19d4 a129          	cp	a,#41
8533  19d6 2703          	jreq	L432
8534  19d8 cc1bbf        	jp	L5243
8535  19db               L432:
8536                     ; 1761 		if(ee_DEVICE!=1)ee_DEVICE=1;
8538  19db ce0002        	ldw	x,_ee_DEVICE
8539  19de a30001        	cpw	x,#1
8540  19e1 270b          	jreq	L1073
8543  19e3 ae0001        	ldw	x,#1
8544  19e6 89            	pushw	x
8545  19e7 ae0002        	ldw	x,#_ee_DEVICE
8546  19ea cd0000        	call	c_eewrw
8548  19ed 85            	popw	x
8549  19ee               L1073:
8550                     ; 1762 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8552  19ee b6cd          	ld	a,_mess+13
8553  19f0 5f            	clrw	x
8554  19f1 97            	ld	xl,a
8555  19f2 c30000        	cpw	x,_ee_IMAXVENT
8556  19f5 270c          	jreq	L3073
8559  19f7 b6cd          	ld	a,_mess+13
8560  19f9 5f            	clrw	x
8561  19fa 97            	ld	xl,a
8562  19fb 89            	pushw	x
8563  19fc ae0000        	ldw	x,#_ee_IMAXVENT
8564  19ff cd0000        	call	c_eewrw
8566  1a02 85            	popw	x
8567  1a03               L3073:
8568                     ; 1763 			if(ee_TZAS!=3) ee_TZAS=3;
8570  1a03 ce0014        	ldw	x,_ee_TZAS
8571  1a06 a30003        	cpw	x,#3
8572  1a09 2603          	jrne	L632
8573  1a0b cc1bbf        	jp	L5243
8574  1a0e               L632:
8577  1a0e ae0003        	ldw	x,#3
8578  1a11 89            	pushw	x
8579  1a12 ae0014        	ldw	x,#_ee_TZAS
8580  1a15 cd0000        	call	c_eewrw
8582  1a18 85            	popw	x
8583  1a19 acbf1bbf      	jpf	L5243
8584  1a1d               L1663:
8585                     ; 1767 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8587  1a1d b6c6          	ld	a,_mess+6
8588  1a1f c10001        	cp	a,_adress
8589  1a22 262d          	jrne	L1173
8591  1a24 b6c7          	ld	a,_mess+7
8592  1a26 c10001        	cp	a,_adress
8593  1a29 2626          	jrne	L1173
8595  1a2b b6c8          	ld	a,_mess+8
8596  1a2d a116          	cp	a,#22
8597  1a2f 2620          	jrne	L1173
8599  1a31 b6c9          	ld	a,_mess+9
8600  1a33 a163          	cp	a,#99
8601  1a35 261a          	jrne	L1173
8602                     ; 1769 	flags&=0b11100001;
8604  1a37 b60a          	ld	a,_flags
8605  1a39 a4e1          	and	a,#225
8606  1a3b b70a          	ld	_flags,a
8607                     ; 1770 	tsign_cnt=0;
8609  1a3d 5f            	clrw	x
8610  1a3e bf4a          	ldw	_tsign_cnt,x
8611                     ; 1771 	tmax_cnt=0;
8613  1a40 5f            	clrw	x
8614  1a41 bf48          	ldw	_tmax_cnt,x
8615                     ; 1772 	umax_cnt=0;
8617  1a43 5f            	clrw	x
8618  1a44 bf62          	ldw	_umax_cnt,x
8619                     ; 1773 	umin_cnt=0;
8621  1a46 5f            	clrw	x
8622  1a47 bf60          	ldw	_umin_cnt,x
8623                     ; 1774 	led_drv_cnt=30;
8625  1a49 351e0019      	mov	_led_drv_cnt,#30
8627  1a4d acbf1bbf      	jpf	L5243
8628  1a51               L1173:
8629                     ; 1776 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8631  1a51 b6c6          	ld	a,_mess+6
8632  1a53 a1ff          	cp	a,#255
8633  1a55 265f          	jrne	L5173
8635  1a57 b6c7          	ld	a,_mess+7
8636  1a59 a1ff          	cp	a,#255
8637  1a5b 2659          	jrne	L5173
8639  1a5d b6c8          	ld	a,_mess+8
8640  1a5f a116          	cp	a,#22
8641  1a61 2653          	jrne	L5173
8643  1a63 b6c9          	ld	a,_mess+9
8644  1a65 a116          	cp	a,#22
8645  1a67 264d          	jrne	L5173
8646                     ; 1778 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8648  1a69 b6ca          	ld	a,_mess+10
8649  1a6b a155          	cp	a,#85
8650  1a6d 260f          	jrne	L7173
8652  1a6f b6cb          	ld	a,_mess+11
8653  1a71 a155          	cp	a,#85
8654  1a73 2609          	jrne	L7173
8657  1a75 be5b          	ldw	x,__x_
8658  1a77 1c0001        	addw	x,#1
8659  1a7a bf5b          	ldw	__x_,x
8661  1a7c 2024          	jra	L1273
8662  1a7e               L7173:
8663                     ; 1779 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8665  1a7e b6ca          	ld	a,_mess+10
8666  1a80 a166          	cp	a,#102
8667  1a82 260f          	jrne	L3273
8669  1a84 b6cb          	ld	a,_mess+11
8670  1a86 a166          	cp	a,#102
8671  1a88 2609          	jrne	L3273
8674  1a8a be5b          	ldw	x,__x_
8675  1a8c 1d0001        	subw	x,#1
8676  1a8f bf5b          	ldw	__x_,x
8678  1a91 200f          	jra	L1273
8679  1a93               L3273:
8680                     ; 1780 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8682  1a93 b6ca          	ld	a,_mess+10
8683  1a95 a177          	cp	a,#119
8684  1a97 2609          	jrne	L1273
8686  1a99 b6cb          	ld	a,_mess+11
8687  1a9b a177          	cp	a,#119
8688  1a9d 2603          	jrne	L1273
8691  1a9f 5f            	clrw	x
8692  1aa0 bf5b          	ldw	__x_,x
8693  1aa2               L1273:
8694                     ; 1781      gran(&_x_,-XMAX,XMAX);
8696  1aa2 ae0019        	ldw	x,#25
8697  1aa5 89            	pushw	x
8698  1aa6 aeffe7        	ldw	x,#65511
8699  1aa9 89            	pushw	x
8700  1aaa ae005b        	ldw	x,#__x_
8701  1aad cd0000        	call	_gran
8703  1ab0 5b04          	addw	sp,#4
8705  1ab2 acbf1bbf      	jpf	L5243
8706  1ab6               L5173:
8707                     ; 1783 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8709  1ab6 b6c6          	ld	a,_mess+6
8710  1ab8 c10001        	cp	a,_adress
8711  1abb 2665          	jrne	L3373
8713  1abd b6c7          	ld	a,_mess+7
8714  1abf c10001        	cp	a,_adress
8715  1ac2 265e          	jrne	L3373
8717  1ac4 b6c8          	ld	a,_mess+8
8718  1ac6 a116          	cp	a,#22
8719  1ac8 2658          	jrne	L3373
8721  1aca b6c9          	ld	a,_mess+9
8722  1acc b1ca          	cp	a,_mess+10
8723  1ace 2652          	jrne	L3373
8725  1ad0 b6c9          	ld	a,_mess+9
8726  1ad2 a1ee          	cp	a,#238
8727  1ad4 264c          	jrne	L3373
8728                     ; 1785 	rotor_int++;
8730  1ad6 be1a          	ldw	x,_rotor_int
8731  1ad8 1c0001        	addw	x,#1
8732  1adb bf1a          	ldw	_rotor_int,x
8733                     ; 1786      tempI=pwm_u;
8735  1add be0b          	ldw	x,_pwm_u
8736  1adf 1f04          	ldw	(OFST-1,sp),x
8737                     ; 1787 	ee_U_AVT=tempI;
8739  1ae1 1e04          	ldw	x,(OFST-1,sp)
8740  1ae3 89            	pushw	x
8741  1ae4 ae000a        	ldw	x,#_ee_U_AVT
8742  1ae7 cd0000        	call	c_eewrw
8744  1aea 85            	popw	x
8745                     ; 1788 	UU_AVT=Un;
8747  1aeb be69          	ldw	x,_Un
8748  1aed 89            	pushw	x
8749  1aee ae0006        	ldw	x,#_UU_AVT
8750  1af1 cd0000        	call	c_eewrw
8752  1af4 85            	popw	x
8753                     ; 1789 	delay_ms(100);
8755  1af5 ae0064        	ldw	x,#100
8756  1af8 cd004c        	call	_delay_ms
8758                     ; 1790 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
8760  1afb ce000a        	ldw	x,_ee_U_AVT
8761  1afe 1304          	cpw	x,(OFST-1,sp)
8762  1b00 2703          	jreq	L042
8763  1b02 cc1bbf        	jp	L5243
8764  1b05               L042:
8767  1b05 4b00          	push	#0
8768  1b07 4b00          	push	#0
8769  1b09 4b00          	push	#0
8770  1b0b 4b00          	push	#0
8771  1b0d 4bdd          	push	#221
8772  1b0f 4bdd          	push	#221
8773  1b11 4b91          	push	#145
8774  1b13 3b0001        	push	_adress
8775  1b16 ae018e        	ldw	x,#398
8776  1b19 cd13ea        	call	_can_transmit
8778  1b1c 5b08          	addw	sp,#8
8779  1b1e acbf1bbf      	jpf	L5243
8780  1b22               L3373:
8781                     ; 1795 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8783  1b22 b6c7          	ld	a,_mess+7
8784  1b24 a1da          	cp	a,#218
8785  1b26 2652          	jrne	L1473
8787  1b28 b6c6          	ld	a,_mess+6
8788  1b2a c10001        	cp	a,_adress
8789  1b2d 274b          	jreq	L1473
8791  1b2f b6c6          	ld	a,_mess+6
8792  1b31 a106          	cp	a,#6
8793  1b33 2445          	jruge	L1473
8794                     ; 1797 	i_main_bps_cnt[mess[6]]=0;
8796  1b35 b6c6          	ld	a,_mess+6
8797  1b37 5f            	clrw	x
8798  1b38 97            	ld	xl,a
8799  1b39 6f06          	clr	(_i_main_bps_cnt,x)
8800                     ; 1798 	i_main_flag[mess[6]]=1;
8802  1b3b b6c6          	ld	a,_mess+6
8803  1b3d 5f            	clrw	x
8804  1b3e 97            	ld	xl,a
8805  1b3f a601          	ld	a,#1
8806  1b41 e711          	ld	(_i_main_flag,x),a
8807                     ; 1799 	if(bMAIN)
8809                     	btst	_bMAIN
8810  1b48 2475          	jruge	L5243
8811                     ; 1801 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8813  1b4a b6c9          	ld	a,_mess+9
8814  1b4c 5f            	clrw	x
8815  1b4d 97            	ld	xl,a
8816  1b4e 4f            	clr	a
8817  1b4f 02            	rlwa	x,a
8818  1b50 1f01          	ldw	(OFST-4,sp),x
8819  1b52 b6c8          	ld	a,_mess+8
8820  1b54 5f            	clrw	x
8821  1b55 97            	ld	xl,a
8822  1b56 72fb01        	addw	x,(OFST-4,sp)
8823  1b59 b6c6          	ld	a,_mess+6
8824  1b5b 905f          	clrw	y
8825  1b5d 9097          	ld	yl,a
8826  1b5f 9058          	sllw	y
8827  1b61 90ef17        	ldw	(_i_main,y),x
8828                     ; 1802 		i_main[adress]=I;
8830  1b64 c60001        	ld	a,_adress
8831  1b67 5f            	clrw	x
8832  1b68 97            	ld	xl,a
8833  1b69 58            	sllw	x
8834  1b6a 90be6b        	ldw	y,_I
8835  1b6d ef17          	ldw	(_i_main,x),y
8836                     ; 1803      	i_main_flag[adress]=1;
8838  1b6f c60001        	ld	a,_adress
8839  1b72 5f            	clrw	x
8840  1b73 97            	ld	xl,a
8841  1b74 a601          	ld	a,#1
8842  1b76 e711          	ld	(_i_main_flag,x),a
8843  1b78 2045          	jra	L5243
8844  1b7a               L1473:
8845                     ; 1807 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8847  1b7a b6c7          	ld	a,_mess+7
8848  1b7c a1db          	cp	a,#219
8849  1b7e 263f          	jrne	L5243
8851  1b80 b6c6          	ld	a,_mess+6
8852  1b82 c10001        	cp	a,_adress
8853  1b85 2738          	jreq	L5243
8855  1b87 b6c6          	ld	a,_mess+6
8856  1b89 a106          	cp	a,#6
8857  1b8b 2432          	jruge	L5243
8858                     ; 1809 	i_main_bps_cnt[mess[6]]=0;
8860  1b8d b6c6          	ld	a,_mess+6
8861  1b8f 5f            	clrw	x
8862  1b90 97            	ld	xl,a
8863  1b91 6f06          	clr	(_i_main_bps_cnt,x)
8864                     ; 1810 	i_main_flag[mess[6]]=1;		
8866  1b93 b6c6          	ld	a,_mess+6
8867  1b95 5f            	clrw	x
8868  1b96 97            	ld	xl,a
8869  1b97 a601          	ld	a,#1
8870  1b99 e711          	ld	(_i_main_flag,x),a
8871                     ; 1811 	if(bMAIN)
8873                     	btst	_bMAIN
8874  1ba0 241d          	jruge	L5243
8875                     ; 1813 		if(mess[9]==0)i_main_flag[i]=1;
8877  1ba2 3dc9          	tnz	_mess+9
8878  1ba4 260a          	jrne	L3573
8881  1ba6 7b03          	ld	a,(OFST-2,sp)
8882  1ba8 5f            	clrw	x
8883  1ba9 97            	ld	xl,a
8884  1baa a601          	ld	a,#1
8885  1bac e711          	ld	(_i_main_flag,x),a
8887  1bae 2006          	jra	L5573
8888  1bb0               L3573:
8889                     ; 1814 		else i_main_flag[i]=0;
8891  1bb0 7b03          	ld	a,(OFST-2,sp)
8892  1bb2 5f            	clrw	x
8893  1bb3 97            	ld	xl,a
8894  1bb4 6f11          	clr	(_i_main_flag,x)
8895  1bb6               L5573:
8896                     ; 1815 		i_main_flag[adress]=1;
8898  1bb6 c60001        	ld	a,_adress
8899  1bb9 5f            	clrw	x
8900  1bba 97            	ld	xl,a
8901  1bbb a601          	ld	a,#1
8902  1bbd e711          	ld	(_i_main_flag,x),a
8903  1bbf               L5243:
8904                     ; 1821 can_in_an_end:
8904                     ; 1822 bCAN_RX=0;
8906  1bbf 3f09          	clr	_bCAN_RX
8907                     ; 1823 }   
8910  1bc1 5b05          	addw	sp,#5
8911  1bc3 81            	ret
8934                     ; 1826 void t4_init(void){
8935                     	switch	.text
8936  1bc4               _t4_init:
8940                     ; 1827 	TIM4->PSCR = 4;
8942  1bc4 35045345      	mov	21317,#4
8943                     ; 1828 	TIM4->ARR= 77;
8945  1bc8 354d5346      	mov	21318,#77
8946                     ; 1829 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8948  1bcc 72105341      	bset	21313,#0
8949                     ; 1831 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8951  1bd0 35855340      	mov	21312,#133
8952                     ; 1833 }
8955  1bd4 81            	ret
8978                     ; 1836 void t1_init(void)
8978                     ; 1837 {
8979                     	switch	.text
8980  1bd5               _t1_init:
8984                     ; 1838 TIM1->ARRH= 0x03;
8986  1bd5 35035262      	mov	21090,#3
8987                     ; 1839 TIM1->ARRL= 0xff;
8989  1bd9 35ff5263      	mov	21091,#255
8990                     ; 1840 TIM1->CCR1H= 0x00;	
8992  1bdd 725f5265      	clr	21093
8993                     ; 1841 TIM1->CCR1L= 0xff;
8995  1be1 35ff5266      	mov	21094,#255
8996                     ; 1842 TIM1->CCR2H= 0x00;	
8998  1be5 725f5267      	clr	21095
8999                     ; 1843 TIM1->CCR2L= 0x00;
9001  1be9 725f5268      	clr	21096
9002                     ; 1844 TIM1->CCR3H= 0x00;	
9004  1bed 725f5269      	clr	21097
9005                     ; 1845 TIM1->CCR3L= 0x64;
9007  1bf1 3564526a      	mov	21098,#100
9008                     ; 1847 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9010  1bf5 35685258      	mov	21080,#104
9011                     ; 1848 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9013  1bf9 35685259      	mov	21081,#104
9014                     ; 1849 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9016  1bfd 3568525a      	mov	21082,#104
9017                     ; 1850 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9019  1c01 3511525c      	mov	21084,#17
9020                     ; 1851 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9022  1c05 3501525d      	mov	21085,#1
9023                     ; 1852 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9025  1c09 35815250      	mov	21072,#129
9026                     ; 1853 TIM1->BKR|= TIM1_BKR_AOE;
9028  1c0d 721c526d      	bset	21101,#6
9029                     ; 1854 }
9032  1c11 81            	ret
9057                     ; 1858 void adc2_init(void)
9057                     ; 1859 {
9058                     	switch	.text
9059  1c12               _adc2_init:
9063                     ; 1860 adc_plazma[0]++;
9065  1c12 beb2          	ldw	x,_adc_plazma
9066  1c14 1c0001        	addw	x,#1
9067  1c17 bfb2          	ldw	_adc_plazma,x
9068                     ; 1884 GPIOB->DDR&=~(1<<4);
9070  1c19 72195007      	bres	20487,#4
9071                     ; 1885 GPIOB->CR1&=~(1<<4);
9073  1c1d 72195008      	bres	20488,#4
9074                     ; 1886 GPIOB->CR2&=~(1<<4);
9076  1c21 72195009      	bres	20489,#4
9077                     ; 1888 GPIOB->DDR&=~(1<<5);
9079  1c25 721b5007      	bres	20487,#5
9080                     ; 1889 GPIOB->CR1&=~(1<<5);
9082  1c29 721b5008      	bres	20488,#5
9083                     ; 1890 GPIOB->CR2&=~(1<<5);
9085  1c2d 721b5009      	bres	20489,#5
9086                     ; 1892 GPIOB->DDR&=~(1<<6);
9088  1c31 721d5007      	bres	20487,#6
9089                     ; 1893 GPIOB->CR1&=~(1<<6);
9091  1c35 721d5008      	bres	20488,#6
9092                     ; 1894 GPIOB->CR2&=~(1<<6);
9094  1c39 721d5009      	bres	20489,#6
9095                     ; 1896 GPIOB->DDR&=~(1<<7);
9097  1c3d 721f5007      	bres	20487,#7
9098                     ; 1897 GPIOB->CR1&=~(1<<7);
9100  1c41 721f5008      	bres	20488,#7
9101                     ; 1898 GPIOB->CR2&=~(1<<7);
9103  1c45 721f5009      	bres	20489,#7
9104                     ; 1908 ADC2->TDRL=0xff;
9106  1c49 35ff5407      	mov	21511,#255
9107                     ; 1910 ADC2->CR2=0x08;
9109  1c4d 35085402      	mov	21506,#8
9110                     ; 1911 ADC2->CR1=0x40;
9112  1c51 35405401      	mov	21505,#64
9113                     ; 1914 	ADC2->CSR=0x20+adc_ch+3;
9115  1c55 b6bf          	ld	a,_adc_ch
9116  1c57 ab23          	add	a,#35
9117  1c59 c75400        	ld	21504,a
9118                     ; 1916 	ADC2->CR1|=1;
9120  1c5c 72105401      	bset	21505,#0
9121                     ; 1917 	ADC2->CR1|=1;
9123  1c60 72105401      	bset	21505,#0
9124                     ; 1920 adc_plazma[1]=adc_ch;
9126  1c64 b6bf          	ld	a,_adc_ch
9127  1c66 5f            	clrw	x
9128  1c67 97            	ld	xl,a
9129  1c68 bfb4          	ldw	_adc_plazma+2,x
9130                     ; 1921 }
9133  1c6a 81            	ret
9167                     ; 1930 @far @interrupt void TIM4_UPD_Interrupt (void) 
9167                     ; 1931 {
9169                     	switch	.text
9170  1c6b               f_TIM4_UPD_Interrupt:
9174                     ; 1932 TIM4->SR1&=~TIM4_SR1_UIF;
9176  1c6b 72115342      	bres	21314,#0
9177                     ; 1934 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9179  1c6f 3c05          	inc	_pwm_vent_cnt
9180  1c71 b605          	ld	a,_pwm_vent_cnt
9181  1c73 a10a          	cp	a,#10
9182  1c75 2502          	jrult	L7104
9185  1c77 3f05          	clr	_pwm_vent_cnt
9186  1c79               L7104:
9187                     ; 1935 GPIOB->ODR|=(1<<3);
9189  1c79 72165005      	bset	20485,#3
9190                     ; 1936 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9192  1c7d b605          	ld	a,_pwm_vent_cnt
9193  1c7f a105          	cp	a,#5
9194  1c81 2504          	jrult	L1204
9197  1c83 72175005      	bres	20485,#3
9198  1c87               L1204:
9199                     ; 1941 if(++t0_cnt0>=100)
9201  1c87 9c            	rvf
9202  1c88 be00          	ldw	x,_t0_cnt0
9203  1c8a 1c0001        	addw	x,#1
9204  1c8d bf00          	ldw	_t0_cnt0,x
9205  1c8f a30064        	cpw	x,#100
9206  1c92 2f3f          	jrslt	L3204
9207                     ; 1943 	t0_cnt0=0;
9209  1c94 5f            	clrw	x
9210  1c95 bf00          	ldw	_t0_cnt0,x
9211                     ; 1944 	b100Hz=1;
9213  1c97 72100008      	bset	_b100Hz
9214                     ; 1946 	if(++t0_cnt1>=10)
9216  1c9b 3c02          	inc	_t0_cnt1
9217  1c9d b602          	ld	a,_t0_cnt1
9218  1c9f a10a          	cp	a,#10
9219  1ca1 2506          	jrult	L5204
9220                     ; 1948 		t0_cnt1=0;
9222  1ca3 3f02          	clr	_t0_cnt1
9223                     ; 1949 		b10Hz=1;
9225  1ca5 72100007      	bset	_b10Hz
9226  1ca9               L5204:
9227                     ; 1952 	if(++t0_cnt2>=20)
9229  1ca9 3c03          	inc	_t0_cnt2
9230  1cab b603          	ld	a,_t0_cnt2
9231  1cad a114          	cp	a,#20
9232  1caf 2506          	jrult	L7204
9233                     ; 1954 		t0_cnt2=0;
9235  1cb1 3f03          	clr	_t0_cnt2
9236                     ; 1955 		b5Hz=1;
9238  1cb3 72100006      	bset	_b5Hz
9239  1cb7               L7204:
9240                     ; 1959 	if(++t0_cnt4>=50)
9242  1cb7 3c05          	inc	_t0_cnt4
9243  1cb9 b605          	ld	a,_t0_cnt4
9244  1cbb a132          	cp	a,#50
9245  1cbd 2506          	jrult	L1304
9246                     ; 1961 		t0_cnt4=0;
9248  1cbf 3f05          	clr	_t0_cnt4
9249                     ; 1962 		b2Hz=1;
9251  1cc1 72100005      	bset	_b2Hz
9252  1cc5               L1304:
9253                     ; 1965 	if(++t0_cnt3>=100)
9255  1cc5 3c04          	inc	_t0_cnt3
9256  1cc7 b604          	ld	a,_t0_cnt3
9257  1cc9 a164          	cp	a,#100
9258  1ccb 2506          	jrult	L3204
9259                     ; 1967 		t0_cnt3=0;
9261  1ccd 3f04          	clr	_t0_cnt3
9262                     ; 1968 		b1Hz=1;
9264  1ccf 72100004      	bset	_b1Hz
9265  1cd3               L3204:
9266                     ; 1974 }
9269  1cd3 80            	iret
9294                     ; 1977 @far @interrupt void CAN_RX_Interrupt (void) 
9294                     ; 1978 {
9295                     	switch	.text
9296  1cd4               f_CAN_RX_Interrupt:
9300                     ; 1980 CAN->PSR= 7;									// page 7 - read messsage
9302  1cd4 35075427      	mov	21543,#7
9303                     ; 1982 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9305  1cd8 ae000e        	ldw	x,#14
9306  1cdb               L452:
9307  1cdb d65427        	ld	a,(21543,x)
9308  1cde e7bf          	ld	(_mess-1,x),a
9309  1ce0 5a            	decw	x
9310  1ce1 26f8          	jrne	L452
9311                     ; 1993 bCAN_RX=1;
9313  1ce3 35010009      	mov	_bCAN_RX,#1
9314                     ; 1994 CAN->RFR|=(1<<5);
9316  1ce7 721a5424      	bset	21540,#5
9317                     ; 1996 }
9320  1ceb 80            	iret
9343                     ; 1999 @far @interrupt void CAN_TX_Interrupt (void) 
9343                     ; 2000 {
9344                     	switch	.text
9345  1cec               f_CAN_TX_Interrupt:
9349                     ; 2001 if((CAN->TSR)&(1<<0))
9351  1cec c65422        	ld	a,21538
9352  1cef a501          	bcp	a,#1
9353  1cf1 2708          	jreq	L5504
9354                     ; 2003 	bTX_FREE=1;	
9356  1cf3 35010008      	mov	_bTX_FREE,#1
9357                     ; 2005 	CAN->TSR|=(1<<0);
9359  1cf7 72105422      	bset	21538,#0
9360  1cfb               L5504:
9361                     ; 2007 }
9364  1cfb 80            	iret
9422                     ; 2010 @far @interrupt void ADC2_EOC_Interrupt (void) {
9423                     	switch	.text
9424  1cfc               f_ADC2_EOC_Interrupt:
9426       00000009      OFST:	set	9
9427  1cfc be00          	ldw	x,c_x
9428  1cfe 89            	pushw	x
9429  1cff be00          	ldw	x,c_y
9430  1d01 89            	pushw	x
9431  1d02 be02          	ldw	x,c_lreg+2
9432  1d04 89            	pushw	x
9433  1d05 be00          	ldw	x,c_lreg
9434  1d07 89            	pushw	x
9435  1d08 5209          	subw	sp,#9
9438                     ; 2015 adc_plazma[2]++;
9440  1d0a beb6          	ldw	x,_adc_plazma+4
9441  1d0c 1c0001        	addw	x,#1
9442  1d0f bfb6          	ldw	_adc_plazma+4,x
9443                     ; 2022 ADC2->CSR&=~(1<<7);
9445  1d11 721f5400      	bres	21504,#7
9446                     ; 2024 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9448  1d15 c65405        	ld	a,21509
9449  1d18 b703          	ld	c_lreg+3,a
9450  1d1a 3f02          	clr	c_lreg+2
9451  1d1c 3f01          	clr	c_lreg+1
9452  1d1e 3f00          	clr	c_lreg
9453  1d20 96            	ldw	x,sp
9454  1d21 1c0001        	addw	x,#OFST-8
9455  1d24 cd0000        	call	c_rtol
9457  1d27 c65404        	ld	a,21508
9458  1d2a 5f            	clrw	x
9459  1d2b 97            	ld	xl,a
9460  1d2c 90ae0100      	ldw	y,#256
9461  1d30 cd0000        	call	c_umul
9463  1d33 96            	ldw	x,sp
9464  1d34 1c0001        	addw	x,#OFST-8
9465  1d37 cd0000        	call	c_ladd
9467  1d3a 96            	ldw	x,sp
9468  1d3b 1c0006        	addw	x,#OFST-3
9469  1d3e cd0000        	call	c_rtol
9471                     ; 2029 if(adr_drv_stat==1)
9473  1d41 b607          	ld	a,_adr_drv_stat
9474  1d43 a101          	cp	a,#1
9475  1d45 260b          	jrne	L5014
9476                     ; 2031 	adr_drv_stat=2;
9478  1d47 35020007      	mov	_adr_drv_stat,#2
9479                     ; 2032 	adc_buff_[0]=temp_adc;
9481  1d4b 1e08          	ldw	x,(OFST-1,sp)
9482  1d4d cf0005        	ldw	_adc_buff_,x
9484  1d50 2020          	jra	L7014
9485  1d52               L5014:
9486                     ; 2035 else if(adr_drv_stat==3)
9488  1d52 b607          	ld	a,_adr_drv_stat
9489  1d54 a103          	cp	a,#3
9490  1d56 260b          	jrne	L1114
9491                     ; 2037 	adr_drv_stat=4;
9493  1d58 35040007      	mov	_adr_drv_stat,#4
9494                     ; 2038 	adc_buff_[1]=temp_adc;
9496  1d5c 1e08          	ldw	x,(OFST-1,sp)
9497  1d5e cf0007        	ldw	_adc_buff_+2,x
9499  1d61 200f          	jra	L7014
9500  1d63               L1114:
9501                     ; 2041 else if(adr_drv_stat==5)
9503  1d63 b607          	ld	a,_adr_drv_stat
9504  1d65 a105          	cp	a,#5
9505  1d67 2609          	jrne	L7014
9506                     ; 2043 	adr_drv_stat=6;
9508  1d69 35060007      	mov	_adr_drv_stat,#6
9509                     ; 2044 	adc_buff_[9]=temp_adc;
9511  1d6d 1e08          	ldw	x,(OFST-1,sp)
9512  1d6f cf0017        	ldw	_adc_buff_+18,x
9513  1d72               L7014:
9514                     ; 2047 adc_buff[adc_ch][adc_cnt]=temp_adc;
9516  1d72 b6be          	ld	a,_adc_cnt
9517  1d74 5f            	clrw	x
9518  1d75 97            	ld	xl,a
9519  1d76 58            	sllw	x
9520  1d77 1f03          	ldw	(OFST-6,sp),x
9521  1d79 b6bf          	ld	a,_adc_ch
9522  1d7b 97            	ld	xl,a
9523  1d7c a620          	ld	a,#32
9524  1d7e 42            	mul	x,a
9525  1d7f 72fb03        	addw	x,(OFST-6,sp)
9526  1d82 1608          	ldw	y,(OFST-1,sp)
9527  1d84 df0019        	ldw	(_adc_buff,x),y
9528                     ; 2053 adc_ch++;
9530  1d87 3cbf          	inc	_adc_ch
9531                     ; 2054 if(adc_ch>=5)
9533  1d89 b6bf          	ld	a,_adc_ch
9534  1d8b a105          	cp	a,#5
9535  1d8d 250c          	jrult	L7114
9536                     ; 2057 	adc_ch=0;
9538  1d8f 3fbf          	clr	_adc_ch
9539                     ; 2058 	adc_cnt++;
9541  1d91 3cbe          	inc	_adc_cnt
9542                     ; 2059 	if(adc_cnt>=16)
9544  1d93 b6be          	ld	a,_adc_cnt
9545  1d95 a110          	cp	a,#16
9546  1d97 2502          	jrult	L7114
9547                     ; 2061 		adc_cnt=0;
9549  1d99 3fbe          	clr	_adc_cnt
9550  1d9b               L7114:
9551                     ; 2065 if((adc_cnt&0x03)==0)
9553  1d9b b6be          	ld	a,_adc_cnt
9554  1d9d a503          	bcp	a,#3
9555  1d9f 264b          	jrne	L3214
9556                     ; 2069 	tempSS=0;
9558  1da1 ae0000        	ldw	x,#0
9559  1da4 1f08          	ldw	(OFST-1,sp),x
9560  1da6 ae0000        	ldw	x,#0
9561  1da9 1f06          	ldw	(OFST-3,sp),x
9562                     ; 2070 	for(i=0;i<16;i++)
9564  1dab 0f05          	clr	(OFST-4,sp)
9565  1dad               L5214:
9566                     ; 2072 		tempSS+=(signed long)adc_buff[adc_ch][i];
9568  1dad 7b05          	ld	a,(OFST-4,sp)
9569  1daf 5f            	clrw	x
9570  1db0 97            	ld	xl,a
9571  1db1 58            	sllw	x
9572  1db2 1f03          	ldw	(OFST-6,sp),x
9573  1db4 b6bf          	ld	a,_adc_ch
9574  1db6 97            	ld	xl,a
9575  1db7 a620          	ld	a,#32
9576  1db9 42            	mul	x,a
9577  1dba 72fb03        	addw	x,(OFST-6,sp)
9578  1dbd de0019        	ldw	x,(_adc_buff,x)
9579  1dc0 cd0000        	call	c_itolx
9581  1dc3 96            	ldw	x,sp
9582  1dc4 1c0006        	addw	x,#OFST-3
9583  1dc7 cd0000        	call	c_lgadd
9585                     ; 2070 	for(i=0;i<16;i++)
9587  1dca 0c05          	inc	(OFST-4,sp)
9590  1dcc 7b05          	ld	a,(OFST-4,sp)
9591  1dce a110          	cp	a,#16
9592  1dd0 25db          	jrult	L5214
9593                     ; 2074 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9595  1dd2 96            	ldw	x,sp
9596  1dd3 1c0006        	addw	x,#OFST-3
9597  1dd6 cd0000        	call	c_ltor
9599  1dd9 a604          	ld	a,#4
9600  1ddb cd0000        	call	c_lrsh
9602  1dde be02          	ldw	x,c_lreg+2
9603  1de0 b6bf          	ld	a,_adc_ch
9604  1de2 905f          	clrw	y
9605  1de4 9097          	ld	yl,a
9606  1de6 9058          	sllw	y
9607  1de8 90df0005      	ldw	(_adc_buff_,y),x
9608  1dec               L3214:
9609                     ; 2085 adc_plazma_short++;
9611  1dec bebc          	ldw	x,_adc_plazma_short
9612  1dee 1c0001        	addw	x,#1
9613  1df1 bfbc          	ldw	_adc_plazma_short,x
9614                     ; 2100 }
9617  1df3 5b09          	addw	sp,#9
9618  1df5 85            	popw	x
9619  1df6 bf00          	ldw	c_lreg,x
9620  1df8 85            	popw	x
9621  1df9 bf02          	ldw	c_lreg+2,x
9622  1dfb 85            	popw	x
9623  1dfc bf00          	ldw	c_y,x
9624  1dfe 85            	popw	x
9625  1dff bf00          	ldw	c_x,x
9626  1e01 80            	iret
9690                     ; 2108 main()
9690                     ; 2109 {
9692                     	switch	.text
9693  1e02               _main:
9697                     ; 2111 CLK->ECKR|=1;
9699  1e02 721050c1      	bset	20673,#0
9701  1e06               L5414:
9702                     ; 2112 while((CLK->ECKR & 2) == 0);
9704  1e06 c650c1        	ld	a,20673
9705  1e09 a502          	bcp	a,#2
9706  1e0b 27f9          	jreq	L5414
9707                     ; 2113 CLK->SWCR|=2;
9709  1e0d 721250c5      	bset	20677,#1
9710                     ; 2114 CLK->SWR=0xB4;
9712  1e11 35b450c4      	mov	20676,#180
9713                     ; 2116 delay_ms(200);
9715  1e15 ae00c8        	ldw	x,#200
9716  1e18 cd004c        	call	_delay_ms
9718                     ; 2117 FLASH_DUKR=0xae;
9720  1e1b 35ae5064      	mov	_FLASH_DUKR,#174
9721                     ; 2118 FLASH_DUKR=0x56;
9723  1e1f 35565064      	mov	_FLASH_DUKR,#86
9724                     ; 2119 enableInterrupts();
9727  1e23 9a            rim
9729                     ; 2122 adr_drv_v3();
9732  1e24 cd1038        	call	_adr_drv_v3
9734                     ; 2124 adress=0;
9736  1e27 725f0001      	clr	_adress
9737                     ; 2126 t4_init();
9739  1e2b cd1bc4        	call	_t4_init
9741                     ; 2128 		GPIOG->DDR|=(1<<0);
9743  1e2e 72105020      	bset	20512,#0
9744                     ; 2129 		GPIOG->CR1|=(1<<0);
9746  1e32 72105021      	bset	20513,#0
9747                     ; 2130 		GPIOG->CR2&=~(1<<0);	
9749  1e36 72115022      	bres	20514,#0
9750                     ; 2133 		GPIOG->DDR&=~(1<<1);
9752  1e3a 72135020      	bres	20512,#1
9753                     ; 2134 		GPIOG->CR1|=(1<<1);
9755  1e3e 72125021      	bset	20513,#1
9756                     ; 2135 		GPIOG->CR2&=~(1<<1);
9758  1e42 72135022      	bres	20514,#1
9759                     ; 2137 init_CAN();
9761  1e46 cd137b        	call	_init_CAN
9763                     ; 2142 GPIOC->DDR|=(1<<1);
9765  1e49 7212500c      	bset	20492,#1
9766                     ; 2143 GPIOC->CR1|=(1<<1);
9768  1e4d 7212500d      	bset	20493,#1
9769                     ; 2144 GPIOC->CR2|=(1<<1);
9771  1e51 7212500e      	bset	20494,#1
9772                     ; 2146 GPIOC->DDR|=(1<<2);
9774  1e55 7214500c      	bset	20492,#2
9775                     ; 2147 GPIOC->CR1|=(1<<2);
9777  1e59 7214500d      	bset	20493,#2
9778                     ; 2148 GPIOC->CR2|=(1<<2);
9780  1e5d 7214500e      	bset	20494,#2
9781                     ; 2155 t1_init();
9783  1e61 cd1bd5        	call	_t1_init
9785                     ; 2157 GPIOA->DDR|=(1<<5);
9787  1e64 721a5002      	bset	20482,#5
9788                     ; 2158 GPIOA->CR1|=(1<<5);
9790  1e68 721a5003      	bset	20483,#5
9791                     ; 2159 GPIOA->CR2&=~(1<<5);
9793  1e6c 721b5004      	bres	20484,#5
9794                     ; 2165 GPIOB->DDR|=(1<<3);
9796  1e70 72165007      	bset	20487,#3
9797                     ; 2166 GPIOB->CR1|=(1<<3);
9799  1e74 72165008      	bset	20488,#3
9800                     ; 2167 GPIOB->CR2|=(1<<3);
9802  1e78 72165009      	bset	20489,#3
9803                     ; 2169 GPIOC->DDR|=(1<<3);
9805  1e7c 7216500c      	bset	20492,#3
9806                     ; 2170 GPIOC->CR1|=(1<<3);
9808  1e80 7216500d      	bset	20493,#3
9809                     ; 2171 GPIOC->CR2|=(1<<3);
9811  1e84 7216500e      	bset	20494,#3
9812                     ; 2174 if(bps_class==bpsIPS) 
9814  1e88 b601          	ld	a,_bps_class
9815  1e8a a101          	cp	a,#1
9816  1e8c 260a          	jrne	L3514
9817                     ; 2176 	pwm_u=ee_U_AVT;
9819  1e8e ce000a        	ldw	x,_ee_U_AVT
9820  1e91 bf0b          	ldw	_pwm_u,x
9821                     ; 2177 	volum_u_main_=ee_U_AVT;
9823  1e93 ce000a        	ldw	x,_ee_U_AVT
9824  1e96 bf1c          	ldw	_volum_u_main_,x
9825  1e98               L3514:
9826                     ; 2184 	if(bCAN_RX)
9828  1e98 3d09          	tnz	_bCAN_RX
9829  1e9a 2705          	jreq	L7514
9830                     ; 2186 		bCAN_RX=0;
9832  1e9c 3f09          	clr	_bCAN_RX
9833                     ; 2187 		can_in_an();	
9835  1e9e cd1586        	call	_can_in_an
9837  1ea1               L7514:
9838                     ; 2189 	if(b100Hz)
9840                     	btst	_b100Hz
9841  1ea6 240a          	jruge	L1614
9842                     ; 2191 		b100Hz=0;
9844  1ea8 72110008      	bres	_b100Hz
9845                     ; 2200 		adc2_init();
9847  1eac cd1c12        	call	_adc2_init
9849                     ; 2201 		can_tx_hndl();
9851  1eaf cd146e        	call	_can_tx_hndl
9853  1eb2               L1614:
9854                     ; 2204 	if(b10Hz)
9856                     	btst	_b10Hz
9857  1eb7 2419          	jruge	L3614
9858                     ; 2206 		b10Hz=0;
9860  1eb9 72110007      	bres	_b10Hz
9861                     ; 2208           matemat();
9863  1ebd cd0bef        	call	_matemat
9865                     ; 2209 	    	led_drv(); 
9867  1ec0 cd0711        	call	_led_drv
9869                     ; 2210 	     link_drv();
9871  1ec3 cd081b        	call	_link_drv
9873                     ; 2211 	     pwr_hndl();		//вычисление воздействий на силу
9875  1ec6 cd0ad3        	call	_pwr_hndl
9877                     ; 2212 	     JP_drv();
9879  1ec9 cd0790        	call	_JP_drv
9881                     ; 2213 	     flags_drv();
9883  1ecc cd0fed        	call	_flags_drv
9885                     ; 2214 		net_drv();
9887  1ecf cd14d8        	call	_net_drv
9889  1ed2               L3614:
9890                     ; 2217 	if(b5Hz)
9892                     	btst	_b5Hz
9893  1ed7 240d          	jruge	L5614
9894                     ; 2219 		b5Hz=0;
9896  1ed9 72110006      	bres	_b5Hz
9897                     ; 2221 		pwr_drv();		//воздействие на силу
9899  1edd cd09cf        	call	_pwr_drv
9901                     ; 2222 		led_hndl();
9903  1ee0 cd008e        	call	_led_hndl
9905                     ; 2224 		vent_drv();
9907  1ee3 cd086a        	call	_vent_drv
9909  1ee6               L5614:
9910                     ; 2227 	if(b2Hz)
9912                     	btst	_b2Hz
9913  1eeb 2404          	jruge	L7614
9914                     ; 2229 		b2Hz=0;
9916  1eed 72110005      	bres	_b2Hz
9917  1ef1               L7614:
9918                     ; 2238 	if(b1Hz)
9920                     	btst	_b1Hz
9921  1ef6 24a0          	jruge	L3514
9922                     ; 2240 		b1Hz=0;
9924  1ef8 72110004      	bres	_b1Hz
9925                     ; 2242 		temper_drv();			//вычисление аварий температуры
9927  1efc cd0d1d        	call	_temper_drv
9929                     ; 2243 		u_drv();
9931  1eff cd0df4        	call	_u_drv
9933                     ; 2244           x_drv();
9935  1f02 cd0ed4        	call	_x_drv
9937                     ; 2245           if(main_cnt<1000)main_cnt++;
9939  1f05 9c            	rvf
9940  1f06 be4e          	ldw	x,_main_cnt
9941  1f08 a303e8        	cpw	x,#1000
9942  1f0b 2e07          	jrsge	L3714
9945  1f0d be4e          	ldw	x,_main_cnt
9946  1f0f 1c0001        	addw	x,#1
9947  1f12 bf4e          	ldw	_main_cnt,x
9948  1f14               L3714:
9949                     ; 2246   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9951  1f14 b65f          	ld	a,_link
9952  1f16 a1aa          	cp	a,#170
9953  1f18 2706          	jreq	L7714
9955  1f1a b647          	ld	a,_jp_mode
9956  1f1c a103          	cp	a,#3
9957  1f1e 2603          	jrne	L5714
9958  1f20               L7714:
9961  1f20 cd0f4e        	call	_apv_hndl
9963  1f23               L5714:
9964                     ; 2249   		can_error_cnt++;
9966  1f23 3c6d          	inc	_can_error_cnt
9967                     ; 2250   		if(can_error_cnt>=10)
9969  1f25 b66d          	ld	a,_can_error_cnt
9970  1f27 a10a          	cp	a,#10
9971  1f29 2505          	jrult	L1024
9972                     ; 2252   			can_error_cnt=0;
9974  1f2b 3f6d          	clr	_can_error_cnt
9975                     ; 2253 			init_CAN();
9977  1f2d cd137b        	call	_init_CAN
9979  1f30               L1024:
9980                     ; 2257 		volum_u_main_drv();
9982  1f30 cd1228        	call	_volum_u_main_drv
9984                     ; 2259 		pwm_stat++;
9986  1f33 3c04          	inc	_pwm_stat
9987                     ; 2260 		if(pwm_stat>=10)pwm_stat=0;
9989  1f35 b604          	ld	a,_pwm_stat
9990  1f37 a10a          	cp	a,#10
9991  1f39 2502          	jrult	L3024
9994  1f3b 3f04          	clr	_pwm_stat
9995  1f3d               L3024:
9996                     ; 2261 adc_plazma_short++;
9998  1f3d bebc          	ldw	x,_adc_plazma_short
9999  1f3f 1c0001        	addw	x,#1
10000  1f42 bfbc          	ldw	_adc_plazma_short,x
10001  1f44 ac981e98      	jpf	L3514
11015                     	xdef	_main
11016                     	xdef	f_ADC2_EOC_Interrupt
11017                     	xdef	f_CAN_TX_Interrupt
11018                     	xdef	f_CAN_RX_Interrupt
11019                     	xdef	f_TIM4_UPD_Interrupt
11020                     	xdef	_adc2_init
11021                     	xdef	_t1_init
11022                     	xdef	_t4_init
11023                     	xdef	_can_in_an
11024                     	xdef	_net_drv
11025                     	xdef	_can_tx_hndl
11026                     	xdef	_can_transmit
11027                     	xdef	_init_CAN
11028                     	xdef	_volum_u_main_drv
11029                     	xdef	_adr_drv_v3
11030                     	xdef	_adr_drv_v4
11031                     	xdef	_flags_drv
11032                     	xdef	_apv_hndl
11033                     	xdef	_apv_stop
11034                     	xdef	_apv_start
11035                     	xdef	_x_drv
11036                     	xdef	_u_drv
11037                     	xdef	_temper_drv
11038                     	xdef	_matemat
11039                     	xdef	_pwr_hndl
11040                     	xdef	_pwr_drv
11041                     	xdef	_vent_drv
11042                     	xdef	_link_drv
11043                     	xdef	_JP_drv
11044                     	xdef	_led_drv
11045                     	xdef	_led_hndl
11046                     	xdef	_delay_ms
11047                     	xdef	_granee
11048                     	xdef	_gran
11049                     .eeprom:	section	.data
11050  0000               _ee_IMAXVENT:
11051  0000 0000          	ds.b	2
11052                     	xdef	_ee_IMAXVENT
11053                     	switch	.ubsct
11054  0001               _bps_class:
11055  0001 00            	ds.b	1
11056                     	xdef	_bps_class
11057  0002               _vent_pwm:
11058  0002 0000          	ds.b	2
11059                     	xdef	_vent_pwm
11060  0004               _pwm_stat:
11061  0004 00            	ds.b	1
11062                     	xdef	_pwm_stat
11063  0005               _pwm_vent_cnt:
11064  0005 00            	ds.b	1
11065                     	xdef	_pwm_vent_cnt
11066                     	switch	.eeprom
11067  0002               _ee_DEVICE:
11068  0002 0000          	ds.b	2
11069                     	xdef	_ee_DEVICE
11070  0004               _ee_AVT_MODE:
11071  0004 0000          	ds.b	2
11072                     	xdef	_ee_AVT_MODE
11073                     	switch	.ubsct
11074  0006               _i_main_bps_cnt:
11075  0006 000000000000  	ds.b	6
11076                     	xdef	_i_main_bps_cnt
11077  000c               _i_main_sigma:
11078  000c 0000          	ds.b	2
11079                     	xdef	_i_main_sigma
11080  000e               _i_main_num_of_bps:
11081  000e 00            	ds.b	1
11082                     	xdef	_i_main_num_of_bps
11083  000f               _i_main_avg:
11084  000f 0000          	ds.b	2
11085                     	xdef	_i_main_avg
11086  0011               _i_main_flag:
11087  0011 000000000000  	ds.b	6
11088                     	xdef	_i_main_flag
11089  0017               _i_main:
11090  0017 000000000000  	ds.b	12
11091                     	xdef	_i_main
11092  0023               _x:
11093  0023 000000000000  	ds.b	12
11094                     	xdef	_x
11095                     	xdef	_volum_u_main_
11096                     	switch	.eeprom
11097  0006               _UU_AVT:
11098  0006 0000          	ds.b	2
11099                     	xdef	_UU_AVT
11100                     	switch	.ubsct
11101  002f               _cnt_net_drv:
11102  002f 00            	ds.b	1
11103                     	xdef	_cnt_net_drv
11104                     	switch	.bit
11105  0001               _bMAIN:
11106  0001 00            	ds.b	1
11107                     	xdef	_bMAIN
11108                     	switch	.ubsct
11109  0030               _plazma_int:
11110  0030 000000000000  	ds.b	6
11111                     	xdef	_plazma_int
11112                     	xdef	_rotor_int
11113  0036               _led_green_buff:
11114  0036 00000000      	ds.b	4
11115                     	xdef	_led_green_buff
11116  003a               _led_red_buff:
11117  003a 00000000      	ds.b	4
11118                     	xdef	_led_red_buff
11119                     	xdef	_led_drv_cnt
11120                     	xdef	_led_green
11121                     	xdef	_led_red
11122  003e               _res_fl_cnt:
11123  003e 00            	ds.b	1
11124                     	xdef	_res_fl_cnt
11125                     	xdef	_bRES_
11126                     	xdef	_bRES
11127                     	switch	.eeprom
11128  0008               _res_fl_:
11129  0008 00            	ds.b	1
11130                     	xdef	_res_fl_
11131  0009               _res_fl:
11132  0009 00            	ds.b	1
11133                     	xdef	_res_fl
11134                     	switch	.ubsct
11135  003f               _cnt_apv_off:
11136  003f 00            	ds.b	1
11137                     	xdef	_cnt_apv_off
11138                     	switch	.bit
11139  0002               _bAPV:
11140  0002 00            	ds.b	1
11141                     	xdef	_bAPV
11142                     	switch	.ubsct
11143  0040               _apv_cnt_:
11144  0040 0000          	ds.b	2
11145                     	xdef	_apv_cnt_
11146  0042               _apv_cnt:
11147  0042 000000        	ds.b	3
11148                     	xdef	_apv_cnt
11149                     	xdef	_bBL_IPS
11150                     	switch	.bit
11151  0003               _bBL:
11152  0003 00            	ds.b	1
11153                     	xdef	_bBL
11154                     	switch	.ubsct
11155  0045               _cnt_JP1:
11156  0045 00            	ds.b	1
11157                     	xdef	_cnt_JP1
11158  0046               _cnt_JP0:
11159  0046 00            	ds.b	1
11160                     	xdef	_cnt_JP0
11161  0047               _jp_mode:
11162  0047 00            	ds.b	1
11163                     	xdef	_jp_mode
11164                     	xdef	_pwm_i
11165                     	xdef	_pwm_u
11166  0048               _tmax_cnt:
11167  0048 0000          	ds.b	2
11168                     	xdef	_tmax_cnt
11169  004a               _tsign_cnt:
11170  004a 0000          	ds.b	2
11171                     	xdef	_tsign_cnt
11172                     	switch	.eeprom
11173  000a               _ee_U_AVT:
11174  000a 0000          	ds.b	2
11175                     	xdef	_ee_U_AVT
11176  000c               _ee_tsign:
11177  000c 0000          	ds.b	2
11178                     	xdef	_ee_tsign
11179  000e               _ee_tmax:
11180  000e 0000          	ds.b	2
11181                     	xdef	_ee_tmax
11182  0010               _ee_dU:
11183  0010 0000          	ds.b	2
11184                     	xdef	_ee_dU
11185  0012               _ee_Umax:
11186  0012 0000          	ds.b	2
11187                     	xdef	_ee_Umax
11188  0014               _ee_TZAS:
11189  0014 0000          	ds.b	2
11190                     	xdef	_ee_TZAS
11191                     	switch	.ubsct
11192  004c               _main_cnt1:
11193  004c 0000          	ds.b	2
11194                     	xdef	_main_cnt1
11195  004e               _main_cnt:
11196  004e 0000          	ds.b	2
11197                     	xdef	_main_cnt
11198  0050               _off_bp_cnt:
11199  0050 00            	ds.b	1
11200                     	xdef	_off_bp_cnt
11201  0051               _flags_tu_cnt_off:
11202  0051 00            	ds.b	1
11203                     	xdef	_flags_tu_cnt_off
11204  0052               _flags_tu_cnt_on:
11205  0052 00            	ds.b	1
11206                     	xdef	_flags_tu_cnt_on
11207  0053               _vol_i_temp:
11208  0053 0000          	ds.b	2
11209                     	xdef	_vol_i_temp
11210  0055               _vol_u_temp:
11211  0055 0000          	ds.b	2
11212                     	xdef	_vol_u_temp
11213                     	switch	.eeprom
11214  0016               __x_ee_:
11215  0016 0000          	ds.b	2
11216                     	xdef	__x_ee_
11217                     	switch	.ubsct
11218  0057               __x_cnt:
11219  0057 0000          	ds.b	2
11220                     	xdef	__x_cnt
11221  0059               __x__:
11222  0059 0000          	ds.b	2
11223                     	xdef	__x__
11224  005b               __x_:
11225  005b 0000          	ds.b	2
11226                     	xdef	__x_
11227  005d               _flags_tu:
11228  005d 00            	ds.b	1
11229                     	xdef	_flags_tu
11230                     	xdef	_flags
11231  005e               _link_cnt:
11232  005e 00            	ds.b	1
11233                     	xdef	_link_cnt
11234  005f               _link:
11235  005f 00            	ds.b	1
11236                     	xdef	_link
11237  0060               _umin_cnt:
11238  0060 0000          	ds.b	2
11239                     	xdef	_umin_cnt
11240  0062               _umax_cnt:
11241  0062 0000          	ds.b	2
11242                     	xdef	_umax_cnt
11243                     	switch	.eeprom
11244  0018               _ee_K:
11245  0018 000000000000  	ds.b	16
11246                     	xdef	_ee_K
11247                     	switch	.ubsct
11248  0064               _T:
11249  0064 00            	ds.b	1
11250                     	xdef	_T
11251  0065               _Udb:
11252  0065 0000          	ds.b	2
11253                     	xdef	_Udb
11254  0067               _Ui:
11255  0067 0000          	ds.b	2
11256                     	xdef	_Ui
11257  0069               _Un:
11258  0069 0000          	ds.b	2
11259                     	xdef	_Un
11260  006b               _I:
11261  006b 0000          	ds.b	2
11262                     	xdef	_I
11263  006d               _can_error_cnt:
11264  006d 00            	ds.b	1
11265                     	xdef	_can_error_cnt
11266                     	xdef	_bCAN_RX
11267  006e               _tx_busy_cnt:
11268  006e 00            	ds.b	1
11269                     	xdef	_tx_busy_cnt
11270                     	xdef	_bTX_FREE
11271  006f               _can_buff_rd_ptr:
11272  006f 00            	ds.b	1
11273                     	xdef	_can_buff_rd_ptr
11274  0070               _can_buff_wr_ptr:
11275  0070 00            	ds.b	1
11276                     	xdef	_can_buff_wr_ptr
11277  0071               _can_out_buff:
11278  0071 000000000000  	ds.b	64
11279                     	xdef	_can_out_buff
11280                     	switch	.bss
11281  0000               _adress_error:
11282  0000 00            	ds.b	1
11283                     	xdef	_adress_error
11284  0001               _adress:
11285  0001 00            	ds.b	1
11286                     	xdef	_adress
11287  0002               _adr:
11288  0002 000000        	ds.b	3
11289                     	xdef	_adr
11290                     	xdef	_adr_drv_stat
11291                     	xdef	_led_ind
11292                     	switch	.ubsct
11293  00b1               _led_ind_cnt:
11294  00b1 00            	ds.b	1
11295                     	xdef	_led_ind_cnt
11296  00b2               _adc_plazma:
11297  00b2 000000000000  	ds.b	10
11298                     	xdef	_adc_plazma
11299  00bc               _adc_plazma_short:
11300  00bc 0000          	ds.b	2
11301                     	xdef	_adc_plazma_short
11302  00be               _adc_cnt:
11303  00be 00            	ds.b	1
11304                     	xdef	_adc_cnt
11305  00bf               _adc_ch:
11306  00bf 00            	ds.b	1
11307                     	xdef	_adc_ch
11308                     	switch	.bss
11309  0005               _adc_buff_:
11310  0005 000000000000  	ds.b	20
11311                     	xdef	_adc_buff_
11312  0019               _adc_buff:
11313  0019 000000000000  	ds.b	320
11314                     	xdef	_adc_buff
11315                     	switch	.ubsct
11316  00c0               _mess:
11317  00c0 000000000000  	ds.b	14
11318                     	xdef	_mess
11319                     	switch	.bit
11320  0004               _b1Hz:
11321  0004 00            	ds.b	1
11322                     	xdef	_b1Hz
11323  0005               _b2Hz:
11324  0005 00            	ds.b	1
11325                     	xdef	_b2Hz
11326  0006               _b5Hz:
11327  0006 00            	ds.b	1
11328                     	xdef	_b5Hz
11329  0007               _b10Hz:
11330  0007 00            	ds.b	1
11331                     	xdef	_b10Hz
11332  0008               _b100Hz:
11333  0008 00            	ds.b	1
11334                     	xdef	_b100Hz
11335                     	xdef	_t0_cnt4
11336                     	xdef	_t0_cnt3
11337                     	xdef	_t0_cnt2
11338                     	xdef	_t0_cnt1
11339                     	xdef	_t0_cnt0
11340                     	xref.b	c_lreg
11341                     	xref.b	c_x
11342                     	xref.b	c_y
11362                     	xref	c_lrsh
11363                     	xref	c_lgadd
11364                     	xref	c_ladd
11365                     	xref	c_umul
11366                     	xref	c_lgmul
11367                     	xref	c_lgsub
11368                     	xref	c_lsbc
11369                     	xref	c_idiv
11370                     	xref	c_ldiv
11371                     	xref	c_itolx
11372                     	xref	c_eewrc
11373                     	xref	c_imul
11374                     	xref	c_lcmp
11375                     	xref	c_ltor
11376                     	xref	c_lgadc
11377                     	xref	c_rtol
11378                     	xref	c_vmul
11379                     	xref	c_eewrw
11380                     	end
