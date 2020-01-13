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
2198  0000               _bBL:
2199  0000 01            	dc.b	1
2200  0001               _bBL_IPS:
2201  0001 00            	dc.b	0
2202                     	bsct
2203  000f               _bRES:
2204  000f 00            	dc.b	0
2205  0010               _bRES_:
2206  0010 00            	dc.b	0
2207  0011               _led_red:
2208  0011 00000000      	dc.l	0
2209  0015               _led_green:
2210  0015 03030303      	dc.l	50529027
2211  0019               _led_drv_cnt:
2212  0019 1e            	dc.b	30
2213  001a               _rotor_int:
2214  001a 007b          	dc.w	123
2215  001c               _volum_u_main_:
2216  001c 02bc          	dc.w	700
2275                     ; 165 void gran(signed short *adr, signed short min, signed short max)
2275                     ; 166 {
2277                     	switch	.text
2278  0000               _gran:
2280  0000 89            	pushw	x
2281       00000000      OFST:	set	0
2284                     ; 167 if (*adr<min) *adr=min;
2286  0001 9c            	rvf
2287  0002 9093          	ldw	y,x
2288  0004 51            	exgw	x,y
2289  0005 fe            	ldw	x,(x)
2290  0006 1305          	cpw	x,(OFST+5,sp)
2291  0008 51            	exgw	x,y
2292  0009 2e03          	jrsge	L7541
2295  000b 1605          	ldw	y,(OFST+5,sp)
2296  000d ff            	ldw	(x),y
2297  000e               L7541:
2298                     ; 168 if (*adr>max) *adr=max; 
2300  000e 9c            	rvf
2301  000f 1e01          	ldw	x,(OFST+1,sp)
2302  0011 9093          	ldw	y,x
2303  0013 51            	exgw	x,y
2304  0014 fe            	ldw	x,(x)
2305  0015 1307          	cpw	x,(OFST+7,sp)
2306  0017 51            	exgw	x,y
2307  0018 2d05          	jrsle	L1641
2310  001a 1e01          	ldw	x,(OFST+1,sp)
2311  001c 1607          	ldw	y,(OFST+7,sp)
2312  001e ff            	ldw	(x),y
2313  001f               L1641:
2314                     ; 169 } 
2317  001f 85            	popw	x
2318  0020 81            	ret
2371                     ; 172 void granee(@eeprom signed short *adr, signed short min, signed short max)
2371                     ; 173 {
2372                     	switch	.text
2373  0021               _granee:
2375  0021 89            	pushw	x
2376       00000000      OFST:	set	0
2379                     ; 174 if (*adr<min) *adr=min;
2381  0022 9c            	rvf
2382  0023 9093          	ldw	y,x
2383  0025 51            	exgw	x,y
2384  0026 fe            	ldw	x,(x)
2385  0027 1305          	cpw	x,(OFST+5,sp)
2386  0029 51            	exgw	x,y
2387  002a 2e09          	jrsge	L1151
2390  002c 1e05          	ldw	x,(OFST+5,sp)
2391  002e 89            	pushw	x
2392  002f 1e03          	ldw	x,(OFST+3,sp)
2393  0031 cd0000        	call	c_eewrw
2395  0034 85            	popw	x
2396  0035               L1151:
2397                     ; 175 if (*adr>max) *adr=max; 
2399  0035 9c            	rvf
2400  0036 1e01          	ldw	x,(OFST+1,sp)
2401  0038 9093          	ldw	y,x
2402  003a 51            	exgw	x,y
2403  003b fe            	ldw	x,(x)
2404  003c 1307          	cpw	x,(OFST+7,sp)
2405  003e 51            	exgw	x,y
2406  003f 2d09          	jrsle	L3151
2409  0041 1e07          	ldw	x,(OFST+7,sp)
2410  0043 89            	pushw	x
2411  0044 1e03          	ldw	x,(OFST+3,sp)
2412  0046 cd0000        	call	c_eewrw
2414  0049 85            	popw	x
2415  004a               L3151:
2416                     ; 176 }
2419  004a 85            	popw	x
2420  004b 81            	ret
2481                     ; 179 long delay_ms(short in)
2481                     ; 180 {
2482                     	switch	.text
2483  004c               _delay_ms:
2485  004c 520c          	subw	sp,#12
2486       0000000c      OFST:	set	12
2489                     ; 183 i=((long)in)*100UL;
2491  004e 90ae0064      	ldw	y,#100
2492  0052 cd0000        	call	c_vmul
2494  0055 96            	ldw	x,sp
2495  0056 1c0005        	addw	x,#OFST-7
2496  0059 cd0000        	call	c_rtol
2498                     ; 185 for(ii=0;ii<i;ii++)
2500  005c ae0000        	ldw	x,#0
2501  005f 1f0b          	ldw	(OFST-1,sp),x
2502  0061 ae0000        	ldw	x,#0
2503  0064 1f09          	ldw	(OFST-3,sp),x
2505  0066 2012          	jra	L3551
2506  0068               L7451:
2507                     ; 187 		iii++;
2509  0068 96            	ldw	x,sp
2510  0069 1c0001        	addw	x,#OFST-11
2511  006c a601          	ld	a,#1
2512  006e cd0000        	call	c_lgadc
2514                     ; 185 for(ii=0;ii<i;ii++)
2516  0071 96            	ldw	x,sp
2517  0072 1c0009        	addw	x,#OFST-3
2518  0075 a601          	ld	a,#1
2519  0077 cd0000        	call	c_lgadc
2521  007a               L3551:
2524  007a 9c            	rvf
2525  007b 96            	ldw	x,sp
2526  007c 1c0009        	addw	x,#OFST-3
2527  007f cd0000        	call	c_ltor
2529  0082 96            	ldw	x,sp
2530  0083 1c0005        	addw	x,#OFST-7
2531  0086 cd0000        	call	c_lcmp
2533  0089 2fdd          	jrslt	L7451
2534                     ; 190 }
2537  008b 5b0c          	addw	sp,#12
2538  008d 81            	ret
2574                     ; 193 void led_hndl(void)
2574                     ; 194 {
2575                     	switch	.text
2576  008e               _led_hndl:
2580                     ; 195 if(adress_error)
2582  008e 725d0000      	tnz	_adress_error
2583  0092 2718          	jreq	L7651
2584                     ; 197 	led_red=0x55555555L;
2586  0094 ae5555        	ldw	x,#21845
2587  0097 bf13          	ldw	_led_red+2,x
2588  0099 ae5555        	ldw	x,#21845
2589  009c bf11          	ldw	_led_red,x
2590                     ; 198 	led_green=0x55555555L;
2592  009e ae5555        	ldw	x,#21845
2593  00a1 bf17          	ldw	_led_green+2,x
2594  00a3 ae5555        	ldw	x,#21845
2595  00a6 bf15          	ldw	_led_green,x
2597  00a8 ac100710      	jpf	L1751
2598  00ac               L7651:
2599                     ; 214 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2601  00ac 3d01          	tnz	_bps_class
2602  00ae 2703          	jreq	L41
2603  00b0 cc0363        	jp	L3751
2604  00b3               L41:
2605                     ; 216 	if(jp_mode!=jp3)
2607  00b3 b647          	ld	a,_jp_mode
2608  00b5 a103          	cp	a,#3
2609  00b7 2603          	jrne	L61
2610  00b9 cc025f        	jp	L5751
2611  00bc               L61:
2612                     ; 218 		if(main_cnt1<(5*ee_TZAS))
2614  00bc 9c            	rvf
2615  00bd ce0014        	ldw	x,_ee_TZAS
2616  00c0 90ae0005      	ldw	y,#5
2617  00c4 cd0000        	call	c_imul
2619  00c7 b34c          	cpw	x,_main_cnt1
2620  00c9 2d18          	jrsle	L7751
2621                     ; 220 			led_red=0x00000000L;
2623  00cb ae0000        	ldw	x,#0
2624  00ce bf13          	ldw	_led_red+2,x
2625  00d0 ae0000        	ldw	x,#0
2626  00d3 bf11          	ldw	_led_red,x
2627                     ; 221 			led_green=0x03030303L;
2629  00d5 ae0303        	ldw	x,#771
2630  00d8 bf17          	ldw	_led_green+2,x
2631  00da ae0303        	ldw	x,#771
2632  00dd bf15          	ldw	_led_green,x
2634  00df ac200220      	jpf	L1061
2635  00e3               L7751:
2636                     ; 224 		else if((link==ON)&&(flags_tu&0b10000000))
2638  00e3 b65f          	ld	a,_link
2639  00e5 a155          	cp	a,#85
2640  00e7 261e          	jrne	L3061
2642  00e9 b65d          	ld	a,_flags_tu
2643  00eb a580          	bcp	a,#128
2644  00ed 2718          	jreq	L3061
2645                     ; 226 			led_red=0x00055555L;
2647  00ef ae5555        	ldw	x,#21845
2648  00f2 bf13          	ldw	_led_red+2,x
2649  00f4 ae0005        	ldw	x,#5
2650  00f7 bf11          	ldw	_led_red,x
2651                     ; 227 			led_green=0xffffffffL;
2653  00f9 aeffff        	ldw	x,#65535
2654  00fc bf17          	ldw	_led_green+2,x
2655  00fe aeffff        	ldw	x,#-1
2656  0101 bf15          	ldw	_led_green,x
2658  0103 ac200220      	jpf	L1061
2659  0107               L3061:
2660                     ; 230 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2662  0107 9c            	rvf
2663  0108 ce0014        	ldw	x,_ee_TZAS
2664  010b 90ae0005      	ldw	y,#5
2665  010f cd0000        	call	c_imul
2667  0112 b34c          	cpw	x,_main_cnt1
2668  0114 2e37          	jrsge	L7061
2670  0116 9c            	rvf
2671  0117 ce0014        	ldw	x,_ee_TZAS
2672  011a 90ae0005      	ldw	y,#5
2673  011e cd0000        	call	c_imul
2675  0121 1c0064        	addw	x,#100
2676  0124 b34c          	cpw	x,_main_cnt1
2677  0126 2d25          	jrsle	L7061
2679  0128 ce0004        	ldw	x,_ee_AVT_MODE
2680  012b a30055        	cpw	x,#85
2681  012e 271d          	jreq	L7061
2683  0130 ce0002        	ldw	x,_ee_DEVICE
2684  0133 2618          	jrne	L7061
2685                     ; 232 			led_red=0x00000000L;
2687  0135 ae0000        	ldw	x,#0
2688  0138 bf13          	ldw	_led_red+2,x
2689  013a ae0000        	ldw	x,#0
2690  013d bf11          	ldw	_led_red,x
2691                     ; 233 			led_green=0xffffffffL;	
2693  013f aeffff        	ldw	x,#65535
2694  0142 bf17          	ldw	_led_green+2,x
2695  0144 aeffff        	ldw	x,#-1
2696  0147 bf15          	ldw	_led_green,x
2698  0149 ac200220      	jpf	L1061
2699  014d               L7061:
2700                     ; 236 		else  if(link==OFF)
2702  014d b65f          	ld	a,_link
2703  014f a1aa          	cp	a,#170
2704  0151 2618          	jrne	L3161
2705                     ; 238 			led_red=0x55555555L;
2707  0153 ae5555        	ldw	x,#21845
2708  0156 bf13          	ldw	_led_red+2,x
2709  0158 ae5555        	ldw	x,#21845
2710  015b bf11          	ldw	_led_red,x
2711                     ; 239 			led_green=0xffffffffL;
2713  015d aeffff        	ldw	x,#65535
2714  0160 bf17          	ldw	_led_green+2,x
2715  0162 aeffff        	ldw	x,#-1
2716  0165 bf15          	ldw	_led_green,x
2718  0167 ac200220      	jpf	L1061
2719  016b               L3161:
2720                     ; 242 		else if((link==ON)&&((flags&0b00111110)==0))
2722  016b b65f          	ld	a,_link
2723  016d a155          	cp	a,#85
2724  016f 261d          	jrne	L7161
2726  0171 b60a          	ld	a,_flags
2727  0173 a53e          	bcp	a,#62
2728  0175 2617          	jrne	L7161
2729                     ; 244 			led_red=0x00000000L;
2731  0177 ae0000        	ldw	x,#0
2732  017a bf13          	ldw	_led_red+2,x
2733  017c ae0000        	ldw	x,#0
2734  017f bf11          	ldw	_led_red,x
2735                     ; 245 			led_green=0xffffffffL;
2737  0181 aeffff        	ldw	x,#65535
2738  0184 bf17          	ldw	_led_green+2,x
2739  0186 aeffff        	ldw	x,#-1
2740  0189 bf15          	ldw	_led_green,x
2742  018b cc0220        	jra	L1061
2743  018e               L7161:
2744                     ; 248 		else if((flags&0b00111110)==0b00000100)
2746  018e b60a          	ld	a,_flags
2747  0190 a43e          	and	a,#62
2748  0192 a104          	cp	a,#4
2749  0194 2616          	jrne	L3261
2750                     ; 250 			led_red=0x00010001L;
2752  0196 ae0001        	ldw	x,#1
2753  0199 bf13          	ldw	_led_red+2,x
2754  019b ae0001        	ldw	x,#1
2755  019e bf11          	ldw	_led_red,x
2756                     ; 251 			led_green=0xffffffffL;	
2758  01a0 aeffff        	ldw	x,#65535
2759  01a3 bf17          	ldw	_led_green+2,x
2760  01a5 aeffff        	ldw	x,#-1
2761  01a8 bf15          	ldw	_led_green,x
2763  01aa 2074          	jra	L1061
2764  01ac               L3261:
2765                     ; 253 		else if(flags&0b00000010)
2767  01ac b60a          	ld	a,_flags
2768  01ae a502          	bcp	a,#2
2769  01b0 2716          	jreq	L7261
2770                     ; 255 			led_red=0x00010001L;
2772  01b2 ae0001        	ldw	x,#1
2773  01b5 bf13          	ldw	_led_red+2,x
2774  01b7 ae0001        	ldw	x,#1
2775  01ba bf11          	ldw	_led_red,x
2776                     ; 256 			led_green=0x00000000L;	
2778  01bc ae0000        	ldw	x,#0
2779  01bf bf17          	ldw	_led_green+2,x
2780  01c1 ae0000        	ldw	x,#0
2781  01c4 bf15          	ldw	_led_green,x
2783  01c6 2058          	jra	L1061
2784  01c8               L7261:
2785                     ; 258 		else if(flags&0b00001000)
2787  01c8 b60a          	ld	a,_flags
2788  01ca a508          	bcp	a,#8
2789  01cc 2716          	jreq	L3361
2790                     ; 260 			led_red=0x00090009L;
2792  01ce ae0009        	ldw	x,#9
2793  01d1 bf13          	ldw	_led_red+2,x
2794  01d3 ae0009        	ldw	x,#9
2795  01d6 bf11          	ldw	_led_red,x
2796                     ; 261 			led_green=0x00000000L;	
2798  01d8 ae0000        	ldw	x,#0
2799  01db bf17          	ldw	_led_green+2,x
2800  01dd ae0000        	ldw	x,#0
2801  01e0 bf15          	ldw	_led_green,x
2803  01e2 203c          	jra	L1061
2804  01e4               L3361:
2805                     ; 263 		else if(flags&0b00010000)
2807  01e4 b60a          	ld	a,_flags
2808  01e6 a510          	bcp	a,#16
2809  01e8 2716          	jreq	L7361
2810                     ; 265 			led_red=0x00490049L;
2812  01ea ae0049        	ldw	x,#73
2813  01ed bf13          	ldw	_led_red+2,x
2814  01ef ae0049        	ldw	x,#73
2815  01f2 bf11          	ldw	_led_red,x
2816                     ; 266 			led_green=0x00000000L;	
2818  01f4 ae0000        	ldw	x,#0
2819  01f7 bf17          	ldw	_led_green+2,x
2820  01f9 ae0000        	ldw	x,#0
2821  01fc bf15          	ldw	_led_green,x
2823  01fe 2020          	jra	L1061
2824  0200               L7361:
2825                     ; 269 		else if((link==ON)&&(flags&0b00100000))
2827  0200 b65f          	ld	a,_link
2828  0202 a155          	cp	a,#85
2829  0204 261a          	jrne	L1061
2831  0206 b60a          	ld	a,_flags
2832  0208 a520          	bcp	a,#32
2833  020a 2714          	jreq	L1061
2834                     ; 271 			led_red=0x00000000L;
2836  020c ae0000        	ldw	x,#0
2837  020f bf13          	ldw	_led_red+2,x
2838  0211 ae0000        	ldw	x,#0
2839  0214 bf11          	ldw	_led_red,x
2840                     ; 272 			led_green=0x00030003L;
2842  0216 ae0003        	ldw	x,#3
2843  0219 bf17          	ldw	_led_green+2,x
2844  021b ae0003        	ldw	x,#3
2845  021e bf15          	ldw	_led_green,x
2846  0220               L1061:
2847                     ; 275 		if((jp_mode==jp1))
2849  0220 b647          	ld	a,_jp_mode
2850  0222 a101          	cp	a,#1
2851  0224 2618          	jrne	L5461
2852                     ; 277 			led_red=0x00000000L;
2854  0226 ae0000        	ldw	x,#0
2855  0229 bf13          	ldw	_led_red+2,x
2856  022b ae0000        	ldw	x,#0
2857  022e bf11          	ldw	_led_red,x
2858                     ; 278 			led_green=0x33333333L;
2860  0230 ae3333        	ldw	x,#13107
2861  0233 bf17          	ldw	_led_green+2,x
2862  0235 ae3333        	ldw	x,#13107
2863  0238 bf15          	ldw	_led_green,x
2865  023a ac100710      	jpf	L1751
2866  023e               L5461:
2867                     ; 280 		else if((jp_mode==jp2))
2869  023e b647          	ld	a,_jp_mode
2870  0240 a102          	cp	a,#2
2871  0242 2703          	jreq	L02
2872  0244 cc0710        	jp	L1751
2873  0247               L02:
2874                     ; 282 			led_red=0xccccccccL;
2876  0247 aecccc        	ldw	x,#52428
2877  024a bf13          	ldw	_led_red+2,x
2878  024c aecccc        	ldw	x,#-13108
2879  024f bf11          	ldw	_led_red,x
2880                     ; 283 			led_green=0x00000000L;
2882  0251 ae0000        	ldw	x,#0
2883  0254 bf17          	ldw	_led_green+2,x
2884  0256 ae0000        	ldw	x,#0
2885  0259 bf15          	ldw	_led_green,x
2886  025b ac100710      	jpf	L1751
2887  025f               L5751:
2888                     ; 286 	else if(jp_mode==jp3)
2890  025f b647          	ld	a,_jp_mode
2891  0261 a103          	cp	a,#3
2892  0263 2703          	jreq	L22
2893  0265 cc0710        	jp	L1751
2894  0268               L22:
2895                     ; 288 		if(main_cnt1<(5*ee_TZAS))
2897  0268 9c            	rvf
2898  0269 ce0014        	ldw	x,_ee_TZAS
2899  026c 90ae0005      	ldw	y,#5
2900  0270 cd0000        	call	c_imul
2902  0273 b34c          	cpw	x,_main_cnt1
2903  0275 2d18          	jrsle	L7561
2904                     ; 290 			led_red=0x00000000L;
2906  0277 ae0000        	ldw	x,#0
2907  027a bf13          	ldw	_led_red+2,x
2908  027c ae0000        	ldw	x,#0
2909  027f bf11          	ldw	_led_red,x
2910                     ; 291 			led_green=0x03030303L;
2912  0281 ae0303        	ldw	x,#771
2913  0284 bf17          	ldw	_led_green+2,x
2914  0286 ae0303        	ldw	x,#771
2915  0289 bf15          	ldw	_led_green,x
2917  028b ac100710      	jpf	L1751
2918  028f               L7561:
2919                     ; 293 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
2921  028f 9c            	rvf
2922  0290 ce0014        	ldw	x,_ee_TZAS
2923  0293 90ae0005      	ldw	y,#5
2924  0297 cd0000        	call	c_imul
2926  029a b34c          	cpw	x,_main_cnt1
2927  029c 2e2a          	jrsge	L3661
2929  029e 9c            	rvf
2930  029f ce0014        	ldw	x,_ee_TZAS
2931  02a2 90ae0005      	ldw	y,#5
2932  02a6 cd0000        	call	c_imul
2934  02a9 1c0046        	addw	x,#70
2935  02ac b34c          	cpw	x,_main_cnt1
2936  02ae 2d18          	jrsle	L3661
2937                     ; 295 			led_red=0x00000000L;
2939  02b0 ae0000        	ldw	x,#0
2940  02b3 bf13          	ldw	_led_red+2,x
2941  02b5 ae0000        	ldw	x,#0
2942  02b8 bf11          	ldw	_led_red,x
2943                     ; 296 			led_green=0xffffffffL;	
2945  02ba aeffff        	ldw	x,#65535
2946  02bd bf17          	ldw	_led_green+2,x
2947  02bf aeffff        	ldw	x,#-1
2948  02c2 bf15          	ldw	_led_green,x
2950  02c4 ac100710      	jpf	L1751
2951  02c8               L3661:
2952                     ; 299 		else if((flags&0b00011110)==0)
2954  02c8 b60a          	ld	a,_flags
2955  02ca a51e          	bcp	a,#30
2956  02cc 2618          	jrne	L7661
2957                     ; 301 			led_red=0x00000000L;
2959  02ce ae0000        	ldw	x,#0
2960  02d1 bf13          	ldw	_led_red+2,x
2961  02d3 ae0000        	ldw	x,#0
2962  02d6 bf11          	ldw	_led_red,x
2963                     ; 302 			led_green=0xffffffffL;
2965  02d8 aeffff        	ldw	x,#65535
2966  02db bf17          	ldw	_led_green+2,x
2967  02dd aeffff        	ldw	x,#-1
2968  02e0 bf15          	ldw	_led_green,x
2970  02e2 ac100710      	jpf	L1751
2971  02e6               L7661:
2972                     ; 306 		else if((flags&0b00111110)==0b00000100)
2974  02e6 b60a          	ld	a,_flags
2975  02e8 a43e          	and	a,#62
2976  02ea a104          	cp	a,#4
2977  02ec 2618          	jrne	L3761
2978                     ; 308 			led_red=0x00010001L;
2980  02ee ae0001        	ldw	x,#1
2981  02f1 bf13          	ldw	_led_red+2,x
2982  02f3 ae0001        	ldw	x,#1
2983  02f6 bf11          	ldw	_led_red,x
2984                     ; 309 			led_green=0xffffffffL;	
2986  02f8 aeffff        	ldw	x,#65535
2987  02fb bf17          	ldw	_led_green+2,x
2988  02fd aeffff        	ldw	x,#-1
2989  0300 bf15          	ldw	_led_green,x
2991  0302 ac100710      	jpf	L1751
2992  0306               L3761:
2993                     ; 311 		else if(flags&0b00000010)
2995  0306 b60a          	ld	a,_flags
2996  0308 a502          	bcp	a,#2
2997  030a 2718          	jreq	L7761
2998                     ; 313 			led_red=0x00010001L;
3000  030c ae0001        	ldw	x,#1
3001  030f bf13          	ldw	_led_red+2,x
3002  0311 ae0001        	ldw	x,#1
3003  0314 bf11          	ldw	_led_red,x
3004                     ; 314 			led_green=0x00000000L;	
3006  0316 ae0000        	ldw	x,#0
3007  0319 bf17          	ldw	_led_green+2,x
3008  031b ae0000        	ldw	x,#0
3009  031e bf15          	ldw	_led_green,x
3011  0320 ac100710      	jpf	L1751
3012  0324               L7761:
3013                     ; 316 		else if(flags&0b00001000)
3015  0324 b60a          	ld	a,_flags
3016  0326 a508          	bcp	a,#8
3017  0328 2718          	jreq	L3071
3018                     ; 318 			led_red=0x00090009L;
3020  032a ae0009        	ldw	x,#9
3021  032d bf13          	ldw	_led_red+2,x
3022  032f ae0009        	ldw	x,#9
3023  0332 bf11          	ldw	_led_red,x
3024                     ; 319 			led_green=0x00000000L;	
3026  0334 ae0000        	ldw	x,#0
3027  0337 bf17          	ldw	_led_green+2,x
3028  0339 ae0000        	ldw	x,#0
3029  033c bf15          	ldw	_led_green,x
3031  033e ac100710      	jpf	L1751
3032  0342               L3071:
3033                     ; 321 		else if(flags&0b00010000)
3035  0342 b60a          	ld	a,_flags
3036  0344 a510          	bcp	a,#16
3037  0346 2603          	jrne	L42
3038  0348 cc0710        	jp	L1751
3039  034b               L42:
3040                     ; 323 			led_red=0x00490049L;
3042  034b ae0049        	ldw	x,#73
3043  034e bf13          	ldw	_led_red+2,x
3044  0350 ae0049        	ldw	x,#73
3045  0353 bf11          	ldw	_led_red,x
3046                     ; 324 			led_green=0xffffffffL;	
3048  0355 aeffff        	ldw	x,#65535
3049  0358 bf17          	ldw	_led_green+2,x
3050  035a aeffff        	ldw	x,#-1
3051  035d bf15          	ldw	_led_green,x
3052  035f ac100710      	jpf	L1751
3053  0363               L3751:
3054                     ; 328 else if(bps_class==bpsIPS)	//если блок ИПСный
3056  0363 b601          	ld	a,_bps_class
3057  0365 a101          	cp	a,#1
3058  0367 2703          	jreq	L62
3059  0369 cc0710        	jp	L1751
3060  036c               L62:
3061                     ; 330 	if(jp_mode!=jp3)
3063  036c b647          	ld	a,_jp_mode
3064  036e a103          	cp	a,#3
3065  0370 2603          	jrne	L03
3066  0372 cc061c        	jp	L5171
3067  0375               L03:
3068                     ; 332 		if(main_cnt1<(5*ee_TZAS))
3070  0375 9c            	rvf
3071  0376 ce0014        	ldw	x,_ee_TZAS
3072  0379 90ae0005      	ldw	y,#5
3073  037d cd0000        	call	c_imul
3075  0380 b34c          	cpw	x,_main_cnt1
3076  0382 2d18          	jrsle	L7171
3077                     ; 334 			led_red=0x00000000L;
3079  0384 ae0000        	ldw	x,#0
3080  0387 bf13          	ldw	_led_red+2,x
3081  0389 ae0000        	ldw	x,#0
3082  038c bf11          	ldw	_led_red,x
3083                     ; 335 			led_green=0x03030303L;
3085  038e ae0303        	ldw	x,#771
3086  0391 bf17          	ldw	_led_green+2,x
3087  0393 ae0303        	ldw	x,#771
3088  0396 bf15          	ldw	_led_green,x
3090  0398 acdd05dd      	jpf	L1271
3091  039c               L7171:
3092                     ; 338 		else if((link==ON)&&(flags_tu&0b10000000))
3094  039c b65f          	ld	a,_link
3095  039e a155          	cp	a,#85
3096  03a0 261e          	jrne	L3271
3098  03a2 b65d          	ld	a,_flags_tu
3099  03a4 a580          	bcp	a,#128
3100  03a6 2718          	jreq	L3271
3101                     ; 340 			led_red=0x00055555L;
3103  03a8 ae5555        	ldw	x,#21845
3104  03ab bf13          	ldw	_led_red+2,x
3105  03ad ae0005        	ldw	x,#5
3106  03b0 bf11          	ldw	_led_red,x
3107                     ; 341 			led_green=0xffffffffL;
3109  03b2 aeffff        	ldw	x,#65535
3110  03b5 bf17          	ldw	_led_green+2,x
3111  03b7 aeffff        	ldw	x,#-1
3112  03ba bf15          	ldw	_led_green,x
3114  03bc acdd05dd      	jpf	L1271
3115  03c0               L3271:
3116                     ; 344 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3118  03c0 9c            	rvf
3119  03c1 ce0014        	ldw	x,_ee_TZAS
3120  03c4 90ae0005      	ldw	y,#5
3121  03c8 cd0000        	call	c_imul
3123  03cb b34c          	cpw	x,_main_cnt1
3124  03cd 2e37          	jrsge	L7271
3126  03cf 9c            	rvf
3127  03d0 ce0014        	ldw	x,_ee_TZAS
3128  03d3 90ae0005      	ldw	y,#5
3129  03d7 cd0000        	call	c_imul
3131  03da 1c0064        	addw	x,#100
3132  03dd b34c          	cpw	x,_main_cnt1
3133  03df 2d25          	jrsle	L7271
3135  03e1 ce0004        	ldw	x,_ee_AVT_MODE
3136  03e4 a30055        	cpw	x,#85
3137  03e7 271d          	jreq	L7271
3139  03e9 ce0002        	ldw	x,_ee_DEVICE
3140  03ec 2618          	jrne	L7271
3141                     ; 346 			led_red=0x00000000L;
3143  03ee ae0000        	ldw	x,#0
3144  03f1 bf13          	ldw	_led_red+2,x
3145  03f3 ae0000        	ldw	x,#0
3146  03f6 bf11          	ldw	_led_red,x
3147                     ; 347 			led_green=0xffffffffL;	
3149  03f8 aeffff        	ldw	x,#65535
3150  03fb bf17          	ldw	_led_green+2,x
3151  03fd aeffff        	ldw	x,#-1
3152  0400 bf15          	ldw	_led_green,x
3154  0402 acdd05dd      	jpf	L1271
3155  0406               L7271:
3156                     ; 350 		else  if(link==OFF)
3158  0406 b65f          	ld	a,_link
3159  0408 a1aa          	cp	a,#170
3160  040a 2703          	jreq	L23
3161  040c cc0528        	jp	L3371
3162  040f               L23:
3163                     ; 352 			if((flags&0b00011110)==0)
3165  040f b60a          	ld	a,_flags
3166  0411 a51e          	bcp	a,#30
3167  0413 262d          	jrne	L5371
3168                     ; 354 				led_red=0x00000000L;
3170  0415 ae0000        	ldw	x,#0
3171  0418 bf13          	ldw	_led_red+2,x
3172  041a ae0000        	ldw	x,#0
3173  041d bf11          	ldw	_led_red,x
3174                     ; 355 				if(bMAIN)led_green=0xfffffff5L;
3176                     	btst	_bMAIN
3177  0424 240e          	jruge	L7371
3180  0426 aefff5        	ldw	x,#65525
3181  0429 bf17          	ldw	_led_green+2,x
3182  042b aeffff        	ldw	x,#-1
3183  042e bf15          	ldw	_led_green,x
3185  0430 acdd05dd      	jpf	L1271
3186  0434               L7371:
3187                     ; 356 				else led_green=0xffffffffL;
3189  0434 aeffff        	ldw	x,#65535
3190  0437 bf17          	ldw	_led_green+2,x
3191  0439 aeffff        	ldw	x,#-1
3192  043c bf15          	ldw	_led_green,x
3193  043e acdd05dd      	jpf	L1271
3194  0442               L5371:
3195                     ; 359 			else if((flags&0b00111110)==0b00000100)
3197  0442 b60a          	ld	a,_flags
3198  0444 a43e          	and	a,#62
3199  0446 a104          	cp	a,#4
3200  0448 262d          	jrne	L5471
3201                     ; 361 				led_red=0x00010001L;
3203  044a ae0001        	ldw	x,#1
3204  044d bf13          	ldw	_led_red+2,x
3205  044f ae0001        	ldw	x,#1
3206  0452 bf11          	ldw	_led_red,x
3207                     ; 362 				if(bMAIN)led_green=0xfffffff5L;
3209                     	btst	_bMAIN
3210  0459 240e          	jruge	L7471
3213  045b aefff5        	ldw	x,#65525
3214  045e bf17          	ldw	_led_green+2,x
3215  0460 aeffff        	ldw	x,#-1
3216  0463 bf15          	ldw	_led_green,x
3218  0465 acdd05dd      	jpf	L1271
3219  0469               L7471:
3220                     ; 363 				else led_green=0xffffffffL;	
3222  0469 aeffff        	ldw	x,#65535
3223  046c bf17          	ldw	_led_green+2,x
3224  046e aeffff        	ldw	x,#-1
3225  0471 bf15          	ldw	_led_green,x
3226  0473 acdd05dd      	jpf	L1271
3227  0477               L5471:
3228                     ; 365 			else if(flags&0b00000010)
3230  0477 b60a          	ld	a,_flags
3231  0479 a502          	bcp	a,#2
3232  047b 272d          	jreq	L5571
3233                     ; 367 				led_red=0x00010001L;
3235  047d ae0001        	ldw	x,#1
3236  0480 bf13          	ldw	_led_red+2,x
3237  0482 ae0001        	ldw	x,#1
3238  0485 bf11          	ldw	_led_red,x
3239                     ; 368 				if(bMAIN)led_green=0x00000005L;
3241                     	btst	_bMAIN
3242  048c 240e          	jruge	L7571
3245  048e ae0005        	ldw	x,#5
3246  0491 bf17          	ldw	_led_green+2,x
3247  0493 ae0000        	ldw	x,#0
3248  0496 bf15          	ldw	_led_green,x
3250  0498 acdd05dd      	jpf	L1271
3251  049c               L7571:
3252                     ; 369 				else led_green=0x00000000L;
3254  049c ae0000        	ldw	x,#0
3255  049f bf17          	ldw	_led_green+2,x
3256  04a1 ae0000        	ldw	x,#0
3257  04a4 bf15          	ldw	_led_green,x
3258  04a6 acdd05dd      	jpf	L1271
3259  04aa               L5571:
3260                     ; 371 			else if(flags&0b00001000)
3262  04aa b60a          	ld	a,_flags
3263  04ac a508          	bcp	a,#8
3264  04ae 272d          	jreq	L5671
3265                     ; 373 				led_red=0x00090009L;
3267  04b0 ae0009        	ldw	x,#9
3268  04b3 bf13          	ldw	_led_red+2,x
3269  04b5 ae0009        	ldw	x,#9
3270  04b8 bf11          	ldw	_led_red,x
3271                     ; 374 				if(bMAIN)led_green=0x00000005L;
3273                     	btst	_bMAIN
3274  04bf 240e          	jruge	L7671
3277  04c1 ae0005        	ldw	x,#5
3278  04c4 bf17          	ldw	_led_green+2,x
3279  04c6 ae0000        	ldw	x,#0
3280  04c9 bf15          	ldw	_led_green,x
3282  04cb acdd05dd      	jpf	L1271
3283  04cf               L7671:
3284                     ; 375 				else led_green=0x00000000L;	
3286  04cf ae0000        	ldw	x,#0
3287  04d2 bf17          	ldw	_led_green+2,x
3288  04d4 ae0000        	ldw	x,#0
3289  04d7 bf15          	ldw	_led_green,x
3290  04d9 acdd05dd      	jpf	L1271
3291  04dd               L5671:
3292                     ; 377 			else if(flags&0b00010000)
3294  04dd b60a          	ld	a,_flags
3295  04df a510          	bcp	a,#16
3296  04e1 272d          	jreq	L5771
3297                     ; 379 				led_red=0x00490049L;
3299  04e3 ae0049        	ldw	x,#73
3300  04e6 bf13          	ldw	_led_red+2,x
3301  04e8 ae0049        	ldw	x,#73
3302  04eb bf11          	ldw	_led_red,x
3303                     ; 380 				if(bMAIN)led_green=0x00000005L;
3305                     	btst	_bMAIN
3306  04f2 240e          	jruge	L7771
3309  04f4 ae0005        	ldw	x,#5
3310  04f7 bf17          	ldw	_led_green+2,x
3311  04f9 ae0000        	ldw	x,#0
3312  04fc bf15          	ldw	_led_green,x
3314  04fe acdd05dd      	jpf	L1271
3315  0502               L7771:
3316                     ; 381 				else led_green=0x00000000L;	
3318  0502 ae0000        	ldw	x,#0
3319  0505 bf17          	ldw	_led_green+2,x
3320  0507 ae0000        	ldw	x,#0
3321  050a bf15          	ldw	_led_green,x
3322  050c acdd05dd      	jpf	L1271
3323  0510               L5771:
3324                     ; 385 				led_red=0x55555555L;
3326  0510 ae5555        	ldw	x,#21845
3327  0513 bf13          	ldw	_led_red+2,x
3328  0515 ae5555        	ldw	x,#21845
3329  0518 bf11          	ldw	_led_red,x
3330                     ; 386 				led_green=0xffffffffL;
3332  051a aeffff        	ldw	x,#65535
3333  051d bf17          	ldw	_led_green+2,x
3334  051f aeffff        	ldw	x,#-1
3335  0522 bf15          	ldw	_led_green,x
3336  0524 acdd05dd      	jpf	L1271
3337  0528               L3371:
3338                     ; 402 		else if((link==ON)&&((flags&0b00111110)==0))
3340  0528 b65f          	ld	a,_link
3341  052a a155          	cp	a,#85
3342  052c 261d          	jrne	L7002
3344  052e b60a          	ld	a,_flags
3345  0530 a53e          	bcp	a,#62
3346  0532 2617          	jrne	L7002
3347                     ; 404 			led_red=0x00000000L;
3349  0534 ae0000        	ldw	x,#0
3350  0537 bf13          	ldw	_led_red+2,x
3351  0539 ae0000        	ldw	x,#0
3352  053c bf11          	ldw	_led_red,x
3353                     ; 405 			led_green=0xffffffffL;
3355  053e aeffff        	ldw	x,#65535
3356  0541 bf17          	ldw	_led_green+2,x
3357  0543 aeffff        	ldw	x,#-1
3358  0546 bf15          	ldw	_led_green,x
3360  0548 cc05dd        	jra	L1271
3361  054b               L7002:
3362                     ; 408 		else if((flags&0b00111110)==0b00000100)
3364  054b b60a          	ld	a,_flags
3365  054d a43e          	and	a,#62
3366  054f a104          	cp	a,#4
3367  0551 2616          	jrne	L3102
3368                     ; 410 			led_red=0x00010001L;
3370  0553 ae0001        	ldw	x,#1
3371  0556 bf13          	ldw	_led_red+2,x
3372  0558 ae0001        	ldw	x,#1
3373  055b bf11          	ldw	_led_red,x
3374                     ; 411 			led_green=0xffffffffL;	
3376  055d aeffff        	ldw	x,#65535
3377  0560 bf17          	ldw	_led_green+2,x
3378  0562 aeffff        	ldw	x,#-1
3379  0565 bf15          	ldw	_led_green,x
3381  0567 2074          	jra	L1271
3382  0569               L3102:
3383                     ; 413 		else if(flags&0b00000010)
3385  0569 b60a          	ld	a,_flags
3386  056b a502          	bcp	a,#2
3387  056d 2716          	jreq	L7102
3388                     ; 415 			led_red=0x00010001L;
3390  056f ae0001        	ldw	x,#1
3391  0572 bf13          	ldw	_led_red+2,x
3392  0574 ae0001        	ldw	x,#1
3393  0577 bf11          	ldw	_led_red,x
3394                     ; 416 			led_green=0x00000000L;	
3396  0579 ae0000        	ldw	x,#0
3397  057c bf17          	ldw	_led_green+2,x
3398  057e ae0000        	ldw	x,#0
3399  0581 bf15          	ldw	_led_green,x
3401  0583 2058          	jra	L1271
3402  0585               L7102:
3403                     ; 418 		else if(flags&0b00001000)
3405  0585 b60a          	ld	a,_flags
3406  0587 a508          	bcp	a,#8
3407  0589 2716          	jreq	L3202
3408                     ; 420 			led_red=0x00090009L;
3410  058b ae0009        	ldw	x,#9
3411  058e bf13          	ldw	_led_red+2,x
3412  0590 ae0009        	ldw	x,#9
3413  0593 bf11          	ldw	_led_red,x
3414                     ; 421 			led_green=0x00000000L;	
3416  0595 ae0000        	ldw	x,#0
3417  0598 bf17          	ldw	_led_green+2,x
3418  059a ae0000        	ldw	x,#0
3419  059d bf15          	ldw	_led_green,x
3421  059f 203c          	jra	L1271
3422  05a1               L3202:
3423                     ; 423 		else if(flags&0b00010000)
3425  05a1 b60a          	ld	a,_flags
3426  05a3 a510          	bcp	a,#16
3427  05a5 2716          	jreq	L7202
3428                     ; 425 			led_red=0x00490049L;
3430  05a7 ae0049        	ldw	x,#73
3431  05aa bf13          	ldw	_led_red+2,x
3432  05ac ae0049        	ldw	x,#73
3433  05af bf11          	ldw	_led_red,x
3434                     ; 426 			led_green=0x00000000L;	
3436  05b1 ae0000        	ldw	x,#0
3437  05b4 bf17          	ldw	_led_green+2,x
3438  05b6 ae0000        	ldw	x,#0
3439  05b9 bf15          	ldw	_led_green,x
3441  05bb 2020          	jra	L1271
3442  05bd               L7202:
3443                     ; 429 		else if((link==ON)&&(flags&0b00100000))
3445  05bd b65f          	ld	a,_link
3446  05bf a155          	cp	a,#85
3447  05c1 261a          	jrne	L1271
3449  05c3 b60a          	ld	a,_flags
3450  05c5 a520          	bcp	a,#32
3451  05c7 2714          	jreq	L1271
3452                     ; 431 			led_red=0x00000000L;
3454  05c9 ae0000        	ldw	x,#0
3455  05cc bf13          	ldw	_led_red+2,x
3456  05ce ae0000        	ldw	x,#0
3457  05d1 bf11          	ldw	_led_red,x
3458                     ; 432 			led_green=0x00030003L;
3460  05d3 ae0003        	ldw	x,#3
3461  05d6 bf17          	ldw	_led_green+2,x
3462  05d8 ae0003        	ldw	x,#3
3463  05db bf15          	ldw	_led_green,x
3464  05dd               L1271:
3465                     ; 435 		if((jp_mode==jp1))
3467  05dd b647          	ld	a,_jp_mode
3468  05df a101          	cp	a,#1
3469  05e1 2618          	jrne	L5302
3470                     ; 437 			led_red=0x00000000L;
3472  05e3 ae0000        	ldw	x,#0
3473  05e6 bf13          	ldw	_led_red+2,x
3474  05e8 ae0000        	ldw	x,#0
3475  05eb bf11          	ldw	_led_red,x
3476                     ; 438 			led_green=0x33333333L;
3478  05ed ae3333        	ldw	x,#13107
3479  05f0 bf17          	ldw	_led_green+2,x
3480  05f2 ae3333        	ldw	x,#13107
3481  05f5 bf15          	ldw	_led_green,x
3483  05f7 ac100710      	jpf	L1751
3484  05fb               L5302:
3485                     ; 440 		else if((jp_mode==jp2))
3487  05fb b647          	ld	a,_jp_mode
3488  05fd a102          	cp	a,#2
3489  05ff 2703          	jreq	L43
3490  0601 cc0710        	jp	L1751
3491  0604               L43:
3492                     ; 444 			led_red=0xccccccccL;
3494  0604 aecccc        	ldw	x,#52428
3495  0607 bf13          	ldw	_led_red+2,x
3496  0609 aecccc        	ldw	x,#-13108
3497  060c bf11          	ldw	_led_red,x
3498                     ; 445 			led_green=0x00000000L;
3500  060e ae0000        	ldw	x,#0
3501  0611 bf17          	ldw	_led_green+2,x
3502  0613 ae0000        	ldw	x,#0
3503  0616 bf15          	ldw	_led_green,x
3504  0618 ac100710      	jpf	L1751
3505  061c               L5171:
3506                     ; 448 	else if(jp_mode==jp3)
3508  061c b647          	ld	a,_jp_mode
3509  061e a103          	cp	a,#3
3510  0620 2703          	jreq	L63
3511  0622 cc0710        	jp	L1751
3512  0625               L63:
3513                     ; 450 		if(main_cnt1<(5*ee_TZAS))
3515  0625 9c            	rvf
3516  0626 ce0014        	ldw	x,_ee_TZAS
3517  0629 90ae0005      	ldw	y,#5
3518  062d cd0000        	call	c_imul
3520  0630 b34c          	cpw	x,_main_cnt1
3521  0632 2d18          	jrsle	L7402
3522                     ; 452 			led_red=0x00000000L;
3524  0634 ae0000        	ldw	x,#0
3525  0637 bf13          	ldw	_led_red+2,x
3526  0639 ae0000        	ldw	x,#0
3527  063c bf11          	ldw	_led_red,x
3528                     ; 453 			led_green=0x03030303L;
3530  063e ae0303        	ldw	x,#771
3531  0641 bf17          	ldw	_led_green+2,x
3532  0643 ae0303        	ldw	x,#771
3533  0646 bf15          	ldw	_led_green,x
3535  0648 ac100710      	jpf	L1751
3536  064c               L7402:
3537                     ; 455 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3539  064c 9c            	rvf
3540  064d ce0014        	ldw	x,_ee_TZAS
3541  0650 90ae0005      	ldw	y,#5
3542  0654 cd0000        	call	c_imul
3544  0657 b34c          	cpw	x,_main_cnt1
3545  0659 2e29          	jrsge	L3502
3547  065b 9c            	rvf
3548  065c ce0014        	ldw	x,_ee_TZAS
3549  065f 90ae0005      	ldw	y,#5
3550  0663 cd0000        	call	c_imul
3552  0666 1c0046        	addw	x,#70
3553  0669 b34c          	cpw	x,_main_cnt1
3554  066b 2d17          	jrsle	L3502
3555                     ; 457 			led_red=0x00000000L;
3557  066d ae0000        	ldw	x,#0
3558  0670 bf13          	ldw	_led_red+2,x
3559  0672 ae0000        	ldw	x,#0
3560  0675 bf11          	ldw	_led_red,x
3561                     ; 458 			led_green=0xffffffffL;	
3563  0677 aeffff        	ldw	x,#65535
3564  067a bf17          	ldw	_led_green+2,x
3565  067c aeffff        	ldw	x,#-1
3566  067f bf15          	ldw	_led_green,x
3568  0681 cc0710        	jra	L1751
3569  0684               L3502:
3570                     ; 461 		else if((flags&0b00011110)==0)
3572  0684 b60a          	ld	a,_flags
3573  0686 a51e          	bcp	a,#30
3574  0688 2616          	jrne	L7502
3575                     ; 463 			led_red=0x00000000L;
3577  068a ae0000        	ldw	x,#0
3578  068d bf13          	ldw	_led_red+2,x
3579  068f ae0000        	ldw	x,#0
3580  0692 bf11          	ldw	_led_red,x
3581                     ; 464 			led_green=0xffffffffL;
3583  0694 aeffff        	ldw	x,#65535
3584  0697 bf17          	ldw	_led_green+2,x
3585  0699 aeffff        	ldw	x,#-1
3586  069c bf15          	ldw	_led_green,x
3588  069e 2070          	jra	L1751
3589  06a0               L7502:
3590                     ; 468 		else if((flags&0b00111110)==0b00000100)
3592  06a0 b60a          	ld	a,_flags
3593  06a2 a43e          	and	a,#62
3594  06a4 a104          	cp	a,#4
3595  06a6 2616          	jrne	L3602
3596                     ; 470 			led_red=0x00010001L;
3598  06a8 ae0001        	ldw	x,#1
3599  06ab bf13          	ldw	_led_red+2,x
3600  06ad ae0001        	ldw	x,#1
3601  06b0 bf11          	ldw	_led_red,x
3602                     ; 471 			led_green=0xffffffffL;	
3604  06b2 aeffff        	ldw	x,#65535
3605  06b5 bf17          	ldw	_led_green+2,x
3606  06b7 aeffff        	ldw	x,#-1
3607  06ba bf15          	ldw	_led_green,x
3609  06bc 2052          	jra	L1751
3610  06be               L3602:
3611                     ; 473 		else if(flags&0b00000010)
3613  06be b60a          	ld	a,_flags
3614  06c0 a502          	bcp	a,#2
3615  06c2 2716          	jreq	L7602
3616                     ; 475 			led_red=0x00010001L;
3618  06c4 ae0001        	ldw	x,#1
3619  06c7 bf13          	ldw	_led_red+2,x
3620  06c9 ae0001        	ldw	x,#1
3621  06cc bf11          	ldw	_led_red,x
3622                     ; 476 			led_green=0x00000000L;	
3624  06ce ae0000        	ldw	x,#0
3625  06d1 bf17          	ldw	_led_green+2,x
3626  06d3 ae0000        	ldw	x,#0
3627  06d6 bf15          	ldw	_led_green,x
3629  06d8 2036          	jra	L1751
3630  06da               L7602:
3631                     ; 478 		else if(flags&0b00001000)
3633  06da b60a          	ld	a,_flags
3634  06dc a508          	bcp	a,#8
3635  06de 2716          	jreq	L3702
3636                     ; 480 			led_red=0x00090009L;
3638  06e0 ae0009        	ldw	x,#9
3639  06e3 bf13          	ldw	_led_red+2,x
3640  06e5 ae0009        	ldw	x,#9
3641  06e8 bf11          	ldw	_led_red,x
3642                     ; 481 			led_green=0x00000000L;	
3644  06ea ae0000        	ldw	x,#0
3645  06ed bf17          	ldw	_led_green+2,x
3646  06ef ae0000        	ldw	x,#0
3647  06f2 bf15          	ldw	_led_green,x
3649  06f4 201a          	jra	L1751
3650  06f6               L3702:
3651                     ; 483 		else if(flags&0b00010000)
3653  06f6 b60a          	ld	a,_flags
3654  06f8 a510          	bcp	a,#16
3655  06fa 2714          	jreq	L1751
3656                     ; 485 			led_red=0x00490049L;
3658  06fc ae0049        	ldw	x,#73
3659  06ff bf13          	ldw	_led_red+2,x
3660  0701 ae0049        	ldw	x,#73
3661  0704 bf11          	ldw	_led_red,x
3662                     ; 486 			led_green=0xffffffffL;	
3664  0706 aeffff        	ldw	x,#65535
3665  0709 bf17          	ldw	_led_green+2,x
3666  070b aeffff        	ldw	x,#-1
3667  070e bf15          	ldw	_led_green,x
3668  0710               L1751:
3669                     ; 490 }
3672  0710 81            	ret
3700                     ; 493 void led_drv(void)
3700                     ; 494 {
3701                     	switch	.text
3702  0711               _led_drv:
3706                     ; 496 GPIOA->DDR|=(1<<6);
3708  0711 721c5002      	bset	20482,#6
3709                     ; 497 GPIOA->CR1|=(1<<6);
3711  0715 721c5003      	bset	20483,#6
3712                     ; 498 GPIOA->CR2&=~(1<<6);
3714  0719 721d5004      	bres	20484,#6
3715                     ; 499 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<6); 	//Горит если в led_red_buff 1 и на ножке 1
3717  071d b63d          	ld	a,_led_red_buff+3
3718  071f a501          	bcp	a,#1
3719  0721 2706          	jreq	L1112
3722  0723 721c5000      	bset	20480,#6
3724  0727 2004          	jra	L3112
3725  0729               L1112:
3726                     ; 500 else GPIOA->ODR&=~(1<<6); 
3728  0729 721d5000      	bres	20480,#6
3729  072d               L3112:
3730                     ; 503 GPIOA->DDR|=(1<<5);
3732  072d 721a5002      	bset	20482,#5
3733                     ; 504 GPIOA->CR1|=(1<<5);
3735  0731 721a5003      	bset	20483,#5
3736                     ; 505 GPIOA->CR2&=~(1<<5);	
3738  0735 721b5004      	bres	20484,#5
3739                     ; 506 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3741  0739 b639          	ld	a,_led_green_buff+3
3742  073b a501          	bcp	a,#1
3743  073d 2706          	jreq	L5112
3746  073f 721a5000      	bset	20480,#5
3748  0743 2004          	jra	L7112
3749  0745               L5112:
3750                     ; 507 else GPIOA->ODR&=~(1<<5);
3752  0745 721b5000      	bres	20480,#5
3753  0749               L7112:
3754                     ; 510 led_red_buff>>=1;
3756  0749 373a          	sra	_led_red_buff
3757  074b 363b          	rrc	_led_red_buff+1
3758  074d 363c          	rrc	_led_red_buff+2
3759  074f 363d          	rrc	_led_red_buff+3
3760                     ; 511 led_green_buff>>=1;
3762  0751 3736          	sra	_led_green_buff
3763  0753 3637          	rrc	_led_green_buff+1
3764  0755 3638          	rrc	_led_green_buff+2
3765  0757 3639          	rrc	_led_green_buff+3
3766                     ; 512 if(++led_drv_cnt>32)
3768  0759 3c19          	inc	_led_drv_cnt
3769  075b b619          	ld	a,_led_drv_cnt
3770  075d a121          	cp	a,#33
3771  075f 2512          	jrult	L1212
3772                     ; 514 	led_drv_cnt=0;
3774  0761 3f19          	clr	_led_drv_cnt
3775                     ; 515 	led_red_buff=led_red;
3777  0763 be13          	ldw	x,_led_red+2
3778  0765 bf3c          	ldw	_led_red_buff+2,x
3779  0767 be11          	ldw	x,_led_red
3780  0769 bf3a          	ldw	_led_red_buff,x
3781                     ; 516 	led_green_buff=led_green;
3783  076b be17          	ldw	x,_led_green+2
3784  076d bf38          	ldw	_led_green_buff+2,x
3785  076f be15          	ldw	x,_led_green
3786  0771 bf36          	ldw	_led_green_buff,x
3787  0773               L1212:
3788                     ; 522 } 
3791  0773 81            	ret
3817                     ; 525 void JP_drv(void)
3817                     ; 526 {
3818                     	switch	.text
3819  0774               _JP_drv:
3823                     ; 528 GPIOD->DDR&=~(1<<6);
3825  0774 721d5011      	bres	20497,#6
3826                     ; 529 GPIOD->CR1|=(1<<6);
3828  0778 721c5012      	bset	20498,#6
3829                     ; 530 GPIOD->CR2&=~(1<<6);
3831  077c 721d5013      	bres	20499,#6
3832                     ; 532 GPIOD->DDR&=~(1<<7);
3834  0780 721f5011      	bres	20497,#7
3835                     ; 533 GPIOD->CR1|=(1<<7);
3837  0784 721e5012      	bset	20498,#7
3838                     ; 534 GPIOD->CR2&=~(1<<7);
3840  0788 721f5013      	bres	20499,#7
3841                     ; 536 if(GPIOD->IDR&(1<<6))
3843  078c c65010        	ld	a,20496
3844  078f a540          	bcp	a,#64
3845  0791 270a          	jreq	L3312
3846                     ; 538 	if(cnt_JP0<10)
3848  0793 b646          	ld	a,_cnt_JP0
3849  0795 a10a          	cp	a,#10
3850  0797 2411          	jruge	L7312
3851                     ; 540 		cnt_JP0++;
3853  0799 3c46          	inc	_cnt_JP0
3854  079b 200d          	jra	L7312
3855  079d               L3312:
3856                     ; 543 else if(!(GPIOD->IDR&(1<<6)))
3858  079d c65010        	ld	a,20496
3859  07a0 a540          	bcp	a,#64
3860  07a2 2606          	jrne	L7312
3861                     ; 545 	if(cnt_JP0)
3863  07a4 3d46          	tnz	_cnt_JP0
3864  07a6 2702          	jreq	L7312
3865                     ; 547 		cnt_JP0--;
3867  07a8 3a46          	dec	_cnt_JP0
3868  07aa               L7312:
3869                     ; 551 if(GPIOD->IDR&(1<<7))
3871  07aa c65010        	ld	a,20496
3872  07ad a580          	bcp	a,#128
3873  07af 270a          	jreq	L5412
3874                     ; 553 	if(cnt_JP1<10)
3876  07b1 b645          	ld	a,_cnt_JP1
3877  07b3 a10a          	cp	a,#10
3878  07b5 2411          	jruge	L1512
3879                     ; 555 		cnt_JP1++;
3881  07b7 3c45          	inc	_cnt_JP1
3882  07b9 200d          	jra	L1512
3883  07bb               L5412:
3884                     ; 558 else if(!(GPIOD->IDR&(1<<7)))
3886  07bb c65010        	ld	a,20496
3887  07be a580          	bcp	a,#128
3888  07c0 2606          	jrne	L1512
3889                     ; 560 	if(cnt_JP1)
3891  07c2 3d45          	tnz	_cnt_JP1
3892  07c4 2702          	jreq	L1512
3893                     ; 562 		cnt_JP1--;
3895  07c6 3a45          	dec	_cnt_JP1
3896  07c8               L1512:
3897                     ; 567 if((cnt_JP0==10)&&(cnt_JP1==10))
3899  07c8 b646          	ld	a,_cnt_JP0
3900  07ca a10a          	cp	a,#10
3901  07cc 2608          	jrne	L7512
3903  07ce b645          	ld	a,_cnt_JP1
3904  07d0 a10a          	cp	a,#10
3905  07d2 2602          	jrne	L7512
3906                     ; 569 	jp_mode=jp0;
3908  07d4 3f47          	clr	_jp_mode
3909  07d6               L7512:
3910                     ; 571 if((cnt_JP0==0)&&(cnt_JP1==10))
3912  07d6 3d46          	tnz	_cnt_JP0
3913  07d8 260a          	jrne	L1612
3915  07da b645          	ld	a,_cnt_JP1
3916  07dc a10a          	cp	a,#10
3917  07de 2604          	jrne	L1612
3918                     ; 573 	jp_mode=jp1;
3920  07e0 35010047      	mov	_jp_mode,#1
3921  07e4               L1612:
3922                     ; 575 if((cnt_JP0==10)&&(cnt_JP1==0))
3924  07e4 b646          	ld	a,_cnt_JP0
3925  07e6 a10a          	cp	a,#10
3926  07e8 2608          	jrne	L3612
3928  07ea 3d45          	tnz	_cnt_JP1
3929  07ec 2604          	jrne	L3612
3930                     ; 577 	jp_mode=jp2;
3932  07ee 35020047      	mov	_jp_mode,#2
3933  07f2               L3612:
3934                     ; 579 if((cnt_JP0==0)&&(cnt_JP1==0))
3936  07f2 3d46          	tnz	_cnt_JP0
3937  07f4 2608          	jrne	L5612
3939  07f6 3d45          	tnz	_cnt_JP1
3940  07f8 2604          	jrne	L5612
3941                     ; 581 	jp_mode=jp3;
3943  07fa 35030047      	mov	_jp_mode,#3
3944  07fe               L5612:
3945                     ; 584 }
3948  07fe 81            	ret
3980                     ; 587 void link_drv(void)		//10Hz
3980                     ; 588 {
3981                     	switch	.text
3982  07ff               _link_drv:
3986                     ; 589 if(jp_mode!=jp3)
3988  07ff b647          	ld	a,_jp_mode
3989  0801 a103          	cp	a,#3
3990  0803 2744          	jreq	L7712
3991                     ; 591 	if(link_cnt<52)link_cnt++;
3993  0805 b65e          	ld	a,_link_cnt
3994  0807 a134          	cp	a,#52
3995  0809 2402          	jruge	L1022
3998  080b 3c5e          	inc	_link_cnt
3999  080d               L1022:
4000                     ; 592 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4002  080d b65e          	ld	a,_link_cnt
4003  080f a131          	cp	a,#49
4004  0811 2606          	jrne	L3022
4007  0813 b60a          	ld	a,_flags
4008  0815 a4c1          	and	a,#193
4009  0817 b70a          	ld	_flags,a
4010  0819               L3022:
4011                     ; 593 	if(link_cnt==50)
4013  0819 b65e          	ld	a,_link_cnt
4014  081b a132          	cp	a,#50
4015  081d 262e          	jrne	L5122
4016                     ; 595 		link=OFF;
4018  081f 35aa005f      	mov	_link,#170
4019                     ; 600 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4021  0823 b601          	ld	a,_bps_class
4022  0825 a101          	cp	a,#1
4023  0827 2606          	jrne	L7022
4026  0829 72100002      	bset	_bMAIN
4028  082d 2004          	jra	L1122
4029  082f               L7022:
4030                     ; 601 		else bMAIN=0;
4032  082f 72110002      	bres	_bMAIN
4033  0833               L1122:
4034                     ; 603 		cnt_net_drv=0;
4036  0833 3f2f          	clr	_cnt_net_drv
4037                     ; 604     		if(!res_fl_)
4039  0835 725d0008      	tnz	_res_fl_
4040  0839 2612          	jrne	L5122
4041                     ; 606 	    		bRES_=1;
4043  083b 35010010      	mov	_bRES_,#1
4044                     ; 607 	    		res_fl_=1;
4046  083f a601          	ld	a,#1
4047  0841 ae0008        	ldw	x,#_res_fl_
4048  0844 cd0000        	call	c_eewrc
4050  0847 2004          	jra	L5122
4051  0849               L7712:
4052                     ; 611 else link=OFF;	
4054  0849 35aa005f      	mov	_link,#170
4055  084d               L5122:
4056                     ; 612 } 
4059  084d 81            	ret
4128                     .const:	section	.text
4129  0000               L05:
4130  0000 0000000b      	dc.l	11
4131  0004               L25:
4132  0004 00000001      	dc.l	1
4133                     ; 616 void vent_drv(void)
4133                     ; 617 {
4134                     	switch	.text
4135  084e               _vent_drv:
4137  084e 520e          	subw	sp,#14
4138       0000000e      OFST:	set	14
4141                     ; 620 	short vent_pwm_i_necc=400;
4143  0850 ae0190        	ldw	x,#400
4144  0853 1f07          	ldw	(OFST-7,sp),x
4145                     ; 621 	short vent_pwm_t_necc=400;
4147  0855 ae0190        	ldw	x,#400
4148  0858 1f09          	ldw	(OFST-5,sp),x
4149                     ; 622 	short vent_pwm_max_necc=400;
4151                     ; 627 	tempSL=36000L/(signed long)ee_Umax;
4153  085a ce0012        	ldw	x,_ee_Umax
4154  085d cd0000        	call	c_itolx
4156  0860 96            	ldw	x,sp
4157  0861 1c0001        	addw	x,#OFST-13
4158  0864 cd0000        	call	c_rtol
4160  0867 ae8ca0        	ldw	x,#36000
4161  086a bf02          	ldw	c_lreg+2,x
4162  086c ae0000        	ldw	x,#0
4163  086f bf00          	ldw	c_lreg,x
4164  0871 96            	ldw	x,sp
4165  0872 1c0001        	addw	x,#OFST-13
4166  0875 cd0000        	call	c_ldiv
4168  0878 96            	ldw	x,sp
4169  0879 1c000b        	addw	x,#OFST-3
4170  087c cd0000        	call	c_rtol
4172                     ; 628 	tempSL=(signed long)I/tempSL;
4174  087f be6b          	ldw	x,_I
4175  0881 cd0000        	call	c_itolx
4177  0884 96            	ldw	x,sp
4178  0885 1c000b        	addw	x,#OFST-3
4179  0888 cd0000        	call	c_ldiv
4181  088b 96            	ldw	x,sp
4182  088c 1c000b        	addw	x,#OFST-3
4183  088f cd0000        	call	c_rtol
4185                     ; 630 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4187  0892 ce0002        	ldw	x,_ee_DEVICE
4188  0895 a30001        	cpw	x,#1
4189  0898 2613          	jrne	L1522
4192  089a be6b          	ldw	x,_I
4193  089c 90ce0000      	ldw	y,_ee_IMAXVENT
4194  08a0 cd0000        	call	c_idiv
4196  08a3 cd0000        	call	c_itolx
4198  08a6 96            	ldw	x,sp
4199  08a7 1c000b        	addw	x,#OFST-3
4200  08aa cd0000        	call	c_rtol
4202  08ad               L1522:
4203                     ; 632 	if(tempSL>10)vent_pwm_i_necc=1000;
4205  08ad 9c            	rvf
4206  08ae 96            	ldw	x,sp
4207  08af 1c000b        	addw	x,#OFST-3
4208  08b2 cd0000        	call	c_ltor
4210  08b5 ae0000        	ldw	x,#L05
4211  08b8 cd0000        	call	c_lcmp
4213  08bb 2f07          	jrslt	L3522
4216  08bd ae03e8        	ldw	x,#1000
4217  08c0 1f07          	ldw	(OFST-7,sp),x
4219  08c2 2025          	jra	L5522
4220  08c4               L3522:
4221                     ; 633 	else if(tempSL<1)vent_pwm_i_necc=400;
4223  08c4 9c            	rvf
4224  08c5 96            	ldw	x,sp
4225  08c6 1c000b        	addw	x,#OFST-3
4226  08c9 cd0000        	call	c_ltor
4228  08cc ae0004        	ldw	x,#L25
4229  08cf cd0000        	call	c_lcmp
4231  08d2 2e07          	jrsge	L7522
4234  08d4 ae0190        	ldw	x,#400
4235  08d7 1f07          	ldw	(OFST-7,sp),x
4237  08d9 200e          	jra	L5522
4238  08db               L7522:
4239                     ; 634 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4241  08db 1e0d          	ldw	x,(OFST-1,sp)
4242  08dd 90ae003c      	ldw	y,#60
4243  08e1 cd0000        	call	c_imul
4245  08e4 1c0190        	addw	x,#400
4246  08e7 1f07          	ldw	(OFST-7,sp),x
4247  08e9               L5522:
4248                     ; 635 	gran(&vent_pwm_i_necc,400,1000);
4250  08e9 ae03e8        	ldw	x,#1000
4251  08ec 89            	pushw	x
4252  08ed ae0190        	ldw	x,#400
4253  08f0 89            	pushw	x
4254  08f1 96            	ldw	x,sp
4255  08f2 1c000b        	addw	x,#OFST-3
4256  08f5 cd0000        	call	_gran
4258  08f8 5b04          	addw	sp,#4
4259                     ; 637 	tempSL=(signed long)T;
4261  08fa b664          	ld	a,_T
4262  08fc b703          	ld	c_lreg+3,a
4263  08fe 48            	sll	a
4264  08ff 4f            	clr	a
4265  0900 a200          	sbc	a,#0
4266  0902 b702          	ld	c_lreg+2,a
4267  0904 b701          	ld	c_lreg+1,a
4268  0906 b700          	ld	c_lreg,a
4269  0908 96            	ldw	x,sp
4270  0909 1c000b        	addw	x,#OFST-3
4271  090c cd0000        	call	c_rtol
4273                     ; 638 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4275  090f 9c            	rvf
4276  0910 ce000c        	ldw	x,_ee_tsign
4277  0913 cd0000        	call	c_itolx
4279  0916 a61e          	ld	a,#30
4280  0918 cd0000        	call	c_lsbc
4282  091b 96            	ldw	x,sp
4283  091c 1c000b        	addw	x,#OFST-3
4284  091f cd0000        	call	c_lcmp
4286  0922 2f07          	jrslt	L3622
4289  0924 ae0190        	ldw	x,#400
4290  0927 1f09          	ldw	(OFST-5,sp),x
4292  0929 2030          	jra	L5622
4293  092b               L3622:
4294                     ; 639 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4296  092b 9c            	rvf
4297  092c ce000c        	ldw	x,_ee_tsign
4298  092f cd0000        	call	c_itolx
4300  0932 96            	ldw	x,sp
4301  0933 1c000b        	addw	x,#OFST-3
4302  0936 cd0000        	call	c_lcmp
4304  0939 2c07          	jrsgt	L7622
4307  093b ae03e8        	ldw	x,#1000
4308  093e 1f09          	ldw	(OFST-5,sp),x
4310  0940 2019          	jra	L5622
4311  0942               L7622:
4312                     ; 640 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4314  0942 ce000c        	ldw	x,_ee_tsign
4315  0945 1d001e        	subw	x,#30
4316  0948 1f03          	ldw	(OFST-11,sp),x
4317  094a 1e0d          	ldw	x,(OFST-1,sp)
4318  094c 72f003        	subw	x,(OFST-11,sp)
4319  094f 90ae0014      	ldw	y,#20
4320  0953 cd0000        	call	c_imul
4322  0956 1c0190        	addw	x,#400
4323  0959 1f09          	ldw	(OFST-5,sp),x
4324  095b               L5622:
4325                     ; 641 	gran(&vent_pwm_t_necc,400,1000);
4327  095b ae03e8        	ldw	x,#1000
4328  095e 89            	pushw	x
4329  095f ae0190        	ldw	x,#400
4330  0962 89            	pushw	x
4331  0963 96            	ldw	x,sp
4332  0964 1c000d        	addw	x,#OFST-1
4333  0967 cd0000        	call	_gran
4335  096a 5b04          	addw	sp,#4
4336                     ; 643 	vent_pwm_max_necc=vent_pwm_i_necc;
4338  096c 1e07          	ldw	x,(OFST-7,sp)
4339  096e 1f05          	ldw	(OFST-9,sp),x
4340                     ; 644 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4342  0970 9c            	rvf
4343  0971 1e09          	ldw	x,(OFST-5,sp)
4344  0973 1307          	cpw	x,(OFST-7,sp)
4345  0975 2d04          	jrsle	L3722
4348  0977 1e09          	ldw	x,(OFST-5,sp)
4349  0979 1f05          	ldw	(OFST-9,sp),x
4350  097b               L3722:
4351                     ; 646 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4353  097b 9c            	rvf
4354  097c be02          	ldw	x,_vent_pwm
4355  097e 1305          	cpw	x,(OFST-9,sp)
4356  0980 2e07          	jrsge	L5722
4359  0982 be02          	ldw	x,_vent_pwm
4360  0984 1c000a        	addw	x,#10
4361  0987 bf02          	ldw	_vent_pwm,x
4362  0989               L5722:
4363                     ; 647 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4365  0989 9c            	rvf
4366  098a be02          	ldw	x,_vent_pwm
4367  098c 1305          	cpw	x,(OFST-9,sp)
4368  098e 2d07          	jrsle	L7722
4371  0990 be02          	ldw	x,_vent_pwm
4372  0992 1d000a        	subw	x,#10
4373  0995 bf02          	ldw	_vent_pwm,x
4374  0997               L7722:
4375                     ; 648 	gran(&vent_pwm,400,1000);
4377  0997 ae03e8        	ldw	x,#1000
4378  099a 89            	pushw	x
4379  099b ae0190        	ldw	x,#400
4380  099e 89            	pushw	x
4381  099f ae0002        	ldw	x,#_vent_pwm
4382  09a2 cd0000        	call	_gran
4384  09a5 5b04          	addw	sp,#4
4385                     ; 650 }
4388  09a7 5b0e          	addw	sp,#14
4389  09a9 81            	ret
4423                     ; 655 void pwr_drv(void)
4423                     ; 656 {
4424                     	switch	.text
4425  09aa               _pwr_drv:
4429                     ; 660 BLOCK_INIT
4431  09aa 72145007      	bset	20487,#2
4434  09ae 72145008      	bset	20488,#2
4437  09b2 72155009      	bres	20489,#2
4438                     ; 662 if(main_cnt1<1500)main_cnt1++;
4440  09b6 9c            	rvf
4441  09b7 be4c          	ldw	x,_main_cnt1
4442  09b9 a305dc        	cpw	x,#1500
4443  09bc 2e07          	jrsge	L1132
4446  09be be4c          	ldw	x,_main_cnt1
4447  09c0 1c0001        	addw	x,#1
4448  09c3 bf4c          	ldw	_main_cnt1,x
4449  09c5               L1132:
4450                     ; 665 if((ee_DEVICE))
4452  09c5 ce0002        	ldw	x,_ee_DEVICE
4453  09c8 2721          	jreq	L3132
4454                     ; 667 	if(bBL)
4456                     	btst	_bBL
4457  09cf 2408          	jruge	L5132
4458                     ; 669 		BLOCK_ON
4460  09d1 72145005      	bset	20485,#2
4462  09d5 ac8d0a8d      	jpf	L3232
4463  09d9               L5132:
4464                     ; 671 	else if(!bBL)
4466                     	btst	_bBL
4467  09de 2403          	jruge	L65
4468  09e0 cc0a8d        	jp	L3232
4469  09e3               L65:
4470                     ; 673 		BLOCK_OFF
4472  09e3 72155005      	bres	20485,#2
4473  09e7 ac8d0a8d      	jpf	L3232
4474  09eb               L3132:
4475                     ; 676 else if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4477  09eb 9c            	rvf
4478  09ec ce0014        	ldw	x,_ee_TZAS
4479  09ef 90ae0005      	ldw	y,#5
4480  09f3 cd0000        	call	c_imul
4482  09f6 b34c          	cpw	x,_main_cnt1
4483  09f8 2d0d          	jrsle	L5232
4485  09fa b601          	ld	a,_bps_class
4486  09fc a101          	cp	a,#1
4487  09fe 2707          	jreq	L5232
4488                     ; 678 	BLOCK_ON
4490  0a00 72145005      	bset	20485,#2
4492  0a04 cc0a8d        	jra	L3232
4493  0a07               L5232:
4494                     ; 681 else if(bps_class==bpsIPS)
4496  0a07 b601          	ld	a,_bps_class
4497  0a09 a101          	cp	a,#1
4498  0a0b 261a          	jrne	L1332
4499                     ; 684 		if(bBL_IPS)
4501                     	btst	_bBL_IPS
4502  0a12 2406          	jruge	L3332
4503                     ; 686 			 BLOCK_ON
4505  0a14 72145005      	bset	20485,#2
4507  0a18 2073          	jra	L3232
4508  0a1a               L3332:
4509                     ; 689 		else if(!bBL_IPS)
4511                     	btst	_bBL_IPS
4512  0a1f 256c          	jrult	L3232
4513                     ; 691 			  BLOCK_OFF
4515  0a21 72155005      	bres	20485,#2
4516  0a25 2066          	jra	L3232
4517  0a27               L1332:
4518                     ; 695 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4520  0a27 9c            	rvf
4521  0a28 ce0014        	ldw	x,_ee_TZAS
4522  0a2b 90ae0005      	ldw	y,#5
4523  0a2f cd0000        	call	c_imul
4525  0a32 b34c          	cpw	x,_main_cnt1
4526  0a34 2e3f          	jrsge	L3432
4528  0a36 9c            	rvf
4529  0a37 ce0014        	ldw	x,_ee_TZAS
4530  0a3a 90ae0005      	ldw	y,#5
4531  0a3e cd0000        	call	c_imul
4533  0a41 1c0046        	addw	x,#70
4534  0a44 b34c          	cpw	x,_main_cnt1
4535  0a46 2d2d          	jrsle	L3432
4536                     ; 697 	if(bps_class==bpsIPS)
4538  0a48 b601          	ld	a,_bps_class
4539  0a4a a101          	cp	a,#1
4540  0a4c 2606          	jrne	L5432
4541                     ; 699 		  BLOCK_OFF
4543  0a4e 72155005      	bres	20485,#2
4545  0a52 2039          	jra	L3232
4546  0a54               L5432:
4547                     ; 702 	else if(bps_class==bpsIBEP)
4549  0a54 3d01          	tnz	_bps_class
4550  0a56 2635          	jrne	L3232
4551                     ; 704 		if(ee_DEVICE)
4553  0a58 ce0002        	ldw	x,_ee_DEVICE
4554  0a5b 2712          	jreq	L3532
4555                     ; 706 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4557  0a5d b60a          	ld	a,_flags
4558  0a5f a520          	bcp	a,#32
4559  0a61 2706          	jreq	L5532
4562  0a63 72145005      	bset	20485,#2
4564  0a67 2024          	jra	L3232
4565  0a69               L5532:
4566                     ; 707 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4568  0a69 72155005      	bres	20485,#2
4569  0a6d 201e          	jra	L3232
4570  0a6f               L3532:
4571                     ; 711 			BLOCK_OFF
4573  0a6f 72155005      	bres	20485,#2
4574  0a73 2018          	jra	L3232
4575  0a75               L3432:
4576                     ; 716 else if(bBL)
4578                     	btst	_bBL
4579  0a7a 2406          	jruge	L5632
4580                     ; 718 	BLOCK_ON
4582  0a7c 72145005      	bset	20485,#2
4584  0a80 200b          	jra	L3232
4585  0a82               L5632:
4586                     ; 721 else if(!bBL)
4588                     	btst	_bBL
4589  0a87 2504          	jrult	L3232
4590                     ; 723 	BLOCK_OFF
4592  0a89 72155005      	bres	20485,#2
4593  0a8d               L3232:
4594                     ; 727 gran(&pwm_u,2,1020);
4596  0a8d ae03fc        	ldw	x,#1020
4597  0a90 89            	pushw	x
4598  0a91 ae0002        	ldw	x,#2
4599  0a94 89            	pushw	x
4600  0a95 ae000b        	ldw	x,#_pwm_u
4601  0a98 cd0000        	call	_gran
4603  0a9b 5b04          	addw	sp,#4
4604                     ; 737 TIM1->CCR2H= (char)(pwm_u/256);	
4606  0a9d be0b          	ldw	x,_pwm_u
4607  0a9f 90ae0100      	ldw	y,#256
4608  0aa3 cd0000        	call	c_idiv
4610  0aa6 9f            	ld	a,xl
4611  0aa7 c75267        	ld	21095,a
4612                     ; 738 TIM1->CCR2L= (char)pwm_u;
4614  0aaa 55000c5268    	mov	21096,_pwm_u+1
4615                     ; 740 TIM1->CCR1H= (char)(pwm_i/256);	
4617  0aaf be0d          	ldw	x,_pwm_i
4618  0ab1 90ae0100      	ldw	y,#256
4619  0ab5 cd0000        	call	c_idiv
4621  0ab8 9f            	ld	a,xl
4622  0ab9 c75265        	ld	21093,a
4623                     ; 741 TIM1->CCR1L= (char)pwm_i;
4625  0abc 55000e5266    	mov	21094,_pwm_i+1
4626                     ; 743 TIM1->CCR3H= (char)(vent_pwm/256);	
4628  0ac1 be02          	ldw	x,_vent_pwm
4629  0ac3 90ae0100      	ldw	y,#256
4630  0ac7 cd0000        	call	c_idiv
4632  0aca 9f            	ld	a,xl
4633  0acb c75269        	ld	21097,a
4634                     ; 744 TIM1->CCR3L= (char)vent_pwm;
4636  0ace 550003526a    	mov	21098,_vent_pwm+1
4637                     ; 745 }
4640  0ad3 81            	ret
4678                     ; 753 void pwr_hndl(void)				
4678                     ; 754 {
4679                     	switch	.text
4680  0ad4               _pwr_hndl:
4684                     ; 755 if(jp_mode==jp3)
4686  0ad4 b647          	ld	a,_jp_mode
4687  0ad6 a103          	cp	a,#3
4688  0ad8 2627          	jrne	L3042
4689                     ; 757 	if((flags&0b00001010)==0)
4691  0ada b60a          	ld	a,_flags
4692  0adc a50a          	bcp	a,#10
4693  0ade 260d          	jrne	L5042
4694                     ; 759 		pwm_u=500;
4696  0ae0 ae01f4        	ldw	x,#500
4697  0ae3 bf0b          	ldw	_pwm_u,x
4698                     ; 761 		bBL=0;
4700  0ae5 72110000      	bres	_bBL
4702  0ae9 acef0bef      	jpf	L3142
4703  0aed               L5042:
4704                     ; 763 	else if(flags&0b00001010)
4706  0aed b60a          	ld	a,_flags
4707  0aef a50a          	bcp	a,#10
4708  0af1 2603          	jrne	L26
4709  0af3 cc0bef        	jp	L3142
4710  0af6               L26:
4711                     ; 765 		pwm_u=0;
4713  0af6 5f            	clrw	x
4714  0af7 bf0b          	ldw	_pwm_u,x
4715                     ; 767 		bBL=1;
4717  0af9 72100000      	bset	_bBL
4718  0afd acef0bef      	jpf	L3142
4719  0b01               L3042:
4720                     ; 771 else if(jp_mode==jp2)
4722  0b01 b647          	ld	a,_jp_mode
4723  0b03 a102          	cp	a,#2
4724  0b05 2610          	jrne	L5142
4725                     ; 773 	pwm_u=0;
4727  0b07 5f            	clrw	x
4728  0b08 bf0b          	ldw	_pwm_u,x
4729                     ; 774 	pwm_i=0x3ff;
4731  0b0a ae03ff        	ldw	x,#1023
4732  0b0d bf0d          	ldw	_pwm_i,x
4733                     ; 775 	bBL=0;
4735  0b0f 72110000      	bres	_bBL
4737  0b13 acef0bef      	jpf	L3142
4738  0b17               L5142:
4739                     ; 777 else if(jp_mode==jp1)
4741  0b17 b647          	ld	a,_jp_mode
4742  0b19 a101          	cp	a,#1
4743  0b1b 2612          	jrne	L1242
4744                     ; 779 	pwm_u=0x3ff;
4746  0b1d ae03ff        	ldw	x,#1023
4747  0b20 bf0b          	ldw	_pwm_u,x
4748                     ; 780 	pwm_i=0x3ff;
4750  0b22 ae03ff        	ldw	x,#1023
4751  0b25 bf0d          	ldw	_pwm_i,x
4752                     ; 781 	bBL=0;
4754  0b27 72110000      	bres	_bBL
4756  0b2b acef0bef      	jpf	L3142
4757  0b2f               L1242:
4758                     ; 784 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4760                     	btst	_bMAIN
4761  0b34 2417          	jruge	L5242
4763  0b36 b65f          	ld	a,_link
4764  0b38 a155          	cp	a,#85
4765  0b3a 2611          	jrne	L5242
4766                     ; 786 	pwm_u=volum_u_main_;
4768  0b3c be1c          	ldw	x,_volum_u_main_
4769  0b3e bf0b          	ldw	_pwm_u,x
4770                     ; 787 	pwm_i=0x3ff;
4772  0b40 ae03ff        	ldw	x,#1023
4773  0b43 bf0d          	ldw	_pwm_i,x
4774                     ; 788 	bBL_IPS=0;
4776  0b45 72110001      	bres	_bBL_IPS
4778  0b49 acef0bef      	jpf	L3142
4779  0b4d               L5242:
4780                     ; 791 else if(link==OFF)
4782  0b4d b65f          	ld	a,_link
4783  0b4f a1aa          	cp	a,#170
4784  0b51 2650          	jrne	L1342
4785                     ; 800  	if(ee_DEVICE)
4787  0b53 ce0002        	ldw	x,_ee_DEVICE
4788  0b56 270d          	jreq	L3342
4789                     ; 802 		pwm_u=0x00;
4791  0b58 5f            	clrw	x
4792  0b59 bf0b          	ldw	_pwm_u,x
4793                     ; 803 		pwm_i=0x00;
4795  0b5b 5f            	clrw	x
4796  0b5c bf0d          	ldw	_pwm_i,x
4797                     ; 804 		bBL=1;
4799  0b5e 72100000      	bset	_bBL
4801  0b62 cc0bef        	jra	L3142
4802  0b65               L3342:
4803                     ; 808 		if((flags&0b00011010)==0)
4805  0b65 b60a          	ld	a,_flags
4806  0b67 a51a          	bcp	a,#26
4807  0b69 2622          	jrne	L7342
4808                     ; 810 			pwm_u=ee_U_AVT;
4810  0b6b ce000a        	ldw	x,_ee_U_AVT
4811  0b6e bf0b          	ldw	_pwm_u,x
4812                     ; 811 			gran(&pwm_u,0,1020);
4814  0b70 ae03fc        	ldw	x,#1020
4815  0b73 89            	pushw	x
4816  0b74 5f            	clrw	x
4817  0b75 89            	pushw	x
4818  0b76 ae000b        	ldw	x,#_pwm_u
4819  0b79 cd0000        	call	_gran
4821  0b7c 5b04          	addw	sp,#4
4822                     ; 812 		    	pwm_i=0x3ff;
4824  0b7e ae03ff        	ldw	x,#1023
4825  0b81 bf0d          	ldw	_pwm_i,x
4826                     ; 813 			bBL=0;
4828  0b83 72110000      	bres	_bBL
4829                     ; 814 			bBL_IPS=0;
4831  0b87 72110001      	bres	_bBL_IPS
4833  0b8b 2062          	jra	L3142
4834  0b8d               L7342:
4835                     ; 816 		else if(flags&0b00011010)
4837  0b8d b60a          	ld	a,_flags
4838  0b8f a51a          	bcp	a,#26
4839  0b91 275c          	jreq	L3142
4840                     ; 818 			pwm_u=0;
4842  0b93 5f            	clrw	x
4843  0b94 bf0b          	ldw	_pwm_u,x
4844                     ; 819 			pwm_i=0;
4846  0b96 5f            	clrw	x
4847  0b97 bf0d          	ldw	_pwm_i,x
4848                     ; 820 			bBL=1;
4850  0b99 72100000      	bset	_bBL
4851                     ; 821 			bBL_IPS=1;
4853  0b9d 72100001      	bset	_bBL_IPS
4854  0ba1 204c          	jra	L3142
4855  0ba3               L1342:
4856                     ; 830 else	if(link==ON)				//если есть связь
4858  0ba3 b65f          	ld	a,_link
4859  0ba5 a155          	cp	a,#85
4860  0ba7 2646          	jrne	L3142
4861                     ; 832 	if((flags&0b00100000)==0)	//если нет блокировки извне
4863  0ba9 b60a          	ld	a,_flags
4864  0bab a520          	bcp	a,#32
4865  0bad 2630          	jrne	L1542
4866                     ; 834 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
4868  0baf b60a          	ld	a,_flags
4869  0bb1 a51a          	bcp	a,#26
4870  0bb3 2706          	jreq	L5542
4872  0bb5 b60a          	ld	a,_flags
4873  0bb7 a540          	bcp	a,#64
4874  0bb9 2712          	jreq	L3542
4875  0bbb               L5542:
4876                     ; 836 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
4878  0bbb be5b          	ldw	x,__x_
4879  0bbd 72bb0055      	addw	x,_vol_u_temp
4880  0bc1 bf0b          	ldw	_pwm_u,x
4881                     ; 837 		    	pwm_i=vol_i_temp;
4883  0bc3 be53          	ldw	x,_vol_i_temp
4884  0bc5 bf0d          	ldw	_pwm_i,x
4885                     ; 838 			bBL=0;
4887  0bc7 72110000      	bres	_bBL
4889  0bcb 2022          	jra	L3142
4890  0bcd               L3542:
4891                     ; 840 		else if(flags&0b00011010)					//если есть аварии
4893  0bcd b60a          	ld	a,_flags
4894  0bcf a51a          	bcp	a,#26
4895  0bd1 271c          	jreq	L3142
4896                     ; 842 			pwm_u=0;								//то полный стоп
4898  0bd3 5f            	clrw	x
4899  0bd4 bf0b          	ldw	_pwm_u,x
4900                     ; 843 			pwm_i=0;
4902  0bd6 5f            	clrw	x
4903  0bd7 bf0d          	ldw	_pwm_i,x
4904                     ; 844 			bBL=1;
4906  0bd9 72100000      	bset	_bBL
4907  0bdd 2010          	jra	L3142
4908  0bdf               L1542:
4909                     ; 847 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4911  0bdf b60a          	ld	a,_flags
4912  0be1 a520          	bcp	a,#32
4913  0be3 270a          	jreq	L3142
4914                     ; 849 		pwm_u=0;
4916  0be5 5f            	clrw	x
4917  0be6 bf0b          	ldw	_pwm_u,x
4918                     ; 850 	    	pwm_i=0;
4920  0be8 5f            	clrw	x
4921  0be9 bf0d          	ldw	_pwm_i,x
4922                     ; 851 		bBL=1;
4924  0beb 72100000      	bset	_bBL
4925  0bef               L3142:
4926                     ; 857 }
4929  0bef 81            	ret
4971                     	switch	.const
4972  0008               L66:
4973  0008 00000258      	dc.l	600
4974  000c               L07:
4975  000c 00000708      	dc.l	1800
4976  0010               L27:
4977  0010 000003e8      	dc.l	1000
4978                     ; 860 void matemat(void)
4978                     ; 861 {
4979                     	switch	.text
4980  0bf0               _matemat:
4982  0bf0 5204          	subw	sp,#4
4983       00000004      OFST:	set	4
4986                     ; 882 temp_SL=adc_buff_[4];
4988  0bf2 ce000d        	ldw	x,_adc_buff_+8
4989  0bf5 cd0000        	call	c_itolx
4991  0bf8 96            	ldw	x,sp
4992  0bf9 1c0001        	addw	x,#OFST-3
4993  0bfc cd0000        	call	c_rtol
4995                     ; 883 temp_SL-=ee_K[0][0];
4997  0bff ce0018        	ldw	x,_ee_K
4998  0c02 cd0000        	call	c_itolx
5000  0c05 96            	ldw	x,sp
5001  0c06 1c0001        	addw	x,#OFST-3
5002  0c09 cd0000        	call	c_lgsub
5004                     ; 884 if(temp_SL<0) temp_SL=0;
5006  0c0c 9c            	rvf
5007  0c0d 0d01          	tnz	(OFST-3,sp)
5008  0c0f 2e0a          	jrsge	L5052
5011  0c11 ae0000        	ldw	x,#0
5012  0c14 1f03          	ldw	(OFST-1,sp),x
5013  0c16 ae0000        	ldw	x,#0
5014  0c19 1f01          	ldw	(OFST-3,sp),x
5015  0c1b               L5052:
5016                     ; 885 temp_SL*=ee_K[0][1];
5018  0c1b ce001a        	ldw	x,_ee_K+2
5019  0c1e cd0000        	call	c_itolx
5021  0c21 96            	ldw	x,sp
5022  0c22 1c0001        	addw	x,#OFST-3
5023  0c25 cd0000        	call	c_lgmul
5025                     ; 886 temp_SL/=600;
5027  0c28 96            	ldw	x,sp
5028  0c29 1c0001        	addw	x,#OFST-3
5029  0c2c cd0000        	call	c_ltor
5031  0c2f ae0008        	ldw	x,#L66
5032  0c32 cd0000        	call	c_ldiv
5034  0c35 96            	ldw	x,sp
5035  0c36 1c0001        	addw	x,#OFST-3
5036  0c39 cd0000        	call	c_rtol
5038                     ; 887 I=(signed short)temp_SL;
5040  0c3c 1e03          	ldw	x,(OFST-1,sp)
5041  0c3e bf6b          	ldw	_I,x
5042                     ; 892 temp_SL=(signed long)adc_buff_[1];
5044  0c40 ce0007        	ldw	x,_adc_buff_+2
5045  0c43 cd0000        	call	c_itolx
5047  0c46 96            	ldw	x,sp
5048  0c47 1c0001        	addw	x,#OFST-3
5049  0c4a cd0000        	call	c_rtol
5051                     ; 894 if(temp_SL<0) temp_SL=0;
5053  0c4d 9c            	rvf
5054  0c4e 0d01          	tnz	(OFST-3,sp)
5055  0c50 2e0a          	jrsge	L7052
5058  0c52 ae0000        	ldw	x,#0
5059  0c55 1f03          	ldw	(OFST-1,sp),x
5060  0c57 ae0000        	ldw	x,#0
5061  0c5a 1f01          	ldw	(OFST-3,sp),x
5062  0c5c               L7052:
5063                     ; 895 temp_SL*=(signed long)ee_K[2][1];
5065  0c5c ce0022        	ldw	x,_ee_K+10
5066  0c5f cd0000        	call	c_itolx
5068  0c62 96            	ldw	x,sp
5069  0c63 1c0001        	addw	x,#OFST-3
5070  0c66 cd0000        	call	c_lgmul
5072                     ; 896 temp_SL/=1800L;
5074  0c69 96            	ldw	x,sp
5075  0c6a 1c0001        	addw	x,#OFST-3
5076  0c6d cd0000        	call	c_ltor
5078  0c70 ae000c        	ldw	x,#L07
5079  0c73 cd0000        	call	c_ldiv
5081  0c76 96            	ldw	x,sp
5082  0c77 1c0001        	addw	x,#OFST-3
5083  0c7a cd0000        	call	c_rtol
5085                     ; 897 Ui=(unsigned short)temp_SL;
5087  0c7d 1e03          	ldw	x,(OFST-1,sp)
5088  0c7f bf67          	ldw	_Ui,x
5089                     ; 904 temp_SL=adc_buff_[3];
5091  0c81 ce000b        	ldw	x,_adc_buff_+6
5092  0c84 cd0000        	call	c_itolx
5094  0c87 96            	ldw	x,sp
5095  0c88 1c0001        	addw	x,#OFST-3
5096  0c8b cd0000        	call	c_rtol
5098                     ; 906 if(temp_SL<0) temp_SL=0;
5100  0c8e 9c            	rvf
5101  0c8f 0d01          	tnz	(OFST-3,sp)
5102  0c91 2e0a          	jrsge	L1152
5105  0c93 ae0000        	ldw	x,#0
5106  0c96 1f03          	ldw	(OFST-1,sp),x
5107  0c98 ae0000        	ldw	x,#0
5108  0c9b 1f01          	ldw	(OFST-3,sp),x
5109  0c9d               L1152:
5110                     ; 907 temp_SL*=ee_K[1][1];
5112  0c9d ce001e        	ldw	x,_ee_K+6
5113  0ca0 cd0000        	call	c_itolx
5115  0ca3 96            	ldw	x,sp
5116  0ca4 1c0001        	addw	x,#OFST-3
5117  0ca7 cd0000        	call	c_lgmul
5119                     ; 908 temp_SL/=1800;
5121  0caa 96            	ldw	x,sp
5122  0cab 1c0001        	addw	x,#OFST-3
5123  0cae cd0000        	call	c_ltor
5125  0cb1 ae000c        	ldw	x,#L07
5126  0cb4 cd0000        	call	c_ldiv
5128  0cb7 96            	ldw	x,sp
5129  0cb8 1c0001        	addw	x,#OFST-3
5130  0cbb cd0000        	call	c_rtol
5132                     ; 909 Un=(unsigned short)temp_SL;
5134  0cbe 1e03          	ldw	x,(OFST-1,sp)
5135  0cc0 bf69          	ldw	_Un,x
5136                     ; 912 temp_SL=adc_buff_[2];
5138  0cc2 ce0009        	ldw	x,_adc_buff_+4
5139  0cc5 cd0000        	call	c_itolx
5141  0cc8 96            	ldw	x,sp
5142  0cc9 1c0001        	addw	x,#OFST-3
5143  0ccc cd0000        	call	c_rtol
5145                     ; 913 temp_SL*=ee_K[3][1];
5147  0ccf ce0026        	ldw	x,_ee_K+14
5148  0cd2 cd0000        	call	c_itolx
5150  0cd5 96            	ldw	x,sp
5151  0cd6 1c0001        	addw	x,#OFST-3
5152  0cd9 cd0000        	call	c_lgmul
5154                     ; 914 temp_SL/=1000;
5156  0cdc 96            	ldw	x,sp
5157  0cdd 1c0001        	addw	x,#OFST-3
5158  0ce0 cd0000        	call	c_ltor
5160  0ce3 ae0010        	ldw	x,#L27
5161  0ce6 cd0000        	call	c_ldiv
5163  0ce9 96            	ldw	x,sp
5164  0cea 1c0001        	addw	x,#OFST-3
5165  0ced cd0000        	call	c_rtol
5167                     ; 915 T=(signed short)(temp_SL-273L);
5169  0cf0 7b04          	ld	a,(OFST+0,sp)
5170  0cf2 5f            	clrw	x
5171  0cf3 4d            	tnz	a
5172  0cf4 2a01          	jrpl	L47
5173  0cf6 53            	cplw	x
5174  0cf7               L47:
5175  0cf7 97            	ld	xl,a
5176  0cf8 1d0111        	subw	x,#273
5177  0cfb 01            	rrwa	x,a
5178  0cfc b764          	ld	_T,a
5179  0cfe 02            	rlwa	x,a
5180                     ; 916 if(T<-30)T=-30;
5182  0cff 9c            	rvf
5183  0d00 b664          	ld	a,_T
5184  0d02 a1e2          	cp	a,#226
5185  0d04 2e04          	jrsge	L3152
5188  0d06 35e20064      	mov	_T,#226
5189  0d0a               L3152:
5190                     ; 917 if(T>120)T=120;
5192  0d0a 9c            	rvf
5193  0d0b b664          	ld	a,_T
5194  0d0d a179          	cp	a,#121
5195  0d0f 2f04          	jrslt	L5152
5198  0d11 35780064      	mov	_T,#120
5199  0d15               L5152:
5200                     ; 919 Udb=flags;
5202  0d15 b60a          	ld	a,_flags
5203  0d17 5f            	clrw	x
5204  0d18 97            	ld	xl,a
5205  0d19 bf65          	ldw	_Udb,x
5206                     ; 925 }
5209  0d1b 5b04          	addw	sp,#4
5210  0d1d 81            	ret
5241                     ; 928 void temper_drv(void)		//1 Hz
5241                     ; 929 {
5242                     	switch	.text
5243  0d1e               _temper_drv:
5247                     ; 931 if(T>ee_tsign) tsign_cnt++;
5249  0d1e 9c            	rvf
5250  0d1f 5f            	clrw	x
5251  0d20 b664          	ld	a,_T
5252  0d22 2a01          	jrpl	L001
5253  0d24 53            	cplw	x
5254  0d25               L001:
5255  0d25 97            	ld	xl,a
5256  0d26 c3000c        	cpw	x,_ee_tsign
5257  0d29 2d09          	jrsle	L7252
5260  0d2b be4a          	ldw	x,_tsign_cnt
5261  0d2d 1c0001        	addw	x,#1
5262  0d30 bf4a          	ldw	_tsign_cnt,x
5264  0d32 201d          	jra	L1352
5265  0d34               L7252:
5266                     ; 932 else if (T<(ee_tsign-1)) tsign_cnt--;
5268  0d34 9c            	rvf
5269  0d35 ce000c        	ldw	x,_ee_tsign
5270  0d38 5a            	decw	x
5271  0d39 905f          	clrw	y
5272  0d3b b664          	ld	a,_T
5273  0d3d 2a02          	jrpl	L201
5274  0d3f 9053          	cplw	y
5275  0d41               L201:
5276  0d41 9097          	ld	yl,a
5277  0d43 90bf00        	ldw	c_y,y
5278  0d46 b300          	cpw	x,c_y
5279  0d48 2d07          	jrsle	L1352
5282  0d4a be4a          	ldw	x,_tsign_cnt
5283  0d4c 1d0001        	subw	x,#1
5284  0d4f bf4a          	ldw	_tsign_cnt,x
5285  0d51               L1352:
5286                     ; 934 gran(&tsign_cnt,0,60);
5288  0d51 ae003c        	ldw	x,#60
5289  0d54 89            	pushw	x
5290  0d55 5f            	clrw	x
5291  0d56 89            	pushw	x
5292  0d57 ae004a        	ldw	x,#_tsign_cnt
5293  0d5a cd0000        	call	_gran
5295  0d5d 5b04          	addw	sp,#4
5296                     ; 936 if(tsign_cnt>=55)
5298  0d5f 9c            	rvf
5299  0d60 be4a          	ldw	x,_tsign_cnt
5300  0d62 a30037        	cpw	x,#55
5301  0d65 2f16          	jrslt	L5352
5302                     ; 938 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5304  0d67 3d47          	tnz	_jp_mode
5305  0d69 2606          	jrne	L3452
5307  0d6b b60a          	ld	a,_flags
5308  0d6d a540          	bcp	a,#64
5309  0d6f 2706          	jreq	L1452
5310  0d71               L3452:
5312  0d71 b647          	ld	a,_jp_mode
5313  0d73 a103          	cp	a,#3
5314  0d75 2612          	jrne	L5452
5315  0d77               L1452:
5318  0d77 7214000a      	bset	_flags,#2
5319  0d7b 200c          	jra	L5452
5320  0d7d               L5352:
5321                     ; 940 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5323  0d7d 9c            	rvf
5324  0d7e be4a          	ldw	x,_tsign_cnt
5325  0d80 a30006        	cpw	x,#6
5326  0d83 2e04          	jrsge	L5452
5329  0d85 7215000a      	bres	_flags,#2
5330  0d89               L5452:
5331                     ; 945 if(T>ee_tmax) tmax_cnt++;
5333  0d89 9c            	rvf
5334  0d8a 5f            	clrw	x
5335  0d8b b664          	ld	a,_T
5336  0d8d 2a01          	jrpl	L401
5337  0d8f 53            	cplw	x
5338  0d90               L401:
5339  0d90 97            	ld	xl,a
5340  0d91 c3000e        	cpw	x,_ee_tmax
5341  0d94 2d09          	jrsle	L1552
5344  0d96 be48          	ldw	x,_tmax_cnt
5345  0d98 1c0001        	addw	x,#1
5346  0d9b bf48          	ldw	_tmax_cnt,x
5348  0d9d 201d          	jra	L3552
5349  0d9f               L1552:
5350                     ; 946 else if (T<(ee_tmax-1)) tmax_cnt--;
5352  0d9f 9c            	rvf
5353  0da0 ce000e        	ldw	x,_ee_tmax
5354  0da3 5a            	decw	x
5355  0da4 905f          	clrw	y
5356  0da6 b664          	ld	a,_T
5357  0da8 2a02          	jrpl	L601
5358  0daa 9053          	cplw	y
5359  0dac               L601:
5360  0dac 9097          	ld	yl,a
5361  0dae 90bf00        	ldw	c_y,y
5362  0db1 b300          	cpw	x,c_y
5363  0db3 2d07          	jrsle	L3552
5366  0db5 be48          	ldw	x,_tmax_cnt
5367  0db7 1d0001        	subw	x,#1
5368  0dba bf48          	ldw	_tmax_cnt,x
5369  0dbc               L3552:
5370                     ; 948 gran(&tmax_cnt,0,60);
5372  0dbc ae003c        	ldw	x,#60
5373  0dbf 89            	pushw	x
5374  0dc0 5f            	clrw	x
5375  0dc1 89            	pushw	x
5376  0dc2 ae0048        	ldw	x,#_tmax_cnt
5377  0dc5 cd0000        	call	_gran
5379  0dc8 5b04          	addw	sp,#4
5380                     ; 950 if(tmax_cnt>=55)
5382  0dca 9c            	rvf
5383  0dcb be48          	ldw	x,_tmax_cnt
5384  0dcd a30037        	cpw	x,#55
5385  0dd0 2f16          	jrslt	L7552
5386                     ; 952 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5388  0dd2 3d47          	tnz	_jp_mode
5389  0dd4 2606          	jrne	L5652
5391  0dd6 b60a          	ld	a,_flags
5392  0dd8 a540          	bcp	a,#64
5393  0dda 2706          	jreq	L3652
5394  0ddc               L5652:
5396  0ddc b647          	ld	a,_jp_mode
5397  0dde a103          	cp	a,#3
5398  0de0 2612          	jrne	L7652
5399  0de2               L3652:
5402  0de2 7212000a      	bset	_flags,#1
5403  0de6 200c          	jra	L7652
5404  0de8               L7552:
5405                     ; 954 else if (tmax_cnt<=5) flags&=0b11111101;
5407  0de8 9c            	rvf
5408  0de9 be48          	ldw	x,_tmax_cnt
5409  0deb a30006        	cpw	x,#6
5410  0dee 2e04          	jrsge	L7652
5413  0df0 7213000a      	bres	_flags,#1
5414  0df4               L7652:
5415                     ; 957 } 
5418  0df4 81            	ret
5450                     ; 960 void u_drv(void)		//1Hz
5450                     ; 961 { 
5451                     	switch	.text
5452  0df5               _u_drv:
5456                     ; 962 if(jp_mode!=jp3)
5458  0df5 b647          	ld	a,_jp_mode
5459  0df7 a103          	cp	a,#3
5460  0df9 2770          	jreq	L3062
5461                     ; 964 	if(Ui>ee_Umax)umax_cnt++;
5463  0dfb 9c            	rvf
5464  0dfc be67          	ldw	x,_Ui
5465  0dfe c30012        	cpw	x,_ee_Umax
5466  0e01 2d09          	jrsle	L5062
5469  0e03 be62          	ldw	x,_umax_cnt
5470  0e05 1c0001        	addw	x,#1
5471  0e08 bf62          	ldw	_umax_cnt,x
5473  0e0a 2003          	jra	L7062
5474  0e0c               L5062:
5475                     ; 965 	else umax_cnt=0;
5477  0e0c 5f            	clrw	x
5478  0e0d bf62          	ldw	_umax_cnt,x
5479  0e0f               L7062:
5480                     ; 966 	gran(&umax_cnt,0,10);
5482  0e0f ae000a        	ldw	x,#10
5483  0e12 89            	pushw	x
5484  0e13 5f            	clrw	x
5485  0e14 89            	pushw	x
5486  0e15 ae0062        	ldw	x,#_umax_cnt
5487  0e18 cd0000        	call	_gran
5489  0e1b 5b04          	addw	sp,#4
5490                     ; 967 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5492  0e1d 9c            	rvf
5493  0e1e be62          	ldw	x,_umax_cnt
5494  0e20 a3000a        	cpw	x,#10
5495  0e23 2f04          	jrslt	L1162
5498  0e25 7216000a      	bset	_flags,#3
5499  0e29               L1162:
5500                     ; 970 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5502  0e29 9c            	rvf
5503  0e2a be67          	ldw	x,_Ui
5504  0e2c b369          	cpw	x,_Un
5505  0e2e 2e1c          	jrsge	L3162
5507  0e30 9c            	rvf
5508  0e31 be69          	ldw	x,_Un
5509  0e33 72b00067      	subw	x,_Ui
5510  0e37 c30010        	cpw	x,_ee_dU
5511  0e3a 2d10          	jrsle	L3162
5513  0e3c c65005        	ld	a,20485
5514  0e3f a504          	bcp	a,#4
5515  0e41 2609          	jrne	L3162
5518  0e43 be60          	ldw	x,_umin_cnt
5519  0e45 1c0001        	addw	x,#1
5520  0e48 bf60          	ldw	_umin_cnt,x
5522  0e4a 2003          	jra	L5162
5523  0e4c               L3162:
5524                     ; 971 	else umin_cnt=0;
5526  0e4c 5f            	clrw	x
5527  0e4d bf60          	ldw	_umin_cnt,x
5528  0e4f               L5162:
5529                     ; 972 	gran(&umin_cnt,0,10);	
5531  0e4f ae000a        	ldw	x,#10
5532  0e52 89            	pushw	x
5533  0e53 5f            	clrw	x
5534  0e54 89            	pushw	x
5535  0e55 ae0060        	ldw	x,#_umin_cnt
5536  0e58 cd0000        	call	_gran
5538  0e5b 5b04          	addw	sp,#4
5539                     ; 973 	if(umin_cnt>=10)flags|=0b00010000;	  
5541  0e5d 9c            	rvf
5542  0e5e be60          	ldw	x,_umin_cnt
5543  0e60 a3000a        	cpw	x,#10
5544  0e63 2f6f          	jrslt	L1262
5547  0e65 7218000a      	bset	_flags,#4
5548  0e69 2069          	jra	L1262
5549  0e6b               L3062:
5550                     ; 975 else if(jp_mode==jp3)
5552  0e6b b647          	ld	a,_jp_mode
5553  0e6d a103          	cp	a,#3
5554  0e6f 2663          	jrne	L1262
5555                     ; 977 	if(Ui>700)umax_cnt++;
5557  0e71 9c            	rvf
5558  0e72 be67          	ldw	x,_Ui
5559  0e74 a302bd        	cpw	x,#701
5560  0e77 2f09          	jrslt	L5262
5563  0e79 be62          	ldw	x,_umax_cnt
5564  0e7b 1c0001        	addw	x,#1
5565  0e7e bf62          	ldw	_umax_cnt,x
5567  0e80 2003          	jra	L7262
5568  0e82               L5262:
5569                     ; 978 	else umax_cnt=0;
5571  0e82 5f            	clrw	x
5572  0e83 bf62          	ldw	_umax_cnt,x
5573  0e85               L7262:
5574                     ; 979 	gran(&umax_cnt,0,10);
5576  0e85 ae000a        	ldw	x,#10
5577  0e88 89            	pushw	x
5578  0e89 5f            	clrw	x
5579  0e8a 89            	pushw	x
5580  0e8b ae0062        	ldw	x,#_umax_cnt
5581  0e8e cd0000        	call	_gran
5583  0e91 5b04          	addw	sp,#4
5584                     ; 980 	if(umax_cnt>=10)flags|=0b00001000;
5586  0e93 9c            	rvf
5587  0e94 be62          	ldw	x,_umax_cnt
5588  0e96 a3000a        	cpw	x,#10
5589  0e99 2f04          	jrslt	L1362
5592  0e9b 7216000a      	bset	_flags,#3
5593  0e9f               L1362:
5594                     ; 983 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5596  0e9f 9c            	rvf
5597  0ea0 be67          	ldw	x,_Ui
5598  0ea2 a300c8        	cpw	x,#200
5599  0ea5 2e10          	jrsge	L3362
5601  0ea7 c65005        	ld	a,20485
5602  0eaa a504          	bcp	a,#4
5603  0eac 2609          	jrne	L3362
5606  0eae be60          	ldw	x,_umin_cnt
5607  0eb0 1c0001        	addw	x,#1
5608  0eb3 bf60          	ldw	_umin_cnt,x
5610  0eb5 2003          	jra	L5362
5611  0eb7               L3362:
5612                     ; 984 	else umin_cnt=0;
5614  0eb7 5f            	clrw	x
5615  0eb8 bf60          	ldw	_umin_cnt,x
5616  0eba               L5362:
5617                     ; 985 	gran(&umin_cnt,0,10);	
5619  0eba ae000a        	ldw	x,#10
5620  0ebd 89            	pushw	x
5621  0ebe 5f            	clrw	x
5622  0ebf 89            	pushw	x
5623  0ec0 ae0060        	ldw	x,#_umin_cnt
5624  0ec3 cd0000        	call	_gran
5626  0ec6 5b04          	addw	sp,#4
5627                     ; 986 	if(umin_cnt>=10)flags|=0b00010000;	  
5629  0ec8 9c            	rvf
5630  0ec9 be60          	ldw	x,_umin_cnt
5631  0ecb a3000a        	cpw	x,#10
5632  0ece 2f04          	jrslt	L1262
5635  0ed0 7218000a      	bset	_flags,#4
5636  0ed4               L1262:
5637                     ; 988 }
5640  0ed4 81            	ret
5667                     ; 991 void x_drv(void)
5667                     ; 992 {
5668                     	switch	.text
5669  0ed5               _x_drv:
5673                     ; 993 if(_x__==_x_)
5675  0ed5 be59          	ldw	x,__x__
5676  0ed7 b35b          	cpw	x,__x_
5677  0ed9 262a          	jrne	L1562
5678                     ; 995 	if(_x_cnt<60)
5680  0edb 9c            	rvf
5681  0edc be57          	ldw	x,__x_cnt
5682  0ede a3003c        	cpw	x,#60
5683  0ee1 2e25          	jrsge	L1662
5684                     ; 997 		_x_cnt++;
5686  0ee3 be57          	ldw	x,__x_cnt
5687  0ee5 1c0001        	addw	x,#1
5688  0ee8 bf57          	ldw	__x_cnt,x
5689                     ; 998 		if(_x_cnt>=60)
5691  0eea 9c            	rvf
5692  0eeb be57          	ldw	x,__x_cnt
5693  0eed a3003c        	cpw	x,#60
5694  0ef0 2f16          	jrslt	L1662
5695                     ; 1000 			if(_x_ee_!=_x_)_x_ee_=_x_;
5697  0ef2 ce0016        	ldw	x,__x_ee_
5698  0ef5 b35b          	cpw	x,__x_
5699  0ef7 270f          	jreq	L1662
5702  0ef9 be5b          	ldw	x,__x_
5703  0efb 89            	pushw	x
5704  0efc ae0016        	ldw	x,#__x_ee_
5705  0eff cd0000        	call	c_eewrw
5707  0f02 85            	popw	x
5708  0f03 2003          	jra	L1662
5709  0f05               L1562:
5710                     ; 1005 else _x_cnt=0;
5712  0f05 5f            	clrw	x
5713  0f06 bf57          	ldw	__x_cnt,x
5714  0f08               L1662:
5715                     ; 1007 if(_x_cnt>60) _x_cnt=0;	
5717  0f08 9c            	rvf
5718  0f09 be57          	ldw	x,__x_cnt
5719  0f0b a3003d        	cpw	x,#61
5720  0f0e 2f03          	jrslt	L3662
5723  0f10 5f            	clrw	x
5724  0f11 bf57          	ldw	__x_cnt,x
5725  0f13               L3662:
5726                     ; 1009 _x__=_x_;
5728  0f13 be5b          	ldw	x,__x_
5729  0f15 bf59          	ldw	__x__,x
5730                     ; 1010 }
5733  0f17 81            	ret
5759                     ; 1013 void apv_start(void)
5759                     ; 1014 {
5760                     	switch	.text
5761  0f18               _apv_start:
5765                     ; 1015 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5767  0f18 3d42          	tnz	_apv_cnt
5768  0f1a 2624          	jrne	L5762
5770  0f1c 3d43          	tnz	_apv_cnt+1
5771  0f1e 2620          	jrne	L5762
5773  0f20 3d44          	tnz	_apv_cnt+2
5774  0f22 261c          	jrne	L5762
5776                     	btst	_bAPV
5777  0f29 2515          	jrult	L5762
5778                     ; 1017 	apv_cnt[0]=60;
5780  0f2b 353c0042      	mov	_apv_cnt,#60
5781                     ; 1018 	apv_cnt[1]=60;
5783  0f2f 353c0043      	mov	_apv_cnt+1,#60
5784                     ; 1019 	apv_cnt[2]=60;
5786  0f33 353c0044      	mov	_apv_cnt+2,#60
5787                     ; 1020 	apv_cnt_=3600;
5789  0f37 ae0e10        	ldw	x,#3600
5790  0f3a bf40          	ldw	_apv_cnt_,x
5791                     ; 1021 	bAPV=1;	
5793  0f3c 72100003      	bset	_bAPV
5794  0f40               L5762:
5795                     ; 1023 }
5798  0f40 81            	ret
5824                     ; 1026 void apv_stop(void)
5824                     ; 1027 {
5825                     	switch	.text
5826  0f41               _apv_stop:
5830                     ; 1028 apv_cnt[0]=0;
5832  0f41 3f42          	clr	_apv_cnt
5833                     ; 1029 apv_cnt[1]=0;
5835  0f43 3f43          	clr	_apv_cnt+1
5836                     ; 1030 apv_cnt[2]=0;
5838  0f45 3f44          	clr	_apv_cnt+2
5839                     ; 1031 apv_cnt_=0;	
5841  0f47 5f            	clrw	x
5842  0f48 bf40          	ldw	_apv_cnt_,x
5843                     ; 1032 bAPV=0;
5845  0f4a 72110003      	bres	_bAPV
5846                     ; 1033 }
5849  0f4e 81            	ret
5884                     ; 1037 void apv_hndl(void)
5884                     ; 1038 {
5885                     	switch	.text
5886  0f4f               _apv_hndl:
5890                     ; 1039 if(apv_cnt[0])
5892  0f4f 3d42          	tnz	_apv_cnt
5893  0f51 271e          	jreq	L7172
5894                     ; 1041 	apv_cnt[0]--;
5896  0f53 3a42          	dec	_apv_cnt
5897                     ; 1042 	if(apv_cnt[0]==0)
5899  0f55 3d42          	tnz	_apv_cnt
5900  0f57 265a          	jrne	L3272
5901                     ; 1044 		flags&=0b11100001;
5903  0f59 b60a          	ld	a,_flags
5904  0f5b a4e1          	and	a,#225
5905  0f5d b70a          	ld	_flags,a
5906                     ; 1045 		tsign_cnt=0;
5908  0f5f 5f            	clrw	x
5909  0f60 bf4a          	ldw	_tsign_cnt,x
5910                     ; 1046 		tmax_cnt=0;
5912  0f62 5f            	clrw	x
5913  0f63 bf48          	ldw	_tmax_cnt,x
5914                     ; 1047 		umax_cnt=0;
5916  0f65 5f            	clrw	x
5917  0f66 bf62          	ldw	_umax_cnt,x
5918                     ; 1048 		umin_cnt=0;
5920  0f68 5f            	clrw	x
5921  0f69 bf60          	ldw	_umin_cnt,x
5922                     ; 1050 		led_drv_cnt=30;
5924  0f6b 351e0019      	mov	_led_drv_cnt,#30
5925  0f6f 2042          	jra	L3272
5926  0f71               L7172:
5927                     ; 1053 else if(apv_cnt[1])
5929  0f71 3d43          	tnz	_apv_cnt+1
5930  0f73 271e          	jreq	L5272
5931                     ; 1055 	apv_cnt[1]--;
5933  0f75 3a43          	dec	_apv_cnt+1
5934                     ; 1056 	if(apv_cnt[1]==0)
5936  0f77 3d43          	tnz	_apv_cnt+1
5937  0f79 2638          	jrne	L3272
5938                     ; 1058 		flags&=0b11100001;
5940  0f7b b60a          	ld	a,_flags
5941  0f7d a4e1          	and	a,#225
5942  0f7f b70a          	ld	_flags,a
5943                     ; 1059 		tsign_cnt=0;
5945  0f81 5f            	clrw	x
5946  0f82 bf4a          	ldw	_tsign_cnt,x
5947                     ; 1060 		tmax_cnt=0;
5949  0f84 5f            	clrw	x
5950  0f85 bf48          	ldw	_tmax_cnt,x
5951                     ; 1061 		umax_cnt=0;
5953  0f87 5f            	clrw	x
5954  0f88 bf62          	ldw	_umax_cnt,x
5955                     ; 1062 		umin_cnt=0;
5957  0f8a 5f            	clrw	x
5958  0f8b bf60          	ldw	_umin_cnt,x
5959                     ; 1064 		led_drv_cnt=30;
5961  0f8d 351e0019      	mov	_led_drv_cnt,#30
5962  0f91 2020          	jra	L3272
5963  0f93               L5272:
5964                     ; 1067 else if(apv_cnt[2])
5966  0f93 3d44          	tnz	_apv_cnt+2
5967  0f95 271c          	jreq	L3272
5968                     ; 1069 	apv_cnt[2]--;
5970  0f97 3a44          	dec	_apv_cnt+2
5971                     ; 1070 	if(apv_cnt[2]==0)
5973  0f99 3d44          	tnz	_apv_cnt+2
5974  0f9b 2616          	jrne	L3272
5975                     ; 1072 		flags&=0b11100001;
5977  0f9d b60a          	ld	a,_flags
5978  0f9f a4e1          	and	a,#225
5979  0fa1 b70a          	ld	_flags,a
5980                     ; 1073 		tsign_cnt=0;
5982  0fa3 5f            	clrw	x
5983  0fa4 bf4a          	ldw	_tsign_cnt,x
5984                     ; 1074 		tmax_cnt=0;
5986  0fa6 5f            	clrw	x
5987  0fa7 bf48          	ldw	_tmax_cnt,x
5988                     ; 1075 		umax_cnt=0;
5990  0fa9 5f            	clrw	x
5991  0faa bf62          	ldw	_umax_cnt,x
5992                     ; 1076 		umin_cnt=0;          
5994  0fac 5f            	clrw	x
5995  0fad bf60          	ldw	_umin_cnt,x
5996                     ; 1078 		led_drv_cnt=30;
5998  0faf 351e0019      	mov	_led_drv_cnt,#30
5999  0fb3               L3272:
6000                     ; 1082 if(apv_cnt_)
6002  0fb3 be40          	ldw	x,_apv_cnt_
6003  0fb5 2712          	jreq	L7372
6004                     ; 1084 	apv_cnt_--;
6006  0fb7 be40          	ldw	x,_apv_cnt_
6007  0fb9 1d0001        	subw	x,#1
6008  0fbc bf40          	ldw	_apv_cnt_,x
6009                     ; 1085 	if(apv_cnt_==0) 
6011  0fbe be40          	ldw	x,_apv_cnt_
6012  0fc0 2607          	jrne	L7372
6013                     ; 1087 		bAPV=0;
6015  0fc2 72110003      	bres	_bAPV
6016                     ; 1088 		apv_start();
6018  0fc6 cd0f18        	call	_apv_start
6020  0fc9               L7372:
6021                     ; 1092 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6023  0fc9 be60          	ldw	x,_umin_cnt
6024  0fcb 261e          	jrne	L3472
6026  0fcd be62          	ldw	x,_umax_cnt
6027  0fcf 261a          	jrne	L3472
6029  0fd1 c65005        	ld	a,20485
6030  0fd4 a504          	bcp	a,#4
6031  0fd6 2613          	jrne	L3472
6032                     ; 1094 	if(cnt_apv_off<20)
6034  0fd8 b63f          	ld	a,_cnt_apv_off
6035  0fda a114          	cp	a,#20
6036  0fdc 240f          	jruge	L1572
6037                     ; 1096 		cnt_apv_off++;
6039  0fde 3c3f          	inc	_cnt_apv_off
6040                     ; 1097 		if(cnt_apv_off>=20)
6042  0fe0 b63f          	ld	a,_cnt_apv_off
6043  0fe2 a114          	cp	a,#20
6044  0fe4 2507          	jrult	L1572
6045                     ; 1099 			apv_stop();
6047  0fe6 cd0f41        	call	_apv_stop
6049  0fe9 2002          	jra	L1572
6050  0feb               L3472:
6051                     ; 1103 else cnt_apv_off=0;	
6053  0feb 3f3f          	clr	_cnt_apv_off
6054  0fed               L1572:
6055                     ; 1105 }
6058  0fed 81            	ret
6061                     	switch	.ubsct
6062  0000               L3572_flags_old:
6063  0000 00            	ds.b	1
6099                     ; 1108 void flags_drv(void)
6099                     ; 1109 {
6100                     	switch	.text
6101  0fee               _flags_drv:
6105                     ; 1111 if(jp_mode!=jp3) 
6107  0fee b647          	ld	a,_jp_mode
6108  0ff0 a103          	cp	a,#3
6109  0ff2 2723          	jreq	L3772
6110                     ; 1113 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6112  0ff4 b60a          	ld	a,_flags
6113  0ff6 a508          	bcp	a,#8
6114  0ff8 2706          	jreq	L1003
6116  0ffa b600          	ld	a,L3572_flags_old
6117  0ffc a508          	bcp	a,#8
6118  0ffe 270c          	jreq	L7772
6119  1000               L1003:
6121  1000 b60a          	ld	a,_flags
6122  1002 a510          	bcp	a,#16
6123  1004 2726          	jreq	L5003
6125  1006 b600          	ld	a,L3572_flags_old
6126  1008 a510          	bcp	a,#16
6127  100a 2620          	jrne	L5003
6128  100c               L7772:
6129                     ; 1115     		if(link==OFF)apv_start();
6131  100c b65f          	ld	a,_link
6132  100e a1aa          	cp	a,#170
6133  1010 261a          	jrne	L5003
6136  1012 cd0f18        	call	_apv_start
6138  1015 2015          	jra	L5003
6139  1017               L3772:
6140                     ; 1118 else if(jp_mode==jp3) 
6142  1017 b647          	ld	a,_jp_mode
6143  1019 a103          	cp	a,#3
6144  101b 260f          	jrne	L5003
6145                     ; 1120 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6147  101d b60a          	ld	a,_flags
6148  101f a508          	bcp	a,#8
6149  1021 2709          	jreq	L5003
6151  1023 b600          	ld	a,L3572_flags_old
6152  1025 a508          	bcp	a,#8
6153  1027 2603          	jrne	L5003
6154                     ; 1122     		apv_start();
6156  1029 cd0f18        	call	_apv_start
6158  102c               L5003:
6159                     ; 1125 flags_old=flags;
6161  102c 450a00        	mov	L3572_flags_old,_flags
6162                     ; 1127 } 
6165  102f 81            	ret
6199                     ; 1266 char adr_gran(signed short in)
6199                     ; 1267 {
6200                     	switch	.text
6201  1030               _adr_gran:
6203  1030 89            	pushw	x
6204       00000000      OFST:	set	0
6207                     ; 1268 if(in>800)return 1;
6209  1031 9c            	rvf
6210  1032 a30321        	cpw	x,#801
6211  1035 2f04          	jrslt	L1303
6214  1037 a601          	ld	a,#1
6216  1039 2011          	jra	L621
6217  103b               L1303:
6218                     ; 1269 else if((in>60)&&(in<150))return 0;
6220  103b 9c            	rvf
6221  103c 1e01          	ldw	x,(OFST+1,sp)
6222  103e a3003d        	cpw	x,#61
6223  1041 2f0b          	jrslt	L5303
6225  1043 9c            	rvf
6226  1044 1e01          	ldw	x,(OFST+1,sp)
6227  1046 a30096        	cpw	x,#150
6228  1049 2e03          	jrsge	L5303
6231  104b 4f            	clr	a
6233  104c               L621:
6235  104c 85            	popw	x
6236  104d 81            	ret
6237  104e               L5303:
6238                     ; 1270 else return 100;
6240  104e a664          	ld	a,#100
6242  1050 20fa          	jra	L621
6271                     ; 1274 void adr_drv_v3(void)
6271                     ; 1275 {
6272                     	switch	.text
6273  1052               _adr_drv_v3:
6275  1052 88            	push	a
6276       00000001      OFST:	set	1
6279                     ; 1281 GPIOB->DDR&=~(1<<0);
6281  1053 72115007      	bres	20487,#0
6282                     ; 1282 GPIOB->CR1&=~(1<<0);
6284  1057 72115008      	bres	20488,#0
6285                     ; 1283 GPIOB->CR2&=~(1<<0);
6287  105b 72115009      	bres	20489,#0
6288                     ; 1284 ADC2->CR2=0x08;
6290  105f 35085402      	mov	21506,#8
6291                     ; 1285 ADC2->CR1=0x40;
6293  1063 35405401      	mov	21505,#64
6294                     ; 1286 ADC2->CSR=0x20+0;
6296  1067 35205400      	mov	21504,#32
6297                     ; 1287 ADC2->CR1|=1;
6299  106b 72105401      	bset	21505,#0
6300                     ; 1288 ADC2->CR1|=1;
6302  106f 72105401      	bset	21505,#0
6303                     ; 1289 adr_drv_stat=1;
6305  1073 35010007      	mov	_adr_drv_stat,#1
6306  1077               L1503:
6307                     ; 1290 while(adr_drv_stat==1);
6310  1077 b607          	ld	a,_adr_drv_stat
6311  1079 a101          	cp	a,#1
6312  107b 27fa          	jreq	L1503
6313                     ; 1292 GPIOB->DDR&=~(1<<1);
6315  107d 72135007      	bres	20487,#1
6316                     ; 1293 GPIOB->CR1&=~(1<<1);
6318  1081 72135008      	bres	20488,#1
6319                     ; 1294 GPIOB->CR2&=~(1<<1);
6321  1085 72135009      	bres	20489,#1
6322                     ; 1295 ADC2->CR2=0x08;
6324  1089 35085402      	mov	21506,#8
6325                     ; 1296 ADC2->CR1=0x40;
6327  108d 35405401      	mov	21505,#64
6328                     ; 1297 ADC2->CSR=0x20+1;
6330  1091 35215400      	mov	21504,#33
6331                     ; 1298 ADC2->CR1|=1;
6333  1095 72105401      	bset	21505,#0
6334                     ; 1299 ADC2->CR1|=1;
6336  1099 72105401      	bset	21505,#0
6337                     ; 1300 adr_drv_stat=3;
6339  109d 35030007      	mov	_adr_drv_stat,#3
6340  10a1               L7503:
6341                     ; 1301 while(adr_drv_stat==3);
6344  10a1 b607          	ld	a,_adr_drv_stat
6345  10a3 a103          	cp	a,#3
6346  10a5 27fa          	jreq	L7503
6347                     ; 1303 GPIOE->DDR&=~(1<<6);
6349  10a7 721d5016      	bres	20502,#6
6350                     ; 1304 GPIOE->CR1&=~(1<<6);
6352  10ab 721d5017      	bres	20503,#6
6353                     ; 1305 GPIOE->CR2&=~(1<<6);
6355  10af 721d5018      	bres	20504,#6
6356                     ; 1306 ADC2->CR2=0x08;
6358  10b3 35085402      	mov	21506,#8
6359                     ; 1307 ADC2->CR1=0x40;
6361  10b7 35405401      	mov	21505,#64
6362                     ; 1308 ADC2->CSR=0x20+9;
6364  10bb 35295400      	mov	21504,#41
6365                     ; 1309 ADC2->CR1|=1;
6367  10bf 72105401      	bset	21505,#0
6368                     ; 1310 ADC2->CR1|=1;
6370  10c3 72105401      	bset	21505,#0
6371                     ; 1311 adr_drv_stat=5;
6373  10c7 35050007      	mov	_adr_drv_stat,#5
6374  10cb               L5603:
6375                     ; 1312 while(adr_drv_stat==5);
6378  10cb b607          	ld	a,_adr_drv_stat
6379  10cd a105          	cp	a,#5
6380  10cf 27fa          	jreq	L5603
6381                     ; 1316 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6383  10d1 9c            	rvf
6384  10d2 ce0005        	ldw	x,_adc_buff_
6385  10d5 a3022a        	cpw	x,#554
6386  10d8 2f0f          	jrslt	L3703
6388  10da 9c            	rvf
6389  10db ce0005        	ldw	x,_adc_buff_
6390  10de a30253        	cpw	x,#595
6391  10e1 2e06          	jrsge	L3703
6394  10e3 725f0002      	clr	_adr
6396  10e7 204c          	jra	L5703
6397  10e9               L3703:
6398                     ; 1317 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6400  10e9 9c            	rvf
6401  10ea ce0005        	ldw	x,_adc_buff_
6402  10ed a3036d        	cpw	x,#877
6403  10f0 2f0f          	jrslt	L7703
6405  10f2 9c            	rvf
6406  10f3 ce0005        	ldw	x,_adc_buff_
6407  10f6 a30396        	cpw	x,#918
6408  10f9 2e06          	jrsge	L7703
6411  10fb 35010002      	mov	_adr,#1
6413  10ff 2034          	jra	L5703
6414  1101               L7703:
6415                     ; 1318 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6417  1101 9c            	rvf
6418  1102 ce0005        	ldw	x,_adc_buff_
6419  1105 a302a3        	cpw	x,#675
6420  1108 2f0f          	jrslt	L3013
6422  110a 9c            	rvf
6423  110b ce0005        	ldw	x,_adc_buff_
6424  110e a302cc        	cpw	x,#716
6425  1111 2e06          	jrsge	L3013
6428  1113 35020002      	mov	_adr,#2
6430  1117 201c          	jra	L5703
6431  1119               L3013:
6432                     ; 1319 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6434  1119 9c            	rvf
6435  111a ce0005        	ldw	x,_adc_buff_
6436  111d a303e3        	cpw	x,#995
6437  1120 2f0f          	jrslt	L7013
6439  1122 9c            	rvf
6440  1123 ce0005        	ldw	x,_adc_buff_
6441  1126 a3040c        	cpw	x,#1036
6442  1129 2e06          	jrsge	L7013
6445  112b 35030002      	mov	_adr,#3
6447  112f 2004          	jra	L5703
6448  1131               L7013:
6449                     ; 1320 else adr[0]=5;
6451  1131 35050002      	mov	_adr,#5
6452  1135               L5703:
6453                     ; 1322 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6455  1135 9c            	rvf
6456  1136 ce0007        	ldw	x,_adc_buff_+2
6457  1139 a3022a        	cpw	x,#554
6458  113c 2f0f          	jrslt	L3113
6460  113e 9c            	rvf
6461  113f ce0007        	ldw	x,_adc_buff_+2
6462  1142 a30253        	cpw	x,#595
6463  1145 2e06          	jrsge	L3113
6466  1147 725f0003      	clr	_adr+1
6468  114b 204c          	jra	L5113
6469  114d               L3113:
6470                     ; 1323 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6472  114d 9c            	rvf
6473  114e ce0007        	ldw	x,_adc_buff_+2
6474  1151 a3036d        	cpw	x,#877
6475  1154 2f0f          	jrslt	L7113
6477  1156 9c            	rvf
6478  1157 ce0007        	ldw	x,_adc_buff_+2
6479  115a a30396        	cpw	x,#918
6480  115d 2e06          	jrsge	L7113
6483  115f 35010003      	mov	_adr+1,#1
6485  1163 2034          	jra	L5113
6486  1165               L7113:
6487                     ; 1324 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6489  1165 9c            	rvf
6490  1166 ce0007        	ldw	x,_adc_buff_+2
6491  1169 a302a3        	cpw	x,#675
6492  116c 2f0f          	jrslt	L3213
6494  116e 9c            	rvf
6495  116f ce0007        	ldw	x,_adc_buff_+2
6496  1172 a302cc        	cpw	x,#716
6497  1175 2e06          	jrsge	L3213
6500  1177 35020003      	mov	_adr+1,#2
6502  117b 201c          	jra	L5113
6503  117d               L3213:
6504                     ; 1325 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6506  117d 9c            	rvf
6507  117e ce0007        	ldw	x,_adc_buff_+2
6508  1181 a303e3        	cpw	x,#995
6509  1184 2f0f          	jrslt	L7213
6511  1186 9c            	rvf
6512  1187 ce0007        	ldw	x,_adc_buff_+2
6513  118a a3040c        	cpw	x,#1036
6514  118d 2e06          	jrsge	L7213
6517  118f 35030003      	mov	_adr+1,#3
6519  1193 2004          	jra	L5113
6520  1195               L7213:
6521                     ; 1326 else adr[1]=5;
6523  1195 35050003      	mov	_adr+1,#5
6524  1199               L5113:
6525                     ; 1328 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6527  1199 9c            	rvf
6528  119a ce0017        	ldw	x,_adc_buff_+18
6529  119d a3022a        	cpw	x,#554
6530  11a0 2f0f          	jrslt	L3313
6532  11a2 9c            	rvf
6533  11a3 ce0017        	ldw	x,_adc_buff_+18
6534  11a6 a30253        	cpw	x,#595
6535  11a9 2e06          	jrsge	L3313
6538  11ab 725f0004      	clr	_adr+2
6540  11af 204c          	jra	L5313
6541  11b1               L3313:
6542                     ; 1329 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6544  11b1 9c            	rvf
6545  11b2 ce0017        	ldw	x,_adc_buff_+18
6546  11b5 a3036d        	cpw	x,#877
6547  11b8 2f0f          	jrslt	L7313
6549  11ba 9c            	rvf
6550  11bb ce0017        	ldw	x,_adc_buff_+18
6551  11be a30396        	cpw	x,#918
6552  11c1 2e06          	jrsge	L7313
6555  11c3 35010004      	mov	_adr+2,#1
6557  11c7 2034          	jra	L5313
6558  11c9               L7313:
6559                     ; 1330 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6561  11c9 9c            	rvf
6562  11ca ce0017        	ldw	x,_adc_buff_+18
6563  11cd a302a3        	cpw	x,#675
6564  11d0 2f0f          	jrslt	L3413
6566  11d2 9c            	rvf
6567  11d3 ce0017        	ldw	x,_adc_buff_+18
6568  11d6 a302cc        	cpw	x,#716
6569  11d9 2e06          	jrsge	L3413
6572  11db 35020004      	mov	_adr+2,#2
6574  11df 201c          	jra	L5313
6575  11e1               L3413:
6576                     ; 1331 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6578  11e1 9c            	rvf
6579  11e2 ce0017        	ldw	x,_adc_buff_+18
6580  11e5 a303e3        	cpw	x,#995
6581  11e8 2f0f          	jrslt	L7413
6583  11ea 9c            	rvf
6584  11eb ce0017        	ldw	x,_adc_buff_+18
6585  11ee a3040c        	cpw	x,#1036
6586  11f1 2e06          	jrsge	L7413
6589  11f3 35030004      	mov	_adr+2,#3
6591  11f7 2004          	jra	L5313
6592  11f9               L7413:
6593                     ; 1332 else adr[2]=5;
6595  11f9 35050004      	mov	_adr+2,#5
6596  11fd               L5313:
6597                     ; 1336 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6599  11fd c60002        	ld	a,_adr
6600  1200 a105          	cp	a,#5
6601  1202 270e          	jreq	L5513
6603  1204 c60003        	ld	a,_adr+1
6604  1207 a105          	cp	a,#5
6605  1209 2707          	jreq	L5513
6607  120b c60004        	ld	a,_adr+2
6608  120e a105          	cp	a,#5
6609  1210 2606          	jrne	L3513
6610  1212               L5513:
6611                     ; 1339 	adress_error=1;
6613  1212 35010000      	mov	_adress_error,#1
6615  1216               L1613:
6616                     ; 1350 }
6619  1216 84            	pop	a
6620  1217 81            	ret
6621  1218               L3513:
6622                     ; 1343 	if(adr[2]&0x02) bps_class=bpsIPS;
6624  1218 c60004        	ld	a,_adr+2
6625  121b a502          	bcp	a,#2
6626  121d 2706          	jreq	L3613
6629  121f 35010001      	mov	_bps_class,#1
6631  1223 2002          	jra	L5613
6632  1225               L3613:
6633                     ; 1344 	else bps_class=bpsIBEP;
6635  1225 3f01          	clr	_bps_class
6636  1227               L5613:
6637                     ; 1346 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6639  1227 c60004        	ld	a,_adr+2
6640  122a a401          	and	a,#1
6641  122c 97            	ld	xl,a
6642  122d a610          	ld	a,#16
6643  122f 42            	mul	x,a
6644  1230 9f            	ld	a,xl
6645  1231 6b01          	ld	(OFST+0,sp),a
6646  1233 c60003        	ld	a,_adr+1
6647  1236 48            	sll	a
6648  1237 48            	sll	a
6649  1238 cb0002        	add	a,_adr
6650  123b 1b01          	add	a,(OFST+0,sp)
6651  123d c70001        	ld	_adress,a
6652  1240 20d4          	jra	L1613
6711                     ; 1354 void adr_drv_v4(void)
6711                     ; 1355 {
6712                     	switch	.text
6713  1242               _adr_drv_v4:
6715  1242 5209          	subw	sp,#9
6716       00000009      OFST:	set	9
6719                     ; 1365 GPIOB->DDR&=~(1<<0);
6721  1244 72115007      	bres	20487,#0
6722                     ; 1366 GPIOB->CR1&=~(1<<0);
6724  1248 72115008      	bres	20488,#0
6725                     ; 1367 GPIOB->CR2&=~(1<<0);
6727  124c 72115009      	bres	20489,#0
6728                     ; 1368 ADC2->CR2=0x08;
6730  1250 35085402      	mov	21506,#8
6731                     ; 1369 ADC2->CR1=0x40;
6733  1254 35405401      	mov	21505,#64
6734                     ; 1370 ADC2->CSR=0x20+0;
6736  1258 35205400      	mov	21504,#32
6737                     ; 1371 ADC2->CR1|=1;
6739  125c 72105401      	bset	21505,#0
6740                     ; 1372 ADC2->CR1|=1;
6742  1260 72105401      	bset	21505,#0
6743                     ; 1373 adr_drv_stat=1;
6745  1264 35010007      	mov	_adr_drv_stat,#1
6746  1268               L5123:
6747                     ; 1374 while(adr_drv_stat==1);
6750  1268 b607          	ld	a,_adr_drv_stat
6751  126a a101          	cp	a,#1
6752  126c 27fa          	jreq	L5123
6753                     ; 1376 GPIOB->DDR&=~(1<<1);
6755  126e 72135007      	bres	20487,#1
6756                     ; 1377 GPIOB->CR1&=~(1<<1);
6758  1272 72135008      	bres	20488,#1
6759                     ; 1378 GPIOB->CR2&=~(1<<1);
6761  1276 72135009      	bres	20489,#1
6762                     ; 1379 ADC2->CR2=0x08;
6764  127a 35085402      	mov	21506,#8
6765                     ; 1380 ADC2->CR1=0x40;
6767  127e 35405401      	mov	21505,#64
6768                     ; 1381 ADC2->CSR=0x20+1;
6770  1282 35215400      	mov	21504,#33
6771                     ; 1382 ADC2->CR1|=1;
6773  1286 72105401      	bset	21505,#0
6774                     ; 1383 ADC2->CR1|=1;
6776  128a 72105401      	bset	21505,#0
6777                     ; 1384 adr_drv_stat=3;
6779  128e 35030007      	mov	_adr_drv_stat,#3
6780  1292               L3223:
6781                     ; 1385 while(adr_drv_stat==3);
6784  1292 b607          	ld	a,_adr_drv_stat
6785  1294 a103          	cp	a,#3
6786  1296 27fa          	jreq	L3223
6787                     ; 1387 GPIOE->DDR&=~(1<<6);
6789  1298 721d5016      	bres	20502,#6
6790                     ; 1388 GPIOE->CR1&=~(1<<6);
6792  129c 721d5017      	bres	20503,#6
6793                     ; 1389 GPIOE->CR2&=~(1<<6);
6795  12a0 721d5018      	bres	20504,#6
6796                     ; 1390 ADC2->CR2=0x08;
6798  12a4 35085402      	mov	21506,#8
6799                     ; 1391 ADC2->CR1=0x40;
6801  12a8 35405401      	mov	21505,#64
6802                     ; 1392 ADC2->CSR=0x20+9;
6804  12ac 35295400      	mov	21504,#41
6805                     ; 1393 ADC2->CR1|=1;
6807  12b0 72105401      	bset	21505,#0
6808                     ; 1394 ADC2->CR1|=1;
6810  12b4 72105401      	bset	21505,#0
6811                     ; 1395 adr_drv_stat=5;
6813  12b8 35050007      	mov	_adr_drv_stat,#5
6814  12bc               L1323:
6815                     ; 1396 while(adr_drv_stat==5);
6818  12bc b607          	ld	a,_adr_drv_stat
6819  12be a105          	cp	a,#5
6820  12c0 27fa          	jreq	L1323
6821                     ; 1398 aaa[0]=adr_gran(adc_buff_[0]);
6823  12c2 ce0005        	ldw	x,_adc_buff_
6824  12c5 cd1030        	call	_adr_gran
6826  12c8 6b07          	ld	(OFST-2,sp),a
6827                     ; 1399 tempSI=adc_buff_[0]/260;
6829  12ca ce0005        	ldw	x,_adc_buff_
6830  12cd 90ae0104      	ldw	y,#260
6831  12d1 cd0000        	call	c_idiv
6833  12d4 1f05          	ldw	(OFST-4,sp),x
6834                     ; 1400 gran(&tempSI,0,3);
6836  12d6 ae0003        	ldw	x,#3
6837  12d9 89            	pushw	x
6838  12da 5f            	clrw	x
6839  12db 89            	pushw	x
6840  12dc 96            	ldw	x,sp
6841  12dd 1c0009        	addw	x,#OFST+0
6842  12e0 cd0000        	call	_gran
6844  12e3 5b04          	addw	sp,#4
6845                     ; 1401 aaaa[0]=(char)tempSI;
6847  12e5 7b06          	ld	a,(OFST-3,sp)
6848  12e7 6b02          	ld	(OFST-7,sp),a
6849                     ; 1403 aaa[1]=adr_gran(adc_buff_[1]);
6851  12e9 ce0007        	ldw	x,_adc_buff_+2
6852  12ec cd1030        	call	_adr_gran
6854  12ef 6b08          	ld	(OFST-1,sp),a
6855                     ; 1404 tempSI=adc_buff_[1]/260;
6857  12f1 ce0007        	ldw	x,_adc_buff_+2
6858  12f4 90ae0104      	ldw	y,#260
6859  12f8 cd0000        	call	c_idiv
6861  12fb 1f05          	ldw	(OFST-4,sp),x
6862                     ; 1405 gran(&tempSI,0,3);
6864  12fd ae0003        	ldw	x,#3
6865  1300 89            	pushw	x
6866  1301 5f            	clrw	x
6867  1302 89            	pushw	x
6868  1303 96            	ldw	x,sp
6869  1304 1c0009        	addw	x,#OFST+0
6870  1307 cd0000        	call	_gran
6872  130a 5b04          	addw	sp,#4
6873                     ; 1406 aaaa[1]=(char)tempSI;
6875  130c 7b06          	ld	a,(OFST-3,sp)
6876  130e 6b03          	ld	(OFST-6,sp),a
6877                     ; 1408 aaa[2]=adr_gran(adc_buff_[9]);
6879  1310 ce0017        	ldw	x,_adc_buff_+18
6880  1313 cd1030        	call	_adr_gran
6882  1316 6b09          	ld	(OFST+0,sp),a
6883                     ; 1409 tempSI=adc_buff_[2]/260;
6885  1318 ce0009        	ldw	x,_adc_buff_+4
6886  131b 90ae0104      	ldw	y,#260
6887  131f cd0000        	call	c_idiv
6889  1322 1f05          	ldw	(OFST-4,sp),x
6890                     ; 1410 gran(&tempSI,0,3);
6892  1324 ae0003        	ldw	x,#3
6893  1327 89            	pushw	x
6894  1328 5f            	clrw	x
6895  1329 89            	pushw	x
6896  132a 96            	ldw	x,sp
6897  132b 1c0009        	addw	x,#OFST+0
6898  132e cd0000        	call	_gran
6900  1331 5b04          	addw	sp,#4
6901                     ; 1411 aaaa[2]=(char)tempSI;
6903  1333 7b06          	ld	a,(OFST-3,sp)
6904  1335 6b04          	ld	(OFST-5,sp),a
6905                     ; 1414 adress=100;
6907  1337 35640001      	mov	_adress,#100
6908                     ; 1417 if((aaa[0]!=100)&&(aaa[1]!=100)&&(aaa[2]!=100))
6910  133b 7b07          	ld	a,(OFST-2,sp)
6911  133d a164          	cp	a,#100
6912  133f 2734          	jreq	L7323
6914  1341 7b08          	ld	a,(OFST-1,sp)
6915  1343 a164          	cp	a,#100
6916  1345 272e          	jreq	L7323
6918  1347 7b09          	ld	a,(OFST+0,sp)
6919  1349 a164          	cp	a,#100
6920  134b 2728          	jreq	L7323
6921                     ; 1419 	if(aaa[0]==0)
6923  134d 0d07          	tnz	(OFST-2,sp)
6924  134f 2610          	jrne	L1423
6925                     ; 1421 		if(aaa[1]==0)adress=3;
6927  1351 0d08          	tnz	(OFST-1,sp)
6928  1353 2606          	jrne	L3423
6931  1355 35030001      	mov	_adress,#3
6933  1359 2046          	jra	L7523
6934  135b               L3423:
6935                     ; 1422 		else adress=0;
6937  135b 725f0001      	clr	_adress
6938  135f 2040          	jra	L7523
6939  1361               L1423:
6940                     ; 1424 	else if(aaa[1]==0)adress=1;	
6942  1361 0d08          	tnz	(OFST-1,sp)
6943  1363 2606          	jrne	L1523
6946  1365 35010001      	mov	_adress,#1
6948  1369 2036          	jra	L7523
6949  136b               L1523:
6950                     ; 1425 	else if(aaa[2]==0)adress=2;
6952  136b 0d09          	tnz	(OFST+0,sp)
6953  136d 2632          	jrne	L7523
6956  136f 35020001      	mov	_adress,#2
6957  1373 202c          	jra	L7523
6958  1375               L7323:
6959                     ; 1429 else if((aaa[0]==100)&&(aaa[1]==100)&&(aaa[2]==100))adress=aaaa[0]+ (aaaa[1]*4)+ (aaaa[2]*16);
6961  1375 7b07          	ld	a,(OFST-2,sp)
6962  1377 a164          	cp	a,#100
6963  1379 2622          	jrne	L1623
6965  137b 7b08          	ld	a,(OFST-1,sp)
6966  137d a164          	cp	a,#100
6967  137f 261c          	jrne	L1623
6969  1381 7b09          	ld	a,(OFST+0,sp)
6970  1383 a164          	cp	a,#100
6971  1385 2616          	jrne	L1623
6974  1387 7b04          	ld	a,(OFST-5,sp)
6975  1389 97            	ld	xl,a
6976  138a a610          	ld	a,#16
6977  138c 42            	mul	x,a
6978  138d 9f            	ld	a,xl
6979  138e 6b01          	ld	(OFST-8,sp),a
6980  1390 7b03          	ld	a,(OFST-6,sp)
6981  1392 48            	sll	a
6982  1393 48            	sll	a
6983  1394 1b02          	add	a,(OFST-7,sp)
6984  1396 1b01          	add	a,(OFST-8,sp)
6985  1398 c70001        	ld	_adress,a
6987  139b 2004          	jra	L7523
6988  139d               L1623:
6989                     ; 1433 else adress=100;
6991  139d 35640001      	mov	_adress,#100
6992  13a1               L7523:
6993                     ; 1435 }
6996  13a1 5b09          	addw	sp,#9
6997  13a3 81            	ret
7041                     ; 1439 void volum_u_main_drv(void)
7041                     ; 1440 {
7042                     	switch	.text
7043  13a4               _volum_u_main_drv:
7045  13a4 88            	push	a
7046       00000001      OFST:	set	1
7049                     ; 1443 if(bMAIN)
7051                     	btst	_bMAIN
7052  13aa 2503          	jrult	L631
7053  13ac cc14f5        	jp	L3033
7054  13af               L631:
7055                     ; 1445 	if(Un<(UU_AVT-10))volum_u_main_+=5;
7057  13af 9c            	rvf
7058  13b0 ce0006        	ldw	x,_UU_AVT
7059  13b3 1d000a        	subw	x,#10
7060  13b6 b369          	cpw	x,_Un
7061  13b8 2d09          	jrsle	L5033
7064  13ba be1c          	ldw	x,_volum_u_main_
7065  13bc 1c0005        	addw	x,#5
7066  13bf bf1c          	ldw	_volum_u_main_,x
7068  13c1 2036          	jra	L7033
7069  13c3               L5033:
7070                     ; 1446 	else if(Un<(UU_AVT-1))volum_u_main_++;
7072  13c3 9c            	rvf
7073  13c4 ce0006        	ldw	x,_UU_AVT
7074  13c7 5a            	decw	x
7075  13c8 b369          	cpw	x,_Un
7076  13ca 2d09          	jrsle	L1133
7079  13cc be1c          	ldw	x,_volum_u_main_
7080  13ce 1c0001        	addw	x,#1
7081  13d1 bf1c          	ldw	_volum_u_main_,x
7083  13d3 2024          	jra	L7033
7084  13d5               L1133:
7085                     ; 1447 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
7087  13d5 9c            	rvf
7088  13d6 ce0006        	ldw	x,_UU_AVT
7089  13d9 1c000a        	addw	x,#10
7090  13dc b369          	cpw	x,_Un
7091  13de 2e09          	jrsge	L5133
7094  13e0 be1c          	ldw	x,_volum_u_main_
7095  13e2 1d000a        	subw	x,#10
7096  13e5 bf1c          	ldw	_volum_u_main_,x
7098  13e7 2010          	jra	L7033
7099  13e9               L5133:
7100                     ; 1448 	else if(Un>(UU_AVT+1))volum_u_main_--;
7102  13e9 9c            	rvf
7103  13ea ce0006        	ldw	x,_UU_AVT
7104  13ed 5c            	incw	x
7105  13ee b369          	cpw	x,_Un
7106  13f0 2e07          	jrsge	L7033
7109  13f2 be1c          	ldw	x,_volum_u_main_
7110  13f4 1d0001        	subw	x,#1
7111  13f7 bf1c          	ldw	_volum_u_main_,x
7112  13f9               L7033:
7113                     ; 1449 	if(volum_u_main_>1020)volum_u_main_=1020;
7115  13f9 9c            	rvf
7116  13fa be1c          	ldw	x,_volum_u_main_
7117  13fc a303fd        	cpw	x,#1021
7118  13ff 2f05          	jrslt	L3233
7121  1401 ae03fc        	ldw	x,#1020
7122  1404 bf1c          	ldw	_volum_u_main_,x
7123  1406               L3233:
7124                     ; 1450 	if(volum_u_main_<0)volum_u_main_=0;
7126  1406 9c            	rvf
7127  1407 be1c          	ldw	x,_volum_u_main_
7128  1409 2e03          	jrsge	L5233
7131  140b 5f            	clrw	x
7132  140c bf1c          	ldw	_volum_u_main_,x
7133  140e               L5233:
7134                     ; 1453 	i_main_sigma=0;
7136  140e 5f            	clrw	x
7137  140f bf0c          	ldw	_i_main_sigma,x
7138                     ; 1454 	i_main_num_of_bps=0;
7140  1411 3f0e          	clr	_i_main_num_of_bps
7141                     ; 1455 	for(i=0;i<6;i++)
7143  1413 0f01          	clr	(OFST+0,sp)
7144  1415               L7233:
7145                     ; 1457 		if(i_main_flag[i])
7147  1415 7b01          	ld	a,(OFST+0,sp)
7148  1417 5f            	clrw	x
7149  1418 97            	ld	xl,a
7150  1419 6d11          	tnz	(_i_main_flag,x)
7151  141b 2719          	jreq	L5333
7152                     ; 1459 			i_main_sigma+=i_main[i];
7154  141d 7b01          	ld	a,(OFST+0,sp)
7155  141f 5f            	clrw	x
7156  1420 97            	ld	xl,a
7157  1421 58            	sllw	x
7158  1422 ee17          	ldw	x,(_i_main,x)
7159  1424 72bb000c      	addw	x,_i_main_sigma
7160  1428 bf0c          	ldw	_i_main_sigma,x
7161                     ; 1460 			i_main_flag[i]=1;
7163  142a 7b01          	ld	a,(OFST+0,sp)
7164  142c 5f            	clrw	x
7165  142d 97            	ld	xl,a
7166  142e a601          	ld	a,#1
7167  1430 e711          	ld	(_i_main_flag,x),a
7168                     ; 1461 			i_main_num_of_bps++;
7170  1432 3c0e          	inc	_i_main_num_of_bps
7172  1434 2006          	jra	L7333
7173  1436               L5333:
7174                     ; 1465 			i_main_flag[i]=0;	
7176  1436 7b01          	ld	a,(OFST+0,sp)
7177  1438 5f            	clrw	x
7178  1439 97            	ld	xl,a
7179  143a 6f11          	clr	(_i_main_flag,x)
7180  143c               L7333:
7181                     ; 1455 	for(i=0;i<6;i++)
7183  143c 0c01          	inc	(OFST+0,sp)
7186  143e 7b01          	ld	a,(OFST+0,sp)
7187  1440 a106          	cp	a,#6
7188  1442 25d1          	jrult	L7233
7189                     ; 1468 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7191  1444 be0c          	ldw	x,_i_main_sigma
7192  1446 b60e          	ld	a,_i_main_num_of_bps
7193  1448 905f          	clrw	y
7194  144a 9097          	ld	yl,a
7195  144c cd0000        	call	c_idiv
7197  144f bf0f          	ldw	_i_main_avg,x
7198                     ; 1469 	for(i=0;i<6;i++)
7200  1451 0f01          	clr	(OFST+0,sp)
7201  1453               L1433:
7202                     ; 1471 		if(i_main_flag[i])
7204  1453 7b01          	ld	a,(OFST+0,sp)
7205  1455 5f            	clrw	x
7206  1456 97            	ld	xl,a
7207  1457 6d11          	tnz	(_i_main_flag,x)
7208  1459 2603cc14ea    	jreq	L7433
7209                     ; 1473 			if(i_main[i]<(i_main_avg-10))x[i]++;
7211  145e 9c            	rvf
7212  145f 7b01          	ld	a,(OFST+0,sp)
7213  1461 5f            	clrw	x
7214  1462 97            	ld	xl,a
7215  1463 58            	sllw	x
7216  1464 90be0f        	ldw	y,_i_main_avg
7217  1467 72a2000a      	subw	y,#10
7218  146b 90bf00        	ldw	c_y,y
7219  146e 9093          	ldw	y,x
7220  1470 90ee17        	ldw	y,(_i_main,y)
7221  1473 90b300        	cpw	y,c_y
7222  1476 2e11          	jrsge	L1533
7225  1478 7b01          	ld	a,(OFST+0,sp)
7226  147a 5f            	clrw	x
7227  147b 97            	ld	xl,a
7228  147c 58            	sllw	x
7229  147d 9093          	ldw	y,x
7230  147f ee23          	ldw	x,(_x,x)
7231  1481 1c0001        	addw	x,#1
7232  1484 90ef23        	ldw	(_x,y),x
7234  1487 2029          	jra	L3533
7235  1489               L1533:
7236                     ; 1474 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7238  1489 9c            	rvf
7239  148a 7b01          	ld	a,(OFST+0,sp)
7240  148c 5f            	clrw	x
7241  148d 97            	ld	xl,a
7242  148e 58            	sllw	x
7243  148f 90be0f        	ldw	y,_i_main_avg
7244  1492 72a9000a      	addw	y,#10
7245  1496 90bf00        	ldw	c_y,y
7246  1499 9093          	ldw	y,x
7247  149b 90ee17        	ldw	y,(_i_main,y)
7248  149e 90b300        	cpw	y,c_y
7249  14a1 2d0f          	jrsle	L3533
7252  14a3 7b01          	ld	a,(OFST+0,sp)
7253  14a5 5f            	clrw	x
7254  14a6 97            	ld	xl,a
7255  14a7 58            	sllw	x
7256  14a8 9093          	ldw	y,x
7257  14aa ee23          	ldw	x,(_x,x)
7258  14ac 1d0001        	subw	x,#1
7259  14af 90ef23        	ldw	(_x,y),x
7260  14b2               L3533:
7261                     ; 1475 			if(x[i]>100)x[i]=100;
7263  14b2 9c            	rvf
7264  14b3 7b01          	ld	a,(OFST+0,sp)
7265  14b5 5f            	clrw	x
7266  14b6 97            	ld	xl,a
7267  14b7 58            	sllw	x
7268  14b8 9093          	ldw	y,x
7269  14ba 90ee23        	ldw	y,(_x,y)
7270  14bd 90a30065      	cpw	y,#101
7271  14c1 2f0b          	jrslt	L7533
7274  14c3 7b01          	ld	a,(OFST+0,sp)
7275  14c5 5f            	clrw	x
7276  14c6 97            	ld	xl,a
7277  14c7 58            	sllw	x
7278  14c8 90ae0064      	ldw	y,#100
7279  14cc ef23          	ldw	(_x,x),y
7280  14ce               L7533:
7281                     ; 1476 			if(x[i]<-100)x[i]=-100;
7283  14ce 9c            	rvf
7284  14cf 7b01          	ld	a,(OFST+0,sp)
7285  14d1 5f            	clrw	x
7286  14d2 97            	ld	xl,a
7287  14d3 58            	sllw	x
7288  14d4 9093          	ldw	y,x
7289  14d6 90ee23        	ldw	y,(_x,y)
7290  14d9 90a3ff9c      	cpw	y,#65436
7291  14dd 2e0b          	jrsge	L7433
7294  14df 7b01          	ld	a,(OFST+0,sp)
7295  14e1 5f            	clrw	x
7296  14e2 97            	ld	xl,a
7297  14e3 58            	sllw	x
7298  14e4 90aeff9c      	ldw	y,#65436
7299  14e8 ef23          	ldw	(_x,x),y
7300  14ea               L7433:
7301                     ; 1469 	for(i=0;i<6;i++)
7303  14ea 0c01          	inc	(OFST+0,sp)
7306  14ec 7b01          	ld	a,(OFST+0,sp)
7307  14ee a106          	cp	a,#6
7308  14f0 2403cc1453    	jrult	L1433
7309  14f5               L3033:
7310                     ; 1483 }
7313  14f5 84            	pop	a
7314  14f6 81            	ret
7337                     ; 1486 void init_CAN(void) {
7338                     	switch	.text
7339  14f7               _init_CAN:
7343                     ; 1487 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7345  14f7 72135420      	bres	21536,#1
7346                     ; 1488 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7348  14fb 72105420      	bset	21536,#0
7350  14ff               L5733:
7351                     ; 1489 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7353  14ff c65421        	ld	a,21537
7354  1502 a501          	bcp	a,#1
7355  1504 27f9          	jreq	L5733
7356                     ; 1491 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7358  1506 72185420      	bset	21536,#4
7359                     ; 1493 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7361  150a 35025427      	mov	21543,#2
7362                     ; 1502 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7364  150e 35135428      	mov	21544,#19
7365                     ; 1503 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7367  1512 35c05429      	mov	21545,#192
7368                     ; 1504 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7370  1516 357f542c      	mov	21548,#127
7371                     ; 1505 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7373  151a 35e0542d      	mov	21549,#224
7374                     ; 1507 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7376  151e 35315430      	mov	21552,#49
7377                     ; 1508 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7379  1522 35c05431      	mov	21553,#192
7380                     ; 1509 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7382  1526 357f5434      	mov	21556,#127
7383                     ; 1510 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7385  152a 35e05435      	mov	21557,#224
7386                     ; 1514 	CAN->PSR= 6;									// set page 6
7388  152e 35065427      	mov	21543,#6
7389                     ; 1519 	CAN->Page.Config.FMR1&=~3;								//mask mode
7391  1532 c65430        	ld	a,21552
7392  1535 a4fc          	and	a,#252
7393  1537 c75430        	ld	21552,a
7394                     ; 1525 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7396  153a 35065432      	mov	21554,#6
7397                     ; 1526 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7399  153e 35605432      	mov	21554,#96
7400                     ; 1529 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7402  1542 72105432      	bset	21554,#0
7403                     ; 1530 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7405  1546 72185432      	bset	21554,#4
7406                     ; 1533 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7408  154a 35065427      	mov	21543,#6
7409                     ; 1535 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7411  154e 3509542c      	mov	21548,#9
7412                     ; 1536 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7414  1552 35e7542d      	mov	21549,#231
7415                     ; 1538 	CAN->IER|=(1<<1);
7417  1556 72125425      	bset	21541,#1
7418                     ; 1541 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7420  155a 72115420      	bres	21536,#0
7422  155e               L3043:
7423                     ; 1542 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7425  155e c65421        	ld	a,21537
7426  1561 a501          	bcp	a,#1
7427  1563 26f9          	jrne	L3043
7428                     ; 1543 }
7431  1565 81            	ret
7539                     ; 1546 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7539                     ; 1547 {
7540                     	switch	.text
7541  1566               _can_transmit:
7543  1566 89            	pushw	x
7544       00000000      OFST:	set	0
7547                     ; 1549 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7549  1567 b670          	ld	a,_can_buff_wr_ptr
7550  1569 a104          	cp	a,#4
7551  156b 2502          	jrult	L5643
7554  156d 3f70          	clr	_can_buff_wr_ptr
7555  156f               L5643:
7556                     ; 1551 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7558  156f b670          	ld	a,_can_buff_wr_ptr
7559  1571 97            	ld	xl,a
7560  1572 a610          	ld	a,#16
7561  1574 42            	mul	x,a
7562  1575 1601          	ldw	y,(OFST+1,sp)
7563  1577 a606          	ld	a,#6
7564  1579               L441:
7565  1579 9054          	srlw	y
7566  157b 4a            	dec	a
7567  157c 26fb          	jrne	L441
7568  157e 909f          	ld	a,yl
7569  1580 e771          	ld	(_can_out_buff,x),a
7570                     ; 1552 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7572  1582 b670          	ld	a,_can_buff_wr_ptr
7573  1584 97            	ld	xl,a
7574  1585 a610          	ld	a,#16
7575  1587 42            	mul	x,a
7576  1588 7b02          	ld	a,(OFST+2,sp)
7577  158a 48            	sll	a
7578  158b 48            	sll	a
7579  158c e772          	ld	(_can_out_buff+1,x),a
7580                     ; 1554 can_out_buff[can_buff_wr_ptr][2]=data0;
7582  158e b670          	ld	a,_can_buff_wr_ptr
7583  1590 97            	ld	xl,a
7584  1591 a610          	ld	a,#16
7585  1593 42            	mul	x,a
7586  1594 7b05          	ld	a,(OFST+5,sp)
7587  1596 e773          	ld	(_can_out_buff+2,x),a
7588                     ; 1555 can_out_buff[can_buff_wr_ptr][3]=data1;
7590  1598 b670          	ld	a,_can_buff_wr_ptr
7591  159a 97            	ld	xl,a
7592  159b a610          	ld	a,#16
7593  159d 42            	mul	x,a
7594  159e 7b06          	ld	a,(OFST+6,sp)
7595  15a0 e774          	ld	(_can_out_buff+3,x),a
7596                     ; 1556 can_out_buff[can_buff_wr_ptr][4]=data2;
7598  15a2 b670          	ld	a,_can_buff_wr_ptr
7599  15a4 97            	ld	xl,a
7600  15a5 a610          	ld	a,#16
7601  15a7 42            	mul	x,a
7602  15a8 7b07          	ld	a,(OFST+7,sp)
7603  15aa e775          	ld	(_can_out_buff+4,x),a
7604                     ; 1557 can_out_buff[can_buff_wr_ptr][5]=data3;
7606  15ac b670          	ld	a,_can_buff_wr_ptr
7607  15ae 97            	ld	xl,a
7608  15af a610          	ld	a,#16
7609  15b1 42            	mul	x,a
7610  15b2 7b08          	ld	a,(OFST+8,sp)
7611  15b4 e776          	ld	(_can_out_buff+5,x),a
7612                     ; 1558 can_out_buff[can_buff_wr_ptr][6]=data4;
7614  15b6 b670          	ld	a,_can_buff_wr_ptr
7615  15b8 97            	ld	xl,a
7616  15b9 a610          	ld	a,#16
7617  15bb 42            	mul	x,a
7618  15bc 7b09          	ld	a,(OFST+9,sp)
7619  15be e777          	ld	(_can_out_buff+6,x),a
7620                     ; 1559 can_out_buff[can_buff_wr_ptr][7]=data5;
7622  15c0 b670          	ld	a,_can_buff_wr_ptr
7623  15c2 97            	ld	xl,a
7624  15c3 a610          	ld	a,#16
7625  15c5 42            	mul	x,a
7626  15c6 7b0a          	ld	a,(OFST+10,sp)
7627  15c8 e778          	ld	(_can_out_buff+7,x),a
7628                     ; 1560 can_out_buff[can_buff_wr_ptr][8]=data6;
7630  15ca b670          	ld	a,_can_buff_wr_ptr
7631  15cc 97            	ld	xl,a
7632  15cd a610          	ld	a,#16
7633  15cf 42            	mul	x,a
7634  15d0 7b0b          	ld	a,(OFST+11,sp)
7635  15d2 e779          	ld	(_can_out_buff+8,x),a
7636                     ; 1561 can_out_buff[can_buff_wr_ptr][9]=data7;
7638  15d4 b670          	ld	a,_can_buff_wr_ptr
7639  15d6 97            	ld	xl,a
7640  15d7 a610          	ld	a,#16
7641  15d9 42            	mul	x,a
7642  15da 7b0c          	ld	a,(OFST+12,sp)
7643  15dc e77a          	ld	(_can_out_buff+9,x),a
7644                     ; 1563 can_buff_wr_ptr++;
7646  15de 3c70          	inc	_can_buff_wr_ptr
7647                     ; 1564 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7649  15e0 b670          	ld	a,_can_buff_wr_ptr
7650  15e2 a104          	cp	a,#4
7651  15e4 2502          	jrult	L7643
7654  15e6 3f70          	clr	_can_buff_wr_ptr
7655  15e8               L7643:
7656                     ; 1565 } 
7659  15e8 85            	popw	x
7660  15e9 81            	ret
7689                     ; 1568 void can_tx_hndl(void)
7689                     ; 1569 {
7690                     	switch	.text
7691  15ea               _can_tx_hndl:
7695                     ; 1570 if(bTX_FREE)
7697  15ea 3d08          	tnz	_bTX_FREE
7698  15ec 2757          	jreq	L1053
7699                     ; 1572 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7701  15ee b66f          	ld	a,_can_buff_rd_ptr
7702  15f0 b170          	cp	a,_can_buff_wr_ptr
7703  15f2 275f          	jreq	L7053
7704                     ; 1574 		bTX_FREE=0;
7706  15f4 3f08          	clr	_bTX_FREE
7707                     ; 1576 		CAN->PSR= 0;
7709  15f6 725f5427      	clr	21543
7710                     ; 1577 		CAN->Page.TxMailbox.MDLCR=8;
7712  15fa 35085429      	mov	21545,#8
7713                     ; 1578 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7715  15fe b66f          	ld	a,_can_buff_rd_ptr
7716  1600 97            	ld	xl,a
7717  1601 a610          	ld	a,#16
7718  1603 42            	mul	x,a
7719  1604 e671          	ld	a,(_can_out_buff,x)
7720  1606 c7542a        	ld	21546,a
7721                     ; 1579 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7723  1609 b66f          	ld	a,_can_buff_rd_ptr
7724  160b 97            	ld	xl,a
7725  160c a610          	ld	a,#16
7726  160e 42            	mul	x,a
7727  160f e672          	ld	a,(_can_out_buff+1,x)
7728  1611 c7542b        	ld	21547,a
7729                     ; 1581 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7731  1614 b66f          	ld	a,_can_buff_rd_ptr
7732  1616 97            	ld	xl,a
7733  1617 a610          	ld	a,#16
7734  1619 42            	mul	x,a
7735  161a 01            	rrwa	x,a
7736  161b ab73          	add	a,#_can_out_buff+2
7737  161d 2401          	jrnc	L051
7738  161f 5c            	incw	x
7739  1620               L051:
7740  1620 5f            	clrw	x
7741  1621 97            	ld	xl,a
7742  1622 bf00          	ldw	c_x,x
7743  1624 ae0008        	ldw	x,#8
7744  1627               L251:
7745  1627 5a            	decw	x
7746  1628 92d600        	ld	a,([c_x],x)
7747  162b d7542e        	ld	(21550,x),a
7748  162e 5d            	tnzw	x
7749  162f 26f6          	jrne	L251
7750                     ; 1583 		can_buff_rd_ptr++;
7752  1631 3c6f          	inc	_can_buff_rd_ptr
7753                     ; 1584 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7755  1633 b66f          	ld	a,_can_buff_rd_ptr
7756  1635 a104          	cp	a,#4
7757  1637 2502          	jrult	L5053
7760  1639 3f6f          	clr	_can_buff_rd_ptr
7761  163b               L5053:
7762                     ; 1586 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7764  163b 72105428      	bset	21544,#0
7765                     ; 1587 		CAN->IER|=(1<<0);
7767  163f 72105425      	bset	21541,#0
7768  1643 200e          	jra	L7053
7769  1645               L1053:
7770                     ; 1592 	tx_busy_cnt++;
7772  1645 3c6e          	inc	_tx_busy_cnt
7773                     ; 1593 	if(tx_busy_cnt>=100)
7775  1647 b66e          	ld	a,_tx_busy_cnt
7776  1649 a164          	cp	a,#100
7777  164b 2506          	jrult	L7053
7778                     ; 1595 		tx_busy_cnt=0;
7780  164d 3f6e          	clr	_tx_busy_cnt
7781                     ; 1596 		bTX_FREE=1;
7783  164f 35010008      	mov	_bTX_FREE,#1
7784  1653               L7053:
7785                     ; 1599 }
7788  1653 81            	ret
7827                     ; 1602 void net_drv(void)
7827                     ; 1603 { 
7828                     	switch	.text
7829  1654               _net_drv:
7833                     ; 1605 if(bMAIN)
7835                     	btst	_bMAIN
7836  1659 2503          	jrult	L651
7837  165b cc1701        	jp	L3253
7838  165e               L651:
7839                     ; 1607 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7841  165e 3c2f          	inc	_cnt_net_drv
7842  1660 b62f          	ld	a,_cnt_net_drv
7843  1662 a107          	cp	a,#7
7844  1664 2502          	jrult	L5253
7847  1666 3f2f          	clr	_cnt_net_drv
7848  1668               L5253:
7849                     ; 1609 	if(cnt_net_drv<=5) 
7851  1668 b62f          	ld	a,_cnt_net_drv
7852  166a a106          	cp	a,#6
7853  166c 244c          	jruge	L7253
7854                     ; 1611 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7856  166e 4be8          	push	#232
7857  1670 4be8          	push	#232
7858  1672 b62f          	ld	a,_cnt_net_drv
7859  1674 5f            	clrw	x
7860  1675 97            	ld	xl,a
7861  1676 58            	sllw	x
7862  1677 ee23          	ldw	x,(_x,x)
7863  1679 72bb001c      	addw	x,_volum_u_main_
7864  167d 90ae0100      	ldw	y,#256
7865  1681 cd0000        	call	c_idiv
7867  1684 9f            	ld	a,xl
7868  1685 88            	push	a
7869  1686 b62f          	ld	a,_cnt_net_drv
7870  1688 5f            	clrw	x
7871  1689 97            	ld	xl,a
7872  168a 58            	sllw	x
7873  168b e624          	ld	a,(_x+1,x)
7874  168d bb1d          	add	a,_volum_u_main_+1
7875  168f 88            	push	a
7876  1690 4b00          	push	#0
7877  1692 4bed          	push	#237
7878  1694 3b002f        	push	_cnt_net_drv
7879  1697 3b002f        	push	_cnt_net_drv
7880  169a ae009e        	ldw	x,#158
7881  169d cd1566        	call	_can_transmit
7883  16a0 5b08          	addw	sp,#8
7884                     ; 1612 		i_main_bps_cnt[cnt_net_drv]++;
7886  16a2 b62f          	ld	a,_cnt_net_drv
7887  16a4 5f            	clrw	x
7888  16a5 97            	ld	xl,a
7889  16a6 6c06          	inc	(_i_main_bps_cnt,x)
7890                     ; 1613 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7892  16a8 b62f          	ld	a,_cnt_net_drv
7893  16aa 5f            	clrw	x
7894  16ab 97            	ld	xl,a
7895  16ac e606          	ld	a,(_i_main_bps_cnt,x)
7896  16ae a10b          	cp	a,#11
7897  16b0 254f          	jrult	L3253
7900  16b2 b62f          	ld	a,_cnt_net_drv
7901  16b4 5f            	clrw	x
7902  16b5 97            	ld	xl,a
7903  16b6 6f11          	clr	(_i_main_flag,x)
7904  16b8 2047          	jra	L3253
7905  16ba               L7253:
7906                     ; 1615 	else if(cnt_net_drv==6)
7908  16ba b62f          	ld	a,_cnt_net_drv
7909  16bc a106          	cp	a,#6
7910  16be 2641          	jrne	L3253
7911                     ; 1617 		plazma_int[2]=pwm_u;
7913  16c0 be0b          	ldw	x,_pwm_u
7914  16c2 bf34          	ldw	_plazma_int+4,x
7915                     ; 1618 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7917  16c4 3b0067        	push	_Ui
7918  16c7 3b0068        	push	_Ui+1
7919  16ca 3b0069        	push	_Un
7920  16cd 3b006a        	push	_Un+1
7921  16d0 3b006b        	push	_I
7922  16d3 3b006c        	push	_I+1
7923  16d6 4bda          	push	#218
7924  16d8 3b0001        	push	_adress
7925  16db ae018e        	ldw	x,#398
7926  16de cd1566        	call	_can_transmit
7928  16e1 5b08          	addw	sp,#8
7929                     ; 1619 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7931  16e3 3b0034        	push	_plazma_int+4
7932  16e6 3b0035        	push	_plazma_int+5
7933  16e9 3b005c        	push	__x_+1
7934  16ec 3b000a        	push	_flags
7935  16ef 4b00          	push	#0
7936  16f1 3b0064        	push	_T
7937  16f4 4bdb          	push	#219
7938  16f6 3b0001        	push	_adress
7939  16f9 ae018e        	ldw	x,#398
7940  16fc cd1566        	call	_can_transmit
7942  16ff 5b08          	addw	sp,#8
7943  1701               L3253:
7944                     ; 1622 }
7947  1701 81            	ret
8057                     ; 1625 void can_in_an(void)
8057                     ; 1626 {
8058                     	switch	.text
8059  1702               _can_in_an:
8061  1702 5205          	subw	sp,#5
8062       00000005      OFST:	set	5
8065                     ; 1636 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
8067  1704 b6c6          	ld	a,_mess+6
8068  1706 c10001        	cp	a,_adress
8069  1709 2703          	jreq	L202
8070  170b cc1818        	jp	L3753
8071  170e               L202:
8073  170e b6c7          	ld	a,_mess+7
8074  1710 c10001        	cp	a,_adress
8075  1713 2703          	jreq	L402
8076  1715 cc1818        	jp	L3753
8077  1718               L402:
8079  1718 b6c8          	ld	a,_mess+8
8080  171a a1ed          	cp	a,#237
8081  171c 2703          	jreq	L602
8082  171e cc1818        	jp	L3753
8083  1721               L602:
8084                     ; 1639 	can_error_cnt=0;
8086  1721 3f6d          	clr	_can_error_cnt
8087                     ; 1641 	bMAIN=0;
8089  1723 72110002      	bres	_bMAIN
8090                     ; 1642  	flags_tu=mess[9];
8092  1727 45c95d        	mov	_flags_tu,_mess+9
8093                     ; 1643  	if(flags_tu&0b00000001)
8095  172a b65d          	ld	a,_flags_tu
8096  172c a501          	bcp	a,#1
8097  172e 2706          	jreq	L5753
8098                     ; 1648  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
8100  1730 721a000a      	bset	_flags,#5
8102  1734 200e          	jra	L7753
8103  1736               L5753:
8104                     ; 1659  				flags&=0b11011111; 
8106  1736 721b000a      	bres	_flags,#5
8107                     ; 1660  				off_bp_cnt=5*ee_TZAS;
8109  173a c60015        	ld	a,_ee_TZAS+1
8110  173d 97            	ld	xl,a
8111  173e a605          	ld	a,#5
8112  1740 42            	mul	x,a
8113  1741 9f            	ld	a,xl
8114  1742 b750          	ld	_off_bp_cnt,a
8115  1744               L7753:
8116                     ; 1666  	if(flags_tu&0b00000010) flags|=0b01000000;
8118  1744 b65d          	ld	a,_flags_tu
8119  1746 a502          	bcp	a,#2
8120  1748 2706          	jreq	L1063
8123  174a 721c000a      	bset	_flags,#6
8125  174e 2004          	jra	L3063
8126  1750               L1063:
8127                     ; 1667  	else flags&=0b10111111; 
8129  1750 721d000a      	bres	_flags,#6
8130  1754               L3063:
8131                     ; 1669  	vol_u_temp=mess[10]+mess[11]*256;
8133  1754 b6cb          	ld	a,_mess+11
8134  1756 5f            	clrw	x
8135  1757 97            	ld	xl,a
8136  1758 4f            	clr	a
8137  1759 02            	rlwa	x,a
8138  175a 01            	rrwa	x,a
8139  175b bbca          	add	a,_mess+10
8140  175d 2401          	jrnc	L261
8141  175f 5c            	incw	x
8142  1760               L261:
8143  1760 b756          	ld	_vol_u_temp+1,a
8144  1762 9f            	ld	a,xl
8145  1763 b755          	ld	_vol_u_temp,a
8146                     ; 1670  	vol_i_temp=mess[12]+mess[13]*256;  
8148  1765 b6cd          	ld	a,_mess+13
8149  1767 5f            	clrw	x
8150  1768 97            	ld	xl,a
8151  1769 4f            	clr	a
8152  176a 02            	rlwa	x,a
8153  176b 01            	rrwa	x,a
8154  176c bbcc          	add	a,_mess+12
8155  176e 2401          	jrnc	L461
8156  1770 5c            	incw	x
8157  1771               L461:
8158  1771 b754          	ld	_vol_i_temp+1,a
8159  1773 9f            	ld	a,xl
8160  1774 b753          	ld	_vol_i_temp,a
8161                     ; 1679 	plazma_int[2]=T;
8163  1776 5f            	clrw	x
8164  1777 b664          	ld	a,_T
8165  1779 2a01          	jrpl	L661
8166  177b 53            	cplw	x
8167  177c               L661:
8168  177c 97            	ld	xl,a
8169  177d bf34          	ldw	_plazma_int+4,x
8170                     ; 1680  	rotor_int=flags_tu+(((short)flags)<<8);
8172  177f b60a          	ld	a,_flags
8173  1781 5f            	clrw	x
8174  1782 97            	ld	xl,a
8175  1783 4f            	clr	a
8176  1784 02            	rlwa	x,a
8177  1785 01            	rrwa	x,a
8178  1786 bb5d          	add	a,_flags_tu
8179  1788 2401          	jrnc	L071
8180  178a 5c            	incw	x
8181  178b               L071:
8182  178b b71b          	ld	_rotor_int+1,a
8183  178d 9f            	ld	a,xl
8184  178e b71a          	ld	_rotor_int,a
8185                     ; 1681 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8187  1790 3b0067        	push	_Ui
8188  1793 3b0068        	push	_Ui+1
8189  1796 3b0069        	push	_Un
8190  1799 3b006a        	push	_Un+1
8191  179c 3b006b        	push	_I
8192  179f 3b006c        	push	_I+1
8193  17a2 4bda          	push	#218
8194  17a4 3b0001        	push	_adress
8195  17a7 ae018e        	ldw	x,#398
8196  17aa cd1566        	call	_can_transmit
8198  17ad 5b08          	addw	sp,#8
8199                     ; 1682 	can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8201  17af 3b0034        	push	_plazma_int+4
8202  17b2 3b0035        	push	_plazma_int+5
8203  17b5 3b005c        	push	__x_+1
8204  17b8 3b000a        	push	_flags
8205  17bb 4b00          	push	#0
8206  17bd 3b0064        	push	_T
8207  17c0 4bdb          	push	#219
8208  17c2 3b0001        	push	_adress
8209  17c5 ae018e        	ldw	x,#398
8210  17c8 cd1566        	call	_can_transmit
8212  17cb 5b08          	addw	sp,#8
8213                     ; 1683      link_cnt=0;
8215  17cd 3f5e          	clr	_link_cnt
8216                     ; 1684      link=ON;
8218  17cf 3555005f      	mov	_link,#85
8219                     ; 1686      if(flags_tu&0b10000000)
8221  17d3 b65d          	ld	a,_flags_tu
8222  17d5 a580          	bcp	a,#128
8223  17d7 2716          	jreq	L5063
8224                     ; 1688      	if(!res_fl)
8226  17d9 725d0009      	tnz	_res_fl
8227  17dd 2625          	jrne	L1163
8228                     ; 1690      		res_fl=1;
8230  17df a601          	ld	a,#1
8231  17e1 ae0009        	ldw	x,#_res_fl
8232  17e4 cd0000        	call	c_eewrc
8234                     ; 1691      		bRES=1;
8236  17e7 3501000f      	mov	_bRES,#1
8237                     ; 1692      		res_fl_cnt=0;
8239  17eb 3f3e          	clr	_res_fl_cnt
8240  17ed 2015          	jra	L1163
8241  17ef               L5063:
8242                     ; 1697      	if(main_cnt>20)
8244  17ef 9c            	rvf
8245  17f0 be4e          	ldw	x,_main_cnt
8246  17f2 a30015        	cpw	x,#21
8247  17f5 2f0d          	jrslt	L1163
8248                     ; 1699     			if(res_fl)
8250  17f7 725d0009      	tnz	_res_fl
8251  17fb 2707          	jreq	L1163
8252                     ; 1701      			res_fl=0;
8254  17fd 4f            	clr	a
8255  17fe ae0009        	ldw	x,#_res_fl
8256  1801 cd0000        	call	c_eewrc
8258  1804               L1163:
8259                     ; 1706       if(res_fl_)
8261  1804 725d0008      	tnz	_res_fl_
8262  1808 2603          	jrne	L012
8263  180a cc1d3b        	jp	L7353
8264  180d               L012:
8265                     ; 1708       	res_fl_=0;
8267  180d 4f            	clr	a
8268  180e ae0008        	ldw	x,#_res_fl_
8269  1811 cd0000        	call	c_eewrc
8271  1814 ac3b1d3b      	jpf	L7353
8272  1818               L3753:
8273                     ; 1711 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8275  1818 b6c6          	ld	a,_mess+6
8276  181a c10001        	cp	a,_adress
8277  181d 2703          	jreq	L212
8278  181f cc1a2e        	jp	L3263
8279  1822               L212:
8281  1822 b6c7          	ld	a,_mess+7
8282  1824 c10001        	cp	a,_adress
8283  1827 2703          	jreq	L412
8284  1829 cc1a2e        	jp	L3263
8285  182c               L412:
8287  182c b6c8          	ld	a,_mess+8
8288  182e a1ee          	cp	a,#238
8289  1830 2703          	jreq	L612
8290  1832 cc1a2e        	jp	L3263
8291  1835               L612:
8293  1835 b6c9          	ld	a,_mess+9
8294  1837 b1ca          	cp	a,_mess+10
8295  1839 2703          	jreq	L022
8296  183b cc1a2e        	jp	L3263
8297  183e               L022:
8298                     ; 1713 	rotor_int++;
8300  183e be1a          	ldw	x,_rotor_int
8301  1840 1c0001        	addw	x,#1
8302  1843 bf1a          	ldw	_rotor_int,x
8303                     ; 1714 	if((mess[9]&0xf0)==0x20)
8305  1845 b6c9          	ld	a,_mess+9
8306  1847 a4f0          	and	a,#240
8307  1849 a120          	cp	a,#32
8308  184b 2673          	jrne	L5263
8309                     ; 1716 		if((mess[9]&0x0f)==0x01)
8311  184d b6c9          	ld	a,_mess+9
8312  184f a40f          	and	a,#15
8313  1851 a101          	cp	a,#1
8314  1853 260d          	jrne	L7263
8315                     ; 1718 			ee_K[0][0]=adc_buff_[4];
8317  1855 ce000d        	ldw	x,_adc_buff_+8
8318  1858 89            	pushw	x
8319  1859 ae0018        	ldw	x,#_ee_K
8320  185c cd0000        	call	c_eewrw
8322  185f 85            	popw	x
8324  1860 204a          	jra	L1363
8325  1862               L7263:
8326                     ; 1720 		else if((mess[9]&0x0f)==0x02)
8328  1862 b6c9          	ld	a,_mess+9
8329  1864 a40f          	and	a,#15
8330  1866 a102          	cp	a,#2
8331  1868 260b          	jrne	L3363
8332                     ; 1722 			ee_K[0][1]++;
8334  186a ce001a        	ldw	x,_ee_K+2
8335  186d 1c0001        	addw	x,#1
8336  1870 cf001a        	ldw	_ee_K+2,x
8338  1873 2037          	jra	L1363
8339  1875               L3363:
8340                     ; 1724 		else if((mess[9]&0x0f)==0x03)
8342  1875 b6c9          	ld	a,_mess+9
8343  1877 a40f          	and	a,#15
8344  1879 a103          	cp	a,#3
8345  187b 260b          	jrne	L7363
8346                     ; 1726 			ee_K[0][1]+=10;
8348  187d ce001a        	ldw	x,_ee_K+2
8349  1880 1c000a        	addw	x,#10
8350  1883 cf001a        	ldw	_ee_K+2,x
8352  1886 2024          	jra	L1363
8353  1888               L7363:
8354                     ; 1728 		else if((mess[9]&0x0f)==0x04)
8356  1888 b6c9          	ld	a,_mess+9
8357  188a a40f          	and	a,#15
8358  188c a104          	cp	a,#4
8359  188e 260b          	jrne	L3463
8360                     ; 1730 			ee_K[0][1]--;
8362  1890 ce001a        	ldw	x,_ee_K+2
8363  1893 1d0001        	subw	x,#1
8364  1896 cf001a        	ldw	_ee_K+2,x
8366  1899 2011          	jra	L1363
8367  189b               L3463:
8368                     ; 1732 		else if((mess[9]&0x0f)==0x05)
8370  189b b6c9          	ld	a,_mess+9
8371  189d a40f          	and	a,#15
8372  189f a105          	cp	a,#5
8373  18a1 2609          	jrne	L1363
8374                     ; 1734 			ee_K[0][1]-=10;
8376  18a3 ce001a        	ldw	x,_ee_K+2
8377  18a6 1d000a        	subw	x,#10
8378  18a9 cf001a        	ldw	_ee_K+2,x
8379  18ac               L1363:
8380                     ; 1736 		granee(&ee_K[0][1],50,3000);									
8382  18ac ae0bb8        	ldw	x,#3000
8383  18af 89            	pushw	x
8384  18b0 ae0032        	ldw	x,#50
8385  18b3 89            	pushw	x
8386  18b4 ae001a        	ldw	x,#_ee_K+2
8387  18b7 cd0021        	call	_granee
8389  18ba 5b04          	addw	sp,#4
8391  18bc ac141a14      	jpf	L1563
8392  18c0               L5263:
8393                     ; 1738 	else if((mess[9]&0xf0)==0x10)
8395  18c0 b6c9          	ld	a,_mess+9
8396  18c2 a4f0          	and	a,#240
8397  18c4 a110          	cp	a,#16
8398  18c6 2673          	jrne	L3563
8399                     ; 1740 		if((mess[9]&0x0f)==0x01)
8401  18c8 b6c9          	ld	a,_mess+9
8402  18ca a40f          	and	a,#15
8403  18cc a101          	cp	a,#1
8404  18ce 260d          	jrne	L5563
8405                     ; 1742 			ee_K[1][0]=adc_buff_[1];
8407  18d0 ce0007        	ldw	x,_adc_buff_+2
8408  18d3 89            	pushw	x
8409  18d4 ae001c        	ldw	x,#_ee_K+4
8410  18d7 cd0000        	call	c_eewrw
8412  18da 85            	popw	x
8414  18db 204a          	jra	L7563
8415  18dd               L5563:
8416                     ; 1744 		else if((mess[9]&0x0f)==0x02)
8418  18dd b6c9          	ld	a,_mess+9
8419  18df a40f          	and	a,#15
8420  18e1 a102          	cp	a,#2
8421  18e3 260b          	jrne	L1663
8422                     ; 1746 			ee_K[1][1]++;
8424  18e5 ce001e        	ldw	x,_ee_K+6
8425  18e8 1c0001        	addw	x,#1
8426  18eb cf001e        	ldw	_ee_K+6,x
8428  18ee 2037          	jra	L7563
8429  18f0               L1663:
8430                     ; 1748 		else if((mess[9]&0x0f)==0x03)
8432  18f0 b6c9          	ld	a,_mess+9
8433  18f2 a40f          	and	a,#15
8434  18f4 a103          	cp	a,#3
8435  18f6 260b          	jrne	L5663
8436                     ; 1750 			ee_K[1][1]+=10;
8438  18f8 ce001e        	ldw	x,_ee_K+6
8439  18fb 1c000a        	addw	x,#10
8440  18fe cf001e        	ldw	_ee_K+6,x
8442  1901 2024          	jra	L7563
8443  1903               L5663:
8444                     ; 1752 		else if((mess[9]&0x0f)==0x04)
8446  1903 b6c9          	ld	a,_mess+9
8447  1905 a40f          	and	a,#15
8448  1907 a104          	cp	a,#4
8449  1909 260b          	jrne	L1763
8450                     ; 1754 			ee_K[1][1]--;
8452  190b ce001e        	ldw	x,_ee_K+6
8453  190e 1d0001        	subw	x,#1
8454  1911 cf001e        	ldw	_ee_K+6,x
8456  1914 2011          	jra	L7563
8457  1916               L1763:
8458                     ; 1756 		else if((mess[9]&0x0f)==0x05)
8460  1916 b6c9          	ld	a,_mess+9
8461  1918 a40f          	and	a,#15
8462  191a a105          	cp	a,#5
8463  191c 2609          	jrne	L7563
8464                     ; 1758 			ee_K[1][1]-=10;
8466  191e ce001e        	ldw	x,_ee_K+6
8467  1921 1d000a        	subw	x,#10
8468  1924 cf001e        	ldw	_ee_K+6,x
8469  1927               L7563:
8470                     ; 1763 		granee(&ee_K[1][1],10,30000);
8472  1927 ae7530        	ldw	x,#30000
8473  192a 89            	pushw	x
8474  192b ae000a        	ldw	x,#10
8475  192e 89            	pushw	x
8476  192f ae001e        	ldw	x,#_ee_K+6
8477  1932 cd0021        	call	_granee
8479  1935 5b04          	addw	sp,#4
8481  1937 ac141a14      	jpf	L1563
8482  193b               L3563:
8483                     ; 1767 	else if((mess[9]&0xf0)==0x00)
8485  193b b6c9          	ld	a,_mess+9
8486  193d a5f0          	bcp	a,#240
8487  193f 2671          	jrne	L1073
8488                     ; 1769 		if((mess[9]&0x0f)==0x01)
8490  1941 b6c9          	ld	a,_mess+9
8491  1943 a40f          	and	a,#15
8492  1945 a101          	cp	a,#1
8493  1947 260d          	jrne	L3073
8494                     ; 1771 			ee_K[2][0]=adc_buff_[2];
8496  1949 ce0009        	ldw	x,_adc_buff_+4
8497  194c 89            	pushw	x
8498  194d ae0020        	ldw	x,#_ee_K+8
8499  1950 cd0000        	call	c_eewrw
8501  1953 85            	popw	x
8503  1954 204a          	jra	L5073
8504  1956               L3073:
8505                     ; 1773 		else if((mess[9]&0x0f)==0x02)
8507  1956 b6c9          	ld	a,_mess+9
8508  1958 a40f          	and	a,#15
8509  195a a102          	cp	a,#2
8510  195c 260b          	jrne	L7073
8511                     ; 1775 			ee_K[2][1]++;
8513  195e ce0022        	ldw	x,_ee_K+10
8514  1961 1c0001        	addw	x,#1
8515  1964 cf0022        	ldw	_ee_K+10,x
8517  1967 2037          	jra	L5073
8518  1969               L7073:
8519                     ; 1777 		else if((mess[9]&0x0f)==0x03)
8521  1969 b6c9          	ld	a,_mess+9
8522  196b a40f          	and	a,#15
8523  196d a103          	cp	a,#3
8524  196f 260b          	jrne	L3173
8525                     ; 1779 			ee_K[2][1]+=10;
8527  1971 ce0022        	ldw	x,_ee_K+10
8528  1974 1c000a        	addw	x,#10
8529  1977 cf0022        	ldw	_ee_K+10,x
8531  197a 2024          	jra	L5073
8532  197c               L3173:
8533                     ; 1781 		else if((mess[9]&0x0f)==0x04)
8535  197c b6c9          	ld	a,_mess+9
8536  197e a40f          	and	a,#15
8537  1980 a104          	cp	a,#4
8538  1982 260b          	jrne	L7173
8539                     ; 1783 			ee_K[2][1]--;
8541  1984 ce0022        	ldw	x,_ee_K+10
8542  1987 1d0001        	subw	x,#1
8543  198a cf0022        	ldw	_ee_K+10,x
8545  198d 2011          	jra	L5073
8546  198f               L7173:
8547                     ; 1785 		else if((mess[9]&0x0f)==0x05)
8549  198f b6c9          	ld	a,_mess+9
8550  1991 a40f          	and	a,#15
8551  1993 a105          	cp	a,#5
8552  1995 2609          	jrne	L5073
8553                     ; 1787 			ee_K[2][1]-=10;
8555  1997 ce0022        	ldw	x,_ee_K+10
8556  199a 1d000a        	subw	x,#10
8557  199d cf0022        	ldw	_ee_K+10,x
8558  19a0               L5073:
8559                     ; 1792 		granee(&ee_K[2][1],10,30000);
8561  19a0 ae7530        	ldw	x,#30000
8562  19a3 89            	pushw	x
8563  19a4 ae000a        	ldw	x,#10
8564  19a7 89            	pushw	x
8565  19a8 ae0022        	ldw	x,#_ee_K+10
8566  19ab cd0021        	call	_granee
8568  19ae 5b04          	addw	sp,#4
8570  19b0 2062          	jra	L1563
8571  19b2               L1073:
8572                     ; 1796 	else if((mess[9]&0xf0)==0x30)
8574  19b2 b6c9          	ld	a,_mess+9
8575  19b4 a4f0          	and	a,#240
8576  19b6 a130          	cp	a,#48
8577  19b8 265a          	jrne	L1563
8578                     ; 1798 		if((mess[9]&0x0f)==0x02)
8580  19ba b6c9          	ld	a,_mess+9
8581  19bc a40f          	and	a,#15
8582  19be a102          	cp	a,#2
8583  19c0 260b          	jrne	L1373
8584                     ; 1800 			ee_K[3][1]++;
8586  19c2 ce0026        	ldw	x,_ee_K+14
8587  19c5 1c0001        	addw	x,#1
8588  19c8 cf0026        	ldw	_ee_K+14,x
8590  19cb 2037          	jra	L3373
8591  19cd               L1373:
8592                     ; 1802 		else if((mess[9]&0x0f)==0x03)
8594  19cd b6c9          	ld	a,_mess+9
8595  19cf a40f          	and	a,#15
8596  19d1 a103          	cp	a,#3
8597  19d3 260b          	jrne	L5373
8598                     ; 1804 			ee_K[3][1]+=10;
8600  19d5 ce0026        	ldw	x,_ee_K+14
8601  19d8 1c000a        	addw	x,#10
8602  19db cf0026        	ldw	_ee_K+14,x
8604  19de 2024          	jra	L3373
8605  19e0               L5373:
8606                     ; 1806 		else if((mess[9]&0x0f)==0x04)
8608  19e0 b6c9          	ld	a,_mess+9
8609  19e2 a40f          	and	a,#15
8610  19e4 a104          	cp	a,#4
8611  19e6 260b          	jrne	L1473
8612                     ; 1808 			ee_K[3][1]--;
8614  19e8 ce0026        	ldw	x,_ee_K+14
8615  19eb 1d0001        	subw	x,#1
8616  19ee cf0026        	ldw	_ee_K+14,x
8618  19f1 2011          	jra	L3373
8619  19f3               L1473:
8620                     ; 1810 		else if((mess[9]&0x0f)==0x05)
8622  19f3 b6c9          	ld	a,_mess+9
8623  19f5 a40f          	and	a,#15
8624  19f7 a105          	cp	a,#5
8625  19f9 2609          	jrne	L3373
8626                     ; 1812 			ee_K[3][1]-=10;
8628  19fb ce0026        	ldw	x,_ee_K+14
8629  19fe 1d000a        	subw	x,#10
8630  1a01 cf0026        	ldw	_ee_K+14,x
8631  1a04               L3373:
8632                     ; 1814 		granee(&ee_K[3][1],300,517);									
8634  1a04 ae0205        	ldw	x,#517
8635  1a07 89            	pushw	x
8636  1a08 ae012c        	ldw	x,#300
8637  1a0b 89            	pushw	x
8638  1a0c ae0026        	ldw	x,#_ee_K+14
8639  1a0f cd0021        	call	_granee
8641  1a12 5b04          	addw	sp,#4
8642  1a14               L1563:
8643                     ; 1817 	link_cnt=0;
8645  1a14 3f5e          	clr	_link_cnt
8646                     ; 1818      link=ON;
8648  1a16 3555005f      	mov	_link,#85
8649                     ; 1819      if(res_fl_)
8651  1a1a 725d0008      	tnz	_res_fl_
8652  1a1e 2603          	jrne	L222
8653  1a20 cc1d3b        	jp	L7353
8654  1a23               L222:
8655                     ; 1821       	res_fl_=0;
8657  1a23 4f            	clr	a
8658  1a24 ae0008        	ldw	x,#_res_fl_
8659  1a27 cd0000        	call	c_eewrc
8661  1a2a ac3b1d3b      	jpf	L7353
8662  1a2e               L3263:
8663                     ; 1827 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8665  1a2e b6c6          	ld	a,_mess+6
8666  1a30 a1ff          	cp	a,#255
8667  1a32 2703          	jreq	L422
8668  1a34 cc1ac2        	jp	L3573
8669  1a37               L422:
8671  1a37 b6c7          	ld	a,_mess+7
8672  1a39 a1ff          	cp	a,#255
8673  1a3b 2703          	jreq	L622
8674  1a3d cc1ac2        	jp	L3573
8675  1a40               L622:
8677  1a40 b6c8          	ld	a,_mess+8
8678  1a42 a162          	cp	a,#98
8679  1a44 267c          	jrne	L3573
8680                     ; 1830 	tempSS=mess[9]+(mess[10]*256);
8682  1a46 b6ca          	ld	a,_mess+10
8683  1a48 5f            	clrw	x
8684  1a49 97            	ld	xl,a
8685  1a4a 4f            	clr	a
8686  1a4b 02            	rlwa	x,a
8687  1a4c 01            	rrwa	x,a
8688  1a4d bbc9          	add	a,_mess+9
8689  1a4f 2401          	jrnc	L271
8690  1a51 5c            	incw	x
8691  1a52               L271:
8692  1a52 02            	rlwa	x,a
8693  1a53 1f04          	ldw	(OFST-1,sp),x
8694  1a55 01            	rrwa	x,a
8695                     ; 1831 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8697  1a56 ce0012        	ldw	x,_ee_Umax
8698  1a59 1304          	cpw	x,(OFST-1,sp)
8699  1a5b 270a          	jreq	L5573
8702  1a5d 1e04          	ldw	x,(OFST-1,sp)
8703  1a5f 89            	pushw	x
8704  1a60 ae0012        	ldw	x,#_ee_Umax
8705  1a63 cd0000        	call	c_eewrw
8707  1a66 85            	popw	x
8708  1a67               L5573:
8709                     ; 1832 	tempSS=mess[11]+(mess[12]*256);
8711  1a67 b6cc          	ld	a,_mess+12
8712  1a69 5f            	clrw	x
8713  1a6a 97            	ld	xl,a
8714  1a6b 4f            	clr	a
8715  1a6c 02            	rlwa	x,a
8716  1a6d 01            	rrwa	x,a
8717  1a6e bbcb          	add	a,_mess+11
8718  1a70 2401          	jrnc	L471
8719  1a72 5c            	incw	x
8720  1a73               L471:
8721  1a73 02            	rlwa	x,a
8722  1a74 1f04          	ldw	(OFST-1,sp),x
8723  1a76 01            	rrwa	x,a
8724                     ; 1833 	if(ee_dU!=tempSS) ee_dU=tempSS;
8726  1a77 ce0010        	ldw	x,_ee_dU
8727  1a7a 1304          	cpw	x,(OFST-1,sp)
8728  1a7c 270a          	jreq	L7573
8731  1a7e 1e04          	ldw	x,(OFST-1,sp)
8732  1a80 89            	pushw	x
8733  1a81 ae0010        	ldw	x,#_ee_dU
8734  1a84 cd0000        	call	c_eewrw
8736  1a87 85            	popw	x
8737  1a88               L7573:
8738                     ; 1834 	if((mess[13]&0x0f)==0x5)
8740  1a88 b6cd          	ld	a,_mess+13
8741  1a8a a40f          	and	a,#15
8742  1a8c a105          	cp	a,#5
8743  1a8e 261a          	jrne	L1673
8744                     ; 1836 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8746  1a90 ce0004        	ldw	x,_ee_AVT_MODE
8747  1a93 a30055        	cpw	x,#85
8748  1a96 2603          	jrne	L032
8749  1a98 cc1d3b        	jp	L7353
8750  1a9b               L032:
8753  1a9b ae0055        	ldw	x,#85
8754  1a9e 89            	pushw	x
8755  1a9f ae0004        	ldw	x,#_ee_AVT_MODE
8756  1aa2 cd0000        	call	c_eewrw
8758  1aa5 85            	popw	x
8759  1aa6 ac3b1d3b      	jpf	L7353
8760  1aaa               L1673:
8761                     ; 1838 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8763  1aaa ce0004        	ldw	x,_ee_AVT_MODE
8764  1aad a30055        	cpw	x,#85
8765  1ab0 2703          	jreq	L232
8766  1ab2 cc1d3b        	jp	L7353
8767  1ab5               L232:
8770  1ab5 5f            	clrw	x
8771  1ab6 89            	pushw	x
8772  1ab7 ae0004        	ldw	x,#_ee_AVT_MODE
8773  1aba cd0000        	call	c_eewrw
8775  1abd 85            	popw	x
8776  1abe ac3b1d3b      	jpf	L7353
8777  1ac2               L3573:
8778                     ; 1841 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8780  1ac2 b6c6          	ld	a,_mess+6
8781  1ac4 a1ff          	cp	a,#255
8782  1ac6 2703          	jreq	L432
8783  1ac8 cc1b99        	jp	L3773
8784  1acb               L432:
8786  1acb b6c7          	ld	a,_mess+7
8787  1acd a1ff          	cp	a,#255
8788  1acf 2703          	jreq	L632
8789  1ad1 cc1b99        	jp	L3773
8790  1ad4               L632:
8792  1ad4 b6c8          	ld	a,_mess+8
8793  1ad6 a126          	cp	a,#38
8794  1ad8 2709          	jreq	L5773
8796  1ada b6c8          	ld	a,_mess+8
8797  1adc a129          	cp	a,#41
8798  1ade 2703          	jreq	L042
8799  1ae0 cc1b99        	jp	L3773
8800  1ae3               L042:
8801  1ae3               L5773:
8802                     ; 1844 	tempSS=mess[9]+(mess[10]*256);
8804  1ae3 b6ca          	ld	a,_mess+10
8805  1ae5 5f            	clrw	x
8806  1ae6 97            	ld	xl,a
8807  1ae7 4f            	clr	a
8808  1ae8 02            	rlwa	x,a
8809  1ae9 01            	rrwa	x,a
8810  1aea bbc9          	add	a,_mess+9
8811  1aec 2401          	jrnc	L671
8812  1aee 5c            	incw	x
8813  1aef               L671:
8814  1aef 02            	rlwa	x,a
8815  1af0 1f04          	ldw	(OFST-1,sp),x
8816  1af2 01            	rrwa	x,a
8817                     ; 1845 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8819  1af3 ce000e        	ldw	x,_ee_tmax
8820  1af6 1304          	cpw	x,(OFST-1,sp)
8821  1af8 270a          	jreq	L7773
8824  1afa 1e04          	ldw	x,(OFST-1,sp)
8825  1afc 89            	pushw	x
8826  1afd ae000e        	ldw	x,#_ee_tmax
8827  1b00 cd0000        	call	c_eewrw
8829  1b03 85            	popw	x
8830  1b04               L7773:
8831                     ; 1846 	tempSS=mess[11]+(mess[12]*256);
8833  1b04 b6cc          	ld	a,_mess+12
8834  1b06 5f            	clrw	x
8835  1b07 97            	ld	xl,a
8836  1b08 4f            	clr	a
8837  1b09 02            	rlwa	x,a
8838  1b0a 01            	rrwa	x,a
8839  1b0b bbcb          	add	a,_mess+11
8840  1b0d 2401          	jrnc	L002
8841  1b0f 5c            	incw	x
8842  1b10               L002:
8843  1b10 02            	rlwa	x,a
8844  1b11 1f04          	ldw	(OFST-1,sp),x
8845  1b13 01            	rrwa	x,a
8846                     ; 1847 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8848  1b14 ce000c        	ldw	x,_ee_tsign
8849  1b17 1304          	cpw	x,(OFST-1,sp)
8850  1b19 270a          	jreq	L1004
8853  1b1b 1e04          	ldw	x,(OFST-1,sp)
8854  1b1d 89            	pushw	x
8855  1b1e ae000c        	ldw	x,#_ee_tsign
8856  1b21 cd0000        	call	c_eewrw
8858  1b24 85            	popw	x
8859  1b25               L1004:
8860                     ; 1850 	if(mess[8]==MEM_KF1)
8862  1b25 b6c8          	ld	a,_mess+8
8863  1b27 a126          	cp	a,#38
8864  1b29 2623          	jrne	L3004
8865                     ; 1852 		if(ee_DEVICE!=0)ee_DEVICE=0;
8867  1b2b ce0002        	ldw	x,_ee_DEVICE
8868  1b2e 2709          	jreq	L5004
8871  1b30 5f            	clrw	x
8872  1b31 89            	pushw	x
8873  1b32 ae0002        	ldw	x,#_ee_DEVICE
8874  1b35 cd0000        	call	c_eewrw
8876  1b38 85            	popw	x
8877  1b39               L5004:
8878                     ; 1853 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8880  1b39 b6cd          	ld	a,_mess+13
8881  1b3b 5f            	clrw	x
8882  1b3c 97            	ld	xl,a
8883  1b3d c30014        	cpw	x,_ee_TZAS
8884  1b40 270c          	jreq	L3004
8887  1b42 b6cd          	ld	a,_mess+13
8888  1b44 5f            	clrw	x
8889  1b45 97            	ld	xl,a
8890  1b46 89            	pushw	x
8891  1b47 ae0014        	ldw	x,#_ee_TZAS
8892  1b4a cd0000        	call	c_eewrw
8894  1b4d 85            	popw	x
8895  1b4e               L3004:
8896                     ; 1855 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8898  1b4e b6c8          	ld	a,_mess+8
8899  1b50 a129          	cp	a,#41
8900  1b52 2703          	jreq	L242
8901  1b54 cc1d3b        	jp	L7353
8902  1b57               L242:
8903                     ; 1857 		if(ee_DEVICE!=1)ee_DEVICE=1;
8905  1b57 ce0002        	ldw	x,_ee_DEVICE
8906  1b5a a30001        	cpw	x,#1
8907  1b5d 270b          	jreq	L3104
8910  1b5f ae0001        	ldw	x,#1
8911  1b62 89            	pushw	x
8912  1b63 ae0002        	ldw	x,#_ee_DEVICE
8913  1b66 cd0000        	call	c_eewrw
8915  1b69 85            	popw	x
8916  1b6a               L3104:
8917                     ; 1858 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8919  1b6a b6cd          	ld	a,_mess+13
8920  1b6c 5f            	clrw	x
8921  1b6d 97            	ld	xl,a
8922  1b6e c30000        	cpw	x,_ee_IMAXVENT
8923  1b71 270c          	jreq	L5104
8926  1b73 b6cd          	ld	a,_mess+13
8927  1b75 5f            	clrw	x
8928  1b76 97            	ld	xl,a
8929  1b77 89            	pushw	x
8930  1b78 ae0000        	ldw	x,#_ee_IMAXVENT
8931  1b7b cd0000        	call	c_eewrw
8933  1b7e 85            	popw	x
8934  1b7f               L5104:
8935                     ; 1859 			if(ee_TZAS!=3) ee_TZAS=3;
8937  1b7f ce0014        	ldw	x,_ee_TZAS
8938  1b82 a30003        	cpw	x,#3
8939  1b85 2603          	jrne	L442
8940  1b87 cc1d3b        	jp	L7353
8941  1b8a               L442:
8944  1b8a ae0003        	ldw	x,#3
8945  1b8d 89            	pushw	x
8946  1b8e ae0014        	ldw	x,#_ee_TZAS
8947  1b91 cd0000        	call	c_eewrw
8949  1b94 85            	popw	x
8950  1b95 ac3b1d3b      	jpf	L7353
8951  1b99               L3773:
8952                     ; 1863 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8954  1b99 b6c6          	ld	a,_mess+6
8955  1b9b c10001        	cp	a,_adress
8956  1b9e 262d          	jrne	L3204
8958  1ba0 b6c7          	ld	a,_mess+7
8959  1ba2 c10001        	cp	a,_adress
8960  1ba5 2626          	jrne	L3204
8962  1ba7 b6c8          	ld	a,_mess+8
8963  1ba9 a116          	cp	a,#22
8964  1bab 2620          	jrne	L3204
8966  1bad b6c9          	ld	a,_mess+9
8967  1baf a163          	cp	a,#99
8968  1bb1 261a          	jrne	L3204
8969                     ; 1865 	flags&=0b11100001;
8971  1bb3 b60a          	ld	a,_flags
8972  1bb5 a4e1          	and	a,#225
8973  1bb7 b70a          	ld	_flags,a
8974                     ; 1866 	tsign_cnt=0;
8976  1bb9 5f            	clrw	x
8977  1bba bf4a          	ldw	_tsign_cnt,x
8978                     ; 1867 	tmax_cnt=0;
8980  1bbc 5f            	clrw	x
8981  1bbd bf48          	ldw	_tmax_cnt,x
8982                     ; 1868 	umax_cnt=0;
8984  1bbf 5f            	clrw	x
8985  1bc0 bf62          	ldw	_umax_cnt,x
8986                     ; 1869 	umin_cnt=0;
8988  1bc2 5f            	clrw	x
8989  1bc3 bf60          	ldw	_umin_cnt,x
8990                     ; 1870 	led_drv_cnt=30;
8992  1bc5 351e0019      	mov	_led_drv_cnt,#30
8994  1bc9 ac3b1d3b      	jpf	L7353
8995  1bcd               L3204:
8996                     ; 1872 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8998  1bcd b6c6          	ld	a,_mess+6
8999  1bcf a1ff          	cp	a,#255
9000  1bd1 265f          	jrne	L7204
9002  1bd3 b6c7          	ld	a,_mess+7
9003  1bd5 a1ff          	cp	a,#255
9004  1bd7 2659          	jrne	L7204
9006  1bd9 b6c8          	ld	a,_mess+8
9007  1bdb a116          	cp	a,#22
9008  1bdd 2653          	jrne	L7204
9010  1bdf b6c9          	ld	a,_mess+9
9011  1be1 a116          	cp	a,#22
9012  1be3 264d          	jrne	L7204
9013                     ; 1874 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
9015  1be5 b6ca          	ld	a,_mess+10
9016  1be7 a155          	cp	a,#85
9017  1be9 260f          	jrne	L1304
9019  1beb b6cb          	ld	a,_mess+11
9020  1bed a155          	cp	a,#85
9021  1bef 2609          	jrne	L1304
9024  1bf1 be5b          	ldw	x,__x_
9025  1bf3 1c0001        	addw	x,#1
9026  1bf6 bf5b          	ldw	__x_,x
9028  1bf8 2024          	jra	L3304
9029  1bfa               L1304:
9030                     ; 1875 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
9032  1bfa b6ca          	ld	a,_mess+10
9033  1bfc a166          	cp	a,#102
9034  1bfe 260f          	jrne	L5304
9036  1c00 b6cb          	ld	a,_mess+11
9037  1c02 a166          	cp	a,#102
9038  1c04 2609          	jrne	L5304
9041  1c06 be5b          	ldw	x,__x_
9042  1c08 1d0001        	subw	x,#1
9043  1c0b bf5b          	ldw	__x_,x
9045  1c0d 200f          	jra	L3304
9046  1c0f               L5304:
9047                     ; 1876 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
9049  1c0f b6ca          	ld	a,_mess+10
9050  1c11 a177          	cp	a,#119
9051  1c13 2609          	jrne	L3304
9053  1c15 b6cb          	ld	a,_mess+11
9054  1c17 a177          	cp	a,#119
9055  1c19 2603          	jrne	L3304
9058  1c1b 5f            	clrw	x
9059  1c1c bf5b          	ldw	__x_,x
9060  1c1e               L3304:
9061                     ; 1877      gran(&_x_,-XMAX,XMAX);
9063  1c1e ae0019        	ldw	x,#25
9064  1c21 89            	pushw	x
9065  1c22 aeffe7        	ldw	x,#65511
9066  1c25 89            	pushw	x
9067  1c26 ae005b        	ldw	x,#__x_
9068  1c29 cd0000        	call	_gran
9070  1c2c 5b04          	addw	sp,#4
9072  1c2e ac3b1d3b      	jpf	L7353
9073  1c32               L7204:
9074                     ; 1879 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
9076  1c32 b6c6          	ld	a,_mess+6
9077  1c34 c10001        	cp	a,_adress
9078  1c37 2665          	jrne	L5404
9080  1c39 b6c7          	ld	a,_mess+7
9081  1c3b c10001        	cp	a,_adress
9082  1c3e 265e          	jrne	L5404
9084  1c40 b6c8          	ld	a,_mess+8
9085  1c42 a116          	cp	a,#22
9086  1c44 2658          	jrne	L5404
9088  1c46 b6c9          	ld	a,_mess+9
9089  1c48 b1ca          	cp	a,_mess+10
9090  1c4a 2652          	jrne	L5404
9092  1c4c b6c9          	ld	a,_mess+9
9093  1c4e a1ee          	cp	a,#238
9094  1c50 264c          	jrne	L5404
9095                     ; 1881 	rotor_int++;
9097  1c52 be1a          	ldw	x,_rotor_int
9098  1c54 1c0001        	addw	x,#1
9099  1c57 bf1a          	ldw	_rotor_int,x
9100                     ; 1882      tempI=pwm_u;
9102  1c59 be0b          	ldw	x,_pwm_u
9103  1c5b 1f04          	ldw	(OFST-1,sp),x
9104                     ; 1883 	ee_U_AVT=tempI;
9106  1c5d 1e04          	ldw	x,(OFST-1,sp)
9107  1c5f 89            	pushw	x
9108  1c60 ae000a        	ldw	x,#_ee_U_AVT
9109  1c63 cd0000        	call	c_eewrw
9111  1c66 85            	popw	x
9112                     ; 1884 	UU_AVT=Un;
9114  1c67 be69          	ldw	x,_Un
9115  1c69 89            	pushw	x
9116  1c6a ae0006        	ldw	x,#_UU_AVT
9117  1c6d cd0000        	call	c_eewrw
9119  1c70 85            	popw	x
9120                     ; 1885 	delay_ms(100);
9122  1c71 ae0064        	ldw	x,#100
9123  1c74 cd004c        	call	_delay_ms
9125                     ; 1886 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
9127  1c77 ce000a        	ldw	x,_ee_U_AVT
9128  1c7a 1304          	cpw	x,(OFST-1,sp)
9129  1c7c 2703          	jreq	L642
9130  1c7e cc1d3b        	jp	L7353
9131  1c81               L642:
9134  1c81 4b00          	push	#0
9135  1c83 4b00          	push	#0
9136  1c85 4b00          	push	#0
9137  1c87 4b00          	push	#0
9138  1c89 4bdd          	push	#221
9139  1c8b 4bdd          	push	#221
9140  1c8d 4b91          	push	#145
9141  1c8f 3b0001        	push	_adress
9142  1c92 ae018e        	ldw	x,#398
9143  1c95 cd1566        	call	_can_transmit
9145  1c98 5b08          	addw	sp,#8
9146  1c9a ac3b1d3b      	jpf	L7353
9147  1c9e               L5404:
9148                     ; 1891 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9150  1c9e b6c7          	ld	a,_mess+7
9151  1ca0 a1da          	cp	a,#218
9152  1ca2 2652          	jrne	L3504
9154  1ca4 b6c6          	ld	a,_mess+6
9155  1ca6 c10001        	cp	a,_adress
9156  1ca9 274b          	jreq	L3504
9158  1cab b6c6          	ld	a,_mess+6
9159  1cad a106          	cp	a,#6
9160  1caf 2445          	jruge	L3504
9161                     ; 1893 	i_main_bps_cnt[mess[6]]=0;
9163  1cb1 b6c6          	ld	a,_mess+6
9164  1cb3 5f            	clrw	x
9165  1cb4 97            	ld	xl,a
9166  1cb5 6f06          	clr	(_i_main_bps_cnt,x)
9167                     ; 1894 	i_main_flag[mess[6]]=1;
9169  1cb7 b6c6          	ld	a,_mess+6
9170  1cb9 5f            	clrw	x
9171  1cba 97            	ld	xl,a
9172  1cbb a601          	ld	a,#1
9173  1cbd e711          	ld	(_i_main_flag,x),a
9174                     ; 1895 	if(bMAIN)
9176                     	btst	_bMAIN
9177  1cc4 2475          	jruge	L7353
9178                     ; 1897 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9180  1cc6 b6c9          	ld	a,_mess+9
9181  1cc8 5f            	clrw	x
9182  1cc9 97            	ld	xl,a
9183  1cca 4f            	clr	a
9184  1ccb 02            	rlwa	x,a
9185  1ccc 1f01          	ldw	(OFST-4,sp),x
9186  1cce b6c8          	ld	a,_mess+8
9187  1cd0 5f            	clrw	x
9188  1cd1 97            	ld	xl,a
9189  1cd2 72fb01        	addw	x,(OFST-4,sp)
9190  1cd5 b6c6          	ld	a,_mess+6
9191  1cd7 905f          	clrw	y
9192  1cd9 9097          	ld	yl,a
9193  1cdb 9058          	sllw	y
9194  1cdd 90ef17        	ldw	(_i_main,y),x
9195                     ; 1898 		i_main[adress]=I;
9197  1ce0 c60001        	ld	a,_adress
9198  1ce3 5f            	clrw	x
9199  1ce4 97            	ld	xl,a
9200  1ce5 58            	sllw	x
9201  1ce6 90be6b        	ldw	y,_I
9202  1ce9 ef17          	ldw	(_i_main,x),y
9203                     ; 1899      	i_main_flag[adress]=1;
9205  1ceb c60001        	ld	a,_adress
9206  1cee 5f            	clrw	x
9207  1cef 97            	ld	xl,a
9208  1cf0 a601          	ld	a,#1
9209  1cf2 e711          	ld	(_i_main_flag,x),a
9210  1cf4 2045          	jra	L7353
9211  1cf6               L3504:
9212                     ; 1903 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9214  1cf6 b6c7          	ld	a,_mess+7
9215  1cf8 a1db          	cp	a,#219
9216  1cfa 263f          	jrne	L7353
9218  1cfc b6c6          	ld	a,_mess+6
9219  1cfe c10001        	cp	a,_adress
9220  1d01 2738          	jreq	L7353
9222  1d03 b6c6          	ld	a,_mess+6
9223  1d05 a106          	cp	a,#6
9224  1d07 2432          	jruge	L7353
9225                     ; 1905 	i_main_bps_cnt[mess[6]]=0;
9227  1d09 b6c6          	ld	a,_mess+6
9228  1d0b 5f            	clrw	x
9229  1d0c 97            	ld	xl,a
9230  1d0d 6f06          	clr	(_i_main_bps_cnt,x)
9231                     ; 1906 	i_main_flag[mess[6]]=1;		
9233  1d0f b6c6          	ld	a,_mess+6
9234  1d11 5f            	clrw	x
9235  1d12 97            	ld	xl,a
9236  1d13 a601          	ld	a,#1
9237  1d15 e711          	ld	(_i_main_flag,x),a
9238                     ; 1907 	if(bMAIN)
9240                     	btst	_bMAIN
9241  1d1c 241d          	jruge	L7353
9242                     ; 1909 		if(mess[9]==0)i_main_flag[i]=1;
9244  1d1e 3dc9          	tnz	_mess+9
9245  1d20 260a          	jrne	L5604
9248  1d22 7b03          	ld	a,(OFST-2,sp)
9249  1d24 5f            	clrw	x
9250  1d25 97            	ld	xl,a
9251  1d26 a601          	ld	a,#1
9252  1d28 e711          	ld	(_i_main_flag,x),a
9254  1d2a 2006          	jra	L7604
9255  1d2c               L5604:
9256                     ; 1910 		else i_main_flag[i]=0;
9258  1d2c 7b03          	ld	a,(OFST-2,sp)
9259  1d2e 5f            	clrw	x
9260  1d2f 97            	ld	xl,a
9261  1d30 6f11          	clr	(_i_main_flag,x)
9262  1d32               L7604:
9263                     ; 1911 		i_main_flag[adress]=1;
9265  1d32 c60001        	ld	a,_adress
9266  1d35 5f            	clrw	x
9267  1d36 97            	ld	xl,a
9268  1d37 a601          	ld	a,#1
9269  1d39 e711          	ld	(_i_main_flag,x),a
9270  1d3b               L7353:
9271                     ; 1917 can_in_an_end:
9271                     ; 1918 bCAN_RX=0;
9273  1d3b 3f09          	clr	_bCAN_RX
9274                     ; 1919 }   
9277  1d3d 5b05          	addw	sp,#5
9278  1d3f 81            	ret
9301                     ; 1922 void t4_init(void){
9302                     	switch	.text
9303  1d40               _t4_init:
9307                     ; 1923 	TIM4->PSCR = 4;
9309  1d40 35045345      	mov	21317,#4
9310                     ; 1924 	TIM4->ARR= 77;
9312  1d44 354d5346      	mov	21318,#77
9313                     ; 1925 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9315  1d48 72105341      	bset	21313,#0
9316                     ; 1927 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9318  1d4c 35855340      	mov	21312,#133
9319                     ; 1929 }
9322  1d50 81            	ret
9345                     ; 1932 void t1_init(void)
9345                     ; 1933 {
9346                     	switch	.text
9347  1d51               _t1_init:
9351                     ; 1934 TIM1->ARRH= 0x03;
9353  1d51 35035262      	mov	21090,#3
9354                     ; 1935 TIM1->ARRL= 0xff;
9356  1d55 35ff5263      	mov	21091,#255
9357                     ; 1936 TIM1->CCR1H= 0x00;	
9359  1d59 725f5265      	clr	21093
9360                     ; 1937 TIM1->CCR1L= 0xff;
9362  1d5d 35ff5266      	mov	21094,#255
9363                     ; 1938 TIM1->CCR2H= 0x00;	
9365  1d61 725f5267      	clr	21095
9366                     ; 1939 TIM1->CCR2L= 0x00;
9368  1d65 725f5268      	clr	21096
9369                     ; 1940 TIM1->CCR3H= 0x00;	
9371  1d69 725f5269      	clr	21097
9372                     ; 1941 TIM1->CCR3L= 0x64;
9374  1d6d 3564526a      	mov	21098,#100
9375                     ; 1943 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9377  1d71 35685258      	mov	21080,#104
9378                     ; 1944 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9380  1d75 35685259      	mov	21081,#104
9381                     ; 1945 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9383  1d79 3568525a      	mov	21082,#104
9384                     ; 1946 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9386  1d7d 3511525c      	mov	21084,#17
9387                     ; 1947 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9389  1d81 3501525d      	mov	21085,#1
9390                     ; 1948 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9392  1d85 35815250      	mov	21072,#129
9393                     ; 1949 TIM1->BKR|= TIM1_BKR_AOE;
9395  1d89 721c526d      	bset	21101,#6
9396                     ; 1950 }
9399  1d8d 81            	ret
9424                     ; 1954 void adc2_init(void)
9424                     ; 1955 {
9425                     	switch	.text
9426  1d8e               _adc2_init:
9430                     ; 1956 adc_plazma[0]++;
9432  1d8e beb2          	ldw	x,_adc_plazma
9433  1d90 1c0001        	addw	x,#1
9434  1d93 bfb2          	ldw	_adc_plazma,x
9435                     ; 1980 GPIOB->DDR&=~(1<<4);
9437  1d95 72195007      	bres	20487,#4
9438                     ; 1981 GPIOB->CR1&=~(1<<4);
9440  1d99 72195008      	bres	20488,#4
9441                     ; 1982 GPIOB->CR2&=~(1<<4);
9443  1d9d 72195009      	bres	20489,#4
9444                     ; 1984 GPIOB->DDR&=~(1<<5);
9446  1da1 721b5007      	bres	20487,#5
9447                     ; 1985 GPIOB->CR1&=~(1<<5);
9449  1da5 721b5008      	bres	20488,#5
9450                     ; 1986 GPIOB->CR2&=~(1<<5);
9452  1da9 721b5009      	bres	20489,#5
9453                     ; 1988 GPIOB->DDR&=~(1<<6);
9455  1dad 721d5007      	bres	20487,#6
9456                     ; 1989 GPIOB->CR1&=~(1<<6);
9458  1db1 721d5008      	bres	20488,#6
9459                     ; 1990 GPIOB->CR2&=~(1<<6);
9461  1db5 721d5009      	bres	20489,#6
9462                     ; 1992 GPIOB->DDR&=~(1<<7);
9464  1db9 721f5007      	bres	20487,#7
9465                     ; 1993 GPIOB->CR1&=~(1<<7);
9467  1dbd 721f5008      	bres	20488,#7
9468                     ; 1994 GPIOB->CR2&=~(1<<7);
9470  1dc1 721f5009      	bres	20489,#7
9471                     ; 2004 ADC2->TDRL=0xff;
9473  1dc5 35ff5407      	mov	21511,#255
9474                     ; 2006 ADC2->CR2=0x08;
9476  1dc9 35085402      	mov	21506,#8
9477                     ; 2007 ADC2->CR1=0x40;
9479  1dcd 35405401      	mov	21505,#64
9480                     ; 2010 	ADC2->CSR=0x20+adc_ch+3;
9482  1dd1 b6bf          	ld	a,_adc_ch
9483  1dd3 ab23          	add	a,#35
9484  1dd5 c75400        	ld	21504,a
9485                     ; 2012 	ADC2->CR1|=1;
9487  1dd8 72105401      	bset	21505,#0
9488                     ; 2013 	ADC2->CR1|=1;
9490  1ddc 72105401      	bset	21505,#0
9491                     ; 2016 adc_plazma[1]=adc_ch;
9493  1de0 b6bf          	ld	a,_adc_ch
9494  1de2 5f            	clrw	x
9495  1de3 97            	ld	xl,a
9496  1de4 bfb4          	ldw	_adc_plazma+2,x
9497                     ; 2017 }
9500  1de6 81            	ret
9534                     ; 2026 @far @interrupt void TIM4_UPD_Interrupt (void) 
9534                     ; 2027 {
9536                     	switch	.text
9537  1de7               f_TIM4_UPD_Interrupt:
9541                     ; 2028 TIM4->SR1&=~TIM4_SR1_UIF;
9543  1de7 72115342      	bres	21314,#0
9544                     ; 2030 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9546  1deb 3c05          	inc	_pwm_vent_cnt
9547  1ded b605          	ld	a,_pwm_vent_cnt
9548  1def a10a          	cp	a,#10
9549  1df1 2502          	jrult	L1314
9552  1df3 3f05          	clr	_pwm_vent_cnt
9553  1df5               L1314:
9554                     ; 2031 GPIOB->ODR|=(1<<3);
9556  1df5 72165005      	bset	20485,#3
9557                     ; 2032 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9559  1df9 b605          	ld	a,_pwm_vent_cnt
9560  1dfb a105          	cp	a,#5
9561  1dfd 2504          	jrult	L3314
9564  1dff 72175005      	bres	20485,#3
9565  1e03               L3314:
9566                     ; 2037 if(++t0_cnt0>=100)
9568  1e03 9c            	rvf
9569  1e04 be00          	ldw	x,_t0_cnt0
9570  1e06 1c0001        	addw	x,#1
9571  1e09 bf00          	ldw	_t0_cnt0,x
9572  1e0b a30064        	cpw	x,#100
9573  1e0e 2f3f          	jrslt	L5314
9574                     ; 2039 	t0_cnt0=0;
9576  1e10 5f            	clrw	x
9577  1e11 bf00          	ldw	_t0_cnt0,x
9578                     ; 2040 	b100Hz=1;
9580  1e13 72100008      	bset	_b100Hz
9581                     ; 2042 	if(++t0_cnt1>=10)
9583  1e17 3c02          	inc	_t0_cnt1
9584  1e19 b602          	ld	a,_t0_cnt1
9585  1e1b a10a          	cp	a,#10
9586  1e1d 2506          	jrult	L7314
9587                     ; 2044 		t0_cnt1=0;
9589  1e1f 3f02          	clr	_t0_cnt1
9590                     ; 2045 		b10Hz=1;
9592  1e21 72100007      	bset	_b10Hz
9593  1e25               L7314:
9594                     ; 2048 	if(++t0_cnt2>=20)
9596  1e25 3c03          	inc	_t0_cnt2
9597  1e27 b603          	ld	a,_t0_cnt2
9598  1e29 a114          	cp	a,#20
9599  1e2b 2506          	jrult	L1414
9600                     ; 2050 		t0_cnt2=0;
9602  1e2d 3f03          	clr	_t0_cnt2
9603                     ; 2051 		b5Hz=1;
9605  1e2f 72100006      	bset	_b5Hz
9606  1e33               L1414:
9607                     ; 2055 	if(++t0_cnt4>=50)
9609  1e33 3c05          	inc	_t0_cnt4
9610  1e35 b605          	ld	a,_t0_cnt4
9611  1e37 a132          	cp	a,#50
9612  1e39 2506          	jrult	L3414
9613                     ; 2057 		t0_cnt4=0;
9615  1e3b 3f05          	clr	_t0_cnt4
9616                     ; 2058 		b2Hz=1;
9618  1e3d 72100005      	bset	_b2Hz
9619  1e41               L3414:
9620                     ; 2061 	if(++t0_cnt3>=100)
9622  1e41 3c04          	inc	_t0_cnt3
9623  1e43 b604          	ld	a,_t0_cnt3
9624  1e45 a164          	cp	a,#100
9625  1e47 2506          	jrult	L5314
9626                     ; 2063 		t0_cnt3=0;
9628  1e49 3f04          	clr	_t0_cnt3
9629                     ; 2064 		b1Hz=1;
9631  1e4b 72100004      	bset	_b1Hz
9632  1e4f               L5314:
9633                     ; 2070 }
9636  1e4f 80            	iret
9661                     ; 2073 @far @interrupt void CAN_RX_Interrupt (void) 
9661                     ; 2074 {
9662                     	switch	.text
9663  1e50               f_CAN_RX_Interrupt:
9667                     ; 2076 CAN->PSR= 7;									// page 7 - read messsage
9669  1e50 35075427      	mov	21543,#7
9670                     ; 2078 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9672  1e54 ae000e        	ldw	x,#14
9673  1e57               L262:
9674  1e57 d65427        	ld	a,(21543,x)
9675  1e5a e7bf          	ld	(_mess-1,x),a
9676  1e5c 5a            	decw	x
9677  1e5d 26f8          	jrne	L262
9678                     ; 2089 bCAN_RX=1;
9680  1e5f 35010009      	mov	_bCAN_RX,#1
9681                     ; 2090 CAN->RFR|=(1<<5);
9683  1e63 721a5424      	bset	21540,#5
9684                     ; 2092 }
9687  1e67 80            	iret
9710                     ; 2095 @far @interrupt void CAN_TX_Interrupt (void) 
9710                     ; 2096 {
9711                     	switch	.text
9712  1e68               f_CAN_TX_Interrupt:
9716                     ; 2097 if((CAN->TSR)&(1<<0))
9718  1e68 c65422        	ld	a,21538
9719  1e6b a501          	bcp	a,#1
9720  1e6d 2708          	jreq	L7614
9721                     ; 2099 	bTX_FREE=1;	
9723  1e6f 35010008      	mov	_bTX_FREE,#1
9724                     ; 2101 	CAN->TSR|=(1<<0);
9726  1e73 72105422      	bset	21538,#0
9727  1e77               L7614:
9728                     ; 2103 }
9731  1e77 80            	iret
9789                     ; 2106 @far @interrupt void ADC2_EOC_Interrupt (void) {
9790                     	switch	.text
9791  1e78               f_ADC2_EOC_Interrupt:
9793       00000009      OFST:	set	9
9794  1e78 be00          	ldw	x,c_x
9795  1e7a 89            	pushw	x
9796  1e7b be00          	ldw	x,c_y
9797  1e7d 89            	pushw	x
9798  1e7e be02          	ldw	x,c_lreg+2
9799  1e80 89            	pushw	x
9800  1e81 be00          	ldw	x,c_lreg
9801  1e83 89            	pushw	x
9802  1e84 5209          	subw	sp,#9
9805                     ; 2111 adc_plazma[2]++;
9807  1e86 beb6          	ldw	x,_adc_plazma+4
9808  1e88 1c0001        	addw	x,#1
9809  1e8b bfb6          	ldw	_adc_plazma+4,x
9810                     ; 2118 ADC2->CSR&=~(1<<7);
9812  1e8d 721f5400      	bres	21504,#7
9813                     ; 2120 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9815  1e91 c65405        	ld	a,21509
9816  1e94 b703          	ld	c_lreg+3,a
9817  1e96 3f02          	clr	c_lreg+2
9818  1e98 3f01          	clr	c_lreg+1
9819  1e9a 3f00          	clr	c_lreg
9820  1e9c 96            	ldw	x,sp
9821  1e9d 1c0001        	addw	x,#OFST-8
9822  1ea0 cd0000        	call	c_rtol
9824  1ea3 c65404        	ld	a,21508
9825  1ea6 5f            	clrw	x
9826  1ea7 97            	ld	xl,a
9827  1ea8 90ae0100      	ldw	y,#256
9828  1eac cd0000        	call	c_umul
9830  1eaf 96            	ldw	x,sp
9831  1eb0 1c0001        	addw	x,#OFST-8
9832  1eb3 cd0000        	call	c_ladd
9834  1eb6 96            	ldw	x,sp
9835  1eb7 1c0006        	addw	x,#OFST-3
9836  1eba cd0000        	call	c_rtol
9838                     ; 2125 if(adr_drv_stat==1)
9840  1ebd b607          	ld	a,_adr_drv_stat
9841  1ebf a101          	cp	a,#1
9842  1ec1 260b          	jrne	L7124
9843                     ; 2127 	adr_drv_stat=2;
9845  1ec3 35020007      	mov	_adr_drv_stat,#2
9846                     ; 2128 	adc_buff_[0]=temp_adc;
9848  1ec7 1e08          	ldw	x,(OFST-1,sp)
9849  1ec9 cf0005        	ldw	_adc_buff_,x
9851  1ecc 2020          	jra	L1224
9852  1ece               L7124:
9853                     ; 2131 else if(adr_drv_stat==3)
9855  1ece b607          	ld	a,_adr_drv_stat
9856  1ed0 a103          	cp	a,#3
9857  1ed2 260b          	jrne	L3224
9858                     ; 2133 	adr_drv_stat=4;
9860  1ed4 35040007      	mov	_adr_drv_stat,#4
9861                     ; 2134 	adc_buff_[1]=temp_adc;
9863  1ed8 1e08          	ldw	x,(OFST-1,sp)
9864  1eda cf0007        	ldw	_adc_buff_+2,x
9866  1edd 200f          	jra	L1224
9867  1edf               L3224:
9868                     ; 2137 else if(adr_drv_stat==5)
9870  1edf b607          	ld	a,_adr_drv_stat
9871  1ee1 a105          	cp	a,#5
9872  1ee3 2609          	jrne	L1224
9873                     ; 2139 	adr_drv_stat=6;
9875  1ee5 35060007      	mov	_adr_drv_stat,#6
9876                     ; 2140 	adc_buff_[9]=temp_adc;
9878  1ee9 1e08          	ldw	x,(OFST-1,sp)
9879  1eeb cf0017        	ldw	_adc_buff_+18,x
9880  1eee               L1224:
9881                     ; 2143 adc_buff[adc_ch][adc_cnt]=temp_adc;
9883  1eee b6be          	ld	a,_adc_cnt
9884  1ef0 5f            	clrw	x
9885  1ef1 97            	ld	xl,a
9886  1ef2 58            	sllw	x
9887  1ef3 1f03          	ldw	(OFST-6,sp),x
9888  1ef5 b6bf          	ld	a,_adc_ch
9889  1ef7 97            	ld	xl,a
9890  1ef8 a620          	ld	a,#32
9891  1efa 42            	mul	x,a
9892  1efb 72fb03        	addw	x,(OFST-6,sp)
9893  1efe 1608          	ldw	y,(OFST-1,sp)
9894  1f00 df0019        	ldw	(_adc_buff,x),y
9895                     ; 2149 adc_ch++;
9897  1f03 3cbf          	inc	_adc_ch
9898                     ; 2150 if(adc_ch>=5)
9900  1f05 b6bf          	ld	a,_adc_ch
9901  1f07 a105          	cp	a,#5
9902  1f09 250c          	jrult	L1324
9903                     ; 2153 	adc_ch=0;
9905  1f0b 3fbf          	clr	_adc_ch
9906                     ; 2154 	adc_cnt++;
9908  1f0d 3cbe          	inc	_adc_cnt
9909                     ; 2155 	if(adc_cnt>=16)
9911  1f0f b6be          	ld	a,_adc_cnt
9912  1f11 a110          	cp	a,#16
9913  1f13 2502          	jrult	L1324
9914                     ; 2157 		adc_cnt=0;
9916  1f15 3fbe          	clr	_adc_cnt
9917  1f17               L1324:
9918                     ; 2161 if((adc_cnt&0x03)==0)
9920  1f17 b6be          	ld	a,_adc_cnt
9921  1f19 a503          	bcp	a,#3
9922  1f1b 264b          	jrne	L5324
9923                     ; 2165 	tempSS=0;
9925  1f1d ae0000        	ldw	x,#0
9926  1f20 1f08          	ldw	(OFST-1,sp),x
9927  1f22 ae0000        	ldw	x,#0
9928  1f25 1f06          	ldw	(OFST-3,sp),x
9929                     ; 2166 	for(i=0;i<16;i++)
9931  1f27 0f05          	clr	(OFST-4,sp)
9932  1f29               L7324:
9933                     ; 2168 		tempSS+=(signed long)adc_buff[adc_ch][i];
9935  1f29 7b05          	ld	a,(OFST-4,sp)
9936  1f2b 5f            	clrw	x
9937  1f2c 97            	ld	xl,a
9938  1f2d 58            	sllw	x
9939  1f2e 1f03          	ldw	(OFST-6,sp),x
9940  1f30 b6bf          	ld	a,_adc_ch
9941  1f32 97            	ld	xl,a
9942  1f33 a620          	ld	a,#32
9943  1f35 42            	mul	x,a
9944  1f36 72fb03        	addw	x,(OFST-6,sp)
9945  1f39 de0019        	ldw	x,(_adc_buff,x)
9946  1f3c cd0000        	call	c_itolx
9948  1f3f 96            	ldw	x,sp
9949  1f40 1c0006        	addw	x,#OFST-3
9950  1f43 cd0000        	call	c_lgadd
9952                     ; 2166 	for(i=0;i<16;i++)
9954  1f46 0c05          	inc	(OFST-4,sp)
9957  1f48 7b05          	ld	a,(OFST-4,sp)
9958  1f4a a110          	cp	a,#16
9959  1f4c 25db          	jrult	L7324
9960                     ; 2170 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9962  1f4e 96            	ldw	x,sp
9963  1f4f 1c0006        	addw	x,#OFST-3
9964  1f52 cd0000        	call	c_ltor
9966  1f55 a604          	ld	a,#4
9967  1f57 cd0000        	call	c_lrsh
9969  1f5a be02          	ldw	x,c_lreg+2
9970  1f5c b6bf          	ld	a,_adc_ch
9971  1f5e 905f          	clrw	y
9972  1f60 9097          	ld	yl,a
9973  1f62 9058          	sllw	y
9974  1f64 90df0005      	ldw	(_adc_buff_,y),x
9975  1f68               L5324:
9976                     ; 2181 adc_plazma_short++;
9978  1f68 bebc          	ldw	x,_adc_plazma_short
9979  1f6a 1c0001        	addw	x,#1
9980  1f6d bfbc          	ldw	_adc_plazma_short,x
9981                     ; 2196 }
9984  1f6f 5b09          	addw	sp,#9
9985  1f71 85            	popw	x
9986  1f72 bf00          	ldw	c_lreg,x
9987  1f74 85            	popw	x
9988  1f75 bf02          	ldw	c_lreg+2,x
9989  1f77 85            	popw	x
9990  1f78 bf00          	ldw	c_y,x
9991  1f7a 85            	popw	x
9992  1f7b bf00          	ldw	c_x,x
9993  1f7d 80            	iret
10056                     ; 2204 main()
10056                     ; 2205 {
10058                     	switch	.text
10059  1f7e               _main:
10063                     ; 2207 CLK->ECKR|=1;
10065  1f7e 721050c1      	bset	20673,#0
10067  1f82               L7524:
10068                     ; 2208 while((CLK->ECKR & 2) == 0);
10070  1f82 c650c1        	ld	a,20673
10071  1f85 a502          	bcp	a,#2
10072  1f87 27f9          	jreq	L7524
10073                     ; 2209 CLK->SWCR|=2;
10075  1f89 721250c5      	bset	20677,#1
10076                     ; 2210 CLK->SWR=0xB4;
10078  1f8d 35b450c4      	mov	20676,#180
10079                     ; 2211 BLOCK_INIT
10081  1f91 72145007      	bset	20487,#2
10084  1f95 72145008      	bset	20488,#2
10087  1f99 72155009      	bres	20489,#2
10088                     ; 2212 BLOCK_ON
10090  1f9d 72145005      	bset	20485,#2
10091                     ; 2214 delay_ms(200);
10093  1fa1 ae00c8        	ldw	x,#200
10094  1fa4 cd004c        	call	_delay_ms
10096                     ; 2215 FLASH_DUKR=0xae;
10098  1fa7 35ae5064      	mov	_FLASH_DUKR,#174
10099                     ; 2216 FLASH_DUKR=0x56;
10101  1fab 35565064      	mov	_FLASH_DUKR,#86
10102                     ; 2217 enableInterrupts();
10105  1faf 9a            rim
10107                     ; 2240 adr_drv_v4();
10110  1fb0 cd1242        	call	_adr_drv_v4
10112                     ; 2244 t4_init();
10114  1fb3 cd1d40        	call	_t4_init
10116                     ; 2246 		GPIOG->DDR|=(1<<0);
10118  1fb6 72105020      	bset	20512,#0
10119                     ; 2247 		GPIOG->CR1|=(1<<0);
10121  1fba 72105021      	bset	20513,#0
10122                     ; 2248 		GPIOG->CR2&=~(1<<0);	
10124  1fbe 72115022      	bres	20514,#0
10125                     ; 2251 		GPIOG->DDR&=~(1<<1);
10127  1fc2 72135020      	bres	20512,#1
10128                     ; 2252 		GPIOG->CR1|=(1<<1);
10130  1fc6 72125021      	bset	20513,#1
10131                     ; 2253 		GPIOG->CR2&=~(1<<1);
10133  1fca 72135022      	bres	20514,#1
10134                     ; 2255 init_CAN();
10136  1fce cd14f7        	call	_init_CAN
10138                     ; 2260 GPIOC->DDR|=(1<<1);
10140  1fd1 7212500c      	bset	20492,#1
10141                     ; 2261 GPIOC->CR1|=(1<<1);
10143  1fd5 7212500d      	bset	20493,#1
10144                     ; 2262 GPIOC->CR2|=(1<<1);
10146  1fd9 7212500e      	bset	20494,#1
10147                     ; 2264 GPIOC->DDR|=(1<<2);
10149  1fdd 7214500c      	bset	20492,#2
10150                     ; 2265 GPIOC->CR1|=(1<<2);
10152  1fe1 7214500d      	bset	20493,#2
10153                     ; 2266 GPIOC->CR2|=(1<<2);
10155  1fe5 7214500e      	bset	20494,#2
10156                     ; 2273 t1_init();
10158  1fe9 cd1d51        	call	_t1_init
10160                     ; 2275 GPIOA->DDR|=(1<<5);
10162  1fec 721a5002      	bset	20482,#5
10163                     ; 2276 GPIOA->CR1|=(1<<5);
10165  1ff0 721a5003      	bset	20483,#5
10166                     ; 2277 GPIOA->CR2&=~(1<<5);
10168  1ff4 721b5004      	bres	20484,#5
10169                     ; 2283 GPIOB->DDR|=(1<<3);
10171  1ff8 72165007      	bset	20487,#3
10172                     ; 2284 GPIOB->CR1|=(1<<3);
10174  1ffc 72165008      	bset	20488,#3
10175                     ; 2285 GPIOB->CR2|=(1<<3);
10177  2000 72165009      	bset	20489,#3
10178                     ; 2287 GPIOC->DDR|=(1<<3);
10180  2004 7216500c      	bset	20492,#3
10181                     ; 2288 GPIOC->CR1|=(1<<3);
10183  2008 7216500d      	bset	20493,#3
10184                     ; 2289 GPIOC->CR2|=(1<<3);
10186  200c 7216500e      	bset	20494,#3
10187                     ; 2292 if(bps_class==bpsIPS) 
10189  2010 b601          	ld	a,_bps_class
10190  2012 a101          	cp	a,#1
10191  2014 260a          	jrne	L5624
10192                     ; 2294 	pwm_u=ee_U_AVT;
10194  2016 ce000a        	ldw	x,_ee_U_AVT
10195  2019 bf0b          	ldw	_pwm_u,x
10196                     ; 2295 	volum_u_main_=ee_U_AVT;
10198  201b ce000a        	ldw	x,_ee_U_AVT
10199  201e bf1c          	ldw	_volum_u_main_,x
10200  2020               L5624:
10201                     ; 2302 	if(bCAN_RX)
10203  2020 3d09          	tnz	_bCAN_RX
10204  2022 2705          	jreq	L1724
10205                     ; 2304 		bCAN_RX=0;
10207  2024 3f09          	clr	_bCAN_RX
10208                     ; 2305 		can_in_an();	
10210  2026 cd1702        	call	_can_in_an
10212  2029               L1724:
10213                     ; 2307 	if(b100Hz)
10215                     	btst	_b100Hz
10216  202e 241e          	jruge	L3724
10217                     ; 2309 		b100Hz=0;
10219  2030 72110008      	bres	_b100Hz
10220                     ; 2318 		adc2_init();
10222  2034 cd1d8e        	call	_adc2_init
10224                     ; 2319 		can_tx_hndl();
10226  2037 cd15ea        	call	_can_tx_hndl
10228                     ; 2321 		GPIOC->DDR|=(1<<7);
10230  203a 721e500c      	bset	20492,#7
10231                     ; 2322 		GPIOC->CR1|=(1<<7);
10233  203e 721e500d      	bset	20493,#7
10234                     ; 2323 		GPIOC->CR2|=(1<<7);
10236  2042 721e500e      	bset	20494,#7
10237                     ; 2324 		GPIOC->ODR^=(1<<7);
10239  2046 c6500a        	ld	a,20490
10240  2049 a880          	xor	a,	#128
10241  204b c7500a        	ld	20490,a
10242  204e               L3724:
10243                     ; 2327 	if(b10Hz)
10245                     	btst	_b10Hz
10246  2053 2419          	jruge	L5724
10247                     ; 2329 		b10Hz=0;
10249  2055 72110007      	bres	_b10Hz
10250                     ; 2331           matemat();
10252  2059 cd0bf0        	call	_matemat
10254                     ; 2332 	    	led_drv(); 
10256  205c cd0711        	call	_led_drv
10258                     ; 2333 	     link_drv();
10260  205f cd07ff        	call	_link_drv
10262                     ; 2334 	     pwr_hndl();		//вычисление воздействий на силу
10264  2062 cd0ad4        	call	_pwr_hndl
10266                     ; 2335 	     JP_drv();
10268  2065 cd0774        	call	_JP_drv
10270                     ; 2336 	     flags_drv();
10272  2068 cd0fee        	call	_flags_drv
10274                     ; 2337 		net_drv();
10276  206b cd1654        	call	_net_drv
10278  206e               L5724:
10279                     ; 2340 	if(b5Hz)
10281                     	btst	_b5Hz
10282  2073 240d          	jruge	L7724
10283                     ; 2342 		b5Hz=0;
10285  2075 72110006      	bres	_b5Hz
10286                     ; 2344 		pwr_drv();		//воздействие на силу
10288  2079 cd09aa        	call	_pwr_drv
10290                     ; 2345 		led_hndl();
10292  207c cd008e        	call	_led_hndl
10294                     ; 2347 		vent_drv();
10296  207f cd084e        	call	_vent_drv
10298  2082               L7724:
10299                     ; 2350 	if(b2Hz)
10301                     	btst	_b2Hz
10302  2087 2404          	jruge	L1034
10303                     ; 2352 		b2Hz=0;
10305  2089 72110005      	bres	_b2Hz
10306  208d               L1034:
10307                     ; 2361 	if(b1Hz)
10309                     	btst	_b1Hz
10310  2092 248c          	jruge	L5624
10311                     ; 2363 		b1Hz=0;
10313  2094 72110004      	bres	_b1Hz
10314                     ; 2365 		temper_drv();			//вычисление аварий температуры
10316  2098 cd0d1e        	call	_temper_drv
10318                     ; 2366 		u_drv();
10320  209b cd0df5        	call	_u_drv
10322                     ; 2367           x_drv();
10324  209e cd0ed5        	call	_x_drv
10326                     ; 2368           if(main_cnt<1000)main_cnt++;
10328  20a1 9c            	rvf
10329  20a2 be4e          	ldw	x,_main_cnt
10330  20a4 a303e8        	cpw	x,#1000
10331  20a7 2e07          	jrsge	L5034
10334  20a9 be4e          	ldw	x,_main_cnt
10335  20ab 1c0001        	addw	x,#1
10336  20ae bf4e          	ldw	_main_cnt,x
10337  20b0               L5034:
10338                     ; 2369   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10340  20b0 b65f          	ld	a,_link
10341  20b2 a1aa          	cp	a,#170
10342  20b4 2706          	jreq	L1134
10344  20b6 b647          	ld	a,_jp_mode
10345  20b8 a103          	cp	a,#3
10346  20ba 2603          	jrne	L7034
10347  20bc               L1134:
10350  20bc cd0f4f        	call	_apv_hndl
10352  20bf               L7034:
10353                     ; 2372   		can_error_cnt++;
10355  20bf 3c6d          	inc	_can_error_cnt
10356                     ; 2373   		if(can_error_cnt>=10)
10358  20c1 b66d          	ld	a,_can_error_cnt
10359  20c3 a10a          	cp	a,#10
10360  20c5 2505          	jrult	L3134
10361                     ; 2375   			can_error_cnt=0;
10363  20c7 3f6d          	clr	_can_error_cnt
10364                     ; 2376 			init_CAN();
10366  20c9 cd14f7        	call	_init_CAN
10368  20cc               L3134:
10369                     ; 2380 		volum_u_main_drv();
10371  20cc cd13a4        	call	_volum_u_main_drv
10373                     ; 2382 		pwm_stat++;
10375  20cf 3c04          	inc	_pwm_stat
10376                     ; 2383 		if(pwm_stat>=10)pwm_stat=0;
10378  20d1 b604          	ld	a,_pwm_stat
10379  20d3 a10a          	cp	a,#10
10380  20d5 2502          	jrult	L5134
10383  20d7 3f04          	clr	_pwm_stat
10384  20d9               L5134:
10385                     ; 2384 adc_plazma_short++;
10387  20d9 bebc          	ldw	x,_adc_plazma_short
10388  20db 1c0001        	addw	x,#1
10389  20de bfbc          	ldw	_adc_plazma_short,x
10390  20e0 ac202020      	jpf	L5624
11404                     	xdef	_main
11405                     	xdef	f_ADC2_EOC_Interrupt
11406                     	xdef	f_CAN_TX_Interrupt
11407                     	xdef	f_CAN_RX_Interrupt
11408                     	xdef	f_TIM4_UPD_Interrupt
11409                     	xdef	_adc2_init
11410                     	xdef	_t1_init
11411                     	xdef	_t4_init
11412                     	xdef	_can_in_an
11413                     	xdef	_net_drv
11414                     	xdef	_can_tx_hndl
11415                     	xdef	_can_transmit
11416                     	xdef	_init_CAN
11417                     	xdef	_volum_u_main_drv
11418                     	xdef	_adr_drv_v4
11419                     	xdef	_adr_drv_v3
11420                     	xdef	_adr_gran
11421                     	xdef	_flags_drv
11422                     	xdef	_apv_hndl
11423                     	xdef	_apv_stop
11424                     	xdef	_apv_start
11425                     	xdef	_x_drv
11426                     	xdef	_u_drv
11427                     	xdef	_temper_drv
11428                     	xdef	_matemat
11429                     	xdef	_pwr_hndl
11430                     	xdef	_pwr_drv
11431                     	xdef	_vent_drv
11432                     	xdef	_link_drv
11433                     	xdef	_JP_drv
11434                     	xdef	_led_drv
11435                     	xdef	_led_hndl
11436                     	xdef	_delay_ms
11437                     	xdef	_granee
11438                     	xdef	_gran
11439                     .eeprom:	section	.data
11440  0000               _ee_IMAXVENT:
11441  0000 0000          	ds.b	2
11442                     	xdef	_ee_IMAXVENT
11443                     	switch	.ubsct
11444  0001               _bps_class:
11445  0001 00            	ds.b	1
11446                     	xdef	_bps_class
11447  0002               _vent_pwm:
11448  0002 0000          	ds.b	2
11449                     	xdef	_vent_pwm
11450  0004               _pwm_stat:
11451  0004 00            	ds.b	1
11452                     	xdef	_pwm_stat
11453  0005               _pwm_vent_cnt:
11454  0005 00            	ds.b	1
11455                     	xdef	_pwm_vent_cnt
11456                     	switch	.eeprom
11457  0002               _ee_DEVICE:
11458  0002 0000          	ds.b	2
11459                     	xdef	_ee_DEVICE
11460  0004               _ee_AVT_MODE:
11461  0004 0000          	ds.b	2
11462                     	xdef	_ee_AVT_MODE
11463                     	switch	.ubsct
11464  0006               _i_main_bps_cnt:
11465  0006 000000000000  	ds.b	6
11466                     	xdef	_i_main_bps_cnt
11467  000c               _i_main_sigma:
11468  000c 0000          	ds.b	2
11469                     	xdef	_i_main_sigma
11470  000e               _i_main_num_of_bps:
11471  000e 00            	ds.b	1
11472                     	xdef	_i_main_num_of_bps
11473  000f               _i_main_avg:
11474  000f 0000          	ds.b	2
11475                     	xdef	_i_main_avg
11476  0011               _i_main_flag:
11477  0011 000000000000  	ds.b	6
11478                     	xdef	_i_main_flag
11479  0017               _i_main:
11480  0017 000000000000  	ds.b	12
11481                     	xdef	_i_main
11482  0023               _x:
11483  0023 000000000000  	ds.b	12
11484                     	xdef	_x
11485                     	xdef	_volum_u_main_
11486                     	switch	.eeprom
11487  0006               _UU_AVT:
11488  0006 0000          	ds.b	2
11489                     	xdef	_UU_AVT
11490                     	switch	.ubsct
11491  002f               _cnt_net_drv:
11492  002f 00            	ds.b	1
11493                     	xdef	_cnt_net_drv
11494                     	switch	.bit
11495  0002               _bMAIN:
11496  0002 00            	ds.b	1
11497                     	xdef	_bMAIN
11498                     	switch	.ubsct
11499  0030               _plazma_int:
11500  0030 000000000000  	ds.b	6
11501                     	xdef	_plazma_int
11502                     	xdef	_rotor_int
11503  0036               _led_green_buff:
11504  0036 00000000      	ds.b	4
11505                     	xdef	_led_green_buff
11506  003a               _led_red_buff:
11507  003a 00000000      	ds.b	4
11508                     	xdef	_led_red_buff
11509                     	xdef	_led_drv_cnt
11510                     	xdef	_led_green
11511                     	xdef	_led_red
11512  003e               _res_fl_cnt:
11513  003e 00            	ds.b	1
11514                     	xdef	_res_fl_cnt
11515                     	xdef	_bRES_
11516                     	xdef	_bRES
11517                     	switch	.eeprom
11518  0008               _res_fl_:
11519  0008 00            	ds.b	1
11520                     	xdef	_res_fl_
11521  0009               _res_fl:
11522  0009 00            	ds.b	1
11523                     	xdef	_res_fl
11524                     	switch	.ubsct
11525  003f               _cnt_apv_off:
11526  003f 00            	ds.b	1
11527                     	xdef	_cnt_apv_off
11528                     	switch	.bit
11529  0003               _bAPV:
11530  0003 00            	ds.b	1
11531                     	xdef	_bAPV
11532                     	switch	.ubsct
11533  0040               _apv_cnt_:
11534  0040 0000          	ds.b	2
11535                     	xdef	_apv_cnt_
11536  0042               _apv_cnt:
11537  0042 000000        	ds.b	3
11538                     	xdef	_apv_cnt
11539                     	xdef	_bBL_IPS
11540                     	xdef	_bBL
11541  0045               _cnt_JP1:
11542  0045 00            	ds.b	1
11543                     	xdef	_cnt_JP1
11544  0046               _cnt_JP0:
11545  0046 00            	ds.b	1
11546                     	xdef	_cnt_JP0
11547  0047               _jp_mode:
11548  0047 00            	ds.b	1
11549                     	xdef	_jp_mode
11550                     	xdef	_pwm_i
11551                     	xdef	_pwm_u
11552  0048               _tmax_cnt:
11553  0048 0000          	ds.b	2
11554                     	xdef	_tmax_cnt
11555  004a               _tsign_cnt:
11556  004a 0000          	ds.b	2
11557                     	xdef	_tsign_cnt
11558                     	switch	.eeprom
11559  000a               _ee_U_AVT:
11560  000a 0000          	ds.b	2
11561                     	xdef	_ee_U_AVT
11562  000c               _ee_tsign:
11563  000c 0000          	ds.b	2
11564                     	xdef	_ee_tsign
11565  000e               _ee_tmax:
11566  000e 0000          	ds.b	2
11567                     	xdef	_ee_tmax
11568  0010               _ee_dU:
11569  0010 0000          	ds.b	2
11570                     	xdef	_ee_dU
11571  0012               _ee_Umax:
11572  0012 0000          	ds.b	2
11573                     	xdef	_ee_Umax
11574  0014               _ee_TZAS:
11575  0014 0000          	ds.b	2
11576                     	xdef	_ee_TZAS
11577                     	switch	.ubsct
11578  004c               _main_cnt1:
11579  004c 0000          	ds.b	2
11580                     	xdef	_main_cnt1
11581  004e               _main_cnt:
11582  004e 0000          	ds.b	2
11583                     	xdef	_main_cnt
11584  0050               _off_bp_cnt:
11585  0050 00            	ds.b	1
11586                     	xdef	_off_bp_cnt
11587  0051               _flags_tu_cnt_off:
11588  0051 00            	ds.b	1
11589                     	xdef	_flags_tu_cnt_off
11590  0052               _flags_tu_cnt_on:
11591  0052 00            	ds.b	1
11592                     	xdef	_flags_tu_cnt_on
11593  0053               _vol_i_temp:
11594  0053 0000          	ds.b	2
11595                     	xdef	_vol_i_temp
11596  0055               _vol_u_temp:
11597  0055 0000          	ds.b	2
11598                     	xdef	_vol_u_temp
11599                     	switch	.eeprom
11600  0016               __x_ee_:
11601  0016 0000          	ds.b	2
11602                     	xdef	__x_ee_
11603                     	switch	.ubsct
11604  0057               __x_cnt:
11605  0057 0000          	ds.b	2
11606                     	xdef	__x_cnt
11607  0059               __x__:
11608  0059 0000          	ds.b	2
11609                     	xdef	__x__
11610  005b               __x_:
11611  005b 0000          	ds.b	2
11612                     	xdef	__x_
11613  005d               _flags_tu:
11614  005d 00            	ds.b	1
11615                     	xdef	_flags_tu
11616                     	xdef	_flags
11617  005e               _link_cnt:
11618  005e 00            	ds.b	1
11619                     	xdef	_link_cnt
11620  005f               _link:
11621  005f 00            	ds.b	1
11622                     	xdef	_link
11623  0060               _umin_cnt:
11624  0060 0000          	ds.b	2
11625                     	xdef	_umin_cnt
11626  0062               _umax_cnt:
11627  0062 0000          	ds.b	2
11628                     	xdef	_umax_cnt
11629                     	switch	.eeprom
11630  0018               _ee_K:
11631  0018 000000000000  	ds.b	16
11632                     	xdef	_ee_K
11633                     	switch	.ubsct
11634  0064               _T:
11635  0064 00            	ds.b	1
11636                     	xdef	_T
11637  0065               _Udb:
11638  0065 0000          	ds.b	2
11639                     	xdef	_Udb
11640  0067               _Ui:
11641  0067 0000          	ds.b	2
11642                     	xdef	_Ui
11643  0069               _Un:
11644  0069 0000          	ds.b	2
11645                     	xdef	_Un
11646  006b               _I:
11647  006b 0000          	ds.b	2
11648                     	xdef	_I
11649  006d               _can_error_cnt:
11650  006d 00            	ds.b	1
11651                     	xdef	_can_error_cnt
11652                     	xdef	_bCAN_RX
11653  006e               _tx_busy_cnt:
11654  006e 00            	ds.b	1
11655                     	xdef	_tx_busy_cnt
11656                     	xdef	_bTX_FREE
11657  006f               _can_buff_rd_ptr:
11658  006f 00            	ds.b	1
11659                     	xdef	_can_buff_rd_ptr
11660  0070               _can_buff_wr_ptr:
11661  0070 00            	ds.b	1
11662                     	xdef	_can_buff_wr_ptr
11663  0071               _can_out_buff:
11664  0071 000000000000  	ds.b	64
11665                     	xdef	_can_out_buff
11666                     	switch	.bss
11667  0000               _adress_error:
11668  0000 00            	ds.b	1
11669                     	xdef	_adress_error
11670  0001               _adress:
11671  0001 00            	ds.b	1
11672                     	xdef	_adress
11673  0002               _adr:
11674  0002 000000        	ds.b	3
11675                     	xdef	_adr
11676                     	xdef	_adr_drv_stat
11677                     	xdef	_led_ind
11678                     	switch	.ubsct
11679  00b1               _led_ind_cnt:
11680  00b1 00            	ds.b	1
11681                     	xdef	_led_ind_cnt
11682  00b2               _adc_plazma:
11683  00b2 000000000000  	ds.b	10
11684                     	xdef	_adc_plazma
11685  00bc               _adc_plazma_short:
11686  00bc 0000          	ds.b	2
11687                     	xdef	_adc_plazma_short
11688  00be               _adc_cnt:
11689  00be 00            	ds.b	1
11690                     	xdef	_adc_cnt
11691  00bf               _adc_ch:
11692  00bf 00            	ds.b	1
11693                     	xdef	_adc_ch
11694                     	switch	.bss
11695  0005               _adc_buff_:
11696  0005 000000000000  	ds.b	20
11697                     	xdef	_adc_buff_
11698  0019               _adc_buff:
11699  0019 000000000000  	ds.b	320
11700                     	xdef	_adc_buff
11701                     	switch	.ubsct
11702  00c0               _mess:
11703  00c0 000000000000  	ds.b	14
11704                     	xdef	_mess
11705                     	switch	.bit
11706  0004               _b1Hz:
11707  0004 00            	ds.b	1
11708                     	xdef	_b1Hz
11709  0005               _b2Hz:
11710  0005 00            	ds.b	1
11711                     	xdef	_b2Hz
11712  0006               _b5Hz:
11713  0006 00            	ds.b	1
11714                     	xdef	_b5Hz
11715  0007               _b10Hz:
11716  0007 00            	ds.b	1
11717                     	xdef	_b10Hz
11718  0008               _b100Hz:
11719  0008 00            	ds.b	1
11720                     	xdef	_b100Hz
11721                     	xdef	_t0_cnt4
11722                     	xdef	_t0_cnt3
11723                     	xdef	_t0_cnt2
11724                     	xdef	_t0_cnt1
11725                     	xdef	_t0_cnt0
11726                     	xref.b	c_lreg
11727                     	xref.b	c_x
11728                     	xref.b	c_y
11748                     	xref	c_lrsh
11749                     	xref	c_lgadd
11750                     	xref	c_ladd
11751                     	xref	c_umul
11752                     	xref	c_lgmul
11753                     	xref	c_lgsub
11754                     	xref	c_lsbc
11755                     	xref	c_idiv
11756                     	xref	c_ldiv
11757                     	xref	c_itolx
11758                     	xref	c_eewrc
11759                     	xref	c_imul
11760                     	xref	c_lcmp
11761                     	xref	c_ltor
11762                     	xref	c_lgadc
11763                     	xref	c_rtol
11764                     	xref	c_vmul
11765                     	xref	c_eewrw
11766                     	end
