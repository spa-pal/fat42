   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _bVENT_BLOCK:
  17  0000 00            	dc.b	0
2175                     	switch	.data
2176  0000               _t0_cnt00:
2177  0000 0000          	dc.w	0
2178  0002               _t0_cnt0:
2179  0002 0000          	dc.w	0
2180  0004               _t0_cnt1:
2181  0004 00            	dc.b	0
2182  0005               _t0_cnt2:
2183  0005 00            	dc.b	0
2184  0006               _t0_cnt3:
2185  0006 00            	dc.b	0
2186  0007               _t0_cnt4:
2187  0007 00            	dc.b	0
2188                     	bsct
2189  0001               _led_ind:
2190  0001 05            	dc.b	5
2191  0002               _adr_drv_stat:
2192  0002 00            	dc.b	0
2193  0003               _bTX_FREE:
2194  0003 01            	dc.b	1
2195  0004               _bCAN_RX:
2196  0004 00            	dc.b	0
2197  0005               _flags:
2198  0005 00            	dc.b	0
2199  0006               _vol_i_temp_avar:
2200  0006 0000          	dc.w	0
2201  0008               _pwm_u:
2202  0008 00c8          	dc.w	200
2203  000a               _pwm_i:
2204  000a 0032          	dc.w	50
2205                     .bit:	section	.data,bit
2206  0000               _bBL_IPS:
2207  0000 00            	dc.b	0
2208                     	bsct
2209  000c               _bRES:
2210  000c 00            	dc.b	0
2211  000d               _bRES_:
2212  000d 00            	dc.b	0
2213  000e               _led_red:
2214  000e 00000000      	dc.l	0
2215  0012               _led_green:
2216  0012 03030303      	dc.l	50529027
2217  0016               _led_drv_cnt:
2218  0016 1e            	dc.b	30
2219  0017               _rotor_int:
2220  0017 007b          	dc.w	123
2221  0019               _volum_u_main_:
2222  0019 02bc          	dc.w	700
2267                     .const:	section	.text
2268  0000               L6:
2269  0000 0000ea60      	dc.l	60000
2270                     ; 187 void vent_resurs_hndl(void)
2270                     ; 188 {
2271                     	scross	off
2272                     	switch	.text
2273  0000               _vent_resurs_hndl:
2275  0000 88            	push	a
2276       00000001      OFST:	set	1
2279                     ; 190 if(vent_pwm>100)vent_resurs_sec_cnt++;
2281  0001 9c            	rvf
2282  0002 be0c          	ldw	x,_vent_pwm
2283  0004 a30065        	cpw	x,#101
2284  0007 2f07          	jrslt	L7441
2287  0009 be09          	ldw	x,_vent_resurs_sec_cnt
2288  000b 1c0001        	addw	x,#1
2289  000e bf09          	ldw	_vent_resurs_sec_cnt,x
2290  0010               L7441:
2291                     ; 191 if(vent_resurs_sec_cnt>VENT_RESURS_SEC_IN_HOUR)
2293  0010 be09          	ldw	x,_vent_resurs_sec_cnt
2294  0012 a30e11        	cpw	x,#3601
2295  0015 251b          	jrult	L1541
2296                     ; 193 	if(vent_resurs<60000)vent_resurs++;
2298  0017 9c            	rvf
2299  0018 ce0000        	ldw	x,_vent_resurs
2300  001b cd0000        	call	c_uitolx
2302  001e ae0000        	ldw	x,#L6
2303  0021 cd0000        	call	c_lcmp
2305  0024 2e09          	jrsge	L3541
2308  0026 ce0000        	ldw	x,_vent_resurs
2309  0029 1c0001        	addw	x,#1
2310  002c cf0000        	ldw	_vent_resurs,x
2311  002f               L3541:
2312                     ; 194 	vent_resurs_sec_cnt=0;
2314  002f 5f            	clrw	x
2315  0030 bf09          	ldw	_vent_resurs_sec_cnt,x
2316  0032               L1541:
2317                     ; 199 vent_resurs_buff[0]=0x00|((unsigned char)(vent_resurs&0x000f));
2319  0032 c60001        	ld	a,_vent_resurs+1
2320  0035 a40f          	and	a,#15
2321  0037 c70000        	ld	_vent_resurs_buff,a
2322                     ; 200 vent_resurs_buff[1]=0x40|((unsigned char)((vent_resurs&0x00f0)>>4));
2324  003a c60001        	ld	a,_vent_resurs+1
2325  003d a4f0          	and	a,#240
2326  003f 4e            	swap	a
2327  0040 a40f          	and	a,#15
2328  0042 aa40          	or	a,#64
2329  0044 c70001        	ld	_vent_resurs_buff+1,a
2330                     ; 201 vent_resurs_buff[2]=0x80|((unsigned char)((vent_resurs&0x0f00)>>8));
2332  0047 c60000        	ld	a,_vent_resurs
2333  004a 97            	ld	xl,a
2334  004b c60001        	ld	a,_vent_resurs+1
2335  004e 9f            	ld	a,xl
2336  004f a40f          	and	a,#15
2337  0051 97            	ld	xl,a
2338  0052 4f            	clr	a
2339  0053 02            	rlwa	x,a
2340  0054 4f            	clr	a
2341  0055 01            	rrwa	x,a
2342  0056 9f            	ld	a,xl
2343  0057 aa80          	or	a,#128
2344  0059 c70002        	ld	_vent_resurs_buff+2,a
2345                     ; 202 vent_resurs_buff[3]=0xc0|((unsigned char)((vent_resurs&0xf000)>>12));
2347  005c c60000        	ld	a,_vent_resurs
2348  005f 97            	ld	xl,a
2349  0060 c60001        	ld	a,_vent_resurs+1
2350  0063 9f            	ld	a,xl
2351  0064 a4f0          	and	a,#240
2352  0066 97            	ld	xl,a
2353  0067 4f            	clr	a
2354  0068 02            	rlwa	x,a
2355  0069 01            	rrwa	x,a
2356  006a 4f            	clr	a
2357  006b 41            	exg	a,xl
2358  006c 4e            	swap	a
2359  006d a40f          	and	a,#15
2360  006f 02            	rlwa	x,a
2361  0070 9f            	ld	a,xl
2362  0071 aac0          	or	a,#192
2363  0073 c70003        	ld	_vent_resurs_buff+3,a
2364                     ; 204 temp=vent_resurs_buff[0]&0x0f;
2366  0076 c60000        	ld	a,_vent_resurs_buff
2367  0079 a40f          	and	a,#15
2368  007b 6b01          	ld	(OFST+0,sp),a
2369                     ; 205 temp^=vent_resurs_buff[1]&0x0f;
2371  007d c60001        	ld	a,_vent_resurs_buff+1
2372  0080 a40f          	and	a,#15
2373  0082 1801          	xor	a,(OFST+0,sp)
2374  0084 6b01          	ld	(OFST+0,sp),a
2375                     ; 206 temp^=vent_resurs_buff[2]&0x0f;
2377  0086 c60002        	ld	a,_vent_resurs_buff+2
2378  0089 a40f          	and	a,#15
2379  008b 1801          	xor	a,(OFST+0,sp)
2380  008d 6b01          	ld	(OFST+0,sp),a
2381                     ; 207 temp^=vent_resurs_buff[3]&0x0f;
2383  008f c60003        	ld	a,_vent_resurs_buff+3
2384  0092 a40f          	and	a,#15
2385  0094 1801          	xor	a,(OFST+0,sp)
2386  0096 6b01          	ld	(OFST+0,sp),a
2387                     ; 209 vent_resurs_buff[0]|=(temp&0x03)<<4;
2389  0098 7b01          	ld	a,(OFST+0,sp)
2390  009a a403          	and	a,#3
2391  009c 97            	ld	xl,a
2392  009d a610          	ld	a,#16
2393  009f 42            	mul	x,a
2394  00a0 9f            	ld	a,xl
2395  00a1 ca0000        	or	a,_vent_resurs_buff
2396  00a4 c70000        	ld	_vent_resurs_buff,a
2397                     ; 210 vent_resurs_buff[1]|=(temp&0x0c)<<2;
2399  00a7 7b01          	ld	a,(OFST+0,sp)
2400  00a9 a40c          	and	a,#12
2401  00ab 48            	sll	a
2402  00ac 48            	sll	a
2403  00ad ca0001        	or	a,_vent_resurs_buff+1
2404  00b0 c70001        	ld	_vent_resurs_buff+1,a
2405                     ; 211 vent_resurs_buff[2]|=(temp&0x30);
2407  00b3 7b01          	ld	a,(OFST+0,sp)
2408  00b5 a430          	and	a,#48
2409  00b7 ca0002        	or	a,_vent_resurs_buff+2
2410  00ba c70002        	ld	_vent_resurs_buff+2,a
2411                     ; 212 vent_resurs_buff[3]|=(temp&0xc0)>>2;
2413  00bd 7b01          	ld	a,(OFST+0,sp)
2414  00bf a4c0          	and	a,#192
2415  00c1 44            	srl	a
2416  00c2 44            	srl	a
2417  00c3 ca0003        	or	a,_vent_resurs_buff+3
2418  00c6 c70003        	ld	_vent_resurs_buff+3,a
2419                     ; 215 vent_resurs_tx_cnt++;
2421  00c9 3c08          	inc	_vent_resurs_tx_cnt
2422                     ; 216 if(vent_resurs_tx_cnt>3)vent_resurs_tx_cnt=0;
2424  00cb b608          	ld	a,_vent_resurs_tx_cnt
2425  00cd a104          	cp	a,#4
2426  00cf 2502          	jrult	L5541
2429  00d1 3f08          	clr	_vent_resurs_tx_cnt
2430  00d3               L5541:
2431                     ; 219 }
2434  00d3 84            	pop	a
2435  00d4 81            	ret
2488                     ; 222 void gran(signed short *adr, signed short min, signed short max)
2488                     ; 223 {
2489                     	switch	.text
2490  00d5               _gran:
2492  00d5 89            	pushw	x
2493       00000000      OFST:	set	0
2496                     ; 224 if (*adr<min) *adr=min;
2498  00d6 9c            	rvf
2499  00d7 9093          	ldw	y,x
2500  00d9 51            	exgw	x,y
2501  00da fe            	ldw	x,(x)
2502  00db 1305          	cpw	x,(OFST+5,sp)
2503  00dd 51            	exgw	x,y
2504  00de 2e03          	jrsge	L5051
2507  00e0 1605          	ldw	y,(OFST+5,sp)
2508  00e2 ff            	ldw	(x),y
2509  00e3               L5051:
2510                     ; 225 if (*adr>max) *adr=max; 
2512  00e3 9c            	rvf
2513  00e4 1e01          	ldw	x,(OFST+1,sp)
2514  00e6 9093          	ldw	y,x
2515  00e8 51            	exgw	x,y
2516  00e9 fe            	ldw	x,(x)
2517  00ea 1307          	cpw	x,(OFST+7,sp)
2518  00ec 51            	exgw	x,y
2519  00ed 2d05          	jrsle	L7051
2522  00ef 1e01          	ldw	x,(OFST+1,sp)
2523  00f1 1607          	ldw	y,(OFST+7,sp)
2524  00f3 ff            	ldw	(x),y
2525  00f4               L7051:
2526                     ; 226 } 
2529  00f4 85            	popw	x
2530  00f5 81            	ret
2583                     ; 229 void granee(@eeprom signed short *adr, signed short min, signed short max)
2583                     ; 230 {
2584                     	switch	.text
2585  00f6               _granee:
2587  00f6 89            	pushw	x
2588       00000000      OFST:	set	0
2591                     ; 231 if (*adr<min) *adr=min;
2593  00f7 9c            	rvf
2594  00f8 9093          	ldw	y,x
2595  00fa 51            	exgw	x,y
2596  00fb fe            	ldw	x,(x)
2597  00fc 1305          	cpw	x,(OFST+5,sp)
2598  00fe 51            	exgw	x,y
2599  00ff 2e09          	jrsge	L7351
2602  0101 1e05          	ldw	x,(OFST+5,sp)
2603  0103 89            	pushw	x
2604  0104 1e03          	ldw	x,(OFST+3,sp)
2605  0106 cd0000        	call	c_eewrw
2607  0109 85            	popw	x
2608  010a               L7351:
2609                     ; 232 if (*adr>max) *adr=max; 
2611  010a 9c            	rvf
2612  010b 1e01          	ldw	x,(OFST+1,sp)
2613  010d 9093          	ldw	y,x
2614  010f 51            	exgw	x,y
2615  0110 fe            	ldw	x,(x)
2616  0111 1307          	cpw	x,(OFST+7,sp)
2617  0113 51            	exgw	x,y
2618  0114 2d09          	jrsle	L1451
2621  0116 1e07          	ldw	x,(OFST+7,sp)
2622  0118 89            	pushw	x
2623  0119 1e03          	ldw	x,(OFST+3,sp)
2624  011b cd0000        	call	c_eewrw
2626  011e 85            	popw	x
2627  011f               L1451:
2628                     ; 233 }
2631  011f 85            	popw	x
2632  0120 81            	ret
2693                     ; 236 long delay_ms(short in)
2693                     ; 237 {
2694                     	switch	.text
2695  0121               _delay_ms:
2697  0121 520c          	subw	sp,#12
2698       0000000c      OFST:	set	12
2701                     ; 240 i=((long)in)*100UL;
2703  0123 90ae0064      	ldw	y,#100
2704  0127 cd0000        	call	c_vmul
2706  012a 96            	ldw	x,sp
2707  012b 1c0005        	addw	x,#OFST-7
2708  012e cd0000        	call	c_rtol
2710                     ; 242 for(ii=0;ii<i;ii++)
2712  0131 ae0000        	ldw	x,#0
2713  0134 1f0b          	ldw	(OFST-1,sp),x
2714  0136 ae0000        	ldw	x,#0
2715  0139 1f09          	ldw	(OFST-3,sp),x
2717  013b 2012          	jra	L1061
2718  013d               L5751:
2719                     ; 244 		iii++;
2721  013d 96            	ldw	x,sp
2722  013e 1c0001        	addw	x,#OFST-11
2723  0141 a601          	ld	a,#1
2724  0143 cd0000        	call	c_lgadc
2726                     ; 242 for(ii=0;ii<i;ii++)
2728  0146 96            	ldw	x,sp
2729  0147 1c0009        	addw	x,#OFST-3
2730  014a a601          	ld	a,#1
2731  014c cd0000        	call	c_lgadc
2733  014f               L1061:
2736  014f 9c            	rvf
2737  0150 96            	ldw	x,sp
2738  0151 1c0009        	addw	x,#OFST-3
2739  0154 cd0000        	call	c_ltor
2741  0157 96            	ldw	x,sp
2742  0158 1c0005        	addw	x,#OFST-7
2743  015b cd0000        	call	c_lcmp
2745  015e 2fdd          	jrslt	L5751
2746                     ; 247 }
2749  0160 5b0c          	addw	sp,#12
2750  0162 81            	ret
2783                     ; 250 void led_hndl(void)
2783                     ; 251 {
2784                     	switch	.text
2785  0163               _led_hndl:
2789                     ; 252 if(adress_error)
2791  0163 725d00f6      	tnz	_adress_error
2792  0167 2714          	jreq	L5161
2793                     ; 254 	led_red=0x55555555L;
2795  0169 ae5555        	ldw	x,#21845
2796  016c bf10          	ldw	_led_red+2,x
2797  016e ae5555        	ldw	x,#21845
2798  0171 bf0e          	ldw	_led_red,x
2799                     ; 255 	led_green=0x55555555L;
2801  0173 ae5555        	ldw	x,#21845
2802  0176 bf14          	ldw	_led_green+2,x
2803  0178 ae5555        	ldw	x,#21845
2804  017b bf12          	ldw	_led_green,x
2805  017d               L5161:
2806                     ; 273 	if(jp_mode!=jp3)
2808  017d b650          	ld	a,_jp_mode
2809  017f a103          	cp	a,#3
2810  0181 2603          	jrne	L02
2811  0183 cc0311        	jp	L7161
2812  0186               L02:
2813                     ; 275 		if(main_cnt1<(5*EE_TZAS))
2815  0186 9c            	rvf
2816  0187 be57          	ldw	x,_main_cnt1
2817  0189 a3000f        	cpw	x,#15
2818  018c 2e18          	jrsge	L1261
2819                     ; 277 			led_red=0x00000000L;
2821  018e ae0000        	ldw	x,#0
2822  0191 bf10          	ldw	_led_red+2,x
2823  0193 ae0000        	ldw	x,#0
2824  0196 bf0e          	ldw	_led_red,x
2825                     ; 278 			led_green=0x0303030fL;
2827  0198 ae030f        	ldw	x,#783
2828  019b bf14          	ldw	_led_green+2,x
2829  019d ae0303        	ldw	x,#771
2830  01a0 bf12          	ldw	_led_green,x
2832  01a2 acd202d2      	jpf	L3261
2833  01a6               L1261:
2834                     ; 281 		else if((link==ON)&&(flags_tu&0b10000000))
2836  01a6 b669          	ld	a,_link
2837  01a8 a155          	cp	a,#85
2838  01aa 261e          	jrne	L5261
2840  01ac b666          	ld	a,_flags_tu
2841  01ae a580          	bcp	a,#128
2842  01b0 2718          	jreq	L5261
2843                     ; 283 			led_red=0x00055555L;
2845  01b2 ae5555        	ldw	x,#21845
2846  01b5 bf10          	ldw	_led_red+2,x
2847  01b7 ae0005        	ldw	x,#5
2848  01ba bf0e          	ldw	_led_red,x
2849                     ; 284 			led_green=0xffffffffL;
2851  01bc aeffff        	ldw	x,#65535
2852  01bf bf14          	ldw	_led_green+2,x
2853  01c1 aeffff        	ldw	x,#-1
2854  01c4 bf12          	ldw	_led_green,x
2856  01c6 acd202d2      	jpf	L3261
2857  01ca               L5261:
2858                     ; 287 		else if(((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(100+(5*EE_TZAS)))) && (ee_AVT_MODE!=0x55)&& (!ee_DEVICE))
2860  01ca 9c            	rvf
2861  01cb be57          	ldw	x,_main_cnt1
2862  01cd a30010        	cpw	x,#16
2863  01d0 2f2d          	jrslt	L1361
2865  01d2 9c            	rvf
2866  01d3 be57          	ldw	x,_main_cnt1
2867  01d5 a30073        	cpw	x,#115
2868  01d8 2e25          	jrsge	L1361
2870  01da ce0006        	ldw	x,_ee_AVT_MODE
2871  01dd a30055        	cpw	x,#85
2872  01e0 271d          	jreq	L1361
2874  01e2 ce0004        	ldw	x,_ee_DEVICE
2875  01e5 2618          	jrne	L1361
2876                     ; 289 			led_red=0x00000000L;
2878  01e7 ae0000        	ldw	x,#0
2879  01ea bf10          	ldw	_led_red+2,x
2880  01ec ae0000        	ldw	x,#0
2881  01ef bf0e          	ldw	_led_red,x
2882                     ; 290 			led_green=0xffffffffL;	
2884  01f1 aeffff        	ldw	x,#65535
2885  01f4 bf14          	ldw	_led_green+2,x
2886  01f6 aeffff        	ldw	x,#-1
2887  01f9 bf12          	ldw	_led_green,x
2889  01fb acd202d2      	jpf	L3261
2890  01ff               L1361:
2891                     ; 293 		else  if(link==OFF)
2893  01ff b669          	ld	a,_link
2894  0201 a1aa          	cp	a,#170
2895  0203 2618          	jrne	L5361
2896                     ; 295 			led_red=0x55555555L;
2898  0205 ae5555        	ldw	x,#21845
2899  0208 bf10          	ldw	_led_red+2,x
2900  020a ae5555        	ldw	x,#21845
2901  020d bf0e          	ldw	_led_red,x
2902                     ; 296 			led_green=0xffffffffL;
2904  020f aeffff        	ldw	x,#65535
2905  0212 bf14          	ldw	_led_green+2,x
2906  0214 aeffff        	ldw	x,#-1
2907  0217 bf12          	ldw	_led_green,x
2909  0219 acd202d2      	jpf	L3261
2910  021d               L5361:
2911                     ; 299 		else if((link==ON)&&((flags&0b00111110)==0))
2913  021d b669          	ld	a,_link
2914  021f a155          	cp	a,#85
2915  0221 261d          	jrne	L1461
2917  0223 b605          	ld	a,_flags
2918  0225 a53e          	bcp	a,#62
2919  0227 2617          	jrne	L1461
2920                     ; 301 			led_red=0x00000000L;
2922  0229 ae0000        	ldw	x,#0
2923  022c bf10          	ldw	_led_red+2,x
2924  022e ae0000        	ldw	x,#0
2925  0231 bf0e          	ldw	_led_red,x
2926                     ; 302 			led_green=0xffffffffL;
2928  0233 aeffff        	ldw	x,#65535
2929  0236 bf14          	ldw	_led_green+2,x
2930  0238 aeffff        	ldw	x,#-1
2931  023b bf12          	ldw	_led_green,x
2933  023d cc02d2        	jra	L3261
2934  0240               L1461:
2935                     ; 305 		else if((flags&0b00111110)==0b00000100)
2937  0240 b605          	ld	a,_flags
2938  0242 a43e          	and	a,#62
2939  0244 a104          	cp	a,#4
2940  0246 2616          	jrne	L5461
2941                     ; 307 			led_red=0x00010001L;
2943  0248 ae0001        	ldw	x,#1
2944  024b bf10          	ldw	_led_red+2,x
2945  024d ae0001        	ldw	x,#1
2946  0250 bf0e          	ldw	_led_red,x
2947                     ; 308 			led_green=0xffffffffL;	
2949  0252 aeffff        	ldw	x,#65535
2950  0255 bf14          	ldw	_led_green+2,x
2951  0257 aeffff        	ldw	x,#-1
2952  025a bf12          	ldw	_led_green,x
2954  025c 2074          	jra	L3261
2955  025e               L5461:
2956                     ; 310 		else if(flags&0b00000010)
2958  025e b605          	ld	a,_flags
2959  0260 a502          	bcp	a,#2
2960  0262 2716          	jreq	L1561
2961                     ; 312 			led_red=0x00010001L;
2963  0264 ae0001        	ldw	x,#1
2964  0267 bf10          	ldw	_led_red+2,x
2965  0269 ae0001        	ldw	x,#1
2966  026c bf0e          	ldw	_led_red,x
2967                     ; 313 			led_green=0x00000000L;	
2969  026e ae0000        	ldw	x,#0
2970  0271 bf14          	ldw	_led_green+2,x
2971  0273 ae0000        	ldw	x,#0
2972  0276 bf12          	ldw	_led_green,x
2974  0278 2058          	jra	L3261
2975  027a               L1561:
2976                     ; 315 		else if(flags&0b00001000)
2978  027a b605          	ld	a,_flags
2979  027c a508          	bcp	a,#8
2980  027e 2716          	jreq	L5561
2981                     ; 317 			led_red=0x00090009L;
2983  0280 ae0009        	ldw	x,#9
2984  0283 bf10          	ldw	_led_red+2,x
2985  0285 ae0009        	ldw	x,#9
2986  0288 bf0e          	ldw	_led_red,x
2987                     ; 318 			led_green=0x00000000L;	
2989  028a ae0000        	ldw	x,#0
2990  028d bf14          	ldw	_led_green+2,x
2991  028f ae0000        	ldw	x,#0
2992  0292 bf12          	ldw	_led_green,x
2994  0294 203c          	jra	L3261
2995  0296               L5561:
2996                     ; 320 		else if(flags&0b00010000)
2998  0296 b605          	ld	a,_flags
2999  0298 a510          	bcp	a,#16
3000  029a 2716          	jreq	L1661
3001                     ; 322 			led_red=0x00490049L;
3003  029c ae0049        	ldw	x,#73
3004  029f bf10          	ldw	_led_red+2,x
3005  02a1 ae0049        	ldw	x,#73
3006  02a4 bf0e          	ldw	_led_red,x
3007                     ; 323 			led_green=0x00000000L;	
3009  02a6 ae0000        	ldw	x,#0
3010  02a9 bf14          	ldw	_led_green+2,x
3011  02ab ae0000        	ldw	x,#0
3012  02ae bf12          	ldw	_led_green,x
3014  02b0 2020          	jra	L3261
3015  02b2               L1661:
3016                     ; 326 		else if((link==ON)&&(flags&0b00100000))
3018  02b2 b669          	ld	a,_link
3019  02b4 a155          	cp	a,#85
3020  02b6 261a          	jrne	L3261
3022  02b8 b605          	ld	a,_flags
3023  02ba a520          	bcp	a,#32
3024  02bc 2714          	jreq	L3261
3025                     ; 328 			led_red=0x00000000L;
3027  02be ae0000        	ldw	x,#0
3028  02c1 bf10          	ldw	_led_red+2,x
3029  02c3 ae0000        	ldw	x,#0
3030  02c6 bf0e          	ldw	_led_red,x
3031                     ; 329 			led_green=0x00030003L;
3033  02c8 ae0003        	ldw	x,#3
3034  02cb bf14          	ldw	_led_green+2,x
3035  02cd ae0003        	ldw	x,#3
3036  02d0 bf12          	ldw	_led_green,x
3037  02d2               L3261:
3038                     ; 332 		if((jp_mode==jp1))
3040  02d2 b650          	ld	a,_jp_mode
3041  02d4 a101          	cp	a,#1
3042  02d6 2618          	jrne	L7661
3043                     ; 334 			led_red=0x00000000L;
3045  02d8 ae0000        	ldw	x,#0
3046  02db bf10          	ldw	_led_red+2,x
3047  02dd ae0000        	ldw	x,#0
3048  02e0 bf0e          	ldw	_led_red,x
3049                     ; 335 			led_green=0x33333333L;
3051  02e2 ae3333        	ldw	x,#13107
3052  02e5 bf14          	ldw	_led_green+2,x
3053  02e7 ae3333        	ldw	x,#13107
3054  02ea bf12          	ldw	_led_green,x
3056  02ec aced03ed      	jpf	L5761
3057  02f0               L7661:
3058                     ; 337 		else if((jp_mode==jp2))
3060  02f0 b650          	ld	a,_jp_mode
3061  02f2 a102          	cp	a,#2
3062  02f4 2703          	jreq	L22
3063  02f6 cc03ed        	jp	L5761
3064  02f9               L22:
3065                     ; 339 			led_red=0xccccccccL;
3067  02f9 aecccc        	ldw	x,#52428
3068  02fc bf10          	ldw	_led_red+2,x
3069  02fe aecccc        	ldw	x,#-13108
3070  0301 bf0e          	ldw	_led_red,x
3071                     ; 340 			led_green=0x00000000L;
3073  0303 ae0000        	ldw	x,#0
3074  0306 bf14          	ldw	_led_green+2,x
3075  0308 ae0000        	ldw	x,#0
3076  030b bf12          	ldw	_led_green,x
3077  030d aced03ed      	jpf	L5761
3078  0311               L7161:
3079                     ; 345 	else if(jp_mode==jp3)
3081  0311 b650          	ld	a,_jp_mode
3082  0313 a103          	cp	a,#3
3083  0315 2703          	jreq	L42
3084  0317 cc03ed        	jp	L5761
3085  031a               L42:
3086                     ; 347 		if(main_cnt1<(5*EE_TZAS))
3088  031a 9c            	rvf
3089  031b be57          	ldw	x,_main_cnt1
3090  031d a3000f        	cpw	x,#15
3091  0320 2e18          	jrsge	L1071
3092                     ; 349 			led_red=0x00000000L;
3094  0322 ae0000        	ldw	x,#0
3095  0325 bf10          	ldw	_led_red+2,x
3096  0327 ae0000        	ldw	x,#0
3097  032a bf0e          	ldw	_led_red,x
3098                     ; 350 			led_green=0x03030303L;
3100  032c ae0303        	ldw	x,#771
3101  032f bf14          	ldw	_led_green+2,x
3102  0331 ae0303        	ldw	x,#771
3103  0334 bf12          	ldw	_led_green,x
3105  0336 aced03ed      	jpf	L5761
3106  033a               L1071:
3107                     ; 352 		else if((main_cnt1>(5*EE_TZAS))&&(main_cnt1<(70+(5*EE_TZAS))))
3109  033a 9c            	rvf
3110  033b be57          	ldw	x,_main_cnt1
3111  033d a30010        	cpw	x,#16
3112  0340 2f1f          	jrslt	L5071
3114  0342 9c            	rvf
3115  0343 be57          	ldw	x,_main_cnt1
3116  0345 a30055        	cpw	x,#85
3117  0348 2e17          	jrsge	L5071
3118                     ; 354 			led_red=0x00000000L;
3120  034a ae0000        	ldw	x,#0
3121  034d bf10          	ldw	_led_red+2,x
3122  034f ae0000        	ldw	x,#0
3123  0352 bf0e          	ldw	_led_red,x
3124                     ; 355 			led_green=0xffffffffL;	
3126  0354 aeffff        	ldw	x,#65535
3127  0357 bf14          	ldw	_led_green+2,x
3128  0359 aeffff        	ldw	x,#-1
3129  035c bf12          	ldw	_led_green,x
3131  035e cc03ed        	jra	L5761
3132  0361               L5071:
3133                     ; 358 		else if((flags&0b00011110)==0)
3135  0361 b605          	ld	a,_flags
3136  0363 a51e          	bcp	a,#30
3137  0365 2616          	jrne	L1171
3138                     ; 360 			led_red=0x00000000L;
3140  0367 ae0000        	ldw	x,#0
3141  036a bf10          	ldw	_led_red+2,x
3142  036c ae0000        	ldw	x,#0
3143  036f bf0e          	ldw	_led_red,x
3144                     ; 361 			led_green=0xffffffffL;
3146  0371 aeffff        	ldw	x,#65535
3147  0374 bf14          	ldw	_led_green+2,x
3148  0376 aeffff        	ldw	x,#-1
3149  0379 bf12          	ldw	_led_green,x
3151  037b 2070          	jra	L5761
3152  037d               L1171:
3153                     ; 365 		else if((flags&0b00111110)==0b00000100)
3155  037d b605          	ld	a,_flags
3156  037f a43e          	and	a,#62
3157  0381 a104          	cp	a,#4
3158  0383 2616          	jrne	L5171
3159                     ; 367 			led_red=0x00010001L;
3161  0385 ae0001        	ldw	x,#1
3162  0388 bf10          	ldw	_led_red+2,x
3163  038a ae0001        	ldw	x,#1
3164  038d bf0e          	ldw	_led_red,x
3165                     ; 368 			led_green=0xffffffffL;	
3167  038f aeffff        	ldw	x,#65535
3168  0392 bf14          	ldw	_led_green+2,x
3169  0394 aeffff        	ldw	x,#-1
3170  0397 bf12          	ldw	_led_green,x
3172  0399 2052          	jra	L5761
3173  039b               L5171:
3174                     ; 370 		else if(flags&0b00000010)
3176  039b b605          	ld	a,_flags
3177  039d a502          	bcp	a,#2
3178  039f 2716          	jreq	L1271
3179                     ; 372 			led_red=0x00010001L;
3181  03a1 ae0001        	ldw	x,#1
3182  03a4 bf10          	ldw	_led_red+2,x
3183  03a6 ae0001        	ldw	x,#1
3184  03a9 bf0e          	ldw	_led_red,x
3185                     ; 373 			led_green=0x00000000L;	
3187  03ab ae0000        	ldw	x,#0
3188  03ae bf14          	ldw	_led_green+2,x
3189  03b0 ae0000        	ldw	x,#0
3190  03b3 bf12          	ldw	_led_green,x
3192  03b5 2036          	jra	L5761
3193  03b7               L1271:
3194                     ; 375 		else if(flags&0b00001000)
3196  03b7 b605          	ld	a,_flags
3197  03b9 a508          	bcp	a,#8
3198  03bb 2716          	jreq	L5271
3199                     ; 377 			led_red=0x00090009L;
3201  03bd ae0009        	ldw	x,#9
3202  03c0 bf10          	ldw	_led_red+2,x
3203  03c2 ae0009        	ldw	x,#9
3204  03c5 bf0e          	ldw	_led_red,x
3205                     ; 378 			led_green=0x00000000L;	
3207  03c7 ae0000        	ldw	x,#0
3208  03ca bf14          	ldw	_led_green+2,x
3209  03cc ae0000        	ldw	x,#0
3210  03cf bf12          	ldw	_led_green,x
3212  03d1 201a          	jra	L5761
3213  03d3               L5271:
3214                     ; 380 		else if(flags&0b00010000)
3216  03d3 b605          	ld	a,_flags
3217  03d5 a510          	bcp	a,#16
3218  03d7 2714          	jreq	L5761
3219                     ; 382 			led_red=0x00490049L;
3221  03d9 ae0049        	ldw	x,#73
3222  03dc bf10          	ldw	_led_red+2,x
3223  03de ae0049        	ldw	x,#73
3224  03e1 bf0e          	ldw	_led_red,x
3225                     ; 383 			led_green=0xffffffffL;	
3227  03e3 aeffff        	ldw	x,#65535
3228  03e6 bf14          	ldw	_led_green+2,x
3229  03e8 aeffff        	ldw	x,#-1
3230  03eb bf12          	ldw	_led_green,x
3231  03ed               L5761:
3232                     ; 543 }
3235  03ed 81            	ret
3263                     ; 546 void led_drv(void)
3263                     ; 547 {
3264                     	switch	.text
3265  03ee               _led_drv:
3269                     ; 549 GPIOA->DDR|=(1<<4);
3271  03ee 72185002      	bset	20482,#4
3272                     ; 550 GPIOA->CR1|=(1<<4);
3274  03f2 72185003      	bset	20483,#4
3275                     ; 551 GPIOA->CR2&=~(1<<4);
3277  03f6 72195004      	bres	20484,#4
3278                     ; 552 if(led_red_buff&0b1L) GPIOA->ODR|=(1<<4); 	//Горит если в led_red_buff 1 и на ножке 1
3280  03fa b646          	ld	a,_led_red_buff+3
3281  03fc a501          	bcp	a,#1
3282  03fe 2706          	jreq	L3471
3285  0400 72185000      	bset	20480,#4
3287  0404 2004          	jra	L5471
3288  0406               L3471:
3289                     ; 553 else GPIOA->ODR&=~(1<<4); 
3291  0406 72195000      	bres	20480,#4
3292  040a               L5471:
3293                     ; 556 GPIOA->DDR|=(1<<5);
3295  040a 721a5002      	bset	20482,#5
3296                     ; 557 GPIOA->CR1|=(1<<5);
3298  040e 721a5003      	bset	20483,#5
3299                     ; 558 GPIOA->CR2&=~(1<<5);	
3301  0412 721b5004      	bres	20484,#5
3302                     ; 559 if(led_green_buff&0b1L) GPIOA->ODR|=(1<<5);	//Горит если в led_green_buff 1 и на ножке 1
3304  0416 b642          	ld	a,_led_green_buff+3
3305  0418 a501          	bcp	a,#1
3306  041a 2706          	jreq	L7471
3309  041c 721a5000      	bset	20480,#5
3311  0420 2004          	jra	L1571
3312  0422               L7471:
3313                     ; 560 else GPIOA->ODR&=~(1<<5);
3315  0422 721b5000      	bres	20480,#5
3316  0426               L1571:
3317                     ; 563 led_red_buff>>=1;
3319  0426 3743          	sra	_led_red_buff
3320  0428 3644          	rrc	_led_red_buff+1
3321  042a 3645          	rrc	_led_red_buff+2
3322  042c 3646          	rrc	_led_red_buff+3
3323                     ; 564 led_green_buff>>=1;
3325  042e 373f          	sra	_led_green_buff
3326  0430 3640          	rrc	_led_green_buff+1
3327  0432 3641          	rrc	_led_green_buff+2
3328  0434 3642          	rrc	_led_green_buff+3
3329                     ; 565 if(++led_drv_cnt>32)
3331  0436 3c16          	inc	_led_drv_cnt
3332  0438 b616          	ld	a,_led_drv_cnt
3333  043a a121          	cp	a,#33
3334  043c 2512          	jrult	L3571
3335                     ; 567 	led_drv_cnt=0;
3337  043e 3f16          	clr	_led_drv_cnt
3338                     ; 568 	led_red_buff=led_red;
3340  0440 be10          	ldw	x,_led_red+2
3341  0442 bf45          	ldw	_led_red_buff+2,x
3342  0444 be0e          	ldw	x,_led_red
3343  0446 bf43          	ldw	_led_red_buff,x
3344                     ; 569 	led_green_buff=led_green;
3346  0448 be14          	ldw	x,_led_green+2
3347  044a bf41          	ldw	_led_green_buff+2,x
3348  044c be12          	ldw	x,_led_green
3349  044e bf3f          	ldw	_led_green_buff,x
3350  0450               L3571:
3351                     ; 575 } 
3354  0450 81            	ret
3380                     ; 578 void JP_drv(void)
3380                     ; 579 {
3381                     	switch	.text
3382  0451               _JP_drv:
3386                     ; 581 GPIOD->DDR&=~(1<<6);
3388  0451 721d5011      	bres	20497,#6
3389                     ; 582 GPIOD->CR1|=(1<<6);
3391  0455 721c5012      	bset	20498,#6
3392                     ; 583 GPIOD->CR2&=~(1<<6);
3394  0459 721d5013      	bres	20499,#6
3395                     ; 585 GPIOD->DDR&=~(1<<7);
3397  045d 721f5011      	bres	20497,#7
3398                     ; 586 GPIOD->CR1|=(1<<7);
3400  0461 721e5012      	bset	20498,#7
3401                     ; 587 GPIOD->CR2&=~(1<<7);
3403  0465 721f5013      	bres	20499,#7
3404                     ; 589 if(GPIOD->IDR&(1<<6))
3406  0469 c65010        	ld	a,20496
3407  046c a540          	bcp	a,#64
3408  046e 270a          	jreq	L5671
3409                     ; 591 	if(cnt_JP0<10)
3411  0470 b64f          	ld	a,_cnt_JP0
3412  0472 a10a          	cp	a,#10
3413  0474 2411          	jruge	L1771
3414                     ; 593 		cnt_JP0++;
3416  0476 3c4f          	inc	_cnt_JP0
3417  0478 200d          	jra	L1771
3418  047a               L5671:
3419                     ; 596 else if(!(GPIOD->IDR&(1<<6)))
3421  047a c65010        	ld	a,20496
3422  047d a540          	bcp	a,#64
3423  047f 2606          	jrne	L1771
3424                     ; 598 	if(cnt_JP0)
3426  0481 3d4f          	tnz	_cnt_JP0
3427  0483 2702          	jreq	L1771
3428                     ; 600 		cnt_JP0--;
3430  0485 3a4f          	dec	_cnt_JP0
3431  0487               L1771:
3432                     ; 604 if(GPIOD->IDR&(1<<7))
3434  0487 c65010        	ld	a,20496
3435  048a a580          	bcp	a,#128
3436  048c 270a          	jreq	L7771
3437                     ; 606 	if(cnt_JP1<10)
3439  048e b64e          	ld	a,_cnt_JP1
3440  0490 a10a          	cp	a,#10
3441  0492 2411          	jruge	L3002
3442                     ; 608 		cnt_JP1++;
3444  0494 3c4e          	inc	_cnt_JP1
3445  0496 200d          	jra	L3002
3446  0498               L7771:
3447                     ; 611 else if(!(GPIOD->IDR&(1<<7)))
3449  0498 c65010        	ld	a,20496
3450  049b a580          	bcp	a,#128
3451  049d 2606          	jrne	L3002
3452                     ; 613 	if(cnt_JP1)
3454  049f 3d4e          	tnz	_cnt_JP1
3455  04a1 2702          	jreq	L3002
3456                     ; 615 		cnt_JP1--;
3458  04a3 3a4e          	dec	_cnt_JP1
3459  04a5               L3002:
3460                     ; 620 if((cnt_JP0==10)&&(cnt_JP1==10))
3462  04a5 b64f          	ld	a,_cnt_JP0
3463  04a7 a10a          	cp	a,#10
3464  04a9 2608          	jrne	L1102
3466  04ab b64e          	ld	a,_cnt_JP1
3467  04ad a10a          	cp	a,#10
3468  04af 2602          	jrne	L1102
3469                     ; 622 	jp_mode=jp0;
3471  04b1 3f50          	clr	_jp_mode
3472  04b3               L1102:
3473                     ; 624 if((cnt_JP0==0)&&(cnt_JP1==10))
3475  04b3 3d4f          	tnz	_cnt_JP0
3476  04b5 260a          	jrne	L3102
3478  04b7 b64e          	ld	a,_cnt_JP1
3479  04b9 a10a          	cp	a,#10
3480  04bb 2604          	jrne	L3102
3481                     ; 626 	jp_mode=jp1;
3483  04bd 35010050      	mov	_jp_mode,#1
3484  04c1               L3102:
3485                     ; 628 if((cnt_JP0==10)&&(cnt_JP1==0))
3487  04c1 b64f          	ld	a,_cnt_JP0
3488  04c3 a10a          	cp	a,#10
3489  04c5 2608          	jrne	L5102
3491  04c7 3d4e          	tnz	_cnt_JP1
3492  04c9 2604          	jrne	L5102
3493                     ; 630 	jp_mode=jp2;
3495  04cb 35020050      	mov	_jp_mode,#2
3496  04cf               L5102:
3497                     ; 632 if((cnt_JP0==0)&&(cnt_JP1==0))
3499  04cf 3d4f          	tnz	_cnt_JP0
3500  04d1 2608          	jrne	L7102
3502  04d3 3d4e          	tnz	_cnt_JP1
3503  04d5 2604          	jrne	L7102
3504                     ; 634 	jp_mode=jp3;
3506  04d7 35030050      	mov	_jp_mode,#3
3507  04db               L7102:
3508                     ; 637 }
3511  04db 81            	ret
3543                     ; 640 void link_drv(void)		//10Hz
3543                     ; 641 {
3544                     	switch	.text
3545  04dc               _link_drv:
3549                     ; 642 if(jp_mode!=jp3)
3551  04dc b650          	ld	a,_jp_mode
3552  04de a103          	cp	a,#3
3553  04e0 274d          	jreq	L1302
3554                     ; 644 	if(link_cnt<602)link_cnt++;
3556  04e2 9c            	rvf
3557  04e3 be67          	ldw	x,_link_cnt
3558  04e5 a3025a        	cpw	x,#602
3559  04e8 2e07          	jrsge	L3302
3562  04ea be67          	ldw	x,_link_cnt
3563  04ec 1c0001        	addw	x,#1
3564  04ef bf67          	ldw	_link_cnt,x
3565  04f1               L3302:
3566                     ; 645 	if(link_cnt==90)flags&=0xc1;		//если оборвалась связь первым делом сбрасываем все аварии и внешнюю блокировку
3568  04f1 be67          	ldw	x,_link_cnt
3569  04f3 a3005a        	cpw	x,#90
3570  04f6 2606          	jrne	L5302
3573  04f8 b605          	ld	a,_flags
3574  04fa a4c1          	and	a,#193
3575  04fc b705          	ld	_flags,a
3576  04fe               L5302:
3577                     ; 646 	if(link_cnt==100)
3579  04fe be67          	ldw	x,_link_cnt
3580  0500 a30064        	cpw	x,#100
3581  0503 262e          	jrne	L7402
3582                     ; 648 		link=OFF;
3584  0505 35aa0069      	mov	_link,#170
3585                     ; 653 		if(bps_class==bpsIPS)bMAIN=1;	//если БПС определен как ИПСный - пытаться стать главным;
3587  0509 b60b          	ld	a,_bps_class
3588  050b a101          	cp	a,#1
3589  050d 2606          	jrne	L1402
3592  050f 72100001      	bset	_bMAIN
3594  0513 2004          	jra	L3402
3595  0515               L1402:
3596                     ; 654 		else bMAIN=0;
3598  0515 72110001      	bres	_bMAIN
3599  0519               L3402:
3600                     ; 656 		cnt_net_drv=0;
3602  0519 3f38          	clr	_cnt_net_drv
3603                     ; 657     		if(!res_fl_)
3605  051b 725d000a      	tnz	_res_fl_
3606  051f 2612          	jrne	L7402
3607                     ; 659 	    		bRES_=1;
3609  0521 3501000d      	mov	_bRES_,#1
3610                     ; 660 	    		res_fl_=1;
3612  0525 a601          	ld	a,#1
3613  0527 ae000a        	ldw	x,#_res_fl_
3614  052a cd0000        	call	c_eewrc
3616  052d 2004          	jra	L7402
3617  052f               L1302:
3618                     ; 664 else link=OFF;	
3620  052f 35aa0069      	mov	_link,#170
3621  0533               L7402:
3622                     ; 665 } 
3625  0533 81            	ret
3694                     	switch	.const
3695  0004               L63:
3696  0004 0000000b      	dc.l	11
3697  0008               L04:
3698  0008 00000001      	dc.l	1
3699                     ; 669 void vent_drv(void)
3699                     ; 670 {
3700                     	switch	.text
3701  0534               _vent_drv:
3703  0534 520e          	subw	sp,#14
3704       0000000e      OFST:	set	14
3707                     ; 673 	short vent_pwm_i_necc=400;
3709  0536 ae0190        	ldw	x,#400
3710  0539 1f07          	ldw	(OFST-7,sp),x
3711                     ; 674 	short vent_pwm_t_necc=400;
3713  053b ae0190        	ldw	x,#400
3714  053e 1f09          	ldw	(OFST-5,sp),x
3715                     ; 675 	short vent_pwm_max_necc=400;
3717                     ; 680 	tempSL=36000L/(signed long)ee_Umax;
3719  0540 ce0014        	ldw	x,_ee_Umax
3720  0543 cd0000        	call	c_itolx
3722  0546 96            	ldw	x,sp
3723  0547 1c0001        	addw	x,#OFST-13
3724  054a cd0000        	call	c_rtol
3726  054d ae8ca0        	ldw	x,#36000
3727  0550 bf02          	ldw	c_lreg+2,x
3728  0552 ae0000        	ldw	x,#0
3729  0555 bf00          	ldw	c_lreg,x
3730  0557 96            	ldw	x,sp
3731  0558 1c0001        	addw	x,#OFST-13
3732  055b cd0000        	call	c_ldiv
3734  055e 96            	ldw	x,sp
3735  055f 1c000b        	addw	x,#OFST-3
3736  0562 cd0000        	call	c_rtol
3738                     ; 681 	tempSL=(signed long)I/tempSL;
3740  0565 ce0010        	ldw	x,_I
3741  0568 cd0000        	call	c_itolx
3743  056b 96            	ldw	x,sp
3744  056c 1c000b        	addw	x,#OFST-3
3745  056f cd0000        	call	c_ldiv
3747  0572 96            	ldw	x,sp
3748  0573 1c000b        	addw	x,#OFST-3
3749  0576 cd0000        	call	c_rtol
3751                     ; 686 	if(ee_DEVICE==1) tempSL=(signed long)(I/ee_IMAXVENT);
3753  0579 ce0004        	ldw	x,_ee_DEVICE
3754  057c a30001        	cpw	x,#1
3755  057f 2614          	jrne	L3012
3758  0581 ce0010        	ldw	x,_I
3759  0584 90ce0002      	ldw	y,_ee_IMAXVENT
3760  0588 cd0000        	call	c_idiv
3762  058b cd0000        	call	c_itolx
3764  058e 96            	ldw	x,sp
3765  058f 1c000b        	addw	x,#OFST-3
3766  0592 cd0000        	call	c_rtol
3768  0595               L3012:
3769                     ; 688 	if(tempSL>10)vent_pwm_i_necc=1000;
3771  0595 9c            	rvf
3772  0596 96            	ldw	x,sp
3773  0597 1c000b        	addw	x,#OFST-3
3774  059a cd0000        	call	c_ltor
3776  059d ae0004        	ldw	x,#L63
3777  05a0 cd0000        	call	c_lcmp
3779  05a3 2f07          	jrslt	L5012
3782  05a5 ae03e8        	ldw	x,#1000
3783  05a8 1f07          	ldw	(OFST-7,sp),x
3785  05aa 2023          	jra	L7012
3786  05ac               L5012:
3787                     ; 689 	else if(tempSL<1)vent_pwm_i_necc=0;
3789  05ac 9c            	rvf
3790  05ad 96            	ldw	x,sp
3791  05ae 1c000b        	addw	x,#OFST-3
3792  05b1 cd0000        	call	c_ltor
3794  05b4 ae0008        	ldw	x,#L04
3795  05b7 cd0000        	call	c_lcmp
3797  05ba 2e05          	jrsge	L1112
3800  05bc 5f            	clrw	x
3801  05bd 1f07          	ldw	(OFST-7,sp),x
3803  05bf 200e          	jra	L7012
3804  05c1               L1112:
3805                     ; 690 	else vent_pwm_i_necc=(short)(400L + (tempSL*60L));
3807  05c1 1e0d          	ldw	x,(OFST-1,sp)
3808  05c3 90ae003c      	ldw	y,#60
3809  05c7 cd0000        	call	c_imul
3811  05ca 1c0190        	addw	x,#400
3812  05cd 1f07          	ldw	(OFST-7,sp),x
3813  05cf               L7012:
3814                     ; 691 	gran(&vent_pwm_i_necc,0,1000);
3816  05cf ae03e8        	ldw	x,#1000
3817  05d2 89            	pushw	x
3818  05d3 5f            	clrw	x
3819  05d4 89            	pushw	x
3820  05d5 96            	ldw	x,sp
3821  05d6 1c000b        	addw	x,#OFST-3
3822  05d9 cd00d5        	call	_gran
3824  05dc 5b04          	addw	sp,#4
3825                     ; 693 	tempSL=(signed long)T;
3827  05de b66e          	ld	a,_T
3828  05e0 b703          	ld	c_lreg+3,a
3829  05e2 48            	sll	a
3830  05e3 4f            	clr	a
3831  05e4 a200          	sbc	a,#0
3832  05e6 b702          	ld	c_lreg+2,a
3833  05e8 b701          	ld	c_lreg+1,a
3834  05ea b700          	ld	c_lreg,a
3835  05ec 96            	ldw	x,sp
3836  05ed 1c000b        	addw	x,#OFST-3
3837  05f0 cd0000        	call	c_rtol
3839                     ; 694 	if(tempSL<=(ee_tsign-30L))vent_pwm_t_necc=0;
3841  05f3 9c            	rvf
3842  05f4 ce000e        	ldw	x,_ee_tsign
3843  05f7 cd0000        	call	c_itolx
3845  05fa a61e          	ld	a,#30
3846  05fc cd0000        	call	c_lsbc
3848  05ff 96            	ldw	x,sp
3849  0600 1c000b        	addw	x,#OFST-3
3850  0603 cd0000        	call	c_lcmp
3852  0606 2f05          	jrslt	L5112
3855  0608 5f            	clrw	x
3856  0609 1f09          	ldw	(OFST-5,sp),x
3858  060b 2030          	jra	L7112
3859  060d               L5112:
3860                     ; 695 	else if(tempSL>=ee_tsign)vent_pwm_t_necc=1000;
3862  060d 9c            	rvf
3863  060e ce000e        	ldw	x,_ee_tsign
3864  0611 cd0000        	call	c_itolx
3866  0614 96            	ldw	x,sp
3867  0615 1c000b        	addw	x,#OFST-3
3868  0618 cd0000        	call	c_lcmp
3870  061b 2c07          	jrsgt	L1212
3873  061d ae03e8        	ldw	x,#1000
3874  0620 1f09          	ldw	(OFST-5,sp),x
3876  0622 2019          	jra	L7112
3877  0624               L1212:
3878                     ; 696 	else vent_pwm_t_necc=(short)(400L+(20L*(tempSL-(((signed long)ee_tsign)-30L))));
3880  0624 ce000e        	ldw	x,_ee_tsign
3881  0627 1d001e        	subw	x,#30
3882  062a 1f03          	ldw	(OFST-11,sp),x
3883  062c 1e0d          	ldw	x,(OFST-1,sp)
3884  062e 72f003        	subw	x,(OFST-11,sp)
3885  0631 90ae0014      	ldw	y,#20
3886  0635 cd0000        	call	c_imul
3888  0638 1c0190        	addw	x,#400
3889  063b 1f09          	ldw	(OFST-5,sp),x
3890  063d               L7112:
3891                     ; 697 	gran(&vent_pwm_t_necc,0,1000);
3893  063d ae03e8        	ldw	x,#1000
3894  0640 89            	pushw	x
3895  0641 5f            	clrw	x
3896  0642 89            	pushw	x
3897  0643 96            	ldw	x,sp
3898  0644 1c000d        	addw	x,#OFST-1
3899  0647 cd00d5        	call	_gran
3901  064a 5b04          	addw	sp,#4
3902                     ; 699 	vent_pwm_max_necc=vent_pwm_i_necc;
3904  064c 1e07          	ldw	x,(OFST-7,sp)
3905  064e 1f05          	ldw	(OFST-9,sp),x
3906                     ; 700 	if(vent_pwm_t_necc>vent_pwm_i_necc)vent_pwm_max_necc=vent_pwm_t_necc;
3908  0650 9c            	rvf
3909  0651 1e09          	ldw	x,(OFST-5,sp)
3910  0653 1307          	cpw	x,(OFST-7,sp)
3911  0655 2d04          	jrsle	L5212
3914  0657 1e09          	ldw	x,(OFST-5,sp)
3915  0659 1f05          	ldw	(OFST-9,sp),x
3916  065b               L5212:
3917                     ; 702 	if(vent_pwm<vent_pwm_max_necc)vent_pwm+=10;
3919  065b 9c            	rvf
3920  065c be0c          	ldw	x,_vent_pwm
3921  065e 1305          	cpw	x,(OFST-9,sp)
3922  0660 2e07          	jrsge	L7212
3925  0662 be0c          	ldw	x,_vent_pwm
3926  0664 1c000a        	addw	x,#10
3927  0667 bf0c          	ldw	_vent_pwm,x
3928  0669               L7212:
3929                     ; 703 	if(vent_pwm>vent_pwm_max_necc)vent_pwm-=10;
3931  0669 9c            	rvf
3932  066a be0c          	ldw	x,_vent_pwm
3933  066c 1305          	cpw	x,(OFST-9,sp)
3934  066e 2d07          	jrsle	L1312
3937  0670 be0c          	ldw	x,_vent_pwm
3938  0672 1d000a        	subw	x,#10
3939  0675 bf0c          	ldw	_vent_pwm,x
3940  0677               L1312:
3941                     ; 704 	gran(&vent_pwm,0,1000);
3943  0677 ae03e8        	ldw	x,#1000
3944  067a 89            	pushw	x
3945  067b 5f            	clrw	x
3946  067c 89            	pushw	x
3947  067d ae000c        	ldw	x,#_vent_pwm
3948  0680 cd00d5        	call	_gran
3950  0683 5b04          	addw	sp,#4
3951                     ; 709 }
3954  0685 5b0e          	addw	sp,#14
3955  0687 81            	ret
3982                     ; 714 void pwr_drv(void)
3982                     ; 715 {
3983                     	switch	.text
3984  0688               _pwr_drv:
3988                     ; 776 gran(&pwm_u,0,1020);
3990  0688 ae03fc        	ldw	x,#1020
3991  068b 89            	pushw	x
3992  068c 5f            	clrw	x
3993  068d 89            	pushw	x
3994  068e ae0008        	ldw	x,#_pwm_u
3995  0691 cd00d5        	call	_gran
3997  0694 5b04          	addw	sp,#4
3998                     ; 786 TIM1->CCR2H= (char)(pwm_u/256);	
4000  0696 be08          	ldw	x,_pwm_u
4001  0698 90ae0100      	ldw	y,#256
4002  069c cd0000        	call	c_idiv
4004  069f 9f            	ld	a,xl
4005  06a0 c75267        	ld	21095,a
4006                     ; 787 TIM1->CCR2L= (char)pwm_u;
4008  06a3 5500095268    	mov	21096,_pwm_u+1
4009                     ; 789 TIM1->CCR1H= (char)(pwm_i/256);	
4011  06a8 be0a          	ldw	x,_pwm_i
4012  06aa 90ae0100      	ldw	y,#256
4013  06ae cd0000        	call	c_idiv
4015  06b1 9f            	ld	a,xl
4016  06b2 c75265        	ld	21093,a
4017                     ; 790 TIM1->CCR1L= (char)pwm_i;
4019  06b5 55000b5266    	mov	21094,_pwm_i+1
4020                     ; 792 TIM1->CCR3H= (char)(vent_pwm/256);	
4022  06ba be0c          	ldw	x,_vent_pwm
4023  06bc 90ae0100      	ldw	y,#256
4024  06c0 cd0000        	call	c_idiv
4026  06c3 9f            	ld	a,xl
4027  06c4 c75269        	ld	21097,a
4028                     ; 793 TIM1->CCR3L= (char)vent_pwm;
4030  06c7 55000d526a    	mov	21098,_vent_pwm+1
4031                     ; 794 }
4034  06cc 81            	ret
4092                     	switch	.const
4093  000c               L64:
4094  000c 0000028a      	dc.l	650
4095                     ; 799 void pwr_hndl(void)				
4095                     ; 800 {
4096                     	switch	.text
4097  06cd               _pwr_hndl:
4099  06cd 5205          	subw	sp,#5
4100       00000005      OFST:	set	5
4103                     ; 801 if(jp_mode==jp3)
4105  06cf b650          	ld	a,_jp_mode
4106  06d1 a103          	cp	a,#3
4107  06d3 260a          	jrne	L5612
4108                     ; 803 	pwm_u=0;
4110  06d5 5f            	clrw	x
4111  06d6 bf08          	ldw	_pwm_u,x
4112                     ; 804 	pwm_i=0;
4114  06d8 5f            	clrw	x
4115  06d9 bf0a          	ldw	_pwm_i,x
4117  06db ac280828      	jpf	L7612
4118  06df               L5612:
4119                     ; 806 else if(jp_mode==jp2)
4121  06df b650          	ld	a,_jp_mode
4122  06e1 a102          	cp	a,#2
4123  06e3 260c          	jrne	L1712
4124                     ; 808 	pwm_u=0;
4126  06e5 5f            	clrw	x
4127  06e6 bf08          	ldw	_pwm_u,x
4128                     ; 809 	pwm_i=0x3ff;
4130  06e8 ae03ff        	ldw	x,#1023
4131  06eb bf0a          	ldw	_pwm_i,x
4133  06ed ac280828      	jpf	L7612
4134  06f1               L1712:
4135                     ; 811 else if(jp_mode==jp1)
4137  06f1 b650          	ld	a,_jp_mode
4138  06f3 a101          	cp	a,#1
4139  06f5 260e          	jrne	L5712
4140                     ; 813 	pwm_u=0x3ff;
4142  06f7 ae03ff        	ldw	x,#1023
4143  06fa bf08          	ldw	_pwm_u,x
4144                     ; 814 	pwm_i=0x3ff;
4146  06fc ae03ff        	ldw	x,#1023
4147  06ff bf0a          	ldw	_pwm_i,x
4149  0701 ac280828      	jpf	L7612
4150  0705               L5712:
4151                     ; 825 else if(link==OFF)
4153  0705 b669          	ld	a,_link
4154  0707 a1aa          	cp	a,#170
4155  0709 2703          	jreq	L05
4156  070b cc07b0        	jp	L1022
4157  070e               L05:
4158                     ; 827 	pwm_i=0x3ff;
4160  070e ae03ff        	ldw	x,#1023
4161  0711 bf0a          	ldw	_pwm_i,x
4162                     ; 828 	pwm_u_=(short)((1000L*((long)Unecc))/650L);
4164  0713 ce000a        	ldw	x,_Unecc
4165  0716 90ae03e8      	ldw	y,#1000
4166  071a cd0000        	call	c_vmul
4168  071d ae000c        	ldw	x,#L64
4169  0720 cd0000        	call	c_ldiv
4171  0723 be02          	ldw	x,c_lreg+2
4172  0725 bf51          	ldw	_pwm_u_,x
4173                     ; 830 	pwm_u_buff[pwm_u_buff_ptr]=pwm_u_;
4175  0727 c60013        	ld	a,_pwm_u_buff_ptr
4176  072a 5f            	clrw	x
4177  072b 97            	ld	xl,a
4178  072c 58            	sllw	x
4179  072d 90be51        	ldw	y,_pwm_u_
4180  0730 df0016        	ldw	(_pwm_u_buff,x),y
4181                     ; 831 	pwm_u_buff_ptr++;
4183  0733 725c0013      	inc	_pwm_u_buff_ptr
4184                     ; 832 	if(pwm_u_buff_ptr>=16)pwm_u_buff_ptr=0;
4186  0737 c60013        	ld	a,_pwm_u_buff_ptr
4187  073a a110          	cp	a,#16
4188  073c 2504          	jrult	L3022
4191  073e 725f0013      	clr	_pwm_u_buff_ptr
4192  0742               L3022:
4193                     ; 836 		tempSL=0;
4195  0742 ae0000        	ldw	x,#0
4196  0745 1f03          	ldw	(OFST-2,sp),x
4197  0747 ae0000        	ldw	x,#0
4198  074a 1f01          	ldw	(OFST-4,sp),x
4199                     ; 837 		for(i=0;i<16;i++)
4201  074c 0f05          	clr	(OFST+0,sp)
4202  074e               L5022:
4203                     ; 839 			tempSL+=(signed long)pwm_u_buff[i];
4205  074e 7b05          	ld	a,(OFST+0,sp)
4206  0750 5f            	clrw	x
4207  0751 97            	ld	xl,a
4208  0752 58            	sllw	x
4209  0753 de0016        	ldw	x,(_pwm_u_buff,x)
4210  0756 cd0000        	call	c_itolx
4212  0759 96            	ldw	x,sp
4213  075a 1c0001        	addw	x,#OFST-4
4214  075d cd0000        	call	c_lgadd
4216                     ; 837 		for(i=0;i<16;i++)
4218  0760 0c05          	inc	(OFST+0,sp)
4221  0762 7b05          	ld	a,(OFST+0,sp)
4222  0764 a110          	cp	a,#16
4223  0766 25e6          	jrult	L5022
4224                     ; 841 		tempSL>>=4;
4226  0768 96            	ldw	x,sp
4227  0769 1c0001        	addw	x,#OFST-4
4228  076c a604          	ld	a,#4
4229  076e cd0000        	call	c_lgrsh
4231                     ; 842 		pwm_u_buff_=(signed short)tempSL;
4233  0771 1e03          	ldw	x,(OFST-2,sp)
4234  0773 cf0014        	ldw	_pwm_u_buff_,x
4235                     ; 844 	pwm_u=pwm_u_;
4237  0776 be51          	ldw	x,_pwm_u_
4238  0778 bf08          	ldw	_pwm_u,x
4239                     ; 845 	if((abs((int)(Ui-Unecc)))<20)pwm_u_buff_cnt++;
4241  077a 9c            	rvf
4242  077b ce000c        	ldw	x,_Ui
4243  077e 72b0000a      	subw	x,_Unecc
4244  0782 cd0000        	call	_abs
4246  0785 a30014        	cpw	x,#20
4247  0788 2e06          	jrsge	L3122
4250  078a 725c0012      	inc	_pwm_u_buff_cnt
4252  078e 2004          	jra	L5122
4253  0790               L3122:
4254                     ; 846 	else pwm_u_buff_cnt=0;
4256  0790 725f0012      	clr	_pwm_u_buff_cnt
4257  0794               L5122:
4258                     ; 848 	if(pwm_u_buff_cnt>=20)pwm_u_buff_cnt=20;
4260  0794 c60012        	ld	a,_pwm_u_buff_cnt
4261  0797 a114          	cp	a,#20
4262  0799 2504          	jrult	L7122
4265  079b 35140012      	mov	_pwm_u_buff_cnt,#20
4266  079f               L7122:
4267                     ; 849 	if(pwm_u_buff_cnt>=15)pwm_u=pwm_u_buff_;
4269  079f c60012        	ld	a,_pwm_u_buff_cnt
4270  07a2 a10f          	cp	a,#15
4271  07a4 2403          	jruge	L25
4272  07a6 cc0828        	jp	L7612
4273  07a9               L25:
4276  07a9 ce0014        	ldw	x,_pwm_u_buff_
4277  07ac bf08          	ldw	_pwm_u,x
4278  07ae 2078          	jra	L7612
4279  07b0               L1022:
4280                     ; 852 else	if(link==ON)				//если есть связьvol_i_temp_avar
4282  07b0 b669          	ld	a,_link
4283  07b2 a155          	cp	a,#85
4284  07b4 2672          	jrne	L7612
4285                     ; 854 	if((flags&0b00100000)==0)	//если нет блокировки извне
4287  07b6 b605          	ld	a,_flags
4288  07b8 a520          	bcp	a,#32
4289  07ba 2660          	jrne	L7222
4290                     ; 856 		if(((flags&0b00011010)==0b00000000)) 	//если нет аварий или если они заблокированы
4292  07bc b605          	ld	a,_flags
4293  07be a51a          	bcp	a,#26
4294  07c0 260b          	jrne	L1322
4295                     ; 858 			pwm_u=vol_i_temp;					//управление от укушки + выравнивание токов
4297  07c2 be5c          	ldw	x,_vol_i_temp
4298  07c4 bf08          	ldw	_pwm_u,x
4299                     ; 859 			pwm_i=1000;
4301  07c6 ae03e8        	ldw	x,#1000
4302  07c9 bf0a          	ldw	_pwm_i,x
4304  07cb 200c          	jra	L3322
4305  07cd               L1322:
4306                     ; 861 		else if(flags&0b00011010)					//если есть аварии
4308  07cd b605          	ld	a,_flags
4309  07cf a51a          	bcp	a,#26
4310  07d1 2706          	jreq	L3322
4311                     ; 863 			pwm_u=0;								//то полный стоп
4313  07d3 5f            	clrw	x
4314  07d4 bf08          	ldw	_pwm_u,x
4315                     ; 864 			pwm_i=0;
4317  07d6 5f            	clrw	x
4318  07d7 bf0a          	ldw	_pwm_i,x
4319  07d9               L3322:
4320                     ; 867 		if(vol_i_temp==1000)
4322  07d9 be5c          	ldw	x,_vol_i_temp
4323  07db a303e8        	cpw	x,#1000
4324  07de 260c          	jrne	L7322
4325                     ; 869 			pwm_u=1000;
4327  07e0 ae03e8        	ldw	x,#1000
4328  07e3 bf08          	ldw	_pwm_u,x
4329                     ; 870 			pwm_i=1000;
4331  07e5 ae03e8        	ldw	x,#1000
4332  07e8 bf0a          	ldw	_pwm_i,x
4334  07ea 2014          	jra	L1422
4335  07ec               L7322:
4336                     ; 874 			if((abs((int)(Ui-Unecc)))>50)	pwm_u_cnt=19;
4338  07ec 9c            	rvf
4339  07ed ce000c        	ldw	x,_Ui
4340  07f0 72b0000a      	subw	x,_Unecc
4341  07f4 cd0000        	call	_abs
4343  07f7 a30033        	cpw	x,#51
4344  07fa 2f04          	jrslt	L1422
4347  07fc 35130007      	mov	_pwm_u_cnt,#19
4348  0800               L1422:
4349                     ; 877 		if(pwm_u_cnt)
4351  0800 3d07          	tnz	_pwm_u_cnt
4352  0802 2724          	jreq	L7612
4353                     ; 879 			pwm_u_cnt--;
4355  0804 3a07          	dec	_pwm_u_cnt
4356                     ; 880 			pwm_u=(short)((1000L*((long)Unecc))/650L);
4358  0806 ce000a        	ldw	x,_Unecc
4359  0809 90ae03e8      	ldw	y,#1000
4360  080d cd0000        	call	c_vmul
4362  0810 ae000c        	ldw	x,#L64
4363  0813 cd0000        	call	c_ldiv
4365  0816 be02          	ldw	x,c_lreg+2
4366  0818 bf08          	ldw	_pwm_u,x
4367  081a 200c          	jra	L7612
4368  081c               L7222:
4369                     ; 883 	else if(flags&0b00100000)	//если заблокирован извне то полное выключение
4371  081c b605          	ld	a,_flags
4372  081e a520          	bcp	a,#32
4373  0820 2706          	jreq	L7612
4374                     ; 885 		pwm_u=0;
4376  0822 5f            	clrw	x
4377  0823 bf08          	ldw	_pwm_u,x
4378                     ; 886 		pwm_i=0;
4380  0825 5f            	clrw	x
4381  0826 bf0a          	ldw	_pwm_i,x
4382  0828               L7612:
4383                     ; 914 if(pwm_u>1000)pwm_u=1000;
4385  0828 9c            	rvf
4386  0829 be08          	ldw	x,_pwm_u
4387  082b a303e9        	cpw	x,#1001
4388  082e 2f05          	jrslt	L3522
4391  0830 ae03e8        	ldw	x,#1000
4392  0833 bf08          	ldw	_pwm_u,x
4393  0835               L3522:
4394                     ; 915 if(pwm_i>1000)pwm_i=1000;
4396  0835 9c            	rvf
4397  0836 be0a          	ldw	x,_pwm_i
4398  0838 a303e9        	cpw	x,#1001
4399  083b 2f05          	jrslt	L5522
4402  083d ae03e8        	ldw	x,#1000
4403  0840 bf0a          	ldw	_pwm_i,x
4404  0842               L5522:
4405                     ; 918 }
4408  0842 5b05          	addw	sp,#5
4409  0844 81            	ret
4462                     	switch	.const
4463  0010               L65:
4464  0010 00000258      	dc.l	600
4465  0014               L06:
4466  0014 000003e8      	dc.l	1000
4467  0018               L26:
4468  0018 00000708      	dc.l	1800
4469                     ; 921 void matemat(void)
4469                     ; 922 {
4470                     	switch	.text
4471  0845               _matemat:
4473  0845 5208          	subw	sp,#8
4474       00000008      OFST:	set	8
4477                     ; 946 I=adc_buff_[4];
4479  0847 ce0107        	ldw	x,_adc_buff_+8
4480  084a cf0010        	ldw	_I,x
4481                     ; 947 temp_SL=adc_buff_[4];
4483  084d ce0107        	ldw	x,_adc_buff_+8
4484  0850 cd0000        	call	c_itolx
4486  0853 96            	ldw	x,sp
4487  0854 1c0005        	addw	x,#OFST-3
4488  0857 cd0000        	call	c_rtol
4490                     ; 948 temp_SL-=ee_K[0][0];
4492  085a ce001a        	ldw	x,_ee_K
4493  085d cd0000        	call	c_itolx
4495  0860 96            	ldw	x,sp
4496  0861 1c0005        	addw	x,#OFST-3
4497  0864 cd0000        	call	c_lgsub
4499                     ; 949 if(temp_SL<0) temp_SL=0;
4501  0867 9c            	rvf
4502  0868 0d05          	tnz	(OFST-3,sp)
4503  086a 2e0a          	jrsge	L5722
4506  086c ae0000        	ldw	x,#0
4507  086f 1f07          	ldw	(OFST-1,sp),x
4508  0871 ae0000        	ldw	x,#0
4509  0874 1f05          	ldw	(OFST-3,sp),x
4510  0876               L5722:
4511                     ; 950 temp_SL*=ee_K[0][1];
4513  0876 ce001c        	ldw	x,_ee_K+2
4514  0879 cd0000        	call	c_itolx
4516  087c 96            	ldw	x,sp
4517  087d 1c0005        	addw	x,#OFST-3
4518  0880 cd0000        	call	c_lgmul
4520                     ; 951 temp_SL/=600;
4522  0883 96            	ldw	x,sp
4523  0884 1c0005        	addw	x,#OFST-3
4524  0887 cd0000        	call	c_ltor
4526  088a ae0010        	ldw	x,#L65
4527  088d cd0000        	call	c_ldiv
4529  0890 96            	ldw	x,sp
4530  0891 1c0005        	addw	x,#OFST-3
4531  0894 cd0000        	call	c_rtol
4533                     ; 952 I=(signed short)temp_SL;
4535  0897 1e07          	ldw	x,(OFST-1,sp)
4536  0899 cf0010        	ldw	_I,x
4537                     ; 955 temp_SL=(signed long)adc_buff_[1];//1;
4539                     ; 956 temp_SL=(signed long)adc_buff_[3];//1;
4541  089c ce0105        	ldw	x,_adc_buff_+6
4542  089f cd0000        	call	c_itolx
4544  08a2 96            	ldw	x,sp
4545  08a3 1c0005        	addw	x,#OFST-3
4546  08a6 cd0000        	call	c_rtol
4548                     ; 958 if(temp_SL<0) temp_SL=0;
4550  08a9 9c            	rvf
4551  08aa 0d05          	tnz	(OFST-3,sp)
4552  08ac 2e0a          	jrsge	L7722
4555  08ae ae0000        	ldw	x,#0
4556  08b1 1f07          	ldw	(OFST-1,sp),x
4557  08b3 ae0000        	ldw	x,#0
4558  08b6 1f05          	ldw	(OFST-3,sp),x
4559  08b8               L7722:
4560                     ; 959 temp_SL*=(signed long)ee_K[2][1];
4562  08b8 ce0024        	ldw	x,_ee_K+10
4563  08bb cd0000        	call	c_itolx
4565  08be 96            	ldw	x,sp
4566  08bf 1c0005        	addw	x,#OFST-3
4567  08c2 cd0000        	call	c_lgmul
4569                     ; 960 temp_SL/=1000L;
4571  08c5 96            	ldw	x,sp
4572  08c6 1c0005        	addw	x,#OFST-3
4573  08c9 cd0000        	call	c_ltor
4575  08cc ae0014        	ldw	x,#L06
4576  08cf cd0000        	call	c_ldiv
4578  08d2 96            	ldw	x,sp
4579  08d3 1c0005        	addw	x,#OFST-3
4580  08d6 cd0000        	call	c_rtol
4582                     ; 961 Ui=(unsigned short)temp_SL;
4584  08d9 1e07          	ldw	x,(OFST-1,sp)
4585  08db cf000c        	ldw	_Ui,x
4586                     ; 963 temp_SL=(signed long)adc_buff_5;
4588  08de ce00fd        	ldw	x,_adc_buff_5
4589  08e1 cd0000        	call	c_itolx
4591  08e4 96            	ldw	x,sp
4592  08e5 1c0005        	addw	x,#OFST-3
4593  08e8 cd0000        	call	c_rtol
4595                     ; 965 if(temp_SL<0) temp_SL=0;
4597  08eb 9c            	rvf
4598  08ec 0d05          	tnz	(OFST-3,sp)
4599  08ee 2e0a          	jrsge	L1032
4602  08f0 ae0000        	ldw	x,#0
4603  08f3 1f07          	ldw	(OFST-1,sp),x
4604  08f5 ae0000        	ldw	x,#0
4605  08f8 1f05          	ldw	(OFST-3,sp),x
4606  08fa               L1032:
4607                     ; 966 temp_SL*=(signed long)ee_K[4][1];
4609  08fa ce002c        	ldw	x,_ee_K+18
4610  08fd cd0000        	call	c_itolx
4612  0900 96            	ldw	x,sp
4613  0901 1c0005        	addw	x,#OFST-3
4614  0904 cd0000        	call	c_lgmul
4616                     ; 967 temp_SL/=1000L;
4618  0907 96            	ldw	x,sp
4619  0908 1c0005        	addw	x,#OFST-3
4620  090b cd0000        	call	c_ltor
4622  090e ae0014        	ldw	x,#L06
4623  0911 cd0000        	call	c_ldiv
4625  0914 96            	ldw	x,sp
4626  0915 1c0005        	addw	x,#OFST-3
4627  0918 cd0000        	call	c_rtol
4629                     ; 968 Usum=(unsigned short)temp_SL;
4631  091b 1e07          	ldw	x,(OFST-1,sp)
4632  091d cf0006        	ldw	_Usum,x
4633                     ; 972 temp_SL=adc_buff_[3];
4635  0920 ce0105        	ldw	x,_adc_buff_+6
4636  0923 cd0000        	call	c_itolx
4638  0926 96            	ldw	x,sp
4639  0927 1c0005        	addw	x,#OFST-3
4640  092a cd0000        	call	c_rtol
4642                     ; 974 if(temp_SL<0) temp_SL=0;
4644  092d 9c            	rvf
4645  092e 0d05          	tnz	(OFST-3,sp)
4646  0930 2e0a          	jrsge	L3032
4649  0932 ae0000        	ldw	x,#0
4650  0935 1f07          	ldw	(OFST-1,sp),x
4651  0937 ae0000        	ldw	x,#0
4652  093a 1f05          	ldw	(OFST-3,sp),x
4653  093c               L3032:
4654                     ; 975 temp_SL*=ee_K[1][1];
4656  093c ce0020        	ldw	x,_ee_K+6
4657  093f cd0000        	call	c_itolx
4659  0942 96            	ldw	x,sp
4660  0943 1c0005        	addw	x,#OFST-3
4661  0946 cd0000        	call	c_lgmul
4663                     ; 976 temp_SL/=1800;
4665  0949 96            	ldw	x,sp
4666  094a 1c0005        	addw	x,#OFST-3
4667  094d cd0000        	call	c_ltor
4669  0950 ae0018        	ldw	x,#L26
4670  0953 cd0000        	call	c_ldiv
4672  0956 96            	ldw	x,sp
4673  0957 1c0005        	addw	x,#OFST-3
4674  095a cd0000        	call	c_rtol
4676                     ; 977 Un=(unsigned short)temp_SL;
4678  095d 1e07          	ldw	x,(OFST-1,sp)
4679  095f cf000e        	ldw	_Un,x
4680                     ; 982 temp_SL=adc_buff_[2];
4682  0962 ce0103        	ldw	x,_adc_buff_+4
4683  0965 cd0000        	call	c_itolx
4685  0968 96            	ldw	x,sp
4686  0969 1c0005        	addw	x,#OFST-3
4687  096c cd0000        	call	c_rtol
4689                     ; 983 temp_SL*=ee_K[3][1];
4691  096f ce0028        	ldw	x,_ee_K+14
4692  0972 cd0000        	call	c_itolx
4694  0975 96            	ldw	x,sp
4695  0976 1c0005        	addw	x,#OFST-3
4696  0979 cd0000        	call	c_lgmul
4698                     ; 984 temp_SL/=1000;
4700  097c 96            	ldw	x,sp
4701  097d 1c0005        	addw	x,#OFST-3
4702  0980 cd0000        	call	c_ltor
4704  0983 ae0014        	ldw	x,#L06
4705  0986 cd0000        	call	c_ldiv
4707  0989 96            	ldw	x,sp
4708  098a 1c0005        	addw	x,#OFST-3
4709  098d cd0000        	call	c_rtol
4711                     ; 985 T=(signed short)(temp_SL-273L);
4713  0990 7b08          	ld	a,(OFST+0,sp)
4714  0992 5f            	clrw	x
4715  0993 4d            	tnz	a
4716  0994 2a01          	jrpl	L46
4717  0996 53            	cplw	x
4718  0997               L46:
4719  0997 97            	ld	xl,a
4720  0998 1d0111        	subw	x,#273
4721  099b 01            	rrwa	x,a
4722  099c b76e          	ld	_T,a
4723  099e 02            	rlwa	x,a
4724                     ; 986 if(T<-30)T=-30;
4726  099f 9c            	rvf
4727  09a0 b66e          	ld	a,_T
4728  09a2 a1e2          	cp	a,#226
4729  09a4 2e04          	jrsge	L5032
4732  09a6 35e2006e      	mov	_T,#226
4733  09aa               L5032:
4734                     ; 987 if(T>120)T=120;
4736  09aa 9c            	rvf
4737  09ab b66e          	ld	a,_T
4738  09ad a179          	cp	a,#121
4739  09af 2f04          	jrslt	L7032
4742  09b1 3578006e      	mov	_T,#120
4743  09b5               L7032:
4744                     ; 991 Uin=Usum-Ui;
4746  09b5 ce0006        	ldw	x,_Usum
4747  09b8 72b0000c      	subw	x,_Ui
4748  09bc cf0004        	ldw	_Uin,x
4749                     ; 992 if(link==ON)
4751  09bf b669          	ld	a,_link
4752  09c1 a155          	cp	a,#85
4753  09c3 260c          	jrne	L1132
4754                     ; 994 	Unecc=U_out_const-Uin;
4756  09c5 ce0008        	ldw	x,_U_out_const
4757  09c8 72b00004      	subw	x,_Uin
4758  09cc cf000a        	ldw	_Unecc,x
4760  09cf 200a          	jra	L3132
4761  09d1               L1132:
4762                     ; 1003 else Unecc=ee_UAVT-Uin;
4764  09d1 ce000c        	ldw	x,_ee_UAVT
4765  09d4 72b00004      	subw	x,_Uin
4766  09d8 cf000a        	ldw	_Unecc,x
4767  09db               L3132:
4768                     ; 1012 temp_SL=(signed long)(T-ee_tsign);
4770  09db 5f            	clrw	x
4771  09dc b66e          	ld	a,_T
4772  09de 2a01          	jrpl	L66
4773  09e0 53            	cplw	x
4774  09e1               L66:
4775  09e1 97            	ld	xl,a
4776  09e2 72b0000e      	subw	x,_ee_tsign
4777  09e6 cd0000        	call	c_itolx
4779  09e9 96            	ldw	x,sp
4780  09ea 1c0005        	addw	x,#OFST-3
4781  09ed cd0000        	call	c_rtol
4783                     ; 1013 temp_SL*=1000L;
4785  09f0 ae03e8        	ldw	x,#1000
4786  09f3 bf02          	ldw	c_lreg+2,x
4787  09f5 ae0000        	ldw	x,#0
4788  09f8 bf00          	ldw	c_lreg,x
4789  09fa 96            	ldw	x,sp
4790  09fb 1c0005        	addw	x,#OFST-3
4791  09fe cd0000        	call	c_lgmul
4793                     ; 1014 temp_SL/=(signed long)(ee_tmax-ee_tsign);
4795  0a01 ce0010        	ldw	x,_ee_tmax
4796  0a04 72b0000e      	subw	x,_ee_tsign
4797  0a08 cd0000        	call	c_itolx
4799  0a0b 96            	ldw	x,sp
4800  0a0c 1c0001        	addw	x,#OFST-7
4801  0a0f cd0000        	call	c_rtol
4803  0a12 96            	ldw	x,sp
4804  0a13 1c0005        	addw	x,#OFST-3
4805  0a16 cd0000        	call	c_ltor
4807  0a19 96            	ldw	x,sp
4808  0a1a 1c0001        	addw	x,#OFST-7
4809  0a1d cd0000        	call	c_ldiv
4811  0a20 96            	ldw	x,sp
4812  0a21 1c0005        	addw	x,#OFST-3
4813  0a24 cd0000        	call	c_rtol
4815                     ; 1016 vol_i_temp_avar=(unsigned short)temp_SL; 
4817  0a27 1e07          	ldw	x,(OFST-1,sp)
4818  0a29 bf06          	ldw	_vol_i_temp_avar,x
4819                     ; 1018 debug_info_to_uku[0]=pwm_u;
4821  0a2b be08          	ldw	x,_pwm_u
4822  0a2d bf01          	ldw	_debug_info_to_uku,x
4823                     ; 1019 debug_info_to_uku[1]=vol_i_temp;
4825  0a2f be5c          	ldw	x,_vol_i_temp
4826  0a31 bf03          	ldw	_debug_info_to_uku+2,x
4827                     ; 1021 }
4830  0a33 5b08          	addw	sp,#8
4831  0a35 81            	ret
4862                     ; 1024 void temper_drv(void)		//1 Hz
4862                     ; 1025 {
4863                     	switch	.text
4864  0a36               _temper_drv:
4868                     ; 1027 if(T>ee_tsign) tsign_cnt++;
4870  0a36 9c            	rvf
4871  0a37 5f            	clrw	x
4872  0a38 b66e          	ld	a,_T
4873  0a3a 2a01          	jrpl	L27
4874  0a3c 53            	cplw	x
4875  0a3d               L27:
4876  0a3d 97            	ld	xl,a
4877  0a3e c3000e        	cpw	x,_ee_tsign
4878  0a41 2d09          	jrsle	L5232
4881  0a43 be55          	ldw	x,_tsign_cnt
4882  0a45 1c0001        	addw	x,#1
4883  0a48 bf55          	ldw	_tsign_cnt,x
4885  0a4a 201d          	jra	L7232
4886  0a4c               L5232:
4887                     ; 1028 else if (T<(ee_tsign-1)) tsign_cnt--;
4889  0a4c 9c            	rvf
4890  0a4d ce000e        	ldw	x,_ee_tsign
4891  0a50 5a            	decw	x
4892  0a51 905f          	clrw	y
4893  0a53 b66e          	ld	a,_T
4894  0a55 2a02          	jrpl	L47
4895  0a57 9053          	cplw	y
4896  0a59               L47:
4897  0a59 9097          	ld	yl,a
4898  0a5b 90bf00        	ldw	c_y,y
4899  0a5e b300          	cpw	x,c_y
4900  0a60 2d07          	jrsle	L7232
4903  0a62 be55          	ldw	x,_tsign_cnt
4904  0a64 1d0001        	subw	x,#1
4905  0a67 bf55          	ldw	_tsign_cnt,x
4906  0a69               L7232:
4907                     ; 1030 gran(&tsign_cnt,0,60);
4909  0a69 ae003c        	ldw	x,#60
4910  0a6c 89            	pushw	x
4911  0a6d 5f            	clrw	x
4912  0a6e 89            	pushw	x
4913  0a6f ae0055        	ldw	x,#_tsign_cnt
4914  0a72 cd00d5        	call	_gran
4916  0a75 5b04          	addw	sp,#4
4917                     ; 1032 if(tsign_cnt>=55)
4919  0a77 9c            	rvf
4920  0a78 be55          	ldw	x,_tsign_cnt
4921  0a7a a30037        	cpw	x,#55
4922  0a7d 2f16          	jrslt	L3332
4923                     ; 1034 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000100; //поднять бит подогрева 
4925  0a7f 3d50          	tnz	_jp_mode
4926  0a81 2606          	jrne	L1432
4928  0a83 b605          	ld	a,_flags
4929  0a85 a540          	bcp	a,#64
4930  0a87 2706          	jreq	L7332
4931  0a89               L1432:
4933  0a89 b650          	ld	a,_jp_mode
4934  0a8b a103          	cp	a,#3
4935  0a8d 2612          	jrne	L3432
4936  0a8f               L7332:
4939  0a8f 72140005      	bset	_flags,#2
4940  0a93 200c          	jra	L3432
4941  0a95               L3332:
4942                     ; 1036 else if (tsign_cnt<=5) flags&=0b11111011;	//Сбросить бит подогрева
4944  0a95 9c            	rvf
4945  0a96 be55          	ldw	x,_tsign_cnt
4946  0a98 a30006        	cpw	x,#6
4947  0a9b 2e04          	jrsge	L3432
4950  0a9d 72150005      	bres	_flags,#2
4951  0aa1               L3432:
4952                     ; 1041 if(T>ee_tmax) tmax_cnt++;
4954  0aa1 9c            	rvf
4955  0aa2 5f            	clrw	x
4956  0aa3 b66e          	ld	a,_T
4957  0aa5 2a01          	jrpl	L67
4958  0aa7 53            	cplw	x
4959  0aa8               L67:
4960  0aa8 97            	ld	xl,a
4961  0aa9 c30010        	cpw	x,_ee_tmax
4962  0aac 2d09          	jrsle	L7432
4965  0aae be53          	ldw	x,_tmax_cnt
4966  0ab0 1c0001        	addw	x,#1
4967  0ab3 bf53          	ldw	_tmax_cnt,x
4969  0ab5 201d          	jra	L1532
4970  0ab7               L7432:
4971                     ; 1042 else if (T<(ee_tmax-1)) tmax_cnt--;
4973  0ab7 9c            	rvf
4974  0ab8 ce0010        	ldw	x,_ee_tmax
4975  0abb 5a            	decw	x
4976  0abc 905f          	clrw	y
4977  0abe b66e          	ld	a,_T
4978  0ac0 2a02          	jrpl	L001
4979  0ac2 9053          	cplw	y
4980  0ac4               L001:
4981  0ac4 9097          	ld	yl,a
4982  0ac6 90bf00        	ldw	c_y,y
4983  0ac9 b300          	cpw	x,c_y
4984  0acb 2d07          	jrsle	L1532
4987  0acd be53          	ldw	x,_tmax_cnt
4988  0acf 1d0001        	subw	x,#1
4989  0ad2 bf53          	ldw	_tmax_cnt,x
4990  0ad4               L1532:
4991                     ; 1044 gran(&tmax_cnt,0,60);
4993  0ad4 ae003c        	ldw	x,#60
4994  0ad7 89            	pushw	x
4995  0ad8 5f            	clrw	x
4996  0ad9 89            	pushw	x
4997  0ada ae0053        	ldw	x,#_tmax_cnt
4998  0add cd00d5        	call	_gran
5000  0ae0 5b04          	addw	sp,#4
5001                     ; 1046 if(tmax_cnt>=55)
5003  0ae2 9c            	rvf
5004  0ae3 be53          	ldw	x,_tmax_cnt
5005  0ae5 a30037        	cpw	x,#55
5006  0ae8 2f16          	jrslt	L5532
5007                     ; 1048 	if(((jp_mode==jp0)&&!(flags&0b01000000))||(jp_mode==jp3))	flags|=0b00000010;
5009  0aea 3d50          	tnz	_jp_mode
5010  0aec 2606          	jrne	L3632
5012  0aee b605          	ld	a,_flags
5013  0af0 a540          	bcp	a,#64
5014  0af2 2706          	jreq	L1632
5015  0af4               L3632:
5017  0af4 b650          	ld	a,_jp_mode
5018  0af6 a103          	cp	a,#3
5019  0af8 2612          	jrne	L5632
5020  0afa               L1632:
5023  0afa 72120005      	bset	_flags,#1
5024  0afe 200c          	jra	L5632
5025  0b00               L5532:
5026                     ; 1050 else if (tmax_cnt<=5) flags&=0b11111101;
5028  0b00 9c            	rvf
5029  0b01 be53          	ldw	x,_tmax_cnt
5030  0b03 a30006        	cpw	x,#6
5031  0b06 2e04          	jrsge	L5632
5034  0b08 72130005      	bres	_flags,#1
5035  0b0c               L5632:
5036                     ; 1053 } 
5039  0b0c 81            	ret
5071                     ; 1056 void u_drv(void)		//1Hz
5071                     ; 1057 { 
5072                     	switch	.text
5073  0b0d               _u_drv:
5077                     ; 1058 if(jp_mode!=jp3)
5079  0b0d b650          	ld	a,_jp_mode
5080  0b0f a103          	cp	a,#3
5081  0b11 2774          	jreq	L1042
5082                     ; 1060 	if(Ui>ee_Umax)umax_cnt++;
5084  0b13 9c            	rvf
5085  0b14 ce000c        	ldw	x,_Ui
5086  0b17 c30014        	cpw	x,_ee_Umax
5087  0b1a 2d09          	jrsle	L3042
5090  0b1c be6c          	ldw	x,_umax_cnt
5091  0b1e 1c0001        	addw	x,#1
5092  0b21 bf6c          	ldw	_umax_cnt,x
5094  0b23 2003          	jra	L5042
5095  0b25               L3042:
5096                     ; 1061 	else umax_cnt=0;
5098  0b25 5f            	clrw	x
5099  0b26 bf6c          	ldw	_umax_cnt,x
5100  0b28               L5042:
5101                     ; 1062 	gran(&umax_cnt,0,10);
5103  0b28 ae000a        	ldw	x,#10
5104  0b2b 89            	pushw	x
5105  0b2c 5f            	clrw	x
5106  0b2d 89            	pushw	x
5107  0b2e ae006c        	ldw	x,#_umax_cnt
5108  0b31 cd00d5        	call	_gran
5110  0b34 5b04          	addw	sp,#4
5111                     ; 1063 	if(umax_cnt>=10)flags|=0b00001000; 	//Поднять аварию по превышению напряжения
5113  0b36 9c            	rvf
5114  0b37 be6c          	ldw	x,_umax_cnt
5115  0b39 a3000a        	cpw	x,#10
5116  0b3c 2f04          	jrslt	L7042
5119  0b3e 72160005      	bset	_flags,#3
5120  0b42               L7042:
5121                     ; 1066 	if((Ui<Un)&&((Un-Ui)>ee_dU)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5123  0b42 9c            	rvf
5124  0b43 ce000c        	ldw	x,_Ui
5125  0b46 c3000e        	cpw	x,_Un
5126  0b49 2e1d          	jrsge	L1142
5128  0b4b 9c            	rvf
5129  0b4c ce000e        	ldw	x,_Un
5130  0b4f 72b0000c      	subw	x,_Ui
5131  0b53 c30012        	cpw	x,_ee_dU
5132  0b56 2d10          	jrsle	L1142
5134  0b58 c65005        	ld	a,20485
5135  0b5b a504          	bcp	a,#4
5136  0b5d 2609          	jrne	L1142
5139  0b5f be6a          	ldw	x,_umin_cnt
5140  0b61 1c0001        	addw	x,#1
5141  0b64 bf6a          	ldw	_umin_cnt,x
5143  0b66 2003          	jra	L3142
5144  0b68               L1142:
5145                     ; 1067 	else umin_cnt=0;
5147  0b68 5f            	clrw	x
5148  0b69 bf6a          	ldw	_umin_cnt,x
5149  0b6b               L3142:
5150                     ; 1068 	gran(&umin_cnt,0,10);	
5152  0b6b ae000a        	ldw	x,#10
5153  0b6e 89            	pushw	x
5154  0b6f 5f            	clrw	x
5155  0b70 89            	pushw	x
5156  0b71 ae006a        	ldw	x,#_umin_cnt
5157  0b74 cd00d5        	call	_gran
5159  0b77 5b04          	addw	sp,#4
5160                     ; 1069 	if(umin_cnt>=10)flags|=0b00010000;	  
5162  0b79 9c            	rvf
5163  0b7a be6a          	ldw	x,_umin_cnt
5164  0b7c a3000a        	cpw	x,#10
5165  0b7f 2f71          	jrslt	L7142
5168  0b81 72180005      	bset	_flags,#4
5169  0b85 206b          	jra	L7142
5170  0b87               L1042:
5171                     ; 1071 else if(jp_mode==jp3)
5173  0b87 b650          	ld	a,_jp_mode
5174  0b89 a103          	cp	a,#3
5175  0b8b 2665          	jrne	L7142
5176                     ; 1073 	if(Ui>700)umax_cnt++;
5178  0b8d 9c            	rvf
5179  0b8e ce000c        	ldw	x,_Ui
5180  0b91 a302bd        	cpw	x,#701
5181  0b94 2f09          	jrslt	L3242
5184  0b96 be6c          	ldw	x,_umax_cnt
5185  0b98 1c0001        	addw	x,#1
5186  0b9b bf6c          	ldw	_umax_cnt,x
5188  0b9d 2003          	jra	L5242
5189  0b9f               L3242:
5190                     ; 1074 	else umax_cnt=0;
5192  0b9f 5f            	clrw	x
5193  0ba0 bf6c          	ldw	_umax_cnt,x
5194  0ba2               L5242:
5195                     ; 1075 	gran(&umax_cnt,0,10);
5197  0ba2 ae000a        	ldw	x,#10
5198  0ba5 89            	pushw	x
5199  0ba6 5f            	clrw	x
5200  0ba7 89            	pushw	x
5201  0ba8 ae006c        	ldw	x,#_umax_cnt
5202  0bab cd00d5        	call	_gran
5204  0bae 5b04          	addw	sp,#4
5205                     ; 1076 	if(umax_cnt>=10)flags|=0b00001000;
5207  0bb0 9c            	rvf
5208  0bb1 be6c          	ldw	x,_umax_cnt
5209  0bb3 a3000a        	cpw	x,#10
5210  0bb6 2f04          	jrslt	L7242
5213  0bb8 72160005      	bset	_flags,#3
5214  0bbc               L7242:
5215                     ; 1079 	if((Ui<200)&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))umin_cnt++;	
5217  0bbc 9c            	rvf
5218  0bbd ce000c        	ldw	x,_Ui
5219  0bc0 a300c8        	cpw	x,#200
5220  0bc3 2e10          	jrsge	L1342
5222  0bc5 c65005        	ld	a,20485
5223  0bc8 a504          	bcp	a,#4
5224  0bca 2609          	jrne	L1342
5227  0bcc be6a          	ldw	x,_umin_cnt
5228  0bce 1c0001        	addw	x,#1
5229  0bd1 bf6a          	ldw	_umin_cnt,x
5231  0bd3 2003          	jra	L3342
5232  0bd5               L1342:
5233                     ; 1080 	else umin_cnt=0;
5235  0bd5 5f            	clrw	x
5236  0bd6 bf6a          	ldw	_umin_cnt,x
5237  0bd8               L3342:
5238                     ; 1081 	gran(&umin_cnt,0,10);	
5240  0bd8 ae000a        	ldw	x,#10
5241  0bdb 89            	pushw	x
5242  0bdc 5f            	clrw	x
5243  0bdd 89            	pushw	x
5244  0bde ae006a        	ldw	x,#_umin_cnt
5245  0be1 cd00d5        	call	_gran
5247  0be4 5b04          	addw	sp,#4
5248                     ; 1082 	if(umin_cnt>=10)flags|=0b00010000;	  
5250  0be6 9c            	rvf
5251  0be7 be6a          	ldw	x,_umin_cnt
5252  0be9 a3000a        	cpw	x,#10
5253  0bec 2f04          	jrslt	L7142
5256  0bee 72180005      	bset	_flags,#4
5257  0bf2               L7142:
5258                     ; 1084 }
5261  0bf2 81            	ret
5287                     ; 1109 void apv_start(void)
5287                     ; 1110 {
5288                     	switch	.text
5289  0bf3               _apv_start:
5293                     ; 1111 if((apv_cnt[0]==0)&&(apv_cnt[1]==0)&&(apv_cnt[2]==0)&&!bAPV)
5295  0bf3 3d4b          	tnz	_apv_cnt
5296  0bf5 2624          	jrne	L7442
5298  0bf7 3d4c          	tnz	_apv_cnt+1
5299  0bf9 2620          	jrne	L7442
5301  0bfb 3d4d          	tnz	_apv_cnt+2
5302  0bfd 261c          	jrne	L7442
5304                     	btst	_bAPV
5305  0c04 2515          	jrult	L7442
5306                     ; 1113 	apv_cnt[0]=60;
5308  0c06 353c004b      	mov	_apv_cnt,#60
5309                     ; 1114 	apv_cnt[1]=60;
5311  0c0a 353c004c      	mov	_apv_cnt+1,#60
5312                     ; 1115 	apv_cnt[2]=60;
5314  0c0e 353c004d      	mov	_apv_cnt+2,#60
5315                     ; 1116 	apv_cnt_=3600;
5317  0c12 ae0e10        	ldw	x,#3600
5318  0c15 bf49          	ldw	_apv_cnt_,x
5319                     ; 1117 	bAPV=1;	
5321  0c17 72100002      	bset	_bAPV
5322  0c1b               L7442:
5323                     ; 1119 }
5326  0c1b 81            	ret
5352                     ; 1122 void apv_stop(void)
5352                     ; 1123 {
5353                     	switch	.text
5354  0c1c               _apv_stop:
5358                     ; 1124 apv_cnt[0]=0;
5360  0c1c 3f4b          	clr	_apv_cnt
5361                     ; 1125 apv_cnt[1]=0;
5363  0c1e 3f4c          	clr	_apv_cnt+1
5364                     ; 1126 apv_cnt[2]=0;
5366  0c20 3f4d          	clr	_apv_cnt+2
5367                     ; 1127 apv_cnt_=0;	
5369  0c22 5f            	clrw	x
5370  0c23 bf49          	ldw	_apv_cnt_,x
5371                     ; 1128 bAPV=0;
5373  0c25 72110002      	bres	_bAPV
5374                     ; 1129 }
5377  0c29 81            	ret
5412                     ; 1133 void apv_hndl(void)
5412                     ; 1134 {
5413                     	switch	.text
5414  0c2a               _apv_hndl:
5418                     ; 1135 if(apv_cnt[0])
5420  0c2a 3d4b          	tnz	_apv_cnt
5421  0c2c 271e          	jreq	L1742
5422                     ; 1137 	apv_cnt[0]--;
5424  0c2e 3a4b          	dec	_apv_cnt
5425                     ; 1138 	if(apv_cnt[0]==0)
5427  0c30 3d4b          	tnz	_apv_cnt
5428  0c32 265a          	jrne	L5742
5429                     ; 1140 		flags&=0b11100001;
5431  0c34 b605          	ld	a,_flags
5432  0c36 a4e1          	and	a,#225
5433  0c38 b705          	ld	_flags,a
5434                     ; 1141 		tsign_cnt=0;
5436  0c3a 5f            	clrw	x
5437  0c3b bf55          	ldw	_tsign_cnt,x
5438                     ; 1142 		tmax_cnt=0;
5440  0c3d 5f            	clrw	x
5441  0c3e bf53          	ldw	_tmax_cnt,x
5442                     ; 1143 		umax_cnt=0;
5444  0c40 5f            	clrw	x
5445  0c41 bf6c          	ldw	_umax_cnt,x
5446                     ; 1144 		umin_cnt=0;
5448  0c43 5f            	clrw	x
5449  0c44 bf6a          	ldw	_umin_cnt,x
5450                     ; 1146 		led_drv_cnt=30;
5452  0c46 351e0016      	mov	_led_drv_cnt,#30
5453  0c4a 2042          	jra	L5742
5454  0c4c               L1742:
5455                     ; 1149 else if(apv_cnt[1])
5457  0c4c 3d4c          	tnz	_apv_cnt+1
5458  0c4e 271e          	jreq	L7742
5459                     ; 1151 	apv_cnt[1]--;
5461  0c50 3a4c          	dec	_apv_cnt+1
5462                     ; 1152 	if(apv_cnt[1]==0)
5464  0c52 3d4c          	tnz	_apv_cnt+1
5465  0c54 2638          	jrne	L5742
5466                     ; 1154 		flags&=0b11100001;
5468  0c56 b605          	ld	a,_flags
5469  0c58 a4e1          	and	a,#225
5470  0c5a b705          	ld	_flags,a
5471                     ; 1155 		tsign_cnt=0;
5473  0c5c 5f            	clrw	x
5474  0c5d bf55          	ldw	_tsign_cnt,x
5475                     ; 1156 		tmax_cnt=0;
5477  0c5f 5f            	clrw	x
5478  0c60 bf53          	ldw	_tmax_cnt,x
5479                     ; 1157 		umax_cnt=0;
5481  0c62 5f            	clrw	x
5482  0c63 bf6c          	ldw	_umax_cnt,x
5483                     ; 1158 		umin_cnt=0;
5485  0c65 5f            	clrw	x
5486  0c66 bf6a          	ldw	_umin_cnt,x
5487                     ; 1160 		led_drv_cnt=30;
5489  0c68 351e0016      	mov	_led_drv_cnt,#30
5490  0c6c 2020          	jra	L5742
5491  0c6e               L7742:
5492                     ; 1163 else if(apv_cnt[2])
5494  0c6e 3d4d          	tnz	_apv_cnt+2
5495  0c70 271c          	jreq	L5742
5496                     ; 1165 	apv_cnt[2]--;
5498  0c72 3a4d          	dec	_apv_cnt+2
5499                     ; 1166 	if(apv_cnt[2]==0)
5501  0c74 3d4d          	tnz	_apv_cnt+2
5502  0c76 2616          	jrne	L5742
5503                     ; 1168 		flags&=0b11100001;
5505  0c78 b605          	ld	a,_flags
5506  0c7a a4e1          	and	a,#225
5507  0c7c b705          	ld	_flags,a
5508                     ; 1169 		tsign_cnt=0;
5510  0c7e 5f            	clrw	x
5511  0c7f bf55          	ldw	_tsign_cnt,x
5512                     ; 1170 		tmax_cnt=0;
5514  0c81 5f            	clrw	x
5515  0c82 bf53          	ldw	_tmax_cnt,x
5516                     ; 1171 		umax_cnt=0;
5518  0c84 5f            	clrw	x
5519  0c85 bf6c          	ldw	_umax_cnt,x
5520                     ; 1172 		umin_cnt=0;          
5522  0c87 5f            	clrw	x
5523  0c88 bf6a          	ldw	_umin_cnt,x
5524                     ; 1174 		led_drv_cnt=30;
5526  0c8a 351e0016      	mov	_led_drv_cnt,#30
5527  0c8e               L5742:
5528                     ; 1178 if(apv_cnt_)
5530  0c8e be49          	ldw	x,_apv_cnt_
5531  0c90 2712          	jreq	L1152
5532                     ; 1180 	apv_cnt_--;
5534  0c92 be49          	ldw	x,_apv_cnt_
5535  0c94 1d0001        	subw	x,#1
5536  0c97 bf49          	ldw	_apv_cnt_,x
5537                     ; 1181 	if(apv_cnt_==0) 
5539  0c99 be49          	ldw	x,_apv_cnt_
5540  0c9b 2607          	jrne	L1152
5541                     ; 1183 		bAPV=0;
5543  0c9d 72110002      	bres	_bAPV
5544                     ; 1184 		apv_start();
5546  0ca1 cd0bf3        	call	_apv_start
5548  0ca4               L1152:
5549                     ; 1188 if((umin_cnt==0)&&(umax_cnt==0)/*&&(cnt_adc_ch_2_delta==0)*/&&(!BLOCK_IS_ON/*(GPIOB->ODR&(1<<2))*/))
5551  0ca4 be6a          	ldw	x,_umin_cnt
5552  0ca6 261e          	jrne	L5152
5554  0ca8 be6c          	ldw	x,_umax_cnt
5555  0caa 261a          	jrne	L5152
5557  0cac c65005        	ld	a,20485
5558  0caf a504          	bcp	a,#4
5559  0cb1 2613          	jrne	L5152
5560                     ; 1190 	if(cnt_apv_off<20)
5562  0cb3 b648          	ld	a,_cnt_apv_off
5563  0cb5 a114          	cp	a,#20
5564  0cb7 240f          	jruge	L3252
5565                     ; 1192 		cnt_apv_off++;
5567  0cb9 3c48          	inc	_cnt_apv_off
5568                     ; 1193 		if(cnt_apv_off>=20)
5570  0cbb b648          	ld	a,_cnt_apv_off
5571  0cbd a114          	cp	a,#20
5572  0cbf 2507          	jrult	L3252
5573                     ; 1195 			apv_stop();
5575  0cc1 cd0c1c        	call	_apv_stop
5577  0cc4 2002          	jra	L3252
5578  0cc6               L5152:
5579                     ; 1199 else cnt_apv_off=0;	
5581  0cc6 3f48          	clr	_cnt_apv_off
5582  0cc8               L3252:
5583                     ; 1201 }
5586  0cc8 81            	ret
5589                     	switch	.ubsct
5590  0000               L5252_flags_old:
5591  0000 00            	ds.b	1
5627                     ; 1204 void flags_drv(void)
5627                     ; 1205 {
5628                     	switch	.text
5629  0cc9               _flags_drv:
5633                     ; 1207 if(jp_mode!=jp3) 
5635  0cc9 b650          	ld	a,_jp_mode
5636  0ccb a103          	cp	a,#3
5637  0ccd 2723          	jreq	L5452
5638                     ; 1209 	if(((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/)))||((flags&(1<<4)/*0b00010000*/)&&(!(flags_old&(1<<4)/*0b00010000*/)))) 
5640  0ccf b605          	ld	a,_flags
5641  0cd1 a508          	bcp	a,#8
5642  0cd3 2706          	jreq	L3552
5644  0cd5 b600          	ld	a,L5252_flags_old
5645  0cd7 a508          	bcp	a,#8
5646  0cd9 270c          	jreq	L1552
5647  0cdb               L3552:
5649  0cdb b605          	ld	a,_flags
5650  0cdd a510          	bcp	a,#16
5651  0cdf 2726          	jreq	L7552
5653  0ce1 b600          	ld	a,L5252_flags_old
5654  0ce3 a510          	bcp	a,#16
5655  0ce5 2620          	jrne	L7552
5656  0ce7               L1552:
5657                     ; 1211     		if(link==OFF)apv_start();
5659  0ce7 b669          	ld	a,_link
5660  0ce9 a1aa          	cp	a,#170
5661  0ceb 261a          	jrne	L7552
5664  0ced cd0bf3        	call	_apv_start
5666  0cf0 2015          	jra	L7552
5667  0cf2               L5452:
5668                     ; 1214 else if(jp_mode==jp3) 
5670  0cf2 b650          	ld	a,_jp_mode
5671  0cf4 a103          	cp	a,#3
5672  0cf6 260f          	jrne	L7552
5673                     ; 1216 	if((flags&(1<<3)/*0b00001000*/)&&(!(flags_old&(1<<3)/*0b00001000*/))) 
5675  0cf8 b605          	ld	a,_flags
5676  0cfa a508          	bcp	a,#8
5677  0cfc 2709          	jreq	L7552
5679  0cfe b600          	ld	a,L5252_flags_old
5680  0d00 a508          	bcp	a,#8
5681  0d02 2603          	jrne	L7552
5682                     ; 1218     		apv_start();
5684  0d04 cd0bf3        	call	_apv_start
5686  0d07               L7552:
5687                     ; 1221 flags_old=flags;
5689  0d07 450500        	mov	L5252_flags_old,_flags
5690                     ; 1223 } 
5693  0d0a 81            	ret
5728                     ; 1360 void adr_drv_v4(char in)
5728                     ; 1361 {
5729                     	switch	.text
5730  0d0b               _adr_drv_v4:
5734                     ; 1362 if(adress!=in)adress=in;
5736  0d0b c100f7        	cp	a,_adress
5737  0d0e 2703          	jreq	L3062
5740  0d10 c700f7        	ld	_adress,a
5741  0d13               L3062:
5742                     ; 1363 }
5745  0d13 81            	ret
5774                     ; 1366 void adr_drv_v3(void)
5774                     ; 1367 {
5775                     	switch	.text
5776  0d14               _adr_drv_v3:
5778  0d14 88            	push	a
5779       00000001      OFST:	set	1
5782                     ; 1373 GPIOB->DDR&=~(1<<0);
5784  0d15 72115007      	bres	20487,#0
5785                     ; 1374 GPIOB->CR1&=~(1<<0);
5787  0d19 72115008      	bres	20488,#0
5788                     ; 1375 GPIOB->CR2&=~(1<<0);
5790  0d1d 72115009      	bres	20489,#0
5791                     ; 1376 ADC2->CR2=0x08;
5793  0d21 35085402      	mov	21506,#8
5794                     ; 1377 ADC2->CR1=0x40;
5796  0d25 35405401      	mov	21505,#64
5797                     ; 1378 ADC2->CSR=0x20+0;
5799  0d29 35205400      	mov	21504,#32
5800                     ; 1379 ADC2->CR1|=1;
5802  0d2d 72105401      	bset	21505,#0
5803                     ; 1380 ADC2->CR1|=1;
5805  0d31 72105401      	bset	21505,#0
5806                     ; 1381 adr_drv_stat=1;
5808  0d35 35010002      	mov	_adr_drv_stat,#1
5809  0d39               L5162:
5810                     ; 1382 while(adr_drv_stat==1);
5813  0d39 b602          	ld	a,_adr_drv_stat
5814  0d3b a101          	cp	a,#1
5815  0d3d 27fa          	jreq	L5162
5816                     ; 1384 GPIOB->DDR&=~(1<<1);
5818  0d3f 72135007      	bres	20487,#1
5819                     ; 1385 GPIOB->CR1&=~(1<<1);
5821  0d43 72135008      	bres	20488,#1
5822                     ; 1386 GPIOB->CR2&=~(1<<1);
5824  0d47 72135009      	bres	20489,#1
5825                     ; 1387 ADC2->CR2=0x08;
5827  0d4b 35085402      	mov	21506,#8
5828                     ; 1388 ADC2->CR1=0x40;
5830  0d4f 35405401      	mov	21505,#64
5831                     ; 1389 ADC2->CSR=0x20+1;
5833  0d53 35215400      	mov	21504,#33
5834                     ; 1390 ADC2->CR1|=1;
5836  0d57 72105401      	bset	21505,#0
5837                     ; 1391 ADC2->CR1|=1;
5839  0d5b 72105401      	bset	21505,#0
5840                     ; 1392 adr_drv_stat=3;
5842  0d5f 35030002      	mov	_adr_drv_stat,#3
5843  0d63               L3262:
5844                     ; 1393 while(adr_drv_stat==3);
5847  0d63 b602          	ld	a,_adr_drv_stat
5848  0d65 a103          	cp	a,#3
5849  0d67 27fa          	jreq	L3262
5850                     ; 1395 GPIOE->DDR&=~(1<<6);
5852  0d69 721d5016      	bres	20502,#6
5853                     ; 1396 GPIOE->CR1&=~(1<<6);
5855  0d6d 721d5017      	bres	20503,#6
5856                     ; 1397 GPIOE->CR2&=~(1<<6);
5858  0d71 721d5018      	bres	20504,#6
5859                     ; 1398 ADC2->CR2=0x08;
5861  0d75 35085402      	mov	21506,#8
5862                     ; 1399 ADC2->CR1=0x40;
5864  0d79 35405401      	mov	21505,#64
5865                     ; 1400 ADC2->CSR=0x20+9;
5867  0d7d 35295400      	mov	21504,#41
5868                     ; 1401 ADC2->CR1|=1;
5870  0d81 72105401      	bset	21505,#0
5871                     ; 1402 ADC2->CR1|=1;
5873  0d85 72105401      	bset	21505,#0
5874                     ; 1403 adr_drv_stat=5;
5876  0d89 35050002      	mov	_adr_drv_stat,#5
5877  0d8d               L1362:
5878                     ; 1404 while(adr_drv_stat==5);
5881  0d8d b602          	ld	a,_adr_drv_stat
5882  0d8f a105          	cp	a,#5
5883  0d91 27fa          	jreq	L1362
5884                     ; 1408 if((adc_buff_[0]>=(ADR_CONST_0-20))&&(adc_buff_[0]<=(ADR_CONST_0+20))) adr[0]=0;
5886  0d93 9c            	rvf
5887  0d94 ce00ff        	ldw	x,_adc_buff_
5888  0d97 a3022a        	cpw	x,#554
5889  0d9a 2f0f          	jrslt	L7362
5891  0d9c 9c            	rvf
5892  0d9d ce00ff        	ldw	x,_adc_buff_
5893  0da0 a30253        	cpw	x,#595
5894  0da3 2e06          	jrsge	L7362
5897  0da5 725f00f8      	clr	_adr
5899  0da9 204c          	jra	L1462
5900  0dab               L7362:
5901                     ; 1409 else if((adc_buff_[0]>=(ADR_CONST_1-20))&&(adc_buff_[0]<=(ADR_CONST_1+20))) adr[0]=1;
5903  0dab 9c            	rvf
5904  0dac ce00ff        	ldw	x,_adc_buff_
5905  0daf a3036d        	cpw	x,#877
5906  0db2 2f0f          	jrslt	L3462
5908  0db4 9c            	rvf
5909  0db5 ce00ff        	ldw	x,_adc_buff_
5910  0db8 a30396        	cpw	x,#918
5911  0dbb 2e06          	jrsge	L3462
5914  0dbd 350100f8      	mov	_adr,#1
5916  0dc1 2034          	jra	L1462
5917  0dc3               L3462:
5918                     ; 1410 else if((adc_buff_[0]>=(ADR_CONST_2-20))&&(adc_buff_[0]<=(ADR_CONST_2+20))) adr[0]=2;
5920  0dc3 9c            	rvf
5921  0dc4 ce00ff        	ldw	x,_adc_buff_
5922  0dc7 a302a3        	cpw	x,#675
5923  0dca 2f0f          	jrslt	L7462
5925  0dcc 9c            	rvf
5926  0dcd ce00ff        	ldw	x,_adc_buff_
5927  0dd0 a302cc        	cpw	x,#716
5928  0dd3 2e06          	jrsge	L7462
5931  0dd5 350200f8      	mov	_adr,#2
5933  0dd9 201c          	jra	L1462
5934  0ddb               L7462:
5935                     ; 1411 else if((adc_buff_[0]>=(ADR_CONST_3-20))&&(adc_buff_[0]<=(ADR_CONST_3+20))) adr[0]=3;
5937  0ddb 9c            	rvf
5938  0ddc ce00ff        	ldw	x,_adc_buff_
5939  0ddf a303e3        	cpw	x,#995
5940  0de2 2f0f          	jrslt	L3562
5942  0de4 9c            	rvf
5943  0de5 ce00ff        	ldw	x,_adc_buff_
5944  0de8 a3040c        	cpw	x,#1036
5945  0deb 2e06          	jrsge	L3562
5948  0ded 350300f8      	mov	_adr,#3
5950  0df1 2004          	jra	L1462
5951  0df3               L3562:
5952                     ; 1412 else adr[0]=5;
5954  0df3 350500f8      	mov	_adr,#5
5955  0df7               L1462:
5956                     ; 1414 if((adc_buff_[1]>=(ADR_CONST_0-20))&&(adc_buff_[1]<=(ADR_CONST_0+20))) adr[1]=0;
5958  0df7 9c            	rvf
5959  0df8 ce0101        	ldw	x,_adc_buff_+2
5960  0dfb a3022a        	cpw	x,#554
5961  0dfe 2f0f          	jrslt	L7562
5963  0e00 9c            	rvf
5964  0e01 ce0101        	ldw	x,_adc_buff_+2
5965  0e04 a30253        	cpw	x,#595
5966  0e07 2e06          	jrsge	L7562
5969  0e09 725f00f9      	clr	_adr+1
5971  0e0d 204c          	jra	L1662
5972  0e0f               L7562:
5973                     ; 1415 else if((adc_buff_[1]>=(ADR_CONST_1-20))&&(adc_buff_[1]<=(ADR_CONST_1+20))) adr[1]=1;
5975  0e0f 9c            	rvf
5976  0e10 ce0101        	ldw	x,_adc_buff_+2
5977  0e13 a3036d        	cpw	x,#877
5978  0e16 2f0f          	jrslt	L3662
5980  0e18 9c            	rvf
5981  0e19 ce0101        	ldw	x,_adc_buff_+2
5982  0e1c a30396        	cpw	x,#918
5983  0e1f 2e06          	jrsge	L3662
5986  0e21 350100f9      	mov	_adr+1,#1
5988  0e25 2034          	jra	L1662
5989  0e27               L3662:
5990                     ; 1416 else if((adc_buff_[1]>=(ADR_CONST_2-20))&&(adc_buff_[1]<=(ADR_CONST_2+20))) adr[1]=2;
5992  0e27 9c            	rvf
5993  0e28 ce0101        	ldw	x,_adc_buff_+2
5994  0e2b a302a3        	cpw	x,#675
5995  0e2e 2f0f          	jrslt	L7662
5997  0e30 9c            	rvf
5998  0e31 ce0101        	ldw	x,_adc_buff_+2
5999  0e34 a302cc        	cpw	x,#716
6000  0e37 2e06          	jrsge	L7662
6003  0e39 350200f9      	mov	_adr+1,#2
6005  0e3d 201c          	jra	L1662
6006  0e3f               L7662:
6007                     ; 1417 else if((adc_buff_[1]>=(ADR_CONST_3-20))&&(adc_buff_[1]<=(ADR_CONST_3+20))) adr[1]=3;
6009  0e3f 9c            	rvf
6010  0e40 ce0101        	ldw	x,_adc_buff_+2
6011  0e43 a303e3        	cpw	x,#995
6012  0e46 2f0f          	jrslt	L3762
6014  0e48 9c            	rvf
6015  0e49 ce0101        	ldw	x,_adc_buff_+2
6016  0e4c a3040c        	cpw	x,#1036
6017  0e4f 2e06          	jrsge	L3762
6020  0e51 350300f9      	mov	_adr+1,#3
6022  0e55 2004          	jra	L1662
6023  0e57               L3762:
6024                     ; 1418 else adr[1]=5;
6026  0e57 350500f9      	mov	_adr+1,#5
6027  0e5b               L1662:
6028                     ; 1420 if((adc_buff_[9]>=(ADR_CONST_0-20))&&(adc_buff_[9]<=(ADR_CONST_0+20))) adr[2]=0;
6030  0e5b 9c            	rvf
6031  0e5c ce0111        	ldw	x,_adc_buff_+18
6032  0e5f a3022a        	cpw	x,#554
6033  0e62 2f0f          	jrslt	L7762
6035  0e64 9c            	rvf
6036  0e65 ce0111        	ldw	x,_adc_buff_+18
6037  0e68 a30253        	cpw	x,#595
6038  0e6b 2e06          	jrsge	L7762
6041  0e6d 725f00fa      	clr	_adr+2
6043  0e71 204c          	jra	L1072
6044  0e73               L7762:
6045                     ; 1421 else if((adc_buff_[9]>=(ADR_CONST_1-20))&&(adc_buff_[9]<=(ADR_CONST_1+20))) adr[2]=1;
6047  0e73 9c            	rvf
6048  0e74 ce0111        	ldw	x,_adc_buff_+18
6049  0e77 a3036d        	cpw	x,#877
6050  0e7a 2f0f          	jrslt	L3072
6052  0e7c 9c            	rvf
6053  0e7d ce0111        	ldw	x,_adc_buff_+18
6054  0e80 a30396        	cpw	x,#918
6055  0e83 2e06          	jrsge	L3072
6058  0e85 350100fa      	mov	_adr+2,#1
6060  0e89 2034          	jra	L1072
6061  0e8b               L3072:
6062                     ; 1422 else if((adc_buff_[9]>=(ADR_CONST_2-20))&&(adc_buff_[9]<=(ADR_CONST_2+20))) adr[2]=2;
6064  0e8b 9c            	rvf
6065  0e8c ce0111        	ldw	x,_adc_buff_+18
6066  0e8f a302a3        	cpw	x,#675
6067  0e92 2f0f          	jrslt	L7072
6069  0e94 9c            	rvf
6070  0e95 ce0111        	ldw	x,_adc_buff_+18
6071  0e98 a302cc        	cpw	x,#716
6072  0e9b 2e06          	jrsge	L7072
6075  0e9d 350200fa      	mov	_adr+2,#2
6077  0ea1 201c          	jra	L1072
6078  0ea3               L7072:
6079                     ; 1423 else if((adc_buff_[9]>=(ADR_CONST_3-20))&&(adc_buff_[9]<=(ADR_CONST_3+20))) adr[2]=3;
6081  0ea3 9c            	rvf
6082  0ea4 ce0111        	ldw	x,_adc_buff_+18
6083  0ea7 a303e3        	cpw	x,#995
6084  0eaa 2f0f          	jrslt	L3172
6086  0eac 9c            	rvf
6087  0ead ce0111        	ldw	x,_adc_buff_+18
6088  0eb0 a3040c        	cpw	x,#1036
6089  0eb3 2e06          	jrsge	L3172
6092  0eb5 350300fa      	mov	_adr+2,#3
6094  0eb9 2004          	jra	L1072
6095  0ebb               L3172:
6096                     ; 1424 else adr[2]=5;
6098  0ebb 350500fa      	mov	_adr+2,#5
6099  0ebf               L1072:
6100                     ; 1428 if((adr[0]==5)||(adr[1]==5)||(adr[2]==5))
6102  0ebf c600f8        	ld	a,_adr
6103  0ec2 a105          	cp	a,#5
6104  0ec4 270e          	jreq	L1272
6106  0ec6 c600f9        	ld	a,_adr+1
6107  0ec9 a105          	cp	a,#5
6108  0ecb 2707          	jreq	L1272
6110  0ecd c600fa        	ld	a,_adr+2
6111  0ed0 a105          	cp	a,#5
6112  0ed2 2606          	jrne	L7172
6113  0ed4               L1272:
6114                     ; 1431 	adress_error=1;
6116  0ed4 350100f6      	mov	_adress_error,#1
6118  0ed8               L5272:
6119                     ; 1442 }
6122  0ed8 84            	pop	a
6123  0ed9 81            	ret
6124  0eda               L7172:
6125                     ; 1435 	if(adr[2]&0x02) bps_class=bpsIPS;
6127  0eda c600fa        	ld	a,_adr+2
6128  0edd a502          	bcp	a,#2
6129  0edf 2706          	jreq	L7272
6132  0ee1 3501000b      	mov	_bps_class,#1
6134  0ee5 2002          	jra	L1372
6135  0ee7               L7272:
6136                     ; 1436 	else bps_class=bpsIBEP;
6138  0ee7 3f0b          	clr	_bps_class
6139  0ee9               L1372:
6140                     ; 1438 	adress = adr[0] + (adr[1]*4) + ((adr[2]&0x01)*16);
6142  0ee9 c600fa        	ld	a,_adr+2
6143  0eec a401          	and	a,#1
6144  0eee 97            	ld	xl,a
6145  0eef a610          	ld	a,#16
6146  0ef1 42            	mul	x,a
6147  0ef2 9f            	ld	a,xl
6148  0ef3 6b01          	ld	(OFST+0,sp),a
6149  0ef5 c600f9        	ld	a,_adr+1
6150  0ef8 48            	sll	a
6151  0ef9 48            	sll	a
6152  0efa cb00f8        	add	a,_adr
6153  0efd 1b01          	add	a,(OFST+0,sp)
6154  0eff c700f7        	ld	_adress,a
6155  0f02 20d4          	jra	L5272
6178                     ; 1492 void init_CAN(void) {
6179                     	switch	.text
6180  0f04               _init_CAN:
6184                     ; 1493 	CAN->MCR&=~CAN_MCR_SLEEP;					// CAN wake up request
6186  0f04 72135420      	bres	21536,#1
6187                     ; 1494 	CAN->MCR|= CAN_MCR_INRQ;					// CAN initialization request
6189  0f08 72105420      	bset	21536,#0
6191  0f0c               L5472:
6192                     ; 1495 	while((CAN->MSR & CAN_MSR_INAK) == 0);	// waiting for CAN enter the init mode
6194  0f0c c65421        	ld	a,21537
6195  0f0f a501          	bcp	a,#1
6196  0f11 27f9          	jreq	L5472
6197                     ; 1497 	CAN->MCR|= CAN_MCR_NART;					// no automatic retransmition
6199  0f13 72185420      	bset	21536,#4
6200                     ; 1499 	CAN->PSR= 2;							// *** FILTER 0 SETTINGS ***
6202  0f17 35025427      	mov	21543,#2
6203                     ; 1508 	CAN->Page.Filter01.F0R1= UKU_MESS_STID>>3;			// 16 bits mode
6205  0f1b 35135428      	mov	21544,#19
6206                     ; 1509 	CAN->Page.Filter01.F0R2= UKU_MESS_STID<<5;
6208  0f1f 35c05429      	mov	21545,#192
6209                     ; 1510 	CAN->Page.Filter01.F0R5= UKU_MESS_STID_MASK>>3;
6211  0f23 357f542c      	mov	21548,#127
6212                     ; 1511 	CAN->Page.Filter01.F0R6= UKU_MESS_STID_MASK<<5;
6214  0f27 35e0542d      	mov	21549,#224
6215                     ; 1513 	CAN->Page.Filter01.F1R1= BPS_MESS_STID>>3;			// 16 bits mode
6217  0f2b 35315430      	mov	21552,#49
6218                     ; 1514 	CAN->Page.Filter01.F1R2= BPS_MESS_STID<<5;
6220  0f2f 35c05431      	mov	21553,#192
6221                     ; 1515 	CAN->Page.Filter01.F1R5= BPS_MESS_STID_MASK>>3;
6223  0f33 357f5434      	mov	21556,#127
6224                     ; 1516 	CAN->Page.Filter01.F1R6= BPS_MESS_STID_MASK<<5;
6226  0f37 35e05435      	mov	21557,#224
6227                     ; 1520 	CAN->PSR= 6;									// set page 6
6229  0f3b 35065427      	mov	21543,#6
6230                     ; 1525 	CAN->Page.Config.FMR1&=~3;								//mask mode
6232  0f3f c65430        	ld	a,21552
6233  0f42 a4fc          	and	a,#252
6234  0f44 c75430        	ld	21552,a
6235                     ; 1531 	CAN->Page.Config.FCR1= ((3<<1) & (CAN_FCR1_FSC00 | CAN_FCR1_FSC01));		//16 bit scale
6237  0f47 35065432      	mov	21554,#6
6238                     ; 1532 	CAN->Page.Config.FCR1= ((3<<5) & (CAN_FCR1_FSC10 | CAN_FCR1_FSC11));		//16 bit scale
6240  0f4b 35605432      	mov	21554,#96
6241                     ; 1535 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT0;	// filter 0 active
6243  0f4f 72105432      	bset	21554,#0
6244                     ; 1536 	CAN->Page.Config.FCR1|= CAN_FCR1_FACT1;
6246  0f53 72185432      	bset	21554,#4
6247                     ; 1539 	CAN->PSR= 6;								// *** BIT TIMING SETTINGS ***
6249  0f57 35065427      	mov	21543,#6
6250                     ; 1541 	CAN->Page.Config.BTR1= 9;					// CAN_BTR1_BRP=9, 	tq= fcpu/(9+1)
6252  0f5b 3509542c      	mov	21548,#9
6253                     ; 1542 	CAN->Page.Config.BTR2= (1<<7)|(6<<4) | 7; 		// BS2=8, BS1=7, 		
6255  0f5f 35e7542d      	mov	21549,#231
6256                     ; 1544 	CAN->IER|=(1<<1);
6258  0f63 72125425      	bset	21541,#1
6259                     ; 1547 	CAN->MCR&=~CAN_MCR_INRQ;					// leave initialization request
6261  0f67 72115420      	bres	21536,#0
6263  0f6b               L3572:
6264                     ; 1548 	while((CAN->MSR & CAN_MSR_INAK) != 0);	// waiting for CAN leave the init mode
6266  0f6b c65421        	ld	a,21537
6267  0f6e a501          	bcp	a,#1
6268  0f70 26f9          	jrne	L3572
6269                     ; 1549 }
6272  0f72 81            	ret
6380                     ; 1552 void can_transmit(unsigned short id_st,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7)
6380                     ; 1553 {
6381                     	switch	.text
6382  0f73               _can_transmit:
6384  0f73 89            	pushw	x
6385       00000000      OFST:	set	0
6388                     ; 1555 if((can_buff_wr_ptr<0)||(can_buff_wr_ptr>3))can_buff_wr_ptr=0;
6390  0f74 b672          	ld	a,_can_buff_wr_ptr
6391  0f76 a104          	cp	a,#4
6392  0f78 2502          	jrult	L5303
6395  0f7a 3f72          	clr	_can_buff_wr_ptr
6396  0f7c               L5303:
6397                     ; 1557 can_out_buff[can_buff_wr_ptr][0]=(char)(id_st>>6);
6399  0f7c b672          	ld	a,_can_buff_wr_ptr
6400  0f7e 97            	ld	xl,a
6401  0f7f a610          	ld	a,#16
6402  0f81 42            	mul	x,a
6403  0f82 1601          	ldw	y,(OFST+1,sp)
6404  0f84 a606          	ld	a,#6
6405  0f86               L421:
6406  0f86 9054          	srlw	y
6407  0f88 4a            	dec	a
6408  0f89 26fb          	jrne	L421
6409  0f8b 909f          	ld	a,yl
6410  0f8d e773          	ld	(_can_out_buff,x),a
6411                     ; 1558 can_out_buff[can_buff_wr_ptr][1]=(char)(id_st<<2);
6413  0f8f b672          	ld	a,_can_buff_wr_ptr
6414  0f91 97            	ld	xl,a
6415  0f92 a610          	ld	a,#16
6416  0f94 42            	mul	x,a
6417  0f95 7b02          	ld	a,(OFST+2,sp)
6418  0f97 48            	sll	a
6419  0f98 48            	sll	a
6420  0f99 e774          	ld	(_can_out_buff+1,x),a
6421                     ; 1560 can_out_buff[can_buff_wr_ptr][2]=data0;
6423  0f9b b672          	ld	a,_can_buff_wr_ptr
6424  0f9d 97            	ld	xl,a
6425  0f9e a610          	ld	a,#16
6426  0fa0 42            	mul	x,a
6427  0fa1 7b05          	ld	a,(OFST+5,sp)
6428  0fa3 e775          	ld	(_can_out_buff+2,x),a
6429                     ; 1561 can_out_buff[can_buff_wr_ptr][3]=data1;
6431  0fa5 b672          	ld	a,_can_buff_wr_ptr
6432  0fa7 97            	ld	xl,a
6433  0fa8 a610          	ld	a,#16
6434  0faa 42            	mul	x,a
6435  0fab 7b06          	ld	a,(OFST+6,sp)
6436  0fad e776          	ld	(_can_out_buff+3,x),a
6437                     ; 1562 can_out_buff[can_buff_wr_ptr][4]=data2;
6439  0faf b672          	ld	a,_can_buff_wr_ptr
6440  0fb1 97            	ld	xl,a
6441  0fb2 a610          	ld	a,#16
6442  0fb4 42            	mul	x,a
6443  0fb5 7b07          	ld	a,(OFST+7,sp)
6444  0fb7 e777          	ld	(_can_out_buff+4,x),a
6445                     ; 1563 can_out_buff[can_buff_wr_ptr][5]=data3;
6447  0fb9 b672          	ld	a,_can_buff_wr_ptr
6448  0fbb 97            	ld	xl,a
6449  0fbc a610          	ld	a,#16
6450  0fbe 42            	mul	x,a
6451  0fbf 7b08          	ld	a,(OFST+8,sp)
6452  0fc1 e778          	ld	(_can_out_buff+5,x),a
6453                     ; 1564 can_out_buff[can_buff_wr_ptr][6]=data4;
6455  0fc3 b672          	ld	a,_can_buff_wr_ptr
6456  0fc5 97            	ld	xl,a
6457  0fc6 a610          	ld	a,#16
6458  0fc8 42            	mul	x,a
6459  0fc9 7b09          	ld	a,(OFST+9,sp)
6460  0fcb e779          	ld	(_can_out_buff+6,x),a
6461                     ; 1565 can_out_buff[can_buff_wr_ptr][7]=data5;
6463  0fcd b672          	ld	a,_can_buff_wr_ptr
6464  0fcf 97            	ld	xl,a
6465  0fd0 a610          	ld	a,#16
6466  0fd2 42            	mul	x,a
6467  0fd3 7b0a          	ld	a,(OFST+10,sp)
6468  0fd5 e77a          	ld	(_can_out_buff+7,x),a
6469                     ; 1566 can_out_buff[can_buff_wr_ptr][8]=data6;
6471  0fd7 b672          	ld	a,_can_buff_wr_ptr
6472  0fd9 97            	ld	xl,a
6473  0fda a610          	ld	a,#16
6474  0fdc 42            	mul	x,a
6475  0fdd 7b0b          	ld	a,(OFST+11,sp)
6476  0fdf e77b          	ld	(_can_out_buff+8,x),a
6477                     ; 1567 can_out_buff[can_buff_wr_ptr][9]=data7;
6479  0fe1 b672          	ld	a,_can_buff_wr_ptr
6480  0fe3 97            	ld	xl,a
6481  0fe4 a610          	ld	a,#16
6482  0fe6 42            	mul	x,a
6483  0fe7 7b0c          	ld	a,(OFST+12,sp)
6484  0fe9 e77c          	ld	(_can_out_buff+9,x),a
6485                     ; 1569 can_buff_wr_ptr++;
6487  0feb 3c72          	inc	_can_buff_wr_ptr
6488                     ; 1570 if(can_buff_wr_ptr>3)can_buff_wr_ptr=0;
6490  0fed b672          	ld	a,_can_buff_wr_ptr
6491  0fef a104          	cp	a,#4
6492  0ff1 2502          	jrult	L7303
6495  0ff3 3f72          	clr	_can_buff_wr_ptr
6496  0ff5               L7303:
6497                     ; 1571 } 
6500  0ff5 85            	popw	x
6501  0ff6 81            	ret
6530                     ; 1574 void can_tx_hndl(void)
6530                     ; 1575 {
6531                     	switch	.text
6532  0ff7               _can_tx_hndl:
6536                     ; 1576 if(bTX_FREE)
6538  0ff7 3d03          	tnz	_bTX_FREE
6539  0ff9 2757          	jreq	L1503
6540                     ; 1578 	if(can_buff_rd_ptr!=can_buff_wr_ptr)
6542  0ffb b671          	ld	a,_can_buff_rd_ptr
6543  0ffd b172          	cp	a,_can_buff_wr_ptr
6544  0fff 275f          	jreq	L7503
6545                     ; 1580 		bTX_FREE=0;
6547  1001 3f03          	clr	_bTX_FREE
6548                     ; 1582 		CAN->PSR= 0;
6550  1003 725f5427      	clr	21543
6551                     ; 1583 		CAN->Page.TxMailbox.MDLCR=8;
6553  1007 35085429      	mov	21545,#8
6554                     ; 1584 		CAN->Page.TxMailbox.MIDR1=can_out_buff[can_buff_rd_ptr][0];
6556  100b b671          	ld	a,_can_buff_rd_ptr
6557  100d 97            	ld	xl,a
6558  100e a610          	ld	a,#16
6559  1010 42            	mul	x,a
6560  1011 e673          	ld	a,(_can_out_buff,x)
6561  1013 c7542a        	ld	21546,a
6562                     ; 1585 		CAN->Page.TxMailbox.MIDR2=can_out_buff[can_buff_rd_ptr][1];
6564  1016 b671          	ld	a,_can_buff_rd_ptr
6565  1018 97            	ld	xl,a
6566  1019 a610          	ld	a,#16
6567  101b 42            	mul	x,a
6568  101c e674          	ld	a,(_can_out_buff+1,x)
6569  101e c7542b        	ld	21547,a
6570                     ; 1587 		memcpy(&CAN->Page.TxMailbox.MDAR1, &can_out_buff[can_buff_rd_ptr][2],8);
6572  1021 b671          	ld	a,_can_buff_rd_ptr
6573  1023 97            	ld	xl,a
6574  1024 a610          	ld	a,#16
6575  1026 42            	mul	x,a
6576  1027 01            	rrwa	x,a
6577  1028 ab75          	add	a,#_can_out_buff+2
6578  102a 2401          	jrnc	L031
6579  102c 5c            	incw	x
6580  102d               L031:
6581  102d 5f            	clrw	x
6582  102e 97            	ld	xl,a
6583  102f bf00          	ldw	c_x,x
6584  1031 ae0008        	ldw	x,#8
6585  1034               L231:
6586  1034 5a            	decw	x
6587  1035 92d600        	ld	a,([c_x],x)
6588  1038 d7542e        	ld	(21550,x),a
6589  103b 5d            	tnzw	x
6590  103c 26f6          	jrne	L231
6591                     ; 1589 		can_buff_rd_ptr++;
6593  103e 3c71          	inc	_can_buff_rd_ptr
6594                     ; 1590 		if(can_buff_rd_ptr>3)can_buff_rd_ptr=0;
6596  1040 b671          	ld	a,_can_buff_rd_ptr
6597  1042 a104          	cp	a,#4
6598  1044 2502          	jrult	L5503
6601  1046 3f71          	clr	_can_buff_rd_ptr
6602  1048               L5503:
6603                     ; 1592 		CAN->Page.TxMailbox.MCSR|= CAN_MCSR_TXRQ;
6605  1048 72105428      	bset	21544,#0
6606                     ; 1593 		CAN->IER|=(1<<0);
6608  104c 72105425      	bset	21541,#0
6609  1050 200e          	jra	L7503
6610  1052               L1503:
6611                     ; 1598 	tx_busy_cnt++;
6613  1052 3c70          	inc	_tx_busy_cnt
6614                     ; 1599 	if(tx_busy_cnt>=100)
6616  1054 b670          	ld	a,_tx_busy_cnt
6617  1056 a164          	cp	a,#100
6618  1058 2506          	jrult	L7503
6619                     ; 1601 		tx_busy_cnt=0;
6621  105a 3f70          	clr	_tx_busy_cnt
6622                     ; 1602 		bTX_FREE=1;
6624  105c 35010003      	mov	_bTX_FREE,#1
6625  1060               L7503:
6626                     ; 1605 }
6629  1060 81            	ret
6744                     ; 1631 void can_in_an(void)
6744                     ; 1632 {
6745                     	switch	.text
6746  1061               _can_in_an:
6748  1061 5207          	subw	sp,#7
6749       00000007      OFST:	set	7
6752                     ; 1642 if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==GETTM))	
6754  1063 b6c9          	ld	a,_mess+6
6755  1065 c100f7        	cp	a,_adress
6756  1068 2703          	jreq	L251
6757  106a cc11a2        	jp	L7113
6758  106d               L251:
6760  106d b6ca          	ld	a,_mess+7
6761  106f c100f7        	cp	a,_adress
6762  1072 2703          	jreq	L451
6763  1074 cc11a2        	jp	L7113
6764  1077               L451:
6766  1077 b6cb          	ld	a,_mess+8
6767  1079 a1ed          	cp	a,#237
6768  107b 2703          	jreq	L651
6769  107d cc11a2        	jp	L7113
6770  1080               L651:
6771                     ; 1645 	can_error_cnt=0;
6773  1080 3f6f          	clr	_can_error_cnt
6774                     ; 1647 	bMAIN=0;
6776  1082 72110001      	bres	_bMAIN
6777                     ; 1648  	flags_tu=mess[9];
6779  1086 45cc66        	mov	_flags_tu,_mess+9
6780                     ; 1649  	if(flags_tu&0b00000001)
6782  1089 b666          	ld	a,_flags_tu
6783  108b a501          	bcp	a,#1
6784  108d 2706          	jreq	L1213
6785                     ; 1654  			/*if(flags_tu_cnt_off>=4)*/flags|=0b00100000;
6787  108f 721a0005      	bset	_flags,#5
6789  1093 2008          	jra	L3213
6790  1095               L1213:
6791                     ; 1665  				flags&=0b11011111; 
6793  1095 721b0005      	bres	_flags,#5
6794                     ; 1666  				off_bp_cnt=5*EE_TZAS;
6796  1099 350f0059      	mov	_off_bp_cnt,#15
6797  109d               L3213:
6798                     ; 1672  	if(flags_tu&0b00000010) flags|=0b01000000;
6800  109d b666          	ld	a,_flags_tu
6801  109f a502          	bcp	a,#2
6802  10a1 2706          	jreq	L5213
6805  10a3 721c0005      	bset	_flags,#6
6807  10a7 2004          	jra	L7213
6808  10a9               L5213:
6809                     ; 1673  	else flags&=0b10111111; 
6811  10a9 721d0005      	bres	_flags,#6
6812  10ad               L7213:
6813                     ; 1675  	U_out_const=mess[10]+mess[11]*256;
6815  10ad b6ce          	ld	a,_mess+11
6816  10af 5f            	clrw	x
6817  10b0 97            	ld	xl,a
6818  10b1 4f            	clr	a
6819  10b2 02            	rlwa	x,a
6820  10b3 01            	rrwa	x,a
6821  10b4 bbcd          	add	a,_mess+10
6822  10b6 2401          	jrnc	L631
6823  10b8 5c            	incw	x
6824  10b9               L631:
6825  10b9 c70009        	ld	_U_out_const+1,a
6826  10bc 9f            	ld	a,xl
6827  10bd c70008        	ld	_U_out_const,a
6828                     ; 1676  	vol_i_temp=mess[12]+mess[13]*256;  
6830  10c0 b6d0          	ld	a,_mess+13
6831  10c2 5f            	clrw	x
6832  10c3 97            	ld	xl,a
6833  10c4 4f            	clr	a
6834  10c5 02            	rlwa	x,a
6835  10c6 01            	rrwa	x,a
6836  10c7 bbcf          	add	a,_mess+12
6837  10c9 2401          	jrnc	L041
6838  10cb 5c            	incw	x
6839  10cc               L041:
6840  10cc b75d          	ld	_vol_i_temp+1,a
6841  10ce 9f            	ld	a,xl
6842  10cf b75c          	ld	_vol_i_temp,a
6843                     ; 1686 	if(vent_resurs_tx_cnt>1) plazma_int[2]=vent_resurs;
6845  10d1 b608          	ld	a,_vent_resurs_tx_cnt
6846  10d3 a102          	cp	a,#2
6847  10d5 2507          	jrult	L1313
6850  10d7 ce0000        	ldw	x,_vent_resurs
6851  10da bf3d          	ldw	_plazma_int+4,x
6853  10dc 2004          	jra	L3313
6854  10de               L1313:
6855                     ; 1687 	else plazma_int[2]=vent_resurs_sec_cnt;
6857  10de be09          	ldw	x,_vent_resurs_sec_cnt
6858  10e0 bf3d          	ldw	_plazma_int+4,x
6859  10e2               L3313:
6860                     ; 1688  	rotor_int=flags_tu+(((short)flags)<<8);
6862  10e2 b605          	ld	a,_flags
6863  10e4 5f            	clrw	x
6864  10e5 97            	ld	xl,a
6865  10e6 4f            	clr	a
6866  10e7 02            	rlwa	x,a
6867  10e8 01            	rrwa	x,a
6868  10e9 bb66          	add	a,_flags_tu
6869  10eb 2401          	jrnc	L241
6870  10ed 5c            	incw	x
6871  10ee               L241:
6872  10ee b718          	ld	_rotor_int+1,a
6873  10f0 9f            	ld	a,xl
6874  10f1 b717          	ld	_rotor_int,a
6875                     ; 1689 	can_transmit(0x18e,adress,PUTTM1,*(((char*)&I)+1),*((char*)&I),*(((char*)&Un)+1),*((char*)&Un),*(((char*)&Ui)+1),*((char*)&Ui));
6877  10f3 3b000c        	push	_Ui
6878  10f6 3b000d        	push	_Ui+1
6879  10f9 3b000e        	push	_Un
6880  10fc 3b000f        	push	_Un+1
6881  10ff 3b0010        	push	_I
6882  1102 3b0011        	push	_I+1
6883  1105 4bda          	push	#218
6884  1107 3b00f7        	push	_adress
6885  110a ae018e        	ldw	x,#398
6886  110d cd0f73        	call	_can_transmit
6888  1110 5b08          	addw	sp,#8
6889                     ; 1690 	can_transmit(0x18e,adress,PUTTM2,T,vent_resurs_buff[vent_resurs_tx_cnt],flags,_x_,*(((char*)&Usum)+1),*((char*)&Usum));
6891  1112 3b0006        	push	_Usum
6892  1115 3b0007        	push	_Usum+1
6893  1118 3b0065        	push	__x_+1
6894  111b 3b0005        	push	_flags
6895  111e b608          	ld	a,_vent_resurs_tx_cnt
6896  1120 5f            	clrw	x
6897  1121 97            	ld	xl,a
6898  1122 d60000        	ld	a,(_vent_resurs_buff,x)
6899  1125 88            	push	a
6900  1126 3b006e        	push	_T
6901  1129 4bdb          	push	#219
6902  112b 3b00f7        	push	_adress
6903  112e ae018e        	ldw	x,#398
6904  1131 cd0f73        	call	_can_transmit
6906  1134 5b08          	addw	sp,#8
6907                     ; 1691 	can_transmit(0x18e,adress,PUTTM3,*(((char*)&debug_info_to_uku[0])+1),*((char*)&debug_info_to_uku[0]),*(((char*)&debug_info_to_uku[1])+1),*((char*)&debug_info_to_uku[1]),*(((char*)&debug_info_to_uku[2])+1),*((char*)&debug_info_to_uku[2]));
6909  1136 3b0005        	push	_debug_info_to_uku+4
6910  1139 3b0006        	push	_debug_info_to_uku+5
6911  113c 3b0003        	push	_debug_info_to_uku+2
6912  113f 3b0004        	push	_debug_info_to_uku+3
6913  1142 3b0001        	push	_debug_info_to_uku
6914  1145 3b0002        	push	_debug_info_to_uku+1
6915  1148 4bdc          	push	#220
6916  114a 3b00f7        	push	_adress
6917  114d ae018e        	ldw	x,#398
6918  1150 cd0f73        	call	_can_transmit
6920  1153 5b08          	addw	sp,#8
6921                     ; 1692      link_cnt=0;
6923  1155 5f            	clrw	x
6924  1156 bf67          	ldw	_link_cnt,x
6925                     ; 1693      link=ON;
6927  1158 35550069      	mov	_link,#85
6928                     ; 1695      if(flags_tu&0b10000000)
6930  115c b666          	ld	a,_flags_tu
6931  115e a580          	bcp	a,#128
6932  1160 2716          	jreq	L5313
6933                     ; 1697      	if(!res_fl)
6935  1162 725d000b      	tnz	_res_fl
6936  1166 2626          	jrne	L1413
6937                     ; 1699      		res_fl=1;
6939  1168 a601          	ld	a,#1
6940  116a ae000b        	ldw	x,#_res_fl
6941  116d cd0000        	call	c_eewrc
6943                     ; 1700      		bRES=1;
6945  1170 3501000c      	mov	_bRES,#1
6946                     ; 1701      		res_fl_cnt=0;
6948  1174 3f47          	clr	_res_fl_cnt
6949  1176 2016          	jra	L1413
6950  1178               L5313:
6951                     ; 1706      	if(main_cnt>20)
6953  1178 9c            	rvf
6954  1179 ce0255        	ldw	x,_main_cnt
6955  117c a30015        	cpw	x,#21
6956  117f 2f0d          	jrslt	L1413
6957                     ; 1708     			if(res_fl)
6959  1181 725d000b      	tnz	_res_fl
6960  1185 2707          	jreq	L1413
6961                     ; 1710      			res_fl=0;
6963  1187 4f            	clr	a
6964  1188 ae000b        	ldw	x,#_res_fl
6965  118b cd0000        	call	c_eewrc
6967  118e               L1413:
6968                     ; 1715       if(res_fl_)
6970  118e 725d000a      	tnz	_res_fl_
6971  1192 2603          	jrne	L061
6972  1194 cc1709        	jp	L3603
6973  1197               L061:
6974                     ; 1717       	res_fl_=0;
6976  1197 4f            	clr	a
6977  1198 ae000a        	ldw	x,#_res_fl_
6978  119b cd0000        	call	c_eewrc
6980  119e ac091709      	jpf	L3603
6981  11a2               L7113:
6982                     ; 1720 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==KLBR)&&(mess[9]==mess[10]))
6984  11a2 b6c9          	ld	a,_mess+6
6985  11a4 c100f7        	cp	a,_adress
6986  11a7 2703          	jreq	L261
6987  11a9 cc141f        	jp	L3513
6988  11ac               L261:
6990  11ac b6ca          	ld	a,_mess+7
6991  11ae c100f7        	cp	a,_adress
6992  11b1 2703          	jreq	L461
6993  11b3 cc141f        	jp	L3513
6994  11b6               L461:
6996  11b6 b6cb          	ld	a,_mess+8
6997  11b8 a1ee          	cp	a,#238
6998  11ba 2703          	jreq	L661
6999  11bc cc141f        	jp	L3513
7000  11bf               L661:
7002  11bf b6cc          	ld	a,_mess+9
7003  11c1 b1cd          	cp	a,_mess+10
7004  11c3 2703          	jreq	L071
7005  11c5 cc141f        	jp	L3513
7006  11c8               L071:
7007                     ; 1722 	rotor_int++;
7009  11c8 be17          	ldw	x,_rotor_int
7010  11ca 1c0001        	addw	x,#1
7011  11cd bf17          	ldw	_rotor_int,x
7012                     ; 1723 	if((mess[9]&0xf0)==0x20)
7014  11cf b6cc          	ld	a,_mess+9
7015  11d1 a4f0          	and	a,#240
7016  11d3 a120          	cp	a,#32
7017  11d5 2673          	jrne	L5513
7018                     ; 1725 		if((mess[9]&0x0f)==0x01)
7020  11d7 b6cc          	ld	a,_mess+9
7021  11d9 a40f          	and	a,#15
7022  11db a101          	cp	a,#1
7023  11dd 260d          	jrne	L7513
7024                     ; 1727 			ee_K[0][0]=adc_buff_[4];
7026  11df ce0107        	ldw	x,_adc_buff_+8
7027  11e2 89            	pushw	x
7028  11e3 ae001a        	ldw	x,#_ee_K
7029  11e6 cd0000        	call	c_eewrw
7031  11e9 85            	popw	x
7033  11ea 204a          	jra	L1613
7034  11ec               L7513:
7035                     ; 1729 		else if((mess[9]&0x0f)==0x02)
7037  11ec b6cc          	ld	a,_mess+9
7038  11ee a40f          	and	a,#15
7039  11f0 a102          	cp	a,#2
7040  11f2 260b          	jrne	L3613
7041                     ; 1731 			ee_K[0][1]++;
7043  11f4 ce001c        	ldw	x,_ee_K+2
7044  11f7 1c0001        	addw	x,#1
7045  11fa cf001c        	ldw	_ee_K+2,x
7047  11fd 2037          	jra	L1613
7048  11ff               L3613:
7049                     ; 1733 		else if((mess[9]&0x0f)==0x03)
7051  11ff b6cc          	ld	a,_mess+9
7052  1201 a40f          	and	a,#15
7053  1203 a103          	cp	a,#3
7054  1205 260b          	jrne	L7613
7055                     ; 1735 			ee_K[0][1]+=10;
7057  1207 ce001c        	ldw	x,_ee_K+2
7058  120a 1c000a        	addw	x,#10
7059  120d cf001c        	ldw	_ee_K+2,x
7061  1210 2024          	jra	L1613
7062  1212               L7613:
7063                     ; 1737 		else if((mess[9]&0x0f)==0x04)
7065  1212 b6cc          	ld	a,_mess+9
7066  1214 a40f          	and	a,#15
7067  1216 a104          	cp	a,#4
7068  1218 260b          	jrne	L3713
7069                     ; 1739 			ee_K[0][1]--;
7071  121a ce001c        	ldw	x,_ee_K+2
7072  121d 1d0001        	subw	x,#1
7073  1220 cf001c        	ldw	_ee_K+2,x
7075  1223 2011          	jra	L1613
7076  1225               L3713:
7077                     ; 1741 		else if((mess[9]&0x0f)==0x05)
7079  1225 b6cc          	ld	a,_mess+9
7080  1227 a40f          	and	a,#15
7081  1229 a105          	cp	a,#5
7082  122b 2609          	jrne	L1613
7083                     ; 1743 			ee_K[0][1]-=10;
7085  122d ce001c        	ldw	x,_ee_K+2
7086  1230 1d000a        	subw	x,#10
7087  1233 cf001c        	ldw	_ee_K+2,x
7088  1236               L1613:
7089                     ; 1745 		granee(&ee_K[0][1],50,3000);									
7091  1236 ae0bb8        	ldw	x,#3000
7092  1239 89            	pushw	x
7093  123a ae0032        	ldw	x,#50
7094  123d 89            	pushw	x
7095  123e ae001c        	ldw	x,#_ee_K+2
7096  1241 cd00f6        	call	_granee
7098  1244 5b04          	addw	sp,#4
7100  1246 ac041404      	jpf	L1023
7101  124a               L5513:
7102                     ; 1747 	else if((mess[9]&0xf0)==0x10)
7104  124a b6cc          	ld	a,_mess+9
7105  124c a4f0          	and	a,#240
7106  124e a110          	cp	a,#16
7107  1250 2673          	jrne	L3023
7108                     ; 1749 		if((mess[9]&0x0f)==0x01)
7110  1252 b6cc          	ld	a,_mess+9
7111  1254 a40f          	and	a,#15
7112  1256 a101          	cp	a,#1
7113  1258 260d          	jrne	L5023
7114                     ; 1751 			ee_K[1][0]=adc_buff_[1];
7116  125a ce0101        	ldw	x,_adc_buff_+2
7117  125d 89            	pushw	x
7118  125e ae001e        	ldw	x,#_ee_K+4
7119  1261 cd0000        	call	c_eewrw
7121  1264 85            	popw	x
7123  1265 204a          	jra	L7023
7124  1267               L5023:
7125                     ; 1753 		else if((mess[9]&0x0f)==0x02)
7127  1267 b6cc          	ld	a,_mess+9
7128  1269 a40f          	and	a,#15
7129  126b a102          	cp	a,#2
7130  126d 260b          	jrne	L1123
7131                     ; 1755 			ee_K[1][1]++;
7133  126f ce0020        	ldw	x,_ee_K+6
7134  1272 1c0001        	addw	x,#1
7135  1275 cf0020        	ldw	_ee_K+6,x
7137  1278 2037          	jra	L7023
7138  127a               L1123:
7139                     ; 1757 		else if((mess[9]&0x0f)==0x03)
7141  127a b6cc          	ld	a,_mess+9
7142  127c a40f          	and	a,#15
7143  127e a103          	cp	a,#3
7144  1280 260b          	jrne	L5123
7145                     ; 1759 			ee_K[1][1]+=10;
7147  1282 ce0020        	ldw	x,_ee_K+6
7148  1285 1c000a        	addw	x,#10
7149  1288 cf0020        	ldw	_ee_K+6,x
7151  128b 2024          	jra	L7023
7152  128d               L5123:
7153                     ; 1761 		else if((mess[9]&0x0f)==0x04)
7155  128d b6cc          	ld	a,_mess+9
7156  128f a40f          	and	a,#15
7157  1291 a104          	cp	a,#4
7158  1293 260b          	jrne	L1223
7159                     ; 1763 			ee_K[1][1]--;
7161  1295 ce0020        	ldw	x,_ee_K+6
7162  1298 1d0001        	subw	x,#1
7163  129b cf0020        	ldw	_ee_K+6,x
7165  129e 2011          	jra	L7023
7166  12a0               L1223:
7167                     ; 1765 		else if((mess[9]&0x0f)==0x05)
7169  12a0 b6cc          	ld	a,_mess+9
7170  12a2 a40f          	and	a,#15
7171  12a4 a105          	cp	a,#5
7172  12a6 2609          	jrne	L7023
7173                     ; 1767 			ee_K[1][1]-=10;
7175  12a8 ce0020        	ldw	x,_ee_K+6
7176  12ab 1d000a        	subw	x,#10
7177  12ae cf0020        	ldw	_ee_K+6,x
7178  12b1               L7023:
7179                     ; 1772 		granee(&ee_K[1][1],10,30000);
7181  12b1 ae7530        	ldw	x,#30000
7182  12b4 89            	pushw	x
7183  12b5 ae000a        	ldw	x,#10
7184  12b8 89            	pushw	x
7185  12b9 ae0020        	ldw	x,#_ee_K+6
7186  12bc cd00f6        	call	_granee
7188  12bf 5b04          	addw	sp,#4
7190  12c1 ac041404      	jpf	L1023
7191  12c5               L3023:
7192                     ; 1776 	else if((mess[9]&0xf0)==0x00)
7194  12c5 b6cc          	ld	a,_mess+9
7195  12c7 a5f0          	bcp	a,#240
7196  12c9 2673          	jrne	L1323
7197                     ; 1778 		if((mess[9]&0x0f)==0x01)
7199  12cb b6cc          	ld	a,_mess+9
7200  12cd a40f          	and	a,#15
7201  12cf a101          	cp	a,#1
7202  12d1 260d          	jrne	L3323
7203                     ; 1780 			ee_K[2][0]=adc_buff_[2];
7205  12d3 ce0103        	ldw	x,_adc_buff_+4
7206  12d6 89            	pushw	x
7207  12d7 ae0022        	ldw	x,#_ee_K+8
7208  12da cd0000        	call	c_eewrw
7210  12dd 85            	popw	x
7212  12de 204a          	jra	L5323
7213  12e0               L3323:
7214                     ; 1782 		else if((mess[9]&0x0f)==0x02)
7216  12e0 b6cc          	ld	a,_mess+9
7217  12e2 a40f          	and	a,#15
7218  12e4 a102          	cp	a,#2
7219  12e6 260b          	jrne	L7323
7220                     ; 1784 			ee_K[2][1]++;
7222  12e8 ce0024        	ldw	x,_ee_K+10
7223  12eb 1c0001        	addw	x,#1
7224  12ee cf0024        	ldw	_ee_K+10,x
7226  12f1 2037          	jra	L5323
7227  12f3               L7323:
7228                     ; 1786 		else if((mess[9]&0x0f)==0x03)
7230  12f3 b6cc          	ld	a,_mess+9
7231  12f5 a40f          	and	a,#15
7232  12f7 a103          	cp	a,#3
7233  12f9 260b          	jrne	L3423
7234                     ; 1788 			ee_K[2][1]+=10;
7236  12fb ce0024        	ldw	x,_ee_K+10
7237  12fe 1c000a        	addw	x,#10
7238  1301 cf0024        	ldw	_ee_K+10,x
7240  1304 2024          	jra	L5323
7241  1306               L3423:
7242                     ; 1790 		else if((mess[9]&0x0f)==0x04)
7244  1306 b6cc          	ld	a,_mess+9
7245  1308 a40f          	and	a,#15
7246  130a a104          	cp	a,#4
7247  130c 260b          	jrne	L7423
7248                     ; 1792 			ee_K[2][1]--;
7250  130e ce0024        	ldw	x,_ee_K+10
7251  1311 1d0001        	subw	x,#1
7252  1314 cf0024        	ldw	_ee_K+10,x
7254  1317 2011          	jra	L5323
7255  1319               L7423:
7256                     ; 1794 		else if((mess[9]&0x0f)==0x05)
7258  1319 b6cc          	ld	a,_mess+9
7259  131b a40f          	and	a,#15
7260  131d a105          	cp	a,#5
7261  131f 2609          	jrne	L5323
7262                     ; 1796 			ee_K[2][1]-=10;
7264  1321 ce0024        	ldw	x,_ee_K+10
7265  1324 1d000a        	subw	x,#10
7266  1327 cf0024        	ldw	_ee_K+10,x
7267  132a               L5323:
7268                     ; 1801 		granee(&ee_K[2][1],10,30000);
7270  132a ae7530        	ldw	x,#30000
7271  132d 89            	pushw	x
7272  132e ae000a        	ldw	x,#10
7273  1331 89            	pushw	x
7274  1332 ae0024        	ldw	x,#_ee_K+10
7275  1335 cd00f6        	call	_granee
7277  1338 5b04          	addw	sp,#4
7279  133a ac041404      	jpf	L1023
7280  133e               L1323:
7281                     ; 1805 	else if((mess[9]&0xf0)==0x30)
7283  133e b6cc          	ld	a,_mess+9
7284  1340 a4f0          	and	a,#240
7285  1342 a130          	cp	a,#48
7286  1344 265c          	jrne	L7523
7287                     ; 1807 		if((mess[9]&0x0f)==0x02)
7289  1346 b6cc          	ld	a,_mess+9
7290  1348 a40f          	and	a,#15
7291  134a a102          	cp	a,#2
7292  134c 260b          	jrne	L1623
7293                     ; 1809 			ee_K[3][1]++;
7295  134e ce0028        	ldw	x,_ee_K+14
7296  1351 1c0001        	addw	x,#1
7297  1354 cf0028        	ldw	_ee_K+14,x
7299  1357 2037          	jra	L3623
7300  1359               L1623:
7301                     ; 1811 		else if((mess[9]&0x0f)==0x03)
7303  1359 b6cc          	ld	a,_mess+9
7304  135b a40f          	and	a,#15
7305  135d a103          	cp	a,#3
7306  135f 260b          	jrne	L5623
7307                     ; 1813 			ee_K[3][1]+=10;
7309  1361 ce0028        	ldw	x,_ee_K+14
7310  1364 1c000a        	addw	x,#10
7311  1367 cf0028        	ldw	_ee_K+14,x
7313  136a 2024          	jra	L3623
7314  136c               L5623:
7315                     ; 1815 		else if((mess[9]&0x0f)==0x04)
7317  136c b6cc          	ld	a,_mess+9
7318  136e a40f          	and	a,#15
7319  1370 a104          	cp	a,#4
7320  1372 260b          	jrne	L1723
7321                     ; 1817 			ee_K[3][1]--;
7323  1374 ce0028        	ldw	x,_ee_K+14
7324  1377 1d0001        	subw	x,#1
7325  137a cf0028        	ldw	_ee_K+14,x
7327  137d 2011          	jra	L3623
7328  137f               L1723:
7329                     ; 1819 		else if((mess[9]&0x0f)==0x05)
7331  137f b6cc          	ld	a,_mess+9
7332  1381 a40f          	and	a,#15
7333  1383 a105          	cp	a,#5
7334  1385 2609          	jrne	L3623
7335                     ; 1821 			ee_K[3][1]-=10;
7337  1387 ce0028        	ldw	x,_ee_K+14
7338  138a 1d000a        	subw	x,#10
7339  138d cf0028        	ldw	_ee_K+14,x
7340  1390               L3623:
7341                     ; 1823 		granee(&ee_K[3][1],300,517);									
7343  1390 ae0205        	ldw	x,#517
7344  1393 89            	pushw	x
7345  1394 ae012c        	ldw	x,#300
7346  1397 89            	pushw	x
7347  1398 ae0028        	ldw	x,#_ee_K+14
7348  139b cd00f6        	call	_granee
7350  139e 5b04          	addw	sp,#4
7352  13a0 2062          	jra	L1023
7353  13a2               L7523:
7354                     ; 1826 	else if((mess[9]&0xf0)==0x50)
7356  13a2 b6cc          	ld	a,_mess+9
7357  13a4 a4f0          	and	a,#240
7358  13a6 a150          	cp	a,#80
7359  13a8 265a          	jrne	L1023
7360                     ; 1828 		if((mess[9]&0x0f)==0x02)
7362  13aa b6cc          	ld	a,_mess+9
7363  13ac a40f          	and	a,#15
7364  13ae a102          	cp	a,#2
7365  13b0 260b          	jrne	L3033
7366                     ; 1830 			ee_K[4][1]++;
7368  13b2 ce002c        	ldw	x,_ee_K+18
7369  13b5 1c0001        	addw	x,#1
7370  13b8 cf002c        	ldw	_ee_K+18,x
7372  13bb 2037          	jra	L5033
7373  13bd               L3033:
7374                     ; 1832 		else if((mess[9]&0x0f)==0x03)
7376  13bd b6cc          	ld	a,_mess+9
7377  13bf a40f          	and	a,#15
7378  13c1 a103          	cp	a,#3
7379  13c3 260b          	jrne	L7033
7380                     ; 1834 			ee_K[4][1]+=10;
7382  13c5 ce002c        	ldw	x,_ee_K+18
7383  13c8 1c000a        	addw	x,#10
7384  13cb cf002c        	ldw	_ee_K+18,x
7386  13ce 2024          	jra	L5033
7387  13d0               L7033:
7388                     ; 1836 		else if((mess[9]&0x0f)==0x04)
7390  13d0 b6cc          	ld	a,_mess+9
7391  13d2 a40f          	and	a,#15
7392  13d4 a104          	cp	a,#4
7393  13d6 260b          	jrne	L3133
7394                     ; 1838 			ee_K[4][1]--;
7396  13d8 ce002c        	ldw	x,_ee_K+18
7397  13db 1d0001        	subw	x,#1
7398  13de cf002c        	ldw	_ee_K+18,x
7400  13e1 2011          	jra	L5033
7401  13e3               L3133:
7402                     ; 1840 		else if((mess[9]&0x0f)==0x05)
7404  13e3 b6cc          	ld	a,_mess+9
7405  13e5 a40f          	and	a,#15
7406  13e7 a105          	cp	a,#5
7407  13e9 2609          	jrne	L5033
7408                     ; 1842 			ee_K[4][1]-=10;
7410  13eb ce002c        	ldw	x,_ee_K+18
7411  13ee 1d000a        	subw	x,#10
7412  13f1 cf002c        	ldw	_ee_K+18,x
7413  13f4               L5033:
7414                     ; 1844 		granee(&ee_K[4][1],10,30000);									
7416  13f4 ae7530        	ldw	x,#30000
7417  13f7 89            	pushw	x
7418  13f8 ae000a        	ldw	x,#10
7419  13fb 89            	pushw	x
7420  13fc ae002c        	ldw	x,#_ee_K+18
7421  13ff cd00f6        	call	_granee
7423  1402 5b04          	addw	sp,#4
7424  1404               L1023:
7425                     ; 1847 	link_cnt=0;
7427  1404 5f            	clrw	x
7428  1405 bf67          	ldw	_link_cnt,x
7429                     ; 1848      link=ON;
7431  1407 35550069      	mov	_link,#85
7432                     ; 1849      if(res_fl_)
7434  140b 725d000a      	tnz	_res_fl_
7435  140f 2603          	jrne	L271
7436  1411 cc1709        	jp	L3603
7437  1414               L271:
7438                     ; 1851       	res_fl_=0;
7440  1414 4f            	clr	a
7441  1415 ae000a        	ldw	x,#_res_fl_
7442  1418 cd0000        	call	c_eewrc
7444  141b ac091709      	jpf	L3603
7445  141f               L3513:
7446                     ; 1857 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==MEM_KF))
7448  141f b6c9          	ld	a,_mess+6
7449  1421 a1ff          	cp	a,#255
7450  1423 2703          	jreq	L471
7451  1425 cc14b3        	jp	L5233
7452  1428               L471:
7454  1428 b6ca          	ld	a,_mess+7
7455  142a a1ff          	cp	a,#255
7456  142c 2703          	jreq	L671
7457  142e cc14b3        	jp	L5233
7458  1431               L671:
7460  1431 b6cb          	ld	a,_mess+8
7461  1433 a162          	cp	a,#98
7462  1435 267c          	jrne	L5233
7463                     ; 1860 	tempSS=mess[9]+(mess[10]*256);
7465  1437 b6cd          	ld	a,_mess+10
7466  1439 5f            	clrw	x
7467  143a 97            	ld	xl,a
7468  143b 4f            	clr	a
7469  143c 02            	rlwa	x,a
7470  143d 01            	rrwa	x,a
7471  143e bbcc          	add	a,_mess+9
7472  1440 2401          	jrnc	L441
7473  1442 5c            	incw	x
7474  1443               L441:
7475  1443 02            	rlwa	x,a
7476  1444 1f03          	ldw	(OFST-4,sp),x
7477  1446 01            	rrwa	x,a
7478                     ; 1861 	if(ee_Umax!=tempSS) ee_Umax=tempSS;
7480  1447 ce0014        	ldw	x,_ee_Umax
7481  144a 1303          	cpw	x,(OFST-4,sp)
7482  144c 270a          	jreq	L7233
7485  144e 1e03          	ldw	x,(OFST-4,sp)
7486  1450 89            	pushw	x
7487  1451 ae0014        	ldw	x,#_ee_Umax
7488  1454 cd0000        	call	c_eewrw
7490  1457 85            	popw	x
7491  1458               L7233:
7492                     ; 1862 	tempSS=mess[11]+(mess[12]*256);
7494  1458 b6cf          	ld	a,_mess+12
7495  145a 5f            	clrw	x
7496  145b 97            	ld	xl,a
7497  145c 4f            	clr	a
7498  145d 02            	rlwa	x,a
7499  145e 01            	rrwa	x,a
7500  145f bbce          	add	a,_mess+11
7501  1461 2401          	jrnc	L641
7502  1463 5c            	incw	x
7503  1464               L641:
7504  1464 02            	rlwa	x,a
7505  1465 1f03          	ldw	(OFST-4,sp),x
7506  1467 01            	rrwa	x,a
7507                     ; 1863 	if(ee_dU!=tempSS) ee_dU=tempSS;
7509  1468 ce0012        	ldw	x,_ee_dU
7510  146b 1303          	cpw	x,(OFST-4,sp)
7511  146d 270a          	jreq	L1333
7514  146f 1e03          	ldw	x,(OFST-4,sp)
7515  1471 89            	pushw	x
7516  1472 ae0012        	ldw	x,#_ee_dU
7517  1475 cd0000        	call	c_eewrw
7519  1478 85            	popw	x
7520  1479               L1333:
7521                     ; 1864 	if((mess[13]&0x0f)==0x5)
7523  1479 b6d0          	ld	a,_mess+13
7524  147b a40f          	and	a,#15
7525  147d a105          	cp	a,#5
7526  147f 261a          	jrne	L3333
7527                     ; 1866 		if(ee_AVT_MODE!=0x55)ee_AVT_MODE=0x55;
7529  1481 ce0006        	ldw	x,_ee_AVT_MODE
7530  1484 a30055        	cpw	x,#85
7531  1487 2603          	jrne	L002
7532  1489 cc1709        	jp	L3603
7533  148c               L002:
7536  148c ae0055        	ldw	x,#85
7537  148f 89            	pushw	x
7538  1490 ae0006        	ldw	x,#_ee_AVT_MODE
7539  1493 cd0000        	call	c_eewrw
7541  1496 85            	popw	x
7542  1497 ac091709      	jpf	L3603
7543  149b               L3333:
7544                     ; 1868 	else if(ee_AVT_MODE==0x55)ee_AVT_MODE=0;	
7546  149b ce0006        	ldw	x,_ee_AVT_MODE
7547  149e a30055        	cpw	x,#85
7548  14a1 2703          	jreq	L202
7549  14a3 cc1709        	jp	L3603
7550  14a6               L202:
7553  14a6 5f            	clrw	x
7554  14a7 89            	pushw	x
7555  14a8 ae0006        	ldw	x,#_ee_AVT_MODE
7556  14ab cd0000        	call	c_eewrw
7558  14ae 85            	popw	x
7559  14af ac091709      	jpf	L3603
7560  14b3               L5233:
7561                     ; 1871 else if((mess[6]==0xff)&&(mess[7]==0xff)&&((mess[8]==MEM_KF1)||(mess[8]==MEM_KF4)))
7563  14b3 b6c9          	ld	a,_mess+6
7564  14b5 a1ff          	cp	a,#255
7565  14b7 2703          	jreq	L402
7566  14b9 cc156f        	jp	L5433
7567  14bc               L402:
7569  14bc b6ca          	ld	a,_mess+7
7570  14be a1ff          	cp	a,#255
7571  14c0 2703          	jreq	L602
7572  14c2 cc156f        	jp	L5433
7573  14c5               L602:
7575  14c5 b6cb          	ld	a,_mess+8
7576  14c7 a126          	cp	a,#38
7577  14c9 2709          	jreq	L7433
7579  14cb b6cb          	ld	a,_mess+8
7580  14cd a129          	cp	a,#41
7581  14cf 2703          	jreq	L012
7582  14d1 cc156f        	jp	L5433
7583  14d4               L012:
7584  14d4               L7433:
7585                     ; 1874 	tempSS=mess[9]+(mess[10]*256);
7587  14d4 b6cd          	ld	a,_mess+10
7588  14d6 5f            	clrw	x
7589  14d7 97            	ld	xl,a
7590  14d8 4f            	clr	a
7591  14d9 02            	rlwa	x,a
7592  14da 01            	rrwa	x,a
7593  14db bbcc          	add	a,_mess+9
7594  14dd 2401          	jrnc	L051
7595  14df 5c            	incw	x
7596  14e0               L051:
7597  14e0 02            	rlwa	x,a
7598  14e1 1f03          	ldw	(OFST-4,sp),x
7599  14e3 01            	rrwa	x,a
7600                     ; 1876 	if(ee_UAVT!=tempSS) ee_UAVT=tempSS;
7602  14e4 ce000c        	ldw	x,_ee_UAVT
7603  14e7 1303          	cpw	x,(OFST-4,sp)
7604  14e9 270a          	jreq	L1533
7607  14eb 1e03          	ldw	x,(OFST-4,sp)
7608  14ed 89            	pushw	x
7609  14ee ae000c        	ldw	x,#_ee_UAVT
7610  14f1 cd0000        	call	c_eewrw
7612  14f4 85            	popw	x
7613  14f5               L1533:
7614                     ; 1877 	tempSS=(signed short)mess[11];
7616  14f5 b6ce          	ld	a,_mess+11
7617  14f7 5f            	clrw	x
7618  14f8 97            	ld	xl,a
7619  14f9 1f03          	ldw	(OFST-4,sp),x
7620                     ; 1878 	if(ee_tmax!=tempSS) ee_tmax=tempSS;
7622  14fb ce0010        	ldw	x,_ee_tmax
7623  14fe 1303          	cpw	x,(OFST-4,sp)
7624  1500 270a          	jreq	L3533
7627  1502 1e03          	ldw	x,(OFST-4,sp)
7628  1504 89            	pushw	x
7629  1505 ae0010        	ldw	x,#_ee_tmax
7630  1508 cd0000        	call	c_eewrw
7632  150b 85            	popw	x
7633  150c               L3533:
7634                     ; 1879 	tempSS=(signed short)mess[12];
7636  150c b6cf          	ld	a,_mess+12
7637  150e 5f            	clrw	x
7638  150f 97            	ld	xl,a
7639  1510 1f03          	ldw	(OFST-4,sp),x
7640                     ; 1880 	if(ee_tsign!=tempSS) ee_tsign=tempSS;
7642  1512 ce000e        	ldw	x,_ee_tsign
7643  1515 1303          	cpw	x,(OFST-4,sp)
7644  1517 270a          	jreq	L5533
7647  1519 1e03          	ldw	x,(OFST-4,sp)
7648  151b 89            	pushw	x
7649  151c ae000e        	ldw	x,#_ee_tsign
7650  151f cd0000        	call	c_eewrw
7652  1522 85            	popw	x
7653  1523               L5533:
7654                     ; 1883 	if(mess[8]==MEM_KF1)
7656  1523 b6cb          	ld	a,_mess+8
7657  1525 a126          	cp	a,#38
7658  1527 260e          	jrne	L7533
7659                     ; 1885 		if(ee_DEVICE!=0)ee_DEVICE=0;
7661  1529 ce0004        	ldw	x,_ee_DEVICE
7662  152c 2709          	jreq	L7533
7665  152e 5f            	clrw	x
7666  152f 89            	pushw	x
7667  1530 ae0004        	ldw	x,#_ee_DEVICE
7668  1533 cd0000        	call	c_eewrw
7670  1536 85            	popw	x
7671  1537               L7533:
7672                     ; 1888 	if(mess[8]==MEM_KF4)	//MEM_KF4 передают УКУшки там, где нужно полное управление БПСами с УКУ, включить-выключить, короче не для ИБЭП
7674  1537 b6cb          	ld	a,_mess+8
7675  1539 a129          	cp	a,#41
7676  153b 2703          	jreq	L212
7677  153d cc1709        	jp	L3603
7678  1540               L212:
7679                     ; 1890 		if(ee_DEVICE!=1)ee_DEVICE=1;
7681  1540 ce0004        	ldw	x,_ee_DEVICE
7682  1543 a30001        	cpw	x,#1
7683  1546 270b          	jreq	L5633
7686  1548 ae0001        	ldw	x,#1
7687  154b 89            	pushw	x
7688  154c ae0004        	ldw	x,#_ee_DEVICE
7689  154f cd0000        	call	c_eewrw
7691  1552 85            	popw	x
7692  1553               L5633:
7693                     ; 1891 		if(ee_IMAXVENT!=(signed short)mess[13]) ee_IMAXVENT=(signed short)mess[13];
7695  1553 b6d0          	ld	a,_mess+13
7696  1555 5f            	clrw	x
7697  1556 97            	ld	xl,a
7698  1557 c30002        	cpw	x,_ee_IMAXVENT
7699  155a 2603          	jrne	L412
7700  155c cc1709        	jp	L3603
7701  155f               L412:
7704  155f b6d0          	ld	a,_mess+13
7705  1561 5f            	clrw	x
7706  1562 97            	ld	xl,a
7707  1563 89            	pushw	x
7708  1564 ae0002        	ldw	x,#_ee_IMAXVENT
7709  1567 cd0000        	call	c_eewrw
7711  156a 85            	popw	x
7712  156b ac091709      	jpf	L3603
7713  156f               L5433:
7714                     ; 1896 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==ALRM_RES))
7716  156f b6c9          	ld	a,_mess+6
7717  1571 c100f7        	cp	a,_adress
7718  1574 262d          	jrne	L3733
7720  1576 b6ca          	ld	a,_mess+7
7721  1578 c100f7        	cp	a,_adress
7722  157b 2626          	jrne	L3733
7724  157d b6cb          	ld	a,_mess+8
7725  157f a116          	cp	a,#22
7726  1581 2620          	jrne	L3733
7728  1583 b6cc          	ld	a,_mess+9
7729  1585 a163          	cp	a,#99
7730  1587 261a          	jrne	L3733
7731                     ; 1898 	flags&=0b11100001;
7733  1589 b605          	ld	a,_flags
7734  158b a4e1          	and	a,#225
7735  158d b705          	ld	_flags,a
7736                     ; 1899 	tsign_cnt=0;
7738  158f 5f            	clrw	x
7739  1590 bf55          	ldw	_tsign_cnt,x
7740                     ; 1900 	tmax_cnt=0;
7742  1592 5f            	clrw	x
7743  1593 bf53          	ldw	_tmax_cnt,x
7744                     ; 1901 	umax_cnt=0;
7746  1595 5f            	clrw	x
7747  1596 bf6c          	ldw	_umax_cnt,x
7748                     ; 1902 	umin_cnt=0;
7750  1598 5f            	clrw	x
7751  1599 bf6a          	ldw	_umin_cnt,x
7752                     ; 1903 	led_drv_cnt=30;
7754  159b 351e0016      	mov	_led_drv_cnt,#30
7756  159f ac091709      	jpf	L3603
7757  15a3               L3733:
7758                     ; 1906 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==VENT_RES))
7760  15a3 b6c9          	ld	a,_mess+6
7761  15a5 c100f7        	cp	a,_adress
7762  15a8 2620          	jrne	L7733
7764  15aa b6ca          	ld	a,_mess+7
7765  15ac c100f7        	cp	a,_adress
7766  15af 2619          	jrne	L7733
7768  15b1 b6cb          	ld	a,_mess+8
7769  15b3 a116          	cp	a,#22
7770  15b5 2613          	jrne	L7733
7772  15b7 b6cc          	ld	a,_mess+9
7773  15b9 a164          	cp	a,#100
7774  15bb 260d          	jrne	L7733
7775                     ; 1908 	vent_resurs=0;
7777  15bd 5f            	clrw	x
7778  15be 89            	pushw	x
7779  15bf ae0000        	ldw	x,#_vent_resurs
7780  15c2 cd0000        	call	c_eewrw
7782  15c5 85            	popw	x
7784  15c6 ac091709      	jpf	L3603
7785  15ca               L7733:
7786                     ; 1912 else if((mess[6]==0xff)&&(mess[7]==0xff)&&(mess[8]==CMND)&&(mess[9]==CMND))
7788  15ca b6c9          	ld	a,_mess+6
7789  15cc a1ff          	cp	a,#255
7790  15ce 265f          	jrne	L3043
7792  15d0 b6ca          	ld	a,_mess+7
7793  15d2 a1ff          	cp	a,#255
7794  15d4 2659          	jrne	L3043
7796  15d6 b6cb          	ld	a,_mess+8
7797  15d8 a116          	cp	a,#22
7798  15da 2653          	jrne	L3043
7800  15dc b6cc          	ld	a,_mess+9
7801  15de a116          	cp	a,#22
7802  15e0 264d          	jrne	L3043
7803                     ; 1914 	if((mess[10]==0x55)&&(mess[11]==0x55)) _x_++;
7805  15e2 b6cd          	ld	a,_mess+10
7806  15e4 a155          	cp	a,#85
7807  15e6 260f          	jrne	L5043
7809  15e8 b6ce          	ld	a,_mess+11
7810  15ea a155          	cp	a,#85
7811  15ec 2609          	jrne	L5043
7814  15ee be64          	ldw	x,__x_
7815  15f0 1c0001        	addw	x,#1
7816  15f3 bf64          	ldw	__x_,x
7818  15f5 2024          	jra	L7043
7819  15f7               L5043:
7820                     ; 1915 	else if((mess[10]==0x66)&&(mess[11]==0x66)) _x_--; 
7822  15f7 b6cd          	ld	a,_mess+10
7823  15f9 a166          	cp	a,#102
7824  15fb 260f          	jrne	L1143
7826  15fd b6ce          	ld	a,_mess+11
7827  15ff a166          	cp	a,#102
7828  1601 2609          	jrne	L1143
7831  1603 be64          	ldw	x,__x_
7832  1605 1d0001        	subw	x,#1
7833  1608 bf64          	ldw	__x_,x
7835  160a 200f          	jra	L7043
7836  160c               L1143:
7837                     ; 1916 	else if((mess[10]==0x77)&&(mess[11]==0x77)) _x_=0;
7839  160c b6cd          	ld	a,_mess+10
7840  160e a177          	cp	a,#119
7841  1610 2609          	jrne	L7043
7843  1612 b6ce          	ld	a,_mess+11
7844  1614 a177          	cp	a,#119
7845  1616 2603          	jrne	L7043
7848  1618 5f            	clrw	x
7849  1619 bf64          	ldw	__x_,x
7850  161b               L7043:
7851                     ; 1917      gran(&_x_,-XMAX,XMAX);
7853  161b ae0019        	ldw	x,#25
7854  161e 89            	pushw	x
7855  161f aeffe7        	ldw	x,#65511
7856  1622 89            	pushw	x
7857  1623 ae0064        	ldw	x,#__x_
7858  1626 cd00d5        	call	_gran
7860  1629 5b04          	addw	sp,#4
7862  162b ac091709      	jpf	L3603
7863  162f               L3043:
7864                     ; 1919 else if((mess[6]==adress)&&(mess[7]==adress)&&(mess[8]==CMND)&&(mess[9]==mess[10])&&(mess[9]==0xee))
7866  162f b6c9          	ld	a,_mess+6
7867  1631 c100f7        	cp	a,_adress
7868  1634 2635          	jrne	L1243
7870  1636 b6ca          	ld	a,_mess+7
7871  1638 c100f7        	cp	a,_adress
7872  163b 262e          	jrne	L1243
7874  163d b6cb          	ld	a,_mess+8
7875  163f a116          	cp	a,#22
7876  1641 2628          	jrne	L1243
7878  1643 b6cc          	ld	a,_mess+9
7879  1645 b1cd          	cp	a,_mess+10
7880  1647 2622          	jrne	L1243
7882  1649 b6cc          	ld	a,_mess+9
7883  164b a1ee          	cp	a,#238
7884  164d 261c          	jrne	L1243
7885                     ; 1921 	rotor_int++;
7887  164f be17          	ldw	x,_rotor_int
7888  1651 1c0001        	addw	x,#1
7889  1654 bf17          	ldw	_rotor_int,x
7890                     ; 1922      tempI=pwm_u;
7892                     ; 1924 	UU_AVT=Un;
7894  1656 ce000e        	ldw	x,_Un
7895  1659 89            	pushw	x
7896  165a ae0008        	ldw	x,#_UU_AVT
7897  165d cd0000        	call	c_eewrw
7899  1660 85            	popw	x
7900                     ; 1925 	delay_ms(100);
7902  1661 ae0064        	ldw	x,#100
7903  1664 cd0121        	call	_delay_ms
7906  1667 ac091709      	jpf	L3603
7907  166b               L1243:
7908                     ; 1931 else if((mess[7]==PUTTM1)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7910  166b b6ca          	ld	a,_mess+7
7911  166d a1da          	cp	a,#218
7912  166f 2653          	jrne	L5243
7914  1671 b6c9          	ld	a,_mess+6
7915  1673 c100f7        	cp	a,_adress
7916  1676 274c          	jreq	L5243
7918  1678 b6c9          	ld	a,_mess+6
7919  167a a106          	cp	a,#6
7920  167c 2446          	jruge	L5243
7921                     ; 1933 	i_main_bps_cnt[mess[6]]=0;
7923  167e b6c9          	ld	a,_mess+6
7924  1680 5f            	clrw	x
7925  1681 97            	ld	xl,a
7926  1682 6f0f          	clr	(_i_main_bps_cnt,x)
7927                     ; 1934 	i_main_flag[mess[6]]=1;
7929  1684 b6c9          	ld	a,_mess+6
7930  1686 5f            	clrw	x
7931  1687 97            	ld	xl,a
7932  1688 a601          	ld	a,#1
7933  168a e71a          	ld	(_i_main_flag,x),a
7934                     ; 1935 	if(bMAIN)
7936                     	btst	_bMAIN
7937  1691 2476          	jruge	L3603
7938                     ; 1937 		i_main[mess[6]]=(signed short)mess[8]+(((signed short)mess[9])*256);
7940  1693 b6cc          	ld	a,_mess+9
7941  1695 5f            	clrw	x
7942  1696 97            	ld	xl,a
7943  1697 4f            	clr	a
7944  1698 02            	rlwa	x,a
7945  1699 1f01          	ldw	(OFST-6,sp),x
7946  169b b6cb          	ld	a,_mess+8
7947  169d 5f            	clrw	x
7948  169e 97            	ld	xl,a
7949  169f 72fb01        	addw	x,(OFST-6,sp)
7950  16a2 b6c9          	ld	a,_mess+6
7951  16a4 905f          	clrw	y
7952  16a6 9097          	ld	yl,a
7953  16a8 9058          	sllw	y
7954  16aa 90ef20        	ldw	(_i_main,y),x
7955                     ; 1938 		i_main[adress]=I;
7957  16ad c600f7        	ld	a,_adress
7958  16b0 5f            	clrw	x
7959  16b1 97            	ld	xl,a
7960  16b2 58            	sllw	x
7961  16b3 90ce0010      	ldw	y,_I
7962  16b7 ef20          	ldw	(_i_main,x),y
7963                     ; 1939      	i_main_flag[adress]=1;
7965  16b9 c600f7        	ld	a,_adress
7966  16bc 5f            	clrw	x
7967  16bd 97            	ld	xl,a
7968  16be a601          	ld	a,#1
7969  16c0 e71a          	ld	(_i_main_flag,x),a
7970  16c2 2045          	jra	L3603
7971  16c4               L5243:
7972                     ; 1943 else if((mess[7]==PUTTM2)&&(mess[6]!=adress)&&(mess[6]>=0)&&(mess[6]<=5))
7974  16c4 b6ca          	ld	a,_mess+7
7975  16c6 a1db          	cp	a,#219
7976  16c8 263f          	jrne	L3603
7978  16ca b6c9          	ld	a,_mess+6
7979  16cc c100f7        	cp	a,_adress
7980  16cf 2738          	jreq	L3603
7982  16d1 b6c9          	ld	a,_mess+6
7983  16d3 a106          	cp	a,#6
7984  16d5 2432          	jruge	L3603
7985                     ; 1945 	i_main_bps_cnt[mess[6]]=0;
7987  16d7 b6c9          	ld	a,_mess+6
7988  16d9 5f            	clrw	x
7989  16da 97            	ld	xl,a
7990  16db 6f0f          	clr	(_i_main_bps_cnt,x)
7991                     ; 1946 	i_main_flag[mess[6]]=1;		
7993  16dd b6c9          	ld	a,_mess+6
7994  16df 5f            	clrw	x
7995  16e0 97            	ld	xl,a
7996  16e1 a601          	ld	a,#1
7997  16e3 e71a          	ld	(_i_main_flag,x),a
7998                     ; 1947 	if(bMAIN)
8000                     	btst	_bMAIN
8001  16ea 241d          	jruge	L3603
8002                     ; 1949 		if(mess[9]==0)i_main_flag[i]=1;
8004  16ec 3dcc          	tnz	_mess+9
8005  16ee 260a          	jrne	L7343
8008  16f0 7b07          	ld	a,(OFST+0,sp)
8009  16f2 5f            	clrw	x
8010  16f3 97            	ld	xl,a
8011  16f4 a601          	ld	a,#1
8012  16f6 e71a          	ld	(_i_main_flag,x),a
8014  16f8 2006          	jra	L1443
8015  16fa               L7343:
8016                     ; 1950 		else i_main_flag[i]=0;
8018  16fa 7b07          	ld	a,(OFST+0,sp)
8019  16fc 5f            	clrw	x
8020  16fd 97            	ld	xl,a
8021  16fe 6f1a          	clr	(_i_main_flag,x)
8022  1700               L1443:
8023                     ; 1951 		i_main_flag[adress]=1;
8025  1700 c600f7        	ld	a,_adress
8026  1703 5f            	clrw	x
8027  1704 97            	ld	xl,a
8028  1705 a601          	ld	a,#1
8029  1707 e71a          	ld	(_i_main_flag,x),a
8030  1709               L3603:
8031                     ; 1957 can_in_an_end:
8031                     ; 1958 bCAN_RX=0;
8033  1709 3f04          	clr	_bCAN_RX
8034                     ; 1959 }   
8037  170b 5b07          	addw	sp,#7
8038  170d 81            	ret
8061                     ; 1962 void t4_init(void){
8062                     	switch	.text
8063  170e               _t4_init:
8067                     ; 1963 	TIM4->PSCR = 4;
8069  170e 35045345      	mov	21317,#4
8070                     ; 1964 	TIM4->ARR= 61;
8072  1712 353d5346      	mov	21318,#61
8073                     ; 1965 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
8075  1716 72105341      	bset	21313,#0
8076                     ; 1967 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
8078  171a 35855340      	mov	21312,#133
8079                     ; 1969 }
8082  171e 81            	ret
8105                     ; 1972 void t1_init(void)
8105                     ; 1973 {
8106                     	switch	.text
8107  171f               _t1_init:
8111                     ; 1974 TIM1->ARRH= 0x03;
8113  171f 35035262      	mov	21090,#3
8114                     ; 1975 TIM1->ARRL= 0xff;
8116  1723 35ff5263      	mov	21091,#255
8117                     ; 1976 TIM1->CCR1H= 0x00;	
8119  1727 725f5265      	clr	21093
8120                     ; 1977 TIM1->CCR1L= 0xff;
8122  172b 35ff5266      	mov	21094,#255
8123                     ; 1978 TIM1->CCR2H= 0x00;	
8125  172f 725f5267      	clr	21095
8126                     ; 1979 TIM1->CCR2L= 0x00;
8128  1733 725f5268      	clr	21096
8129                     ; 1980 TIM1->CCR3H= 0x00;	
8131  1737 725f5269      	clr	21097
8132                     ; 1981 TIM1->CCR3L= 0x64;
8134  173b 3564526a      	mov	21098,#100
8135                     ; 1983 TIM1->CCMR1= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8137  173f 35685258      	mov	21080,#104
8138                     ; 1984 TIM1->CCMR2= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8140  1743 35685259      	mov	21081,#104
8141                     ; 1985 TIM1->CCMR3= ((6<<4) & TIM1_CCMR_OCM) | TIM1_CCMR_OCxPE; //OC2 toggle mode, prelouded
8143  1747 3568525a      	mov	21082,#104
8144                     ; 1986 TIM1->CCER1= TIM1_CCER1_CC1E | TIM1_CCER1_CC2E ; //OC1, OC2 output pins enabled
8146  174b 3511525c      	mov	21084,#17
8147                     ; 1987 TIM1->CCER2= TIM1_CCER2_CC3E; //OC1, OC2 output pins enabled
8149  174f 3501525d      	mov	21085,#1
8150                     ; 1988 TIM1->CR1=(TIM1_CR1_CEN | TIM1_CR1_ARPE);
8152  1753 35815250      	mov	21072,#129
8153                     ; 1989 TIM1->BKR|= TIM1_BKR_AOE;
8155  1757 721c526d      	bset	21101,#6
8156                     ; 1990 }
8159  175b 81            	ret
8184                     ; 1994 void adc2_init(void)
8184                     ; 1995 {
8185                     	switch	.text
8186  175c               _adc2_init:
8190                     ; 1996 adc_plazma[0]++;
8192  175c beb5          	ldw	x,_adc_plazma
8193  175e 1c0001        	addw	x,#1
8194  1761 bfb5          	ldw	_adc_plazma,x
8195                     ; 2020 GPIOB->DDR&=~(1<<4);
8197  1763 72195007      	bres	20487,#4
8198                     ; 2021 GPIOB->CR1&=~(1<<4);
8200  1767 72195008      	bres	20488,#4
8201                     ; 2022 GPIOB->CR2&=~(1<<4);
8203  176b 72195009      	bres	20489,#4
8204                     ; 2024 GPIOB->DDR&=~(1<<5);
8206  176f 721b5007      	bres	20487,#5
8207                     ; 2025 GPIOB->CR1&=~(1<<5);
8209  1773 721b5008      	bres	20488,#5
8210                     ; 2026 GPIOB->CR2&=~(1<<5);
8212  1777 721b5009      	bres	20489,#5
8213                     ; 2028 GPIOB->DDR&=~(1<<6);
8215  177b 721d5007      	bres	20487,#6
8216                     ; 2029 GPIOB->CR1&=~(1<<6);
8218  177f 721d5008      	bres	20488,#6
8219                     ; 2030 GPIOB->CR2&=~(1<<6);
8221  1783 721d5009      	bres	20489,#6
8222                     ; 2032 GPIOB->DDR&=~(1<<7);
8224  1787 721f5007      	bres	20487,#7
8225                     ; 2033 GPIOB->CR1&=~(1<<7);
8227  178b 721f5008      	bres	20488,#7
8228                     ; 2034 GPIOB->CR2&=~(1<<7);
8230  178f 721f5009      	bres	20489,#7
8231                     ; 2036 GPIOB->DDR&=~(1<<2);
8233  1793 72155007      	bres	20487,#2
8234                     ; 2037 GPIOB->CR1&=~(1<<2);
8236  1797 72155008      	bres	20488,#2
8237                     ; 2038 GPIOB->CR2&=~(1<<2);
8239  179b 72155009      	bres	20489,#2
8240                     ; 2047 ADC2->TDRL=0xff;
8242  179f 35ff5407      	mov	21511,#255
8243                     ; 2049 ADC2->CR2=0x08;
8245  17a3 35085402      	mov	21506,#8
8246                     ; 2050 ADC2->CR1=0x40;
8248  17a7 35405401      	mov	21505,#64
8249                     ; 2053 	if(adc_ch==5)ADC2->CSR=0x22;
8251  17ab b6c2          	ld	a,_adc_ch
8252  17ad a105          	cp	a,#5
8253  17af 2606          	jrne	L3743
8256  17b1 35225400      	mov	21504,#34
8258  17b5 2007          	jra	L5743
8259  17b7               L3743:
8260                     ; 2054 	else ADC2->CSR=0x20+adc_ch+3;
8262  17b7 b6c2          	ld	a,_adc_ch
8263  17b9 ab23          	add	a,#35
8264  17bb c75400        	ld	21504,a
8265  17be               L5743:
8266                     ; 2056 	ADC2->CR1|=1;
8268  17be 72105401      	bset	21505,#0
8269                     ; 2057 	ADC2->CR1|=1;
8271  17c2 72105401      	bset	21505,#0
8272                     ; 2060 adc_plazma[1]=adc_ch;
8274  17c6 b6c2          	ld	a,_adc_ch
8275  17c8 5f            	clrw	x
8276  17c9 97            	ld	xl,a
8277  17ca bfb7          	ldw	_adc_plazma+2,x
8278                     ; 2061 }
8281  17cc 81            	ret
8317                     ; 2069 @far @interrupt void TIM4_UPD_Interrupt (void) 
8317                     ; 2070 {
8319                     	switch	.text
8320  17cd               f_TIM4_UPD_Interrupt:
8324                     ; 2071 TIM4->SR1&=~TIM4_SR1_UIF;
8326  17cd 72115342      	bres	21314,#0
8327                     ; 2073 if(++pwm_vent_cnt>=10)pwm_vent_cnt=0;
8329  17d1 3c0e          	inc	_pwm_vent_cnt
8330  17d3 b60e          	ld	a,_pwm_vent_cnt
8331  17d5 a10a          	cp	a,#10
8332  17d7 2502          	jrult	L7053
8335  17d9 3f0e          	clr	_pwm_vent_cnt
8336  17db               L7053:
8337                     ; 2074 GPIOB->ODR|=(1<<3);
8339  17db 72165005      	bset	20485,#3
8340                     ; 2075 if(pwm_vent_cnt>=5)GPIOB->ODR&=~(1<<3);
8342  17df b60e          	ld	a,_pwm_vent_cnt
8343  17e1 a105          	cp	a,#5
8344  17e3 2504          	jrult	L1153
8347  17e5 72175005      	bres	20485,#3
8348  17e9               L1153:
8349                     ; 2079 if(++t0_cnt00>=10)
8351  17e9 9c            	rvf
8352  17ea ce0000        	ldw	x,_t0_cnt00
8353  17ed 1c0001        	addw	x,#1
8354  17f0 cf0000        	ldw	_t0_cnt00,x
8355  17f3 a3000a        	cpw	x,#10
8356  17f6 2f08          	jrslt	L3153
8357                     ; 2081 	t0_cnt00=0;
8359  17f8 5f            	clrw	x
8360  17f9 cf0000        	ldw	_t0_cnt00,x
8361                     ; 2082 	b1000Hz=1;
8363  17fc 72100004      	bset	_b1000Hz
8364  1800               L3153:
8365                     ; 2085 if(++t0_cnt0>=100)
8367  1800 9c            	rvf
8368  1801 ce0002        	ldw	x,_t0_cnt0
8369  1804 1c0001        	addw	x,#1
8370  1807 cf0002        	ldw	_t0_cnt0,x
8371  180a a30064        	cpw	x,#100
8372  180d 2f54          	jrslt	L5153
8373                     ; 2087 	t0_cnt0=0;
8375  180f 5f            	clrw	x
8376  1810 cf0002        	ldw	_t0_cnt0,x
8377                     ; 2088 	b100Hz=1;
8379  1813 72100009      	bset	_b100Hz
8380                     ; 2090 	if(++t0_cnt1>=10)
8382  1817 725c0004      	inc	_t0_cnt1
8383  181b c60004        	ld	a,_t0_cnt1
8384  181e a10a          	cp	a,#10
8385  1820 2508          	jrult	L7153
8386                     ; 2092 		t0_cnt1=0;
8388  1822 725f0004      	clr	_t0_cnt1
8389                     ; 2093 		b10Hz=1;
8391  1826 72100008      	bset	_b10Hz
8392  182a               L7153:
8393                     ; 2096 	if(++t0_cnt2>=20)
8395  182a 725c0005      	inc	_t0_cnt2
8396  182e c60005        	ld	a,_t0_cnt2
8397  1831 a114          	cp	a,#20
8398  1833 2508          	jrult	L1253
8399                     ; 2098 		t0_cnt2=0;
8401  1835 725f0005      	clr	_t0_cnt2
8402                     ; 2099 		b5Hz=1;
8404  1839 72100007      	bset	_b5Hz
8405  183d               L1253:
8406                     ; 2103 	if(++t0_cnt4>=50)
8408  183d 725c0007      	inc	_t0_cnt4
8409  1841 c60007        	ld	a,_t0_cnt4
8410  1844 a132          	cp	a,#50
8411  1846 2508          	jrult	L3253
8412                     ; 2105 		t0_cnt4=0;
8414  1848 725f0007      	clr	_t0_cnt4
8415                     ; 2106 		b2Hz=1;
8417  184c 72100006      	bset	_b2Hz
8418  1850               L3253:
8419                     ; 2109 	if(++t0_cnt3>=100)
8421  1850 725c0006      	inc	_t0_cnt3
8422  1854 c60006        	ld	a,_t0_cnt3
8423  1857 a164          	cp	a,#100
8424  1859 2508          	jrult	L5153
8425                     ; 2111 		t0_cnt3=0;
8427  185b 725f0006      	clr	_t0_cnt3
8428                     ; 2112 		b1Hz=1;
8430  185f 72100005      	bset	_b1Hz
8431  1863               L5153:
8432                     ; 2118 }
8435  1863 80            	iret
8460                     ; 2121 @far @interrupt void CAN_RX_Interrupt (void) 
8460                     ; 2122 {
8461                     	switch	.text
8462  1864               f_CAN_RX_Interrupt:
8466                     ; 2124 CAN->PSR= 7;									// page 7 - read messsage
8468  1864 35075427      	mov	21543,#7
8469                     ; 2126 memcpy(&mess[0], &CAN->Page.RxFIFO.MFMI, 14); // compare the message content
8471  1868 ae000e        	ldw	x,#14
8472  186b               L032:
8473  186b d65427        	ld	a,(21543,x)
8474  186e e7c2          	ld	(_mess-1,x),a
8475  1870 5a            	decw	x
8476  1871 26f8          	jrne	L032
8477                     ; 2137 bCAN_RX=1;
8479  1873 35010004      	mov	_bCAN_RX,#1
8480                     ; 2138 CAN->RFR|=(1<<5);
8482  1877 721a5424      	bset	21540,#5
8483                     ; 2140 }
8486  187b 80            	iret
8509                     ; 2143 @far @interrupt void CAN_TX_Interrupt (void) 
8509                     ; 2144 {
8510                     	switch	.text
8511  187c               f_CAN_TX_Interrupt:
8515                     ; 2145 if((CAN->TSR)&(1<<0))
8517  187c c65422        	ld	a,21538
8518  187f a501          	bcp	a,#1
8519  1881 2708          	jreq	L7453
8520                     ; 2147 	bTX_FREE=1;	
8522  1883 35010003      	mov	_bTX_FREE,#1
8523                     ; 2149 	CAN->TSR|=(1<<0);
8525  1887 72105422      	bset	21538,#0
8526  188b               L7453:
8527                     ; 2151 }
8530  188b 80            	iret
8610                     ; 2154 @far @interrupt void ADC2_EOC_Interrupt (void) {
8611                     	switch	.text
8612  188c               f_ADC2_EOC_Interrupt:
8614       0000000d      OFST:	set	13
8615  188c be00          	ldw	x,c_x
8616  188e 89            	pushw	x
8617  188f be00          	ldw	x,c_y
8618  1891 89            	pushw	x
8619  1892 be02          	ldw	x,c_lreg+2
8620  1894 89            	pushw	x
8621  1895 be00          	ldw	x,c_lreg
8622  1897 89            	pushw	x
8623  1898 520d          	subw	sp,#13
8626                     ; 2159 adc_plazma[2]++;
8628  189a beb9          	ldw	x,_adc_plazma+4
8629  189c 1c0001        	addw	x,#1
8630  189f bfb9          	ldw	_adc_plazma+4,x
8631                     ; 2166 ADC2->CSR&=~(1<<7);
8633  18a1 721f5400      	bres	21504,#7
8634                     ; 2168 temp_adc=(((signed long)(ADC2->DRH))*256)+((signed long)(ADC2->DRL));
8636  18a5 c65405        	ld	a,21509
8637  18a8 b703          	ld	c_lreg+3,a
8638  18aa 3f02          	clr	c_lreg+2
8639  18ac 3f01          	clr	c_lreg+1
8640  18ae 3f00          	clr	c_lreg
8641  18b0 96            	ldw	x,sp
8642  18b1 1c0001        	addw	x,#OFST-12
8643  18b4 cd0000        	call	c_rtol
8645  18b7 c65404        	ld	a,21508
8646  18ba 5f            	clrw	x
8647  18bb 97            	ld	xl,a
8648  18bc 90ae0100      	ldw	y,#256
8649  18c0 cd0000        	call	c_umul
8651  18c3 96            	ldw	x,sp
8652  18c4 1c0001        	addw	x,#OFST-12
8653  18c7 cd0000        	call	c_ladd
8655  18ca 96            	ldw	x,sp
8656  18cb 1c000a        	addw	x,#OFST-3
8657  18ce cd0000        	call	c_rtol
8659                     ; 2173 if(adr_drv_stat==1)
8661  18d1 b602          	ld	a,_adr_drv_stat
8662  18d3 a101          	cp	a,#1
8663  18d5 260b          	jrne	L7063
8664                     ; 2175 	adr_drv_stat=2;
8666  18d7 35020002      	mov	_adr_drv_stat,#2
8667                     ; 2176 	adc_buff_[0]=temp_adc;
8669  18db 1e0c          	ldw	x,(OFST-1,sp)
8670  18dd cf00ff        	ldw	_adc_buff_,x
8672  18e0 2020          	jra	L1163
8673  18e2               L7063:
8674                     ; 2179 else if(adr_drv_stat==3)
8676  18e2 b602          	ld	a,_adr_drv_stat
8677  18e4 a103          	cp	a,#3
8678  18e6 260b          	jrne	L3163
8679                     ; 2181 	adr_drv_stat=4;
8681  18e8 35040002      	mov	_adr_drv_stat,#4
8682                     ; 2182 	adc_buff_[1]=temp_adc;
8684  18ec 1e0c          	ldw	x,(OFST-1,sp)
8685  18ee cf0101        	ldw	_adc_buff_+2,x
8687  18f1 200f          	jra	L1163
8688  18f3               L3163:
8689                     ; 2185 else if(adr_drv_stat==5)
8691  18f3 b602          	ld	a,_adr_drv_stat
8692  18f5 a105          	cp	a,#5
8693  18f7 2609          	jrne	L1163
8694                     ; 2187 	adr_drv_stat=6;
8696  18f9 35060002      	mov	_adr_drv_stat,#6
8697                     ; 2188 	adc_buff_[9]=temp_adc;
8699  18fd 1e0c          	ldw	x,(OFST-1,sp)
8700  18ff cf0111        	ldw	_adc_buff_+18,x
8701  1902               L1163:
8702                     ; 2191 adc_buff_buff[adc_ch][adc_cnt_cnt]=temp_adc;
8704  1902 b6b3          	ld	a,_adc_cnt_cnt
8705  1904 5f            	clrw	x
8706  1905 97            	ld	xl,a
8707  1906 58            	sllw	x
8708  1907 1f03          	ldw	(OFST-10,sp),x
8709  1909 b6c2          	ld	a,_adc_ch
8710  190b 97            	ld	xl,a
8711  190c a610          	ld	a,#16
8712  190e 42            	mul	x,a
8713  190f 72fb03        	addw	x,(OFST-10,sp)
8714  1912 160c          	ldw	y,(OFST-1,sp)
8715  1914 df0056        	ldw	(_adc_buff_buff,x),y
8716                     ; 2193 adc_ch++;
8718  1917 3cc2          	inc	_adc_ch
8719                     ; 2194 if(adc_ch>=6)
8721  1919 b6c2          	ld	a,_adc_ch
8722  191b a106          	cp	a,#6
8723  191d 2516          	jrult	L1263
8724                     ; 2196 	adc_ch=0;
8726  191f 3fc2          	clr	_adc_ch
8727                     ; 2197 	adc_cnt_cnt++;
8729  1921 3cb3          	inc	_adc_cnt_cnt
8730                     ; 2198 	if(adc_cnt_cnt>=8)
8732  1923 b6b3          	ld	a,_adc_cnt_cnt
8733  1925 a108          	cp	a,#8
8734  1927 250c          	jrult	L1263
8735                     ; 2200 		adc_cnt_cnt=0;
8737  1929 3fb3          	clr	_adc_cnt_cnt
8738                     ; 2201 		adc_cnt++;
8740  192b 3cc1          	inc	_adc_cnt
8741                     ; 2202 		if(adc_cnt>=16)
8743  192d b6c1          	ld	a,_adc_cnt
8744  192f a110          	cp	a,#16
8745  1931 2502          	jrult	L1263
8746                     ; 2204 			adc_cnt=0;
8748  1933 3fc1          	clr	_adc_cnt
8749  1935               L1263:
8750                     ; 2208 if(adc_cnt_cnt==0)
8752  1935 3db3          	tnz	_adc_cnt_cnt
8753  1937 2660          	jrne	L7263
8754                     ; 2212 	tempSS=0;
8756  1939 ae0000        	ldw	x,#0
8757  193c 1f07          	ldw	(OFST-6,sp),x
8758  193e ae0000        	ldw	x,#0
8759  1941 1f05          	ldw	(OFST-8,sp),x
8760                     ; 2213 	for(i=0;i<8;i++)
8762  1943 0f09          	clr	(OFST-4,sp)
8763  1945               L1363:
8764                     ; 2215 		tempSS+=(signed long)adc_buff_buff[adc_ch][i];
8766  1945 7b09          	ld	a,(OFST-4,sp)
8767  1947 5f            	clrw	x
8768  1948 97            	ld	xl,a
8769  1949 58            	sllw	x
8770  194a 1f03          	ldw	(OFST-10,sp),x
8771  194c b6c2          	ld	a,_adc_ch
8772  194e 97            	ld	xl,a
8773  194f a610          	ld	a,#16
8774  1951 42            	mul	x,a
8775  1952 72fb03        	addw	x,(OFST-10,sp)
8776  1955 de0056        	ldw	x,(_adc_buff_buff,x)
8777  1958 cd0000        	call	c_itolx
8779  195b 96            	ldw	x,sp
8780  195c 1c0005        	addw	x,#OFST-8
8781  195f cd0000        	call	c_lgadd
8783                     ; 2213 	for(i=0;i<8;i++)
8785  1962 0c09          	inc	(OFST-4,sp)
8788  1964 7b09          	ld	a,(OFST-4,sp)
8789  1966 a108          	cp	a,#8
8790  1968 25db          	jrult	L1363
8791                     ; 2217 	adc_buff[adc_ch][adc_cnt]=(signed short)(tempSS>>3);
8793  196a 96            	ldw	x,sp
8794  196b 1c0005        	addw	x,#OFST-8
8795  196e cd0000        	call	c_ltor
8797  1971 a603          	ld	a,#3
8798  1973 cd0000        	call	c_lrsh
8800  1976 be02          	ldw	x,c_lreg+2
8801  1978 b6c1          	ld	a,_adc_cnt
8802  197a 905f          	clrw	y
8803  197c 9097          	ld	yl,a
8804  197e 9058          	sllw	y
8805  1980 1703          	ldw	(OFST-10,sp),y
8806  1982 b6c2          	ld	a,_adc_ch
8807  1984 905f          	clrw	y
8808  1986 9097          	ld	yl,a
8809  1988 9058          	sllw	y
8810  198a 9058          	sllw	y
8811  198c 9058          	sllw	y
8812  198e 9058          	sllw	y
8813  1990 9058          	sllw	y
8814  1992 72f903        	addw	y,(OFST-10,sp)
8815  1995 90df0113      	ldw	(_adc_buff,y),x
8816  1999               L7263:
8817                     ; 2221 if((adc_cnt&0x03)==0)
8819  1999 b6c1          	ld	a,_adc_cnt
8820  199b a503          	bcp	a,#3
8821  199d 264b          	jrne	L7363
8822                     ; 2225 	tempSS=0;
8824  199f ae0000        	ldw	x,#0
8825  19a2 1f07          	ldw	(OFST-6,sp),x
8826  19a4 ae0000        	ldw	x,#0
8827  19a7 1f05          	ldw	(OFST-8,sp),x
8828                     ; 2226 	for(i=0;i<16;i++)
8830  19a9 0f09          	clr	(OFST-4,sp)
8831  19ab               L1463:
8832                     ; 2228 		tempSS+=(signed long)adc_buff[adc_ch][i];
8834  19ab 7b09          	ld	a,(OFST-4,sp)
8835  19ad 5f            	clrw	x
8836  19ae 97            	ld	xl,a
8837  19af 58            	sllw	x
8838  19b0 1f03          	ldw	(OFST-10,sp),x
8839  19b2 b6c2          	ld	a,_adc_ch
8840  19b4 97            	ld	xl,a
8841  19b5 a620          	ld	a,#32
8842  19b7 42            	mul	x,a
8843  19b8 72fb03        	addw	x,(OFST-10,sp)
8844  19bb de0113        	ldw	x,(_adc_buff,x)
8845  19be cd0000        	call	c_itolx
8847  19c1 96            	ldw	x,sp
8848  19c2 1c0005        	addw	x,#OFST-8
8849  19c5 cd0000        	call	c_lgadd
8851                     ; 2226 	for(i=0;i<16;i++)
8853  19c8 0c09          	inc	(OFST-4,sp)
8856  19ca 7b09          	ld	a,(OFST-4,sp)
8857  19cc a110          	cp	a,#16
8858  19ce 25db          	jrult	L1463
8859                     ; 2230 	adc_buff_[adc_ch]=(signed short)(tempSS>>4);
8861  19d0 96            	ldw	x,sp
8862  19d1 1c0005        	addw	x,#OFST-8
8863  19d4 cd0000        	call	c_ltor
8865  19d7 a604          	ld	a,#4
8866  19d9 cd0000        	call	c_lrsh
8868  19dc be02          	ldw	x,c_lreg+2
8869  19de b6c2          	ld	a,_adc_ch
8870  19e0 905f          	clrw	y
8871  19e2 9097          	ld	yl,a
8872  19e4 9058          	sllw	y
8873  19e6 90df00ff      	ldw	(_adc_buff_,y),x
8874  19ea               L7363:
8875                     ; 2237 if(adc_ch==0)adc_buff_5=temp_adc;
8877  19ea 3dc2          	tnz	_adc_ch
8878  19ec 2605          	jrne	L7463
8881  19ee 1e0c          	ldw	x,(OFST-1,sp)
8882  19f0 cf00fd        	ldw	_adc_buff_5,x
8883  19f3               L7463:
8884                     ; 2238 if(adc_ch==2)adc_buff_1=temp_adc;
8886  19f3 b6c2          	ld	a,_adc_ch
8887  19f5 a102          	cp	a,#2
8888  19f7 2605          	jrne	L1563
8891  19f9 1e0c          	ldw	x,(OFST-1,sp)
8892  19fb cf00fb        	ldw	_adc_buff_1,x
8893  19fe               L1563:
8894                     ; 2240 adc_plazma_short++;
8896  19fe bebf          	ldw	x,_adc_plazma_short
8897  1a00 1c0001        	addw	x,#1
8898  1a03 bfbf          	ldw	_adc_plazma_short,x
8899                     ; 2242 }
8902  1a05 5b0d          	addw	sp,#13
8903  1a07 85            	popw	x
8904  1a08 bf00          	ldw	c_lreg,x
8905  1a0a 85            	popw	x
8906  1a0b bf02          	ldw	c_lreg+2,x
8907  1a0d 85            	popw	x
8908  1a0e bf00          	ldw	c_y,x
8909  1a10 85            	popw	x
8910  1a11 bf00          	ldw	c_x,x
8911  1a13 80            	iret
8969                     ; 2251 main()
8969                     ; 2252 {
8971                     	switch	.text
8972  1a14               _main:
8976                     ; 2254 CLK->ECKR|=1;
8978  1a14 721050c1      	bset	20673,#0
8980  1a18               L5663:
8981                     ; 2255 while((CLK->ECKR & 2) == 0);
8983  1a18 c650c1        	ld	a,20673
8984  1a1b a502          	bcp	a,#2
8985  1a1d 27f9          	jreq	L5663
8986                     ; 2256 CLK->SWCR|=2;
8988  1a1f 721250c5      	bset	20677,#1
8989                     ; 2257 CLK->SWR=0xB4;
8991  1a23 35b450c4      	mov	20676,#180
8992                     ; 2259 delay_ms(200);
8994  1a27 ae00c8        	ldw	x,#200
8995  1a2a cd0121        	call	_delay_ms
8997                     ; 2260 FLASH_DUKR=0xae;
8999  1a2d 35ae5064      	mov	_FLASH_DUKR,#174
9000                     ; 2261 FLASH_DUKR=0x56;
9002  1a31 35565064      	mov	_FLASH_DUKR,#86
9003                     ; 2262 enableInterrupts();
9006  1a35 9a            rim
9008                     ; 2265 adr_drv_v3();
9011  1a36 cd0d14        	call	_adr_drv_v3
9013                     ; 2269 t4_init();
9015  1a39 cd170e        	call	_t4_init
9017                     ; 2271 		GPIOG->DDR|=(1<<0);
9019  1a3c 72105020      	bset	20512,#0
9020                     ; 2272 		GPIOG->CR1|=(1<<0);
9022  1a40 72105021      	bset	20513,#0
9023                     ; 2273 		GPIOG->CR2&=~(1<<0);	
9025  1a44 72115022      	bres	20514,#0
9026                     ; 2276 		GPIOG->DDR&=~(1<<1);
9028  1a48 72135020      	bres	20512,#1
9029                     ; 2277 		GPIOG->CR1|=(1<<1);
9031  1a4c 72125021      	bset	20513,#1
9032                     ; 2278 		GPIOG->CR2&=~(1<<1);
9034  1a50 72135022      	bres	20514,#1
9035                     ; 2280 init_CAN();
9037  1a54 cd0f04        	call	_init_CAN
9039                     ; 2285 GPIOC->DDR|=(1<<1);
9041  1a57 7212500c      	bset	20492,#1
9042                     ; 2286 GPIOC->CR1|=(1<<1);
9044  1a5b 7212500d      	bset	20493,#1
9045                     ; 2287 GPIOC->CR2|=(1<<1);
9047  1a5f 7212500e      	bset	20494,#1
9048                     ; 2289 GPIOC->DDR|=(1<<2);
9050  1a63 7214500c      	bset	20492,#2
9051                     ; 2290 GPIOC->CR1|=(1<<2);
9053  1a67 7214500d      	bset	20493,#2
9054                     ; 2291 GPIOC->CR2|=(1<<2);
9056  1a6b 7214500e      	bset	20494,#2
9057                     ; 2298 t1_init();
9059  1a6f cd171f        	call	_t1_init
9061                     ; 2300 GPIOA->DDR|=(1<<5);
9063  1a72 721a5002      	bset	20482,#5
9064                     ; 2301 GPIOA->CR1|=(1<<5);
9066  1a76 721a5003      	bset	20483,#5
9067                     ; 2302 GPIOA->CR2&=~(1<<5);
9069  1a7a 721b5004      	bres	20484,#5
9070                     ; 2308 GPIOB->DDR&=~(1<<3);
9072  1a7e 72175007      	bres	20487,#3
9073                     ; 2309 GPIOB->CR1&=~(1<<3);
9075  1a82 72175008      	bres	20488,#3
9076                     ; 2310 GPIOB->CR2&=~(1<<3);
9078  1a86 72175009      	bres	20489,#3
9079                     ; 2312 GPIOC->DDR|=(1<<3);
9081  1a8a 7216500c      	bset	20492,#3
9082                     ; 2313 GPIOC->CR1|=(1<<3);
9084  1a8e 7216500d      	bset	20493,#3
9085                     ; 2314 GPIOC->CR2|=(1<<3);
9087  1a92 7216500e      	bset	20494,#3
9088  1a96               L1763:
9089                     ; 2320 	if(b1000Hz)
9091                     	btst	_b1000Hz
9092  1a9b 2407          	jruge	L5763
9093                     ; 2322 		b1000Hz=0;
9095  1a9d 72110004      	bres	_b1000Hz
9096                     ; 2324 		adc2_init();
9098  1aa1 cd175c        	call	_adc2_init
9100  1aa4               L5763:
9101                     ; 2327 	if(bCAN_RX)
9103  1aa4 3d04          	tnz	_bCAN_RX
9104  1aa6 2705          	jreq	L7763
9105                     ; 2329 		bCAN_RX=0;
9107  1aa8 3f04          	clr	_bCAN_RX
9108                     ; 2330 		can_in_an();	
9110  1aaa cd1061        	call	_can_in_an
9112  1aad               L7763:
9113                     ; 2332 	if(b100Hz)
9115                     	btst	_b100Hz
9116  1ab2 2407          	jruge	L1073
9117                     ; 2334 		b100Hz=0;
9119  1ab4 72110009      	bres	_b100Hz
9120                     ; 2344 		can_tx_hndl();
9122  1ab8 cd0ff7        	call	_can_tx_hndl
9124  1abb               L1073:
9125                     ; 2347 	if(b10Hz)
9127                     	btst	_b10Hz
9128  1ac0 2425          	jruge	L3073
9129                     ; 2349 		b10Hz=0;
9131  1ac2 72110008      	bres	_b10Hz
9132                     ; 2351 		matemat();
9134  1ac6 cd0845        	call	_matemat
9136                     ; 2352 		led_drv(); 
9138  1ac9 cd03ee        	call	_led_drv
9140                     ; 2353 	  link_drv();
9142  1acc cd04dc        	call	_link_drv
9144                     ; 2355 	  JP_drv();
9146  1acf cd0451        	call	_JP_drv
9148                     ; 2356 	  flags_drv();
9150  1ad2 cd0cc9        	call	_flags_drv
9152                     ; 2358 		if(main_cnt10<100)main_cnt10++;
9154  1ad5 9c            	rvf
9155  1ad6 ce0253        	ldw	x,_main_cnt10
9156  1ad9 a30064        	cpw	x,#100
9157  1adc 2e09          	jrsge	L3073
9160  1ade ce0253        	ldw	x,_main_cnt10
9161  1ae1 1c0001        	addw	x,#1
9162  1ae4 cf0253        	ldw	_main_cnt10,x
9163  1ae7               L3073:
9164                     ; 2361 	if(b5Hz)
9166                     	btst	_b5Hz
9167  1aec 241c          	jruge	L7073
9168                     ; 2363 		b5Hz=0;
9170  1aee 72110007      	bres	_b5Hz
9171                     ; 2365 		pwr_drv();		//воздействие на силу
9173  1af2 cd0688        	call	_pwr_drv
9175                     ; 2366 		led_hndl();
9177  1af5 cd0163        	call	_led_hndl
9179                     ; 2368 		vent_drv();
9181  1af8 cd0534        	call	_vent_drv
9183                     ; 2370 		if(main_cnt1<1000)main_cnt1++;
9185  1afb 9c            	rvf
9186  1afc be57          	ldw	x,_main_cnt1
9187  1afe a303e8        	cpw	x,#1000
9188  1b01 2e07          	jrsge	L7073
9191  1b03 be57          	ldw	x,_main_cnt1
9192  1b05 1c0001        	addw	x,#1
9193  1b08 bf57          	ldw	_main_cnt1,x
9194  1b0a               L7073:
9195                     ; 2373 	if(b2Hz)
9197                     	btst	_b2Hz
9198  1b0f 2404          	jruge	L3173
9199                     ; 2375 		b2Hz=0;
9201  1b11 72110006      	bres	_b2Hz
9202  1b15               L3173:
9203                     ; 2384 	if(b1Hz)
9205                     	btst	_b1Hz
9206  1b1a 2503cc1a96    	jruge	L1763
9207                     ; 2386 		b1Hz=0;
9209  1b1f 72110005      	bres	_b1Hz
9210                     ; 2388 	  pwr_hndl();		//вычисление воздействий на силу
9212  1b23 cd06cd        	call	_pwr_hndl
9214                     ; 2389 		temper_drv();			//вычисление аварий температуры
9216  1b26 cd0a36        	call	_temper_drv
9218                     ; 2390 		u_drv();
9220  1b29 cd0b0d        	call	_u_drv
9222                     ; 2392 		if(main_cnt<1000)main_cnt++;
9224  1b2c 9c            	rvf
9225  1b2d ce0255        	ldw	x,_main_cnt
9226  1b30 a303e8        	cpw	x,#1000
9227  1b33 2e09          	jrsge	L7173
9230  1b35 ce0255        	ldw	x,_main_cnt
9231  1b38 1c0001        	addw	x,#1
9232  1b3b cf0255        	ldw	_main_cnt,x
9233  1b3e               L7173:
9234                     ; 2393   		if((link==OFF)||(jp_mode==jp3))apv_hndl();
9236  1b3e b669          	ld	a,_link
9237  1b40 a1aa          	cp	a,#170
9238  1b42 2706          	jreq	L3273
9240  1b44 b650          	ld	a,_jp_mode
9241  1b46 a103          	cp	a,#3
9242  1b48 2603          	jrne	L1273
9243  1b4a               L3273:
9246  1b4a cd0c2a        	call	_apv_hndl
9248  1b4d               L1273:
9249                     ; 2396   		can_error_cnt++;
9251  1b4d 3c6f          	inc	_can_error_cnt
9252                     ; 2397   		if(can_error_cnt>=10)
9254  1b4f b66f          	ld	a,_can_error_cnt
9255  1b51 a10a          	cp	a,#10
9256  1b53 2505          	jrult	L5273
9257                     ; 2399   			can_error_cnt=0;
9259  1b55 3f6f          	clr	_can_error_cnt
9260                     ; 2400 				init_CAN();
9262  1b57 cd0f04        	call	_init_CAN
9264  1b5a               L5273:
9265                     ; 2410 		vent_resurs_hndl();
9267  1b5a cd0000        	call	_vent_resurs_hndl
9269  1b5d ac961a96      	jpf	L1763
10488                     	xdef	_main
10489                     	xdef	f_ADC2_EOC_Interrupt
10490                     	xdef	f_CAN_TX_Interrupt
10491                     	xdef	f_CAN_RX_Interrupt
10492                     	xdef	f_TIM4_UPD_Interrupt
10493                     	xdef	_adc2_init
10494                     	xdef	_t1_init
10495                     	xdef	_t4_init
10496                     	xdef	_can_in_an
10497                     	xdef	_can_tx_hndl
10498                     	xdef	_can_transmit
10499                     	xdef	_init_CAN
10500                     	xdef	_adr_drv_v3
10501                     	xdef	_adr_drv_v4
10502                     	xdef	_flags_drv
10503                     	xdef	_apv_hndl
10504                     	xdef	_apv_stop
10505                     	xdef	_apv_start
10506                     	xdef	_u_drv
10507                     	xdef	_temper_drv
10508                     	xdef	_matemat
10509                     	xdef	_pwr_hndl
10510                     	xdef	_pwr_drv
10511                     	xdef	_vent_drv
10512                     	xdef	_link_drv
10513                     	xdef	_JP_drv
10514                     	xdef	_led_drv
10515                     	xdef	_led_hndl
10516                     	xdef	_delay_ms
10517                     	xdef	_granee
10518                     	xdef	_gran
10519                     	xdef	_vent_resurs_hndl
10520                     	switch	.ubsct
10521  0001               _debug_info_to_uku:
10522  0001 000000000000  	ds.b	6
10523                     	xdef	_debug_info_to_uku
10524  0007               _pwm_u_cnt:
10525  0007 00            	ds.b	1
10526                     	xdef	_pwm_u_cnt
10527  0008               _vent_resurs_tx_cnt:
10528  0008 00            	ds.b	1
10529                     	xdef	_vent_resurs_tx_cnt
10530                     	switch	.bss
10531  0000               _vent_resurs_buff:
10532  0000 00000000      	ds.b	4
10533                     	xdef	_vent_resurs_buff
10534                     	switch	.ubsct
10535  0009               _vent_resurs_sec_cnt:
10536  0009 0000          	ds.b	2
10537                     	xdef	_vent_resurs_sec_cnt
10538                     .eeprom:	section	.data
10539  0000               _vent_resurs:
10540  0000 0000          	ds.b	2
10541                     	xdef	_vent_resurs
10542  0002               _ee_IMAXVENT:
10543  0002 0000          	ds.b	2
10544                     	xdef	_ee_IMAXVENT
10545                     	switch	.ubsct
10546  000b               _bps_class:
10547  000b 00            	ds.b	1
10548                     	xdef	_bps_class
10549  000c               _vent_pwm:
10550  000c 0000          	ds.b	2
10551                     	xdef	_vent_pwm
10552  000e               _pwm_vent_cnt:
10553  000e 00            	ds.b	1
10554                     	xdef	_pwm_vent_cnt
10555                     	switch	.eeprom
10556  0004               _ee_DEVICE:
10557  0004 0000          	ds.b	2
10558                     	xdef	_ee_DEVICE
10559  0006               _ee_AVT_MODE:
10560  0006 0000          	ds.b	2
10561                     	xdef	_ee_AVT_MODE
10562                     	switch	.ubsct
10563  000f               _i_main_bps_cnt:
10564  000f 000000000000  	ds.b	6
10565                     	xdef	_i_main_bps_cnt
10566  0015               _i_main_sigma:
10567  0015 0000          	ds.b	2
10568                     	xdef	_i_main_sigma
10569  0017               _i_main_num_of_bps:
10570  0017 00            	ds.b	1
10571                     	xdef	_i_main_num_of_bps
10572  0018               _i_main_avg:
10573  0018 0000          	ds.b	2
10574                     	xdef	_i_main_avg
10575  001a               _i_main_flag:
10576  001a 000000000000  	ds.b	6
10577                     	xdef	_i_main_flag
10578  0020               _i_main:
10579  0020 000000000000  	ds.b	12
10580                     	xdef	_i_main
10581  002c               _x:
10582  002c 000000000000  	ds.b	12
10583                     	xdef	_x
10584                     	xdef	_volum_u_main_
10585                     	switch	.eeprom
10586  0008               _UU_AVT:
10587  0008 0000          	ds.b	2
10588                     	xdef	_UU_AVT
10589                     	switch	.ubsct
10590  0038               _cnt_net_drv:
10591  0038 00            	ds.b	1
10592                     	xdef	_cnt_net_drv
10593                     	switch	.bit
10594  0001               _bMAIN:
10595  0001 00            	ds.b	1
10596                     	xdef	_bMAIN
10597                     	switch	.ubsct
10598  0039               _plazma_int:
10599  0039 000000000000  	ds.b	6
10600                     	xdef	_plazma_int
10601                     	xdef	_rotor_int
10602  003f               _led_green_buff:
10603  003f 00000000      	ds.b	4
10604                     	xdef	_led_green_buff
10605  0043               _led_red_buff:
10606  0043 00000000      	ds.b	4
10607                     	xdef	_led_red_buff
10608                     	xdef	_led_drv_cnt
10609                     	xdef	_led_green
10610                     	xdef	_led_red
10611  0047               _res_fl_cnt:
10612  0047 00            	ds.b	1
10613                     	xdef	_res_fl_cnt
10614                     	xdef	_bRES_
10615                     	xdef	_bRES
10616                     	switch	.eeprom
10617  000a               _res_fl_:
10618  000a 00            	ds.b	1
10619                     	xdef	_res_fl_
10620  000b               _res_fl:
10621  000b 00            	ds.b	1
10622                     	xdef	_res_fl
10623                     	switch	.ubsct
10624  0048               _cnt_apv_off:
10625  0048 00            	ds.b	1
10626                     	xdef	_cnt_apv_off
10627                     	switch	.bit
10628  0002               _bAPV:
10629  0002 00            	ds.b	1
10630                     	xdef	_bAPV
10631                     	switch	.ubsct
10632  0049               _apv_cnt_:
10633  0049 0000          	ds.b	2
10634                     	xdef	_apv_cnt_
10635  004b               _apv_cnt:
10636  004b 000000        	ds.b	3
10637                     	xdef	_apv_cnt
10638                     	xdef	_bBL_IPS
10639                     	switch	.bit
10640  0003               _bBL:
10641  0003 00            	ds.b	1
10642                     	xdef	_bBL
10643                     	switch	.ubsct
10644  004e               _cnt_JP1:
10645  004e 00            	ds.b	1
10646                     	xdef	_cnt_JP1
10647  004f               _cnt_JP0:
10648  004f 00            	ds.b	1
10649                     	xdef	_cnt_JP0
10650  0050               _jp_mode:
10651  0050 00            	ds.b	1
10652                     	xdef	_jp_mode
10653  0051               _pwm_u_:
10654  0051 0000          	ds.b	2
10655                     	xdef	_pwm_u_
10656                     	xdef	_pwm_i
10657                     	xdef	_pwm_u
10658  0053               _tmax_cnt:
10659  0053 0000          	ds.b	2
10660                     	xdef	_tmax_cnt
10661  0055               _tsign_cnt:
10662  0055 0000          	ds.b	2
10663                     	xdef	_tsign_cnt
10664                     	switch	.eeprom
10665  000c               _ee_UAVT:
10666  000c 0000          	ds.b	2
10667                     	xdef	_ee_UAVT
10668  000e               _ee_tsign:
10669  000e 0000          	ds.b	2
10670                     	xdef	_ee_tsign
10671  0010               _ee_tmax:
10672  0010 0000          	ds.b	2
10673                     	xdef	_ee_tmax
10674  0012               _ee_dU:
10675  0012 0000          	ds.b	2
10676                     	xdef	_ee_dU
10677  0014               _ee_Umax:
10678  0014 0000          	ds.b	2
10679                     	xdef	_ee_Umax
10680  0016               _ee_TZAS:
10681  0016 0000          	ds.b	2
10682                     	xdef	_ee_TZAS
10683                     	switch	.ubsct
10684  0057               _main_cnt1:
10685  0057 0000          	ds.b	2
10686                     	xdef	_main_cnt1
10687  0059               _off_bp_cnt:
10688  0059 00            	ds.b	1
10689                     	xdef	_off_bp_cnt
10690                     	xdef	_vol_i_temp_avar
10691  005a               _flags_tu_cnt_off:
10692  005a 00            	ds.b	1
10693                     	xdef	_flags_tu_cnt_off
10694  005b               _flags_tu_cnt_on:
10695  005b 00            	ds.b	1
10696                     	xdef	_flags_tu_cnt_on
10697  005c               _vol_i_temp:
10698  005c 0000          	ds.b	2
10699                     	xdef	_vol_i_temp
10700  005e               _vol_u_temp:
10701  005e 0000          	ds.b	2
10702                     	xdef	_vol_u_temp
10703                     	switch	.eeprom
10704  0018               __x_ee_:
10705  0018 0000          	ds.b	2
10706                     	xdef	__x_ee_
10707                     	switch	.ubsct
10708  0060               __x_cnt:
10709  0060 0000          	ds.b	2
10710                     	xdef	__x_cnt
10711  0062               __x__:
10712  0062 0000          	ds.b	2
10713                     	xdef	__x__
10714  0064               __x_:
10715  0064 0000          	ds.b	2
10716                     	xdef	__x_
10717  0066               _flags_tu:
10718  0066 00            	ds.b	1
10719                     	xdef	_flags_tu
10720                     	xdef	_flags
10721  0067               _link_cnt:
10722  0067 0000          	ds.b	2
10723                     	xdef	_link_cnt
10724  0069               _link:
10725  0069 00            	ds.b	1
10726                     	xdef	_link
10727  006a               _umin_cnt:
10728  006a 0000          	ds.b	2
10729                     	xdef	_umin_cnt
10730  006c               _umax_cnt:
10731  006c 0000          	ds.b	2
10732                     	xdef	_umax_cnt
10733                     	switch	.eeprom
10734  001a               _ee_K:
10735  001a 000000000000  	ds.b	20
10736                     	xdef	_ee_K
10737                     	switch	.ubsct
10738  006e               _T:
10739  006e 00            	ds.b	1
10740                     	xdef	_T
10741                     	switch	.bss
10742  0004               _Uin:
10743  0004 0000          	ds.b	2
10744                     	xdef	_Uin
10745  0006               _Usum:
10746  0006 0000          	ds.b	2
10747                     	xdef	_Usum
10748  0008               _U_out_const:
10749  0008 0000          	ds.b	2
10750                     	xdef	_U_out_const
10751  000a               _Unecc:
10752  000a 0000          	ds.b	2
10753                     	xdef	_Unecc
10754  000c               _Ui:
10755  000c 0000          	ds.b	2
10756                     	xdef	_Ui
10757  000e               _Un:
10758  000e 0000          	ds.b	2
10759                     	xdef	_Un
10760  0010               _I:
10761  0010 0000          	ds.b	2
10762                     	xdef	_I
10763                     	switch	.ubsct
10764  006f               _can_error_cnt:
10765  006f 00            	ds.b	1
10766                     	xdef	_can_error_cnt
10767                     	xdef	_bCAN_RX
10768  0070               _tx_busy_cnt:
10769  0070 00            	ds.b	1
10770                     	xdef	_tx_busy_cnt
10771                     	xdef	_bTX_FREE
10772  0071               _can_buff_rd_ptr:
10773  0071 00            	ds.b	1
10774                     	xdef	_can_buff_rd_ptr
10775  0072               _can_buff_wr_ptr:
10776  0072 00            	ds.b	1
10777                     	xdef	_can_buff_wr_ptr
10778  0073               _can_out_buff:
10779  0073 000000000000  	ds.b	64
10780                     	xdef	_can_out_buff
10781                     	switch	.bss
10782  0012               _pwm_u_buff_cnt:
10783  0012 00            	ds.b	1
10784                     	xdef	_pwm_u_buff_cnt
10785  0013               _pwm_u_buff_ptr:
10786  0013 00            	ds.b	1
10787                     	xdef	_pwm_u_buff_ptr
10788  0014               _pwm_u_buff_:
10789  0014 0000          	ds.b	2
10790                     	xdef	_pwm_u_buff_
10791  0016               _pwm_u_buff:
10792  0016 000000000000  	ds.b	64
10793                     	xdef	_pwm_u_buff
10794                     	switch	.ubsct
10795  00b3               _adc_cnt_cnt:
10796  00b3 00            	ds.b	1
10797                     	xdef	_adc_cnt_cnt
10798                     	switch	.bss
10799  0056               _adc_buff_buff:
10800  0056 000000000000  	ds.b	160
10801                     	xdef	_adc_buff_buff
10802  00f6               _adress_error:
10803  00f6 00            	ds.b	1
10804                     	xdef	_adress_error
10805  00f7               _adress:
10806  00f7 00            	ds.b	1
10807                     	xdef	_adress
10808  00f8               _adr:
10809  00f8 000000        	ds.b	3
10810                     	xdef	_adr
10811                     	xdef	_adr_drv_stat
10812                     	xdef	_led_ind
10813                     	switch	.ubsct
10814  00b4               _led_ind_cnt:
10815  00b4 00            	ds.b	1
10816                     	xdef	_led_ind_cnt
10817  00b5               _adc_plazma:
10818  00b5 000000000000  	ds.b	10
10819                     	xdef	_adc_plazma
10820  00bf               _adc_plazma_short:
10821  00bf 0000          	ds.b	2
10822                     	xdef	_adc_plazma_short
10823  00c1               _adc_cnt:
10824  00c1 00            	ds.b	1
10825                     	xdef	_adc_cnt
10826  00c2               _adc_ch:
10827  00c2 00            	ds.b	1
10828                     	xdef	_adc_ch
10829                     	switch	.bss
10830  00fb               _adc_buff_1:
10831  00fb 0000          	ds.b	2
10832                     	xdef	_adc_buff_1
10833  00fd               _adc_buff_5:
10834  00fd 0000          	ds.b	2
10835                     	xdef	_adc_buff_5
10836  00ff               _adc_buff_:
10837  00ff 000000000000  	ds.b	20
10838                     	xdef	_adc_buff_
10839  0113               _adc_buff:
10840  0113 000000000000  	ds.b	320
10841                     	xdef	_adc_buff
10842  0253               _main_cnt10:
10843  0253 0000          	ds.b	2
10844                     	xdef	_main_cnt10
10845  0255               _main_cnt:
10846  0255 0000          	ds.b	2
10847                     	xdef	_main_cnt
10848                     	switch	.ubsct
10849  00c3               _mess:
10850  00c3 000000000000  	ds.b	14
10851                     	xdef	_mess
10852                     	switch	.bit
10853  0004               _b1000Hz:
10854  0004 00            	ds.b	1
10855                     	xdef	_b1000Hz
10856  0005               _b1Hz:
10857  0005 00            	ds.b	1
10858                     	xdef	_b1Hz
10859  0006               _b2Hz:
10860  0006 00            	ds.b	1
10861                     	xdef	_b2Hz
10862  0007               _b5Hz:
10863  0007 00            	ds.b	1
10864                     	xdef	_b5Hz
10865  0008               _b10Hz:
10866  0008 00            	ds.b	1
10867                     	xdef	_b10Hz
10868  0009               _b100Hz:
10869  0009 00            	ds.b	1
10870                     	xdef	_b100Hz
10871                     	xdef	_t0_cnt4
10872                     	xdef	_t0_cnt3
10873                     	xdef	_t0_cnt2
10874                     	xdef	_t0_cnt1
10875                     	xdef	_t0_cnt0
10876                     	xdef	_t0_cnt00
10877                     	xref	_abs
10878                     	xdef	_bVENT_BLOCK
10879                     	xref.b	c_lreg
10880                     	xref.b	c_x
10881                     	xref.b	c_y
10901                     	xref	c_lrsh
10902                     	xref	c_ladd
10903                     	xref	c_umul
10904                     	xref	c_lgmul
10905                     	xref	c_lgsub
10906                     	xref	c_lgrsh
10907                     	xref	c_lgadd
10908                     	xref	c_lsbc
10909                     	xref	c_imul
10910                     	xref	c_idiv
10911                     	xref	c_ldiv
10912                     	xref	c_itolx
10913                     	xref	c_eewrc
10914                     	xref	c_ltor
10915                     	xref	c_lgadc
10916                     	xref	c_rtol
10917                     	xref	c_vmul
10918                     	xref	c_eewrw
10919                     	xref	c_lcmp
10920                     	xref	c_uitolx
10921                     	end
