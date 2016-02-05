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
2273                     ; 165 void gran(signed short *adr, signed short min, signed short max)
2273                     ; 166 {
2275                     	switch	.text
2276  0000               _gran:
2278  0000 89            	pushw	x
2279       00000000      OFST:	set	0
2282                     ; 167 if (*adr<min) *adr=min;
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
2296                     ; 168 if (*adr>max) *adr=max; 
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
2312                     ; 169 } 
2315  001f 85            	popw	x
2316  0020 81            	ret
2369                     ; 172 void granee(@eeprom signed short *adr, signed short min, signed short max)
2369                     ; 173 {
2370                     	switch	.text
2371  0021               _granee:
2373  0021 89            	pushw	x
2374       00000000      OFST:	set	0
2377                     ; 174 if (*adr<min) *adr=min;
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
2395                     ; 175 if (*adr>max) *adr=max; 
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
2414                     ; 176 }
2417  004a 85            	popw	x
2418  004b 81            	ret
2479                     ; 179 long delay_ms(short in)
2479                     ; 180 {
2480                     	switch	.text
2481  004c               _delay_ms:
2483  004c 520c          	subw	sp,#12
2484       0000000c      OFST:	set	12
2487                     ; 183 i=((long)in)*100UL;
2489  004e 90ae0064      	ldw	y,#100
2490  0052 cd0000        	call	c_vmul
2492  0055 96            	ldw	x,sp
2493  0056 1c0005        	addw	x,#OFST-7
2494  0059 cd0000        	call	c_rtol
2496                     ; 185 for(ii=0;ii<i;ii++)
2498  005c ae0000        	ldw	x,#0
2499  005f 1f0b          	ldw	(OFST-1,sp),x
2500  0061 ae0000        	ldw	x,#0
2501  0064 1f09          	ldw	(OFST-3,sp),x
2503  0066 2012          	jra	L3551
2504  0068               L7451:
2505                     ; 187 		iii++;
2507  0068 96            	ldw	x,sp
2508  0069 1c0001        	addw	x,#OFST-11
2509  006c a601          	ld	a,#1
2510  006e cd0000        	call	c_lgadc
2512                     ; 185 for(ii=0;ii<i;ii++)
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
2532                     ; 190 }
2535  008b 5b0c          	addw	sp,#12
2536  008d 81            	ret
2572                     ; 193 void led_hndl(void)
2572                     ; 194 {
2573                     	switch	.text
2574  008e               _led_hndl:
2578                     ; 195 if(adress_error)
2580  008e 725d0000      	tnz	_adress_error
2581  0092 2718          	jreq	L7651
2582                     ; 197 	led_red=0x55555555L;
2584  0094 ae5555        	ldw	x,#21845
2585  0097 bf13          	ldw	_led_red+2,x
2586  0099 ae5555        	ldw	x,#21845
2587  009c bf11          	ldw	_led_red,x
2588                     ; 198 	led_green=0x55555555L;
2590  009e ae5555        	ldw	x,#21845
2591  00a1 bf17          	ldw	_led_green+2,x
2592  00a3 ae5555        	ldw	x,#21845
2593  00a6 bf15          	ldw	_led_green,x
2595  00a8 ac100710      	jpf	L1751
2596  00ac               L7651:
2597                     ; 214 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2599  00ac 3d01          	tnz	_bps_class
2600  00ae 2703          	jreq	L41
2601  00b0 cc0363        	jp	L3751
2602  00b3               L41:
2603                     ; 216 	if(jp_mode!=jp3)
2605  00b3 b647          	ld	a,_jp_mode
2606  00b5 a103          	cp	a,#3
2607  00b7 2603          	jrne	L61
2608  00b9 cc025f        	jp	L5751
2609  00bc               L61:
2610                     ; 218 		if(main_cnt1<(5*ee_TZAS))
2612  00bc 9c            	rvf
2613  00bd ce0014        	ldw	x,_ee_TZAS
2614  00c0 90ae0005      	ldw	y,#5
2615  00c4 cd0000        	call	c_imul
2617  00c7 b34c          	cpw	x,_main_cnt1
2618  00c9 2d18          	jrsle	L7751
2619                     ; 220 			led_red=0x00000000L;
2621  00cb ae0000        	ldw	x,#0
2622  00ce bf13          	ldw	_led_red+2,x
2623  00d0 ae0000        	ldw	x,#0
2624  00d3 bf11          	ldw	_led_red,x
2625                     ; 221 			led_green=0x03030303L;
2627  00d5 ae0303        	ldw	x,#771
2628  00d8 bf17          	ldw	_led_green+2,x
2629  00da ae0303        	ldw	x,#771
2630  00dd bf15          	ldw	_led_green,x
2632  00df ac200220      	jpf	L1061
2633  00e3               L7751:
2634                     ; 224 		else if((link==ON)&&(flags_tu&0b10000000))
2636  00e3 b65f          	ld	a,_link
2637  00e5 a155          	cp	a,#85
2638  00e7 261e          	jrne	L3061
2640  00e9 b65d          	ld	a,_flags_tu
2641  00eb a580          	bcp	a,#128
2642  00ed 2718          	jreq	L3061
2643                     ; 226 			led_red=0x00055555L;
2645  00ef ae5555        	ldw	x,#21845
2646  00f2 bf13          	ldw	_led_red+2,x
2647  00f4 ae0005        	ldw	x,#5
2648  00f7 bf11          	ldw	_led_red,x
2649                     ; 227 			led_green=0xffffffffL;
2651  00f9 aeffff        	ldw	x,#65535
2652  00fc bf17          	ldw	_led_green+2,x
2653  00fe aeffff        	ldw	x,#-1
2654  0101 bf15          	ldw	_led_green,x
2656  0103 ac200220      	jpf	L1061
2657  0107               L3061:
2658                     ; 230 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
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
2683                     ; 232 			led_red=0x00000000L;
2685  0135 ae0000        	ldw	x,#0
2686  0138 bf13          	ldw	_led_red+2,x
2687  013a ae0000        	ldw	x,#0
2688  013d bf11          	ldw	_led_red,x
2689                     ; 233 			led_green=0xffffffffL;	
2691  013f aeffff        	ldw	x,#65535
2692  0142 bf17          	ldw	_led_green+2,x
2693  0144 aeffff        	ldw	x,#-1
2694  0147 bf15          	ldw	_led_green,x
2696  0149 ac200220      	jpf	L1061
2697  014d               L7061:
2698                     ; 236 		else  if(link==OFF)
2700  014d b65f          	ld	a,_link
2701  014f a1aa          	cp	a,#170
2702  0151 2618          	jrne	L3161
2703                     ; 238 			led_red=0x55555555L;
2705  0153 ae5555        	ldw	x,#21845
2706  0156 bf13          	ldw	_led_red+2,x
2707  0158 ae5555        	ldw	x,#21845
2708  015b bf11          	ldw	_led_red,x
2709                     ; 239 			led_green=0xffffffffL;
2711  015d aeffff        	ldw	x,#65535
2712  0160 bf17          	ldw	_led_green+2,x
2713  0162 aeffff        	ldw	x,#-1
2714  0165 bf15          	ldw	_led_green,x
2716  0167 ac200220      	jpf	L1061
2717  016b               L3161:
2718                     ; 242 		else if((link==ON)&&((flags&0b00111110)==0))
2720  016b b65f          	ld	a,_link
2721  016d a155          	cp	a,#85
2722  016f 261d          	jrne	L7161
2724  0171 b60a          	ld	a,_flags
2725  0173 a53e          	bcp	a,#62
2726  0175 2617          	jrne	L7161
2727                     ; 244 			led_red=0x00000000L;
2729  0177 ae0000        	ldw	x,#0
2730  017a bf13          	ldw	_led_red+2,x
2731  017c ae0000        	ldw	x,#0
2732  017f bf11          	ldw	_led_red,x
2733                     ; 245 			led_green=0xffffffffL;
2735  0181 aeffff        	ldw	x,#65535
2736  0184 bf17          	ldw	_led_green+2,x
2737  0186 aeffff        	ldw	x,#-1
2738  0189 bf15          	ldw	_led_green,x
2740  018b cc0220        	jra	L1061
2741  018e               L7161:
2742                     ; 248 		else if((flags&0b00111110)==0b00000100)
2744  018e b60a          	ld	a,_flags
2745  0190 a43e          	and	a,#62
2746  0192 a104          	cp	a,#4
2747  0194 2616          	jrne	L3261
2748                     ; 250 			led_red=0x00010001L;
2750  0196 ae0001        	ldw	x,#1
2751  0199 bf13          	ldw	_led_red+2,x
2752  019b ae0001        	ldw	x,#1
2753  019e bf11          	ldw	_led_red,x
2754                     ; 251 			led_green=0xffffffffL;	
2756  01a0 aeffff        	ldw	x,#65535
2757  01a3 bf17          	ldw	_led_green+2,x
2758  01a5 aeffff        	ldw	x,#-1
2759  01a8 bf15          	ldw	_led_green,x
2761  01aa 2074          	jra	L1061
2762  01ac               L3261:
2763                     ; 253 		else if(flags&0b00000010)
2765  01ac b60a          	ld	a,_flags
2766  01ae a502          	bcp	a,#2
2767  01b0 2716          	jreq	L7261
2768                     ; 255 			led_red=0x00010001L;
2770  01b2 ae0001        	ldw	x,#1
2771  01b5 bf13          	ldw	_led_red+2,x
2772  01b7 ae0001        	ldw	x,#1
2773  01ba bf11          	ldw	_led_red,x
2774                     ; 256 			led_green=0x00000000L;	
2776  01bc ae0000        	ldw	x,#0
2777  01bf bf17          	ldw	_led_green+2,x
2778  01c1 ae0000        	ldw	x,#0
2779  01c4 bf15          	ldw	_led_green,x
2781  01c6 2058          	jra	L1061
2782  01c8               L7261:
2783                     ; 258 		else if(flags&0b00001000)
2785  01c8 b60a          	ld	a,_flags
2786  01ca a508          	bcp	a,#8
2787  01cc 2716          	jreq	L3361
2788                     ; 260 			led_red=0x00090009L;
2790  01ce ae0009        	ldw	x,#9
2791  01d1 bf13          	ldw	_led_red+2,x
2792  01d3 ae0009        	ldw	x,#9
2793  01d6 bf11          	ldw	_led_red,x
2794                     ; 261 			led_green=0x00000000L;	
2796  01d8 ae0000        	ldw	x,#0
2797  01db bf17          	ldw	_led_green+2,x
2798  01dd ae0000        	ldw	x,#0
2799  01e0 bf15          	ldw	_led_green,x
2801  01e2 203c          	jra	L1061
2802  01e4               L3361:
2803                     ; 263 		else if(flags&0b00010000)
2805  01e4 b60a          	ld	a,_flags
2806  01e6 a510          	bcp	a,#16
2807  01e8 2716          	jreq	L7361
2808                     ; 265 			led_red=0x00490049L;
2810  01ea ae0049        	ldw	x,#73
2811  01ed bf13          	ldw	_led_red+2,x
2812  01ef ae0049        	ldw	x,#73
2813  01f2 bf11          	ldw	_led_red,x
2814                     ; 266 			led_green=0x00000000L;	
2816  01f4 ae0000        	ldw	x,#0
2817  01f7 bf17          	ldw	_led_green+2,x
2818  01f9 ae0000        	ldw	x,#0
2819  01fc bf15          	ldw	_led_green,x
2821  01fe 2020          	jra	L1061
2822  0200               L7361:
2823                     ; 269 		else if((link==ON)&&(flags&0b00100000))
2825  0200 b65f          	ld	a,_link
2826  0202 a155          	cp	a,#85
2827  0204 261a          	jrne	L1061
2829  0206 b60a          	ld	a,_flags
2830  0208 a520          	bcp	a,#32
2831  020a 2714          	jreq	L1061
2832                     ; 271 			led_red=0x00000000L;
2834  020c ae0000        	ldw	x,#0
2835  020f bf13          	ldw	_led_red+2,x
2836  0211 ae0000        	ldw	x,#0
2837  0214 bf11          	ldw	_led_red,x
2838                     ; 272 			led_green=0x00030003L;
2840  0216 ae0003        	ldw	x,#3
2841  0219 bf17          	ldw	_led_green+2,x
2842  021b ae0003        	ldw	x,#3
2843  021e bf15          	ldw	_led_green,x
2844  0220               L1061:
2845                     ; 275 		if((jp_mode==jp1))
2847  0220 b647          	ld	a,_jp_mode
2848  0222 a101          	cp	a,#1
2849  0224 2618          	jrne	L5461
2850                     ; 277 			led_red=0x00000000L;
2852  0226 ae0000        	ldw	x,#0
2853  0229 bf13          	ldw	_led_red+2,x
2854  022b ae0000        	ldw	x,#0
2855  022e bf11          	ldw	_led_red,x
2856                     ; 278 			led_green=0x33333333L;
2858  0230 ae3333        	ldw	x,#13107
2859  0233 bf17          	ldw	_led_green+2,x
2860  0235 ae3333        	ldw	x,#13107
2861  0238 bf15          	ldw	_led_green,x
2863  023a ac100710      	jpf	L1751
2864  023e               L5461:
2865                     ; 280 		else if((jp_mode==jp2))
2867  023e b647          	ld	a,_jp_mode
2868  0240 a102          	cp	a,#2
2869  0242 2703          	jreq	L02
2870  0244 cc0710        	jp	L1751
2871  0247               L02:
2872                     ; 282 			led_red=0xccccccccL;
2874  0247 aecccc        	ldw	x,#52428
2875  024a bf13          	ldw	_led_red+2,x
2876  024c aecccc        	ldw	x,#-13108
2877  024f bf11          	ldw	_led_red,x
2878                     ; 283 			led_green=0x00000000L;
2880  0251 ae0000        	ldw	x,#0
2881  0254 bf17          	ldw	_led_green+2,x
2882  0256 ae0000        	ldw	x,#0
2883  0259 bf15          	ldw	_led_green,x
2884  025b ac100710      	jpf	L1751
2885  025f               L5751:
2886                     ; 286 	else if(jp_mode==jp3)
2888  025f b647          	ld	a,_jp_mode
2889  0261 a103          	cp	a,#3
2890  0263 2703          	jreq	L22
2891  0265 cc0710        	jp	L1751
2892  0268               L22:
2893                     ; 288 		if(main_cnt1<(5*ee_TZAS))
2895  0268 9c            	rvf
2896  0269 ce0014        	ldw	x,_ee_TZAS
2897  026c 90ae0005      	ldw	y,#5
2898  0270 cd0000        	call	c_imul
2900  0273 b34c          	cpw	x,_main_cnt1
2901  0275 2d18          	jrsle	L7561
2902                     ; 290 			led_red=0x00000000L;
2904  0277 ae0000        	ldw	x,#0
2905  027a bf13          	ldw	_led_red+2,x
2906  027c ae0000        	ldw	x,#0
2907  027f bf11          	ldw	_led_red,x
2908                     ; 291 			led_green=0x03030303L;
2910  0281 ae0303        	ldw	x,#771
2911  0284 bf17          	ldw	_led_green+2,x
2912  0286 ae0303        	ldw	x,#771
2913  0289 bf15          	ldw	_led_green,x
2915  028b ac100710      	jpf	L1751
2916  028f               L7561:
2917                     ; 293 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
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
2935                     ; 295 			led_red=0x00000000L;
2937  02b0 ae0000        	ldw	x,#0
2938  02b3 bf13          	ldw	_led_red+2,x
2939  02b5 ae0000        	ldw	x,#0
2940  02b8 bf11          	ldw	_led_red,x
2941                     ; 296 			led_green=0xffffffffL;	
2943  02ba aeffff        	ldw	x,#65535
2944  02bd bf17          	ldw	_led_green+2,x
2945  02bf aeffff        	ldw	x,#-1
2946  02c2 bf15          	ldw	_led_green,x
2948  02c4 ac100710      	jpf	L1751
2949  02c8               L3661:
2950                     ; 299 		else if((flags&0b00011110)==0)
2952  02c8 b60a          	ld	a,_flags
2953  02ca a51e          	bcp	a,#30
2954  02cc 2618          	jrne	L7661
2955                     ; 301 			led_red=0x00000000L;
2957  02ce ae0000        	ldw	x,#0
2958  02d1 bf13          	ldw	_led_red+2,x
2959  02d3 ae0000        	ldw	x,#0
2960  02d6 bf11          	ldw	_led_red,x
2961                     ; 302 			led_green=0xffffffffL;
2963  02d8 aeffff        	ldw	x,#65535
2964  02db bf17          	ldw	_led_green+2,x
2965  02dd aeffff        	ldw	x,#-1
2966  02e0 bf15          	ldw	_led_green,x
2968  02e2 ac100710      	jpf	L1751
2969  02e6               L7661:
2970                     ; 306 		else if((flags&0b00111110)==0b00000100)
2972  02e6 b60a          	ld	a,_flags
2973  02e8 a43e          	and	a,#62
2974  02ea a104          	cp	a,#4
2975  02ec 2618          	jrne	L3761
2976                     ; 308 			led_red=0x00010001L;
2978  02ee ae0001        	ldw	x,#1
2979  02f1 bf13          	ldw	_led_red+2,x
2980  02f3 ae0001        	ldw	x,#1
2981  02f6 bf11          	ldw	_led_red,x
2982                     ; 309 			led_green=0xffffffffL;	
2984  02f8 aeffff        	ldw	x,#65535
2985  02fb bf17          	ldw	_led_green+2,x
2986  02fd aeffff        	ldw	x,#-1
2987  0300 bf15          	ldw	_led_green,x
2989  0302 ac100710      	jpf	L1751
2990  0306               L3761:
2991                     ; 311 		else if(flags&0b00000010)
2993  0306 b60a          	ld	a,_flags
2994  0308 a502          	bcp	a,#2
2995  030a 2718          	jreq	L7761
2996                     ; 313 			led_red=0x00010001L;
2998  030c ae0001        	ldw	x,#1
2999  030f bf13          	ldw	_led_red+2,x
3000  0311 ae0001        	ldw	x,#1
3001  0314 bf11          	ldw	_led_red,x
3002                     ; 314 			led_green=0x00000000L;	
3004  0316 ae0000        	ldw	x,#0
3005  0319 bf17          	ldw	_led_green+2,x
3006  031b ae0000        	ldw	x,#0
3007  031e bf15          	ldw	_led_green,x
3009  0320 ac100710      	jpf	L1751
3010  0324               L7761:
3011                     ; 316 		else if(flags&0b00001000)
3013  0324 b60a          	ld	a,_flags
3014  0326 a508          	bcp	a,#8
3015  0328 2718          	jreq	L3071
3016                     ; 318 			led_red=0x00090009L;
3018  032a ae0009        	ldw	x,#9
3019  032d bf13          	ldw	_led_red+2,x
3020  032f ae0009        	ldw	x,#9
3021  0332 bf11          	ldw	_led_red,x
3022                     ; 319 			led_green=0x00000000L;	
3024  0334 ae0000        	ldw	x,#0
3025  0337 bf17          	ldw	_led_green+2,x
3026  0339 ae0000        	ldw	x,#0
3027  033c bf15          	ldw	_led_green,x
3029  033e ac100710      	jpf	L1751
3030  0342               L3071:
3031                     ; 321 		else if(flags&0b00010000)
3033  0342 b60a          	ld	a,_flags
3034  0344 a510          	bcp	a,#16
3035  0346 2603          	jrne	L42
3036  0348 cc0710        	jp	L1751
3037  034b               L42:
3038                     ; 323 			led_red=0x00490049L;
3040  034b ae0049        	ldw	x,#73
3041  034e bf13          	ldw	_led_red+2,x
3042  0350 ae0049        	ldw	x,#73
3043  0353 bf11          	ldw	_led_red,x
3044                     ; 324 			led_green=0xffffffffL;	
3046  0355 aeffff        	ldw	x,#65535
3047  0358 bf17          	ldw	_led_green+2,x
3048  035a aeffff        	ldw	x,#-1
3049  035d bf15          	ldw	_led_green,x
3050  035f ac100710      	jpf	L1751
3051  0363               L3751:
3052                     ; 328 else if(bps_class==bpsIPS)	//если блок ИПСный
3054  0363 b601          	ld	a,_bps_class
3055  0365 a101          	cp	a,#1
3056  0367 2703          	jreq	L62
3057  0369 cc0710        	jp	L1751
3058  036c               L62:
3059                     ; 330 	if(jp_mode!=jp3)
3061  036c b647          	ld	a,_jp_mode
3062  036e a103          	cp	a,#3
3063  0370 2603          	jrne	L03
3064  0372 cc061c        	jp	L5171
3065  0375               L03:
3066                     ; 332 		if(main_cnt1<(5*ee_TZAS))
3068  0375 9c            	rvf
3069  0376 ce0014        	ldw	x,_ee_TZAS
3070  0379 90ae0005      	ldw	y,#5
3071  037d cd0000        	call	c_imul
3073  0380 b34c          	cpw	x,_main_cnt1
3074  0382 2d18          	jrsle	L7171
3075                     ; 334 			led_red=0x00000000L;
3077  0384 ae0000        	ldw	x,#0
3078  0387 bf13          	ldw	_led_red+2,x
3079  0389 ae0000        	ldw	x,#0
3080  038c bf11          	ldw	_led_red,x
3081                     ; 335 			led_green=0x03030303L;
3083  038e ae0303        	ldw	x,#771
3084  0391 bf17          	ldw	_led_green+2,x
3085  0393 ae0303        	ldw	x,#771
3086  0396 bf15          	ldw	_led_green,x
3088  0398 acdd05dd      	jpf	L1271
3089  039c               L7171:
3090                     ; 338 		else if((link==ON)&&(flags_tu&0b10000000))
3092  039c b65f          	ld	a,_link
3093  039e a155          	cp	a,#85
3094  03a0 261e          	jrne	L3271
3096  03a2 b65d          	ld	a,_flags_tu
3097  03a4 a580          	bcp	a,#128
3098  03a6 2718          	jreq	L3271
3099                     ; 340 			led_red=0x00055555L;
3101  03a8 ae5555        	ldw	x,#21845
3102  03ab bf13          	ldw	_led_red+2,x
3103  03ad ae0005        	ldw	x,#5
3104  03b0 bf11          	ldw	_led_red,x
3105                     ; 341 			led_green=0xffffffffL;
3107  03b2 aeffff        	ldw	x,#65535
3108  03b5 bf17          	ldw	_led_green+2,x
3109  03b7 aeffff        	ldw	x,#-1
3110  03ba bf15          	ldw	_led_green,x
3112  03bc acdd05dd      	jpf	L1271
3113  03c0               L3271:
3114                     ; 344 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
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
3139                     ; 346 			led_red=0x00000000L;
3141  03ee ae0000        	ldw	x,#0
3142  03f1 bf13          	ldw	_led_red+2,x
3143  03f3 ae0000        	ldw	x,#0
3144  03f6 bf11          	ldw	_led_red,x
3145                     ; 347 			led_green=0xffffffffL;	
3147  03f8 aeffff        	ldw	x,#65535
3148  03fb bf17          	ldw	_led_green+2,x
3149  03fd aeffff        	ldw	x,#-1
3150  0400 bf15          	ldw	_led_green,x
3152  0402 acdd05dd      	jpf	L1271
3153  0406               L7271:
3154                     ; 350 		else  if(link==OFF)
3156  0406 b65f          	ld	a,_link
3157  0408 a1aa          	cp	a,#170
3158  040a 2703          	jreq	L23
3159  040c cc0528        	jp	L3371
3160  040f               L23:
3161                     ; 352 			if((flags&0b00011110)==0)
3163  040f b60a          	ld	a,_flags
3164  0411 a51e          	bcp	a,#30
3165  0413 262d          	jrne	L5371
3166                     ; 354 				led_red=0x00000000L;
3168  0415 ae0000        	ldw	x,#0
3169  0418 bf13          	ldw	_led_red+2,x
3170  041a ae0000        	ldw	x,#0
3171  041d bf11          	ldw	_led_red,x
3172                     ; 355 				if(bMAIN)led_green=0xfffffff5L;
3174                     	btst	_bMAIN
3175  0424 240e          	jruge	L7371
3178  0426 aefff5        	ldw	x,#65525
3179  0429 bf17          	ldw	_led_green+2,x
3180  042b aeffff        	ldw	x,#-1
3181  042e bf15          	ldw	_led_green,x
3183  0430 acdd05dd      	jpf	L1271
3184  0434               L7371:
3185                     ; 356 				else led_green=0xffffffffL;
3187  0434 aeffff        	ldw	x,#65535
3188  0437 bf17          	ldw	_led_green+2,x
3189  0439 aeffff        	ldw	x,#-1
3190  043c bf15          	ldw	_led_green,x
3191  043e acdd05dd      	jpf	L1271
3192  0442               L5371:
3193                     ; 359 			else if((flags&0b00111110)==0b00000100)
3195  0442 b60a          	ld	a,_flags
3196  0444 a43e          	and	a,#62
3197  0446 a104          	cp	a,#4
3198  0448 262d          	jrne	L5471
3199                     ; 361 				led_red=0x00010001L;
3201  044a ae0001        	ldw	x,#1
3202  044d bf13          	ldw	_led_red+2,x
3203  044f ae0001        	ldw	x,#1
3204  0452 bf11          	ldw	_led_red,x
3205                     ; 362 				if(bMAIN)led_green=0xfffffff5L;
3207                     	btst	_bMAIN
3208  0459 240e          	jruge	L7471
3211  045b aefff5        	ldw	x,#65525
3212  045e bf17          	ldw	_led_green+2,x
3213  0460 aeffff        	ldw	x,#-1
3214  0463 bf15          	ldw	_led_green,x
3216  0465 acdd05dd      	jpf	L1271
3217  0469               L7471:
3218                     ; 363 				else led_green=0xffffffffL;	
3220  0469 aeffff        	ldw	x,#65535
3221  046c bf17          	ldw	_led_green+2,x
3222  046e aeffff        	ldw	x,#-1
3223  0471 bf15          	ldw	_led_green,x
3224  0473 acdd05dd      	jpf	L1271
3225  0477               L5471:
3226                     ; 365 			else if(flags&0b00000010)
3228  0477 b60a          	ld	a,_flags
3229  0479 a502          	bcp	a,#2
3230  047b 272d          	jreq	L5571
3231                     ; 367 				led_red=0x00010001L;
3233  047d ae0001        	ldw	x,#1
3234  0480 bf13          	ldw	_led_red+2,x
3235  0482 ae0001        	ldw	x,#1
3236  0485 bf11          	ldw	_led_red,x
3237                     ; 368 				if(bMAIN)led_green=0x00000005L;
3239                     	btst	_bMAIN
3240  048c 240e          	jruge	L7571
3243  048e ae0005        	ldw	x,#5
3244  0491 bf17          	ldw	_led_green+2,x
3245  0493 ae0000        	ldw	x,#0
3246  0496 bf15          	ldw	_led_green,x
3248  0498 acdd05dd      	jpf	L1271
3249  049c               L7571:
3250                     ; 369 				else led_green=0x00000000L;
3252  049c ae0000        	ldw	x,#0
3253  049f bf17          	ldw	_led_green+2,x
3254  04a1 ae0000        	ldw	x,#0
3255  04a4 bf15          	ldw	_led_green,x
3256  04a6 acdd05dd      	jpf	L1271
3257  04aa               L5571:
3258                     ; 371 			else if(flags&0b00001000)
3260  04aa b60a          	ld	a,_flags
3261  04ac a508          	bcp	a,#8
3262  04ae 272d          	jreq	L5671
3263                     ; 373 				led_red=0x00090009L;
3265  04b0 ae0009        	ldw	x,#9
3266  04b3 bf13          	ldw	_led_red+2,x
3267  04b5 ae0009        	ldw	x,#9
3268  04b8 bf11          	ldw	_led_red,x
3269                     ; 374 				if(bMAIN)led_green=0x00000005L;
3271                     	btst	_bMAIN
3272  04bf 240e          	jruge	L7671
3275  04c1 ae0005        	ldw	x,#5
3276  04c4 bf17          	ldw	_led_green+2,x
3277  04c6 ae0000        	ldw	x,#0
3278  04c9 bf15          	ldw	_led_green,x
3280  04cb acdd05dd      	jpf	L1271
3281  04cf               L7671:
3282                     ; 375 				else led_green=0x00000000L;	
3284  04cf ae0000        	ldw	x,#0
3285  04d2 bf17          	ldw	_led_green+2,x
3286  04d4 ae0000        	ldw	x,#0
3287  04d7 bf15          	ldw	_led_green,x
3288  04d9 acdd05dd      	jpf	L1271
3289  04dd               L5671:
3290                     ; 377 			else if(flags&0b00010000)
3292  04dd b60a          	ld	a,_flags
3293  04df a510          	bcp	a,#16
3294  04e1 272d          	jreq	L5771
3295                     ; 379 				led_red=0x00490049L;
3297  04e3 ae0049        	ldw	x,#73
3298  04e6 bf13          	ldw	_led_red+2,x
3299  04e8 ae0049        	ldw	x,#73
3300  04eb bf11          	ldw	_led_red,x
3301                     ; 380 				if(bMAIN)led_green=0x00000005L;
3303                     	btst	_bMAIN
3304  04f2 240e          	jruge	L7771
3307  04f4 ae0005        	ldw	x,#5
3308  04f7 bf17          	ldw	_led_green+2,x
3309  04f9 ae0000        	ldw	x,#0
3310  04fc bf15          	ldw	_led_green,x
3312  04fe acdd05dd      	jpf	L1271
3313  0502               L7771:
3314                     ; 381 				else led_green=0x00000000L;	
3316  0502 ae0000        	ldw	x,#0
3317  0505 bf17          	ldw	_led_green+2,x
3318  0507 ae0000        	ldw	x,#0
3319  050a bf15          	ldw	_led_green,x
3320  050c acdd05dd      	jpf	L1271
3321  0510               L5771:
3322                     ; 385 				led_red=0x55555555L;
3324  0510 ae5555        	ldw	x,#21845
3325  0513 bf13          	ldw	_led_red+2,x
3326  0515 ae5555        	ldw	x,#21845
3327  0518 bf11          	ldw	_led_red,x
3328                     ; 386 				led_green=0xffffffffL;
3330  051a aeffff        	ldw	x,#65535
3331  051d bf17          	ldw	_led_green+2,x
3332  051f aeffff        	ldw	x,#-1
3333  0522 bf15          	ldw	_led_green,x
3334  0524 acdd05dd      	jpf	L1271
3335  0528               L3371:
3336                     ; 402 		else if((link==ON)&&((flags&0b00111110)==0))
3338  0528 b65f          	ld	a,_link
3339  052a a155          	cp	a,#85
3340  052c 261d          	jrne	L7002
3342  052e b60a          	ld	a,_flags
3343  0530 a53e          	bcp	a,#62
3344  0532 2617          	jrne	L7002
3345                     ; 404 			led_red=0x00000000L;
3347  0534 ae0000        	ldw	x,#0
3348  0537 bf13          	ldw	_led_red+2,x
3349  0539 ae0000        	ldw	x,#0
3350  053c bf11          	ldw	_led_red,x
3351                     ; 405 			led_green=0xffffffffL;
3353  053e aeffff        	ldw	x,#65535
3354  0541 bf17          	ldw	_led_green+2,x
3355  0543 aeffff        	ldw	x,#-1
3356  0546 bf15          	ldw	_led_green,x
3358  0548 cc05dd        	jra	L1271
3359  054b               L7002:
3360                     ; 408 		else if((flags&0b00111110)==0b00000100)
3362  054b b60a          	ld	a,_flags
3363  054d a43e          	and	a,#62
3364  054f a104          	cp	a,#4
3365  0551 2616          	jrne	L3102
3366                     ; 410 			led_red=0x00010001L;
3368  0553 ae0001        	ldw	x,#1
3369  0556 bf13          	ldw	_led_red+2,x
3370  0558 ae0001        	ldw	x,#1
3371  055b bf11          	ldw	_led_red,x
3372                     ; 411 			led_green=0xffffffffL;	
3374  055d aeffff        	ldw	x,#65535
3375  0560 bf17          	ldw	_led_green+2,x
3376  0562 aeffff        	ldw	x,#-1
3377  0565 bf15          	ldw	_led_green,x
3379  0567 2074          	jra	L1271
3380  0569               L3102:
3381                     ; 413 		else if(flags&0b00000010)
3383  0569 b60a          	ld	a,_flags
3384  056b a502          	bcp	a,#2
3385  056d 2716          	jreq	L7102
3386                     ; 415 			led_red=0x00010001L;
3388  056f ae0001        	ldw	x,#1
3389  0572 bf13          	ldw	_led_red+2,x
3390  0574 ae0001        	ldw	x,#1
3391  0577 bf11          	ldw	_led_red,x
3392                     ; 416 			led_green=0x00000000L;	
3394  0579 ae0000        	ldw	x,#0
3395  057c bf17          	ldw	_led_green+2,x
3396  057e ae0000        	ldw	x,#0
3397  0581 bf15          	ldw	_led_green,x
3399  0583 2058          	jra	L1271
3400  0585               L7102:
3401                     ; 418 		else if(flags&0b00001000)
3403  0585 b60a          	ld	a,_flags
3404  0587 a508          	bcp	a,#8
3405  0589 2716          	jreq	L3202
3406                     ; 420 			led_red=0x00090009L;
3408  058b ae0009        	ldw	x,#9
3409  058e bf13          	ldw	_led_red+2,x
3410  0590 ae0009        	ldw	x,#9
3411  0593 bf11          	ldw	_led_red,x
3412                     ; 421 			led_green=0x00000000L;	
3414  0595 ae0000        	ldw	x,#0
3415  0598 bf17          	ldw	_led_green+2,x
3416  059a ae0000        	ldw	x,#0
3417  059d bf15          	ldw	_led_green,x
3419  059f 203c          	jra	L1271
3420  05a1               L3202:
3421                     ; 423 		else if(flags&0b00010000)
3423  05a1 b60a          	ld	a,_flags
3424  05a3 a510          	bcp	a,#16
3425  05a5 2716          	jreq	L7202
3426                     ; 425 			led_red=0x00490049L;
3428  05a7 ae0049        	ldw	x,#73
3429  05aa bf13          	ldw	_led_red+2,x
3430  05ac ae0049        	ldw	x,#73
3431  05af bf11          	ldw	_led_red,x
3432                     ; 426 			led_green=0x00000000L;	
3434  05b1 ae0000        	ldw	x,#0
3435  05b4 bf17          	ldw	_led_green+2,x
3436  05b6 ae0000        	ldw	x,#0
3437  05b9 bf15          	ldw	_led_green,x
3439  05bb 2020          	jra	L1271
3440  05bd               L7202:
3441                     ; 429 		else if((link==ON)&&(flags&0b00100000))
3443  05bd b65f          	ld	a,_link
3444  05bf a155          	cp	a,#85
3445  05c1 261a          	jrne	L1271
3447  05c3 b60a          	ld	a,_flags
3448  05c5 a520          	bcp	a,#32
3449  05c7 2714          	jreq	L1271
3450                     ; 431 			led_red=0x00000000L;
3452  05c9 ae0000        	ldw	x,#0
3453  05cc bf13          	ldw	_led_red+2,x
3454  05ce ae0000        	ldw	x,#0
3455  05d1 bf11          	ldw	_led_red,x
3456                     ; 432 			led_green=0x00030003L;
3458  05d3 ae0003        	ldw	x,#3
3459  05d6 bf17          	ldw	_led_green+2,x
3460  05d8 ae0003        	ldw	x,#3
3461  05db bf15          	ldw	_led_green,x
3462  05dd               L1271:
3463                     ; 435 		if((jp_mode==jp1))
3465  05dd b647          	ld	a,_jp_mode
3466  05df a101          	cp	a,#1
3467  05e1 2618          	jrne	L5302
3468                     ; 437 			led_red=0x00000000L;
3470  05e3 ae0000        	ldw	x,#0
3471  05e6 bf13          	ldw	_led_red+2,x
3472  05e8 ae0000        	ldw	x,#0
3473  05eb bf11          	ldw	_led_red,x
3474                     ; 438 			led_green=0x33333333L;
3476  05ed ae3333        	ldw	x,#13107
3477  05f0 bf17          	ldw	_led_green+2,x
3478  05f2 ae3333        	ldw	x,#13107
3479  05f5 bf15          	ldw	_led_green,x
3481  05f7 ac100710      	jpf	L1751
3482  05fb               L5302:
3483                     ; 440 		else if((jp_mode==jp2))
3485  05fb b647          	ld	a,_jp_mode
3486  05fd a102          	cp	a,#2
3487  05ff 2703          	jreq	L43
3488  0601 cc0710        	jp	L1751
3489  0604               L43:
3490                     ; 444 			led_red=0xccccccccL;
3492  0604 aecccc        	ldw	x,#52428
3493  0607 bf13          	ldw	_led_red+2,x
3494  0609 aecccc        	ldw	x,#-13108
3495  060c bf11          	ldw	_led_red,x
3496                     ; 445 			led_green=0x00000000L;
3498  060e ae0000        	ldw	x,#0
3499  0611 bf17          	ldw	_led_green+2,x
3500  0613 ae0000        	ldw	x,#0
3501  0616 bf15          	ldw	_led_green,x
3502  0618 ac100710      	jpf	L1751
3503  061c               L5171:
3504                     ; 448 	else if(jp_mode==jp3)
3506  061c b647          	ld	a,_jp_mode
3507  061e a103          	cp	a,#3
3508  0620 2703          	jreq	L63
3509  0622 cc0710        	jp	L1751
3510  0625               L63:
3511                     ; 450 		if(main_cnt1<(5*ee_TZAS))
3513  0625 9c            	rvf
3514  0626 ce0014        	ldw	x,_ee_TZAS
3515  0629 90ae0005      	ldw	y,#5
3516  062d cd0000        	call	c_imul
3518  0630 b34c          	cpw	x,_main_cnt1
3519  0632 2d18          	jrsle	L7402
3520                     ; 452 			led_red=0x00000000L;
3522  0634 ae0000        	ldw	x,#0
3523  0637 bf13          	ldw	_led_red+2,x
3524  0639 ae0000        	ldw	x,#0
3525  063c bf11          	ldw	_led_red,x
3526                     ; 453 			led_green=0x03030303L;
3528  063e ae0303        	ldw	x,#771
3529  0641 bf17          	ldw	_led_green+2,x
3530  0643 ae0303        	ldw	x,#771
3531  0646 bf15          	ldw	_led_green,x
3533  0648 ac100710      	jpf	L1751
3534  064c               L7402:
3535                     ; 455 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
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
3553                     ; 457 			led_red=0x00000000L;
3555  066d ae0000        	ldw	x,#0
3556  0670 bf13          	ldw	_led_red+2,x
3557  0672 ae0000        	ldw	x,#0
3558  0675 bf11          	ldw	_led_red,x
3559                     ; 458 			led_green=0xffffffffL;	
3561  0677 aeffff        	ldw	x,#65535
3562  067a bf17          	ldw	_led_green+2,x
3563  067c aeffff        	ldw	x,#-1
3564  067f bf15          	ldw	_led_green,x
3566  0681 cc0710        	jra	L1751
3567  0684               L3502:
3568                     ; 461 		else if((flags&0b00011110)==0)
3570  0684 b60a          	ld	a,_flags
3571  0686 a51e          	bcp	a,#30
3572  0688 2616          	jrne	L7502
3573                     ; 463 			led_red=0x00000000L;
3575  068a ae0000        	ldw	x,#0
3576  068d bf13          	ldw	_led_red+2,x
3577  068f ae0000        	ldw	x,#0
3578  0692 bf11          	ldw	_led_red,x
3579                     ; 464 			led_green=0xffffffffL;
3581  0694 aeffff        	ldw	x,#65535
3582  0697 bf17          	ldw	_led_green+2,x
3583  0699 aeffff        	ldw	x,#-1
3584  069c bf15          	ldw	_led_green,x
3586  069e 2070          	jra	L1751
3587  06a0               L7502:
3588                     ; 468 		else if((flags&0b00111110)==0b00000100)
3590  06a0 b60a          	ld	a,_flags
3591  06a2 a43e          	and	a,#62
3592  06a4 a104          	cp	a,#4
3593  06a6 2616          	jrne	L3602
3594                     ; 470 			led_red=0x00010001L;
3596  06a8 ae0001        	ldw	x,#1
3597  06ab bf13          	ldw	_led_red+2,x
3598  06ad ae0001        	ldw	x,#1
3599  06b0 bf11          	ldw	_led_red,x
3600                     ; 471 			led_green=0xffffffffL;	
3602  06b2 aeffff        	ldw	x,#65535
3603  06b5 bf17          	ldw	_led_green+2,x
3604  06b7 aeffff        	ldw	x,#-1
3605  06ba bf15          	ldw	_led_green,x
3607  06bc 2052          	jra	L1751
3608  06be               L3602:
3609                     ; 473 		else if(flags&0b00000010)
3611  06be b60a          	ld	a,_flags
3612  06c0 a502          	bcp	a,#2
3613  06c2 2716          	jreq	L7602
3614                     ; 475 			led_red=0x00010001L;
3616  06c4 ae0001        	ldw	x,#1
3617  06c7 bf13          	ldw	_led_red+2,x
3618  06c9 ae0001        	ldw	x,#1
3619  06cc bf11          	ldw	_led_red,x
3620                     ; 476 			led_green=0x00000000L;	
3622  06ce ae0000        	ldw	x,#0
3623  06d1 bf17          	ldw	_led_green+2,x
3624  06d3 ae0000        	ldw	x,#0
3625  06d6 bf15          	ldw	_led_green,x
3627  06d8 2036          	jra	L1751
3628  06da               L7602:
3629                     ; 478 		else if(flags&0b00001000)
3631  06da b60a          	ld	a,_flags
3632  06dc a508          	bcp	a,#8
3633  06de 2716          	jreq	L3702
3634                     ; 480 			led_red=0x00090009L;
3636  06e0 ae0009        	ldw	x,#9
3637  06e3 bf13          	ldw	_led_red+2,x
3638  06e5 ae0009        	ldw	x,#9
3639  06e8 bf11          	ldw	_led_red,x
3640                     ; 481 			led_green=0x00000000L;	
3642  06ea ae0000        	ldw	x,#0
3643  06ed bf17          	ldw	_led_green+2,x
3644  06ef ae0000        	ldw	x,#0
3645  06f2 bf15          	ldw	_led_green,x
3647  06f4 201a          	jra	L1751
3648  06f6               L3702:
3649                     ; 483 		else if(flags&0b00010000)
3651  06f6 b60a          	ld	a,_flags
3652  06f8 a510          	bcp	a,#16
3653  06fa 2714          	jreq	L1751
3654                     ; 485 			led_red=0x00490049L;
3656  06fc ae0049        	ldw	x,#73
3657  06ff bf13          	ldw	_led_red+2,x
3658  0701 ae0049        	ldw	x,#73
3659  0704 bf11          	ldw	_led_red,x
3660                     ; 486 			led_green=0xffffffffL;	
3662  0706 aeffff        	ldw	x,#65535
3663  0709 bf17          	ldw	_led_green+2,x
3664  070b aeffff        	ldw	x,#-1
3665  070e bf15          	ldw	_led_green,x
3666  0710               L1751:
3667                     ; 490 }
3670  0710 81            	ret
3698                     ; 493 void led_drv(void)
3698                     ; 494 {
3699                     	switch	.text
3700  0711               _led_drv:
3704                     ; 496 GPIOA->DDR|=(1<<6);
3706  0711 721c5002      	bset	20482,#6
3707                     ; 497 GPIOA->CR1|=(1<<6);
3709  0715 721c5003      	bset	20483,#6
3710                     ; 498 GPIOA->CR2&=~(1<<6);
3712  0719 721d5004      	bres	20484,#6
3713                     ; 499 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<6); 	//Горит если в led_red_buff 1 и на ножке 1
3715  071d b63d          	ld	a,_led_red_buff+3
3716  071f a501          	bcp	a,#1
3717  0721 2706          	jreq	L1112
3720  0723 721c5000      	bset	20480,#6
3722  0727 2004          	jra	L3112
3723  0729               L1112:
3724                     ; 500 else GPIOA->ODR&=~(1<<6); 
3726  0729 721d5000      	bres	20480,#6
3727  072d               L3112:
3728                     ; 503 GPIOA->DDR|=(1<<5);
3730  072d 721a5002      	bset	20482,#5
3731                     ; 504 GPIOA->CR1|=(1<<5);
3733  0731 721a5003      	bset	20483,#5
3734                     ; 505 GPIOA->CR2&=~(1<<5);	
3736  0735 721b5004      	bres	20484,#5
3737                     ; 506 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3739  0739 b639          	ld	a,_led_green_buff+3
3740  073b a501          	bcp	a,#1
3741  073d 2706          	jreq	L5112
3744  073f 721a5000      	bset	20480,#5
3746  0743 2004          	jra	L7112
3747  0745               L5112:
3748                     ; 507 else GPIOA->ODR&=~(1<<5);
3750  0745 721b5000      	bres	20480,#5
3751  0749               L7112:
3752                     ; 510 led_red_buff>>=1;
3754  0749 373a          	sra	_led_red_buff
3755  074b 363b          	rrc	_led_red_buff+1
3756  074d 363c          	rrc	_led_red_buff+2
3757  074f 363d          	rrc	_led_red_buff+3
3758                     ; 511 led_green_buff>>=1;
3760  0751 3736          	sra	_led_green_buff
3761  0753 3637          	rrc	_led_green_buff+1
3762  0755 3638          	rrc	_led_green_buff+2
3763  0757 3639          	rrc	_led_green_buff+3
3764                     ; 512 if(++led_drv_cnt>32)
3766  0759 3c19          	inc	_led_drv_cnt
3767  075b b619          	ld	a,_led_drv_cnt
3768  075d a121          	cp	a,#33
3769  075f 2512          	jrult	L1212
3770                     ; 514 	led_drv_cnt=0;
3772  0761 3f19          	clr	_led_drv_cnt
3773                     ; 515 	led_red_buff=led_red;
3775  0763 be13          	ldw	x,_led_red+2
3776  0765 bf3c          	ldw	_led_red_buff+2,x
3777  0767 be11          	ldw	x,_led_red
3778  0769 bf3a          	ldw	_led_red_buff,x
3779                     ; 516 	led_green_buff=led_green;
3781  076b be17          	ldw	x,_led_green+2
3782  076d bf38          	ldw	_led_green_buff+2,x
3783  076f be15          	ldw	x,_led_green
3784  0771 bf36          	ldw	_led_green_buff,x
3785  0773               L1212:
3786                     ; 522 } 
3789  0773 81            	ret
3815                     ; 525 void JP_drv(void)
3815                     ; 526 {
3816                     	switch	.text
3817  0774               _JP_drv:
3821                     ; 528 GPIOD->DDR&=~(1<<6);
3823  0774 721d5011      	bres	20497,#6
3824                     ; 529 GPIOD->CR1|=(1<<6);
3826  0778 721c5012      	bset	20498,#6
3827                     ; 530 GPIOD->CR2&=~(1<<6);
3829  077c 721d5013      	bres	20499,#6
3830                     ; 532 GPIOD->DDR&=~(1<<7);
3832  0780 721f5011      	bres	20497,#7
3833                     ; 533 GPIOD->CR1|=(1<<7);
3835  0784 721e5012      	bset	20498,#7
3836                     ; 534 GPIOD->CR2&=~(1<<7);
3838  0788 721f5013      	bres	20499,#7
3839                     ; 536 if(GPIOD->IDR&(1<<6))
3841  078c c65010        	ld	a,20496
3842  078f a540          	bcp	a,#64
3843  0791 270a          	jreq	L3312
3844                     ; 538 	if(cnt_JP0<10)
3846  0793 b646          	ld	a,_cnt_JP0
3847  0795 a10a          	cp	a,#10
3848  0797 2411          	jruge	L7312
3849                     ; 540 		cnt_JP0++;
3851  0799 3c46          	inc	_cnt_JP0
3852  079b 200d          	jra	L7312
3853  079d               L3312:
3854                     ; 543 else if(!(GPIOD->IDR&(1<<6)))
3856  079d c65010        	ld	a,20496
3857  07a0 a540          	bcp	a,#64
3858  07a2 2606          	jrne	L7312
3859                     ; 545 	if(cnt_JP0)
3861  07a4 3d46          	tnz	_cnt_JP0
3862  07a6 2702          	jreq	L7312
3863                     ; 547 		cnt_JP0--;
3865  07a8 3a46          	dec	_cnt_JP0
3866  07aa               L7312:
3867                     ; 551 if(GPIOD->IDR&(1<<7))
3869  07aa c65010        	ld	a,20496
3870  07ad a580          	bcp	a,#128
3871  07af 270a          	jreq	L5412
3872                     ; 553 	if(cnt_JP1<10)
3874  07b1 b645          	ld	a,_cnt_JP1
3875  07b3 a10a          	cp	a,#10
3876  07b5 2411          	jruge	L1512
3877                     ; 555 		cnt_JP1++;
3879  07b7 3c45          	inc	_cnt_JP1
3880  07b9 200d          	jra	L1512
3881  07bb               L5412:
3882                     ; 558 else if(!(GPIOD->IDR&(1<<7)))
3884  07bb c65010        	ld	a,20496
3885  07be a580          	bcp	a,#128
3886  07c0 2606          	jrne	L1512
3887                     ; 560 	if(cnt_JP1)
3889  07c2 3d45          	tnz	_cnt_JP1
3890  07c4 2702          	jreq	L1512
3891                     ; 562 		cnt_JP1--;
3893  07c6 3a45          	dec	_cnt_JP1
3894  07c8               L1512:
3895                     ; 567 if((cnt_JP0==10)&&(cnt_JP1==10))
3897  07c8 b646          	ld	a,_cnt_JP0
3898  07ca a10a          	cp	a,#10
3899  07cc 2608          	jrne	L7512
3901  07ce b645          	ld	a,_cnt_JP1
3902  07d0 a10a          	cp	a,#10
3903  07d2 2602          	jrne	L7512
3904                     ; 569 	jp_mode=jp0;
3906  07d4 3f47          	clr	_jp_mode
3907  07d6               L7512:
3908                     ; 571 if((cnt_JP0==0)&&(cnt_JP1==10))
3910  07d6 3d46          	tnz	_cnt_JP0
3911  07d8 260a          	jrne	L1612
3913  07da b645          	ld	a,_cnt_JP1
3914  07dc a10a          	cp	a,#10
3915  07de 2604          	jrne	L1612
3916                     ; 573 	jp_mode=jp1;
3918  07e0 35010047      	mov	_jp_mode,#1
3919  07e4               L1612:
3920                     ; 575 if((cnt_JP0==10)&&(cnt_JP1==0))
3922  07e4 b646          	ld	a,_cnt_JP0
3923  07e6 a10a          	cp	a,#10
3924  07e8 2608          	jrne	L3612
3926  07ea 3d45          	tnz	_cnt_JP1
3927  07ec 2604          	jrne	L3612
3928                     ; 577 	jp_mode=jp2;
3930  07ee 35020047      	mov	_jp_mode,#2
3931  07f2               L3612:
3932                     ; 579 if((cnt_JP0==0)&&(cnt_JP1==0))
3934  07f2 3d46          	tnz	_cnt_JP0
3935  07f4 2608          	jrne	L5612
3937  07f6 3d45          	tnz	_cnt_JP1
3938  07f8 2604          	jrne	L5612
3939                     ; 581 	jp_mode=jp3;
3941  07fa 35030047      	mov	_jp_mode,#3
3942  07fe               L5612:
3943                     ; 584 }
3946  07fe 81            	ret
3978                     ; 587 void link_drv(void)		//10Hz
3978                     ; 588 {
3979                     	switch	.text
3980  07ff               _link_drv:
3984                     ; 589 if(jp_mode!=jp3)
3986  07ff b647          	ld	a,_jp_mode
3987  0801 a103          	cp	a,#3
3988  0803 2744          	jreq	L7712
3989                     ; 591 	if(link_cnt<52)link_cnt++;
3991  0805 b65e          	ld	a,_link_cnt
3992  0807 a134          	cp	a,#52
3993  0809 2402          	jruge	L1022
3996  080b 3c5e          	inc	_link_cnt
3997  080d               L1022:
3998                     ; 592 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4000  080d b65e          	ld	a,_link_cnt
4001  080f a131          	cp	a,#49
4002  0811 2606          	jrne	L3022
4005  0813 b60a          	ld	a,_flags
4006  0815 a4c1          	and	a,#193
4007  0817 b70a          	ld	_flags,a
4008  0819               L3022:
4009                     ; 593 	if(link_cnt==50)
4011  0819 b65e          	ld	a,_link_cnt
4012  081b a132          	cp	a,#50
4013  081d 262e          	jrne	L5122
4014                     ; 595 		link=OFF;
4016  081f 35aa005f      	mov	_link,#170
4017                     ; 600 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4019  0823 b601          	ld	a,_bps_class
4020  0825 a101          	cp	a,#1
4021  0827 2606          	jrne	L7022
4024  0829 72100001      	bset	_bMAIN
4026  082d 2004          	jra	L1122
4027  082f               L7022:
4028                     ; 601 		else bMAIN=0;
4030  082f 72110001      	bres	_bMAIN
4031  0833               L1122:
4032                     ; 603 		cnt_net_drv=0;
4034  0833 3f2f          	clr	_cnt_net_drv
4035                     ; 604     		if(!res_fl_)
4037  0835 725d0008      	tnz	_res_fl_
4038  0839 2612          	jrne	L5122
4039                     ; 606 	    		bRES_=1;
4041  083b 35010010      	mov	_bRES_,#1
4042                     ; 607 	    		res_fl_=1;
4044  083f a601          	ld	a,#1
4045  0841 ae0008        	ldw	x,#_res_fl_
4046  0844 cd0000        	call	c_eewrc
4048  0847 2004          	jra	L5122
4049  0849               L7712:
4050                     ; 611 else link=OFF;	
4052  0849 35aa005f      	mov	_link,#170
4053  084d               L5122:
4054                     ; 612 } 
4057  084d 81            	ret
4126                     .const:	section	.text
4127  0000               L05:
4128  0000 0000000b      	dc.l	11
4129  0004               L25:
4130  0004 00000001      	dc.l	1
4131                     ; 616 void vent_drv(void)
4131                     ; 617 {
4132                     	switch	.text
4133  084e               _vent_drv:
4135  084e 520e          	subw	sp,#14
4136       0000000e      OFST:	set	14
4139                     ; 620 	short vent_pwm_i_necc=400;
4141  0850 ae0190        	ldw	x,#400
4142  0853 1f07          	ldw	(OFST-7,sp),x
4143                     ; 621 	short vent_pwm_t_necc=400;
4145  0855 ae0190        	ldw	x,#400
4146  0858 1f09          	ldw	(OFST-5,sp),x
4147                     ; 622 	short vent_pwm_max_necc=400;
4149                     ; 627 	tempSL=36000L/(signed long)ee_Umax;
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
4170                     ; 628 	tempSL=(signed long)I/tempSL;
4172  087f be6b          	ldw	x,_I
4173  0881 cd0000        	call	c_itolx
4175  0884 96            	ldw	x,sp
4176  0885 1c000b        	addw	x,#OFST-3
4177  0888 cd0000        	call	c_ldiv
4179  088b 96            	ldw	x,sp
4180  088c 1c000b        	addw	x,#OFST-3
4181  088f cd0000        	call	c_rtol
4183                     ; 630 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
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
4201                     ; 632 	if(tempSL>10)vent_pwm_i_necc=1000;
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
4219                     ; 633 	else if(tempSL<1)vent_pwm_i_necc=400;
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
4237                     ; 634 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4239  08db 1e0d          	ldw	x,(OFST-1,sp)
4240  08dd 90ae003c      	ldw	y,#60
4241  08e1 cd0000        	call	c_imul
4243  08e4 1c0190        	addw	x,#400
4244  08e7 1f07          	ldw	(OFST-7,sp),x
4245  08e9               L5522:
4246                     ; 635 	gran(&vent_pwm_i_necc,400,1000);
4248  08e9 ae03e8        	ldw	x,#1000
4249  08ec 89            	pushw	x
4250  08ed ae0190        	ldw	x,#400
4251  08f0 89            	pushw	x
4252  08f1 96            	ldw	x,sp
4253  08f2 1c000b        	addw	x,#OFST-3
4254  08f5 cd0000        	call	_gran
4256  08f8 5b04          	addw	sp,#4
4257                     ; 637 	tempSL=(signed long)T;
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
4271                     ; 638 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
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
4292                     ; 639 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
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
4310                     ; 640 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
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
4323                     ; 641 	gran(&vent_pwm_t_necc,400,1000);
4325  095b ae03e8        	ldw	x,#1000
4326  095e 89            	pushw	x
4327  095f ae0190        	ldw	x,#400
4328  0962 89            	pushw	x
4329  0963 96            	ldw	x,sp
4330  0964 1c000d        	addw	x,#OFST-1
4331  0967 cd0000        	call	_gran
4333  096a 5b04          	addw	sp,#4
4334                     ; 643 	vent_pwm_max_necc=vent_pwm_i_necc;
4336  096c 1e07          	ldw	x,(OFST-7,sp)
4337  096e 1f05          	ldw	(OFST-9,sp),x
4338                     ; 644 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4340  0970 9c            	rvf
4341  0971 1e09          	ldw	x,(OFST-5,sp)
4342  0973 1307          	cpw	x,(OFST-7,sp)
4343  0975 2d04          	jrsle	L3722
4346  0977 1e09          	ldw	x,(OFST-5,sp)
4347  0979 1f05          	ldw	(OFST-9,sp),x
4348  097b               L3722:
4349                     ; 646 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4351  097b 9c            	rvf
4352  097c be02          	ldw	x,_vent_pwm
4353  097e 1305          	cpw	x,(OFST-9,sp)
4354  0980 2e07          	jrsge	L5722
4357  0982 be02          	ldw	x,_vent_pwm
4358  0984 1c000a        	addw	x,#10
4359  0987 bf02          	ldw	_vent_pwm,x
4360  0989               L5722:
4361                     ; 647 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4363  0989 9c            	rvf
4364  098a be02          	ldw	x,_vent_pwm
4365  098c 1305          	cpw	x,(OFST-9,sp)
4366  098e 2d07          	jrsle	L7722
4369  0990 be02          	ldw	x,_vent_pwm
4370  0992 1d000a        	subw	x,#10
4371  0995 bf02          	ldw	_vent_pwm,x
4372  0997               L7722:
4373                     ; 648 	gran(&vent_pwm,400,1000);
4375  0997 ae03e8        	ldw	x,#1000
4376  099a 89            	pushw	x
4377  099b ae0190        	ldw	x,#400
4378  099e 89            	pushw	x
4379  099f ae0002        	ldw	x,#_vent_pwm
4380  09a2 cd0000        	call	_gran
4382  09a5 5b04          	addw	sp,#4
4383                     ; 650 }
4386  09a7 5b0e          	addw	sp,#14
4387  09a9 81            	ret
4421                     ; 655 void pwr_drv(void)
4421                     ; 656 {
4422                     	switch	.text
4423  09aa               _pwr_drv:
4427                     ; 660 BLOCK_INIT
4429  09aa 72145007      	bset	20487,#2
4432  09ae 72145008      	bset	20488,#2
4435  09b2 72155009      	bres	20489,#2
4436                     ; 662 if(main_cnt1<1500)main_cnt1++;
4438  09b6 9c            	rvf
4439  09b7 be4c          	ldw	x,_main_cnt1
4440  09b9 a305dc        	cpw	x,#1500
4441  09bc 2e07          	jrsge	L1132
4444  09be be4c          	ldw	x,_main_cnt1
4445  09c0 1c0001        	addw	x,#1
4446  09c3 bf4c          	ldw	_main_cnt1,x
4447  09c5               L1132:
4448                     ; 664 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4450  09c5 9c            	rvf
4451  09c6 ce0014        	ldw	x,_ee_TZAS
4452  09c9 90ae0005      	ldw	y,#5
4453  09cd cd0000        	call	c_imul
4455  09d0 b34c          	cpw	x,_main_cnt1
4456  09d2 2d0d          	jrsle	L3132
4458  09d4 b601          	ld	a,_bps_class
4459  09d6 a101          	cp	a,#1
4460  09d8 2707          	jreq	L3132
4461                     ; 666 	BLOCK_ON
4463  09da 72145005      	bset	20485,#2
4465  09de cc0a67        	jra	L5132
4466  09e1               L3132:
4467                     ; 669 else if(bps_class==bpsIPS)
4469  09e1 b601          	ld	a,_bps_class
4470  09e3 a101          	cp	a,#1
4471  09e5 261a          	jrne	L7132
4472                     ; 672 		if(bBL_IPS)
4474                     	btst	_bBL_IPS
4475  09ec 2406          	jruge	L1232
4476                     ; 674 			 BLOCK_ON
4478  09ee 72145005      	bset	20485,#2
4480  09f2 2073          	jra	L5132
4481  09f4               L1232:
4482                     ; 677 		else if(!bBL_IPS)
4484                     	btst	_bBL_IPS
4485  09f9 256c          	jrult	L5132
4486                     ; 679 			  BLOCK_OFF
4488  09fb 72155005      	bres	20485,#2
4489  09ff 2066          	jra	L5132
4490  0a01               L7132:
4491                     ; 683 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
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
4509                     ; 685 	if(bps_class==bpsIPS)
4511  0a22 b601          	ld	a,_bps_class
4512  0a24 a101          	cp	a,#1
4513  0a26 2606          	jrne	L3332
4514                     ; 687 		  BLOCK_OFF
4516  0a28 72155005      	bres	20485,#2
4518  0a2c 2039          	jra	L5132
4519  0a2e               L3332:
4520                     ; 690 	else if(bps_class==bpsIBEP)
4522  0a2e 3d01          	tnz	_bps_class
4523  0a30 2635          	jrne	L5132
4524                     ; 692 		if(ee_DEVICE)
4526  0a32 ce0002        	ldw	x,_ee_DEVICE
4527  0a35 2712          	jreq	L1432
4528                     ; 694 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4530  0a37 b60a          	ld	a,_flags
4531  0a39 a520          	bcp	a,#32
4532  0a3b 2706          	jreq	L3432
4535  0a3d 72145005      	bset	20485,#2
4537  0a41 2024          	jra	L5132
4538  0a43               L3432:
4539                     ; 695 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4541  0a43 72155005      	bres	20485,#2
4542  0a47 201e          	jra	L5132
4543  0a49               L1432:
4544                     ; 699 			BLOCK_OFF
4546  0a49 72155005      	bres	20485,#2
4547  0a4d 2018          	jra	L5132
4548  0a4f               L1332:
4549                     ; 704 else if(bBL)
4551                     	btst	_bBL
4552  0a54 2406          	jruge	L3532
4553                     ; 706 	BLOCK_ON
4555  0a56 72145005      	bset	20485,#2
4557  0a5a 200b          	jra	L5132
4558  0a5c               L3532:
4559                     ; 709 else if(!bBL)
4561                     	btst	_bBL
4562  0a61 2504          	jrult	L5132
4563                     ; 711 	BLOCK_OFF
4565  0a63 72155005      	bres	20485,#2
4566  0a67               L5132:
4567                     ; 715 gran(&pwm_u,2,1020);
4569  0a67 ae03fc        	ldw	x,#1020
4570  0a6a 89            	pushw	x
4571  0a6b ae0002        	ldw	x,#2
4572  0a6e 89            	pushw	x
4573  0a6f ae000b        	ldw	x,#_pwm_u
4574  0a72 cd0000        	call	_gran
4576  0a75 5b04          	addw	sp,#4
4577                     ; 725 TIM1->CCR2H= (char)(pwm_u/256);	
4579  0a77 be0b          	ldw	x,_pwm_u
4580  0a79 90ae0100      	ldw	y,#256
4581  0a7d cd0000        	call	c_idiv
4583  0a80 9f            	ld	a,xl
4584  0a81 c75267        	ld	21095,a
4585                     ; 726 TIM1->CCR2L= (char)pwm_u;
4587  0a84 55000c5268    	mov	21096,_pwm_u+1
4588                     ; 728 TIM1->CCR1H= (char)(pwm_i/256);	
4590  0a89 be0d          	ldw	x,_pwm_i
4591  0a8b 90ae0100      	ldw	y,#256
4592  0a8f cd0000        	call	c_idiv
4594  0a92 9f            	ld	a,xl
4595  0a93 c75265        	ld	21093,a
4596                     ; 729 TIM1->CCR1L= (char)pwm_i;
4598  0a96 55000e5266    	mov	21094,_pwm_i+1
4599                     ; 731 TIM1->CCR3H= (char)(vent_pwm/256);	
4601  0a9b be02          	ldw	x,_vent_pwm
4602  0a9d 90ae0100      	ldw	y,#256
4603  0aa1 cd0000        	call	c_idiv
4605  0aa4 9f            	ld	a,xl
4606  0aa5 c75269        	ld	21097,a
4607                     ; 732 TIM1->CCR3L= (char)vent_pwm;
4609  0aa8 550003526a    	mov	21098,_vent_pwm+1
4610                     ; 733 }
4613  0aad 81            	ret
4651                     ; 738 void pwr_hndl(void)				
4651                     ; 739 {
4652                     	switch	.text
4653  0aae               _pwr_hndl:
4657                     ; 740 if(jp_mode==jp3)
4659  0aae b647          	ld	a,_jp_mode
4660  0ab0 a103          	cp	a,#3
4661  0ab2 2627          	jrne	L1732
4662                     ; 742 	if((flags&0b00001010)==0)
4664  0ab4 b60a          	ld	a,_flags
4665  0ab6 a50a          	bcp	a,#10
4666  0ab8 260d          	jrne	L3732
4667                     ; 744 		pwm_u=500;
4669  0aba ae01f4        	ldw	x,#500
4670  0abd bf0b          	ldw	_pwm_u,x
4671                     ; 746 		bBL=0;
4673  0abf 72110003      	bres	_bBL
4675  0ac3 acc90bc9      	jpf	L1042
4676  0ac7               L3732:
4677                     ; 748 	else if(flags&0b00001010)
4679  0ac7 b60a          	ld	a,_flags
4680  0ac9 a50a          	bcp	a,#10
4681  0acb 2603          	jrne	L06
4682  0acd cc0bc9        	jp	L1042
4683  0ad0               L06:
4684                     ; 750 		pwm_u=0;
4686  0ad0 5f            	clrw	x
4687  0ad1 bf0b          	ldw	_pwm_u,x
4688                     ; 752 		bBL=1;
4690  0ad3 72100003      	bset	_bBL
4691  0ad7 acc90bc9      	jpf	L1042
4692  0adb               L1732:
4693                     ; 756 else if(jp_mode==jp2)
4695  0adb b647          	ld	a,_jp_mode
4696  0add a102          	cp	a,#2
4697  0adf 2610          	jrne	L3042
4698                     ; 758 	pwm_u=0;
4700  0ae1 5f            	clrw	x
4701  0ae2 bf0b          	ldw	_pwm_u,x
4702                     ; 759 	pwm_i=0x3ff;
4704  0ae4 ae03ff        	ldw	x,#1023
4705  0ae7 bf0d          	ldw	_pwm_i,x
4706                     ; 760 	bBL=0;
4708  0ae9 72110003      	bres	_bBL
4710  0aed acc90bc9      	jpf	L1042
4711  0af1               L3042:
4712                     ; 762 else if(jp_mode==jp1)
4714  0af1 b647          	ld	a,_jp_mode
4715  0af3 a101          	cp	a,#1
4716  0af5 2612          	jrne	L7042
4717                     ; 764 	pwm_u=0x3ff;
4719  0af7 ae03ff        	ldw	x,#1023
4720  0afa bf0b          	ldw	_pwm_u,x
4721                     ; 765 	pwm_i=0x3ff;
4723  0afc ae03ff        	ldw	x,#1023
4724  0aff bf0d          	ldw	_pwm_i,x
4725                     ; 766 	bBL=0;
4727  0b01 72110003      	bres	_bBL
4729  0b05 acc90bc9      	jpf	L1042
4730  0b09               L7042:
4731                     ; 769 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4733                     	btst	_bMAIN
4734  0b0e 2417          	jruge	L3142
4736  0b10 b65f          	ld	a,_link
4737  0b12 a155          	cp	a,#85
4738  0b14 2611          	jrne	L3142
4739                     ; 771 	pwm_u=volum_u_main_;
4741  0b16 be1c          	ldw	x,_volum_u_main_
4742  0b18 bf0b          	ldw	_pwm_u,x
4743                     ; 772 	pwm_i=0x3ff;
4745  0b1a ae03ff        	ldw	x,#1023
4746  0b1d bf0d          	ldw	_pwm_i,x
4747                     ; 773 	bBL_IPS=0;
4749  0b1f 72110000      	bres	_bBL_IPS
4751  0b23 acc90bc9      	jpf	L1042
4752  0b27               L3142:
4753                     ; 776 else if(link==OFF)
4755  0b27 b65f          	ld	a,_link
4756  0b29 a1aa          	cp	a,#170
4757  0b2b 2650          	jrne	L7142
4758                     ; 785  	if(ee_DEVICE)
4760  0b2d ce0002        	ldw	x,_ee_DEVICE
4761  0b30 270d          	jreq	L1242
4762                     ; 787 		pwm_u=0x00;
4764  0b32 5f            	clrw	x
4765  0b33 bf0b          	ldw	_pwm_u,x
4766                     ; 788 		pwm_i=0x00;
4768  0b35 5f            	clrw	x
4769  0b36 bf0d          	ldw	_pwm_i,x
4770                     ; 789 		bBL=1;
4772  0b38 72100003      	bset	_bBL
4774  0b3c cc0bc9        	jra	L1042
4775  0b3f               L1242:
4776                     ; 793 		if((flags&0b00011010)==0)
4778  0b3f b60a          	ld	a,_flags
4779  0b41 a51a          	bcp	a,#26
4780  0b43 2622          	jrne	L5242
4781                     ; 795 			pwm_u=ee_U_AVT;
4783  0b45 ce000a        	ldw	x,_ee_U_AVT
4784  0b48 bf0b          	ldw	_pwm_u,x
4785                     ; 796 			gran(&pwm_u,0,1020);
4787  0b4a ae03fc        	ldw	x,#1020
4788  0b4d 89            	pushw	x
4789  0b4e 5f            	clrw	x
4790  0b4f 89            	pushw	x
4791  0b50 ae000b        	ldw	x,#_pwm_u
4792  0b53 cd0000        	call	_gran
4794  0b56 5b04          	addw	sp,#4
4795                     ; 797 		    	pwm_i=0x3ff;
4797  0b58 ae03ff        	ldw	x,#1023
4798  0b5b bf0d          	ldw	_pwm_i,x
4799                     ; 798 			bBL=0;
4801  0b5d 72110003      	bres	_bBL
4802                     ; 799 			bBL_IPS=0;
4804  0b61 72110000      	bres	_bBL_IPS
4806  0b65 2062          	jra	L1042
4807  0b67               L5242:
4808                     ; 801 		else if(flags&0b00011010)
4810  0b67 b60a          	ld	a,_flags
4811  0b69 a51a          	bcp	a,#26
4812  0b6b 275c          	jreq	L1042
4813                     ; 803 			pwm_u=0;
4815  0b6d 5f            	clrw	x
4816  0b6e bf0b          	ldw	_pwm_u,x
4817                     ; 804 			pwm_i=0;
4819  0b70 5f            	clrw	x
4820  0b71 bf0d          	ldw	_pwm_i,x
4821                     ; 805 			bBL=1;
4823  0b73 72100003      	bset	_bBL
4824                     ; 806 			bBL_IPS=1;
4826  0b77 72100000      	bset	_bBL_IPS
4827  0b7b 204c          	jra	L1042
4828  0b7d               L7142:
4829                     ; 815 else	if(link==ON)				//если есть связь
4831  0b7d b65f          	ld	a,_link
4832  0b7f a155          	cp	a,#85
4833  0b81 2646          	jrne	L1042
4834                     ; 817 	if((flags&0b00100000)==0)	//если нет блокировки извне
4836  0b83 b60a          	ld	a,_flags
4837  0b85 a520          	bcp	a,#32
4838  0b87 2630          	jrne	L7342
4839                     ; 819 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4841  0b89 b60a          	ld	a,_flags
4842  0b8b a51a          	bcp	a,#26
4843  0b8d 2706          	jreq	L3442
4845  0b8f b60a          	ld	a,_flags
4846  0b91 a540          	bcp	a,#64
4847  0b93 2712          	jreq	L1442
4848  0b95               L3442:
4849                     ; 821 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4851  0b95 be5b          	ldw	x,__x_
4852  0b97 72bb0055      	addw	x,_vol_u_temp
4853  0b9b bf0b          	ldw	_pwm_u,x
4854                     ; 822 		    	pwm_i=vol_i_temp;
4856  0b9d be53          	ldw	x,_vol_i_temp
4857  0b9f bf0d          	ldw	_pwm_i,x
4858                     ; 823 			bBL=0;
4860  0ba1 72110003      	bres	_bBL
4862  0ba5 2022          	jra	L1042
4863  0ba7               L1442:
4864                     ; 825 		else if(flags&0b00011010)					//если есть аварии
4866  0ba7 b60a          	ld	a,_flags
4867  0ba9 a51a          	bcp	a,#26
4868  0bab 271c          	jreq	L1042
4869                     ; 827 			pwm_u=0;								//то полный стоп
4871  0bad 5f            	clrw	x
4872  0bae bf0b          	ldw	_pwm_u,x
4873                     ; 828 			pwm_i=0;
4875  0bb0 5f            	clrw	x
4876  0bb1 bf0d          	ldw	_pwm_i,x
4877                     ; 829 			bBL=1;
4879  0bb3 72100003      	bset	_bBL
4880  0bb7 2010          	jra	L1042
4881  0bb9               L7342:
4882                     ; 832 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4884  0bb9 b60a          	ld	a,_flags
4885  0bbb a520          	bcp	a,#32
4886  0bbd 270a          	jreq	L1042
4887                     ; 834 		pwm_u=0;
4889  0bbf 5f            	clrw	x
4890  0bc0 bf0b          	ldw	_pwm_u,x
4891                     ; 835 	    	pwm_i=0;
4893  0bc2 5f            	clrw	x
4894  0bc3 bf0d          	ldw	_pwm_i,x
4895                     ; 836 		bBL=1;
4897  0bc5 72100003      	bset	_bBL
4898  0bc9               L1042:
4899                     ; 842 }
4902  0bc9 81            	ret
4944                     	switch	.const
4945  0008               L46:
4946  0008 00000258      	dc.l	600
4947  000c               L66:
4948  000c 00000708      	dc.l	1800
4949  0010               L07:
4950  0010 000003e8      	dc.l	1000
4951                     ; 845 void matemat(void)
4951                     ; 846 {
4952                     	switch	.text
4953  0bca               _matemat:
4955  0bca 5204          	subw	sp,#4
4956       00000004      OFST:	set	4
4959                     ; 867 temp_SL=adc_buff_[4];
4961  0bcc ce000d        	ldw	x,_adc_buff_+8
4962  0bcf cd0000        	call	c_itolx
4964  0bd2 96            	ldw	x,sp
4965  0bd3 1c0001        	addw	x,#OFST-3
4966  0bd6 cd0000        	call	c_rtol
4968                     ; 868 temp_SL-=ee_K[0][0];
4970  0bd9 ce0018        	ldw	x,_ee_K
4971  0bdc cd0000        	call	c_itolx
4973  0bdf 96            	ldw	x,sp
4974  0be0 1c0001        	addw	x,#OFST-3
4975  0be3 cd0000        	call	c_lgsub
4977                     ; 869 if(temp_SL<0) temp_SL=0;
4979  0be6 9c            	rvf
4980  0be7 0d01          	tnz	(OFST-3,sp)
4981  0be9 2e0a          	jrsge	L3742
4984  0beb ae0000        	ldw	x,#0
4985  0bee 1f03          	ldw	(OFST-1,sp),x
4986  0bf0 ae0000        	ldw	x,#0
4987  0bf3 1f01          	ldw	(OFST-3,sp),x
4988  0bf5               L3742:
4989                     ; 870 temp_SL*=ee_K[0][1];
4991  0bf5 ce001a        	ldw	x,_ee_K+2
4992  0bf8 cd0000        	call	c_itolx
4994  0bfb 96            	ldw	x,sp
4995  0bfc 1c0001        	addw	x,#OFST-3
4996  0bff cd0000        	call	c_lgmul
4998                     ; 871 temp_SL/=600;
5000  0c02 96            	ldw	x,sp
5001  0c03 1c0001        	addw	x,#OFST-3
5002  0c06 cd0000        	call	c_ltor
5004  0c09 ae0008        	ldw	x,#L46
5005  0c0c cd0000        	call	c_ldiv
5007  0c0f 96            	ldw	x,sp
5008  0c10 1c0001        	addw	x,#OFST-3
5009  0c13 cd0000        	call	c_rtol
5011                     ; 872 I=(signed short)temp_SL;
5013  0c16 1e03          	ldw	x,(OFST-1,sp)
5014  0c18 bf6b          	ldw	_I,x
5015                     ; 877 temp_SL=(signed long)adc_buff_[1];
5017  0c1a ce0007        	ldw	x,_adc_buff_+2
5018  0c1d cd0000        	call	c_itolx
5020  0c20 96            	ldw	x,sp
5021  0c21 1c0001        	addw	x,#OFST-3
5022  0c24 cd0000        	call	c_rtol
5024                     ; 879 if(temp_SL<0) temp_SL=0;
5026  0c27 9c            	rvf
5027  0c28 0d01          	tnz	(OFST-3,sp)
5028  0c2a 2e0a          	jrsge	L5742
5031  0c2c ae0000        	ldw	x,#0
5032  0c2f 1f03          	ldw	(OFST-1,sp),x
5033  0c31 ae0000        	ldw	x,#0
5034  0c34 1f01          	ldw	(OFST-3,sp),x
5035  0c36               L5742:
5036                     ; 880 temp_SL*=(signed long)ee_K[2][1];
5038  0c36 ce0022        	ldw	x,_ee_K+10
5039  0c39 cd0000        	call	c_itolx
5041  0c3c 96            	ldw	x,sp
5042  0c3d 1c0001        	addw	x,#OFST-3
5043  0c40 cd0000        	call	c_lgmul
5045                     ; 881 temp_SL/=1800L;
5047  0c43 96            	ldw	x,sp
5048  0c44 1c0001        	addw	x,#OFST-3
5049  0c47 cd0000        	call	c_ltor
5051  0c4a ae000c        	ldw	x,#L66
5052  0c4d cd0000        	call	c_ldiv
5054  0c50 96            	ldw	x,sp
5055  0c51 1c0001        	addw	x,#OFST-3
5056  0c54 cd0000        	call	c_rtol
5058                     ; 882 Ui=(unsigned short)temp_SL;
5060  0c57 1e03          	ldw	x,(OFST-1,sp)
5061  0c59 bf67          	ldw	_Ui,x
5062                     ; 889 temp_SL=adc_buff_[3];
5064  0c5b ce000b        	ldw	x,_adc_buff_+6
5065  0c5e cd0000        	call	c_itolx
5067  0c61 96            	ldw	x,sp
5068  0c62 1c0001        	addw	x,#OFST-3
5069  0c65 cd0000        	call	c_rtol
5071                     ; 891 if(temp_SL<0) temp_SL=0;
5073  0c68 9c            	rvf
5074  0c69 0d01          	tnz	(OFST-3,sp)
5075  0c6b 2e0a          	jrsge	L7742
5078  0c6d ae0000        	ldw	x,#0
5079  0c70 1f03          	ldw	(OFST-1,sp),x
5080  0c72 ae0000        	ldw	x,#0
5081  0c75 1f01          	ldw	(OFST-3,sp),x
5082  0c77               L7742:
5083                     ; 892 temp_SL*=ee_K[1][1];
5085  0c77 ce001e        	ldw	x,_ee_K+6
5086  0c7a cd0000        	call	c_itolx
5088  0c7d 96            	ldw	x,sp
5089  0c7e 1c0001        	addw	x,#OFST-3
5090  0c81 cd0000        	call	c_lgmul
5092                     ; 893 temp_SL/=1800;
5094  0c84 96            	ldw	x,sp
5095  0c85 1c0001        	addw	x,#OFST-3
5096  0c88 cd0000        	call	c_ltor
5098  0c8b ae000c        	ldw	x,#L66
5099  0c8e cd0000        	call	c_ldiv
5101  0c91 96            	ldw	x,sp
5102  0c92 1c0001        	addw	x,#OFST-3
5103  0c95 cd0000        	call	c_rtol
5105                     ; 894 Un=(unsigned short)temp_SL;
5107  0c98 1e03          	ldw	x,(OFST-1,sp)
5108  0c9a bf69          	ldw	_Un,x
5109                     ; 897 temp_SL=adc_buff_[2];
5111  0c9c ce0009        	ldw	x,_adc_buff_+4
5112  0c9f cd0000        	call	c_itolx
5114  0ca2 96            	ldw	x,sp
5115  0ca3 1c0001        	addw	x,#OFST-3
5116  0ca6 cd0000        	call	c_rtol
5118                     ; 898 temp_SL*=ee_K[3][1];
5120  0ca9 ce0026        	ldw	x,_ee_K+14
5121  0cac cd0000        	call	c_itolx
5123  0caf 96            	ldw	x,sp
5124  0cb0 1c0001        	addw	x,#OFST-3
5125  0cb3 cd0000        	call	c_lgmul
5127                     ; 899 temp_SL/=1000;
5129  0cb6 96            	ldw	x,sp
5130  0cb7 1c0001        	addw	x,#OFST-3
5131  0cba cd0000        	call	c_ltor
5133  0cbd ae0010        	ldw	x,#L07
5134  0cc0 cd0000        	call	c_ldiv
5136  0cc3 96            	ldw	x,sp
5137  0cc4 1c0001        	addw	x,#OFST-3
5138  0cc7 cd0000        	call	c_rtol
5140                     ; 900 T=(signed short)(temp_SL-273L);
5142  0cca 7b04          	ld	a,(OFST+0,sp)
5143  0ccc 5f            	clrw	x
5144  0ccd 4d            	tnz	a
5145  0cce 2a01          	jrpl	L27
5146  0cd0 53            	cplw	x
5147  0cd1               L27:
5148  0cd1 97            	ld	xl,a
5149  0cd2 1d0111        	subw	x,#273
5150  0cd5 01            	rrwa	x,a
5151  0cd6 b764          	ld	_T,a
5152  0cd8 02            	rlwa	x,a
5153                     ; 901 if(T<-30)T=-30;
5155  0cd9 9c            	rvf
5156  0cda b664          	ld	a,_T
5157  0cdc a1e2          	cp	a,#226
5158  0cde 2e04          	jrsge	L1052
5161  0ce0 35e20064      	mov	_T,#226
5162  0ce4               L1052:
5163                     ; 902 if(T>120)T=120;
5165  0ce4 9c            	rvf
5166  0ce5 b664          	ld	a,_T
5167  0ce7 a179          	cp	a,#121
5168  0ce9 2f04          	jrslt	L3052
5171  0ceb 35780064      	mov	_T,#120
5172  0cef               L3052:
5173                     ; 904 Udb=flags;
5175  0cef b60a          	ld	a,_flags
5176  0cf1 5f            	clrw	x
5177  0cf2 97            	ld	xl,a
5178  0cf3 bf65          	ldw	_Udb,x
5179                     ; 910 }
5182  0cf5 5b04          	addw	sp,#4
5183  0cf7 81            	ret
5214                     ; 913 void temper_drv(void)		//1 Hz
5214                     ; 914 {
5215                     	switch	.text
5216  0cf8               _temper_drv:
5220                     ; 916 if(T>ee_tsign) tsign_cnt++;
5222  0cf8 9c            	rvf
5223  0cf9 5f            	clrw	x
5224  0cfa b664          	ld	a,_T
5225  0cfc 2a01          	jrpl	L67
5226  0cfe 53            	cplw	x
5227  0cff               L67:
5228  0cff 97            	ld	xl,a
5229  0d00 c3000c        	cpw	x,_ee_tsign
5230  0d03 2d09          	jrsle	L5152
5233  0d05 be4a          	ldw	x,_tsign_cnt
5234  0d07 1c0001        	addw	x,#1
5235  0d0a bf4a          	ldw	_tsign_cnt,x
5237  0d0c 201d          	jra	L7152
5238  0d0e               L5152:
5239                     ; 917 else if (T<(ee_tsign-1)) tsign_cnt--;
5241  0d0e 9c            	rvf
5242  0d0f ce000c        	ldw	x,_ee_tsign
5243  0d12 5a            	decw	x
5244  0d13 905f          	clrw	y
5245  0d15 b664          	ld	a,_T
5246  0d17 2a02          	jrpl	L001
5247  0d19 9053          	cplw	y
5248  0d1b               L001:
5249  0d1b 9097          	ld	yl,a
5250  0d1d 90bf00        	ldw	c_y,y
5251  0d20 b300          	cpw	x,c_y
5252  0d22 2d07          	jrsle	L7152
5255  0d24 be4a          	ldw	x,_tsign_cnt
5256  0d26 1d0001        	subw	x,#1
5257  0d29 bf4a          	ldw	_tsign_cnt,x
5258  0d2b               L7152:
5259                     ; 919 gran(&tsign_cnt,0,60);
5261  0d2b ae003c        	ldw	x,#60
5262  0d2e 89            	pushw	x
5263  0d2f 5f            	clrw	x
5264  0d30 89            	pushw	x
5265  0d31 ae004a        	ldw	x,#_tsign_cnt
5266  0d34 cd0000        	call	_gran
5268  0d37 5b04          	addw	sp,#4
5269                     ; 921 if(tsign_cnt>=55)
5271  0d39 9c            	rvf
5272  0d3a be4a          	ldw	x,_tsign_cnt
5273  0d3c a30037        	cpw	x,#55
5274  0d3f 2f16          	jrslt	L3252
5275                     ; 923 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5277  0d41 3d47          	tnz	_jp_mode
5278  0d43 2606          	jrne	L1352
5280  0d45 b60a          	ld	a,_flags
5281  0d47 a540          	bcp	a,#64
5282  0d49 2706          	jreq	L7252
5283  0d4b               L1352:
5285  0d4b b647          	ld	a,_jp_mode
5286  0d4d a103          	cp	a,#3
5287  0d4f 2612          	jrne	L3352
5288  0d51               L7252:
5291  0d51 7214000a      	bset	_flags,#2
5292  0d55 200c          	jra	L3352
5293  0d57               L3252:
5294                     ; 925 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5296  0d57 9c            	rvf
5297  0d58 be4a          	ldw	x,_tsign_cnt
5298  0d5a a30006        	cpw	x,#6
5299  0d5d 2e04          	jrsge	L3352
5302  0d5f 7215000a      	bres	_flags,#2
5303  0d63               L3352:
5304                     ; 930 if(T>ee_tmax) tmax_cnt++;
5306  0d63 9c            	rvf
5307  0d64 5f            	clrw	x
5308  0d65 b664          	ld	a,_T
5309  0d67 2a01          	jrpl	L201
5310  0d69 53            	cplw	x
5311  0d6a               L201:
5312  0d6a 97            	ld	xl,a
5313  0d6b c3000e        	cpw	x,_ee_tmax
5314  0d6e 2d09          	jrsle	L7352
5317  0d70 be48          	ldw	x,_tmax_cnt
5318  0d72 1c0001        	addw	x,#1
5319  0d75 bf48          	ldw	_tmax_cnt,x
5321  0d77 201d          	jra	L1452
5322  0d79               L7352:
5323                     ; 931 else if (T<(ee_tmax-1)) tmax_cnt--;
5325  0d79 9c            	rvf
5326  0d7a ce000e        	ldw	x,_ee_tmax
5327  0d7d 5a            	decw	x
5328  0d7e 905f          	clrw	y
5329  0d80 b664          	ld	a,_T
5330  0d82 2a02          	jrpl	L401
5331  0d84 9053          	cplw	y
5332  0d86               L401:
5333  0d86 9097          	ld	yl,a
5334  0d88 90bf00        	ldw	c_y,y
5335  0d8b b300          	cpw	x,c_y
5336  0d8d 2d07          	jrsle	L1452
5339  0d8f be48          	ldw	x,_tmax_cnt
5340  0d91 1d0001        	subw	x,#1
5341  0d94 bf48          	ldw	_tmax_cnt,x
5342  0d96               L1452:
5343                     ; 933 gran(&tmax_cnt,0,60);
5345  0d96 ae003c        	ldw	x,#60
5346  0d99 89            	pushw	x
5347  0d9a 5f            	clrw	x
5348  0d9b 89            	pushw	x
5349  0d9c ae0048        	ldw	x,#_tmax_cnt
5350  0d9f cd0000        	call	_gran
5352  0da2 5b04          	addw	sp,#4
5353                     ; 935 if(tmax_cnt>=55)
5355  0da4 9c            	rvf
5356  0da5 be48          	ldw	x,_tmax_cnt
5357  0da7 a30037        	cpw	x,#55
5358  0daa 2f16          	jrslt	L5452
5359                     ; 937 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5361  0dac 3d47          	tnz	_jp_mode
5362  0dae 2606          	jrne	L3552
5364  0db0 b60a          	ld	a,_flags
5365  0db2 a540          	bcp	a,#64
5366  0db4 2706          	jreq	L1552
5367  0db6               L3552:
5369  0db6 b647          	ld	a,_jp_mode
5370  0db8 a103          	cp	a,#3
5371  0dba 2612          	jrne	L5552
5372  0dbc               L1552:
5375  0dbc 7212000a      	bset	_flags,#1
5376  0dc0 200c          	jra	L5552
5377  0dc2               L5452:
5378                     ; 939 else if (tmax_cnt<=5) flags&=0b11111101;
5380  0dc2 9c            	rvf
5381  0dc3 be48          	ldw	x,_tmax_cnt
5382  0dc5 a30006        	cpw	x,#6
5383  0dc8 2e04          	jrsge	L5552
5386  0dca 7213000a      	bres	_flags,#1
5387  0dce               L5552:
5388                     ; 942 } 
5391  0dce 81            	ret
5423                     ; 945 void u_drv(void)		//1Hz
5423                     ; 946 { 
5424                     	switch	.text
5425  0dcf               _u_drv:
5429                     ; 947 if(jp_mode!=jp3)
5431  0dcf b647          	ld	a,_jp_mode
5432  0dd1 a103          	cp	a,#3
5433  0dd3 2770          	jreq	L1752
5434                     ; 949 	if(Ui>ee_Umax)umax_cnt++;
5436  0dd5 9c            	rvf
5437  0dd6 be67          	ldw	x,_Ui
5438  0dd8 c30012        	cpw	x,_ee_Umax
5439  0ddb 2d09          	jrsle	L3752
5442  0ddd be62          	ldw	x,_umax_cnt
5443  0ddf 1c0001        	addw	x,#1
5444  0de2 bf62          	ldw	_umax_cnt,x
5446  0de4 2003          	jra	L5752
5447  0de6               L3752:
5448                     ; 950 	else umax_cnt=0;
5450  0de6 5f            	clrw	x
5451  0de7 bf62          	ldw	_umax_cnt,x
5452  0de9               L5752:
5453                     ; 951 	gran(&umax_cnt,0,10);
5455  0de9 ae000a        	ldw	x,#10
5456  0dec 89            	pushw	x
5457  0ded 5f            	clrw	x
5458  0dee 89            	pushw	x
5459  0def ae0062        	ldw	x,#_umax_cnt
5460  0df2 cd0000        	call	_gran
5462  0df5 5b04          	addw	sp,#4
5463                     ; 952 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5465  0df7 9c            	rvf
5466  0df8 be62          	ldw	x,_umax_cnt
5467  0dfa a3000a        	cpw	x,#10
5468  0dfd 2f04          	jrslt	L7752
5471  0dff 7216000a      	bset	_flags,#3
5472  0e03               L7752:
5473                     ; 955 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5475  0e03 9c            	rvf
5476  0e04 be67          	ldw	x,_Ui
5477  0e06 b369          	cpw	x,_Un
5478  0e08 2e1c          	jrsge	L1062
5480  0e0a 9c            	rvf
5481  0e0b be69          	ldw	x,_Un
5482  0e0d 72b00067      	subw	x,_Ui
5483  0e11 c30010        	cpw	x,_ee_dU
5484  0e14 2d10          	jrsle	L1062
5486  0e16 c65005        	ld	a,20485
5487  0e19 a504          	bcp	a,#4
5488  0e1b 2609          	jrne	L1062
5491  0e1d be60          	ldw	x,_umin_cnt
5492  0e1f 1c0001        	addw	x,#1
5493  0e22 bf60          	ldw	_umin_cnt,x
5495  0e24 2003          	jra	L3062
5496  0e26               L1062:
5497                     ; 956 	else umin_cnt=0;
5499  0e26 5f            	clrw	x
5500  0e27 bf60          	ldw	_umin_cnt,x
5501  0e29               L3062:
5502                     ; 957 	gran(&umin_cnt,0,10);	
5504  0e29 ae000a        	ldw	x,#10
5505  0e2c 89            	pushw	x
5506  0e2d 5f            	clrw	x
5507  0e2e 89            	pushw	x
5508  0e2f ae0060        	ldw	x,#_umin_cnt
5509  0e32 cd0000        	call	_gran
5511  0e35 5b04          	addw	sp,#4
5512                     ; 958 	if(umin_cnt>=10)flags|=0b00010000;	  
5514  0e37 9c            	rvf
5515  0e38 be60          	ldw	x,_umin_cnt
5516  0e3a a3000a        	cpw	x,#10
5517  0e3d 2f6f          	jrslt	L7062
5520  0e3f 7218000a      	bset	_flags,#4
5521  0e43 2069          	jra	L7062
5522  0e45               L1752:
5523                     ; 960 else if(jp_mode==jp3)
5525  0e45 b647          	ld	a,_jp_mode
5526  0e47 a103          	cp	a,#3
5527  0e49 2663          	jrne	L7062
5528                     ; 962 	if(Ui>700)umax_cnt++;
5530  0e4b 9c            	rvf
5531  0e4c be67          	ldw	x,_Ui
5532  0e4e a302bd        	cpw	x,#701
5533  0e51 2f09          	jrslt	L3162
5536  0e53 be62          	ldw	x,_umax_cnt
5537  0e55 1c0001        	addw	x,#1
5538  0e58 bf62          	ldw	_umax_cnt,x
5540  0e5a 2003          	jra	L5162
5541  0e5c               L3162:
5542                     ; 963 	else umax_cnt=0;
5544  0e5c 5f            	clrw	x
5545  0e5d bf62          	ldw	_umax_cnt,x
5546  0e5f               L5162:
5547                     ; 964 	gran(&umax_cnt,0,10);
5549  0e5f ae000a        	ldw	x,#10
5550  0e62 89            	pushw	x
5551  0e63 5f            	clrw	x
5552  0e64 89            	pushw	x
5553  0e65 ae0062        	ldw	x,#_umax_cnt
5554  0e68 cd0000        	call	_gran
5556  0e6b 5b04          	addw	sp,#4
5557                     ; 965 	if(umax_cnt>=10)flags|=0b00001000;
5559  0e6d 9c            	rvf
5560  0e6e be62          	ldw	x,_umax_cnt
5561  0e70 a3000a        	cpw	x,#10
5562  0e73 2f04          	jrslt	L7162
5565  0e75 7216000a      	bset	_flags,#3
5566  0e79               L7162:
5567                     ; 968 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5569  0e79 9c            	rvf
5570  0e7a be67          	ldw	x,_Ui
5571  0e7c a300c8        	cpw	x,#200
5572  0e7f 2e10          	jrsge	L1262
5574  0e81 c65005        	ld	a,20485
5575  0e84 a504          	bcp	a,#4
5576  0e86 2609          	jrne	L1262
5579  0e88 be60          	ldw	x,_umin_cnt
5580  0e8a 1c0001        	addw	x,#1
5581  0e8d bf60          	ldw	_umin_cnt,x
5583  0e8f 2003          	jra	L3262
5584  0e91               L1262:
5585                     ; 969 	else umin_cnt=0;
5587  0e91 5f            	clrw	x
5588  0e92 bf60          	ldw	_umin_cnt,x
5589  0e94               L3262:
5590                     ; 970 	gran(&umin_cnt,0,10);	
5592  0e94 ae000a        	ldw	x,#10
5593  0e97 89            	pushw	x
5594  0e98 5f            	clrw	x
5595  0e99 89            	pushw	x
5596  0e9a ae0060        	ldw	x,#_umin_cnt
5597  0e9d cd0000        	call	_gran
5599  0ea0 5b04          	addw	sp,#4
5600                     ; 971 	if(umin_cnt>=10)flags|=0b00010000;	  
5602  0ea2 9c            	rvf
5603  0ea3 be60          	ldw	x,_umin_cnt
5604  0ea5 a3000a        	cpw	x,#10
5605  0ea8 2f04          	jrslt	L7062
5608  0eaa 7218000a      	bset	_flags,#4
5609  0eae               L7062:
5610                     ; 973 }
5613  0eae 81            	ret
5640                     ; 976 void x_drv(void)
5640                     ; 977 {
5641                     	switch	.text
5642  0eaf               _x_drv:
5646                     ; 978 if(_x__==_x_)
5648  0eaf be59          	ldw	x,__x__
5649  0eb1 b35b          	cpw	x,__x_
5650  0eb3 262a          	jrne	L7362
5651                     ; 980 	if(_x_cnt<60)
5653  0eb5 9c            	rvf
5654  0eb6 be57          	ldw	x,__x_cnt
5655  0eb8 a3003c        	cpw	x,#60
5656  0ebb 2e25          	jrsge	L7462
5657                     ; 982 		_x_cnt++;
5659  0ebd be57          	ldw	x,__x_cnt
5660  0ebf 1c0001        	addw	x,#1
5661  0ec2 bf57          	ldw	__x_cnt,x
5662                     ; 983 		if(_x_cnt>=60)
5664  0ec4 9c            	rvf
5665  0ec5 be57          	ldw	x,__x_cnt
5666  0ec7 a3003c        	cpw	x,#60
5667  0eca 2f16          	jrslt	L7462
5668                     ; 985 			if(_x_ee_!=_x_)_x_ee_=_x_;
5670  0ecc ce0016        	ldw	x,__x_ee_
5671  0ecf b35b          	cpw	x,__x_
5672  0ed1 270f          	jreq	L7462
5675  0ed3 be5b          	ldw	x,__x_
5676  0ed5 89            	pushw	x
5677  0ed6 ae0016        	ldw	x,#__x_ee_
5678  0ed9 cd0000        	call	c_eewrw
5680  0edc 85            	popw	x
5681  0edd 2003          	jra	L7462
5682  0edf               L7362:
5683                     ; 990 else _x_cnt=0;
5685  0edf 5f            	clrw	x
5686  0ee0 bf57          	ldw	__x_cnt,x
5687  0ee2               L7462:
5688                     ; 992 if(_x_cnt>60) _x_cnt=0;	
5690  0ee2 9c            	rvf
5691  0ee3 be57          	ldw	x,__x_cnt
5692  0ee5 a3003d        	cpw	x,#61
5693  0ee8 2f03          	jrslt	L1562
5696  0eea 5f            	clrw	x
5697  0eeb bf57          	ldw	__x_cnt,x
5698  0eed               L1562:
5699                     ; 994 _x__=_x_;
5701  0eed be5b          	ldw	x,__x_
5702  0eef bf59          	ldw	__x__,x
5703                     ; 995 }
5706  0ef1 81            	ret
5732                     ; 998 void apv_start(void)
5732                     ; 999 {
5733                     	switch	.text
5734  0ef2               _apv_start:
5738                     ; 1000 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5740  0ef2 3d42          	tnz	_apv_cnt
5741  0ef4 2624          	jrne	L3662
5743  0ef6 3d43          	tnz	_apv_cnt+1
5744  0ef8 2620          	jrne	L3662
5746  0efa 3d44          	tnz	_apv_cnt+2
5747  0efc 261c          	jrne	L3662
5749                     	btst	_bAPV
5750  0f03 2515          	jrult	L3662
5751                     ; 1002 	apv_cnt[0]=60;
5753  0f05 353c0042      	mov	_apv_cnt,#60
5754                     ; 1003 	apv_cnt[1]=60;
5756  0f09 353c0043      	mov	_apv_cnt+1,#60
5757                     ; 1004 	apv_cnt[2]=60;
5759  0f0d 353c0044      	mov	_apv_cnt+2,#60
5760                     ; 1005 	apv_cnt_=3600;
5762  0f11 ae0e10        	ldw	x,#3600
5763  0f14 bf40          	ldw	_apv_cnt_,x
5764                     ; 1006 	bAPV=1;	
5766  0f16 72100002      	bset	_bAPV
5767  0f1a               L3662:
5768                     ; 1008 }
5771  0f1a 81            	ret
5797                     ; 1011 void apv_stop(void)
5797                     ; 1012 {
5798                     	switch	.text
5799  0f1b               _apv_stop:
5803                     ; 1013 apv_cnt[0]=0;
5805  0f1b 3f42          	clr	_apv_cnt
5806                     ; 1014 apv_cnt[1]=0;
5808  0f1d 3f43          	clr	_apv_cnt+1
5809                     ; 1015 apv_cnt[2]=0;
5811  0f1f 3f44          	clr	_apv_cnt+2
5812                     ; 1016 apv_cnt_=0;	
5814  0f21 5f            	clrw	x
5815  0f22 bf40          	ldw	_apv_cnt_,x
5816                     ; 1017 bAPV=0;
5818  0f24 72110002      	bres	_bAPV
5819                     ; 1018 }
5822  0f28 81            	ret
5857                     ; 1022 void apv_hndl(void)
5857                     ; 1023 {
5858                     	switch	.text
5859  0f29               _apv_hndl:
5863                     ; 1024 if(apv_cnt[0])
5865  0f29 3d42          	tnz	_apv_cnt
5866  0f2b 271e          	jreq	L5072
5867                     ; 1026 	apv_cnt[0]--;
5869  0f2d 3a42          	dec	_apv_cnt
5870                     ; 1027 	if(apv_cnt[0]==0)
5872  0f2f 3d42          	tnz	_apv_cnt
5873  0f31 265a          	jrne	L1172
5874                     ; 1029 		flags&=0b11100001;
5876  0f33 b60a          	ld	a,_flags
5877  0f35 a4e1          	and	a,#225
5878  0f37 b70a          	ld	_flags,a
5879                     ; 1030 		tsign_cnt=0;
5881  0f39 5f            	clrw	x
5882  0f3a bf4a          	ldw	_tsign_cnt,x
5883                     ; 1031 		tmax_cnt=0;
5885  0f3c 5f            	clrw	x
5886  0f3d bf48          	ldw	_tmax_cnt,x
5887                     ; 1032 		umax_cnt=0;
5889  0f3f 5f            	clrw	x
5890  0f40 bf62          	ldw	_umax_cnt,x
5891                     ; 1033 		umin_cnt=0;
5893  0f42 5f            	clrw	x
5894  0f43 bf60          	ldw	_umin_cnt,x
5895                     ; 1035 		led_drv_cnt=30;
5897  0f45 351e0019      	mov	_led_drv_cnt,#30
5898  0f49 2042          	jra	L1172
5899  0f4b               L5072:
5900                     ; 1038 else if(apv_cnt[1])
5902  0f4b 3d43          	tnz	_apv_cnt+1
5903  0f4d 271e          	jreq	L3172
5904                     ; 1040 	apv_cnt[1]--;
5906  0f4f 3a43          	dec	_apv_cnt+1
5907                     ; 1041 	if(apv_cnt[1]==0)
5909  0f51 3d43          	tnz	_apv_cnt+1
5910  0f53 2638          	jrne	L1172
5911                     ; 1043 		flags&=0b11100001;
5913  0f55 b60a          	ld	a,_flags
5914  0f57 a4e1          	and	a,#225
5915  0f59 b70a          	ld	_flags,a
5916                     ; 1044 		tsign_cnt=0;
5918  0f5b 5f            	clrw	x
5919  0f5c bf4a          	ldw	_tsign_cnt,x
5920                     ; 1045 		tmax_cnt=0;
5922  0f5e 5f            	clrw	x
5923  0f5f bf48          	ldw	_tmax_cnt,x
5924                     ; 1046 		umax_cnt=0;
5926  0f61 5f            	clrw	x
5927  0f62 bf62          	ldw	_umax_cnt,x
5928                     ; 1047 		umin_cnt=0;
5930  0f64 5f            	clrw	x
5931  0f65 bf60          	ldw	_umin_cnt,x
5932                     ; 1049 		led_drv_cnt=30;
5934  0f67 351e0019      	mov	_led_drv_cnt,#30
5935  0f6b 2020          	jra	L1172
5936  0f6d               L3172:
5937                     ; 1052 else if(apv_cnt[2])
5939  0f6d 3d44          	tnz	_apv_cnt+2
5940  0f6f 271c          	jreq	L1172
5941                     ; 1054 	apv_cnt[2]--;
5943  0f71 3a44          	dec	_apv_cnt+2
5944                     ; 1055 	if(apv_cnt[2]==0)
5946  0f73 3d44          	tnz	_apv_cnt+2
5947  0f75 2616          	jrne	L1172
5948                     ; 1057 		flags&=0b11100001;
5950  0f77 b60a          	ld	a,_flags
5951  0f79 a4e1          	and	a,#225
5952  0f7b b70a          	ld	_flags,a
5953                     ; 1058 		tsign_cnt=0;
5955  0f7d 5f            	clrw	x
5956  0f7e bf4a          	ldw	_tsign_cnt,x
5957                     ; 1059 		tmax_cnt=0;
5959  0f80 5f            	clrw	x
5960  0f81 bf48          	ldw	_tmax_cnt,x
5961                     ; 1060 		umax_cnt=0;
5963  0f83 5f            	clrw	x
5964  0f84 bf62          	ldw	_umax_cnt,x
5965                     ; 1061 		umin_cnt=0;          
5967  0f86 5f            	clrw	x
5968  0f87 bf60          	ldw	_umin_cnt,x
5969                     ; 1063 		led_drv_cnt=30;
5971  0f89 351e0019      	mov	_led_drv_cnt,#30
5972  0f8d               L1172:
5973                     ; 1067 if(apv_cnt_)
5975  0f8d be40          	ldw	x,_apv_cnt_
5976  0f8f 2712          	jreq	L5272
5977                     ; 1069 	apv_cnt_--;
5979  0f91 be40          	ldw	x,_apv_cnt_
5980  0f93 1d0001        	subw	x,#1
5981  0f96 bf40          	ldw	_apv_cnt_,x
5982                     ; 1070 	if(apv_cnt_==0) 
5984  0f98 be40          	ldw	x,_apv_cnt_
5985  0f9a 2607          	jrne	L5272
5986                     ; 1072 		bAPV=0;
5988  0f9c 72110002      	bres	_bAPV
5989                     ; 1073 		apv_start();
5991  0fa0 cd0ef2        	call	_apv_start
5993  0fa3               L5272:
5994                     ; 1077 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5996  0fa3 be60          	ldw	x,_umin_cnt
5997  0fa5 261e          	jrne	L1372
5999  0fa7 be62          	ldw	x,_umax_cnt
6000  0fa9 261a          	jrne	L1372
6002  0fab c65005        	ld	a,20485
6003  0fae a504          	bcp	a,#4
6004  0fb0 2613          	jrne	L1372
6005                     ; 1079 	if(cnt_apv_off<20)
6007  0fb2 b63f          	ld	a,_cnt_apv_off
6008  0fb4 a114          	cp	a,#20
6009  0fb6 240f          	jruge	L7372
6010                     ; 1081 		cnt_apv_off++;
6012  0fb8 3c3f          	inc	_cnt_apv_off
6013                     ; 1082 		if(cnt_apv_off>=20)
6015  0fba b63f          	ld	a,_cnt_apv_off
6016  0fbc a114          	cp	a,#20
6017  0fbe 2507          	jrult	L7372
6018                     ; 1084 			apv_stop();
6020  0fc0 cd0f1b        	call	_apv_stop
6022  0fc3 2002          	jra	L7372
6023  0fc5               L1372:
6024                     ; 1088 else cnt_apv_off=0;	
6026  0fc5 3f3f          	clr	_cnt_apv_off
6027  0fc7               L7372:
6028                     ; 1090 }
6031  0fc7 81            	ret
6034                     	switch	.ubsct
6035  0000               L1472_flags_old:
6036  0000 00            	ds.b	1
6072                     ; 1093 void flags_drv(void)
6072                     ; 1094 {
6073                     	switch	.text
6074  0fc8               _flags_drv:
6078                     ; 1096 if(jp_mode!=jp3) 
6080  0fc8 b647          	ld	a,_jp_mode
6081  0fca a103          	cp	a,#3
6082  0fcc 2723          	jreq	L1672
6083                     ; 1098 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
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
6102                     ; 1100     		if(link==OFF)apv_start();
6104  0fe6 b65f          	ld	a,_link
6105  0fe8 a1aa          	cp	a,#170
6106  0fea 261a          	jrne	L3772
6109  0fec cd0ef2        	call	_apv_start
6111  0fef 2015          	jra	L3772
6112  0ff1               L1672:
6113                     ; 1103 else if(jp_mode==jp3) 
6115  0ff1 b647          	ld	a,_jp_mode
6116  0ff3 a103          	cp	a,#3
6117  0ff5 260f          	jrne	L3772
6118                     ; 1105 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6120  0ff7 b60a          	ld	a,_flags
6121  0ff9 a508          	bcp	a,#8
6122  0ffb 2709          	jreq	L3772
6124  0ffd b600          	ld	a,L1472_flags_old
6125  0fff a508          	bcp	a,#8
6126  1001 2603          	jrne	L3772
6127                     ; 1107     		apv_start();
6129  1003 cd0ef2        	call	_apv_start
6131  1006               L3772:
6132                     ; 1110 flags_old=flags;
6134  1006 450a00        	mov	L1472_flags_old,_flags
6135                     ; 1112 } 
6138  1009 81            	ret
6172                     ; 1251 char adr_gran(signed short in)
6172                     ; 1252 {
6173                     	switch	.text
6174  100a               _adr_gran:
6176  100a 89            	pushw	x
6177       00000000      OFST:	set	0
6180                     ; 1253 if(in>800)return 1;
6182  100b 9c            	rvf
6183  100c a30321        	cpw	x,#801
6184  100f 2f04          	jrslt	L7103
6187  1011 a601          	ld	a,#1
6189  1013 2011          	jra	L421
6190  1015               L7103:
6191                     ; 1254 else if((in>60)&&(in<150))return 0;
6193  1015 9c            	rvf
6194  1016 1e01          	ldw	x,(OFST+1,sp)
6195  1018 a3003d        	cpw	x,#61
6196  101b 2f0b          	jrslt	L3203
6198  101d 9c            	rvf
6199  101e 1e01          	ldw	x,(OFST+1,sp)
6200  1020 a30096        	cpw	x,#150
6201  1023 2e03          	jrsge	L3203
6204  1025 4f            	clr	a
6206  1026               L421:
6208  1026 85            	popw	x
6209  1027 81            	ret
6210  1028               L3203:
6211                     ; 1255 else return 100;
6213  1028 a664          	ld	a,#100
6215  102a 20fa          	jra	L421
6244                     ; 1259 void adr_drv_v3(void)
6244                     ; 1260 {
6245                     	switch	.text
6246  102c               _adr_drv_v3:
6248  102c 88            	push	a
6249       00000001      OFST:	set	1
6252                     ; 1266 GPIOB->DDR&=~(1<<0);
6254  102d 72115007      	bres	20487,#0
6255                     ; 1267 GPIOB->CR1&=~(1<<0);
6257  1031 72115008      	bres	20488,#0
6258                     ; 1268 GPIOB->CR2&=~(1<<0);
6260  1035 72115009      	bres	20489,#0
6261                     ; 1269 ADC2->CR2=0x08;
6263  1039 35085402      	mov	21506,#8
6264                     ; 1270 ADC2->CR1=0x40;
6266  103d 35405401      	mov	21505,#64
6267                     ; 1271 ADC2->CSR=0x20+0;
6269  1041 35205400      	mov	21504,#32
6270                     ; 1272 ADC2->CR1|=1;
6272  1045 72105401      	bset	21505,#0
6273                     ; 1273 ADC2->CR1|=1;
6275  1049 72105401      	bset	21505,#0
6276                     ; 1274 adr_drv_stat=1;
6278  104d 35010007      	mov	_adr_drv_stat,#1
6279  1051               L7303:
6280                     ; 1275 while(adr_drv_stat==1);
6283  1051 b607          	ld	a,_adr_drv_stat
6284  1053 a101          	cp	a,#1
6285  1055 27fa          	jreq	L7303
6286                     ; 1277 GPIOB->DDR&=~(1<<1);
6288  1057 72135007      	bres	20487,#1
6289                     ; 1278 GPIOB->CR1&=~(1<<1);
6291  105b 72135008      	bres	20488,#1
6292                     ; 1279 GPIOB->CR2&=~(1<<1);
6294  105f 72135009      	bres	20489,#1
6295                     ; 1280 ADC2->CR2=0x08;
6297  1063 35085402      	mov	21506,#8
6298                     ; 1281 ADC2->CR1=0x40;
6300  1067 35405401      	mov	21505,#64
6301                     ; 1282 ADC2->CSR=0x20+1;
6303  106b 35215400      	mov	21504,#33
6304                     ; 1283 ADC2->CR1|=1;
6306  106f 72105401      	bset	21505,#0
6307                     ; 1284 ADC2->CR1|=1;
6309  1073 72105401      	bset	21505,#0
6310                     ; 1285 adr_drv_stat=3;
6312  1077 35030007      	mov	_adr_drv_stat,#3
6313  107b               L5403:
6314                     ; 1286 while(adr_drv_stat==3);
6317  107b b607          	ld	a,_adr_drv_stat
6318  107d a103          	cp	a,#3
6319  107f 27fa          	jreq	L5403
6320                     ; 1288 GPIOE->DDR&=~(1<<6);
6322  1081 721d5016      	bres	20502,#6
6323                     ; 1289 GPIOE->CR1&=~(1<<6);
6325  1085 721d5017      	bres	20503,#6
6326                     ; 1290 GPIOE->CR2&=~(1<<6);
6328  1089 721d5018      	bres	20504,#6
6329                     ; 1291 ADC2->CR2=0x08;
6331  108d 35085402      	mov	21506,#8
6332                     ; 1292 ADC2->CR1=0x40;
6334  1091 35405401      	mov	21505,#64
6335                     ; 1293 ADC2->CSR=0x20+9;
6337  1095 35295400      	mov	21504,#41
6338                     ; 1294 ADC2->CR1|=1;
6340  1099 72105401      	bset	21505,#0
6341                     ; 1295 ADC2->CR1|=1;
6343  109d 72105401      	bset	21505,#0
6344                     ; 1296 adr_drv_stat=5;
6346  10a1 35050007      	mov	_adr_drv_stat,#5
6347  10a5               L3503:
6348                     ; 1297 while(adr_drv_stat==5);
6351  10a5 b607          	ld	a,_adr_drv_stat
6352  10a7 a105          	cp	a,#5
6353  10a9 27fa          	jreq	L3503
6354                     ; 1301 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
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
6371                     ; 1302 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
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
6388                     ; 1303 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
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
6405                     ; 1304 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
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
6422                     ; 1305 else adr[0]=5;
6424  110b 35050002      	mov	_adr,#5
6425  110f               L3603:
6426                     ; 1307 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
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
6443                     ; 1308 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
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
6460                     ; 1309 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
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
6477                     ; 1310 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
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
6494                     ; 1311 else adr[1]=5;
6496  116f 35050003      	mov	_adr+1,#5
6497  1173               L3013:
6498                     ; 1313 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
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
6515                     ; 1314 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
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
6532                     ; 1315 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
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
6549                     ; 1316 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
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
6566                     ; 1317 else adr[2]=5;
6568  11d3 35050004      	mov	_adr+2,#5
6569  11d7               L3213:
6570                     ; 1321 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
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
6584                     ; 1324 	adress_error=1;
6586  11ec 35010000      	mov	_adress_error,#1
6588  11f0               L7413:
6589                     ; 1335 }
6592  11f0 84            	pop	a
6593  11f1 81            	ret
6594  11f2               L1413:
6595                     ; 1328 	if(adr[2]&0x02) bps_class=bpsIPS;
6597  11f2 c60004        	ld	a,_adr+2
6598  11f5 a502          	bcp	a,#2
6599  11f7 2706          	jreq	L1513
6602  11f9 35010001      	mov	_bps_class,#1
6604  11fd 2002          	jra	L3513
6605  11ff               L1513:
6606                     ; 1329 	else bps_class=bpsIBEP;
6608  11ff 3f01          	clr	_bps_class
6609  1201               L3513:
6610                     ; 1331 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
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
6684                     ; 1339 void adr_drv_v4(void)
6684                     ; 1340 {
6685                     	switch	.text
6686  121c               _adr_drv_v4:
6688  121c 5209          	subw	sp,#9
6689       00000009      OFST:	set	9
6692                     ; 1350 GPIOB->DDR&=~(1<<0);
6694  121e 72115007      	bres	20487,#0
6695                     ; 1351 GPIOB->CR1&=~(1<<0);
6697  1222 72115008      	bres	20488,#0
6698                     ; 1352 GPIOB->CR2&=~(1<<0);
6700  1226 72115009      	bres	20489,#0
6701                     ; 1353 ADC2->CR2=0x08;
6703  122a 35085402      	mov	21506,#8
6704                     ; 1354 ADC2->CR1=0x40;
6706  122e 35405401      	mov	21505,#64
6707                     ; 1355 ADC2->CSR=0x20+0;
6709  1232 35205400      	mov	21504,#32
6710                     ; 1356 ADC2->CR1|=1;
6712  1236 72105401      	bset	21505,#0
6713                     ; 1357 ADC2->CR1|=1;
6715  123a 72105401      	bset	21505,#0
6716                     ; 1358 adr_drv_stat=1;
6718  123e 35010007      	mov	_adr_drv_stat,#1
6719  1242               L3023:
6720                     ; 1359 while(adr_drv_stat==1);
6723  1242 b607          	ld	a,_adr_drv_stat
6724  1244 a101          	cp	a,#1
6725  1246 27fa          	jreq	L3023
6726                     ; 1361 GPIOB->DDR&=~(1<<1);
6728  1248 72135007      	bres	20487,#1
6729                     ; 1362 GPIOB->CR1&=~(1<<1);
6731  124c 72135008      	bres	20488,#1
6732                     ; 1363 GPIOB->CR2&=~(1<<1);
6734  1250 72135009      	bres	20489,#1
6735                     ; 1364 ADC2->CR2=0x08;
6737  1254 35085402      	mov	21506,#8
6738                     ; 1365 ADC2->CR1=0x40;
6740  1258 35405401      	mov	21505,#64
6741                     ; 1366 ADC2->CSR=0x20+1;
6743  125c 35215400      	mov	21504,#33
6744                     ; 1367 ADC2->CR1|=1;
6746  1260 72105401      	bset	21505,#0
6747                     ; 1368 ADC2->CR1|=1;
6749  1264 72105401      	bset	21505,#0
6750                     ; 1369 adr_drv_stat=3;
6752  1268 35030007      	mov	_adr_drv_stat,#3
6753  126c               L1123:
6754                     ; 1370 while(adr_drv_stat==3);
6757  126c b607          	ld	a,_adr_drv_stat
6758  126e a103          	cp	a,#3
6759  1270 27fa          	jreq	L1123
6760                     ; 1372 GPIOE->DDR&=~(1<<6);
6762  1272 721d5016      	bres	20502,#6
6763                     ; 1373 GPIOE->CR1&=~(1<<6);
6765  1276 721d5017      	bres	20503,#6
6766                     ; 1374 GPIOE->CR2&=~(1<<6);
6768  127a 721d5018      	bres	20504,#6
6769                     ; 1375 ADC2->CR2=0x08;
6771  127e 35085402      	mov	21506,#8
6772                     ; 1376 ADC2->CR1=0x40;
6774  1282 35405401      	mov	21505,#64
6775                     ; 1377 ADC2->CSR=0x20+9;
6777  1286 35295400      	mov	21504,#41
6778                     ; 1378 ADC2->CR1|=1;
6780  128a 72105401      	bset	21505,#0
6781                     ; 1379 ADC2->CR1|=1;
6783  128e 72105401      	bset	21505,#0
6784                     ; 1380 adr_drv_stat=5;
6786  1292 35050007      	mov	_adr_drv_stat,#5
6787  1296               L7123:
6788                     ; 1381 while(adr_drv_stat==5);
6791  1296 b607          	ld	a,_adr_drv_stat
6792  1298 a105          	cp	a,#5
6793  129a 27fa          	jreq	L7123
6794                     ; 1383 aaa[0]=adr_gran(adc_buff_[0]);
6796  129c ce0005        	ldw	x,_adc_buff_
6797  129f cd100a        	call	_adr_gran
6799  12a2 6b07          	ld	(OFST-2,sp),a
6800                     ; 1384 tempSI=adc_buff_[0]/260;
6802  12a4 ce0005        	ldw	x,_adc_buff_
6803  12a7 90ae0104      	ldw	y,#260
6804  12ab cd0000        	call	c_idiv
6806  12ae 1f05          	ldw	(OFST-4,sp),x
6807                     ; 1385 gran(&tempSI,0,3);
6809  12b0 ae0003        	ldw	x,#3
6810  12b3 89            	pushw	x
6811  12b4 5f            	clrw	x
6812  12b5 89            	pushw	x
6813  12b6 96            	ldw	x,sp
6814  12b7 1c0009        	addw	x,#OFST+0
6815  12ba cd0000        	call	_gran
6817  12bd 5b04          	addw	sp,#4
6818                     ; 1386 aaaa[0]=(char)tempSI;
6820  12bf 7b06          	ld	a,(OFST-3,sp)
6821  12c1 6b02          	ld	(OFST-7,sp),a
6822                     ; 1388 aaa[1]=adr_gran(adc_buff_[1]);
6824  12c3 ce0007        	ldw	x,_adc_buff_+2
6825  12c6 cd100a        	call	_adr_gran
6827  12c9 6b08          	ld	(OFST-1,sp),a
6828                     ; 1389 tempSI=adc_buff_[1]/260;
6830  12cb ce0007        	ldw	x,_adc_buff_+2
6831  12ce 90ae0104      	ldw	y,#260
6832  12d2 cd0000        	call	c_idiv
6834  12d5 1f05          	ldw	(OFST-4,sp),x
6835                     ; 1390 gran(&tempSI,0,3);
6837  12d7 ae0003        	ldw	x,#3
6838  12da 89            	pushw	x
6839  12db 5f            	clrw	x
6840  12dc 89            	pushw	x
6841  12dd 96            	ldw	x,sp
6842  12de 1c0009        	addw	x,#OFST+0
6843  12e1 cd0000        	call	_gran
6845  12e4 5b04          	addw	sp,#4
6846                     ; 1391 aaaa[1]=(char)tempSI;
6848  12e6 7b06          	ld	a,(OFST-3,sp)
6849  12e8 6b03          	ld	(OFST-6,sp),a
6850                     ; 1393 aaa[2]=adr_gran(adc_buff_[9]);
6852  12ea ce0017        	ldw	x,_adc_buff_+18
6853  12ed cd100a        	call	_adr_gran
6855  12f0 6b09          	ld	(OFST+0,sp),a
6856                     ; 1394 tempSI=adc_buff_[2]/260;
6858  12f2 ce0009        	ldw	x,_adc_buff_+4
6859  12f5 90ae0104      	ldw	y,#260
6860  12f9 cd0000        	call	c_idiv
6862  12fc 1f05          	ldw	(OFST-4,sp),x
6863                     ; 1395 gran(&tempSI,0,3);
6865  12fe ae0003        	ldw	x,#3
6866  1301 89            	pushw	x
6867  1302 5f            	clrw	x
6868  1303 89            	pushw	x
6869  1304 96            	ldw	x,sp
6870  1305 1c0009        	addw	x,#OFST+0
6871  1308 cd0000        	call	_gran
6873  130b 5b04          	addw	sp,#4
6874                     ; 1396 aaaa[2]=(char)tempSI;
6876  130d 7b06          	ld	a,(OFST-3,sp)
6877  130f 6b04          	ld	(OFST-5,sp),a
6878                     ; 1399 adress=100;
6880  1311 35640001      	mov	_adress,#100
6881                     ; 1402 if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
6883  1315 7b07          	ld	a,(OFST-2,sp)
6884  1317 a164          	cp	a,#100
6885  1319 2734          	jreq	L5223
6887  131b 7b08          	ld	a,(OFST-1,sp)
6888  131d a164          	cp	a,#100
6889  131f 272e          	jreq	L5223
6891  1321 7b09          	ld	a,(OFST+0,sp)
6892  1323 a164          	cp	a,#100
6893  1325 2728          	jreq	L5223
6894                     ; 1404 	if(aaa[0]==0)
6896  1327 0d07          	tnz	(OFST-2,sp)
6897  1329 2610          	jrne	L7223
6898                     ; 1406 		if(aaa[1]==0)adress=3;
6900  132b 0d08          	tnz	(OFST-1,sp)
6901  132d 2606          	jrne	L1323
6904  132f 35030001      	mov	_adress,#3
6906  1333 2046          	jra	L5423
6907  1335               L1323:
6908                     ; 1407 		else adress=0;
6910  1335 725f0001      	clr	_adress
6911  1339 2040          	jra	L5423
6912  133b               L7223:
6913                     ; 1409 	else if(aaa[1]==0)adress=1;	
6915  133b 0d08          	tnz	(OFST-1,sp)
6916  133d 2606          	jrne	L7323
6919  133f 35010001      	mov	_adress,#1
6921  1343 2036          	jra	L5423
6922  1345               L7323:
6923                     ; 1410 	else if(aaa[2]==0)adress=2;
6925  1345 0d09          	tnz	(OFST+0,sp)
6926  1347 2632          	jrne	L5423
6929  1349 35020001      	mov	_adress,#2
6930  134d 202c          	jra	L5423
6931  134f               L5223:
6932                     ; 1414 else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adress=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
6934  134f 7b07          	ld	a,(OFST-2,sp)
6935  1351 a164          	cp	a,#100
6936  1353 2622          	jrne	L7423
6938  1355 7b08          	ld	a,(OFST-1,sp)
6939  1357 a164          	cp	a,#100
6940  1359 261c          	jrne	L7423
6942  135b 7b09          	ld	a,(OFST+0,sp)
6943  135d a164          	cp	a,#100
6944  135f 2616          	jrne	L7423
6947  1361 7b04          	ld	a,(OFST-5,sp)
6948  1363 97            	ld	xl,a
6949  1364 a610          	ld	a,#16
6950  1366 42            	mul	x,a
6951  1367 9f            	ld	a,xl
6952  1368 6b01          	ld	(OFST-8,sp),a
6953  136a 7b03          	ld	a,(OFST-6,sp)
6954  136c 48            	sll	a
6955  136d 48            	sll	a
6956  136e 1b02          	add	a,(OFST-7,sp)
6957  1370 1b01          	add	a,(OFST-8,sp)
6958  1372 c70001        	ld	_adress,a
6960  1375 2004          	jra	L5423
6961  1377               L7423:
6962                     ; 1418 else adress=100;
6964  1377 35640001      	mov	_adress,#100
6965  137b               L5423:
6966                     ; 1420 }
6969  137b 5b09          	addw	sp,#9
6970  137d 81            	ret
7014                     ; 1424 void volum_u_main_drv(void)
7014                     ; 1425 {
7015                     	switch	.text
7016  137e               _volum_u_main_drv:
7018  137e 88            	push	a
7019       00000001      OFST:	set	1
7022                     ; 1428 if(bMAIN)
7024                     	btst	_bMAIN
7025  1384 2503          	jrult	L431
7026  1386 cc14cf        	jp	L1723
7027  1389               L431:
7028                     ; 1430 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7030  1389 9c            	rvf
7031  138a ce0006        	ldw	x,_UU_AVT
7032  138d 1d000a        	subw	x,#10
7033  1390 b369          	cpw	x,_Un
7034  1392 2d09          	jrsle	L3723
7037  1394 be1c          	ldw	x,_volum_u_main_
7038  1396 1c0005        	addw	x,#5
7039  1399 bf1c          	ldw	_volum_u_main_,x
7041  139b 2036          	jra	L5723
7042  139d               L3723:
7043                     ; 1431 	else if(Un<(UU_AVT-1))volum_u_main_++;
7045  139d 9c            	rvf
7046  139e ce0006        	ldw	x,_UU_AVT
7047  13a1 5a            	decw	x
7048  13a2 b369          	cpw	x,_Un
7049  13a4 2d09          	jrsle	L7723
7052  13a6 be1c          	ldw	x,_volum_u_main_
7053  13a8 1c0001        	addw	x,#1
7054  13ab bf1c          	ldw	_volum_u_main_,x
7056  13ad 2024          	jra	L5723
7057  13af               L7723:
7058                     ; 1432 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7060  13af 9c            	rvf
7061  13b0 ce0006        	ldw	x,_UU_AVT
7062  13b3 1c000a        	addw	x,#10
7063  13b6 b369          	cpw	x,_Un
7064  13b8 2e09          	jrsge	L3033
7067  13ba be1c          	ldw	x,_volum_u_main_
7068  13bc 1d000a        	subw	x,#10
7069  13bf bf1c          	ldw	_volum_u_main_,x
7071  13c1 2010          	jra	L5723
7072  13c3               L3033:
7073                     ; 1433 	else if(Un>(UU_AVT+1))volum_u_main_--;
7075  13c3 9c            	rvf
7076  13c4 ce0006        	ldw	x,_UU_AVT
7077  13c7 5c            	incw	x
7078  13c8 b369          	cpw	x,_Un
7079  13ca 2e07          	jrsge	L5723
7082  13cc be1c          	ldw	x,_volum_u_main_
7083  13ce 1d0001        	subw	x,#1
7084  13d1 bf1c          	ldw	_volum_u_main_,x
7085  13d3               L5723:
7086                     ; 1434 	if(volum_u_main_>1020)volum_u_main_=1020;
7088  13d3 9c            	rvf
7089  13d4 be1c          	ldw	x,_volum_u_main_
7090  13d6 a303fd        	cpw	x,#1021
7091  13d9 2f05          	jrslt	L1133
7094  13db ae03fc        	ldw	x,#1020
7095  13de bf1c          	ldw	_volum_u_main_,x
7096  13e0               L1133:
7097                     ; 1435 	if(volum_u_main_<0)volum_u_main_=0;
7099  13e0 9c            	rvf
7100  13e1 be1c          	ldw	x,_volum_u_main_
7101  13e3 2e03          	jrsge	L3133
7104  13e5 5f            	clrw	x
7105  13e6 bf1c          	ldw	_volum_u_main_,x
7106  13e8               L3133:
7107                     ; 1438 	i_main_sigma=0;
7109  13e8 5f            	clrw	x
7110  13e9 bf0c          	ldw	_i_main_sigma,x
7111                     ; 1439 	i_main_num_of_bps=0;
7113  13eb 3f0e          	clr	_i_main_num_of_bps
7114                     ; 1440 	for(i=0;i<6;i++)
7116  13ed 0f01          	clr	(OFST+0,sp)
7117  13ef               L5133:
7118                     ; 1442 		if(i_main_flag[i])
7120  13ef 7b01          	ld	a,(OFST+0,sp)
7121  13f1 5f            	clrw	x
7122  13f2 97            	ld	xl,a
7123  13f3 6d11          	tnz	(_i_main_flag,x)
7124  13f5 2719          	jreq	L3233
7125                     ; 1444 			i_main_sigma+=i_main[i];
7127  13f7 7b01          	ld	a,(OFST+0,sp)
7128  13f9 5f            	clrw	x
7129  13fa 97            	ld	xl,a
7130  13fb 58            	sllw	x
7131  13fc ee17          	ldw	x,(_i_main,x)
7132  13fe 72bb000c      	addw	x,_i_main_sigma
7133  1402 bf0c          	ldw	_i_main_sigma,x
7134                     ; 1445 			i_main_flag[i]=1;
7136  1404 7b01          	ld	a,(OFST+0,sp)
7137  1406 5f            	clrw	x
7138  1407 97            	ld	xl,a
7139  1408 a601          	ld	a,#1
7140  140a e711          	ld	(_i_main_flag,x),a
7141                     ; 1446 			i_main_num_of_bps++;
7143  140c 3c0e          	inc	_i_main_num_of_bps
7145  140e 2006          	jra	L5233
7146  1410               L3233:
7147                     ; 1450 			i_main_flag[i]=0;	
7149  1410 7b01          	ld	a,(OFST+0,sp)
7150  1412 5f            	clrw	x
7151  1413 97            	ld	xl,a
7152  1414 6f11          	clr	(_i_main_flag,x)
7153  1416               L5233:
7154                     ; 1440 	for(i=0;i<6;i++)
7156  1416 0c01          	inc	(OFST+0,sp)
7159  1418 7b01          	ld	a,(OFST+0,sp)
7160  141a a106          	cp	a,#6
7161  141c 25d1          	jrult	L5133
7162                     ; 1453 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7164  141e be0c          	ldw	x,_i_main_sigma
7165  1420 b60e          	ld	a,_i_main_num_of_bps
7166  1422 905f          	clrw	y
7167  1424 9097          	ld	yl,a
7168  1426 cd0000        	call	c_idiv
7170  1429 bf0f          	ldw	_i_main_avg,x
7171                     ; 1454 	for(i=0;i<6;i++)
7173  142b 0f01          	clr	(OFST+0,sp)
7174  142d               L7233:
7175                     ; 1456 		if(i_main_flag[i])
7177  142d 7b01          	ld	a,(OFST+0,sp)
7178  142f 5f            	clrw	x
7179  1430 97            	ld	xl,a
7180  1431 6d11          	tnz	(_i_main_flag,x)
7181  1433 2603cc14c4    	jreq	L5333
7182                     ; 1458 			if(i_main[i]<(i_main_avg-10))x[i]++;
7184  1438 9c            	rvf
7185  1439 7b01          	ld	a,(OFST+0,sp)
7186  143b 5f            	clrw	x
7187  143c 97            	ld	xl,a
7188  143d 58            	sllw	x
7189  143e 90be0f        	ldw	y,_i_main_avg
7190  1441 72a2000a      	subw	y,#10
7191  1445 90bf00        	ldw	c_y,y
7192  1448 9093          	ldw	y,x
7193  144a 90ee17        	ldw	y,(_i_main,y)
7194  144d 90b300        	cpw	y,c_y
7195  1450 2e11          	jrsge	L7333
7198  1452 7b01          	ld	a,(OFST+0,sp)
7199  1454 5f            	clrw	x
7200  1455 97            	ld	xl,a
7201  1456 58            	sllw	x
7202  1457 9093          	ldw	y,x
7203  1459 ee23          	ldw	x,(_x,x)
7204  145b 1c0001        	addw	x,#1
7205  145e 90ef23        	ldw	(_x,y),x
7207  1461 2029          	jra	L1433
7208  1463               L7333:
7209                     ; 1459 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7211  1463 9c            	rvf
7212  1464 7b01          	ld	a,(OFST+0,sp)
7213  1466 5f            	clrw	x
7214  1467 97            	ld	xl,a
7215  1468 58            	sllw	x
7216  1469 90be0f        	ldw	y,_i_main_avg
7217  146c 72a9000a      	addw	y,#10
7218  1470 90bf00        	ldw	c_y,y
7219  1473 9093          	ldw	y,x
7220  1475 90ee17        	ldw	y,(_i_main,y)
7221  1478 90b300        	cpw	y,c_y
7222  147b 2d0f          	jrsle	L1433
7225  147d 7b01          	ld	a,(OFST+0,sp)
7226  147f 5f            	clrw	x
7227  1480 97            	ld	xl,a
7228  1481 58            	sllw	x
7229  1482 9093          	ldw	y,x
7230  1484 ee23          	ldw	x,(_x,x)
7231  1486 1d0001        	subw	x,#1
7232  1489 90ef23        	ldw	(_x,y),x
7233  148c               L1433:
7234                     ; 1460 			if(x[i]>100)x[i]=100;
7236  148c 9c            	rvf
7237  148d 7b01          	ld	a,(OFST+0,sp)
7238  148f 5f            	clrw	x
7239  1490 97            	ld	xl,a
7240  1491 58            	sllw	x
7241  1492 9093          	ldw	y,x
7242  1494 90ee23        	ldw	y,(_x,y)
7243  1497 90a30065      	cpw	y,#101
7244  149b 2f0b          	jrslt	L5433
7247  149d 7b01          	ld	a,(OFST+0,sp)
7248  149f 5f            	clrw	x
7249  14a0 97            	ld	xl,a
7250  14a1 58            	sllw	x
7251  14a2 90ae0064      	ldw	y,#100
7252  14a6 ef23          	ldw	(_x,x),y
7253  14a8               L5433:
7254                     ; 1461 			if(x[i]<-100)x[i]=-100;
7256  14a8 9c            	rvf
7257  14a9 7b01          	ld	a,(OFST+0,sp)
7258  14ab 5f            	clrw	x
7259  14ac 97            	ld	xl,a
7260  14ad 58            	sllw	x
7261  14ae 9093          	ldw	y,x
7262  14b0 90ee23        	ldw	y,(_x,y)
7263  14b3 90a3ff9c      	cpw	y,#65436
7264  14b7 2e0b          	jrsge	L5333
7267  14b9 7b01          	ld	a,(OFST+0,sp)
7268  14bb 5f            	clrw	x
7269  14bc 97            	ld	xl,a
7270  14bd 58            	sllw	x
7271  14be 90aeff9c      	ldw	y,#65436
7272  14c2 ef23          	ldw	(_x,x),y
7273  14c4               L5333:
7274                     ; 1454 	for(i=0;i<6;i++)
7276  14c4 0c01          	inc	(OFST+0,sp)
7279  14c6 7b01          	ld	a,(OFST+0,sp)
7280  14c8 a106          	cp	a,#6
7281  14ca 2403cc142d    	jrult	L7233
7282  14cf               L1723:
7283                     ; 1468 }
7286  14cf 84            	pop	a
7287  14d0 81            	ret
7310                     ; 1471 void init_CAN(void) {
7311                     	switch	.text
7312  14d1               _init_CAN:
7316                     ; 1472 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7318  14d1 72135420      	bres	21536,#1
7319                     ; 1473 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7321  14d5 72105420      	bset	21536,#0
7323  14d9               L3633:
7324                     ; 1474 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7326  14d9 c65421        	ld	a,21537
7327  14dc a501          	bcp	a,#1
7328  14de 27f9          	jreq	L3633
7329                     ; 1476 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7331  14e0 72185420      	bset	21536,#4
7332                     ; 1478 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7334  14e4 35025427      	mov	21543,#2
7335                     ; 1487 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7337  14e8 35135428      	mov	21544,#19
7338                     ; 1488 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7340  14ec 35c05429      	mov	21545,#192
7341                     ; 1489 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7343  14f0 357f542c      	mov	21548,#127
7344                     ; 1490 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7346  14f4 35e0542d      	mov	21549,#224
7347                     ; 1492 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7349  14f8 35315430      	mov	21552,#49
7350                     ; 1493 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7352  14fc 35c05431      	mov	21553,#192
7353                     ; 1494 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7355  1500 357f5434      	mov	21556,#127
7356                     ; 1495 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7358  1504 35e05435      	mov	21557,#224
7359                     ; 1499 	CAN->PSR= 6;									// set page 6
7361  1508 35065427      	mov	21543,#6
7362                     ; 1504 	CAN->Page.Config.FMR1&=~3;								//mask mode
7364  150c c65430        	ld	a,21552
7365  150f a4fc          	and	a,#252
7366  1511 c75430        	ld	21552,a
7367                     ; 1510 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7369  1514 35065432      	mov	21554,#6
7370                     ; 1511 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7372  1518 35605432      	mov	21554,#96
7373                     ; 1514 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7375  151c 72105432      	bset	21554,#0
7376                     ; 1515 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7378  1520 72185432      	bset	21554,#4
7379                     ; 1518 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7381  1524 35065427      	mov	21543,#6
7382                     ; 1520 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7384  1528 3509542c      	mov	21548,#9
7385                     ; 1521 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7387  152c 35e7542d      	mov	21549,#231
7388                     ; 1523 	CAN->IER|=(1<<1);
7390  1530 72125425      	bset	21541,#1
7391                     ; 1526 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7393  1534 72115420      	bres	21536,#0
7395  1538               L1733:
7396                     ; 1527 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7398  1538 c65421        	ld	a,21537
7399  153b a501          	bcp	a,#1
7400  153d 26f9          	jrne	L1733
7401                     ; 1528 }
7404  153f 81            	ret
7512                     ; 1531 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7512                     ; 1532 {
7513                     	switch	.text
7514  1540               _can_transmit:
7516  1540 89            	pushw	x
7517       00000000      OFST:	set	0
7520                     ; 1534 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7522  1541 b670          	ld	a,_can_buff_wr_ptr
7523  1543 a104          	cp	a,#4
7524  1545 2502          	jrult	L3543
7527  1547 3f70          	clr	_can_buff_wr_ptr
7528  1549               L3543:
7529                     ; 1536 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7531  1549 b670          	ld	a,_can_buff_wr_ptr
7532  154b 97            	ld	xl,a
7533  154c a610          	ld	a,#16
7534  154e 42            	mul	x,a
7535  154f 1601          	ldw	y,(OFST+1,sp)
7536  1551 a606          	ld	a,#6
7537  1553               L241:
7538  1553 9054          	srlw	y
7539  1555 4a            	dec	a
7540  1556 26fb          	jrne	L241
7541  1558 909f          	ld	a,yl
7542  155a e771          	ld	(_can_out_buff,x),a
7543                     ; 1537 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7545  155c b670          	ld	a,_can_buff_wr_ptr
7546  155e 97            	ld	xl,a
7547  155f a610          	ld	a,#16
7548  1561 42            	mul	x,a
7549  1562 7b02          	ld	a,(OFST+2,sp)
7550  1564 48            	sll	a
7551  1565 48            	sll	a
7552  1566 e772          	ld	(_can_out_buff+1,x),a
7553                     ; 1539 can_out_buff[can_buff_wr_ptr][2]=data0;
7555  1568 b670          	ld	a,_can_buff_wr_ptr
7556  156a 97            	ld	xl,a
7557  156b a610          	ld	a,#16
7558  156d 42            	mul	x,a
7559  156e 7b05          	ld	a,(OFST+5,sp)
7560  1570 e773          	ld	(_can_out_buff+2,x),a
7561                     ; 1540 can_out_buff[can_buff_wr_ptr][3]=data1;
7563  1572 b670          	ld	a,_can_buff_wr_ptr
7564  1574 97            	ld	xl,a
7565  1575 a610          	ld	a,#16
7566  1577 42            	mul	x,a
7567  1578 7b06          	ld	a,(OFST+6,sp)
7568  157a e774          	ld	(_can_out_buff+3,x),a
7569                     ; 1541 can_out_buff[can_buff_wr_ptr][4]=data2;
7571  157c b670          	ld	a,_can_buff_wr_ptr
7572  157e 97            	ld	xl,a
7573  157f a610          	ld	a,#16
7574  1581 42            	mul	x,a
7575  1582 7b07          	ld	a,(OFST+7,sp)
7576  1584 e775          	ld	(_can_out_buff+4,x),a
7577                     ; 1542 can_out_buff[can_buff_wr_ptr][5]=data3;
7579  1586 b670          	ld	a,_can_buff_wr_ptr
7580  1588 97            	ld	xl,a
7581  1589 a610          	ld	a,#16
7582  158b 42            	mul	x,a
7583  158c 7b08          	ld	a,(OFST+8,sp)
7584  158e e776          	ld	(_can_out_buff+5,x),a
7585                     ; 1543 can_out_buff[can_buff_wr_ptr][6]=data4;
7587  1590 b670          	ld	a,_can_buff_wr_ptr
7588  1592 97            	ld	xl,a
7589  1593 a610          	ld	a,#16
7590  1595 42            	mul	x,a
7591  1596 7b09          	ld	a,(OFST+9,sp)
7592  1598 e777          	ld	(_can_out_buff+6,x),a
7593                     ; 1544 can_out_buff[can_buff_wr_ptr][7]=data5;
7595  159a b670          	ld	a,_can_buff_wr_ptr
7596  159c 97            	ld	xl,a
7597  159d a610          	ld	a,#16
7598  159f 42            	mul	x,a
7599  15a0 7b0a          	ld	a,(OFST+10,sp)
7600  15a2 e778          	ld	(_can_out_buff+7,x),a
7601                     ; 1545 can_out_buff[can_buff_wr_ptr][8]=data6;
7603  15a4 b670          	ld	a,_can_buff_wr_ptr
7604  15a6 97            	ld	xl,a
7605  15a7 a610          	ld	a,#16
7606  15a9 42            	mul	x,a
7607  15aa 7b0b          	ld	a,(OFST+11,sp)
7608  15ac e779          	ld	(_can_out_buff+8,x),a
7609                     ; 1546 can_out_buff[can_buff_wr_ptr][9]=data7;
7611  15ae b670          	ld	a,_can_buff_wr_ptr
7612  15b0 97            	ld	xl,a
7613  15b1 a610          	ld	a,#16
7614  15b3 42            	mul	x,a
7615  15b4 7b0c          	ld	a,(OFST+12,sp)
7616  15b6 e77a          	ld	(_can_out_buff+9,x),a
7617                     ; 1548 can_buff_wr_ptr++;
7619  15b8 3c70          	inc	_can_buff_wr_ptr
7620                     ; 1549 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7622  15ba b670          	ld	a,_can_buff_wr_ptr
7623  15bc a104          	cp	a,#4
7624  15be 2502          	jrult	L5543
7627  15c0 3f70          	clr	_can_buff_wr_ptr
7628  15c2               L5543:
7629                     ; 1550 } 
7632  15c2 85            	popw	x
7633  15c3 81            	ret
7662                     ; 1553 void can_tx_hndl(void)
7662                     ; 1554 {
7663                     	switch	.text
7664  15c4               _can_tx_hndl:
7668                     ; 1555 if(bTX_FREE)
7670  15c4 3d08          	tnz	_bTX_FREE
7671  15c6 2757          	jreq	L7643
7672                     ; 1557 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7674  15c8 b66f          	ld	a,_can_buff_rd_ptr
7675  15ca b170          	cp	a,_can_buff_wr_ptr
7676  15cc 275f          	jreq	L5743
7677                     ; 1559 		bTX_FREE=0;
7679  15ce 3f08          	clr	_bTX_FREE
7680                     ; 1561 		CAN->PSR= 0;
7682  15d0 725f5427      	clr	21543
7683                     ; 1562 		CAN->Page.TxMailbox.MDLCR=8;
7685  15d4 35085429      	mov	21545,#8
7686                     ; 1563 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7688  15d8 b66f          	ld	a,_can_buff_rd_ptr
7689  15da 97            	ld	xl,a
7690  15db a610          	ld	a,#16
7691  15dd 42            	mul	x,a
7692  15de e671          	ld	a,(_can_out_buff,x)
7693  15e0 c7542a        	ld	21546,a
7694                     ; 1564 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7696  15e3 b66f          	ld	a,_can_buff_rd_ptr
7697  15e5 97            	ld	xl,a
7698  15e6 a610          	ld	a,#16
7699  15e8 42            	mul	x,a
7700  15e9 e672          	ld	a,(_can_out_buff+1,x)
7701  15eb c7542b        	ld	21547,a
7702                     ; 1566 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7704  15ee b66f          	ld	a,_can_buff_rd_ptr
7705  15f0 97            	ld	xl,a
7706  15f1 a610          	ld	a,#16
7707  15f3 42            	mul	x,a
7708  15f4 01            	rrwa	x,a
7709  15f5 ab73          	add	a,#_can_out_buff+2
7710  15f7 2401          	jrnc	L641
7711  15f9 5c            	incw	x
7712  15fa               L641:
7713  15fa 5f            	clrw	x
7714  15fb 97            	ld	xl,a
7715  15fc bf00          	ldw	c_x,x
7716  15fe ae0008        	ldw	x,#8
7717  1601               L051:
7718  1601 5a            	decw	x
7719  1602 92d600        	ld	a,([c_x],x)
7720  1605 d7542e        	ld	(21550,x),a
7721  1608 5d            	tnzw	x
7722  1609 26f6          	jrne	L051
7723                     ; 1568 		can_buff_rd_ptr++;
7725  160b 3c6f          	inc	_can_buff_rd_ptr
7726                     ; 1569 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7728  160d b66f          	ld	a,_can_buff_rd_ptr
7729  160f a104          	cp	a,#4
7730  1611 2502          	jrult	L3743
7733  1613 3f6f          	clr	_can_buff_rd_ptr
7734  1615               L3743:
7735                     ; 1571 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7737  1615 72105428      	bset	21544,#0
7738                     ; 1572 		CAN->IER|=(1<<0);
7740  1619 72105425      	bset	21541,#0
7741  161d 200e          	jra	L5743
7742  161f               L7643:
7743                     ; 1577 	tx_busy_cnt++;
7745  161f 3c6e          	inc	_tx_busy_cnt
7746                     ; 1578 	if(tx_busy_cnt>=100)
7748  1621 b66e          	ld	a,_tx_busy_cnt
7749  1623 a164          	cp	a,#100
7750  1625 2506          	jrult	L5743
7751                     ; 1580 		tx_busy_cnt=0;
7753  1627 3f6e          	clr	_tx_busy_cnt
7754                     ; 1581 		bTX_FREE=1;
7756  1629 35010008      	mov	_bTX_FREE,#1
7757  162d               L5743:
7758                     ; 1584 }
7761  162d 81            	ret
7800                     ; 1587 void net_drv(void)
7800                     ; 1588 { 
7801                     	switch	.text
7802  162e               _net_drv:
7806                     ; 1590 if(bMAIN)
7808                     	btst	_bMAIN
7809  1633 2503          	jrult	L451
7810  1635 cc16db        	jp	L1153
7811  1638               L451:
7812                     ; 1592 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7814  1638 3c2f          	inc	_cnt_net_drv
7815  163a b62f          	ld	a,_cnt_net_drv
7816  163c a107          	cp	a,#7
7817  163e 2502          	jrult	L3153
7820  1640 3f2f          	clr	_cnt_net_drv
7821  1642               L3153:
7822                     ; 1594 	if(cnt_net_drv<=5) 
7824  1642 b62f          	ld	a,_cnt_net_drv
7825  1644 a106          	cp	a,#6
7826  1646 244c          	jruge	L5153
7827                     ; 1596 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7829  1648 4be8          	push	#232
7830  164a 4be8          	push	#232
7831  164c b62f          	ld	a,_cnt_net_drv
7832  164e 5f            	clrw	x
7833  164f 97            	ld	xl,a
7834  1650 58            	sllw	x
7835  1651 ee23          	ldw	x,(_x,x)
7836  1653 72bb001c      	addw	x,_volum_u_main_
7837  1657 90ae0100      	ldw	y,#256
7838  165b cd0000        	call	c_idiv
7840  165e 9f            	ld	a,xl
7841  165f 88            	push	a
7842  1660 b62f          	ld	a,_cnt_net_drv
7843  1662 5f            	clrw	x
7844  1663 97            	ld	xl,a
7845  1664 58            	sllw	x
7846  1665 e624          	ld	a,(_x+1,x)
7847  1667 bb1d          	add	a,_volum_u_main_+1
7848  1669 88            	push	a
7849  166a 4b00          	push	#0
7850  166c 4bed          	push	#237
7851  166e 3b002f        	push	_cnt_net_drv
7852  1671 3b002f        	push	_cnt_net_drv
7853  1674 ae009e        	ldw	x,#158
7854  1677 cd1540        	call	_can_transmit
7856  167a 5b08          	addw	sp,#8
7857                     ; 1597 		i_main_bps_cnt[cnt_net_drv]++;
7859  167c b62f          	ld	a,_cnt_net_drv
7860  167e 5f            	clrw	x
7861  167f 97            	ld	xl,a
7862  1680 6c06          	inc	(_i_main_bps_cnt,x)
7863                     ; 1598 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7865  1682 b62f          	ld	a,_cnt_net_drv
7866  1684 5f            	clrw	x
7867  1685 97            	ld	xl,a
7868  1686 e606          	ld	a,(_i_main_bps_cnt,x)
7869  1688 a10b          	cp	a,#11
7870  168a 254f          	jrult	L1153
7873  168c b62f          	ld	a,_cnt_net_drv
7874  168e 5f            	clrw	x
7875  168f 97            	ld	xl,a
7876  1690 6f11          	clr	(_i_main_flag,x)
7877  1692 2047          	jra	L1153
7878  1694               L5153:
7879                     ; 1600 	else if(cnt_net_drv==6)
7881  1694 b62f          	ld	a,_cnt_net_drv
7882  1696 a106          	cp	a,#6
7883  1698 2641          	jrne	L1153
7884                     ; 1602 		plazma_int[2]=pwm_u;
7886  169a be0b          	ldw	x,_pwm_u
7887  169c bf34          	ldw	_plazma_int+4,x
7888                     ; 1603 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7890  169e 3b0067        	push	_Ui
7891  16a1 3b0068        	push	_Ui+1
7892  16a4 3b0069        	push	_Un
7893  16a7 3b006a        	push	_Un+1
7894  16aa 3b006b        	push	_I
7895  16ad 3b006c        	push	_I+1
7896  16b0 4bda          	push	#218
7897  16b2 3b0001        	push	_adress
7898  16b5 ae018e        	ldw	x,#398
7899  16b8 cd1540        	call	_can_transmit
7901  16bb 5b08          	addw	sp,#8
7902                     ; 1604 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7904  16bd 3b0034        	push	_plazma_int+4
7905  16c0 3b0035        	push	_plazma_int+5
7906  16c3 3b005c        	push	__x_+1
7907  16c6 3b000a        	push	_flags
7908  16c9 4b00          	push	#0
7909  16cb 3b0064        	push	_T
7910  16ce 4bdb          	push	#219
7911  16d0 3b0001        	push	_adress
7912  16d3 ae018e        	ldw	x,#398
7913  16d6 cd1540        	call	_can_transmit
7915  16d9 5b08          	addw	sp,#8
7916  16db               L1153:
7917                     ; 1607 }
7920  16db 81            	ret
8030                     ; 1610 void can_in_an(void)
8030                     ; 1611 {
8031                     	switch	.text
8032  16dc               _can_in_an:
8034  16dc 5205          	subw	sp,#5
8035       00000005      OFST:	set	5
8038                     ; 1621 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8040  16de b6c6          	ld	a,_mess+6
8041  16e0 c10001        	cp	a,_adress
8042  16e3 2703          	jreq	L002
8043  16e5 cc17f2        	jp	L1653
8044  16e8               L002:
8046  16e8 b6c7          	ld	a,_mess+7
8047  16ea c10001        	cp	a,_adress
8048  16ed 2703          	jreq	L202
8049  16ef cc17f2        	jp	L1653
8050  16f2               L202:
8052  16f2 b6c8          	ld	a,_mess+8
8053  16f4 a1ed          	cp	a,#237
8054  16f6 2703          	jreq	L402
8055  16f8 cc17f2        	jp	L1653
8056  16fb               L402:
8057                     ; 1624 	can_error_cnt=0;
8059  16fb 3f6d          	clr	_can_error_cnt
8060                     ; 1626 	bMAIN=0;
8062  16fd 72110001      	bres	_bMAIN
8063                     ; 1627  	flags_tu=mess[9];
8065  1701 45c95d        	mov	_flags_tu,_mess+9
8066                     ; 1628  	if(flags_tu&0b00000001)
8068  1704 b65d          	ld	a,_flags_tu
8069  1706 a501          	bcp	a,#1
8070  1708 2706          	jreq	L3653
8071                     ; 1633  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8073  170a 721a000a      	bset	_flags,#5
8075  170e 200e          	jra	L5653
8076  1710               L3653:
8077                     ; 1644  				flags&=0b11011111; 
8079  1710 721b000a      	bres	_flags,#5
8080                     ; 1645  				off_bp_cnt=5*ee_TZAS;
8082  1714 c60015        	ld	a,_ee_TZAS+1
8083  1717 97            	ld	xl,a
8084  1718 a605          	ld	a,#5
8085  171a 42            	mul	x,a
8086  171b 9f            	ld	a,xl
8087  171c b750          	ld	_off_bp_cnt,a
8088  171e               L5653:
8089                     ; 1651  	if(flags_tu&0b00000010) flags|=0b01000000;
8091  171e b65d          	ld	a,_flags_tu
8092  1720 a502          	bcp	a,#2
8093  1722 2706          	jreq	L7653
8096  1724 721c000a      	bset	_flags,#6
8098  1728 2004          	jra	L1753
8099  172a               L7653:
8100                     ; 1652  	else flags&=0b10111111; 
8102  172a 721d000a      	bres	_flags,#6
8103  172e               L1753:
8104                     ; 1654  	vol_u_temp=mess[10]+mess[11]*256;
8106  172e b6cb          	ld	a,_mess+11
8107  1730 5f            	clrw	x
8108  1731 97            	ld	xl,a
8109  1732 4f            	clr	a
8110  1733 02            	rlwa	x,a
8111  1734 01            	rrwa	x,a
8112  1735 bbca          	add	a,_mess+10
8113  1737 2401          	jrnc	L061
8114  1739 5c            	incw	x
8115  173a               L061:
8116  173a b756          	ld	_vol_u_temp+1,a
8117  173c 9f            	ld	a,xl
8118  173d b755          	ld	_vol_u_temp,a
8119                     ; 1655  	vol_i_temp=mess[12]+mess[13]*256;  
8121  173f b6cd          	ld	a,_mess+13
8122  1741 5f            	clrw	x
8123  1742 97            	ld	xl,a
8124  1743 4f            	clr	a
8125  1744 02            	rlwa	x,a
8126  1745 01            	rrwa	x,a
8127  1746 bbcc          	add	a,_mess+12
8128  1748 2401          	jrnc	L261
8129  174a 5c            	incw	x
8130  174b               L261:
8131  174b b754          	ld	_vol_i_temp+1,a
8132  174d 9f            	ld	a,xl
8133  174e b753          	ld	_vol_i_temp,a
8134                     ; 1664 	plazma_int[2]=T;
8136  1750 5f            	clrw	x
8137  1751 b664          	ld	a,_T
8138  1753 2a01          	jrpl	L461
8139  1755 53            	cplw	x
8140  1756               L461:
8141  1756 97            	ld	xl,a
8142  1757 bf34          	ldw	_plazma_int+4,x
8143                     ; 1665  	rotor_int=flags_tu+(((short)flags)<<8);
8145  1759 b60a          	ld	a,_flags
8146  175b 5f            	clrw	x
8147  175c 97            	ld	xl,a
8148  175d 4f            	clr	a
8149  175e 02            	rlwa	x,a
8150  175f 01            	rrwa	x,a
8151  1760 bb5d          	add	a,_flags_tu
8152  1762 2401          	jrnc	L661
8153  1764 5c            	incw	x
8154  1765               L661:
8155  1765 b71b          	ld	_rotor_int+1,a
8156  1767 9f            	ld	a,xl
8157  1768 b71a          	ld	_rotor_int,a
8158                     ; 1666 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8160  176a 3b0067        	push	_Ui
8161  176d 3b0068        	push	_Ui+1
8162  1770 3b0069        	push	_Un
8163  1773 3b006a        	push	_Un+1
8164  1776 3b006b        	push	_I
8165  1779 3b006c        	push	_I+1
8166  177c 4bda          	push	#218
8167  177e 3b0001        	push	_adress
8168  1781 ae018e        	ldw	x,#398
8169  1784 cd1540        	call	_can_transmit
8171  1787 5b08          	addw	sp,#8
8172                     ; 1667 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8174  1789 3b0034        	push	_plazma_int+4
8175  178c 3b0035        	push	_plazma_int+5
8176  178f 3b005c        	push	__x_+1
8177  1792 3b000a        	push	_flags
8178  1795 4b00          	push	#0
8179  1797 3b0064        	push	_T
8180  179a 4bdb          	push	#219
8181  179c 3b0001        	push	_adress
8182  179f ae018e        	ldw	x,#398
8183  17a2 cd1540        	call	_can_transmit
8185  17a5 5b08          	addw	sp,#8
8186                     ; 1668      link_cnt=0;
8188  17a7 3f5e          	clr	_link_cnt
8189                     ; 1669      link=ON;
8191  17a9 3555005f      	mov	_link,#85
8192                     ; 1671      if(flags_tu&0b10000000)
8194  17ad b65d          	ld	a,_flags_tu
8195  17af a580          	bcp	a,#128
8196  17b1 2716          	jreq	L3753
8197                     ; 1673      	if(!res_fl)
8199  17b3 725d0009      	tnz	_res_fl
8200  17b7 2625          	jrne	L7753
8201                     ; 1675      		res_fl=1;
8203  17b9 a601          	ld	a,#1
8204  17bb ae0009        	ldw	x,#_res_fl
8205  17be cd0000        	call	c_eewrc
8207                     ; 1676      		bRES=1;
8209  17c1 3501000f      	mov	_bRES,#1
8210                     ; 1677      		res_fl_cnt=0;
8212  17c5 3f3e          	clr	_res_fl_cnt
8213  17c7 2015          	jra	L7753
8214  17c9               L3753:
8215                     ; 1682      	if(main_cnt>20)
8217  17c9 9c            	rvf
8218  17ca be4e          	ldw	x,_main_cnt
8219  17cc a30015        	cpw	x,#21
8220  17cf 2f0d          	jrslt	L7753
8221                     ; 1684     			if(res_fl)
8223  17d1 725d0009      	tnz	_res_fl
8224  17d5 2707          	jreq	L7753
8225                     ; 1686      			res_fl=0;
8227  17d7 4f            	clr	a
8228  17d8 ae0009        	ldw	x,#_res_fl
8229  17db cd0000        	call	c_eewrc
8231  17de               L7753:
8232                     ; 1691       if(res_fl_)
8234  17de 725d0008      	tnz	_res_fl_
8235  17e2 2603          	jrne	L602
8236  17e4 cc1d15        	jp	L5253
8237  17e7               L602:
8238                     ; 1693       	res_fl_=0;
8240  17e7 4f            	clr	a
8241  17e8 ae0008        	ldw	x,#_res_fl_
8242  17eb cd0000        	call	c_eewrc
8244  17ee ac151d15      	jpf	L5253
8245  17f2               L1653:
8246                     ; 1696 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8248  17f2 b6c6          	ld	a,_mess+6
8249  17f4 c10001        	cp	a,_adress
8250  17f7 2703          	jreq	L012
8251  17f9 cc1a08        	jp	L1163
8252  17fc               L012:
8254  17fc b6c7          	ld	a,_mess+7
8255  17fe c10001        	cp	a,_adress
8256  1801 2703          	jreq	L212
8257  1803 cc1a08        	jp	L1163
8258  1806               L212:
8260  1806 b6c8          	ld	a,_mess+8
8261  1808 a1ee          	cp	a,#238
8262  180a 2703          	jreq	L412
8263  180c cc1a08        	jp	L1163
8264  180f               L412:
8266  180f b6c9          	ld	a,_mess+9
8267  1811 b1ca          	cp	a,_mess+10
8268  1813 2703          	jreq	L612
8269  1815 cc1a08        	jp	L1163
8270  1818               L612:
8271                     ; 1698 	rotor_int++;
8273  1818 be1a          	ldw	x,_rotor_int
8274  181a 1c0001        	addw	x,#1
8275  181d bf1a          	ldw	_rotor_int,x
8276                     ; 1699 	if((mess[9]&0xf0)==0x20)
8278  181f b6c9          	ld	a,_mess+9
8279  1821 a4f0          	and	a,#240
8280  1823 a120          	cp	a,#32
8281  1825 2673          	jrne	L3163
8282                     ; 1701 		if((mess[9]&0x0f)==0x01)
8284  1827 b6c9          	ld	a,_mess+9
8285  1829 a40f          	and	a,#15
8286  182b a101          	cp	a,#1
8287  182d 260d          	jrne	L5163
8288                     ; 1703 			ee_K[0][0]=adc_buff_[4];
8290  182f ce000d        	ldw	x,_adc_buff_+8
8291  1832 89            	pushw	x
8292  1833 ae0018        	ldw	x,#_ee_K
8293  1836 cd0000        	call	c_eewrw
8295  1839 85            	popw	x
8297  183a 204a          	jra	L7163
8298  183c               L5163:
8299                     ; 1705 		else if((mess[9]&0x0f)==0x02)
8301  183c b6c9          	ld	a,_mess+9
8302  183e a40f          	and	a,#15
8303  1840 a102          	cp	a,#2
8304  1842 260b          	jrne	L1263
8305                     ; 1707 			ee_K[0][1]++;
8307  1844 ce001a        	ldw	x,_ee_K+2
8308  1847 1c0001        	addw	x,#1
8309  184a cf001a        	ldw	_ee_K+2,x
8311  184d 2037          	jra	L7163
8312  184f               L1263:
8313                     ; 1709 		else if((mess[9]&0x0f)==0x03)
8315  184f b6c9          	ld	a,_mess+9
8316  1851 a40f          	and	a,#15
8317  1853 a103          	cp	a,#3
8318  1855 260b          	jrne	L5263
8319                     ; 1711 			ee_K[0][1]+=10;
8321  1857 ce001a        	ldw	x,_ee_K+2
8322  185a 1c000a        	addw	x,#10
8323  185d cf001a        	ldw	_ee_K+2,x
8325  1860 2024          	jra	L7163
8326  1862               L5263:
8327                     ; 1713 		else if((mess[9]&0x0f)==0x04)
8329  1862 b6c9          	ld	a,_mess+9
8330  1864 a40f          	and	a,#15
8331  1866 a104          	cp	a,#4
8332  1868 260b          	jrne	L1363
8333                     ; 1715 			ee_K[0][1]--;
8335  186a ce001a        	ldw	x,_ee_K+2
8336  186d 1d0001        	subw	x,#1
8337  1870 cf001a        	ldw	_ee_K+2,x
8339  1873 2011          	jra	L7163
8340  1875               L1363:
8341                     ; 1717 		else if((mess[9]&0x0f)==0x05)
8343  1875 b6c9          	ld	a,_mess+9
8344  1877 a40f          	and	a,#15
8345  1879 a105          	cp	a,#5
8346  187b 2609          	jrne	L7163
8347                     ; 1719 			ee_K[0][1]-=10;
8349  187d ce001a        	ldw	x,_ee_K+2
8350  1880 1d000a        	subw	x,#10
8351  1883 cf001a        	ldw	_ee_K+2,x
8352  1886               L7163:
8353                     ; 1721 		granee(&ee_K[0][1],50,3000);									
8355  1886 ae0bb8        	ldw	x,#3000
8356  1889 89            	pushw	x
8357  188a ae0032        	ldw	x,#50
8358  188d 89            	pushw	x
8359  188e ae001a        	ldw	x,#_ee_K+2
8360  1891 cd0021        	call	_granee
8362  1894 5b04          	addw	sp,#4
8364  1896 acee19ee      	jpf	L7363
8365  189a               L3163:
8366                     ; 1723 	else if((mess[9]&0xf0)==0x10)
8368  189a b6c9          	ld	a,_mess+9
8369  189c a4f0          	and	a,#240
8370  189e a110          	cp	a,#16
8371  18a0 2673          	jrne	L1463
8372                     ; 1725 		if((mess[9]&0x0f)==0x01)
8374  18a2 b6c9          	ld	a,_mess+9
8375  18a4 a40f          	and	a,#15
8376  18a6 a101          	cp	a,#1
8377  18a8 260d          	jrne	L3463
8378                     ; 1727 			ee_K[1][0]=adc_buff_[1];
8380  18aa ce0007        	ldw	x,_adc_buff_+2
8381  18ad 89            	pushw	x
8382  18ae ae001c        	ldw	x,#_ee_K+4
8383  18b1 cd0000        	call	c_eewrw
8385  18b4 85            	popw	x
8387  18b5 204a          	jra	L5463
8388  18b7               L3463:
8389                     ; 1729 		else if((mess[9]&0x0f)==0x02)
8391  18b7 b6c9          	ld	a,_mess+9
8392  18b9 a40f          	and	a,#15
8393  18bb a102          	cp	a,#2
8394  18bd 260b          	jrne	L7463
8395                     ; 1731 			ee_K[1][1]++;
8397  18bf ce001e        	ldw	x,_ee_K+6
8398  18c2 1c0001        	addw	x,#1
8399  18c5 cf001e        	ldw	_ee_K+6,x
8401  18c8 2037          	jra	L5463
8402  18ca               L7463:
8403                     ; 1733 		else if((mess[9]&0x0f)==0x03)
8405  18ca b6c9          	ld	a,_mess+9
8406  18cc a40f          	and	a,#15
8407  18ce a103          	cp	a,#3
8408  18d0 260b          	jrne	L3563
8409                     ; 1735 			ee_K[1][1]+=10;
8411  18d2 ce001e        	ldw	x,_ee_K+6
8412  18d5 1c000a        	addw	x,#10
8413  18d8 cf001e        	ldw	_ee_K+6,x
8415  18db 2024          	jra	L5463
8416  18dd               L3563:
8417                     ; 1737 		else if((mess[9]&0x0f)==0x04)
8419  18dd b6c9          	ld	a,_mess+9
8420  18df a40f          	and	a,#15
8421  18e1 a104          	cp	a,#4
8422  18e3 260b          	jrne	L7563
8423                     ; 1739 			ee_K[1][1]--;
8425  18e5 ce001e        	ldw	x,_ee_K+6
8426  18e8 1d0001        	subw	x,#1
8427  18eb cf001e        	ldw	_ee_K+6,x
8429  18ee 2011          	jra	L5463
8430  18f0               L7563:
8431                     ; 1741 		else if((mess[9]&0x0f)==0x05)
8433  18f0 b6c9          	ld	a,_mess+9
8434  18f2 a40f          	and	a,#15
8435  18f4 a105          	cp	a,#5
8436  18f6 2609          	jrne	L5463
8437                     ; 1743 			ee_K[1][1]-=10;
8439  18f8 ce001e        	ldw	x,_ee_K+6
8440  18fb 1d000a        	subw	x,#10
8441  18fe cf001e        	ldw	_ee_K+6,x
8442  1901               L5463:
8443                     ; 1748 		granee(&ee_K[1][1],10,30000);
8445  1901 ae7530        	ldw	x,#30000
8446  1904 89            	pushw	x
8447  1905 ae000a        	ldw	x,#10
8448  1908 89            	pushw	x
8449  1909 ae001e        	ldw	x,#_ee_K+6
8450  190c cd0021        	call	_granee
8452  190f 5b04          	addw	sp,#4
8454  1911 acee19ee      	jpf	L7363
8455  1915               L1463:
8456                     ; 1752 	else if((mess[9]&0xf0)==0x00)
8458  1915 b6c9          	ld	a,_mess+9
8459  1917 a5f0          	bcp	a,#240
8460  1919 2671          	jrne	L7663
8461                     ; 1754 		if((mess[9]&0x0f)==0x01)
8463  191b b6c9          	ld	a,_mess+9
8464  191d a40f          	and	a,#15
8465  191f a101          	cp	a,#1
8466  1921 260d          	jrne	L1763
8467                     ; 1756 			ee_K[2][0]=adc_buff_[2];
8469  1923 ce0009        	ldw	x,_adc_buff_+4
8470  1926 89            	pushw	x
8471  1927 ae0020        	ldw	x,#_ee_K+8
8472  192a cd0000        	call	c_eewrw
8474  192d 85            	popw	x
8476  192e 204a          	jra	L3763
8477  1930               L1763:
8478                     ; 1758 		else if((mess[9]&0x0f)==0x02)
8480  1930 b6c9          	ld	a,_mess+9
8481  1932 a40f          	and	a,#15
8482  1934 a102          	cp	a,#2
8483  1936 260b          	jrne	L5763
8484                     ; 1760 			ee_K[2][1]++;
8486  1938 ce0022        	ldw	x,_ee_K+10
8487  193b 1c0001        	addw	x,#1
8488  193e cf0022        	ldw	_ee_K+10,x
8490  1941 2037          	jra	L3763
8491  1943               L5763:
8492                     ; 1762 		else if((mess[9]&0x0f)==0x03)
8494  1943 b6c9          	ld	a,_mess+9
8495  1945 a40f          	and	a,#15
8496  1947 a103          	cp	a,#3
8497  1949 260b          	jrne	L1073
8498                     ; 1764 			ee_K[2][1]+=10;
8500  194b ce0022        	ldw	x,_ee_K+10
8501  194e 1c000a        	addw	x,#10
8502  1951 cf0022        	ldw	_ee_K+10,x
8504  1954 2024          	jra	L3763
8505  1956               L1073:
8506                     ; 1766 		else if((mess[9]&0x0f)==0x04)
8508  1956 b6c9          	ld	a,_mess+9
8509  1958 a40f          	and	a,#15
8510  195a a104          	cp	a,#4
8511  195c 260b          	jrne	L5073
8512                     ; 1768 			ee_K[2][1]--;
8514  195e ce0022        	ldw	x,_ee_K+10
8515  1961 1d0001        	subw	x,#1
8516  1964 cf0022        	ldw	_ee_K+10,x
8518  1967 2011          	jra	L3763
8519  1969               L5073:
8520                     ; 1770 		else if((mess[9]&0x0f)==0x05)
8522  1969 b6c9          	ld	a,_mess+9
8523  196b a40f          	and	a,#15
8524  196d a105          	cp	a,#5
8525  196f 2609          	jrne	L3763
8526                     ; 1772 			ee_K[2][1]-=10;
8528  1971 ce0022        	ldw	x,_ee_K+10
8529  1974 1d000a        	subw	x,#10
8530  1977 cf0022        	ldw	_ee_K+10,x
8531  197a               L3763:
8532                     ; 1777 		granee(&ee_K[2][1],10,30000);
8534  197a ae7530        	ldw	x,#30000
8535  197d 89            	pushw	x
8536  197e ae000a        	ldw	x,#10
8537  1981 89            	pushw	x
8538  1982 ae0022        	ldw	x,#_ee_K+10
8539  1985 cd0021        	call	_granee
8541  1988 5b04          	addw	sp,#4
8543  198a 2062          	jra	L7363
8544  198c               L7663:
8545                     ; 1781 	else if((mess[9]&0xf0)==0x30)
8547  198c b6c9          	ld	a,_mess+9
8548  198e a4f0          	and	a,#240
8549  1990 a130          	cp	a,#48
8550  1992 265a          	jrne	L7363
8551                     ; 1783 		if((mess[9]&0x0f)==0x02)
8553  1994 b6c9          	ld	a,_mess+9
8554  1996 a40f          	and	a,#15
8555  1998 a102          	cp	a,#2
8556  199a 260b          	jrne	L7173
8557                     ; 1785 			ee_K[3][1]++;
8559  199c ce0026        	ldw	x,_ee_K+14
8560  199f 1c0001        	addw	x,#1
8561  19a2 cf0026        	ldw	_ee_K+14,x
8563  19a5 2037          	jra	L1273
8564  19a7               L7173:
8565                     ; 1787 		else if((mess[9]&0x0f)==0x03)
8567  19a7 b6c9          	ld	a,_mess+9
8568  19a9 a40f          	and	a,#15
8569  19ab a103          	cp	a,#3
8570  19ad 260b          	jrne	L3273
8571                     ; 1789 			ee_K[3][1]+=10;
8573  19af ce0026        	ldw	x,_ee_K+14
8574  19b2 1c000a        	addw	x,#10
8575  19b5 cf0026        	ldw	_ee_K+14,x
8577  19b8 2024          	jra	L1273
8578  19ba               L3273:
8579                     ; 1791 		else if((mess[9]&0x0f)==0x04)
8581  19ba b6c9          	ld	a,_mess+9
8582  19bc a40f          	and	a,#15
8583  19be a104          	cp	a,#4
8584  19c0 260b          	jrne	L7273
8585                     ; 1793 			ee_K[3][1]--;
8587  19c2 ce0026        	ldw	x,_ee_K+14
8588  19c5 1d0001        	subw	x,#1
8589  19c8 cf0026        	ldw	_ee_K+14,x
8591  19cb 2011          	jra	L1273
8592  19cd               L7273:
8593                     ; 1795 		else if((mess[9]&0x0f)==0x05)
8595  19cd b6c9          	ld	a,_mess+9
8596  19cf a40f          	and	a,#15
8597  19d1 a105          	cp	a,#5
8598  19d3 2609          	jrne	L1273
8599                     ; 1797 			ee_K[3][1]-=10;
8601  19d5 ce0026        	ldw	x,_ee_K+14
8602  19d8 1d000a        	subw	x,#10
8603  19db cf0026        	ldw	_ee_K+14,x
8604  19de               L1273:
8605                     ; 1799 		granee(&ee_K[3][1],300,517);									
8607  19de ae0205        	ldw	x,#517
8608  19e1 89            	pushw	x
8609  19e2 ae012c        	ldw	x,#300
8610  19e5 89            	pushw	x
8611  19e6 ae0026        	ldw	x,#_ee_K+14
8612  19e9 cd0021        	call	_granee
8614  19ec 5b04          	addw	sp,#4
8615  19ee               L7363:
8616                     ; 1802 	link_cnt=0;
8618  19ee 3f5e          	clr	_link_cnt
8619                     ; 1803      link=ON;
8621  19f0 3555005f      	mov	_link,#85
8622                     ; 1804      if(res_fl_)
8624  19f4 725d0008      	tnz	_res_fl_
8625  19f8 2603          	jrne	L022
8626  19fa cc1d15        	jp	L5253
8627  19fd               L022:
8628                     ; 1806       	res_fl_=0;
8630  19fd 4f            	clr	a
8631  19fe ae0008        	ldw	x,#_res_fl_
8632  1a01 cd0000        	call	c_eewrc
8634  1a04 ac151d15      	jpf	L5253
8635  1a08               L1163:
8636                     ; 1812 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8638  1a08 b6c6          	ld	a,_mess+6
8639  1a0a a1ff          	cp	a,#255
8640  1a0c 2703          	jreq	L222
8641  1a0e cc1a9c        	jp	L1473
8642  1a11               L222:
8644  1a11 b6c7          	ld	a,_mess+7
8645  1a13 a1ff          	cp	a,#255
8646  1a15 2703          	jreq	L422
8647  1a17 cc1a9c        	jp	L1473
8648  1a1a               L422:
8650  1a1a b6c8          	ld	a,_mess+8
8651  1a1c a162          	cp	a,#98
8652  1a1e 267c          	jrne	L1473
8653                     ; 1815 	tempSS=mess[9]+(mess[10]*256);
8655  1a20 b6ca          	ld	a,_mess+10
8656  1a22 5f            	clrw	x
8657  1a23 97            	ld	xl,a
8658  1a24 4f            	clr	a
8659  1a25 02            	rlwa	x,a
8660  1a26 01            	rrwa	x,a
8661  1a27 bbc9          	add	a,_mess+9
8662  1a29 2401          	jrnc	L071
8663  1a2b 5c            	incw	x
8664  1a2c               L071:
8665  1a2c 02            	rlwa	x,a
8666  1a2d 1f04          	ldw	(OFST-1,sp),x
8667  1a2f 01            	rrwa	x,a
8668                     ; 1816 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8670  1a30 ce0012        	ldw	x,_ee_Umax
8671  1a33 1304          	cpw	x,(OFST-1,sp)
8672  1a35 270a          	jreq	L3473
8675  1a37 1e04          	ldw	x,(OFST-1,sp)
8676  1a39 89            	pushw	x
8677  1a3a ae0012        	ldw	x,#_ee_Umax
8678  1a3d cd0000        	call	c_eewrw
8680  1a40 85            	popw	x
8681  1a41               L3473:
8682                     ; 1817 	tempSS=mess[11]+(mess[12]*256);
8684  1a41 b6cc          	ld	a,_mess+12
8685  1a43 5f            	clrw	x
8686  1a44 97            	ld	xl,a
8687  1a45 4f            	clr	a
8688  1a46 02            	rlwa	x,a
8689  1a47 01            	rrwa	x,a
8690  1a48 bbcb          	add	a,_mess+11
8691  1a4a 2401          	jrnc	L271
8692  1a4c 5c            	incw	x
8693  1a4d               L271:
8694  1a4d 02            	rlwa	x,a
8695  1a4e 1f04          	ldw	(OFST-1,sp),x
8696  1a50 01            	rrwa	x,a
8697                     ; 1818 	if(ee_dU!=tempSS) ee_dU=tempSS;
8699  1a51 ce0010        	ldw	x,_ee_dU
8700  1a54 1304          	cpw	x,(OFST-1,sp)
8701  1a56 270a          	jreq	L5473
8704  1a58 1e04          	ldw	x,(OFST-1,sp)
8705  1a5a 89            	pushw	x
8706  1a5b ae0010        	ldw	x,#_ee_dU
8707  1a5e cd0000        	call	c_eewrw
8709  1a61 85            	popw	x
8710  1a62               L5473:
8711                     ; 1819 	if((mess[13]&0x0f)==0x5)
8713  1a62 b6cd          	ld	a,_mess+13
8714  1a64 a40f          	and	a,#15
8715  1a66 a105          	cp	a,#5
8716  1a68 261a          	jrne	L7473
8717                     ; 1821 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8719  1a6a ce0004        	ldw	x,_ee_AVT_MODE
8720  1a6d a30055        	cpw	x,#85
8721  1a70 2603          	jrne	L622
8722  1a72 cc1d15        	jp	L5253
8723  1a75               L622:
8726  1a75 ae0055        	ldw	x,#85
8727  1a78 89            	pushw	x
8728  1a79 ae0004        	ldw	x,#_ee_AVT_MODE
8729  1a7c cd0000        	call	c_eewrw
8731  1a7f 85            	popw	x
8732  1a80 ac151d15      	jpf	L5253
8733  1a84               L7473:
8734                     ; 1823 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8736  1a84 ce0004        	ldw	x,_ee_AVT_MODE
8737  1a87 a30055        	cpw	x,#85
8738  1a8a 2703          	jreq	L032
8739  1a8c cc1d15        	jp	L5253
8740  1a8f               L032:
8743  1a8f 5f            	clrw	x
8744  1a90 89            	pushw	x
8745  1a91 ae0004        	ldw	x,#_ee_AVT_MODE
8746  1a94 cd0000        	call	c_eewrw
8748  1a97 85            	popw	x
8749  1a98 ac151d15      	jpf	L5253
8750  1a9c               L1473:
8751                     ; 1826 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8753  1a9c b6c6          	ld	a,_mess+6
8754  1a9e a1ff          	cp	a,#255
8755  1aa0 2703          	jreq	L232
8756  1aa2 cc1b73        	jp	L1673
8757  1aa5               L232:
8759  1aa5 b6c7          	ld	a,_mess+7
8760  1aa7 a1ff          	cp	a,#255
8761  1aa9 2703          	jreq	L432
8762  1aab cc1b73        	jp	L1673
8763  1aae               L432:
8765  1aae b6c8          	ld	a,_mess+8
8766  1ab0 a126          	cp	a,#38
8767  1ab2 2709          	jreq	L3673
8769  1ab4 b6c8          	ld	a,_mess+8
8770  1ab6 a129          	cp	a,#41
8771  1ab8 2703          	jreq	L632
8772  1aba cc1b73        	jp	L1673
8773  1abd               L632:
8774  1abd               L3673:
8775                     ; 1829 	tempSS=mess[9]+(mess[10]*256);
8777  1abd b6ca          	ld	a,_mess+10
8778  1abf 5f            	clrw	x
8779  1ac0 97            	ld	xl,a
8780  1ac1 4f            	clr	a
8781  1ac2 02            	rlwa	x,a
8782  1ac3 01            	rrwa	x,a
8783  1ac4 bbc9          	add	a,_mess+9
8784  1ac6 2401          	jrnc	L471
8785  1ac8 5c            	incw	x
8786  1ac9               L471:
8787  1ac9 02            	rlwa	x,a
8788  1aca 1f04          	ldw	(OFST-1,sp),x
8789  1acc 01            	rrwa	x,a
8790                     ; 1830 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8792  1acd ce000e        	ldw	x,_ee_tmax
8793  1ad0 1304          	cpw	x,(OFST-1,sp)
8794  1ad2 270a          	jreq	L5673
8797  1ad4 1e04          	ldw	x,(OFST-1,sp)
8798  1ad6 89            	pushw	x
8799  1ad7 ae000e        	ldw	x,#_ee_tmax
8800  1ada cd0000        	call	c_eewrw
8802  1add 85            	popw	x
8803  1ade               L5673:
8804                     ; 1831 	tempSS=mess[11]+(mess[12]*256);
8806  1ade b6cc          	ld	a,_mess+12
8807  1ae0 5f            	clrw	x
8808  1ae1 97            	ld	xl,a
8809  1ae2 4f            	clr	a
8810  1ae3 02            	rlwa	x,a
8811  1ae4 01            	rrwa	x,a
8812  1ae5 bbcb          	add	a,_mess+11
8813  1ae7 2401          	jrnc	L671
8814  1ae9 5c            	incw	x
8815  1aea               L671:
8816  1aea 02            	rlwa	x,a
8817  1aeb 1f04          	ldw	(OFST-1,sp),x
8818  1aed 01            	rrwa	x,a
8819                     ; 1832 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8821  1aee ce000c        	ldw	x,_ee_tsign
8822  1af1 1304          	cpw	x,(OFST-1,sp)
8823  1af3 270a          	jreq	L7673
8826  1af5 1e04          	ldw	x,(OFST-1,sp)
8827  1af7 89            	pushw	x
8828  1af8 ae000c        	ldw	x,#_ee_tsign
8829  1afb cd0000        	call	c_eewrw
8831  1afe 85            	popw	x
8832  1aff               L7673:
8833                     ; 1835 	if(mess[8]==MEM_KF1)
8835  1aff b6c8          	ld	a,_mess+8
8836  1b01 a126          	cp	a,#38
8837  1b03 2623          	jrne	L1773
8838                     ; 1837 		if(ee_DEVICE!=0)ee_DEVICE=0;
8840  1b05 ce0002        	ldw	x,_ee_DEVICE
8841  1b08 2709          	jreq	L3773
8844  1b0a 5f            	clrw	x
8845  1b0b 89            	pushw	x
8846  1b0c ae0002        	ldw	x,#_ee_DEVICE
8847  1b0f cd0000        	call	c_eewrw
8849  1b12 85            	popw	x
8850  1b13               L3773:
8851                     ; 1838 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8853  1b13 b6cd          	ld	a,_mess+13
8854  1b15 5f            	clrw	x
8855  1b16 97            	ld	xl,a
8856  1b17 c30014        	cpw	x,_ee_TZAS
8857  1b1a 270c          	jreq	L1773
8860  1b1c b6cd          	ld	a,_mess+13
8861  1b1e 5f            	clrw	x
8862  1b1f 97            	ld	xl,a
8863  1b20 89            	pushw	x
8864  1b21 ae0014        	ldw	x,#_ee_TZAS
8865  1b24 cd0000        	call	c_eewrw
8867  1b27 85            	popw	x
8868  1b28               L1773:
8869                     ; 1840 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8871  1b28 b6c8          	ld	a,_mess+8
8872  1b2a a129          	cp	a,#41
8873  1b2c 2703          	jreq	L042
8874  1b2e cc1d15        	jp	L5253
8875  1b31               L042:
8876                     ; 1842 		if(ee_DEVICE!=1)ee_DEVICE=1;
8878  1b31 ce0002        	ldw	x,_ee_DEVICE
8879  1b34 a30001        	cpw	x,#1
8880  1b37 270b          	jreq	L1004
8883  1b39 ae0001        	ldw	x,#1
8884  1b3c 89            	pushw	x
8885  1b3d ae0002        	ldw	x,#_ee_DEVICE
8886  1b40 cd0000        	call	c_eewrw
8888  1b43 85            	popw	x
8889  1b44               L1004:
8890                     ; 1843 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8892  1b44 b6cd          	ld	a,_mess+13
8893  1b46 5f            	clrw	x
8894  1b47 97            	ld	xl,a
8895  1b48 c30000        	cpw	x,_ee_IMAXVENT
8896  1b4b 270c          	jreq	L3004
8899  1b4d b6cd          	ld	a,_mess+13
8900  1b4f 5f            	clrw	x
8901  1b50 97            	ld	xl,a
8902  1b51 89            	pushw	x
8903  1b52 ae0000        	ldw	x,#_ee_IMAXVENT
8904  1b55 cd0000        	call	c_eewrw
8906  1b58 85            	popw	x
8907  1b59               L3004:
8908                     ; 1844 			if(ee_TZAS!=3) ee_TZAS=3;
8910  1b59 ce0014        	ldw	x,_ee_TZAS
8911  1b5c a30003        	cpw	x,#3
8912  1b5f 2603          	jrne	L242
8913  1b61 cc1d15        	jp	L5253
8914  1b64               L242:
8917  1b64 ae0003        	ldw	x,#3
8918  1b67 89            	pushw	x
8919  1b68 ae0014        	ldw	x,#_ee_TZAS
8920  1b6b cd0000        	call	c_eewrw
8922  1b6e 85            	popw	x
8923  1b6f ac151d15      	jpf	L5253
8924  1b73               L1673:
8925                     ; 1848 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8927  1b73 b6c6          	ld	a,_mess+6
8928  1b75 c10001        	cp	a,_adress
8929  1b78 262d          	jrne	L1104
8931  1b7a b6c7          	ld	a,_mess+7
8932  1b7c c10001        	cp	a,_adress
8933  1b7f 2626          	jrne	L1104
8935  1b81 b6c8          	ld	a,_mess+8
8936  1b83 a116          	cp	a,#22
8937  1b85 2620          	jrne	L1104
8939  1b87 b6c9          	ld	a,_mess+9
8940  1b89 a163          	cp	a,#99
8941  1b8b 261a          	jrne	L1104
8942                     ; 1850 	flags&=0b11100001;
8944  1b8d b60a          	ld	a,_flags
8945  1b8f a4e1          	and	a,#225
8946  1b91 b70a          	ld	_flags,a
8947                     ; 1851 	tsign_cnt=0;
8949  1b93 5f            	clrw	x
8950  1b94 bf4a          	ldw	_tsign_cnt,x
8951                     ; 1852 	tmax_cnt=0;
8953  1b96 5f            	clrw	x
8954  1b97 bf48          	ldw	_tmax_cnt,x
8955                     ; 1853 	umax_cnt=0;
8957  1b99 5f            	clrw	x
8958  1b9a bf62          	ldw	_umax_cnt,x
8959                     ; 1854 	umin_cnt=0;
8961  1b9c 5f            	clrw	x
8962  1b9d bf60          	ldw	_umin_cnt,x
8963                     ; 1855 	led_drv_cnt=30;
8965  1b9f 351e0019      	mov	_led_drv_cnt,#30
8967  1ba3 ac151d15      	jpf	L5253
8968  1ba7               L1104:
8969                     ; 1857 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8971  1ba7 b6c6          	ld	a,_mess+6
8972  1ba9 a1ff          	cp	a,#255
8973  1bab 265f          	jrne	L5104
8975  1bad b6c7          	ld	a,_mess+7
8976  1baf a1ff          	cp	a,#255
8977  1bb1 2659          	jrne	L5104
8979  1bb3 b6c8          	ld	a,_mess+8
8980  1bb5 a116          	cp	a,#22
8981  1bb7 2653          	jrne	L5104
8983  1bb9 b6c9          	ld	a,_mess+9
8984  1bbb a116          	cp	a,#22
8985  1bbd 264d          	jrne	L5104
8986                     ; 1859 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8988  1bbf b6ca          	ld	a,_mess+10
8989  1bc1 a155          	cp	a,#85
8990  1bc3 260f          	jrne	L7104
8992  1bc5 b6cb          	ld	a,_mess+11
8993  1bc7 a155          	cp	a,#85
8994  1bc9 2609          	jrne	L7104
8997  1bcb be5b          	ldw	x,__x_
8998  1bcd 1c0001        	addw	x,#1
8999  1bd0 bf5b          	ldw	__x_,x
9001  1bd2 2024          	jra	L1204
9002  1bd4               L7104:
9003                     ; 1860 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9005  1bd4 b6ca          	ld	a,_mess+10
9006  1bd6 a166          	cp	a,#102
9007  1bd8 260f          	jrne	L3204
9009  1bda b6cb          	ld	a,_mess+11
9010  1bdc a166          	cp	a,#102
9011  1bde 2609          	jrne	L3204
9014  1be0 be5b          	ldw	x,__x_
9015  1be2 1d0001        	subw	x,#1
9016  1be5 bf5b          	ldw	__x_,x
9018  1be7 200f          	jra	L1204
9019  1be9               L3204:
9020                     ; 1861 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9022  1be9 b6ca          	ld	a,_mess+10
9023  1beb a177          	cp	a,#119
9024  1bed 2609          	jrne	L1204
9026  1bef b6cb          	ld	a,_mess+11
9027  1bf1 a177          	cp	a,#119
9028  1bf3 2603          	jrne	L1204
9031  1bf5 5f            	clrw	x
9032  1bf6 bf5b          	ldw	__x_,x
9033  1bf8               L1204:
9034                     ; 1862      gran(&_x_,-XMAX,XMAX);
9036  1bf8 ae0019        	ldw	x,#25
9037  1bfb 89            	pushw	x
9038  1bfc aeffe7        	ldw	x,#65511
9039  1bff 89            	pushw	x
9040  1c00 ae005b        	ldw	x,#__x_
9041  1c03 cd0000        	call	_gran
9043  1c06 5b04          	addw	sp,#4
9045  1c08 ac151d15      	jpf	L5253
9046  1c0c               L5104:
9047                     ; 1864 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9049  1c0c b6c6          	ld	a,_mess+6
9050  1c0e c10001        	cp	a,_adress
9051  1c11 2665          	jrne	L3304
9053  1c13 b6c7          	ld	a,_mess+7
9054  1c15 c10001        	cp	a,_adress
9055  1c18 265e          	jrne	L3304
9057  1c1a b6c8          	ld	a,_mess+8
9058  1c1c a116          	cp	a,#22
9059  1c1e 2658          	jrne	L3304
9061  1c20 b6c9          	ld	a,_mess+9
9062  1c22 b1ca          	cp	a,_mess+10
9063  1c24 2652          	jrne	L3304
9065  1c26 b6c9          	ld	a,_mess+9
9066  1c28 a1ee          	cp	a,#238
9067  1c2a 264c          	jrne	L3304
9068                     ; 1866 	rotor_int++;
9070  1c2c be1a          	ldw	x,_rotor_int
9071  1c2e 1c0001        	addw	x,#1
9072  1c31 bf1a          	ldw	_rotor_int,x
9073                     ; 1867      tempI=pwm_u;
9075  1c33 be0b          	ldw	x,_pwm_u
9076  1c35 1f04          	ldw	(OFST-1,sp),x
9077                     ; 1868 	ee_U_AVT=tempI;
9079  1c37 1e04          	ldw	x,(OFST-1,sp)
9080  1c39 89            	pushw	x
9081  1c3a ae000a        	ldw	x,#_ee_U_AVT
9082  1c3d cd0000        	call	c_eewrw
9084  1c40 85            	popw	x
9085                     ; 1869 	UU_AVT=Un;
9087  1c41 be69          	ldw	x,_Un
9088  1c43 89            	pushw	x
9089  1c44 ae0006        	ldw	x,#_UU_AVT
9090  1c47 cd0000        	call	c_eewrw
9092  1c4a 85            	popw	x
9093                     ; 1870 	delay_ms(100);
9095  1c4b ae0064        	ldw	x,#100
9096  1c4e cd004c        	call	_delay_ms
9098                     ; 1871 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9100  1c51 ce000a        	ldw	x,_ee_U_AVT
9101  1c54 1304          	cpw	x,(OFST-1,sp)
9102  1c56 2703          	jreq	L442
9103  1c58 cc1d15        	jp	L5253
9104  1c5b               L442:
9107  1c5b 4b00          	push	#0
9108  1c5d 4b00          	push	#0
9109  1c5f 4b00          	push	#0
9110  1c61 4b00          	push	#0
9111  1c63 4bdd          	push	#221
9112  1c65 4bdd          	push	#221
9113  1c67 4b91          	push	#145
9114  1c69 3b0001        	push	_adress
9115  1c6c ae018e        	ldw	x,#398
9116  1c6f cd1540        	call	_can_transmit
9118  1c72 5b08          	addw	sp,#8
9119  1c74 ac151d15      	jpf	L5253
9120  1c78               L3304:
9121                     ; 1876 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9123  1c78 b6c7          	ld	a,_mess+7
9124  1c7a a1da          	cp	a,#218
9125  1c7c 2652          	jrne	L1404
9127  1c7e b6c6          	ld	a,_mess+6
9128  1c80 c10001        	cp	a,_adress
9129  1c83 274b          	jreq	L1404
9131  1c85 b6c6          	ld	a,_mess+6
9132  1c87 a106          	cp	a,#6
9133  1c89 2445          	jruge	L1404
9134                     ; 1878 	i_main_bps_cnt[mess[6]]=0;
9136  1c8b b6c6          	ld	a,_mess+6
9137  1c8d 5f            	clrw	x
9138  1c8e 97            	ld	xl,a
9139  1c8f 6f06          	clr	(_i_main_bps_cnt,x)
9140                     ; 1879 	i_main_flag[mess[6]]=1;
9142  1c91 b6c6          	ld	a,_mess+6
9143  1c93 5f            	clrw	x
9144  1c94 97            	ld	xl,a
9145  1c95 a601          	ld	a,#1
9146  1c97 e711          	ld	(_i_main_flag,x),a
9147                     ; 1880 	if(bMAIN)
9149                     	btst	_bMAIN
9150  1c9e 2475          	jruge	L5253
9151                     ; 1882 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9153  1ca0 b6c9          	ld	a,_mess+9
9154  1ca2 5f            	clrw	x
9155  1ca3 97            	ld	xl,a
9156  1ca4 4f            	clr	a
9157  1ca5 02            	rlwa	x,a
9158  1ca6 1f01          	ldw	(OFST-4,sp),x
9159  1ca8 b6c8          	ld	a,_mess+8
9160  1caa 5f            	clrw	x
9161  1cab 97            	ld	xl,a
9162  1cac 72fb01        	addw	x,(OFST-4,sp)
9163  1caf b6c6          	ld	a,_mess+6
9164  1cb1 905f          	clrw	y
9165  1cb3 9097          	ld	yl,a
9166  1cb5 9058          	sllw	y
9167  1cb7 90ef17        	ldw	(_i_main,y),x
9168                     ; 1883 		i_main[adress]=I;
9170  1cba c60001        	ld	a,_adress
9171  1cbd 5f            	clrw	x
9172  1cbe 97            	ld	xl,a
9173  1cbf 58            	sllw	x
9174  1cc0 90be6b        	ldw	y,_I
9175  1cc3 ef17          	ldw	(_i_main,x),y
9176                     ; 1884      	i_main_flag[adress]=1;
9178  1cc5 c60001        	ld	a,_adress
9179  1cc8 5f            	clrw	x
9180  1cc9 97            	ld	xl,a
9181  1cca a601          	ld	a,#1
9182  1ccc e711          	ld	(_i_main_flag,x),a
9183  1cce 2045          	jra	L5253
9184  1cd0               L1404:
9185                     ; 1888 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9187  1cd0 b6c7          	ld	a,_mess+7
9188  1cd2 a1db          	cp	a,#219
9189  1cd4 263f          	jrne	L5253
9191  1cd6 b6c6          	ld	a,_mess+6
9192  1cd8 c10001        	cp	a,_adress
9193  1cdb 2738          	jreq	L5253
9195  1cdd b6c6          	ld	a,_mess+6
9196  1cdf a106          	cp	a,#6
9197  1ce1 2432          	jruge	L5253
9198                     ; 1890 	i_main_bps_cnt[mess[6]]=0;
9200  1ce3 b6c6          	ld	a,_mess+6
9201  1ce5 5f            	clrw	x
9202  1ce6 97            	ld	xl,a
9203  1ce7 6f06          	clr	(_i_main_bps_cnt,x)
9204                     ; 1891 	i_main_flag[mess[6]]=1;		
9206  1ce9 b6c6          	ld	a,_mess+6
9207  1ceb 5f            	clrw	x
9208  1cec 97            	ld	xl,a
9209  1ced a601          	ld	a,#1
9210  1cef e711          	ld	(_i_main_flag,x),a
9211                     ; 1892 	if(bMAIN)
9213                     	btst	_bMAIN
9214  1cf6 241d          	jruge	L5253
9215                     ; 1894 		if(mess[9]==0)i_main_flag[i]=1;
9217  1cf8 3dc9          	tnz	_mess+9
9218  1cfa 260a          	jrne	L3504
9221  1cfc 7b03          	ld	a,(OFST-2,sp)
9222  1cfe 5f            	clrw	x
9223  1cff 97            	ld	xl,a
9224  1d00 a601          	ld	a,#1
9225  1d02 e711          	ld	(_i_main_flag,x),a
9227  1d04 2006          	jra	L5504
9228  1d06               L3504:
9229                     ; 1895 		else i_main_flag[i]=0;
9231  1d06 7b03          	ld	a,(OFST-2,sp)
9232  1d08 5f            	clrw	x
9233  1d09 97            	ld	xl,a
9234  1d0a 6f11          	clr	(_i_main_flag,x)
9235  1d0c               L5504:
9236                     ; 1896 		i_main_flag[adress]=1;
9238  1d0c c60001        	ld	a,_adress
9239  1d0f 5f            	clrw	x
9240  1d10 97            	ld	xl,a
9241  1d11 a601          	ld	a,#1
9242  1d13 e711          	ld	(_i_main_flag,x),a
9243  1d15               L5253:
9244                     ; 1902 can_in_an_end:
9244                     ; 1903 bCAN_RX=0;
9246  1d15 3f09          	clr	_bCAN_RX
9247                     ; 1904 }   
9250  1d17 5b05          	addw	sp,#5
9251  1d19 81            	ret
9274                     ; 1907 void t4_init(void){
9275                     	switch	.text
9276  1d1a               _t4_init:
9280                     ; 1908 	TIM4->PSCR = 4;
9282  1d1a 35045345      	mov	21317,#4
9283                     ; 1909 	TIM4->ARR= 77;
9285  1d1e 354d5346      	mov	21318,#77
9286                     ; 1910 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9288  1d22 72105341      	bset	21313,#0
9289                     ; 1912 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9291  1d26 35855340      	mov	21312,#133
9292                     ; 1914 }
9295  1d2a 81            	ret
9318                     ; 1917 void t1_init(void)
9318                     ; 1918 {
9319                     	switch	.text
9320  1d2b               _t1_init:
9324                     ; 1919 TIM1->ARRH= 0x03;
9326  1d2b 35035262      	mov	21090,#3
9327                     ; 1920 TIM1->ARRL= 0xff;
9329  1d2f 35ff5263      	mov	21091,#255
9330                     ; 1921 TIM1->CCR1H= 0x00;	
9332  1d33 725f5265      	clr	21093
9333                     ; 1922 TIM1->CCR1L= 0xff;
9335  1d37 35ff5266      	mov	21094,#255
9336                     ; 1923 TIM1->CCR2H= 0x00;	
9338  1d3b 725f5267      	clr	21095
9339                     ; 1924 TIM1->CCR2L= 0x00;
9341  1d3f 725f5268      	clr	21096
9342                     ; 1925 TIM1->CCR3H= 0x00;	
9344  1d43 725f5269      	clr	21097
9345                     ; 1926 TIM1->CCR3L= 0x64;
9347  1d47 3564526a      	mov	21098,#100
9348                     ; 1928 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9350  1d4b 35685258      	mov	21080,#104
9351                     ; 1929 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9353  1d4f 35685259      	mov	21081,#104
9354                     ; 1930 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9356  1d53 3568525a      	mov	21082,#104
9357                     ; 1931 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9359  1d57 3511525c      	mov	21084,#17
9360                     ; 1932 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9362  1d5b 3501525d      	mov	21085,#1
9363                     ; 1933 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9365  1d5f 35815250      	mov	21072,#129
9366                     ; 1934 TIM1->BKR|= TIM1_BKR_AOE;
9368  1d63 721c526d      	bset	21101,#6
9369                     ; 1935 }
9372  1d67 81            	ret
9397                     ; 1939 void adc2_init(void)
9397                     ; 1940 {
9398                     	switch	.text
9399  1d68               _adc2_init:
9403                     ; 1941 adc_plazma[0]++;
9405  1d68 beb2          	ldw	x,_adc_plazma
9406  1d6a 1c0001        	addw	x,#1
9407  1d6d bfb2          	ldw	_adc_plazma,x
9408                     ; 1965 GPIOB->DDR&=~(1<<4);
9410  1d6f 72195007      	bres	20487,#4
9411                     ; 1966 GPIOB->CR1&=~(1<<4);
9413  1d73 72195008      	bres	20488,#4
9414                     ; 1967 GPIOB->CR2&=~(1<<4);
9416  1d77 72195009      	bres	20489,#4
9417                     ; 1969 GPIOB->DDR&=~(1<<5);
9419  1d7b 721b5007      	bres	20487,#5
9420                     ; 1970 GPIOB->CR1&=~(1<<5);
9422  1d7f 721b5008      	bres	20488,#5
9423                     ; 1971 GPIOB->CR2&=~(1<<5);
9425  1d83 721b5009      	bres	20489,#5
9426                     ; 1973 GPIOB->DDR&=~(1<<6);
9428  1d87 721d5007      	bres	20487,#6
9429                     ; 1974 GPIOB->CR1&=~(1<<6);
9431  1d8b 721d5008      	bres	20488,#6
9432                     ; 1975 GPIOB->CR2&=~(1<<6);
9434  1d8f 721d5009      	bres	20489,#6
9435                     ; 1977 GPIOB->DDR&=~(1<<7);
9437  1d93 721f5007      	bres	20487,#7
9438                     ; 1978 GPIOB->CR1&=~(1<<7);
9440  1d97 721f5008      	bres	20488,#7
9441                     ; 1979 GPIOB->CR2&=~(1<<7);
9443  1d9b 721f5009      	bres	20489,#7
9444                     ; 1989 ADC2->TDRL=0xff;
9446  1d9f 35ff5407      	mov	21511,#255
9447                     ; 1991 ADC2->CR2=0x08;
9449  1da3 35085402      	mov	21506,#8
9450                     ; 1992 ADC2->CR1=0x40;
9452  1da7 35405401      	mov	21505,#64
9453                     ; 1995 	ADC2->CSR=0x20+adc_ch+3;
9455  1dab b6bf          	ld	a,_adc_ch
9456  1dad ab23          	add	a,#35
9457  1daf c75400        	ld	21504,a
9458                     ; 1997 	ADC2->CR1|=1;
9460  1db2 72105401      	bset	21505,#0
9461                     ; 1998 	ADC2->CR1|=1;
9463  1db6 72105401      	bset	21505,#0
9464                     ; 2001 adc_plazma[1]=adc_ch;
9466  1dba b6bf          	ld	a,_adc_ch
9467  1dbc 5f            	clrw	x
9468  1dbd 97            	ld	xl,a
9469  1dbe bfb4          	ldw	_adc_plazma+2,x
9470                     ; 2002 }
9473  1dc0 81            	ret
9507                     ; 2011 @far @interrupt void TIM4_UPD_Interrupt (void) 
9507                     ; 2012 {
9509                     	switch	.text
9510  1dc1               f_TIM4_UPD_Interrupt:
9514                     ; 2013 TIM4->SR1&=~TIM4_SR1_UIF;
9516  1dc1 72115342      	bres	21314,#0
9517                     ; 2015 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9519  1dc5 3c05          	inc	_pwm_vent_cnt
9520  1dc7 b605          	ld	a,_pwm_vent_cnt
9521  1dc9 a10a          	cp	a,#10
9522  1dcb 2502          	jrult	L7114
9525  1dcd 3f05          	clr	_pwm_vent_cnt
9526  1dcf               L7114:
9527                     ; 2016 GPIOB->ODR|=(1<<3);
9529  1dcf 72165005      	bset	20485,#3
9530                     ; 2017 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9532  1dd3 b605          	ld	a,_pwm_vent_cnt
9533  1dd5 a105          	cp	a,#5
9534  1dd7 2504          	jrult	L1214
9537  1dd9 72175005      	bres	20485,#3
9538  1ddd               L1214:
9539                     ; 2022 if(++t0_cnt0>=100)
9541  1ddd 9c            	rvf
9542  1dde be00          	ldw	x,_t0_cnt0
9543  1de0 1c0001        	addw	x,#1
9544  1de3 bf00          	ldw	_t0_cnt0,x
9545  1de5 a30064        	cpw	x,#100
9546  1de8 2f3f          	jrslt	L3214
9547                     ; 2024 	t0_cnt0=0;
9549  1dea 5f            	clrw	x
9550  1deb bf00          	ldw	_t0_cnt0,x
9551                     ; 2025 	b100Hz=1;
9553  1ded 72100008      	bset	_b100Hz
9554                     ; 2027 	if(++t0_cnt1>=10)
9556  1df1 3c02          	inc	_t0_cnt1
9557  1df3 b602          	ld	a,_t0_cnt1
9558  1df5 a10a          	cp	a,#10
9559  1df7 2506          	jrult	L5214
9560                     ; 2029 		t0_cnt1=0;
9562  1df9 3f02          	clr	_t0_cnt1
9563                     ; 2030 		b10Hz=1;
9565  1dfb 72100007      	bset	_b10Hz
9566  1dff               L5214:
9567                     ; 2033 	if(++t0_cnt2>=20)
9569  1dff 3c03          	inc	_t0_cnt2
9570  1e01 b603          	ld	a,_t0_cnt2
9571  1e03 a114          	cp	a,#20
9572  1e05 2506          	jrult	L7214
9573                     ; 2035 		t0_cnt2=0;
9575  1e07 3f03          	clr	_t0_cnt2
9576                     ; 2036 		b5Hz=1;
9578  1e09 72100006      	bset	_b5Hz
9579  1e0d               L7214:
9580                     ; 2040 	if(++t0_cnt4>=50)
9582  1e0d 3c05          	inc	_t0_cnt4
9583  1e0f b605          	ld	a,_t0_cnt4
9584  1e11 a132          	cp	a,#50
9585  1e13 2506          	jrult	L1314
9586                     ; 2042 		t0_cnt4=0;
9588  1e15 3f05          	clr	_t0_cnt4
9589                     ; 2043 		b2Hz=1;
9591  1e17 72100005      	bset	_b2Hz
9592  1e1b               L1314:
9593                     ; 2046 	if(++t0_cnt3>=100)
9595  1e1b 3c04          	inc	_t0_cnt3
9596  1e1d b604          	ld	a,_t0_cnt3
9597  1e1f a164          	cp	a,#100
9598  1e21 2506          	jrult	L3214
9599                     ; 2048 		t0_cnt3=0;
9601  1e23 3f04          	clr	_t0_cnt3
9602                     ; 2049 		b1Hz=1;
9604  1e25 72100004      	bset	_b1Hz
9605  1e29               L3214:
9606                     ; 2055 }
9609  1e29 80            	iret
9634                     ; 2058 @far @interrupt void CAN_RX_Interrupt (void) 
9634                     ; 2059 {
9635                     	switch	.text
9636  1e2a               f_CAN_RX_Interrupt:
9640                     ; 2061 CAN->PSR= 7;									// page 7 - read messsage
9642  1e2a 35075427      	mov	21543,#7
9643                     ; 2063 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9645  1e2e ae000e        	ldw	x,#14
9646  1e31               L062:
9647  1e31 d65427        	ld	a,(21543,x)
9648  1e34 e7bf          	ld	(_mess-1,x),a
9649  1e36 5a            	decw	x
9650  1e37 26f8          	jrne	L062
9651                     ; 2074 bCAN_RX=1;
9653  1e39 35010009      	mov	_bCAN_RX,#1
9654                     ; 2075 CAN->RFR|=(1<<5);
9656  1e3d 721a5424      	bset	21540,#5
9657                     ; 2077 }
9660  1e41 80            	iret
9683                     ; 2080 @far @interrupt void CAN_TX_Interrupt (void) 
9683                     ; 2081 {
9684                     	switch	.text
9685  1e42               f_CAN_TX_Interrupt:
9689                     ; 2082 if((CAN->TSR)&(1<<0))
9691  1e42 c65422        	ld	a,21538
9692  1e45 a501          	bcp	a,#1
9693  1e47 2708          	jreq	L5514
9694                     ; 2084 	bTX_FREE=1;	
9696  1e49 35010008      	mov	_bTX_FREE,#1
9697                     ; 2086 	CAN->TSR|=(1<<0);
9699  1e4d 72105422      	bset	21538,#0
9700  1e51               L5514:
9701                     ; 2088 }
9704  1e51 80            	iret
9762                     ; 2091 @far @interrupt void ADC2_EOC_Interrupt (void) {
9763                     	switch	.text
9764  1e52               f_ADC2_EOC_Interrupt:
9766       00000009      OFST:	set	9
9767  1e52 be00          	ldw	x,c_x
9768  1e54 89            	pushw	x
9769  1e55 be00          	ldw	x,c_y
9770  1e57 89            	pushw	x
9771  1e58 be02          	ldw	x,c_lreg+2
9772  1e5a 89            	pushw	x
9773  1e5b be00          	ldw	x,c_lreg
9774  1e5d 89            	pushw	x
9775  1e5e 5209          	subw	sp,#9
9778                     ; 2096 adc_plazma[2]++;
9780  1e60 beb6          	ldw	x,_adc_plazma+4
9781  1e62 1c0001        	addw	x,#1
9782  1e65 bfb6          	ldw	_adc_plazma+4,x
9783                     ; 2103 ADC2->CSR&=~(1<<7);
9785  1e67 721f5400      	bres	21504,#7
9786                     ; 2105 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9788  1e6b c65405        	ld	a,21509
9789  1e6e b703          	ld	c_lreg+3,a
9790  1e70 3f02          	clr	c_lreg+2
9791  1e72 3f01          	clr	c_lreg+1
9792  1e74 3f00          	clr	c_lreg
9793  1e76 96            	ldw	x,sp
9794  1e77 1c0001        	addw	x,#OFST-8
9795  1e7a cd0000        	call	c_rtol
9797  1e7d c65404        	ld	a,21508
9798  1e80 5f            	clrw	x
9799  1e81 97            	ld	xl,a
9800  1e82 90ae0100      	ldw	y,#256
9801  1e86 cd0000        	call	c_umul
9803  1e89 96            	ldw	x,sp
9804  1e8a 1c0001        	addw	x,#OFST-8
9805  1e8d cd0000        	call	c_ladd
9807  1e90 96            	ldw	x,sp
9808  1e91 1c0006        	addw	x,#OFST-3
9809  1e94 cd0000        	call	c_rtol
9811                     ; 2110 if(adr_drv_stat==1)
9813  1e97 b607          	ld	a,_adr_drv_stat
9814  1e99 a101          	cp	a,#1
9815  1e9b 260b          	jrne	L5024
9816                     ; 2112 	adr_drv_stat=2;
9818  1e9d 35020007      	mov	_adr_drv_stat,#2
9819                     ; 2113 	adc_buff_[0]=temp_adc;
9821  1ea1 1e08          	ldw	x,(OFST-1,sp)
9822  1ea3 cf0005        	ldw	_adc_buff_,x
9824  1ea6 2020          	jra	L7024
9825  1ea8               L5024:
9826                     ; 2116 else if(adr_drv_stat==3)
9828  1ea8 b607          	ld	a,_adr_drv_stat
9829  1eaa a103          	cp	a,#3
9830  1eac 260b          	jrne	L1124
9831                     ; 2118 	adr_drv_stat=4;
9833  1eae 35040007      	mov	_adr_drv_stat,#4
9834                     ; 2119 	adc_buff_[1]=temp_adc;
9836  1eb2 1e08          	ldw	x,(OFST-1,sp)
9837  1eb4 cf0007        	ldw	_adc_buff_+2,x
9839  1eb7 200f          	jra	L7024
9840  1eb9               L1124:
9841                     ; 2122 else if(adr_drv_stat==5)
9843  1eb9 b607          	ld	a,_adr_drv_stat
9844  1ebb a105          	cp	a,#5
9845  1ebd 2609          	jrne	L7024
9846                     ; 2124 	adr_drv_stat=6;
9848  1ebf 35060007      	mov	_adr_drv_stat,#6
9849                     ; 2125 	adc_buff_[9]=temp_adc;
9851  1ec3 1e08          	ldw	x,(OFST-1,sp)
9852  1ec5 cf0017        	ldw	_adc_buff_+18,x
9853  1ec8               L7024:
9854                     ; 2128 adc_buff[adc_ch][adc_cnt]=temp_adc;
9856  1ec8 b6be          	ld	a,_adc_cnt
9857  1eca 5f            	clrw	x
9858  1ecb 97            	ld	xl,a
9859  1ecc 58            	sllw	x
9860  1ecd 1f03          	ldw	(OFST-6,sp),x
9861  1ecf b6bf          	ld	a,_adc_ch
9862  1ed1 97            	ld	xl,a
9863  1ed2 a620          	ld	a,#32
9864  1ed4 42            	mul	x,a
9865  1ed5 72fb03        	addw	x,(OFST-6,sp)
9866  1ed8 1608          	ldw	y,(OFST-1,sp)
9867  1eda df0019        	ldw	(_adc_buff,x),y
9868                     ; 2134 adc_ch++;
9870  1edd 3cbf          	inc	_adc_ch
9871                     ; 2135 if(adc_ch>=5)
9873  1edf b6bf          	ld	a,_adc_ch
9874  1ee1 a105          	cp	a,#5
9875  1ee3 250c          	jrult	L7124
9876                     ; 2138 	adc_ch=0;
9878  1ee5 3fbf          	clr	_adc_ch
9879                     ; 2139 	adc_cnt++;
9881  1ee7 3cbe          	inc	_adc_cnt
9882                     ; 2140 	if(adc_cnt>=16)
9884  1ee9 b6be          	ld	a,_adc_cnt
9885  1eeb a110          	cp	a,#16
9886  1eed 2502          	jrult	L7124
9887                     ; 2142 		adc_cnt=0;
9889  1eef 3fbe          	clr	_adc_cnt
9890  1ef1               L7124:
9891                     ; 2146 if((adc_cnt&0x03)==0)
9893  1ef1 b6be          	ld	a,_adc_cnt
9894  1ef3 a503          	bcp	a,#3
9895  1ef5 264b          	jrne	L3224
9896                     ; 2150 	tempSS=0;
9898  1ef7 ae0000        	ldw	x,#0
9899  1efa 1f08          	ldw	(OFST-1,sp),x
9900  1efc ae0000        	ldw	x,#0
9901  1eff 1f06          	ldw	(OFST-3,sp),x
9902                     ; 2151 	for(i=0;i<16;i++)
9904  1f01 0f05          	clr	(OFST-4,sp)
9905  1f03               L5224:
9906                     ; 2153 		tempSS+=(signed long)adc_buff[adc_ch][i];
9908  1f03 7b05          	ld	a,(OFST-4,sp)
9909  1f05 5f            	clrw	x
9910  1f06 97            	ld	xl,a
9911  1f07 58            	sllw	x
9912  1f08 1f03          	ldw	(OFST-6,sp),x
9913  1f0a b6bf          	ld	a,_adc_ch
9914  1f0c 97            	ld	xl,a
9915  1f0d a620          	ld	a,#32
9916  1f0f 42            	mul	x,a
9917  1f10 72fb03        	addw	x,(OFST-6,sp)
9918  1f13 de0019        	ldw	x,(_adc_buff,x)
9919  1f16 cd0000        	call	c_itolx
9921  1f19 96            	ldw	x,sp
9922  1f1a 1c0006        	addw	x,#OFST-3
9923  1f1d cd0000        	call	c_lgadd
9925                     ; 2151 	for(i=0;i<16;i++)
9927  1f20 0c05          	inc	(OFST-4,sp)
9930  1f22 7b05          	ld	a,(OFST-4,sp)
9931  1f24 a110          	cp	a,#16
9932  1f26 25db          	jrult	L5224
9933                     ; 2155 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9935  1f28 96            	ldw	x,sp
9936  1f29 1c0006        	addw	x,#OFST-3
9937  1f2c cd0000        	call	c_ltor
9939  1f2f a604          	ld	a,#4
9940  1f31 cd0000        	call	c_lrsh
9942  1f34 be02          	ldw	x,c_lreg+2
9943  1f36 b6bf          	ld	a,_adc_ch
9944  1f38 905f          	clrw	y
9945  1f3a 9097          	ld	yl,a
9946  1f3c 9058          	sllw	y
9947  1f3e 90df0005      	ldw	(_adc_buff_,y),x
9948  1f42               L3224:
9949                     ; 2166 adc_plazma_short++;
9951  1f42 bebc          	ldw	x,_adc_plazma_short
9952  1f44 1c0001        	addw	x,#1
9953  1f47 bfbc          	ldw	_adc_plazma_short,x
9954                     ; 2181 }
9957  1f49 5b09          	addw	sp,#9
9958  1f4b 85            	popw	x
9959  1f4c bf00          	ldw	c_lreg,x
9960  1f4e 85            	popw	x
9961  1f4f bf02          	ldw	c_lreg+2,x
9962  1f51 85            	popw	x
9963  1f52 bf00          	ldw	c_y,x
9964  1f54 85            	popw	x
9965  1f55 bf00          	ldw	c_x,x
9966  1f57 80            	iret
10029                     ; 2189 main()
10029                     ; 2190 {
10031                     	switch	.text
10032  1f58               _main:
10036                     ; 2192 CLK->ECKR|=1;
10038  1f58 721050c1      	bset	20673,#0
10040  1f5c               L5424:
10041                     ; 2193 while((CLK->ECKR & 2) == 0);
10043  1f5c c650c1        	ld	a,20673
10044  1f5f a502          	bcp	a,#2
10045  1f61 27f9          	jreq	L5424
10046                     ; 2194 CLK->SWCR|=2;
10048  1f63 721250c5      	bset	20677,#1
10049                     ; 2195 CLK->SWR=0xB4;
10051  1f67 35b450c4      	mov	20676,#180
10052                     ; 2196 BLOCK_INIT
10054  1f6b 72145007      	bset	20487,#2
10057  1f6f 72145008      	bset	20488,#2
10060  1f73 72155009      	bres	20489,#2
10061                     ; 2197 BLOCK_ON
10063  1f77 72145005      	bset	20485,#2
10064                     ; 2199 delay_ms(200);
10066  1f7b ae00c8        	ldw	x,#200
10067  1f7e cd004c        	call	_delay_ms
10069                     ; 2200 FLASH_DUKR=0xae;
10071  1f81 35ae5064      	mov	_FLASH_DUKR,#174
10072                     ; 2201 FLASH_DUKR=0x56;
10074  1f85 35565064      	mov	_FLASH_DUKR,#86
10075                     ; 2202 enableInterrupts();
10078  1f89 9a            rim
10080                     ; 2225 adr_drv_v4();
10083  1f8a cd121c        	call	_adr_drv_v4
10085                     ; 2229 t4_init();
10087  1f8d cd1d1a        	call	_t4_init
10089                     ; 2231 		GPIOG->DDR|=(1<<0);
10091  1f90 72105020      	bset	20512,#0
10092                     ; 2232 		GPIOG->CR1|=(1<<0);
10094  1f94 72105021      	bset	20513,#0
10095                     ; 2233 		GPIOG->CR2&=~(1<<0);	
10097  1f98 72115022      	bres	20514,#0
10098                     ; 2236 		GPIOG->DDR&=~(1<<1);
10100  1f9c 72135020      	bres	20512,#1
10101                     ; 2237 		GPIOG->CR1|=(1<<1);
10103  1fa0 72125021      	bset	20513,#1
10104                     ; 2238 		GPIOG->CR2&=~(1<<1);
10106  1fa4 72135022      	bres	20514,#1
10107                     ; 2240 init_CAN();
10109  1fa8 cd14d1        	call	_init_CAN
10111                     ; 2245 GPIOC->DDR|=(1<<1);
10113  1fab 7212500c      	bset	20492,#1
10114                     ; 2246 GPIOC->CR1|=(1<<1);
10116  1faf 7212500d      	bset	20493,#1
10117                     ; 2247 GPIOC->CR2|=(1<<1);
10119  1fb3 7212500e      	bset	20494,#1
10120                     ; 2249 GPIOC->DDR|=(1<<2);
10122  1fb7 7214500c      	bset	20492,#2
10123                     ; 2250 GPIOC->CR1|=(1<<2);
10125  1fbb 7214500d      	bset	20493,#2
10126                     ; 2251 GPIOC->CR2|=(1<<2);
10128  1fbf 7214500e      	bset	20494,#2
10129                     ; 2258 t1_init();
10131  1fc3 cd1d2b        	call	_t1_init
10133                     ; 2260 GPIOA->DDR|=(1<<5);
10135  1fc6 721a5002      	bset	20482,#5
10136                     ; 2261 GPIOA->CR1|=(1<<5);
10138  1fca 721a5003      	bset	20483,#5
10139                     ; 2262 GPIOA->CR2&=~(1<<5);
10141  1fce 721b5004      	bres	20484,#5
10142                     ; 2268 GPIOB->DDR|=(1<<3);
10144  1fd2 72165007      	bset	20487,#3
10145                     ; 2269 GPIOB->CR1|=(1<<3);
10147  1fd6 72165008      	bset	20488,#3
10148                     ; 2270 GPIOB->CR2|=(1<<3);
10150  1fda 72165009      	bset	20489,#3
10151                     ; 2272 GPIOC->DDR|=(1<<3);
10153  1fde 7216500c      	bset	20492,#3
10154                     ; 2273 GPIOC->CR1|=(1<<3);
10156  1fe2 7216500d      	bset	20493,#3
10157                     ; 2274 GPIOC->CR2|=(1<<3);
10159  1fe6 7216500e      	bset	20494,#3
10160                     ; 2277 if(bps_class==bpsIPS) 
10162  1fea b601          	ld	a,_bps_class
10163  1fec a101          	cp	a,#1
10164  1fee 260a          	jrne	L3524
10165                     ; 2279 	pwm_u=ee_U_AVT;
10167  1ff0 ce000a        	ldw	x,_ee_U_AVT
10168  1ff3 bf0b          	ldw	_pwm_u,x
10169                     ; 2280 	volum_u_main_=ee_U_AVT;
10171  1ff5 ce000a        	ldw	x,_ee_U_AVT
10172  1ff8 bf1c          	ldw	_volum_u_main_,x
10173  1ffa               L3524:
10174                     ; 2287 	if(bCAN_RX)
10176  1ffa 3d09          	tnz	_bCAN_RX
10177  1ffc 2705          	jreq	L7524
10178                     ; 2289 		bCAN_RX=0;
10180  1ffe 3f09          	clr	_bCAN_RX
10181                     ; 2290 		can_in_an();	
10183  2000 cd16dc        	call	_can_in_an
10185  2003               L7524:
10186                     ; 2292 	if(b100Hz)
10188                     	btst	_b100Hz
10189  2008 240a          	jruge	L1624
10190                     ; 2294 		b100Hz=0;
10192  200a 72110008      	bres	_b100Hz
10193                     ; 2303 		adc2_init();
10195  200e cd1d68        	call	_adc2_init
10197                     ; 2304 		can_tx_hndl();
10199  2011 cd15c4        	call	_can_tx_hndl
10201  2014               L1624:
10202                     ; 2307 	if(b10Hz)
10204                     	btst	_b10Hz
10205  2019 2419          	jruge	L3624
10206                     ; 2309 		b10Hz=0;
10208  201b 72110007      	bres	_b10Hz
10209                     ; 2311           matemat();
10211  201f cd0bca        	call	_matemat
10213                     ; 2312 	    	led_drv(); 
10215  2022 cd0711        	call	_led_drv
10217                     ; 2313 	     link_drv();
10219  2025 cd07ff        	call	_link_drv
10221                     ; 2314 	     pwr_hndl();		//вычисление воздействий на силу
10223  2028 cd0aae        	call	_pwr_hndl
10225                     ; 2315 	     JP_drv();
10227  202b cd0774        	call	_JP_drv
10229                     ; 2316 	     flags_drv();
10231  202e cd0fc8        	call	_flags_drv
10233                     ; 2317 		net_drv();
10235  2031 cd162e        	call	_net_drv
10237  2034               L3624:
10238                     ; 2320 	if(b5Hz)
10240                     	btst	_b5Hz
10241  2039 240d          	jruge	L5624
10242                     ; 2322 		b5Hz=0;
10244  203b 72110006      	bres	_b5Hz
10245                     ; 2324 		pwr_drv();		//воздействие на силу
10247  203f cd09aa        	call	_pwr_drv
10249                     ; 2325 		led_hndl();
10251  2042 cd008e        	call	_led_hndl
10253                     ; 2327 		vent_drv();
10255  2045 cd084e        	call	_vent_drv
10257  2048               L5624:
10258                     ; 2330 	if(b2Hz)
10260                     	btst	_b2Hz
10261  204d 2404          	jruge	L7624
10262                     ; 2332 		b2Hz=0;
10264  204f 72110005      	bres	_b2Hz
10265  2053               L7624:
10266                     ; 2341 	if(b1Hz)
10268                     	btst	_b1Hz
10269  2058 24a0          	jruge	L3524
10270                     ; 2343 		b1Hz=0;
10272  205a 72110004      	bres	_b1Hz
10273                     ; 2345 		temper_drv();			//вычисление аварий температуры
10275  205e cd0cf8        	call	_temper_drv
10277                     ; 2346 		u_drv();
10279  2061 cd0dcf        	call	_u_drv
10281                     ; 2347           x_drv();
10283  2064 cd0eaf        	call	_x_drv
10285                     ; 2348           if(main_cnt<1000)main_cnt++;
10287  2067 9c            	rvf
10288  2068 be4e          	ldw	x,_main_cnt
10289  206a a303e8        	cpw	x,#1000
10290  206d 2e07          	jrsge	L3724
10293  206f be4e          	ldw	x,_main_cnt
10294  2071 1c0001        	addw	x,#1
10295  2074 bf4e          	ldw	_main_cnt,x
10296  2076               L3724:
10297                     ; 2349   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10299  2076 b65f          	ld	a,_link
10300  2078 a1aa          	cp	a,#170
10301  207a 2706          	jreq	L7724
10303  207c b647          	ld	a,_jp_mode
10304  207e a103          	cp	a,#3
10305  2080 2603          	jrne	L5724
10306  2082               L7724:
10309  2082 cd0f29        	call	_apv_hndl
10311  2085               L5724:
10312                     ; 2352   		can_error_cnt++;
10314  2085 3c6d          	inc	_can_error_cnt
10315                     ; 2353   		if(can_error_cnt>=10)
10317  2087 b66d          	ld	a,_can_error_cnt
10318  2089 a10a          	cp	a,#10
10319  208b 2505          	jrult	L1034
10320                     ; 2355   			can_error_cnt=0;
10322  208d 3f6d          	clr	_can_error_cnt
10323                     ; 2356 			init_CAN();
10325  208f cd14d1        	call	_init_CAN
10327  2092               L1034:
10328                     ; 2360 		volum_u_main_drv();
10330  2092 cd137e        	call	_volum_u_main_drv
10332                     ; 2362 		pwm_stat++;
10334  2095 3c04          	inc	_pwm_stat
10335                     ; 2363 		if(pwm_stat>=10)pwm_stat=0;
10337  2097 b604          	ld	a,_pwm_stat
10338  2099 a10a          	cp	a,#10
10339  209b 2502          	jrult	L3034
10342  209d 3f04          	clr	_pwm_stat
10343  209f               L3034:
10344                     ; 2364 adc_plazma_short++;
10346  209f bebc          	ldw	x,_adc_plazma_short
10347  20a1 1c0001        	addw	x,#1
10348  20a4 bfbc          	ldw	_adc_plazma_short,x
10349  20a6 acfa1ffa      	jpf	L3524
11363                     	xdef	_main
11364                     	xdef	f_ADC2_EOC_Interrupt
11365                     	xdef	f_CAN_TX_Interrupt
11366                     	xdef	f_CAN_RX_Interrupt
11367                     	xdef	f_TIM4_UPD_Interrupt
11368                     	xdef	_adc2_init
11369                     	xdef	_t1_init
11370                     	xdef	_t4_init
11371                     	xdef	_can_in_an
11372                     	xdef	_net_drv
11373                     	xdef	_can_tx_hndl
11374                     	xdef	_can_transmit
11375                     	xdef	_init_CAN
11376                     	xdef	_volum_u_main_drv
11377                     	xdef	_adr_drv_v4
11378                     	xdef	_adr_drv_v3
11379                     	xdef	_adr_gran
11380                     	xdef	_flags_drv
11381                     	xdef	_apv_hndl
11382                     	xdef	_apv_stop
11383                     	xdef	_apv_start
11384                     	xdef	_x_drv
11385                     	xdef	_u_drv
11386                     	xdef	_temper_drv
11387                     	xdef	_matemat
11388                     	xdef	_pwr_hndl
11389                     	xdef	_pwr_drv
11390                     	xdef	_vent_drv
11391                     	xdef	_link_drv
11392                     	xdef	_JP_drv
11393                     	xdef	_led_drv
11394                     	xdef	_led_hndl
11395                     	xdef	_delay_ms
11396                     	xdef	_granee
11397                     	xdef	_gran
11398                     .eeprom:	section	.data
11399  0000               _ee_IMAXVENT:
11400  0000 0000          	ds.b	2
11401                     	xdef	_ee_IMAXVENT
11402                     	switch	.ubsct
11403  0001               _bps_class:
11404  0001 00            	ds.b	1
11405                     	xdef	_bps_class
11406  0002               _vent_pwm:
11407  0002 0000          	ds.b	2
11408                     	xdef	_vent_pwm
11409  0004               _pwm_stat:
11410  0004 00            	ds.b	1
11411                     	xdef	_pwm_stat
11412  0005               _pwm_vent_cnt:
11413  0005 00            	ds.b	1
11414                     	xdef	_pwm_vent_cnt
11415                     	switch	.eeprom
11416  0002               _ee_DEVICE:
11417  0002 0000          	ds.b	2
11418                     	xdef	_ee_DEVICE
11419  0004               _ee_AVT_MODE:
11420  0004 0000          	ds.b	2
11421                     	xdef	_ee_AVT_MODE
11422                     	switch	.ubsct
11423  0006               _i_main_bps_cnt:
11424  0006 000000000000  	ds.b	6
11425                     	xdef	_i_main_bps_cnt
11426  000c               _i_main_sigma:
11427  000c 0000          	ds.b	2
11428                     	xdef	_i_main_sigma
11429  000e               _i_main_num_of_bps:
11430  000e 00            	ds.b	1
11431                     	xdef	_i_main_num_of_bps
11432  000f               _i_main_avg:
11433  000f 0000          	ds.b	2
11434                     	xdef	_i_main_avg
11435  0011               _i_main_flag:
11436  0011 000000000000  	ds.b	6
11437                     	xdef	_i_main_flag
11438  0017               _i_main:
11439  0017 000000000000  	ds.b	12
11440                     	xdef	_i_main
11441  0023               _x:
11442  0023 000000000000  	ds.b	12
11443                     	xdef	_x
11444                     	xdef	_volum_u_main_
11445                     	switch	.eeprom
11446  0006               _UU_AVT:
11447  0006 0000          	ds.b	2
11448                     	xdef	_UU_AVT
11449                     	switch	.ubsct
11450  002f               _cnt_net_drv:
11451  002f 00            	ds.b	1
11452                     	xdef	_cnt_net_drv
11453                     	switch	.bit
11454  0001               _bMAIN:
11455  0001 00            	ds.b	1
11456                     	xdef	_bMAIN
11457                     	switch	.ubsct
11458  0030               _plazma_int:
11459  0030 000000000000  	ds.b	6
11460                     	xdef	_plazma_int
11461                     	xdef	_rotor_int
11462  0036               _led_green_buff:
11463  0036 00000000      	ds.b	4
11464                     	xdef	_led_green_buff
11465  003a               _led_red_buff:
11466  003a 00000000      	ds.b	4
11467                     	xdef	_led_red_buff
11468                     	xdef	_led_drv_cnt
11469                     	xdef	_led_green
11470                     	xdef	_led_red
11471  003e               _res_fl_cnt:
11472  003e 00            	ds.b	1
11473                     	xdef	_res_fl_cnt
11474                     	xdef	_bRES_
11475                     	xdef	_bRES
11476                     	switch	.eeprom
11477  0008               _res_fl_:
11478  0008 00            	ds.b	1
11479                     	xdef	_res_fl_
11480  0009               _res_fl:
11481  0009 00            	ds.b	1
11482                     	xdef	_res_fl
11483                     	switch	.ubsct
11484  003f               _cnt_apv_off:
11485  003f 00            	ds.b	1
11486                     	xdef	_cnt_apv_off
11487                     	switch	.bit
11488  0002               _bAPV:
11489  0002 00            	ds.b	1
11490                     	xdef	_bAPV
11491                     	switch	.ubsct
11492  0040               _apv_cnt_:
11493  0040 0000          	ds.b	2
11494                     	xdef	_apv_cnt_
11495  0042               _apv_cnt:
11496  0042 000000        	ds.b	3
11497                     	xdef	_apv_cnt
11498                     	xdef	_bBL_IPS
11499                     	switch	.bit
11500  0003               _bBL:
11501  0003 00            	ds.b	1
11502                     	xdef	_bBL
11503                     	switch	.ubsct
11504  0045               _cnt_JP1:
11505  0045 00            	ds.b	1
11506                     	xdef	_cnt_JP1
11507  0046               _cnt_JP0:
11508  0046 00            	ds.b	1
11509                     	xdef	_cnt_JP0
11510  0047               _jp_mode:
11511  0047 00            	ds.b	1
11512                     	xdef	_jp_mode
11513                     	xdef	_pwm_i
11514                     	xdef	_pwm_u
11515  0048               _tmax_cnt:
11516  0048 0000          	ds.b	2
11517                     	xdef	_tmax_cnt
11518  004a               _tsign_cnt:
11519  004a 0000          	ds.b	2
11520                     	xdef	_tsign_cnt
11521                     	switch	.eeprom
11522  000a               _ee_U_AVT:
11523  000a 0000          	ds.b	2
11524                     	xdef	_ee_U_AVT
11525  000c               _ee_tsign:
11526  000c 0000          	ds.b	2
11527                     	xdef	_ee_tsign
11528  000e               _ee_tmax:
11529  000e 0000          	ds.b	2
11530                     	xdef	_ee_tmax
11531  0010               _ee_dU:
11532  0010 0000          	ds.b	2
11533                     	xdef	_ee_dU
11534  0012               _ee_Umax:
11535  0012 0000          	ds.b	2
11536                     	xdef	_ee_Umax
11537  0014               _ee_TZAS:
11538  0014 0000          	ds.b	2
11539                     	xdef	_ee_TZAS
11540                     	switch	.ubsct
11541  004c               _main_cnt1:
11542  004c 0000          	ds.b	2
11543                     	xdef	_main_cnt1
11544  004e               _main_cnt:
11545  004e 0000          	ds.b	2
11546                     	xdef	_main_cnt
11547  0050               _off_bp_cnt:
11548  0050 00            	ds.b	1
11549                     	xdef	_off_bp_cnt
11550  0051               _flags_tu_cnt_off:
11551  0051 00            	ds.b	1
11552                     	xdef	_flags_tu_cnt_off
11553  0052               _flags_tu_cnt_on:
11554  0052 00            	ds.b	1
11555                     	xdef	_flags_tu_cnt_on
11556  0053               _vol_i_temp:
11557  0053 0000          	ds.b	2
11558                     	xdef	_vol_i_temp
11559  0055               _vol_u_temp:
11560  0055 0000          	ds.b	2
11561                     	xdef	_vol_u_temp
11562                     	switch	.eeprom
11563  0016               __x_ee_:
11564  0016 0000          	ds.b	2
11565                     	xdef	__x_ee_
11566                     	switch	.ubsct
11567  0057               __x_cnt:
11568  0057 0000          	ds.b	2
11569                     	xdef	__x_cnt
11570  0059               __x__:
11571  0059 0000          	ds.b	2
11572                     	xdef	__x__
11573  005b               __x_:
11574  005b 0000          	ds.b	2
11575                     	xdef	__x_
11576  005d               _flags_tu:
11577  005d 00            	ds.b	1
11578                     	xdef	_flags_tu
11579                     	xdef	_flags
11580  005e               _link_cnt:
11581  005e 00            	ds.b	1
11582                     	xdef	_link_cnt
11583  005f               _link:
11584  005f 00            	ds.b	1
11585                     	xdef	_link
11586  0060               _umin_cnt:
11587  0060 0000          	ds.b	2
11588                     	xdef	_umin_cnt
11589  0062               _umax_cnt:
11590  0062 0000          	ds.b	2
11591                     	xdef	_umax_cnt
11592                     	switch	.eeprom
11593  0018               _ee_K:
11594  0018 000000000000  	ds.b	16
11595                     	xdef	_ee_K
11596                     	switch	.ubsct
11597  0064               _T:
11598  0064 00            	ds.b	1
11599                     	xdef	_T
11600  0065               _Udb:
11601  0065 0000          	ds.b	2
11602                     	xdef	_Udb
11603  0067               _Ui:
11604  0067 0000          	ds.b	2
11605                     	xdef	_Ui
11606  0069               _Un:
11607  0069 0000          	ds.b	2
11608                     	xdef	_Un
11609  006b               _I:
11610  006b 0000          	ds.b	2
11611                     	xdef	_I
11612  006d               _can_error_cnt:
11613  006d 00            	ds.b	1
11614                     	xdef	_can_error_cnt
11615                     	xdef	_bCAN_RX
11616  006e               _tx_busy_cnt:
11617  006e 00            	ds.b	1
11618                     	xdef	_tx_busy_cnt
11619                     	xdef	_bTX_FREE
11620  006f               _can_buff_rd_ptr:
11621  006f 00            	ds.b	1
11622                     	xdef	_can_buff_rd_ptr
11623  0070               _can_buff_wr_ptr:
11624  0070 00            	ds.b	1
11625                     	xdef	_can_buff_wr_ptr
11626  0071               _can_out_buff:
11627  0071 000000000000  	ds.b	64
11628                     	xdef	_can_out_buff
11629                     	switch	.bss
11630  0000               _adress_error:
11631  0000 00            	ds.b	1
11632                     	xdef	_adress_error
11633  0001               _adress:
11634  0001 00            	ds.b	1
11635                     	xdef	_adress
11636  0002               _adr:
11637  0002 000000        	ds.b	3
11638                     	xdef	_adr
11639                     	xdef	_adr_drv_stat
11640                     	xdef	_led_ind
11641                     	switch	.ubsct
11642  00b1               _led_ind_cnt:
11643  00b1 00            	ds.b	1
11644                     	xdef	_led_ind_cnt
11645  00b2               _adc_plazma:
11646  00b2 000000000000  	ds.b	10
11647                     	xdef	_adc_plazma
11648  00bc               _adc_plazma_short:
11649  00bc 0000          	ds.b	2
11650                     	xdef	_adc_plazma_short
11651  00be               _adc_cnt:
11652  00be 00            	ds.b	1
11653                     	xdef	_adc_cnt
11654  00bf               _adc_ch:
11655  00bf 00            	ds.b	1
11656                     	xdef	_adc_ch
11657                     	switch	.bss
11658  0005               _adc_buff_:
11659  0005 000000000000  	ds.b	20
11660                     	xdef	_adc_buff_
11661  0019               _adc_buff:
11662  0019 000000000000  	ds.b	320
11663                     	xdef	_adc_buff
11664                     	switch	.ubsct
11665  00c0               _mess:
11666  00c0 000000000000  	ds.b	14
11667                     	xdef	_mess
11668                     	switch	.bit
11669  0004               _b1Hz:
11670  0004 00            	ds.b	1
11671                     	xdef	_b1Hz
11672  0005               _b2Hz:
11673  0005 00            	ds.b	1
11674                     	xdef	_b2Hz
11675  0006               _b5Hz:
11676  0006 00            	ds.b	1
11677                     	xdef	_b5Hz
11678  0007               _b10Hz:
11679  0007 00            	ds.b	1
11680                     	xdef	_b10Hz
11681  0008               _b100Hz:
11682  0008 00            	ds.b	1
11683                     	xdef	_b100Hz
11684                     	xdef	_t0_cnt4
11685                     	xdef	_t0_cnt3
11686                     	xdef	_t0_cnt2
11687                     	xdef	_t0_cnt1
11688                     	xdef	_t0_cnt0
11689                     	xref.b	c_lreg
11690                     	xref.b	c_x
11691                     	xref.b	c_y
11711                     	xref	c_lrsh
11712                     	xref	c_lgadd
11713                     	xref	c_ladd
11714                     	xref	c_umul
11715                     	xref	c_lgmul
11716                     	xref	c_lgsub
11717                     	xref	c_lsbc
11718                     	xref	c_idiv
11719                     	xref	c_ldiv
11720                     	xref	c_itolx
11721                     	xref	c_eewrc
11722                     	xref	c_imul
11723                     	xref	c_lcmp
11724                     	xref	c_ltor
11725                     	xref	c_lgadc
11726                     	xref	c_rtol
11727                     	xref	c_vmul
11728                     	xref	c_eewrw
11729                     	end
