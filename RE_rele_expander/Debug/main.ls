   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2172                     	switch	.data
2173  0000               _t0_cnt00:
2174  0000 0000          	dc.w	0
2175  0002               _t0_cnt0:
2176  0002 0000          	dc.w	0
2177  0004               _t0_cnt1:
2178  0004 00            	dc.b	0
2179  0005               _t0_cnt2:
2180  0005 00            	dc.b	0
2181  0006               _t0_cnt3:
2182  0006 00            	dc.b	0
2183  0007               _t0_cnt4:
2184  0007 00            	dc.b	0
2185                     	bsct
2186  0000               _led_ind:
2187  0000 05            	dc.b	5
2188  0001               _adr_drv_stat:
2189  0001 00            	dc.b	0
2190  0002               _bTX_FREE:
2191  0002 01            	dc.b	1
2192  0003               _bCAN_RX:
2193  0003 00            	dc.b	0
2194                     .bit:	section	.data,bit
2195  0000               _bBL_IPS:
2196  0000 00            	dc.b	0
2197                     	bsct
2198  0004               _bRES:
2199  0004 00            	dc.b	0
2200  0005               _bRES_:
2201  0005 00            	dc.b	0
2202  0006               _led_red:
2203  0006 00000000      	dc.l	0
2204  000a               _led_green:
2205  000a 03030303      	dc.l	50529027
2206  000e               _led_drv_cnt:
2207  000e 1e            	dc.b	30
2208  000f               _rotor_int:
2209  000f 007b          	dc.w	123
2268                     ; 114 void gran(signed short *adr, signed short min, signed short max)
2268                     ; 115 {
2270                     	switch	.text
2271  0000               _gran:
2273  0000 89            	pushw	x
2274       00000000      OFST:	set	0
2277                     ; 116 if (*adr<min) *adr=min;
2279  0001 9c            	rvf
2280  0002 9093          	ldw	y,x
2281  0004 51            	exgw	x,y
2282  0005 fe            	ldw	x,(x)
2283  0006 1305          	cpw	x,(OFST+5,sp)
2284  0008 51            	exgw	x,y
2285  0009 2e03          	jrsge	L7541
2288  000b 1605          	ldw	y,(OFST+5,sp)
2289  000d ff            	ldw	(x),y
2290  000e               L7541:
2291                     ; 117 if (*adr>max) *adr=max; 
2293  000e 9c            	rvf
2294  000f 1e01          	ldw	x,(OFST+1,sp)
2295  0011 9093          	ldw	y,x
2296  0013 51            	exgw	x,y
2297  0014 fe            	ldw	x,(x)
2298  0015 1307          	cpw	x,(OFST+7,sp)
2299  0017 51            	exgw	x,y
2300  0018 2d05          	jrsle	L1641
2303  001a 1e01          	ldw	x,(OFST+1,sp)
2304  001c 1607          	ldw	y,(OFST+7,sp)
2305  001e ff            	ldw	(x),y
2306  001f               L1641:
2307                     ; 118 } 
2310  001f 85            	popw	x
2311  0020 81            	ret
2364                     ; 121 void granee(@eeprom signed short *adr, signed short min, signed short max)
2364                     ; 122 {
2365                     	switch	.text
2366  0021               _granee:
2368  0021 89            	pushw	x
2369       00000000      OFST:	set	0
2372                     ; 123 if (*adr<min) *adr=min;
2374  0022 9c            	rvf
2375  0023 9093          	ldw	y,x
2376  0025 51            	exgw	x,y
2377  0026 fe            	ldw	x,(x)
2378  0027 1305          	cpw	x,(OFST+5,sp)
2379  0029 51            	exgw	x,y
2380  002a 2e09          	jrsge	L1151
2383  002c 1e05          	ldw	x,(OFST+5,sp)
2384  002e 89            	pushw	x
2385  002f 1e03          	ldw	x,(OFST+3,sp)
2386  0031 cd0000        	call	c_eewrw
2388  0034 85            	popw	x
2389  0035               L1151:
2390                     ; 124 if (*adr>max) *adr=max; 
2392  0035 9c            	rvf
2393  0036 1e01          	ldw	x,(OFST+1,sp)
2394  0038 9093          	ldw	y,x
2395  003a 51            	exgw	x,y
2396  003b fe            	ldw	x,(x)
2397  003c 1307          	cpw	x,(OFST+7,sp)
2398  003e 51            	exgw	x,y
2399  003f 2d09          	jrsle	L3151
2402  0041 1e07          	ldw	x,(OFST+7,sp)
2403  0043 89            	pushw	x
2404  0044 1e03          	ldw	x,(OFST+3,sp)
2405  0046 cd0000        	call	c_eewrw
2407  0049 85            	popw	x
2408  004a               L3151:
2409                     ; 125 }
2412  004a 85            	popw	x
2413  004b 81            	ret
2474                     ; 128 long delay_ms(short in)
2474                     ; 129 {
2475                     	switch	.text
2476  004c               _delay_ms:
2478  004c 520c          	subw	sp,#12
2479       0000000c      OFST:	set	12
2482                     ; 132 i=((long)in)*100UL;
2484  004e 90ae0064      	ldw	y,#100
2485  0052 cd0000        	call	c_vmul
2487  0055 96            	ldw	x,sp
2488  0056 1c0005        	addw	x,#OFST-7
2489  0059 cd0000        	call	c_rtol
2491                     ; 134 for(ii=0;ii<i;ii++)
2493  005c ae0000        	ldw	x,#0
2494  005f 1f0b          	ldw	(OFST-1,sp),x
2495  0061 ae0000        	ldw	x,#0
2496  0064 1f09          	ldw	(OFST-3,sp),x
2498  0066 2012          	jra	L3551
2499  0068               L7451:
2500                     ; 136 		iii++;
2502  0068 96            	ldw	x,sp
2503  0069 1c0001        	addw	x,#OFST-11
2504  006c a601          	ld	a,#1
2505  006e cd0000        	call	c_lgadc
2507                     ; 134 for(ii=0;ii<i;ii++)
2509  0071 96            	ldw	x,sp
2510  0072 1c0009        	addw	x,#OFST-3
2511  0075 a601          	ld	a,#1
2512  0077 cd0000        	call	c_lgadc
2514  007a               L3551:
2517  007a 9c            	rvf
2518  007b 96            	ldw	x,sp
2519  007c 1c0009        	addw	x,#OFST-3
2520  007f cd0000        	call	c_ltor
2522  0082 96            	ldw	x,sp
2523  0083 1c0005        	addw	x,#OFST-7
2524  0086 cd0000        	call	c_lcmp
2526  0089 2fdd          	jrslt	L7451
2527                     ; 139 }
2530  008b 5b0c          	addw	sp,#12
2531  008d 81            	ret
2559                     ; 142 void led_hndl(void)
2559                     ; 143 {
2560                     	switch	.text
2561  008e               _led_hndl:
2565                     ; 144 if(adress_error)
2567  008e 725d0010      	tnz	_adress_error
2568  0092 2714          	jreq	L7651
2569                     ; 146 	led_red=0x55555555L;
2571  0094 ae5555        	ldw	x,#21845
2572  0097 bf08          	ldw	_led_red+2,x
2573  0099 ae5555        	ldw	x,#21845
2574  009c bf06          	ldw	_led_red,x
2575                     ; 147 	led_green=0x55555555L;
2577  009e ae5555        	ldw	x,#21845
2578  00a1 bf0c          	ldw	_led_green+2,x
2579  00a3 ae5555        	ldw	x,#21845
2580  00a6 bf0a          	ldw	_led_green,x
2581  00a8               L7651:
2582                     ; 165 	if(jp_mode!=jp3)
2584  00a8 b614          	ld	a,_jp_mode
2585  00aa a103          	cp	a,#3
2586  00ac 2603          	jrne	L41
2587  00ae cc014f        	jp	L1751
2588  00b1               L41:
2589                     ; 167 	if((link==ON))
2591  00b1 b619          	ld	a,_link
2592  00b3 a155          	cp	a,#85
2593  00b5 2616          	jrne	L3751
2594                     ; 169 			led_red=0x00055555L;
2596  00b7 ae5555        	ldw	x,#21845
2597  00ba bf08          	ldw	_led_red+2,x
2598  00bc ae0005        	ldw	x,#5
2599  00bf bf06          	ldw	_led_red,x
2600                     ; 170 			led_green=0xffffffffL;
2602  00c1 aeffff        	ldw	x,#65535
2603  00c4 bf0c          	ldw	_led_green+2,x
2604  00c6 aeffff        	ldw	x,#-1
2605  00c9 bf0a          	ldw	_led_green,x
2607  00cb 2036          	jra	L5751
2608  00cd               L3751:
2609                     ; 173 		else  if(link==OFF)
2611  00cd b619          	ld	a,_link
2612  00cf a1aa          	cp	a,#170
2613  00d1 2616          	jrne	L7751
2614                     ; 175 			led_red=0x55555555L;
2616  00d3 ae5555        	ldw	x,#21845
2617  00d6 bf08          	ldw	_led_red+2,x
2618  00d8 ae5555        	ldw	x,#21845
2619  00db bf06          	ldw	_led_red,x
2620                     ; 176 			led_green=0xffffffffL;
2622  00dd aeffff        	ldw	x,#65535
2623  00e0 bf0c          	ldw	_led_green+2,x
2624  00e2 aeffff        	ldw	x,#-1
2625  00e5 bf0a          	ldw	_led_green,x
2627  00e7 201a          	jra	L5751
2628  00e9               L7751:
2629                     ; 179 		else if((link==ON))
2631  00e9 b619          	ld	a,_link
2632  00eb a155          	cp	a,#85
2633  00ed 2614          	jrne	L5751
2634                     ; 181 			led_red=0x00000000L;
2636  00ef ae0000        	ldw	x,#0
2637  00f2 bf08          	ldw	_led_red+2,x
2638  00f4 ae0000        	ldw	x,#0
2639  00f7 bf06          	ldw	_led_red,x
2640                     ; 182 			led_green=0xffffffffL;
2642  00f9 aeffff        	ldw	x,#65535
2643  00fc bf0c          	ldw	_led_green+2,x
2644  00fe aeffff        	ldw	x,#-1
2645  0101 bf0a          	ldw	_led_green,x
2646  0103               L5751:
2647                     ; 187 		if((jp_mode==jp1))
2649  0103 b614          	ld	a,_jp_mode
2650  0105 a101          	cp	a,#1
2651  0107 2616          	jrne	L5061
2652                     ; 189 			led_red=0x00000000L;
2654  0109 ae0000        	ldw	x,#0
2655  010c bf08          	ldw	_led_red+2,x
2656  010e ae0000        	ldw	x,#0
2657  0111 bf06          	ldw	_led_red,x
2658                     ; 190 			led_green=0x33333333L;
2660  0113 ae3333        	ldw	x,#13107
2661  0116 bf0c          	ldw	_led_green+2,x
2662  0118 ae3333        	ldw	x,#13107
2663  011b bf0a          	ldw	_led_green,x
2665  011d 201a          	jra	L7061
2666  011f               L5061:
2667                     ; 192 		else if((jp_mode==jp2))
2669  011f b614          	ld	a,_jp_mode
2670  0121 a102          	cp	a,#2
2671  0123 2614          	jrne	L7061
2672                     ; 194 			led_red=0xccccccccL;
2674  0125 aecccc        	ldw	x,#52428
2675  0128 bf08          	ldw	_led_red+2,x
2676  012a aecccc        	ldw	x,#-13108
2677  012d bf06          	ldw	_led_red,x
2678                     ; 195 			led_green=0x00000000L;
2680  012f ae0000        	ldw	x,#0
2681  0132 bf0c          	ldw	_led_green+2,x
2682  0134 ae0000        	ldw	x,#0
2683  0137 bf0a          	ldw	_led_green,x
2684  0139               L7061:
2685                     ; 197 	led_red=0x00000000L;
2687  0139 ae0000        	ldw	x,#0
2688  013c bf08          	ldw	_led_red+2,x
2689  013e ae0000        	ldw	x,#0
2690  0141 bf06          	ldw	_led_red,x
2691                     ; 198 	led_green=0xfffffffeL;			
2693  0143 aefffe        	ldw	x,#65534
2694  0146 bf0c          	ldw	_led_green+2,x
2695  0148 aeffff        	ldw	x,#-1
2696  014b bf0a          	ldw	_led_green,x
2698  014d 2004          	jra	L3161
2699  014f               L1751:
2700                     ; 200 	else if(jp_mode==jp3)
2702  014f b614          	ld	a,_jp_mode
2703  0151 a103          	cp	a,#3
2704  0153               L3161:
2705                     ; 207 	if(jp_mode!=jp3)
2707  0153 b614          	ld	a,_jp_mode
2708  0155 a103          	cp	a,#3
2709  0157 2774          	jreq	L7161
2710                     ; 209 		if(link==ON)
2712  0159 b619          	ld	a,_link
2713  015b a155          	cp	a,#85
2714  015d 2616          	jrne	L1261
2715                     ; 211 			led_red=0x00055555L;
2717  015f ae5555        	ldw	x,#21845
2718  0162 bf08          	ldw	_led_red+2,x
2719  0164 ae0005        	ldw	x,#5
2720  0167 bf06          	ldw	_led_red,x
2721                     ; 212 			led_green=0xffffffffL;
2723  0169 aeffff        	ldw	x,#65535
2724  016c bf0c          	ldw	_led_green+2,x
2725  016e aeffff        	ldw	x,#-1
2726  0171 bf0a          	ldw	_led_green,x
2728  0173 2020          	jra	L3261
2729  0175               L1261:
2730                     ; 215 		else  if(link==OFF)
2732  0175 b619          	ld	a,_link
2733  0177 a1aa          	cp	a,#170
2734  0179 271a          	jreq	L3261
2736                     ; 222 		else if(link==ON)
2738  017b b619          	ld	a,_link
2739  017d a155          	cp	a,#85
2740  017f 2614          	jrne	L3261
2741                     ; 224 			led_red=0x00000000L;
2743  0181 ae0000        	ldw	x,#0
2744  0184 bf08          	ldw	_led_red+2,x
2745  0186 ae0000        	ldw	x,#0
2746  0189 bf06          	ldw	_led_red,x
2747                     ; 225 			led_green=0x00030003L;
2749  018b ae0003        	ldw	x,#3
2750  018e bf0c          	ldw	_led_green+2,x
2751  0190 ae0003        	ldw	x,#3
2752  0193 bf0a          	ldw	_led_green,x
2753  0195               L3261:
2754                     ; 228 		if((jp_mode==jp1))
2756  0195 b614          	ld	a,_jp_mode
2757  0197 a101          	cp	a,#1
2758  0199 2616          	jrne	L3361
2759                     ; 230 			led_red=0x00000000L;
2761  019b ae0000        	ldw	x,#0
2762  019e bf08          	ldw	_led_red+2,x
2763  01a0 ae0000        	ldw	x,#0
2764  01a3 bf06          	ldw	_led_red,x
2765                     ; 231 			led_green=0x33333333L;
2767  01a5 ae3333        	ldw	x,#13107
2768  01a8 bf0c          	ldw	_led_green+2,x
2769  01aa ae3333        	ldw	x,#13107
2770  01ad bf0a          	ldw	_led_green,x
2772  01af 2020          	jra	L1461
2773  01b1               L3361:
2774                     ; 233 		else if((jp_mode==jp2))
2776  01b1 b614          	ld	a,_jp_mode
2777  01b3 a102          	cp	a,#2
2778  01b5 261a          	jrne	L1461
2779                     ; 237 			led_red=0xccccccccL;
2781  01b7 aecccc        	ldw	x,#52428
2782  01ba bf08          	ldw	_led_red+2,x
2783  01bc aecccc        	ldw	x,#-13108
2784  01bf bf06          	ldw	_led_red,x
2785                     ; 238 			led_green=0x00000000L;
2787  01c1 ae0000        	ldw	x,#0
2788  01c4 bf0c          	ldw	_led_green+2,x
2789  01c6 ae0000        	ldw	x,#0
2790  01c9 bf0a          	ldw	_led_green,x
2791  01cb 2004          	jra	L1461
2792  01cd               L7161:
2793                     ; 241 	else if(jp_mode==jp3)
2795  01cd b614          	ld	a,_jp_mode
2796  01cf a103          	cp	a,#3
2797  01d1               L1461:
2798                     ; 245 	led_red=0xffffffffL;
2800  01d1 aeffff        	ldw	x,#65535
2801  01d4 bf08          	ldw	_led_red+2,x
2802  01d6 aeffff        	ldw	x,#-1
2803  01d9 bf06          	ldw	_led_red,x
2804                     ; 246 	led_green=0x00000000L;		
2806  01db ae0000        	ldw	x,#0
2807  01de bf0c          	ldw	_led_green+2,x
2808  01e0 ae0000        	ldw	x,#0
2809  01e3 bf0a          	ldw	_led_green,x
2810                     ; 248 }
2813  01e5 81            	ret
2841                     ; 251 void led_drv(void)
2841                     ; 252 {
2842                     	switch	.text
2843  01e6               _led_drv:
2847                     ; 254 GPIOA->DDR|=(1<<4);
2849  01e6 72185002      	bset	20482,#4
2850                     ; 255 GPIOA->CR1|=(1<<4);
2852  01ea 72185003      	bset	20483,#4
2853                     ; 256 GPIOA->CR2&=~(1<<4);
2855  01ee 72195004      	bres	20484,#4
2856                     ; 257 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
2858  01f2 b610          	ld	a,_led_red_buff+3
2859  01f4 a501          	bcp	a,#1
2860  01f6 2706          	jreq	L5561
2863  01f8 72185000      	bset	20480,#4
2865  01fc 2004          	jra	L7561
2866  01fe               L5561:
2867                     ; 258 else GPIOA->ODR&=~(1<<4); 
2869  01fe 72195000      	bres	20480,#4
2870  0202               L7561:
2871                     ; 261 GPIOA->DDR|=(1<<5);
2873  0202 721a5002      	bset	20482,#5
2874                     ; 262 GPIOA->CR1|=(1<<5);
2876  0206 721a5003      	bset	20483,#5
2877                     ; 263 GPIOA->CR2&=~(1<<5);	
2879  020a 721b5004      	bres	20484,#5
2880                     ; 264 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
2882  020e b60c          	ld	a,_led_green_buff+3
2883  0210 a501          	bcp	a,#1
2884  0212 2706          	jreq	L1661
2887  0214 721a5000      	bset	20480,#5
2889  0218 2004          	jra	L3661
2890  021a               L1661:
2891                     ; 265 else GPIOA->ODR&=~(1<<5);
2893  021a 721b5000      	bres	20480,#5
2894  021e               L3661:
2895                     ; 268 led_red_buff>>=1;
2897  021e 370d          	sra	_led_red_buff
2898  0220 360e          	rrc	_led_red_buff+1
2899  0222 360f          	rrc	_led_red_buff+2
2900  0224 3610          	rrc	_led_red_buff+3
2901                     ; 269 led_green_buff>>=1;
2903  0226 3709          	sra	_led_green_buff
2904  0228 360a          	rrc	_led_green_buff+1
2905  022a 360b          	rrc	_led_green_buff+2
2906  022c 360c          	rrc	_led_green_buff+3
2907                     ; 270 if(++led_drv_cnt>32)
2909  022e 3c0e          	inc	_led_drv_cnt
2910  0230 b60e          	ld	a,_led_drv_cnt
2911  0232 a121          	cp	a,#33
2912  0234 2512          	jrult	L5661
2913                     ; 272 	led_drv_cnt=0;
2915  0236 3f0e          	clr	_led_drv_cnt
2916                     ; 273 	led_red_buff=led_red;
2918  0238 be08          	ldw	x,_led_red+2
2919  023a bf0f          	ldw	_led_red_buff+2,x
2920  023c be06          	ldw	x,_led_red
2921  023e bf0d          	ldw	_led_red_buff,x
2922                     ; 274 	led_green_buff=led_green;
2924  0240 be0c          	ldw	x,_led_green+2
2925  0242 bf0b          	ldw	_led_green_buff+2,x
2926  0244 be0a          	ldw	x,_led_green
2927  0246 bf09          	ldw	_led_green_buff,x
2928  0248               L5661:
2929                     ; 280 } 
2932  0248 81            	ret
2958                     ; 283 void JP_drv(void)
2958                     ; 284 {
2959                     	switch	.text
2960  0249               _JP_drv:
2964                     ; 286 GPIOD->DDR&=~(1<<6);
2966  0249 721d5011      	bres	20497,#6
2967                     ; 287 GPIOD->CR1|=(1<<6);
2969  024d 721c5012      	bset	20498,#6
2970                     ; 288 GPIOD->CR2&=~(1<<6);
2972  0251 721d5013      	bres	20499,#6
2973                     ; 290 GPIOD->DDR&=~(1<<7);
2975  0255 721f5011      	bres	20497,#7
2976                     ; 291 GPIOD->CR1|=(1<<7);
2978  0259 721e5012      	bset	20498,#7
2979                     ; 292 GPIOD->CR2&=~(1<<7);
2981  025d 721f5013      	bres	20499,#7
2982                     ; 294 if(GPIOD->IDR&(1<<6))
2984  0261 c65010        	ld	a,20496
2985  0264 a540          	bcp	a,#64
2986  0266 270a          	jreq	L7761
2987                     ; 296 	if(cnt_JP0<10)
2989  0268 b613          	ld	a,_cnt_JP0
2990  026a a10a          	cp	a,#10
2991  026c 2411          	jruge	L3071
2992                     ; 298 		cnt_JP0++;
2994  026e 3c13          	inc	_cnt_JP0
2995  0270 200d          	jra	L3071
2996  0272               L7761:
2997                     ; 301 else if(!(GPIOD->IDR&(1<<6)))
2999  0272 c65010        	ld	a,20496
3000  0275 a540          	bcp	a,#64
3001  0277 2606          	jrne	L3071
3002                     ; 303 	if(cnt_JP0)
3004  0279 3d13          	tnz	_cnt_JP0
3005  027b 2702          	jreq	L3071
3006                     ; 305 		cnt_JP0--;
3008  027d 3a13          	dec	_cnt_JP0
3009  027f               L3071:
3010                     ; 309 if(GPIOD->IDR&(1<<7))
3012  027f c65010        	ld	a,20496
3013  0282 a580          	bcp	a,#128
3014  0284 270a          	jreq	L1171
3015                     ; 311 	if(cnt_JP1<10)
3017  0286 b612          	ld	a,_cnt_JP1
3018  0288 a10a          	cp	a,#10
3019  028a 2411          	jruge	L5171
3020                     ; 313 		cnt_JP1++;
3022  028c 3c12          	inc	_cnt_JP1
3023  028e 200d          	jra	L5171
3024  0290               L1171:
3025                     ; 316 else if(!(GPIOD->IDR&(1<<7)))
3027  0290 c65010        	ld	a,20496
3028  0293 a580          	bcp	a,#128
3029  0295 2606          	jrne	L5171
3030                     ; 318 	if(cnt_JP1)
3032  0297 3d12          	tnz	_cnt_JP1
3033  0299 2702          	jreq	L5171
3034                     ; 320 		cnt_JP1--;
3036  029b 3a12          	dec	_cnt_JP1
3037  029d               L5171:
3038                     ; 325 if((cnt_JP0==10)&&(cnt_JP1==10))
3040  029d b613          	ld	a,_cnt_JP0
3041  029f a10a          	cp	a,#10
3042  02a1 2608          	jrne	L3271
3044  02a3 b612          	ld	a,_cnt_JP1
3045  02a5 a10a          	cp	a,#10
3046  02a7 2602          	jrne	L3271
3047                     ; 327 	jp_mode=jp0;
3049  02a9 3f14          	clr	_jp_mode
3050  02ab               L3271:
3051                     ; 329 if((cnt_JP0==0)&&(cnt_JP1==10))
3053  02ab 3d13          	tnz	_cnt_JP0
3054  02ad 260a          	jrne	L5271
3056  02af b612          	ld	a,_cnt_JP1
3057  02b1 a10a          	cp	a,#10
3058  02b3 2604          	jrne	L5271
3059                     ; 331 	jp_mode=jp1;
3061  02b5 35010014      	mov	_jp_mode,#1
3062  02b9               L5271:
3063                     ; 333 if((cnt_JP0==10)&&(cnt_JP1==0))
3065  02b9 b613          	ld	a,_cnt_JP0
3066  02bb a10a          	cp	a,#10
3067  02bd 2608          	jrne	L7271
3069  02bf 3d12          	tnz	_cnt_JP1
3070  02c1 2604          	jrne	L7271
3071                     ; 335 	jp_mode=jp2;
3073  02c3 35020014      	mov	_jp_mode,#2
3074  02c7               L7271:
3075                     ; 337 if((cnt_JP0==0)&&(cnt_JP1==0))
3077  02c7 3d13          	tnz	_cnt_JP0
3078  02c9 2608          	jrne	L1371
3080  02cb 3d12          	tnz	_cnt_JP1
3081  02cd 2604          	jrne	L1371
3082                     ; 339 	jp_mode=jp3;
3084  02cf 35030014      	mov	_jp_mode,#3
3085  02d3               L1371:
3086                     ; 342 }
3089  02d3 81            	ret
3117                     ; 345 void link_drv(void)		//10Hz
3117                     ; 346 {
3118                     	switch	.text
3119  02d4               _link_drv:
3123                     ; 347 if(jp_mode!=jp3)
3125  02d4 b614          	ld	a,_jp_mode
3126  02d6 a103          	cp	a,#3
3127  02d8 2722          	jreq	L3471
3128                     ; 349 	if(link_cnt<602)link_cnt++;
3130  02da 9c            	rvf
3131  02db be17          	ldw	x,_link_cnt
3132  02dd a3025a        	cpw	x,#602
3133  02e0 2e07          	jrsge	L5471
3136  02e2 be17          	ldw	x,_link_cnt
3137  02e4 1c0001        	addw	x,#1
3138  02e7 bf17          	ldw	_link_cnt,x
3139  02e9               L5471:
3140                     ; 350 	if(link_cnt==100)
3142  02e9 be17          	ldw	x,_link_cnt
3143  02eb a30064        	cpw	x,#100
3144  02ee 2610          	jrne	L1571
3145                     ; 352 		link=OFF;
3147  02f0 35aa0019      	mov	_link,#170
3148                     ; 360 		cnt_net_drv=0;
3150  02f4 3f02          	clr	_cnt_net_drv
3151                     ; 363 	    		bRES_=1;
3153  02f6 35010005      	mov	_bRES_,#1
3154  02fa 2004          	jra	L1571
3155  02fc               L3471:
3156                     ; 368 else link=OFF;	
3158  02fc 35aa0019      	mov	_link,#170
3159  0300               L1571:
3160                     ; 369 } 
3163  0300 81            	ret
3186                     ; 374 void rele_hndl(void)
3186                     ; 375 {
3187                     	switch	.text
3188  0301               _rele_hndl:
3192                     ; 376 }
3195  0301 81            	ret
3218                     ; 379 void init_CAN(void) {
3219                     	switch	.text
3220  0302               _init_CAN:
3224                     ; 380 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
3226  0302 72135420      	bres	21536,#1
3227                     ; 381 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
3229  0306 72105420      	bset	21536,#0
3231  030a               L5771:
3232                     ; 382 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
3234  030a c65421        	ld	a,21537
3235  030d a501          	bcp	a,#1
3236  030f 27f9          	jreq	L5771
3237                     ; 384 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
3239  0311 72185420      	bset	21536,#4
3240                     ; 386 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
3242  0315 35025427      	mov	21543,#2
3243                     ; 395 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
3245  0319 35135428      	mov	21544,#19
3246                     ; 396 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
3248  031d 35c05429      	mov	21545,#192
3249                     ; 397 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
3251  0321 357f542c      	mov	21548,#127
3252                     ; 398 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
3254  0325 35e0542d      	mov	21549,#224
3255                     ; 400 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
3257  0329 35315430      	mov	21552,#49
3258                     ; 401 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
3260  032d 35c05431      	mov	21553,#192
3261                     ; 402 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
3263  0331 357f5434      	mov	21556,#127
3264                     ; 403 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
3266  0335 35e05435      	mov	21557,#224
3267                     ; 407 	CAN->PSR= 6;									// set page 6
3269  0339 35065427      	mov	21543,#6
3270                     ; 412 	CAN->Page.Config.FMR1&=~3;								//mask mode
3272  033d c65430        	ld	a,21552
3273  0340 a4fc          	and	a,#252
3274  0342 c75430        	ld	21552,a
3275                     ; 418 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
3277  0345 35065432      	mov	21554,#6
3278                     ; 419 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
3280  0349 35605432      	mov	21554,#96
3281                     ; 422 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
3283  034d 72105432      	bset	21554,#0
3284                     ; 423 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
3286  0351 72185432      	bset	21554,#4
3287                     ; 426 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
3289  0355 35065427      	mov	21543,#6
3290                     ; 428 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
3292  0359 3509542c      	mov	21548,#9
3293                     ; 429 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
3295  035d 35e7542d      	mov	21549,#231
3296                     ; 431 	CAN->IER|=(1<<1);
3298  0361 72125425      	bset	21541,#1
3299                     ; 434 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
3301  0365 72115420      	bres	21536,#0
3303  0369               L3002:
3304                     ; 435 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
3306  0369 c65421        	ld	a,21537
3307  036c a501          	bcp	a,#1
3308  036e 26f9          	jrne	L3002
3309                     ; 436 }
3312  0370 81            	ret
3420                     ; 439 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
3420                     ; 440 {
3421                     	switch	.text
3422  0371               _can_transmit:
3424  0371 89            	pushw	x
3425       00000000      OFST:	set	0
3428                     ; 442 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
3430  0372 b622          	ld	a,_can_buff_wr_ptr
3431  0374 a104          	cp	a,#4
3432  0376 2502          	jrult	L5602
3435  0378 3f22          	clr	_can_buff_wr_ptr
3436  037a               L5602:
3437                     ; 444 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
3439  037a b622          	ld	a,_can_buff_wr_ptr
3440  037c 97            	ld	xl,a
3441  037d a610          	ld	a,#16
3442  037f 42            	mul	x,a
3443  0380 1601          	ldw	y,(OFST+1,sp)
3444  0382 a606          	ld	a,#6
3445  0384               L23:
3446  0384 9054          	srlw	y
3447  0386 4a            	dec	a
3448  0387 26fb          	jrne	L23
3449  0389 909f          	ld	a,yl
3450  038b e723          	ld	(_can_out_buff,x),a
3451                     ; 445 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
3453  038d b622          	ld	a,_can_buff_wr_ptr
3454  038f 97            	ld	xl,a
3455  0390 a610          	ld	a,#16
3456  0392 42            	mul	x,a
3457  0393 7b02          	ld	a,(OFST+2,sp)
3458  0395 48            	sll	a
3459  0396 48            	sll	a
3460  0397 e724          	ld	(_can_out_buff+1,x),a
3461                     ; 447 can_out_buff[can_buff_wr_ptr][2]=data0;
3463  0399 b622          	ld	a,_can_buff_wr_ptr
3464  039b 97            	ld	xl,a
3465  039c a610          	ld	a,#16
3466  039e 42            	mul	x,a
3467  039f 7b05          	ld	a,(OFST+5,sp)
3468  03a1 e725          	ld	(_can_out_buff+2,x),a
3469                     ; 448 can_out_buff[can_buff_wr_ptr][3]=data1;
3471  03a3 b622          	ld	a,_can_buff_wr_ptr
3472  03a5 97            	ld	xl,a
3473  03a6 a610          	ld	a,#16
3474  03a8 42            	mul	x,a
3475  03a9 7b06          	ld	a,(OFST+6,sp)
3476  03ab e726          	ld	(_can_out_buff+3,x),a
3477                     ; 449 can_out_buff[can_buff_wr_ptr][4]=data2;
3479  03ad b622          	ld	a,_can_buff_wr_ptr
3480  03af 97            	ld	xl,a
3481  03b0 a610          	ld	a,#16
3482  03b2 42            	mul	x,a
3483  03b3 7b07          	ld	a,(OFST+7,sp)
3484  03b5 e727          	ld	(_can_out_buff+4,x),a
3485                     ; 450 can_out_buff[can_buff_wr_ptr][5]=data3;
3487  03b7 b622          	ld	a,_can_buff_wr_ptr
3488  03b9 97            	ld	xl,a
3489  03ba a610          	ld	a,#16
3490  03bc 42            	mul	x,a
3491  03bd 7b08          	ld	a,(OFST+8,sp)
3492  03bf e728          	ld	(_can_out_buff+5,x),a
3493                     ; 451 can_out_buff[can_buff_wr_ptr][6]=data4;
3495  03c1 b622          	ld	a,_can_buff_wr_ptr
3496  03c3 97            	ld	xl,a
3497  03c4 a610          	ld	a,#16
3498  03c6 42            	mul	x,a
3499  03c7 7b09          	ld	a,(OFST+9,sp)
3500  03c9 e729          	ld	(_can_out_buff+6,x),a
3501                     ; 452 can_out_buff[can_buff_wr_ptr][7]=data5;
3503  03cb b622          	ld	a,_can_buff_wr_ptr
3504  03cd 97            	ld	xl,a
3505  03ce a610          	ld	a,#16
3506  03d0 42            	mul	x,a
3507  03d1 7b0a          	ld	a,(OFST+10,sp)
3508  03d3 e72a          	ld	(_can_out_buff+7,x),a
3509                     ; 453 can_out_buff[can_buff_wr_ptr][8]=data6;
3511  03d5 b622          	ld	a,_can_buff_wr_ptr
3512  03d7 97            	ld	xl,a
3513  03d8 a610          	ld	a,#16
3514  03da 42            	mul	x,a
3515  03db 7b0b          	ld	a,(OFST+11,sp)
3516  03dd e72b          	ld	(_can_out_buff+8,x),a
3517                     ; 454 can_out_buff[can_buff_wr_ptr][9]=data7;
3519  03df b622          	ld	a,_can_buff_wr_ptr
3520  03e1 97            	ld	xl,a
3521  03e2 a610          	ld	a,#16
3522  03e4 42            	mul	x,a
3523  03e5 7b0c          	ld	a,(OFST+12,sp)
3524  03e7 e72c          	ld	(_can_out_buff+9,x),a
3525                     ; 456 can_buff_wr_ptr++;
3527  03e9 3c22          	inc	_can_buff_wr_ptr
3528                     ; 457 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
3530  03eb b622          	ld	a,_can_buff_wr_ptr
3531  03ed a104          	cp	a,#4
3532  03ef 2502          	jrult	L7602
3535  03f1 3f22          	clr	_can_buff_wr_ptr
3536  03f3               L7602:
3537                     ; 458 } 
3540  03f3 85            	popw	x
3541  03f4 81            	ret
3570                     ; 461 void can_tx_hndl(void)
3570                     ; 462 {
3571                     	switch	.text
3572  03f5               _can_tx_hndl:
3576                     ; 463 if(bTX_FREE)
3578  03f5 3d02          	tnz	_bTX_FREE
3579  03f7 2757          	jreq	L1012
3580                     ; 465 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
3582  03f9 b621          	ld	a,_can_buff_rd_ptr
3583  03fb b122          	cp	a,_can_buff_wr_ptr
3584  03fd 275f          	jreq	L7012
3585                     ; 467 		bTX_FREE=0;
3587  03ff 3f02          	clr	_bTX_FREE
3588                     ; 469 		CAN->PSR= 0;
3590  0401 725f5427      	clr	21543
3591                     ; 470 		CAN->Page.TxMailbox.MDLCR=8;
3593  0405 35085429      	mov	21545,#8
3594                     ; 471 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
3596  0409 b621          	ld	a,_can_buff_rd_ptr
3597  040b 97            	ld	xl,a
3598  040c a610          	ld	a,#16
3599  040e 42            	mul	x,a
3600  040f e623          	ld	a,(_can_out_buff,x)
3601  0411 c7542a        	ld	21546,a
3602                     ; 472 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
3604  0414 b621          	ld	a,_can_buff_rd_ptr
3605  0416 97            	ld	xl,a
3606  0417 a610          	ld	a,#16
3607  0419 42            	mul	x,a
3608  041a e624          	ld	a,(_can_out_buff+1,x)
3609  041c c7542b        	ld	21547,a
3610                     ; 474 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
3612  041f b621          	ld	a,_can_buff_rd_ptr
3613  0421 97            	ld	xl,a
3614  0422 a610          	ld	a,#16
3615  0424 42            	mul	x,a
3616  0425 01            	rrwa	x,a
3617  0426 ab25          	add	a,#_can_out_buff+2
3618  0428 2401          	jrnc	L63
3619  042a 5c            	incw	x
3620  042b               L63:
3621  042b 5f            	clrw	x
3622  042c 97            	ld	xl,a
3623  042d bf00          	ldw	c_x,x
3624  042f ae0008        	ldw	x,#8
3625  0432               L04:
3626  0432 5a            	decw	x
3627  0433 92d600        	ld	a,([c_x],x)
3628  0436 d7542e        	ld	(21550,x),a
3629  0439 5d            	tnzw	x
3630  043a 26f6          	jrne	L04
3631                     ; 476 		can_buff_rd_ptr++;
3633  043c 3c21          	inc	_can_buff_rd_ptr
3634                     ; 477 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
3636  043e b621          	ld	a,_can_buff_rd_ptr
3637  0440 a104          	cp	a,#4
3638  0442 2502          	jrult	L5012
3641  0444 3f21          	clr	_can_buff_rd_ptr
3642  0446               L5012:
3643                     ; 479 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
3645  0446 72105428      	bset	21544,#0
3646                     ; 480 		CAN->IER|=(1<<0);
3648  044a 72105425      	bset	21541,#0
3649  044e 200e          	jra	L7012
3650  0450               L1012:
3651                     ; 485 	tx_busy_cnt++;
3653  0450 3c20          	inc	_tx_busy_cnt
3654                     ; 486 	if(tx_busy_cnt>=100)
3656  0452 b620          	ld	a,_tx_busy_cnt
3657  0454 a164          	cp	a,#100
3658  0456 2506          	jrult	L7012
3659                     ; 488 		tx_busy_cnt=0;
3661  0458 3f20          	clr	_tx_busy_cnt
3662                     ; 489 		bTX_FREE=1;
3664  045a 35010002      	mov	_bTX_FREE,#1
3665  045e               L7012:
3666                     ; 492 }
3669  045e 81            	ret
3697                     ; 495 void can_in_an(void)
3697                     ; 496 {
3698                     	switch	.text
3699  045f               _can_in_an:
3703                     ; 497 if((mess[6]==RELE_DATA)&&(mess[7]==RELE_DATA))
3705  045f b66a          	ld	a,_mess+6
3706  0461 a117          	cp	a,#23
3707  0463 260c          	jrne	L3112
3709  0465 b66b          	ld	a,_mess+7
3710  0467 a117          	cp	a,#23
3711  0469 2606          	jrne	L3112
3712                     ; 499 	rele_data[0]=mess[8];
3714  046b 456c00        	mov	_rele_data,_mess+8
3715                     ; 500 	rele_data[1]=mess[9];
3717  046e 456d01        	mov	_rele_data+1,_mess+9
3718  0471               L3112:
3719                     ; 503 can_in_an_end:
3719                     ; 504 bCAN_RX=0;
3721  0471 3f03          	clr	_bCAN_RX
3722                     ; 505 }   
3725  0473 81            	ret
3748                     ; 508 void t4_init(void){
3749                     	switch	.text
3750  0474               _t4_init:
3754                     ; 509 	TIM4->PSCR = 4;
3756  0474 35045345      	mov	21317,#4
3757                     ; 510 	TIM4->ARR= 61;
3759  0478 353d5346      	mov	21318,#61
3760                     ; 511 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
3762  047c 72105341      	bset	21313,#0
3763                     ; 513 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
3765  0480 35855340      	mov	21312,#133
3766                     ; 515 }
3769  0484 81            	ret
3792                     ; 518 void t1_init(void)
3792                     ; 519 {
3793                     	switch	.text
3794  0485               _t1_init:
3798                     ; 520 TIM1->ARRH= 0x03;
3800  0485 35035262      	mov	21090,#3
3801                     ; 521 TIM1->ARRL= 0xff;
3803  0489 35ff5263      	mov	21091,#255
3804                     ; 522 TIM1->CCR1H= 0x00;	
3806  048d 725f5265      	clr	21093
3807                     ; 523 TIM1->CCR1L= 0xff;
3809  0491 35ff5266      	mov	21094,#255
3810                     ; 524 TIM1->CCR2H= 0x00;	
3812  0495 725f5267      	clr	21095
3813                     ; 525 TIM1->CCR2L= 0x00;
3815  0499 725f5268      	clr	21096
3816                     ; 526 TIM1->CCR3H= 0x00;	
3818  049d 725f5269      	clr	21097
3819                     ; 527 TIM1->CCR3L= 0x64;
3821  04a1 3564526a      	mov	21098,#100
3822                     ; 529 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3824  04a5 35685258      	mov	21080,#104
3825                     ; 530 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3827  04a9 35685259      	mov	21081,#104
3828                     ; 531 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
3830  04ad 3568525a      	mov	21082,#104
3831                     ; 532 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
3833  04b1 3511525c      	mov	21084,#17
3834                     ; 533 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
3836  04b5 3501525d      	mov	21085,#1
3837                     ; 534 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
3839  04b9 35815250      	mov	21072,#129
3840                     ; 535 TIM1->BKR|= TIM1_BKR_AOE;
3842  04bd 721c526d      	bset	21101,#6
3843                     ; 536 }
3846  04c1 81            	ret
3881                     ; 544 @far @interrupt void TIM4_UPD_Interrupt (void) 
3881                     ; 545 {
3883                     	switch	.text
3884  04c2               f_TIM4_UPD_Interrupt:
3888                     ; 546 TIM4->SR1&=~TIM4_SR1_UIF;
3890  04c2 72115342      	bres	21314,#0
3891                     ; 551 if(++t0_cnt00>=10)
3893  04c6 9c            	rvf
3894  04c7 ce0000        	ldw	x,_t0_cnt00
3895  04ca 1c0001        	addw	x,#1
3896  04cd cf0000        	ldw	_t0_cnt00,x
3897  04d0 a3000a        	cpw	x,#10
3898  04d3 2f08          	jrslt	L1612
3899                     ; 553 	t0_cnt00=0;
3901  04d5 5f            	clrw	x
3902  04d6 cf0000        	ldw	_t0_cnt00,x
3903                     ; 554 	b1000Hz=1;
3905  04d9 72100003      	bset	_b1000Hz
3906  04dd               L1612:
3907                     ; 557 if(++t0_cnt0>=100)
3909  04dd 9c            	rvf
3910  04de ce0002        	ldw	x,_t0_cnt0
3911  04e1 1c0001        	addw	x,#1
3912  04e4 cf0002        	ldw	_t0_cnt0,x
3913  04e7 a30064        	cpw	x,#100
3914  04ea 2f54          	jrslt	L3612
3915                     ; 559 	t0_cnt0=0;
3917  04ec 5f            	clrw	x
3918  04ed cf0002        	ldw	_t0_cnt0,x
3919                     ; 560 	b100Hz=1;
3921  04f0 72100008      	bset	_b100Hz
3922                     ; 562 	if(++t0_cnt1>=10)
3924  04f4 725c0004      	inc	_t0_cnt1
3925  04f8 c60004        	ld	a,_t0_cnt1
3926  04fb a10a          	cp	a,#10
3927  04fd 2508          	jrult	L5612
3928                     ; 564 		t0_cnt1=0;
3930  04ff 725f0004      	clr	_t0_cnt1
3931                     ; 565 		b10Hz=1;
3933  0503 72100007      	bset	_b10Hz
3934  0507               L5612:
3935                     ; 568 	if(++t0_cnt2>=20)
3937  0507 725c0005      	inc	_t0_cnt2
3938  050b c60005        	ld	a,_t0_cnt2
3939  050e a114          	cp	a,#20
3940  0510 2508          	jrult	L7612
3941                     ; 570 		t0_cnt2=0;
3943  0512 725f0005      	clr	_t0_cnt2
3944                     ; 571 		b5Hz=1;
3946  0516 72100006      	bset	_b5Hz
3947  051a               L7612:
3948                     ; 575 	if(++t0_cnt4>=50)
3950  051a 725c0007      	inc	_t0_cnt4
3951  051e c60007        	ld	a,_t0_cnt4
3952  0521 a132          	cp	a,#50
3953  0523 2508          	jrult	L1712
3954                     ; 577 		t0_cnt4=0;
3956  0525 725f0007      	clr	_t0_cnt4
3957                     ; 578 		b2Hz=1;
3959  0529 72100005      	bset	_b2Hz
3960  052d               L1712:
3961                     ; 581 	if(++t0_cnt3>=100)
3963  052d 725c0006      	inc	_t0_cnt3
3964  0531 c60006        	ld	a,_t0_cnt3
3965  0534 a164          	cp	a,#100
3966  0536 2508          	jrult	L3612
3967                     ; 583 		t0_cnt3=0;
3969  0538 725f0006      	clr	_t0_cnt3
3970                     ; 584 		b1Hz=1;
3972  053c 72100004      	bset	_b1Hz
3973  0540               L3612:
3974                     ; 590 }
3977  0540 80            	iret
4002                     ; 593 @far @interrupt void CAN_RX_Interrupt (void) 
4002                     ; 594 {
4003                     	switch	.text
4004  0541               f_CAN_RX_Interrupt:
4008                     ; 596 CAN->PSR= 7;									// page 7 - read messsage
4010  0541 35075427      	mov	21543,#7
4011                     ; 598 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
4013  0545 ae000e        	ldw	x,#14
4014  0548               L45:
4015  0548 d65427        	ld	a,(21543,x)
4016  054b e763          	ld	(_mess-1,x),a
4017  054d 5a            	decw	x
4018  054e 26f8          	jrne	L45
4019                     ; 609 bCAN_RX=1;
4021  0550 35010003      	mov	_bCAN_RX,#1
4022                     ; 610 CAN->RFR|=(1<<5);
4024  0554 721a5424      	bset	21540,#5
4025                     ; 612 }
4028  0558 80            	iret
4051                     ; 615 @far @interrupt void CAN_TX_Interrupt (void) 
4051                     ; 616 {
4052                     	switch	.text
4053  0559               f_CAN_TX_Interrupt:
4057                     ; 617 if((CAN->TSR)&(1<<0))
4059  0559 c65422        	ld	a,21538
4060  055c a501          	bcp	a,#1
4061  055e 2708          	jreq	L5122
4062                     ; 619 	bTX_FREE=1;	
4064  0560 35010002      	mov	_bTX_FREE,#1
4065                     ; 621 	CAN->TSR|=(1<<0);
4067  0564 72105422      	bset	21538,#0
4068  0568               L5122:
4069                     ; 623 }
4072  0568 80            	iret
4094                     ; 626 @far @interrupt void ADC2_EOC_Interrupt (void) {
4095                     	switch	.text
4096  0569               f_ADC2_EOC_Interrupt:
4100                     ; 628 ADC2->CSR&=~(1<<7);
4102  0569 721f5400      	bres	21504,#7
4103                     ; 632 }
4106  056d 80            	iret
4149                     ; 641 main()
4149                     ; 642 {
4151                     	switch	.text
4152  056e               _main:
4156                     ; 644 CLK->ECKR|=1;
4158  056e 721050c1      	bset	20673,#0
4160  0572               L1422:
4161                     ; 645 while((CLK->ECKR & 2) == 0);
4163  0572 c650c1        	ld	a,20673
4164  0575 a502          	bcp	a,#2
4165  0577 27f9          	jreq	L1422
4166                     ; 646 CLK->SWCR|=2;
4168  0579 721250c5      	bset	20677,#1
4169                     ; 647 CLK->SWR=0xB4;
4171  057d 35b450c4      	mov	20676,#180
4172                     ; 649 delay_ms(200);
4174  0581 ae00c8        	ldw	x,#200
4175  0584 cd004c        	call	_delay_ms
4177                     ; 650 FLASH_DUKR=0xae;
4179  0587 35ae5064      	mov	_FLASH_DUKR,#174
4180                     ; 651 FLASH_DUKR=0x56;
4182  058b 35565064      	mov	_FLASH_DUKR,#86
4183                     ; 652 enableInterrupts();
4186  058f 9a            rim
4188                     ; 656 t4_init();
4191  0590 cd0474        	call	_t4_init
4193                     ; 658 		GPIOG->DDR|=(1<<0);
4195  0593 72105020      	bset	20512,#0
4196                     ; 659 		GPIOG->CR1|=(1<<0);
4198  0597 72105021      	bset	20513,#0
4199                     ; 660 		GPIOG->CR2&=~(1<<0);	
4201  059b 72115022      	bres	20514,#0
4202                     ; 663 		GPIOG->DDR&=~(1<<1);
4204  059f 72135020      	bres	20512,#1
4205                     ; 664 		GPIOG->CR1|=(1<<1);
4207  05a3 72125021      	bset	20513,#1
4208                     ; 665 		GPIOG->CR2&=~(1<<1);
4210  05a7 72135022      	bres	20514,#1
4211                     ; 672 GPIOC->DDR|=(1<<1);
4213  05ab 7212500c      	bset	20492,#1
4214                     ; 673 GPIOC->CR1|=(1<<1);
4216  05af 7212500d      	bset	20493,#1
4217                     ; 674 GPIOC->CR2|=(1<<1);
4219  05b3 7212500e      	bset	20494,#1
4220                     ; 676 GPIOC->DDR|=(1<<2);
4222  05b7 7214500c      	bset	20492,#2
4223                     ; 677 GPIOC->CR1|=(1<<2);
4225  05bb 7214500d      	bset	20493,#2
4226                     ; 678 GPIOC->CR2|=(1<<2);
4228  05bf 7214500e      	bset	20494,#2
4229                     ; 685 t1_init();
4231  05c3 cd0485        	call	_t1_init
4233                     ; 687 GPIOA->DDR|=(1<<5);
4235  05c6 721a5002      	bset	20482,#5
4236                     ; 688 GPIOA->CR1|=(1<<5);
4238  05ca 721a5003      	bset	20483,#5
4239                     ; 689 GPIOA->CR2&=~(1<<5);
4241  05ce 721b5004      	bres	20484,#5
4242                     ; 695 GPIOB->DDR&=~(1<<3);
4244  05d2 72175007      	bres	20487,#3
4245                     ; 696 GPIOB->CR1&=~(1<<3);
4247  05d6 72175008      	bres	20488,#3
4248                     ; 697 GPIOB->CR2&=~(1<<3);
4250  05da 72175009      	bres	20489,#3
4251                     ; 699 GPIOC->DDR|=(1<<3);
4253  05de 7216500c      	bset	20492,#3
4254                     ; 700 GPIOC->CR1|=(1<<3);
4256  05e2 7216500d      	bset	20493,#3
4257                     ; 701 GPIOC->CR2|=(1<<3);
4259  05e6 7216500e      	bset	20494,#3
4260                     ; 705 GPIOA->DDR|=(1<<4);
4262  05ea 72185002      	bset	20482,#4
4263                     ; 706 GPIOA->CR1|=(1<<4);
4265  05ee 72185003      	bset	20483,#4
4266                     ; 707 GPIOA->CR2&=~(1<<4);
4268  05f2 72195004      	bres	20484,#4
4269                     ; 710 GPIOA->DDR|=(1<<5);
4271  05f6 721a5002      	bset	20482,#5
4272                     ; 711 GPIOA->CR1|=(1<<5);
4274  05fa 721a5003      	bset	20483,#5
4275                     ; 712 GPIOA->CR2&=~(1<<5);	
4277  05fe 721b5004      	bres	20484,#5
4278  0602               L5422:
4279                     ; 718 	if(b1000Hz)
4281                     	btst	_b1000Hz
4282  0607 2404          	jruge	L1522
4283                     ; 720 		b1000Hz=0;
4285  0609 72110003      	bres	_b1000Hz
4286  060d               L1522:
4287                     ; 723 	if(bCAN_RX)
4289  060d 3d03          	tnz	_bCAN_RX
4290  060f 2705          	jreq	L3522
4291                     ; 725 		bCAN_RX=0;
4293  0611 3f03          	clr	_bCAN_RX
4294                     ; 726 		can_in_an();	
4296  0613 cd045f        	call	_can_in_an
4298  0616               L3522:
4299                     ; 728 	if(b100Hz)
4301                     	btst	_b100Hz
4302  061b 2407          	jruge	L5522
4303                     ; 730 		b100Hz=0;
4305  061d 72110008      	bres	_b100Hz
4306                     ; 740 		can_tx_hndl();
4308  0621 cd03f5        	call	_can_tx_hndl
4310  0624               L5522:
4311                     ; 743 	if(b10Hz)
4313                     	btst	_b10Hz
4314  0629 241f          	jruge	L7522
4315                     ; 745 		b10Hz=0;
4317  062b 72110007      	bres	_b10Hz
4318                     ; 748 	  link_drv();
4320  062f cd02d4        	call	_link_drv
4322                     ; 750 	  JP_drv();
4324  0632 cd0249        	call	_JP_drv
4326                     ; 751 		if(main_cnt<100)main_cnt++;
4328  0635 9c            	rvf
4329  0636 ce0011        	ldw	x,_main_cnt
4330  0639 a30064        	cpw	x,#100
4331  063c 2e09          	jrsge	L1622
4334  063e ce0011        	ldw	x,_main_cnt
4335  0641 1c0001        	addw	x,#1
4336  0644 cf0011        	ldw	_main_cnt,x
4337  0647               L1622:
4338                     ; 753 		rele_hndl();
4340  0647 cd0301        	call	_rele_hndl
4342  064a               L7522:
4343                     ; 756 	if(b5Hz)
4345                     	btst	_b5Hz
4346  064f 2407          	jruge	L3622
4347                     ; 758 		b5Hz=0;
4349  0651 72110006      	bres	_b5Hz
4350                     ; 760 		led_hndl();
4352  0655 cd008e        	call	_led_hndl
4354  0658               L3622:
4355                     ; 763 	if(b2Hz)
4357                     	btst	_b2Hz
4358  065d 2404          	jruge	L5622
4359                     ; 765 		b2Hz=0;
4361  065f 72110005      	bres	_b2Hz
4362  0663               L5622:
4363                     ; 774 	if(b1Hz)
4365                     	btst	_b1Hz
4366  0668 2498          	jruge	L5422
4367                     ; 776 		b1Hz=0;
4369  066a 72110004      	bres	_b1Hz
4370                     ; 779           if(main_cnt<1000)main_cnt++;
4372  066e 9c            	rvf
4373  066f ce0011        	ldw	x,_main_cnt
4374  0672 a303e8        	cpw	x,#1000
4375  0675 2e09          	jrsge	L1722
4378  0677 ce0011        	ldw	x,_main_cnt
4379  067a 1c0001        	addw	x,#1
4380  067d cf0011        	ldw	_main_cnt,x
4381  0680               L1722:
4382                     ; 782   		can_error_cnt++;
4384  0680 3c1f          	inc	_can_error_cnt
4385                     ; 783   		if(can_error_cnt>=10)
4387  0682 b61f          	ld	a,_can_error_cnt
4388  0684 a10a          	cp	a,#10
4389  0686 2505          	jrult	L3722
4390                     ; 785   			can_error_cnt=0;
4392  0688 3f1f          	clr	_can_error_cnt
4393                     ; 786 			init_CAN();
4395  068a cd0302        	call	_init_CAN
4397  068d               L3722:
4398                     ; 789 		GPIOA->ODR^=(1<<4)|(1<<5);
4400  068d c65000        	ld	a,20480
4401  0690 a830          	xor	a,	#48
4402  0692 c75000        	ld	20480,a
4403  0695 cc0602        	jra	L5422
4991                     	xdef	_main
4992                     	xdef	f_ADC2_EOC_Interrupt
4993                     	xdef	f_CAN_TX_Interrupt
4994                     	xdef	f_CAN_RX_Interrupt
4995                     	xdef	f_TIM4_UPD_Interrupt
4996                     	xdef	_t1_init
4997                     	xdef	_t4_init
4998                     	xdef	_can_in_an
4999                     	xdef	_can_tx_hndl
5000                     	xdef	_can_transmit
5001                     	xdef	_init_CAN
5002                     	xdef	_rele_hndl
5003                     	xdef	_link_drv
5004                     	xdef	_JP_drv
5005                     	xdef	_led_drv
5006                     	xdef	_led_hndl
5007                     	xdef	_delay_ms
5008                     	xdef	_granee
5009                     	xdef	_gran
5010                     	switch	.ubsct
5011  0000               _rele_data:
5012  0000 0000          	ds.b	2
5013                     	xdef	_rele_data
5014  0002               _cnt_net_drv:
5015  0002 00            	ds.b	1
5016                     	xdef	_cnt_net_drv
5017                     	switch	.bit
5018  0001               _bMAIN:
5019  0001 00            	ds.b	1
5020                     	xdef	_bMAIN
5021                     	switch	.ubsct
5022  0003               _plazma_int:
5023  0003 000000000000  	ds.b	6
5024                     	xdef	_plazma_int
5025                     	xdef	_rotor_int
5026  0009               _led_green_buff:
5027  0009 00000000      	ds.b	4
5028                     	xdef	_led_green_buff
5029  000d               _led_red_buff:
5030  000d 00000000      	ds.b	4
5031                     	xdef	_led_red_buff
5032                     	xdef	_led_drv_cnt
5033                     	xdef	_led_green
5034                     	xdef	_led_red
5035  0011               _res_fl_cnt:
5036  0011 00            	ds.b	1
5037                     	xdef	_res_fl_cnt
5038                     	xdef	_bRES_
5039                     	xdef	_bRES
5040                     	xdef	_bBL_IPS
5041                     	switch	.bit
5042  0002               _bBL:
5043  0002 00            	ds.b	1
5044                     	xdef	_bBL
5045                     	switch	.ubsct
5046  0012               _cnt_JP1:
5047  0012 00            	ds.b	1
5048                     	xdef	_cnt_JP1
5049  0013               _cnt_JP0:
5050  0013 00            	ds.b	1
5051                     	xdef	_cnt_JP0
5052  0014               _jp_mode:
5053  0014 00            	ds.b	1
5054                     	xdef	_jp_mode
5055  0015               _main_cnt1:
5056  0015 0000          	ds.b	2
5057                     	xdef	_main_cnt1
5058  0017               _link_cnt:
5059  0017 0000          	ds.b	2
5060                     	xdef	_link_cnt
5061  0019               _link:
5062  0019 00            	ds.b	1
5063                     	xdef	_link
5064  001a               _umin_cnt:
5065  001a 0000          	ds.b	2
5066                     	xdef	_umin_cnt
5067  001c               _umax_cnt:
5068  001c 0000          	ds.b	2
5069                     	xdef	_umax_cnt
5070                     .eeprom:	section	.data
5071  0000               _ee_K:
5072  0000 000000000000  	ds.b	20
5073                     	xdef	_ee_K
5074                     	switch	.ubsct
5075  001e               _T:
5076  001e 00            	ds.b	1
5077                     	xdef	_T
5078                     	switch	.bss
5079  0000               _Uin:
5080  0000 0000          	ds.b	2
5081                     	xdef	_Uin
5082  0002               _Usum:
5083  0002 0000          	ds.b	2
5084                     	xdef	_Usum
5085  0004               _U_out_const:
5086  0004 0000          	ds.b	2
5087                     	xdef	_U_out_const
5088  0006               _Unecc:
5089  0006 0000          	ds.b	2
5090                     	xdef	_Unecc
5091  0008               _Udb:
5092  0008 0000          	ds.b	2
5093                     	xdef	_Udb
5094  000a               _Ui:
5095  000a 0000          	ds.b	2
5096                     	xdef	_Ui
5097  000c               _Un:
5098  000c 0000          	ds.b	2
5099                     	xdef	_Un
5100  000e               _I:
5101  000e 0000          	ds.b	2
5102                     	xdef	_I
5103                     	switch	.ubsct
5104  001f               _can_error_cnt:
5105  001f 00            	ds.b	1
5106                     	xdef	_can_error_cnt
5107                     	xdef	_bCAN_RX
5108  0020               _tx_busy_cnt:
5109  0020 00            	ds.b	1
5110                     	xdef	_tx_busy_cnt
5111                     	xdef	_bTX_FREE
5112  0021               _can_buff_rd_ptr:
5113  0021 00            	ds.b	1
5114                     	xdef	_can_buff_rd_ptr
5115  0022               _can_buff_wr_ptr:
5116  0022 00            	ds.b	1
5117                     	xdef	_can_buff_wr_ptr
5118  0023               _can_out_buff:
5119  0023 000000000000  	ds.b	64
5120                     	xdef	_can_out_buff
5121                     	switch	.bss
5122  0010               _adress_error:
5123  0010 00            	ds.b	1
5124                     	xdef	_adress_error
5125                     	xdef	_adr_drv_stat
5126                     	xdef	_led_ind
5127                     	switch	.ubsct
5128  0063               _led_ind_cnt:
5129  0063 00            	ds.b	1
5130                     	xdef	_led_ind_cnt
5131                     	switch	.bss
5132  0011               _main_cnt:
5133  0011 0000          	ds.b	2
5134                     	xdef	_main_cnt
5135                     	switch	.ubsct
5136  0064               _mess:
5137  0064 000000000000  	ds.b	14
5138                     	xdef	_mess
5139                     	switch	.bit
5140  0003               _b1000Hz:
5141  0003 00            	ds.b	1
5142                     	xdef	_b1000Hz
5143  0004               _b1Hz:
5144  0004 00            	ds.b	1
5145                     	xdef	_b1Hz
5146  0005               _b2Hz:
5147  0005 00            	ds.b	1
5148                     	xdef	_b2Hz
5149  0006               _b5Hz:
5150  0006 00            	ds.b	1
5151                     	xdef	_b5Hz
5152  0007               _b10Hz:
5153  0007 00            	ds.b	1
5154                     	xdef	_b10Hz
5155  0008               _b100Hz:
5156  0008 00            	ds.b	1
5157                     	xdef	_b100Hz
5158                     	xdef	_t0_cnt4
5159                     	xdef	_t0_cnt3
5160                     	xdef	_t0_cnt2
5161                     	xdef	_t0_cnt1
5162                     	xdef	_t0_cnt0
5163                     	xdef	_t0_cnt00
5164                     	xref.b	c_x
5165                     	xref.b	c_y
5185                     	xref	c_lcmp
5186                     	xref	c_ltor
5187                     	xref	c_lgadc
5188                     	xref	c_rtol
5189                     	xref	c_vmul
5190                     	xref	c_eewrw
5191                     	end
