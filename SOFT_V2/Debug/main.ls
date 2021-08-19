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
3698                     ; 492 void led_drv(void)
3698                     ; 493 {
3699                     	switch	.text
3700  0711               _led_drv:
3704                     ; 495 GPIOA->DDR|=(1<<6);
3706  0711 721c5002      	bset	20482,#6
3707                     ; 496 GPIOA->CR1|=(1<<6);
3709  0715 721c5003      	bset	20483,#6
3710                     ; 497 GPIOA->CR2&=~(1<<6);
3712  0719 721d5004      	bres	20484,#6
3713                     ; 498 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<6); 	//Горит если в led_red_buff 1 и на ножке 1
3715  071d b63d          	ld	a,_led_red_buff+3
3716  071f a501          	bcp	a,#1
3717  0721 2706          	jreq	L1112
3720  0723 721c5000      	bset	20480,#6
3722  0727 2004          	jra	L3112
3723  0729               L1112:
3724                     ; 499 else GPIOA->ODR&=~(1<<6); 
3726  0729 721d5000      	bres	20480,#6
3727  072d               L3112:
3728                     ; 502 GPIOA->DDR|=(1<<5);
3730  072d 721a5002      	bset	20482,#5
3731                     ; 503 GPIOA->CR1|=(1<<5);
3733  0731 721a5003      	bset	20483,#5
3734                     ; 504 GPIOA->CR2&=~(1<<5);	
3736  0735 721b5004      	bres	20484,#5
3737                     ; 505 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3739  0739 b639          	ld	a,_led_green_buff+3
3740  073b a501          	bcp	a,#1
3741  073d 2706          	jreq	L5112
3744  073f 721a5000      	bset	20480,#5
3746  0743 2004          	jra	L7112
3747  0745               L5112:
3748                     ; 506 else GPIOA->ODR&=~(1<<5);
3750  0745 721b5000      	bres	20480,#5
3751  0749               L7112:
3752                     ; 509 led_red_buff>>=1;
3754  0749 373a          	sra	_led_red_buff
3755  074b 363b          	rrc	_led_red_buff+1
3756  074d 363c          	rrc	_led_red_buff+2
3757  074f 363d          	rrc	_led_red_buff+3
3758                     ; 510 led_green_buff>>=1;
3760  0751 3736          	sra	_led_green_buff
3761  0753 3637          	rrc	_led_green_buff+1
3762  0755 3638          	rrc	_led_green_buff+2
3763  0757 3639          	rrc	_led_green_buff+3
3764                     ; 511 if(++led_drv_cnt>32)
3766  0759 3c19          	inc	_led_drv_cnt
3767  075b b619          	ld	a,_led_drv_cnt
3768  075d a121          	cp	a,#33
3769  075f 2512          	jrult	L1212
3770                     ; 513 	led_drv_cnt=0;
3772  0761 3f19          	clr	_led_drv_cnt
3773                     ; 514 	led_red_buff=led_red;
3775  0763 be13          	ldw	x,_led_red+2
3776  0765 bf3c          	ldw	_led_red_buff+2,x
3777  0767 be11          	ldw	x,_led_red
3778  0769 bf3a          	ldw	_led_red_buff,x
3779                     ; 515 	led_green_buff=led_green;
3781  076b be17          	ldw	x,_led_green+2
3782  076d bf38          	ldw	_led_green_buff+2,x
3783  076f be15          	ldw	x,_led_green
3784  0771 bf36          	ldw	_led_green_buff,x
3785  0773               L1212:
3786                     ; 521 } 
3789  0773 81            	ret
3815                     ; 524 void JP_drv(void)
3815                     ; 525 {
3816                     	switch	.text
3817  0774               _JP_drv:
3821                     ; 527 GPIOD->DDR&=~(1<<6);
3823  0774 721d5011      	bres	20497,#6
3824                     ; 528 GPIOD->CR1|=(1<<6);
3826  0778 721c5012      	bset	20498,#6
3827                     ; 529 GPIOD->CR2&=~(1<<6);
3829  077c 721d5013      	bres	20499,#6
3830                     ; 531 GPIOD->DDR&=~(1<<7);
3832  0780 721f5011      	bres	20497,#7
3833                     ; 532 GPIOD->CR1|=(1<<7);
3835  0784 721e5012      	bset	20498,#7
3836                     ; 533 GPIOD->CR2&=~(1<<7);
3838  0788 721f5013      	bres	20499,#7
3839                     ; 535 if(GPIOD->IDR&(1<<6))
3841  078c c65010        	ld	a,20496
3842  078f a540          	bcp	a,#64
3843  0791 270a          	jreq	L3312
3844                     ; 537 	if(cnt_JP0<10)
3846  0793 b646          	ld	a,_cnt_JP0
3847  0795 a10a          	cp	a,#10
3848  0797 2411          	jruge	L7312
3849                     ; 539 		cnt_JP0++;
3851  0799 3c46          	inc	_cnt_JP0
3852  079b 200d          	jra	L7312
3853  079d               L3312:
3854                     ; 542 else if(!(GPIOD->IDR&(1<<6)))
3856  079d c65010        	ld	a,20496
3857  07a0 a540          	bcp	a,#64
3858  07a2 2606          	jrne	L7312
3859                     ; 544 	if(cnt_JP0)
3861  07a4 3d46          	tnz	_cnt_JP0
3862  07a6 2702          	jreq	L7312
3863                     ; 546 		cnt_JP0--;
3865  07a8 3a46          	dec	_cnt_JP0
3866  07aa               L7312:
3867                     ; 550 if(GPIOD->IDR&(1<<7))
3869  07aa c65010        	ld	a,20496
3870  07ad a580          	bcp	a,#128
3871  07af 270a          	jreq	L5412
3872                     ; 552 	if(cnt_JP1<10)
3874  07b1 b645          	ld	a,_cnt_JP1
3875  07b3 a10a          	cp	a,#10
3876  07b5 2411          	jruge	L1512
3877                     ; 554 		cnt_JP1++;
3879  07b7 3c45          	inc	_cnt_JP1
3880  07b9 200d          	jra	L1512
3881  07bb               L5412:
3882                     ; 557 else if(!(GPIOD->IDR&(1<<7)))
3884  07bb c65010        	ld	a,20496
3885  07be a580          	bcp	a,#128
3886  07c0 2606          	jrne	L1512
3887                     ; 559 	if(cnt_JP1)
3889  07c2 3d45          	tnz	_cnt_JP1
3890  07c4 2702          	jreq	L1512
3891                     ; 561 		cnt_JP1--;
3893  07c6 3a45          	dec	_cnt_JP1
3894  07c8               L1512:
3895                     ; 566 if((cnt_JP0==10)&&(cnt_JP1==10))
3897  07c8 b646          	ld	a,_cnt_JP0
3898  07ca a10a          	cp	a,#10
3899  07cc 2608          	jrne	L7512
3901  07ce b645          	ld	a,_cnt_JP1
3902  07d0 a10a          	cp	a,#10
3903  07d2 2602          	jrne	L7512
3904                     ; 568 	jp_mode=jp0;
3906  07d4 3f47          	clr	_jp_mode
3907  07d6               L7512:
3908                     ; 570 if((cnt_JP0==0)&&(cnt_JP1==10))
3910  07d6 3d46          	tnz	_cnt_JP0
3911  07d8 260a          	jrne	L1612
3913  07da b645          	ld	a,_cnt_JP1
3914  07dc a10a          	cp	a,#10
3915  07de 2604          	jrne	L1612
3916                     ; 572 	jp_mode=jp1;
3918  07e0 35010047      	mov	_jp_mode,#1
3919  07e4               L1612:
3920                     ; 574 if((cnt_JP0==10)&&(cnt_JP1==0))
3922  07e4 b646          	ld	a,_cnt_JP0
3923  07e6 a10a          	cp	a,#10
3924  07e8 2608          	jrne	L3612
3926  07ea 3d45          	tnz	_cnt_JP1
3927  07ec 2604          	jrne	L3612
3928                     ; 576 	jp_mode=jp2;
3930  07ee 35020047      	mov	_jp_mode,#2
3931  07f2               L3612:
3932                     ; 578 if((cnt_JP0==0)&&(cnt_JP1==0))
3934  07f2 3d46          	tnz	_cnt_JP0
3935  07f4 2608          	jrne	L5612
3937  07f6 3d45          	tnz	_cnt_JP1
3938  07f8 2604          	jrne	L5612
3939                     ; 580 	jp_mode=jp3;
3941  07fa 35030047      	mov	_jp_mode,#3
3942  07fe               L5612:
3943                     ; 583 }
3946  07fe 81            	ret
3978                     ; 586 void link_drv(void)		//10Hz
3978                     ; 587 {
3979                     	switch	.text
3980  07ff               _link_drv:
3984                     ; 588 if(jp_mode!=jp3)
3986  07ff b647          	ld	a,_jp_mode
3987  0801 a103          	cp	a,#3
3988  0803 2744          	jreq	L7712
3989                     ; 590 	if(link_cnt<52)link_cnt++;
3991  0805 b65e          	ld	a,_link_cnt
3992  0807 a134          	cp	a,#52
3993  0809 2402          	jruge	L1022
3996  080b 3c5e          	inc	_link_cnt
3997  080d               L1022:
3998                     ; 591 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4000  080d b65e          	ld	a,_link_cnt
4001  080f a131          	cp	a,#49
4002  0811 2606          	jrne	L3022
4005  0813 b60a          	ld	a,_flags
4006  0815 a4c1          	and	a,#193
4007  0817 b70a          	ld	_flags,a
4008  0819               L3022:
4009                     ; 592 	if(link_cnt==50)
4011  0819 b65e          	ld	a,_link_cnt
4012  081b a132          	cp	a,#50
4013  081d 262e          	jrne	L5122
4014                     ; 594 		link=OFF;
4016  081f 35aa005f      	mov	_link,#170
4017                     ; 599 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4019  0823 b601          	ld	a,_bps_class
4020  0825 a101          	cp	a,#1
4021  0827 2606          	jrne	L7022
4024  0829 72100001      	bset	_bMAIN
4026  082d 2004          	jra	L1122
4027  082f               L7022:
4028                     ; 600 		else bMAIN=0;
4030  082f 72110001      	bres	_bMAIN
4031  0833               L1122:
4032                     ; 602 		cnt_net_drv=0;
4034  0833 3f2f          	clr	_cnt_net_drv
4035                     ; 603     		if(!res_fl_)
4037  0835 725d0008      	tnz	_res_fl_
4038  0839 2612          	jrne	L5122
4039                     ; 605 	    		bRES_=1;
4041  083b 35010010      	mov	_bRES_,#1
4042                     ; 606 	    		res_fl_=1;
4044  083f a601          	ld	a,#1
4045  0841 ae0008        	ldw	x,#_res_fl_
4046  0844 cd0000        	call	c_eewrc
4048  0847 2004          	jra	L5122
4049  0849               L7712:
4050                     ; 610 else link=OFF;	
4052  0849 35aa005f      	mov	_link,#170
4053  084d               L5122:
4054                     ; 611 } 
4057  084d 81            	ret
4126                     .const:	section	.text
4127  0000               L05:
4128  0000 0000000b      	dc.l	11
4129  0004               L25:
4130  0004 00000001      	dc.l	1
4131                     ; 615 void vent_drv(void)
4131                     ; 616 {
4132                     	switch	.text
4133  084e               _vent_drv:
4135  084e 520e          	subw	sp,#14
4136       0000000e      OFST:	set	14
4139                     ; 619 	short vent_pwm_i_necc=400;
4141  0850 ae0190        	ldw	x,#400
4142  0853 1f07          	ldw	(OFST-7,sp),x
4143                     ; 620 	short vent_pwm_t_necc=400;
4145  0855 ae0190        	ldw	x,#400
4146  0858 1f09          	ldw	(OFST-5,sp),x
4147                     ; 621 	short vent_pwm_max_necc=400;
4149                     ; 626 	tempSL=36000L/(signed long)ee_Umax;
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
4170                     ; 627 	tempSL=(signed long)I/tempSL;
4172  087f be6b          	ldw	x,_I
4173  0881 cd0000        	call	c_itolx
4175  0884 96            	ldw	x,sp
4176  0885 1c000b        	addw	x,#OFST-3
4177  0888 cd0000        	call	c_ldiv
4179  088b 96            	ldw	x,sp
4180  088c 1c000b        	addw	x,#OFST-3
4181  088f cd0000        	call	c_rtol
4183                     ; 629 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4185  0892 ce0002        	ldw	x,_ee_DEVICE
4186  0895 a30001        	cpw	x,#1
4187  0898 2613          	jrne	L1522
4190  089a be6b          	ldw	x,_I
4191  089c 90ce0000      	ldw	y,_ee_IMAXVENT
4192  08a0 cd0000        	call	c_idiv
4194  08a3 cd0000        	call	c_itolx
4196  08a6 96            	ldw	x,sp
4197  08a7 1c000b        	addw	x,#OFST-3
4198  08aa cd0000        	call	c_rtol
4200  08ad               L1522:
4201                     ; 631 	if(tempSL>10)vent_pwm_i_necc=1000;
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
4219                     ; 632 	else if(tempSL<1)vent_pwm_i_necc=400;
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
4237                     ; 633 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4239  08db 1e0d          	ldw	x,(OFST-1,sp)
4240  08dd 90ae003c      	ldw	y,#60
4241  08e1 cd0000        	call	c_imul
4243  08e4 1c0190        	addw	x,#400
4244  08e7 1f07          	ldw	(OFST-7,sp),x
4245  08e9               L5522:
4246                     ; 634 	gran(&vent_pwm_i_necc,400,1000);
4248  08e9 ae03e8        	ldw	x,#1000
4249  08ec 89            	pushw	x
4250  08ed ae0190        	ldw	x,#400
4251  08f0 89            	pushw	x
4252  08f1 96            	ldw	x,sp
4253  08f2 1c000b        	addw	x,#OFST-3
4254  08f5 cd0000        	call	_gran
4256  08f8 5b04          	addw	sp,#4
4257                     ; 636 	tempSL=(signed long)T;
4259  08fa b664          	ld	a,_T
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
4271                     ; 637 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
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
4292                     ; 638 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
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
4310                     ; 639 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
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
4323                     ; 640 	gran(&vent_pwm_t_necc,400,1000);
4325  095b ae03e8        	ldw	x,#1000
4326  095e 89            	pushw	x
4327  095f ae0190        	ldw	x,#400
4328  0962 89            	pushw	x
4329  0963 96            	ldw	x,sp
4330  0964 1c000d        	addw	x,#OFST-1
4331  0967 cd0000        	call	_gran
4333  096a 5b04          	addw	sp,#4
4334                     ; 642 	vent_pwm_max_necc=vent_pwm_i_necc;
4336  096c 1e07          	ldw	x,(OFST-7,sp)
4337  096e 1f05          	ldw	(OFST-9,sp),x
4338                     ; 643 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4340  0970 9c            	rvf
4341  0971 1e09          	ldw	x,(OFST-5,sp)
4342  0973 1307          	cpw	x,(OFST-7,sp)
4343  0975 2d04          	jrsle	L3722
4346  0977 1e09          	ldw	x,(OFST-5,sp)
4347  0979 1f05          	ldw	(OFST-9,sp),x
4348  097b               L3722:
4349                     ; 645 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4351  097b 9c            	rvf
4352  097c be02          	ldw	x,_vent_pwm
4353  097e 1305          	cpw	x,(OFST-9,sp)
4354  0980 2e07          	jrsge	L5722
4357  0982 be02          	ldw	x,_vent_pwm
4358  0984 1c000a        	addw	x,#10
4359  0987 bf02          	ldw	_vent_pwm,x
4360  0989               L5722:
4361                     ; 646 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4363  0989 9c            	rvf
4364  098a be02          	ldw	x,_vent_pwm
4365  098c 1305          	cpw	x,(OFST-9,sp)
4366  098e 2d07          	jrsle	L7722
4369  0990 be02          	ldw	x,_vent_pwm
4370  0992 1d000a        	subw	x,#10
4371  0995 bf02          	ldw	_vent_pwm,x
4372  0997               L7722:
4373                     ; 647 	gran(&vent_pwm,400,1000);
4375  0997 ae03e8        	ldw	x,#1000
4376  099a 89            	pushw	x
4377  099b ae0190        	ldw	x,#400
4378  099e 89            	pushw	x
4379  099f ae0002        	ldw	x,#_vent_pwm
4380  09a2 cd0000        	call	_gran
4382  09a5 5b04          	addw	sp,#4
4383                     ; 649 }
4386  09a7 5b0e          	addw	sp,#14
4387  09a9 81            	ret
4421                     ; 654 void pwr_drv(void)
4421                     ; 655 {
4422                     	switch	.text
4423  09aa               _pwr_drv:
4427                     ; 659 BLOCK_INIT
4429  09aa 72145007      	bset	20487,#2
4432  09ae 72145008      	bset	20488,#2
4435  09b2 72155009      	bres	20489,#2
4436                     ; 661 if(main_cnt1<1500)main_cnt1++;
4438  09b6 9c            	rvf
4439  09b7 be4c          	ldw	x,_main_cnt1
4440  09b9 a305dc        	cpw	x,#1500
4441  09bc 2e07          	jrsge	L1132
4444  09be be4c          	ldw	x,_main_cnt1
4445  09c0 1c0001        	addw	x,#1
4446  09c3 bf4c          	ldw	_main_cnt1,x
4447  09c5               L1132:
4448                     ; 663 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4450  09c5 9c            	rvf
4451  09c6 ce0014        	ldw	x,_ee_TZAS
4452  09c9 90ae0005      	ldw	y,#5
4453  09cd cd0000        	call	c_imul
4455  09d0 b34c          	cpw	x,_main_cnt1
4456  09d2 2d0d          	jrsle	L3132
4458  09d4 b601          	ld	a,_bps_class
4459  09d6 a101          	cp	a,#1
4460  09d8 2707          	jreq	L3132
4461                     ; 665 	BLOCK_ON
4463  09da 72145005      	bset	20485,#2
4465  09de cc0a67        	jra	L5132
4466  09e1               L3132:
4467                     ; 668 else if(bps_class==bpsIPS)
4469  09e1 b601          	ld	a,_bps_class
4470  09e3 a101          	cp	a,#1
4471  09e5 261a          	jrne	L7132
4472                     ; 671 		if(bBL_IPS)
4474                     	btst	_bBL_IPS
4475  09ec 2406          	jruge	L1232
4476                     ; 673 			 BLOCK_ON
4478  09ee 72145005      	bset	20485,#2
4480  09f2 2073          	jra	L5132
4481  09f4               L1232:
4482                     ; 676 		else if(!bBL_IPS)
4484                     	btst	_bBL_IPS
4485  09f9 256c          	jrult	L5132
4486                     ; 678 			  BLOCK_OFF
4488  09fb 72155005      	bres	20485,#2
4489  09ff 2066          	jra	L5132
4490  0a01               L7132:
4491                     ; 682 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4493  0a01 9c            	rvf
4494  0a02 ce0014        	ldw	x,_ee_TZAS
4495  0a05 90ae0005      	ldw	y,#5
4496  0a09 cd0000        	call	c_imul
4498  0a0c b34c          	cpw	x,_main_cnt1
4499  0a0e 2e3f          	jrsge	L1332
4501  0a10 9c            	rvf
4502  0a11 ce0014        	ldw	x,_ee_TZAS
4503  0a14 90ae0005      	ldw	y,#5
4504  0a18 cd0000        	call	c_imul
4506  0a1b 1c0046        	addw	x,#70
4507  0a1e b34c          	cpw	x,_main_cnt1
4508  0a20 2d2d          	jrsle	L1332
4509                     ; 684 	if(bps_class==bpsIPS)
4511  0a22 b601          	ld	a,_bps_class
4512  0a24 a101          	cp	a,#1
4513  0a26 2606          	jrne	L3332
4514                     ; 686 		  BLOCK_OFF
4516  0a28 72155005      	bres	20485,#2
4518  0a2c 2039          	jra	L5132
4519  0a2e               L3332:
4520                     ; 689 	else if(bps_class==bpsIBEP)
4522  0a2e 3d01          	tnz	_bps_class
4523  0a30 2635          	jrne	L5132
4524                     ; 691 		if(ee_DEVICE)
4526  0a32 ce0002        	ldw	x,_ee_DEVICE
4527  0a35 2712          	jreq	L1432
4528                     ; 693 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4530  0a37 b60a          	ld	a,_flags
4531  0a39 a520          	bcp	a,#32
4532  0a3b 2706          	jreq	L3432
4535  0a3d 72145005      	bset	20485,#2
4537  0a41 2024          	jra	L5132
4538  0a43               L3432:
4539                     ; 694 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4541  0a43 72155005      	bres	20485,#2
4542  0a47 201e          	jra	L5132
4543  0a49               L1432:
4544                     ; 698 			BLOCK_OFF
4546  0a49 72155005      	bres	20485,#2
4547  0a4d 2018          	jra	L5132
4548  0a4f               L1332:
4549                     ; 703 else if(bBL)
4551                     	btst	_bBL
4552  0a54 2406          	jruge	L3532
4553                     ; 705 	BLOCK_ON
4555  0a56 72145005      	bset	20485,#2
4557  0a5a 200b          	jra	L5132
4558  0a5c               L3532:
4559                     ; 708 else if(!bBL)
4561                     	btst	_bBL
4562  0a61 2504          	jrult	L5132
4563                     ; 710 	BLOCK_OFF
4565  0a63 72155005      	bres	20485,#2
4566  0a67               L5132:
4567                     ; 714 gran(&pwm_u,2,1020);
4569  0a67 ae03fc        	ldw	x,#1020
4570  0a6a 89            	pushw	x
4571  0a6b ae0002        	ldw	x,#2
4572  0a6e 89            	pushw	x
4573  0a6f ae000b        	ldw	x,#_pwm_u
4574  0a72 cd0000        	call	_gran
4576  0a75 5b04          	addw	sp,#4
4577                     ; 724 TIM1->CCR2H= (char)(pwm_u/256);	
4579  0a77 be0b          	ldw	x,_pwm_u
4580  0a79 90ae0100      	ldw	y,#256
4581  0a7d cd0000        	call	c_idiv
4583  0a80 9f            	ld	a,xl
4584  0a81 c75267        	ld	21095,a
4585                     ; 725 TIM1->CCR2L= (char)pwm_u;
4587  0a84 55000c5268    	mov	21096,_pwm_u+1
4588                     ; 727 TIM1->CCR1H= (char)(pwm_i/256);	
4590  0a89 be0d          	ldw	x,_pwm_i
4591  0a8b 90ae0100      	ldw	y,#256
4592  0a8f cd0000        	call	c_idiv
4594  0a92 9f            	ld	a,xl
4595  0a93 c75265        	ld	21093,a
4596                     ; 728 TIM1->CCR1L= (char)pwm_i;
4598  0a96 55000e5266    	mov	21094,_pwm_i+1
4599                     ; 730 TIM1->CCR3H= (char)(vent_pwm/256);	
4601  0a9b be02          	ldw	x,_vent_pwm
4602  0a9d 90ae0100      	ldw	y,#256
4603  0aa1 cd0000        	call	c_idiv
4605  0aa4 9f            	ld	a,xl
4606  0aa5 c75269        	ld	21097,a
4607                     ; 731 TIM1->CCR3L= (char)vent_pwm;
4609  0aa8 550003526a    	mov	21098,_vent_pwm+1
4610                     ; 732 }
4613  0aad 81            	ret
4651                     ; 737 void pwr_hndl(void)				
4651                     ; 738 {
4652                     	switch	.text
4653  0aae               _pwr_hndl:
4657                     ; 739 if(jp_mode==jp3)
4659  0aae b647          	ld	a,_jp_mode
4660  0ab0 a103          	cp	a,#3
4661  0ab2 2627          	jrne	L1732
4662                     ; 741 	if((flags&0b00001010)==0)
4664  0ab4 b60a          	ld	a,_flags
4665  0ab6 a50a          	bcp	a,#10
4666  0ab8 260d          	jrne	L3732
4667                     ; 743 		pwm_u=500;
4669  0aba ae01f4        	ldw	x,#500
4670  0abd bf0b          	ldw	_pwm_u,x
4671                     ; 745 		bBL=0;
4673  0abf 72110003      	bres	_bBL
4675  0ac3 acc90bc9      	jpf	L1042
4676  0ac7               L3732:
4677                     ; 747 	else if(flags&0b00001010)
4679  0ac7 b60a          	ld	a,_flags
4680  0ac9 a50a          	bcp	a,#10
4681  0acb 2603          	jrne	L06
4682  0acd cc0bc9        	jp	L1042
4683  0ad0               L06:
4684                     ; 749 		pwm_u=0;
4686  0ad0 5f            	clrw	x
4687  0ad1 bf0b          	ldw	_pwm_u,x
4688                     ; 751 		bBL=1;
4690  0ad3 72100003      	bset	_bBL
4691  0ad7 acc90bc9      	jpf	L1042
4692  0adb               L1732:
4693                     ; 755 else if(jp_mode==jp2)
4695  0adb b647          	ld	a,_jp_mode
4696  0add a102          	cp	a,#2
4697  0adf 2610          	jrne	L3042
4698                     ; 757 	pwm_u=0;
4700  0ae1 5f            	clrw	x
4701  0ae2 bf0b          	ldw	_pwm_u,x
4702                     ; 758 	pwm_i=0x3ff;
4704  0ae4 ae03ff        	ldw	x,#1023
4705  0ae7 bf0d          	ldw	_pwm_i,x
4706                     ; 759 	bBL=0;
4708  0ae9 72110003      	bres	_bBL
4710  0aed acc90bc9      	jpf	L1042
4711  0af1               L3042:
4712                     ; 761 else if(jp_mode==jp1)
4714  0af1 b647          	ld	a,_jp_mode
4715  0af3 a101          	cp	a,#1
4716  0af5 2612          	jrne	L7042
4717                     ; 763 	pwm_u=0x3ff;
4719  0af7 ae03ff        	ldw	x,#1023
4720  0afa bf0b          	ldw	_pwm_u,x
4721                     ; 764 	pwm_i=0x3ff;
4723  0afc ae03ff        	ldw	x,#1023
4724  0aff bf0d          	ldw	_pwm_i,x
4725                     ; 765 	bBL=0;
4727  0b01 72110003      	bres	_bBL
4729  0b05 acc90bc9      	jpf	L1042
4730  0b09               L7042:
4731                     ; 768 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4733                     	btst	_bMAIN
4734  0b0e 2417          	jruge	L3142
4736  0b10 b65f          	ld	a,_link
4737  0b12 a155          	cp	a,#85
4738  0b14 2611          	jrne	L3142
4739                     ; 770 	pwm_u=volum_u_main_;
4741  0b16 be1c          	ldw	x,_volum_u_main_
4742  0b18 bf0b          	ldw	_pwm_u,x
4743                     ; 771 	pwm_i=0x3ff;
4745  0b1a ae03ff        	ldw	x,#1023
4746  0b1d bf0d          	ldw	_pwm_i,x
4747                     ; 772 	bBL_IPS=0;
4749  0b1f 72110000      	bres	_bBL_IPS
4751  0b23 acc90bc9      	jpf	L1042
4752  0b27               L3142:
4753                     ; 775 else if(link==OFF)
4755  0b27 b65f          	ld	a,_link
4756  0b29 a1aa          	cp	a,#170
4757  0b2b 2650          	jrne	L7142
4758                     ; 784  	if(ee_DEVICE)
4760  0b2d ce0002        	ldw	x,_ee_DEVICE
4761  0b30 270d          	jreq	L1242
4762                     ; 786 		pwm_u=0x00;
4764  0b32 5f            	clrw	x
4765  0b33 bf0b          	ldw	_pwm_u,x
4766                     ; 787 		pwm_i=0x00;
4768  0b35 5f            	clrw	x
4769  0b36 bf0d          	ldw	_pwm_i,x
4770                     ; 788 		bBL=1;
4772  0b38 72100003      	bset	_bBL
4774  0b3c cc0bc9        	jra	L1042
4775  0b3f               L1242:
4776                     ; 792 		if((flags&0b00011010)==0)
4778  0b3f b60a          	ld	a,_flags
4779  0b41 a51a          	bcp	a,#26
4780  0b43 2622          	jrne	L5242
4781                     ; 794 			pwm_u=ee_U_AVT;
4783  0b45 ce000a        	ldw	x,_ee_U_AVT
4784  0b48 bf0b          	ldw	_pwm_u,x
4785                     ; 795 			gran(&pwm_u,0,1020);
4787  0b4a ae03fc        	ldw	x,#1020
4788  0b4d 89            	pushw	x
4789  0b4e 5f            	clrw	x
4790  0b4f 89            	pushw	x
4791  0b50 ae000b        	ldw	x,#_pwm_u
4792  0b53 cd0000        	call	_gran
4794  0b56 5b04          	addw	sp,#4
4795                     ; 796 		    	pwm_i=0x3ff;
4797  0b58 ae03ff        	ldw	x,#1023
4798  0b5b bf0d          	ldw	_pwm_i,x
4799                     ; 797 			bBL=0;
4801  0b5d 72110003      	bres	_bBL
4802                     ; 798 			bBL_IPS=0;
4804  0b61 72110000      	bres	_bBL_IPS
4806  0b65 2062          	jra	L1042
4807  0b67               L5242:
4808                     ; 800 		else if(flags&0b00011010)
4810  0b67 b60a          	ld	a,_flags
4811  0b69 a51a          	bcp	a,#26
4812  0b6b 275c          	jreq	L1042
4813                     ; 802 			pwm_u=0;
4815  0b6d 5f            	clrw	x
4816  0b6e bf0b          	ldw	_pwm_u,x
4817                     ; 803 			pwm_i=0;
4819  0b70 5f            	clrw	x
4820  0b71 bf0d          	ldw	_pwm_i,x
4821                     ; 804 			bBL=1;
4823  0b73 72100003      	bset	_bBL
4824                     ; 805 			bBL_IPS=1;
4826  0b77 72100000      	bset	_bBL_IPS
4827  0b7b 204c          	jra	L1042
4828  0b7d               L7142:
4829                     ; 814 else	if(link==ON)				//если есть связь
4831  0b7d b65f          	ld	a,_link
4832  0b7f a155          	cp	a,#85
4833  0b81 2646          	jrne	L1042
4834                     ; 816 	if((flags&0b00100000)==0)	//если нет блокировки извне
4836  0b83 b60a          	ld	a,_flags
4837  0b85 a520          	bcp	a,#32
4838  0b87 2630          	jrne	L7342
4839                     ; 818 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4841  0b89 b60a          	ld	a,_flags
4842  0b8b a51a          	bcp	a,#26
4843  0b8d 2706          	jreq	L3442
4845  0b8f b60a          	ld	a,_flags
4846  0b91 a540          	bcp	a,#64
4847  0b93 2712          	jreq	L1442
4848  0b95               L3442:
4849                     ; 820 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4851  0b95 be5b          	ldw	x,__x_
4852  0b97 72bb0055      	addw	x,_vol_u_temp
4853  0b9b bf0b          	ldw	_pwm_u,x
4854                     ; 821 		    	pwm_i=vol_i_temp;
4856  0b9d be53          	ldw	x,_vol_i_temp
4857  0b9f bf0d          	ldw	_pwm_i,x
4858                     ; 822 			bBL=0;
4860  0ba1 72110003      	bres	_bBL
4862  0ba5 2022          	jra	L1042
4863  0ba7               L1442:
4864                     ; 824 		else if(flags&0b00011010)					//если есть аварии
4866  0ba7 b60a          	ld	a,_flags
4867  0ba9 a51a          	bcp	a,#26
4868  0bab 271c          	jreq	L1042
4869                     ; 826 			pwm_u=0;								//то полный стоп
4871  0bad 5f            	clrw	x
4872  0bae bf0b          	ldw	_pwm_u,x
4873                     ; 827 			pwm_i=0;
4875  0bb0 5f            	clrw	x
4876  0bb1 bf0d          	ldw	_pwm_i,x
4877                     ; 828 			bBL=1;
4879  0bb3 72100003      	bset	_bBL
4880  0bb7 2010          	jra	L1042
4881  0bb9               L7342:
4882                     ; 831 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4884  0bb9 b60a          	ld	a,_flags
4885  0bbb a520          	bcp	a,#32
4886  0bbd 270a          	jreq	L1042
4887                     ; 833 		pwm_u=0;
4889  0bbf 5f            	clrw	x
4890  0bc0 bf0b          	ldw	_pwm_u,x
4891                     ; 834 	    	pwm_i=0;
4893  0bc2 5f            	clrw	x
4894  0bc3 bf0d          	ldw	_pwm_i,x
4895                     ; 835 		bBL=1;
4897  0bc5 72100003      	bset	_bBL
4898  0bc9               L1042:
4899                     ; 841 }
4902  0bc9 81            	ret
4944                     	switch	.const
4945  0008               L46:
4946  0008 00000258      	dc.l	600
4947  000c               L66:
4948  000c 00000708      	dc.l	1800
4949  0010               L07:
4950  0010 000003e8      	dc.l	1000
4951                     ; 844 void matemat(void)
4951                     ; 845 {
4952                     	switch	.text
4953  0bca               _matemat:
4955  0bca 5204          	subw	sp,#4
4956       00000004      OFST:	set	4
4959                     ; 866 temp_SL=adc_buff_[4];
4961  0bcc ce000d        	ldw	x,_adc_buff_+8
4962  0bcf cd0000        	call	c_itolx
4964  0bd2 96            	ldw	x,sp
4965  0bd3 1c0001        	addw	x,#OFST-3
4966  0bd6 cd0000        	call	c_rtol
4968                     ; 867 temp_SL-=ee_K[0][0];
4970  0bd9 ce0018        	ldw	x,_ee_K
4971  0bdc cd0000        	call	c_itolx
4973  0bdf 96            	ldw	x,sp
4974  0be0 1c0001        	addw	x,#OFST-3
4975  0be3 cd0000        	call	c_lgsub
4977                     ; 868 if(temp_SL<0) temp_SL=0;
4979  0be6 9c            	rvf
4980  0be7 0d01          	tnz	(OFST-3,sp)
4981  0be9 2e0a          	jrsge	L3742
4984  0beb ae0000        	ldw	x,#0
4985  0bee 1f03          	ldw	(OFST-1,sp),x
4986  0bf0 ae0000        	ldw	x,#0
4987  0bf3 1f01          	ldw	(OFST-3,sp),x
4988  0bf5               L3742:
4989                     ; 869 temp_SL*=ee_K[0][1];
4991  0bf5 ce001a        	ldw	x,_ee_K+2
4992  0bf8 cd0000        	call	c_itolx
4994  0bfb 96            	ldw	x,sp
4995  0bfc 1c0001        	addw	x,#OFST-3
4996  0bff cd0000        	call	c_lgmul
4998                     ; 870 temp_SL/=600;
5000  0c02 96            	ldw	x,sp
5001  0c03 1c0001        	addw	x,#OFST-3
5002  0c06 cd0000        	call	c_ltor
5004  0c09 ae0008        	ldw	x,#L46
5005  0c0c cd0000        	call	c_ldiv
5007  0c0f 96            	ldw	x,sp
5008  0c10 1c0001        	addw	x,#OFST-3
5009  0c13 cd0000        	call	c_rtol
5011                     ; 871 I=(signed short)temp_SL;
5013  0c16 1e03          	ldw	x,(OFST-1,sp)
5014  0c18 bf6b          	ldw	_I,x
5015                     ; 876 temp_SL=(signed long)adc_buff_[1];
5017  0c1a ce0007        	ldw	x,_adc_buff_+2
5018  0c1d cd0000        	call	c_itolx
5020  0c20 96            	ldw	x,sp
5021  0c21 1c0001        	addw	x,#OFST-3
5022  0c24 cd0000        	call	c_rtol
5024                     ; 878 if(temp_SL<0) temp_SL=0;
5026  0c27 9c            	rvf
5027  0c28 0d01          	tnz	(OFST-3,sp)
5028  0c2a 2e0a          	jrsge	L5742
5031  0c2c ae0000        	ldw	x,#0
5032  0c2f 1f03          	ldw	(OFST-1,sp),x
5033  0c31 ae0000        	ldw	x,#0
5034  0c34 1f01          	ldw	(OFST-3,sp),x
5035  0c36               L5742:
5036                     ; 879 temp_SL*=(signed long)ee_K[2][1];
5038  0c36 ce0022        	ldw	x,_ee_K+10
5039  0c39 cd0000        	call	c_itolx
5041  0c3c 96            	ldw	x,sp
5042  0c3d 1c0001        	addw	x,#OFST-3
5043  0c40 cd0000        	call	c_lgmul
5045                     ; 880 temp_SL/=1800L;
5047  0c43 96            	ldw	x,sp
5048  0c44 1c0001        	addw	x,#OFST-3
5049  0c47 cd0000        	call	c_ltor
5051  0c4a ae000c        	ldw	x,#L66
5052  0c4d cd0000        	call	c_ldiv
5054  0c50 96            	ldw	x,sp
5055  0c51 1c0001        	addw	x,#OFST-3
5056  0c54 cd0000        	call	c_rtol
5058                     ; 881 Ui=(unsigned short)temp_SL;
5060  0c57 1e03          	ldw	x,(OFST-1,sp)
5061  0c59 bf67          	ldw	_Ui,x
5062                     ; 888 temp_SL=adc_buff_[3];
5064  0c5b ce000b        	ldw	x,_adc_buff_+6
5065  0c5e cd0000        	call	c_itolx
5067  0c61 96            	ldw	x,sp
5068  0c62 1c0001        	addw	x,#OFST-3
5069  0c65 cd0000        	call	c_rtol
5071                     ; 890 if(temp_SL<0) temp_SL=0;
5073  0c68 9c            	rvf
5074  0c69 0d01          	tnz	(OFST-3,sp)
5075  0c6b 2e0a          	jrsge	L7742
5078  0c6d ae0000        	ldw	x,#0
5079  0c70 1f03          	ldw	(OFST-1,sp),x
5080  0c72 ae0000        	ldw	x,#0
5081  0c75 1f01          	ldw	(OFST-3,sp),x
5082  0c77               L7742:
5083                     ; 891 temp_SL*=ee_K[1][1];
5085  0c77 ce001e        	ldw	x,_ee_K+6
5086  0c7a cd0000        	call	c_itolx
5088  0c7d 96            	ldw	x,sp
5089  0c7e 1c0001        	addw	x,#OFST-3
5090  0c81 cd0000        	call	c_lgmul
5092                     ; 892 temp_SL/=1800;
5094  0c84 96            	ldw	x,sp
5095  0c85 1c0001        	addw	x,#OFST-3
5096  0c88 cd0000        	call	c_ltor
5098  0c8b ae000c        	ldw	x,#L66
5099  0c8e cd0000        	call	c_ldiv
5101  0c91 96            	ldw	x,sp
5102  0c92 1c0001        	addw	x,#OFST-3
5103  0c95 cd0000        	call	c_rtol
5105                     ; 893 Un=(unsigned short)temp_SL;
5107  0c98 1e03          	ldw	x,(OFST-1,sp)
5108  0c9a bf69          	ldw	_Un,x
5109                     ; 896 temp_SL=adc_buff_[2];
5111  0c9c ce0009        	ldw	x,_adc_buff_+4
5112  0c9f cd0000        	call	c_itolx
5114  0ca2 96            	ldw	x,sp
5115  0ca3 1c0001        	addw	x,#OFST-3
5116  0ca6 cd0000        	call	c_rtol
5118                     ; 897 temp_SL*=ee_K[3][1];
5120  0ca9 ce0026        	ldw	x,_ee_K+14
5121  0cac cd0000        	call	c_itolx
5123  0caf 96            	ldw	x,sp
5124  0cb0 1c0001        	addw	x,#OFST-3
5125  0cb3 cd0000        	call	c_lgmul
5127                     ; 898 temp_SL/=1000;
5129  0cb6 96            	ldw	x,sp
5130  0cb7 1c0001        	addw	x,#OFST-3
5131  0cba cd0000        	call	c_ltor
5133  0cbd ae0010        	ldw	x,#L07
5134  0cc0 cd0000        	call	c_ldiv
5136  0cc3 96            	ldw	x,sp
5137  0cc4 1c0001        	addw	x,#OFST-3
5138  0cc7 cd0000        	call	c_rtol
5140                     ; 899 T=(char)(temp_SL-273L);
5142  0cca 7b04          	ld	a,(OFST+0,sp)
5143  0ccc a011          	sub	a,#17
5144  0cce b764          	ld	_T,a
5145                     ; 900 if(T<1)T=0;
5147  0cd0 9c            	rvf
5148  0cd1 b664          	ld	a,_T
5149  0cd3 a101          	cp	a,#1
5150  0cd5 2e02          	jrsge	L1052
5153  0cd7 3f64          	clr	_T
5154  0cd9               L1052:
5155                     ; 901 if(T>120)T=120;
5157  0cd9 9c            	rvf
5158  0cda b664          	ld	a,_T
5159  0cdc a179          	cp	a,#121
5160  0cde 2f04          	jrslt	L3052
5163  0ce0 35780064      	mov	_T,#120
5164  0ce4               L3052:
5165                     ; 904 Udb=flags;
5167  0ce4 b60a          	ld	a,_flags
5168  0ce6 5f            	clrw	x
5169  0ce7 97            	ld	xl,a
5170  0ce8 bf65          	ldw	_Udb,x
5171                     ; 910 }
5174  0cea 5b04          	addw	sp,#4
5175  0cec 81            	ret
5206                     ; 913 void temper_drv(void)		//1 Hz
5206                     ; 914 {
5207                     	switch	.text
5208  0ced               _temper_drv:
5212                     ; 916 if(T>ee_tsign) tsign_cnt++;
5214  0ced 9c            	rvf
5215  0cee 5f            	clrw	x
5216  0cef b664          	ld	a,_T
5217  0cf1 2a01          	jrpl	L47
5218  0cf3 53            	cplw	x
5219  0cf4               L47:
5220  0cf4 97            	ld	xl,a
5221  0cf5 c3000c        	cpw	x,_ee_tsign
5222  0cf8 2d09          	jrsle	L5152
5225  0cfa be4a          	ldw	x,_tsign_cnt
5226  0cfc 1c0001        	addw	x,#1
5227  0cff bf4a          	ldw	_tsign_cnt,x
5229  0d01 201d          	jra	L7152
5230  0d03               L5152:
5231                     ; 917 else if (T<(ee_tsign-1)) tsign_cnt--;
5233  0d03 9c            	rvf
5234  0d04 ce000c        	ldw	x,_ee_tsign
5235  0d07 5a            	decw	x
5236  0d08 905f          	clrw	y
5237  0d0a b664          	ld	a,_T
5238  0d0c 2a02          	jrpl	L67
5239  0d0e 9053          	cplw	y
5240  0d10               L67:
5241  0d10 9097          	ld	yl,a
5242  0d12 90bf00        	ldw	c_y,y
5243  0d15 b300          	cpw	x,c_y
5244  0d17 2d07          	jrsle	L7152
5247  0d19 be4a          	ldw	x,_tsign_cnt
5248  0d1b 1d0001        	subw	x,#1
5249  0d1e bf4a          	ldw	_tsign_cnt,x
5250  0d20               L7152:
5251                     ; 919 gran(&tsign_cnt,0,60);
5253  0d20 ae003c        	ldw	x,#60
5254  0d23 89            	pushw	x
5255  0d24 5f            	clrw	x
5256  0d25 89            	pushw	x
5257  0d26 ae004a        	ldw	x,#_tsign_cnt
5258  0d29 cd0000        	call	_gran
5260  0d2c 5b04          	addw	sp,#4
5261                     ; 921 if(tsign_cnt>=55)
5263  0d2e 9c            	rvf
5264  0d2f be4a          	ldw	x,_tsign_cnt
5265  0d31 a30037        	cpw	x,#55
5266  0d34 2f16          	jrslt	L3252
5267                     ; 923 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5269  0d36 3d47          	tnz	_jp_mode
5270  0d38 2606          	jrne	L1352
5272  0d3a b60a          	ld	a,_flags
5273  0d3c a540          	bcp	a,#64
5274  0d3e 2706          	jreq	L7252
5275  0d40               L1352:
5277  0d40 b647          	ld	a,_jp_mode
5278  0d42 a103          	cp	a,#3
5279  0d44 2612          	jrne	L3352
5280  0d46               L7252:
5283  0d46 7214000a      	bset	_flags,#2
5284  0d4a 200c          	jra	L3352
5285  0d4c               L3252:
5286                     ; 925 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5288  0d4c 9c            	rvf
5289  0d4d be4a          	ldw	x,_tsign_cnt
5290  0d4f a30006        	cpw	x,#6
5291  0d52 2e04          	jrsge	L3352
5294  0d54 7215000a      	bres	_flags,#2
5295  0d58               L3352:
5296                     ; 930 if(T>ee_tmax) tmax_cnt++;
5298  0d58 9c            	rvf
5299  0d59 5f            	clrw	x
5300  0d5a b664          	ld	a,_T
5301  0d5c 2a01          	jrpl	L001
5302  0d5e 53            	cplw	x
5303  0d5f               L001:
5304  0d5f 97            	ld	xl,a
5305  0d60 c3000e        	cpw	x,_ee_tmax
5306  0d63 2d09          	jrsle	L7352
5309  0d65 be48          	ldw	x,_tmax_cnt
5310  0d67 1c0001        	addw	x,#1
5311  0d6a bf48          	ldw	_tmax_cnt,x
5313  0d6c 201d          	jra	L1452
5314  0d6e               L7352:
5315                     ; 931 else if (T<(ee_tmax-1)) tmax_cnt--;
5317  0d6e 9c            	rvf
5318  0d6f ce000e        	ldw	x,_ee_tmax
5319  0d72 5a            	decw	x
5320  0d73 905f          	clrw	y
5321  0d75 b664          	ld	a,_T
5322  0d77 2a02          	jrpl	L201
5323  0d79 9053          	cplw	y
5324  0d7b               L201:
5325  0d7b 9097          	ld	yl,a
5326  0d7d 90bf00        	ldw	c_y,y
5327  0d80 b300          	cpw	x,c_y
5328  0d82 2d07          	jrsle	L1452
5331  0d84 be48          	ldw	x,_tmax_cnt
5332  0d86 1d0001        	subw	x,#1
5333  0d89 bf48          	ldw	_tmax_cnt,x
5334  0d8b               L1452:
5335                     ; 933 gran(&tmax_cnt,0,60);
5337  0d8b ae003c        	ldw	x,#60
5338  0d8e 89            	pushw	x
5339  0d8f 5f            	clrw	x
5340  0d90 89            	pushw	x
5341  0d91 ae0048        	ldw	x,#_tmax_cnt
5342  0d94 cd0000        	call	_gran
5344  0d97 5b04          	addw	sp,#4
5345                     ; 935 if(tmax_cnt>=55)
5347  0d99 9c            	rvf
5348  0d9a be48          	ldw	x,_tmax_cnt
5349  0d9c a30037        	cpw	x,#55
5350  0d9f 2f16          	jrslt	L5452
5351                     ; 937 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5353  0da1 3d47          	tnz	_jp_mode
5354  0da3 2606          	jrne	L3552
5356  0da5 b60a          	ld	a,_flags
5357  0da7 a540          	bcp	a,#64
5358  0da9 2706          	jreq	L1552
5359  0dab               L3552:
5361  0dab b647          	ld	a,_jp_mode
5362  0dad a103          	cp	a,#3
5363  0daf 2612          	jrne	L5552
5364  0db1               L1552:
5367  0db1 7212000a      	bset	_flags,#1
5368  0db5 200c          	jra	L5552
5369  0db7               L5452:
5370                     ; 939 else if (tmax_cnt<=5) flags&=0b11111101;
5372  0db7 9c            	rvf
5373  0db8 be48          	ldw	x,_tmax_cnt
5374  0dba a30006        	cpw	x,#6
5375  0dbd 2e04          	jrsge	L5552
5378  0dbf 7213000a      	bres	_flags,#1
5379  0dc3               L5552:
5380                     ; 942 } 
5383  0dc3 81            	ret
5413                     ; 945 void u_drv(void)		//1Hz
5413                     ; 946 { 
5414                     	switch	.text
5415  0dc4               _u_drv:
5419                     ; 947 if(jp_mode!=jp3)
5421  0dc4 b647          	ld	a,_jp_mode
5422  0dc6 a103          	cp	a,#3
5423  0dc8 2730          	jreq	L1752
5424                     ; 949 	if(Ui>ee_Umax)umax_cnt++;
5426  0dca 9c            	rvf
5427  0dcb be67          	ldw	x,_Ui
5428  0dcd c30012        	cpw	x,_ee_Umax
5429  0dd0 2d09          	jrsle	L3752
5432  0dd2 be62          	ldw	x,_umax_cnt
5433  0dd4 1c0001        	addw	x,#1
5434  0dd7 bf62          	ldw	_umax_cnt,x
5436  0dd9 2003          	jra	L5752
5437  0ddb               L3752:
5438                     ; 950 	else umax_cnt=0;
5440  0ddb 5f            	clrw	x
5441  0ddc bf62          	ldw	_umax_cnt,x
5442  0dde               L5752:
5443                     ; 951 	gran(&umax_cnt,0,10);
5445  0dde ae000a        	ldw	x,#10
5446  0de1 89            	pushw	x
5447  0de2 5f            	clrw	x
5448  0de3 89            	pushw	x
5449  0de4 ae0062        	ldw	x,#_umax_cnt
5450  0de7 cd0000        	call	_gran
5452  0dea 5b04          	addw	sp,#4
5453                     ; 952 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5455  0dec 9c            	rvf
5456  0ded be62          	ldw	x,_umax_cnt
5457  0def a3000a        	cpw	x,#10
5458  0df2 2f6f          	jrslt	L1062
5461  0df4 7216000a      	bset	_flags,#3
5462  0df8 2069          	jra	L1062
5463  0dfa               L1752:
5464                     ; 960 else if(jp_mode==jp3)
5466  0dfa b647          	ld	a,_jp_mode
5467  0dfc a103          	cp	a,#3
5468  0dfe 2663          	jrne	L1062
5469                     ; 962 	if(Ui>700)umax_cnt++;
5471  0e00 9c            	rvf
5472  0e01 be67          	ldw	x,_Ui
5473  0e03 a302bd        	cpw	x,#701
5474  0e06 2f09          	jrslt	L5062
5477  0e08 be62          	ldw	x,_umax_cnt
5478  0e0a 1c0001        	addw	x,#1
5479  0e0d bf62          	ldw	_umax_cnt,x
5481  0e0f 2003          	jra	L7062
5482  0e11               L5062:
5483                     ; 963 	else umax_cnt=0;
5485  0e11 5f            	clrw	x
5486  0e12 bf62          	ldw	_umax_cnt,x
5487  0e14               L7062:
5488                     ; 964 	gran(&umax_cnt,0,10);
5490  0e14 ae000a        	ldw	x,#10
5491  0e17 89            	pushw	x
5492  0e18 5f            	clrw	x
5493  0e19 89            	pushw	x
5494  0e1a ae0062        	ldw	x,#_umax_cnt
5495  0e1d cd0000        	call	_gran
5497  0e20 5b04          	addw	sp,#4
5498                     ; 965 	if(umax_cnt>=10)flags|=0b00001000;
5500  0e22 9c            	rvf
5501  0e23 be62          	ldw	x,_umax_cnt
5502  0e25 a3000a        	cpw	x,#10
5503  0e28 2f04          	jrslt	L1162
5506  0e2a 7216000a      	bset	_flags,#3
5507  0e2e               L1162:
5508                     ; 968 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5510  0e2e 9c            	rvf
5511  0e2f be67          	ldw	x,_Ui
5512  0e31 a300c8        	cpw	x,#200
5513  0e34 2e10          	jrsge	L3162
5515  0e36 c65005        	ld	a,20485
5516  0e39 a504          	bcp	a,#4
5517  0e3b 2609          	jrne	L3162
5520  0e3d be60          	ldw	x,_umin_cnt
5521  0e3f 1c0001        	addw	x,#1
5522  0e42 bf60          	ldw	_umin_cnt,x
5524  0e44 2003          	jra	L5162
5525  0e46               L3162:
5526                     ; 969 	else umin_cnt=0;
5528  0e46 5f            	clrw	x
5529  0e47 bf60          	ldw	_umin_cnt,x
5530  0e49               L5162:
5531                     ; 970 	gran(&umin_cnt,0,10);	
5533  0e49 ae000a        	ldw	x,#10
5534  0e4c 89            	pushw	x
5535  0e4d 5f            	clrw	x
5536  0e4e 89            	pushw	x
5537  0e4f ae0060        	ldw	x,#_umin_cnt
5538  0e52 cd0000        	call	_gran
5540  0e55 5b04          	addw	sp,#4
5541                     ; 971 	if(umin_cnt>=10)flags|=0b00010000;	  
5543  0e57 9c            	rvf
5544  0e58 be60          	ldw	x,_umin_cnt
5545  0e5a a3000a        	cpw	x,#10
5546  0e5d 2f04          	jrslt	L1062
5549  0e5f 7218000a      	bset	_flags,#4
5550  0e63               L1062:
5551                     ; 973 }
5554  0e63 81            	ret
5581                     ; 976 void x_drv(void)
5581                     ; 977 {
5582                     	switch	.text
5583  0e64               _x_drv:
5587                     ; 978 if(_x__==_x_)
5589  0e64 be59          	ldw	x,__x__
5590  0e66 b35b          	cpw	x,__x_
5591  0e68 262a          	jrne	L1362
5592                     ; 980 	if(_x_cnt<60)
5594  0e6a 9c            	rvf
5595  0e6b be57          	ldw	x,__x_cnt
5596  0e6d a3003c        	cpw	x,#60
5597  0e70 2e25          	jrsge	L1462
5598                     ; 982 		_x_cnt++;
5600  0e72 be57          	ldw	x,__x_cnt
5601  0e74 1c0001        	addw	x,#1
5602  0e77 bf57          	ldw	__x_cnt,x
5603                     ; 983 		if(_x_cnt>=60)
5605  0e79 9c            	rvf
5606  0e7a be57          	ldw	x,__x_cnt
5607  0e7c a3003c        	cpw	x,#60
5608  0e7f 2f16          	jrslt	L1462
5609                     ; 985 			if(_x_ee_!=_x_)_x_ee_=_x_;
5611  0e81 ce0016        	ldw	x,__x_ee_
5612  0e84 b35b          	cpw	x,__x_
5613  0e86 270f          	jreq	L1462
5616  0e88 be5b          	ldw	x,__x_
5617  0e8a 89            	pushw	x
5618  0e8b ae0016        	ldw	x,#__x_ee_
5619  0e8e cd0000        	call	c_eewrw
5621  0e91 85            	popw	x
5622  0e92 2003          	jra	L1462
5623  0e94               L1362:
5624                     ; 990 else _x_cnt=0;
5626  0e94 5f            	clrw	x
5627  0e95 bf57          	ldw	__x_cnt,x
5628  0e97               L1462:
5629                     ; 992 if(_x_cnt>60) _x_cnt=0;	
5631  0e97 9c            	rvf
5632  0e98 be57          	ldw	x,__x_cnt
5633  0e9a a3003d        	cpw	x,#61
5634  0e9d 2f03          	jrslt	L3462
5637  0e9f 5f            	clrw	x
5638  0ea0 bf57          	ldw	__x_cnt,x
5639  0ea2               L3462:
5640                     ; 994 _x__=_x_;
5642  0ea2 be5b          	ldw	x,__x_
5643  0ea4 bf59          	ldw	__x__,x
5644                     ; 995 }
5647  0ea6 81            	ret
5673                     ; 998 void apv_start(void)
5673                     ; 999 {
5674                     	switch	.text
5675  0ea7               _apv_start:
5679                     ; 1000 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5681  0ea7 3d42          	tnz	_apv_cnt
5682  0ea9 2624          	jrne	L5562
5684  0eab 3d43          	tnz	_apv_cnt+1
5685  0ead 2620          	jrne	L5562
5687  0eaf 3d44          	tnz	_apv_cnt+2
5688  0eb1 261c          	jrne	L5562
5690                     	btst	_bAPV
5691  0eb8 2515          	jrult	L5562
5692                     ; 1002 	apv_cnt[0]=60;
5694  0eba 353c0042      	mov	_apv_cnt,#60
5695                     ; 1003 	apv_cnt[1]=60;
5697  0ebe 353c0043      	mov	_apv_cnt+1,#60
5698                     ; 1004 	apv_cnt[2]=60;
5700  0ec2 353c0044      	mov	_apv_cnt+2,#60
5701                     ; 1005 	apv_cnt_=3600;
5703  0ec6 ae0e10        	ldw	x,#3600
5704  0ec9 bf40          	ldw	_apv_cnt_,x
5705                     ; 1006 	bAPV=1;	
5707  0ecb 72100002      	bset	_bAPV
5708  0ecf               L5562:
5709                     ; 1008 }
5712  0ecf 81            	ret
5738                     ; 1011 void apv_stop(void)
5738                     ; 1012 {
5739                     	switch	.text
5740  0ed0               _apv_stop:
5744                     ; 1013 apv_cnt[0]=0;
5746  0ed0 3f42          	clr	_apv_cnt
5747                     ; 1014 apv_cnt[1]=0;
5749  0ed2 3f43          	clr	_apv_cnt+1
5750                     ; 1015 apv_cnt[2]=0;
5752  0ed4 3f44          	clr	_apv_cnt+2
5753                     ; 1016 apv_cnt_=0;	
5755  0ed6 5f            	clrw	x
5756  0ed7 bf40          	ldw	_apv_cnt_,x
5757                     ; 1017 bAPV=0;
5759  0ed9 72110002      	bres	_bAPV
5760                     ; 1018 }
5763  0edd 81            	ret
5798                     ; 1022 void apv_hndl(void)
5798                     ; 1023 {
5799                     	switch	.text
5800  0ede               _apv_hndl:
5804                     ; 1024 if(apv_cnt[0])
5806  0ede 3d42          	tnz	_apv_cnt
5807  0ee0 271e          	jreq	L7762
5808                     ; 1026 	apv_cnt[0]--;
5810  0ee2 3a42          	dec	_apv_cnt
5811                     ; 1027 	if(apv_cnt[0]==0)
5813  0ee4 3d42          	tnz	_apv_cnt
5814  0ee6 265a          	jrne	L3072
5815                     ; 1029 		flags&=0b11100001;
5817  0ee8 b60a          	ld	a,_flags
5818  0eea a4e1          	and	a,#225
5819  0eec b70a          	ld	_flags,a
5820                     ; 1030 		tsign_cnt=0;
5822  0eee 5f            	clrw	x
5823  0eef bf4a          	ldw	_tsign_cnt,x
5824                     ; 1031 		tmax_cnt=0;
5826  0ef1 5f            	clrw	x
5827  0ef2 bf48          	ldw	_tmax_cnt,x
5828                     ; 1032 		umax_cnt=0;
5830  0ef4 5f            	clrw	x
5831  0ef5 bf62          	ldw	_umax_cnt,x
5832                     ; 1033 		umin_cnt=0;
5834  0ef7 5f            	clrw	x
5835  0ef8 bf60          	ldw	_umin_cnt,x
5836                     ; 1035 		led_drv_cnt=30;
5838  0efa 351e0019      	mov	_led_drv_cnt,#30
5839  0efe 2042          	jra	L3072
5840  0f00               L7762:
5841                     ; 1038 else if(apv_cnt[1])
5843  0f00 3d43          	tnz	_apv_cnt+1
5844  0f02 271e          	jreq	L5072
5845                     ; 1040 	apv_cnt[1]--;
5847  0f04 3a43          	dec	_apv_cnt+1
5848                     ; 1041 	if(apv_cnt[1]==0)
5850  0f06 3d43          	tnz	_apv_cnt+1
5851  0f08 2638          	jrne	L3072
5852                     ; 1043 		flags&=0b11100001;
5854  0f0a b60a          	ld	a,_flags
5855  0f0c a4e1          	and	a,#225
5856  0f0e b70a          	ld	_flags,a
5857                     ; 1044 		tsign_cnt=0;
5859  0f10 5f            	clrw	x
5860  0f11 bf4a          	ldw	_tsign_cnt,x
5861                     ; 1045 		tmax_cnt=0;
5863  0f13 5f            	clrw	x
5864  0f14 bf48          	ldw	_tmax_cnt,x
5865                     ; 1046 		umax_cnt=0;
5867  0f16 5f            	clrw	x
5868  0f17 bf62          	ldw	_umax_cnt,x
5869                     ; 1047 		umin_cnt=0;
5871  0f19 5f            	clrw	x
5872  0f1a bf60          	ldw	_umin_cnt,x
5873                     ; 1049 		led_drv_cnt=30;
5875  0f1c 351e0019      	mov	_led_drv_cnt,#30
5876  0f20 2020          	jra	L3072
5877  0f22               L5072:
5878                     ; 1052 else if(apv_cnt[2])
5880  0f22 3d44          	tnz	_apv_cnt+2
5881  0f24 271c          	jreq	L3072
5882                     ; 1054 	apv_cnt[2]--;
5884  0f26 3a44          	dec	_apv_cnt+2
5885                     ; 1055 	if(apv_cnt[2]==0)
5887  0f28 3d44          	tnz	_apv_cnt+2
5888  0f2a 2616          	jrne	L3072
5889                     ; 1057 		flags&=0b11100001;
5891  0f2c b60a          	ld	a,_flags
5892  0f2e a4e1          	and	a,#225
5893  0f30 b70a          	ld	_flags,a
5894                     ; 1058 		tsign_cnt=0;
5896  0f32 5f            	clrw	x
5897  0f33 bf4a          	ldw	_tsign_cnt,x
5898                     ; 1059 		tmax_cnt=0;
5900  0f35 5f            	clrw	x
5901  0f36 bf48          	ldw	_tmax_cnt,x
5902                     ; 1060 		umax_cnt=0;
5904  0f38 5f            	clrw	x
5905  0f39 bf62          	ldw	_umax_cnt,x
5906                     ; 1061 		umin_cnt=0;          
5908  0f3b 5f            	clrw	x
5909  0f3c bf60          	ldw	_umin_cnt,x
5910                     ; 1063 		led_drv_cnt=30;
5912  0f3e 351e0019      	mov	_led_drv_cnt,#30
5913  0f42               L3072:
5914                     ; 1067 if(apv_cnt_)
5916  0f42 be40          	ldw	x,_apv_cnt_
5917  0f44 2712          	jreq	L7172
5918                     ; 1069 	apv_cnt_--;
5920  0f46 be40          	ldw	x,_apv_cnt_
5921  0f48 1d0001        	subw	x,#1
5922  0f4b bf40          	ldw	_apv_cnt_,x
5923                     ; 1070 	if(apv_cnt_==0) 
5925  0f4d be40          	ldw	x,_apv_cnt_
5926  0f4f 2607          	jrne	L7172
5927                     ; 1072 		bAPV=0;
5929  0f51 72110002      	bres	_bAPV
5930                     ; 1073 		apv_start();
5932  0f55 cd0ea7        	call	_apv_start
5934  0f58               L7172:
5935                     ; 1077 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5937  0f58 be60          	ldw	x,_umin_cnt
5938  0f5a 261e          	jrne	L3272
5940  0f5c be62          	ldw	x,_umax_cnt
5941  0f5e 261a          	jrne	L3272
5943  0f60 c65005        	ld	a,20485
5944  0f63 a504          	bcp	a,#4
5945  0f65 2613          	jrne	L3272
5946                     ; 1079 	if(cnt_apv_off<20)
5948  0f67 b63f          	ld	a,_cnt_apv_off
5949  0f69 a114          	cp	a,#20
5950  0f6b 240f          	jruge	L1372
5951                     ; 1081 		cnt_apv_off++;
5953  0f6d 3c3f          	inc	_cnt_apv_off
5954                     ; 1082 		if(cnt_apv_off>=20)
5956  0f6f b63f          	ld	a,_cnt_apv_off
5957  0f71 a114          	cp	a,#20
5958  0f73 2507          	jrult	L1372
5959                     ; 1084 			apv_stop();
5961  0f75 cd0ed0        	call	_apv_stop
5963  0f78 2002          	jra	L1372
5964  0f7a               L3272:
5965                     ; 1088 else cnt_apv_off=0;	
5967  0f7a 3f3f          	clr	_cnt_apv_off
5968  0f7c               L1372:
5969                     ; 1090 }
5972  0f7c 81            	ret
5975                     	switch	.ubsct
5976  0000               L3372_flags_old:
5977  0000 00            	ds.b	1
6013                     ; 1093 void flags_drv(void)
6013                     ; 1094 {
6014                     	switch	.text
6015  0f7d               _flags_drv:
6019                     ; 1096 if(jp_mode!=jp3) 
6021  0f7d b647          	ld	a,_jp_mode
6022  0f7f a103          	cp	a,#3
6023  0f81 2723          	jreq	L3572
6024                     ; 1098 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6026  0f83 b60a          	ld	a,_flags
6027  0f85 a508          	bcp	a,#8
6028  0f87 2706          	jreq	L1672
6030  0f89 b600          	ld	a,L3372_flags_old
6031  0f8b a508          	bcp	a,#8
6032  0f8d 270c          	jreq	L7572
6033  0f8f               L1672:
6035  0f8f b60a          	ld	a,_flags
6036  0f91 a510          	bcp	a,#16
6037  0f93 2726          	jreq	L5672
6039  0f95 b600          	ld	a,L3372_flags_old
6040  0f97 a510          	bcp	a,#16
6041  0f99 2620          	jrne	L5672
6042  0f9b               L7572:
6043                     ; 1100     		if(link==OFF)apv_start();
6045  0f9b b65f          	ld	a,_link
6046  0f9d a1aa          	cp	a,#170
6047  0f9f 261a          	jrne	L5672
6050  0fa1 cd0ea7        	call	_apv_start
6052  0fa4 2015          	jra	L5672
6053  0fa6               L3572:
6054                     ; 1103 else if(jp_mode==jp3) 
6056  0fa6 b647          	ld	a,_jp_mode
6057  0fa8 a103          	cp	a,#3
6058  0faa 260f          	jrne	L5672
6059                     ; 1105 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6061  0fac b60a          	ld	a,_flags
6062  0fae a508          	bcp	a,#8
6063  0fb0 2709          	jreq	L5672
6065  0fb2 b600          	ld	a,L3372_flags_old
6066  0fb4 a508          	bcp	a,#8
6067  0fb6 2603          	jrne	L5672
6068                     ; 1107     		apv_start();
6070  0fb8 cd0ea7        	call	_apv_start
6072  0fbb               L5672:
6073                     ; 1110 flags_old=flags;
6075  0fbb 450a00        	mov	L3372_flags_old,_flags
6076                     ; 1112 } 
6079  0fbe 81            	ret
6113                     ; 1251 char adr_gran(signed short in)
6113                     ; 1252 {
6114                     	switch	.text
6115  0fbf               _adr_gran:
6117  0fbf 89            	pushw	x
6118       00000000      OFST:	set	0
6121                     ; 1253 if(in>800)return 1;
6123  0fc0 9c            	rvf
6124  0fc1 a30321        	cpw	x,#801
6125  0fc4 2f04          	jrslt	L1103
6128  0fc6 a601          	ld	a,#1
6130  0fc8 2011          	jra	L221
6131  0fca               L1103:
6132                     ; 1254 else if((in>60)&&(in<150))return 0;
6134  0fca 9c            	rvf
6135  0fcb 1e01          	ldw	x,(OFST+1,sp)
6136  0fcd a3003d        	cpw	x,#61
6137  0fd0 2f0b          	jrslt	L5103
6139  0fd2 9c            	rvf
6140  0fd3 1e01          	ldw	x,(OFST+1,sp)
6141  0fd5 a30096        	cpw	x,#150
6142  0fd8 2e03          	jrsge	L5103
6145  0fda 4f            	clr	a
6147  0fdb               L221:
6149  0fdb 85            	popw	x
6150  0fdc 81            	ret
6151  0fdd               L5103:
6152                     ; 1255 else return 100;
6154  0fdd a664          	ld	a,#100
6156  0fdf 20fa          	jra	L221
6185                     ; 1259 void adr_drv_v3(void)
6185                     ; 1260 {
6186                     	switch	.text
6187  0fe1               _adr_drv_v3:
6189  0fe1 88            	push	a
6190       00000001      OFST:	set	1
6193                     ; 1266 GPIOB->DDR&=~(1<<0);
6195  0fe2 72115007      	bres	20487,#0
6196                     ; 1267 GPIOB->CR1&=~(1<<0);
6198  0fe6 72115008      	bres	20488,#0
6199                     ; 1268 GPIOB->CR2&=~(1<<0);
6201  0fea 72115009      	bres	20489,#0
6202                     ; 1269 ADC2->CR2=0x08;
6204  0fee 35085402      	mov	21506,#8
6205                     ; 1270 ADC2->CR1=0x40;
6207  0ff2 35405401      	mov	21505,#64
6208                     ; 1271 ADC2->CSR=0x20+0;
6210  0ff6 35205400      	mov	21504,#32
6211                     ; 1272 ADC2->CR1|=1;
6213  0ffa 72105401      	bset	21505,#0
6214                     ; 1273 ADC2->CR1|=1;
6216  0ffe 72105401      	bset	21505,#0
6217                     ; 1274 adr_drv_stat=1;
6219  1002 35010007      	mov	_adr_drv_stat,#1
6220  1006               L1303:
6221                     ; 1275 while(adr_drv_stat==1);
6224  1006 b607          	ld	a,_adr_drv_stat
6225  1008 a101          	cp	a,#1
6226  100a 27fa          	jreq	L1303
6227                     ; 1277 GPIOB->DDR&=~(1<<1);
6229  100c 72135007      	bres	20487,#1
6230                     ; 1278 GPIOB->CR1&=~(1<<1);
6232  1010 72135008      	bres	20488,#1
6233                     ; 1279 GPIOB->CR2&=~(1<<1);
6235  1014 72135009      	bres	20489,#1
6236                     ; 1280 ADC2->CR2=0x08;
6238  1018 35085402      	mov	21506,#8
6239                     ; 1281 ADC2->CR1=0x40;
6241  101c 35405401      	mov	21505,#64
6242                     ; 1282 ADC2->CSR=0x20+1;
6244  1020 35215400      	mov	21504,#33
6245                     ; 1283 ADC2->CR1|=1;
6247  1024 72105401      	bset	21505,#0
6248                     ; 1284 ADC2->CR1|=1;
6250  1028 72105401      	bset	21505,#0
6251                     ; 1285 adr_drv_stat=3;
6253  102c 35030007      	mov	_adr_drv_stat,#3
6254  1030               L7303:
6255                     ; 1286 while(adr_drv_stat==3);
6258  1030 b607          	ld	a,_adr_drv_stat
6259  1032 a103          	cp	a,#3
6260  1034 27fa          	jreq	L7303
6261                     ; 1288 GPIOE->DDR&=~(1<<6);
6263  1036 721d5016      	bres	20502,#6
6264                     ; 1289 GPIOE->CR1&=~(1<<6);
6266  103a 721d5017      	bres	20503,#6
6267                     ; 1290 GPIOE->CR2&=~(1<<6);
6269  103e 721d5018      	bres	20504,#6
6270                     ; 1291 ADC2->CR2=0x08;
6272  1042 35085402      	mov	21506,#8
6273                     ; 1292 ADC2->CR1=0x40;
6275  1046 35405401      	mov	21505,#64
6276                     ; 1293 ADC2->CSR=0x20+9;
6278  104a 35295400      	mov	21504,#41
6279                     ; 1294 ADC2->CR1|=1;
6281  104e 72105401      	bset	21505,#0
6282                     ; 1295 ADC2->CR1|=1;
6284  1052 72105401      	bset	21505,#0
6285                     ; 1296 adr_drv_stat=5;
6287  1056 35050007      	mov	_adr_drv_stat,#5
6288  105a               L5403:
6289                     ; 1297 while(adr_drv_stat==5);
6292  105a b607          	ld	a,_adr_drv_stat
6293  105c a105          	cp	a,#5
6294  105e 27fa          	jreq	L5403
6295                     ; 1301 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6297  1060 9c            	rvf
6298  1061 ce0005        	ldw	x,_adc_buff_
6299  1064 a3022a        	cpw	x,#554
6300  1067 2f0f          	jrslt	L3503
6302  1069 9c            	rvf
6303  106a ce0005        	ldw	x,_adc_buff_
6304  106d a30253        	cpw	x,#595
6305  1070 2e06          	jrsge	L3503
6308  1072 725f0002      	clr	_adr
6310  1076 204c          	jra	L5503
6311  1078               L3503:
6312                     ; 1302 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6314  1078 9c            	rvf
6315  1079 ce0005        	ldw	x,_adc_buff_
6316  107c a3036d        	cpw	x,#877
6317  107f 2f0f          	jrslt	L7503
6319  1081 9c            	rvf
6320  1082 ce0005        	ldw	x,_adc_buff_
6321  1085 a30396        	cpw	x,#918
6322  1088 2e06          	jrsge	L7503
6325  108a 35010002      	mov	_adr,#1
6327  108e 2034          	jra	L5503
6328  1090               L7503:
6329                     ; 1303 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6331  1090 9c            	rvf
6332  1091 ce0005        	ldw	x,_adc_buff_
6333  1094 a302a3        	cpw	x,#675
6334  1097 2f0f          	jrslt	L3603
6336  1099 9c            	rvf
6337  109a ce0005        	ldw	x,_adc_buff_
6338  109d a302cc        	cpw	x,#716
6339  10a0 2e06          	jrsge	L3603
6342  10a2 35020002      	mov	_adr,#2
6344  10a6 201c          	jra	L5503
6345  10a8               L3603:
6346                     ; 1304 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6348  10a8 9c            	rvf
6349  10a9 ce0005        	ldw	x,_adc_buff_
6350  10ac a303e3        	cpw	x,#995
6351  10af 2f0f          	jrslt	L7603
6353  10b1 9c            	rvf
6354  10b2 ce0005        	ldw	x,_adc_buff_
6355  10b5 a3040c        	cpw	x,#1036
6356  10b8 2e06          	jrsge	L7603
6359  10ba 35030002      	mov	_adr,#3
6361  10be 2004          	jra	L5503
6362  10c0               L7603:
6363                     ; 1305 else adr[0]=5;
6365  10c0 35050002      	mov	_adr,#5
6366  10c4               L5503:
6367                     ; 1307 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6369  10c4 9c            	rvf
6370  10c5 ce0007        	ldw	x,_adc_buff_+2
6371  10c8 a3022a        	cpw	x,#554
6372  10cb 2f0f          	jrslt	L3703
6374  10cd 9c            	rvf
6375  10ce ce0007        	ldw	x,_adc_buff_+2
6376  10d1 a30253        	cpw	x,#595
6377  10d4 2e06          	jrsge	L3703
6380  10d6 725f0003      	clr	_adr+1
6382  10da 204c          	jra	L5703
6383  10dc               L3703:
6384                     ; 1308 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6386  10dc 9c            	rvf
6387  10dd ce0007        	ldw	x,_adc_buff_+2
6388  10e0 a3036d        	cpw	x,#877
6389  10e3 2f0f          	jrslt	L7703
6391  10e5 9c            	rvf
6392  10e6 ce0007        	ldw	x,_adc_buff_+2
6393  10e9 a30396        	cpw	x,#918
6394  10ec 2e06          	jrsge	L7703
6397  10ee 35010003      	mov	_adr+1,#1
6399  10f2 2034          	jra	L5703
6400  10f4               L7703:
6401                     ; 1309 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6403  10f4 9c            	rvf
6404  10f5 ce0007        	ldw	x,_adc_buff_+2
6405  10f8 a302a3        	cpw	x,#675
6406  10fb 2f0f          	jrslt	L3013
6408  10fd 9c            	rvf
6409  10fe ce0007        	ldw	x,_adc_buff_+2
6410  1101 a302cc        	cpw	x,#716
6411  1104 2e06          	jrsge	L3013
6414  1106 35020003      	mov	_adr+1,#2
6416  110a 201c          	jra	L5703
6417  110c               L3013:
6418                     ; 1310 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6420  110c 9c            	rvf
6421  110d ce0007        	ldw	x,_adc_buff_+2
6422  1110 a303e3        	cpw	x,#995
6423  1113 2f0f          	jrslt	L7013
6425  1115 9c            	rvf
6426  1116 ce0007        	ldw	x,_adc_buff_+2
6427  1119 a3040c        	cpw	x,#1036
6428  111c 2e06          	jrsge	L7013
6431  111e 35030003      	mov	_adr+1,#3
6433  1122 2004          	jra	L5703
6434  1124               L7013:
6435                     ; 1311 else adr[1]=5;
6437  1124 35050003      	mov	_adr+1,#5
6438  1128               L5703:
6439                     ; 1313 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6441  1128 9c            	rvf
6442  1129 ce0017        	ldw	x,_adc_buff_+18
6443  112c a3022a        	cpw	x,#554
6444  112f 2f0f          	jrslt	L3113
6446  1131 9c            	rvf
6447  1132 ce0017        	ldw	x,_adc_buff_+18
6448  1135 a30253        	cpw	x,#595
6449  1138 2e06          	jrsge	L3113
6452  113a 725f0004      	clr	_adr+2
6454  113e 204c          	jra	L5113
6455  1140               L3113:
6456                     ; 1314 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6458  1140 9c            	rvf
6459  1141 ce0017        	ldw	x,_adc_buff_+18
6460  1144 a3036d        	cpw	x,#877
6461  1147 2f0f          	jrslt	L7113
6463  1149 9c            	rvf
6464  114a ce0017        	ldw	x,_adc_buff_+18
6465  114d a30396        	cpw	x,#918
6466  1150 2e06          	jrsge	L7113
6469  1152 35010004      	mov	_adr+2,#1
6471  1156 2034          	jra	L5113
6472  1158               L7113:
6473                     ; 1315 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6475  1158 9c            	rvf
6476  1159 ce0017        	ldw	x,_adc_buff_+18
6477  115c a302a3        	cpw	x,#675
6478  115f 2f0f          	jrslt	L3213
6480  1161 9c            	rvf
6481  1162 ce0017        	ldw	x,_adc_buff_+18
6482  1165 a302cc        	cpw	x,#716
6483  1168 2e06          	jrsge	L3213
6486  116a 35020004      	mov	_adr+2,#2
6488  116e 201c          	jra	L5113
6489  1170               L3213:
6490                     ; 1316 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6492  1170 9c            	rvf
6493  1171 ce0017        	ldw	x,_adc_buff_+18
6494  1174 a303e3        	cpw	x,#995
6495  1177 2f0f          	jrslt	L7213
6497  1179 9c            	rvf
6498  117a ce0017        	ldw	x,_adc_buff_+18
6499  117d a3040c        	cpw	x,#1036
6500  1180 2e06          	jrsge	L7213
6503  1182 35030004      	mov	_adr+2,#3
6505  1186 2004          	jra	L5113
6506  1188               L7213:
6507                     ; 1317 else adr[2]=5;
6509  1188 35050004      	mov	_adr+2,#5
6510  118c               L5113:
6511                     ; 1321 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6513  118c c60002        	ld	a,_adr
6514  118f a105          	cp	a,#5
6515  1191 270e          	jreq	L5313
6517  1193 c60003        	ld	a,_adr+1
6518  1196 a105          	cp	a,#5
6519  1198 2707          	jreq	L5313
6521  119a c60004        	ld	a,_adr+2
6522  119d a105          	cp	a,#5
6523  119f 2606          	jrne	L3313
6524  11a1               L5313:
6525                     ; 1324 	adress_error=1;
6527  11a1 35010000      	mov	_adress_error,#1
6529  11a5               L1413:
6530                     ; 1335 }
6533  11a5 84            	pop	a
6534  11a6 81            	ret
6535  11a7               L3313:
6536                     ; 1328 	if(adr[2]&0x02) bps_class=bpsIPS;
6538  11a7 c60004        	ld	a,_adr+2
6539  11aa a502          	bcp	a,#2
6540  11ac 2706          	jreq	L3413
6543  11ae 35010001      	mov	_bps_class,#1
6545  11b2 2002          	jra	L5413
6546  11b4               L3413:
6547                     ; 1329 	else bps_class=bpsIBEP;
6549  11b4 3f01          	clr	_bps_class
6550  11b6               L5413:
6551                     ; 1331 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6553  11b6 c60004        	ld	a,_adr+2
6554  11b9 a401          	and	a,#1
6555  11bb 97            	ld	xl,a
6556  11bc a610          	ld	a,#16
6557  11be 42            	mul	x,a
6558  11bf 9f            	ld	a,xl
6559  11c0 6b01          	ld	(OFST+0,sp),a
6560  11c2 c60003        	ld	a,_adr+1
6561  11c5 48            	sll	a
6562  11c6 48            	sll	a
6563  11c7 cb0002        	add	a,_adr
6564  11ca 1b01          	add	a,(OFST+0,sp)
6565  11cc c70001        	ld	_adress,a
6566  11cf 20d4          	jra	L1413
6625                     ; 1339 void adr_drv_v4(void)
6625                     ; 1340 {
6626                     	switch	.text
6627  11d1               _adr_drv_v4:
6629  11d1 5209          	subw	sp,#9
6630       00000009      OFST:	set	9
6633                     ; 1350 GPIOB->DDR&=~(1<<0);
6635  11d3 72115007      	bres	20487,#0
6636                     ; 1351 GPIOB->CR1&=~(1<<0);
6638  11d7 72115008      	bres	20488,#0
6639                     ; 1352 GPIOB->CR2&=~(1<<0);
6641  11db 72115009      	bres	20489,#0
6642                     ; 1353 ADC2->CR2=0x08;
6644  11df 35085402      	mov	21506,#8
6645                     ; 1354 ADC2->CR1=0x40;
6647  11e3 35405401      	mov	21505,#64
6648                     ; 1355 ADC2->CSR=0x20+0;
6650  11e7 35205400      	mov	21504,#32
6651                     ; 1356 ADC2->CR1|=1;
6653  11eb 72105401      	bset	21505,#0
6654                     ; 1357 ADC2->CR1|=1;
6656  11ef 72105401      	bset	21505,#0
6657                     ; 1358 adr_drv_stat=1;
6659  11f3 35010007      	mov	_adr_drv_stat,#1
6660  11f7               L5713:
6661                     ; 1359 while(adr_drv_stat==1);
6664  11f7 b607          	ld	a,_adr_drv_stat
6665  11f9 a101          	cp	a,#1
6666  11fb 27fa          	jreq	L5713
6667                     ; 1361 GPIOB->DDR&=~(1<<1);
6669  11fd 72135007      	bres	20487,#1
6670                     ; 1362 GPIOB->CR1&=~(1<<1);
6672  1201 72135008      	bres	20488,#1
6673                     ; 1363 GPIOB->CR2&=~(1<<1);
6675  1205 72135009      	bres	20489,#1
6676                     ; 1364 ADC2->CR2=0x08;
6678  1209 35085402      	mov	21506,#8
6679                     ; 1365 ADC2->CR1=0x40;
6681  120d 35405401      	mov	21505,#64
6682                     ; 1366 ADC2->CSR=0x20+1;
6684  1211 35215400      	mov	21504,#33
6685                     ; 1367 ADC2->CR1|=1;
6687  1215 72105401      	bset	21505,#0
6688                     ; 1368 ADC2->CR1|=1;
6690  1219 72105401      	bset	21505,#0
6691                     ; 1369 adr_drv_stat=3;
6693  121d 35030007      	mov	_adr_drv_stat,#3
6694  1221               L3023:
6695                     ; 1370 while(adr_drv_stat==3);
6698  1221 b607          	ld	a,_adr_drv_stat
6699  1223 a103          	cp	a,#3
6700  1225 27fa          	jreq	L3023
6701                     ; 1372 GPIOE->DDR&=~(1<<6);
6703  1227 721d5016      	bres	20502,#6
6704                     ; 1373 GPIOE->CR1&=~(1<<6);
6706  122b 721d5017      	bres	20503,#6
6707                     ; 1374 GPIOE->CR2&=~(1<<6);
6709  122f 721d5018      	bres	20504,#6
6710                     ; 1375 ADC2->CR2=0x08;
6712  1233 35085402      	mov	21506,#8
6713                     ; 1376 ADC2->CR1=0x40;
6715  1237 35405401      	mov	21505,#64
6716                     ; 1377 ADC2->CSR=0x20+9;
6718  123b 35295400      	mov	21504,#41
6719                     ; 1378 ADC2->CR1|=1;
6721  123f 72105401      	bset	21505,#0
6722                     ; 1379 ADC2->CR1|=1;
6724  1243 72105401      	bset	21505,#0
6725                     ; 1380 adr_drv_stat=5;
6727  1247 35050007      	mov	_adr_drv_stat,#5
6728  124b               L1123:
6729                     ; 1381 while(adr_drv_stat==5);
6732  124b b607          	ld	a,_adr_drv_stat
6733  124d a105          	cp	a,#5
6734  124f 27fa          	jreq	L1123
6735                     ; 1383 aaa[0]=adr_gran(adc_buff_[0]);
6737  1251 ce0005        	ldw	x,_adc_buff_
6738  1254 cd0fbf        	call	_adr_gran
6740  1257 6b07          	ld	(OFST-2,sp),a
6741                     ; 1384 tempSI=adc_buff_[0]/260;
6743  1259 ce0005        	ldw	x,_adc_buff_
6744  125c 90ae0104      	ldw	y,#260
6745  1260 cd0000        	call	c_idiv
6747  1263 1f05          	ldw	(OFST-4,sp),x
6748                     ; 1385 gran(&tempSI,0,3);
6750  1265 ae0003        	ldw	x,#3
6751  1268 89            	pushw	x
6752  1269 5f            	clrw	x
6753  126a 89            	pushw	x
6754  126b 96            	ldw	x,sp
6755  126c 1c0009        	addw	x,#OFST+0
6756  126f cd0000        	call	_gran
6758  1272 5b04          	addw	sp,#4
6759                     ; 1386 aaaa[0]=(char)tempSI;
6761  1274 7b06          	ld	a,(OFST-3,sp)
6762  1276 6b02          	ld	(OFST-7,sp),a
6763                     ; 1388 aaa[1]=adr_gran(adc_buff_[1]);
6765  1278 ce0007        	ldw	x,_adc_buff_+2
6766  127b cd0fbf        	call	_adr_gran
6768  127e 6b08          	ld	(OFST-1,sp),a
6769                     ; 1389 tempSI=adc_buff_[1]/260;
6771  1280 ce0007        	ldw	x,_adc_buff_+2
6772  1283 90ae0104      	ldw	y,#260
6773  1287 cd0000        	call	c_idiv
6775  128a 1f05          	ldw	(OFST-4,sp),x
6776                     ; 1390 gran(&tempSI,0,3);
6778  128c ae0003        	ldw	x,#3
6779  128f 89            	pushw	x
6780  1290 5f            	clrw	x
6781  1291 89            	pushw	x
6782  1292 96            	ldw	x,sp
6783  1293 1c0009        	addw	x,#OFST+0
6784  1296 cd0000        	call	_gran
6786  1299 5b04          	addw	sp,#4
6787                     ; 1391 aaaa[1]=(char)tempSI;
6789  129b 7b06          	ld	a,(OFST-3,sp)
6790  129d 6b03          	ld	(OFST-6,sp),a
6791                     ; 1393 aaa[2]=adr_gran(adc_buff_[9]);
6793  129f ce0017        	ldw	x,_adc_buff_+18
6794  12a2 cd0fbf        	call	_adr_gran
6796  12a5 6b09          	ld	(OFST+0,sp),a
6797                     ; 1394 tempSI=adc_buff_[2]/260;
6799  12a7 ce0009        	ldw	x,_adc_buff_+4
6800  12aa 90ae0104      	ldw	y,#260
6801  12ae cd0000        	call	c_idiv
6803  12b1 1f05          	ldw	(OFST-4,sp),x
6804                     ; 1395 gran(&tempSI,0,3);
6806  12b3 ae0003        	ldw	x,#3
6807  12b6 89            	pushw	x
6808  12b7 5f            	clrw	x
6809  12b8 89            	pushw	x
6810  12b9 96            	ldw	x,sp
6811  12ba 1c0009        	addw	x,#OFST+0
6812  12bd cd0000        	call	_gran
6814  12c0 5b04          	addw	sp,#4
6815                     ; 1396 aaaa[2]=(char)tempSI;
6817  12c2 7b06          	ld	a,(OFST-3,sp)
6818  12c4 6b04          	ld	(OFST-5,sp),a
6819                     ; 1399 adress=100;
6821  12c6 35640001      	mov	_adress,#100
6822                     ; 1402 if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
6824  12ca 7b07          	ld	a,(OFST-2,sp)
6825  12cc a164          	cp	a,#100
6826  12ce 2734          	jreq	L7123
6828  12d0 7b08          	ld	a,(OFST-1,sp)
6829  12d2 a164          	cp	a,#100
6830  12d4 272e          	jreq	L7123
6832  12d6 7b09          	ld	a,(OFST+0,sp)
6833  12d8 a164          	cp	a,#100
6834  12da 2728          	jreq	L7123
6835                     ; 1404 	if(aaa[0]==0)
6837  12dc 0d07          	tnz	(OFST-2,sp)
6838  12de 2610          	jrne	L1223
6839                     ; 1406 		if(aaa[1]==0)adress=3;
6841  12e0 0d08          	tnz	(OFST-1,sp)
6842  12e2 2606          	jrne	L3223
6845  12e4 35030001      	mov	_adress,#3
6847  12e8 2046          	jra	L7323
6848  12ea               L3223:
6849                     ; 1407 		else adress=0;
6851  12ea 725f0001      	clr	_adress
6852  12ee 2040          	jra	L7323
6853  12f0               L1223:
6854                     ; 1409 	else if(aaa[1]==0)adress=1;	
6856  12f0 0d08          	tnz	(OFST-1,sp)
6857  12f2 2606          	jrne	L1323
6860  12f4 35010001      	mov	_adress,#1
6862  12f8 2036          	jra	L7323
6863  12fa               L1323:
6864                     ; 1410 	else if(aaa[2]==0)adress=2;
6866  12fa 0d09          	tnz	(OFST+0,sp)
6867  12fc 2632          	jrne	L7323
6870  12fe 35020001      	mov	_adress,#2
6871  1302 202c          	jra	L7323
6872  1304               L7123:
6873                     ; 1414 else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adress=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
6875  1304 7b07          	ld	a,(OFST-2,sp)
6876  1306 a164          	cp	a,#100
6877  1308 2622          	jrne	L1423
6879  130a 7b08          	ld	a,(OFST-1,sp)
6880  130c a164          	cp	a,#100
6881  130e 261c          	jrne	L1423
6883  1310 7b09          	ld	a,(OFST+0,sp)
6884  1312 a164          	cp	a,#100
6885  1314 2616          	jrne	L1423
6888  1316 7b04          	ld	a,(OFST-5,sp)
6889  1318 97            	ld	xl,a
6890  1319 a610          	ld	a,#16
6891  131b 42            	mul	x,a
6892  131c 9f            	ld	a,xl
6893  131d 6b01          	ld	(OFST-8,sp),a
6894  131f 7b03          	ld	a,(OFST-6,sp)
6895  1321 48            	sll	a
6896  1322 48            	sll	a
6897  1323 1b02          	add	a,(OFST-7,sp)
6898  1325 1b01          	add	a,(OFST-8,sp)
6899  1327 c70001        	ld	_adress,a
6901  132a 2004          	jra	L7323
6902  132c               L1423:
6903                     ; 1418 else adress=100;
6905  132c 35640001      	mov	_adress,#100
6906  1330               L7323:
6907                     ; 1420 }
6910  1330 5b09          	addw	sp,#9
6911  1332 81            	ret
6955                     ; 1424 void volum_u_main_drv(void)
6955                     ; 1425 {
6956                     	switch	.text
6957  1333               _volum_u_main_drv:
6959  1333 88            	push	a
6960       00000001      OFST:	set	1
6963                     ; 1428 if(bMAIN)
6965                     	btst	_bMAIN
6966  1339 2503          	jrult	L231
6967  133b cc1484        	jp	L3623
6968  133e               L231:
6969                     ; 1430 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6971  133e 9c            	rvf
6972  133f ce0006        	ldw	x,_UU_AVT
6973  1342 1d000a        	subw	x,#10
6974  1345 b369          	cpw	x,_Un
6975  1347 2d09          	jrsle	L5623
6978  1349 be1c          	ldw	x,_volum_u_main_
6979  134b 1c0005        	addw	x,#5
6980  134e bf1c          	ldw	_volum_u_main_,x
6982  1350 2036          	jra	L7623
6983  1352               L5623:
6984                     ; 1431 	else if(Un<(UU_AVT-1))volum_u_main_++;
6986  1352 9c            	rvf
6987  1353 ce0006        	ldw	x,_UU_AVT
6988  1356 5a            	decw	x
6989  1357 b369          	cpw	x,_Un
6990  1359 2d09          	jrsle	L1723
6993  135b be1c          	ldw	x,_volum_u_main_
6994  135d 1c0001        	addw	x,#1
6995  1360 bf1c          	ldw	_volum_u_main_,x
6997  1362 2024          	jra	L7623
6998  1364               L1723:
6999                     ; 1432 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7001  1364 9c            	rvf
7002  1365 ce0006        	ldw	x,_UU_AVT
7003  1368 1c000a        	addw	x,#10
7004  136b b369          	cpw	x,_Un
7005  136d 2e09          	jrsge	L5723
7008  136f be1c          	ldw	x,_volum_u_main_
7009  1371 1d000a        	subw	x,#10
7010  1374 bf1c          	ldw	_volum_u_main_,x
7012  1376 2010          	jra	L7623
7013  1378               L5723:
7014                     ; 1433 	else if(Un>(UU_AVT+1))volum_u_main_--;
7016  1378 9c            	rvf
7017  1379 ce0006        	ldw	x,_UU_AVT
7018  137c 5c            	incw	x
7019  137d b369          	cpw	x,_Un
7020  137f 2e07          	jrsge	L7623
7023  1381 be1c          	ldw	x,_volum_u_main_
7024  1383 1d0001        	subw	x,#1
7025  1386 bf1c          	ldw	_volum_u_main_,x
7026  1388               L7623:
7027                     ; 1434 	if(volum_u_main_>1020)volum_u_main_=1020;
7029  1388 9c            	rvf
7030  1389 be1c          	ldw	x,_volum_u_main_
7031  138b a303fd        	cpw	x,#1021
7032  138e 2f05          	jrslt	L3033
7035  1390 ae03fc        	ldw	x,#1020
7036  1393 bf1c          	ldw	_volum_u_main_,x
7037  1395               L3033:
7038                     ; 1435 	if(volum_u_main_<0)volum_u_main_=0;
7040  1395 9c            	rvf
7041  1396 be1c          	ldw	x,_volum_u_main_
7042  1398 2e03          	jrsge	L5033
7045  139a 5f            	clrw	x
7046  139b bf1c          	ldw	_volum_u_main_,x
7047  139d               L5033:
7048                     ; 1438 	i_main_sigma=0;
7050  139d 5f            	clrw	x
7051  139e bf0c          	ldw	_i_main_sigma,x
7052                     ; 1439 	i_main_num_of_bps=0;
7054  13a0 3f0e          	clr	_i_main_num_of_bps
7055                     ; 1440 	for(i=0;i<6;i++)
7057  13a2 0f01          	clr	(OFST+0,sp)
7058  13a4               L7033:
7059                     ; 1442 		if(i_main_flag[i])
7061  13a4 7b01          	ld	a,(OFST+0,sp)
7062  13a6 5f            	clrw	x
7063  13a7 97            	ld	xl,a
7064  13a8 6d11          	tnz	(_i_main_flag,x)
7065  13aa 2719          	jreq	L5133
7066                     ; 1444 			i_main_sigma+=i_main[i];
7068  13ac 7b01          	ld	a,(OFST+0,sp)
7069  13ae 5f            	clrw	x
7070  13af 97            	ld	xl,a
7071  13b0 58            	sllw	x
7072  13b1 ee17          	ldw	x,(_i_main,x)
7073  13b3 72bb000c      	addw	x,_i_main_sigma
7074  13b7 bf0c          	ldw	_i_main_sigma,x
7075                     ; 1445 			i_main_flag[i]=1;
7077  13b9 7b01          	ld	a,(OFST+0,sp)
7078  13bb 5f            	clrw	x
7079  13bc 97            	ld	xl,a
7080  13bd a601          	ld	a,#1
7081  13bf e711          	ld	(_i_main_flag,x),a
7082                     ; 1446 			i_main_num_of_bps++;
7084  13c1 3c0e          	inc	_i_main_num_of_bps
7086  13c3 2006          	jra	L7133
7087  13c5               L5133:
7088                     ; 1450 			i_main_flag[i]=0;	
7090  13c5 7b01          	ld	a,(OFST+0,sp)
7091  13c7 5f            	clrw	x
7092  13c8 97            	ld	xl,a
7093  13c9 6f11          	clr	(_i_main_flag,x)
7094  13cb               L7133:
7095                     ; 1440 	for(i=0;i<6;i++)
7097  13cb 0c01          	inc	(OFST+0,sp)
7100  13cd 7b01          	ld	a,(OFST+0,sp)
7101  13cf a106          	cp	a,#6
7102  13d1 25d1          	jrult	L7033
7103                     ; 1453 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7105  13d3 be0c          	ldw	x,_i_main_sigma
7106  13d5 b60e          	ld	a,_i_main_num_of_bps
7107  13d7 905f          	clrw	y
7108  13d9 9097          	ld	yl,a
7109  13db cd0000        	call	c_idiv
7111  13de bf0f          	ldw	_i_main_avg,x
7112                     ; 1454 	for(i=0;i<6;i++)
7114  13e0 0f01          	clr	(OFST+0,sp)
7115  13e2               L1233:
7116                     ; 1456 		if(i_main_flag[i])
7118  13e2 7b01          	ld	a,(OFST+0,sp)
7119  13e4 5f            	clrw	x
7120  13e5 97            	ld	xl,a
7121  13e6 6d11          	tnz	(_i_main_flag,x)
7122  13e8 2603cc1479    	jreq	L7233
7123                     ; 1458 			if(i_main[i]<(i_main_avg-10))x[i]++;
7125  13ed 9c            	rvf
7126  13ee 7b01          	ld	a,(OFST+0,sp)
7127  13f0 5f            	clrw	x
7128  13f1 97            	ld	xl,a
7129  13f2 58            	sllw	x
7130  13f3 90be0f        	ldw	y,_i_main_avg
7131  13f6 72a2000a      	subw	y,#10
7132  13fa 90bf00        	ldw	c_y,y
7133  13fd 9093          	ldw	y,x
7134  13ff 90ee17        	ldw	y,(_i_main,y)
7135  1402 90b300        	cpw	y,c_y
7136  1405 2e11          	jrsge	L1333
7139  1407 7b01          	ld	a,(OFST+0,sp)
7140  1409 5f            	clrw	x
7141  140a 97            	ld	xl,a
7142  140b 58            	sllw	x
7143  140c 9093          	ldw	y,x
7144  140e ee23          	ldw	x,(_x,x)
7145  1410 1c0001        	addw	x,#1
7146  1413 90ef23        	ldw	(_x,y),x
7148  1416 2029          	jra	L3333
7149  1418               L1333:
7150                     ; 1459 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7152  1418 9c            	rvf
7153  1419 7b01          	ld	a,(OFST+0,sp)
7154  141b 5f            	clrw	x
7155  141c 97            	ld	xl,a
7156  141d 58            	sllw	x
7157  141e 90be0f        	ldw	y,_i_main_avg
7158  1421 72a9000a      	addw	y,#10
7159  1425 90bf00        	ldw	c_y,y
7160  1428 9093          	ldw	y,x
7161  142a 90ee17        	ldw	y,(_i_main,y)
7162  142d 90b300        	cpw	y,c_y
7163  1430 2d0f          	jrsle	L3333
7166  1432 7b01          	ld	a,(OFST+0,sp)
7167  1434 5f            	clrw	x
7168  1435 97            	ld	xl,a
7169  1436 58            	sllw	x
7170  1437 9093          	ldw	y,x
7171  1439 ee23          	ldw	x,(_x,x)
7172  143b 1d0001        	subw	x,#1
7173  143e 90ef23        	ldw	(_x,y),x
7174  1441               L3333:
7175                     ; 1460 			if(x[i]>100)x[i]=100;
7177  1441 9c            	rvf
7178  1442 7b01          	ld	a,(OFST+0,sp)
7179  1444 5f            	clrw	x
7180  1445 97            	ld	xl,a
7181  1446 58            	sllw	x
7182  1447 9093          	ldw	y,x
7183  1449 90ee23        	ldw	y,(_x,y)
7184  144c 90a30065      	cpw	y,#101
7185  1450 2f0b          	jrslt	L7333
7188  1452 7b01          	ld	a,(OFST+0,sp)
7189  1454 5f            	clrw	x
7190  1455 97            	ld	xl,a
7191  1456 58            	sllw	x
7192  1457 90ae0064      	ldw	y,#100
7193  145b ef23          	ldw	(_x,x),y
7194  145d               L7333:
7195                     ; 1461 			if(x[i]<-100)x[i]=-100;
7197  145d 9c            	rvf
7198  145e 7b01          	ld	a,(OFST+0,sp)
7199  1460 5f            	clrw	x
7200  1461 97            	ld	xl,a
7201  1462 58            	sllw	x
7202  1463 9093          	ldw	y,x
7203  1465 90ee23        	ldw	y,(_x,y)
7204  1468 90a3ff9c      	cpw	y,#65436
7205  146c 2e0b          	jrsge	L7233
7208  146e 7b01          	ld	a,(OFST+0,sp)
7209  1470 5f            	clrw	x
7210  1471 97            	ld	xl,a
7211  1472 58            	sllw	x
7212  1473 90aeff9c      	ldw	y,#65436
7213  1477 ef23          	ldw	(_x,x),y
7214  1479               L7233:
7215                     ; 1454 	for(i=0;i<6;i++)
7217  1479 0c01          	inc	(OFST+0,sp)
7220  147b 7b01          	ld	a,(OFST+0,sp)
7221  147d a106          	cp	a,#6
7222  147f 2403cc13e2    	jrult	L1233
7223  1484               L3623:
7224                     ; 1468 }
7227  1484 84            	pop	a
7228  1485 81            	ret
7251                     ; 1471 void init_CAN(void) {
7252                     	switch	.text
7253  1486               _init_CAN:
7257                     ; 1472 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7259  1486 72135420      	bres	21536,#1
7260                     ; 1473 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7262  148a 72105420      	bset	21536,#0
7264  148e               L5533:
7265                     ; 1474 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7267  148e c65421        	ld	a,21537
7268  1491 a501          	bcp	a,#1
7269  1493 27f9          	jreq	L5533
7270                     ; 1476 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7272  1495 72185420      	bset	21536,#4
7273                     ; 1478 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7275  1499 35025427      	mov	21543,#2
7276                     ; 1487 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7278  149d 35135428      	mov	21544,#19
7279                     ; 1488 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7281  14a1 35c05429      	mov	21545,#192
7282                     ; 1489 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7284  14a5 357f542c      	mov	21548,#127
7285                     ; 1490 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7287  14a9 35e0542d      	mov	21549,#224
7288                     ; 1492 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7290  14ad 35315430      	mov	21552,#49
7291                     ; 1493 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7293  14b1 35c05431      	mov	21553,#192
7294                     ; 1494 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7296  14b5 357f5434      	mov	21556,#127
7297                     ; 1495 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7299  14b9 35e05435      	mov	21557,#224
7300                     ; 1499 	CAN->PSR= 6;									// set page 6
7302  14bd 35065427      	mov	21543,#6
7303                     ; 1504 	CAN->Page.Config.FMR1&=~3;								//mask mode
7305  14c1 c65430        	ld	a,21552
7306  14c4 a4fc          	and	a,#252
7307  14c6 c75430        	ld	21552,a
7308                     ; 1510 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7310  14c9 35065432      	mov	21554,#6
7311                     ; 1511 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7313  14cd 35605432      	mov	21554,#96
7314                     ; 1514 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7316  14d1 72105432      	bset	21554,#0
7317                     ; 1515 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7319  14d5 72185432      	bset	21554,#4
7320                     ; 1518 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7322  14d9 35065427      	mov	21543,#6
7323                     ; 1520 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7325  14dd 3509542c      	mov	21548,#9
7326                     ; 1521 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7328  14e1 35e7542d      	mov	21549,#231
7329                     ; 1523 	CAN->IER|=(1<<1);
7331  14e5 72125425      	bset	21541,#1
7332                     ; 1526 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7334  14e9 72115420      	bres	21536,#0
7336  14ed               L3633:
7337                     ; 1527 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7339  14ed c65421        	ld	a,21537
7340  14f0 a501          	bcp	a,#1
7341  14f2 26f9          	jrne	L3633
7342                     ; 1528 }
7345  14f4 81            	ret
7453                     ; 1531 void can_transmit(unsigned short id_st,char data0,char data1,signed char data2,char data3,char data4,char data5,char data6,char data7)
7453                     ; 1532 {
7454                     	switch	.text
7455  14f5               _can_transmit:
7457  14f5 89            	pushw	x
7458       00000000      OFST:	set	0
7461                     ; 1534 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7463  14f6 b670          	ld	a,_can_buff_wr_ptr
7464  14f8 a104          	cp	a,#4
7465  14fa 2502          	jrult	L5443
7468  14fc 3f70          	clr	_can_buff_wr_ptr
7469  14fe               L5443:
7470                     ; 1536 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7472  14fe b670          	ld	a,_can_buff_wr_ptr
7473  1500 97            	ld	xl,a
7474  1501 a610          	ld	a,#16
7475  1503 42            	mul	x,a
7476  1504 1601          	ldw	y,(OFST+1,sp)
7477  1506 a606          	ld	a,#6
7478  1508               L041:
7479  1508 9054          	srlw	y
7480  150a 4a            	dec	a
7481  150b 26fb          	jrne	L041
7482  150d 909f          	ld	a,yl
7483  150f e771          	ld	(_can_out_buff,x),a
7484                     ; 1537 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7486  1511 b670          	ld	a,_can_buff_wr_ptr
7487  1513 97            	ld	xl,a
7488  1514 a610          	ld	a,#16
7489  1516 42            	mul	x,a
7490  1517 7b02          	ld	a,(OFST+2,sp)
7491  1519 48            	sll	a
7492  151a 48            	sll	a
7493  151b e772          	ld	(_can_out_buff+1,x),a
7494                     ; 1539 can_out_buff[can_buff_wr_ptr][2]=data0;
7496  151d b670          	ld	a,_can_buff_wr_ptr
7497  151f 97            	ld	xl,a
7498  1520 a610          	ld	a,#16
7499  1522 42            	mul	x,a
7500  1523 7b05          	ld	a,(OFST+5,sp)
7501  1525 e773          	ld	(_can_out_buff+2,x),a
7502                     ; 1540 can_out_buff[can_buff_wr_ptr][3]=data1;
7504  1527 b670          	ld	a,_can_buff_wr_ptr
7505  1529 97            	ld	xl,a
7506  152a a610          	ld	a,#16
7507  152c 42            	mul	x,a
7508  152d 7b06          	ld	a,(OFST+6,sp)
7509  152f e774          	ld	(_can_out_buff+3,x),a
7510                     ; 1541 can_out_buff[can_buff_wr_ptr][4]=data2;
7512  1531 b670          	ld	a,_can_buff_wr_ptr
7513  1533 97            	ld	xl,a
7514  1534 a610          	ld	a,#16
7515  1536 42            	mul	x,a
7516  1537 7b07          	ld	a,(OFST+7,sp)
7517  1539 e775          	ld	(_can_out_buff+4,x),a
7518                     ; 1542 can_out_buff[can_buff_wr_ptr][5]=data3;
7520  153b b670          	ld	a,_can_buff_wr_ptr
7521  153d 97            	ld	xl,a
7522  153e a610          	ld	a,#16
7523  1540 42            	mul	x,a
7524  1541 7b08          	ld	a,(OFST+8,sp)
7525  1543 e776          	ld	(_can_out_buff+5,x),a
7526                     ; 1543 can_out_buff[can_buff_wr_ptr][6]=data4;
7528  1545 b670          	ld	a,_can_buff_wr_ptr
7529  1547 97            	ld	xl,a
7530  1548 a610          	ld	a,#16
7531  154a 42            	mul	x,a
7532  154b 7b09          	ld	a,(OFST+9,sp)
7533  154d e777          	ld	(_can_out_buff+6,x),a
7534                     ; 1544 can_out_buff[can_buff_wr_ptr][7]=data5;
7536  154f b670          	ld	a,_can_buff_wr_ptr
7537  1551 97            	ld	xl,a
7538  1552 a610          	ld	a,#16
7539  1554 42            	mul	x,a
7540  1555 7b0a          	ld	a,(OFST+10,sp)
7541  1557 e778          	ld	(_can_out_buff+7,x),a
7542                     ; 1545 can_out_buff[can_buff_wr_ptr][8]=data6;
7544  1559 b670          	ld	a,_can_buff_wr_ptr
7545  155b 97            	ld	xl,a
7546  155c a610          	ld	a,#16
7547  155e 42            	mul	x,a
7548  155f 7b0b          	ld	a,(OFST+11,sp)
7549  1561 e779          	ld	(_can_out_buff+8,x),a
7550                     ; 1546 can_out_buff[can_buff_wr_ptr][9]=data7;
7552  1563 b670          	ld	a,_can_buff_wr_ptr
7553  1565 97            	ld	xl,a
7554  1566 a610          	ld	a,#16
7555  1568 42            	mul	x,a
7556  1569 7b0c          	ld	a,(OFST+12,sp)
7557  156b e77a          	ld	(_can_out_buff+9,x),a
7558                     ; 1548 can_buff_wr_ptr++;
7560  156d 3c70          	inc	_can_buff_wr_ptr
7561                     ; 1549 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7563  156f b670          	ld	a,_can_buff_wr_ptr
7564  1571 a104          	cp	a,#4
7565  1573 2502          	jrult	L7443
7568  1575 3f70          	clr	_can_buff_wr_ptr
7569  1577               L7443:
7570                     ; 1550 } 
7573  1577 85            	popw	x
7574  1578 81            	ret
7603                     ; 1553 void can_tx_hndl(void)
7603                     ; 1554 {
7604                     	switch	.text
7605  1579               _can_tx_hndl:
7609                     ; 1555 if(bTX_FREE)
7611  1579 3d08          	tnz	_bTX_FREE
7612  157b 2757          	jreq	L1643
7613                     ; 1557 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7615  157d b66f          	ld	a,_can_buff_rd_ptr
7616  157f b170          	cp	a,_can_buff_wr_ptr
7617  1581 275f          	jreq	L7643
7618                     ; 1559 		bTX_FREE=0;
7620  1583 3f08          	clr	_bTX_FREE
7621                     ; 1561 		CAN->PSR= 0;
7623  1585 725f5427      	clr	21543
7624                     ; 1562 		CAN->Page.TxMailbox.MDLCR=8;
7626  1589 35085429      	mov	21545,#8
7627                     ; 1563 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7629  158d b66f          	ld	a,_can_buff_rd_ptr
7630  158f 97            	ld	xl,a
7631  1590 a610          	ld	a,#16
7632  1592 42            	mul	x,a
7633  1593 e671          	ld	a,(_can_out_buff,x)
7634  1595 c7542a        	ld	21546,a
7635                     ; 1564 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7637  1598 b66f          	ld	a,_can_buff_rd_ptr
7638  159a 97            	ld	xl,a
7639  159b a610          	ld	a,#16
7640  159d 42            	mul	x,a
7641  159e e672          	ld	a,(_can_out_buff+1,x)
7642  15a0 c7542b        	ld	21547,a
7643                     ; 1566 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7645  15a3 b66f          	ld	a,_can_buff_rd_ptr
7646  15a5 97            	ld	xl,a
7647  15a6 a610          	ld	a,#16
7648  15a8 42            	mul	x,a
7649  15a9 01            	rrwa	x,a
7650  15aa ab73          	add	a,#_can_out_buff+2
7651  15ac 2401          	jrnc	L441
7652  15ae 5c            	incw	x
7653  15af               L441:
7654  15af 5f            	clrw	x
7655  15b0 97            	ld	xl,a
7656  15b1 bf00          	ldw	c_x,x
7657  15b3 ae0008        	ldw	x,#8
7658  15b6               L641:
7659  15b6 5a            	decw	x
7660  15b7 92d600        	ld	a,([c_x],x)
7661  15ba d7542e        	ld	(21550,x),a
7662  15bd 5d            	tnzw	x
7663  15be 26f6          	jrne	L641
7664                     ; 1568 		can_buff_rd_ptr++;
7666  15c0 3c6f          	inc	_can_buff_rd_ptr
7667                     ; 1569 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7669  15c2 b66f          	ld	a,_can_buff_rd_ptr
7670  15c4 a104          	cp	a,#4
7671  15c6 2502          	jrult	L5643
7674  15c8 3f6f          	clr	_can_buff_rd_ptr
7675  15ca               L5643:
7676                     ; 1571 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7678  15ca 72105428      	bset	21544,#0
7679                     ; 1572 		CAN->IER|=(1<<0);
7681  15ce 72105425      	bset	21541,#0
7682  15d2 200e          	jra	L7643
7683  15d4               L1643:
7684                     ; 1577 	tx_busy_cnt++;
7686  15d4 3c6e          	inc	_tx_busy_cnt
7687                     ; 1578 	if(tx_busy_cnt>=100)
7689  15d6 b66e          	ld	a,_tx_busy_cnt
7690  15d8 a164          	cp	a,#100
7691  15da 2506          	jrult	L7643
7692                     ; 1580 		tx_busy_cnt=0;
7694  15dc 3f6e          	clr	_tx_busy_cnt
7695                     ; 1581 		bTX_FREE=1;
7697  15de 35010008      	mov	_bTX_FREE,#1
7698  15e2               L7643:
7699                     ; 1584 }
7702  15e2 81            	ret
7741                     ; 1587 void net_drv(void)
7741                     ; 1588 { 
7742                     	switch	.text
7743  15e3               _net_drv:
7747                     ; 1590 if(bMAIN)
7749                     	btst	_bMAIN
7750  15e8 2503          	jrult	L251
7751  15ea cc1690        	jp	L3053
7752  15ed               L251:
7753                     ; 1592 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7755  15ed 3c2f          	inc	_cnt_net_drv
7756  15ef b62f          	ld	a,_cnt_net_drv
7757  15f1 a107          	cp	a,#7
7758  15f3 2502          	jrult	L5053
7761  15f5 3f2f          	clr	_cnt_net_drv
7762  15f7               L5053:
7763                     ; 1594 	if(cnt_net_drv<=5) 
7765  15f7 b62f          	ld	a,_cnt_net_drv
7766  15f9 a106          	cp	a,#6
7767  15fb 244c          	jruge	L7053
7768                     ; 1596 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7770  15fd 4be8          	push	#232
7771  15ff 4be8          	push	#232
7772  1601 b62f          	ld	a,_cnt_net_drv
7773  1603 5f            	clrw	x
7774  1604 97            	ld	xl,a
7775  1605 58            	sllw	x
7776  1606 ee23          	ldw	x,(_x,x)
7777  1608 72bb001c      	addw	x,_volum_u_main_
7778  160c 90ae0100      	ldw	y,#256
7779  1610 cd0000        	call	c_idiv
7781  1613 9f            	ld	a,xl
7782  1614 88            	push	a
7783  1615 b62f          	ld	a,_cnt_net_drv
7784  1617 5f            	clrw	x
7785  1618 97            	ld	xl,a
7786  1619 58            	sllw	x
7787  161a e624          	ld	a,(_x+1,x)
7788  161c bb1d          	add	a,_volum_u_main_+1
7789  161e 88            	push	a
7790  161f 4b00          	push	#0
7791  1621 4bed          	push	#237
7792  1623 3b002f        	push	_cnt_net_drv
7793  1626 3b002f        	push	_cnt_net_drv
7794  1629 ae009e        	ldw	x,#158
7795  162c cd14f5        	call	_can_transmit
7797  162f 5b08          	addw	sp,#8
7798                     ; 1597 		i_main_bps_cnt[cnt_net_drv]++;
7800  1631 b62f          	ld	a,_cnt_net_drv
7801  1633 5f            	clrw	x
7802  1634 97            	ld	xl,a
7803  1635 6c06          	inc	(_i_main_bps_cnt,x)
7804                     ; 1598 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7806  1637 b62f          	ld	a,_cnt_net_drv
7807  1639 5f            	clrw	x
7808  163a 97            	ld	xl,a
7809  163b e606          	ld	a,(_i_main_bps_cnt,x)
7810  163d a10b          	cp	a,#11
7811  163f 254f          	jrult	L3053
7814  1641 b62f          	ld	a,_cnt_net_drv
7815  1643 5f            	clrw	x
7816  1644 97            	ld	xl,a
7817  1645 6f11          	clr	(_i_main_flag,x)
7818  1647 2047          	jra	L3053
7819  1649               L7053:
7820                     ; 1600 	else if(cnt_net_drv==6)
7822  1649 b62f          	ld	a,_cnt_net_drv
7823  164b a106          	cp	a,#6
7824  164d 2641          	jrne	L3053
7825                     ; 1602 		plazma_int[2]=pwm_u;
7827  164f be0b          	ldw	x,_pwm_u
7828  1651 bf34          	ldw	_plazma_int+4,x
7829                     ; 1603 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7831  1653 3b0067        	push	_Ui
7832  1656 3b0068        	push	_Ui+1
7833  1659 3b0069        	push	_Un
7834  165c 3b006a        	push	_Un+1
7835  165f 3b006b        	push	_I
7836  1662 3b006c        	push	_I+1
7837  1665 4bda          	push	#218
7838  1667 3b0001        	push	_adress
7839  166a ae018e        	ldw	x,#398
7840  166d cd14f5        	call	_can_transmit
7842  1670 5b08          	addw	sp,#8
7843                     ; 1604 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7845  1672 3b0034        	push	_plazma_int+4
7846  1675 3b0035        	push	_plazma_int+5
7847  1678 3b005c        	push	__x_+1
7848  167b 3b000a        	push	_flags
7849  167e 4b00          	push	#0
7850  1680 3b0064        	push	_T
7851  1683 4bdb          	push	#219
7852  1685 3b0001        	push	_adress
7853  1688 ae018e        	ldw	x,#398
7854  168b cd14f5        	call	_can_transmit
7856  168e 5b08          	addw	sp,#8
7857  1690               L3053:
7858                     ; 1607 }
7861  1690 81            	ret
7971                     ; 1610 void can_in_an(void)
7971                     ; 1611 {
7972                     	switch	.text
7973  1691               _can_in_an:
7975  1691 5205          	subw	sp,#5
7976       00000005      OFST:	set	5
7979                     ; 1621 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7981  1693 b6c6          	ld	a,_mess+6
7982  1695 c10001        	cp	a,_adress
7983  1698 2703          	jreq	L471
7984  169a cc17a2        	jp	L3553
7985  169d               L471:
7987  169d b6c7          	ld	a,_mess+7
7988  169f c10001        	cp	a,_adress
7989  16a2 2703          	jreq	L671
7990  16a4 cc17a2        	jp	L3553
7991  16a7               L671:
7993  16a7 b6c8          	ld	a,_mess+8
7994  16a9 a1ed          	cp	a,#237
7995  16ab 2703          	jreq	L002
7996  16ad cc17a2        	jp	L3553
7997  16b0               L002:
7998                     ; 1624 	can_error_cnt=0;
8000  16b0 3f6d          	clr	_can_error_cnt
8001                     ; 1626 	bMAIN=0;
8003  16b2 72110001      	bres	_bMAIN
8004                     ; 1627  	flags_tu=mess[9];
8006  16b6 45c95d        	mov	_flags_tu,_mess+9
8007                     ; 1628  	if(flags_tu&0b00000001)
8009  16b9 b65d          	ld	a,_flags_tu
8010  16bb a501          	bcp	a,#1
8011  16bd 2706          	jreq	L5553
8012                     ; 1633  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8014  16bf 721a000a      	bset	_flags,#5
8016  16c3 200e          	jra	L7553
8017  16c5               L5553:
8018                     ; 1644  				flags&=0b11011111; 
8020  16c5 721b000a      	bres	_flags,#5
8021                     ; 1645  				off_bp_cnt=5*ee_TZAS;
8023  16c9 c60015        	ld	a,_ee_TZAS+1
8024  16cc 97            	ld	xl,a
8025  16cd a605          	ld	a,#5
8026  16cf 42            	mul	x,a
8027  16d0 9f            	ld	a,xl
8028  16d1 b750          	ld	_off_bp_cnt,a
8029  16d3               L7553:
8030                     ; 1651  	if(flags_tu&0b00000010) flags|=0b01000000;
8032  16d3 b65d          	ld	a,_flags_tu
8033  16d5 a502          	bcp	a,#2
8034  16d7 2706          	jreq	L1653
8037  16d9 721c000a      	bset	_flags,#6
8039  16dd 2004          	jra	L3653
8040  16df               L1653:
8041                     ; 1652  	else flags&=0b10111111; 
8043  16df 721d000a      	bres	_flags,#6
8044  16e3               L3653:
8045                     ; 1654  	vol_u_temp=mess[10]+mess[11]*256;
8047  16e3 b6cb          	ld	a,_mess+11
8048  16e5 5f            	clrw	x
8049  16e6 97            	ld	xl,a
8050  16e7 4f            	clr	a
8051  16e8 02            	rlwa	x,a
8052  16e9 01            	rrwa	x,a
8053  16ea bbca          	add	a,_mess+10
8054  16ec 2401          	jrnc	L651
8055  16ee 5c            	incw	x
8056  16ef               L651:
8057  16ef b756          	ld	_vol_u_temp+1,a
8058  16f1 9f            	ld	a,xl
8059  16f2 b755          	ld	_vol_u_temp,a
8060                     ; 1655  	vol_i_temp=mess[12]+mess[13]*256;  
8062  16f4 b6cd          	ld	a,_mess+13
8063  16f6 5f            	clrw	x
8064  16f7 97            	ld	xl,a
8065  16f8 4f            	clr	a
8066  16f9 02            	rlwa	x,a
8067  16fa 01            	rrwa	x,a
8068  16fb bbcc          	add	a,_mess+12
8069  16fd 2401          	jrnc	L061
8070  16ff 5c            	incw	x
8071  1700               L061:
8072  1700 b754          	ld	_vol_i_temp+1,a
8073  1702 9f            	ld	a,xl
8074  1703 b753          	ld	_vol_i_temp,a
8075                     ; 1665 	plazma_int[2]=pwm_u;
8077  1705 be0b          	ldw	x,_pwm_u
8078  1707 bf34          	ldw	_plazma_int+4,x
8079                     ; 1666  	rotor_int=flags_tu+(((short)flags)<<8);
8081  1709 b60a          	ld	a,_flags
8082  170b 5f            	clrw	x
8083  170c 97            	ld	xl,a
8084  170d 4f            	clr	a
8085  170e 02            	rlwa	x,a
8086  170f 01            	rrwa	x,a
8087  1710 bb5d          	add	a,_flags_tu
8088  1712 2401          	jrnc	L261
8089  1714 5c            	incw	x
8090  1715               L261:
8091  1715 b71b          	ld	_rotor_int+1,a
8092  1717 9f            	ld	a,xl
8093  1718 b71a          	ld	_rotor_int,a
8094                     ; 1667 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8096  171a 3b0067        	push	_Ui
8097  171d 3b0068        	push	_Ui+1
8098  1720 3b0069        	push	_Un
8099  1723 3b006a        	push	_Un+1
8100  1726 3b006b        	push	_I
8101  1729 3b006c        	push	_I+1
8102  172c 4bda          	push	#218
8103  172e 3b0001        	push	_adress
8104  1731 ae018e        	ldw	x,#398
8105  1734 cd14f5        	call	_can_transmit
8107  1737 5b08          	addw	sp,#8
8108                     ; 1668 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8110  1739 3b0034        	push	_plazma_int+4
8111  173c 3b0035        	push	_plazma_int+5
8112  173f 3b005c        	push	__x_+1
8113  1742 3b000a        	push	_flags
8114  1745 4b00          	push	#0
8115  1747 3b0064        	push	_T
8116  174a 4bdb          	push	#219
8117  174c 3b0001        	push	_adress
8118  174f ae018e        	ldw	x,#398
8119  1752 cd14f5        	call	_can_transmit
8121  1755 5b08          	addw	sp,#8
8122                     ; 1669      link_cnt=0;
8124  1757 3f5e          	clr	_link_cnt
8125                     ; 1670      link=ON;
8127  1759 3555005f      	mov	_link,#85
8128                     ; 1672      if(flags_tu&0b10000000)
8130  175d b65d          	ld	a,_flags_tu
8131  175f a580          	bcp	a,#128
8132  1761 2716          	jreq	L5653
8133                     ; 1674      	if(!res_fl)
8135  1763 725d0009      	tnz	_res_fl
8136  1767 2625          	jrne	L1753
8137                     ; 1676      		res_fl=1;
8139  1769 a601          	ld	a,#1
8140  176b ae0009        	ldw	x,#_res_fl
8141  176e cd0000        	call	c_eewrc
8143                     ; 1677      		bRES=1;
8145  1771 3501000f      	mov	_bRES,#1
8146                     ; 1678      		res_fl_cnt=0;
8148  1775 3f3e          	clr	_res_fl_cnt
8149  1777 2015          	jra	L1753
8150  1779               L5653:
8151                     ; 1683      	if(main_cnt>20)
8153  1779 9c            	rvf
8154  177a be4e          	ldw	x,_main_cnt
8155  177c a30015        	cpw	x,#21
8156  177f 2f0d          	jrslt	L1753
8157                     ; 1685     			if(res_fl)
8159  1781 725d0009      	tnz	_res_fl
8160  1785 2707          	jreq	L1753
8161                     ; 1687      			res_fl=0;
8163  1787 4f            	clr	a
8164  1788 ae0009        	ldw	x,#_res_fl
8165  178b cd0000        	call	c_eewrc
8167  178e               L1753:
8168                     ; 1692       if(res_fl_)
8170  178e 725d0008      	tnz	_res_fl_
8171  1792 2603          	jrne	L202
8172  1794 cc1cc5        	jp	L7153
8173  1797               L202:
8174                     ; 1694       	res_fl_=0;
8176  1797 4f            	clr	a
8177  1798 ae0008        	ldw	x,#_res_fl_
8178  179b cd0000        	call	c_eewrc
8180  179e acc51cc5      	jpf	L7153
8181  17a2               L3553:
8182                     ; 1697 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8184  17a2 b6c6          	ld	a,_mess+6
8185  17a4 c10001        	cp	a,_adress
8186  17a7 2703          	jreq	L402
8187  17a9 cc19b8        	jp	L3063
8188  17ac               L402:
8190  17ac b6c7          	ld	a,_mess+7
8191  17ae c10001        	cp	a,_adress
8192  17b1 2703          	jreq	L602
8193  17b3 cc19b8        	jp	L3063
8194  17b6               L602:
8196  17b6 b6c8          	ld	a,_mess+8
8197  17b8 a1ee          	cp	a,#238
8198  17ba 2703          	jreq	L012
8199  17bc cc19b8        	jp	L3063
8200  17bf               L012:
8202  17bf b6c9          	ld	a,_mess+9
8203  17c1 b1ca          	cp	a,_mess+10
8204  17c3 2703          	jreq	L212
8205  17c5 cc19b8        	jp	L3063
8206  17c8               L212:
8207                     ; 1699 	rotor_int++;
8209  17c8 be1a          	ldw	x,_rotor_int
8210  17ca 1c0001        	addw	x,#1
8211  17cd bf1a          	ldw	_rotor_int,x
8212                     ; 1700 	if((mess[9]&0xf0)==0x20)
8214  17cf b6c9          	ld	a,_mess+9
8215  17d1 a4f0          	and	a,#240
8216  17d3 a120          	cp	a,#32
8217  17d5 2673          	jrne	L5063
8218                     ; 1702 		if((mess[9]&0x0f)==0x01)
8220  17d7 b6c9          	ld	a,_mess+9
8221  17d9 a40f          	and	a,#15
8222  17db a101          	cp	a,#1
8223  17dd 260d          	jrne	L7063
8224                     ; 1704 			ee_K[0][0]=adc_buff_[4];
8226  17df ce000d        	ldw	x,_adc_buff_+8
8227  17e2 89            	pushw	x
8228  17e3 ae0018        	ldw	x,#_ee_K
8229  17e6 cd0000        	call	c_eewrw
8231  17e9 85            	popw	x
8233  17ea 204a          	jra	L1163
8234  17ec               L7063:
8235                     ; 1706 		else if((mess[9]&0x0f)==0x02)
8237  17ec b6c9          	ld	a,_mess+9
8238  17ee a40f          	and	a,#15
8239  17f0 a102          	cp	a,#2
8240  17f2 260b          	jrne	L3163
8241                     ; 1708 			ee_K[0][1]++;
8243  17f4 ce001a        	ldw	x,_ee_K+2
8244  17f7 1c0001        	addw	x,#1
8245  17fa cf001a        	ldw	_ee_K+2,x
8247  17fd 2037          	jra	L1163
8248  17ff               L3163:
8249                     ; 1710 		else if((mess[9]&0x0f)==0x03)
8251  17ff b6c9          	ld	a,_mess+9
8252  1801 a40f          	and	a,#15
8253  1803 a103          	cp	a,#3
8254  1805 260b          	jrne	L7163
8255                     ; 1712 			ee_K[0][1]+=10;
8257  1807 ce001a        	ldw	x,_ee_K+2
8258  180a 1c000a        	addw	x,#10
8259  180d cf001a        	ldw	_ee_K+2,x
8261  1810 2024          	jra	L1163
8262  1812               L7163:
8263                     ; 1714 		else if((mess[9]&0x0f)==0x04)
8265  1812 b6c9          	ld	a,_mess+9
8266  1814 a40f          	and	a,#15
8267  1816 a104          	cp	a,#4
8268  1818 260b          	jrne	L3263
8269                     ; 1716 			ee_K[0][1]--;
8271  181a ce001a        	ldw	x,_ee_K+2
8272  181d 1d0001        	subw	x,#1
8273  1820 cf001a        	ldw	_ee_K+2,x
8275  1823 2011          	jra	L1163
8276  1825               L3263:
8277                     ; 1718 		else if((mess[9]&0x0f)==0x05)
8279  1825 b6c9          	ld	a,_mess+9
8280  1827 a40f          	and	a,#15
8281  1829 a105          	cp	a,#5
8282  182b 2609          	jrne	L1163
8283                     ; 1720 			ee_K[0][1]-=10;
8285  182d ce001a        	ldw	x,_ee_K+2
8286  1830 1d000a        	subw	x,#10
8287  1833 cf001a        	ldw	_ee_K+2,x
8288  1836               L1163:
8289                     ; 1722 		granee(&ee_K[0][1],50,3000);									
8291  1836 ae0bb8        	ldw	x,#3000
8292  1839 89            	pushw	x
8293  183a ae0032        	ldw	x,#50
8294  183d 89            	pushw	x
8295  183e ae001a        	ldw	x,#_ee_K+2
8296  1841 cd0021        	call	_granee
8298  1844 5b04          	addw	sp,#4
8300  1846 ac9e199e      	jpf	L1363
8301  184a               L5063:
8302                     ; 1724 	else if((mess[9]&0xf0)==0x10)
8304  184a b6c9          	ld	a,_mess+9
8305  184c a4f0          	and	a,#240
8306  184e a110          	cp	a,#16
8307  1850 2673          	jrne	L3363
8308                     ; 1726 		if((mess[9]&0x0f)==0x01)
8310  1852 b6c9          	ld	a,_mess+9
8311  1854 a40f          	and	a,#15
8312  1856 a101          	cp	a,#1
8313  1858 260d          	jrne	L5363
8314                     ; 1728 			ee_K[1][0]=adc_buff_[1];
8316  185a ce0007        	ldw	x,_adc_buff_+2
8317  185d 89            	pushw	x
8318  185e ae001c        	ldw	x,#_ee_K+4
8319  1861 cd0000        	call	c_eewrw
8321  1864 85            	popw	x
8323  1865 204a          	jra	L7363
8324  1867               L5363:
8325                     ; 1730 		else if((mess[9]&0x0f)==0x02)
8327  1867 b6c9          	ld	a,_mess+9
8328  1869 a40f          	and	a,#15
8329  186b a102          	cp	a,#2
8330  186d 260b          	jrne	L1463
8331                     ; 1732 			ee_K[1][1]++;
8333  186f ce001e        	ldw	x,_ee_K+6
8334  1872 1c0001        	addw	x,#1
8335  1875 cf001e        	ldw	_ee_K+6,x
8337  1878 2037          	jra	L7363
8338  187a               L1463:
8339                     ; 1734 		else if((mess[9]&0x0f)==0x03)
8341  187a b6c9          	ld	a,_mess+9
8342  187c a40f          	and	a,#15
8343  187e a103          	cp	a,#3
8344  1880 260b          	jrne	L5463
8345                     ; 1736 			ee_K[1][1]+=10;
8347  1882 ce001e        	ldw	x,_ee_K+6
8348  1885 1c000a        	addw	x,#10
8349  1888 cf001e        	ldw	_ee_K+6,x
8351  188b 2024          	jra	L7363
8352  188d               L5463:
8353                     ; 1738 		else if((mess[9]&0x0f)==0x04)
8355  188d b6c9          	ld	a,_mess+9
8356  188f a40f          	and	a,#15
8357  1891 a104          	cp	a,#4
8358  1893 260b          	jrne	L1563
8359                     ; 1740 			ee_K[1][1]--;
8361  1895 ce001e        	ldw	x,_ee_K+6
8362  1898 1d0001        	subw	x,#1
8363  189b cf001e        	ldw	_ee_K+6,x
8365  189e 2011          	jra	L7363
8366  18a0               L1563:
8367                     ; 1742 		else if((mess[9]&0x0f)==0x05)
8369  18a0 b6c9          	ld	a,_mess+9
8370  18a2 a40f          	and	a,#15
8371  18a4 a105          	cp	a,#5
8372  18a6 2609          	jrne	L7363
8373                     ; 1744 			ee_K[1][1]-=10;
8375  18a8 ce001e        	ldw	x,_ee_K+6
8376  18ab 1d000a        	subw	x,#10
8377  18ae cf001e        	ldw	_ee_K+6,x
8378  18b1               L7363:
8379                     ; 1749 		granee(&ee_K[1][1],10,30000);
8381  18b1 ae7530        	ldw	x,#30000
8382  18b4 89            	pushw	x
8383  18b5 ae000a        	ldw	x,#10
8384  18b8 89            	pushw	x
8385  18b9 ae001e        	ldw	x,#_ee_K+6
8386  18bc cd0021        	call	_granee
8388  18bf 5b04          	addw	sp,#4
8390  18c1 ac9e199e      	jpf	L1363
8391  18c5               L3363:
8392                     ; 1753 	else if((mess[9]&0xf0)==0x00)
8394  18c5 b6c9          	ld	a,_mess+9
8395  18c7 a5f0          	bcp	a,#240
8396  18c9 2671          	jrne	L1663
8397                     ; 1755 		if((mess[9]&0x0f)==0x01)
8399  18cb b6c9          	ld	a,_mess+9
8400  18cd a40f          	and	a,#15
8401  18cf a101          	cp	a,#1
8402  18d1 260d          	jrne	L3663
8403                     ; 1757 			ee_K[2][0]=adc_buff_[2];
8405  18d3 ce0009        	ldw	x,_adc_buff_+4
8406  18d6 89            	pushw	x
8407  18d7 ae0020        	ldw	x,#_ee_K+8
8408  18da cd0000        	call	c_eewrw
8410  18dd 85            	popw	x
8412  18de 204a          	jra	L5663
8413  18e0               L3663:
8414                     ; 1759 		else if((mess[9]&0x0f)==0x02)
8416  18e0 b6c9          	ld	a,_mess+9
8417  18e2 a40f          	and	a,#15
8418  18e4 a102          	cp	a,#2
8419  18e6 260b          	jrne	L7663
8420                     ; 1761 			ee_K[2][1]++;
8422  18e8 ce0022        	ldw	x,_ee_K+10
8423  18eb 1c0001        	addw	x,#1
8424  18ee cf0022        	ldw	_ee_K+10,x
8426  18f1 2037          	jra	L5663
8427  18f3               L7663:
8428                     ; 1763 		else if((mess[9]&0x0f)==0x03)
8430  18f3 b6c9          	ld	a,_mess+9
8431  18f5 a40f          	and	a,#15
8432  18f7 a103          	cp	a,#3
8433  18f9 260b          	jrne	L3763
8434                     ; 1765 			ee_K[2][1]+=10;
8436  18fb ce0022        	ldw	x,_ee_K+10
8437  18fe 1c000a        	addw	x,#10
8438  1901 cf0022        	ldw	_ee_K+10,x
8440  1904 2024          	jra	L5663
8441  1906               L3763:
8442                     ; 1767 		else if((mess[9]&0x0f)==0x04)
8444  1906 b6c9          	ld	a,_mess+9
8445  1908 a40f          	and	a,#15
8446  190a a104          	cp	a,#4
8447  190c 260b          	jrne	L7763
8448                     ; 1769 			ee_K[2][1]--;
8450  190e ce0022        	ldw	x,_ee_K+10
8451  1911 1d0001        	subw	x,#1
8452  1914 cf0022        	ldw	_ee_K+10,x
8454  1917 2011          	jra	L5663
8455  1919               L7763:
8456                     ; 1771 		else if((mess[9]&0x0f)==0x05)
8458  1919 b6c9          	ld	a,_mess+9
8459  191b a40f          	and	a,#15
8460  191d a105          	cp	a,#5
8461  191f 2609          	jrne	L5663
8462                     ; 1773 			ee_K[2][1]-=10;
8464  1921 ce0022        	ldw	x,_ee_K+10
8465  1924 1d000a        	subw	x,#10
8466  1927 cf0022        	ldw	_ee_K+10,x
8467  192a               L5663:
8468                     ; 1778 		granee(&ee_K[2][1],10,30000);
8470  192a ae7530        	ldw	x,#30000
8471  192d 89            	pushw	x
8472  192e ae000a        	ldw	x,#10
8473  1931 89            	pushw	x
8474  1932 ae0022        	ldw	x,#_ee_K+10
8475  1935 cd0021        	call	_granee
8477  1938 5b04          	addw	sp,#4
8479  193a 2062          	jra	L1363
8480  193c               L1663:
8481                     ; 1782 	else if((mess[9]&0xf0)==0x30)
8483  193c b6c9          	ld	a,_mess+9
8484  193e a4f0          	and	a,#240
8485  1940 a130          	cp	a,#48
8486  1942 265a          	jrne	L1363
8487                     ; 1784 		if((mess[9]&0x0f)==0x02)
8489  1944 b6c9          	ld	a,_mess+9
8490  1946 a40f          	and	a,#15
8491  1948 a102          	cp	a,#2
8492  194a 260b          	jrne	L1173
8493                     ; 1786 			ee_K[3][1]++;
8495  194c ce0026        	ldw	x,_ee_K+14
8496  194f 1c0001        	addw	x,#1
8497  1952 cf0026        	ldw	_ee_K+14,x
8499  1955 2037          	jra	L3173
8500  1957               L1173:
8501                     ; 1788 		else if((mess[9]&0x0f)==0x03)
8503  1957 b6c9          	ld	a,_mess+9
8504  1959 a40f          	and	a,#15
8505  195b a103          	cp	a,#3
8506  195d 260b          	jrne	L5173
8507                     ; 1790 			ee_K[3][1]+=10;
8509  195f ce0026        	ldw	x,_ee_K+14
8510  1962 1c000a        	addw	x,#10
8511  1965 cf0026        	ldw	_ee_K+14,x
8513  1968 2024          	jra	L3173
8514  196a               L5173:
8515                     ; 1792 		else if((mess[9]&0x0f)==0x04)
8517  196a b6c9          	ld	a,_mess+9
8518  196c a40f          	and	a,#15
8519  196e a104          	cp	a,#4
8520  1970 260b          	jrne	L1273
8521                     ; 1794 			ee_K[3][1]--;
8523  1972 ce0026        	ldw	x,_ee_K+14
8524  1975 1d0001        	subw	x,#1
8525  1978 cf0026        	ldw	_ee_K+14,x
8527  197b 2011          	jra	L3173
8528  197d               L1273:
8529                     ; 1796 		else if((mess[9]&0x0f)==0x05)
8531  197d b6c9          	ld	a,_mess+9
8532  197f a40f          	and	a,#15
8533  1981 a105          	cp	a,#5
8534  1983 2609          	jrne	L3173
8535                     ; 1798 			ee_K[3][1]-=10;
8537  1985 ce0026        	ldw	x,_ee_K+14
8538  1988 1d000a        	subw	x,#10
8539  198b cf0026        	ldw	_ee_K+14,x
8540  198e               L3173:
8541                     ; 1800 		granee(&ee_K[3][1],300,517);									
8543  198e ae0205        	ldw	x,#517
8544  1991 89            	pushw	x
8545  1992 ae012c        	ldw	x,#300
8546  1995 89            	pushw	x
8547  1996 ae0026        	ldw	x,#_ee_K+14
8548  1999 cd0021        	call	_granee
8550  199c 5b04          	addw	sp,#4
8551  199e               L1363:
8552                     ; 1803 	link_cnt=0;
8554  199e 3f5e          	clr	_link_cnt
8555                     ; 1804      link=ON;
8557  19a0 3555005f      	mov	_link,#85
8558                     ; 1805      if(res_fl_)
8560  19a4 725d0008      	tnz	_res_fl_
8561  19a8 2603          	jrne	L412
8562  19aa cc1cc5        	jp	L7153
8563  19ad               L412:
8564                     ; 1807       	res_fl_=0;
8566  19ad 4f            	clr	a
8567  19ae ae0008        	ldw	x,#_res_fl_
8568  19b1 cd0000        	call	c_eewrc
8570  19b4 acc51cc5      	jpf	L7153
8571  19b8               L3063:
8572                     ; 1813 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==0x95))
8574  19b8 b6c6          	ld	a,_mess+6
8575  19ba a1ff          	cp	a,#255
8576  19bc 2703          	jreq	L612
8577  19be cc1a4c        	jp	L3373
8578  19c1               L612:
8580  19c1 b6c7          	ld	a,_mess+7
8581  19c3 a1ff          	cp	a,#255
8582  19c5 2703          	jreq	L022
8583  19c7 cc1a4c        	jp	L3373
8584  19ca               L022:
8586  19ca b6c8          	ld	a,_mess+8
8587  19cc a195          	cp	a,#149
8588  19ce 267c          	jrne	L3373
8589                     ; 1816 	tempSS=mess[9]+(mess[10]*256);
8591  19d0 b6ca          	ld	a,_mess+10
8592  19d2 5f            	clrw	x
8593  19d3 97            	ld	xl,a
8594  19d4 4f            	clr	a
8595  19d5 02            	rlwa	x,a
8596  19d6 01            	rrwa	x,a
8597  19d7 bbc9          	add	a,_mess+9
8598  19d9 2401          	jrnc	L461
8599  19db 5c            	incw	x
8600  19dc               L461:
8601  19dc 02            	rlwa	x,a
8602  19dd 1f04          	ldw	(OFST-1,sp),x
8603  19df 01            	rrwa	x,a
8604                     ; 1817 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8606  19e0 ce0012        	ldw	x,_ee_Umax
8607  19e3 1304          	cpw	x,(OFST-1,sp)
8608  19e5 270a          	jreq	L5373
8611  19e7 1e04          	ldw	x,(OFST-1,sp)
8612  19e9 89            	pushw	x
8613  19ea ae0012        	ldw	x,#_ee_Umax
8614  19ed cd0000        	call	c_eewrw
8616  19f0 85            	popw	x
8617  19f1               L5373:
8618                     ; 1818 	tempSS=mess[11]+(mess[12]*256);
8620  19f1 b6cc          	ld	a,_mess+12
8621  19f3 5f            	clrw	x
8622  19f4 97            	ld	xl,a
8623  19f5 4f            	clr	a
8624  19f6 02            	rlwa	x,a
8625  19f7 01            	rrwa	x,a
8626  19f8 bbcb          	add	a,_mess+11
8627  19fa 2401          	jrnc	L661
8628  19fc 5c            	incw	x
8629  19fd               L661:
8630  19fd 02            	rlwa	x,a
8631  19fe 1f04          	ldw	(OFST-1,sp),x
8632  1a00 01            	rrwa	x,a
8633                     ; 1819 	if(ee_dU!=tempSS) ee_dU=tempSS;
8635  1a01 ce0010        	ldw	x,_ee_dU
8636  1a04 1304          	cpw	x,(OFST-1,sp)
8637  1a06 270a          	jreq	L7373
8640  1a08 1e04          	ldw	x,(OFST-1,sp)
8641  1a0a 89            	pushw	x
8642  1a0b ae0010        	ldw	x,#_ee_dU
8643  1a0e cd0000        	call	c_eewrw
8645  1a11 85            	popw	x
8646  1a12               L7373:
8647                     ; 1820 	if((mess[13]&0x0f)==0x5)
8649  1a12 b6cd          	ld	a,_mess+13
8650  1a14 a40f          	and	a,#15
8651  1a16 a105          	cp	a,#5
8652  1a18 261a          	jrne	L1473
8653                     ; 1822 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8655  1a1a ce0004        	ldw	x,_ee_AVT_MODE
8656  1a1d a30055        	cpw	x,#85
8657  1a20 2603          	jrne	L222
8658  1a22 cc1cc5        	jp	L7153
8659  1a25               L222:
8662  1a25 ae0055        	ldw	x,#85
8663  1a28 89            	pushw	x
8664  1a29 ae0004        	ldw	x,#_ee_AVT_MODE
8665  1a2c cd0000        	call	c_eewrw
8667  1a2f 85            	popw	x
8668  1a30 acc51cc5      	jpf	L7153
8669  1a34               L1473:
8670                     ; 1824 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8672  1a34 ce0004        	ldw	x,_ee_AVT_MODE
8673  1a37 a30055        	cpw	x,#85
8674  1a3a 2703          	jreq	L422
8675  1a3c cc1cc5        	jp	L7153
8676  1a3f               L422:
8679  1a3f 5f            	clrw	x
8680  1a40 89            	pushw	x
8681  1a41 ae0004        	ldw	x,#_ee_AVT_MODE
8682  1a44 cd0000        	call	c_eewrw
8684  1a47 85            	popw	x
8685  1a48 acc51cc5      	jpf	L7153
8686  1a4c               L3373:
8687                     ; 1827 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8689  1a4c b6c6          	ld	a,_mess+6
8690  1a4e a1ff          	cp	a,#255
8691  1a50 2703          	jreq	L622
8692  1a52 cc1b23        	jp	L3573
8693  1a55               L622:
8695  1a55 b6c7          	ld	a,_mess+7
8696  1a57 a1ff          	cp	a,#255
8697  1a59 2703          	jreq	L032
8698  1a5b cc1b23        	jp	L3573
8699  1a5e               L032:
8701  1a5e b6c8          	ld	a,_mess+8
8702  1a60 a126          	cp	a,#38
8703  1a62 2709          	jreq	L5573
8705  1a64 b6c8          	ld	a,_mess+8
8706  1a66 a129          	cp	a,#41
8707  1a68 2703          	jreq	L232
8708  1a6a cc1b23        	jp	L3573
8709  1a6d               L232:
8710  1a6d               L5573:
8711                     ; 1830 	tempSS=mess[9]+(mess[10]*256);
8713  1a6d b6ca          	ld	a,_mess+10
8714  1a6f 5f            	clrw	x
8715  1a70 97            	ld	xl,a
8716  1a71 4f            	clr	a
8717  1a72 02            	rlwa	x,a
8718  1a73 01            	rrwa	x,a
8719  1a74 bbc9          	add	a,_mess+9
8720  1a76 2401          	jrnc	L071
8721  1a78 5c            	incw	x
8722  1a79               L071:
8723  1a79 02            	rlwa	x,a
8724  1a7a 1f04          	ldw	(OFST-1,sp),x
8725  1a7c 01            	rrwa	x,a
8726                     ; 1831 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8728  1a7d ce000e        	ldw	x,_ee_tmax
8729  1a80 1304          	cpw	x,(OFST-1,sp)
8730  1a82 270a          	jreq	L7573
8733  1a84 1e04          	ldw	x,(OFST-1,sp)
8734  1a86 89            	pushw	x
8735  1a87 ae000e        	ldw	x,#_ee_tmax
8736  1a8a cd0000        	call	c_eewrw
8738  1a8d 85            	popw	x
8739  1a8e               L7573:
8740                     ; 1832 	tempSS=mess[11]+(mess[12]*256);
8742  1a8e b6cc          	ld	a,_mess+12
8743  1a90 5f            	clrw	x
8744  1a91 97            	ld	xl,a
8745  1a92 4f            	clr	a
8746  1a93 02            	rlwa	x,a
8747  1a94 01            	rrwa	x,a
8748  1a95 bbcb          	add	a,_mess+11
8749  1a97 2401          	jrnc	L271
8750  1a99 5c            	incw	x
8751  1a9a               L271:
8752  1a9a 02            	rlwa	x,a
8753  1a9b 1f04          	ldw	(OFST-1,sp),x
8754  1a9d 01            	rrwa	x,a
8755                     ; 1833 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8757  1a9e ce000c        	ldw	x,_ee_tsign
8758  1aa1 1304          	cpw	x,(OFST-1,sp)
8759  1aa3 270a          	jreq	L1673
8762  1aa5 1e04          	ldw	x,(OFST-1,sp)
8763  1aa7 89            	pushw	x
8764  1aa8 ae000c        	ldw	x,#_ee_tsign
8765  1aab cd0000        	call	c_eewrw
8767  1aae 85            	popw	x
8768  1aaf               L1673:
8769                     ; 1836 	if(mess[8]==MEM_KF1)
8771  1aaf b6c8          	ld	a,_mess+8
8772  1ab1 a126          	cp	a,#38
8773  1ab3 2623          	jrne	L3673
8774                     ; 1838 		if(ee_DEVICE!=0)ee_DEVICE=0;
8776  1ab5 ce0002        	ldw	x,_ee_DEVICE
8777  1ab8 2709          	jreq	L5673
8780  1aba 5f            	clrw	x
8781  1abb 89            	pushw	x
8782  1abc ae0002        	ldw	x,#_ee_DEVICE
8783  1abf cd0000        	call	c_eewrw
8785  1ac2 85            	popw	x
8786  1ac3               L5673:
8787                     ; 1839 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8789  1ac3 b6cd          	ld	a,_mess+13
8790  1ac5 5f            	clrw	x
8791  1ac6 97            	ld	xl,a
8792  1ac7 c30014        	cpw	x,_ee_TZAS
8793  1aca 270c          	jreq	L3673
8796  1acc b6cd          	ld	a,_mess+13
8797  1ace 5f            	clrw	x
8798  1acf 97            	ld	xl,a
8799  1ad0 89            	pushw	x
8800  1ad1 ae0014        	ldw	x,#_ee_TZAS
8801  1ad4 cd0000        	call	c_eewrw
8803  1ad7 85            	popw	x
8804  1ad8               L3673:
8805                     ; 1841 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8807  1ad8 b6c8          	ld	a,_mess+8
8808  1ada a129          	cp	a,#41
8809  1adc 2703          	jreq	L432
8810  1ade cc1cc5        	jp	L7153
8811  1ae1               L432:
8812                     ; 1843 		if(ee_DEVICE!=1)ee_DEVICE=1;
8814  1ae1 ce0002        	ldw	x,_ee_DEVICE
8815  1ae4 a30001        	cpw	x,#1
8816  1ae7 270b          	jreq	L3773
8819  1ae9 ae0001        	ldw	x,#1
8820  1aec 89            	pushw	x
8821  1aed ae0002        	ldw	x,#_ee_DEVICE
8822  1af0 cd0000        	call	c_eewrw
8824  1af3 85            	popw	x
8825  1af4               L3773:
8826                     ; 1844 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8828  1af4 b6cd          	ld	a,_mess+13
8829  1af6 5f            	clrw	x
8830  1af7 97            	ld	xl,a
8831  1af8 c30000        	cpw	x,_ee_IMAXVENT
8832  1afb 270c          	jreq	L5773
8835  1afd b6cd          	ld	a,_mess+13
8836  1aff 5f            	clrw	x
8837  1b00 97            	ld	xl,a
8838  1b01 89            	pushw	x
8839  1b02 ae0000        	ldw	x,#_ee_IMAXVENT
8840  1b05 cd0000        	call	c_eewrw
8842  1b08 85            	popw	x
8843  1b09               L5773:
8844                     ; 1845 			if(ee_TZAS!=3) ee_TZAS=3;
8846  1b09 ce0014        	ldw	x,_ee_TZAS
8847  1b0c a30003        	cpw	x,#3
8848  1b0f 2603          	jrne	L632
8849  1b11 cc1cc5        	jp	L7153
8850  1b14               L632:
8853  1b14 ae0003        	ldw	x,#3
8854  1b17 89            	pushw	x
8855  1b18 ae0014        	ldw	x,#_ee_TZAS
8856  1b1b cd0000        	call	c_eewrw
8858  1b1e 85            	popw	x
8859  1b1f acc51cc5      	jpf	L7153
8860  1b23               L3573:
8861                     ; 1849 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8863  1b23 b6c6          	ld	a,_mess+6
8864  1b25 c10001        	cp	a,_adress
8865  1b28 262d          	jrne	L3004
8867  1b2a b6c7          	ld	a,_mess+7
8868  1b2c c10001        	cp	a,_adress
8869  1b2f 2626          	jrne	L3004
8871  1b31 b6c8          	ld	a,_mess+8
8872  1b33 a116          	cp	a,#22
8873  1b35 2620          	jrne	L3004
8875  1b37 b6c9          	ld	a,_mess+9
8876  1b39 a163          	cp	a,#99
8877  1b3b 261a          	jrne	L3004
8878                     ; 1851 	flags&=0b11100001;
8880  1b3d b60a          	ld	a,_flags
8881  1b3f a4e1          	and	a,#225
8882  1b41 b70a          	ld	_flags,a
8883                     ; 1852 	tsign_cnt=0;
8885  1b43 5f            	clrw	x
8886  1b44 bf4a          	ldw	_tsign_cnt,x
8887                     ; 1853 	tmax_cnt=0;
8889  1b46 5f            	clrw	x
8890  1b47 bf48          	ldw	_tmax_cnt,x
8891                     ; 1854 	umax_cnt=0;
8893  1b49 5f            	clrw	x
8894  1b4a bf62          	ldw	_umax_cnt,x
8895                     ; 1855 	umin_cnt=0;
8897  1b4c 5f            	clrw	x
8898  1b4d bf60          	ldw	_umin_cnt,x
8899                     ; 1856 	led_drv_cnt=30;
8901  1b4f 351e0019      	mov	_led_drv_cnt,#30
8903  1b53 acc51cc5      	jpf	L7153
8904  1b57               L3004:
8905                     ; 1858 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8907  1b57 b6c6          	ld	a,_mess+6
8908  1b59 a1ff          	cp	a,#255
8909  1b5b 265f          	jrne	L7004
8911  1b5d b6c7          	ld	a,_mess+7
8912  1b5f a1ff          	cp	a,#255
8913  1b61 2659          	jrne	L7004
8915  1b63 b6c8          	ld	a,_mess+8
8916  1b65 a116          	cp	a,#22
8917  1b67 2653          	jrne	L7004
8919  1b69 b6c9          	ld	a,_mess+9
8920  1b6b a116          	cp	a,#22
8921  1b6d 264d          	jrne	L7004
8922                     ; 1860 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8924  1b6f b6ca          	ld	a,_mess+10
8925  1b71 a155          	cp	a,#85
8926  1b73 260f          	jrne	L1104
8928  1b75 b6cb          	ld	a,_mess+11
8929  1b77 a155          	cp	a,#85
8930  1b79 2609          	jrne	L1104
8933  1b7b be5b          	ldw	x,__x_
8934  1b7d 1c0001        	addw	x,#1
8935  1b80 bf5b          	ldw	__x_,x
8937  1b82 2024          	jra	L3104
8938  1b84               L1104:
8939                     ; 1861 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8941  1b84 b6ca          	ld	a,_mess+10
8942  1b86 a166          	cp	a,#102
8943  1b88 260f          	jrne	L5104
8945  1b8a b6cb          	ld	a,_mess+11
8946  1b8c a166          	cp	a,#102
8947  1b8e 2609          	jrne	L5104
8950  1b90 be5b          	ldw	x,__x_
8951  1b92 1d0001        	subw	x,#1
8952  1b95 bf5b          	ldw	__x_,x
8954  1b97 200f          	jra	L3104
8955  1b99               L5104:
8956                     ; 1862 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8958  1b99 b6ca          	ld	a,_mess+10
8959  1b9b a177          	cp	a,#119
8960  1b9d 2609          	jrne	L3104
8962  1b9f b6cb          	ld	a,_mess+11
8963  1ba1 a177          	cp	a,#119
8964  1ba3 2603          	jrne	L3104
8967  1ba5 5f            	clrw	x
8968  1ba6 bf5b          	ldw	__x_,x
8969  1ba8               L3104:
8970                     ; 1863      gran(&_x_,-XMAX,XMAX);
8972  1ba8 ae0019        	ldw	x,#25
8973  1bab 89            	pushw	x
8974  1bac aeffe7        	ldw	x,#65511
8975  1baf 89            	pushw	x
8976  1bb0 ae005b        	ldw	x,#__x_
8977  1bb3 cd0000        	call	_gran
8979  1bb6 5b04          	addw	sp,#4
8981  1bb8 acc51cc5      	jpf	L7153
8982  1bbc               L7004:
8983                     ; 1865 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8985  1bbc b6c6          	ld	a,_mess+6
8986  1bbe c10001        	cp	a,_adress
8987  1bc1 2665          	jrne	L5204
8989  1bc3 b6c7          	ld	a,_mess+7
8990  1bc5 c10001        	cp	a,_adress
8991  1bc8 265e          	jrne	L5204
8993  1bca b6c8          	ld	a,_mess+8
8994  1bcc a116          	cp	a,#22
8995  1bce 2658          	jrne	L5204
8997  1bd0 b6c9          	ld	a,_mess+9
8998  1bd2 b1ca          	cp	a,_mess+10
8999  1bd4 2652          	jrne	L5204
9001  1bd6 b6c9          	ld	a,_mess+9
9002  1bd8 a1ee          	cp	a,#238
9003  1bda 264c          	jrne	L5204
9004                     ; 1867 	rotor_int++;
9006  1bdc be1a          	ldw	x,_rotor_int
9007  1bde 1c0001        	addw	x,#1
9008  1be1 bf1a          	ldw	_rotor_int,x
9009                     ; 1868      tempI=pwm_u;
9011  1be3 be0b          	ldw	x,_pwm_u
9012  1be5 1f04          	ldw	(OFST-1,sp),x
9013                     ; 1869 	ee_U_AVT=tempI;
9015  1be7 1e04          	ldw	x,(OFST-1,sp)
9016  1be9 89            	pushw	x
9017  1bea ae000a        	ldw	x,#_ee_U_AVT
9018  1bed cd0000        	call	c_eewrw
9020  1bf0 85            	popw	x
9021                     ; 1870 	UU_AVT=Un;
9023  1bf1 be69          	ldw	x,_Un
9024  1bf3 89            	pushw	x
9025  1bf4 ae0006        	ldw	x,#_UU_AVT
9026  1bf7 cd0000        	call	c_eewrw
9028  1bfa 85            	popw	x
9029                     ; 1871 	delay_ms(100);
9031  1bfb ae0064        	ldw	x,#100
9032  1bfe cd004c        	call	_delay_ms
9034                     ; 1872 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9036  1c01 ce000a        	ldw	x,_ee_U_AVT
9037  1c04 1304          	cpw	x,(OFST-1,sp)
9038  1c06 2703          	jreq	L042
9039  1c08 cc1cc5        	jp	L7153
9040  1c0b               L042:
9043  1c0b 4b00          	push	#0
9044  1c0d 4b00          	push	#0
9045  1c0f 4b00          	push	#0
9046  1c11 4b00          	push	#0
9047  1c13 4bdd          	push	#221
9048  1c15 4bdd          	push	#221
9049  1c17 4b91          	push	#145
9050  1c19 3b0001        	push	_adress
9051  1c1c ae018e        	ldw	x,#398
9052  1c1f cd14f5        	call	_can_transmit
9054  1c22 5b08          	addw	sp,#8
9055  1c24 acc51cc5      	jpf	L7153
9056  1c28               L5204:
9057                     ; 1877 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9059  1c28 b6c7          	ld	a,_mess+7
9060  1c2a a1da          	cp	a,#218
9061  1c2c 2652          	jrne	L3304
9063  1c2e b6c6          	ld	a,_mess+6
9064  1c30 c10001        	cp	a,_adress
9065  1c33 274b          	jreq	L3304
9067  1c35 b6c6          	ld	a,_mess+6
9068  1c37 a106          	cp	a,#6
9069  1c39 2445          	jruge	L3304
9070                     ; 1879 	i_main_bps_cnt[mess[6]]=0;
9072  1c3b b6c6          	ld	a,_mess+6
9073  1c3d 5f            	clrw	x
9074  1c3e 97            	ld	xl,a
9075  1c3f 6f06          	clr	(_i_main_bps_cnt,x)
9076                     ; 1880 	i_main_flag[mess[6]]=1;
9078  1c41 b6c6          	ld	a,_mess+6
9079  1c43 5f            	clrw	x
9080  1c44 97            	ld	xl,a
9081  1c45 a601          	ld	a,#1
9082  1c47 e711          	ld	(_i_main_flag,x),a
9083                     ; 1881 	if(bMAIN)
9085                     	btst	_bMAIN
9086  1c4e 2475          	jruge	L7153
9087                     ; 1883 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9089  1c50 b6c9          	ld	a,_mess+9
9090  1c52 5f            	clrw	x
9091  1c53 97            	ld	xl,a
9092  1c54 4f            	clr	a
9093  1c55 02            	rlwa	x,a
9094  1c56 1f01          	ldw	(OFST-4,sp),x
9095  1c58 b6c8          	ld	a,_mess+8
9096  1c5a 5f            	clrw	x
9097  1c5b 97            	ld	xl,a
9098  1c5c 72fb01        	addw	x,(OFST-4,sp)
9099  1c5f b6c6          	ld	a,_mess+6
9100  1c61 905f          	clrw	y
9101  1c63 9097          	ld	yl,a
9102  1c65 9058          	sllw	y
9103  1c67 90ef17        	ldw	(_i_main,y),x
9104                     ; 1884 		i_main[adress]=I;
9106  1c6a c60001        	ld	a,_adress
9107  1c6d 5f            	clrw	x
9108  1c6e 97            	ld	xl,a
9109  1c6f 58            	sllw	x
9110  1c70 90be6b        	ldw	y,_I
9111  1c73 ef17          	ldw	(_i_main,x),y
9112                     ; 1885      	i_main_flag[adress]=1;
9114  1c75 c60001        	ld	a,_adress
9115  1c78 5f            	clrw	x
9116  1c79 97            	ld	xl,a
9117  1c7a a601          	ld	a,#1
9118  1c7c e711          	ld	(_i_main_flag,x),a
9119  1c7e 2045          	jra	L7153
9120  1c80               L3304:
9121                     ; 1889 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9123  1c80 b6c7          	ld	a,_mess+7
9124  1c82 a1db          	cp	a,#219
9125  1c84 263f          	jrne	L7153
9127  1c86 b6c6          	ld	a,_mess+6
9128  1c88 c10001        	cp	a,_adress
9129  1c8b 2738          	jreq	L7153
9131  1c8d b6c6          	ld	a,_mess+6
9132  1c8f a106          	cp	a,#6
9133  1c91 2432          	jruge	L7153
9134                     ; 1891 	i_main_bps_cnt[mess[6]]=0;
9136  1c93 b6c6          	ld	a,_mess+6
9137  1c95 5f            	clrw	x
9138  1c96 97            	ld	xl,a
9139  1c97 6f06          	clr	(_i_main_bps_cnt,x)
9140                     ; 1892 	i_main_flag[mess[6]]=1;		
9142  1c99 b6c6          	ld	a,_mess+6
9143  1c9b 5f            	clrw	x
9144  1c9c 97            	ld	xl,a
9145  1c9d a601          	ld	a,#1
9146  1c9f e711          	ld	(_i_main_flag,x),a
9147                     ; 1893 	if(bMAIN)
9149                     	btst	_bMAIN
9150  1ca6 241d          	jruge	L7153
9151                     ; 1895 		if(mess[9]==0)i_main_flag[i]=1;
9153  1ca8 3dc9          	tnz	_mess+9
9154  1caa 260a          	jrne	L5404
9157  1cac 7b03          	ld	a,(OFST-2,sp)
9158  1cae 5f            	clrw	x
9159  1caf 97            	ld	xl,a
9160  1cb0 a601          	ld	a,#1
9161  1cb2 e711          	ld	(_i_main_flag,x),a
9163  1cb4 2006          	jra	L7404
9164  1cb6               L5404:
9165                     ; 1896 		else i_main_flag[i]=0;
9167  1cb6 7b03          	ld	a,(OFST-2,sp)
9168  1cb8 5f            	clrw	x
9169  1cb9 97            	ld	xl,a
9170  1cba 6f11          	clr	(_i_main_flag,x)
9171  1cbc               L7404:
9172                     ; 1897 		i_main_flag[adress]=1;
9174  1cbc c60001        	ld	a,_adress
9175  1cbf 5f            	clrw	x
9176  1cc0 97            	ld	xl,a
9177  1cc1 a601          	ld	a,#1
9178  1cc3 e711          	ld	(_i_main_flag,x),a
9179  1cc5               L7153:
9180                     ; 1903 can_in_an_end:
9180                     ; 1904 bCAN_RX=0;
9182  1cc5 3f09          	clr	_bCAN_RX
9183                     ; 1905 }   
9186  1cc7 5b05          	addw	sp,#5
9187  1cc9 81            	ret
9210                     ; 1908 void t4_init(void){
9211                     	switch	.text
9212  1cca               _t4_init:
9216                     ; 1909 	TIM4->PSCR = 4;
9218  1cca 35045345      	mov	21317,#4
9219                     ; 1910 	TIM4->ARR= 77;
9221  1cce 354d5346      	mov	21318,#77
9222                     ; 1911 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9224  1cd2 72105341      	bset	21313,#0
9225                     ; 1913 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9227  1cd6 35855340      	mov	21312,#133
9228                     ; 1915 }
9231  1cda 81            	ret
9254                     ; 1918 void t1_init(void)
9254                     ; 1919 {
9255                     	switch	.text
9256  1cdb               _t1_init:
9260                     ; 1920 TIM1->ARRH= 0x03;
9262  1cdb 35035262      	mov	21090,#3
9263                     ; 1921 TIM1->ARRL= 0xff;
9265  1cdf 35ff5263      	mov	21091,#255
9266                     ; 1922 TIM1->CCR1H= 0x00;	
9268  1ce3 725f5265      	clr	21093
9269                     ; 1923 TIM1->CCR1L= 0xff;
9271  1ce7 35ff5266      	mov	21094,#255
9272                     ; 1924 TIM1->CCR2H= 0x00;	
9274  1ceb 725f5267      	clr	21095
9275                     ; 1925 TIM1->CCR2L= 0x00;
9277  1cef 725f5268      	clr	21096
9278                     ; 1926 TIM1->CCR3H= 0x00;	
9280  1cf3 725f5269      	clr	21097
9281                     ; 1927 TIM1->CCR3L= 0x64;
9283  1cf7 3564526a      	mov	21098,#100
9284                     ; 1929 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9286  1cfb 35685258      	mov	21080,#104
9287                     ; 1930 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9289  1cff 35685259      	mov	21081,#104
9290                     ; 1931 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9292  1d03 3568525a      	mov	21082,#104
9293                     ; 1932 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9295  1d07 3511525c      	mov	21084,#17
9296                     ; 1933 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9298  1d0b 3501525d      	mov	21085,#1
9299                     ; 1934 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9301  1d0f 35815250      	mov	21072,#129
9302                     ; 1935 TIM1->BKR|= TIM1_BKR_AOE;
9304  1d13 721c526d      	bset	21101,#6
9305                     ; 1936 }
9308  1d17 81            	ret
9333                     ; 1940 void adc2_init(void)
9333                     ; 1941 {
9334                     	switch	.text
9335  1d18               _adc2_init:
9339                     ; 1942 adc_plazma[0]++;
9341  1d18 beb2          	ldw	x,_adc_plazma
9342  1d1a 1c0001        	addw	x,#1
9343  1d1d bfb2          	ldw	_adc_plazma,x
9344                     ; 1966 GPIOB->DDR&=~(1<<4);
9346  1d1f 72195007      	bres	20487,#4
9347                     ; 1967 GPIOB->CR1&=~(1<<4);
9349  1d23 72195008      	bres	20488,#4
9350                     ; 1968 GPIOB->CR2&=~(1<<4);
9352  1d27 72195009      	bres	20489,#4
9353                     ; 1970 GPIOB->DDR&=~(1<<5);
9355  1d2b 721b5007      	bres	20487,#5
9356                     ; 1971 GPIOB->CR1&=~(1<<5);
9358  1d2f 721b5008      	bres	20488,#5
9359                     ; 1972 GPIOB->CR2&=~(1<<5);
9361  1d33 721b5009      	bres	20489,#5
9362                     ; 1974 GPIOB->DDR&=~(1<<6);
9364  1d37 721d5007      	bres	20487,#6
9365                     ; 1975 GPIOB->CR1&=~(1<<6);
9367  1d3b 721d5008      	bres	20488,#6
9368                     ; 1976 GPIOB->CR2&=~(1<<6);
9370  1d3f 721d5009      	bres	20489,#6
9371                     ; 1978 GPIOB->DDR&=~(1<<7);
9373  1d43 721f5007      	bres	20487,#7
9374                     ; 1979 GPIOB->CR1&=~(1<<7);
9376  1d47 721f5008      	bres	20488,#7
9377                     ; 1980 GPIOB->CR2&=~(1<<7);
9379  1d4b 721f5009      	bres	20489,#7
9380                     ; 1990 ADC2->TDRL=0xff;
9382  1d4f 35ff5407      	mov	21511,#255
9383                     ; 1992 ADC2->CR2=0x08;
9385  1d53 35085402      	mov	21506,#8
9386                     ; 1993 ADC2->CR1=0x40;
9388  1d57 35405401      	mov	21505,#64
9389                     ; 1996 	ADC2->CSR=0x20+adc_ch+3;
9391  1d5b b6bf          	ld	a,_adc_ch
9392  1d5d ab23          	add	a,#35
9393  1d5f c75400        	ld	21504,a
9394                     ; 1998 	ADC2->CR1|=1;
9396  1d62 72105401      	bset	21505,#0
9397                     ; 1999 	ADC2->CR1|=1;
9399  1d66 72105401      	bset	21505,#0
9400                     ; 2002 adc_plazma[1]=adc_ch;
9402  1d6a b6bf          	ld	a,_adc_ch
9403  1d6c 5f            	clrw	x
9404  1d6d 97            	ld	xl,a
9405  1d6e bfb4          	ldw	_adc_plazma+2,x
9406                     ; 2003 }
9409  1d70 81            	ret
9443                     ; 2012 @far @interrupt void TIM4_UPD_Interrupt (void) 
9443                     ; 2013 {
9445                     	switch	.text
9446  1d71               f_TIM4_UPD_Interrupt:
9450                     ; 2014 TIM4->SR1&=~TIM4_SR1_UIF;
9452  1d71 72115342      	bres	21314,#0
9453                     ; 2016 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9455  1d75 3c05          	inc	_pwm_vent_cnt
9456  1d77 b605          	ld	a,_pwm_vent_cnt
9457  1d79 a10a          	cp	a,#10
9458  1d7b 2502          	jrult	L1114
9461  1d7d 3f05          	clr	_pwm_vent_cnt
9462  1d7f               L1114:
9463                     ; 2017 GPIOB->ODR|=(1<<3);
9465  1d7f 72165005      	bset	20485,#3
9466                     ; 2018 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9468  1d83 b605          	ld	a,_pwm_vent_cnt
9469  1d85 a105          	cp	a,#5
9470  1d87 2504          	jrult	L3114
9473  1d89 72175005      	bres	20485,#3
9474  1d8d               L3114:
9475                     ; 2023 if(++t0_cnt0>=100)
9477  1d8d 9c            	rvf
9478  1d8e be00          	ldw	x,_t0_cnt0
9479  1d90 1c0001        	addw	x,#1
9480  1d93 bf00          	ldw	_t0_cnt0,x
9481  1d95 a30064        	cpw	x,#100
9482  1d98 2f3f          	jrslt	L5114
9483                     ; 2025 	t0_cnt0=0;
9485  1d9a 5f            	clrw	x
9486  1d9b bf00          	ldw	_t0_cnt0,x
9487                     ; 2026 	b100Hz=1;
9489  1d9d 72100008      	bset	_b100Hz
9490                     ; 2028 	if(++t0_cnt1>=10)
9492  1da1 3c02          	inc	_t0_cnt1
9493  1da3 b602          	ld	a,_t0_cnt1
9494  1da5 a10a          	cp	a,#10
9495  1da7 2506          	jrult	L7114
9496                     ; 2030 		t0_cnt1=0;
9498  1da9 3f02          	clr	_t0_cnt1
9499                     ; 2031 		b10Hz=1;
9501  1dab 72100007      	bset	_b10Hz
9502  1daf               L7114:
9503                     ; 2034 	if(++t0_cnt2>=20)
9505  1daf 3c03          	inc	_t0_cnt2
9506  1db1 b603          	ld	a,_t0_cnt2
9507  1db3 a114          	cp	a,#20
9508  1db5 2506          	jrult	L1214
9509                     ; 2036 		t0_cnt2=0;
9511  1db7 3f03          	clr	_t0_cnt2
9512                     ; 2037 		b5Hz=1;
9514  1db9 72100006      	bset	_b5Hz
9515  1dbd               L1214:
9516                     ; 2041 	if(++t0_cnt4>=50)
9518  1dbd 3c05          	inc	_t0_cnt4
9519  1dbf b605          	ld	a,_t0_cnt4
9520  1dc1 a132          	cp	a,#50
9521  1dc3 2506          	jrult	L3214
9522                     ; 2043 		t0_cnt4=0;
9524  1dc5 3f05          	clr	_t0_cnt4
9525                     ; 2044 		b2Hz=1;
9527  1dc7 72100005      	bset	_b2Hz
9528  1dcb               L3214:
9529                     ; 2047 	if(++t0_cnt3>=100)
9531  1dcb 3c04          	inc	_t0_cnt3
9532  1dcd b604          	ld	a,_t0_cnt3
9533  1dcf a164          	cp	a,#100
9534  1dd1 2506          	jrult	L5114
9535                     ; 2049 		t0_cnt3=0;
9537  1dd3 3f04          	clr	_t0_cnt3
9538                     ; 2050 		b1Hz=1;
9540  1dd5 72100004      	bset	_b1Hz
9541  1dd9               L5114:
9542                     ; 2056 }
9545  1dd9 80            	iret
9570                     ; 2059 @far @interrupt void CAN_RX_Interrupt (void) 
9570                     ; 2060 {
9571                     	switch	.text
9572  1dda               f_CAN_RX_Interrupt:
9576                     ; 2062 CAN->PSR= 7;									// page 7 - read messsage
9578  1dda 35075427      	mov	21543,#7
9579                     ; 2064 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9581  1dde ae000e        	ldw	x,#14
9582  1de1               L452:
9583  1de1 d65427        	ld	a,(21543,x)
9584  1de4 e7bf          	ld	(_mess-1,x),a
9585  1de6 5a            	decw	x
9586  1de7 26f8          	jrne	L452
9587                     ; 2075 bCAN_RX=1;
9589  1de9 35010009      	mov	_bCAN_RX,#1
9590                     ; 2076 CAN->RFR|=(1<<5);
9592  1ded 721a5424      	bset	21540,#5
9593                     ; 2078 }
9596  1df1 80            	iret
9619                     ; 2081 @far @interrupt void CAN_TX_Interrupt (void) 
9619                     ; 2082 {
9620                     	switch	.text
9621  1df2               f_CAN_TX_Interrupt:
9625                     ; 2083 if((CAN->TSR)&(1<<0))
9627  1df2 c65422        	ld	a,21538
9628  1df5 a501          	bcp	a,#1
9629  1df7 2708          	jreq	L7414
9630                     ; 2085 	bTX_FREE=1;	
9632  1df9 35010008      	mov	_bTX_FREE,#1
9633                     ; 2087 	CAN->TSR|=(1<<0);
9635  1dfd 72105422      	bset	21538,#0
9636  1e01               L7414:
9637                     ; 2089 }
9640  1e01 80            	iret
9698                     ; 2092 @far @interrupt void ADC2_EOC_Interrupt (void) {
9699                     	switch	.text
9700  1e02               f_ADC2_EOC_Interrupt:
9702       00000009      OFST:	set	9
9703  1e02 be00          	ldw	x,c_x
9704  1e04 89            	pushw	x
9705  1e05 be00          	ldw	x,c_y
9706  1e07 89            	pushw	x
9707  1e08 be02          	ldw	x,c_lreg+2
9708  1e0a 89            	pushw	x
9709  1e0b be00          	ldw	x,c_lreg
9710  1e0d 89            	pushw	x
9711  1e0e 5209          	subw	sp,#9
9714                     ; 2097 adc_plazma[2]++;
9716  1e10 beb6          	ldw	x,_adc_plazma+4
9717  1e12 1c0001        	addw	x,#1
9718  1e15 bfb6          	ldw	_adc_plazma+4,x
9719                     ; 2104 ADC2->CSR&=~(1<<7);
9721  1e17 721f5400      	bres	21504,#7
9722                     ; 2106 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9724  1e1b c65405        	ld	a,21509
9725  1e1e b703          	ld	c_lreg+3,a
9726  1e20 3f02          	clr	c_lreg+2
9727  1e22 3f01          	clr	c_lreg+1
9728  1e24 3f00          	clr	c_lreg
9729  1e26 96            	ldw	x,sp
9730  1e27 1c0001        	addw	x,#OFST-8
9731  1e2a cd0000        	call	c_rtol
9733  1e2d c65404        	ld	a,21508
9734  1e30 5f            	clrw	x
9735  1e31 97            	ld	xl,a
9736  1e32 90ae0100      	ldw	y,#256
9737  1e36 cd0000        	call	c_umul
9739  1e39 96            	ldw	x,sp
9740  1e3a 1c0001        	addw	x,#OFST-8
9741  1e3d cd0000        	call	c_ladd
9743  1e40 96            	ldw	x,sp
9744  1e41 1c0006        	addw	x,#OFST-3
9745  1e44 cd0000        	call	c_rtol
9747                     ; 2111 if(adr_drv_stat==1)
9749  1e47 b607          	ld	a,_adr_drv_stat
9750  1e49 a101          	cp	a,#1
9751  1e4b 260b          	jrne	L7714
9752                     ; 2113 	adr_drv_stat=2;
9754  1e4d 35020007      	mov	_adr_drv_stat,#2
9755                     ; 2114 	adc_buff_[0]=temp_adc;
9757  1e51 1e08          	ldw	x,(OFST-1,sp)
9758  1e53 cf0005        	ldw	_adc_buff_,x
9760  1e56 2020          	jra	L1024
9761  1e58               L7714:
9762                     ; 2117 else if(adr_drv_stat==3)
9764  1e58 b607          	ld	a,_adr_drv_stat
9765  1e5a a103          	cp	a,#3
9766  1e5c 260b          	jrne	L3024
9767                     ; 2119 	adr_drv_stat=4;
9769  1e5e 35040007      	mov	_adr_drv_stat,#4
9770                     ; 2120 	adc_buff_[1]=temp_adc;
9772  1e62 1e08          	ldw	x,(OFST-1,sp)
9773  1e64 cf0007        	ldw	_adc_buff_+2,x
9775  1e67 200f          	jra	L1024
9776  1e69               L3024:
9777                     ; 2123 else if(adr_drv_stat==5)
9779  1e69 b607          	ld	a,_adr_drv_stat
9780  1e6b a105          	cp	a,#5
9781  1e6d 2609          	jrne	L1024
9782                     ; 2125 	adr_drv_stat=6;
9784  1e6f 35060007      	mov	_adr_drv_stat,#6
9785                     ; 2126 	adc_buff_[9]=temp_adc;
9787  1e73 1e08          	ldw	x,(OFST-1,sp)
9788  1e75 cf0017        	ldw	_adc_buff_+18,x
9789  1e78               L1024:
9790                     ; 2129 adc_buff[adc_ch][adc_cnt]=temp_adc;
9792  1e78 b6be          	ld	a,_adc_cnt
9793  1e7a 5f            	clrw	x
9794  1e7b 97            	ld	xl,a
9795  1e7c 58            	sllw	x
9796  1e7d 1f03          	ldw	(OFST-6,sp),x
9797  1e7f b6bf          	ld	a,_adc_ch
9798  1e81 97            	ld	xl,a
9799  1e82 a620          	ld	a,#32
9800  1e84 42            	mul	x,a
9801  1e85 72fb03        	addw	x,(OFST-6,sp)
9802  1e88 1608          	ldw	y,(OFST-1,sp)
9803  1e8a df0019        	ldw	(_adc_buff,x),y
9804                     ; 2135 adc_ch++;
9806  1e8d 3cbf          	inc	_adc_ch
9807                     ; 2136 if(adc_ch>=5)
9809  1e8f b6bf          	ld	a,_adc_ch
9810  1e91 a105          	cp	a,#5
9811  1e93 250c          	jrult	L1124
9812                     ; 2139 	adc_ch=0;
9814  1e95 3fbf          	clr	_adc_ch
9815                     ; 2140 	adc_cnt++;
9817  1e97 3cbe          	inc	_adc_cnt
9818                     ; 2141 	if(adc_cnt>=16)
9820  1e99 b6be          	ld	a,_adc_cnt
9821  1e9b a110          	cp	a,#16
9822  1e9d 2502          	jrult	L1124
9823                     ; 2143 		adc_cnt=0;
9825  1e9f 3fbe          	clr	_adc_cnt
9826  1ea1               L1124:
9827                     ; 2147 if((adc_cnt&0x03)==0)
9829  1ea1 b6be          	ld	a,_adc_cnt
9830  1ea3 a503          	bcp	a,#3
9831  1ea5 264b          	jrne	L5124
9832                     ; 2151 	tempSS=0;
9834  1ea7 ae0000        	ldw	x,#0
9835  1eaa 1f08          	ldw	(OFST-1,sp),x
9836  1eac ae0000        	ldw	x,#0
9837  1eaf 1f06          	ldw	(OFST-3,sp),x
9838                     ; 2152 	for(i=0;i<16;i++)
9840  1eb1 0f05          	clr	(OFST-4,sp)
9841  1eb3               L7124:
9842                     ; 2154 		tempSS+=(signed long)adc_buff[adc_ch][i];
9844  1eb3 7b05          	ld	a,(OFST-4,sp)
9845  1eb5 5f            	clrw	x
9846  1eb6 97            	ld	xl,a
9847  1eb7 58            	sllw	x
9848  1eb8 1f03          	ldw	(OFST-6,sp),x
9849  1eba b6bf          	ld	a,_adc_ch
9850  1ebc 97            	ld	xl,a
9851  1ebd a620          	ld	a,#32
9852  1ebf 42            	mul	x,a
9853  1ec0 72fb03        	addw	x,(OFST-6,sp)
9854  1ec3 de0019        	ldw	x,(_adc_buff,x)
9855  1ec6 cd0000        	call	c_itolx
9857  1ec9 96            	ldw	x,sp
9858  1eca 1c0006        	addw	x,#OFST-3
9859  1ecd cd0000        	call	c_lgadd
9861                     ; 2152 	for(i=0;i<16;i++)
9863  1ed0 0c05          	inc	(OFST-4,sp)
9866  1ed2 7b05          	ld	a,(OFST-4,sp)
9867  1ed4 a110          	cp	a,#16
9868  1ed6 25db          	jrult	L7124
9869                     ; 2156 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9871  1ed8 96            	ldw	x,sp
9872  1ed9 1c0006        	addw	x,#OFST-3
9873  1edc cd0000        	call	c_ltor
9875  1edf a604          	ld	a,#4
9876  1ee1 cd0000        	call	c_lrsh
9878  1ee4 be02          	ldw	x,c_lreg+2
9879  1ee6 b6bf          	ld	a,_adc_ch
9880  1ee8 905f          	clrw	y
9881  1eea 9097          	ld	yl,a
9882  1eec 9058          	sllw	y
9883  1eee 90df0005      	ldw	(_adc_buff_,y),x
9884  1ef2               L5124:
9885                     ; 2167 adc_plazma_short++;
9887  1ef2 bebc          	ldw	x,_adc_plazma_short
9888  1ef4 1c0001        	addw	x,#1
9889  1ef7 bfbc          	ldw	_adc_plazma_short,x
9890                     ; 2182 }
9893  1ef9 5b09          	addw	sp,#9
9894  1efb 85            	popw	x
9895  1efc bf00          	ldw	c_lreg,x
9896  1efe 85            	popw	x
9897  1eff bf02          	ldw	c_lreg+2,x
9898  1f01 85            	popw	x
9899  1f02 bf00          	ldw	c_y,x
9900  1f04 85            	popw	x
9901  1f05 bf00          	ldw	c_x,x
9902  1f07 80            	iret
9965                     ; 2190 main()
9965                     ; 2191 {
9967                     	switch	.text
9968  1f08               _main:
9972                     ; 2193 CLK->ECKR|=1;
9974  1f08 721050c1      	bset	20673,#0
9976  1f0c               L7324:
9977                     ; 2194 while((CLK->ECKR & 2) == 0);
9979  1f0c c650c1        	ld	a,20673
9980  1f0f a502          	bcp	a,#2
9981  1f11 27f9          	jreq	L7324
9982                     ; 2195 CLK->SWCR|=2;
9984  1f13 721250c5      	bset	20677,#1
9985                     ; 2196 CLK->SWR=0xB4;
9987  1f17 35b450c4      	mov	20676,#180
9988                     ; 2197 BLOCK_INIT
9990  1f1b 72145007      	bset	20487,#2
9993  1f1f 72145008      	bset	20488,#2
9996  1f23 72155009      	bres	20489,#2
9997                     ; 2198 BLOCK_ON
9999  1f27 72145005      	bset	20485,#2
10000                     ; 2200 delay_ms(200);
10002  1f2b ae00c8        	ldw	x,#200
10003  1f2e cd004c        	call	_delay_ms
10005                     ; 2201 FLASH_DUKR=0xae;
10007  1f31 35ae5064      	mov	_FLASH_DUKR,#174
10008                     ; 2202 FLASH_DUKR=0x56;
10010  1f35 35565064      	mov	_FLASH_DUKR,#86
10011                     ; 2203 enableInterrupts();
10014  1f39 9a            rim
10016                     ; 2226 adr_drv_v4();
10019  1f3a cd11d1        	call	_adr_drv_v4
10021                     ; 2230 t4_init();
10023  1f3d cd1cca        	call	_t4_init
10025                     ; 2232 		GPIOG->DDR|=(1<<0);
10027  1f40 72105020      	bset	20512,#0
10028                     ; 2233 		GPIOG->CR1|=(1<<0);
10030  1f44 72105021      	bset	20513,#0
10031                     ; 2234 		GPIOG->CR2&=~(1<<0);	
10033  1f48 72115022      	bres	20514,#0
10034                     ; 2237 		GPIOG->DDR&=~(1<<1);
10036  1f4c 72135020      	bres	20512,#1
10037                     ; 2238 		GPIOG->CR1|=(1<<1);
10039  1f50 72125021      	bset	20513,#1
10040                     ; 2239 		GPIOG->CR2&=~(1<<1);
10042  1f54 72135022      	bres	20514,#1
10043                     ; 2241 init_CAN();
10045  1f58 cd1486        	call	_init_CAN
10047                     ; 2246 GPIOC->DDR|=(1<<1);
10049  1f5b 7212500c      	bset	20492,#1
10050                     ; 2247 GPIOC->CR1|=(1<<1);
10052  1f5f 7212500d      	bset	20493,#1
10053                     ; 2248 GPIOC->CR2|=(1<<1);
10055  1f63 7212500e      	bset	20494,#1
10056                     ; 2250 GPIOC->DDR|=(1<<2);
10058  1f67 7214500c      	bset	20492,#2
10059                     ; 2251 GPIOC->CR1|=(1<<2);
10061  1f6b 7214500d      	bset	20493,#2
10062                     ; 2252 GPIOC->CR2|=(1<<2);
10064  1f6f 7214500e      	bset	20494,#2
10065                     ; 2259 t1_init();
10067  1f73 cd1cdb        	call	_t1_init
10069                     ; 2261 GPIOA->DDR|=(1<<5);
10071  1f76 721a5002      	bset	20482,#5
10072                     ; 2262 GPIOA->CR1|=(1<<5);
10074  1f7a 721a5003      	bset	20483,#5
10075                     ; 2263 GPIOA->CR2&=~(1<<5);
10077  1f7e 721b5004      	bres	20484,#5
10078                     ; 2269 GPIOB->DDR|=(1<<3);
10080  1f82 72165007      	bset	20487,#3
10081                     ; 2270 GPIOB->CR1|=(1<<3);
10083  1f86 72165008      	bset	20488,#3
10084                     ; 2271 GPIOB->CR2|=(1<<3);
10086  1f8a 72165009      	bset	20489,#3
10087                     ; 2273 GPIOC->DDR|=(1<<3);
10089  1f8e 7216500c      	bset	20492,#3
10090                     ; 2274 GPIOC->CR1|=(1<<3);
10092  1f92 7216500d      	bset	20493,#3
10093                     ; 2275 GPIOC->CR2|=(1<<3);
10095  1f96 7216500e      	bset	20494,#3
10096                     ; 2278 if(bps_class==bpsIPS) 
10098  1f9a b601          	ld	a,_bps_class
10099  1f9c a101          	cp	a,#1
10100  1f9e 260a          	jrne	L5424
10101                     ; 2280 	pwm_u=ee_U_AVT;
10103  1fa0 ce000a        	ldw	x,_ee_U_AVT
10104  1fa3 bf0b          	ldw	_pwm_u,x
10105                     ; 2281 	volum_u_main_=ee_U_AVT;
10107  1fa5 ce000a        	ldw	x,_ee_U_AVT
10108  1fa8 bf1c          	ldw	_volum_u_main_,x
10109  1faa               L5424:
10110                     ; 2288 	if(bCAN_RX)
10112  1faa 3d09          	tnz	_bCAN_RX
10113  1fac 2705          	jreq	L1524
10114                     ; 2290 		bCAN_RX=0;
10116  1fae 3f09          	clr	_bCAN_RX
10117                     ; 2291 		can_in_an();	
10119  1fb0 cd1691        	call	_can_in_an
10121  1fb3               L1524:
10122                     ; 2293 	if(b100Hz)
10124                     	btst	_b100Hz
10125  1fb8 241e          	jruge	L3524
10126                     ; 2295 		b100Hz=0;
10128  1fba 72110008      	bres	_b100Hz
10129                     ; 2304 		adc2_init();
10131  1fbe cd1d18        	call	_adc2_init
10133                     ; 2305 		can_tx_hndl();
10135  1fc1 cd1579        	call	_can_tx_hndl
10137                     ; 2307 		GPIOC->DDR|=(1<<7);
10139  1fc4 721e500c      	bset	20492,#7
10140                     ; 2308 		GPIOC->CR1|=(1<<7);
10142  1fc8 721e500d      	bset	20493,#7
10143                     ; 2309 		GPIOC->CR2|=(1<<7);
10145  1fcc 721e500e      	bset	20494,#7
10146                     ; 2310 		GPIOC->ODR^=(1<<7);
10148  1fd0 c6500a        	ld	a,20490
10149  1fd3 a880          	xor	a,	#128
10150  1fd5 c7500a        	ld	20490,a
10151  1fd8               L3524:
10152                     ; 2313 	if(b10Hz)
10154                     	btst	_b10Hz
10155  1fdd 2419          	jruge	L5524
10156                     ; 2315 		b10Hz=0;
10158  1fdf 72110007      	bres	_b10Hz
10159                     ; 2317           matemat();
10161  1fe3 cd0bca        	call	_matemat
10163                     ; 2318 	    	led_drv(); 
10165  1fe6 cd0711        	call	_led_drv
10167                     ; 2319 	     link_drv();
10169  1fe9 cd07ff        	call	_link_drv
10171                     ; 2320 	     pwr_hndl();		//вычисление воздействий на силу
10173  1fec cd0aae        	call	_pwr_hndl
10175                     ; 2321 	     JP_drv();
10177  1fef cd0774        	call	_JP_drv
10179                     ; 2322 	     flags_drv();
10181  1ff2 cd0f7d        	call	_flags_drv
10183                     ; 2323 		net_drv();
10185  1ff5 cd15e3        	call	_net_drv
10187  1ff8               L5524:
10188                     ; 2326 	if(b5Hz)
10190                     	btst	_b5Hz
10191  1ffd 240d          	jruge	L7524
10192                     ; 2328 		b5Hz=0;
10194  1fff 72110006      	bres	_b5Hz
10195                     ; 2330 		pwr_drv();		//воздействие на силу
10197  2003 cd09aa        	call	_pwr_drv
10199                     ; 2331 		led_hndl();
10201  2006 cd008e        	call	_led_hndl
10203                     ; 2333 		vent_drv();
10205  2009 cd084e        	call	_vent_drv
10207  200c               L7524:
10208                     ; 2336 	if(b2Hz)
10210                     	btst	_b2Hz
10211  2011 2404          	jruge	L1624
10212                     ; 2338 		b2Hz=0;
10214  2013 72110005      	bres	_b2Hz
10215  2017               L1624:
10216                     ; 2347 	if(b1Hz)
10218                     	btst	_b1Hz
10219  201c 248c          	jruge	L5424
10220                     ; 2349 		b1Hz=0;
10222  201e 72110004      	bres	_b1Hz
10223                     ; 2351 		temper_drv();			//вычисление аварий температуры
10225  2022 cd0ced        	call	_temper_drv
10227                     ; 2352 		u_drv();
10229  2025 cd0dc4        	call	_u_drv
10231                     ; 2353           x_drv();
10233  2028 cd0e64        	call	_x_drv
10235                     ; 2354           if(main_cnt<1000)main_cnt++;
10237  202b 9c            	rvf
10238  202c be4e          	ldw	x,_main_cnt
10239  202e a303e8        	cpw	x,#1000
10240  2031 2e07          	jrsge	L5624
10243  2033 be4e          	ldw	x,_main_cnt
10244  2035 1c0001        	addw	x,#1
10245  2038 bf4e          	ldw	_main_cnt,x
10246  203a               L5624:
10247                     ; 2355   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10249  203a b65f          	ld	a,_link
10250  203c a1aa          	cp	a,#170
10251  203e 2706          	jreq	L1724
10253  2040 b647          	ld	a,_jp_mode
10254  2042 a103          	cp	a,#3
10255  2044 2603          	jrne	L7624
10256  2046               L1724:
10259  2046 cd0ede        	call	_apv_hndl
10261  2049               L7624:
10262                     ; 2358   		can_error_cnt++;
10264  2049 3c6d          	inc	_can_error_cnt
10265                     ; 2359   		if(can_error_cnt>=10)
10267  204b b66d          	ld	a,_can_error_cnt
10268  204d a10a          	cp	a,#10
10269  204f 2505          	jrult	L3724
10270                     ; 2361   			can_error_cnt=0;
10272  2051 3f6d          	clr	_can_error_cnt
10273                     ; 2362 			init_CAN();
10275  2053 cd1486        	call	_init_CAN
10277  2056               L3724:
10278                     ; 2366 		volum_u_main_drv();
10280  2056 cd1333        	call	_volum_u_main_drv
10282                     ; 2368 		pwm_stat++;
10284  2059 3c04          	inc	_pwm_stat
10285                     ; 2369 		if(pwm_stat>=10)pwm_stat=0;
10287  205b b604          	ld	a,_pwm_stat
10288  205d a10a          	cp	a,#10
10289  205f 2502          	jrult	L5724
10292  2061 3f04          	clr	_pwm_stat
10293  2063               L5724:
10294                     ; 2370 adc_plazma_short++;
10296  2063 bebc          	ldw	x,_adc_plazma_short
10297  2065 1c0001        	addw	x,#1
10298  2068 bfbc          	ldw	_adc_plazma_short,x
10299  206a acaa1faa      	jpf	L5424
11313                     	xdef	_main
11314                     	xdef	f_ADC2_EOC_Interrupt
11315                     	xdef	f_CAN_TX_Interrupt
11316                     	xdef	f_CAN_RX_Interrupt
11317                     	xdef	f_TIM4_UPD_Interrupt
11318                     	xdef	_adc2_init
11319                     	xdef	_t1_init
11320                     	xdef	_t4_init
11321                     	xdef	_can_in_an
11322                     	xdef	_net_drv
11323                     	xdef	_can_tx_hndl
11324                     	xdef	_can_transmit
11325                     	xdef	_init_CAN
11326                     	xdef	_volum_u_main_drv
11327                     	xdef	_adr_drv_v4
11328                     	xdef	_adr_drv_v3
11329                     	xdef	_adr_gran
11330                     	xdef	_flags_drv
11331                     	xdef	_apv_hndl
11332                     	xdef	_apv_stop
11333                     	xdef	_apv_start
11334                     	xdef	_x_drv
11335                     	xdef	_u_drv
11336                     	xdef	_temper_drv
11337                     	xdef	_matemat
11338                     	xdef	_pwr_hndl
11339                     	xdef	_pwr_drv
11340                     	xdef	_vent_drv
11341                     	xdef	_link_drv
11342                     	xdef	_JP_drv
11343                     	xdef	_led_drv
11344                     	xdef	_led_hndl
11345                     	xdef	_delay_ms
11346                     	xdef	_granee
11347                     	xdef	_gran
11348                     .eeprom:	section	.data
11349  0000               _ee_IMAXVENT:
11350  0000 0000          	ds.b	2
11351                     	xdef	_ee_IMAXVENT
11352                     	switch	.ubsct
11353  0001               _bps_class:
11354  0001 00            	ds.b	1
11355                     	xdef	_bps_class
11356  0002               _vent_pwm:
11357  0002 0000          	ds.b	2
11358                     	xdef	_vent_pwm
11359  0004               _pwm_stat:
11360  0004 00            	ds.b	1
11361                     	xdef	_pwm_stat
11362  0005               _pwm_vent_cnt:
11363  0005 00            	ds.b	1
11364                     	xdef	_pwm_vent_cnt
11365                     	switch	.eeprom
11366  0002               _ee_DEVICE:
11367  0002 0000          	ds.b	2
11368                     	xdef	_ee_DEVICE
11369  0004               _ee_AVT_MODE:
11370  0004 0000          	ds.b	2
11371                     	xdef	_ee_AVT_MODE
11372                     	switch	.ubsct
11373  0006               _i_main_bps_cnt:
11374  0006 000000000000  	ds.b	6
11375                     	xdef	_i_main_bps_cnt
11376  000c               _i_main_sigma:
11377  000c 0000          	ds.b	2
11378                     	xdef	_i_main_sigma
11379  000e               _i_main_num_of_bps:
11380  000e 00            	ds.b	1
11381                     	xdef	_i_main_num_of_bps
11382  000f               _i_main_avg:
11383  000f 0000          	ds.b	2
11384                     	xdef	_i_main_avg
11385  0011               _i_main_flag:
11386  0011 000000000000  	ds.b	6
11387                     	xdef	_i_main_flag
11388  0017               _i_main:
11389  0017 000000000000  	ds.b	12
11390                     	xdef	_i_main
11391  0023               _x:
11392  0023 000000000000  	ds.b	12
11393                     	xdef	_x
11394                     	xdef	_volum_u_main_
11395                     	switch	.eeprom
11396  0006               _UU_AVT:
11397  0006 0000          	ds.b	2
11398                     	xdef	_UU_AVT
11399                     	switch	.ubsct
11400  002f               _cnt_net_drv:
11401  002f 00            	ds.b	1
11402                     	xdef	_cnt_net_drv
11403                     	switch	.bit
11404  0001               _bMAIN:
11405  0001 00            	ds.b	1
11406                     	xdef	_bMAIN
11407                     	switch	.ubsct
11408  0030               _plazma_int:
11409  0030 000000000000  	ds.b	6
11410                     	xdef	_plazma_int
11411                     	xdef	_rotor_int
11412  0036               _led_green_buff:
11413  0036 00000000      	ds.b	4
11414                     	xdef	_led_green_buff
11415  003a               _led_red_buff:
11416  003a 00000000      	ds.b	4
11417                     	xdef	_led_red_buff
11418                     	xdef	_led_drv_cnt
11419                     	xdef	_led_green
11420                     	xdef	_led_red
11421  003e               _res_fl_cnt:
11422  003e 00            	ds.b	1
11423                     	xdef	_res_fl_cnt
11424                     	xdef	_bRES_
11425                     	xdef	_bRES
11426                     	switch	.eeprom
11427  0008               _res_fl_:
11428  0008 00            	ds.b	1
11429                     	xdef	_res_fl_
11430  0009               _res_fl:
11431  0009 00            	ds.b	1
11432                     	xdef	_res_fl
11433                     	switch	.ubsct
11434  003f               _cnt_apv_off:
11435  003f 00            	ds.b	1
11436                     	xdef	_cnt_apv_off
11437                     	switch	.bit
11438  0002               _bAPV:
11439  0002 00            	ds.b	1
11440                     	xdef	_bAPV
11441                     	switch	.ubsct
11442  0040               _apv_cnt_:
11443  0040 0000          	ds.b	2
11444                     	xdef	_apv_cnt_
11445  0042               _apv_cnt:
11446  0042 000000        	ds.b	3
11447                     	xdef	_apv_cnt
11448                     	xdef	_bBL_IPS
11449                     	switch	.bit
11450  0003               _bBL:
11451  0003 00            	ds.b	1
11452                     	xdef	_bBL
11453                     	switch	.ubsct
11454  0045               _cnt_JP1:
11455  0045 00            	ds.b	1
11456                     	xdef	_cnt_JP1
11457  0046               _cnt_JP0:
11458  0046 00            	ds.b	1
11459                     	xdef	_cnt_JP0
11460  0047               _jp_mode:
11461  0047 00            	ds.b	1
11462                     	xdef	_jp_mode
11463                     	xdef	_pwm_i
11464                     	xdef	_pwm_u
11465  0048               _tmax_cnt:
11466  0048 0000          	ds.b	2
11467                     	xdef	_tmax_cnt
11468  004a               _tsign_cnt:
11469  004a 0000          	ds.b	2
11470                     	xdef	_tsign_cnt
11471                     	switch	.eeprom
11472  000a               _ee_U_AVT:
11473  000a 0000          	ds.b	2
11474                     	xdef	_ee_U_AVT
11475  000c               _ee_tsign:
11476  000c 0000          	ds.b	2
11477                     	xdef	_ee_tsign
11478  000e               _ee_tmax:
11479  000e 0000          	ds.b	2
11480                     	xdef	_ee_tmax
11481  0010               _ee_dU:
11482  0010 0000          	ds.b	2
11483                     	xdef	_ee_dU
11484  0012               _ee_Umax:
11485  0012 0000          	ds.b	2
11486                     	xdef	_ee_Umax
11487  0014               _ee_TZAS:
11488  0014 0000          	ds.b	2
11489                     	xdef	_ee_TZAS
11490                     	switch	.ubsct
11491  004c               _main_cnt1:
11492  004c 0000          	ds.b	2
11493                     	xdef	_main_cnt1
11494  004e               _main_cnt:
11495  004e 0000          	ds.b	2
11496                     	xdef	_main_cnt
11497  0050               _off_bp_cnt:
11498  0050 00            	ds.b	1
11499                     	xdef	_off_bp_cnt
11500  0051               _flags_tu_cnt_off:
11501  0051 00            	ds.b	1
11502                     	xdef	_flags_tu_cnt_off
11503  0052               _flags_tu_cnt_on:
11504  0052 00            	ds.b	1
11505                     	xdef	_flags_tu_cnt_on
11506  0053               _vol_i_temp:
11507  0053 0000          	ds.b	2
11508                     	xdef	_vol_i_temp
11509  0055               _vol_u_temp:
11510  0055 0000          	ds.b	2
11511                     	xdef	_vol_u_temp
11512                     	switch	.eeprom
11513  0016               __x_ee_:
11514  0016 0000          	ds.b	2
11515                     	xdef	__x_ee_
11516                     	switch	.ubsct
11517  0057               __x_cnt:
11518  0057 0000          	ds.b	2
11519                     	xdef	__x_cnt
11520  0059               __x__:
11521  0059 0000          	ds.b	2
11522                     	xdef	__x__
11523  005b               __x_:
11524  005b 0000          	ds.b	2
11525                     	xdef	__x_
11526  005d               _flags_tu:
11527  005d 00            	ds.b	1
11528                     	xdef	_flags_tu
11529                     	xdef	_flags
11530  005e               _link_cnt:
11531  005e 00            	ds.b	1
11532                     	xdef	_link_cnt
11533  005f               _link:
11534  005f 00            	ds.b	1
11535                     	xdef	_link
11536  0060               _umin_cnt:
11537  0060 0000          	ds.b	2
11538                     	xdef	_umin_cnt
11539  0062               _umax_cnt:
11540  0062 0000          	ds.b	2
11541                     	xdef	_umax_cnt
11542                     	switch	.eeprom
11543  0018               _ee_K:
11544  0018 000000000000  	ds.b	16
11545                     	xdef	_ee_K
11546                     	switch	.ubsct
11547  0064               _T:
11548  0064 00            	ds.b	1
11549                     	xdef	_T
11550  0065               _Udb:
11551  0065 0000          	ds.b	2
11552                     	xdef	_Udb
11553  0067               _Ui:
11554  0067 0000          	ds.b	2
11555                     	xdef	_Ui
11556  0069               _Un:
11557  0069 0000          	ds.b	2
11558                     	xdef	_Un
11559  006b               _I:
11560  006b 0000          	ds.b	2
11561                     	xdef	_I
11562  006d               _can_error_cnt:
11563  006d 00            	ds.b	1
11564                     	xdef	_can_error_cnt
11565                     	xdef	_bCAN_RX
11566  006e               _tx_busy_cnt:
11567  006e 00            	ds.b	1
11568                     	xdef	_tx_busy_cnt
11569                     	xdef	_bTX_FREE
11570  006f               _can_buff_rd_ptr:
11571  006f 00            	ds.b	1
11572                     	xdef	_can_buff_rd_ptr
11573  0070               _can_buff_wr_ptr:
11574  0070 00            	ds.b	1
11575                     	xdef	_can_buff_wr_ptr
11576  0071               _can_out_buff:
11577  0071 000000000000  	ds.b	64
11578                     	xdef	_can_out_buff
11579                     	switch	.bss
11580  0000               _adress_error:
11581  0000 00            	ds.b	1
11582                     	xdef	_adress_error
11583  0001               _adress:
11584  0001 00            	ds.b	1
11585                     	xdef	_adress
11586  0002               _adr:
11587  0002 000000        	ds.b	3
11588                     	xdef	_adr
11589                     	xdef	_adr_drv_stat
11590                     	xdef	_led_ind
11591                     	switch	.ubsct
11592  00b1               _led_ind_cnt:
11593  00b1 00            	ds.b	1
11594                     	xdef	_led_ind_cnt
11595  00b2               _adc_plazma:
11596  00b2 000000000000  	ds.b	10
11597                     	xdef	_adc_plazma
11598  00bc               _adc_plazma_short:
11599  00bc 0000          	ds.b	2
11600                     	xdef	_adc_plazma_short
11601  00be               _adc_cnt:
11602  00be 00            	ds.b	1
11603                     	xdef	_adc_cnt
11604  00bf               _adc_ch:
11605  00bf 00            	ds.b	1
11606                     	xdef	_adc_ch
11607                     	switch	.bss
11608  0005               _adc_buff_:
11609  0005 000000000000  	ds.b	20
11610                     	xdef	_adc_buff_
11611  0019               _adc_buff:
11612  0019 000000000000  	ds.b	320
11613                     	xdef	_adc_buff
11614                     	switch	.ubsct
11615  00c0               _mess:
11616  00c0 000000000000  	ds.b	14
11617                     	xdef	_mess
11618                     	switch	.bit
11619  0004               _b1Hz:
11620  0004 00            	ds.b	1
11621                     	xdef	_b1Hz
11622  0005               _b2Hz:
11623  0005 00            	ds.b	1
11624                     	xdef	_b2Hz
11625  0006               _b5Hz:
11626  0006 00            	ds.b	1
11627                     	xdef	_b5Hz
11628  0007               _b10Hz:
11629  0007 00            	ds.b	1
11630                     	xdef	_b10Hz
11631  0008               _b100Hz:
11632  0008 00            	ds.b	1
11633                     	xdef	_b100Hz
11634                     	xdef	_t0_cnt4
11635                     	xdef	_t0_cnt3
11636                     	xdef	_t0_cnt2
11637                     	xdef	_t0_cnt1
11638                     	xdef	_t0_cnt0
11639                     	xref.b	c_lreg
11640                     	xref.b	c_x
11641                     	xref.b	c_y
11661                     	xref	c_lrsh
11662                     	xref	c_lgadd
11663                     	xref	c_ladd
11664                     	xref	c_umul
11665                     	xref	c_lgmul
11666                     	xref	c_lgsub
11667                     	xref	c_lsbc
11668                     	xref	c_idiv
11669                     	xref	c_ldiv
11670                     	xref	c_itolx
11671                     	xref	c_eewrc
11672                     	xref	c_imul
11673                     	xref	c_lcmp
11674                     	xref	c_ltor
11675                     	xref	c_lgadc
11676                     	xref	c_rtol
11677                     	xref	c_vmul
11678                     	xref	c_eewrw
11679                     	end
