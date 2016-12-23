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
2262                     ; 175 void vent_resurs_hndl(void)
2262                     ; 176 {
2264                     	switch	.text
2265  0000               _vent_resurs_hndl:
2267  0000 88            	push	a
2268       00000001      OFST:	set	1
2271                     ; 178 if(!bVENT_BLOCK)vent_resurs_sec_cnt++;
2273  0001 3d00          	tnz	_bVENT_BLOCK
2274  0003 2607          	jrne	L7441
2277  0005 be02          	ldw	x,_vent_resurs_sec_cnt
2278  0007 1c0001        	addw	x,#1
2279  000a bf02          	ldw	_vent_resurs_sec_cnt,x
2280  000c               L7441:
2281                     ; 179 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2283  000c be02          	ldw	x,_vent_resurs_sec_cnt
2284  000e a30e11        	cpw	x,#3601
2285  0011 250c          	jrult	L1541
2286                     ; 181 	vent_resurs++;
2288  0013 ce0000        	ldw	x,_vent_resurs
2289  0016 1c0001        	addw	x,#1
2290  0019 cf0000        	ldw	_vent_resurs,x
2291                     ; 182 	vent_resurs_sec_cnt=0;
2293  001c 5f            	clrw	x
2294  001d bf02          	ldw	_vent_resurs_sec_cnt,x
2295  001f               L1541:
2296                     ; 187 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2298  001f c60001        	ld	a,_vent_resurs+1
2299  0022 a40f          	and	a,#15
2300  0024 c70000        	ld	_vent_resurs_buff,a
2301                     ; 188 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2303  0027 c60001        	ld	a,_vent_resurs+1
2304  002a a4f0          	and	a,#240
2305  002c 4e            	swap	a
2306  002d a40f          	and	a,#15
2307  002f aa40          	or	a,#64
2308  0031 c70001        	ld	_vent_resurs_buff+1,a
2309                     ; 189 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2311  0034 c60000        	ld	a,_vent_resurs
2312  0037 97            	ld	xl,a
2313  0038 c60001        	ld	a,_vent_resurs+1
2314  003b 9f            	ld	a,xl
2315  003c a40f          	and	a,#15
2316  003e 97            	ld	xl,a
2317  003f 4f            	clr	a
2318  0040 02            	rlwa	x,a
2319  0041 4f            	clr	a
2320  0042 01            	rrwa	x,a
2321  0043 9f            	ld	a,xl
2322  0044 aa80          	or	a,#128
2323  0046 c70002        	ld	_vent_resurs_buff+2,a
2324                     ; 190 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2326  0049 c60000        	ld	a,_vent_resurs
2327  004c 97            	ld	xl,a
2328  004d c60001        	ld	a,_vent_resurs+1
2329  0050 9f            	ld	a,xl
2330  0051 a4f0          	and	a,#240
2331  0053 97            	ld	xl,a
2332  0054 4f            	clr	a
2333  0055 02            	rlwa	x,a
2334  0056 01            	rrwa	x,a
2335  0057 4f            	clr	a
2336  0058 41            	exg	a,xl
2337  0059 4e            	swap	a
2338  005a a40f          	and	a,#15
2339  005c 02            	rlwa	x,a
2340  005d 9f            	ld	a,xl
2341  005e aac0          	or	a,#192
2342  0060 c70003        	ld	_vent_resurs_buff+3,a
2343                     ; 192 temp=vent_resurs_buff[0]&0x0f;
2345  0063 c60000        	ld	a,_vent_resurs_buff
2346  0066 a40f          	and	a,#15
2347  0068 6b01          	ld	(OFST+0,sp),a
2348                     ; 193 temp^=vent_resurs_buff[1]&0x0f;
2350  006a c60001        	ld	a,_vent_resurs_buff+1
2351  006d a40f          	and	a,#15
2352  006f 1801          	xor	a,(OFST+0,sp)
2353  0071 6b01          	ld	(OFST+0,sp),a
2354                     ; 194 temp^=vent_resurs_buff[2]&0x0f;
2356  0073 c60002        	ld	a,_vent_resurs_buff+2
2357  0076 a40f          	and	a,#15
2358  0078 1801          	xor	a,(OFST+0,sp)
2359  007a 6b01          	ld	(OFST+0,sp),a
2360                     ; 195 temp^=vent_resurs_buff[3]&0x0f;
2362  007c c60003        	ld	a,_vent_resurs_buff+3
2363  007f a40f          	and	a,#15
2364  0081 1801          	xor	a,(OFST+0,sp)
2365  0083 6b01          	ld	(OFST+0,sp),a
2366                     ; 197 vent_resurs_buff[0]|=(temp&0x03)<<4;
2368  0085 7b01          	ld	a,(OFST+0,sp)
2369  0087 a403          	and	a,#3
2370  0089 97            	ld	xl,a
2371  008a a610          	ld	a,#16
2372  008c 42            	mul	x,a
2373  008d 9f            	ld	a,xl
2374  008e ca0000        	or	a,_vent_resurs_buff
2375  0091 c70000        	ld	_vent_resurs_buff,a
2376                     ; 198 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2378  0094 7b01          	ld	a,(OFST+0,sp)
2379  0096 a40c          	and	a,#12
2380  0098 48            	sll	a
2381  0099 48            	sll	a
2382  009a ca0001        	or	a,_vent_resurs_buff+1
2383  009d c70001        	ld	_vent_resurs_buff+1,a
2384                     ; 199 vent_resurs_buff[2]|=(temp&0x30);
2386  00a0 7b01          	ld	a,(OFST+0,sp)
2387  00a2 a430          	and	a,#48
2388  00a4 ca0002        	or	a,_vent_resurs_buff+2
2389  00a7 c70002        	ld	_vent_resurs_buff+2,a
2390                     ; 200 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2392  00aa 7b01          	ld	a,(OFST+0,sp)
2393  00ac a4c0          	and	a,#192
2394  00ae 44            	srl	a
2395  00af 44            	srl	a
2396  00b0 ca0003        	or	a,_vent_resurs_buff+3
2397  00b3 c70003        	ld	_vent_resurs_buff+3,a
2398                     ; 203 vent_resurs_tx_cnt++;
2400  00b6 3c01          	inc	_vent_resurs_tx_cnt
2401                     ; 204 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2403  00b8 b601          	ld	a,_vent_resurs_tx_cnt
2404  00ba a104          	cp	a,#4
2405  00bc 2502          	jrult	L3541
2408  00be 3f01          	clr	_vent_resurs_tx_cnt
2409  00c0               L3541:
2410                     ; 207 }
2413  00c0 84            	pop	a
2414  00c1 81            	ret
2467                     ; 210 void gran(signed short *adr, signed short min, signed short max)
2467                     ; 211 {
2468                     	switch	.text
2469  00c2               _gran:
2471  00c2 89            	pushw	x
2472       00000000      OFST:	set	0
2475                     ; 212 if (*adr<min) *adr=min;
2477  00c3 9c            	rvf
2478  00c4 9093          	ldw	y,x
2479  00c6 51            	exgw	x,y
2480  00c7 fe            	ldw	x,(x)
2481  00c8 1305          	cpw	x,(OFST+5,sp)
2482  00ca 51            	exgw	x,y
2483  00cb 2e03          	jrsge	L3051
2486  00cd 1605          	ldw	y,(OFST+5,sp)
2487  00cf ff            	ldw	(x),y
2488  00d0               L3051:
2489                     ; 213 if (*adr>max) *adr=max; 
2491  00d0 9c            	rvf
2492  00d1 1e01          	ldw	x,(OFST+1,sp)
2493  00d3 9093          	ldw	y,x
2494  00d5 51            	exgw	x,y
2495  00d6 fe            	ldw	x,(x)
2496  00d7 1307          	cpw	x,(OFST+7,sp)
2497  00d9 51            	exgw	x,y
2498  00da 2d05          	jrsle	L5051
2501  00dc 1e01          	ldw	x,(OFST+1,sp)
2502  00de 1607          	ldw	y,(OFST+7,sp)
2503  00e0 ff            	ldw	(x),y
2504  00e1               L5051:
2505                     ; 214 } 
2508  00e1 85            	popw	x
2509  00e2 81            	ret
2562                     ; 217 void granee(@eeprom signed short *adr, signed short min, signed short max)
2562                     ; 218 {
2563                     	switch	.text
2564  00e3               _granee:
2566  00e3 89            	pushw	x
2567       00000000      OFST:	set	0
2570                     ; 219 if (*adr<min) *adr=min;
2572  00e4 9c            	rvf
2573  00e5 9093          	ldw	y,x
2574  00e7 51            	exgw	x,y
2575  00e8 fe            	ldw	x,(x)
2576  00e9 1305          	cpw	x,(OFST+5,sp)
2577  00eb 51            	exgw	x,y
2578  00ec 2e09          	jrsge	L5351
2581  00ee 1e05          	ldw	x,(OFST+5,sp)
2582  00f0 89            	pushw	x
2583  00f1 1e03          	ldw	x,(OFST+3,sp)
2584  00f3 cd0000        	call	c_eewrw
2586  00f6 85            	popw	x
2587  00f7               L5351:
2588                     ; 220 if (*adr>max) *adr=max; 
2590  00f7 9c            	rvf
2591  00f8 1e01          	ldw	x,(OFST+1,sp)
2592  00fa 9093          	ldw	y,x
2593  00fc 51            	exgw	x,y
2594  00fd fe            	ldw	x,(x)
2595  00fe 1307          	cpw	x,(OFST+7,sp)
2596  0100 51            	exgw	x,y
2597  0101 2d09          	jrsle	L7351
2600  0103 1e07          	ldw	x,(OFST+7,sp)
2601  0105 89            	pushw	x
2602  0106 1e03          	ldw	x,(OFST+3,sp)
2603  0108 cd0000        	call	c_eewrw
2605  010b 85            	popw	x
2606  010c               L7351:
2607                     ; 221 }
2610  010c 85            	popw	x
2611  010d 81            	ret
2672                     ; 224 long delay_ms(short in)
2672                     ; 225 {
2673                     	switch	.text
2674  010e               _delay_ms:
2676  010e 520c          	subw	sp,#12
2677       0000000c      OFST:	set	12
2680                     ; 228 i=((long)in)*100UL;
2682  0110 90ae0064      	ldw	y,#100
2683  0114 cd0000        	call	c_vmul
2685  0117 96            	ldw	x,sp
2686  0118 1c0005        	addw	x,#OFST-7
2687  011b cd0000        	call	c_rtol
2689                     ; 230 for(ii=0;ii<i;ii++)
2691  011e ae0000        	ldw	x,#0
2692  0121 1f0b          	ldw	(OFST-1,sp),x
2693  0123 ae0000        	ldw	x,#0
2694  0126 1f09          	ldw	(OFST-3,sp),x
2696  0128 2012          	jra	L7751
2697  012a               L3751:
2698                     ; 232 		iii++;
2700  012a 96            	ldw	x,sp
2701  012b 1c0001        	addw	x,#OFST-11
2702  012e a601          	ld	a,#1
2703  0130 cd0000        	call	c_lgadc
2705                     ; 230 for(ii=0;ii<i;ii++)
2707  0133 96            	ldw	x,sp
2708  0134 1c0009        	addw	x,#OFST-3
2709  0137 a601          	ld	a,#1
2710  0139 cd0000        	call	c_lgadc
2712  013c               L7751:
2715  013c 9c            	rvf
2716  013d 96            	ldw	x,sp
2717  013e 1c0009        	addw	x,#OFST-3
2718  0141 cd0000        	call	c_ltor
2720  0144 96            	ldw	x,sp
2721  0145 1c0005        	addw	x,#OFST-7
2722  0148 cd0000        	call	c_lcmp
2724  014b 2fdd          	jrslt	L3751
2725                     ; 235 }
2728  014d 5b0c          	addw	sp,#12
2729  014f 81            	ret
2765                     ; 238 void led_hndl(void)
2765                     ; 239 {
2766                     	switch	.text
2767  0150               _led_hndl:
2771                     ; 240 if(adress_error)
2773  0150 725d0004      	tnz	_adress_error
2774  0154 2718          	jreq	L3161
2775                     ; 242 	led_red=0x55555555L;
2777  0156 ae5555        	ldw	x,#21845
2778  0159 bf14          	ldw	_led_red+2,x
2779  015b ae5555        	ldw	x,#21845
2780  015e bf12          	ldw	_led_red,x
2781                     ; 243 	led_green=0x55555555L;
2783  0160 ae5555        	ldw	x,#21845
2784  0163 bf18          	ldw	_led_green+2,x
2785  0165 ae5555        	ldw	x,#21845
2786  0168 bf16          	ldw	_led_green,x
2788  016a acd207d2      	jpf	L5161
2789  016e               L3161:
2790                     ; 259 else if(bps_class==bpsIBEP)	//если блок ИБЭПный
2792  016e 3d04          	tnz	_bps_class
2793  0170 2703          	jreq	L61
2794  0172 cc0425        	jp	L7161
2795  0175               L61:
2796                     ; 261 	if(jp_mode!=jp3)
2798  0175 b64a          	ld	a,_jp_mode
2799  0177 a103          	cp	a,#3
2800  0179 2603          	jrne	L02
2801  017b cc0321        	jp	L1261
2802  017e               L02:
2803                     ; 263 		if(main_cnt1<(5*ee_TZAS))
2805  017e 9c            	rvf
2806  017f ce0016        	ldw	x,_ee_TZAS
2807  0182 90ae0005      	ldw	y,#5
2808  0186 cd0000        	call	c_imul
2810  0189 b34f          	cpw	x,_main_cnt1
2811  018b 2d18          	jrsle	L3261
2812                     ; 265 			led_red=0x00000000L;
2814  018d ae0000        	ldw	x,#0
2815  0190 bf14          	ldw	_led_red+2,x
2816  0192 ae0000        	ldw	x,#0
2817  0195 bf12          	ldw	_led_red,x
2818                     ; 266 			led_green=0x03030303L;
2820  0197 ae0303        	ldw	x,#771
2821  019a bf18          	ldw	_led_green+2,x
2822  019c ae0303        	ldw	x,#771
2823  019f bf16          	ldw	_led_green,x
2825  01a1 ace202e2      	jpf	L5261
2826  01a5               L3261:
2827                     ; 269 		else if((link==ON)&&(flags_tu&0b10000000))
2829  01a5 b662          	ld	a,_link
2830  01a7 a155          	cp	a,#85
2831  01a9 261e          	jrne	L7261
2833  01ab b660          	ld	a,_flags_tu
2834  01ad a580          	bcp	a,#128
2835  01af 2718          	jreq	L7261
2836                     ; 271 			led_red=0x00055555L;
2838  01b1 ae5555        	ldw	x,#21845
2839  01b4 bf14          	ldw	_led_red+2,x
2840  01b6 ae0005        	ldw	x,#5
2841  01b9 bf12          	ldw	_led_red,x
2842                     ; 272 			led_green=0xffffffffL;
2844  01bb aeffff        	ldw	x,#65535
2845  01be bf18          	ldw	_led_green+2,x
2846  01c0 aeffff        	ldw	x,#-1
2847  01c3 bf16          	ldw	_led_green,x
2849  01c5 ace202e2      	jpf	L5261
2850  01c9               L7261:
2851                     ; 275 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2853  01c9 9c            	rvf
2854  01ca ce0016        	ldw	x,_ee_TZAS
2855  01cd 90ae0005      	ldw	y,#5
2856  01d1 cd0000        	call	c_imul
2858  01d4 b34f          	cpw	x,_main_cnt1
2859  01d6 2e37          	jrsge	L3361
2861  01d8 9c            	rvf
2862  01d9 ce0016        	ldw	x,_ee_TZAS
2863  01dc 90ae0005      	ldw	y,#5
2864  01e0 cd0000        	call	c_imul
2866  01e3 1c0064        	addw	x,#100
2867  01e6 b34f          	cpw	x,_main_cnt1
2868  01e8 2d25          	jrsle	L3361
2870  01ea ce0006        	ldw	x,_ee_AVT_MODE
2871  01ed a30055        	cpw	x,#85
2872  01f0 271d          	jreq	L3361
2874  01f2 ce0004        	ldw	x,_ee_DEVICE
2875  01f5 2618          	jrne	L3361
2876                     ; 277 			led_red=0x00000000L;
2878  01f7 ae0000        	ldw	x,#0
2879  01fa bf14          	ldw	_led_red+2,x
2880  01fc ae0000        	ldw	x,#0
2881  01ff bf12          	ldw	_led_red,x
2882                     ; 278 			led_green=0xffffffffL;	
2884  0201 aeffff        	ldw	x,#65535
2885  0204 bf18          	ldw	_led_green+2,x
2886  0206 aeffff        	ldw	x,#-1
2887  0209 bf16          	ldw	_led_green,x
2889  020b ace202e2      	jpf	L5261
2890  020f               L3361:
2891                     ; 281 		else  if(link==OFF)
2893  020f b662          	ld	a,_link
2894  0211 a1aa          	cp	a,#170
2895  0213 2618          	jrne	L7361
2896                     ; 283 			led_red=0x55555555L;
2898  0215 ae5555        	ldw	x,#21845
2899  0218 bf14          	ldw	_led_red+2,x
2900  021a ae5555        	ldw	x,#21845
2901  021d bf12          	ldw	_led_red,x
2902                     ; 284 			led_green=0xffffffffL;
2904  021f aeffff        	ldw	x,#65535
2905  0222 bf18          	ldw	_led_green+2,x
2906  0224 aeffff        	ldw	x,#-1
2907  0227 bf16          	ldw	_led_green,x
2909  0229 ace202e2      	jpf	L5261
2910  022d               L7361:
2911                     ; 287 		else if((link==ON)&&((flags&0b00111110)==0))
2913  022d b662          	ld	a,_link
2914  022f a155          	cp	a,#85
2915  0231 261d          	jrne	L3461
2917  0233 b60b          	ld	a,_flags
2918  0235 a53e          	bcp	a,#62
2919  0237 2617          	jrne	L3461
2920                     ; 289 			led_red=0x00000000L;
2922  0239 ae0000        	ldw	x,#0
2923  023c bf14          	ldw	_led_red+2,x
2924  023e ae0000        	ldw	x,#0
2925  0241 bf12          	ldw	_led_red,x
2926                     ; 290 			led_green=0xffffffffL;
2928  0243 aeffff        	ldw	x,#65535
2929  0246 bf18          	ldw	_led_green+2,x
2930  0248 aeffff        	ldw	x,#-1
2931  024b bf16          	ldw	_led_green,x
2933  024d cc02e2        	jra	L5261
2934  0250               L3461:
2935                     ; 293 		else if((flags&0b00111110)==0b00000100)
2937  0250 b60b          	ld	a,_flags
2938  0252 a43e          	and	a,#62
2939  0254 a104          	cp	a,#4
2940  0256 2616          	jrne	L7461
2941                     ; 295 			led_red=0x00010001L;
2943  0258 ae0001        	ldw	x,#1
2944  025b bf14          	ldw	_led_red+2,x
2945  025d ae0001        	ldw	x,#1
2946  0260 bf12          	ldw	_led_red,x
2947                     ; 296 			led_green=0xffffffffL;	
2949  0262 aeffff        	ldw	x,#65535
2950  0265 bf18          	ldw	_led_green+2,x
2951  0267 aeffff        	ldw	x,#-1
2952  026a bf16          	ldw	_led_green,x
2954  026c 2074          	jra	L5261
2955  026e               L7461:
2956                     ; 298 		else if(flags&0b00000010)
2958  026e b60b          	ld	a,_flags
2959  0270 a502          	bcp	a,#2
2960  0272 2716          	jreq	L3561
2961                     ; 300 			led_red=0x00010001L;
2963  0274 ae0001        	ldw	x,#1
2964  0277 bf14          	ldw	_led_red+2,x
2965  0279 ae0001        	ldw	x,#1
2966  027c bf12          	ldw	_led_red,x
2967                     ; 301 			led_green=0x00000000L;	
2969  027e ae0000        	ldw	x,#0
2970  0281 bf18          	ldw	_led_green+2,x
2971  0283 ae0000        	ldw	x,#0
2972  0286 bf16          	ldw	_led_green,x
2974  0288 2058          	jra	L5261
2975  028a               L3561:
2976                     ; 303 		else if(flags&0b00001000)
2978  028a b60b          	ld	a,_flags
2979  028c a508          	bcp	a,#8
2980  028e 2716          	jreq	L7561
2981                     ; 305 			led_red=0x00090009L;
2983  0290 ae0009        	ldw	x,#9
2984  0293 bf14          	ldw	_led_red+2,x
2985  0295 ae0009        	ldw	x,#9
2986  0298 bf12          	ldw	_led_red,x
2987                     ; 306 			led_green=0x00000000L;	
2989  029a ae0000        	ldw	x,#0
2990  029d bf18          	ldw	_led_green+2,x
2991  029f ae0000        	ldw	x,#0
2992  02a2 bf16          	ldw	_led_green,x
2994  02a4 203c          	jra	L5261
2995  02a6               L7561:
2996                     ; 308 		else if(flags&0b00010000)
2998  02a6 b60b          	ld	a,_flags
2999  02a8 a510          	bcp	a,#16
3000  02aa 2716          	jreq	L3661
3001                     ; 310 			led_red=0x00490049L;
3003  02ac ae0049        	ldw	x,#73
3004  02af bf14          	ldw	_led_red+2,x
3005  02b1 ae0049        	ldw	x,#73
3006  02b4 bf12          	ldw	_led_red,x
3007                     ; 311 			led_green=0x00000000L;	
3009  02b6 ae0000        	ldw	x,#0
3010  02b9 bf18          	ldw	_led_green+2,x
3011  02bb ae0000        	ldw	x,#0
3012  02be bf16          	ldw	_led_green,x
3014  02c0 2020          	jra	L5261
3015  02c2               L3661:
3016                     ; 314 		else if((link==ON)&&(flags&0b00100000))
3018  02c2 b662          	ld	a,_link
3019  02c4 a155          	cp	a,#85
3020  02c6 261a          	jrne	L5261
3022  02c8 b60b          	ld	a,_flags
3023  02ca a520          	bcp	a,#32
3024  02cc 2714          	jreq	L5261
3025                     ; 316 			led_red=0x00000000L;
3027  02ce ae0000        	ldw	x,#0
3028  02d1 bf14          	ldw	_led_red+2,x
3029  02d3 ae0000        	ldw	x,#0
3030  02d6 bf12          	ldw	_led_red,x
3031                     ; 317 			led_green=0x00030003L;
3033  02d8 ae0003        	ldw	x,#3
3034  02db bf18          	ldw	_led_green+2,x
3035  02dd ae0003        	ldw	x,#3
3036  02e0 bf16          	ldw	_led_green,x
3037  02e2               L5261:
3038                     ; 320 		if((jp_mode==jp1))
3040  02e2 b64a          	ld	a,_jp_mode
3041  02e4 a101          	cp	a,#1
3042  02e6 2618          	jrne	L1761
3043                     ; 322 			led_red=0x00000000L;
3045  02e8 ae0000        	ldw	x,#0
3046  02eb bf14          	ldw	_led_red+2,x
3047  02ed ae0000        	ldw	x,#0
3048  02f0 bf12          	ldw	_led_red,x
3049                     ; 323 			led_green=0x33333333L;
3051  02f2 ae3333        	ldw	x,#13107
3052  02f5 bf18          	ldw	_led_green+2,x
3053  02f7 ae3333        	ldw	x,#13107
3054  02fa bf16          	ldw	_led_green,x
3056  02fc acd207d2      	jpf	L5161
3057  0300               L1761:
3058                     ; 325 		else if((jp_mode==jp2))
3060  0300 b64a          	ld	a,_jp_mode
3061  0302 a102          	cp	a,#2
3062  0304 2703          	jreq	L22
3063  0306 cc07d2        	jp	L5161
3064  0309               L22:
3065                     ; 327 			led_red=0xccccccccL;
3067  0309 aecccc        	ldw	x,#52428
3068  030c bf14          	ldw	_led_red+2,x
3069  030e aecccc        	ldw	x,#-13108
3070  0311 bf12          	ldw	_led_red,x
3071                     ; 328 			led_green=0x00000000L;
3073  0313 ae0000        	ldw	x,#0
3074  0316 bf18          	ldw	_led_green+2,x
3075  0318 ae0000        	ldw	x,#0
3076  031b bf16          	ldw	_led_green,x
3077  031d acd207d2      	jpf	L5161
3078  0321               L1261:
3079                     ; 331 	else if(jp_mode==jp3)
3081  0321 b64a          	ld	a,_jp_mode
3082  0323 a103          	cp	a,#3
3083  0325 2703          	jreq	L42
3084  0327 cc07d2        	jp	L5161
3085  032a               L42:
3086                     ; 333 		if(main_cnt1<(5*ee_TZAS))
3088  032a 9c            	rvf
3089  032b ce0016        	ldw	x,_ee_TZAS
3090  032e 90ae0005      	ldw	y,#5
3091  0332 cd0000        	call	c_imul
3093  0335 b34f          	cpw	x,_main_cnt1
3094  0337 2d18          	jrsle	L3071
3095                     ; 335 			led_red=0x00000000L;
3097  0339 ae0000        	ldw	x,#0
3098  033c bf14          	ldw	_led_red+2,x
3099  033e ae0000        	ldw	x,#0
3100  0341 bf12          	ldw	_led_red,x
3101                     ; 336 			led_green=0x03030303L;
3103  0343 ae0303        	ldw	x,#771
3104  0346 bf18          	ldw	_led_green+2,x
3105  0348 ae0303        	ldw	x,#771
3106  034b bf16          	ldw	_led_green,x
3108  034d acd207d2      	jpf	L5161
3109  0351               L3071:
3110                     ; 338 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3112  0351 9c            	rvf
3113  0352 ce0016        	ldw	x,_ee_TZAS
3114  0355 90ae0005      	ldw	y,#5
3115  0359 cd0000        	call	c_imul
3117  035c b34f          	cpw	x,_main_cnt1
3118  035e 2e2a          	jrsge	L7071
3120  0360 9c            	rvf
3121  0361 ce0016        	ldw	x,_ee_TZAS
3122  0364 90ae0005      	ldw	y,#5
3123  0368 cd0000        	call	c_imul
3125  036b 1c0046        	addw	x,#70
3126  036e b34f          	cpw	x,_main_cnt1
3127  0370 2d18          	jrsle	L7071
3128                     ; 340 			led_red=0x00000000L;
3130  0372 ae0000        	ldw	x,#0
3131  0375 bf14          	ldw	_led_red+2,x
3132  0377 ae0000        	ldw	x,#0
3133  037a bf12          	ldw	_led_red,x
3134                     ; 341 			led_green=0xffffffffL;	
3136  037c aeffff        	ldw	x,#65535
3137  037f bf18          	ldw	_led_green+2,x
3138  0381 aeffff        	ldw	x,#-1
3139  0384 bf16          	ldw	_led_green,x
3141  0386 acd207d2      	jpf	L5161
3142  038a               L7071:
3143                     ; 344 		else if((flags&0b00011110)==0)
3145  038a b60b          	ld	a,_flags
3146  038c a51e          	bcp	a,#30
3147  038e 2618          	jrne	L3171
3148                     ; 346 			led_red=0x00000000L;
3150  0390 ae0000        	ldw	x,#0
3151  0393 bf14          	ldw	_led_red+2,x
3152  0395 ae0000        	ldw	x,#0
3153  0398 bf12          	ldw	_led_red,x
3154                     ; 347 			led_green=0xffffffffL;
3156  039a aeffff        	ldw	x,#65535
3157  039d bf18          	ldw	_led_green+2,x
3158  039f aeffff        	ldw	x,#-1
3159  03a2 bf16          	ldw	_led_green,x
3161  03a4 acd207d2      	jpf	L5161
3162  03a8               L3171:
3163                     ; 351 		else if((flags&0b00111110)==0b00000100)
3165  03a8 b60b          	ld	a,_flags
3166  03aa a43e          	and	a,#62
3167  03ac a104          	cp	a,#4
3168  03ae 2618          	jrne	L7171
3169                     ; 353 			led_red=0x00010001L;
3171  03b0 ae0001        	ldw	x,#1
3172  03b3 bf14          	ldw	_led_red+2,x
3173  03b5 ae0001        	ldw	x,#1
3174  03b8 bf12          	ldw	_led_red,x
3175                     ; 354 			led_green=0xffffffffL;	
3177  03ba aeffff        	ldw	x,#65535
3178  03bd bf18          	ldw	_led_green+2,x
3179  03bf aeffff        	ldw	x,#-1
3180  03c2 bf16          	ldw	_led_green,x
3182  03c4 acd207d2      	jpf	L5161
3183  03c8               L7171:
3184                     ; 356 		else if(flags&0b00000010)
3186  03c8 b60b          	ld	a,_flags
3187  03ca a502          	bcp	a,#2
3188  03cc 2718          	jreq	L3271
3189                     ; 358 			led_red=0x00010001L;
3191  03ce ae0001        	ldw	x,#1
3192  03d1 bf14          	ldw	_led_red+2,x
3193  03d3 ae0001        	ldw	x,#1
3194  03d6 bf12          	ldw	_led_red,x
3195                     ; 359 			led_green=0x00000000L;	
3197  03d8 ae0000        	ldw	x,#0
3198  03db bf18          	ldw	_led_green+2,x
3199  03dd ae0000        	ldw	x,#0
3200  03e0 bf16          	ldw	_led_green,x
3202  03e2 acd207d2      	jpf	L5161
3203  03e6               L3271:
3204                     ; 361 		else if(flags&0b00001000)
3206  03e6 b60b          	ld	a,_flags
3207  03e8 a508          	bcp	a,#8
3208  03ea 2718          	jreq	L7271
3209                     ; 363 			led_red=0x00090009L;
3211  03ec ae0009        	ldw	x,#9
3212  03ef bf14          	ldw	_led_red+2,x
3213  03f1 ae0009        	ldw	x,#9
3214  03f4 bf12          	ldw	_led_red,x
3215                     ; 364 			led_green=0x00000000L;	
3217  03f6 ae0000        	ldw	x,#0
3218  03f9 bf18          	ldw	_led_green+2,x
3219  03fb ae0000        	ldw	x,#0
3220  03fe bf16          	ldw	_led_green,x
3222  0400 acd207d2      	jpf	L5161
3223  0404               L7271:
3224                     ; 366 		else if(flags&0b00010000)
3226  0404 b60b          	ld	a,_flags
3227  0406 a510          	bcp	a,#16
3228  0408 2603          	jrne	L62
3229  040a cc07d2        	jp	L5161
3230  040d               L62:
3231                     ; 368 			led_red=0x00490049L;
3233  040d ae0049        	ldw	x,#73
3234  0410 bf14          	ldw	_led_red+2,x
3235  0412 ae0049        	ldw	x,#73
3236  0415 bf12          	ldw	_led_red,x
3237                     ; 369 			led_green=0xffffffffL;	
3239  0417 aeffff        	ldw	x,#65535
3240  041a bf18          	ldw	_led_green+2,x
3241  041c aeffff        	ldw	x,#-1
3242  041f bf16          	ldw	_led_green,x
3243  0421 acd207d2      	jpf	L5161
3244  0425               L7161:
3245                     ; 373 else if(bps_class==bpsIPS)	//если блок ИПСный
3247  0425 b604          	ld	a,_bps_class
3248  0427 a101          	cp	a,#1
3249  0429 2703          	jreq	L03
3250  042b cc07d2        	jp	L5161
3251  042e               L03:
3252                     ; 375 	if(jp_mode!=jp3)
3254  042e b64a          	ld	a,_jp_mode
3255  0430 a103          	cp	a,#3
3256  0432 2603          	jrne	L23
3257  0434 cc06de        	jp	L1471
3258  0437               L23:
3259                     ; 377 		if(main_cnt1<(5*ee_TZAS))
3261  0437 9c            	rvf
3262  0438 ce0016        	ldw	x,_ee_TZAS
3263  043b 90ae0005      	ldw	y,#5
3264  043f cd0000        	call	c_imul
3266  0442 b34f          	cpw	x,_main_cnt1
3267  0444 2d18          	jrsle	L3471
3268                     ; 379 			led_red=0x00000000L;
3270  0446 ae0000        	ldw	x,#0
3271  0449 bf14          	ldw	_led_red+2,x
3272  044b ae0000        	ldw	x,#0
3273  044e bf12          	ldw	_led_red,x
3274                     ; 380 			led_green=0x03030303L;
3276  0450 ae0303        	ldw	x,#771
3277  0453 bf18          	ldw	_led_green+2,x
3278  0455 ae0303        	ldw	x,#771
3279  0458 bf16          	ldw	_led_green,x
3281  045a ac9f069f      	jpf	L5471
3282  045e               L3471:
3283                     ; 383 		else if((link==ON)&&(flags_tu&0b10000000))
3285  045e b662          	ld	a,_link
3286  0460 a155          	cp	a,#85
3287  0462 261e          	jrne	L7471
3289  0464 b660          	ld	a,_flags_tu
3290  0466 a580          	bcp	a,#128
3291  0468 2718          	jreq	L7471
3292                     ; 385 			led_red=0x00055555L;
3294  046a ae5555        	ldw	x,#21845
3295  046d bf14          	ldw	_led_red+2,x
3296  046f ae0005        	ldw	x,#5
3297  0472 bf12          	ldw	_led_red,x
3298                     ; 386 			led_green=0xffffffffL;
3300  0474 aeffff        	ldw	x,#65535
3301  0477 bf18          	ldw	_led_green+2,x
3302  0479 aeffff        	ldw	x,#-1
3303  047c bf16          	ldw	_led_green,x
3305  047e ac9f069f      	jpf	L5471
3306  0482               L7471:
3307                     ; 389 		else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(100+(5*ee_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
3309  0482 9c            	rvf
3310  0483 ce0016        	ldw	x,_ee_TZAS
3311  0486 90ae0005      	ldw	y,#5
3312  048a cd0000        	call	c_imul
3314  048d b34f          	cpw	x,_main_cnt1
3315  048f 2e37          	jrsge	L3571
3317  0491 9c            	rvf
3318  0492 ce0016        	ldw	x,_ee_TZAS
3319  0495 90ae0005      	ldw	y,#5
3320  0499 cd0000        	call	c_imul
3322  049c 1c0064        	addw	x,#100
3323  049f b34f          	cpw	x,_main_cnt1
3324  04a1 2d25          	jrsle	L3571
3326  04a3 ce0006        	ldw	x,_ee_AVT_MODE
3327  04a6 a30055        	cpw	x,#85
3328  04a9 271d          	jreq	L3571
3330  04ab ce0004        	ldw	x,_ee_DEVICE
3331  04ae 2618          	jrne	L3571
3332                     ; 391 			led_red=0x00000000L;
3334  04b0 ae0000        	ldw	x,#0
3335  04b3 bf14          	ldw	_led_red+2,x
3336  04b5 ae0000        	ldw	x,#0
3337  04b8 bf12          	ldw	_led_red,x
3338                     ; 392 			led_green=0xffffffffL;	
3340  04ba aeffff        	ldw	x,#65535
3341  04bd bf18          	ldw	_led_green+2,x
3342  04bf aeffff        	ldw	x,#-1
3343  04c2 bf16          	ldw	_led_green,x
3345  04c4 ac9f069f      	jpf	L5471
3346  04c8               L3571:
3347                     ; 395 		else  if(link==OFF)
3349  04c8 b662          	ld	a,_link
3350  04ca a1aa          	cp	a,#170
3351  04cc 2703          	jreq	L43
3352  04ce cc05ea        	jp	L7571
3353  04d1               L43:
3354                     ; 397 			if((flags&0b00011110)==0)
3356  04d1 b60b          	ld	a,_flags
3357  04d3 a51e          	bcp	a,#30
3358  04d5 262d          	jrne	L1671
3359                     ; 399 				led_red=0x00000000L;
3361  04d7 ae0000        	ldw	x,#0
3362  04da bf14          	ldw	_led_red+2,x
3363  04dc ae0000        	ldw	x,#0
3364  04df bf12          	ldw	_led_red,x
3365                     ; 400 				if(bMAIN)led_green=0xfffffff5L;
3367                     	btst	_bMAIN
3368  04e6 240e          	jruge	L3671
3371  04e8 aefff5        	ldw	x,#65525
3372  04eb bf18          	ldw	_led_green+2,x
3373  04ed aeffff        	ldw	x,#-1
3374  04f0 bf16          	ldw	_led_green,x
3376  04f2 ac9f069f      	jpf	L5471
3377  04f6               L3671:
3378                     ; 401 				else led_green=0xffffffffL;
3380  04f6 aeffff        	ldw	x,#65535
3381  04f9 bf18          	ldw	_led_green+2,x
3382  04fb aeffff        	ldw	x,#-1
3383  04fe bf16          	ldw	_led_green,x
3384  0500 ac9f069f      	jpf	L5471
3385  0504               L1671:
3386                     ; 404 			else if((flags&0b00111110)==0b00000100)
3388  0504 b60b          	ld	a,_flags
3389  0506 a43e          	and	a,#62
3390  0508 a104          	cp	a,#4
3391  050a 262d          	jrne	L1771
3392                     ; 406 				led_red=0x00010001L;
3394  050c ae0001        	ldw	x,#1
3395  050f bf14          	ldw	_led_red+2,x
3396  0511 ae0001        	ldw	x,#1
3397  0514 bf12          	ldw	_led_red,x
3398                     ; 407 				if(bMAIN)led_green=0xfffffff5L;
3400                     	btst	_bMAIN
3401  051b 240e          	jruge	L3771
3404  051d aefff5        	ldw	x,#65525
3405  0520 bf18          	ldw	_led_green+2,x
3406  0522 aeffff        	ldw	x,#-1
3407  0525 bf16          	ldw	_led_green,x
3409  0527 ac9f069f      	jpf	L5471
3410  052b               L3771:
3411                     ; 408 				else led_green=0xffffffffL;	
3413  052b aeffff        	ldw	x,#65535
3414  052e bf18          	ldw	_led_green+2,x
3415  0530 aeffff        	ldw	x,#-1
3416  0533 bf16          	ldw	_led_green,x
3417  0535 ac9f069f      	jpf	L5471
3418  0539               L1771:
3419                     ; 410 			else if(flags&0b00000010)
3421  0539 b60b          	ld	a,_flags
3422  053b a502          	bcp	a,#2
3423  053d 272d          	jreq	L1002
3424                     ; 412 				led_red=0x00010001L;
3426  053f ae0001        	ldw	x,#1
3427  0542 bf14          	ldw	_led_red+2,x
3428  0544 ae0001        	ldw	x,#1
3429  0547 bf12          	ldw	_led_red,x
3430                     ; 413 				if(bMAIN)led_green=0x00000005L;
3432                     	btst	_bMAIN
3433  054e 240e          	jruge	L3002
3436  0550 ae0005        	ldw	x,#5
3437  0553 bf18          	ldw	_led_green+2,x
3438  0555 ae0000        	ldw	x,#0
3439  0558 bf16          	ldw	_led_green,x
3441  055a ac9f069f      	jpf	L5471
3442  055e               L3002:
3443                     ; 414 				else led_green=0x00000000L;
3445  055e ae0000        	ldw	x,#0
3446  0561 bf18          	ldw	_led_green+2,x
3447  0563 ae0000        	ldw	x,#0
3448  0566 bf16          	ldw	_led_green,x
3449  0568 ac9f069f      	jpf	L5471
3450  056c               L1002:
3451                     ; 416 			else if(flags&0b00001000)
3453  056c b60b          	ld	a,_flags
3454  056e a508          	bcp	a,#8
3455  0570 272d          	jreq	L1102
3456                     ; 418 				led_red=0x00090009L;
3458  0572 ae0009        	ldw	x,#9
3459  0575 bf14          	ldw	_led_red+2,x
3460  0577 ae0009        	ldw	x,#9
3461  057a bf12          	ldw	_led_red,x
3462                     ; 419 				if(bMAIN)led_green=0x00000005L;
3464                     	btst	_bMAIN
3465  0581 240e          	jruge	L3102
3468  0583 ae0005        	ldw	x,#5
3469  0586 bf18          	ldw	_led_green+2,x
3470  0588 ae0000        	ldw	x,#0
3471  058b bf16          	ldw	_led_green,x
3473  058d ac9f069f      	jpf	L5471
3474  0591               L3102:
3475                     ; 420 				else led_green=0x00000000L;	
3477  0591 ae0000        	ldw	x,#0
3478  0594 bf18          	ldw	_led_green+2,x
3479  0596 ae0000        	ldw	x,#0
3480  0599 bf16          	ldw	_led_green,x
3481  059b ac9f069f      	jpf	L5471
3482  059f               L1102:
3483                     ; 422 			else if(flags&0b00010000)
3485  059f b60b          	ld	a,_flags
3486  05a1 a510          	bcp	a,#16
3487  05a3 272d          	jreq	L1202
3488                     ; 424 				led_red=0x00490049L;
3490  05a5 ae0049        	ldw	x,#73
3491  05a8 bf14          	ldw	_led_red+2,x
3492  05aa ae0049        	ldw	x,#73
3493  05ad bf12          	ldw	_led_red,x
3494                     ; 425 				if(bMAIN)led_green=0x00000005L;
3496                     	btst	_bMAIN
3497  05b4 240e          	jruge	L3202
3500  05b6 ae0005        	ldw	x,#5
3501  05b9 bf18          	ldw	_led_green+2,x
3502  05bb ae0000        	ldw	x,#0
3503  05be bf16          	ldw	_led_green,x
3505  05c0 ac9f069f      	jpf	L5471
3506  05c4               L3202:
3507                     ; 426 				else led_green=0x00000000L;	
3509  05c4 ae0000        	ldw	x,#0
3510  05c7 bf18          	ldw	_led_green+2,x
3511  05c9 ae0000        	ldw	x,#0
3512  05cc bf16          	ldw	_led_green,x
3513  05ce ac9f069f      	jpf	L5471
3514  05d2               L1202:
3515                     ; 430 				led_red=0x55555555L;
3517  05d2 ae5555        	ldw	x,#21845
3518  05d5 bf14          	ldw	_led_red+2,x
3519  05d7 ae5555        	ldw	x,#21845
3520  05da bf12          	ldw	_led_red,x
3521                     ; 431 				led_green=0xffffffffL;
3523  05dc aeffff        	ldw	x,#65535
3524  05df bf18          	ldw	_led_green+2,x
3525  05e1 aeffff        	ldw	x,#-1
3526  05e4 bf16          	ldw	_led_green,x
3527  05e6 ac9f069f      	jpf	L5471
3528  05ea               L7571:
3529                     ; 447 		else if((link==ON)&&((flags&0b00111110)==0))
3531  05ea b662          	ld	a,_link
3532  05ec a155          	cp	a,#85
3533  05ee 261d          	jrne	L3302
3535  05f0 b60b          	ld	a,_flags
3536  05f2 a53e          	bcp	a,#62
3537  05f4 2617          	jrne	L3302
3538                     ; 449 			led_red=0x00000000L;
3540  05f6 ae0000        	ldw	x,#0
3541  05f9 bf14          	ldw	_led_red+2,x
3542  05fb ae0000        	ldw	x,#0
3543  05fe bf12          	ldw	_led_red,x
3544                     ; 450 			led_green=0xffffffffL;
3546  0600 aeffff        	ldw	x,#65535
3547  0603 bf18          	ldw	_led_green+2,x
3548  0605 aeffff        	ldw	x,#-1
3549  0608 bf16          	ldw	_led_green,x
3551  060a cc069f        	jra	L5471
3552  060d               L3302:
3553                     ; 453 		else if((flags&0b00111110)==0b00000100)
3555  060d b60b          	ld	a,_flags
3556  060f a43e          	and	a,#62
3557  0611 a104          	cp	a,#4
3558  0613 2616          	jrne	L7302
3559                     ; 455 			led_red=0x00010001L;
3561  0615 ae0001        	ldw	x,#1
3562  0618 bf14          	ldw	_led_red+2,x
3563  061a ae0001        	ldw	x,#1
3564  061d bf12          	ldw	_led_red,x
3565                     ; 456 			led_green=0xffffffffL;	
3567  061f aeffff        	ldw	x,#65535
3568  0622 bf18          	ldw	_led_green+2,x
3569  0624 aeffff        	ldw	x,#-1
3570  0627 bf16          	ldw	_led_green,x
3572  0629 2074          	jra	L5471
3573  062b               L7302:
3574                     ; 458 		else if(flags&0b00000010)
3576  062b b60b          	ld	a,_flags
3577  062d a502          	bcp	a,#2
3578  062f 2716          	jreq	L3402
3579                     ; 460 			led_red=0x00010001L;
3581  0631 ae0001        	ldw	x,#1
3582  0634 bf14          	ldw	_led_red+2,x
3583  0636 ae0001        	ldw	x,#1
3584  0639 bf12          	ldw	_led_red,x
3585                     ; 461 			led_green=0x00000000L;	
3587  063b ae0000        	ldw	x,#0
3588  063e bf18          	ldw	_led_green+2,x
3589  0640 ae0000        	ldw	x,#0
3590  0643 bf16          	ldw	_led_green,x
3592  0645 2058          	jra	L5471
3593  0647               L3402:
3594                     ; 463 		else if(flags&0b00001000)
3596  0647 b60b          	ld	a,_flags
3597  0649 a508          	bcp	a,#8
3598  064b 2716          	jreq	L7402
3599                     ; 465 			led_red=0x00090009L;
3601  064d ae0009        	ldw	x,#9
3602  0650 bf14          	ldw	_led_red+2,x
3603  0652 ae0009        	ldw	x,#9
3604  0655 bf12          	ldw	_led_red,x
3605                     ; 466 			led_green=0x00000000L;	
3607  0657 ae0000        	ldw	x,#0
3608  065a bf18          	ldw	_led_green+2,x
3609  065c ae0000        	ldw	x,#0
3610  065f bf16          	ldw	_led_green,x
3612  0661 203c          	jra	L5471
3613  0663               L7402:
3614                     ; 468 		else if(flags&0b00010000)
3616  0663 b60b          	ld	a,_flags
3617  0665 a510          	bcp	a,#16
3618  0667 2716          	jreq	L3502
3619                     ; 470 			led_red=0x00490049L;
3621  0669 ae0049        	ldw	x,#73
3622  066c bf14          	ldw	_led_red+2,x
3623  066e ae0049        	ldw	x,#73
3624  0671 bf12          	ldw	_led_red,x
3625                     ; 471 			led_green=0x00000000L;	
3627  0673 ae0000        	ldw	x,#0
3628  0676 bf18          	ldw	_led_green+2,x
3629  0678 ae0000        	ldw	x,#0
3630  067b bf16          	ldw	_led_green,x
3632  067d 2020          	jra	L5471
3633  067f               L3502:
3634                     ; 474 		else if((link==ON)&&(flags&0b00100000))
3636  067f b662          	ld	a,_link
3637  0681 a155          	cp	a,#85
3638  0683 261a          	jrne	L5471
3640  0685 b60b          	ld	a,_flags
3641  0687 a520          	bcp	a,#32
3642  0689 2714          	jreq	L5471
3643                     ; 476 			led_red=0x00000000L;
3645  068b ae0000        	ldw	x,#0
3646  068e bf14          	ldw	_led_red+2,x
3647  0690 ae0000        	ldw	x,#0
3648  0693 bf12          	ldw	_led_red,x
3649                     ; 477 			led_green=0x00030003L;
3651  0695 ae0003        	ldw	x,#3
3652  0698 bf18          	ldw	_led_green+2,x
3653  069a ae0003        	ldw	x,#3
3654  069d bf16          	ldw	_led_green,x
3655  069f               L5471:
3656                     ; 480 		if((jp_mode==jp1))
3658  069f b64a          	ld	a,_jp_mode
3659  06a1 a101          	cp	a,#1
3660  06a3 2618          	jrne	L1602
3661                     ; 482 			led_red=0x00000000L;
3663  06a5 ae0000        	ldw	x,#0
3664  06a8 bf14          	ldw	_led_red+2,x
3665  06aa ae0000        	ldw	x,#0
3666  06ad bf12          	ldw	_led_red,x
3667                     ; 483 			led_green=0x33333333L;
3669  06af ae3333        	ldw	x,#13107
3670  06b2 bf18          	ldw	_led_green+2,x
3671  06b4 ae3333        	ldw	x,#13107
3672  06b7 bf16          	ldw	_led_green,x
3674  06b9 acd207d2      	jpf	L5161
3675  06bd               L1602:
3676                     ; 485 		else if((jp_mode==jp2))
3678  06bd b64a          	ld	a,_jp_mode
3679  06bf a102          	cp	a,#2
3680  06c1 2703          	jreq	L63
3681  06c3 cc07d2        	jp	L5161
3682  06c6               L63:
3683                     ; 489 			led_red=0xccccccccL;
3685  06c6 aecccc        	ldw	x,#52428
3686  06c9 bf14          	ldw	_led_red+2,x
3687  06cb aecccc        	ldw	x,#-13108
3688  06ce bf12          	ldw	_led_red,x
3689                     ; 490 			led_green=0x00000000L;
3691  06d0 ae0000        	ldw	x,#0
3692  06d3 bf18          	ldw	_led_green+2,x
3693  06d5 ae0000        	ldw	x,#0
3694  06d8 bf16          	ldw	_led_green,x
3695  06da acd207d2      	jpf	L5161
3696  06de               L1471:
3697                     ; 493 	else if(jp_mode==jp3)
3699  06de b64a          	ld	a,_jp_mode
3700  06e0 a103          	cp	a,#3
3701  06e2 2703          	jreq	L04
3702  06e4 cc07d2        	jp	L5161
3703  06e7               L04:
3704                     ; 495 		if(main_cnt1<(5*ee_TZAS))
3706  06e7 9c            	rvf
3707  06e8 ce0016        	ldw	x,_ee_TZAS
3708  06eb 90ae0005      	ldw	y,#5
3709  06ef cd0000        	call	c_imul
3711  06f2 b34f          	cpw	x,_main_cnt1
3712  06f4 2d18          	jrsle	L3702
3713                     ; 497 			led_red=0x00000000L;
3715  06f6 ae0000        	ldw	x,#0
3716  06f9 bf14          	ldw	_led_red+2,x
3717  06fb ae0000        	ldw	x,#0
3718  06fe bf12          	ldw	_led_red,x
3719                     ; 498 			led_green=0x03030303L;
3721  0700 ae0303        	ldw	x,#771
3722  0703 bf18          	ldw	_led_green+2,x
3723  0705 ae0303        	ldw	x,#771
3724  0708 bf16          	ldw	_led_green,x
3726  070a acd207d2      	jpf	L5161
3727  070e               L3702:
3728                     ; 500 		else if((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS))))
3730  070e 9c            	rvf
3731  070f ce0016        	ldw	x,_ee_TZAS
3732  0712 90ae0005      	ldw	y,#5
3733  0716 cd0000        	call	c_imul
3735  0719 b34f          	cpw	x,_main_cnt1
3736  071b 2e29          	jrsge	L7702
3738  071d 9c            	rvf
3739  071e ce0016        	ldw	x,_ee_TZAS
3740  0721 90ae0005      	ldw	y,#5
3741  0725 cd0000        	call	c_imul
3743  0728 1c0046        	addw	x,#70
3744  072b b34f          	cpw	x,_main_cnt1
3745  072d 2d17          	jrsle	L7702
3746                     ; 502 			led_red=0x00000000L;
3748  072f ae0000        	ldw	x,#0
3749  0732 bf14          	ldw	_led_red+2,x
3750  0734 ae0000        	ldw	x,#0
3751  0737 bf12          	ldw	_led_red,x
3752                     ; 503 			led_green=0xffffffffL;	
3754  0739 aeffff        	ldw	x,#65535
3755  073c bf18          	ldw	_led_green+2,x
3756  073e aeffff        	ldw	x,#-1
3757  0741 bf16          	ldw	_led_green,x
3759  0743 cc07d2        	jra	L5161
3760  0746               L7702:
3761                     ; 506 		else if((flags&0b00011110)==0)
3763  0746 b60b          	ld	a,_flags
3764  0748 a51e          	bcp	a,#30
3765  074a 2616          	jrne	L3012
3766                     ; 508 			led_red=0x00000000L;
3768  074c ae0000        	ldw	x,#0
3769  074f bf14          	ldw	_led_red+2,x
3770  0751 ae0000        	ldw	x,#0
3771  0754 bf12          	ldw	_led_red,x
3772                     ; 509 			led_green=0xffffffffL;
3774  0756 aeffff        	ldw	x,#65535
3775  0759 bf18          	ldw	_led_green+2,x
3776  075b aeffff        	ldw	x,#-1
3777  075e bf16          	ldw	_led_green,x
3779  0760 2070          	jra	L5161
3780  0762               L3012:
3781                     ; 513 		else if((flags&0b00111110)==0b00000100)
3783  0762 b60b          	ld	a,_flags
3784  0764 a43e          	and	a,#62
3785  0766 a104          	cp	a,#4
3786  0768 2616          	jrne	L7012
3787                     ; 515 			led_red=0x00010001L;
3789  076a ae0001        	ldw	x,#1
3790  076d bf14          	ldw	_led_red+2,x
3791  076f ae0001        	ldw	x,#1
3792  0772 bf12          	ldw	_led_red,x
3793                     ; 516 			led_green=0xffffffffL;	
3795  0774 aeffff        	ldw	x,#65535
3796  0777 bf18          	ldw	_led_green+2,x
3797  0779 aeffff        	ldw	x,#-1
3798  077c bf16          	ldw	_led_green,x
3800  077e 2052          	jra	L5161
3801  0780               L7012:
3802                     ; 518 		else if(flags&0b00000010)
3804  0780 b60b          	ld	a,_flags
3805  0782 a502          	bcp	a,#2
3806  0784 2716          	jreq	L3112
3807                     ; 520 			led_red=0x00010001L;
3809  0786 ae0001        	ldw	x,#1
3810  0789 bf14          	ldw	_led_red+2,x
3811  078b ae0001        	ldw	x,#1
3812  078e bf12          	ldw	_led_red,x
3813                     ; 521 			led_green=0x00000000L;	
3815  0790 ae0000        	ldw	x,#0
3816  0793 bf18          	ldw	_led_green+2,x
3817  0795 ae0000        	ldw	x,#0
3818  0798 bf16          	ldw	_led_green,x
3820  079a 2036          	jra	L5161
3821  079c               L3112:
3822                     ; 523 		else if(flags&0b00001000)
3824  079c b60b          	ld	a,_flags
3825  079e a508          	bcp	a,#8
3826  07a0 2716          	jreq	L7112
3827                     ; 525 			led_red=0x00090009L;
3829  07a2 ae0009        	ldw	x,#9
3830  07a5 bf14          	ldw	_led_red+2,x
3831  07a7 ae0009        	ldw	x,#9
3832  07aa bf12          	ldw	_led_red,x
3833                     ; 526 			led_green=0x00000000L;	
3835  07ac ae0000        	ldw	x,#0
3836  07af bf18          	ldw	_led_green+2,x
3837  07b1 ae0000        	ldw	x,#0
3838  07b4 bf16          	ldw	_led_green,x
3840  07b6 201a          	jra	L5161
3841  07b8               L7112:
3842                     ; 528 		else if(flags&0b00010000)
3844  07b8 b60b          	ld	a,_flags
3845  07ba a510          	bcp	a,#16
3846  07bc 2714          	jreq	L5161
3847                     ; 530 			led_red=0x00490049L;
3849  07be ae0049        	ldw	x,#73
3850  07c1 bf14          	ldw	_led_red+2,x
3851  07c3 ae0049        	ldw	x,#73
3852  07c6 bf12          	ldw	_led_red,x
3853                     ; 531 			led_green=0xffffffffL;	
3855  07c8 aeffff        	ldw	x,#65535
3856  07cb bf18          	ldw	_led_green+2,x
3857  07cd aeffff        	ldw	x,#-1
3858  07d0 bf16          	ldw	_led_green,x
3859  07d2               L5161:
3860                     ; 535 }
3863  07d2 81            	ret
3891                     ; 538 void led_drv(void)
3891                     ; 539 {
3892                     	switch	.text
3893  07d3               _led_drv:
3897                     ; 541 GPIOA->DDR|=(1<<4);
3899  07d3 72185002      	bset	20482,#4
3900                     ; 542 GPIOA->CR1|=(1<<4);
3902  07d7 72185003      	bset	20483,#4
3903                     ; 543 GPIOA->CR2&=~(1<<4);
3905  07db 72195004      	bres	20484,#4
3906                     ; 544 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3908  07df b640          	ld	a,_led_red_buff+3
3909  07e1 a501          	bcp	a,#1
3910  07e3 2706          	jreq	L5312
3913  07e5 72185000      	bset	20480,#4
3915  07e9 2004          	jra	L7312
3916  07eb               L5312:
3917                     ; 545 else GPIOA->ODR&=~(1<<4); 
3919  07eb 72195000      	bres	20480,#4
3920  07ef               L7312:
3921                     ; 548 GPIOA->DDR|=(1<<5);
3923  07ef 721a5002      	bset	20482,#5
3924                     ; 549 GPIOA->CR1|=(1<<5);
3926  07f3 721a5003      	bset	20483,#5
3927                     ; 550 GPIOA->CR2&=~(1<<5);	
3929  07f7 721b5004      	bres	20484,#5
3930                     ; 551 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3932  07fb b63c          	ld	a,_led_green_buff+3
3933  07fd a501          	bcp	a,#1
3934  07ff 2706          	jreq	L1412
3937  0801 721a5000      	bset	20480,#5
3939  0805 2004          	jra	L3412
3940  0807               L1412:
3941                     ; 552 else GPIOA->ODR&=~(1<<5);
3943  0807 721b5000      	bres	20480,#5
3944  080b               L3412:
3945                     ; 555 led_red_buff>>=1;
3947  080b 373d          	sra	_led_red_buff
3948  080d 363e          	rrc	_led_red_buff+1
3949  080f 363f          	rrc	_led_red_buff+2
3950  0811 3640          	rrc	_led_red_buff+3
3951                     ; 556 led_green_buff>>=1;
3953  0813 3739          	sra	_led_green_buff
3954  0815 363a          	rrc	_led_green_buff+1
3955  0817 363b          	rrc	_led_green_buff+2
3956  0819 363c          	rrc	_led_green_buff+3
3957                     ; 557 if(++led_drv_cnt>32)
3959  081b 3c1a          	inc	_led_drv_cnt
3960  081d b61a          	ld	a,_led_drv_cnt
3961  081f a121          	cp	a,#33
3962  0821 2512          	jrult	L5412
3963                     ; 559 	led_drv_cnt=0;
3965  0823 3f1a          	clr	_led_drv_cnt
3966                     ; 560 	led_red_buff=led_red;
3968  0825 be14          	ldw	x,_led_red+2
3969  0827 bf3f          	ldw	_led_red_buff+2,x
3970  0829 be12          	ldw	x,_led_red
3971  082b bf3d          	ldw	_led_red_buff,x
3972                     ; 561 	led_green_buff=led_green;
3974  082d be18          	ldw	x,_led_green+2
3975  082f bf3b          	ldw	_led_green_buff+2,x
3976  0831 be16          	ldw	x,_led_green
3977  0833 bf39          	ldw	_led_green_buff,x
3978  0835               L5412:
3979                     ; 567 } 
3982  0835 81            	ret
4008                     ; 570 void JP_drv(void)
4008                     ; 571 {
4009                     	switch	.text
4010  0836               _JP_drv:
4014                     ; 573 GPIOD->DDR&=~(1<<6);
4016  0836 721d5011      	bres	20497,#6
4017                     ; 574 GPIOD->CR1|=(1<<6);
4019  083a 721c5012      	bset	20498,#6
4020                     ; 575 GPIOD->CR2&=~(1<<6);
4022  083e 721d5013      	bres	20499,#6
4023                     ; 577 GPIOD->DDR&=~(1<<7);
4025  0842 721f5011      	bres	20497,#7
4026                     ; 578 GPIOD->CR1|=(1<<7);
4028  0846 721e5012      	bset	20498,#7
4029                     ; 579 GPIOD->CR2&=~(1<<7);
4031  084a 721f5013      	bres	20499,#7
4032                     ; 581 if(GPIOD->IDR&(1<<6))
4034  084e c65010        	ld	a,20496
4035  0851 a540          	bcp	a,#64
4036  0853 270a          	jreq	L7512
4037                     ; 583 	if(cnt_JP0<10)
4039  0855 b649          	ld	a,_cnt_JP0
4040  0857 a10a          	cp	a,#10
4041  0859 2411          	jruge	L3612
4042                     ; 585 		cnt_JP0++;
4044  085b 3c49          	inc	_cnt_JP0
4045  085d 200d          	jra	L3612
4046  085f               L7512:
4047                     ; 588 else if(!(GPIOD->IDR&(1<<6)))
4049  085f c65010        	ld	a,20496
4050  0862 a540          	bcp	a,#64
4051  0864 2606          	jrne	L3612
4052                     ; 590 	if(cnt_JP0)
4054  0866 3d49          	tnz	_cnt_JP0
4055  0868 2702          	jreq	L3612
4056                     ; 592 		cnt_JP0--;
4058  086a 3a49          	dec	_cnt_JP0
4059  086c               L3612:
4060                     ; 596 if(GPIOD->IDR&(1<<7))
4062  086c c65010        	ld	a,20496
4063  086f a580          	bcp	a,#128
4064  0871 270a          	jreq	L1712
4065                     ; 598 	if(cnt_JP1<10)
4067  0873 b648          	ld	a,_cnt_JP1
4068  0875 a10a          	cp	a,#10
4069  0877 2411          	jruge	L5712
4070                     ; 600 		cnt_JP1++;
4072  0879 3c48          	inc	_cnt_JP1
4073  087b 200d          	jra	L5712
4074  087d               L1712:
4075                     ; 603 else if(!(GPIOD->IDR&(1<<7)))
4077  087d c65010        	ld	a,20496
4078  0880 a580          	bcp	a,#128
4079  0882 2606          	jrne	L5712
4080                     ; 605 	if(cnt_JP1)
4082  0884 3d48          	tnz	_cnt_JP1
4083  0886 2702          	jreq	L5712
4084                     ; 607 		cnt_JP1--;
4086  0888 3a48          	dec	_cnt_JP1
4087  088a               L5712:
4088                     ; 612 if((cnt_JP0==10)&&(cnt_JP1==10))
4090  088a b649          	ld	a,_cnt_JP0
4091  088c a10a          	cp	a,#10
4092  088e 2608          	jrne	L3022
4094  0890 b648          	ld	a,_cnt_JP1
4095  0892 a10a          	cp	a,#10
4096  0894 2602          	jrne	L3022
4097                     ; 614 	jp_mode=jp0;
4099  0896 3f4a          	clr	_jp_mode
4100  0898               L3022:
4101                     ; 616 if((cnt_JP0==0)&&(cnt_JP1==10))
4103  0898 3d49          	tnz	_cnt_JP0
4104  089a 260a          	jrne	L5022
4106  089c b648          	ld	a,_cnt_JP1
4107  089e a10a          	cp	a,#10
4108  08a0 2604          	jrne	L5022
4109                     ; 618 	jp_mode=jp1;
4111  08a2 3501004a      	mov	_jp_mode,#1
4112  08a6               L5022:
4113                     ; 620 if((cnt_JP0==10)&&(cnt_JP1==0))
4115  08a6 b649          	ld	a,_cnt_JP0
4116  08a8 a10a          	cp	a,#10
4117  08aa 2608          	jrne	L7022
4119  08ac 3d48          	tnz	_cnt_JP1
4120  08ae 2604          	jrne	L7022
4121                     ; 622 	jp_mode=jp2;
4123  08b0 3502004a      	mov	_jp_mode,#2
4124  08b4               L7022:
4125                     ; 624 if((cnt_JP0==0)&&(cnt_JP1==0))
4127  08b4 3d49          	tnz	_cnt_JP0
4128  08b6 2608          	jrne	L1122
4130  08b8 3d48          	tnz	_cnt_JP1
4131  08ba 2604          	jrne	L1122
4132                     ; 626 	jp_mode=jp3;
4134  08bc 3503004a      	mov	_jp_mode,#3
4135  08c0               L1122:
4136                     ; 629 }
4139  08c0 81            	ret
4171                     ; 632 void link_drv(void)		//10Hz
4171                     ; 633 {
4172                     	switch	.text
4173  08c1               _link_drv:
4177                     ; 634 if(jp_mode!=jp3)
4179  08c1 b64a          	ld	a,_jp_mode
4180  08c3 a103          	cp	a,#3
4181  08c5 2744          	jreq	L3222
4182                     ; 636 	if(link_cnt<52)link_cnt++;
4184  08c7 b661          	ld	a,_link_cnt
4185  08c9 a134          	cp	a,#52
4186  08cb 2402          	jruge	L5222
4189  08cd 3c61          	inc	_link_cnt
4190  08cf               L5222:
4191                     ; 637 	if(link_cnt==49)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
4193  08cf b661          	ld	a,_link_cnt
4194  08d1 a131          	cp	a,#49
4195  08d3 2606          	jrne	L7222
4198  08d5 b60b          	ld	a,_flags
4199  08d7 a4c1          	and	a,#193
4200  08d9 b70b          	ld	_flags,a
4201  08db               L7222:
4202                     ; 638 	if(link_cnt==50)
4204  08db b661          	ld	a,_link_cnt
4205  08dd a132          	cp	a,#50
4206  08df 262e          	jrne	L1422
4207                     ; 640 		link=OFF;
4209  08e1 35aa0062      	mov	_link,#170
4210                     ; 645 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
4212  08e5 b604          	ld	a,_bps_class
4213  08e7 a101          	cp	a,#1
4214  08e9 2606          	jrne	L3322
4217  08eb 72100001      	bset	_bMAIN
4219  08ef 2004          	jra	L5322
4220  08f1               L3322:
4221                     ; 646 		else bMAIN=0;
4223  08f1 72110001      	bres	_bMAIN
4224  08f5               L5322:
4225                     ; 648 		cnt_net_drv=0;
4227  08f5 3f32          	clr	_cnt_net_drv
4228                     ; 649     		if(!res_fl_)
4230  08f7 725d000a      	tnz	_res_fl_
4231  08fb 2612          	jrne	L1422
4232                     ; 651 	    		bRES_=1;
4234  08fd 35010011      	mov	_bRES_,#1
4235                     ; 652 	    		res_fl_=1;
4237  0901 a601          	ld	a,#1
4238  0903 ae000a        	ldw	x,#_res_fl_
4239  0906 cd0000        	call	c_eewrc
4241  0909 2004          	jra	L1422
4242  090b               L3222:
4243                     ; 656 else link=OFF;	
4245  090b 35aa0062      	mov	_link,#170
4246  090f               L1422:
4247                     ; 657 } 
4250  090f 81            	ret
4320                     .const:	section	.text
4321  0000               L25:
4322  0000 0000000b      	dc.l	11
4323  0004               L45:
4324  0004 00000001      	dc.l	1
4325                     ; 661 void vent_drv(void)
4325                     ; 662 {
4326                     	switch	.text
4327  0910               _vent_drv:
4329  0910 520e          	subw	sp,#14
4330       0000000e      OFST:	set	14
4333                     ; 665 	short vent_pwm_i_necc=400;
4335  0912 ae0190        	ldw	x,#400
4336  0915 1f07          	ldw	(OFST-7,sp),x
4337                     ; 666 	short vent_pwm_t_necc=400;
4339  0917 ae0190        	ldw	x,#400
4340  091a 1f09          	ldw	(OFST-5,sp),x
4341                     ; 667 	short vent_pwm_max_necc=400;
4343                     ; 672 	tempSL=36000L/(signed long)ee_Umax;
4345  091c ce0014        	ldw	x,_ee_Umax
4346  091f cd0000        	call	c_itolx
4348  0922 96            	ldw	x,sp
4349  0923 1c0001        	addw	x,#OFST-13
4350  0926 cd0000        	call	c_rtol
4352  0929 ae8ca0        	ldw	x,#36000
4353  092c bf02          	ldw	c_lreg+2,x
4354  092e ae0000        	ldw	x,#0
4355  0931 bf00          	ldw	c_lreg,x
4356  0933 96            	ldw	x,sp
4357  0934 1c0001        	addw	x,#OFST-13
4358  0937 cd0000        	call	c_ldiv
4360  093a 96            	ldw	x,sp
4361  093b 1c000b        	addw	x,#OFST-3
4362  093e cd0000        	call	c_rtol
4364                     ; 673 	tempSL=(signed long)I/tempSL;
4366  0941 be6e          	ldw	x,_I
4367  0943 cd0000        	call	c_itolx
4369  0946 96            	ldw	x,sp
4370  0947 1c000b        	addw	x,#OFST-3
4371  094a cd0000        	call	c_ldiv
4373  094d 96            	ldw	x,sp
4374  094e 1c000b        	addw	x,#OFST-3
4375  0951 cd0000        	call	c_rtol
4377                     ; 675 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
4379  0954 ce0004        	ldw	x,_ee_DEVICE
4380  0957 a30001        	cpw	x,#1
4381  095a 2613          	jrne	L5722
4384  095c be6e          	ldw	x,_I
4385  095e 90ce0002      	ldw	y,_ee_IMAXVENT
4386  0962 cd0000        	call	c_idiv
4388  0965 cd0000        	call	c_itolx
4390  0968 96            	ldw	x,sp
4391  0969 1c000b        	addw	x,#OFST-3
4392  096c cd0000        	call	c_rtol
4394  096f               L5722:
4395                     ; 677 	if(tempSL>10)vent_pwm_i_necc=1000;
4397  096f 9c            	rvf
4398  0970 96            	ldw	x,sp
4399  0971 1c000b        	addw	x,#OFST-3
4400  0974 cd0000        	call	c_ltor
4402  0977 ae0000        	ldw	x,#L25
4403  097a cd0000        	call	c_lcmp
4405  097d 2f07          	jrslt	L7722
4408  097f ae03e8        	ldw	x,#1000
4409  0982 1f07          	ldw	(OFST-7,sp),x
4411  0984 2025          	jra	L1032
4412  0986               L7722:
4413                     ; 678 	else if(tempSL<1)vent_pwm_i_necc=400;
4415  0986 9c            	rvf
4416  0987 96            	ldw	x,sp
4417  0988 1c000b        	addw	x,#OFST-3
4418  098b cd0000        	call	c_ltor
4420  098e ae0004        	ldw	x,#L45
4421  0991 cd0000        	call	c_lcmp
4423  0994 2e07          	jrsge	L3032
4426  0996 ae0190        	ldw	x,#400
4427  0999 1f07          	ldw	(OFST-7,sp),x
4429  099b 200e          	jra	L1032
4430  099d               L3032:
4431                     ; 679 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
4433  099d 1e0d          	ldw	x,(OFST-1,sp)
4434  099f 90ae003c      	ldw	y,#60
4435  09a3 cd0000        	call	c_imul
4437  09a6 1c0190        	addw	x,#400
4438  09a9 1f07          	ldw	(OFST-7,sp),x
4439  09ab               L1032:
4440                     ; 680 	gran(&vent_pwm_i_necc,400,1000);
4442  09ab ae03e8        	ldw	x,#1000
4443  09ae 89            	pushw	x
4444  09af ae0190        	ldw	x,#400
4445  09b2 89            	pushw	x
4446  09b3 96            	ldw	x,sp
4447  09b4 1c000b        	addw	x,#OFST-3
4448  09b7 cd00c2        	call	_gran
4450  09ba 5b04          	addw	sp,#4
4451                     ; 682 	tempSL=(signed long)T;
4453  09bc b667          	ld	a,_T
4454  09be b703          	ld	c_lreg+3,a
4455  09c0 48            	sll	a
4456  09c1 4f            	clr	a
4457  09c2 a200          	sbc	a,#0
4458  09c4 b702          	ld	c_lreg+2,a
4459  09c6 b701          	ld	c_lreg+1,a
4460  09c8 b700          	ld	c_lreg,a
4461  09ca 96            	ldw	x,sp
4462  09cb 1c000b        	addw	x,#OFST-3
4463  09ce cd0000        	call	c_rtol
4465                     ; 683 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=400;
4467  09d1 9c            	rvf
4468  09d2 ce000e        	ldw	x,_ee_tsign
4469  09d5 cd0000        	call	c_itolx
4471  09d8 a61e          	ld	a,#30
4472  09da cd0000        	call	c_lsbc
4474  09dd 96            	ldw	x,sp
4475  09de 1c000b        	addw	x,#OFST-3
4476  09e1 cd0000        	call	c_lcmp
4478  09e4 2f07          	jrslt	L7032
4481  09e6 ae0190        	ldw	x,#400
4482  09e9 1f09          	ldw	(OFST-5,sp),x
4484  09eb 2030          	jra	L1132
4485  09ed               L7032:
4486                     ; 684 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
4488  09ed 9c            	rvf
4489  09ee ce000e        	ldw	x,_ee_tsign
4490  09f1 cd0000        	call	c_itolx
4492  09f4 96            	ldw	x,sp
4493  09f5 1c000b        	addw	x,#OFST-3
4494  09f8 cd0000        	call	c_lcmp
4496  09fb 2c07          	jrsgt	L3132
4499  09fd ae03e8        	ldw	x,#1000
4500  0a00 1f09          	ldw	(OFST-5,sp),x
4502  0a02 2019          	jra	L1132
4503  0a04               L3132:
4504                     ; 685 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
4506  0a04 ce000e        	ldw	x,_ee_tsign
4507  0a07 1d001e        	subw	x,#30
4508  0a0a 1f03          	ldw	(OFST-11,sp),x
4509  0a0c 1e0d          	ldw	x,(OFST-1,sp)
4510  0a0e 72f003        	subw	x,(OFST-11,sp)
4511  0a11 90ae0014      	ldw	y,#20
4512  0a15 cd0000        	call	c_imul
4514  0a18 1c0190        	addw	x,#400
4515  0a1b 1f09          	ldw	(OFST-5,sp),x
4516  0a1d               L1132:
4517                     ; 686 	gran(&vent_pwm_t_necc,400,1000);
4519  0a1d ae03e8        	ldw	x,#1000
4520  0a20 89            	pushw	x
4521  0a21 ae0190        	ldw	x,#400
4522  0a24 89            	pushw	x
4523  0a25 96            	ldw	x,sp
4524  0a26 1c000d        	addw	x,#OFST-1
4525  0a29 cd00c2        	call	_gran
4527  0a2c 5b04          	addw	sp,#4
4528                     ; 688 	vent_pwm_max_necc=vent_pwm_i_necc;
4530  0a2e 1e07          	ldw	x,(OFST-7,sp)
4531  0a30 1f05          	ldw	(OFST-9,sp),x
4532                     ; 689 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
4534  0a32 9c            	rvf
4535  0a33 1e09          	ldw	x,(OFST-5,sp)
4536  0a35 1307          	cpw	x,(OFST-7,sp)
4537  0a37 2d04          	jrsle	L7132
4540  0a39 1e09          	ldw	x,(OFST-5,sp)
4541  0a3b 1f05          	ldw	(OFST-9,sp),x
4542  0a3d               L7132:
4543                     ; 691 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
4545  0a3d 9c            	rvf
4546  0a3e be05          	ldw	x,_vent_pwm
4547  0a40 1305          	cpw	x,(OFST-9,sp)
4548  0a42 2e07          	jrsge	L1232
4551  0a44 be05          	ldw	x,_vent_pwm
4552  0a46 1c000a        	addw	x,#10
4553  0a49 bf05          	ldw	_vent_pwm,x
4554  0a4b               L1232:
4555                     ; 692 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
4557  0a4b 9c            	rvf
4558  0a4c be05          	ldw	x,_vent_pwm
4559  0a4e 1305          	cpw	x,(OFST-9,sp)
4560  0a50 2d07          	jrsle	L3232
4563  0a52 be05          	ldw	x,_vent_pwm
4564  0a54 1d000a        	subw	x,#10
4565  0a57 bf05          	ldw	_vent_pwm,x
4566  0a59               L3232:
4567                     ; 693 	gran(&vent_pwm,400,1000);
4569  0a59 ae03e8        	ldw	x,#1000
4570  0a5c 89            	pushw	x
4571  0a5d ae0190        	ldw	x,#400
4572  0a60 89            	pushw	x
4573  0a61 ae0005        	ldw	x,#_vent_pwm
4574  0a64 cd00c2        	call	_gran
4576  0a67 5b04          	addw	sp,#4
4577                     ; 697 	if(bVENT_BLOCK)vent_pwm=0;
4579  0a69 3d00          	tnz	_bVENT_BLOCK
4580  0a6b 2703          	jreq	L5232
4583  0a6d 5f            	clrw	x
4584  0a6e bf05          	ldw	_vent_pwm,x
4585  0a70               L5232:
4586                     ; 698 }
4589  0a70 5b0e          	addw	sp,#14
4590  0a72 81            	ret
4625                     ; 703 void pwr_drv(void)
4625                     ; 704 {
4626                     	switch	.text
4627  0a73               _pwr_drv:
4631                     ; 708 BLOCK_INIT
4633  0a73 72145007      	bset	20487,#2
4636  0a77 72145008      	bset	20488,#2
4639  0a7b 72155009      	bres	20489,#2
4640                     ; 710 if(main_cnt1<1500)main_cnt1++;
4642  0a7f 9c            	rvf
4643  0a80 be4f          	ldw	x,_main_cnt1
4644  0a82 a305dc        	cpw	x,#1500
4645  0a85 2e07          	jrsge	L7332
4648  0a87 be4f          	ldw	x,_main_cnt1
4649  0a89 1c0001        	addw	x,#1
4650  0a8c bf4f          	ldw	_main_cnt1,x
4651  0a8e               L7332:
4652                     ; 712 if((main_cnt1<(5*ee_TZAS))&&(bps_class!=bpsIPS))
4654  0a8e 9c            	rvf
4655  0a8f ce0016        	ldw	x,_ee_TZAS
4656  0a92 90ae0005      	ldw	y,#5
4657  0a96 cd0000        	call	c_imul
4659  0a99 b34f          	cpw	x,_main_cnt1
4660  0a9b 2d12          	jrsle	L1432
4662  0a9d b604          	ld	a,_bps_class
4663  0a9f a101          	cp	a,#1
4664  0aa1 270c          	jreq	L1432
4665                     ; 714 	BLOCK_ON
4667  0aa3 72145005      	bset	20485,#2
4670  0aa7 35010000      	mov	_bVENT_BLOCK,#1
4672  0aab ac4c0b4c      	jpf	L3432
4673  0aaf               L1432:
4674                     ; 717 else if(bps_class==bpsIPS)
4676  0aaf b604          	ld	a,_bps_class
4677  0ab1 a101          	cp	a,#1
4678  0ab3 2621          	jrne	L5432
4679                     ; 720 		if(bBL_IPS)
4681                     	btst	_bBL_IPS
4682  0aba 240b          	jruge	L7432
4683                     ; 722 			 BLOCK_ON
4685  0abc 72145005      	bset	20485,#2
4688  0ac0 35010000      	mov	_bVENT_BLOCK,#1
4690  0ac4 cc0b4c        	jra	L3432
4691  0ac7               L7432:
4692                     ; 725 		else if(!bBL_IPS)
4694                     	btst	_bBL_IPS
4695  0acc 257e          	jrult	L3432
4696                     ; 727 			  BLOCK_OFF
4698  0ace 72155005      	bres	20485,#2
4701  0ad2 3f00          	clr	_bVENT_BLOCK
4702  0ad4 2076          	jra	L3432
4703  0ad6               L5432:
4704                     ; 731 else if(((main_cnt1>(5*ee_TZAS))&&(main_cnt1<(70+(5*ee_TZAS)))))
4706  0ad6 9c            	rvf
4707  0ad7 ce0016        	ldw	x,_ee_TZAS
4708  0ada 90ae0005      	ldw	y,#5
4709  0ade cd0000        	call	c_imul
4711  0ae1 b34f          	cpw	x,_main_cnt1
4712  0ae3 2e49          	jrsge	L7532
4714  0ae5 9c            	rvf
4715  0ae6 ce0016        	ldw	x,_ee_TZAS
4716  0ae9 90ae0005      	ldw	y,#5
4717  0aed cd0000        	call	c_imul
4719  0af0 1c0046        	addw	x,#70
4720  0af3 b34f          	cpw	x,_main_cnt1
4721  0af5 2d37          	jrsle	L7532
4722                     ; 733 	if(bps_class==bpsIPS)
4724  0af7 b604          	ld	a,_bps_class
4725  0af9 a101          	cp	a,#1
4726  0afb 2608          	jrne	L1632
4727                     ; 735 		  BLOCK_OFF
4729  0afd 72155005      	bres	20485,#2
4732  0b01 3f00          	clr	_bVENT_BLOCK
4734  0b03 2047          	jra	L3432
4735  0b05               L1632:
4736                     ; 738 	else if(bps_class==bpsIBEP)
4738  0b05 3d04          	tnz	_bps_class
4739  0b07 2643          	jrne	L3432
4740                     ; 740 		if(ee_DEVICE)
4742  0b09 ce0004        	ldw	x,_ee_DEVICE
4743  0b0c 2718          	jreq	L7632
4744                     ; 742 			if(flags&0b00100000)BLOCK_ON //GPIOB->ODR|=(1<<2);
4746  0b0e b60b          	ld	a,_flags
4747  0b10 a520          	bcp	a,#32
4748  0b12 270a          	jreq	L1732
4751  0b14 72145005      	bset	20485,#2
4754  0b18 35010000      	mov	_bVENT_BLOCK,#1
4756  0b1c 202e          	jra	L3432
4757  0b1e               L1732:
4758                     ; 743 			else	BLOCK_OFF //GPIOB->ODR&=~(1<<2);
4760  0b1e 72155005      	bres	20485,#2
4763  0b22 3f00          	clr	_bVENT_BLOCK
4764  0b24 2026          	jra	L3432
4765  0b26               L7632:
4766                     ; 747 			BLOCK_OFF
4768  0b26 72155005      	bres	20485,#2
4771  0b2a 3f00          	clr	_bVENT_BLOCK
4772  0b2c 201e          	jra	L3432
4773  0b2e               L7532:
4774                     ; 752 else if(bBL)
4776                     	btst	_bBL
4777  0b33 240a          	jruge	L1042
4778                     ; 754 	BLOCK_ON
4780  0b35 72145005      	bset	20485,#2
4783  0b39 35010000      	mov	_bVENT_BLOCK,#1
4785  0b3d 200d          	jra	L3432
4786  0b3f               L1042:
4787                     ; 757 else if(!bBL)
4789                     	btst	_bBL
4790  0b44 2506          	jrult	L3432
4791                     ; 759 	BLOCK_OFF
4793  0b46 72155005      	bres	20485,#2
4796  0b4a 3f00          	clr	_bVENT_BLOCK
4797  0b4c               L3432:
4798                     ; 763 gran(&pwm_u,2,1020);
4800  0b4c ae03fc        	ldw	x,#1020
4801  0b4f 89            	pushw	x
4802  0b50 ae0002        	ldw	x,#2
4803  0b53 89            	pushw	x
4804  0b54 ae000c        	ldw	x,#_pwm_u
4805  0b57 cd00c2        	call	_gran
4807  0b5a 5b04          	addw	sp,#4
4808                     ; 773 TIM1->CCR2H= (char)(pwm_u/256);	
4810  0b5c be0c          	ldw	x,_pwm_u
4811  0b5e 90ae0100      	ldw	y,#256
4812  0b62 cd0000        	call	c_idiv
4814  0b65 9f            	ld	a,xl
4815  0b66 c75267        	ld	21095,a
4816                     ; 774 TIM1->CCR2L= (char)pwm_u;
4818  0b69 55000d5268    	mov	21096,_pwm_u+1
4819                     ; 776 TIM1->CCR1H= (char)(pwm_i/256);	
4821  0b6e be0e          	ldw	x,_pwm_i
4822  0b70 90ae0100      	ldw	y,#256
4823  0b74 cd0000        	call	c_idiv
4825  0b77 9f            	ld	a,xl
4826  0b78 c75265        	ld	21093,a
4827                     ; 777 TIM1->CCR1L= (char)pwm_i;
4829  0b7b 55000f5266    	mov	21094,_pwm_i+1
4830                     ; 779 TIM1->CCR3H= (char)(vent_pwm/256);	
4832  0b80 be05          	ldw	x,_vent_pwm
4833  0b82 90ae0100      	ldw	y,#256
4834  0b86 cd0000        	call	c_idiv
4836  0b89 9f            	ld	a,xl
4837  0b8a c75269        	ld	21097,a
4838                     ; 780 TIM1->CCR3L= (char)vent_pwm;
4840  0b8d 550006526a    	mov	21098,_vent_pwm+1
4841                     ; 781 }
4844  0b92 81            	ret
4882                     ; 786 void pwr_hndl(void)				
4882                     ; 787 {
4883                     	switch	.text
4884  0b93               _pwr_hndl:
4888                     ; 788 if(jp_mode==jp3)
4890  0b93 b64a          	ld	a,_jp_mode
4891  0b95 a103          	cp	a,#3
4892  0b97 2627          	jrne	L7142
4893                     ; 790 	if((flags&0b00001010)==0)
4895  0b99 b60b          	ld	a,_flags
4896  0b9b a50a          	bcp	a,#10
4897  0b9d 260d          	jrne	L1242
4898                     ; 792 		pwm_u=500;
4900  0b9f ae01f4        	ldw	x,#500
4901  0ba2 bf0c          	ldw	_pwm_u,x
4902                     ; 794 		bBL=0;
4904  0ba4 72110003      	bres	_bBL
4906  0ba8 acae0cae      	jpf	L7242
4907  0bac               L1242:
4908                     ; 796 	else if(flags&0b00001010)
4910  0bac b60b          	ld	a,_flags
4911  0bae a50a          	bcp	a,#10
4912  0bb0 2603          	jrne	L26
4913  0bb2 cc0cae        	jp	L7242
4914  0bb5               L26:
4915                     ; 798 		pwm_u=0;
4917  0bb5 5f            	clrw	x
4918  0bb6 bf0c          	ldw	_pwm_u,x
4919                     ; 800 		bBL=1;
4921  0bb8 72100003      	bset	_bBL
4922  0bbc acae0cae      	jpf	L7242
4923  0bc0               L7142:
4924                     ; 804 else if(jp_mode==jp2)
4926  0bc0 b64a          	ld	a,_jp_mode
4927  0bc2 a102          	cp	a,#2
4928  0bc4 2610          	jrne	L1342
4929                     ; 806 	pwm_u=0;
4931  0bc6 5f            	clrw	x
4932  0bc7 bf0c          	ldw	_pwm_u,x
4933                     ; 807 	pwm_i=0x3ff;
4935  0bc9 ae03ff        	ldw	x,#1023
4936  0bcc bf0e          	ldw	_pwm_i,x
4937                     ; 808 	bBL=0;
4939  0bce 72110003      	bres	_bBL
4941  0bd2 acae0cae      	jpf	L7242
4942  0bd6               L1342:
4943                     ; 810 else if(jp_mode==jp1)
4945  0bd6 b64a          	ld	a,_jp_mode
4946  0bd8 a101          	cp	a,#1
4947  0bda 2612          	jrne	L5342
4948                     ; 812 	pwm_u=0x3ff;
4950  0bdc ae03ff        	ldw	x,#1023
4951  0bdf bf0c          	ldw	_pwm_u,x
4952                     ; 813 	pwm_i=0x3ff;
4954  0be1 ae03ff        	ldw	x,#1023
4955  0be4 bf0e          	ldw	_pwm_i,x
4956                     ; 814 	bBL=0;
4958  0be6 72110003      	bres	_bBL
4960  0bea acae0cae      	jpf	L7242
4961  0bee               L5342:
4962                     ; 817 else if((bMAIN)&&(link==ON)/*&&(ee_AVT_MODE!=0x55)*/)
4964                     	btst	_bMAIN
4965  0bf3 2417          	jruge	L1442
4967  0bf5 b662          	ld	a,_link
4968  0bf7 a155          	cp	a,#85
4969  0bf9 2611          	jrne	L1442
4970                     ; 819 	pwm_u=volum_u_main_;
4972  0bfb be1d          	ldw	x,_volum_u_main_
4973  0bfd bf0c          	ldw	_pwm_u,x
4974                     ; 820 	pwm_i=0x3ff;
4976  0bff ae03ff        	ldw	x,#1023
4977  0c02 bf0e          	ldw	_pwm_i,x
4978                     ; 821 	bBL_IPS=0;
4980  0c04 72110000      	bres	_bBL_IPS
4982  0c08 acae0cae      	jpf	L7242
4983  0c0c               L1442:
4984                     ; 824 else if(link==OFF)
4986  0c0c b662          	ld	a,_link
4987  0c0e a1aa          	cp	a,#170
4988  0c10 2650          	jrne	L5442
4989                     ; 833  	if(ee_DEVICE)
4991  0c12 ce0004        	ldw	x,_ee_DEVICE
4992  0c15 270d          	jreq	L7442
4993                     ; 835 		pwm_u=0x00;
4995  0c17 5f            	clrw	x
4996  0c18 bf0c          	ldw	_pwm_u,x
4997                     ; 836 		pwm_i=0x00;
4999  0c1a 5f            	clrw	x
5000  0c1b bf0e          	ldw	_pwm_i,x
5001                     ; 837 		bBL=1;
5003  0c1d 72100003      	bset	_bBL
5005  0c21 cc0cae        	jra	L7242
5006  0c24               L7442:
5007                     ; 841 		if((flags&0b00011010)==0)
5009  0c24 b60b          	ld	a,_flags
5010  0c26 a51a          	bcp	a,#26
5011  0c28 2622          	jrne	L3542
5012                     ; 843 			pwm_u=ee_U_AVT;
5014  0c2a ce000c        	ldw	x,_ee_U_AVT
5015  0c2d bf0c          	ldw	_pwm_u,x
5016                     ; 844 			gran(&pwm_u,0,1020);
5018  0c2f ae03fc        	ldw	x,#1020
5019  0c32 89            	pushw	x
5020  0c33 5f            	clrw	x
5021  0c34 89            	pushw	x
5022  0c35 ae000c        	ldw	x,#_pwm_u
5023  0c38 cd00c2        	call	_gran
5025  0c3b 5b04          	addw	sp,#4
5026                     ; 845 		    	pwm_i=0x3ff;
5028  0c3d ae03ff        	ldw	x,#1023
5029  0c40 bf0e          	ldw	_pwm_i,x
5030                     ; 846 			bBL=0;
5032  0c42 72110003      	bres	_bBL
5033                     ; 847 			bBL_IPS=0;
5035  0c46 72110000      	bres	_bBL_IPS
5037  0c4a 2062          	jra	L7242
5038  0c4c               L3542:
5039                     ; 849 		else if(flags&0b00011010)
5041  0c4c b60b          	ld	a,_flags
5042  0c4e a51a          	bcp	a,#26
5043  0c50 275c          	jreq	L7242
5044                     ; 851 			pwm_u=0;
5046  0c52 5f            	clrw	x
5047  0c53 bf0c          	ldw	_pwm_u,x
5048                     ; 852 			pwm_i=0;
5050  0c55 5f            	clrw	x
5051  0c56 bf0e          	ldw	_pwm_i,x
5052                     ; 853 			bBL=1;
5054  0c58 72100003      	bset	_bBL
5055                     ; 854 			bBL_IPS=1;
5057  0c5c 72100000      	bset	_bBL_IPS
5058  0c60 204c          	jra	L7242
5059  0c62               L5442:
5060                     ; 863 else	if(link==ON)				//если есть связь
5062  0c62 b662          	ld	a,_link
5063  0c64 a155          	cp	a,#85
5064  0c66 2646          	jrne	L7242
5065                     ; 865 	if((flags&0b00100000)==0)	//если нет блокировки извне
5067  0c68 b60b          	ld	a,_flags
5068  0c6a a520          	bcp	a,#32
5069  0c6c 2630          	jrne	L5642
5070                     ; 867 		if(((flags&0b00011010)==0)||(flags&0b01000000)) 	//если нет аварий или если они заблокированы
5072  0c6e b60b          	ld	a,_flags
5073  0c70 a51a          	bcp	a,#26
5074  0c72 2706          	jreq	L1742
5076  0c74 b60b          	ld	a,_flags
5077  0c76 a540          	bcp	a,#64
5078  0c78 2712          	jreq	L7642
5079  0c7a               L1742:
5080                     ; 869 			pwm_u=vol_u_temp+_x_;					//управление от укушки + выравнивание токов
5082  0c7a be5e          	ldw	x,__x_
5083  0c7c 72bb0058      	addw	x,_vol_u_temp
5084  0c80 bf0c          	ldw	_pwm_u,x
5085                     ; 870 		    	pwm_i=vol_i_temp;
5087  0c82 be56          	ldw	x,_vol_i_temp
5088  0c84 bf0e          	ldw	_pwm_i,x
5089                     ; 871 			bBL=0;
5091  0c86 72110003      	bres	_bBL
5093  0c8a 2022          	jra	L7242
5094  0c8c               L7642:
5095                     ; 873 		else if(flags&0b00011010)					//если есть аварии
5097  0c8c b60b          	ld	a,_flags
5098  0c8e a51a          	bcp	a,#26
5099  0c90 271c          	jreq	L7242
5100                     ; 875 			pwm_u=0;								//то полный стоп
5102  0c92 5f            	clrw	x
5103  0c93 bf0c          	ldw	_pwm_u,x
5104                     ; 876 			pwm_i=0;
5106  0c95 5f            	clrw	x
5107  0c96 bf0e          	ldw	_pwm_i,x
5108                     ; 877 			bBL=1;
5110  0c98 72100003      	bset	_bBL
5111  0c9c 2010          	jra	L7242
5112  0c9e               L5642:
5113                     ; 880 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
5115  0c9e b60b          	ld	a,_flags
5116  0ca0 a520          	bcp	a,#32
5117  0ca2 270a          	jreq	L7242
5118                     ; 882 		pwm_u=0;
5120  0ca4 5f            	clrw	x
5121  0ca5 bf0c          	ldw	_pwm_u,x
5122                     ; 883 	    	pwm_i=0;
5124  0ca7 5f            	clrw	x
5125  0ca8 bf0e          	ldw	_pwm_i,x
5126                     ; 884 		bBL=1;
5128  0caa 72100003      	bset	_bBL
5129  0cae               L7242:
5130                     ; 890 }
5133  0cae 81            	ret
5175                     	switch	.const
5176  0008               L66:
5177  0008 00000258      	dc.l	600
5178  000c               L07:
5179  000c 000003e8      	dc.l	1000
5180  0010               L27:
5181  0010 00000708      	dc.l	1800
5182                     ; 893 void matemat(void)
5182                     ; 894 {
5183                     	switch	.text
5184  0caf               _matemat:
5186  0caf 5204          	subw	sp,#4
5187       00000004      OFST:	set	4
5190                     ; 915 temp_SL=adc_buff_[4];
5192  0cb1 ce0011        	ldw	x,_adc_buff_+8
5193  0cb4 cd0000        	call	c_itolx
5195  0cb7 96            	ldw	x,sp
5196  0cb8 1c0001        	addw	x,#OFST-3
5197  0cbb cd0000        	call	c_rtol
5199                     ; 916 temp_SL-=ee_K[0][0];
5201  0cbe ce001a        	ldw	x,_ee_K
5202  0cc1 cd0000        	call	c_itolx
5204  0cc4 96            	ldw	x,sp
5205  0cc5 1c0001        	addw	x,#OFST-3
5206  0cc8 cd0000        	call	c_lgsub
5208                     ; 917 if(temp_SL<0) temp_SL=0;
5210  0ccb 9c            	rvf
5211  0ccc 0d01          	tnz	(OFST-3,sp)
5212  0cce 2e0a          	jrsge	L1252
5215  0cd0 ae0000        	ldw	x,#0
5216  0cd3 1f03          	ldw	(OFST-1,sp),x
5217  0cd5 ae0000        	ldw	x,#0
5218  0cd8 1f01          	ldw	(OFST-3,sp),x
5219  0cda               L1252:
5220                     ; 918 temp_SL*=ee_K[0][1];
5222  0cda ce001c        	ldw	x,_ee_K+2
5223  0cdd cd0000        	call	c_itolx
5225  0ce0 96            	ldw	x,sp
5226  0ce1 1c0001        	addw	x,#OFST-3
5227  0ce4 cd0000        	call	c_lgmul
5229                     ; 919 temp_SL/=600;
5231  0ce7 96            	ldw	x,sp
5232  0ce8 1c0001        	addw	x,#OFST-3
5233  0ceb cd0000        	call	c_ltor
5235  0cee ae0008        	ldw	x,#L66
5236  0cf1 cd0000        	call	c_ldiv
5238  0cf4 96            	ldw	x,sp
5239  0cf5 1c0001        	addw	x,#OFST-3
5240  0cf8 cd0000        	call	c_rtol
5242                     ; 920 I=(signed short)temp_SL;
5244  0cfb 1e03          	ldw	x,(OFST-1,sp)
5245  0cfd bf6e          	ldw	_I,x
5246                     ; 925 temp_SL=(signed long)adc_buff_[1];
5248  0cff ce000b        	ldw	x,_adc_buff_+2
5249  0d02 cd0000        	call	c_itolx
5251  0d05 96            	ldw	x,sp
5252  0d06 1c0001        	addw	x,#OFST-3
5253  0d09 cd0000        	call	c_rtol
5255                     ; 927 if(temp_SL<0) temp_SL=0;
5257  0d0c 9c            	rvf
5258  0d0d 0d01          	tnz	(OFST-3,sp)
5259  0d0f 2e0a          	jrsge	L3252
5262  0d11 ae0000        	ldw	x,#0
5263  0d14 1f03          	ldw	(OFST-1,sp),x
5264  0d16 ae0000        	ldw	x,#0
5265  0d19 1f01          	ldw	(OFST-3,sp),x
5266  0d1b               L3252:
5267                     ; 928 temp_SL*=(signed long)ee_K[2][1];
5269  0d1b ce0024        	ldw	x,_ee_K+10
5270  0d1e cd0000        	call	c_itolx
5272  0d21 96            	ldw	x,sp
5273  0d22 1c0001        	addw	x,#OFST-3
5274  0d25 cd0000        	call	c_lgmul
5276                     ; 929 temp_SL/=1000L;
5278  0d28 96            	ldw	x,sp
5279  0d29 1c0001        	addw	x,#OFST-3
5280  0d2c cd0000        	call	c_ltor
5282  0d2f ae000c        	ldw	x,#L07
5283  0d32 cd0000        	call	c_ldiv
5285  0d35 96            	ldw	x,sp
5286  0d36 1c0001        	addw	x,#OFST-3
5287  0d39 cd0000        	call	c_rtol
5289                     ; 930 Ui=(unsigned short)temp_SL;
5291  0d3c 1e03          	ldw	x,(OFST-1,sp)
5292  0d3e bf6a          	ldw	_Ui,x
5293                     ; 937 temp_SL=adc_buff_[3];
5295  0d40 ce000f        	ldw	x,_adc_buff_+6
5296  0d43 cd0000        	call	c_itolx
5298  0d46 96            	ldw	x,sp
5299  0d47 1c0001        	addw	x,#OFST-3
5300  0d4a cd0000        	call	c_rtol
5302                     ; 939 if(temp_SL<0) temp_SL=0;
5304  0d4d 9c            	rvf
5305  0d4e 0d01          	tnz	(OFST-3,sp)
5306  0d50 2e0a          	jrsge	L5252
5309  0d52 ae0000        	ldw	x,#0
5310  0d55 1f03          	ldw	(OFST-1,sp),x
5311  0d57 ae0000        	ldw	x,#0
5312  0d5a 1f01          	ldw	(OFST-3,sp),x
5313  0d5c               L5252:
5314                     ; 940 temp_SL*=ee_K[1][1];
5316  0d5c ce0020        	ldw	x,_ee_K+6
5317  0d5f cd0000        	call	c_itolx
5319  0d62 96            	ldw	x,sp
5320  0d63 1c0001        	addw	x,#OFST-3
5321  0d66 cd0000        	call	c_lgmul
5323                     ; 941 temp_SL/=1800;
5325  0d69 96            	ldw	x,sp
5326  0d6a 1c0001        	addw	x,#OFST-3
5327  0d6d cd0000        	call	c_ltor
5329  0d70 ae0010        	ldw	x,#L27
5330  0d73 cd0000        	call	c_ldiv
5332  0d76 96            	ldw	x,sp
5333  0d77 1c0001        	addw	x,#OFST-3
5334  0d7a cd0000        	call	c_rtol
5336                     ; 942 Un=(unsigned short)temp_SL;
5338  0d7d 1e03          	ldw	x,(OFST-1,sp)
5339  0d7f bf6c          	ldw	_Un,x
5340                     ; 945 temp_SL=adc_buff_[2];
5342  0d81 ce000d        	ldw	x,_adc_buff_+4
5343  0d84 cd0000        	call	c_itolx
5345  0d87 96            	ldw	x,sp
5346  0d88 1c0001        	addw	x,#OFST-3
5347  0d8b cd0000        	call	c_rtol
5349                     ; 946 temp_SL*=ee_K[3][1];
5351  0d8e ce0028        	ldw	x,_ee_K+14
5352  0d91 cd0000        	call	c_itolx
5354  0d94 96            	ldw	x,sp
5355  0d95 1c0001        	addw	x,#OFST-3
5356  0d98 cd0000        	call	c_lgmul
5358                     ; 947 temp_SL/=1000;
5360  0d9b 96            	ldw	x,sp
5361  0d9c 1c0001        	addw	x,#OFST-3
5362  0d9f cd0000        	call	c_ltor
5364  0da2 ae000c        	ldw	x,#L07
5365  0da5 cd0000        	call	c_ldiv
5367  0da8 96            	ldw	x,sp
5368  0da9 1c0001        	addw	x,#OFST-3
5369  0dac cd0000        	call	c_rtol
5371                     ; 948 T=(signed short)(temp_SL-273L);
5373  0daf 7b04          	ld	a,(OFST+0,sp)
5374  0db1 5f            	clrw	x
5375  0db2 4d            	tnz	a
5376  0db3 2a01          	jrpl	L47
5377  0db5 53            	cplw	x
5378  0db6               L47:
5379  0db6 97            	ld	xl,a
5380  0db7 1d0111        	subw	x,#273
5381  0dba 01            	rrwa	x,a
5382  0dbb b767          	ld	_T,a
5383  0dbd 02            	rlwa	x,a
5384                     ; 949 if(T<-30)T=-30;
5386  0dbe 9c            	rvf
5387  0dbf b667          	ld	a,_T
5388  0dc1 a1e2          	cp	a,#226
5389  0dc3 2e04          	jrsge	L7252
5392  0dc5 35e20067      	mov	_T,#226
5393  0dc9               L7252:
5394                     ; 950 if(T>120)T=120;
5396  0dc9 9c            	rvf
5397  0dca b667          	ld	a,_T
5398  0dcc a179          	cp	a,#121
5399  0dce 2f04          	jrslt	L1352
5402  0dd0 35780067      	mov	_T,#120
5403  0dd4               L1352:
5404                     ; 952 Udb=flags;
5406  0dd4 b60b          	ld	a,_flags
5407  0dd6 5f            	clrw	x
5408  0dd7 97            	ld	xl,a
5409  0dd8 bf68          	ldw	_Udb,x
5410                     ; 958 }
5413  0dda 5b04          	addw	sp,#4
5414  0ddc 81            	ret
5445                     ; 961 void temper_drv(void)		//1 Hz
5445                     ; 962 {
5446                     	switch	.text
5447  0ddd               _temper_drv:
5451                     ; 964 if(T>ee_tsign) tsign_cnt++;
5453  0ddd 9c            	rvf
5454  0dde 5f            	clrw	x
5455  0ddf b667          	ld	a,_T
5456  0de1 2a01          	jrpl	L001
5457  0de3 53            	cplw	x
5458  0de4               L001:
5459  0de4 97            	ld	xl,a
5460  0de5 c3000e        	cpw	x,_ee_tsign
5461  0de8 2d09          	jrsle	L3452
5464  0dea be4d          	ldw	x,_tsign_cnt
5465  0dec 1c0001        	addw	x,#1
5466  0def bf4d          	ldw	_tsign_cnt,x
5468  0df1 201d          	jra	L5452
5469  0df3               L3452:
5470                     ; 965 else if (T<(ee_tsign-1)) tsign_cnt--;
5472  0df3 9c            	rvf
5473  0df4 ce000e        	ldw	x,_ee_tsign
5474  0df7 5a            	decw	x
5475  0df8 905f          	clrw	y
5476  0dfa b667          	ld	a,_T
5477  0dfc 2a02          	jrpl	L201
5478  0dfe 9053          	cplw	y
5479  0e00               L201:
5480  0e00 9097          	ld	yl,a
5481  0e02 90bf00        	ldw	c_y,y
5482  0e05 b300          	cpw	x,c_y
5483  0e07 2d07          	jrsle	L5452
5486  0e09 be4d          	ldw	x,_tsign_cnt
5487  0e0b 1d0001        	subw	x,#1
5488  0e0e bf4d          	ldw	_tsign_cnt,x
5489  0e10               L5452:
5490                     ; 967 gran(&tsign_cnt,0,60);
5492  0e10 ae003c        	ldw	x,#60
5493  0e13 89            	pushw	x
5494  0e14 5f            	clrw	x
5495  0e15 89            	pushw	x
5496  0e16 ae004d        	ldw	x,#_tsign_cnt
5497  0e19 cd00c2        	call	_gran
5499  0e1c 5b04          	addw	sp,#4
5500                     ; 969 if(tsign_cnt>=55)
5502  0e1e 9c            	rvf
5503  0e1f be4d          	ldw	x,_tsign_cnt
5504  0e21 a30037        	cpw	x,#55
5505  0e24 2f16          	jrslt	L1552
5506                     ; 971 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
5508  0e26 3d4a          	tnz	_jp_mode
5509  0e28 2606          	jrne	L7552
5511  0e2a b60b          	ld	a,_flags
5512  0e2c a540          	bcp	a,#64
5513  0e2e 2706          	jreq	L5552
5514  0e30               L7552:
5516  0e30 b64a          	ld	a,_jp_mode
5517  0e32 a103          	cp	a,#3
5518  0e34 2612          	jrne	L1652
5519  0e36               L5552:
5522  0e36 7214000b      	bset	_flags,#2
5523  0e3a 200c          	jra	L1652
5524  0e3c               L1552:
5525                     ; 973 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
5527  0e3c 9c            	rvf
5528  0e3d be4d          	ldw	x,_tsign_cnt
5529  0e3f a30006        	cpw	x,#6
5530  0e42 2e04          	jrsge	L1652
5533  0e44 7215000b      	bres	_flags,#2
5534  0e48               L1652:
5535                     ; 978 if(T>ee_tmax) tmax_cnt++;
5537  0e48 9c            	rvf
5538  0e49 5f            	clrw	x
5539  0e4a b667          	ld	a,_T
5540  0e4c 2a01          	jrpl	L401
5541  0e4e 53            	cplw	x
5542  0e4f               L401:
5543  0e4f 97            	ld	xl,a
5544  0e50 c30010        	cpw	x,_ee_tmax
5545  0e53 2d09          	jrsle	L5652
5548  0e55 be4b          	ldw	x,_tmax_cnt
5549  0e57 1c0001        	addw	x,#1
5550  0e5a bf4b          	ldw	_tmax_cnt,x
5552  0e5c 201d          	jra	L7652
5553  0e5e               L5652:
5554                     ; 979 else if (T<(ee_tmax-1)) tmax_cnt--;
5556  0e5e 9c            	rvf
5557  0e5f ce0010        	ldw	x,_ee_tmax
5558  0e62 5a            	decw	x
5559  0e63 905f          	clrw	y
5560  0e65 b667          	ld	a,_T
5561  0e67 2a02          	jrpl	L601
5562  0e69 9053          	cplw	y
5563  0e6b               L601:
5564  0e6b 9097          	ld	yl,a
5565  0e6d 90bf00        	ldw	c_y,y
5566  0e70 b300          	cpw	x,c_y
5567  0e72 2d07          	jrsle	L7652
5570  0e74 be4b          	ldw	x,_tmax_cnt
5571  0e76 1d0001        	subw	x,#1
5572  0e79 bf4b          	ldw	_tmax_cnt,x
5573  0e7b               L7652:
5574                     ; 981 gran(&tmax_cnt,0,60);
5576  0e7b ae003c        	ldw	x,#60
5577  0e7e 89            	pushw	x
5578  0e7f 5f            	clrw	x
5579  0e80 89            	pushw	x
5580  0e81 ae004b        	ldw	x,#_tmax_cnt
5581  0e84 cd00c2        	call	_gran
5583  0e87 5b04          	addw	sp,#4
5584                     ; 983 if(tmax_cnt>=55)
5586  0e89 9c            	rvf
5587  0e8a be4b          	ldw	x,_tmax_cnt
5588  0e8c a30037        	cpw	x,#55
5589  0e8f 2f16          	jrslt	L3752
5590                     ; 985 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5592  0e91 3d4a          	tnz	_jp_mode
5593  0e93 2606          	jrne	L1062
5595  0e95 b60b          	ld	a,_flags
5596  0e97 a540          	bcp	a,#64
5597  0e99 2706          	jreq	L7752
5598  0e9b               L1062:
5600  0e9b b64a          	ld	a,_jp_mode
5601  0e9d a103          	cp	a,#3
5602  0e9f 2612          	jrne	L3062
5603  0ea1               L7752:
5606  0ea1 7212000b      	bset	_flags,#1
5607  0ea5 200c          	jra	L3062
5608  0ea7               L3752:
5609                     ; 987 else if (tmax_cnt<=5) flags&=0b11111101;
5611  0ea7 9c            	rvf
5612  0ea8 be4b          	ldw	x,_tmax_cnt
5613  0eaa a30006        	cpw	x,#6
5614  0ead 2e04          	jrsge	L3062
5617  0eaf 7213000b      	bres	_flags,#1
5618  0eb3               L3062:
5619                     ; 990 } 
5622  0eb3 81            	ret
5654                     ; 993 void u_drv(void)		//1Hz
5654                     ; 994 { 
5655                     	switch	.text
5656  0eb4               _u_drv:
5660                     ; 995 if(jp_mode!=jp3)
5662  0eb4 b64a          	ld	a,_jp_mode
5663  0eb6 a103          	cp	a,#3
5664  0eb8 2770          	jreq	L7162
5665                     ; 997 	if(Ui>ee_Umax)umax_cnt++;
5667  0eba 9c            	rvf
5668  0ebb be6a          	ldw	x,_Ui
5669  0ebd c30014        	cpw	x,_ee_Umax
5670  0ec0 2d09          	jrsle	L1262
5673  0ec2 be65          	ldw	x,_umax_cnt
5674  0ec4 1c0001        	addw	x,#1
5675  0ec7 bf65          	ldw	_umax_cnt,x
5677  0ec9 2003          	jra	L3262
5678  0ecb               L1262:
5679                     ; 998 	else umax_cnt=0;
5681  0ecb 5f            	clrw	x
5682  0ecc bf65          	ldw	_umax_cnt,x
5683  0ece               L3262:
5684                     ; 999 	gran(&umax_cnt,0,10);
5686  0ece ae000a        	ldw	x,#10
5687  0ed1 89            	pushw	x
5688  0ed2 5f            	clrw	x
5689  0ed3 89            	pushw	x
5690  0ed4 ae0065        	ldw	x,#_umax_cnt
5691  0ed7 cd00c2        	call	_gran
5693  0eda 5b04          	addw	sp,#4
5694                     ; 1000 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5696  0edc 9c            	rvf
5697  0edd be65          	ldw	x,_umax_cnt
5698  0edf a3000a        	cpw	x,#10
5699  0ee2 2f04          	jrslt	L5262
5702  0ee4 7216000b      	bset	_flags,#3
5703  0ee8               L5262:
5704                     ; 1003 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5706  0ee8 9c            	rvf
5707  0ee9 be6a          	ldw	x,_Ui
5708  0eeb b36c          	cpw	x,_Un
5709  0eed 2e1c          	jrsge	L7262
5711  0eef 9c            	rvf
5712  0ef0 be6c          	ldw	x,_Un
5713  0ef2 72b0006a      	subw	x,_Ui
5714  0ef6 c30012        	cpw	x,_ee_dU
5715  0ef9 2d10          	jrsle	L7262
5717  0efb c65005        	ld	a,20485
5718  0efe a504          	bcp	a,#4
5719  0f00 2609          	jrne	L7262
5722  0f02 be63          	ldw	x,_umin_cnt
5723  0f04 1c0001        	addw	x,#1
5724  0f07 bf63          	ldw	_umin_cnt,x
5726  0f09 2003          	jra	L1362
5727  0f0b               L7262:
5728                     ; 1004 	else umin_cnt=0;
5730  0f0b 5f            	clrw	x
5731  0f0c bf63          	ldw	_umin_cnt,x
5732  0f0e               L1362:
5733                     ; 1005 	gran(&umin_cnt,0,10);	
5735  0f0e ae000a        	ldw	x,#10
5736  0f11 89            	pushw	x
5737  0f12 5f            	clrw	x
5738  0f13 89            	pushw	x
5739  0f14 ae0063        	ldw	x,#_umin_cnt
5740  0f17 cd00c2        	call	_gran
5742  0f1a 5b04          	addw	sp,#4
5743                     ; 1006 	if(umin_cnt>=10)flags|=0b00010000;	  
5745  0f1c 9c            	rvf
5746  0f1d be63          	ldw	x,_umin_cnt
5747  0f1f a3000a        	cpw	x,#10
5748  0f22 2f6f          	jrslt	L5362
5751  0f24 7218000b      	bset	_flags,#4
5752  0f28 2069          	jra	L5362
5753  0f2a               L7162:
5754                     ; 1008 else if(jp_mode==jp3)
5756  0f2a b64a          	ld	a,_jp_mode
5757  0f2c a103          	cp	a,#3
5758  0f2e 2663          	jrne	L5362
5759                     ; 1010 	if(Ui>700)umax_cnt++;
5761  0f30 9c            	rvf
5762  0f31 be6a          	ldw	x,_Ui
5763  0f33 a302bd        	cpw	x,#701
5764  0f36 2f09          	jrslt	L1462
5767  0f38 be65          	ldw	x,_umax_cnt
5768  0f3a 1c0001        	addw	x,#1
5769  0f3d bf65          	ldw	_umax_cnt,x
5771  0f3f 2003          	jra	L3462
5772  0f41               L1462:
5773                     ; 1011 	else umax_cnt=0;
5775  0f41 5f            	clrw	x
5776  0f42 bf65          	ldw	_umax_cnt,x
5777  0f44               L3462:
5778                     ; 1012 	gran(&umax_cnt,0,10);
5780  0f44 ae000a        	ldw	x,#10
5781  0f47 89            	pushw	x
5782  0f48 5f            	clrw	x
5783  0f49 89            	pushw	x
5784  0f4a ae0065        	ldw	x,#_umax_cnt
5785  0f4d cd00c2        	call	_gran
5787  0f50 5b04          	addw	sp,#4
5788                     ; 1013 	if(umax_cnt>=10)flags|=0b00001000;
5790  0f52 9c            	rvf
5791  0f53 be65          	ldw	x,_umax_cnt
5792  0f55 a3000a        	cpw	x,#10
5793  0f58 2f04          	jrslt	L5462
5796  0f5a 7216000b      	bset	_flags,#3
5797  0f5e               L5462:
5798                     ; 1016 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5800  0f5e 9c            	rvf
5801  0f5f be6a          	ldw	x,_Ui
5802  0f61 a300c8        	cpw	x,#200
5803  0f64 2e10          	jrsge	L7462
5805  0f66 c65005        	ld	a,20485
5806  0f69 a504          	bcp	a,#4
5807  0f6b 2609          	jrne	L7462
5810  0f6d be63          	ldw	x,_umin_cnt
5811  0f6f 1c0001        	addw	x,#1
5812  0f72 bf63          	ldw	_umin_cnt,x
5814  0f74 2003          	jra	L1562
5815  0f76               L7462:
5816                     ; 1017 	else umin_cnt=0;
5818  0f76 5f            	clrw	x
5819  0f77 bf63          	ldw	_umin_cnt,x
5820  0f79               L1562:
5821                     ; 1018 	gran(&umin_cnt,0,10);	
5823  0f79 ae000a        	ldw	x,#10
5824  0f7c 89            	pushw	x
5825  0f7d 5f            	clrw	x
5826  0f7e 89            	pushw	x
5827  0f7f ae0063        	ldw	x,#_umin_cnt
5828  0f82 cd00c2        	call	_gran
5830  0f85 5b04          	addw	sp,#4
5831                     ; 1019 	if(umin_cnt>=10)flags|=0b00010000;	  
5833  0f87 9c            	rvf
5834  0f88 be63          	ldw	x,_umin_cnt
5835  0f8a a3000a        	cpw	x,#10
5836  0f8d 2f04          	jrslt	L5362
5839  0f8f 7218000b      	bset	_flags,#4
5840  0f93               L5362:
5841                     ; 1021 }
5844  0f93 81            	ret
5871                     ; 1024 void x_drv(void)
5871                     ; 1025 {
5872                     	switch	.text
5873  0f94               _x_drv:
5877                     ; 1026 if(_x__==_x_)
5879  0f94 be5c          	ldw	x,__x__
5880  0f96 b35e          	cpw	x,__x_
5881  0f98 262a          	jrne	L5662
5882                     ; 1028 	if(_x_cnt<60)
5884  0f9a 9c            	rvf
5885  0f9b be5a          	ldw	x,__x_cnt
5886  0f9d a3003c        	cpw	x,#60
5887  0fa0 2e25          	jrsge	L5762
5888                     ; 1030 		_x_cnt++;
5890  0fa2 be5a          	ldw	x,__x_cnt
5891  0fa4 1c0001        	addw	x,#1
5892  0fa7 bf5a          	ldw	__x_cnt,x
5893                     ; 1031 		if(_x_cnt>=60)
5895  0fa9 9c            	rvf
5896  0faa be5a          	ldw	x,__x_cnt
5897  0fac a3003c        	cpw	x,#60
5898  0faf 2f16          	jrslt	L5762
5899                     ; 1033 			if(_x_ee_!=_x_)_x_ee_=_x_;
5901  0fb1 ce0018        	ldw	x,__x_ee_
5902  0fb4 b35e          	cpw	x,__x_
5903  0fb6 270f          	jreq	L5762
5906  0fb8 be5e          	ldw	x,__x_
5907  0fba 89            	pushw	x
5908  0fbb ae0018        	ldw	x,#__x_ee_
5909  0fbe cd0000        	call	c_eewrw
5911  0fc1 85            	popw	x
5912  0fc2 2003          	jra	L5762
5913  0fc4               L5662:
5914                     ; 1038 else _x_cnt=0;
5916  0fc4 5f            	clrw	x
5917  0fc5 bf5a          	ldw	__x_cnt,x
5918  0fc7               L5762:
5919                     ; 1040 if(_x_cnt>60) _x_cnt=0;	
5921  0fc7 9c            	rvf
5922  0fc8 be5a          	ldw	x,__x_cnt
5923  0fca a3003d        	cpw	x,#61
5924  0fcd 2f03          	jrslt	L7762
5927  0fcf 5f            	clrw	x
5928  0fd0 bf5a          	ldw	__x_cnt,x
5929  0fd2               L7762:
5930                     ; 1042 _x__=_x_;
5932  0fd2 be5e          	ldw	x,__x_
5933  0fd4 bf5c          	ldw	__x__,x
5934                     ; 1043 }
5937  0fd6 81            	ret
5963                     ; 1046 void apv_start(void)
5963                     ; 1047 {
5964                     	switch	.text
5965  0fd7               _apv_start:
5969                     ; 1048 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5971  0fd7 3d45          	tnz	_apv_cnt
5972  0fd9 2624          	jrne	L1172
5974  0fdb 3d46          	tnz	_apv_cnt+1
5975  0fdd 2620          	jrne	L1172
5977  0fdf 3d47          	tnz	_apv_cnt+2
5978  0fe1 261c          	jrne	L1172
5980                     	btst	_bAPV
5981  0fe8 2515          	jrult	L1172
5982                     ; 1050 	apv_cnt[0]=60;
5984  0fea 353c0045      	mov	_apv_cnt,#60
5985                     ; 1051 	apv_cnt[1]=60;
5987  0fee 353c0046      	mov	_apv_cnt+1,#60
5988                     ; 1052 	apv_cnt[2]=60;
5990  0ff2 353c0047      	mov	_apv_cnt+2,#60
5991                     ; 1053 	apv_cnt_=3600;
5993  0ff6 ae0e10        	ldw	x,#3600
5994  0ff9 bf43          	ldw	_apv_cnt_,x
5995                     ; 1054 	bAPV=1;	
5997  0ffb 72100002      	bset	_bAPV
5998  0fff               L1172:
5999                     ; 1056 }
6002  0fff 81            	ret
6028                     ; 1059 void apv_stop(void)
6028                     ; 1060 {
6029                     	switch	.text
6030  1000               _apv_stop:
6034                     ; 1061 apv_cnt[0]=0;
6036  1000 3f45          	clr	_apv_cnt
6037                     ; 1062 apv_cnt[1]=0;
6039  1002 3f46          	clr	_apv_cnt+1
6040                     ; 1063 apv_cnt[2]=0;
6042  1004 3f47          	clr	_apv_cnt+2
6043                     ; 1064 apv_cnt_=0;	
6045  1006 5f            	clrw	x
6046  1007 bf43          	ldw	_apv_cnt_,x
6047                     ; 1065 bAPV=0;
6049  1009 72110002      	bres	_bAPV
6050                     ; 1066 }
6053  100d 81            	ret
6088                     ; 1070 void apv_hndl(void)
6088                     ; 1071 {
6089                     	switch	.text
6090  100e               _apv_hndl:
6094                     ; 1072 if(apv_cnt[0])
6096  100e 3d45          	tnz	_apv_cnt
6097  1010 271e          	jreq	L3372
6098                     ; 1074 	apv_cnt[0]--;
6100  1012 3a45          	dec	_apv_cnt
6101                     ; 1075 	if(apv_cnt[0]==0)
6103  1014 3d45          	tnz	_apv_cnt
6104  1016 265a          	jrne	L7372
6105                     ; 1077 		flags&=0b11100001;
6107  1018 b60b          	ld	a,_flags
6108  101a a4e1          	and	a,#225
6109  101c b70b          	ld	_flags,a
6110                     ; 1078 		tsign_cnt=0;
6112  101e 5f            	clrw	x
6113  101f bf4d          	ldw	_tsign_cnt,x
6114                     ; 1079 		tmax_cnt=0;
6116  1021 5f            	clrw	x
6117  1022 bf4b          	ldw	_tmax_cnt,x
6118                     ; 1080 		umax_cnt=0;
6120  1024 5f            	clrw	x
6121  1025 bf65          	ldw	_umax_cnt,x
6122                     ; 1081 		umin_cnt=0;
6124  1027 5f            	clrw	x
6125  1028 bf63          	ldw	_umin_cnt,x
6126                     ; 1083 		led_drv_cnt=30;
6128  102a 351e001a      	mov	_led_drv_cnt,#30
6129  102e 2042          	jra	L7372
6130  1030               L3372:
6131                     ; 1086 else if(apv_cnt[1])
6133  1030 3d46          	tnz	_apv_cnt+1
6134  1032 271e          	jreq	L1472
6135                     ; 1088 	apv_cnt[1]--;
6137  1034 3a46          	dec	_apv_cnt+1
6138                     ; 1089 	if(apv_cnt[1]==0)
6140  1036 3d46          	tnz	_apv_cnt+1
6141  1038 2638          	jrne	L7372
6142                     ; 1091 		flags&=0b11100001;
6144  103a b60b          	ld	a,_flags
6145  103c a4e1          	and	a,#225
6146  103e b70b          	ld	_flags,a
6147                     ; 1092 		tsign_cnt=0;
6149  1040 5f            	clrw	x
6150  1041 bf4d          	ldw	_tsign_cnt,x
6151                     ; 1093 		tmax_cnt=0;
6153  1043 5f            	clrw	x
6154  1044 bf4b          	ldw	_tmax_cnt,x
6155                     ; 1094 		umax_cnt=0;
6157  1046 5f            	clrw	x
6158  1047 bf65          	ldw	_umax_cnt,x
6159                     ; 1095 		umin_cnt=0;
6161  1049 5f            	clrw	x
6162  104a bf63          	ldw	_umin_cnt,x
6163                     ; 1097 		led_drv_cnt=30;
6165  104c 351e001a      	mov	_led_drv_cnt,#30
6166  1050 2020          	jra	L7372
6167  1052               L1472:
6168                     ; 1100 else if(apv_cnt[2])
6170  1052 3d47          	tnz	_apv_cnt+2
6171  1054 271c          	jreq	L7372
6172                     ; 1102 	apv_cnt[2]--;
6174  1056 3a47          	dec	_apv_cnt+2
6175                     ; 1103 	if(apv_cnt[2]==0)
6177  1058 3d47          	tnz	_apv_cnt+2
6178  105a 2616          	jrne	L7372
6179                     ; 1105 		flags&=0b11100001;
6181  105c b60b          	ld	a,_flags
6182  105e a4e1          	and	a,#225
6183  1060 b70b          	ld	_flags,a
6184                     ; 1106 		tsign_cnt=0;
6186  1062 5f            	clrw	x
6187  1063 bf4d          	ldw	_tsign_cnt,x
6188                     ; 1107 		tmax_cnt=0;
6190  1065 5f            	clrw	x
6191  1066 bf4b          	ldw	_tmax_cnt,x
6192                     ; 1108 		umax_cnt=0;
6194  1068 5f            	clrw	x
6195  1069 bf65          	ldw	_umax_cnt,x
6196                     ; 1109 		umin_cnt=0;          
6198  106b 5f            	clrw	x
6199  106c bf63          	ldw	_umin_cnt,x
6200                     ; 1111 		led_drv_cnt=30;
6202  106e 351e001a      	mov	_led_drv_cnt,#30
6203  1072               L7372:
6204                     ; 1115 if(apv_cnt_)
6206  1072 be43          	ldw	x,_apv_cnt_
6207  1074 2712          	jreq	L3572
6208                     ; 1117 	apv_cnt_--;
6210  1076 be43          	ldw	x,_apv_cnt_
6211  1078 1d0001        	subw	x,#1
6212  107b bf43          	ldw	_apv_cnt_,x
6213                     ; 1118 	if(apv_cnt_==0) 
6215  107d be43          	ldw	x,_apv_cnt_
6216  107f 2607          	jrne	L3572
6217                     ; 1120 		bAPV=0;
6219  1081 72110002      	bres	_bAPV
6220                     ; 1121 		apv_start();
6222  1085 cd0fd7        	call	_apv_start
6224  1088               L3572:
6225                     ; 1125 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
6227  1088 be63          	ldw	x,_umin_cnt
6228  108a 261e          	jrne	L7572
6230  108c be65          	ldw	x,_umax_cnt
6231  108e 261a          	jrne	L7572
6233  1090 c65005        	ld	a,20485
6234  1093 a504          	bcp	a,#4
6235  1095 2613          	jrne	L7572
6236                     ; 1127 	if(cnt_apv_off<20)
6238  1097 b642          	ld	a,_cnt_apv_off
6239  1099 a114          	cp	a,#20
6240  109b 240f          	jruge	L5672
6241                     ; 1129 		cnt_apv_off++;
6243  109d 3c42          	inc	_cnt_apv_off
6244                     ; 1130 		if(cnt_apv_off>=20)
6246  109f b642          	ld	a,_cnt_apv_off
6247  10a1 a114          	cp	a,#20
6248  10a3 2507          	jrult	L5672
6249                     ; 1132 			apv_stop();
6251  10a5 cd1000        	call	_apv_stop
6253  10a8 2002          	jra	L5672
6254  10aa               L7572:
6255                     ; 1136 else cnt_apv_off=0;	
6257  10aa 3f42          	clr	_cnt_apv_off
6258  10ac               L5672:
6259                     ; 1138 }
6262  10ac 81            	ret
6265                     	switch	.ubsct
6266  0000               L7672_flags_old:
6267  0000 00            	ds.b	1
6303                     ; 1141 void flags_drv(void)
6303                     ; 1142 {
6304                     	switch	.text
6305  10ad               _flags_drv:
6309                     ; 1144 if(jp_mode!=jp3) 
6311  10ad b64a          	ld	a,_jp_mode
6312  10af a103          	cp	a,#3
6313  10b1 2723          	jreq	L7003
6314                     ; 1146 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
6316  10b3 b60b          	ld	a,_flags
6317  10b5 a508          	bcp	a,#8
6318  10b7 2706          	jreq	L5103
6320  10b9 b600          	ld	a,L7672_flags_old
6321  10bb a508          	bcp	a,#8
6322  10bd 270c          	jreq	L3103
6323  10bf               L5103:
6325  10bf b60b          	ld	a,_flags
6326  10c1 a510          	bcp	a,#16
6327  10c3 2726          	jreq	L1203
6329  10c5 b600          	ld	a,L7672_flags_old
6330  10c7 a510          	bcp	a,#16
6331  10c9 2620          	jrne	L1203
6332  10cb               L3103:
6333                     ; 1148     		if(link==OFF)apv_start();
6335  10cb b662          	ld	a,_link
6336  10cd a1aa          	cp	a,#170
6337  10cf 261a          	jrne	L1203
6340  10d1 cd0fd7        	call	_apv_start
6342  10d4 2015          	jra	L1203
6343  10d6               L7003:
6344                     ; 1151 else if(jp_mode==jp3) 
6346  10d6 b64a          	ld	a,_jp_mode
6347  10d8 a103          	cp	a,#3
6348  10da 260f          	jrne	L1203
6349                     ; 1153 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
6351  10dc b60b          	ld	a,_flags
6352  10de a508          	bcp	a,#8
6353  10e0 2709          	jreq	L1203
6355  10e2 b600          	ld	a,L7672_flags_old
6356  10e4 a508          	bcp	a,#8
6357  10e6 2603          	jrne	L1203
6358                     ; 1155     		apv_start();
6360  10e8 cd0fd7        	call	_apv_start
6362  10eb               L1203:
6363                     ; 1158 flags_old=flags;
6365  10eb 450b00        	mov	L7672_flags_old,_flags
6366                     ; 1160 } 
6369  10ee 81            	ret
6404                     ; 1297 void adr_drv_v4(char in)
6404                     ; 1298 {
6405                     	switch	.text
6406  10ef               _adr_drv_v4:
6410                     ; 1299 if(adress!=in)adress=in;
6412  10ef c10005        	cp	a,_adress
6413  10f2 2703          	jreq	L5403
6416  10f4 c70005        	ld	_adress,a
6417  10f7               L5403:
6418                     ; 1300 }
6421  10f7 81            	ret
6450                     ; 1303 void adr_drv_v3(void)
6450                     ; 1304 {
6451                     	switch	.text
6452  10f8               _adr_drv_v3:
6454  10f8 88            	push	a
6455       00000001      OFST:	set	1
6458                     ; 1310 GPIOB->DDR&=~(1<<0);
6460  10f9 72115007      	bres	20487,#0
6461                     ; 1311 GPIOB->CR1&=~(1<<0);
6463  10fd 72115008      	bres	20488,#0
6464                     ; 1312 GPIOB->CR2&=~(1<<0);
6466  1101 72115009      	bres	20489,#0
6467                     ; 1313 ADC2->CR2=0x08;
6469  1105 35085402      	mov	21506,#8
6470                     ; 1314 ADC2->CR1=0x40;
6472  1109 35405401      	mov	21505,#64
6473                     ; 1315 ADC2->CSR=0x20+0;
6475  110d 35205400      	mov	21504,#32
6476                     ; 1316 ADC2->CR1|=1;
6478  1111 72105401      	bset	21505,#0
6479                     ; 1317 ADC2->CR1|=1;
6481  1115 72105401      	bset	21505,#0
6482                     ; 1318 adr_drv_stat=1;
6484  1119 35010008      	mov	_adr_drv_stat,#1
6485  111d               L7503:
6486                     ; 1319 while(adr_drv_stat==1);
6489  111d b608          	ld	a,_adr_drv_stat
6490  111f a101          	cp	a,#1
6491  1121 27fa          	jreq	L7503
6492                     ; 1321 GPIOB->DDR&=~(1<<1);
6494  1123 72135007      	bres	20487,#1
6495                     ; 1322 GPIOB->CR1&=~(1<<1);
6497  1127 72135008      	bres	20488,#1
6498                     ; 1323 GPIOB->CR2&=~(1<<1);
6500  112b 72135009      	bres	20489,#1
6501                     ; 1324 ADC2->CR2=0x08;
6503  112f 35085402      	mov	21506,#8
6504                     ; 1325 ADC2->CR1=0x40;
6506  1133 35405401      	mov	21505,#64
6507                     ; 1326 ADC2->CSR=0x20+1;
6509  1137 35215400      	mov	21504,#33
6510                     ; 1327 ADC2->CR1|=1;
6512  113b 72105401      	bset	21505,#0
6513                     ; 1328 ADC2->CR1|=1;
6515  113f 72105401      	bset	21505,#0
6516                     ; 1329 adr_drv_stat=3;
6518  1143 35030008      	mov	_adr_drv_stat,#3
6519  1147               L5603:
6520                     ; 1330 while(adr_drv_stat==3);
6523  1147 b608          	ld	a,_adr_drv_stat
6524  1149 a103          	cp	a,#3
6525  114b 27fa          	jreq	L5603
6526                     ; 1332 GPIOE->DDR&=~(1<<6);
6528  114d 721d5016      	bres	20502,#6
6529                     ; 1333 GPIOE->CR1&=~(1<<6);
6531  1151 721d5017      	bres	20503,#6
6532                     ; 1334 GPIOE->CR2&=~(1<<6);
6534  1155 721d5018      	bres	20504,#6
6535                     ; 1335 ADC2->CR2=0x08;
6537  1159 35085402      	mov	21506,#8
6538                     ; 1336 ADC2->CR1=0x40;
6540  115d 35405401      	mov	21505,#64
6541                     ; 1337 ADC2->CSR=0x20+9;
6543  1161 35295400      	mov	21504,#41
6544                     ; 1338 ADC2->CR1|=1;
6546  1165 72105401      	bset	21505,#0
6547                     ; 1339 ADC2->CR1|=1;
6549  1169 72105401      	bset	21505,#0
6550                     ; 1340 adr_drv_stat=5;
6552  116d 35050008      	mov	_adr_drv_stat,#5
6553  1171               L3703:
6554                     ; 1341 while(adr_drv_stat==5);
6557  1171 b608          	ld	a,_adr_drv_stat
6558  1173 a105          	cp	a,#5
6559  1175 27fa          	jreq	L3703
6560                     ; 1345 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
6562  1177 9c            	rvf
6563  1178 ce0009        	ldw	x,_adc_buff_
6564  117b a3022a        	cpw	x,#554
6565  117e 2f0f          	jrslt	L1013
6567  1180 9c            	rvf
6568  1181 ce0009        	ldw	x,_adc_buff_
6569  1184 a30253        	cpw	x,#595
6570  1187 2e06          	jrsge	L1013
6573  1189 725f0006      	clr	_adr
6575  118d 204c          	jra	L3013
6576  118f               L1013:
6577                     ; 1346 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
6579  118f 9c            	rvf
6580  1190 ce0009        	ldw	x,_adc_buff_
6581  1193 a3036d        	cpw	x,#877
6582  1196 2f0f          	jrslt	L5013
6584  1198 9c            	rvf
6585  1199 ce0009        	ldw	x,_adc_buff_
6586  119c a30396        	cpw	x,#918
6587  119f 2e06          	jrsge	L5013
6590  11a1 35010006      	mov	_adr,#1
6592  11a5 2034          	jra	L3013
6593  11a7               L5013:
6594                     ; 1347 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
6596  11a7 9c            	rvf
6597  11a8 ce0009        	ldw	x,_adc_buff_
6598  11ab a302a3        	cpw	x,#675
6599  11ae 2f0f          	jrslt	L1113
6601  11b0 9c            	rvf
6602  11b1 ce0009        	ldw	x,_adc_buff_
6603  11b4 a302cc        	cpw	x,#716
6604  11b7 2e06          	jrsge	L1113
6607  11b9 35020006      	mov	_adr,#2
6609  11bd 201c          	jra	L3013
6610  11bf               L1113:
6611                     ; 1348 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
6613  11bf 9c            	rvf
6614  11c0 ce0009        	ldw	x,_adc_buff_
6615  11c3 a303e3        	cpw	x,#995
6616  11c6 2f0f          	jrslt	L5113
6618  11c8 9c            	rvf
6619  11c9 ce0009        	ldw	x,_adc_buff_
6620  11cc a3040c        	cpw	x,#1036
6621  11cf 2e06          	jrsge	L5113
6624  11d1 35030006      	mov	_adr,#3
6626  11d5 2004          	jra	L3013
6627  11d7               L5113:
6628                     ; 1349 else adr[0]=5;
6630  11d7 35050006      	mov	_adr,#5
6631  11db               L3013:
6632                     ; 1351 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
6634  11db 9c            	rvf
6635  11dc ce000b        	ldw	x,_adc_buff_+2
6636  11df a3022a        	cpw	x,#554
6637  11e2 2f0f          	jrslt	L1213
6639  11e4 9c            	rvf
6640  11e5 ce000b        	ldw	x,_adc_buff_+2
6641  11e8 a30253        	cpw	x,#595
6642  11eb 2e06          	jrsge	L1213
6645  11ed 725f0007      	clr	_adr+1
6647  11f1 204c          	jra	L3213
6648  11f3               L1213:
6649                     ; 1352 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
6651  11f3 9c            	rvf
6652  11f4 ce000b        	ldw	x,_adc_buff_+2
6653  11f7 a3036d        	cpw	x,#877
6654  11fa 2f0f          	jrslt	L5213
6656  11fc 9c            	rvf
6657  11fd ce000b        	ldw	x,_adc_buff_+2
6658  1200 a30396        	cpw	x,#918
6659  1203 2e06          	jrsge	L5213
6662  1205 35010007      	mov	_adr+1,#1
6664  1209 2034          	jra	L3213
6665  120b               L5213:
6666                     ; 1353 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
6668  120b 9c            	rvf
6669  120c ce000b        	ldw	x,_adc_buff_+2
6670  120f a302a3        	cpw	x,#675
6671  1212 2f0f          	jrslt	L1313
6673  1214 9c            	rvf
6674  1215 ce000b        	ldw	x,_adc_buff_+2
6675  1218 a302cc        	cpw	x,#716
6676  121b 2e06          	jrsge	L1313
6679  121d 35020007      	mov	_adr+1,#2
6681  1221 201c          	jra	L3213
6682  1223               L1313:
6683                     ; 1354 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6685  1223 9c            	rvf
6686  1224 ce000b        	ldw	x,_adc_buff_+2
6687  1227 a303e3        	cpw	x,#995
6688  122a 2f0f          	jrslt	L5313
6690  122c 9c            	rvf
6691  122d ce000b        	ldw	x,_adc_buff_+2
6692  1230 a3040c        	cpw	x,#1036
6693  1233 2e06          	jrsge	L5313
6696  1235 35030007      	mov	_adr+1,#3
6698  1239 2004          	jra	L3213
6699  123b               L5313:
6700                     ; 1355 else adr[1]=5;
6702  123b 35050007      	mov	_adr+1,#5
6703  123f               L3213:
6704                     ; 1357 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6706  123f 9c            	rvf
6707  1240 ce001b        	ldw	x,_adc_buff_+18
6708  1243 a3022a        	cpw	x,#554
6709  1246 2f0f          	jrslt	L1413
6711  1248 9c            	rvf
6712  1249 ce001b        	ldw	x,_adc_buff_+18
6713  124c a30253        	cpw	x,#595
6714  124f 2e06          	jrsge	L1413
6717  1251 725f0008      	clr	_adr+2
6719  1255 204c          	jra	L3413
6720  1257               L1413:
6721                     ; 1358 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6723  1257 9c            	rvf
6724  1258 ce001b        	ldw	x,_adc_buff_+18
6725  125b a3036d        	cpw	x,#877
6726  125e 2f0f          	jrslt	L5413
6728  1260 9c            	rvf
6729  1261 ce001b        	ldw	x,_adc_buff_+18
6730  1264 a30396        	cpw	x,#918
6731  1267 2e06          	jrsge	L5413
6734  1269 35010008      	mov	_adr+2,#1
6736  126d 2034          	jra	L3413
6737  126f               L5413:
6738                     ; 1359 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6740  126f 9c            	rvf
6741  1270 ce001b        	ldw	x,_adc_buff_+18
6742  1273 a302a3        	cpw	x,#675
6743  1276 2f0f          	jrslt	L1513
6745  1278 9c            	rvf
6746  1279 ce001b        	ldw	x,_adc_buff_+18
6747  127c a302cc        	cpw	x,#716
6748  127f 2e06          	jrsge	L1513
6751  1281 35020008      	mov	_adr+2,#2
6753  1285 201c          	jra	L3413
6754  1287               L1513:
6755                     ; 1360 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6757  1287 9c            	rvf
6758  1288 ce001b        	ldw	x,_adc_buff_+18
6759  128b a303e3        	cpw	x,#995
6760  128e 2f0f          	jrslt	L5513
6762  1290 9c            	rvf
6763  1291 ce001b        	ldw	x,_adc_buff_+18
6764  1294 a3040c        	cpw	x,#1036
6765  1297 2e06          	jrsge	L5513
6768  1299 35030008      	mov	_adr+2,#3
6770  129d 2004          	jra	L3413
6771  129f               L5513:
6772                     ; 1361 else adr[2]=5;
6774  129f 35050008      	mov	_adr+2,#5
6775  12a3               L3413:
6776                     ; 1365 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6778  12a3 c60006        	ld	a,_adr
6779  12a6 a105          	cp	a,#5
6780  12a8 270e          	jreq	L3613
6782  12aa c60007        	ld	a,_adr+1
6783  12ad a105          	cp	a,#5
6784  12af 2707          	jreq	L3613
6786  12b1 c60008        	ld	a,_adr+2
6787  12b4 a105          	cp	a,#5
6788  12b6 2606          	jrne	L1613
6789  12b8               L3613:
6790                     ; 1368 	adress_error=1;
6792  12b8 35010004      	mov	_adress_error,#1
6794  12bc               L7613:
6795                     ; 1379 }
6798  12bc 84            	pop	a
6799  12bd 81            	ret
6800  12be               L1613:
6801                     ; 1372 	if(adr[2]&0x02) bps_class=bpsIPS;
6803  12be c60008        	ld	a,_adr+2
6804  12c1 a502          	bcp	a,#2
6805  12c3 2706          	jreq	L1713
6808  12c5 35010004      	mov	_bps_class,#1
6810  12c9 2002          	jra	L3713
6811  12cb               L1713:
6812                     ; 1373 	else bps_class=bpsIBEP;
6814  12cb 3f04          	clr	_bps_class
6815  12cd               L3713:
6816                     ; 1375 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6818  12cd c60008        	ld	a,_adr+2
6819  12d0 a401          	and	a,#1
6820  12d2 97            	ld	xl,a
6821  12d3 a610          	ld	a,#16
6822  12d5 42            	mul	x,a
6823  12d6 9f            	ld	a,xl
6824  12d7 6b01          	ld	(OFST+0,sp),a
6825  12d9 c60007        	ld	a,_adr+1
6826  12dc 48            	sll	a
6827  12dd 48            	sll	a
6828  12de cb0006        	add	a,_adr
6829  12e1 1b01          	add	a,(OFST+0,sp)
6830  12e3 c70005        	ld	_adress,a
6831  12e6 20d4          	jra	L7613
6875                     ; 1382 void volum_u_main_drv(void)
6875                     ; 1383 {
6876                     	switch	.text
6877  12e8               _volum_u_main_drv:
6879  12e8 88            	push	a
6880       00000001      OFST:	set	1
6883                     ; 1386 if(bMAIN)
6885                     	btst	_bMAIN
6886  12ee 2503          	jrult	L231
6887  12f0 cc1439        	jp	L3123
6888  12f3               L231:
6889                     ; 1388 	if(Un<(UU_AVT-10))volum_u_main_+=5;
6891  12f3 9c            	rvf
6892  12f4 ce0008        	ldw	x,_UU_AVT
6893  12f7 1d000a        	subw	x,#10
6894  12fa b36c          	cpw	x,_Un
6895  12fc 2d09          	jrsle	L5123
6898  12fe be1d          	ldw	x,_volum_u_main_
6899  1300 1c0005        	addw	x,#5
6900  1303 bf1d          	ldw	_volum_u_main_,x
6902  1305 2036          	jra	L7123
6903  1307               L5123:
6904                     ; 1389 	else if(Un<(UU_AVT-1))volum_u_main_++;
6906  1307 9c            	rvf
6907  1308 ce0008        	ldw	x,_UU_AVT
6908  130b 5a            	decw	x
6909  130c b36c          	cpw	x,_Un
6910  130e 2d09          	jrsle	L1223
6913  1310 be1d          	ldw	x,_volum_u_main_
6914  1312 1c0001        	addw	x,#1
6915  1315 bf1d          	ldw	_volum_u_main_,x
6917  1317 2024          	jra	L7123
6918  1319               L1223:
6919                     ; 1390 	else if(Un>(UU_AVT+10))volum_u_main_-=10;
6921  1319 9c            	rvf
6922  131a ce0008        	ldw	x,_UU_AVT
6923  131d 1c000a        	addw	x,#10
6924  1320 b36c          	cpw	x,_Un
6925  1322 2e09          	jrsge	L5223
6928  1324 be1d          	ldw	x,_volum_u_main_
6929  1326 1d000a        	subw	x,#10
6930  1329 bf1d          	ldw	_volum_u_main_,x
6932  132b 2010          	jra	L7123
6933  132d               L5223:
6934                     ; 1391 	else if(Un>(UU_AVT+1))volum_u_main_--;
6936  132d 9c            	rvf
6937  132e ce0008        	ldw	x,_UU_AVT
6938  1331 5c            	incw	x
6939  1332 b36c          	cpw	x,_Un
6940  1334 2e07          	jrsge	L7123
6943  1336 be1d          	ldw	x,_volum_u_main_
6944  1338 1d0001        	subw	x,#1
6945  133b bf1d          	ldw	_volum_u_main_,x
6946  133d               L7123:
6947                     ; 1392 	if(volum_u_main_>1020)volum_u_main_=1020;
6949  133d 9c            	rvf
6950  133e be1d          	ldw	x,_volum_u_main_
6951  1340 a303fd        	cpw	x,#1021
6952  1343 2f05          	jrslt	L3323
6955  1345 ae03fc        	ldw	x,#1020
6956  1348 bf1d          	ldw	_volum_u_main_,x
6957  134a               L3323:
6958                     ; 1393 	if(volum_u_main_<0)volum_u_main_=0;
6960  134a 9c            	rvf
6961  134b be1d          	ldw	x,_volum_u_main_
6962  134d 2e03          	jrsge	L5323
6965  134f 5f            	clrw	x
6966  1350 bf1d          	ldw	_volum_u_main_,x
6967  1352               L5323:
6968                     ; 1396 	i_main_sigma=0;
6970  1352 5f            	clrw	x
6971  1353 bf0f          	ldw	_i_main_sigma,x
6972                     ; 1397 	i_main_num_of_bps=0;
6974  1355 3f11          	clr	_i_main_num_of_bps
6975                     ; 1398 	for(i=0;i<6;i++)
6977  1357 0f01          	clr	(OFST+0,sp)
6978  1359               L7323:
6979                     ; 1400 		if(i_main_flag[i])
6981  1359 7b01          	ld	a,(OFST+0,sp)
6982  135b 5f            	clrw	x
6983  135c 97            	ld	xl,a
6984  135d 6d14          	tnz	(_i_main_flag,x)
6985  135f 2719          	jreq	L5423
6986                     ; 1402 			i_main_sigma+=i_main[i];
6988  1361 7b01          	ld	a,(OFST+0,sp)
6989  1363 5f            	clrw	x
6990  1364 97            	ld	xl,a
6991  1365 58            	sllw	x
6992  1366 ee1a          	ldw	x,(_i_main,x)
6993  1368 72bb000f      	addw	x,_i_main_sigma
6994  136c bf0f          	ldw	_i_main_sigma,x
6995                     ; 1403 			i_main_flag[i]=1;
6997  136e 7b01          	ld	a,(OFST+0,sp)
6998  1370 5f            	clrw	x
6999  1371 97            	ld	xl,a
7000  1372 a601          	ld	a,#1
7001  1374 e714          	ld	(_i_main_flag,x),a
7002                     ; 1404 			i_main_num_of_bps++;
7004  1376 3c11          	inc	_i_main_num_of_bps
7006  1378 2006          	jra	L7423
7007  137a               L5423:
7008                     ; 1408 			i_main_flag[i]=0;	
7010  137a 7b01          	ld	a,(OFST+0,sp)
7011  137c 5f            	clrw	x
7012  137d 97            	ld	xl,a
7013  137e 6f14          	clr	(_i_main_flag,x)
7014  1380               L7423:
7015                     ; 1398 	for(i=0;i<6;i++)
7017  1380 0c01          	inc	(OFST+0,sp)
7020  1382 7b01          	ld	a,(OFST+0,sp)
7021  1384 a106          	cp	a,#6
7022  1386 25d1          	jrult	L7323
7023                     ; 1411 	i_main_avg=i_main_sigma/i_main_num_of_bps;
7025  1388 be0f          	ldw	x,_i_main_sigma
7026  138a b611          	ld	a,_i_main_num_of_bps
7027  138c 905f          	clrw	y
7028  138e 9097          	ld	yl,a
7029  1390 cd0000        	call	c_idiv
7031  1393 bf12          	ldw	_i_main_avg,x
7032                     ; 1412 	for(i=0;i<6;i++)
7034  1395 0f01          	clr	(OFST+0,sp)
7035  1397               L1523:
7036                     ; 1414 		if(i_main_flag[i])
7038  1397 7b01          	ld	a,(OFST+0,sp)
7039  1399 5f            	clrw	x
7040  139a 97            	ld	xl,a
7041  139b 6d14          	tnz	(_i_main_flag,x)
7042  139d 2603cc142e    	jreq	L7523
7043                     ; 1416 			if(i_main[i]<(i_main_avg-10))x[i]++;
7045  13a2 9c            	rvf
7046  13a3 7b01          	ld	a,(OFST+0,sp)
7047  13a5 5f            	clrw	x
7048  13a6 97            	ld	xl,a
7049  13a7 58            	sllw	x
7050  13a8 90be12        	ldw	y,_i_main_avg
7051  13ab 72a2000a      	subw	y,#10
7052  13af 90bf00        	ldw	c_y,y
7053  13b2 9093          	ldw	y,x
7054  13b4 90ee1a        	ldw	y,(_i_main,y)
7055  13b7 90b300        	cpw	y,c_y
7056  13ba 2e11          	jrsge	L1623
7059  13bc 7b01          	ld	a,(OFST+0,sp)
7060  13be 5f            	clrw	x
7061  13bf 97            	ld	xl,a
7062  13c0 58            	sllw	x
7063  13c1 9093          	ldw	y,x
7064  13c3 ee26          	ldw	x,(_x,x)
7065  13c5 1c0001        	addw	x,#1
7066  13c8 90ef26        	ldw	(_x,y),x
7068  13cb 2029          	jra	L3623
7069  13cd               L1623:
7070                     ; 1417 			else if(i_main[i]>(i_main_avg+10))x[i]--;
7072  13cd 9c            	rvf
7073  13ce 7b01          	ld	a,(OFST+0,sp)
7074  13d0 5f            	clrw	x
7075  13d1 97            	ld	xl,a
7076  13d2 58            	sllw	x
7077  13d3 90be12        	ldw	y,_i_main_avg
7078  13d6 72a9000a      	addw	y,#10
7079  13da 90bf00        	ldw	c_y,y
7080  13dd 9093          	ldw	y,x
7081  13df 90ee1a        	ldw	y,(_i_main,y)
7082  13e2 90b300        	cpw	y,c_y
7083  13e5 2d0f          	jrsle	L3623
7086  13e7 7b01          	ld	a,(OFST+0,sp)
7087  13e9 5f            	clrw	x
7088  13ea 97            	ld	xl,a
7089  13eb 58            	sllw	x
7090  13ec 9093          	ldw	y,x
7091  13ee ee26          	ldw	x,(_x,x)
7092  13f0 1d0001        	subw	x,#1
7093  13f3 90ef26        	ldw	(_x,y),x
7094  13f6               L3623:
7095                     ; 1418 			if(x[i]>100)x[i]=100;
7097  13f6 9c            	rvf
7098  13f7 7b01          	ld	a,(OFST+0,sp)
7099  13f9 5f            	clrw	x
7100  13fa 97            	ld	xl,a
7101  13fb 58            	sllw	x
7102  13fc 9093          	ldw	y,x
7103  13fe 90ee26        	ldw	y,(_x,y)
7104  1401 90a30065      	cpw	y,#101
7105  1405 2f0b          	jrslt	L7623
7108  1407 7b01          	ld	a,(OFST+0,sp)
7109  1409 5f            	clrw	x
7110  140a 97            	ld	xl,a
7111  140b 58            	sllw	x
7112  140c 90ae0064      	ldw	y,#100
7113  1410 ef26          	ldw	(_x,x),y
7114  1412               L7623:
7115                     ; 1419 			if(x[i]<-100)x[i]=-100;
7117  1412 9c            	rvf
7118  1413 7b01          	ld	a,(OFST+0,sp)
7119  1415 5f            	clrw	x
7120  1416 97            	ld	xl,a
7121  1417 58            	sllw	x
7122  1418 9093          	ldw	y,x
7123  141a 90ee26        	ldw	y,(_x,y)
7124  141d 90a3ff9c      	cpw	y,#65436
7125  1421 2e0b          	jrsge	L7523
7128  1423 7b01          	ld	a,(OFST+0,sp)
7129  1425 5f            	clrw	x
7130  1426 97            	ld	xl,a
7131  1427 58            	sllw	x
7132  1428 90aeff9c      	ldw	y,#65436
7133  142c ef26          	ldw	(_x,x),y
7134  142e               L7523:
7135                     ; 1412 	for(i=0;i<6;i++)
7137  142e 0c01          	inc	(OFST+0,sp)
7140  1430 7b01          	ld	a,(OFST+0,sp)
7141  1432 a106          	cp	a,#6
7142  1434 2403cc1397    	jrult	L1523
7143  1439               L3123:
7144                     ; 1426 }
7147  1439 84            	pop	a
7148  143a 81            	ret
7171                     ; 1429 void init_CAN(void) {
7172                     	switch	.text
7173  143b               _init_CAN:
7177                     ; 1430 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
7179  143b 72135420      	bres	21536,#1
7180                     ; 1431 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
7182  143f 72105420      	bset	21536,#0
7184  1443               L5033:
7185                     ; 1432 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
7187  1443 c65421        	ld	a,21537
7188  1446 a501          	bcp	a,#1
7189  1448 27f9          	jreq	L5033
7190                     ; 1434 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
7192  144a 72185420      	bset	21536,#4
7193                     ; 1436 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
7195  144e 35025427      	mov	21543,#2
7196                     ; 1445 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
7198  1452 35135428      	mov	21544,#19
7199                     ; 1446 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
7201  1456 35c05429      	mov	21545,#192
7202                     ; 1447 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
7204  145a 357f542c      	mov	21548,#127
7205                     ; 1448 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
7207  145e 35e0542d      	mov	21549,#224
7208                     ; 1450 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
7210  1462 35315430      	mov	21552,#49
7211                     ; 1451 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
7213  1466 35c05431      	mov	21553,#192
7214                     ; 1452 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
7216  146a 357f5434      	mov	21556,#127
7217                     ; 1453 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
7219  146e 35e05435      	mov	21557,#224
7220                     ; 1457 	CAN->PSR= 6;									// set page 6
7222  1472 35065427      	mov	21543,#6
7223                     ; 1462 	CAN->Page.Config.FMR1&=~3;								//mask mode
7225  1476 c65430        	ld	a,21552
7226  1479 a4fc          	and	a,#252
7227  147b c75430        	ld	21552,a
7228                     ; 1468 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
7230  147e 35065432      	mov	21554,#6
7231                     ; 1469 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
7233  1482 35605432      	mov	21554,#96
7234                     ; 1472 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
7236  1486 72105432      	bset	21554,#0
7237                     ; 1473 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
7239  148a 72185432      	bset	21554,#4
7240                     ; 1476 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
7242  148e 35065427      	mov	21543,#6
7243                     ; 1478 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
7245  1492 3509542c      	mov	21548,#9
7246                     ; 1479 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
7248  1496 35e7542d      	mov	21549,#231
7249                     ; 1481 	CAN->IER|=(1<<1);
7251  149a 72125425      	bset	21541,#1
7252                     ; 1484 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
7254  149e 72115420      	bres	21536,#0
7256  14a2               L3133:
7257                     ; 1485 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
7259  14a2 c65421        	ld	a,21537
7260  14a5 a501          	bcp	a,#1
7261  14a7 26f9          	jrne	L3133
7262                     ; 1486 }
7265  14a9 81            	ret
7373                     ; 1489 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
7373                     ; 1490 {
7374                     	switch	.text
7375  14aa               _can_transmit:
7377  14aa 89            	pushw	x
7378       00000000      OFST:	set	0
7381                     ; 1492 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
7383  14ab b673          	ld	a,_can_buff_wr_ptr
7384  14ad a104          	cp	a,#4
7385  14af 2502          	jrult	L5733
7388  14b1 3f73          	clr	_can_buff_wr_ptr
7389  14b3               L5733:
7390                     ; 1494 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
7392  14b3 b673          	ld	a,_can_buff_wr_ptr
7393  14b5 97            	ld	xl,a
7394  14b6 a610          	ld	a,#16
7395  14b8 42            	mul	x,a
7396  14b9 1601          	ldw	y,(OFST+1,sp)
7397  14bb a606          	ld	a,#6
7398  14bd               L041:
7399  14bd 9054          	srlw	y
7400  14bf 4a            	dec	a
7401  14c0 26fb          	jrne	L041
7402  14c2 909f          	ld	a,yl
7403  14c4 e774          	ld	(_can_out_buff,x),a
7404                     ; 1495 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
7406  14c6 b673          	ld	a,_can_buff_wr_ptr
7407  14c8 97            	ld	xl,a
7408  14c9 a610          	ld	a,#16
7409  14cb 42            	mul	x,a
7410  14cc 7b02          	ld	a,(OFST+2,sp)
7411  14ce 48            	sll	a
7412  14cf 48            	sll	a
7413  14d0 e775          	ld	(_can_out_buff+1,x),a
7414                     ; 1497 can_out_buff[can_buff_wr_ptr][2]=data0;
7416  14d2 b673          	ld	a,_can_buff_wr_ptr
7417  14d4 97            	ld	xl,a
7418  14d5 a610          	ld	a,#16
7419  14d7 42            	mul	x,a
7420  14d8 7b05          	ld	a,(OFST+5,sp)
7421  14da e776          	ld	(_can_out_buff+2,x),a
7422                     ; 1498 can_out_buff[can_buff_wr_ptr][3]=data1;
7424  14dc b673          	ld	a,_can_buff_wr_ptr
7425  14de 97            	ld	xl,a
7426  14df a610          	ld	a,#16
7427  14e1 42            	mul	x,a
7428  14e2 7b06          	ld	a,(OFST+6,sp)
7429  14e4 e777          	ld	(_can_out_buff+3,x),a
7430                     ; 1499 can_out_buff[can_buff_wr_ptr][4]=data2;
7432  14e6 b673          	ld	a,_can_buff_wr_ptr
7433  14e8 97            	ld	xl,a
7434  14e9 a610          	ld	a,#16
7435  14eb 42            	mul	x,a
7436  14ec 7b07          	ld	a,(OFST+7,sp)
7437  14ee e778          	ld	(_can_out_buff+4,x),a
7438                     ; 1500 can_out_buff[can_buff_wr_ptr][5]=data3;
7440  14f0 b673          	ld	a,_can_buff_wr_ptr
7441  14f2 97            	ld	xl,a
7442  14f3 a610          	ld	a,#16
7443  14f5 42            	mul	x,a
7444  14f6 7b08          	ld	a,(OFST+8,sp)
7445  14f8 e779          	ld	(_can_out_buff+5,x),a
7446                     ; 1501 can_out_buff[can_buff_wr_ptr][6]=data4;
7448  14fa b673          	ld	a,_can_buff_wr_ptr
7449  14fc 97            	ld	xl,a
7450  14fd a610          	ld	a,#16
7451  14ff 42            	mul	x,a
7452  1500 7b09          	ld	a,(OFST+9,sp)
7453  1502 e77a          	ld	(_can_out_buff+6,x),a
7454                     ; 1502 can_out_buff[can_buff_wr_ptr][7]=data5;
7456  1504 b673          	ld	a,_can_buff_wr_ptr
7457  1506 97            	ld	xl,a
7458  1507 a610          	ld	a,#16
7459  1509 42            	mul	x,a
7460  150a 7b0a          	ld	a,(OFST+10,sp)
7461  150c e77b          	ld	(_can_out_buff+7,x),a
7462                     ; 1503 can_out_buff[can_buff_wr_ptr][8]=data6;
7464  150e b673          	ld	a,_can_buff_wr_ptr
7465  1510 97            	ld	xl,a
7466  1511 a610          	ld	a,#16
7467  1513 42            	mul	x,a
7468  1514 7b0b          	ld	a,(OFST+11,sp)
7469  1516 e77c          	ld	(_can_out_buff+8,x),a
7470                     ; 1504 can_out_buff[can_buff_wr_ptr][9]=data7;
7472  1518 b673          	ld	a,_can_buff_wr_ptr
7473  151a 97            	ld	xl,a
7474  151b a610          	ld	a,#16
7475  151d 42            	mul	x,a
7476  151e 7b0c          	ld	a,(OFST+12,sp)
7477  1520 e77d          	ld	(_can_out_buff+9,x),a
7478                     ; 1506 can_buff_wr_ptr++;
7480  1522 3c73          	inc	_can_buff_wr_ptr
7481                     ; 1507 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
7483  1524 b673          	ld	a,_can_buff_wr_ptr
7484  1526 a104          	cp	a,#4
7485  1528 2502          	jrult	L7733
7488  152a 3f73          	clr	_can_buff_wr_ptr
7489  152c               L7733:
7490                     ; 1508 } 
7493  152c 85            	popw	x
7494  152d 81            	ret
7523                     ; 1511 void can_tx_hndl(void)
7523                     ; 1512 {
7524                     	switch	.text
7525  152e               _can_tx_hndl:
7529                     ; 1513 if(bTX_FREE)
7531  152e 3d09          	tnz	_bTX_FREE
7532  1530 2757          	jreq	L1143
7533                     ; 1515 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
7535  1532 b672          	ld	a,_can_buff_rd_ptr
7536  1534 b173          	cp	a,_can_buff_wr_ptr
7537  1536 275f          	jreq	L7143
7538                     ; 1517 		bTX_FREE=0;
7540  1538 3f09          	clr	_bTX_FREE
7541                     ; 1519 		CAN->PSR= 0;
7543  153a 725f5427      	clr	21543
7544                     ; 1520 		CAN->Page.TxMailbox.MDLCR=8;
7546  153e 35085429      	mov	21545,#8
7547                     ; 1521 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
7549  1542 b672          	ld	a,_can_buff_rd_ptr
7550  1544 97            	ld	xl,a
7551  1545 a610          	ld	a,#16
7552  1547 42            	mul	x,a
7553  1548 e674          	ld	a,(_can_out_buff,x)
7554  154a c7542a        	ld	21546,a
7555                     ; 1522 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
7557  154d b672          	ld	a,_can_buff_rd_ptr
7558  154f 97            	ld	xl,a
7559  1550 a610          	ld	a,#16
7560  1552 42            	mul	x,a
7561  1553 e675          	ld	a,(_can_out_buff+1,x)
7562  1555 c7542b        	ld	21547,a
7563                     ; 1524 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
7565  1558 b672          	ld	a,_can_buff_rd_ptr
7566  155a 97            	ld	xl,a
7567  155b a610          	ld	a,#16
7568  155d 42            	mul	x,a
7569  155e 01            	rrwa	x,a
7570  155f ab76          	add	a,#_can_out_buff+2
7571  1561 2401          	jrnc	L441
7572  1563 5c            	incw	x
7573  1564               L441:
7574  1564 5f            	clrw	x
7575  1565 97            	ld	xl,a
7576  1566 bf00          	ldw	c_x,x
7577  1568 ae0008        	ldw	x,#8
7578  156b               L641:
7579  156b 5a            	decw	x
7580  156c 92d600        	ld	a,([c_x],x)
7581  156f d7542e        	ld	(21550,x),a
7582  1572 5d            	tnzw	x
7583  1573 26f6          	jrne	L641
7584                     ; 1526 		can_buff_rd_ptr++;
7586  1575 3c72          	inc	_can_buff_rd_ptr
7587                     ; 1527 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
7589  1577 b672          	ld	a,_can_buff_rd_ptr
7590  1579 a104          	cp	a,#4
7591  157b 2502          	jrult	L5143
7594  157d 3f72          	clr	_can_buff_rd_ptr
7595  157f               L5143:
7596                     ; 1529 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
7598  157f 72105428      	bset	21544,#0
7599                     ; 1530 		CAN->IER|=(1<<0);
7601  1583 72105425      	bset	21541,#0
7602  1587 200e          	jra	L7143
7603  1589               L1143:
7604                     ; 1535 	tx_busy_cnt++;
7606  1589 3c71          	inc	_tx_busy_cnt
7607                     ; 1536 	if(tx_busy_cnt>=100)
7609  158b b671          	ld	a,_tx_busy_cnt
7610  158d a164          	cp	a,#100
7611  158f 2506          	jrult	L7143
7612                     ; 1538 		tx_busy_cnt=0;
7614  1591 3f71          	clr	_tx_busy_cnt
7615                     ; 1539 		bTX_FREE=1;
7617  1593 35010009      	mov	_bTX_FREE,#1
7618  1597               L7143:
7619                     ; 1542 }
7622  1597 81            	ret
7661                     ; 1545 void net_drv(void)
7661                     ; 1546 { 
7662                     	switch	.text
7663  1598               _net_drv:
7667                     ; 1548 if(bMAIN)
7669                     	btst	_bMAIN
7670  159d 2503          	jrult	L251
7671  159f cc1645        	jp	L3343
7672  15a2               L251:
7673                     ; 1550 	if(++cnt_net_drv>=7) cnt_net_drv=0; 
7675  15a2 3c32          	inc	_cnt_net_drv
7676  15a4 b632          	ld	a,_cnt_net_drv
7677  15a6 a107          	cp	a,#7
7678  15a8 2502          	jrult	L5343
7681  15aa 3f32          	clr	_cnt_net_drv
7682  15ac               L5343:
7683                     ; 1552 	if(cnt_net_drv<=5) 
7685  15ac b632          	ld	a,_cnt_net_drv
7686  15ae a106          	cp	a,#6
7687  15b0 244c          	jruge	L7343
7688                     ; 1554 		can_transmit(0x09e,cnt_net_drv,cnt_net_drv,GETTM,0,(char)(volum_u_main_+x[cnt_net_drv]),(char)((volum_u_main_+x[cnt_net_drv])/256),1000,1000);
7690  15b2 4be8          	push	#232
7691  15b4 4be8          	push	#232
7692  15b6 b632          	ld	a,_cnt_net_drv
7693  15b8 5f            	clrw	x
7694  15b9 97            	ld	xl,a
7695  15ba 58            	sllw	x
7696  15bb ee26          	ldw	x,(_x,x)
7697  15bd 72bb001d      	addw	x,_volum_u_main_
7698  15c1 90ae0100      	ldw	y,#256
7699  15c5 cd0000        	call	c_idiv
7701  15c8 9f            	ld	a,xl
7702  15c9 88            	push	a
7703  15ca b632          	ld	a,_cnt_net_drv
7704  15cc 5f            	clrw	x
7705  15cd 97            	ld	xl,a
7706  15ce 58            	sllw	x
7707  15cf e627          	ld	a,(_x+1,x)
7708  15d1 bb1e          	add	a,_volum_u_main_+1
7709  15d3 88            	push	a
7710  15d4 4b00          	push	#0
7711  15d6 4bed          	push	#237
7712  15d8 3b0032        	push	_cnt_net_drv
7713  15db 3b0032        	push	_cnt_net_drv
7714  15de ae009e        	ldw	x,#158
7715  15e1 cd14aa        	call	_can_transmit
7717  15e4 5b08          	addw	sp,#8
7718                     ; 1555 		i_main_bps_cnt[cnt_net_drv]++;
7720  15e6 b632          	ld	a,_cnt_net_drv
7721  15e8 5f            	clrw	x
7722  15e9 97            	ld	xl,a
7723  15ea 6c09          	inc	(_i_main_bps_cnt,x)
7724                     ; 1556 		if(i_main_bps_cnt[cnt_net_drv]>10)i_main_flag[cnt_net_drv]=0;
7726  15ec b632          	ld	a,_cnt_net_drv
7727  15ee 5f            	clrw	x
7728  15ef 97            	ld	xl,a
7729  15f0 e609          	ld	a,(_i_main_bps_cnt,x)
7730  15f2 a10b          	cp	a,#11
7731  15f4 254f          	jrult	L3343
7734  15f6 b632          	ld	a,_cnt_net_drv
7735  15f8 5f            	clrw	x
7736  15f9 97            	ld	xl,a
7737  15fa 6f14          	clr	(_i_main_flag,x)
7738  15fc 2047          	jra	L3343
7739  15fe               L7343:
7740                     ; 1558 	else if(cnt_net_drv==6)
7742  15fe b632          	ld	a,_cnt_net_drv
7743  1600 a106          	cp	a,#6
7744  1602 2641          	jrne	L3343
7745                     ; 1560 		plazma_int[2]=pwm_u;
7747  1604 be0c          	ldw	x,_pwm_u
7748  1606 bf37          	ldw	_plazma_int+4,x
7749                     ; 1561 		can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
7751  1608 3b006a        	push	_Ui
7752  160b 3b006b        	push	_Ui+1
7753  160e 3b006c        	push	_Un
7754  1611 3b006d        	push	_Un+1
7755  1614 3b006e        	push	_I
7756  1617 3b006f        	push	_I+1
7757  161a 4bda          	push	#218
7758  161c 3b0005        	push	_adress
7759  161f ae018e        	ldw	x,#398
7760  1622 cd14aa        	call	_can_transmit
7762  1625 5b08          	addw	sp,#8
7763                     ; 1562 		can_transmit(0x18e,adress,PUTTM2,T,0,flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
7765  1627 3b0037        	push	_plazma_int+4
7766  162a 3b0038        	push	_plazma_int+5
7767  162d 3b005f        	push	__x_+1
7768  1630 3b000b        	push	_flags
7769  1633 4b00          	push	#0
7770  1635 3b0067        	push	_T
7771  1638 4bdb          	push	#219
7772  163a 3b0005        	push	_adress
7773  163d ae018e        	ldw	x,#398
7774  1640 cd14aa        	call	_can_transmit
7776  1643 5b08          	addw	sp,#8
7777  1645               L3343:
7778                     ; 1565 }
7781  1645 81            	ret
7894                     ; 1568 void can_in_an(void)
7894                     ; 1569 {
7895                     	switch	.text
7896  1646               _can_in_an:
7898  1646 5205          	subw	sp,#5
7899       00000005      OFST:	set	5
7902                     ; 1579 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
7904  1648 b6c9          	ld	a,_mess+6
7905  164a c10005        	cp	a,_adress
7906  164d 2703          	jreq	L671
7907  164f cc1762        	jp	L3053
7908  1652               L671:
7910  1652 b6ca          	ld	a,_mess+7
7911  1654 c10005        	cp	a,_adress
7912  1657 2703          	jreq	L002
7913  1659 cc1762        	jp	L3053
7914  165c               L002:
7916  165c b6cb          	ld	a,_mess+8
7917  165e a1ed          	cp	a,#237
7918  1660 2703          	jreq	L202
7919  1662 cc1762        	jp	L3053
7920  1665               L202:
7921                     ; 1582 	can_error_cnt=0;
7923  1665 3f70          	clr	_can_error_cnt
7924                     ; 1584 	bMAIN=0;
7926  1667 72110001      	bres	_bMAIN
7927                     ; 1585  	flags_tu=mess[9];
7929  166b 45cc60        	mov	_flags_tu,_mess+9
7930                     ; 1586  	if(flags_tu&0b00000001)
7932  166e b660          	ld	a,_flags_tu
7933  1670 a501          	bcp	a,#1
7934  1672 2706          	jreq	L5053
7935                     ; 1591  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
7937  1674 721a000b      	bset	_flags,#5
7939  1678 200e          	jra	L7053
7940  167a               L5053:
7941                     ; 1602  				flags&=0b11011111; 
7943  167a 721b000b      	bres	_flags,#5
7944                     ; 1603  				off_bp_cnt=5*ee_TZAS;
7946  167e c60017        	ld	a,_ee_TZAS+1
7947  1681 97            	ld	xl,a
7948  1682 a605          	ld	a,#5
7949  1684 42            	mul	x,a
7950  1685 9f            	ld	a,xl
7951  1686 b753          	ld	_off_bp_cnt,a
7952  1688               L7053:
7953                     ; 1609  	if(flags_tu&0b00000010) flags|=0b01000000;
7955  1688 b660          	ld	a,_flags_tu
7956  168a a502          	bcp	a,#2
7957  168c 2706          	jreq	L1153
7960  168e 721c000b      	bset	_flags,#6
7962  1692 2004          	jra	L3153
7963  1694               L1153:
7964                     ; 1610  	else flags&=0b10111111; 
7966  1694 721d000b      	bres	_flags,#6
7967  1698               L3153:
7968                     ; 1612  	vol_u_temp=mess[10]+mess[11]*256;
7970  1698 b6ce          	ld	a,_mess+11
7971  169a 5f            	clrw	x
7972  169b 97            	ld	xl,a
7973  169c 4f            	clr	a
7974  169d 02            	rlwa	x,a
7975  169e 01            	rrwa	x,a
7976  169f bbcd          	add	a,_mess+10
7977  16a1 2401          	jrnc	L651
7978  16a3 5c            	incw	x
7979  16a4               L651:
7980  16a4 b759          	ld	_vol_u_temp+1,a
7981  16a6 9f            	ld	a,xl
7982  16a7 b758          	ld	_vol_u_temp,a
7983                     ; 1613  	vol_i_temp=mess[12]+mess[13]*256;  
7985  16a9 b6d0          	ld	a,_mess+13
7986  16ab 5f            	clrw	x
7987  16ac 97            	ld	xl,a
7988  16ad 4f            	clr	a
7989  16ae 02            	rlwa	x,a
7990  16af 01            	rrwa	x,a
7991  16b0 bbcf          	add	a,_mess+12
7992  16b2 2401          	jrnc	L061
7993  16b4 5c            	incw	x
7994  16b5               L061:
7995  16b5 b757          	ld	_vol_i_temp+1,a
7996  16b7 9f            	ld	a,xl
7997  16b8 b756          	ld	_vol_i_temp,a
7998                     ; 1622 	plazma_int[2]=T;
8000  16ba 5f            	clrw	x
8001  16bb b667          	ld	a,_T
8002  16bd 2a01          	jrpl	L261
8003  16bf 53            	cplw	x
8004  16c0               L261:
8005  16c0 97            	ld	xl,a
8006  16c1 bf37          	ldw	_plazma_int+4,x
8007                     ; 1623  	rotor_int=flags_tu+(((short)flags)<<8);
8009  16c3 b60b          	ld	a,_flags
8010  16c5 5f            	clrw	x
8011  16c6 97            	ld	xl,a
8012  16c7 4f            	clr	a
8013  16c8 02            	rlwa	x,a
8014  16c9 01            	rrwa	x,a
8015  16ca bb60          	add	a,_flags_tu
8016  16cc 2401          	jrnc	L461
8017  16ce 5c            	incw	x
8018  16cf               L461:
8019  16cf b71c          	ld	_rotor_int+1,a
8020  16d1 9f            	ld	a,xl
8021  16d2 b71b          	ld	_rotor_int,a
8022                     ; 1624 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
8024  16d4 3b006a        	push	_Ui
8025  16d7 3b006b        	push	_Ui+1
8026  16da 3b006c        	push	_Un
8027  16dd 3b006d        	push	_Un+1
8028  16e0 3b006e        	push	_I
8029  16e3 3b006f        	push	_I+1
8030  16e6 4bda          	push	#218
8031  16e8 3b0005        	push	_adress
8032  16eb ae018e        	ldw	x,#398
8033  16ee cd14aa        	call	_can_transmit
8035  16f1 5b08          	addw	sp,#8
8036                     ; 1625 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&plazma_int[2])+1),*((char*)&plazma_int[2]));
8038  16f3 3b0037        	push	_plazma_int+4
8039  16f6 3b0038        	push	_plazma_int+5
8040  16f9 3b005f        	push	__x_+1
8041  16fc 3b000b        	push	_flags
8042  16ff b601          	ld	a,_vent_resurs_tx_cnt
8043  1701 5f            	clrw	x
8044  1702 97            	ld	xl,a
8045  1703 d60000        	ld	a,(_vent_resurs_buff,x)
8046  1706 88            	push	a
8047  1707 3b0067        	push	_T
8048  170a 4bdb          	push	#219
8049  170c 3b0005        	push	_adress
8050  170f ae018e        	ldw	x,#398
8051  1712 cd14aa        	call	_can_transmit
8053  1715 5b08          	addw	sp,#8
8054                     ; 1626      link_cnt=0;
8056  1717 3f61          	clr	_link_cnt
8057                     ; 1627      link=ON;
8059  1719 35550062      	mov	_link,#85
8060                     ; 1629      if(flags_tu&0b10000000)
8062  171d b660          	ld	a,_flags_tu
8063  171f a580          	bcp	a,#128
8064  1721 2716          	jreq	L5153
8065                     ; 1631      	if(!res_fl)
8067  1723 725d000b      	tnz	_res_fl
8068  1727 2625          	jrne	L1253
8069                     ; 1633      		res_fl=1;
8071  1729 a601          	ld	a,#1
8072  172b ae000b        	ldw	x,#_res_fl
8073  172e cd0000        	call	c_eewrc
8075                     ; 1634      		bRES=1;
8077  1731 35010010      	mov	_bRES,#1
8078                     ; 1635      		res_fl_cnt=0;
8080  1735 3f41          	clr	_res_fl_cnt
8081  1737 2015          	jra	L1253
8082  1739               L5153:
8083                     ; 1640      	if(main_cnt>20)
8085  1739 9c            	rvf
8086  173a be51          	ldw	x,_main_cnt
8087  173c a30015        	cpw	x,#21
8088  173f 2f0d          	jrslt	L1253
8089                     ; 1642     			if(res_fl)
8091  1741 725d000b      	tnz	_res_fl
8092  1745 2707          	jreq	L1253
8093                     ; 1644      			res_fl=0;
8095  1747 4f            	clr	a
8096  1748 ae000b        	ldw	x,#_res_fl
8097  174b cd0000        	call	c_eewrc
8099  174e               L1253:
8100                     ; 1649       if(res_fl_)
8102  174e 725d000a      	tnz	_res_fl_
8103  1752 2603          	jrne	L402
8104  1754 cc1cac        	jp	L7443
8105  1757               L402:
8106                     ; 1651       	res_fl_=0;
8108  1757 4f            	clr	a
8109  1758 ae000a        	ldw	x,#_res_fl_
8110  175b cd0000        	call	c_eewrc
8112  175e acac1cac      	jpf	L7443
8113  1762               L3053:
8114                     ; 1654 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
8116  1762 b6c9          	ld	a,_mess+6
8117  1764 c10005        	cp	a,_adress
8118  1767 2703          	jreq	L602
8119  1769 cc1978        	jp	L3353
8120  176c               L602:
8122  176c b6ca          	ld	a,_mess+7
8123  176e c10005        	cp	a,_adress
8124  1771 2703          	jreq	L012
8125  1773 cc1978        	jp	L3353
8126  1776               L012:
8128  1776 b6cb          	ld	a,_mess+8
8129  1778 a1ee          	cp	a,#238
8130  177a 2703          	jreq	L212
8131  177c cc1978        	jp	L3353
8132  177f               L212:
8134  177f b6cc          	ld	a,_mess+9
8135  1781 b1cd          	cp	a,_mess+10
8136  1783 2703          	jreq	L412
8137  1785 cc1978        	jp	L3353
8138  1788               L412:
8139                     ; 1656 	rotor_int++;
8141  1788 be1b          	ldw	x,_rotor_int
8142  178a 1c0001        	addw	x,#1
8143  178d bf1b          	ldw	_rotor_int,x
8144                     ; 1657 	if((mess[9]&0xf0)==0x20)
8146  178f b6cc          	ld	a,_mess+9
8147  1791 a4f0          	and	a,#240
8148  1793 a120          	cp	a,#32
8149  1795 2673          	jrne	L5353
8150                     ; 1659 		if((mess[9]&0x0f)==0x01)
8152  1797 b6cc          	ld	a,_mess+9
8153  1799 a40f          	and	a,#15
8154  179b a101          	cp	a,#1
8155  179d 260d          	jrne	L7353
8156                     ; 1661 			ee_K[0][0]=adc_buff_[4];
8158  179f ce0011        	ldw	x,_adc_buff_+8
8159  17a2 89            	pushw	x
8160  17a3 ae001a        	ldw	x,#_ee_K
8161  17a6 cd0000        	call	c_eewrw
8163  17a9 85            	popw	x
8165  17aa 204a          	jra	L1453
8166  17ac               L7353:
8167                     ; 1663 		else if((mess[9]&0x0f)==0x02)
8169  17ac b6cc          	ld	a,_mess+9
8170  17ae a40f          	and	a,#15
8171  17b0 a102          	cp	a,#2
8172  17b2 260b          	jrne	L3453
8173                     ; 1665 			ee_K[0][1]++;
8175  17b4 ce001c        	ldw	x,_ee_K+2
8176  17b7 1c0001        	addw	x,#1
8177  17ba cf001c        	ldw	_ee_K+2,x
8179  17bd 2037          	jra	L1453
8180  17bf               L3453:
8181                     ; 1667 		else if((mess[9]&0x0f)==0x03)
8183  17bf b6cc          	ld	a,_mess+9
8184  17c1 a40f          	and	a,#15
8185  17c3 a103          	cp	a,#3
8186  17c5 260b          	jrne	L7453
8187                     ; 1669 			ee_K[0][1]+=10;
8189  17c7 ce001c        	ldw	x,_ee_K+2
8190  17ca 1c000a        	addw	x,#10
8191  17cd cf001c        	ldw	_ee_K+2,x
8193  17d0 2024          	jra	L1453
8194  17d2               L7453:
8195                     ; 1671 		else if((mess[9]&0x0f)==0x04)
8197  17d2 b6cc          	ld	a,_mess+9
8198  17d4 a40f          	and	a,#15
8199  17d6 a104          	cp	a,#4
8200  17d8 260b          	jrne	L3553
8201                     ; 1673 			ee_K[0][1]--;
8203  17da ce001c        	ldw	x,_ee_K+2
8204  17dd 1d0001        	subw	x,#1
8205  17e0 cf001c        	ldw	_ee_K+2,x
8207  17e3 2011          	jra	L1453
8208  17e5               L3553:
8209                     ; 1675 		else if((mess[9]&0x0f)==0x05)
8211  17e5 b6cc          	ld	a,_mess+9
8212  17e7 a40f          	and	a,#15
8213  17e9 a105          	cp	a,#5
8214  17eb 2609          	jrne	L1453
8215                     ; 1677 			ee_K[0][1]-=10;
8217  17ed ce001c        	ldw	x,_ee_K+2
8218  17f0 1d000a        	subw	x,#10
8219  17f3 cf001c        	ldw	_ee_K+2,x
8220  17f6               L1453:
8221                     ; 1679 		granee(&ee_K[0][1],50,3000);									
8223  17f6 ae0bb8        	ldw	x,#3000
8224  17f9 89            	pushw	x
8225  17fa ae0032        	ldw	x,#50
8226  17fd 89            	pushw	x
8227  17fe ae001c        	ldw	x,#_ee_K+2
8228  1801 cd00e3        	call	_granee
8230  1804 5b04          	addw	sp,#4
8232  1806 ac5e195e      	jpf	L1653
8233  180a               L5353:
8234                     ; 1681 	else if((mess[9]&0xf0)==0x10)
8236  180a b6cc          	ld	a,_mess+9
8237  180c a4f0          	and	a,#240
8238  180e a110          	cp	a,#16
8239  1810 2673          	jrne	L3653
8240                     ; 1683 		if((mess[9]&0x0f)==0x01)
8242  1812 b6cc          	ld	a,_mess+9
8243  1814 a40f          	and	a,#15
8244  1816 a101          	cp	a,#1
8245  1818 260d          	jrne	L5653
8246                     ; 1685 			ee_K[1][0]=adc_buff_[1];
8248  181a ce000b        	ldw	x,_adc_buff_+2
8249  181d 89            	pushw	x
8250  181e ae001e        	ldw	x,#_ee_K+4
8251  1821 cd0000        	call	c_eewrw
8253  1824 85            	popw	x
8255  1825 204a          	jra	L7653
8256  1827               L5653:
8257                     ; 1687 		else if((mess[9]&0x0f)==0x02)
8259  1827 b6cc          	ld	a,_mess+9
8260  1829 a40f          	and	a,#15
8261  182b a102          	cp	a,#2
8262  182d 260b          	jrne	L1753
8263                     ; 1689 			ee_K[1][1]++;
8265  182f ce0020        	ldw	x,_ee_K+6
8266  1832 1c0001        	addw	x,#1
8267  1835 cf0020        	ldw	_ee_K+6,x
8269  1838 2037          	jra	L7653
8270  183a               L1753:
8271                     ; 1691 		else if((mess[9]&0x0f)==0x03)
8273  183a b6cc          	ld	a,_mess+9
8274  183c a40f          	and	a,#15
8275  183e a103          	cp	a,#3
8276  1840 260b          	jrne	L5753
8277                     ; 1693 			ee_K[1][1]+=10;
8279  1842 ce0020        	ldw	x,_ee_K+6
8280  1845 1c000a        	addw	x,#10
8281  1848 cf0020        	ldw	_ee_K+6,x
8283  184b 2024          	jra	L7653
8284  184d               L5753:
8285                     ; 1695 		else if((mess[9]&0x0f)==0x04)
8287  184d b6cc          	ld	a,_mess+9
8288  184f a40f          	and	a,#15
8289  1851 a104          	cp	a,#4
8290  1853 260b          	jrne	L1063
8291                     ; 1697 			ee_K[1][1]--;
8293  1855 ce0020        	ldw	x,_ee_K+6
8294  1858 1d0001        	subw	x,#1
8295  185b cf0020        	ldw	_ee_K+6,x
8297  185e 2011          	jra	L7653
8298  1860               L1063:
8299                     ; 1699 		else if((mess[9]&0x0f)==0x05)
8301  1860 b6cc          	ld	a,_mess+9
8302  1862 a40f          	and	a,#15
8303  1864 a105          	cp	a,#5
8304  1866 2609          	jrne	L7653
8305                     ; 1701 			ee_K[1][1]-=10;
8307  1868 ce0020        	ldw	x,_ee_K+6
8308  186b 1d000a        	subw	x,#10
8309  186e cf0020        	ldw	_ee_K+6,x
8310  1871               L7653:
8311                     ; 1706 		granee(&ee_K[1][1],10,30000);
8313  1871 ae7530        	ldw	x,#30000
8314  1874 89            	pushw	x
8315  1875 ae000a        	ldw	x,#10
8316  1878 89            	pushw	x
8317  1879 ae0020        	ldw	x,#_ee_K+6
8318  187c cd00e3        	call	_granee
8320  187f 5b04          	addw	sp,#4
8322  1881 ac5e195e      	jpf	L1653
8323  1885               L3653:
8324                     ; 1710 	else if((mess[9]&0xf0)==0x00)
8326  1885 b6cc          	ld	a,_mess+9
8327  1887 a5f0          	bcp	a,#240
8328  1889 2671          	jrne	L1163
8329                     ; 1712 		if((mess[9]&0x0f)==0x01)
8331  188b b6cc          	ld	a,_mess+9
8332  188d a40f          	and	a,#15
8333  188f a101          	cp	a,#1
8334  1891 260d          	jrne	L3163
8335                     ; 1714 			ee_K[2][0]=adc_buff_[2];
8337  1893 ce000d        	ldw	x,_adc_buff_+4
8338  1896 89            	pushw	x
8339  1897 ae0022        	ldw	x,#_ee_K+8
8340  189a cd0000        	call	c_eewrw
8342  189d 85            	popw	x
8344  189e 204a          	jra	L5163
8345  18a0               L3163:
8346                     ; 1716 		else if((mess[9]&0x0f)==0x02)
8348  18a0 b6cc          	ld	a,_mess+9
8349  18a2 a40f          	and	a,#15
8350  18a4 a102          	cp	a,#2
8351  18a6 260b          	jrne	L7163
8352                     ; 1718 			ee_K[2][1]++;
8354  18a8 ce0024        	ldw	x,_ee_K+10
8355  18ab 1c0001        	addw	x,#1
8356  18ae cf0024        	ldw	_ee_K+10,x
8358  18b1 2037          	jra	L5163
8359  18b3               L7163:
8360                     ; 1720 		else if((mess[9]&0x0f)==0x03)
8362  18b3 b6cc          	ld	a,_mess+9
8363  18b5 a40f          	and	a,#15
8364  18b7 a103          	cp	a,#3
8365  18b9 260b          	jrne	L3263
8366                     ; 1722 			ee_K[2][1]+=10;
8368  18bb ce0024        	ldw	x,_ee_K+10
8369  18be 1c000a        	addw	x,#10
8370  18c1 cf0024        	ldw	_ee_K+10,x
8372  18c4 2024          	jra	L5163
8373  18c6               L3263:
8374                     ; 1724 		else if((mess[9]&0x0f)==0x04)
8376  18c6 b6cc          	ld	a,_mess+9
8377  18c8 a40f          	and	a,#15
8378  18ca a104          	cp	a,#4
8379  18cc 260b          	jrne	L7263
8380                     ; 1726 			ee_K[2][1]--;
8382  18ce ce0024        	ldw	x,_ee_K+10
8383  18d1 1d0001        	subw	x,#1
8384  18d4 cf0024        	ldw	_ee_K+10,x
8386  18d7 2011          	jra	L5163
8387  18d9               L7263:
8388                     ; 1728 		else if((mess[9]&0x0f)==0x05)
8390  18d9 b6cc          	ld	a,_mess+9
8391  18db a40f          	and	a,#15
8392  18dd a105          	cp	a,#5
8393  18df 2609          	jrne	L5163
8394                     ; 1730 			ee_K[2][1]-=10;
8396  18e1 ce0024        	ldw	x,_ee_K+10
8397  18e4 1d000a        	subw	x,#10
8398  18e7 cf0024        	ldw	_ee_K+10,x
8399  18ea               L5163:
8400                     ; 1735 		granee(&ee_K[2][1],10,30000);
8402  18ea ae7530        	ldw	x,#30000
8403  18ed 89            	pushw	x
8404  18ee ae000a        	ldw	x,#10
8405  18f1 89            	pushw	x
8406  18f2 ae0024        	ldw	x,#_ee_K+10
8407  18f5 cd00e3        	call	_granee
8409  18f8 5b04          	addw	sp,#4
8411  18fa 2062          	jra	L1653
8412  18fc               L1163:
8413                     ; 1739 	else if((mess[9]&0xf0)==0x30)
8415  18fc b6cc          	ld	a,_mess+9
8416  18fe a4f0          	and	a,#240
8417  1900 a130          	cp	a,#48
8418  1902 265a          	jrne	L1653
8419                     ; 1741 		if((mess[9]&0x0f)==0x02)
8421  1904 b6cc          	ld	a,_mess+9
8422  1906 a40f          	and	a,#15
8423  1908 a102          	cp	a,#2
8424  190a 260b          	jrne	L1463
8425                     ; 1743 			ee_K[3][1]++;
8427  190c ce0028        	ldw	x,_ee_K+14
8428  190f 1c0001        	addw	x,#1
8429  1912 cf0028        	ldw	_ee_K+14,x
8431  1915 2037          	jra	L3463
8432  1917               L1463:
8433                     ; 1745 		else if((mess[9]&0x0f)==0x03)
8435  1917 b6cc          	ld	a,_mess+9
8436  1919 a40f          	and	a,#15
8437  191b a103          	cp	a,#3
8438  191d 260b          	jrne	L5463
8439                     ; 1747 			ee_K[3][1]+=10;
8441  191f ce0028        	ldw	x,_ee_K+14
8442  1922 1c000a        	addw	x,#10
8443  1925 cf0028        	ldw	_ee_K+14,x
8445  1928 2024          	jra	L3463
8446  192a               L5463:
8447                     ; 1749 		else if((mess[9]&0x0f)==0x04)
8449  192a b6cc          	ld	a,_mess+9
8450  192c a40f          	and	a,#15
8451  192e a104          	cp	a,#4
8452  1930 260b          	jrne	L1563
8453                     ; 1751 			ee_K[3][1]--;
8455  1932 ce0028        	ldw	x,_ee_K+14
8456  1935 1d0001        	subw	x,#1
8457  1938 cf0028        	ldw	_ee_K+14,x
8459  193b 2011          	jra	L3463
8460  193d               L1563:
8461                     ; 1753 		else if((mess[9]&0x0f)==0x05)
8463  193d b6cc          	ld	a,_mess+9
8464  193f a40f          	and	a,#15
8465  1941 a105          	cp	a,#5
8466  1943 2609          	jrne	L3463
8467                     ; 1755 			ee_K[3][1]-=10;
8469  1945 ce0028        	ldw	x,_ee_K+14
8470  1948 1d000a        	subw	x,#10
8471  194b cf0028        	ldw	_ee_K+14,x
8472  194e               L3463:
8473                     ; 1757 		granee(&ee_K[3][1],300,517);									
8475  194e ae0205        	ldw	x,#517
8476  1951 89            	pushw	x
8477  1952 ae012c        	ldw	x,#300
8478  1955 89            	pushw	x
8479  1956 ae0028        	ldw	x,#_ee_K+14
8480  1959 cd00e3        	call	_granee
8482  195c 5b04          	addw	sp,#4
8483  195e               L1653:
8484                     ; 1760 	link_cnt=0;
8486  195e 3f61          	clr	_link_cnt
8487                     ; 1761      link=ON;
8489  1960 35550062      	mov	_link,#85
8490                     ; 1762      if(res_fl_)
8492  1964 725d000a      	tnz	_res_fl_
8493  1968 2603          	jrne	L612
8494  196a cc1cac        	jp	L7443
8495  196d               L612:
8496                     ; 1764       	res_fl_=0;
8498  196d 4f            	clr	a
8499  196e ae000a        	ldw	x,#_res_fl_
8500  1971 cd0000        	call	c_eewrc
8502  1974 acac1cac      	jpf	L7443
8503  1978               L3353:
8504                     ; 1770 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
8506  1978 b6c9          	ld	a,_mess+6
8507  197a a1ff          	cp	a,#255
8508  197c 2703          	jreq	L022
8509  197e cc1a0c        	jp	L3663
8510  1981               L022:
8512  1981 b6ca          	ld	a,_mess+7
8513  1983 a1ff          	cp	a,#255
8514  1985 2703          	jreq	L222
8515  1987 cc1a0c        	jp	L3663
8516  198a               L222:
8518  198a b6cb          	ld	a,_mess+8
8519  198c a162          	cp	a,#98
8520  198e 267c          	jrne	L3663
8521                     ; 1773 	tempSS=mess[9]+(mess[10]*256);
8523  1990 b6cd          	ld	a,_mess+10
8524  1992 5f            	clrw	x
8525  1993 97            	ld	xl,a
8526  1994 4f            	clr	a
8527  1995 02            	rlwa	x,a
8528  1996 01            	rrwa	x,a
8529  1997 bbcc          	add	a,_mess+9
8530  1999 2401          	jrnc	L661
8531  199b 5c            	incw	x
8532  199c               L661:
8533  199c 02            	rlwa	x,a
8534  199d 1f04          	ldw	(OFST-1,sp),x
8535  199f 01            	rrwa	x,a
8536                     ; 1774 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
8538  19a0 ce0014        	ldw	x,_ee_Umax
8539  19a3 1304          	cpw	x,(OFST-1,sp)
8540  19a5 270a          	jreq	L5663
8543  19a7 1e04          	ldw	x,(OFST-1,sp)
8544  19a9 89            	pushw	x
8545  19aa ae0014        	ldw	x,#_ee_Umax
8546  19ad cd0000        	call	c_eewrw
8548  19b0 85            	popw	x
8549  19b1               L5663:
8550                     ; 1775 	tempSS=mess[11]+(mess[12]*256);
8552  19b1 b6cf          	ld	a,_mess+12
8553  19b3 5f            	clrw	x
8554  19b4 97            	ld	xl,a
8555  19b5 4f            	clr	a
8556  19b6 02            	rlwa	x,a
8557  19b7 01            	rrwa	x,a
8558  19b8 bbce          	add	a,_mess+11
8559  19ba 2401          	jrnc	L071
8560  19bc 5c            	incw	x
8561  19bd               L071:
8562  19bd 02            	rlwa	x,a
8563  19be 1f04          	ldw	(OFST-1,sp),x
8564  19c0 01            	rrwa	x,a
8565                     ; 1776 	if(ee_dU!=tempSS) ee_dU=tempSS;
8567  19c1 ce0012        	ldw	x,_ee_dU
8568  19c4 1304          	cpw	x,(OFST-1,sp)
8569  19c6 270a          	jreq	L7663
8572  19c8 1e04          	ldw	x,(OFST-1,sp)
8573  19ca 89            	pushw	x
8574  19cb ae0012        	ldw	x,#_ee_dU
8575  19ce cd0000        	call	c_eewrw
8577  19d1 85            	popw	x
8578  19d2               L7663:
8579                     ; 1777 	if((mess[13]&0x0f)==0x5)
8581  19d2 b6d0          	ld	a,_mess+13
8582  19d4 a40f          	and	a,#15
8583  19d6 a105          	cp	a,#5
8584  19d8 261a          	jrne	L1763
8585                     ; 1779 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
8587  19da ce0006        	ldw	x,_ee_AVT_MODE
8588  19dd a30055        	cpw	x,#85
8589  19e0 2603          	jrne	L422
8590  19e2 cc1cac        	jp	L7443
8591  19e5               L422:
8594  19e5 ae0055        	ldw	x,#85
8595  19e8 89            	pushw	x
8596  19e9 ae0006        	ldw	x,#_ee_AVT_MODE
8597  19ec cd0000        	call	c_eewrw
8599  19ef 85            	popw	x
8600  19f0 acac1cac      	jpf	L7443
8601  19f4               L1763:
8602                     ; 1781 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
8604  19f4 ce0006        	ldw	x,_ee_AVT_MODE
8605  19f7 a30055        	cpw	x,#85
8606  19fa 2703          	jreq	L622
8607  19fc cc1cac        	jp	L7443
8608  19ff               L622:
8611  19ff 5f            	clrw	x
8612  1a00 89            	pushw	x
8613  1a01 ae0006        	ldw	x,#_ee_AVT_MODE
8614  1a04 cd0000        	call	c_eewrw
8616  1a07 85            	popw	x
8617  1a08 acac1cac      	jpf	L7443
8618  1a0c               L3663:
8619                     ; 1784 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
8621  1a0c b6c9          	ld	a,_mess+6
8622  1a0e a1ff          	cp	a,#255
8623  1a10 2703          	jreq	L032
8624  1a12 cc1ae3        	jp	L3073
8625  1a15               L032:
8627  1a15 b6ca          	ld	a,_mess+7
8628  1a17 a1ff          	cp	a,#255
8629  1a19 2703          	jreq	L232
8630  1a1b cc1ae3        	jp	L3073
8631  1a1e               L232:
8633  1a1e b6cb          	ld	a,_mess+8
8634  1a20 a126          	cp	a,#38
8635  1a22 2709          	jreq	L5073
8637  1a24 b6cb          	ld	a,_mess+8
8638  1a26 a129          	cp	a,#41
8639  1a28 2703          	jreq	L432
8640  1a2a cc1ae3        	jp	L3073
8641  1a2d               L432:
8642  1a2d               L5073:
8643                     ; 1787 	tempSS=mess[9]+(mess[10]*256);
8645  1a2d b6cd          	ld	a,_mess+10
8646  1a2f 5f            	clrw	x
8647  1a30 97            	ld	xl,a
8648  1a31 4f            	clr	a
8649  1a32 02            	rlwa	x,a
8650  1a33 01            	rrwa	x,a
8651  1a34 bbcc          	add	a,_mess+9
8652  1a36 2401          	jrnc	L271
8653  1a38 5c            	incw	x
8654  1a39               L271:
8655  1a39 02            	rlwa	x,a
8656  1a3a 1f04          	ldw	(OFST-1,sp),x
8657  1a3c 01            	rrwa	x,a
8658                     ; 1788 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
8660  1a3d ce0010        	ldw	x,_ee_tmax
8661  1a40 1304          	cpw	x,(OFST-1,sp)
8662  1a42 270a          	jreq	L7073
8665  1a44 1e04          	ldw	x,(OFST-1,sp)
8666  1a46 89            	pushw	x
8667  1a47 ae0010        	ldw	x,#_ee_tmax
8668  1a4a cd0000        	call	c_eewrw
8670  1a4d 85            	popw	x
8671  1a4e               L7073:
8672                     ; 1789 	tempSS=mess[11]+(mess[12]*256);
8674  1a4e b6cf          	ld	a,_mess+12
8675  1a50 5f            	clrw	x
8676  1a51 97            	ld	xl,a
8677  1a52 4f            	clr	a
8678  1a53 02            	rlwa	x,a
8679  1a54 01            	rrwa	x,a
8680  1a55 bbce          	add	a,_mess+11
8681  1a57 2401          	jrnc	L471
8682  1a59 5c            	incw	x
8683  1a5a               L471:
8684  1a5a 02            	rlwa	x,a
8685  1a5b 1f04          	ldw	(OFST-1,sp),x
8686  1a5d 01            	rrwa	x,a
8687                     ; 1790 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
8689  1a5e ce000e        	ldw	x,_ee_tsign
8690  1a61 1304          	cpw	x,(OFST-1,sp)
8691  1a63 270a          	jreq	L1173
8694  1a65 1e04          	ldw	x,(OFST-1,sp)
8695  1a67 89            	pushw	x
8696  1a68 ae000e        	ldw	x,#_ee_tsign
8697  1a6b cd0000        	call	c_eewrw
8699  1a6e 85            	popw	x
8700  1a6f               L1173:
8701                     ; 1793 	if(mess[8]==MEM_KF1)
8703  1a6f b6cb          	ld	a,_mess+8
8704  1a71 a126          	cp	a,#38
8705  1a73 2623          	jrne	L3173
8706                     ; 1795 		if(ee_DEVICE!=0)ee_DEVICE=0;
8708  1a75 ce0004        	ldw	x,_ee_DEVICE
8709  1a78 2709          	jreq	L5173
8712  1a7a 5f            	clrw	x
8713  1a7b 89            	pushw	x
8714  1a7c ae0004        	ldw	x,#_ee_DEVICE
8715  1a7f cd0000        	call	c_eewrw
8717  1a82 85            	popw	x
8718  1a83               L5173:
8719                     ; 1796 		if(ee_TZAS!=(signed short)mess[13]) ee_TZAS=(signed short)mess[13];
8721  1a83 b6d0          	ld	a,_mess+13
8722  1a85 5f            	clrw	x
8723  1a86 97            	ld	xl,a
8724  1a87 c30016        	cpw	x,_ee_TZAS
8725  1a8a 270c          	jreq	L3173
8728  1a8c b6d0          	ld	a,_mess+13
8729  1a8e 5f            	clrw	x
8730  1a8f 97            	ld	xl,a
8731  1a90 89            	pushw	x
8732  1a91 ae0016        	ldw	x,#_ee_TZAS
8733  1a94 cd0000        	call	c_eewrw
8735  1a97 85            	popw	x
8736  1a98               L3173:
8737                     ; 1798 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
8739  1a98 b6cb          	ld	a,_mess+8
8740  1a9a a129          	cp	a,#41
8741  1a9c 2703          	jreq	L632
8742  1a9e cc1cac        	jp	L7443
8743  1aa1               L632:
8744                     ; 1800 		if(ee_DEVICE!=1)ee_DEVICE=1;
8746  1aa1 ce0004        	ldw	x,_ee_DEVICE
8747  1aa4 a30001        	cpw	x,#1
8748  1aa7 270b          	jreq	L3273
8751  1aa9 ae0001        	ldw	x,#1
8752  1aac 89            	pushw	x
8753  1aad ae0004        	ldw	x,#_ee_DEVICE
8754  1ab0 cd0000        	call	c_eewrw
8756  1ab3 85            	popw	x
8757  1ab4               L3273:
8758                     ; 1801 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
8760  1ab4 b6d0          	ld	a,_mess+13
8761  1ab6 5f            	clrw	x
8762  1ab7 97            	ld	xl,a
8763  1ab8 c30002        	cpw	x,_ee_IMAXVENT
8764  1abb 270c          	jreq	L5273
8767  1abd b6d0          	ld	a,_mess+13
8768  1abf 5f            	clrw	x
8769  1ac0 97            	ld	xl,a
8770  1ac1 89            	pushw	x
8771  1ac2 ae0002        	ldw	x,#_ee_IMAXVENT
8772  1ac5 cd0000        	call	c_eewrw
8774  1ac8 85            	popw	x
8775  1ac9               L5273:
8776                     ; 1802 			if(ee_TZAS!=3) ee_TZAS=3;
8778  1ac9 ce0016        	ldw	x,_ee_TZAS
8779  1acc a30003        	cpw	x,#3
8780  1acf 2603          	jrne	L042
8781  1ad1 cc1cac        	jp	L7443
8782  1ad4               L042:
8785  1ad4 ae0003        	ldw	x,#3
8786  1ad7 89            	pushw	x
8787  1ad8 ae0016        	ldw	x,#_ee_TZAS
8788  1adb cd0000        	call	c_eewrw
8790  1ade 85            	popw	x
8791  1adf acac1cac      	jpf	L7443
8792  1ae3               L3073:
8793                     ; 1806 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
8795  1ae3 b6c9          	ld	a,_mess+6
8796  1ae5 c10005        	cp	a,_adress
8797  1ae8 262d          	jrne	L3373
8799  1aea b6ca          	ld	a,_mess+7
8800  1aec c10005        	cp	a,_adress
8801  1aef 2626          	jrne	L3373
8803  1af1 b6cb          	ld	a,_mess+8
8804  1af3 a116          	cp	a,#22
8805  1af5 2620          	jrne	L3373
8807  1af7 b6cc          	ld	a,_mess+9
8808  1af9 a163          	cp	a,#99
8809  1afb 261a          	jrne	L3373
8810                     ; 1808 	flags&=0b11100001;
8812  1afd b60b          	ld	a,_flags
8813  1aff a4e1          	and	a,#225
8814  1b01 b70b          	ld	_flags,a
8815                     ; 1809 	tsign_cnt=0;
8817  1b03 5f            	clrw	x
8818  1b04 bf4d          	ldw	_tsign_cnt,x
8819                     ; 1810 	tmax_cnt=0;
8821  1b06 5f            	clrw	x
8822  1b07 bf4b          	ldw	_tmax_cnt,x
8823                     ; 1811 	umax_cnt=0;
8825  1b09 5f            	clrw	x
8826  1b0a bf65          	ldw	_umax_cnt,x
8827                     ; 1812 	umin_cnt=0;
8829  1b0c 5f            	clrw	x
8830  1b0d bf63          	ldw	_umin_cnt,x
8831                     ; 1813 	led_drv_cnt=30;
8833  1b0f 351e001a      	mov	_led_drv_cnt,#30
8835  1b13 acac1cac      	jpf	L7443
8836  1b17               L3373:
8837                     ; 1816 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
8839  1b17 b6c9          	ld	a,_mess+6
8840  1b19 c10005        	cp	a,_adress
8841  1b1c 2620          	jrne	L7373
8843  1b1e b6ca          	ld	a,_mess+7
8844  1b20 c10005        	cp	a,_adress
8845  1b23 2619          	jrne	L7373
8847  1b25 b6cb          	ld	a,_mess+8
8848  1b27 a116          	cp	a,#22
8849  1b29 2613          	jrne	L7373
8851  1b2b b6cc          	ld	a,_mess+9
8852  1b2d a164          	cp	a,#100
8853  1b2f 260d          	jrne	L7373
8854                     ; 1818 	vent_resurs=0;
8856  1b31 5f            	clrw	x
8857  1b32 89            	pushw	x
8858  1b33 ae0000        	ldw	x,#_vent_resurs
8859  1b36 cd0000        	call	c_eewrw
8861  1b39 85            	popw	x
8863  1b3a acac1cac      	jpf	L7443
8864  1b3e               L7373:
8865                     ; 1822 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
8867  1b3e b6c9          	ld	a,_mess+6
8868  1b40 a1ff          	cp	a,#255
8869  1b42 265f          	jrne	L3473
8871  1b44 b6ca          	ld	a,_mess+7
8872  1b46 a1ff          	cp	a,#255
8873  1b48 2659          	jrne	L3473
8875  1b4a b6cb          	ld	a,_mess+8
8876  1b4c a116          	cp	a,#22
8877  1b4e 2653          	jrne	L3473
8879  1b50 b6cc          	ld	a,_mess+9
8880  1b52 a116          	cp	a,#22
8881  1b54 264d          	jrne	L3473
8882                     ; 1824 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
8884  1b56 b6cd          	ld	a,_mess+10
8885  1b58 a155          	cp	a,#85
8886  1b5a 260f          	jrne	L5473
8888  1b5c b6ce          	ld	a,_mess+11
8889  1b5e a155          	cp	a,#85
8890  1b60 2609          	jrne	L5473
8893  1b62 be5e          	ldw	x,__x_
8894  1b64 1c0001        	addw	x,#1
8895  1b67 bf5e          	ldw	__x_,x
8897  1b69 2024          	jra	L7473
8898  1b6b               L5473:
8899                     ; 1825 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
8901  1b6b b6cd          	ld	a,_mess+10
8902  1b6d a166          	cp	a,#102
8903  1b6f 260f          	jrne	L1573
8905  1b71 b6ce          	ld	a,_mess+11
8906  1b73 a166          	cp	a,#102
8907  1b75 2609          	jrne	L1573
8910  1b77 be5e          	ldw	x,__x_
8911  1b79 1d0001        	subw	x,#1
8912  1b7c bf5e          	ldw	__x_,x
8914  1b7e 200f          	jra	L7473
8915  1b80               L1573:
8916                     ; 1826 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
8918  1b80 b6cd          	ld	a,_mess+10
8919  1b82 a177          	cp	a,#119
8920  1b84 2609          	jrne	L7473
8922  1b86 b6ce          	ld	a,_mess+11
8923  1b88 a177          	cp	a,#119
8924  1b8a 2603          	jrne	L7473
8927  1b8c 5f            	clrw	x
8928  1b8d bf5e          	ldw	__x_,x
8929  1b8f               L7473:
8930                     ; 1827      gran(&_x_,-XMAX,XMAX);
8932  1b8f ae0019        	ldw	x,#25
8933  1b92 89            	pushw	x
8934  1b93 aeffe7        	ldw	x,#65511
8935  1b96 89            	pushw	x
8936  1b97 ae005e        	ldw	x,#__x_
8937  1b9a cd00c2        	call	_gran
8939  1b9d 5b04          	addw	sp,#4
8941  1b9f acac1cac      	jpf	L7443
8942  1ba3               L3473:
8943                     ; 1829 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
8945  1ba3 b6c9          	ld	a,_mess+6
8946  1ba5 c10005        	cp	a,_adress
8947  1ba8 2665          	jrne	L1673
8949  1baa b6ca          	ld	a,_mess+7
8950  1bac c10005        	cp	a,_adress
8951  1baf 265e          	jrne	L1673
8953  1bb1 b6cb          	ld	a,_mess+8
8954  1bb3 a116          	cp	a,#22
8955  1bb5 2658          	jrne	L1673
8957  1bb7 b6cc          	ld	a,_mess+9
8958  1bb9 b1cd          	cp	a,_mess+10
8959  1bbb 2652          	jrne	L1673
8961  1bbd b6cc          	ld	a,_mess+9
8962  1bbf a1ee          	cp	a,#238
8963  1bc1 264c          	jrne	L1673
8964                     ; 1831 	rotor_int++;
8966  1bc3 be1b          	ldw	x,_rotor_int
8967  1bc5 1c0001        	addw	x,#1
8968  1bc8 bf1b          	ldw	_rotor_int,x
8969                     ; 1832      tempI=pwm_u;
8971  1bca be0c          	ldw	x,_pwm_u
8972  1bcc 1f04          	ldw	(OFST-1,sp),x
8973                     ; 1833 	ee_U_AVT=tempI;
8975  1bce 1e04          	ldw	x,(OFST-1,sp)
8976  1bd0 89            	pushw	x
8977  1bd1 ae000c        	ldw	x,#_ee_U_AVT
8978  1bd4 cd0000        	call	c_eewrw
8980  1bd7 85            	popw	x
8981                     ; 1834 	UU_AVT=Un;
8983  1bd8 be6c          	ldw	x,_Un
8984  1bda 89            	pushw	x
8985  1bdb ae0008        	ldw	x,#_UU_AVT
8986  1bde cd0000        	call	c_eewrw
8988  1be1 85            	popw	x
8989                     ; 1835 	delay_ms(100);
8991  1be2 ae0064        	ldw	x,#100
8992  1be5 cd010e        	call	_delay_ms
8994                     ; 1836 	if(ee_U_AVT==tempI)can_transmit(0x18e,adress,PUTID,0xdd,0xdd,0,0,0,0);
8996  1be8 ce000c        	ldw	x,_ee_U_AVT
8997  1beb 1304          	cpw	x,(OFST-1,sp)
8998  1bed 2703          	jreq	L242
8999  1bef cc1cac        	jp	L7443
9000  1bf2               L242:
9003  1bf2 4b00          	push	#0
9004  1bf4 4b00          	push	#0
9005  1bf6 4b00          	push	#0
9006  1bf8 4b00          	push	#0
9007  1bfa 4bdd          	push	#221
9008  1bfc 4bdd          	push	#221
9009  1bfe 4b91          	push	#145
9010  1c00 3b0005        	push	_adress
9011  1c03 ae018e        	ldw	x,#398
9012  1c06 cd14aa        	call	_can_transmit
9014  1c09 5b08          	addw	sp,#8
9015  1c0b acac1cac      	jpf	L7443
9016  1c0f               L1673:
9017                     ; 1841 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9019  1c0f b6ca          	ld	a,_mess+7
9020  1c11 a1da          	cp	a,#218
9021  1c13 2652          	jrne	L7673
9023  1c15 b6c9          	ld	a,_mess+6
9024  1c17 c10005        	cp	a,_adress
9025  1c1a 274b          	jreq	L7673
9027  1c1c b6c9          	ld	a,_mess+6
9028  1c1e a106          	cp	a,#6
9029  1c20 2445          	jruge	L7673
9030                     ; 1843 	i_main_bps_cnt[mess[6]]=0;
9032  1c22 b6c9          	ld	a,_mess+6
9033  1c24 5f            	clrw	x
9034  1c25 97            	ld	xl,a
9035  1c26 6f09          	clr	(_i_main_bps_cnt,x)
9036                     ; 1844 	i_main_flag[mess[6]]=1;
9038  1c28 b6c9          	ld	a,_mess+6
9039  1c2a 5f            	clrw	x
9040  1c2b 97            	ld	xl,a
9041  1c2c a601          	ld	a,#1
9042  1c2e e714          	ld	(_i_main_flag,x),a
9043                     ; 1845 	if(bMAIN)
9045                     	btst	_bMAIN
9046  1c35 2475          	jruge	L7443
9047                     ; 1847 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
9049  1c37 b6cc          	ld	a,_mess+9
9050  1c39 5f            	clrw	x
9051  1c3a 97            	ld	xl,a
9052  1c3b 4f            	clr	a
9053  1c3c 02            	rlwa	x,a
9054  1c3d 1f01          	ldw	(OFST-4,sp),x
9055  1c3f b6cb          	ld	a,_mess+8
9056  1c41 5f            	clrw	x
9057  1c42 97            	ld	xl,a
9058  1c43 72fb01        	addw	x,(OFST-4,sp)
9059  1c46 b6c9          	ld	a,_mess+6
9060  1c48 905f          	clrw	y
9061  1c4a 9097          	ld	yl,a
9062  1c4c 9058          	sllw	y
9063  1c4e 90ef1a        	ldw	(_i_main,y),x
9064                     ; 1848 		i_main[adress]=I;
9066  1c51 c60005        	ld	a,_adress
9067  1c54 5f            	clrw	x
9068  1c55 97            	ld	xl,a
9069  1c56 58            	sllw	x
9070  1c57 90be6e        	ldw	y,_I
9071  1c5a ef1a          	ldw	(_i_main,x),y
9072                     ; 1849      	i_main_flag[adress]=1;
9074  1c5c c60005        	ld	a,_adress
9075  1c5f 5f            	clrw	x
9076  1c60 97            	ld	xl,a
9077  1c61 a601          	ld	a,#1
9078  1c63 e714          	ld	(_i_main_flag,x),a
9079  1c65 2045          	jra	L7443
9080  1c67               L7673:
9081                     ; 1853 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
9083  1c67 b6ca          	ld	a,_mess+7
9084  1c69 a1db          	cp	a,#219
9085  1c6b 263f          	jrne	L7443
9087  1c6d b6c9          	ld	a,_mess+6
9088  1c6f c10005        	cp	a,_adress
9089  1c72 2738          	jreq	L7443
9091  1c74 b6c9          	ld	a,_mess+6
9092  1c76 a106          	cp	a,#6
9093  1c78 2432          	jruge	L7443
9094                     ; 1855 	i_main_bps_cnt[mess[6]]=0;
9096  1c7a b6c9          	ld	a,_mess+6
9097  1c7c 5f            	clrw	x
9098  1c7d 97            	ld	xl,a
9099  1c7e 6f09          	clr	(_i_main_bps_cnt,x)
9100                     ; 1856 	i_main_flag[mess[6]]=1;		
9102  1c80 b6c9          	ld	a,_mess+6
9103  1c82 5f            	clrw	x
9104  1c83 97            	ld	xl,a
9105  1c84 a601          	ld	a,#1
9106  1c86 e714          	ld	(_i_main_flag,x),a
9107                     ; 1857 	if(bMAIN)
9109                     	btst	_bMAIN
9110  1c8d 241d          	jruge	L7443
9111                     ; 1859 		if(mess[9]==0)i_main_flag[i]=1;
9113  1c8f 3dcc          	tnz	_mess+9
9114  1c91 260a          	jrne	L1004
9117  1c93 7b03          	ld	a,(OFST-2,sp)
9118  1c95 5f            	clrw	x
9119  1c96 97            	ld	xl,a
9120  1c97 a601          	ld	a,#1
9121  1c99 e714          	ld	(_i_main_flag,x),a
9123  1c9b 2006          	jra	L3004
9124  1c9d               L1004:
9125                     ; 1860 		else i_main_flag[i]=0;
9127  1c9d 7b03          	ld	a,(OFST-2,sp)
9128  1c9f 5f            	clrw	x
9129  1ca0 97            	ld	xl,a
9130  1ca1 6f14          	clr	(_i_main_flag,x)
9131  1ca3               L3004:
9132                     ; 1861 		i_main_flag[adress]=1;
9134  1ca3 c60005        	ld	a,_adress
9135  1ca6 5f            	clrw	x
9136  1ca7 97            	ld	xl,a
9137  1ca8 a601          	ld	a,#1
9138  1caa e714          	ld	(_i_main_flag,x),a
9139  1cac               L7443:
9140                     ; 1867 can_in_an_end:
9140                     ; 1868 bCAN_RX=0;
9142  1cac 3f0a          	clr	_bCAN_RX
9143                     ; 1869 }   
9146  1cae 5b05          	addw	sp,#5
9147  1cb0 81            	ret
9170                     ; 1872 void t4_init(void){
9171                     	switch	.text
9172  1cb1               _t4_init:
9176                     ; 1873 	TIM4->PSCR = 4;
9178  1cb1 35045345      	mov	21317,#4
9179                     ; 1874 	TIM4->ARR= 77;
9181  1cb5 354d5346      	mov	21318,#77
9182                     ; 1875 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
9184  1cb9 72105341      	bset	21313,#0
9185                     ; 1877 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
9187  1cbd 35855340      	mov	21312,#133
9188                     ; 1879 }
9191  1cc1 81            	ret
9214                     ; 1882 void t1_init(void)
9214                     ; 1883 {
9215                     	switch	.text
9216  1cc2               _t1_init:
9220                     ; 1884 TIM1->ARRH= 0x03;
9222  1cc2 35035262      	mov	21090,#3
9223                     ; 1885 TIM1->ARRL= 0xff;
9225  1cc6 35ff5263      	mov	21091,#255
9226                     ; 1886 TIM1->CCR1H= 0x00;	
9228  1cca 725f5265      	clr	21093
9229                     ; 1887 TIM1->CCR1L= 0xff;
9231  1cce 35ff5266      	mov	21094,#255
9232                     ; 1888 TIM1->CCR2H= 0x00;	
9234  1cd2 725f5267      	clr	21095
9235                     ; 1889 TIM1->CCR2L= 0x00;
9237  1cd6 725f5268      	clr	21096
9238                     ; 1890 TIM1->CCR3H= 0x00;	
9240  1cda 725f5269      	clr	21097
9241                     ; 1891 TIM1->CCR3L= 0x64;
9243  1cde 3564526a      	mov	21098,#100
9244                     ; 1893 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9246  1ce2 35685258      	mov	21080,#104
9247                     ; 1894 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9249  1ce6 35685259      	mov	21081,#104
9250                     ; 1895 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
9252  1cea 3568525a      	mov	21082,#104
9253                     ; 1896 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
9255  1cee 3511525c      	mov	21084,#17
9256                     ; 1897 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
9258  1cf2 3501525d      	mov	21085,#1
9259                     ; 1898 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
9261  1cf6 35815250      	mov	21072,#129
9262                     ; 1899 TIM1->BKR|= TIM1_BKR_AOE;
9264  1cfa 721c526d      	bset	21101,#6
9265                     ; 1900 }
9268  1cfe 81            	ret
9293                     ; 1904 void adc2_init(void)
9293                     ; 1905 {
9294                     	switch	.text
9295  1cff               _adc2_init:
9299                     ; 1906 adc_plazma[0]++;
9301  1cff beb5          	ldw	x,_adc_plazma
9302  1d01 1c0001        	addw	x,#1
9303  1d04 bfb5          	ldw	_adc_plazma,x
9304                     ; 1930 GPIOB->DDR&=~(1<<4);
9306  1d06 72195007      	bres	20487,#4
9307                     ; 1931 GPIOB->CR1&=~(1<<4);
9309  1d0a 72195008      	bres	20488,#4
9310                     ; 1932 GPIOB->CR2&=~(1<<4);
9312  1d0e 72195009      	bres	20489,#4
9313                     ; 1934 GPIOB->DDR&=~(1<<5);
9315  1d12 721b5007      	bres	20487,#5
9316                     ; 1935 GPIOB->CR1&=~(1<<5);
9318  1d16 721b5008      	bres	20488,#5
9319                     ; 1936 GPIOB->CR2&=~(1<<5);
9321  1d1a 721b5009      	bres	20489,#5
9322                     ; 1938 GPIOB->DDR&=~(1<<6);
9324  1d1e 721d5007      	bres	20487,#6
9325                     ; 1939 GPIOB->CR1&=~(1<<6);
9327  1d22 721d5008      	bres	20488,#6
9328                     ; 1940 GPIOB->CR2&=~(1<<6);
9330  1d26 721d5009      	bres	20489,#6
9331                     ; 1942 GPIOB->DDR&=~(1<<7);
9333  1d2a 721f5007      	bres	20487,#7
9334                     ; 1943 GPIOB->CR1&=~(1<<7);
9336  1d2e 721f5008      	bres	20488,#7
9337                     ; 1944 GPIOB->CR2&=~(1<<7);
9339  1d32 721f5009      	bres	20489,#7
9340                     ; 1954 ADC2->TDRL=0xff;
9342  1d36 35ff5407      	mov	21511,#255
9343                     ; 1956 ADC2->CR2=0x08;
9345  1d3a 35085402      	mov	21506,#8
9346                     ; 1957 ADC2->CR1=0x40;
9348  1d3e 35405401      	mov	21505,#64
9349                     ; 1960 	ADC2->CSR=0x20+adc_ch+3;
9351  1d42 b6c2          	ld	a,_adc_ch
9352  1d44 ab23          	add	a,#35
9353  1d46 c75400        	ld	21504,a
9354                     ; 1962 	ADC2->CR1|=1;
9356  1d49 72105401      	bset	21505,#0
9357                     ; 1963 	ADC2->CR1|=1;
9359  1d4d 72105401      	bset	21505,#0
9360                     ; 1966 adc_plazma[1]=adc_ch;
9362  1d51 b6c2          	ld	a,_adc_ch
9363  1d53 5f            	clrw	x
9364  1d54 97            	ld	xl,a
9365  1d55 bfb7          	ldw	_adc_plazma+2,x
9366                     ; 1967 }
9369  1d57 81            	ret
9403                     ; 1976 @far @interrupt void TIM4_UPD_Interrupt (void) 
9403                     ; 1977 {
9405                     	switch	.text
9406  1d58               f_TIM4_UPD_Interrupt:
9410                     ; 1978 TIM4->SR1&=~TIM4_SR1_UIF;
9412  1d58 72115342      	bres	21314,#0
9413                     ; 1980 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
9415  1d5c 3c08          	inc	_pwm_vent_cnt
9416  1d5e b608          	ld	a,_pwm_vent_cnt
9417  1d60 a10a          	cp	a,#10
9418  1d62 2502          	jrult	L5404
9421  1d64 3f08          	clr	_pwm_vent_cnt
9422  1d66               L5404:
9423                     ; 1981 GPIOB->ODR|=(1<<3);
9425  1d66 72165005      	bset	20485,#3
9426                     ; 1982 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
9428  1d6a b608          	ld	a,_pwm_vent_cnt
9429  1d6c a105          	cp	a,#5
9430  1d6e 2504          	jrult	L7404
9433  1d70 72175005      	bres	20485,#3
9434  1d74               L7404:
9435                     ; 1987 if(++t0_cnt0>=100)
9437  1d74 9c            	rvf
9438  1d75 be01          	ldw	x,_t0_cnt0
9439  1d77 1c0001        	addw	x,#1
9440  1d7a bf01          	ldw	_t0_cnt0,x
9441  1d7c a30064        	cpw	x,#100
9442  1d7f 2f3f          	jrslt	L1504
9443                     ; 1989 	t0_cnt0=0;
9445  1d81 5f            	clrw	x
9446  1d82 bf01          	ldw	_t0_cnt0,x
9447                     ; 1990 	b100Hz=1;
9449  1d84 72100008      	bset	_b100Hz
9450                     ; 1992 	if(++t0_cnt1>=10)
9452  1d88 3c03          	inc	_t0_cnt1
9453  1d8a b603          	ld	a,_t0_cnt1
9454  1d8c a10a          	cp	a,#10
9455  1d8e 2506          	jrult	L3504
9456                     ; 1994 		t0_cnt1=0;
9458  1d90 3f03          	clr	_t0_cnt1
9459                     ; 1995 		b10Hz=1;
9461  1d92 72100007      	bset	_b10Hz
9462  1d96               L3504:
9463                     ; 1998 	if(++t0_cnt2>=20)
9465  1d96 3c04          	inc	_t0_cnt2
9466  1d98 b604          	ld	a,_t0_cnt2
9467  1d9a a114          	cp	a,#20
9468  1d9c 2506          	jrult	L5504
9469                     ; 2000 		t0_cnt2=0;
9471  1d9e 3f04          	clr	_t0_cnt2
9472                     ; 2001 		b5Hz=1;
9474  1da0 72100006      	bset	_b5Hz
9475  1da4               L5504:
9476                     ; 2005 	if(++t0_cnt4>=50)
9478  1da4 3c06          	inc	_t0_cnt4
9479  1da6 b606          	ld	a,_t0_cnt4
9480  1da8 a132          	cp	a,#50
9481  1daa 2506          	jrult	L7504
9482                     ; 2007 		t0_cnt4=0;
9484  1dac 3f06          	clr	_t0_cnt4
9485                     ; 2008 		b2Hz=1;
9487  1dae 72100005      	bset	_b2Hz
9488  1db2               L7504:
9489                     ; 2011 	if(++t0_cnt3>=100)
9491  1db2 3c05          	inc	_t0_cnt3
9492  1db4 b605          	ld	a,_t0_cnt3
9493  1db6 a164          	cp	a,#100
9494  1db8 2506          	jrult	L1504
9495                     ; 2013 		t0_cnt3=0;
9497  1dba 3f05          	clr	_t0_cnt3
9498                     ; 2014 		b1Hz=1;
9500  1dbc 72100004      	bset	_b1Hz
9501  1dc0               L1504:
9502                     ; 2020 }
9505  1dc0 80            	iret
9530                     ; 2023 @far @interrupt void CAN_RX_Interrupt (void) 
9530                     ; 2024 {
9531                     	switch	.text
9532  1dc1               f_CAN_RX_Interrupt:
9536                     ; 2026 CAN->PSR= 7;									// page 7 - read messsage
9538  1dc1 35075427      	mov	21543,#7
9539                     ; 2028 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
9541  1dc5 ae000e        	ldw	x,#14
9542  1dc8               L652:
9543  1dc8 d65427        	ld	a,(21543,x)
9544  1dcb e7c2          	ld	(_mess-1,x),a
9545  1dcd 5a            	decw	x
9546  1dce 26f8          	jrne	L652
9547                     ; 2039 bCAN_RX=1;
9549  1dd0 3501000a      	mov	_bCAN_RX,#1
9550                     ; 2040 CAN->RFR|=(1<<5);
9552  1dd4 721a5424      	bset	21540,#5
9553                     ; 2042 }
9556  1dd8 80            	iret
9579                     ; 2045 @far @interrupt void CAN_TX_Interrupt (void) 
9579                     ; 2046 {
9580                     	switch	.text
9581  1dd9               f_CAN_TX_Interrupt:
9585                     ; 2047 if((CAN->TSR)&(1<<0))
9587  1dd9 c65422        	ld	a,21538
9588  1ddc a501          	bcp	a,#1
9589  1dde 2708          	jreq	L3014
9590                     ; 2049 	bTX_FREE=1;	
9592  1de0 35010009      	mov	_bTX_FREE,#1
9593                     ; 2051 	CAN->TSR|=(1<<0);
9595  1de4 72105422      	bset	21538,#0
9596  1de8               L3014:
9597                     ; 2053 }
9600  1de8 80            	iret
9658                     ; 2056 @far @interrupt void ADC2_EOC_Interrupt (void) {
9659                     	switch	.text
9660  1de9               f_ADC2_EOC_Interrupt:
9662       00000009      OFST:	set	9
9663  1de9 be00          	ldw	x,c_x
9664  1deb 89            	pushw	x
9665  1dec be00          	ldw	x,c_y
9666  1dee 89            	pushw	x
9667  1def be02          	ldw	x,c_lreg+2
9668  1df1 89            	pushw	x
9669  1df2 be00          	ldw	x,c_lreg
9670  1df4 89            	pushw	x
9671  1df5 5209          	subw	sp,#9
9674                     ; 2061 adc_plazma[2]++;
9676  1df7 beb9          	ldw	x,_adc_plazma+4
9677  1df9 1c0001        	addw	x,#1
9678  1dfc bfb9          	ldw	_adc_plazma+4,x
9679                     ; 2068 ADC2->CSR&=~(1<<7);
9681  1dfe 721f5400      	bres	21504,#7
9682                     ; 2070 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
9684  1e02 c65405        	ld	a,21509
9685  1e05 b703          	ld	c_lreg+3,a
9686  1e07 3f02          	clr	c_lreg+2
9687  1e09 3f01          	clr	c_lreg+1
9688  1e0b 3f00          	clr	c_lreg
9689  1e0d 96            	ldw	x,sp
9690  1e0e 1c0001        	addw	x,#OFST-8
9691  1e11 cd0000        	call	c_rtol
9693  1e14 c65404        	ld	a,21508
9694  1e17 5f            	clrw	x
9695  1e18 97            	ld	xl,a
9696  1e19 90ae0100      	ldw	y,#256
9697  1e1d cd0000        	call	c_umul
9699  1e20 96            	ldw	x,sp
9700  1e21 1c0001        	addw	x,#OFST-8
9701  1e24 cd0000        	call	c_ladd
9703  1e27 96            	ldw	x,sp
9704  1e28 1c0006        	addw	x,#OFST-3
9705  1e2b cd0000        	call	c_rtol
9707                     ; 2075 if(adr_drv_stat==1)
9709  1e2e b608          	ld	a,_adr_drv_stat
9710  1e30 a101          	cp	a,#1
9711  1e32 260b          	jrne	L3314
9712                     ; 2077 	adr_drv_stat=2;
9714  1e34 35020008      	mov	_adr_drv_stat,#2
9715                     ; 2078 	adc_buff_[0]=temp_adc;
9717  1e38 1e08          	ldw	x,(OFST-1,sp)
9718  1e3a cf0009        	ldw	_adc_buff_,x
9720  1e3d 2020          	jra	L5314
9721  1e3f               L3314:
9722                     ; 2081 else if(adr_drv_stat==3)
9724  1e3f b608          	ld	a,_adr_drv_stat
9725  1e41 a103          	cp	a,#3
9726  1e43 260b          	jrne	L7314
9727                     ; 2083 	adr_drv_stat=4;
9729  1e45 35040008      	mov	_adr_drv_stat,#4
9730                     ; 2084 	adc_buff_[1]=temp_adc;
9732  1e49 1e08          	ldw	x,(OFST-1,sp)
9733  1e4b cf000b        	ldw	_adc_buff_+2,x
9735  1e4e 200f          	jra	L5314
9736  1e50               L7314:
9737                     ; 2087 else if(adr_drv_stat==5)
9739  1e50 b608          	ld	a,_adr_drv_stat
9740  1e52 a105          	cp	a,#5
9741  1e54 2609          	jrne	L5314
9742                     ; 2089 	adr_drv_stat=6;
9744  1e56 35060008      	mov	_adr_drv_stat,#6
9745                     ; 2090 	adc_buff_[9]=temp_adc;
9747  1e5a 1e08          	ldw	x,(OFST-1,sp)
9748  1e5c cf001b        	ldw	_adc_buff_+18,x
9749  1e5f               L5314:
9750                     ; 2093 adc_buff[adc_ch][adc_cnt]=temp_adc;
9752  1e5f b6c1          	ld	a,_adc_cnt
9753  1e61 5f            	clrw	x
9754  1e62 97            	ld	xl,a
9755  1e63 58            	sllw	x
9756  1e64 1f03          	ldw	(OFST-6,sp),x
9757  1e66 b6c2          	ld	a,_adc_ch
9758  1e68 97            	ld	xl,a
9759  1e69 a620          	ld	a,#32
9760  1e6b 42            	mul	x,a
9761  1e6c 72fb03        	addw	x,(OFST-6,sp)
9762  1e6f 1608          	ldw	y,(OFST-1,sp)
9763  1e71 df001d        	ldw	(_adc_buff,x),y
9764                     ; 2099 adc_ch++;
9766  1e74 3cc2          	inc	_adc_ch
9767                     ; 2100 if(adc_ch>=5)
9769  1e76 b6c2          	ld	a,_adc_ch
9770  1e78 a105          	cp	a,#5
9771  1e7a 250c          	jrult	L5414
9772                     ; 2103 	adc_ch=0;
9774  1e7c 3fc2          	clr	_adc_ch
9775                     ; 2104 	adc_cnt++;
9777  1e7e 3cc1          	inc	_adc_cnt
9778                     ; 2105 	if(adc_cnt>=16)
9780  1e80 b6c1          	ld	a,_adc_cnt
9781  1e82 a110          	cp	a,#16
9782  1e84 2502          	jrult	L5414
9783                     ; 2107 		adc_cnt=0;
9785  1e86 3fc1          	clr	_adc_cnt
9786  1e88               L5414:
9787                     ; 2111 if((adc_cnt&0x03)==0)
9789  1e88 b6c1          	ld	a,_adc_cnt
9790  1e8a a503          	bcp	a,#3
9791  1e8c 264b          	jrne	L1514
9792                     ; 2115 	tempSS=0;
9794  1e8e ae0000        	ldw	x,#0
9795  1e91 1f08          	ldw	(OFST-1,sp),x
9796  1e93 ae0000        	ldw	x,#0
9797  1e96 1f06          	ldw	(OFST-3,sp),x
9798                     ; 2116 	for(i=0;i<16;i++)
9800  1e98 0f05          	clr	(OFST-4,sp)
9801  1e9a               L3514:
9802                     ; 2118 		tempSS+=(signed long)adc_buff[adc_ch][i];
9804  1e9a 7b05          	ld	a,(OFST-4,sp)
9805  1e9c 5f            	clrw	x
9806  1e9d 97            	ld	xl,a
9807  1e9e 58            	sllw	x
9808  1e9f 1f03          	ldw	(OFST-6,sp),x
9809  1ea1 b6c2          	ld	a,_adc_ch
9810  1ea3 97            	ld	xl,a
9811  1ea4 a620          	ld	a,#32
9812  1ea6 42            	mul	x,a
9813  1ea7 72fb03        	addw	x,(OFST-6,sp)
9814  1eaa de001d        	ldw	x,(_adc_buff,x)
9815  1ead cd0000        	call	c_itolx
9817  1eb0 96            	ldw	x,sp
9818  1eb1 1c0006        	addw	x,#OFST-3
9819  1eb4 cd0000        	call	c_lgadd
9821                     ; 2116 	for(i=0;i<16;i++)
9823  1eb7 0c05          	inc	(OFST-4,sp)
9826  1eb9 7b05          	ld	a,(OFST-4,sp)
9827  1ebb a110          	cp	a,#16
9828  1ebd 25db          	jrult	L3514
9829                     ; 2120 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
9831  1ebf 96            	ldw	x,sp
9832  1ec0 1c0006        	addw	x,#OFST-3
9833  1ec3 cd0000        	call	c_ltor
9835  1ec6 a604          	ld	a,#4
9836  1ec8 cd0000        	call	c_lrsh
9838  1ecb be02          	ldw	x,c_lreg+2
9839  1ecd b6c2          	ld	a,_adc_ch
9840  1ecf 905f          	clrw	y
9841  1ed1 9097          	ld	yl,a
9842  1ed3 9058          	sllw	y
9843  1ed5 90df0009      	ldw	(_adc_buff_,y),x
9844  1ed9               L1514:
9845                     ; 2131 adc_plazma_short++;
9847  1ed9 bebf          	ldw	x,_adc_plazma_short
9848  1edb 1c0001        	addw	x,#1
9849  1ede bfbf          	ldw	_adc_plazma_short,x
9850                     ; 2146 }
9853  1ee0 5b09          	addw	sp,#9
9854  1ee2 85            	popw	x
9855  1ee3 bf00          	ldw	c_lreg,x
9856  1ee5 85            	popw	x
9857  1ee6 bf02          	ldw	c_lreg+2,x
9858  1ee8 85            	popw	x
9859  1ee9 bf00          	ldw	c_y,x
9860  1eeb 85            	popw	x
9861  1eec bf00          	ldw	c_x,x
9862  1eee 80            	iret
9926                     ; 2154 main()
9926                     ; 2155 {
9928                     	switch	.text
9929  1eef               _main:
9933                     ; 2157 CLK->ECKR|=1;
9935  1eef 721050c1      	bset	20673,#0
9937  1ef3               L3714:
9938                     ; 2158 while((CLK->ECKR & 2) == 0);
9940  1ef3 c650c1        	ld	a,20673
9941  1ef6 a502          	bcp	a,#2
9942  1ef8 27f9          	jreq	L3714
9943                     ; 2159 CLK->SWCR|=2;
9945  1efa 721250c5      	bset	20677,#1
9946                     ; 2160 CLK->SWR=0xB4;
9948  1efe 35b450c4      	mov	20676,#180
9949                     ; 2162 delay_ms(200);
9951  1f02 ae00c8        	ldw	x,#200
9952  1f05 cd010e        	call	_delay_ms
9954                     ; 2163 FLASH_DUKR=0xae;
9956  1f08 35ae5064      	mov	_FLASH_DUKR,#174
9957                     ; 2164 FLASH_DUKR=0x56;
9959  1f0c 35565064      	mov	_FLASH_DUKR,#86
9960                     ; 2165 enableInterrupts();
9963  1f10 9a            rim
9965                     ; 2168 adr_drv_v3();
9968  1f11 cd10f8        	call	_adr_drv_v3
9970                     ; 2172 t4_init();
9972  1f14 cd1cb1        	call	_t4_init
9974                     ; 2174 		GPIOG->DDR|=(1<<0);
9976  1f17 72105020      	bset	20512,#0
9977                     ; 2175 		GPIOG->CR1|=(1<<0);
9979  1f1b 72105021      	bset	20513,#0
9980                     ; 2176 		GPIOG->CR2&=~(1<<0);	
9982  1f1f 72115022      	bres	20514,#0
9983                     ; 2179 		GPIOG->DDR&=~(1<<1);
9985  1f23 72135020      	bres	20512,#1
9986                     ; 2180 		GPIOG->CR1|=(1<<1);
9988  1f27 72125021      	bset	20513,#1
9989                     ; 2181 		GPIOG->CR2&=~(1<<1);
9991  1f2b 72135022      	bres	20514,#1
9992                     ; 2183 init_CAN();
9994  1f2f cd143b        	call	_init_CAN
9996                     ; 2188 GPIOC->DDR|=(1<<1);
9998  1f32 7212500c      	bset	20492,#1
9999                     ; 2189 GPIOC->CR1|=(1<<1);
10001  1f36 7212500d      	bset	20493,#1
10002                     ; 2190 GPIOC->CR2|=(1<<1);
10004  1f3a 7212500e      	bset	20494,#1
10005                     ; 2192 GPIOC->DDR|=(1<<2);
10007  1f3e 7214500c      	bset	20492,#2
10008                     ; 2193 GPIOC->CR1|=(1<<2);
10010  1f42 7214500d      	bset	20493,#2
10011                     ; 2194 GPIOC->CR2|=(1<<2);
10013  1f46 7214500e      	bset	20494,#2
10014                     ; 2201 t1_init();
10016  1f4a cd1cc2        	call	_t1_init
10018                     ; 2203 GPIOA->DDR|=(1<<5);
10020  1f4d 721a5002      	bset	20482,#5
10021                     ; 2204 GPIOA->CR1|=(1<<5);
10023  1f51 721a5003      	bset	20483,#5
10024                     ; 2205 GPIOA->CR2&=~(1<<5);
10026  1f55 721b5004      	bres	20484,#5
10027                     ; 2211 GPIOB->DDR&=~(1<<3);
10029  1f59 72175007      	bres	20487,#3
10030                     ; 2212 GPIOB->CR1&=~(1<<3);
10032  1f5d 72175008      	bres	20488,#3
10033                     ; 2213 GPIOB->CR2&=~(1<<3);
10035  1f61 72175009      	bres	20489,#3
10036                     ; 2215 GPIOC->DDR|=(1<<3);
10038  1f65 7216500c      	bset	20492,#3
10039                     ; 2216 GPIOC->CR1|=(1<<3);
10041  1f69 7216500d      	bset	20493,#3
10042                     ; 2217 GPIOC->CR2|=(1<<3);
10044  1f6d 7216500e      	bset	20494,#3
10045                     ; 2220 if(bps_class==bpsIPS) 
10047  1f71 b604          	ld	a,_bps_class
10048  1f73 a101          	cp	a,#1
10049  1f75 260a          	jrne	L1024
10050                     ; 2222 	pwm_u=ee_U_AVT;
10052  1f77 ce000c        	ldw	x,_ee_U_AVT
10053  1f7a bf0c          	ldw	_pwm_u,x
10054                     ; 2223 	volum_u_main_=ee_U_AVT;
10056  1f7c ce000c        	ldw	x,_ee_U_AVT
10057  1f7f bf1d          	ldw	_volum_u_main_,x
10058  1f81               L1024:
10059                     ; 2230 	if(bCAN_RX)
10061  1f81 3d0a          	tnz	_bCAN_RX
10062  1f83 2705          	jreq	L5024
10063                     ; 2232 		bCAN_RX=0;
10065  1f85 3f0a          	clr	_bCAN_RX
10066                     ; 2233 		can_in_an();	
10068  1f87 cd1646        	call	_can_in_an
10070  1f8a               L5024:
10071                     ; 2235 	if(b100Hz)
10073                     	btst	_b100Hz
10074  1f8f 240a          	jruge	L7024
10075                     ; 2237 		b100Hz=0;
10077  1f91 72110008      	bres	_b100Hz
10078                     ; 2246 		adc2_init();
10080  1f95 cd1cff        	call	_adc2_init
10082                     ; 2247 		can_tx_hndl();
10084  1f98 cd152e        	call	_can_tx_hndl
10086  1f9b               L7024:
10087                     ; 2250 	if(b10Hz)
10089                     	btst	_b10Hz
10090  1fa0 2419          	jruge	L1124
10091                     ; 2252 		b10Hz=0;
10093  1fa2 72110007      	bres	_b10Hz
10094                     ; 2254           matemat();
10096  1fa6 cd0caf        	call	_matemat
10098                     ; 2255 	    	led_drv(); 
10100  1fa9 cd07d3        	call	_led_drv
10102                     ; 2256 	     link_drv();
10104  1fac cd08c1        	call	_link_drv
10106                     ; 2257 	     pwr_hndl();		//вычисление воздействий на силу
10108  1faf cd0b93        	call	_pwr_hndl
10110                     ; 2258 	     JP_drv();
10112  1fb2 cd0836        	call	_JP_drv
10114                     ; 2259 	     flags_drv();
10116  1fb5 cd10ad        	call	_flags_drv
10118                     ; 2260 		net_drv();
10120  1fb8 cd1598        	call	_net_drv
10122  1fbb               L1124:
10123                     ; 2263 	if(b5Hz)
10125                     	btst	_b5Hz
10126  1fc0 240d          	jruge	L3124
10127                     ; 2265 		b5Hz=0;
10129  1fc2 72110006      	bres	_b5Hz
10130                     ; 2267 		pwr_drv();		//воздействие на силу
10132  1fc6 cd0a73        	call	_pwr_drv
10134                     ; 2268 		led_hndl();
10136  1fc9 cd0150        	call	_led_hndl
10138                     ; 2270 		vent_drv();
10140  1fcc cd0910        	call	_vent_drv
10142  1fcf               L3124:
10143                     ; 2273 	if(b2Hz)
10145                     	btst	_b2Hz
10146  1fd4 2404          	jruge	L5124
10147                     ; 2275 		b2Hz=0;
10149  1fd6 72110005      	bres	_b2Hz
10150  1fda               L5124:
10151                     ; 2284 	if(b1Hz)
10153                     	btst	_b1Hz
10154  1fdf 24a0          	jruge	L1024
10155                     ; 2286 		b1Hz=0;
10157  1fe1 72110004      	bres	_b1Hz
10158                     ; 2288 		temper_drv();			//вычисление аварий температуры
10160  1fe5 cd0ddd        	call	_temper_drv
10162                     ; 2289 		u_drv();
10164  1fe8 cd0eb4        	call	_u_drv
10166                     ; 2290           x_drv();
10168  1feb cd0f94        	call	_x_drv
10170                     ; 2291           if(main_cnt<1000)main_cnt++;
10172  1fee 9c            	rvf
10173  1fef be51          	ldw	x,_main_cnt
10174  1ff1 a303e8        	cpw	x,#1000
10175  1ff4 2e07          	jrsge	L1224
10178  1ff6 be51          	ldw	x,_main_cnt
10179  1ff8 1c0001        	addw	x,#1
10180  1ffb bf51          	ldw	_main_cnt,x
10181  1ffd               L1224:
10182                     ; 2292   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
10184  1ffd b662          	ld	a,_link
10185  1fff a1aa          	cp	a,#170
10186  2001 2706          	jreq	L5224
10188  2003 b64a          	ld	a,_jp_mode
10189  2005 a103          	cp	a,#3
10190  2007 2603          	jrne	L3224
10191  2009               L5224:
10194  2009 cd100e        	call	_apv_hndl
10196  200c               L3224:
10197                     ; 2295   		can_error_cnt++;
10199  200c 3c70          	inc	_can_error_cnt
10200                     ; 2296   		if(can_error_cnt>=10)
10202  200e b670          	ld	a,_can_error_cnt
10203  2010 a10a          	cp	a,#10
10204  2012 2505          	jrult	L7224
10205                     ; 2298   			can_error_cnt=0;
10207  2014 3f70          	clr	_can_error_cnt
10208                     ; 2299 			init_CAN();
10210  2016 cd143b        	call	_init_CAN
10212  2019               L7224:
10213                     ; 2303 		volum_u_main_drv();
10215  2019 cd12e8        	call	_volum_u_main_drv
10217                     ; 2305 		pwm_stat++;
10219  201c 3c07          	inc	_pwm_stat
10220                     ; 2306 		if(pwm_stat>=10)pwm_stat=0;
10222  201e b607          	ld	a,_pwm_stat
10223  2020 a10a          	cp	a,#10
10224  2022 2502          	jrult	L1324
10227  2024 3f07          	clr	_pwm_stat
10228  2026               L1324:
10229                     ; 2307 adc_plazma_short++;
10231  2026 bebf          	ldw	x,_adc_plazma_short
10232  2028 1c0001        	addw	x,#1
10233  202b bfbf          	ldw	_adc_plazma_short,x
10234                     ; 2309 		vent_resurs_hndl();
10236  202d cd0000        	call	_vent_resurs_hndl
10238  2030 ac811f81      	jpf	L1024
11299                     	xdef	_main
11300                     	xdef	f_ADC2_EOC_Interrupt
11301                     	xdef	f_CAN_TX_Interrupt
11302                     	xdef	f_CAN_RX_Interrupt
11303                     	xdef	f_TIM4_UPD_Interrupt
11304                     	xdef	_adc2_init
11305                     	xdef	_t1_init
11306                     	xdef	_t4_init
11307                     	xdef	_can_in_an
11308                     	xdef	_net_drv
11309                     	xdef	_can_tx_hndl
11310                     	xdef	_can_transmit
11311                     	xdef	_init_CAN
11312                     	xdef	_volum_u_main_drv
11313                     	xdef	_adr_drv_v3
11314                     	xdef	_adr_drv_v4
11315                     	xdef	_flags_drv
11316                     	xdef	_apv_hndl
11317                     	xdef	_apv_stop
11318                     	xdef	_apv_start
11319                     	xdef	_x_drv
11320                     	xdef	_u_drv
11321                     	xdef	_temper_drv
11322                     	xdef	_matemat
11323                     	xdef	_pwr_hndl
11324                     	xdef	_pwr_drv
11325                     	xdef	_vent_drv
11326                     	xdef	_link_drv
11327                     	xdef	_JP_drv
11328                     	xdef	_led_drv
11329                     	xdef	_led_hndl
11330                     	xdef	_delay_ms
11331                     	xdef	_granee
11332                     	xdef	_gran
11333                     	xdef	_vent_resurs_hndl
11334                     	switch	.ubsct
11335  0001               _vent_resurs_tx_cnt:
11336  0001 00            	ds.b	1
11337                     	xdef	_vent_resurs_tx_cnt
11338                     	switch	.bss
11339  0000               _vent_resurs_buff:
11340  0000 00000000      	ds.b	4
11341                     	xdef	_vent_resurs_buff
11342                     	switch	.ubsct
11343  0002               _vent_resurs_sec_cnt:
11344  0002 0000          	ds.b	2
11345                     	xdef	_vent_resurs_sec_cnt
11346                     .eeprom:	section	.data
11347  0000               _vent_resurs:
11348  0000 0000          	ds.b	2
11349                     	xdef	_vent_resurs
11350  0002               _ee_IMAXVENT:
11351  0002 0000          	ds.b	2
11352                     	xdef	_ee_IMAXVENT
11353                     	switch	.ubsct
11354  0004               _bps_class:
11355  0004 00            	ds.b	1
11356                     	xdef	_bps_class
11357  0005               _vent_pwm:
11358  0005 0000          	ds.b	2
11359                     	xdef	_vent_pwm
11360  0007               _pwm_stat:
11361  0007 00            	ds.b	1
11362                     	xdef	_pwm_stat
11363  0008               _pwm_vent_cnt:
11364  0008 00            	ds.b	1
11365                     	xdef	_pwm_vent_cnt
11366                     	switch	.eeprom
11367  0004               _ee_DEVICE:
11368  0004 0000          	ds.b	2
11369                     	xdef	_ee_DEVICE
11370  0006               _ee_AVT_MODE:
11371  0006 0000          	ds.b	2
11372                     	xdef	_ee_AVT_MODE
11373                     	switch	.ubsct
11374  0009               _i_main_bps_cnt:
11375  0009 000000000000  	ds.b	6
11376                     	xdef	_i_main_bps_cnt
11377  000f               _i_main_sigma:
11378  000f 0000          	ds.b	2
11379                     	xdef	_i_main_sigma
11380  0011               _i_main_num_of_bps:
11381  0011 00            	ds.b	1
11382                     	xdef	_i_main_num_of_bps
11383  0012               _i_main_avg:
11384  0012 0000          	ds.b	2
11385                     	xdef	_i_main_avg
11386  0014               _i_main_flag:
11387  0014 000000000000  	ds.b	6
11388                     	xdef	_i_main_flag
11389  001a               _i_main:
11390  001a 000000000000  	ds.b	12
11391                     	xdef	_i_main
11392  0026               _x:
11393  0026 000000000000  	ds.b	12
11394                     	xdef	_x
11395                     	xdef	_volum_u_main_
11396                     	switch	.eeprom
11397  0008               _UU_AVT:
11398  0008 0000          	ds.b	2
11399                     	xdef	_UU_AVT
11400                     	switch	.ubsct
11401  0032               _cnt_net_drv:
11402  0032 00            	ds.b	1
11403                     	xdef	_cnt_net_drv
11404                     	switch	.bit
11405  0001               _bMAIN:
11406  0001 00            	ds.b	1
11407                     	xdef	_bMAIN
11408                     	switch	.ubsct
11409  0033               _plazma_int:
11410  0033 000000000000  	ds.b	6
11411                     	xdef	_plazma_int
11412                     	xdef	_rotor_int
11413  0039               _led_green_buff:
11414  0039 00000000      	ds.b	4
11415                     	xdef	_led_green_buff
11416  003d               _led_red_buff:
11417  003d 00000000      	ds.b	4
11418                     	xdef	_led_red_buff
11419                     	xdef	_led_drv_cnt
11420                     	xdef	_led_green
11421                     	xdef	_led_red
11422  0041               _res_fl_cnt:
11423  0041 00            	ds.b	1
11424                     	xdef	_res_fl_cnt
11425                     	xdef	_bRES_
11426                     	xdef	_bRES
11427                     	switch	.eeprom
11428  000a               _res_fl_:
11429  000a 00            	ds.b	1
11430                     	xdef	_res_fl_
11431  000b               _res_fl:
11432  000b 00            	ds.b	1
11433                     	xdef	_res_fl
11434                     	switch	.ubsct
11435  0042               _cnt_apv_off:
11436  0042 00            	ds.b	1
11437                     	xdef	_cnt_apv_off
11438                     	switch	.bit
11439  0002               _bAPV:
11440  0002 00            	ds.b	1
11441                     	xdef	_bAPV
11442                     	switch	.ubsct
11443  0043               _apv_cnt_:
11444  0043 0000          	ds.b	2
11445                     	xdef	_apv_cnt_
11446  0045               _apv_cnt:
11447  0045 000000        	ds.b	3
11448                     	xdef	_apv_cnt
11449                     	xdef	_bBL_IPS
11450                     	switch	.bit
11451  0003               _bBL:
11452  0003 00            	ds.b	1
11453                     	xdef	_bBL
11454                     	switch	.ubsct
11455  0048               _cnt_JP1:
11456  0048 00            	ds.b	1
11457                     	xdef	_cnt_JP1
11458  0049               _cnt_JP0:
11459  0049 00            	ds.b	1
11460                     	xdef	_cnt_JP0
11461  004a               _jp_mode:
11462  004a 00            	ds.b	1
11463                     	xdef	_jp_mode
11464                     	xdef	_pwm_i
11465                     	xdef	_pwm_u
11466  004b               _tmax_cnt:
11467  004b 0000          	ds.b	2
11468                     	xdef	_tmax_cnt
11469  004d               _tsign_cnt:
11470  004d 0000          	ds.b	2
11471                     	xdef	_tsign_cnt
11472                     	switch	.eeprom
11473  000c               _ee_U_AVT:
11474  000c 0000          	ds.b	2
11475                     	xdef	_ee_U_AVT
11476  000e               _ee_tsign:
11477  000e 0000          	ds.b	2
11478                     	xdef	_ee_tsign
11479  0010               _ee_tmax:
11480  0010 0000          	ds.b	2
11481                     	xdef	_ee_tmax
11482  0012               _ee_dU:
11483  0012 0000          	ds.b	2
11484                     	xdef	_ee_dU
11485  0014               _ee_Umax:
11486  0014 0000          	ds.b	2
11487                     	xdef	_ee_Umax
11488  0016               _ee_TZAS:
11489  0016 0000          	ds.b	2
11490                     	xdef	_ee_TZAS
11491                     	switch	.ubsct
11492  004f               _main_cnt1:
11493  004f 0000          	ds.b	2
11494                     	xdef	_main_cnt1
11495  0051               _main_cnt:
11496  0051 0000          	ds.b	2
11497                     	xdef	_main_cnt
11498  0053               _off_bp_cnt:
11499  0053 00            	ds.b	1
11500                     	xdef	_off_bp_cnt
11501  0054               _flags_tu_cnt_off:
11502  0054 00            	ds.b	1
11503                     	xdef	_flags_tu_cnt_off
11504  0055               _flags_tu_cnt_on:
11505  0055 00            	ds.b	1
11506                     	xdef	_flags_tu_cnt_on
11507  0056               _vol_i_temp:
11508  0056 0000          	ds.b	2
11509                     	xdef	_vol_i_temp
11510  0058               _vol_u_temp:
11511  0058 0000          	ds.b	2
11512                     	xdef	_vol_u_temp
11513                     	switch	.eeprom
11514  0018               __x_ee_:
11515  0018 0000          	ds.b	2
11516                     	xdef	__x_ee_
11517                     	switch	.ubsct
11518  005a               __x_cnt:
11519  005a 0000          	ds.b	2
11520                     	xdef	__x_cnt
11521  005c               __x__:
11522  005c 0000          	ds.b	2
11523                     	xdef	__x__
11524  005e               __x_:
11525  005e 0000          	ds.b	2
11526                     	xdef	__x_
11527  0060               _flags_tu:
11528  0060 00            	ds.b	1
11529                     	xdef	_flags_tu
11530                     	xdef	_flags
11531  0061               _link_cnt:
11532  0061 00            	ds.b	1
11533                     	xdef	_link_cnt
11534  0062               _link:
11535  0062 00            	ds.b	1
11536                     	xdef	_link
11537  0063               _umin_cnt:
11538  0063 0000          	ds.b	2
11539                     	xdef	_umin_cnt
11540  0065               _umax_cnt:
11541  0065 0000          	ds.b	2
11542                     	xdef	_umax_cnt
11543                     	switch	.eeprom
11544  001a               _ee_K:
11545  001a 000000000000  	ds.b	16
11546                     	xdef	_ee_K
11547                     	switch	.ubsct
11548  0067               _T:
11549  0067 00            	ds.b	1
11550                     	xdef	_T
11551  0068               _Udb:
11552  0068 0000          	ds.b	2
11553                     	xdef	_Udb
11554  006a               _Ui:
11555  006a 0000          	ds.b	2
11556                     	xdef	_Ui
11557  006c               _Un:
11558  006c 0000          	ds.b	2
11559                     	xdef	_Un
11560  006e               _I:
11561  006e 0000          	ds.b	2
11562                     	xdef	_I
11563  0070               _can_error_cnt:
11564  0070 00            	ds.b	1
11565                     	xdef	_can_error_cnt
11566                     	xdef	_bCAN_RX
11567  0071               _tx_busy_cnt:
11568  0071 00            	ds.b	1
11569                     	xdef	_tx_busy_cnt
11570                     	xdef	_bTX_FREE
11571  0072               _can_buff_rd_ptr:
11572  0072 00            	ds.b	1
11573                     	xdef	_can_buff_rd_ptr
11574  0073               _can_buff_wr_ptr:
11575  0073 00            	ds.b	1
11576                     	xdef	_can_buff_wr_ptr
11577  0074               _can_out_buff:
11578  0074 000000000000  	ds.b	64
11579                     	xdef	_can_out_buff
11580                     	switch	.bss
11581  0004               _adress_error:
11582  0004 00            	ds.b	1
11583                     	xdef	_adress_error
11584  0005               _adress:
11585  0005 00            	ds.b	1
11586                     	xdef	_adress
11587  0006               _adr:
11588  0006 000000        	ds.b	3
11589                     	xdef	_adr
11590                     	xdef	_adr_drv_stat
11591                     	xdef	_led_ind
11592                     	switch	.ubsct
11593  00b4               _led_ind_cnt:
11594  00b4 00            	ds.b	1
11595                     	xdef	_led_ind_cnt
11596  00b5               _adc_plazma:
11597  00b5 000000000000  	ds.b	10
11598                     	xdef	_adc_plazma
11599  00bf               _adc_plazma_short:
11600  00bf 0000          	ds.b	2
11601                     	xdef	_adc_plazma_short
11602  00c1               _adc_cnt:
11603  00c1 00            	ds.b	1
11604                     	xdef	_adc_cnt
11605  00c2               _adc_ch:
11606  00c2 00            	ds.b	1
11607                     	xdef	_adc_ch
11608                     	switch	.bss
11609  0009               _adc_buff_:
11610  0009 000000000000  	ds.b	20
11611                     	xdef	_adc_buff_
11612  001d               _adc_buff:
11613  001d 000000000000  	ds.b	320
11614                     	xdef	_adc_buff
11615                     	switch	.ubsct
11616  00c3               _mess:
11617  00c3 000000000000  	ds.b	14
11618                     	xdef	_mess
11619                     	switch	.bit
11620  0004               _b1Hz:
11621  0004 00            	ds.b	1
11622                     	xdef	_b1Hz
11623  0005               _b2Hz:
11624  0005 00            	ds.b	1
11625                     	xdef	_b2Hz
11626  0006               _b5Hz:
11627  0006 00            	ds.b	1
11628                     	xdef	_b5Hz
11629  0007               _b10Hz:
11630  0007 00            	ds.b	1
11631                     	xdef	_b10Hz
11632  0008               _b100Hz:
11633  0008 00            	ds.b	1
11634                     	xdef	_b100Hz
11635                     	xdef	_t0_cnt4
11636                     	xdef	_t0_cnt3
11637                     	xdef	_t0_cnt2
11638                     	xdef	_t0_cnt1
11639                     	xdef	_t0_cnt0
11640                     	xdef	_bVENT_BLOCK
11641                     	xref.b	c_lreg
11642                     	xref.b	c_x
11643                     	xref.b	c_y
11663                     	xref	c_lrsh
11664                     	xref	c_lgadd
11665                     	xref	c_ladd
11666                     	xref	c_umul
11667                     	xref	c_lgmul
11668                     	xref	c_lgsub
11669                     	xref	c_lsbc
11670                     	xref	c_idiv
11671                     	xref	c_ldiv
11672                     	xref	c_itolx
11673                     	xref	c_eewrc
11674                     	xref	c_imul
11675                     	xref	c_lcmp
11676                     	xref	c_ltor
11677                     	xref	c_lgadc
11678                     	xref	c_rtol
11679                     	xref	c_vmul
11680                     	xref	c_eewrw
11681                     	end
