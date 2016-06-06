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
3796                     ; 526 if((flags&0b00011110)==0) GPIOB->ODR|=(1<<3); 	//Если нет аварий то реле под ток
3798  077f b60a          	ld	a,_flags
3799  0781 a51e          	bcp	a,#30
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
4806                     ; 802 		if((flags&0b00001010)==0)
4808  0b64 b60a          	ld	a,_flags
4809  0b66 a50a          	bcp	a,#10
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
4838                     ; 810 		else if(flags&0b00001010)
4840  0b8c b60a          	ld	a,_flags
4841  0b8e a50a          	bcp	a,#10
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
5452                     ; 954 void u_drv(void)		//1Hz
5452                     ; 955 { 
5453                     	switch	.text
5454  0df4               _u_drv:
5458                     ; 956 if(jp_mode!=jp3)
5460  0df4 b647          	ld	a,_jp_mode
5461  0df6 a103          	cp	a,#3
5462  0df8 2769          	jreq	L5752
5463                     ; 958 	if(Ui>ee_Umax)umax_cnt++;
5465  0dfa 9c            	rvf
5466  0dfb be67          	ldw	x,_Ui
5467  0dfd c30012        	cpw	x,_ee_Umax
5468  0e00 2d09          	jrsle	L7752
5471  0e02 be62          	ldw	x,_umax_cnt
5472  0e04 1c0001        	addw	x,#1
5473  0e07 bf62          	ldw	_umax_cnt,x
5475  0e09 2003          	jra	L1062
5476  0e0b               L7752:
5477                     ; 959 	else umax_cnt=0;
5479  0e0b 5f            	clrw	x
5480  0e0c bf62          	ldw	_umax_cnt,x
5481  0e0e               L1062:
5482                     ; 960 	gran(&umax_cnt,0,10);
5484  0e0e ae000a        	ldw	x,#10
5485  0e11 89            	pushw	x
5486  0e12 5f            	clrw	x
5487  0e13 89            	pushw	x
5488  0e14 ae0062        	ldw	x,#_umax_cnt
5489  0e17 cd0000        	call	_gran
5491  0e1a 5b04          	addw	sp,#4
5492                     ; 961 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5494  0e1c 9c            	rvf
5495  0e1d be62          	ldw	x,_umax_cnt
5496  0e1f a3000a        	cpw	x,#10
5497  0e22 2f04          	jrslt	L3062
5500  0e24 7216000a      	bset	_flags,#3
5501  0e28               L3062:
5502                     ; 964 	if((Ui<(ee_Umax-ee_dU))&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5504  0e28 9c            	rvf
5505  0e29 ce0012        	ldw	x,_ee_Umax
5506  0e2c 72b00010      	subw	x,_ee_dU
5507  0e30 b367          	cpw	x,_Ui
5508  0e32 2d10          	jrsle	L5062
5510  0e34 c65005        	ld	a,20485
5511  0e37 a504          	bcp	a,#4
5512  0e39 2609          	jrne	L5062
5515  0e3b be60          	ldw	x,_umin_cnt
5516  0e3d 1c0001        	addw	x,#1
5517  0e40 bf60          	ldw	_umin_cnt,x
5519  0e42 2003          	jra	L7062
5520  0e44               L5062:
5521                     ; 965 	else umin_cnt=0;
5523  0e44 5f            	clrw	x
5524  0e45 bf60          	ldw	_umin_cnt,x
5525  0e47               L7062:
5526                     ; 966 	gran(&umin_cnt,0,10);	
5528  0e47 ae000a        	ldw	x,#10
5529  0e4a 89            	pushw	x
5530  0e4b 5f            	clrw	x
5531  0e4c 89            	pushw	x
5532  0e4d ae0060        	ldw	x,#_umin_cnt
5533  0e50 cd0000        	call	_gran
5535  0e53 5b04          	addw	sp,#4
5536                     ; 967 	if(umin_cnt>=10)flags|=0b00010000;	  
5538  0e55 9c            	rvf
5539  0e56 be60          	ldw	x,_umin_cnt
5540  0e58 a3000a        	cpw	x,#10
5541  0e5b 2f6f          	jrslt	L3162
5544  0e5d 7218000a      	bset	_flags,#4
5545  0e61 2069          	jra	L3162
5546  0e63               L5752:
5547                     ; 969 else if(jp_mode==jp3)
5549  0e63 b647          	ld	a,_jp_mode
5550  0e65 a103          	cp	a,#3
5551  0e67 2663          	jrne	L3162
5552                     ; 971 	if(Ui>700)umax_cnt++;
5554  0e69 9c            	rvf
5555  0e6a be67          	ldw	x,_Ui
5556  0e6c a302bd        	cpw	x,#701
5557  0e6f 2f09          	jrslt	L7162
5560  0e71 be62          	ldw	x,_umax_cnt
5561  0e73 1c0001        	addw	x,#1
5562  0e76 bf62          	ldw	_umax_cnt,x
5564  0e78 2003          	jra	L1262
5565  0e7a               L7162:
5566                     ; 972 	else umax_cnt=0;
5568  0e7a 5f            	clrw	x
5569  0e7b bf62          	ldw	_umax_cnt,x
5570  0e7d               L1262:
5571                     ; 973 	gran(&umax_cnt,0,10);
5573  0e7d ae000a        	ldw	x,#10
5574  0e80 89            	pushw	x
5575  0e81 5f            	clrw	x
5576  0e82 89            	pushw	x
5577  0e83 ae0062        	ldw	x,#_umax_cnt
5578  0e86 cd0000        	call	_gran
5580  0e89 5b04          	addw	sp,#4
5581                     ; 974 	if(umax_cnt>=10)flags|=0b00001000;
5583  0e8b 9c            	rvf
5584  0e8c be62          	ldw	x,_umax_cnt
5585  0e8e a3000a        	cpw	x,#10
5586  0e91 2f04          	jrslt	L3262
5589  0e93 7216000a      	bset	_flags,#3
5590  0e97               L3262:
5591                     ; 977 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5593  0e97 9c            	rvf
5594  0e98 be67          	ldw	x,_Ui
5595  0e9a a300c8        	cpw	x,#200
5596  0e9d 2e10          	jrsge	L5262
5598  0e9f c65005        	ld	a,20485
5599  0ea2 a504          	bcp	a,#4
5600  0ea4 2609          	jrne	L5262
5603  0ea6 be60          	ldw	x,_umin_cnt
5604  0ea8 1c0001        	addw	x,#1
5605  0eab bf60          	ldw	_umin_cnt,x
5607  0ead 2003          	jra	L7262
5608  0eaf               L5262:
5609                     ; 978 	else umin_cnt=0;
5611  0eaf 5f            	clrw	x
5612  0eb0 bf60          	ldw	_umin_cnt,x
5613  0eb2               L7262:
5614                     ; 979 	gran(&umin_cnt,0,10);	
5616  0eb2 ae000a        	ldw	x,#10
5617  0eb5 89            	pushw	x
5618  0eb6 5f            	clrw	x
5619  0eb7 89            	pushw	x
5620  0eb8 ae0060        	ldw	x,#_umin_cnt
5621  0ebb cd0000        	call	_gran
5623  0ebe 5b04          	addw	sp,#4
5624                     ; 980 	if(umin_cnt>=10)flags|=0b00010000;	  
5626  0ec0 9c            	rvf
5627  0ec1 be60          	ldw	x,_umin_cnt
5628  0ec3 a3000a        	cpw	x,#10
5629  0ec6 2f04          	jrslt	L3162
5632  0ec8 7218000a      	bset	_flags,#4
5633  0ecc               L3162:
5634                     ; 982 }
5637  0ecc 81            	ret
5664                     ; 985 void x_drv(void)
5664                     ; 986 {
5665                     	switch	.text
5666  0ecd               _x_drv:
5670                     ; 987 if(_x__==_x_)
5672  0ecd be59          	ldw	x,__x__
5673  0ecf b35b          	cpw	x,__x_
5674  0ed1 262a          	jrne	L3462
5675                     ; 989 	if(_x_cnt<60)
5677  0ed3 9c            	rvf
5678  0ed4 be57          	ldw	x,__x_cnt
5679  0ed6 a3003c        	cpw	x,#60
5680  0ed9 2e25          	jrsge	L3562
5681                     ; 991 		_x_cnt++;
5683  0edb be57          	ldw	x,__x_cnt
5684  0edd 1c0001        	addw	x,#1
5685  0ee0 bf57          	ldw	__x_cnt,x
5686                     ; 992 		if(_x_cnt>=60)
5688  0ee2 9c            	rvf
5689  0ee3 be57          	ldw	x,__x_cnt
5690  0ee5 a3003c        	cpw	x,#60
5691  0ee8 2f16          	jrslt	L3562
5692                     ; 994 			if(_x_ee_!=_x_)_x_ee_=_x_;
5694  0eea ce0016        	ldw	x,__x_ee_
5695  0eed b35b          	cpw	x,__x_
5696  0eef 270f          	jreq	L3562
5699  0ef1 be5b          	ldw	x,__x_
5700  0ef3 89            	pushw	x
5701  0ef4 ae0016        	ldw	x,#__x_ee_
5702  0ef7 cd0000        	call	c_eewrw
5704  0efa 85            	popw	x
5705  0efb 2003          	jra	L3562
5706  0efd               L3462:
5707                     ; 999 else _x_cnt=0;
5709  0efd 5f            	clrw	x
5710  0efe bf57          	ldw	__x_cnt,x
5711  0f00               L3562:
5712                     ; 1001 if(_x_cnt>60) _x_cnt=0;	
5714  0f00 9c            	rvf
5715  0f01 be57          	ldw	x,__x_cnt
5716  0f03 a3003d        	cpw	x,#61
5717  0f06 2f03          	jrslt	L5562
5720  0f08 5f            	clrw	x
5721  0f09 bf57          	ldw	__x_cnt,x
5722  0f0b               L5562:
5723                     ; 1003 _x__=_x_;
5725  0f0b be5b          	ldw	x,__x_
5726  0f0d bf59          	ldw	__x__,x
5727                     ; 1004 }
5730  0f0f 81            	ret
5756                     ; 1007 void apv_start(void)
5756                     ; 1008 {
5757                     	switch	.text
5758  0f10               _apv_start:
5762                     ; 1009 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5764  0f10 3d42          	tnz	_apv_cnt
5765  0f12 2624          	jrne	L7662
5767  0f14 3d43          	tnz	_apv_cnt+1
5768  0f16 2620          	jrne	L7662
5770  0f18 3d44          	tnz	_apv_cnt+2
5771  0f1a 261c          	jrne	L7662
5773                     	btst	_bAPV
5774  0f21 2515          	jrult	L7662
5775                     ; 1011 	apv_cnt[0]=60;
5777  0f23 353c0042      	mov	_apv_cnt,#60
5778                     ; 1012 	apv_cnt[1]=60;
5780  0f27 353c0043      	mov	_apv_cnt+1,#60
5781                     ; 1013 	apv_cnt[2]=60;
5783  0f2b 353c0044      	mov	_apv_cnt+2,#60
5784                     ; 1014 	apv_cnt_=3600;
5786  0f2f ae0e10        	ldw	x,#3600
5787  0f32 bf40          	ldw	_apv_cnt_,x
5788                     ; 1015 	bAPV=1;	
5790  0f34 72100002      	bset	_bAPV
5791  0f38               L7662:
5792                     ; 1017 }
5795  0f38 81            	ret
5821                     ; 1020 void apv_stop(void)
5821                     ; 1021 {
5822                     	switch	.text
5823  0f39               _apv_stop:
5827                     ; 1022 apv_cnt[0]=0;
5829  0f39 3f42          	clr	_apv_cnt
5830                     ; 1023 apv_cnt[1]=0;
5832  0f3b 3f43          	clr	_apv_cnt+1
5833                     ; 1024 apv_cnt[2]=0;
5835  0f3d 3f44          	clr	_apv_cnt+2
5836                     ; 1025 apv_cnt_=0;	
5838  0f3f 5f            	clrw	x
5839  0f40 bf40          	ldw	_apv_cnt_,x
5840                     ; 1026 bAPV=0;
5842  0f42 72110002      	bres	_bAPV
5843                     ; 1027 }
5846  0f46 81            	ret
5881                     ; 1031 void apv_hndl(void)
5881                     ; 1032 {
5882                     	switch	.text
5883  0f47               _apv_hndl:
5887                     ; 1033 if(apv_cnt[0])
5889  0f47 3d42          	tnz	_apv_cnt
5890  0f49 271e          	jreq	L1172
5891                     ; 1035 	apv_cnt[0]--;
5893  0f4b 3a42          	dec	_apv_cnt
5894                     ; 1036 	if(apv_cnt[0]==0)
5896  0f4d 3d42          	tnz	_apv_cnt
5897  0f4f 265a          	jrne	L5172
5898                     ; 1038 		flags&=0b11100001;
5900  0f51 b60a          	ld	a,_flags
5901  0f53 a4e1          	and	a,#225
5902  0f55 b70a          	ld	_flags,a
5903                     ; 1039 		tsign_cnt=0;
5905  0f57 5f            	clrw	x
5906  0f58 bf4a          	ldw	_tsign_cnt,x
5907                     ; 1040 		tmax_cnt=0;
5909  0f5a 5f            	clrw	x
5910  0f5b bf48          	ldw	_tmax_cnt,x
5911                     ; 1041 		umax_cnt=0;
5913  0f5d 5f            	clrw	x
5914  0f5e bf62          	ldw	_umax_cnt,x
5915                     ; 1042 		umin_cnt=0;
5917  0f60 5f            	clrw	x
5918  0f61 bf60          	ldw	_umin_cnt,x
5919                     ; 1044 		led_drv_cnt=30;
5921  0f63 351e0019      	mov	_led_drv_cnt,#30
5922  0f67 2042          	jra	L5172
5923  0f69               L1172:
5924                     ; 1047 else if(apv_cnt[1])
5926  0f69 3d43          	tnz	_apv_cnt+1
5927  0f6b 271e          	jreq	L7172
5928                     ; 1049 	apv_cnt[1]--;
5930  0f6d 3a43          	dec	_apv_cnt+1
5931                     ; 1050 	if(apv_cnt[1]==0)
5933  0f6f 3d43          	tnz	_apv_cnt+1
5934  0f71 2638          	jrne	L5172
5935                     ; 1052 		flags&=0b11100001;
5937  0f73 b60a          	ld	a,_flags
5938  0f75 a4e1          	and	a,#225
5939  0f77 b70a          	ld	_flags,a
5940                     ; 1053 		tsign_cnt=0;
5942  0f79 5f            	clrw	x
5943  0f7a bf4a          	ldw	_tsign_cnt,x
5944                     ; 1054 		tmax_cnt=0;
5946  0f7c 5f            	clrw	x
5947  0f7d bf48          	ldw	_tmax_cnt,x
5948                     ; 1055 		umax_cnt=0;
5950  0f7f 5f            	clrw	x
5951  0f80 bf62          	ldw	_umax_cnt,x
5952                     ; 1056 		umin_cnt=0;
5954  0f82 5f            	clrw	x
5955  0f83 bf60          	ldw	_umin_cnt,x
5956                     ; 1058 		led_drv_cnt=30;
5958  0f85 351e0019      	mov	_led_drv_cnt,#30
5959  0f89 2020          	jra	L5172
5960  0f8b               L7172:
5961                     ; 1061 else if(apv_cnt[2])
5963  0f8b 3d44          	tnz	_apv_cnt+2
5964  0f8d 271c          	jreq	L5172
5965                     ; 1063 	apv_cnt[2]--;
5967  0f8f 3a44          	dec	_apv_cnt+2
5968                     ; 1064 	if(apv_cnt[2]==0)
5970  0f91 3d44          	tnz	_apv_cnt+2
5971  0f93 2616          	jrne	L5172
5972                     ; 1066 		flags&=0b11100001;
5974  0f95 b60a          	ld	a,_flags
5975  0f97 a4e1          	and	a,#225
5976  0f99 b70a          	ld	_flags,a
5977                     ; 1067 		tsign_cnt=0;
5979  0f9b 5f            	clrw	x
5980  0f9c bf4a          	ldw	_tsign_cnt,x
5981                     ; 1068 		tmax_cnt=0;
5983  0f9e 5f            	clrw	x
5984  0f9f bf48          	ldw	_tmax_cnt,x
5985                     ; 1069 		umax_cnt=0;
5987  0fa1 5f            	clrw	x
5988  0fa2 bf62          	ldw	_umax_cnt,x
5989                     ; 1070 		umin_cnt=0;          
5991  0fa4 5f            	clrw	x
5992  0fa5 bf60          	ldw	_umin_cnt,x
5993                     ; 1072 		led_drv_cnt=30;
5995  0fa7 351e0019      	mov	_led_drv_cnt,#30
5996  0fab               L5172:
5997                     ; 1076 if(apv_cnt_)
5999  0fab be40          	ldw	x,_apv_cnt_
6000  0fad 2712          	jreq	L1372
6001                     ; 1078 	apv_cnt_--;
6003  0faf be40          	ldw	x,_apv_cnt_
6004  0fb1 1d0001        	subw	x,#1
6005  0fb4 bf40          	ldw	_apv_cnt_,x
6006                     ; 1079 	if(apv_cnt_==0) 
6008  0fb6 be40          	ldw	x,_apv_cnt_
6009  0fb8 2607          	jrne	L1372
6010                     ; 1081 		bAPV=0;
6012  0fba 72110002      	bres	_bAPV
6013                     ; 1082 		apv_start();
6015  0fbe cd0f10        	call	_apv_start
6017  0fc1               L1372:
6018                     ; 1086 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6020  0fc1 be60          	ldw	x,_umin_cnt
6021  0fc3 261e          	jrne	L5372
6023  0fc5 be62          	ldw	x,_umax_cnt
6024  0fc7 261a          	jrne	L5372
6026  0fc9 c65005        	ld	a,20485
6027  0fcc a504          	bcp	a,#4
6028  0fce 2613          	jrne	L5372
6029                     ; 1088 	if(cnt_apv_off<20)
6031  0fd0 b63f          	ld	a,_cnt_apv_off
6032  0fd2 a114          	cp	a,#20
6033  0fd4 240f          	jruge	L3472
6034                     ; 1090 		cnt_apv_off++;
6036  0fd6 3c3f          	inc	_cnt_apv_off
6037                     ; 1091 		if(cnt_apv_off>=20)
6039  0fd8 b63f          	ld	a,_cnt_apv_off
6040  0fda a114          	cp	a,#20
6041  0fdc 2507          	jrult	L3472
6042                     ; 1093 			apv_stop();
6044  0fde cd0f39        	call	_apv_stop
6046  0fe1 2002          	jra	L3472
6047  0fe3               L5372:
6048                     ; 1097 else cnt_apv_off=0;	
6050  0fe3 3f3f          	clr	_cnt_apv_off
6051  0fe5               L3472:
6052                     ; 1099 }
6055  0fe5 81            	ret
6058                     	switch	.ubsct
6059  0000               L5472_flags_old:
6060  0000 00            	ds.b	1
6096                     ; 1102 void flags_drv(void)
6096                     ; 1103 {
6097                     	switch	.text
6098  0fe6               _flags_drv:
6102                     ; 1105 if(jp_mode!=jp3) 
6104  0fe6 b647          	ld	a,_jp_mode
6105  0fe8 a103          	cp	a,#3
6106  0fea 2723          	jreq	L5672
6107                     ; 1107 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6109  0fec b60a          	ld	a,_flags
6110  0fee a508          	bcp	a,#8
6111  0ff0 2706          	jreq	L3772
6113  0ff2 b600          	ld	a,L5472_flags_old
6114  0ff4 a508          	bcp	a,#8
6115  0ff6 270c          	jreq	L1772
6116  0ff8               L3772:
6118  0ff8 b60a          	ld	a,_flags
6119  0ffa a510          	bcp	a,#16
6120  0ffc 2726          	jreq	L7772
6122  0ffe b600          	ld	a,L5472_flags_old
6123  1000 a510          	bcp	a,#16
6124  1002 2620          	jrne	L7772
6125  1004               L1772:
6126                     ; 1109     		if(link==OFF)apv_start();
6128  1004 b65f          	ld	a,_link
6129  1006 a1aa          	cp	a,#170
6130  1008 261a          	jrne	L7772
6133  100a cd0f10        	call	_apv_start
6135  100d 2015          	jra	L7772
6136  100f               L5672:
6137                     ; 1112 else if(jp_mode==jp3) 
6139  100f b647          	ld	a,_jp_mode
6140  1011 a103          	cp	a,#3
6141  1013 260f          	jrne	L7772
6142                     ; 1114 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6144  1015 b60a          	ld	a,_flags
6145  1017 a508          	bcp	a,#8
6146  1019 2709          	jreq	L7772
6148  101b b600          	ld	a,L5472_flags_old
6149  101d a508          	bcp	a,#8
6150  101f 2603          	jrne	L7772
6151                     ; 1116     		apv_start();
6153  1021 cd0f10        	call	_apv_start
6155  1024               L7772:
6156                     ; 1119 flags_old=flags;
6158  1024 450a00        	mov	L5472_flags_old,_flags
6159                     ; 1121 } 
6162  1027 81            	ret
6197                     ; 1258 void adr_drv_v4(char in)
6197                     ; 1259 {
6198                     	switch	.text
6199  1028               _adr_drv_v4:
6203                     ; 1260 if(adress!=in)adress=in;
6205  1028 c10001        	cp	a,_adress
6206  102b 2703          	jreq	L3203
6209  102d c70001        	ld	_adress,a
6210  1030               L3203:
6211                     ; 1261 }
6214  1030 81            	ret
6243                     ; 1264 void adr_drv_v3(void)
6243                     ; 1265 {
6244                     	switch	.text
6245  1031               _adr_drv_v3:
6247  1031 88            	push	a
6248       00000001      OFST:	set	1
6251                     ; 1271 GPIOB->DDR&=~(1<<0);
6253  1032 72115007      	bres	20487,#0
6254                     ; 1272 GPIOB->CR1&=~(1<<0);
6256  1036 72115008      	bres	20488,#0
6257                     ; 1273 GPIOB->CR2&=~(1<<0);
6259  103a 72115009      	bres	20489,#0
6260                     ; 1274 ADC2->CR2=0x08;
6262  103e 35085402      	mov	21506,#8
6263                     ; 1275 ADC2->CR1=0x40;
6265  1042 35405401      	mov	21505,#64
6266                     ; 1276 ADC2->CSR=0x20+0;
6268  1046 35205400      	mov	21504,#32
6269                     ; 1277 ADC2->CR1|=1;
6271  104a 72105401      	bset	21505,#0
6272                     ; 1278 ADC2->CR1|=1;
6274  104e 72105401      	bset	21505,#0
6275                     ; 1279 adr_drv_stat=1;
6277  1052 35010007      	mov	_adr_drv_stat,#1
6278  1056               L5303:
6279                     ; 1280 while(adr_drv_stat==1);
6282  1056 b607          	ld	a,_adr_drv_stat
6283  1058 a101          	cp	a,#1
6284  105a 27fa          	jreq	L5303
6285                     ; 1282 GPIOB->DDR&=~(1<<1);
6287  105c 72135007      	bres	20487,#1
6288                     ; 1283 GPIOB->CR1&=~(1<<1);
6290  1060 72135008      	bres	20488,#1
6291                     ; 1284 GPIOB->CR2&=~(1<<1);
6293  1064 72135009      	bres	20489,#1
6294                     ; 1285 ADC2->CR2=0x08;
6296  1068 35085402      	mov	21506,#8
6297                     ; 1286 ADC2->CR1=0x40;
6299  106c 35405401      	mov	21505,#64
6300                     ; 1287 ADC2->CSR=0x20+1;
6302  1070 35215400      	mov	21504,#33
6303                     ; 1288 ADC2->CR1|=1;
6305  1074 72105401      	bset	21505,#0
6306                     ; 1289 ADC2->CR1|=1;
6308  1078 72105401      	bset	21505,#0
6309                     ; 1290 adr_drv_stat=3;
6311  107c 35030007      	mov	_adr_drv_stat,#3
6312  1080               L3403:
6313                     ; 1291 while(adr_drv_stat==3);
6316  1080 b607          	ld	a,_adr_drv_stat
6317  1082 a103          	cp	a,#3
6318  1084 27fa          	jreq	L3403
6319                     ; 1293 GPIOE->DDR&=~(1<<6);
6321  1086 721d5016      	bres	20502,#6
6322                     ; 1294 GPIOE->CR1&=~(1<<6);
6324  108a 721d5017      	bres	20503,#6
6325                     ; 1295 GPIOE->CR2&=~(1<<6);
6327  108e 721d5018      	bres	20504,#6
6328                     ; 1296 ADC2->CR2=0x08;
6330  1092 35085402      	mov	21506,#8
6331                     ; 1297 ADC2->CR1=0x40;
6333  1096 35405401      	mov	21505,#64
6334                     ; 1298 ADC2->CSR=0x20+9;
6336  109a 35295400      	mov	21504,#41
6337                     ; 1299 ADC2->CR1|=1;
6339  109e 72105401      	bset	21505,#0
6340                     ; 1300 ADC2->CR1|=1;
6342  10a2 72105401      	bset	21505,#0
6343                     ; 1301 adr_drv_stat=5;
6345  10a6 35050007      	mov	_adr_drv_stat,#5
6346  10aa               L1503:
6347                     ; 1302 while(adr_drv_stat==5);
6350  10aa b607          	ld	a,_adr_drv_stat
6351  10ac a105          	cp	a,#5
6352  10ae 27fa          	jreq	L1503
6353                     ; 1306 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6355  10b0 9c            	rvf
6356  10b1 ce0005        	ldw	x,_adc_buff_
6357  10b4 a3022a        	cpw	x,#554
6358  10b7 2f0f          	jrslt	L7503
6360  10b9 9c            	rvf
6361  10ba ce0005        	ldw	x,_adc_buff_
6362  10bd a30253        	cpw	x,#595
6363  10c0 2e06          	jrsge	L7503
6366  10c2 725f0002      	clr	_adr
6368  10c6 204c          	jra	L1603
6369  10c8               L7503:
6370                     ; 1307 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6372  10c8 9c            	rvf
6373  10c9 ce0005        	ldw	x,_adc_buff_
6374  10cc a3036d        	cpw	x,#877
6375  10cf 2f0f          	jrslt	L3603
6377  10d1 9c            	rvf
6378  10d2 ce0005        	ldw	x,_adc_buff_
6379  10d5 a30396        	cpw	x,#918
6380  10d8 2e06          	jrsge	L3603
6383  10da 35010002      	mov	_adr,#1
6385  10de 2034          	jra	L1603
6386  10e0               L3603:
6387                     ; 1308 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6389  10e0 9c            	rvf
6390  10e1 ce0005        	ldw	x,_adc_buff_
6391  10e4 a302a3        	cpw	x,#675
6392  10e7 2f0f          	jrslt	L7603
6394  10e9 9c            	rvf
6395  10ea ce0005        	ldw	x,_adc_buff_
6396  10ed a302cc        	cpw	x,#716
6397  10f0 2e06          	jrsge	L7603
6400  10f2 35020002      	mov	_adr,#2
6402  10f6 201c          	jra	L1603
6403  10f8               L7603:
6404                     ; 1309 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6406  10f8 9c            	rvf
6407  10f9 ce0005        	ldw	x,_adc_buff_
6408  10fc a303e3        	cpw	x,#995
6409  10ff 2f0f          	jrslt	L3703
6411  1101 9c            	rvf
6412  1102 ce0005        	ldw	x,_adc_buff_
6413  1105 a3040c        	cpw	x,#1036
6414  1108 2e06          	jrsge	L3703
6417  110a 35030002      	mov	_adr,#3
6419  110e 2004          	jra	L1603
6420  1110               L3703:
6421                     ; 1310 else adr[0]=5;
6423  1110 35050002      	mov	_adr,#5
6424  1114               L1603:
6425                     ; 1312 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6427  1114 9c            	rvf
6428  1115 ce0007        	ldw	x,_adc_buff_+2
6429  1118 a3022a        	cpw	x,#554
6430  111b 2f0f          	jrslt	L7703
6432  111d 9c            	rvf
6433  111e ce0007        	ldw	x,_adc_buff_+2
6434  1121 a30253        	cpw	x,#595
6435  1124 2e06          	jrsge	L7703
6438  1126 725f0003      	clr	_adr+1
6440  112a 204c          	jra	L1013
6441  112c               L7703:
6442                     ; 1313 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6444  112c 9c            	rvf
6445  112d ce0007        	ldw	x,_adc_buff_+2
6446  1130 a3036d        	cpw	x,#877
6447  1133 2f0f          	jrslt	L3013
6449  1135 9c            	rvf
6450  1136 ce0007        	ldw	x,_adc_buff_+2
6451  1139 a30396        	cpw	x,#918
6452  113c 2e06          	jrsge	L3013
6455  113e 35010003      	mov	_adr+1,#1
6457  1142 2034          	jra	L1013
6458  1144               L3013:
6459                     ; 1314 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6461  1144 9c            	rvf
6462  1145 ce0007        	ldw	x,_adc_buff_+2
6463  1148 a302a3        	cpw	x,#675
6464  114b 2f0f          	jrslt	L7013
6466  114d 9c            	rvf
6467  114e ce0007        	ldw	x,_adc_buff_+2
6468  1151 a302cc        	cpw	x,#716
6469  1154 2e06          	jrsge	L7013
6472  1156 35020003      	mov	_adr+1,#2
6474  115a 201c          	jra	L1013
6475  115c               L7013:
6476                     ; 1315 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6478  115c 9c            	rvf
6479  115d ce0007        	ldw	x,_adc_buff_+2
6480  1160 a303e3        	cpw	x,#995
6481  1163 2f0f          	jrslt	L3113
6483  1165 9c            	rvf
6484  1166 ce0007        	ldw	x,_adc_buff_+2
6485  1169 a3040c        	cpw	x,#1036
6486  116c 2e06          	jrsge	L3113
6489  116e 35030003      	mov	_adr+1,#3
6491  1172 2004          	jra	L1013
6492  1174               L3113:
6493                     ; 1316 else adr[1]=5;
6495  1174 35050003      	mov	_adr+1,#5
6496  1178               L1013:
6497                     ; 1318 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6499  1178 9c            	rvf
6500  1179 ce0017        	ldw	x,_adc_buff_+18
6501  117c a3022a        	cpw	x,#554
6502  117f 2f0f          	jrslt	L7113
6504  1181 9c            	rvf
6505  1182 ce0017        	ldw	x,_adc_buff_+18
6506  1185 a30253        	cpw	x,#595
6507  1188 2e06          	jrsge	L7113
6510  118a 725f0004      	clr	_adr+2
6512  118e 204c          	jra	L1213
6513  1190               L7113:
6514                     ; 1319 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6516  1190 9c            	rvf
6517  1191 ce0017        	ldw	x,_adc_buff_+18
6518  1194 a3036d        	cpw	x,#877
6519  1197 2f0f          	jrslt	L3213
6521  1199 9c            	rvf
6522  119a ce0017        	ldw	x,_adc_buff_+18
6523  119d a30396        	cpw	x,#918
6524  11a0 2e06          	jrsge	L3213
6527  11a2 35010004      	mov	_adr+2,#1
6529  11a6 2034          	jra	L1213
6530  11a8               L3213:
6531                     ; 1320 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6533  11a8 9c            	rvf
6534  11a9 ce0017        	ldw	x,_adc_buff_+18
6535  11ac a302a3        	cpw	x,#675
6536  11af 2f0f          	jrslt	L7213
6538  11b1 9c            	rvf
6539  11b2 ce0017        	ldw	x,_adc_buff_+18
6540  11b5 a302cc        	cpw	x,#716
6541  11b8 2e06          	jrsge	L7213
6544  11ba 35020004      	mov	_adr+2,#2
6546  11be 201c          	jra	L1213
6547  11c0               L7213:
6548                     ; 1321 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6550  11c0 9c            	rvf
6551  11c1 ce0017        	ldw	x,_adc_buff_+18
6552  11c4 a303e3        	cpw	x,#995
6553  11c7 2f0f          	jrslt	L3313
6555  11c9 9c            	rvf
6556  11ca ce0017        	ldw	x,_adc_buff_+18
6557  11cd a3040c        	cpw	x,#1036
6558  11d0 2e06          	jrsge	L3313
6561  11d2 35030004      	mov	_adr+2,#3
6563  11d6 2004          	jra	L1213
6564  11d8               L3313:
6565                     ; 1322 else adr[2]=5;
6567  11d8 35050004      	mov	_adr+2,#5
6568  11dc               L1213:
6569                     ; 1326 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6571  11dc c60002        	ld	a,_adr
6572  11df a105          	cp	a,#5
6573  11e1 270e          	jreq	L1413
6575  11e3 c60003        	ld	a,_adr+1
6576  11e6 a105          	cp	a,#5
6577  11e8 2707          	jreq	L1413
6579  11ea c60004        	ld	a,_adr+2
6580  11ed a105          	cp	a,#5
6581  11ef 2606          	jrne	L7313
6582  11f1               L1413:
6583                     ; 1329 	adress_error=1;
6585  11f1 35010000      	mov	_adress_error,#1
6587  11f5               L5413:
6588                     ; 1340 }
6591  11f5 84            	pop	a
6592  11f6 81            	ret
6593  11f7               L7313:
6594                     ; 1333 	if(adr[2]&0x02) bps_class=bpsIPS;
6596  11f7 c60004        	ld	a,_adr+2
6597  11fa a502          	bcp	a,#2
6598  11fc 2706          	jreq	L7413
6601  11fe 35010001      	mov	_bps_class,#1
6603  1202 2002          	jra	L1513
6604  1204               L7413:
6605                     ; 1334 	else bps_class=bpsIBEP;
6607  1204 3f01          	clr	_bps_class
6608  1206               L1513:
6609                     ; 1336 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6611  1206 c60004        	ld	a,_adr+2
6612  1209 a401          	and	a,#1
6613  120b 97            	ld	xl,a
6614  120c a610          	ld	a,#16
6615  120e 42            	mul	x,a
6616  120f 9f            	ld	a,xl
6617  1210 6b01          	ld	(OFST+0,sp),a
6618  1212 c60003        	ld	a,_adr+1
6619  1215 48            	sll	a
6620  1216 48            	sll	a
6621  1217 cb0002        	add	a,_adr
6622  121a 1b01          	add	a,(OFST+0,sp)
6623  121c c70001        	ld	_adress,a
6624  121f 20d4          	jra	L5413
6668                     ; 1343 void volum_u_main_drv(void)
6668                     ; 1344 {
6669                     	switch	.text
6670  1221               _volum_u_main_drv:
6672  1221 88            	push	a
6673       00000001      OFST:	set	1
6676                     ; 1347 if(bMAIN)
6678                     	btst	_bMAIN
6679  1227 2503          	jrult	L031
6680  1229 cc1372        	jp	L1713
6681  122c               L031:
6682                     ; 1349 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6684  122c 9c            	rvf
6685  122d ce0006        	ldw	x,_UU_AVT
6686  1230 1d000a        	subw	x,#10
6687  1233 b369          	cpw	x,_Un
6688  1235 2d09          	jrsle	L3713
6691  1237 be1c          	ldw	x,_volum_u_main_
6692  1239 1c0005        	addw	x,#5
6693  123c bf1c          	ldw	_volum_u_main_,x
6695  123e 2036          	jra	L5713
6696  1240               L3713:
6697                     ; 1350 	else if(Un<(UU_AVT-1))volum_u_main_++;
6699  1240 9c            	rvf
6700  1241 ce0006        	ldw	x,_UU_AVT
6701  1244 5a            	decw	x
6702  1245 b369          	cpw	x,_Un
6703  1247 2d09          	jrsle	L7713
6706  1249 be1c          	ldw	x,_volum_u_main_
6707  124b 1c0001        	addw	x,#1
6708  124e bf1c          	ldw	_volum_u_main_,x
6710  1250 2024          	jra	L5713
6711  1252               L7713:
6712                     ; 1351 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
6714  1252 9c            	rvf
6715  1253 ce0006        	ldw	x,_UU_AVT
6716  1256 1c000a        	addw	x,#10
6717  1259 b369          	cpw	x,_Un
6718  125b 2e09          	jrsge	L3023
6721  125d be1c          	ldw	x,_volum_u_main_
6722  125f 1d000a        	subw	x,#10
6723  1262 bf1c          	ldw	_volum_u_main_,x
6725  1264 2010          	jra	L5713
6726  1266               L3023:
6727                     ; 1352 	else if(Un>(UU_AVT+1))volum_u_main_--;
6729  1266 9c            	rvf
6730  1267 ce0006        	ldw	x,_UU_AVT
6731  126a 5c            	incw	x
6732  126b b369          	cpw	x,_Un
6733  126d 2e07          	jrsge	L5713
6736  126f be1c          	ldw	x,_volum_u_main_
6737  1271 1d0001        	subw	x,#1
6738  1274 bf1c          	ldw	_volum_u_main_,x
6739  1276               L5713:
6740                     ; 1353 	if(volum_u_main_>1020)volum_u_main_=1020;
6742  1276 9c            	rvf
6743  1277 be1c          	ldw	x,_volum_u_main_
6744  1279 a303fd        	cpw	x,#1021
6745  127c 2f05          	jrslt	L1123
6748  127e ae03fc        	ldw	x,#1020
6749  1281 bf1c          	ldw	_volum_u_main_,x
6750  1283               L1123:
6751                     ; 1354 	if(volum_u_main_<0)volum_u_main_=0;
6753  1283 9c            	rvf
6754  1284 be1c          	ldw	x,_volum_u_main_
6755  1286 2e03          	jrsge	L3123
6758  1288 5f            	clrw	x
6759  1289 bf1c          	ldw	_volum_u_main_,x
6760  128b               L3123:
6761                     ; 1357 	i_main_sigma=0;
6763  128b 5f            	clrw	x
6764  128c bf0c          	ldw	_i_main_sigma,x
6765                     ; 1358 	i_main_num_of_bps=0;
6767  128e 3f0e          	clr	_i_main_num_of_bps
6768                     ; 1359 	for(i=0;i<6;i++)
6770  1290 0f01          	clr	(OFST+0,sp)
6771  1292               L5123:
6772                     ; 1361 		if(i_main_flag[i])
6774  1292 7b01          	ld	a,(OFST+0,sp)
6775  1294 5f            	clrw	x
6776  1295 97            	ld	xl,a
6777  1296 6d11          	tnz	(_i_main_flag,x)
6778  1298 2719          	jreq	L3223
6779                     ; 1363 			i_main_sigma+=i_main[i];
6781  129a 7b01          	ld	a,(OFST+0,sp)
6782  129c 5f            	clrw	x
6783  129d 97            	ld	xl,a
6784  129e 58            	sllw	x
6785  129f ee17          	ldw	x,(_i_main,x)
6786  12a1 72bb000c      	addw	x,_i_main_sigma
6787  12a5 bf0c          	ldw	_i_main_sigma,x
6788                     ; 1364 			i_main_flag[i]=1;
6790  12a7 7b01          	ld	a,(OFST+0,sp)
6791  12a9 5f            	clrw	x
6792  12aa 97            	ld	xl,a
6793  12ab a601          	ld	a,#1
6794  12ad e711          	ld	(_i_main_flag,x),a
6795                     ; 1365 			i_main_num_of_bps++;
6797  12af 3c0e          	inc	_i_main_num_of_bps
6799  12b1 2006          	jra	L5223
6800  12b3               L3223:
6801                     ; 1369 			i_main_flag[i]=0;	
6803  12b3 7b01          	ld	a,(OFST+0,sp)
6804  12b5 5f            	clrw	x
6805  12b6 97            	ld	xl,a
6806  12b7 6f11          	clr	(_i_main_flag,x)
6807  12b9               L5223:
6808                     ; 1359 	for(i=0;i<6;i++)
6810  12b9 0c01          	inc	(OFST+0,sp)
6813  12bb 7b01          	ld	a,(OFST+0,sp)
6814  12bd a106          	cp	a,#6
6815  12bf 25d1          	jrult	L5123
6816                     ; 1372 	i_main_avg=i_main_sigma/i_main_num_of_bps;
6818  12c1 be0c          	ldw	x,_i_main_sigma
6819  12c3 b60e          	ld	a,_i_main_num_of_bps
6820  12c5 905f          	clrw	y
6821  12c7 9097          	ld	yl,a
6822  12c9 cd0000        	call	c_idiv
6824  12cc bf0f          	ldw	_i_main_avg,x
6825                     ; 1373 	for(i=0;i<6;i++)
6827  12ce 0f01          	clr	(OFST+0,sp)
6828  12d0               L7223:
6829                     ; 1375 		if(i_main_flag[i])
6831  12d0 7b01          	ld	a,(OFST+0,sp)
6832  12d2 5f            	clrw	x
6833  12d3 97            	ld	xl,a
6834  12d4 6d11          	tnz	(_i_main_flag,x)
6835  12d6 2603cc1367    	jreq	L5323
6836                     ; 1377 			if(i_main[i]<(i_main_avg-10))x[i]++;
6838  12db 9c            	rvf
6839  12dc 7b01          	ld	a,(OFST+0,sp)
6840  12de 5f            	clrw	x
6841  12df 97            	ld	xl,a
6842  12e0 58            	sllw	x
6843  12e1 90be0f        	ldw	y,_i_main_avg
6844  12e4 72a2000a      	subw	y,#10
6845  12e8 90bf00        	ldw	c_y,y
6846  12eb 9093          	ldw	y,x
6847  12ed 90ee17        	ldw	y,(_i_main,y)
6848  12f0 90b300        	cpw	y,c_y
6849  12f3 2e11          	jrsge	L7323
6852  12f5 7b01          	ld	a,(OFST+0,sp)
6853  12f7 5f            	clrw	x
6854  12f8 97            	ld	xl,a
6855  12f9 58            	sllw	x
6856  12fa 9093          	ldw	y,x
6857  12fc ee23          	ldw	x,(_x,x)
6858  12fe 1c0001        	addw	x,#1
6859  1301 90ef23        	ldw	(_x,y),x
6861  1304 2029          	jra	L1423
6862  1306               L7323:
6863                     ; 1378 			else if(i_main[i]>(i_main_avg+10))x[i]--;
6865  1306 9c            	rvf
6866  1307 7b01          	ld	a,(OFST+0,sp)
6867  1309 5f            	clrw	x
6868  130a 97            	ld	xl,a
6869  130b 58            	sllw	x
6870  130c 90be0f        	ldw	y,_i_main_avg
6871  130f 72a9000a      	addw	y,#10
6872  1313 90bf00        	ldw	c_y,y
6873  1316 9093          	ldw	y,x
6874  1318 90ee17        	ldw	y,(_i_main,y)
6875  131b 90b300        	cpw	y,c_y
6876  131e 2d0f          	jrsle	L1423
6879  1320 7b01          	ld	a,(OFST+0,sp)
6880  1322 5f            	clrw	x
6881  1323 97            	ld	xl,a
6882  1324 58            	sllw	x
6883  1325 9093          	ldw	y,x
6884  1327 ee23          	ldw	x,(_x,x)
6885  1329 1d0001        	subw	x,#1
6886  132c 90ef23        	ldw	(_x,y),x
6887  132f               L1423:
6888                     ; 1379 			if(x[i]>100)x[i]=100;
6890  132f 9c            	rvf
6891  1330 7b01          	ld	a,(OFST+0,sp)
6892  1332 5f            	clrw	x
6893  1333 97            	ld	xl,a
6894  1334 58            	sllw	x
6895  1335 9093          	ldw	y,x
6896  1337 90ee23        	ldw	y,(_x,y)
6897  133a 90a30065      	cpw	y,#101
6898  133e 2f0b          	jrslt	L5423
6901  1340 7b01          	ld	a,(OFST+0,sp)
6902  1342 5f            	clrw	x
6903  1343 97            	ld	xl,a
6904  1344 58            	sllw	x
6905  1345 90ae0064      	ldw	y,#100
6906  1349 ef23          	ldw	(_x,x),y
6907  134b               L5423:
6908                     ; 1380 			if(x[i]<-100)x[i]=-100;
6910  134b 9c            	rvf
6911  134c 7b01          	ld	a,(OFST+0,sp)
6912  134e 5f            	clrw	x
6913  134f 97            	ld	xl,a
6914  1350 58            	sllw	x
6915  1351 9093          	ldw	y,x
6916  1353 90ee23        	ldw	y,(_x,y)
6917  1356 90a3ff9c      	cpw	y,#65436
6918  135a 2e0b          	jrsge	L5323
6921  135c 7b01          	ld	a,(OFST+0,sp)
6922  135e 5f            	clrw	x
6923  135f 97            	ld	xl,a
6924  1360 58            	sllw	x
6925  1361 90aeff9c      	ldw	y,#65436
6926  1365 ef23          	ldw	(_x,x),y
6927  1367               L5323:
6928                     ; 1373 	for(i=0;i<6;i++)
6930  1367 0c01          	inc	(OFST+0,sp)
6933  1369 7b01          	ld	a,(OFST+0,sp)
6934  136b a106          	cp	a,#6
6935  136d 2403cc12d0    	jrult	L7223
6936  1372               L1713:
6937                     ; 1387 }
6940  1372 84            	pop	a
6941  1373 81            	ret
6964                     ; 1390 void init_CAN(void) {
6965                     	switch	.text
6966  1374               _init_CAN:
6970                     ; 1391 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6972  1374 72135420      	bres	21536,#1
6973                     ; 1392 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6975  1378 72105420      	bset	21536,#0
6977  137c               L3623:
6978                     ; 1393 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6980  137c c65421        	ld	a,21537
6981  137f a501          	bcp	a,#1
6982  1381 27f9          	jreq	L3623
6983                     ; 1395 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6985  1383 72185420      	bset	21536,#4
6986                     ; 1397 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6988  1387 35025427      	mov	21543,#2
6989                     ; 1406 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6991  138b 35135428      	mov	21544,#19
6992                     ; 1407 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6994  138f 35c05429      	mov	21545,#192
6995                     ; 1408 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6997  1393 357f542c      	mov	21548,#127
6998                     ; 1409 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7000  1397 35e0542d      	mov	21549,#224
7001                     ; 1411 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7003  139b 35315430      	mov	21552,#49
7004                     ; 1412 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7006  139f 35c05431      	mov	21553,#192
7007                     ; 1413 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7009  13a3 357f5434      	mov	21556,#127
7010                     ; 1414 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7012  13a7 35e05435      	mov	21557,#224
7013                     ; 1418 	CAN->PSR= 6;									// set page 6
7015  13ab 35065427      	mov	21543,#6
7016                     ; 1423 	CAN->Page.Config.FMR1&=~3;								//mask mode
7018  13af c65430        	ld	a,21552
7019  13b2 a4fc          	and	a,#252
7020  13b4 c75430        	ld	21552,a
7021                     ; 1429 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7023  13b7 35065432      	mov	21554,#6
7024                     ; 1430 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7026  13bb 35605432      	mov	21554,#96
7027                     ; 1433 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7029  13bf 72105432      	bset	21554,#0
7030                     ; 1434 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7032  13c3 72185432      	bset	21554,#4
7033                     ; 1437 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7035  13c7 35065427      	mov	21543,#6
7036                     ; 1439 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7038  13cb 3509542c      	mov	21548,#9
7039                     ; 1440 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7041  13cf 35e7542d      	mov	21549,#231
7042                     ; 1442 	CAN->IER|=(1<<1);
7044  13d3 72125425      	bset	21541,#1
7045                     ; 1445 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7047  13d7 72115420      	bres	21536,#0
7049  13db               L1723:
7050                     ; 1446 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7052  13db c65421        	ld	a,21537
7053  13de a501          	bcp	a,#1
7054  13e0 26f9          	jrne	L1723
7055                     ; 1447 }
7058  13e2 81            	ret
7166                     ; 1450 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7166                     ; 1451 {
7167                     	switch	.text
7168  13e3               _can_transmit:
7170  13e3 89            	pushw	x
7171       00000000      OFST:	set	0
7174                     ; 1453 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7176  13e4 b670          	ld	a,_can_buff_wr_ptr
7177  13e6 a104          	cp	a,#4
7178  13e8 2502          	jrult	L3533
7181  13ea 3f70          	clr	_can_buff_wr_ptr
7182  13ec               L3533:
7183                     ; 1455 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7185  13ec b670          	ld	a,_can_buff_wr_ptr
7186  13ee 97            	ld	xl,a
7187  13ef a610          	ld	a,#16
7188  13f1 42            	mul	x,a
7189  13f2 1601          	ldw	y,(OFST+1,sp)
7190  13f4 a606          	ld	a,#6
7191  13f6               L631:
7192  13f6 9054          	srlw	y
7193  13f8 4a            	dec	a
7194  13f9 26fb          	jrne	L631
7195  13fb 909f          	ld	a,yl
7196  13fd e771          	ld	(_can_out_buff,x),a
7197                     ; 1456 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7199  13ff b670          	ld	a,_can_buff_wr_ptr
7200  1401 97            	ld	xl,a
7201  1402 a610          	ld	a,#16
7202  1404 42            	mul	x,a
7203  1405 7b02          	ld	a,(OFST+2,sp)
7204  1407 48            	sll	a
7205  1408 48            	sll	a
7206  1409 e772          	ld	(_can_out_buff+1,x),a
7207                     ; 1458 can_out_buff[can_buff_wr_ptr][2]=data0;
7209  140b b670          	ld	a,_can_buff_wr_ptr
7210  140d 97            	ld	xl,a
7211  140e a610          	ld	a,#16
7212  1410 42            	mul	x,a
7213  1411 7b05          	ld	a,(OFST+5,sp)
7214  1413 e773          	ld	(_can_out_buff+2,x),a
7215                     ; 1459 can_out_buff[can_buff_wr_ptr][3]=data1;
7217  1415 b670          	ld	a,_can_buff_wr_ptr
7218  1417 97            	ld	xl,a
7219  1418 a610          	ld	a,#16
7220  141a 42            	mul	x,a
7221  141b 7b06          	ld	a,(OFST+6,sp)
7222  141d e774          	ld	(_can_out_buff+3,x),a
7223                     ; 1460 can_out_buff[can_buff_wr_ptr][4]=data2;
7225  141f b670          	ld	a,_can_buff_wr_ptr
7226  1421 97            	ld	xl,a
7227  1422 a610          	ld	a,#16
7228  1424 42            	mul	x,a
7229  1425 7b07          	ld	a,(OFST+7,sp)
7230  1427 e775          	ld	(_can_out_buff+4,x),a
7231                     ; 1461 can_out_buff[can_buff_wr_ptr][5]=data3;
7233  1429 b670          	ld	a,_can_buff_wr_ptr
7234  142b 97            	ld	xl,a
7235  142c a610          	ld	a,#16
7236  142e 42            	mul	x,a
7237  142f 7b08          	ld	a,(OFST+8,sp)
7238  1431 e776          	ld	(_can_out_buff+5,x),a
7239                     ; 1462 can_out_buff[can_buff_wr_ptr][6]=data4;
7241  1433 b670          	ld	a,_can_buff_wr_ptr
7242  1435 97            	ld	xl,a
7243  1436 a610          	ld	a,#16
7244  1438 42            	mul	x,a
7245  1439 7b09          	ld	a,(OFST+9,sp)
7246  143b e777          	ld	(_can_out_buff+6,x),a
7247                     ; 1463 can_out_buff[can_buff_wr_ptr][7]=data5;
7249  143d b670          	ld	a,_can_buff_wr_ptr
7250  143f 97            	ld	xl,a
7251  1440 a610          	ld	a,#16
7252  1442 42            	mul	x,a
7253  1443 7b0a          	ld	a,(OFST+10,sp)
7254  1445 e778          	ld	(_can_out_buff+7,x),a
7255                     ; 1464 can_out_buff[can_buff_wr_ptr][8]=data6;
7257  1447 b670          	ld	a,_can_buff_wr_ptr
7258  1449 97            	ld	xl,a
7259  144a a610          	ld	a,#16
7260  144c 42            	mul	x,a
7261  144d 7b0b          	ld	a,(OFST+11,sp)
7262  144f e779          	ld	(_can_out_buff+8,x),a
7263                     ; 1465 can_out_buff[can_buff_wr_ptr][9]=data7;
7265  1451 b670          	ld	a,_can_buff_wr_ptr
7266  1453 97            	ld	xl,a
7267  1454 a610          	ld	a,#16
7268  1456 42            	mul	x,a
7269  1457 7b0c          	ld	a,(OFST+12,sp)
7270  1459 e77a          	ld	(_can_out_buff+9,x),a
7271                     ; 1467 can_buff_wr_ptr++;
7273  145b 3c70          	inc	_can_buff_wr_ptr
7274                     ; 1468 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7276  145d b670          	ld	a,_can_buff_wr_ptr
7277  145f a104          	cp	a,#4
7278  1461 2502          	jrult	L5533
7281  1463 3f70          	clr	_can_buff_wr_ptr
7282  1465               L5533:
7283                     ; 1469 } 
7286  1465 85            	popw	x
7287  1466 81            	ret
7316                     ; 1472 void can_tx_hndl(void)
7316                     ; 1473 {
7317                     	switch	.text
7318  1467               _can_tx_hndl:
7322                     ; 1474 if(bTX_FREE)
7324  1467 3d08          	tnz	_bTX_FREE
7325  1469 2757          	jreq	L7633
7326                     ; 1476 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7328  146b b66f          	ld	a,_can_buff_rd_ptr
7329  146d b170          	cp	a,_can_buff_wr_ptr
7330  146f 275f          	jreq	L5733
7331                     ; 1478 		bTX_FREE=0;
7333  1471 3f08          	clr	_bTX_FREE
7334                     ; 1480 		CAN->PSR= 0;
7336  1473 725f5427      	clr	21543
7337                     ; 1481 		CAN->Page.TxMailbox.MDLCR=8;
7339  1477 35085429      	mov	21545,#8
7340                     ; 1482 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7342  147b b66f          	ld	a,_can_buff_rd_ptr
7343  147d 97            	ld	xl,a
7344  147e a610          	ld	a,#16
7345  1480 42            	mul	x,a
7346  1481 e671          	ld	a,(_can_out_buff,x)
7347  1483 c7542a        	ld	21546,a
7348                     ; 1483 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7350  1486 b66f          	ld	a,_can_buff_rd_ptr
7351  1488 97            	ld	xl,a
7352  1489 a610          	ld	a,#16
7353  148b 42            	mul	x,a
7354  148c e672          	ld	a,(_can_out_buff+1,x)
7355  148e c7542b        	ld	21547,a
7356                     ; 1485 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7358  1491 b66f          	ld	a,_can_buff_rd_ptr
7359  1493 97            	ld	xl,a
7360  1494 a610          	ld	a,#16
7361  1496 42            	mul	x,a
7362  1497 01            	rrwa	x,a
7363  1498 ab73          	add	a,#_can_out_buff+2
7364  149a 2401          	jrnc	L241
7365  149c 5c            	incw	x
7366  149d               L241:
7367  149d 5f            	clrw	x
7368  149e 97            	ld	xl,a
7369  149f bf00          	ldw	c_x,x
7370  14a1 ae0008        	ldw	x,#8
7371  14a4               L441:
7372  14a4 5a            	decw	x
7373  14a5 92d600        	ld	a,([c_x],x)
7374  14a8 d7542e        	ld	(21550,x),a
7375  14ab 5d            	tnzw	x
7376  14ac 26f6          	jrne	L441
7377                     ; 1487 		can_buff_rd_ptr++;
7379  14ae 3c6f          	inc	_can_buff_rd_ptr
7380                     ; 1488 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7382  14b0 b66f          	ld	a,_can_buff_rd_ptr
7383  14b2 a104          	cp	a,#4
7384  14b4 2502          	jrult	L3733
7387  14b6 3f6f          	clr	_can_buff_rd_ptr
7388  14b8               L3733:
7389                     ; 1490 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7391  14b8 72105428      	bset	21544,#0
7392                     ; 1491 		CAN->IER|=(1<<0);
7394  14bc 72105425      	bset	21541,#0
7395  14c0 200e          	jra	L5733
7396  14c2               L7633:
7397                     ; 1496 	tx_busy_cnt++;
7399  14c2 3c6e          	inc	_tx_busy_cnt
7400                     ; 1497 	if(tx_busy_cnt>=100)
7402  14c4 b66e          	ld	a,_tx_busy_cnt
7403  14c6 a164          	cp	a,#100
7404  14c8 2506          	jrult	L5733
7405                     ; 1499 		tx_busy_cnt=0;
7407  14ca 3f6e          	clr	_tx_busy_cnt
7408                     ; 1500 		bTX_FREE=1;
7410  14cc 35010008      	mov	_bTX_FREE,#1
7411  14d0               L5733:
7412                     ; 1503 }
7415  14d0 81            	ret
7454                     ; 1506 void net_drv(void)
7454                     ; 1507 { 
7455                     	switch	.text
7456  14d1               _net_drv:
7460                     ; 1509 if(bMAIN)
7462                     	btst	_bMAIN
7463  14d6 2503          	jrult	L051
7464  14d8 cc157e        	jp	L1143
7465  14db               L051:
7466                     ; 1511 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7468  14db 3c2f          	inc	_cnt_net_drv
7469  14dd b62f          	ld	a,_cnt_net_drv
7470  14df a107          	cp	a,#7
7471  14e1 2502          	jrult	L3143
7474  14e3 3f2f          	clr	_cnt_net_drv
7475  14e5               L3143:
7476                     ; 1513 	if(cnt_net_drv<=5) 
7478  14e5 b62f          	ld	a,_cnt_net_drv
7479  14e7 a106          	cp	a,#6
7480  14e9 244c          	jruge	L5143
7481                     ; 1515 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7483  14eb 4be8          	push	#232
7484  14ed 4be8          	push	#232
7485  14ef b62f          	ld	a,_cnt_net_drv
7486  14f1 5f            	clrw	x
7487  14f2 97            	ld	xl,a
7488  14f3 58            	sllw	x
7489  14f4 ee23          	ldw	x,(_x,x)
7490  14f6 72bb001c      	addw	x,_volum_u_main_
7491  14fa 90ae0100      	ldw	y,#256
7492  14fe cd0000        	call	c_idiv
7494  1501 9f            	ld	a,xl
7495  1502 88            	push	a
7496  1503 b62f          	ld	a,_cnt_net_drv
7497  1505 5f            	clrw	x
7498  1506 97            	ld	xl,a
7499  1507 58            	sllw	x
7500  1508 e624          	ld	a,(_x+1,x)
7501  150a bb1d          	add	a,_volum_u_main_+1
7502  150c 88            	push	a
7503  150d 4b00          	push	#0
7504  150f 4bed          	push	#237
7505  1511 3b002f        	push	_cnt_net_drv
7506  1514 3b002f        	push	_cnt_net_drv
7507  1517 ae009e        	ldw	x,#158
7508  151a cd13e3        	call	_can_transmit
7510  151d 5b08          	addw	sp,#8
7511                     ; 1516 		i_main_bps_cnt[cnt_net_drv]++;
7513  151f b62f          	ld	a,_cnt_net_drv
7514  1521 5f            	clrw	x
7515  1522 97            	ld	xl,a
7516  1523 6c06          	inc	(_i_main_bps_cnt,x)
7517                     ; 1517 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7519  1525 b62f          	ld	a,_cnt_net_drv
7520  1527 5f            	clrw	x
7521  1528 97            	ld	xl,a
7522  1529 e606          	ld	a,(_i_main_bps_cnt,x)
7523  152b a10b          	cp	a,#11
7524  152d 254f          	jrult	L1143
7527  152f b62f          	ld	a,_cnt_net_drv
7528  1531 5f            	clrw	x
7529  1532 97            	ld	xl,a
7530  1533 6f11          	clr	(_i_main_flag,x)
7531  1535 2047          	jra	L1143
7532  1537               L5143:
7533                     ; 1519 	else if(cnt_net_drv==6)
7535  1537 b62f          	ld	a,_cnt_net_drv
7536  1539 a106          	cp	a,#6
7537  153b 2641          	jrne	L1143
7538                     ; 1521 		plazma_int[2]=pwm_u;
7540  153d be0b          	ldw	x,_pwm_u
7541  153f bf34          	ldw	_plazma_int+4,x
7542                     ; 1522 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7544  1541 3b0067        	push	_Ui
7545  1544 3b0068        	push	_Ui+1
7546  1547 3b0069        	push	_Un
7547  154a 3b006a        	push	_Un+1
7548  154d 3b006b        	push	_I
7549  1550 3b006c        	push	_I+1
7550  1553 4bda          	push	#218
7551  1555 3b0001        	push	_adress
7552  1558 ae018e        	ldw	x,#398
7553  155b cd13e3        	call	_can_transmit
7555  155e 5b08          	addw	sp,#8
7556                     ; 1523 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7558  1560 3b0034        	push	_plazma_int+4
7559  1563 3b0035        	push	_plazma_int+5
7560  1566 3b005c        	push	__x_+1
7561  1569 3b000a        	push	_flags
7562  156c 4b00          	push	#0
7563  156e 3b0064        	push	_T
7564  1571 4bdb          	push	#219
7565  1573 3b0001        	push	_adress
7566  1576 ae018e        	ldw	x,#398
7567  1579 cd13e3        	call	_can_transmit
7569  157c 5b08          	addw	sp,#8
7570  157e               L1143:
7571                     ; 1526 }
7574  157e 81            	ret
7684                     ; 1529 void can_in_an(void)
7684                     ; 1530 {
7685                     	switch	.text
7686  157f               _can_in_an:
7688  157f 5205          	subw	sp,#5
7689       00000005      OFST:	set	5
7692                     ; 1540 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7694  1581 b6c6          	ld	a,_mess+6
7695  1583 c10001        	cp	a,_adress
7696  1586 2703          	jreq	L471
7697  1588 cc1695        	jp	L1643
7698  158b               L471:
7700  158b b6c7          	ld	a,_mess+7
7701  158d c10001        	cp	a,_adress
7702  1590 2703          	jreq	L671
7703  1592 cc1695        	jp	L1643
7704  1595               L671:
7706  1595 b6c8          	ld	a,_mess+8
7707  1597 a1ed          	cp	a,#237
7708  1599 2703          	jreq	L002
7709  159b cc1695        	jp	L1643
7710  159e               L002:
7711                     ; 1543 	can_error_cnt=0;
7713  159e 3f6d          	clr	_can_error_cnt
7714                     ; 1545 	bMAIN=0;
7716  15a0 72110001      	bres	_bMAIN
7717                     ; 1546  	flags_tu=mess[9];
7719  15a4 45c95d        	mov	_flags_tu,_mess+9
7720                     ; 1547  	if(flags_tu&0b00000001)
7722  15a7 b65d          	ld	a,_flags_tu
7723  15a9 a501          	bcp	a,#1
7724  15ab 2706          	jreq	L3643
7725                     ; 1552  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7727  15ad 721a000a      	bset	_flags,#5
7729  15b1 200e          	jra	L5643
7730  15b3               L3643:
7731                     ; 1563  				flags&=0b11011111; 
7733  15b3 721b000a      	bres	_flags,#5
7734                     ; 1564  				off_bp_cnt=5*ee_TZAS;
7736  15b7 c60015        	ld	a,_ee_TZAS+1
7737  15ba 97            	ld	xl,a
7738  15bb a605          	ld	a,#5
7739  15bd 42            	mul	x,a
7740  15be 9f            	ld	a,xl
7741  15bf b750          	ld	_off_bp_cnt,a
7742  15c1               L5643:
7743                     ; 1570  	if(flags_tu&0b00000010) flags|=0b01000000;
7745  15c1 b65d          	ld	a,_flags_tu
7746  15c3 a502          	bcp	a,#2
7747  15c5 2706          	jreq	L7643
7750  15c7 721c000a      	bset	_flags,#6
7752  15cb 2004          	jra	L1743
7753  15cd               L7643:
7754                     ; 1571  	else flags&=0b10111111; 
7756  15cd 721d000a      	bres	_flags,#6
7757  15d1               L1743:
7758                     ; 1573  	vol_u_temp=mess[10]+mess[11]*256;
7760  15d1 b6cb          	ld	a,_mess+11
7761  15d3 5f            	clrw	x
7762  15d4 97            	ld	xl,a
7763  15d5 4f            	clr	a
7764  15d6 02            	rlwa	x,a
7765  15d7 01            	rrwa	x,a
7766  15d8 bbca          	add	a,_mess+10
7767  15da 2401          	jrnc	L451
7768  15dc 5c            	incw	x
7769  15dd               L451:
7770  15dd b756          	ld	_vol_u_temp+1,a
7771  15df 9f            	ld	a,xl
7772  15e0 b755          	ld	_vol_u_temp,a
7773                     ; 1574  	vol_i_temp=mess[12]+mess[13]*256;  
7775  15e2 b6cd          	ld	a,_mess+13
7776  15e4 5f            	clrw	x
7777  15e5 97            	ld	xl,a
7778  15e6 4f            	clr	a
7779  15e7 02            	rlwa	x,a
7780  15e8 01            	rrwa	x,a
7781  15e9 bbcc          	add	a,_mess+12
7782  15eb 2401          	jrnc	L651
7783  15ed 5c            	incw	x
7784  15ee               L651:
7785  15ee b754          	ld	_vol_i_temp+1,a
7786  15f0 9f            	ld	a,xl
7787  15f1 b753          	ld	_vol_i_temp,a
7788                     ; 1583 	plazma_int[2]=T;
7790  15f3 5f            	clrw	x
7791  15f4 b664          	ld	a,_T
7792  15f6 2a01          	jrpl	L061
7793  15f8 53            	cplw	x
7794  15f9               L061:
7795  15f9 97            	ld	xl,a
7796  15fa bf34          	ldw	_plazma_int+4,x
7797                     ; 1584  	rotor_int=flags_tu+(((short)flags)<<8);
7799  15fc b60a          	ld	a,_flags
7800  15fe 5f            	clrw	x
7801  15ff 97            	ld	xl,a
7802  1600 4f            	clr	a
7803  1601 02            	rlwa	x,a
7804  1602 01            	rrwa	x,a
7805  1603 bb5d          	add	a,_flags_tu
7806  1605 2401          	jrnc	L261
7807  1607 5c            	incw	x
7808  1608               L261:
7809  1608 b71b          	ld	_rotor_int+1,a
7810  160a 9f            	ld	a,xl
7811  160b b71a          	ld	_rotor_int,a
7812                     ; 1585 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7814  160d 3b0067        	push	_Ui
7815  1610 3b0068        	push	_Ui+1
7816  1613 3b0069        	push	_Un
7817  1616 3b006a        	push	_Un+1
7818  1619 3b006b        	push	_I
7819  161c 3b006c        	push	_I+1
7820  161f 4bda          	push	#218
7821  1621 3b0001        	push	_adress
7822  1624 ae018e        	ldw	x,#398
7823  1627 cd13e3        	call	_can_transmit
7825  162a 5b08          	addw	sp,#8
7826                     ; 1586 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7828  162c 3b0034        	push	_plazma_int+4
7829  162f 3b0035        	push	_plazma_int+5
7830  1632 3b005c        	push	__x_+1
7831  1635 3b000a        	push	_flags
7832  1638 4b00          	push	#0
7833  163a 3b0064        	push	_T
7834  163d 4bdb          	push	#219
7835  163f 3b0001        	push	_adress
7836  1642 ae018e        	ldw	x,#398
7837  1645 cd13e3        	call	_can_transmit
7839  1648 5b08          	addw	sp,#8
7840                     ; 1587      link_cnt=0;
7842  164a 3f5e          	clr	_link_cnt
7843                     ; 1588      link=ON;
7845  164c 3555005f      	mov	_link,#85
7846                     ; 1590      if(flags_tu&0b10000000)
7848  1650 b65d          	ld	a,_flags_tu
7849  1652 a580          	bcp	a,#128
7850  1654 2716          	jreq	L3743
7851                     ; 1592      	if(!res_fl)
7853  1656 725d0009      	tnz	_res_fl
7854  165a 2625          	jrne	L7743
7855                     ; 1594      		res_fl=1;
7857  165c a601          	ld	a,#1
7858  165e ae0009        	ldw	x,#_res_fl
7859  1661 cd0000        	call	c_eewrc
7861                     ; 1595      		bRES=1;
7863  1664 3501000f      	mov	_bRES,#1
7864                     ; 1596      		res_fl_cnt=0;
7866  1668 3f3e          	clr	_res_fl_cnt
7867  166a 2015          	jra	L7743
7868  166c               L3743:
7869                     ; 1601      	if(main_cnt>20)
7871  166c 9c            	rvf
7872  166d be4e          	ldw	x,_main_cnt
7873  166f a30015        	cpw	x,#21
7874  1672 2f0d          	jrslt	L7743
7875                     ; 1603     			if(res_fl)
7877  1674 725d0009      	tnz	_res_fl
7878  1678 2707          	jreq	L7743
7879                     ; 1605      			res_fl=0;
7881  167a 4f            	clr	a
7882  167b ae0009        	ldw	x,#_res_fl
7883  167e cd0000        	call	c_eewrc
7885  1681               L7743:
7886                     ; 1610       if(res_fl_)
7888  1681 725d0008      	tnz	_res_fl_
7889  1685 2603          	jrne	L202
7890  1687 cc1bb8        	jp	L5243
7891  168a               L202:
7892                     ; 1612       	res_fl_=0;
7894  168a 4f            	clr	a
7895  168b ae0008        	ldw	x,#_res_fl_
7896  168e cd0000        	call	c_eewrc
7898  1691 acb81bb8      	jpf	L5243
7899  1695               L1643:
7900                     ; 1615 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7902  1695 b6c6          	ld	a,_mess+6
7903  1697 c10001        	cp	a,_adress
7904  169a 2703          	jreq	L402
7905  169c cc18ab        	jp	L1153
7906  169f               L402:
7908  169f b6c7          	ld	a,_mess+7
7909  16a1 c10001        	cp	a,_adress
7910  16a4 2703          	jreq	L602
7911  16a6 cc18ab        	jp	L1153
7912  16a9               L602:
7914  16a9 b6c8          	ld	a,_mess+8
7915  16ab a1ee          	cp	a,#238
7916  16ad 2703          	jreq	L012
7917  16af cc18ab        	jp	L1153
7918  16b2               L012:
7920  16b2 b6c9          	ld	a,_mess+9
7921  16b4 b1ca          	cp	a,_mess+10
7922  16b6 2703          	jreq	L212
7923  16b8 cc18ab        	jp	L1153
7924  16bb               L212:
7925                     ; 1617 	rotor_int++;
7927  16bb be1a          	ldw	x,_rotor_int
7928  16bd 1c0001        	addw	x,#1
7929  16c0 bf1a          	ldw	_rotor_int,x
7930                     ; 1618 	if((mess[9]&0xf0)==0x20)
7932  16c2 b6c9          	ld	a,_mess+9
7933  16c4 a4f0          	and	a,#240
7934  16c6 a120          	cp	a,#32
7935  16c8 2673          	jrne	L3153
7936                     ; 1620 		if((mess[9]&0x0f)==0x01)
7938  16ca b6c9          	ld	a,_mess+9
7939  16cc a40f          	and	a,#15
7940  16ce a101          	cp	a,#1
7941  16d0 260d          	jrne	L5153
7942                     ; 1622 			ee_K[0][0]=adc_buff_[4];
7944  16d2 ce000d        	ldw	x,_adc_buff_+8
7945  16d5 89            	pushw	x
7946  16d6 ae0018        	ldw	x,#_ee_K
7947  16d9 cd0000        	call	c_eewrw
7949  16dc 85            	popw	x
7951  16dd 204a          	jra	L7153
7952  16df               L5153:
7953                     ; 1624 		else if((mess[9]&0x0f)==0x02)
7955  16df b6c9          	ld	a,_mess+9
7956  16e1 a40f          	and	a,#15
7957  16e3 a102          	cp	a,#2
7958  16e5 260b          	jrne	L1253
7959                     ; 1626 			ee_K[0][1]++;
7961  16e7 ce001a        	ldw	x,_ee_K+2
7962  16ea 1c0001        	addw	x,#1
7963  16ed cf001a        	ldw	_ee_K+2,x
7965  16f0 2037          	jra	L7153
7966  16f2               L1253:
7967                     ; 1628 		else if((mess[9]&0x0f)==0x03)
7969  16f2 b6c9          	ld	a,_mess+9
7970  16f4 a40f          	and	a,#15
7971  16f6 a103          	cp	a,#3
7972  16f8 260b          	jrne	L5253
7973                     ; 1630 			ee_K[0][1]+=10;
7975  16fa ce001a        	ldw	x,_ee_K+2
7976  16fd 1c000a        	addw	x,#10
7977  1700 cf001a        	ldw	_ee_K+2,x
7979  1703 2024          	jra	L7153
7980  1705               L5253:
7981                     ; 1632 		else if((mess[9]&0x0f)==0x04)
7983  1705 b6c9          	ld	a,_mess+9
7984  1707 a40f          	and	a,#15
7985  1709 a104          	cp	a,#4
7986  170b 260b          	jrne	L1353
7987                     ; 1634 			ee_K[0][1]--;
7989  170d ce001a        	ldw	x,_ee_K+2
7990  1710 1d0001        	subw	x,#1
7991  1713 cf001a        	ldw	_ee_K+2,x
7993  1716 2011          	jra	L7153
7994  1718               L1353:
7995                     ; 1636 		else if((mess[9]&0x0f)==0x05)
7997  1718 b6c9          	ld	a,_mess+9
7998  171a a40f          	and	a,#15
7999  171c a105          	cp	a,#5
8000  171e 2609          	jrne	L7153
8001                     ; 1638 			ee_K[0][1]-=10;
8003  1720 ce001a        	ldw	x,_ee_K+2
8004  1723 1d000a        	subw	x,#10
8005  1726 cf001a        	ldw	_ee_K+2,x
8006  1729               L7153:
8007                     ; 1640 		granee(&ee_K[0][1],50,3000);									
8009  1729 ae0bb8        	ldw	x,#3000
8010  172c 89            	pushw	x
8011  172d ae0032        	ldw	x,#50
8012  1730 89            	pushw	x
8013  1731 ae001a        	ldw	x,#_ee_K+2
8014  1734 cd0021        	call	_granee
8016  1737 5b04          	addw	sp,#4
8018  1739 ac911891      	jpf	L7353
8019  173d               L3153:
8020                     ; 1642 	else if((mess[9]&0xf0)==0x10)
8022  173d b6c9          	ld	a,_mess+9
8023  173f a4f0          	and	a,#240
8024  1741 a110          	cp	a,#16
8025  1743 2673          	jrne	L1453
8026                     ; 1644 		if((mess[9]&0x0f)==0x01)
8028  1745 b6c9          	ld	a,_mess+9
8029  1747 a40f          	and	a,#15
8030  1749 a101          	cp	a,#1
8031  174b 260d          	jrne	L3453
8032                     ; 1646 			ee_K[1][0]=adc_buff_[1];
8034  174d ce0007        	ldw	x,_adc_buff_+2
8035  1750 89            	pushw	x
8036  1751 ae001c        	ldw	x,#_ee_K+4
8037  1754 cd0000        	call	c_eewrw
8039  1757 85            	popw	x
8041  1758 204a          	jra	L5453
8042  175a               L3453:
8043                     ; 1648 		else if((mess[9]&0x0f)==0x02)
8045  175a b6c9          	ld	a,_mess+9
8046  175c a40f          	and	a,#15
8047  175e a102          	cp	a,#2
8048  1760 260b          	jrne	L7453
8049                     ; 1650 			ee_K[1][1]++;
8051  1762 ce001e        	ldw	x,_ee_K+6
8052  1765 1c0001        	addw	x,#1
8053  1768 cf001e        	ldw	_ee_K+6,x
8055  176b 2037          	jra	L5453
8056  176d               L7453:
8057                     ; 1652 		else if((mess[9]&0x0f)==0x03)
8059  176d b6c9          	ld	a,_mess+9
8060  176f a40f          	and	a,#15
8061  1771 a103          	cp	a,#3
8062  1773 260b          	jrne	L3553
8063                     ; 1654 			ee_K[1][1]+=10;
8065  1775 ce001e        	ldw	x,_ee_K+6
8066  1778 1c000a        	addw	x,#10
8067  177b cf001e        	ldw	_ee_K+6,x
8069  177e 2024          	jra	L5453
8070  1780               L3553:
8071                     ; 1656 		else if((mess[9]&0x0f)==0x04)
8073  1780 b6c9          	ld	a,_mess+9
8074  1782 a40f          	and	a,#15
8075  1784 a104          	cp	a,#4
8076  1786 260b          	jrne	L7553
8077                     ; 1658 			ee_K[1][1]--;
8079  1788 ce001e        	ldw	x,_ee_K+6
8080  178b 1d0001        	subw	x,#1
8081  178e cf001e        	ldw	_ee_K+6,x
8083  1791 2011          	jra	L5453
8084  1793               L7553:
8085                     ; 1660 		else if((mess[9]&0x0f)==0x05)
8087  1793 b6c9          	ld	a,_mess+9
8088  1795 a40f          	and	a,#15
8089  1797 a105          	cp	a,#5
8090  1799 2609          	jrne	L5453
8091                     ; 1662 			ee_K[1][1]-=10;
8093  179b ce001e        	ldw	x,_ee_K+6
8094  179e 1d000a        	subw	x,#10
8095  17a1 cf001e        	ldw	_ee_K+6,x
8096  17a4               L5453:
8097                     ; 1667 		granee(&ee_K[1][1],10,30000);
8099  17a4 ae7530        	ldw	x,#30000
8100  17a7 89            	pushw	x
8101  17a8 ae000a        	ldw	x,#10
8102  17ab 89            	pushw	x
8103  17ac ae001e        	ldw	x,#_ee_K+6
8104  17af cd0021        	call	_granee
8106  17b2 5b04          	addw	sp,#4
8108  17b4 ac911891      	jpf	L7353
8109  17b8               L1453:
8110                     ; 1671 	else if((mess[9]&0xf0)==0x00)
8112  17b8 b6c9          	ld	a,_mess+9
8113  17ba a5f0          	bcp	a,#240
8114  17bc 2671          	jrne	L7653
8115                     ; 1673 		if((mess[9]&0x0f)==0x01)
8117  17be b6c9          	ld	a,_mess+9
8118  17c0 a40f          	and	a,#15
8119  17c2 a101          	cp	a,#1
8120  17c4 260d          	jrne	L1753
8121                     ; 1675 			ee_K[2][0]=adc_buff_[2];
8123  17c6 ce0009        	ldw	x,_adc_buff_+4
8124  17c9 89            	pushw	x
8125  17ca ae0020        	ldw	x,#_ee_K+8
8126  17cd cd0000        	call	c_eewrw
8128  17d0 85            	popw	x
8130  17d1 204a          	jra	L3753
8131  17d3               L1753:
8132                     ; 1677 		else if((mess[9]&0x0f)==0x02)
8134  17d3 b6c9          	ld	a,_mess+9
8135  17d5 a40f          	and	a,#15
8136  17d7 a102          	cp	a,#2
8137  17d9 260b          	jrne	L5753
8138                     ; 1679 			ee_K[2][1]++;
8140  17db ce0022        	ldw	x,_ee_K+10
8141  17de 1c0001        	addw	x,#1
8142  17e1 cf0022        	ldw	_ee_K+10,x
8144  17e4 2037          	jra	L3753
8145  17e6               L5753:
8146                     ; 1681 		else if((mess[9]&0x0f)==0x03)
8148  17e6 b6c9          	ld	a,_mess+9
8149  17e8 a40f          	and	a,#15
8150  17ea a103          	cp	a,#3
8151  17ec 260b          	jrne	L1063
8152                     ; 1683 			ee_K[2][1]+=10;
8154  17ee ce0022        	ldw	x,_ee_K+10
8155  17f1 1c000a        	addw	x,#10
8156  17f4 cf0022        	ldw	_ee_K+10,x
8158  17f7 2024          	jra	L3753
8159  17f9               L1063:
8160                     ; 1685 		else if((mess[9]&0x0f)==0x04)
8162  17f9 b6c9          	ld	a,_mess+9
8163  17fb a40f          	and	a,#15
8164  17fd a104          	cp	a,#4
8165  17ff 260b          	jrne	L5063
8166                     ; 1687 			ee_K[2][1]--;
8168  1801 ce0022        	ldw	x,_ee_K+10
8169  1804 1d0001        	subw	x,#1
8170  1807 cf0022        	ldw	_ee_K+10,x
8172  180a 2011          	jra	L3753
8173  180c               L5063:
8174                     ; 1689 		else if((mess[9]&0x0f)==0x05)
8176  180c b6c9          	ld	a,_mess+9
8177  180e a40f          	and	a,#15
8178  1810 a105          	cp	a,#5
8179  1812 2609          	jrne	L3753
8180                     ; 1691 			ee_K[2][1]-=10;
8182  1814 ce0022        	ldw	x,_ee_K+10
8183  1817 1d000a        	subw	x,#10
8184  181a cf0022        	ldw	_ee_K+10,x
8185  181d               L3753:
8186                     ; 1696 		granee(&ee_K[2][1],10,30000);
8188  181d ae7530        	ldw	x,#30000
8189  1820 89            	pushw	x
8190  1821 ae000a        	ldw	x,#10
8191  1824 89            	pushw	x
8192  1825 ae0022        	ldw	x,#_ee_K+10
8193  1828 cd0021        	call	_granee
8195  182b 5b04          	addw	sp,#4
8197  182d 2062          	jra	L7353
8198  182f               L7653:
8199                     ; 1700 	else if((mess[9]&0xf0)==0x30)
8201  182f b6c9          	ld	a,_mess+9
8202  1831 a4f0          	and	a,#240
8203  1833 a130          	cp	a,#48
8204  1835 265a          	jrne	L7353
8205                     ; 1702 		if((mess[9]&0x0f)==0x02)
8207  1837 b6c9          	ld	a,_mess+9
8208  1839 a40f          	and	a,#15
8209  183b a102          	cp	a,#2
8210  183d 260b          	jrne	L7163
8211                     ; 1704 			ee_K[3][1]++;
8213  183f ce0026        	ldw	x,_ee_K+14
8214  1842 1c0001        	addw	x,#1
8215  1845 cf0026        	ldw	_ee_K+14,x
8217  1848 2037          	jra	L1263
8218  184a               L7163:
8219                     ; 1706 		else if((mess[9]&0x0f)==0x03)
8221  184a b6c9          	ld	a,_mess+9
8222  184c a40f          	and	a,#15
8223  184e a103          	cp	a,#3
8224  1850 260b          	jrne	L3263
8225                     ; 1708 			ee_K[3][1]+=10;
8227  1852 ce0026        	ldw	x,_ee_K+14
8228  1855 1c000a        	addw	x,#10
8229  1858 cf0026        	ldw	_ee_K+14,x
8231  185b 2024          	jra	L1263
8232  185d               L3263:
8233                     ; 1710 		else if((mess[9]&0x0f)==0x04)
8235  185d b6c9          	ld	a,_mess+9
8236  185f a40f          	and	a,#15
8237  1861 a104          	cp	a,#4
8238  1863 260b          	jrne	L7263
8239                     ; 1712 			ee_K[3][1]--;
8241  1865 ce0026        	ldw	x,_ee_K+14
8242  1868 1d0001        	subw	x,#1
8243  186b cf0026        	ldw	_ee_K+14,x
8245  186e 2011          	jra	L1263
8246  1870               L7263:
8247                     ; 1714 		else if((mess[9]&0x0f)==0x05)
8249  1870 b6c9          	ld	a,_mess+9
8250  1872 a40f          	and	a,#15
8251  1874 a105          	cp	a,#5
8252  1876 2609          	jrne	L1263
8253                     ; 1716 			ee_K[3][1]-=10;
8255  1878 ce0026        	ldw	x,_ee_K+14
8256  187b 1d000a        	subw	x,#10
8257  187e cf0026        	ldw	_ee_K+14,x
8258  1881               L1263:
8259                     ; 1718 		granee(&ee_K[3][1],300,517);									
8261  1881 ae0205        	ldw	x,#517
8262  1884 89            	pushw	x
8263  1885 ae012c        	ldw	x,#300
8264  1888 89            	pushw	x
8265  1889 ae0026        	ldw	x,#_ee_K+14
8266  188c cd0021        	call	_granee
8268  188f 5b04          	addw	sp,#4
8269  1891               L7353:
8270                     ; 1721 	link_cnt=0;
8272  1891 3f5e          	clr	_link_cnt
8273                     ; 1722      link=ON;
8275  1893 3555005f      	mov	_link,#85
8276                     ; 1723      if(res_fl_)
8278  1897 725d0008      	tnz	_res_fl_
8279  189b 2603          	jrne	L412
8280  189d cc1bb8        	jp	L5243
8281  18a0               L412:
8282                     ; 1725       	res_fl_=0;
8284  18a0 4f            	clr	a
8285  18a1 ae0008        	ldw	x,#_res_fl_
8286  18a4 cd0000        	call	c_eewrc
8288  18a7 acb81bb8      	jpf	L5243
8289  18ab               L1153:
8290                     ; 1731 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8292  18ab b6c6          	ld	a,_mess+6
8293  18ad a1ff          	cp	a,#255
8294  18af 2703          	jreq	L612
8295  18b1 cc193f        	jp	L1463
8296  18b4               L612:
8298  18b4 b6c7          	ld	a,_mess+7
8299  18b6 a1ff          	cp	a,#255
8300  18b8 2703          	jreq	L022
8301  18ba cc193f        	jp	L1463
8302  18bd               L022:
8304  18bd b6c8          	ld	a,_mess+8
8305  18bf a162          	cp	a,#98
8306  18c1 267c          	jrne	L1463
8307                     ; 1734 	tempSS=mess[9]+(mess[10]*256);
8309  18c3 b6ca          	ld	a,_mess+10
8310  18c5 5f            	clrw	x
8311  18c6 97            	ld	xl,a
8312  18c7 4f            	clr	a
8313  18c8 02            	rlwa	x,a
8314  18c9 01            	rrwa	x,a
8315  18ca bbc9          	add	a,_mess+9
8316  18cc 2401          	jrnc	L461
8317  18ce 5c            	incw	x
8318  18cf               L461:
8319  18cf 02            	rlwa	x,a
8320  18d0 1f04          	ldw	(OFST-1,sp),x
8321  18d2 01            	rrwa	x,a
8322                     ; 1735 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8324  18d3 ce0012        	ldw	x,_ee_Umax
8325  18d6 1304          	cpw	x,(OFST-1,sp)
8326  18d8 270a          	jreq	L3463
8329  18da 1e04          	ldw	x,(OFST-1,sp)
8330  18dc 89            	pushw	x
8331  18dd ae0012        	ldw	x,#_ee_Umax
8332  18e0 cd0000        	call	c_eewrw
8334  18e3 85            	popw	x
8335  18e4               L3463:
8336                     ; 1736 	tempSS=mess[11]+(mess[12]*256);
8338  18e4 b6cc          	ld	a,_mess+12
8339  18e6 5f            	clrw	x
8340  18e7 97            	ld	xl,a
8341  18e8 4f            	clr	a
8342  18e9 02            	rlwa	x,a
8343  18ea 01            	rrwa	x,a
8344  18eb bbcb          	add	a,_mess+11
8345  18ed 2401          	jrnc	L661
8346  18ef 5c            	incw	x
8347  18f0               L661:
8348  18f0 02            	rlwa	x,a
8349  18f1 1f04          	ldw	(OFST-1,sp),x
8350  18f3 01            	rrwa	x,a
8351                     ; 1737 	if(ee_dU!=tempSS) ee_dU=tempSS;
8353  18f4 ce0010        	ldw	x,_ee_dU
8354  18f7 1304          	cpw	x,(OFST-1,sp)
8355  18f9 270a          	jreq	L5463
8358  18fb 1e04          	ldw	x,(OFST-1,sp)
8359  18fd 89            	pushw	x
8360  18fe ae0010        	ldw	x,#_ee_dU
8361  1901 cd0000        	call	c_eewrw
8363  1904 85            	popw	x
8364  1905               L5463:
8365                     ; 1738 	if((mess[13]&0x0f)==0x5)
8367  1905 b6cd          	ld	a,_mess+13
8368  1907 a40f          	and	a,#15
8369  1909 a105          	cp	a,#5
8370  190b 261a          	jrne	L7463
8371                     ; 1740 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8373  190d ce0004        	ldw	x,_ee_AVT_MODE
8374  1910 a30055        	cpw	x,#85
8375  1913 2603          	jrne	L222
8376  1915 cc1bb8        	jp	L5243
8377  1918               L222:
8380  1918 ae0055        	ldw	x,#85
8381  191b 89            	pushw	x
8382  191c ae0004        	ldw	x,#_ee_AVT_MODE
8383  191f cd0000        	call	c_eewrw
8385  1922 85            	popw	x
8386  1923 acb81bb8      	jpf	L5243
8387  1927               L7463:
8388                     ; 1742 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8390  1927 ce0004        	ldw	x,_ee_AVT_MODE
8391  192a a30055        	cpw	x,#85
8392  192d 2703          	jreq	L422
8393  192f cc1bb8        	jp	L5243
8394  1932               L422:
8397  1932 5f            	clrw	x
8398  1933 89            	pushw	x
8399  1934 ae0004        	ldw	x,#_ee_AVT_MODE
8400  1937 cd0000        	call	c_eewrw
8402  193a 85            	popw	x
8403  193b acb81bb8      	jpf	L5243
8404  193f               L1463:
8405                     ; 1745 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8407  193f b6c6          	ld	a,_mess+6
8408  1941 a1ff          	cp	a,#255
8409  1943 2703          	jreq	L622
8410  1945 cc1a16        	jp	L1663
8411  1948               L622:
8413  1948 b6c7          	ld	a,_mess+7
8414  194a a1ff          	cp	a,#255
8415  194c 2703          	jreq	L032
8416  194e cc1a16        	jp	L1663
8417  1951               L032:
8419  1951 b6c8          	ld	a,_mess+8
8420  1953 a126          	cp	a,#38
8421  1955 2709          	jreq	L3663
8423  1957 b6c8          	ld	a,_mess+8
8424  1959 a129          	cp	a,#41
8425  195b 2703          	jreq	L232
8426  195d cc1a16        	jp	L1663
8427  1960               L232:
8428  1960               L3663:
8429                     ; 1748 	tempSS=mess[9]+(mess[10]*256);
8431  1960 b6ca          	ld	a,_mess+10
8432  1962 5f            	clrw	x
8433  1963 97            	ld	xl,a
8434  1964 4f            	clr	a
8435  1965 02            	rlwa	x,a
8436  1966 01            	rrwa	x,a
8437  1967 bbc9          	add	a,_mess+9
8438  1969 2401          	jrnc	L071
8439  196b 5c            	incw	x
8440  196c               L071:
8441  196c 02            	rlwa	x,a
8442  196d 1f04          	ldw	(OFST-1,sp),x
8443  196f 01            	rrwa	x,a
8444                     ; 1749 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8446  1970 ce000e        	ldw	x,_ee_tmax
8447  1973 1304          	cpw	x,(OFST-1,sp)
8448  1975 270a          	jreq	L5663
8451  1977 1e04          	ldw	x,(OFST-1,sp)
8452  1979 89            	pushw	x
8453  197a ae000e        	ldw	x,#_ee_tmax
8454  197d cd0000        	call	c_eewrw
8456  1980 85            	popw	x
8457  1981               L5663:
8458                     ; 1750 	tempSS=mess[11]+(mess[12]*256);
8460  1981 b6cc          	ld	a,_mess+12
8461  1983 5f            	clrw	x
8462  1984 97            	ld	xl,a
8463  1985 4f            	clr	a
8464  1986 02            	rlwa	x,a
8465  1987 01            	rrwa	x,a
8466  1988 bbcb          	add	a,_mess+11
8467  198a 2401          	jrnc	L271
8468  198c 5c            	incw	x
8469  198d               L271:
8470  198d 02            	rlwa	x,a
8471  198e 1f04          	ldw	(OFST-1,sp),x
8472  1990 01            	rrwa	x,a
8473                     ; 1751 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8475  1991 ce000c        	ldw	x,_ee_tsign
8476  1994 1304          	cpw	x,(OFST-1,sp)
8477  1996 270a          	jreq	L7663
8480  1998 1e04          	ldw	x,(OFST-1,sp)
8481  199a 89            	pushw	x
8482  199b ae000c        	ldw	x,#_ee_tsign
8483  199e cd0000        	call	c_eewrw
8485  19a1 85            	popw	x
8486  19a2               L7663:
8487                     ; 1754 	if(mess[8]==MEM_KF1)
8489  19a2 b6c8          	ld	a,_mess+8
8490  19a4 a126          	cp	a,#38
8491  19a6 2623          	jrne	L1763
8492                     ; 1756 		if(ee_DEVICE!=0)ee_DEVICE=0;
8494  19a8 ce0002        	ldw	x,_ee_DEVICE
8495  19ab 2709          	jreq	L3763
8498  19ad 5f            	clrw	x
8499  19ae 89            	pushw	x
8500  19af ae0002        	ldw	x,#_ee_DEVICE
8501  19b2 cd0000        	call	c_eewrw
8503  19b5 85            	popw	x
8504  19b6               L3763:
8505                     ; 1757 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8507  19b6 b6cd          	ld	a,_mess+13
8508  19b8 5f            	clrw	x
8509  19b9 97            	ld	xl,a
8510  19ba c30014        	cpw	x,_ee_TZAS
8511  19bd 270c          	jreq	L1763
8514  19bf b6cd          	ld	a,_mess+13
8515  19c1 5f            	clrw	x
8516  19c2 97            	ld	xl,a
8517  19c3 89            	pushw	x
8518  19c4 ae0014        	ldw	x,#_ee_TZAS
8519  19c7 cd0000        	call	c_eewrw
8521  19ca 85            	popw	x
8522  19cb               L1763:
8523                     ; 1759 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8525  19cb b6c8          	ld	a,_mess+8
8526  19cd a129          	cp	a,#41
8527  19cf 2703          	jreq	L432
8528  19d1 cc1bb8        	jp	L5243
8529  19d4               L432:
8530                     ; 1761 		if(ee_DEVICE!=1)ee_DEVICE=1;
8532  19d4 ce0002        	ldw	x,_ee_DEVICE
8533  19d7 a30001        	cpw	x,#1
8534  19da 270b          	jreq	L1073
8537  19dc ae0001        	ldw	x,#1
8538  19df 89            	pushw	x
8539  19e0 ae0002        	ldw	x,#_ee_DEVICE
8540  19e3 cd0000        	call	c_eewrw
8542  19e6 85            	popw	x
8543  19e7               L1073:
8544                     ; 1762 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8546  19e7 b6cd          	ld	a,_mess+13
8547  19e9 5f            	clrw	x
8548  19ea 97            	ld	xl,a
8549  19eb c30000        	cpw	x,_ee_IMAXVENT
8550  19ee 270c          	jreq	L3073
8553  19f0 b6cd          	ld	a,_mess+13
8554  19f2 5f            	clrw	x
8555  19f3 97            	ld	xl,a
8556  19f4 89            	pushw	x
8557  19f5 ae0000        	ldw	x,#_ee_IMAXVENT
8558  19f8 cd0000        	call	c_eewrw
8560  19fb 85            	popw	x
8561  19fc               L3073:
8562                     ; 1763 			if(ee_TZAS!=3) ee_TZAS=3;
8564  19fc ce0014        	ldw	x,_ee_TZAS
8565  19ff a30003        	cpw	x,#3
8566  1a02 2603          	jrne	L632
8567  1a04 cc1bb8        	jp	L5243
8568  1a07               L632:
8571  1a07 ae0003        	ldw	x,#3
8572  1a0a 89            	pushw	x
8573  1a0b ae0014        	ldw	x,#_ee_TZAS
8574  1a0e cd0000        	call	c_eewrw
8576  1a11 85            	popw	x
8577  1a12 acb81bb8      	jpf	L5243
8578  1a16               L1663:
8579                     ; 1767 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8581  1a16 b6c6          	ld	a,_mess+6
8582  1a18 c10001        	cp	a,_adress
8583  1a1b 262d          	jrne	L1173
8585  1a1d b6c7          	ld	a,_mess+7
8586  1a1f c10001        	cp	a,_adress
8587  1a22 2626          	jrne	L1173
8589  1a24 b6c8          	ld	a,_mess+8
8590  1a26 a116          	cp	a,#22
8591  1a28 2620          	jrne	L1173
8593  1a2a b6c9          	ld	a,_mess+9
8594  1a2c a163          	cp	a,#99
8595  1a2e 261a          	jrne	L1173
8596                     ; 1769 	flags&=0b11100001;
8598  1a30 b60a          	ld	a,_flags
8599  1a32 a4e1          	and	a,#225
8600  1a34 b70a          	ld	_flags,a
8601                     ; 1770 	tsign_cnt=0;
8603  1a36 5f            	clrw	x
8604  1a37 bf4a          	ldw	_tsign_cnt,x
8605                     ; 1771 	tmax_cnt=0;
8607  1a39 5f            	clrw	x
8608  1a3a bf48          	ldw	_tmax_cnt,x
8609                     ; 1772 	umax_cnt=0;
8611  1a3c 5f            	clrw	x
8612  1a3d bf62          	ldw	_umax_cnt,x
8613                     ; 1773 	umin_cnt=0;
8615  1a3f 5f            	clrw	x
8616  1a40 bf60          	ldw	_umin_cnt,x
8617                     ; 1774 	led_drv_cnt=30;
8619  1a42 351e0019      	mov	_led_drv_cnt,#30
8621  1a46 acb81bb8      	jpf	L5243
8622  1a4a               L1173:
8623                     ; 1776 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8625  1a4a b6c6          	ld	a,_mess+6
8626  1a4c a1ff          	cp	a,#255
8627  1a4e 265f          	jrne	L5173
8629  1a50 b6c7          	ld	a,_mess+7
8630  1a52 a1ff          	cp	a,#255
8631  1a54 2659          	jrne	L5173
8633  1a56 b6c8          	ld	a,_mess+8
8634  1a58 a116          	cp	a,#22
8635  1a5a 2653          	jrne	L5173
8637  1a5c b6c9          	ld	a,_mess+9
8638  1a5e a116          	cp	a,#22
8639  1a60 264d          	jrne	L5173
8640                     ; 1778 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8642  1a62 b6ca          	ld	a,_mess+10
8643  1a64 a155          	cp	a,#85
8644  1a66 260f          	jrne	L7173
8646  1a68 b6cb          	ld	a,_mess+11
8647  1a6a a155          	cp	a,#85
8648  1a6c 2609          	jrne	L7173
8651  1a6e be5b          	ldw	x,__x_
8652  1a70 1c0001        	addw	x,#1
8653  1a73 bf5b          	ldw	__x_,x
8655  1a75 2024          	jra	L1273
8656  1a77               L7173:
8657                     ; 1779 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8659  1a77 b6ca          	ld	a,_mess+10
8660  1a79 a166          	cp	a,#102
8661  1a7b 260f          	jrne	L3273
8663  1a7d b6cb          	ld	a,_mess+11
8664  1a7f a166          	cp	a,#102
8665  1a81 2609          	jrne	L3273
8668  1a83 be5b          	ldw	x,__x_
8669  1a85 1d0001        	subw	x,#1
8670  1a88 bf5b          	ldw	__x_,x
8672  1a8a 200f          	jra	L1273
8673  1a8c               L3273:
8674                     ; 1780 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8676  1a8c b6ca          	ld	a,_mess+10
8677  1a8e a177          	cp	a,#119
8678  1a90 2609          	jrne	L1273
8680  1a92 b6cb          	ld	a,_mess+11
8681  1a94 a177          	cp	a,#119
8682  1a96 2603          	jrne	L1273
8685  1a98 5f            	clrw	x
8686  1a99 bf5b          	ldw	__x_,x
8687  1a9b               L1273:
8688                     ; 1781      gran(&_x_,-XMAX,XMAX);
8690  1a9b ae0019        	ldw	x,#25
8691  1a9e 89            	pushw	x
8692  1a9f aeffe7        	ldw	x,#65511
8693  1aa2 89            	pushw	x
8694  1aa3 ae005b        	ldw	x,#__x_
8695  1aa6 cd0000        	call	_gran
8697  1aa9 5b04          	addw	sp,#4
8699  1aab acb81bb8      	jpf	L5243
8700  1aaf               L5173:
8701                     ; 1783 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8703  1aaf b6c6          	ld	a,_mess+6
8704  1ab1 c10001        	cp	a,_adress
8705  1ab4 2665          	jrne	L3373
8707  1ab6 b6c7          	ld	a,_mess+7
8708  1ab8 c10001        	cp	a,_adress
8709  1abb 265e          	jrne	L3373
8711  1abd b6c8          	ld	a,_mess+8
8712  1abf a116          	cp	a,#22
8713  1ac1 2658          	jrne	L3373
8715  1ac3 b6c9          	ld	a,_mess+9
8716  1ac5 b1ca          	cp	a,_mess+10
8717  1ac7 2652          	jrne	L3373
8719  1ac9 b6c9          	ld	a,_mess+9
8720  1acb a1ee          	cp	a,#238
8721  1acd 264c          	jrne	L3373
8722                     ; 1785 	rotor_int++;
8724  1acf be1a          	ldw	x,_rotor_int
8725  1ad1 1c0001        	addw	x,#1
8726  1ad4 bf1a          	ldw	_rotor_int,x
8727                     ; 1786      tempI=pwm_u;
8729  1ad6 be0b          	ldw	x,_pwm_u
8730  1ad8 1f04          	ldw	(OFST-1,sp),x
8731                     ; 1787 	ee_U_AVT=tempI;
8733  1ada 1e04          	ldw	x,(OFST-1,sp)
8734  1adc 89            	pushw	x
8735  1add ae000a        	ldw	x,#_ee_U_AVT
8736  1ae0 cd0000        	call	c_eewrw
8738  1ae3 85            	popw	x
8739                     ; 1788 	UU_AVT=Un;
8741  1ae4 be69          	ldw	x,_Un
8742  1ae6 89            	pushw	x
8743  1ae7 ae0006        	ldw	x,#_UU_AVT
8744  1aea cd0000        	call	c_eewrw
8746  1aed 85            	popw	x
8747                     ; 1789 	delay_ms(100);
8749  1aee ae0064        	ldw	x,#100
8750  1af1 cd004c        	call	_delay_ms
8752                     ; 1790 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
8754  1af4 ce000a        	ldw	x,_ee_U_AVT
8755  1af7 1304          	cpw	x,(OFST-1,sp)
8756  1af9 2703          	jreq	L042
8757  1afb cc1bb8        	jp	L5243
8758  1afe               L042:
8761  1afe 4b00          	push	#0
8762  1b00 4b00          	push	#0
8763  1b02 4b00          	push	#0
8764  1b04 4b00          	push	#0
8765  1b06 4bdd          	push	#221
8766  1b08 4bdd          	push	#221
8767  1b0a 4b91          	push	#145
8768  1b0c 3b0001        	push	_adress
8769  1b0f ae018e        	ldw	x,#398
8770  1b12 cd13e3        	call	_can_transmit
8772  1b15 5b08          	addw	sp,#8
8773  1b17 acb81bb8      	jpf	L5243
8774  1b1b               L3373:
8775                     ; 1795 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8777  1b1b b6c7          	ld	a,_mess+7
8778  1b1d a1da          	cp	a,#218
8779  1b1f 2652          	jrne	L1473
8781  1b21 b6c6          	ld	a,_mess+6
8782  1b23 c10001        	cp	a,_adress
8783  1b26 274b          	jreq	L1473
8785  1b28 b6c6          	ld	a,_mess+6
8786  1b2a a106          	cp	a,#6
8787  1b2c 2445          	jruge	L1473
8788                     ; 1797 	i_main_bps_cnt[mess[6]]=0;
8790  1b2e b6c6          	ld	a,_mess+6
8791  1b30 5f            	clrw	x
8792  1b31 97            	ld	xl,a
8793  1b32 6f06          	clr	(_i_main_bps_cnt,x)
8794                     ; 1798 	i_main_flag[mess[6]]=1;
8796  1b34 b6c6          	ld	a,_mess+6
8797  1b36 5f            	clrw	x
8798  1b37 97            	ld	xl,a
8799  1b38 a601          	ld	a,#1
8800  1b3a e711          	ld	(_i_main_flag,x),a
8801                     ; 1799 	if(bMAIN)
8803                     	btst	_bMAIN
8804  1b41 2475          	jruge	L5243
8805                     ; 1801 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8807  1b43 b6c9          	ld	a,_mess+9
8808  1b45 5f            	clrw	x
8809  1b46 97            	ld	xl,a
8810  1b47 4f            	clr	a
8811  1b48 02            	rlwa	x,a
8812  1b49 1f01          	ldw	(OFST-4,sp),x
8813  1b4b b6c8          	ld	a,_mess+8
8814  1b4d 5f            	clrw	x
8815  1b4e 97            	ld	xl,a
8816  1b4f 72fb01        	addw	x,(OFST-4,sp)
8817  1b52 b6c6          	ld	a,_mess+6
8818  1b54 905f          	clrw	y
8819  1b56 9097          	ld	yl,a
8820  1b58 9058          	sllw	y
8821  1b5a 90ef17        	ldw	(_i_main,y),x
8822                     ; 1802 		i_main[adress]=I;
8824  1b5d c60001        	ld	a,_adress
8825  1b60 5f            	clrw	x
8826  1b61 97            	ld	xl,a
8827  1b62 58            	sllw	x
8828  1b63 90be6b        	ldw	y,_I
8829  1b66 ef17          	ldw	(_i_main,x),y
8830                     ; 1803      	i_main_flag[adress]=1;
8832  1b68 c60001        	ld	a,_adress
8833  1b6b 5f            	clrw	x
8834  1b6c 97            	ld	xl,a
8835  1b6d a601          	ld	a,#1
8836  1b6f e711          	ld	(_i_main_flag,x),a
8837  1b71 2045          	jra	L5243
8838  1b73               L1473:
8839                     ; 1807 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8841  1b73 b6c7          	ld	a,_mess+7
8842  1b75 a1db          	cp	a,#219
8843  1b77 263f          	jrne	L5243
8845  1b79 b6c6          	ld	a,_mess+6
8846  1b7b c10001        	cp	a,_adress
8847  1b7e 2738          	jreq	L5243
8849  1b80 b6c6          	ld	a,_mess+6
8850  1b82 a106          	cp	a,#6
8851  1b84 2432          	jruge	L5243
8852                     ; 1809 	i_main_bps_cnt[mess[6]]=0;
8854  1b86 b6c6          	ld	a,_mess+6
8855  1b88 5f            	clrw	x
8856  1b89 97            	ld	xl,a
8857  1b8a 6f06          	clr	(_i_main_bps_cnt,x)
8858                     ; 1810 	i_main_flag[mess[6]]=1;		
8860  1b8c b6c6          	ld	a,_mess+6
8861  1b8e 5f            	clrw	x
8862  1b8f 97            	ld	xl,a
8863  1b90 a601          	ld	a,#1
8864  1b92 e711          	ld	(_i_main_flag,x),a
8865                     ; 1811 	if(bMAIN)
8867                     	btst	_bMAIN
8868  1b99 241d          	jruge	L5243
8869                     ; 1813 		if(mess[9]==0)i_main_flag[i]=1;
8871  1b9b 3dc9          	tnz	_mess+9
8872  1b9d 260a          	jrne	L3573
8875  1b9f 7b03          	ld	a,(OFST-2,sp)
8876  1ba1 5f            	clrw	x
8877  1ba2 97            	ld	xl,a
8878  1ba3 a601          	ld	a,#1
8879  1ba5 e711          	ld	(_i_main_flag,x),a
8881  1ba7 2006          	jra	L5573
8882  1ba9               L3573:
8883                     ; 1814 		else i_main_flag[i]=0;
8885  1ba9 7b03          	ld	a,(OFST-2,sp)
8886  1bab 5f            	clrw	x
8887  1bac 97            	ld	xl,a
8888  1bad 6f11          	clr	(_i_main_flag,x)
8889  1baf               L5573:
8890                     ; 1815 		i_main_flag[adress]=1;
8892  1baf c60001        	ld	a,_adress
8893  1bb2 5f            	clrw	x
8894  1bb3 97            	ld	xl,a
8895  1bb4 a601          	ld	a,#1
8896  1bb6 e711          	ld	(_i_main_flag,x),a
8897  1bb8               L5243:
8898                     ; 1821 can_in_an_end:
8898                     ; 1822 bCAN_RX=0;
8900  1bb8 3f09          	clr	_bCAN_RX
8901                     ; 1823 }   
8904  1bba 5b05          	addw	sp,#5
8905  1bbc 81            	ret
8928                     ; 1826 void t4_init(void){
8929                     	switch	.text
8930  1bbd               _t4_init:
8934                     ; 1827 	TIM4->PSCR = 4;
8936  1bbd 35045345      	mov	21317,#4
8937                     ; 1828 	TIM4->ARR= 77;
8939  1bc1 354d5346      	mov	21318,#77
8940                     ; 1829 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8942  1bc5 72105341      	bset	21313,#0
8943                     ; 1831 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8945  1bc9 35855340      	mov	21312,#133
8946                     ; 1833 }
8949  1bcd 81            	ret
8972                     ; 1836 void t1_init(void)
8972                     ; 1837 {
8973                     	switch	.text
8974  1bce               _t1_init:
8978                     ; 1838 TIM1->ARRH= 0x03;
8980  1bce 35035262      	mov	21090,#3
8981                     ; 1839 TIM1->ARRL= 0xff;
8983  1bd2 35ff5263      	mov	21091,#255
8984                     ; 1840 TIM1->CCR1H= 0x00;	
8986  1bd6 725f5265      	clr	21093
8987                     ; 1841 TIM1->CCR1L= 0xff;
8989  1bda 35ff5266      	mov	21094,#255
8990                     ; 1842 TIM1->CCR2H= 0x00;	
8992  1bde 725f5267      	clr	21095
8993                     ; 1843 TIM1->CCR2L= 0x00;
8995  1be2 725f5268      	clr	21096
8996                     ; 1844 TIM1->CCR3H= 0x00;	
8998  1be6 725f5269      	clr	21097
8999                     ; 1845 TIM1->CCR3L= 0x64;
9001  1bea 3564526a      	mov	21098,#100
9002                     ; 1847 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9004  1bee 35685258      	mov	21080,#104
9005                     ; 1848 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9007  1bf2 35685259      	mov	21081,#104
9008                     ; 1849 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9010  1bf6 3568525a      	mov	21082,#104
9011                     ; 1850 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9013  1bfa 3511525c      	mov	21084,#17
9014                     ; 1851 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9016  1bfe 3501525d      	mov	21085,#1
9017                     ; 1852 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9019  1c02 35815250      	mov	21072,#129
9020                     ; 1853 TIM1->BKR|= TIM1_BKR_AOE;
9022  1c06 721c526d      	bset	21101,#6
9023                     ; 1854 }
9026  1c0a 81            	ret
9051                     ; 1858 void adc2_init(void)
9051                     ; 1859 {
9052                     	switch	.text
9053  1c0b               _adc2_init:
9057                     ; 1860 adc_plazma[0]++;
9059  1c0b beb2          	ldw	x,_adc_plazma
9060  1c0d 1c0001        	addw	x,#1
9061  1c10 bfb2          	ldw	_adc_plazma,x
9062                     ; 1884 GPIOB->DDR&=~(1<<4);
9064  1c12 72195007      	bres	20487,#4
9065                     ; 1885 GPIOB->CR1&=~(1<<4);
9067  1c16 72195008      	bres	20488,#4
9068                     ; 1886 GPIOB->CR2&=~(1<<4);
9070  1c1a 72195009      	bres	20489,#4
9071                     ; 1888 GPIOB->DDR&=~(1<<5);
9073  1c1e 721b5007      	bres	20487,#5
9074                     ; 1889 GPIOB->CR1&=~(1<<5);
9076  1c22 721b5008      	bres	20488,#5
9077                     ; 1890 GPIOB->CR2&=~(1<<5);
9079  1c26 721b5009      	bres	20489,#5
9080                     ; 1892 GPIOB->DDR&=~(1<<6);
9082  1c2a 721d5007      	bres	20487,#6
9083                     ; 1893 GPIOB->CR1&=~(1<<6);
9085  1c2e 721d5008      	bres	20488,#6
9086                     ; 1894 GPIOB->CR2&=~(1<<6);
9088  1c32 721d5009      	bres	20489,#6
9089                     ; 1896 GPIOB->DDR&=~(1<<7);
9091  1c36 721f5007      	bres	20487,#7
9092                     ; 1897 GPIOB->CR1&=~(1<<7);
9094  1c3a 721f5008      	bres	20488,#7
9095                     ; 1898 GPIOB->CR2&=~(1<<7);
9097  1c3e 721f5009      	bres	20489,#7
9098                     ; 1908 ADC2->TDRL=0xff;
9100  1c42 35ff5407      	mov	21511,#255
9101                     ; 1910 ADC2->CR2=0x08;
9103  1c46 35085402      	mov	21506,#8
9104                     ; 1911 ADC2->CR1=0x40;
9106  1c4a 35405401      	mov	21505,#64
9107                     ; 1915 	ADC2->CSR=0x20+adc_ch+3;
9109  1c4e b6bf          	ld	a,_adc_ch
9110  1c50 ab23          	add	a,#35
9111  1c52 c75400        	ld	21504,a
9112                     ; 1917 	ADC2->CR1|=1;
9114  1c55 72105401      	bset	21505,#0
9115                     ; 1918 	ADC2->CR1|=1;
9117  1c59 72105401      	bset	21505,#0
9118                     ; 1921 adc_plazma[1]=adc_ch;
9120  1c5d b6bf          	ld	a,_adc_ch
9121  1c5f 5f            	clrw	x
9122  1c60 97            	ld	xl,a
9123  1c61 bfb4          	ldw	_adc_plazma+2,x
9124                     ; 1922 }
9127  1c63 81            	ret
9160                     ; 1931 @far @interrupt void TIM4_UPD_Interrupt (void) 
9160                     ; 1932 {
9162                     	switch	.text
9163  1c64               f_TIM4_UPD_Interrupt:
9167                     ; 1933 TIM4->SR1&=~TIM4_SR1_UIF;
9169  1c64 72115342      	bres	21314,#0
9170                     ; 1942 if(++t0_cnt0>=100)
9172  1c68 9c            	rvf
9173  1c69 be00          	ldw	x,_t0_cnt0
9174  1c6b 1c0001        	addw	x,#1
9175  1c6e bf00          	ldw	_t0_cnt0,x
9176  1c70 a30064        	cpw	x,#100
9177  1c73 2f3f          	jrslt	L7104
9178                     ; 1944 	t0_cnt0=0;
9180  1c75 5f            	clrw	x
9181  1c76 bf00          	ldw	_t0_cnt0,x
9182                     ; 1945 	b100Hz=1;
9184  1c78 72100008      	bset	_b100Hz
9185                     ; 1947 	if(++t0_cnt1>=10)
9187  1c7c 3c02          	inc	_t0_cnt1
9188  1c7e b602          	ld	a,_t0_cnt1
9189  1c80 a10a          	cp	a,#10
9190  1c82 2506          	jrult	L1204
9191                     ; 1949 		t0_cnt1=0;
9193  1c84 3f02          	clr	_t0_cnt1
9194                     ; 1950 		b10Hz=1;
9196  1c86 72100007      	bset	_b10Hz
9197  1c8a               L1204:
9198                     ; 1953 	if(++t0_cnt2>=20)
9200  1c8a 3c03          	inc	_t0_cnt2
9201  1c8c b603          	ld	a,_t0_cnt2
9202  1c8e a114          	cp	a,#20
9203  1c90 2506          	jrult	L3204
9204                     ; 1955 		t0_cnt2=0;
9206  1c92 3f03          	clr	_t0_cnt2
9207                     ; 1956 		b5Hz=1;
9209  1c94 72100006      	bset	_b5Hz
9210  1c98               L3204:
9211                     ; 1960 	if(++t0_cnt4>=50)
9213  1c98 3c05          	inc	_t0_cnt4
9214  1c9a b605          	ld	a,_t0_cnt4
9215  1c9c a132          	cp	a,#50
9216  1c9e 2506          	jrult	L5204
9217                     ; 1962 		t0_cnt4=0;
9219  1ca0 3f05          	clr	_t0_cnt4
9220                     ; 1963 		b2Hz=1;
9222  1ca2 72100005      	bset	_b2Hz
9223  1ca6               L5204:
9224                     ; 1966 	if(++t0_cnt3>=100)
9226  1ca6 3c04          	inc	_t0_cnt3
9227  1ca8 b604          	ld	a,_t0_cnt3
9228  1caa a164          	cp	a,#100
9229  1cac 2506          	jrult	L7104
9230                     ; 1968 		t0_cnt3=0;
9232  1cae 3f04          	clr	_t0_cnt3
9233                     ; 1969 		b1Hz=1;
9235  1cb0 72100004      	bset	_b1Hz
9236  1cb4               L7104:
9237                     ; 1975 }
9240  1cb4 80            	iret
9265                     ; 1978 @far @interrupt void CAN_RX_Interrupt (void) 
9265                     ; 1979 {
9266                     	switch	.text
9267  1cb5               f_CAN_RX_Interrupt:
9271                     ; 1981 CAN->PSR= 7;									// page 7 - read messsage
9273  1cb5 35075427      	mov	21543,#7
9274                     ; 1983 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9276  1cb9 ae000e        	ldw	x,#14
9277  1cbc               L452:
9278  1cbc d65427        	ld	a,(21543,x)
9279  1cbf e7bf          	ld	(_mess-1,x),a
9280  1cc1 5a            	decw	x
9281  1cc2 26f8          	jrne	L452
9282                     ; 1994 bCAN_RX=1;
9284  1cc4 35010009      	mov	_bCAN_RX,#1
9285                     ; 1995 CAN->RFR|=(1<<5);
9287  1cc8 721a5424      	bset	21540,#5
9288                     ; 1997 }
9291  1ccc 80            	iret
9314                     ; 2000 @far @interrupt void CAN_TX_Interrupt (void) 
9314                     ; 2001 {
9315                     	switch	.text
9316  1ccd               f_CAN_TX_Interrupt:
9320                     ; 2002 if((CAN->TSR)&(1<<0))
9322  1ccd c65422        	ld	a,21538
9323  1cd0 a501          	bcp	a,#1
9324  1cd2 2708          	jreq	L1504
9325                     ; 2004 	bTX_FREE=1;	
9327  1cd4 35010008      	mov	_bTX_FREE,#1
9328                     ; 2006 	CAN->TSR|=(1<<0);
9330  1cd8 72105422      	bset	21538,#0
9331  1cdc               L1504:
9332                     ; 2008 }
9335  1cdc 80            	iret
9393                     ; 2011 @far @interrupt void ADC2_EOC_Interrupt (void) {
9394                     	switch	.text
9395  1cdd               f_ADC2_EOC_Interrupt:
9397       00000009      OFST:	set	9
9398  1cdd be00          	ldw	x,c_x
9399  1cdf 89            	pushw	x
9400  1ce0 be00          	ldw	x,c_y
9401  1ce2 89            	pushw	x
9402  1ce3 be02          	ldw	x,c_lreg+2
9403  1ce5 89            	pushw	x
9404  1ce6 be00          	ldw	x,c_lreg
9405  1ce8 89            	pushw	x
9406  1ce9 5209          	subw	sp,#9
9409                     ; 2016 adc_plazma[2]++;
9411  1ceb beb6          	ldw	x,_adc_plazma+4
9412  1ced 1c0001        	addw	x,#1
9413  1cf0 bfb6          	ldw	_adc_plazma+4,x
9414                     ; 2023 ADC2->CSR&=~(1<<7);
9416  1cf2 721f5400      	bres	21504,#7
9417                     ; 2025 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9419  1cf6 c65405        	ld	a,21509
9420  1cf9 b703          	ld	c_lreg+3,a
9421  1cfb 3f02          	clr	c_lreg+2
9422  1cfd 3f01          	clr	c_lreg+1
9423  1cff 3f00          	clr	c_lreg
9424  1d01 96            	ldw	x,sp
9425  1d02 1c0001        	addw	x,#OFST-8
9426  1d05 cd0000        	call	c_rtol
9428  1d08 c65404        	ld	a,21508
9429  1d0b 5f            	clrw	x
9430  1d0c 97            	ld	xl,a
9431  1d0d 90ae0100      	ldw	y,#256
9432  1d11 cd0000        	call	c_umul
9434  1d14 96            	ldw	x,sp
9435  1d15 1c0001        	addw	x,#OFST-8
9436  1d18 cd0000        	call	c_ladd
9438  1d1b 96            	ldw	x,sp
9439  1d1c 1c0006        	addw	x,#OFST-3
9440  1d1f cd0000        	call	c_rtol
9442                     ; 2030 if(adr_drv_stat==1)
9444  1d22 b607          	ld	a,_adr_drv_stat
9445  1d24 a101          	cp	a,#1
9446  1d26 260b          	jrne	L1014
9447                     ; 2032 	adr_drv_stat=2;
9449  1d28 35020007      	mov	_adr_drv_stat,#2
9450                     ; 2033 	adc_buff_[0]=temp_adc;
9452  1d2c 1e08          	ldw	x,(OFST-1,sp)
9453  1d2e cf0005        	ldw	_adc_buff_,x
9455  1d31 2020          	jra	L3014
9456  1d33               L1014:
9457                     ; 2036 else if(adr_drv_stat==3)
9459  1d33 b607          	ld	a,_adr_drv_stat
9460  1d35 a103          	cp	a,#3
9461  1d37 260b          	jrne	L5014
9462                     ; 2038 	adr_drv_stat=4;
9464  1d39 35040007      	mov	_adr_drv_stat,#4
9465                     ; 2039 	adc_buff_[1]=temp_adc;
9467  1d3d 1e08          	ldw	x,(OFST-1,sp)
9468  1d3f cf0007        	ldw	_adc_buff_+2,x
9470  1d42 200f          	jra	L3014
9471  1d44               L5014:
9472                     ; 2042 else if(adr_drv_stat==5)
9474  1d44 b607          	ld	a,_adr_drv_stat
9475  1d46 a105          	cp	a,#5
9476  1d48 2609          	jrne	L3014
9477                     ; 2044 	adr_drv_stat=6;
9479  1d4a 35060007      	mov	_adr_drv_stat,#6
9480                     ; 2045 	adc_buff_[9]=temp_adc;
9482  1d4e 1e08          	ldw	x,(OFST-1,sp)
9483  1d50 cf0017        	ldw	_adc_buff_+18,x
9484  1d53               L3014:
9485                     ; 2048 adc_buff[adc_ch][adc_cnt]=temp_adc;
9487  1d53 b6be          	ld	a,_adc_cnt
9488  1d55 5f            	clrw	x
9489  1d56 97            	ld	xl,a
9490  1d57 58            	sllw	x
9491  1d58 1f03          	ldw	(OFST-6,sp),x
9492  1d5a b6bf          	ld	a,_adc_ch
9493  1d5c 97            	ld	xl,a
9494  1d5d a620          	ld	a,#32
9495  1d5f 42            	mul	x,a
9496  1d60 72fb03        	addw	x,(OFST-6,sp)
9497  1d63 1608          	ldw	y,(OFST-1,sp)
9498  1d65 df0019        	ldw	(_adc_buff,x),y
9499                     ; 2054 adc_ch++;
9501  1d68 3cbf          	inc	_adc_ch
9502                     ; 2055 if(adc_ch>=5)
9504  1d6a b6bf          	ld	a,_adc_ch
9505  1d6c a105          	cp	a,#5
9506  1d6e 250e          	jrult	L3114
9507                     ; 2058 	adc_ch=1;
9509  1d70 350100bf      	mov	_adc_ch,#1
9510                     ; 2059 	adc_cnt++;
9512  1d74 3cbe          	inc	_adc_cnt
9513                     ; 2060 	if(adc_cnt>=16)
9515  1d76 b6be          	ld	a,_adc_cnt
9516  1d78 a110          	cp	a,#16
9517  1d7a 2502          	jrult	L3114
9518                     ; 2062 		adc_cnt=0;
9520  1d7c 3fbe          	clr	_adc_cnt
9521  1d7e               L3114:
9522                     ; 2066 if((adc_cnt&0x03)==0)
9524  1d7e b6be          	ld	a,_adc_cnt
9525  1d80 a503          	bcp	a,#3
9526  1d82 264b          	jrne	L7114
9527                     ; 2070 	tempSS=0;
9529  1d84 ae0000        	ldw	x,#0
9530  1d87 1f08          	ldw	(OFST-1,sp),x
9531  1d89 ae0000        	ldw	x,#0
9532  1d8c 1f06          	ldw	(OFST-3,sp),x
9533                     ; 2071 	for(i=0;i<16;i++)
9535  1d8e 0f05          	clr	(OFST-4,sp)
9536  1d90               L1214:
9537                     ; 2073 		tempSS+=(signed long)adc_buff[adc_ch][i];
9539  1d90 7b05          	ld	a,(OFST-4,sp)
9540  1d92 5f            	clrw	x
9541  1d93 97            	ld	xl,a
9542  1d94 58            	sllw	x
9543  1d95 1f03          	ldw	(OFST-6,sp),x
9544  1d97 b6bf          	ld	a,_adc_ch
9545  1d99 97            	ld	xl,a
9546  1d9a a620          	ld	a,#32
9547  1d9c 42            	mul	x,a
9548  1d9d 72fb03        	addw	x,(OFST-6,sp)
9549  1da0 de0019        	ldw	x,(_adc_buff,x)
9550  1da3 cd0000        	call	c_itolx
9552  1da6 96            	ldw	x,sp
9553  1da7 1c0006        	addw	x,#OFST-3
9554  1daa cd0000        	call	c_lgadd
9556                     ; 2071 	for(i=0;i<16;i++)
9558  1dad 0c05          	inc	(OFST-4,sp)
9561  1daf 7b05          	ld	a,(OFST-4,sp)
9562  1db1 a110          	cp	a,#16
9563  1db3 25db          	jrult	L1214
9564                     ; 2075 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9566  1db5 96            	ldw	x,sp
9567  1db6 1c0006        	addw	x,#OFST-3
9568  1db9 cd0000        	call	c_ltor
9570  1dbc a604          	ld	a,#4
9571  1dbe cd0000        	call	c_lrsh
9573  1dc1 be02          	ldw	x,c_lreg+2
9574  1dc3 b6bf          	ld	a,_adc_ch
9575  1dc5 905f          	clrw	y
9576  1dc7 9097          	ld	yl,a
9577  1dc9 9058          	sllw	y
9578  1dcb 90df0005      	ldw	(_adc_buff_,y),x
9579  1dcf               L7114:
9580                     ; 2086 adc_plazma_short++;
9582  1dcf bebc          	ldw	x,_adc_plazma_short
9583  1dd1 1c0001        	addw	x,#1
9584  1dd4 bfbc          	ldw	_adc_plazma_short,x
9585                     ; 2101 }
9588  1dd6 5b09          	addw	sp,#9
9589  1dd8 85            	popw	x
9590  1dd9 bf00          	ldw	c_lreg,x
9591  1ddb 85            	popw	x
9592  1ddc bf02          	ldw	c_lreg+2,x
9593  1dde 85            	popw	x
9594  1ddf bf00          	ldw	c_y,x
9595  1de1 85            	popw	x
9596  1de2 bf00          	ldw	c_x,x
9597  1de4 80            	iret
9660                     ; 2109 main()
9660                     ; 2110 {
9662                     	switch	.text
9663  1de5               _main:
9667                     ; 2112 CLK->ECKR|=1;
9669  1de5 721050c1      	bset	20673,#0
9671  1de9               L1414:
9672                     ; 2113 while((CLK->ECKR & 2) == 0);
9674  1de9 c650c1        	ld	a,20673
9675  1dec a502          	bcp	a,#2
9676  1dee 27f9          	jreq	L1414
9677                     ; 2114 CLK->SWCR|=2;
9679  1df0 721250c5      	bset	20677,#1
9680                     ; 2115 CLK->SWR=0xB4;
9682  1df4 35b450c4      	mov	20676,#180
9683                     ; 2117 delay_ms(200);
9685  1df8 ae00c8        	ldw	x,#200
9686  1dfb cd004c        	call	_delay_ms
9688                     ; 2118 FLASH_DUKR=0xae;
9690  1dfe 35ae5064      	mov	_FLASH_DUKR,#174
9691                     ; 2119 FLASH_DUKR=0x56;
9693  1e02 35565064      	mov	_FLASH_DUKR,#86
9694                     ; 2120 enableInterrupts();
9697  1e06 9a            rim
9699                     ; 2125 adress=0;
9702  1e07 725f0001      	clr	_adress
9703                     ; 2126 bps_class=bpsIPS;
9705  1e0b 35010001      	mov	_bps_class,#1
9706                     ; 2128 t4_init();
9708  1e0f cd1bbd        	call	_t4_init
9710                     ; 2130 		GPIOG->DDR|=(1<<0);
9712  1e12 72105020      	bset	20512,#0
9713                     ; 2131 		GPIOG->CR1|=(1<<0);
9715  1e16 72105021      	bset	20513,#0
9716                     ; 2132 		GPIOG->CR2&=~(1<<0);	
9718  1e1a 72115022      	bres	20514,#0
9719                     ; 2135 		GPIOG->DDR&=~(1<<1);
9721  1e1e 72135020      	bres	20512,#1
9722                     ; 2136 		GPIOG->CR1|=(1<<1);
9724  1e22 72125021      	bset	20513,#1
9725                     ; 2137 		GPIOG->CR2&=~(1<<1);
9727  1e26 72135022      	bres	20514,#1
9728                     ; 2139 init_CAN();
9730  1e2a cd1374        	call	_init_CAN
9732                     ; 2144 GPIOC->DDR|=(1<<1);
9734  1e2d 7212500c      	bset	20492,#1
9735                     ; 2145 GPIOC->CR1|=(1<<1);
9737  1e31 7212500d      	bset	20493,#1
9738                     ; 2146 GPIOC->CR2|=(1<<1);
9740  1e35 7212500e      	bset	20494,#1
9741                     ; 2148 GPIOC->DDR|=(1<<2);
9743  1e39 7214500c      	bset	20492,#2
9744                     ; 2149 GPIOC->CR1|=(1<<2);
9746  1e3d 7214500d      	bset	20493,#2
9747                     ; 2150 GPIOC->CR2|=(1<<2);
9749  1e41 7214500e      	bset	20494,#2
9750                     ; 2157 t1_init();
9752  1e45 cd1bce        	call	_t1_init
9754                     ; 2159 GPIOA->DDR|=(1<<5);
9756  1e48 721a5002      	bset	20482,#5
9757                     ; 2160 GPIOA->CR1|=(1<<5);
9759  1e4c 721a5003      	bset	20483,#5
9760                     ; 2161 GPIOA->CR2&=~(1<<5);
9762  1e50 721b5004      	bres	20484,#5
9763                     ; 2167 GPIOB->DDR|=(1<<3);
9765  1e54 72165007      	bset	20487,#3
9766                     ; 2168 GPIOB->CR1|=(1<<3);
9768  1e58 72165008      	bset	20488,#3
9769                     ; 2169 GPIOB->CR2|=(1<<3);
9771  1e5c 72165009      	bset	20489,#3
9772                     ; 2171 GPIOC->DDR|=(1<<3);
9774  1e60 7216500c      	bset	20492,#3
9775                     ; 2172 GPIOC->CR1|=(1<<3);
9777  1e64 7216500d      	bset	20493,#3
9778                     ; 2173 GPIOC->CR2|=(1<<3);
9780  1e68 7216500e      	bset	20494,#3
9781                     ; 2176 if(bps_class==bpsIPS) 
9783  1e6c b601          	ld	a,_bps_class
9784  1e6e a101          	cp	a,#1
9785  1e70 260a          	jrne	L7414
9786                     ; 2178 	pwm_u=ee_U_AVT;
9788  1e72 ce000a        	ldw	x,_ee_U_AVT
9789  1e75 bf0b          	ldw	_pwm_u,x
9790                     ; 2179 	volum_u_main_=ee_U_AVT;
9792  1e77 ce000a        	ldw	x,_ee_U_AVT
9793  1e7a bf1c          	ldw	_volum_u_main_,x
9794  1e7c               L7414:
9795                     ; 2186 	if(bCAN_RX)
9797  1e7c 3d09          	tnz	_bCAN_RX
9798  1e7e 2705          	jreq	L3514
9799                     ; 2188 		bCAN_RX=0;
9801  1e80 3f09          	clr	_bCAN_RX
9802                     ; 2189 		can_in_an();	
9804  1e82 cd157f        	call	_can_in_an
9806  1e85               L3514:
9807                     ; 2191 	if(b100Hz)
9809                     	btst	_b100Hz
9810  1e8a 240a          	jruge	L5514
9811                     ; 2193 		b100Hz=0;
9813  1e8c 72110008      	bres	_b100Hz
9814                     ; 2202 		adc2_init();
9816  1e90 cd1c0b        	call	_adc2_init
9818                     ; 2203 		can_tx_hndl();
9820  1e93 cd1467        	call	_can_tx_hndl
9822  1e96               L5514:
9823                     ; 2206 	if(b10Hz)
9825                     	btst	_b10Hz
9826  1e9b 2419          	jruge	L7514
9827                     ; 2208 		b10Hz=0;
9829  1e9d 72110007      	bres	_b10Hz
9830                     ; 2210           matemat();
9832  1ea1 cd0bef        	call	_matemat
9834                     ; 2211 	    	led_drv(); 
9836  1ea4 cd0711        	call	_led_drv
9838                     ; 2212 	     link_drv();
9840  1ea7 cd081b        	call	_link_drv
9842                     ; 2213 	     pwr_hndl();		//вычисление воздействий на силу
9844  1eaa cd0ad3        	call	_pwr_hndl
9846                     ; 2214 	     JP_drv();
9848  1ead cd0790        	call	_JP_drv
9850                     ; 2215 	     flags_drv();
9852  1eb0 cd0fe6        	call	_flags_drv
9854                     ; 2216 		net_drv();
9856  1eb3 cd14d1        	call	_net_drv
9858  1eb6               L7514:
9859                     ; 2219 	if(b5Hz)
9861                     	btst	_b5Hz
9862  1ebb 240d          	jruge	L1614
9863                     ; 2221 		b5Hz=0;
9865  1ebd 72110006      	bres	_b5Hz
9866                     ; 2223 		pwr_drv();		//воздействие на силу
9868  1ec1 cd09cf        	call	_pwr_drv
9870                     ; 2224 		led_hndl();
9872  1ec4 cd008e        	call	_led_hndl
9874                     ; 2226 		vent_drv();
9876  1ec7 cd086a        	call	_vent_drv
9878  1eca               L1614:
9879                     ; 2229 	if(b2Hz)
9881                     	btst	_b2Hz
9882  1ecf 2404          	jruge	L3614
9883                     ; 2231 		b2Hz=0;
9885  1ed1 72110005      	bres	_b2Hz
9886  1ed5               L3614:
9887                     ; 2240 	if(b1Hz)
9889                     	btst	_b1Hz
9890  1eda 24a0          	jruge	L7414
9891                     ; 2242 		b1Hz=0;
9893  1edc 72110004      	bres	_b1Hz
9894                     ; 2244 		temper_drv();			//вычисление аварий температуры
9896  1ee0 cd0d1d        	call	_temper_drv
9898                     ; 2245 		u_drv();
9900  1ee3 cd0df4        	call	_u_drv
9902                     ; 2246           x_drv();
9904  1ee6 cd0ecd        	call	_x_drv
9906                     ; 2247           if(main_cnt<1000)main_cnt++;
9908  1ee9 9c            	rvf
9909  1eea be4e          	ldw	x,_main_cnt
9910  1eec a303e8        	cpw	x,#1000
9911  1eef 2e07          	jrsge	L7614
9914  1ef1 be4e          	ldw	x,_main_cnt
9915  1ef3 1c0001        	addw	x,#1
9916  1ef6 bf4e          	ldw	_main_cnt,x
9917  1ef8               L7614:
9918                     ; 2248   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9920  1ef8 b65f          	ld	a,_link
9921  1efa a1aa          	cp	a,#170
9922  1efc 2706          	jreq	L3714
9924  1efe b647          	ld	a,_jp_mode
9925  1f00 a103          	cp	a,#3
9926  1f02 2603          	jrne	L1714
9927  1f04               L3714:
9930  1f04 cd0f47        	call	_apv_hndl
9932  1f07               L1714:
9933                     ; 2251   		can_error_cnt++;
9935  1f07 3c6d          	inc	_can_error_cnt
9936                     ; 2252   		if(can_error_cnt>=10)
9938  1f09 b66d          	ld	a,_can_error_cnt
9939  1f0b a10a          	cp	a,#10
9940  1f0d 2505          	jrult	L5714
9941                     ; 2254   			can_error_cnt=0;
9943  1f0f 3f6d          	clr	_can_error_cnt
9944                     ; 2255 			init_CAN();
9946  1f11 cd1374        	call	_init_CAN
9948  1f14               L5714:
9949                     ; 2259 		volum_u_main_drv();
9951  1f14 cd1221        	call	_volum_u_main_drv
9953                     ; 2261 		pwm_stat++;
9955  1f17 3c04          	inc	_pwm_stat
9956                     ; 2262 		if(pwm_stat>=10)pwm_stat=0;
9958  1f19 b604          	ld	a,_pwm_stat
9959  1f1b a10a          	cp	a,#10
9960  1f1d 2502          	jrult	L7714
9963  1f1f 3f04          	clr	_pwm_stat
9964  1f21               L7714:
9965                     ; 2263 adc_plazma_short++;
9967  1f21 bebc          	ldw	x,_adc_plazma_short
9968  1f23 1c0001        	addw	x,#1
9969  1f26 bfbc          	ldw	_adc_plazma_short,x
9970  1f28 ac7c1e7c      	jpf	L7414
10984                     	xdef	_main
10985                     	xdef	f_ADC2_EOC_Interrupt
10986                     	xdef	f_CAN_TX_Interrupt
10987                     	xdef	f_CAN_RX_Interrupt
10988                     	xdef	f_TIM4_UPD_Interrupt
10989                     	xdef	_adc2_init
10990                     	xdef	_t1_init
10991                     	xdef	_t4_init
10992                     	xdef	_can_in_an
10993                     	xdef	_net_drv
10994                     	xdef	_can_tx_hndl
10995                     	xdef	_can_transmit
10996                     	xdef	_init_CAN
10997                     	xdef	_volum_u_main_drv
10998                     	xdef	_adr_drv_v3
10999                     	xdef	_adr_drv_v4
11000                     	xdef	_flags_drv
11001                     	xdef	_apv_hndl
11002                     	xdef	_apv_stop
11003                     	xdef	_apv_start
11004                     	xdef	_x_drv
11005                     	xdef	_u_drv
11006                     	xdef	_temper_drv
11007                     	xdef	_matemat
11008                     	xdef	_pwr_hndl
11009                     	xdef	_pwr_drv
11010                     	xdef	_vent_drv
11011                     	xdef	_link_drv
11012                     	xdef	_JP_drv
11013                     	xdef	_led_drv
11014                     	xdef	_led_hndl
11015                     	xdef	_delay_ms
11016                     	xdef	_granee
11017                     	xdef	_gran
11018                     .eeprom:	section	.data
11019  0000               _ee_IMAXVENT:
11020  0000 0000          	ds.b	2
11021                     	xdef	_ee_IMAXVENT
11022                     	switch	.ubsct
11023  0001               _bps_class:
11024  0001 00            	ds.b	1
11025                     	xdef	_bps_class
11026  0002               _vent_pwm:
11027  0002 0000          	ds.b	2
11028                     	xdef	_vent_pwm
11029  0004               _pwm_stat:
11030  0004 00            	ds.b	1
11031                     	xdef	_pwm_stat
11032  0005               _pwm_vent_cnt:
11033  0005 00            	ds.b	1
11034                     	xdef	_pwm_vent_cnt
11035                     	switch	.eeprom
11036  0002               _ee_DEVICE:
11037  0002 0000          	ds.b	2
11038                     	xdef	_ee_DEVICE
11039  0004               _ee_AVT_MODE:
11040  0004 0000          	ds.b	2
11041                     	xdef	_ee_AVT_MODE
11042                     	switch	.ubsct
11043  0006               _i_main_bps_cnt:
11044  0006 000000000000  	ds.b	6
11045                     	xdef	_i_main_bps_cnt
11046  000c               _i_main_sigma:
11047  000c 0000          	ds.b	2
11048                     	xdef	_i_main_sigma
11049  000e               _i_main_num_of_bps:
11050  000e 00            	ds.b	1
11051                     	xdef	_i_main_num_of_bps
11052  000f               _i_main_avg:
11053  000f 0000          	ds.b	2
11054                     	xdef	_i_main_avg
11055  0011               _i_main_flag:
11056  0011 000000000000  	ds.b	6
11057                     	xdef	_i_main_flag
11058  0017               _i_main:
11059  0017 000000000000  	ds.b	12
11060                     	xdef	_i_main
11061  0023               _x:
11062  0023 000000000000  	ds.b	12
11063                     	xdef	_x
11064                     	xdef	_volum_u_main_
11065                     	switch	.eeprom
11066  0006               _UU_AVT:
11067  0006 0000          	ds.b	2
11068                     	xdef	_UU_AVT
11069                     	switch	.ubsct
11070  002f               _cnt_net_drv:
11071  002f 00            	ds.b	1
11072                     	xdef	_cnt_net_drv
11073                     	switch	.bit
11074  0001               _bMAIN:
11075  0001 00            	ds.b	1
11076                     	xdef	_bMAIN
11077                     	switch	.ubsct
11078  0030               _plazma_int:
11079  0030 000000000000  	ds.b	6
11080                     	xdef	_plazma_int
11081                     	xdef	_rotor_int
11082  0036               _led_green_buff:
11083  0036 00000000      	ds.b	4
11084                     	xdef	_led_green_buff
11085  003a               _led_red_buff:
11086  003a 00000000      	ds.b	4
11087                     	xdef	_led_red_buff
11088                     	xdef	_led_drv_cnt
11089                     	xdef	_led_green
11090                     	xdef	_led_red
11091  003e               _res_fl_cnt:
11092  003e 00            	ds.b	1
11093                     	xdef	_res_fl_cnt
11094                     	xdef	_bRES_
11095                     	xdef	_bRES
11096                     	switch	.eeprom
11097  0008               _res_fl_:
11098  0008 00            	ds.b	1
11099                     	xdef	_res_fl_
11100  0009               _res_fl:
11101  0009 00            	ds.b	1
11102                     	xdef	_res_fl
11103                     	switch	.ubsct
11104  003f               _cnt_apv_off:
11105  003f 00            	ds.b	1
11106                     	xdef	_cnt_apv_off
11107                     	switch	.bit
11108  0002               _bAPV:
11109  0002 00            	ds.b	1
11110                     	xdef	_bAPV
11111                     	switch	.ubsct
11112  0040               _apv_cnt_:
11113  0040 0000          	ds.b	2
11114                     	xdef	_apv_cnt_
11115  0042               _apv_cnt:
11116  0042 000000        	ds.b	3
11117                     	xdef	_apv_cnt
11118                     	xdef	_bBL_IPS
11119                     	switch	.bit
11120  0003               _bBL:
11121  0003 00            	ds.b	1
11122                     	xdef	_bBL
11123                     	switch	.ubsct
11124  0045               _cnt_JP1:
11125  0045 00            	ds.b	1
11126                     	xdef	_cnt_JP1
11127  0046               _cnt_JP0:
11128  0046 00            	ds.b	1
11129                     	xdef	_cnt_JP0
11130  0047               _jp_mode:
11131  0047 00            	ds.b	1
11132                     	xdef	_jp_mode
11133                     	xdef	_pwm_i
11134                     	xdef	_pwm_u
11135  0048               _tmax_cnt:
11136  0048 0000          	ds.b	2
11137                     	xdef	_tmax_cnt
11138  004a               _tsign_cnt:
11139  004a 0000          	ds.b	2
11140                     	xdef	_tsign_cnt
11141                     	switch	.eeprom
11142  000a               _ee_U_AVT:
11143  000a 0000          	ds.b	2
11144                     	xdef	_ee_U_AVT
11145  000c               _ee_tsign:
11146  000c 0000          	ds.b	2
11147                     	xdef	_ee_tsign
11148  000e               _ee_tmax:
11149  000e 0000          	ds.b	2
11150                     	xdef	_ee_tmax
11151  0010               _ee_dU:
11152  0010 0000          	ds.b	2
11153                     	xdef	_ee_dU
11154  0012               _ee_Umax:
11155  0012 0000          	ds.b	2
11156                     	xdef	_ee_Umax
11157  0014               _ee_TZAS:
11158  0014 0000          	ds.b	2
11159                     	xdef	_ee_TZAS
11160                     	switch	.ubsct
11161  004c               _main_cnt1:
11162  004c 0000          	ds.b	2
11163                     	xdef	_main_cnt1
11164  004e               _main_cnt:
11165  004e 0000          	ds.b	2
11166                     	xdef	_main_cnt
11167  0050               _off_bp_cnt:
11168  0050 00            	ds.b	1
11169                     	xdef	_off_bp_cnt
11170  0051               _flags_tu_cnt_off:
11171  0051 00            	ds.b	1
11172                     	xdef	_flags_tu_cnt_off
11173  0052               _flags_tu_cnt_on:
11174  0052 00            	ds.b	1
11175                     	xdef	_flags_tu_cnt_on
11176  0053               _vol_i_temp:
11177  0053 0000          	ds.b	2
11178                     	xdef	_vol_i_temp
11179  0055               _vol_u_temp:
11180  0055 0000          	ds.b	2
11181                     	xdef	_vol_u_temp
11182                     	switch	.eeprom
11183  0016               __x_ee_:
11184  0016 0000          	ds.b	2
11185                     	xdef	__x_ee_
11186                     	switch	.ubsct
11187  0057               __x_cnt:
11188  0057 0000          	ds.b	2
11189                     	xdef	__x_cnt
11190  0059               __x__:
11191  0059 0000          	ds.b	2
11192                     	xdef	__x__
11193  005b               __x_:
11194  005b 0000          	ds.b	2
11195                     	xdef	__x_
11196  005d               _flags_tu:
11197  005d 00            	ds.b	1
11198                     	xdef	_flags_tu
11199                     	xdef	_flags
11200  005e               _link_cnt:
11201  005e 00            	ds.b	1
11202                     	xdef	_link_cnt
11203  005f               _link:
11204  005f 00            	ds.b	1
11205                     	xdef	_link
11206  0060               _umin_cnt:
11207  0060 0000          	ds.b	2
11208                     	xdef	_umin_cnt
11209  0062               _umax_cnt:
11210  0062 0000          	ds.b	2
11211                     	xdef	_umax_cnt
11212                     	switch	.eeprom
11213  0018               _ee_K:
11214  0018 000000000000  	ds.b	16
11215                     	xdef	_ee_K
11216                     	switch	.ubsct
11217  0064               _T:
11218  0064 00            	ds.b	1
11219                     	xdef	_T
11220  0065               _Udb:
11221  0065 0000          	ds.b	2
11222                     	xdef	_Udb
11223  0067               _Ui:
11224  0067 0000          	ds.b	2
11225                     	xdef	_Ui
11226  0069               _Un:
11227  0069 0000          	ds.b	2
11228                     	xdef	_Un
11229  006b               _I:
11230  006b 0000          	ds.b	2
11231                     	xdef	_I
11232  006d               _can_error_cnt:
11233  006d 00            	ds.b	1
11234                     	xdef	_can_error_cnt
11235                     	xdef	_bCAN_RX
11236  006e               _tx_busy_cnt:
11237  006e 00            	ds.b	1
11238                     	xdef	_tx_busy_cnt
11239                     	xdef	_bTX_FREE
11240  006f               _can_buff_rd_ptr:
11241  006f 00            	ds.b	1
11242                     	xdef	_can_buff_rd_ptr
11243  0070               _can_buff_wr_ptr:
11244  0070 00            	ds.b	1
11245                     	xdef	_can_buff_wr_ptr
11246  0071               _can_out_buff:
11247  0071 000000000000  	ds.b	64
11248                     	xdef	_can_out_buff
11249                     	switch	.bss
11250  0000               _adress_error:
11251  0000 00            	ds.b	1
11252                     	xdef	_adress_error
11253  0001               _adress:
11254  0001 00            	ds.b	1
11255                     	xdef	_adress
11256  0002               _adr:
11257  0002 000000        	ds.b	3
11258                     	xdef	_adr
11259                     	xdef	_adr_drv_stat
11260                     	xdef	_led_ind
11261                     	switch	.ubsct
11262  00b1               _led_ind_cnt:
11263  00b1 00            	ds.b	1
11264                     	xdef	_led_ind_cnt
11265  00b2               _adc_plazma:
11266  00b2 000000000000  	ds.b	10
11267                     	xdef	_adc_plazma
11268  00bc               _adc_plazma_short:
11269  00bc 0000          	ds.b	2
11270                     	xdef	_adc_plazma_short
11271  00be               _adc_cnt:
11272  00be 00            	ds.b	1
11273                     	xdef	_adc_cnt
11274  00bf               _adc_ch:
11275  00bf 00            	ds.b	1
11276                     	xdef	_adc_ch
11277                     	switch	.bss
11278  0005               _adc_buff_:
11279  0005 000000000000  	ds.b	20
11280                     	xdef	_adc_buff_
11281  0019               _adc_buff:
11282  0019 000000000000  	ds.b	320
11283                     	xdef	_adc_buff
11284                     	switch	.ubsct
11285  00c0               _mess:
11286  00c0 000000000000  	ds.b	14
11287                     	xdef	_mess
11288                     	switch	.bit
11289  0004               _b1Hz:
11290  0004 00            	ds.b	1
11291                     	xdef	_b1Hz
11292  0005               _b2Hz:
11293  0005 00            	ds.b	1
11294                     	xdef	_b2Hz
11295  0006               _b5Hz:
11296  0006 00            	ds.b	1
11297                     	xdef	_b5Hz
11298  0007               _b10Hz:
11299  0007 00            	ds.b	1
11300                     	xdef	_b10Hz
11301  0008               _b100Hz:
11302  0008 00            	ds.b	1
11303                     	xdef	_b100Hz
11304                     	xdef	_t0_cnt4
11305                     	xdef	_t0_cnt3
11306                     	xdef	_t0_cnt2
11307                     	xdef	_t0_cnt1
11308                     	xdef	_t0_cnt0
11309                     	xref.b	c_lreg
11310                     	xref.b	c_x
11311                     	xref.b	c_y
11331                     	xref	c_lrsh
11332                     	xref	c_lgadd
11333                     	xref	c_ladd
11334                     	xref	c_umul
11335                     	xref	c_lgmul
11336                     	xref	c_lgsub
11337                     	xref	c_lsbc
11338                     	xref	c_idiv
11339                     	xref	c_ldiv
11340                     	xref	c_itolx
11341                     	xref	c_eewrc
11342                     	xref	c_imul
11343                     	xref	c_lcmp
11344                     	xref	c_ltor
11345                     	xref	c_lgadc
11346                     	xref	c_rtol
11347                     	xref	c_vmul
11348                     	xref	c_eewrw
11349                     	end
