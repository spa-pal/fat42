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
3704                     ; 495 GPIOA->DDR|=(1<<4);
3706  0711 72185002      	bset	20482,#4
3707                     ; 496 GPIOA->CR1|=(1<<4);
3709  0715 72185003      	bset	20483,#4
3710                     ; 497 GPIOA->CR2&=~(1<<4);
3712  0719 72195004      	bres	20484,#4
3713                     ; 498 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3715  071d b63d          	ld	a,_led_red_buff+3
3716  071f a501          	bcp	a,#1
3717  0721 2706          	jreq	L1112
3720  0723 72185000      	bset	20480,#4
3722  0727 2004          	jra	L3112
3723  0729               L1112:
3724                     ; 499 else GPIOA->ODR&=~(1<<4); 
3726  0729 72195000      	bres	20480,#4
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
4383                     ; 649 	vent_pwm=1000-vent_pwm;	// Для нового блока. Там похоже нужна инверсия
4385  09a7 ae03e8        	ldw	x,#1000
4386  09aa 72b00002      	subw	x,_vent_pwm
4387  09ae bf02          	ldw	_vent_pwm,x
4388                     ; 651 }
4391  09b0 5b0e          	addw	sp,#14
4392  09b2 81            	ret
4426                     ; 656 void pwr_drv(void)
4426                     ; 657 {
4427                     	switch	.text
4428  09b3               _pwr_drv:
4432                     ; 661 BLOCK_INIT
4434  09b3 72145007      	bset	20487,#2
4437  09b7 72145008      	bset	20488,#2
4440  09bb 72155009      	bres	20489,#2
4441                     ; 663 if(main_cnt1<1500)main_cnt1++;
4443  09bf 9c            	rvf
4444  09c0 be4c          	ldw	x,_main_cnt1
4445  09c2 a305dc        	cpw	x,#1500
4446  09c5 2e07          	jrsge	L1132
4449  09c7 be4c          	ldw	x,_main_cnt1
4450  09c9 1c0001        	addw	x,#1
4451  09cc bf4c          	ldw	_main_cnt1,x
4452  09ce               L1132:
4453                     ; 665 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4455  09ce 9c            	rvf
4456  09cf ce0014        	ldw	x,_ee_TZAS
4457  09d2 90ae0005      	ldw	y,#5
4458  09d6 cd0000        	call	c_imul
4460  09d9 b34c          	cpw	x,_main_cnt1
4461  09db 2d0d          	jrsle	L3132
4463  09dd b601          	ld	a,_bps_class
4464  09df a101          	cp	a,#1
4465  09e1 2707          	jreq	L3132
4466                     ; 667 	BLOCK_ON
4468  09e3 72145005      	bset	20485,#2
4470  09e7 cc0a70        	jra	L5132
4471  09ea               L3132:
4472                     ; 670 else if(bps_class==bpsIPS)
4474  09ea b601          	ld	a,_bps_class
4475  09ec a101          	cp	a,#1
4476  09ee 261a          	jrne	L7132
4477                     ; 673 		if(bBL_IPS)
4479                     	btst	_bBL_IPS
4480  09f5 2406          	jruge	L1232
4481                     ; 675 			 BLOCK_ON
4483  09f7 72145005      	bset	20485,#2
4485  09fb 2073          	jra	L5132
4486  09fd               L1232:
4487                     ; 678 		else if(!bBL_IPS)
4489                     	btst	_bBL_IPS
4490  0a02 256c          	jrult	L5132
4491                     ; 680 			  BLOCK_OFF
4493  0a04 72155005      	bres	20485,#2
4494  0a08 2066          	jra	L5132
4495  0a0a               L7132:
4496                     ; 684 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4498  0a0a 9c            	rvf
4499  0a0b ce0014        	ldw	x,_ee_TZAS
4500  0a0e 90ae0005      	ldw	y,#5
4501  0a12 cd0000        	call	c_imul
4503  0a15 b34c          	cpw	x,_main_cnt1
4504  0a17 2e3f          	jrsge	L1332
4506  0a19 9c            	rvf
4507  0a1a ce0014        	ldw	x,_ee_TZAS
4508  0a1d 90ae0005      	ldw	y,#5
4509  0a21 cd0000        	call	c_imul
4511  0a24 1c0046        	addw	x,#70
4512  0a27 b34c          	cpw	x,_main_cnt1
4513  0a29 2d2d          	jrsle	L1332
4514                     ; 686 	if(bps_class==bpsIPS)
4516  0a2b b601          	ld	a,_bps_class
4517  0a2d a101          	cp	a,#1
4518  0a2f 2606          	jrne	L3332
4519                     ; 688 		  BLOCK_OFF
4521  0a31 72155005      	bres	20485,#2
4523  0a35 2039          	jra	L5132
4524  0a37               L3332:
4525                     ; 691 	else if(bps_class==bpsIBEP)
4527  0a37 3d01          	tnz	_bps_class
4528  0a39 2635          	jrne	L5132
4529                     ; 693 		if(ee_DEVICE)
4531  0a3b ce0002        	ldw	x,_ee_DEVICE
4532  0a3e 2712          	jreq	L1432
4533                     ; 695 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4535  0a40 b60a          	ld	a,_flags
4536  0a42 a520          	bcp	a,#32
4537  0a44 2706          	jreq	L3432
4540  0a46 72145005      	bset	20485,#2
4542  0a4a 2024          	jra	L5132
4543  0a4c               L3432:
4544                     ; 696 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4546  0a4c 72155005      	bres	20485,#2
4547  0a50 201e          	jra	L5132
4548  0a52               L1432:
4549                     ; 700 			BLOCK_OFF
4551  0a52 72155005      	bres	20485,#2
4552  0a56 2018          	jra	L5132
4553  0a58               L1332:
4554                     ; 705 else if(bBL)
4556                     	btst	_bBL
4557  0a5d 2406          	jruge	L3532
4558                     ; 707 	BLOCK_ON
4560  0a5f 72145005      	bset	20485,#2
4562  0a63 200b          	jra	L5132
4563  0a65               L3532:
4564                     ; 710 else if(!bBL)
4566                     	btst	_bBL
4567  0a6a 2504          	jrult	L5132
4568                     ; 712 	BLOCK_OFF
4570  0a6c 72155005      	bres	20485,#2
4571  0a70               L5132:
4572                     ; 716 gran(&pwm_u,2,1020);
4574  0a70 ae03fc        	ldw	x,#1020
4575  0a73 89            	pushw	x
4576  0a74 ae0002        	ldw	x,#2
4577  0a77 89            	pushw	x
4578  0a78 ae000b        	ldw	x,#_pwm_u
4579  0a7b cd0000        	call	_gran
4581  0a7e 5b04          	addw	sp,#4
4582                     ; 726 TIM1->CCR2H= (char)(pwm_u/256);	
4584  0a80 be0b          	ldw	x,_pwm_u
4585  0a82 90ae0100      	ldw	y,#256
4586  0a86 cd0000        	call	c_idiv
4588  0a89 9f            	ld	a,xl
4589  0a8a c75267        	ld	21095,a
4590                     ; 727 TIM1->CCR2L= (char)pwm_u;
4592  0a8d 55000c5268    	mov	21096,_pwm_u+1
4593                     ; 729 TIM1->CCR1H= (char)(pwm_i/256);	
4595  0a92 be0d          	ldw	x,_pwm_i
4596  0a94 90ae0100      	ldw	y,#256
4597  0a98 cd0000        	call	c_idiv
4599  0a9b 9f            	ld	a,xl
4600  0a9c c75265        	ld	21093,a
4601                     ; 730 TIM1->CCR1L= (char)pwm_i;
4603  0a9f 55000e5266    	mov	21094,_pwm_i+1
4604                     ; 732 TIM1->CCR3H= (char)(vent_pwm/256);	
4606  0aa4 be02          	ldw	x,_vent_pwm
4607  0aa6 90ae0100      	ldw	y,#256
4608  0aaa cd0000        	call	c_idiv
4610  0aad 9f            	ld	a,xl
4611  0aae c75269        	ld	21097,a
4612                     ; 733 TIM1->CCR3L= (char)vent_pwm;
4614  0ab1 550003526a    	mov	21098,_vent_pwm+1
4615                     ; 734 }
4618  0ab6 81            	ret
4656                     ; 739 void pwr_hndl(void)				
4656                     ; 740 {
4657                     	switch	.text
4658  0ab7               _pwr_hndl:
4662                     ; 741 if(jp_mode==jp3)
4664  0ab7 b647          	ld	a,_jp_mode
4665  0ab9 a103          	cp	a,#3
4666  0abb 2627          	jrne	L1732
4667                     ; 743 	if((flags&0b00001010)==0)
4669  0abd b60a          	ld	a,_flags
4670  0abf a50a          	bcp	a,#10
4671  0ac1 260d          	jrne	L3732
4672                     ; 745 		pwm_u=500;
4674  0ac3 ae01f4        	ldw	x,#500
4675  0ac6 bf0b          	ldw	_pwm_u,x
4676                     ; 747 		bBL=0;
4678  0ac8 72110003      	bres	_bBL
4680  0acc acd20bd2      	jpf	L1042
4681  0ad0               L3732:
4682                     ; 749 	else if(flags&0b00001010)
4684  0ad0 b60a          	ld	a,_flags
4685  0ad2 a50a          	bcp	a,#10
4686  0ad4 2603          	jrne	L06
4687  0ad6 cc0bd2        	jp	L1042
4688  0ad9               L06:
4689                     ; 751 		pwm_u=0;
4691  0ad9 5f            	clrw	x
4692  0ada bf0b          	ldw	_pwm_u,x
4693                     ; 753 		bBL=1;
4695  0adc 72100003      	bset	_bBL
4696  0ae0 acd20bd2      	jpf	L1042
4697  0ae4               L1732:
4698                     ; 757 else if(jp_mode==jp2)
4700  0ae4 b647          	ld	a,_jp_mode
4701  0ae6 a102          	cp	a,#2
4702  0ae8 2610          	jrne	L3042
4703                     ; 759 	pwm_u=0;
4705  0aea 5f            	clrw	x
4706  0aeb bf0b          	ldw	_pwm_u,x
4707                     ; 760 	pwm_i=0x3ff;
4709  0aed ae03ff        	ldw	x,#1023
4710  0af0 bf0d          	ldw	_pwm_i,x
4711                     ; 761 	bBL=0;
4713  0af2 72110003      	bres	_bBL
4715  0af6 acd20bd2      	jpf	L1042
4716  0afa               L3042:
4717                     ; 763 else if(jp_mode==jp1)
4719  0afa b647          	ld	a,_jp_mode
4720  0afc a101          	cp	a,#1
4721  0afe 2612          	jrne	L7042
4722                     ; 765 	pwm_u=0x3ff;
4724  0b00 ae03ff        	ldw	x,#1023
4725  0b03 bf0b          	ldw	_pwm_u,x
4726                     ; 766 	pwm_i=0x3ff;
4728  0b05 ae03ff        	ldw	x,#1023
4729  0b08 bf0d          	ldw	_pwm_i,x
4730                     ; 767 	bBL=0;
4732  0b0a 72110003      	bres	_bBL
4734  0b0e acd20bd2      	jpf	L1042
4735  0b12               L7042:
4736                     ; 770 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4738                     	btst	_bMAIN
4739  0b17 2417          	jruge	L3142
4741  0b19 b65f          	ld	a,_link
4742  0b1b a155          	cp	a,#85
4743  0b1d 2611          	jrne	L3142
4744                     ; 772 	pwm_u=volum_u_main_;
4746  0b1f be1c          	ldw	x,_volum_u_main_
4747  0b21 bf0b          	ldw	_pwm_u,x
4748                     ; 773 	pwm_i=0x3ff;
4750  0b23 ae03ff        	ldw	x,#1023
4751  0b26 bf0d          	ldw	_pwm_i,x
4752                     ; 774 	bBL_IPS=0;
4754  0b28 72110000      	bres	_bBL_IPS
4756  0b2c acd20bd2      	jpf	L1042
4757  0b30               L3142:
4758                     ; 777 else if(link==OFF)
4760  0b30 b65f          	ld	a,_link
4761  0b32 a1aa          	cp	a,#170
4762  0b34 2650          	jrne	L7142
4763                     ; 786  	if(ee_DEVICE)
4765  0b36 ce0002        	ldw	x,_ee_DEVICE
4766  0b39 270d          	jreq	L1242
4767                     ; 788 		pwm_u=0x00;
4769  0b3b 5f            	clrw	x
4770  0b3c bf0b          	ldw	_pwm_u,x
4771                     ; 789 		pwm_i=0x00;
4773  0b3e 5f            	clrw	x
4774  0b3f bf0d          	ldw	_pwm_i,x
4775                     ; 790 		bBL=1;
4777  0b41 72100003      	bset	_bBL
4779  0b45 cc0bd2        	jra	L1042
4780  0b48               L1242:
4781                     ; 794 		if((flags&0b00011010)==0)
4783  0b48 b60a          	ld	a,_flags
4784  0b4a a51a          	bcp	a,#26
4785  0b4c 2622          	jrne	L5242
4786                     ; 796 			pwm_u=ee_U_AVT;
4788  0b4e ce000a        	ldw	x,_ee_U_AVT
4789  0b51 bf0b          	ldw	_pwm_u,x
4790                     ; 797 			gran(&pwm_u,0,1020);
4792  0b53 ae03fc        	ldw	x,#1020
4793  0b56 89            	pushw	x
4794  0b57 5f            	clrw	x
4795  0b58 89            	pushw	x
4796  0b59 ae000b        	ldw	x,#_pwm_u
4797  0b5c cd0000        	call	_gran
4799  0b5f 5b04          	addw	sp,#4
4800                     ; 798 		    	pwm_i=0x3ff;
4802  0b61 ae03ff        	ldw	x,#1023
4803  0b64 bf0d          	ldw	_pwm_i,x
4804                     ; 799 			bBL=0;
4806  0b66 72110003      	bres	_bBL
4807                     ; 800 			bBL_IPS=0;
4809  0b6a 72110000      	bres	_bBL_IPS
4811  0b6e 2062          	jra	L1042
4812  0b70               L5242:
4813                     ; 802 		else if(flags&0b00011010)
4815  0b70 b60a          	ld	a,_flags
4816  0b72 a51a          	bcp	a,#26
4817  0b74 275c          	jreq	L1042
4818                     ; 804 			pwm_u=0;
4820  0b76 5f            	clrw	x
4821  0b77 bf0b          	ldw	_pwm_u,x
4822                     ; 805 			pwm_i=0;
4824  0b79 5f            	clrw	x
4825  0b7a bf0d          	ldw	_pwm_i,x
4826                     ; 806 			bBL=1;
4828  0b7c 72100003      	bset	_bBL
4829                     ; 807 			bBL_IPS=1;
4831  0b80 72100000      	bset	_bBL_IPS
4832  0b84 204c          	jra	L1042
4833  0b86               L7142:
4834                     ; 816 else	if(link==ON)				//если есть связь
4836  0b86 b65f          	ld	a,_link
4837  0b88 a155          	cp	a,#85
4838  0b8a 2646          	jrne	L1042
4839                     ; 818 	if((flags&0b00100000)==0)	//если нет блокировки извне
4841  0b8c b60a          	ld	a,_flags
4842  0b8e a520          	bcp	a,#32
4843  0b90 2630          	jrne	L7342
4844                     ; 820 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4846  0b92 b60a          	ld	a,_flags
4847  0b94 a51a          	bcp	a,#26
4848  0b96 2706          	jreq	L3442
4850  0b98 b60a          	ld	a,_flags
4851  0b9a a540          	bcp	a,#64
4852  0b9c 2712          	jreq	L1442
4853  0b9e               L3442:
4854                     ; 822 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4856  0b9e be5b          	ldw	x,__x_
4857  0ba0 72bb0055      	addw	x,_vol_u_temp
4858  0ba4 bf0b          	ldw	_pwm_u,x
4859                     ; 823 		    	pwm_i=vol_i_temp;
4861  0ba6 be53          	ldw	x,_vol_i_temp
4862  0ba8 bf0d          	ldw	_pwm_i,x
4863                     ; 824 			bBL=0;
4865  0baa 72110003      	bres	_bBL
4867  0bae 2022          	jra	L1042
4868  0bb0               L1442:
4869                     ; 826 		else if(flags&0b00011010)					//если есть аварии
4871  0bb0 b60a          	ld	a,_flags
4872  0bb2 a51a          	bcp	a,#26
4873  0bb4 271c          	jreq	L1042
4874                     ; 828 			pwm_u=0;								//то полный стоп
4876  0bb6 5f            	clrw	x
4877  0bb7 bf0b          	ldw	_pwm_u,x
4878                     ; 829 			pwm_i=0;
4880  0bb9 5f            	clrw	x
4881  0bba bf0d          	ldw	_pwm_i,x
4882                     ; 830 			bBL=1;
4884  0bbc 72100003      	bset	_bBL
4885  0bc0 2010          	jra	L1042
4886  0bc2               L7342:
4887                     ; 833 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4889  0bc2 b60a          	ld	a,_flags
4890  0bc4 a520          	bcp	a,#32
4891  0bc6 270a          	jreq	L1042
4892                     ; 835 		pwm_u=0;
4894  0bc8 5f            	clrw	x
4895  0bc9 bf0b          	ldw	_pwm_u,x
4896                     ; 836 	    	pwm_i=0;
4898  0bcb 5f            	clrw	x
4899  0bcc bf0d          	ldw	_pwm_i,x
4900                     ; 837 		bBL=1;
4902  0bce 72100003      	bset	_bBL
4903  0bd2               L1042:
4904                     ; 843 }
4907  0bd2 81            	ret
4949                     	switch	.const
4950  0008               L46:
4951  0008 00000258      	dc.l	600
4952  000c               L66:
4953  000c 00000708      	dc.l	1800
4954  0010               L07:
4955  0010 000003e8      	dc.l	1000
4956                     ; 846 void matemat(void)
4956                     ; 847 {
4957                     	switch	.text
4958  0bd3               _matemat:
4960  0bd3 5204          	subw	sp,#4
4961       00000004      OFST:	set	4
4964                     ; 868 temp_SL=adc_buff_[4];
4966  0bd5 ce000d        	ldw	x,_adc_buff_+8
4967  0bd8 cd0000        	call	c_itolx
4969  0bdb 96            	ldw	x,sp
4970  0bdc 1c0001        	addw	x,#OFST-3
4971  0bdf cd0000        	call	c_rtol
4973                     ; 869 temp_SL-=ee_K[0][0];
4975  0be2 ce0018        	ldw	x,_ee_K
4976  0be5 cd0000        	call	c_itolx
4978  0be8 96            	ldw	x,sp
4979  0be9 1c0001        	addw	x,#OFST-3
4980  0bec cd0000        	call	c_lgsub
4982                     ; 870 if(temp_SL<0) temp_SL=0;
4984  0bef 9c            	rvf
4985  0bf0 0d01          	tnz	(OFST-3,sp)
4986  0bf2 2e0a          	jrsge	L3742
4989  0bf4 ae0000        	ldw	x,#0
4990  0bf7 1f03          	ldw	(OFST-1,sp),x
4991  0bf9 ae0000        	ldw	x,#0
4992  0bfc 1f01          	ldw	(OFST-3,sp),x
4993  0bfe               L3742:
4994                     ; 871 temp_SL*=ee_K[0][1];
4996  0bfe ce001a        	ldw	x,_ee_K+2
4997  0c01 cd0000        	call	c_itolx
4999  0c04 96            	ldw	x,sp
5000  0c05 1c0001        	addw	x,#OFST-3
5001  0c08 cd0000        	call	c_lgmul
5003                     ; 872 temp_SL/=600;
5005  0c0b 96            	ldw	x,sp
5006  0c0c 1c0001        	addw	x,#OFST-3
5007  0c0f cd0000        	call	c_ltor
5009  0c12 ae0008        	ldw	x,#L46
5010  0c15 cd0000        	call	c_ldiv
5012  0c18 96            	ldw	x,sp
5013  0c19 1c0001        	addw	x,#OFST-3
5014  0c1c cd0000        	call	c_rtol
5016                     ; 873 I=(signed short)temp_SL;
5018  0c1f 1e03          	ldw	x,(OFST-1,sp)
5019  0c21 bf6b          	ldw	_I,x
5020                     ; 878 temp_SL=(signed long)adc_buff_[1];
5022  0c23 ce0007        	ldw	x,_adc_buff_+2
5023  0c26 cd0000        	call	c_itolx
5025  0c29 96            	ldw	x,sp
5026  0c2a 1c0001        	addw	x,#OFST-3
5027  0c2d cd0000        	call	c_rtol
5029                     ; 880 if(temp_SL<0) temp_SL=0;
5031  0c30 9c            	rvf
5032  0c31 0d01          	tnz	(OFST-3,sp)
5033  0c33 2e0a          	jrsge	L5742
5036  0c35 ae0000        	ldw	x,#0
5037  0c38 1f03          	ldw	(OFST-1,sp),x
5038  0c3a ae0000        	ldw	x,#0
5039  0c3d 1f01          	ldw	(OFST-3,sp),x
5040  0c3f               L5742:
5041                     ; 881 temp_SL*=(signed long)ee_K[2][1];
5043  0c3f ce0022        	ldw	x,_ee_K+10
5044  0c42 cd0000        	call	c_itolx
5046  0c45 96            	ldw	x,sp
5047  0c46 1c0001        	addw	x,#OFST-3
5048  0c49 cd0000        	call	c_lgmul
5050                     ; 882 temp_SL/=1800L;
5052  0c4c 96            	ldw	x,sp
5053  0c4d 1c0001        	addw	x,#OFST-3
5054  0c50 cd0000        	call	c_ltor
5056  0c53 ae000c        	ldw	x,#L66
5057  0c56 cd0000        	call	c_ldiv
5059  0c59 96            	ldw	x,sp
5060  0c5a 1c0001        	addw	x,#OFST-3
5061  0c5d cd0000        	call	c_rtol
5063                     ; 883 Ui=(unsigned short)temp_SL;
5065  0c60 1e03          	ldw	x,(OFST-1,sp)
5066  0c62 bf67          	ldw	_Ui,x
5067                     ; 890 temp_SL=adc_buff_[3];
5069  0c64 ce000b        	ldw	x,_adc_buff_+6
5070  0c67 cd0000        	call	c_itolx
5072  0c6a 96            	ldw	x,sp
5073  0c6b 1c0001        	addw	x,#OFST-3
5074  0c6e cd0000        	call	c_rtol
5076                     ; 892 if(temp_SL<0) temp_SL=0;
5078  0c71 9c            	rvf
5079  0c72 0d01          	tnz	(OFST-3,sp)
5080  0c74 2e0a          	jrsge	L7742
5083  0c76 ae0000        	ldw	x,#0
5084  0c79 1f03          	ldw	(OFST-1,sp),x
5085  0c7b ae0000        	ldw	x,#0
5086  0c7e 1f01          	ldw	(OFST-3,sp),x
5087  0c80               L7742:
5088                     ; 893 temp_SL*=ee_K[1][1];
5090  0c80 ce001e        	ldw	x,_ee_K+6
5091  0c83 cd0000        	call	c_itolx
5093  0c86 96            	ldw	x,sp
5094  0c87 1c0001        	addw	x,#OFST-3
5095  0c8a cd0000        	call	c_lgmul
5097                     ; 894 temp_SL/=1800;
5099  0c8d 96            	ldw	x,sp
5100  0c8e 1c0001        	addw	x,#OFST-3
5101  0c91 cd0000        	call	c_ltor
5103  0c94 ae000c        	ldw	x,#L66
5104  0c97 cd0000        	call	c_ldiv
5106  0c9a 96            	ldw	x,sp
5107  0c9b 1c0001        	addw	x,#OFST-3
5108  0c9e cd0000        	call	c_rtol
5110                     ; 895 Un=(unsigned short)temp_SL;
5112  0ca1 1e03          	ldw	x,(OFST-1,sp)
5113  0ca3 bf69          	ldw	_Un,x
5114                     ; 898 temp_SL=adc_buff_[2];
5116  0ca5 ce0009        	ldw	x,_adc_buff_+4
5117  0ca8 cd0000        	call	c_itolx
5119  0cab 96            	ldw	x,sp
5120  0cac 1c0001        	addw	x,#OFST-3
5121  0caf cd0000        	call	c_rtol
5123                     ; 899 temp_SL*=ee_K[3][1];
5125  0cb2 ce0026        	ldw	x,_ee_K+14
5126  0cb5 cd0000        	call	c_itolx
5128  0cb8 96            	ldw	x,sp
5129  0cb9 1c0001        	addw	x,#OFST-3
5130  0cbc cd0000        	call	c_lgmul
5132                     ; 900 temp_SL/=1000;
5134  0cbf 96            	ldw	x,sp
5135  0cc0 1c0001        	addw	x,#OFST-3
5136  0cc3 cd0000        	call	c_ltor
5138  0cc6 ae0010        	ldw	x,#L07
5139  0cc9 cd0000        	call	c_ldiv
5141  0ccc 96            	ldw	x,sp
5142  0ccd 1c0001        	addw	x,#OFST-3
5143  0cd0 cd0000        	call	c_rtol
5145                     ; 901 T=(signed short)(temp_SL-273L);
5147  0cd3 7b04          	ld	a,(OFST+0,sp)
5148  0cd5 5f            	clrw	x
5149  0cd6 4d            	tnz	a
5150  0cd7 2a01          	jrpl	L27
5151  0cd9 53            	cplw	x
5152  0cda               L27:
5153  0cda 97            	ld	xl,a
5154  0cdb 1d0111        	subw	x,#273
5155  0cde 01            	rrwa	x,a
5156  0cdf b764          	ld	_T,a
5157  0ce1 02            	rlwa	x,a
5158                     ; 902 if(T<-30)T=-30;
5160  0ce2 9c            	rvf
5161  0ce3 b664          	ld	a,_T
5162  0ce5 a1e2          	cp	a,#226
5163  0ce7 2e04          	jrsge	L1052
5166  0ce9 35e20064      	mov	_T,#226
5167  0ced               L1052:
5168                     ; 903 if(T>120)T=120;
5170  0ced 9c            	rvf
5171  0cee b664          	ld	a,_T
5172  0cf0 a179          	cp	a,#121
5173  0cf2 2f04          	jrslt	L3052
5176  0cf4 35780064      	mov	_T,#120
5177  0cf8               L3052:
5178                     ; 905 Udb=flags;
5180  0cf8 b60a          	ld	a,_flags
5181  0cfa 5f            	clrw	x
5182  0cfb 97            	ld	xl,a
5183  0cfc bf65          	ldw	_Udb,x
5184                     ; 911 }
5187  0cfe 5b04          	addw	sp,#4
5188  0d00 81            	ret
5219                     ; 914 void temper_drv(void)		//1 Hz
5219                     ; 915 {
5220                     	switch	.text
5221  0d01               _temper_drv:
5225                     ; 917 if(T>ee_tsign) tsign_cnt++;
5227  0d01 9c            	rvf
5228  0d02 5f            	clrw	x
5229  0d03 b664          	ld	a,_T
5230  0d05 2a01          	jrpl	L67
5231  0d07 53            	cplw	x
5232  0d08               L67:
5233  0d08 97            	ld	xl,a
5234  0d09 c3000c        	cpw	x,_ee_tsign
5235  0d0c 2d09          	jrsle	L5152
5238  0d0e be4a          	ldw	x,_tsign_cnt
5239  0d10 1c0001        	addw	x,#1
5240  0d13 bf4a          	ldw	_tsign_cnt,x
5242  0d15 201d          	jra	L7152
5243  0d17               L5152:
5244                     ; 918 else if (T<(ee_tsign-1)) tsign_cnt--;
5246  0d17 9c            	rvf
5247  0d18 ce000c        	ldw	x,_ee_tsign
5248  0d1b 5a            	decw	x
5249  0d1c 905f          	clrw	y
5250  0d1e b664          	ld	a,_T
5251  0d20 2a02          	jrpl	L001
5252  0d22 9053          	cplw	y
5253  0d24               L001:
5254  0d24 9097          	ld	yl,a
5255  0d26 90bf00        	ldw	c_y,y
5256  0d29 b300          	cpw	x,c_y
5257  0d2b 2d07          	jrsle	L7152
5260  0d2d be4a          	ldw	x,_tsign_cnt
5261  0d2f 1d0001        	subw	x,#1
5262  0d32 bf4a          	ldw	_tsign_cnt,x
5263  0d34               L7152:
5264                     ; 920 gran(&tsign_cnt,0,60);
5266  0d34 ae003c        	ldw	x,#60
5267  0d37 89            	pushw	x
5268  0d38 5f            	clrw	x
5269  0d39 89            	pushw	x
5270  0d3a ae004a        	ldw	x,#_tsign_cnt
5271  0d3d cd0000        	call	_gran
5273  0d40 5b04          	addw	sp,#4
5274                     ; 922 if(tsign_cnt>=55)
5276  0d42 9c            	rvf
5277  0d43 be4a          	ldw	x,_tsign_cnt
5278  0d45 a30037        	cpw	x,#55
5279  0d48 2f16          	jrslt	L3252
5280                     ; 924 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5282  0d4a 3d47          	tnz	_jp_mode
5283  0d4c 2606          	jrne	L1352
5285  0d4e b60a          	ld	a,_flags
5286  0d50 a540          	bcp	a,#64
5287  0d52 2706          	jreq	L7252
5288  0d54               L1352:
5290  0d54 b647          	ld	a,_jp_mode
5291  0d56 a103          	cp	a,#3
5292  0d58 2612          	jrne	L3352
5293  0d5a               L7252:
5296  0d5a 7214000a      	bset	_flags,#2
5297  0d5e 200c          	jra	L3352
5298  0d60               L3252:
5299                     ; 926 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5301  0d60 9c            	rvf
5302  0d61 be4a          	ldw	x,_tsign_cnt
5303  0d63 a30006        	cpw	x,#6
5304  0d66 2e04          	jrsge	L3352
5307  0d68 7215000a      	bres	_flags,#2
5308  0d6c               L3352:
5309                     ; 931 if(T>ee_tmax) tmax_cnt++;
5311  0d6c 9c            	rvf
5312  0d6d 5f            	clrw	x
5313  0d6e b664          	ld	a,_T
5314  0d70 2a01          	jrpl	L201
5315  0d72 53            	cplw	x
5316  0d73               L201:
5317  0d73 97            	ld	xl,a
5318  0d74 c3000e        	cpw	x,_ee_tmax
5319  0d77 2d09          	jrsle	L7352
5322  0d79 be48          	ldw	x,_tmax_cnt
5323  0d7b 1c0001        	addw	x,#1
5324  0d7e bf48          	ldw	_tmax_cnt,x
5326  0d80 201d          	jra	L1452
5327  0d82               L7352:
5328                     ; 932 else if (T<(ee_tmax-1)) tmax_cnt--;
5330  0d82 9c            	rvf
5331  0d83 ce000e        	ldw	x,_ee_tmax
5332  0d86 5a            	decw	x
5333  0d87 905f          	clrw	y
5334  0d89 b664          	ld	a,_T
5335  0d8b 2a02          	jrpl	L401
5336  0d8d 9053          	cplw	y
5337  0d8f               L401:
5338  0d8f 9097          	ld	yl,a
5339  0d91 90bf00        	ldw	c_y,y
5340  0d94 b300          	cpw	x,c_y
5341  0d96 2d07          	jrsle	L1452
5344  0d98 be48          	ldw	x,_tmax_cnt
5345  0d9a 1d0001        	subw	x,#1
5346  0d9d bf48          	ldw	_tmax_cnt,x
5347  0d9f               L1452:
5348                     ; 934 gran(&tmax_cnt,0,60);
5350  0d9f ae003c        	ldw	x,#60
5351  0da2 89            	pushw	x
5352  0da3 5f            	clrw	x
5353  0da4 89            	pushw	x
5354  0da5 ae0048        	ldw	x,#_tmax_cnt
5355  0da8 cd0000        	call	_gran
5357  0dab 5b04          	addw	sp,#4
5358                     ; 936 if(tmax_cnt>=55)
5360  0dad 9c            	rvf
5361  0dae be48          	ldw	x,_tmax_cnt
5362  0db0 a30037        	cpw	x,#55
5363  0db3 2f16          	jrslt	L5452
5364                     ; 938 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5366  0db5 3d47          	tnz	_jp_mode
5367  0db7 2606          	jrne	L3552
5369  0db9 b60a          	ld	a,_flags
5370  0dbb a540          	bcp	a,#64
5371  0dbd 2706          	jreq	L1552
5372  0dbf               L3552:
5374  0dbf b647          	ld	a,_jp_mode
5375  0dc1 a103          	cp	a,#3
5376  0dc3 2612          	jrne	L5552
5377  0dc5               L1552:
5380  0dc5 7212000a      	bset	_flags,#1
5381  0dc9 200c          	jra	L5552
5382  0dcb               L5452:
5383                     ; 940 else if (tmax_cnt<=5) flags&=0b11111101;
5385  0dcb 9c            	rvf
5386  0dcc be48          	ldw	x,_tmax_cnt
5387  0dce a30006        	cpw	x,#6
5388  0dd1 2e04          	jrsge	L5552
5391  0dd3 7213000a      	bres	_flags,#1
5392  0dd7               L5552:
5393                     ; 943 } 
5396  0dd7 81            	ret
5428                     ; 946 void u_drv(void)		//1Hz
5428                     ; 947 { 
5429                     	switch	.text
5430  0dd8               _u_drv:
5434                     ; 948 if(jp_mode!=jp3)
5436  0dd8 b647          	ld	a,_jp_mode
5437  0dda a103          	cp	a,#3
5438  0ddc 2770          	jreq	L1752
5439                     ; 950 	if(Ui>ee_Umax)umax_cnt++;
5441  0dde 9c            	rvf
5442  0ddf be67          	ldw	x,_Ui
5443  0de1 c30012        	cpw	x,_ee_Umax
5444  0de4 2d09          	jrsle	L3752
5447  0de6 be62          	ldw	x,_umax_cnt
5448  0de8 1c0001        	addw	x,#1
5449  0deb bf62          	ldw	_umax_cnt,x
5451  0ded 2003          	jra	L5752
5452  0def               L3752:
5453                     ; 951 	else umax_cnt=0;
5455  0def 5f            	clrw	x
5456  0df0 bf62          	ldw	_umax_cnt,x
5457  0df2               L5752:
5458                     ; 952 	gran(&umax_cnt,0,10);
5460  0df2 ae000a        	ldw	x,#10
5461  0df5 89            	pushw	x
5462  0df6 5f            	clrw	x
5463  0df7 89            	pushw	x
5464  0df8 ae0062        	ldw	x,#_umax_cnt
5465  0dfb cd0000        	call	_gran
5467  0dfe 5b04          	addw	sp,#4
5468                     ; 953 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5470  0e00 9c            	rvf
5471  0e01 be62          	ldw	x,_umax_cnt
5472  0e03 a3000a        	cpw	x,#10
5473  0e06 2f04          	jrslt	L7752
5476  0e08 7216000a      	bset	_flags,#3
5477  0e0c               L7752:
5478                     ; 956 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5480  0e0c 9c            	rvf
5481  0e0d be67          	ldw	x,_Ui
5482  0e0f b369          	cpw	x,_Un
5483  0e11 2e1c          	jrsge	L1062
5485  0e13 9c            	rvf
5486  0e14 be69          	ldw	x,_Un
5487  0e16 72b00067      	subw	x,_Ui
5488  0e1a c30010        	cpw	x,_ee_dU
5489  0e1d 2d10          	jrsle	L1062
5491  0e1f c65005        	ld	a,20485
5492  0e22 a504          	bcp	a,#4
5493  0e24 2609          	jrne	L1062
5496  0e26 be60          	ldw	x,_umin_cnt
5497  0e28 1c0001        	addw	x,#1
5498  0e2b bf60          	ldw	_umin_cnt,x
5500  0e2d 2003          	jra	L3062
5501  0e2f               L1062:
5502                     ; 957 	else umin_cnt=0;
5504  0e2f 5f            	clrw	x
5505  0e30 bf60          	ldw	_umin_cnt,x
5506  0e32               L3062:
5507                     ; 958 	gran(&umin_cnt,0,10);	
5509  0e32 ae000a        	ldw	x,#10
5510  0e35 89            	pushw	x
5511  0e36 5f            	clrw	x
5512  0e37 89            	pushw	x
5513  0e38 ae0060        	ldw	x,#_umin_cnt
5514  0e3b cd0000        	call	_gran
5516  0e3e 5b04          	addw	sp,#4
5517                     ; 959 	if(umin_cnt>=10)flags|=0b00010000;	  
5519  0e40 9c            	rvf
5520  0e41 be60          	ldw	x,_umin_cnt
5521  0e43 a3000a        	cpw	x,#10
5522  0e46 2f6f          	jrslt	L7062
5525  0e48 7218000a      	bset	_flags,#4
5526  0e4c 2069          	jra	L7062
5527  0e4e               L1752:
5528                     ; 961 else if(jp_mode==jp3)
5530  0e4e b647          	ld	a,_jp_mode
5531  0e50 a103          	cp	a,#3
5532  0e52 2663          	jrne	L7062
5533                     ; 963 	if(Ui>700)umax_cnt++;
5535  0e54 9c            	rvf
5536  0e55 be67          	ldw	x,_Ui
5537  0e57 a302bd        	cpw	x,#701
5538  0e5a 2f09          	jrslt	L3162
5541  0e5c be62          	ldw	x,_umax_cnt
5542  0e5e 1c0001        	addw	x,#1
5543  0e61 bf62          	ldw	_umax_cnt,x
5545  0e63 2003          	jra	L5162
5546  0e65               L3162:
5547                     ; 964 	else umax_cnt=0;
5549  0e65 5f            	clrw	x
5550  0e66 bf62          	ldw	_umax_cnt,x
5551  0e68               L5162:
5552                     ; 965 	gran(&umax_cnt,0,10);
5554  0e68 ae000a        	ldw	x,#10
5555  0e6b 89            	pushw	x
5556  0e6c 5f            	clrw	x
5557  0e6d 89            	pushw	x
5558  0e6e ae0062        	ldw	x,#_umax_cnt
5559  0e71 cd0000        	call	_gran
5561  0e74 5b04          	addw	sp,#4
5562                     ; 966 	if(umax_cnt>=10)flags|=0b00001000;
5564  0e76 9c            	rvf
5565  0e77 be62          	ldw	x,_umax_cnt
5566  0e79 a3000a        	cpw	x,#10
5567  0e7c 2f04          	jrslt	L7162
5570  0e7e 7216000a      	bset	_flags,#3
5571  0e82               L7162:
5572                     ; 969 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5574  0e82 9c            	rvf
5575  0e83 be67          	ldw	x,_Ui
5576  0e85 a300c8        	cpw	x,#200
5577  0e88 2e10          	jrsge	L1262
5579  0e8a c65005        	ld	a,20485
5580  0e8d a504          	bcp	a,#4
5581  0e8f 2609          	jrne	L1262
5584  0e91 be60          	ldw	x,_umin_cnt
5585  0e93 1c0001        	addw	x,#1
5586  0e96 bf60          	ldw	_umin_cnt,x
5588  0e98 2003          	jra	L3262
5589  0e9a               L1262:
5590                     ; 970 	else umin_cnt=0;
5592  0e9a 5f            	clrw	x
5593  0e9b bf60          	ldw	_umin_cnt,x
5594  0e9d               L3262:
5595                     ; 971 	gran(&umin_cnt,0,10);	
5597  0e9d ae000a        	ldw	x,#10
5598  0ea0 89            	pushw	x
5599  0ea1 5f            	clrw	x
5600  0ea2 89            	pushw	x
5601  0ea3 ae0060        	ldw	x,#_umin_cnt
5602  0ea6 cd0000        	call	_gran
5604  0ea9 5b04          	addw	sp,#4
5605                     ; 972 	if(umin_cnt>=10)flags|=0b00010000;	  
5607  0eab 9c            	rvf
5608  0eac be60          	ldw	x,_umin_cnt
5609  0eae a3000a        	cpw	x,#10
5610  0eb1 2f04          	jrslt	L7062
5613  0eb3 7218000a      	bset	_flags,#4
5614  0eb7               L7062:
5615                     ; 974 }
5618  0eb7 81            	ret
5645                     ; 977 void x_drv(void)
5645                     ; 978 {
5646                     	switch	.text
5647  0eb8               _x_drv:
5651                     ; 979 if(_x__==_x_)
5653  0eb8 be59          	ldw	x,__x__
5654  0eba b35b          	cpw	x,__x_
5655  0ebc 262a          	jrne	L7362
5656                     ; 981 	if(_x_cnt<60)
5658  0ebe 9c            	rvf
5659  0ebf be57          	ldw	x,__x_cnt
5660  0ec1 a3003c        	cpw	x,#60
5661  0ec4 2e25          	jrsge	L7462
5662                     ; 983 		_x_cnt++;
5664  0ec6 be57          	ldw	x,__x_cnt
5665  0ec8 1c0001        	addw	x,#1
5666  0ecb bf57          	ldw	__x_cnt,x
5667                     ; 984 		if(_x_cnt>=60)
5669  0ecd 9c            	rvf
5670  0ece be57          	ldw	x,__x_cnt
5671  0ed0 a3003c        	cpw	x,#60
5672  0ed3 2f16          	jrslt	L7462
5673                     ; 986 			if(_x_ee_!=_x_)_x_ee_=_x_;
5675  0ed5 ce0016        	ldw	x,__x_ee_
5676  0ed8 b35b          	cpw	x,__x_
5677  0eda 270f          	jreq	L7462
5680  0edc be5b          	ldw	x,__x_
5681  0ede 89            	pushw	x
5682  0edf ae0016        	ldw	x,#__x_ee_
5683  0ee2 cd0000        	call	c_eewrw
5685  0ee5 85            	popw	x
5686  0ee6 2003          	jra	L7462
5687  0ee8               L7362:
5688                     ; 991 else _x_cnt=0;
5690  0ee8 5f            	clrw	x
5691  0ee9 bf57          	ldw	__x_cnt,x
5692  0eeb               L7462:
5693                     ; 993 if(_x_cnt>60) _x_cnt=0;	
5695  0eeb 9c            	rvf
5696  0eec be57          	ldw	x,__x_cnt
5697  0eee a3003d        	cpw	x,#61
5698  0ef1 2f03          	jrslt	L1562
5701  0ef3 5f            	clrw	x
5702  0ef4 bf57          	ldw	__x_cnt,x
5703  0ef6               L1562:
5704                     ; 995 _x__=_x_;
5706  0ef6 be5b          	ldw	x,__x_
5707  0ef8 bf59          	ldw	__x__,x
5708                     ; 996 }
5711  0efa 81            	ret
5737                     ; 999 void apv_start(void)
5737                     ; 1000 {
5738                     	switch	.text
5739  0efb               _apv_start:
5743                     ; 1001 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5745  0efb 3d42          	tnz	_apv_cnt
5746  0efd 2624          	jrne	L3662
5748  0eff 3d43          	tnz	_apv_cnt+1
5749  0f01 2620          	jrne	L3662
5751  0f03 3d44          	tnz	_apv_cnt+2
5752  0f05 261c          	jrne	L3662
5754                     	btst	_bAPV
5755  0f0c 2515          	jrult	L3662
5756                     ; 1003 	apv_cnt[0]=60;
5758  0f0e 353c0042      	mov	_apv_cnt,#60
5759                     ; 1004 	apv_cnt[1]=60;
5761  0f12 353c0043      	mov	_apv_cnt+1,#60
5762                     ; 1005 	apv_cnt[2]=60;
5764  0f16 353c0044      	mov	_apv_cnt+2,#60
5765                     ; 1006 	apv_cnt_=3600;
5767  0f1a ae0e10        	ldw	x,#3600
5768  0f1d bf40          	ldw	_apv_cnt_,x
5769                     ; 1007 	bAPV=1;	
5771  0f1f 72100002      	bset	_bAPV
5772  0f23               L3662:
5773                     ; 1009 }
5776  0f23 81            	ret
5802                     ; 1012 void apv_stop(void)
5802                     ; 1013 {
5803                     	switch	.text
5804  0f24               _apv_stop:
5808                     ; 1014 apv_cnt[0]=0;
5810  0f24 3f42          	clr	_apv_cnt
5811                     ; 1015 apv_cnt[1]=0;
5813  0f26 3f43          	clr	_apv_cnt+1
5814                     ; 1016 apv_cnt[2]=0;
5816  0f28 3f44          	clr	_apv_cnt+2
5817                     ; 1017 apv_cnt_=0;	
5819  0f2a 5f            	clrw	x
5820  0f2b bf40          	ldw	_apv_cnt_,x
5821                     ; 1018 bAPV=0;
5823  0f2d 72110002      	bres	_bAPV
5824                     ; 1019 }
5827  0f31 81            	ret
5862                     ; 1023 void apv_hndl(void)
5862                     ; 1024 {
5863                     	switch	.text
5864  0f32               _apv_hndl:
5868                     ; 1025 if(apv_cnt[0])
5870  0f32 3d42          	tnz	_apv_cnt
5871  0f34 271e          	jreq	L5072
5872                     ; 1027 	apv_cnt[0]--;
5874  0f36 3a42          	dec	_apv_cnt
5875                     ; 1028 	if(apv_cnt[0]==0)
5877  0f38 3d42          	tnz	_apv_cnt
5878  0f3a 265a          	jrne	L1172
5879                     ; 1030 		flags&=0b11100001;
5881  0f3c b60a          	ld	a,_flags
5882  0f3e a4e1          	and	a,#225
5883  0f40 b70a          	ld	_flags,a
5884                     ; 1031 		tsign_cnt=0;
5886  0f42 5f            	clrw	x
5887  0f43 bf4a          	ldw	_tsign_cnt,x
5888                     ; 1032 		tmax_cnt=0;
5890  0f45 5f            	clrw	x
5891  0f46 bf48          	ldw	_tmax_cnt,x
5892                     ; 1033 		umax_cnt=0;
5894  0f48 5f            	clrw	x
5895  0f49 bf62          	ldw	_umax_cnt,x
5896                     ; 1034 		umin_cnt=0;
5898  0f4b 5f            	clrw	x
5899  0f4c bf60          	ldw	_umin_cnt,x
5900                     ; 1036 		led_drv_cnt=30;
5902  0f4e 351e0019      	mov	_led_drv_cnt,#30
5903  0f52 2042          	jra	L1172
5904  0f54               L5072:
5905                     ; 1039 else if(apv_cnt[1])
5907  0f54 3d43          	tnz	_apv_cnt+1
5908  0f56 271e          	jreq	L3172
5909                     ; 1041 	apv_cnt[1]--;
5911  0f58 3a43          	dec	_apv_cnt+1
5912                     ; 1042 	if(apv_cnt[1]==0)
5914  0f5a 3d43          	tnz	_apv_cnt+1
5915  0f5c 2638          	jrne	L1172
5916                     ; 1044 		flags&=0b11100001;
5918  0f5e b60a          	ld	a,_flags
5919  0f60 a4e1          	and	a,#225
5920  0f62 b70a          	ld	_flags,a
5921                     ; 1045 		tsign_cnt=0;
5923  0f64 5f            	clrw	x
5924  0f65 bf4a          	ldw	_tsign_cnt,x
5925                     ; 1046 		tmax_cnt=0;
5927  0f67 5f            	clrw	x
5928  0f68 bf48          	ldw	_tmax_cnt,x
5929                     ; 1047 		umax_cnt=0;
5931  0f6a 5f            	clrw	x
5932  0f6b bf62          	ldw	_umax_cnt,x
5933                     ; 1048 		umin_cnt=0;
5935  0f6d 5f            	clrw	x
5936  0f6e bf60          	ldw	_umin_cnt,x
5937                     ; 1050 		led_drv_cnt=30;
5939  0f70 351e0019      	mov	_led_drv_cnt,#30
5940  0f74 2020          	jra	L1172
5941  0f76               L3172:
5942                     ; 1053 else if(apv_cnt[2])
5944  0f76 3d44          	tnz	_apv_cnt+2
5945  0f78 271c          	jreq	L1172
5946                     ; 1055 	apv_cnt[2]--;
5948  0f7a 3a44          	dec	_apv_cnt+2
5949                     ; 1056 	if(apv_cnt[2]==0)
5951  0f7c 3d44          	tnz	_apv_cnt+2
5952  0f7e 2616          	jrne	L1172
5953                     ; 1058 		flags&=0b11100001;
5955  0f80 b60a          	ld	a,_flags
5956  0f82 a4e1          	and	a,#225
5957  0f84 b70a          	ld	_flags,a
5958                     ; 1059 		tsign_cnt=0;
5960  0f86 5f            	clrw	x
5961  0f87 bf4a          	ldw	_tsign_cnt,x
5962                     ; 1060 		tmax_cnt=0;
5964  0f89 5f            	clrw	x
5965  0f8a bf48          	ldw	_tmax_cnt,x
5966                     ; 1061 		umax_cnt=0;
5968  0f8c 5f            	clrw	x
5969  0f8d bf62          	ldw	_umax_cnt,x
5970                     ; 1062 		umin_cnt=0;          
5972  0f8f 5f            	clrw	x
5973  0f90 bf60          	ldw	_umin_cnt,x
5974                     ; 1064 		led_drv_cnt=30;
5976  0f92 351e0019      	mov	_led_drv_cnt,#30
5977  0f96               L1172:
5978                     ; 1068 if(apv_cnt_)
5980  0f96 be40          	ldw	x,_apv_cnt_
5981  0f98 2712          	jreq	L5272
5982                     ; 1070 	apv_cnt_--;
5984  0f9a be40          	ldw	x,_apv_cnt_
5985  0f9c 1d0001        	subw	x,#1
5986  0f9f bf40          	ldw	_apv_cnt_,x
5987                     ; 1071 	if(apv_cnt_==0) 
5989  0fa1 be40          	ldw	x,_apv_cnt_
5990  0fa3 2607          	jrne	L5272
5991                     ; 1073 		bAPV=0;
5993  0fa5 72110002      	bres	_bAPV
5994                     ; 1074 		apv_start();
5996  0fa9 cd0efb        	call	_apv_start
5998  0fac               L5272:
5999                     ; 1078 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6001  0fac be60          	ldw	x,_umin_cnt
6002  0fae 261e          	jrne	L1372
6004  0fb0 be62          	ldw	x,_umax_cnt
6005  0fb2 261a          	jrne	L1372
6007  0fb4 c65005        	ld	a,20485
6008  0fb7 a504          	bcp	a,#4
6009  0fb9 2613          	jrne	L1372
6010                     ; 1080 	if(cnt_apv_off<20)
6012  0fbb b63f          	ld	a,_cnt_apv_off
6013  0fbd a114          	cp	a,#20
6014  0fbf 240f          	jruge	L7372
6015                     ; 1082 		cnt_apv_off++;
6017  0fc1 3c3f          	inc	_cnt_apv_off
6018                     ; 1083 		if(cnt_apv_off>=20)
6020  0fc3 b63f          	ld	a,_cnt_apv_off
6021  0fc5 a114          	cp	a,#20
6022  0fc7 2507          	jrult	L7372
6023                     ; 1085 			apv_stop();
6025  0fc9 cd0f24        	call	_apv_stop
6027  0fcc 2002          	jra	L7372
6028  0fce               L1372:
6029                     ; 1089 else cnt_apv_off=0;	
6031  0fce 3f3f          	clr	_cnt_apv_off
6032  0fd0               L7372:
6033                     ; 1091 }
6036  0fd0 81            	ret
6039                     	switch	.ubsct
6040  0000               L1472_flags_old:
6041  0000 00            	ds.b	1
6077                     ; 1094 void flags_drv(void)
6077                     ; 1095 {
6078                     	switch	.text
6079  0fd1               _flags_drv:
6083                     ; 1097 if(jp_mode!=jp3) 
6085  0fd1 b647          	ld	a,_jp_mode
6086  0fd3 a103          	cp	a,#3
6087  0fd5 2723          	jreq	L1672
6088                     ; 1099 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6090  0fd7 b60a          	ld	a,_flags
6091  0fd9 a508          	bcp	a,#8
6092  0fdb 2706          	jreq	L7672
6094  0fdd b600          	ld	a,L1472_flags_old
6095  0fdf a508          	bcp	a,#8
6096  0fe1 270c          	jreq	L5672
6097  0fe3               L7672:
6099  0fe3 b60a          	ld	a,_flags
6100  0fe5 a510          	bcp	a,#16
6101  0fe7 2726          	jreq	L3772
6103  0fe9 b600          	ld	a,L1472_flags_old
6104  0feb a510          	bcp	a,#16
6105  0fed 2620          	jrne	L3772
6106  0fef               L5672:
6107                     ; 1101     		if(link==OFF)apv_start();
6109  0fef b65f          	ld	a,_link
6110  0ff1 a1aa          	cp	a,#170
6111  0ff3 261a          	jrne	L3772
6114  0ff5 cd0efb        	call	_apv_start
6116  0ff8 2015          	jra	L3772
6117  0ffa               L1672:
6118                     ; 1104 else if(jp_mode==jp3) 
6120  0ffa b647          	ld	a,_jp_mode
6121  0ffc a103          	cp	a,#3
6122  0ffe 260f          	jrne	L3772
6123                     ; 1106 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6125  1000 b60a          	ld	a,_flags
6126  1002 a508          	bcp	a,#8
6127  1004 2709          	jreq	L3772
6129  1006 b600          	ld	a,L1472_flags_old
6130  1008 a508          	bcp	a,#8
6131  100a 2603          	jrne	L3772
6132                     ; 1108     		apv_start();
6134  100c cd0efb        	call	_apv_start
6136  100f               L3772:
6137                     ; 1111 flags_old=flags;
6139  100f 450a00        	mov	L1472_flags_old,_flags
6140                     ; 1113 } 
6143  1012 81            	ret
6178                     ; 1250 void adr_drv_v4(char in)
6178                     ; 1251 {
6179                     	switch	.text
6180  1013               _adr_drv_v4:
6184                     ; 1252 if(adress!=in)adress=in;
6186  1013 c10001        	cp	a,_adress
6187  1016 2703          	jreq	L7103
6190  1018 c70001        	ld	_adress,a
6191  101b               L7103:
6192                     ; 1253 }
6195  101b 81            	ret
6224                     ; 1256 void adr_drv_v3(void)
6224                     ; 1257 {
6225                     	switch	.text
6226  101c               _adr_drv_v3:
6228  101c 88            	push	a
6229       00000001      OFST:	set	1
6232                     ; 1263 GPIOB->DDR&=~(1<<0);
6234  101d 72115007      	bres	20487,#0
6235                     ; 1264 GPIOB->CR1&=~(1<<0);
6237  1021 72115008      	bres	20488,#0
6238                     ; 1265 GPIOB->CR2&=~(1<<0);
6240  1025 72115009      	bres	20489,#0
6241                     ; 1266 ADC2->CR2=0x08;
6243  1029 35085402      	mov	21506,#8
6244                     ; 1267 ADC2->CR1=0x40;
6246  102d 35405401      	mov	21505,#64
6247                     ; 1268 ADC2->CSR=0x20+0;
6249  1031 35205400      	mov	21504,#32
6250                     ; 1269 ADC2->CR1|=1;
6252  1035 72105401      	bset	21505,#0
6253                     ; 1270 ADC2->CR1|=1;
6255  1039 72105401      	bset	21505,#0
6256                     ; 1271 adr_drv_stat=1;
6258  103d 35010007      	mov	_adr_drv_stat,#1
6259  1041               L1303:
6260                     ; 1272 while(adr_drv_stat==1);
6263  1041 b607          	ld	a,_adr_drv_stat
6264  1043 a101          	cp	a,#1
6265  1045 27fa          	jreq	L1303
6266                     ; 1274 GPIOB->DDR&=~(1<<1);
6268  1047 72135007      	bres	20487,#1
6269                     ; 1275 GPIOB->CR1&=~(1<<1);
6271  104b 72135008      	bres	20488,#1
6272                     ; 1276 GPIOB->CR2&=~(1<<1);
6274  104f 72135009      	bres	20489,#1
6275                     ; 1277 ADC2->CR2=0x08;
6277  1053 35085402      	mov	21506,#8
6278                     ; 1278 ADC2->CR1=0x40;
6280  1057 35405401      	mov	21505,#64
6281                     ; 1279 ADC2->CSR=0x20+1;
6283  105b 35215400      	mov	21504,#33
6284                     ; 1280 ADC2->CR1|=1;
6286  105f 72105401      	bset	21505,#0
6287                     ; 1281 ADC2->CR1|=1;
6289  1063 72105401      	bset	21505,#0
6290                     ; 1282 adr_drv_stat=3;
6292  1067 35030007      	mov	_adr_drv_stat,#3
6293  106b               L7303:
6294                     ; 1283 while(adr_drv_stat==3);
6297  106b b607          	ld	a,_adr_drv_stat
6298  106d a103          	cp	a,#3
6299  106f 27fa          	jreq	L7303
6300                     ; 1285 GPIOE->DDR&=~(1<<6);
6302  1071 721d5016      	bres	20502,#6
6303                     ; 1286 GPIOE->CR1&=~(1<<6);
6305  1075 721d5017      	bres	20503,#6
6306                     ; 1287 GPIOE->CR2&=~(1<<6);
6308  1079 721d5018      	bres	20504,#6
6309                     ; 1288 ADC2->CR2=0x08;
6311  107d 35085402      	mov	21506,#8
6312                     ; 1289 ADC2->CR1=0x40;
6314  1081 35405401      	mov	21505,#64
6315                     ; 1290 ADC2->CSR=0x20+9;
6317  1085 35295400      	mov	21504,#41
6318                     ; 1291 ADC2->CR1|=1;
6320  1089 72105401      	bset	21505,#0
6321                     ; 1292 ADC2->CR1|=1;
6323  108d 72105401      	bset	21505,#0
6324                     ; 1293 adr_drv_stat=5;
6326  1091 35050007      	mov	_adr_drv_stat,#5
6327  1095               L5403:
6328                     ; 1294 while(adr_drv_stat==5);
6331  1095 b607          	ld	a,_adr_drv_stat
6332  1097 a105          	cp	a,#5
6333  1099 27fa          	jreq	L5403
6334                     ; 1298 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6336  109b 9c            	rvf
6337  109c ce0005        	ldw	x,_adc_buff_
6338  109f a3022a        	cpw	x,#554
6339  10a2 2f0f          	jrslt	L3503
6341  10a4 9c            	rvf
6342  10a5 ce0005        	ldw	x,_adc_buff_
6343  10a8 a30253        	cpw	x,#595
6344  10ab 2e06          	jrsge	L3503
6347  10ad 725f0002      	clr	_adr
6349  10b1 204c          	jra	L5503
6350  10b3               L3503:
6351                     ; 1299 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6353  10b3 9c            	rvf
6354  10b4 ce0005        	ldw	x,_adc_buff_
6355  10b7 a3036d        	cpw	x,#877
6356  10ba 2f0f          	jrslt	L7503
6358  10bc 9c            	rvf
6359  10bd ce0005        	ldw	x,_adc_buff_
6360  10c0 a30396        	cpw	x,#918
6361  10c3 2e06          	jrsge	L7503
6364  10c5 35010002      	mov	_adr,#1
6366  10c9 2034          	jra	L5503
6367  10cb               L7503:
6368                     ; 1300 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6370  10cb 9c            	rvf
6371  10cc ce0005        	ldw	x,_adc_buff_
6372  10cf a302a3        	cpw	x,#675
6373  10d2 2f0f          	jrslt	L3603
6375  10d4 9c            	rvf
6376  10d5 ce0005        	ldw	x,_adc_buff_
6377  10d8 a302cc        	cpw	x,#716
6378  10db 2e06          	jrsge	L3603
6381  10dd 35020002      	mov	_adr,#2
6383  10e1 201c          	jra	L5503
6384  10e3               L3603:
6385                     ; 1301 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6387  10e3 9c            	rvf
6388  10e4 ce0005        	ldw	x,_adc_buff_
6389  10e7 a303e3        	cpw	x,#995
6390  10ea 2f0f          	jrslt	L7603
6392  10ec 9c            	rvf
6393  10ed ce0005        	ldw	x,_adc_buff_
6394  10f0 a3040c        	cpw	x,#1036
6395  10f3 2e06          	jrsge	L7603
6398  10f5 35030002      	mov	_adr,#3
6400  10f9 2004          	jra	L5503
6401  10fb               L7603:
6402                     ; 1302 else adr[0]=5;
6404  10fb 35050002      	mov	_adr,#5
6405  10ff               L5503:
6406                     ; 1304 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6408  10ff 9c            	rvf
6409  1100 ce0007        	ldw	x,_adc_buff_+2
6410  1103 a3022a        	cpw	x,#554
6411  1106 2f0f          	jrslt	L3703
6413  1108 9c            	rvf
6414  1109 ce0007        	ldw	x,_adc_buff_+2
6415  110c a30253        	cpw	x,#595
6416  110f 2e06          	jrsge	L3703
6419  1111 725f0003      	clr	_adr+1
6421  1115 204c          	jra	L5703
6422  1117               L3703:
6423                     ; 1305 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6425  1117 9c            	rvf
6426  1118 ce0007        	ldw	x,_adc_buff_+2
6427  111b a3036d        	cpw	x,#877
6428  111e 2f0f          	jrslt	L7703
6430  1120 9c            	rvf
6431  1121 ce0007        	ldw	x,_adc_buff_+2
6432  1124 a30396        	cpw	x,#918
6433  1127 2e06          	jrsge	L7703
6436  1129 35010003      	mov	_adr+1,#1
6438  112d 2034          	jra	L5703
6439  112f               L7703:
6440                     ; 1306 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6442  112f 9c            	rvf
6443  1130 ce0007        	ldw	x,_adc_buff_+2
6444  1133 a302a3        	cpw	x,#675
6445  1136 2f0f          	jrslt	L3013
6447  1138 9c            	rvf
6448  1139 ce0007        	ldw	x,_adc_buff_+2
6449  113c a302cc        	cpw	x,#716
6450  113f 2e06          	jrsge	L3013
6453  1141 35020003      	mov	_adr+1,#2
6455  1145 201c          	jra	L5703
6456  1147               L3013:
6457                     ; 1307 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6459  1147 9c            	rvf
6460  1148 ce0007        	ldw	x,_adc_buff_+2
6461  114b a303e3        	cpw	x,#995
6462  114e 2f0f          	jrslt	L7013
6464  1150 9c            	rvf
6465  1151 ce0007        	ldw	x,_adc_buff_+2
6466  1154 a3040c        	cpw	x,#1036
6467  1157 2e06          	jrsge	L7013
6470  1159 35030003      	mov	_adr+1,#3
6472  115d 2004          	jra	L5703
6473  115f               L7013:
6474                     ; 1308 else adr[1]=5;
6476  115f 35050003      	mov	_adr+1,#5
6477  1163               L5703:
6478                     ; 1310 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6480  1163 9c            	rvf
6481  1164 ce0017        	ldw	x,_adc_buff_+18
6482  1167 a3022a        	cpw	x,#554
6483  116a 2f0f          	jrslt	L3113
6485  116c 9c            	rvf
6486  116d ce0017        	ldw	x,_adc_buff_+18
6487  1170 a30253        	cpw	x,#595
6488  1173 2e06          	jrsge	L3113
6491  1175 725f0004      	clr	_adr+2
6493  1179 204c          	jra	L5113
6494  117b               L3113:
6495                     ; 1311 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6497  117b 9c            	rvf
6498  117c ce0017        	ldw	x,_adc_buff_+18
6499  117f a3036d        	cpw	x,#877
6500  1182 2f0f          	jrslt	L7113
6502  1184 9c            	rvf
6503  1185 ce0017        	ldw	x,_adc_buff_+18
6504  1188 a30396        	cpw	x,#918
6505  118b 2e06          	jrsge	L7113
6508  118d 35010004      	mov	_adr+2,#1
6510  1191 2034          	jra	L5113
6511  1193               L7113:
6512                     ; 1312 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6514  1193 9c            	rvf
6515  1194 ce0017        	ldw	x,_adc_buff_+18
6516  1197 a302a3        	cpw	x,#675
6517  119a 2f0f          	jrslt	L3213
6519  119c 9c            	rvf
6520  119d ce0017        	ldw	x,_adc_buff_+18
6521  11a0 a302cc        	cpw	x,#716
6522  11a3 2e06          	jrsge	L3213
6525  11a5 35020004      	mov	_adr+2,#2
6527  11a9 201c          	jra	L5113
6528  11ab               L3213:
6529                     ; 1313 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6531  11ab 9c            	rvf
6532  11ac ce0017        	ldw	x,_adc_buff_+18
6533  11af a303e3        	cpw	x,#995
6534  11b2 2f0f          	jrslt	L7213
6536  11b4 9c            	rvf
6537  11b5 ce0017        	ldw	x,_adc_buff_+18
6538  11b8 a3040c        	cpw	x,#1036
6539  11bb 2e06          	jrsge	L7213
6542  11bd 35030004      	mov	_adr+2,#3
6544  11c1 2004          	jra	L5113
6545  11c3               L7213:
6546                     ; 1314 else adr[2]=5;
6548  11c3 35050004      	mov	_adr+2,#5
6549  11c7               L5113:
6550                     ; 1318 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6552  11c7 c60002        	ld	a,_adr
6553  11ca a105          	cp	a,#5
6554  11cc 270e          	jreq	L5313
6556  11ce c60003        	ld	a,_adr+1
6557  11d1 a105          	cp	a,#5
6558  11d3 2707          	jreq	L5313
6560  11d5 c60004        	ld	a,_adr+2
6561  11d8 a105          	cp	a,#5
6562  11da 2606          	jrne	L3313
6563  11dc               L5313:
6564                     ; 1321 	adress_error=1;
6566  11dc 35010000      	mov	_adress_error,#1
6568  11e0               L1413:
6569                     ; 1332 }
6572  11e0 84            	pop	a
6573  11e1 81            	ret
6574  11e2               L3313:
6575                     ; 1325 	if(adr[2]&0x02) bps_class=bpsIPS;
6577  11e2 c60004        	ld	a,_adr+2
6578  11e5 a502          	bcp	a,#2
6579  11e7 2706          	jreq	L3413
6582  11e9 35010001      	mov	_bps_class,#1
6584  11ed 2002          	jra	L5413
6585  11ef               L3413:
6586                     ; 1326 	else bps_class=bpsIBEP;
6588  11ef 3f01          	clr	_bps_class
6589  11f1               L5413:
6590                     ; 1328 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6592  11f1 c60004        	ld	a,_adr+2
6593  11f4 a401          	and	a,#1
6594  11f6 97            	ld	xl,a
6595  11f7 a610          	ld	a,#16
6596  11f9 42            	mul	x,a
6597  11fa 9f            	ld	a,xl
6598  11fb 6b01          	ld	(OFST+0,sp),a
6599  11fd c60003        	ld	a,_adr+1
6600  1200 48            	sll	a
6601  1201 48            	sll	a
6602  1202 cb0002        	add	a,_adr
6603  1205 1b01          	add	a,(OFST+0,sp)
6604  1207 c70001        	ld	_adress,a
6605  120a 20d4          	jra	L1413
6649                     ; 1335 void volum_u_main_drv(void)
6649                     ; 1336 {
6650                     	switch	.text
6651  120c               _volum_u_main_drv:
6653  120c 88            	push	a
6654       00000001      OFST:	set	1
6657                     ; 1339 if(bMAIN)
6659                     	btst	_bMAIN
6660  1212 2503          	jrult	L031
6661  1214 cc135d        	jp	L5613
6662  1217               L031:
6663                     ; 1341 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6665  1217 9c            	rvf
6666  1218 ce0006        	ldw	x,_UU_AVT
6667  121b 1d000a        	subw	x,#10
6668  121e b369          	cpw	x,_Un
6669  1220 2d09          	jrsle	L7613
6672  1222 be1c          	ldw	x,_volum_u_main_
6673  1224 1c0005        	addw	x,#5
6674  1227 bf1c          	ldw	_volum_u_main_,x
6676  1229 2036          	jra	L1713
6677  122b               L7613:
6678                     ; 1342 	else if(Un<(UU_AVT-1))volum_u_main_++;
6680  122b 9c            	rvf
6681  122c ce0006        	ldw	x,_UU_AVT
6682  122f 5a            	decw	x
6683  1230 b369          	cpw	x,_Un
6684  1232 2d09          	jrsle	L3713
6687  1234 be1c          	ldw	x,_volum_u_main_
6688  1236 1c0001        	addw	x,#1
6689  1239 bf1c          	ldw	_volum_u_main_,x
6691  123b 2024          	jra	L1713
6692  123d               L3713:
6693                     ; 1343 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
6695  123d 9c            	rvf
6696  123e ce0006        	ldw	x,_UU_AVT
6697  1241 1c000a        	addw	x,#10
6698  1244 b369          	cpw	x,_Un
6699  1246 2e09          	jrsge	L7713
6702  1248 be1c          	ldw	x,_volum_u_main_
6703  124a 1d000a        	subw	x,#10
6704  124d bf1c          	ldw	_volum_u_main_,x
6706  124f 2010          	jra	L1713
6707  1251               L7713:
6708                     ; 1344 	else if(Un>(UU_AVT+1))volum_u_main_--;
6710  1251 9c            	rvf
6711  1252 ce0006        	ldw	x,_UU_AVT
6712  1255 5c            	incw	x
6713  1256 b369          	cpw	x,_Un
6714  1258 2e07          	jrsge	L1713
6717  125a be1c          	ldw	x,_volum_u_main_
6718  125c 1d0001        	subw	x,#1
6719  125f bf1c          	ldw	_volum_u_main_,x
6720  1261               L1713:
6721                     ; 1345 	if(volum_u_main_>1020)volum_u_main_=1020;
6723  1261 9c            	rvf
6724  1262 be1c          	ldw	x,_volum_u_main_
6725  1264 a303fd        	cpw	x,#1021
6726  1267 2f05          	jrslt	L5023
6729  1269 ae03fc        	ldw	x,#1020
6730  126c bf1c          	ldw	_volum_u_main_,x
6731  126e               L5023:
6732                     ; 1346 	if(volum_u_main_<0)volum_u_main_=0;
6734  126e 9c            	rvf
6735  126f be1c          	ldw	x,_volum_u_main_
6736  1271 2e03          	jrsge	L7023
6739  1273 5f            	clrw	x
6740  1274 bf1c          	ldw	_volum_u_main_,x
6741  1276               L7023:
6742                     ; 1349 	i_main_sigma=0;
6744  1276 5f            	clrw	x
6745  1277 bf0c          	ldw	_i_main_sigma,x
6746                     ; 1350 	i_main_num_of_bps=0;
6748  1279 3f0e          	clr	_i_main_num_of_bps
6749                     ; 1351 	for(i=0;i<6;i++)
6751  127b 0f01          	clr	(OFST+0,sp)
6752  127d               L1123:
6753                     ; 1353 		if(i_main_flag[i])
6755  127d 7b01          	ld	a,(OFST+0,sp)
6756  127f 5f            	clrw	x
6757  1280 97            	ld	xl,a
6758  1281 6d11          	tnz	(_i_main_flag,x)
6759  1283 2719          	jreq	L7123
6760                     ; 1355 			i_main_sigma+=i_main[i];
6762  1285 7b01          	ld	a,(OFST+0,sp)
6763  1287 5f            	clrw	x
6764  1288 97            	ld	xl,a
6765  1289 58            	sllw	x
6766  128a ee17          	ldw	x,(_i_main,x)
6767  128c 72bb000c      	addw	x,_i_main_sigma
6768  1290 bf0c          	ldw	_i_main_sigma,x
6769                     ; 1356 			i_main_flag[i]=1;
6771  1292 7b01          	ld	a,(OFST+0,sp)
6772  1294 5f            	clrw	x
6773  1295 97            	ld	xl,a
6774  1296 a601          	ld	a,#1
6775  1298 e711          	ld	(_i_main_flag,x),a
6776                     ; 1357 			i_main_num_of_bps++;
6778  129a 3c0e          	inc	_i_main_num_of_bps
6780  129c 2006          	jra	L1223
6781  129e               L7123:
6782                     ; 1361 			i_main_flag[i]=0;	
6784  129e 7b01          	ld	a,(OFST+0,sp)
6785  12a0 5f            	clrw	x
6786  12a1 97            	ld	xl,a
6787  12a2 6f11          	clr	(_i_main_flag,x)
6788  12a4               L1223:
6789                     ; 1351 	for(i=0;i<6;i++)
6791  12a4 0c01          	inc	(OFST+0,sp)
6794  12a6 7b01          	ld	a,(OFST+0,sp)
6795  12a8 a106          	cp	a,#6
6796  12aa 25d1          	jrult	L1123
6797                     ; 1364 	i_main_avg=i_main_sigma/i_main_num_of_bps;
6799  12ac be0c          	ldw	x,_i_main_sigma
6800  12ae b60e          	ld	a,_i_main_num_of_bps
6801  12b0 905f          	clrw	y
6802  12b2 9097          	ld	yl,a
6803  12b4 cd0000        	call	c_idiv
6805  12b7 bf0f          	ldw	_i_main_avg,x
6806                     ; 1365 	for(i=0;i<6;i++)
6808  12b9 0f01          	clr	(OFST+0,sp)
6809  12bb               L3223:
6810                     ; 1367 		if(i_main_flag[i])
6812  12bb 7b01          	ld	a,(OFST+0,sp)
6813  12bd 5f            	clrw	x
6814  12be 97            	ld	xl,a
6815  12bf 6d11          	tnz	(_i_main_flag,x)
6816  12c1 2603cc1352    	jreq	L1323
6817                     ; 1369 			if(i_main[i]<(i_main_avg-10))x[i]++;
6819  12c6 9c            	rvf
6820  12c7 7b01          	ld	a,(OFST+0,sp)
6821  12c9 5f            	clrw	x
6822  12ca 97            	ld	xl,a
6823  12cb 58            	sllw	x
6824  12cc 90be0f        	ldw	y,_i_main_avg
6825  12cf 72a2000a      	subw	y,#10
6826  12d3 90bf00        	ldw	c_y,y
6827  12d6 9093          	ldw	y,x
6828  12d8 90ee17        	ldw	y,(_i_main,y)
6829  12db 90b300        	cpw	y,c_y
6830  12de 2e11          	jrsge	L3323
6833  12e0 7b01          	ld	a,(OFST+0,sp)
6834  12e2 5f            	clrw	x
6835  12e3 97            	ld	xl,a
6836  12e4 58            	sllw	x
6837  12e5 9093          	ldw	y,x
6838  12e7 ee23          	ldw	x,(_x,x)
6839  12e9 1c0001        	addw	x,#1
6840  12ec 90ef23        	ldw	(_x,y),x
6842  12ef 2029          	jra	L5323
6843  12f1               L3323:
6844                     ; 1370 			else if(i_main[i]>(i_main_avg+10))x[i]--;
6846  12f1 9c            	rvf
6847  12f2 7b01          	ld	a,(OFST+0,sp)
6848  12f4 5f            	clrw	x
6849  12f5 97            	ld	xl,a
6850  12f6 58            	sllw	x
6851  12f7 90be0f        	ldw	y,_i_main_avg
6852  12fa 72a9000a      	addw	y,#10
6853  12fe 90bf00        	ldw	c_y,y
6854  1301 9093          	ldw	y,x
6855  1303 90ee17        	ldw	y,(_i_main,y)
6856  1306 90b300        	cpw	y,c_y
6857  1309 2d0f          	jrsle	L5323
6860  130b 7b01          	ld	a,(OFST+0,sp)
6861  130d 5f            	clrw	x
6862  130e 97            	ld	xl,a
6863  130f 58            	sllw	x
6864  1310 9093          	ldw	y,x
6865  1312 ee23          	ldw	x,(_x,x)
6866  1314 1d0001        	subw	x,#1
6867  1317 90ef23        	ldw	(_x,y),x
6868  131a               L5323:
6869                     ; 1371 			if(x[i]>100)x[i]=100;
6871  131a 9c            	rvf
6872  131b 7b01          	ld	a,(OFST+0,sp)
6873  131d 5f            	clrw	x
6874  131e 97            	ld	xl,a
6875  131f 58            	sllw	x
6876  1320 9093          	ldw	y,x
6877  1322 90ee23        	ldw	y,(_x,y)
6878  1325 90a30065      	cpw	y,#101
6879  1329 2f0b          	jrslt	L1423
6882  132b 7b01          	ld	a,(OFST+0,sp)
6883  132d 5f            	clrw	x
6884  132e 97            	ld	xl,a
6885  132f 58            	sllw	x
6886  1330 90ae0064      	ldw	y,#100
6887  1334 ef23          	ldw	(_x,x),y
6888  1336               L1423:
6889                     ; 1372 			if(x[i]<-100)x[i]=-100;
6891  1336 9c            	rvf
6892  1337 7b01          	ld	a,(OFST+0,sp)
6893  1339 5f            	clrw	x
6894  133a 97            	ld	xl,a
6895  133b 58            	sllw	x
6896  133c 9093          	ldw	y,x
6897  133e 90ee23        	ldw	y,(_x,y)
6898  1341 90a3ff9c      	cpw	y,#65436
6899  1345 2e0b          	jrsge	L1323
6902  1347 7b01          	ld	a,(OFST+0,sp)
6903  1349 5f            	clrw	x
6904  134a 97            	ld	xl,a
6905  134b 58            	sllw	x
6906  134c 90aeff9c      	ldw	y,#65436
6907  1350 ef23          	ldw	(_x,x),y
6908  1352               L1323:
6909                     ; 1365 	for(i=0;i<6;i++)
6911  1352 0c01          	inc	(OFST+0,sp)
6914  1354 7b01          	ld	a,(OFST+0,sp)
6915  1356 a106          	cp	a,#6
6916  1358 2403cc12bb    	jrult	L3223
6917  135d               L5613:
6918                     ; 1379 }
6921  135d 84            	pop	a
6922  135e 81            	ret
6945                     ; 1382 void init_CAN(void) {
6946                     	switch	.text
6947  135f               _init_CAN:
6951                     ; 1383 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6953  135f 72135420      	bres	21536,#1
6954                     ; 1384 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6956  1363 72105420      	bset	21536,#0
6958  1367               L7523:
6959                     ; 1385 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6961  1367 c65421        	ld	a,21537
6962  136a a501          	bcp	a,#1
6963  136c 27f9          	jreq	L7523
6964                     ; 1387 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6966  136e 72185420      	bset	21536,#4
6967                     ; 1389 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6969  1372 35025427      	mov	21543,#2
6970                     ; 1398 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6972  1376 35135428      	mov	21544,#19
6973                     ; 1399 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6975  137a 35c05429      	mov	21545,#192
6976                     ; 1400 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6978  137e 357f542c      	mov	21548,#127
6979                     ; 1401 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6981  1382 35e0542d      	mov	21549,#224
6982                     ; 1403 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6984  1386 35315430      	mov	21552,#49
6985                     ; 1404 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6987  138a 35c05431      	mov	21553,#192
6988                     ; 1405 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6990  138e 357f5434      	mov	21556,#127
6991                     ; 1406 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6993  1392 35e05435      	mov	21557,#224
6994                     ; 1410 	CAN->PSR= 6;									// set page 6
6996  1396 35065427      	mov	21543,#6
6997                     ; 1415 	CAN->Page.Config.FMR1&=~3;								//mask mode
6999  139a c65430        	ld	a,21552
7000  139d a4fc          	and	a,#252
7001  139f c75430        	ld	21552,a
7002                     ; 1421 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7004  13a2 35065432      	mov	21554,#6
7005                     ; 1422 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7007  13a6 35605432      	mov	21554,#96
7008                     ; 1425 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7010  13aa 72105432      	bset	21554,#0
7011                     ; 1426 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7013  13ae 72185432      	bset	21554,#4
7014                     ; 1429 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7016  13b2 35065427      	mov	21543,#6
7017                     ; 1431 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7019  13b6 3509542c      	mov	21548,#9
7020                     ; 1432 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7022  13ba 35e7542d      	mov	21549,#231
7023                     ; 1434 	CAN->IER|=(1<<1);
7025  13be 72125425      	bset	21541,#1
7026                     ; 1437 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7028  13c2 72115420      	bres	21536,#0
7030  13c6               L5623:
7031                     ; 1438 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7033  13c6 c65421        	ld	a,21537
7034  13c9 a501          	bcp	a,#1
7035  13cb 26f9          	jrne	L5623
7036                     ; 1439 }
7039  13cd 81            	ret
7147                     ; 1442 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7147                     ; 1443 {
7148                     	switch	.text
7149  13ce               _can_transmit:
7151  13ce 89            	pushw	x
7152       00000000      OFST:	set	0
7155                     ; 1445 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7157  13cf b670          	ld	a,_can_buff_wr_ptr
7158  13d1 a104          	cp	a,#4
7159  13d3 2502          	jrult	L7433
7162  13d5 3f70          	clr	_can_buff_wr_ptr
7163  13d7               L7433:
7164                     ; 1447 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7166  13d7 b670          	ld	a,_can_buff_wr_ptr
7167  13d9 97            	ld	xl,a
7168  13da a610          	ld	a,#16
7169  13dc 42            	mul	x,a
7170  13dd 1601          	ldw	y,(OFST+1,sp)
7171  13df a606          	ld	a,#6
7172  13e1               L631:
7173  13e1 9054          	srlw	y
7174  13e3 4a            	dec	a
7175  13e4 26fb          	jrne	L631
7176  13e6 909f          	ld	a,yl
7177  13e8 e771          	ld	(_can_out_buff,x),a
7178                     ; 1448 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7180  13ea b670          	ld	a,_can_buff_wr_ptr
7181  13ec 97            	ld	xl,a
7182  13ed a610          	ld	a,#16
7183  13ef 42            	mul	x,a
7184  13f0 7b02          	ld	a,(OFST+2,sp)
7185  13f2 48            	sll	a
7186  13f3 48            	sll	a
7187  13f4 e772          	ld	(_can_out_buff+1,x),a
7188                     ; 1450 can_out_buff[can_buff_wr_ptr][2]=data0;
7190  13f6 b670          	ld	a,_can_buff_wr_ptr
7191  13f8 97            	ld	xl,a
7192  13f9 a610          	ld	a,#16
7193  13fb 42            	mul	x,a
7194  13fc 7b05          	ld	a,(OFST+5,sp)
7195  13fe e773          	ld	(_can_out_buff+2,x),a
7196                     ; 1451 can_out_buff[can_buff_wr_ptr][3]=data1;
7198  1400 b670          	ld	a,_can_buff_wr_ptr
7199  1402 97            	ld	xl,a
7200  1403 a610          	ld	a,#16
7201  1405 42            	mul	x,a
7202  1406 7b06          	ld	a,(OFST+6,sp)
7203  1408 e774          	ld	(_can_out_buff+3,x),a
7204                     ; 1452 can_out_buff[can_buff_wr_ptr][4]=data2;
7206  140a b670          	ld	a,_can_buff_wr_ptr
7207  140c 97            	ld	xl,a
7208  140d a610          	ld	a,#16
7209  140f 42            	mul	x,a
7210  1410 7b07          	ld	a,(OFST+7,sp)
7211  1412 e775          	ld	(_can_out_buff+4,x),a
7212                     ; 1453 can_out_buff[can_buff_wr_ptr][5]=data3;
7214  1414 b670          	ld	a,_can_buff_wr_ptr
7215  1416 97            	ld	xl,a
7216  1417 a610          	ld	a,#16
7217  1419 42            	mul	x,a
7218  141a 7b08          	ld	a,(OFST+8,sp)
7219  141c e776          	ld	(_can_out_buff+5,x),a
7220                     ; 1454 can_out_buff[can_buff_wr_ptr][6]=data4;
7222  141e b670          	ld	a,_can_buff_wr_ptr
7223  1420 97            	ld	xl,a
7224  1421 a610          	ld	a,#16
7225  1423 42            	mul	x,a
7226  1424 7b09          	ld	a,(OFST+9,sp)
7227  1426 e777          	ld	(_can_out_buff+6,x),a
7228                     ; 1455 can_out_buff[can_buff_wr_ptr][7]=data5;
7230  1428 b670          	ld	a,_can_buff_wr_ptr
7231  142a 97            	ld	xl,a
7232  142b a610          	ld	a,#16
7233  142d 42            	mul	x,a
7234  142e 7b0a          	ld	a,(OFST+10,sp)
7235  1430 e778          	ld	(_can_out_buff+7,x),a
7236                     ; 1456 can_out_buff[can_buff_wr_ptr][8]=data6;
7238  1432 b670          	ld	a,_can_buff_wr_ptr
7239  1434 97            	ld	xl,a
7240  1435 a610          	ld	a,#16
7241  1437 42            	mul	x,a
7242  1438 7b0b          	ld	a,(OFST+11,sp)
7243  143a e779          	ld	(_can_out_buff+8,x),a
7244                     ; 1457 can_out_buff[can_buff_wr_ptr][9]=data7;
7246  143c b670          	ld	a,_can_buff_wr_ptr
7247  143e 97            	ld	xl,a
7248  143f a610          	ld	a,#16
7249  1441 42            	mul	x,a
7250  1442 7b0c          	ld	a,(OFST+12,sp)
7251  1444 e77a          	ld	(_can_out_buff+9,x),a
7252                     ; 1459 can_buff_wr_ptr++;
7254  1446 3c70          	inc	_can_buff_wr_ptr
7255                     ; 1460 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7257  1448 b670          	ld	a,_can_buff_wr_ptr
7258  144a a104          	cp	a,#4
7259  144c 2502          	jrult	L1533
7262  144e 3f70          	clr	_can_buff_wr_ptr
7263  1450               L1533:
7264                     ; 1461 } 
7267  1450 85            	popw	x
7268  1451 81            	ret
7297                     ; 1464 void can_tx_hndl(void)
7297                     ; 1465 {
7298                     	switch	.text
7299  1452               _can_tx_hndl:
7303                     ; 1466 if(bTX_FREE)
7305  1452 3d08          	tnz	_bTX_FREE
7306  1454 2757          	jreq	L3633
7307                     ; 1468 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7309  1456 b66f          	ld	a,_can_buff_rd_ptr
7310  1458 b170          	cp	a,_can_buff_wr_ptr
7311  145a 275f          	jreq	L1733
7312                     ; 1470 		bTX_FREE=0;
7314  145c 3f08          	clr	_bTX_FREE
7315                     ; 1472 		CAN->PSR= 0;
7317  145e 725f5427      	clr	21543
7318                     ; 1473 		CAN->Page.TxMailbox.MDLCR=8;
7320  1462 35085429      	mov	21545,#8
7321                     ; 1474 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7323  1466 b66f          	ld	a,_can_buff_rd_ptr
7324  1468 97            	ld	xl,a
7325  1469 a610          	ld	a,#16
7326  146b 42            	mul	x,a
7327  146c e671          	ld	a,(_can_out_buff,x)
7328  146e c7542a        	ld	21546,a
7329                     ; 1475 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7331  1471 b66f          	ld	a,_can_buff_rd_ptr
7332  1473 97            	ld	xl,a
7333  1474 a610          	ld	a,#16
7334  1476 42            	mul	x,a
7335  1477 e672          	ld	a,(_can_out_buff+1,x)
7336  1479 c7542b        	ld	21547,a
7337                     ; 1477 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7339  147c b66f          	ld	a,_can_buff_rd_ptr
7340  147e 97            	ld	xl,a
7341  147f a610          	ld	a,#16
7342  1481 42            	mul	x,a
7343  1482 01            	rrwa	x,a
7344  1483 ab73          	add	a,#_can_out_buff+2
7345  1485 2401          	jrnc	L241
7346  1487 5c            	incw	x
7347  1488               L241:
7348  1488 5f            	clrw	x
7349  1489 97            	ld	xl,a
7350  148a bf00          	ldw	c_x,x
7351  148c ae0008        	ldw	x,#8
7352  148f               L441:
7353  148f 5a            	decw	x
7354  1490 92d600        	ld	a,([c_x],x)
7355  1493 d7542e        	ld	(21550,x),a
7356  1496 5d            	tnzw	x
7357  1497 26f6          	jrne	L441
7358                     ; 1479 		can_buff_rd_ptr++;
7360  1499 3c6f          	inc	_can_buff_rd_ptr
7361                     ; 1480 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7363  149b b66f          	ld	a,_can_buff_rd_ptr
7364  149d a104          	cp	a,#4
7365  149f 2502          	jrult	L7633
7368  14a1 3f6f          	clr	_can_buff_rd_ptr
7369  14a3               L7633:
7370                     ; 1482 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7372  14a3 72105428      	bset	21544,#0
7373                     ; 1483 		CAN->IER|=(1<<0);
7375  14a7 72105425      	bset	21541,#0
7376  14ab 200e          	jra	L1733
7377  14ad               L3633:
7378                     ; 1488 	tx_busy_cnt++;
7380  14ad 3c6e          	inc	_tx_busy_cnt
7381                     ; 1489 	if(tx_busy_cnt>=100)
7383  14af b66e          	ld	a,_tx_busy_cnt
7384  14b1 a164          	cp	a,#100
7385  14b3 2506          	jrult	L1733
7386                     ; 1491 		tx_busy_cnt=0;
7388  14b5 3f6e          	clr	_tx_busy_cnt
7389                     ; 1492 		bTX_FREE=1;
7391  14b7 35010008      	mov	_bTX_FREE,#1
7392  14bb               L1733:
7393                     ; 1495 }
7396  14bb 81            	ret
7435                     ; 1498 void net_drv(void)
7435                     ; 1499 { 
7436                     	switch	.text
7437  14bc               _net_drv:
7441                     ; 1501 if(bMAIN)
7443                     	btst	_bMAIN
7444  14c1 2503          	jrult	L051
7445  14c3 cc1569        	jp	L5043
7446  14c6               L051:
7447                     ; 1503 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7449  14c6 3c2f          	inc	_cnt_net_drv
7450  14c8 b62f          	ld	a,_cnt_net_drv
7451  14ca a107          	cp	a,#7
7452  14cc 2502          	jrult	L7043
7455  14ce 3f2f          	clr	_cnt_net_drv
7456  14d0               L7043:
7457                     ; 1505 	if(cnt_net_drv<=5) 
7459  14d0 b62f          	ld	a,_cnt_net_drv
7460  14d2 a106          	cp	a,#6
7461  14d4 244c          	jruge	L1143
7462                     ; 1507 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7464  14d6 4be8          	push	#232
7465  14d8 4be8          	push	#232
7466  14da b62f          	ld	a,_cnt_net_drv
7467  14dc 5f            	clrw	x
7468  14dd 97            	ld	xl,a
7469  14de 58            	sllw	x
7470  14df ee23          	ldw	x,(_x,x)
7471  14e1 72bb001c      	addw	x,_volum_u_main_
7472  14e5 90ae0100      	ldw	y,#256
7473  14e9 cd0000        	call	c_idiv
7475  14ec 9f            	ld	a,xl
7476  14ed 88            	push	a
7477  14ee b62f          	ld	a,_cnt_net_drv
7478  14f0 5f            	clrw	x
7479  14f1 97            	ld	xl,a
7480  14f2 58            	sllw	x
7481  14f3 e624          	ld	a,(_x+1,x)
7482  14f5 bb1d          	add	a,_volum_u_main_+1
7483  14f7 88            	push	a
7484  14f8 4b00          	push	#0
7485  14fa 4bed          	push	#237
7486  14fc 3b002f        	push	_cnt_net_drv
7487  14ff 3b002f        	push	_cnt_net_drv
7488  1502 ae009e        	ldw	x,#158
7489  1505 cd13ce        	call	_can_transmit
7491  1508 5b08          	addw	sp,#8
7492                     ; 1508 		i_main_bps_cnt[cnt_net_drv]++;
7494  150a b62f          	ld	a,_cnt_net_drv
7495  150c 5f            	clrw	x
7496  150d 97            	ld	xl,a
7497  150e 6c06          	inc	(_i_main_bps_cnt,x)
7498                     ; 1509 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7500  1510 b62f          	ld	a,_cnt_net_drv
7501  1512 5f            	clrw	x
7502  1513 97            	ld	xl,a
7503  1514 e606          	ld	a,(_i_main_bps_cnt,x)
7504  1516 a10b          	cp	a,#11
7505  1518 254f          	jrult	L5043
7508  151a b62f          	ld	a,_cnt_net_drv
7509  151c 5f            	clrw	x
7510  151d 97            	ld	xl,a
7511  151e 6f11          	clr	(_i_main_flag,x)
7512  1520 2047          	jra	L5043
7513  1522               L1143:
7514                     ; 1511 	else if(cnt_net_drv==6)
7516  1522 b62f          	ld	a,_cnt_net_drv
7517  1524 a106          	cp	a,#6
7518  1526 2641          	jrne	L5043
7519                     ; 1513 		plazma_int[2]=pwm_u;
7521  1528 be0b          	ldw	x,_pwm_u
7522  152a bf34          	ldw	_plazma_int+4,x
7523                     ; 1514 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7525  152c 3b0067        	push	_Ui
7526  152f 3b0068        	push	_Ui+1
7527  1532 3b0069        	push	_Un
7528  1535 3b006a        	push	_Un+1
7529  1538 3b006b        	push	_I
7530  153b 3b006c        	push	_I+1
7531  153e 4bda          	push	#218
7532  1540 3b0001        	push	_adress
7533  1543 ae018e        	ldw	x,#398
7534  1546 cd13ce        	call	_can_transmit
7536  1549 5b08          	addw	sp,#8
7537                     ; 1515 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7539  154b 3b0034        	push	_plazma_int+4
7540  154e 3b0035        	push	_plazma_int+5
7541  1551 3b005c        	push	__x_+1
7542  1554 3b000a        	push	_flags
7543  1557 4b00          	push	#0
7544  1559 3b0064        	push	_T
7545  155c 4bdb          	push	#219
7546  155e 3b0001        	push	_adress
7547  1561 ae018e        	ldw	x,#398
7548  1564 cd13ce        	call	_can_transmit
7550  1567 5b08          	addw	sp,#8
7551  1569               L5043:
7552                     ; 1518 }
7555  1569 81            	ret
7665                     ; 1521 void can_in_an(void)
7665                     ; 1522 {
7666                     	switch	.text
7667  156a               _can_in_an:
7669  156a 5205          	subw	sp,#5
7670       00000005      OFST:	set	5
7673                     ; 1532 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7675  156c b6c6          	ld	a,_mess+6
7676  156e c10001        	cp	a,_adress
7677  1571 2703          	jreq	L471
7678  1573 cc1680        	jp	L5543
7679  1576               L471:
7681  1576 b6c7          	ld	a,_mess+7
7682  1578 c10001        	cp	a,_adress
7683  157b 2703          	jreq	L671
7684  157d cc1680        	jp	L5543
7685  1580               L671:
7687  1580 b6c8          	ld	a,_mess+8
7688  1582 a1ed          	cp	a,#237
7689  1584 2703          	jreq	L002
7690  1586 cc1680        	jp	L5543
7691  1589               L002:
7692                     ; 1535 	can_error_cnt=0;
7694  1589 3f6d          	clr	_can_error_cnt
7695                     ; 1537 	bMAIN=0;
7697  158b 72110001      	bres	_bMAIN
7698                     ; 1538  	flags_tu=mess[9];
7700  158f 45c95d        	mov	_flags_tu,_mess+9
7701                     ; 1539  	if(flags_tu&0b00000001)
7703  1592 b65d          	ld	a,_flags_tu
7704  1594 a501          	bcp	a,#1
7705  1596 2706          	jreq	L7543
7706                     ; 1544  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7708  1598 721a000a      	bset	_flags,#5
7710  159c 200e          	jra	L1643
7711  159e               L7543:
7712                     ; 1555  				flags&=0b11011111; 
7714  159e 721b000a      	bres	_flags,#5
7715                     ; 1556  				off_bp_cnt=5*ee_TZAS;
7717  15a2 c60015        	ld	a,_ee_TZAS+1
7718  15a5 97            	ld	xl,a
7719  15a6 a605          	ld	a,#5
7720  15a8 42            	mul	x,a
7721  15a9 9f            	ld	a,xl
7722  15aa b750          	ld	_off_bp_cnt,a
7723  15ac               L1643:
7724                     ; 1562  	if(flags_tu&0b00000010) flags|=0b01000000;
7726  15ac b65d          	ld	a,_flags_tu
7727  15ae a502          	bcp	a,#2
7728  15b0 2706          	jreq	L3643
7731  15b2 721c000a      	bset	_flags,#6
7733  15b6 2004          	jra	L5643
7734  15b8               L3643:
7735                     ; 1563  	else flags&=0b10111111; 
7737  15b8 721d000a      	bres	_flags,#6
7738  15bc               L5643:
7739                     ; 1565  	vol_u_temp=mess[10]+mess[11]*256;
7741  15bc b6cb          	ld	a,_mess+11
7742  15be 5f            	clrw	x
7743  15bf 97            	ld	xl,a
7744  15c0 4f            	clr	a
7745  15c1 02            	rlwa	x,a
7746  15c2 01            	rrwa	x,a
7747  15c3 bbca          	add	a,_mess+10
7748  15c5 2401          	jrnc	L451
7749  15c7 5c            	incw	x
7750  15c8               L451:
7751  15c8 b756          	ld	_vol_u_temp+1,a
7752  15ca 9f            	ld	a,xl
7753  15cb b755          	ld	_vol_u_temp,a
7754                     ; 1566  	vol_i_temp=mess[12]+mess[13]*256;  
7756  15cd b6cd          	ld	a,_mess+13
7757  15cf 5f            	clrw	x
7758  15d0 97            	ld	xl,a
7759  15d1 4f            	clr	a
7760  15d2 02            	rlwa	x,a
7761  15d3 01            	rrwa	x,a
7762  15d4 bbcc          	add	a,_mess+12
7763  15d6 2401          	jrnc	L651
7764  15d8 5c            	incw	x
7765  15d9               L651:
7766  15d9 b754          	ld	_vol_i_temp+1,a
7767  15db 9f            	ld	a,xl
7768  15dc b753          	ld	_vol_i_temp,a
7769                     ; 1575 	plazma_int[2]=T;
7771  15de 5f            	clrw	x
7772  15df b664          	ld	a,_T
7773  15e1 2a01          	jrpl	L061
7774  15e3 53            	cplw	x
7775  15e4               L061:
7776  15e4 97            	ld	xl,a
7777  15e5 bf34          	ldw	_plazma_int+4,x
7778                     ; 1576  	rotor_int=flags_tu+(((short)flags)<<8);
7780  15e7 b60a          	ld	a,_flags
7781  15e9 5f            	clrw	x
7782  15ea 97            	ld	xl,a
7783  15eb 4f            	clr	a
7784  15ec 02            	rlwa	x,a
7785  15ed 01            	rrwa	x,a
7786  15ee bb5d          	add	a,_flags_tu
7787  15f0 2401          	jrnc	L261
7788  15f2 5c            	incw	x
7789  15f3               L261:
7790  15f3 b71b          	ld	_rotor_int+1,a
7791  15f5 9f            	ld	a,xl
7792  15f6 b71a          	ld	_rotor_int,a
7793                     ; 1577 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7795  15f8 3b0067        	push	_Ui
7796  15fb 3b0068        	push	_Ui+1
7797  15fe 3b0069        	push	_Un
7798  1601 3b006a        	push	_Un+1
7799  1604 3b006b        	push	_I
7800  1607 3b006c        	push	_I+1
7801  160a 4bda          	push	#218
7802  160c 3b0001        	push	_adress
7803  160f ae018e        	ldw	x,#398
7804  1612 cd13ce        	call	_can_transmit
7806  1615 5b08          	addw	sp,#8
7807                     ; 1578 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7809  1617 3b0034        	push	_plazma_int+4
7810  161a 3b0035        	push	_plazma_int+5
7811  161d 3b005c        	push	__x_+1
7812  1620 3b000a        	push	_flags
7813  1623 4b00          	push	#0
7814  1625 3b0064        	push	_T
7815  1628 4bdb          	push	#219
7816  162a 3b0001        	push	_adress
7817  162d ae018e        	ldw	x,#398
7818  1630 cd13ce        	call	_can_transmit
7820  1633 5b08          	addw	sp,#8
7821                     ; 1579      link_cnt=0;
7823  1635 3f5e          	clr	_link_cnt
7824                     ; 1580      link=ON;
7826  1637 3555005f      	mov	_link,#85
7827                     ; 1582      if(flags_tu&0b10000000)
7829  163b b65d          	ld	a,_flags_tu
7830  163d a580          	bcp	a,#128
7831  163f 2716          	jreq	L7643
7832                     ; 1584      	if(!res_fl)
7834  1641 725d0009      	tnz	_res_fl
7835  1645 2625          	jrne	L3743
7836                     ; 1586      		res_fl=1;
7838  1647 a601          	ld	a,#1
7839  1649 ae0009        	ldw	x,#_res_fl
7840  164c cd0000        	call	c_eewrc
7842                     ; 1587      		bRES=1;
7844  164f 3501000f      	mov	_bRES,#1
7845                     ; 1588      		res_fl_cnt=0;
7847  1653 3f3e          	clr	_res_fl_cnt
7848  1655 2015          	jra	L3743
7849  1657               L7643:
7850                     ; 1593      	if(main_cnt>20)
7852  1657 9c            	rvf
7853  1658 be4e          	ldw	x,_main_cnt
7854  165a a30015        	cpw	x,#21
7855  165d 2f0d          	jrslt	L3743
7856                     ; 1595     			if(res_fl)
7858  165f 725d0009      	tnz	_res_fl
7859  1663 2707          	jreq	L3743
7860                     ; 1597      			res_fl=0;
7862  1665 4f            	clr	a
7863  1666 ae0009        	ldw	x,#_res_fl
7864  1669 cd0000        	call	c_eewrc
7866  166c               L3743:
7867                     ; 1602       if(res_fl_)
7869  166c 725d0008      	tnz	_res_fl_
7870  1670 2603          	jrne	L202
7871  1672 cc1ba3        	jp	L1243
7872  1675               L202:
7873                     ; 1604       	res_fl_=0;
7875  1675 4f            	clr	a
7876  1676 ae0008        	ldw	x,#_res_fl_
7877  1679 cd0000        	call	c_eewrc
7879  167c aca31ba3      	jpf	L1243
7880  1680               L5543:
7881                     ; 1607 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
7883  1680 b6c6          	ld	a,_mess+6
7884  1682 c10001        	cp	a,_adress
7885  1685 2703          	jreq	L402
7886  1687 cc1896        	jp	L5053
7887  168a               L402:
7889  168a b6c7          	ld	a,_mess+7
7890  168c c10001        	cp	a,_adress
7891  168f 2703          	jreq	L602
7892  1691 cc1896        	jp	L5053
7893  1694               L602:
7895  1694 b6c8          	ld	a,_mess+8
7896  1696 a1ee          	cp	a,#238
7897  1698 2703          	jreq	L012
7898  169a cc1896        	jp	L5053
7899  169d               L012:
7901  169d b6c9          	ld	a,_mess+9
7902  169f b1ca          	cp	a,_mess+10
7903  16a1 2703          	jreq	L212
7904  16a3 cc1896        	jp	L5053
7905  16a6               L212:
7906                     ; 1609 	rotor_int++;
7908  16a6 be1a          	ldw	x,_rotor_int
7909  16a8 1c0001        	addw	x,#1
7910  16ab bf1a          	ldw	_rotor_int,x
7911                     ; 1610 	if((mess[9]&0xf0)==0x20)
7913  16ad b6c9          	ld	a,_mess+9
7914  16af a4f0          	and	a,#240
7915  16b1 a120          	cp	a,#32
7916  16b3 2673          	jrne	L7053
7917                     ; 1612 		if((mess[9]&0x0f)==0x01)
7919  16b5 b6c9          	ld	a,_mess+9
7920  16b7 a40f          	and	a,#15
7921  16b9 a101          	cp	a,#1
7922  16bb 260d          	jrne	L1153
7923                     ; 1614 			ee_K[0][0]=adc_buff_[4];
7925  16bd ce000d        	ldw	x,_adc_buff_+8
7926  16c0 89            	pushw	x
7927  16c1 ae0018        	ldw	x,#_ee_K
7928  16c4 cd0000        	call	c_eewrw
7930  16c7 85            	popw	x
7932  16c8 204a          	jra	L3153
7933  16ca               L1153:
7934                     ; 1616 		else if((mess[9]&0x0f)==0x02)
7936  16ca b6c9          	ld	a,_mess+9
7937  16cc a40f          	and	a,#15
7938  16ce a102          	cp	a,#2
7939  16d0 260b          	jrne	L5153
7940                     ; 1618 			ee_K[0][1]++;
7942  16d2 ce001a        	ldw	x,_ee_K+2
7943  16d5 1c0001        	addw	x,#1
7944  16d8 cf001a        	ldw	_ee_K+2,x
7946  16db 2037          	jra	L3153
7947  16dd               L5153:
7948                     ; 1620 		else if((mess[9]&0x0f)==0x03)
7950  16dd b6c9          	ld	a,_mess+9
7951  16df a40f          	and	a,#15
7952  16e1 a103          	cp	a,#3
7953  16e3 260b          	jrne	L1253
7954                     ; 1622 			ee_K[0][1]+=10;
7956  16e5 ce001a        	ldw	x,_ee_K+2
7957  16e8 1c000a        	addw	x,#10
7958  16eb cf001a        	ldw	_ee_K+2,x
7960  16ee 2024          	jra	L3153
7961  16f0               L1253:
7962                     ; 1624 		else if((mess[9]&0x0f)==0x04)
7964  16f0 b6c9          	ld	a,_mess+9
7965  16f2 a40f          	and	a,#15
7966  16f4 a104          	cp	a,#4
7967  16f6 260b          	jrne	L5253
7968                     ; 1626 			ee_K[0][1]--;
7970  16f8 ce001a        	ldw	x,_ee_K+2
7971  16fb 1d0001        	subw	x,#1
7972  16fe cf001a        	ldw	_ee_K+2,x
7974  1701 2011          	jra	L3153
7975  1703               L5253:
7976                     ; 1628 		else if((mess[9]&0x0f)==0x05)
7978  1703 b6c9          	ld	a,_mess+9
7979  1705 a40f          	and	a,#15
7980  1707 a105          	cp	a,#5
7981  1709 2609          	jrne	L3153
7982                     ; 1630 			ee_K[0][1]-=10;
7984  170b ce001a        	ldw	x,_ee_K+2
7985  170e 1d000a        	subw	x,#10
7986  1711 cf001a        	ldw	_ee_K+2,x
7987  1714               L3153:
7988                     ; 1632 		granee(&ee_K[0][1],50,3000);									
7990  1714 ae0bb8        	ldw	x,#3000
7991  1717 89            	pushw	x
7992  1718 ae0032        	ldw	x,#50
7993  171b 89            	pushw	x
7994  171c ae001a        	ldw	x,#_ee_K+2
7995  171f cd0021        	call	_granee
7997  1722 5b04          	addw	sp,#4
7999  1724 ac7c187c      	jpf	L3353
8000  1728               L7053:
8001                     ; 1634 	else if((mess[9]&0xf0)==0x10)
8003  1728 b6c9          	ld	a,_mess+9
8004  172a a4f0          	and	a,#240
8005  172c a110          	cp	a,#16
8006  172e 2673          	jrne	L5353
8007                     ; 1636 		if((mess[9]&0x0f)==0x01)
8009  1730 b6c9          	ld	a,_mess+9
8010  1732 a40f          	and	a,#15
8011  1734 a101          	cp	a,#1
8012  1736 260d          	jrne	L7353
8013                     ; 1638 			ee_K[1][0]=adc_buff_[1];
8015  1738 ce0007        	ldw	x,_adc_buff_+2
8016  173b 89            	pushw	x
8017  173c ae001c        	ldw	x,#_ee_K+4
8018  173f cd0000        	call	c_eewrw
8020  1742 85            	popw	x
8022  1743 204a          	jra	L1453
8023  1745               L7353:
8024                     ; 1640 		else if((mess[9]&0x0f)==0x02)
8026  1745 b6c9          	ld	a,_mess+9
8027  1747 a40f          	and	a,#15
8028  1749 a102          	cp	a,#2
8029  174b 260b          	jrne	L3453
8030                     ; 1642 			ee_K[1][1]++;
8032  174d ce001e        	ldw	x,_ee_K+6
8033  1750 1c0001        	addw	x,#1
8034  1753 cf001e        	ldw	_ee_K+6,x
8036  1756 2037          	jra	L1453
8037  1758               L3453:
8038                     ; 1644 		else if((mess[9]&0x0f)==0x03)
8040  1758 b6c9          	ld	a,_mess+9
8041  175a a40f          	and	a,#15
8042  175c a103          	cp	a,#3
8043  175e 260b          	jrne	L7453
8044                     ; 1646 			ee_K[1][1]+=10;
8046  1760 ce001e        	ldw	x,_ee_K+6
8047  1763 1c000a        	addw	x,#10
8048  1766 cf001e        	ldw	_ee_K+6,x
8050  1769 2024          	jra	L1453
8051  176b               L7453:
8052                     ; 1648 		else if((mess[9]&0x0f)==0x04)
8054  176b b6c9          	ld	a,_mess+9
8055  176d a40f          	and	a,#15
8056  176f a104          	cp	a,#4
8057  1771 260b          	jrne	L3553
8058                     ; 1650 			ee_K[1][1]--;
8060  1773 ce001e        	ldw	x,_ee_K+6
8061  1776 1d0001        	subw	x,#1
8062  1779 cf001e        	ldw	_ee_K+6,x
8064  177c 2011          	jra	L1453
8065  177e               L3553:
8066                     ; 1652 		else if((mess[9]&0x0f)==0x05)
8068  177e b6c9          	ld	a,_mess+9
8069  1780 a40f          	and	a,#15
8070  1782 a105          	cp	a,#5
8071  1784 2609          	jrne	L1453
8072                     ; 1654 			ee_K[1][1]-=10;
8074  1786 ce001e        	ldw	x,_ee_K+6
8075  1789 1d000a        	subw	x,#10
8076  178c cf001e        	ldw	_ee_K+6,x
8077  178f               L1453:
8078                     ; 1659 		granee(&ee_K[1][1],10,30000);
8080  178f ae7530        	ldw	x,#30000
8081  1792 89            	pushw	x
8082  1793 ae000a        	ldw	x,#10
8083  1796 89            	pushw	x
8084  1797 ae001e        	ldw	x,#_ee_K+6
8085  179a cd0021        	call	_granee
8087  179d 5b04          	addw	sp,#4
8089  179f ac7c187c      	jpf	L3353
8090  17a3               L5353:
8091                     ; 1663 	else if((mess[9]&0xf0)==0x00)
8093  17a3 b6c9          	ld	a,_mess+9
8094  17a5 a5f0          	bcp	a,#240
8095  17a7 2671          	jrne	L3653
8096                     ; 1665 		if((mess[9]&0x0f)==0x01)
8098  17a9 b6c9          	ld	a,_mess+9
8099  17ab a40f          	and	a,#15
8100  17ad a101          	cp	a,#1
8101  17af 260d          	jrne	L5653
8102                     ; 1667 			ee_K[2][0]=adc_buff_[2];
8104  17b1 ce0009        	ldw	x,_adc_buff_+4
8105  17b4 89            	pushw	x
8106  17b5 ae0020        	ldw	x,#_ee_K+8
8107  17b8 cd0000        	call	c_eewrw
8109  17bb 85            	popw	x
8111  17bc 204a          	jra	L7653
8112  17be               L5653:
8113                     ; 1669 		else if((mess[9]&0x0f)==0x02)
8115  17be b6c9          	ld	a,_mess+9
8116  17c0 a40f          	and	a,#15
8117  17c2 a102          	cp	a,#2
8118  17c4 260b          	jrne	L1753
8119                     ; 1671 			ee_K[2][1]++;
8121  17c6 ce0022        	ldw	x,_ee_K+10
8122  17c9 1c0001        	addw	x,#1
8123  17cc cf0022        	ldw	_ee_K+10,x
8125  17cf 2037          	jra	L7653
8126  17d1               L1753:
8127                     ; 1673 		else if((mess[9]&0x0f)==0x03)
8129  17d1 b6c9          	ld	a,_mess+9
8130  17d3 a40f          	and	a,#15
8131  17d5 a103          	cp	a,#3
8132  17d7 260b          	jrne	L5753
8133                     ; 1675 			ee_K[2][1]+=10;
8135  17d9 ce0022        	ldw	x,_ee_K+10
8136  17dc 1c000a        	addw	x,#10
8137  17df cf0022        	ldw	_ee_K+10,x
8139  17e2 2024          	jra	L7653
8140  17e4               L5753:
8141                     ; 1677 		else if((mess[9]&0x0f)==0x04)
8143  17e4 b6c9          	ld	a,_mess+9
8144  17e6 a40f          	and	a,#15
8145  17e8 a104          	cp	a,#4
8146  17ea 260b          	jrne	L1063
8147                     ; 1679 			ee_K[2][1]--;
8149  17ec ce0022        	ldw	x,_ee_K+10
8150  17ef 1d0001        	subw	x,#1
8151  17f2 cf0022        	ldw	_ee_K+10,x
8153  17f5 2011          	jra	L7653
8154  17f7               L1063:
8155                     ; 1681 		else if((mess[9]&0x0f)==0x05)
8157  17f7 b6c9          	ld	a,_mess+9
8158  17f9 a40f          	and	a,#15
8159  17fb a105          	cp	a,#5
8160  17fd 2609          	jrne	L7653
8161                     ; 1683 			ee_K[2][1]-=10;
8163  17ff ce0022        	ldw	x,_ee_K+10
8164  1802 1d000a        	subw	x,#10
8165  1805 cf0022        	ldw	_ee_K+10,x
8166  1808               L7653:
8167                     ; 1688 		granee(&ee_K[2][1],10,30000);
8169  1808 ae7530        	ldw	x,#30000
8170  180b 89            	pushw	x
8171  180c ae000a        	ldw	x,#10
8172  180f 89            	pushw	x
8173  1810 ae0022        	ldw	x,#_ee_K+10
8174  1813 cd0021        	call	_granee
8176  1816 5b04          	addw	sp,#4
8178  1818 2062          	jra	L3353
8179  181a               L3653:
8180                     ; 1692 	else if((mess[9]&0xf0)==0x30)
8182  181a b6c9          	ld	a,_mess+9
8183  181c a4f0          	and	a,#240
8184  181e a130          	cp	a,#48
8185  1820 265a          	jrne	L3353
8186                     ; 1694 		if((mess[9]&0x0f)==0x02)
8188  1822 b6c9          	ld	a,_mess+9
8189  1824 a40f          	and	a,#15
8190  1826 a102          	cp	a,#2
8191  1828 260b          	jrne	L3163
8192                     ; 1696 			ee_K[3][1]++;
8194  182a ce0026        	ldw	x,_ee_K+14
8195  182d 1c0001        	addw	x,#1
8196  1830 cf0026        	ldw	_ee_K+14,x
8198  1833 2037          	jra	L5163
8199  1835               L3163:
8200                     ; 1698 		else if((mess[9]&0x0f)==0x03)
8202  1835 b6c9          	ld	a,_mess+9
8203  1837 a40f          	and	a,#15
8204  1839 a103          	cp	a,#3
8205  183b 260b          	jrne	L7163
8206                     ; 1700 			ee_K[3][1]+=10;
8208  183d ce0026        	ldw	x,_ee_K+14
8209  1840 1c000a        	addw	x,#10
8210  1843 cf0026        	ldw	_ee_K+14,x
8212  1846 2024          	jra	L5163
8213  1848               L7163:
8214                     ; 1702 		else if((mess[9]&0x0f)==0x04)
8216  1848 b6c9          	ld	a,_mess+9
8217  184a a40f          	and	a,#15
8218  184c a104          	cp	a,#4
8219  184e 260b          	jrne	L3263
8220                     ; 1704 			ee_K[3][1]--;
8222  1850 ce0026        	ldw	x,_ee_K+14
8223  1853 1d0001        	subw	x,#1
8224  1856 cf0026        	ldw	_ee_K+14,x
8226  1859 2011          	jra	L5163
8227  185b               L3263:
8228                     ; 1706 		else if((mess[9]&0x0f)==0x05)
8230  185b b6c9          	ld	a,_mess+9
8231  185d a40f          	and	a,#15
8232  185f a105          	cp	a,#5
8233  1861 2609          	jrne	L5163
8234                     ; 1708 			ee_K[3][1]-=10;
8236  1863 ce0026        	ldw	x,_ee_K+14
8237  1866 1d000a        	subw	x,#10
8238  1869 cf0026        	ldw	_ee_K+14,x
8239  186c               L5163:
8240                     ; 1710 		granee(&ee_K[3][1],300,517);									
8242  186c ae0205        	ldw	x,#517
8243  186f 89            	pushw	x
8244  1870 ae012c        	ldw	x,#300
8245  1873 89            	pushw	x
8246  1874 ae0026        	ldw	x,#_ee_K+14
8247  1877 cd0021        	call	_granee
8249  187a 5b04          	addw	sp,#4
8250  187c               L3353:
8251                     ; 1713 	link_cnt=0;
8253  187c 3f5e          	clr	_link_cnt
8254                     ; 1714      link=ON;
8256  187e 3555005f      	mov	_link,#85
8257                     ; 1715      if(res_fl_)
8259  1882 725d0008      	tnz	_res_fl_
8260  1886 2603          	jrne	L412
8261  1888 cc1ba3        	jp	L1243
8262  188b               L412:
8263                     ; 1717       	res_fl_=0;
8265  188b 4f            	clr	a
8266  188c ae0008        	ldw	x,#_res_fl_
8267  188f cd0000        	call	c_eewrc
8269  1892 aca31ba3      	jpf	L1243
8270  1896               L5053:
8271                     ; 1723 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8273  1896 b6c6          	ld	a,_mess+6
8274  1898 a1ff          	cp	a,#255
8275  189a 2703          	jreq	L612
8276  189c cc192a        	jp	L5363
8277  189f               L612:
8279  189f b6c7          	ld	a,_mess+7
8280  18a1 a1ff          	cp	a,#255
8281  18a3 2703          	jreq	L022
8282  18a5 cc192a        	jp	L5363
8283  18a8               L022:
8285  18a8 b6c8          	ld	a,_mess+8
8286  18aa a162          	cp	a,#98
8287  18ac 267c          	jrne	L5363
8288                     ; 1726 	tempSS=mess[9]+(mess[10]*256);
8290  18ae b6ca          	ld	a,_mess+10
8291  18b0 5f            	clrw	x
8292  18b1 97            	ld	xl,a
8293  18b2 4f            	clr	a
8294  18b3 02            	rlwa	x,a
8295  18b4 01            	rrwa	x,a
8296  18b5 bbc9          	add	a,_mess+9
8297  18b7 2401          	jrnc	L461
8298  18b9 5c            	incw	x
8299  18ba               L461:
8300  18ba 02            	rlwa	x,a
8301  18bb 1f04          	ldw	(OFST-1,sp),x
8302  18bd 01            	rrwa	x,a
8303                     ; 1727 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8305  18be ce0012        	ldw	x,_ee_Umax
8306  18c1 1304          	cpw	x,(OFST-1,sp)
8307  18c3 270a          	jreq	L7363
8310  18c5 1e04          	ldw	x,(OFST-1,sp)
8311  18c7 89            	pushw	x
8312  18c8 ae0012        	ldw	x,#_ee_Umax
8313  18cb cd0000        	call	c_eewrw
8315  18ce 85            	popw	x
8316  18cf               L7363:
8317                     ; 1728 	tempSS=mess[11]+(mess[12]*256);
8319  18cf b6cc          	ld	a,_mess+12
8320  18d1 5f            	clrw	x
8321  18d2 97            	ld	xl,a
8322  18d3 4f            	clr	a
8323  18d4 02            	rlwa	x,a
8324  18d5 01            	rrwa	x,a
8325  18d6 bbcb          	add	a,_mess+11
8326  18d8 2401          	jrnc	L661
8327  18da 5c            	incw	x
8328  18db               L661:
8329  18db 02            	rlwa	x,a
8330  18dc 1f04          	ldw	(OFST-1,sp),x
8331  18de 01            	rrwa	x,a
8332                     ; 1729 	if(ee_dU!=tempSS) ee_dU=tempSS;
8334  18df ce0010        	ldw	x,_ee_dU
8335  18e2 1304          	cpw	x,(OFST-1,sp)
8336  18e4 270a          	jreq	L1463
8339  18e6 1e04          	ldw	x,(OFST-1,sp)
8340  18e8 89            	pushw	x
8341  18e9 ae0010        	ldw	x,#_ee_dU
8342  18ec cd0000        	call	c_eewrw
8344  18ef 85            	popw	x
8345  18f0               L1463:
8346                     ; 1730 	if((mess[13]&0x0f)==0x5)
8348  18f0 b6cd          	ld	a,_mess+13
8349  18f2 a40f          	and	a,#15
8350  18f4 a105          	cp	a,#5
8351  18f6 261a          	jrne	L3463
8352                     ; 1732 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8354  18f8 ce0004        	ldw	x,_ee_AVT_MODE
8355  18fb a30055        	cpw	x,#85
8356  18fe 2603          	jrne	L222
8357  1900 cc1ba3        	jp	L1243
8358  1903               L222:
8361  1903 ae0055        	ldw	x,#85
8362  1906 89            	pushw	x
8363  1907 ae0004        	ldw	x,#_ee_AVT_MODE
8364  190a cd0000        	call	c_eewrw
8366  190d 85            	popw	x
8367  190e aca31ba3      	jpf	L1243
8368  1912               L3463:
8369                     ; 1734 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8371  1912 ce0004        	ldw	x,_ee_AVT_MODE
8372  1915 a30055        	cpw	x,#85
8373  1918 2703          	jreq	L422
8374  191a cc1ba3        	jp	L1243
8375  191d               L422:
8378  191d 5f            	clrw	x
8379  191e 89            	pushw	x
8380  191f ae0004        	ldw	x,#_ee_AVT_MODE
8381  1922 cd0000        	call	c_eewrw
8383  1925 85            	popw	x
8384  1926 aca31ba3      	jpf	L1243
8385  192a               L5363:
8386                     ; 1737 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8388  192a b6c6          	ld	a,_mess+6
8389  192c a1ff          	cp	a,#255
8390  192e 2703          	jreq	L622
8391  1930 cc1a01        	jp	L5563
8392  1933               L622:
8394  1933 b6c7          	ld	a,_mess+7
8395  1935 a1ff          	cp	a,#255
8396  1937 2703          	jreq	L032
8397  1939 cc1a01        	jp	L5563
8398  193c               L032:
8400  193c b6c8          	ld	a,_mess+8
8401  193e a126          	cp	a,#38
8402  1940 2709          	jreq	L7563
8404  1942 b6c8          	ld	a,_mess+8
8405  1944 a129          	cp	a,#41
8406  1946 2703          	jreq	L232
8407  1948 cc1a01        	jp	L5563
8408  194b               L232:
8409  194b               L7563:
8410                     ; 1740 	tempSS=mess[9]+(mess[10]*256);
8412  194b b6ca          	ld	a,_mess+10
8413  194d 5f            	clrw	x
8414  194e 97            	ld	xl,a
8415  194f 4f            	clr	a
8416  1950 02            	rlwa	x,a
8417  1951 01            	rrwa	x,a
8418  1952 bbc9          	add	a,_mess+9
8419  1954 2401          	jrnc	L071
8420  1956 5c            	incw	x
8421  1957               L071:
8422  1957 02            	rlwa	x,a
8423  1958 1f04          	ldw	(OFST-1,sp),x
8424  195a 01            	rrwa	x,a
8425                     ; 1741 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8427  195b ce000e        	ldw	x,_ee_tmax
8428  195e 1304          	cpw	x,(OFST-1,sp)
8429  1960 270a          	jreq	L1663
8432  1962 1e04          	ldw	x,(OFST-1,sp)
8433  1964 89            	pushw	x
8434  1965 ae000e        	ldw	x,#_ee_tmax
8435  1968 cd0000        	call	c_eewrw
8437  196b 85            	popw	x
8438  196c               L1663:
8439                     ; 1742 	tempSS=mess[11]+(mess[12]*256);
8441  196c b6cc          	ld	a,_mess+12
8442  196e 5f            	clrw	x
8443  196f 97            	ld	xl,a
8444  1970 4f            	clr	a
8445  1971 02            	rlwa	x,a
8446  1972 01            	rrwa	x,a
8447  1973 bbcb          	add	a,_mess+11
8448  1975 2401          	jrnc	L271
8449  1977 5c            	incw	x
8450  1978               L271:
8451  1978 02            	rlwa	x,a
8452  1979 1f04          	ldw	(OFST-1,sp),x
8453  197b 01            	rrwa	x,a
8454                     ; 1743 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8456  197c ce000c        	ldw	x,_ee_tsign
8457  197f 1304          	cpw	x,(OFST-1,sp)
8458  1981 270a          	jreq	L3663
8461  1983 1e04          	ldw	x,(OFST-1,sp)
8462  1985 89            	pushw	x
8463  1986 ae000c        	ldw	x,#_ee_tsign
8464  1989 cd0000        	call	c_eewrw
8466  198c 85            	popw	x
8467  198d               L3663:
8468                     ; 1746 	if(mess[8]==MEM_KF1)
8470  198d b6c8          	ld	a,_mess+8
8471  198f a126          	cp	a,#38
8472  1991 2623          	jrne	L5663
8473                     ; 1748 		if(ee_DEVICE!=0)ee_DEVICE=0;
8475  1993 ce0002        	ldw	x,_ee_DEVICE
8476  1996 2709          	jreq	L7663
8479  1998 5f            	clrw	x
8480  1999 89            	pushw	x
8481  199a ae0002        	ldw	x,#_ee_DEVICE
8482  199d cd0000        	call	c_eewrw
8484  19a0 85            	popw	x
8485  19a1               L7663:
8486                     ; 1749 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8488  19a1 b6cd          	ld	a,_mess+13
8489  19a3 5f            	clrw	x
8490  19a4 97            	ld	xl,a
8491  19a5 c30014        	cpw	x,_ee_TZAS
8492  19a8 270c          	jreq	L5663
8495  19aa b6cd          	ld	a,_mess+13
8496  19ac 5f            	clrw	x
8497  19ad 97            	ld	xl,a
8498  19ae 89            	pushw	x
8499  19af ae0014        	ldw	x,#_ee_TZAS
8500  19b2 cd0000        	call	c_eewrw
8502  19b5 85            	popw	x
8503  19b6               L5663:
8504                     ; 1751 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8506  19b6 b6c8          	ld	a,_mess+8
8507  19b8 a129          	cp	a,#41
8508  19ba 2703          	jreq	L432
8509  19bc cc1ba3        	jp	L1243
8510  19bf               L432:
8511                     ; 1753 		if(ee_DEVICE!=1)ee_DEVICE=1;
8513  19bf ce0002        	ldw	x,_ee_DEVICE
8514  19c2 a30001        	cpw	x,#1
8515  19c5 270b          	jreq	L5763
8518  19c7 ae0001        	ldw	x,#1
8519  19ca 89            	pushw	x
8520  19cb ae0002        	ldw	x,#_ee_DEVICE
8521  19ce cd0000        	call	c_eewrw
8523  19d1 85            	popw	x
8524  19d2               L5763:
8525                     ; 1754 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8527  19d2 b6cd          	ld	a,_mess+13
8528  19d4 5f            	clrw	x
8529  19d5 97            	ld	xl,a
8530  19d6 c30000        	cpw	x,_ee_IMAXVENT
8531  19d9 270c          	jreq	L7763
8534  19db b6cd          	ld	a,_mess+13
8535  19dd 5f            	clrw	x
8536  19de 97            	ld	xl,a
8537  19df 89            	pushw	x
8538  19e0 ae0000        	ldw	x,#_ee_IMAXVENT
8539  19e3 cd0000        	call	c_eewrw
8541  19e6 85            	popw	x
8542  19e7               L7763:
8543                     ; 1755 			if(ee_TZAS!=3) ee_TZAS=3;
8545  19e7 ce0014        	ldw	x,_ee_TZAS
8546  19ea a30003        	cpw	x,#3
8547  19ed 2603          	jrne	L632
8548  19ef cc1ba3        	jp	L1243
8549  19f2               L632:
8552  19f2 ae0003        	ldw	x,#3
8553  19f5 89            	pushw	x
8554  19f6 ae0014        	ldw	x,#_ee_TZAS
8555  19f9 cd0000        	call	c_eewrw
8557  19fc 85            	popw	x
8558  19fd aca31ba3      	jpf	L1243
8559  1a01               L5563:
8560                     ; 1759 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8562  1a01 b6c6          	ld	a,_mess+6
8563  1a03 c10001        	cp	a,_adress
8564  1a06 262d          	jrne	L5073
8566  1a08 b6c7          	ld	a,_mess+7
8567  1a0a c10001        	cp	a,_adress
8568  1a0d 2626          	jrne	L5073
8570  1a0f b6c8          	ld	a,_mess+8
8571  1a11 a116          	cp	a,#22
8572  1a13 2620          	jrne	L5073
8574  1a15 b6c9          	ld	a,_mess+9
8575  1a17 a163          	cp	a,#99
8576  1a19 261a          	jrne	L5073
8577                     ; 1761 	flags&=0b11100001;
8579  1a1b b60a          	ld	a,_flags
8580  1a1d a4e1          	and	a,#225
8581  1a1f b70a          	ld	_flags,a
8582                     ; 1762 	tsign_cnt=0;
8584  1a21 5f            	clrw	x
8585  1a22 bf4a          	ldw	_tsign_cnt,x
8586                     ; 1763 	tmax_cnt=0;
8588  1a24 5f            	clrw	x
8589  1a25 bf48          	ldw	_tmax_cnt,x
8590                     ; 1764 	umax_cnt=0;
8592  1a27 5f            	clrw	x
8593  1a28 bf62          	ldw	_umax_cnt,x
8594                     ; 1765 	umin_cnt=0;
8596  1a2a 5f            	clrw	x
8597  1a2b bf60          	ldw	_umin_cnt,x
8598                     ; 1766 	led_drv_cnt=30;
8600  1a2d 351e0019      	mov	_led_drv_cnt,#30
8602  1a31 aca31ba3      	jpf	L1243
8603  1a35               L5073:
8604                     ; 1768 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8606  1a35 b6c6          	ld	a,_mess+6
8607  1a37 a1ff          	cp	a,#255
8608  1a39 265f          	jrne	L1173
8610  1a3b b6c7          	ld	a,_mess+7
8611  1a3d a1ff          	cp	a,#255
8612  1a3f 2659          	jrne	L1173
8614  1a41 b6c8          	ld	a,_mess+8
8615  1a43 a116          	cp	a,#22
8616  1a45 2653          	jrne	L1173
8618  1a47 b6c9          	ld	a,_mess+9
8619  1a49 a116          	cp	a,#22
8620  1a4b 264d          	jrne	L1173
8621                     ; 1770 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8623  1a4d b6ca          	ld	a,_mess+10
8624  1a4f a155          	cp	a,#85
8625  1a51 260f          	jrne	L3173
8627  1a53 b6cb          	ld	a,_mess+11
8628  1a55 a155          	cp	a,#85
8629  1a57 2609          	jrne	L3173
8632  1a59 be5b          	ldw	x,__x_
8633  1a5b 1c0001        	addw	x,#1
8634  1a5e bf5b          	ldw	__x_,x
8636  1a60 2024          	jra	L5173
8637  1a62               L3173:
8638                     ; 1771 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8640  1a62 b6ca          	ld	a,_mess+10
8641  1a64 a166          	cp	a,#102
8642  1a66 260f          	jrne	L7173
8644  1a68 b6cb          	ld	a,_mess+11
8645  1a6a a166          	cp	a,#102
8646  1a6c 2609          	jrne	L7173
8649  1a6e be5b          	ldw	x,__x_
8650  1a70 1d0001        	subw	x,#1
8651  1a73 bf5b          	ldw	__x_,x
8653  1a75 200f          	jra	L5173
8654  1a77               L7173:
8655                     ; 1772 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8657  1a77 b6ca          	ld	a,_mess+10
8658  1a79 a177          	cp	a,#119
8659  1a7b 2609          	jrne	L5173
8661  1a7d b6cb          	ld	a,_mess+11
8662  1a7f a177          	cp	a,#119
8663  1a81 2603          	jrne	L5173
8666  1a83 5f            	clrw	x
8667  1a84 bf5b          	ldw	__x_,x
8668  1a86               L5173:
8669                     ; 1773      gran(&_x_,-XMAX,XMAX);
8671  1a86 ae0019        	ldw	x,#25
8672  1a89 89            	pushw	x
8673  1a8a aeffe7        	ldw	x,#65511
8674  1a8d 89            	pushw	x
8675  1a8e ae005b        	ldw	x,#__x_
8676  1a91 cd0000        	call	_gran
8678  1a94 5b04          	addw	sp,#4
8680  1a96 aca31ba3      	jpf	L1243
8681  1a9a               L1173:
8682                     ; 1775 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8684  1a9a b6c6          	ld	a,_mess+6
8685  1a9c c10001        	cp	a,_adress
8686  1a9f 2665          	jrne	L7273
8688  1aa1 b6c7          	ld	a,_mess+7
8689  1aa3 c10001        	cp	a,_adress
8690  1aa6 265e          	jrne	L7273
8692  1aa8 b6c8          	ld	a,_mess+8
8693  1aaa a116          	cp	a,#22
8694  1aac 2658          	jrne	L7273
8696  1aae b6c9          	ld	a,_mess+9
8697  1ab0 b1ca          	cp	a,_mess+10
8698  1ab2 2652          	jrne	L7273
8700  1ab4 b6c9          	ld	a,_mess+9
8701  1ab6 a1ee          	cp	a,#238
8702  1ab8 264c          	jrne	L7273
8703                     ; 1777 	rotor_int++;
8705  1aba be1a          	ldw	x,_rotor_int
8706  1abc 1c0001        	addw	x,#1
8707  1abf bf1a          	ldw	_rotor_int,x
8708                     ; 1778      tempI=pwm_u;
8710  1ac1 be0b          	ldw	x,_pwm_u
8711  1ac3 1f04          	ldw	(OFST-1,sp),x
8712                     ; 1779 	ee_U_AVT=tempI;
8714  1ac5 1e04          	ldw	x,(OFST-1,sp)
8715  1ac7 89            	pushw	x
8716  1ac8 ae000a        	ldw	x,#_ee_U_AVT
8717  1acb cd0000        	call	c_eewrw
8719  1ace 85            	popw	x
8720                     ; 1780 	UU_AVT=Un;
8722  1acf be69          	ldw	x,_Un
8723  1ad1 89            	pushw	x
8724  1ad2 ae0006        	ldw	x,#_UU_AVT
8725  1ad5 cd0000        	call	c_eewrw
8727  1ad8 85            	popw	x
8728                     ; 1781 	delay_ms(100);
8730  1ad9 ae0064        	ldw	x,#100
8731  1adc cd004c        	call	_delay_ms
8733                     ; 1782 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
8735  1adf ce000a        	ldw	x,_ee_U_AVT
8736  1ae2 1304          	cpw	x,(OFST-1,sp)
8737  1ae4 2703          	jreq	L042
8738  1ae6 cc1ba3        	jp	L1243
8739  1ae9               L042:
8742  1ae9 4b00          	push	#0
8743  1aeb 4b00          	push	#0
8744  1aed 4b00          	push	#0
8745  1aef 4b00          	push	#0
8746  1af1 4bdd          	push	#221
8747  1af3 4bdd          	push	#221
8748  1af5 4b91          	push	#145
8749  1af7 3b0001        	push	_adress
8750  1afa ae018e        	ldw	x,#398
8751  1afd cd13ce        	call	_can_transmit
8753  1b00 5b08          	addw	sp,#8
8754  1b02 aca31ba3      	jpf	L1243
8755  1b06               L7273:
8756                     ; 1787 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8758  1b06 b6c7          	ld	a,_mess+7
8759  1b08 a1da          	cp	a,#218
8760  1b0a 2652          	jrne	L5373
8762  1b0c b6c6          	ld	a,_mess+6
8763  1b0e c10001        	cp	a,_adress
8764  1b11 274b          	jreq	L5373
8766  1b13 b6c6          	ld	a,_mess+6
8767  1b15 a106          	cp	a,#6
8768  1b17 2445          	jruge	L5373
8769                     ; 1789 	i_main_bps_cnt[mess[6]]=0;
8771  1b19 b6c6          	ld	a,_mess+6
8772  1b1b 5f            	clrw	x
8773  1b1c 97            	ld	xl,a
8774  1b1d 6f06          	clr	(_i_main_bps_cnt,x)
8775                     ; 1790 	i_main_flag[mess[6]]=1;
8777  1b1f b6c6          	ld	a,_mess+6
8778  1b21 5f            	clrw	x
8779  1b22 97            	ld	xl,a
8780  1b23 a601          	ld	a,#1
8781  1b25 e711          	ld	(_i_main_flag,x),a
8782                     ; 1791 	if(bMAIN)
8784                     	btst	_bMAIN
8785  1b2c 2475          	jruge	L1243
8786                     ; 1793 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
8788  1b2e b6c9          	ld	a,_mess+9
8789  1b30 5f            	clrw	x
8790  1b31 97            	ld	xl,a
8791  1b32 4f            	clr	a
8792  1b33 02            	rlwa	x,a
8793  1b34 1f01          	ldw	(OFST-4,sp),x
8794  1b36 b6c8          	ld	a,_mess+8
8795  1b38 5f            	clrw	x
8796  1b39 97            	ld	xl,a
8797  1b3a 72fb01        	addw	x,(OFST-4,sp)
8798  1b3d b6c6          	ld	a,_mess+6
8799  1b3f 905f          	clrw	y
8800  1b41 9097          	ld	yl,a
8801  1b43 9058          	sllw	y
8802  1b45 90ef17        	ldw	(_i_main,y),x
8803                     ; 1794 		i_main[adress]=I;
8805  1b48 c60001        	ld	a,_adress
8806  1b4b 5f            	clrw	x
8807  1b4c 97            	ld	xl,a
8808  1b4d 58            	sllw	x
8809  1b4e 90be6b        	ldw	y,_I
8810  1b51 ef17          	ldw	(_i_main,x),y
8811                     ; 1795      	i_main_flag[adress]=1;
8813  1b53 c60001        	ld	a,_adress
8814  1b56 5f            	clrw	x
8815  1b57 97            	ld	xl,a
8816  1b58 a601          	ld	a,#1
8817  1b5a e711          	ld	(_i_main_flag,x),a
8818  1b5c 2045          	jra	L1243
8819  1b5e               L5373:
8820                     ; 1799 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
8822  1b5e b6c7          	ld	a,_mess+7
8823  1b60 a1db          	cp	a,#219
8824  1b62 263f          	jrne	L1243
8826  1b64 b6c6          	ld	a,_mess+6
8827  1b66 c10001        	cp	a,_adress
8828  1b69 2738          	jreq	L1243
8830  1b6b b6c6          	ld	a,_mess+6
8831  1b6d a106          	cp	a,#6
8832  1b6f 2432          	jruge	L1243
8833                     ; 1801 	i_main_bps_cnt[mess[6]]=0;
8835  1b71 b6c6          	ld	a,_mess+6
8836  1b73 5f            	clrw	x
8837  1b74 97            	ld	xl,a
8838  1b75 6f06          	clr	(_i_main_bps_cnt,x)
8839                     ; 1802 	i_main_flag[mess[6]]=1;		
8841  1b77 b6c6          	ld	a,_mess+6
8842  1b79 5f            	clrw	x
8843  1b7a 97            	ld	xl,a
8844  1b7b a601          	ld	a,#1
8845  1b7d e711          	ld	(_i_main_flag,x),a
8846                     ; 1803 	if(bMAIN)
8848                     	btst	_bMAIN
8849  1b84 241d          	jruge	L1243
8850                     ; 1805 		if(mess[9]==0)i_main_flag[i]=1;
8852  1b86 3dc9          	tnz	_mess+9
8853  1b88 260a          	jrne	L7473
8856  1b8a 7b03          	ld	a,(OFST-2,sp)
8857  1b8c 5f            	clrw	x
8858  1b8d 97            	ld	xl,a
8859  1b8e a601          	ld	a,#1
8860  1b90 e711          	ld	(_i_main_flag,x),a
8862  1b92 2006          	jra	L1573
8863  1b94               L7473:
8864                     ; 1806 		else i_main_flag[i]=0;
8866  1b94 7b03          	ld	a,(OFST-2,sp)
8867  1b96 5f            	clrw	x
8868  1b97 97            	ld	xl,a
8869  1b98 6f11          	clr	(_i_main_flag,x)
8870  1b9a               L1573:
8871                     ; 1807 		i_main_flag[adress]=1;
8873  1b9a c60001        	ld	a,_adress
8874  1b9d 5f            	clrw	x
8875  1b9e 97            	ld	xl,a
8876  1b9f a601          	ld	a,#1
8877  1ba1 e711          	ld	(_i_main_flag,x),a
8878  1ba3               L1243:
8879                     ; 1813 can_in_an_end:
8879                     ; 1814 bCAN_RX=0;
8881  1ba3 3f09          	clr	_bCAN_RX
8882                     ; 1815 }   
8885  1ba5 5b05          	addw	sp,#5
8886  1ba7 81            	ret
8909                     ; 1818 void t4_init(void){
8910                     	switch	.text
8911  1ba8               _t4_init:
8915                     ; 1819 	TIM4->PSCR = 4;
8917  1ba8 35045345      	mov	21317,#4
8918                     ; 1820 	TIM4->ARR= 77;
8920  1bac 354d5346      	mov	21318,#77
8921                     ; 1821 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8923  1bb0 72105341      	bset	21313,#0
8924                     ; 1823 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8926  1bb4 35855340      	mov	21312,#133
8927                     ; 1825 }
8930  1bb8 81            	ret
8953                     ; 1828 void t1_init(void)
8953                     ; 1829 {
8954                     	switch	.text
8955  1bb9               _t1_init:
8959                     ; 1830 TIM1->ARRH= 0x03;
8961  1bb9 35035262      	mov	21090,#3
8962                     ; 1831 TIM1->ARRL= 0xff;
8964  1bbd 35ff5263      	mov	21091,#255
8965                     ; 1832 TIM1->CCR1H= 0x00;	
8967  1bc1 725f5265      	clr	21093
8968                     ; 1833 TIM1->CCR1L= 0xff;
8970  1bc5 35ff5266      	mov	21094,#255
8971                     ; 1834 TIM1->CCR2H= 0x00;	
8973  1bc9 725f5267      	clr	21095
8974                     ; 1835 TIM1->CCR2L= 0x00;
8976  1bcd 725f5268      	clr	21096
8977                     ; 1836 TIM1->CCR3H= 0x00;	
8979  1bd1 725f5269      	clr	21097
8980                     ; 1837 TIM1->CCR3L= 0x64;
8982  1bd5 3564526a      	mov	21098,#100
8983                     ; 1839 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8985  1bd9 35685258      	mov	21080,#104
8986                     ; 1840 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8988  1bdd 35685259      	mov	21081,#104
8989                     ; 1841 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8991  1be1 3568525a      	mov	21082,#104
8992                     ; 1842 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8994  1be5 3511525c      	mov	21084,#17
8995                     ; 1843 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8997  1be9 3501525d      	mov	21085,#1
8998                     ; 1844 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9000  1bed 35815250      	mov	21072,#129
9001                     ; 1845 TIM1->BKR|= TIM1_BKR_AOE;
9003  1bf1 721c526d      	bset	21101,#6
9004                     ; 1846 }
9007  1bf5 81            	ret
9032                     ; 1850 void adc2_init(void)
9032                     ; 1851 {
9033                     	switch	.text
9034  1bf6               _adc2_init:
9038                     ; 1852 adc_plazma[0]++;
9040  1bf6 beb2          	ldw	x,_adc_plazma
9041  1bf8 1c0001        	addw	x,#1
9042  1bfb bfb2          	ldw	_adc_plazma,x
9043                     ; 1876 GPIOB->DDR&=~(1<<4);
9045  1bfd 72195007      	bres	20487,#4
9046                     ; 1877 GPIOB->CR1&=~(1<<4);
9048  1c01 72195008      	bres	20488,#4
9049                     ; 1878 GPIOB->CR2&=~(1<<4);
9051  1c05 72195009      	bres	20489,#4
9052                     ; 1880 GPIOB->DDR&=~(1<<5);
9054  1c09 721b5007      	bres	20487,#5
9055                     ; 1881 GPIOB->CR1&=~(1<<5);
9057  1c0d 721b5008      	bres	20488,#5
9058                     ; 1882 GPIOB->CR2&=~(1<<5);
9060  1c11 721b5009      	bres	20489,#5
9061                     ; 1884 GPIOB->DDR&=~(1<<6);
9063  1c15 721d5007      	bres	20487,#6
9064                     ; 1885 GPIOB->CR1&=~(1<<6);
9066  1c19 721d5008      	bres	20488,#6
9067                     ; 1886 GPIOB->CR2&=~(1<<6);
9069  1c1d 721d5009      	bres	20489,#6
9070                     ; 1888 GPIOB->DDR&=~(1<<7);
9072  1c21 721f5007      	bres	20487,#7
9073                     ; 1889 GPIOB->CR1&=~(1<<7);
9075  1c25 721f5008      	bres	20488,#7
9076                     ; 1890 GPIOB->CR2&=~(1<<7);
9078  1c29 721f5009      	bres	20489,#7
9079                     ; 1900 ADC2->TDRL=0xff;
9081  1c2d 35ff5407      	mov	21511,#255
9082                     ; 1902 ADC2->CR2=0x08;
9084  1c31 35085402      	mov	21506,#8
9085                     ; 1903 ADC2->CR1=0x40;
9087  1c35 35405401      	mov	21505,#64
9088                     ; 1906 	ADC2->CSR=0x20+adc_ch+3;
9090  1c39 b6bf          	ld	a,_adc_ch
9091  1c3b ab23          	add	a,#35
9092  1c3d c75400        	ld	21504,a
9093                     ; 1908 	ADC2->CR1|=1;
9095  1c40 72105401      	bset	21505,#0
9096                     ; 1909 	ADC2->CR1|=1;
9098  1c44 72105401      	bset	21505,#0
9099                     ; 1912 adc_plazma[1]=adc_ch;
9101  1c48 b6bf          	ld	a,_adc_ch
9102  1c4a 5f            	clrw	x
9103  1c4b 97            	ld	xl,a
9104  1c4c bfb4          	ldw	_adc_plazma+2,x
9105                     ; 1913 }
9108  1c4e 81            	ret
9142                     ; 1922 @far @interrupt void TIM4_UPD_Interrupt (void) 
9142                     ; 1923 {
9144                     	switch	.text
9145  1c4f               f_TIM4_UPD_Interrupt:
9149                     ; 1924 TIM4->SR1&=~TIM4_SR1_UIF;
9151  1c4f 72115342      	bres	21314,#0
9152                     ; 1926 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9154  1c53 3c05          	inc	_pwm_vent_cnt
9155  1c55 b605          	ld	a,_pwm_vent_cnt
9156  1c57 a10a          	cp	a,#10
9157  1c59 2502          	jrult	L3104
9160  1c5b 3f05          	clr	_pwm_vent_cnt
9161  1c5d               L3104:
9162                     ; 1927 GPIOB->ODR|=(1<<3);
9164  1c5d 72165005      	bset	20485,#3
9165                     ; 1928 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9167  1c61 b605          	ld	a,_pwm_vent_cnt
9168  1c63 a105          	cp	a,#5
9169  1c65 2504          	jrult	L5104
9172  1c67 72175005      	bres	20485,#3
9173  1c6b               L5104:
9174                     ; 1933 if(++t0_cnt0>=100)
9176  1c6b 9c            	rvf
9177  1c6c be00          	ldw	x,_t0_cnt0
9178  1c6e 1c0001        	addw	x,#1
9179  1c71 bf00          	ldw	_t0_cnt0,x
9180  1c73 a30064        	cpw	x,#100
9181  1c76 2f3f          	jrslt	L7104
9182                     ; 1935 	t0_cnt0=0;
9184  1c78 5f            	clrw	x
9185  1c79 bf00          	ldw	_t0_cnt0,x
9186                     ; 1936 	b100Hz=1;
9188  1c7b 72100008      	bset	_b100Hz
9189                     ; 1938 	if(++t0_cnt1>=10)
9191  1c7f 3c02          	inc	_t0_cnt1
9192  1c81 b602          	ld	a,_t0_cnt1
9193  1c83 a10a          	cp	a,#10
9194  1c85 2506          	jrult	L1204
9195                     ; 1940 		t0_cnt1=0;
9197  1c87 3f02          	clr	_t0_cnt1
9198                     ; 1941 		b10Hz=1;
9200  1c89 72100007      	bset	_b10Hz
9201  1c8d               L1204:
9202                     ; 1944 	if(++t0_cnt2>=20)
9204  1c8d 3c03          	inc	_t0_cnt2
9205  1c8f b603          	ld	a,_t0_cnt2
9206  1c91 a114          	cp	a,#20
9207  1c93 2506          	jrult	L3204
9208                     ; 1946 		t0_cnt2=0;
9210  1c95 3f03          	clr	_t0_cnt2
9211                     ; 1947 		b5Hz=1;
9213  1c97 72100006      	bset	_b5Hz
9214  1c9b               L3204:
9215                     ; 1951 	if(++t0_cnt4>=50)
9217  1c9b 3c05          	inc	_t0_cnt4
9218  1c9d b605          	ld	a,_t0_cnt4
9219  1c9f a132          	cp	a,#50
9220  1ca1 2506          	jrult	L5204
9221                     ; 1953 		t0_cnt4=0;
9223  1ca3 3f05          	clr	_t0_cnt4
9224                     ; 1954 		b2Hz=1;
9226  1ca5 72100005      	bset	_b2Hz
9227  1ca9               L5204:
9228                     ; 1957 	if(++t0_cnt3>=100)
9230  1ca9 3c04          	inc	_t0_cnt3
9231  1cab b604          	ld	a,_t0_cnt3
9232  1cad a164          	cp	a,#100
9233  1caf 2506          	jrult	L7104
9234                     ; 1959 		t0_cnt3=0;
9236  1cb1 3f04          	clr	_t0_cnt3
9237                     ; 1960 		b1Hz=1;
9239  1cb3 72100004      	bset	_b1Hz
9240  1cb7               L7104:
9241                     ; 1966 }
9244  1cb7 80            	iret
9269                     ; 1969 @far @interrupt void CAN_RX_Interrupt (void) 
9269                     ; 1970 {
9270                     	switch	.text
9271  1cb8               f_CAN_RX_Interrupt:
9275                     ; 1972 CAN->PSR= 7;									// page 7 - read messsage
9277  1cb8 35075427      	mov	21543,#7
9278                     ; 1974 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9280  1cbc ae000e        	ldw	x,#14
9281  1cbf               L452:
9282  1cbf d65427        	ld	a,(21543,x)
9283  1cc2 e7bf          	ld	(_mess-1,x),a
9284  1cc4 5a            	decw	x
9285  1cc5 26f8          	jrne	L452
9286                     ; 1985 bCAN_RX=1;
9288  1cc7 35010009      	mov	_bCAN_RX,#1
9289                     ; 1986 CAN->RFR|=(1<<5);
9291  1ccb 721a5424      	bset	21540,#5
9292                     ; 1988 }
9295  1ccf 80            	iret
9318                     ; 1991 @far @interrupt void CAN_TX_Interrupt (void) 
9318                     ; 1992 {
9319                     	switch	.text
9320  1cd0               f_CAN_TX_Interrupt:
9324                     ; 1993 if((CAN->TSR)&(1<<0))
9326  1cd0 c65422        	ld	a,21538
9327  1cd3 a501          	bcp	a,#1
9328  1cd5 2708          	jreq	L1504
9329                     ; 1995 	bTX_FREE=1;	
9331  1cd7 35010008      	mov	_bTX_FREE,#1
9332                     ; 1997 	CAN->TSR|=(1<<0);
9334  1cdb 72105422      	bset	21538,#0
9335  1cdf               L1504:
9336                     ; 1999 }
9339  1cdf 80            	iret
9397                     ; 2002 @far @interrupt void ADC2_EOC_Interrupt (void) {
9398                     	switch	.text
9399  1ce0               f_ADC2_EOC_Interrupt:
9401       00000009      OFST:	set	9
9402  1ce0 be00          	ldw	x,c_x
9403  1ce2 89            	pushw	x
9404  1ce3 be00          	ldw	x,c_y
9405  1ce5 89            	pushw	x
9406  1ce6 be02          	ldw	x,c_lreg+2
9407  1ce8 89            	pushw	x
9408  1ce9 be00          	ldw	x,c_lreg
9409  1ceb 89            	pushw	x
9410  1cec 5209          	subw	sp,#9
9413                     ; 2007 adc_plazma[2]++;
9415  1cee beb6          	ldw	x,_adc_plazma+4
9416  1cf0 1c0001        	addw	x,#1
9417  1cf3 bfb6          	ldw	_adc_plazma+4,x
9418                     ; 2014 ADC2->CSR&=~(1<<7);
9420  1cf5 721f5400      	bres	21504,#7
9421                     ; 2016 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9423  1cf9 c65405        	ld	a,21509
9424  1cfc b703          	ld	c_lreg+3,a
9425  1cfe 3f02          	clr	c_lreg+2
9426  1d00 3f01          	clr	c_lreg+1
9427  1d02 3f00          	clr	c_lreg
9428  1d04 96            	ldw	x,sp
9429  1d05 1c0001        	addw	x,#OFST-8
9430  1d08 cd0000        	call	c_rtol
9432  1d0b c65404        	ld	a,21508
9433  1d0e 5f            	clrw	x
9434  1d0f 97            	ld	xl,a
9435  1d10 90ae0100      	ldw	y,#256
9436  1d14 cd0000        	call	c_umul
9438  1d17 96            	ldw	x,sp
9439  1d18 1c0001        	addw	x,#OFST-8
9440  1d1b cd0000        	call	c_ladd
9442  1d1e 96            	ldw	x,sp
9443  1d1f 1c0006        	addw	x,#OFST-3
9444  1d22 cd0000        	call	c_rtol
9446                     ; 2021 if(adr_drv_stat==1)
9448  1d25 b607          	ld	a,_adr_drv_stat
9449  1d27 a101          	cp	a,#1
9450  1d29 260b          	jrne	L1014
9451                     ; 2023 	adr_drv_stat=2;
9453  1d2b 35020007      	mov	_adr_drv_stat,#2
9454                     ; 2024 	adc_buff_[0]=temp_adc;
9456  1d2f 1e08          	ldw	x,(OFST-1,sp)
9457  1d31 cf0005        	ldw	_adc_buff_,x
9459  1d34 2020          	jra	L3014
9460  1d36               L1014:
9461                     ; 2027 else if(adr_drv_stat==3)
9463  1d36 b607          	ld	a,_adr_drv_stat
9464  1d38 a103          	cp	a,#3
9465  1d3a 260b          	jrne	L5014
9466                     ; 2029 	adr_drv_stat=4;
9468  1d3c 35040007      	mov	_adr_drv_stat,#4
9469                     ; 2030 	adc_buff_[1]=temp_adc;
9471  1d40 1e08          	ldw	x,(OFST-1,sp)
9472  1d42 cf0007        	ldw	_adc_buff_+2,x
9474  1d45 200f          	jra	L3014
9475  1d47               L5014:
9476                     ; 2033 else if(adr_drv_stat==5)
9478  1d47 b607          	ld	a,_adr_drv_stat
9479  1d49 a105          	cp	a,#5
9480  1d4b 2609          	jrne	L3014
9481                     ; 2035 	adr_drv_stat=6;
9483  1d4d 35060007      	mov	_adr_drv_stat,#6
9484                     ; 2036 	adc_buff_[9]=temp_adc;
9486  1d51 1e08          	ldw	x,(OFST-1,sp)
9487  1d53 cf0017        	ldw	_adc_buff_+18,x
9488  1d56               L3014:
9489                     ; 2039 adc_buff[adc_ch][adc_cnt]=temp_adc;
9491  1d56 b6be          	ld	a,_adc_cnt
9492  1d58 5f            	clrw	x
9493  1d59 97            	ld	xl,a
9494  1d5a 58            	sllw	x
9495  1d5b 1f03          	ldw	(OFST-6,sp),x
9496  1d5d b6bf          	ld	a,_adc_ch
9497  1d5f 97            	ld	xl,a
9498  1d60 a620          	ld	a,#32
9499  1d62 42            	mul	x,a
9500  1d63 72fb03        	addw	x,(OFST-6,sp)
9501  1d66 1608          	ldw	y,(OFST-1,sp)
9502  1d68 df0019        	ldw	(_adc_buff,x),y
9503                     ; 2045 adc_ch++;
9505  1d6b 3cbf          	inc	_adc_ch
9506                     ; 2046 if(adc_ch>=5)
9508  1d6d b6bf          	ld	a,_adc_ch
9509  1d6f a105          	cp	a,#5
9510  1d71 250c          	jrult	L3114
9511                     ; 2049 	adc_ch=0;
9513  1d73 3fbf          	clr	_adc_ch
9514                     ; 2050 	adc_cnt++;
9516  1d75 3cbe          	inc	_adc_cnt
9517                     ; 2051 	if(adc_cnt>=16)
9519  1d77 b6be          	ld	a,_adc_cnt
9520  1d79 a110          	cp	a,#16
9521  1d7b 2502          	jrult	L3114
9522                     ; 2053 		adc_cnt=0;
9524  1d7d 3fbe          	clr	_adc_cnt
9525  1d7f               L3114:
9526                     ; 2057 if((adc_cnt&0x03)==0)
9528  1d7f b6be          	ld	a,_adc_cnt
9529  1d81 a503          	bcp	a,#3
9530  1d83 264b          	jrne	L7114
9531                     ; 2061 	tempSS=0;
9533  1d85 ae0000        	ldw	x,#0
9534  1d88 1f08          	ldw	(OFST-1,sp),x
9535  1d8a ae0000        	ldw	x,#0
9536  1d8d 1f06          	ldw	(OFST-3,sp),x
9537                     ; 2062 	for(i=0;i<16;i++)
9539  1d8f 0f05          	clr	(OFST-4,sp)
9540  1d91               L1214:
9541                     ; 2064 		tempSS+=(signed long)adc_buff[adc_ch][i];
9543  1d91 7b05          	ld	a,(OFST-4,sp)
9544  1d93 5f            	clrw	x
9545  1d94 97            	ld	xl,a
9546  1d95 58            	sllw	x
9547  1d96 1f03          	ldw	(OFST-6,sp),x
9548  1d98 b6bf          	ld	a,_adc_ch
9549  1d9a 97            	ld	xl,a
9550  1d9b a620          	ld	a,#32
9551  1d9d 42            	mul	x,a
9552  1d9e 72fb03        	addw	x,(OFST-6,sp)
9553  1da1 de0019        	ldw	x,(_adc_buff,x)
9554  1da4 cd0000        	call	c_itolx
9556  1da7 96            	ldw	x,sp
9557  1da8 1c0006        	addw	x,#OFST-3
9558  1dab cd0000        	call	c_lgadd
9560                     ; 2062 	for(i=0;i<16;i++)
9562  1dae 0c05          	inc	(OFST-4,sp)
9565  1db0 7b05          	ld	a,(OFST-4,sp)
9566  1db2 a110          	cp	a,#16
9567  1db4 25db          	jrult	L1214
9568                     ; 2066 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9570  1db6 96            	ldw	x,sp
9571  1db7 1c0006        	addw	x,#OFST-3
9572  1dba cd0000        	call	c_ltor
9574  1dbd a604          	ld	a,#4
9575  1dbf cd0000        	call	c_lrsh
9577  1dc2 be02          	ldw	x,c_lreg+2
9578  1dc4 b6bf          	ld	a,_adc_ch
9579  1dc6 905f          	clrw	y
9580  1dc8 9097          	ld	yl,a
9581  1dca 9058          	sllw	y
9582  1dcc 90df0005      	ldw	(_adc_buff_,y),x
9583  1dd0               L7114:
9584                     ; 2077 adc_plazma_short++;
9586  1dd0 bebc          	ldw	x,_adc_plazma_short
9587  1dd2 1c0001        	addw	x,#1
9588  1dd5 bfbc          	ldw	_adc_plazma_short,x
9589                     ; 2092 }
9592  1dd7 5b09          	addw	sp,#9
9593  1dd9 85            	popw	x
9594  1dda bf00          	ldw	c_lreg,x
9595  1ddc 85            	popw	x
9596  1ddd bf02          	ldw	c_lreg+2,x
9597  1ddf 85            	popw	x
9598  1de0 bf00          	ldw	c_y,x
9599  1de2 85            	popw	x
9600  1de3 bf00          	ldw	c_x,x
9601  1de5 80            	iret
9664                     ; 2100 main()
9664                     ; 2101 {
9666                     	switch	.text
9667  1de6               _main:
9671                     ; 2103 CLK->ECKR|=1;
9673  1de6 721050c1      	bset	20673,#0
9675  1dea               L1414:
9676                     ; 2104 while((CLK->ECKR & 2) == 0);
9678  1dea c650c1        	ld	a,20673
9679  1ded a502          	bcp	a,#2
9680  1def 27f9          	jreq	L1414
9681                     ; 2105 CLK->SWCR|=2;
9683  1df1 721250c5      	bset	20677,#1
9684                     ; 2106 CLK->SWR=0xB4;
9686  1df5 35b450c4      	mov	20676,#180
9687                     ; 2108 delay_ms(200);
9689  1df9 ae00c8        	ldw	x,#200
9690  1dfc cd004c        	call	_delay_ms
9692                     ; 2109 FLASH_DUKR=0xae;
9694  1dff 35ae5064      	mov	_FLASH_DUKR,#174
9695                     ; 2110 FLASH_DUKR=0x56;
9697  1e03 35565064      	mov	_FLASH_DUKR,#86
9698                     ; 2111 enableInterrupts();
9701  1e07 9a            rim
9703                     ; 2114 adr_drv_v3();
9706  1e08 cd101c        	call	_adr_drv_v3
9708                     ; 2118 t4_init();
9710  1e0b cd1ba8        	call	_t4_init
9712                     ; 2120 		GPIOG->DDR|=(1<<0);
9714  1e0e 72105020      	bset	20512,#0
9715                     ; 2121 		GPIOG->CR1|=(1<<0);
9717  1e12 72105021      	bset	20513,#0
9718                     ; 2122 		GPIOG->CR2&=~(1<<0);	
9720  1e16 72115022      	bres	20514,#0
9721                     ; 2125 		GPIOG->DDR&=~(1<<1);
9723  1e1a 72135020      	bres	20512,#1
9724                     ; 2126 		GPIOG->CR1|=(1<<1);
9726  1e1e 72125021      	bset	20513,#1
9727                     ; 2127 		GPIOG->CR2&=~(1<<1);
9729  1e22 72135022      	bres	20514,#1
9730                     ; 2129 init_CAN();
9732  1e26 cd135f        	call	_init_CAN
9734                     ; 2134 GPIOC->DDR|=(1<<1);
9736  1e29 7212500c      	bset	20492,#1
9737                     ; 2135 GPIOC->CR1|=(1<<1);
9739  1e2d 7212500d      	bset	20493,#1
9740                     ; 2136 GPIOC->CR2|=(1<<1);
9742  1e31 7212500e      	bset	20494,#1
9743                     ; 2138 GPIOC->DDR|=(1<<2);
9745  1e35 7214500c      	bset	20492,#2
9746                     ; 2139 GPIOC->CR1|=(1<<2);
9748  1e39 7214500d      	bset	20493,#2
9749                     ; 2140 GPIOC->CR2|=(1<<2);
9751  1e3d 7214500e      	bset	20494,#2
9752                     ; 2147 t1_init();
9754  1e41 cd1bb9        	call	_t1_init
9756                     ; 2149 GPIOA->DDR|=(1<<5);
9758  1e44 721a5002      	bset	20482,#5
9759                     ; 2150 GPIOA->CR1|=(1<<5);
9761  1e48 721a5003      	bset	20483,#5
9762                     ; 2151 GPIOA->CR2&=~(1<<5);
9764  1e4c 721b5004      	bres	20484,#5
9765                     ; 2157 GPIOB->DDR|=(1<<3);
9767  1e50 72165007      	bset	20487,#3
9768                     ; 2158 GPIOB->CR1|=(1<<3);
9770  1e54 72165008      	bset	20488,#3
9771                     ; 2159 GPIOB->CR2|=(1<<3);
9773  1e58 72165009      	bset	20489,#3
9774                     ; 2161 GPIOC->DDR|=(1<<3);
9776  1e5c 7216500c      	bset	20492,#3
9777                     ; 2162 GPIOC->CR1|=(1<<3);
9779  1e60 7216500d      	bset	20493,#3
9780                     ; 2163 GPIOC->CR2|=(1<<3);
9782  1e64 7216500e      	bset	20494,#3
9783                     ; 2166 if(bps_class==bpsIPS) 
9785  1e68 b601          	ld	a,_bps_class
9786  1e6a a101          	cp	a,#1
9787  1e6c 260a          	jrne	L7414
9788                     ; 2168 	pwm_u=ee_U_AVT;
9790  1e6e ce000a        	ldw	x,_ee_U_AVT
9791  1e71 bf0b          	ldw	_pwm_u,x
9792                     ; 2169 	volum_u_main_=ee_U_AVT;
9794  1e73 ce000a        	ldw	x,_ee_U_AVT
9795  1e76 bf1c          	ldw	_volum_u_main_,x
9796  1e78               L7414:
9797                     ; 2176 	if(bCAN_RX)
9799  1e78 3d09          	tnz	_bCAN_RX
9800  1e7a 2705          	jreq	L3514
9801                     ; 2178 		bCAN_RX=0;
9803  1e7c 3f09          	clr	_bCAN_RX
9804                     ; 2179 		can_in_an();	
9806  1e7e cd156a        	call	_can_in_an
9808  1e81               L3514:
9809                     ; 2181 	if(b100Hz)
9811                     	btst	_b100Hz
9812  1e86 240a          	jruge	L5514
9813                     ; 2183 		b100Hz=0;
9815  1e88 72110008      	bres	_b100Hz
9816                     ; 2192 		adc2_init();
9818  1e8c cd1bf6        	call	_adc2_init
9820                     ; 2193 		can_tx_hndl();
9822  1e8f cd1452        	call	_can_tx_hndl
9824  1e92               L5514:
9825                     ; 2196 	if(b10Hz)
9827                     	btst	_b10Hz
9828  1e97 2419          	jruge	L7514
9829                     ; 2198 		b10Hz=0;
9831  1e99 72110007      	bres	_b10Hz
9832                     ; 2200           matemat();
9834  1e9d cd0bd3        	call	_matemat
9836                     ; 2201 	    	led_drv(); 
9838  1ea0 cd0711        	call	_led_drv
9840                     ; 2202 	     link_drv();
9842  1ea3 cd07ff        	call	_link_drv
9844                     ; 2203 	     pwr_hndl();		//вычисление воздействий на силу
9846  1ea6 cd0ab7        	call	_pwr_hndl
9848                     ; 2204 	     JP_drv();
9850  1ea9 cd0774        	call	_JP_drv
9852                     ; 2205 	     flags_drv();
9854  1eac cd0fd1        	call	_flags_drv
9856                     ; 2206 		net_drv();
9858  1eaf cd14bc        	call	_net_drv
9860  1eb2               L7514:
9861                     ; 2209 	if(b5Hz)
9863                     	btst	_b5Hz
9864  1eb7 240d          	jruge	L1614
9865                     ; 2211 		b5Hz=0;
9867  1eb9 72110006      	bres	_b5Hz
9868                     ; 2213 		pwr_drv();		//воздействие на силу
9870  1ebd cd09b3        	call	_pwr_drv
9872                     ; 2214 		led_hndl();
9874  1ec0 cd008e        	call	_led_hndl
9876                     ; 2216 		vent_drv();
9878  1ec3 cd084e        	call	_vent_drv
9880  1ec6               L1614:
9881                     ; 2219 	if(b2Hz)
9883                     	btst	_b2Hz
9884  1ecb 2404          	jruge	L3614
9885                     ; 2221 		b2Hz=0;
9887  1ecd 72110005      	bres	_b2Hz
9888  1ed1               L3614:
9889                     ; 2230 	if(b1Hz)
9891                     	btst	_b1Hz
9892  1ed6 24a0          	jruge	L7414
9893                     ; 2232 		b1Hz=0;
9895  1ed8 72110004      	bres	_b1Hz
9896                     ; 2234 		temper_drv();			//вычисление аварий температуры
9898  1edc cd0d01        	call	_temper_drv
9900                     ; 2235 		u_drv();
9902  1edf cd0dd8        	call	_u_drv
9904                     ; 2236           x_drv();
9906  1ee2 cd0eb8        	call	_x_drv
9908                     ; 2237           if(main_cnt<1000)main_cnt++;
9910  1ee5 9c            	rvf
9911  1ee6 be4e          	ldw	x,_main_cnt
9912  1ee8 a303e8        	cpw	x,#1000
9913  1eeb 2e07          	jrsge	L7614
9916  1eed be4e          	ldw	x,_main_cnt
9917  1eef 1c0001        	addw	x,#1
9918  1ef2 bf4e          	ldw	_main_cnt,x
9919  1ef4               L7614:
9920                     ; 2238   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9922  1ef4 b65f          	ld	a,_link
9923  1ef6 a1aa          	cp	a,#170
9924  1ef8 2706          	jreq	L3714
9926  1efa b647          	ld	a,_jp_mode
9927  1efc a103          	cp	a,#3
9928  1efe 2603          	jrne	L1714
9929  1f00               L3714:
9932  1f00 cd0f32        	call	_apv_hndl
9934  1f03               L1714:
9935                     ; 2241   		can_error_cnt++;
9937  1f03 3c6d          	inc	_can_error_cnt
9938                     ; 2242   		if(can_error_cnt>=10)
9940  1f05 b66d          	ld	a,_can_error_cnt
9941  1f07 a10a          	cp	a,#10
9942  1f09 2505          	jrult	L5714
9943                     ; 2244   			can_error_cnt=0;
9945  1f0b 3f6d          	clr	_can_error_cnt
9946                     ; 2245 			init_CAN();
9948  1f0d cd135f        	call	_init_CAN
9950  1f10               L5714:
9951                     ; 2249 		volum_u_main_drv();
9953  1f10 cd120c        	call	_volum_u_main_drv
9955                     ; 2251 		pwm_stat++;
9957  1f13 3c04          	inc	_pwm_stat
9958                     ; 2252 		if(pwm_stat>=10)pwm_stat=0;
9960  1f15 b604          	ld	a,_pwm_stat
9961  1f17 a10a          	cp	a,#10
9962  1f19 2502          	jrult	L7714
9965  1f1b 3f04          	clr	_pwm_stat
9966  1f1d               L7714:
9967                     ; 2253 adc_plazma_short++;
9969  1f1d bebc          	ldw	x,_adc_plazma_short
9970  1f1f 1c0001        	addw	x,#1
9971  1f22 bfbc          	ldw	_adc_plazma_short,x
9972  1f24 ac781e78      	jpf	L7414
10986                     	xdef	_main
10987                     	xdef	f_ADC2_EOC_Interrupt
10988                     	xdef	f_CAN_TX_Interrupt
10989                     	xdef	f_CAN_RX_Interrupt
10990                     	xdef	f_TIM4_UPD_Interrupt
10991                     	xdef	_adc2_init
10992                     	xdef	_t1_init
10993                     	xdef	_t4_init
10994                     	xdef	_can_in_an
10995                     	xdef	_net_drv
10996                     	xdef	_can_tx_hndl
10997                     	xdef	_can_transmit
10998                     	xdef	_init_CAN
10999                     	xdef	_volum_u_main_drv
11000                     	xdef	_adr_drv_v3
11001                     	xdef	_adr_drv_v4
11002                     	xdef	_flags_drv
11003                     	xdef	_apv_hndl
11004                     	xdef	_apv_stop
11005                     	xdef	_apv_start
11006                     	xdef	_x_drv
11007                     	xdef	_u_drv
11008                     	xdef	_temper_drv
11009                     	xdef	_matemat
11010                     	xdef	_pwr_hndl
11011                     	xdef	_pwr_drv
11012                     	xdef	_vent_drv
11013                     	xdef	_link_drv
11014                     	xdef	_JP_drv
11015                     	xdef	_led_drv
11016                     	xdef	_led_hndl
11017                     	xdef	_delay_ms
11018                     	xdef	_granee
11019                     	xdef	_gran
11020                     .eeprom:	section	.data
11021  0000               _ee_IMAXVENT:
11022  0000 0000          	ds.b	2
11023                     	xdef	_ee_IMAXVENT
11024                     	switch	.ubsct
11025  0001               _bps_class:
11026  0001 00            	ds.b	1
11027                     	xdef	_bps_class
11028  0002               _vent_pwm:
11029  0002 0000          	ds.b	2
11030                     	xdef	_vent_pwm
11031  0004               _pwm_stat:
11032  0004 00            	ds.b	1
11033                     	xdef	_pwm_stat
11034  0005               _pwm_vent_cnt:
11035  0005 00            	ds.b	1
11036                     	xdef	_pwm_vent_cnt
11037                     	switch	.eeprom
11038  0002               _ee_DEVICE:
11039  0002 0000          	ds.b	2
11040                     	xdef	_ee_DEVICE
11041  0004               _ee_AVT_MODE:
11042  0004 0000          	ds.b	2
11043                     	xdef	_ee_AVT_MODE
11044                     	switch	.ubsct
11045  0006               _i_main_bps_cnt:
11046  0006 000000000000  	ds.b	6
11047                     	xdef	_i_main_bps_cnt
11048  000c               _i_main_sigma:
11049  000c 0000          	ds.b	2
11050                     	xdef	_i_main_sigma
11051  000e               _i_main_num_of_bps:
11052  000e 00            	ds.b	1
11053                     	xdef	_i_main_num_of_bps
11054  000f               _i_main_avg:
11055  000f 0000          	ds.b	2
11056                     	xdef	_i_main_avg
11057  0011               _i_main_flag:
11058  0011 000000000000  	ds.b	6
11059                     	xdef	_i_main_flag
11060  0017               _i_main:
11061  0017 000000000000  	ds.b	12
11062                     	xdef	_i_main
11063  0023               _x:
11064  0023 000000000000  	ds.b	12
11065                     	xdef	_x
11066                     	xdef	_volum_u_main_
11067                     	switch	.eeprom
11068  0006               _UU_AVT:
11069  0006 0000          	ds.b	2
11070                     	xdef	_UU_AVT
11071                     	switch	.ubsct
11072  002f               _cnt_net_drv:
11073  002f 00            	ds.b	1
11074                     	xdef	_cnt_net_drv
11075                     	switch	.bit
11076  0001               _bMAIN:
11077  0001 00            	ds.b	1
11078                     	xdef	_bMAIN
11079                     	switch	.ubsct
11080  0030               _plazma_int:
11081  0030 000000000000  	ds.b	6
11082                     	xdef	_plazma_int
11083                     	xdef	_rotor_int
11084  0036               _led_green_buff:
11085  0036 00000000      	ds.b	4
11086                     	xdef	_led_green_buff
11087  003a               _led_red_buff:
11088  003a 00000000      	ds.b	4
11089                     	xdef	_led_red_buff
11090                     	xdef	_led_drv_cnt
11091                     	xdef	_led_green
11092                     	xdef	_led_red
11093  003e               _res_fl_cnt:
11094  003e 00            	ds.b	1
11095                     	xdef	_res_fl_cnt
11096                     	xdef	_bRES_
11097                     	xdef	_bRES
11098                     	switch	.eeprom
11099  0008               _res_fl_:
11100  0008 00            	ds.b	1
11101                     	xdef	_res_fl_
11102  0009               _res_fl:
11103  0009 00            	ds.b	1
11104                     	xdef	_res_fl
11105                     	switch	.ubsct
11106  003f               _cnt_apv_off:
11107  003f 00            	ds.b	1
11108                     	xdef	_cnt_apv_off
11109                     	switch	.bit
11110  0002               _bAPV:
11111  0002 00            	ds.b	1
11112                     	xdef	_bAPV
11113                     	switch	.ubsct
11114  0040               _apv_cnt_:
11115  0040 0000          	ds.b	2
11116                     	xdef	_apv_cnt_
11117  0042               _apv_cnt:
11118  0042 000000        	ds.b	3
11119                     	xdef	_apv_cnt
11120                     	xdef	_bBL_IPS
11121                     	switch	.bit
11122  0003               _bBL:
11123  0003 00            	ds.b	1
11124                     	xdef	_bBL
11125                     	switch	.ubsct
11126  0045               _cnt_JP1:
11127  0045 00            	ds.b	1
11128                     	xdef	_cnt_JP1
11129  0046               _cnt_JP0:
11130  0046 00            	ds.b	1
11131                     	xdef	_cnt_JP0
11132  0047               _jp_mode:
11133  0047 00            	ds.b	1
11134                     	xdef	_jp_mode
11135                     	xdef	_pwm_i
11136                     	xdef	_pwm_u
11137  0048               _tmax_cnt:
11138  0048 0000          	ds.b	2
11139                     	xdef	_tmax_cnt
11140  004a               _tsign_cnt:
11141  004a 0000          	ds.b	2
11142                     	xdef	_tsign_cnt
11143                     	switch	.eeprom
11144  000a               _ee_U_AVT:
11145  000a 0000          	ds.b	2
11146                     	xdef	_ee_U_AVT
11147  000c               _ee_tsign:
11148  000c 0000          	ds.b	2
11149                     	xdef	_ee_tsign
11150  000e               _ee_tmax:
11151  000e 0000          	ds.b	2
11152                     	xdef	_ee_tmax
11153  0010               _ee_dU:
11154  0010 0000          	ds.b	2
11155                     	xdef	_ee_dU
11156  0012               _ee_Umax:
11157  0012 0000          	ds.b	2
11158                     	xdef	_ee_Umax
11159  0014               _ee_TZAS:
11160  0014 0000          	ds.b	2
11161                     	xdef	_ee_TZAS
11162                     	switch	.ubsct
11163  004c               _main_cnt1:
11164  004c 0000          	ds.b	2
11165                     	xdef	_main_cnt1
11166  004e               _main_cnt:
11167  004e 0000          	ds.b	2
11168                     	xdef	_main_cnt
11169  0050               _off_bp_cnt:
11170  0050 00            	ds.b	1
11171                     	xdef	_off_bp_cnt
11172  0051               _flags_tu_cnt_off:
11173  0051 00            	ds.b	1
11174                     	xdef	_flags_tu_cnt_off
11175  0052               _flags_tu_cnt_on:
11176  0052 00            	ds.b	1
11177                     	xdef	_flags_tu_cnt_on
11178  0053               _vol_i_temp:
11179  0053 0000          	ds.b	2
11180                     	xdef	_vol_i_temp
11181  0055               _vol_u_temp:
11182  0055 0000          	ds.b	2
11183                     	xdef	_vol_u_temp
11184                     	switch	.eeprom
11185  0016               __x_ee_:
11186  0016 0000          	ds.b	2
11187                     	xdef	__x_ee_
11188                     	switch	.ubsct
11189  0057               __x_cnt:
11190  0057 0000          	ds.b	2
11191                     	xdef	__x_cnt
11192  0059               __x__:
11193  0059 0000          	ds.b	2
11194                     	xdef	__x__
11195  005b               __x_:
11196  005b 0000          	ds.b	2
11197                     	xdef	__x_
11198  005d               _flags_tu:
11199  005d 00            	ds.b	1
11200                     	xdef	_flags_tu
11201                     	xdef	_flags
11202  005e               _link_cnt:
11203  005e 00            	ds.b	1
11204                     	xdef	_link_cnt
11205  005f               _link:
11206  005f 00            	ds.b	1
11207                     	xdef	_link
11208  0060               _umin_cnt:
11209  0060 0000          	ds.b	2
11210                     	xdef	_umin_cnt
11211  0062               _umax_cnt:
11212  0062 0000          	ds.b	2
11213                     	xdef	_umax_cnt
11214                     	switch	.eeprom
11215  0018               _ee_K:
11216  0018 000000000000  	ds.b	16
11217                     	xdef	_ee_K
11218                     	switch	.ubsct
11219  0064               _T:
11220  0064 00            	ds.b	1
11221                     	xdef	_T
11222  0065               _Udb:
11223  0065 0000          	ds.b	2
11224                     	xdef	_Udb
11225  0067               _Ui:
11226  0067 0000          	ds.b	2
11227                     	xdef	_Ui
11228  0069               _Un:
11229  0069 0000          	ds.b	2
11230                     	xdef	_Un
11231  006b               _I:
11232  006b 0000          	ds.b	2
11233                     	xdef	_I
11234  006d               _can_error_cnt:
11235  006d 00            	ds.b	1
11236                     	xdef	_can_error_cnt
11237                     	xdef	_bCAN_RX
11238  006e               _tx_busy_cnt:
11239  006e 00            	ds.b	1
11240                     	xdef	_tx_busy_cnt
11241                     	xdef	_bTX_FREE
11242  006f               _can_buff_rd_ptr:
11243  006f 00            	ds.b	1
11244                     	xdef	_can_buff_rd_ptr
11245  0070               _can_buff_wr_ptr:
11246  0070 00            	ds.b	1
11247                     	xdef	_can_buff_wr_ptr
11248  0071               _can_out_buff:
11249  0071 000000000000  	ds.b	64
11250                     	xdef	_can_out_buff
11251                     	switch	.bss
11252  0000               _adress_error:
11253  0000 00            	ds.b	1
11254                     	xdef	_adress_error
11255  0001               _adress:
11256  0001 00            	ds.b	1
11257                     	xdef	_adress
11258  0002               _adr:
11259  0002 000000        	ds.b	3
11260                     	xdef	_adr
11261                     	xdef	_adr_drv_stat
11262                     	xdef	_led_ind
11263                     	switch	.ubsct
11264  00b1               _led_ind_cnt:
11265  00b1 00            	ds.b	1
11266                     	xdef	_led_ind_cnt
11267  00b2               _adc_plazma:
11268  00b2 000000000000  	ds.b	10
11269                     	xdef	_adc_plazma
11270  00bc               _adc_plazma_short:
11271  00bc 0000          	ds.b	2
11272                     	xdef	_adc_plazma_short
11273  00be               _adc_cnt:
11274  00be 00            	ds.b	1
11275                     	xdef	_adc_cnt
11276  00bf               _adc_ch:
11277  00bf 00            	ds.b	1
11278                     	xdef	_adc_ch
11279                     	switch	.bss
11280  0005               _adc_buff_:
11281  0005 000000000000  	ds.b	20
11282                     	xdef	_adc_buff_
11283  0019               _adc_buff:
11284  0019 000000000000  	ds.b	320
11285                     	xdef	_adc_buff
11286                     	switch	.ubsct
11287  00c0               _mess:
11288  00c0 000000000000  	ds.b	14
11289                     	xdef	_mess
11290                     	switch	.bit
11291  0004               _b1Hz:
11292  0004 00            	ds.b	1
11293                     	xdef	_b1Hz
11294  0005               _b2Hz:
11295  0005 00            	ds.b	1
11296                     	xdef	_b2Hz
11297  0006               _b5Hz:
11298  0006 00            	ds.b	1
11299                     	xdef	_b5Hz
11300  0007               _b10Hz:
11301  0007 00            	ds.b	1
11302                     	xdef	_b10Hz
11303  0008               _b100Hz:
11304  0008 00            	ds.b	1
11305                     	xdef	_b100Hz
11306                     	xdef	_t0_cnt4
11307                     	xdef	_t0_cnt3
11308                     	xdef	_t0_cnt2
11309                     	xdef	_t0_cnt1
11310                     	xdef	_t0_cnt0
11311                     	xref.b	c_lreg
11312                     	xref.b	c_x
11313                     	xref.b	c_y
11333                     	xref	c_lrsh
11334                     	xref	c_lgadd
11335                     	xref	c_ladd
11336                     	xref	c_umul
11337                     	xref	c_lgmul
11338                     	xref	c_lgsub
11339                     	xref	c_lsbc
11340                     	xref	c_idiv
11341                     	xref	c_ldiv
11342                     	xref	c_itolx
11343                     	xref	c_eewrc
11344                     	xref	c_imul
11345                     	xref	c_lcmp
11346                     	xref	c_ltor
11347                     	xref	c_lgadc
11348                     	xref	c_rtol
11349                     	xref	c_vmul
11350                     	xref	c_eewrw
11351                     	end
